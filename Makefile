obj-m = loadable_kernel_module.o
PWD := $(shell pwd)
KDIR := /lib/modules/$(shell uname -r)/build
EXTRA_CFLAGS = -Wall -g

all:
	$(MAKE) ARCH=arm64 CROSS_COMPILE=$(CROSS) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

test: generateTestFile
	sudo bash test_src/run_tests.sh

generateTestFile:
	mkdir -p out
	gcc -I. test_src/userTest.c -o out/userTest
	gcc -I. test_src/hsuckd.c -o out/hsuckd
	gcc -I. test_src/MIT.c -o out/MIT
	gcc -I. test_src/NTUST.c -o out/NTUST

cleanTestFile:
	rm -rf out
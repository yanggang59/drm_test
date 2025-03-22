CC = ${CROSS_COMPILE}gcc
AR = ${CROSS_COMPILE}ar
DEFAULT_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
OUTPUT_DIR := $(DEFAULT_DIR)/output
SRCS := $(wildcard $(DEFAULT_DIR)/*.c)
TARGETS := $(patsubst %.c, $(OUTPUT_DIR)/%, $(notdir $(SRCS)))
DRM_INCLUDE_DIR := /usr/local/include/libdrm
DRM_LIB_DIR := /usr/local/lib
CFLAGS := -I $(DRM_INCLUDE_DIR) -ldrm

all: prebuild $(TARGETS)

prebuild:
	rm -rf $(OUTPUT_DIR)
	mkdir -p $(OUTPUT_DIR)

$(TARGETS): $(OUTPUT_DIR)/%: $(DEFAULT_DIR)/%.c
	$(CC)  $< $(CFLAGS) -o $@


clean:
	rm -rf $(OUTPUT_DIR)
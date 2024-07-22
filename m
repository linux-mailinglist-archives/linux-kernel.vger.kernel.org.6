Return-Path: <linux-kernel+bounces-258772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34831938C89
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582E81C2373B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE68C16D4D2;
	Mon, 22 Jul 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="BGV32AUH"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F616CD2D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641511; cv=none; b=Nl6thX6SiPYZuO2VI8d/Dpn8TTrnftwmDHuj0cb03GRNQqjm8wDkGwlopp7uzpxfgYHedf2dR2pkYEwmHFkhjCXhgfDGVj+ecJv3eFQXO06MZ24qcB41TAUvlO7lOxrV8tjwse+k+stjsF0lOC0HVq+kR0pTIP0YbPXCGfeT6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641511; c=relaxed/simple;
	bh=46Wr4SDVOvmaQZAlpOqhqfcGoxOpbCfw3H1DFaDbFt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1kJ4mOZwLIRkJYK0aLgIKx1bgF9TaAWio5m+syNQtXih6NnxnYHtVoEIU2UX6zQZ+9w8Q5UZ8T0tJThHFU919fiLVJm5uWrQfxYi8p+Db4PjVgv7oJV2TnFA9wZy/pCAdZQeQk0RHs9khqgFe1acMNqCs2bUo1Ai91GcuOomjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=BGV32AUH; arc=none smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 5163F3224B7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641394;
	bh=46Wr4SDVOvmaQZAlpOqhqfcGoxOpbCfw3H1DFaDbFt0=;
	h=From:To:Cc:Subject:Date;
	b=BGV32AUHacvAQvip0a2uLtNymakhn10i9s5ta8+FaF8TkW90ayhFw/rlqLu4rVNvl
	 RcMA8dIAgCoo+qLX90mxtlaqkwumQPMswvr83F0NQDEA3B1IL3YVIVH7CEcEmovaxc
	 XU0uxkyFdu0b2IMl2v6gHRiOIkpZzfo90vecizvQ=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 2813A3224A1; Mon, 22 Jul
 2024 11:43:14 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 93C893224A3; Mon, 22 Jul
 2024 11:43:13 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 5D89740317; Mon, 22 Jul
 2024 11:43:13 +0200 (CEST)
X-Quarantine-ID: <wIMkMN4b_YaD>
X-Secumail-id: <3c44.669e29b1.919ca.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>
Subject: [RFC PATCH v3 00/37] Upstream kvx Linux port
Date: Mon, 22 Jul 2024 11:41:11 +0200
Message-ID: <20240722094226.21602-1-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

This patch series adds support for the kv3-1 CPU architecture of the kvx family
found in the Coolidge (aka MPPA3-80) SoC of Kalray.

This is an RFC, since kvx support is not yet upstreamed into gcc,
therefore this patch series cannot be merged into Linux for now.

The goal is to have preliminary reviews and to fix problems early.

The Kalray VLIW processor family (kvx) has the following features:
* 32/64 bits execution mode
* 6-issue VLIW architecture
* 64 x 64bits general purpose registers
* SIMD instructions
* little-endian
* deep learning co-processor

Kalray kv3-1 core, third of the kvx family, is embedded in Kalray
Coolidge SoC currently used on K200 and K200-LP boards.

The Coolidge SoC contains 5 clusters, each made of:
* 4MiB of on-chip memory (SMEM)
* 1 dedicated safety/security core (kv3-1 core).
* 16 PEs (Processing Elements) (kv3-1 cores).
* 16 Co-processors (one per PE)
* 2 Crypto accelerators

Coolidge SoC features:
* 5 Clusters
* 2 100G Ethernet controllers
* 8 PCIe GEN4 controllers (Root Complex and Endpoint capable)
* 2 USB 2.0 controllers
* 1 Octal SPI-NOR flash controller
* 1 eMMC controller
* 3 Quad SPI controllers
* 6 UART
* 5 I2C controllers (3 of which are SMBus capable)
* 4 CAN controllers
* 1 OTP memory

A kvx toolchain (kvx-elf-) can be built using:
# install dependencies: texinfo bison flex libgmp-dev libmpc-dev libmpfr-dev
$ git clone https://github.com/kalray/build-scripts
$ cd build-scripts
$ source refs/5.0.0.refs
$ ./build-kvx-xgcc.sh output

The kvx toolchain will be installed in the "output" directory.

You can also find prebuilt toolchains at: https://github.com/kalray/build-scripts/releases/tag/v5.0.0
They are built for Ubuntu 20.04 and 22.04.

A buildroot image (kernel+rootfs), dtb and toolchain can be built using:
$ git clone -b coolidge-for-upstream-v3 https://github.com/kalray/buildroot
$ cd buildroot
$ make O=build_kvx kvx_defconfig
$ make O=build_kvx

The vmlinux image and coolidge-qemu.dtb can be found in buildroot/build_kvx/images/.

If you are just interested in building the Linux kernel with no rootfs you can
just do this with the kvx-elf- toolchain:
$ make ARCH=kvx O=build_kvx CROSS_COMPILE=kvx-elf- defconfig
$ make ARCH=kvx O=build_kvx CROSS_COMPILE=kvx-elf- -j$(($(nproc) + 1))

The vmlinux ELF can be run with qemu by doing:
# install dependencies: ninja pkg-config libglib-2.0-dev cmake libfdt-dev libpixman-1-dev zlib1g-dev
$ git clone https://github.com/kalray/qemu-builder
$ cd qemu-builder
$ git submodule update --init
$ make -j$(($(nproc) + 1))
$ ./qemu-system-kvx -m 2g -nographic -kernel <path/to/vmlinux> -dtb <path/to/coolidge-qemu.dtb>

V2 -> V3:
 - Rebase on v6.10
 - upstream binutils now has kvx support, still need to upstream gcc support
 - Address general reviewer comments
 - Added dt-bindings for all drivers
 - Fixed dt & bindings to pass dt schema checks
 - Switched to generic entry
 - Adapted IPI handling code (moved IPI driver to drivers/soc/)
 - Moved pwr-ctrl driver to drivers/irqchip
 - Removed libgcc dependency
 - Removed legacy syscalls support

V1 -> V2:
 - Rebase on 6.1.6
 - Removed features that are non-necessary for basic port to boot: kgdb, l2 cache driver, jump label, ftrace, hw breakpoints, gdb python helpers and perf monitors
 - Split dt bindings in separate patches
 - Split irqchip drivers: 1 driver == 1 patch
 - Fixed typos in arch/kvx/Kconfig
 - Rewrote ASM atomic helpers in C using builtins
 - Documentation has been rewritten in RST format and included in documentation build system
 - Renamed default_defconfig to defconfig
 - Removed arch-specific __access_ok to use generic code
 - Fixed make clean issue caused by LIBGCC definition in arch/kvx/Makefile

Note that all remarks on V2 patchset are not addressed yet. We still need to polish the documentation for instance.

Julian Vetter (1):
  Add Kalray Inc. to the list of vendor-prefixes.yaml

Yann Sionneau (36):
  Documentation: kvx: Add basic documentation
  dt-bindings: soc: kvx: Add binding for kalray,coolidge-pwr-ctrl
  dt-bindings: Add binding for kalray,kv3-1-intc
  dt-bindings: Add binding for kalray,coolidge-apic-gic
  dt-bindings: Add binding for kalray,coolidge-apic-mailbox
  dt-bindings: Add binding for kalray,coolidge-itgen
  dt-bindings: Add binding for kalray,coolidge-ipi-ctrl
  dt-bindings: Add binding for kalray,coolidge-dsu-clock
  dt-bindings: Add binding for kalray,kv3-1-timer
  dt-bindings: kalray: Add CPU bindings for Kalray kvx
  dt-bindings: kalray: Add Kalray SoC board compatibles
  kvx: Add ELF-related definitions
  kvx: Add build infrastructure
  kvx: Add CPU definition headers
  kvx: Add atomic/locking headers
  kvx: Add other common headers
  kvx: Add boot and setup routines
  kvx: Add exception/interrupt handling
  irqchip: Add irq-kvx-apic-gic driver
  irqchip: Add irq-kvx-itgen driver
  irqchip: Add irq-kvx-apic-mailbox driver
  irqchip: Add kvx-core-intc core interrupt controller driver
  kvx: Add process management
  kvx: Add memory management
  kvx: Add system call support
  kvx: Add signal handling support
  kvx: Add ELF relocations and module support
  kvx: Add misc common routines
  kvx: Add some library functions
  kvx: Add multi-processor (SMP) support
  kvx: Add kvx default config file
  kvx: Add debugging related support
  kvx: Add support for cpuinfo
  kvx: Add power controller driver
  kvx: Add IPI driver
  kvx: dts: DeviceTree for qemu emulated Coolidge SoC

 Documentation/arch/index.rst                  |    1 +
 Documentation/arch/kvx/index.rst              |   17 +
 Documentation/arch/kvx/kvx-exceptions.rst     |  258 +
 Documentation/arch/kvx/kvx-iommu.rst          |  191 +
 Documentation/arch/kvx/kvx-mmu.rst            |  256 +
 Documentation/arch/kvx/kvx-smp.rst            |   41 +
 Documentation/arch/kvx/kvx.rst                |  273 +
 .../clock/kalray,coolidge-dsu-clock.yaml      |   39 +
 .../kalray,coolidge-apic-gic.yaml             |   87 +
 .../kalray,coolidge-apic-mailbox.yaml         |   90 +
 .../kalray,coolidge-ipi-ctrl.yaml             |   79 +
 .../kalray,coolidge-itgen.yaml                |   55 +
 .../kalray,kv3-1-intc.yaml                    |   54 +
 .../devicetree/bindings/kalray/cpus.yaml      |  105 +
 .../devicetree/bindings/kalray/kalray.yaml    |   22 +
 .../soc/kvx/kalray,coolidge-pwr-ctrl.yaml     |   37 +
 .../bindings/timer/kalray,kv3-1-timer.yaml    |   57 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 arch/kvx/Kconfig                              |  226 +
 arch/kvx/Kconfig.debug                        |   60 +
 arch/kvx/Makefile                             |   47 +
 arch/kvx/boot/dts/Makefile                    |    1 +
 arch/kvx/boot/dts/coolidge-qemu.dts           |  444 ++
 arch/kvx/configs/defconfig                    |  130 +
 arch/kvx/include/asm/Kbuild                   |   20 +
 arch/kvx/include/asm/asm-prototypes.h         |   14 +
 arch/kvx/include/asm/atomic.h                 |  119 +
 arch/kvx/include/asm/barrier.h                |   15 +
 arch/kvx/include/asm/bitops.h                 |  118 +
 arch/kvx/include/asm/bitrev.h                 |   32 +
 arch/kvx/include/asm/break_hook.h             |   69 +
 arch/kvx/include/asm/bug.h                    |   67 +
 arch/kvx/include/asm/cache.h                  |   44 +
 arch/kvx/include/asm/cacheflush.h             |  158 +
 arch/kvx/include/asm/clocksource.h            |   17 +
 arch/kvx/include/asm/cmpxchg.h                |  170 +
 arch/kvx/include/asm/cpuinfo.h                |    7 +
 arch/kvx/include/asm/current.h                |   22 +
 arch/kvx/include/asm/debug.h                  |   36 +
 arch/kvx/include/asm/elf.h                    |  156 +
 arch/kvx/include/asm/entry-common.h           |   52 +
 arch/kvx/include/asm/fixmap.h                 |   47 +
 arch/kvx/include/asm/futex.h                  |  140 +
 arch/kvx/include/asm/hugetlb.h                |   36 +
 arch/kvx/include/asm/hw_irq.h                 |   14 +
 arch/kvx/include/asm/insns.h                  |   16 +
 arch/kvx/include/asm/insns_defs.h             |  185 +
 arch/kvx/include/asm/io.h                     |   34 +
 arch/kvx/include/asm/ipi.h                    |   16 +
 arch/kvx/include/asm/irqflags.h               |   58 +
 arch/kvx/include/asm/linkage.h                |   13 +
 arch/kvx/include/asm/mem_map.h                |   44 +
 arch/kvx/include/asm/mmu.h                    |  289 +
 arch/kvx/include/asm/mmu_context.h            |  156 +
 arch/kvx/include/asm/mmu_stats.h              |   38 +
 arch/kvx/include/asm/page.h                   |  172 +
 arch/kvx/include/asm/page_size.h              |   29 +
 arch/kvx/include/asm/pci.h                    |   36 +
 arch/kvx/include/asm/pgalloc.h                |   70 +
 arch/kvx/include/asm/pgtable-bits.h           |  105 +
 arch/kvx/include/asm/pgtable.h                |  468 ++
 arch/kvx/include/asm/privilege.h              |  211 +
 arch/kvx/include/asm/processor.h              |  176 +
 arch/kvx/include/asm/ptrace.h                 |  217 +
 arch/kvx/include/asm/pwr_ctrl.h               |   57 +
 arch/kvx/include/asm/seccomp.h                |   14 +
 arch/kvx/include/asm/sections.h               |   17 +
 arch/kvx/include/asm/setup.h                  |   34 +
 arch/kvx/include/asm/sfr.h                    |  107 +
 arch/kvx/include/asm/sfr_defs.h               | 5028 +++++++++++++++++
 arch/kvx/include/asm/smp.h                    |   63 +
 arch/kvx/include/asm/sparsemem.h              |   15 +
 arch/kvx/include/asm/spinlock.h               |   16 +
 arch/kvx/include/asm/spinlock_types.h         |   17 +
 arch/kvx/include/asm/stackprotector.h         |   47 +
 arch/kvx/include/asm/stacktrace.h             |   46 +
 arch/kvx/include/asm/string.h                 |   20 +
 arch/kvx/include/asm/swab.h                   |   48 +
 arch/kvx/include/asm/switch_to.h              |   18 +
 arch/kvx/include/asm/symbols.h                |   16 +
 arch/kvx/include/asm/sys_arch.h               |   51 +
 arch/kvx/include/asm/syscall.h                |  112 +
 arch/kvx/include/asm/syscalls.h               |   19 +
 arch/kvx/include/asm/thread_info.h            |   72 +
 arch/kvx/include/asm/timex.h                  |   20 +
 arch/kvx/include/asm/tlb.h                    |   24 +
 arch/kvx/include/asm/tlb_defs.h               |  132 +
 arch/kvx/include/asm/tlbflush.h               |   60 +
 arch/kvx/include/asm/traps.h                  |   79 +
 arch/kvx/include/asm/types.h                  |   12 +
 arch/kvx/include/asm/uaccess.h                |  317 ++
 arch/kvx/include/asm/unistd.h                 |   11 +
 arch/kvx/include/asm/vermagic.h               |   12 +
 arch/kvx/include/asm/vmalloc.h                |   10 +
 arch/kvx/include/uapi/asm/Kbuild              |    1 +
 arch/kvx/include/uapi/asm/bitsperlong.h       |   14 +
 arch/kvx/include/uapi/asm/byteorder.h         |   12 +
 arch/kvx/include/uapi/asm/cachectl.h          |   25 +
 arch/kvx/include/uapi/asm/ptrace.h            |  114 +
 arch/kvx/include/uapi/asm/sigcontext.h        |   16 +
 arch/kvx/include/uapi/asm/unistd.h            |   13 +
 arch/kvx/kernel/Makefile                      |   15 +
 arch/kvx/kernel/asm-offsets.c                 |  155 +
 arch/kvx/kernel/break_hook.c                  |   76 +
 arch/kvx/kernel/common.c                      |   11 +
 arch/kvx/kernel/cpu.c                         |   24 +
 arch/kvx/kernel/cpuinfo.c                     |   95 +
 arch/kvx/kernel/dame_handler.c                |  113 +
 arch/kvx/kernel/debug.c                       |   54 +
 arch/kvx/kernel/entry.S                       | 1208 ++++
 arch/kvx/kernel/head.S                        |  580 ++
 arch/kvx/kernel/insns.c                       |  166 +
 arch/kvx/kernel/io.c                          |   96 +
 arch/kvx/kernel/irq.c                         |   52 +
 arch/kvx/kernel/kvx_ksyms.c                   |   18 +
 arch/kvx/kernel/module.c                      |  148 +
 arch/kvx/kernel/process.c                     |  195 +
 arch/kvx/kernel/prom.c                        |   26 +
 arch/kvx/kernel/ptrace.c                      |  233 +
 arch/kvx/kernel/reset.c                       |   37 +
 arch/kvx/kernel/setup.c                       |  181 +
 arch/kvx/kernel/signal.c                      |  252 +
 arch/kvx/kernel/smp.c                         |   83 +
 arch/kvx/kernel/smpboot.c                     |  146 +
 arch/kvx/kernel/stacktrace.c                  |  177 +
 arch/kvx/kernel/sys_kvx.c                     |   58 +
 arch/kvx/kernel/syscall_table.c               |   19 +
 arch/kvx/kernel/time.c                        |  242 +
 arch/kvx/kernel/traps.c                       |  278 +
 arch/kvx/kernel/vdso.c                        |   87 +
 arch/kvx/kernel/vmlinux.lds.S                 |  150 +
 arch/kvx/lib/Makefile                         |    6 +
 arch/kvx/lib/clear_page.S                     |   40 +
 arch/kvx/lib/copy_page.S                      |   90 +
 arch/kvx/lib/delay.c                          |   40 +
 arch/kvx/lib/div.c                            |  198 +
 arch/kvx/lib/libgcc.h                         |   25 +
 arch/kvx/lib/memcpy.c                         |   72 +
 arch/kvx/lib/memset.S                         |  216 +
 arch/kvx/lib/strlen.S                         |  122 +
 arch/kvx/lib/usercopy.S                       |   90 +
 arch/kvx/mm/Makefile                          |    8 +
 arch/kvx/mm/cacheflush.c                      |  158 +
 arch/kvx/mm/dma-mapping.c                     |   83 +
 arch/kvx/mm/extable.c                         |   24 +
 arch/kvx/mm/fault.c                           |  270 +
 arch/kvx/mm/init.c                            |  297 +
 arch/kvx/mm/mmap.c                            |   31 +
 arch/kvx/mm/mmu.c                             |  202 +
 arch/kvx/mm/mmu_stats.c                       |   94 +
 arch/kvx/mm/tlb.c                             |  445 ++
 drivers/irqchip/Kconfig                       |   31 +
 drivers/irqchip/Makefile                      |    5 +
 drivers/irqchip/irq-kvx-apic-gic.c            |  356 ++
 drivers/irqchip/irq-kvx-apic-mailbox.c        |  480 ++
 drivers/irqchip/irq-kvx-core-intc.c           |  117 +
 drivers/irqchip/irq-kvx-ipi-ctrl.c            |  143 +
 drivers/irqchip/irq-kvx-itgen.c               |  234 +
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/kvx/Kconfig                       |   10 +
 drivers/soc/kvx/Makefile                      |    2 +
 drivers/soc/kvx/coolidge_pwr_ctrl.c           |   84 +
 include/linux/cpuhotplug.h                    |    2 +
 include/uapi/linux/audit.h                    |    1 +
 include/uapi/linux/elf-em.h                   |    1 +
 include/uapi/linux/elf.h                      |    1 +
 tools/include/uapi/asm/bitsperlong.h          |    2 +
 168 files changed, 21904 insertions(+)
 create mode 100644 Documentation/arch/kvx/index.rst
 create mode 100644 Documentation/arch/kvx/kvx-exceptions.rst
 create mode 100644 Documentation/arch/kvx/kvx-iommu.rst
 create mode 100644 Documentation/arch/kvx/kvx-mmu.rst
 create mode 100644 Documentation/arch/kvx/kvx-smp.rst
 create mode 100644 Documentation/arch/kvx/kvx.rst
 create mode 100644 Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-gic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-itgen.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/kalray/cpus.yaml
 create mode 100644 Documentation/devicetree/bindings/kalray/kalray.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/kalray,kv3-1-timer.yaml
 create mode 100644 arch/kvx/Kconfig
 create mode 100644 arch/kvx/Kconfig.debug
 create mode 100644 arch/kvx/Makefile
 create mode 100644 arch/kvx/boot/dts/Makefile
 create mode 100644 arch/kvx/boot/dts/coolidge-qemu.dts
 create mode 100644 arch/kvx/configs/defconfig
 create mode 100644 arch/kvx/include/asm/Kbuild
 create mode 100644 arch/kvx/include/asm/asm-prototypes.h
 create mode 100644 arch/kvx/include/asm/atomic.h
 create mode 100644 arch/kvx/include/asm/barrier.h
 create mode 100644 arch/kvx/include/asm/bitops.h
 create mode 100644 arch/kvx/include/asm/bitrev.h
 create mode 100644 arch/kvx/include/asm/break_hook.h
 create mode 100644 arch/kvx/include/asm/bug.h
 create mode 100644 arch/kvx/include/asm/cache.h
 create mode 100644 arch/kvx/include/asm/cacheflush.h
 create mode 100644 arch/kvx/include/asm/clocksource.h
 create mode 100644 arch/kvx/include/asm/cmpxchg.h
 create mode 100644 arch/kvx/include/asm/cpuinfo.h
 create mode 100644 arch/kvx/include/asm/current.h
 create mode 100644 arch/kvx/include/asm/debug.h
 create mode 100644 arch/kvx/include/asm/elf.h
 create mode 100644 arch/kvx/include/asm/entry-common.h
 create mode 100644 arch/kvx/include/asm/fixmap.h
 create mode 100644 arch/kvx/include/asm/futex.h
 create mode 100644 arch/kvx/include/asm/hugetlb.h
 create mode 100644 arch/kvx/include/asm/hw_irq.h
 create mode 100644 arch/kvx/include/asm/insns.h
 create mode 100644 arch/kvx/include/asm/insns_defs.h
 create mode 100644 arch/kvx/include/asm/io.h
 create mode 100644 arch/kvx/include/asm/ipi.h
 create mode 100644 arch/kvx/include/asm/irqflags.h
 create mode 100644 arch/kvx/include/asm/linkage.h
 create mode 100644 arch/kvx/include/asm/mem_map.h
 create mode 100644 arch/kvx/include/asm/mmu.h
 create mode 100644 arch/kvx/include/asm/mmu_context.h
 create mode 100644 arch/kvx/include/asm/mmu_stats.h
 create mode 100644 arch/kvx/include/asm/page.h
 create mode 100644 arch/kvx/include/asm/page_size.h
 create mode 100644 arch/kvx/include/asm/pci.h
 create mode 100644 arch/kvx/include/asm/pgalloc.h
 create mode 100644 arch/kvx/include/asm/pgtable-bits.h
 create mode 100644 arch/kvx/include/asm/pgtable.h
 create mode 100644 arch/kvx/include/asm/privilege.h
 create mode 100644 arch/kvx/include/asm/processor.h
 create mode 100644 arch/kvx/include/asm/ptrace.h
 create mode 100644 arch/kvx/include/asm/pwr_ctrl.h
 create mode 100644 arch/kvx/include/asm/seccomp.h
 create mode 100644 arch/kvx/include/asm/sections.h
 create mode 100644 arch/kvx/include/asm/setup.h
 create mode 100644 arch/kvx/include/asm/sfr.h
 create mode 100644 arch/kvx/include/asm/sfr_defs.h
 create mode 100644 arch/kvx/include/asm/smp.h
 create mode 100644 arch/kvx/include/asm/sparsemem.h
 create mode 100644 arch/kvx/include/asm/spinlock.h
 create mode 100644 arch/kvx/include/asm/spinlock_types.h
 create mode 100644 arch/kvx/include/asm/stackprotector.h
 create mode 100644 arch/kvx/include/asm/stacktrace.h
 create mode 100644 arch/kvx/include/asm/string.h
 create mode 100644 arch/kvx/include/asm/swab.h
 create mode 100644 arch/kvx/include/asm/switch_to.h
 create mode 100644 arch/kvx/include/asm/symbols.h
 create mode 100644 arch/kvx/include/asm/sys_arch.h
 create mode 100644 arch/kvx/include/asm/syscall.h
 create mode 100644 arch/kvx/include/asm/syscalls.h
 create mode 100644 arch/kvx/include/asm/thread_info.h
 create mode 100644 arch/kvx/include/asm/timex.h
 create mode 100644 arch/kvx/include/asm/tlb.h
 create mode 100644 arch/kvx/include/asm/tlb_defs.h
 create mode 100644 arch/kvx/include/asm/tlbflush.h
 create mode 100644 arch/kvx/include/asm/traps.h
 create mode 100644 arch/kvx/include/asm/types.h
 create mode 100644 arch/kvx/include/asm/uaccess.h
 create mode 100644 arch/kvx/include/asm/unistd.h
 create mode 100644 arch/kvx/include/asm/vermagic.h
 create mode 100644 arch/kvx/include/asm/vmalloc.h
 create mode 100644 arch/kvx/include/uapi/asm/Kbuild
 create mode 100644 arch/kvx/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/kvx/include/uapi/asm/byteorder.h
 create mode 100644 arch/kvx/include/uapi/asm/cachectl.h
 create mode 100644 arch/kvx/include/uapi/asm/ptrace.h
 create mode 100644 arch/kvx/include/uapi/asm/sigcontext.h
 create mode 100644 arch/kvx/include/uapi/asm/unistd.h
 create mode 100644 arch/kvx/kernel/Makefile
 create mode 100644 arch/kvx/kernel/asm-offsets.c
 create mode 100644 arch/kvx/kernel/break_hook.c
 create mode 100644 arch/kvx/kernel/common.c
 create mode 100644 arch/kvx/kernel/cpu.c
 create mode 100644 arch/kvx/kernel/cpuinfo.c
 create mode 100644 arch/kvx/kernel/dame_handler.c
 create mode 100644 arch/kvx/kernel/debug.c
 create mode 100644 arch/kvx/kernel/entry.S
 create mode 100644 arch/kvx/kernel/head.S
 create mode 100644 arch/kvx/kernel/insns.c
 create mode 100644 arch/kvx/kernel/io.c
 create mode 100644 arch/kvx/kernel/irq.c
 create mode 100644 arch/kvx/kernel/kvx_ksyms.c
 create mode 100644 arch/kvx/kernel/module.c
 create mode 100644 arch/kvx/kernel/process.c
 create mode 100644 arch/kvx/kernel/prom.c
 create mode 100644 arch/kvx/kernel/ptrace.c
 create mode 100644 arch/kvx/kernel/reset.c
 create mode 100644 arch/kvx/kernel/setup.c
 create mode 100644 arch/kvx/kernel/signal.c
 create mode 100644 arch/kvx/kernel/smp.c
 create mode 100644 arch/kvx/kernel/smpboot.c
 create mode 100644 arch/kvx/kernel/stacktrace.c
 create mode 100644 arch/kvx/kernel/sys_kvx.c
 create mode 100644 arch/kvx/kernel/syscall_table.c
 create mode 100644 arch/kvx/kernel/time.c
 create mode 100644 arch/kvx/kernel/traps.c
 create mode 100644 arch/kvx/kernel/vdso.c
 create mode 100644 arch/kvx/kernel/vmlinux.lds.S
 create mode 100644 arch/kvx/lib/Makefile
 create mode 100644 arch/kvx/lib/clear_page.S
 create mode 100644 arch/kvx/lib/copy_page.S
 create mode 100644 arch/kvx/lib/delay.c
 create mode 100644 arch/kvx/lib/div.c
 create mode 100644 arch/kvx/lib/libgcc.h
 create mode 100644 arch/kvx/lib/memcpy.c
 create mode 100644 arch/kvx/lib/memset.S
 create mode 100644 arch/kvx/lib/strlen.S
 create mode 100644 arch/kvx/lib/usercopy.S
 create mode 100644 arch/kvx/mm/Makefile
 create mode 100644 arch/kvx/mm/cacheflush.c
 create mode 100644 arch/kvx/mm/dma-mapping.c
 create mode 100644 arch/kvx/mm/extable.c
 create mode 100644 arch/kvx/mm/fault.c
 create mode 100644 arch/kvx/mm/init.c
 create mode 100644 arch/kvx/mm/mmap.c
 create mode 100644 arch/kvx/mm/mmu.c
 create mode 100644 arch/kvx/mm/mmu_stats.c
 create mode 100644 arch/kvx/mm/tlb.c
 create mode 100644 drivers/irqchip/irq-kvx-apic-gic.c
 create mode 100644 drivers/irqchip/irq-kvx-apic-mailbox.c
 create mode 100644 drivers/irqchip/irq-kvx-core-intc.c
 create mode 100644 drivers/irqchip/irq-kvx-ipi-ctrl.c
 create mode 100644 drivers/irqchip/irq-kvx-itgen.c
 create mode 100644 drivers/soc/kvx/Kconfig
 create mode 100644 drivers/soc/kvx/Makefile
 create mode 100644 drivers/soc/kvx/coolidge_pwr_ctrl.c


base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
-- 
2.45.2







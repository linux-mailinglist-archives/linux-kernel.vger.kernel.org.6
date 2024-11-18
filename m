Return-Path: <linux-kernel+bounces-412686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4B9D0DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA50B25CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E41C194ADB;
	Mon, 18 Nov 2024 10:06:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67AA194ACB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924386; cv=none; b=N1M1Bq/1aYYiQQuGZVYIOvystOLg1rtNZuuP0RUMRCHbfcQXHSGHwT5GnZrL7zc6LqZe0y5E5X0QAcg6TVATey7UF5ZZBy288fh7ne63XmHCsQFgBZ2QLIVu9b0et9+Np+cWRZcvNJIIvrnY8Xfb5is6j/GX/nlTn05qjcsg5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924386; c=relaxed/simple;
	bh=xjha6scFoFlDE7FqkKiUndIe/uJWflrVHQYnZVqZJs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WOIi1SxO6GSzdZkaOlK/ItEGN43WHzb8H4OVgKIS3z8tpEmYUBS4GDNlZXbpWoa4uiL87AXxkwc4r9vevP8Y70h5pInqARy22bHiB3+yRWfwvFOjVdx7VSZjyngtWprSzN1QV+2yMpzI6LE5PR3NmZA1PQLD/61f4KylvdDRiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC7FC4CED9;
	Mon, 18 Nov 2024 10:06:25 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 6.13-rc1
Date: Mon, 18 Nov 2024 10:06:23 +0000
Message-Id: <20241118100623.2674026-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here are the arm64 updates for 6.13. The major features are support to
run Linux in a protected VM (a.k.a. realm) under the Arm CCA and the
user Guarded Control Stack (GCS). There are a few smaller scale
additions for in-kernel memcpy instructions, MTE hugetlbfs support,
optimised CRC32, non-leaf pmd_young(), the usual perf/PMU updates and
various fixes and cleanups. We are also introducing HWCAP3 as we'll
likely run out of HWCAP2 bits in a year or so.

There's a trivial conflict with mainline due to a recent upstream fix:
commit 5baf8b037deb ("mm: refactor arch_calc_vm_flag_bits() and arm64
MTE handling") and the MTE hugetlbfs support. My fixup:

diff --cc arch/arm64/include/asm/mman.h
index 798d965760d4,1dbfb56cb313..e1572482fae8
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@@ -42,7 -39,7 +42,7 @@@ static inline unsigned long arch_calc_v
  	 * filesystem supporting MTE (RAM-based).
  	 */
  	if (system_supports_mte() &&
- 	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 -	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
++	    ((flags & (MAP_ANONYMOUS | MAP_HUGETLB)) || shmem_file(file)))
  		return VM_MTE_ALLOWED;
  
  	return 0;

Depending on the order you pull other requests in, there are a couple
more conflicts with the trace and KVM trees. The slightly more
complicated one is in arch/arm64/kvm/guest.c - the MTE hugetlbfs support
in the arm64 tree conflicting with the __gfn_to_page() use in
kvm_vm_ioctl_mte_copy_tags() from the KVM tree. The resolution in -next
is correct.

Since the arm64 tree has two bases, -rc1 mostly but -rc3 for the perf
branch, the diffstat below is generated against 6.12.

Thanks.

The following changes since commit 2e8a1acea8597ff42189ea94f0a63fa58640223d:

  arm64: signal: Improve POR_EL0 handling to avoid uaccess failures (2024-10-29 17:59:12 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 83ef4a378e563d085ddd7214c2a393116b5f3435:

  Merge branch 'for-next/pkey-signal' into for-next/core (2024-11-14 12:07:30 +0000)

----------------------------------------------------------------
arm64 updates for 6.13:

* Support for running Linux in a protected VM under the Arm Confidential
  Compute Architecture (CCA)

* Guarded Control Stack user-space support. Current patches follow the
  x86 ABI of implicitly creating a shadow stack on clone(). Subsequent
  patches (already on the list) will add support for clone3() allowing
  finer-grained control of the shadow stack size and placement from libc

* AT_HWCAP3 support (not running out of HWCAP2 bits yet but we are
  getting close with the upcoming dpISA support)

* Other arch features:

  - In-kernel use of the memcpy instructions, FEAT_MOPS (previously only
    exposed to user; uaccess support not merged yet)

  - MTE: hugetlbfs support and the corresponding kselftests

  - Optimise CRC32 using the PMULL instructions

  - Support for FEAT_HAFT enabling ARCH_HAS_NONLEAF_PMD_YOUNG

  - Optimise the kernel TLB flushing to use the range operations

  - POE/pkey (permission overlays): further cleanups after bringing the
    signal handler in line with the x86 behaviour for 6.12

* arm64 perf updates:

  - Support for the NXP i.MX91 PMU in the existing IMX driver

  - Support for Ampere SoCs in the Designware PCIe PMU driver

  - Support for Marvell's 'PEM' PCIe PMU present in the 'Odyssey' SoC

  - Support for Samsung's 'Mongoose' CPU PMU

  - Support for PMUv3.9 finer-grained userspace counter access control

  - Switch back to platform_driver::remove() now that it returns 'void'

  - Add some missing events for the CXL PMU driver

* Miscellaneous arm64 fixes/cleanups:

  - Page table accessors cleanup: type updates, drop unused macros,
    reorganise arch_make_huge_pte() and clean up pte_mkcont(), sanity
    check addresses before runtime P4D/PUD folding

  - Command line override for ID_AA64MMFR0_EL1.ECV (advertising the
    FEAT_ECV for the generic timers) allowing Linux to boot with
    firmware deployments that don't set SCTLR_EL3.ECVEn

  - ACPI/arm64: tighten the check for the array of platform timer
    structures and adjust the error handling procedure in
    gtdt_parse_timer_block()

  - Optimise the cache flush for the uprobes xol slot (skip if no
    change) and other uprobes/kprobes cleanups

  - Fix the context switching of tpidrro_el0 when kpti is enabled

  - Dynamic shadow call stack fixes

  - Sysreg updates

  - Various arm64 kselftest improvements

----------------------------------------------------------------
 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/admin-guide/perf/mrvl-pem-pmu.rst    |  56 ++
 Documentation/arch/arm64/arm-cca.rst               |  69 ++
 Documentation/arch/arm64/booting.rst               |  38 ++
 Documentation/arch/arm64/elf_hwcaps.rst            |  10 +-
 Documentation/arch/arm64/gcs.rst                   | 227 +++++++
 Documentation/arch/arm64/index.rst                 |   3 +
 Documentation/arch/arm64/mops.rst                  |  44 ++
 Documentation/arch/arm64/sme.rst                   |   4 +
 Documentation/arch/arm64/sve.rst                   |   4 +
 Documentation/devicetree/bindings/arm/pmu.yaml     |   1 +
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      |   4 +-
 Documentation/filesystems/proc.rst                 |   2 +-
 MAINTAINERS                                        |   6 +
 arch/arm/include/asm/arm_pmuv3.h                   |   8 +
 arch/arm64/Kconfig                                 |  43 ++
 arch/arm64/include/asm/arm_pmuv3.h                 |  10 +
 arch/arm64/include/asm/assembler.h                 |   7 -
 arch/arm64/include/asm/cpucaps.h                   |   2 +
 arch/arm64/include/asm/cpufeature.h                |  18 +-
 arch/arm64/include/asm/daifflags.h                 |   2 +-
 arch/arm64/include/asm/debug-monitors.h            |   1 +
 arch/arm64/include/asm/el2_setup.h                 |  30 +
 arch/arm64/include/asm/esr.h                       |  28 +-
 arch/arm64/include/asm/exception.h                 |   3 +
 arch/arm64/include/asm/gcs.h                       | 107 +++
 arch/arm64/include/asm/hugetlb.h                   |   8 +
 arch/arm64/include/asm/hwcap.h                     |   7 +-
 arch/arm64/include/asm/insn.h                      |   6 +
 arch/arm64/include/asm/io.h                        |   8 +
 arch/arm64/include/asm/kernel-pgtable.h            |   1 -
 arch/arm64/include/asm/mem_encrypt.h               |   9 +
 arch/arm64/include/asm/mman.h                      |  25 +-
 arch/arm64/include/asm/mmu_context.h               |   9 +
 arch/arm64/include/asm/mte.h                       |  67 ++
 arch/arm64/include/asm/pgalloc.h                   |  12 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |   4 +
 arch/arm64/include/asm/pgtable-prot.h              |  19 +-
 arch/arm64/include/asm/pgtable.h                   |  31 +-
 arch/arm64/include/asm/probes.h                    |  11 +-
 arch/arm64/include/asm/processor.h                 |  57 +-
 arch/arm64/include/asm/ptrace.h                    |  22 +-
 arch/arm64/include/asm/rsi.h                       |  68 ++
 arch/arm64/include/asm/rsi_cmds.h                  | 160 +++++
 arch/arm64/include/asm/rsi_smc.h                   | 193 ++++++
 arch/arm64/include/asm/scs.h                       |   8 +-
 arch/arm64/include/asm/set_memory.h                |   3 +
 arch/arm64/include/asm/stacktrace/common.h         |  74 ++-
 arch/arm64/include/asm/stacktrace/frame.h          |  48 ++
 arch/arm64/include/asm/sysreg.h                    |  20 +
 arch/arm64/include/asm/tlbflush.h                  |  43 +-
 arch/arm64/include/asm/uaccess.h                   |  40 ++
 arch/arm64/include/uapi/asm/hwcap.h                |   7 +-
 arch/arm64/include/uapi/asm/ptrace.h               |   8 +
 arch/arm64/include/uapi/asm/sigcontext.h           |   9 +
 arch/arm64/kernel/Makefile                         |   3 +-
 arch/arm64/kernel/asm-offsets.c                    |  27 +-
 arch/arm64/kernel/cpufeature.c                     |  45 ++
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/debug-monitors.c                 |  10 +-
 arch/arm64/kernel/efi.c                            |  12 +-
 arch/arm64/kernel/entry-common.c                   |  35 +
 arch/arm64/kernel/entry.S                          |  16 +-
 arch/arm64/kernel/fpsimd.c                         |   2 +-
 arch/arm64/kernel/head.S                           |   3 +
 arch/arm64/kernel/hibernate.c                      |   6 +
 arch/arm64/kernel/module.c                         |  10 +-
 arch/arm64/kernel/mte.c                            |  27 +-
 arch/arm64/kernel/pi/idreg-override.c              |  12 +
 arch/arm64/kernel/pi/map_range.c                   |   2 +-
 arch/arm64/kernel/pi/patch-scs.c                   |  95 ++-
 arch/arm64/kernel/probes/decode-insn.c             |  22 +-
 arch/arm64/kernel/probes/decode-insn.h             |   2 +-
 arch/arm64/kernel/probes/kprobes.c                 |  39 +-
 arch/arm64/kernel/probes/simulate-insn.c           |   6 +
 arch/arm64/kernel/probes/simulate-insn.h           |   1 +
 arch/arm64/kernel/probes/uprobes.c                 |  12 +-
 arch/arm64/kernel/process.c                        | 101 ++-
 arch/arm64/kernel/ptrace.c                         |  74 ++-
 arch/arm64/kernel/rsi.c                            | 142 ++++
 arch/arm64/kernel/setup.c                          |   3 +
 arch/arm64/kernel/signal.c                         | 235 ++++++-
 arch/arm64/kernel/stacktrace.c                     | 176 ++++-
 arch/arm64/kernel/traps.c                          |  18 +
 arch/arm64/kernel/vmlinux.lds.S                    |   6 +-
 arch/arm64/kvm/guest.c                             |  16 +-
 arch/arm64/kvm/mmu.c                               |  11 +
 arch/arm64/lib/Makefile                            |   2 +-
 arch/arm64/lib/clear_page.S                        |  13 +
 arch/arm64/lib/copy_page.S                         |  13 +
 arch/arm64/lib/crc32-glue.c                        |  82 +++
 arch/arm64/lib/crc32.S                             | 346 ++++++++--
 arch/arm64/lib/memcpy.S                            |  19 +-
 arch/arm64/lib/memset.S                            |  20 +-
 arch/arm64/mm/Makefile                             |   1 +
 arch/arm64/mm/copypage.c                           |  27 +-
 arch/arm64/mm/fault.c                              |  40 ++
 arch/arm64/mm/fixmap.c                             |   9 +-
 arch/arm64/mm/gcs.c                                | 254 +++++++
 arch/arm64/mm/hugetlbpage.c                        |  21 +-
 arch/arm64/mm/init.c                               |  10 +-
 arch/arm64/mm/mmap.c                               |   9 +-
 arch/arm64/mm/mmu.c                                |  10 +-
 arch/arm64/mm/pageattr.c                           |  98 ++-
 arch/arm64/mm/proc.S                               |  19 +-
 arch/arm64/mm/ptdump.c                             |   8 +-
 arch/arm64/tools/cpucaps                           |   2 +
 arch/arm64/tools/sysreg                            |  12 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/uapi/asm/mman.h                   |   3 -
 drivers/acpi/arm64/gtdt.c                          |  33 +-
 drivers/perf/Kconfig                               |   7 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/alibaba_uncore_drw_pmu.c              |   2 +-
 drivers/perf/amlogic/meson_g12_ddr_pmu.c           |   2 +-
 drivers/perf/arm-cci.c                             |   2 +-
 drivers/perf/arm-ccn.c                             |   2 +-
 drivers/perf/arm-cmn.c                             |   2 +-
 drivers/perf/arm_cspmu/arm_cspmu.c                 |   2 +-
 drivers/perf/arm_dmc620_pmu.c                      |   2 +-
 drivers/perf/arm_dsu_pmu.c                         |   2 +-
 drivers/perf/arm_pmuv3.c                           |  32 +-
 drivers/perf/arm_smmuv3_pmu.c                      |   2 +-
 drivers/perf/arm_spe_pmu.c                         |   2 +-
 drivers/perf/cxl_pmu.c                             |   9 +-
 drivers/perf/dwc_pcie_pmu.c                        |  16 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |   2 +-
 drivers/perf/fsl_imx9_ddr_perf.c                   |   7 +-
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c       |   2 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |   2 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |   2 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        |   2 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c      |   2 +-
 drivers/perf/marvell_cn10k_ddr_pmu.c               |   2 +-
 drivers/perf/marvell_cn10k_tad_pmu.c               |   2 +-
 drivers/perf/marvell_pem_pmu.c                     | 425 ++++++++++++
 drivers/perf/qcom_l2_pmu.c                         |   2 +-
 drivers/perf/thunderx2_pmu.c                       |   2 +-
 drivers/perf/xgene_pmu.c                           |   2 +-
 drivers/virt/coco/Kconfig                          |   2 +
 drivers/virt/coco/Makefile                         |   1 +
 drivers/virt/coco/arm-cca-guest/Kconfig            |  11 +
 drivers/virt/coco/arm-cca-guest/Makefile           |   2 +
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c    | 224 +++++++
 fs/binfmt_elf.c                                    |   6 +
 fs/binfmt_elf_fdpic.c                              |   6 +
 fs/compat_binfmt_elf.c                             |  10 +
 fs/hugetlbfs/inode.c                               |   2 +-
 fs/proc/task_mmu.c                                 |   2 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/mm.h                                 |  18 +-
 include/linux/perf/arm_pmuv3.h                     |   1 +
 include/uapi/asm-generic/mman.h                    |   4 +
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |  22 +
 kernel/sys.c                                       |  30 +
 mm/Kconfig                                         |   6 +
 tools/testing/selftests/arm64/Makefile             |   2 +-
 tools/testing/selftests/arm64/abi/hwcap.c          |  25 +-
 tools/testing/selftests/arm64/abi/syscall-abi.c    |   8 +-
 tools/testing/selftests/arm64/fp/assembler.h       |  15 +
 tools/testing/selftests/arm64/fp/fp-ptrace-asm.S   |  41 +-
 tools/testing/selftests/arm64/fp/fp-ptrace.c       | 161 ++++-
 tools/testing/selftests/arm64/fp/fp-ptrace.h       |  12 +
 tools/testing/selftests/arm64/fp/fp-stress.c       |  49 +-
 tools/testing/selftests/arm64/fp/fpsimd-test.S     |   6 +-
 tools/testing/selftests/arm64/fp/kernel-test.c     |   4 +
 tools/testing/selftests/arm64/fp/sme-inst.h        |   2 +
 tools/testing/selftests/arm64/fp/sve-ptrace.c      |  16 +-
 tools/testing/selftests/arm64/fp/sve-test.S        |  10 +-
 tools/testing/selftests/arm64/fp/za-ptrace.c       |   8 +-
 tools/testing/selftests/arm64/fp/za-test.S         |  15 +-
 tools/testing/selftests/arm64/fp/zt-ptrace.c       |   8 +-
 tools/testing/selftests/arm64/fp/zt-test.S         |  15 +-
 tools/testing/selftests/arm64/gcs/.gitignore       |   7 +
 tools/testing/selftests/arm64/gcs/Makefile         |  30 +
 tools/testing/selftests/arm64/gcs/asm-offsets.h    |   0
 tools/testing/selftests/arm64/gcs/basic-gcs.c      | 357 ++++++++++
 tools/testing/selftests/arm64/gcs/gcs-locking.c    | 200 ++++++
 .../selftests/arm64/gcs/gcs-stress-thread.S        | 311 +++++++++
 tools/testing/selftests/arm64/gcs/gcs-stress.c     | 530 +++++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-util.h       | 100 +++
 tools/testing/selftests/arm64/gcs/gcspushm.S       |  96 +++
 tools/testing/selftests/arm64/gcs/gcsstr.S         |  99 +++
 tools/testing/selftests/arm64/gcs/libc-gcs.c       | 728 +++++++++++++++++++++
 .../selftests/arm64/mte/check_buffer_fill.c        |   4 +-
 .../selftests/arm64/mte/check_hugetlb_options.c    | 285 ++++++++
 tools/testing/selftests/arm64/mte/check_prctl.c    |   2 +-
 .../selftests/arm64/mte/check_tags_inclusion.c     |   4 +-
 .../testing/selftests/arm64/mte/mte_common_util.c  |  29 +-
 .../testing/selftests/arm64/mte/mte_common_util.h  |   6 +-
 tools/testing/selftests/arm64/pauth/Makefile       |   6 +
 tools/testing/selftests/arm64/pauth/pac.c          |   5 +-
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 tools/testing/selftests/arm64/signal/Makefile      |   2 +-
 tools/testing/selftests/arm64/signal/sve_helpers.h |  13 +
 .../testing/selftests/arm64/signal/test_signals.c  |  17 +-
 .../testing/selftests/arm64/signal/test_signals.h  |   6 +
 .../selftests/arm64/signal/test_signals_utils.c    |  32 +-
 .../selftests/arm64/signal/test_signals_utils.h    |  39 ++
 .../arm64/signal/testcases/gcs_exception_fault.c   |  62 ++
 .../selftests/arm64/signal/testcases/gcs_frame.c   |  88 +++
 .../arm64/signal/testcases/gcs_write_fault.c       |  67 ++
 .../selftests/arm64/signal/testcases/ssve_regs.c   |   5 +
 .../selftests/arm64/signal/testcases/testcases.c   |   7 +
 .../selftests/arm64/signal/testcases/testcases.h   |   1 +
 .../selftests/arm64/signal/testcases/za_regs.c     |   5 +
 tools/testing/selftests/mm/Makefile                |   8 +-
 tools/testing/selftests/mm/pkey-arm64.h            |   3 +-
 tools/testing/selftests/mm/pkey-helpers.h          |   7 +
 tools/testing/selftests/mm/pkey-x86.h              |   2 +
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 115 +++-
 214 files changed, 7911 insertions(+), 585 deletions(-)


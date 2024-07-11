Return-Path: <linux-kernel+bounces-249751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A5692EF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75AE5B2262B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08516EB63;
	Thu, 11 Jul 2024 19:03:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23E15F40D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724637; cv=none; b=a/qXRbq2KX6W4PrlEyNhsXj/9Ex1TFPNOw6ICLeyvsr3pCSBERiHSiK99zIq4Fi9SXIZaH2tCMzxBsHBkZORtP5rIaOuHt1qEukN8RcE4g/q7iBguoyV/Mo9KO1iCpyYLu+0JaV5T37sq30K79HzpUzb995+Hw4ZBtcfibUsb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724637; c=relaxed/simple;
	bh=Iid+3GBeJAdaquca/Q8nirP3UQOVJc4EBe7DYXF6ig8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tGQMcmwD0ZYBhPD6TdpV9mUhkIXToT05W29o5Q8tTCew7lc85eOEtdoXJsV2ANAlJH6tmy8Mmkjp4uT9zV3v1saQFdnX1qx8mToOO+8XMSXHDN6A44FuAKv4Y8gffc/YNqUKWBUI8z5zE9hbOsXmEPC6hV+WIbi/PFv2Fgalgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A775C116B1;
	Thu, 11 Jul 2024 19:03:55 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 6.11
Date: Thu, 11 Jul 2024 20:03:53 +0100
Message-Id: <20240711190353.3248426-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

I'm about to go on holiday for two weeks, so here's an early pull
request for 6.11. The biggest part is the virtual CPU hotplug that
touches ACPI, irqchip. We also have some GICv3 optimisation for
pseudo-NMIs that has been queued via the arm64 tree. Otherwise the usual
perf updates, kselftest, various small cleanups. There's a minor
conflict currently in -next with the kvmarm tree but it's trivial (in
arch/arm64/include/asm/esr.h).

I'll check emails occasionally during the merging window but if there's
anything urgent, Will can take over.

Thanks.

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 4f3a6c4de7d932be94cde2c52ae58feeec9c9dbf:

  Merge branch 'for-next/vcpu-hotplug' into for-next/core (2024-07-11 19:10:02 +0100)

----------------------------------------------------------------
arm64 updates for 6.11:

* Virtual CPU hotplug support for arm64 ACPI systems

* cpufeature infrastructure cleanups and making the FEAT_ECBHB ID bits
  visible to guests

* CPU errata: expand the speculative SSBS workaround to more CPUs

* arm64 ACPI:

  - acpi=nospcr option to disable SPCR as default console for arm64

  - Move some ACPI code (cpuidle, FFH) to drivers/acpi/arm64/

* GICv3, use compile-time PMR values: optimise the way regular IRQs are
  masked/unmasked when GICv3 pseudo-NMIs are used, removing the need for
  a static key in fast paths by using a priority value chosen
  dynamically at boot time

* arm64 perf updates:

  - Rework of the IMX PMU driver to enable support for I.MX95

  - Enable support for tertiary match groups in the CMN PMU driver

  - Initial refactoring of the CPU PMU code to prepare for the fixed
    instruction counter introduced by Arm v9.4

  - Add missing PMU driver MODULE_DESCRIPTION() strings

  - Hook up DT compatibles for recent CPU PMUs

* arm64 kselftest updates:

  - Kernel mode NEON fp-stress

  - Cleanups, spelling mistakes

* arm64 Documentation update with a minor clarification on TBI

* Miscellaneous:

  - Fix missing IPI statistics

  - Implement raw_smp_processor_id() using thread_info rather than a
    per-CPU variable (better code generation)

  - Make MTE checking of in-kernel asynchronous tag faults conditional
    on KASAN being enabled

  - Minor cleanups, typos

----------------------------------------------------------------
Andre Przywara (2):
      dt-bindings: arm: pmu: Add new Cortex and Neoverse cores
      perf: pmuv3: Add new Cortex and Neoverse PMUs

Anshuman Khandual (3):
      arm64/mm: Stop using ESR_ELx_FSC_TYPE during fault
      KVM: arm64: Replace custom macros with fields from ID_AA64PFR0_EL1
      arm64/cpufeature: Replace custom macros with fields from ID_AA64PFR0_EL1

Catalin Marinas (3):
      irqchip/gic-v3: Fix 'broken_rdists' unused warning when !SMP and !ACPI
      Merge branches 'for-next/cpufeature', 'for-next/misc', 'for-next/kselftest', 'for-next/mte', 'for-next/errata', 'for-next/acpi', 'for-next/gic-v3-pmr' and 'for-next/doc', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/vcpu-hotplug' into for-next/core

Colin Ian King (1):
      kselftest/arm64: Fix a couple of spelling mistakes

Dev Jain (1):
      kselftest/arm64: Fix redundancy of a testcase

Gavin Shan (1):
      arm64: Kconfig: Fix dependencies to enable ACPI_HOTPLUG_CPU

Ilkka Koskinen (2):
      perf/arm-cmn: Decouple wp_config registers from filter group number
      perf/arm-cmn: Enable support for tertiary match group

James Morse (7):
      ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
      ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
      arm64: acpi: Move get_cpu_for_acpi_id() to a header
      irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
      irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs
      arm64: document virtual CPU hotplug's expectations
      cpumask: Add enabled cpumask for present CPUs that can be brought online

Jean-Philippe Brucker (1):
      arm64: psci: Ignore DENIED CPUs

Jeff Johnson (2):
      ARM64: reloc_test: add missing MODULE_DESCRIPTION() macro
      perf: add missing MODULE_DESCRIPTION() macros

Jinjie Ruan (1):
      arm64: smp: Fix missing IPI statistics

Jonathan Cameron (11):
      ACPI: processor: Simplify initial onlining to use same path for cold and hotplug
      cpu: Do not warn on arch_register_cpu() returning -EPROBE_DEFER
      ACPI: processor: Drop duplicated check on _STA (enabled + present)
      ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()
      ACPI: processor: Fix memory leaks in error paths of processor_add()
      ACPI: processor: Move checks and availability of acpi_processor earlier
      ACPI: processor: Add acpi_get_processor_handle() helper
      ACPI: scan: switch to flags for acpi_scan_check_and_detach()
      arm64: acpi: Harden get_cpu_for_acpi_id() against missing CPU entry
      arm64: arch_register_cpu() variant to check if an ACPI handle is now available.
      arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI_PROCESSOR is enabled.

Kevin Brodsky (1):
      Documentation: arm64: Update memory.rst for TBI

Liu Wei (1):
      ACPI: Add acpi=nospcr to disable ACPI SPCR as default console on ARM64

Mark Brown (1):
      kselftest/arm64: Include kernel mode NEON in fp-stress

Mark Rutland (10):
      arm64: cputype: Add Cortex-X3 definitions
      arm64: cputype: Add Cortex-A720 definitions
      arm64: cputype: Add Cortex-X925 definitions
      arm64: errata: Unify speculative SSBS errata logic
      arm64: errata: Expand speculative SSBS workaround
      wordpart.h: Add REPEAT_BYTE_U32()
      irqchip/gic-common: Remove sync_access callback
      irqchip/gic-v3: Make distributor priorities variables
      irqchip/gic-v3: Detect GICD_CTRL.DS and SCR_EL3.FIQ earlier
      arm64: irqchip/gic-v3: Select priorities at boot time

Mike Rapoport (IBM) (1):
      arm64: Kconfig: fix typo in __builtin_return_adddress

Muhammad Usama Anjum (2):
      selftests: arm64: tags_test: conform test to TAP output
      selftests: arm64: tags: remove the result script

Nianyao Tang (1):
      arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits in ID_AA64MMFR1 register

Peter Collingbourne (1):
      arm64: mte: Make mte_check_tfsr_*() conditional on KASAN instead of MTE

Puranjay Mohan (2):
      arm64/arch_timer: include <linux/percpu.h>
      arm64: implement raw_smp_processor_id() using thread_info

Rob Herring (Arm) (5):
      perf: arm_pmuv3: Avoid assigning fixed cycle counter with threshold
      perf: arm_pmuv3: Drop unnecessary IS_ENABLED(CONFIG_ARM64) check
      perf/arm: Move 32-bit PMU drivers to drivers/perf/
      perf: arm_v6/7_pmu: Drop non-DT probe support
      perf: arm_pmuv3: Include asm/arm_pmuv3.h from linux/perf/arm_pmuv3.h

Seongsu Park (1):
      arm64: Cleanup __cpu_set_tcr_t0sz()

Sudeep Holla (3):
      ACPI: arm64: Sort entries alphabetically
      arm64: cpuidle: Move ACPI specific code into drivers/acpi/arm64/
      arm64: FFH: Move ACPI specific code into drivers/acpi/arm64/

Xu Yang (6):
      dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
      perf: imx_perf: add macro definitions for parsing config attr
      perf: imx_perf: let the driver manage the counter usage rather the user
      perf: imx_perf: refactor driver for imx93
      perf: imx_perf: fix counter start and config sequence
      perf: imx_perf: add support for i.MX95 platform

Youwan Wang (1):
      ACPI / amba: Drop unnecessary check for registered amba_dummy_clk

 Documentation/ABI/testing/sysfs-devices-system-cpu |   6 +
 Documentation/admin-guide/kernel-parameters.txt    |  10 +-
 Documentation/arch/arm64/cpu-hotplug.rst           |  79 +++++
 Documentation/arch/arm64/index.rst                 |   1 +
 Documentation/arch/arm64/memory.rst                |  42 ++-
 Documentation/arch/arm64/silicon-errata.rst        |  16 +-
 Documentation/devicetree/bindings/arm/pmu.yaml     |   6 +
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      |   3 +
 arch/arm/kernel/Makefile                           |   2 -
 arch/arm64/Kconfig                                 |  41 +--
 arch/arm64/include/asm/acpi.h                      |  12 +
 arch/arm64/include/asm/arch_gicv3.h                |  15 -
 arch/arm64/include/asm/arch_timer.h                |   2 +-
 arch/arm64/include/asm/arm_pmuv3.h                 |   2 +-
 arch/arm64/include/asm/cpucaps.h                   |   2 +-
 arch/arm64/include/asm/cpufeature.h                |   4 +-
 arch/arm64/include/asm/cputype.h                   |   6 +
 arch/arm64/include/asm/esr.h                       |  33 +-
 arch/arm64/include/asm/mmu_context.h               |   4 +-
 arch/arm64/include/asm/mte.h                       |   4 +-
 arch/arm64/include/asm/ptrace.h                    |  33 +-
 arch/arm64/include/asm/smp.h                       |  13 +-
 arch/arm64/include/asm/sysreg.h                    |   4 -
 arch/arm64/kernel/Makefile                         |   1 -
 arch/arm64/kernel/acpi.c                           | 129 ++------
 arch/arm64/kernel/acpi_numa.c                      |  11 -
 arch/arm64/kernel/cpu_errata.c                     |  17 +-
 arch/arm64/kernel/cpufeature.c                     |   5 +-
 arch/arm64/kernel/image-vars.h                     |   5 -
 arch/arm64/kernel/proton-pack.c                    |   2 +-
 arch/arm64/kernel/psci.c                           |   2 +-
 arch/arm64/kernel/reloc_test_core.c                |   1 +
 arch/arm64/kernel/smp.c                            |  74 ++++-
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h     |  10 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |   4 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |   2 +-
 arch/arm64/kvm/pmu-emul.c                          |   1 -
 drivers/acpi/acpi_processor.c                      | 145 +++++----
 drivers/acpi/arm64/Makefile                        |   6 +-
 drivers/acpi/arm64/amba.c                          |   6 +-
 .../arm64/kernel => drivers/acpi/arm64}/cpuidle.c  |   4 -
 drivers/acpi/arm64/ffh.c                           | 107 +++++++
 drivers/acpi/processor_core.c                      |   3 +-
 drivers/acpi/processor_driver.c                    |  43 +--
 drivers/acpi/scan.c                                |  47 ++-
 drivers/base/cpu.c                                 |  12 +-
 drivers/irqchip/irq-gic-common.c                   |  22 +-
 drivers/irqchip/irq-gic-common.h                   |   7 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  11 +-
 drivers/irqchip/irq-gic-v3.c                       | 282 ++++++++--------
 drivers/irqchip/irq-gic.c                          |  10 +-
 drivers/irqchip/irq-hip04.c                        |   6 +-
 drivers/perf/Kconfig                               |  12 +
 drivers/perf/Makefile                              |   3 +
 drivers/perf/arm-ccn.c                             |   1 +
 drivers/perf/arm-cmn.c                             | 116 +++++--
 drivers/perf/arm_cspmu/ampere_cspmu.c              |   1 +
 drivers/perf/arm_cspmu/arm_cspmu.c                 |   1 +
 drivers/perf/arm_cspmu/nvidia_cspmu.c              |   1 +
 drivers/perf/arm_pmuv3.c                           |  26 +-
 .../perf_event_v6.c => drivers/perf/arm_v6_pmu.c   |  20 +-
 .../perf_event_v7.c => drivers/perf/arm_v7_pmu.c   |  13 +-
 .../perf/arm_xscale_pmu.c                          |   3 -
 drivers/perf/cxl_pmu.c                             |   1 +
 drivers/perf/fsl_imx8_ddr_perf.c                   |   1 +
 drivers/perf/fsl_imx9_ddr_perf.c                   | 354 +++++++++++++++------
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |   1 +
 drivers/perf/marvell_cn10k_ddr_pmu.c               |   1 +
 include/acpi/acpi_bus.h                            |   1 +
 include/acpi/processor.h                           |   2 +-
 include/linux/acpi.h                               |  12 +-
 include/linux/cpumask.h                            |  25 ++
 include/linux/irqchip/arm-gic-common.h             |   4 -
 include/linux/irqchip/arm-gic-v3-prio.h            |  52 +++
 include/linux/irqchip/arm-gic-v3.h                 |   2 +-
 include/linux/perf/arm_pmuv3.h                     |   2 +
 include/linux/wordpart.h                           |   8 +
 kernel/cpu.c                                       |   3 +
 tools/testing/selftests/arm64/abi/ptrace.c         |   2 +-
 tools/testing/selftests/arm64/fp/.gitignore        |   1 +
 tools/testing/selftests/arm64/fp/Makefile          |   1 +
 tools/testing/selftests/arm64/fp/fp-stress.c       |  26 +-
 tools/testing/selftests/arm64/fp/kernel-test.c     | 324 +++++++++++++++++++
 tools/testing/selftests/arm64/tags/Makefile        |   1 -
 .../testing/selftests/arm64/tags/run_tags_test.sh  |  12 -
 tools/testing/selftests/arm64/tags/tags_test.c     |  10 +-
 86 files changed, 1606 insertions(+), 752 deletions(-)
 create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst
 rename {arch/arm64/kernel => drivers/acpi/arm64}/cpuidle.c (97%)
 create mode 100644 drivers/acpi/arm64/ffh.c
 rename arch/arm/kernel/perf_event_v6.c => drivers/perf/arm_v6_pmu.c (95%)
 rename arch/arm/kernel/perf_event_v7.c => drivers/perf/arm_v7_pmu.c (99%)
 rename arch/arm/kernel/perf_event_xscale.c => drivers/perf/arm_xscale_pmu.c (99%)
 create mode 100644 include/linux/irqchip/arm-gic-v3-prio.h
 create mode 100644 tools/testing/selftests/arm64/fp/kernel-test.c
 delete mode 100755 tools/testing/selftests/arm64/tags/run_tags_test.sh


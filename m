Return-Path: <linux-kernel+bounces-576091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D2A70AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2337173B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB71FF7B9;
	Tue, 25 Mar 2025 19:53:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024911EE7B3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932407; cv=none; b=pQfKTtYh5Q5irMMEw0aVI9cvxfQ6CzUJD39HzeWcF1gwNbmYWnL+/U9sNH5IDLko6vuCfFaQRuf/RRJdvfR5BMIIT3ezzodts1UCZnNIlrb3qmc0RR3DFarEiXzhE3/79UWrNrhxObqmRs1EROMjs9DQ8YI74PwMzYtcTZxeVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932407; c=relaxed/simple;
	bh=PKowxcNhSMz+pe5pZnJhk2yLFSsqG/1lsJ8FZb0Z/Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZXnW/c/OQW3OIShonmFXss/E+9JQsLMIH6wJgyEFl3V5v7ssqHHZvlnb/C7wpcUaX4ITPG05wrvTkqnVZLHG4fMm1vayyokekSGnmf70RD15noFM/XWifyEtmriXBriTGTCTckXGdPuOOdLYFaoYR6ZY5iduCXcDDa8e49/YyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D92BC4CEE4;
	Tue, 25 Mar 2025 19:53:25 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates 6.15-rc1
Date: Tue, 25 Mar 2025 19:53:22 +0000
Message-Id: <20250325195322.3243734-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the arm64 updates for 6.15-rc1 below. Nothing major this
time around. Apart from the usual perf/PMU updates, some page table
cleanups, the notable features are average CPU frequency based on the
AMUv1 counters, CONFIG_HOTPLUG_SMT and MOPS instructions (memcpy/memset)
in the uaccess routines.

Thanks.

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 64fa6b9322a904198589c0479dca6f2ed7f2eb04:

  Merge branch 'for-next/el2-enable-feat-pmuv3p9' into for-next/core (2025-03-25 19:32:32 +0000)

----------------------------------------------------------------
arm64 updates for 6.15:

Perf and PMUs:

 - Support for the "Rainier" CPU PMU from Arm

 - Preparatory driver changes and cleanups that pave the way for BRBE
   support

 - Support for partial virtualisation of the Apple-M1 PMU

 - Support for the second event filter in Arm CSPMU designs

 - Minor fixes and cleanups (CMN and DWC PMUs)

 - Enable EL2 requirements for FEAT_PMUv3p9

Power, CPU topology:

 - Support for AMUv1-based average CPU frequency

 - Run-time SMT control wired up for arm64 (CONFIG_HOTPLUG_SMT). It adds
   a generic topology_is_primary_thread() function overridden by x86 and
   powerpc

New(ish) features:

 - MOPS (memcpy/memset) support for the uaccess routines

Security/confidential compute:

 - Fix the DMA address for devices used in Realms with Arm CCA. The
   CCA architecture uses the address bit to differentiate between shared
   and private addresses

 - Spectre-BHB: assume CPUs Linux doesn't know about vulnerable by
   default

Memory management clean-ups:

 - Drop the P*D_TABLE_BIT definition in preparation for 128-bit PTEs

 - Some minor page table accessor clean-ups

 - PIE/POE (permission indirection/overlay) helpers clean-up

Kselftests:

 - MTE: skip hugetlb tests if MTE is not supported on such mappings and
   user correct naming for sync/async tag checking modes

Miscellaneous:

 - Add a PKEY_UNRESTRICTED definition as 0 to uapi (toolchain people
   request)

 - Sysreg updates for new register fields

 - CPU type info for some Qualcomm Kryo cores

----------------------------------------------------------------
Anshuman Khandual (16):
      arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
      arm64/sysreg: Add register fields for HDFGRTR2_EL2
      arm64/sysreg: Add register fields for HDFGWTR2_EL2
      arm64/sysreg: Add register fields for HFGITR2_EL2
      arm64/sysreg: Add register fields for HFGRTR2_EL2
      arm64/sysreg: Add register fields for HFGWTR2_EL2
      arm64/mm: Convert __pte_to_phys() and __phys_to_pte_val() as functions
      arm64/hugetlb: Consistently use pud_sect_supported()
      arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
      KVM: arm64: ptdump: Test PMD_TYPE_MASK for block mapping
      arm64/ptdump: Test PMD_TYPE_MASK for block mapping
      arm64/mm: Clear PXX_TYPE_MASK in mk_[pmd|pud]_sect_prot()
      arm64/mm: Clear PXX_TYPE_MASK and set PXD_TYPE_SECT in [pmd|pud]_mkhuge()
      arm64/mm: Check PXD_TYPE_TABLE in [p4d|pgd]_bad()
      arm64/mm: Drop PXD_TABLE_BIT
      arm64/mm: Define PTDESC_ORDER

Ard Biesheuvel (1):
      arm64/kernel: Always use level 2 or higher for early mappings

Beata Michalska (5):
      cpufreq: Allow arch_freq_get_on_cpu to return an error
      cpufreq: Introduce an optional cpuinfo_avg_freq sysfs entry
      arm64: Provide an AMU-based version of arch_freq_get_on_cpu
      arm64: Update AMU-based freq scale factor on entering idle
      arm64: Utilize for_each_cpu_wrap for reference lookup

Catalin Marinas (5):
      kselftest/arm64: mte: Use the correct naming for tag check modes in check_hugetlb_options.c
      kselftest/arm64: mte: Skip the hugetlb tests if MTE not supported on such mappings
      Merge branches 'for-next/amuv1-avg-freq', 'for-next/pkey_unrestricted', 'for-next/sysreg', 'for-next/misc', 'for-next/pgtable-cleanups', 'for-next/kselftest', 'for-next/uaccess-mops', 'for-next/pie-poe-cleanup', 'for-next/cputype-kryo', 'for-next/cca-dma-address', 'for-next/drop-pxd_table_bit' and 'for-next/spectre-bhb-assume-vulnerable', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/smt-control' into for-next/core
      Merge branch 'for-next/el2-enable-feat-pmuv3p9' into for-next/core

Douglas Anderson (7):
      arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
      arm64: cputype: Add comments about Qualcomm Kryo 5XX and 6XX cores
      arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
      arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
      arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe list
      arm64: cputype: Add MIDR_CORTEX_A76AE
      arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists

Ionela Voinescu (1):
      arch_topology: init capacity_freq_ref to 0

James Clark (2):
      arm64/sysreg: Fix unbalanced closing block
      arm64/sysreg: Enforce whole word match for open/close tokens

Kevin Brodsky (3):
      arm64/sysreg: Improve PIR/POR helpers
      arm64/sysreg: Rename POE_RXW to POE_RWX
      arm64/sysreg: Move POR_EL0_INIT to asm/por.h

Kristina Martšenko (3):
      arm64: extable: Add fixup handling for uaccess CPY* instructions
      arm64: mm: Handle PAN faults on uaccess CPY* instructions
      arm64: lib: Use MOPS for usercopy routines

Madhavan Srinivasan (1):
      selftest/powerpc/mm/pkey: fix build-break introduced by commit 00894c3fc917

Mark Rutland (3):
      perf: arm_pmu: Don't disable counter in armpmu_add()
      perf: arm_pmuv3: Don't disable counter in armv8pmu_enable_event()
      perf: arm_pmu: Move PMUv3-specific data

Oliver Upton (2):
      drivers/perf: apple_m1: Refactor event select/filter configuration
      drivers/perf: apple_m1: Support host/guest event filtering

Rob Herring (Arm) (4):
      perf: arm_pmuv3: Call kvm_vcpu_pmu_resync_el0() before enabling counters
      perf: arm_v7_pmu: Drop obvious comments for enabling/disabling counters and interrupts
      perf: arm_v7_pmu: Don't disable counter in (armv7|krait_|scorpion_)pmu_enable_event()
      perf: apple_m1: Don't disable counter in m1_pmu_enable_event()

Robin Murphy (5):
      perf/arm-cmn: Minor event type housekeeping
      perf/arm_cspmu: Move register definitons to header
      perf/arm_cspmu: Generalise event filtering
      perf/arm_cspmu: Add PMEVFILT2R support
      perf/arm_cspmu: Fix missing io.h include

Ryan Roberts (2):
      arm64/mm: Check PUD_TYPE_TABLE in pud_bad()
      arm64/mm: Check pmd_table() in pmd_trans_huge()

Suzuki K Poulose (3):
      dma: Fix encryption bit clearing for dma_to_phys
      dma: Introduce generic dma_addr_*crypted helpers
      arm64: realm: Use aliased addresses for device DMA to shared buffers

Thomas Weißschuh (1):
      arm64: mm: Don't use %pK through printk

Vincenzo Frascino (1):
      perf: arm_pmuv3: Add support for ARM Rainier PMU

Will Deacon (1):
      Merge branch 'perf/m1-guest-events' of git://git.kernel.org/pub/scm/linux/kernel/git/oupton/linux into for-next/perf

Yicong Yang (4):
      cpu/SMT: Provide a default topology_is_primary_thread()
      arch_topology: Support SMT control for OF based system
      arm64: topology: Support SMT control on ACPI based system
      arm64: Kconfig: Enable HOTPLUG_SMT

Yue Haibing (1):
      arm64/fpsimd: Remove unused declaration fpsimd_kvm_prepare()

Yunhui Cui (2):
      perf/dwc_pcie: fix some unreleased resources
      perf/dwc_pcie: fix duplicate pci_dev devices

Yury Khrustalev (3):
      mm/pkey: Add PKEY_UNRESTRICTED macro
      selftests/mm: Use PKEY_UNRESTRICTED macro
      selftests/powerpc: Use PKEY_UNRESTRICTED macro

 Documentation/admin-guide/pm/cpufreq.rst           |  17 +-
 Documentation/arch/arm64/booting.rst               |  22 +++
 arch/arm64/Kconfig                                 |   3 +-
 arch/arm64/include/asm/apple_m1_pmu.h              |   1 +
 arch/arm64/include/asm/asm-extable.h               |  10 +-
 arch/arm64/include/asm/asm-uaccess.h               |   4 +
 arch/arm64/include/asm/cputype.h                   |  14 ++
 arch/arm64/include/asm/el2_setup.h                 |  25 +++
 arch/arm64/include/asm/extable.h                   |   4 +-
 arch/arm64/include/asm/fpsimd.h                    |   1 -
 arch/arm64/include/asm/kernel-pgtable.h            |   8 +-
 arch/arm64/include/asm/mem_encrypt.h               |  11 ++
 arch/arm64/include/asm/pgtable-hwdef.h             |  35 ++--
 arch/arm64/include/asm/pgtable-prot.h              |  36 ++--
 arch/arm64/include/asm/pgtable.h                   |  80 +++++---
 arch/arm64/include/asm/por.h                       |  11 +-
 arch/arm64/include/asm/spectre.h                   |   1 -
 arch/arm64/include/asm/sysreg.h                    |  15 +-
 arch/arm64/kernel/pi/map_range.c                   |   6 +-
 arch/arm64/kernel/proton-pack.c                    | 208 +++++++++++----------
 arch/arm64/kernel/signal.c                         |   2 +-
 arch/arm64/kernel/topology.c                       | 182 +++++++++++++++++-
 arch/arm64/kvm/at.c                                |   8 +-
 arch/arm64/kvm/ptdump.c                            |   4 +-
 arch/arm64/lib/clear_user.S                        |  25 ++-
 arch/arm64/lib/copy_from_user.S                    |  10 +
 arch/arm64/lib/copy_template.S                     |  10 +
 arch/arm64/lib/copy_to_user.S                      |  10 +
 arch/arm64/mm/extable.c                            |  40 +++-
 arch/arm64/mm/fault.c                              |   4 +-
 arch/arm64/mm/hugetlbpage.c                        |  20 +-
 arch/arm64/mm/kasan_init.c                         |   6 +-
 arch/arm64/mm/mmu.c                                |  10 +-
 arch/arm64/mm/physaddr.c                           |   2 +-
 arch/arm64/mm/ptdump.c                             |   4 +-
 arch/arm64/tools/gen-sysreg.awk                    |  31 +--
 arch/arm64/tools/sysreg                            | 105 ++++++++++-
 arch/powerpc/include/asm/topology.h                |   1 +
 arch/x86/include/asm/topology.h                    |   2 +-
 arch/x86/kernel/cpu/aperfmperf.c                   |   2 +-
 arch/x86/kernel/cpu/proc.c                         |   7 +-
 drivers/base/arch_topology.c                       |  26 ++-
 drivers/cpufreq/Kconfig.x86                        |  12 ++
 drivers/cpufreq/cpufreq.c                          |  38 +++-
 drivers/perf/apple_m1_cpu_pmu.c                    |  70 ++++---
 drivers/perf/arm-cmn.c                             |   5 +-
 drivers/perf/arm_cspmu/ampere_cspmu.c              |  32 +---
 drivers/perf/arm_cspmu/arm_cspmu.c                 |  81 ++------
 drivers/perf/arm_cspmu/arm_cspmu.h                 |  57 +++++-
 drivers/perf/arm_cspmu/nvidia_cspmu.c              |  22 ++-
 drivers/perf/arm_pmu.c                             |   8 +-
 drivers/perf/arm_pmuv3.c                           |  11 +-
 drivers/perf/arm_v7_pmu.c                          |  50 -----
 drivers/perf/dwc_pcie_pmu.c                        |  51 +++--
 include/linux/cpufreq.h                            |   2 +-
 include/linux/dma-direct.h                         |  13 +-
 include/linux/mem_encrypt.h                        |  23 +++
 include/linux/perf/arm_pmu.h                       |  13 +-
 include/linux/topology.h                           |  23 +++
 include/uapi/asm-generic/mman-common.h             |   1 +
 .../selftests/arm64/mte/check_hugetlb_options.c    |  19 +-
 tools/testing/selftests/mm/mseal_test.c            |   6 +-
 tools/testing/selftests/mm/pkey-helpers.h          |   3 +-
 tools/testing/selftests/mm/pkey_sighandler_tests.c |   4 +-
 tools/testing/selftests/mm/protection_keys.c       |   2 +-
 tools/testing/selftests/powerpc/include/pkeys.h    |   5 +-
 .../testing/selftests/powerpc/mm/pkey_exec_prot.c  |   2 +-
 tools/testing/selftests/powerpc/mm/pkey_siginfo.c  |   2 +-
 tools/testing/selftests/powerpc/ptrace/core-pkey.c |   6 +-
 .../testing/selftests/powerpc/ptrace/ptrace-pkey.c |   6 +-
 70 files changed, 1111 insertions(+), 479 deletions(-)


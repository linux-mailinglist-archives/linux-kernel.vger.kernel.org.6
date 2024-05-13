Return-Path: <linux-kernel+bounces-177744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176C68C4427
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A244B22E55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8BF57C96;
	Mon, 13 May 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka1OKGm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9557894
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614200; cv=none; b=MR1BtNhltPcD9X2Z/JaDk8RmXnZopIq8oAzu2nMqnMsChTd3mUvIRHxTGmVXSw05zK7FUYda82TWOP7zX6iEMStQlrLQpAYWd4g4mPZZXHTle9xz/1mrgUn+y25yUeJJRYzomoiTjUnC3fpVf3svPp2bb1Km4mg4XGG4c5rXLGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614200; c=relaxed/simple;
	bh=HvLHlNIARfVIcuFw9eDkpyU0syqxjB/6zfMwQil/xfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uVCVJmDiIzwTwh58GBl/lg5FS7aqOmzcF6Qs7MvSbeeK/o9A2qN0NekOCRSLeTrVF8ZkNmmUTPrYOcLhFZQDKZgF8ZHS0lDfyX8jZHQvMyg0pLUy2+JB8GMr0QClt4vLHaUuEksgYBzPPwo8Uvz3EALTQQ+Q4Zngz94vdhi8tNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka1OKGm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BA0C113CC;
	Mon, 13 May 2024 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715614200;
	bh=HvLHlNIARfVIcuFw9eDkpyU0syqxjB/6zfMwQil/xfc=;
	h=Date:From:To:Cc:Subject:From;
	b=ka1OKGm+yZJ19L+u+jngRCvJ9aloBT5oRnIOPm7bU64+iyPhuKzz0nzZNyTt8zcZG
	 ar+9VvpUc3+CvhOx+q554GwetNkqLhjzP88UKKwp/N3UAVZ9q/B9rF/2PS2kNtYRz1
	 U8kyteyd0I1PmWTYye1821tI16GCaaBNBffRNX0qCxL1vj3u/Ix5zLbOn1atpk483x
	 3UXEUuyZlGSrvWRyiWzRYJzjxHlwowIUptnEAn+cmysosu7Mq5IZINdfr/6rmhePfT
	 ziHJ1zNN0eaHxoBHrVhYYcTgKPfwhUwYdGEnv9JOlrgHUI3/Yzl1pd3eS33wcseISd
	 dClIlpLHRrSHQ==
Date: Mon, 13 May 2024 16:29:55 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 updates for 6.10
Message-ID: <20240513152955.GA28901@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull these arm64 updates for 6.10. There's a summary in the tag,
but the most interesting parts are probably the mm changes from Ryan
which optimise the creation of the linear mapping at boot and
(separately) implement write-protect support for userfaultfd.

Outside of our usual directories, the Kbuild-related changes under
scripts/ have been acked by Masahiro whilst the drivers/acpi/ parts have
been acked by Rafael and the addition of cpumask_any_and_but() has been
acked by Yury.

I've also picked up some CPU errata workarounds since tagging this, so
I'll aim to send those next week.

Cheers,

Will

--->8

The following changes since commit e3ba51ab24fddef79fc212f9840de54db8fd1685:

  arm64: tlb: Fix TLBI RANGE operand (2024-04-10 18:22:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 54e1a2aa61a7bf4af2799baf7ab2dc2712844245:

  Merge branch 'for-next/tlbi' into for-next/core (2024-05-09 15:56:26 +0100)

----------------------------------------------------------------
arm64 updates for 6.10

ACPI:
* Support for the Firmware ACPI Control Structure (FACS) signature
  feature which is used to reboot out of hibernation on some systems.

Kbuild:
* Support for building Flat Image Tree (FIT) images, where the kernel
  Image is compressed alongside a set of devicetree blobs.

Memory management:
* Optimisation of our early page-table manipulation for creation of the
  linear mapping.

* Support for userfaultfd write protection, which brings along some nice
  cleanups to our handling of invalid but present ptes.

* Extend our use of range TLBI invalidation at EL1.

Perf and PMUs:
* Ensure that the 'pmu->parent' pointer is correctly initialised by PMU
  drivers.

* Avoid allocating 'cpumask_t' types on the stack in some PMU drivers.

* Fix parsing of the CPU PMU "version" field in assembly code, as it
  doesn't follow the usual architectural rules.

* Add best-effort unwinding support for USER_STACKTRACE

* Minor driver fixes and cleanups.

Selftests:
* Minor cleanups to the arm64 selftests (missing NULL check, unused
  variable).

Miscellaneous
* Add a command-line alias for disabling 32-bit application support.

* Add part number for Neoverse-V2 CPUs.

* Minor fixes and cleanups.

----------------------------------------------------------------
Andrea della Porta (1):
      arm64: Add the arm64.no32bit_el0 command line option

Andy Shevchenko (1):
      drivers/perf: thunderx2_pmu: Replace open coded acpi_match_acpi_device()

Besar Wicaksono (1):
      arm64: Add Neoverse-V2 part

David Woodhouse (2):
      ACPICA: Detect FACS even for hardware reduced platforms
      arm64: acpi: Honour firmware_signature field of FACS, if it exists

Dawei Li (9):
      perf/alibaba_uncore_drw: Avoid placing cpumask on the stack
      perf/arm-cmn: Avoid placing cpumask on the stack
      perf/arm_cspmu: Avoid placing cpumask on the stack
      perf/arm_dsu: Avoid placing cpumask on the stack
      perf/dwc_pcie: Avoid placing cpumask on the stack
      perf/hisi_pcie: Avoid placing cpumask on the stack
      perf/hisi_uncore: Avoid placing cpumask on the stack
      perf/qcom_l2: Avoid placing cpumask on the stack
      perf/thunderx2: Avoid placing cpumask on the stack

Gavin Shan (2):
      arm64: tlb: Improve __TLBI_VADDR_RANGE()
      arm64: tlb: Allow range operation for MAX_TLBI_RANGE_PAGES

George Guo (1):
      arm64: simplify arch_static_branch/_jump function

Hao Chen (1):
      drivers/perf: hisi: hns3: Actually use devm_add_action_or_reset()

Jinjie Ruan (1):
      arm64: Remove unnecessary irqflags alternative.h include

Joel Granados (1):
      drivers: perf: Remove the now superfluous sentinel elements from ctl_table array

Jonathan Cameron (23):
      perf/hisi-pcie: Assign parent for event_source device
      Documentation: hisi-pmu: Drop reference to /sys/devices path
      perf/hisi-uncore: Assign parents for event_source devices
      Documentation: hns-pmu: Use /sys/bus/event_source/devices paths
      perf/hisi-hns3: Assign parents for event_source device
      perf/amlogic: Assign parents for event_source devices
      perf/arm_cspmu: Assign parents for event_source devices
      Documentation: xgene-pmu: Use /sys/bus/event_source/devices paths
      perf/xgene: Assign parents for event_source devices
      Documentation: thunderx2-pmu: Use /sys/bus/event_source/devices paths
      perf/thunderx2: Assign parents for event_source devices
      perf/riscv: Assign parents for event_source devices
      Documentation: qcom-pmu: Use /sys/bus/event_source/devices paths
      perf/qcom: Assign parents for event_source devices
      perf/imx_ddr: Assign parents for event_source devices
      perf/arm_pmu: Assign parents for event_source devices
      perf/alibaba_uncore: Assign parents for event_source device
      perf/arm-cci: Assign parents for event_source device
      perf/arm-ccn: Assign parents for event_source device
      perf/arm-dmc620: Assign parents for event_source device
      perf/arm-dsu: Assign parents for event_source device
      perf/arm-smmuv3: Assign parents for event_source device
      perf/arm-spe: Assign parents for event_source device

Junhao He (2):
      drivers/perf: hisi_pcie: Fix out-of-bound access when valid event group
      drivers/perf: hisi: hns3: Fix out-of-bound access when valid event group

Kunwu Chan (1):
      kselftest: arm64: Add a null pointer check

Mark Rutland (3):
      cpumask: add cpumask_any_and_but()
      arm64: assembler: update stale comment for disable_step_tsk
      arm64: defer clearing DAIF.D

Robin Murphy (1):
      perf/arm-cmn: Set PMU device parent

Ryan Roberts (8):
      arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
      arm64: mm: Batch dsb and isb when populating pgtables
      arm64: mm: Don't remap pgtables for allocate vs populate
      arm64/mm: generalize PMD_PRESENT_INVALID for all levels
      arm64/mm: Remove PTE_PROT_NONE bit
      arm64/mm: Move PTE_PRESENT_INVALID to overlay PTE_NG
      arm64/mm: Add uffd write-protect support
      arm64/mm: Fix pud_user_accessible_page() for PGTABLE_LEVELS <= 2

Shiqi Liu (1):
      arm64/sysreg: Update PIE permission encodings

Simon Glass (2):
      arm64: Add BOOT_TARGETS variable
      arm64: boot: Support Flat Image Tree

Will Deacon (7):
      Merge branch 'for-next/acpi' into for-next/core
      Merge branch 'for-next/kbuild' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/selftests' into for-next/core
      Merge branch 'for-next/tlbi' into for-next/core

Yicong Yang (1):
      arm64: arm_pmuv3: Correctly extract and check the PMUVer

chenqiwu (1):
      arm64: Add USER_STACKTRACE support

xieming (1):
      kselftest/arm64: Remove unused parameters in abi test

 Documentation/admin-guide/kernel-parameters.txt  |   3 +
 Documentation/admin-guide/perf/hisi-pmu.rst      |   1 -
 Documentation/admin-guide/perf/hns3-pmu.rst      |   8 +-
 Documentation/admin-guide/perf/qcom_l2_pmu.rst   |   2 +-
 Documentation/admin-guide/perf/qcom_l3_pmu.rst   |   2 +-
 Documentation/admin-guide/perf/thunderx2-pmu.rst |   2 +-
 Documentation/admin-guide/perf/xgene-pmu.rst     |   2 +-
 Documentation/process/changes.rst                |   9 +
 MAINTAINERS                                      |   7 +
 arch/arm64/Kconfig                               |   2 +
 arch/arm64/Makefile                              |  11 +-
 arch/arm64/boot/.gitignore                       |   1 +
 arch/arm64/boot/Makefile                         |   6 +-
 arch/arm64/include/asm/assembler.h               |  13 +-
 arch/arm64/include/asm/cputype.h                 |   2 +
 arch/arm64/include/asm/el2_setup.h               |   9 +-
 arch/arm64/include/asm/irqflags.h                |   1 -
 arch/arm64/include/asm/jump_label.h              |  28 ++-
 arch/arm64/include/asm/pgtable-prot.h            |  19 +-
 arch/arm64/include/asm/pgtable.h                 | 114 ++++++---
 arch/arm64/include/asm/sysreg.h                  |  24 +-
 arch/arm64/include/asm/tlbflush.h                |  33 ++-
 arch/arm64/kernel/acpi.c                         |  10 +
 arch/arm64/kernel/perf_callchain.c               | 118 +--------
 arch/arm64/kernel/pi/idreg-override.c            |   2 +
 arch/arm64/kernel/setup.c                        |  11 +-
 arch/arm64/kernel/smp.c                          |   7 +
 arch/arm64/kernel/stacktrace.c                   | 120 ++++++++++
 arch/arm64/mm/mmu.c                              | 101 ++++----
 arch/arm64/mm/proc.S                             |  10 -
 drivers/acpi/acpica/tbfadt.c                     |  30 +--
 drivers/acpi/acpica/tbutils.c                    |   7 +-
 drivers/perf/alibaba_uncore_drw_pmu.c            |  11 +-
 drivers/perf/amlogic/meson_ddr_pmu_core.c        |   1 +
 drivers/perf/arm-cci.c                           |   1 +
 drivers/perf/arm-ccn.c                           |   1 +
 drivers/perf/arm-cmn.c                           |  11 +-
 drivers/perf/arm_cspmu/arm_cspmu.c               |   9 +-
 drivers/perf/arm_dmc620_pmu.c                    |   1 +
 drivers/perf/arm_dsu_pmu.c                       |  20 +-
 drivers/perf/arm_pmu_platform.c                  |   1 +
 drivers/perf/arm_smmuv3_pmu.c                    |   1 +
 drivers/perf/arm_spe_pmu.c                       |   1 +
 drivers/perf/dwc_pcie_pmu.c                      |  10 +-
 drivers/perf/fsl_imx8_ddr_perf.c                 |   1 +
 drivers/perf/hisilicon/hisi_pcie_pmu.c           |  24 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c         |   7 +-
 drivers/perf/hisilicon/hns3_pmu.c                |  17 +-
 drivers/perf/qcom_l2_pmu.c                       |   9 +-
 drivers/perf/qcom_l3_pmu.c                       |   1 +
 drivers/perf/riscv_pmu_legacy.c                  |   1 +
 drivers/perf/riscv_pmu_sbi.c                     |   2 +-
 drivers/perf/thunderx2_pmu.c                     |  30 +--
 drivers/perf/xgene_pmu.c                         |   1 +
 include/linux/cpumask.h                          |  23 ++
 scripts/Makefile.lib                             |  16 ++
 scripts/make_fit.py                              | 290 +++++++++++++++++++++++
 tools/arch/arm64/include/asm/sysreg.h            |  24 +-
 tools/testing/selftests/arm64/abi/tpidr2.c       |   2 +-
 tools/testing/selftests/arm64/tags/tags_test.c   |   4 +
 60 files changed, 859 insertions(+), 376 deletions(-)
 create mode 100755 scripts/make_fit.py


Return-Path: <linux-kernel+bounces-572922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8172A6D071
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3B37A309E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5C1946C7;
	Sun, 23 Mar 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hZnZAFjJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+H5KFevr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429E199E89
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752317; cv=none; b=KQRVo5KLJ8X7z8ZcZG2CFkJ3O0WRUAmHUplX1+90BM39aMRybU91eJ3KFbPLojMa0ivp99P9TOHxV09PyIwWSEflvdkG/DfLJXQCaonDsGXDs14+kqbSdPiGC337haQKBHNzNyc7K7/KHV6USINJj3qt81gZX8RsEG6YW3Ei30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752317; c=relaxed/simple;
	bh=XtB28eMR40YN6s+52BwDmedbQhsNyk4t6LHniFqY+0o=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=lns4FIafE+Vm0xRzYi5Wvg9wI7bh9RqUsZL1NADVDf79GFbQKJq2901eLPLVU0klvFk+KgrraPQTxfWRx0LIh9rlJliA9R8aqRPj49gMm671z6lj3nqb8aw+jl4rqkk1d8/V56MjsJL7uYC5KORmkjTX7nTwMKGPuGmtriT5BkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hZnZAFjJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+H5KFevr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742752304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=ILK4S8nV4pUiponXtwt3LbW2NDhzdMqrMT2IIjwInMI=;
	b=hZnZAFjJMmUgu8XLV7B4LW8sxDhekGfemxyG7nvsB0lrY12ojJFMmTb0IIbD1hVwZDAWvP
	qmRlNXCsh8NVKNLv5JIpL6OmGKkLo0hXauYFZiKLuSg33Ry10whQFulZFfjVzhkPgnRSQX
	fGmfAE5S+sP1l1wcozRo2AAFhB69nqGrfT+Rm8HGVSox6c0FHCTcv41eVF9JKrmv83g9jh
	ecGkjpHgefkqhf+qPbYe1c5rdbOdFR+eEkGorIp/m+j6wjCm1OhGgNie+3yl4lMjmaRqs/
	A+/oh03ub/loif1PqK7fkm1U3OLjbDc3tjBWdpbP/7K39TwD/ZK97ZCkMFVYlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742752304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=ILK4S8nV4pUiponXtwt3LbW2NDhzdMqrMT2IIjwInMI=;
	b=+H5KFevrais+xg1JPx/wDA6n3XtC8zbLO0xBorVC2HbrW1QwKMFuAmtNiWQBvC4fiL2bT7
	LZ/j+Av1DLAlpcBw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/vdso for v6.15-rc1
References: <174275225552.1561082.4969731002775597670.tglx@xen13>
Message-ID: <174275226574.1561082.183279031431690330.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 18:51:44 +0100 (CET)

Linus,

please pull the latest timers/vdso branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2025=
-03-23

up to:  652262975db4: sparc/vdso: Always reject undefined references during l=
inking

Updates for the VDSO infrastructure:

  - Consolidate the VDSO storage=20
 =20
    The VDSO data storage and data layout has been largely architecture
    specific for historical reasons. That increases the maintenance effort
    and causes inconsistencies over and over.

    There is no real technical reason for architecture specific layouts and
    implementations. The architecture specific details can easily be
    integrated into a generic layout, which also reduces the amount of
    duplicated code for managing the mappings.

    Convert all architectures over to a unified layout and common mapping
    infrastructure. This splits the VDSO data layout into subsystem
    specific blocks, timekeeping, random and architecture parts, which
    provides a better structure and allows to improve and update the
    functionalities without conflict and interaction.

  - Rework the timekeeping data storage

    The current implementation is designed for exposing system timekeeping
    accessors, which was good enough at the time when it was designed.

    PTP and Time Sensitive Networking (TSN) change that as there are
    requirements to expose independent PTP clocks, which are not related to
    system timekeeping.

    Replace the monolithic data storage by a structured layout, which
    allows to add support for independent PTP clocks on top while reusing
    both the data structures and the time accessor implementations.

Note: There is a trivial conflict vs. the x86/core pull request, which
      changes a VDSO random implementation detail.

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (15):
      vdso: Make vdso_time_data cacheline aligned
      vdso/datapage: Define vdso_clock to prepare for multiple PTP clocks
      vdso/helpers: Prepare introduction of struct vdso_clock
      vdso/gettimeofday: Prepare introduction of struct vdso_clock
      vdso/gettimeofday: Prepare do_hres() for introduction of struct vdso_cl=
ock
      vdso/gettimeofday: Prepare do_hres_timens() for introduction of struct =
vdso_clock
      vdso/gettimeofday: Prepare do_coarse() for introduction of struct vdso_=
clock
      vdso/gettimeofday: Prepare do_coarse_timens() for introduction of struc=
t vdso_clock
      vdso/gettimeofday: Prepare helper functions for introduction of struct =
vdso_clock
      vdso/vsyscall: Prepare introduction of struct vdso_clock
      vdso/namespace: Rename timens_setup_vdso_data() to reflect new vdso_clo=
ck struct
      time/namespace: Prepare introduction of struct vdso_clock
      x86/vdso: Prepare introduction of struct vdso_clock
      vdso: Move architecture related data before basetime data
      vdso: Rework struct vdso_time_data and introduce struct vdso_clock

Nam Cao (2):
      arm64/vdso: Prepare introduction of struct vdso_clock
      powerpc/vdso: Prepare introduction of struct vdso_clock

Thomas Wei=C3=9Fschuh (38):
      x86/vdso: Fix latent bug in vclock_pages calculation
      parisc: Remove unused symbol vdso_data
      vdso: Introduce vdso/align.h
      vdso: Rename included Makefile
      vdso: Add generic time data storage
      vdso: Add generic random data storage
      vdso: Add generic architecture-specific data storage
      arm64: vdso: Switch to generic storage implementation
      riscv: vdso: Switch to generic storage implementation
      LoongArch: vDSO: Switch to generic storage implementation
      arm: vdso: Switch to generic storage implementation
      s390/vdso: Switch to generic storage implementation
      MIPS: vdso: Switch to generic storage implementation
      powerpc/vdso: Switch to generic storage implementation
      x86/vdso: Switch to generic storage implementation
      x86/vdso/vdso2c: Remove page handling
      vdso: Remove remnants of architecture-specific random state storage
      vdso: Remove remnants of architecture-specific time storage
      MAINTAINERS: Add vDSO selftests
      elf, uapi: Add definition for STN_UNDEF
      elf, uapi: Add definition for DT_GNU_HASH
      elf, uapi: Add definitions for VER_FLG_BASE and VER_FLG_WEAK
      elf, uapi: Add type ElfXX_Versym
      elf, uapi: Add types ElfXX_Verdef and ElfXX_Veraux
      tools/include: Add uapi/linux/elf.h
      selftests: Add headers target
      tools/nolibc: add limits.h shim header
      selftests: vDSO: vdso_standalone_test_x86: Use vdso_init_form_sysinfo_e=
hdr
      selftests: vDSO: parse_vdso: Drop vdso_init_from_auxv()
      selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers
      selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__ instead of ULONG_MAX
      selftests: vDSO: vdso_test_gettimeofday: Clean up includes
      selftests: vDSO: vdso_test_gettimeofday: Make compatible with nolibc
      selftests: vDSO: vdso_standalone_test_x86: Switch to nolibc
      vdso: Introduce vdso/cache.h
      arm64: Make asm/cache.h compatible with vDSO
      x86/vdso: Always reject undefined references during linking
      sparc/vdso: Always reject undefined references during linking


 MAINTAINERS                                        |   1 +
 arch/Kconfig                                       |   4 +
 arch/arm/include/asm/vdso.h                        |   2 +
 arch/arm/include/asm/vdso/gettimeofday.h           |   7 +-
 arch/arm/include/asm/vdso/vsyscall.h               |  12 +-
 arch/arm/kernel/asm-offsets.c                      |   4 -
 arch/arm/kernel/vdso.c                             |  34 +-
 arch/arm/mm/Kconfig                                |   1 +
 arch/arm/vdso/Makefile                             |   2 +-
 arch/arm/vdso/vdso.lds.S                           |   4 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/cache.h                     |   4 +-
 arch/arm64/include/asm/vdso.h                      |   2 +-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h  |  38 +-
 arch/arm64/include/asm/vdso/getrandom.h            |  12 -
 arch/arm64/include/asm/vdso/gettimeofday.h         |  16 +-
 arch/arm64/include/asm/vdso/vsyscall.h             |  29 +-
 arch/arm64/kernel/vdso.c                           |  90 +---
 arch/arm64/kernel/vdso/Makefile                    |   2 +-
 arch/arm64/kernel/vdso/vdso.lds.S                  |   7 +-
 arch/arm64/kernel/vdso32/Makefile                  |   2 +-
 arch/arm64/kernel/vdso32/vdso.lds.S                |   7 +-
 arch/csky/kernel/vdso/Makefile                     |   2 +-
 arch/loongarch/Kconfig                             |   2 +
 arch/loongarch/include/asm/vdso.h                  |   1 -
 arch/loongarch/include/asm/vdso/arch_data.h        |  25 +
 arch/loongarch/include/asm/vdso/getrandom.h        |   5 -
 arch/loongarch/include/asm/vdso/gettimeofday.h     |  14 +-
 arch/loongarch/include/asm/vdso/vdso.h             |  38 +-
 arch/loongarch/include/asm/vdso/vsyscall.h         |  17 -
 arch/loongarch/kernel/asm-offsets.c                |   2 +-
 arch/loongarch/kernel/vdso.c                       |  92 +---
 arch/loongarch/vdso/Makefile                       |   2 +-
 arch/loongarch/vdso/vdso.lds.S                     |   8 +-
 arch/loongarch/vdso/vgetcpu.c                      |  12 +-
 arch/mips/Kconfig                                  |   1 +
 arch/mips/include/asm/vdso/gettimeofday.h          |   9 +-
 arch/mips/include/asm/vdso/vdso.h                  |  19 +-
 arch/mips/include/asm/vdso/vsyscall.h              |  14 +-
 arch/mips/kernel/vdso.c                            |  47 +-
 arch/mips/vdso/Makefile                            |   2 +-
 arch/mips/vdso/vdso.lds.S                          |   5 +-
 arch/parisc/include/asm/vdso.h                     |   2 -
 arch/parisc/kernel/vdso32/Makefile                 |   2 +-
 arch/parisc/kernel/vdso64/Makefile                 |   2 +-
 arch/powerpc/Kconfig                               |   2 +
 arch/powerpc/include/asm/vdso.h                    |   1 +
 arch/powerpc/include/asm/vdso/arch_data.h          |  37 ++
 arch/powerpc/include/asm/vdso/getrandom.h          |  11 +-
 arch/powerpc/include/asm/vdso/gettimeofday.h       |  29 +-
 arch/powerpc/include/asm/vdso/vsyscall.h           |  13 -
 arch/powerpc/include/asm/vdso_datapage.h           |  44 +-
 arch/powerpc/kernel/asm-offsets.c                  |   1 -
 arch/powerpc/kernel/time.c                         |   2 +-
 arch/powerpc/kernel/vdso.c                         | 115 +----
 arch/powerpc/kernel/vdso/Makefile                  |   2 +-
 arch/powerpc/kernel/vdso/cacheflush.S              |   2 +-
 arch/powerpc/kernel/vdso/datapage.S                |   4 +-
 arch/powerpc/kernel/vdso/gettimeofday.S            |   4 +-
 arch/powerpc/kernel/vdso/vdso32.lds.S              |   4 +-
 arch/powerpc/kernel/vdso/vdso64.lds.S              |   4 +-
 arch/powerpc/kernel/vdso/vgettimeofday.c           |  14 +-
 arch/riscv/Kconfig                                 |   3 +-
 arch/riscv/include/asm/vdso.h                      |   2 +-
 .../include/asm/vdso/{time_data.h =3D> arch_data.h}  |   8 +-
 arch/riscv/include/asm/vdso/gettimeofday.h         |  14 +-
 arch/riscv/include/asm/vdso/vsyscall.h             |   9 -
 arch/riscv/kernel/sys_hwprobe.c                    |   3 +-
 arch/riscv/kernel/vdso.c                           |  90 +---
 arch/riscv/kernel/vdso/Makefile                    |   2 +-
 arch/riscv/kernel/vdso/hwprobe.c                   |   6 +-
 arch/riscv/kernel/vdso/vdso.lds.S                  |   7 +-
 arch/s390/Kconfig                                  |   1 +
 arch/s390/include/asm/vdso.h                       |   4 +-
 arch/s390/include/asm/vdso/getrandom.h             |  12 -
 arch/s390/include/asm/vdso/gettimeofday.h          |  15 +-
 arch/s390/include/asm/vdso/vsyscall.h              |  20 -
 arch/s390/kernel/time.c                            |  11 +-
 arch/s390/kernel/vdso.c                            |  97 +---
 arch/s390/kernel/vdso32/Makefile                   |   2 +-
 arch/s390/kernel/vdso32/vdso32.lds.S               |   7 +-
 arch/s390/kernel/vdso64/Makefile                   |   2 +-
 arch/s390/kernel/vdso64/vdso64.lds.S               |   8 +-
 arch/sparc/vdso/Makefile                           |   7 +-
 arch/sparc/vdso/checkundef.sh                      |  10 -
 arch/x86/Kconfig                                   |   1 +
 arch/x86/entry/vdso/Makefile                       |   9 +-
 arch/x86/entry/vdso/checkundef.sh                  |  10 -
 arch/x86/entry/vdso/vdso-layout.lds.S              |  10 +-
 arch/x86/entry/vdso/vdso2c.c                       |  21 -
 arch/x86/entry/vdso/vdso2c.h                       |  20 -
 arch/x86/entry/vdso/vma.c                          | 125 +----
 arch/x86/include/asm/vdso.h                        |   6 -
 arch/x86/include/asm/vdso/getrandom.h              |  10 -
 arch/x86/include/asm/vdso/gettimeofday.h           |  37 +-
 arch/x86/include/asm/vdso/vsyscall.h               |  23 +-
 drivers/char/random.c                              |   6 +-
 include/asm-generic/vdso/vsyscall.h                |  27 +-
 include/linux/align.h                              |  10 +-
 include/linux/cache.h                              |   9 +-
 include/linux/time_namespace.h                     |   2 -
 include/linux/vdso_datastore.h                     |  10 +
 include/uapi/linux/elf.h                           |  38 ++
 include/vdso/align.h                               |  15 +
 include/vdso/cache.h                               |  15 +
 include/vdso/datapage.h                            | 120 +++--
 include/vdso/helpers.h                             |  24 +-
 kernel/time/namespace.c                            |  24 +-
 kernel/time/vsyscall.c                             |  66 +--
 lib/Makefile                                       |   2 +-
 lib/vdso/Kconfig                                   |   5 +
 lib/vdso/Makefile                                  |  19 +-
 lib/vdso/Makefile.include                          |  18 +
 lib/vdso/datastore.c                               | 129 +++++
 lib/vdso/getrandom.c                               |   8 +-
 lib/vdso/gettimeofday.c                            | 196 ++++----
 tools/include/nolibc/Makefile                      |   1 +
 tools/include/nolibc/limits.h                      |   7 +
 tools/include/uapi/linux/elf.h                     | 524 +++++++++++++++++++=
++
 tools/testing/selftests/lib.mk                     |   5 +-
 tools/testing/selftests/vDSO/Makefile              |  11 +-
 tools/testing/selftests/vDSO/parse_vdso.c          |  19 +-
 tools/testing/selftests/vDSO/parse_vdso.h          |   1 -
 .../selftests/vDSO/vdso_standalone_test_x86.c      | 150 ++----
 .../selftests/vDSO/vdso_test_gettimeofday.c        |   4 +-
 125 files changed, 1397 insertions(+), 1573 deletions(-)
 create mode 100644 arch/loongarch/include/asm/vdso/arch_data.h
 create mode 100644 arch/powerpc/include/asm/vdso/arch_data.h
 rename arch/riscv/include/asm/vdso/{time_data.h =3D> arch_data.h} (71%)
 delete mode 100644 arch/sparc/vdso/checkundef.sh
 delete mode 100755 arch/x86/entry/vdso/checkundef.sh
 create mode 100644 include/linux/vdso_datastore.h
 create mode 100644 include/vdso/align.h
 create mode 100644 include/vdso/cache.h
 create mode 100644 lib/vdso/Makefile.include
 create mode 100644 lib/vdso/datastore.c
 create mode 100644 tools/include/nolibc/limits.h
 create mode 100644 tools/include/uapi/linux/elf.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..74c6399529c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9777,6 +9777,7 @@ F:	include/asm-generic/vdso/vsyscall.h
 F:	include/vdso/
 F:	kernel/time/vsyscall.c
 F:	lib/vdso/
+F:	tools/testing/selftests/vDSO/
=20
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
diff --git a/arch/Kconfig b/arch/Kconfig
index b8a4ff365582..9f6eb09ef12d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1584,6 +1584,10 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
=20
+config ARCH_HAS_VDSO_ARCH_DATA
+	depends on GENERIC_VDSO_DATA_STORE
+	bool
+
 config ARCH_HAS_VDSO_TIME_DATA
 	bool
=20
diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index 5b85889f82ee..88364a6727ff 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -4,6 +4,8 @@
=20
 #ifdef __KERNEL__
=20
+#define __VDSO_PAGES	4
+
 #ifndef __ASSEMBLY__
=20
 struct mm_struct;
diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/=
vdso/gettimeofday.h
index 592d3d015ca7..1e9f81639c88 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -112,7 +112,7 @@ static inline bool arm_vdso_hres_capable(void)
 #define __arch_vdso_hres_capable arm_vdso_hres_capable
=20
 static __always_inline u64 __arch_get_hw_counter(int clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 #ifdef CONFIG_ARM_ARCH_TIMER
 	u64 cycle_now;
@@ -135,11 +135,6 @@ static __always_inline u64 __arch_get_hw_counter(int clo=
ck_mode,
 #endif
 }
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso=
/vsyscall.h
index 705414710dcd..4e7226ad02ec 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -7,22 +7,14 @@
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
=20
-extern struct vdso_data *vdso_data;
 extern bool cntvct_ok;
=20
 static __always_inline
-struct vdso_data *__arm_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __arm_get_k_vdso_data
-
-static __always_inline
-void __arm_sync_vdso_data(struct vdso_data *vdata)
+void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 {
 	flush_dcache_page(virt_to_page(vdata));
 }
-#define __arch_sync_vdso_data __arm_sync_vdso_data
+#define __arch_sync_vdso_time_data __arch_sync_vdso_time_data
=20
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 4853875740d0..123f4a8ef446 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -153,10 +153,6 @@ int main(void)
   DEFINE(CACHE_WRITEBACK_ORDER, __CACHE_WRITEBACK_ORDER);
   DEFINE(CACHE_WRITEBACK_GRANULE, __CACHE_WRITEBACK_GRANULE);
   BLANK();
-#ifdef CONFIG_VDSO
-  DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
-#endif
-  BLANK();
 #ifdef CONFIG_ARM_MPU
   DEFINE(MPU_RNG_INFO_RNGS,	offsetof(struct mpu_rgn_info, rgns));
   DEFINE(MPU_RNG_INFO_USED,	offsetof(struct mpu_rgn_info, used));
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 29dd2f3c62fe..325448ffbba0 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -7,6 +7,7 @@
  */
=20
 #include <linux/cache.h>
+#include <linux/vdso_datastore.h>
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -33,15 +34,6 @@ extern char vdso_start[], vdso_end[];
 /* Total number of pages needed for the data and text portions of the VDSO. =
*/
 unsigned int vdso_total_pages __ro_after_init;
=20
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
-
-static struct page *vdso_data_page __ro_after_init;
-static const struct vm_special_mapping vdso_data_mapping =3D {
-	.name =3D "[vvar]",
-	.pages =3D &vdso_data_page,
-};
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
@@ -192,9 +184,6 @@ static int __init vdso_init(void)
 	if (vdso_text_pagelist =3D=3D NULL)
 		return -ENOMEM;
=20
-	/* Grab the VDSO data page. */
-	vdso_data_page =3D virt_to_page(vdso_data);
-
 	/* Grab the VDSO text pages. */
 	for (i =3D 0; i < text_pages; i++) {
 		struct page *page;
@@ -205,7 +194,7 @@ static int __init vdso_init(void)
=20
 	vdso_text_mapping.pages =3D vdso_text_pagelist;
=20
-	vdso_total_pages =3D 1; /* for the data/vvar page */
+	vdso_total_pages =3D VDSO_NR_PAGES; /* for the data/vvar pages */
 	vdso_total_pages +=3D text_pages;
=20
 	cntvct_ok =3D cntvct_functional();
@@ -216,16 +205,7 @@ static int __init vdso_init(void)
 }
 arch_initcall(vdso_init);
=20
-static int install_vvar(struct mm_struct *mm, unsigned long addr)
-{
-	struct vm_area_struct *vma;
-
-	vma =3D _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ | VM_MAYREAD,
-				       &vdso_data_mapping);
-
-	return PTR_ERR_OR_ZERO(vma);
-}
+static_assert(__VDSO_PAGES =3D=3D VDSO_NR_PAGES);
=20
 /* assumes mmap_lock is write-locked */
 void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
@@ -238,12 +218,12 @@ void arm_install_vdso(struct mm_struct *mm, unsigned lo=
ng addr)
 	if (vdso_text_pagelist =3D=3D NULL)
 		return;
=20
-	if (install_vvar(mm, addr))
+	if (IS_ERR(vdso_install_vvar_mapping(mm, addr)))
 		return;
=20
-	/* Account for vvar page. */
-	addr +=3D PAGE_SIZE;
-	len =3D (vdso_total_pages - 1) << PAGE_SHIFT;
+	/* Account for vvar pages. */
+	addr +=3D VDSO_NR_PAGES * PAGE_SIZE;
+	len =3D (vdso_total_pages - VDSO_NR_PAGES) << PAGE_SHIFT;
=20
 	vma =3D _install_special_mapping(mm, addr, len,
 		VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 2b6f50dd5478..5c1023a6d78c 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -928,6 +928,7 @@ config VDSO
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 8a306bbec4a0..cb044bfd145d 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 hostprogs :=3D vdsomunge
=20
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 9bfa0f52923c..7c08371f4400 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -11,16 +11,16 @@
  */
=20
 #include <linux/const.h>
-#include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - VDSO_DATA_SIZE);
+	VDSO_VVAR_SYMS
=20
 	. =3D SIZEOF_HEADERS;
=20
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca8..3770b73f270b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,6 +162,7 @@ config ARM64
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 06a4670bdb0b..99cd6546e72e 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -35,7 +35,7 @@
 #define ARCH_DMA_MINALIGN	(128)
 #define ARCH_KMALLOC_MINALIGN	(8)
=20
-#ifndef __ASSEMBLY__
+#if !defined(__ASSEMBLY__) && !defined(BUILD_VDSO)
=20
 #include <linux/bitops.h>
 #include <linux/kasan-enabled.h>
@@ -118,6 +118,6 @@ static inline u32 __attribute_const__ read_cpuid_effectiv=
e_cachetype(void)
 	return ctr;
 }
=20
-#endif	/* __ASSEMBLY__ */
+#endif /* !defined(__ASSEMBLY__) && !defined(BUILD_VDSO) */
=20
 #endif
diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 3e3c3fdb1842..61679070f595 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_H
 #define __ASM_VDSO_H
=20
-#define __VVAR_PAGES    2
+#define __VDSO_PAGES    4
=20
 #ifndef __ASSEMBLY__
=20
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/i=
nclude/asm/vdso/compat_gettimeofday.h
index 778c1202bbbf..d60ea7a72a9c 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -104,7 +104,7 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_=
timespec32 *_ts)
 }
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	u64 res;
=20
@@ -131,45 +131,33 @@ static __always_inline u64 __arch_get_hw_counter(s32 cl=
ock_mode,
 	return res;
 }
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
 {
-	const struct vdso_data *ret;
+	const struct vdso_time_data *ret;
=20
 	/*
-	 * This simply puts &_vdso_data into ret. The reason why we don't use
-	 * `ret =3D _vdso_data` is that the compiler tends to optimise this in a
-	 * very suboptimal way: instead of keeping &_vdso_data in a register,
-	 * it goes through a relocation almost every time _vdso_data must be
+	 * This simply puts &_vdso_time_data into ret. The reason why we don't use
+	 * `ret =3D _vdso_time_data` is that the compiler tends to optimise this in=
 a
+	 * very suboptimal way: instead of keeping &_vdso_time_data in a register,
+	 * it goes through a relocation almost every time _vdso_time_data must be
 	 * accessed (even in subfunctions). This is both time and space
 	 * consuming: each relocation uses a word in the code section, and it
 	 * has to be loaded at runtime.
 	 *
 	 * This trick hides the assignment from the compiler. Since it cannot
 	 * track where the pointer comes from, it will only use one relocation
-	 * where __arch_get_vdso_data() is called, and then keep the result in
-	 * a register.
+	 * where __aarch64_get_vdso_u_time_data() is called, and then keep the
+	 * result in a register.
 	 */
-	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(_vdso_data));
+	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(&vdso_u_time_data));
=20
 	return ret;
 }
+#define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
=20
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	const struct vdso_data *ret;
-
-	/* See __arch_get_vdso_data(). */
-	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(_timens_data));
-
-	return ret;
-}
-#endif
-
-static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 {
-	return vd->clock_mode =3D=3D VDSO_CLOCKMODE_ARCHTIMER;
+	return vc->clock_mode =3D=3D VDSO_CLOCKMODE_ARCHTIMER;
 }
 #define vdso_clocksource_ok	vdso_clocksource_ok
=20
diff --git a/arch/arm64/include/asm/vdso/getrandom.h b/arch/arm64/include/asm=
/vdso/getrandom.h
index 342f807e2044..a2197da1951b 100644
--- a/arch/arm64/include/asm/vdso/getrandom.h
+++ b/arch/arm64/include/asm/vdso/getrandom.h
@@ -33,18 +33,6 @@ static __always_inline ssize_t getrandom_syscall(void *_bu=
ffer, size_t _len, uns
 	return ret;
 }
=20
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
-{
-	/*
-	 * The RNG data is in the real VVAR data page, but if a task belongs to a t=
ime namespace
-	 * then VVAR_DATA_PAGE_OFFSET points to the namespace-specific VVAR page an=
d VVAR_TIMENS_
-	 * PAGE_OFFSET points to the real VVAR page.
-	 */
-	if (IS_ENABLED(CONFIG_TIME_NS) && _vdso_data->clock_mode =3D=3D VDSO_CLOCKM=
ODE_TIMENS)
-		return (void *)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * (1UL << CONFIG_=
PAGE_SHIFT);
-	return &_vdso_rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/=
asm/vdso/gettimeofday.h
index 764d13e2916c..92a2b59a9f3d 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -67,7 +67,7 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel=
_timespec *_ts)
 }
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	u64 res;
=20
@@ -99,20 +99,6 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock=
_mode,
 	return res;
 }
=20
-static __always_inline
-const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return _timens_data;
-}
-#endif
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/=
vdso/vsyscall.h
index eea51946d45a..de58951b8df6 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -2,44 +2,21 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
-#define __VDSO_RND_DATA_OFFSET  480
-
 #ifndef __ASSEMBLY__
=20
 #include <vdso/datapage.h>
=20
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
 #define VDSO_PRECISION_MASK	~(0xFF00ULL<<48)
=20
-extern struct vdso_data *vdso_data;
=20
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
 static __always_inline
-struct vdso_data *__arm64_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __arm64_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
-{
-	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
-}
-#define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
-
-static __always_inline
-void __arm64_update_vsyscall(struct vdso_data *vdata)
+void __arm64_update_vsyscall(struct vdso_time_data *vdata)
 {
-	vdata[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
-	vdata[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
+	vdata->clock_data[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
+	vdata->clock_data[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
 }
 #define __arch_update_vsyscall __arm64_update_vsyscall
=20
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8ed8e5b713b..887ac0b05961 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -18,7 +18,7 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <linux/vmalloc.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
@@ -57,12 +57,6 @@ static struct vdso_abi_info vdso_info[] __ro_after_init =
=3D {
 #endif /* CONFIG_COMPAT_VDSO */
 };
=20
-/*
- * The vDSO data page.
- */
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
@@ -104,78 +98,6 @@ static int __init __vdso_init(enum vdso_abi abi)
 	return 0;
 }
=20
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-static const struct vm_special_mapping vvar_map;
-
-/*
- * The vvar mapping contains data for a specific time namespace, so when a t=
ask
- * changes namespace we must unmap its vvar data for the old namespace.
- * Subsequent faults will map in data for the new namespace.
- *
- * For more details see timens_setup_vdso_data().
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vvar_map))
-			zap_vma_pages(vma);
-	}
-
-	mmap_read_unlock(mm);
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	struct page *timens_page =3D find_timens_vvar_page(vma);
-	unsigned long pfn;
-
-	switch (vmf->pgoff) {
-	case VVAR_DATA_PAGE_OFFSET:
-		if (timens_page)
-			pfn =3D page_to_pfn(timens_page);
-		else
-			pfn =3D sym_to_pfn(vdso_data);
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
-		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		pfn =3D sym_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
-static const struct vm_special_mapping vvar_map =3D {
-	.name   =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
-
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -185,11 +107,11 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	unsigned long gp_flags =3D 0;
 	void *ret;
=20
-	BUILD_BUG_ON(VVAR_NR_PAGES !=3D __VVAR_PAGES);
+	BUILD_BUG_ON(VDSO_NR_PAGES !=3D __VDSO_PAGES);
=20
 	vdso_text_len =3D vdso_info[abi].vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
-	vdso_mapping_len =3D vdso_text_len + VVAR_NR_PAGES * PAGE_SIZE;
+	vdso_mapping_len =3D vdso_text_len + VDSO_NR_PAGES * PAGE_SIZE;
=20
 	vdso_base =3D get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
@@ -197,16 +119,14 @@ static int __setup_additional_pages(enum vdso_abi abi,
 		goto up_fail;
 	}
=20
-	ret =3D _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_PFNMAP,
-				       &vvar_map);
+	ret =3D vdso_install_vvar_mapping(mm, vdso_base);
 	if (IS_ERR(ret))
 		goto up_fail;
=20
 	if (system_supports_bti_kernel())
 		gp_flags =3D VM_ARM64_BTI;
=20
-	vdso_base +=3D VVAR_NR_PAGES * PAGE_SIZE;
+	vdso_base +=3D VDSO_NR_PAGES * PAGE_SIZE;
 	mm->context.vdso =3D (void *)vdso_base;
 	ret =3D _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 35685c036044..5e27e46aa496 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -7,7 +7,7 @@
 #
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 obj-vdso :=3D vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-cha=
cha.o
=20
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.=
lds.S
index 4ec32e86a8da..2e20d0593f18 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -20,11 +20,8 @@ OUTPUT_ARCH(aarch64)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-	PROVIDE(_vdso_rng_data =3D _vdso_data + __VDSO_RND_DATA_OFFSET);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Mak=
efile
index 25a2cb6317f3..f2dfdc7dc818 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -3,7 +3,7 @@
 # Makefile for vdso32
 #
=20
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 # Same as cc-*option, but using CC_COMPAT instead of CC
 ifeq ($(CONFIG_CC_IS_CLANG), y)
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/v=
dso.lds.S
index 732702a187e9..e02b27487ce8 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -12,16 +12,15 @@
 #include <asm/page.h>
 #include <asm/vdso.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
=20
 SECTIONS
 {
-	PROVIDE_HIDDEN(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE_HIDDEN(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index 069ef0b17fe5..a3042287a070 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 # Symbols present in the vdso
 vdso-syms  +=3D rt_sigreturn
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2b8bd27a852f..d7ddf2a43e63 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -30,6 +30,7 @@ config LOONGARCH
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
@@ -106,6 +107,7 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAS_IOPORT
diff --git a/arch/loongarch/include/asm/vdso.h b/arch/loongarch/include/asm/v=
dso.h
index d3ba35eb23e7..f72ec79e2dde 100644
--- a/arch/loongarch/include/asm/vdso.h
+++ b/arch/loongarch/include/asm/vdso.h
@@ -31,7 +31,6 @@ struct loongarch_vdso_info {
 	unsigned long size;
 	unsigned long offset_sigreturn;
 	struct vm_special_mapping code_mapping;
-	struct vm_special_mapping data_mapping;
 };
=20
 extern struct loongarch_vdso_info vdso_info;
diff --git a/arch/loongarch/include/asm/vdso/arch_data.h b/arch/loongarch/inc=
lude/asm/vdso/arch_data.h
new file mode 100644
index 000000000000..322d0a5f1c84
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/arch_data.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef _VDSO_ARCH_DATA_H
+#define _VDSO_ARCH_DATA_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/asm.h>
+#include <asm/vdso.h>
+
+struct vdso_pcpu_data {
+	u32 node;
+} ____cacheline_aligned_in_smp;
+
+struct vdso_arch_data {
+	struct vdso_pcpu_data pdata[NR_CPUS];
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch/inc=
lude/asm/vdso/getrandom.h
index e80f3c4ac748..48c43f55b039 100644
--- a/arch/loongarch/include/asm/vdso/getrandom.h
+++ b/arch/loongarch/include/asm/vdso/getrandom.h
@@ -28,11 +28,6 @@ static __always_inline ssize_t getrandom_syscall(void *_bu=
ffer, size_t _len, uns
 	return ret;
 }
=20
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
-{
-	return &_loongarch_data.rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/=
include/asm/vdso/gettimeofday.h
index 7eb3f041af76..88cfcf133116 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -72,7 +72,7 @@ static __always_inline int clock_getres_fallback(
 }
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	uint64_t count;
=20
@@ -89,18 +89,6 @@ static inline bool loongarch_vdso_hres_capable(void)
 }
 #define __arch_vdso_hres_capable loongarch_vdso_hres_capable
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return _timens_data;
-}
-#endif
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/=
asm/vdso/vdso.h
index 1c183a9b2115..50c65fb29daf 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -12,43 +12,9 @@
 #include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
-struct vdso_pcpu_data {
-	u32 node;
-} ____cacheline_aligned_in_smp;
-
-struct loongarch_vdso_data {
-	struct vdso_pcpu_data pdata[NR_CPUS];
-	struct vdso_rng_data rng_data;
-};
-
-/*
- * The layout of vvar:
- *
- *                      high
- * +---------------------+--------------------------+
- * | loongarch vdso data | LOONGARCH_VDSO_DATA_SIZE |
- * +---------------------+--------------------------+
- * |  time-ns vdso data  |        PAGE_SIZE         |
- * +---------------------+--------------------------+
- * |  generic vdso data  |        PAGE_SIZE         |
- * +---------------------+--------------------------+
- *                      low
- */
-#define LOONGARCH_VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct loongarch_vdso_dat=
a))
-#define LOONGARCH_VDSO_DATA_PAGES (LOONGARCH_VDSO_DATA_SIZE >> PAGE_SHIFT)
-
-enum vvar_pages {
-	VVAR_GENERIC_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_LOONGARCH_PAGES_START,
-	VVAR_LOONGARCH_PAGES_END =3D VVAR_LOONGARCH_PAGES_START + LOONGARCH_VDSO_DA=
TA_PAGES - 1,
-	VVAR_NR_PAGES,
-};
-
-#define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
-
-extern struct loongarch_vdso_data _loongarch_data __attribute__((visibility(=
"hidden")));
+#define VVAR_SIZE (VDSO_NR_PAGES << PAGE_SHIFT)
=20
 #endif /* __ASSEMBLY__ */
=20
diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/incl=
ude/asm/vdso/vsyscall.h
index 8987e951d0a9..1140b54b4bc8 100644
--- a/arch/loongarch/include/asm/vdso/vsyscall.h
+++ b/arch/loongarch/include/asm/vdso/vsyscall.h
@@ -6,23 +6,6 @@
=20
 #include <vdso/datapage.h>
=20
-extern struct vdso_data *vdso_data;
-extern struct vdso_rng_data *vdso_rng_data;
-
-static __always_inline
-struct vdso_data *__loongarch_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __loongarch_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__loongarch_get_k_vdso_rng_data(void)
-{
-	return vdso_rng_data;
-}
-#define __arch_get_k_vdso_rng_data __loongarch_get_k_vdso_rng_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-=
offsets.c
index 8be1c38ad8eb..6f1524bba957 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -315,6 +315,6 @@ static void __used output_vdso_defines(void)
 {
 	COMMENT("LoongArch vDSO offsets.");
=20
-	DEFINE(__VVAR_PAGES, VVAR_NR_PAGES);
+	DEFINE(__VDSO_PAGES, VDSO_NR_PAGES);
 	BLANK();
 }
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 05e5fbac102a..10cf1608c7b3 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -14,7 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
=20
 #include <asm/page.h>
 #include <asm/vdso.h>
@@ -25,18 +25,6 @@
=20
 extern char vdso_start[], vdso_end[];
=20
-/* Kernel-provided data used by the VDSO. */
-static union vdso_data_store generic_vdso_data __page_aligned_data;
-
-static union {
-	u8 page[LOONGARCH_VDSO_DATA_SIZE];
-	struct loongarch_vdso_data vdata;
-} loongarch_vdso_data __page_aligned_data;
-
-struct vdso_data *vdso_data =3D generic_vdso_data.data;
-struct vdso_pcpu_data *vdso_pdata =3D loongarch_vdso_data.vdata.pdata;
-struct vdso_rng_data *vdso_rng_data =3D &loongarch_vdso_data.vdata.rng_data;
-
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_s=
truct *new_vma)
 {
 	current->mm->context.vdso =3D (void *)(new_vma->vm_start);
@@ -44,53 +32,12 @@ static int vdso_mremap(const struct vm_special_mapping *s=
m, struct vm_area_struc
 	return 0;
 }
=20
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	unsigned long pfn;
-	struct page *timens_page =3D find_timens_vvar_page(vma);
-
-	switch (vmf->pgoff) {
-	case VVAR_GENERIC_PAGE_OFFSET:
-		if (!timens_page)
-			pfn =3D sym_to_pfn(vdso_data);
-		else
-			pfn =3D page_to_pfn(timens_page);
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace specific
-		 * VVAR is mapped with the VVAR_GENERIC_PAGE_OFFSET and the real
-		 * VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		else
-			pfn =3D sym_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	case VVAR_LOONGARCH_PAGES_START ... VVAR_LOONGARCH_PAGES_END:
-		pfn =3D sym_to_pfn(&loongarch_vdso_data) + vmf->pgoff - VVAR_LOONGARCH_PAG=
ES_START;
-		break;
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
 struct loongarch_vdso_info vdso_info =3D {
 	.vdso =3D vdso_start,
 	.code_mapping =3D {
 		.name =3D "[vdso]",
 		.mremap =3D vdso_mremap,
 	},
-	.data_mapping =3D {
-		.name =3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
 	.offset_sigreturn =3D vdso_offset_sigreturn,
 };
=20
@@ -101,7 +48,7 @@ static int __init init_vdso(void)
 	BUG_ON(!PAGE_ALIGNED(vdso_info.vdso));
=20
 	for_each_possible_cpu(cpu)
-		vdso_pdata[cpu].node =3D cpu_to_node(cpu);
+		vdso_k_arch_data->pdata[cpu].node =3D cpu_to_node(cpu);
=20
 	vdso_info.size =3D PAGE_ALIGN(vdso_end - vdso_start);
 	vdso_info.code_mapping.pages =3D
@@ -115,37 +62,6 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
=20
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-/*
- * The vvar mapping contains data for a specific time namespace, so when a
- * task changes namespace we must unmap its vvar data for the old namespace.
- * Subsequent faults will map in data for the new namespace.
- *
- * For more details see timens_setup_vdso_data().
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	struct vm_area_struct *vma;
-
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vdso_info.data_mapping))
-			zap_vma_pages(vma);
-	}
-	mmap_read_unlock(mm);
-
-	return 0;
-}
-#endif
-
 static unsigned long vdso_base(void)
 {
 	unsigned long base =3D STACK_TOP;
@@ -181,9 +97,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,=
 int uses_interp)
 		goto out;
 	}
=20
-	vma =3D _install_special_mapping(mm, data_addr, VVAR_SIZE,
-				       VM_READ | VM_MAYREAD | VM_PFNMAP,
-				       &info->data_mapping);
+	vma =3D vdso_install_vvar_mapping(mm, data_addr);
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		goto out;
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index fdde1bcd4e26..1c26147aff70 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -2,7 +2,7 @@
 # Objects to go into the VDSO.
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 obj-vdso-y :=3D elf.o vgetcpu.o vgettimeofday.o vgetrandom.o \
               vgetrandom-chacha.o sigreturn.o
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
index 160cfaef2de4..8ff986499947 100644
--- a/arch/loongarch/vdso/vdso.lds.S
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -5,6 +5,7 @@
  */
 #include <asm/page.h>
 #include <generated/asm-offsets.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf64-loongarch", "elf64-loongarch", "elf64-loongarch")
=20
@@ -12,11 +13,8 @@ OUTPUT_ARCH(loongarch)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
-	PROVIDE(_loongarch_data =3D _vdso_data + 2 * PAGE_SIZE);
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 0db51258b2a7..5301cd9d0f83 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -19,27 +19,19 @@ static __always_inline int read_cpu_id(void)
 	return cpu_id;
 }
=20
-static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
-{
-	return _loongarch_data.pdata;
-}
-
 extern
 int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache=
 *unused);
 int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache=
 *unused)
 {
 	int cpu_id;
-	const struct vdso_pcpu_data *data;
=20
 	cpu_id =3D read_cpu_id();
=20
 	if (cpu)
 		*cpu =3D cpu_id;
=20
-	if (node) {
-		data =3D get_pcpu_data();
-		*node =3D data[cpu_id].node;
-	}
+	if (node)
+		*node =3D vdso_u_arch_data.pdata[cpu_id].node;
=20
 	return 0;
 }
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1924f2d83932..b51168e319ea 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -51,6 +51,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
 	select HAVE_ARCH_COMPILER_H
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/as=
m/vdso/gettimeofday.h
index 44a45f3fa4b0..fd32baa30e17 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -167,7 +167,7 @@ static __always_inline u64 read_r4k_count(void)
=20
 #ifdef CONFIG_CLKSRC_MIPS_GIC
=20
-static __always_inline u64 read_gic_count(const struct vdso_data *data)
+static __always_inline u64 read_gic_count(const struct vdso_time_data *data)
 {
 	void __iomem *gic =3D get_gic(data);
 	u32 hi, hi2, lo;
@@ -184,7 +184,7 @@ static __always_inline u64 read_gic_count(const struct vd=
so_data *data)
 #endif
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 #ifdef CONFIG_CSRC_R4K
 	if (clock_mode =3D=3D VDSO_CLOCKMODE_R4K)
@@ -209,10 +209,11 @@ static inline bool mips_vdso_hres_capable(void)
 }
 #define __arch_vdso_hres_capable mips_vdso_hres_capable
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
 {
-	return get_vdso_data();
+	return get_vdso_time_data();
 }
+#define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
=20
 #endif /* !__ASSEMBLY__ */
=20
diff --git a/arch/mips/include/asm/vdso/vdso.h b/arch/mips/include/asm/vdso/v=
dso.h
index 6cd88191fefa..acd0efcd3d93 100644
--- a/arch/mips/include/asm/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -5,16 +5,18 @@
  */
=20
 #include <asm/sgidefs.h>
+#include <vdso/page.h>
+
+#define __VDSO_PAGES 4
=20
 #ifndef __ASSEMBLY__
=20
 #include <asm/asm.h>
-#include <asm/page.h>
 #include <asm/vdso.h>
=20
-static inline unsigned long get_vdso_base(void)
+static inline const struct vdso_time_data *get_vdso_time_data(void)
 {
-	unsigned long addr;
+	const struct vdso_time_data *addr;
=20
 	/*
 	 * We can't use cpu_has_mips_r6 since it needs the cpu_data[]
@@ -27,7 +29,7 @@ static inline unsigned long get_vdso_base(void)
 	 * We can't use addiupc because there is no label-label
 	 * support for the addiupc reloc
 	 */
-	__asm__("lapc	%0, _start			\n"
+	__asm__("lapc	%0, vdso_u_time_data		\n"
 		: "=3Dr" (addr) : :);
 #else
 	/*
@@ -46,7 +48,7 @@ static inline unsigned long get_vdso_base(void)
 	"	.set noreorder				\n"
 	"	bal	1f				\n"
 	"	 nop					\n"
-	"	.word	_start - .			\n"
+	"	.word	vdso_u_time_data - .		\n"
 	"1:	lw	%0, 0($31)			\n"
 	"	" STR(PTR_ADDU) " %0, $31, %0		\n"
 	"	.set pop				\n"
@@ -58,14 +60,9 @@ static inline unsigned long get_vdso_base(void)
 	return addr;
 }
=20
-static inline const struct vdso_data *get_vdso_data(void)
-{
-	return (const struct vdso_data *)(get_vdso_base() - PAGE_SIZE);
-}
-
 #ifdef CONFIG_CLKSRC_MIPS_GIC
=20
-static inline void __iomem *get_gic(const struct vdso_data *data)
+static inline void __iomem *get_gic(const struct vdso_time_data *data)
 {
 	return (void __iomem *)((unsigned long)data & PAGE_MASK) - PAGE_SIZE;
 }
diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vd=
so/vsyscall.h
index a4582870aaea..2b1debb62dee 100644
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -2,22 +2,12 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
+#include <asm/page.h>
+
 #ifndef __ASSEMBLY__
=20
 #include <vdso/datapage.h>
=20
-extern struct vdso_data *vdso_data;
-
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-static __always_inline
-struct vdso_data *__mips_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __mips_get_k_vdso_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 75c9d3618f58..de096777172f 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -15,6 +15,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/vdso_datastore.h>
=20
 #include <asm/abi.h>
 #include <asm/mips-cps.h>
@@ -23,20 +24,7 @@
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
=20
-/* Kernel-provided data used by the VDSO. */
-static union vdso_data_store mips_vdso_data __page_aligned_data;
-struct vdso_data *vdso_data =3D mips_vdso_data.data;
-
-/*
- * Mapping for the VDSO data/GIC pages. The real pages are mapped manually, =
as
- * what we map and where within the area they are mapped is determined at
- * runtime.
- */
-static struct page *no_pages[] =3D { NULL };
-static struct vm_special_mapping vdso_vvar_mapping =3D {
-	.name =3D "[vvar]",
-	.pages =3D no_pages,
-};
+static_assert(VDSO_NR_PAGES =3D=3D __VDSO_PAGES);
=20
 static void __init init_vdso_image(struct mips_vdso_image *image)
 {
@@ -90,7 +78,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, =
int uses_interp)
 {
 	struct mips_vdso_image *image =3D current->thread.abi->vdso;
 	struct mm_struct *mm =3D current->mm;
-	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pf=
n, gic_base;
+	unsigned long gic_size, size, base, data_addr, vdso_addr, gic_pfn, gic_base;
 	struct vm_area_struct *vma;
 	int ret;
=20
@@ -119,8 +107,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm=
, int uses_interp)
 	 * the counter registers at the start.
 	 */
 	gic_size =3D mips_gic_present() ? PAGE_SIZE : 0;
-	vvar_size =3D gic_size + PAGE_SIZE;
-	size =3D vvar_size + image->size;
+	size =3D gic_size + VDSO_NR_PAGES * PAGE_SIZE + image->size;
=20
 	/*
 	 * Find a region that's large enough for us to perform the
@@ -143,15 +130,13 @@ int arch_setup_additional_pages(struct linux_binprm *bp=
rm, int uses_interp)
 	 */
 	if (cpu_has_dc_aliases) {
 		base =3D __ALIGN_MASK(base, shm_align_mask);
-		base +=3D ((unsigned long)vdso_data - gic_size) & shm_align_mask;
+		base +=3D ((unsigned long)vdso_k_time_data - gic_size) & shm_align_mask;
 	}
=20
 	data_addr =3D base + gic_size;
-	vdso_addr =3D data_addr + PAGE_SIZE;
+	vdso_addr =3D data_addr + VDSO_NR_PAGES * PAGE_SIZE;
=20
-	vma =3D _install_special_mapping(mm, base, vvar_size,
-				       VM_READ | VM_MAYREAD,
-				       &vdso_vvar_mapping);
+	vma =3D vdso_install_vvar_mapping(mm, data_addr);
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		goto out;
@@ -161,6 +146,17 @@ int arch_setup_additional_pages(struct linux_binprm *bpr=
m, int uses_interp)
 	if (gic_size) {
 		gic_base =3D (unsigned long)mips_gic_base + MIPS_GIC_USER_OFS;
 		gic_pfn =3D PFN_DOWN(__pa(gic_base));
+		static const struct vm_special_mapping gic_mapping =3D {
+			.name	=3D "[gic]",
+			.pages	=3D (struct page **) { NULL },
+		};
+
+		vma =3D _install_special_mapping(mm, base, gic_size, VM_READ | VM_MAYREAD,
+					       &gic_mapping);
+		if (IS_ERR(vma)) {
+			ret =3D PTR_ERR(vma);
+			goto out;
+		}
=20
 		ret =3D io_remap_pfn_range(vma, base, gic_pfn, gic_size,
 					 pgprot_noncached(vma->vm_page_prot));
@@ -168,13 +164,6 @@ int arch_setup_additional_pages(struct linux_binprm *bpr=
m, int uses_interp)
 			goto out;
 	}
=20
-	/* Map data page. */
-	ret =3D remap_pfn_range(vma, data_addr,
-			      virt_to_phys(vdso_data) >> PAGE_SHIFT,
-			      PAGE_SIZE, vma->vm_page_prot);
-	if (ret)
-		goto out;
-
 	/* Map VDSO image. */
 	vma =3D _install_special_mapping(mm, vdso_addr, image->size,
 				       VM_READ | VM_EXEC |
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index b289b2c1b294..fb4c493aaffa 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -2,7 +2,7 @@
 # Objects to go into the VDSO.
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 obj-vdso-y :=3D elf.o vgettimeofday.o sigreturn.o
=20
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 836465e3bcb8..c8bbe56d89cb 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -5,6 +5,8 @@
  */
=20
 #include <asm/sgidefs.h>
+#include <asm/vdso/vdso.h>
+#include <vdso/datapage.h>
=20
 #if _MIPS_SIM =3D=3D _MIPS_SIM_ABI64
 OUTPUT_FORMAT("elf64-tradlittlemips", "elf64-tradbigmips", "elf64-tradlittle=
mips")
@@ -18,7 +20,8 @@ OUTPUT_ARCH(mips)
=20
 SECTIONS
 {
-	PROVIDE(_start =3D .);
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	/*
diff --git a/arch/parisc/include/asm/vdso.h b/arch/parisc/include/asm/vdso.h
index 2a2dc11b5545..5f581c1d6460 100644
--- a/arch/parisc/include/asm/vdso.h
+++ b/arch/parisc/include/asm/vdso.h
@@ -12,8 +12,6 @@
 #define VDSO64_SYMBOL(tsk, name) ((tsk)->mm->context.vdso_base + (vdso64_off=
set_##name))
 #define VDSO32_SYMBOL(tsk, name) ((tsk)->mm->context.vdso_base + (vdso32_off=
set_##name))
=20
-extern struct vdso_data *vdso_data;
-
 #endif /* __ASSEMBLY __ */
=20
 /* Default link addresses for the vDSOs */
diff --git a/arch/parisc/kernel/vdso32/Makefile b/arch/parisc/kernel/vdso32/M=
akefile
index 288f8b85978f..4ee8d17da229 100644
--- a/arch/parisc/kernel/vdso32/Makefile
+++ b/arch/parisc/kernel/vdso32/Makefile
@@ -1,5 +1,5 @@
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 KCOV_INSTRUMENT :=3D n
=20
diff --git a/arch/parisc/kernel/vdso64/Makefile b/arch/parisc/kernel/vdso64/M=
akefile
index bc5d9553f311..c63f4069170f 100644
--- a/arch/parisc/kernel/vdso64/Makefile
+++ b/arch/parisc/kernel/vdso64/Makefile
@@ -1,5 +1,5 @@
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 KCOV_INSTRUMENT :=3D n
=20
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 424f188e62d9..8a2a6e403eb1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -159,6 +159,7 @@ config PPC
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN
+	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_HAVE_EXTRA_ELF_NOTES        if SPU_BASE
 	select ARCH_KEEP_MEMBLOCK
@@ -209,6 +210,7 @@ config PPC
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index 8d972bc98b55..1ca23fbfe087 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_VDSO_H
=20
 #define VDSO_VERSION_STRING	LINUX_2.6.15
+#define __VDSO_PAGES		4
=20
 #ifndef __ASSEMBLY__
=20
diff --git a/arch/powerpc/include/asm/vdso/arch_data.h b/arch/powerpc/include=
/asm/vdso/arch_data.h
new file mode 100644
index 000000000000..c240a6b87518
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/arch_data.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2002 Peter Bergner <bergner@vnet.ibm.com>, IBM
+ * Copyright (C) 2005 Benjamin Herrenschmidy <benh@kernel.crashing.org>,
+ * 		      IBM Corp.
+ */
+#ifndef _ASM_POWERPC_VDSO_ARCH_DATA_H
+#define _ASM_POWERPC_VDSO_ARCH_DATA_H
+
+#include <linux/unistd.h>
+#include <linux/types.h>
+
+#define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
+
+#ifdef CONFIG_PPC64
+
+struct vdso_arch_data {
+	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
+	__u32 dcache_block_size;		/* L1 d-cache block size     */
+	__u32 icache_block_size;		/* L1 i-cache block size     */
+	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
+	__u32 icache_log_block_size;		/* L1 i-cache log block size */
+	__u32 syscall_map[SYSCALL_MAP_SIZE];	/* Map of syscalls  */
+	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
+};
+
+#else /* CONFIG_PPC64 */
+
+struct vdso_arch_data {
+	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
+	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
+	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
+};
+
+#endif /* CONFIG_PPC64 */
+
+#endif /* _ASM_POWERPC_VDSO_ARCH_DATA_H */
diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include=
/asm/vdso/getrandom.h
index 80ce0709725e..067a5396aac6 100644
--- a/arch/powerpc/include/asm/vdso/getrandom.h
+++ b/arch/powerpc/include/asm/vdso/getrandom.h
@@ -43,20 +43,21 @@ static __always_inline ssize_t getrandom_syscall(void *bu=
ffer, size_t len, unsig
 			    (unsigned long)len, (unsigned long)flags);
 }
=20
-static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_dat=
a(void)
 {
-	struct vdso_arch_data *data;
+	struct vdso_rng_data *data;
=20
 	asm (
 		"	bcl	20, 31, .+4 ;"
 		"0:	mflr	%0 ;"
-		"	addis	%0, %0, (_vdso_datapage - 0b)@ha ;"
-		"	addi	%0, %0, (_vdso_datapage - 0b)@l  ;"
+		"	addis	%0, %0, (vdso_u_rng_data - 0b)@ha ;"
+		"	addi	%0, %0, (vdso_u_rng_data - 0b)@l  ;"
 		: "=3Dr" (data) : : "lr"
 	);
=20
-	return &data->rng_data;
+	return data;
 }
+#define __arch_get_vdso_u_rng_data __arch_get_vdso_u_rng_data
=20
 ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, v=
oid *opaque_state,
 			     size_t opaque_len);
diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/incl=
ude/asm/vdso/gettimeofday.h
index c6390890a60c..99c9d6f43fde 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -94,22 +94,12 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_=
timespec32 *_ts)
 #endif
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	return get_tb();
 }
=20
-const struct vdso_data *__arch_get_vdso_data(void);
-
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
-}
-#endif
-
-static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 {
 	return true;
 }
@@ -135,21 +125,22 @@ static __always_inline u64 vdso_shift_ns(u64 ns, unsign=
ed long shift)
=20
 #ifdef __powerpc64__
 int __c_kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
-			     const struct vdso_data *vd);
+			     const struct vdso_time_data *vd);
 int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *re=
s,
-			    const struct vdso_data *vd);
+			    const struct vdso_time_data *vd);
 #else
 int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
-			     const struct vdso_data *vd);
+			     const struct vdso_time_data *vd);
 int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
-			       const struct vdso_data *vd);
+			       const struct vdso_time_data *vd);
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
-			    const struct vdso_data *vd);
+			    const struct vdso_time_data *vd);
 #endif
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone=
 *tz,
-			    const struct vdso_data *vd);
+			    const struct vdso_time_data *vd);
 __kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time,
-				    const struct vdso_data *vd);
+				    const struct vdso_time_data *vd);
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_POWERPC_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/=
asm/vdso/vsyscall.h
index 48560a119559..c2c9ae1b22e7 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -6,19 +6,6 @@
=20
 #include <asm/vdso_datapage.h>
=20
-static __always_inline
-struct vdso_data *__arch_get_k_vdso_data(void)
-{
-	return vdso_data->data;
-}
-#define __arch_get_k_vdso_data __arch_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__arch_get_k_vdso_rng_data(void)
-{
-	return &vdso_data->rng_data;
-}
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/=
asm/vdso_datapage.h
index a202f5b63479..95d45a50355d 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -11,56 +11,18 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/unistd.h>
-#include <linux/time.h>
 #include <vdso/datapage.h>
=20
-#define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
-
-#ifdef CONFIG_PPC64
-
-struct vdso_arch_data {
-	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
-	__u32 dcache_block_size;		/* L1 d-cache block size     */
-	__u32 icache_block_size;		/* L1 i-cache block size     */
-	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
-	__u32 icache_log_block_size;		/* L1 i-cache log block size */
-	__u32 syscall_map[SYSCALL_MAP_SIZE];	/* Map of syscalls  */
-	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
-
-	struct vdso_rng_data rng_data;
-
-	struct vdso_data data[CS_BASES] __aligned(1 << CONFIG_PAGE_SHIFT);
-};
-
-#else /* CONFIG_PPC64 */
-
-struct vdso_arch_data {
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
-	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
-	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
-	struct vdso_rng_data rng_data;
-
-	struct vdso_data data[CS_BASES] __aligned(1 << CONFIG_PAGE_SHIFT);
-};
-
-#endif /* CONFIG_PPC64 */
-
-extern struct vdso_arch_data *vdso_data;
-
 #else /* __ASSEMBLY__ */
=20
-.macro get_datapage ptr offset=3D0
+.macro get_datapage ptr symbol
 	bcl	20, 31, .+4
 999:
 	mflr	\ptr
-	addis	\ptr, \ptr, (_vdso_datapage - 999b + \offset)@ha
-	addi	\ptr, \ptr, (_vdso_datapage - 999b + \offset)@l
+	addis	\ptr, \ptr, (\symbol - 999b)@ha
+	addi	\ptr, \ptr, (\symbol - 999b)@l
 .endm
=20
-#include <asm/asm-offsets.h>
-#include <asm/page.h>
-
 #endif /* __ASSEMBLY__ */
=20
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offs=
ets.c
index 7a390bd4f4af..b3048f6d3822 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -334,7 +334,6 @@ int main(void)
 #endif /* ! CONFIG_PPC64 */
=20
 	/* datapage offsets for use by vdso */
-	OFFSET(VDSO_DATA_OFFSET, vdso_arch_data, data);
 	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_arch_data, tb_ticks_per_sec);
 #ifdef CONFIG_PPC64
 	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_arch_data, icache_block_size);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 0727332ad86f..15784c5c95c7 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -950,7 +950,7 @@ void __init time_init(void)
 		sys_tz.tz_dsttime =3D 0;
 	}
=20
-	vdso_data->tb_ticks_per_sec =3D tb_ticks_per_sec;
+	vdso_k_arch_data->tb_ticks_per_sec =3D tb_ticks_per_sec;
 #ifdef CONFIG_PPC64_PROC_SYSTEMCFG
 	systemcfg->tb_ticks_per_sec =3D tb_ticks_per_sec;
 #endif
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 43379365ce1b..219d67bcf747 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -17,7 +17,7 @@
 #include <linux/elf.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
=20
 #include <asm/syscall.h>
@@ -32,6 +32,8 @@
 #include <asm/vdso_datapage.h>
 #include <asm/setup.h>
=20
+static_assert(__VDSO_PAGES =3D=3D VDSO_NR_PAGES);
+
 /* The alignment of the vDSO */
 #define VDSO_ALIGNMENT	(1 << 16)
=20
@@ -40,24 +42,6 @@ extern char vdso64_start, vdso64_end;
=20
 long sys_ni_syscall(void);
=20
-/*
- * The vdso data page (aka. systemcfg for old ppc64 fans) is here.
- * Once the early boot kernel code no longer needs to muck around
- * with it, it will become dynamically allocated
- */
-static union {
-	struct vdso_arch_data	data;
-	u8			page[2 * PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
-struct vdso_arch_data *vdso_data =3D &vdso_data_store.data;
-
-enum vvar_pages {
-	VVAR_BASE_PAGE_OFFSET,
-	VVAR_TIME_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_s=
truct *new_vma,
 		       unsigned long text_size)
 {
@@ -96,14 +80,6 @@ static void vdso_close(const struct vm_special_mapping *sm=
, struct vm_area_struc
 	mm->context.vdso =3D NULL;
 }
=20
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf);
-
-static struct vm_special_mapping vvar_spec __ro_after_init =3D {
-	.name =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
-
 static struct vm_special_mapping vdso32_spec __ro_after_init =3D {
 	.name =3D "[vdso]",
 	.mremap =3D vdso32_mremap,
@@ -116,73 +92,6 @@ static struct vm_special_mapping vdso64_spec __ro_after_i=
nit =3D {
 	.close =3D vdso_close,
 };
=20
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return vvar_page;
-}
-
-/*
- * The vvar mapping contains data for a specific time namespace, so when a t=
ask
- * changes namespace we must unmap its vvar data for the old namespace.
- * Subsequent faults will map in data for the new namespace.
- *
- * For more details see timens_setup_vdso_data().
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	VMA_ITERATOR(vmi, mm, 0);
-	struct vm_area_struct *vma;
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vvar_spec))
-			zap_vma_pages(vma);
-	}
-	mmap_read_unlock(mm);
-
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	struct page *timens_page =3D find_timens_vvar_page(vma);
-	unsigned long pfn;
-
-	switch (vmf->pgoff) {
-	case VVAR_BASE_PAGE_OFFSET:
-		pfn =3D virt_to_pfn(vdso_data);
-		break;
-	case VVAR_TIME_PAGE_OFFSET:
-		if (timens_page)
-			pfn =3D page_to_pfn(timens_page);
-		else
-			pfn =3D virt_to_pfn(vdso_data->data);
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
-		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		pfn =3D virt_to_pfn(vdso_data->data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
 /*
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
@@ -191,7 +100,7 @@ static int __arch_setup_additional_pages(struct linux_bin=
prm *bprm, int uses_int
 {
 	unsigned long vdso_size, vdso_base, mappings_size;
 	struct vm_special_mapping *vdso_spec;
-	unsigned long vvar_size =3D VVAR_NR_PAGES * PAGE_SIZE;
+	unsigned long vvar_size =3D VDSO_NR_PAGES * PAGE_SIZE;
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
=20
@@ -217,9 +126,7 @@ static int __arch_setup_additional_pages(struct linux_bin=
prm *bprm, int uses_int
 	/* Add required alignment. */
 	vdso_base =3D ALIGN(vdso_base, VDSO_ALIGNMENT);
=20
-	vma =3D _install_special_mapping(mm, vdso_base, vvar_size,
-				       VM_READ | VM_MAYREAD | VM_IO |
-				       VM_DONTDUMP | VM_PFNMAP, &vvar_spec);
+	vma =3D vdso_install_vvar_mapping(mm, vdso_base);
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
=20
@@ -299,10 +206,10 @@ static void __init vdso_setup_syscall_map(void)
=20
 	for (i =3D 0; i < NR_syscalls; i++) {
 		if (sys_call_table[i] !=3D (void *)&sys_ni_syscall)
-			vdso_data->syscall_map[i >> 5] |=3D 0x80000000UL >> (i & 0x1f);
+			vdso_k_arch_data->syscall_map[i >> 5] |=3D 0x80000000UL >> (i & 0x1f);
 		if (IS_ENABLED(CONFIG_COMPAT) &&
 		    compat_sys_call_table[i] !=3D (void *)&sys_ni_syscall)
-			vdso_data->compat_syscall_map[i >> 5] |=3D 0x80000000UL >> (i & 0x1f);
+			vdso_k_arch_data->compat_syscall_map[i >> 5] |=3D 0x80000000UL >> (i & 0x=
1f);
 	}
 }
=20
@@ -352,10 +259,10 @@ static struct page ** __init vdso_setup_pages(void *sta=
rt, void *end)
 static int __init vdso_init(void)
 {
 #ifdef CONFIG_PPC64
-	vdso_data->dcache_block_size =3D ppc64_caches.l1d.block_size;
-	vdso_data->icache_block_size =3D ppc64_caches.l1i.block_size;
-	vdso_data->dcache_log_block_size =3D ppc64_caches.l1d.log_block_size;
-	vdso_data->icache_log_block_size =3D ppc64_caches.l1i.log_block_size;
+	vdso_k_arch_data->dcache_block_size =3D ppc64_caches.l1d.block_size;
+	vdso_k_arch_data->icache_block_size =3D ppc64_caches.l1i.block_size;
+	vdso_k_arch_data->dcache_log_block_size =3D ppc64_caches.l1d.log_block_size;
+	vdso_k_arch_data->icache_log_block_size =3D ppc64_caches.l1i.log_block_size;
 #endif /* CONFIG_PPC64 */
=20
 	vdso_setup_syscall_map();
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Mak=
efile
index 0e3ed6fb199f..e8824f933326 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -3,7 +3,7 @@
 # List of files in the vdso, has to be asm only for now
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 obj-vdso32 =3D sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32=
.o note-32.o getcpu-32.o
 obj-vdso64 =3D sigtramp64-64.o gettimeofday-64.o datapage-64.o cacheflush-64=
.o note-64.o getcpu-64.o
diff --git a/arch/powerpc/kernel/vdso/cacheflush.S b/arch/powerpc/kernel/vdso=
/cacheflush.S
index 0085ae464dac..488d3ade11e6 100644
--- a/arch/powerpc/kernel/vdso/cacheflush.S
+++ b/arch/powerpc/kernel/vdso/cacheflush.S
@@ -30,7 +30,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 #ifdef CONFIG_PPC64
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10
+	get_datapage	r10 vdso_u_arch_data
 	mtlr	r12
   .cfi_restore	lr
 #endif
diff --git a/arch/powerpc/kernel/vdso/datapage.S b/arch/powerpc/kernel/vdso/d=
atapage.S
index db8e167f0166..d23b2e8e2a34 100644
--- a/arch/powerpc/kernel/vdso/datapage.S
+++ b/arch/powerpc/kernel/vdso/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr.	r4,r3
-	get_datapage	r3
+	get_datapage	r3 vdso_u_arch_data
 	mtlr	r12
 #ifdef __powerpc64__
 	addi	r3,r3,CFG_SYSCALL_MAP64
@@ -52,7 +52,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3
+	get_datapage	r3 vdso_u_arch_data
 #ifndef __powerpc64__
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
 #endif
diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vd=
so/gettimeofday.S
index 5333848322ca..79c967212444 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -33,9 +33,9 @@
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
 	.ifeq	\call_time
-		get_datapage	r5 VDSO_DATA_OFFSET
+		get_datapage	r5 vdso_u_time_data
 	.else
-		get_datapage	r4 VDSO_DATA_OFFSET
+		get_datapage	r4 vdso_u_time_data
 	.endif
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso=
/vdso32.lds.S
index 1a1b0b6d681a..72a1012b8a20 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -6,6 +6,7 @@
 #include <asm/vdso.h>
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
=20
 #ifdef __LITTLE_ENDIAN__
 OUTPUT_FORMAT("elf32-powerpcle", "elf32-powerpcle", "elf32-powerpcle")
@@ -16,7 +17,8 @@ OUTPUT_ARCH(powerpc:common)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_datapage =3D . - 3 * PAGE_SIZE);
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash          	: { *(.hash) }			:text
diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso=
/vdso64.lds.S
index e21b5506cad6..32102a05eaa7 100644
--- a/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -6,6 +6,7 @@
 #include <asm/vdso.h>
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
=20
 #ifdef __LITTLE_ENDIAN__
 OUTPUT_FORMAT("elf64-powerpcle", "elf64-powerpcle", "elf64-powerpcle")
@@ -16,7 +17,8 @@ OUTPUT_ARCH(powerpc:common64)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_datapage =3D . - 3 * PAGE_SIZE);
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/powerpc/kernel/vdso/vgettimeofday.c b/arch/powerpc/kernel/v=
dso/vgettimeofday.c
index 55a287c9a736..6f5167d81af5 100644
--- a/arch/powerpc/kernel/vdso/vgettimeofday.c
+++ b/arch/powerpc/kernel/vdso/vgettimeofday.c
@@ -7,43 +7,43 @@
=20
 #ifdef __powerpc64__
 int __c_kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
-			     const struct vdso_data *vd)
+			     const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime_data(vd, clock, ts);
 }
=20
 int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *re=
s,
-			    const struct vdso_data *vd)
+			    const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_getres_data(vd, clock_id, res);
 }
 #else
 int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
-			     const struct vdso_data *vd)
+			     const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime32_data(vd, clock, ts);
 }
=20
 int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
-			       const struct vdso_data *vd)
+			       const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime_data(vd, clock, ts);
 }
=20
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
-			    const struct vdso_data *vd)
+			    const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_getres_time32_data(vd, clock_id, res);
 }
 #endif
=20
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone=
 *tz,
-			    const struct vdso_data *vd)
+			    const struct vdso_time_data *vd)
 {
 	return __cvdso_gettimeofday_data(vd, tv, tz);
 }
=20
-__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct =
vdso_data *vd)
+__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct =
vdso_time_data *vd)
 {
 	return __cvdso_time_data(vd, time);
 }
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..aa8ea53186c0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -53,7 +53,7 @@ config RISCV
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_TIME_DATA
+	select ARCH_HAS_VDSO_ARCH_DATA if GENERIC_VDSO_DATA_STORE
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -116,6 +116,7 @@ config RISCV
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
+	select GENERIC_VDSO_DATA_STORE if MMU
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index f891478829a5..c130d8100232 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -14,7 +14,7 @@
  */
 #ifdef CONFIG_MMU
=20
-#define __VVAR_PAGES    2
+#define __VDSO_PAGES    4
=20
 #ifndef __ASSEMBLY__
 #include <generated/vdso-offsets.h>
diff --git a/arch/riscv/include/asm/vdso/time_data.h b/arch/riscv/include/asm=
/vdso/arch_data.h
similarity index 71%
rename from arch/riscv/include/asm/vdso/time_data.h
rename to arch/riscv/include/asm/vdso/arch_data.h
index dfa65228999b..da57a3786f7a 100644
--- a/arch/riscv/include/asm/vdso/time_data.h
+++ b/arch/riscv/include/asm/vdso/arch_data.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __RISCV_ASM_VDSO_TIME_DATA_H
-#define __RISCV_ASM_VDSO_TIME_DATA_H
+#ifndef __RISCV_ASM_VDSO_ARCH_DATA_H
+#define __RISCV_ASM_VDSO_ARCH_DATA_H
=20
 #include <linux/types.h>
 #include <vdso/datapage.h>
 #include <asm/hwprobe.h>
=20
-struct arch_vdso_time_data {
+struct vdso_arch_data {
 	/* Stash static answers to the hwprobe queries when all CPUs are selected. =
*/
 	__u64 all_cpu_hwprobe_values[RISCV_HWPROBE_MAX_KEY + 1];
=20
@@ -14,4 +14,4 @@ struct arch_vdso_time_data {
 	__u8 homogeneous_cpus;
 };
=20
-#endif /* __RISCV_ASM_VDSO_TIME_DATA_H */
+#endif /* __RISCV_ASM_VDSO_ARCH_DATA_H */
diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/=
asm/vdso/gettimeofday.h
index ba3283cf7acc..29164f84f93c 100644
--- a/arch/riscv/include/asm/vdso/gettimeofday.h
+++ b/arch/riscv/include/asm/vdso/gettimeofday.h
@@ -69,7 +69,7 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel=
_timespec *_ts)
 #endif /* CONFIG_GENERIC_TIME_VSYSCALL */
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	/*
 	 * The purpose of csr_read(CSR_TIME) is to trap the system into
@@ -79,18 +79,6 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock=
_mode,
 	return csr_read(CSR_TIME);
 }
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return _timens_data;
-}
-#endif
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/riscv/include/asm/vdso/vsyscall.h b/arch/riscv/include/asm/=
vdso/vsyscall.h
index e8a9c4b53c0c..1140b54b4bc8 100644
--- a/arch/riscv/include/asm/vdso/vsyscall.h
+++ b/arch/riscv/include/asm/vdso/vsyscall.h
@@ -6,15 +6,6 @@
=20
 #include <vdso/datapage.h>
=20
-extern struct vdso_data *vdso_data;
-
-static __always_inline struct vdso_data *__riscv_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-
-#define __arch_get_k_vdso_data __riscv_get_k_vdso_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bcd3b816306c..04a4e5495512 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -450,8 +450,7 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *=
pairs,
=20
 static int __init init_hwprobe_vdso_data(void)
 {
-	struct vdso_data *vd =3D __arch_get_k_vdso_data();
-	struct arch_vdso_time_data *avd =3D &vd->arch_data;
+	struct vdso_arch_data *avd =3D vdso_k_arch_data;
 	u64 id_bitsmash =3D 0;
 	struct riscv_hwprobe pair;
 	int key;
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 3ca3ae4277e1..cc2895d1fbc2 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -13,20 +13,11 @@
 #include <linux/err.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
 #include <vdso/vsyscall.h>
=20
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
-#define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
-
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
+#define VVAR_SIZE  (VDSO_NR_PAGES << PAGE_SHIFT)
=20
 struct __vdso_info {
 	const char *name;
@@ -79,78 +70,6 @@ static void __init __vdso_init(struct __vdso_info *vdso_in=
fo)
 	vdso_info->cm->pages =3D vdso_pagelist;
 }
=20
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-static const struct vm_special_mapping rv_vvar_map;
-
-/*
- * The vvar mapping contains data for a specific time namespace, so when a t=
ask
- * changes namespace we must unmap its vvar data for the old namespace.
- * Subsequent faults will map in data for the new namespace.
- *
- * For more details see timens_setup_vdso_data().
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &rv_vvar_map))
-			zap_vma_pages(vma);
-	}
-
-	mmap_read_unlock(mm);
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	struct page *timens_page =3D find_timens_vvar_page(vma);
-	unsigned long pfn;
-
-	switch (vmf->pgoff) {
-	case VVAR_DATA_PAGE_OFFSET:
-		if (timens_page)
-			pfn =3D page_to_pfn(timens_page);
-		else
-			pfn =3D sym_to_pfn(vdso_data);
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
-		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		pfn =3D sym_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
-static const struct vm_special_mapping rv_vvar_map =3D {
-	.name   =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
-
 static struct vm_special_mapping rv_vdso_map __ro_after_init =3D {
 	.name   =3D "[vdso]",
 	.mremap =3D vdso_mremap,
@@ -196,7 +115,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	void *ret;
=20
-	BUILD_BUG_ON(VVAR_NR_PAGES !=3D __VVAR_PAGES);
+	BUILD_BUG_ON(VDSO_NR_PAGES !=3D __VDSO_PAGES);
=20
 	vdso_text_len =3D vdso_info->vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
@@ -208,8 +127,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
 		goto up_fail;
 	}
=20
-	ret =3D _install_special_mapping(mm, vdso_base, VVAR_SIZE,
-		(VM_READ | VM_MAYREAD | VM_PFNMAP), &rv_vvar_map);
+	ret =3D vdso_install_vvar_mapping(mm, vdso_base);
 	if (IS_ERR(ret))
 		goto up_fail;
=20
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 9a1b555e8733..ad73607abc28 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -2,7 +2,7 @@
 # Copied from arch/tile/kernel/vdso/Makefile
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
 # Symbols present in the vdso
 vdso-syms  =3D rt_sigreturn
 ifdef CONFIG_64BIT
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprob=
e.c
index a158c029344f..2ddeba6c68dd 100644
--- a/arch/riscv/kernel/vdso/hwprobe.c
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -16,8 +16,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pair=
s, size_t pair_count,
 				 size_t cpusetsize, unsigned long *cpus,
 				 unsigned int flags)
 {
-	const struct vdso_data *vd =3D __arch_get_vdso_data();
-	const struct arch_vdso_time_data *avd =3D &vd->arch_data;
+	const struct vdso_arch_data *avd =3D &vdso_u_arch_data;
 	bool all_cpus =3D !cpusetsize && !cpus;
 	struct riscv_hwprobe *p =3D pairs;
 	struct riscv_hwprobe *end =3D pairs + pair_count;
@@ -51,8 +50,7 @@ static int riscv_vdso_get_cpus(struct riscv_hwprobe *pairs,=
 size_t pair_count,
 			       size_t cpusetsize, unsigned long *cpus,
 			       unsigned int flags)
 {
-	const struct vdso_data *vd =3D __arch_get_vdso_data();
-	const struct arch_vdso_time_data *avd =3D &vd->arch_data;
+	const struct vdso_arch_data *avd =3D &vdso_u_arch_data;
 	struct riscv_hwprobe *p =3D pairs;
 	struct riscv_hwprobe *end =3D pairs + pair_count;
 	unsigned char *c =3D (unsigned char *)cpus;
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.=
lds.S
index cbe2a179331d..8e86965a8aae 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -4,15 +4,14 @@
  */
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_ARCH(riscv)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9c9ec08d78c7..7ed6f229250c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -166,6 +166,7 @@ config S390
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE
diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 92c73e4d97a9..420a073fdde5 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -6,13 +6,11 @@
=20
 #ifndef __ASSEMBLY__
=20
-extern struct vdso_data *vdso_data;
-
 int vdso_getcpu_init(void);
=20
 #endif /* __ASSEMBLY__ */
=20
-#define __VVAR_PAGES	2
+#define __VDSO_PAGES	4
=20
 #define VDSO_VERSION_STRING	LINUX_2.6.29
=20
diff --git a/arch/s390/include/asm/vdso/getrandom.h b/arch/s390/include/asm/v=
dso/getrandom.h
index 36355af7160b..f8713ce39bb2 100644
--- a/arch/s390/include/asm/vdso/getrandom.h
+++ b/arch/s390/include/asm/vdso/getrandom.h
@@ -23,18 +23,6 @@ static __always_inline ssize_t getrandom_syscall(void *buf=
fer, size_t len, unsig
 	return syscall3(__NR_getrandom, (long)buffer, (long)len, (long)flags);
 }
=20
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
-{
-	/*
-	 * The RNG data is in the real VVAR data page, but if a task belongs to a t=
ime namespace
-	 * then VVAR_DATA_PAGE_OFFSET points to the namespace-specific VVAR page an=
d VVAR_TIMENS_
-	 * PAGE_OFFSET points to the real VVAR page.
-	 */
-	if (IS_ENABLED(CONFIG_TIME_NS) && _vdso_data->clock_mode =3D=3D VDSO_CLOCKM=
ODE_TIMENS)
-		return (void *)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE;
-	return &_vdso_rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/s390/include/asm/vdso/gettimeofday.h b/arch/s390/include/as=
m/vdso/gettimeofday.h
index 7937765ccfa5..fb4564308e9d 100644
--- a/arch/s390/include/asm/vdso/gettimeofday.h
+++ b/arch/s390/include/asm/vdso/gettimeofday.h
@@ -14,12 +14,7 @@
 #include <linux/compiler.h>
=20
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-static inline u64 __arch_get_hw_counter(s32 clock_mode, const struct vdso_da=
ta *vd)
+static inline u64 __arch_get_hw_counter(s32 clock_mode, const struct vdso_ti=
me_data *vd)
 {
 	u64 adj, now;
=20
@@ -49,12 +44,4 @@ long clock_getres_fallback(clockid_t clkid, struct __kerne=
l_timespec *ts)
 	return syscall2(__NR_clock_getres, (long)clkid, (long)ts);
 }
=20
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return _timens_data;
-}
-#endif
-
 #endif
diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vd=
so/vsyscall.h
index 3eb576ecd3bd..d346ebe51301 100644
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -2,32 +2,12 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
-#define __VDSO_RND_DATA_OFFSET	768
-
 #ifndef __ASSEMBLY__
=20
 #include <linux/hrtimer.h>
 #include <vdso/datapage.h>
 #include <asm/vdso.h>
=20
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES
-};
-
-static __always_inline struct vdso_data *__s390_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __s390_get_k_vdso_data
-
-static __always_inline struct vdso_rng_data *__s390_get_k_vdso_rnd_data(void)
-{
-	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
-}
-#define __arch_get_k_vdso_rng_data __s390_get_k_vdso_rnd_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index e9f47c3a6197..699a18f1c54e 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -79,12 +79,10 @@ void __init time_early_init(void)
 {
 	struct ptff_qto qto;
 	struct ptff_qui qui;
-	int cs;
=20
 	/* Initialize TOD steering parameters */
 	tod_steering_end =3D tod_clock_base.tod;
-	for (cs =3D 0; cs < CS_BASES; cs++)
-		vdso_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
+	vdso_k_time_data->arch_data.tod_steering_end =3D tod_steering_end;
=20
 	if (!test_facility(28))
 		return;
@@ -373,7 +371,6 @@ static void clock_sync_global(long delta)
 {
 	unsigned long now, adj;
 	struct ptff_qto qto;
-	int cs;
=20
 	/* Fixup the monotonic sched clock. */
 	tod_clock_base.eitod +=3D delta;
@@ -389,10 +386,8 @@ static void clock_sync_global(long delta)
 		panic("TOD clock sync offset %li is too large to drift\n",
 		      tod_steering_delta);
 	tod_steering_end =3D now + (abs(tod_steering_delta) << 15);
-	for (cs =3D 0; cs < CS_BASES; cs++) {
-		vdso_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
-		vdso_data[cs].arch_data.tod_steering_delta =3D tod_steering_delta;
-	}
+	vdso_k_time_data->arch_data.tod_steering_end =3D tod_steering_end;
+	vdso_k_time_data->arch_data.tod_steering_delta =3D tod_steering_delta;
=20
 	/* Update LPAR offset. */
 	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) =3D=3D 0)
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 598b512cde01..70c8f9ad13cd 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -16,8 +16,8 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
-#include <linux/time_namespace.h>
 #include <linux/random.h>
+#include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
 #include <asm/vdso/vsyscall.h>
 #include <asm/alternative.h>
@@ -26,85 +26,6 @@
 extern char vdso64_start[], vdso64_end[];
 extern char vdso32_start[], vdso32_end[];
=20
-static struct vm_special_mapping vvar_mapping;
-
-static union vdso_data_store vdso_data_store __page_aligned_data;
-
-struct vdso_data *vdso_data =3D vdso_data_store.data;
-
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-/*
- * The VVAR page layout depends on whether a task belongs to the root or
- * non-root time namespace. Whenever a task changes its namespace, the VVAR
- * page tables are cleared and then they will be re-faulted with a
- * corresponding layout.
- * See also the comment near timens_setup_vdso_data() for details.
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	VMA_ITERATOR(vmi, mm, 0);
-	struct vm_area_struct *vma;
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (!vma_is_special_mapping(vma, &vvar_mapping))
-			continue;
-		zap_vma_pages(vma);
-		break;
-	}
-	mmap_read_unlock(mm);
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	struct page *timens_page =3D find_timens_vvar_page(vma);
-	unsigned long addr, pfn;
-	vm_fault_t err;
-
-	switch (vmf->pgoff) {
-	case VVAR_DATA_PAGE_OFFSET:
-		pfn =3D virt_to_pfn(vdso_data);
-		if (timens_page) {
-			/*
-			 * Fault in VVAR page too, since it will be accessed
-			 * to get clock data anyway.
-			 */
-			addr =3D vmf->address + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE;
-			err =3D vmf_insert_pfn(vma, addr, pfn);
-			if (unlikely(err & VM_FAULT_ERROR))
-				return err;
-			pfn =3D page_to_pfn(timens_page);
-		}
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
-		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		pfn =3D virt_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *vma)
 {
@@ -112,11 +33,6 @@ static int vdso_mremap(const struct vm_special_mapping *s=
m,
 	return 0;
 }
=20
-static struct vm_special_mapping vvar_mapping =3D {
-	.name =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
-
 static struct vm_special_mapping vdso64_mapping =3D {
 	.name =3D "[vdso]",
 	.mremap =3D vdso_mremap,
@@ -142,7 +58,7 @@ static int map_vdso(unsigned long addr, unsigned long vdso=
_mapping_len)
 	struct vm_area_struct *vma;
 	int rc;
=20
-	BUILD_BUG_ON(VVAR_NR_PAGES !=3D __VVAR_PAGES);
+	BUILD_BUG_ON(VDSO_NR_PAGES !=3D __VDSO_PAGES);
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
@@ -157,14 +73,11 @@ static int map_vdso(unsigned long addr, unsigned long vd=
so_mapping_len)
 	rc =3D vvar_start;
 	if (IS_ERR_VALUE(vvar_start))
 		goto out;
-	vma =3D _install_special_mapping(mm, vvar_start, VVAR_NR_PAGES*PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
-				       &vvar_mapping);
+	vma =3D vdso_install_vvar_mapping(mm, vvar_start);
 	rc =3D PTR_ERR(vma);
 	if (IS_ERR(vma))
 		goto out;
-	vdso_text_start =3D vvar_start + VVAR_NR_PAGES * PAGE_SIZE;
+	vdso_text_start =3D vvar_start + VDSO_NR_PAGES * PAGE_SIZE;
 	/* VM_MAYWRITE for COW so gdb can set breakpoints */
 	vma =3D _install_special_mapping(mm, vdso_text_start, vdso_text_len,
 				       VM_READ|VM_EXEC|
@@ -220,7 +133,7 @@ unsigned long vdso_text_size(void)
=20
 unsigned long vdso_size(void)
 {
-	return vdso_text_size() + VVAR_NR_PAGES * PAGE_SIZE;
+	return vdso_text_size() + VDSO_NR_PAGES * PAGE_SIZE;
 }
=20
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makef=
ile
index 2c5afb88d298..1e4ddd1a683f 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -2,7 +2,7 @@
 # List of files in the vdso
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
 obj-vdso32 =3D vdso_user_wrapper-32.o note-32.o
=20
 # Build rules
diff --git a/arch/s390/kernel/vdso32/vdso32.lds.S b/arch/s390/kernel/vdso32/v=
dso32.lds.S
index c916c4f73f76..9630d58c2080 100644
--- a/arch/s390/kernel/vdso32/vdso32.lds.S
+++ b/arch/s390/kernel/vdso32/vdso32.lds.S
@@ -6,16 +6,15 @@
=20
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390:31-bit)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makef=
ile
index ad206f2068d8..d8f0df742809 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -2,7 +2,7 @@
 # List of files in the vdso
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
 obj-vdso64 =3D vdso_user_wrapper.o note.o vgetrandom-chacha.o
 obj-cvdso64 =3D vdso64_generic.o getcpu.o vgetrandom.o
 VDSO_CFLAGS_REMOVE :=3D -pg $(CC_FLAGS_FTRACE) $(CC_FLAGS_EXPOLINE)
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/v=
dso64.lds.S
index ec42b7d9cb53..e4f6551ae898 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -7,17 +7,15 @@
 #include <asm/vdso/vsyscall.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
 OUTPUT_ARCH(s390:64-bit)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-	PROVIDE(_vdso_rng_data =3D _vdso_data + __VDSO_RND_DATA_OFFSET);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 50ec2978cda5..fdc4a8f5a49c 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -22,7 +22,7 @@ targets +=3D $(foreach x, 32 64, vdso-image-$(x).c vdso$(x)=
.so vdso$(x).so.dbg)
=20
 CPPFLAGS_vdso.lds +=3D -P -C
=20
-VDSO_LDFLAGS_vdso.lds =3D -m elf64_sparc -soname linux-vdso.so.1 --no-undefi=
ned \
+VDSO_LDFLAGS_vdso.lds =3D -m elf64_sparc -soname linux-vdso.so.1 \
 			-z max-page-size=3D8192
=20
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
@@ -101,7 +101,6 @@ $(obj)/vdso32.so.dbg: FORCE \
 quiet_cmd_vdso =3D VDSO    $@
       cmd_vdso =3D $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		sh $(src)/checkundef.sh '$(OBJDUMP)' '$@'
+		       -T $(filter %.lds,$^) $(filter %.o,$^)
=20
-VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 -Bsymbolic
+VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 -Bsymbolic --=
no-undefined
diff --git a/arch/sparc/vdso/checkundef.sh b/arch/sparc/vdso/checkundef.sh
deleted file mode 100644
index 2d85876ffc32..000000000000
--- a/arch/sparc/vdso/checkundef.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-objdump=3D"$1"
-file=3D"$2"
-$objdump -t "$file" | grep '*UUND*' | grep -v '#scratch' > /dev/null 2>&1
-if [ $? -eq 1 ]; then
-    exit 0
-else
-    echo "$file: undefined symbols found" >&2
-    exit 1
-fi
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d957e2f..e66ffd941d17 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -178,6 +178,7 @@ config X86
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1e..a6430c5636b8 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -4,7 +4,7 @@
 #
=20
 # Include the generic Makefile to check the built vDSO:
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 # Files to link into the vDSO:
 vobjs-y :=3D vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o vgetrandom-=
chacha.o
@@ -32,7 +32,7 @@ targets +=3D $(foreach x, 64 x32 32, vdso-image-$(x).c vdso=
$(x).so vdso$(x).so.dbg
=20
 CPPFLAGS_vdso.lds +=3D -P -C
=20
-VDSO_LDFLAGS_vdso.lds =3D -m elf_x86_64 -soname linux-vdso.so.1 --no-undefin=
ed \
+VDSO_LDFLAGS_vdso.lds =3D -m elf_x86_64 -soname linux-vdso.so.1 \
 			-z max-page-size=3D4096
=20
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
@@ -151,10 +151,9 @@ $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32=
) FORCE
 quiet_cmd_vdso =3D VDSO    $@
       cmd_vdso =3D $(LD) -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		 sh $(src)/checkundef.sh '$(NM)' '$@'
+		       -T $(filter %.lds,$^) $(filter %.o,$^)
=20
-VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 \
+VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 --no-undefine=
d \
 	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
=20
 quiet_cmd_vdso_and_check =3D VDSO    $@
diff --git a/arch/x86/entry/vdso/checkundef.sh b/arch/x86/entry/vdso/checkund=
ef.sh
deleted file mode 100755
index 7ee90a9b549d..000000000000
--- a/arch/x86/entry/vdso/checkundef.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-nm=3D"$1"
-file=3D"$2"
-$nm "$file" | grep '^ *U' > /dev/null 2>&1
-if [ $? -eq 1 ]; then
-    exit 0
-else
-    echo "$file: undefined symbols found" >&2
-    exit 1
-fi
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index 872947c1004c..ec1ac191a057 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vdso.h>
 #include <asm/vdso/vsyscall.h>
+#include <vdso/datapage.h>
=20
 /*
  * Linker script for vDSO.  This is an ELF shared object prelinked to
@@ -17,14 +18,9 @@ SECTIONS
 	 * segment.
 	 */
=20
-	vvar_start =3D . - __VVAR_PAGES * PAGE_SIZE;
-	vvar_page  =3D vvar_start;
+	VDSO_VVAR_SYMS
=20
-	vdso_rng_data =3D vvar_page + __VDSO_RND_DATA_OFFSET;
-
-	timens_page  =3D vvar_start + PAGE_SIZE;
-
-	vclock_pages =3D vvar_start + VDSO_NR_VCLOCK_PAGES * PAGE_SIZE;
+	vclock_pages =3D VDSO_VCLOCK_PAGES_START(vdso_u_data);
 	pvclock_page =3D vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
 	hvclock_page =3D vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
=20
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 90d15f2a7205..f84e8f8fa5fe 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -69,33 +69,12 @@
=20
 const char *outfilename;
=20
-/* Symbols that we need in vdso2c. */
-enum {
-	sym_vvar_start,
-	sym_vvar_page,
-	sym_pvclock_page,
-	sym_hvclock_page,
-	sym_timens_page,
-};
-
-const int special_pages[] =3D {
-	sym_vvar_page,
-	sym_pvclock_page,
-	sym_hvclock_page,
-	sym_timens_page,
-};
-
 struct vdso_sym {
 	const char *name;
 	bool export;
 };
=20
 struct vdso_sym required_syms[] =3D {
-	[sym_vvar_start] =3D {"vvar_start", true},
-	[sym_vvar_page] =3D {"vvar_page", true},
-	[sym_pvclock_page] =3D {"pvclock_page", true},
-	[sym_hvclock_page] =3D {"hvclock_page", true},
-	[sym_timens_page] =3D {"timens_page", true},
 	{"VDSO32_NOTE_MASK", true},
 	{"__kernel_vsyscall", true},
 	{"__kernel_sigreturn", true},
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 67b3e37576a6..78ed1c1f28b9 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -150,26 +150,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		}
 	}
=20
-	/* Validate mapping addresses. */
-	for (i =3D 0; i < sizeof(special_pages) / sizeof(special_pages[0]); i++) {
-		INT_BITS symval =3D syms[special_pages[i]];
-
-		if (!symval)
-			continue;  /* The mapping isn't used; ignore it. */
-
-		if (symval % 4096)
-			fail("%s must be a multiple of 4096\n",
-			     required_syms[i].name);
-		if (symval + 4096 < syms[sym_vvar_start])
-			fail("%s underruns vvar_start\n",
-			     required_syms[i].name);
-		if (symval + 4096 > 0)
-			fail("%s is on the wrong side of the vdso text\n",
-			     required_syms[i].name);
-	}
-	if (syms[sym_vvar_start] % 4096)
-		fail("vvar_begin must be a multiple of 4096\n");
-
 	if (!image_name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 39e6efc1a9ca..7245e95c573e 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -14,7 +14,7 @@
 #include <linux/elf.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
=20
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
@@ -27,13 +27,7 @@
 #include <asm/vdso/vsyscall.h>
 #include <clocksource/hyperv_timer.h>
=20
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)vvar_page;
-}
-
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
+static_assert(VDSO_NR_PAGES + VDSO_NR_VCLOCK_PAGES =3D=3D __VDSO_PAGES);
=20
 unsigned int vclocks_used __read_mostly;
=20
@@ -54,7 +48,6 @@ int __init init_vdso_image(const struct vdso_image *image)
 	return 0;
 }
=20
-static const struct vm_special_mapping vvar_mapping;
 struct linux_binprm;
=20
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
@@ -98,99 +91,6 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
=20
-#ifdef CONFIG_TIME_NS
-/*
- * The vvar page layout depends on whether a task belongs to the root or
- * non-root time namespace. Whenever a task changes its namespace, the VVAR
- * page tables are cleared and then they will re-faulted with a
- * corresponding layout.
- * See also the comment near timens_setup_vdso_data() for details.
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vvar_mapping))
-			zap_vma_pages(vma);
-	}
-	mmap_read_unlock(mm);
-
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-		      struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	const struct vdso_image *image =3D vma->vm_mm->context.vdso_image;
-	unsigned long pfn;
-	long sym_offset;
-
-	if (!image)
-		return VM_FAULT_SIGBUS;
-
-	sym_offset =3D (long)(vmf->pgoff << PAGE_SHIFT) +
-		image->sym_vvar_start;
-
-	/*
-	 * Sanity check: a symbol offset of zero means that the page
-	 * does not exist for this vdso image, not that the page is at
-	 * offset zero relative to the text mapping.  This should be
-	 * impossible here, because sym_offset should only be zero for
-	 * the page past the end of the vvar mapping.
-	 */
-	if (sym_offset =3D=3D 0)
-		return VM_FAULT_SIGBUS;
-
-	if (sym_offset =3D=3D image->sym_vvar_page) {
-		struct page *timens_page =3D find_timens_vvar_page(vma);
-
-		pfn =3D __pa_symbol(vdso_data) >> PAGE_SHIFT;
-
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the sym_vvar_page offset and
-		 * the real VVAR page is mapped with the sym_timens_page
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (timens_page) {
-			unsigned long addr;
-			vm_fault_t err;
-
-			/*
-			 * Optimization: inside time namespace pre-fault
-			 * VVAR page too. As on timens page there are only
-			 * offsets for clocks on VVAR, it'll be faulted
-			 * shortly by VDSO code.
-			 */
-			addr =3D vmf->address + (image->sym_timens_page - sym_offset);
-			err =3D vmf_insert_pfn(vma, addr, pfn);
-			if (unlikely(err & VM_FAULT_ERROR))
-				return err;
-
-			pfn =3D page_to_pfn(timens_page);
-		}
-
-		return vmf_insert_pfn(vma, vmf->address, pfn);
-
-	} else if (sym_offset =3D=3D image->sym_timens_page) {
-		struct page *timens_page =3D find_timens_vvar_page(vma);
-
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-
-		pfn =3D __pa_symbol(vdso_data) >> PAGE_SHIFT;
-		return vmf_insert_pfn(vma, vmf->address, pfn);
-	}
-
-	return VM_FAULT_SIGBUS;
-}
-
 static vm_fault_t vvar_vclock_fault(const struct vm_special_mapping *sm,
 				    struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -212,7 +112,6 @@ static vm_fault_t vvar_vclock_fault(const struct vm_speci=
al_mapping *sm,
 	case VDSO_PAGE_HVCLOCK_OFFSET:
 	{
 		unsigned long pfn =3D hv_get_tsc_pfn();
-
 		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address, pfn);
 		break;
@@ -228,10 +127,6 @@ static const struct vm_special_mapping vdso_mapping =3D {
 	.fault =3D vdso_fault,
 	.mremap =3D vdso_mremap,
 };
-static const struct vm_special_mapping vvar_mapping =3D {
-	.name =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
 static const struct vm_special_mapping vvar_vclock_mapping =3D {
 	.name =3D "[vvar_vclock]",
 	.fault =3D vvar_vclock_fault,
@@ -253,13 +148,13 @@ static int map_vdso(const struct vdso_image *image, uns=
igned long addr)
 		return -EINTR;
=20
 	addr =3D get_unmapped_area(NULL, addr,
-				 image->size - image->sym_vvar_start, 0, 0);
+				 image->size + __VDSO_PAGES * PAGE_SIZE, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret =3D addr;
 		goto up_fail;
 	}
=20
-	text_start =3D addr - image->sym_vvar_start;
+	text_start =3D addr + __VDSO_PAGES * PAGE_SIZE;
=20
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
@@ -276,13 +171,7 @@ static int map_vdso(const struct vdso_image *image, unsi=
gned long addr)
 		goto up_fail;
 	}
=20
-	vma =3D _install_special_mapping(mm,
-				       addr,
-				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
-				       &vvar_mapping);
-
+	vma =3D vdso_install_vvar_mapping(mm, addr);
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
@@ -290,7 +179,7 @@ static int map_vdso(const struct vdso_image *image, unsig=
ned long addr)
 	}
=20
 	vma =3D _install_special_mapping(mm,
-				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
+				       VDSO_VCLOCK_PAGES_START(addr),
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
 				       VM_PFNMAP,
@@ -327,7 +216,7 @@ int map_vdso_once(const struct vdso_image *image, unsigne=
d long addr)
 	 */
 	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
-				vma_is_special_mapping(vma, &vvar_mapping) ||
+				vma_is_special_mapping(vma, &vdso_vvar_mapping) ||
 				vma_is_special_mapping(vma, &vvar_vclock_mapping)) {
 			mmap_write_unlock(mm);
 			return -EEXIST;
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index d7f6592b74a9..80be0da733df 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -18,12 +18,6 @@ struct vdso_image {
 	unsigned long extable_base, extable_len;
 	const void *extable;
=20
-	long sym_vvar_start;  /* Negative offset to the vvar area */
-
-	long sym_vvar_page;
-	long sym_pvclock_page;
-	long sym_hvclock_page;
-	long sym_timens_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vds=
o/getrandom.h
index 2bf9c0e970c3..af85539f6557 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -27,16 +27,6 @@ static __always_inline ssize_t getrandom_syscall(void *buf=
fer, size_t len, unsig
 	return ret;
 }
=20
-extern struct vdso_rng_data vdso_rng_data
-	__attribute__((visibility("hidden")));
-
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
-{
-	if (IS_ENABLED(CONFIG_TIME_NS) && __arch_get_vdso_data()->clock_mode =3D=3D=
 VDSO_CLOCKMODE_TIMENS)
-		return (void *)&vdso_rng_data + ((void *)&timens_page - (void *)__arch_get=
_vdso_data());
-	return &vdso_rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index 375a34b0f365..9e52cc46e1da 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -19,12 +19,6 @@
 #include <asm/pvclock.h>
 #include <clocksource/hyperv_timer.h>
=20
-extern struct vdso_data vvar_page
-	__attribute__((visibility("hidden")));
-
-extern struct vdso_data timens_page
-	__attribute__((visibility("hidden")));
-
 #define VDSO_HAS_TIME 1
=20
 #define VDSO_HAS_CLOCK_GETRES 1
@@ -59,14 +53,6 @@ extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
=20
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return &timens_page;
-}
-#endif
-
 #ifndef BUILD_VDSO32
=20
 static __always_inline
@@ -250,7 +236,7 @@ static u64 vread_hvclock(void)
 #endif
=20
 static inline u64 __arch_get_hw_counter(s32 clock_mode,
-					const struct vdso_data *vd)
+					const struct vdso_time_data *vd)
 {
 	if (likely(clock_mode =3D=3D VDSO_CLOCKMODE_TSC))
 		return (u64)rdtsc_ordered() & S64_MAX;
@@ -275,12 +261,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode,
 	return U64_MAX;
 }
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return &vvar_page;
-}
-
-static inline bool arch_vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool arch_vdso_clocksource_ok(const struct vdso_clock *vc)
 {
 	return true;
 }
@@ -319,34 +300,34 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * declares everything with the MSB/Sign-bit set as invalid. Therefore the
  * effective mask is S64_MAX.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycl=
es, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_clock *vc, u64 cyc=
les, u64 base)
 {
-	u64 delta =3D cycles - vd->cycle_last;
+	u64 delta =3D cycles - vc->cycle_last;
=20
 	/*
 	 * Negative motion and deltas which can cause multiplication
 	 * overflow require special treatment. This check covers both as
-	 * negative motion is guaranteed to be greater than @vd::max_cycles
+	 * negative motion is guaranteed to be greater than @vc::max_cycles
 	 * due to unsigned comparison.
 	 *
 	 * Due to the MSB/Sign-bit being used as invalid marker (see
 	 * arch_vdso_cycles_ok() above), the effective mask is S64_MAX, but that
 	 * case is also unlikely and will also take the unlikely path here.
 	 */
-	if (unlikely(delta > vd->max_cycles)) {
+	if (unlikely(delta > vc->max_cycles)) {
 		/*
 		 * Due to the above mentioned TSC wobbles, filter out
 		 * negative motion.  Per the above masking, the effective
 		 * sign bit is now bit 62.
 		 */
 		if (delta & (1ULL << 62))
-			return base >> vd->shift;
+			return base >> vc->shift;
=20
 		/* Handle multiplication overflow gracefully */
-		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vd->mult, base, vd->shift);
+		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vc->mult, base, vc->shift);
 	}
=20
-	return ((delta * vd->mult) + base) >> vd->shift;
+	return ((delta * vc->mult) + base) >> vc->shift;
 }
 #define vdso_calc_ns vdso_calc_ns
=20
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index 37b4a70559a8..ebbf63420af0 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -2,10 +2,10 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
-#define __VDSO_RND_DATA_OFFSET  640
-#define __VVAR_PAGES	4
+#define __VDSO_PAGES	6
=20
 #define VDSO_NR_VCLOCK_PAGES	2
+#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VDSO_PAGES - VDSO_NR_VCLOCK_P=
AGES) * PAGE_SIZE)
 #define VDSO_PAGE_PVCLOCK_OFFSET	0
 #define VDSO_PAGE_HVCLOCK_OFFSET	1
=20
@@ -14,25 +14,6 @@
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
=20
-extern struct vdso_data *vdso_data;
-
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-static __always_inline
-struct vdso_data *__x86_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __x86_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
-{
-	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
-}
-#define __arch_get_k_vdso_rng_data __x86_get_k_vdso_rng_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2581186fa61b..92cbd24a36d8 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -278,7 +278,7 @@ static void crng_reseed(struct work_struct *work)
 	WRITE_ONCE(base_crng.generation, next_gen);
 #ifdef CONFIG_VDSO_GETRANDOM
 	/* base_crng.generation's invalid value is ULONG_MAX, while
-	 * _vdso_rng_data.generation's invalid value is 0, so add one to the
+	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
 	 * former to arrive at the latter. Use smp_store_release so that this
 	 * is ordered with the write above to base_crng.generation. Pairs with
 	 * the smp_rmb() before the syscall in the vDSO code.
@@ -290,7 +290,7 @@ static void crng_reseed(struct work_struct *work)
 	 * because the vDSO side only checks whether the value changed, without
 	 * actually using or interpreting the value.
 	 */
-	smp_store_release((unsigned long *)&__arch_get_k_vdso_rng_data()->generatio=
n, next_gen + 1);
+	smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen +=
 1);
 #endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init =3D CRNG_READY;
@@ -743,7 +743,7 @@ static void __cold _credit_init_bits(size_t bits)
 			queue_work(system_unbound_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
 #ifdef CONFIG_VDSO_GETRANDOM
-		WRITE_ONCE(__arch_get_k_vdso_rng_data()->is_ready, true);
+		WRITE_ONCE(vdso_k_rng_data->is_ready, true);
 #endif
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index 01dafd604188..b550afa15ecd 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,24 +4,35 @@
=20
 #ifndef __ASSEMBLY__
=20
-#ifndef __arch_get_k_vdso_data
-static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
+
+#ifndef __arch_get_vdso_u_time_data
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
 {
-	return NULL;
+	return &vdso_u_time_data;
 }
-#endif /* __arch_get_k_vdso_data */
+#endif
+
+#ifndef __arch_get_vdso_u_rng_data
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_dat=
a(void)
+{
+	return &vdso_u_rng_data;
+}
+#endif
+
+#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 #ifndef __arch_update_vsyscall
-static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata)
+static __always_inline void __arch_update_vsyscall(struct vdso_time_data *vd=
ata)
 {
 }
 #endif /* __arch_update_vsyscall */
=20
-#ifndef __arch_sync_vdso_data
-static __always_inline void __arch_sync_vdso_data(struct vdso_data *vdata)
+#ifndef __arch_sync_vdso_time_data
+static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data=
 *vdata)
 {
 }
-#endif /* __arch_sync_vdso_data */
+#endif /* __arch_sync_vdso_time_data */
=20
 #endif /* !__ASSEMBLY__ */
=20
diff --git a/include/linux/align.h b/include/linux/align.h
index 2b4acec7b95a..55debf105a5d 100644
--- a/include/linux/align.h
+++ b/include/linux/align.h
@@ -2,14 +2,6 @@
 #ifndef _LINUX_ALIGN_H
 #define _LINUX_ALIGN_H
=20
-#include <linux/const.h>
-
-/* @a is a power of 2 value */
-#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
-#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
-#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
-#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
-#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
-#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
+#include <vdso/align.h>
=20
 #endif	/* _LINUX_ALIGN_H */
diff --git a/include/linux/cache.h b/include/linux/cache.h
index ca2a05682a54..e69768f50d53 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -3,16 +3,13 @@
 #define __LINUX_CACHE_H
=20
 #include <uapi/linux/kernel.h>
+#include <vdso/cache.h>
 #include <asm/cache.h>
=20
 #ifndef L1_CACHE_ALIGN
 #define L1_CACHE_ALIGN(x) __ALIGN_KERNEL(x, L1_CACHE_BYTES)
 #endif
=20
-#ifndef SMP_CACHE_BYTES
-#define SMP_CACHE_BYTES L1_CACHE_BYTES
-#endif
-
 /**
  * SMP_CACHE_ALIGN - align a value to the L2 cacheline size
  * @x: value to align
@@ -63,10 +60,6 @@
 #define __ro_after_init __section(".data..ro_after_init")
 #endif
=20
-#ifndef ____cacheline_aligned
-#define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
-#endif
-
 #ifndef ____cacheline_aligned_in_smp
 #ifdef CONFIG_SMP
 #define ____cacheline_aligned_in_smp ____cacheline_aligned
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 876e31b4461d..0b8b32bf0655 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -165,6 +165,4 @@ static inline ktime_t timens_ktime_to_host(clockid_t cloc=
kid, ktime_t tim)
 }
 #endif
=20
-struct vdso_data *arch_get_vdso_data(void *vvar_page);
-
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/vdso_datastore.h b/include/linux/vdso_datastore.h
new file mode 100644
index 000000000000..a91fa24b06e0
--- /dev/null
+++ b/include/linux/vdso_datastore.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VDSO_DATASTORE_H
+#define _LINUX_VDSO_DATASTORE_H
+
+#include <linux/mm_types.h>
+
+extern const struct vm_special_mapping vdso_vvar_mapping;
+struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsig=
ned long addr);
+
+#endif /* _LINUX_VDSO_DATASTORE_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d29cec..49f9f90458d8 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -11,6 +11,7 @@ typedef __u16	Elf32_Half;
 typedef __u32	Elf32_Off;
 typedef __s32	Elf32_Sword;
 typedef __u32	Elf32_Word;
+typedef __u16	Elf32_Versym;
=20
 /* 64-bit ELF base types. */
 typedef __u64	Elf64_Addr;
@@ -21,6 +22,7 @@ typedef __s32	Elf64_Sword;
 typedef __u32	Elf64_Word;
 typedef __u64	Elf64_Xword;
 typedef __s64	Elf64_Sxword;
+typedef __u16	Elf64_Versym;
=20
 /* These constants are for the segment types stored in the image headers */
 #define PT_NULL    0
@@ -107,6 +109,7 @@ typedef __s64	Elf64_Sxword;
 #define DT_VALRNGLO	0x6ffffd00
 #define DT_VALRNGHI	0x6ffffdff
 #define DT_ADDRRNGLO	0x6ffffe00
+#define DT_GNU_HASH	0x6ffffef5
 #define DT_ADDRRNGHI	0x6ffffeff
 #define DT_VERSYM	0x6ffffff0
 #define DT_RELACOUNT	0x6ffffff9
@@ -125,6 +128,8 @@ typedef __s64	Elf64_Sxword;
 #define STB_GLOBAL 1
 #define STB_WEAK   2
=20
+#define STN_UNDEF 0
+
 #define STT_NOTYPE  0
 #define STT_OBJECT  1
 #define STT_FUNC    2
@@ -133,6 +138,9 @@ typedef __s64	Elf64_Sxword;
 #define STT_COMMON  5
 #define STT_TLS     6
=20
+#define VER_FLG_BASE 0x1
+#define VER_FLG_WEAK 0x2
+
 #define ELF_ST_BIND(x)		((x) >> 4)
 #define ELF_ST_TYPE(x)		((x) & 0xf)
 #define ELF32_ST_BIND(x)	ELF_ST_BIND(x)
@@ -483,4 +491,34 @@ typedef struct elf64_note {
 /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
 #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
=20
+typedef struct {
+  Elf32_Half	vd_version;
+  Elf32_Half	vd_flags;
+  Elf32_Half	vd_ndx;
+  Elf32_Half	vd_cnt;
+  Elf32_Word	vd_hash;
+  Elf32_Word	vd_aux;
+  Elf32_Word	vd_next;
+} Elf32_Verdef;
+
+typedef struct {
+  Elf64_Half	vd_version;
+  Elf64_Half	vd_flags;
+  Elf64_Half	vd_ndx;
+  Elf64_Half	vd_cnt;
+  Elf64_Word	vd_hash;
+  Elf64_Word	vd_aux;
+  Elf64_Word	vd_next;
+} Elf64_Verdef;
+
+typedef struct {
+  Elf32_Word    vda_name;
+  Elf32_Word    vda_next;
+} Elf32_Verdaux;
+
+typedef struct {
+  Elf64_Word    vda_name;
+  Elf64_Word    vda_next;
+} Elf64_Verdaux;
+
 #endif /* _UAPI_LINUX_ELF_H */
diff --git a/include/vdso/align.h b/include/vdso/align.h
new file mode 100644
index 000000000000..02dd8626b5c5
--- /dev/null
+++ b/include/vdso/align.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_ALIGN_H
+#define __VDSO_ALIGN_H
+
+#include <vdso/const.h>
+
+/* @a is a power of 2 value */
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
+#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
+#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
+#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
+
+#endif	/* __VDSO_ALIGN_H */
diff --git a/include/vdso/cache.h b/include/vdso/cache.h
new file mode 100644
index 000000000000..f89d48304bf8
--- /dev/null
+++ b/include/vdso/cache.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_CACHE_H
+#define __VDSO_CACHE_H
+
+#include <asm/cache.h>
+
+#ifndef SMP_CACHE_BYTES
+#define SMP_CACHE_BYTES L1_CACHE_BYTES
+#endif
+
+#ifndef ____cacheline_aligned
+#define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
+#endif
+
+#endif	/* __VDSO_ALIGN_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index d967baa0cd0c..1864e76e8f69 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -9,11 +9,14 @@
 #include <uapi/linux/types.h>
 #include <uapi/asm-generic/errno-base.h>
=20
+#include <vdso/align.h>
 #include <vdso/bits.h>
+#include <vdso/cache.h>
 #include <vdso/clocksource.h>
 #include <vdso/ktime.h>
 #include <vdso/limits.h>
 #include <vdso/math64.h>
+#include <vdso/page.h>
 #include <vdso/processor.h>
 #include <vdso/time.h>
 #include <vdso/time32.h>
@@ -25,6 +28,15 @@
 struct arch_vdso_time_data {};
 #endif
=20
+#if defined(CONFIG_ARCH_HAS_VDSO_ARCH_DATA)
+#include <asm/vdso/arch_data.h>
+#elif defined(CONFIG_GENERIC_VDSO_DATA_STORE)
+struct vdso_arch_data {
+	/* Needed for the generic code, never actually used at runtime */
+	char __unused;
+};
+#endif
+
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -45,11 +57,11 @@ struct arch_vdso_time_data {};
  *
  * There is one vdso_timestamp object in vvar for each vDSO-accelerated
  * clock_id. For high-resolution clocks, this encodes the time
- * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
+ * corresponding to vdso_time_data.cycle_last. For coarse clocks this encodes
  * the actual time.
  *
  * To be noticed that for highres clocks nsec is left-shifted by
- * vdso_data.cs[x].shift.
+ * vdso_time_data[x].shift.
  */
 struct vdso_timestamp {
 	u64	sec;
@@ -57,7 +69,7 @@ struct vdso_timestamp {
 };
=20
 /**
- * struct vdso_data - vdso datapage representation
+ * struct vdso_clock - vdso per clocksource datapage representation
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
@@ -67,19 +79,9 @@ struct vdso_timestamp {
  * @shift:		clocksource shift
  * @basetime[clock_id]:	basetime per clock_id
  * @offset[clock_id]:	time namespace offset per clock_id
- * @tz_minuteswest:	minutes west of Greenwich
- * @tz_dsttime:		type of DST correction
- * @hrtimer_res:	hrtimer resolution
- * @__unused:		unused
- * @arch_data:		architecture specific data (optional, defaults
- *			to an empty struct)
  *
- * vdso_data will be accessed by 64 bit and compat code at the same time
- * so we should be careful before modifying this structure.
- *
- * The ordering of the struct members is optimized to have fast access to the
- * often required struct members which are related to CLOCK_REALTIME and
- * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ * See also struct vdso_time_data for basic access and ordering information =
as
+ * struct vdso_clock is used there.
  *
  * @basetime is used to store the base time for the system wide time getter
  * VVAR page.
@@ -92,7 +94,7 @@ struct vdso_timestamp {
  * For clocks which are not affected by time namespace adjustment the
  * offset must be zero.
  */
-struct vdso_data {
+struct vdso_clock {
 	u32			seq;
=20
 	s32			clock_mode;
@@ -108,14 +110,35 @@ struct vdso_data {
 		struct vdso_timestamp	basetime[VDSO_BASES];
 		struct timens_offset	offset[VDSO_BASES];
 	};
+};
+
+/**
+ * struct vdso_time_data - vdso datapage representation
+ * @arch_data:		architecture specific data (optional, defaults
+ *			to an empty struct)
+ * @clock_data:		clocksource related data (array)
+ * @tz_minuteswest:	minutes west of Greenwich
+ * @tz_dsttime:		type of DST correction
+ * @hrtimer_res:	hrtimer resolution
+ * @__unused:		unused
+ *
+ * vdso_time_data will be accessed by 64 bit and compat code at the same time
+ * so we should be careful before modifying this structure.
+ *
+ * The ordering of the struct members is optimized to have fast acces to the
+ * often required struct members which are related to CLOCK_REALTIME and
+ * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ */
+struct vdso_time_data {
+	struct arch_vdso_time_data	arch_data;
=20
-	s32			tz_minuteswest;
-	s32			tz_dsttime;
-	u32			hrtimer_res;
-	u32			__unused;
+	struct vdso_clock		clock_data[CS_BASES];
=20
-	struct arch_vdso_time_data arch_data;
-};
+	s32				tz_minuteswest;
+	s32				tz_dsttime;
+	u32				hrtimer_res;
+	u32				__unused;
+} ____cacheline_aligned;
=20
 /**
  * struct vdso_rng_data - vdso RNG state information
@@ -136,22 +159,32 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidd=
en")));
-extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hi=
dden")));
-extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden=
")));
-
-/**
- * union vdso_data_store - Generic vDSO data page
- */
-union vdso_data_store {
-	struct vdso_data	data[CS_BASES];
-	u8			page[1U << CONFIG_PAGE_SHIFT];
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
+extern struct vdso_time_data vdso_u_time_data __attribute__((visibility("hid=
den")));
+extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidde=
n")));
+extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hid=
den")));
+
+extern struct vdso_time_data *vdso_k_time_data;
+extern struct vdso_rng_data *vdso_k_rng_data;
+extern struct vdso_arch_data *vdso_k_arch_data;
+
+#define VDSO_ARCH_DATA_SIZE ALIGN(sizeof(struct vdso_arch_data), PAGE_SIZE)
+#define VDSO_ARCH_DATA_PAGES (VDSO_ARCH_DATA_SIZE >> PAGE_SHIFT)
+
+enum vdso_pages {
+	VDSO_TIME_PAGE_OFFSET,
+	VDSO_TIMENS_PAGE_OFFSET,
+	VDSO_RNG_PAGE_OFFSET,
+	VDSO_ARCH_PAGES_START,
+	VDSO_ARCH_PAGES_END =3D VDSO_ARCH_PAGES_START + VDSO_ARCH_DATA_PAGES - 1,
+	VDSO_NR_PAGES
 };
=20
+#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
+
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
- * - __arch_get_vdso_data(): to get the vdso datapage.
  * - __arch_get_hw_counter(): to get the hw counter based on the
  *   clock_mode.
  * - gettimeofday_fallback(): fallback for gettimeofday.
@@ -164,6 +197,27 @@ union vdso_data_store {
 #include <asm/vdso/gettimeofday.h>
 #endif /* ENABLE_COMPAT_VDSO */
=20
+#else /* !__ASSEMBLY__ */
+
+#ifdef CONFIG_VDSO_GETRANDOM
+#define __vdso_u_rng_data	PROVIDE(vdso_u_rng_data =3D vdso_u_data + 2 * PAGE=
_SIZE);
+#else
+#define __vdso_u_rng_data
+#endif
+
+#ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
+#define __vdso_u_arch_data	PROVIDE(vdso_u_arch_data =3D vdso_u_data + 3 * PA=
GE_SIZE);
+#else
+#define __vdso_u_arch_data
+#endif
+
+#define VDSO_VVAR_SYMS						\
+	PROVIDE(vdso_u_data =3D . - __VDSO_PAGES * PAGE_SIZE);	\
+	PROVIDE(vdso_u_time_data =3D vdso_u_data);		\
+	__vdso_u_rng_data					\
+	__vdso_u_arch_data					\
+
+
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __VDSO_DATAPAGE_H */
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 3ddb03bb05cb..0a98fed550ba 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -7,49 +7,53 @@
 #include <asm/barrier.h>
 #include <vdso/datapage.h>
=20
-static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
+static __always_inline u32 vdso_read_begin(const struct vdso_clock *vc)
 {
 	u32 seq;
=20
-	while (unlikely((seq =3D READ_ONCE(vd->seq)) & 1))
+	while (unlikely((seq =3D READ_ONCE(vc->seq)) & 1))
 		cpu_relax();
=20
 	smp_rmb();
 	return seq;
 }
=20
-static __always_inline u32 vdso_read_retry(const struct vdso_data *vd,
+static __always_inline u32 vdso_read_retry(const struct vdso_clock *vc,
 					   u32 start)
 {
 	u32 seq;
=20
 	smp_rmb();
-	seq =3D READ_ONCE(vd->seq);
+	seq =3D READ_ONCE(vc->seq);
 	return seq !=3D start;
 }
=20
-static __always_inline void vdso_write_begin(struct vdso_data *vd)
+static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
 {
+	struct vdso_clock *vc =3D vd->clock_data;
+
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
 	 * updates to vd[x].seq and it is possible that the value seen by the
 	 * reader is inconsistent.
 	 */
-	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
+	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
+	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
 	smp_wmb();
 }
=20
-static __always_inline void vdso_write_end(struct vdso_data *vd)
+static __always_inline void vdso_write_end(struct vdso_time_data *vd)
 {
+	struct vdso_clock *vc =3D vd->clock_data;
+
 	smp_wmb();
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
 	 * updates to vd[x].seq and it is possible that the value seen by the
 	 * reader is inconsistent.
 	 */
-	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
+	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
+	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
 }
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 0775b9ec952a..e3642278df43 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -165,26 +165,26 @@ static struct timens_offset offset_from_ts(struct times=
pec64 off)
  *     HVCLOCK
  *     VVAR
  *
- * The check for vdso_data->clock_mode is in the unlikely path of
+ * The check for vdso_clock->clock_mode is in the unlikely path of
  * the seq begin magic. So for the non-timens case most of the time
  * 'seq' is even, so the branch is not taken.
  *
  * If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
- * for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
+ * for vdso_clock->clock_mode is a non-issue. The task is spin waiting for t=
he
  * update to finish and for 'seq' to become even anyway.
  *
- * Timens page has vdso_data->clock_mode set to VDSO_CLOCKMODE_TIMENS which
+ * Timens page has vdso_clock->clock_mode set to VDSO_CLOCKMODE_TIMENS which
  * enforces the time namespace handling path.
  */
-static void timens_setup_vdso_data(struct vdso_data *vdata,
-				   struct time_namespace *ns)
+static void timens_setup_vdso_clock_data(struct vdso_clock *vc,
+					 struct time_namespace *ns)
 {
-	struct timens_offset *offset =3D vdata->offset;
+	struct timens_offset *offset =3D vc->offset;
 	struct timens_offset monotonic =3D offset_from_ts(ns->offsets.monotonic);
 	struct timens_offset boottime =3D offset_from_ts(ns->offsets.boottime);
=20
-	vdata->seq			=3D 1;
-	vdata->clock_mode		=3D VDSO_CLOCKMODE_TIMENS;
+	vc->seq				=3D 1;
+	vc->clock_mode			=3D VDSO_CLOCKMODE_TIMENS;
 	offset[CLOCK_MONOTONIC]		=3D monotonic;
 	offset[CLOCK_MONOTONIC_RAW]	=3D monotonic;
 	offset[CLOCK_MONOTONIC_COARSE]	=3D monotonic;
@@ -219,7 +219,8 @@ static DEFINE_MUTEX(offset_lock);
 static void timens_set_vvar_page(struct task_struct *task,
 				struct time_namespace *ns)
 {
-	struct vdso_data *vdata;
+	struct vdso_time_data *vdata;
+	struct vdso_clock *vc;
 	unsigned int i;
=20
 	if (ns =3D=3D &init_time_ns)
@@ -235,10 +236,11 @@ static void timens_set_vvar_page(struct task_struct *ta=
sk,
 		goto out;
=20
 	ns->frozen_offsets =3D true;
-	vdata =3D arch_get_vdso_data(page_address(ns->vvar_page));
+	vdata =3D page_address(ns->vvar_page);
+	vc =3D vdata->clock_data;
=20
 	for (i =3D 0; i < CS_BASES; i++)
-		timens_setup_vdso_data(&vdata[i], ns);
+		timens_setup_vdso_clock_data(&vc[i], ns);
=20
 out:
 	mutex_unlock(&offset_lock);
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 05d383143165..01c2ab1e8971 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -15,29 +15,29 @@
=20
 #include "timekeeping_internal.h"
=20
-static inline void update_vdso_data(struct vdso_data *vdata,
-				    struct timekeeper *tk)
+static inline void update_vdso_time_data(struct vdso_time_data *vdata, struc=
t timekeeper *tk)
 {
+	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec, sec;
=20
-	vdata[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
+	vc[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vdata[CS_HRES_COARSE].max_cycles	=3D tk->tkr_mono.clock->max_cycles;
+	vc[CS_HRES_COARSE].max_cycles	=3D tk->tkr_mono.clock->max_cycles;
 #endif
-	vdata[CS_HRES_COARSE].mask		=3D tk->tkr_mono.mask;
-	vdata[CS_HRES_COARSE].mult		=3D tk->tkr_mono.mult;
-	vdata[CS_HRES_COARSE].shift		=3D tk->tkr_mono.shift;
-	vdata[CS_RAW].cycle_last		=3D tk->tkr_raw.cycle_last;
+	vc[CS_HRES_COARSE].mask		=3D tk->tkr_mono.mask;
+	vc[CS_HRES_COARSE].mult		=3D tk->tkr_mono.mult;
+	vc[CS_HRES_COARSE].shift	=3D tk->tkr_mono.shift;
+	vc[CS_RAW].cycle_last		=3D tk->tkr_raw.cycle_last;
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vdata[CS_RAW].max_cycles		=3D tk->tkr_raw.clock->max_cycles;
+	vc[CS_RAW].max_cycles		=3D tk->tkr_raw.clock->max_cycles;
 #endif
-	vdata[CS_RAW].mask			=3D tk->tkr_raw.mask;
-	vdata[CS_RAW].mult			=3D tk->tkr_raw.mult;
-	vdata[CS_RAW].shift			=3D tk->tkr_raw.shift;
+	vc[CS_RAW].mask			=3D tk->tkr_raw.mask;
+	vc[CS_RAW].mult			=3D tk->tkr_raw.mult;
+	vc[CS_RAW].shift		=3D tk->tkr_raw.shift;
=20
 	/* CLOCK_MONOTONIC */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
 	vdso_ts->sec	=3D tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
=20
 	nsec =3D tk->tkr_mono.xtime_nsec;
@@ -55,7 +55,7 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 	nsec	+=3D (u64)tk->monotonic_to_boot.tv_nsec << tk->tkr_mono.shift;
=20
 	/* CLOCK_BOOTTIME */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
 	vdso_ts->sec	=3D sec;
=20
 	while (nsec >=3D (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
@@ -65,19 +65,20 @@ static inline void update_vdso_data(struct vdso_data *vda=
ta,
 	vdso_ts->nsec	=3D nsec;
=20
 	/* CLOCK_MONOTONIC_RAW */
-	vdso_ts		=3D &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
+	vdso_ts		=3D &vc[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
 	vdso_ts->sec	=3D tk->raw_sec;
 	vdso_ts->nsec	=3D tk->tkr_raw.xtime_nsec;
=20
 	/* CLOCK_TAI */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_TAI];
 	vdso_ts->sec	=3D tk->xtime_sec + (s64)tk->tai_offset;
 	vdso_ts->nsec	=3D tk->tkr_mono.xtime_nsec;
 }
=20
 void update_vsyscall(struct timekeeper *tk)
 {
-	struct vdso_data *vdata =3D __arch_get_k_vdso_data();
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
+	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
 	s32 clock_mode;
 	u64 nsec;
@@ -86,21 +87,21 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_write_begin(vdata);
=20
 	clock_mode =3D tk->tkr_mono.clock->vdso_clock_mode;
-	vdata[CS_HRES_COARSE].clock_mode	=3D clock_mode;
-	vdata[CS_RAW].clock_mode		=3D clock_mode;
+	vc[CS_HRES_COARSE].clock_mode	=3D clock_mode;
+	vc[CS_RAW].clock_mode		=3D clock_mode;
=20
 	/* CLOCK_REALTIME also required for time() */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
 	vdso_ts->sec	=3D tk->xtime_sec;
 	vdso_ts->nsec	=3D tk->tkr_mono.xtime_nsec;
=20
 	/* CLOCK_REALTIME_COARSE */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
 	vdso_ts->sec	=3D tk->xtime_sec;
 	vdso_ts->nsec	=3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
=20
 	/* CLOCK_MONOTONIC_COARSE */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
 	vdso_ts->sec	=3D tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec		=3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 	nsec		=3D nsec + tk->wall_to_monotonic.tv_nsec;
@@ -108,32 +109,31 @@ void update_vsyscall(struct timekeeper *tk)
=20
 	/*
 	 * Read without the seqlock held by clock_getres().
-	 * Note: No need to have a second copy.
 	 */
-	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
+	WRITE_ONCE(vdata->hrtimer_res, hrtimer_resolution);
=20
 	/*
 	 * If the current clocksource is not VDSO capable, then spare the
 	 * update of the high resolution parts.
 	 */
 	if (clock_mode !=3D VDSO_CLOCKMODE_NONE)
-		update_vdso_data(vdata, tk);
+		update_vdso_time_data(vdata, tk);
=20
 	__arch_update_vsyscall(vdata);
=20
 	vdso_write_end(vdata);
=20
-	__arch_sync_vdso_data(vdata);
+	__arch_sync_vdso_time_data(vdata);
 }
=20
 void update_vsyscall_tz(void)
 {
-	struct vdso_data *vdata =3D __arch_get_k_vdso_data();
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
=20
-	vdata[CS_HRES_COARSE].tz_minuteswest =3D sys_tz.tz_minuteswest;
-	vdata[CS_HRES_COARSE].tz_dsttime =3D sys_tz.tz_dsttime;
+	vdata->tz_minuteswest =3D sys_tz.tz_minuteswest;
+	vdata->tz_dsttime =3D sys_tz.tz_dsttime;
=20
-	__arch_sync_vdso_data(vdata);
+	__arch_sync_vdso_time_data(vdata);
 }
=20
 /**
@@ -150,7 +150,7 @@ void update_vsyscall_tz(void)
  */
 unsigned long vdso_update_begin(void)
 {
-	struct vdso_data *vdata =3D __arch_get_k_vdso_data();
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
 	unsigned long flags =3D timekeeper_lock_irqsave();
=20
 	vdso_write_begin(vdata);
@@ -167,9 +167,9 @@ unsigned long vdso_update_begin(void)
  */
 void vdso_update_end(unsigned long flags)
 {
-	struct vdso_data *vdata =3D __arch_get_k_vdso_data();
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
=20
 	vdso_write_end(vdata);
-	__arch_sync_vdso_data(vdata);
+	__arch_sync_vdso_time_data(vdata);
 	timekeeper_unlock_irqrestore(flags);
 }
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..fcdee83deb5c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -132,7 +132,7 @@ endif
 obj-$(CONFIG_DEBUG_INFO_REDUCED) +=3D debug_info.o
 CFLAGS_debug_info.o +=3D $(call cc-option, -femit-struct-debug-detailed=3Dan=
y)
=20
-obj-y +=3D math/ crypto/
+obj-y +=3D math/ crypto/ vdso/
=20
 obj-$(CONFIG_GENERIC_IOMAP) +=3D iomap.o
 obj-$(CONFIG_HAS_IOMEM) +=3D iomap_copy.o devres.o
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 82fe827af542..45df764b49ad 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -43,3 +43,8 @@ config VDSO_GETRANDOM
 	bool
 	help
 	  Selected by architectures that support vDSO getrandom().
+
+config GENERIC_VDSO_DATA_STORE
+	bool
+	help
+	  Selected by architectures that use the generic vDSO data store.
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
index cedbf15f8087..aedd40aaa950 100644
--- a/lib/vdso/Makefile
+++ b/lib/vdso/Makefile
@@ -1,18 +1,3 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
=20
-GENERIC_VDSO_MK_PATH :=3D $(abspath $(lastword $(MAKEFILE_LIST)))
-GENERIC_VDSO_DIR :=3D $(dir $(GENERIC_VDSO_MK_PATH))
-
-c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) :=3D $(addprefix $(GENERIC_VDS=
O_DIR), gettimeofday.c)
-c-getrandom-$(CONFIG_VDSO_GETRANDOM) :=3D $(addprefix $(GENERIC_VDSO_DIR), g=
etrandom.c)
-
-# This cmd checks that the vdso library does not contain dynamic relocations.
-# It has to be called after the linking of the vdso library and requires it
-# as a parameter.
-#
-# As a workaround for some GNU ld ports which produce unneeded R_*_NONE
-# dynamic relocations, ignore R_*_NONE.
-quiet_cmd_vdso_check =3D VDSOCHK $@
-      cmd_vdso_check =3D if $(READELF) -rW $@ | grep -v _NONE | grep -q " R_=
\w*_"; \
-		       then (echo >&2 "$@: dynamic relocations are not supported"; \
-			     rm -f $@; /bin/false); fi
+obj-$(CONFIG_GENERIC_VDSO_DATA_STORE) +=3D datastore.o
diff --git a/lib/vdso/Makefile.include b/lib/vdso/Makefile.include
new file mode 100644
index 000000000000..cedbf15f8087
--- /dev/null
+++ b/lib/vdso/Makefile.include
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+GENERIC_VDSO_MK_PATH :=3D $(abspath $(lastword $(MAKEFILE_LIST)))
+GENERIC_VDSO_DIR :=3D $(dir $(GENERIC_VDSO_MK_PATH))
+
+c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) :=3D $(addprefix $(GENERIC_VDS=
O_DIR), gettimeofday.c)
+c-getrandom-$(CONFIG_VDSO_GETRANDOM) :=3D $(addprefix $(GENERIC_VDSO_DIR), g=
etrandom.c)
+
+# This cmd checks that the vdso library does not contain dynamic relocations.
+# It has to be called after the linking of the vdso library and requires it
+# as a parameter.
+#
+# As a workaround for some GNU ld ports which produce unneeded R_*_NONE
+# dynamic relocations, ignore R_*_NONE.
+quiet_cmd_vdso_check =3D VDSOCHK $@
+      cmd_vdso_check =3D if $(READELF) -rW $@ | grep -v _NONE | grep -q " R_=
\w*_"; \
+		       then (echo >&2 "$@: dynamic relocations are not supported"; \
+			     rm -f $@; /bin/false); fi
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
new file mode 100644
index 000000000000..c715e217ec65
--- /dev/null
+++ b/lib/vdso/datastore.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/linkage.h>
+#include <linux/mmap_lock.h>
+#include <linux/mm.h>
+#include <linux/time_namespace.h>
+#include <linux/types.h>
+#include <linux/vdso_datastore.h>
+#include <vdso/datapage.h>
+
+/*
+ * The vDSO data page.
+ */
+#ifdef CONFIG_HAVE_GENERIC_VDSO
+static union {
+	struct vdso_time_data	data;
+	u8			page[PAGE_SIZE];
+} vdso_time_data_store __page_aligned_data;
+struct vdso_time_data *vdso_k_time_data =3D &vdso_time_data_store.data;
+static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
+#endif /* CONFIG_HAVE_GENERIC_VDSO */
+
+#ifdef CONFIG_VDSO_GETRANDOM
+static union {
+	struct vdso_rng_data	data;
+	u8			page[PAGE_SIZE];
+} vdso_rng_data_store __page_aligned_data;
+struct vdso_rng_data *vdso_k_rng_data =3D &vdso_rng_data_store.data;
+static_assert(sizeof(vdso_rng_data_store) =3D=3D PAGE_SIZE);
+#endif /* CONFIG_VDSO_GETRANDOM */
+
+#ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
+static union {
+	struct vdso_arch_data	data;
+	u8			page[VDSO_ARCH_DATA_SIZE];
+} vdso_arch_data_store __page_aligned_data;
+struct vdso_arch_data *vdso_k_arch_data =3D &vdso_arch_data_store.data;
+#endif /* CONFIG_ARCH_HAS_VDSO_ARCH_DATA */
+
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
+			     struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct page *timens_page =3D find_timens_vvar_page(vma);
+	unsigned long addr, pfn;
+	vm_fault_t err;
+
+	switch (vmf->pgoff) {
+	case VDSO_TIME_PAGE_OFFSET:
+		if (!IS_ENABLED(CONFIG_HAVE_GENERIC_VDSO))
+			return VM_FAULT_SIGBUS;
+		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		if (timens_page) {
+			/*
+			 * Fault in VVAR page too, since it will be accessed
+			 * to get clock data anyway.
+			 */
+			addr =3D vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
+			err =3D vmf_insert_pfn(vma, addr, pfn);
+			if (unlikely(err & VM_FAULT_ERROR))
+				return err;
+			pfn =3D page_to_pfn(timens_page);
+		}
+		break;
+	case VDSO_TIMENS_PAGE_OFFSET:
+		/*
+		 * If a task belongs to a time namespace then a namespace
+		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
+		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
+		 * offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (!IS_ENABLED(CONFIG_TIME_NS) || !timens_page)
+			return VM_FAULT_SIGBUS;
+		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		break;
+	case VDSO_RNG_PAGE_OFFSET:
+		if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+			return VM_FAULT_SIGBUS;
+		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_rng_data));
+		break;
+	case VDSO_ARCH_PAGES_START ... VDSO_ARCH_PAGES_END:
+		if (!IS_ENABLED(CONFIG_ARCH_HAS_VDSO_ARCH_DATA))
+			return VM_FAULT_SIGBUS;
+		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_arch_data)) +
+			vmf->pgoff - VDSO_ARCH_PAGES_START;
+		break;
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
+}
+
+const struct vm_special_mapping vdso_vvar_mapping =3D {
+	.name	=3D "[vvar]",
+	.fault	=3D vvar_fault,
+};
+
+struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsig=
ned long addr)
+{
+	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
+					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP | VM_PFNMAP,
+					&vdso_vvar_mapping);
+}
+
+#ifdef CONFIG_TIME_NS
+/*
+ * The vvar page layout depends on whether a task belongs to the root or
+ * non-root time namespace. Whenever a task changes its namespace, the VVAR
+ * page tables are cleared and then they will be re-faulted with a
+ * corresponding layout.
+ * See also the comment near timens_setup_vdso_clock_data() for details.
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm =3D task->mm;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma_is_special_mapping(vma, &vdso_vvar_mapping))
+			zap_vma_pages(vma);
+	}
+	mmap_read_unlock(mm);
+
+	return 0;
+}
+#endif
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 938ca539aaa6..440f8a6203a6 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -12,6 +12,9 @@
 #include <uapi/linux/mman.h>
 #include <uapi/linux/random.h>
=20
+/* Bring in default accessors */
+#include <vdso/vsyscall.h>
+
 #undef PAGE_SIZE
 #undef PAGE_MASK
 #define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
@@ -152,7 +155,7 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_in=
fo, void *buffer, size_
=20
 		/*
 		 * Prevent the syscall from being reordered wrt current_generation. Pairs =
with the
-		 * smp_store_release(&_vdso_rng_data.generation) in random.c.
+		 * smp_store_release(&vdso_k_rng_data->generation) in random.c.
 		 */
 		smp_rmb();
=20
@@ -256,5 +259,6 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_in=
fo, void *buffer, size_
 static __always_inline ssize_t
 __cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque=
_state, size_t opaque_len)
 {
-	return __cvdso_getrandom_data(__arch_get_vdso_rng_data(), buffer, len, flag=
s, opaque_state, opaque_len);
+	return __cvdso_getrandom_data(__arch_get_vdso_u_rng_data(), buffer, len, fl=
ags,
+				      opaque_state, opaque_len);
 }
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c01eaafd8041..93ef801a97ef 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -5,6 +5,9 @@
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
=20
+/* Bring in default accessors */
+#include <vdso/vsyscall.h>
+
 #ifndef vdso_calc_ns
=20
 #ifdef VDSO_DELTA_NOMASK
@@ -14,12 +17,12 @@
 #endif
=20
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 de=
lta)
+static __always_inline bool vdso_delta_ok(const struct vdso_clock *vc, u64 d=
elta)
 {
-	return delta < vd->max_cycles;
+	return delta < vc->max_cycles;
 }
 #else
-static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 de=
lta)
+static __always_inline bool vdso_delta_ok(const struct vdso_clock *vc, u64 d=
elta)
 {
 	return true;
 }
@@ -36,14 +39,14 @@ static __always_inline u64 vdso_shift_ns(u64 ns, u32 shif=
t)
  * Default implementation which works for all sane clocksources. That
  * obviously excludes x86/TSC.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycl=
es, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_clock *vc, u64 cyc=
les, u64 base)
 {
-	u64 delta =3D (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
+	u64 delta =3D (cycles - vc->cycle_last) & VDSO_DELTA_MASK(vc);
=20
-	if (likely(vdso_delta_ok(vd, delta)))
-		return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
+	if (likely(vdso_delta_ok(vc, delta)))
+		return vdso_shift_ns((delta * vc->mult) + base, vc->shift);
=20
-	return mul_u64_u32_add_u64_shr(delta, vd->mult, base, vd->shift);
+	return mul_u64_u32_add_u64_shr(delta, vc->mult, base, vc->shift);
 }
 #endif /* vdso_calc_ns */
=20
@@ -55,9 +58,9 @@ static inline bool __arch_vdso_hres_capable(void)
 #endif
=20
 #ifndef vdso_clocksource_ok
-static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 {
-	return vd->clock_mode !=3D VDSO_CLOCKMODE_NONE;
+	return vc->clock_mode !=3D VDSO_CLOCKMODE_NONE;
 }
 #endif
=20
@@ -69,36 +72,45 @@ static inline bool vdso_cycles_ok(u64 cycles)
 #endif
=20
 #ifdef CONFIG_TIME_NS
-static __always_inline int do_hres_timens(const struct vdso_data *vdns, cloc=
kid_t clk,
-					  struct __kernel_timespec *ts)
+
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
+static __always_inline
+const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso=
_time_data *vd)
+{
+	return (void *)vd + PAGE_SIZE;
+}
+#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
+
+static __always_inline
+int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_cloc=
k *vcns,
+		   clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct timens_offset *offs =3D &vdns->offset[clk];
+	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
+	const struct timens_offset *offs =3D &vcns->offset[clk];
+	const struct vdso_clock *vc =3D vd->clock_data;
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_data *vd;
 	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
=20
-	vd =3D vdns - (clk =3D=3D CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_COARSE);
-	vd =3D __arch_get_timens_vdso_data(vd);
 	if (clk !=3D CLOCK_MONOTONIC_RAW)
-		vd =3D &vd[CS_HRES_COARSE];
+		vc =3D &vc[CS_HRES_COARSE];
 	else
-		vd =3D &vd[CS_RAW];
-	vdso_ts =3D &vd->basetime[clk];
+		vc =3D &vc[CS_RAW];
+	vdso_ts =3D &vc->basetime[clk];
=20
 	do {
-		seq =3D vdso_read_begin(vd);
+		seq =3D vdso_read_begin(vc);
=20
-		if (unlikely(!vdso_clocksource_ok(vd)))
+		if (unlikely(!vdso_clocksource_ok(vc)))
 			return -1;
=20
-		cycles =3D __arch_get_hw_counter(vd->clock_mode, vd);
+		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns =3D vdso_calc_ns(vd, cycles, vdso_ts->nsec);
+		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
 		sec =3D vdso_ts->sec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	/* Add the namespace offset */
 	sec +=3D offs->sec;
@@ -115,22 +127,24 @@ static __always_inline int do_hres_timens(const struct =
vdso_data *vdns, clockid_
 }
 #else
 static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
+const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso=
_time_data *vd)
 {
 	return NULL;
 }
=20
-static __always_inline int do_hres_timens(const struct vdso_data *vdns, cloc=
kid_t clk,
-					  struct __kernel_timespec *ts)
+static __always_inline
+int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_cloc=
k *vcns,
+		   clockid_t clk, struct __kernel_timespec *ts)
 {
 	return -EINVAL;
 }
 #endif
=20
-static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
-				   struct __kernel_timespec *ts)
+static __always_inline
+int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	    clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
+	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
 	u64 cycles, sec, ns;
 	u32 seq;
=20
@@ -142,31 +156,31 @@ static __always_inline int do_hres(const struct vdso_da=
ta *vd, clockid_t clk,
 		/*
 		 * Open coded function vdso_read_begin() to handle
 		 * VDSO_CLOCKMODE_TIMENS. Time namespace enabled tasks have a
-		 * special VVAR page installed which has vd->seq set to 1 and
-		 * vd->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
+		 * special VVAR page installed which has vc->seq set to 1 and
+		 * vc->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
 		 * namespace affected tasks this does not affect performance
-		 * because if vd->seq is odd, i.e. a concurrent update is in
-		 * progress the extra check for vd->clock_mode is just a few
-		 * extra instructions while spin waiting for vd->seq to become
+		 * because if vc->seq is odd, i.e. a concurrent update is in
+		 * progress the extra check for vc->clock_mode is just a few
+		 * extra instructions while spin waiting for vc->seq to become
 		 * even again.
 		 */
-		while (unlikely((seq =3D READ_ONCE(vd->seq)) & 1)) {
+		while (unlikely((seq =3D READ_ONCE(vc->seq)) & 1)) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
-			    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-				return do_hres_timens(vd, clk, ts);
+			    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+				return do_hres_timens(vd, vc, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();
=20
-		if (unlikely(!vdso_clocksource_ok(vd)))
+		if (unlikely(!vdso_clocksource_ok(vc)))
 			return -1;
=20
-		cycles =3D __arch_get_hw_counter(vd->clock_mode, vd);
+		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns =3D vdso_calc_ns(vd, cycles, vdso_ts->nsec);
+		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
 		sec =3D vdso_ts->sec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	/*
 	 * Do this outside the loop: a race inside the loop could result
@@ -179,21 +193,25 @@ static __always_inline int do_hres(const struct vdso_da=
ta *vd, clockid_t clk,
 }
=20
 #ifdef CONFIG_TIME_NS
-static __always_inline int do_coarse_timens(const struct vdso_data *vdns, cl=
ockid_t clk,
-					    struct __kernel_timespec *ts)
+static __always_inline
+int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_cl=
ock *vcns,
+		     clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd =3D __arch_get_timens_vdso_data(vdns);
-	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
-	const struct timens_offset *offs =3D &vdns->offset[clk];
+	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
+	const struct timens_offset *offs =3D &vcns->offset[clk];
+	const struct vdso_clock *vc =3D vd->clock_data;
+	const struct vdso_timestamp *vdso_ts;
 	u64 nsec;
 	s64 sec;
 	s32 seq;
=20
+	vdso_ts =3D &vc->basetime[clk];
+
 	do {
-		seq =3D vdso_read_begin(vd);
+		seq =3D vdso_read_begin(vc);
 		sec =3D vdso_ts->sec;
 		nsec =3D vdso_ts->nsec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	/* Add the namespace offset */
 	sec +=3D offs->sec;
@@ -208,17 +226,19 @@ static __always_inline int do_coarse_timens(const struc=
t vdso_data *vdns, clocki
 	return 0;
 }
 #else
-static __always_inline int do_coarse_timens(const struct vdso_data *vdns, cl=
ockid_t clk,
-					    struct __kernel_timespec *ts)
+static __always_inline
+int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_cl=
ock *vcns,
+		     clockid_t clk, struct __kernel_timespec *ts)
 {
 	return -1;
 }
 #endif
=20
-static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t c=
lk,
-				     struct __kernel_timespec *ts)
+static __always_inline
+int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	      clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
+	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
 	u32 seq;
=20
 	do {
@@ -226,25 +246,26 @@ static __always_inline int do_coarse(const struct vdso_=
data *vd, clockid_t clk,
 		 * Open coded function vdso_read_begin() to handle
 		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
 		 */
-		while ((seq =3D READ_ONCE(vd->seq)) & 1) {
+		while ((seq =3D READ_ONCE(vc->seq)) & 1) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
-			    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-				return do_coarse_timens(vd, clk, ts);
+			    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+				return do_coarse_timens(vd, vc, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();
=20
 		ts->tv_sec =3D vdso_ts->sec;
 		ts->tv_nsec =3D vdso_ts->nsec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	return 0;
 }
=20
 static __always_inline int
-__cvdso_clock_gettime_common(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct __kernel_timespec *ts)
 {
+	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
=20
 	/* Check for negative values or invalid clocks */
@@ -257,19 +278,19 @@ __cvdso_clock_gettime_common(const struct vdso_data *vd=
, clockid_t clock,
 	 */
 	msk =3D 1U << clock;
 	if (likely(msk & VDSO_HRES))
-		vd =3D &vd[CS_HRES_COARSE];
+		vc =3D &vc[CS_HRES_COARSE];
 	else if (msk & VDSO_COARSE)
-		return do_coarse(&vd[CS_HRES_COARSE], clock, ts);
+		return do_coarse(vd, &vc[CS_HRES_COARSE], clock, ts);
 	else if (msk & VDSO_RAW)
-		vd =3D &vd[CS_RAW];
+		vc =3D &vc[CS_RAW];
 	else
 		return -1;
=20
-	return do_hres(vd, clock, ts);
+	return do_hres(vd, vc, clock, ts);
 }
=20
 static __maybe_unused int
-__cvdso_clock_gettime_data(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_gettime_data(const struct vdso_time_data *vd, clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
 	int ret =3D __cvdso_clock_gettime_common(vd, clock, ts);
@@ -282,12 +303,12 @@ __cvdso_clock_gettime_data(const struct vdso_data *vd, =
clockid_t clock,
 static __maybe_unused int
 __cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
-	return __cvdso_clock_gettime_data(__arch_get_vdso_data(), clock, ts);
+	return __cvdso_clock_gettime_data(__arch_get_vdso_u_time_data(), clock, ts);
 }
=20
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_gettime32_data(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_gettime32_data(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
@@ -308,19 +329,20 @@ __cvdso_clock_gettime32_data(const struct vdso_data *vd=
, clockid_t clock,
 static __maybe_unused int
 __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 {
-	return __cvdso_clock_gettime32_data(__arch_get_vdso_data(), clock, res);
+	return __cvdso_clock_gettime32_data(__arch_get_vdso_u_time_data(), clock, r=
es);
 }
 #endif /* BUILD_VDSO32 */
=20
 static __maybe_unused int
-__cvdso_gettimeofday_data(const struct vdso_data *vd,
+__cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
+	const struct vdso_clock *vc =3D vd->clock_data;
=20
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
=20
-		if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+		if (do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
=20
 		tv->tv_sec =3D ts.tv_sec;
@@ -329,8 +351,8 @@ __cvdso_gettimeofday_data(const struct vdso_data *vd,
=20
 	if (unlikely(tz !=3D NULL)) {
 		if (IS_ENABLED(CONFIG_TIME_NS) &&
-		    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-			vd =3D __arch_get_timens_vdso_data(vd);
+		    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+			vd =3D __arch_get_vdso_u_timens_data(vd);
=20
 		tz->tz_minuteswest =3D vd[CS_HRES_COARSE].tz_minuteswest;
 		tz->tz_dsttime =3D vd[CS_HRES_COARSE].tz_dsttime;
@@ -342,20 +364,23 @@ __cvdso_gettimeofday_data(const struct vdso_data *vd,
 static __maybe_unused int
 __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	return __cvdso_gettimeofday_data(__arch_get_vdso_data(), tv, tz);
+	return __cvdso_gettimeofday_data(__arch_get_vdso_u_time_data(), tv, tz);
 }
=20
 #ifdef VDSO_HAS_TIME
 static __maybe_unused __kernel_old_time_t
-__cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
+__cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *time)
 {
+	const struct vdso_clock *vc =3D vd->clock_data;
 	__kernel_old_time_t t;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
-	    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-		vd =3D __arch_get_timens_vdso_data(vd);
+	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS) {
+		vd =3D __arch_get_vdso_u_timens_data(vd);
+		vc =3D vd->clock_data;
+	}
=20
-	t =3D READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	t =3D READ_ONCE(vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
=20
 	if (time)
 		*time =3D t;
@@ -365,15 +390,16 @@ __cvdso_time_data(const struct vdso_data *vd, __kernel_=
old_time_t *time)
=20
 static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *=
time)
 {
-	return __cvdso_time_data(__arch_get_vdso_data(), time);
+	return __cvdso_time_data(__arch_get_vdso_u_time_data(), time);
 }
 #endif /* VDSO_HAS_TIME */
=20
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres_common(const struct vdso_data *vd, clockid_t clock,
+int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t c=
lock,
 				struct __kernel_timespec *res)
 {
+	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
 	u64 ns;
=20
@@ -382,8 +408,8 @@ int __cvdso_clock_getres_common(const struct vdso_data *v=
d, clockid_t clock,
 		return -1;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
-	    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-		vd =3D __arch_get_timens_vdso_data(vd);
+	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+		vd =3D __arch_get_vdso_u_timens_data(vd);
=20
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
@@ -394,7 +420,7 @@ int __cvdso_clock_getres_common(const struct vdso_data *v=
d, clockid_t clock,
 		/*
 		 * Preserves the behaviour of posix_get_hrtimer_res().
 		 */
-		ns =3D READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
+		ns =3D READ_ONCE(vd->hrtimer_res);
 	} else if (msk & VDSO_COARSE) {
 		/*
 		 * Preserves the behaviour of posix_get_coarse_res().
@@ -412,7 +438,7 @@ int __cvdso_clock_getres_common(const struct vdso_data *v=
d, clockid_t clock,
 }
=20
 static __maybe_unused
-int __cvdso_clock_getres_data(const struct vdso_data *vd, clockid_t clock,
+int __cvdso_clock_getres_data(const struct vdso_time_data *vd, clockid_t clo=
ck,
 			      struct __kernel_timespec *res)
 {
 	int ret =3D __cvdso_clock_getres_common(vd, clock, res);
@@ -425,12 +451,12 @@ int __cvdso_clock_getres_data(const struct vdso_data *v=
d, clockid_t clock,
 static __maybe_unused
 int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 {
-	return __cvdso_clock_getres_data(__arch_get_vdso_data(), clock, res);
+	return __cvdso_clock_getres_data(__arch_get_vdso_u_time_data(), clock, res);
 }
=20
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_getres_time32_data(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_getres_time32_data(const struct vdso_time_data *vd, clockid_t =
clock,
 				 struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
@@ -451,7 +477,7 @@ __cvdso_clock_getres_time32_data(const struct vdso_data *=
vd, clockid_t clock,
 static __maybe_unused int
 __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 {
-	return __cvdso_clock_getres_time32_data(__arch_get_vdso_data(),
+	return __cvdso_clock_getres_time32_data(__arch_get_vdso_u_time_data(),
 						clock, res);
 }
 #endif /* BUILD_VDSO32 */
diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index a1f55fb24bb3..c1299a053145 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -30,6 +30,7 @@ all_files :=3D \
 		crt.h \
 		ctype.h \
 		errno.h \
+		limits.h \
 		nolibc.h \
 		signal.h \
 		stackprotector.h \
diff --git a/tools/include/nolibc/limits.h b/tools/include/nolibc/limits.h
new file mode 100644
index 000000000000..306d4141f4d2
--- /dev/null
+++ b/tools/include/nolibc/limits.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Shim limits.h header for NOLIBC.
+ * Copyright (C) 2025 Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#include "nolibc.h"
diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/elf.h
new file mode 100644
index 000000000000..5834b83d7f9a
--- /dev/null
+++ b/tools/include/uapi/linux/elf.h
@@ -0,0 +1,524 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_ELF_H
+#define _LINUX_ELF_H
+
+#include <linux/types.h>
+#include <linux/elf-em.h>
+
+/* 32-bit ELF base types. */
+typedef __u32	Elf32_Addr;
+typedef __u16	Elf32_Half;
+typedef __u32	Elf32_Off;
+typedef __s32	Elf32_Sword;
+typedef __u32	Elf32_Word;
+typedef __u16	Elf32_Versym;
+
+/* 64-bit ELF base types. */
+typedef __u64	Elf64_Addr;
+typedef __u16	Elf64_Half;
+typedef __s16	Elf64_SHalf;
+typedef __u64	Elf64_Off;
+typedef __s32	Elf64_Sword;
+typedef __u32	Elf64_Word;
+typedef __u64	Elf64_Xword;
+typedef __s64	Elf64_Sxword;
+typedef __u16	Elf64_Versym;
+
+/* These constants are for the segment types stored in the image headers */
+#define PT_NULL    0
+#define PT_LOAD    1
+#define PT_DYNAMIC 2
+#define PT_INTERP  3
+#define PT_NOTE    4
+#define PT_SHLIB   5
+#define PT_PHDR    6
+#define PT_TLS     7		/* Thread local storage segment */
+#define PT_LOOS    0x60000000	/* OS-specific */
+#define PT_HIOS    0x6fffffff	/* OS-specific */
+#define PT_LOPROC  0x70000000
+#define PT_HIPROC  0x7fffffff
+#define PT_GNU_EH_FRAME	(PT_LOOS + 0x474e550)
+#define PT_GNU_STACK	(PT_LOOS + 0x474e551)
+#define PT_GNU_RELRO	(PT_LOOS + 0x474e552)
+#define PT_GNU_PROPERTY	(PT_LOOS + 0x474e553)
+
+
+/* ARM MTE memory tag segment type */
+#define PT_AARCH64_MEMTAG_MTE	(PT_LOPROC + 0x2)
+
+/*
+ * Extended Numbering
+ *
+ * If the real number of program header table entries is larger than
+ * or equal to PN_XNUM(0xffff), it is set to sh_info field of the
+ * section header at index 0, and PN_XNUM is set to e_phnum
+ * field. Otherwise, the section header at index 0 is zero
+ * initialized, if it exists.
+ *
+ * Specifications are available in:
+ *
+ * - Oracle: Linker and Libraries.
+ *   Part No: 817=E2=80=931984=E2=80=9319, August 2011.
+ *   https://docs.oracle.com/cd/E18752_01/pdf/817-1984.pdf
+ *
+ * - System V ABI AMD64 Architecture Processor Supplement
+ *   Draft Version 0.99.4,
+ *   January 13, 2010.
+ *   http://www.cs.washington.edu/education/courses/cse351/12wi/supp-docs/ab=
i.pdf
+ */
+#define PN_XNUM 0xffff
+
+/* These constants define the different elf file types */
+#define ET_NONE   0
+#define ET_REL    1
+#define ET_EXEC   2
+#define ET_DYN    3
+#define ET_CORE   4
+#define ET_LOPROC 0xff00
+#define ET_HIPROC 0xffff
+
+/* This is the info that is needed to parse the dynamic section of the file =
*/
+#define DT_NULL		0
+#define DT_NEEDED	1
+#define DT_PLTRELSZ	2
+#define DT_PLTGOT	3
+#define DT_HASH		4
+#define DT_STRTAB	5
+#define DT_SYMTAB	6
+#define DT_RELA		7
+#define DT_RELASZ	8
+#define DT_RELAENT	9
+#define DT_STRSZ	10
+#define DT_SYMENT	11
+#define DT_INIT		12
+#define DT_FINI		13
+#define DT_SONAME	14
+#define DT_RPATH	15
+#define DT_SYMBOLIC	16
+#define DT_REL		17
+#define DT_RELSZ	18
+#define DT_RELENT	19
+#define DT_PLTREL	20
+#define DT_DEBUG	21
+#define DT_TEXTREL	22
+#define DT_JMPREL	23
+#define DT_ENCODING	32
+#define OLD_DT_LOOS	0x60000000
+#define DT_LOOS		0x6000000d
+#define DT_HIOS		0x6ffff000
+#define DT_VALRNGLO	0x6ffffd00
+#define DT_VALRNGHI	0x6ffffdff
+#define DT_ADDRRNGLO	0x6ffffe00
+#define DT_GNU_HASH	0x6ffffef5
+#define DT_ADDRRNGHI	0x6ffffeff
+#define DT_VERSYM	0x6ffffff0
+#define DT_RELACOUNT	0x6ffffff9
+#define DT_RELCOUNT	0x6ffffffa
+#define DT_FLAGS_1	0x6ffffffb
+#define DT_VERDEF	0x6ffffffc
+#define	DT_VERDEFNUM	0x6ffffffd
+#define DT_VERNEED	0x6ffffffe
+#define	DT_VERNEEDNUM	0x6fffffff
+#define OLD_DT_HIOS     0x6fffffff
+#define DT_LOPROC	0x70000000
+#define DT_HIPROC	0x7fffffff
+
+/* This info is needed when parsing the symbol table */
+#define STB_LOCAL  0
+#define STB_GLOBAL 1
+#define STB_WEAK   2
+
+#define STN_UNDEF 0
+
+#define STT_NOTYPE  0
+#define STT_OBJECT  1
+#define STT_FUNC    2
+#define STT_SECTION 3
+#define STT_FILE    4
+#define STT_COMMON  5
+#define STT_TLS     6
+
+#define VER_FLG_BASE 0x1
+#define VER_FLG_WEAK 0x2
+
+#define ELF_ST_BIND(x)		((x) >> 4)
+#define ELF_ST_TYPE(x)		((x) & 0xf)
+#define ELF32_ST_BIND(x)	ELF_ST_BIND(x)
+#define ELF32_ST_TYPE(x)	ELF_ST_TYPE(x)
+#define ELF64_ST_BIND(x)	ELF_ST_BIND(x)
+#define ELF64_ST_TYPE(x)	ELF_ST_TYPE(x)
+
+typedef struct {
+  Elf32_Sword d_tag;
+  union {
+    Elf32_Sword	d_val;
+    Elf32_Addr	d_ptr;
+  } d_un;
+} Elf32_Dyn;
+
+typedef struct {
+  Elf64_Sxword d_tag;		/* entry tag value */
+  union {
+    Elf64_Xword d_val;
+    Elf64_Addr d_ptr;
+  } d_un;
+} Elf64_Dyn;
+
+/* The following are used with relocations */
+#define ELF32_R_SYM(x) ((x) >> 8)
+#define ELF32_R_TYPE(x) ((x) & 0xff)
+
+#define ELF64_R_SYM(i)			((i) >> 32)
+#define ELF64_R_TYPE(i)			((i) & 0xffffffff)
+
+typedef struct elf32_rel {
+  Elf32_Addr	r_offset;
+  Elf32_Word	r_info;
+} Elf32_Rel;
+
+typedef struct elf64_rel {
+  Elf64_Addr r_offset;	/* Location at which to apply the action */
+  Elf64_Xword r_info;	/* index and type of relocation */
+} Elf64_Rel;
+
+typedef struct elf32_rela {
+  Elf32_Addr	r_offset;
+  Elf32_Word	r_info;
+  Elf32_Sword	r_addend;
+} Elf32_Rela;
+
+typedef struct elf64_rela {
+  Elf64_Addr r_offset;	/* Location at which to apply the action */
+  Elf64_Xword r_info;	/* index and type of relocation */
+  Elf64_Sxword r_addend;	/* Constant addend used to compute value */
+} Elf64_Rela;
+
+typedef struct elf32_sym {
+  Elf32_Word	st_name;
+  Elf32_Addr	st_value;
+  Elf32_Word	st_size;
+  unsigned char	st_info;
+  unsigned char	st_other;
+  Elf32_Half	st_shndx;
+} Elf32_Sym;
+
+typedef struct elf64_sym {
+  Elf64_Word st_name;		/* Symbol name, index in string tbl */
+  unsigned char	st_info;	/* Type and binding attributes */
+  unsigned char	st_other;	/* No defined meaning, 0 */
+  Elf64_Half st_shndx;		/* Associated section index */
+  Elf64_Addr st_value;		/* Value of the symbol */
+  Elf64_Xword st_size;		/* Associated symbol size */
+} Elf64_Sym;
+
+
+#define EI_NIDENT	16
+
+typedef struct elf32_hdr {
+  unsigned char	e_ident[EI_NIDENT];
+  Elf32_Half	e_type;
+  Elf32_Half	e_machine;
+  Elf32_Word	e_version;
+  Elf32_Addr	e_entry;  /* Entry point */
+  Elf32_Off	e_phoff;
+  Elf32_Off	e_shoff;
+  Elf32_Word	e_flags;
+  Elf32_Half	e_ehsize;
+  Elf32_Half	e_phentsize;
+  Elf32_Half	e_phnum;
+  Elf32_Half	e_shentsize;
+  Elf32_Half	e_shnum;
+  Elf32_Half	e_shstrndx;
+} Elf32_Ehdr;
+
+typedef struct elf64_hdr {
+  unsigned char	e_ident[EI_NIDENT];	/* ELF "magic number" */
+  Elf64_Half e_type;
+  Elf64_Half e_machine;
+  Elf64_Word e_version;
+  Elf64_Addr e_entry;		/* Entry point virtual address */
+  Elf64_Off e_phoff;		/* Program header table file offset */
+  Elf64_Off e_shoff;		/* Section header table file offset */
+  Elf64_Word e_flags;
+  Elf64_Half e_ehsize;
+  Elf64_Half e_phentsize;
+  Elf64_Half e_phnum;
+  Elf64_Half e_shentsize;
+  Elf64_Half e_shnum;
+  Elf64_Half e_shstrndx;
+} Elf64_Ehdr;
+
+/* These constants define the permissions on sections in the program
+   header, p_flags. */
+#define PF_R		0x4
+#define PF_W		0x2
+#define PF_X		0x1
+
+typedef struct elf32_phdr {
+  Elf32_Word	p_type;
+  Elf32_Off	p_offset;
+  Elf32_Addr	p_vaddr;
+  Elf32_Addr	p_paddr;
+  Elf32_Word	p_filesz;
+  Elf32_Word	p_memsz;
+  Elf32_Word	p_flags;
+  Elf32_Word	p_align;
+} Elf32_Phdr;
+
+typedef struct elf64_phdr {
+  Elf64_Word p_type;
+  Elf64_Word p_flags;
+  Elf64_Off p_offset;		/* Segment file offset */
+  Elf64_Addr p_vaddr;		/* Segment virtual address */
+  Elf64_Addr p_paddr;		/* Segment physical address */
+  Elf64_Xword p_filesz;		/* Segment size in file */
+  Elf64_Xword p_memsz;		/* Segment size in memory */
+  Elf64_Xword p_align;		/* Segment alignment, file & memory */
+} Elf64_Phdr;
+
+/* sh_type */
+#define SHT_NULL	0
+#define SHT_PROGBITS	1
+#define SHT_SYMTAB	2
+#define SHT_STRTAB	3
+#define SHT_RELA	4
+#define SHT_HASH	5
+#define SHT_DYNAMIC	6
+#define SHT_NOTE	7
+#define SHT_NOBITS	8
+#define SHT_REL		9
+#define SHT_SHLIB	10
+#define SHT_DYNSYM	11
+#define SHT_NUM		12
+#define SHT_LOPROC	0x70000000
+#define SHT_HIPROC	0x7fffffff
+#define SHT_LOUSER	0x80000000
+#define SHT_HIUSER	0xffffffff
+
+/* sh_flags */
+#define SHF_WRITE		0x1
+#define SHF_ALLOC		0x2
+#define SHF_EXECINSTR		0x4
+#define SHF_RELA_LIVEPATCH	0x00100000
+#define SHF_RO_AFTER_INIT	0x00200000
+#define SHF_MASKPROC		0xf0000000
+
+/* special section indexes */
+#define SHN_UNDEF	0
+#define SHN_LORESERVE	0xff00
+#define SHN_LOPROC	0xff00
+#define SHN_HIPROC	0xff1f
+#define SHN_LIVEPATCH	0xff20
+#define SHN_ABS		0xfff1
+#define SHN_COMMON	0xfff2
+#define SHN_HIRESERVE	0xffff
+
+typedef struct elf32_shdr {
+  Elf32_Word	sh_name;
+  Elf32_Word	sh_type;
+  Elf32_Word	sh_flags;
+  Elf32_Addr	sh_addr;
+  Elf32_Off	sh_offset;
+  Elf32_Word	sh_size;
+  Elf32_Word	sh_link;
+  Elf32_Word	sh_info;
+  Elf32_Word	sh_addralign;
+  Elf32_Word	sh_entsize;
+} Elf32_Shdr;
+
+typedef struct elf64_shdr {
+  Elf64_Word sh_name;		/* Section name, index in string tbl */
+  Elf64_Word sh_type;		/* Type of section */
+  Elf64_Xword sh_flags;		/* Miscellaneous section attributes */
+  Elf64_Addr sh_addr;		/* Section virtual addr at execution */
+  Elf64_Off sh_offset;		/* Section file offset */
+  Elf64_Xword sh_size;		/* Size of section in bytes */
+  Elf64_Word sh_link;		/* Index of another section */
+  Elf64_Word sh_info;		/* Additional section information */
+  Elf64_Xword sh_addralign;	/* Section alignment */
+  Elf64_Xword sh_entsize;	/* Entry size if section holds table */
+} Elf64_Shdr;
+
+#define	EI_MAG0		0		/* e_ident[] indexes */
+#define	EI_MAG1		1
+#define	EI_MAG2		2
+#define	EI_MAG3		3
+#define	EI_CLASS	4
+#define	EI_DATA		5
+#define	EI_VERSION	6
+#define	EI_OSABI	7
+#define	EI_PAD		8
+
+#define	ELFMAG0		0x7f		/* EI_MAG */
+#define	ELFMAG1		'E'
+#define	ELFMAG2		'L'
+#define	ELFMAG3		'F'
+#define	ELFMAG		"\177ELF"
+#define	SELFMAG		4
+
+#define	ELFCLASSNONE	0		/* EI_CLASS */
+#define	ELFCLASS32	1
+#define	ELFCLASS64	2
+#define	ELFCLASSNUM	3
+
+#define ELFDATANONE	0		/* e_ident[EI_DATA] */
+#define ELFDATA2LSB	1
+#define ELFDATA2MSB	2
+
+#define EV_NONE		0		/* e_version, EI_VERSION */
+#define EV_CURRENT	1
+#define EV_NUM		2
+
+#define ELFOSABI_NONE	0
+#define ELFOSABI_LINUX	3
+
+#ifndef ELF_OSABI
+#define ELF_OSABI ELFOSABI_NONE
+#endif
+
+/*
+ * Notes used in ET_CORE. Architectures export some of the arch register sets
+ * using the corresponding note types via the PTRACE_GETREGSET and
+ * PTRACE_SETREGSET requests.
+ * The note name for these types is "LINUX", except NT_PRFPREG that is named
+ * "CORE".
+ */
+#define NT_PRSTATUS	1
+#define NT_PRFPREG	2
+#define NT_PRPSINFO	3
+#define NT_TASKSTRUCT	4
+#define NT_AUXV		6
+/*
+ * Note to userspace developers: size of NT_SIGINFO note may increase
+ * in the future to accomodate more fields, don't assume it is fixed!
+ */
+#define NT_SIGINFO      0x53494749
+#define NT_FILE		0x46494c45
+#define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/co=
mmon.h */
+#define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
+#define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
+#define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
+#define NT_PPC_TAR	0x103		/* Target Address Register */
+#define NT_PPC_PPR	0x104		/* Program Priority Register */
+#define NT_PPC_DSCR	0x105		/* Data Stream Control Register */
+#define NT_PPC_EBB	0x106		/* Event Based Branch Registers */
+#define NT_PPC_PMU	0x107		/* Performance Monitor Registers */
+#define NT_PPC_TM_CGPR	0x108		/* TM checkpointed GPR Registers */
+#define NT_PPC_TM_CFPR	0x109		/* TM checkpointed FPR Registers */
+#define NT_PPC_TM_CVMX	0x10a		/* TM checkpointed VMX Registers */
+#define NT_PPC_TM_CVSX	0x10b		/* TM checkpointed VSX Registers */
+#define NT_PPC_TM_SPR	0x10c		/* TM Special Purpose Registers */
+#define NT_PPC_TM_CTAR	0x10d		/* TM checkpointed Target Address Register */
+#define NT_PPC_TM_CPPR	0x10e		/* TM checkpointed Program Priority Register */
+#define NT_PPC_TM_CDSCR	0x10f		/* TM checkpointed Data Stream Control Regist=
er */
+#define NT_PPC_PKEY	0x110		/* Memory Protection Keys registers */
+#define NT_PPC_DEXCR	0x111		/* PowerPC DEXCR registers */
+#define NT_PPC_HASHKEYR	0x112		/* PowerPC HASHKEYR register */
+#define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
+#define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=3Ddeny) */
+#define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
+/* Old binutils treats 0x203 as a CET state */
+#define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
+#define NT_X86_XSAVE_LAYOUT	0x205	/* XSAVE layout description */
+#define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
+#define NT_S390_TIMER	0x301		/* s390 timer register */
+#define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
+#define NT_S390_TODPREG	0x303		/* s390 TOD programmable register */
+#define NT_S390_CTRS	0x304		/* s390 control registers */
+#define NT_S390_PREFIX	0x305		/* s390 prefix register */
+#define NT_S390_LAST_BREAK	0x306	/* s390 breaking event address */
+#define NT_S390_SYSTEM_CALL	0x307	/* s390 system call restart data */
+#define NT_S390_TDB	0x308		/* s390 transaction diagnostic block */
+#define NT_S390_VXRS_LOW	0x309	/* s390 vector registers 0-15 upper half */
+#define NT_S390_VXRS_HIGH	0x30a	/* s390 vector registers 16-31 */
+#define NT_S390_GS_CB	0x30b		/* s390 guarded storage registers */
+#define NT_S390_GS_BC	0x30c		/* s390 guarded storage broadcast control block=
 */
+#define NT_S390_RI_CB	0x30d		/* s390 runtime instrumentation */
+#define NT_S390_PV_CPU_DATA	0x30e	/* s390 protvirt cpu dump data */
+#define NT_ARM_VFP	0x400		/* ARM VFP/NEON registers */
+#define NT_ARM_TLS	0x401		/* ARM TLS register */
+#define NT_ARM_HW_BREAK	0x402		/* ARM hardware breakpoint registers */
+#define NT_ARM_HW_WATCH	0x403		/* ARM hardware watchpoint registers */
+#define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
+#define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
+#define NT_ARM_PAC_MASK		0x406	/* ARM pointer authentication code masks */
+#define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
+#define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
+#define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl=
()) */
+#define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl(=
)) */
+#define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
+#define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
+#define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
+#define NT_ARM_FPMR	0x40e		/* ARM floating point mode register */
+#define NT_ARM_POE	0x40f		/* ARM POE registers */
+#define NT_ARM_GCS	0x410		/* ARM GCS state */
+#define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
+#define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
+#define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
+#define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
+#define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
+#define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
+#define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (pr=
ctl()) */
+#define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
+#define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
+#define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension register=
s */
+#define NT_LOONGARCH_LASX	0xa03	/* LoongArch Loongson Advanced SIMD Extensio=
n registers */
+#define NT_LOONGARCH_LBT	0xa04	/* LoongArch Loongson Binary Translation regi=
sters */
+#define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint regis=
ters */
+#define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint regis=
ters */
+
+/* Note types with note name "GNU" */
+#define NT_GNU_PROPERTY_TYPE_0	5
+
+/* Note header in a PT_NOTE section */
+typedef struct elf32_note {
+  Elf32_Word	n_namesz;	/* Name size */
+  Elf32_Word	n_descsz;	/* Content size */
+  Elf32_Word	n_type;		/* Content type */
+} Elf32_Nhdr;
+
+/* Note header in a PT_NOTE section */
+typedef struct elf64_note {
+  Elf64_Word n_namesz;	/* Name size */
+  Elf64_Word n_descsz;	/* Content size */
+  Elf64_Word n_type;	/* Content type */
+} Elf64_Nhdr;
+
+/* .note.gnu.property types for EM_AARCH64: */
+#define GNU_PROPERTY_AARCH64_FEATURE_1_AND	0xc0000000
+
+/* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
+#define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
+
+typedef struct {
+  Elf32_Half	vd_version;
+  Elf32_Half	vd_flags;
+  Elf32_Half	vd_ndx;
+  Elf32_Half	vd_cnt;
+  Elf32_Word	vd_hash;
+  Elf32_Word	vd_aux;
+  Elf32_Word	vd_next;
+} Elf32_Verdef;
+
+typedef struct {
+  Elf64_Half	vd_version;
+  Elf64_Half	vd_flags;
+  Elf64_Half	vd_ndx;
+  Elf64_Half	vd_cnt;
+  Elf64_Word	vd_hash;
+  Elf64_Word	vd_aux;
+  Elf64_Word	vd_next;
+} Elf64_Verdef;
+
+typedef struct {
+  Elf32_Word    vda_name;
+  Elf32_Word    vda_next;
+} Elf32_Verdaux;
+
+typedef struct {
+  Elf64_Word    vda_name;
+  Elf64_Word    vda_next;
+} Elf64_Verdaux;
+
+#endif /* _LINUX_ELF_H */
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be8..530390033929 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -228,4 +228,7 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
=20
-.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
+headers:
+	$(Q)$(MAKE) -C $(top_srcdir) headers
+
+.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir h=
eaders
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/=
vDSO/Makefile
index 1cf14a8da438..12a0614b9fd4 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -19,13 +19,20 @@ LDLIBS +=3D -lgcc_s
 endif
=20
 include ../lib.mk
+
+CFLAGS +=3D $(TOOLS_INCLUDES)
+
+CFLAGS_NOLIBC :=3D -nostdlib -nostdinc -ffreestanding -fno-asynchronous-unwi=
nd-tables \
+		 -fno-stack-protector -include $(top_srcdir)/tools/include/nolibc/nolibc.h=
 \
+		 -I$(top_srcdir)/tools/include/nolibc/ $(KHDR_INCLUDES)
+
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
 $(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
=20
-$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
-$(OUTPUT)/vdso_standalone_test_x86: CFLAGS +=3D-nostdlib -fno-asynchronous-u=
nwind-tables -fno-stack-protector
+$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c =
| headers
+$(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=3D$(CFLAGS_NOLIBC) $(CFLAGS)
=20
 $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
 $(OUTPUT)/vdso_test_correctness: LDFLAGS +=3D -ldl
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selfte=
sts/vDSO/parse_vdso.c
index 2fe5e983cb22..902b8f9984a1 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -19,13 +19,14 @@
 #include <stdint.h>
 #include <string.h>
 #include <limits.h>
-#include <elf.h>
+#include <linux/auxvec.h>
+#include <linux/elf.h>
=20
 #include "parse_vdso.h"
=20
 /* And here's the code. */
 #ifndef ELF_BITS
-# if ULONG_MAX > 0xffffffffUL
+# if __SIZEOF_LONG__ >=3D 8
 #  define ELF_BITS 64
 # else
 #  define ELF_BITS 32
@@ -297,17 +298,3 @@ void *vdso_sym(const char *version, const char *name)
=20
 	return 0;
 }
-
-void vdso_init_from_auxv(void *auxv)
-{
-	ELF(auxv_t) *elf_auxv =3D auxv;
-	for (int i =3D 0; elf_auxv[i].a_type !=3D AT_NULL; i++)
-	{
-		if (elf_auxv[i].a_type =3D=3D AT_SYSINFO_EHDR) {
-			vdso_init_from_sysinfo_ehdr(elf_auxv[i].a_un.a_val);
-			return;
-		}
-	}
-
-	vdso_info.valid =3D false;
-}
diff --git a/tools/testing/selftests/vDSO/parse_vdso.h b/tools/testing/selfte=
sts/vDSO/parse_vdso.h
index de0453067d7c..09d068ed11f9 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.h
+++ b/tools/testing/selftests/vDSO/parse_vdso.h
@@ -26,6 +26,5 @@
  */
 void *vdso_sym(const char *version, const char *name);
 void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-void vdso_init_from_auxv(void *auxv);
=20
 #endif
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/=
testing/selftests/vDSO/vdso_standalone_test_x86.c
index 644915862af8..9ce795b806f0 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -1,142 +1,58 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * vdso_test.c: Sample code to test parse_vdso.c on x86
- * Copyright (c) 2011-2014 Andy Lutomirski
+ * vdso_test_gettimeofday.c: Sample code to test parse_vdso.c and
+ *                           vDSO gettimeofday()
+ * Copyright (c) 2014 Andy Lutomirski
  *
- * You can amuse yourself by compiling with:
- * gcc -std=3Dgnu99 -nostdlib
- *     -Os -fno-asynchronous-unwind-tables -flto -lgcc_s
- *      vdso_standalone_test_x86.c parse_vdso.c
- * to generate a small binary.  On x86_64, you can omit -lgcc_s
- * if you want the binary to be completely standalone.
+ * Compile with:
+ * gcc -std=3Dgnu99 vdso_test_gettimeofday.c parse_vdso_gettimeofday.c
+ *
+ * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, to=
o.
  */
=20
-#include <sys/syscall.h>
+#include <stdio.h>
+#ifndef NOLIBC
+#include <sys/auxv.h>
 #include <sys/time.h>
-#include <unistd.h>
-#include <stdint.h>
-
-#include "parse_vdso.h"
-
-/* We need some libc functions... */
-int strcmp(const char *a, const char *b)
-{
-	/* This implementation is buggy: it never returns -1. */
-	while (*a || *b) {
-		if (*a !=3D *b)
-			return 1;
-		if (*a =3D=3D 0 || *b =3D=3D 0)
-			return 1;
-		a++;
-		b++;
-	}
-
-	return 0;
-}
-
-/*
- * The clang build needs this, although gcc does not.
- * Stolen from lib/string.c.
- */
-void *memcpy(void *dest, const void *src, size_t count)
-{
-	char *tmp =3D dest;
-	const char *s =3D src;
-
-	while (count--)
-		*tmp++ =3D *s++;
-	return dest;
-}
-
-/* ...and two syscalls.  This is x86-specific. */
-static inline long x86_syscall3(long nr, long a0, long a1, long a2)
-{
-	long ret;
-#ifdef __x86_64__
-	asm volatile ("syscall" : "=3Da" (ret) : "a" (nr),
-		      "D" (a0), "S" (a1), "d" (a2) :
-		      "cc", "memory", "rcx",
-		      "r8", "r9", "r10", "r11" );
-#else
-	asm volatile ("int $0x80" : "=3Da" (ret) : "a" (nr),
-		      "b" (a0), "c" (a1), "d" (a2) :
-		      "cc", "memory" );
 #endif
-	return ret;
-}
=20
-static inline long linux_write(int fd, const void *data, size_t len)
-{
-	return x86_syscall3(__NR_write, fd, (long)data, (long)len);
-}
+#include "../kselftest.h"
+#include "parse_vdso.h"
+#include "vdso_config.h"
+#include "vdso_call.h"
=20
-static inline void linux_exit(int code)
+int main(int argc, char **argv)
 {
-	x86_syscall3(__NR_exit, code, 0, 0);
-}
+	const char *version =3D versions[VDSO_VERSION];
+	const char **name =3D (const char **)&names[VDSO_NAMES];
=20
-void to_base10(char *lastdig, time_t n)
-{
-	while (n) {
-		*lastdig =3D (n % 10) + '0';
-		n /=3D 10;
-		lastdig--;
+	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		return KSFT_SKIP;
 	}
-}
-
-void c_main(void **stack)
-{
-	/* Parse the stack */
-	long argc =3D (long)*stack;
-	stack +=3D argc + 2;
-
-	/* Now we're pointing at the environment.  Skip it. */
-	while(*stack)
-		stack++;
-	stack++;
=20
-	/* Now we're pointing at auxv.  Initialize the vDSO parser. */
-	vdso_init_from_auxv((void *)stack);
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
=20
 	/* Find gettimeofday. */
 	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-	gtod_t gtod =3D (gtod_t)vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
+	gtod_t gtod =3D (gtod_t)vdso_sym(version, name[0]);
=20
-	if (!gtod)
-		linux_exit(1);
+	if (!gtod) {
+		printf("Could not find %s\n", name[0]);
+		return KSFT_SKIP;
+	}
=20
 	struct timeval tv;
-	long ret =3D gtod(&tv, 0);
+	long ret =3D VDSO_CALL(gtod, 2, &tv, 0);
=20
 	if (ret =3D=3D 0) {
-		char buf[] =3D "The time is                     .000000\n";
-		to_base10(buf + 31, tv.tv_sec);
-		to_base10(buf + 38, tv.tv_usec);
-		linux_write(1, buf, sizeof(buf) - 1);
+		printf("The time is %lld.%06lld\n",
+		       (long long)tv.tv_sec, (long long)tv.tv_usec);
 	} else {
-		linux_exit(ret);
+		printf("%s failed\n", name[0]);
+		return KSFT_FAIL;
 	}
=20
-	linux_exit(0);
+	return 0;
 }
-
-/*
- * This is the real entry point.  It passes the initial stack into
- * the C entry point.
- */
-asm (
-	".text\n"
-	".global _start\n"
-	".type _start,@function\n"
-	"_start:\n\t"
-#ifdef __x86_64__
-	"mov %rsp,%rdi\n\t"
-	"and $-16,%rsp\n\t"
-	"sub $8,%rsp\n\t"
-	"jmp c_main"
-#else
-	"push %esp\n\t"
-	"call c_main\n\t"
-	"int $3"
-#endif
-	);
diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/te=
sting/selftests/vDSO/vdso_test_gettimeofday.c
index e31b18ffae33..9ce795b806f0 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -10,11 +10,11 @@
  * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, to=
o.
  */
=20
-#include <stdint.h>
-#include <elf.h>
 #include <stdio.h>
+#ifndef NOLIBC
 #include <sys/auxv.h>
 #include <sys/time.h>
+#endif
=20
 #include "../kselftest.h"
 #include "parse_vdso.h"



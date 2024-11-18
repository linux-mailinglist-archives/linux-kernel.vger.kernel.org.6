Return-Path: <linux-kernel+bounces-413417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C029D18C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE005282A44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9801E2833;
	Mon, 18 Nov 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4p/1bufy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GCd/kkw0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E41E1301
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957734; cv=none; b=W28DLOx6OgjND0SWJCbSFJtFFCmF73/f6bmtmyaxarI+9W0dhOrxvtUkEHJyg+7rCeanN569o+Bo5ztOIgpktBOvzmMZ4VfkJ1m2iNbKM356RAnGnZYmhiA079MWK86KzrO0y14GNZsHQa6xASZ5QlCqFMr9cBO80TjkPwuXne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957734; c=relaxed/simple;
	bh=wzLUiGFEyMpaSiBRxUyLW9Yo+BlpFx0I3eSTGRbzwdU=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=RkNTIHKHE2vMftBFbxWpMHvQaFysF9rwqE5vyLWBadImLppuBdjs+TD2X2BOpdHLZu0ao0bZHxCtgS8+OSwiEjg+wUE6yo4lZyHvn4n2VjxGScyF1lvYPtyznh1H5MuaUqUEDavH1cnYdObsQTEg7NmsJamIHgN1woDrDTRUYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4p/1bufy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GCd/kkw0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731957726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=idEJ3wT1rWa0I3nVOvxFMoXq0qDWcLvs6BI70jz77JA=;
	b=4p/1bufynCK96LHrt4zlGX0xMfSJkT3fNOKMCgKQYO1IKMFZNt/gNzqPAFcYcLRYdGmhgX
	n0xB164pJI8yP7XwhOxQGAhPGxBLkwnJq0il/wvZF5TGFBkInkq6BQGA7wUZOGMNwP1CUo
	d3cuVtzJAE954CKjGlEVAxlTU4isatkOHJ9V3pqp8Z7XEdGyv5+JLRx4NaTGEde6vfS2Dd
	lOi5gHvc5E0byoYu7FMbzvkVA6w7lPV3hh7cmnz/oRPHfz1KhwC5LJHp/62EEsaPPbOThc
	RY+zhBgHEsR1pIUdF9QwMpS3lcEYS83A/VGRylaeY3Y+bdaub3GQNfumlRl6fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731957726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=idEJ3wT1rWa0I3nVOvxFMoXq0qDWcLvs6BI70jz77JA=;
	b=GCd/kkw0REFOZtKldNtUQJUXu3VJMeQ0G5pYv1PVSHGXszHMQKV++j3FUHaNgmHb5+0ZyI
	cZq6eCtiJqyQrmAg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/vdso for v6.13-rc1
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
Message-ID: <173195758949.1896928.8792221019523581466.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 20:22:02 +0100 (CET)

Linus,

please pull the latest timers/vdso branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2024=
-11-18

up to:  7fa3c36ea270: x86/vdso: Add missing brackets in switch case


First step of consolidating the VDSO data page handling:

  The VDSO data page handling is architecture specific for historical
  reasons, but there is no real technical reason to do so.

  Aside of that VDSO data has become a dump ground for various mechanisms
  and fail to provide a clear separation of the functionalities.

  Clean this up by:

    * consolidating the VDSO page data by getting rid of architecture
      specific warts especially in x86 and PowerPC.

    * removing the last includes of header files which are pulling in other
      headers outside of the VDSO namespace.

    * seperating timekeeping and other VDSO data accordingly.

  Further consolidation of the VDSO page handling is done in subsequent
  changes scheduled for the next merge window.

  This also lays the ground for expanding the VDSO time getters for
  independent PTP clocks in a generic way without making every architecture
  add support seperately.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      vdso: Change PAGE_MASK to signed on all 32-bit architectures

Nam Cao (1):
      vdso: Rename struct arch_vdso_data to arch_vdso_time_data

Thomas Gleixner (1):
      x86/vdso: Add missing brackets in switch case

Thomas Wei=C3=9Fschuh (36):
      vdso: Remove timekeeper argument of __arch_update_vsyscall()
      arm: vdso: Remove timekeeper includes
      arm64: vdso: Remove timekeeper include
      powerpc/vdso: Remove timekeeper includes
      riscv: vdso: Remove timekeeper include
      s390/vdso: Remove timekeeper includes
      x86/vdso: Remove timekeeper include
      LoongArch: vdso: Remove timekeeper includes
      MIPS: vdso: Remove timekeeper includes
      csky/vdso: Remove gettimeofday() and friends from VDSO
      csky/vdso: Remove arch_vma_name()
      s390/vdso: Drop LBASE_VDSO
      arm64: vdso: Drop LBASE_VDSO
      arm64: vdso: Use only one single vvar mapping
      riscv: vdso: Use only one single vvar mapping
      ARM: vdso: Remove assembly for datapage access
      LoongArch: vDSO: Use vdso/datapage.h to access vDSO data
      MIPS: vdso: Avoid name conflict around "vdso_data"
      x86/mm/mmap: Remove arch_vma_name()
      x86/vdso: Use __arch_get_vdso_data() to access vdso data
      x86/vdso: Place vdso_data at beginning of vvar page
      x86/vdso: Access rng data from kernel without vvar
      x86/vdso: Allocate vvar page from C code
      x86/vdso: Access timens vdso data without vvar.h
      x86/vdso: Access rng vdso data without vvar.h
      x86/vdso: Move the rng offset to vsyscall.h
      x86/vdso: Access vdso data without vvar.h
      x86/vdso: Delete vvar.h
      x86/vdso: Split virtual clock pages into dedicated mapping
      powerpc/vdso: Remove offset comment from 32bit vdso_arch_data
      powerpc/procfs: Propagate error of remap_pfn_range()
      powerpc/pseries/lparcfg: Fix printing of system_active_processors
      powerpc/pseries/lparcfg: Use num_possible_cpus() for potential processo=
rs
      powerpc: Add kconfig option for the systemcfg page
      powerpc: Split systemcfg data out of vdso data page
      powerpc: Split systemcfg struct definitions out from vdso

Vincenzo Frascino (3):
      drm: i915: Change fault type to unsigned long
      vdso: Introduce vdso/page.h
      s390: Remove remaining _PAGE_* macros


 arch/Kconfig                                       |   2 +-
 arch/alpha/include/asm/page.h                      |   6 +-
 arch/arc/include/uapi/asm/page.h                   |   7 +-
 arch/arm/include/asm/page.h                        |   5 +-
 arch/arm/include/asm/vdso/gettimeofday.h           |   4 +-
 arch/arm/include/asm/vdso/vsyscall.h               |   4 -
 arch/arm/kernel/vdso.c                             |   1 -
 arch/arm/vdso/Makefile                             |   2 +-
 arch/arm/vdso/datapage.S                           |  16 ---
 arch/arm/vdso/vdso.lds.S                           |   3 +-
 arch/arm64/include/asm/page-def.h                  |   5 +-
 arch/arm64/include/asm/vdso.h                      |   9 +-
 arch/arm64/include/asm/vdso/vsyscall.h             |   3 +-
 arch/arm64/kernel/vdso.c                           |  44 +++-----
 arch/arm64/kernel/vdso/vdso.lds.S                  |   2 +-
 arch/arm64/kernel/vdso32/vdso.lds.S                |   2 +-
 arch/csky/Kconfig                                  |   4 -
 arch/csky/include/asm/page.h                       |   8 +-
 arch/csky/include/asm/vdso/clocksource.h           |   9 --
 arch/csky/include/asm/vdso/gettimeofday.h          | 114 -------------------=
--
 arch/csky/include/asm/vdso/processor.h             |  12 ---
 arch/csky/include/asm/vdso/vsyscall.h              |  22 ----
 arch/csky/kernel/vdso.c                            |  31 +-----
 arch/csky/kernel/vdso/Makefile                     |   1 -
 arch/csky/kernel/vdso/vdso.lds.S                   |   4 -
 arch/csky/kernel/vdso/vgettimeofday.c              |  30 ------
 arch/hexagon/include/asm/page.h                    |   4 +-
 arch/loongarch/include/asm/page.h                  |   7 +-
 arch/loongarch/include/asm/vdso/getrandom.h        |   3 +-
 arch/loongarch/include/asm/vdso/gettimeofday.h     |   4 +-
 arch/loongarch/include/asm/vdso/vdso.h             |  18 +---
 arch/loongarch/include/asm/vdso/vsyscall.h         |   4 -
 arch/loongarch/kernel/asm-offsets.c                |   9 ++
 arch/loongarch/kernel/vdso.c                       |   1 -
 arch/loongarch/vdso/vdso.lds.S                     |   8 +-
 arch/loongarch/vdso/vgetcpu.c                      |   2 +-
 arch/m68k/include/asm/page.h                       |   6 +-
 arch/microblaze/include/asm/page.h                 |   5 +-
 arch/mips/include/asm/page.h                       |   7 +-
 arch/mips/include/asm/vdso/vsyscall.h              |   1 -
 arch/mips/kernel/vdso.c                            |   1 -
 arch/mips/vdso/genvdso.c                           |   4 +-
 arch/nios2/include/asm/page.h                      |   7 +-
 arch/openrisc/include/asm/page.h                   |  11 +-
 arch/parisc/include/asm/page.h                     |   4 +-
 arch/powerpc/Kconfig                               |   8 ++
 arch/powerpc/include/asm/page.h                    |  10 +-
 arch/powerpc/include/asm/systemcfg.h               |  52 ++++++++++
 arch/powerpc/include/asm/vdso/vsyscall.h           |   4 -
 arch/powerpc/include/asm/vdso_datapage.h           |  61 +----------
 arch/powerpc/kernel/proc_powerpc.c                 |  37 +++++--
 arch/powerpc/kernel/setup-common.c                 |   5 +-
 arch/powerpc/kernel/smp.c                          |  11 +-
 arch/powerpc/kernel/time.c                         |   5 +-
 arch/powerpc/kernel/vdso.c                         |  20 ----
 arch/powerpc/platforms/powernv/smp.c               |   5 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   5 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   5 +-
 arch/riscv/Kconfig                                 |   2 +-
 arch/riscv/include/asm/page.h                      |   4 +-
 .../riscv/include/asm/vdso/{data.h =3D> time_data.h} |   8 +-
 arch/riscv/include/asm/vdso/vsyscall.h             |   4 -
 arch/riscv/kernel/sys_hwprobe.c                    |   2 +-
 arch/riscv/kernel/vdso.c                           |  52 +++-------
 arch/riscv/kernel/vdso/hwprobe.c                   |   4 +-
 arch/s390/Kconfig                                  |   2 +-
 arch/s390/include/asm/page.h                       |  10 +-
 arch/s390/include/asm/pgtable.h                    |   2 +-
 arch/s390/include/asm/vdso.h                       |   3 -
 arch/s390/include/asm/vdso/data.h                  |  12 ---
 arch/s390/include/asm/vdso/time_data.h             |  12 +++
 arch/s390/include/asm/vdso/vsyscall.h              |   5 -
 arch/s390/kernel/time.c                            |   1 -
 arch/s390/kernel/vdso32/vdso32.lds.S               |   2 +-
 arch/s390/kernel/vdso64/vdso64.lds.S               |   2 +-
 arch/s390/mm/fault.c                               |   2 +-
 arch/s390/mm/gmap.c                                |   6 +-
 arch/s390/mm/pgalloc.c                             |   4 +-
 arch/sh/include/asm/page.h                         |   6 +-
 arch/sparc/include/asm/page_32.h                   |   4 +-
 arch/sparc/include/asm/page_64.h                   |   4 +-
 arch/um/include/asm/page.h                         |   5 +-
 arch/x86/entry/vdso/vdso-layout.lds.S              |  20 ++--
 arch/x86/entry/vdso/vma.c                          |  92 +++++++++++------
 arch/x86/include/asm/page_types.h                  |   5 +-
 arch/x86/include/asm/vdso/getrandom.h              |  10 +-
 arch/x86/include/asm/vdso/gettimeofday.h           |  12 ++-
 arch/x86/include/asm/vdso/vsyscall.h               |  15 ++-
 arch/x86/include/asm/vvar.h                        |  71 -------------
 arch/x86/kernel/vmlinux.lds.S                      |  23 -----
 arch/x86/mm/mmap.c                                 |   5 -
 arch/x86/tools/relocs.c                            |   1 -
 arch/xtensa/include/asm/page.h                     |   8 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   6 +-
 include/asm-generic/vdso/vsyscall.h                |   3 +-
 include/vdso/datapage.h                            |   8 +-
 include/vdso/page.h                                |  31 ++++++
 kernel/time/vsyscall.c                             |   2 +-
 98 files changed, 372 insertions(+), 782 deletions(-)
 delete mode 100644 arch/arm/vdso/datapage.S
 delete mode 100644 arch/csky/include/asm/vdso/clocksource.h
 delete mode 100644 arch/csky/include/asm/vdso/gettimeofday.h
 delete mode 100644 arch/csky/include/asm/vdso/processor.h
 delete mode 100644 arch/csky/include/asm/vdso/vsyscall.h
 delete mode 100644 arch/csky/kernel/vdso/vgettimeofday.c
 create mode 100644 arch/powerpc/include/asm/systemcfg.h
 rename arch/riscv/include/asm/vdso/{data.h =3D> time_data.h} (71%)
 delete mode 100644 arch/s390/include/asm/vdso/data.h
 create mode 100644 arch/s390/include/asm/vdso/time_data.h
 delete mode 100644 arch/x86/include/asm/vvar.h
 create mode 100644 include/vdso/page.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 8af374ea1adc..7f1ec327b587 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1530,7 +1530,7 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
=20
-config ARCH_HAS_VDSO_DATA
+config ARCH_HAS_VDSO_TIME_DATA
 	bool
=20
 config HAVE_STATIC_CALL
diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index 70419e6be1a3..261af54fd601 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -4,11 +4,7 @@
=20
 #include <linux/const.h>
 #include <asm/pal.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 #ifndef __ASSEMBLY__
=20
diff --git a/arch/arc/include/uapi/asm/page.h b/arch/arc/include/uapi/asm/pag=
e.h
index 7fd9e741b527..4606a326af5c 100644
--- a/arch/arc/include/uapi/asm/page.h
+++ b/arch/arc/include/uapi/asm/page.h
@@ -14,7 +14,7 @@
=20
 /* PAGE_SHIFT determines the page size */
 #ifdef __KERNEL__
-#define PAGE_SHIFT CONFIG_PAGE_SHIFT
+#include <vdso/page.h>
 #else
 /*
  * Default 8k
@@ -24,11 +24,10 @@
  * not available
  */
 #define PAGE_SHIFT 13
+#define PAGE_SIZE	_BITUL(PAGE_SHIFT)	/* Default 8K */
+#define PAGE_MASK	(~(PAGE_SIZE-1))
 #endif
=20
-#define PAGE_SIZE	_BITUL(PAGE_SHIFT)	/* Default 8K */
 #define PAGE_OFFSET	_AC(0x80000000, UL)	/* Kernel starts at 2G onwrds */
=20
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
 #endif /* _UAPI__ASM_ARC_PAGE_H */
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 62af9f7f9e96..ef11b721230e 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -7,10 +7,7 @@
 #ifndef _ASMARM_PAGE_H
 #define _ASMARM_PAGE_H
=20
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~((1 << PAGE_SHIFT) - 1))
+#include <vdso/page.h>
=20
 #ifndef __ASSEMBLY__
=20
diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/=
vdso/gettimeofday.h
index 2134cbd5469f..592d3d015ca7 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -15,8 +15,6 @@
=20
 #define VDSO_HAS_CLOCK_GETRES		1
=20
-extern struct vdso_data *__get_datapage(void);
-
 static __always_inline int gettimeofday_fallback(
 				struct __kernel_old_timeval *_tv,
 				struct timezone *_tz)
@@ -139,7 +137,7 @@ static __always_inline u64 __arch_get_hw_counter(int cloc=
k_mode,
=20
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return __get_datapage();
+	return _vdso_data;
 }
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso=
/vsyscall.h
index 47e41ae8ccd0..705414710dcd 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -4,16 +4,12 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
=20
 extern struct vdso_data *vdso_data;
 extern bool cntvct_ok;
=20
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline
 struct vdso_data *__arm_get_k_vdso_data(void)
 {
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index d499ad461b00..29dd2f3c62fe 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -14,7 +14,6 @@
 #include <linux/of.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
-#include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
 #include <asm/arch_timer.h>
 #include <asm/barrier.h>
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 01067a2bc43b..8a306bbec4a0 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -5,7 +5,7 @@ include $(srctree)/lib/vdso/Makefile
=20
 hostprogs :=3D vdsomunge
=20
-obj-vdso :=3D vgettimeofday.o datapage.o note.o
+obj-vdso :=3D vgettimeofday.o note.o
=20
 # Build rules
 targets :=3D $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
diff --git a/arch/arm/vdso/datapage.S b/arch/arm/vdso/datapage.S
deleted file mode 100644
index 9cd73b725d9f..000000000000
--- a/arch/arm/vdso/datapage.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-
-	.align 2
-.L_vdso_data_ptr:
-	.long	_start - . - VDSO_DATA_SIZE
-
-ENTRY(__get_datapage)
-	.fnstart
-	adr	r0, .L_vdso_data_ptr
-	ldr	r1, [r0]
-	add	r0, r0, r1
-	bx	lr
-	.fnend
-ENDPROC(__get_datapage)
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 165d1d2eb76b..9bfa0f52923c 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -11,6 +11,7 @@
  */
=20
 #include <linux/const.h>
+#include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
=20
@@ -19,7 +20,7 @@ OUTPUT_ARCH(arm)
=20
 SECTIONS
 {
-	PROVIDE(_start =3D .);
+	PROVIDE(_vdso_data =3D . - VDSO_DATA_SIZE);
=20
 	. =3D SIZEOF_HEADERS;
=20
diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-=
def.h
index 792e9fe881dc..d402e08442ee 100644
--- a/arch/arm64/include/asm/page-def.h
+++ b/arch/arm64/include/asm/page-def.h
@@ -10,9 +10,6 @@
=20
 #include <linux/const.h>
=20
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 #endif /* __ASM_PAGE_DEF_H */
diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 4305995c8f82..3e3c3fdb1842 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -5,13 +5,6 @@
 #ifndef __ASM_VDSO_H
 #define __ASM_VDSO_H
=20
-/*
- * Default link address for the vDSO.
- * Since we randomise the VDSO mapping, there's little point in trying
- * to prelink this.
- */
-#define VDSO_LBASE	0x0
-
 #define __VVAR_PAGES    2
=20
 #ifndef __ASSEMBLY__
@@ -20,7 +13,7 @@
=20
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
-	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
+	(void *)(vdso_offset_##name + (unsigned long)(base)); \
 })
=20
 extern char vdso_start[], vdso_end[];
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/=
vdso/vsyscall.h
index 5b6d0dd3cef5..eea51946d45a 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -6,7 +6,6 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
=20
 enum vvar_pages {
@@ -37,7 +36,7 @@ struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
 #define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
=20
 static __always_inline
-void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
+void __arm64_update_vsyscall(struct vdso_data *vdata)
 {
 	vdata[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
 	vdata[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 706c9c3a7a50..e8ed8e5b713b 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -19,7 +19,6 @@
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/time_namespace.h>
-#include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
@@ -39,8 +38,6 @@ struct vdso_abi_info {
 	const char *vdso_code_start;
 	const char *vdso_code_end;
 	unsigned long vdso_pages;
-	/* Data Mapping */
-	struct vm_special_mapping *dm;
 	/* Code Mapping */
 	struct vm_special_mapping *cm;
 };
@@ -113,6 +110,8 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 	return (struct vdso_data *)(vvar_page);
 }
=20
+static const struct vm_special_mapping vvar_map;
+
 /*
  * The vvar mapping contains data for a specific time namespace, so when a t=
ask
  * changes namespace we must unmap its vvar data for the old namespace.
@@ -129,12 +128,8 @@ int vdso_join_timens(struct task_struct *task, struct ti=
me_namespace *ns)
 	mmap_read_lock(mm);
=20
 	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
-			zap_vma_pages(vma);
-#ifdef CONFIG_COMPAT_VDSO
-		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA32].dm))
+		if (vma_is_special_mapping(vma, &vvar_map))
 			zap_vma_pages(vma);
-#endif
 	}
=20
 	mmap_read_unlock(mm);
@@ -176,6 +171,11 @@ static vm_fault_t vvar_fault(const struct vm_special_map=
ping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
=20
+static const struct vm_special_mapping vvar_map =3D {
+	.name   =3D "[vvar]",
+	.fault =3D vvar_fault,
+};
+
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -199,7 +199,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
=20
 	ret =3D _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_PFNMAP,
-				       vdso_info[abi].dm);
+				       &vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
=20
@@ -229,7 +229,6 @@ static int __setup_additional_pages(enum vdso_abi abi,
 enum aarch32_map {
 	AA32_MAP_VECTORS, /* kuser helpers */
 	AA32_MAP_SIGPAGE,
-	AA32_MAP_VVAR,
 	AA32_MAP_VDSO,
 };
=20
@@ -254,10 +253,6 @@ static struct vm_special_mapping aarch32_vdso_maps[] =3D=
 {
 		.pages	=3D &aarch32_sig_page,
 		.mremap	=3D aarch32_sigpage_mremap,
 	},
-	[AA32_MAP_VVAR] =3D {
-		.name =3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
 	[AA32_MAP_VDSO] =3D {
 		.name =3D "[vdso]",
 		.mremap =3D vdso_mremap,
@@ -307,7 +302,6 @@ static int __init __aarch32_alloc_vdso_pages(void)
 	if (!IS_ENABLED(CONFIG_COMPAT_VDSO))
 		return 0;
=20
-	vdso_info[VDSO_ABI_AA32].dm =3D &aarch32_vdso_maps[AA32_MAP_VVAR];
 	vdso_info[VDSO_ABI_AA32].cm =3D &aarch32_vdso_maps[AA32_MAP_VDSO];
=20
 	return __vdso_init(VDSO_ABI_AA32);
@@ -402,26 +396,14 @@ int aarch32_setup_additional_pages(struct linux_binprm =
*bprm, int uses_interp)
 }
 #endif /* CONFIG_COMPAT */
=20
-enum aarch64_map {
-	AA64_MAP_VVAR,
-	AA64_MAP_VDSO,
-};
-
-static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init =3D {
-	[AA64_MAP_VVAR] =3D {
-		.name	=3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
-	[AA64_MAP_VDSO] =3D {
-		.name	=3D "[vdso]",
-		.mremap =3D vdso_mremap,
-	},
+static struct vm_special_mapping aarch64_vdso_map __ro_after_init =3D {
+	.name	=3D "[vdso]",
+	.mremap =3D vdso_mremap,
 };
=20
 static int __init vdso_init(void)
 {
-	vdso_info[VDSO_ABI_AA64].dm =3D &aarch64_vdso_maps[AA64_MAP_VVAR];
-	vdso_info[VDSO_ABI_AA64].cm =3D &aarch64_vdso_maps[AA64_MAP_VDSO];
+	vdso_info[VDSO_ABI_AA64].cm =3D &aarch64_vdso_map;
=20
 	return __vdso_init(VDSO_ABI_AA64);
 }
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.=
lds.S
index f204a9ddc833..4ec32e86a8da 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -25,7 +25,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/v=
dso.lds.S
index 8d95d7d35057..732702a187e9 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -22,7 +22,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE_HIDDEN(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 5479707eb5d1..acc431c331b0 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -64,9 +64,6 @@ config CSKY
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_32
-	select GENERIC_GETTIMEOFDAY
 	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
@@ -80,7 +77,6 @@ config CSKY
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
-	select HAVE_GENERIC_VDSO
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 0ca6c408c07f..f8beae295afb 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -7,12 +7,8 @@
 #include <asm/cache.h>
 #include <linux/const.h>
=20
-/*
- * PAGE_SHIFT determines the page size: 4KB
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
+
 #define THREAD_SIZE	(PAGE_SIZE * 2)
 #define THREAD_MASK	(~(THREAD_SIZE - 1))
 #define THREAD_SHIFT	(PAGE_SHIFT + 1)
diff --git a/arch/csky/include/asm/vdso/clocksource.h b/arch/csky/include/asm=
/vdso/clocksource.h
deleted file mode 100644
index dfca7b4724b7..000000000000
--- a/arch/csky/include/asm/vdso/clocksource.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_VDSO_CSKY_CLOCKSOURCE_H
-#define __ASM_VDSO_CSKY_CLOCKSOURCE_H
-
-#define VDSO_ARCH_CLOCKMODES	\
-	VDSO_CLOCKMODE_ARCHTIMER
-
-#endif /* __ASM_VDSO_CSKY_CLOCKSOURCE_H */
diff --git a/arch/csky/include/asm/vdso/gettimeofday.h b/arch/csky/include/as=
m/vdso/gettimeofday.h
deleted file mode 100644
index 6c4f1446944f..000000000000
--- a/arch/csky/include/asm/vdso/gettimeofday.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_VDSO_CSKY_GETTIMEOFDAY_H
-#define __ASM_VDSO_CSKY_GETTIMEOFDAY_H
-
-#ifndef __ASSEMBLY__
-
-#include <asm/barrier.h>
-#include <asm/unistd.h>
-#include <abi/regdef.h>
-#include <uapi/linux/time.h>
-
-#define VDSO_HAS_CLOCK_GETRES	1
-
-static __always_inline
-int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
-			  struct timezone *_tz)
-{
-	register struct __kernel_old_timeval *tv asm("a0") =3D _tv;
-	register struct timezone *tz asm("a1") =3D _tz;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_gettimeofday;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(tv), "r"(tz), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-static __always_inline
-long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
-{
-	register clockid_t clkid asm("a0") =3D _clkid;
-	register struct __kernel_timespec *ts asm("a1") =3D _ts;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_clock_gettime64;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(clkid), "r"(ts), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-static __always_inline
-long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
-{
-	register clockid_t clkid asm("a0") =3D _clkid;
-	register struct old_timespec32 *ts asm("a1") =3D _ts;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_clock_gettime;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(clkid), "r"(ts), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-static __always_inline
-int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
-{
-	register clockid_t clkid asm("a0") =3D _clkid;
-	register struct __kernel_timespec *ts asm("a1") =3D _ts;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_clock_getres_time64;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(clkid), "r"(ts), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-static __always_inline
-int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
-{
-	register clockid_t clkid asm("a0") =3D _clkid;
-	register struct old_timespec32 *ts asm("a1") =3D _ts;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_clock_getres;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(clkid), "r"(ts), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-uint64_t csky_pmu_read_cc(void);
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
-{
-#ifdef CONFIG_CSKY_PMU_V1
-	return csky_pmu_read_cc();
-#else
-	return 0;
-#endif
-}
-
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __ASM_VDSO_CSKY_GETTIMEOFDAY_H */
diff --git a/arch/csky/include/asm/vdso/processor.h b/arch/csky/include/asm/v=
dso/processor.h
deleted file mode 100644
index 39a6b561d0cc..000000000000
--- a/arch/csky/include/asm/vdso/processor.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#ifndef __ASM_VDSO_CSKY_PROCESSOR_H
-#define __ASM_VDSO_CSKY_PROCESSOR_H
-
-#ifndef __ASSEMBLY__
-
-#define cpu_relax()	barrier()
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __ASM_VDSO_CSKY_PROCESSOR_H */
diff --git a/arch/csky/include/asm/vdso/vsyscall.h b/arch/csky/include/asm/vd=
so/vsyscall.h
deleted file mode 100644
index c276211a7c4d..000000000000
--- a/arch/csky/include/asm/vdso/vsyscall.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_VDSO_CSKY_VSYSCALL_H
-#define __ASM_VDSO_CSKY_VSYSCALL_H
-
-#ifndef __ASSEMBLY__
-
-#include <vdso/datapage.h>
-
-extern struct vdso_data *vdso_data;
-
-static __always_inline struct vdso_data *__csky_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __csky_get_k_vdso_data
-
-#include <asm-generic/vdso/vsyscall.h>
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __ASM_VDSO_CSKY_VSYSCALL_H */
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index 5c9ef63c29f1..c54d019d66bc 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -8,23 +8,19 @@
 #include <linux/slab.h>
=20
 #include <asm/page.h>
-#include <vdso/datapage.h>
=20
 extern char vdso_start[], vdso_end[];
=20
 static unsigned int vdso_pages;
 static struct page **vdso_pagelist;
=20
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
-
 static int __init vdso_init(void)
 {
 	unsigned int i;
=20
 	vdso_pages =3D (vdso_end - vdso_start) >> PAGE_SHIFT;
 	vdso_pagelist =3D
-		kcalloc(vdso_pages + 1, sizeof(struct page *), GFP_KERNEL);
+		kcalloc(vdso_pages, sizeof(struct page *), GFP_KERNEL);
 	if (unlikely(vdso_pagelist =3D=3D NULL)) {
 		pr_err("vdso: pagelist allocation failed\n");
 		return -ENOMEM;
@@ -36,7 +32,6 @@ static int __init vdso_init(void)
 		pg =3D virt_to_page(vdso_start + (i << PAGE_SHIFT));
 		vdso_pagelist[i] =3D pg;
 	}
-	vdso_pagelist[i] =3D virt_to_page(vdso_data);
=20
 	return 0;
 }
@@ -52,11 +47,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	static struct vm_special_mapping vdso_mapping =3D {
 		.name =3D "[vdso]",
 	};
-	static struct vm_special_mapping vvar_mapping =3D {
-		.name =3D "[vvar]",
-	};
=20
-	vdso_len =3D (vdso_pages + 1) << PAGE_SHIFT;
+	vdso_len =3D vdso_pages << PAGE_SHIFT;
=20
 	mmap_write_lock(mm);
 	vdso_base =3D get_unmapped_area(NULL, 0, vdso_len, 0, 0);
@@ -85,27 +77,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	}
=20
 	vdso_base +=3D (vdso_pages << PAGE_SHIFT);
-	vvar_mapping.pages =3D &vdso_pagelist[vdso_pages];
-	vma =3D _install_special_mapping(mm, vdso_base, PAGE_SIZE,
-		(VM_READ | VM_MAYREAD), &vvar_mapping);
-
-	if (IS_ERR(vma)) {
-		ret =3D PTR_ERR(vma);
-		mm->context.vdso =3D NULL;
-		goto end;
-	}
 	ret =3D 0;
 end:
 	mmap_write_unlock(mm);
 	return ret;
 }
-
-const char *arch_vma_name(struct vm_area_struct *vma)
-{
-	if (vma->vm_mm && (vma->vm_start =3D=3D (long)vma->vm_mm->context.vdso))
-		return "[vdso]";
-	if (vma->vm_mm && (vma->vm_start =3D=3D
-			   (long)vma->vm_mm->context.vdso + PAGE_SIZE))
-		return "[vdso_data]";
-	return NULL;
-}
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index bc2261f5a8d4..069ef0b17fe5 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -5,7 +5,6 @@ include $(srctree)/lib/vdso/Makefile
=20
 # Symbols present in the vdso
 vdso-syms  +=3D rt_sigreturn
-vdso-syms  +=3D vgettimeofday
=20
 # Files to link into the vdso
 obj-vdso =3D $(patsubst %, %.o, $(vdso-syms)) note.o
diff --git a/arch/csky/kernel/vdso/vdso.lds.S b/arch/csky/kernel/vdso/vdso.ld=
s.S
index 590a6c79fff7..8d226252d439 100644
--- a/arch/csky/kernel/vdso/vdso.lds.S
+++ b/arch/csky/kernel/vdso/vdso.lds.S
@@ -49,10 +49,6 @@ VERSION
 	LINUX_5.10 {
 	global:
 		__vdso_rt_sigreturn;
-		__vdso_clock_gettime;
-		__vdso_clock_gettime64;
-		__vdso_gettimeofday;
-		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/csky/kernel/vdso/vgettimeofday.c b/arch/csky/kernel/vdso/vg=
ettimeofday.c
deleted file mode 100644
index 55af30e83752..000000000000
--- a/arch/csky/kernel/vdso/vgettimeofday.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include <linux/time.h>
-#include <linux/types.h>
-#include <vdso/gettime.h>
-
-extern
-int __vdso_clock_gettime(clockid_t clock,
-			 struct old_timespec32 *ts)
-{
-	return __cvdso_clock_gettime32(clock, ts);
-}
-
-int __vdso_clock_gettime64(clockid_t clock,
-			   struct __kernel_timespec *ts)
-{
-	return __cvdso_clock_gettime(clock, ts);
-}
-
-int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
-			struct timezone *tz)
-{
-	return __cvdso_gettimeofday(tv, tz);
-}
-
-int __vdso_clock_getres(clockid_t clock_id,
-			struct old_timespec32 *res)
-{
-	return __cvdso_clock_getres_time32(clock_id, res);
-}
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 8a6af57274c2..b01f8df69dd4 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -45,9 +45,7 @@
 #define HVM_HUGEPAGE_SIZE 0x5
 #endif
=20
-#define PAGE_SHIFT CONFIG_PAGE_SHIFT
-#define PAGE_SIZE  (1UL << PAGE_SHIFT)
-#define PAGE_MASK  (~((1 << PAGE_SHIFT) - 1))
+#include <vdso/page.h>
=20
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/p=
age.h
index e85df33f11c7..83f3533e31a4 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -8,12 +8,7 @@
 #include <linux/const.h>
 #include <asm/addrspace.h>
=20
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
=20
 #define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
 #define HPAGE_SIZE	(_AC(1, UL) << HPAGE_SHIFT)
diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch/inc=
lude/asm/vdso/getrandom.h
index 02f36772541b..e80f3c4ac748 100644
--- a/arch/loongarch/include/asm/vdso/getrandom.h
+++ b/arch/loongarch/include/asm/vdso/getrandom.h
@@ -30,8 +30,7 @@ static __always_inline ssize_t getrandom_syscall(void *_buf=
fer, size_t _len, uns
=20
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
 {
-	return (const struct vdso_rng_data *)(get_vdso_data() + VVAR_LOONGARCH_PAGE=
S_START *
-	       PAGE_SIZE + offsetof(struct loongarch_vdso_data, rng_data));
+	return &_loongarch_data.rng_data;
 }
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/=
include/asm/vdso/gettimeofday.h
index 89e6b222c2f2..7eb3f041af76 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -91,14 +91,14 @@ static inline bool loongarch_vdso_hres_capable(void)
=20
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return (const struct vdso_data *)get_vdso_data();
+	return _vdso_data;
 }
=20
 #ifdef CONFIG_TIME_NS
 static __always_inline
 const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
 {
-	return (const struct vdso_data *)(get_vdso_data() + VVAR_TIMENS_PAGE_OFFSET=
 * PAGE_SIZE);
+	return _timens_data;
 }
 #endif
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/=
asm/vdso/vdso.h
index e31ac7474513..1c183a9b2115 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -48,23 +48,7 @@ enum vvar_pages {
=20
 #define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
=20
-static inline unsigned long get_vdso_base(void)
-{
-	unsigned long addr;
-
-	__asm__(
-	" la.pcrel %0, _start\n"
-	: "=3Dr" (addr)
-	:
-	:);
-
-	return addr;
-}
-
-static inline unsigned long get_vdso_data(void)
-{
-	return get_vdso_base() - VVAR_SIZE;
-}
+extern struct loongarch_vdso_data _loongarch_data __attribute__((visibility(=
"hidden")));
=20
 #endif /* __ASSEMBLY__ */
=20
diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/incl=
ude/asm/vdso/vsyscall.h
index b1273ce6f140..8987e951d0a9 100644
--- a/arch/loongarch/include/asm/vdso/vsyscall.h
+++ b/arch/loongarch/include/asm/vdso/vsyscall.h
@@ -4,15 +4,11 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
=20
 extern struct vdso_data *vdso_data;
 extern struct vdso_rng_data *vdso_rng_data;
=20
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline
 struct vdso_data *__loongarch_get_k_vdso_data(void)
 {
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-=
offsets.c
index bee9f7a3108f..049c5c3e370c 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -14,6 +14,7 @@
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/ftrace.h>
+#include <vdso/datapage.h>
=20
 static void __used output_ptreg_defines(void)
 {
@@ -321,3 +322,11 @@ static void __used output_kvm_defines(void)
 	OFFSET(KVM_GPGD, kvm, arch.pgd);
 	BLANK();
 }
+
+static void __used output_vdso_defines(void)
+{
+	COMMENT("LoongArch vDSO offsets.");
+
+	DEFINE(__VVAR_PAGES, VVAR_NR_PAGES);
+	BLANK();
+}
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index f6fcc52aefae..4d7cb9425dc3 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/time_namespace.h>
-#include <linux/timekeeper_internal.h>
=20
 #include <asm/page.h>
 #include <asm/vdso.h>
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
index 6b441bde4026..160cfaef2de4 100644
--- a/arch/loongarch/vdso/vdso.lds.S
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -3,6 +3,8 @@
  * Author: Huacai Chen <chenhuacai@loongson.cn>
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include <asm/page.h>
+#include <generated/asm-offsets.h>
=20
 OUTPUT_FORMAT("elf64-loongarch", "elf64-loongarch", "elf64-loongarch")
=20
@@ -10,7 +12,11 @@ OUTPUT_ARCH(loongarch)
=20
 SECTIONS
 {
-	PROVIDE(_start =3D .);
+	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
+#ifdef CONFIG_TIME_NS
+	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
+#endif
+	PROVIDE(_loongarch_data =3D _vdso_data + 2 * PAGE_SIZE);
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 9e445be39763..0db51258b2a7 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -21,7 +21,7 @@ static __always_inline int read_cpu_id(void)
=20
 static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
 {
-	return (struct vdso_pcpu_data *)(get_vdso_data() + VVAR_LOONGARCH_PAGES_STA=
RT * PAGE_SIZE);
+	return _loongarch_data.pdata;
 }
=20
 extern
diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 8cfb84b49975..b173ba27d36f 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -6,10 +6,8 @@
 #include <asm/setup.h>
 #include <asm/page_offset.h>
=20
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
+
 #define PAGE_OFFSET	(PAGE_OFFSET_RAW)
=20
 #ifndef __ASSEMBLY__
diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm=
/page.h
index 8810f4f1c3b0..d1ec3806edab 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -19,10 +19,7 @@
=20
 #ifdef __KERNEL__
=20
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 #define LOAD_OFFSET	ASM_CONST((CONFIG_KERNEL_START-CONFIG_KERNEL_BASE_ADDR))
=20
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 4609cb0326cf..bc3e3484c1bf 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -14,12 +14,7 @@
 #include <linux/kernel.h>
 #include <asm/mipsregs.h>
=20
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
+#include <vdso/page.h>
=20
 /*
  * This is used for calculating the real page sizes
diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vd=
so/vsyscall.h
index 47168aaf1eff..a4582870aaea 100644
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -4,7 +4,6 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
=20
 extern struct vdso_data *vdso_data;
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index dda36fa26307..4c8e3c0aa210 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -14,7 +14,6 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/timekeeper_internal.h>
=20
 #include <asm/abi.h>
 #include <asm/mips-cps.h>
diff --git a/arch/mips/vdso/genvdso.c b/arch/mips/vdso/genvdso.c
index 09e30eb4be86..d47412ea6e67 100644
--- a/arch/mips/vdso/genvdso.c
+++ b/arch/mips/vdso/genvdso.c
@@ -270,7 +270,7 @@ int main(int argc, char **argv)
=20
 	/* Write out the stripped VDSO data. */
 	fprintf(out_file,
-		"static unsigned char vdso_data[PAGE_ALIGN(%zu)] __page_aligned_data =3D {=
\n\t",
+		"static unsigned char vdso_image_data[PAGE_ALIGN(%zu)] __page_aligned_data=
 =3D {\n\t",
 		vdso_size);
 	for (i =3D 0; i < vdso_size; i++) {
 		if (!(i % 10))
@@ -286,7 +286,7 @@ int main(int argc, char **argv)
=20
 	fprintf(out_file, "struct mips_vdso_image vdso_image%s%s =3D {\n",
 		(vdso_name[0]) ? "_" : "", vdso_name);
-	fprintf(out_file, "\t.data =3D vdso_data,\n");
+	fprintf(out_file, "\t.data =3D vdso_image_data,\n");
 	fprintf(out_file, "\t.size =3D PAGE_ALIGN(%zu),\n", vdso_size);
 	fprintf(out_file, "\t.mapping =3D {\n");
 	fprintf(out_file, "\t\t.name =3D \"[vdso]\",\n");
diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
index 0722f88e63cc..2897ec1b74f6 100644
--- a/arch/nios2/include/asm/page.h
+++ b/arch/nios2/include/asm/page.h
@@ -18,12 +18,7 @@
 #include <linux/pfn.h>
 #include <linux/const.h>
=20
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
=20
 /*
  * PAGE_OFFSET -- the first address of the first page of memory.
diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/pag=
e.h
index 1d5913f67c31..124a2db4b160 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -15,16 +15,7 @@
 #ifndef __ASM_OPENRISC_PAGE_H
 #define __ASM_OPENRISC_PAGE_H
=20
-
-/* PAGE_SHIFT determines the page size */
-
-#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE       (1 << PAGE_SHIFT)
-#else
-#define PAGE_SIZE       (1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK       (~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 #define PAGE_OFFSET	0xc0000000
 #define KERNELBASE	PAGE_OFFSET
diff --git a/arch/parisc/include/asm/page.h b/arch/parisc/include/asm/page.h
index 4bea2e95798f..6c4836fb5407 100644
--- a/arch/parisc/include/asm/page.h
+++ b/arch/parisc/include/asm/page.h
@@ -4,9 +4,7 @@
=20
 #include <linux/const.h>
=20
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
=20
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8094a01974cc..5d348e1f09d7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1298,6 +1298,14 @@ config MODULES_SIZE
=20
 endmenu
=20
+config PPC64_PROC_SYSTEMCFG
+	def_bool y
+	depends on PPC64 && PROC_FS
+	help
+	  This option enables the presence of /proc/ppc64/systemcfg through
+	  which the systemcfg page can be accessed.
+	  This interface only exists for backwards-compatibility.
+
 if PPC64
 # This value must have zeroes in the bottom 60 bits otherwise lots will break
 config PAGE_OFFSET
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 83d0a4fc5f75..af9a2628d1df 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -21,8 +21,7 @@
  * page size. When using 64K pages however, whether we are really supporting
  * 64K pages in HW or not is irrelevant to those definitions.
  */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(ASM_CONST(1) << PAGE_SHIFT)
+#include <vdso/page.h>
=20
 #ifndef __ASSEMBLY__
 #ifndef CONFIG_HUGETLB_PAGE
@@ -41,13 +40,6 @@ extern unsigned int hpage_shift;
 #define HUGE_MAX_HSTATE		(MMU_PAGE_COUNT-1)
 #endif
=20
-/*
- * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
- * assign PAGE_MASK to a larger type it gets extended the way we want
- * (i.e. with 1s in the high bits)
- */
-#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
-
 /*
  * KERNELBASE is the virtual address of the start of the kernel, it's often
  * the same as PAGE_OFFSET, but _might not be_.
diff --git a/arch/powerpc/include/asm/systemcfg.h b/arch/powerpc/include/asm/=
systemcfg.h
new file mode 100644
index 000000000000..2f9b1d6a5c98
--- /dev/null
+++ b/arch/powerpc/include/asm/systemcfg.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _SYSTEMCFG_H
+#define _SYSTEMCFG_H
+
+/*
+ * Copyright (C) 2002 Peter Bergner <bergner@vnet.ibm.com>, IBM
+ * Copyright (C) 2005 Benjamin Herrenschmidy <benh@kernel.crashing.org>,
+ * 		      IBM Corp.
+ */
+
+#ifdef CONFIG_PPC64
+
+/*
+ * If the major version changes we are incompatible.
+ * Minor version changes are a hint.
+ */
+#define SYSTEMCFG_MAJOR 1
+#define SYSTEMCFG_MINOR 1
+
+#include <linux/types.h>
+
+struct systemcfg {
+	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
+	struct {			/* Systemcfg version numbers	     */
+		__u32 major;		/* Major number			0x10 */
+		__u32 minor;		/* Minor number			0x14 */
+	} version;
+
+	/* Note about the platform flags: it now only contains the lpar
+	 * bit. The actual platform number is dead and buried
+	 */
+	__u32 platform;			/* Platform flags		0x18 */
+	__u32 processor;		/* Processor type		0x1C */
+	__u64 processorCount;		/* # of physical processors	0x20 */
+	__u64 physicalMemorySize;	/* Size of real memory(B)	0x28 */
+	__u64 tb_orig_stamp;		/* (NU) Timebase at boot	0x30 */
+	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
+	__u64 tb_to_xs;			/* (NU) Inverse of TB to 2^20	0x40 */
+	__u64 stamp_xsec;		/* (NU)				0x48 */
+	__u64 tb_update_count;		/* (NU) Timebase atomicity ctr	0x50 */
+	__u32 tz_minuteswest;		/* (NU) Min. west of Greenwich	0x58 */
+	__u32 tz_dsttime;		/* (NU) Type of dst correction	0x5C */
+	__u32 dcache_size;		/* L1 d-cache size		0x60 */
+	__u32 dcache_line_size;		/* L1 d-cache line size		0x64 */
+	__u32 icache_size;		/* L1 i-cache size		0x68 */
+	__u32 icache_line_size;		/* L1 i-cache line size		0x6C */
+};
+
+extern struct systemcfg *systemcfg;
+
+#endif /* CONFIG_PPC64 */
+#endif /* _SYSTEMCFG_H */
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/=
asm/vdso/vsyscall.h
index 92f480d8cc6d..48560a119559 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -4,12 +4,8 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <asm/vdso_datapage.h>
=20
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline
 struct vdso_data *__arch_get_k_vdso_data(void)
 {
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/=
asm/vdso_datapage.h
index 248dee138f7b..a9686310be2c 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -9,29 +9,6 @@
  * 		      IBM Corp.
  */
=20
-
-/*
- * Note about this structure:
- *
- * This structure was historically called systemcfg and exposed to
- * userland via /proc/ppc64/systemcfg. Unfortunately, this became an
- * ABI issue as some proprietary software started relying on being able
- * to mmap() it, thus we have to keep the base layout at least for a
- * few kernel versions.
- *
- * However, since ppc32 doesn't suffer from this backward handicap,
- * a simpler version of the data structure is used there with only the
- * fields actually used by the vDSO.
- *
- */
-
-/*
- * If the major version changes we are incompatible.
- * Minor version changes are a hint.
- */
-#define SYSTEMCFG_MAJOR 1
-#define SYSTEMCFG_MINOR 1
-
 #ifndef __ASSEMBLY__
=20
 #include <linux/unistd.h>
@@ -40,41 +17,10 @@
=20
 #define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
=20
-/*
- * So here is the ppc64 backward compatible version
- */
-
 #ifdef CONFIG_PPC64
=20
 struct vdso_arch_data {
-	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
-	struct {			/* Systemcfg version numbers	     */
-		__u32 major;		/* Major number			0x10 */
-		__u32 minor;		/* Minor number			0x14 */
-	} version;
-
-	/* Note about the platform flags: it now only contains the lpar
-	 * bit. The actual platform number is dead and buried
-	 */
-	__u32 platform;			/* Platform flags		0x18 */
-	__u32 processor;		/* Processor type		0x1C */
-	__u64 processorCount;		/* # of physical processors	0x20 */
-	__u64 physicalMemorySize;	/* Size of real memory(B)	0x28 */
-	__u64 tb_orig_stamp;		/* (NU) Timebase at boot	0x30 */
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
-	__u64 tb_to_xs;			/* (NU) Inverse of TB to 2^20	0x40 */
-	__u64 stamp_xsec;		/* (NU)				0x48 */
-	__u64 tb_update_count;		/* (NU) Timebase atomicity ctr	0x50 */
-	__u32 tz_minuteswest;		/* (NU) Min. west of Greenwich	0x58 */
-	__u32 tz_dsttime;		/* (NU) Type of dst correction	0x5C */
-	__u32 dcache_size;		/* L1 d-cache size		0x60 */
-	__u32 dcache_line_size;		/* L1 d-cache line size		0x64 */
-	__u32 icache_size;		/* L1 i-cache size		0x68 */
-	__u32 icache_line_size;		/* L1 i-cache line size		0x6C */
-
-	/* those additional ones don't have to be located anywhere
-	 * special as they were not part of the original systemcfg
-	 */
+	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
 	__u32 dcache_block_size;		/* L1 d-cache block size     */
 	__u32 icache_block_size;		/* L1 i-cache block size     */
 	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
@@ -88,11 +34,8 @@ struct vdso_arch_data {
=20
 #else /* CONFIG_PPC64 */
=20
-/*
- * And here is the simpler 32 bits version
- */
 struct vdso_arch_data {
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
+	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
 	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
 	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
 	struct vdso_data data[CS_BASES];
diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_po=
werpc.c
index b109cd7b5d01..3816a2bf2b84 100644
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -4,6 +4,7 @@
  */
=20
 #include <linux/init.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
@@ -12,9 +13,10 @@
 #include <asm/machdep.h>
 #include <asm/vdso_datapage.h>
 #include <asm/rtas.h>
+#include <asm/systemcfg.h>
 #include <linux/uaccess.h>
=20
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
=20
 static loff_t page_map_seek(struct file *file, loff_t off, int whence)
 {
@@ -33,10 +35,9 @@ static int page_map_mmap( struct file *file, struct vm_are=
a_struct *vma )
 	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE)
 		return -EINVAL;
=20
-	remap_pfn_range(vma, vma->vm_start,
-			__pa(pde_data(file_inode(file))) >> PAGE_SHIFT,
-			PAGE_SIZE, vma->vm_page_prot);
-	return 0;
+	return remap_pfn_range(vma, vma->vm_start,
+			       __pa(pde_data(file_inode(file))) >> PAGE_SHIFT,
+			       PAGE_SIZE, vma->vm_page_prot);
 }
=20
 static const struct proc_ops page_map_proc_ops =3D {
@@ -45,13 +46,35 @@ static const struct proc_ops page_map_proc_ops =3D {
 	.proc_mmap	=3D page_map_mmap,
 };
=20
+static union {
+	struct systemcfg	data;
+	u8			page[PAGE_SIZE];
+} systemcfg_data_store __page_aligned_data;
+struct systemcfg *systemcfg =3D &systemcfg_data_store.data;
=20
 static int __init proc_ppc64_init(void)
 {
 	struct proc_dir_entry *pde;
=20
+	strcpy((char *)systemcfg->eye_catcher, "SYSTEMCFG:PPC64");
+	systemcfg->version.major =3D SYSTEMCFG_MAJOR;
+	systemcfg->version.minor =3D SYSTEMCFG_MINOR;
+	systemcfg->processor =3D mfspr(SPRN_PVR);
+	/*
+	 * Fake the old platform number for pSeries and add
+	 * in LPAR bit if necessary
+	 */
+	systemcfg->platform =3D 0x100;
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		systemcfg->platform |=3D 1;
+	systemcfg->physicalMemorySize =3D memblock_phys_mem_size();
+	systemcfg->dcache_size =3D ppc64_caches.l1d.size;
+	systemcfg->dcache_line_size =3D ppc64_caches.l1d.line_size;
+	systemcfg->icache_size =3D ppc64_caches.l1i.size;
+	systemcfg->icache_line_size =3D ppc64_caches.l1i.line_size;
+
 	pde =3D proc_create_data("powerpc/systemcfg", S_IFREG | 0444, NULL,
-			       &page_map_proc_ops, vdso_data);
+			       &page_map_proc_ops, systemcfg);
 	if (!pde)
 		return 1;
 	proc_set_size(pde, PAGE_SIZE);
@@ -60,7 +83,7 @@ static int __init proc_ppc64_init(void)
 }
 __initcall(proc_ppc64_init);
=20
-#endif /* CONFIG_PPC64 */
+#endif /* CONFIG_PPC64_PROC_SYSTEMCFG */
=20
 /*
  * Create the ppc64 and ppc64/rtas directories early. This allows us to
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-c=
ommon.c
index 943430077375..0b732d3b283b 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -67,6 +67,7 @@
 #include <asm/cpu_has_feature.h>
 #include <asm/kasan.h>
 #include <asm/mce.h>
+#include <asm/systemcfg.h>
=20
 #include "setup.h"
=20
@@ -560,7 +561,9 @@ void __init smp_setup_cpu_maps(void)
 	out:
 		of_node_put(dn);
 	}
-	vdso_data->processorCount =3D num_present_cpus();
+#endif
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->processorCount =3D num_present_cpus();
 #endif /* CONFIG_PPC64 */
=20
         /* Initialize CPU <=3D> thread mapping/
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4ab9b8cee77a..5ac7084eebc0 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -61,6 +61,7 @@
 #include <asm/ftrace.h>
 #include <asm/kup.h>
 #include <asm/fadump.h>
+#include <asm/systemcfg.h>
=20
 #include <trace/events/ipi.h>
=20
@@ -1186,8 +1187,8 @@ int generic_cpu_disable(void)
 		return -EBUSY;
=20
 	set_cpu_online(cpu, false);
-#ifdef CONFIG_PPC64
-	vdso_data->processorCount--;
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->processorCount--;
 #endif
 	/* Update affinity of all IRQs previously aimed at this CPU */
 	irq_migrate_all_off_this_cpu();
@@ -1642,10 +1643,12 @@ void start_secondary(void *unused)
=20
 	secondary_cpu_time_init();
=20
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
 	if (system_state =3D=3D SYSTEM_RUNNING)
-		vdso_data->processorCount++;
+		systemcfg->processorCount++;
+#endif
=20
+#ifdef CONFIG_PPC64
 	vdso_getcpu_init();
 #endif
 	set_numa_node(numa_cpu_lookup_table[cpu]);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 0ff9f038e800..0727332ad86f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -71,11 +71,11 @@
 #include <asm/vdso_datapage.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/systemcfg.h>
=20
 /* powerpc clocksource/clockevent code */
=20
 #include <linux/clockchips.h>
-#include <linux/timekeeper_internal.h>
=20
 static u64 timebase_read(struct clocksource *);
 static struct clocksource clocksource_timebase =3D {
@@ -951,6 +951,9 @@ void __init time_init(void)
 	}
=20
 	vdso_data->tb_ticks_per_sec =3D tb_ticks_per_sec;
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->tb_ticks_per_sec =3D tb_ticks_per_sec;
+#endif
=20
 	/* initialise and enable the large decrementer (if we have one) */
 	set_decrementer_max();
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index ee4b9d676cff..924f7f4fa597 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -16,7 +16,6 @@
 #include <linux/user.h>
 #include <linux/elf.h>
 #include <linux/security.h>
-#include <linux/memblock.h>
 #include <linux/syscalls.h>
 #include <linux/time_namespace.h>
 #include <vdso/datapage.h>
@@ -349,25 +348,6 @@ static struct page ** __init vdso_setup_pages(void *star=
t, void *end)
 static int __init vdso_init(void)
 {
 #ifdef CONFIG_PPC64
-	/*
-	 * Fill up the "systemcfg" stuff for backward compatibility
-	 */
-	strcpy((char *)vdso_data->eye_catcher, "SYSTEMCFG:PPC64");
-	vdso_data->version.major =3D SYSTEMCFG_MAJOR;
-	vdso_data->version.minor =3D SYSTEMCFG_MINOR;
-	vdso_data->processor =3D mfspr(SPRN_PVR);
-	/*
-	 * Fake the old platform number for pSeries and add
-	 * in LPAR bit if necessary
-	 */
-	vdso_data->platform =3D 0x100;
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		vdso_data->platform |=3D 1;
-	vdso_data->physicalMemorySize =3D memblock_phys_mem_size();
-	vdso_data->dcache_size =3D ppc64_caches.l1d.size;
-	vdso_data->dcache_line_size =3D ppc64_caches.l1d.line_size;
-	vdso_data->icache_size =3D ppc64_caches.l1i.size;
-	vdso_data->icache_line_size =3D ppc64_caches.l1i.line_size;
 	vdso_data->dcache_block_size =3D ppc64_caches.l1d.block_size;
 	vdso_data->icache_block_size =3D ppc64_caches.l1i.block_size;
 	vdso_data->dcache_log_block_size =3D ppc64_caches.l1d.log_block_size;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/po=
wernv/smp.c
index 8f14f0581a21..2e9da58195f5 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -36,6 +36,7 @@
 #include <asm/kexec.h>
 #include <asm/reg.h>
 #include <asm/powernv.h>
+#include <asm/systemcfg.h>
=20
 #include "powernv.h"
=20
@@ -136,7 +137,9 @@ static int pnv_smp_cpu_disable(void)
 	 * the generic fixup_irqs. --BenH.
 	 */
 	set_cpu_online(cpu, false);
-	vdso_data->processorCount--;
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->processorCount--;
+#endif
 	if (cpu =3D=3D boot_cpuid)
 		boot_cpuid =3D cpumask_any(cpu_online_mask);
 	if (xive_enabled())
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/plat=
forms/pseries/hotplug-cpu.c
index 6838a0fcda29..bc6926dbf148 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -33,6 +33,7 @@
 #include <asm/xive.h>
 #include <asm/plpar_wrappers.h>
 #include <asm/topology.h>
+#include <asm/systemcfg.h>
=20
 #include "pseries.h"
=20
@@ -83,7 +84,9 @@ static int pseries_cpu_disable(void)
 	int cpu =3D smp_processor_id();
=20
 	set_cpu_online(cpu, false);
-	vdso_data->processorCount--;
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->processorCount--;
+#endif
=20
 	/*fix boot_cpuid here*/
 	if (cpu =3D=3D boot_cpuid)
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platform=
s/pseries/lparcfg.c
index 62da20f9700a..cc22924f159f 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -29,7 +29,6 @@
 #include <asm/firmware.h>
 #include <asm/rtas.h>
 #include <asm/time.h>
-#include <asm/vdso_datapage.h>
 #include <asm/vio.h>
 #include <asm/mmu.h>
 #include <asm/machdep.h>
@@ -530,7 +529,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void =
*v)
 		lrdrp =3D of_get_property(rtas_node, "ibm,lrdr-capacity", NULL);
=20
 	if (lrdrp =3D=3D NULL) {
-		partition_potential_processors =3D vdso_data->processorCount;
+		partition_potential_processors =3D num_possible_cpus();
 	} else {
 		partition_potential_processors =3D be32_to_cpup(lrdrp + 4);
 	}
@@ -553,7 +552,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void =
*v)
 	} else {		/* non SPLPAR case */
=20
 		seq_printf(m, "system_active_processors=3D%d\n",
-			   partition_potential_processors);
+			   partition_active_processors);
=20
 		seq_printf(m, "system_potential_processors=3D%d\n",
 			   partition_potential_processors);
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62545946ecf4..c278280c134f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -50,7 +50,7 @@ config RISCV
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_DATA
+	select ARCH_HAS_VDSO_TIME_DATA
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 32d308a3355f..9875399827c7 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -12,9 +12,7 @@
 #include <linux/pfn.h>
 #include <linux/const.h>
=20
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
=20
 #define HPAGE_SHIFT		PMD_SHIFT
 #define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
diff --git a/arch/riscv/include/asm/vdso/data.h b/arch/riscv/include/asm/vdso=
/time_data.h
similarity index 71%
rename from arch/riscv/include/asm/vdso/data.h
rename to arch/riscv/include/asm/vdso/time_data.h
index dc2f76f58b76..dfa65228999b 100644
--- a/arch/riscv/include/asm/vdso/data.h
+++ b/arch/riscv/include/asm/vdso/time_data.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __RISCV_ASM_VDSO_DATA_H
-#define __RISCV_ASM_VDSO_DATA_H
+#ifndef __RISCV_ASM_VDSO_TIME_DATA_H
+#define __RISCV_ASM_VDSO_TIME_DATA_H
=20
 #include <linux/types.h>
 #include <vdso/datapage.h>
 #include <asm/hwprobe.h>
=20
-struct arch_vdso_data {
+struct arch_vdso_time_data {
 	/* Stash static answers to the hwprobe queries when all CPUs are selected. =
*/
 	__u64 all_cpu_hwprobe_values[RISCV_HWPROBE_MAX_KEY + 1];
=20
@@ -14,4 +14,4 @@ struct arch_vdso_data {
 	__u8 homogeneous_cpus;
 };
=20
-#endif /* __RISCV_ASM_VDSO_DATA_H */
+#endif /* __RISCV_ASM_VDSO_TIME_DATA_H */
diff --git a/arch/riscv/include/asm/vdso/vsyscall.h b/arch/riscv/include/asm/=
vdso/vsyscall.h
index 82fd5d83bd60..e8a9c4b53c0c 100644
--- a/arch/riscv/include/asm/vdso/vsyscall.h
+++ b/arch/riscv/include/asm/vdso/vsyscall.h
@@ -4,14 +4,10 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
=20
 extern struct vdso_data *vdso_data;
=20
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline struct vdso_data *__riscv_get_k_vdso_data(void)
 {
 	return vdso_data;
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cea0ca2bf2a2..711a31f27c3d 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -402,7 +402,7 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *=
pairs,
 static int __init init_hwprobe_vdso_data(void)
 {
 	struct vdso_data *vd =3D __arch_get_k_vdso_data();
-	struct arch_vdso_data *avd =3D &vd->arch_data;
+	struct arch_vdso_time_data *avd =3D &vd->arch_data;
 	u64 id_bitsmash =3D 0;
 	struct riscv_hwprobe pair;
 	int key;
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 98315b98256d..3ca3ae4277e1 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -23,11 +23,6 @@ enum vvar_pages {
 	VVAR_NR_PAGES,
 };
=20
-enum rv_vdso_map {
-	RV_VDSO_MAP_VVAR,
-	RV_VDSO_MAP_VDSO,
-};
-
 #define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
=20
 static union vdso_data_store vdso_data_store __page_aligned_data;
@@ -38,8 +33,6 @@ struct __vdso_info {
 	const char *vdso_code_start;
 	const char *vdso_code_end;
 	unsigned long vdso_pages;
-	/* Data Mapping */
-	struct vm_special_mapping *dm;
 	/* Code Mapping */
 	struct vm_special_mapping *cm;
 };
@@ -92,6 +85,8 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 	return (struct vdso_data *)(vvar_page);
 }
=20
+static const struct vm_special_mapping rv_vvar_map;
+
 /*
  * The vvar mapping contains data for a specific time namespace, so when a t=
ask
  * changes namespace we must unmap its vvar data for the old namespace.
@@ -108,12 +103,8 @@ int vdso_join_timens(struct task_struct *task, struct ti=
me_namespace *ns)
 	mmap_read_lock(mm);
=20
 	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, vdso_info.dm))
-			zap_vma_pages(vma);
-#ifdef CONFIG_COMPAT
-		if (vma_is_special_mapping(vma, compat_vdso_info.dm))
+		if (vma_is_special_mapping(vma, &rv_vvar_map))
 			zap_vma_pages(vma);
-#endif
 	}
=20
 	mmap_read_unlock(mm);
@@ -155,43 +146,34 @@ static vm_fault_t vvar_fault(const struct vm_special_ma=
pping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
=20
-static struct vm_special_mapping rv_vdso_maps[] __ro_after_init =3D {
-	[RV_VDSO_MAP_VVAR] =3D {
-		.name   =3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
-	[RV_VDSO_MAP_VDSO] =3D {
-		.name   =3D "[vdso]",
-		.mremap =3D vdso_mremap,
-	},
+static const struct vm_special_mapping rv_vvar_map =3D {
+	.name   =3D "[vvar]",
+	.fault =3D vvar_fault,
+};
+
+static struct vm_special_mapping rv_vdso_map __ro_after_init =3D {
+	.name   =3D "[vdso]",
+	.mremap =3D vdso_mremap,
 };
=20
 static struct __vdso_info vdso_info __ro_after_init =3D {
 	.name =3D "vdso",
 	.vdso_code_start =3D vdso_start,
 	.vdso_code_end =3D vdso_end,
-	.dm =3D &rv_vdso_maps[RV_VDSO_MAP_VVAR],
-	.cm =3D &rv_vdso_maps[RV_VDSO_MAP_VDSO],
+	.cm =3D &rv_vdso_map,
 };
=20
 #ifdef CONFIG_COMPAT
-static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init =3D {
-	[RV_VDSO_MAP_VVAR] =3D {
-		.name   =3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
-	[RV_VDSO_MAP_VDSO] =3D {
-		.name   =3D "[vdso]",
-		.mremap =3D vdso_mremap,
-	},
+static struct vm_special_mapping rv_compat_vdso_map __ro_after_init =3D {
+	.name   =3D "[vdso]",
+	.mremap =3D vdso_mremap,
 };
=20
 static struct __vdso_info compat_vdso_info __ro_after_init =3D {
 	.name =3D "compat_vdso",
 	.vdso_code_start =3D compat_vdso_start,
 	.vdso_code_end =3D compat_vdso_end,
-	.dm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
-	.cm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
+	.cm =3D &rv_compat_vdso_map,
 };
 #endif
=20
@@ -227,7 +209,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
 	}
=20
 	ret =3D _install_special_mapping(mm, vdso_base, VVAR_SIZE,
-		(VM_READ | VM_MAYREAD | VM_PFNMAP), vdso_info->dm);
+		(VM_READ | VM_MAYREAD | VM_PFNMAP), &rv_vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
=20
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprob=
e.c
index 1e926e4b5881..a158c029344f 100644
--- a/arch/riscv/kernel/vdso/hwprobe.c
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -17,7 +17,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pair=
s, size_t pair_count,
 				 unsigned int flags)
 {
 	const struct vdso_data *vd =3D __arch_get_vdso_data();
-	const struct arch_vdso_data *avd =3D &vd->arch_data;
+	const struct arch_vdso_time_data *avd =3D &vd->arch_data;
 	bool all_cpus =3D !cpusetsize && !cpus;
 	struct riscv_hwprobe *p =3D pairs;
 	struct riscv_hwprobe *end =3D pairs + pair_count;
@@ -52,7 +52,7 @@ static int riscv_vdso_get_cpus(struct riscv_hwprobe *pairs,=
 size_t pair_count,
 			       unsigned int flags)
 {
 	const struct vdso_data *vd =3D __arch_get_vdso_data();
-	const struct arch_vdso_data *avd =3D &vd->arch_data;
+	const struct arch_vdso_time_data *avd =3D &vd->arch_data;
 	struct riscv_hwprobe *p =3D pairs;
 	struct riscv_hwprobe *end =3D pairs + pair_count;
 	unsigned char *c =3D (unsigned char *)cpus;
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d339fe4fdedf..8cdd8359e00c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -88,7 +88,7 @@ config S390
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_DATA
+	select ARCH_HAS_VDSO_TIME_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 73e1e03317b4..b7ba87f89761 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -11,14 +11,8 @@
 #include <linux/const.h>
 #include <asm/types.h>
=20
-#define _PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define _PAGE_SIZE	(_AC(1, UL) << _PAGE_SHIFT)
-#define _PAGE_MASK	(~(_PAGE_SIZE - 1))
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	_PAGE_SHIFT
-#define PAGE_SIZE	_PAGE_SIZE
-#define PAGE_MASK	_PAGE_MASK
+#include <vdso/page.h>
+
 #define PAGE_DEFAULT_ACC	_AC(0, UL)
 /* storage-protection override */
 #define PAGE_SPO_ACC		9
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 0ffbaf741955..8b67036edb69 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -338,7 +338,7 @@ static inline int is_module_addr(void *addr)
 #define _REGION2_INDEX	(0x7ffUL << _REGION2_SHIFT)
 #define _REGION3_INDEX	(0x7ffUL << _REGION3_SHIFT)
 #define _SEGMENT_INDEX	(0x7ffUL << _SEGMENT_SHIFT)
-#define _PAGE_INDEX	(0xffUL  << _PAGE_SHIFT)
+#define _PAGE_INDEX	(0xffUL  << PAGE_SHIFT)
=20
 #define _REGION1_SIZE	(1UL << _REGION1_SHIFT)
 #define _REGION2_SIZE	(1UL << _REGION2_SHIFT)
diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 91061f0279be..92c73e4d97a9 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -12,9 +12,6 @@ int vdso_getcpu_init(void);
=20
 #endif /* __ASSEMBLY__ */
=20
-/* Default link address for the vDSO */
-#define VDSO_LBASE	0
-
 #define __VVAR_PAGES	2
=20
 #define VDSO_VERSION_STRING	LINUX_2.6.29
diff --git a/arch/s390/include/asm/vdso/data.h b/arch/s390/include/asm/vdso/d=
ata.h
deleted file mode 100644
index 0e2b40ef69b0..000000000000
--- a/arch/s390/include/asm/vdso/data.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __S390_ASM_VDSO_DATA_H
-#define __S390_ASM_VDSO_DATA_H
-
-#include <linux/types.h>
-
-struct arch_vdso_data {
-	__s64 tod_steering_delta;
-	__u64 tod_steering_end;
-};
-
-#endif /* __S390_ASM_VDSO_DATA_H */
diff --git a/arch/s390/include/asm/vdso/time_data.h b/arch/s390/include/asm/v=
dso/time_data.h
new file mode 100644
index 000000000000..8a08752422e6
--- /dev/null
+++ b/arch/s390/include/asm/vdso/time_data.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __S390_ASM_VDSO_TIME_DATA_H
+#define __S390_ASM_VDSO_TIME_DATA_H
+
+#include <linux/types.h>
+
+struct arch_vdso_time_data {
+	__s64 tod_steering_delta;
+	__u64 tod_steering_end;
+};
+
+#endif /* __S390_ASM_VDSO_TIME_DATA_H */
diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vd=
so/vsyscall.h
index 3c5d5e47814e..3eb576ecd3bd 100644
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -7,7 +7,6 @@
 #ifndef __ASSEMBLY__
=20
 #include <linux/hrtimer.h>
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/vdso.h>
=20
@@ -17,10 +16,6 @@ enum vvar_pages {
 	VVAR_NR_PAGES
 };
=20
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-
 static __always_inline struct vdso_data *__s390_get_k_vdso_data(void)
 {
 	return vdso_data;
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index b713effe0579..4fae6c701784 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -36,7 +36,6 @@
 #include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/notifier.h>
-#include <linux/timekeeper_internal.h>
 #include <linux/clockchips.h>
 #include <linux/gfp.h>
 #include <linux/kprobes.h>
diff --git a/arch/s390/kernel/vdso32/vdso32.lds.S b/arch/s390/kernel/vdso32/v=
dso32.lds.S
index 65b9513a5a0e..c916c4f73f76 100644
--- a/arch/s390/kernel/vdso32/vdso32.lds.S
+++ b/arch/s390/kernel/vdso32/vdso32.lds.S
@@ -16,7 +16,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/v=
dso64.lds.S
index 753040a4b5ab..ec42b7d9cb53 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -18,7 +18,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index ad8b0d6b77ea..12e10269dfcd 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -147,7 +147,7 @@ static void dump_pagetable(unsigned long asce, unsigned l=
ong address)
 			goto out;
 		table =3D __va(entry & _SEGMENT_ENTRY_ORIGIN);
 	}
-	table +=3D (address & _PAGE_INDEX) >> _PAGE_SHIFT;
+	table +=3D (address & _PAGE_INDEX) >> PAGE_SHIFT;
 	if (get_kernel_nofault(entry, table))
 		goto bad;
 	pr_cont("P:%016lx ", entry);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index eb0b51a36be0..346ec059c8bd 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -851,7 +851,7 @@ static inline unsigned long *gmap_table_walk(struct gmap =
*gmap,
 		if (*table & _REGION_ENTRY_INVALID)
 			return NULL;
 		table =3D __va(*table & _SEGMENT_ENTRY_ORIGIN);
-		table +=3D (gaddr & _PAGE_INDEX) >> _PAGE_SHIFT;
+		table +=3D (gaddr & _PAGE_INDEX) >> PAGE_SHIFT;
 	}
 	return table;
 }
@@ -1317,7 +1317,7 @@ static void gmap_unshadow_page(struct gmap *sg, unsigne=
d long raddr)
 	table =3D gmap_table_walk(sg, raddr, 0); /* get page table pointer */
 	if (!table || *table & _PAGE_INVALID)
 		return;
-	gmap_call_notifier(sg, raddr, raddr + _PAGE_SIZE - 1);
+	gmap_call_notifier(sg, raddr, raddr + PAGE_SIZE - 1);
 	ptep_unshadow_pte(sg->mm, raddr, (pte_t *) table);
 }
=20
@@ -1335,7 +1335,7 @@ static void __gmap_unshadow_pgt(struct gmap *sg, unsign=
ed long raddr,
 	int i;
=20
 	BUG_ON(!gmap_is_shadow(sg));
-	for (i =3D 0; i < _PAGE_ENTRIES; i++, raddr +=3D _PAGE_SIZE)
+	for (i =3D 0; i < _PAGE_ENTRIES; i++, raddr +=3D PAGE_SIZE)
 		pgt[i] =3D _PAGE_INVALID;
 }
=20
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index f691e0fb66a2..58696a0c4e4a 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -278,7 +278,7 @@ static inline unsigned long base_##NAME##_addr_end(unsign=
ed long addr,	\
 	return (next - 1) < (end - 1) ? next : end;			\
 }
=20
-BASE_ADDR_END_FUNC(page,    _PAGE_SIZE)
+BASE_ADDR_END_FUNC(page,    PAGE_SIZE)
 BASE_ADDR_END_FUNC(segment, _SEGMENT_SIZE)
 BASE_ADDR_END_FUNC(region3, _REGION3_SIZE)
 BASE_ADDR_END_FUNC(region2, _REGION2_SIZE)
@@ -302,7 +302,7 @@ static int base_page_walk(unsigned long *origin, unsigned=
 long addr,
 	if (!alloc)
 		return 0;
 	pte =3D origin;
-	pte +=3D (addr & _PAGE_INDEX) >> _PAGE_SHIFT;
+	pte +=3D (addr & _PAGE_INDEX) >> PAGE_SHIFT;
 	do {
 		next =3D base_page_addr_end(addr, end);
 		*pte =3D base_lra(addr);
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index f780b467e75d..fc39b8171bfb 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -8,10 +8,8 @@
=20
 #include <linux/const.h>
=20
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
+
 #define PTE_MASK	PAGE_MASK
=20
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_3=
2.h
index 9977c77374cd..9954254ea569 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -11,9 +11,7 @@
=20
 #include <linux/const.h>
=20
-#define PAGE_SHIFT   CONFIG_PAGE_SHIFT
-#define PAGE_SIZE    (_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK    (~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 #ifndef __ASSEMBLY__
=20
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_6=
4.h
index e9bd24821c93..2a68ff5b6eab 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -4,9 +4,7 @@
=20
 #include <linux/const.h>
=20
-#define PAGE_SHIFT   CONFIG_PAGE_SHIFT
-#define PAGE_SIZE    (_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK    (~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 /* Flushing for D-cache alias handling is only needed if
  * the page size is smaller than 16K.
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 9ef9a8aedfa6..834313ecd3d6 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -9,10 +9,7 @@
=20
 #include <linux/const.h>
=20
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 #ifndef __ASSEMBLY__
=20
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index bafa73f09e92..872947c1004c 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vdso.h>
+#include <asm/vdso/vsyscall.h>
=20
 /*
  * Linker script for vDSO.  This is an ELF shared object prelinked to
@@ -16,23 +17,16 @@ SECTIONS
 	 * segment.
 	 */
=20
-	vvar_start =3D . - 4 * PAGE_SIZE;
+	vvar_start =3D . - __VVAR_PAGES * PAGE_SIZE;
 	vvar_page  =3D vvar_start;
=20
-	/* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) vvar_ ## name =3D vvar_page + offset;
-#include <asm/vvar.h>
-#undef EMIT_VVAR
+	vdso_rng_data =3D vvar_page + __VDSO_RND_DATA_OFFSET;
=20
-	pvclock_page =3D vvar_start + PAGE_SIZE;
-	hvclock_page =3D vvar_start + 2 * PAGE_SIZE;
-	timens_page  =3D vvar_start + 3 * PAGE_SIZE;
+	timens_page  =3D vvar_start + PAGE_SIZE;
=20
-#undef _ASM_X86_VVAR_H
-	/* Place all vvars in timens too at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) timens_ ## name =3D timens_page + offset;
-#include <asm/vvar.h>
-#undef EMIT_VVAR
+	vclock_pages =3D vvar_start + VDSO_NR_VCLOCK_PAGES * PAGE_SIZE;
+	pvclock_page =3D vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
+	hvclock_page =3D vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
=20
 	. =3D SIZEOF_HEADERS;
=20
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index b8fed8b8b9cc..bfc7cabf4017 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -20,26 +20,20 @@
 #include <asm/vgtod.h>
 #include <asm/proto.h>
 #include <asm/vdso.h>
-#include <asm/vvar.h>
 #include <asm/tlb.h>
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
+#include <asm/vdso/vsyscall.h>
 #include <clocksource/hyperv_timer.h>
=20
-#undef _ASM_X86_VVAR_H
-#define EMIT_VVAR(name, offset)	\
-	const size_t name ## _offset =3D offset;
-#include <asm/vvar.h>
-
 struct vdso_data *arch_get_vdso_data(void *vvar_page)
 {
-	return (struct vdso_data *)(vvar_page + _vdso_data_offset);
+	return (struct vdso_data *)vvar_page;
 }
-#undef EMIT_VVAR
=20
-DEFINE_VVAR(struct vdso_data, _vdso_data);
-DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
+static union vdso_data_store vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data =3D vdso_data_store.data;
=20
 unsigned int vclocks_used __read_mostly;
=20
@@ -154,7 +148,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapp=
ing *sm,
 	if (sym_offset =3D=3D image->sym_vvar_page) {
 		struct page *timens_page =3D find_timens_vvar_page(vma);
=20
-		pfn =3D __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+		pfn =3D __pa_symbol(vdso_data) >> PAGE_SHIFT;
=20
 		/*
 		 * If a task belongs to a time namespace then a namespace
@@ -182,32 +176,52 @@ static vm_fault_t vvar_fault(const struct vm_special_ma=
pping *sm,
 		}
=20
 		return vmf_insert_pfn(vma, vmf->address, pfn);
-	} else if (sym_offset =3D=3D image->sym_pvclock_page) {
-		struct pvclock_vsyscall_time_info *pvti =3D
-			pvclock_get_pvti_cpu0_va();
-		if (pvti && vclock_was_used(VDSO_CLOCKMODE_PVCLOCK)) {
-			return vmf_insert_pfn_prot(vma, vmf->address,
-					__pa(pvti) >> PAGE_SHIFT,
-					pgprot_decrypted(vma->vm_page_prot));
-		}
-	} else if (sym_offset =3D=3D image->sym_hvclock_page) {
-		pfn =3D hv_get_tsc_pfn();
=20
-		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
-			return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset =3D=3D image->sym_timens_page) {
 		struct page *timens_page =3D find_timens_vvar_page(vma);
=20
 		if (!timens_page)
 			return VM_FAULT_SIGBUS;
=20
-		pfn =3D __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+		pfn =3D __pa_symbol(vdso_data) >> PAGE_SHIFT;
 		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
=20
 	return VM_FAULT_SIGBUS;
 }
=20
+static vm_fault_t vvar_vclock_fault(const struct vm_special_mapping *sm,
+				    struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	switch (vmf->pgoff) {
+#ifdef CONFIG_PARAVIRT_CLOCK
+	case VDSO_PAGE_PVCLOCK_OFFSET:
+	{
+		struct pvclock_vsyscall_time_info *pvti =3D
+			pvclock_get_pvti_cpu0_va();
+
+		if (pvti && vclock_was_used(VDSO_CLOCKMODE_PVCLOCK))
+			return vmf_insert_pfn_prot(vma, vmf->address,
+					__pa(pvti) >> PAGE_SHIFT,
+					pgprot_decrypted(vma->vm_page_prot));
+		break;
+	}
+#endif /* CONFIG_PARAVIRT_CLOCK */
+#ifdef CONFIG_HYPERV_TIMER
+	case VDSO_PAGE_HVCLOCK_OFFSET:
+	{
+		unsigned long pfn =3D hv_get_tsc_pfn();
+
+		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
+			return vmf_insert_pfn(vma, vmf->address, pfn);
+		break;
+	}
+#endif /* CONFIG_HYPERV_TIMER */
+	}
+
+	return VM_FAULT_SIGBUS;
+}
+
 static const struct vm_special_mapping vdso_mapping =3D {
 	.name =3D "[vdso]",
 	.fault =3D vdso_fault,
@@ -217,6 +231,10 @@ static const struct vm_special_mapping vvar_mapping =3D {
 	.name =3D "[vvar]",
 	.fault =3D vvar_fault,
 };
+static const struct vm_special_mapping vvar_vclock_mapping =3D {
+	.name =3D "[vvar_vclock]",
+	.fault =3D vvar_vclock_fault,
+};
=20
 /*
  * Add vdso and vvar mappings to current process.
@@ -259,7 +277,7 @@ static int map_vdso(const struct vdso_image *image, unsig=
ned long addr)
=20
 	vma =3D _install_special_mapping(mm,
 				       addr,
-				       -image->sym_vvar_start,
+				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
 				       VM_PFNMAP,
 				       &vvar_mapping);
@@ -267,11 +285,26 @@ static int map_vdso(const struct vdso_image *image, uns=
igned long addr)
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
-	} else {
-		current->mm->context.vdso =3D (void __user *)text_start;
-		current->mm->context.vdso_image =3D image;
+		goto up_fail;
 	}
=20
+	vma =3D _install_special_mapping(mm,
+				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
+				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
+				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
+				       VM_PFNMAP,
+				       &vvar_vclock_mapping);
+
+	if (IS_ERR(vma)) {
+		ret =3D PTR_ERR(vma);
+		do_munmap(mm, text_start, image->size, NULL);
+		do_munmap(mm, addr, image->size, NULL);
+		goto up_fail;
+	}
+
+	current->mm->context.vdso =3D (void __user *)text_start;
+	current->mm->context.vdso_image =3D image;
+
 up_fail:
 	mmap_write_unlock(mm);
 	return ret;
@@ -293,7 +326,8 @@ int map_vdso_once(const struct vdso_image *image, unsigne=
d long addr)
 	 */
 	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
-				vma_is_special_mapping(vma, &vvar_mapping)) {
+				vma_is_special_mapping(vma, &vvar_mapping) ||
+				vma_is_special_mapping(vma, &vvar_vclock_mapping)) {
 			mmap_write_unlock(mm);
 			return -EEXIST;
 		}
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_ty=
pes.h
index 52f1b4ff0cc1..974688973cf6 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -6,10 +6,7 @@
 #include <linux/types.h>
 #include <linux/mem_encrypt.h>
=20
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
=20
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vds=
o/getrandom.h
index ff5334ad32a0..2bf9c0e970c3 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -8,7 +8,6 @@
 #ifndef __ASSEMBLY__
=20
 #include <asm/unistd.h>
-#include <asm/vvar.h>
=20
 /**
  * getrandom_syscall - Invoke the getrandom() syscall.
@@ -28,13 +27,14 @@ static __always_inline ssize_t getrandom_syscall(void *bu=
ffer, size_t len, unsig
 	return ret;
 }
=20
-#define __vdso_rng_data (VVAR(_vdso_rng_data))
+extern struct vdso_rng_data vdso_rng_data
+	__attribute__((visibility("hidden")));
=20
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
 {
-	if (IS_ENABLED(CONFIG_TIME_NS) && __vdso_data->clock_mode =3D=3D VDSO_CLOCK=
MODE_TIMENS)
-		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)&=
__vdso_data);
-	return &__vdso_rng_data;
+	if (IS_ENABLED(CONFIG_TIME_NS) && __arch_get_vdso_data()->clock_mode =3D=3D=
 VDSO_CLOCKMODE_TIMENS)
+		return (void *)&vdso_rng_data + ((void *)&timens_page - (void *)__arch_get=
_vdso_data());
+	return &vdso_rng_data;
 }
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index b2d2df026f6e..375a34b0f365 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -14,14 +14,16 @@
=20
 #include <uapi/linux/time.h>
 #include <asm/vgtod.h>
-#include <asm/vvar.h>
 #include <asm/unistd.h>
 #include <asm/msr.h>
 #include <asm/pvclock.h>
 #include <clocksource/hyperv_timer.h>
=20
-#define __vdso_data (VVAR(_vdso_data))
-#define __timens_vdso_data (TIMENS(_vdso_data))
+extern struct vdso_data vvar_page
+	__attribute__((visibility("hidden")));
+
+extern struct vdso_data timens_page
+	__attribute__((visibility("hidden")));
=20
 #define VDSO_HAS_TIME 1
=20
@@ -61,7 +63,7 @@ extern struct ms_hyperv_tsc_page hvclock_page
 static __always_inline
 const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
 {
-	return __timens_vdso_data;
+	return &timens_page;
 }
 #endif
=20
@@ -275,7 +277,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode,
=20
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return __vdso_data;
+	return &vvar_page;
 }
=20
 static inline bool arch_vdso_clocksource_ok(const struct vdso_data *vd)
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index 67fedf1698b5..37b4a70559a8 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -2,12 +2,19 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
+#define __VDSO_RND_DATA_OFFSET  640
+#define __VVAR_PAGES	4
+
+#define VDSO_NR_VCLOCK_PAGES	2
+#define VDSO_PAGE_PVCLOCK_OFFSET	0
+#define VDSO_PAGE_HVCLOCK_OFFSET	1
+
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
-#include <asm/vvar.h>
+
+extern struct vdso_data *vdso_data;
=20
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
@@ -15,14 +22,14 @@
 static __always_inline
 struct vdso_data *__x86_get_k_vdso_data(void)
 {
-	return _vdso_data;
+	return vdso_data;
 }
 #define __arch_get_k_vdso_data __x86_get_k_vdso_data
=20
 static __always_inline
 struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
 {
-	return &_vdso_rng_data;
+	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
 }
 #define __arch_get_k_vdso_rng_data __x86_get_k_vdso_rng_data
=20
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
deleted file mode 100644
index 9d9af37f7cab..000000000000
--- a/arch/x86/include/asm/vvar.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * vvar.h: Shared vDSO/kernel variable declarations
- * Copyright (c) 2011 Andy Lutomirski
- *
- * A handful of variables are accessible (read-only) from userspace
- * code in the vsyscall page and the vdso.  They are declared here.
- * Some other file must define them with DEFINE_VVAR.
- *
- * In normal kernel code, they are used like any other variable.
- * In user code, they are accessed through the VVAR macro.
- *
- * These variables live in a page of kernel data that has an extra RO
- * mapping for userspace.  Each variable needs a unique offset within
- * that page; specify that offset with the DECLARE_VVAR macro.  (If
- * you mess up, the linker will catch it.)
- */
-
-#ifndef _ASM_X86_VVAR_H
-#define _ASM_X86_VVAR_H
-
-#ifdef EMIT_VVAR
-/*
- * EMIT_VVAR() is used by the kernel linker script to put vvars in the
- * right place. Also, it's used by kernel code to import offsets values.
- */
-#define DECLARE_VVAR(offset, type, name) \
-	EMIT_VVAR(name, offset)
-#define DECLARE_VVAR_SINGLE(offset, type, name) \
-	EMIT_VVAR(name, offset)
-
-#else
-
-extern char __vvar_page;
-
-#define DECLARE_VVAR(offset, type, name)				\
-	extern type vvar_ ## name[CS_BASES]				\
-	__attribute__((visibility("hidden")));				\
-	extern type timens_ ## name[CS_BASES]				\
-	__attribute__((visibility("hidden")));				\
-
-#define DECLARE_VVAR_SINGLE(offset, type, name)				\
-	extern type vvar_ ## name					\
-	__attribute__((visibility("hidden")));				\
-
-#define VVAR(name) (vvar_ ## name)
-#define TIMENS(name) (timens_ ## name)
-
-#define DEFINE_VVAR(type, name)						\
-	type name[CS_BASES]						\
-	__attribute__((section(".vvar_" #name), aligned(16))) __visible
-
-#define DEFINE_VVAR_SINGLE(type, name)					\
-	type name							\
-	__attribute__((section(".vvar_" #name), aligned(16))) __visible
-
-#endif
-
-/* DECLARE_VVAR(offset, type, name) */
-
-DECLARE_VVAR(128, struct vdso_data, _vdso_data)
-
-#if !defined(_SINGLE_DATA)
-#define _SINGLE_DATA
-DECLARE_VVAR_SINGLE(640, struct vdso_rng_data, _vdso_rng_data)
-#endif
-
-#undef DECLARE_VVAR
-#undef DECLARE_VVAR_SINGLE
-
-#endif
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6726be89b7a6..e7e19842736a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -193,29 +193,6 @@ SECTIONS
=20
 	ORC_UNWIND_TABLE
=20
-	. =3D ALIGN(PAGE_SIZE);
-	__vvar_page =3D .;
-
-	.vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
-		/* work around gold bug 13023 */
-		__vvar_beginning_hack =3D .;
-
-		/* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset)				\
-		. =3D __vvar_beginning_hack + offset;	\
-		*(.vvar_ ## name)
-#include <asm/vvar.h>
-#undef EMIT_VVAR
-
-		/*
-		 * Pad the rest of the page with zeros.  Otherwise the loader
-		 * can leave garbage here.
-		 */
-		. =3D __vvar_beginning_hack + PAGE_SIZE;
-	} :data
-
-	. =3D ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
-
 	/* Init code and data - will be freed after init */
 	. =3D ALIGN(PAGE_SIZE);
 	.init.begin : AT(ADDR(.init.begin) - LOAD_OFFSET) {
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index a2cabb1c81e1..b8a6ffffb451 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -163,11 +163,6 @@ unsigned long get_mmap_base(int is_legacy)
 	return is_legacy ? mm->mmap_legacy_base : mm->mmap_base;
 }
=20
-const char *arch_vma_name(struct vm_area_struct *vma)
-{
-	return NULL;
-}
-
 /**
  * mmap_address_hint_valid - Validate the address hint of mmap
  * @addr:	Address hint
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index c101bed61940..6afe2e5e9102 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -89,7 +89,6 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] =3D=
 {
 	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
-	"__vvar_page|"
 	"_end)$"
 };
=20
diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
index 4db56ef052d2..595c1037b738 100644
--- a/arch/xtensa/include/asm/page.h
+++ b/arch/xtensa/include/asm/page.h
@@ -18,13 +18,7 @@
 #include <asm/cache.h>
 #include <asm/kmem_layout.h>
=20
-/*
- * PAGE_SHIFT determines the page size
- */
-
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(__XTENSA_UL_CONST(1) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
=20
 #ifdef CONFIG_MMU
 #define PAGE_OFFSET	XCHAL_KSEG_CACHED_VADDR
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/int=
el_gt.c
index a6c69a706fd7..bb29f361110e 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -302,7 +302,7 @@ static void gen6_check_faults(struct intel_gt *gt)
 {
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
-	u32 fault;
+	unsigned long fault;
=20
 	for_each_engine(engine, gt, id) {
 		fault =3D GEN6_RING_FAULT_REG_READ(engine);
@@ -310,8 +310,8 @@ static void gen6_check_faults(struct intel_gt *gt)
 			gt_dbg(gt, "Unexpected fault\n"
 			       "\tAddr: 0x%08lx\n"
 			       "\tAddress space: %s\n"
-			       "\tSource ID: %d\n"
-			       "\tType: %d\n",
+			       "\tSource ID: %ld\n"
+			       "\tType: %ld\n",
 			       fault & PAGE_MASK,
 			       fault & RING_FAULT_GTTSEL_MASK ?
 			       "GGTT" : "PPGTT",
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index c835607f78ae..01dafd604188 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -12,8 +12,7 @@ static __always_inline struct vdso_data *__arch_get_k_vdso_=
data(void)
 #endif /* __arch_get_k_vdso_data */
=20
 #ifndef __arch_update_vsyscall
-static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
-						   struct timekeeper *tk)
+static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata)
 {
 }
 #endif /* __arch_update_vsyscall */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index b85f24cac3f5..d967baa0cd0c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,10 +19,10 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
=20
-#ifdef CONFIG_ARCH_HAS_VDSO_DATA
-#include <asm/vdso/data.h>
+#ifdef CONFIG_ARCH_HAS_VDSO_TIME_DATA
+#include <asm/vdso/time_data.h>
 #else
-struct arch_vdso_data {};
+struct arch_vdso_time_data {};
 #endif
=20
 #define VDSO_BASES	(CLOCK_TAI + 1)
@@ -114,7 +114,7 @@ struct vdso_data {
 	u32			hrtimer_res;
 	u32			__unused;
=20
-	struct arch_vdso_data	arch_data;
+	struct arch_vdso_time_data arch_data;
 };
=20
 /**
diff --git a/include/vdso/page.h b/include/vdso/page.h
new file mode 100644
index 000000000000..710ae2414e68
--- /dev/null
+++ b/include/vdso/page.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_PAGE_H
+#define __VDSO_PAGE_H
+
+#include <uapi/linux/const.h>
+
+/*
+ * PAGE_SHIFT determines the page size.
+ *
+ * Note: This definition is required because PAGE_SHIFT is used
+ * in several places throuout the codebase.
+ */
+#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
+
+#define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
+
+#if !defined(CONFIG_64BIT)
+/*
+ * Applies only to 32-bit architectures.
+ *
+ * Subtle: (1 << CONFIG_PAGE_SHIFT) is an int, not an unsigned long.
+ * So if we assign PAGE_MASK to a larger type it gets extended the
+ * way we want (i.e. with 1s in the high bits) while masking a
+ * 64-bit value such as phys_addr_t.
+ */
+#define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
+#else
+#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#endif
+
+#endif	/* __VDSO_PAGE_H */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 9193d6133e5d..28706a13c222 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -119,7 +119,7 @@ void update_vsyscall(struct timekeeper *tk)
 	if (clock_mode !=3D VDSO_CLOCKMODE_NONE)
 		update_vdso_data(vdata, tk);
=20
-	__arch_update_vsyscall(vdata, tk);
+	__arch_update_vsyscall(vdata);
=20
 	vdso_write_end(vdata);
=20



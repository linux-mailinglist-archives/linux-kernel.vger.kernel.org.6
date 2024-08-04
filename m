Return-Path: <linux-kernel+bounces-273862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B195946EF2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB376B22225
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856B4779D;
	Sun,  4 Aug 2024 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QSrLL1La";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HtyjdoVi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02914290C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776584; cv=none; b=cnDI7rYl3sULE+gNdd7l1CqGG18jSvvd/z99P0KPS7p/VkpsLun5fkbqxPMEKsDIokkyO8HHU6nkHN8AqEdIyx3F4+R0oS4lMN4qSOw18LUleBER+hpz06ZV32VtECulcQnYzx8Sc6Gec9j3zagvNcw5Rf2Ms04s7BDCY8Ygchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776584; c=relaxed/simple;
	bh=fOXt48TfxRdg7jMXlp+mBCNRLC5OxetNxB0BqlVriQQ=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=naQWBIPDspdWA8qpmIgGtPmSvZop6SeFeRtDdWQdm47QBxRU2JVtdqqIM1pH30e/3hhFEsVEpwj64E5gJCU0a2AnSfeTT8PGQCZDd3mMldb+c7QPchMSrHJH1owXah/U1QTsFpzGvv/jz94HFVCQdcmudDmqiGpXvdjc9gwUZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QSrLL1La; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HtyjdoVi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722776580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=e+5YGEcOgm8cU4Rh2odUsqXOy6dkhRnMiMsRCpLocCY=;
	b=QSrLL1LaDO8JwyS03gmyUHctuSBMiExXBZEd5mRUqFXYcxY9/rdzqacBomTAthX8bTNZJI
	bNBubtZuVp6taboZvLE1hxgeHu4mpS9MHdMvNwFWajx4xiiVfMcAhvvthWMacwBhi2YZ4q
	xehgNi71bnLC1TNlnwrc0x7VPK3l+6rPdPF/MKukZZv5oFiUNMkFpgily96GyAJF3y80Dr
	rE2zNzz8rHRN1p4DKS0hhZV7pyZKt0T3z2N6ji0au5Moe9mmP9kIlTemGRFgJBoc/7oFcP
	mrwzDSl0YgtEkrlHIWCuZjBAAyGGs1bS4bA3FUBvSykyI5rorbdGc5F9UT9haQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722776580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=e+5YGEcOgm8cU4Rh2odUsqXOy6dkhRnMiMsRCpLocCY=;
	b=HtyjdoVi3tqDso189MPS1bRcMARdOqMIIj7rE+yij+HsZLgoiEHOLvdLrc7WzfH8XGKqaN
	6cRCQFEE7sOiBhCA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.11-rc2
References: <172277654174.866296.10517632866315552419.tglx@xen13>
Message-ID: <172277654939.866296.14745286844919555114.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  4 Aug 2024 15:03:00 +0200 (CEST)

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-=
08-04

up to:  dd35a0933269: x86/uaccess: Zero the 8-byte get_range case on failure =
on 32-bit


X86 fixes:

    - Prevent a deadlock on cpu_hotplug_lock in the aperf/mperf driver.

      A recent change in the ACPI code which consolidated code pathes moved
      the invocation of init_freq_invariance_cppc() to be moved to a CPU
      hotplug handler. The first invocation on AMD CPUs ends up enabling a
      static branch which dead locks because the static branch enable tries to
      acquire cpu_hotplug_lock but that lock is already held write by the
      hotplug machinery.

      Use static_branch_enable_cpuslocked() instead and take the hotplug
      lock read for the Intel code path which is invoked from the
      architecture code outside of the CPU hotplug operations.

    - Fix the number of reserved bits in the sev_config structure bit field
      so that the bitfield does not exceed 64 bit.

    - Add missing Zen5 model numbers

    - Fix the alignment assumptions of pti_clone_pgtable() and
      clone_entry_text() on 32-bit:

      The code assumes PMD aligned code sections, but on 32-bit the kernel
      entry text is not PMD aligned. So depending on the code size and
      location, which is configuration and compiler dependent, entry text
      can cross a PMD boundary. As the start is not PMD aligned adding PMD
      size to the start address is larger than the end address which
      results in partially mapped entry code for user space. That causes
      endless recursion on the first entry from userspace (usually #PF).

      Cure this by aligning the start address in the addition so it ends up
      at the next PMD start address.

      clone_entry_text() enforces PMD mapping, but on 32-bit the tail might
      eventually be PTE mapped, which causes a map fail because the PMD for
      the tail is not a large page mapping. Use PTI_LEVEL_KERNEL_IMAGE for
      the clone() invocation which resolves to PTE on 32-bit and PMD on
      64-bit.

    - Zero the 8-byte case for get_user() on range check failure on 32-bit

      The recend consolidation of the 8-byte get_user() case broke the
      zeroing in the failure case again. Establish it by clearing ECX
      before the range check and not afterwards as that obvioulsy can't be
      reached when the range check fails

=20
Thanks,

	tglx

------------------>
Borislav Petkov (AMD) (1):
      x86/setup: Parse the builtin command line before merging

David Gow (1):
      x86/uaccess: Zero the 8-byte get_range case on failure on 32-bit

Jonathan Cameron (1):
      x86/aperfmperf: Fix deadlock on cpu_hotplug_lock

Pavan Kumar Paluri (1):
      x86/sev: Fix __reserved field in sev_config

Perry Yuan (1):
      x86/CPU/AMD: Add models 0x60-0x6f to the Zen5 range

Peter Zijlstra (2):
      x86/mm: Fix pti_clone_pgtable() alignment assumption
      x86/mm: Fix pti_clone_entry_text() for i386


 arch/x86/coco/sev/core.c         |  2 +-
 arch/x86/include/asm/cmdline.h   |  4 ++++
 arch/x86/kernel/cpu/amd.c        |  2 +-
 arch/x86/kernel/cpu/aperfmperf.c |  6 ++++--
 arch/x86/kernel/setup.c          |  2 +-
 arch/x86/lib/cmdline.c           | 25 ++++++++++++++++++-------
 arch/x86/lib/getuser.S           |  4 +++-
 arch/x86/mm/pti.c                |  8 ++++----
 8 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 082d61d85dfc..de1df0cb45da 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -163,7 +163,7 @@ struct sev_config {
 	       */
 	      use_cas		: 1,
=20
-	      __reserved	: 62;
+	      __reserved	: 61;
 };
=20
 static struct sev_config sev_cfg __read_mostly;
diff --git a/arch/x86/include/asm/cmdline.h b/arch/x86/include/asm/cmdline.h
index 6faaf27e8899..6cbd9ae58b21 100644
--- a/arch/x86/include/asm/cmdline.h
+++ b/arch/x86/include/asm/cmdline.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_X86_CMDLINE_H
 #define _ASM_X86_CMDLINE_H
=20
+#include <asm/setup.h>
+
+extern char builtin_cmdline[COMMAND_LINE_SIZE];
+
 int cmdline_find_option_bool(const char *cmdline_ptr, const char *option);
 int cmdline_find_option(const char *cmdline_ptr, const char *option,
 			char *buffer, int bufsize);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index be5889bded49..1e0fe5f8ab84 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -462,7 +462,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		switch (c->x86_model) {
 		case 0x00 ... 0x2f:
 		case 0x40 ... 0x4f:
-		case 0x70 ... 0x7f:
+		case 0x60 ... 0x7f:
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
 			break;
 		default:
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmper=
f.c
index b3fa61d45352..0b69bfbf345d 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -306,7 +306,7 @@ static void freq_invariance_enable(void)
 		WARN_ON_ONCE(1);
 		return;
 	}
-	static_branch_enable(&arch_scale_freq_key);
+	static_branch_enable_cpuslocked(&arch_scale_freq_key);
 	register_freq_invariance_syscore_ops();
 	pr_info("Estimated ratio of average max frequency by base frequency (times =
1024): %llu\n", arch_max_freq_ratio);
 }
@@ -323,8 +323,10 @@ static void __init bp_init_freq_invariance(void)
 	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
 		return;
=20
-	if (intel_set_max_freq_ratio())
+	if (intel_set_max_freq_ratio()) {
+		guard(cpus_read_lock)();
 		freq_invariance_enable();
+	}
 }
=20
 static void disable_freq_invariance_workfn(struct work_struct *work)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 5d34cad9b7b1..6129dc2ba784 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -164,7 +164,7 @@ unsigned long saved_video_mode;
=20
 static char __initdata command_line[COMMAND_LINE_SIZE];
 #ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] =3D CONFIG_CMDLINE;
+char builtin_cmdline[COMMAND_LINE_SIZE] =3D CONFIG_CMDLINE;
 bool builtin_cmdline_added __ro_after_init;
 #endif
=20
diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index 384da1fdd5c6..c65cd5550454 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -207,18 +207,29 @@ __cmdline_find_option(const char *cmdline, int max_cmdl=
ine_size,
=20
 int cmdline_find_option_bool(const char *cmdline, const char *option)
 {
-	if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
-		WARN_ON_ONCE(!builtin_cmdline_added);
+	int ret;
=20
-	return __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
+	ret =3D __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
+	if (ret > 0)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOL) && !builtin_cmdline_added)
+		return __cmdline_find_option_bool(builtin_cmdline, COMMAND_LINE_SIZE, opti=
on);
+
+	return ret;
 }
=20
 int cmdline_find_option(const char *cmdline, const char *option, char *buffe=
r,
 			int bufsize)
 {
-	if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
-		WARN_ON_ONCE(!builtin_cmdline_added);
+	int ret;
+
+	ret =3D __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option, buffer, b=
ufsize);
+	if (ret > 0)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOL) && !builtin_cmdline_added)
+		return __cmdline_find_option(builtin_cmdline, COMMAND_LINE_SIZE, option, b=
uffer, bufsize);
=20
-	return __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option,
-				     buffer, bufsize);
+	return ret;
 }
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index a314622aa093..d066aecf8aeb 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -88,12 +88,14 @@ SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
=20
 SYM_FUNC_START(__get_user_8)
+#ifndef CONFIG_X86_64
+	xor %ecx,%ecx
+#endif
 	check_range size=3D8
 	ASM_STAC
 #ifdef CONFIG_X86_64
 	UACCESS movq (%_ASM_AX),%rdx
 #else
-	xor %ecx,%ecx
 	UACCESS movl (%_ASM_AX),%edx
 	UACCESS movl 4(%_ASM_AX),%ecx
 #endif
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 2e69abf4f852..bfdf5f45b137 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -374,14 +374,14 @@ pti_clone_pgtable(unsigned long start, unsigned long en=
d,
 			 */
 			*target_pmd =3D *pmd;
=20
-			addr +=3D PMD_SIZE;
+			addr =3D round_up(addr + 1, PMD_SIZE);
=20
 		} else if (level =3D=3D PTI_CLONE_PTE) {
=20
 			/* Walk the page-table down to the pte level */
 			pte =3D pte_offset_kernel(pmd, addr);
 			if (pte_none(*pte)) {
-				addr +=3D PAGE_SIZE;
+				addr =3D round_up(addr + 1, PAGE_SIZE);
 				continue;
 			}
=20
@@ -401,7 +401,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			/* Clone the PTE */
 			*target_pte =3D *pte;
=20
-			addr +=3D PAGE_SIZE;
+			addr =3D round_up(addr + 1, PAGE_SIZE);
=20
 		} else {
 			BUG();
@@ -496,7 +496,7 @@ static void pti_clone_entry_text(void)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_CLONE_PMD);
+			  PTI_LEVEL_KERNEL_IMAGE);
 }
=20
 /*



Return-Path: <linux-kernel+bounces-282275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DFE94E186
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED4C2815B6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EA814A4EB;
	Sun, 11 Aug 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tzzX4VLj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9d1pXVfo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2651494A8
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723384692; cv=none; b=iV/tsviaVxQvSpnhrgSECOnI398s/cYQT+fQB5oPUqcLp4kFUeaF+WcuaRP3BuwB9GPeP9b4b/3O14ix/9XXSTqG9MKYoBbMpCUPPfa7336QuC2cTg0L0UiTurJIYd8DkIk97RUMhWr+KsvGclyirp18d/pyixP5ZSRERdIy250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723384692; c=relaxed/simple;
	bh=fVaeClEZK2v4WDgb2Oswfx3WpN9hCSFa1ZQ0iBJt3ts=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=sz00YqcBkjjk3qg2XZYv96vd28PD5q/RuKNjTO7WRRb87NhNNvsfk4T5IZ3lZhgrL5lrge1BPURyFB3wTbL956AN1T/CUOmIpaWzYP3f8j08UouCvZmgNzWCWbNzdBXhW1fy87DOVgjZ4NW10PXTcXPZCmaTy/EbUMhPCxcUf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tzzX4VLj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9d1pXVfo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723384688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=7UtzTqPGlSYPUH11X7byM3k/w8gAmOkqLsJ1bf0Kge4=;
	b=tzzX4VLj9ZYnKdMH56riHQexfVZ445jt/HJpGsMhnuBo7Yq3DUo3TUC6hiygtiVwsXmsCv
	UJ/9bqMKdaabXCrts/Wn3YGP8d5j5Rvsf2PsWjmrEyjJ6ZxF5eNWOUFtomuZwUmLvdlqMn
	YYsEWOSPG2YhOk9hkr9y02FyeReY57giX4ypowEtI9Liw0NooRJMehlCWwM1of64cUtG0C
	TZq40QKE3JnaX4/+/bpYzV9v7BYknzGmXUt/4P/9zA1gXVjpMkRXCvCfktKnFfVu/5YhKT
	tGeD0n32cDGxftb6HU+5UsrUaIYITnEjgapzDN2MqvLPQq3ieVMu6b2ynkgeDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723384688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=7UtzTqPGlSYPUH11X7byM3k/w8gAmOkqLsJ1bf0Kge4=;
	b=9d1pXVfop25W2O+GSE0+hMzDtItXtfC7dbzSrrdfcVONonK96aY8+QduTtT2FWegVA0eyE
	hAF3KPi2nq0CKfBw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.11-rc3
References: 
 <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
Message-ID: 
 <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Aug 2024 15:58:08 +0200 (CEST)

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-=
08-11

up to:  919f18f961c0: x86/mtrr: Check if fixed MTRRs exist before saving them

A set of x86 fixes:

  - Fix 32-bit PTI for real. pti_clone_entry_text() is called twice, once
    before initcalls so that initcalls can use the user-mode helper and
    then again after text is set read only. Setting read only on 32-bit
    might break up the PMD mapping, which makes the second invocation of
    pti_clone_entry_text() find the mappings out of sync and failing.

    Allow the second call to split the existing PMDs in the user mapping
    and synchronize with the kernel mapping.

  - Don't make acpi_mp_wake_mailbox not read only after init as the mail
    box must be writable in the case that CPU hotplug operations happen
    after boot. Otherwise the attempt to start a CPU crashes with a write
    to read only memory.

  - Add a missing sanity check in mtrr_save_state() to ensure that the
    fixed MTRR MSRs are supported.

    Otherwise mtrr_save_state() ends up in a #GP, which is fixed up, but
    the WARN_ON() can bring systems down when panic on warn is set.

Thanks,

	tglx

------------------>
Andi Kleen (1):
      x86/mtrr: Check if fixed MTRRs exist before saving them

Chen Yu (1):
      x86/paravirt: Fix incorrect virt spinlock setting on bare metal

Thomas Gleixner (1):
      x86/mm: Fix PTI for i386 some more

Zhiquan Li (1):
      x86/acpi: Remove __ro_after_init from acpi_mp_wake_mailbox


 arch/x86/include/asm/qspinlock.h   | 12 +++++-----
 arch/x86/kernel/acpi/madt_wakeup.c |  2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  2 +-
 arch/x86/kernel/paravirt.c         |  7 +++---
 arch/x86/mm/pti.c                  | 45 ++++++++++++++++++++++++------------=
--
 5 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinloc=
k.h
index a053c1293975..68da67df304d 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -66,13 +66,15 @@ static inline bool vcpu_is_preempted(long cpu)
=20
 #ifdef CONFIG_PARAVIRT
 /*
- * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
+ * virt_spin_lock_key - disables by default the virt_spin_lock() hijack.
  *
- * Native (and PV wanting native due to vCPU pinning) should disable this ke=
y.
- * It is done in this backwards fashion to only have a single direction chan=
ge,
- * which removes ordering between native_pv_spin_init() and HV setup.
+ * Native (and PV wanting native due to vCPU pinning) should keep this key
+ * disabled. Native does not touch the key.
+ *
+ * When in a guest then native_pv_lock_init() enables the key first and
+ * KVM/XEN might conditionally disable it later in the boot process again.
  */
-DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
=20
 /*
  * Shortcut for the queued_spin_lock_slowpath() function that allows
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_w=
akeup.c
index 6cfe762be28b..d5ef6215583b 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -19,7 +19,7 @@
 static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
=20
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_=
after_init;
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
=20
 static u64 acpi_mp_pgd __ro_after_init;
 static u64 acpi_mp_reset_vector_paddr __ro_after_init;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 767bf1c71aad..2a2fc14955cd 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -609,7 +609,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
=20
-	if (!mtrr_enabled())
+	if (!mtrr_enabled() || !mtrr_state.have_fixed)
 		return;
=20
 	first_cpu =3D cpumask_first(cpu_online_mask);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5358d43886ad..fec381533555 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.tex=
t);
 DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
=20
-DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
=20
 void __init native_pv_lock_init(void)
 {
-	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
-	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		static_branch_disable(&virt_spin_lock_key);
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		static_branch_enable(&virt_spin_lock_key);
 }
=20
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index bfdf5f45b137..851ec8f1363a 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -241,7 +241,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long a=
ddress)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address, bool late_t=
ext)
 {
 	gfp_t gfp =3D (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd;
@@ -251,10 +251,15 @@ static pte_t *pti_user_pagetable_walk_pte(unsigned long=
 address)
 	if (!pmd)
 		return NULL;
=20
-	/* We can't do anything sensible if we hit a large mapping. */
+	/* Large PMD mapping found */
 	if (pmd_leaf(*pmd)) {
-		WARN_ON(1);
-		return NULL;
+		/* Clear the PMD if we hit a large mapping from the first round */
+		if (late_text) {
+			set_pmd(pmd, __pmd(0));
+		} else {
+			WARN_ON_ONCE(1);
+			return NULL;
+		}
 	}
=20
 	if (pmd_none(*pmd)) {
@@ -283,7 +288,7 @@ static void __init pti_setup_vsyscall(void)
 	if (!pte || WARN_ON(level !=3D PG_LEVEL_4K) || pte_none(*pte))
 		return;
=20
-	target_pte =3D pti_user_pagetable_walk_pte(VSYSCALL_ADDR);
+	target_pte =3D pti_user_pagetable_walk_pte(VSYSCALL_ADDR, false);
 	if (WARN_ON(!target_pte))
 		return;
=20
@@ -301,7 +306,7 @@ enum pti_clone_level {
=20
 static void
 pti_clone_pgtable(unsigned long start, unsigned long end,
-		  enum pti_clone_level level)
+		  enum pti_clone_level level, bool late_text)
 {
 	unsigned long addr;
=20
@@ -390,7 +395,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 				return;
=20
 			/* Allocate PTE in the user page-table */
-			target_pte =3D pti_user_pagetable_walk_pte(addr);
+			target_pte =3D pti_user_pagetable_walk_pte(addr, late_text);
 			if (WARN_ON(!target_pte))
 				return;
=20
@@ -452,7 +457,7 @@ static void __init pti_clone_user_shared(void)
 		phys_addr_t pa =3D per_cpu_ptr_to_phys((void *)va);
 		pte_t *target_pte;
=20
-		target_pte =3D pti_user_pagetable_walk_pte(va);
+		target_pte =3D pti_user_pagetable_walk_pte(va, false);
 		if (WARN_ON(!target_pte))
 			return;
=20
@@ -475,7 +480,7 @@ static void __init pti_clone_user_shared(void)
 	start =3D CPU_ENTRY_AREA_BASE;
 	end   =3D start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
=20
-	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
+	pti_clone_pgtable(start, end, PTI_CLONE_PMD, false);
 }
 #endif /* CONFIG_X86_64 */
=20
@@ -492,11 +497,11 @@ static void __init pti_setup_espfix64(void)
 /*
  * Clone the populated PMDs of the entry text and force it RO.
  */
-static void pti_clone_entry_text(void)
+static void pti_clone_entry_text(bool late)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_LEVEL_KERNEL_IMAGE);
+			  PTI_LEVEL_KERNEL_IMAGE, late);
 }
=20
 /*
@@ -571,7 +576,7 @@ static void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
+	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE, false);
=20
 	/*
 	 * pti_clone_pgtable() will set the global bit in any PMDs
@@ -638,8 +643,15 @@ void __init pti_init(void)
=20
 	/* Undo all global bits from the init pagetables in head_64.S: */
 	pti_set_kernel_image_nonglobal();
+
 	/* Replace some of the global bits just for shared entry text: */
-	pti_clone_entry_text();
+	/*
+	 * This is very early in boot. Device and Late initcalls can do
+	 * modprobe before free_initmem() and mark_readonly(). This
+	 * pti_clone_entry_text() allows those user-mode-helpers to function,
+	 * but notably the text is still RW.
+	 */
+	pti_clone_entry_text(false);
 	pti_setup_espfix64();
 	pti_setup_vsyscall();
 }
@@ -656,10 +668,11 @@ void pti_finalize(void)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 	/*
-	 * We need to clone everything (again) that maps parts of the
-	 * kernel image.
+	 * This is after free_initmem() (all initcalls are done) and we've done
+	 * mark_readonly(). Text is now NX which might've split some PMDs
+	 * relative to the early clone.
 	 */
-	pti_clone_entry_text();
+	pti_clone_entry_text(true);
 	pti_clone_kernel_text();
=20
 	debug_checkwx_user();



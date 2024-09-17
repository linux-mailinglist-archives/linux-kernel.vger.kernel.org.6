Return-Path: <linux-kernel+bounces-331479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF897AD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC1F283980
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF92155A4E;
	Tue, 17 Sep 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJC3mczc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="puE7relv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9215B57A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563258; cv=none; b=o4t5WsKfMpS9LJiOojPzBtaSZmV0n6HDqhwFcsheQMwWH+RHY67fnvS7AOPQI+KTvdcvw4aK23+gEE9ZYY5wk5/jTLFmrqjmmWfaxrRybX5ErK6Vh/U6dmgKFXW3SvnlffN8VMnbyeodUY/oq3fprFANRsVZKa+9uV2pPPEPTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563258; c=relaxed/simple;
	bh=zHZlLgjk5I/vi5/HJDxFKcfR9CIcAWXEiGDTSq8kT2g=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=EGuU/SnC+c/WsJI28cZ9uUxhb3SfR/AtgPpkezbjNOOT+5Zs70VaeKWPSI2KN4XHYQ+z6QpsHZKM8QCTaYOMf3ypUBgBw8QD2mG7QxpGtKnhORsAJYc+PDHF+e6FGon0X/Z5blpc3YQIpl+A/zdR9FOY007EK3ShVpKQz+eIxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJC3mczc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=puE7relv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=kCaOYakGsG+NZsCaRvcP8RMbfgYykgfVrkjdnIZvFPY=;
	b=wJC3mczc8xvHK+HQfLTIy6x/vIjAXOD4LqDdDxMNgAO6uNePHAYYtxtv4spMQNlrFr/Ptr
	7R6HrOA3A2ckkaqrvKS0Na3Gdq7GTWzixLpU8HBesgRdqn3+hNgWS7IgPWXeK0dC+k3NZj
	8ipO8aV1HQ0aBslUxyvX7spoGEhMliZwKkL+ucObqcZw0L/WuhTD+msJn1whW3bn0AiKv1
	E8xZe4TBwA3ZvKx5kznB5WVXQL9W7icldnorlXQS/605Lp1OniXAtSqILP+4N7Fl5OuJXI
	dW3episD2oNJIX/cVE699QZYKdu7wu1Khc5pKh154euxj06uVRYUJWEJWdP9AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=kCaOYakGsG+NZsCaRvcP8RMbfgYykgfVrkjdnIZvFPY=;
	b=puE7relvaoqavVhCJJkAPQIxOokPHMzimADDGGGE0xqQAY/kdeiSFqH0cwge/fdJL91T5T
	AcxnEnuUX8wg1pDA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/cleanups for v6.12-rc1
References: <172656198112.2471820.6226852046770294674.tglx@xen13>
Message-ID: <172656198437.2471820.9809446814731986690.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:54:07 +0200 (CEST)

Linus,

please pull the latest x86/cleanups branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-202=
4-09-17

up to:  a678164aadbf: x86/EISA: Dereference memory directly instead of using =
readl()

A set of cleanups across x86:

  - Use memremap() for the EISA probe instrad of ioremap(). EISA is
    strictly memory and not MMIO

  - Cleanups and enhancement all over the place

Thanks,

	tglx

------------------>
Gaosheng Cui (1):
      x86/mtrr: Remove obsolete declaration for mtrr_bp_restore()

Kai Huang (3):
      x86/sgx: Fix a W=3D1 build warning in function comment
      x86/kexec: Fix a comment of swap_pages() assembly
      x86/kexec: Add comments around swap_pages() assembly to improve readabi=
lity

Maciej W. Rozycki (2):
      x86/EISA: Use memremap() to probe for the EISA BIOS signature
      x86/EISA: Dereference memory directly instead of using readl()

Nathan Chancellor (1):
      x86/cpu_entry_area: Annotate percpu_setup_exception_stacks() as __init

Uros Bizjak (1):
      x86/boot/64: Strip percpu address space when setting up GDT descriptors

WangYuli (1):
      x86/cpu: Clarify the error message when BIOS does not support SGX

Yue Haibing (1):
      x86/extable: Remove unused declaration fixup_bug()


 arch/x86/include/asm/extable.h       |  1 -
 arch/x86/include/asm/mtrr.h          |  2 --
 arch/x86/kernel/cpu/feat_ctl.c       |  2 +-
 arch/x86/kernel/cpu/sgx/main.c       |  2 +-
 arch/x86/kernel/eisa.c               |  8 ++++----
 arch/x86/kernel/head64.c             |  3 ++-
 arch/x86/kernel/relocate_kernel_64.S | 10 +++++++---
 arch/x86/mm/cpu_entry_area.c         |  2 +-
 8 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index eeed395c3177..a0e0c6b50155 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -37,7 +37,6 @@ struct pt_regs;
=20
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
-extern int fixup_bug(struct pt_regs *regs, int trapnr);
 extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
=20
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 090d658a85a6..4218248083d9 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -69,7 +69,6 @@ extern int mtrr_add_page(unsigned long base, unsigned long =
size,
 			 unsigned int type, bool increment);
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
-extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
 void mtrr_disable(void);
@@ -117,7 +116,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long=
 end_pfn)
 	return 0;
 }
 #define mtrr_bp_init() do {} while (0)
-#define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
 #define mtrr_enable() do {} while (0)
 #define mtrr_generic_set_state() do {} while (0)
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 1640ae76548f..4a4118784c13 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -188,7 +188,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 update_sgx:
 	if (!(msr & FEAT_CTL_SGX_ENABLED)) {
 		if (enable_sgx_kvm || enable_sgx_driver)
-			pr_err_once("SGX disabled by BIOS.\n");
+			pr_err_once("SGX disabled or unsupported by BIOS.\n");
 		clear_cpu_cap(c, X86_FEATURE_SGX);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 27892e57c4ef..1a000acd933a 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -732,7 +732,7 @@ int arch_memory_failure(unsigned long pfn, int flags)
 	return 0;
 }
=20
-/**
+/*
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
  * metric.
diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index 53935b4d62e3..9535a6507db7 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -11,15 +11,15 @@
=20
 static __init int eisa_bus_probe(void)
 {
-	void __iomem *p;
+	u32 *p;
=20
 	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_G=
UEST_SEV_SNP))
 		return 0;
=20
-	p =3D ioremap(0x0FFFD9, 4);
-	if (p && readl(p) =3D=3D 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
+	p =3D memremap(0x0FFFD9, 4, MEMREMAP_WB);
+	if (p && *p =3D=3D 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
 		EISA_bus =3D 1;
-	iounmap(p);
+	memunmap(p);
 	return 0;
 }
 subsys_initcall(eisa_bus_probe);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a817ed0724d1..4b9d4557fc94 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -559,10 +559,11 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_gdt_idt(void)
 {
+	struct desc_struct *gdt =3D (void *)(__force unsigned long)init_per_cpu_var=
(gdt_page.gdt);
 	void *handler =3D NULL;
=20
 	struct desc_ptr startup_gdt_descr =3D {
-		.address =3D (unsigned long)&RIP_REL_REF(init_per_cpu_var(gdt_page.gdt)),
+		.address =3D (unsigned long)&RIP_REL_REF(*gdt),
 		.size    =3D GDT_SIZE - 1,
 	};
=20
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_=
kernel_64.S
index 042c9a0334e9..e9e88c342f75 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -170,6 +170,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	wbinvd
 .Lsme_off:
=20
+	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 	call	swap_pages
=20
@@ -258,7 +259,7 @@ SYM_CODE_END(virtual_mapped)
 	/* Do the copies */
 SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	UNWIND_HINT_END_OF_STACK
-	movq	%rdi, %rcx	/* Put the page_list in %rcx */
+	movq	%rdi, %rcx	/* Put the indirection_page in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
 	jmp	1f
@@ -289,18 +290,21 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rcx,   %rsi  /* For ever source page do a copy */
 	andq	$0xfffffffffffff000, %rsi
=20
-	movq	%rdi, %rdx
-	movq	%rsi, %rax
+	movq	%rdi, %rdx    /* Save destination page to %rdx */
+	movq	%rsi, %rax    /* Save source page to %rax */
=20
+	/* copy source page to swap page */
 	movq	%r10, %rdi
 	movl	$512, %ecx
 	rep ; movsq
=20
+	/* copy destination page to source page */
 	movq	%rax, %rdi
 	movq	%rdx, %rsi
 	movl	$512, %ecx
 	rep ; movsq
=20
+	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
 	movl	$512, %ecx
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index e91500a80963..575f863f3c75 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -164,7 +164,7 @@ static void __init percpu_setup_exception_stacks(unsigned=
 int cpu)
 	}
 }
 #else
-static inline void percpu_setup_exception_stacks(unsigned int cpu)
+static void __init percpu_setup_exception_stacks(unsigned int cpu)
 {
 	struct cpu_entry_area *cea =3D get_cpu_entry_area(cpu);
=20



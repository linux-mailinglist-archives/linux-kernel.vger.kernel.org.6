Return-Path: <linux-kernel+bounces-269863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C01D9437BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9911C225D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D716C6A9;
	Wed, 31 Jul 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZggZsor"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2516087B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460819; cv=none; b=c4MvotE/OibhCBtEtBGQDNwzrWJgeY2uJ/gYFrjCOCCre5nltbRaKRioahqYX795q0xsElQjm+ymMLpsknf6haTJD6djH1Vm/o7XgpdklDm73IbBJBwY4hYgMRKXohw0LlWFOvJcLLiPOt0vHg/u8Oh7u157SBTbfv+oc/+OYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460819; c=relaxed/simple;
	bh=1bp15DNfSTpRNqiLCsSX0hzcJSvTv3PoYFAeXRAtMSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbaaaVtfGDvD6ESdvP2DAjX55V0Vafwj+gC5goe9obwT3tu4Meclndpq0MvHcpsGkJT+KOZPKx7DoN8FVncB0sgzpTXzYb8hJETlUr6VmNxrlDvVPxMtmDKPLi6b5g38tgoXmBRssM2PIAS1UFzTlONoXfQWDbgFnjbiOPHsMlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZggZsor; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=99NOhiHSZH1mHlS99o2GcHjFtFtJkhO9crLjbw6VoOk=; b=NZggZsora5e/55H95gvBGrXXzf
	mR9NMcMUNRR65B/wT+Q6XUlN9NNzI1JSN8Xw3oQy4PREMV1S2ybiZFwOxajHj72yj7ErUaRWFp00U
	dUeSUjAWE+NHkZkAUJz3FLHcxBjIRy+sXZ2fSYGVlR9J1v7SjigArKExgvhoVC8QH0gs4n5HLbSwm
	d7EaayX5XMj710Vv+HARwHQtGrwMul0F34VdPjsi8jMsVz2El6zIbOxVuakI27XzvO/GSN/+mjH9K
	0QcMmUS9Pr/x9AU9CuGqZzVebxsF3a+scVOzmA+ZlB7Kcy8d4acz0/rnQtL3LZNnmXgAFdx/D8veO
	anlmUx4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZGjw-00000005INI-46l6;
	Wed, 31 Jul 2024 21:20:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CB669300820; Wed, 31 Jul 2024 23:20:07 +0200 (CEST)
Date: Wed, 31 Jul 2024 23:20:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731212007.GW26599@noisy.programming.kicks-ass.net>
References: <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net>
 <20240731165108.GH33588@noisy.programming.kicks-ass.net>
 <87bk2d5v83.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk2d5v83.ffs@tglx>

On Wed, Jul 31, 2024 at 07:26:04PM +0200, Thomas Gleixner wrote:
> On Wed, Jul 31 2024 at 18:51, Peter Zijlstra wrote:
> > On Wed, Jul 31, 2024 at 06:31:05PM +0200, Peter Zijlstra wrote:
> > Thomas, this all still relies on the full text section being PMD mapped,
> > and since we don't have ALIGN_ENTRY_TEXT_END and _etext has PAGE_SIZE
> > alignment, can't have a PAGE mapped tail which then doesn't get cloned?
> >
> > Do we want to make pto_clone_entry_text() use PTI_LEVEL_KERNEL_IMAGE
> > such that it will clone whatever it has?
> 
> Yes, I think so.

The alternative is ripping that level thing out entirely, and simply
duplicate anything we find in the page-tables.

We could add something like:

	WARN_ON_ONCE(IS_ENABLED(CONFIG_X86_64));

in the PTE path, but do we really care?

---
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -47,16 +47,6 @@
 #define __GFP_NOTRACK	0
 #endif
 
-/*
- * Define the page-table levels we clone for user-space on 32
- * and 64 bit.
- */
-#ifdef CONFIG_X86_64
-#define	PTI_LEVEL_KERNEL_IMAGE	PTI_CLONE_PMD
-#else
-#define	PTI_LEVEL_KERNEL_IMAGE	PTI_CLONE_PTE
-#endif
-
 static void __init pti_print_if_insecure(const char *reason)
 {
 	if (boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
@@ -294,14 +284,7 @@ static void __init pti_setup_vsyscall(vo
 static void __init pti_setup_vsyscall(void) { }
 #endif
 
-enum pti_clone_level {
-	PTI_CLONE_PMD,
-	PTI_CLONE_PTE,
-};
-
-static void
-pti_clone_pgtable(unsigned long start, unsigned long end,
-		  enum pti_clone_level level)
+static void pti_clone_pgtable(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
 
@@ -341,7 +324,7 @@ pti_clone_pgtable(unsigned long start, u
 			continue;
 		}
 
-		if (pmd_leaf(*pmd) || level == PTI_CLONE_PMD) {
+		if (pmd_leaf(*pmd)) {
 			target_pmd = pti_user_pagetable_walk_pmd(addr);
 			if (WARN_ON(!target_pmd))
 				return;
@@ -375,37 +358,33 @@ pti_clone_pgtable(unsigned long start, u
 			*target_pmd = *pmd;
 
 			addr = round_up(addr + 1, PMD_SIZE);
+			continue;
+		}
 
-		} else if (level == PTI_CLONE_PTE) {
-
-			/* Walk the page-table down to the pte level */
-			pte = pte_offset_kernel(pmd, addr);
-			if (pte_none(*pte)) {
-				addr = round_up(addr + 1, PAGE_SIZE);
-				continue;
-			}
-
-			/* Only clone present PTEs */
-			if (WARN_ON(!(pte_flags(*pte) & _PAGE_PRESENT)))
-				return;
+		/* Walk the page-table down to the pte level */
+		pte = pte_offset_kernel(pmd, addr);
+		if (pte_none(*pte)) {
+			addr = round_up(addr + 1, PAGE_SIZE);
+			continue;
+		}
 
-			/* Allocate PTE in the user page-table */
-			target_pte = pti_user_pagetable_walk_pte(addr);
-			if (WARN_ON(!target_pte))
-				return;
+		/* Only clone present PTEs */
+		if (WARN_ON(!(pte_flags(*pte) & _PAGE_PRESENT)))
+			return;
 
-			/* Set GLOBAL bit in both PTEs */
-			if (boot_cpu_has(X86_FEATURE_PGE))
-				*pte = pte_set_flags(*pte, _PAGE_GLOBAL);
+		/* Allocate PTE in the user page-table */
+		target_pte = pti_user_pagetable_walk_pte(addr);
+		if (WARN_ON(!target_pte))
+			return;
 
-			/* Clone the PTE */
-			*target_pte = *pte;
+		/* Set GLOBAL bit in both PTEs */
+		if (boot_cpu_has(X86_FEATURE_PGE))
+			*pte = pte_set_flags(*pte, _PAGE_GLOBAL);
 
-			addr = round_up(addr + 1, PAGE_SIZE);
+		/* Clone the PTE */
+		*target_pte = *pte;
 
-		} else {
-			BUG();
-		}
+		addr = round_up(addr + 1, PAGE_SIZE);
 	}
 }
 
@@ -475,7 +454,7 @@ static void __init pti_clone_user_shared
 	start = CPU_ENTRY_AREA_BASE;
 	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
 
-	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
+	pti_clone_pgtable(start, end);
 }
 #endif /* CONFIG_X86_64 */
 
@@ -495,8 +474,7 @@ static void __init pti_setup_espfix64(vo
 static void pti_clone_entry_text(void)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
-			  (unsigned long) __entry_text_end,
-			  PTI_CLONE_PMD);
+			  (unsigned long) __entry_text_end);
 }
 
 /*
@@ -571,7 +549,7 @@ static void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
+	pti_clone_pgtable(start, end_clone);
 
 	/*
 	 * pti_clone_pgtable() will set the global bit in any PMDs


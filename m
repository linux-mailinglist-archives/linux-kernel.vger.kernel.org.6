Return-Path: <linux-kernel+bounces-418828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7859D65F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5EBB23AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578011DFE2B;
	Fri, 22 Nov 2024 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B/+vrUUN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E61DFDA4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315672; cv=none; b=cDea9YBmrHiq53iI0Ofi3sPH8GhJ3/5eUYXdWifkt1bEVR9FosNMsIEEi2BN7kFXGsoQb35PTl5p49i75jyoz6u5pbZdToCMa75gNn59nO+RC5xLQl7xFVxHgcnfgZtqw7QZ0EeXtjZnnCj/u/hyVIQcyVtX5UPedtekfB6s8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315672; c=relaxed/simple;
	bh=uRUahdtDavNRTasiCR5XGsVM1KcJ5DDqEdAjGSbsx4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtl5XM4iH2UdkUYacZMNn2DNKqH6hKsYiYXRKxAEuWgXhH53Myjsf5TUTHBRYmv0r30mrGC+JZsifY6owdxMQprIQOMdyF6pixKflWoRQXpQl0Fhh2KszUi6qAIguX5vfl2XtbONKg5XUpM3Vca34Bf/lN5tX2sWZuPnbFxTWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B/+vrUUN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eNmI8QbdRntdJMuGHB3pdtes6ciQ8jd8QPd+JuE3tjw=; b=B/+vrUUNGVQSSZ80qj/dVWDO8b
	xH0sZ0Z/f2jXrKXQSO27b0NMruU6YSQ02ZyDNfo7WIMQLa0xOqJtqe6enamTcekvryT83TRiMFHL6
	Bdg5tUiYmOsRjkE0+IcHd77tHkQmPu91VLjkqHug4BFRK61Z6AJ4grOVDgo7SNjTia2LT5aA/JmNc
	9AtViSfYmDHrnnwArVF7ll9mgD7IpSYSuIqYjoLua41WniJ7cVZIKtaNASPAc426vvtuX2yG0W6UX
	vuaaGRG0MnS0C4gJYNH3Kz9xOuAV1iK3aMJ3NuX3rVvraC/B0tTukhbzcwcP9+RH5t11I8Con1GY2
	+V4gJYfA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQs-00000000ma8-00bk;
	Fri, 22 Nov 2024 22:47:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiR-0ynt;
	Fri, 22 Nov 2024 22:47:19 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org
Subject: [RFC PATCH v2 09/16] x86/kexec: Drop page_list argument from relocate_kernel()
Date: Fri, 22 Nov 2024 22:38:18 +0000
Message-ID: <20241122224715.171751-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The kernel's virtual mapping of the relocate_kernel page currently needs
to be RWX because it is written to before the %cr3 switch.

Now that the relocate_kernel page has its own .data section and local
variables, it can also have *global* variables. So eliminate the separate
page_list argument, and write the same information directly to variables
in the relocate_kernel page instead. This way, the relocate_kernel code
itself doesn't need to copy it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         | 13 +++++-----
 arch/x86/kernel/machine_kexec_64.c   | 21 +++++++---------
 arch/x86/kernel/relocate_kernel_64.S | 36 ++++++++++------------------
 3 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index ae5482a2f0ca..9af54743de90 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -8,12 +8,6 @@
 # define PA_PGD			2
 # define PA_SWAP_PAGE		3
 # define PAGES_NR		4
-#else
-# define PA_CONTROL_PAGE	0
-# define VA_CONTROL_PAGE	1
-# define PA_TABLE_PAGE		2
-# define PA_SWAP_PAGE		3
-# define PAGES_NR		4
 #endif
 
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
@@ -63,6 +57,11 @@ struct kimage;
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
+
+extern unsigned long kexec_pa_control_page;
+extern unsigned long kexec_va_control_page;
+extern unsigned long kexec_pa_table_page;
+extern unsigned long kexec_pa_swap_page;
 #endif
 
 /*
@@ -125,7 +124,7 @@ relocate_kernel(unsigned long indirection_page,
 #else
 unsigned long
 relocate_kernel(unsigned long indirection_page,
-		unsigned long page_list,
+		unsigned long pa_control_page,
 		unsigned long start_address,
 		unsigned int preserve_context,
 		unsigned int host_mem_enc_active);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 60632a5a2a13..c653c2c22d63 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -309,6 +309,13 @@ int machine_kexec_prepare(struct kimage *image)
 	result = init_pgtable(image, start_pgtable);
 	if (result)
 		return result;
+	kexec_va_control_page = (unsigned long)control_page;
+	kexec_pa_table_page =
+	  (unsigned long)__pa(page_address(image->control_code_page));
+
+	if (image->type == KEXEC_TYPE_DEFAULT)
+		kexec_pa_swap_page = (page_to_pfn(image->swap_page)
+						<< PAGE_SHIFT);
 
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
@@ -333,12 +340,11 @@ void machine_kexec_cleanup(struct kimage *image)
 void machine_kexec(struct kimage *image)
 {
 	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
-					     unsigned long page_list,
+					     unsigned long pa_control_page,
 					     unsigned long start_address,
 					     unsigned int preserve_context,
 					     unsigned int host_mem_enc_active);
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
-	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
 	void *control_page;
@@ -376,15 +382,6 @@ void machine_kexec(struct kimage *image)
 
 	control_page = page_address(image->control_code_page) + PAGE_SIZE;
 
-	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
-	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-	page_list[PA_TABLE_PAGE] =
-	  (unsigned long)__pa(page_address(image->control_code_page));
-
-	if (image->type == KEXEC_TYPE_DEFAULT)
-		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
-						<< PAGE_SHIFT);
-
 	/*
 	 * Allow for the possibility that relocate_kernel might not be at
 	 * the very start of the page.
@@ -412,7 +409,7 @@ void machine_kexec(struct kimage *image)
 
 	/* now call it */
 	image->start = relocate_kernel_ptr((unsigned long)image->head,
-					   (unsigned long)page_list,
+					   virt_to_phys(control_page),
 					   image->start,
 					   image->preserve_context,
 					   host_mem_enc_active);
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 445ca56dabbe..b9ad3ef0b982 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -34,9 +34,9 @@ SYM_DATA_LOCAL(saved_cr0, .quad 0)
 SYM_DATA_LOCAL(saved_cr3, .quad 0)
 SYM_DATA_LOCAL(saved_cr4, .quad 0)
 	/* other data */
-SYM_DATA_LOCAL(va_control_page, .quad 0)
-SYM_DATA_LOCAL(pa_table_page, .quad 0)
-SYM_DATA_LOCAL(pa_swap_page, .quad 0)
+SYM_DATA(kexec_va_control_page, .quad 0)
+SYM_DATA(kexec_pa_table_page, .quad 0)
+SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
 	.section .text.relocate_kernel,"ax";
@@ -46,7 +46,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	ANNOTATE_NOENDBR
 	/*
 	 * %rdi indirection_page
-	 * %rsi page_list
+	 * %rsi pa_control_page
 	 * %rdx start address
 	 * %rcx preserve_context
 	 * %r8  host_mem_enc_active
@@ -79,31 +79,19 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Save SME active flag */
 	movq	%r8, %r12
 
-	/*
-	 * get physical and virtual address of control page now
-	 * this is impossible after page table switch
-	 */
-	movq	PTR(PA_CONTROL_PAGE)(%rsi), %r8
-	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
-
-	/* get physical address of page table now too */
-	movq	PTR(PA_TABLE_PAGE)(%rsi), %r9
-
-	/* get physical address of swap page now */
-	movq	PTR(PA_SWAP_PAGE)(%rsi), %r10
-
-	/* save some information for jumping back */
-	movq	%r9, pa_table_page(%rip)
-	movq	%r10, pa_swap_page(%rip)
+	/* save indirection list for jumping back */
 	movq	%rdi, pa_backup_pages_map(%rip)
-	movq	%r11, va_control_page(%rip)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 
 	/* Switch to the identity mapped page tables */
+	movq	kexec_pa_table_page(%rip), %r9
 	movq	%r9, %cr3
 
+	/* Physical address of control page */
+	movq    %rsi, %r8
+
 	/* setup a new stack at the end of the physical control page */
 	lea	PAGE_SIZE(%r8), %rsp
 
@@ -227,13 +215,13 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* get the re-entry point of the peer system */
 	movq	0(%rsp), %rbp
 	leaq	relocate_kernel(%rip), %r8
-	movq	pa_swap_page(%rip), %r10
+	movq	kexec_pa_swap_page(%rip), %r10
 	movq	pa_backup_pages_map(%rip), %rdi
-	movq	pa_table_page(%rip), %rax
+	movq	kexec_pa_table_page(%rip), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	va_control_page(%rip), %rax
+	movq	kexec_va_control_page(%rip), %rax
 	addq	$(virtual_mapped - relocate_kernel), %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE
-- 
2.47.0



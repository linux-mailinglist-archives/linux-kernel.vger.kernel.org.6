Return-Path: <linux-kernel+bounces-423859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374B09DAD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA252849DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0A205E2C;
	Wed, 27 Nov 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZhEQPA9v"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30844203708
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734252; cv=none; b=bHM29rajUadqXx650vqEwEnlSGrLQWjmNrDKumw17tE0I14C+hwih1yzs5cLuzbaHZlGjm168kHCW0QD6uPbx6jp81THhT+J9KS8zeD0qq6azXxSfcYJrr36p9DvTMNpwswO8vSmAMBlumr0sy7vNA76uI2Mi9piMNDMm/lHiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734252; c=relaxed/simple;
	bh=kUbjanEXjddFgktas16TK/9UQEactJwhG2rx0T5+mxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcFPoA+2+18ggegencd9l2OhR/TZNchISqyV+QPFZGnQHHVTjqzKAw4LjNAdWJj0AcqDUVt4Oe8BFIznZBu8tucGMd57rTc4ZUc8YKVxObleYWcqUxc5vJrj6LGB8etwG128pyLCXgHaI3WiMN10m0CdOCREJsBrjFjX10t7BE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZhEQPA9v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y4llxN1150m5VJE0hmL7LsJF75dL//a2jb4zHWMLskg=; b=ZhEQPA9v058lCWo6BA0DdXpU8t
	4cO4Y4bJ182spc8JTetBfGW/mk0wHAjb14b5Dyd2pyiTm6K3Co4sXcm3Hcodux6oDlzSpwgpnwwcX
	dY2FQKoev3uaIVEO6UVDrfo+g3eAxI2LLGefgaPijYH1BRag77BW/uYp72e4X1RurD2F9Whu8Mn0L
	CM+HI5E1OUZFtn0PPboNX1SWymJ8LsnXXfdeBykm+XRQbNWOTNbPzae/6AUTk9tNR3RCQ7217h5b5
	jb++0Xcn0RMJg7Hupw04+UCPLXcSpFw0SYFnrg2CsHEw+XzHYVWtLeWPUGnZLOEknZUfsMNldjtie
	CmyB0DCQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKD-00000001cWB-1XV7;
	Wed, 27 Nov 2024 19:03:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000Biq-1bsr;
	Wed, 27 Nov 2024 19:03:46 +0000
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
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [RFC PATCH v4 11/20] x86/kexec: Drop page_list argument from relocate_kernel()
Date: Wed, 27 Nov 2024 19:00:25 +0000
Message-ID: <20241127190343.44916-12-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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
 arch/x86/include/asm/kexec.h         | 12 ++++------
 arch/x86/kernel/machine_kexec_64.c   | 18 ++++++--------
 arch/x86/kernel/relocate_kernel_64.S | 36 ++++++++++------------------
 3 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index ccb8ff37fa9d..48e4f44f794f 100644
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
 
 # define KEXEC_CONTROL_PAGE_SIZE	4096
@@ -60,6 +54,10 @@ struct kimage;
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
+
+extern unsigned long kexec_va_control_page;
+extern unsigned long kexec_pa_table_page;
+extern unsigned long kexec_pa_swap_page;
 #endif
 
 /*
@@ -122,7 +120,7 @@ relocate_kernel(unsigned long indirection_page,
 #else
 unsigned long
 relocate_kernel(unsigned long indirection_page,
-		unsigned long page_list,
+		unsigned long pa_control_page,
 		unsigned long start_address,
 		unsigned int preserve_context,
 		unsigned int host_mem_enc_active);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 63dca5c595f6..c9fd60f8f806 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -315,6 +315,11 @@ int machine_kexec_prepare(struct kimage *image)
 	result = init_pgtable(image, __pa(control_page));
 	if (result)
 		return result;
+	kexec_va_control_page = (unsigned long)control_page;
+	kexec_pa_table_page = (unsigned long)__pa(image->arch.pgd);
+
+	if (image->type == KEXEC_TYPE_DEFAULT)
+		kexec_pa_swap_page = page_to_pfn(image->swap_page) << PAGE_SHIFT;
 
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
@@ -339,12 +344,11 @@ void machine_kexec_cleanup(struct kimage *image)
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
@@ -382,14 +386,6 @@ void machine_kexec(struct kimage *image)
 
 	control_page = page_address(image->control_code_page);
 
-	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
-	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-	page_list[PA_TABLE_PAGE] = (unsigned long)__pa(image->arch.pgd);
-
-	if (image->type == KEXEC_TYPE_DEFAULT)
-		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
-						<< PAGE_SHIFT);
-
 	/*
 	 * Allow for the possibility that relocate_kernel might not be at
 	 * the very start of the page.
@@ -417,7 +413,7 @@ void machine_kexec(struct kimage *image)
 
 	/* now call it */
 	image->start = relocate_kernel_ptr((unsigned long)image->head,
-					   (unsigned long)page_list,
+					   virt_to_phys(control_page),
 					   image->start,
 					   image->preserve_context,
 					   host_mem_enc_active);
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 469af51589ee..16f123527406 100644
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



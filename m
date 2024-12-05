Return-Path: <linux-kernel+bounces-433562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9732A9E59D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F63285784
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24F229B00;
	Thu,  5 Dec 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kkTag37B"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804FC221470
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412846; cv=none; b=drw28BROEUyXqsQXip+eOKwCzMSfwhmCsVYGQHgdebJkwof0nawicy5uPzPRSVFrPWWXc/1k0C7OGwSDO8ejAEzTrAm+9KtWrSzN3gQjd5PJ15jiFoKxF22YhpOGLzLDjXSRN8p4fp4PVAVp2GihqwdtXv5ZhgzFXFTmL604rjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412846; c=relaxed/simple;
	bh=h9T1Us79rG5zNlNiqErNkmovUuy+vDBk3u4+TWO3n5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJvcWqXGvW22RMKDwH0o0xejSZrcya7PoZY8pkAduNfAcNJQcM5i/swcFVPiDPEo+uEhh48jm6i1X9QHTNI9UZXPwt7ho5EyawY6diVQG+yctqUDODYNm0E9m4xnQIUDe3Y1RHtJUM8nH+z3d128Di6bdXudYExDpEq0NeQiYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kkTag37B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DHyuUfLXwZ8dNR2vFEDqrk7NrFvfuBvjwmzlKRQQKmc=; b=kkTag37Brihmz++oUOdAGFVxIE
	T0NpDJA9yrf4Mt4Gik9Be1mUoqY4CWMFAZaMpIvHP22fByx4Do6ZXD3gq3d6nVa5+hUdVcOmjBSKh
	tQD4iOCVccBvD+NuF8cZoY8fY1mDURbROHwIG3gMf9/J5jS2awjsmsyHvFhMqvLZupJryRprqB4hM
	8s2VwdwOwhSqiLl9XUdw4FfB0c5zX2O9LSAeH2BH7wsnXND/utG1coqpzNdSs059qNaTEcG0msf72
	WOpn4Q+o5EMaQPPY1tsW/LlkZX37uAZn+S8br4PB2cfuuPyCYdz5DWUpkPOYZG/T5g6K6XQbEcb5w
	SsJAR+cQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrM-0000000DDp1-1sRT;
	Thu, 05 Dec 2024 15:33:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyLb-1z0t;
	Thu, 05 Dec 2024 15:33:45 +0000
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
Subject: [PATCH v5 07/20] x86/kexec: Invoke copy of relocate_kernel() instead of the original
Date: Thu,  5 Dec 2024 15:05:13 +0000
Message-ID: <20241205153343.3275139-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
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

This currently calls set_memory_x() from machine_kexec_prepare() just
like the 32-bit version does. That's actually a bit earlier than I'd
like, as it leaves the page RWX all the time the image is even *loaded*.

Subsequent commits will eliminate all the writes to the page between the
point it's marked executable in machine_kexec_prepare() the time that
relocate_kernel() is running and has switched to the identmap %cr3, so
that it can be ROX. But that can't happen until it's moved to the .data
section of the kernel, and *that* can't happen until we start executing
the copy instead of executing it in place in the kernel .text. So break
the circular dependency in those commits by letting it be RWX for now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   | 30 ++++++++++++++++++++++------
 arch/x86/kernel/relocate_kernel_64.S |  5 ++++-
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3a4cbac1a0c6..9567347f7a9b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -157,7 +157,12 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd,
 	pmd_t *pmd;
 	pte_t *pte;
 
-	vaddr = (unsigned long)relocate_kernel;
+	/*
+	 * For the transition to the identity mapped page tables, the control
+	 * code page also needs to be mapped at the virtual address it starts
+	 * off running from.
+	 */
+	vaddr = (unsigned long)__va(control_page);
 	paddr = control_page;
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
@@ -311,11 +316,17 @@ int machine_kexec_prepare(struct kimage *image)
 
 	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
+	set_memory_x((unsigned long)control_page, 1);
+
 	return 0;
 }
 
 void machine_kexec_cleanup(struct kimage *image)
 {
+	void *control_page = page_address(image->control_code_page);
+
+	set_memory_nx((unsigned long)control_page, 1);
+
 	free_transition_pgtable(image);
 }
 
@@ -325,6 +336,11 @@ void machine_kexec_cleanup(struct kimage *image)
  */
 void machine_kexec(struct kimage *image)
 {
+	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
+					     unsigned long page_list,
+					     unsigned long start_address,
+					     unsigned int preserve_context,
+					     unsigned int host_mem_enc_active);
 	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
@@ -371,6 +387,8 @@ void machine_kexec(struct kimage *image)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
 						<< PAGE_SHIFT);
 
+	relocate_kernel_ptr = control_page;
+
 	/*
 	 * The segment registers are funny things, they have both a
 	 * visible and an invisible part.  Whenever the visible part is
@@ -390,11 +408,11 @@ void machine_kexec(struct kimage *image)
 	native_gdt_invalidate();
 
 	/* now call it */
-	image->start = relocate_kernel((unsigned long)image->head,
-				       (unsigned long)page_list,
-				       image->start,
-				       image->preserve_context,
-				       host_mem_enc_active);
+	image->start = relocate_kernel_ptr((unsigned long)image->head,
+					   (unsigned long)page_list,
+					   image->start,
+					   image->preserve_context,
+					   host_mem_enc_active);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 50cc33f2ecb7..b48bd82843fd 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,7 @@
 #define CP_PA_TABLE_PAGE	DATA(0x20)
 #define CP_PA_SWAP_PAGE		DATA(0x28)
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
+#define CP_VA_CONTROL_PAGE	DATA(0x38)
 
 	.text
 	.align PAGE_SIZE
@@ -99,6 +100,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%r9, CP_PA_TABLE_PAGE(%r11)
 	movq	%r10, CP_PA_SWAP_PAGE(%r11)
 	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
+	movq	%r11, CP_VA_CONTROL_PAGE(%r11)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
@@ -235,7 +237,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
+	movq	CP_VA_CONTROL_PAGE(%r8), %rax
+	addq	$(virtual_mapped - relocate_kernel), %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE
 	ret
-- 
2.47.0



Return-Path: <linux-kernel+bounces-433548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907969E59C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7DA286989
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8545222587;
	Thu,  5 Dec 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H6NUMV6e"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75421C164
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412842; cv=none; b=hsfIooY7Fl5N1hMil/InuJy5WsHwiyOFKGK4DFFmkTCiIeTYm5vWjEfax156n9mnflWXYZRj+WjvBAUFxMx97b3X9niYl8V4OgOSg0WlgX0qB37Ktg+ViChOiL1nz378iOk2KHyYuQE/e6xQlDmJyG1M++W2E0yO47fCKREb/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412842; c=relaxed/simple;
	bh=FnjULSBzw/5x2nqh5fEY8NoswemDBo5mH3L03jLEDTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilDf8tp1ffq3kTkll5XAi4TeaQENhg72eiteRImT6M+9pn/8dk/UOZVpoWnRsZIm4Yc116QkmOKfp8jIV9HAlzLvlxQuuE8zr7aKbijI+YV4RZhE8QGRiYZRPsU/IZ1wSy/4F+BKPzRpRcwckmFTP5p07vGlYipj+h+LzxGd5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H6NUMV6e; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O9h+1X3o4WcRcg3Vz9yCPXTiAmVXYaU5B6MeGcLgIQo=; b=H6NUMV6eRjCPceTglhVV994tZB
	wB5yGaMfW5kG95rbO6OCB5GLFKbu+4Yqrxf+//wcwCb83yNpVhxudsWFA2sUD4v8nQrE8fbAEmiSg
	Cf84o1kuwOJhhwUt6u5yIsup+WNMl4Lifq5wXhCFHq/sXKY++FuMT3mtc5PPu7s+mDD7mleDotgSx
	q+irsb39imSzAVOWsqVbHJF8eFSYhZb4K24nPONR4nuNnWdU25+mnBl1Ea1VL9BOPkHPJRO3EnJpG
	QAmFfgqedZa4jIU00KPlSkT/aKpIT70Gu/ydKBPXGia3ZHhPcCGlN/skqkOisIxcWYO5V/ttN5X3P
	BfNT9Tyg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-00000002wEv-35yD;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyLn-2Hcu;
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
Subject: [PATCH v5 09/20] x86/kexec: Add data section to relocate_kernel
Date: Thu,  5 Dec 2024 15:05:15 +0000
Message-ID: <20241205153343.3275139-10-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Now that the relocate_kernel page is handled sanely by a linker script
we can have actual data, and just use %rip-relative addressing to access
it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   |  8 +++-
 arch/x86/kernel/relocate_kernel_64.S | 62 ++++++++++++++--------------
 arch/x86/kernel/vmlinux.lds.S        |  1 +
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 23dffdc070dd..63dca5c595f6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -343,6 +343,7 @@ void machine_kexec(struct kimage *image)
 					     unsigned long start_address,
 					     unsigned int preserve_context,
 					     unsigned int host_mem_enc_active);
+	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
 	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
@@ -389,7 +390,12 @@ void machine_kexec(struct kimage *image)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
 						<< PAGE_SHIFT);
 
-	relocate_kernel_ptr = control_page;
+	/*
+	 * Allow for the possibility that relocate_kernel might not be at
+	 * the very start of the page.
+	 */
+	relocate_kernel_ptr = control_page + (unsigned long)relocate_kernel -
+		reloc_start;
 
 	/*
 	 * The segment registers are funny things, they have both a
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 01138f862c59..469af51589ee 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -23,23 +23,21 @@
 #define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 
 /*
- * control_page + KEXEC_CONTROL_CODE_MAX_SIZE
- * ~ control_page + PAGE_SIZE are used as data storage and stack for
- * jumping back
+ * The .text.relocate_kernel and .data.relocate_kernel sections are copied
+ * into the control page, and the remainder of the page is used as the stack.
  */
-#define DATA(offset)		(KEXEC_CONTROL_CODE_MAX_SIZE+(offset))
 
+	.section .data.relocate_kernel,"a";
 /* Minimal CPU state */
-#define RSP			DATA(0x0)
-#define CR0			DATA(0x8)
-#define CR3			DATA(0x10)
-#define CR4			DATA(0x18)
-
-/* other data */
-#define CP_PA_TABLE_PAGE	DATA(0x20)
-#define CP_PA_SWAP_PAGE		DATA(0x28)
-#define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
-#define CP_VA_CONTROL_PAGE	DATA(0x38)
+SYM_DATA_LOCAL(saved_rsp, .quad 0)
+SYM_DATA_LOCAL(saved_cr0, .quad 0)
+SYM_DATA_LOCAL(saved_cr3, .quad 0)
+SYM_DATA_LOCAL(saved_cr4, .quad 0)
+	/* other data */
+SYM_DATA_LOCAL(va_control_page, .quad 0)
+SYM_DATA_LOCAL(pa_table_page, .quad 0)
+SYM_DATA_LOCAL(pa_swap_page, .quad 0)
+SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
 	.section .text.relocate_kernel,"ax";
 	.code64
@@ -63,14 +61,13 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq %r15
 	pushf
 
-	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
-	movq	%rsp, RSP(%r11)
+	movq	%rsp, saved_rsp(%rip)
 	movq	%cr0, %rax
-	movq	%rax, CR0(%r11)
+	movq	%rax, saved_cr0(%rip)
 	movq	%cr3, %rax
-	movq	%rax, CR3(%r11)
+	movq	%rax, saved_cr3(%rip)
 	movq	%cr4, %rax
-	movq	%rax, CR4(%r11)
+	movq	%rax, saved_cr4(%rip)
 
 	/* Save CR4. Required to enable the right paging mode later. */
 	movq	%rax, %r13
@@ -83,10 +80,11 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%r8, %r12
 
 	/*
-	 * get physical address of control page now
+	 * get physical and virtual address of control page now
 	 * this is impossible after page table switch
 	 */
 	movq	PTR(PA_CONTROL_PAGE)(%rsi), %r8
+	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
 
 	/* get physical address of page table now too */
 	movq	PTR(PA_TABLE_PAGE)(%rsi), %r9
@@ -95,10 +93,10 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	PTR(PA_SWAP_PAGE)(%rsi), %r10
 
 	/* save some information for jumping back */
-	movq	%r9, CP_PA_TABLE_PAGE(%r11)
-	movq	%r10, CP_PA_SWAP_PAGE(%r11)
-	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
-	movq	%r11, CP_VA_CONTROL_PAGE(%r11)
+	movq	%r9, pa_table_page(%rip)
+	movq	%r10, pa_swap_page(%rip)
+	movq	%rdi, pa_backup_pages_map(%rip)
+	movq	%r11, va_control_page(%rip)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
@@ -229,13 +227,13 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* get the re-entry point of the peer system */
 	movq	0(%rsp), %rbp
 	leaq	relocate_kernel(%rip), %r8
-	movq	CP_PA_SWAP_PAGE(%r8), %r10
-	movq	CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
-	movq	CP_PA_TABLE_PAGE(%r8), %rax
+	movq	pa_swap_page(%rip), %r10
+	movq	pa_backup_pages_map(%rip), %rdi
+	movq	pa_table_page(%rip), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	CP_VA_CONTROL_PAGE(%r8), %rax
+	movq	va_control_page(%rip), %rax
 	addq	$(virtual_mapped - relocate_kernel), %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE
@@ -246,11 +244,11 @@ SYM_CODE_END(identity_mapped)
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR // RET target, above
-	movq	RSP(%r8), %rsp
-	movq	CR4(%r8), %rax
+	movq	saved_rsp(%rip), %rsp
+	movq	saved_cr4(%rip), %rax
 	movq	%rax, %cr4
-	movq	CR3(%r8), %rax
-	movq	CR0(%r8), %r8
+	movq	saved_cr3(%rip), %rax
+	movq	saved_cr0(%rip), %r8
 	movq	%rax, %cr3
 	movq	%r8, %cr0
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 17ebaa441e87..7304e5b4bf60 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -101,6 +101,7 @@ const_pcpu_hot = pcpu_hot;
 	. = ALIGN(0x100);					\
 	__relocate_kernel_start = .;				\
 	*(.text.relocate_kernel);				\
+	*(.data.relocate_kernel);				\
 	__relocate_kernel_end = .;
 
 ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX_SIZE,
-- 
2.47.0



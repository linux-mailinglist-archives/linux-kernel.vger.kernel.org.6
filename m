Return-Path: <linux-kernel+bounces-418827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AC19D65EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F61B23A08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF211DFE26;
	Fri, 22 Nov 2024 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UsmPB4sb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD391DFD9C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315672; cv=none; b=T7F7iplJ0wik6+Gj6nkDD6VeZdnkpQFCwi2sq87Scf4LqxChHagYBaxpFVvbdYQQhXDn2DzJX6L/aM1edXaBecfLrBc8+jhWxEZAFfkMvjFXa4qKzR5Uzh5N5tirXBZlwxoBGXnIIDPOWoGot62OuPJe/U1ar51bvNV4A8dozfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315672; c=relaxed/simple;
	bh=1CQpF3bpcbIZMdH+g7V2kqts4I2IkYRuvHmPq1r0U4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvO/egxN7IugTiDhPrrXQhAX5gH4d1hXgwaILSZTPz8Sfstl+W+YvrCom/JNkkgRpBzu2rQWMOsfPtLE1CNHgruj513m4ZeFzdhHNEGBru/0z77USDX59tSORs44uLCkFi+Z0e8OHy09rxZaxrgDJDDuTGm3/+qK+tU8P3kfda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UsmPB4sb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=F1IMqtYJfaw0RknrZ4o5TbPrvhsDQP3o18Mfcsk2flo=; b=UsmPB4sblATqM+wzwEDUH9lkVB
	mJlOVBqgcjNqdKGVDae0KRt7YK2L5snkYDXeKmPdrSA1tJDvsPEdvAruBkUHcje5TelVaPyOps+6b
	+GoGK4U0MQRguLrsaP54+dJOtlev60+lKdm6DCSurBvzisgsiwJ6nxx9pVKsh6Yx+VkcMxHpXLBA/
	Wj0QtCvCDfs8ChUEnvgkMoFXSzf+uhu74yRlv3fKIRhby9fev7408PutbBh8yk8JTz5fIvPV6YPI7
	7CtydXLrkJZ5TM/iUHlbDFQSe0iIduXYNsVzXtrqwnfSBsf/ctektIKjxshur2I0GEfHO4Xzmdbzf
	IpxFLbIQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQs-00000000ma7-001i;
	Fri, 22 Nov 2024 22:47:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiL-0aRO;
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
Subject: [RFC PATCH v2 07/16] x86/kexec: Add data section to relocate_kernel
Date: Fri, 22 Nov 2024 22:38:16 +0000
Message-ID: <20241122224715.171751-8-dwmw2@infradead.org>
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

Now that the relocate_kernel page is handled sanely by a linker script
we can have actual data, and just use %rip-relative addressing to access
it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   |  7 +++-
 arch/x86/kernel/relocate_kernel_64.S | 62 ++++++++++++++--------------
 arch/x86/kernel/vmlinux.lds.S        |  1 +
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 048868d868ce..123e9544506b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -383,7 +383,12 @@ void machine_kexec(struct kimage *image)
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
index 085dddf79476..445ca56dabbe 100644
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
index 925a821134b5..324c1c42faae 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -100,6 +100,7 @@ const_pcpu_hot = pcpu_hot;
 	. = ALIGN(0x100);					\
 	__relocate_kernel_start = .;				\
 	*(.text.relocate_kernel);				\
+	*(.data.relocate_kernel);				\
 	__relocate_kernel_end = .;
 #else
 #define KEXEC_RELOCATE_KERNEL
-- 
2.47.0



Return-Path: <linux-kernel+bounces-420791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2019D8318
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A7E162CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89319E819;
	Mon, 25 Nov 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wS/eSmnp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01B1922ED
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529316; cv=none; b=oFBnBtwliwBW5sKK0Q4eXMtTmzJ97rtVnPmwD2kVFijBehxOemTsVQKIPbeNdkc0+f5CPPMT5RcNj5Ug6ehuiWtCoC7INbV9E376nBPu1bvAIH/ShsPzkacg77zgsyncSbmaUvYBjP2Rsb70+J6DbzXCb9ocuEdmrdZY6L1G+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529316; c=relaxed/simple;
	bh=7iHAYI8cuCh2JNJIm2Bxm26kHD7vWrGnCgYM9/c4Pbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+vSKACUnfglGXFOR2YjMBO66BXZUbKAGLv4gjIjbaQ0d0BzyAla+TRa7yUwSw9jCMrNggVE4kHKkLBl19cWg0HE3sX8fd7yHBuRZeem/nyxNaAFVXzkgnVw0LuS7W0RmN+KmDNp6+GRJEiTzRSuzgqttN2oEdg/V+lWwmwR9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wS/eSmnp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3lozAiWTUlary5HhI59k81gofGJ4AbxVflT6xIoJcCc=; b=wS/eSmnpw1lANg2cM0+yxkzrVe
	yJZ37a6cz/GyJ68vGzKagWw5Pncqmh2vkFvQqMYEIxPi2Q9wxd/XxxjyMSiDinkydEZlpl8BUSmpv
	I5+JFnFoTVhPfmv+Ug2AobBBWo2G5UfSlO0QIvR1/uZxiR8t/h7GPmlQqkLev8/8DsoLETpJF0m7M
	VLCe3ExpGniXBdIKOyHDhttE2mn6BXE1AKkBU4ZluJdOXqHdjPXk0oIwP44rhVGo4iZ+dPxE2OY7q
	nQ62O6HHHvirgTJIfxSjE6Zuisvn7otQuNJbG1fpgi4KNmsZs8cSj31xQ7PoKcPqKJrOTtSW3G1bb
	nxfUCeTA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW10-0000000BirB-12V3;
	Mon, 25 Nov 2024 10:08:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000lj-3xmJ;
	Mon, 25 Nov 2024 10:08:21 +0000
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
Subject: [RFC PATCH v3 17/20] x86/kexec: Debugging support: Load an IDT and basic exception entry points
Date: Mon, 25 Nov 2024 09:54:47 +0000
Message-ID: <20241125100815.2512-18-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         |  5 ++
 arch/x86/kernel/machine_kexec_64.c   | 23 ++++++++
 arch/x86/kernel/relocate_kernel_64.S | 82 ++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 48e4f44f794f..c14b0a2704c0 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -8,6 +8,9 @@
 # define PA_PGD			2
 # define PA_SWAP_PAGE		3
 # define PAGES_NR		4
+#else
+/* Size of each exception handler referenced by the IDT */
+# define KEXEC_DEBUG_EXC_HANDLER_SIZE	6 /* pushi, pushi, 2-byte jmp */
 #endif
 
 # define KEXEC_CONTROL_PAGE_SIZE	4096
@@ -58,6 +61,8 @@ struct kimage;
 extern unsigned long kexec_va_control_page;
 extern unsigned long kexec_pa_table_page;
 extern unsigned long kexec_pa_swap_page;
+extern gate_desc kexec_debug_idt[];
+extern unsigned char kexec_debug_exc_vectors[];
 #endif
 
 /*
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c51e688c1f91..dfb1722622bd 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -310,6 +310,26 @@ static void load_segments(void)
 		);
 }
 
+static void prepare_debug_idt(unsigned long control_page, unsigned long vec_ofs)
+{
+#ifdef CONFIG_KEXEC_DEBUG
+	gate_desc idtentry = { 0 };
+	int i;
+
+	idtentry.bits.p = 1;
+	idtentry.bits.type = GATE_TRAP;
+	idtentry.segment = __KERNEL_CS;
+	idtentry.offset_low = (control_page & 0xFFFF) + vec_ofs;
+	idtentry.offset_middle = (control_page >> 16) & 0xFFFF;
+	idtentry.offset_high = control_page >> 32;
+
+	for (i = 0; i < 16; i++) {
+		kexec_debug_idt[i] = idtentry;
+		idtentry.offset_low += KEXEC_DEBUG_EXC_HANDLER_SIZE;
+	}
+#endif
+}
+
 int machine_kexec_prepare(struct kimage *image)
 {
 	void *control_page = page_address(image->control_code_page);
@@ -327,6 +347,9 @@ int machine_kexec_prepare(struct kimage *image)
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		kexec_pa_swap_page = page_to_pfn(image->swap_page) << PAGE_SHIFT;
 
+	prepare_debug_idt((unsigned long)__pa(control_page),
+			  (unsigned long)kexec_debug_exc_vectors - reloc_start);
+
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	set_memory_rox((unsigned long)control_page, 1);
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 6c6bfdccfe6a..2179f691a45b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -49,6 +49,12 @@ SYM_DATA_START_LOCAL(kexec_debug_gdt)
 	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
 	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
 SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
+
+	.balign 8
+SYM_DATA_START(kexec_debug_idt)
+	.skip 0x100, 0x00
+SYM_DATA_END(kexec_debug_idt)
+
 #endif /* CONFIG_KEXEC_DEBUG */
 
 	.section .text.relocate_kernel,"ax";
@@ -108,6 +114,11 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	int3
 SYM_CODE_END(relocate_kernel)
 
+#ifdef DEBUG
+	UNWIND_HINT_UNDEFINED
+	.balign 0x100	/* relocate_kernel will be overwritten with an IDT */
+#endif
+
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	UNWIND_HINT_END_OF_STACK
 	/*
@@ -137,6 +148,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* Test that we can load segments */
 	movq	%ds, %rax
 	movq	%rax, %ds
+
+	/* Now an IDTR on the stack to load the IDT the kernel created */
+	leaq	kexec_debug_idt(%rip), %rsi
+	pushq	%rsi
+	pushw	$0xff
+	lidt	(%rsp)
+	addq	$10, %rsp
+
+	//int3
 #endif /* CONFIG_KEXEC_DEBUG */
 
 	/*
@@ -346,3 +366,65 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	ret
 	int3
 SYM_CODE_END(swap_pages)
+
+#ifdef CONFIG_KEXEC_DEBUG
+SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
+	/* Each of these is 6 bytes. */
+.macro vec_err exc
+	UNWIND_HINT_ENTRY
+	. = kexec_debug_exc_vectors + (\exc * KEXEC_DEBUG_EXC_HANDLER_SIZE)
+	nop
+	nop
+	pushq	$\exc
+	jmp	exc_handler
+.endm
+
+.macro vec_noerr exc
+	UNWIND_HINT_ENTRY
+	. = kexec_debug_exc_vectors + (\exc * KEXEC_DEBUG_EXC_HANDLER_SIZE)
+	pushq	$0
+	pushq	$\exc
+	jmp	exc_handler
+.endm
+
+	ANNOTATE_NOENDBR
+	vec_noerr 0 // #DE
+	vec_noerr 1 // #DB
+	vec_noerr 2 // #NMI
+	vec_noerr 3 // #BP
+	vec_noerr 4 // #OF
+	vec_noerr 5 // #BR
+	vec_noerr 6 // #UD
+	vec_noerr 7 // #NM
+	vec_err 8   // #DF
+	vec_noerr 9
+	vec_err 10 // #TS
+	vec_err 11 // #NP
+	vec_err 12 // #SS
+	vec_err 13 // #GP
+	vec_err 14 // #PF
+	vec_noerr 15
+SYM_CODE_END(kexec_debug_exc_vectors)
+
+SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
+	pushq	%rax
+	pushq	%rdx
+	movw	$0x3f8, %dx
+	movb	$'A', %al
+	outb	%al, %dx
+	popq	%rdx
+	popq	%rax
+
+	/* Only return from int3 */
+	cmpq	$3, (%rsp)
+	jne	.Ldie
+
+	addq	$16, %rsp
+	iretq
+
+.Ldie:
+	hlt
+	jmp	.Ldie
+
+SYM_CODE_END(exc_handler)
+#endif /* CONFIG_KEXEC_DEBUG */
-- 
2.47.0



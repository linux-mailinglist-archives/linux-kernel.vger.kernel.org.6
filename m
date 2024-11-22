Return-Path: <linux-kernel+bounces-418822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F609D65E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED447283921
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55CC1C4A37;
	Fri, 22 Nov 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qxKUp010"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722718C033
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315666; cv=none; b=ZreZRoOOgJUrSeYb0nqOpMQexpz+Vkp5IOrUNbFzFeNhTtnwCuW5mRvcs7VggPdfYu3I2wQelIooidGeZV61RNdJFVEU7apRD8FZoqBKgfPjQp4Wc71ZjCc7b5NI6jvywqtj//JEVCClLpYhJkCy92EMCVk0qlfxZezlCZTvIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315666; c=relaxed/simple;
	bh=mm6W+60mWEXMtTcR54u9llsIS2mCxnvfy6OpRrFSG4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm68f7x4W21kAjbzwau853qmLAfUFvEDVKv/4HtNHW1ky9YzFGLlQezkzYi/zlbqtdta8oVzfvPSTb/19WQgzFj9bdoyK3607x++XiGthCgl9m06uxuIXcPx10mQJl9umgxI7EBdL0G4Nxqk5RMNmXOiA2viJCp3TlJYNhaEq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qxKUp010; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p6nY0MqUdf1P9uopFxDVE2/tcFa/fWVkj9Ig2+H4ywM=; b=qxKUp010qnr2xUv2WEZk2EODFm
	jy1AblzHSPGfKfPB1FQlMN96+BoifoWUal7RbRHmHpTJ2SAOjo0tc0xe+G4//I7WQl+Jin1Y0ejP/
	tGq2mrI1+zITB+m/EqVtTH0GfPrtq0yKGRFiKLWhxIRHIo94gNSgo+Bzsw3usdCidIp4qhvNP4GhZ
	QTSDNIo81E8i3YQxdCbd3R58ats/BDEfo56K0/ZtytISBcLLc3wk9Yw+Ner5cw1NLuM8OOxE6gun/
	Tg3B+WVmHCDjBZ0Ka2SSHoLgd089Ob1hdwMeIbHEuesWEOBpZG+Cod+gybg8tx7zgRf0s5swZl5AO
	N41CjXFw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQt-00000008PI7-27yK;
	Fri, 22 Nov 2024 22:47:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iij-2Bxx;
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
Subject: [RFC PATCH v2 15/16] x86/kexec: Debugging support: Dump registers on exception
Date: Fri, 22 Nov 2024 22:38:24 +0000
Message-ID: <20241122224715.171751-16-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 83 +++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4ace2577afc6..67f6853c7abe 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -400,6 +400,55 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 SYM_CODE_END(swap_pages)
 
 #ifdef DEBUG
+/*
+ * This allows other types of serial ports to be used.
+ *  - %al: Character to be printed (no clobber %rax)
+ *  - %rdx: MMIO address or port.
+ */
+.macro pr_char
+	outb	%al, %dx
+.endm
+
+/* Print the nybble in %bl, clobber %rax */
+SYM_CODE_START_LOCAL_NOALIGN(pr_nybble)
+	UNWIND_HINT_FUNC
+	movb	%bl, %al
+	nop
+	andb	$0x0f, %al
+	addb 	$0x30, %al
+	cmpb	$0x3a, %al
+	jb	1f
+	addb	$('a' - '0' - 10), %al
+1:	pr_char
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_nybble)
+
+SYM_CODE_START_LOCAL_NOALIGN(pr_qword)
+	UNWIND_HINT_FUNC
+	movq	$16, %rcx
+1:	rolq	$4, %rbx
+	call	pr_nybble
+	loop	1b
+	movb	$'\n', %al
+	pr_char
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_qword)
+
+.macro print_reg a, b, c, d, r
+	movb	$\a, %al
+	pr_char
+	movb	$\b, %al
+	pr_char
+	movb	$\c, %al
+	pr_char
+	movb	$\d, %al
+	pr_char
+	movq	\r, %rbx
+	call	pr_qword
+.endm
+
 SYM_CODE_START_LOCAL_NOALIGN(exc_vectors)
 	/* Each of these is 6 bytes. */
 .macro vec_err exc
@@ -439,11 +488,39 @@ SYM_CODE_END(exc_vectors)
 
 SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 	pushq	%rax
+	pushq	%rbx
+	pushq	%rcx
 	pushq	%rdx
+
 	movw	$0x3f8, %dx
-	movb	$'A', %al
-	outb	%al, %dx
+
+	/* rip and exception info */
+	print_reg 'E', 'x', 'c', ':', 32(%rsp)
+	print_reg 'E', 'r', 'r', ':', 40(%rsp)
+	print_reg 'r', 'i', 'p', ':', 48(%rsp)
+
+	/* We spilled these to the stack */
+	print_reg 'r', 'a', 'x', ':', 24(%rsp)
+	print_reg 'r', 'b', 'x', ':', 16(%rsp)
+	print_reg 'r', 'c', 'x', ':', 8(%rsp)
+	print_reg 'r', 'd', 'x', ':', (%rsp)
+
+	/* Other registers */
+	print_reg 'r', 's', 'i', ':', %rsi
+	print_reg 'r', 'd', 'i', ':', %rdi
+	print_reg 'r', '8', ' ', ':', %r8
+	print_reg 'r', '9', ' ', ':', %r9
+	print_reg 'r', '1', '0', ':', %r10
+	print_reg 'r', '1', '1', ':', %r11
+	print_reg 'r', '1', '2', ':', %r12
+	print_reg 'r', '1', '3', ':', %r13
+	print_reg 'r', '1', '4', ':', %r14
+	print_reg 'r', '1', '5', ':', %r15
+	print_reg 'c', 'r', '2', ':', %cr2
+
 	popq	%rdx
+	popq	%rcx
+	popq	%rbx
 	popq	%rax
 
 	/* Only return from int3 */
@@ -456,6 +533,6 @@ SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 .Ldie:
 	hlt
 	jmp	.Ldie
-
+	int3
 SYM_CODE_END(exc_handler)
 #endif /* DEBUG */
-- 
2.47.0



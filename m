Return-Path: <linux-kernel+bounces-423850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4839DAD86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8291673CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB4C204096;
	Wed, 27 Nov 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mj7+sGdO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2A1FF7BC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734247; cv=none; b=XOUpvbAUJ/p0aWqaCrBWIwFWpWCqXOYGokfBqMwB6qyIu97h5RRFQlyf3pJLcQUjKlfe7N8mhLWIBMPHQEA2T9RXFOzFjzXW1q48JlxYU+SGt895KxoOf7kYVrHpDQGdOI280gYxpq/1vpCHjzpjpYNBKCZLukMH4fKPePKDtvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734247; c=relaxed/simple;
	bh=Uw3Y4djbQj+oGnM4V8NZ8aD+cLeBaycYn3PSbrmSV2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHrwqA/npleMUt+RIDx9r7AU9E/lXFd3gnMMKtBoFGyiw2u/vyKVsyGt+39XcGCF08M6Br+Dj1gxDVlss9x1FyddDMIv4rin+Fn2beJAUXDHeJE2/nzefAhE21XvjC+Ud2LOp2Alk5aYHEPrJFHOKOp0b3boi71gmCAgf0ib9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mj7+sGdO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HZSTsH9jPmSjfGOA2jGMGLovn1Q55JGddszKWUZDjoo=; b=Mj7+sGdOscCDZGphhrrgLTyyRk
	7E73fFbQ2jcn6CZoAgC0onGv6QK4VraOTWFd96mO4tuK6p6Hlgt/Tl6ubX4wBmA8JTHJ5gg6s0tXe
	9yYa0ri6NTzuD6toBOGPhGbmC9VIcxIIf9SI7t+Ju4iXNGpdjnCoTTvKNlXRWE9fQyzI8ZpejSSgn
	4NHRUIjIdJFIULjoZE4++QNyE7eJ/fh52K/QKattt5Szn58t1Ox/cF5Y1y149MAUIGcuVo0BdLtjM
	3EfVZKBn21gdgtyBS3AAioYGlcu7V+VN+nS94gHG3+vCluiLyjWIm1HAmT67hW7ZbjDMNSt6BmbFN
	OUkCPVAA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKF-00000001Suj-17gP;
	Wed, 27 Nov 2024 19:03:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000BjK-2yJ6;
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
Subject: [RFC PATCH v4 18/20] x86/kexec: Debugging support: Dump registers on exception
Date: Wed, 27 Nov 2024 19:00:32 +0000
Message-ID: <20241127190343.44916-19-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The actual serial output function is a no-op for now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 104 ++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 2179f691a45b..cd349b6d34a7 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -114,11 +114,6 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	int3
 SYM_CODE_END(relocate_kernel)
 
-#ifdef DEBUG
-	UNWIND_HINT_UNDEFINED
-	.balign 0x100	/* relocate_kernel will be overwritten with an IDT */
-#endif
-
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	UNWIND_HINT_END_OF_STACK
 	/*
@@ -368,6 +363,68 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 SYM_CODE_END(swap_pages)
 
 #ifdef CONFIG_KEXEC_DEBUG
+/*
+ * Generic 'print character' routine (as yet unimplemented)
+ *  - %al: Character to be printed (may clobber %rax)
+ *  - %rdx: MMIO address or port.
+ */
+SYM_CODE_START_LOCAL_NOALIGN(pr_char)
+	UNWIND_HINT_FUNC
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_char)
+
+/*
+ * Load pr_char function pointer into %rsi and load %rdx with whatever
+ * that function wants to see there (typically port/MMIO address).
+ */
+.macro	pr_setup
+	/* No output; pr_char just returns */
+	leaq	pr_char(%rip), %rsi
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
+	ANNOTATE_RETPOLINE_SAFE
+1:	jmp	*%rsi
+SYM_CODE_END(pr_nybble)
+
+SYM_CODE_START_LOCAL_NOALIGN(pr_qword)
+	UNWIND_HINT_FUNC
+	movq	$16, %rcx
+1:	rolq	$4, %rbx
+	call	pr_nybble
+	loop	1b
+	movb	$'\n', %al
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rsi
+SYM_CODE_END(pr_qword)
+
+.macro print_reg a, b, c, d, r
+	movb	$\a, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movb	$\b, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movb	$\c, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movb	$\d, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movq	\r, %rbx
+	call	pr_qword
+.endm
+
 SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
 	/* Each of these is 6 bytes. */
 .macro vec_err exc
@@ -408,11 +465,42 @@ SYM_CODE_END(kexec_debug_exc_vectors)
 
 SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 	pushq	%rax
+	pushq	%rbx
+	pushq	%rcx
 	pushq	%rdx
-	movw	$0x3f8, %dx
-	movb	$'A', %al
-	outb	%al, %dx
+	pushq	%rsi
+
+	/* Set up %rdx/%rsi for debug output */
+	pr_setup
+
+	/* rip and exception info */
+	print_reg 'E', 'x', 'c', ':', 40(%rsp)
+	print_reg 'E', 'r', 'r', ':', 48(%rsp)
+	print_reg 'r', 'i', 'p', ':', 54(%rsp)
+
+	/* We spilled these to the stack */
+	print_reg 'r', 'a', 'x', ':', 32(%rsp)
+	print_reg 'r', 'b', 'x', ':', 24(%rsp)
+	print_reg 'r', 'c', 'x', ':', 16(%rsp)
+	print_reg 'r', 'd', 'x', ':', 8(%rsp)
+
+	/* Other registers */
+	print_reg 'r', 's', 'i', ':', (%rsp)
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
+	popq	%rsi
 	popq	%rdx
+	popq	%rcx
+	popq	%rbx
 	popq	%rax
 
 	/* Only return from int3 */
-- 
2.47.0



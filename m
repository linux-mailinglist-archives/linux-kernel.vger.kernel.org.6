Return-Path: <linux-kernel+bounces-557920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E943CA5DF59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DD017C983
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B7A2566DD;
	Wed, 12 Mar 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L2MWYAC9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D52505D0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790597; cv=none; b=uiesa3Qt0GeFzjnN18hSmuMkKPpWg4J3rAN/oOA2gMgf9DBszeqgBES/iJhfT26A0ISjJ6XEXTPH3BjYqBhs1D1akivpFqBc5Y74opINv0OctEHTgfvZiv7CeGqztUWazQfeUvTqQo0kWDDFJ2FNDA4BKOvcFB+bkIqMnXG6gh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790597; c=relaxed/simple;
	bh=ae2dRyNvuj0+hnN34R8rhRFO3kqIm7+6j82izHN2YDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKffvMXf6TTqRovRm+cNiefsZKKVZmninv6hPMuZmv0WRWsURNSuc56heDORRcSv+IgXHsrBVRy77OtyhcvYqpz2vOYqL916QIqUHzgYrBkAUVmLfx+eAyR68f74TvWuuo7sx/8sbW9aiQDHJXTlXqFA2MUOt+QbogsPulQ0AQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L2MWYAC9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=10QklvjPg7r84qVDpNoqUsEwSacO5WYxpBy2BALCLno=; b=L2MWYAC9jR30grCB6kTNgxFdf0
	aPu5msLO5ymf3QVg3vLHkHcA5E0R60ARKUILy+1Kq59c2Cixjvfusf5Q8WtM6uCuGLMfhncVVBojJ
	7HfrQ4k6nrkYXQyRsZYkOHK8Ds1wNjZSAdeL9uaQIYrXR58JhoCWHMUsvZXKhR03LZvHGFHq9nW/g
	QciL/04yjc4GlLg2HTVK0h8+9OaUh+JRNHs0K2B+eLywgl9DuHLLR3XvqqFiFM3b+6s+vYNMyPHtZ
	2FIw02EkMPk7gENc5fsVHl715vsqbwb2JbthGRFJRbWQJUhNh66GphbSxYfqABBzggICQ79EQNTqd
	HuFwtDig==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIS-00000002QEp-2d4J;
	Wed, 12 Mar 2025 14:43:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uUG-28hi;
	Wed, 12 Mar 2025 14:42:59 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v7 3/8] x86/kexec: Debugging support: Dump registers on exception
Date: Wed, 12 Mar 2025 14:34:15 +0000
Message-ID: <20250312144257.2348250-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
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
 arch/x86/kernel/relocate_kernel_64.S | 101 ++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 5bf3eec2821b..2cc35ca11c3e 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -379,6 +379,69 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	int3
 SYM_CODE_END(swap_pages)
 
+/*
+ * Generic 'print character' routine (as yet unimplemented)
+ *  - %al: Character to be printed (may clobber %rax)
+ *  - %rdx: MMIO address or port.
+ */
+SYM_CODE_START_LOCAL_NOALIGN(pr_char)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
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
@@ -419,11 +482,43 @@ SYM_CODE_END(kexec_debug_exc_vectors)
 
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
+	print_reg 'E', 'x', 'c', ':', 0x28(%rsp)
+	print_reg 'E', 'r', 'r', ':', 0x30(%rsp)
+	print_reg 'r', 'i', 'p', ':', 0x38(%rsp)
+	print_reg 'r', 's', 'p', ':', 0x50(%rsp)
+
+	/* We spilled these to the stack */
+	print_reg 'r', 'a', 'x', ':', 0x20(%rsp)
+	print_reg 'r', 'b', 'x', ':', 0x18(%rsp)
+	print_reg 'r', 'c', 'x', ':', 0x10(%rsp)
+	print_reg 'r', 'd', 'x', ':', 0x08(%rsp)
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
2.48.1



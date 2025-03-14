Return-Path: <linux-kernel+bounces-561870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B47A617D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969C1188A3A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28468204875;
	Fri, 14 Mar 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qwvTc2uY"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2363A1FDE35
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973564; cv=none; b=lVafhpUlWDjbKgG8aM/TJ0atdG7qd/5+L0mqrLYgVQINAbc+sZIz3kYDq8zqPF1zcB/HL68VVgIkLtgp+RMVjwatELtKOw5MwHd6ZvAFr0zMsSFoQcUogyt3/0VF2gaUT9hyZwgXdmX7DXVVJlNKyI8xMo6SUqnQTKBn/H95cLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973564; c=relaxed/simple;
	bh=3KV2A40aE8hziNQ20v2xlelA3ksEf/i1QIUUg5cXLdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBgzddzjfymNq2p9UoQ/jFVlGxaIgbkUPB0SO3oWNHjHy9PFGES94Wog778qNrB1AOzBRATHWYivAOLBqtuPb84mL/YIsUDSd8LkGhQPiXcmznblg+4ycpaBGnlIp2uQPC+enY3TjHs5P6wlBHFIxBXM+uzrLMSwjYfafWPEkSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qwvTc2uY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XiU2A8Hf++dNsHgUZJbi/FS+hirzyzKI9tlEDEk267E=; b=qwvTc2uY27wXLSW8SnjfbZSPNf
	XAx+8qyapF9t8uM9JwqFtY4otTLYNWpp74MkZJFNsDshKBXbD4iPWBhriarGMwWdct1OTlUfFtuPy
	E0frzIt+40jJPGf8Ogc2tLscxKdFROaavwx5bOS5Qte33Z7bAkSzkEnJHXB/J+fWlFaaMlWhuGbOl
	0bGReU5nf9pB/mgIKtpfgHAxfpZiBz/ji2hY9F8nRlcq6R3jazyZMKHOWVt41vJudQEU3Iu5jxRgm
	JtZCcXiUb+K/kvxk2oH2d1Zq0dkrctHQnr9KmwV7QTD1Mix3WDWvZ6WXsZ1vV0mTvl8gsaCxQ+4xT
	0vht+9Uw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tb-00000002vUB-3fgc;
	Fri, 14 Mar 2025 17:32:32 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tY-0000000CsVp-3WmP;
	Fri, 14 Mar 2025 17:32:28 +0000
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
Subject: [PATCH v8 2/7] x86/kexec: Debugging support: Dump registers on exception
Date: Fri, 14 Mar 2025 17:27:34 +0000
Message-ID: <20250314173226.3062535-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314173226.3062535-1-dwmw2@infradead.org>
References: <20250314173226.3062535-1-dwmw2@infradead.org>
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
 arch/x86/kernel/relocate_kernel_64.S | 121 +++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b07c55019ce5..c2f73998d1b6 100644
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
@@ -422,17 +485,63 @@ SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 	VALIDATE_UNRET_END
 
 	pushq	%rax
+	pushq	%rbx
+	pushq	%rcx
 	pushq	%rdx
-	movw	$0x3f8, %dx
-	movb	$'A', %al
-	outb	%al, %dx
-	popq	%rdx
-	popq	%rax
+	pushq	%rsi
+
+	/* Stack frame */
+#define EXC_SS		0x58 /* Architectural... */
+#define EXC_RSP		0x50
+#define EXC_EFLAGS	0x48
+#define EXC_CS		0x40
+#define EXC_RIP		0x38
+#define EXC_ERRORCODE	0x30 /* Either architectural or zero pushed by handler */
+#define EXC_EXCEPTION	0x28 /* Pushed by handler entry point */
+#define EXC_RAX		0x20 /* Pushed just above in exc_handler */
+#define EXC_RBX		0x18
+#define EXC_RCX		0x10
+#define EXC_RDX		0x08
+#define EXC_RSI		0x00
+
+	/* Set up %rdx/%rsi for debug output */
+	pr_setup
+
+	/* rip and exception info */
+	print_reg 'E', 'x', 'c', ':', EXC_EXCEPTION(%rsp)
+	print_reg 'E', 'r', 'r', ':', EXC_ERRORCODE(%rsp)
+	print_reg 'r', 'i', 'p', ':', EXC_RIP(%rsp)
+	print_reg 'r', 's', 'p', ':', EXC_RSP(%rsp)
+
+	/* We spilled these to the stack */
+	print_reg 'r', 'a', 'x', ':', EXC_RAX(%rsp)
+	print_reg 'r', 'b', 'x', ':', EXC_RBX(%rsp)
+	print_reg 'r', 'c', 'x', ':', EXC_RCX(%rsp)
+	print_reg 'r', 'd', 'x', ':', EXC_RDX(%rsp)
+	print_reg 'r', 's', 'i', ':', EXC_RSI(%rsp)
+
+	/* Other registers untouched */
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
 
 	/* Only return from int3 */
-	cmpq	$3, (%rsp)
+	cmpq	$3, EXC_EXCEPTION(%rsp)
 	jne	.Ldie
 
+	popq	%rsi
+	popq	%rdx
+	popq	%rcx
+	popq	%rbx
+	popq	%rax
+
 	addq	$16, %rsp
 	iretq
 
-- 
2.48.1



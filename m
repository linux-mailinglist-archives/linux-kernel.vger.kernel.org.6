Return-Path: <linux-kernel+bounces-522045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB23A3C538
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFA31896359
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16EC20C032;
	Wed, 19 Feb 2025 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/EwmvmN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF51FE45B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983012; cv=none; b=cCIRkiUkS3YhHF2DAzsUCUv+I81n44Be268DpC6hwqmh3jrnqFkREmxg1PfYQWSrF+dJYR0O5utOy71TMpZubnYo5aXXZakkoef+xQPmQQDaZM/HJmpY80qLqjYGA9dfw1Xs2qry5D6qMtYbmrt8Pyi2IxU+buDbzpC4CZSTcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983012; c=relaxed/simple;
	bh=TM+i+OGrZK8ytIpm5H0KdmzYz4hrrB25z0z6K2huRys=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uzauDdl3yUU/haItdb2yOM4Pii6S5JXD5JZSXVfzpYPJnVKGsEYgD33OYusosxCOOD/nZLTNEhT5FdfaVbXFNueVZ/voy6gy3J/EgxlRgZnV27KCyyDWYMyaZiu/txXjwljJk9OP/+hGdpkNu0zFoP8aI0KW2aW1ublu+31J18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M/EwmvmN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=XiaeP0zY0E9OZG92iLfjRSZjSKwJIsUYCSKEWwoZUPM=; b=M/EwmvmNW8f6hgqPsH0JR69QWN
	rF1k4jEdB7NsrI3CtMeBVvrVo/Ci3aWhcgT4r9ur0P5EvXR/L4ScREo1AN2lPUH6PkVKiDLcrunud
	1N6avw0GjPLiByBdCzZhyd8CPKcAsFiht1cLCWYG4w60EKRMaa2rGPUCPqUQky/S9ukFc2fnBuYmP
	KJJf9lz7/rUsAX0YV9eN5guYnYsH8Kb4FfJ9aHzz/pn2dyXtmxbw0P9Qmzzd4ufMBVdB57AVsVl5T
	6qWp2XJ/yUKE8ICb1cV/bCuerOyjiqokJXjPT3pKi/Y/FaMoK7QlOxR5DXjDJnGunYLGCxZuMmSWQ
	XJuIFOeg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn40-00000006Whj-2QYr;
	Wed, 19 Feb 2025 16:36:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 06372300B40; Wed, 19 Feb 2025 17:36:43 +0100 (CET)
Message-ID: <20250219163514.791951626@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com,
 mhiramat@kernel.org,
 jmill@asu.edu
Subject: [PATCH v3 05/10] x86/ibt: Optimize FineIBT sequence
References: <20250219162107.880673196@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Scott notes that non-taken branches are faster. Abuse overlapping code
that traps instead of explicit UD2 instructions.

And LEA does not modify flags and will have less dependencies.

Suggested-by: Scott Constable <scott.d.constable@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   58 ++++++++++++++++++++++++++----------------
 arch/x86/net/bpf_jit_comp.c   |    5 +--
 2 files changed, 39 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1054,9 +1054,9 @@ early_param("cfi", cfi_parse_cmdline);
  * __cfi_\func:					__cfi_\func:
  *	movl   $0x12345678,%eax		// 5	     endbr64			// 4
  *	nop					     subl   $0x12345678,%r10d   // 7
- *	nop					     jz     1f			// 2
- *	nop					     ud2			// 2
- *	nop					1:   nop			// 1
+ *	nop					     jne    __cfi_\func+6	// 2
+ *	nop					     nop3			// 3
+ *	nop
  *	nop
  *	nop
  *	nop
@@ -1068,37 +1068,47 @@ early_param("cfi", cfi_parse_cmdline);
  *
  * caller:					caller:
  *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%r10d	// 6
- *	addl	$-15(%r11),%r10d	 // 4	     sub    $16,%r11		// 4
+ *	addl	$-15(%r11),%r10d	 // 4	     lea    -0x10(%r11),%r11	// 4
  *	je	1f			 // 2	     nop4			// 4
  *	ud2				 // 2
- * 1:	call	__x86_indirect_thunk_r11 // 5	     call   *%r11; nop2;	// 5
+ * 1:	cs call	__x86_indirect_thunk_r11 // 6	     call   *%r11; nop3;	// 6
  *
  */
 
-asm(	".pushsection .rodata			\n"
-	"fineibt_preamble_start:		\n"
-	"	endbr64				\n"
-	"	subl	$0x12345678, %r10d	\n"
-	"	je	fineibt_preamble_end	\n"
-	"fineibt_preamble_ud2:			\n"
-	"	ud2				\n"
-	"	nop				\n"
-	"fineibt_preamble_end:			\n"
+/*
+ * <fineibt_preamble_start>:
+ *  0:   f3 0f 1e fa             endbr64
+ *  4:   41 81 <ea> 78 56 34 12  sub    $0x12345678, %r10d
+ *  b:   75 f9                   jne    6 <fineibt_preamble_start+0x6>
+ *  d:   0f 1f 00                nopl   (%rax)
+ */
+asm(	".pushsection .rodata				\n"
+	"fineibt_preamble_start:			\n"
+	"	endbr64					\n"
+	"	subl	$0x12345678, %r10d		\n"
+	"	jne	fineibt_preamble_start+6	\n"
+	ASM_NOP3
+	"fineibt_preamble_end:				\n"
 	".popsection\n"
 );
 
 extern u8 fineibt_preamble_start[];
-extern u8 fineibt_preamble_ud2[];
 extern u8 fineibt_preamble_end[];
 
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
-#define fineibt_preamble_ud2  (fineibt_preamble_ud2 - fineibt_preamble_start)
+#define fineibt_preamble_ud   6
 #define fineibt_preamble_hash 7
 
+/*
+ * <fineibt_caller_start>:
+ *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
+ *  6:   4d 8d 5b f0             lea    -0x10(%r11), %r11
+ *  a:   0f 1f 40 00             nopl   0x0(%rax)
+ */
 asm(	".pushsection .rodata			\n"
 	"fineibt_caller_start:			\n"
 	"	movl	$0x12345678, %r10d	\n"
-	"	sub	$16, %r11		\n"
+	"	lea	-0x10(%r11), %r11	\n"
 	ASM_NOP4
 	"fineibt_caller_end:			\n"
 	".popsection				\n"
@@ -1429,15 +1439,15 @@ static void poison_cfi(void *addr)
 }
 
 /*
- * regs->ip points to a UD2 instruction, return true and fill out target and
- * type when this UD2 is from a FineIBT preamble.
+ * When regs->ip points to a 0xEA byte in the FineIBT preamble,
+ * return true and fill out target and type.
  *
  * We check the preamble by checking for the ENDBR instruction relative to the
- * UD2 instruction.
+ * 0xEA instruction.
  */
 bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
-	unsigned long addr = regs->ip - fineibt_preamble_ud2;
+	unsigned long addr = regs->ip - fineibt_preamble_ud;
 	u32 hash;
 
 	if (!exact_endbr((void *)addr))
@@ -1448,6 +1458,12 @@ bool decode_fineibt_insn(struct pt_regs
 	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
 	*type = (u32)regs->r10 + hash;
 
+	/*
+	 * Since regs->ip points to the middle of an instruction; it cannot
+	 * continue with the normal fixup.
+	 */
+	regs->ip = *target;
+
 	return true;
 
 Efault:
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -417,9 +417,8 @@ static void emit_fineibt(u8 **pprog, u32
 
 	EMIT_ENDBR();
 	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
-	EMIT2(0x74, 0x07);				/* jz.d8 +7		*/
-	EMIT2(0x0f, 0x0b);				/* ud2			*/
-	EMIT1(0x90);					/* nop			*/
+	EMIT2(0x75, 0xf9);				/* jne.d8 .-7		*/
+	EMIT3(0x0f, 0x1f, 0x00);			/* nop3			*/
 	EMIT_ENDBR_POISON();
 
 	*pprog = prog;




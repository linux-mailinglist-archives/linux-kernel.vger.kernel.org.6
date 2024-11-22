Return-Path: <linux-kernel+bounces-418215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6A09D5EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE901F23479
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BC41DF97E;
	Fri, 22 Nov 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IYs9fu+P"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6451DE2DA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277812; cv=none; b=hvbpRz8uGcQxazCWQyI2VxtgfR7hS744Cjtp/sWjJgjPE1rO9Nk/A4JlEfVIQKU1mclewwmTHGVEDCP7MEcGya5HiX0OcPu56hfop1EVy/cg0c9f5JEHAQQPWUUGzW7RmjfkSa/EytgRsUKszNLP0y/K4fob0Hl+PKhc35yMYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277812; c=relaxed/simple;
	bh=EhZ1VmUBU3oU2QwB906u37VFOFY9mXd6AAqr8QHO0/s=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=c5Mlip5n9cEInSke2AoIPWIdP/XiYBoC0Vef9VJ1x+dK0oOKdtb0cBeHFyJsqS7h05UtYUMOh1wJBuOvCS0H5SR1FZGJmLMH7n0Nj9hz2x0tKkJAd8/tkfu/oyUcY/uH6LCvehPB9VcRvKETtrFERolcA8EOYlLESzzEp7Q+hNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IYs9fu+P; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=LpPe5pTofDOreIRlTEa7ME57/EzH98eTbxi5ud5+/n0=; b=IYs9fu+PLMEwChw1rd72VIUxej
	sft4FMEFTyFoEoaL3Ae1W8IWHWVoH2qzBWsG9jwryduC60tF+2lvnzjYtKXzp6nv4cKmDpex7ZiR3
	WpZRADnPkN+VwGIagCcbfxJ5ZCQCCZX5sMaq8bOvx7PQwkLxLGgNSY1eTEtIGLrKt6plq7FcQIWPl
	kOjHeQvP5QX8+PYO5CHTVHGPkOFJFVOki9QJwZbYIGf+Cxo69mDvmaCTfg6Bh42RGxlGm6liJUpU4
	1EzjOuYYdw/017kbwUZWWAVhmpN8pkwhyKJpAFHiF3pgLhYX/RLv9xfHvTCfkEwX/GhhmqopZsIFp
	Ma+tHP8w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESae-00000000hax-2wLl;
	Fri, 22 Nov 2024 12:16:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 093FA302DC2; Fri, 22 Nov 2024 13:16:47 +0100 (CET)
Message-Id: <20241122121556.560621502@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 22 Nov 2024 13:10:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 9/9] objtool: Collect all annotations in objtool.h
References: <20241122121016.372005127@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h   |   12 ------------
 arch/x86/include/asm/nospec-branch.h |    9 ---------
 include/linux/objtool.h              |   30 +++++++++++++++++++++++-------
 3 files changed, 23 insertions(+), 28 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -56,12 +56,6 @@
 #endif
 
 /*
- * objtool annotation to ignore the alternatives and only consider the original
- * instruction(s).
- */
-#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
-
-/*
  * The patching flags are part of the upper bits of the @ft_flags parameter when
  * specifying them. The split is currently like this:
  *
@@ -308,12 +302,6 @@ void nop_func(void);
 #endif
 
 /*
- * objtool annotation to ignore the alternatives and only consider the original
- * instruction(s).
- */
-#define ANNOTATE_IGNORE_ALTERNATIVE ANNOTATE type=ANNOTYPE_IGNORE_ALTS
-
-/*
  * Issue one struct alt_instr descriptor entry (need to put it into
  * the section .altinstructions, see below). This entry contains
  * enough information for the alternatives patching code to patch an
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -180,13 +180,6 @@
 #ifdef __ASSEMBLY__
 
 /*
- * This should be used immediately before an indirect jump/call. It tells
- * objtool the subsequent indirect jump/call is vouched safe for retpoline
- * builds.
- */
-#define ANNOTATE_RETPOLINE_SAFE	ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
-
-/*
  * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
  * vs RETBleed validation.
  */
@@ -345,8 +338,6 @@
 
 #else /* __ASSEMBLY__ */
 
-#define ANNOTATE_RETPOLINE_SAFE ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
-
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -61,8 +61,6 @@
 	"911:\n\t"						\
 	__ASM_ANNOTATE(911b, x)
 
-#define ANNOTATE_NOENDBR	ASM_ANNOTATE(ANNOTYPE_NOENDBR)
-
 #else /* __ASSEMBLY__ */
 
 /*
@@ -140,8 +138,6 @@
 	.popsection
 .endm
 
-#define ANNOTATE_NOENDBR	ANNOTATE type=ANNOTYPE_NOENDBR
-
 /*
  * This macro indicates that the following intra-function call is valid.
  * Any non-annotated intra-function call will cause objtool to issue a warning.
@@ -158,7 +154,6 @@
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define ASM_ANNOTATE(x)
-#define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
@@ -166,8 +161,6 @@
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
-.macro ANNOTATE_NOENDBR
-.endm
 .macro REACHABLE
 .endm
 .macro ANNOTATE type:req
@@ -176,4 +169,27 @@
 
 #endif /* CONFIG_OBJTOOL */
 
+#ifndef __ASSEMBLY__
+/*
+ * Annotate away the various 'relocation to !ENDBR` complaints; knowing that
+ * these relocations will never be used for indirect calls.
+ */
+#define ANNOTATE_NOENDBR		ASM_ANNOTATE(ANNOTYPE_NOENDBR)
+/*
+ * This should be used immediately before an indirect jump/call. It tells
+ * objtool the subsequent indirect jump/call is vouched safe for retpoline
+ * builds.
+ */
+#define ANNOTATE_RETPOLINE_SAFE		ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
+/*
+ * objtool annotation to ignore the alternatives and only consider the original
+ * instruction(s).
+ */
+#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
+#else
+#define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
+#define ANNOTATE_RETPOLINE_SAFE		ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
+#define ANNOTATE_IGNORE_ALTERNATIVE	ANNOTATE type=ANNOTYPE_IGNORE_ALTS
+#endif
+
 #endif /* _LINUX_OBJTOOL_H */




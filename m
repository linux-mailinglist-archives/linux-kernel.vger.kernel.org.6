Return-Path: <linux-kernel+bounces-424497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C79DB500
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204501691B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4C157A67;
	Thu, 28 Nov 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BgRX0cXB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D9156887;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787050; cv=none; b=R26hvKg2F6SKtE3OL1tHM1E++hOcXkwkFk4tr0U8hg+N0H4uS1Kww7wu5LnOJ1JaGZyq6+uLc4KVjc2eD3YnKur44p7BT3SFyKyT2y/8zQXFaGExRQBe8KWbdG4cbmvuFbt8B+jYvrI0S4xHfuhQtZ0/WLEORA0BXtQjAsGSEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787050; c=relaxed/simple;
	bh=ITaR2GLJjD8N0qxqVx4qsccbDiOdUCBnuYv4gpCvXDs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jdDUlaRMhEU02W4sRRkGAXOJJW+o2KJ2/xSuLn0sezy4aRcHyYbsDfh9ZmHs0s2TW0k1wg74Y4E6uTp6cxLIIVVF6a7lPmfmd/jzvvzK1MTEplP+RaJ8uAmIrpPJJXlfl05yEdCnt2GYkdzU4tH3DLGP6P6bNC4d7wq5MBuK4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BgRX0cXB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=9kPdLx/gy38dNocF8o8UedzxUuCkNlflSHnB7A+iYrA=; b=BgRX0cXBHBbxPFd7Ao55X3L2La
	h/c3xWMzOiplOTHPrwJRHpcXenq5rarJm3kSiDQqLAu55tidAOx26sFADkt/pBI1pdA+9M+o0WXYS
	9hvRsatukXHQ0O4AC4ZPtYkVo9WW3mcDe2ptuYs2nmis3a0WwhE2WZ6kl9OHatxs0bFE31Viv4y4S
	MXVXRMzAoWRw96+yJAKleyQDAa6q6SyxSSOg6FcisUHlApGiqKaRymIQIFTy0Fdsw4pZ+Yc01DL5F
	NSOOjA6Q8kULBYXxAY254jRgQwyPPhh6duwWy4ksKwFJNlHiJiEsme8vqzi1Tts0JK6ax3MWHzdK3
	Gb2RMdqQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb47-00000002Tpv-0VFZ;
	Thu, 28 Nov 2024 09:44:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2066A30119B; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094311.786598147@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:39:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 09/16] objtool: Collect more annotations in objtool.h
References: <20241128093851.469225872@infradead.org>
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
 arch/x86/include/asm/alternative.h   |   12 -----
 arch/x86/include/asm/nospec-branch.h |    9 ---
 include/linux/instrumentation.h      |    4 -
 include/linux/objtool.h              |   80 +++++++++++++++++++++++------------
 4 files changed, 55 insertions(+), 50 deletions(-)

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
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -10,7 +10,7 @@
 /* Begin/end of an instrumentation safe region */
 #define __instrumentation_begin(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_BEGIN)\
+		     ANNOTATE_INSTR_BEGIN(__ASM_BREF(c))		\
 		     : : "i" (c));					\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
@@ -48,7 +48,7 @@
  */
 #define __instrumentation_end(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_END)	\
+		     ANNOTATE_INSTR_END(__ASM_BREF(c))			\
 		     : : "i" (c));					\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -63,8 +63,6 @@
 	"911:\n\t"						\
 	__ASM_ANNOTATE(911b, type)
 
-#define ANNOTATE_NOENDBR	ASM_ANNOTATE(ANNOTYPE_NOENDBR)
-
 #else /* __ASSEMBLY__ */
 
 /*
@@ -113,19 +111,6 @@
 #endif
 .endm
 
-/*
- * Use objtool to validate the entry requirement that all code paths do
- * VALIDATE_UNRET_END before RET.
- *
- * NOTE: The macro must be used at the beginning of a global symbol, otherwise
- * it will be ignored.
- */
-#if defined(CONFIG_NOINSTR_VALIDATION) && \
-	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO))
-#define VALIDATE_UNRET_BEGIN	ANNOTATE type=ANNOTYPE_UNRET_BEGIN
-#else
-#define VALIDATE_UNRET_BEGIN
-#endif
 
 .macro REACHABLE
 .Lhere_\@:
@@ -142,14 +127,6 @@
 	.popsection
 .endm
 
-#define ANNOTATE_NOENDBR	ANNOTATE type=ANNOTYPE_NOENDBR
-
-/*
- * This macro indicates that the following intra-function call is valid.
- * Any non-annotated intra-function call will cause objtool to issue a warning.
- */
-#define ANNOTATE_INTRA_FUNCTION_CALL ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
-
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
@@ -161,16 +138,12 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define __ASM_ANNOTATE(label, type)
 #define ASM_ANNOTATE(type)
-#define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
 #else
-#define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
-.macro ANNOTATE_NOENDBR
-.endm
 .macro REACHABLE
 .endm
 .macro ANNOTATE type:req
@@ -179,4 +152,57 @@
 
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
+ * See linux/instrumentation.h
+ */
+#define ANNOTATE_INSTR_BEGIN(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_BEGIN)
+#define ANNOTATE_INSTR_END(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_END)
+/*
+ * objtool annotation to ignore the alternatives and only consider the original
+ * instruction(s).
+ */
+#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL	ASM_ANNOTATE(ANNOTYPE_INTRA_FUNCTION_CALL)
+/*
+ * Use objtool to validate the entry requirement that all code paths do
+ * VALIDATE_UNRET_END before RET.
+ *
+ * NOTE: The macro must be used at the beginning of a global symbol, otherwise
+ * it will be ignored.
+ */
+#define ANNOTATE_UNRET_BEGIN		ASM_ANNOTATE(ANNOTYPE_UNRET_BEGIN)
+
+#else
+#define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
+#define ANNOTATE_RETPOLINE_SAFE		ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
+/*	ANNOTATE_INSTR_BEGIN		ANNOTATE type=ANNOTYPE_INSTR_BEGIN */
+/*	ANNOTATE_INSTR_END		ANNOTATE type=ANNOTYPE_INSTR_END */
+#define ANNOTATE_IGNORE_ALTERNATIVE	ANNOTATE type=ANNOTYPE_IGNORE_ALTS
+#define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
+#define ANNOTATE_UNRET_BEGIN		ANNOTATE type=ANNOTYPE_UNRET_BEGIN
+#endif
+
+#if defined(CONFIG_NOINSTR_VALIDATION) && \
+	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO))
+#define VALIDATE_UNRET_BEGIN	ANNOTATE_UNRET_BEGIN
+#else
+#define VALIDATE_UNRET_BEGIN
+#endif
+
 #endif /* _LINUX_OBJTOOL_H */




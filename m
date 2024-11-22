Return-Path: <linux-kernel+bounces-418213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F119D5EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F8B26799
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5368F1DF969;
	Fri, 22 Nov 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h9QWmZAb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B201DE3A5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277812; cv=none; b=FTIS46eWPpTi8ZQMHJrn8TZENn4TjRtXWLdDZeiXg2hCFua2XwxZDxzbeq9nKPFMQ51BtmRZ6IE6cKdtZ06P2cbj66wFUKnVhujbgpPie4oqGGR77p4flD3gBg87FK74fafMVBQ0g59u6acc8IalxO3jf6elzuKhft6XNxJwbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277812; c=relaxed/simple;
	bh=urQS2yElTEETyLW5CU+NAf/gKKL/T9AYgcHyh9xnDqE=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aKrIa3l9R0XBl/8o+7UaakyLtUQfdhTwlnqudtxUXD7LMb+cx6PGfVGLcVkrmAdibRh6JMzto2ancK1Tqd93mw9COtzkOR2bK9p6rx1gP/wdXeKx0d9pgmgOP/AQrFINhAdJlogLljZD968ggjCGjnTuYUkD8ysXUqb0yvHvgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h9QWmZAb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=v1B4si17lsJiu/eTcPxww45FJaJL5S2ZR+MPXXr7Od4=; b=h9QWmZAbIeT3t4zE8dsrFChqx3
	nkooOCmbqlDGRz5eIIQ3w3Ax2DoosP0/nZtMGBvtHTgD3oGPGhzx4K/Ld3MSjQwDlWVstIeUtVt51
	Ag0Qhifwr0ou1m29vCihtJXs5Vtm7Pr5HKnjE2qQttW26f3/nQUeMMt1Qr14ymDLiBdt4w19UTiGi
	9kc3lrLtP4ZdlKzraR7+ejd96W47zeueBQrZ1+v6pnBvrIo05c85a1qYffkpHroL50Rfki/T1dYb8
	wIWlX4FHkL3Sc5Gy4bp4qjiiAe+k4GuQAZRfPChNdcm6tMrDLhJoqxezZJQeUrJJv+ed9CkPgct6p
	Ca6ohGwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESad-00000007dTS-0rUG;
	Fri, 22 Nov 2024 12:16:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 016FE302795; Fri, 22 Nov 2024 13:16:46 +0100 (CET)
Message-Id: <20241122121556.315596549@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 22 Nov 2024 13:10:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 7/9] objtool: Convert ANNOTATE_INTRA_FUNCTION_CALLS to ANNOTATE
References: <20241122121016.372005127@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/objtool.h             |   16 ++----
 include/linux/objtool_types.h       |    1 
 tools/include/linux/objtool_types.h |    1 
 tools/objtool/check.c               |   96 ++++++++++++++----------------------
 4 files changed, 47 insertions(+), 67 deletions(-)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -66,16 +66,6 @@
 #else /* __ASSEMBLY__ */
 
 /*
- * This macro indicates that the following intra-function call is valid.
- * Any non-annotated intra-function call will cause objtool to issue a warning.
- */
-#define ANNOTATE_INTRA_FUNCTION_CALL				\
-	999:							\
-	.pushsection .discard.intra_function_calls;		\
-	.long 999b;						\
-	.popsection;
-
-/*
  * In asm, there are two kinds of code: normal C-type callable functions and
  * the rest.  The normal callable functions can be called by other code, and
  * don't do anything unusual with the stack.  Such normal callable functions
@@ -152,6 +142,12 @@
 
 #define ANNOTATE_NOENDBR	ANNOTATE type=ANNOTYPE_NOENDBR
 
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -63,5 +63,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
+#define ANNOTYPE_INTRA_FUNCTION_CALL	7
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -63,5 +63,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
+#define ANNOTYPE_INTRA_FUNCTION_CALL	7
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2339,7 +2339,8 @@ static int read_unwind_hints(struct objt
 	return 0;
 }
 
-static int read_annotate(struct objtool_file *file, int (*func)(int type, struct instruction *insn))
+static int read_annotate(struct objtool_file *file,
+			 int (*func)(struct objtool_file *file, int type, struct instruction *insn))
 {
 	struct section *sec;
 	struct instruction *insn;
@@ -2372,7 +2373,7 @@ static int read_annotate(struct objtool_
 			return -1;
 		}
 
-		ret = func(type, insn);
+		ret = func(file, type, insn);
 		if (ret < 0)
 			return ret;
 	}
@@ -2380,7 +2381,7 @@ static int read_annotate(struct objtool_
 	return 0;
 }
 
-static int __annotate_ignore_alts(int type, struct instruction *insn)
+static int __annotate_ignore_alts(struct objtool_file *file, int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_IGNORE_ALTS)
 		return 0;
@@ -2389,7 +2390,7 @@ static int __annotate_ignore_alts(int ty
 	return 0;
 }
 
-static int __annotate_noendbr(int type, struct instruction *insn)
+static int __annotate_noendbr(struct objtool_file *file, int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_NOENDBR)
 		return 0;
@@ -2398,7 +2399,37 @@ static int __annotate_noendbr(int type,
 	return 0;
 }
 
-static int __annotate_retpoline_safe(int type, struct instruction *insn)
+static int __annotate_ifc(struct objtool_file *file, int type, struct instruction *insn)
+{
+	unsigned long dest_off;
+
+	if (type != ANNOTYPE_INTRA_FUNCTION_CALL)
+		return 0;
+
+	if (insn->type != INSN_CALL) {
+		WARN_INSN(insn, "intra_function_call not a direct call");
+		return -1;
+	}
+
+	/*
+	 * Treat intra-function CALLs as JMPs, but with a stack_op.
+	 * See add_call_destinations(), which strips stack_ops from
+	 * normal CALLs.
+	 */
+	insn->type = INSN_JUMP_UNCONDITIONAL;
+
+	dest_off = arch_jump_destination(insn);
+	insn->jump_dest = find_insn(file, insn->sec, dest_off);
+	if (!insn->jump_dest) {
+		WARN_INSN(insn, "can't find call dest at %s+0x%lx",
+			  insn->sec->name, dest_off);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int __annotate_retpoline_safe(struct objtool_file *file, int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_RETPOLINE_SAFE)
 		return 0;
@@ -2415,7 +2446,7 @@ static int __annotate_retpoline_safe(int
 	return 0;
 }
 
-static int __annotate_instr(int type, struct instruction *insn)
+static int __annotate_instr(struct objtool_file *file, int type, struct instruction *insn)
 {
 	switch (type) {
 	case ANNOTYPE_INSTR_BEGIN:
@@ -2433,7 +2464,7 @@ static int __annotate_instr(int type, st
 	return 0;
 }
 
-static int __annotate_unret(int type, struct instruction *insn)
+static int __annotate_unret(struct objtool_file *file, int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_UNRET_BEGIN)
 		return 0;
@@ -2443,55 +2474,6 @@ static int __annotate_unret(int type, st
 
 }
 
-static int read_intra_function_calls(struct objtool_file *file)
-{
-	struct instruction *insn;
-	struct section *rsec;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
-	if (!rsec)
-		return 0;
-
-	for_each_reloc(rsec, reloc) {
-		unsigned long dest_off;
-
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s",
-			     rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.intra_function_call entry");
-			return -1;
-		}
-
-		if (insn->type != INSN_CALL) {
-			WARN_INSN(insn, "intra_function_call not a direct call");
-			return -1;
-		}
-
-		/*
-		 * Treat intra-function CALLs as JMPs, but with a stack_op.
-		 * See add_call_destinations(), which strips stack_ops from
-		 * normal CALLs.
-		 */
-		insn->type = INSN_JUMP_UNCONDITIONAL;
-
-		dest_off = arch_jump_destination(insn);
-		insn->jump_dest = find_insn(file, insn->sec, dest_off);
-		if (!insn->jump_dest) {
-			WARN_INSN(insn, "can't find call dest at %s+0x%lx",
-				  insn->sec->name, dest_off);
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
 /*
  * Return true if name matches an instrumentation function, where calls to that
  * function from noinstr code can safely be removed, but compilers won't do so.
@@ -2630,7 +2612,7 @@ static int decode_sections(struct objtoo
 	 * Must be before add_call_destination(); it changes INSN_CALL to
 	 * INSN_JUMP.
 	 */
-	ret = read_intra_function_calls(file);
+	ret = read_annotate(file, __annotate_ifc);
 	if (ret)
 		return ret;
 




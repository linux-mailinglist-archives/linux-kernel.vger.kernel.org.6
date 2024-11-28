Return-Path: <linux-kernel+bounces-424487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B149DB4F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3127168419
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082BF1993BD;
	Thu, 28 Nov 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n6lLEyLW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D475157469;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787048; cv=none; b=DzXVtoC4pLXinqTKxXf72qlD2dVlzZK4FgC5BAb0KahxCSVS4Ht2XhmaJfprvQbBP3so+QM1yRn2B5P/4F7rpBYmssGx0Fc9rFp36IIPvmxo6eEy0yqo14uQySip7uYscI+7W1k68wYtcMxWcjea+zTZ6mZ5VDryfCtrFPK+66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787048; c=relaxed/simple;
	bh=mjGYKOb/9aa0YeN+TcHRcxP5fOQBAHQaQPcv1HRzvd0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=f/Ib71oc9DoyQGa/Y384nrkN5kJLg8uOvnm2vQC3MHkIbkgs8dl+rIAdow6/LzylsvpGIorcvo/vmj0hfBjGnAvdUmRoo4SJZcETMb6SRRLXfLxAK9XIWPEiI82ffuu3xX5tFzaPyXFstko+X4KjouUahTXPdXjK+z/x2v2Oyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n6lLEyLW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ebPwFK9/gXudqGrOXnn2CmwIsGPf4asTmbEvTCyk04E=; b=n6lLEyLWrz6K7Bd8hEcV7WXv/z
	rO1oEnx6loQdZh8ZRPEP0nIOu6GQuKHmrhhCe97vDO5Osl80G9P0FWtG5FHPUZ4h4vfQTeICKQ+Ol
	CGXfWAh0WUdrhfCNKPzWrTT1HXynuynrUNXuf+9BZbhOeIKC8uW3RNCPuurr4/0/5dzwmwu5yUjlw
	gnpKiZIJGJNPLBtCax6V1T9nbDnXEQzRuuikKxT6Mk5latohwO9upKGIZF6oWkT1EQH+F62JXJTS2
	2KAEuco9zLFkGAUlkB4A5WdIfaKCcZQPgd9GNQHeZElpASZ9R3vg6SR6wes38a4vOOE6B1kiTkCz/
	mwmoAkIw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb46-00000002Tpp-0bpL;
	Thu, 28 Nov 2024 09:44:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0A62D30050D; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094311.145275669@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:38:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/16] objtool: Convert ANNOTATE_RETPOLINE_SAFE to ANNOTATE
References: <20241128093851.469225872@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   13 +-------
 include/linux/objtool_types.h        |    1 
 tools/include/linux/objtool_types.h  |    1 
 tools/objtool/check.c                |   52 ++++++++++++-----------------------
 4 files changed, 22 insertions(+), 45 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -184,12 +184,7 @@
  * objtool the subsequent indirect jump/call is vouched safe for retpoline
  * builds.
  */
-.macro ANNOTATE_RETPOLINE_SAFE
-.Lhere_\@:
-	.pushsection .discard.retpoline_safe
-	.long .Lhere_\@
-	.popsection
-.endm
+#define ANNOTATE_RETPOLINE_SAFE	ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
 
 /*
  * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
@@ -350,11 +345,7 @@
 
 #else /* __ASSEMBLY__ */
 
-#define ANNOTATE_RETPOLINE_SAFE					\
-	"999:\n\t"						\
-	".pushsection .discard.retpoline_safe\n\t"		\
-	".long 999b\n\t"					\
-	".popsection\n\t"
+#define ANNOTATE_RETPOLINE_SAFE ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -58,5 +58,6 @@ struct unwind_hint {
  * Annotate types
  */
 #define ANNOTYPE_NOENDBR		1
+#define ANNOTYPE_RETPOLINE_SAFE		2
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -58,5 +58,6 @@ struct unwind_hint {
  * Annotate types
  */
 #define ANNOTYPE_NOENDBR		1
+#define ANNOTYPE_RETPOLINE_SAFE		2
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2373,12 +2373,12 @@ static int read_unwind_hints(struct objt
 	return 0;
 }
 
-static int read_annotate(struct objtool_file *file, void (*func)(int type, struct instruction *insn))
+static int read_annotate(struct objtool_file *file, int (*func)(int type, struct instruction *insn))
 {
 	struct section *sec;
 	struct instruction *insn;
 	struct reloc *reloc;
-	int type;
+	int type, ret;
 
 	sec = find_section_by_name(file->elf, ".discard.annotate_insn");
 	if (!sec)
@@ -2406,53 +2406,37 @@ static int read_annotate(struct objtool_
 			return -1;
 		}
 
-		func(type, insn);
+		ret = func(type, insn);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
 }
 
-static void __annotate_noendbr(int type, struct instruction *insn)
+static int __annotate_noendbr(int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_NOENDBR)
-		return;
+		return 0;
 
 	insn->noendbr = 1;
+	return 0;
 }
 
-static int read_retpoline_hints(struct objtool_file *file)
+static int __annotate_retpoline_safe(int type, struct instruction *insn)
 {
-	struct section *rsec;
-	struct instruction *insn;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
-	if (!rsec)
+	if (type != ANNOTYPE_RETPOLINE_SAFE)
 		return 0;
 
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.retpoline_safe entry");
-			return -1;
-		}
-
-		if (insn->type != INSN_JUMP_DYNAMIC &&
-		    insn->type != INSN_CALL_DYNAMIC &&
-		    insn->type != INSN_RETURN &&
-		    insn->type != INSN_NOP) {
-			WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
-			return -1;
-		}
-
-		insn->retpoline_safe = true;
+	if (insn->type != INSN_JUMP_DYNAMIC &&
+	    insn->type != INSN_CALL_DYNAMIC &&
+	    insn->type != INSN_RETURN &&
+	    insn->type != INSN_NOP) {
+		WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
+		return -1;
 	}
 
+	insn->retpoline_safe = true;
 	return 0;
 }
 
@@ -2742,7 +2726,7 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_retpoline_hints(file);
+	ret = read_annotate(file, __annotate_retpoline_safe);
 	if (ret)
 		return ret;
 




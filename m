Return-Path: <linux-kernel+bounces-418214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F509D5EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB66E283597
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF31DF967;
	Fri, 22 Nov 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TVmg1PHc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C31DE2B3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277812; cv=none; b=LrYZNQAUyiXqmsoMJ5tIPo8Qm0Yxf+vtWizK9Q3lPVDJdgzTPyxlnwylfkiBHkMtWS+NGEsZgeZ5O8gUUkGTWahkV2dY14eF6fZeh02GRlZ1yhskAz9ZS0zkSE3fFIy/up3K0EB4pMxoVgNQhDTvkMeVfqmNx0lvvSJ3f/46zYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277812; c=relaxed/simple;
	bh=6Szio8eOyHDBpl65HFmw6k+IdFMuOAQlksIiABq4l5M=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pZbEsee7CcginvAFOP/W3wv4Z8EhdpFqMzUQEr11WfbjAVEX1xrirDYbThF58lpfyliHDfVbIOAPO8+oXZvUeyK7QRHLVbXV7slHWscKgortXKtBlOv8LIcIFLDByjhIMJ8ttVCgCES+vjWCXkbF3YwT7ikygPlM7rGLsee3QaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TVmg1PHc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=B6opN5MpeDT3Yz+qLMJgiO+trHgJ54BWfaP4MBuFTWY=; b=TVmg1PHc8g5uHsmb9Ay+cQykYv
	ZTxaGQS0myHnsVsVVquz8tVhaiyOndrKZCt97StusAy9aFo20v95pVXqe5I6D3NTwGUSmGKRiHAtq
	i5OIvbhWlCIFF0+CQLLuSK7IHQYL4lLFAQIQbNHT6LQ44ILCB0L67BQ7GnRk/7GF+dye4S69eYXjw
	IbLwom5Nh4KjLDWv6wZt6hW3SegfgCMo57F85xN4EKIr3UJx3cdB+lOOTOQgvUWONNuhcx3RgC3G3
	b+VwR3oQxnipMsxY0j4OL8O4YQP974P+ZeJhR63cH/4zR6XlgGijMukV3Jp4mez9QgY2ABNNUWLlG
	syVsKNVw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESae-00000000han-08RY;
	Fri, 22 Nov 2024 12:16:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E1CB730119C; Fri, 22 Nov 2024 13:16:46 +0100 (CET)
Message-Id: <20241122121555.727837221@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 22 Nov 2024 13:10:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 2/9] objtool: Convert ANNOTATE_NOENDBR to ANNOTATE
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
 include/linux/objtool.h             |   17 ++++-------------
 include/linux/objtool_types.h       |    5 +++++
 tools/include/linux/objtool_types.h |    5 +++++
 tools/objtool/check.c               |   32 +++++---------------------------
 4 files changed, 19 insertions(+), 40 deletions(-)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -45,12 +45,6 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
-#define ANNOTATE_NOENDBR					\
-	"986: \n\t"						\
-	".pushsection .discard.noendbr\n\t"			\
-	".long 986b\n\t"					\
-	".popsection\n\t"
-
 #define ASM_REACHABLE							\
 	"998:\n\t"							\
 	".pushsection .discard.reachable\n\t"				\
@@ -64,6 +58,8 @@
 	".long " __stringify(x) "\n\t"				\
 	".popsection\n\t"
 
+#define ANNOTATE_NOENDBR	ASM_ANNOTATE(ANNOTYPE_NOENDBR)
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -122,13 +118,6 @@
 #endif
 .endm
 
-.macro ANNOTATE_NOENDBR
-.Lhere_\@:
-	.pushsection .discard.noendbr
-	.long	.Lhere_\@
-	.popsection
-.endm
-
 /*
  * Use objtool to validate the entry requirement that all code paths do
  * VALIDATE_UNRET_END before RET.
@@ -161,6 +150,8 @@
 	.popsection
 .endm
 
+#define ANNOTATE_NOENDBR	ANNOTATE type=ANNOTYPE_NOENDBR
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -54,4 +54,9 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_SAVE		6
 #define UNWIND_HINT_TYPE_RESTORE	7
 
+/*
+ * Annotate types
+ */
+#define ANNOTYPE_NOENDBR		1
+
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -54,4 +54,9 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_SAVE		6
 #define UNWIND_HINT_TYPE_RESTORE	7
 
+/*
+ * Annotate types
+ */
+#define ANNOTYPE_NOENDBR		1
+
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2412,32 +2412,12 @@ static int read_annotate(struct objtool_
 	return 0;
 }
 
-static void __annotate_nop(int type, struct instruction *insn)
+static void __annotate_noendbr(int type, struct instruction *insn)
 {
-}
-
-static int read_noendbr_hints(struct objtool_file *file)
-{
-	struct instruction *insn;
-	struct section *rsec;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.noendbr");
-	if (!rsec)
-		return 0;
+	if (type != ANNOTYPE_NOENDBR)
+		return;
 
-	for_each_reloc(rsec, reloc) {
-		insn = find_insn(file, reloc->sym->sec,
-				 reloc->sym->offset + reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.noendbr entry");
-			return -1;
-		}
-
-		insn->noendbr = 1;
-	}
-
-	return 0;
+	insn->noendbr = 1;
 }
 
 static int read_retpoline_hints(struct objtool_file *file)
@@ -2713,12 +2693,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	read_annotate(file, __annotate_nop);
-
 	/*
 	 * Must be before read_unwind_hints() since that needs insn->noendbr.
 	 */
-	ret = read_noendbr_hints(file);
+	ret = read_annotate(file, __annotate_noendbr);
 	if (ret)
 		return ret;
 




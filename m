Return-Path: <linux-kernel+bounces-424490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4BD9DB4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7990282A32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D8199E9D;
	Thu, 28 Nov 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CEgObCQc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D6157A67;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787048; cv=none; b=OclWh3WmgnfOfOPFOBUGLg9aeVeRXL2raETCuf4c9sqxS79d59KU38lTb+Jb7ynrm8gspPnilRVmqdrKnhp8+KFtedPXSdpR+fNB4OKzSFUyX4qJ3CTfXXHyO6yxb+zY8/M3sYUxcFs4W2WHdUVcP+DKrJOj/ydbwxQIaV36oNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787048; c=relaxed/simple;
	bh=wFlCoEAqlIoCoTTUT6pSSssyVzAtTdlc/NrdEkBZd6E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SXZJ0CYGLZlNuzVOtWMssVrWzapuP4UPoElleA01HfW/NL77vzrtfa4z9Y3CubIeT65fgO8Lp2HrvdCt9t1ybc/sACXeAGra5O1kcETt+MHe8jfVUlr1MFeyobcMwm1csdJ83FcQqwyBNUgPuTg9wEJnbAfrf5kd9Nm0scQMRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CEgObCQc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=yzOsAdXvgxlBpGX4F0j5KjZUypXDwsaiDmjUhQcqSqU=; b=CEgObCQc7rsXQ7HghTE5Rn7fwZ
	CUvhzSAPec6Qs4lllEZ+R60oHYJSrFiuMLnXunXchkvmkquGe84M5NRiXhFBNFxcJM/uvXq6JJs9k
	Y37IQpETCR1u7AjO89DckthSlMMWSSmkDCjqSt9D5C8g3W7PC+cLFTVsPoDJT9xr8keA7t44NO6f8
	TIlG3BsIS1L/YbknAjwTkUz8lp9+T7X9hUGMPpin7gqIipS367id3cMH4FcM9FWbObXIo/YA0jQEw
	Z33dYCnGWK2+zLODYVgRXbe7wikqojmPbQi8qzwjoSXW+C+U7eaXBVqYaMTvJGOpwbulqscd/TzUd
	QRXLxuWw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb47-00000001a7y-1oJD;
	Thu, 28 Nov 2024 09:44:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0653B30037D; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094311.042140333@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:38:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/16] objtool: Convert ANNOTATE_NOENDBR to ANNOTATE
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
 	".long " __stringify(type) "\n\t"				\
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
 




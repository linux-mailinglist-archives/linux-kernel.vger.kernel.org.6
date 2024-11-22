Return-Path: <linux-kernel+bounces-418216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A55889D5EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CBBB269A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9F1DF97F;
	Fri, 22 Nov 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="auNUiqDJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A851BC9ED
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277813; cv=none; b=IlCS9sW2MRc6Gc2Fm2y2u9wArZ99udfIXVYSoCxf7U5Vfe4/GADSN0RXUjSx8aE15YCH7nIn7CxfgGHVB0CGUNrO/vTPvm2KNuX60QjPyxaf0VliujWKMt1HNfM1QXNtDTyvNakApAZ4cEepdoET4Lujt0+71hQLKrcCDQkPHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277813; c=relaxed/simple;
	bh=lwA0wdJRXuY7SHVj38Dd3BUpN2SRWnmL+R4sBJPinaI=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eaCAgpFHObq7/641PiQlAdA9jxDJKaLc9RCgRo3HP4zFYXhj9viIXhUn/N4U2AGCSY3JwWYGDARef/wUFyCcernyQsN84E4mAE2C8P4xfcEGby7MvnSr7ffsgq+hyJSXPV0YukccVXU7L2R8JdDBpZsCcP0kE8dUbWxigKViM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=auNUiqDJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Qwvok3TZbwDxhY8xOhIpf0sVTqtWf/2n8qGfU0FRsjI=; b=auNUiqDJtsnD4lT6BYvWrAlovb
	u/xesgrAqoadRGXCqwtAyD8IVyjsmuXQ95RG68t3fYG4inqCI7Jf455rWlWsNUeeNn5P7W9SiN+97
	tkaCRo3G9Mq8Lzwrw0IuuU3RlXhNKnh54biPY3VDmXt67+ZEmn5gUMbcPCRsdD2npg9l3GbLK2s/m
	fmie7CopxMdrJMQ7ke3HovOOlPFJjxM7KLnP5lcm4Z2naCC9fX/jv7To3BcanM99xNPZijGxEk/Zj
	WLXKC6r6DxFLICEn7eu2TnOZ4Y621ApKUsetKJJNQSnM5OqPRbXQuWLAqIHbfChxrwe+UnS9BjKqt
	NzCzkW1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESad-00000007dTT-0t2f;
	Fri, 22 Nov 2024 12:16:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 05358302DAF; Fri, 22 Nov 2024 13:16:47 +0100 (CET)
Message-Id: <20241122121556.447242540@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 22 Nov 2024 13:10:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 8/9] objtool: Collapse annotate sequences
References: <20241122121016.372005127@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Reduce read_annotate() runs by collapsing subsequent runs into a
single call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241111125218.921110073@infradead.org
---
 tools/objtool/check.c |   87 ++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 55 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2308,21 +2308,24 @@ static int read_annotate(struct objtool_
 	return 0;
 }
 
-static int __annotate_ignore_alts(struct objtool_file *file, int type, struct instruction *insn)
+static int __annotate_early(struct objtool_file *file, int type, struct instruction *insn)
 {
-	if (type != ANNOTYPE_IGNORE_ALTS)
-		return 0;
+	switch (type) {
+	case ANNOTYPE_IGNORE_ALTS:
+		insn->ignore_alts = true;
+		break;
 
-	insn->ignore_alts = true;
-	return 0;
-}
+	/*
+	 * Must be before read_unwind_hints() since that needs insn->noendbr.
+	 */
+	case ANNOTYPE_NOENDBR:
+		insn->noendbr = 1;
+		break;
 
-static int __annotate_noendbr(struct objtool_file *file, int type, struct instruction *insn)
-{
-	if (type != ANNOTYPE_NOENDBR)
-		return 0;
+	default:
+		break;
+	}
 
-	insn->noendbr = 1;
 	return 0;
 }
 
@@ -2356,26 +2359,21 @@ static int __annotate_ifc(struct objtool
 	return 0;
 }
 
-static int __annotate_retpoline_safe(struct objtool_file *file, int type, struct instruction *insn)
+static int __annotate_late(struct objtool_file *file, int type, struct instruction *insn)
 {
-	if (type != ANNOTYPE_RETPOLINE_SAFE)
-		return 0;
-
-	if (insn->type != INSN_JUMP_DYNAMIC &&
-	    insn->type != INSN_CALL_DYNAMIC &&
-	    insn->type != INSN_RETURN &&
-	    insn->type != INSN_NOP) {
-		WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
-		return -1;
-	}
+	switch (type) {
+	case ANNOTYPE_RETPOLINE_SAFE:
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC &&
+		    insn->type != INSN_RETURN &&
+		    insn->type != INSN_NOP) {
+			WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
+			return -1;
+		}
 
-	insn->retpoline_safe = true;
-	return 0;
-}
+		insn->retpoline_safe = true;
+		break;
 
-static int __annotate_instr(struct objtool_file *file, int type, struct instruction *insn)
-{
-	switch (type) {
 	case ANNOTYPE_INSTR_BEGIN:
 		insn->instr++;
 		break;
@@ -2384,6 +2382,10 @@ static int __annotate_instr(struct objto
 		insn->instr--;
 		break;
 
+	case ANNOTYPE_UNRET_BEGIN:
+		insn->unret = 1;
+		break;
+
 	default:
 		break;
 	}
@@ -2391,16 +2393,6 @@ static int __annotate_instr(struct objto
 	return 0;
 }
 
-static int __annotate_unret(struct objtool_file *file, int type, struct instruction *insn)
-{
-	if (type != ANNOTYPE_UNRET_BEGIN)
-		return 0;
-
-	insn->unret = 1;
-	return 0;
-
-}
-
 /*
  * Return true if name matches an instrumentation function, where calls to that
  * function from noinstr code can safely be removed, but compilers won't do so.
@@ -2507,14 +2499,7 @@ static int decode_sections(struct objtoo
 	add_ignores(file);
 	add_uaccess_safe(file);
 
-	ret = read_annotate(file, __annotate_ignore_alts);
-	if (ret)
-		return ret;
-
-	/*
-	 * Must be before read_unwind_hints() since that needs insn->noendbr.
-	 */
-	ret = read_annotate(file, __annotate_noendbr);
+	ret = read_annotate(file, __annotate_early);
 	if (ret)
 		return ret;
 
@@ -2560,15 +2545,7 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_annotate(file, __annotate_retpoline_safe);
-	if (ret)
-		return ret;
-
-	ret = read_annotate(file, __annotate_instr);
-	if (ret)
-		return ret;
-
-	ret = read_annotate(file, __annotate_unret);
+	ret = read_annotate(file, __annotate_late);
 	if (ret)
 		return ret;
 




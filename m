Return-Path: <linux-kernel+bounces-424493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2E9DB4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73BF280D72
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B933199FC1;
	Thu, 28 Nov 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YspFPRzt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE195158527;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787049; cv=none; b=R4BVD8JJgieVaZhafY8QMFTt3hv/tzETkOK1xaOi5OAYE6G0iIUtXOgF1GrGBPBfHZyYTnvXW1tPMiuJdtR+Bo+xakVOuqWlwT8Yxxk4Lg+9R0ydUXLB6KeMxeQwbFdINqLivHMPCCggHmDj4gxJECk4/ZJ9zFGXbIfXjp0eQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787049; c=relaxed/simple;
	bh=YcfV9sNulwTJAZsqIgdZ4lAcBlsY+5gHFkKNA+RgmF4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OTj/ccxuPBacvyyRWayigS4M/fm5yU9A9SWshsSkOboUJU12H7uCW7IxUnrreQ7cjE0ivzyhyiz4jFC/uhZuVzk56zBSwjoHZzgrRpGhmfFDnf00wes3JC9CbwlYK/InHeqZRR4Niix25fqZtzq7AlEJCsWUZo1MVofcKx1BFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YspFPRzt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=gj4p7yl7+dkaCocJAkHrhZxZwRJ1S2yOeCSzaopDaGY=; b=YspFPRztAC9wBWB26mKWdL/mwe
	5+6xhDtTAjCUKKJdeCMK3G9z+H7Uzx7T8T5YEISf3b+vn8O4rqEauS4zahzAKZK3nP3+22q/HFAg9
	LD8JTnB3xF5m21OWRmtQ1x7p39QZ20IwIcmwxxlAyT682b3lyZvC0/vQcokoXhqQhBUALMu4MoiXg
	lEErU92pCt/aiITS8JKXUa2iRRp5Cppcs+c5aIHEj7XZ6bvHJOMcbeDgVXVc73ZJj7YEs/1zGc8C/
	tNAoKdRX5t4k83K1lyKPPO7cWVLeBKXFbbPpDRZWWvR87GPdE0KNuq77n6QN0CZ6pDSXjlDC081M7
	OUULcylQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb48-00000001a85-1cyd;
	Thu, 28 Nov 2024 09:44:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 133FA300781; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094311.358508242@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:38:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/16] objtool: Convert VALIDATE_UNRET_BEGIN to ANNOTATE
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
 include/linux/objtool.h             |    9 +++------
 include/linux/objtool_types.h       |    1 +
 tools/include/linux/objtool_types.h |    1 +
 tools/objtool/check.c               |   28 +++++-----------------------
 4 files changed, 10 insertions(+), 29 deletions(-)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -130,15 +130,12 @@
  * NOTE: The macro must be used at the beginning of a global symbol, otherwise
  * it will be ignored.
  */
-.macro VALIDATE_UNRET_BEGIN
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
 	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO))
-.Lhere_\@:
-	.pushsection .discard.validate_unret
-	.long	.Lhere_\@ - .
-	.popsection
+#define VALIDATE_UNRET_BEGIN	ANNOTATE type=ANNOTYPE_UNRET_BEGIN
+#else
+#define VALIDATE_UNRET_BEGIN
 #endif
-.endm
 
 .macro REACHABLE
 .Lhere_\@:
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -61,5 +61,6 @@ struct unwind_hint {
 #define ANNOTYPE_RETPOLINE_SAFE		2
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
+#define ANNOTYPE_UNRET_BEGIN		5
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -61,5 +61,6 @@ struct unwind_hint {
 #define ANNOTYPE_RETPOLINE_SAFE		2
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
+#define ANNOTYPE_UNRET_BEGIN		5
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2458,33 +2458,15 @@ static int __annotate_instr(int type, st
 	return 0;
 }
 
-static int read_validate_unret_hints(struct objtool_file *file)
+static int __annotate_unret(int type, struct instruction *insn)
 {
-	struct section *rsec;
-	struct instruction *insn;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.validate_unret");
-	if (!rsec)
+	if (type != ANNOTYPE_UNRET_BEGIN)
 		return 0;
 
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.instr_end entry");
-			return -1;
-		}
-		insn->unret = 1;
-	}
-
+	insn->unret = 1;
 	return 0;
-}
 
+}
 
 static int read_intra_function_calls(struct objtool_file *file)
 {
@@ -2705,7 +2687,7 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_validate_unret_hints(file);
+	ret = read_annotate(file, __annotate_unret);
 	if (ret)
 		return ret;
 




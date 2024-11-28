Return-Path: <linux-kernel+bounces-424498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D69DB4FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84EA2B24258
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB59C1A9B4B;
	Thu, 28 Nov 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OR6uPmZu"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB4157493;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787050; cv=none; b=pLyK5z6bVXsap5p/Qhc3MYA/UKHuQ0xbm+zLOtzCcUraXERrQ6WFPl0+ZcLqF87xGVuFPvvIDiCg6Ud8gT5wYN7AMIA8cvvkFXXFOActPTysUO/qrW3QFJzv0qwSDiZ/xqS3Czpos9X8DSBzeY2mRo3RymOx8J9gJuVmqHFrj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787050; c=relaxed/simple;
	bh=zGeX2Q5hmN43CvvwJeuQ5uQfmOvAIr3FT8xoXu1/NS4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=plS5hYTm30FDKZwwoHSpTL3iOaRn+0xytWVkIQjPvnh4+y7T1mZ+VWdiaolsFsAhBhG6asf6nPJzNFEbIa282eh3AeG3CtvkNaJneTizp9RzQdlM2OkBj1vgkUQh2Fc9W9hxi21bi+q+gRX9zxwrgkhf1lBaXsGWi9l5Wta6rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OR6uPmZu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=H2gMDC/NqQVhMx36aV1q2hSUUdkgY6DQgcGm+BWajhA=; b=OR6uPmZut4eB1MXlLkJR7o57Tl
	Z9VkY8i5vi8UsSWRkImQbzMHje8U7MXtFOBBNdDPok5pCjV9cGZbysnFp8Umyne7kFl/QwuCCwYyx
	1JMLUUADn4pza/WHLmJGi8FwVL8G3lGVjuZveUOVFtfDftEhBmowEEsvaVsUAkPylBOGMtsBl1fp7
	gRiww0OqW/WDmxtqc+GTIe8Vs475ep2h/OiQfejH1EAPD8rdaqe3azYAAx1+foimAujm6kB4quPLV
	65cvXN3rIZOw1mAdA9CmBlmJFXx6k2UQlNBfe9r+BnRXxVzXKBG7vJMpHOBSJsRcNty+/CN3JjbM4
	ShvcMNJQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb47-00000001a7z-1oIB;
	Thu, 28 Nov 2024 09:44:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0DFB730072F; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094311.245980207@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:38:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/16] objtool: Convert instrumentation_{begin,end}() to ANNOTATE
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
 include/linux/instrumentation.h     |   11 +++-----
 include/linux/objtool.h             |   12 ++++++--
 include/linux/objtool_types.h       |    2 +
 tools/include/linux/objtool_types.h |    2 +
 tools/objtool/check.c               |   49 +++++++-----------------------------
 5 files changed, 28 insertions(+), 48 deletions(-)

--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -4,14 +4,14 @@
 
 #ifdef CONFIG_NOINSTR_VALIDATION
 
+#include <linux/objtool.h>
 #include <linux/stringify.h>
 
 /* Begin/end of an instrumentation safe region */
 #define __instrumentation_begin(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     ".pushsection .discard.instr_begin\n\t"		\
-		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_BEGIN)\
+		     : : "i" (c));					\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
@@ -48,9 +48,8 @@
  */
 #define __instrumentation_end(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     ".pushsection .discard.instr_end\n\t"		\
-		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_END)	\
+		     : : "i" (c));					\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else /* !CONFIG_NOINSTR_VALIDATION */
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -51,13 +51,18 @@
 	".long 998b\n\t"						\
 	".popsection\n\t"
 
-#define ASM_ANNOTATE(type)						\
-	"911:\n\t"							\
+#define __ASM_BREF(label)	label ## b
+
+#define __ASM_ANNOTATE(label, type)					\
 	".pushsection .discard.annotate_insn,\"M\",@progbits,8\n\t"	\
-	".long 911b - .\n\t"						\
+	".long " __stringify(label) " - .\n\t"			\
 	".long " __stringify(type) "\n\t"				\
 	".popsection\n\t"
 
+#define ASM_ANNOTATE(type)						\
+	"911:\n\t"						\
+	__ASM_ANNOTATE(911b, type)
+
 #define ANNOTATE_NOENDBR	ASM_ANNOTATE(ANNOTYPE_NOENDBR)
 
 #else /* __ASSEMBLY__ */
@@ -161,6 +166,7 @@
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
+#define __ASM_ANNOTATE(label, type)
 #define ASM_ANNOTATE(type)
 #define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -59,5 +59,7 @@ struct unwind_hint {
  */
 #define ANNOTYPE_NOENDBR		1
 #define ANNOTYPE_RETPOLINE_SAFE		2
+#define ANNOTYPE_INSTR_BEGIN		3
+#define ANNOTYPE_INSTR_END		4
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -59,5 +59,7 @@ struct unwind_hint {
  */
 #define ANNOTYPE_NOENDBR		1
 #define ANNOTYPE_RETPOLINE_SAFE		2
+#define ANNOTYPE_INSTR_BEGIN		3
+#define ANNOTYPE_INSTR_END		4
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2440,48 +2440,19 @@ static int __annotate_retpoline_safe(int
 	return 0;
 }
 
-static int read_instr_hints(struct objtool_file *file)
+static int __annotate_instr(int type, struct instruction *insn)
 {
-	struct section *rsec;
-	struct instruction *insn;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.instr_end");
-	if (!rsec)
-		return 0;
-
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
+	switch (type) {
+	case ANNOTYPE_INSTR_BEGIN:
+		insn->instr++;
+		break;
 
+	case ANNOTYPE_INSTR_END:
 		insn->instr--;
-	}
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.instr_begin");
-	if (!rsec)
-		return 0;
+		break;
 
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.instr_begin entry");
-			return -1;
-		}
-
-		insn->instr++;
+	default:
+		break;
 	}
 
 	return 0;
@@ -2730,7 +2701,7 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_instr_hints(file);
+	ret = read_annotate(file, __annotate_instr);
 	if (ret)
 		return ret;
 




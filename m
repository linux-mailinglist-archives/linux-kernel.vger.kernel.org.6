Return-Path: <linux-kernel+bounces-418209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68AF9D5EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD041F21A48
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDEF1DEFC6;
	Fri, 22 Nov 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqbIin57"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A91DC1BA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277811; cv=none; b=nzR+dUgKjkJCwwQj+nWwGQN/4uLkroUpF//G2WgKWsMKv0KfPtTiTlMtjVnfn8oRNdGvRPgZhEsFbqzLzhFHykbqorx+hvs7sJsDcAvBw/pQu207oTjMJFfQxqgOYykewtIiN3rjdbbl5UengTIJbDsNoE71ewHnZWgfAcN6zGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277811; c=relaxed/simple;
	bh=oGt7d2/1AZ6ttNQD3Hxor5BKbIHGTlMU4ITcmaa5IXY=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=W6k9VUG8iSU/5wsRRSWSEkrEKDPoPmoRzIDNLuq+dt4AX0at15wdduF+ZmxpHM86CM1OaLvQGtTJGUtfQJBf9843oMhbtw+0nmWreyfX+Z8TDaOKTySo4k6OutcJ04LdsaWfg7RaQnypaUnBPrXwjbb8NzxmeRLzRKvQ8vUkizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sqbIin57; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=gAZk8BfSgMbnXgBVXT4gwmRA5jBGKu/1a0p5ZQUwXz4=; b=sqbIin57NOM30pSQ+3hk4/m8XM
	BP6yE2ZPmelffkCcZO1RpzAiwLAfr31tn9tdibk9lzeGc15PQTsCZhvAKpvCuJ/FFmmcIIwJuV528
	wt5D1oSUkXmlQ4Sjul3MWIzt4nrJSD2OsA4SI1NObpr05JxeldJRimv9TFlDNOESIxE65Aj7GWPTW
	KuXbcrExKz9ok//+zkJR/hxLBgKKoA/KRuYryu7vjFzGaIwYczkvnmCcVhGLYex4fQ22MFl89OPeG
	aWBfNgt2cY747bBChuE2JI1EhkTE6+8pl3rTM0AJZ2Y1uz1Z3L8+JElVY8CwXeTZAQa/NBG/OVTYP
	jxCZOBxQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESac-00000007dTM-2EEW;
	Fri, 22 Nov 2024 12:16:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EA0DB3021DA; Fri, 22 Nov 2024 13:16:46 +0100 (CET)
Message-Id: <20241122121555.941999497@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 22 Nov 2024 13:10:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 4/9] objtool: Convert instrumentation_{begin,end}() to ANNOTATE
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
 include/linux/instrumentation.h     |   12 ++++----
 include/linux/objtool.h             |    9 ++++--
 include/linux/objtool_types.h       |    2 +
 tools/include/linux/objtool_types.h |    2 +
 tools/objtool/check.c               |   49 +++++++-----------------------------
 5 files changed, 26 insertions(+), 48 deletions(-)

--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -4,14 +4,15 @@
 
 #ifdef CONFIG_NOINSTR_VALIDATION
 
+#include <linux/objtool.h>
 #include <linux/stringify.h>
+#include <linux/args.h>
 
 /* Begin/end of an instrumentation safe region */
 #define __instrumentation_begin(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     ".pushsection .discard.instr_begin\n\t"		\
-		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+		     __ASM_ANNOTATE(CONCATENATE(c, b), ANNOTYPE_INSTR_BEGIN)	\
+		     : : "i" (c));					\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
@@ -48,9 +49,8 @@
  */
 #define __instrumentation_end(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     ".pushsection .discard.instr_end\n\t"		\
-		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+		     __ASM_ANNOTATE(CONCATENATE(c, b), ANNOTYPE_INSTR_END)		\
+		     : : "i" (c));					\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else /* !CONFIG_NOINSTR_VALIDATION */
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -51,13 +51,16 @@
 	".long 998b\n\t"						\
 	".popsection\n\t"
 
-#define ASM_ANNOTATE(x)						\
-	"911:\n\t"						\
+#define __ASM_ANNOTATE(s, x)					\
 	".pushsection .discard.annotate,\"M\",@progbits,8\n\t"	\
-	".long 911b - .\n\t"					\
+	".long " __stringify(s) " - .\n\t"			\
 	".long " __stringify(x) "\n\t"				\
 	".popsection\n\t"
 
+#define ASM_ANNOTATE(x)						\
+	"911:\n\t"						\
+	__ASM_ANNOTATE(911b, x)
+
 #define ANNOTATE_NOENDBR	ASM_ANNOTATE(ANNOTYPE_NOENDBR)
 
 #else /* __ASSEMBLY__ */
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
 




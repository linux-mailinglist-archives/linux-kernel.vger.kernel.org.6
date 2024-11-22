Return-Path: <linux-kernel+bounces-418212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6B9D5EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C66B25DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3159E1DF24D;
	Fri, 22 Nov 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jxi9YcBO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913171BC091
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277812; cv=none; b=Vh21I8ut10EqI1RclVCjW1Y1xuNx1S+iSlECjkInDUm2wyDbxAkXVtjn4iHuwtmqYwha9mFDDo2bIKblWVGHFE1Ox2/7MB3l6FUJrBESG8xJLOPwPxmvsU16JKf/LGSi0r5ET8KUwQhaWemR5cE7dj8IcRrC4FCW25dySJFc4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277812; c=relaxed/simple;
	bh=J4qe9kzMeaC+48JT9UPo1D22Cwz02M19mcNneZ0NCOo=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=G31twRfOJKCzJJkFVkDmEuDBXTPUArHPHdstIfXdYy0QO1GHvx5hFiNATTSSCuBagOm4HQc5W1wUADNRnnh7qYXQOOXD985c+841xPZlB8LAP3EYV8/1q6+uIBJ7IbwCWGvKoIzFRgY1NXZlvkcLX0CpJy8sfUDtg+XoH453LDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jxi9YcBO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=iT8rZBU1kFBBncA0eT4LO89fZPLO0VJsqubseEy0Iso=; b=Jxi9YcBOgUmTDHGeHm8smpmeUB
	gq3j8D6vULfed0mlwbWkuDhKW4TktTZwaKAWpEB6rk3GbS/WKY4fQqJRQBM2L84BdXgNHViLJohq5
	tKKW16EeB/giZE2vZL8dvVGo00763aFsFmTeol0PX1Q5S+ZTfN7yyWG0JGUOAJ4KPQ3wAC8m5eUKL
	0IrE/SqiCZxBYyQxF5AJrrFD+3Vseo5D3Hifx4bmsAGtFXuwGk1MQxIqODRfbAQOPJ9NvBOBix90P
	JccPySBsG0oE40s8yz2cHQgTgrPgFPg6bhDl53R00C/8qxsgeU4bFa6P5Vu+rN9a1rLBzv8eW8RX5
	yfSIuZOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESad-00000007dTR-0sY2;
	Fri, 22 Nov 2024 12:16:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F185C30221D; Fri, 22 Nov 2024 13:16:46 +0100 (CET)
Message-Id: <20241122121556.172693402@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 22 Nov 2024 13:10:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 6/9] objtool: Convert ANNOTATE_IGNORE_ALTERNATIVE to ANNOTATE
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
 arch/x86/include/asm/alternative.h  |   14 ++---------
 include/linux/objtool_types.h       |    1 
 tools/include/linux/objtool_types.h |    1 
 tools/objtool/check.c               |   45 ++++++++----------------------------
 4 files changed, 15 insertions(+), 46 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stringify.h>
+#include <linux/objtool.h>
 #include <asm/asm.h>
 
 #define ALT_FLAGS_SHIFT		16
@@ -55,11 +56,7 @@
  * objtool annotation to ignore the alternatives and only consider the original
  * instruction(s).
  */
-#define ANNOTATE_IGNORE_ALTERNATIVE				\
-	"999:\n\t"						\
-	".pushsection .discard.ignore_alts\n\t"			\
-	".long 999b\n\t"					\
-	".popsection\n\t"
+#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
 
 /*
  * The patching flags are part of the upper bits of the @ft_flags parameter when
@@ -349,12 +346,7 @@ static inline int alternatives_text_rese
  * objtool annotation to ignore the alternatives and only consider the original
  * instruction(s).
  */
-.macro ANNOTATE_IGNORE_ALTERNATIVE
-	.Lannotate_\@:
-	.pushsection .discard.ignore_alts
-	.long .Lannotate_\@
-	.popsection
-.endm
+#define ANNOTATE_IGNORE_ALTERNATIVE ANNOTATE type=ANNOTYPE_IGNORE_ALTS
 
 /*
  * Issue one struct alt_instr descriptor entry (need to put it into
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -62,5 +62,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
+#define ANNOTYPE_IGNORE_ALTS		6
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -62,5 +62,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
+#define ANNOTYPE_IGNORE_ALTS		6
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1255,40 +1255,6 @@ static void add_uaccess_safe(struct objt
 }
 
 /*
- * FIXME: For now, just ignore any alternatives which add retpolines.  This is
- * a temporary hack, as it doesn't allow ORC to unwind from inside a retpoline.
- * But it at least allows objtool to understand the control flow *around* the
- * retpoline.
- */
-static int add_ignore_alternatives(struct objtool_file *file)
-{
-	struct section *rsec;
-	struct reloc *reloc;
-	struct instruction *insn;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.ignore_alts");
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
-			WARN("bad .discard.ignore_alts entry");
-			return -1;
-		}
-
-		insn->ignore_alts = true;
-	}
-
-	return 0;
-}
-
-/*
  * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
  * will be added to the .retpoline_sites section.
  */
@@ -2341,6 +2307,15 @@ static int read_annotate(struct objtool_
 	return 0;
 }
 
+static int __annotate_ignore_alts(int type, struct instruction *insn)
+{
+	if (type != ANNOTYPE_IGNORE_ALTS)
+		return 0;
+
+	insn->ignore_alts = true;
+	return 0;
+}
+
 static int __annotate_noendbr(int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_NOENDBR)
@@ -2550,7 +2525,7 @@ static int decode_sections(struct objtoo
 	add_ignores(file);
 	add_uaccess_safe(file);
 
-	ret = add_ignore_alternatives(file);
+	ret = read_annotate(file, __annotate_ignore_alts);
 	if (ret)
 		return ret;
 




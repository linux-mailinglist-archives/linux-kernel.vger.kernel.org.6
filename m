Return-Path: <linux-kernel+bounces-424494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EB9DB4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046AB16233F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9650819ABAC;
	Thu, 28 Nov 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIvtZCR7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C8157E82;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787049; cv=none; b=Q4FWlsBDlkQ3CIpIzR2gxbLDb3J32psQJthI6EY2T3PzHgYFBppd+fV7BdwxG2r5TcE7A8wZLXeEy/U/b5B/vtAekFH391wfL7eaWBjK/lFsy234yzSOGPxO3b5AMdGObBYXdWFsxfOmESGDf+ZU8rLUu7/NBnYLEpAMWhXsFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787049; c=relaxed/simple;
	bh=1zB7QCTHqenNuqJa/hFSq5h350ONNN3U6vz5U0PjDLA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VN3ab540kZ4AgXMDjaRCpJjwS07OZVtdNkBwJcHBULuZja7HfP7zn4fYvv0dT864y8eOwwcd94rtn+Kzq08nNA/q0b9FsSCzb7EILtsOresb06i0EszZ2pOi1IXT2GDrjv/fsZyJsZoixpv7bBtPiIMSZuCnMoyXia4JumRQR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WIvtZCR7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=bCe6p4zd4smqU+6rwokNNvA3uR+14ozb9/hQrP5U9Z8=; b=WIvtZCR7pT7UffRJT8ORirOubm
	12nYob7K2zSXAYburYCiGFG9ULPBABPneUcHR6PyrH8U1pSFrVnq+ZlyTSIadlerF/6O7s3rO5Z6S
	wIwbCHNajfH5+YjeNm7tUbsHRJY11ZP1HOSZA9soETRi1f7YpB8j1ztpdQeFEknq3iUD1U5JFD/LI
	tN9txs6d1InSXpKL1pADgh77Czon3qBEwwSEviISE5B5Y+DJdWMehPTbSzK37+wbaoZOI/YqAXvBk
	UcqrG0TZ6xh0iyhmelCbSoqsrquiYQotCbzfD2KCte4YSLBb++M1SvnWOwIMB1hH6DiK2kznJWVJj
	EO1oy43A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb48-00000001a88-1hI3;
	Thu, 28 Nov 2024 09:44:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 31FAB301CEB; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094312.353431347@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:39:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 14/16] objtool: Convert {.UN}REACHABLE to ANNOTATE
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
 arch/loongarch/include/asm/bug.h    |    2 
 arch/x86/entry/entry_64.S           |    4 -
 arch/x86/include/asm/bug.h          |    2 
 arch/x86/include/asm/irq_stack.h    |    2 
 include/linux/objtool.h             |   18 +++----
 include/linux/objtool_types.h       |    1 
 tools/include/linux/objtool_types.h |    1 
 tools/objtool/check.c               |   82 +++++++++---------------------------
 8 files changed, 36 insertions(+), 76 deletions(-)

--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -45,7 +45,7 @@
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ASM_REACHABLE);	\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE);\
 	instrumentation_end();					\
 } while (0)
 
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -311,7 +311,7 @@ SYM_CODE_END(xen_error_entry)
 	call	\cfunc
 
 	/* For some configurations \cfunc ends up being a noreturn. */
-	REACHABLE
+	ANNOTATE_REACHABLE
 
 	jmp	error_return
 .endm
@@ -532,7 +532,7 @@ SYM_CODE_START(\asmsym)
 	call	\cfunc
 
 	/* For some configurations \cfunc ends up being a noreturn. */
-	REACHABLE
+	ANNOTATE_REACHABLE
 
 	jmp	paranoid_exit
 
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -92,7 +92,7 @@ do {								\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);		\
+	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE);	\
 	instrumentation_end();					\
 } while (0)
 
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -101,7 +101,7 @@
 
 #define ASM_CALL_ARG0							\
 	"call %c[__func]				\n"		\
-	ASM_REACHABLE
+	ANNOTATE_REACHABLE
 
 #define ASM_CALL_ARG1							\
 	"movq	%[arg1], %%rdi				\n"		\
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -111,14 +111,6 @@
 #endif
 .endm
 
-
-.macro REACHABLE
-.Lhere_\@:
-	.pushsection .discard.reachable
-	.long	.Lhere_\@
-	.popsection
-.endm
-
 .macro ANNOTATE type:req
 .Lhere_\@:
 	.pushsection .discard.annotate_insn,"M",@progbits,8
@@ -138,14 +130,11 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define __ASM_ANNOTATE(label, type)
 #define ASM_ANNOTATE(type)
-#define ASM_REACHABLE
 #else
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
-.macro REACHABLE
-.endm
 .macro ANNOTATE type:req
 .endm
 #endif
@@ -187,6 +176,12 @@
  * it will be ignored.
  */
 #define ANNOTATE_UNRET_BEGIN		ASM_ANNOTATE(ANNOTYPE_UNRET_BEGIN)
+/*
+ * This should be used directly after an instruction that is considered
+ * terminating, like a noreturn CALL or UD2 when we know they are not -- eg
+ * WARN using UD2.
+ */
+#define ANNOTATE_REACHABLE		ASM_ANNOTATE(ANNOTYPE_REACHABLE)
 
 #else
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
@@ -196,6 +191,7 @@
 #define ANNOTATE_IGNORE_ALTERNATIVE	ANNOTATE type=ANNOTYPE_IGNORE_ALTS
 #define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
 #define ANNOTATE_UNRET_BEGIN		ANNOTATE type=ANNOTYPE_UNRET_BEGIN
+#define ANNOTATE_REACHABLE		ANNOTATE type=ANNOTYPE_REACHABLE
 #endif
 
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -64,5 +64,6 @@ struct unwind_hint {
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
+#define ANNOTYPE_REACHABLE		8
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -64,5 +64,6 @@ struct unwind_hint {
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
+#define ANNOTYPE_REACHABLE		8
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -627,56 +627,6 @@ static struct instruction *find_last_ins
 	return insn;
 }
 
-/*
- * Mark "ud2" instructions and manually annotated dead ends.
- */
-static int add_dead_ends(struct objtool_file *file)
-{
-	struct section *rsec;
-	struct reloc *reloc;
-	struct instruction *insn;
-	uint64_t offset;
-
-	/*
-	 * UD2 defaults to being a dead-end, allow them to be annotated for
-	 * non-fatal, eg WARN.
-	 */
-	rsec = find_section_by_name(file->elf, ".rela.discard.reachable");
-	if (!rsec)
-		return 0;
-
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type == STT_SECTION) {
-			offset = reloc_addend(reloc);
-		} else if (reloc->sym->local_label) {
-			offset = reloc->sym->offset;
-		} else {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, offset);
-		if (insn)
-			insn = prev_insn_same_sec(file, insn);
-		else if (offset == reloc->sym->sec->sh.sh_size) {
-			insn = find_last_insn(file, reloc->sym->sec);
-			if (!insn) {
-				WARN("can't find reachable insn at %s+0x%" PRIx64,
-				     reloc->sym->sec->name, offset);
-				return -1;
-			}
-		} else {
-			WARN("can't find reachable insn at %s+0x%" PRIx64,
-			     reloc->sym->sec->name, offset);
-			return -1;
-		}
-
-		insn->dead_end = false;
-	}
-
-	return 0;
-}
-
 static int create_static_call_sections(struct objtool_file *file)
 {
 	struct static_call_site *site;
@@ -2306,6 +2256,7 @@ static int read_annotate(struct objtool_
 	struct section *sec;
 	struct instruction *insn;
 	struct reloc *reloc;
+	uint64_t offset;
 	int type, ret;
 
 	sec = find_section_by_name(file->elf, ".discard.annotate_insn");
@@ -2327,8 +2278,19 @@ static int read_annotate(struct objtool_
 	for_each_reloc(sec->rsec, reloc) {
 		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
 
-		insn = find_insn(file, reloc->sym->sec,
-				 reloc->sym->offset + reloc_addend(reloc));
+		offset = reloc->sym->offset + reloc_addend(reloc);
+		insn = find_insn(file, reloc->sym->sec, offset);
+
+		/*
+		 * Reachable annotations are 'funneh' and act on the previous instruction :/
+		 */
+		if (type == ANNOTYPE_REACHABLE) {
+			if (insn)
+				insn = prev_insn_same_sec(file, insn);
+			else if (offset == reloc->sym->sec->sh.sh_size)
+				insn = find_last_insn(file, reloc->sym->sec);
+		}
+
 		if (!insn) {
 			WARN("bad .discard.annotate_insn entry: %d of type %d", reloc_idx(reloc), type);
 			return -1;
@@ -2420,6 +2382,10 @@ static int __annotate_late(struct objtoo
 		insn->unret = 1;
 		break;
 
+	case ANNOTYPE_REACHABLE:
+		insn->dead_end = false;
+		break;
+
 	default:
 		break;
 	}
@@ -2566,14 +2532,6 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	/*
-	 * Must be after add_call_destinations() such that it can override
-	 * dead_end_function() marks.
-	 */
-	ret = add_dead_ends(file);
-	if (ret)
-		return ret;
-
 	ret = add_jump_table_alts(file);
 	if (ret)
 		return ret;
@@ -2582,6 +2540,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be after add_call_destinations() such that it can override
+	 * dead_end_function() marks.
+	 */
 	ret = read_annotate(file, __annotate_late);
 	if (ret)
 		return ret;




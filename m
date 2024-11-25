Return-Path: <linux-kernel+bounces-421033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B49D8668
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162B7B2B241
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477D01A7060;
	Mon, 25 Nov 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/XPvRQk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823B944F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539981; cv=none; b=WXDTqeYb6rmCrKnw2L2EWfWLXGFRCQQL/ylcQSnxnFTuSSI1fjMhj9SDzUshICaxeNN7/orZK6RJrl24OqP+Nn5N/okiAumlXQHwv3jIzKUj3c8Ltuz3tvM2y/tzlBmvJo1gVNA8ila7WY8kg7tiQtl9Uf+0YgKiL0Jd3LPcM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539981; c=relaxed/simple;
	bh=/mTxK42kQw/NgDBhW8SAlwKIoRCuxo6KOsUR3kl0vIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6dRBI6kP1urPXldpc/XwwSpWDJC+CrYPp5zMUJzjpr2bavDPIycvWvWXK17SdArDO1CCrosovMTb++8N8Ip/ycLv3TFfg6niHiWtubC2uYZ12UYz3fvLh2CQF72r01MnzYcVpE6MYtfjLLFiIIWtTvBZ6IgsxDYmLqtYsoIlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U/XPvRQk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BDWepXKCNHOnMhRlWOQYgQhKCM8U0HzCSU9nFM4FrxU=; b=U/XPvRQk9X4RdtaVJOj6PMO/Kx
	rzQ9tumW17HmP7W3urRSvRM95a6t11i8jgi5Jw/CMmt8LLL9rHOCnN170XeBm49uJ5leiY90510DO
	XULrVECdOxI2MWUMjHKVc+A97v0MjWNQ39Mz9l9OJ/mBummq5xmsvVu+1YV1DPXy598f4XB4XXlh8
	6hk/8BNxOMQJEnSqs28qz3L/cyAgIjAUwKqRvOJAH2exRpTlSpF29oPHNDgg1Wi4ZJUx/wDCN19l8
	TrGjYxMPWy792UiPLq1ZwEXBBH8lOynNhimq8hJWSfdG2kiYwQH/D0oZZYkSHWZ7EFwTVkV+jiuid
	PbgJNTfQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFYn7-0000000BtOI-0Bsy;
	Mon, 25 Nov 2024 13:06:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 81B8030026A; Mon, 25 Nov 2024 14:06:13 +0100 (CET)
Date: Mon, 25 Nov 2024 14:06:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] objtool: Collect all annotations in objtool.h
Message-ID: <20241125130613.GO38972@noisy.programming.kicks-ass.net>
References: <20241122121016.372005127@infradead.org>
 <20241122121556.560621502@infradead.org>
 <20241122175445.tx3edadmof76yegs@jpoimboe>
 <20241123131943.GD24774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123131943.GD24774@noisy.programming.kicks-ass.net>

On Sat, Nov 23, 2024 at 02:19:43PM +0100, Peter Zijlstra wrote:

> > BTW, is there a reason .discard.[un]reachable weren't converted over?
> 
> Completely forgot/missed them. Let me add a patch.

So this is turning into a bit of a trainwreck :/

That is, the below works, but I ended up having to include objtool.h
from compiler.h, which is really unfortunate.

--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -4,6 +4,7 @@
 
 #include <asm/break.h>
 #include <linux/stringify.h>
+#include <linux/objtool.h>
 
 #ifndef CONFIG_DEBUG_BUGVERBOSE
 #define _BUGVERBOSE_LOCATION(file, line)
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
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -3,6 +3,7 @@
 #define __LINUX_COMPILER_H
 
 #include <linux/compiler_types.h>
+#include <linux/objtool.h>
 
 #ifndef __ASSEMBLY__
 
@@ -107,37 +108,10 @@ void ftrace_likely_update(struct ftrace_
 # define barrier_before_unreachable() do { } while (0)
 #endif
 
-/* Unreachable code */
 #ifdef CONFIG_OBJTOOL
-/*
- * These macros help objtool understand GCC code flow for unreachable code.
- * The __COUNTER__ based labels are a hack to make each instance of the macros
- * unique, to convince GCC not to merge duplicate inline asm statements.
- */
-#define __stringify_label(n) #n
-
-#define __annotate_reachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
-			".pushsection .discard.reachable\n\t"		\
-			".long " __stringify_label(c) "b - .\n\t"	\
-			".popsection\n\t");				\
-})
-#define annotate_reachable() __annotate_reachable(__COUNTER__)
-
-#define __annotate_unreachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
-		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
-})
-#define annotate_unreachable() __annotate_unreachable(__COUNTER__)
-
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
-
 #else /* !CONFIG_OBJTOOL */
-#define annotate_reachable()
-#define annotate_unreachable()
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
 
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -6,12 +6,11 @@
 
 #include <linux/objtool.h>
 #include <linux/stringify.h>
-#include <linux/args.h>
 
 /* Begin/end of an instrumentation safe region */
 #define __instrumentation_begin(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     __ASM_ANNOTATE(CONCATENATE(c, b), ANNOTYPE_INSTR_BEGIN)	\
+		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_BEGIN)\
 		     : : "i" (c));					\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
@@ -49,7 +48,7 @@
  */
 #define __instrumentation_end(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     __ASM_ANNOTATE(CONCATENATE(c, b), ANNOTYPE_INSTR_END)		\
+		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_END)	\
 		     : : "i" (c));					\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_OBJTOOL_H
 #define _LINUX_OBJTOOL_H
+#ifndef LINKER_SCRIPT
 
 #include <linux/objtool_types.h>
 
@@ -45,21 +46,19 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
-#define ASM_REACHABLE							\
-	"998:\n\t"							\
-	".pushsection .discard.reachable\n\t"				\
-	".long 998b\n\t"						\
-	".popsection\n\t"
-
 #define __ASM_ANNOTATE(s, x)					\
 	".pushsection .discard.annotate_insn,\"M\",@progbits,8\n\t"	\
 	".long " __stringify(s) " - .\n\t"			\
 	".long " __stringify(x) "\n\t"				\
 	".popsection\n\t"
 
-#define ASM_ANNOTATE(x)						\
-	"911:\n\t"						\
-	__ASM_ANNOTATE(911b, x)
+#define __ASM_BREF(s)	s ## b
+
+#define _ASM_ANNOTATE(s, x)					\
+	__stringify(s) ":\n\t"					\
+	__ASM_ANNOTATE(__ASM_BREF(s), x)
+
+#define ASM_ANNOTATE(x)		_ASM_ANNOTATE(__COUNTER__, x)
 
 #else /* __ASSEMBLY__ */
 
@@ -109,14 +108,6 @@
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
@@ -135,14 +126,11 @@
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define ASM_ANNOTATE(x)
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
@@ -180,12 +168,17 @@
  */
 #define ANNOTATE_UNRET_BEGIN		ASM_ANNOTATE(ANNOTYPE_UNRET_BEGIN)
 
+#define ANNOTATE_REACHABLE		ASM_ANNOTATE(ANNOTYPE_REACHABLE)
+#define ANNOTATE_UNREACHABLE		ASM_ANNOTATE(ANNOTYPE_UNREACHABLE)
+
 #else
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
 #define ANNOTATE_RETPOLINE_SAFE		ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
 #define ANNOTATE_IGNORE_ALTERNATIVE	ANNOTATE type=ANNOTYPE_IGNORE_ALTS
 #define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
 #define ANNOTATE_UNRET_BEGIN		ANNOTATE type=ANNOTYPE_UNRET_BEGIN
+#define ANNOTATE_REACHABLE		ANNOTATE type=ANNOTYPE_REACHABLE
+#define ANNOTATE_UNREACHABLE		ANNOTATE type=ANNOTYPE_UNREACHABLE
 #endif
 
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
@@ -195,4 +188,13 @@
 #define VALIDATE_UNRET_BEGIN
 #endif
 
+#define annotate_reachable() ({			\
+	asm volatile (ANNOTATE_REACHABLE);	\
+})
+
+#define annotate_unreachable() ({		\
+	asm volatile (ANNOTATE_UNREACHABLE);	\
+})
+
+#endif /* LINKER_SCRIPT */
 #endif /* _LINUX_OBJTOOL_H */
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -64,5 +64,7 @@ struct unwind_hint {
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
+#define ANNOTYPE_REACHABLE		8
+#define ANNOTYPE_UNREACHABLE		9
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -627,95 +627,6 @@ static struct instruction *find_last_ins
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
-	 * Check for manually annotated dead ends.
-	 */
-	rsec = find_section_by_name(file->elf, ".rela.discard.unreachable");
-	if (!rsec)
-		goto reachable;
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
-				WARN("can't find unreachable insn at %s+0x%" PRIx64,
-				     reloc->sym->sec->name, offset);
-				return -1;
-			}
-		} else {
-			WARN("can't find unreachable insn at %s+0x%" PRIx64,
-			     reloc->sym->sec->name, offset);
-			return -1;
-		}
-
-		insn->dead_end = true;
-	}
-
-reachable:
-	/*
-	 * These manually annotated reachable checks are needed for GCC 4.4,
-	 * where the Linux unreachable() macro isn't supported.  In that case
-	 * GCC doesn't know the "ud2" is fatal, so it generates code as if it's
-	 * not a dead end.
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
@@ -2345,6 +2256,7 @@ static int read_annotate(struct objtool_
 	struct section *sec;
 	struct instruction *insn;
 	struct reloc *reloc;
+	uint64_t offset;
 	int type, ret;
 
 	sec = find_section_by_name(file->elf, ".discard.annotate_insn");
@@ -2366,8 +2278,19 @@ static int read_annotate(struct objtool_
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
+		if (type == ANNOTYPE_REACHABLE || type == ANNOTYPE_UNREACHABLE) {
+			if (insn)
+				insn = prev_insn_same_sec(file, insn);
+			else if (offset == reloc->sym->sec->sh.sh_size)
+				insn = find_last_insn(file, reloc->sym->sec);
+		}
+
 		if (!insn) {
 			WARN("bad .discard.annotate_insn entry: %d of type %d", reloc_idx(reloc), type);
 			return -1;
@@ -2459,6 +2382,14 @@ static int __annotate_late(struct objtoo
 		insn->unret = 1;
 		break;
 
+	case ANNOTYPE_REACHABLE:
+		insn->dead_end = false;
+		break;
+
+	case ANNOTYPE_UNREACHABLE:
+		insn->dead_end = true;
+		break;
+
 	default:
 		break;
 	}
@@ -2605,14 +2536,6 @@ static int decode_sections(struct objtoo
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
@@ -2621,6 +2544,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be after add_call_destinations() such that it can override
+	 * dead_end_function() marks.
+	 */
 	ret = read_annotate(file, __annotate_late);
 	if (ret)
 		return ret;


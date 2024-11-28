Return-Path: <linux-kernel+bounces-424486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA849DB4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5D41628C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9AE192D66;
	Thu, 28 Nov 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tSmu00M2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08E155C83;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787048; cv=none; b=g1Pdk11GfkzwZWfDX/GEtEJ1qcuXPwNdNvOTfJ0XQZRiqeYilqqcPMOUP6JdxA7jl6A0+l7WgTUl0Hsmd9420kjDoP8DT2X4/EJWAjnWwquUfOiJhOqGuTpk36G1xAKn5ANvEgBMmqzxbbzfTMGhK9fJU0tviU+BYPqeAv+oTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787048; c=relaxed/simple;
	bh=xtSZebKWsUH+UCo4IBaR0pGfLgkWjIXEJBRZfBMlU2M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YhY94IQu9CZejHk3eyg6js1Eq/fnzLWDc2Yk8XXcK4kw+ZlbO/p2B/whKQIWC40NNM8hfE4ZqsGAAxoMGK3a9Ru+ysrY15cizZppxchRJVVqwFoyymmyaOpX2r8i72wOGG0/qvFsPR3O67URfyO+qqdk5eLTl0vUh3wtBOFagZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tSmu00M2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=MaRHRxfWomSomgbkiybbctrnE7Gu06p2gq17dQqKIug=; b=tSmu00M2cslQ/Vkar7t1oTc1Ev
	WoETsvPRUwSWItwFVpYzyei2H7kmYHwSe/14GkrbrTavpTYWPdUpkDtdI1KSxu0HCB0zdeNA3Eyjf
	bbA9PxbbyWFQv/BgXazI7fMKLVqO9L6SwzfiIzKffss3RhiEpKiRVnLCkXyryW8zBNvQveexYuZux
	4PBTMiSnzuNHpx/vIFn1l0x5doLD5sT2ccAoSOlKZLNtsNlRDw/fPUfgoLvbdmSI/S7TgrTdESB33
	yzOneZc+ilm4bD3A3bRmeNOT+WM7iLuRktu7w6dmXlhFjNDwxcTrOLuBEKdyBx8TCF5ve4nvaHdIp
	moYCJUag==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb47-00000002Tq4-2oiX;
	Thu, 28 Nov 2024 09:44:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 356F7301CFB; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094312.494176035@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:39:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/16] objtool: Fix ANNOTATE_REACHABLE to be a normal annotation
References: <20241128093851.469225872@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Currently REACHABLE is weird for being on the instruction after the
instruction it modifies.

Since all REACHABLE annotations have an explicit instruction, flip
them around.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/loongarch/include/asm/bug.h |    2 +-
 arch/x86/entry/entry_64.S        |    5 ++---
 arch/x86/include/asm/bug.h       |    2 +-
 arch/x86/include/asm/irq_stack.h |    4 ++--
 include/linux/objtool.h          |    4 ++--
 tools/objtool/check.c            |   23 -----------------------
 6 files changed, 8 insertions(+), 32 deletions(-)

--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -45,7 +45,7 @@
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE);\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE(10001b));\
 	instrumentation_end();					\
 } while (0)
 
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -308,10 +308,9 @@ SYM_CODE_END(xen_error_entry)
 		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	.endif
 
-	call	\cfunc
-
 	/* For some configurations \cfunc ends up being a noreturn. */
 	ANNOTATE_REACHABLE
+	call	\cfunc
 
 	jmp	error_return
 .endm
@@ -529,10 +528,10 @@ SYM_CODE_START(\asmsym)
 	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
 	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-	call	\cfunc
 
 	/* For some configurations \cfunc ends up being a noreturn. */
 	ANNOTATE_REACHABLE
+	call	\cfunc
 
 	jmp	paranoid_exit
 
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -92,7 +92,7 @@ do {								\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE);	\
+	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
 	instrumentation_end();					\
 } while (0)
 
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -100,8 +100,8 @@
 }
 
 #define ASM_CALL_ARG0							\
-	"call %c[__func]				\n"		\
-	ANNOTATE_REACHABLE
+	"1: call %c[__func]				\n"		\
+	ANNOTATE_REACHABLE(1b)
 
 #define ASM_CALL_ARG1							\
 	"movq	%[arg1], %%rdi				\n"		\
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -177,11 +177,11 @@
  */
 #define ANNOTATE_UNRET_BEGIN		ASM_ANNOTATE(ANNOTYPE_UNRET_BEGIN)
 /*
- * This should be used directly after an instruction that is considered
+ * This should be used to refer to an instruction that is considered
  * terminating, like a noreturn CALL or UD2 when we know they are not -- eg
  * WARN using UD2.
  */
-#define ANNOTATE_REACHABLE		ASM_ANNOTATE(ANNOTYPE_REACHABLE)
+#define ANNOTATE_REACHABLE(label)	__ASM_ANNOTATE(label, ANNOTYPE_REACHABLE)
 
 #else
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -614,19 +614,6 @@ static int init_pv_ops(struct objtool_fi
 	return 0;
 }
 
-static struct instruction *find_last_insn(struct objtool_file *file,
-					  struct section *sec)
-{
-	struct instruction *insn = NULL;
-	unsigned int offset;
-	unsigned int end = (sec->sh.sh_size > 10) ? sec->sh.sh_size - 10 : 0;
-
-	for (offset = sec->sh.sh_size - 1; offset >= end && !insn; offset--)
-		insn = find_insn(file, sec, offset);
-
-	return insn;
-}
-
 static int create_static_call_sections(struct objtool_file *file)
 {
 	struct static_call_site *site;
@@ -2281,16 +2268,6 @@ static int read_annotate(struct objtool_
 		offset = reloc->sym->offset + reloc_addend(reloc);
 		insn = find_insn(file, reloc->sym->sec, offset);
 
-		/*
-		 * Reachable annotations are 'funneh' and act on the previous instruction :/
-		 */
-		if (type == ANNOTYPE_REACHABLE) {
-			if (insn)
-				insn = prev_insn_same_sec(file, insn);
-			else if (offset == reloc->sym->sec->sh.sh_size)
-				insn = find_last_insn(file, reloc->sym->sec);
-		}
-
 		if (!insn) {
 			WARN("bad .discard.annotate_insn entry: %d of type %d", reloc_idx(reloc), type);
 			return -1;




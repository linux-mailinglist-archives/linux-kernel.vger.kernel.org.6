Return-Path: <linux-kernel+bounces-424491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA7D9DB4FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B802E16803D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E6199EAD;
	Thu, 28 Nov 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GaZGUuyo"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C115746F;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787049; cv=none; b=tqeIoAZNzYm20dFRHlLYUcyPTBGGRUFtbrIJ5wzij0Qqvz4ZfjWKxKXMuXAaxqvoEoK4UR60BkLT1yRcjOdx0mmJwST5GgVElM9KuLacpHHROwOfkKvHlQuaWoY7xG42jant910WzY+fgNmx6GmHKvrNmTiogj0/qi2LNFC5MkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787049; c=relaxed/simple;
	bh=UwDAhm94WYMzmdwCr57iKe2v+wiBrV3Pe5j9H0SPak0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JCfj/293wWI7Nho4uA4TLCxFlnMyUUkPZCPJGmQ43+Xec24M2VoFttflcJ2Pmqxj0kL9UC8loa0JY6ec24hXNKi4E6oduQ6iuWAt/Vc0uFYfk1qQm0gXMi3JwlFT61pmitYMV5f7yjRVQif0GvPHLz0rZc1XCE0QHxOBFzguUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GaZGUuyo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=RpesRdzRkQjwqb+WxngnuqT7GtZc/MTBiU+SPkIMEI0=; b=GaZGUuyoRZUX27QCOC5mfJ+skx
	Z/bf6Zam07+XCGaVCu1jCdf2F694g8sPfyTxCncXXLzCPqau6mNLtjuhN+oF9nzRnnii+9oT9rhSm
	YsKH8jjfcCZYy5UA45zsOyso/WBdQRQk9AJM4f2EYUP//LOONT/9Kr4gHv5tZ4XpgIlOJLE0fju66
	xb6s4L6DvWIs+W0/fy5HhP1aitqTtZrEQJyBEXVAfZeL2fFoT2ChIWl3wRGrFypX8e2hbWtVe5yIp
	kFOkDrQQjNzhCDU6hzBo/FT+dzy5SNT/dVy6U3HOvKrNZ6HnYsimIkan6KTWVXAUT2GBPE/LvOI6D
	pqiESD6g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb47-00000002Tpw-0V1V;
	Thu, 28 Nov 2024 09:44:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2E789301CA1; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094312.235637588@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:39:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/16] objtool: Remove annotate_{,un}reachable()
References: <20241128093851.469225872@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

There are no users of annotate_reachable() left.

And the annotate_unreachable() usage in unreachable() is plain wrong;
it will hide dangerous fall-through code-gen.

Remove both.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler.h |   27 ---------------------------
 tools/objtool/check.c    |   43 ++-----------------------------------------
 2 files changed, 2 insertions(+), 68 deletions(-)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -109,35 +109,9 @@ void ftrace_likely_update(struct ftrace_
 
 /* Unreachable code */
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
 
@@ -147,7 +121,6 @@ void ftrace_likely_update(struct ftrace_
  * control elsewhere.
  */
 #define unreachable() do {		\
-	annotate_unreachable();		\
 	barrier_before_unreachable();	\
 	__builtin_unreachable();	\
 } while (0)
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -638,47 +638,8 @@ static int add_dead_ends(struct objtool_
 	uint64_t offset;
 
 	/*
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
+	 * UD2 defaults to being a dead-end, allow them to be annotated for
+	 * non-fatal, eg WARN.
 	 */
 	rsec = find_section_by_name(file->elf, ".rela.discard.reachable");
 	if (!rsec)




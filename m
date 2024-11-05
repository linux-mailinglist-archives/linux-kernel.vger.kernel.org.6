Return-Path: <linux-kernel+bounces-396359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45169BCC1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6067C1F221C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA71D515B;
	Tue,  5 Nov 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KEtbemT+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F01D3593
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807272; cv=none; b=Z9QIV2RWV0c2gzPgWb2sBqhzQDLeFL0igK2qx/QBo7/J/fdWHjhJn+TNTWRosAajDDJUSuTeke2wS15fets254VVawfk5Xwza0Yto99qoNnFPae0hLETmOZv5oUmtYR1VL2VIbqaKX8CO/q9ieLati0rXfM+2Qy0Y1L7S04/P4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807272; c=relaxed/simple;
	bh=ryXTU9fHZzQgpaF29u04yy9MkLK2NlveGQd5vziUiu0=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pJ9KR9VnnEegWcWGgGUYX2UsbjFM2bLKhy0Ya2HU0ocMtst7KaXvUv/0my/ro4TBo/wghl3fqk42RbWQa3Emxb7EOD4X71aEvrhhwstos5yF6HtoEUKiOMc4fYDXIeY8pJRTKlFLRRHtHgkf+9tyvARUqcBtFNRW/+DafsNK/g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KEtbemT+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=uzZy2VC0fu25fz6TAYvW25c3Fo100n5TxloGAF+9AvQ=; b=KEtbemT+LVy1nu+XKXgceM96uA
	lLorNLKFjXiaRwXge3BLiM4tb+Xa0LEc8Jn49e1X58FmpYViRGa1U8Jc5/gJkkisEIf1jlA6/RUX3
	N3hAiRGt0ZqBmRVXzUZZHvlaq34uJ+0/Ayr09XlTc3cK0fQQCCw9xCEFrEN0eRrMk6XP9u4NyzmeR
	pef1gXiYymz0pMmVG9zhyF0qIUuOxzaDdyPXc7Jpg5d9hB0JKcLk38Zgv3UexQE3gwTTZe3QbR0Fy
	cKSyII+EiqH/VjfL03mDhCuXbj5RGC72/tET0HCJng6STNAp5tJwbk/02iqHyTpiumIWC7hlIZ/Yx
	n73T8DAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8I2E-0000000Bjjm-1FFH;
	Tue, 05 Nov 2024 11:47:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E83BD300883; Tue,  5 Nov 2024 12:47:45 +0100 (CET)
Message-Id: <20241105114522.174924003@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 05 Nov 2024 12:39:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 alexei.starovoitov@gmail.com,
 ebiggers@kernel.org,
 samitolvanen@google.com,
 kees@kernel.org
Subject: [PATCH 4/8] x86/alternative: Simplify callthunk patching
References: <20241105113901.348320374@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Now that paravirt call patching is implemented using alternatives, it
is possible to avoid having to patch the alternative sites by
including the altinstr_replacement calls in the call_sites list.

This means we're now stacking relative adjustments like so:

  callthunks_patch_builtin_calls():
    patches all function calls to target: func() -> func()-10
    since the CALL accounting lives in the CALL_PADDING.

    This explicitly includes .altinstr_replacement

  alt_replace_call():
    patches: x86_BUG() -> target()

    this patching is done in a relative manner, and will preserve
    the above adjustment, meaning that with calldepth patching it
    will do: x86_BUG()-10 -> target()-10

  apply_relocation():
    does code relocation, and adjusts all RIP-relative instructions
    to the new location, also in a relative manner.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h |    1 -
 arch/x86/kernel/alternative.c      |    8 ++++----
 arch/x86/kernel/callthunks.c       |   13 -------------
 arch/x86/kernel/module.c           |   17 ++++++-----------
 tools/objtool/arch/x86/decode.c    |    1 +
 tools/objtool/check.c              |   12 ++----------
 6 files changed, 13 insertions(+), 39 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -109,7 +109,6 @@ struct module;
 
 struct callthunk_sites {
 	s32				*call_start, *call_end;
-	struct alt_instr		*alt_start, *alt_end;
 };
 
 #ifdef CONFIG_CALL_THUNKS
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1701,14 +1701,14 @@ void __init alternative_instructions(voi
 	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
 	apply_returns(__return_sites, __return_sites_end);
 
-	apply_alternatives(__alt_instructions, __alt_instructions_end);
-
 	/*
-	 * Now all calls are established. Apply the call thunks if
-	 * required.
+	 * Adjust all CALL instructions to point to func()-10, including
+	 * those in .altinstr_replacement.
 	 */
 	callthunks_patch_builtin_calls();
 
+	apply_alternatives(__alt_instructions, __alt_instructions_end);
+
 	/*
 	 * Seal all functions that do not have their address taken.
 	 */
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -239,21 +239,10 @@ patch_call_sites(s32 *start, s32 *end, c
 }
 
 static __init_or_module void
-patch_alt_call_sites(struct alt_instr *start, struct alt_instr *end,
-		     const struct core_text *ct)
-{
-	struct alt_instr *a;
-
-	for (a = start; a < end; a++)
-		patch_call((void *)&a->instr_offset + a->instr_offset, ct);
-}
-
-static __init_or_module void
 callthunks_setup(struct callthunk_sites *cs, const struct core_text *ct)
 {
 	prdbg("Patching call sites %s\n", ct->name);
 	patch_call_sites(cs->call_start, cs->call_end, ct);
-	patch_alt_call_sites(cs->alt_start, cs->alt_end, ct);
 	prdbg("Patching call sites done%s\n", ct->name);
 }
 
@@ -262,8 +251,6 @@ void __init callthunks_patch_builtin_cal
 	struct callthunk_sites cs = {
 		.call_start	= __call_sites,
 		.call_end	= __call_sites_end,
-		.alt_start	= __alt_instructions,
-		.alt_end	= __alt_instructions_end
 	};
 
 	if (!cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -275,12 +275,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *rseg = (void *)returns->sh_addr;
 		apply_returns(rseg, rseg + returns->sh_size);
 	}
-	if (alt) {
-		/* patch .altinstructions */
-		void *aseg = (void *)alt->sh_addr;
-		apply_alternatives(aseg, aseg + alt->sh_size);
-	}
-	if (calls || alt) {
+	if (calls) {
 		struct callthunk_sites cs = {};
 
 		if (calls) {
@@ -288,13 +283,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 			cs.call_end = (void *)calls->sh_addr + calls->sh_size;
 		}
 
-		if (alt) {
-			cs.alt_start = (void *)alt->sh_addr;
-			cs.alt_end = (void *)alt->sh_addr + alt->sh_size;
-		}
-
 		callthunks_patch_module_calls(&cs, me);
 	}
+	if (alt) {
+		/* patch .altinstructions */
+		void *aseg = (void *)alt->sh_addr;
+		apply_alternatives(aseg, aseg + alt->sh_size);
+	}
 	if (ibt_endbr) {
 		void *iseg = (void *)ibt_endbr->sh_addr;
 		apply_seal_endbr(iseg, iseg + ibt_endbr->sh_size);
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -845,5 +845,6 @@ bool arch_is_rethunk(struct symbol *sym)
 bool arch_is_embedded_insn(struct symbol *sym)
 {
 	return !strcmp(sym->name, "retbleed_return_thunk") ||
+	       !strcmp(sym->name, "srso_alias_safe_ret") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1410,15 +1410,6 @@ static void annotate_call_site(struct ob
 	if (!sym)
 		sym = reloc->sym;
 
-	/*
-	 * Alternative replacement code is just template code which is
-	 * sometimes copied to the original instruction. For now, don't
-	 * annotate it. (In the future we might consider annotating the
-	 * original instruction if/when it ever makes sense to do so.)
-	 */
-	if (!strcmp(insn->sec->name, ".altinstr_replacement"))
-		return;
-
 	if (sym->static_call_tramp) {
 		list_add_tail(&insn->call_node, &file->static_call_list);
 		return;
@@ -1476,7 +1467,8 @@ static void annotate_call_site(struct ob
 		return;
 	}
 
-	if (insn->type == INSN_CALL && !insn->sec->init)
+	if (insn->type == INSN_CALL && !insn->sec->init &&
+	    !insn->_call_dest->embedded_insn)
 		list_add_tail(&insn->call_node, &file->call_list);
 
 	if (!sibling && dead_end_function(file, sym))




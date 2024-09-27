Return-Path: <linux-kernel+bounces-342130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA6988AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9C9283F86
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76681C2DBD;
	Fri, 27 Sep 2024 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xn14qP8p"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752011C230E
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466655; cv=none; b=EWH6utuqnpvUmWUH8ipvUI4G+jjwvDhdI5URSppTmc0oOqz+IDuwYKxJ4e9LmUH0NOpx4uV+f3j1CWi/UZ+Lju074Ot47z3N01E26Hi/dtj1BDnNNXoRaWTLIgIh4i1qsktnp/cKUWNZfsAyOWzPUE+OtctAHTO6X8ZiCL1ikPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466655; c=relaxed/simple;
	bh=Xxd+7KjV5+HgGdOk/MOUF4qFidlu+p84pKGG8meR5hM=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HQQWf3WOtoO23HDoOO2wYjyNry8DyCV/gzM0fVmpI2Siyvzm9MEa18NLUdjq7iGzVwR1z0BqoxpL0jPhVT/G5UIckw2RRBykiv6ZN51DbZl7ojwPmmoRyDrQLyfYte35wAVnkTvaqZA6Kn643ddDbAkV1YVYobUu7KoknGP+P/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xn14qP8p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ojwF+rKwH0i5yOPUIhXM5uKj2cf0V2HnToDyhfHscac=; b=Xn14qP8patnfXqdGBG/0UwI1KI
	I9M7TgwjNlrzDshTssQ6+9A9bbbAEkL8tr8Q/MZSynTMEUnQwdb2ObMPVUCVx62fCLe2bP+kT3ArX
	ZDTA+p3tVaEpcCvb85KjocMBMZX7Xx+s332NugCi+tIM/4zEg5GigoxnF+XfPezxaILcGMogaDV0D
	iIIznTnz5ALufpgtoO7Z3huRfbjq+rSMoWA4jT9PmZqqjm2LNnGeC4t91xeWMVi4ttoBy16B1jJqZ
	1pJz7LUyj4l6eHLjfiECXnve+1dJp+sQKUyhTEP25MB7CUY7nYhCjDSvwMDuqCpgRwGx5vf+AzCA7
	6XK2TPDw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzF-0000000AVcg-1Ehg;
	Fri, 27 Sep 2024 19:50:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B330C300CBA; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194924.617641991@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:48:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com
Subject: [PATCH 03/14] x86/alternative: Simplify callthunk patching
References: <20240927194856.096003183@infradead.org>
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
+	 * Adjust call CALL instructions to point to func()-10, including those
+	 * in .altinstr_replacement.
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
@@ -1360,15 +1360,6 @@ static void annotate_call_site(struct ob
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
@@ -1426,7 +1417,8 @@ static void annotate_call_site(struct ob
 		return;
 	}
 
-	if (insn->type == INSN_CALL && !insn->sec->init)
+	if (insn->type == INSN_CALL && !insn->sec->init &&
+	    !insn->_call_dest->embedded_insn)
 		list_add_tail(&insn->call_node, &file->call_list);
 
 	if (!sibling && dead_end_function(file, sym))




Return-Path: <linux-kernel+bounces-424492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CE29DB4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5032A167EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32535199EA3;
	Thu, 28 Nov 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JIEyW5r2"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AD158531;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787049; cv=none; b=aPGm7hux5H3yqpjmtvUJ4ibzy7SiPtnbNjMJ2MCd62ZW2v68LzEsD0TIZRAbBd6gcGGAFAeyC/gHH45DWRSsgWu0pZLzd9QfTeI+m2OWgNfjAqsAh2o3znAcRPSlVTjvVjZaFiIac7n+5TsswNqA//s5TsOmivTCPihldwOqp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787049; c=relaxed/simple;
	bh=Oe+3vjd2qdkewgyh/k7t04PvR1t241PDwCsmc7iAVRI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aGpFzCa1z3Lw920npFk1B/h4JYLzD74CKS3Ikytx3HuVdtJ8HlbffnwxWAz6/mDjWPDP8PtuUFqUpEIUsNI/vEU0Vy0C13ws4x3VrU02KZlbYZzzkMFfylpniNZMO4Fs6h6AoOgC4fyEOHh+B3dhQpJ6OQ9W8jqcXbu9BGh5AM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JIEyW5r2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=wX5tmmCqoplajf6+NuYtusl+C0AEA6dnIu4zaT2BJ+Y=; b=JIEyW5r20fRmd80e0YLk5B7J6c
	V3RmIF3V+0UlLCl+5qv5qRs0ebNZmbPZOIFVWDaiTcjehoVF32TzzRBZ14KOutwvGYHeOOxPelKUX
	JJqJYyRt1fUbll7GBcH6wFXs1A85w78U2aROWiga72KnSnq5ggW38SBTlFhBcLAZz+3mfpMsWQXIS
	Fspi5NpqVwwShfjq7DHoh7hu5T7NUz6ZRp/IJk3T4OSHMWAIUJpZ1E6C2I3UqVaoLqs+tiCG71GHk
	WcAoa3zPtsP2KS3rDTqRTwk4+MSLTYXHUzNAiXZ8AIO4S/aCwtB/IMNUimBFIisr6mCJcpTDofuDH
	tPMDhhkg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb47-00000001a7x-1oJG;
	Thu, 28 Nov 2024 09:44:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0371B30026A; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094310.932794537@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:38:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/16] objtool: Generic annotation infrastructure
References: <20241128093851.469225872@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Avoid endless .discard.foo sections for each annotation, create a
single .discard.annotate_insn section that takes an annotation type along
with the instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/objtool.h |   18 ++++++++++++++++++
 tools/objtool/check.c   |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -57,6 +57,13 @@
 	".long 998b\n\t"						\
 	".popsection\n\t"
 
+#define ASM_ANNOTATE(type)						\
+	"911:\n\t"							\
+	".pushsection .discard.annotate_insn,\"M\",@progbits,8\n\t"	\
+	".long 911b - .\n\t"						\
+	".long " __stringify(type) "\n\t"				\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -146,6 +153,14 @@
 	.popsection
 .endm
 
+.macro ANNOTATE type:req
+.Lhere_\@:
+	.pushsection .discard.annotate_insn,"M",@progbits,8
+	.long	.Lhere_\@ - .
+	.long	\type
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
@@ -155,6 +170,7 @@
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
+#define ASM_ANNOTATE(type)
 #define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
 #else
@@ -167,6 +183,8 @@
 .endm
 .macro REACHABLE
 .endm
+.macro ANNOTATE type:req
+.endm
 #endif
 
 #endif /* CONFIG_OBJTOOL */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2373,6 +2373,49 @@ static int read_unwind_hints(struct objt
 	return 0;
 }
 
+static int read_annotate(struct objtool_file *file, void (*func)(int type, struct instruction *insn))
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct reloc *reloc;
+	int type;
+
+	sec = find_section_by_name(file->elf, ".discard.annotate_insn");
+	if (!sec)
+		return 0;
+
+	if (!sec->rsec)
+		return 0;
+
+	if (sec->sh.sh_entsize != 8) {
+		static bool warned = false;
+		if (!warned) {
+			WARN("%s: dodgy linker, sh_entsize != 8", sec->name);
+			warned = true;
+		}
+		sec->sh.sh_entsize = 8;
+	}
+
+	for_each_reloc(sec->rsec, reloc) {
+		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
+
+		insn = find_insn(file, reloc->sym->sec,
+				 reloc->sym->offset + reloc_addend(reloc));
+		if (!insn) {
+			WARN("bad .discard.annotate_insn entry: %d of type %d", reloc_idx(reloc), type);
+			return -1;
+		}
+
+		func(type, insn);
+	}
+
+	return 0;
+}
+
+static void __annotate_nop(int type, struct instruction *insn)
+{
+}
+
 static int read_noendbr_hints(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -2670,6 +2713,8 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	read_annotate(file, __annotate_nop);
+
 	/*
 	 * Must be before read_unwind_hints() since that needs insn->noendbr.
 	 */




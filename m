Return-Path: <linux-kernel+bounces-196800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542798D61E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A744283870
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3015886E;
	Fri, 31 May 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edYPUPMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B931586C1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158933; cv=none; b=m5ulBHQxktqEToraRE5g0mOWuDkFV/dHE6yEpe2GOyaEryDMzDzHxgA3Axg12N6YFjBV66mBzVPQtPMwymBgWO3hIdbcb3EUqXwRPV86yXpBaGPOSmqQeCVAiv5aToA3RD5pAPqk6fPbZ99R6ZHSU/vB2GuPGRL9vSGGTP/9EgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158933; c=relaxed/simple;
	bh=duytlqQj8aupakjXZbZuEUtL1bnOnoFgPDJUWXroXHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe/lSNvFMVd+P5LwyW7ZXCUS88usdwayv9zPwjTLfASuB5gpP0pqk1olwYiOSdw8vhTHOY5i3C/+aH1b9wcRBkjKv2hNMHuXUjIldO9Qx8EIwWcI/3pkm5iODYr78IWIY7lBL+rSKVB+QhDrBaqTgYWcC3RJKCW+ZyaDePsAGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edYPUPMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D338AC32781;
	Fri, 31 May 2024 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158933;
	bh=duytlqQj8aupakjXZbZuEUtL1bnOnoFgPDJUWXroXHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edYPUPMO0venmdNIjTdYf5/woZ55IhefIVOAAJzCsBHwwNG1R2E3jgkpsse+9ufBo
	 9SAK2Tt4s4g1v8BF6LEecK41xq+B3cP12SEvpE6d+pRwODe4pgP6AaMtVzMJ6oIcVf
	 QXaLhY3z4ylJbUnGENZfRjk/nDknwOFj6A5LnLg1+xQzDUTP6jGcs6P7ikg5PgydbV
	 vm3NKHvHw4k+mD56x+EB9+6jo32m/Jjgd2dWkjOdmGrm+oRtcCps8ciAKOGRSVDYYq
	 XGRInHRk9iake0tZEoZWBkdECm3T2WO9EeO6k476S+a1TJGDqO76RvLLBPuDto9HJh
	 Er64S9zxxooZQ==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 14/14] x86/alternative: Replace the old macros
Date: Fri, 31 May 2024 14:35:11 +0200
Message-ID: <20240531123512.21427-15-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531123512.21427-1-bp@kernel.org>
References: <20240531123512.21427-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Now that the new macros have been gradually put in place, replace the
old ones. Leave the new label numbers starting at 7xx as a hint that the
new nested alternatives are being used now.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 144 +++++++----------------------
 arch/x86/kernel/fpu/xstate.h       |   2 +-
 2 files changed, 33 insertions(+), 113 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 19b574331ffd..f02867092a49 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -156,131 +156,51 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 #define ALT_CALL_INSTR		"call BUG_func"
 
-#define b_replacement(num)	"664"#num
-#define e_replacement(num)	"665"#num
+#define alt_slen		"772b-771b"
+#define alt_total_slen		"773b-771b"
+#define alt_rlen		"775f-774f"
 
-#define alt_end_marker		"663"
-#define alt_slen		"662b-661b"
-#define n_alt_slen		"772b-771b"
-
-#define alt_total_slen		alt_end_marker"b-661b"
-#define n_alt_total_slen	"773b-771b"
-
-#define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
-#define n_alt_rlen		"775f-774f"
-
-#define OLDINSTR(oldinstr, num)						\
-	"# ALT: oldnstr\n"						\
-	"661:\n\t" oldinstr "\n662:\n"					\
-	"# ALT: padding\n"						\
-	".skip -(((" alt_rlen(num) ")-(" alt_slen ")) > 0) * "		\
-		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
-	alt_end_marker ":\n"
-
-#define N_OLDINSTR(oldinstr)						\
-	"# N_ALT: oldinstr\n"						\
+#define OLDINSTR(oldinstr)						\
+	"# ALT: oldinstr\n"						\
 	"771:\n\t" oldinstr "\n772:\n"					\
-	"# N_ALT: padding\n"						\
-	".skip -(((" n_alt_rlen ")-(" n_alt_slen ")) > 0) * "		\
-		"((" n_alt_rlen ")-(" n_alt_slen ")),0x90\n"		\
+	"# ALT: padding\n"						\
+	".skip -(((" alt_rlen ")-(" alt_slen ")) > 0) * "		\
+		"((" alt_rlen ")-(" alt_slen ")),0x90\n"		\
 	"773:\n"
 
-/*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_short(a, b)	"((" a ") ^ (((" a ") ^ (" b ")) & -(-((" a ") < (" b ")))))"
-
-/*
- * Pad the second replacement alternative with additional NOPs if it is
- * additionally longer than the first replacement alternative.
- */
-#define OLDINSTR_2(oldinstr, num1, num2) \
-	"# ALT: oldinstr2\n"									\
-	"661:\n\t" oldinstr "\n662:\n"								\
-	"# ALT: padding2\n"									\
-	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
-		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
-	alt_end_marker ":\n"
-
-#define OLDINSTR_3(oldinsn, n1, n2, n3)								\
-	"# ALT: oldinstr3\n"									\
-	"661:\n\t" oldinsn "\n662:\n"								\
-	"# ALT: padding3\n"									\
-	".skip -((" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")) > 0) * "							\
-		"(" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")), 0x90\n"							\
-	alt_end_marker ":\n"
-
-#define ALTINSTR_ENTRY(ft_flags, num)					      \
-	" .long 661b - .\n"				/* label           */ \
-	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
-	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
-	" .byte " alt_total_slen "\n"			/* source len      */ \
-	" .byte " alt_rlen(num) "\n"			/* replacement len */
-
-#define N_ALTINSTR_ENTRY(ft_flags)					      \
+#define ALTINSTR_ENTRY(ft_flags)					      \
 	".pushsection .altinstructions,\"a\"\n"				      \
 	" .long 771b - .\n"				/* label           */ \
 	" .long 774f - .\n"				/* new instruction */ \
 	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
-	" .byte " n_alt_total_slen "\n"			/* source len      */ \
-	" .byte " n_alt_rlen "\n"			/* replacement len */ \
+	" .byte " alt_total_slen "\n"			/* source len      */ \
+	" .byte " alt_rlen "\n"				/* replacement len */ \
 	".popsection\n"
 
-#define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
-	"# ALT: replacement " #num "\n"						\
-	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
-
-#define N_ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
-	".pushsection .altinstr_replacement, \"ax\"\n"				\
-	"# N_ALT: replacement\n"						\
-	"774:\n\t" newinstr "\n775:\n"						\
+#define ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
+	".pushsection .altinstr_replacement, \"ax\"\n"			\
+	"# ALT: replacement\n"						\
+	"774:\n\t" newinstr "\n775:\n"					\
 	".popsection\n"
 
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
-	OLDINSTR(oldinstr, 1)						\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags, 1)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr, 1)				\
-	".popsection\n"
-
-/* Nested alternatives macro variant */
-#define N_ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
-	N_OLDINSTR(oldinstr)						\
-	N_ALTINSTR_ENTRY(ft_flags)					\
-	N_ALTINSTR_REPLACEMENT(newinstr)
+	OLDINSTR(oldinstr)						\
+	ALTINSTR_ENTRY(ft_flags)					\
+	ALTINSTR_REPLACEMENT(newinstr)
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	OLDINSTR_2(oldinstr, 1, 2)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
-	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
-	".popsection\n"
-
-#define N_ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
-	N_ALTERNATIVE(N_ALTERNATIVE(oldinst, newinst1, flag1),		\
-		      newinst2, flag2)
+	ALTERNATIVE(ALTERNATIVE(oldinstr, newinstr1, ft_flags1), newinstr2, ft_flags2)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
-	N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
-		      newinstr_yes, ft_flags)
+	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS, newinstr_yes, ft_flags)
 
 #define ALTERNATIVE_3(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, \
 			newinstr3, ft_flags3)				\
-	N_ALTERNATIVE(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2), \
+	ALTERNATIVE(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2), \
 		      newinstr3, ft_flags3)
+
 /*
  * Alternative instructions for different CPU types or capabilities.
  *
@@ -294,10 +214,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * without volatile and memory clobber.
  */
 #define alternative(oldinstr, newinstr, ft_flags)			\
-	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
+	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
 /*
  * Alternative inline assembly with input.
@@ -308,17 +228,17 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Leaving an unused argument 0 to keep API compatibility.
  */
 #define alternative_input(oldinstr, newinstr, ft_flags, input...)	\
-	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
+	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) \
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
-	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
+	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: output : "i" (0), ## input)
 
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile(N_ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
+	asm_inline volatile(ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
@@ -329,7 +249,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,		\
 			   output, input...)						\
-	asm_inline volatile(N_ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,	\
+	asm_inline volatile(ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,	\
 		"call %P[new2]", ft_flags2)						\
 		: output, ASM_CALL_CONSTRAINT						\
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
@@ -413,7 +333,7 @@ void nop_func(void);
  * @newinstr. ".skip" directive takes care of proper instruction padding
  * in case @newinstr is longer than @oldinstr.
  */
-#define __N_ALTERNATIVE(oldinst, newinst, flag)				\
+#define __ALTERNATIVE(oldinst, newinst, flag)				\
 740:									\
 	oldinst	;							\
 741:									\
@@ -429,7 +349,7 @@ void nop_func(void);
 	.popsection ;
 
 .macro ALTERNATIVE oldinstr, newinstr, ft_flags
-	__N_ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
+	__ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
 .endm
 
 #define old_len			141b-140b
@@ -452,12 +372,12 @@ void nop_func(void);
  * @feature2, it replaces @oldinstr with @feature2.
  */
 .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
-	__N_ALTERNATIVE(__N_ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
+	__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
 		      \newinstr2, \ft_flags2)
 .endm
 
 .macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
-	__N_ALTERNATIVE(N_ALTERNATIVE_2(\oldinstr, \newinstr1, \ft_flags1, \newinstr2, \ft_flags2),
+	__ALTERNATIVE(ALTERNATIVE_2(\oldinstr, \newinstr1, \ft_flags1, \newinstr2, \ft_flags2),
 		      \newinstr3, \ft_flags3)
 .endm
 
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 4fe8501efc6c..70903c12a911 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -134,7 +134,7 @@ static inline u64 xfeatures_mask_independent(void)
 				 XRSTORS, X86_FEATURE_XSAVES)		\
 		     "\n"						\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE(661b, 3b, EX_TYPE_FPU_RESTORE)	\
+		     _ASM_EXTABLE_TYPE(771b, 3b, EX_TYPE_FPU_RESTORE)	\
 		     :							\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
-- 
2.43.0



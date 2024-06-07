Return-Path: <linux-kernel+bounces-205891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5B19001E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0FA1C2154D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D94194A52;
	Fri,  7 Jun 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDBIfceO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770181946D0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759040; cv=none; b=N/TMf8LX4t4fSv5ToOHeFq1aRyutTHpIREsAVSL0MsOHvSjkFvI5CIE2a4K/FYTgrwpgKLuZPTC5fNaTNh6NRtmyvdQSK3i7yq+306HH+ZWg5cQfi3h9ldiXwLOPGsem2G/yZtDC/QTXdJH+0MieuXDrBHEIIUvNkp1eZEe054k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759040; c=relaxed/simple;
	bh=Kpx+YjQbXZ46f/l7nC+io8PAVstKFYCXDtl4IwhcbhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLyHliRxrKSPnyEQmR6RH614rL1u0LOyRRnDu8cr0wgcEPmH9C/vHE5KSvjs7hii9z9t8Fyxcpd7Ll0zLRdIdm+ofZZ5JySAiKfxWhR5OExa2Q4jUcUUaHJFd/7FPCb/BRBnxedLTZfFpFPbqb6EJdBbsDVGlRJtql/Gj/FxEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDBIfceO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CA8C2BBFC;
	Fri,  7 Jun 2024 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759040;
	bh=Kpx+YjQbXZ46f/l7nC+io8PAVstKFYCXDtl4IwhcbhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDBIfceOM0a8ua9YZzce3mzEdeqnp0h4vluwItzCJmjEMCZm1C4fct/0Jzsr3HGge
	 FxZJ6e2ksFpMUBHNyrNIsSLPIjSTVQCBMgDc+926ixSAIbEKmNSq6BFhLl4D4ermwe
	 s70m2OMf1tdzM/ZblhraGTb8x3STZ3fgusR/jciDd1wIkikSzuooyyTJXaDG0+6jZR
	 GvoRvnertpnxICoIn5IAn1Orh3RTcbYAeSZLUoyeFg2PGEcpqMNpxwG9Ohb9wmwOpQ
	 K5D4Tnx/Q7Hroz2I2p/u5gMGTXocz+ZgSuHe5m2pwIM1sBK3MrcUgrJHSGVhMiZN+H
	 RCXLJRkGmUQJA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 10/14] x86/alternative: Convert ALTERNATIVE_3()
Date: Fri,  7 Jun 2024 13:16:57 +0200
Message-ID: <20240607111701.8366-11-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607111701.8366-1-bp@kernel.org>
References: <20240607111701.8366-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Zap the hack of using an ALTERNATIVE_3() internal label, as suggested by
bgerst:

  https://lore.kernel.org/r/CAMzpN2i4oJ-Dv0qO46Fd-DxNv5z9=x%2BvO%2B8g=47NiiAf8QEJYA@mail.gmail.com

in favor of a label local to this macro only, as it should be done.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 24 ++++--------------------
 arch/x86/kernel/fpu/xstate.h       | 14 +++++---------
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 007baab32c14..fba12ad237e2 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -277,26 +277,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, ft_flags)
 
-#define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
-			newinsn3, ft_flags3)				\
-	OLDINSTR_3(oldinsn, 1, 2, 3)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	ALTINSTR_ENTRY(ft_flags3, 3)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinsn1, 1)				\
-	ALTINSTR_REPLACEMENT(newinsn2, 2)				\
-	ALTINSTR_REPLACEMENT(newinsn3, 3)				\
-	".popsection\n"
-
-
-#define N_ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
-		      newinst3, flag3)					\
-	N_ALTERNATIVE(N_ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
-		      newinst3, flag3)
-
+#define ALTERNATIVE_3(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, \
+			newinstr3, ft_flags3)				\
+	N_ALTERNATIVE(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2), \
+		      newinstr3, ft_flags3)
 /*
  * Alternative instructions for different CPU types or capabilities.
  *
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 05df04f39628..2ee0b9c53dcc 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -106,21 +106,17 @@ static inline u64 xfeatures_mask_independent(void)
  * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEOPT
  * supports modified optimization which is not supported by XSAVE.
  *
- * We use XSAVE as a fallback.
- *
- * The 661 label is defined in the ALTERNATIVE* macros as the address of the
- * original instruction which gets replaced. We need to use it here as the
- * address of the instruction where we might get an exception at.
+ * Use XSAVE as a fallback.
  */
 #define XSTATE_XSAVE(st, lmask, hmask, err)				\
-	asm volatile(ALTERNATIVE_3(XSAVE,				\
+	asm volatile("1: " ALTERNATIVE_3(XSAVE,				\
 				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
 				   XSAVEC,   X86_FEATURE_XSAVEC,	\
 				   XSAVES,   X86_FEATURE_XSAVES)	\
 		     "\n"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(661b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
+		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
@@ -130,11 +126,11 @@ static inline u64 xfeatures_mask_independent(void)
  * XSAVE area format.
  */
 #define XSTATE_XRESTORE(st, lmask, hmask)				\
-	asm volatile(ALTERNATIVE(XRSTOR,				\
+	asm volatile("1: " ALTERNATIVE(XRSTOR,				\
 				 XRSTORS, X86_FEATURE_XSAVES)		\
 		     "\n"						\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE(661b, 3b, EX_TYPE_FPU_RESTORE)	\
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FPU_RESTORE)	\
 		     :							\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
-- 
2.43.0



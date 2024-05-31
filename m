Return-Path: <linux-kernel+bounces-196796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4D8D61E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15FE1F264D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757EC17623A;
	Fri, 31 May 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY6J2Q65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5FE1761B8
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158928; cv=none; b=UpBd8kDm5iAjrmzJcgxAggIu6LJ2FqYzB2cLobn2rCEdxS1gyBLWj/MQpNe7TaKboeQ7HUJRoVcQhn2ojhjmz0TIkLo8TSiDDltCgFDla7DO54r1g70LJUL+bGwhQbf73lKnrMEJNLZSMsnWXNrkW7tGTPxItVhMr2YyGHsrwn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158928; c=relaxed/simple;
	bh=RVWUpI+ztxW7eltxB+4LrpXND84Y22vsqge4eJbKxJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0qU/qsoVTpzRQFgqGu2u69vyeoK6sEhIDAfvaXPjjZn7EILo0ivJ/j9srIJ+wdnpNVwFRO3cHIKDG9wR7AToJ9di+e0CZeiIRwTVAu+VALwtXBSfCHt5gx9z2bD2774fB0dlR6oMSxE3UU92QOK7f17cOgjqjFEoq0dgRgGQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY6J2Q65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA65BC32781;
	Fri, 31 May 2024 12:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158928;
	bh=RVWUpI+ztxW7eltxB+4LrpXND84Y22vsqge4eJbKxJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jY6J2Q65F3fsacyYB4He5iDuCWRQZ+MMv00KcUN/h+x/JzPVLcJeMKfENjmIdb2Dj
	 F9D1dH+wBzGH3ESctPFdLwcWi/1lxaJtKNqVjoxSJ5/e+J8cZ+XzgUPGY029buSfTw
	 JLoRYNllgilzIP34f+qQ3Tueym7otnHmOBSnHmaxkBr3LqDCZsea86uPA8tMTYKMXY
	 UkioHa5eCpM3WK6njjXOfGMbEyr+TqEVDdhmZ3/duGhn2VNmZj87FfPCP4vWvWklZH
	 kCe/FK/3QPzywsUDYtXon3tke6n+g8KZXUDcCSJf2euJIZjwWVbcsjupHNH9Oxhi5H
	 Q46fcMdIlCekw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 10/14] x86/alternative: Convert ALTERNATIVE_3()
Date: Fri, 31 May 2024 14:35:07 +0200
Message-ID: <20240531123512.21427-11-bp@kernel.org>
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

Fixup label numbering too as the new macros have new label numbers.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 24 ++++--------------------
 arch/x86/kernel/fpu/xstate.h       |  4 ++--
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 73ee18705ef1..0df99855e003 100644
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
index 05df04f39628..4fe8501efc6c 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -108,7 +108,7 @@ static inline u64 xfeatures_mask_independent(void)
  *
  * We use XSAVE as a fallback.
  *
- * The 661 label is defined in the ALTERNATIVE* macros as the address of the
+ * The 771 label is defined in the ALTERNATIVE* macros as the address of the
  * original instruction which gets replaced. We need to use it here as the
  * address of the instruction where we might get an exception at.
  */
@@ -120,7 +120,7 @@ static inline u64 xfeatures_mask_independent(void)
 		     "\n"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(661b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
+		     _ASM_EXTABLE_TYPE_REG(771b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
-- 
2.43.0



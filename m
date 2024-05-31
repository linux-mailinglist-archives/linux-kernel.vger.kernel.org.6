Return-Path: <linux-kernel+bounces-196797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5DB8D61E5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B5AB25F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49B9176ACD;
	Fri, 31 May 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4UYdC5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837A17625F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158930; cv=none; b=F4Z3mstf4Ln+Y2sNH7pq6ToX1iQdQb1sgv7XMU7dLYT522wwZduiBbHkX6CbT/USrx89uD4OXxH7NyDbD7uxZiboH6L440BcPZH45Xpu8ERDkZ21FltJJlbi7Z3EKRclu6/Mp0ULEQ5GUGpelR/Q4JfSJSnS+/bHN4Xgj2RjQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158930; c=relaxed/simple;
	bh=fX9zdFndNsZ6Oozx6KKrax/RedQUUs+v/vZeMTOCjCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON+RAYnvD7iTp2eEJT0/kgkRVG4MljzPV//AdODb2qzXVzRH+DbfP0yUuvT9SWNp1dKnF5UMByL3qYe8gZUHRcsv1nl8bWJZRsfFOPhFPitF/e/UQqkBGgsaNbJMioTMkm66eKn8q2P1C0GyBn5sFEmGgcrsoIfMIkgZKiNhob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4UYdC5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158A2C32781;
	Fri, 31 May 2024 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158929;
	bh=fX9zdFndNsZ6Oozx6KKrax/RedQUUs+v/vZeMTOCjCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4UYdC5AAMlep3YEpHUIQzMelPybpqMLrdL6Ux1LTCiQFYlcJr40cZJ43JcrIZJkZ
	 VE4BxD7MpWswtCIk8UC+jyzM5FAF4uwjpheHf9ndOCKmV0KCW0nb9zG2j69D0Jfh1c
	 kmJk1tN1qZymULInPejRWQnX4AblcoNxT/mq+wmLW46GRGbwg96smBV2OVGr2LRZXO
	 FzkIO33nGKcQE41nD/RrUkfObkL2TK/yEKorNDSQgFop7MCPA16kbM/aBXJYAx0ma4
	 r32Tjz79pr0uPc6r2mu69SebjghIAspBEUBW7p1vnjdV0BTAulxJYgSGKA+T+Vw8Fm
	 VN8cn7I+jSiRg==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 11/14] x86/alternative: Convert the asm ALTERNATIVE() macro
Date: Fri, 31 May 2024 14:35:08 +0200
Message-ID: <20240531123512.21427-12-bp@kernel.org>
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

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 0df99855e003..4b17267f3f2f 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -413,24 +413,6 @@ void nop_func(void);
  * @newinstr. ".skip" directive takes care of proper instruction padding
  * in case @newinstr is longer than @oldinstr.
  */
-.macro ALTERNATIVE oldinstr, newinstr, ft_flags
-140:
-	\oldinstr
-141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags,142b-140b,144f-143f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr
-144:
-	.popsection
-.endm
-
 #define __N_ALTERNATIVE(oldinst, newinst, flag)				\
 740:									\
 	oldinst	;							\
@@ -446,12 +428,10 @@ void nop_func(void);
 744:									\
 	.popsection ;
 
-
-.macro N_ALTERNATIVE oldinstr, newinstr, ft_flags
+.macro ALTERNATIVE oldinstr, newinstr, ft_flags
 	__N_ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
 .endm
 
-
 #define old_len			141b-140b
 #define new_len1		144f-143f
 #define new_len2		145f-144f
-- 
2.43.0



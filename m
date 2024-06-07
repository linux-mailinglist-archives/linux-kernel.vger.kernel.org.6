Return-Path: <linux-kernel+bounces-205889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9051C9001E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A663A1C20E03
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9E19413B;
	Fri,  7 Jun 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtOt/ExG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1BD1940B5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759037; cv=none; b=CbgTW44w/PXrhNwdT1gELzSY96VBvxEvQIKlFokPgve2o5ocxcOtSMErUQnb8DwL8L29japBGL1SJpgo9e96SIQSuISMdnpI73OS4IeBX6rlZawJNbioAKclJgXqd2ZB3+xGgSKl459g+uok3REBJIzLrqxQztEqoA87E6Uhf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759037; c=relaxed/simple;
	bh=SkAL6P8aesAmbpCT2O5FROApQPOqWnWIL7i4C/sp/ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJSIxhBcGS7PXqBqdHNS/ms3wQydmb/SCqnjbCiWttghGINUXnJMZ15WvQctBVBkGXQh/3ictrncS+NRLToBFijR5MLw5ddNDtFcffWfN8joDaLku4H4xTAnx2v+NToYmBT7xNNu5HgqtwdvO1/CRb8TPhEvGqKJ8mtwLJVc+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtOt/ExG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA878C4AF07;
	Fri,  7 Jun 2024 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759037;
	bh=SkAL6P8aesAmbpCT2O5FROApQPOqWnWIL7i4C/sp/ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtOt/ExG7mZegohbTeKdWc1S0nbNzsMDDcgUzeac90GfN2BehWlvUchO/MaUQ8xUC
	 Ex3D/s0pkZnBq0VKivMuoNKEzvvOXCOrefExiUXfgPyQYPSiDo4lUqKwmRpYjsuudW
	 DgOP93iJ/aEjLI1aecLwJ5ASB7+mzag9tFa3JoKArjI8m6lf5R+kDSxdSxYxxiUNae
	 RIilEd4RZnH7M5sVnITDm6S0RXRUoT04X7U4EGkqbMJkgtfVh+HqZCwpM2ZFdEUC6N
	 uU8FWW99E5/KLQehIIHGhlmBdEa6eNwKqrpEdS3EXqrxidTl7lUmF9xFhZGFAkhpBo
	 WWpj2Zx2ETCbg==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 08/14] x86/alternative: Convert alternative_call_2()
Date: Fri,  7 Jun 2024 13:16:55 +0200
Message-ID: <20240607111701.8366-9-bp@kernel.org>
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

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index b6597574fa43..bc260f27d7f1 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -358,23 +358,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, function1 is used.
  * Otherwise, old function is used.
  */
-#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2, \
-			   output, input...)				\
-	asm_inline volatile (ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1, \
-		"call %c[new2]", ft_flags2)				\
-		: output, ASM_CALL_CONSTRAINT				\
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		\
+#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,		\
+			   output, input...)						\
+	asm_inline volatile(N_ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,	\
+		"call %c[new2]", ft_flags2)						\
+		: output, ASM_CALL_CONSTRAINT						\
+		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
 		  [new2] "i" (newfunc2), ## input)
 
-#define n_alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,   \
-			   output, input...)				      \
-	asm_inline volatile (N_ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,\
-		"call %c[new2]", ft_flags2)				      \
-		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input)
-
-
 /*
  * use this macro(s) if you need more than one output parameter
  * in alternative_io
-- 
2.43.0



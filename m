Return-Path: <linux-kernel+bounces-205884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B09001DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880AD2832E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1CE190675;
	Fri,  7 Jun 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPLRjesl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61384190463
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759031; cv=none; b=sF5N7zzBfRJI+gON9fGcmUQiXnFofflHsp3hfcUSJ+rqTcV4i9xIH3aniqUm+HkLwP5qrls+P8psXjnGFW+dddb0doCEY+ZnIk28yR7YuQtivWtTmVwFGFv8d1enlVSpnMgxZ2Dwd0GnkcvcRX4oD1iaw4pqF09X7HPAeQOIwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759031; c=relaxed/simple;
	bh=vziuIUlIcL3EGLmUnsFyHCZrIa0y4BZwVvEBzkBn1Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWYWoPoaOrvWaOuW6vt3zedDpV2NFmUUabea3868Mc/5sPQyRUtS2iy6rrJuAZ/GYcnB932oTuYX4kzEQAGrQcng+uGyWyaDB/4LIOa3nTanWg3EOfegjMvmiAsk+kmt3Cyt3PG3r31UicYw0aPfQpPLT3swF5exmmNsZuDO80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPLRjesl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C26C32781;
	Fri,  7 Jun 2024 11:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759031;
	bh=vziuIUlIcL3EGLmUnsFyHCZrIa0y4BZwVvEBzkBn1Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPLRjeslzhWdmICfKo0WrcZj8hxdiWojzbiKznAwLYS1YX05UkRQ5PtuX+Of5Gq+C
	 4SoQ5RmGpeupqgybdJEBUANYRMfbQwyV53PAr5KuLkmH4IrDs4BDLf0olTHbL0G/fZ
	 qU44LTOzZBp59hZvmXBC1ODCGWYZ9eun8/zcVIUj1iyAjDJf1lhAhk4zMWLaJRVn7l
	 Uqq43iUrLaJyinVTRHJs0IdyolbVcIkXUSThuiokbEvYz1hhkF1uwTDg7VHWLPr8ki
	 PpnZDxyERGfLyFFHLsd44rlDmAvd9J1wv9uWssJIMuc7PniWieVrwmcp4nWgtNm7i8
	 P98o6Q7u6k7Fg==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 03/14] x86/alternative: Convert alternative()
Date: Fri,  7 Jun 2024 13:16:50 +0200
Message-ID: <20240607111701.8366-4-bp@kernel.org>
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

Split conversion deliberately into minimal pieces to ease bisection
because debugging alternatives is a nightmare.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 7d9ebc516bde..c05bff2e3626 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -316,14 +316,11 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * without volatile and memory clobber.
  */
 #define alternative(oldinstr, newinstr, ft_flags)			\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
+	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
-#define n_alternative(oldinstr, newinstr, ft_flags)			\
-	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
-
 #define n_alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
-- 
2.43.0



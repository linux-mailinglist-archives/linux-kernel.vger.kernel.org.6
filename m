Return-Path: <linux-kernel+bounces-205888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394CA9001DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC240284241
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015F19409E;
	Fri,  7 Jun 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAlGygxt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB5194088
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759036; cv=none; b=KcR4GOAqUdV2CmkBGZev5PQXCcDlGm5sEnpp/c8Sdu9u+qX8++qyvPaFLvNDykLgkw899Rtpq3HkYl9s2X0Ptgq/VOsmiOa9zmXJurqUxqMi1iXLSpv4THfxyeDeH3Yb+Ouh9+Q8bx8GxpcF/C8GUYQjaEChENshL7PusFWuYc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759036; c=relaxed/simple;
	bh=rn3s2RmxRTxbJSVhbZdiuz/L02U5NGxr5eXKw3dd/jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elCF1CXggKcSS4bU3zx88enZCzv8GmKj8/8YmnhQrhXVgBsEaXboRBjvTppfHw3lbx739P8oMroBzpxiHcFf49VyM0jIEc5J3eSEENMfQXQhAHFpzrrraGHGZ2Qw8aM7dXhW5ZgROVmdhWvKE15Vv0Q2tWfIIAQC60ylKirXUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAlGygxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9279CC32781;
	Fri,  7 Jun 2024 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759036;
	bh=rn3s2RmxRTxbJSVhbZdiuz/L02U5NGxr5eXKw3dd/jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAlGygxt/5UT/TLCnemWs8OthpPmhH83tJBf3skKLcvb9c4BE5zfzBF0LAkvMkMqv
	 KsIe6cq8tDQtCCxdCEbcyXnCSS0uOZ3eo5fKrpONoDB6zsRpNTcHGZu5goMHI8iY3M
	 ihReNCHhOD/hEU80p0c5SC9ObZbBc9GeZ2p+H0tuYt+ZUZuwbo+BsX6hT2zhKHhhlt
	 IHH8R0g3cBnyRVWzTU3+jLHlORJABSE7uRZvOn/C0iP7FxLu8qDOOdx92z4rYWa71+
	 Oye59vKSoGL4Gc6LqC5RwPh95xOUaUudpJvrs5gNukjhKT4I17mMNyIV+rNkWxfyNS
	 +qVCuaALmJTdw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 07/14] x86/alternative: Convert alternative_call()
Date: Fri,  7 Jun 2024 13:16:54 +0200
Message-ID: <20240607111701.8366-8-bp@kernel.org>
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
 arch/x86/include/asm/alternative.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 6a746811c602..b6597574fa43 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -349,11 +349,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * suffix.
  */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
-
-#define n_alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile (N_ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
+	asm_inline volatile(N_ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
-- 
2.43.0



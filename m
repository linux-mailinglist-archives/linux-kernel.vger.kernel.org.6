Return-Path: <linux-kernel+bounces-287860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB268952D58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BCBB215E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77347DA87;
	Thu, 15 Aug 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1TUk1r0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876A7DA70
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720820; cv=none; b=m8EB1z4q0DL0Rnoght1nnhvIXQK3RXDIHBAYbFvjCDPqvgF8modhSNT3LRXp6ISLn/QW2cXPOISUukfYfRS1Ks6eNNxClgCR9zHMz80/eVb/jwBe6vUCzdKQwpoCgAydTLjK+y6ksb26mevHp5E0wCSxz/knJCBuBQ6EIj39swQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720820; c=relaxed/simple;
	bh=hIFrXWK0XdYxRiVPlyn4ixXpDHLCFlIFLA/+865LQ2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YZqS2Zc1ccK4lMVSuE/1sC9hYi4MCcuKUkt1vIerGdpj00LXOyC8qr6NlB+CFHVKCI+n+K4tsouZVrlJ0BZBe3JBvCvMQUT1WS4iberjo30oQScvZJRMG/lE5Uc0lh5HGn8EYZEn3fnM+z2rMt9phiji834bBEzaQINu4ZQdzwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r1TUk1r0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso233012f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723720817; x=1724325617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMp9NlJv/KqGuQrLAUvjlu1z67TgVJ49xEoYQUtzX1A=;
        b=r1TUk1r0yC8/YK1B+9+y1WTf9ZO7iXkSqlOEwth6vuqG/yXa5YlWhz1TqpYnbspf+M
         cYAIRoUTgNqVcoHZVb2apLbXEPhU2tvlXYpdI/nR6cVAmUI0DG55KKHFUbbSnPTTV4SE
         qmbcRS149qZEJ8Ds+XSoD83f7GTsEfE0cSWcO4hKyrlH2mawYJ0/kgQzeF/Wv80xnBcf
         /xt62l0nOksXAfxbkq/nMhGBNzNfuGADPcWXzbJby2FNQCMc50eavORMiD3wOMc4uAIV
         tcKaiKXW4Qg9inpgNLudB4GV0AJziUl2gA0Ln+L7sG75e/MvpTt9Ij3rFTdcW+tHJAC0
         eB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723720817; x=1724325617;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMp9NlJv/KqGuQrLAUvjlu1z67TgVJ49xEoYQUtzX1A=;
        b=KnUuXvVcfXrOPc/R8kCiAhm8n+iCr2wk85SMDsxzURjz7fAx2a1eqUCDozafqjvetx
         /Mw/98IDZ1LaPPjqBkS+iYdShcufRmC1mGgCyrKFumQaDB14ld6e5iFsPFz/dofnQ651
         NQMa7ibH0DpIwG4EACn+E6tGymJd0sy0DZVR2HPChzNW+e8PYJTPljIuvZ/YMrApykx3
         7cGZxk9oBrXWhRf12fDsugRoFIwYlfSa5y3RrrJgow01Eo5RdxJ7+zqIIjfqIEdHDsdL
         5ttz1YDWDaaFt+nyYq1FrRsBbLSH6V0J5VQ9naUs2x9l3Zv8QjSIn79c150ii6yqOj8F
         aGCg==
X-Forwarded-Encrypted: i=1; AJvYcCWbvRz5zigesxK01AB8ZduhpaGQ16mxKJW1uB+f1fFrC0cqQX7SrVAsTdTsZxRV8WJqF1AbFV5+BN/8cwFMI5xkP9eAWc9Sfcd9OGXz
X-Gm-Message-State: AOJu0YxwyTpz0zBbkU4LfN/YkTDv+6fTX1vxJDYhAHW4vxYlfTyIYJps
	vEs6OHvWXAA2eQq3gbQbw2rR3Q2t20dmcVQ38vI3UuhACkwdjXQMwu0LIVZjtgKTNMe186FhmyR
	3
X-Google-Smtp-Source: AGHT+IEUd95r2lX0qztYTlBsm265KC1oBRiSWufErk82u9C6kL44YcrfE0uhKwIok3zCaDBPYIDtWw==
X-Received: by 2002:a05:6000:1971:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-37177756a27mr4266586f8f.1.1723720816689;
        Thu, 15 Aug 2024 04:20:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849a05sm1249441f8f.26.2024.08.15.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:20:16 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:20:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	shwetar <shwetar@vayavyalabs.com>,
	Ruud Derwig <Ruud.Derwig@synopsys.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] crypto: spacc - Fix NULL vs IS_ERR() check in
 spacc_aead_fallback()
Message-ID: <469138c9-8faf-4a8d-b2fe-90d0718e2788@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c352e73-714a-476e-8e71-eef750f22902@stanley.mountain>

The crypto_alloc_aead() function doesn't return NULL pointers, it returns
error pointers.  Fix the error checking.

Fixes: 06af76b46c78 ("crypto: spacc - Add SPAcc aead support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/crypto/dwc-spacc/spacc_aead.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/dwc-spacc/spacc_aead.c b/drivers/crypto/dwc-spacc/spacc_aead.c
index 50ef9053fc4d..da9df329f9d4 100755
--- a/drivers/crypto/dwc-spacc/spacc_aead.c
+++ b/drivers/crypto/dwc-spacc/spacc_aead.c
@@ -784,9 +784,9 @@ static int spacc_aead_fallback(struct aead_request *req,
 	ctx->fb.aead = crypto_alloc_aead(aead_name, 0,
 					 CRYPTO_ALG_NEED_FALLBACK |
 					 CRYPTO_ALG_ASYNC);
-	if (!ctx->fb.aead) {
+	if (IS_ERR(ctx->fb.aead)) {
 		pr_err("Spacc aead fallback tfm is NULL!\n");
-		return -EINVAL;
+		return PTR_ERR(ctx->fb.aead);
 	}
 
 	subreq = aead_request_alloc(ctx->fb.aead, GFP_KERNEL);
-- 
2.43.0



Return-Path: <linux-kernel+bounces-287200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F54A95248A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB781F23EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CBD1C7B9B;
	Wed, 14 Aug 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYMT06+U"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C81C9DFD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669928; cv=none; b=e1w+Fq/4MmGDpYEVaQVNRty7tUjSPmlY9ChHLb2kudiLVZJ9nGpH90jPSJLmYlYTYpDpzF//dgoYTWoku1/9q7lpXMBxqzNW9PjL0f5wYcFjZZ322bV8kBgjfBGei7IyMNta85sLPfkdVNcw4BsHV1m4lSEYRTzd/V+rb8rHbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669928; c=relaxed/simple;
	bh=2GDAnPXDCO8WsPQJmInY0Nku6B4q2ax/ORM0Ijp/ysM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j7TmEjm0U+zj9+L3bv+r8U4Gb2tdhGLv2aL/TRm+xcnbIwr5bT9qbFzZ3h95fVGz1YTft+KdsvwB/nYZm0mEHgHyiuVENkRk5y17j32QXckqYkP4hqF215XbyBG30P11NNG0l73hCAbVXn2JC678HyBSSbuiAE5sqdPkGbiE1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XYMT06+U; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428178fc07eso1202605e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723669922; x=1724274722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wnecrCBfNMIqTbazGYk50cWogArEuWoUivR0Jks7i3o=;
        b=XYMT06+UGYlGN1lEb96xSOoSQqLDnN387B8X2EYAvcTNUkzJno082TZ6PMfosQRUoL
         l2vhewnEfHIT1TcP0K7uxD1poexJRAtNwRmKRCCqdObbFXmR6CaVO3G/lkkIyN642MTH
         IgCW1OgAPZq2iOoWOq+j2Qq+rQ9sqdECnrN5P8hpZByPCD8VPdz3OOvHyFLu8L2fjj8z
         6ILlOKHm5qyym8uaFjUC+0qXiPwG7LWt66GeB94mSc3zjYm4qJsOPklpymJaHuchKQVV
         3Bkfo2D6BVpU6yMKDvr0C3p2/PtNkHLiia7BpK9UrU1Ml9NZTbkxTsamK2FcDQppObLd
         xSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669922; x=1724274722;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnecrCBfNMIqTbazGYk50cWogArEuWoUivR0Jks7i3o=;
        b=kMtQUNSKmlhu67baGoDB8xLoQFDge2xa7ZQD62JFozJ6AcCrs+LBMwmvHPmdFfn8wR
         mcD43Rx74zs4MqY6bHMHwX2WVnPqSneXuG3yqqGfjj3rXnT/doc7p677Fa5mb1ptZtNy
         c1RDV+51Qpdovq070PPKNr4C3lOxsY0L6L/+X8hZkOEbaqr0G0Doqjc8OHo5RCyMInak
         28k5agmIXoKEZZavCgcxguIZpcdOok0OgcMcKn67suokIM8muio3gwhUQ/LFPO9fHZZF
         ZJyiwv2bir/vX1I+ZCJtPHAv5EBjZT716vyodHmteYi6ZjJMTZffz16awW2DIifnITw/
         29xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEzZkbcDZci/eJNL5qRqdByGNX6B+NIeFHiMPxyWrZq/kiA0mfbZkTXprrdC0aC3cqp5nvBWiNstqA6L+1FRg94OIt78Bv5GQiMyb+
X-Gm-Message-State: AOJu0Yxd3XPRqTfUFqRrAnEjtPrnwzuZhsZe6xfYPInI0aThP+VRuvUK
	FD70N1jATG/OiVtzth6Lo669ebF/PaBUetWhjaxKDo98no7bansYsPtCWE4UzZo=
X-Google-Smtp-Source: AGHT+IGT4QskXd6JH+wwlH+mb1PDuD4UMLNo4ckVVpaOKI5SBci3hdH8HmXXfH/EyMzKqk/UWE9jnw==
X-Received: by 2002:adf:ec52:0:b0:368:5e34:4b4b with SMTP id ffacd0b85a97d-37177768ef1mr2577439f8f.6.1723669921933;
        Wed, 14 Aug 2024 14:12:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849a05sm40860f8f.26.2024.08.14.14.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:12:01 -0700 (PDT)
Date: Thu, 15 Aug 2024 00:11:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Bhoomika K <bhoomikak@vayavyalabs.com>,
	Ruud Derwig <Ruud.Derwig@synopsys.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] crypto: spacc - Fix off by one in spacc_isenabled()
Message-ID: <6327d472-b4d5-4678-b54c-9808a68e3504@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c12622ca-923e-4aa5-993b-36cee7442ed2@stanley.mountain>

The spacc->config.modes[] array has CRYPTO_MODE_LAST number of elements
so this > comparison should be >= to prevent an out of bounds access.

Fixes: c8981d9230d8 ("crypto: spacc - Add SPAcc Skcipher support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The CRYPTO_MODE_LAST variable is poorly named.  Based on the name you
would expect it to be the last valid value but it's not.  (I'm not
a huge fan of code which uses the last valid value instead of the
size personally, but the names should match).

 drivers/crypto/dwc-spacc/spacc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/dwc-spacc/spacc_core.c b/drivers/crypto/dwc-spacc/spacc_core.c
index e3380528e82b..b7630f559973 100644
--- a/drivers/crypto/dwc-spacc/spacc_core.c
+++ b/drivers/crypto/dwc-spacc/spacc_core.c
@@ -1295,7 +1295,7 @@ int spacc_isenabled(struct spacc_device *spacc, int mode, int keysize)
 {
 	int x;
 
-	if (mode < 0 || mode > CRYPTO_MODE_LAST)
+	if (mode < 0 || mode >= CRYPTO_MODE_LAST)
 		return 0;
 
 	if (mode == CRYPTO_MODE_NULL    ||
-- 
2.43.0



Return-Path: <linux-kernel+bounces-527160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591BEA407F9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF7C19C25CA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980820B7F7;
	Sat, 22 Feb 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2s81Vs/"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706920ADC0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224350; cv=none; b=axiNU3eQJ8ldjl+ZfCRcTU1y7tecHLcELcFqnvJcJsi/UVgbgBUpHtNSsLG+KCJ3EfXyNfZIbCjtbpuwdsA8kcjWoQe1iVXCaAbK90LcHGYSqYf3hAXKig+HrasQfM5xAzpe8OA4vs7mXeBCULIHLZEM88L0zvZwHOyH7XMEI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224350; c=relaxed/simple;
	bh=xeg5lwI6l9nm70MC/C/1m/cmoxok9e9nkZsk3Cz9ITM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9DqeKd19e5Q3OXZGthN34mOu9wyaBZeDFy5rERJsxA3wHj1o3kz9ySCBvdnMNLbxTrMqQKRe1tQDwc57zv6suiUM4P1Blhjf5tN7di9caVpRaPDx7gC4M+lEu7/n7UmGlhmAjN20s+aBo26Icl5CkBQtTfI6Izxf1o7JjrqwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2s81Vs/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb4944fa73so42644766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224347; x=1740829147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9EcpsvlfdILzMAQp2/jsodVgf7CmKMPZrf0qtieAZk=;
        b=j2s81Vs/dARxGEHocxn/u1Oc97+GGBJWhLhxPUolPjhHLG7FwqM9DYSSzllIyu4ock
         hZ4ZZgBM0qcoCVgx6F5Qls8ut/l+16uPTCMrsBM/XVZRRdcVZwuGx87lOCZN1mGE6124
         xg3xaFM3MOUiStRcjDn77VzJswMnYQ2KuyzcfqPY/ZhB/tSWoyJhIaGdRF3X5DOLyvid
         WawpCOXcLovM6R5n3byrZG82WNCDJ0YRWgXUaxYMNFTYFDUybJfqAUNcWtg9SMv/ksUO
         BKIT9uKVq9Yr1zK5SeGqz5/xq+Vcp+ponOEu5U8Z2Wa2RBoaCCljFs7fy8Pxb5S9nMi3
         ucHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224347; x=1740829147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9EcpsvlfdILzMAQp2/jsodVgf7CmKMPZrf0qtieAZk=;
        b=VdQ8svuCdyo7XmfsoUqPjtMdbyir/u8RxheCpTFozfMVUTZqcCUdfDN3NlatMUvVZS
         c0Ige8ipMKHg6vEMYxwlXdj9+O26DI071rzK3SQyIu7a1O686dK5qDXHSlt973JGVcz3
         Pis46T8qI6tx27zT/2Vr7A/tuqxLBFBNYMCLUsITTm1nGcOR7pYy2qW2lXt0GQbgZahF
         Y+7xfh8YSLt/TX+2/0VzxJpm7/UnfrRqa9BUEYiNSLpz9spOzI5c0V15HWlrCzhS+j0+
         XZa3gFPnIrOfJ2OhAWrhIK+7CyHZ+ulLkdLG9Q8b9CzuuBDPpbanABpxzosPuYjMPgMC
         zkow==
X-Forwarded-Encrypted: i=1; AJvYcCWhYVZ7dv9ojQ4cSNZA5bO0w0M4p0ajGMKcvbklCEEehMEViN7IEj5u0K/XW/k061QmcTmvrNYeDAQKYT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIl22iZMMYFznaJqqDaTPYVmgRrjB/ytwlsGHv5R4aMvBaQGo
	yQdevCrsHaPj8Zs2F32eVDK+rkW+46rhCIc9BCCl7dKpzQDtZ1CrAnBDE+U5sR0=
X-Gm-Gg: ASbGncu4WygJYcgpkNpvbyoLb2PGB71Yf50M4pgr/+i1VMQCqXJ1H5dVGGlV7Y7MPkj
	+daS+k8bukkNxpPqcrzU2VyiobqWH0uuq8ZDy7TDLyJlmOcmzxr/Gabsgu8yC11qpJtzjWPPDWq
	CTfUpYvsgaveoAPwGRRh8vfDThzwJrtmJaSOAJGT3oN50sM61IcxtIKZ0vpX0dmTRE7ROoOOcTW
	rFIGbALW7XPaMNBxRgKukVdVC0aqCfPj5boGqNGo7OhjEu9fCS2vK/umxgsxaw1d6gjBTSnRj9L
	gP9VLevWXDS4NWcRtMCIvJF6zSvXQ+m+v6GCPJZHTLm+OB1MVi9TLg+Bx72Co+pAHVwxOBqtfLv
	C
X-Google-Smtp-Source: AGHT+IGE0bApSp7dpESrNQt49BwR4WA+qiKhIkXWSHbpkmvW4yQXqhCs1JVsFtKIeRDqIfBdSklEfg==
X-Received: by 2002:a17:907:2d8b:b0:ab6:db64:b040 with SMTP id a640c23a62f3a-abc09e5c67bmr270858866b.12.1740224347024;
        Sat, 22 Feb 2025 03:39:07 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9723a559sm1202702066b.96.2025.02.22.03.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:39:05 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 22 Feb 2025 12:38:58 +0100
Subject: [PATCH 2/3] coresight: tpda: Constify amba_id table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-coresight-const-arm-id-v1-2-69a377cd098b@linaro.org>
References: <20250222-coresight-const-arm-id-v1-0-69a377cd098b@linaro.org>
In-Reply-To: <20250222-coresight-const-arm-id-v1-0-69a377cd098b@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=910;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=xeg5lwI6l9nm70MC/C/1m/cmoxok9e9nkZsk3Cz9ITM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubdTnCMPcpy6c2h/pgiuP66+FVJGGwEqtA4gO
 wTNczwr0wGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m3UwAKCRDBN2bmhouD
 14ZGD/9qBAFceci9UnQuGsh2nJFoNvu/OliVMqj48SwI0tusP3wiJn7Sdyk7XzGzeDiZQm4q/Z0
 JrNWwa0v8qy+GPgQZ+/Qpu3yWA9hqOHl3RIG4/UUzDKui3OdO5Qh4OAXUELdPOXg9CFwGcFCtWJ
 EXkJdl3M9btre2yODtwbOhg+dvViv8+5tuTb1ye7m4g460S4Q9SnsdOPsi8oTgH6ri9/g3KKiQG
 DrSsyugTA6gYmBcAqEMl8EK64XZTAmr3M1JOj5msdA5lfgy40nzpi2Y6xlBJ9iqFhgQuSaS011J
 I1WyvTGa4P3k482/+Yi3BdRMWYbEyXDiddotc4BrAiN100k520LQm0chHWT3XtpNORGdD3xY3cM
 w9SWJzPwowHSQPx3mWwyX1EcCWUTA3XypkpTjZg/HSZSKmBzlhLYKpsa5Jd2+nC1Vrzcg9cCYSK
 6XzccWtHE02pvbWexV3BRhhDXsHmYcP+Uex4KP0+hwDnmwHY01/AI4uRIwyUPWC/85ecK6aBhW5
 LolTUMbxXnocBMil7RV0zAakeNCNsW+3QLgivv7/5JwIn6RmXIRHXK4Aq19NFkQlDqne+uDXsqM
 JrOL8Yp68oz/o7hxk+nbNU+USsPh+954RR8/zTBebVoN2tRWK3mS3+WqtF4UsNxu0Nq1p310MBZ
 TVLl6Zqv5iMuQzw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct amba_id' table is not modified so can be changed to const for
more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 189a4abc2561e3ec256c63f615112c2159360c86..573da8427428d430ab7f11398d1980193e21481f 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -331,7 +331,7 @@ static void tpda_remove(struct amba_device *adev)
  * Different TPDA has different periph id.
  * The difference is 0-7 bits' value. So ignore 0-7 bits.
  */
-static struct amba_id tpda_ids[] = {
+static const struct amba_id tpda_ids[] = {
 	{
 		.id     = 0x000f0f00,
 		.mask   = 0x000fff00,

-- 
2.43.0



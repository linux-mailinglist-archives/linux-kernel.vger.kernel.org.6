Return-Path: <linux-kernel+bounces-239224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF1925827
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8ECCB24131
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC77515B0F4;
	Wed,  3 Jul 2024 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byKV50H2"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C013A3F0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001776; cv=none; b=Es9XXmqFaLu5XxKlzjWCni+Re4omMj1vfw6Y6SX2UFcnPOG5kJDz4WJL8rR+XqpKAi7UHxxEY8Ps+AlC9PNXH0W4NO+xpgHmjh3nuEmY8aQwCOX5RbVwBCRdI3ChXDVJjheTS2CVmiaQaLUpzsnJGxjhYt+dg4VdZFd2bjSYMA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001776; c=relaxed/simple;
	bh=spgt4+9qxflitv4UZ9Bu05Oaf5uCcTTFwks7tVlyyyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U08ixQrO0uHf8FwpZF16/Xe15Pr65nR9zsA3UwfS0di25VHXQwH6WLKjCEIECVAcTKZgfzWjvBDYPJFi5SS0NoXXf2IF+HsQJHSv4tK60WiaEF6sL2o3YRpyyI3Rsky+mdDZEDoV8TCQiAA/xr1wiBqlAYWXWTD5N4pNSuFIPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=byKV50H2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a751ed17b1eso77759066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001773; x=1720606573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNI2ho20l/ka7Xx+ilkgiXagRPnJI8t8zqq0ZnfN4sg=;
        b=byKV50H2zkqmS/aCNK209fu0z9c8PlhfFFpYcQ1sEI6DV2PToAIV4g8VDupFD/Cw0F
         D5f4+J73mbpkA0mdn/JRuWClW/UMqzWYX/29oUSRoN31iTMJJl9cRgO/AbKRuOZ3qiAo
         tAbhYySsehHFu9Im8VjVuuEIczZEdjKH0+JSFopdg5CP74RxQ2V7kbHa0uJVVuq058I5
         mFwkmzsf4SEufXqIG7+snYut7Imm7kfXx6Yo2KaAdqXC7B3mVDGtIYgHEtDj9sdhdB78
         xbJc6+NhgdJhFjQZ0tieL2S28xqbHe99Wj/UgZO97iunv/gxo3AONm9Ih4+kXVEDunoA
         fImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001773; x=1720606573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNI2ho20l/ka7Xx+ilkgiXagRPnJI8t8zqq0ZnfN4sg=;
        b=Ck/CCpNyFwMSljB9GOq0XF61oWC80lz8MqG0aAc41m87WttxSUDGj9/6jhfdL9Opgz
         oXCIhc8OfL2XbKWFJ89pjeX0Uj6pAIbdeL4nvCMpsMJ1G6akVNCaftidN25Hw88kS6D/
         11NmTFXlM1pjTBZFYcS3MX5ijnx3djeIviDFqWU4mKiivEj88s3Aohp+tx6N0kwKPmHW
         bDNSpMmcVT1fHdL0SwH2kC9csLckpHHywQDvg3kKwn63N3qVe/51anyINQ7qU0LNzpzp
         Owi9vhux8kPIBkkdZxjErxWl9E0Zncjr9EG500TB3HYRdQu6dGPcfq3M21nFGR6JOZNu
         7GXw==
X-Forwarded-Encrypted: i=1; AJvYcCW1I8Ex7FdtvtSBwtqRLiVnNRDX1lEjq2LYQjg3kYMVyydK4GHdXboDS/FfV6wdkCZMY0+qcxKpVih2HjrxAWZFmLiHanJ6gAN+so+r
X-Gm-Message-State: AOJu0YwrWB/o7GcmIc8YKTpE4arimziGqtCq2rO2OfCCcR5nTWYiSZg8
	SiTZiSa8Cg5PF1ybPbQD4AUYKjcw3d4YYD8Tw2YKSTNE38VdwkOhHOyj2UWJyJ4=
X-Google-Smtp-Source: AGHT+IFwvHMeiG1PusuzlYb/BFpwlNvMyLpyqwyCsLc+99Ds2Xl5m1ldYJi49+/zg/u8Ua72v8fKPg==
X-Received: by 2002:a17:906:4755:b0:a6e:f869:d718 with SMTP id a640c23a62f3a-a77a244253fmr95689866b.21.1720001772744;
        Wed, 03 Jul 2024 03:16:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 12:15:53 +0200
Subject: [PATCH 1/9] soundwire: amd: simplify return path in hw_params
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-soundwire-cleanup-h-v1-1-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=spgt4+9qxflitv4UZ9Bu05Oaf5uCcTTFwks7tVlyyyk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhSTizydiWsNiK1lACRmuFWUvFUfjVVfPft6QQ
 GqZjW9cjMWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUk4gAKCRDBN2bmhouD
 1+OyEACYUGyGkiAqfA3VhOQNjJGbNBY3zshL3OR4Dp0zNhFrvG213/9aF09o5CoUJdjL9OVYlT8
 cULDGKCXWhkP7sj//ZtO64dP/cCN7IHWvboimzJjdyzFIRmOU0F8yPJLpWT+5H94tqeYscQXZbk
 hVZKYfKfY2UIDtdTU3fvoyve0UovB+45qay3vJoU++UFxKYkOG1dsDn7QrkCSfe8NQWs7SEO45B
 fp84f6O8pyMo/Ukj+yHj9r0y7LneFQsDHpGjBkq6dzYbnWKmc9CVzFXiuzBLL585b/PX7BQqr3u
 cD5tJDKSDoe4vF+JIN4JgMDoTKvw7Yud5ryMhjMN7EIhSVBkmLET0UIeOkwB//YGBRdev4rE8lV
 yHSuBZQF72sQfk/GOwl//j74lQbIjoGJbXz1JqaV9PXJWm34wz9saXzWcd8fddpmfo4eQk8gCwE
 7Ak8qXCX1cN8I23mA9Qm9aEV7WXzaNa3uou/yEyRMIeKIPjqsKslRBpYzViomKA2L2SzCA4FMgr
 bE6y04hLFzcFwlVJA5JtNirAuQMwiY5TZaCY62upQRXUPWa+YOAILvBCYA7AaL04W0dO4kDH9+4
 C8py4dpNKxikSvBMwPx0Isnori7dK3OWCOqjQp56TGnQYDbSuiy+rdNfJ2zqWBHl2T5PNWrPr/j
 54nNNwjTZSABXGA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Remove unused error path (label+goto) to make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/amd_manager.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 795e223f7e5c..4470fda83c5c 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -627,10 +627,8 @@ static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
 
 	/* Port configuration */
 	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
-	if (!pconfig) {
-		ret =  -ENOMEM;
-		goto error;
-	}
+	if (!pconfig)
+		return -ENOMEM;
 
 	pconfig->num = dai->id;
 	pconfig->ch_mask = (1 << ch) - 1;
@@ -640,7 +638,7 @@ static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
 		dev_err(amd_manager->dev, "add manager to stream failed:%d\n", ret);
 
 	kfree(pconfig);
-error:
+
 	return ret;
 }
 

-- 
2.43.0



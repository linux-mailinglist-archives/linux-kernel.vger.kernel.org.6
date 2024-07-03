Return-Path: <linux-kernel+bounces-239435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A77926051
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696D5B2E620
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1FD17B409;
	Wed,  3 Jul 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlUDUCNA"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E5178CE8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008679; cv=none; b=rzJeSaVadt63cY2G5eOo9AzoFYyp3wF8UDFBZH/e/YL799KCii7izpJE/N0kGrx7l4HZgEjneP/Av9Nx6cC80A8ZQjZ9SmS7WJlvVKlHHavIfrFbq5BSyG3qvMKivn8hHQNYbBeumSzGVy4GZtrFpruWHunupxEBAey3WjYEnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008679; c=relaxed/simple;
	bh=5n2U7Ii8u9qpjNSh5gTMMpFE3U1zzbLfE0z6dwMWgWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e8yWXxuvcSh1zlz6zu7cW5LIEftm0Qr+RWZAci1RDD6gQQKwrmwAZJnKjV0KHWX37xHPofBqXCGjo6dda9jiirD45w8LuAiMeTD3Zj2402A+sFscvCmWEeK2DHT22AAN4HgS0JvsvjoYep/F6cUwHdt8ffHu5fHAMFNrMmT8exU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YlUDUCNA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36786081ac8so906675f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720008676; x=1720613476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voPxYQD0gS+6s0oE8RPo9jZsqMZNTCeTe5vHHnILF0s=;
        b=YlUDUCNA5DW9JzmyxXROL5pYYoM5+FyfaJRxN+RdRaWzIzSI8O7UnyHgxcIkTwlvl0
         4Dvo8THa0eovczK4bWodvyf6/EYD/betLmWTR/8q2tWv5efpsJHtmPoTy8EV3YrKg6qr
         +4+w731Y4TJEejUd9Vu26WTWAHitTljqve8gyfzcg/pL+xvOqYyFFery/9Bx8BnRYhB1
         YwGJ99nVjq9Ca9go9BywHWlIu3iSz/rWrkf8CdZypsyFPrXglrtWtTSmRNnTCfNE9vQK
         vBlSwR5MLrC8/uAg5JPtfG9sltgTHK6aDQKJkNc2cTINS6JPQt8SUzUlp2K0M5d6O7ZS
         zdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008676; x=1720613476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voPxYQD0gS+6s0oE8RPo9jZsqMZNTCeTe5vHHnILF0s=;
        b=sIX22fVihkyz9A45kOo81PbcsXJJUNPlnQMVQbDS60AB3EG5ndl8EJAbl0oWm/YHrg
         C8cjYBySxt7ameAbr2aSy+RI2Pz2j9TeA/5SOXjiKT2jsc8kdDcBgyg+L/ZZKnCmjkwF
         mI5iTTJs4qFFbCd3eephQhOnnHxTlZ11wyuDXY34+noQgB1YULSge00jE2+BoE2qLjXd
         unTQkSg4rUtnMYYDKEQA0RGf6vZJVAG5CM5ivifcDGfRiOIG1i8K+p51MmYJ/VDWdijU
         gzSf+vlcuQUqo3TTPFPSnV8VpE4yjZKgHmql+9CSHtglIXkN3OiT0YNN6QMiBTC7L+cu
         /gDg==
X-Forwarded-Encrypted: i=1; AJvYcCVNpr4HjZU94BLoXrwivyks5sUOK5oVAtOMPnFbk+pB5ww7EMMSD8rMwbuHxZ48szDtQH8CRJGgJ34n3XF6dGTTZBRO2dKsNH/yiD6K
X-Gm-Message-State: AOJu0Yw6W50uhyxKqN2jIhpgeFFqcDrNNRnwElcE3xzOsEtN7+2lu5XR
	nXKqvfsgOzSJgC/HpxqfghE5LKQOBHIYsNz8QNkbAPiu9EwCc3pDwFAGKRx6y5JIrRWiYswSv9C
	46SI=
X-Google-Smtp-Source: AGHT+IHUpJv09c/tX0BJoWGcywOs1/igC2JtMah//K7mGQHmsYLuuC/hM6I4L59TczjXLvEdh4+MWg==
X-Received: by 2002:adf:fe88:0:b0:364:aafb:5fd7 with SMTP id ffacd0b85a97d-36775725e0bmr7848385f8f.45.1720008676185;
        Wed, 03 Jul 2024 05:11:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a10307bsm15716222f8f.94.2024.07.03.05.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:11:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 14:10:59 +0200
Subject: [PATCH 05/11] ASoC: simple-card-utils: Simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-asoc-cleanup-h-v1-5-71219dfd0aef@linaro.org>
References: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
In-Reply-To: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5n2U7Ii8u9qpjNSh5gTMMpFE3U1zzbLfE0z6dwMWgWY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhT/VpH4b1lQMWfJeGjQDjMJ4k7DARxOdBMzRK
 YzljfxO+aqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoU/1QAKCRDBN2bmhouD
 172hEACWQQu3Q5imqmfhy2Da+4TNTvqC5znQ4ArWh4RI66hNVDgTQHmyb+N0fxWIL3qrevl8eSr
 0AN3N1lmd6D7W5upGGqIks/nPJgFiEe7VqIhy13tVhA7ebEYCWp88sNtgOYg55zmOJh5E+Bsf5H
 DlSPHhaaDgKoFK6wwXe9XGHUMDnSuuortUIxpQeiKT7U1DKNHYHfeUsKuB1y1miIV0ZO2F+15Uw
 Ek5WblZNHEWX5C9PS9z6mW8epDNRqFh6wuCZNXx7UnVD7845z5wO6Kq6etIlVxVi2m3wzdPh2ED
 URWvk1er5OxmQgbjwYoZlZTHY5Na/xooBuKB9bywJATWbzltzlE1RHlcJJT4JsHMnd62Gf7/bGq
 Y1yeVYjgi2LV2ocil3//TPQItf1LRV/odPQ8BLUssFP3BLg1gfFLfZq+bZ/sb2wny8cLVE2Zm/T
 /xX4nd0/068uemcuJIOOrzOv6RFH5u71oP3Pw5WhhqPybcpXw/KhztBlBBNv79PtO5MOjH86s3E
 hVzSxSqHUtzRB0nvkkPw+Z/7uV0sovANZSF25ogEV8Yb92eQg+KNfeS5pbHryj2Lhzekufvp6wD
 5uEgE8Og4+VCN28mAw2TKrmk1fGO+0o8ETKvaYlPlWTUghUVwV0O0pu8xEnjXMiNB3MSf0ZwV7w
 rA74nq0PkFkfJyA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling (less
error paths) and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/generic/simple-card-utils.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index a18de86b3c88..fedae7f6f70c 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -5,6 +5,7 @@
 // Copyright (c) 2016 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 
 #include <dt-bindings/sound/audio-graph.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -135,8 +136,8 @@ EXPORT_SYMBOL_GPL(simple_util_parse_daifmt);
 int simple_util_parse_tdm_width_map(struct device *dev, struct device_node *np,
 				    struct simple_util_dai *dai)
 {
-	u32 *array_values, *p;
 	int n, i, ret;
+	u32 *p;
 
 	if (!of_property_read_bool(np, "dai-tdm-slot-width-map"))
 		return 0;
@@ -151,14 +152,15 @@ int simple_util_parse_tdm_width_map(struct device *dev, struct device_node *np,
 	if (!dai->tdm_width_map)
 		return -ENOMEM;
 
-	array_values = kcalloc(n, sizeof(*array_values), GFP_KERNEL);
+	u32 *array_values __free(kfree) = kcalloc(n, sizeof(*array_values),
+						  GFP_KERNEL);
 	if (!array_values)
 		return -ENOMEM;
 
 	ret = of_property_read_u32_array(np, "dai-tdm-slot-width-map", array_values, n);
 	if (ret < 0) {
 		dev_err(dev, "Could not read dai-tdm-slot-width-map: %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	p = array_values;
@@ -169,11 +171,8 @@ int simple_util_parse_tdm_width_map(struct device *dev, struct device_node *np,
 	}
 
 	dai->n_tdm_widths = i;
-	ret = 0;
-out:
-	kfree(array_values);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(simple_util_parse_tdm_width_map);
 

-- 
2.43.0



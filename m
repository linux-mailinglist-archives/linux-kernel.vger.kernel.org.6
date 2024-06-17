Return-Path: <linux-kernel+bounces-217348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F890AE95
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AFF2879ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366BE19068C;
	Mon, 17 Jun 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1Ioqe52"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20B19581F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629418; cv=none; b=QVKqEnK5kmg7rxvl9A53jjbl+ilGf7N27n/NI6f7WmrFkNPQ3AgSzA4o9k8WoOZaVI/jSbkCYCWt+Ha7sZfS2tZ/Tm7imbzPkXk8OlOTQ3ByGmG1TyOTgyLw/hYSgCayehruutgIy1NulEKbocI/L7BVdX9MnZQh6+IwboRJy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629418; c=relaxed/simple;
	bh=uc8wdHZiLzWn8eJSKz2w46aTnoymKmEOQTD+XqijcNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXWCed7CIvvDXBL1mJ6uL+ghb7L+UnZ6K4+tsu4rcX+SZHcS9VSTyXORlBN/09pn74wqsovnyKgAcYJMEa2KSBt52XEJTgU7p9oLv57kbavRycuYZhRO5qOXckHPU2pEEDpxOrXEbtsn+S3Rf1UD4OOsnpuXxSZugrGQ+PrPwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1Ioqe52; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so5133286a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718629415; x=1719234215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iu6ddlV0v3h5uXrvH+gS9VZsH+jfrjvNQ9t7e1CssRA=;
        b=O1Ioqe52bnzYtcZszyXClbU2qV2/7PUkTu5XuRM9sDMuWyBybCJXIxxJwqNhWejuN3
         lra3QuUp6eUivUsR6aygXGq7o5GYwixaz4uJteJkPGqmQr+LIMHVB5L/KDdUpwAFhD32
         5FG09v/hTx+NkR5yHYp+ffnY0ttqx+HXXnLeKel03h0QejZWqettS1VpZJyD8z2ObTPO
         bo4zKuND9firqsaOP6ac5Y4GxAIH4l10LysFMCV1n7FJb9SsuKOKA49r0cQ7OMXUAoYF
         1h4SlUuy9R1BFFGP+ILu0on2pq2TJKwtWvUddsGrGqNhFQwtyTuCHNWGrB7ojYn2qMsO
         aw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718629415; x=1719234215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iu6ddlV0v3h5uXrvH+gS9VZsH+jfrjvNQ9t7e1CssRA=;
        b=Mc4jbN8u7Hn6OnVeW6G4VVY2SEISOWgLmEXcU4qxWjwtPezlJoI6f8BqbuU4WYscxm
         OJuzs397z0XRutj2RJckCFCzQes85abbxm2P9Y6Sz4L1vFuoZQjLbbvg3HbH7ioBTAs4
         Z5+4eVfAMYcU7wUTsjVeistJKnCOFQt/DSV1wb2mfmFJSkDlzH+9TWGaLJYuurG+xMaR
         tURGHvlX1+2DQCc9Yr2G9lgjr9wXyDaXHMB0JhWgFPhGqa2LSK6l8XWUYjsPAQHK9z6a
         MBevEKlTR+LvYCnK5jj5ez88CEGfsdbeN5zI+F00mfkvQBEXMjhHNX0UYcjDSEEs85jJ
         a+zw==
X-Forwarded-Encrypted: i=1; AJvYcCUbPxkwVg3XAhO/oiKdItA6BrFAzlVy07gna+VFPpHRTJJ4FXtza2hZ/P2I7+7j/J+gMAkDVoUkpd1nGLt8EGZHK6RRIv1FKTU2r5zh
X-Gm-Message-State: AOJu0Yxbga3QZton9Gs5c9xYswbvQJHJLipU5IY/ADrVqi22o8tvR+Ab
	DChLkAdcMtfbScj3K8F77nrzElpvue0VW1LAX3ZYWKpZPUqo+CZDito14wZIZcU=
X-Google-Smtp-Source: AGHT+IHUNni8AOLm/9P2UblMUUEc9IpqI2ijdEam/5ZmmPsfGDtdOofoplS92A83e6uVXMfUnxfkog==
X-Received: by 2002:a50:cc88:0:b0:57c:6a71:e62e with SMTP id 4fb4d7f45d1cf-57cbd67f3cemr6395349a12.23.1718629415088;
        Mon, 17 Jun 2024 06:03:35 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72daa67sm6404349a12.38.2024.06.17.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:03:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 17 Jun 2024 15:03:19 +0200
Subject: [PATCH 1/6] ASoC: Constify of_phandle_args in snd_soc_dai_driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-n-asoc-const-auto-selectable-formats-v1-1-8004f346ee38@linaro.org>
References: <20240617-n-asoc-const-auto-selectable-formats-v1-0-8004f346ee38@linaro.org>
In-Reply-To: <20240617-n-asoc-const-auto-selectable-formats-v1-0-8004f346ee38@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Cezary Rojewski <cezary.rojewski@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uc8wdHZiLzWn8eJSKz2w46aTnoymKmEOQTD+XqijcNc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmcDQfFrlQ7abVRm3aNe8Kkl9L6AnbPjX6Y+7s7
 DYZjCHDS7iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnA0HwAKCRDBN2bmhouD
 10OYEACBZaQnC3nQIQco5nBJ8EikBNDkW/UcZU1og4FTRcbp49NVM6dFadb/k3/UZiat/5ZpaEq
 zsS2SII+bSFc0pkj1KCS2/ExC1+YCJ8MQdraBAWAOjH+oLOzomr5AoJi0EHVUnwna4KAkDmOqJ6
 sZJlvKBFT5RO7JARzHJcQF5PbYZqNHdhjylzgGpMpbU004tward7+b8CIIIxfZQ0CEgRlZNYDxq
 GrxNQNuGYku2ZCEVD19+BVieHkWapsKKBb/i4VLf3ubPG4ajioK4HW/LOpCWazXHWf8fQUkm+wG
 oN4fspmO64ts3Z/UMSj8MC9d9Gp2gV2Vh7pwPk60392PqJAhckFIxFSb7jSA23axzglAaL2POiu
 +0nVAPDeMRMDusjP+eC4YTWgz2vOlGNOCEOzhsK5ZWHiLhdLGthsPQPGrDc7Vappth96fI+XBmI
 Y3weq2AWK7tLyDaeqoVF8eVJXL79LNq1JKnhDthxIeoCZ/3uZz5uU3bTrMLh113Kmpt33DO3t44
 fSt6jsKQ2uMJEYxDJiRH1fQACXqQUpeM1ItArx6Cwc4SPje6WIiRbmPOReOyLrgtss1x5/LnrXJ
 3gpAibBpSPjAg9thRJuMKNw9M+RfdYyQN6axgpnAZvd0cZjwE5xavkzExTwqawMW12HMJTPXVJb
 cxilbMW0MQ12miA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ASoC core code does not modify contents of 'of_phandle_args' in 'struct
snd_soc_dai_driver', so the pointer can be made as a pointer to const.
This makes code safer, serves as clear annotation of core's intentions
and allows putting pointed structures in rodata (if ever applicable).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/sound/soc-dai.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 279223c4ef5e..8b2ae7b71965 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -413,7 +413,7 @@ struct snd_soc_dai_driver {
 	unsigned int id;
 	unsigned int base;
 	struct snd_soc_dobj dobj;
-	struct of_phandle_args *dai_args;
+	const struct of_phandle_args *dai_args;
 
 	/* ops */
 	const struct snd_soc_dai_ops *ops;

-- 
2.43.0



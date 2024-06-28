Return-Path: <linux-kernel+bounces-233740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8B091BC6C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2182C285101
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2001586F2;
	Fri, 28 Jun 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXSR1QbT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59015688E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569501; cv=none; b=o5oNBhewarZvpek0ukDv43IXI8e71DE/tEx0+uQn/iR7DA6LnZJyNt1TUzyiFH2CaodXDf+auqPZZ8al/lVaPsrZH1APnGxK3D51BYCMNwyd/NHZPKWsEbdUcBtotntqpceGTOeNrdpGw6C79QSQQ/iuymsmfpOddhYi1mdXQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569501; c=relaxed/simple;
	bh=mHTTaZNpcGoV/mUxNlKDTFQQYgAom9YHnI/rebyFS7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HY3ySppByoEB1P572EapRBbnO+wRSp3ls7r8VLEUdyKHni0+uHWcPFYVqXCwD+1qTsmh0xq8N1ZgxPbrZ9CIt2D59CHCMcJJcO3SvE5jvZLrg9ON1gP6wiVljLILFIPIxiEjfF9DmR10mSZ1bTRpaKg8tAN/sep18tjjNhLmWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXSR1QbT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so3833415e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719569497; x=1720174297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkhZEX+m4yRFERQhljwkeNudJNH97Tx+yLOdy4DNmag=;
        b=NXSR1QbTx2wlSPfo42CZ6/xhYmxKsCO4ksMqsghRVXdX6XwIREUcpQJxiQJvxfsuwN
         fjP7btc+g+ZF4oeNG2rc+sAU7LFDhlyFerA8dkIaHZqlMm1wm3zJ7CpG9Rm0IGulZvoa
         22Wz8GyLfIN7jh6N84PAzh2H1F9OUImQRrbnyaN7mVcLt6V7ncxYGBu5yz/N95PbKio7
         J1uvx4qif3WRbwe3Qln3rW50Yk454QM5xbVA7/zkaX/MJBxzZf5pLBrhnYRB3NCmAetx
         yyNRTOCW0q016pu6XOmOzwYSFnsMZXM/SMU616hhlsu+mBEjlIIUx3FfxnOBdNjf3+6u
         oiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719569497; x=1720174297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkhZEX+m4yRFERQhljwkeNudJNH97Tx+yLOdy4DNmag=;
        b=KH96tkCo8bfXs8YNOjD72pjAvYc1YMDhE9XQkPKa7N5b38zD+mG0p7jgv2iOdD7RH5
         5SOknROxBy/8OhCQ8BotixheuVMhPqb/CqNYshh1jKpnnQEIVfrTsh4Cm4RocV/PW3ZI
         HoPLMcTFXPGeYh0hqz4PT5qEldPFdweu1RJli4QQ+Sjd17aJ59vVXj8VCKXwurzmZJoA
         BTTcBbE8xVG8F4t6cvFlqtQhCDQT6ZR5+LWDxftqu0bPDNwcV4RCHaNvCFs9bUCw1o3+
         3OUY21fIlY+ZUs4hirrgW8stPpYpokyJHAj+wcOexTpF0nrA4RqigqA3OW+OGx/rNLJA
         2vpA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ahdJEwr7GTjhITHyULa7BCNNQhgmNwe23Psa40kd2gX8dOaQIlmTZ60M+D/IGjpvLMxx7ncUJ8tHI+DMcNII15FTX7rKdBfRa31v
X-Gm-Message-State: AOJu0YxhFjTLQwNRHcmUysMVJdh6vcbs/sVYz4EkKxAvRDYgZOlA+/2+
	a9NCq+2+fn9v1pwTFnqsuIMz4w3UJ5NWtYqarm3URnlcb7fdDw7dUXlBvWL89uQ=
X-Google-Smtp-Source: AGHT+IFZAKYRP0ELHRLqVkzPXiFVn5Ahxi3UScj47Vi/DSByvBMN7t47V/esD9G6nGISyat/slInbA==
X-Received: by 2002:a05:600c:5819:b0:421:5966:ca40 with SMTP id 5b1f17b1804b1-4248cc2a7c5mr108666635e9.10.1719569497596;
        Fri, 28 Jun 2024 03:11:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c15f8sm27024605e9.47.2024.06.28.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:11:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 28 Jun 2024 12:10:59 +0200
Subject: [PATCH v2 5/5] ASoC: codecs: lpass-wsa-macro: Simplify with
 cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-5-e9741143e485@linaro.org>
References: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
In-Reply-To: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3389;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=mHTTaZNpcGoV/mUxNlKDTFQQYgAom9YHnI/rebyFS7Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfoxByjErZrFpA2io6CZmKX5eVHl0S31rLIcwQ
 2f2VwflwMOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn6MQQAKCRDBN2bmhouD
 18JEEACLa57k2Kdt04/TAWG2YVD7j2medFXWR35HQqZq7tCGbwlbGgmOIKAkK7gTKhV0C29W70s
 K4EUklMzCu1T1sfEXj6loRtyiBuF8ECRNzkDmUSRosn79fMoSb0O5AjiFEREM/x+kTZB8dhE5P8
 eGSW7/ZSPR6xwngg/6MXkoYvAkoUhygozoe+s28L9kOdaHGyWL+P+dR1vt68dR4xieRaD4ODGE3
 AACvLmKGSDKw9nnyo+d+2+KMPX9rmgZTPXFLA4WAS1X+C5i6ZK5MkDI2SyGs18M9Mhn/beLJ8+2
 +RmSuGfpAiaeD3el/FM1sIQPLbPE96AcoxHB9SwtogsJF9HvO7+PkiRGhtDmOk+G84pgt9NGwgA
 9/Tyo5wZffwXH3UmzTC5VylYGtZ30lcZDR/K4Ls/iLMZowfqF2UtAIbEKj6t3ds3SYLZ5TNxYT/
 vxetsm0/b8K/2eKgcsmN4RRQYCFmSUYv42sy/Aa0KhPMltTdaPfJmcPZI8DcEo27ihzMdM8i8fG
 SbtIZf5DlMSMQMKqSkLMu/1PqlIOlHNMyhIpHJJ+5WbOfWiFdL9TZ8SAYwjR/5hwIs0U4PVE2JO
 BO4yzz6ETyhEimP5i9EWWrxI0n5JPxufOWDo2CKnk9XoLTyFXCUVAfQtUOFXBKrLDa3PAQMhqN9
 fC8hCTxQmqvjJaA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver's probe() has two allocations which are needed only within the
probe() itself - for devm_regmap_init_mmio().

Usage of devm interface is a bit misleading here, because these can be
freed right after each scope finishes.

This makes the code a bit more obvious and self documenting.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 sound/soc/codecs/lpass-wsa-macro.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index b4e7139bac61..73a588289408 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -2725,8 +2726,6 @@ static const struct snd_soc_component_driver wsa_macro_component_drv = {
 static int wsa_macro_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct reg_default *reg_defaults;
-	struct regmap_config *reg_config;
 	struct wsa_macro *wsa;
 	kernel_ulong_t flags;
 	void __iomem *base;
@@ -2765,6 +2764,8 @@ static int wsa_macro_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	wsa->codec_version = lpass_macro_get_codec_version();
+	struct reg_default *reg_defaults __free(kfree) = NULL;
+
 	switch (wsa->codec_version) {
 	case LPASS_CODEC_VERSION_1_0:
 	case LPASS_CODEC_VERSION_1_1:
@@ -2773,9 +2774,8 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	case LPASS_CODEC_VERSION_2_1:
 		wsa->reg_layout = &wsa_codec_v2_1;
 		def_count = ARRAY_SIZE(wsa_defaults) + ARRAY_SIZE(wsa_defaults_v2_1);
-		reg_defaults = devm_kmalloc_array(dev, def_count,
-						  sizeof(*reg_defaults),
-						  GFP_KERNEL);
+		reg_defaults = kmalloc_array(def_count, sizeof(*reg_defaults),
+					     GFP_KERNEL);
 		if (!reg_defaults)
 			return -ENOMEM;
 		memcpy(&reg_defaults[0], wsa_defaults, sizeof(wsa_defaults));
@@ -2789,9 +2789,8 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	case LPASS_CODEC_VERSION_2_8:
 		wsa->reg_layout = &wsa_codec_v2_5;
 		def_count = ARRAY_SIZE(wsa_defaults) + ARRAY_SIZE(wsa_defaults_v2_5);
-		reg_defaults = devm_kmalloc_array(dev, def_count,
-						  sizeof(*reg_defaults),
-						  GFP_KERNEL);
+		reg_defaults = kmalloc_array(def_count, sizeof(*reg_defaults),
+					     GFP_KERNEL);
 		if (!reg_defaults)
 			return -ENOMEM;
 		memcpy(&reg_defaults[0], wsa_defaults, sizeof(wsa_defaults));
@@ -2804,8 +2803,9 @@ static int wsa_macro_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	reg_config = devm_kmemdup(dev, &wsa_regmap_config,
-				  sizeof(*reg_config), GFP_KERNEL);
+	struct regmap_config *reg_config __free(kfree) = kmemdup(&wsa_regmap_config,
+								 sizeof(*reg_config),
+								 GFP_KERNEL);
 	if (!reg_config)
 		return -ENOMEM;
 
@@ -2816,8 +2816,6 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(wsa->regmap))
 		return PTR_ERR(wsa->regmap);
 
-	devm_kfree(dev, reg_config);
-	devm_kfree(dev, reg_defaults);
 	dev_set_drvdata(dev, wsa);
 
 	wsa->dev = dev;

-- 
2.43.0



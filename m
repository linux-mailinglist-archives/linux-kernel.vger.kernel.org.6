Return-Path: <linux-kernel+bounces-538655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F80DA49B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D311899A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2CD27781B;
	Fri, 28 Feb 2025 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fq2IaRUD"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8E270052
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751656; cv=none; b=gj7Md2POVHoorKhnBGJ/u6pm7bMmjlFz9aSD6VrqlWBk8ZDJJyEuxEwvCSsQRehk58fb+hDdQ/mYpfDmWMfyDOiv83RM0OpSlKl+gD6ZCIF5BltRmIC931HwqULZJUiTGAEdyIXbYZ0PJYDXiQApW7Xdx8z0flkcUuhbNwb75sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751656; c=relaxed/simple;
	bh=K1YnffI9DtkL7cIsY9hYSQnQd4r9QfJylkyPV44F0aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhLhFv5iGQio6ydixTU7Yay67x6aIW5/HcHCe6/qGEVlq9qbKmZBmy+wHTxNjM4Y7l8RuNkHcFdIi+BjfPNFoQOjn+YUSuv69ufcwQGEeyYZ7gGx9NZF0odaZJlYTLSw4dn9ytirW9BdXdH4qXKpZMqb9tk/w4jNKFaz+akxHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fq2IaRUD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so3851942a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751652; x=1741356452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1wrjOZ25AMEbbC5RG2Bl34Xp7n5uiu5eMlW7fz5kxo=;
        b=Fq2IaRUDGGTVcTdoqKq/uXNxxWjhVn03scZGsguKU9PU6Q0wr0ayInn7XtBuXM8lz4
         yDkx/GrB1E4zpJkmJXPxTgADPUi5N0GR/WdHsCpVJM+GzTJOY/eL2r8fFFvzp4IVCXlS
         ilpuIWd51quE/qXKrptdngdnQPZcI67eQkrlACdOCfLL22RD4zwvcC3rMIG039pnSXSD
         TIPhWmUu87i2MWzhQyi+QSEfxCXj9SKHRV5AEsOQ+ATzphTuDs7TayRYZQvCm5OQ0NcR
         M60dpxpwomQe/KYzOgrQBkAvWFeLd7KhDN2FICurQFrenTeayj9ihCvSdrvfzM7MUSk6
         ABIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751652; x=1741356452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1wrjOZ25AMEbbC5RG2Bl34Xp7n5uiu5eMlW7fz5kxo=;
        b=Zf5YNci274uHzJkqyU9JsHKtdWPSsXMviBiC/8DQQ5IDdFp9rdTjFZckBMNhImaniY
         jNNaujHX5tJl5Ba5yQKOLJcVJZ9o/cQUS2q7d3/NM9g9Da7vyCNkMJthu+3fbtM7ZDLs
         EhdnYBNipz3Sjs+hSXZiu/kVCWTQWYnBywRQP/WPm51KWeiIgctvwpq7ix/ANHiUi2IU
         EGTg6sdEw1yAUgHrEyd4v0Hd5AFcpQGAtpGF41cqUZlcbSkOAjWKVt91A76j5R2XTZQ3
         vGcrT7WcmdvuQAoxXoefoak4qCoXxZVMiP/f0VTIULw9GlQGNCi5d/P+bsLxvkeXkmoi
         47vQ==
X-Gm-Message-State: AOJu0YxgNqM//V4i1QV36kKVmlPfa1mgAGFB7HgVjSS3QzdbtIb3fqgv
	Cn6qeOivENZKesWOK4QmYHhdVzYbX+ih4qHMoHHLNtW9L9Y+tZB/Qk57Pl6zLxk=
X-Gm-Gg: ASbGncuR+XWRafSvsedGHoWykiP3Luw5nvCHkTaU01dy7O/AcHwFiHqTstFSuJs4bTx
	bYoiFb1eRuiu1V2eTPr7x34/UmFtjqREVl7Qoe2/KPPvMxbxe0C8U3VeQU+sBZJPF3wg9VQPS93
	XZKo5TR7Icl/AoQzo4FaE6BMcUMhU/uc+l9sGDB8WdPVWTVKMxOqHsVi8Yfwmd03Z0R+w1vL7hm
	YyoNv+kkR2VA6vxukxX49tiLnUV6OrGz89miIR1HvzxB+89wdoC3YVM/z/ZLLZSzH2uoDXcIAFp
	TxKtUbHs6g6VysyFFWKUn4PT4xBpqiavvsZuBKzt0XtxRrdDBOEFnHg/p67nP3T8Rf41QbR6wbs
	25X4qwtisdg==
X-Google-Smtp-Source: AGHT+IH8oBqlrNujitdioxAVXjdPgLAryRZxpXTnrztyLFYptlh+GD/CB4rbFiDA0RhEFxZK1lBu3A==
X-Received: by 2002:a05:6402:35c6:b0:5dc:c943:7b6 with SMTP id 4fb4d7f45d1cf-5e4d6ad4a6amr2900190a12.3.1740751651952;
        Fri, 28 Feb 2025 06:07:31 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:31 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:30 +0000
Subject: [PATCH 17/18] rtc: max77686: use dev_err_probe() where appropriate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-rtc-cleanups-v1-17-b44cec078481@linaro.org>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
In-Reply-To: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

dev_err_probe() exists to simplify code and harmonise error messages,
there's no reason not to use it here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-max77686.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 6b0d02b44c8097453f704cbec9f02580fb869ca3..69ea3ce75b5a5426d4a56b979773be71c4ee7562 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -704,10 +704,9 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 	}
 
 	info->regmap = dev_get_regmap(parent, NULL);
-	if (!info->regmap) {
-		dev_err(info->dev, "Failed to get rtc regmap\n");
-		return -ENODEV;
-	}
+	if (!info->regmap)
+		return dev_err_probe(info->dev, -ENODEV,
+				     "Failed to get rtc regmap\n");
 
 	if (info->drv_data->rtc_i2c_addr == MAX77686_INVALID_I2C_ADDR) {
 		info->rtc_regmap = info->regmap;
@@ -716,28 +715,24 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 
 	client = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
 					   info->drv_data->rtc_i2c_addr);
-	if (IS_ERR(client)) {
-		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
-		return PTR_ERR(client);
-	}
+	if (IS_ERR(client))
+		return dev_err_probe(info->dev, PTR_ERR(client),
+				     "Failed to allocate I2C device for RTC\n");
 
 	info->rtc_regmap = devm_regmap_init_i2c(client,
 						info->drv_data->regmap_config);
-	if (IS_ERR(info->rtc_regmap)) {
-		ret = PTR_ERR(info->rtc_regmap);
-		dev_err(info->dev, "Failed to allocate RTC regmap: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(info->rtc_regmap))
+		return dev_err_probe(info->dev, PTR_ERR(info->rtc_regmap),
+				     "Failed to allocate RTC regmap\n");
 
 add_rtc_irq:
 	ret = regmap_add_irq_chip(info->rtc_regmap, info->rtc_irq,
 				  IRQF_ONESHOT | IRQF_SHARED,
 				  0, info->drv_data->rtc_irq_chip,
 				  &info->rtc_irq_data);
-	if (ret < 0) {
-		dev_err(info->dev, "Failed to add RTC irq chip: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(info->dev, ret,
+				     "Failed to add RTC irq chip\n");
 
 	return 0;
 }

-- 
2.48.1.711.g2feabab25a-goog



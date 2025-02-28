Return-Path: <linux-kernel+bounces-538638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FFAA49B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C827A403E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A126E65D;
	Fri, 28 Feb 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i03efqjn"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E526BDB4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751646; cv=none; b=cc+I3R9kaSv9kRwm9sYtEzms4QW20m70pk+PLb3z80lFHYS26a/DewltyHSLgFxhzhTz6u0FVpsbVFaYsYA+X+nKi9PnQdehmGWPv5JGO3Svsjr3PJ4+vercWxDD23OoMWAlgQPXDx4HjlcqwSguXmQ0xaKnzyOtrioQQ3b8pPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751646; c=relaxed/simple;
	bh=o6iUQpkX2kREXBtqHVFBYq4KM/Ol+6TBK8alsSBDLFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3FN4smbJ/LYSRc18LvH4l9pAIGybVV92jEMiu787OE2FvYsGBk4xgr/CkPZjjBxtb4ITyluma+jY/eOCpU7q3CcvVANobk0Ci+SqNolnKfpG2DAnUYPOgoMk6haUx1DBVigjJLmgUGxU2+kaunwNaUwBWuxJYy1kUNrOAeqY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i03efqjn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso3239609a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751643; x=1741356443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxV5ubkQILRDTTOOiWiVBaTKuCWcjZ1klG/odToLNLU=;
        b=i03efqjnlFkObHW1ztwNuqWMePtLs/sq4dmV85pqjRtrRv/6u5zjc3+7LF9N6rvm3D
         VgUAuMNZCVN2aFvXztpaWFFP6KTLbP292+FHSHhqP8+lbYjhzwIVbSTznR1jePgTeQf3
         Xxv3R/EoiFGazGdfUiQXPOq0KgQi7g6izTyHExGklTWZBRp2GjxYsuYqjKIVpz6KU0jg
         FAk+qFERo+crftlurfpxbBl/JRZqV5Uabocq71zI7Cb2v0M0bUQEHeDAXjmgW8h+/nNU
         m4kdI1wUlFu64hozU2n29hXURoDUgiVuiisr9Nnt5mdj7Et3JhuyXmsjFzFhCbDmcD1Y
         bsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751643; x=1741356443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxV5ubkQILRDTTOOiWiVBaTKuCWcjZ1klG/odToLNLU=;
        b=SHH8Nz2xdFroLMfWNPDusPndz2rxr96pVBc1jCD8n0t1mmQdnaeow9njATBY9cxWUI
         VfLHXlKIknKRABDuhGtRN0Ljc8I+OQwETVHritNGJuk6MeQfV49q4ob16xoU19BWKPLk
         G+EGPDJ6JsVc1pw7PDwwolVBch+niwoWsSGeXfsJ0w6K3AT0ESjemLCY0lLcav7Abbxn
         6RW9eiNGfHaeZNLdsugOFo/GQ9GSio7I/dOgjPwnjutCw7uNd5eOpoSo4AdR4tKvgPyd
         ukBQolLO9fCPODHaXpBtItPou9PMriybSsx1X1Duq/eENCQpGRnUSeUWp7EJu7iyF9Nn
         ATkQ==
X-Gm-Message-State: AOJu0YwlbG5HuY+zu5wMXFTppV1R37/02cXrlFtQRRFI5Q8jmD5X3COL
	kCFP8C49LqnzB5XQ6x/WRt/F+nKWTU+8x2MbXtMsnjxjXR4Lon8v8K4SN+B12O4=
X-Gm-Gg: ASbGncuRDc2dnAHIhkXJiHV5WQn5jQI8Dy559+pFjG/Z/Vo6uemllSrSmjnuAYgOfrN
	lez0gSkvC82kuS6aOSXICpWDhJm9xh9xl23frPI0GhHxm2cwvhM2VGm70Szp9xZ6kGUXkAfJ9aM
	uTPaxkmzgEN7HVfAgH3FKZq/95g9js/amfjzsZce8YuZZ4U+jjZV2A1livGxMe0wWJOnWZi/6k2
	o8ufm8baqjQuY/xUX+dEmO3p/ev+bM9dtUCn7vjJtC9vPAvRLkvnneUgdS4ERw3Zt9VbTCHiltT
	RYS3cp26QPpG7S79kL6e91io+C7kmaPa6iAiXTxSf7cP8ILGPztyG+6X5EwwtjepxpgAessUBZH
	5KonnYNbIkw==
X-Google-Smtp-Source: AGHT+IFUL7DUuq/VqTU9dmynPShF+8aK2RXF+k+UR0pl4bWqZxWvS8VoSsjq66EWlcydyD7uTG7tww==
X-Received: by 2002:a05:6402:1d4d:b0:5dc:796f:fc86 with SMTP id 4fb4d7f45d1cf-5e4d6af436amr7325207a12.16.1740751642551;
        Fri, 28 Feb 2025 06:07:22 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:21 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:14 +0000
Subject: [PATCH 01/18] rtc: max77686: drop needless struct
 max77686_rtc_info::rtc member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-rtc-cleanups-v1-1-b44cec078481@linaro.org>
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

When this driver was converted to using the devres managed i2c device
in commit 59a7f24fceb3 ("rtc: max77686: convert to
devm_i2c_new_dummy_device()"), struct max77686_rtc_info::rtc became
essentially unused.

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-max77686.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7bb044d2ac25aeaaf2404b47b7e7bd485ae3d39e..6b0d02b44c8097453f704cbec9f02580fb869ca3 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -85,7 +85,6 @@ struct max77686_rtc_driver_data {
 
 struct max77686_rtc_info {
 	struct device		*dev;
-	struct i2c_client	*rtc;
 	struct rtc_device	*rtc_dev;
 	struct mutex		lock;
 
@@ -691,6 +690,7 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 {
 	struct device *parent = info->dev->parent;
 	struct i2c_client *parent_i2c = to_i2c_client(parent);
+	struct i2c_client *client;
 	int ret;
 
 	if (info->drv_data->rtc_irq_from_platform) {
@@ -714,14 +714,14 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		goto add_rtc_irq;
 	}
 
-	info->rtc = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
-					      info->drv_data->rtc_i2c_addr);
-	if (IS_ERR(info->rtc)) {
+	client = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
+					   info->drv_data->rtc_i2c_addr);
+	if (IS_ERR(client)) {
 		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
-		return PTR_ERR(info->rtc);
+		return PTR_ERR(client);
 	}
 
-	info->rtc_regmap = devm_regmap_init_i2c(info->rtc,
+	info->rtc_regmap = devm_regmap_init_i2c(client,
 						info->drv_data->regmap_config);
 	if (IS_ERR(info->rtc_regmap)) {
 		ret = PTR_ERR(info->rtc_regmap);

-- 
2.48.1.711.g2feabab25a-goog



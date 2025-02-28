Return-Path: <linux-kernel+bounces-538640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF180A49B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3B8174942
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26ED26E970;
	Fri, 28 Feb 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWSYZCEa"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5126D5AD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751646; cv=none; b=kEXF7VQFnf8nPw+I/L00ojia9znGoXgSI0eErDlvlS7jdxI3dTLnFFW2MupLkbH6c56oSqtxO+LpYnL6/l1hsKRRCMFH4paGu4jP0EjHqwXZf3882LhSbnZoVSyIGHwtMeBhZxuAOw9/CLyQ53F+KrytC0oSPy6o3KWrQ238Jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751646; c=relaxed/simple;
	bh=YYl9m2BnndcCMYaFzMLWUSCBfr0DlXeXEgFndcdua9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVkO5OmiXqelxVUezxm5HmZ16DGrRyQnzt/vTe8LT+YdGexdZx/tRuHrLNkudMI0Ka0CRXt8GpKj/wGAyXIiviQ5SBMVyFPCZVpmvVo1NeI4FtOvc9ozrHQp4OOqXUKv9gzWuKdYBRf8lWmTvsPb41eIn4e9vIl/OXztCHGtZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWSYZCEa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so2923100a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751643; x=1741356443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEusmS+5iWAG1jDnjFt/eyKJ89b8w4e+6UytiCX0MQA=;
        b=FWSYZCEadyU8vj+pOdi9pSaK3qhDb0DI4SvuPVtjfjAN5lOFDiPpEUdNMZ2yKCrCRn
         XCsoPymSJT6/1KXGy7qXM9YpN+9bX0BkcbuJawYWUjvDgdkf1V9mn/OpD8JcQiEX1dzh
         l9BMqalRG+AtTZFpjLKPCs6AmJsJfVZ62z+eyXcgzuSRGmEnRHdPP2eeDVgvOvZr3xMy
         wfdCsQHPpVt3oH6b8rXf6rqiE5YaM61GS3TCBDeDFFySy7l2Fa+mq3GQuEmdIg7vPoMZ
         EZ4sb7BzTtmF4AwmWcoUZ9F3GvQYPMVuhD/QOxy63cMX2iSmfIRnDVy4iHop7gFfmDQC
         E+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751643; x=1741356443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEusmS+5iWAG1jDnjFt/eyKJ89b8w4e+6UytiCX0MQA=;
        b=hFQD4k/DqmalTmsL386TCvawxFdZepB3qvL3JquebQ+yoP39dPp90Y2T257XLmhRbL
         cb0oe3CMXNdq4Yaws4QWb7VWrsSxPDZMFRtLGORTgtJRitp6Vp4g+YOl3nbyk5EwdB2b
         4XJkzNArDvgVP29moIXRsz476CV3u8u7zzuBwv2KVBSWoN9CJyjcxIgA2cfJ2VCmgjUi
         /OBO1YqgZogi1NenFaG3Li5fAcW2qBUquOqh4nw3JWTDJaJo/14vgfEnGSMt5VaIQYOa
         o2Aj01avc38MglZ6mSw/5W9/6NFrNAsttdbtgdQX6ZnXy2/cldMw9wU2yri6cpc0fb+j
         xQfg==
X-Gm-Message-State: AOJu0YxgCu0agPADMLXu1A1yxrc+sUErpIDjIHZCw9fYp+zuM1kScsHR
	4eZYToWGYQS1DNrjRwGMEYjN5tnNHvv9NCkZ1wp1iBcN4CA3zvA0JX1dUJp18U0=
X-Gm-Gg: ASbGncuvK7SDj6Y10Bsazia0/4MH7pY33porRgSDkHhLWJkGLowsvMohuScTxf6A9bC
	5ZuppMJAgBPOp6R9jZcxWrJeHIRP5jj1xW13jlJOkeGJdLVl9PMaOJhxgkTZq84XuoG51D2lJxe
	GXlf8RA+Zgx7N9obqSaq94HhLZAFAGr9F40bmt01qB3g2XpfvT1PTpx3s0nSdf1FbOc8ozkAFYO
	QZ3FyK8XBZbHaJR4BLnSWKGvlXdIvRPvJlwok/uncQZ53MKbg4yBIJrtj7hqz0Am4jZOsknsQgj
	upfwLuvMXQb2CXj5qqjq901TFhljkB7WrW85e2iFRh+uN7RDNQxaBWPHg5xDfOTd2i9VzFuOKTL
	zgp1FsCngYQ==
X-Google-Smtp-Source: AGHT+IHzPJx5i3RI7O2yaVdHtPJ0az692A2jfkouiK94jhHcaAYqi/2J0zpg5aMdk74cXIZT8BcCug==
X-Received: by 2002:a05:6402:42cb:b0:5d9:a54:f8b4 with SMTP id 4fb4d7f45d1cf-5e4d6af0565mr2697422a12.11.1740751643440;
        Fri, 28 Feb 2025 06:07:23 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:22 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:15 +0000
Subject: [PATCH 02/18] rtc: s5m: drop needless struct s5m_rtc_info::i2c
 member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-rtc-cleanups-v1-2-b44cec078481@linaro.org>
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
in commit 7db7ad0817fe ("rtc: s5m: use devm_i2c_new_dummy_device()"),
struct s5m_rtc_info::i2c became essentially unused.

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-s5m.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 36acca5b2639e272dd9baed06ea5582f635702b0..77dd61c30681b8f0a2f23063ad5f7eb52f5b7158 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -146,7 +146,6 @@ static const struct s5m_rtc_reg_config s2mps15_rtc_regs = {
 
 struct s5m_rtc_info {
 	struct device *dev;
-	struct i2c_client *i2c;
 	struct sec_pmic_dev *s5m87xx;
 	struct regmap *regmap;
 	struct rtc_device *rtc_dev;
@@ -640,6 +639,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 {
 	struct sec_pmic_dev *s5m87xx = dev_get_drvdata(pdev->dev.parent);
 	struct s5m_rtc_info *info;
+	struct i2c_client *i2c;
 	const struct regmap_config *regmap_cfg;
 	int ret, alarm_irq;
 
@@ -675,14 +675,14 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info->i2c = devm_i2c_new_dummy_device(&pdev->dev, s5m87xx->i2c->adapter,
-					      RTC_I2C_ADDR);
-	if (IS_ERR(info->i2c)) {
+	i2c = devm_i2c_new_dummy_device(&pdev->dev, i2c->adapter,
+					RTC_I2C_ADDR);
+	if (IS_ERR(i2c)) {
 		dev_err(&pdev->dev, "Failed to allocate I2C for RTC\n");
-		return PTR_ERR(info->i2c);
+		return PTR_ERR(i2c);
 	}
 
-	info->regmap = devm_regmap_init_i2c(info->i2c, regmap_cfg);
+	info->regmap = devm_regmap_init_i2c(i2c, regmap_cfg);
 	if (IS_ERR(info->regmap)) {
 		ret = PTR_ERR(info->regmap);
 		dev_err(&pdev->dev, "Failed to allocate RTC register map: %d\n",

-- 
2.48.1.711.g2feabab25a-goog



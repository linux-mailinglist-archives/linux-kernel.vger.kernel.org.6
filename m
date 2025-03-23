Return-Path: <linux-kernel+bounces-573036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2342A6D225
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A151895AAC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CFC1F8671;
	Sun, 23 Mar 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d29kBB7C"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B301E9917
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769584; cv=none; b=kqnG2lU6wuli7SufP7DpcpKOe7mqeYTr11YpcrEdTb9mCrS1gR8wu2KZSkpIR/McFzSOO3523NAuOfY+dsgZW5VeEz81CMJCe+2hs1W5Wv11/goBEuog4LhpDibdviTCP6ZmCiWXvoHaJNx8/duZRR1RNzEAn11mWlfCNAkXbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769584; c=relaxed/simple;
	bh=fW8fGdBIj01Ce5nYKYOtr5RzqfYdqbt2xVnIKMnonN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5qIcVJs3tXaOXWsVEV2jUmE3HMnGXQZ8L5ldsIa1Mxj/XmIX99Vkd9nH7g+xdX+jWEHtUOngw5mXy9tDF5s5mGoy38sXwgg/kJzKmOqUVxlvSZD5sszNI8F2QpovX5mvSOZBreQJnGswq6kCdJWw2r23e4eJyMcR27exU6+Ut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d29kBB7C; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso588943266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769575; x=1743374375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66I6A9BwKPx78r+x2ze+D3BdpB1AaTqz42y1bAQYxGU=;
        b=d29kBB7CUsXeKyp2ri3yZaOZ/ombMpQc5JXyAyIdzCvPla2rksYIx2WUPRSDvTeX6g
         4FOpBEVwQ8I/DXrh6dkih3Ln4hvzKzaUUZy6ODpe/sJxVptogR5MS7Ct58NnKiFOlyze
         DXmb1qarJ29lSMNrptogUsvB9nBHUfyiga7xQQ+Ovj12sCs+bRme5fpI8RHT+i+Dnt+R
         fSG1fKK7t/bPR2i6ZNM9AXJoAbKM5LY8jxBI9B5jQyKJndIq8wAV5cvuetvD9na5+TCi
         yaMz70Y6ghIcdBCUMLDaoeMMTbRPTZJuZ2RYUUHn/mNGsslg+4u+kY5xZoV6hZd2x4I9
         +iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769575; x=1743374375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66I6A9BwKPx78r+x2ze+D3BdpB1AaTqz42y1bAQYxGU=;
        b=h4jmt0IYsLsEvPGBLhJzn0G6p2nhu/UFles8Y8VCVHNRY7zOjlRvAP9Rv12W1fEaDZ
         ebrSnshMgFy4vPEVOG2TsZGVXk2+tVnc76OS2bY8EchmeEw/K6I/JExgfhcbFJI9+fYj
         dK8OD1ED9uMQw1YJrlJnG3U4FHVCUWIK0CZPyl2PhSCncGPnZAQuTQ06TZgsN0Du0v6l
         lDj7MghkCLOV4V8InM56+6zoS7bzhNtJPKxv1LLfcaD8v95u8UhGNpaO/1gqA0cEOYmV
         K1IxRdi2/now79HXGuaDtXWkd8QnXAkCa8UFsrwZi4NVNtA8Y7ptgW4hu0ohswwIpwbT
         Saog==
X-Forwarded-Encrypted: i=1; AJvYcCUhKokSOVDAE4LtGS25+ZfiyFCf6bYHN8tBT0G90gvSggs26ocBQx9fHtuHgrBTp8W06NCm6LXRwjUeKjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXcWnms1Y6eENSI0lr6BheVSemt0RqNq/CeYco43ml88dzrgd
	dal/4dUVEadGhcyO8YvYIIXv4FSGc8aEKcQq5J0DTVNMd2ZwpMCV9OFxhsVtmiA=
X-Gm-Gg: ASbGnctBMy/LNx639cIU4lekXVjRfR7aommA4eoGNttBy6O8Gb364iIjw26KYSBQ5W0
	1xZhKEH7fT+OJO8jD0GX8DB2PRlZ7i2rz7ZmOhw5XO5TEC22c4g6XIv9AsAlmjlORMa2WccVQWw
	7lNKgURKpfuTOpD+XSy7sSm4WOCz7Kc3N8JKN3M/MbHH5N21ZC7XCTNRVhuMJQxcOyzLkVG2mEe
	f7fuByUbAayHs746XJ538GZ9sBVd4tcoJ0m5SjzExc9rXGSVrZMeTaEJ4VBafydvQOJYtioZNBk
	qBp3S6rIkKtMPT5v8hgkg/AXUmn6V9wsL9LgOkF+4dS2vr0p/9C1nCwkGL85EMGAJ4ymnCqjD7W
	F/wCzf5ArWctALu9QnA1cdX5DHVmL
X-Google-Smtp-Source: AGHT+IFOl2n2dt4259UO9Y2Hc/nB/vtxXxb3XEltGi4hCBG4hgPGKnJT2FEY0IZG076qDEvYKYdc8w==
X-Received: by 2002:a17:907:7f0c:b0:ac3:c4a9:7f89 with SMTP id a640c23a62f3a-ac3f251f2a0mr846621366b.54.1742769575429;
        Sun, 23 Mar 2025 15:39:35 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:35 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:36 +0000
Subject: [PATCH 20/34] mfd: sec: rework platform data and regmap
 instantiating
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-20-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Instead of a large open-coded switch statement, just add both regmap
config and device type to the OF match data. This allows us to have all
related information in one place, and avoids a long switch() statement.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-i2c.c | 137 +++++++++++++++++++++++++-------------------------
 1 file changed, 68 insertions(+), 69 deletions(-)

diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
index 1bdd6ea36fcd9f56ea5ec1159a87723f4c09a0bd..9f33d4569cf73461c57d101f6ca1cf2b75f22b4d 100644
--- a/drivers/mfd/sec-i2c.c
+++ b/drivers/mfd/sec-i2c.c
@@ -20,11 +20,16 @@
 #include <linux/mfd/samsung/s5m8767.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include "sec-core.h"
 
+struct sec_pmic_i2c_platform_data {
+	const struct regmap_config *regmap_cfg;
+	unsigned long device_type;
+};
+
 static bool s2mpa01_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -153,55 +158,23 @@ sec_pmic_i2c_parse_dt_pdata(struct device *dev,
 
 static int sec_pmic_i2c_probe(struct i2c_client *client)
 {
+	const struct sec_pmic_i2c_platform_data *pdata;
 	struct sec_pmic_probe_data probedata;
-	const struct regmap_config *regmap;
-	unsigned long device_type;
 	struct regmap *regmap_pmic;
 
-	sec_pmic_i2c_parse_dt_pdata(&client->dev, &probedata);
-
-	device_type = (unsigned long)of_device_get_match_data(&client->dev);
-
-	switch (device_type) {
-	case S2DOS05:
-		regmap = &s2dos05_regmap_config;
-		break;
-	case S2MPA01:
-		regmap = &s2mpa01_regmap_config;
-		break;
-	case S2MPS11X:
-		regmap = &s2mps11_regmap_config;
-		break;
-	case S2MPS13X:
-		regmap = &s2mps13_regmap_config;
-		break;
-	case S2MPS14X:
-		regmap = &s2mps14_regmap_config;
-		break;
-	case S2MPS15X:
-		regmap = &s2mps15_regmap_config;
-		break;
-	case S2MPU02:
-		regmap = &s2mpu02_regmap_config;
-		break;
-	case S2MPU05:
-		regmap = &s2mpu05_regmap_config;
-		break;
-	case S5M8767X:
-		regmap = &s5m8767_regmap_config;
-		break;
-	default:
+	pdata = device_get_match_data(&client->dev);
+	if (!pdata)
 		return dev_err_probe(&client->dev, -ENODEV,
-				     "Unsupported device type %lu\n",
-				     device_type);
-	}
+				     "Unsupported device type\n");
 
-	regmap_pmic = devm_regmap_init_i2c(client, regmap);
+	sec_pmic_i2c_parse_dt_pdata(&client->dev, &probedata);
+
+	regmap_pmic = devm_regmap_init_i2c(client, pdata->regmap_cfg);
 	if (IS_ERR(regmap_pmic))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap_pmic),
 				     "regmap init failed\n");
 
-	return sec_pmic_probe(&client->dev, device_type, client->irq,
+	return sec_pmic_probe(&client->dev, pdata->device_type, client->irq,
 			      regmap_pmic, &probedata, client);
 }
 
@@ -210,35 +183,61 @@ static void sec_pmic_i2c_shutdown(struct i2c_client *i2c)
 	sec_pmic_shutdown(&i2c->dev);
 }
 
+static const struct sec_pmic_i2c_platform_data s2dos05_data = {
+	.regmap_cfg = &s2dos05_regmap_config,
+	.device_type = S2DOS05
+};
+
+static const struct sec_pmic_i2c_platform_data s2mpa01_data = {
+	.regmap_cfg = &s2mpa01_regmap_config,
+	.device_type = S2MPA01,
+};
+
+static const struct sec_pmic_i2c_platform_data s2mps11_data = {
+	.regmap_cfg = &s2mps11_regmap_config,
+	.device_type = S2MPS11X,
+};
+
+static const struct sec_pmic_i2c_platform_data s2mps13_data = {
+	.regmap_cfg = &s2mps13_regmap_config,
+	.device_type = S2MPS13X,
+};
+
+static const struct sec_pmic_i2c_platform_data s2mps14_data = {
+	.regmap_cfg = &s2mps14_regmap_config,
+	.device_type = S2MPS14X,
+};
+
+static const struct sec_pmic_i2c_platform_data s2mps15_data = {
+	.regmap_cfg = &s2mps15_regmap_config,
+	.device_type = S2MPS15X,
+};
+
+static const struct sec_pmic_i2c_platform_data s2mpu02_data = {
+	.regmap_cfg = &s2mpu02_regmap_config,
+	.device_type = S2MPU02,
+};
+
+static const struct sec_pmic_i2c_platform_data s2mpu05_data = {
+	.regmap_cfg = &s2mpu05_regmap_config,
+	.device_type = S2MPU05,
+};
+
+static const struct sec_pmic_i2c_platform_data s5m8767_data = {
+	.regmap_cfg = &s5m8767_regmap_config,
+	.device_type = S5M8767X,
+};
+
 static const struct of_device_id sec_pmic_i2c_of_match[] = {
-	{
-		.compatible = "samsung,s2dos05",
-		.data = (void *)S2DOS05,
-	}, {
-		.compatible = "samsung,s2mpa01-pmic",
-		.data = (void *)S2MPA01,
-	}, {
-		.compatible = "samsung,s2mps11-pmic",
-		.data = (void *)S2MPS11X,
-	}, {
-		.compatible = "samsung,s2mps13-pmic",
-		.data = (void *)S2MPS13X,
-	}, {
-		.compatible = "samsung,s2mps14-pmic",
-		.data = (void *)S2MPS14X,
-	}, {
-		.compatible = "samsung,s2mps15-pmic",
-		.data = (void *)S2MPS15X,
-	}, {
-		.compatible = "samsung,s2mpu02-pmic",
-		.data = (void *)S2MPU02,
-	}, {
-		.compatible = "samsung,s2mpu05-pmic",
-		.data = (void *)S2MPU05,
-	}, {
-		.compatible = "samsung,s5m8767-pmic",
-		.data = (void *)S5M8767X,
-	},
+	{ .compatible = "samsung,s2dos05", .data = &s2dos05_data, },
+	{ .compatible = "samsung,s2mpa01-pmic", .data = &s2mpa01_data, },
+	{ .compatible = "samsung,s2mps11-pmic", .data = &s2mps11_data, },
+	{ .compatible = "samsung,s2mps13-pmic", .data = &s2mps13_data, },
+	{ .compatible = "samsung,s2mps14-pmic", .data = &s2mps15_data, },
+	{ .compatible = "samsung,s2mps15-pmic", .data = &s2mps15_data, },
+	{ .compatible = "samsung,s2mpu02-pmic", .data = &s2mpu02_data, },
+	{ .compatible = "samsung,s2mpu05-pmic", .data = &s2mpu05_data, },
+	{ .compatible = "samsung,s5m8767-pmic", .data = &s5m8767_data, },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sec_pmic_i2c_of_match);

-- 
2.49.0.395.g12beb8f557-goog



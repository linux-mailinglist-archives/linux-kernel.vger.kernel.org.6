Return-Path: <linux-kernel+bounces-181205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FFB8C78FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A181F215CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79B14D6FC;
	Thu, 16 May 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p0S5dnGS"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C114BFA5
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872133; cv=none; b=HU7ReLi9pFBzRJl6hqwuwzl8DFxlUk3FnOONcJ0jWJs5tmBLkpi83yrl8cBxR5i63j2kEMwoms5jWmJKL80XChpk+R1Gfg+dHaK7+Yn+2GCrt4rXE5gqGkdc5FMHNuaB7NoOSem1Or3bH3rTexCFYrYk0aTQ4VBN0jM5Ol4i+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872133; c=relaxed/simple;
	bh=GPIkBbQj4IQYkRBMApjzbDefFG1cRgF3e6hKKqXUa84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPWjOWs9rbOn65lW4AarW8HRYZb+koblPkamAnvSvOGs3SjgBfew2SY1Rlni16RIojCVq3FbUAcX+jQw1XEl1pj+6ihNHl23Lm2RHJWkbZZxxGWNLvftApVWdqmHCcbiXOSM0KoQKc/E/nRgZ8UecbCT8etO07l8KqtWkeV/wzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p0S5dnGS; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db17e8767cso12510971fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715872130; x=1716476930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zlq2XgSsulaEdUEoiNJy3+0ETTvrLEFhmOVX/TPKWFg=;
        b=p0S5dnGSdMKtvt45zX7xJfOn2ceBCsFzGZqPG3stB6jWb7rrlM+4+rxT7DlKbC6+sF
         Ze2uXr2DDZ8TzsgSxICYc0pwUU6CVokQnzW1APxdBYqRIzLG69wsDyud92ge1BRoi4VU
         HsXXOMd80A8csNv3JU4mNIHyqx2ep6uCAvbcqLzja1N6iOYkx/dhbKsSePcxXFmXQWW2
         UyS10NhCMqXFtfjfxTlCzg+nCHV2Ly/SW/W6pL2KpiN8NDP/+XNAKzkPgwxT1Ua7KdXE
         f2TdCKVTGuPxMnOHsr+KjiMVysnLnPkC+TFeig89Cprqivn0JwMSdgxGjPrBTABQjQO5
         A6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872130; x=1716476930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zlq2XgSsulaEdUEoiNJy3+0ETTvrLEFhmOVX/TPKWFg=;
        b=geE9X2PpTksApN60kNhAwmH9bBB+82mB3rajE0Iwm4z8jZVu+d5PwVjbUZ/LmtDigh
         xWxVbEo9W52iTctyFkf/liepHnmzcaO+6s/iRIl+zdwHaIdo3PqxpyObpDLM2wZT4t/E
         ESmSINeBFrAoP6r8TnTQFSESibf1LpWjev/6unLAv1PAlR8s9RMIN80rgRqBO1AKeX8X
         MKZo0zwZ/KLgDceMWIi+dorD/osKvWzwbNtyArQbVV8K8Tx4l6xSKVLYBJJIShZb+Y9W
         e7jp0o1RsaHIk0aMch/DtShDgo1Zq4You5LTfSdJqnCvdMtz3Lb7O3vZqPPQcVOkDLaZ
         /nYg==
X-Forwarded-Encrypted: i=1; AJvYcCWIHe3nFBsrcEAg+RVYxCYj5mEcjPtxYdzb+T+mGQW00HuhPCsurNeDYpWgQ8l5/ngeGGTo5xW+XUQDvGw8aYsFVD2/DChH8GkHkqZh
X-Gm-Message-State: AOJu0Yzv/wTeQOffdPz/rzchntUYFbrZKEJLGE841vAMWn1ldyTQzEfn
	6sl7O0Plg+7I1xrcgWhxZ7huO7jTBFbwjuS9wWncNDkm5lKLN4uAhliJlmvUQ8E=
X-Google-Smtp-Source: AGHT+IHr28udNSRatyT+2G5LNG1+hGVEMFrX9RhYuqKy2yHAm390/4kDGgRKQKwjLoGX9pVtnsJ34g==
X-Received: by 2002:a2e:5112:0:b0:2e6:d2bc:1d18 with SMTP id 38308e7fff4ca-2e6d2bc24e5mr52015521fa.22.1715872129966;
        Thu, 16 May 2024 08:08:49 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1fce:7e5a:e201:edd5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm309351725e9.18.2024.05.16.08.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:08:49 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [RFC PATCH 3/9] reset: amlogic: split the device and platform probe
Date: Thu, 16 May 2024 17:08:33 +0200
Message-ID: <20240516150842.705844-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516150842.705844-1-jbrunet@baylibre.com>
References: <20240516150842.705844-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

To prepare the addition of the auxiliary device support, split
the device probe from the probe of the platform device.

The device probe will be common to both the platform and auxiliary
driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 55 +++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 59126c9f194a..fec55321b52b 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -87,6 +87,27 @@ static const struct reset_control_ops meson_reset_ops = {
 	.deassert	= meson_reset_deassert,
 };
 
+static int meson_reset_probe(struct device *dev, struct regmap *map,
+			     const struct meson_reset_param *param)
+{
+	unsigned int stride = regmap_get_reg_stride(map);
+	struct meson_reset *data;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->param = param;
+	data->map = map;
+	data->rcdev.owner = dev->driver->owner;
+	data->rcdev.nr_resets = param->reg_count * BITS_PER_BYTE
+		* stride;
+	data->rcdev.ops = &meson_reset_ops;
+	data->rcdev.of_node = dev->of_node;
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+
 static const struct meson_reset_param meson8b_param = {
 	.reg_count	= 8,
 	.reset_offset	= 0x0,
@@ -125,46 +146,38 @@ static const struct regmap_config regmap_config = {
 	.reg_stride = 4,
 };
 
-static int meson_reset_probe(struct platform_device *pdev)
+static int meson_reset_pltf_probe(struct platform_device *pdev)
 {
+
+	const struct meson_reset_param *param;
 	struct device *dev = &pdev->dev;
-	struct meson_reset *data;
+	struct regmap *map;
 	void __iomem *base;
 
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	data->param = of_device_get_match_data(dev);
-	if (!data->param)
+	param = of_device_get_match_data(dev);
+	if (!param)
 		return -ENODEV;
 
-	data->map = devm_regmap_init_mmio(dev, base, &regmap_config);
-	if (IS_ERR(data->map))
-		return dev_err_probe(dev, PTR_ERR(data->map),
+	map = devm_regmap_init_mmio(dev, base, &regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
 				     "can't init regmap mmio region\n");
 
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
-		* regmap_config.reg_stride;
-	data->rcdev.ops = &meson_reset_ops;
-	data->rcdev.of_node = dev->of_node;
-
-	return devm_reset_controller_register(dev, &data->rcdev);
+	return meson_reset_probe(dev, map, param);
 }
 
-static struct platform_driver meson_reset_driver = {
-	.probe	= meson_reset_probe,
+static struct platform_driver meson_reset_pltf_driver = {
+	.probe	= meson_reset_pltf_probe,
 	.driver = {
 		.name		= "meson_reset",
 		.of_match_table	= meson_reset_dt_ids,
 	},
 };
-module_platform_driver(meson_reset_driver);
+module_platform_driver(meson_reset_pltf_driver);
 
 MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
-- 
2.43.0



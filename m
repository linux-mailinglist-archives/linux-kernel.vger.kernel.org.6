Return-Path: <linux-kernel+bounces-256241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F21934B57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381C1B2359D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545FC12E1D6;
	Thu, 18 Jul 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JAp1nfl/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993686126
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296689; cv=none; b=YltiGw5kSIIVSj6HJi7iwMf2HuCajZvvZBw7izxEQEcz5x/yRag+7f0IaY987gEhPY4V52lQsUJ9/8DWXC3TPdGcmL8upYIgKFwGpsOvFUWKiK6pNphwC7SVQ/ykjfl+Ln/0haLLyqfSHLo5QJt2XX1LtrkCOT4U26TiF2L5PL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296689; c=relaxed/simple;
	bh=cxaqUoQ9aguHyFdmx85j2AoRbVwkuszVVEgKQCGMEX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4Qcl0S8eEaP/vGlikHPnc/zZnSpcMJ+RqQNPzQpzIb9+O41aDdc/gQ0F8ivHKlyoH6wEpQdNfcTB3qdQYRhU7mx3wGIHO5McQIUJAoe7QsmPMZHXFfj3GZpLjbRkV8ndH+fYuIEfLgYQcnpEmOzz8hfVNO4yuhjTpKGtjpgZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JAp1nfl/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-368380828d6so420422f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721296684; x=1721901484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f/3bReYMesF4TJq9BOi7hv3PG6ArjPAwHRzmWrlWAw=;
        b=JAp1nfl/mUpnT3GSrT+5Dc8Y0mNb84sLVaWAmDyW8veLLmLKy9Qihv0oyqKOM6SvmU
         YfWCtHUvb+LC7H3tMN7Urxfl5DWHdl6PHwGZV5zwMUP6JR97UYJBDZ1xFn+84pw2BXcu
         AXGPpJzk/0dV3EgA3uxMnyzafslm8HNbkGo/xcz4MNPGM0U8//j+N4QlK1dqcTK1RGlB
         asz5R3eajummhQQfwLfgNB3CctDFEIwQ9IwRmzkkgqMNsZwGBFOsXXQWQcTmPqUTw84d
         kpLtbWXavKuuEMT2tYTODUA26ENtO3kz6B3J/6AQ4gc6REF63y0nQ7V1XR3YVC4I7OEd
         NU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296684; x=1721901484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+f/3bReYMesF4TJq9BOi7hv3PG6ArjPAwHRzmWrlWAw=;
        b=mJVou3SHYbbY0uMRigxXbS3GKj9SUi1jCgQhUyNC5A7zZUa0+43sRbJsQ/yuVrnerO
         b1DCgkmEOtnRUo1UZUBo/LZesXCM4helh+XBZBEDZS1LPlLayOibogGSGP06aOULhHL8
         K46wmYP0QY8lmxC/4lW+GUR/SH28bpYeZwieotyelKZvHUbbfWNHap5SiKcjxR7YQK+9
         MSIyfwbdd0y5od3o92WXDya4tDRZeQ1u3VUQ+epXwBa/IdBUnOy0FzxZeKqryCL+JCB6
         soC6mnNC9SA8DYzFbK6BuXa4CgifO3hnUVHxd1o8Z5iI21uPixOcx1hE7a6OkpI23yxp
         TpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBLt+YSGWrwFpVYpar1Ff5c/zvBdZekvRcHH0NqkeqeScH4HkgCaa4CeMSBSmnFsKUqOiy41F7edkD2jVJEb15k9qgFeKUQ6hfGSAw
X-Gm-Message-State: AOJu0YwHFvWeYhlGCKtOt8zsxHlIBKw9GCROtNBNETcwjjrmXcdqJksg
	VCm1dIEfCEjcip5SGEZNfc45wseXEd1pcYUfsKlH9vqsgzKeDk/MkwWGcurfeAs=
X-Google-Smtp-Source: AGHT+IF2wpylHtE0GsGjeKwrPISupVDdqlSWSz7Bc5nyMlVO3EB3+GjMC7UpkG8hkKpJnSbvcphnrQ==
X-Received: by 2002:a5d:540d:0:b0:367:9803:bfe7 with SMTP id ffacd0b85a97d-3683171fe16mr2596315f8f.53.1721296684185;
        Thu, 18 Jul 2024 02:58:04 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8d37:f44a:c212:e320])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3680dab3be3sm13837155f8f.24.2024.07.18.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 02:58:03 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 1/9] reset: amlogic: convert driver to regmap
Date: Thu, 18 Jul 2024 11:57:45 +0200
Message-ID: <20240718095755.3511992-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718095755.3511992-1-jbrunet@baylibre.com>
References: <20240718095755.3511992-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

To allow using the same driver for the main reset controller and the
auxiliary ones embedded in the clock controllers, convert the
the Amlogic reset driver to regmap.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 80 ++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index f78be97898bc..8f3d6e9df235 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -11,36 +11,44 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#define BITS_PER_REG	32
-
 struct meson_reset_param {
 	int reg_count;
 	int level_offset;
 };
 
 struct meson_reset {
-	void __iomem *reg_base;
 	const struct meson_reset_param *param;
 	struct reset_controller_dev rcdev;
-	spinlock_t lock;
+	struct regmap *map;
 };
 
+static void meson_reset_offset_and_bit(struct meson_reset *data,
+				       unsigned long id,
+				       unsigned int *offset,
+				       unsigned int *bit)
+{
+	unsigned int stride = regmap_get_reg_stride(data->map);
+
+	*offset = (id / (stride * BITS_PER_BYTE)) * stride;
+	*bit = id % (stride * BITS_PER_BYTE);
+}
+
 static int meson_reset_reset(struct reset_controller_dev *rcdev,
-			      unsigned long id)
+			     unsigned long id)
 {
 	struct meson_reset *data =
 		container_of(rcdev, struct meson_reset, rcdev);
-	unsigned int bank = id / BITS_PER_REG;
-	unsigned int offset = id % BITS_PER_REG;
-	void __iomem *reg_addr = data->reg_base + (bank << 2);
+	unsigned int offset, bit;
 
-	writel(BIT(offset), reg_addr);
+	meson_reset_offset_and_bit(data, id, &offset, &bit);
 
-	return 0;
+	return regmap_update_bits(data->map, offset,
+				  BIT(bit), BIT(bit));
 }
 
 static int meson_reset_level(struct reset_controller_dev *rcdev,
@@ -48,25 +56,13 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
 {
 	struct meson_reset *data =
 		container_of(rcdev, struct meson_reset, rcdev);
-	unsigned int bank = id / BITS_PER_REG;
-	unsigned int offset = id % BITS_PER_REG;
-	void __iomem *reg_addr;
-	unsigned long flags;
-	u32 reg;
+	unsigned int offset, bit;
 
-	reg_addr = data->reg_base + data->param->level_offset + (bank << 2);
+	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->level_offset;
 
-	spin_lock_irqsave(&data->lock, flags);
-
-	reg = readl(reg_addr);
-	if (assert)
-		writel(reg & ~BIT(offset), reg_addr);
-	else
-		writel(reg | BIT(offset), reg_addr);
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
+	return regmap_update_bits(data->map, offset,
+				  BIT(bit), assert ? 0 : BIT(bit));
 }
 
 static int meson_reset_assert(struct reset_controller_dev *rcdev,
@@ -113,30 +109,42 @@ static const struct of_device_id meson_reset_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
 
+static const struct regmap_config regmap_config = {
+	.reg_bits   = 32,
+	.val_bits   = 32,
+	.reg_stride = 4,
+};
+
 static int meson_reset_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct meson_reset *data;
+	void __iomem *base;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->reg_base))
-		return PTR_ERR(data->reg_base);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
-	data->param = of_device_get_match_data(&pdev->dev);
+	data->param = of_device_get_match_data(dev);
 	if (!data->param)
 		return -ENODEV;
 
-	spin_lock_init(&data->lock);
+	data->map = devm_regmap_init_mmio(dev, base, &regmap_config);
+	if (IS_ERR(data->map))
+		return dev_err_probe(dev, PTR_ERR(data->map),
+				     "can't init regmap mmio region\n");
 
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_REG;
+	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
+		* regmap_config.reg_stride;
 	data->rcdev.ops = &meson_reset_ops;
-	data->rcdev.of_node = pdev->dev.of_node;
+	data->rcdev.of_node = dev->of_node;
 
-	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
+	return devm_reset_controller_register(dev, &data->rcdev);
 }
 
 static struct platform_driver meson_reset_driver = {
-- 
2.43.0



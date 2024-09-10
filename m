Return-Path: <linux-kernel+bounces-323453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665CC973D68
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9461C20DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D850A1A3A9C;
	Tue, 10 Sep 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D7abIpd/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841A1A0B10
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985987; cv=none; b=s0/J5k98/Z/Nc5Pt+t9REn0CdSGAVRuLyXnKuplX0xB0z5/1ffP4JCBHXMDHJZoMsMp1EbyT8v0kxIJxW/lvw1Wtm8Z9rnMz0F6S1DZoSUqdkPDMN1yqdDdoaTy9JxJniLbStvn2p11AtKF9B8KkrAURWp2qwUavdr/18CYkp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985987; c=relaxed/simple;
	bh=4VEzXjRyAdc+s0ybDA3IP98hrZK72BhbDpiWxhkjQHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKetqAhExG5lKI94B3xsSd9Sr1Dfu/v4zw0eXm5q88aDcui6U3xBK1Fo+R3U35tY7uPcu0SKjC2c2dKK2yLG2TUXx+13L6bP1n0RfOyhBrKwqnvKdE5YPCpm770zchmIn1BrEu2082LytLS0rM/CjI+KdNO6SnjjlMxskOnMuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D7abIpd/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso25390235e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985983; x=1726590783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1hDqtVqiV/aX1h4XvmroKUK+ZQ/3Ms3NrT6oivQF+g=;
        b=D7abIpd/cjXw3s0+BXtnBORoci2BT+OK6SPfCfhc71llYrpPFlShz13hEwNFJIktsY
         0tkBzVmOgadCE81eQKa7+W8RB8ZHGrGOlRCYUbhqSIfCeC8kjhBs/RsiUFcI5UjJ7x87
         bZ43eGc7o5c/a2W9E+fvBnc6KPvMOkJyHc9f3gcur+2ZCnuRian4GFqI1eANFe1mzd9G
         +PuKizHgov4YVjIgsd9GrRjtW4grHU8QNCjfS+xBTVc0vefkVsPLVulX+trEIBUm6qon
         ERPF7clQMHfdztk4dBg+VaX9l45RbmWL8jLKx8EJgmFP9D0x5PK6sCedviWkLrsUQXzZ
         k13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985983; x=1726590783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1hDqtVqiV/aX1h4XvmroKUK+ZQ/3Ms3NrT6oivQF+g=;
        b=hfU3PuP48Nvf29fD6L0qVd7k84nP4Ms1k6/296gkmBQEyy5i5071jlm9BtHuN1YSMq
         wwlgCMDwb8hO6/YP9DB0Bpeu2j1gkA0ty5B8dTVpRqAx1y7Mp4OTFMdby+VU1DNM3iPq
         irWOs4y00NkelCCE+CGPVKk4FvMLazef/Ri6i9V9d0OU7vkELvmvfw/2O2KQ60Esi0VD
         1CHInAA9RgbHAhu0OuozbEN22DP2T1VGb7IP+I8qvjHx1GIN5nV26MZo13bx8Ukvk/ee
         z8qEwPtBt9+c4zyqgJjTF8+tIzoWbip7ufrwMDAoKQ9osLvgCQYxgf2LMBMyu51u0hL1
         aIeg==
X-Forwarded-Encrypted: i=1; AJvYcCUD0KldroxbRywe5p1+ZJvPeRe2FfR/+jx2QYeI97Be2c2bhvXv8GF3JWs6o4y/BfA/f8p3L3aEjY5jo98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlzkoRuFA5p0yxJAL2kPfJ9T125twlAaqxwkFXrcz9p/5JC7j
	UALf8c/QvAQMIQfvbnM33WlanT5BpT5BbAXNNvKn1BfbqEsSHxet6cD84bc7bmvxl8K5XYR7Tyv
	2
X-Google-Smtp-Source: AGHT+IFH59dMtSyNh7I/3WfwlYfHuMIivRRdyOaildtpWKUEoDTns5XbC6x76J50TkiaYXWsITBbmg==
X-Received: by 2002:adf:cf09:0:b0:374:c651:4abf with SMTP id ffacd0b85a97d-3788969feb9mr9056641f8f.52.1725985982855;
        Tue, 10 Sep 2024 09:33:02 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:02 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Sep 2024 18:32:43 +0200
Subject: [PATCH v5 1/9] reset: amlogic: convert driver to regmap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-meson-rst-aux-v5-1-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
In-Reply-To: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5135; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=4VEzXjRyAdc+s0ybDA3IP98hrZK72BhbDpiWxhkjQHY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS0LOglI0FGds477b9AQjE45jlk1P8b7S9Ch
 gvPHtXspCmJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0tAAKCRDm/A8cN/La
 hcV3D/4gRYU9Uq7kJahPMTbuJSt7Ql6GYfpoar3B0U+Wo8OAw8hZOR10Yc4wuWNRsvrdUXz7TTg
 THwq0hEJtvshHYIqxuD/kSVrTE6Ha0Cyqq5JoEqzmxr+EVBPgIJRayEx8iNlC2y17kldgKTENgg
 msszAvsvo++eV5KIIl3mxQWoQ3eoGrYJqv73DEu3LNAhH3KYjroR7U5dojFH5UVu2H7llzbz1xA
 Re3N4lkfnbvZglOQ+Ur9mr/1sGGQJfsjrQmeGW5CvQlk0wKW8tBi0+on2e/fMk5ejRuuP2XedcN
 8i+Wm+ybn9I0QBZm2fm3OhSiJzzh/ZPTVHIW5PQTsMTMP2jb7/mBRIvfEhH1OM08AN/ZM0SQ4r6
 txAhLskuqHZDsMl0YsxU1qzZX1K/M51hzq/OlBCsf2Ke6eKTwQ01BRQFtwibcGi9hk/aQzbas4M
 4cdpCxLIQyZK+wPSqK6EWU/Eznf5pYnfW4l49Hyh7b544JxTSekXmNv76AID0GXQZl7o2aJ/uRJ
 ++5blmIBwvYS7dQVRIELRqhsdlQbzWHA42y8mYCUibeqLTwo+l8xnMy0JW3SLklGDHZfoofwiWa
 hTMc4l6jqK26IVKH9DGupIht0K8j2cxO7YfJA1Nemy4vvNLO3GuapbAaxr1oGcDjHDsDoyuxnls
 jltoZnT+NliAMcw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

To allow using the same driver for the main reset controller and the
auxiliary ones embedded in the clock controllers, convert the
the Amlogic reset driver to regmap.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/Kconfig       |  1 +
 drivers/reset/reset-meson.c | 79 ++++++++++++++++++++++++---------------------
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 5484a65f66b9..c730ba6f678b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -157,6 +157,7 @@ config RESET_MESON
 	tristate "Meson Reset Driver"
 	depends on ARCH_MESON || COMPILE_TEST
 	default ARCH_MESON
+	select REGMAP_MMIO
 	help
 	  This enables the reset driver for Amlogic Meson SoCs.
 
diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 1e9fca3e30e8..9dd38cc209e2 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -11,36 +11,43 @@
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
+	return regmap_write(data->map, offset, BIT(bit));
 }
 
 static int meson_reset_level(struct reset_controller_dev *rcdev,
@@ -48,25 +55,13 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
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
@@ -119,30 +114,42 @@ static const struct of_device_id meson_reset_dt_ids[] = {
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
2.45.2



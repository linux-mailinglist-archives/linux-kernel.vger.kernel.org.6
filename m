Return-Path: <linux-kernel+bounces-318942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE6696F57C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2CBB232A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564391CEE9D;
	Fri,  6 Sep 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1NMVV+AU"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFF1CCEEA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629724; cv=none; b=j35VblKGw2l3pcxmm5qByRPpxQ0u+oVzoohPy7tL8oiEJNQJUDz2Gb/Zw/oVrN+sInHY9GPheyPNNi0k0AjereBmqC/5lb7mStLyjv8P5WkFoVKalrMdZxgsAmvWQlHyzWaD5qCmXE/zJM0dsix6wUt7Rylo94nTBXin7VbIriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629724; c=relaxed/simple;
	bh=nr6iNBU9QPCIvnO9/MQUvPA1RIWVyVRjkH+HH1AHiQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVzJY+tqhm5dD4QuhXdza/mdMEDgUFAXDNsLQgN3wfuHLbA7zqI5H43IwU2+dVf4PLCrk7d05ONK+YIxU0G3sxRAXQWJ37+VXDmImJBdqz0Keo5NXSIwJuNDd9HGR99UH8O19sR57tzaR6ekA/GwKL/1EU0paFnbOfGdnJQkS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1NMVV+AU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37747c1d928so1153128f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725629721; x=1726234521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/k8Vw9s8c3vx1FzrrsUK66X+N4rd9Tj8aDo0ScuGc6U=;
        b=1NMVV+AU1YKNWM+f3Uh7e0GQVWz1Jj3vlRm7wLnb3BuSo3suNZEhNunl1w792ZeQ1o
         xMT3DePnKEJCiyRoXRYGkT0jVCbSasbDpuGHyCjv6hXfzRxhtBK/8ee0UiBh81lso2RG
         hbBp4mPCKBGKgVrfaTUbu10c220ki8SVpJFuj7m2xmt1PVpt/adgaC2OqG2RFtuhF5xX
         khDTuAp1Dl3tdCEmjUDG9M807To091r3dHKTxegw/B/prJgEoOd4MA91B3gUgibqBn+N
         Zj+D9n0X71Onvd+nj7W1kW2WLVESHz0cXPiMweOzKay9k957N9DEOGTrWSRYcBNp0Olw
         a2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629721; x=1726234521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/k8Vw9s8c3vx1FzrrsUK66X+N4rd9Tj8aDo0ScuGc6U=;
        b=VE/RhO6wxp06X/faB1YxC2gq/Pac9F3ZQr8IPN5GitE+/lX8rwRIR9Ve+HPOq/U9x2
         pQHmXNdEMU25z5FcfoWlUZUDj7+ZOECNxwU+ZvpXubtz4InGxlk7lt121yD7pDTEoueC
         JIBIfZfCTTXzoq8+mYwN9oPkUHCRNqibBsmM2OTZ6TOMT7LSaBo/Wg8zTHFpGXpc8kgE
         AGpMCRCm/kJeoqtkO0egvdqjV8wSPeYKcj8Yf80eUcfhL9FPJImmPUUq1mutXy7HFNyc
         xwTmsnYYbyi81v29JjJCRbyZ8fD67PxCTZZV+LOMZC5Pdt15VKAHA1LwxMTulI5A6WFO
         laMg==
X-Forwarded-Encrypted: i=1; AJvYcCVs5ZNQvr7MBm7TLoK0TVS9vi8vK1R1wSwAXSjuOR5hcOvml34ZI3RFGHPuBEUx6LtYlAmpjTngRsp7Nyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj//9F4T//zJf75Xn6hzw8hSUdJktG8leqy7OvJ/BbCLqHgaMn
	/+1I/ZIE+W2L5eLFNIxR4udHmLc5YXRah/uFfaLUvFkNkStEQnLdLHt2iLOGUmYXxl+q2k99Baq
	d
X-Google-Smtp-Source: AGHT+IG6zGp+EGPyl2G/sbXQM+iPf9ynjtzmZ9+oRa6GrrDLZwIH2kFh1EK96Z7tR1FuVnxf2OaClA==
X-Received: by 2002:adf:f610:0:b0:371:82ec:206f with SMTP id ffacd0b85a97d-378895c71b8mr1873113f8f.16.1725629720180;
        Fri, 06 Sep 2024 06:35:20 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b0ad:b504:10d4:481d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21684597f8f.62.2024.09.06.06.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:35:19 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 06 Sep 2024 15:34:46 +0200
Subject: [PATCH v4 1/9] reset: amlogic: convert driver to regmap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-meson-rst-aux-v4-1-08824c3d108b@baylibre.com>
References: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
In-Reply-To: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4710; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=nr6iNBU9QPCIvnO9/MQUvPA1RIWVyVRjkH+HH1AHiQI=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2wUOaSvOFexQNmqHkSGVtcoiU+q5cdE3wWeos
 pGVbRanLvKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtsFDgAKCRDm/A8cN/La
 hYXbD/9xqasTIEVkwp3pKd+o2zGkOPC0wgIxIRtlVKClkbYJ6Obm8DdMqe3C080mzvx3aQdj3BQ
 E+sGkfcg0+gFc0bEz7G5fv2HxkMiWOPO8HtxjlMInf4ncihnVGxWXnzDQujH1Xvnv2D1yz5wY+U
 S3wmUEo0Uh362C8F5+uMhaunHxEYVMPw6p2cQiRJdBy+1QGlS3uKMJ17dxG+SnNhfYvOsahsKoR
 XfmQg8tbZUs19uPqswVBmNZAowF548LF7Y+zPxtve0oGSCHyA22sGxuSFol2osUbAk5cnQl1Z5v
 DNoM7nQm6MHspbLdY89r3SXEyTvBLw+XSzd6vAwvTfjgQZ/ZwJ/Id+XL1RDGpmylvhMs3Tf4uA2
 ZQjloABTRZJ4DiW1rJbAePnOUnjNmtGDFV+Y2FmmgRBqc8VTj2DAVKEJs+e71PfrmEGhUhjvrwZ
 JWG/54oT8NXUfkrhickGdU0iI3YTvYfSgnowcCCiaPzXn9P/7J585vtGXiPMUM/EMIGCRplVsjY
 /WzuRwoOOsQbyvij3SFUrhEYaX0K9o0VZ2puNlAlwrHGjN4OuAlbKOPy1cteyErWbRPItw4xn40
 tUCpjnZIQyMk9nbMbErpi7dxJ1OK0WL3Ti4NeFfWFV7C2UzBn4Orrmn4Ra+tqJIrrJ22eMkbloN
 YQFDPL/27gC1EUA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

To allow using the same driver for the main reset controller and the
auxiliary ones embedded in the clock controllers, convert the
the Amlogic reset driver to regmap.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 79 ++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

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



Return-Path: <linux-kernel+bounces-323460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B35973D70
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177221C24EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4341AC43D;
	Tue, 10 Sep 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tXS6d3HZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4441ABEAF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985994; cv=none; b=qLl3lV40APgVsTez+3XtJJO5PjAPRb7rRfUTq7X0Te8wiJy9XMU6x1tbYZEq0oxHO4OKwCCA8fcb9mfDvl6/umkkJp/9zszYaLfSoJadgWMhIKAjCDy1xAJrX+2EAdi+cJ41loYFjGONf0FyY0zcUrkchp832W79ZHti7C6HwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985994; c=relaxed/simple;
	bh=Y2iBifCKerss9PeXY+mNFJFaOt4z3yePdb10uNuG3wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Md1904snLSoDCbBALlGxKO6Nw6J//R2Tut7LMAKhKpproVCQxau+2dMh1vATWziCYYv7g9jHZeoZTuhdFlp6LJNeUAJHxA97IEQodIdWBvU//AjUuMpT2dYtCO0b6OA3UdzrXUQ7oXRBcbMixDgvbhYl81BXBJMnPSvPmKFevtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tXS6d3HZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bb6d3e260so9996435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985990; x=1726590790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdhmdJqA/EyjrFNuD6QzQPCe1kr/HLVNmesNpkTvFG8=;
        b=tXS6d3HZSf+vEaC4Dnl3fx8iwWNpn8w5Oad7HoM/VjBb7PFD6p0WcBG9J1oVCPFR0h
         RHSmo6xYlCHjwTZNaKZZnN8jL4mZLjeEKxmYTijkOlP+bFwiu1rexAgiWzc/SV2nOVYg
         baImnyAEi3321zn6I/uVLqx0Yah05bzCtw7e8qYZvZHAG9P1nPSvuR0McNYb2F5JgaBG
         saoRN2R3BUhB9g9AMjTrn9BSLJapHJLT0SBPRbZtCKcZr03yMt+Cxn0R6tXMAKzW89H4
         qfCqozvD5CHmLHNNhB5YhWnPKUmhI8Kon+1CKb4KOiS3DjeXmUNzgtat3KKcZYYW3t9Z
         bSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985990; x=1726590790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdhmdJqA/EyjrFNuD6QzQPCe1kr/HLVNmesNpkTvFG8=;
        b=WVq0zZgf3O80wOVmI5v8erpMynLYi9LBy+rKiSj9SHsqB10/35MVrHJR8tDztw2P8U
         fLf56JSNk8oO1Jbzv3rsM92jY6jVEogxsT1F1K95XNZYeMYVnTNBM+FDgxMfb+kMNPu1
         uQ3GTbMc+ou77MKd/znuuzYUopqfSQEqbMWazwcMCdUAYOZI4JvTYwFSsMDGrX/Qz3HF
         mSszu9cZQpRwfRgcgzJmPcFceFN79LjWSXh4qpg5mwEibMcvV9ac7SGUOjeR6JgrV8zd
         ywCrroh7DctnK1m0V1GOHTZk++z/kt+pgwGQ7PgVOH3rPQDvTAluNKb2/R+rfTca989b
         +RNA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ6vsrZ9tdxBCljBKcZdRJ1F2A4fzR2aZmV40RZc4MRnci/eTcr4udn+11qnrt8iOhWRCZlIIpVDQDr9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1JeHQz1hlcaiWYnPbhkWPSqzQ49yB8Pxm4T2rx9TP1vI8TQt
	8thnjzlcXqlCIwBFUZB8U4hbGLOqVZElR6SRx7IMAKEtE400Rt0weLC+UOVZ9Pk=
X-Google-Smtp-Source: AGHT+IG0AbAhGMFiLKIpKgecMzRUKowqar+Tq4u+vnpZI/+6Lvxx9Ij6skVPyUAN8aUk/W1kE7M6Sw==
X-Received: by 2002:a05:600c:1549:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-42ccd30c286mr2390415e9.1.1725985989916;
        Tue, 10 Sep 2024 09:33:09 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:09 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Sep 2024 18:32:50 +0200
Subject: [PATCH v5 8/9] reset: amlogic: split the device core and platform
 probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-meson-rst-aux-v5-8-60be62635d3e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11278; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=Y2iBifCKerss9PeXY+mNFJFaOt4z3yePdb10uNuG3wQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS7BE55V32yPq8m1dzSvsGLZUB5NTINws7JD
 Duz7ppsnL+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0uwAKCRDm/A8cN/La
 hRWQD/9Rht4NZSryoBK6rvt/1gkE8AYg4yXpm4IX/vV9md2JzoEStF9v1pRbXvCmI8FGebY0sHA
 VOcf5+0MXKveEbIXwDa+b2bDasYnxOSAyi4EyidTUitXP525Qhwxb9/mBeZ9r2y0S1fXv1fUlnv
 Q77zf+NtCsXsE+creuzdjSPLa8VQxI28vr+6XpIOIXo4PfkRu1FcMO2UB/r+JG1MTFSvVVAfFIL
 jdj9pOGJBB6JtTsp8N0zvqY04+a2Rln+OGo8RmoRWSRmAF9iQiY49UNR0QbpLEbyokncf4YjW1H
 gEwBTC5BbidnQehnJouioBfHVi0Hi1aMffgNklJmX1ZiZPuydfEQeKCG3w6/RzZS0KFjI/SAaJw
 bfTQ3/t+w9Rv1xTvyX5LggLyf5aeRQ7uF//lQVEVZR8+sqUtgaZ5ao2bLPrWIUqOBgpopb/R42i
 WzXHFSVZJFhgNf47tSRs3Z8JQtadzlHN2LYM7MdVFVN7Xw5BtQkolJsQLduCfNwTlJImUM9Bbri
 h8A/D6Ebm+CZLvq8vGI5ig9hVF0YUER9q7x0aKbWQfgRIu0JpmDtqDFUQvAEKhKjw2q4zhmgZ1T
 ycGkKj6JWb1aSalcGkNk6kC1FQADmp2KRz0FBG+GMd1Zt/shZ4Qfa9+KDVd3ElGRV304T5cvX25
 qCroFfMuPIAkE1w==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

To prepare the addition of the auxiliary device support, split
out the device coomon functions from the probe of the platform device.

The device core function will be common to both the platform and auxiliary
driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/amlogic/Kconfig              |   7 +-
 drivers/reset/amlogic/Makefile             |   1 +
 drivers/reset/amlogic/reset-meson-common.c | 121 ++++++++++++++++++++++++++++
 drivers/reset/amlogic/reset-meson.c        | 122 ++++-------------------------
 drivers/reset/amlogic/reset-meson.h        |  24 ++++++
 5 files changed, 167 insertions(+), 108 deletions(-)

diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfig
index 532e6a4f7865..1d77987088f4 100644
--- a/drivers/reset/amlogic/Kconfig
+++ b/drivers/reset/amlogic/Kconfig
@@ -1,10 +1,15 @@
+config RESET_MESON_COMMON
+	tristate
+	select REGMAP
+
 config RESET_MESON
 	tristate "Meson Reset Driver"
 	depends on ARCH_MESON || COMPILE_TEST
 	default ARCH_MESON
 	select REGMAP_MMIO
+	select RESET_MESON_COMMON
 	help
-	  This enables the reset driver for Amlogic Meson SoCs.
+	  This enables the reset driver for Amlogic SoCs.
 
 config RESET_MESON_AUDIO_ARB
 	tristate "Meson Audio Memory Arbiter Reset Driver"
diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makefile
index 55509fc78513..74aaa2fb5e13 100644
--- a/drivers/reset/amlogic/Makefile
+++ b/drivers/reset/amlogic/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
+obj-$(CONFIG_RESET_MESON_COMMON) += reset-meson-common.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
diff --git a/drivers/reset/amlogic/reset-meson-common.c b/drivers/reset/amlogic/reset-meson-common.c
new file mode 100644
index 000000000000..d57544801ae9
--- /dev/null
+++ b/drivers/reset/amlogic/reset-meson-common.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Amlogic Meson Reset core functions
+ *
+ * Copyright (c) 2016-2024 BayLibre, SAS.
+ * Authors: Neil Armstrong <narmstrong@baylibre.com>
+ *          Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include "reset-meson.h"
+
+struct meson_reset {
+	const struct meson_reset_param *param;
+	struct reset_controller_dev rcdev;
+	struct regmap *map;
+};
+
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
+static int meson_reset_reset(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct meson_reset *data =
+		container_of(rcdev, struct meson_reset, rcdev);
+	unsigned int offset, bit;
+
+	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->reset_offset;
+
+	return regmap_write(data->map, offset, BIT(bit));
+}
+
+static int meson_reset_level(struct reset_controller_dev *rcdev,
+			    unsigned long id, bool assert)
+{
+	struct meson_reset *data =
+		container_of(rcdev, struct meson_reset, rcdev);
+	unsigned int offset, bit;
+
+	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->level_offset;
+	assert ^= data->param->level_low_reset;
+
+	return regmap_update_bits(data->map, offset,
+				  BIT(bit), assert ? BIT(bit) : 0);
+}
+
+static int meson_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct meson_reset *data =
+		container_of(rcdev, struct meson_reset, rcdev);
+	unsigned int val, offset, bit;
+
+	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->level_offset;
+
+	regmap_read(data->map, offset, &val);
+	val = !!(BIT(bit) & val);
+
+	return val ^ data->param->level_low_reset;
+}
+
+static int meson_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	return meson_reset_level(rcdev, id, true);
+}
+
+static int meson_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return meson_reset_level(rcdev, id, false);
+}
+
+static const struct reset_control_ops meson_reset_ops = {
+	.reset		= meson_reset_reset,
+	.assert		= meson_reset_assert,
+	.deassert	= meson_reset_deassert,
+	.status		= meson_reset_status,
+};
+
+int meson_reset_controller_register(struct device *dev, struct regmap *map,
+				    const struct meson_reset_param *param)
+{
+	struct meson_reset *data;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->param = param;
+	data->map = map;
+	data->rcdev.owner = dev->driver->owner;
+	data->rcdev.nr_resets = param->reset_num;
+	data->rcdev.ops = &meson_reset_ops;
+	data->rcdev.of_node = dev->of_node;
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+EXPORT_SYMBOL_NS_GPL(meson_reset_controller_register, MESON_RESET);
+
+MODULE_DESCRIPTION("Amlogic Meson Reset Core function");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(MESON_RESET);
diff --git a/drivers/reset/amlogic/reset-meson.c b/drivers/reset/amlogic/reset-meson.c
index af690d3012ec..feb19bf6da77 100644
--- a/drivers/reset/amlogic/reset-meson.c
+++ b/drivers/reset/amlogic/reset-meson.c
@@ -2,106 +2,20 @@
 /*
  * Amlogic Meson Reset Controller driver
  *
- * Copyright (c) 2016 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2016-2024 BayLibre, SAS.
+ * Authors: Neil Armstrong <narmstrong@baylibre.com>
+ *          Jerome Brunet <jbrunet@baylibre.com>
  */
+
 #include <linux/err.h>
-#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-
-struct meson_reset_param {
-	unsigned int reset_num;
-	unsigned int reset_offset;
-	unsigned int level_offset;
-	bool level_low_reset;
-};
-
-struct meson_reset {
-	const struct meson_reset_param *param;
-	struct reset_controller_dev rcdev;
-	struct regmap *map;
-};
-
-static void meson_reset_offset_and_bit(struct meson_reset *data,
-				       unsigned long id,
-				       unsigned int *offset,
-				       unsigned int *bit)
-{
-	unsigned int stride = regmap_get_reg_stride(data->map);
-
-	*offset = (id / (stride * BITS_PER_BYTE)) * stride;
-	*bit = id % (stride * BITS_PER_BYTE);
-}
-
-static int meson_reset_reset(struct reset_controller_dev *rcdev,
-			     unsigned long id)
-{
-	struct meson_reset *data =
-		container_of(rcdev, struct meson_reset, rcdev);
-	unsigned int offset, bit;
-
-	meson_reset_offset_and_bit(data, id, &offset, &bit);
-	offset += data->param->reset_offset;
-
-	return regmap_write(data->map, offset, BIT(bit));
-}
-
-static int meson_reset_level(struct reset_controller_dev *rcdev,
-			    unsigned long id, bool assert)
-{
-	struct meson_reset *data =
-		container_of(rcdev, struct meson_reset, rcdev);
-	unsigned int offset, bit;
-
-	meson_reset_offset_and_bit(data, id, &offset, &bit);
-	offset += data->param->level_offset;
-	assert ^= data->param->level_low_reset;
 
-	return regmap_update_bits(data->map, offset,
-				  BIT(bit), assert ? BIT(bit) : 0);
-}
-
-static int meson_reset_status(struct reset_controller_dev *rcdev,
-			      unsigned long id)
-{
-	struct meson_reset *data =
-		container_of(rcdev, struct meson_reset, rcdev);
-	unsigned int val, offset, bit;
-
-	meson_reset_offset_and_bit(data, id, &offset, &bit);
-	offset += data->param->level_offset;
-
-	regmap_read(data->map, offset, &val);
-	val = !!(BIT(bit) & val);
-
-	return val ^ data->param->level_low_reset;
-}
-
-static int meson_reset_assert(struct reset_controller_dev *rcdev,
-			      unsigned long id)
-{
-	return meson_reset_level(rcdev, id, true);
-}
-
-static int meson_reset_deassert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	return meson_reset_level(rcdev, id, false);
-}
-
-static const struct reset_control_ops meson_reset_ops = {
-	.reset		= meson_reset_reset,
-	.assert		= meson_reset_assert,
-	.deassert	= meson_reset_deassert,
-	.status		= meson_reset_status,
-};
+#include "reset-meson.h"
 
 static const struct meson_reset_param meson8b_param = {
 	.reset_num	= 256,
@@ -151,33 +65,25 @@ static const struct regmap_config regmap_config = {
 
 static int meson_reset_probe(struct platform_device *pdev)
 {
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
 
-	data->param = device_get_match_data(dev);
-	if (!data->param)
+	param = device_get_match_data(dev);
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
-	data->rcdev.nr_resets = data->param->reset_num;
-	data->rcdev.ops = &meson_reset_ops;
-	data->rcdev.of_node = dev->of_node;
-
-	return devm_reset_controller_register(dev, &data->rcdev);
+	return meson_reset_controller_register(dev, map, param);
 }
 
 static struct platform_driver meson_reset_driver = {
@@ -191,4 +97,6 @@ module_platform_driver(meson_reset_driver);
 
 MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(MESON_RESET);
diff --git a/drivers/reset/amlogic/reset-meson.h b/drivers/reset/amlogic/reset-meson.h
new file mode 100644
index 000000000000..4e1dbd7569c5
--- /dev/null
+++ b/drivers/reset/amlogic/reset-meson.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (c) 2024 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_RESET_H
+#define __MESON_RESET_H
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+struct meson_reset_param {
+	unsigned int reset_num;
+	unsigned int reset_offset;
+	unsigned int level_offset;
+	bool level_low_reset;
+};
+
+int meson_reset_controller_register(struct device *dev, struct regmap *map,
+				    const struct meson_reset_param *param);
+
+#endif /* __MESON_RESET_H */

-- 
2.45.2



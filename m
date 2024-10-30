Return-Path: <linux-kernel+bounces-388844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B383E9B6525
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08F01C21F63
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1F1F4298;
	Wed, 30 Oct 2024 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kw2MusW5"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572151EB9FD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297026; cv=none; b=tnV3tmlqd6zGZK8C8P7z4x5HEGNpXvzotfK5+rGRmwAs4hpT+09m6ptak3GJqDlWaDhNfK1ypdnmEMzg3fTz0wdkmwGvFls8vW5EYTjGMr6ilMSF1CiK5M1qy3FANB45f7Yr6fy7bSrrVP5l3EJx1OhNLKMAIJtZTOG1yhD/1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297026; c=relaxed/simple;
	bh=U3wPU5DgJFbZ11jCb2oEje7Ha/+dy8PlwFR/zPfd2C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFlZofd8vR3zzy3Sfvb7g4SOZBwfpisPvM0m2rcH1AUtlyodqNPc8qg5IYpES90rB4dN2XPmrnxPhJ8o8xv5dg3V1yWJ8NPd6vBBdbyloHnj5PUlEt+iI7bIGhI9EJIJijqIgwW/XEat29Kt0Jk1DkpKaMqNpNAqdNNukaOR/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kw2MusW5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso6890206e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730297021; x=1730901821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeTM1UP/JKN2HvD4YD1Y7DH9pKIiJFnkrzVdoRLqoXo=;
        b=Kw2MusW5hnCWZh1aQaD8Am/dtwlEzD9Y1bgKprvSTXoEaTC/bbTl3KbRsbZjHrqt5h
         TMwZxpaTXzAfqj7/+SLf1Rh/XzWA+mUSaZNLzWNC5TMHz6qdNk/YK+T2Inf+ggJXNRg5
         wS05G77cuzKjDhLmIwnOXvitSR0yMOIoleK1ujD5GSum90SBoaMZoXCVHV9OUj+A3rx5
         sWW0wUlom2ArhL14pFIrn3TtxuZ9r/1jeUBYeNuZqj/5y5A72DhhzVghFWCAKv7DI5iE
         3r+KXKLASxA2jF2vNfG2rNS4WV08EDs6+mu3sfjLvfWlHhlC/2MyHSFx6Bn58bzzOK89
         +pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297021; x=1730901821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeTM1UP/JKN2HvD4YD1Y7DH9pKIiJFnkrzVdoRLqoXo=;
        b=MomFh9oGkLX1zf/x7wMFw/FnpJSq8KOxtDkqG4uiXDRIrzxr1yo9GiX1suOJgXuSeG
         fHCrfjKRuBnfPwTPNNpObpVONkYn4Xz0UtVyqluxe2dfMvz0XUMd095xeJFRcARr9Pne
         pcRAO23uS5BuOznCYZEiFGHAdO0l/QY0eXlg9gb8yOfbwd9Jvhu+TIRCVoHQ6OE/Xqt/
         U0P1ZEYwmN1rDDe3tq6DD4/pbFw37ziVMlmVkgjHv72Fin7m6dgQDW9OvJ90s/9SRCri
         +RrxKdZJDBtTsmI0gbxcvDuorJLNtepqsdKnIuyT95KtmJkJCuuJPRQHE5fAvsxrSvOR
         sz5Q==
X-Gm-Message-State: AOJu0Yyj29iRNp7oK7m8ag75t1BBKOMy/nO2Vx0W/pVSTjq3S+nehNfD
	YJarcHMbouFO7q8Yr74pXOnc9TuTcxo1/B5VYvCEi8snnPWOh6SRo6emHD8CMEm/Ow18QTq3nQ3
	Y2Ic=
X-Google-Smtp-Source: AGHT+IHCP4WNCOkojPwqzIJEdVW3Gvv3Rxap+mHqa5KAPADEGBlNzFelwP9o3OpBa2lBJVhkw/P3Lg==
X-Received: by 2002:a05:6512:1384:b0:536:a4e1:5fa2 with SMTP id 2adb3069b0e04-53b348de8c1mr7883715e87.26.1730297021114;
        Wed, 30 Oct 2024 07:03:41 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm22498405e9.30.2024.10.30.07.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:40 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/7] nvmem: Add R-Car E-FUSE driver
Date: Wed, 30 Oct 2024 14:03:10 +0000
Message-Id: <20241030140315.40562-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
References: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6626; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=AF2xFGTuUEoPWLs+M9669JQEm8bKosMbLQXhR1Izw7I=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyijrTNWJq91sHx/jELXJbVClnH7i00nriDf Sr6ECZ8FLmJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8ogAKCRB6of1ZxzRV N/XlB/0ZacMJ6b7b3ue4tGQ/bQxXclzGoWScZP3mLUyrgWI9mFTI2oav3XarxdiZyWgt64hfAmn u7VUqHM6yfUhSh3JnnaDkqcVbUrMC/U8GnwmFGVfPueU/6zQDObAsdGToPHFTS61eC4JmXgKO4F UMyhoQjS2JkLsZ/y8cSumVyFdfsBlFfwy663GfLzpEfV2W6tUqRQZbrFl93JLNxCGsXRi7AYdCj 9ekdVb06BK4YFEUU1FWJhK6sE0txkHLoRaXhfftdE7YtUWwZI4J5LQeAcKJi5CoCFre11zP4/ES DrFoC6vOeucRyXk54G+WgZCiCO/5bMB3tpJDXsaG2XOudKS8
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Car Gen4 SoCs contain fuses indicating hardware support or hardware
(e.g. tuning) parameters.  Add a driver to access the state of the
fuses.  This supports two types of hardware fuse providers:
  1. E-FUSE non-volatile memory accessible through the Pin Function
     Controller on R-Car V3U and S4-8,
  2. E-FUSE non-volatile memory accessible through OTP_MEM on R-Car V4H
     and V4M.

The state of the cells can be read using the NVMEM framework, either
from kernel space (e.g. by the Renesas UFSHCD driver), or from
userspace.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS                |   1 +
 drivers/nvmem/Kconfig      |  11 +++
 drivers/nvmem/Makefile     |   2 +
 drivers/nvmem/rcar-efuse.c | 142 +++++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 drivers/nvmem/rcar-efuse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 269529b370a0..b3b605a52d3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2924,6 +2924,7 @@ F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	arch/arm64/boot/dts/renesas/
 F:	arch/riscv/boot/dts/renesas/
+F:	drivers/nvmem/rcar-efuse.c
 F:	drivers/pmdomain/renesas/
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d2c384f58028..8671b7c974b9 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -246,6 +246,17 @@ config NVMEM_RAVE_SP_EEPROM
 	help
 	  Say y here to enable Rave SP EEPROM support.
 
+config NVMEM_RCAR_EFUSE
+	tristate "Renesas R-Car Gen4 E-FUSE support"
+	depends on (ARCH_RENESAS && ARM64) || COMPILE_TEST
+	depends on NVMEM
+	help
+	  Enable support for reading the fuses in the E-FUSE or OTP
+	  non-volatile memory block on Renesas R-Car Gen4 SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-rcar-efuse.
+
 config NVMEM_RMEM
 	tristate "Reserved Memory Based Driver Support"
 	depends on HAS_IOMEM
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index cdd01fbf1313..5b77bbb6488b 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -52,6 +52,8 @@ obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)	+= nvmem_sec_qfprom.o
 nvmem_sec_qfprom-y			:= sec-qfprom.o
 obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
+obj-$(CONFIG_NVMEM_RCAR_EFUSE)		+= nvmem-rcar-efuse.o
+nvmem-rcar-efuse-y			:= rcar-efuse.o
 obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
 nvmem-rmem-y				:= rmem.o
 obj-$(CONFIG_NVMEM_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
diff --git a/drivers/nvmem/rcar-efuse.c b/drivers/nvmem/rcar-efuse.c
new file mode 100644
index 000000000000..f24bdb9cb5a7
--- /dev/null
+++ b/drivers/nvmem/rcar-efuse.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Renesas R-Car E-FUSE/OTP Driver
+ *
+ * Copyright (C) 2024 Glider bv
+ */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+
+struct rcar_fuse {
+	struct nvmem_keepout keepouts[2];
+	struct nvmem_device *nvmem;
+	struct device *dev;
+	void __iomem *base;
+};
+
+struct rcar_fuse_data {
+	unsigned int bank;	/* 0: PFC + E-FUSE, 1: OPT_MEM + E-FUSE */
+	unsigned int start;	/* inclusive */
+	unsigned int end;	/* exclusive */
+};
+
+static int rcar_fuse_reg_read(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct rcar_fuse *fuse = priv;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(fuse->dev);
+	if (ret < 0)
+		return ret;
+
+	__ioread32_copy(val, fuse->base + offset, bytes / 4);
+
+	pm_runtime_put(fuse->dev);
+
+	return 0;
+}
+
+static int rcar_fuse_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct rcar_fuse_data *data = device_get_match_data(dev);
+	struct nvmem_config config = {
+		.dev = dev,
+		.name = "rcar-fuse",
+		.id = NVMEM_DEVID_NONE,
+		.owner = THIS_MODULE,
+		.type = NVMEM_TYPE_OTP,
+		.read_only = true,
+		.root_only = true,
+		.reg_read = rcar_fuse_reg_read,
+		.word_size = 4,
+		.stride = 4,
+	};
+	struct rcar_fuse *fuse;
+	struct resource *res;
+	int ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0)
+		return ret;
+
+	fuse = devm_kzalloc(dev, sizeof(*fuse), GFP_KERNEL);
+	if (!fuse)
+		return -ENOMEM;
+
+	fuse->base = devm_platform_get_and_ioremap_resource(pdev, data->bank,
+							    &res);
+	if (IS_ERR(fuse->base))
+		return PTR_ERR(fuse->base);
+
+	fuse->dev = dev;
+	fuse->keepouts[0].start = 0;
+	fuse->keepouts[0].end = data->start;
+	fuse->keepouts[1].start = data->end;
+	fuse->keepouts[1].end = resource_size(res);
+
+	config.keepout = fuse->keepouts;
+	config.nkeepout = ARRAY_SIZE(fuse->keepouts);
+	config.size = resource_size(res);
+	config.priv = fuse;
+
+	fuse->nvmem = devm_nvmem_register(dev, &config);
+	if (IS_ERR(fuse->nvmem))
+		return dev_err_probe(dev, PTR_ERR(fuse->nvmem),
+				     "Failed to register NVMEM device\n");
+
+	return 0;
+}
+
+static const struct rcar_fuse_data rcar_fuse_v3u = {
+	.bank = 0,
+	.start = 0x0c0,
+	.end = 0x0e8,
+};
+
+static const struct rcar_fuse_data rcar_fuse_s4 = {
+	.bank = 0,
+	.start = 0x0c0,
+	.end = 0x14c,
+};
+
+static const struct rcar_fuse_data rcar_fuse_v4h = {
+	.bank = 1,
+	.start = 0x100,
+	.end = 0x1a0,
+};
+
+static const struct rcar_fuse_data rcar_fuse_v4m = {
+	.bank = 1,
+	.start = 0x100,
+	.end = 0x110,
+};
+
+static const struct of_device_id rcar_fuse_match[] = {
+	{ .compatible = "renesas,r8a779a0-efuse", .data = &rcar_fuse_v3u },
+	{ .compatible = "renesas,r8a779f0-efuse", .data = &rcar_fuse_s4 },
+	{ .compatible = "renesas,r8a779g0-otp", .data = &rcar_fuse_v4h },
+	{ .compatible = "renesas,r8a779h0-otp", .data = &rcar_fuse_v4m },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver rcar_fuse_driver = {
+	.probe = rcar_fuse_probe,
+	.driver = {
+		.name = "rcar_fuse",
+		.of_match_table = rcar_fuse_match,
+	},
+};
+module_platform_driver(rcar_fuse_driver);
+
+MODULE_DESCRIPTION("Renesas R-Car E-FUSE/OTP driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Geert Uytterhoeven");
-- 
2.25.1



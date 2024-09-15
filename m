Return-Path: <linux-kernel+bounces-329833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E12979681
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D629281A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 11:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDCD1C57B7;
	Sun, 15 Sep 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLrFdoBL"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3943BBEA;
	Sun, 15 Sep 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400702; cv=none; b=j4OA8nQ/eNLrQE2f2hquvAKH+kJ2KUc6SoiOujwPgy1IIUVVFQGF4A7a4gDSRcnCpLeTdt52ko8AP2GZf5BU8exG240emdFoR8xPz8O5UwrCJWn+g1sQND/KgXotqMpPRAnUyqDPDCOqpqwNVbtqMZgltyEXAv6Gt3pMzUtgGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400702; c=relaxed/simple;
	bh=7sptYmZNvN380n1kQpRiRyGhzcGMEaSyHh6jLXylY6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PnhClMDz16ar46I1iWXFmKauku4F/ilGcsnLp8XMtkfYLE0wSn4kpJyKzCGOUFZs7XOlWZdrGwryGaWf47VPBwrH3nM0jcWZYwzfNsienCiNuV7bQUOg+ugkThAYshOoPoZN+OCFIpJ1SKloWaHg+PFYa6rskuetmlk59EqCICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLrFdoBL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so484645366b.2;
        Sun, 15 Sep 2024 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726400699; x=1727005499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjYXEh+UbA9qfzH/UnBxzC6T1hiNz97xyypMsutGg+M=;
        b=FLrFdoBLq28PiuSMM9jKi9xsYrBlpNs3/7dRPb9Ghp2FLYHqeXh+B4/wEg/cOc+KFV
         TTonNgX1MvNtAbqvO8OhoaK+RWb/werEWVXbB8gKYHvfNYgOSHAtkB1gSdy6w8lh/xuO
         6USyEiYMkDCDPyIy6YeSk3KhWBzjFtOM1N058B11NwgE+lLQ1MtC57OiRWPlJXzHdavN
         ePdX5MfuR8LN6lpimSvLPttv1YRD7fngehpzzO/QwCCdDtVNwuYoRidu8HIox56o0dLn
         u89EoRR76SXEdzZ52KTNmRRUbJ+Y+WomsH9QHk/mPnMDVpviukcwEuHl3hY7SOpWiZNd
         BgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726400699; x=1727005499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjYXEh+UbA9qfzH/UnBxzC6T1hiNz97xyypMsutGg+M=;
        b=OnzDT8R/HOr4LijbFZc6ayMXiB68TkMbdwli2o4TNsJ33/yDDaG6o9xy1D1Xs5BGmw
         3aal5JzJ1ZyPUCysG70D4NUjYYG3vttlgdSvNo0X/nLhTkFwig0IsF/ZU+vwpqDqUjvK
         WGjsCcisKp2KULSSaH9uQN1jhZjc73Xf09uDvcc8jtOn5GBnWfOgjmbUbfhT2qFFDb9c
         N+14eg67AwFjrrHJ3X0qdDbKwt1ERFue8Y3X3qqNL2l0+OMSxKuUnJBBgb29PsSGaVXJ
         OeXlXOl5MgCMhVl1Zj5OHVZVX9P6BfkXlU2Nv1v6/oKXl9ckmeLuE9gSszHgWtctTcSe
         DkUg==
X-Forwarded-Encrypted: i=1; AJvYcCVZt1TQV1U5ISBETxDRTEZ92iclr7cEtimhjynH7vDygTTwLP7cAekBzusTb0D+dN7tTjQz0/RkfsDb2IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbE1K/f8D8JkVjqSOOb19KCD80pZwLUzF9FTkRWl5JO5connX
	js8Xr7KJ74BDm2olVxizh0hkh4qPHpLX3KwJvgNxqzglsxAhBbeX
X-Google-Smtp-Source: AGHT+IHXk4ugJxOP+KLW8R2DhUn7YJ4NYahM5A6lar/YmFVgn0iuSPe4lDkcPU3xD/66jrRtBCfWkQ==
X-Received: by 2002:a17:907:6096:b0:a8b:6ee7:ba26 with SMTP id a640c23a62f3a-a90294a88d5mr1357286266b.1.1726400699151;
        Sun, 15 Sep 2024 04:44:59 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109676esm188778266b.33.2024.09.15.04.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 04:44:58 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
X-Google-Original-From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] reset: add driver for imx8ulp SIM reset controller
Date: Sun, 15 Sep 2024 07:43:10 -0400
Message-Id: <20240915114311.75496-3-laurentiu.mihalcea@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com>
References: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain components can be reset via the SIM module.
Add reset controller driver for the SIM module to
allow drivers for said components to control the
reset signal(s).

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/Kconfig             |   7 ++
 drivers/reset/Makefile            |   1 +
 drivers/reset/reset-imx8ulp-sim.c | 106 ++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/reset/reset-imx8ulp-sim.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 5484a65f66b9..492081354d03 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -113,6 +113,13 @@ config RESET_IMX8MP_AUDIOMIX
 	help
 	  This enables the reset controller driver for i.MX8MP AudioMix
 
+config RESET_IMX8ULP_SIM
+	tristate "i.MX8ULP SIM Reset Driver"
+	depends on ARCH_MXC
+	help
+	  This enables the SIM (System Integration Module) reset driver
+	  for i.MX8ULP SoC.
+
 config RESET_INTEL_GW
 	bool "Intel Reset Controller Driver"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 4411a2a124d7..38354e701811 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_IMX8MP_AUDIOMIX) += reset-imx8mp-audiomix.o
+obj-$(CONFIG_RESET_IMX8ULP_SIM) += reset-imx8ulp-sim.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
 obj-$(CONFIG_RESET_K210) += reset-k210.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
diff --git a/drivers/reset/reset-imx8ulp-sim.c b/drivers/reset/reset-imx8ulp-sim.c
new file mode 100644
index 000000000000..04ff11d41e10
--- /dev/null
+++ b/drivers/reset/reset-imx8ulp-sim.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/of_platform.h>
+
+#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N	0
+#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N	1
+#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N	2
+
+#define IMX8ULP_SIM_RESET_NUM 3
+
+#define AVD_SIM_SYSCTRL0        0x8
+
+struct imx8ulp_sim_reset {
+	struct reset_controller_dev     rcdev;
+	struct regmap                   *regmap;
+};
+
+static const u32 imx8ulp_sim_reset_bits[IMX8ULP_SIM_RESET_NUM] = {
+	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N] = BIT(3),
+	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N] = BIT(4),
+	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N] = BIT(5),
+};
+
+static inline struct imx8ulp_sim_reset *
+to_imx8ulp_sim_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct imx8ulp_sim_reset, rcdev);
+}
+
+static int imx8ulp_sim_reset_assert(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
+	const u32 bit = imx8ulp_sim_reset_bits[id];
+
+	return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, 0);
+}
+
+static int imx8ulp_sim_reset_deassert(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
+	const u32 bit = imx8ulp_sim_reset_bits[id];
+
+	return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, bit);
+}
+
+static const struct reset_control_ops imx8ulp_sim_reset_ops = {
+	.assert         = imx8ulp_sim_reset_assert,
+	.deassert       = imx8ulp_sim_reset_deassert,
+};
+
+static const struct of_device_id imx8ulp_sim_reset_dt_ids[] = {
+	{ .compatible = "nxp,imx8ulp-avd-sim-reset", },
+	{ /* sentinel */ },
+};
+
+static int imx8ulp_sim_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx8ulp_sim_reset *simr;
+	int ret;
+
+	simr = devm_kzalloc(dev, sizeof(*simr), GFP_KERNEL);
+	if (!simr)
+		return -ENOMEM;
+
+	simr->regmap = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(simr->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(simr->regmap),
+				     "failed to get regmap\n");
+
+	simr->rcdev.owner = THIS_MODULE;
+	simr->rcdev.nr_resets = IMX8ULP_SIM_RESET_NUM;
+	simr->rcdev.ops = &imx8ulp_sim_reset_ops;
+	simr->rcdev.of_node = dev->of_node;
+
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		return ret;
+
+	return devm_reset_controller_register(dev, &simr->rcdev);
+}
+
+static struct platform_driver imx8ulp_sim_reset_driver = {
+	.probe  = imx8ulp_sim_reset_probe,
+	.driver = {
+		.name           = KBUILD_MODNAME,
+		.of_match_table = imx8ulp_sim_reset_dt_ids,
+	},
+};
+module_platform_driver(imx8ulp_sim_reset_driver);
+
+MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8ULP System Integration Module Reset driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1



Return-Path: <linux-kernel+bounces-335224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48BF97E2CD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31621C20974
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8C3D966;
	Sun, 22 Sep 2024 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNJZ7r3a"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718062AE9F;
	Sun, 22 Sep 2024 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727027013; cv=none; b=Zpr6/Wi+kCjCIrh6hJOJb9L82NZ5p+/tARORf8ixp0FW3UJa8XEboZisTlH2x/FLBjBss5EJzlTzszGYfucvX1U8GEPX5HTzNghqhAtKCFYV2+9M+cOHBoI+3rLHAgY0+hbnm7ratJgYEzNmpL4qo6HNKhxH+m4nF4+wnXYj22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727027013; c=relaxed/simple;
	bh=qvomAVsgjVquavMzr9zL9linzNKq+RaoPdejhXdE3WA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KFL75/Gkptf02a6rjp8Mkt0JdHQ0zcZ6XIJ1q/4xA59xv53R4ZA9j7yT4zewf78+DdQ2/yT5Zzq+eBJmsOqWWy5YQQ6KkOq/Y+dRc0xo6mKPQb3FjAfeywNUSrQF8Su9/cNybxruTfJsyIEzeQ235pqthxLH9rA2+XXG6U5VSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNJZ7r3a; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cafda818aso34530695e9.2;
        Sun, 22 Sep 2024 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727027010; x=1727631810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwzmLNpjWJRdVldJqN02tTMnPCndIPTBIEsSbyh7yKo=;
        b=PNJZ7r3acRygYGuFle9HG1nIPqDdF7etKNVY/GvRAo/OtBYmwnuiutA5mqynq6Vpdq
         TwdRC+1xor3+7CYDs6ae421xTUyFM1rm4i/R/3+/f9JunfWUXE5Ra8x6Vcnl1XgfZyWh
         Hp3wTqUo/V1rIzCmG3wqBy+/Fdpf1Bc4/U/zyeiKc9uD0YkVBo5s6elzSguTHlaJXsrh
         OlxGaeXpcLjK2Z7503WMyuyPjCvvXab1JJpCLJ2I0j2CaVxMb0bv7d4xrgQ+LJJh2fR2
         WxokWHYycgw4BRthhHG8gMAAep6Bo82JW2zk0TI8xv2Hut41kSAOEiXDqgsiOrsBDOVv
         Pxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727027010; x=1727631810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwzmLNpjWJRdVldJqN02tTMnPCndIPTBIEsSbyh7yKo=;
        b=unWqmVGcIAOxbpxv55iuKJgQFpkYYYqC54wF988SRYctVW/wIz6sW8qnoRKcclnvmh
         DSJbe/TonUS5YVD0hgiolZyFhhrlUCuxJjnxVooCfE7SqyVCPRMnX3wC0wcyKIyacj1F
         uzfV2ugeHfuVCZYQW4E/KalgvGXM7DZ/VZLvoSwVrocO3yVDjInYou3Fm0cJtRpbtY+l
         zoEQxp7V+g/9/XNLy1/NVROgNT6sCG1GkWyMzoebmRjYnLUxdC2EI2HiMtsaA6J3kFdf
         7errxTsExemq6gNaJ0NSzxmK4O1wefGMMWJjdb1ecHfxyU0Q/mw0dX75AoKm2f3nfRdJ
         0gUw==
X-Forwarded-Encrypted: i=1; AJvYcCUddxfAGiUHt+eMGw1gRKHFX48WAd1vtWZdjzug8+888oFizoa8YPzkS4nOERrPFO5bBUEHYbxn6EUsBuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6uit1oobYg9TY5H4NITq1SfmSr4U9JgTrqX4WQiCcTIMgD/a
	NuWKtNg0VqPOwtCbIvKZMvYpg7utKlTmQKMSNkgDu5giVtRZ254q
X-Google-Smtp-Source: AGHT+IGmf+SEoc4Nnw3sjCTGVuvVFiaxnZHqQwUZud8R56zHPcES+eUxclGIeTe0JCAzyU1BBYYN8w==
X-Received: by 2002:a5d:6947:0:b0:374:c040:b015 with SMTP id ffacd0b85a97d-37a43197c90mr4221315f8f.57.1727027009474;
        Sun, 22 Sep 2024 10:43:29 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ae60ad0sm80758535e9.1.2024.09.22.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 10:43:28 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
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
Subject: [PATCH v5 2/3] reset: add driver for imx8ulp SIM reset controller
Date: Sun, 22 Sep 2024 13:42:24 -0400
Message-Id: <20240922174225.75948-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240922174225.75948-1-laurentiumihalcea111@gmail.com>
References: <20240922174225.75948-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

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



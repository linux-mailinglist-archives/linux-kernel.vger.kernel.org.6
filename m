Return-Path: <linux-kernel+bounces-181570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EA58C7DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B95283B71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AE4158849;
	Thu, 16 May 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqJUv4vv"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E11586C0;
	Thu, 16 May 2024 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892094; cv=none; b=RJVIkPjNkt60LFvECAGCtdLu/1f+6crCJRnTNXhoWYr/wpXoyPLWCrRLgUXscsOkRBWtXgtEMOgdViDRGtFb8O+OZyNzah1aMI0sR4CoMR6mzh8ck/eIcVhEioVx3HSk7Yoe7MuUNlZECIWHFeH1Y7aTgIIPEsuXRSqNsa8sQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892094; c=relaxed/simple;
	bh=Fm8UmZPGCcL7w4efTvhgE4GkAB+5OARyNMPff6mb6Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFMZwkv4TMsX2MJyUO00G+8t/rNXAuy633bS947oLf6C5ms0D5Eq9SdM194+16JCtzfrec68r29hLev8T4A/P9nHEWQeKHx9B5rwnZpsx0aidIiG2jRMup/tZXc79vd9WBljq2I9y8ueG837R5gx4RvKapgQbDDdD4JvNO1uP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqJUv4vv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57342829409so5490606a12.1;
        Thu, 16 May 2024 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715892091; x=1716496891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWpEEFOjXdoKUDHUMaULzp8ujAfsObhxpkb6Hovmxkg=;
        b=aqJUv4vv70JbQEnKXBTBqkqdjHADLIkDj6Nn/oEyogwgpgtmPTjmzmnfP4bGg6/hlW
         l+Zf/RhT1HhUnNVp4rKl/S0HPUB8xbE6/deRgqtZbLC34uXp1NjTlGkRmDejfQotUjCQ
         AH3zFIpIMGq5zDb4PTrOM5QGMP8SD3Fkmt/+PgBSPGHYBB4r7BjImXb/X6tPNfc9kSA9
         8uNcpTQcH2o72WlFsBN3yRPdURvpbIkTbC/HAxEjGPPgt2iFDP/bPikZfk23RyIWai3w
         graEL0qoofMmfRROZ+m2/Ol0M0aiiEoCNL/2oPkbBUwQkkgay07ow/VPc0yaYNoC9Rds
         +u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715892091; x=1716496891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWpEEFOjXdoKUDHUMaULzp8ujAfsObhxpkb6Hovmxkg=;
        b=V6SroK+vfaXrb2v2UxKy7oNt49rPOkxvkVsly1PY1ZE9Gj6emrKBpMzdMXLwfMIkwD
         yIoYnaDHsGWwxvHRAtjf4R7C7D4v9XQVS/K7QOZBv1v4vHJIgyMaHwGkyzv7vNMLC6QM
         Srxo80Nqhl+6tSzhfFzILFRWLnGfZzEB5u22USINHaRhtZ9d4ruHNwn+gO+r5gzCM6p1
         i3UC1dMtU5MEcwrKbSapULEBWYQM1eWHD8ZXWZVTswblltJ8T5Z//pzwNOMc8HjyeCxx
         GVPldqoWlVh+2jpF0F8iDhqbcpd/LJwff6wGgGPEzey60rOiTfCPy2akJ2nIY3LlBWH0
         OZtw==
X-Forwarded-Encrypted: i=1; AJvYcCUSfhQ4Zlzd7lLExNZ62Cynq0IYVCT06pnUlXxo7XUdvkhr7Exwl1+q7wojhyly+G/xWB2fE8nCLOtYGdyqLsyyLJcDPwsEAMuxnmyZqfZvQR9P6LDRLC46YlXUMj+ws0car3t9DuqKlw==
X-Gm-Message-State: AOJu0YweIMK2mdy3mSZ3ngciRVhdsROW6EstE/ADF4FFb4hu8LAAo9xK
	l2jgbrDYasJ82am/LH9OAS9/rBmHhOwgX6exIH+ZfOC1j03Nredz1arMvV1h
X-Google-Smtp-Source: AGHT+IEQ9m7qotqrl3gagHyAMaFy47efeLvj+SXsKvIDBZoMlPip0ftICcEzfAI56MHtjIFGjuDv3g==
X-Received: by 2002:a05:6402:17d0:b0:574:d009:cb3c with SMTP id 4fb4d7f45d1cf-574d009ce2fmr9388979a12.18.1715892090707;
        Thu, 16 May 2024 13:41:30 -0700 (PDT)
Received: from localhost.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2b8f7fsm10859828a12.66.2024.05.16.13.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 13:41:30 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] reset: add driver for imx8ulp SIM reset controller
Date: Thu, 16 May 2024 23:40:29 +0300
Message-Id: <20240516204031.171920-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
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
 drivers/reset/Kconfig                         |  7 ++
 drivers/reset/Makefile                        |  1 +
 drivers/reset/reset-imx8ulp-sim.c             | 98 +++++++++++++++++++
 include/dt-bindings/reset/imx8ulp-sim-reset.h | 16 +++
 4 files changed, 122 insertions(+)
 create mode 100644 drivers/reset/reset-imx8ulp-sim.c
 create mode 100644 include/dt-bindings/reset/imx8ulp-sim-reset.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 85b27c42cf65..c1f4d9ebd0fd 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -91,6 +91,13 @@ config RESET_IMX7
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
 
+config RESET_IMX8ULP_SIM
+	tristate "i.MX8ULP SIM Reset Driver"
+	depends on ARCH_MXC
+	help
+	  This enables the SIM (System Integration Module) reset driver
+	  for the i.MX8ULP SoC.
+
 config RESET_INTEL_GW
 	bool "Intel Reset Controller Driver"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index fd8b49fa46fc..f257d6a41f1e 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
+obj-$(CONFIG_RESET_IMX8ULP_SIM) += reset-imx8ulp-sim.o
diff --git a/drivers/reset/reset-imx8ulp-sim.c b/drivers/reset/reset-imx8ulp-sim.c
new file mode 100644
index 000000000000..27923b9cd454
--- /dev/null
+++ b/drivers/reset/reset-imx8ulp-sim.c
@@ -0,0 +1,98 @@
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
+#include <dt-bindings/reset/imx8ulp-sim-reset.h>
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
+	simr->regmap = syscon_node_to_regmap(dev->of_node->parent);
+	if (IS_ERR(simr->regmap)) {
+		ret = PTR_ERR(simr->regmap);
+		dev_err(dev, "failed to get regmap: %d\n", ret);
+		return ret;
+	}
+
+	simr->rcdev.owner = THIS_MODULE;
+	simr->rcdev.nr_resets = IMX8ULP_SIM_RESET_NUM;
+	simr->rcdev.ops = &imx8ulp_sim_reset_ops;
+	simr->rcdev.of_node = dev->of_node;
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
diff --git a/include/dt-bindings/reset/imx8ulp-sim-reset.h b/include/dt-bindings/reset/imx8ulp-sim-reset.h
new file mode 100644
index 000000000000..a3cee0d60773
--- /dev/null
+++ b/include/dt-bindings/reset/imx8ulp-sim-reset.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
+#define DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
+
+#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N    0
+#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N    1
+#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N   2
+
+#define IMX8ULP_SIM_RESET_NUM                   3
+
+#endif /* DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H */
-- 
2.34.1



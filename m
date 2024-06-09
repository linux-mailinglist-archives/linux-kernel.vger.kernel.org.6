Return-Path: <linux-kernel+bounces-207364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776290162A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA56A1C20C62
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB0744369;
	Sun,  9 Jun 2024 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQI0qmxg"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED714315F;
	Sun,  9 Jun 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717938077; cv=none; b=P59SRfYAIWdWgmeqFv21Gr0KwaNhcTUdRl9l8OhKyIE80iCFMSq/E/nSMB/joAKk/560C26ac4lT1Qx0W1XggtYiGMCT5yohSUAxQ29Egi2XjJpaGE4ooqCAxslh5XOBMt45Q/EILMq7VDDb7ckdLo+MEJPX6WqqjYz/T4la4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717938077; c=relaxed/simple;
	bh=00/efm170rHixvXjsDdkmTJjaLFkiwwiwdlNwtJtkho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T75gi6spMsBu+jj+WuX8i6Ir+ClVAlHWcovo8m3Atpg2gkLCqKK9S9to0c3NfrTER4HsJMR8Rg/CEB63E9qcX8mqSSAv4JKdDfKVazZJaUT3eMks0SgfCTTZnCPDMvV+JGCrL3RTzJLbNiWNdJd2kE8rDm++b7m3E+X+A0MOIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQI0qmxg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a63359aaaa6so537067766b.2;
        Sun, 09 Jun 2024 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717938074; x=1718542874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roddXwv5d465/lxlFzMrZn0lrN/Jz4rrWHyGURYshMc=;
        b=LQI0qmxgM/SgjsmDGGtj1DgsduTImromPZbvifJQJuU+YrAmZ1oJ/sXEw2qDiOS0Bd
         h3wAUHYNPaHGmSUFJHhG+IFo1ZpeiOQ70U/zvnmIEMXDQC9MVsOyWqNubA0X3Hl/1Pq3
         hxScX4h1KOnfhMbT9c41f94lwlkq5o5H4KNmbc8QPF90Qk564t2CvKGK2cdJ4uRULnMs
         Tv4pAkFHi3hLrbR6F7V4TAi3VQvTWNCCoCjlWiA5AQ9rYhWCPb6CS2IPKlKC65bZGxMX
         ru19cXw/vVx0m1Bin4rhYn06JnriMtNDNIFR5SQDO8i4PNxg6e189g+16v+t8M6SwCmN
         ZDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717938074; x=1718542874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roddXwv5d465/lxlFzMrZn0lrN/Jz4rrWHyGURYshMc=;
        b=NH7oJklRx2fq95sWLxMIMxerGgteNoB98KpTfocmu0naeRS+DJnJBDPIoGDBN1avnW
         rChIw2dF8yVd/orKcdLoBF8H0JQgTkAhXv/o63IEMnDtJT21iDzXlf6DepZc6cv/sOjD
         7vcyRTl5ws8PiL1ruugC1izhk3MtwwXr5R4XrT7+hje9i8CJYS+0KXsB8JuRMwFqnaIi
         8pp7NctG7ziBbqLX9vD86T/8vPiNODH3WVfwHICMV9lF6eRLcElXd71PNI0d38H/DoH/
         riUsgN2rFYePB0TWPvvYjTIlCVk1STp/4Co0V0Kpi7n6zyD8JkGaACWkIzPy+n5w7b5E
         xxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Xhniyr3STmkmSdjhsyEzcIjjw71Fxvi4px109ZHrzA0Xe0vXGl785iwnKUNSuvvd7eGEwQ++PujRr9fcJLQ10Kazs4AyIrkUgYQ4eJ6jgDS8CVtlv4HEtv4xe4KzDWwb42LlJgEmNg==
X-Gm-Message-State: AOJu0YxX38J7NoXW+XMzpNbWn8Wsx9m4vpBnJpAUWZwNIO3y3Q69CRW4
	8IuCmUqYCUfTG4zTyABFLxTwFbhYdn+w2xovMXA3L+UoNlAyDVHZ
X-Google-Smtp-Source: AGHT+IGreRkBONukfacHwv3hN2S0XEX0TDLoo4NDkaB14N8SCtzAN4GtduaJrUVGiB3CjataKqHrAQ==
X-Received: by 2002:a17:906:1752:b0:a6e:facf:f982 with SMTP id a640c23a62f3a-a6efacffa1emr277059466b.23.1717938073841;
        Sun, 09 Jun 2024 06:01:13 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1841fceasm85961266b.70.2024.06.09.06.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 06:01:13 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] reset: add driver for imx8ulp SIM reset controller
Date: Sun,  9 Jun 2024 15:59:00 +0300
Message-Id: <20240609125901.76274-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240609125901.76274-1-laurentiumihalcea111@gmail.com>
References: <20240609125901.76274-1-laurentiumihalcea111@gmail.com>
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
 drivers/reset/Kconfig                         |   7 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-imx8ulp-sim.c             | 103 ++++++++++++++++++
 include/dt-bindings/reset/imx8ulp-sim-reset.h |  16 +++
 4 files changed, 127 insertions(+)
 create mode 100644 drivers/reset/reset-imx8ulp-sim.c
 create mode 100644 include/dt-bindings/reset/imx8ulp-sim-reset.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7112f5932609..9b3574a4f1c6 100644
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
+	  for i.MX8ULP SoC.
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
index 000000000000..d1b9511a5c6a
--- /dev/null
+++ b/drivers/reset/reset-imx8ulp-sim.c
@@ -0,0 +1,103 @@
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
+#include <linux/of_platform.h>
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
diff --git a/include/dt-bindings/reset/imx8ulp-sim-reset.h b/include/dt-bindings/reset/imx8ulp-sim-reset.h
new file mode 100644
index 000000000000..9f8fb8680a5e
--- /dev/null
+++ b/include/dt-bindings/reset/imx8ulp-sim-reset.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef DT_BINDINGS_RESET_IMX8ULP_SIM_H
+#define DT_BINDINGS_RESET_IMX8ULP_SIM_H
+
+#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N    0
+#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N    1
+#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N   2
+
+#define IMX8ULP_SIM_RESET_NUM                   3
+
+#endif /* DT_BINDINGS_RESET_IMX8ULP_SIM_H */
-- 
2.34.1



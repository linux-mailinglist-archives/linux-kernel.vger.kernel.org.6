Return-Path: <linux-kernel+bounces-252844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCC9318BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95522B228AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2484D8B9;
	Mon, 15 Jul 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6zz9VZh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FDA481CD;
	Mon, 15 Jul 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062007; cv=none; b=txbW6PkbR1A2TamDfYmsnUfxeke0wRzVzLbh0yBWtZKwHhTNT9bvs9m4IeotK48MoetJh4sbMT2x4+FC9h/pIDqZ0LV2CXbyh1McbI5JhImhO+/wBXIdl1CvkCtG5AXpigklucJX4gbjTa/fOO4LlDILOeCP9jWUyTCAQrXHoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062007; c=relaxed/simple;
	bh=2i9fi87fwGI/U7ZIjVQcpIYrxTU8HgNTEMUHbWJFl6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYak6d/uWl3oXUlEEWEcjynVPDGhp1eBYcUXNrbAOMNUk6Pjo19nR61OBa1zg9s4T9d75KVhZqSZqplboy0ChcSAO26V2304gPQO2mC9FS5P7gtVwmbvAqWvzKnQWhsm7VEhOSy9HyidWtpODbnsvm/Hgs3tDH3MYJQZN+Zw9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6zz9VZh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266edee10cso28567795e9.2;
        Mon, 15 Jul 2024 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721062003; x=1721666803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh6JZ+1LYv7M2Ni3seuv4GEQ7MYtjKnioH0Jix8Ipz0=;
        b=m6zz9VZhCWymvQGWnmekuHfL4e6ay4f+m8c3zErzmyYW1CbL7W45lIuUFTTXMnxK77
         QkVmkoCFbrdp9IJuCjCtCaggavbH2i2bf0Ke+HLF777hpgwXDS39/Nwc2sIhCfDb/Vi0
         TlOG5AGwL4gVwcL0gb6nZpBfCrimD/tTZnTfe892aZS2vr7/Y92Gr5TxGFgUQ3ka2vgy
         SQqyfKJAN1Z1l2LC/QdacH/ZG6oGkn5d9EOmyKmAWyo+4prw/9V0UAN5mkaVaRH8P8CJ
         N6MoRZI+sWR1/tJHrrxfXfflIEIrHvEJyXMxW8dQEb002/7lKWSQrvVTjDOWo9jl/vcv
         b6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062003; x=1721666803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jh6JZ+1LYv7M2Ni3seuv4GEQ7MYtjKnioH0Jix8Ipz0=;
        b=M3kOynhWXi59hnxak4RurksEsLbaZKiNzq3F3bYf2p9g4cMC0gIoT/Hwel/hewLqjW
         wu5g0tcdbfRCwR6165xER2NIKf5nzjQR1vDTLYxyf69I9jWpoB5C2kiwG4URuJtLVApW
         uUgkybgH1S904Fcv6l1C7Pl4tgxjWIizdXW5xmvPShFlLpnrH1VCSzVuz+9A2uiZwhlr
         TO0b2DCORn7hDqNy4k3IStqnYM2EP0Gdf0W3ulKSjfz1fthoJhlgpuHrmljshyg+o05D
         MShY9wGZVJG3XXG0WHNBeWdFbujJJop/+M2ZFZjvUPOkkmQgdz6x8/CafypQhfJWEAjR
         df5g==
X-Forwarded-Encrypted: i=1; AJvYcCWfpawQIewR4RomUDdnGizoWydsPCH/kE1/mdLdIMFfASe7aWwOV2hzVW2M1ZsoMiO9joVmab79kcPDNwilWY9S+tnN1gU14kfj4cIo
X-Gm-Message-State: AOJu0YwCiRp5j3Ph41JXblqJWHx7nYdvdZ8jD7WqbV3kRqBXoh81Fsr0
	lsHnSCzYeAJv7RjdwXp0Nv8gah8FPbdF2HLdL4bAhwOqKxUHwsFW
X-Google-Smtp-Source: AGHT+IEr6cCHa9wTd0C+ds1nssosgD28+7x4wtLWpAatjKXHXE7WHF1w1QpLnGh9WYZlFn6Fb/QL9g==
X-Received: by 2002:a05:600c:1911:b0:426:5dd0:a1fc with SMTP id 5b1f17b1804b1-427b88d00f5mr1337135e9.34.1721062003548;
        Mon, 15 Jul 2024 09:46:43 -0700 (PDT)
Received: from playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e7749esm94316975e9.2.2024.07.15.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:46:43 -0700 (PDT)
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
Subject: [PATCH v3 2/3] reset: add driver for imx8ulp SIM reset controller
Date: Mon, 15 Jul 2024 12:45:13 -0400
Message-Id: <20240715164514.8718-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715164514.8718-1-laurentiumihalcea111@gmail.com>
References: <20240715164514.8718-1-laurentiumihalcea111@gmail.com>
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
index 67bce340a87e..8e9cbf2859d6 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -100,6 +100,13 @@ config RESET_IMX8MP_AUDIOMIX
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
index 27b0bbdfcc04..685e08982283 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
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



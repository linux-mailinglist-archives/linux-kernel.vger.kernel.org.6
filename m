Return-Path: <linux-kernel+bounces-547694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A6DA50C76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D601714EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E97D256C63;
	Wed,  5 Mar 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/h0/K21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FD17B50B;
	Wed,  5 Mar 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206405; cv=none; b=jV7U1EUVQm7NAKQ1tIDev7x/+oX/1Z632WvywAF9ltPfKAFSYdXWz8pH6GoiIGE5lroymlmM3TRNxbeUsp4LpZeFP4iGjyXoIv8z06RFwYS/w7QYundoopcO4eWHpGbs0mvsMd1rYIbknOzvMj22cuFvGOKaAXzzlW24DfuJPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206405; c=relaxed/simple;
	bh=Y+Si40H9xvWW0NrdR4yM4VReyGwc5L82H6rUoRcB3Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRIYa/Vdtfjmi3uTBrC1nRXSlXY8Ib+UGddAdv5gcr/DlhODRDdIuxJo93Q4fCG4qULvUHzSUtRKFrvgPvCFEi5tWmSdbKVH4wSsUpFUL0/xnbIAfTCVT8PxYy081rrrE5CfOlyb+Nozi+cCSlL4lAXKa8sVfBQQPksvioP0ljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/h0/K21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C52AC4CEE0;
	Wed,  5 Mar 2025 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741206405;
	bh=Y+Si40H9xvWW0NrdR4yM4VReyGwc5L82H6rUoRcB3Vo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M/h0/K21t75bfCjSagqoaN9u2XSZqYSbEy70L436keqQWryiGVdPYjsjbLXRwGvZf
	 VC90WXIu3Bm3uso5B93l26rY5zZwFrTO1v921zmpbWeC3l47G2NvVu/xY56PvyS9XU
	 yNFiMpYz/YG9LSS1ERcA45gmce2bGgiXht4tTqtiRR29YB1j1HRua7wtDuewwmQBsG
	 lppH3qiqwJRhgRTLZH/yFZlk2z8+Kr1N3TSHWTZq4wiUbOhjoIr7071oe2NUWSaLXc
	 C3zgx8HyZBveGhx5JV6zYWv/RSdmaq5omFoVmT5xUTOJFFeDsaigob8Cyj03KnMvGU
	 OAIiabjk7zNOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6A2C282EC;
	Wed,  5 Mar 2025 20:26:45 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 05 Mar 2025 21:26:40 +0100
Subject: [PATCH 2/3] spmi: add a spmi driver for Apple SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-spmi-v1-2-c98f561fa99f@gmail.com>
References: <20250305-spmi-v1-0-c98f561fa99f@gmail.com>
In-Reply-To: <20250305-spmi-v1-0-c98f561fa99f@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, 
 Jean-Francois Bortolotti <jeff@borto.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741206403; l=7051;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=rJ1vd9Iyd4gHu+jjWDpOWXoACMXfatLFKEyKY06WpWo=;
 b=sSgqnZA+YPk4BKHtpSDkTabZcZg+dilCxAqkFglzGcLhilQ5/ZrxlYTTgPef7EKr1Ko7H8G5Y
 ZQDIr7nhEIaCA0NdE7t0PICYTMqVX0CpiNN0Lj33U4x61h6317TNz6w
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Jean-Francois Bortolotti <jeff@borto.fr>

Signed-off-by: Jean-Francois Bortolotti <jeff@borto.fr>
Co-developed-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS                          |   1 +
 drivers/spmi/Kconfig                 |   8 ++
 drivers/spmi/Makefile                |   1 +
 drivers/spmi/spmi-apple-controller.c | 176 +++++++++++++++++++++++++++++++++++
 4 files changed, 186 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 271ff8110df83c2d4fe7fbbfffc0a72259460bc5..9006695261d29fbc1e15659c2b43d7afeee0b656 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2254,6 +2254,7 @@ F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
 F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
+F:	drivers/spmi/spmi-apple-controller.c
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 F:	include/dt-bindings/pinctrl/apple.h
diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index 73780204631463631cabcbad5bf83e8dbbee94ce..9005fa91d9f4e541403ccc7bf84e0592402ac41e 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -11,6 +11,14 @@ menuconfig SPMI
 
 if SPMI
 
+config SPMI_APPLE
+	tristate "Apple SoC SPMI Controller platform driver"
+	depends on ARCH_APPLE || COMPILE_TEST
+	help
+	  If you say yes to this option, support will be included for the
+	  SPMI controller present on many Apple SoCs, including the
+	  t8103 (M1) and t600x (M1 Pro/Max).
+
 config SPMI_HISI3670
 	tristate "Hisilicon 3670 SPMI Controller"
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 7f152167bb05b2c24a0f9669f60278152898eebb..38ac635645ba65aa46cb5e8a50072ed9771e229b 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -4,6 +4,7 @@
 #
 obj-$(CONFIG_SPMI)	+= spmi.o spmi-devres.o
 
+obj-$(CONFIG_SPMI_APPLE)	+= spmi-apple-controller.o
 obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
 obj-$(CONFIG_SPMI_MSM_PMIC_ARB)	+= spmi-pmic-arb.o
 obj-$(CONFIG_SPMI_MTK_PMIF)	+= spmi-mtk-pmif.o
diff --git a/drivers/spmi/spmi-apple-controller.c b/drivers/spmi/spmi-apple-controller.c
new file mode 100644
index 0000000000000000000000000000000000000000..194fa5dd7c2c6fc4ecfbee0db7930b0c73b02550
--- /dev/null
+++ b/drivers/spmi/spmi-apple-controller.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Apple SoC SPMI device driver
+ *
+ * Copyright The Asahi Linux Contributors
+ *
+ * Inspired by:
+ *		OpenBSD support Copyright (c) 2021 Mark Kettenis <kettenis@openbsd.org>
+ *		Correllium support Copyright (C) 2021 Corellium LLC
+ *		hisi-spmi-controller.c
+ *		spmi-pmic-ard.c Copyright (c) 2021, The Linux Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/spmi.h>
+
+/* SPMI Controller Registers */
+#define SPMI_STATUS_REG 0
+#define SPMI_CMD_REG 0x4
+#define SPMI_RSP_REG 0x8
+
+#define SPMI_RX_FIFO_EMPTY BIT(24)
+
+#define REG_POLL_INTERVAL 10000
+#define REG_POLL_TIMEOUT (REG_POLL_INTERVAL * 5)
+
+struct apple_spmi {
+	void __iomem *regs;
+};
+
+#define poll_reg(spmi, reg, val, cond) \
+	readl_relaxed_poll_timeout((spmi)->regs + (reg), (val), (cond), \
+				   REG_POLL_INTERVAL, REG_POLL_TIMEOUT)
+
+static inline u32 read_reg(struct apple_spmi *spmi, int offset)
+{
+	return readl_relaxed(spmi->regs + offset);
+}
+
+static inline void write_reg(u32 value, struct apple_spmi *spmi, int offset)
+{
+	writel_relaxed(value, spmi->regs + offset);
+}
+
+static int spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+			 u16 saddr, u8 *__buf, size_t bc)
+{
+	struct apple_spmi *spmi = spmi_controller_get_drvdata(ctrl);
+	u32 spmi_cmd = opc | sid << 8 | saddr << 16 | (bc - 1) | (1 << 15);
+	u32 rsp;
+	u32 status;
+	size_t len_to_read = 0;
+	u8 i;
+	int ret;
+
+	write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
+
+	/* Wait for Rx FIFO to have something */
+	ret = poll_reg(spmi, SPMI_STATUS_REG, status, !(status & SPMI_RX_FIFO_EMPTY));
+	if (ret) {
+		dev_err(&ctrl->dev,
+			"%s:Failed to wait for RX FIFO not empty\n", __func__);
+		return ret;
+	}
+
+	/* Discard SPMI reply status */
+	read_reg(spmi, SPMI_RSP_REG);
+
+	/* Read SPMI data reply */
+	while (len_to_read < bc) {
+		rsp = read_reg(spmi, SPMI_RSP_REG);
+		i = 0;
+		while ((len_to_read < bc) && (i < 4)) {
+			__buf[len_to_read++] = ((0xff << (8 * i)) & rsp) >>
+					       (8 * i);
+			i += 1;
+		}
+	}
+
+	return 0;
+}
+
+static int spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+			  u16 saddr, const u8 *__buf, size_t bc)
+{
+	struct apple_spmi *spmi = spmi_controller_get_drvdata(ctrl);
+	u32 spmi_cmd = opc | sid << 8 | saddr << 16 | (bc - 1) | (1 << 15);
+	u32 status;
+	size_t i = 0, j;
+	int ret;
+
+	write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
+
+	while (i < bc) {
+		j = 0;
+		spmi_cmd = 0;
+		while ((j < 4) & (i < bc))
+			spmi_cmd |= __buf[i++] << (j++ * 8);
+
+		write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
+	}
+
+	/* Wait for Rx FIFO to have something */
+	ret = poll_reg(spmi, SPMI_STATUS_REG, status, !(status & SPMI_RX_FIFO_EMPTY));
+	if (ret) {
+		dev_err(&ctrl->dev,
+			"%s:Failed to wait for RX FIFO not empty\n", __func__);
+		return ret;
+	}
+
+	/* Discard */
+	read_reg(spmi, SPMI_RSP_REG);
+
+	return 0;
+}
+
+static int spmi_controller_probe(struct platform_device *pdev)
+{
+	struct apple_spmi *spmi;
+	struct spmi_controller *ctrl;
+	int ret;
+
+	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*spmi));
+	if (IS_ERR(ctrl)) {
+		dev_err_probe(&pdev->dev, PTR_ERR(ctrl),
+			      "Can't allocate spmi_controller data\n");
+		return -ENOMEM;
+	}
+
+	spmi = spmi_controller_get_drvdata(ctrl);
+
+	spmi->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(spmi->regs)) {
+		dev_err_probe(&pdev->dev, PTR_ERR(spmi->regs),
+			      "Can't get ioremap regs\n");
+		return PTR_ERR(spmi->regs);
+	}
+
+	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
+
+	ctrl->read_cmd = spmi_read_cmd;
+	ctrl->write_cmd = spmi_write_cmd;
+
+	ret = devm_spmi_controller_add(&pdev->dev, ctrl);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"spmi_controller_add failed with error %d!\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id spmi_controller_match_table[] = {
+	{ .compatible = "apple,spmi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spmi_controller_match_table);
+
+static struct platform_driver spmi_controller_driver = {
+	.probe		= spmi_controller_probe,
+	.driver		= {
+		.name	= "apple-spmi",
+		.of_match_table = spmi_controller_match_table,
+	},
+};
+module_platform_driver(spmi_controller_driver);
+
+MODULE_AUTHOR("Jean-Francois Bortolotti <jeff@borto.fr>");
+MODULE_DESCRIPTION("Apple SoC SPMI driver");
+MODULE_LICENSE("GPL");

-- 
2.48.1




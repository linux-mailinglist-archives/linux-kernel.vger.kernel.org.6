Return-Path: <linux-kernel+bounces-252414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A58259312C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DEEB22858
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6C0189F46;
	Mon, 15 Jul 2024 11:04:17 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA95187321;
	Mon, 15 Jul 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041457; cv=none; b=Z7/VAlBs3dE4kkHxfJ/wopl4rfl4M+rjHfDBU/jr4xmdDm2h2mS/bsSmQWruBUlpFK5KkvLHQwwXKdKjsq4HZUwR9ZBqlvyCrklT0TEOiS4iE17UFXWWxgAkjtSpKziOtWg2Kr+K1Rbw3+j1oWrvM729e0oeXA2/tGU7IaPIBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041457; c=relaxed/simple;
	bh=ouJC+8gRTfBbj5yxuVUTwSQl4xfN0ySlsCOV6/pgvts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8KkA92nxvUSwPbLXblEjSysswOatIJGf4J1CBf8QspBQQmSBq+/MFiBeycRkR5OYxA4NEEHd+fhLTaKivfbRuAvtAFgZY00VUynsdgJar7bvouZK8j7bpdBnzahSscVr1X8WepN+uvYQySdeFilnlrDOhK+U3LxGP/Cnwa1k78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sTJV4-0006GM-5V; Mon, 15 Jul 2024 13:04:10 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/3] clk: add driver for voltage controlled oscillators
Date: Mon, 15 Jul 2024 13:02:50 +0200
Message-Id: <20240715110251.261844-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240715110251.261844-1-heiko@sntech.de>
References: <20240715110251.261844-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In contrast to fixed clocks that are described as ungateable, boards
sometimes use additional oscillators for things like PCIe reference
clocks, that need actual supplies to get enabled and enable-gpios to be
toggled for them to work.

This adds a driver for those generic voltage controlled oscillators,
that can show up in schematics looking like

         ----------------
Enable - | 100MHz,3.3V, | - VDD
         |    3225      |
   GND - |              | - OUT
         ----------------

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/Kconfig   |  10 ++++
 drivers/clk/Makefile  |   1 +
 drivers/clk/clk-vco.c | 133 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/clk/clk-vco.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3e9099504fad4..e93a380b6ee47 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -414,6 +414,16 @@ config COMMON_CLK_VC7
 	  Renesas Versaclock7 is a family of configurable clock generator
 	  and jitter attenuator ICs with fractional and integer dividers.
 
+config COMMON_CLK_VCO
+	tristate "Clock driver for voltage controlled oscillators"
+	depends on GPIOLIB && REGULATOR
+	help
+	  This driver supports generic voltage controlled oscillators that
+	  are not configurable but need supplies to be enabled to run.
+	  Generally they need a supply voltage to be enabled and may also
+	  require a separate enable pin, though in a lot of cases, vdd
+	  and enable control might be tied to the same supply.
+
 config COMMON_CLK_STM32F
 	def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746)
 	help
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4abe16c8ccdfe..ca7b7b7ddfd8d 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_COMMON_CLK_SI521XX)	+= clk-si521xx.o
 obj-$(CONFIG_COMMON_CLK_VC3)		+= clk-versaclock3.o
 obj-$(CONFIG_COMMON_CLK_VC5)		+= clk-versaclock5.o
 obj-$(CONFIG_COMMON_CLK_VC7)		+= clk-versaclock7.o
+obj-$(CONFIG_COMMON_CLK_VCO)		+= clk-vco.o
 obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
 obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 
diff --git a/drivers/clk/clk-vco.c b/drivers/clk/clk-vco.c
new file mode 100644
index 0000000000000..f7fe2bc627f36
--- /dev/null
+++ b/drivers/clk/clk-vco.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Heiko Stuebner <heiko@sntech.de>
+ *
+ * Generic voltage controlled oscillator
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+struct clk_vco {
+	struct device *dev;
+	struct clk_hw hw;
+	u32 rate;
+	struct regulator *supply;
+	struct gpio_desc *enable_gpio;
+};
+
+#define to_clk_vco(_hw) container_of(_hw, struct clk_vco, hw)
+
+static int clk_vco_prepare(struct clk_hw *hw)
+{
+	return regulator_enable(to_clk_vco(hw)->supply);
+}
+
+static void clk_vco_unprepare(struct clk_hw *hw)
+{
+	regulator_disable(to_clk_vco(hw)->supply);
+}
+
+static int clk_vco_enable(struct clk_hw *hw)
+{
+	gpiod_set_value(to_clk_vco(hw)->enable_gpio, 1);
+	return 0;
+}
+
+static void clk_vco_disable(struct clk_hw *hw)
+{
+	gpiod_set_value(to_clk_vco(hw)->enable_gpio, 0);
+}
+
+static unsigned long clk_vco_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	return to_clk_vco(hw)->rate;
+}
+
+const struct clk_ops clk_vco_ops = {
+	.prepare = clk_vco_prepare,
+	.unprepare = clk_vco_unprepare,
+	.enable = clk_vco_enable,
+	.disable = clk_vco_disable,
+	.recalc_rate = clk_vco_recalc_rate,
+};
+
+static int clk_vco_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct clk_vco *clkgen;
+	const char *clk_name;
+	int ret;
+
+	clkgen = devm_kzalloc(dev, sizeof(*clkgen), GFP_KERNEL);
+	if (!clkgen)
+		return -ENOMEM;
+
+	clkgen->dev = dev;
+
+	if (device_property_read_u32(dev, "clock-frequency", &clkgen->rate))
+		return dev_err_probe(dev, -EIO, "failed to get clock-frequency");
+
+	ret = device_property_read_string(dev, "clock-output-names", &clk_name);
+	if (ret)
+		clk_name = fwnode_get_name(dev->fwnode);
+
+	clkgen->supply = devm_regulator_get_optional(dev, "vdd");
+	if (IS_ERR(clkgen->supply)) {
+		if (PTR_ERR(clkgen->supply) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(clkgen->supply),
+					     "failed to get regulator\n");
+		clkgen->supply = NULL;
+	}
+
+	clkgen->enable_gpio = devm_gpiod_get_optional(dev, "enable",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(clkgen->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(clkgen->enable_gpio),
+				     "failed to get gpio\n");
+
+	ret = gpiod_direction_output(clkgen->enable_gpio, 0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to set gpio output");
+
+	clkgen->hw.init = CLK_HW_INIT_NO_PARENT(clk_name, &clk_vco_ops, 0);
+
+	/* register the clock */
+	ret = devm_clk_hw_register(dev, &clkgen->hw);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register clock\n");
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					  &clkgen->hw);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register clock provider\n");
+
+	return 0;
+}
+
+static const struct of_device_id clk_vco_ids[] = {
+	{ .compatible = "voltage-oscillator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clk_vco_ids);
+
+static struct platform_driver clk_vco_driver = {
+	.driver = {
+		.name = "clk_vco",
+		.of_match_table = clk_vco_ids,
+	},
+	.probe = clk_vco_probe,
+};
+module_platform_driver(clk_vco_driver);
+
+MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
+MODULE_DESCRIPTION("Voltage controlled oscillator driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2



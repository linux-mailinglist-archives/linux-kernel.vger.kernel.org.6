Return-Path: <linux-kernel+bounces-318439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62896EDE3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6FB1C234A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FD915A863;
	Fri,  6 Sep 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rRlDaVqZ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E015854A;
	Fri,  6 Sep 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611124; cv=none; b=Z5FqSIkoJb/wDrjjf33tv4Zi7kE3SA3XfOxyowjYpakNntoIHS7hVS5/4sXp1kNW1zmeX6utJnDRsrc2rIIg81VkaG2pFZ8s/LBwvE5kSwrHt4ViMALvWgOVx0pq3E5U27Z+aILAhbrAOuRyshUlivxMn0nuv/ccwPAqNAuia+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611124; c=relaxed/simple;
	bh=tRdRr/QErLxG9jQmLJyDACsa3C73d3fuYxjKJe56PEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5k353oHuc7e2Luo1VDaf9acpxSS6OObaWOvqPU+Tr0XEAepBFCEDMLDhcMKNRUOPZpZx4K8YFRGaKY717rPcVlb3Vx+8Az4dFp+gWiZpAOBEJ3pjVf9whaAORYw8PfJl+magwh1Pj2UMMUKlNXxi6hmAyfrxPc/V9T8WPJJJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rRlDaVqZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iUDhu/ZGJnFLW++ZXEMrIwbiwMU6+cDB7edRKWs0gRc=; b=rRlDaVqZmUA8QNc0SgcyJqCyzs
	+U3L9pI/eCeaplP8s8RhSe+i0T2uZEpvjwmqgwaJ7ykTtac3fsW2EP8zlMKT8hmYIxnZ0TCR9Fg2O
	hGEMqvbzQsFQ2RrBJYuhL0f1Tq4KxuXpfSsQQLK1DzM8+sRFKr7QukejhKE4Hln23FextEJnK/PiQ
	eg6X3jdQlkf/yqCsWGN7Vt+7Zr4M3UUjWh0JRczogoJEmdBzEvpZxlz3UEIBVX0EHQmU+f4FXY1mM
	uShjs2ykBi2HCJhZxy30JsCWKiPIUcIfxc+hdvMysbIk3kJTPZxnRPLlnlqtSOGr6i1frg0UonRhp
	uzoy/+cA==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1smUHQ-0000jF-Al; Fri, 06 Sep 2024 10:25:20 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v4 4/5] clk: clk-gpio: add driver for gated-fixed-clocks
Date: Fri,  6 Sep 2024 10:25:10 +0200
Message-ID: <20240906082511.2963890-5-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906082511.2963890-1-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de>
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

This adds a driver for those generic gated-fixed-clocks
that can show up in schematics looking like

         ----------------
Enable - | 100MHz,3.3V, | - VDD
         |    3225      |
   GND - |              | - OUT
         ----------------

The new driver gets grouped together with the existing gpio-gate and
gpio-mux, as it for one re-uses a lot of the gpio-gate functions
and also in its core it's just another gpio-controlled clock, just
with a fixed rate and a regulator-supply added in.

The regulator-API provides function stubs for the !CONFIG_REGULATOR case,
so no special handling is necessary.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-gpio.c | 186 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index cda362a2eca0..3a215f91ad55 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 /**
  * DOC: basic gpio gated clock which can be enabled and disabled
@@ -239,3 +240,188 @@ static struct platform_driver gpio_clk_driver = {
 	},
 };
 builtin_platform_driver(gpio_clk_driver);
+
+/**
+ * DOC: gated fixed clock, controlled with a gpio output and a regulator
+ * Traits of this clock:
+ * prepare - clk_prepare and clk_unprepare are function & control regulator
+ *           optionally a gpio that can sleep
+ * enable - clk_enable and clk_disable are functional & control gpio
+ * rate - rate is fixed and set on clock registration
+ * parent - fixed clock is a root clock and has no parent
+ */
+
+/**
+ * struct clk_gate_fixed - gated-fixed-clock
+ *
+ * clk_gpio:	instance of clk_gpio for gate-gpio
+ * supply:	supply regulator
+ * rate:	fixed rate
+ */
+struct clk_gated_fixed {
+	struct clk_gpio clk_gpio;
+	struct regulator *supply;
+	unsigned long rate;
+};
+
+#define to_clk_gated_fixed(_clk_gpio) container_of(_clk_gpio, struct clk_gated_fixed, clk_gpio)
+
+static unsigned long clk_gated_fixed_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	return to_clk_gated_fixed(to_clk_gpio(hw))->rate;
+}
+
+static int clk_gated_fixed_prepare(struct clk_hw *hw)
+{
+	struct clk_gated_fixed *clk = to_clk_gated_fixed(to_clk_gpio(hw));
+
+	if (!clk->supply)
+		return 0;
+
+	return regulator_enable(clk->supply);
+}
+
+static void clk_gated_fixed_unprepare(struct clk_hw *hw)
+{
+	struct clk_gated_fixed *clk = to_clk_gated_fixed(to_clk_gpio(hw));
+
+	if (!clk->supply)
+		return;
+
+	regulator_disable(clk->supply);
+}
+
+static int clk_gated_fixed_is_prepared(struct clk_hw *hw)
+{
+	struct clk_gated_fixed *clk = to_clk_gated_fixed(to_clk_gpio(hw));
+
+	if (!clk->supply)
+		return true;
+
+	return regulator_is_enabled(clk->supply);
+}
+
+/*
+ * Fixed gated clock with non-sleeping gpio.
+ *
+ * Prepare operation turns on the supply regulator
+ * and the enable operation switches the enable-gpio.
+ */
+static const struct clk_ops clk_gated_fixed_ops = {
+	.prepare = clk_gated_fixed_prepare,
+	.unprepare = clk_gated_fixed_unprepare,
+	.is_prepared = clk_gated_fixed_is_prepared,
+	.enable = clk_gpio_gate_enable,
+	.disable = clk_gpio_gate_disable,
+	.is_enabled = clk_gpio_gate_is_enabled,
+	.recalc_rate = clk_gated_fixed_recalc_rate,
+};
+
+static int clk_sleeping_gated_fixed_prepare(struct clk_hw *hw)
+{
+	int ret;
+
+	ret = clk_gated_fixed_prepare(hw);
+	if (ret)
+		return ret;
+
+	ret = clk_sleeping_gpio_gate_prepare(hw);
+	if (ret)
+		clk_gated_fixed_unprepare(hw);
+
+	return ret;
+}
+
+static void clk_sleeping_gated_fixed_unprepare(struct clk_hw *hw)
+{
+	clk_gated_fixed_unprepare(hw);
+	clk_sleeping_gpio_gate_unprepare(hw);
+}
+
+/*
+ * Fixed gated clock with non-sleeping gpio.
+ *
+ * Enabling the supply regulator and switching the enable-gpio happens
+ * both in the prepare step.
+ * is_prepared only needs to check the gpio state, as toggling the
+ * gpio is the last step when preparing.
+ */
+static const struct clk_ops clk_sleeping_gated_fixed_ops = {
+	.prepare = clk_sleeping_gated_fixed_prepare,
+	.unprepare = clk_sleeping_gated_fixed_unprepare,
+	.is_prepared = clk_sleeping_gpio_gate_is_prepared,
+	.recalc_rate = clk_gated_fixed_recalc_rate,
+};
+
+static int clk_gated_fixed_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct clk_gated_fixed *clk;
+	const struct clk_ops *ops;
+	const char *clk_name;
+	u32 rate;
+	int ret;
+
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+	ret = device_property_read_u32(dev, "clock-frequency", &rate);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get clock-frequency\n");
+	clk->rate = rate;
+
+	ret = device_property_read_string(dev, "clock-output-names", &clk_name);
+	if (ret)
+		clk_name = fwnode_get_name(dev->fwnode);
+
+	clk->supply = devm_regulator_get_optional(dev, "vdd");
+	if (IS_ERR(clk->supply)) {
+		if (PTR_ERR(clk->supply) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(clk->supply),
+					     "Failed to get regulator\n");
+		clk->supply = NULL;
+	}
+
+	clk->clk_gpio.gpiod = devm_gpiod_get_optional(dev, "enable",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(clk->clk_gpio.gpiod))
+		return dev_err_probe(dev, PTR_ERR(clk->clk_gpio.gpiod),
+				     "Failed to get gpio\n");
+
+	if (gpiod_cansleep(clk->clk_gpio.gpiod))
+		ops = &clk_sleeping_gated_fixed_ops;
+	else
+		ops = &clk_gated_fixed_ops;
+
+	clk->clk_gpio.hw.init = CLK_HW_INIT_NO_PARENT(clk_name, ops, 0);
+
+	/* register the clock */
+	ret = devm_clk_hw_register(dev, &clk->clk_gpio.hw);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register clock\n");
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					  &clk->clk_gpio.hw);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register clock provider\n");
+
+	return 0;
+}
+
+static const struct of_device_id gated_fixed_clk_match_table[] = {
+	{ .compatible = "gated-fixed-clock" },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver gated_fixed_clk_driver = {
+	.probe		= clk_gated_fixed_probe,
+	.driver		= {
+		.name	= "gated-fixed-clk",
+		.of_match_table = gated_fixed_clk_match_table,
+	},
+};
+builtin_platform_driver(gated_fixed_clk_driver);
-- 
2.43.0



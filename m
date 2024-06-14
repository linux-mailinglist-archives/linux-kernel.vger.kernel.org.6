Return-Path: <linux-kernel+bounces-214436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19463908468
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DD91F25C31
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06336184107;
	Fri, 14 Jun 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hbzZce1l"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB18183094
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718349600; cv=none; b=JNDmRN3GUmycuQCiZ4KfTofcr7DHYMxeYvDIEbtQm8z+iGPPD40WdkcrQSynyN4Up0vHmSXHYk0KDIbbb2ihJI9G4azmcsamRVSQBpshWuuVOM1Fj4FAugaMsQBsT4szE3RNn+5DZONS3bJ7r2Q0n2aVGcyM9hlNn67ODbqWA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718349600; c=relaxed/simple;
	bh=CdOMIfbT6Nt2Zi/oLjl84DVcWPxKdsyKKS+0b4cAfrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5T/BASgF+cpNwZw0ESkYW1wMDIdnADsS77ExEk71TrfMWNxvpL+hkL9j3DMaRvud6xNulaaCneRj6hvNRcpx5fA+0lY4z1fxZzf8/6NNihdUr/gekoOkgEkMK0ANEXYR3WGo2XhdIXICuVEeOlBfx12806RF3OLAtKT3zQ2ANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hbzZce1l; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so17591051fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718349596; x=1718954396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TwzmK6wu9zm3cDBCz3PFUOjizlSmEgRc0oDvfVQTQY=;
        b=hbzZce1lVFhGaCpE06VdJNu3MK6KdE9KJK28joZGOlh0iQJaN+/KNAa0XxpHFU4YW+
         i/tpVHmaBSPx3M8iTWy/Ynt85j1McLBJcCUbjUKftNQP2VLN/6orN/WAaByaSOTxE9w9
         bVE3l8tTcb/kZ0Jj+Q5ybR2r6eTPwNo+hpHnbEL9NCNVlLzn3jMwdD6qFjtpJKYGgdl7
         sMqkrQVgYiPbmFd8EKZTKuW40zyX0u6u04HcA7U+WG5YhAezK4DZJz5gCfKC2yvXfNbT
         GWVPHittim4cTf/2JlBZQHF0xDa7fqilgni8UBfUNiL/fD7AUTwXDLm6lIP/F6D73eBD
         aTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718349596; x=1718954396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TwzmK6wu9zm3cDBCz3PFUOjizlSmEgRc0oDvfVQTQY=;
        b=vW0srL5rU+VydAmlMHUUjermQZkAF8NLQUrP8pt4upKKcigBeM8vNlwVK+lYVsyOxp
         uQE3mxSDRc4YNtG1K8pz55Y6qdN5MLvAyHOKOTDK+4jmqNnGOwydt1NumthvBZnCrVDL
         YFjLcy+hfzKhmEB/rhZyGO2W7DJwiLr2bwfvJ5xJ2buokXY3EKCo6bNOZLWPpnbdCTLx
         kXmDhv4G8x0ChddfFwHDUngn3QkQqPBXYD1WhCJQswOcjj+EzSu5e6D6ZmtZRPu4La0F
         h4yzU5mr/BL5Ag3MXbjVNKYKOi8lyUHf87kj9AsTCgtDYMVHZo02tToGIHhUiuxBF/Vi
         0ABw==
X-Forwarded-Encrypted: i=1; AJvYcCX1cW5h819PIj5V5OoTXZYUtaj4uBnYqEXl3YSdKXoOdIxZ9L10U4pfyWxBImheAk0AXJKzHuf8l27vlJD+TAgtqmf/44TanCfhdGtM
X-Gm-Message-State: AOJu0YxGDbNxb1VReNDJMiqkR3BqgylCBxlWFUZYbfE+I5bxCnAqxJX1
	RJ+kdw99BaZdlwRtOHscnqWJUJu18XL5bY0jJCKAiKS8mDPCLDMD1V2Gw0BWmgk=
X-Google-Smtp-Source: AGHT+IEkRyLEr340Rwpfq72yYbGglbHdtExlmdcIVFwIxZNQRwzK7ZbbzF4tgxXpzngXHiqUzVu8cg==
X-Received: by 2002:ac2:57c3:0:b0:52b:c292:f7c with SMTP id 2adb3069b0e04-52ca6e9886emr1049235e87.62.1718349596425;
        Fri, 14 Jun 2024 00:19:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9eesm87272555e9.9.2024.06.14.00.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 00:19:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 04/12] clk: renesas: clk-vbattb: Add VBATTB clock driver
Date: Fri, 14 Jun 2024 10:19:24 +0300
Message-Id: <20240614071932.1014067-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614071932.1014067-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240614071932.1014067-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The VBATTB IP of the Renesas RZ/G3S SoC controls the clock that is used
by the RTC. The input to the VBATTB could be a 32KHz crystal connected
to both the RTXIN and RTXOUT pins or an external clock connected to
RTXOUT pin. In case an external clock is connected to the RTXOUT pin the
renesas,vbattb-osc-bypass DT property need to be used when describing the
node.

The load capacitance of the on-board oscillator need to be configured with
renesas,vbattb-load-nanofarads DT property.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig      |   4 +
 drivers/clk/renesas/Makefile     |   1 +
 drivers/clk/renesas/clk-vbattb.c | 202 +++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 drivers/clk/renesas/clk-vbattb.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index d252150402e8..1dc38e3a8326 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -228,6 +228,10 @@ config CLK_RZG2L
 	bool "Renesas RZ/{G2L,G2UL,G3S,V2L} family clock support" if COMPILE_TEST
 	select RESET_CONTROLLER
 
+config CLK_VBATTB
+	bool "Renesas VBATTB clock controller"
+	select RESET_CONTROLLER
+
 # Generic
 config CLK_RENESAS_CPG_MSSR
 	bool "CPG/MSSR clock support" if COMPILE_TEST
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index f7e18679c3b8..e9e487f53577 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_CLK_RZG2L)			+= rzg2l-cpg.o
 obj-$(CONFIG_CLK_RENESAS_CPG_MSSR)	+= renesas-cpg-mssr.o
 obj-$(CONFIG_CLK_RENESAS_CPG_MSTP)	+= clk-mstp.o
 obj-$(CONFIG_CLK_RENESAS_DIV6)		+= clk-div6.o
+obj-$(CONFIG_CLK_VBATTB)		+= clk-vbattb.o
diff --git a/drivers/clk/renesas/clk-vbattb.c b/drivers/clk/renesas/clk-vbattb.c
new file mode 100644
index 000000000000..0a5cc886e89c
--- /dev/null
+++ b/drivers/clk/renesas/clk-vbattb.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VBATTB clock driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#define VBATTB_BKSCCR			0x1c
+#define VBATTB_BKSCCR_SOSEL		BIT(6)
+#define VBATTB_SOSCCR2			0x24
+#define VBATTB_SOSCCR2_SOSTP2		BIT(0)
+#define VBATTB_XOSCCR			0x30
+#define VBATTB_XOSCCR_OUTEN		BIT(16)
+#define VBATTB_XOSCCR_XSEL		GENMASK(1, 0)
+#define VBATTB_XOSCCR_XSEL_4_PF		0x0
+#define VBATTB_XOSCCR_XSEL_7_PF		0x1
+#define VBATTB_XOSCCR_XSEL_9_PF		0x2
+#define VBATTB_XOSCCR_XSEL_12_5_PF	0x3
+
+/**
+ * struct vbattb_clk - VBATTB clock data structure
+ * @regmap: regmap
+ * @hw: clk hw
+ * @lock: device lock
+ * @load_capacitance: load capacitance
+ */
+struct vbattb_clk {
+	struct regmap *regmap;
+	struct clk_hw hw;
+	spinlock_t lock;
+	u8 load_capacitance;
+};
+
+#define to_vbattb_clk(_hw) container_of(_hw, struct vbattb_clk, hw)
+
+static int vbattb_clk_enable(struct clk_hw *hw)
+{
+	struct vbattb_clk *vbclk = to_vbattb_clk(hw);
+	struct regmap *regmap = vbclk->regmap;
+
+	spin_lock(&vbclk->lock);
+	regmap_update_bits(regmap, VBATTB_SOSCCR2, VBATTB_SOSCCR2_SOSTP2, 0);
+	regmap_update_bits(regmap, VBATTB_XOSCCR, VBATTB_XOSCCR_OUTEN | VBATTB_XOSCCR_XSEL,
+			   VBATTB_XOSCCR_OUTEN | vbclk->load_capacitance);
+	spin_unlock(&vbclk->lock);
+
+	return 0;
+}
+
+static void vbattb_clk_disable(struct clk_hw *hw)
+{
+	struct vbattb_clk *vbclk = to_vbattb_clk(hw);
+	struct regmap *regmap = vbclk->regmap;
+
+	spin_lock(&vbclk->lock);
+	regmap_update_bits(regmap, VBATTB_XOSCCR, VBATTB_XOSCCR_OUTEN, 0);
+	regmap_update_bits(regmap, VBATTB_SOSCCR2, VBATTB_SOSCCR2_SOSTP2, VBATTB_SOSCCR2_SOSTP2);
+	spin_unlock(&vbclk->lock);
+}
+
+static int vbattb_clk_is_enabled(struct clk_hw *hw)
+{
+	struct vbattb_clk *vbclk = to_vbattb_clk(hw);
+	struct regmap *regmap = vbclk->regmap;
+	unsigned int xosccr, sosccr2;
+	int ret;
+
+	spin_lock(&vbclk->lock);
+	ret = regmap_read(regmap, VBATTB_XOSCCR, &xosccr);
+	if (ret)
+		goto unlock;
+
+	ret = regmap_read(regmap, VBATTB_SOSCCR2, &sosccr2);
+unlock:
+	spin_unlock(&vbclk->lock);
+
+	if (ret)
+		return 0;
+
+	return ((xosccr & VBATTB_XOSCCR_OUTEN) && !(sosccr2 & VBATTB_SOSCCR2_SOSTP2));
+}
+
+static const struct clk_ops vbattb_clk_ops = {
+	.enable = vbattb_clk_enable,
+	.disable = vbattb_clk_disable,
+	.is_enabled = vbattb_clk_is_enabled,
+};
+
+static int vbattb_clk_validate_load_capacitance(struct vbattb_clk *vbclk, u32 load_capacitance)
+{
+	switch (load_capacitance) {
+	case 4000:
+		vbclk->load_capacitance = VBATTB_XOSCCR_XSEL_4_PF;
+		break;
+	case 7000:
+		vbclk->load_capacitance = VBATTB_XOSCCR_XSEL_7_PF;
+		break;
+	case 9000:
+		vbclk->load_capacitance = VBATTB_XOSCCR_XSEL_9_PF;
+		break;
+	case 12500:
+		vbclk->load_capacitance = VBATTB_XOSCCR_XSEL_12_5_PF;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vbattb_clk_probe(struct platform_device *pdev)
+{
+	struct clk_parent_data parent_data = { .fw_name = "vbattb_xtal" };
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct clk_init_data init = {};
+	struct vbattb_clk *vbclk;
+	u32 load_capacitance;
+	struct clk_hw *hw;
+	bool bypass;
+	int ret;
+
+	vbclk = devm_kzalloc(dev, GFP_KERNEL, sizeof(*vbclk));
+	if (!vbclk)
+		return -ENOMEM;
+
+	vbclk->regmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(vbclk->regmap))
+		return PTR_ERR(vbclk->regmap);
+
+	bypass = of_property_read_bool(np, "renesas,vbattb-osc-bypass");
+	ret = of_property_read_u32(np, "renesas,vbattb-load-nanofarads", &load_capacitance);
+	if (ret)
+		return ret;
+
+	ret = vbattb_clk_validate_load_capacitance(vbclk, load_capacitance);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(vbclk->regmap, VBATTB_BKSCCR, VBATTB_BKSCCR_SOSEL,
+			   bypass ? VBATTB_BKSCCR_SOSEL : 0);
+
+	init.name = "vbattclk";
+	init.ops = &vbattb_clk_ops;
+	init.parent_data = &parent_data;
+	init.num_parents = 1;
+	init.flags = 0;
+
+	vbclk->hw.init = &init;
+	hw = &vbclk->hw;
+
+	spin_lock_init(&vbclk->lock);
+
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		goto rpm_put;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	if (ret)
+		goto rpm_put;
+
+	return 0;
+
+rpm_put:
+	pm_runtime_put(dev);
+	return ret;
+}
+
+static const struct of_device_id vbattb_clk_match[] = {
+	{ .compatible = "renesas,rzg3s-vbattb-clk" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver vbattb_clk_driver = {
+	.driver		= {
+		.name	= "vbattb-clk",
+		.of_match_table = vbattb_clk_match,
+	},
+	.probe = vbattb_clk_probe,
+};
+module_platform_driver(vbattb_clk_driver);
+
+MODULE_DESCRIPTION("Renesas VBATTB Clock Driver");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>");
+MODULE_LICENSE("GPL");
-- 
2.39.2



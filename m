Return-Path: <linux-kernel+bounces-571733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACEA6C164
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19156189D771
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8673230BDC;
	Fri, 21 Mar 2025 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSi2QU4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7EA2309B6;
	Fri, 21 Mar 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577827; cv=none; b=cJguSKXXKbQx9XDWaVyk26YOq8+gYKUCi8QzzEJzp0FJ+B3HtY/ihAb4fAbigrWGUo0ctiNo7PpLrry7I7Jt/LkNa65DWRGIQ5at9qcqSp6erJ3xZntm3TBhtp4/W0Kr1KsSNGjJsYNZ0bpOip0B2HwLFWcdkFI4fBe4wVEljNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577827; c=relaxed/simple;
	bh=RIaLytEA1lVSh28yAE2eOkonTtXe8DgddLseiGsgHsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cj78cPjwC4WRjfSCdk9pFgUk4jOUeqlb7764oAjmOsorOCIUHUfgWDS7UE3fIA2hRz61F/78UWj/IyIvmZ3jJVI54o1w0qSsAIuf981eoMTDXw7p6/KT8iTRaGW8Y8ZtUGhG2fcgcXPsk47Urf/iASqjbm1HSZDgLQw2OIBURBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSi2QU4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C6FC4CEE8;
	Fri, 21 Mar 2025 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577825;
	bh=RIaLytEA1lVSh28yAE2eOkonTtXe8DgddLseiGsgHsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSi2QU4C4MkwyZp7XLlZbfQXkHggO3qye8NVPCwfuNYmq1QeCAh47TT1N89laedQp
	 TRcGvK2mO++wGxY7KIaXPiiHMX0QQQlfHF4k8SBVuS9sN1t90g1TB2FmsUsRmMSXtl
	 DfhbCrVRsoOqfZj21KzPEoaFey8qEfZZtsYO7ZpliykaOESKR9RhKKv6w35VVFaokU
	 abo6nd+zzoErGgcGK8IObWPswZCkVJ4/CTxBp49mZv4daMzfrAlSFMn/p/4DAf7hrj
	 mrl2eZEjOL6IR9I8Nly42dVkRCTGseLZVnOwJz0wD6qHDoW5JBcGHwywjkukFi7WFB
	 OXIRo5WsxYwbg==
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 9/9] clk: microchip: mpfs: use regmap clock types
Date: Fri, 21 Mar 2025 17:22:42 +0000
Message-ID: <20250321-aflutter-unearned-1d6078241fb3@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10027; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=pQhEwkt5Ys1X5PbTe/h5CRH87bs0UPsQSVu7EETaHAE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3F0SvNG+oPOHvtGWXacUPnZTnqyffSfgaa2f3O+dTT soU39uRHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIw10M/2ObZeJlZjz02yDv eVN427PvX4rDnXwfdtp8Sz0cvezTg90M/7PLjvWvSWjt0jI/sbJCS1+me6trSbD8++WadW/Y/v7 awgoA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Convert the PolarFire SoC clock driver to use regmap clock types as a
preparatory work for supporting the new binding for this device that
will only provide the second of the two register regions, and will
require the use of syscon regmap to access the "cfg" and "periph" clocks
currently supported by the driver.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/Kconfig    |   4 +
 drivers/clk/microchip/clk-mpfs.c | 151 ++++++++++++++++++++-----------
 2 files changed, 101 insertions(+), 54 deletions(-)

diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfig
index 0724ce65898f..cab9a909893b 100644
--- a/drivers/clk/microchip/Kconfig
+++ b/drivers/clk/microchip/Kconfig
@@ -7,6 +7,10 @@ config MCHP_CLK_MPFS
 	bool "Clk driver for PolarFire SoC"
 	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
 	default ARCH_MICROCHIP_POLARFIRE
+	depends on MFD_SYSCON
 	select AUXILIARY_BUS
+	select COMMON_CLK_DIVIDER_REGMAP
+	select COMMON_CLK_GATE_REGMAP
+	select REGMAP_MMIO
 	help
 	  Supports Clock Configuration for PolarFire SoC
diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index c22632a7439c..c7fec0fcbe37 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -6,8 +6,10 @@
  */
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <soc/microchip/mpfs.h>
 
@@ -30,6 +32,14 @@
 #define MSSPLL_POSTDIV_WIDTH	0x07u
 #define MSSPLL_FIXED_DIV	4u
 
+static const struct regmap_config clk_mpfs_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.max_register = REG_SUBBLK_CLOCK_CR,
+};
+
 /*
  * This clock ID is defined here, rather than the binding headers, as it is an
  * internal clock only, and therefore has no consumers in other peripheral
@@ -39,6 +49,7 @@
 
 struct mpfs_clock_data {
 	struct device *dev;
+	struct regmap *regmap;
 	void __iomem *base;
 	void __iomem *msspll_base;
 	struct clk_hw_onecell_data hw_data;
@@ -68,14 +79,12 @@ struct mpfs_msspll_out_hw_clock {
 #define to_mpfs_msspll_out_clk(_hw) container_of(_hw, struct mpfs_msspll_out_hw_clock, hw)
 
 struct mpfs_cfg_hw_clock {
-	struct clk_divider cfg;
-	struct clk_init_data init;
+	struct clk_divider_regmap divider;
 	unsigned int id;
-	u32 reg_offset;
 };
 
 struct mpfs_periph_hw_clock {
-	struct clk_gate periph;
+	struct clk_gate_regmap gate;
 	unsigned int id;
 };
 
@@ -172,15 +181,15 @@ static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_c
  * MSS PLL output clocks
  */
 
-#define CLK_PLL_OUT(_id, _name, _parent, _flags, _shift, _width, _offset) {	\
-	.id = _id,								\
-	.output.shift = _shift,							\
-	.output.width = _width,							\
-	.output.table = NULL,							\
-	.reg_offset = _offset,							\
-	.output.flags = _flags,							\
-	.output.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_ops, 0),	\
-	.output.lock = &mpfs_clk_lock,						\
+#define CLK_PLL_OUT(_id, _name, _parent, _flags, _shift, _width, _offset) {		\
+	.id = _id,									\
+	.output.shift = _shift,								\
+	.output.width = _width,								\
+	.output.table = NULL,								\
+	.reg_offset = _offset,								\
+	.output.flags = _flags,								\
+	.output.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_regmap_ops, 0),	\
+	.output.lock = &mpfs_clk_lock,							\
 }
 
 static struct mpfs_msspll_out_hw_clock mpfs_msspll_out_clks[] = {
@@ -220,15 +229,14 @@ static int mpfs_clk_register_msspll_outs(struct device *dev,
  * "CFG" clocks
  */
 
-#define CLK_CFG(_id, _name, _parent, _shift, _width, _table, _flags, _offset) {		\
-	.id = _id,									\
-	.cfg.shift = _shift,								\
-	.cfg.width = _width,								\
-	.cfg.table = _table,								\
-	.reg_offset = _offset,								\
-	.cfg.flags = _flags,								\
-	.cfg.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_ops, 0),		\
-	.cfg.lock = &mpfs_clk_lock,							\
+#define CLK_CFG(_id, _name, _parent, _shift, _width, _table, _flags, _offset) {	\
+	.id = _id,								\
+	.divider.shift = _shift,						\
+	.divider.width = _width,						\
+	.divider.table = _table,						\
+	.divider.map_offset = _offset,						\
+	.divider.flags = _flags,						\
+	.divider.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_regmap_ops, 0),	\
 }
 
 #define CLK_CPU_OFFSET		0u
@@ -245,13 +253,13 @@ static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
 		REG_CLOCK_CONFIG_CR),
 	{
 		.id = CLK_RTCREF,
-		.cfg.shift = 0,
-		.cfg.width = 12,
-		.cfg.table = mpfs_div_rtcref_table,
-		.reg_offset = REG_RTC_CLOCK_CR,
-		.cfg.flags = CLK_DIVIDER_ONE_BASED,
-		.cfg.hw.init =
-			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &clk_divider_ops, 0),
+		.divider.shift = 0,
+		.divider.width = 12,
+		.divider.table = mpfs_div_rtcref_table,
+		.divider.map_offset = REG_RTC_CLOCK_CR,
+		.divider.flags = CLK_DIVIDER_ONE_BASED,
+		.divider.hw.init =
+			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &clk_divider_regmap_ops, 0),
 	}
 };
 
@@ -264,14 +272,14 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_cfg_hw_clock *cfg_hw = &cfg_hws[i];
 
-		cfg_hw->cfg.reg = data->base + cfg_hw->reg_offset;
-		ret = devm_clk_hw_register(dev, &cfg_hw->cfg.hw);
+		cfg_hw->divider.regmap = data->regmap;
+		ret = devm_clk_hw_register(dev, &cfg_hw->divider.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     cfg_hw->id);
 
 		id = cfg_hw->id;
-		data->hw_data.hws[id] = &cfg_hw->cfg.hw;
+		data->hw_data.hws[id] = &cfg_hw->divider.hw;
 	}
 
 	return 0;
@@ -281,15 +289,14 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
  * peripheral clocks - devices connected to axi or ahb buses.
  */
 
-#define CLK_PERIPH(_id, _name, _parent, _shift, _flags) {			\
-	.id = _id,								\
-	.periph.bit_idx = _shift,						\
-	.periph.hw.init = CLK_HW_INIT_HW(_name, _parent, &clk_gate_ops,		\
-				  _flags),					\
-	.periph.lock = &mpfs_clk_lock,						\
+#define CLK_PERIPH(_id, _name, _parent, _shift, _flags) {				\
+	.id = _id,									\
+	.gate.map_offset = REG_SUBBLK_CLOCK_CR,						\
+	.gate.bit_idx = _shift,								\
+	.gate.hw.init = CLK_HW_INIT_HW(_name, _parent, &clk_gate_regmap_ops, _flags),	\
 }
 
-#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT##_OFFSET].cfg.hw)
+#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT##_OFFSET].divider.hw)
 
 /*
  * Critical clocks:
@@ -346,19 +353,60 @@ static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_c
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_periph_hw_clock *periph_hw = &periph_hws[i];
 
-		periph_hw->periph.reg = data->base + REG_SUBBLK_CLOCK_CR;
-		ret = devm_clk_hw_register(dev, &periph_hw->periph.hw);
+		periph_hw->gate.map = data->regmap;
+		ret = devm_clk_hw_register(dev, &periph_hw->gate.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     periph_hw->id);
 
 		id = periph_hws[i].id;
-		data->hw_data.hws[id] = &periph_hw->periph.hw;
+		data->hw_data.hws[id] = &periph_hw->gate.hw;
 	}
 
 	return 0;
 }
 
+static inline int mpfs_clk_syscon_probe(struct mpfs_clock_data *clk_data,
+					struct platform_device *pdev)
+{
+	clk_data->regmap = syscon_regmap_lookup_by_compatible("microchip,mpfs-mss-top-sysreg");
+	if (IS_ERR(clk_data->regmap))
+		return PTR_ERR(clk_data->regmap);
+
+	clk_data->msspll_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(clk_data->msspll_base))
+		return PTR_ERR(clk_data->msspll_base);
+
+	return 0;
+}
+
+static inline int mpfs_clk_old_format_probe(struct mpfs_clock_data *clk_data,
+					    struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	dev_warn(&pdev->dev, "falling back to old devicetree format");
+
+	clk_data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(clk_data->base))
+		return PTR_ERR(clk_data->base);
+
+	clk_data->msspll_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(clk_data->msspll_base))
+		return PTR_ERR(clk_data->msspll_base);
+
+	clk_data->regmap = devm_regmap_init_mmio(dev, clk_data->base, &clk_mpfs_regmap_config);
+	if (IS_ERR(clk_data->regmap))
+		return PTR_ERR(clk_data->regmap);
+
+	ret = mpfs_reset_controller_register(dev, clk_data->base + REG_SUBBLK_RESET_CR);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int mpfs_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -374,13 +422,12 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	clk_data->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(clk_data->base))
-		return PTR_ERR(clk_data->base);
-
-	clk_data->msspll_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(clk_data->msspll_base))
-		return PTR_ERR(clk_data->msspll_base);
+	ret = mpfs_clk_syscon_probe(clk_data, pdev);
+	if (ret) {
+		ret = mpfs_clk_old_format_probe(clk_data, pdev);
+		if (ret)
+			return ret;
+	}
 
 	clk_data->hw_data.num = num_clks;
 	clk_data->dev = dev;
@@ -406,11 +453,7 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &clk_data->hw_data);
-	if (ret)
-		return ret;
-
-	return mpfs_reset_controller_register(dev, clk_data->base + REG_SUBBLK_RESET_CR);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &clk_data->hw_data);
 }
 
 static const struct of_device_id mpfs_clk_of_match_table[] = {
-- 
2.45.2



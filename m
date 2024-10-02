Return-Path: <linux-kernel+bounces-347362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E409F98D1AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A7DB2506F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7D6205E34;
	Wed,  2 Oct 2024 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaFI33AE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF1205E23;
	Wed,  2 Oct 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866135; cv=none; b=nZ77SjBl9m58YsnYzhFlM4wB/jevlZHHOeRWcXOY2LTCjHvMarjIOLz7jJYjlfIHxVoBJrh7629nJyVrBhgO0SV9xgpELuiE/vqmNTD6kLM4UyDkOXqnknGRVibHpCnVnMhxoRpGSu0z+4rkm8XlUt/VmJc4/aAkLiaqtaIPriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866135; c=relaxed/simple;
	bh=135SsPEYaxmVYVhAr6AU//Ybd+iCcSp8Ys1d5sMKqS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YagmRA3BXSBNcK/NVcWoo7hZTvDAmsEs7PfB7ymSnSdhqA01xjFG/4mBh6XW1gRMojBwiOFRCxkPYfL86Sglp2wmFJL2qxZUYyukJAtN742yEuxCKReYT2Eh7rZDARsvZbEdKYwagVOMFT9HIHvv8u97br1vav2147nqRnD+bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaFI33AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B76C4CECF;
	Wed,  2 Oct 2024 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866135;
	bh=135SsPEYaxmVYVhAr6AU//Ybd+iCcSp8Ys1d5sMKqS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaFI33AEIsbQnmHj19YPLFo7UuQNsMgWftgGr9VVFM0UVTCvfMpig8BPBdbngT2o0
	 TjxmWK9S3At2PIOntRwa+aRJS3s/4u8D2LUDehPs7YfSSBkSbR7izxGp4dA9H6z1Qc
	 XyGW2K5qQrdY9iE4SRtbsbc1/Tj1x77JhGXznbUoQxUtIUmMoIoTcrZOc9NQCEzbvV
	 RUPQBywHpZzWUJD2QKXnnfNxQ9Sw9sldR0Nw1G22heSESTH5rb1/F7Igtm1gJACuIh
	 WWRtT9llEd2Swpw1vpbEyILHHd77Duf9EDC6MhWoVJc5nfRFqlLfhS01wu4ph+unYx
	 halvVd4SQHNIQ==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 09/11] clk: microchip: mpfs: use regmap clock types
Date: Wed,  2 Oct 2024 11:48:07 +0100
Message-ID: <20241002-monkhood-album-64c44dc9841b@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-private-unequal-33cfa6101338@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8447; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Yu86W17jKMDKSzVLM2Zg0G0yvkuZxddHUoJQp2hVgMM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/VR5lzj/5J63zp8HB9vM1uyYXetzY3Ddb38RUgbPxp xXLvXvhHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhIYxDD/2SZl9slOIzvdulP rpg1xUnmRs/348WTBctT/TuLQ22dtzL8r1J/cG7W3I2ZW1J8WEQP/t+66U6h5rT355/sSz803YT Fgh8A
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
 drivers/clk/microchip/Kconfig    |   3 +
 drivers/clk/microchip/clk-mpfs.c | 114 ++++++++++++++++++++++---------
 2 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfig
index 0724ce65898f3..72da1e0f437d9 100644
--- a/drivers/clk/microchip/Kconfig
+++ b/drivers/clk/microchip/Kconfig
@@ -7,6 +7,9 @@ config MCHP_CLK_MPFS
 	bool "Clk driver for PolarFire SoC"
 	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
 	default ARCH_MICROCHIP_POLARFIRE
+	depends on MFD_SYSCON
 	select AUXILIARY_BUS
+	select COMMON_CLK_REGMAP
+	select REGMAP_MMIO
 	help
 	  Supports Clock Configuration for PolarFire SoC
diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 28ec0da88cb38..8cf963291317c 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -6,10 +6,13 @@
  */
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <soc/microchip/mpfs.h>
+#include <linux/clk/clk-regmap.h>
 
 /* address offset of control registers */
 #define REG_MSSPLL_REF_CR	0x08u
@@ -30,6 +33,14 @@
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
@@ -39,6 +50,7 @@
 
 struct mpfs_clock_data {
 	struct device *dev;
+	struct regmap *regmap;
 	void __iomem *base;
 	void __iomem *msspll_base;
 	struct clk_hw_onecell_data hw_data;
@@ -68,14 +80,14 @@ struct mpfs_msspll_out_hw_clock {
 #define to_mpfs_msspll_out_clk(_hw) container_of(_hw, struct mpfs_msspll_out_hw_clock, hw)
 
 struct mpfs_cfg_hw_clock {
-	struct clk_divider cfg;
-	struct clk_init_data init;
+	struct clk_regmap sigh;
+	struct clk_regmap_div_data cfg;
 	unsigned int id;
-	u32 reg_offset;
 };
 
 struct mpfs_periph_hw_clock {
-	struct clk_gate periph;
+	struct clk_regmap sigh;
+	struct clk_regmap_gate_data periph;
 	unsigned int id;
 };
 
@@ -225,10 +237,9 @@ static int mpfs_clk_register_msspll_outs(struct device *dev,
 	.cfg.shift = _shift,								\
 	.cfg.width = _width,								\
 	.cfg.table = _table,								\
-	.reg_offset = _offset,								\
+	.cfg.offset = _offset,								\
 	.cfg.flags = _flags,								\
-	.cfg.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_ops, 0),		\
-	.cfg.lock = &mpfs_clk_lock,							\
+	.sigh.hw.init = CLK_HW_INIT(_name, _parent, &clk_regmap_divider_ops, 0),	\
 }
 
 #define CLK_CPU_OFFSET		0u
@@ -248,10 +259,10 @@ static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
 		.cfg.shift = 0,
 		.cfg.width = 12,
 		.cfg.table = mpfs_div_rtcref_table,
-		.reg_offset = REG_RTC_CLOCK_CR,
+		.cfg.offset = REG_RTC_CLOCK_CR,
 		.cfg.flags = CLK_DIVIDER_ONE_BASED,
-		.cfg.hw.init =
-			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &clk_divider_ops, 0),
+		.sigh.hw.init =
+			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &clk_regmap_divider_ops, 0),
 	}
 };
 
@@ -264,14 +275,16 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_cfg_hw_clock *cfg_hw = &cfg_hws[i];
 
-		cfg_hw->cfg.reg = data->base + cfg_hw->reg_offset;
-		ret = devm_clk_hw_register(dev, &cfg_hw->cfg.hw);
+		cfg_hw->sigh.map = data->regmap;
+		cfg_hw->sigh.data = &cfg_hw->cfg;
+
+		ret = devm_clk_hw_register(dev, &cfg_hw->sigh.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     cfg_hw->id);
 
 		id = cfg_hw->id;
-		data->hw_data.hws[id] = &cfg_hw->cfg.hw;
+		data->hw_data.hws[id] = &cfg_hw->sigh.hw;
 	}
 
 	return 0;
@@ -283,13 +296,13 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
 
 #define CLK_PERIPH(_id, _name, _parent, _shift, _flags) {			\
 	.id = _id,								\
+	.periph.offset = REG_SUBBLK_CLOCK_CR,					\
 	.periph.bit_idx = _shift,						\
-	.periph.hw.init = CLK_HW_INIT_HW(_name, _parent, &clk_gate_ops,		\
-				  _flags),					\
-	.periph.lock = &mpfs_clk_lock,						\
+	.sigh.hw.init = CLK_HW_INIT_HW(_name, _parent, &clk_regmap_gate_ops,	\
+					 _flags),				\
 }
 
-#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT##_OFFSET].cfg.hw)
+#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT##_OFFSET].sigh.hw)
 
 /*
  * Critical clocks:
@@ -346,19 +359,61 @@ static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_c
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_periph_hw_clock *periph_hw = &periph_hws[i];
 
-		periph_hw->periph.reg = data->base + REG_SUBBLK_CLOCK_CR;
-		ret = devm_clk_hw_register(dev, &periph_hw->periph.hw);
+		periph_hw->sigh.map = data->regmap;
+		periph_hw->sigh.data = &periph_hw->periph;
+		ret = devm_clk_hw_register(dev, &periph_hw->sigh.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     periph_hw->id);
 
 		id = periph_hws[i].id;
-		data->hw_data.hws[id] = &periph_hw->periph.hw;
+		data->hw_data.hws[id] = &periph_hw->sigh.hw;
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
@@ -374,13 +429,12 @@ static int mpfs_clk_probe(struct platform_device *pdev)
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
@@ -406,11 +460,7 @@ static int mpfs_clk_probe(struct platform_device *pdev)
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



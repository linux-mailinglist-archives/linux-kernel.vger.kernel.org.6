Return-Path: <linux-kernel+bounces-288051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0EC95323A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E661C23916
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5B1B143B;
	Thu, 15 Aug 2024 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umfABLK6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012B1AC454;
	Thu, 15 Aug 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730525; cv=none; b=gd+IMkK3TJSzZah+WxxNvzAmr4eKIozoM7JYEBnGpLFc6TJTrPx32RkyvCfm80t0Jtg3hbUhbU4Nl12x0oaVi9ldAis8i71WV2tp8YIn6xlsPP5G6VXonAc8NbQ24sYGYz/Kon1IkS9AdyGy4poBSiHwvGuE0rCJ2puEHMOHzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730525; c=relaxed/simple;
	bh=//J+70MpTR0Du2JzFTYBY8HR3h40SC+x8QIXmtCouSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3QI9fXkaqis8xtot3AD8H3IivXkdkBXYsc3Y6W2g1l2DG1cUbA4mtOokpEi9mV+7a1h1NmVrVU81H9n1/s2DyL285jy89yoYjhoNczPdFLGcEBloLZ+mkn7weIJ/MagRQwXehkbmMf+hIUEORVIAXkYQv9Lx2pZap3mEtj6u6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umfABLK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E96EC4AF11;
	Thu, 15 Aug 2024 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730524;
	bh=//J+70MpTR0Du2JzFTYBY8HR3h40SC+x8QIXmtCouSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umfABLK6ha8wtrFzMJkYv26fZ7ihfdbvdfi1HfIUgyq7zUnsqLt7DMfeeO55iUttx
	 68ws3Nxmkubqv2oh3xcpih/fmDuBrDDMgbChGWLujWKSPD0yCllPw6ZF8XTQnL86uw
	 m7SJsmfCU+e3wxCnNv3qJDd/0A+G51gNSC+vudVELyORenwHQsGB8r+ulQU2ct7fS6
	 jTOaWzNlJF2YMubLPBv1esb+nxBEBZPxqdOoaxpjgOgKHj2E3lw47OsoB2S8A7riE3
	 EWv0Zz6JZiRjZkwZOScGUPHKsz54wVFZBdEyfy9kX+3fxBxB/mhgPE5+IgpE7GQ/n6
	 5XuEeiD0jH6hA==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/11] clk: microchip: mpfs: use regmap clock types
Date: Thu, 15 Aug 2024 15:01:12 +0100
Message-ID: <20240815-aspire-rocket-38a56ce389ae@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7027; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=8TEePMgwAHr2dnJymzvS6c7DD2P/83v04LyJwVYBlQ0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uHRvthd3Pd675k+pF7P6hEuZSmEnXvavem8YMX/Vw TktJt6eHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjI1OMM/zR4f5nnJq87/Hqi 8hP19pYXeyfuENHfYRtyTGvtM9PSy2yMDL2yz6/9neES2b5ddJrS7F83mnK/Lv+0XeHIoT5Z/c/ CWYwA
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
 drivers/clk/microchip/clk-mpfs.c | 81 ++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 28ec0da88cb3..e288c1729a23 100644
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
+#include "clk-regmap.h"
 
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
@@ -346,14 +359,15 @@ static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_c
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
@@ -374,6 +388,19 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
+	clk_data->regmap = syscon_regmap_lookup_by_compatible("microchip,mpfs-mss-top-sysreg");
+	if (IS_ERR(clk_data->regmap)) {
+		clk_data->regmap = NULL;
+		goto old_format;
+	}
+
+	clk_data->msspll_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(clk_data->msspll_base))
+		return PTR_ERR(clk_data->msspll_base);
+
+	goto done;
+
+old_format:
 	clk_data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(clk_data->base))
 		return PTR_ERR(clk_data->base);
@@ -382,6 +409,14 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(clk_data->msspll_base))
 		return PTR_ERR(clk_data->msspll_base);
 
+	clk_data->regmap = devm_regmap_init_mmio(dev, clk_data->base, &clk_mpfs_regmap_config);
+	if (IS_ERR(clk_data->regmap))
+		return PTR_ERR(clk_data->regmap);
+
+	ret = mpfs_reset_controller_register(dev, clk_data->base + REG_SUBBLK_RESET_CR);
+	if (ret)
+		return ret;
+done:
 	clk_data->hw_data.num = num_clks;
 	clk_data->dev = dev;
 	dev_set_drvdata(dev, clk_data);
@@ -406,11 +441,7 @@ static int mpfs_clk_probe(struct platform_device *pdev)
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
2.43.0



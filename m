Return-Path: <linux-kernel+bounces-221908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8C890FA61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EAC282B10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B0B18EB0;
	Thu, 20 Jun 2024 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DpZTOU1K"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2DDDB8;
	Thu, 20 Jun 2024 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843913; cv=none; b=XqDA1Txpse6J6gGqbxbU4RvaZnnMvmCkYlzFBSzKrE0K3wTQttgpgJt+5Bcu3eD2AdhrTyuiZ3/qN+GY4Je/KafXqvNpaX1+IqoLJe3Q1FXSfdwHQhVEwEsdC41J06tfalYsmbmGo/ZojoOsbzH+fJfFvo32qDpPVtDtZsaET+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843913; c=relaxed/simple;
	bh=8oc+gW9i1iuNOLqRtRgTfLkc+/HrQ5t4e8n2v6OKIPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxKdTrGLz3yyVd/s9RtVH6+yDggnbUDR0xVd92xUABqHucPo8EYuscaYCuAqGitiHZb49MC5eCFnOWdGIC38QCtoZFGsA63+yr08W9fsKgnwpg1zjwbpyN1YrDiJbS33ShvOX2Ww3YfnI8onJd3JPfAFHnpQqhHQE3FRMOhio1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DpZTOU1K; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718843910;
	bh=8oc+gW9i1iuNOLqRtRgTfLkc+/HrQ5t4e8n2v6OKIPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DpZTOU1K8dWEpEie3PDyuRrYDtBzcOiHSFvKoog2U5MM0LifMGFzmZGk9s+F88dl+
	 Kx7JaA+0IG/6YeCuU+SbEt45cnCuV3lcBJ5lihSLbta0jtFDjs3JvLsTEjBYGiKyOo
	 25UpxxvbQ6DuOo8yTI1Od4/2yek/qfi31xPOzKOxmZYnbI+WcEYIDaoMWKxH3jxdFd
	 zTGa1b712N+a46lgYR/j9lFvi/YfHoWUWK50CKDvfHKA6qtuwfW3jIkuCaINCMDkFE
	 +rAzJVxTofie0BaQ/x8Tzw6f4imnRcFBE78oAC64haWg2opPaKvwfw7SpbRqidZoWL
	 6SZJX2X5yCOag==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0171E37821B0;
	Thu, 20 Jun 2024 00:38:29 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 20 Jun 2024 03:36:25 +0300
Subject: [PATCH v2 4/4] phy: phy-rockchip-samsung-hdptx: Add clock provider
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-rk3588-hdmiphy-clkprov-v2-4-6a2d2164e508@collabora.com>
References: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
In-Reply-To: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

The HDMI PHY PLL can be used as an alternative dclk source to RK3588 SoC
CRU. It provides more accurate clock rates required by VOP2 to improve
existing support for display modes handling, which is known to be
problematic when dealing with non-integer refresh rates, among others.

It is worth noting this only works for HDMI 2.0 or below, e.g. cannot be
used to support HDMI 2.1 4K@120Hz mode.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 195 +++++++++++++++++++---
 1 file changed, 173 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 72de287282eb..9f084697dd05 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -8,6 +8,7 @@
  */
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -191,6 +192,8 @@
 #define LN3_TX_SER_RATE_SEL_HBR2	BIT(3)
 #define LN3_TX_SER_RATE_SEL_HBR3	BIT(2)
 
+#define HDMI20_MAX_RATE			600000000
+
 struct lcpll_config {
 	u32 bit_rate;
 	u8 lcvco_mode_en;
@@ -273,6 +276,12 @@ struct rk_hdptx_phy {
 	struct clk_bulk_data *clks;
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];
+
+	/* clk provider */
+	struct clk_hw hw;
+	unsigned long rate;
+
+	atomic_t usage_count;
 };
 
 static const struct ropll_config ropll_tmds_cfg[] = {
@@ -760,6 +769,8 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	struct ropll_config rc = {0};
 	int i;
 
+	hdptx->rate = rate * 100;
+
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
 		if (rate == ropll_tmds_cfg[i].bit_rate) {
 			cfg = &ropll_tmds_cfg[i];
@@ -823,19 +834,6 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
 					   unsigned int rate)
 {
-	u32 val;
-	int ret;
-
-	ret = regmap_read(hdptx->grf, GRF_HDPTX_STATUS, &val);
-	if (ret)
-		return ret;
-
-	if (!(val & HDPTX_O_PLL_LOCK_DONE)) {
-		ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
-		if (ret)
-			return ret;
-	}
-
 	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_sb_init_seq);
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
@@ -857,10 +855,68 @@ static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
 	return rk_hdptx_post_enable_lane(hdptx);
 }
 
+static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
+				     unsigned int rate)
+{
+	u32 status;
+	int ret;
+
+	if (atomic_inc_return(&hdptx->usage_count) > 1)
+		return 0;
+
+	ret = regmap_read(hdptx->grf, GRF_HDPTX_STATUS, &status);
+	if (ret)
+		goto dec_usage;
+
+	if (status & HDPTX_O_PLL_LOCK_DONE)
+		dev_warn(hdptx->dev, "PLL locked by unknown consumer!\n");
+
+	if (rate) {
+		ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
+		if (ret)
+			goto dec_usage;
+	}
+
+	return 0;
+
+dec_usage:
+	atomic_dec(&hdptx->usage_count);
+	return ret;
+}
+
+static int rk_hdptx_phy_consumer_put(struct rk_hdptx_phy *hdptx, bool force)
+{
+	u32 status;
+	int ret;
+
+	ret = atomic_dec_return(&hdptx->usage_count);
+	if (ret > 0)
+		return 0;
+
+	if (ret < 0) {
+		dev_warn(hdptx->dev, "Usage count underflow!\n");
+		ret = -EINVAL;
+	} else {
+		ret = regmap_read(hdptx->grf, GRF_HDPTX_STATUS, &status);
+		if (!ret) {
+			if (status & HDPTX_O_PLL_LOCK_DONE)
+				rk_hdptx_phy_disable(hdptx);
+			return 0;
+		} else if (force) {
+			return 0;
+		}
+	}
+
+	atomic_inc(&hdptx->usage_count);
+	return ret;
+}
+
 static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
 	int bus_width = phy_get_bus_width(hdptx->phy);
+	int ret;
+
 	/*
 	 * FIXME: Temporary workaround to pass pixel_clk_rate
 	 * from the HDMI bridge driver until phy_configure_opts_hdmi
@@ -871,20 +927,22 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
 		__func__, bus_width, rate);
 
-	return rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
+	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
+	if (ret)
+		return ret;
+
+	ret = rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
+	if (ret)
+		rk_hdptx_phy_consumer_put(hdptx, true);
+
+	return ret;
 }
 
 static int rk_hdptx_phy_power_off(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
-	u32 val;
-	int ret;
 
-	ret = regmap_read(hdptx->grf, GRF_HDPTX_STATUS, &val);
-	if (ret == 0 && (val & HDPTX_O_PLL_LOCK_DONE))
-		rk_hdptx_phy_disable(hdptx);
-
-	return ret;
+	return rk_hdptx_phy_consumer_put(hdptx, false);
 }
 
 static const struct phy_ops rk_hdptx_phy_ops = {
@@ -893,6 +951,99 @@ static const struct phy_ops rk_hdptx_phy_ops = {
 	.owner	   = THIS_MODULE,
 };
 
+static struct rk_hdptx_phy *to_rk_hdptx_phy(struct clk_hw *hw)
+{
+	return container_of(hw, struct rk_hdptx_phy, hw);
+}
+
+static int rk_hdptx_phy_clk_prepare(struct clk_hw *hw)
+{
+	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
+
+	return rk_hdptx_phy_consumer_get(hdptx, hdptx->rate / 100);
+}
+
+static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)
+{
+	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
+
+	rk_hdptx_phy_consumer_put(hdptx, true);
+}
+
+static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
+
+	return hdptx->rate;
+}
+
+static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *parent_rate)
+{
+	u32 bit_rate = rate / 100;
+	int i;
+
+	if (rate > HDMI20_MAX_RATE)
+		return rate;
+
+	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
+		if (bit_rate == ropll_tmds_cfg[i].bit_rate)
+			break;
+
+	if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
+	    !rk_hdptx_phy_clk_pll_calc(bit_rate, NULL))
+		return -EINVAL;
+
+	return rate;
+}
+
+static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
+
+	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
+}
+
+static const struct clk_ops hdptx_phy_clk_ops = {
+	.prepare = rk_hdptx_phy_clk_prepare,
+	.unprepare = rk_hdptx_phy_clk_unprepare,
+	.recalc_rate = rk_hdptx_phy_clk_recalc_rate,
+	.round_rate = rk_hdptx_phy_clk_round_rate,
+	.set_rate = rk_hdptx_phy_clk_set_rate,
+};
+
+static int rk_hdptx_phy_clk_register(struct rk_hdptx_phy *hdptx)
+{
+	struct device *dev = hdptx->dev;
+	const char *name, *pname;
+	struct clk *refclk;
+	int ret, id;
+
+	refclk = devm_clk_get(dev, "ref");
+	if (IS_ERR(refclk))
+		return dev_err_probe(dev, PTR_ERR(refclk),
+				     "Failed to get ref clock\n");
+
+	id = of_alias_get_id(dev->of_node, "hdptxphy");
+	name = id > 0 ? "clk_hdmiphy_pixel1" : "clk_hdmiphy_pixel0";
+	pname = __clk_get_name(refclk);
+
+	hdptx->hw.init = CLK_HW_INIT(name, pname, &hdptx_phy_clk_ops,
+				     CLK_GET_RATE_NOCACHE);
+
+	ret = devm_clk_hw_register(dev, &hdptx->hw);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register clock\n");
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &hdptx->hw);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register clk provider\n");
+	return 0;
+}
+
 static int rk_hdptx_phy_runtime_suspend(struct device *dev)
 {
 	struct rk_hdptx_phy *hdptx = dev_get_drvdata(dev);
@@ -987,7 +1138,7 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 	reset_control_deassert(hdptx->rsts[RST_CMN].rstc);
 	reset_control_deassert(hdptx->rsts[RST_INIT].rstc);
 
-	return 0;
+	return rk_hdptx_phy_clk_register(hdptx);
 }
 
 static const struct dev_pm_ops rk_hdptx_phy_pm_ops = {

-- 
2.45.2



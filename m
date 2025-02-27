Return-Path: <linux-kernel+bounces-536099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8724CA47B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9462C7A58B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD422AE76;
	Thu, 27 Feb 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ULhwrt4C"
Received: from mail-m49229.qiye.163.com (mail-m49229.qiye.163.com [45.254.49.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779322AE7B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654531; cv=none; b=bhP2MacLs0VVH2X31TQf0tESH78CkKaKitd0W/p6x90TzYKTeNnFLwUMLzS7h3XmPfQY98fFSnhXCO9lzW/IYvp707qtG037LCfbovyzpWl2OgUjXlnVWuOKFQT9/SRI/t6T8LR2hBNPj6xa9h180NPF4uDf7nExODvAkl3wJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654531; c=relaxed/simple;
	bh=QHn4HGGrNEHup49JMpTVd+MF/a35K53V/neZlMLU8vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAMq86hLdAQjg12qjhgs8IC8JgYVK+pbNyNPThC2yfPC2riwOIxpw9UDQKOCW/o/iYGK7kIqUxy56NtihF5d2p4riWrpQBNmcK0IQGnoS2Gg7MTtU3HsFQn2t9r5y42iC2f3JiC51z3EvEUWg34IuFVMAzYGXQzGWbH8iu2/x2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ULhwrt4C; arc=none smtp.client-ip=45.254.49.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65b3847;
	Thu, 27 Feb 2025 19:08:39 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Jon Lin <jon.lin@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] phy: rockchip-naneng-combo: Support rk3562
Date: Thu, 27 Feb 2025 19:08:36 +0800
Message-Id: <20250227110836.2343158-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227110836.2343158-1-kever.yang@rock-chips.com>
References: <20250227110836.2343158-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4ZTFYfTU1NGUtJGRhNThhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEtNQk
	tVSktLVUpCWQY+
X-HM-Tid: 0a95471824e603afkunmc65b3847
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6KBw*KTIQPw0QEhQ5LiIr
	N0wKCTNVSlVKTE9LTU5PTklLTE9OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTU9NNwY+
DKIM-Signature:a=rsa-sha256;
	b=ULhwrt4CtUYgtoeVhaymrZeyMuRaiMahRK817+qjyUak3w4pOORljjkbvn+1GxclU3P0EXgGFnt9vYGesjtcFKCKnssCta5H2VP7mGI2+uwMPVw6mQH+o4XuDaeZFjIV6sSw3QsbSW+j6dh1yqfi+WM4h1zpunFV0/JXmnmpxhU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=k263oKWboHCcuxXXk1JkUAVYt1B/neLERbLAUbODuas=;
	h=date:mime-version:subject:message-id:from;

From: Jon Lin <jon.lin@rock-chips.com>

rk3562 has 1 naneng comboPHY used for PCIe and USB3.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v2:
- Collect review tag

 .../rockchip/phy-rockchip-naneng-combphy.c    | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index a1532ef8bbe9..e4c5e0531b16 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -393,6 +393,154 @@ static int rockchip_combphy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
+{
+	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
+	unsigned long rate;
+	u32 val;
+
+	switch (priv->type) {
+	case PHY_TYPE_PCIE:
+		/* Set SSC downward spread spectrum */
+		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
+					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
+					 PHYREG32);
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
+		break;
+	case PHY_TYPE_USB3:
+		/* Set SSC downward spread spectrum */
+		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
+					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
+					 PHYREG32);
+
+		/* Enable adaptive CTLE for USB3.0 Rx */
+		rockchip_combphy_updatel(priv, PHYREG15_CTLE_EN,
+					 PHYREG15_CTLE_EN, PHYREG15);
+
+		/* Set PLL KVCO fine tuning signals */
+		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK, BIT(3), PHYREG33);
+
+		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
+		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+
+		/* Set PLL input clock divider 1/2 */
+		val = FIELD_PREP(PHYREG6_PLL_DIV_MASK, PHYREG6_PLL_DIV_2);
+		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK, val, PHYREG6);
+
+		/* Set PLL loop divider */
+		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+
+		/* Set PLL KVCO to min and set PLL charge pump current to max */
+		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_usb, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
+		break;
+	default:
+		dev_err(priv->dev, "incompatible PHY type\n");
+		return -EINVAL;
+	}
+
+	rate = clk_get_rate(priv->refclk);
+
+	switch (rate) {
+	case REF_CLOCK_24MHz:
+		if (priv->type == PHY_TYPE_USB3) {
+			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
+			val = FIELD_PREP(PHYREG15_SSC_CNT_MASK, PHYREG15_SSC_CNT_VALUE);
+			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
+						 val, PHYREG15);
+
+			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+		}
+		break;
+	case REF_CLOCK_25MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
+		break;
+	case REF_CLOCK_100MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
+		if (priv->type == PHY_TYPE_PCIE) {
+			/* PLL KVCO tuning fine */
+			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE);
+			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
+						 val, PHYREG33);
+
+			/* Enable controlling random jitter, aka RMJ */
+			writel(0x4, priv->mmio + PHYREG12);
+
+			val = PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT;
+			rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
+						 val, PHYREG6);
+
+			writel(0x32, priv->mmio + PHYREG18);
+			writel(0xf0, priv->mmio + PHYREG11);
+		}
+		break;
+	default:
+		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
+		return -EINVAL;
+	}
+
+	if (priv->ext_refclk) {
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
+		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
+			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
+			val |= PHYREG13_CKRCV_AMP0;
+			rockchip_combphy_updatel(priv, PHYREG13_RESISTER_MASK, val, PHYREG13);
+
+			val = readl(priv->mmio + PHYREG14);
+			val |= PHYREG14_CKRCV_AMP1;
+			writel(val, priv->mmio + PHYREG14);
+		}
+	}
+
+	if (priv->enable_ssc) {
+		val = readl(priv->mmio + PHYREG8);
+		val |= PHYREG8_SSC_EN;
+		writel(val, priv->mmio + PHYREG8);
+	}
+
+	return 0;
+}
+
+static const struct rockchip_combphy_grfcfg rk3562_combphy_grfcfgs = {
+	/* pipe-phy-grf */
+	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
+	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
+	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
+	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
+	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
+	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
+	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
+	.pipe_phymode_sel	= { 0x0008, 1, 1, 0x00, 0x01 },
+	.pipe_rate_sel		= { 0x0008, 2, 2, 0x00, 0x01 },
+	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
+	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
+	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
+	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
+	.pipe_sel_usb		= { 0x000c, 14, 13, 0x00, 0x01 },
+	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
+	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
+	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
+	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
+	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
+};
+
+static const struct rockchip_combphy_cfg rk3562_combphy_cfgs = {
+	.num_phys = 1,
+	.phy_ids = {
+		0xff750000
+	},
+	.grfcfg		= &rk3562_combphy_grfcfgs,
+	.combphy_cfg	= rk3562_combphy_cfg,
+};
+
 static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 {
 	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
@@ -1046,6 +1194,10 @@ static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
 };
 
 static const struct of_device_id rockchip_combphy_of_match[] = {
+	{
+		.compatible = "rockchip,rk3562-naneng-combphy",
+		.data = &rk3562_combphy_cfgs,
+	},
 	{
 		.compatible = "rockchip,rk3568-naneng-combphy",
 		.data = &rk3568_combphy_cfgs,
-- 
2.25.1



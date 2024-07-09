Return-Path: <linux-kernel+bounces-245772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E67992B905
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AE41C2359E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12B158875;
	Tue,  9 Jul 2024 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cioP5CFj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94015539D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526849; cv=none; b=iwnnpvisanpvOAgO8/ixzY2zNQgZCzQNA+7xRCosWngSlblBBw1eHDYrc3iUBBNUc9+LrioF9/bFuMyDn0CxMphvZpcLhNXFDGa+od/vYrYSQtQFSVbFDxGSoryB+6EOtkepBaFWqUA6B2IGBlsI5nJ5jkJqqiW5hvQt2g7L6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526849; c=relaxed/simple;
	bh=hyq32fgzRssDXs8ebNPy9R8MxG8UZRFLu6b5ha/kDTo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E05qzsD5pYHWl9MwmzxZ8+0ztczIQodwCdjUmnpkU9cIzDs5TVBnZcA9JeZ/+3h6SGJ29Fz2l1EZ6TW8rPb+A13vq0nAvVmHD7CelPvFG6+0HqW7SKzfO0pXb/63vayFrS8V+vi64qUFRpxd7ISCOjM5ue9rHrpaAGAaGNzBcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cioP5CFj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 469C78rL053638;
	Tue, 9 Jul 2024 07:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720526828;
	bh=RbPArqZ2DUzrhYU5Rtwc7+IXSTCnBlKk14Zeoilyvpk=;
	h=From:To:CC:Subject:Date;
	b=cioP5CFjIzTSXCrzClp4MaS2MXfCiETvY7XRKXYivt4HvT++/sS3FUJcyv1rEWJgj
	 ftg/qA5gA5JY5ICK6XjwfPwpbdhiwQBnWg8uIDHaDh03qUk8DKKt5WW+c7H0IYwfIE
	 jkvo8DBDPBMOqVdkMWo2XGkAwfzv/woZsPE94C9Y=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 469C78KB013844
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:07:08 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jul 2024 07:07:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jul 2024 07:07:08 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 469C73OK080432;
	Tue, 9 Jul 2024 07:07:04 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <p.zabel@pengutronix.de>,
        <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <thomas.richard@bootlin.com>, <theo.lebrun@bootlin.com>,
        <robh@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] phy: cadence-torrent: add support for three or more links using 2 protocols
Date: Tue, 9 Jul 2024 17:37:03 +0530
Message-ID: <20240709120703.2716397-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The Torrent SERDES can support at most two different protocols. This only
mandates that the device-tree sub-nodes expressing the configuration should
describe links with at-most two different protocols.

The existing implementation however imposes an artificial constraint that
allows only two links (device-tree sub-nodes). As long as at-most two
protocols are chosen, using more than two links to describe them in an
alternating configuration is still a valid configuration of the Torrent
SERDES.

A 3-Link 2-Protocol configuration of the 4-Lane SERDES can be:
Lane 0 => Protocol 1 => Link 1
Lane 1 => Protocol 1 => Link 1
Lane 2 => Protocol 2 => Link 2
Lane 3 => Protocol 1 => Link 3

A 4-Link 2-Protocol configuration of the 4-Lane SERDES can be:
Lane 0 => Protocol 1 => Link 1
Lane 1 => Protocol 2 => Link 2
Lane 2 => Protocol 1 => Link 3
Lane 3 => Protocol 2 => Link 4

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240709.
Patch has been sanity tested on J7200-EVM which has the 4-Lane Torrent
SERDES in a PCIe+QSGMII multi-link configuration as follows:
SERDES0 Lanes 0 and 1 for PCIe
SERDES0 Lane2 for QSGMII

I have also sanity tested the 3 subnode use-case:
SERDES0 Lanes 0 and 1 for PCIe -> SUBNODE 1
SERDES0 Lane2 for QSGMII -> SUBNODE 2
SERDES0 Lane3 for PCIe -> SUBNODE 3
verifying that Lanes 0 and 1 for PCIe and Lane2 for QSGMII are functional.
Since the PCIe on the J7200-EVM doesn't support splitting the link, I
could not verify functionality of SERDES0 Lane3 as PCIe.

The intended use-case supported by this patch is something like:
SERDES0 Lane0 for SGMII
SERDES0 Lane1 for SGMII
SERDES0 Lane2 for QSGMII
SERDES0 Lane3 for SGMII
which still is only 2 protocols: SGMII and QSGMII
but requires 3 device-tree subnodes to express it. Such a configuration is
not currently supported by the driver. This patch aims to support such
use-cases as well.

Regards,
Siddharth.

 drivers/phy/cadence/phy-cadence-torrent.c | 239 +++++++++++-----------
 1 file changed, 124 insertions(+), 115 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 56ce82a47f88..58e9f8d82630 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -351,6 +351,7 @@ struct cdns_torrent_phy {
 	void __iomem *sd_base; /* SD0801 registers base */
 	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
 	u32 dp_pll;
+	u32 protocol_bitmask;
 	struct reset_control *phy_rst;
 	struct reset_control *apb_rst;
 	struct device *dev;
@@ -2475,21 +2476,21 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	struct cdns_reg_pairs *reg_pairs;
 	enum cdns_torrent_ssc_mode ssc;
 	struct regmap *regmap;
-	u32 num_regs;
+	u32 num_regs, protocol;
 
-	/* Maximum 2 links (subnodes) are supported */
-	if (cdns_phy->nsubnodes != 2)
+	/* Maximum 2 protocols are supported */
+	if (hweight32(cdns_phy->protocol_bitmask) != 2)
 		return -EINVAL;
 
-	phy_t1 = cdns_phy->phys[0].phy_type;
-	phy_t2 = cdns_phy->phys[1].phy_type;
+	phy_t1 = fns(cdns_phy->protocol_bitmask, 0);
+	phy_t2 = fns(cdns_phy->protocol_bitmask, 1);
 
 	/**
 	 * First configure the PHY for first link with phy_t1. Get the array
 	 * values as [phy_t1][phy_t2][ssc].
 	 */
-	for (node = 0; node < cdns_phy->nsubnodes; node++) {
-		if (node == 1) {
+	for (protocol = 0; protocol < 2; protocol++) {
+		if (protocol == 1) {
 			/**
 			 * If first link with phy_t1 is configured, then
 			 * configure the PHY for second link with phy_t2.
@@ -2499,130 +2500,136 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			swap(ref_clk, ref_clk1);
 		}
 
-		mlane = cdns_phy->phys[node].mlane;
-		ssc = cdns_phy->phys[node].ssc_mode;
-		num_lanes = cdns_phy->phys[node].num_lanes;
+		for (node = 0; node < cdns_phy->nsubnodes; node++) {
+			if (cdns_phy->phys[node].phy_type != phy_t1)
+				continue;
 
-		/**
-		 * PHY configuration specific registers:
-		 * link_cmn_vals depend on combination of PHY types being
-		 * configured and are common for both PHY types, so array
-		 * values should be same for [phy_t1][phy_t2][ssc] and
-		 * [phy_t2][phy_t1][ssc].
-		 * xcvr_diag_vals also depend on combination of PHY types
-		 * being configured, but these can be different for particular
-		 * PHY type and are per lane.
-		 */
-		link_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->link_cmn_vals_tbl,
-							  CLK_ANY, CLK_ANY,
-							  phy_t1, phy_t2, ANY_SSC);
-		if (link_cmn_vals) {
-			reg_pairs = link_cmn_vals->reg_pairs;
-			num_regs = link_cmn_vals->num_regs;
-			regmap = cdns_phy->regmap_common_cdb;
+			mlane = cdns_phy->phys[node].mlane;
+			ssc = cdns_phy->phys[node].ssc_mode;
+			num_lanes = cdns_phy->phys[node].num_lanes;
 
 			/**
-			 * First array value in link_cmn_vals must be of
-			 * PHY_PLL_CFG register
+			 * PHY configuration specific registers:
+			 * link_cmn_vals depend on combination of PHY types being
+			 * configured and are common for both PHY types, so array
+			 * values should be same for [phy_t1][phy_t2][ssc] and
+			 * [phy_t2][phy_t1][ssc].
+			 * xcvr_diag_vals also depend on combination of PHY types
+			 * being configured, but these can be different for particular
+			 * PHY type and are per lane.
 			 */
-			regmap_field_write(cdns_phy->phy_pll_cfg,
-					   reg_pairs[0].val);
+			link_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->link_cmn_vals_tbl,
+								  CLK_ANY, CLK_ANY,
+								  phy_t1, phy_t2, ANY_SSC);
+			if (link_cmn_vals) {
+				reg_pairs = link_cmn_vals->reg_pairs;
+				num_regs = link_cmn_vals->num_regs;
+				regmap = cdns_phy->regmap_common_cdb;
 
-			for (i = 1; i < num_regs; i++)
-				regmap_write(regmap, reg_pairs[i].off,
-					     reg_pairs[i].val);
-		}
+				/**
+				 * First array value in link_cmn_vals must be of
+				 * PHY_PLL_CFG register
+				 */
+				regmap_field_write(cdns_phy->phy_pll_cfg,
+						   reg_pairs[0].val);
 
-		xcvr_diag_vals = cdns_torrent_get_tbl_vals(&init_data->xcvr_diag_vals_tbl,
-							   CLK_ANY, CLK_ANY,
-							   phy_t1, phy_t2, ANY_SSC);
-		if (xcvr_diag_vals) {
-			reg_pairs = xcvr_diag_vals->reg_pairs;
-			num_regs = xcvr_diag_vals->num_regs;
-			for (i = 0; i < num_lanes; i++) {
-				regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
-				for (j = 0; j < num_regs; j++)
-					regmap_write(regmap, reg_pairs[j].off,
-						     reg_pairs[j].val);
+				for (i = 1; i < num_regs; i++)
+					regmap_write(regmap, reg_pairs[i].off,
+						     reg_pairs[i].val);
 			}
-		}
 
-		/* PHY PCS common registers configurations */
-		pcs_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->pcs_cmn_vals_tbl,
-							 CLK_ANY, CLK_ANY,
-							 phy_t1, phy_t2, ANY_SSC);
-		if (pcs_cmn_vals) {
-			reg_pairs = pcs_cmn_vals->reg_pairs;
-			num_regs = pcs_cmn_vals->num_regs;
-			regmap = cdns_phy->regmap_phy_pcs_common_cdb;
-			for (i = 0; i < num_regs; i++)
-				regmap_write(regmap, reg_pairs[i].off,
-					     reg_pairs[i].val);
-		}
+			xcvr_diag_vals = cdns_torrent_get_tbl_vals(&init_data->xcvr_diag_vals_tbl,
+								   CLK_ANY, CLK_ANY,
+								   phy_t1, phy_t2, ANY_SSC);
+			if (xcvr_diag_vals) {
+				reg_pairs = xcvr_diag_vals->reg_pairs;
+				num_regs = xcvr_diag_vals->num_regs;
+				for (i = 0; i < num_lanes; i++) {
+					regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
+					for (j = 0; j < num_regs; j++)
+						regmap_write(regmap, reg_pairs[j].off,
+							     reg_pairs[j].val);
+				}
+			}
 
-		/* PHY PMA common registers configurations */
-		phy_pma_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->phy_pma_cmn_vals_tbl,
-							     CLK_ANY, CLK_ANY,
-							     phy_t1, phy_t2, ANY_SSC);
-		if (phy_pma_cmn_vals) {
-			reg_pairs = phy_pma_cmn_vals->reg_pairs;
-			num_regs = phy_pma_cmn_vals->num_regs;
-			regmap = cdns_phy->regmap_phy_pma_common_cdb;
-			for (i = 0; i < num_regs; i++)
-				regmap_write(regmap, reg_pairs[i].off,
-					     reg_pairs[i].val);
-		}
+			/* PHY PCS common registers configurations */
+			pcs_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->pcs_cmn_vals_tbl,
+								 CLK_ANY, CLK_ANY,
+								 phy_t1, phy_t2, ANY_SSC);
+			if (pcs_cmn_vals) {
+				reg_pairs = pcs_cmn_vals->reg_pairs;
+				num_regs = pcs_cmn_vals->num_regs;
+				regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+				for (i = 0; i < num_regs; i++)
+					regmap_write(regmap, reg_pairs[i].off,
+						     reg_pairs[i].val);
+			}
 
-		/* PMA common registers configurations */
-		cmn_vals = cdns_torrent_get_tbl_vals(&init_data->cmn_vals_tbl,
-						     ref_clk, ref_clk1,
-						     phy_t1, phy_t2, ssc);
-		if (cmn_vals) {
-			reg_pairs = cmn_vals->reg_pairs;
-			num_regs = cmn_vals->num_regs;
-			regmap = cdns_phy->regmap_common_cdb;
-			for (i = 0; i < num_regs; i++)
-				regmap_write(regmap, reg_pairs[i].off,
-					     reg_pairs[i].val);
-		}
+			/* PHY PMA common registers configurations */
+			phy_pma_cmn_vals =
+				cdns_torrent_get_tbl_vals(&init_data->phy_pma_cmn_vals_tbl,
+							  CLK_ANY, CLK_ANY, phy_t1, phy_t2,
+							  ANY_SSC);
+			if (phy_pma_cmn_vals) {
+				reg_pairs = phy_pma_cmn_vals->reg_pairs;
+				num_regs = phy_pma_cmn_vals->num_regs;
+				regmap = cdns_phy->regmap_phy_pma_common_cdb;
+				for (i = 0; i < num_regs; i++)
+					regmap_write(regmap, reg_pairs[i].off,
+						     reg_pairs[i].val);
+			}
 
-		/* PMA TX lane registers configurations */
-		tx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->tx_ln_vals_tbl,
-						       ref_clk, ref_clk1,
-						       phy_t1, phy_t2, ssc);
-		if (tx_ln_vals) {
-			reg_pairs = tx_ln_vals->reg_pairs;
-			num_regs = tx_ln_vals->num_regs;
-			for (i = 0; i < num_lanes; i++) {
-				regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
-				for (j = 0; j < num_regs; j++)
-					regmap_write(regmap, reg_pairs[j].off,
-						     reg_pairs[j].val);
+			/* PMA common registers configurations */
+			cmn_vals = cdns_torrent_get_tbl_vals(&init_data->cmn_vals_tbl,
+							     ref_clk, ref_clk1,
+							     phy_t1, phy_t2, ssc);
+			if (cmn_vals) {
+				reg_pairs = cmn_vals->reg_pairs;
+				num_regs = cmn_vals->num_regs;
+				regmap = cdns_phy->regmap_common_cdb;
+				for (i = 0; i < num_regs; i++)
+					regmap_write(regmap, reg_pairs[i].off,
+						     reg_pairs[i].val);
 			}
-		}
 
-		/* PMA RX lane registers configurations */
-		rx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->rx_ln_vals_tbl,
-						       ref_clk, ref_clk1,
-						       phy_t1, phy_t2, ssc);
-		if (rx_ln_vals) {
-			reg_pairs = rx_ln_vals->reg_pairs;
-			num_regs = rx_ln_vals->num_regs;
-			for (i = 0; i < num_lanes; i++) {
-				regmap = cdns_phy->regmap_rx_lane_cdb[i + mlane];
-				for (j = 0; j < num_regs; j++)
-					regmap_write(regmap, reg_pairs[j].off,
-						     reg_pairs[j].val);
+			/* PMA TX lane registers configurations */
+			tx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->tx_ln_vals_tbl,
+							       ref_clk, ref_clk1,
+							       phy_t1, phy_t2, ssc);
+			if (tx_ln_vals) {
+				reg_pairs = tx_ln_vals->reg_pairs;
+				num_regs = tx_ln_vals->num_regs;
+				for (i = 0; i < num_lanes; i++) {
+					regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
+					for (j = 0; j < num_regs; j++)
+						regmap_write(regmap, reg_pairs[j].off,
+							     reg_pairs[j].val);
+				}
 			}
-		}
 
-		if (phy_t1 == TYPE_DP) {
-			ret = cdns_torrent_dp_get_pll(cdns_phy, phy_t2);
-			if (ret)
-				return ret;
-		}
+			/* PMA RX lane registers configurations */
+			rx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->rx_ln_vals_tbl,
+							       ref_clk, ref_clk1,
+							       phy_t1, phy_t2, ssc);
+			if (rx_ln_vals) {
+				reg_pairs = rx_ln_vals->reg_pairs;
+				num_regs = rx_ln_vals->num_regs;
+				for (i = 0; i < num_lanes; i++) {
+					regmap = cdns_phy->regmap_rx_lane_cdb[i + mlane];
+					for (j = 0; j < num_regs; j++)
+						regmap_write(regmap, reg_pairs[j].off,
+							     reg_pairs[j].val);
+				}
+			}
 
-		reset_control_deassert(cdns_phy->phys[node].lnk_rst);
+			if (phy_t1 == TYPE_DP) {
+				ret = cdns_torrent_dp_get_pll(cdns_phy, phy_t2);
+				if (ret)
+					return ret;
+			}
+
+			reset_control_deassert(cdns_phy->phys[node].lnk_rst);
+		}
 	}
 
 	/* Take the PHY out of reset */
@@ -2826,6 +2833,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, cdns_phy);
 	cdns_phy->dev = dev;
 	cdns_phy->init_data = data;
+	cdns_phy->protocol_bitmask = 0;
 
 	cdns_phy->sd_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cdns_phy->sd_base))
@@ -3010,6 +3018,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		}
 
 		cdns_phy->phys[node].phy = gphy;
+		cdns_phy->protocol_bitmask |= BIT(cdns_phy->phys[node].phy_type);
 		phy_set_drvdata(gphy, &cdns_phy->phys[node]);
 
 		node++;
-- 
2.40.1



Return-Path: <linux-kernel+bounces-274458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7C194784C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF392B22568
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44001527AF;
	Mon,  5 Aug 2024 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UUS0iTiQ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A34154426
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850011; cv=none; b=ILt8ijhCNV1b3b5hEJZ6ShRNfMxpGa4sxauuzpvantoqkgiwgIQPVElQX4Mxqviff1Hk3eum8iFGJhvVKyx7BZv6eXPnVmZdfWeDqtg9Q3x4Z4/KqSu+4zpgj5qm/WUMrRPro28t91PtyTjFx2Jj2Vm3tQjYbMuX+8Qi3YPymBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850011; c=relaxed/simple;
	bh=uMtQsuyPFeZLRzghyfADaGXiMGJwyghefsx3OGEOh6g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2bwf7kIafLy1EjXHqR28l9xssyuw3G/CuT7Nzqz9xZtwKQRZ7xAzK+EEfiC+7Gvq6zlJ8Ph+00H+J+7s3WjUwTYFiY16aKdeO9QwIboeolNxo4u9eGKqBaW2Fndwpzr35qQviCaHzQiKIYRhkhedHY69ANb2BACgeUtc6IN/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UUS0iTiQ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4759QCHE066999;
	Mon, 5 Aug 2024 04:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722849972;
	bh=PLtvQM6mK0ErbG4GpXkO3aHV9a/JpRkzS9nxiChIEdI=;
	h=From:To:CC:Subject:Date;
	b=UUS0iTiQa31df7NmfaYHxyxe0hPzjNSNNU/K2ZCQNrx7YvpC/qw6gXlIK5a0/w8fb
	 0dgAP0JKkB8lmAB379ZeiCHY88W8imt99JNkUiBHqNpAoL/M71SRPy+FQVER8l5574
	 ULzdIAXxAkNIyu/pXHf6em3lob0vbXVN+ijUkv7A=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4759QCs4063377
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Aug 2024 04:26:12 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Aug 2024 04:26:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Aug 2024 04:26:12 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4759Q7Lp004882;
	Mon, 5 Aug 2024 04:26:08 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <p.zabel@pengutronix.de>,
        <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <thomas.richard@bootlin.com>, <theo.lebrun@bootlin.com>,
        <christophe.jaillet@wanadoo.fr>, <robh@kernel.org>,
        <make24@iscas.ac.cn>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4] phy: cadence-torrent: add support for three or more links using 2 protocols
Date: Mon, 5 Aug 2024 14:56:07 +0530
Message-ID: <20240805092607.143869-1-s-vadapalli@ti.com>
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

The Torrent SERDES can support at most two different protocols (PHY types).
This only mandates that the device-tree sub-nodes used to represent the
configuration should describe links with at-most two different protocols.

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
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

Hello,

This patch is based on linux-next tagged next-20240805.
Patch has been sanity tested and tested for functionality in the following
configurations with the Torrent SERDES0 on J7200-EVM:
1. PCIe (Lanes 0 and 1) + QSGMII (Lane 2)
   => 2 protocols, 2 links
2. PCIe (Lanes 0 and 1) + QSGMII (Lane 2) + PCIe (Lane 3)
   => 2 protocols, 3 links

v3:
https://lore.kernel.org/r/20240716102442.1605280-1-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on linux-next tagged next-20240805.
- Collected Reviewed-by tag from Roger Quadros <rogerq@kernel.org>
  https://lore.kernel.org/r/1c393235-3bf3-4c89-ab54-42de5a33c8c2@kernel.org/

v2:
https://lore.kernel.org/r/20240710115624.3232925-1-s-vadapalli@ti.com/
Changes since v2:
- Based on Swapnil and Roger's feedback on the v2 patch, the
  configuration will be performed as follows:
  1) For Multilink configuration with 2 sub-nodes, irrespective of
  whether or not the protocols/phy-types are same or different,
  the phy-types present in the sub-nodes are used as-is and the
  configuration is performed by iterating over the sub-nodes.
  This is identical to the existing implementation and PCIe Multilink
  which is a single protocol expressed with 2 sub-nodes can also be
  supported.
  2) For Multilink configuration with 3 or more sub-nodes, the
  configuration is performed by iterating over all sub-nodes and
  configuring those which match the first protocol, followed by
  iterating over all sub-nodes and configuring the ones which match the
  second protocol. This supports 3 or 4 links as long as the number of
  protocols is still 2 (all array values are of the type
  [phy_t1][phy_t2], so only two different protocols are supported).

v1:
https://lore.kernel.org/r/20240709120703.2716397-1-s-vadapalli@ti.com/
Changes since v1:
- A multilink configuration doesn't necessarily imply two protocols
  since a single protocol may be split across links as follows:
  Lane 0 => Protocol 1
  Lane 1 => Unused
  Lane 2 => Protocol 1
  Lane 3 => Unused
  which corresponds to two links and therefore two sub-nodes. In such a
  case, treat it as two single-link configurations performed sequentially
  which happens to be the case prior to this patch. To address this,
  handle the case where cdns_torrent_phy_configure_multilink() can be
  invoked for a single protocol with multiple sub-nodes (links) by
  erroring out only when the number of protocols is strictly greater
  than two, followed by handling the configuration similar to how it was
  done prior to this patch.

Regards,
Siddharth.

 drivers/phy/cadence/phy-cadence-torrent.c | 291 +++++++++++++---------
 1 file changed, 172 insertions(+), 119 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a2d32d5f6b07..8bbbbb87bb22 100644
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
@@ -2473,156 +2474,206 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	enum cdns_torrent_phy_type phy_t1, phy_t2;
 	const struct cdns_reg_pairs *reg_pairs;
 	int i, j, node, mlane, num_lanes, ret;
+	struct device *dev = cdns_phy->dev;
 	enum cdns_torrent_ssc_mode ssc;
 	struct regmap *regmap;
-	u32 num_regs;
+	u32 num_regs, num_protocols, protocol;
 
-	/* Maximum 2 links (subnodes) are supported */
-	if (cdns_phy->nsubnodes != 2)
+	num_protocols = hweight32(cdns_phy->protocol_bitmask);
+	/* Maximum 2 protocols are supported */
+	if (num_protocols > 2) {
+		dev_err(dev, "at most 2 protocols are supported\n");
 		return -EINVAL;
+	}
 
-	phy_t1 = cdns_phy->phys[0].phy_type;
-	phy_t2 = cdns_phy->phys[1].phy_type;
 
 	/**
-	 * First configure the PHY for first link with phy_t1. Get the array
-	 * values as [phy_t1][phy_t2][ssc].
+	 * Get PHY types directly from subnodes if only 2 subnodes exist.
+	 * It is possible for phy_t1 to be the same as phy_t2 for special
+	 * configurations such as PCIe Multilink.
 	 */
-	for (node = 0; node < cdns_phy->nsubnodes; node++) {
-		if (node == 1) {
+	if (cdns_phy->nsubnodes == 2) {
+		phy_t1 = cdns_phy->phys[0].phy_type;
+		phy_t2 = cdns_phy->phys[1].phy_type;
+	} else {
+		/**
+		 * Both PHY types / protocols should be unique.
+		 * If they are the same, it should be expressed with either
+		 * a) Single-Link (1 Sub-node) - handled via PHY APIs
+		 * OR
+		 * b) Double-Link (2 Sub-nodes) - handled above
+		 */
+		if (num_protocols != 2) {
+			dev_err(dev, "incorrect representation of link\n");
+			return -EINVAL;
+		}
+
+		phy_t1 = fns(cdns_phy->protocol_bitmask, 0);
+		phy_t2 = fns(cdns_phy->protocol_bitmask, 1);
+	}
+
+	/**
+	 * Configure all links with the protocol phy_t1 first followed by
+	 * configuring all links with the protocol phy_t2.
+	 *
+	 * When phy_t1 = phy_t2, it is a single protocol and configuration
+	 * is performed with a single iteration of the protocol and multiple
+	 * iterations over the sub-nodes (links).
+	 *
+	 * When phy_t1 != phy_t2, there are two protocols and configuration
+	 * is performed by iterating over all sub-nodes matching the first
+	 * protocol and configuring them first, followed by iterating over
+	 * all sub-nodes matching the second protocol and configuring them
+	 * next.
+	 */
+	for (protocol = 0; protocol < num_protocols; protocol++) {
+		/**
+		 * For the case where num_protocols is 1,
+		 * phy_t1 = phy_t2 and the swap is unnecessary.
+		 *
+		 * Swapping phy_t1 and phy_t2 is only required when the
+		 * number of protocols is 2 and there are 2 or more links.
+		 */
+		if (protocol == 1) {
 			/**
-			 * If first link with phy_t1 is configured, then
-			 * configure the PHY for second link with phy_t2.
+			 * If first protocol with phy_t1 is configured, then
+			 * configure the PHY for second protocol with phy_t2.
 			 * Get the array values as [phy_t2][phy_t1][ssc].
 			 */
 			swap(phy_t1, phy_t2);
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
@@ -2826,6 +2877,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, cdns_phy);
 	cdns_phy->dev = dev;
 	cdns_phy->init_data = data;
+	cdns_phy->protocol_bitmask = 0;
 
 	cdns_phy->sd_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cdns_phy->sd_base))
@@ -3010,6 +3062,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		}
 
 		cdns_phy->phys[node].phy = gphy;
+		cdns_phy->protocol_bitmask |= BIT(cdns_phy->phys[node].phy_type);
 		phy_set_drvdata(gphy, &cdns_phy->phys[node]);
 
 		node++;
-- 
2.40.1



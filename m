Return-Path: <linux-kernel+bounces-249615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900FA92EDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E4C283A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606616E89B;
	Thu, 11 Jul 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UCdmwYjO"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A416DC0F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719106; cv=none; b=N9WIUfjWVcSBA1YqY7q/af8SioY+L0iHaZOdg2tAA0ITa5+fi2wFoBF6U0WIVzvtVpNJf6euOGuiRZn9U57bjmZHxWtmYDP1jjoWihZ9O4yYmqpldznKC4dV5jerDsXXLUsiOkETbWduu8/FHdbNKFkTNBL4CiLrM892gXx8o5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719106; c=relaxed/simple;
	bh=d0rz10bABHfwQA8K1RS5jZzki6RQ8u69L/YIFc0LRcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKBOPBmiAMPPdNOnw17A4kV9FkeGjpLwS0Ryp69awpRay0KWzgJ9ckB6jsI4GVEGkQp4MxOQomiK1nFuzVBmSHSZgCiRPVqKDZXXvbCItUxniKQb3F1qcoSQsUj3QGPCOQh2NL/BR34aRskEqpKbLCjww6hxkSXDRa/ds6mW0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UCdmwYjO; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id RxdPsAr1uHTrpRxdusVM4d; Thu, 11 Jul 2024 19:31:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720719103;
	bh=IHSzGyCBZ96fFD83zyiq1j3cJyuFru4VA9guWRHtEyk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UCdmwYjOUnPrpZiWvXPZ9ownhx2wSPvs4wXDSoL3btvDx714fuFvmz5bbArkuohJV
	 w6pYqGqYspALbZCo8AyJEB6T4hFWjNu5LpcVQ+fZyCLs0skhElqx8ee8fhDK9j3T6B
	 1iHT3FYrygyaY5CcQ9FuBVZe3Wqpv6UUeN2N6B+/UeluXcgoVZub4cjRFemwRlYipa
	 DN+05RfpvU39pJmN/ddMYZzWtooTykOg5Gd5+fN78a6598FIlRiSFXHS+nPWuhGVoB
	 48l2F5eKUcBn6gWuSZvJREQ/gJ2YJFz0gjRR42ZMlb4vorF4mz6Pv82la6EXwrQPSB
	 z0+QHgIZ0N+FQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jul 2024 19:31:43 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/4] phy: cadence-torrent: Constify struct cdns_torrent_vals
Date: Thu, 11 Jul 2024 19:31:08 +0200
Message-ID: <d9d135ee9b806726766a1bc5e1404267939aa637.1720718240.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720718240.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720718240.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct cdns_torrent_vals' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  92234	   6078	     16	  98328	  18018	drivers/phy/cadence/phy-cadence-torrent.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  93578	   4798	     16	  98392	  18058	drivers/phy/cadence/phy-cadence-torrent.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/phy/cadence/phy-cadence-torrent.c | 182 +++++++++++-----------
 1 file changed, 91 insertions(+), 91 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 6787d64ee982..e99fa19aafb2 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -428,7 +428,7 @@ struct cdns_torrent_vals {
 
 struct cdns_torrent_vals_entry {
 	u32 key;
-	struct cdns_torrent_vals *vals;
+	const struct cdns_torrent_vals *vals;
 };
 
 struct cdns_torrent_vals_table {
@@ -454,12 +454,12 @@ struct cdns_regmap_cdb_context {
 	u8 reg_offset_shift;
 };
 
-static struct cdns_torrent_vals *cdns_torrent_get_tbl_vals(const struct cdns_torrent_vals_table *tbl,
-							   enum cdns_torrent_ref_clk refclk0,
-							   enum cdns_torrent_ref_clk refclk1,
-							   enum cdns_torrent_phy_type link0,
-							   enum cdns_torrent_phy_type link1,
-							   enum cdns_torrent_ssc_mode ssc)
+static const struct cdns_torrent_vals *cdns_torrent_get_tbl_vals(const struct cdns_torrent_vals_table *tbl,
+								 enum cdns_torrent_ref_clk refclk0,
+								 enum cdns_torrent_ref_clk refclk1,
+								 enum cdns_torrent_phy_type link0,
+								 enum cdns_torrent_phy_type link1,
+								 enum cdns_torrent_ssc_mode ssc)
 {
 	int i;
 	u32 key = CDNS_TORRENT_KEY(refclk0, refclk1, link0, link1, ssc);
@@ -2306,15 +2306,15 @@ static int cdns_torrent_regmap_init(struct cdns_torrent_phy *cdns_phy)
 static int cdns_torrent_phy_init(struct phy *phy)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	const struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
-	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	const struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
-	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
+	const struct cdns_torrent_vals *phy_pma_cmn_vals;
 	enum cdns_torrent_ssc_mode ssc = inst->ssc_mode;
-	struct cdns_torrent_vals *phy_pma_cmn_vals;
-	struct cdns_torrent_vals *pcs_cmn_vals;
+	const struct cdns_torrent_vals *pcs_cmn_vals;
 	const struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
 	u32 num_regs;
@@ -2463,14 +2463,14 @@ static const struct phy_ops cdns_torrent_phy_ops = {
 static
 int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 {
+	const struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
-	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	const struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_ref_clk ref_clk1 = cdns_phy->ref_clk1_rate;
 	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
-	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
+	const struct cdns_torrent_vals *phy_pma_cmn_vals;
+	const struct cdns_torrent_vals *pcs_cmn_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2;
-	struct cdns_torrent_vals *phy_pma_cmn_vals;
-	struct cdns_torrent_vals *pcs_cmn_vals;
 	const struct cdns_reg_pairs *reg_pairs;
 	int i, j, node, mlane, num_lanes, ret;
 	enum cdns_torrent_ssc_mode ssc;
@@ -3088,12 +3088,12 @@ static const struct cdns_reg_pairs sgmii_qsgmii_xcvr_diag_ln_regs[] = {
 	{0x0113, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals sgmii_qsgmii_link_cmn_vals = {
+static const struct cdns_torrent_vals sgmii_qsgmii_link_cmn_vals = {
 	.reg_pairs = sgmii_qsgmii_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(sgmii_qsgmii_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals sgmii_qsgmii_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals sgmii_qsgmii_xcvr_diag_ln_vals = {
 	.reg_pairs = sgmii_qsgmii_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_qsgmii_xcvr_diag_ln_regs),
 };
@@ -3171,17 +3171,17 @@ static const struct cdns_reg_pairs dp_usb_xcvr_diag_ln_regs[] = {
 	{0x0009, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals usb_dp_link_cmn_vals = {
+static const struct cdns_torrent_vals usb_dp_link_cmn_vals = {
 	.reg_pairs = usb_dp_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(usb_dp_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals usb_dp_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals usb_dp_xcvr_diag_ln_vals = {
 	.reg_pairs = usb_dp_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(usb_dp_xcvr_diag_ln_regs),
 };
 
-static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
 	.reg_pairs = dp_usb_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(dp_usb_xcvr_diag_ln_regs),
 };
@@ -3205,17 +3205,17 @@ static const struct cdns_reg_pairs sgmii_usxgmii_xcvr_diag_ln_regs[] = {
 	{0x0A9B, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals usxgmii_sgmii_link_cmn_vals = {
+static const struct cdns_torrent_vals usxgmii_sgmii_link_cmn_vals = {
 	.reg_pairs = usxgmii_sgmii_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(usxgmii_sgmii_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals usxgmii_sgmii_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals usxgmii_sgmii_xcvr_diag_ln_vals = {
 	.reg_pairs = usxgmii_sgmii_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(usxgmii_sgmii_xcvr_diag_ln_regs),
 };
 
-static struct cdns_torrent_vals sgmii_usxgmii_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals sgmii_usxgmii_xcvr_diag_ln_vals = {
 	.reg_pairs = sgmii_usxgmii_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_usxgmii_xcvr_diag_ln_regs),
 };
@@ -3233,7 +3233,7 @@ static const struct cdns_reg_pairs ml_usxgmii_pll0_156_25_no_ssc_cmn_regs[] = {
 	{0x0138, CMN_PLL0_LOCK_PLLCNT_START}
 };
 
-static struct cdns_torrent_vals ml_usxgmii_pll0_156_25_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals ml_usxgmii_pll0_156_25_no_ssc_cmn_vals = {
 	.reg_pairs = ml_usxgmii_pll0_156_25_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(ml_usxgmii_pll0_156_25_no_ssc_cmn_regs),
 };
@@ -3248,7 +3248,7 @@ static const struct cdns_reg_pairs ml_sgmii_pll1_100_no_ssc_cmn_regs[] = {
 	{0x007F, CMN_TXPDCAL_TUNE}
 };
 
-static struct cdns_torrent_vals ml_sgmii_pll1_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals ml_sgmii_pll1_100_no_ssc_cmn_vals = {
 	.reg_pairs = ml_sgmii_pll1_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(ml_sgmii_pll1_100_no_ssc_cmn_regs),
 };
@@ -3280,7 +3280,7 @@ static const struct cdns_reg_pairs j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_regs[
 	{0x0138, CMN_PLL0_LOCK_PLLCNT_START}
 };
 
-static struct cdns_torrent_vals j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_vals = {
 	.reg_pairs = j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_regs),
 };
@@ -3297,7 +3297,7 @@ static const struct cdns_reg_pairs j7200_ml_sgmii_pll1_100_no_ssc_cmn_regs[] = {
 	{0x007F, CMN_TXPDCAL_TUNE}
 };
 
-static struct cdns_torrent_vals j7200_ml_sgmii_pll1_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals j7200_ml_sgmii_pll1_100_no_ssc_cmn_vals = {
 	.reg_pairs = j7200_ml_sgmii_pll1_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(j7200_ml_sgmii_pll1_100_no_ssc_cmn_regs),
 };
@@ -3322,17 +3322,17 @@ static const struct cdns_reg_pairs usxgmii_pcie_xcvr_diag_ln_regs[] = {
 	{0x0089, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals pcie_usxgmii_link_cmn_vals = {
+static const struct cdns_torrent_vals pcie_usxgmii_link_cmn_vals = {
 	.reg_pairs = pcie_usxgmii_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_usxgmii_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals pcie_usxgmii_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals pcie_usxgmii_xcvr_diag_ln_vals = {
 	.reg_pairs = pcie_usxgmii_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(pcie_usxgmii_xcvr_diag_ln_regs),
 };
 
-static struct cdns_torrent_vals usxgmii_pcie_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals usxgmii_pcie_xcvr_diag_ln_vals = {
 	.reg_pairs = usxgmii_pcie_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(usxgmii_pcie_xcvr_diag_ln_regs),
 };
@@ -3381,17 +3381,17 @@ static const struct cdns_reg_pairs ml_usxgmii_156_25_no_ssc_rx_ln_regs[] = {
 	{0x018C, RX_CDRLF_CNFG}
 };
 
-static struct cdns_torrent_vals ml_usxgmii_pll1_156_25_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals ml_usxgmii_pll1_156_25_no_ssc_cmn_vals = {
 	.reg_pairs = ml_usxgmii_pll1_156_25_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(ml_usxgmii_pll1_156_25_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals ml_usxgmii_156_25_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals ml_usxgmii_156_25_no_ssc_tx_ln_vals = {
 	.reg_pairs = ml_usxgmii_156_25_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(ml_usxgmii_156_25_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals ml_usxgmii_156_25_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals ml_usxgmii_156_25_no_ssc_rx_ln_vals = {
 	.reg_pairs = ml_usxgmii_156_25_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(ml_usxgmii_156_25_no_ssc_rx_ln_regs),
 };
@@ -3401,7 +3401,7 @@ static const struct cdns_reg_pairs ti_usxgmii_phy_pma_cmn_regs[] = {
 	{0x0040, PHY_PMA_CMN_CTRL1},
 };
 
-static struct cdns_torrent_vals ti_usxgmii_phy_pma_cmn_vals = {
+static const struct cdns_torrent_vals ti_usxgmii_phy_pma_cmn_vals = {
 	.reg_pairs = ti_usxgmii_phy_pma_cmn_regs,
 	.num_regs = ARRAY_SIZE(ti_usxgmii_phy_pma_cmn_regs),
 };
@@ -3418,12 +3418,12 @@ static const struct cdns_reg_pairs sl_usxgmii_xcvr_diag_ln_regs[] = {
 	{0x0001, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals sl_usxgmii_link_cmn_vals = {
+static const struct cdns_torrent_vals sl_usxgmii_link_cmn_vals = {
 	.reg_pairs = sl_usxgmii_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_usxgmii_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals sl_usxgmii_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals sl_usxgmii_xcvr_diag_ln_vals = {
 	.reg_pairs = sl_usxgmii_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_usxgmii_xcvr_diag_ln_regs),
 };
@@ -3498,17 +3498,17 @@ static const struct cdns_reg_pairs usxgmii_156_25_no_ssc_rx_ln_regs[] = {
 	{0x018C, RX_CDRLF_CNFG}
 };
 
-static struct cdns_torrent_vals sl_usxgmii_156_25_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sl_usxgmii_156_25_no_ssc_cmn_vals = {
 	.reg_pairs = sl_usxgmii_156_25_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_usxgmii_156_25_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals usxgmii_156_25_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals usxgmii_156_25_no_ssc_tx_ln_vals = {
 	.reg_pairs = usxgmii_156_25_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(usxgmii_156_25_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals usxgmii_156_25_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals usxgmii_156_25_no_ssc_rx_ln_vals = {
 	.reg_pairs = usxgmii_156_25_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(usxgmii_156_25_no_ssc_rx_ln_regs),
 };
@@ -3531,17 +3531,17 @@ static const struct cdns_reg_pairs dp_pcie_xcvr_diag_ln_regs[] = {
 	{0x0009, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals pcie_dp_link_cmn_vals = {
+static const struct cdns_torrent_vals pcie_dp_link_cmn_vals = {
 	.reg_pairs = pcie_dp_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_dp_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals pcie_dp_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals pcie_dp_xcvr_diag_ln_vals = {
 	.reg_pairs = pcie_dp_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(pcie_dp_xcvr_diag_ln_regs),
 };
 
-static struct cdns_torrent_vals dp_pcie_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals dp_pcie_xcvr_diag_ln_vals = {
 	.reg_pairs = dp_pcie_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(dp_pcie_xcvr_diag_ln_regs),
 };
@@ -3569,17 +3569,17 @@ static const struct cdns_reg_pairs dp_100_no_ssc_rx_ln_regs[] = {
 	{0x0000, RX_REE_PERGCSM_CTRL}
 };
 
-static struct cdns_torrent_vals dp_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals dp_100_no_ssc_cmn_vals = {
 	.reg_pairs = dp_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(dp_100_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals dp_100_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals dp_100_no_ssc_tx_ln_vals = {
 	.reg_pairs = dp_100_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(dp_100_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals dp_100_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals dp_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = dp_100_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(dp_100_no_ssc_rx_ln_regs),
 };
@@ -3594,12 +3594,12 @@ static const struct cdns_reg_pairs sl_dp_xcvr_diag_ln_regs[] = {
 	{0x0001, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals sl_dp_link_cmn_vals = {
+static const struct cdns_torrent_vals sl_dp_link_cmn_vals = {
 	.reg_pairs = sl_dp_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals sl_dp_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals sl_dp_xcvr_diag_ln_vals = {
 	.reg_pairs = sl_dp_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_xcvr_diag_ln_regs),
 };
@@ -3660,17 +3660,17 @@ static const struct cdns_reg_pairs sl_dp_19_2_no_ssc_rx_ln_regs[] = {
 	{0x0000, RX_REE_PERGCSM_CTRL}
 };
 
-static struct cdns_torrent_vals sl_dp_19_2_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sl_dp_19_2_no_ssc_cmn_vals = {
 	.reg_pairs = sl_dp_19_2_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_19_2_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals sl_dp_19_2_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals sl_dp_19_2_no_ssc_tx_ln_vals = {
 	.reg_pairs = sl_dp_19_2_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_19_2_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals sl_dp_19_2_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals sl_dp_19_2_no_ssc_rx_ln_vals = {
 	.reg_pairs = sl_dp_19_2_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_19_2_no_ssc_rx_ln_regs),
 };
@@ -3731,17 +3731,17 @@ static const struct cdns_reg_pairs sl_dp_25_no_ssc_rx_ln_regs[] = {
 	{0x0000, RX_REE_PERGCSM_CTRL}
 };
 
-static struct cdns_torrent_vals sl_dp_25_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sl_dp_25_no_ssc_cmn_vals = {
 	.reg_pairs = sl_dp_25_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals sl_dp_25_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals sl_dp_25_no_ssc_tx_ln_vals = {
 	.reg_pairs = sl_dp_25_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals sl_dp_25_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals sl_dp_25_no_ssc_rx_ln_vals = {
 	.reg_pairs = sl_dp_25_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_rx_ln_regs),
 };
@@ -3769,17 +3769,17 @@ static const struct cdns_reg_pairs sl_dp_100_no_ssc_rx_ln_regs[] = {
 	{0x0000, RX_REE_PERGCSM_CTRL}
 };
 
-static struct cdns_torrent_vals sl_dp_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sl_dp_100_no_ssc_cmn_vals = {
 	.reg_pairs = sl_dp_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals sl_dp_100_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals sl_dp_100_no_ssc_tx_ln_vals = {
 	.reg_pairs = sl_dp_100_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals sl_dp_100_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals sl_dp_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = sl_dp_100_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_rx_ln_regs),
 };
@@ -3803,17 +3803,17 @@ static const struct cdns_reg_pairs sgmii_usb_xcvr_diag_ln_regs[] = {
 	{0x009B, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals usb_sgmii_link_cmn_vals = {
+static const struct cdns_torrent_vals usb_sgmii_link_cmn_vals = {
 	.reg_pairs = usb_sgmii_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(usb_sgmii_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals usb_sgmii_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals usb_sgmii_xcvr_diag_ln_vals = {
 	.reg_pairs = usb_sgmii_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(usb_sgmii_xcvr_diag_ln_regs),
 };
 
-static struct cdns_torrent_vals sgmii_usb_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals sgmii_usb_xcvr_diag_ln_vals = {
 	.reg_pairs = sgmii_usb_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_usb_xcvr_diag_ln_regs),
 };
@@ -3838,17 +3838,17 @@ static const struct cdns_reg_pairs usb_pcie_xcvr_diag_ln_regs[] = {
 	{0x00C9, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals pcie_usb_link_cmn_vals = {
+static const struct cdns_torrent_vals pcie_usb_link_cmn_vals = {
 	.reg_pairs = pcie_usb_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_usb_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals pcie_usb_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals pcie_usb_xcvr_diag_ln_vals = {
 	.reg_pairs = pcie_usb_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(pcie_usb_xcvr_diag_ln_regs),
 };
 
-static struct cdns_torrent_vals usb_pcie_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals usb_pcie_xcvr_diag_ln_vals = {
 	.reg_pairs = usb_pcie_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(usb_pcie_xcvr_diag_ln_regs),
 };
@@ -3907,7 +3907,7 @@ static const struct cdns_reg_pairs usb_100_int_ssc_cmn_regs[] = {
 	{0x007F, CMN_TXPDCAL_TUNE}
 };
 
-static struct cdns_torrent_vals usb_100_int_ssc_cmn_vals = {
+static const struct cdns_torrent_vals usb_100_int_ssc_cmn_vals = {
 	.reg_pairs = usb_100_int_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(usb_100_int_ssc_cmn_regs),
 };
@@ -3924,12 +3924,12 @@ static const struct cdns_reg_pairs sl_usb_xcvr_diag_ln_regs[] = {
 	{0x0041, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals sl_usb_link_cmn_vals = {
+static const struct cdns_torrent_vals sl_usb_link_cmn_vals = {
 	.reg_pairs = sl_usb_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_usb_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals sl_usb_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals sl_usb_xcvr_diag_ln_vals = {
 	.reg_pairs = sl_usb_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_usb_xcvr_diag_ln_regs),
 };
@@ -3941,7 +3941,7 @@ static const struct cdns_reg_pairs usb_phy_pcs_cmn_regs[] = {
 	{0x0010, PHY_PIPE_USB3_GEN2_POST_CFG1}
 };
 
-static struct cdns_torrent_vals usb_phy_pcs_cmn_vals = {
+static const struct cdns_torrent_vals usb_phy_pcs_cmn_vals = {
 	.reg_pairs = usb_phy_pcs_cmn_regs,
 	.num_regs = ARRAY_SIZE(usb_phy_pcs_cmn_regs),
 };
@@ -3957,7 +3957,7 @@ static const struct cdns_reg_pairs sl_usb_100_no_ssc_cmn_regs[] = {
 	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD}
 };
 
-static struct cdns_torrent_vals sl_usb_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sl_usb_100_no_ssc_cmn_vals = {
 	.reg_pairs = sl_usb_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_usb_100_no_ssc_cmn_regs),
 };
@@ -4002,17 +4002,17 @@ static const struct cdns_reg_pairs usb_100_no_ssc_rx_ln_regs[] = {
 	{0x0003, RX_CDRLF_CNFG3}
 };
 
-static struct cdns_torrent_vals usb_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals usb_100_no_ssc_cmn_vals = {
 	.reg_pairs = usb_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(usb_100_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals usb_100_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals usb_100_no_ssc_tx_ln_vals = {
 	.reg_pairs = usb_100_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(usb_100_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals usb_100_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals usb_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = usb_100_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(usb_100_no_ssc_rx_ln_regs),
 };
@@ -4059,7 +4059,7 @@ static const struct cdns_reg_pairs sl_usb_100_int_ssc_cmn_regs[] = {
 	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD}
 };
 
-static struct cdns_torrent_vals sl_usb_100_int_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sl_usb_100_int_ssc_cmn_vals = {
 	.reg_pairs = sl_usb_100_int_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_usb_100_int_ssc_cmn_regs),
 };
@@ -4084,17 +4084,17 @@ static const struct cdns_reg_pairs sgmii_pcie_xcvr_diag_ln_regs[] = {
 	{0x009B, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals pcie_sgmii_link_cmn_vals = {
+static const struct cdns_torrent_vals pcie_sgmii_link_cmn_vals = {
 	.reg_pairs = pcie_sgmii_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_sgmii_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals pcie_sgmii_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals pcie_sgmii_xcvr_diag_ln_vals = {
 	.reg_pairs = pcie_sgmii_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(pcie_sgmii_xcvr_diag_ln_regs),
 };
 
-static struct cdns_torrent_vals sgmii_pcie_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals sgmii_pcie_xcvr_diag_ln_vals = {
 	.reg_pairs = sgmii_pcie_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_pcie_xcvr_diag_ln_regs),
 };
@@ -4108,7 +4108,7 @@ static const struct cdns_reg_pairs sl_sgmii_100_no_ssc_cmn_regs[] = {
 	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
 };
 
-static struct cdns_torrent_vals sl_sgmii_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sl_sgmii_100_no_ssc_cmn_vals = {
 	.reg_pairs = sl_sgmii_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_sgmii_100_no_ssc_cmn_regs),
 };
@@ -4155,22 +4155,22 @@ static const struct cdns_reg_pairs sgmii_100_no_ssc_rx_ln_regs[] = {
 	{0x018C, RX_CDRLF_CNFG},
 };
 
-static struct cdns_torrent_vals sgmii_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sgmii_100_no_ssc_cmn_vals = {
 	.reg_pairs = sgmii_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals sgmii_100_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals sgmii_100_no_ssc_tx_ln_vals = {
 	.reg_pairs = sgmii_100_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals ti_sgmii_100_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals ti_sgmii_100_no_ssc_tx_ln_vals = {
 	.reg_pairs = ti_sgmii_100_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(ti_sgmii_100_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals sgmii_100_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals sgmii_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = sgmii_100_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_rx_ln_regs),
 };
@@ -4187,7 +4187,7 @@ static const struct cdns_reg_pairs j7200_sgmii_100_no_ssc_tx_ln_regs[] = {
 	{0x4000, XCVR_DIAG_RXCLK_CTRL}
 };
 
-static struct cdns_torrent_vals j7200_sgmii_100_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals j7200_sgmii_100_no_ssc_tx_ln_vals = {
 	.reg_pairs = j7200_sgmii_100_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(j7200_sgmii_100_no_ssc_tx_ln_regs),
 };
@@ -4214,7 +4214,7 @@ static const struct cdns_reg_pairs j7200_sgmii_100_no_ssc_rx_ln_regs[] = {
 	{0x018C, RX_CDRLF_CNFG}
 };
 
-static struct cdns_torrent_vals j7200_sgmii_100_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals j7200_sgmii_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = j7200_sgmii_100_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(j7200_sgmii_100_no_ssc_rx_ln_regs),
 };
@@ -4271,7 +4271,7 @@ static const struct cdns_reg_pairs sgmii_100_int_ssc_cmn_regs[] = {
 	{0x007F, CMN_TXPDCAL_TUNE}
 };
 
-static struct cdns_torrent_vals sgmii_100_int_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sgmii_100_int_ssc_cmn_vals = {
 	.reg_pairs = sgmii_100_int_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sgmii_100_int_ssc_cmn_regs),
 };
@@ -4285,7 +4285,7 @@ static const struct cdns_reg_pairs sl_qsgmii_100_no_ssc_cmn_regs[] = {
 	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
 };
 
-static struct cdns_torrent_vals sl_qsgmii_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sl_qsgmii_100_no_ssc_cmn_vals = {
 	.reg_pairs = sl_qsgmii_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_qsgmii_100_no_ssc_cmn_regs),
 };
@@ -4334,22 +4334,22 @@ static const struct cdns_reg_pairs qsgmii_100_no_ssc_rx_ln_regs[] = {
 	{0x018C, RX_CDRLF_CNFG},
 };
 
-static struct cdns_torrent_vals qsgmii_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals qsgmii_100_no_ssc_cmn_vals = {
 	.reg_pairs = qsgmii_100_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals qsgmii_100_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals qsgmii_100_no_ssc_tx_ln_vals = {
 	.reg_pairs = qsgmii_100_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals ti_qsgmii_100_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals ti_qsgmii_100_no_ssc_tx_ln_vals = {
 	.reg_pairs = ti_qsgmii_100_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(ti_qsgmii_100_no_ssc_tx_ln_regs),
 };
 
-static struct cdns_torrent_vals qsgmii_100_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals qsgmii_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = qsgmii_100_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_rx_ln_regs),
 };
@@ -4367,7 +4367,7 @@ static const struct cdns_reg_pairs j7200_qsgmii_100_no_ssc_tx_ln_regs[] = {
 	{0x4000, XCVR_DIAG_RXCLK_CTRL}
 };
 
-static struct cdns_torrent_vals j7200_qsgmii_100_no_ssc_tx_ln_vals = {
+static const struct cdns_torrent_vals j7200_qsgmii_100_no_ssc_tx_ln_vals = {
 	.reg_pairs = j7200_qsgmii_100_no_ssc_tx_ln_regs,
 	.num_regs = ARRAY_SIZE(j7200_qsgmii_100_no_ssc_tx_ln_regs),
 };
@@ -4394,7 +4394,7 @@ static const struct cdns_reg_pairs j7200_qsgmii_100_no_ssc_rx_ln_regs[] = {
 	{0x018C, RX_CDRLF_CNFG}
 };
 
-static struct cdns_torrent_vals j7200_qsgmii_100_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals j7200_qsgmii_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = j7200_qsgmii_100_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(j7200_qsgmii_100_no_ssc_rx_ln_regs),
 };
@@ -4451,7 +4451,7 @@ static const struct cdns_reg_pairs qsgmii_100_int_ssc_cmn_regs[] = {
 	{0x007F, CMN_TXPDCAL_TUNE}
 };
 
-static struct cdns_torrent_vals qsgmii_100_int_ssc_cmn_vals = {
+static const struct cdns_torrent_vals qsgmii_100_int_ssc_cmn_vals = {
 	.reg_pairs = qsgmii_100_int_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(qsgmii_100_int_ssc_cmn_regs),
 };
@@ -4468,12 +4468,12 @@ static const struct cdns_reg_pairs sl_sgmii_xcvr_diag_ln_regs[] = {
 	{0x0013, XCVR_DIAG_PLLDRC_CTRL}
 };
 
-static struct cdns_torrent_vals sl_sgmii_link_cmn_vals = {
+static const struct cdns_torrent_vals sl_sgmii_link_cmn_vals = {
 	.reg_pairs = sl_sgmii_link_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_sgmii_link_cmn_regs),
 };
 
-static struct cdns_torrent_vals sl_sgmii_xcvr_diag_ln_vals = {
+static const struct cdns_torrent_vals sl_sgmii_xcvr_diag_ln_vals = {
 	.reg_pairs = sl_sgmii_xcvr_diag_ln_regs,
 	.num_regs = ARRAY_SIZE(sl_sgmii_xcvr_diag_ln_regs),
 };
@@ -4528,7 +4528,7 @@ static const struct cdns_reg_pairs pcie_100_int_ssc_cmn_regs[] = {
 	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR}
 };
 
-static struct cdns_torrent_vals pcie_100_int_ssc_cmn_vals = {
+static const struct cdns_torrent_vals pcie_100_int_ssc_cmn_vals = {
 	.reg_pairs = pcie_100_int_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_100_int_ssc_cmn_regs),
 };
@@ -4583,7 +4583,7 @@ static const struct cdns_reg_pairs sl_pcie_100_int_ssc_cmn_regs[] = {
 	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR}
 };
 
-static struct cdns_torrent_vals sl_pcie_100_int_ssc_cmn_vals = {
+static const struct cdns_torrent_vals sl_pcie_100_int_ssc_cmn_vals = {
 	.reg_pairs = sl_pcie_100_int_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(sl_pcie_100_int_ssc_cmn_regs),
 };
@@ -4601,12 +4601,12 @@ static const struct cdns_reg_pairs pcie_100_ext_no_ssc_rx_ln_regs[] = {
 	{0x0001, RX_DIAG_ACYA}
 };
 
-static struct cdns_torrent_vals pcie_100_no_ssc_cmn_vals = {
+static const struct cdns_torrent_vals pcie_100_no_ssc_cmn_vals = {
 	.reg_pairs = pcie_100_ext_no_ssc_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_100_ext_no_ssc_cmn_regs),
 };
 
-static struct cdns_torrent_vals pcie_100_no_ssc_rx_ln_vals = {
+static const struct cdns_torrent_vals pcie_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = pcie_100_ext_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(pcie_100_ext_no_ssc_rx_ln_regs),
 };
-- 
2.45.2



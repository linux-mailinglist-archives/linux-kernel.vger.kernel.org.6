Return-Path: <linux-kernel+bounces-249782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CD92EFBB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16517B21BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C9C16F909;
	Thu, 11 Jul 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JvB3Mkxq"
Received: from msa.smtpout.orange.fr (msa-208.smtpout.orange.fr [193.252.23.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C716F82F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726511; cv=none; b=stPm4lO3Uzrx1+JW6zx/Mgk0PNGqwRDIxl3nZiYn514YJLQadXQIj8qX89MLk3uy7dNEi5jhOvggV44VoaFhHxfMR8ITMEQZHCn8gNqTndGO5eu7gH2EPNCAWKHWZmeiwcGkPHVD8cWH1KBrozHvWp+qvb80VTRbKiY0qTy4qHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726511; c=relaxed/simple;
	bh=eP8D2AlULiplo11sxaqVpd06Seg2ZUNBL6SsUgrO1NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLLGB4Z6Bun++9HMeaZvS6ycOKoSdYa5KqNu/2OwaEv5LN47VXNYeI/GuBwy+cwU70SrZxa1ScnPuT01W59HYESyeJ3Xzw8UERKBxw6kjBWQUPfZAm9QgfHangZHLbQ5+csZREuelkTmGYTebzyf7GQdSlZsAw8OvlumlAewTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JvB3Mkxq; arc=none smtp.client-ip=193.252.23.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.. ([77.131.3.214])
	by smtp.orange.fr with ESMTPA
	id RzZBsCMFrj4pfRzZGsIiRu; Thu, 11 Jul 2024 21:35:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720726502;
	bh=dRpz9tTr7QVvo4jsxN8ZGItmvHwQfohDQmxginrSsQ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JvB3Mkxqfq/Pfy0T3tXD7mgqhA5FuqwkjqyumSBu0lgO/lY8fivaCu31HACrQ20YU
	 P3tfrUqTh6fM8pKdeV2JQ5gxTdgj9Go4/wrrrZ5TL1NYHxIGxCDY6wP7kWvS7eIifz
	 5oMdO0+rByWN8ZsIJR9GsXmX5zjN3YC/LAbKFFwkF5ZMWJmQdzh96XS+8qpOPRK4zo
	 1QEQTW2/DAPSw2hprvNje09kutnRZOEHPe3xQZQprH3uCEWGG4Hc+ql1VufPaCiruu
	 sUlhEsieKEBD9PincvVNIGubprXECVnkVmnt/E1ZHd8WwPk16NEsnxNEX9KG/3ZOAI
	 wi9OpXxg1SMyA==
X-ME-Helo: fedora..
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jul 2024 21:35:02 +0200
X-ME-IP: 77.131.3.214
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] phy: cadence: Sierra: Constify struct cdns_sierra_vals
Date: Thu, 11 Jul 2024 21:34:53 +0200
Message-ID: <0ccfd259fdf40475c89cfb22a64c6388e7c646b4.1720723132.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720723132.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720723132.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct cdns_sierra_vals' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  60521	   4310	     16	  64847	   fd4f	drivers/phy/cadence/phy-cadence-sierra.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  60937	   3894	     16	  64847	   fd4f	drivers/phy/cadence/phy-cadence-sierra.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/phy/cadence/phy-cadence-sierra.c | 80 ++++++++++++------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 6bb0ca3443f1..947492c8f381 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -362,14 +362,14 @@ struct cdns_sierra_data {
 	u32 id_value;
 	u8 block_offset_shift;
 	u8 reg_offset_shift;
-	struct cdns_sierra_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					     [NUM_SSC_MODE];
-	struct cdns_sierra_vals *phy_pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-						[NUM_SSC_MODE];
-	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					     [NUM_SSC_MODE];
-	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					    [NUM_SSC_MODE];
+	const struct cdns_sierra_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+						   [NUM_SSC_MODE];
+	const struct cdns_sierra_vals *phy_pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+						      [NUM_SSC_MODE];
+	const struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+						   [NUM_SSC_MODE];
+	const struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+						  [NUM_SSC_MODE];
 };
 
 struct cdns_regmap_cdb_context {
@@ -539,12 +539,12 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
 	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
 	const struct cdns_sierra_data *init_data = phy->init_data;
-	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
+	const struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
 	enum cdns_sierra_phy_type phy_type = ins->phy_type;
+	const struct cdns_sierra_vals *phy_pma_ln_vals;
 	enum cdns_sierra_ssc_mode ssc = ins->ssc_mode;
-	struct cdns_sierra_vals *phy_pma_ln_vals;
+	const struct cdns_sierra_vals *pcs_cmn_vals;
 	const struct cdns_reg_pairs *reg_pairs;
-	struct cdns_sierra_vals *pcs_cmn_vals;
 	struct regmap *regmap;
 	u32 num_regs;
 	int i, j;
@@ -1244,12 +1244,12 @@ static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
 
 static int cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
 {
+	const struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
 	const struct cdns_sierra_data *init_data = sp->init_data;
-	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
+	const struct cdns_sierra_vals *phy_pma_ln_vals;
+	const struct cdns_sierra_vals *pcs_cmn_vals;
 	enum cdns_sierra_phy_type phy_t1, phy_t2;
-	struct cdns_sierra_vals *phy_pma_ln_vals;
 	const struct cdns_reg_pairs *reg_pairs;
-	struct cdns_sierra_vals *pcs_cmn_vals;
 	int i, j, node, mlane, num_lanes, ret;
 	enum cdns_sierra_ssc_mode ssc;
 	struct regmap *regmap;
@@ -1548,7 +1548,7 @@ static const struct cdns_reg_pairs sgmii_phy_pma_ln_regs[] = {
 	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
 };
 
-static struct cdns_sierra_vals sgmii_phy_pma_ln_vals = {
+static const struct cdns_sierra_vals sgmii_phy_pma_ln_vals = {
 	.reg_pairs = sgmii_phy_pma_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_phy_pma_ln_regs),
 };
@@ -1598,12 +1598,12 @@ static const struct cdns_reg_pairs sgmii_100_no_ssc_plllc1_opt3_ln_regs[] = {
 	{0x0002, SIERRA_RXBUFFER_RCDFECTRL_PREG}
 };
 
-static struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_cmn_vals = {
+static const struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_cmn_vals = {
 	.reg_pairs = sgmii_100_no_ssc_plllc1_opt3_cmn_regs,
 	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_plllc1_opt3_cmn_regs),
 };
 
-static struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_ln_vals = {
+static const struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_ln_vals = {
 	.reg_pairs = sgmii_100_no_ssc_plllc1_opt3_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_plllc1_opt3_ln_regs),
 };
@@ -1613,7 +1613,7 @@ static const struct cdns_reg_pairs qsgmii_phy_pma_ln_regs[] = {
 	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
 };
 
-static struct cdns_sierra_vals qsgmii_phy_pma_ln_vals = {
+static const struct cdns_sierra_vals qsgmii_phy_pma_ln_vals = {
 	.reg_pairs = qsgmii_phy_pma_ln_regs,
 	.num_regs = ARRAY_SIZE(qsgmii_phy_pma_ln_regs),
 };
@@ -1664,12 +1664,12 @@ static const struct cdns_reg_pairs qsgmii_100_no_ssc_plllc1_ln_regs[] = {
 	{0x0002, SIERRA_RXBUFFER_RCDFECTRL_PREG}
 };
 
-static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_cmn_vals = {
+static const struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_cmn_vals = {
 	.reg_pairs = qsgmii_100_no_ssc_plllc1_cmn_regs,
 	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_cmn_regs),
 };
 
-static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_ln_vals = {
+static const struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_ln_vals = {
 	.reg_pairs = qsgmii_100_no_ssc_plllc1_ln_regs,
 	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_ln_regs),
 };
@@ -1679,7 +1679,7 @@ static const struct cdns_reg_pairs pcie_phy_pcs_cmn_regs[] = {
 	{0x0430, SIERRA_PHY_PIPE_CMN_CTRL1}
 };
 
-static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
+static const struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
 	.reg_pairs = pcie_phy_pcs_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
 };
@@ -1745,12 +1745,12 @@ static const struct cdns_reg_pairs ml_pcie_100_no_ssc_ln_regs[] = {
 	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
-static struct cdns_sierra_vals pcie_100_no_ssc_plllc_cmn_vals = {
+static const struct cdns_sierra_vals pcie_100_no_ssc_plllc_cmn_vals = {
 	.reg_pairs = pcie_100_no_ssc_plllc_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_100_no_ssc_plllc_cmn_regs),
 };
 
-static struct cdns_sierra_vals ml_pcie_100_no_ssc_ln_vals = {
+static const struct cdns_sierra_vals ml_pcie_100_no_ssc_ln_vals = {
 	.reg_pairs = ml_pcie_100_no_ssc_ln_regs,
 	.num_regs = ARRAY_SIZE(ml_pcie_100_no_ssc_ln_regs),
 };
@@ -1810,7 +1810,7 @@ static const struct cdns_reg_pairs ti_ml_pcie_100_no_ssc_ln_regs[] = {
 	{0x0002, SIERRA_TX_RCVDET_OVRD_PREG}
 };
 
-static struct cdns_sierra_vals ti_ml_pcie_100_no_ssc_ln_vals = {
+static const struct cdns_sierra_vals ti_ml_pcie_100_no_ssc_ln_vals = {
 	.reg_pairs = ti_ml_pcie_100_no_ssc_ln_regs,
 	.num_regs = ARRAY_SIZE(ti_ml_pcie_100_no_ssc_ln_regs),
 };
@@ -1886,12 +1886,12 @@ static const struct cdns_reg_pairs ml_pcie_100_int_ssc_ln_regs[] = {
 	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
-static struct cdns_sierra_vals pcie_100_int_ssc_plllc_cmn_vals = {
+static const struct cdns_sierra_vals pcie_100_int_ssc_plllc_cmn_vals = {
 	.reg_pairs = pcie_100_int_ssc_plllc_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_100_int_ssc_plllc_cmn_regs),
 };
 
-static struct cdns_sierra_vals ml_pcie_100_int_ssc_ln_vals = {
+static const struct cdns_sierra_vals ml_pcie_100_int_ssc_ln_vals = {
 	.reg_pairs = ml_pcie_100_int_ssc_ln_regs,
 	.num_regs = ARRAY_SIZE(ml_pcie_100_int_ssc_ln_regs),
 };
@@ -1954,7 +1954,7 @@ static const struct cdns_reg_pairs ti_ml_pcie_100_int_ssc_ln_regs[] = {
 	{0x0002, SIERRA_TX_RCVDET_OVRD_PREG}
 };
 
-static struct cdns_sierra_vals ti_ml_pcie_100_int_ssc_ln_vals = {
+static const struct cdns_sierra_vals ti_ml_pcie_100_int_ssc_ln_vals = {
 	.reg_pairs = ti_ml_pcie_100_int_ssc_ln_regs,
 	.num_regs = ARRAY_SIZE(ti_ml_pcie_100_int_ssc_ln_regs),
 };
@@ -2024,12 +2024,12 @@ static const struct cdns_reg_pairs ml_pcie_100_ext_ssc_ln_regs[] = {
 	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
-static struct cdns_sierra_vals pcie_100_ext_ssc_plllc_cmn_vals = {
+static const struct cdns_sierra_vals pcie_100_ext_ssc_plllc_cmn_vals = {
 	.reg_pairs = pcie_100_ext_ssc_plllc_cmn_regs,
 	.num_regs = ARRAY_SIZE(pcie_100_ext_ssc_plllc_cmn_regs),
 };
 
-static struct cdns_sierra_vals ml_pcie_100_ext_ssc_ln_vals = {
+static const struct cdns_sierra_vals ml_pcie_100_ext_ssc_ln_vals = {
 	.reg_pairs = ml_pcie_100_ext_ssc_ln_regs,
 	.num_regs = ARRAY_SIZE(ml_pcie_100_ext_ssc_ln_regs),
 };
@@ -2092,7 +2092,7 @@ static const struct cdns_reg_pairs ti_ml_pcie_100_ext_ssc_ln_regs[] = {
 	{0x0002, SIERRA_TX_RCVDET_OVRD_PREG}
 };
 
-static struct cdns_sierra_vals ti_ml_pcie_100_ext_ssc_ln_vals = {
+static const struct cdns_sierra_vals ti_ml_pcie_100_ext_ssc_ln_vals = {
 	.reg_pairs = ti_ml_pcie_100_ext_ssc_ln_regs,
 	.num_regs = ARRAY_SIZE(ti_ml_pcie_100_ext_ssc_ln_regs),
 };
@@ -2152,12 +2152,12 @@ static const struct cdns_reg_pairs cdns_pcie_ln_regs_no_ssc[] = {
 	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
-static struct cdns_sierra_vals pcie_100_no_ssc_cmn_vals = {
+static const struct cdns_sierra_vals pcie_100_no_ssc_cmn_vals = {
 	.reg_pairs = cdns_pcie_cmn_regs_no_ssc,
 	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_no_ssc),
 };
 
-static struct cdns_sierra_vals pcie_100_no_ssc_ln_vals = {
+static const struct cdns_sierra_vals pcie_100_no_ssc_ln_vals = {
 	.reg_pairs = cdns_pcie_ln_regs_no_ssc,
 	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_no_ssc),
 };
@@ -2227,12 +2227,12 @@ static const struct cdns_reg_pairs cdns_pcie_ln_regs_int_ssc[] = {
 	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
-static struct cdns_sierra_vals pcie_100_int_ssc_cmn_vals = {
+static const struct cdns_sierra_vals pcie_100_int_ssc_cmn_vals = {
 	.reg_pairs = cdns_pcie_cmn_regs_int_ssc,
 	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_int_ssc),
 };
 
-static struct cdns_sierra_vals pcie_100_int_ssc_ln_vals = {
+static const struct cdns_sierra_vals pcie_100_int_ssc_ln_vals = {
 	.reg_pairs = cdns_pcie_ln_regs_int_ssc,
 	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_int_ssc),
 };
@@ -2296,12 +2296,12 @@ static const struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
 	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
-static struct cdns_sierra_vals pcie_100_ext_ssc_cmn_vals = {
+static const struct cdns_sierra_vals pcie_100_ext_ssc_cmn_vals = {
 	.reg_pairs = cdns_pcie_cmn_regs_ext_ssc,
 	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
 };
 
-static struct cdns_sierra_vals pcie_100_ext_ssc_ln_vals = {
+static const struct cdns_sierra_vals pcie_100_ext_ssc_ln_vals = {
 	.reg_pairs = cdns_pcie_ln_regs_ext_ssc,
 	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
 };
@@ -2413,12 +2413,12 @@ static const struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0x4243, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
-static struct cdns_sierra_vals usb_100_ext_ssc_cmn_vals = {
+static const struct cdns_sierra_vals usb_100_ext_ssc_cmn_vals = {
 	.reg_pairs = cdns_usb_cmn_regs_ext_ssc,
 	.num_regs = ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
 };
 
-static struct cdns_sierra_vals usb_100_ext_ssc_ln_vals = {
+static const struct cdns_sierra_vals usb_100_ext_ssc_ln_vals = {
 	.reg_pairs = cdns_usb_ln_regs_ext_ssc,
 	.num_regs = ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
 };
@@ -2443,7 +2443,7 @@ static const struct cdns_reg_pairs sgmii_pma_cmn_vals[] = {
 	{0x0013, SIERRA_CMN_PLLLC1_DCOCAL_CTRL_PREG},
 };
 
-static struct cdns_sierra_vals sgmii_cmn_vals = {
+static const struct cdns_sierra_vals sgmii_cmn_vals = {
 	.reg_pairs = sgmii_pma_cmn_vals,
 	.num_regs = ARRAY_SIZE(sgmii_pma_cmn_vals),
 };
@@ -2489,7 +2489,7 @@ static const struct cdns_reg_pairs sgmii_ln_regs[] = {
 	{0x321F, SIERRA_CPICAL_RES_STARTCODE_MODE01_PREG},
 };
 
-static struct cdns_sierra_vals sgmii_pma_ln_vals = {
+static const struct cdns_sierra_vals sgmii_pma_ln_vals = {
 	.reg_pairs = sgmii_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_ln_regs),
 };
-- 
2.45.2



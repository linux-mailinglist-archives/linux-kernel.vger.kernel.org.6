Return-Path: <linux-kernel+bounces-577234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF00A71A40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B423B1886BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA101F4176;
	Wed, 26 Mar 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZfyXjtOv"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D17153BE8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002617; cv=none; b=JRNGB27eByTfc7OFgpdOZ7mF1R6qv/kGuoXEieFt5D8vkKUMnLPUt0PpML3pz5A+ddGu8GqWN8w9Di4Ww/0R168FlX1qaqnuCfp0uv60Iu2iCImmbgu6UqAb4PG5k491V8xkn4W7CaVK/WH0ge9Yemk8yQbmBkaJXxv3Zolph6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002617; c=relaxed/simple;
	bh=LTuJihWWgilndmk9mTgn3jlXLSh19OZ/HAUZDX0/VUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lP+p2GQw0NgrKzxv0IBM5vPxj2bjyLhohy3aE/yw08NGe18xkqLLaNioSzxAqLc5CkLMCbiwUdEU9dPOTuCF3sls0BxsOOaYTqQFePt8nqj8fSJHCdrBeL6akcDXTQ7zxlP0H/v3WmncWNY571RNg2zzwA3cdXSiliY6O7VnKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZfyXjtOv; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52QFNN5o2128035
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Mar 2025 10:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743002603;
	bh=HYIha5KWB07+PC+ckhBYmLlo27ya2SY+HumbYnoxom4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZfyXjtOvkoqMCIG4TYPcSaua7z4sSGfhavxsdwpJmD/6Ft5RcU6i84U5vkFK2Apis
	 qF4LDaFVr4UmAaydcvtXy8q3XLOWkxGGZGEIoOZXfWmVm0HY41YX8WSztWNKfkCMwP
	 vcM33Wu4NPyVDeF08r+Q51Nmx9ckX9XT6A1OKyDo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52QFNNGg125628;
	Wed, 26 Mar 2025 10:23:23 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Mar 2025 10:23:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Mar 2025 10:23:22 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52QFNMfH076834;
	Wed, 26 Mar 2025 10:23:22 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <mripard@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sakari.ailus@linux.intel.com>, <u.kleine-koenig@baylibre.com>,
        <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>, <s-jain1@ti.com>,
        <r-donadkar@ti.com>, <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 1/2] phy: cadence: cdns-dphy: Fix PLL lock and O_CMN_READY polling
Date: Wed, 26 Mar 2025 20:53:19 +0530
Message-ID: <20250326152320.3835249-2-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250326152320.3835249-1-devarsht@ti.com>
References: <20250326152320.3835249-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

PLL lockup and O_CMN_READY assertion can only happen after common state
machine gets enabled, but driver was polling them before the common state
machine was enabled. To fix this, add new function callbacks polling on PLL
lock and O_CMN_READY assertion and call them only after common state
machine gets enabled.

Cc: stable@vger.kernel.org
Fixes: 7a343c8bf4b5 ("phy: Add Cadence D-PHY support")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: 
- Return error code on polling timeout
- Moved out calibration logic to separate patch

 drivers/phy/cadence/cdns-dphy.c | 57 ++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index ed87a3970f83..c4de9e4d3e93 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -99,6 +99,8 @@ struct cdns_dphy_ops {
 	void (*set_pll_cfg)(struct cdns_dphy *dphy,
 			    const struct cdns_dphy_cfg *cfg);
 	unsigned long (*get_wakeup_time_ns)(struct cdns_dphy *dphy);
+	int (*wait_for_pll_lock)(struct cdns_dphy *dphy);
+	int (*wait_for_cmn_ready)(struct cdns_dphy *dphy);
 };
 
 struct cdns_dphy {
@@ -191,6 +193,26 @@ static unsigned long cdns_dphy_get_wakeup_time_ns(struct cdns_dphy *dphy)
 	return dphy->ops->get_wakeup_time_ns(dphy);
 }
 
+static int cdns_dphy_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	int ret = 0;
+
+	if (dphy->ops->wait_for_pll_lock)
+		ret = dphy->ops->wait_for_pll_lock(dphy);
+
+	return ret;
+}
+
+static int cdns_dphy_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	int ret = 0;
+
+	if (dphy->ops->wait_for_cmn_ready)
+		ret = dphy->ops->wait_for_cmn_ready(dphy);
+
+	return ret;
+}
+
 static unsigned long cdns_dphy_ref_get_wakeup_time_ns(struct cdns_dphy *dphy)
 {
 	/* Default wakeup time is 800 ns (in a simulated environment). */
@@ -232,7 +254,6 @@ static unsigned long cdns_dphy_j721e_get_wakeup_time_ns(struct cdns_dphy *dphy)
 static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 					const struct cdns_dphy_cfg *cfg)
 {
-	u32 status;
 
 	/*
 	 * set the PWM and PLL Byteclk divider settings to recommended values
@@ -249,13 +270,6 @@ static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 
 	writel(DPHY_TX_J721E_WIZ_LANE_RSTB,
 	       dphy->regs + DPHY_TX_J721E_WIZ_RST_CTRL);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
-			   (status & DPHY_TX_WIZ_PLL_LOCK), 0, POLL_TIMEOUT_US);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
-			   (status & DPHY_TX_WIZ_O_CMN_READY), 0,
-			   POLL_TIMEOUT_US);
 }
 
 static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
@@ -263,6 +277,23 @@ static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
 	writel(div, dphy->regs + DPHY_TX_J721E_WIZ_PSM_FREQ);
 }
 
+static int cdns_dphy_j721e_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
+			       status & DPHY_TX_WIZ_PLL_LOCK, 0, POLL_TIMEOUT_US);
+}
+
+static int cdns_dphy_j721e_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
+			       status & DPHY_TX_WIZ_O_CMN_READY, 0,
+			       POLL_TIMEOUT_US);
+}
+
 /*
  * This is the reference implementation of DPHY hooks. Specific integration of
  * this IP may have to re-implement some of them depending on how they decided
@@ -278,6 +309,8 @@ static const struct cdns_dphy_ops j721e_dphy_ops = {
 	.get_wakeup_time_ns = cdns_dphy_j721e_get_wakeup_time_ns,
 	.set_pll_cfg = cdns_dphy_j721e_set_pll_cfg,
 	.set_psm_div = cdns_dphy_j721e_set_psm_div,
+	.wait_for_pll_lock = cdns_dphy_j721e_wait_for_pll_lock,
+	.wait_for_cmn_ready = cdns_dphy_j721e_wait_for_cmn_ready,
 };
 
 static int cdns_dphy_config_from_opts(struct phy *phy,
@@ -373,6 +406,14 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
 	writel(reg, dphy->regs + DPHY_BAND_CFG);
 
+	ret = cdns_dphy_wait_for_pll_lock(dphy);
+	if (ret)
+		dev_err(&dphy->phy->dev, "Failed to lock PLL with err %d\n", ret);
+
+	ret = cdns_dphy_wait_for_cmn_ready(dphy);
+	if (ret)
+		dev_err(&dphy->phy->dev, "O_CMN_READY signal failed to assert with err %d\n", ret);
+
 	return 0;
 }
 
-- 
2.39.1



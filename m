Return-Path: <linux-kernel+bounces-234527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD6291C7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B728B27DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49580630;
	Fri, 28 Jun 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J8Dot2eR"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC67A715
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608165; cv=none; b=Qfxx7xV230UktEjSp8B84hpdJ5j584VGIHM0XUniARblAEVbbB8STMotoLR4XmGJV7QLD4eJ4ortz2nTzm939ZviN30JTKPSnv0dlitkW8bCbo5Lniw4u9ebWIJvZCnAhqLzSSYGl0t0amv7bAiJ3XbOtktxXp3eBP3wnJL3GB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608165; c=relaxed/simple;
	bh=7vSs2AxTZFZFcue+3cJMHw0ES5vsxSJk9Wv60ZDzZKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxhlmX6mIeW2tmd8xv+r1+LW3WVmUAXi4heJ/xxwtEXR0YAHA5TatU0SwK6NqbfHAdjXbWDLNeM2XGUn2QXAcV/jKIFng2j1garwBflhGDP+RJIINCgRhJ6sW1lMADmpCFwilpqF+wBBApfv3sPYyXIEnAHCR/28ajMkXxyrxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J8Dot2eR; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhvHqCXuudFTNwDuA4VjIUrafDHyK4yeQF5CqDZlZYo=;
	b=J8Dot2eRL2Hf3kwUWOGKMagrRlX7BmnSpUlyWTekGmsAkFY3Nj8fnj/ynx7S15N9iDegVI
	EPTHfmDTlq2yAKQmwTePrfa0Hex4kzioby+753sqUZmd9IJ+XIdXQvb6fOAZUVJZQMZaSK
	mueQ6zkItnOi+haWU7fldEg5aqsDvto=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: linux-phy@lists.infradead.org
X-Envelope-To: vkoul@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: kishon@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 1/5] phy: zynqmp: Enable reference clock correctly
Date: Fri, 28 Jun 2024 16:55:36 -0400
Message-Id: <20240628205540.3098010-2-sean.anderson@linux.dev>
In-Reply-To: <20240628205540.3098010-1-sean.anderson@linux.dev>
References: <20240628205540.3098010-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Lanes can use other lanes' reference clocks, as determined by refclk.
Use refclk to determine the clock to enable/disable instead of always
using the lane's own reference clock. This ensures the clock selected in
xpsgtr_configure_pll is the one enabled.

For the other half of the equation, always program REF_CLK_SEL even when
we are selecting the lane's own clock. This ensures that Linux's idea of
the reference clock matches the hardware. We use the "local" clock mux
for this instead of going through the ref clock network.

Fixes: 25d700833513 ("phy: xilinx: phy-zynqmp: dynamic clock support for power-save")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- Remove inapplicable comments

Changes in v2:
- New

 drivers/phy/xilinx/phy-zynqmp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index dc8319bda43d..f2bff7f25f05 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -80,7 +80,8 @@
 
 /* Reference clock selection parameters */
 #define L0_Ln_REF_CLK_SEL(n)		(0x2860 + (n) * 4)
-#define L0_REF_CLK_SEL_MASK		0x8f
+#define L0_REF_CLK_LCL_SEL		BIT(7)
+#define L0_REF_CLK_SEL_MASK		0x9f
 
 /* Calibration digital logic parameters */
 #define L3_TM_CALIB_DIG19		0xec4c
@@ -349,11 +350,12 @@ static void xpsgtr_configure_pll(struct xpsgtr_phy *gtr_phy)
 		       PLL_FREQ_MASK, ssc->pll_ref_clk);
 
 	/* Enable lane clock sharing, if required */
-	if (gtr_phy->refclk != gtr_phy->lane) {
-		/* Lane3 Ref Clock Selection Register */
+	if (gtr_phy->refclk == gtr_phy->lane)
+		xpsgtr_clr_set(gtr_phy->dev, L0_Ln_REF_CLK_SEL(gtr_phy->lane),
+			       L0_REF_CLK_SEL_MASK, L0_REF_CLK_LCL_SEL);
+	else
 		xpsgtr_clr_set(gtr_phy->dev, L0_Ln_REF_CLK_SEL(gtr_phy->lane),
 			       L0_REF_CLK_SEL_MASK, 1 << gtr_phy->refclk);
-	}
 
 	/* SSC step size [7:0] */
 	xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEP_SIZE_0_LSB,
@@ -573,7 +575,7 @@ static int xpsgtr_phy_init(struct phy *phy)
 	mutex_lock(&gtr_dev->gtr_mutex);
 
 	/* Configure and enable the clock when peripheral phy_init call */
-	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->lane]))
+	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->refclk]))
 		goto out;
 
 	/* Skip initialization if not required. */
@@ -625,7 +627,7 @@ static int xpsgtr_phy_exit(struct phy *phy)
 	gtr_phy->skip_phy_init = false;
 
 	/* Ensure that disable clock only, which configure for lane */
-	clk_disable_unprepare(gtr_dev->clk[gtr_phy->lane]);
+	clk_disable_unprepare(gtr_dev->clk[gtr_phy->refclk]);
 
 	return 0;
 }
-- 
2.35.1.1320.gc452695387.dirty



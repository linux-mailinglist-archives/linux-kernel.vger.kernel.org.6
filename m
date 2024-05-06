Return-Path: <linux-kernel+bounces-170215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3788BD38B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD244B21F74
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875515820E;
	Mon,  6 May 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dV2SIsuU"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402715746C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014883; cv=none; b=bQYnrYQ2D5w8GFxr7mg9aG8WqFwknrtFEXzQcfSD9TaJOc84HFRDYuckW84unLdMsrO7/wk+rNvIZB/digBd9cp14eb8bw1VQ3owJUyBb5yjOB56v1yEfoz6Zjo2dLW9KCWt8TlqOEQqsYbxh2WZiBl/8x9q1Vp6ktfnq7X2kAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014883; c=relaxed/simple;
	bh=9o9cp9ASuaoo2SeaWcpce2frMMF2qGAGLxQ+yzn2qDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JITJnTpGozAuO+gWTYYha10J8aXx1KZ+ovCLMm6em4KRrpy/gXjv+up+ZG0lQfbnb2eNo7cdYrPa7tsAfnOwjZscnxS9LbMBwQFLnjKgzsKBt4URTnfJqZQar21ZA9mrRcJB8O1YsoqpMClJVuvVoIFVdEGhMMFfQmhtFi97jMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dV2SIsuU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715014879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+Np06nET1bUu2fFobpOkXKoyFCkgH94QLr++iblhls=;
	b=dV2SIsuUJzOTHHIwYfo2u8cKOEkJF1YDJip1kQ/Y/LYAtU7TZQgBy4HW+SFsjfJQaeLifb
	FaMEJn4HtemjuPejPPIID7eZ6jWjoDe1UjXILFqC31EHFs/Qc5CEAi6O22KoFUs3N+naHv
	L4Qa659i6SOozEuEED8H8LT8htgQP5g=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 3/4] phy: zynqmp: Only wait for PLL lock "primary" instances
Date: Mon,  6 May 2024 13:01:09 -0400
Message-Id: <20240506170110.2874724-4-sean.anderson@linux.dev>
In-Reply-To: <20240506170110.2874724-1-sean.anderson@linux.dev>
References: <20240506170110.2874724-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For PCIe and DisplayPort, the phy instance represents the controller's
logical lane. Wait for the instance 0 phy's PLL to lock as other
instances will never lock. We do this in xpsgtr_wait_pll_lock so callers
don't have to determine the correct lane themselves.

The original comment is wrong about cumulative wait times. Since we are
just polling a bit, all subsequent waiters will finish immediately.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Move the logic for waiting on PLL lock to xpsgtr_wait_pll_lock

 drivers/phy/xilinx/phy-zynqmp.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 5a8f81bbeb8d..b86fe2a249a8 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -294,10 +294,30 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
 	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
 	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
 	unsigned int timeout = TIMEOUT_US;
+	u8 protocol = gtr_phy->protocol;
 	int ret;
 
 	dev_dbg(gtr_dev->dev, "Waiting for PLL lock\n");
 
+	/*
+	 * For DP and PCIe, only the instance 0 PLL is used. Switch to that phy
+	 * so we wait on the right PLL.
+	 */
+	if ((protocol == ICM_PROTOCOL_DP || protocol == ICM_PROTOCOL_PCIE) &&
+	    gtr_phy->instance) {
+		int i;
+
+		for (i = 0; i < NUM_LANES; i++) {
+			gtr_phy = &gtr_dev->phys[i];
+
+			if (gtr_phy->protocol == protocol && !gtr_phy->instance)
+				goto got_phy;
+		}
+
+		return -EBUSY;
+	}
+
+got_phy:
 	while (1) {
 		u32 reg = xpsgtr_read_phy(gtr_phy, L0_PLL_STATUS_READ_1);
 
@@ -627,15 +647,7 @@ static int xpsgtr_phy_power_on(struct phy *phy)
 	/* Skip initialization if not required. */
 	if (!xpsgtr_phy_init_required(gtr_phy))
 		return ret;
-	/*
-	 * Wait for the PLL to lock. For DP, only wait on DP0 to avoid
-	 * cumulating waits for both lanes. The user is expected to initialize
-	 * lane 0 last.
-	 */
-	if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
-		ret = xpsgtr_wait_pll_lock(phy);
-
-	return ret;
+	return xpsgtr_wait_pll_lock(phy);
 }
 
 static int xpsgtr_phy_configure(struct phy *phy, union phy_configure_opts *opts)
-- 
2.35.1.1320.gc452695387.dirty



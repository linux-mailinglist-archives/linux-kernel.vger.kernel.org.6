Return-Path: <linux-kernel+bounces-234529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B491C7A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F501F21C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C02F8172D;
	Fri, 28 Jun 2024 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AFDgDhKY"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152280BF2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608169; cv=none; b=qWEXRXxxVmacsawLpYgzI4WwihPyCdr/ImTBZ3cX6Rqc4IS2mFTNVgp18QdP/ruoZ+IlzwPKN+nRC7XaaoMMHoM3zL+Lx15M7l3JEzCmk8SbqPE04TAGDk34regiYAs/Ro2Amgx2zcHMq+HcRxf6YqWVipjAhLBdhdiYPjCvB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608169; c=relaxed/simple;
	bh=nopR7kksnQPVM1Lih9chyh7N87REt7rwU0ihF7ZbveY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BGpF0TAV+PFmJ9ixhYh93zqe+sqVZ9xrFehUrcggOt/s6fUjFHdf0KIzBgRFgUiW2Mrn9lupQKu4Xggvnt4hOiwhA4wyPKPpvMpoavxzGfitB/ovGCjnLX/GBzBoRZ/7JmGiXZNGOXdvMclGxC60q+VanisUkiI8RcPiHlAwePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AFDgDhKY; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEWbV4dqpa1TJriBZCpsvwB0QOnRaJIArW3SQXCHi9c=;
	b=AFDgDhKY0NsP3dTnmHaWQtnn6jcTiThwnjPr+V/uYInCqwflw4ml4bg9bGbEcCcOZtZt4R
	P+Q4wcZKBXTNZEe37nHg3mod/xb+ly7GqY1vgyhRKwTmzN2OHS/UJ+R+GYomNjWWF4Xc+X
	1Z8IXM89R0k7+VXCe/pdR/IbyMMtE+E=
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
Subject: [PATCH v3 3/5] phy: zynqmp: Only wait for PLL lock "primary" instances
Date: Fri, 28 Jun 2024 16:55:38 -0400
Message-Id: <20240628205540.3098010-4-sean.anderson@linux.dev>
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

For PCIe and DisplayPort, the phy instance represents the controller's
logical lane. Wait for the instance 0 phy's PLL to lock as other
instances will never lock. We do this in xpsgtr_wait_pll_lock so callers
don't have to determine the correct lane themselves.

The original comment is wrong about cumulative wait times. Since we are
just polling a bit, all subsequent waiters will finish immediately.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v2)

Changes in v2:
- Move the logic for waiting on PLL lock to xpsgtr_wait_pll_lock

 drivers/phy/xilinx/phy-zynqmp.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index a1cf32024efb..4d697e11d8eb 100644
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
 
@@ -625,15 +645,7 @@ static int xpsgtr_phy_power_on(struct phy *phy)
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



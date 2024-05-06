Return-Path: <linux-kernel+bounces-170216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608F18BD38C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94553B226F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC515885C;
	Mon,  6 May 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SXnecchZ"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B87157E7A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014884; cv=none; b=Vwgr7khMx+RX0b+qN0s7zTmKPEgDCKcfFsyb706qAp4etG7DGKVcj4fgkhA9brHk368dDowA+KI1f8VdKo3hrAaR5WRqBbWj2alO1BmTBM9LsEjPw8ZFYhmB/DWEoIM4UxLRsKlzWohynWJu7numCrjkhQ2+jU1xrhFhExZ5jCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014884; c=relaxed/simple;
	bh=d6Xfy4UCyWqdopD5dBNuP/bdXW74dEdd6XtFMyagUt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULHnHZ67lK3wurRGdFLPjNagCnvuME/gVNTz7qvBdeYgFETs090qSwAYYCqi84I86tuekhuBaWISCtGhpL6ba9u/gLJhysLmb/XzDDwPnb6r348xyFOVfSYzpgBesYxtrKeBPI4+zPTA+Ll1NqP/KkQrbJ9gpk19iZ6Sw88d2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SXnecchZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715014881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cymb81QFA90cgzVWyCG8xmXANdYL6hFgCIH16jTwgp4=;
	b=SXnecchZOmlUkNSbT3EZ3jx8I+bsAi/ghp8tnGJNmS+mKzBpL5HXG/1PapWwZFLv6S+sLR
	6acFddYtwbn6mI34/ZP51xk5qtiSAjMJ7RxCqhfeFb50rDfjgKe0dEah5xtEqzyE3x4RWO
	lN4Eh8FftU8x8Bnig++3q7DlvRSNjh8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 4/4] phy: zynqmp: Add debugfs support
Date: Mon,  6 May 2024 13:01:10 -0400
Message-Id: <20240506170110.2874724-5-sean.anderson@linux.dev>
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

Add support for printing some basic status information to debugfs. This
is helpful when debugging phy consumers to make sure they are configuring
the phy appropriately.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Use debugfs_create_devm_seqfile

 drivers/phy/xilinx/phy-zynqmp.c | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index b86fe2a249a8..2520c75a4a77 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -123,6 +124,15 @@
 #define ICM_PROTOCOL_DP			0x4
 #define ICM_PROTOCOL_SGMII		0x5
 
+static const char *const xpsgtr_icm_str[] = {
+	[ICM_PROTOCOL_PD] = "powered down",
+	[ICM_PROTOCOL_PCIE] = "PCIe",
+	[ICM_PROTOCOL_SATA] = "SATA",
+	[ICM_PROTOCOL_USB] = "USB",
+	[ICM_PROTOCOL_DP] = "DisplayPort",
+	[ICM_PROTOCOL_SGMII] = "SGMII",
+};
+
 /* Test Mode common reset control  parameters */
 #define TM_CMN_RST			0x10018
 #define TM_CMN_RST_EN			0x1
@@ -788,6 +798,34 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 	return ERR_PTR(-EINVAL);
 }
 
+/*
+ * DebugFS
+ */
+
+static int xpsgtr_status_read(struct seq_file *seq, void *data)
+{
+	struct device *dev = seq->private;
+	struct xpsgtr_phy *gtr_phy = dev_get_drvdata(dev);
+	struct clk *clk;
+	u32 pll_status;
+
+	mutex_lock(&gtr_phy->phy->mutex);
+	pll_status = xpsgtr_read_phy(gtr_phy, L0_PLL_STATUS_READ_1);
+	clk = gtr_phy->dev->clk[gtr_phy->refclk];
+
+	seq_printf(seq, "Lane:            %u\n", gtr_phy->lane);
+	seq_printf(seq, "Protocol:        %s\n",
+		   xpsgtr_icm_str[gtr_phy->protocol]);
+	seq_printf(seq, "Instance:        %u\n", gtr_phy->instance);
+	seq_printf(seq, "Reference clock: %u (%pC)\n", gtr_phy->refclk, clk);
+	seq_printf(seq, "Reference rate:  %lu\n", clk_get_rate(clk));
+	seq_printf(seq, "PLL locked:      %s\n",
+		   pll_status & PLL_STATUS_LOCKED ? "yes" : "no");
+
+	mutex_unlock(&gtr_phy->phy->mutex);
+	return 0;
+}
+
 /*
  * Power Management
  */
@@ -937,6 +975,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
 
 		gtr_phy->phy = phy;
 		phy_set_drvdata(phy, gtr_phy);
+		debugfs_create_devm_seqfile(&phy->dev, "status", phy->debugfs,
+					    xpsgtr_status_read);
 	}
 
 	/* Register the PHY provider. */
-- 
2.35.1.1320.gc452695387.dirty



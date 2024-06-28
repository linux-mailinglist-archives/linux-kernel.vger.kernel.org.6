Return-Path: <linux-kernel+bounces-234531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCB091C7A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2268D1F2199D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E21C133987;
	Fri, 28 Jun 2024 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jlVQwsY4"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861812FF63
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608173; cv=none; b=DRPzHmFGg3+8TVypA2ESlDfjKdPRarPqmkaSMIUTs8LH3NX6nJXqb1GF37Tsy/z519Yz75z0+GyF0CdwwR64s/Et0GmQKhOdF7hkuaAfnez++KBjja1u9NljYLpyHoDveYQiAVf+QDct0qMUfu6hgILgDQDh3IGArC8AEYQ/fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608173; c=relaxed/simple;
	bh=Vr4GWAtkI0RK8RKzAPo9ZX18QXiqWSiamhRUG0ug9As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NIUMm4t3fwiD5RUzNyKfe2AZ24xGnvodTUJ1KvgN2nB4j7v7fgE3QWj4bIIZodSjXFM/DN2p02TyWiA1GZTn6ybU/QkZi4MyLSlUGOQPsDcEhrGwPzkiQNqSWOEjNAK6OKO4Ttss2dgMdAqb7qj7vK4lPK56dhTppp+6QTmiL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jlVQwsY4; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cc0/PQs/I7BBZwE0Aen+Vq0PIaX9cTiisku8tz9D9Po=;
	b=jlVQwsY43r14MNC0D6Flo6YEepgaDVnzgdU91I+spzzM5yeGX12vDVymiuiuwed3w1+dwF
	zkX4UQWOAOtby4t7+krBw4qHLQ3oQohWjYNn6s7/oU6gf5nqaUb6A7upuxwMeslkcfziLy
	9Eb2ApDhlfu9CO+BrOWHjSLDWf5CDzk=
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
Subject: [PATCH v3 5/5] phy: zynqmp: Add debugfs support
Date: Fri, 28 Jun 2024 16:55:40 -0400
Message-Id: <20240628205540.3098010-6-sean.anderson@linux.dev>
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

Add support for printing some basic status information to debugfs. This
is helpful when debugging phy consumers to make sure they are configuring
the phy appropriately.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- Use "none" to represent ICM_PROTOCOL_PD, since the lane may not
  actually be powered-down.

Changes in v2:
- Use debugfs_create_devm_seqfile

 drivers/phy/xilinx/phy-zynqmp.c | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 991be42eef3d..cb15041371c9 100644
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
+	[ICM_PROTOCOL_PD] = "none",
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
@@ -787,6 +797,34 @@ static struct phy *xpsgtr_xlate(struct device *dev,
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
@@ -936,6 +974,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
 
 		gtr_phy->phy = phy;
 		phy_set_drvdata(phy, gtr_phy);
+		debugfs_create_devm_seqfile(&phy->dev, "status", phy->debugfs,
+					    xpsgtr_status_read);
 	}
 
 	/* Register the PHY provider. */
-- 
2.35.1.1320.gc452695387.dirty



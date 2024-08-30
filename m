Return-Path: <linux-kernel+bounces-308001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207FC96560D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CC01C21EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC8614C585;
	Fri, 30 Aug 2024 03:58:35 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3AA13D53E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990315; cv=none; b=j6iUUWtr3xP+gnd9nE+kVmkQbeopEzIdX2Kps3XiqULZvguqSZmGKvtAvtsQQqu6xkhi8P8d0NjzfHH670qpg3d2vkSGvBnG7E5aZHvP7szp9e/LTjLghywYXGtX/wBRzEA5iFnVJQMm6pVVQlGJa7+HZwXu5rfwNSH5aLPDbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990315; c=relaxed/simple;
	bh=z8f6m//cRs9df2j2uEfVxe9DiqfsopdJL1GsiBEFfko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aB8dRl0Dsu0Iut+GPdLE1j0C3xibeyqHtL35iUZtdH57NAe3V8HitJ3pJ5rIxOIbtgS2h+Sw16CPtYy95JlcPu7sw0ct9aeCYjTr6MQ1qjpwRKofOVIu+EEpZvxiYTZXvOB9MGN1CY8rejHUbDR5wwWhAHFuY43+AN90a6oD4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ww48Z2BJJzpV4p;
	Fri, 30 Aug 2024 11:56:46 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E41171401F3;
	Fri, 30 Aug 2024 11:58:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 11:58:30 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <herve.codina@bootlin.com>, <qiang.zhao@nxp.com>,
	<christophe.leroy@csgroup.eu>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 4/4] soc: fsl: cpm1: qmc: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 12:06:36 +0800
Message-ID: <20240830040636.3508679-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830040636.3508679-1-ruanjinjie@huawei.com>
References: <20240830040636.3508679-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use the dev_err_probe() helper to simplify error handling during probe.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Update the commit message.
---
 drivers/soc/fsl/qe/qmc.c | 53 ++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index d5937b5b5f15..4315af115b8e 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1182,14 +1182,10 @@ static int qmc_of_parse_chans(struct qmc *qmc, struct device_node *np)
 
 	for_each_available_child_of_node_scoped(np, chan_np) {
 		ret = of_property_read_u32(chan_np, "reg", &chan_id);
-		if (ret) {
-			dev_err(qmc->dev, "%pOF: failed to read reg\n", chan_np);
-			return ret;
-		}
-		if (chan_id > 63) {
-			dev_err(qmc->dev, "%pOF: Invalid chan_id\n", chan_np);
-			return -EINVAL;
-		}
+		if (ret)
+			return dev_err_probe(qmc->dev, ret, "%pOF: failed to read reg\n", chan_np);
+		if (chan_id > 63)
+			return dev_err_probe(qmc->dev, -EINVAL, "%pOF: Invalid chan_id\n", chan_np);
 
 		chan = devm_kzalloc(qmc->dev, sizeof(*chan), GFP_KERNEL);
 		if (!chan)
@@ -1201,39 +1197,34 @@ static int qmc_of_parse_chans(struct qmc *qmc, struct device_node *np)
 		spin_lock_init(&chan->tx_lock);
 
 		ret = of_property_read_u64(chan_np, "fsl,tx-ts-mask", &ts_mask);
-		if (ret) {
-			dev_err(qmc->dev, "%pOF: failed to read fsl,tx-ts-mask\n",
-				chan_np);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(qmc->dev, ret,
+					     "%pOF: failed to read fsl,tx-ts-mask\n",
+					     chan_np);
 		chan->tx_ts_mask_avail = ts_mask;
 		chan->tx_ts_mask = chan->tx_ts_mask_avail;
 
 		ret = of_property_read_u64(chan_np, "fsl,rx-ts-mask", &ts_mask);
-		if (ret) {
-			dev_err(qmc->dev, "%pOF: failed to read fsl,rx-ts-mask\n",
-				chan_np);
-			return ret;
-		}
+		if (ret)
+			dev_err_probe(qmc->dev, ret, "%pOF: failed to read fsl,rx-ts-mask\n",
+				      chan_np);
 		chan->rx_ts_mask_avail = ts_mask;
 		chan->rx_ts_mask = chan->rx_ts_mask_avail;
 
 		mode = "transparent";
 		ret = of_property_read_string(chan_np, "fsl,operational-mode", &mode);
-		if (ret && ret != -EINVAL) {
-			dev_err(qmc->dev, "%pOF: failed to read fsl,operational-mode\n",
-				chan_np);
-			return ret;
-		}
+		if (ret && ret != -EINVAL)
+			return dev_err_probe(qmc->dev, ret,
+					     "%pOF: failed to read fsl,operational-mode\n",
+					     chan_np);
 		if (!strcmp(mode, "transparent")) {
 			chan->mode = QMC_TRANSPARENT;
 		} else if (!strcmp(mode, "hdlc")) {
 			chan->mode = QMC_HDLC;
-		} else {
-			dev_err(qmc->dev, "%pOF: Invalid fsl,operational-mode (%s)\n",
-				chan_np, mode);
-			return -EINVAL;
-		}
+		} else
+			return dev_err_probe(qmc->dev, -EINVAL,
+					     "%pOF: Invalid fsl,operational-mode (%s)\n",
+					     chan_np, mode);
 
 		chan->is_reverse_data = of_property_read_bool(chan_np,
 							      "fsl,reverse-data");
@@ -1590,10 +1581,8 @@ static int qmc_probe(struct platform_device *pdev)
 
 	/* Connect the serial (SCC) to TSA */
 	ret = tsa_serial_connect(qmc->tsa_serial);
-	if (ret) {
-		dev_err(qmc->dev, "Failed to connect TSA serial\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(qmc->dev, ret, "Failed to connect TSA serial\n");
 
 	/* Parse channels informationss */
 	ret = qmc_of_parse_chans(qmc, np);
-- 
2.34.1



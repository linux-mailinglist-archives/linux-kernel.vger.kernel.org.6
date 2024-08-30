Return-Path: <linux-kernel+bounces-308003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B2965610
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5D2288290
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70714D6FC;
	Fri, 30 Aug 2024 03:58:40 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1D13D53E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990319; cv=none; b=O261mo/Ng/gGBTEUA4l3Ga6lJLNbrAXpD44SBfJAeq5iH9/wMpyRGKWOYiLuP49ogpaM0pKC6FXpbPUm69a4AGkaDWq++y7sn3MEUzXJc4wbqlVH+lmd3TKBx4+YITYKLhJev1biUYdLunLlHCgtoGgTDR/PjVLpe1V+OH2tn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990319; c=relaxed/simple;
	bh=0a0i47uKCzCqIbQ3w+80kBW3Q8hFOG9useEP0JsQsPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIgws/ryIQcNxQdiAbmgrcicvBMgQ6UlGLf7dod2qhxHx7N7ECuuzuugpeXD/lfYlr9SxzgvbU8rCllMYuFP1P1Hhdg2/UB8aBOg6YaiAt0+GMAtBEX5zNbEylsA+N7uzWI0n0RjEE37fpNfY8q4fBe1P5HqXAlk7cbBcVn2Kfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ww4BH6df0z1S9QM;
	Fri, 30 Aug 2024 11:58:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DF771A0188;
	Fri, 30 Aug 2024 11:58:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 11:58:29 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <herve.codina@bootlin.com>, <qiang.zhao@nxp.com>,
	<christophe.leroy@csgroup.eu>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 2/4] soc: fsl: cpm1: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 12:06:34 +0800
Message-ID: <20240830040636.3508679-3-ruanjinjie@huawei.com>
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
 drivers/soc/fsl/qe/tsa.c | 62 +++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 7fa399b7a47c..fc37d23b746d 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -453,10 +453,8 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 
 	for_each_available_child_of_node_scoped(np, tdm_np) {
 		ret = of_property_read_u32(tdm_np, "reg", &tdm_id);
-		if (ret) {
-			dev_err(tsa->dev, "%pOF: failed to read reg\n", tdm_np);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(tsa->dev, ret, "%pOF: failed to read reg\n", tdm_np);
 		switch (tdm_id) {
 		case 0:
 			tsa->tdms |= BIT(TSA_TDMA);
@@ -465,18 +463,15 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 			tsa->tdms |= BIT(TSA_TDMB);
 			break;
 		default:
-			dev_err(tsa->dev, "%pOF: Invalid tdm_id (%u)\n", tdm_np,
-				tdm_id);
-			return -EINVAL;
+			return dev_err_probe(tsa->dev, -EINVAL, "%pOF: Invalid tdm_id (%u)\n",
+					     tdm_np, tdm_id);
 		}
 	}
 
 	for_each_available_child_of_node_scoped(np, tdm_np) {
 		ret = of_property_read_u32(tdm_np, "reg", &tdm_id);
-		if (ret) {
-			dev_err(tsa->dev, "%pOF: failed to read reg\n", tdm_np);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(tsa->dev, ret, "%pOF: failed to read reg\n", tdm_np);
 
 		tdm = &tsa->tdm[tdm_id];
 		tdm->simode_tdm = TSA_SIMODE_TDM_SDM_NORM;
@@ -484,35 +479,26 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 		val = 0;
 		ret = of_property_read_u32(tdm_np, "fsl,rx-frame-sync-delay-bits",
 					   &val);
-		if (ret && ret != -EINVAL) {
-			dev_err(tsa->dev,
-				"%pOF: failed to read fsl,rx-frame-sync-delay-bits\n",
-				tdm_np);
-			return ret;
-		}
-		if (val > 3) {
-			dev_err(tsa->dev,
-				"%pOF: Invalid fsl,rx-frame-sync-delay-bits (%u)\n",
-				tdm_np, val);
-			return -EINVAL;
-		}
+		if (ret && ret != -EINVAL)
+			return dev_err_probe(tsa->dev, ret,
+					     "%pOF: failed to read fsl,rx-frame-sync-delay-bits\n",
+					     tdm_np);
+		if (val > 3)
+			return dev_err_probe(tsa->dev, -EINVAL,
+					     "%pOF: Invalid fsl,rx-frame-sync-delay-bits (%u)\n",
+					     tdm_np, val);
 		tdm->simode_tdm |= TSA_SIMODE_TDM_RFSD(val);
 
 		val = 0;
 		ret = of_property_read_u32(tdm_np, "fsl,tx-frame-sync-delay-bits",
 					   &val);
-		if (ret && ret != -EINVAL) {
-			dev_err(tsa->dev,
-				"%pOF: failed to read fsl,tx-frame-sync-delay-bits\n",
-				tdm_np);
-			return ret;
-		}
-		if (val > 3) {
-			dev_err(tsa->dev,
-				"%pOF: Invalid fsl,tx-frame-sync-delay-bits (%u)\n",
-				tdm_np, val);
-			return -EINVAL;
-		}
+		if (ret && ret != -EINVAL)
+			return dev_err_probe(tsa->dev, ret,
+				"%pOF: failed to read fsl,tx-frame-sync-delay-bits\n", tdm_np);
+		if (val > 3)
+			return dev_err_probe(tsa->dev, -EINVAL,
+					     "%pOF: Invalid fsl,tx-frame-sync-delay-bits (%u)\n",
+					     tdm_np, val);
 		tdm->simode_tdm |= TSA_SIMODE_TDM_TFSD(val);
 
 		if (of_property_read_bool(tdm_np, "fsl,common-rxtx-pins"))
@@ -645,10 +631,8 @@ static int tsa_probe(struct platform_device *pdev)
 		return PTR_ERR(tsa->si_regs);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "si_ram");
-	if (!res) {
-		dev_err(tsa->dev, "si_ram resource missing\n");
-		return -EINVAL;
-	}
+	if (!res)
+		return dev_err_probe(tsa->dev, -EINVAL, "si_ram resource missing\n");
 	tsa->si_ram_sz = resource_size(res);
 	tsa->si_ram = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(tsa->si_ram))
-- 
2.34.1



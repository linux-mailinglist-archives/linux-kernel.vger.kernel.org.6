Return-Path: <linux-kernel+bounces-300785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBAC95E851
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7B6B20BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD29683CDB;
	Mon, 26 Aug 2024 06:16:27 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB944376;
	Mon, 26 Aug 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652987; cv=none; b=RAB8BB0Ib013d9Qh4hdOEJpeRk+fVPdMbHDDmDxnk/69As6IiwfnkJzq+IfnVarzhOt4a0pe7QzwnHcU6sfn+DoVQnCfyk97yZVlnV4D57vNcDyfEQZqZVFEp7j1o57J3ORtRNUWPrpfCaHbrnfaXiI/iEQqd6NGYGObVfNyvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652987; c=relaxed/simple;
	bh=9Bx+mlTFJh7CVQogVmIRk06zCokEZG5UXiMI/hIhcH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IETTe8i6jd+MDkhHl+EsMRMFA8hgkYcayAX8EWg9YcSB611DRBliFW1GylLfmplkZKtmIWSFhrp+3/igKD5epIN7cSjjmbOkwlYU1DeACjDd9dZ3cXtOQjBBMTA8KtTT8DusTv0y3vY+J5sIa2EvkWGU2bSn6PtUKg3Z+CUbWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WsgQx4pTSzyR52;
	Mon, 26 Aug 2024 14:15:53 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 91F341404FC;
	Mon, 26 Aug 2024 14:16:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 14:16:21 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <krzk@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 2/3] of/platform: Simplify with scoped for each OF child
Date: Mon, 26 Aug 2024 14:24:07 +0800
Message-ID: <20240826062408.2406734-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826062408.2406734-1-ruanjinjie@huawei.com>
References: <20240826062408.2406734-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/of/platform.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 86be4dfb9323..ebc8f0359a95 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -338,7 +338,6 @@ static int of_platform_bus_create(struct device_node *bus,
 				  struct device *parent, bool strict)
 {
 	const struct of_dev_auxdata *auxdata;
-	struct device_node *child;
 	struct platform_device *dev;
 	const char *bus_id = NULL;
 	void *platform_data = NULL;
@@ -382,13 +381,11 @@ static int of_platform_bus_create(struct device_node *bus,
 	if (!dev || !of_match_node(matches, bus))
 		return 0;
 
-	for_each_child_of_node(bus, child) {
+	for_each_child_of_node_scoped(bus, child) {
 		pr_debug("   create child: %pOF\n", child);
 		rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
-		if (rc) {
-			of_node_put(child);
+		if (rc)
 			break;
-		}
 	}
 	of_node_set_flag(bus, OF_POPULATED_BUS);
 	return rc;
@@ -459,7 +456,6 @@ int of_platform_populate(struct device_node *root,
 			const struct of_dev_auxdata *lookup,
 			struct device *parent)
 {
-	struct device_node *child;
 	int rc = 0;
 
 	root = root ? of_node_get(root) : of_find_node_by_path("/");
@@ -470,12 +466,10 @@ int of_platform_populate(struct device_node *root,
 	pr_debug(" starting at: %pOF\n", root);
 
 	device_links_supplier_sync_state_pause();
-	for_each_child_of_node(root, child) {
+	for_each_child_of_node_scoped(root, child) {
 		rc = of_platform_bus_create(child, matches, lookup, parent, true);
-		if (rc) {
-			of_node_put(child);
+		if (rc)
 			break;
-		}
 	}
 	device_links_supplier_sync_state_resume();
 
-- 
2.34.1



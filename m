Return-Path: <linux-kernel+bounces-296788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A195AF30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B341C22CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392617E005;
	Thu, 22 Aug 2024 07:20:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7617DFF5;
	Thu, 22 Aug 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311202; cv=none; b=JD6pdqe/2F/dDbk0p69iOTM4ed66/0sI413cO5yZlD2EIH6QU4RcyuxRY/AOeVsf8ff9WQhipqjcutFsSjTlqYta+6b+Sua8CPXBiUQ8us3e56rkeA38JWO2x1CWLX22lVw7dGE90WkgAmN1jXhYv+Tk7NKVc3s7FDAk7B3j1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311202; c=relaxed/simple;
	bh=rOvd85FI7PCMs5Ot0GiMcBg5jGcZBE+fM0C9/VVTsLQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dwrU65eMLUu4dl73AzqIFV7nSPJz0ax22JAAbdcY71MTuKmPtozLF6m3dM6LXgk19MO10MpuXpaU4zcG6sjg7LxUPR+NFk7zAc23LimKRqQbkw174d67YQWye2NHEJQjC84Q59ny4a/dlAwkC/zQ6wp9iIm1329sVTxzW5VEA0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqF2f448Cz2CnDN;
	Thu, 22 Aug 2024 15:19:54 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id F07411400FD;
	Thu, 22 Aug 2024 15:19:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Aug
 2024 15:19:57 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] of: overlay: Simplify with scoped for each OF child loop
Date: Thu, 22 Aug 2024 15:27:24 +0800
Message-ID: <20240822072724.3549631-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/of/overlay.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 4d861a75d694..cbdecccca097 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -472,7 +472,6 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 static int build_changeset_next_level(struct overlay_changeset *ovcs,
 		struct target *target, const struct device_node *overlay_node)
 {
-	struct device_node *child;
 	struct property *prop;
 	int ret;
 
@@ -485,12 +484,11 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
 		}
 	}
 
-	for_each_child_of_node(overlay_node, child) {
+	for_each_child_of_node_scoped(overlay_node, child) {
 		ret = add_changeset_node(ovcs, target, child);
 		if (ret) {
 			pr_debug("Failed to apply node @%pOF/%pOFn, err=%d\n",
 				 target->np, child, ret);
-			of_node_put(child);
 			return ret;
 		}
 	}
@@ -1078,16 +1076,12 @@ EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
  */
 static int find_node(struct device_node *tree, struct device_node *np)
 {
-	struct device_node *child;
-
 	if (tree == np)
 		return 1;
 
-	for_each_child_of_node(tree, child) {
-		if (find_node(child, np)) {
-			of_node_put(child);
+	for_each_child_of_node_scoped(tree, child) {
+		if (find_node(child, np))
 			return 1;
-		}
 	}
 
 	return 0;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-300786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2295E854
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AD11C20B84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640DD84FA0;
	Mon, 26 Aug 2024 06:16:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858B4205D;
	Mon, 26 Aug 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652988; cv=none; b=klTDnwG8+JVfsKzbkW8KNtXAI6WzS3fJGXfzdrLrhLIOUjxNdn3CVdj7pKy2t52sWaN8dctKfmFQHBV6FR4NI+MZNpFEj+bo3CT6ARAZs+mo1GKVa04A4X4dzY0Gl3DpXbkO5yCuwKlC+PsqTzfQPuuhGr4s3QWYOM8vPEv2RjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652988; c=relaxed/simple;
	bh=rOvd85FI7PCMs5Ot0GiMcBg5jGcZBE+fM0C9/VVTsLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ez+sGptjQ8LSLYN1lsaW6OEfyV3ixi6qeNh1oOxlyKFzv8BCW0AnqkJYLe4J6grpBXxsfnvWjrLwxpGZ7Kmr5pNTlkpMy1IgscAQm8SIjqqhxecuXDEBg8JgqXd5kAOt+eEnEnURCcu/VnTFgtiXr8TdtEDZs0HHNVAvgqBltAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WsgPZ46D3zpTQ0;
	Mon, 26 Aug 2024 14:14:42 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 441A3140120;
	Mon, 26 Aug 2024 14:16:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 14:16:20 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <krzk@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 1/3] of: overlay: Simplify with scoped for each OF child loop
Date: Mon, 26 Aug 2024 14:24:06 +0800
Message-ID: <20240826062408.2406734-2-ruanjinjie@huawei.com>
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



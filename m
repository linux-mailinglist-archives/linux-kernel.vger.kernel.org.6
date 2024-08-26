Return-Path: <linux-kernel+bounces-300784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BFB95E84F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094A31F212CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC14882877;
	Mon, 26 Aug 2024 06:16:26 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4262A02;
	Mon, 26 Aug 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652986; cv=none; b=g+YrV5NdllF1IEmuR+rTE6cCNpCHeZDrLSpEt7smf0cERmwt8N+dcg3N2TNEYX7ORT4fbiHVUEZdEyiHHFt0RYwO+G3O8a2NbZxmWpskk7OrtD+3HBEjbWB08XlCQ4rJJqEOi6+Toq6JG8p3C237gKIx3qZrHlq2S5B6Kv/hPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652986; c=relaxed/simple;
	bh=Xays7bld+bCbbiXsEDuwx1Ur7OWw3FT7eghZQVYCbwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loXTkBvLHZBGXbY6Oxyh/aJh8Jv0gQrjhGmtQ7E2XVxryVCAtptydeKuuiy7iOBDcSL5ad7V48HWUh+floSRXJHCHsvtxhMw2OaKdMFTHWjLF9n0cUnp0cbTquiXIMKfXIwO5+Um/0R0Vj0M+a1CNxygiAufRpHPzn6g8TnGR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WsgMh42yHz1HHL2;
	Mon, 26 Aug 2024 14:13:04 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E042B1A0188;
	Mon, 26 Aug 2024 14:16:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 14:16:21 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <krzk@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 3/3] of: resolver: Simplify with scoped for each OF child loop
Date: Mon, 26 Aug 2024 14:24:08 +0800
Message-ID: <20240826062408.2406734-4-ruanjinjie@huawei.com>
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
 drivers/of/resolver.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 2780928764a4..5cf96776dd7d 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -150,7 +150,7 @@ static int node_name_cmp(const struct device_node *dn1,
 static int adjust_local_phandle_references(struct device_node *local_fixups,
 		struct device_node *overlay, int phandle_delta)
 {
-	struct device_node *child, *overlay_child;
+	struct device_node *overlay_child;
 	struct property *prop_fix, *prop;
 	int err, i, count;
 	unsigned int off;
@@ -194,7 +194,7 @@ static int adjust_local_phandle_references(struct device_node *local_fixups,
 	 * The roots of the subtrees are the overlay's __local_fixups__ node
 	 * and the overlay's root node.
 	 */
-	for_each_child_of_node(local_fixups, child) {
+	for_each_child_of_node_scoped(local_fixups, child) {
 
 		for_each_child_of_node(overlay, overlay_child)
 			if (!node_name_cmp(child, overlay_child)) {
@@ -202,17 +202,13 @@ static int adjust_local_phandle_references(struct device_node *local_fixups,
 				break;
 			}
 
-		if (!overlay_child) {
-			of_node_put(child);
+		if (!overlay_child)
 			return -EINVAL;
-		}
 
 		err = adjust_local_phandle_references(child, overlay_child,
 				phandle_delta);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
-- 
2.34.1



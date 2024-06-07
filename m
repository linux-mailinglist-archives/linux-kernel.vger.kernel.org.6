Return-Path: <linux-kernel+bounces-205318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E98FFA94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DD71C24010
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B40156C5B;
	Fri,  7 Jun 2024 04:27:19 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24885155737
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734436; cv=none; b=DVKC+DZRibKv4VjyAaHGKFlg32fVXAbx7NOPTm3lKuU9JypBDjZwunQYoqfskZc+xc2Kycwya/IdAluVQA8m923KL5hFG/E/4GWdSzMcD9yR1Km5hrdDcULNFc2L3LzD4JHn1h/9HH/qNGzJkIC7yPLwY1CabKiBGim11KY8z1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734436; c=relaxed/simple;
	bh=+wK5w+0i0E9yf0r5rV3Z0VpKTK5KEF+PJ0Gpt9VrqfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKvvyQ5FVkJ9cs1ItoC76KVNIxMQLJciqGZeafaUMH6CqD+6U+j0LbZfxKsUkcnpE9VsMcEHjethSxMVumxXvky1UkuuISNyihEVvrfgO3dtP/HYedWoOvG0R4Hg2ZO/LZOfDJgHJnepKkbiBokZBiTj7B6aNk57ctWs4I0Zrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSkc3gDFzPpnZ;
	Fri,  7 Jun 2024 12:23:52 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id C86E018007E;
	Fri,  7 Jun 2024 12:27:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:03 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 049/110] ubifs-utils: Adapt master.c in libubifs
Date: Fri, 7 Jun 2024 12:25:14 +0800
Message-ID: <20240607042615.2069840-50-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Adapt master.c in libubifs, compared with linux kernel implementations:
 1. Remove authentication related implementations
    (eg. mst_node_check_hash), authentication is not supported in fsck
    for now.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/master.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/ubifs-utils/libubifs/master.c b/ubifs-utils/libubifs/master.c
index 7adc37c1..cce1a415 100644
--- a/ubifs-utils/libubifs/master.c
+++ b/ubifs-utils/libubifs/master.c
@@ -10,7 +10,11 @@
 
 /* This file implements reading and writing the master node */
 
+#include "linux_err.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
 
 /**
  * ubifs_compare_master_node - compare two UBIFS master nodes
@@ -21,7 +25,7 @@
  * This function compares two UBIFS master nodes. Returns 0 if they are equal
  * and nonzero if not.
  */
-int ubifs_compare_master_node(struct ubifs_info *c, void *m1, void *m2)
+int ubifs_compare_master_node(__unused struct ubifs_info *c, void *m1, void *m2)
 {
 	int ret;
 	int behind;
@@ -61,20 +65,11 @@ int ubifs_compare_master_node(struct ubifs_info *c, void *m1, void *m2)
  *
  * Returns 0 if the hashes are equal, a negative error code otherwise.
  */
-static int mst_node_check_hash(const struct ubifs_info *c,
-			       const struct ubifs_mst_node *mst,
-			       const u8 *expected)
+static int mst_node_check_hash(__unused const struct ubifs_info *c,
+			       __unused const struct ubifs_mst_node *mst,
+			       __unused const u8 *expected)
 {
-	u8 calc[UBIFS_MAX_HASH_LEN];
-	const void *node = mst;
-
-	crypto_shash_tfm_digest(c->hash_tfm, node + sizeof(struct ubifs_ch),
-				UBIFS_MST_NODE_SZ - sizeof(struct ubifs_ch),
-				calc);
-
-	if (ubifs_check_hash(c, expected, calc))
-		return -EPERM;
-
+	// To be implemented
 	return 0;
 }
 
-- 
2.13.6



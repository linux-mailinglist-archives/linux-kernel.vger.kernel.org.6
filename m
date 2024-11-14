Return-Path: <linux-kernel+bounces-409717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC19C907C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61301F21112
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E317A583;
	Thu, 14 Nov 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e5sEXTDf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977F188A15
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603942; cv=none; b=RXjV+h5QZpDlQVvewrSTWFyZri8F2nVa18QorynOQooAUBfZPMe1PvZAPssg0WEm6zfZoBHP0PH260NaLA9cxuniGB8Ds1+f3jC6MsotJIdtoCI7kmdT1Z4g0LoXKC34FxXuCAy/F37kQcTsswr4aKjuGvV9hwc+915tUANLOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603942; c=relaxed/simple;
	bh=7nlDCyySdr8N5wOBTpeEwUUUmZ7mni5cFGtHr8tlGfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNuMXBAzIa+bMKpz1PA6bjMZ1issbOGOX4yjG4NNd2CKWCDTQwUbMCyBtglnU4wJGQqGQc9PKmfNAyC4dBOffReB7OEogulYBIETpREEGF5fqWLYYalcAMZHUBf7oMbzvLAzn7NCCnn8oxTjdHRrwoTLr+hvdRONFQcAPoK/b2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e5sEXTDf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECsbMo014973;
	Thu, 14 Nov 2024 17:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=ynPl9
	gjds2k6dEiCMO+N2WSsdWiMIGwmXOvf0GpdocM=; b=e5sEXTDfO+9txCvBL2gaO
	PseoX1Eu4WM0EXd5Ua2tbRQFg21bv7KA3iM8o1O9Ft/JnW2n7NXbXDLVd2ziBk4b
	HscKR7HmWMTNgTGw3TQqz9OnMETwj0az+WHOz0BSHqUZBkEKrL3b7mgPxFwOP6wr
	fb7ChzvfT+YXJa30KiBDpU5nzGBWGHT4IaHV+vZZS3M6rdnwaoW9YKxnTtHw21XG
	ynTRsJtRJV7yyXi9d37B+uPJBA1l58W9KM3JE+Vib6QPzG0qEzJUJC/GrrVUq941
	kPpJLdtycht+uHqGQqLt5B4LUBADwoePYA/GJvskSxqxsD5PWrafIOr1CUicb/6Q
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k29phu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEGqCFR022850;
	Thu, 14 Nov 2024 17:05:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1jy9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEH5QmR032739;
	Thu, 14 Nov 2024 17:05:31 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-39-201-66.vpn.oracle.com [10.39.201.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42vuw1jy5w-6;
	Thu, 14 Nov 2024 17:05:31 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 5/5] maple_tree: add sufficient height
Date: Thu, 14 Nov 2024 12:05:24 -0500
Message-ID: <20241114170524.64391-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140134
X-Proofpoint-ORIG-GUID: Y-Yt0maQHdk3t4xGXgbaBnY9e5HIwRyM
X-Proofpoint-GUID: Y-Yt0maQHdk3t4xGXgbaBnY9e5HIwRyM

If a parent node is vacant but holds mt_min_slots + 1 entries,
rebalancing with a leaf node could cause this parent node to become
insufficient. This will lead to another level of rebalancing in the tree
and requires more node allocations. Therefore, we also have to track the
level at which there is a node with > mt_min_slots entries. We can use
this as the worst case for the wr_rebalance case.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/maple_tree.h       |  4 +++-
 lib/maple_tree.c                 | 14 +++++++++++++-
 tools/testing/radix-tree/maple.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 7d777aa2d9ed..37dc9525dff6 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -464,6 +464,7 @@ struct ma_wr_state {
 	void *entry;			/* The entry to write */
 	void *content;			/* The existing entry that is being overwritten */
 	unsigned char vacant_height;	/* Depth of lowest node with free space */
+	unsigned char sufficient_height;/* Depth of lowest node with min sufficiency + 1 nodes */
 };
 
 #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
@@ -499,7 +500,8 @@ struct ma_wr_state {
 		.mas = ma_state,					\
 		.content = NULL,					\
 		.entry = wr_entry,					\
-		.vacant_height = 0					\
+		.vacant_height = 0,					\
+		.sufficient_height = 0					\
 	}
 
 #define MA_TOPIARY(name, tree)						\
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 59c5c3f8db30..3d39773601d3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3558,6 +3558,14 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 		if (mas->end < mt_slots[wr_mas->type] - 1)
 			wr_mas->vacant_height = mas->depth + 1;
 
+		if (ma_is_root(mas_mn(mas)))
+			/* root needs more than 2 entries to be sufficient + 1 */
+			if (mas->end > 2)
+				wr_mas->sufficient_height = 1;
+
+		if (mas->end > mt_min_slots[wr_mas->type] + 1)
+			wr_mas->sufficient_height = mas->depth + 1;
+
 		mas_wr_walk_traverse(wr_mas);
 	}
 
@@ -4198,7 +4206,11 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 		ret = delta * 2 + 1;
 		break;
 	case wr_rebalance:
-		ret = height * 2 + 1;
+		if (wr_mas->sufficient_height < wr_mas->vacant_height) {
+			ret = (height - wr_mas->sufficient_height) * 2 + 1;
+			break;
+		}
+		ret = delta * 2 + 1;
 		break;
 	case wr_node_store:
 		ret = mt_in_rcu(mas->tree) ? 1 : 0;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index bc8b107e0177..f55ab8c8b491 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36329,6 +36329,30 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
 
 extern void test_kmem_cache_bulk(void);
 
+/*
+ * Test to check the path of a spanning rebalance which results in
+ * a collapse where the rebalancing of the child node leads to
+ * insufficieny in the parent node.
+ */
+static void check_collapsing_rebalance(struct maple_tree *mt)
+{
+	int i = 0;
+	MA_STATE(mas, mt, ULONG_MAX, ULONG_MAX);
+
+	/* create a height 4 tree */
+	while (mt_height(mt) < 4) {
+		mtree_store_range(mt, i, i + 10, xa_mk_value(i), GFP_KERNEL);
+		i += 9;
+	}
+
+	/* delete all entries one at a time, starting from the right */
+	do {
+		mas_erase(&mas);
+	} while (mas_prev(&mas, 0) != NULL);
+
+	mtree_unlock(mt);
+}
+
 /* callback function used for check_nomem_writer_race() */
 static void writer2(void *maple_tree)
 {
@@ -36495,6 +36519,10 @@ void farmer_tests(void)
 	check_spanning_write(&tree);
 	mtree_destroy(&tree);
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_collapsing_rebalance(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_null_expand(&tree);
 	mtree_destroy(&tree);
-- 
2.43.0



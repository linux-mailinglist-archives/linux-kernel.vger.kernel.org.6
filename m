Return-Path: <linux-kernel+bounces-537292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A02A48A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD53A6BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D534A27183A;
	Thu, 27 Feb 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B/MWfCW/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50589271808
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689326; cv=none; b=PZQ3Va5Vtp3NLjCnZksT81wyBCN9Vn/pRRdaGLdfL48+8Ev60toRMpXH6pRGYCpmXyrHFz42+d0RCuBvm0SgXanMVbZzln51v/tcCOAERYLYnvaHQwzoTjzeCnOPAIhpfdO5oSvBEZcPc6NWuUVh2/JZ7mnvmw4qlr+RKJKjq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689326; c=relaxed/simple;
	bh=SXKMeXI+VYQTdlPVdyCNpF6RPwijEnz1Hk82zR5+MH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxSQioRTvxIyJ22fyNfY7qhodB5dV+9Hf/XummJyJeAFAh/TBhVVJ3RL/Nbe+OBsFL797Dd2Vv2epq/Fcc7xIbZjxWIdTc2Y6BGirl4UbVUR7bM63YPCAiET64bIAV/RNHtm/GWt+CL7CZgW+jrkkLlCmHCC7sfJkoXvTm9XGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B/MWfCW/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJiXZv016373;
	Thu, 27 Feb 2025 20:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=JuEm0
	THBBAVfyITvD6DAdLmtYPg2v5ViaCoOAvJ6+pg=; b=B/MWfCW/6nVzxODMI4aAh
	tGJYjO/x3zbgvlkDiywZwNdVfmtMgTS4rVDja7zV/B/2PQ0tuZI9Vh17GAiPz3qn
	tnt2776lS0aDWlgQWZE3eGq/HcwnX46ybhLlvbvcgCpctNyCPFK7r6Oi7ec9APVm
	8gXgV8Um9MwSaxx0OaMa/UlKnIHiPLdcyLSSbJfNcN79i47cJsxWr9IaMWU+Z+nQ
	6EXVs7mgEaZalrLDuLEOA1DNXoppK5AOGn/pWmgrhtEx3oEOlz3MUQr97xU3odtz
	LhNF/cSD1rF5Ll1kLEPSZKPMHGkHqXvPhJElfx7hkcsiVuL+XXHje2aqj6wCLke/
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psecbja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJB2Du012641;
	Thu, 27 Feb 2025 20:48:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dws6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51RKhrvm030883;
	Thu, 27 Feb 2025 20:48:34 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44y51dwrvc-6;
	Thu, 27 Feb 2025 20:48:34 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 5/6] maple_tree: add sufficient height
Date: Thu, 27 Feb 2025 20:48:22 +0000
Message-ID: <20250227204823.758784-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
References: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270154
X-Proofpoint-GUID: -0BP64E3TDaVjZabqOuZvlV2I6UXJsU1
X-Proofpoint-ORIG-GUID: -0BP64E3TDaVjZabqOuZvlV2I6UXJsU1

In order to support rebalancing and spanning stores using less than the
worst case number of nodes, we need to track more than just the vacant
height. Using only vacant height to reduce the worst case maple node
allocation count can lead to a shortcoming of nodes in the following
scenarios.

For rebalancing writes, when a leaf node becomes insufficient, it may be
combined with a sibling into a single node. This means that the parent node
which has entries for this children will lose one entry. If this parent node
was just meeting the minimum entries, losing one entry will now cause this
parent node to be insufficient. This leads to a cascading operation of
rebalancing at different levels and can lead to more node allocations than
simply using vacant height can return.

For spanning writes, a similar situation occurs. At the location at
which a spanning write is detected, the number of ancestor nodes may
similarly need to rebalanced into a smaller number of nodes and the same
cascading situation could occur.

To use less than the full height of the tree for the number of
allocations, we also need to track the height at which a non-leaf node
cannot become insufficient. This means even if a rebalance occurs to a
child of this node, it currently has enough entries that it can lose one
without any further action. This field is stored in the maple write state
as sufficient height. In mas_prealloc_calc() when figuring out how many
nodes to allocate, we check if the the vacant node is lower in the tree
than a sufficient node (has a larger value). If it is, we cannot use the
vacant height and must use the difference in the height and sufficient
height as the basis for the number of nodes needed.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/maple_tree.h       |  4 +++-
 lib/maple_tree.c                 | 17 +++++++++++++++--
 tools/testing/radix-tree/maple.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

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
index c859c7253d69..d3aa5241166b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3560,6 +3560,13 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 		if (mas->end < mt_slots[wr_mas->type] - 1)
 			wr_mas->vacant_height = mas->depth + 1;
 
+		if (ma_is_root(mas_mn(mas))) {
+			/* root needs more than 2 entries to be sufficient + 1 */
+			if (mas->end > 2)
+				wr_mas->sufficient_height = 1;
+		} else if (mas->end > mt_min_slots[wr_mas->type] + 1)
+			wr_mas->sufficient_height = mas->depth + 1;
+
 		mas_wr_walk_traverse(wr_mas);
 	}
 
@@ -4195,13 +4202,19 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 			ret = 0;
 		break;
 	case wr_spanning_store:
-		WARN_ON_ONCE(ret != height * 3 + 1);
+		if (wr_mas->sufficient_height < wr_mas->vacant_height)
+			ret = (height - wr_mas->sufficient_height) * 3 + 1;
+		else
+			ret = delta * 3 + 1;
 		break;
 	case wr_split_store:
 		ret = delta * 2 + 1;
 		break;
 	case wr_rebalance:
-		ret = height * 2 + 1;
+		if (wr_mas->sufficient_height < wr_mas->vacant_height)
+			ret = (height - wr_mas->sufficient_height) * 2 + 1;
+		else
+			ret = delta * 2 + 1;
 		break;
 	case wr_node_store:
 		ret = mt_in_rcu(mas->tree) ? 1 : 0;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 5950a7c9b27f..dc8e40b94c3f 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36311,6 +36311,30 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
 
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
@@ -36477,6 +36501,10 @@ void farmer_tests(void)
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



Return-Path: <linux-kernel+bounces-537290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD30A48A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524BA16BBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBEC26FA77;
	Thu, 27 Feb 2025 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NxhDk4ts"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6F270ECE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689322; cv=none; b=hVL2oZsxjXTrHDWOcG7KhjEz71jmcDYYAnvc+W8bOdEyzVXxXBr5aoilkwelDtLPxRO0YQwX8n2bein1ufV2J6Atm0pmt4M2JFCs3ngJ1W/NqDRtJ8aODCTzgeXTB/DQIx72JOzG9qDwqA4GbIu/M22n4bINMbgL0yskaP687SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689322; c=relaxed/simple;
	bh=XAZnok0S49ELWACGuseJI0Fa57i+hvs3d+sdMvKJSWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHlN9jFAX8uNo0IHzJjhHJBumUF73x4Tnol0i5nsTpTNpfdx6xUooCD27CaDVKdloE04qLYCGvTwJlntjVib8CmliQ7aj2LoxSb6KAn4EBWLP3SdSRgr+ksosku9RiXs/6tasBlWmBJ5vppvmhpKwExrOP+vcLGIlki4phDUDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NxhDk4ts; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJivuU020031;
	Thu, 27 Feb 2025 20:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=9LL2P
	3OXGfVz0nnVa8W39TneCyQ10Aw4rLIk1Wd13bw=; b=NxhDk4tsxMlSEelWIb2Z7
	1+IimFvRIjSRcWPOE+ynJTEEXqhNnTTIOi+VNTRkX4EDrd2g3294n36/vEpu1Ron
	dhYJlVYOPwWMpuUAh07HQ6K6qUhzoaikXOs8AjRn994q26oK45w+Iqw6ncOnsnbC
	uGamtv/x0etKgwTKzQC4527leb7F3e2o4RvgFQID3GhhDp41Ygb5cUIaPVqC3jhQ
	TNYv9N5hFMyH8exswQPNP3EzVM0cw7MQHhjvlc3DP2OUCLXw+k0s6vWNUXgwsWx5
	7ZyMCrjfalTrP8o7ZJ6qpAK5TvAEhSPJFNTLorfpXsDHJpisYTZtGWC1JThEjZAX
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse4bch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJ5gfs012575;
	Thu, 27 Feb 2025 20:48:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dws3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51RKhrvi030883;
	Thu, 27 Feb 2025 20:48:31 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44y51dwrvc-4;
	Thu, 27 Feb 2025 20:48:31 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 3/6] maple_tree: use vacant nodes to reduce worst case allocations
Date: Thu, 27 Feb 2025 20:48:20 +0000
Message-ID: <20250227204823.758784-4-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: HFRumWjksH2GrIpyFTFDyBAAQ3qLdNVH
X-Proofpoint-GUID: HFRumWjksH2GrIpyFTFDyBAAQ3qLdNVH

In order to determine the store type for a maple tree operation, a walk
of the tree is done through mas_wr_walk(). This function descends the
tree until a spanning write is detected or we reach a leaf node. While
descending, keep track of the height at which we encounter a node with
available space. This is done by checking if mas->end is less than the
number of slots a given node type can fit.

Now that the height of the vacant node is tracked, we can use the
difference between the height of the tree and the height of the vacant
node to know how many levels we will have to propagate creating new
nodes. Update mas_prealloc_calc() to consider the vacant height and
reduce the number of worst-case allocations.

Rebalancing and spanning stores are not supported and fall back to using
the full height of the tree for allocations.

Update preallocation testing assertions to take into account vacant
height.

Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
---
 include/linux/maple_tree.h       |  2 +
 lib/maple_tree.c                 | 13 ++++--
 tools/testing/radix-tree/maple.c | 79 ++++++++++++++++++++++++++++----
 3 files changed, 82 insertions(+), 12 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index cbbcd18d4186..7d777aa2d9ed 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -463,6 +463,7 @@ struct ma_wr_state {
 	void __rcu **slots;		/* mas->node->slots pointer */
 	void *entry;			/* The entry to write */
 	void *content;			/* The existing entry that is being overwritten */
+	unsigned char vacant_height;	/* Depth of lowest node with free space */
 };
 
 #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
@@ -498,6 +499,7 @@ struct ma_wr_state {
 		.mas = ma_state,					\
 		.content = NULL,					\
 		.entry = wr_entry,					\
+		.vacant_height = 0					\
 	}
 
 #define MA_TOPIARY(name, tree)						\
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a37837d6f3eb..878a7740628c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3544,6 +3544,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 		if (ma_is_leaf(wr_mas->type))
 			return true;
 
+		if (mas->end < mt_slots[wr_mas->type] - 1)
+			wr_mas->vacant_height = mas->depth + 1;
+
 		mas_wr_walk_traverse(wr_mas);
 	}
 
@@ -4159,7 +4162,9 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
 static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 {
 	struct ma_state *mas = wr_mas->mas;
-	int ret = mas_mt_height(mas) * 3 + 1;
+	unsigned char height = mas_mt_height(mas);
+	int ret = height * 3 + 1;
+	unsigned char delta = height - wr_mas->vacant_height;
 
 	switch (mas->store_type) {
 	case wr_invalid:
@@ -4177,13 +4182,13 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 			ret = 0;
 		break;
 	case wr_spanning_store:
-		ret =  mas_mt_height(mas) * 3 + 1;
+		WARN_ON_ONCE(ret != height * 3 + 1);
 		break;
 	case wr_split_store:
-		ret =  mas_mt_height(mas) * 2 + 1;
+		ret = delta * 2 + 1;
 		break;
 	case wr_rebalance:
-		ret =  mas_mt_height(mas) * 2 - 1;
+		ret = height * 2 + 1;
 		break;
 	case wr_node_store:
 		ret = mt_in_rcu(mas->tree) ? 1 : 0;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index bc30050227fd..5950a7c9b27f 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35475,15 +35475,65 @@ static void check_dfs_preorder(struct maple_tree *mt)
 }
 /* End of depth first search tests */
 
+/* get height of the lowest non-leaf node with free space */
+static unsigned char get_vacant_height(struct ma_wr_state *wr_mas, void *entry)
+{
+	struct ma_state *mas = wr_mas->mas;
+	char vacant_height = 0;
+	enum maple_type type;
+	unsigned long *pivots;
+	unsigned long min = 0;
+	unsigned long max = ULONG_MAX;
+	unsigned char offset;
+
+	/* start traversal */
+	mas_reset(mas);
+	mas_start(mas);
+	if (!xa_is_node(mas_root(mas)))
+		return 0;
+
+	type = mte_node_type(mas->node);
+	wr_mas->type = type;
+	while (!ma_is_leaf(type)) {
+		mas_node_walk(mas, mte_to_node(mas->node), type, &min, &max);
+		offset = mas->offset;
+		mas->end = mas_data_end(mas);
+		pivots = ma_pivots(mte_to_node(mas->node), type);
+
+		if (pivots) {
+			if (offset)
+				min = pivots[mas->offset - 1];
+			if (offset < mas->end)
+				max = pivots[mas->offset];
+		}
+		wr_mas->r_max = offset < mas->end ? pivots[offset] : mas->max;
+
+		/* detect spanning write */
+		if (mas_is_span_wr(wr_mas))
+			break;
+
+		if (mas->end < mt_slot_count(mas->node) - 1)
+			vacant_height = mas->depth + 1;
+
+		mas_descend(mas);
+		type = mte_node_type(mas->node);
+		mas->depth++;
+	}
+
+	return vacant_height;
+}
+
 /* Preallocation testing */
 static noinline void __init check_prealloc(struct maple_tree *mt)
 {
 	unsigned long i, max = 100;
 	unsigned long allocated;
 	unsigned char height;
+	unsigned char vacant_height;
 	struct maple_node *mn;
 	void *ptr = check_prealloc;
 	MA_STATE(mas, mt, 10, 20);
+	MA_WR_STATE(wr_mas, &mas, ptr);
 
 	mt_set_non_kernel(1000);
 	for (i = 0; i <= max; i++)
@@ -35494,8 +35544,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
+	vacant_height = get_vacant_height(&wr_mas, ptr);
 	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
@@ -35503,8 +35554,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
+	vacant_height = get_vacant_height(&wr_mas, ptr);
 	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
@@ -35514,7 +35566,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	vacant_height = get_vacant_height(&wr_mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mn->parent = ma_parent_ptr(mn);
@@ -35527,7 +35580,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	vacant_height = get_vacant_height(&wr_mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
@@ -35540,7 +35594,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	vacant_height = get_vacant_height(&wr_mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mas_push_node(&mas, mn);
@@ -35553,7 +35608,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	vacant_height = get_vacant_height(&wr_mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
@@ -35578,7 +35634,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 2);
+	vacant_height = get_vacant_height(&wr_mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 2);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
@@ -35595,8 +35652,14 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
+	vacant_height = get_vacant_height(&wr_mas, ptr);
 	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	/*
+	 * vacant height cannot be used to compute the number of nodes needed
+	 * as the root contains two entries which means it is on the verge of
+	 * insufficiency. The worst case full height of the tree is needed.
+	 */
+	MT_BUG_ON(mt, allocated != height * 3 + 1);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mas_set_range(&mas, 0, 200);
-- 
2.43.0



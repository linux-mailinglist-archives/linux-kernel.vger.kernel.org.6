Return-Path: <linux-kernel+bounces-526228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA8DA3FBC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162F67AAD82
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12B216E35;
	Fri, 21 Feb 2025 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JoGgR1i4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF40210F49
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155797; cv=none; b=o5xv3CXYdUq7snRc+bIYGjU9bqRM3oVcDYmRC8xQegbDcIecstLkDf4A4R7HS4tCJjxP2uDt630mL/06gudvAaD7f8zX4ZUmDqPbyPsApBQk6L54K4bPh/kiY8kCilry/EivqC0ATQxlB+/9rcll31KxFHL1OH+XEVCMkxrUWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155797; c=relaxed/simple;
	bh=+xiYZFDM2z/uBc6tYQfqB+FJ2i/ibguxGwRTylR0CTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgsp4GWJa5hdqBWTWVr4K9WaWyG4qduzStX61d73DMmGIH0sSJsj5VH7egKQKvpphb5/eJ/eVQW+vgQdW1uz6i7nbEbDD9dnr+eV8wtSBnDCfZIZIPZjLnVhTxE91ivW6nK9oyKGwMIy2o49ZG9+iQPzS7fjdpuGYqEd87QkBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JoGgR1i4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fZVI017431;
	Fri, 21 Feb 2025 16:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=mppvm
	tBExwjVqSXhlL1cgO1sMv2taYNKWRxQFhLDs2w=; b=JoGgR1i4L28o0kKgwk964
	VWPtzToikPnIW5xr3ml3z8sTsV71nXJ6gnbv4tCrtpA7lzugPsa1aldglDVAUfSU
	lFCdwkjvyAlI8h+92eeOvB2YaPXT8CLOGN7NH4Ao2SZtjfcEnG0ye6i7LrSpyL+2
	jjKfajKrrcwqJtnVSFCRaxAp7kM1l1VVflUmudgXrCrsBfeIrkF2WxLSTKFzid72
	eYtjH2m/CiI4htI6+CGW4MaSqy/qf/jTQ3pG0YBRTT+fRFKO75Njh3x8h6p+ox4M
	HDUlIAZK5YgkhSMi7LT747q3Rh6Qg2AbtUvED8K4f/iBz0yrVbCuVoJKAZXGF2WR
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kpmwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LFex62010624;
	Fri, 21 Feb 2025 16:36:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07gxm7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:14 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LGUIXH005786;
	Fri, 21 Feb 2025 16:36:14 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44w07gxm69-4;
	Fri, 21 Feb 2025 16:36:14 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 3/6] maple_tree: use vacant nodes to reduce worst case allocations
Date: Fri, 21 Feb 2025 16:36:07 +0000
Message-ID: <20250221163610.578409-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210118
X-Proofpoint-ORIG-GUID: XiQ8wTaETKHof91B1TGOXJmkKayqD82w
X-Proofpoint-GUID: XiQ8wTaETKHof91B1TGOXJmkKayqD82w

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
 include/linux/maple_tree.h       |   2 +
 lib/maple_tree.c                 |  13 ++--
 tools/testing/radix-tree/maple.c | 102 ++++++++++++++++++++++++++++---
 3 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index cbbcd18d4186..7d777aa2d9ed 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -463,6 +463,7 @@ struct ma_wr_state {
 	void __rcu **slots;		/* mas->node->slots pointer */
 	void *entry;			/* The entry to write */
 	void *content;			/* The existing entry that is being overwritten */
+	unsigned char vacant_height;	/* Height of lowest node with free space */
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
index d7dac3119748..ef71af0529f4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3542,6 +3542,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 		if (ma_is_leaf(wr_mas->type))
 			return true;
 
+		if (mas->end < mt_slots[wr_mas->type] - 1)
+			wr_mas->vacant_height = mas->depth + 1;
+
 		mas_wr_walk_traverse(wr_mas);
 	}
 
@@ -4157,7 +4160,9 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
 static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 {
 	struct ma_state *mas = wr_mas->mas;
-	int ret = mas_mt_height(mas) * 3 + 1;
+	unsigned char height = mas_mt_height(mas);
+	int ret = height * 3 + 1;
+	unsigned char delta = height - wr_mas->vacant_height;
 
 	switch (mas->store_type) {
 	case wr_invalid:
@@ -4175,13 +4180,13 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 			ret = 0;
 		break;
 	case wr_spanning_store:
-		ret =  mas_mt_height(mas) * 3 + 1;
+		ret = height * 3 + 1;
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
index bc30050227fd..d22c1008dffe 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35475,12 +35475,85 @@ static void check_dfs_preorder(struct maple_tree *mt)
 }
 /* End of depth first search tests */
 
+/* same implementation as mas_is_span_wr() in lib/maple_tree.c */
+static bool is_span_wr(struct ma_state *mas, unsigned long r_max,
+				enum maple_type type, void *entry)
+{
+	unsigned long max = r_max;
+	unsigned long last = mas->last;
+
+	/* Contained in this pivot, fast path */
+	if (last < max)
+		return false;
+
+	if (ma_is_leaf(type)) {
+		max = mas->max;
+		if (last < max)
+			return false;
+	}
+
+	if (last == max) {
+		/*
+		 * The last entry of leaf node cannot be NULL unless it is the
+		 * rightmost node (writing ULONG_MAX), otherwise it spans slots.
+		 */
+		if (entry || last == ULONG_MAX)
+			return false;
+	}
+
+	return true;
+}
+
+/* get height of the lowest non-leaf node with free space */
+static unsigned char get_vacant_height(struct ma_state *mas, void *entry)
+{
+	char vacant_height = 0;
+	enum maple_type type;
+	unsigned long *pivots;
+	unsigned long min = 0;
+	unsigned long max = ULONG_MAX;
+
+	/* start traversal */
+	mas_reset(mas);
+	mas_start(mas);
+	if (!xa_is_node(mas_root(mas)))
+		return 0;
+
+	type = mte_node_type(mas->node);
+	while (!ma_is_leaf(type)) {
+		mas_node_walk(mas, mte_to_node(mas->node), type, &min, &max);
+		mas->end = mas_data_end(mas);
+		pivots = ma_pivots(mte_to_node(mas->node), type);
+
+		if (pivots) {
+			if (mas->offset)
+				min = pivots[mas->offset - 1];
+			if (mas->offset < mas->end)
+				max = pivots[mas->offset];
+		}
+
+		/* detect spanning write */
+		if (is_span_wr(mas, max, type, entry))
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
@@ -35494,8 +35567,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
+	vacant_height = get_vacant_height(&mas, ptr);
 	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
@@ -35503,8 +35577,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
+	vacant_height = get_vacant_height(&mas, ptr);
 	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
@@ -35514,7 +35589,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	vacant_height = get_vacant_height(&mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mn->parent = ma_parent_ptr(mn);
@@ -35527,7 +35603,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	vacant_height = get_vacant_height(&mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
@@ -35540,7 +35617,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	vacant_height = get_vacant_height(&mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mas_push_node(&mas, mn);
@@ -35553,7 +35631,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	vacant_height = get_vacant_height(&mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
@@ -35578,7 +35657,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1 + height * 2);
+	vacant_height = get_vacant_height(&mas, ptr);
+	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 2);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
@@ -35595,8 +35675,14 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
+	vacant_height = get_vacant_height(&mas, ptr);
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



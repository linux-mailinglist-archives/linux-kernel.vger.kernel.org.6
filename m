Return-Path: <linux-kernel+bounces-537288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF13A48A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B0B16912A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE427126C;
	Thu, 27 Feb 2025 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ahKBFIdD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B526A0E8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689320; cv=none; b=UmGE2eSoJupthe/WIUeRZTZUXe4VBhlYT6XWBAyJdHOMuELnEy2yRbFcTCQ8l9MJwoeFosnFQktKbh36EXLH4zYr9cd+8z0YBiho4ERszYoBKgmVzfi3kP2KB0ujWywfbHnNdal5gDAM71h77lpBYvSoiTtwNuakkH6x98DI8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689320; c=relaxed/simple;
	bh=Xxud70Inza86j1JQ9nHUEnW33K891lr2O2QEID5NVK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buLggsZy4slGp5ddquKoP638lazxmk4LR05nn8hz/pd/f8PGhrCISr6QwtzNcr+d52oJoOla8VHK5Nk1NqeDukBQ2UgbiHpHnMGvGHvxU8wFxSAA0aIoFoG9BBwglR0cJLpqjOvsGrC+kLhgMi1YsNcTKPGAtiUGXap+Zu7cMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ahKBFIdD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJiXvx016378;
	Thu, 27 Feb 2025 20:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=gOwuz
	uTOLUCNwJAMPht/sO46yRRy3GRTeMgEldjsPnU=; b=ahKBFIdDqMDUr0McX+3EF
	ZxhSy0tY5rvY2X7vdmD4Go02lQKuNCU/uVAeU63f1IJHaEXTHKIte2izLECE8bnC
	04An58Q9qRXiXxPc5sxe2TbCFjve3FSRdliNI3DK8DMX4HVhzxLQEChTXVaZAFb7
	HPBWl9hO1k2N+BjutKb/AL+tGKUNn4/1oIoH6LpGJmuCf/CyT+y+CDWP1FEs8n4u
	1Rd7Dl3R+s/LmHkxpvYC+kAgYJvKv3uYnHkX+OYff8TnFsZrGj43SVpuD2WF3qUs
	UItQ8eSBrXov9Li3LjZW21s/wAoq2bxWG8uLb1cay6MTp3uNEN6yK0WZX8/B7JhP
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psecbj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJ30w5012629;
	Thu, 27 Feb 2025 20:48:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dws1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51RKhrvg030883;
	Thu, 27 Feb 2025 20:48:30 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44y51dwrvc-3;
	Thu, 27 Feb 2025 20:48:30 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 2/6] maple_tree: use height and depth consistently
Date: Thu, 27 Feb 2025 20:48:19 +0000
Message-ID: <20250227204823.758784-3-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: l6ABSd6hzPhnG4lAK7HrR1bf2g6TVq8x
X-Proofpoint-ORIG-GUID: l6ABSd6hzPhnG4lAK7HrR1bf2g6TVq8x

For the maple tree, the root node is defined to have a depth of 0 with a
height of 1. Each level down from the node, these values are incremented
by 1. Various code paths define a root with depth 1 which is inconsisent
with the definition. Modify the code to be consistent with this
definition.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 85 ++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0410e13a099e..a37837d6f3eb 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -211,14 +211,14 @@ static void ma_free_rcu(struct maple_node *node)
 	call_rcu(&node->rcu, mt_free_rcu);
 }
 
-static void mas_set_height(struct ma_state *mas)
+static void mt_set_height(struct maple_tree *mt, unsigned char height)
 {
-	unsigned int new_flags = mas->tree->ma_flags;
+	unsigned int new_flags = mt->ma_flags;
 
 	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
-	MAS_BUG_ON(mas, mas->depth > MAPLE_HEIGHT_MAX);
-	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
-	mas->tree->ma_flags = new_flags;
+	MT_BUG_ON(mt, height > MAPLE_HEIGHT_MAX);
+	new_flags |= height << MT_FLAGS_HEIGHT_OFFSET;
+	mt->ma_flags = new_flags;
 }
 
 static unsigned int mas_mt_height(struct ma_state *mas)
@@ -1375,7 +1375,7 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
-			mas->depth = 1;
+			mas->depth = 0;
 			mas->status = ma_active;
 			mas->node = mte_safe_root(root);
 			mas->offset = 0;
@@ -1716,9 +1716,10 @@ static inline void mas_adopt_children(struct ma_state *mas,
  * node as dead.
  * @mas: the maple state with the new node
  * @old_enode: The old maple encoded node to replace.
+ * @new_height: if we are inserting a root node, update the height of the tree
  */
 static inline void mas_put_in_tree(struct ma_state *mas,
-		struct maple_enode *old_enode)
+		struct maple_enode *old_enode, char new_height)
 	__must_hold(mas->tree->ma_lock)
 {
 	unsigned char offset;
@@ -1727,7 +1728,7 @@ static inline void mas_put_in_tree(struct ma_state *mas,
 	if (mte_is_root(mas->node)) {
 		mas_mn(mas)->parent = ma_parent_ptr(mas_tree_parent(mas));
 		rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
-		mas_set_height(mas);
+		mt_set_height(mas->tree, new_height);
 	} else {
 
 		offset = mte_parent_slot(mas->node);
@@ -1745,12 +1746,13 @@ static inline void mas_put_in_tree(struct ma_state *mas,
  * the parent encoding to locate the maple node in the tree.
  * @mas: the ma_state with @mas->node pointing to the new node.
  * @old_enode: The old maple encoded node.
+ * @new_height: The new height of the tree as a result of the operation
  */
 static inline void mas_replace_node(struct ma_state *mas,
-		struct maple_enode *old_enode)
+		struct maple_enode *old_enode, unsigned char new_height)
 	__must_hold(mas->tree->ma_lock)
 {
-	mas_put_in_tree(mas, old_enode);
+	mas_put_in_tree(mas, old_enode, new_height);
 	mas_free(mas, old_enode);
 }
 
@@ -2540,10 +2542,11 @@ static inline void mas_topiary_node(struct ma_state *mas,
  *
  * @mas: The maple state pointing at the new data
  * @old_enode: The maple encoded node being replaced
+ * @new_height: The new height of the tree as a result of the operation
  *
  */
 static inline void mas_topiary_replace(struct ma_state *mas,
-		struct maple_enode *old_enode)
+		struct maple_enode *old_enode, unsigned char new_height)
 {
 	struct ma_state tmp[3], tmp_next[3];
 	MA_TOPIARY(subtrees, mas->tree);
@@ -2551,7 +2554,7 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 	int i, n;
 
 	/* Place data in tree & then mark node as old */
-	mas_put_in_tree(mas, old_enode);
+	mas_put_in_tree(mas, old_enode, new_height);
 
 	/* Update the parent pointers in the tree */
 	tmp[0] = *mas;
@@ -2635,14 +2638,15 @@ static inline void mas_topiary_replace(struct ma_state *mas,
  * mas_wmb_replace() - Write memory barrier and replace
  * @mas: The maple state
  * @old_enode: The old maple encoded node that is being replaced.
+ * @new_height: The new height of the tree as a result of the operation
  *
  * Updates gap as necessary.
  */
 static inline void mas_wmb_replace(struct ma_state *mas,
-		struct maple_enode *old_enode)
+		struct maple_enode *old_enode, unsigned char new_height)
 {
 	/* Insert the new data in the tree */
-	mas_topiary_replace(mas, old_enode);
+	mas_topiary_replace(mas, old_enode, new_height);
 
 	if (mte_is_leaf(mas->node))
 		return;
@@ -2828,6 +2832,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 {
 	unsigned char split, mid_split;
 	unsigned char slot = 0;
+	unsigned char new_height = 0; /* used if node is a new root */
 	struct maple_enode *left = NULL, *middle = NULL, *right = NULL;
 	struct maple_enode *old_enode;
 
@@ -2877,7 +2882,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 		 */
 		memset(mast->bn, 0, sizeof(struct maple_big_node));
 		mast->bn->type = mte_node_type(left);
-		l_mas.depth++;
+		new_height++;
 
 		/* Root already stored in l->node. */
 		if (mas_is_root_limits(mast->l))
@@ -2901,8 +2906,10 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 			continue;
 
 		/* May be a new root stored in mast->bn */
-		if (mas_is_root_limits(mast->orig_l))
+		if (mas_is_root_limits(mast->orig_l)) {
+			new_height++;
 			break;
+		}
 
 		mast_spanning_rebalance(mast);
 
@@ -2913,7 +2920,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 
 	l_mas.node = mt_mk_node(ma_mnode_ptr(mas_pop_node(mas)),
 				mte_node_type(mast->orig_l->node));
-	l_mas.depth++;
+
 	mab_mas_cp(mast->bn, 0, mt_slots[mast->bn->type] - 1, &l_mas, true);
 	mas_set_parent(mas, left, l_mas.node, slot);
 	if (middle)
@@ -2937,7 +2944,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 	mas->min = l_mas.min;
 	mas->max = l_mas.max;
 	mas->offset = l_mas.offset;
-	mas_wmb_replace(mas, old_enode);
+	mas_wmb_replace(mas, old_enode, new_height);
 	mtree_range_walk(mas);
 	return;
 }
@@ -3013,6 +3020,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	void __rcu **l_slots, **slots;
 	unsigned long *l_pivs, *pivs, gap;
 	bool in_rcu = mt_in_rcu(mas->tree);
+	unsigned char new_height = mas_mt_height(mas);
 
 	MA_STATE(l_mas, mas->tree, mas->index, mas->last);
 
@@ -3107,7 +3115,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	mas_ascend(mas);
 
 	if (in_rcu) {
-		mas_replace_node(mas, old_eparent);
+		mas_replace_node(mas, old_eparent, new_height);
 		mas_adopt_children(mas, mas->node);
 	}
 
@@ -3118,10 +3126,9 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
  * mas_split_final_node() - Split the final node in a subtree operation.
  * @mast: the maple subtree state
  * @mas: The maple state
- * @height: The height of the tree in case it's a new root.
  */
 static inline void mas_split_final_node(struct maple_subtree_state *mast,
-					struct ma_state *mas, int height)
+					struct ma_state *mas)
 {
 	struct maple_enode *ancestor;
 
@@ -3130,7 +3137,6 @@ static inline void mas_split_final_node(struct maple_subtree_state *mast,
 			mast->bn->type = maple_arange_64;
 		else
 			mast->bn->type = maple_range_64;
-		mas->depth = height;
 	}
 	/*
 	 * Only a single node is used here, could be root.
@@ -3218,7 +3224,6 @@ static inline void mast_split_data(struct maple_subtree_state *mast,
  * mas_push_data() - Instead of splitting a node, it is beneficial to push the
  * data to the right or left node if there is room.
  * @mas: The maple state
- * @height: The current height of the maple state
  * @mast: The maple subtree state
  * @left: Push left or not.
  *
@@ -3226,8 +3231,8 @@ static inline void mast_split_data(struct maple_subtree_state *mast,
  *
  * Return: True if pushed, false otherwise.
  */
-static inline bool mas_push_data(struct ma_state *mas, int height,
-				 struct maple_subtree_state *mast, bool left)
+static inline bool mas_push_data(struct ma_state *mas,
+				struct maple_subtree_state *mast, bool left)
 {
 	unsigned char slot_total = mast->bn->b_end;
 	unsigned char end, space, split;
@@ -3284,7 +3289,7 @@ static inline bool mas_push_data(struct ma_state *mas, int height,
 
 	mast_split_data(mast, mas, split);
 	mast_fill_bnode(mast, mas, 2);
-	mas_split_final_node(mast, mas, height + 1);
+	mas_split_final_node(mast, mas);
 	return true;
 }
 
@@ -3297,6 +3302,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 {
 	struct maple_subtree_state mast;
 	int height = 0;
+	unsigned int orig_height = mas_mt_height(mas);
 	unsigned char mid_split, split = 0;
 	struct maple_enode *old;
 
@@ -3323,7 +3329,6 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
 
 	trace_ma_op(__func__, mas);
-	mas->depth = mas_mt_height(mas);
 
 	mast.l = &l_mas;
 	mast.r = &r_mas;
@@ -3331,9 +3336,9 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	mast.orig_r = &prev_r_mas;
 	mast.bn = b_node;
 
-	while (height++ <= mas->depth) {
+	while (height++ <= orig_height) {
 		if (mt_slots[b_node->type] > b_node->b_end) {
-			mas_split_final_node(&mast, mas, height);
+			mas_split_final_node(&mast, mas);
 			break;
 		}
 
@@ -3348,11 +3353,15 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 		 * is a significant savings.
 		 */
 		/* Try to push left. */
-		if (mas_push_data(mas, height, &mast, true))
+		if (mas_push_data(mas, &mast, true)) {
+			height++;
 			break;
+		}
 		/* Try to push right. */
-		if (mas_push_data(mas, height, &mast, false))
+		if (mas_push_data(mas, &mast, false)) {
+			height++;
 			break;
+		}
 
 		split = mab_calc_split(mas, b_node, &mid_split);
 		mast_split_data(&mast, mas, split);
@@ -3369,7 +3378,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	/* Set the original node as dead */
 	old = mas->node;
 	mas->node = l_mas.node;
-	mas_wmb_replace(mas, old);
+	mas_wmb_replace(mas, old, height);
 	mtree_range_walk(mas);
 	return;
 }
@@ -3428,8 +3437,7 @@ static inline void mas_root_expand(struct ma_state *mas, void *entry)
 	if (mas->last != ULONG_MAX)
 		pivots[++slot] = ULONG_MAX;
 
-	mas->depth = 1;
-	mas_set_height(mas);
+	mt_set_height(mas->tree, 1);
 	ma_set_meta(node, maple_leaf_64, 0, slot);
 	/* swap the new root into the tree */
 	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
@@ -3673,8 +3681,7 @@ static inline void mas_new_root(struct ma_state *mas, void *entry)
 	WARN_ON_ONCE(mas->index || mas->last != ULONG_MAX);
 
 	if (!entry) {
-		mas->depth = 0;
-		mas_set_height(mas);
+		mt_set_height(mas->tree, 0);
 		rcu_assign_pointer(mas->tree->ma_root, entry);
 		mas->status = ma_start;
 		goto done;
@@ -3688,8 +3695,7 @@ static inline void mas_new_root(struct ma_state *mas, void *entry)
 	mas->status = ma_active;
 	rcu_assign_pointer(slots[0], entry);
 	pivots[0] = mas->last;
-	mas->depth = 1;
-	mas_set_height(mas);
+	mt_set_height(mas->tree, 1);
 	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
 
 done:
@@ -3808,6 +3814,7 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 	struct maple_node reuse, *newnode;
 	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
 	bool in_rcu = mt_in_rcu(mas->tree);
+	unsigned char height = mas_mt_height(mas);
 
 	if (mas->last == wr_mas->end_piv)
 		offset_end++; /* don't copy this offset */
@@ -3864,7 +3871,7 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 		struct maple_enode *old_enode = mas->node;
 
 		mas->node = mt_mk_node(newnode, wr_mas->type);
-		mas_replace_node(mas, old_enode);
+		mas_replace_node(mas, old_enode, height);
 	} else {
 		memcpy(wr_mas->node, newnode, sizeof(struct maple_node));
 	}
-- 
2.43.0



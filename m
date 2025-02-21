Return-Path: <linux-kernel+bounces-526229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40567A3FBBC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37A6189533B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE66217654;
	Fri, 21 Feb 2025 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LAKdgRLr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED742215F4F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155797; cv=none; b=dpE2yuWtvnAAI/qTSwnWFg+uhxAhnnm1Dazw3C+u95zEuOPG6UD41RWfHw9TVvBYhf8KMO0AtrdND3eSY3pdjUACdHDsM4+0p6BcE3AVMp2IucmYfwu1nYVrNjSMQ5kiiRymu48ntwIQuG7i+tk9XqHkI3XMKwIged6yBbKIXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155797; c=relaxed/simple;
	bh=PhghgN3DKbkEJhdhzO5gkgeorLXCeRZVjCPxJGbS5io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQSpSMTzInh6ORJWzZVj0jw/nwt0LTSsTsi0KfLJk9M7lhdNCcowu+cmdE/RHnlI/AStRaa2Rv5GzVjMT7lWi4cG0zwFmCOkeYse+VDiG0KHL+q5XrGxqhDUiHzUEzMNi7I9p+mRv/8nyk03UIpLO+plDnpQlHWXMepNmjHWGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LAKdgRLr; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fgYH002408;
	Fri, 21 Feb 2025 16:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=WkuiN
	F0/htL3Jy07AyGdjLbsziOaDecoGSXXo42RYFY=; b=LAKdgRLrAC/BSfmweyAhL
	ya1amcbQw3cznBRma0R/DfX92CL8ROQ6X1DGFY0ggSy2HMqBVtFlfxZeTRFCwMJZ
	N1L6RQNzUSfbAFW1D8VkvdJ8s3UzHU76xWrw12G7dwF1Yag+2+buX+y1scPYtupx
	+AiRYx+VC4ECIg8VkC5cEq0zuajx2A1zR3a57OT6BPkLLJFosSMdzkBnWtCvyUEw
	9cZs1XCcAqz1dZYzM86Dy55EGyImkFZq8u8WdP0kQsNgMtMy/xEUID1LehRw9v/q
	i6a2h6amX/RWUWFRyQS0NLuFQ9OiipbkxrpQDDUM8K0fT3OUhj6LkBDYUzjoII7k
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00m6r2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LFOUD9010486;
	Fri, 21 Feb 2025 16:36:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07gxm7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:14 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LGUIXF005786;
	Fri, 21 Feb 2025 16:36:13 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44w07gxm69-3;
	Fri, 21 Feb 2025 16:36:13 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 2/6] maple_tree: use height and depth consistently
Date: Fri, 21 Feb 2025 16:36:06 +0000
Message-ID: <20250221163610.578409-3-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: GV-IRD0oti9QoMeOwwqxiCKfSKm9TC2A
X-Proofpoint-GUID: GV-IRD0oti9QoMeOwwqxiCKfSKm9TC2A

For the maple tree, the root node is defined to have a depth of 0 with a
height of 1. Each level down from the node, these values are incremented
by 1. Various code paths define a root with depth 1 which is inconsisent
with the definition. Modify the code to be consistent with this
definition.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 85 +++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0410e13a099e..d7dac3119748 100644
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
@@ -1747,10 +1748,10 @@ static inline void mas_put_in_tree(struct ma_state *mas,
  * @old_enode: The old maple encoded node.
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
 
@@ -2543,7 +2544,7 @@ static inline void mas_topiary_node(struct ma_state *mas,
  *
  */
 static inline void mas_topiary_replace(struct ma_state *mas,
-		struct maple_enode *old_enode)
+		struct maple_enode *old_enode, unsigned char new_height)
 {
 	struct ma_state tmp[3], tmp_next[3];
 	MA_TOPIARY(subtrees, mas->tree);
@@ -2551,7 +2552,7 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 	int i, n;
 
 	/* Place data in tree & then mark node as old */
-	mas_put_in_tree(mas, old_enode);
+	mas_put_in_tree(mas, old_enode, new_height);
 
 	/* Update the parent pointers in the tree */
 	tmp[0] = *mas;
@@ -2639,10 +2640,10 @@ static inline void mas_topiary_replace(struct ma_state *mas,
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
@@ -2828,6 +2829,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 {
 	unsigned char split, mid_split;
 	unsigned char slot = 0;
+	unsigned char new_height = 0; /* used if node is a new root */
 	struct maple_enode *left = NULL, *middle = NULL, *right = NULL;
 	struct maple_enode *old_enode;
 
@@ -2877,7 +2879,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 		 */
 		memset(mast->bn, 0, sizeof(struct maple_big_node));
 		mast->bn->type = mte_node_type(left);
-		l_mas.depth++;
+		new_height++;
 
 		/* Root already stored in l->node. */
 		if (mas_is_root_limits(mast->l))
@@ -2901,8 +2903,10 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 			continue;
 
 		/* May be a new root stored in mast->bn */
-		if (mas_is_root_limits(mast->orig_l))
+		if (mas_is_root_limits(mast->orig_l)) {
+			new_height++;
 			break;
+		}
 
 		mast_spanning_rebalance(mast);
 
@@ -2913,7 +2917,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 
 	l_mas.node = mt_mk_node(ma_mnode_ptr(mas_pop_node(mas)),
 				mte_node_type(mast->orig_l->node));
-	l_mas.depth++;
+
 	mab_mas_cp(mast->bn, 0, mt_slots[mast->bn->type] - 1, &l_mas, true);
 	mas_set_parent(mas, left, l_mas.node, slot);
 	if (middle)
@@ -2937,7 +2941,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 	mas->min = l_mas.min;
 	mas->max = l_mas.max;
 	mas->offset = l_mas.offset;
-	mas_wmb_replace(mas, old_enode);
+	mas_wmb_replace(mas, old_enode, new_height);
 	mtree_range_walk(mas);
 	return;
 }
@@ -3013,6 +3017,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	void __rcu **l_slots, **slots;
 	unsigned long *l_pivs, *pivs, gap;
 	bool in_rcu = mt_in_rcu(mas->tree);
+	unsigned char new_height = mas_mt_height(mas);
 
 	MA_STATE(l_mas, mas->tree, mas->index, mas->last);
 
@@ -3107,7 +3112,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	mas_ascend(mas);
 
 	if (in_rcu) {
-		mas_replace_node(mas, old_eparent);
+		mas_replace_node(mas, old_eparent, new_height);
 		mas_adopt_children(mas, mas->node);
 	}
 
@@ -3118,10 +3123,9 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
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
 
@@ -3130,7 +3134,6 @@ static inline void mas_split_final_node(struct maple_subtree_state *mast,
 			mast->bn->type = maple_arange_64;
 		else
 			mast->bn->type = maple_range_64;
-		mas->depth = height;
 	}
 	/*
 	 * Only a single node is used here, could be root.
@@ -3153,8 +3156,7 @@ static inline void mas_split_final_node(struct maple_subtree_state *mast,
  * @skip: The number of entries to skip for new nodes insertion.
  */
 static inline void mast_fill_bnode(struct maple_subtree_state *mast,
-					 struct ma_state *mas,
-					 unsigned char skip)
+					 struct ma_state *mas, unsigned char skip, int *height)
 {
 	bool cp = true;
 	unsigned char split;
@@ -3226,7 +3228,7 @@ static inline void mast_split_data(struct maple_subtree_state *mast,
  *
  * Return: True if pushed, false otherwise.
  */
-static inline bool mas_push_data(struct ma_state *mas, int height,
+static inline bool mas_push_data(struct ma_state *mas, int *height,
 				 struct maple_subtree_state *mast, bool left)
 {
 	unsigned char slot_total = mast->bn->b_end;
@@ -3283,8 +3285,8 @@ static inline bool mas_push_data(struct ma_state *mas, int height,
 		mast->orig_l->offset += end + 1;
 
 	mast_split_data(mast, mas, split);
-	mast_fill_bnode(mast, mas, 2);
-	mas_split_final_node(mast, mas, height + 1);
+	mast_fill_bnode(mast, mas, 2, height);
+	mas_split_final_node(mast, mas);
 	return true;
 }
 
@@ -3297,6 +3299,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 {
 	struct maple_subtree_state mast;
 	int height = 0;
+	unsigned int orig_height = mas_mt_height(mas);
 	unsigned char mid_split, split = 0;
 	struct maple_enode *old;
 
@@ -3323,7 +3326,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
 
 	trace_ma_op(__func__, mas);
-	mas->depth = mas_mt_height(mas);
+	mas->depth = orig_height;
 
 	mast.l = &l_mas;
 	mast.r = &r_mas;
@@ -3333,7 +3336,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 
 	while (height++ <= mas->depth) {
 		if (mt_slots[b_node->type] > b_node->b_end) {
-			mas_split_final_node(&mast, mas, height);
+			mas_split_final_node(&mast, mas);
 			break;
 		}
 
@@ -3348,11 +3351,15 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 		 * is a significant savings.
 		 */
 		/* Try to push left. */
-		if (mas_push_data(mas, height, &mast, true))
+		if (mas_push_data(mas, &height, &mast, true)) {
+			height++;
 			break;
+		}
 		/* Try to push right. */
-		if (mas_push_data(mas, height, &mast, false))
+		if (mas_push_data(mas, &height, &mast, false)) {
+			height++;
 			break;
+		}
 
 		split = mab_calc_split(mas, b_node, &mid_split);
 		mast_split_data(&mast, mas, split);
@@ -3361,7 +3368,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 		 * r->max.
 		 */
 		mast.r->max = mas->max;
-		mast_fill_bnode(&mast, mas, 1);
+		mast_fill_bnode(&mast, mas, 1, &height);
 		prev_l_mas = *mast.l;
 		prev_r_mas = *mast.r;
 	}
@@ -3369,7 +3376,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	/* Set the original node as dead */
 	old = mas->node;
 	mas->node = l_mas.node;
-	mas_wmb_replace(mas, old);
+	mas_wmb_replace(mas, old, height);
 	mtree_range_walk(mas);
 	return;
 }
@@ -3428,8 +3435,7 @@ static inline void mas_root_expand(struct ma_state *mas, void *entry)
 	if (mas->last != ULONG_MAX)
 		pivots[++slot] = ULONG_MAX;
 
-	mas->depth = 1;
-	mas_set_height(mas);
+	mt_set_height(mas->tree, 1);
 	ma_set_meta(node, maple_leaf_64, 0, slot);
 	/* swap the new root into the tree */
 	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
@@ -3673,8 +3679,7 @@ static inline void mas_new_root(struct ma_state *mas, void *entry)
 	WARN_ON_ONCE(mas->index || mas->last != ULONG_MAX);
 
 	if (!entry) {
-		mas->depth = 0;
-		mas_set_height(mas);
+		mt_set_height(mas->tree, 0);
 		rcu_assign_pointer(mas->tree->ma_root, entry);
 		mas->status = ma_start;
 		goto done;
@@ -3688,8 +3693,7 @@ static inline void mas_new_root(struct ma_state *mas, void *entry)
 	mas->status = ma_active;
 	rcu_assign_pointer(slots[0], entry);
 	pivots[0] = mas->last;
-	mas->depth = 1;
-	mas_set_height(mas);
+	mt_set_height(mas->tree, 1);
 	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
 
 done:
@@ -3808,6 +3812,7 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 	struct maple_node reuse, *newnode;
 	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
 	bool in_rcu = mt_in_rcu(mas->tree);
+	unsigned char height = mas_mt_height(mas);
 
 	if (mas->last == wr_mas->end_piv)
 		offset_end++; /* don't copy this offset */
@@ -3864,7 +3869,7 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 		struct maple_enode *old_enode = mas->node;
 
 		mas->node = mt_mk_node(newnode, wr_mas->type);
-		mas_replace_node(mas, old_enode);
+		mas_replace_node(mas, old_enode, height);
 	} else {
 		memcpy(wr_mas->node, newnode, sizeof(struct maple_node));
 	}
-- 
2.43.0



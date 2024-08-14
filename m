Return-Path: <linux-kernel+bounces-286855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00296951FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8197F1F23967
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B6C1BBBEA;
	Wed, 14 Aug 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nZBIKsmq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446A1B9B28
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652415; cv=none; b=u70R9myoFLJm+UKZ1WGDS8ij00Y/vRx+ffqDOSdkhA61PS2Sx0cv2wC96vXWjsA43EHsBcXdmSH5swADximN0YCBDcB7mcLaeqmL0zQfsWsoSwNY3KdtzFwczV+nvrlYT7ukTjgU+MpZKYvXxV2Xo89zhm1ydndF2QlwGGooock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652415; c=relaxed/simple;
	bh=Yam73ovSl+OyClzN1WENJH+xQhwVYgNhxt2cyTaTdLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4bzwPi0QcRh/7DkuLOO5Q2bR0fVenblLUbcOhJckdX1JfDaM/8+8WWurKxWNqCL5kICqtVOL7lGvMR6phTonEjXufBAdhgJfb2cByBSVQ75TJ7+gIvpkIZ/Nb5c21fR5f+vKvVeMPUFlrqFMsOnZjXtvSlU1hV31PnpswjzFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nZBIKsmq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtZ2p028354;
	Wed, 14 Aug 2024 16:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=z
	Oe6rYReOJ9R8LQkfQkW5rBoXsJ7vwbdrjrfz4Pketk=; b=nZBIKsmq3qfVDaDOR
	NFFfs0Q1jRlhfa5GlaKoXfrdhdqeTn+TY3tZzmF2j5K5d6uungZgFxi6qMHhAMmQ
	RiKNhom+4tcnMagmGVicBeo30y8Fb7A1ldRREU8N2Y8ECVkHlYxn3ACEy+QYZ4yD
	u+fja3wHjXel0jgu37GTyaYjVQj/DOPVqp10MEawmBRZ7Z6H0DjfndUEm2Tv4CwB
	MLZzaEjFXpd8l1qt2aE3pGlBysVMoCA9AdaRD00hsm0Epqqa/2IpmL3vMbJorien
	xvwlLcqBzQfVgqyXYYsjOqtGEAmV+jdnzXtx2iKR+4VxGEerEa2jE/Zp5ZSKzAcw
	9zwZQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt10shw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFqAgH021061;
	Wed, 14 Aug 2024 16:19:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvC4035951;
	Wed, 14 Aug 2024 16:19:51 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-5;
	Wed, 14 Aug 2024 16:19:51 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 04/17] maple_tree: introduce mas_wr_store_type()
Date: Wed, 14 Aug 2024 12:19:31 -0400
Message-ID: <20240814161944.55347-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_12,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140111
X-Proofpoint-GUID: 2sRgIeRR8qHOa4oJ-mYnfXbiem0eaLIF
X-Proofpoint-ORIG-GUID: 2sRgIeRR8qHOa4oJ-mYnfXbiem0eaLIF

Introduce mas_wr_store_type() which will set the correct store type
based on a walk of the tree. In mas_wr_node_store() the <= min_slots
condition is changed to < as if new_end is = to mt_min_slots then there
is not enough room.

mas_prealloc_calc() is also introduced to abstract the calculation used
to determine the number of nodes needed for a store operation.

In this change a call to mas_reset() is removed in the error case of
mas_prealloc(). This is only needed in the MA_STATE_REBALANCE case of
mas_destroy(). We can move the call to mas_reset() directly to
mas_destroy().

Also, add a test case to validate the order that we check the store type
in is correct. This test models a vma expanding and then shrinking which
is part of the boot process.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c                 | 217 ++++++++++++++++++++++---------
 tools/testing/radix-tree/maple.c |  36 +++++
 2 files changed, 193 insertions(+), 60 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index de4a91ced8ca..d0b9b3795b96 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1372,9 +1372,9 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 			return NULL;
 		}
 
+		mas->node = NULL;
 		/* empty tree */
 		if (unlikely(!root)) {
-			mas->node = NULL;
 			mas->status = ma_none;
 			mas->offset = MAPLE_NODE_SLOTS;
 			return NULL;
@@ -3890,7 +3890,7 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 	bool in_rcu = mt_in_rcu(mas->tree);
 
 	/* Check if there is enough data. The room is enough. */
-	if (!mte_is_root(mas->node) && (new_end <= mt_min_slots[wr_mas->type]) &&
+	if (!mte_is_root(mas->node) && (new_end < mt_min_slots[wr_mas->type]) &&
 	    !(mas->mas_flags & MA_STATE_BULK))
 		return false;
 
@@ -4275,6 +4275,146 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
 	wr_mas->content = mas_start(mas);
 }
 
+/**
+ * mas_prealloc_calc() - Calculate number of nodes needed for a
+ * given store oepration
+ * @mas: The maple state
+ * @entry: The entry to store into the tree
+ *
+ * Return: Number of nodes required for preallocation.
+ */
+static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
+{
+	int ret = mas_mt_height(mas) * 3 + 1;
+
+	switch (mas->store_type) {
+	case wr_invalid:
+		WARN_ON_ONCE(1);
+		break;
+	case wr_new_root:
+		ret = 1;
+		break;
+	case wr_store_root:
+		if (likely((mas->last != 0) || (mas->index != 0)))
+			ret = 1;
+		else if (((unsigned long) (entry) & 3) == 2)
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case wr_spanning_store:
+		ret =  mas_mt_height(mas) * 3 + 1;
+		break;
+	case wr_split_store:
+		ret =  mas_mt_height(mas) * 2 + 1;
+		break;
+	case wr_rebalance:
+		ret =  mas_mt_height(mas) * 2 - 1;
+		break;
+	case wr_node_store:
+		ret = mt_in_rcu(mas->tree) ? 1 : 0;
+		break;
+	case wr_append:
+	case wr_exact_fit:
+	case wr_slot_store:
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * mas_wr_store_type() - Set the store type for a given
+ * store operation.
+ * @wr_mas: The maple write state
+ */
+static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end;
+
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
+		mas->store_type = wr_store_root;
+		return;
+	}
+
+	if (unlikely(!mas_wr_walk(wr_mas))) {
+		mas->store_type = wr_spanning_store;
+		return;
+	}
+
+	/* At this point, we are at the leaf node that needs to be altered. */
+	mas_wr_end_piv(wr_mas);
+	if (!wr_mas->entry)
+		mas_wr_extend_null(wr_mas);
+
+	new_end = mas_wr_new_end(wr_mas);
+	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last)) {
+		mas->store_type = wr_exact_fit;
+		return;
+	}
+
+	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
+		mas->store_type = wr_new_root;
+		return;
+	}
+
+	/* Potential spanning rebalance collapsing a node */
+	if (new_end < mt_min_slots[wr_mas->type]) {
+		if (!mte_is_root(mas->node)) {
+			mas->store_type = wr_rebalance;
+			return;
+		}
+		mas->store_type = wr_node_store;
+		return;
+	}
+
+	if (new_end >= mt_slots[wr_mas->type]) {
+		mas->store_type = wr_split_store;
+		return;
+	}
+
+	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
+		mas->store_type = wr_append;
+		return;
+	}
+
+	if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
+		(wr_mas->offset_end - mas->offset == 1))) {
+		mas->store_type = wr_slot_store;
+		return;
+	}
+
+	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
+		(mas->mas_flags & MA_STATE_BULK)) {
+		mas->store_type = wr_node_store;
+		return;
+	}
+
+	mas->store_type = wr_invalid;
+	MAS_WARN_ON(mas, 1);
+}
+
+/**
+ * mas_wr_preallocate() - Preallocate enough nodes for a store operation
+ * @wr_mas: The maple write state
+ * @entry: The entry that will be stored
+ *
+ */
+static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry)
+{
+	struct ma_state *mas = wr_mas->mas;
+	int request;
+
+	mas_wr_prealloc_setup(wr_mas);
+	mas_wr_store_type(wr_mas);
+	request = mas_prealloc_calc(mas, entry);
+	if (!request)
+		return;
+
+	mas_node_count(mas, request);
+}
+
 /**
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
@@ -5508,69 +5648,25 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
-	unsigned char node_size;
-	int request = 1;
-	int ret;
-
-
-	if (unlikely(!mas->index && mas->last == ULONG_MAX))
-		goto ask_now;
+	int ret = 0;
+	int request;
 
 	mas_wr_prealloc_setup(&wr_mas);
-	/* Root expand */
-	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
-		goto ask_now;
-
-	if (unlikely(!mas_wr_walk(&wr_mas))) {
-		/* Spanning store, use worst case for now */
-		request = 1 + mas_mt_height(mas) * 3;
-		goto ask_now;
-	}
-
-	/* At this point, we are at the leaf node that needs to be altered. */
-	/* Exact fit, no nodes needed. */
-	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
-		return 0;
-
-	mas_wr_end_piv(&wr_mas);
-	node_size = mas_wr_new_end(&wr_mas);
-
-	/* Slot store, does not require additional nodes */
-	if (node_size == mas->end) {
-		/* reuse node */
-		if (!mt_in_rcu(mas->tree))
-			return 0;
-		/* shifting boundary */
-		if (wr_mas.offset_end - mas->offset == 1)
-			return 0;
-	}
+	mas_wr_store_type(&wr_mas);
+	request = mas_prealloc_calc(mas, entry);
+	if (!request)
+		return ret;
 
-	if (node_size >= mt_slots[wr_mas.type]) {
-		/* Split, worst case for now. */
-		request = 1 + mas_mt_height(mas) * 2;
-		goto ask_now;
+	mas_node_count_gfp(mas, request, gfp);
+	if (mas_is_err(mas)) {
+		mas_set_alloc_req(mas, 0);
+		ret = xa_err(mas->node);
+		mas_destroy(mas);
+		mas_reset(mas);
+		return ret;
 	}
 
-	/* New root needs a single node */
-	if (unlikely(mte_is_root(mas->node)))
-		goto ask_now;
-
-	/* Potential spanning rebalance collapsing a node, use worst-case */
-	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
-		request = mas_mt_height(mas) * 2 - 1;
-
-	/* node store, slot store needs one node */
-ask_now:
-	mas_node_count_gfp(mas, request, gfp);
 	mas->mas_flags |= MA_STATE_PREALLOC;
-	if (likely(!mas_is_err(mas)))
-		return 0;
-
-	mas_set_alloc_req(mas, 0);
-	ret = xa_err(mas->node);
-	mas_reset(mas);
-	mas_destroy(mas);
-	mas_reset(mas);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mas_preallocate);
@@ -5596,7 +5692,8 @@ void mas_destroy(struct ma_state *mas)
 	 */
 	if (mas->mas_flags & MA_STATE_REBALANCE) {
 		unsigned char end;
-
+		if (mas_is_err(mas))
+			mas_reset(mas);
 		mas_start(mas);
 		mtree_range_walk(mas);
 		end = mas->end + 1;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index ef5b83cf94ea..ad42a36231fb 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36283,6 +36283,38 @@ static void check_nomem_writer_race(struct maple_tree *mt)
 	mtree_unlock(mt);
 }
 
+ /* test to simulate expanding a vma from [0x7fffffffe000, 0x7ffffffff000)
+  * to [0x7ffde4ca1000, 0x7ffffffff000) and then shrinking the vma to
+  * [0x7ffde4ca1000, 0x7ffde4ca2000)
+  */
+static inline int check_vma_modification(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 0);
+
+	mtree_lock(mt);
+	/* vma with old start and old end */
+	__mas_set_range(&mas, 0x7fffffffe000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
+	mas_store_prealloc(&mas, xa_mk_value(1));
+
+	/* next write occurs partly in previous range [0, 0x7fffffffe000)*/
+	mas_prev_range(&mas, 0);
+	/* expand vma to {0x7ffde4ca1000, 0x7ffffffff000) */
+	__mas_set_range(&mas, 0x7ffde4ca1000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
+	mas_store_prealloc(&mas, xa_mk_value(1));
+
+	/* shrink vma to [0x7ffde4ca1000, 7ffde4ca2000) */
+	__mas_set_range(&mas, 0x7ffde4ca2000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, NULL, GFP_KERNEL);
+	mas_store_prealloc(&mas, NULL);
+	mt_dump(mt, mt_dump_hex);
+
+	mas_destroy(&mas);
+	mtree_unlock(mt);
+	return 0;
+}
+
 void farmer_tests(void)
 {
 	struct maple_node *node;
@@ -36290,6 +36322,10 @@ void farmer_tests(void)
 
 	mt_dump(&tree, mt_dump_dec);
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | MT_FLAGS_USE_RCU);
+	check_vma_modification(&tree);
+	mtree_destroy(&tree);
+
 	tree.ma_root = xa_mk_value(0);
 	mt_dump(&tree, mt_dump_dec);
 
-- 
2.46.0



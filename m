Return-Path: <linux-kernel+bounces-409718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDC79C9080
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614862831C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EC18FDAC;
	Thu, 14 Nov 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z1GCbDs1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1C191466
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603949; cv=none; b=kyi0u4NwUqhukVyZ22eHbTpqbf/5YaXRNzm9Q2vSkphOZ5CferZy/hq0lfka2aSH9X0om6Ovk9SWCKmcnc+Gs2TgSimGntEGxVXXokvXGe2akoBa5AQq+Xy0/RlveTjXvBlipyvx8mf1dDSUn1+dS+KCYtOEQbuLiyCmJ6h67dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603949; c=relaxed/simple;
	bh=aiSQGLZdsShs18zs/5u0wpRsw4lzli0lMRikfWavT78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbx/USbBD2a7dr9i2eZzUXlqFRjeWRbatbtPReW5go96TuU2M4HXIOfOrNZeTXox0kGFycHOFcJSMipdNQDH40dZ7hebCcQ/WDlTZy25JlGOf0MYMT55xxsBdI+ZxiTTNGjXPqB0i4TlE3V4S4cRb4WJ/xBcuhkvVNbUMwGwmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z1GCbDs1; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECXUrQ006704;
	Thu, 14 Nov 2024 17:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=DRxKY
	AZcCAMW15klVCiRiGLQ4sjCSB7uPPfv42IObWU=; b=Z1GCbDs1t6Vnl15y76+He
	YuuuRLWsnt6ujrK8hIL0wKm6QgjMSzD6h7Tjgc1Xm7khuxNP+Hgjayvnbjt8xKnU
	DxFL/DSVy9o5tug+xlQ9747gU6GyPoTnz20jD062hvdhwd3rASi+9JS3sbhJmPMT
	UvIJ8pnD/Azc0C+zp0CMhjozcMPgY4RLb/dhMZkRG4nj5tK4y0dy/hexXmcY4VD0
	4WDFWvEEgHkU0R4NfJ1MMhzmAas7WkucuXgxfEgjTu6n8ouz8unaoGARYjd6tcUv
	CUPHMFKg6WA4SDhfolG/ZWrnQcfr7mId9fiDCROu6av6cPGOdFyBHNDY800JbZ2o
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwsr6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEGGpAX022744;
	Thu, 14 Nov 2024 17:05:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1jy83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:29 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEH5QmL032739;
	Thu, 14 Nov 2024 17:05:28 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-39-201-66.vpn.oracle.com [10.39.201.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42vuw1jy5w-3;
	Thu, 14 Nov 2024 17:05:28 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/5] maple_tree: use height and depth consistently
Date: Thu, 14 Nov 2024 12:05:21 -0500
Message-ID: <20241114170524.64391-3-sidhartha.kumar@oracle.com>
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
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=975 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140134
X-Proofpoint-GUID: 7jgAwCWQElIyqGhjSvDnTmTu9MQckSbD
X-Proofpoint-ORIG-GUID: 7jgAwCWQElIyqGhjSvDnTmTu9MQckSbD

For the maple tree, the root node is defined to have a depth of 0 with a
height of 1. Each level down from the node, these values are incremented
by 1. Various code paths define a root with depth 1 which is inconsisent
with the definition. Modify the code to be consistent with this
definition.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 318d496debd7..21289e350382 100644
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
@@ -1375,7 +1375,6 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
-			mas->depth = 1;
 			mas->status = ma_active;
 			mas->node = mte_safe_root(root);
 			mas->offset = 0;
@@ -1727,7 +1726,7 @@ static inline void mas_put_in_tree(struct ma_state *mas,
 	if (mte_is_root(mas->node)) {
 		mas_mn(mas)->parent = ma_parent_ptr(mas_tree_parent(mas));
 		rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
-		mas_set_height(mas);
+		mt_set_height(mas->tree, mas->depth + 1);
 	} else {
 
 		offset = mte_parent_slot(mas->node);
@@ -2888,12 +2887,12 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 		 */
 		memset(mast->bn, 0, sizeof(struct maple_big_node));
 		mast->bn->type = mte_node_type(left);
-		l_mas.depth++;
 
 		/* Root already stored in l->node. */
 		if (mas_is_root_limits(mast->l))
 			goto new_root;
 
+		l_mas.depth++;
 		mast_ascend(mast);
 		mast_combine_cp_left(mast);
 		l_mas.offset = mast->bn->b_end;
@@ -3141,7 +3140,7 @@ static inline void mas_split_final_node(struct maple_subtree_state *mast,
 			mast->bn->type = maple_arange_64;
 		else
 			mast->bn->type = maple_range_64;
-		mas->depth = height;
+		mas->depth = height - 1;
 	}
 	/*
 	 * Only a single node is used here, could be root.
@@ -3308,6 +3307,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 {
 	struct maple_subtree_state mast;
 	int height = 0;
+	unsigned int orig_height = mas_mt_height(mas);
 	unsigned char mid_split, split = 0;
 	struct maple_enode *old;
 
@@ -3334,7 +3334,6 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
 
 	trace_ma_op(__func__, mas);
-	mas->depth = mas_mt_height(mas);
 
 	mast.l = &l_mas;
 	mast.r = &r_mas;
@@ -3342,7 +3341,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	mast.orig_r = &prev_r_mas;
 	mast.bn = b_node;
 
-	while (height++ <= mas->depth) {
+	while (height++ <= orig_height) {
 		if (mt_slots[b_node->type] > b_node->b_end) {
 			mas_split_final_node(&mast, mas, height);
 			break;
@@ -3439,8 +3438,7 @@ static inline void mas_root_expand(struct ma_state *mas, void *entry)
 	if (mas->last != ULONG_MAX)
 		pivots[++slot] = ULONG_MAX;
 
-	mas->depth = 1;
-	mas_set_height(mas);
+	mt_set_height(mas->tree, 1);
 	ma_set_meta(node, maple_leaf_64, 0, slot);
 	/* swap the new root into the tree */
 	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
@@ -3684,8 +3682,7 @@ static inline void mas_new_root(struct ma_state *mas, void *entry)
 	WARN_ON_ONCE(mas->index || mas->last != ULONG_MAX);
 
 	if (!entry) {
-		mas->depth = 0;
-		mas_set_height(mas);
+		mt_set_height(mas->tree, 0);
 		rcu_assign_pointer(mas->tree->ma_root, entry);
 		mas->status = ma_start;
 		goto done;
@@ -3699,8 +3696,7 @@ static inline void mas_new_root(struct ma_state *mas, void *entry)
 	mas->status = ma_active;
 	rcu_assign_pointer(slots[0], entry);
 	pivots[0] = mas->last;
-	mas->depth = 1;
-	mas_set_height(mas);
+	mt_set_height(mas->tree, 1);
 	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
 
 done:
-- 
2.43.0



Return-Path: <linux-kernel+bounces-286851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00339951FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774251F21F34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821A1B9B35;
	Wed, 14 Aug 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7lxwfgN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD41B86C5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652412; cv=none; b=tld7HLAukHmZWXmomGM8z7izS4P36PUMbiLN9GuWgp5jncDmJ0bsoIucC+s6D5+QeTTGlM0FEWApza3tQn8Nx393h823ka9ECqyQPYxPMrSGhXsYXNXiSkOLwRObd/D2W0Zt8j62BfvzghD8jedYGROqwx+QGYtZ5T2pfyTW740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652412; c=relaxed/simple;
	bh=V6a39l3Ageekj4yS2kT4Inux7w8JrV8KSrRV1rzJbIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzgHSoc5+2b5md2mdkHeCelP0Bi7gOtt7hTuVo57enMQ4KLJAo1wdMYEWll3PWzf1Kum26vSkw/YZAdkG4Pvka6W8+qhwvJVu4/rV2Pdf9CGlcYq/UMQRubjWC9LRQ9dWsm1kiF8DjyBbdZi82+NwAp4BR/QmgjY9SO92NTsxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a7lxwfgN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtZhl007009;
	Wed, 14 Aug 2024 16:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=F
	HexjyU3Q15ZZbT4MhKAGdpth4Y64xmG6/MK3RLc4O0=; b=a7lxwfgNnDjsTO2gi
	IiCC/TcYUHc2YOJ8zWsjMKJ1A1iFYEW093yfx7NmkTpBz5e2G2lDRGZK8eeMktnb
	OXw4iDwouF/aigblf0/WQJL2V+A/RKYBbUPqx13+QbOt4p/jgM195LagvFNWdUOt
	DP1QH6KooEKv7ghiTtoiN4rEUEAuoSwES2aj0u4XLFVY9mrHjKOtQiSjXEKMy/C7
	+u3E5ZGK7mopLYbYnLgp5gCTWi0JPacZTIcPhijjfXExtZjRBMMwDtRIqNmjj3wZ
	ZfcYN0lkH0QsQ8EFepGI4Ew3TyuCQwgvOkjrCuieVrWTsg2nxKtIngsekmmOod2a
	HR7uQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0398m0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:20:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EGJ2Cv021157;
	Wed, 14 Aug 2024 16:20:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:20:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCU035951;
	Wed, 14 Aug 2024 16:20:00 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-18;
	Wed, 14 Aug 2024 16:20:00 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 17/17] maple_tree: make write helper functions void
Date: Wed, 14 Aug 2024 12:19:44 -0400
Message-ID: <20240814161944.55347-18-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: l7t_v_9i3qSLTKN8Pp53EdLjA9dyzh5O
X-Proofpoint-GUID: l7t_v_9i3qSLTKN8Pp53EdLjA9dyzh5O

The return value of various write helper functions are not checked. We
can safely change the return type of these functions to be void.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 73ce63d9c3a0..755ba8b18e14 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2823,10 +2823,8 @@ static inline void *mtree_range_walk(struct ma_state *mas)
  * orig_l_mas->last is used in mas_consume to find the slots that will need to
  * be either freed or destroyed.  orig_l_mas->depth keeps track of the height of
  * the new sub-tree in case the sub-tree becomes the full tree.
- *
- * Return: the number of elements in b_node during the last loop.
  */
-static int mas_spanning_rebalance(struct ma_state *mas,
+static void mas_spanning_rebalance(struct ma_state *mas,
 		struct maple_subtree_state *mast, unsigned char count)
 {
 	unsigned char split, mid_split;
@@ -2942,7 +2940,7 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 	mas->offset = l_mas.offset;
 	mas_wmb_replace(mas, old_enode);
 	mtree_range_walk(mas);
-	return mast->bn->b_end;
+	return;
 }
 
 /*
@@ -2952,10 +2950,8 @@ static int mas_spanning_rebalance(struct ma_state *mas,
  *
  * Rebalance two nodes into a single node or two new nodes that are sufficient.
  * Continue upwards until tree is sufficient.
- *
- * Return: the number of elements in b_node during the last loop.
  */
-static inline int mas_rebalance(struct ma_state *mas,
+static inline void mas_rebalance(struct ma_state *mas,
 				struct maple_big_node *b_node)
 {
 	char empty_count = mas_mt_height(mas);
@@ -3300,9 +3296,8 @@ static inline bool mas_push_data(struct ma_state *mas, int height,
  * mas_split() - Split data that is too big for one node into two.
  * @mas: The maple state
  * @b_node: The maple big node
- * Return: 1 on success, 0 on failure.
  */
-static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
+static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 {
 	struct maple_subtree_state mast;
 	int height = 0;
@@ -3380,7 +3375,7 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	mas->node = l_mas.node;
 	mas_wmb_replace(mas, old);
 	mtree_range_walk(mas);
-	return 1;
+	return;
 }
 
 /*
@@ -3388,7 +3383,7 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
  * @wr_mas: The maple write state
  * @b_node: The maple big node
  */
-static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
+static noinline_for_kasan void mas_commit_b_node(struct ma_wr_state *wr_mas,
 			    struct maple_big_node *b_node)
 {
 	enum store_type type = wr_mas->mas->store_type;
@@ -3664,10 +3659,8 @@ static void mte_destroy_walk(struct maple_enode *, struct maple_tree *);
  * @entry: The entry to store.
  *
  * Only valid when the index == 0 and the last == ULONG_MAX
- *
- * Return 0 on error, 1 on success.
  */
-static inline int mas_new_root(struct ma_state *mas, void *entry)
+static inline void mas_new_root(struct ma_state *mas, void *entry)
 {
 	struct maple_enode *root = mas_root_locked(mas);
 	enum maple_type type = maple_leaf_64;
@@ -3699,7 +3692,7 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 	if (xa_is_node(root))
 		mte_destroy_walk(root, mas->tree);
 
-	return 1;
+	return;
 }
 /*
  * mas_wr_spanning_store() - Create a subtree with the store operation completed
@@ -3707,10 +3700,8 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
  * Note that mas is expected to point to the node which caused the store to
  * span.
  * @wr_mas: The maple write state
- *
- * Return: 0 on error, positive on success.
  */
-static noinline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
+static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 {
 	struct maple_subtree_state mast;
 	struct maple_big_node b_node;
@@ -3802,10 +3793,8 @@ static noinline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
  * @wr_mas: The maple write state
  *
  * Attempts to reuse the node, but may allocate.
- *
- * Return: True if stored, false otherwise
  */
-static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
+static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 				     unsigned char new_end)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -3878,16 +3867,14 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 	trace_ma_write(__func__, mas, 0, wr_mas->entry);
 	mas_update_gap(mas);
 	mas->end = new_end;
-	return true;
+	return;
 }
 
 /*
  * mas_wr_slot_store: Attempt to store a value in a slot.
  * @wr_mas: the maple write state
- *
- * Return: True if stored, false otherwise
  */
-static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
+static inline void mas_wr_slot_store(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char offset = mas->offset;
@@ -3919,7 +3906,7 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 		wr_mas->pivots[offset + 1] = mas->last;
 		mas->offset++; /* Keep mas accurate. */
 	} else {
-		return false;
+		return;
 	}
 
 	trace_ma_write(__func__, mas, 0, wr_mas->entry);
@@ -3930,7 +3917,7 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 	if (!wr_mas->entry || gap)
 		mas_update_gap(mas);
 
-	return true;
+	return;
 }
 
 static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
@@ -4004,10 +3991,8 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
  * This is currently unsafe in rcu mode since the end of the node may be cached
  * by readers while the node contents may be updated which could result in
  * inaccurate information.
- *
- * Return: True if appended, false otherwise
  */
-static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
+static inline void mas_wr_append(struct ma_wr_state *wr_mas,
 		unsigned char new_end)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -4046,7 +4031,7 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 
 	mas->end = new_end;
 	trace_ma_write(__func__, mas, new_end, wr_mas->entry);
-	return  true;
+	return;
 }
 
 /*
-- 
2.46.0



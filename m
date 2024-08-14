Return-Path: <linux-kernel+bounces-286857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE60951FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22001C215AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA741BC9E9;
	Wed, 14 Aug 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UOpT1u7X"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B371BA896
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652417; cv=none; b=WdjVqnkKB3yFgDmMNX+XyYetzG/43WpxCjnNSBvd4ht9NOmEP3kADe4iiHKOcH7FiA0kuMXThL0QDoiVbp3IxXwMYR/okrc/mXzZsa2VQhtnNTuXRPDZdotTMnY4rzpKHNwy5hzEwV46T7g8LhOWkfbRQwGnJvXAxeh2ENb57RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652417; c=relaxed/simple;
	bh=qD9h5K9kaMeoJei4CL41Ecv9Ky6a90PI2y2gFTSaZIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcM+z9DegQbErJRwUsTFpTgxKqdLYwNnBu7gph7tu9Pc3tqLyIaK9eOED8pAHKF7tVqa2tQm7CmbxIYcymLTbQLU72T6ka3NEOLgVw+uE2oCPKgOXvrS5py3LZeSVEayk3fTBc5vIBJam8ERl5ES7tCwAwg2TVkf3MzWWu5U2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UOpT1u7X; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtaej007052;
	Wed, 14 Aug 2024 16:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Q
	E3jLMhbqm5q5B6AQVQeAXFLzswsHx3Oigu5M+migRk=; b=UOpT1u7XABBNy9u6n
	11Ws01wlN2+kvSwhXk28LE/xqi+hBvd3YJs++RDwwG1LZjkX63Zvl0IApuP+Qs6E
	jGRmFGuqNKC+iIJWLp/j8A6KrqaMOXM50qwHCZueMqdV/U3KXeGrdu5yDsCWluqq
	esVO9bB++EfwfM48H4dSExTQG3OtvtlZAPKp3t3UfAtXZlJqQcuJbxcEFmQP9+vO
	gTI/MVWKyKB5CDk5ui/kXKq0sXeckur0B/0Sg0WEMau4+YUrto4GE1VSD1Ea6dun
	DQMGiNqHRTLj5L3vn9dVYuu+TDmUx2ku8Z6HlitF+JE9ZZ1+PL3mpCqk6+kBFvS/
	OfUjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0398m0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EGCmUe020856;
	Wed, 14 Aug 2024 16:19:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCE035951;
	Wed, 14 Aug 2024 16:19:54 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-10;
	Wed, 14 Aug 2024 16:19:54 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 09/17] maple_tree: use store type in mas_wr_store_entry()
Date: Wed, 14 Aug 2024 12:19:36 -0400
Message-ID: <20240814161944.55347-10-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: bg50TrhVVWz8g9rwKKayfyCa375nXiqW
X-Proofpoint-GUID: bg50TrhVVWz8g9rwKKayfyCa375nXiqW

When storing an entry, we can read the store type that was set from a
previous partial walk of the tree. Now that the type of store is known,
select the correct write helper function to use to complete the store.

Also noinline mas_wr_spanning_store() to limit stack frame usage in
mas_wr_store_entry() as it allocates a maple_big_node on the stack.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 90 ++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 38 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a1689fc6227b..2242e07a46dc 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3780,7 +3780,7 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
  *
  * Return: 0 on error, positive on success.
  */
-static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
+static noinline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 {
 	struct maple_subtree_state mast;
 	struct maple_big_node b_node;
@@ -4206,43 +4206,62 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end = mas_wr_new_end(wr_mas);
 
-	wr_mas->content = mas_start(mas);
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
-		mas_store_root(mas, wr_mas->entry);
+	switch (mas->store_type) {
+	case wr_invalid:
+		MT_BUG_ON(mas->tree, 1);
 		return;
-	}
-
-	if (unlikely(!mas_wr_walk(wr_mas))) {
+	case wr_new_root:
+		mas_new_root(mas, wr_mas->entry);
+		break;
+	case wr_store_root:
+		mas_store_root(mas, wr_mas->entry);
+		break;
+	case wr_exact_fit:
+		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
+		if (!!wr_mas->entry ^ !!wr_mas->content)
+			mas_update_gap(mas);
+		break;
+	case wr_append:
+		mas_wr_append(wr_mas, new_end);
+		break;
+	case wr_slot_store:
+		mas_wr_slot_store(wr_mas);
+		break;
+	case wr_node_store:
+		mas_wr_node_store(wr_mas, new_end);
+		break;
+	case wr_spanning_store:
 		mas_wr_spanning_store(wr_mas);
-		return;
+		break;
+	case wr_split_store:
+	case wr_rebalance:
+		mas_wr_bnode(wr_mas);
+		break;
 	}
 
-	/* At this point, we are at the leaf node that needs to be altered. */
-	mas_wr_end_piv(wr_mas);
-	/* New root for a single pointer */
-	if (unlikely(!mas->index && mas->last == ULONG_MAX))
-		mas_new_root(mas, wr_mas->entry);
-	else
-		mas_wr_modify(wr_mas);
+	return;
 }
 
-static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
+static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
 {
-	if (!mas_is_active(wr_mas->mas)) {
-		if (mas_is_start(wr_mas->mas))
-			return;
+	struct ma_state *mas = wr_mas->mas;
+
+	if (!mas_is_active(mas)) {
+		if (mas_is_start(mas))
+			goto set_content;
 
-		if (unlikely(mas_is_paused(wr_mas->mas)))
+		if (unlikely(mas_is_paused(mas)))
 			goto reset;
 
-		if (unlikely(mas_is_none(wr_mas->mas)))
+		if (unlikely(mas_is_none(mas)))
 			goto reset;
 
-		if (unlikely(mas_is_overflow(wr_mas->mas)))
+		if (unlikely(mas_is_overflow(mas)))
 			goto reset;
 
-		if (unlikely(mas_is_underflow(wr_mas->mas)))
+		if (unlikely(mas_is_underflow(mas)))
 			goto reset;
 	}
 
@@ -4251,27 +4270,20 @@ static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 	 * writes within this node.  This is to stop partial walks in
 	 * mas_prealloc() from being reset.
 	 */
-	if (wr_mas->mas->last > wr_mas->mas->max)
+	if (mas->last > mas->max)
 		goto reset;
 
 	if (wr_mas->entry)
-		return;
+		goto set_content;
 
-	if (mte_is_leaf(wr_mas->mas->node) &&
-	    wr_mas->mas->last == wr_mas->mas->max)
+	if (mte_is_leaf(mas->node) && mas->last == mas->max)
 		goto reset;
 
-	return;
+	goto set_content;
 
 reset:
-	mas_reset(wr_mas->mas);
-}
-
-static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
-{
-	struct ma_state *mas = wr_mas->mas;
-
-	mas_wr_store_setup(wr_mas);
+	mas_reset(mas);
+set_content:
 	wr_mas->content = mas_start(mas);
 }
 
@@ -5582,7 +5594,8 @@ void *mas_store(struct ma_state *mas, void *entry)
 	 * want to examine what happens if a single store operation was to
 	 * overwrite multiple entries within a self-balancing B-Tree.
 	 */
-	mas_wr_store_setup(&wr_mas);
+	mas_wr_prealloc_setup(&wr_mas);
+	mas_wr_store_type(&wr_mas);
 	mas_wr_store_entry(&wr_mas);
 	return wr_mas.content;
 }
@@ -5634,7 +5647,8 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	mas_wr_store_setup(&wr_mas);
+	mas_wr_prealloc_setup(&wr_mas);
+	mas_wr_store_type(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
-- 
2.46.0



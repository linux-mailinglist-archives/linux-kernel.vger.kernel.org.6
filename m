Return-Path: <linux-kernel+bounces-286868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35737951FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF791281CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1312C1BD011;
	Wed, 14 Aug 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FA1pacCm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1A1BD008
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652420; cv=none; b=fX8m0MJGONo540K/9W+Y6tuWq657i4D7Ib8oo7xU6HiEfZQRkxRUiKoVB0u7T4+8+j1C4g4c6Z/qLyXHBovUyZljhsKZAPon8A9BQPbtdULgzUBcP9ekcqtxT1+pk25hFIyVr7yCfp0VkW1YBw0xtT6kM5yrHriSPrw9h+1fKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652420; c=relaxed/simple;
	bh=6py9RR8bQwy1oeiEnY3oqKKkGb3EPM1OuxSl3V3wDG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQj3ND3QUhKCNbq8gG5DrM4gMrMHbih/s3AIiiObXxPAKws1y8DVoeRlY+lEua9Z0i5qZI+xC/tKy1TPDJEQuSj9iKnRHYAeiOketVr9HQvWKR+VO25gleB3bBXqCFdr9ZKBd2Tzj9+IikmLzrya2gIhBJ4xhj7X3eDRrgKD7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FA1pacCm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtbbE013643;
	Wed, 14 Aug 2024 16:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=H
	7wKxpEJwe8slGwjyrSc9cjrvQv+dSZXxkMjvMrzgqo=; b=FA1pacCmf4kRDc1Ob
	IuXhF2UMItZNQizOH0DZ4CEt3KJ+5yCt8vcXtelmYBu7dlZWARQwmcmXkyPxwShN
	0rqN+rpccT/cz5kAcHrPp8Enc8XIKxTn3+mUuq3duVy2dAy8D2/yPWYYvCqPKImf
	lEGalAjaOw8IndVGzlwDpgIINZAaxg/WWMUdk1SWof8ZfS/G0dhzOEQMA8ygQD+j
	vipsdoaKAdZcfb5FiZNQoQixSFIsRCHEpjAQQIhehGUHOIhLYhDZ8L2cxOKTNzZ7
	AxJkxghw426HTCZzgpDIzrp+dQqAC5puQdBbn2PLKiShwEgylTHCRlV6DwDH9zx2
	Zeq+g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtrsu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:20:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFoG8f021115;
	Wed, 14 Aug 2024 16:19:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:58 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCO035951;
	Wed, 14 Aug 2024 16:19:58 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-15;
	Wed, 14 Aug 2024 16:19:58 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 14/17] maple_tree: remove node allocations from various write helper functions
Date: Wed, 14 Aug 2024 12:19:41 -0400
Message-ID: <20240814161944.55347-15-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: vZ3iApY1g4hjGhmvvlhdYKM7awe7RSw7
X-Proofpoint-GUID: vZ3iApY1g4hjGhmvvlhdYKM7awe7RSw7

These write helper functions are all called from store paths which
preallocate enough nodes that will be needed for the write. There is no
more need to allocate within the functions themselves.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d5e020dd93fa..5f79be184377 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2976,9 +2976,6 @@ static inline int mas_rebalance(struct ma_state *mas,
 	 * tries to combine the data in the same way.  If one node contains the
 	 * entire range of the tree, then that node is used as a new root node.
 	 */
-	mas_node_count(mas, empty_count * 2 - 1);
-	if (mas_is_err(mas))
-		return 0;
 
 	mast.orig_l = &l_mas;
 	mast.orig_r = &r_mas;
@@ -3029,11 +3026,6 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 	/* set up node. */
 	if (in_rcu) {
-		/* Allocate for both left and right as well as parent. */
-		mas_node_count(mas, 3);
-		if (mas_is_err(mas))
-			return;
-
 		newnode = mas_pop_node(mas);
 	} else {
 		newnode = &reuse;
@@ -3341,10 +3333,6 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 
 	trace_ma_op(__func__, mas);
 	mas->depth = mas_mt_height(mas);
-	/* Allocation failures will happen early. */
-	mas_node_count(mas, 1 + mas->depth * 2);
-	if (mas_is_err(mas))
-		return 0;
 
 	mast.l = &l_mas;
 	mast.r = &r_mas;
@@ -3427,10 +3415,6 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	unsigned long *pivots;
 	int slot = 0;
 
-	mas_node_count(mas, 1);
-	if (unlikely(mas_is_err(mas)))
-		return 0;
-
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
@@ -3699,10 +3683,6 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 		goto done;
 	}
 
-	mas_node_count(mas, 1);
-	if (mas_is_err(mas))
-		return 0;
-
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
@@ -3765,9 +3745,6 @@ static noinline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	 * entries per level plus a new root.
 	 */
 	height = mas_mt_height(mas);
-	mas_node_count(mas, 1 + height * 3);
-	if (mas_is_err(mas))
-		return 0;
 
 	/*
 	 * Set up right side.  Need to get to the next offset after the spanning
@@ -3851,10 +3828,6 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 
 	/* set up node. */
 	if (in_rcu) {
-		mas_node_count(mas, 1);
-		if (mas_is_err(mas))
-			return false;
-
 		newnode = mas_pop_node(mas);
 	} else {
 		memset(&reuse, 0, sizeof(struct maple_node));
-- 
2.46.0



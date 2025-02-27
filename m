Return-Path: <linux-kernel+bounces-537293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB5DA48A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739CD1889B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F2927183E;
	Thu, 27 Feb 2025 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gRNNqAGu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6C271818
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689326; cv=none; b=POSWNDb0iNYzKG9icCcQhNYbR9xD0IEqlRP/mWJw5neUVpXaNDkRWSFIYV4oucMqSBMRyih1zHXhTXH3eukWJQQDxD+eW4/m+WRaba+SjvRSSoPy+8Zwt54ueCthDDfPEQKcIsx/0gwNElRIWHbM5tPHzACN7ZwSF9Ap6Ai57QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689326; c=relaxed/simple;
	bh=uqFu6+AnpGHxr8NBX4Luk2zMRZ70uid9p7oor9n91K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEQyDsev6r5OYOIUEUMGWCVJbftVppNUL+Jx8bYaifi02i4w1vRNFhS/+9T7+LeyibJaAx1ZRc91GJfzCgBy1oM+RrY3cx+EmlzAnrRRHuHQXQk4JPssUwzqDvxcNwDPj9zwmSHJrzrRoKGwwr/gEpEK32dx7UyrWuaxbRBls8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gRNNqAGu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJiY80016056;
	Thu, 27 Feb 2025 20:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=9rOxR
	8xV/873pof+AkJuZwF4Ju77egxXek8DyN5etOw=; b=gRNNqAGuqrxyrzWhstSKs
	Ci96yqLVfG0pofsHzOswSLRK9TzfDpUMDWz5XN1sgTWv13nkL3UDSlElBumNqx9e
	z8xK8lW6MsJESWhaOIbRt8Wj7rpe+i4pWJTCxeDASF03lVxXpxd8Zg2ntjpI3vkv
	RFgUE+dBNbhv9m1EkfpnT7TK6aDS4syuYOrNrNulgwCTxA5GV+RxoyXA9H1gm4mb
	SSR4ZES6EujTv7pnRuC3AImP2Hloi3Yh7FP78pyE0kDwultKRTt1Mx99GGL4P2cq
	xY6YsqRkq2nBd9GdwTLYfQjSDrO/CMCJ4FijSpeashBdkP4xebzgVEFCpNlO8Ii/
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf49m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJGgfJ012623;
	Thu, 27 Feb 2025 20:48:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dws8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51RKhrvo030883;
	Thu, 27 Feb 2025 20:48:36 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44y51dwrvc-7;
	Thu, 27 Feb 2025 20:48:35 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 6/6] maple_tree: reorder mas->store_type case statements
Date: Thu, 27 Feb 2025 20:48:23 +0000
Message-ID: <20250227204823.758784-7-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: lKETHqUtyLBnsXDOSH0cE46buP1f3N_E
X-Proofpoint-GUID: lKETHqUtyLBnsXDOSH0cE46buP1f3N_E

Move the unlikely case that mas->store_type is invalid to be the last
evaluated case and put liklier cases higher up.

Suggested-by: Liam R. Howlett <liam.howlett@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d3aa5241166b..776693593ab9 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4093,15 +4093,6 @@ static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 	unsigned char new_end = mas_wr_new_end(wr_mas);
 
 	switch (mas->store_type) {
-	case wr_invalid:
-		MT_BUG_ON(mas->tree, 1);
-		return;
-	case wr_new_root:
-		mas_new_root(mas, wr_mas->entry);
-		break;
-	case wr_store_root:
-		mas_store_root(mas, wr_mas->entry);
-		break;
 	case wr_exact_fit:
 		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
 		if (!!wr_mas->entry ^ !!wr_mas->content)
@@ -4123,6 +4114,14 @@ static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 	case wr_rebalance:
 		mas_wr_bnode(wr_mas);
 		break;
+	case wr_new_root:
+		mas_new_root(mas, wr_mas->entry);
+		break;
+	case wr_store_root:
+		mas_store_root(mas, wr_mas->entry);
+		break;
+	case wr_invalid:
+		MT_BUG_ON(mas->tree, 1);
 	}
 
 	return;
@@ -4187,19 +4186,10 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 	unsigned char delta = height - wr_mas->vacant_height;
 
 	switch (mas->store_type) {
-	case wr_invalid:
-		WARN_ON_ONCE(1);
-		break;
-	case wr_new_root:
-		ret = 1;
-		break;
-	case wr_store_root:
-		if (likely((mas->last != 0) || (mas->index != 0)))
-			ret = 1;
-		else if (((unsigned long) (entry) & 3) == 2)
-			ret = 1;
-		else
-			ret = 0;
+	case wr_exact_fit:
+	case wr_append:
+	case wr_slot_store:
+		ret = 0;
 		break;
 	case wr_spanning_store:
 		if (wr_mas->sufficient_height < wr_mas->vacant_height)
@@ -4219,10 +4209,19 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 	case wr_node_store:
 		ret = mt_in_rcu(mas->tree) ? 1 : 0;
 		break;
-	case wr_append:
-	case wr_exact_fit:
-	case wr_slot_store:
-		ret = 0;
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
+	case wr_invalid:
+		WARN_ON_ONCE(1);
 	}
 
 	return ret;
-- 
2.43.0



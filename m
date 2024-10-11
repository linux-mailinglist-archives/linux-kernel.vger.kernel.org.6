Return-Path: <linux-kernel+bounces-361877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4F99AE39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F542872D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58811D3189;
	Fri, 11 Oct 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZBIImaXI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7B1D0E2B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683111; cv=none; b=bhzgezONk/4AdKwQ2sGu5nCbHr5w3SOGMy3anMrGtVAm6cR1urlxyRuV+tuNPvZ3wr76FD6EQk3wRI0lGN1nSXG7nUnIcjhWNSrv9U5m92pztK4qDiRMYdniFBFQqTaUAnc5LYgbyPDuD95bPkDQo9J9cufz/8lgCVvxMwTiBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683111; c=relaxed/simple;
	bh=7NQ2GFQh1/udyaN5fJWj0TuAXI4WGKb+Q4z0dd5jLNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJ/FmaAcGdFIackynFjUSQCCOzUs5Wq0G2g3BC0NDtUhtWFO33NaZNd/b44bAzpwTcvVW/V4eYnM87XKwir6//YJYdYCacawk17i0/LkjAwwapxKKU8jhVOp8WSdySe5hs2Rpcsk/OMP0oy6brBEkfIrq9eCi6fOysK5HjYXACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZBIImaXI; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJU84k030021;
	Fri, 11 Oct 2024 21:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=xnWRr
	y+gLN3GpXpXevD+PZSS7Fx/gqHioKulUKJNRrw=; b=ZBIImaXI5Urs9jUykLwXK
	alYd1N2RAe9o3VbIrDU7Ui8riuXkLOXA3bCACmBnw6fltcAkRPncean0hJ29yzOC
	+8zF1YmAZRrBRrQSFfJ0lUFjiwzPxni789Abx9QmUxjdR/thSMUXlUH71O1rqbi/
	ZKMoiZw7sxx+qyt3eOUXJM9UtsAhBPdwH8JlRN2Bd0aSRrnVGMeG8/lnaqJxd9fS
	aICtPbhczKa1YMoYi1nUNezOy626Qgc0sI22LrvDIOwFgsNwxcti4dZJ/TTm15UE
	7nBFU9WpT5tgYn2D292RLsf6F/NoFXaYItyIxxOqVMAmp4Pbg4nk0X7a8EY/GIbr
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dwvm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 21:44:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKUFfp028019;
	Fri, 11 Oct 2024 21:44:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwj3961-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 21:44:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49BLisSo026877;
	Fri, 11 Oct 2024 21:44:55 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-170-196.vpn.oracle.com [10.65.170.196])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uwj395e-2;
	Fri, 11 Oct 2024 21:44:55 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/2] maple_tree: refactor mas_wr_store_type()
Date: Fri, 11 Oct 2024 17:44:51 -0400
Message-ID: <20241011214451.7286-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241011214451.7286-1-sidhartha.kumar@oracle.com>
References: <20241011214451.7286-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110153
X-Proofpoint-ORIG-GUID: 7-fLVjE2wzeVOGEEfcoVFkKReyQH3081
X-Proofpoint-GUID: 7-fLVjE2wzeVOGEEfcoVFkKReyQH3081

In mas_wr_store_type(), we check if new_end < mt_slots[wr_mas->type]. If
this check fails, we know that ,after this, new_end is >= mt_min_slots.
Checking this again when we detect a wr_node_store later in the function
is reduntant. Because this check is part of an OR statement, the statement
will always evaluate to true, therefore we can just get rid of it.

We also refactor mas_wr_store_type() to return the store type rather
than set it directly as it greatly cleans up the function.

Suggested-by: Liam Howlett <liam.howlett@oracle.com>
Suggested-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
---

Hi Andrew, could you please drop
"maple_tree: remove conditionals to detect wr_node_store" in mm-unstable
before applying this patch

 lib/maple_tree.c | 72 +++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b3b1d4b8126b..a5e982e482dd 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4191,24 +4191,22 @@ static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
 }
 
 /*
- * mas_wr_store_type() - Set the store type for a given
+ * mas_wr_store_type() - Determine the store type for a given
  * store operation.
  * @wr_mas: The maple write state
+ *
+ * Return: the type of store needed for the operation
  */
-static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
+static inline enum store_type mas_wr_store_type(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char new_end;
 
-	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
-		mas->store_type = wr_store_root;
-		return;
-	}
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
+		return wr_store_root;
 
-	if (unlikely(!mas_wr_walk(wr_mas))) {
-		mas->store_type = wr_spanning_store;
-		return;
-	}
+	if (unlikely(!mas_wr_walk(wr_mas)))
+		return wr_spanning_store;
 
 	/* At this point, we are at the leaf node that needs to be altered. */
 	mas_wr_end_piv(wr_mas);
@@ -4216,50 +4214,30 @@ static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
 		mas_wr_extend_null(wr_mas);
 
 	new_end = mas_wr_new_end(wr_mas);
-	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last)) {
-		mas->store_type = wr_exact_fit;
-		return;
-	}
+	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last))
+		return wr_exact_fit;
 
-	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
-		mas->store_type = wr_new_root;
-		return;
-	}
+	if (unlikely(!mas->index && mas->last == ULONG_MAX))
+		return wr_new_root;
 
 	/* Potential spanning rebalance collapsing a node */
 	if (new_end < mt_min_slots[wr_mas->type]) {
-		if (!mte_is_root(mas->node) && !(mas->mas_flags & MA_STATE_BULK)) {
-			mas->store_type = wr_rebalance;
-			return;
-		}
-		mas->store_type = wr_node_store;
-		return;
+		if (!mte_is_root(mas->node) && !(mas->mas_flags & MA_STATE_BULK))
+			return  wr_rebalance;
+		return wr_node_store;
 	}
 
-	if (new_end >= mt_slots[wr_mas->type]) {
-		mas->store_type = wr_split_store;
-		return;
-	}
+	if (new_end >= mt_slots[wr_mas->type])
+		return wr_split_store;
 
-	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
-		mas->store_type = wr_append;
-		return;
-	}
+	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end))
+		return wr_append;
 
 	if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
-		(wr_mas->offset_end - mas->offset == 1))) {
-		mas->store_type = wr_slot_store;
-		return;
-	}
-
-	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
-		(mas->mas_flags & MA_STATE_BULK)) {
-		mas->store_type = wr_node_store;
-		return;
-	}
+		(wr_mas->offset_end - mas->offset == 1)))
+		return wr_slot_store;
 
-	mas->store_type = wr_invalid;
-	MAS_WARN_ON(mas, 1);
+	return wr_node_store;
 }
 
 /**
@@ -4274,7 +4252,7 @@ static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry)
 	int request;
 
 	mas_wr_prealloc_setup(wr_mas);
-	mas_wr_store_type(wr_mas);
+	mas->store_type = mas_wr_store_type(wr_mas);
 	request = mas_prealloc_calc(mas, entry);
 	if (!request)
 		return;
@@ -5446,7 +5424,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 	 * overwrite multiple entries within a self-balancing B-Tree.
 	 */
 	mas_wr_prealloc_setup(&wr_mas);
-	mas_wr_store_type(&wr_mas);
+	mas->store_type = mas_wr_store_type(&wr_mas);
 	if (mas->mas_flags & MA_STATE_PREALLOC) {
 		mas_wr_store_entry(&wr_mas);
 		MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
@@ -5549,7 +5527,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	int request;
 
 	mas_wr_prealloc_setup(&wr_mas);
-	mas_wr_store_type(&wr_mas);
+	mas->store_type = mas_wr_store_type(&wr_mas);
 	request = mas_prealloc_calc(mas, entry);
 	if (!request)
 		return ret;
-- 
2.43.0



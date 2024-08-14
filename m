Return-Path: <linux-kernel+bounces-286867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC606951FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32D7B2A3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB41BF30C;
	Wed, 14 Aug 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U47gcGkn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BEB1BB695
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652420; cv=none; b=hG9zf6tMxnwe0DhJJZ+WpsB+1bEUnrZWLFNte76B9CLO4C28UcRKvp+3xg9b5DfO6fSOXcQeK+vuqjvQP2WdFVK9NZUMOlnzpBaBuAl/v5d4Molko59sfVDnRKmJrA7zqYZeFeNXzpL3V7GSTlcBBqaReTK3OAWg7I5xGw385e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652420; c=relaxed/simple;
	bh=xvtjLsqo1zm7GJ8wGRr2aUcUgp13PhRzKWUO2x2acrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP8RvqDZgp9rcU6xvlAru9fWirzTpQr3p31Ha1V+/9V03limekAwqDD9AhVmle/yGweTdaouI//MHvIzF5rj8uAOWs9ea8XMNjXPDMigcPFdku3uURHWyIZz0Nl+8R6O4j9TMCWLzqp3hqsnurQsMAJSrcZJYcM1MOcuza0bSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U47gcGkn; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtZ2q028354;
	Wed, 14 Aug 2024 16:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=U
	GEoYZW0sw4JTr+KtFllFbwfaNVoSsnR7nGvPPo51B0=; b=U47gcGknT2xsxJP8j
	a9Y7GWU4zPM8Jy+OuCj0mjpmLsrNuaa3u9lcz8ISjgV+Pij4bMdU2mzVUsc9SY+4
	W0qqP0uTwLYutr3bs7dmgsd4YY81viTX/kk+8bI9+Dmwjr/O9fuJscrvM/gW7XHL
	IVz3cgPxgDBHB1xH8xNCgRJJNalWCKKrSE+8Zw3AyWjWxaVNktBZEOo/B4wsxwXm
	Ftuf5dROFN0BQBQeADiTtmKbX3012Cyo2XHqtXNIEcmlpy6QTyiqAc8YK+KNhefv
	+SdtWTT2Fo54UTyBsH3Qey7mjiStkPCiWYq/0AKqXJx8J2Y6z1HAWfwl5oeUYiUj
	CuLsg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt10shx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFQeGb021164;
	Wed, 14 Aug 2024 16:19:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:52 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvC6035951;
	Wed, 14 Aug 2024 16:19:51 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-6;
	Wed, 14 Aug 2024 16:19:51 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 05/17] maple_tree: remove mas_destroy() from mas_nomem()
Date: Wed, 14 Aug 2024 12:19:32 -0400
Message-ID: <20240814161944.55347-6-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: O2M6SR9o4ay1I-4Ym4vLae6geAmveOtk
X-Proofpoint-ORIG-GUID: O2M6SR9o4ay1I-4Ym4vLae6geAmveOtk

Separate call to mas_destroy() from mas_nomem() so we can check for no
memory errors without destroying the current maple state in
mas_store_gfp(). We then add calls to mas_destroy() to callers of
mas_nomem().

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c                 | 37 +++++++++++++++++++++-----------
 tools/testing/radix-tree/maple.c | 10 +++++----
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d0b9b3795b96..58985107cf00 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4519,6 +4519,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
 	if (*next == 0)
 		mas->tree->ma_flags |= MT_FLAGS_ALLOC_WRAPPED;
 
+	mas_destroy(mas);
 	return ret;
 }
 EXPORT_SYMBOL(mas_alloc_cyclic);
@@ -5601,21 +5602,25 @@ int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
 	unsigned long index = mas->index;
 	unsigned long last = mas->last;
 	MA_WR_STATE(wr_mas, mas, entry);
+	int ret = 0;
 
-	mas_wr_store_setup(&wr_mas);
-	trace_ma_write(__func__, mas, 0, entry);
 retry:
-	mas_wr_store_entry(&wr_mas);
+	mas_wr_preallocate(&wr_mas, entry);
 	if (unlikely(mas_nomem(mas, gfp))) {
 		if (!entry)
 			__mas_set_range(mas, index, last);
 		goto retry;
 	}
 
-	if (unlikely(mas_is_err(mas)))
-		return xa_err(mas->node);
+	if (mas_is_err(mas)) {
+		ret = xa_err(mas->node);
+		goto out;
+	}
 
-	return 0;
+	mas_wr_store_entry(&wr_mas);
+out:
+	mas_destroy(mas);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mas_store_gfp);
 
@@ -6374,6 +6379,7 @@ void *mas_erase(struct ma_state *mas)
 		goto write_retry;
 	}
 
+	mas_destroy(mas);
 	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_erase);
@@ -6388,10 +6394,8 @@ EXPORT_SYMBOL_GPL(mas_erase);
 bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 	__must_hold(mas->tree->ma_lock)
 {
-	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
-		mas_destroy(mas);
+	if (likely(mas->node != MA_ERROR(-ENOMEM)))
 		return false;
-	}
 
 	if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
 		mtree_unlock(mas->tree);
@@ -6469,6 +6473,7 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 {
 	MA_STATE(mas, mt, index, last);
 	MA_WR_STATE(wr_mas, &mas, entry);
+	int ret = 0;
 
 	trace_ma_write(__func__, &mas, 0, entry);
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
@@ -6484,10 +6489,12 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		goto retry;
 
 	mtree_unlock(mt);
+
 	if (mas_is_err(&mas))
-		return xa_err(mas.node);
+		ret = xa_err(mas.node);
 
-	return 0;
+	mas_destroy(&mas);
+	return ret;
 }
 EXPORT_SYMBOL(mtree_store_range);
 
@@ -6523,6 +6530,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 		unsigned long last, void *entry, gfp_t gfp)
 {
 	MA_STATE(ms, mt, first, last);
+	int ret = 0;
 
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
@@ -6538,9 +6546,10 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 
 	mtree_unlock(mt);
 	if (mas_is_err(&ms))
-		return xa_err(ms.node);
+		ret = xa_err(ms.node);
 
-	return 0;
+	mas_destroy(&ms);
+	return ret;
 }
 EXPORT_SYMBOL(mtree_insert_range);
 
@@ -6595,6 +6604,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 
 unlock:
 	mtree_unlock(mt);
+	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_range);
@@ -6676,6 +6686,7 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 
 unlock:
 	mtree_unlock(mt);
+	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_rrange);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index ad42a36231fb..c5b00aca9def 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -120,7 +120,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
 	mas_push_node(&mas, mn);
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL); /* free */
+	mas_destroy(&mas);
 	mtree_unlock(mt);
 
 
@@ -144,7 +144,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	mas.status = ma_start;
-	mas_nomem(&mas, GFP_KERNEL);
+	mas_destroy(&mas);
 	/* Allocate 3 nodes, will fail. */
 	mas_node_count(&mas, 3);
 	/* Drop the lock and allocate 3 nodes. */
@@ -161,7 +161,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
 	/* Free. */
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL);
+	mas_destroy(&mas);
 
 	/* Set allocation request to 1. */
 	mas_set_alloc_req(&mas, 1);
@@ -277,6 +277,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 		}
 		mas_reset(&mas);
 		MT_BUG_ON(mt, mas_nomem(&mas, GFP_KERNEL));
+		mas_destroy(&mas);
 
 	}
 
@@ -299,7 +300,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	}
 	MT_BUG_ON(mt, mas_allocated(&mas) != total);
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL); /* Free. */
+	mas_destroy(&mas); /* Free. */
 
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	for (i = 1; i < 128; i++) {
@@ -35847,6 +35848,7 @@ static noinline void __init check_nomem(struct maple_tree *mt)
 	mas_store(&ms, &ms); /* insert 1 -> &ms */
 	mas_nomem(&ms, GFP_KERNEL); /* Node allocated in here. */
 	mtree_unlock(mt);
+	mas_destroy(&ms);
 	mtree_destroy(mt);
 }
 
-- 
2.46.0



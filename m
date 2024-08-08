Return-Path: <linux-kernel+bounces-279863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237394C2C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1021F2379B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1721B19007E;
	Thu,  8 Aug 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hMq/0yWk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CD18E04F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134620; cv=none; b=ScoG0wLMkBhIVhcCLJaPyNF3kjUEBM33chxnGVRwdM3rnYK7aSbqfCqNN0gouk/KWOmTRhYQZjn7pDzoQ4Z3HW4RqUVGDsVzJDoYitwbVoWuRl0Q8J3H9Hp9ItZCl87kTrbiQRNQ5YgPezO1Qj4707PS8zaz/PYkYgtYwfZbT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134620; c=relaxed/simple;
	bh=NGHV7TCxCxk6/GgFIA+YjWql8B1r6Jp1z754ux9MQ+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+3xWeAbPGvYJb11yJCsdNCS3tijg5TrXV+LLrkemUrZYlu5nZbE5rnF1QqV5ZnrAJT8KxNp4cZdrJTP+XqbBUZXDgLBJI6B0g6JYDvLUFNtugVk3zqBIEgCKGT/0Wqeg8RMPMSv4mqLI7wI71t7Bu/MKgG85Box26WRK4Vex/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hMq/0yWk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMWmg014888;
	Thu, 8 Aug 2024 16:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=MCKv0iZLaIKB2U
	xF0JuAuzv2IhnYhIEWfUHEcWlI/e0=; b=hMq/0yWkdLVu68vKITOB4PFk1ove1U
	mXaVtx4QKrgbHNZ5gAt4Az5MCnoO8oVChKNuOW4+u/TSzmg7Vi7JNkvtaP8m2zGL
	xl5y5+GrbOADOCthWTIYRtvJ7xY0cMk1Jxg3T2AgHtxZ7XMJ6dhjo4TNBoGkgvA9
	slDnu/OSdF1o6Z9/uk8OktfG5MLV5leCqvLF7LA3QBqYADDA7ioiUmuCRDP0sC6J
	2sxNWeSdHsKvdYcpjmYm+qdII/KNQWByU++rBXEawgrZDee0I/5dd3GNfMYO0xTq
	ktYw1btlB/9XyKtiH/F44IwHrB5UISwC4Je7BNhFPnz8TRCymnK9vM4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5tj6ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 16:30:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478GAa0a039522;
	Thu, 8 Aug 2024 16:30:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0cvkqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 16:30:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 478GU5On039245;
	Thu, 8 Aug 2024 16:30:05 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-170-228.vpn.oracle.com [10.65.170.228])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40sb0cvkpn-1;
	Thu, 08 Aug 2024 16:30:05 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/2] maple_tree: add test to replicate low memory race conditions
Date: Thu,  8 Aug 2024 12:29:59 -0400
Message-ID: <20240808163000.25053-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_16,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408080116
X-Proofpoint-ORIG-GUID: dwviSdDfYBhYQgD9tRC6g2YMHe7I4dHP
X-Proofpoint-GUID: dwviSdDfYBhYQgD9tRC6g2YMHe7I4dHP

Add new callback fields to the userspace implementation of struct
kmem_cache. This allows for executing callback functions in order to
further test low memory scenarios where node allocation is retried.

This callback can help test race conditions by calling a function when a
low memory event is tested". This exposes a race condition that is
addressed in a subsequent patch.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c                 | 12 +++++++
 tools/testing/radix-tree/maple.c | 60 ++++++++++++++++++++++++++++++++
 tools/testing/shared/linux.c     | 26 +++++++++++++-
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index aa3a5df15b8e..65fba37ef999 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6997,6 +6997,18 @@ void mt_set_non_kernel(unsigned int val)
 	kmem_cache_set_non_kernel(maple_node_cache, val);
 }
 
+extern void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)(void *));
+void mt_set_callback(void (*callback)(void *))
+{
+	kmem_cache_set_callback(maple_node_cache, callback);
+}
+
+extern void kmem_cache_set_private(struct kmem_cache *cachep, void *private);
+void mt_set_private(void *private)
+{
+	kmem_cache_set_private(maple_node_cache, private);
+}
+
 extern unsigned long kmem_cache_get_alloc(struct kmem_cache *);
 unsigned long mt_get_alloc_size(void)
 {
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index cd1cf05503b4..0e699feb71b8 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36224,6 +36224,61 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
 
 extern void test_kmem_cache_bulk(void);
 
+static void writer2(void *maple_tree)
+{
+	struct maple_tree *mt = (struct maple_tree *)maple_tree;
+	MA_STATE(mas, mt, 0, 0);
+
+	mtree_lock(mas.tree);
+	__mas_set_range(&mas, 6, 10);
+	mas_store(&mas, xa_mk_value(0xC));
+	mas_destroy(&mas);
+	mtree_unlock(mas.tree);
+}
+
+static void check_data_race(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 0);
+
+	mt_set_non_kernel(0);
+	/* setup root with 2 values with NULL in between */
+	mtree_store_range(mt, 0, 5, xa_mk_value(0xA), GFP_KERNEL);
+	mtree_store_range(mt, 6, 10, NULL, GFP_KERNEL);
+	mtree_store_range(mt, 11, 15, xa_mk_value(0xB), GFP_KERNEL);
+
+	/* setup writer 2 that will trigger the race condition */
+	mt_set_private(mt);
+	mt_set_callback(writer2);
+
+	mtree_lock(mt);
+	/* erase 0-5 */
+	mas_reset(&mas);
+	mas.index = 0;
+	mas.last = 5;
+	mas_erase(&mas);
+
+	/* index 6-10 should retain the value from writer 2*/
+	check_load(mt, 6, xa_mk_value(0xC));
+	mtree_unlock(mt);
+
+	/* test for the same race but with mas_store_gfp */
+	mtree_store_range(mt, 0, 5, xa_mk_value(0xA), GFP_KERNEL);
+	mtree_store_range(mt, 6, 10, NULL, GFP_KERNEL);
+
+	mtree_lock(mt);
+	mas_reset(&mas);
+	mas.index = 0;
+	mas.last = 5;
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+
+	check_load(mt, 6, xa_mk_value(0xC));
+
+	mt_set_private(NULL);
+	mt_set_callback(NULL);
+	mas_destroy(&mas);
+	mtree_unlock(mt);
+}
+
 void farmer_tests(void)
 {
 	struct maple_node *node;
@@ -36243,6 +36298,11 @@ void farmer_tests(void)
 	node->mr64.pivot[2] = 0;
 	tree.ma_root = mt_mk_node(node, maple_leaf_64);
 	mt_dump(&tree, mt_dump_dec);
+	mtree_destroy(&tree);
+
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
+	check_data_race(&tree);
+	mtree_destroy(&tree);
 
 	node->parent = ma_parent_ptr(node);
 	ma_free_rcu(node);
diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
index 4eb442206d01..17263696b5d8 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -26,8 +26,21 @@ struct kmem_cache {
 	unsigned int non_kernel;
 	unsigned long nr_allocated;
 	unsigned long nr_tallocated;
+	bool exec_callback;
+	void (*callback)(void *);
+	void *private;
 };
 
+void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)(void *))
+{
+	cachep->callback = callback;
+}
+
+void kmem_cache_set_private(struct kmem_cache *cachep, void *private)
+{
+	cachep->private = private;
+}
+
 void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val)
 {
 	cachep->non_kernel = val;
@@ -58,9 +71,17 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 {
 	void *p;
 
+	if (cachep->exec_callback) {
+		if (cachep->callback)
+			cachep->callback(cachep->private);
+		cachep->exec_callback = false;
+	}
+
 	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
-		if (!cachep->non_kernel)
+		if (!cachep->non_kernel) {
+			cachep->exec_callback = true;
 			return NULL;
+		}
 
 		cachep->non_kernel--;
 	}
@@ -223,6 +244,9 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 	ret->objs = NULL;
 	ret->ctor = ctor;
 	ret->non_kernel = 0;
+	ret->exec_callback = false;
+	ret->callback = NULL;
+	ret->private = NULL;
 	return ret;
 }
 
-- 
2.46.0


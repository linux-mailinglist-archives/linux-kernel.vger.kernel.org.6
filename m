Return-Path: <linux-kernel+bounces-283639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4B94F735
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3E5B21427
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC81917EC;
	Mon, 12 Aug 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="culyO0NO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6518FC75
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489570; cv=none; b=Z/Zf9Bootk0Esh52UpcUe9ss0z9vjWOBMFOyyuC11kZGvtjI23uWDBo7UaNlAnG/gBNitPz8UAh2iNp6cE2I2lE7LDTBe5HvaJUu7LaoYLRQQ064x1iwvJHgEaBZCV9RgziXk8D9V3twfohHHVM8p+yWs+tnnu1KRG5gveyaKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489570; c=relaxed/simple;
	bh=SD3o8t3xpSydQKsCJ4Oo318BGEY3obp3OrU51923D2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMeULa7GQ9xlflqZ6DHTVelSVMFTWSWYNBXlxzGkn+rKIijk/Rkus6m0Yiy+h6F9HeRN1rXzXhWgwAn3mSI+tP6b741RXYutpDLX+gbumO6Un/tGpSl5sKfH14cKT3+GoVjxnpZhvKOsjD1ghRWKDiDKajtQfzRQ2lfa0Va2qjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=culyO0NO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXnhS018534;
	Mon, 12 Aug 2024 19:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=8
	QTi9OJ0WYuil/jQ98RXaB1n034ZwVOed6J+lTgWExk=; b=culyO0NOP0oVmsnsn
	cbPrM9zUWvS1ZtsMK6xES9k8eLzGvfUbwlH9QkQMEe61bf7c5uNw3va2wpfoB0cw
	pHQrOwNbGwSOO9CtZ28bVk4PuKqhQ+aYqc2TR8HxkdD7F4ulCfYN3aBVzYzgObc4
	8T3pRh8iunpYJMfNt5WldhuaXasZB0Qj1DuGkezQ79r7CJfBe2JkLaXX8EJkkMMZ
	uXZMZe0EpzFdBRVY6mS0vlGo9LN8FvDq51MLMJuzcytXPkitPyV3RVwOzQD94fXL
	5wVB09Pka3B654l4HGcyodrV1nNl0r6VI+c2ZUjFtVEJmz9XY8sz0IkyDP6puEVB
	mv+Jw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0393ck9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:05:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CJ3jNO017630;
	Mon, 12 Aug 2024 19:05:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8dfdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:05:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47CJ22Kh022973;
	Mon, 12 Aug 2024 19:05:49 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-176-210.vpn.oracle.com [10.65.176.210])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40wxn8dfa3-2;
	Mon, 12 Aug 2024 19:05:49 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 2/2] maple_tree: add test to replicate low memory race conditions
Date: Mon, 12 Aug 2024 15:05:43 -0400
Message-ID: <20240812190543.71967-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812190543.71967-1-sidhartha.kumar@oracle.com>
References: <20240812190543.71967-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120141
X-Proofpoint-ORIG-GUID: rAZAEemYjuAn6o_hPAuZF05o8qpaOcbe
X-Proofpoint-GUID: rAZAEemYjuAn6o_hPAuZF05o8qpaOcbe

Add new callback fields to the userspace implementation of struct
kmem_cache. This allows for executing callback functions in order to
further test low memory scenarios where node allocation is retried.

This callback can help test race conditions by calling a function when a
low memory event is tested.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
v1 -> v2:
        - change test name to check_nomem_writer_race()
        - move test down in farmer_tests()
        - remove mas_destroy() from check_nomem_writer_race() as its not
          needed
        - remove using mas.index and mas.last directly through
          mas_set_range() and MA_STATE macros.
        - remove uneeded mas_reset() in check_nomem_writer_race().

 lib/maple_tree.c                 | 13 +++++++
 tools/testing/radix-tree/maple.c | 63 ++++++++++++++++++++++++++++++++
 tools/testing/shared/linux.c     | 26 ++++++++++++-
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b547ff211ac7..14d7864b8d53 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7005,6 +7005,19 @@ void mt_set_non_kernel(unsigned int val)
 	kmem_cache_set_non_kernel(maple_node_cache, val);
 }
 
+extern void kmem_cache_set_callback(struct kmem_cache *cachep,
+		void (*callback)(void *));
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
index cd1cf05503b4..ef5b83cf94ea 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36224,6 +36224,65 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
 
 extern void test_kmem_cache_bulk(void);
 
+/* callback function used for check_nomem_writer_race() */
+static void writer2(void *maple_tree)
+{
+	struct maple_tree *mt = (struct maple_tree *)maple_tree;
+	MA_STATE(mas, mt, 6, 10);
+
+	mtree_lock(mas.tree);
+	mas_store(&mas, xa_mk_value(0xC));
+	mas_destroy(&mas);
+	mtree_unlock(mas.tree);
+}
+
+/*
+ * check_nomem_writer_race() - test a possible race in the mas_nomem() path
+ * @mt: The tree to build.
+ *
+ * There is a possible race condition in low memory conditions when mas_nomem()
+ * gives up its lock. A second writer can chagne the entry that the primary
+ * writer executing the mas_nomem() path is modifying. This test recreates this
+ * scenario to ensure we are handling it correctly.
+ */
+static void check_nomem_writer_race(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 5);
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
+	mas_erase(&mas);
+
+	/* index 6-10 should retain the value from writer 2 */
+	check_load(mt, 6, xa_mk_value(0xC));
+	mtree_unlock(mt);
+
+	/* test for the same race but with mas_store_gfp() */
+	mtree_store_range(mt, 0, 5, xa_mk_value(0xA), GFP_KERNEL);
+	mtree_store_range(mt, 6, 10, NULL, GFP_KERNEL);
+
+	mas_set_range(&mas, 0, 5);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+
+	/* ensure write made by writer 2 is retained */
+	check_load(mt, 6, xa_mk_value(0xC));
+
+	mt_set_private(NULL);
+	mt_set_callback(NULL);
+	mtree_unlock(mt);
+}
+
 void farmer_tests(void)
 {
 	struct maple_node *node;
@@ -36257,6 +36316,10 @@ void farmer_tests(void)
 	check_dfs_preorder(&tree);
 	mtree_destroy(&tree);
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
+	check_nomem_writer_race(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_prealloc(&tree);
 	mtree_destroy(&tree);
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



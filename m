Return-Path: <linux-kernel+bounces-447957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7A9F392C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23B87A222C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307E7207A20;
	Mon, 16 Dec 2024 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PexKnRJU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AA207657
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374730; cv=none; b=fY9Q1+yD3YlNiCI78AVg8riUZBVT1BYPV5VT4iZcpxtr0HVTv2bDy8wa2i9hQ00bMy4JOIZnaWuS+PxELlZO6RDO9mqQLACHZtcj2sDYnp9ZcARXgJwBj+DfIBM/us4uJZFyt/dt+8B0Nx3EhSoYZA6ELBM20mKPw96qQFF/SIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374730; c=relaxed/simple;
	bh=N+SDcaRaPLmwU+S3cxEP/3JecqntZWQBn2RnxDMjWoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQq/4CwDWISS+68XxljG8ocS+rIt9Wilg+TJ62k2LIwun3RNqy+iLV8QPUjENQX3+QJx52oPnAgyKaBSc72qZM1qTMmHYFULFyJ0KgA8qnM4GTviWxrYc8/XoIDW1ZysgS9DKjTAGnorOaZy2Bv9MTrU5joW6xRfI6r11+yWx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PexKnRJU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734374726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+qZu5w8AAZJ493Tj0qMUBFvCjVcrATmNsXnEfokgdYQ=;
	b=PexKnRJUffjQ1MhcXfHBTkFL+p5Sld83NSCeoxtJH+phyLUUcw0WvX4CEIRkgEj6Pls5yi
	xa2QAdh+7Vr+vi8qSQnX1qSVYOiqfVxYZn9zLV1oD6YVKVoI9YADCBKerxcWKgs6ONs9Ni
	K2au0ifumrt4So7aSTZZOnCuNcGh/ZI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-7rd2VwcBNOeswmkRVStcaA-1; Mon,
 16 Dec 2024 13:45:22 -0500
X-MC-Unique: 7rd2VwcBNOeswmkRVStcaA-1
X-Mimecast-MFC-AGG-ID: 7rd2VwcBNOeswmkRVStcaA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 637571955F3C;
	Mon, 16 Dec 2024 18:45:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02A5A1956056;
	Mon, 16 Dec 2024 18:45:19 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: linux-mm@kvack.org,
	mgorman@techsingularity.net
Cc: david@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [RFC] mm: alloc_pages_bulk_noprof: drop page_list argument
Date: Mon, 16 Dec 2024 13:45:04 -0500
Message-ID: <20241216184504.19406-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The commit 387ba26fb1cb added __alloc_pages_bulk() along with the page_list
argument. The next commit 0f87d9d30f21 added the array-based argument. As
it turns out, the page_list argument has no users in the current tree (if it
ever had any). Dropping it allows for a slight simplification and eliminates
some unnecessary checks, now that page_array is required.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 include/linux/gfp.h |  8 ++------
 mm/mempolicy.c      | 14 +++++++-------
 mm/page_alloc.c     | 39 ++++++++++++---------------------------
 3 files changed, 21 insertions(+), 40 deletions(-)

I spotted this while reading some code. Sending as RFC because I'm not sure
if there might be a good reason to keep it.

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b0fe9f62d15b..eebed36443b3 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -212,7 +212,6 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
 
 unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 				nodemask_t *nodemask, int nr_pages,
-				struct list_head *page_list,
 				struct page **page_array);
 #define __alloc_pages_bulk(...)			alloc_hooks(alloc_pages_bulk_noprof(__VA_ARGS__))
 
@@ -223,11 +222,8 @@ unsigned long alloc_pages_bulk_array_mempolicy_noprof(gfp_t gfp,
 	alloc_hooks(alloc_pages_bulk_array_mempolicy_noprof(__VA_ARGS__))
 
 /* Bulk allocate order-0 pages */
-#define alloc_pages_bulk_list(_gfp, _nr_pages, _list)			\
-	__alloc_pages_bulk(_gfp, numa_mem_id(), NULL, _nr_pages, _list, NULL)
-
 #define alloc_pages_bulk_array(_gfp, _nr_pages, _page_array)		\
-	__alloc_pages_bulk(_gfp, numa_mem_id(), NULL, _nr_pages, NULL, _page_array)
+	__alloc_pages_bulk(_gfp, numa_mem_id(), NULL, _nr_pages, _page_array)
 
 static inline unsigned long
 alloc_pages_bulk_array_node_noprof(gfp_t gfp, int nid, unsigned long nr_pages,
@@ -236,7 +232,7 @@ alloc_pages_bulk_array_node_noprof(gfp_t gfp, int nid, unsigned long nr_pages,
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
-	return alloc_pages_bulk_noprof(gfp, nid, NULL, nr_pages, NULL, page_array);
+	return alloc_pages_bulk_noprof(gfp, nid, NULL, nr_pages, page_array);
 }
 
 #define alloc_pages_bulk_array_node(...)				\
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 04f35659717a..42a7b07ccc15 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2375,13 +2375,13 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 		if (delta) {
 			nr_allocated = alloc_pages_bulk_noprof(gfp,
 					interleave_nodes(pol), NULL,
-					nr_pages_per_node + 1, NULL,
+					nr_pages_per_node + 1,
 					page_array);
 			delta--;
 		} else {
 			nr_allocated = alloc_pages_bulk_noprof(gfp,
 					interleave_nodes(pol), NULL,
-					nr_pages_per_node, NULL, page_array);
+					nr_pages_per_node, page_array);
 		}
 
 		page_array += nr_allocated;
@@ -2430,7 +2430,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	if (weight && node_isset(node, nodes)) {
 		node_pages = min(rem_pages, weight);
 		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
-						  NULL, page_array);
+						  page_array);
 		page_array += nr_allocated;
 		total_allocated += nr_allocated;
 		/* if that's all the pages, no need to interleave */
@@ -2493,7 +2493,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 		if (!node_pages)
 			break;
 		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
-						  NULL, page_array);
+						  page_array);
 		page_array += nr_allocated;
 		total_allocated += nr_allocated;
 		if (total_allocated == nr_pages)
@@ -2517,11 +2517,11 @@ static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
 	nr_allocated  = alloc_pages_bulk_noprof(preferred_gfp, nid, &pol->nodes,
-					   nr_pages, NULL, page_array);
+					   nr_pages, page_array);
 
 	if (nr_allocated < nr_pages)
 		nr_allocated += alloc_pages_bulk_noprof(gfp, numa_node_id(), NULL,
-				nr_pages - nr_allocated, NULL,
+				nr_pages - nr_allocated,
 				page_array + nr_allocated);
 	return nr_allocated;
 }
@@ -2557,7 +2557,7 @@ unsigned long alloc_pages_bulk_array_mempolicy_noprof(gfp_t gfp,
 	nid = numa_node_id();
 	nodemask = policy_nodemask(gfp, pol, NO_INTERLEAVE_INDEX, &nid);
 	return alloc_pages_bulk_noprof(gfp, nid, nodemask,
-				       nr_pages, NULL, page_array);
+				       nr_pages, page_array);
 }
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1cb4b8c8886d..32c7ca80468c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4529,28 +4529,23 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 }
 
 /*
- * __alloc_pages_bulk - Allocate a number of order-0 pages to a list or array
+ * __alloc_pages_bulk - Allocate a number of order-0 pages to an array
  * @gfp: GFP flags for the allocation
  * @preferred_nid: The preferred NUMA node ID to allocate from
  * @nodemask: Set of nodes to allocate from, may be NULL
- * @nr_pages: The number of pages desired on the list or array
- * @page_list: Optional list to store the allocated pages
- * @page_array: Optional array to store the pages
+ * @nr_pages: The number of pages desired on the array
+ * @page_array: Array to store the pages
  *
  * This is a batched version of the page allocator that attempts to
- * allocate nr_pages quickly. Pages are added to page_list if page_list
- * is not NULL, otherwise it is assumed that the page_array is valid.
+ * allocate nr_pages quickly. Pages are added to the page_array.
  *
- * For lists, nr_pages is the number of pages that should be allocated.
- *
- * For arrays, only NULL elements are populated with pages and nr_pages
+ * Note that only NULL elements are populated with pages and nr_pages
  * is the maximum number of pages that will be stored in the array.
  *
- * Returns the number of pages on the list or array.
+ * Returns the number of pages on the array.
  */
 unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			nodemask_t *nodemask, int nr_pages,
-			struct list_head *page_list,
 			struct page **page_array)
 {
 	struct page *page;
@@ -4568,7 +4563,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	 * Skip populated array elements to determine if any pages need
 	 * to be allocated before disabling IRQs.
 	 */
-	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
+	while (nr_populated < nr_pages && page_array[nr_populated])
 		nr_populated++;
 
 	/* No pages requested? */
@@ -4576,7 +4571,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		goto out;
 
 	/* Already populated array? */
-	if (unlikely(page_array && nr_pages - nr_populated == 0))
+	if (unlikely(nr_pages - nr_populated == 0))
 		goto out;
 
 	/* Bulk allocator does not support memcg accounting. */
@@ -4658,7 +4653,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	while (nr_populated < nr_pages) {
 
 		/* Skip existing pages */
-		if (page_array && page_array[nr_populated]) {
+		if (page_array[nr_populated]) {
 			nr_populated++;
 			continue;
 		}
@@ -4676,11 +4671,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		nr_account++;
 
 		prep_new_page(page, 0, gfp, 0);
-		if (page_list)
-			list_add(&page->lru, page_list);
-		else
-			page_array[nr_populated] = page;
-		nr_populated++;
+		page_array[nr_populated++] = page;
 	}
 
 	pcp_spin_unlock(pcp);
@@ -4697,14 +4688,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 failed:
 	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
-	if (page) {
-		if (page_list)
-			list_add(&page->lru, page_list);
-		else
-			page_array[nr_populated] = page;
-		nr_populated++;
-	}
-
+	if (page)
+		page_array[nr_populated++] = page;
 	goto out;
 }
 EXPORT_SYMBOL_GPL(alloc_pages_bulk_noprof);
-- 
2.47.1



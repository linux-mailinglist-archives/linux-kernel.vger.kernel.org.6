Return-Path: <linux-kernel+bounces-223538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED09114A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA21F1F28030
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75B824B3;
	Thu, 20 Jun 2024 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Trg5lKI8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0076041
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918988; cv=none; b=oxWK+Llj679MuWeetQRFIfSQ5dlkwwQ4BGBFYhdBWRoNkEEiC83Ej/a7jx4Yhz7Y+QCWL2z1qXp4iDguR7kQvicnqiJKxL5009Ot4mXpiDrcMXgYkCTvJttkAcQiDwyM3hHYIfVWD6jB43LP1ODED1qx8ahowWsTKFYz7k3ricE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918988; c=relaxed/simple;
	bh=KSlm8lvirawc2eJ715Pj+F3E45AYSI0xzUPUrEw0QT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA0jiTMCeDDHp5/msxhakhVrn8gzjYlJf3TSw5KBoELmabmAuhM5jGSE5QaZ6WTLkByp1sNvUJoh4TfdvSAUWKIJbBkDD7v56ZP4WHrhE9LAsBmtMgBFAprQQfV296aDa1QzGB3dKzz7P2PJ3RjC6usXoYKH3QghJHoULNO7oxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Trg5lKI8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718918985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WE7XSbE5eRnL7QGI4j2KBnNO3JP8DLj8XFRYb1hlHtY=;
	b=Trg5lKI8hkXL+ZmFC2bKrPC1c0dxXMIppcjwsUSAbJ0J10yfly7bUnr0g7uhe8pDKQErUu
	czz/Rmeig9FZm4+oMvsch4oie2sYn3S16JpgvM/5iUj4AA/dFQw76hs6GfuhneMRDk0hMq
	1ZZhaZ/feUFIlqjnb5QHm/XxvjokO70=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-y_q3-vAEPDaRf0dMPw964g-1; Thu,
 20 Jun 2024 17:29:44 -0400
X-MC-Unique: y_q3-vAEPDaRf0dMPw964g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58F3E19560B8;
	Thu, 20 Jun 2024 21:29:43 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.54])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C1E019560AF;
	Thu, 20 Jun 2024 21:29:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio isolation + checks under PTL
Date: Thu, 20 Jun 2024 23:29:35 +0200
Message-ID: <20240620212935.656243-3-david@redhat.com>
In-Reply-To: <20240620212935.656243-1-david@redhat.com>
References: <20240620212935.656243-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Currently we always take a folio reference even if migration will not
even be tried or isolation failed, requiring us to grab+drop an additional
reference.

Further, we end up calling folio_likely_mapped_shared() while the folio
might have already been unmapped, because after we dropped the PTL, that
can easily happen. We want to stop touching mapcounts and friends from
such context, and only call folio_likely_mapped_shared() while the folio
is still mapped: mapcount information is pretty much stale and unreliable
otherwise.

So let's move checks into numamigrate_isolate_folio(), rename that
function to migrate_misplaced_folio_prepare(), and call that function
from callsites where we call migrate_misplaced_folio(), but still with
the PTL held.

We can now stop taking temporary folio references, and really only take
a reference if folio isolation succeeded. Doing the
folio_likely_mapped_shared() + golio isolation under PT lock is now similar
to how we handle MADV_PAGEOUT.

While at it, combine the folio_is_file_lru() checks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  7 ++++
 mm/huge_memory.c        |  8 ++--
 mm/memory.c             |  9 +++--
 mm/migrate.c            | 81 +++++++++++++++++++----------------------
 4 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index f9d92482d117..644be30b69c8 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -139,9 +139,16 @@ const struct movable_operations *page_movable_ops(struct page *page)
 }
 
 #ifdef CONFIG_NUMA_BALANCING
+int migrate_misplaced_folio_prepare(struct folio *folio,
+		struct vm_area_struct *vma, int node);
 int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 			   int node);
 #else
+static inline int migrate_misplaced_folio_prepare(struct folio *folio,
+		struct vm_area_struct *vma, int node)
+{
+	return -EAGAIN; /* can't migrate now */
+}
 static inline int migrate_misplaced_folio(struct folio *folio,
 					 struct vm_area_struct *vma, int node)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fc27dabcd8e3..4b2817bb2c7d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (node_is_toptier(nid))
 		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
-	if (target_nid == NUMA_NO_NODE) {
-		folio_put(folio);
+	if (target_nid == NUMA_NO_NODE)
+		goto out_map;
+	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
+		flags |= TNF_MIGRATE_FAIL;
 		goto out_map;
 	}
-
+	/* The folio is isolated and isolation code holds a folio reference. */
 	spin_unlock(vmf->ptl);
 	writable = false;
 
diff --git a/mm/memory.c b/mm/memory.c
index 118660de5bcc..4fd1ecfced4d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5207,8 +5207,6 @@ int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-	folio_get(folio);
-
 	/* Record the current PID acceesing VMA */
 	vma_set_access_pid_bit(vma);
 
@@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	else
 		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
-	if (target_nid == NUMA_NO_NODE) {
-		folio_put(folio);
+	if (target_nid == NUMA_NO_NODE)
+		goto out_map;
+	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
+		flags |= TNF_MIGRATE_FAIL;
 		goto out_map;
 	}
+	/* The folio is isolated and isolation code holds a folio reference. */
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	writable = false;
 	ignore_writable = true;
diff --git a/mm/migrate.c b/mm/migrate.c
index 0307b54879a0..27f070f64f27 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2530,9 +2530,37 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 	return __folio_alloc_node(gfp, order, nid);
 }
 
-static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
+/*
+ * Prepare for calling migrate_misplaced_folio() by isolating the folio if
+ * permitted. Must be called with the PTL still held.
+ */
+int migrate_misplaced_folio_prepare(struct folio *folio,
+		struct vm_area_struct *vma, int node)
 {
 	int nr_pages = folio_nr_pages(folio);
+	pg_data_t *pgdat = NODE_DATA(node);
+
+	if (folio_is_file_lru(folio)) {
+		/*
+		 * Do not migrate file folios that are mapped in multiple
+		 * processes with execute permissions as they are probably
+		 * shared libraries.
+		 *
+		 * See folio_likely_mapped_shared() on possible imprecision
+		 * when we cannot easily detect if a folio is shared.
+		 */
+		if ((vma->vm_flags & VM_EXEC) &&
+		    folio_likely_mapped_shared(folio))
+			return -EACCES;
+
+		/*
+		 * Do not migrate dirty folios as not all filesystems can move
+		 * dirty folios in MIGRATE_ASYNC mode which is a waste of
+		 * cycles.
+		 */
+		if (folio_test_dirty(folio))
+			return -EAGAIN;
+	}
 
 	/* Avoid migrating to a node that is nearly full */
 	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
@@ -2550,65 +2578,37 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
 		 * further.
 		 */
 		if (z < 0)
-			return 0;
+			return -EAGAIN;
 
 		wakeup_kswapd(pgdat->node_zones + z, 0,
 			      folio_order(folio), ZONE_MOVABLE);
-		return 0;
+		return -EAGAIN;
 	}
 
 	if (!folio_isolate_lru(folio))
-		return 0;
+		return -EAGAIN;
 
 	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
 			    nr_pages);
-
-	/*
-	 * Isolating the folio has taken another reference, so the
-	 * caller's reference can be safely dropped without the folio
-	 * disappearing underneath us during migration.
-	 */
-	folio_put(folio);
-	return 1;
+	return 0;
 }
 
 /*
  * Attempt to migrate a misplaced folio to the specified destination
- * node. Caller is expected to have an elevated reference count on
- * the folio that will be dropped by this function before returning.
+ * node. Caller is expected to have isolated the folio by calling
+ * migrate_misplaced_folio_prepare(), which will result in an
+ * elevated reference count on the folio. This function will un-isolate the
+ * folio, dereferencing the folio before returning.
  */
 int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 			    int node)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
-	int isolated;
 	int nr_remaining;
 	unsigned int nr_succeeded;
 	LIST_HEAD(migratepages);
 	int nr_pages = folio_nr_pages(folio);
 
-	/*
-	 * Don't migrate file folios that are mapped in multiple processes
-	 * with execute permissions as they are probably shared libraries.
-	 *
-	 * See folio_likely_mapped_shared() on possible imprecision when we
-	 * cannot easily detect if a folio is shared.
-	 */
-	if (folio_likely_mapped_shared(folio) && folio_is_file_lru(folio) &&
-	    (vma->vm_flags & VM_EXEC))
-		goto out;
-
-	/*
-	 * Also do not migrate dirty folios as not all filesystems can move
-	 * dirty folios in MIGRATE_ASYNC mode which is a waste of cycles.
-	 */
-	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
-		goto out;
-
-	isolated = numamigrate_isolate_folio(pgdat, folio);
-	if (!isolated)
-		goto out;
-
 	list_add(&folio->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
 				     NULL, node, MIGRATE_ASYNC,
@@ -2620,7 +2620,6 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 					folio_is_file_lru(folio), -nr_pages);
 			folio_putback_lru(folio);
 		}
-		isolated = 0;
 	}
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
@@ -2629,11 +2628,7 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 					    nr_succeeded);
 	}
 	BUG_ON(!list_empty(&migratepages));
-	return isolated ? 0 : -EAGAIN;
-
-out:
-	folio_put(folio);
-	return -EAGAIN;
+	return nr_remaining ? -EAGAIN : 0;
 }
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_NUMA */
-- 
2.45.2



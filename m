Return-Path: <linux-kernel+bounces-339704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E198694A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 00:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3901C21846
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5084D15696E;
	Wed, 25 Sep 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b96mvYb6"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A916C6B7
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727304462; cv=none; b=OZNvgOmJTY4qqI1GIVY2L+2A96BccJwpNWsXgTOPWc4wrktm3YjHl8Y4Fr/QehbAlqee/7aMBgiof4kv+u8t1kp7Kq4M3HXTImX6rN2u6bzY7BkKUjk+6gMGvc7OyqRUUwE/DFu7O2vY67V6odQVXyTmFM0QGf0/is3cXTCFbnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727304462; c=relaxed/simple;
	bh=1g4IdDRqJh6D2QlxKfW8as0oMlgwAnyNl6zJXteLUks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQHpOyBJJkIh+AZ+4b9NQlQBMejQhv2YhKeMoiOcP7ZmBnfBcLHyIFY8FLym5d3gzQlPNEZ/3XRqqj1a4tA9OvN5ich9qdbR9VhgF74X7l//x6tOmXjWNf+/q+lDNatDVUCFE6b84WrREyhy4POioHNf3RV95l8d/3heKYiDTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b96mvYb6; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727304458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slbZ9FKSwH6OAIBuSfcvPtxMsbwgB1Nos7HczeUcRQE=;
	b=b96mvYb6xAxPtPPb3lkOg3MmF6z+lRx20ztLlq+lEb6GvoxLsb5txOTLu2fQ0nNRYskp6j
	MXlHRTFvlL2g/67ij5+TC0d0ktcdzvREN/Ogrrl0x2xzD70paFu5oXoOQ5D0zDYq+9XLgl
	ySe24QdKOYsZ0zMIOw2wwx9WjVcHvd4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Omar Sandoval <osandov@osandov.com>,
	Chris Mason <clm@fb.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 2/2] mm: optimize invalidation of shadow entries
Date: Wed, 25 Sep 2024 15:47:16 -0700
Message-ID: <20240925224716.2904498-3-shakeel.butt@linux.dev>
In-Reply-To: <20240925224716.2904498-1-shakeel.butt@linux.dev>
References: <20240925224716.2904498-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The kernel invalidates the page cache in batches of PAGEVEC_SIZE. For
each batch, it traverses the page cache tree and collects the entries
(folio and shadow entries) in the struct folio_batch. For the shadow
entries present in the folio_batch, it has to traverse the page cache
tree for each individual entry to remove them. This patch optimize this
by removing them in a single tree traversal.

To evaluate the changes, we created 200GiB file on a fuse fs and in a
memcg. We created the shadow entries by triggering reclaim through
memory.reclaim in that specific memcg and measure the simple
fadvise(DONTNEED) operation.

 # time xfs_io -c 'fadvise -d 0 ${file_size}' file

              time (sec)
Without       5.12 +- 0.061
With-patch    4.19 +- 0.086 (18.16% decrease)

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---

Changes since v1:
- N/A

 mm/truncate.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 1d51c023d9c5..520c8cf8f58f 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -23,42 +23,28 @@
 #include <linux/rmap.h>
 #include "internal.h"
 
-/*
- * Regular page slots are stabilized by the page lock even without the tree
- * itself locked.  These unlocked entries need verification under the tree
- * lock.
- */
-static inline void __clear_shadow_entry(struct address_space *mapping,
-				pgoff_t index, void *entry)
-{
-	XA_STATE(xas, &mapping->i_pages, index);
-
-	xas_set_update(&xas, workingset_update_node);
-	if (xas_load(&xas) != entry)
-		return;
-	xas_store(&xas, NULL);
-}
-
 static void clear_shadow_entries(struct address_space *mapping,
-				 struct folio_batch *fbatch, pgoff_t *indices)
+				 unsigned long start, unsigned long max)
 {
-	int i;
+	XA_STATE(xas, &mapping->i_pages, start);
+	struct folio *folio;
 
 	/* Handled by shmem itself, or for DAX we do nothing. */
 	if (shmem_mapping(mapping) || dax_mapping(mapping))
 		return;
 
-	spin_lock(&mapping->host->i_lock);
-	xa_lock_irq(&mapping->i_pages);
+	xas_set_update(&xas, workingset_update_node);
 
-	for (i = 0; i < folio_batch_count(fbatch); i++) {
-		struct folio *folio = fbatch->folios[i];
+	spin_lock(&mapping->host->i_lock);
+	xas_lock_irq(&xas);
 
+	/* Clear all shadow entries from start to max */
+	xas_for_each(&xas, folio, max) {
 		if (xa_is_value(folio))
-			__clear_shadow_entry(mapping, indices[i], folio);
+			xas_store(&xas, NULL);
 	}
 
-	xa_unlock_irq(&mapping->i_pages);
+	xas_unlock_irq(&xas);
 	if (mapping_shrinkable(mapping))
 		inode_add_lru(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
@@ -481,7 +467,9 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 
 	folio_batch_init(&fbatch);
 	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		int nr = folio_batch_count(&fbatch);
+
+		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing folio->index */
@@ -508,7 +496,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 		}
 
 		if (xa_has_values)
-			clear_shadow_entries(mapping, &fbatch, indices);
+			clear_shadow_entries(mapping, indices[0], indices[nr-1]);
 
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
@@ -612,7 +600,9 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	folio_batch_init(&fbatch);
 	index = start;
 	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		int nr = folio_batch_count(&fbatch);
+
+		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing folio->index */
@@ -658,7 +648,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 		}
 
 		if (xa_has_values)
-			clear_shadow_entries(mapping, &fbatch, indices);
+			clear_shadow_entries(mapping, indices[0], indices[nr-1]);
 
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
-- 
2.43.5



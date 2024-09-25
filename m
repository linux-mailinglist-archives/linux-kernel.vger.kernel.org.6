Return-Path: <linux-kernel+bounces-339703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D50986949
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 00:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E6A284D52
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9FE15CD55;
	Wed, 25 Sep 2024 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="poOh5QVY"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C351155C82
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727304459; cv=none; b=qJxHo1n+4HfpgJT9PnIMIbSnxU2EulPejKHsbNAt73E5k+E5U4rmyc37jBDbzZ1c6L5QJiAkQOnXFF4xQfWHR+KrdHCjwoHU0sea/Wah7lF41bkg4D6ewYHNWPZQrAhurJybqfQjpZ43kuZnyCNUP8XLLbMsHTaxeR5g/hNWTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727304459; c=relaxed/simple;
	bh=KjmLV7WqS296Xi4O8B9vKhHEMe5ASci0o7Xfc5ngjh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md+0M33k0bbsZi+f5np0HU9GTisZT8Vzqgs0Nw16si2wBOaVxAqQiX5yKMU2d26OFGspN0vdFgZM1c0An7R7wAVA9PgZC4lfcsQ6zSHIYysGgLv5SnDA6H8u0UHqM15glhuNxLEqXCHBbKBmSNjbLdnvD3P73LO079/Q7T4YaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=poOh5QVY; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727304454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+3OMHz/a1Wuc/jYKVUdzYlQ51tOrama2GsuX31VDms=;
	b=poOh5QVY7GqwCIGs3N3EgUq00XLMjZVziVPSxT/oZnhktBQ98KhavI5/FmhMPdgT2NDmdX
	lYrvY/IXi0XwdZcdRgIshA4r1/ScVCRIQJPqZYEKtHPmNWQ0WHyaFJGaetAHpqy/sSFMYP
	mHZqHopFHnlCTGKvYkanahcImiiMTJA=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Omar Sandoval <osandov@osandov.com>,
	Chris Mason <clm@fb.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 1/2] mm: optimize truncation of shadow entries
Date: Wed, 25 Sep 2024 15:47:15 -0700
Message-ID: <20240925224716.2904498-2-shakeel.butt@linux.dev>
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

The kernel truncates the page cache in batches of PAGEVEC_SIZE. For each
batch, it traverses the page cache tree and collects the entries (folio
and shadow entries) in the struct folio_batch. For the shadow entries
present in the folio_batch, it has to traverse the page cache tree for
each individual entry to remove them. This patch optimize this by
removing them in a single tree traversal.

On large machines in our production which run workloads manipulating
large amount of data, we have observed that a large amount of CPUs are
spent on truncation of very large files (100s of GiBs file sizes). More
specifically most of time was spent on shadow entries cleanup, so
optimizing the shadow entries cleanup, even a little bit, has good
impact.

To evaluate the changes, we created 200GiB file on a fuse fs and in a
memcg. We created the shadow entries by triggering reclaim through
memory.reclaim in that specific memcg and measure the simple truncation
operation.

 # time truncate -s 0 file

              time (sec)
Without       5.164 +- 0.059
With-patch    4.21  +- 0.066 (18.47% decrease)

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---

Changes since v1:
- Added a comment on the assumption of indices array (Johannes)

 mm/truncate.c | 53 +++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd340a46..1d51c023d9c5 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -68,54 +68,53 @@ static void clear_shadow_entries(struct address_space *mapping,
  * Unconditionally remove exceptional entries. Usually called from truncate
  * path. Note that the folio_batch may be altered by this function by removing
  * exceptional entries similar to what folio_batch_remove_exceptionals() does.
+ * Please note that indices[] has entries in ascending order as guaranteed by
+ * either find_get_entries() or find_lock_entries().
  */
 static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 				struct folio_batch *fbatch, pgoff_t *indices)
 {
+	XA_STATE(xas, &mapping->i_pages, indices[0]);
+	int nr = folio_batch_count(fbatch);
+	struct folio *folio;
 	int i, j;
-	bool dax;
 
 	/* Handled by shmem itself */
 	if (shmem_mapping(mapping))
 		return;
 
-	for (j = 0; j < folio_batch_count(fbatch); j++)
+	for (j = 0; j < nr; j++)
 		if (xa_is_value(fbatch->folios[j]))
 			break;
 
-	if (j == folio_batch_count(fbatch))
+	if (j == nr)
 		return;
 
-	dax = dax_mapping(mapping);
-	if (!dax) {
-		spin_lock(&mapping->host->i_lock);
-		xa_lock_irq(&mapping->i_pages);
+	if (dax_mapping(mapping)) {
+		for (i = j; i < nr; i++) {
+			if (xa_is_value(fbatch->folios[i]))
+				dax_delete_mapping_entry(mapping, indices[i]);
+		}
+		goto out;
 	}
 
-	for (i = j; i < folio_batch_count(fbatch); i++) {
-		struct folio *folio = fbatch->folios[i];
-		pgoff_t index = indices[i];
-
-		if (!xa_is_value(folio)) {
-			fbatch->folios[j++] = folio;
-			continue;
-		}
+	xas_set(&xas, indices[j]);
+	xas_set_update(&xas, workingset_update_node);
 
-		if (unlikely(dax)) {
-			dax_delete_mapping_entry(mapping, index);
-			continue;
-		}
+	spin_lock(&mapping->host->i_lock);
+	xas_lock_irq(&xas);
 
-		__clear_shadow_entry(mapping, index, folio);
+	xas_for_each(&xas, folio, indices[nr-1]) {
+		if (xa_is_value(folio))
+			xas_store(&xas, NULL);
 	}
 
-	if (!dax) {
-		xa_unlock_irq(&mapping->i_pages);
-		if (mapping_shrinkable(mapping))
-			inode_add_lru(mapping->host);
-		spin_unlock(&mapping->host->i_lock);
-	}
-	fbatch->nr = j;
+	xas_unlock_irq(&xas);
+	if (mapping_shrinkable(mapping))
+		inode_add_lru(mapping->host);
+	spin_unlock(&mapping->host->i_lock);
+out:
+	folio_batch_remove_exceptionals(fbatch);
 }
 
 /**
-- 
2.43.5



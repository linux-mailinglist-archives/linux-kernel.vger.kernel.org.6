Return-Path: <linux-kernel+bounces-268634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5857C942726
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C16D283D11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5621A6193;
	Wed, 31 Jul 2024 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK8KjJ/l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52131A4F03
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408563; cv=none; b=XhddSJ3dh6sv2xX7cbnsShvDmYHTgmHFhtVkAc7rAqcAdoXVCb1b3DluO+gSOWobtUqoxp+3wHITkjGreGmi/pQyB8ntTIamknLOHjVQytRrs6ywrYxE4P5onjNaE4MTrgYvWPjF0yYdWGS1I+V8oFyCLKkR0Wuhlr6FUCux2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408563; c=relaxed/simple;
	bh=dTXhdRo4kj8AjPmtS92IPfvC0Tt9HRSF2uv8IzXug84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwHCR5cjVYCxMHC1ZIJxhUxqkR5bEpAp3kEQXkcIPcnqRAY4NAsreMZtnE/NSS3Y+8nq/pa7NzY/I5KiVTUtzQEoszwU4L6lr84n5kguE4HyZN1jrvtPf88fzteeQ63DTpM+xk7nyldlc5lsD03MZ1tQt119sq4+T4qYkIi/Isg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK8KjJ/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C8C116B1;
	Wed, 31 Jul 2024 06:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722408563;
	bh=dTXhdRo4kj8AjPmtS92IPfvC0Tt9HRSF2uv8IzXug84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gK8KjJ/ls7+wOOlC/d0FIoIXSj0R3NDeM9+iXvu+adQMveBC7Fw4bO4QtnnIORD7t
	 HUaqkSKzJ3O4YQGooMEdusu0u8qfpoUpzlmdWhcCXnhafPdp39veiPnVP4pFVj6eaC
	 Hypx12Tzh9rSc1aX45e+Kl/Ng6w495hCq3L9rZIDOoQso4g78OyJQbcYWeXWQ5GHH9
	 6VgkoFE2SXNqcZZiJV3hEhnax2ILh+N417/Re33nNrOxCA3Twr3F8+lVaqlhwkikqP
	 bn6Giz7nv1xSti5xL2dvq+0TrKdFxCVvQi6LVviMLQVcNQkX1FXlpdPVc3yZ7ZCwc/
	 S9uV63wbVZ7iQ==
From: chrisl@kernel.org
Date: Tue, 30 Jul 2024 23:49:18 -0700
Subject: [PATCH v5 6/9] mm: swap: allow cache reclaim to skip slot cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-swap-allocator-v5-6-cb9c148b9297@kernel.org>
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
In-Reply-To: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

From: Kairui Song <kasong@tencent.com>

Currently we free the reclaimed slots through slot cache even
if the slot is required to be empty immediately. As a result
the reclaim caller will see the slot still occupied even after a
successful reclaim, and need to keep reclaiming until slot cache
get flushed. This caused ineffective or over reclaim when SWAP is
under stress.

So introduce a new flag allowing the slot to be emptied bypassing
the slot cache.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 152 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 109 insertions(+), 43 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9b63b2262cc2..4c0fc0409d3c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -53,8 +53,15 @@
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
 static void free_swap_count_continuations(struct swap_info_struct *);
+static void swap_entry_range_free(struct swap_info_struct *si, swp_entry_t entry,
+				  unsigned int nr_pages);
 static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 			     unsigned int nr_entries);
+static bool folio_swapcache_freeable(struct folio *folio);
+static struct swap_cluster_info *lock_cluster_or_swap_info(
+		struct swap_info_struct *si, unsigned long offset);
+static void unlock_cluster_or_swap_info(struct swap_info_struct *si,
+					struct swap_cluster_info *ci);
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
@@ -129,8 +136,25 @@ static inline unsigned char swap_count(unsigned char ent)
  * corresponding page
  */
 #define TTRS_UNMAPPED		0x2
-/* Reclaim the swap entry if swap is getting full*/
+/* Reclaim the swap entry if swap is getting full */
 #define TTRS_FULL		0x4
+/* Reclaim directly, bypass the slot cache and don't touch device lock */
+#define TTRS_DIRECT		0x8
+
+static bool swap_is_has_cache(struct swap_info_struct *si,
+			      unsigned long offset, int nr_pages)
+{
+	unsigned char *map = si->swap_map + offset;
+	unsigned char *map_end = map + nr_pages;
+
+	do {
+		VM_BUG_ON(!(*map & SWAP_HAS_CACHE));
+		if (*map != SWAP_HAS_CACHE)
+			return false;
+	} while (++map < map_end);
+
+	return true;
+}
 
 /*
  * returns number of pages in the folio that backs the swap entry. If positive,
@@ -141,12 +165,22 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 				 unsigned long offset, unsigned long flags)
 {
 	swp_entry_t entry = swp_entry(si->type, offset);
+	struct address_space *address_space = swap_address_space(entry);
+	struct swap_cluster_info *ci;
 	struct folio *folio;
-	int ret = 0;
+	int ret, nr_pages;
+	bool need_reclaim;
 
-	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
+	folio = filemap_get_folio(address_space, swap_cache_index(entry));
 	if (IS_ERR(folio))
 		return 0;
+
+	/* offset could point to the middle of a large folio */
+	entry = folio->swap;
+	offset = swp_offset(entry);
+	nr_pages = folio_nr_pages(folio);
+	ret = -nr_pages;
+
 	/*
 	 * When this function is called from scan_swap_map_slots() and it's
 	 * called by vmscan.c at reclaiming folios. So we hold a folio lock
@@ -154,14 +188,50 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * case and you should use folio_free_swap() with explicit folio_lock()
 	 * in usual operations.
 	 */
-	if (folio_trylock(folio)) {
-		if ((flags & TTRS_ANYWAY) ||
-		    ((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
-		    ((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)))
-			ret = folio_free_swap(folio);
-		folio_unlock(folio);
+	if (!folio_trylock(folio))
+		goto out;
+
+	need_reclaim = ((flags & TTRS_ANYWAY) ||
+			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
+			((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)));
+	if (!need_reclaim || !folio_swapcache_freeable(folio))
+		goto out_unlock;
+
+	/*
+	 * It's safe to delete the folio from swap cache only if the folio's
+	 * swap_map is HAS_CACHE only, which means the slots have no page table
+	 * reference or pending writeback, and can't be allocated to others.
+	 */
+	ci = lock_cluster_or_swap_info(si, offset);
+	need_reclaim = swap_is_has_cache(si, offset, nr_pages);
+	unlock_cluster_or_swap_info(si, ci);
+	if (!need_reclaim)
+		goto out_unlock;
+
+	if (!(flags & TTRS_DIRECT)) {
+		/* Free through slot cache */
+		delete_from_swap_cache(folio);
+		folio_set_dirty(folio);
+		ret = nr_pages;
+		goto out_unlock;
 	}
-	ret = ret ? folio_nr_pages(folio) : -folio_nr_pages(folio);
+
+	xa_lock_irq(&address_space->i_pages);
+	__delete_from_swap_cache(folio, entry, NULL);
+	xa_unlock_irq(&address_space->i_pages);
+	folio_ref_sub(folio, nr_pages);
+	folio_set_dirty(folio);
+
+	spin_lock(&si->lock);
+	/* Only sinple page folio can be backed by zswap */
+	if (!nr_pages)
+		zswap_invalidate(entry);
+	swap_entry_range_free(si, entry, nr_pages);
+	spin_unlock(&si->lock);
+	ret = nr_pages;
+out_unlock:
+	folio_unlock(folio);
+out:
 	folio_put(folio);
 	return ret;
 }
@@ -903,7 +973,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	if (vm_swap_full() && si->swap_map[offset] == SWAP_HAS_CACHE) {
 		int swap_was_freed;
 		spin_unlock(&si->lock);
-		swap_was_freed = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
+		swap_was_freed = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY | TTRS_DIRECT);
 		spin_lock(&si->lock);
 		/* entry was freed successfully, try to use this again */
 		if (swap_was_freed > 0)
@@ -1340,9 +1410,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	unsigned long offset = swp_offset(entry);
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
-	unsigned char *map;
-	unsigned int i, free_entries = 0;
-	unsigned char val;
 	int size = 1 << swap_entry_order(folio_order(folio));
 
 	si = _swap_info_get(entry);
@@ -1350,23 +1417,14 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 		return;
 
 	ci = lock_cluster_or_swap_info(si, offset);
-	if (size > 1) {
-		map = si->swap_map + offset;
-		for (i = 0; i < size; i++) {
-			val = map[i];
-			VM_BUG_ON(!(val & SWAP_HAS_CACHE));
-			if (val == SWAP_HAS_CACHE)
-				free_entries++;
-		}
-		if (free_entries == size) {
-			unlock_cluster_or_swap_info(si, ci);
-			spin_lock(&si->lock);
-			swap_entry_range_free(si, entry, size);
-			spin_unlock(&si->lock);
-			return;
-		}
+	if (size > 1 && swap_is_has_cache(si, offset, size)) {
+		unlock_cluster_or_swap_info(si, ci);
+		spin_lock(&si->lock);
+		swap_entry_range_free(si, entry, size);
+		spin_unlock(&si->lock);
+		return;
 	}
-	for (i = 0; i < size; i++, entry.val++) {
+	for (int i = 0; i < size; i++, entry.val++) {
 		if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE)) {
 			unlock_cluster_or_swap_info(si, ci);
 			free_swap_slot(entry);
@@ -1526,16 +1584,7 @@ static bool folio_swapped(struct folio *folio)
 	return swap_page_trans_huge_swapped(si, entry, folio_order(folio));
 }
 
-/**
- * folio_free_swap() - Free the swap space used for this folio.
- * @folio: The folio to remove.
- *
- * If swap is getting full, or if there are no more mappings of this folio,
- * then call folio_free_swap to free its swap space.
- *
- * Return: true if we were able to release the swap space.
- */
-bool folio_free_swap(struct folio *folio)
+static bool folio_swapcache_freeable(struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -1543,8 +1592,6 @@ bool folio_free_swap(struct folio *folio)
 		return false;
 	if (folio_test_writeback(folio))
 		return false;
-	if (folio_swapped(folio))
-		return false;
 
 	/*
 	 * Once hibernation has begun to create its image of memory,
@@ -1564,6 +1611,25 @@ bool folio_free_swap(struct folio *folio)
 	if (pm_suspended_storage())
 		return false;
 
+	return true;
+}
+
+/**
+ * folio_free_swap() - Free the swap space used for this folio.
+ * @folio: The folio to remove.
+ *
+ * If swap is getting full, or if there are no more mappings of this folio,
+ * then call folio_free_swap to free its swap space.
+ *
+ * Return: true if we were able to release the swap space.
+ */
+bool folio_free_swap(struct folio *folio)
+{
+	if (!folio_swapcache_freeable(folio))
+		return false;
+	if (folio_swapped(folio))
+		return false;
+
 	delete_from_swap_cache(folio);
 	folio_set_dirty(folio);
 	return true;
@@ -1640,7 +1706,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 			 * to the next boundary.
 			 */
 			nr = __try_to_reclaim_swap(si, offset,
-					      TTRS_UNMAPPED | TTRS_FULL);
+						   TTRS_UNMAPPED | TTRS_FULL);
 			if (nr == 0)
 				nr = 1;
 			else if (nr < 0)

-- 
2.46.0.rc1.232.g9752f9e123-goog



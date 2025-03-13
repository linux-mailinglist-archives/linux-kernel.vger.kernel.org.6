Return-Path: <linux-kernel+bounces-560042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C60A5FCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1455919C231D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060A26B2D8;
	Thu, 13 Mar 2025 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOyYff/5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C126B2C8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885318; cv=none; b=MTFqkzlDGD/Gwtl7K1MSoXJWL2Hyl/x8O8uTYKMLHyt7iey/ZhPOPTpTs+NTs7dkENUZdCrekN6IVguGteStScfxA40xSgF801aFD8xohaJDf2pw/QOdcEAkNmCMpYaFDAwxlv/+pYmaQ7lLJCcMgV0i7ZdlKbk7HSlyK9c58k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885318; c=relaxed/simple;
	bh=7TXsLa16bJ6nmR8WrO2DF+DlGkQAGH19aQ1WgIJgf4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft8IdpBDUdvKGV9ta71knXXoIRzB7nu8nLtVPjGJ9nzZG8BTvOIOyJS4xE0XCm+zZF4hPZlzuTNFeYxgQNzNoP1jyzqdegq8O/+A7Y+sxbfgWvsPgxfCigUowVKFgay+RTugOEQjnTg8v3gzxS4P4uByY7MCZpJePnCjkxP4auQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOyYff/5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22113560c57so24799595ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741885315; x=1742490115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N6Z7115UVx6Vl+tDLjAm/FdoMPRDXf2lrj7KLmbVn88=;
        b=MOyYff/5rhyVKZH347pv4B5CcvlDEF30mDVOF2o7rAVrUTavMq9G48go5Io/Xp5p2W
         2Mgy1PoLhaMNzSXk27Y7sznxegZ/q6Aj+6AZ/HGpr3mr1udsSrQUablvHOrTnq4nvEX3
         bvO0/72ViLRFzwRGAQ94LpiYkxiRlD3TTDKPv7du4MS53YEQo1prmJgl8FNDyAyEQRHY
         d8cAsCDKg7ef0AY1YaF9iZw/GJozIa7sYOhUlJ4LlWHVZDeBNzTHHLgsjVAtwvulHMSi
         0uOZhbcB03Xf6R08/oiW3YyjrZP/TLmG/EGcZ9YFfBZM96k+URvd0MhKz47ydU/IjZvH
         CM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885315; x=1742490115;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6Z7115UVx6Vl+tDLjAm/FdoMPRDXf2lrj7KLmbVn88=;
        b=YEH4g89XkXmmpFBpckvdHCHSoB0BhKt5g91YFVrjC9GjLDZqDVcwQQW7Q/iJbE/rxR
         W3em7IgJrFQOAsCE+AX17p6PrAIvIyTqt6lBSl/f0EGoKlVavFumFK6qwlErL3faDxqb
         OyapLVVjCSi8rVUmqBiCFqi853r6DypkIHCdCnk7/3vM+KzgzruUg+pChykBAfCOVrVd
         UMPk6QgqJnMSYxwl/kASG4L3DFD6koNM/Jg+UmZwziIL9QTzwCWYW/kb9L8i597CXqmf
         WUySBKzHz1m8Fpz/Lp5rc3Tuv5qdU1CljYqgu23dZaaTh/Wmosx4B+ZHct1seUEP2vwA
         +x8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGbF495feIaMBzcGqDuvhqeWCR90pfD8J3PiArmyFcbJ9uKdcpnvEdMvqzr1S6ZCu+GQKxR5DODpw1PhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBCPhIxod5/B1KiYohutDc9oirrLSKQkGwPb1z1m8IVSgt+GpV
	y/DvzrO1ES8wCOelaq0EnZZw3qoWlRmAkzxtXpGOUmoTegk348A6
X-Gm-Gg: ASbGncv95xVhZYznKHUQ02liOC/YfsoyhkBaz33av15YtxCpASyG9l2OpNGLsZfJGiT
	wV2MC5Gpjwbui6s6/NxbZkm07DGipyXGFWzk1LbKZb4K6SYGs8KpkQqycT32z5WvL2H+UB6vvN5
	QAprTRMSc2D+35zQRfH6HhlIfKG7Ff2d43COn8+9ZZOZ+kJFHE/TGpydrBtz6WCpmi4sYErqsRg
	+c5+jj/N5/KkLZp3RNRJitqtTV+1jyvaSw+1xoxh7GDoUm9KWmQkDYUT90lsCh+hxTLu33deBBU
	WKp8x7kLPQ9RlN5g76qveVwsPhGwUh45QWNeBUPGGYdE8kJyYAbN9YOlHDRVmTUgag==
X-Google-Smtp-Source: AGHT+IGFqZ5LNoVkmizf8XxxIrr2WieCKS2BNmYocBIQLWMsAOjYTWAUqhLCVcG6WQw9yTbXp2I88g==
X-Received: by 2002:a17:902:f605:b0:220:cd9a:a167 with SMTP id d9443c01a7336-225dd822bbdmr4475895ad.4.1741885315030;
        Thu, 13 Mar 2025 10:01:55 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167df0esm1613529b3a.93.2025.03.13.10.01.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Mar 2025 10:01:54 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 7/7] mm, swap: simplify folio swap allocation
Date: Fri, 14 Mar 2025 00:59:35 +0800
Message-ID: <20250313165935.63303-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313165935.63303-1-ryncsn@gmail.com>
References: <20250313165935.63303-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

With slot cache gone, clean up the allocation helpers even more.
folio_alloc_swap will be the only entry for allocation and adding the
folio to swap cache (except suspend), making it opposite of
folio_free_swap.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   8 ++--
 mm/shmem.c           |  21 +++-----
 mm/swap.h            |   6 ---
 mm/swap_state.c      |  57 ----------------------
 mm/swapfile.c        | 111 ++++++++++++++++++++++++++++---------------
 mm/vmscan.c          |  16 ++++++-
 6 files changed, 95 insertions(+), 124 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index c5856dcc263a..9c99eee160f9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -478,7 +478,7 @@ static inline long get_nr_swap_pages(void)
 }
 
 extern void si_swapinfo(struct sysinfo *);
-swp_entry_t folio_alloc_swap(struct folio *folio);
+int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask);
 bool folio_free_swap(struct folio *folio);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
@@ -586,11 +586,9 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
-static inline swp_entry_t folio_alloc_swap(struct folio *folio)
+static inline int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
 {
-	swp_entry_t entry;
-	entry.val = 0;
-	return entry;
+	return -EINVAL;
 }
 
 static inline bool folio_free_swap(struct folio *folio)
diff --git a/mm/shmem.c b/mm/shmem.c
index 1eed26bf8ae5..7b738d8d6581 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1546,7 +1546,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-	swp_entry_t swap;
 	pgoff_t index;
 	int nr_pages;
 	bool split = false;
@@ -1628,14 +1627,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		folio_mark_uptodate(folio);
 	}
 
-	swap = folio_alloc_swap(folio);
-	if (!swap.val) {
-		if (nr_pages > 1)
-			goto try_split;
-
-		goto redirty;
-	}
-
 	/*
 	 * Add inode to shmem_unuse()'s list of swapped-out inodes,
 	 * if it's not already there.  Do it now before the folio is
@@ -1648,20 +1639,20 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if (list_empty(&info->swaplist))
 		list_add(&info->swaplist, &shmem_swaplist);
 
-	if (add_to_swap_cache(folio, swap,
-			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
-			NULL) == 0) {
+	if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
 		shmem_recalc_inode(inode, 0, nr_pages);
-		swap_shmem_alloc(swap, nr_pages);
-		shmem_delete_from_page_cache(folio, swp_to_radix_entry(swap));
+		swap_shmem_alloc(folio->swap, nr_pages);
+		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
 		mutex_unlock(&shmem_swaplist_mutex);
 		BUG_ON(folio_mapped(folio));
 		return swap_writepage(&folio->page, wbc);
 	}
 
+	list_del_init(&info->swaplist);
 	mutex_unlock(&shmem_swaplist_mutex);
-	put_swap_folio(folio, swap);
+	if (nr_pages > 1)
+		goto try_split;
 redirty:
 	folio_mark_dirty(folio);
 	if (wbc->for_reclaim)
diff --git a/mm/swap.h b/mm/swap.h
index ad2f121de970..0abb68091b4f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -50,7 +50,6 @@ static inline pgoff_t swap_cache_index(swp_entry_t entry)
 }
 
 void show_swap_cache_info(void);
-bool add_to_swap(struct folio *folio);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
 int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 		      gfp_t gfp, void **shadowp);
@@ -163,11 +162,6 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 	return filemap_get_folio(mapping, index);
 }
 
-static inline bool add_to_swap(struct folio *folio)
-{
-	return false;
-}
-
 static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
 {
 	return NULL;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2b5744e211cd..68fd981b514f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -166,63 +166,6 @@ void __delete_from_swap_cache(struct folio *folio,
 	__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
 }
 
-/**
- * add_to_swap - allocate swap space for a folio
- * @folio: folio we want to move to swap
- *
- * Allocate swap space for the folio and add the folio to the
- * swap cache.
- *
- * Context: Caller needs to hold the folio lock.
- * Return: Whether the folio was added to the swap cache.
- */
-bool add_to_swap(struct folio *folio)
-{
-	swp_entry_t entry;
-	int err;
-
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
-
-	entry = folio_alloc_swap(folio);
-	if (!entry.val)
-		return false;
-
-	/*
-	 * XArray node allocations from PF_MEMALLOC contexts could
-	 * completely exhaust the page allocator. __GFP_NOMEMALLOC
-	 * stops emergency reserves from being allocated.
-	 *
-	 * TODO: this could cause a theoretical memory reclaim
-	 * deadlock in the swap out path.
-	 */
-	/*
-	 * Add it to the swap cache.
-	 */
-	err = add_to_swap_cache(folio, entry,
-			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL);
-	if (err)
-		goto fail;
-	/*
-	 * Normally the folio will be dirtied in unmap because its
-	 * pte should be dirty. A special case is MADV_FREE page. The
-	 * page's pte could have dirty bit cleared but the folio's
-	 * SwapBacked flag is still set because clearing the dirty bit
-	 * and SwapBacked flag has no lock protected. For such folio,
-	 * unmap will not set dirty bit for it, so folio reclaim will
-	 * not write the folio out. This can cause data corruption when
-	 * the folio is swapped in later. Always setting the dirty flag
-	 * for the folio solves the problem.
-	 */
-	folio_mark_dirty(folio);
-
-	return true;
-
-fail:
-	put_swap_folio(folio, entry);
-	return false;
-}
-
 /*
  * This must be called only on folios that have
  * been verified to be in the swap cache and locked.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9bd95173865d..2eff8b51a945 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1176,9 +1176,8 @@ static bool get_swap_device_info(struct swap_info_struct *si)
  * Fast path try to get swap entries with specified order from current
  * CPU's swap entry pool (a cluster).
  */
-static int swap_alloc_fast(swp_entry_t *entry,
-			   unsigned char usage,
-			   int order)
+static bool swap_alloc_fast(swp_entry_t *entry,
+			    int order)
 {
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
@@ -1197,7 +1196,7 @@ static int swap_alloc_fast(swp_entry_t *entry,
 	if (cluster_is_usable(ci, order)) {
 		if (cluster_is_empty(ci))
 			offset = cluster_offset(si, ci);
-		found = alloc_swap_scan_cluster(si, ci, offset, order, usage);
+		found = alloc_swap_scan_cluster(si, ci, offset, order, SWAP_HAS_CACHE);
 		if (found)
 			*entry = swp_entry(si->type, found);
 	} else {
@@ -1208,47 +1207,30 @@ static int swap_alloc_fast(swp_entry_t *entry,
 	return !!found;
 }
 
-swp_entry_t folio_alloc_swap(struct folio *folio)
+/* Rotate the device and switch to a new cluster */
+static bool swap_alloc_slow(swp_entry_t *entry,
+			    int order)
 {
-	unsigned int order = folio_order(folio);
-	unsigned int size = 1 << order;
-	struct swap_info_struct *si, *next;
-	swp_entry_t entry = {};
-	unsigned long offset;
 	int node;
+	unsigned long offset;
+	struct swap_info_struct *si, *next;
 
-	if (order) {
-		/*
-		 * Should not even be attempting large allocations when huge
-		 * page swap is disabled. Warn and fail the allocation.
-		 */
-		if (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUSTER) {
-			VM_WARN_ON_ONCE(1);
-			return entry;
-		}
-	}
-
-	/* Fast path using percpu cluster */
-	local_lock(&percpu_swap_cluster.lock);
-	if (swap_alloc_fast(&entry, SWAP_HAS_CACHE, order))
-		goto out;
-
-	/* Rotate the device and switch to a new cluster */
+	node = numa_node_id();
 	spin_lock(&swap_avail_lock);
 start_over:
-	node = numa_node_id();
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
+		/* Rotate the device and switch to a new cluster */
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
 			offset = cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE);
 			put_swap_device(si);
 			if (offset) {
-				entry = swp_entry(si->type, offset);
-				goto out;
+				*entry = swp_entry(si->type, offset);
+				return true;
 			}
 			if (order)
-				goto out;
+				return false;
 		}
 
 		spin_lock(&swap_avail_lock);
@@ -1267,16 +1249,67 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 			goto start_over;
 	}
 	spin_unlock(&swap_avail_lock);
-out:
+	return false;
+}
+
+/**
+ * folio_alloc_swap - allocate swap space for a folio
+ * @folio: folio we want to move to swap
+ * @gfp: gfp mask for shadow nodes
+ *
+ * Allocate swap space for the folio and add the folio to the
+ * swap cache.
+ *
+ * Context: Caller needs to hold the folio lock.
+ * Return: Whether the folio was added to the swap cache.
+ */
+int folio_alloc_swap(struct folio *folio, gfp_t gfp)
+{
+	unsigned int order = folio_order(folio);
+	unsigned int size = 1 << order;
+	swp_entry_t entry = {};
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
+
+	/*
+	 * Should not even be attempting large allocations when huge
+	 * page swap is disabled. Warn and fail the allocation.
+	 */
+	if (order && (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUSTER)) {
+		VM_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	local_lock(&percpu_swap_cluster.lock);
+	if (!swap_alloc_fast(&entry, order))
+		swap_alloc_slow(&entry, order);
 	local_unlock(&percpu_swap_cluster.lock);
+
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		put_swap_folio(folio, entry);
-		entry.val = 0;
-	}
-	if (entry.val)
-		atomic_long_sub(size, &nr_swap_pages);
-	return entry;
+	if (mem_cgroup_try_charge_swap(folio, entry))
+		goto out_free;
+
+	if (!entry.val)
+		return -ENOMEM;
+
+	/*
+	 * XArray node allocations from PF_MEMALLOC contexts could
+	 * completely exhaust the page allocator. __GFP_NOMEMALLOC
+	 * stops emergency reserves from being allocated.
+	 *
+	 * TODO: this could cause a theoretical memory reclaim
+	 * deadlock in the swap out path.
+	 */
+	if (add_to_swap_cache(folio, entry, gfp | __GFP_NOMEMALLOC, NULL))
+		goto out_free;
+
+	atomic_long_sub(size, &nr_swap_pages);
+	return 0;
+
+out_free:
+	put_swap_folio(folio, entry);
+	return -ENOMEM;
 }
 
 static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 84ec20f12200..2bc740637a6c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1289,7 +1289,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					    split_folio_to_list(folio, folio_list))
 						goto activate_locked;
 				}
-				if (!add_to_swap(folio)) {
+				if (folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOWARN)) {
 					int __maybe_unused order = folio_order(folio);
 
 					if (!folio_test_large(folio))
@@ -1305,9 +1305,21 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					}
 #endif
 					count_mthp_stat(order, MTHP_STAT_SWPOUT_FALLBACK);
-					if (!add_to_swap(folio))
+					if (folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOWARN))
 						goto activate_locked_split;
 				}
+				/*
+				 * Normally the folio will be dirtied in unmap because its
+				 * pte should be dirty. A special case is MADV_FREE page. The
+				 * page's pte could have dirty bit cleared but the folio's
+				 * SwapBacked flag is still set because clearing the dirty bit
+				 * and SwapBacked flag has no lock protected. For such folio,
+				 * unmap will not set dirty bit for it, so folio reclaim will
+				 * not write the folio out. This can cause data corruption when
+				 * the folio is swapped in later. Always setting the dirty flag
+				 * for the folio solves the problem.
+				 */
+				folio_mark_dirty(folio);
 			}
 		}
 
-- 
2.48.1



Return-Path: <linux-kernel+bounces-515462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA24A36520
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40613AF305
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5630269B18;
	Fri, 14 Feb 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed6ki5wb"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079D269B0B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555939; cv=none; b=fpbmc2cgNLZiCiMfuzUxagCTCSlGHEYnqKEEQr7rIutMzJV1CtuQG7jwZg4Qvx47iXb0pDj0CfH64BkUFyiELsBvFX4VLVi6DOaoS4DRUw6ZCz+9YjouEv2/cVK1xKqynxp5SE40E1UsdvpZA2xt69psVytUf+eJfp6me6zcS6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555939; c=relaxed/simple;
	bh=Ii4C2B8Q05zbNYVU3US5x/Ud4xWKaB+IajjZ4KoJVgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSXtAKfa+DkcDNm9HsKkUubQ64RxdvruePqA3AapQy1iwQuLxovQYHa1yXSGg6OtXcYSaeuNLnF2PIsfCjD8bIcwr08jwd+rOJd3Ov5w1+pvyxgGu9Lvl0YL2XRt6qVOeiTN/4TWq++9+AHRM7kJVm9nEbHGGFkvh4KGNR8SncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed6ki5wb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c8eb195aso47559605ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555937; x=1740160737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g131YEqRMfLTVZhTMtUAtQy5KjWaVYxNxWGQgGzsAzk=;
        b=Ed6ki5wbfxbRIHKa4Zm/3p9mABAupYnvRmWqboTOacJ40uCkGmWRmAyhIWhmUOeZY5
         j/gHyx7b7dRJGFq8LMGrwl9mAjOaj+Nm+/qqDD4jZq9kKQI263o4qwfjXJDEQvfL+bK+
         2R1Y30gvYiy8cb4jvtUDUU14VQ3ph9WyQAtOtjooQJXMq6fozJrcc8chpw7ZRqyTVSaT
         7AajcAUxhtDR9eUjpZ8S+ZGiggtWM7xeUchFcu55nYPrOrlsAeP0ASpkVmmuoy7WdgZU
         OJ4/1ggZse8L6YNLldH8vOeljJ1/T0tixTVVGSeNq99ucbRFEQSSzLXoD772ha/2vw+6
         4CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555937; x=1740160737;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g131YEqRMfLTVZhTMtUAtQy5KjWaVYxNxWGQgGzsAzk=;
        b=SKj/V+1OjGjFo21FfCMSHTIRiy8MpkwdxYpYggSbc5319Krj7E2B33VL8f1FpbK0iY
         GX/ZoHN3rCXORvl0VCTU1mLXOIbTOHQPBGi2SC38CoPl3upAFVOCnEHfY01AAF+WuUqn
         /6JalCDoJPpAjuhGoL7PLh6EasgeFa9n9slz7gBjtCiQ9eT+Npghc+q/TUl7g/rqP2uD
         k/e0yT3rd2Xzrx6azaI/iYTmxU+G8qBX4bE8lGUrU8OJgqXEzigNX5kftxTWi92poetB
         tLUIDhzUczrcMDYCutpkDlibNqFmsr3Ujv6Tys2okArIePc7GMrqZ6L3aW29c19tEpYo
         +cUA==
X-Forwarded-Encrypted: i=1; AJvYcCVvXdZxhadiKXQoKb2M9hZ68o3kbCpx4UfuATCGxU61lf4pJ+9rvQSxOU0rHmqp5LH2eOO34Fy1lV3ozQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygjiRQ9ww2Q7eOgE9hYb+PrwxcAxI8L73j49tgmYQXhkv/4mU/
	cpRDfTz5rNDn6XDdpNNeH/3gNbIvMZu1O4XjDh1q81RWeeyPCS4y
X-Gm-Gg: ASbGncvfyvr+5G1RQJiBcm8MdXUqvpurjtJlGctnHztPPRD9TyVG9afJoCzLQycjEzQ
	Fq+ns4bXC6VVBb284Fxi1uaO7b1YwKFwLWpZQFsr567MrVko7YaW9doY/fLYzxxzkxnfkBET0o3
	56O3hV8Xi6PN6sc2GVKu6FHWnZiERoomdfBmmlVPSU9CtA4DEX8U35MOCQkiC71FtSVfxAlkIAZ
	joqF6NAijnjtJR47mAaEtt4vaYILxlxjkBn/dNehnXrxYcXYC4LPYfp5v0XXX0f303YabTf5tSB
	F6aIHuR0SfayM6D6IY02DzWFCUKeXTWni4iM
X-Google-Smtp-Source: AGHT+IEBFWRSKG7OwZIbmlb93b7xdfMca6gf2NNi7p6B/FLu0eRP37//Pl09ZSVseFox+/txo2Nx6Q==
X-Received: by 2002:a17:902:d483:b0:215:6e01:ad07 with SMTP id d9443c01a7336-22103efb5b1mr2464155ad.6.1739555937010;
        Fri, 14 Feb 2025 09:58:57 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55943b5sm31216605ad.246.2025.02.14.09.58.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 09:58:56 -0800 (PST)
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
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 7/7] mm, swap: simplify folio swap allocation
Date: Sat, 15 Feb 2025 01:57:09 +0800
Message-ID: <20250214175709.76029-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214175709.76029-1-ryncsn@gmail.com>
References: <20250214175709.76029-1-ryncsn@gmail.com>
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
folio_alloc_swap will be the only entry for allocation and adding
the folio to swap cache (except suspend), making it opposite of
folio_free_swap.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   8 ++--
 mm/shmem.c           |  21 +++------
 mm/swap.h            |   6 ---
 mm/swap_state.c      |  57 ----------------------
 mm/swapfile.c        | 110 ++++++++++++++++++++++++++++---------------
 mm/vmscan.c          |  16 ++++++-
 6 files changed, 94 insertions(+), 124 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 456833705ea0..e799e965dac8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -478,7 +478,7 @@ static inline long get_nr_swap_pages(void)
 }
 
 extern void si_swapinfo(struct sysinfo *);
-swp_entry_t folio_alloc_swap(struct folio *folio);
+bool folio_alloc_swap(struct folio *folio, gfp_t gfp_mask);
 bool folio_free_swap(struct folio *folio);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
@@ -587,11 +587,9 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
-static inline swp_entry_t folio_alloc_swap(struct folio *folio)
+static bool folio_alloc_swap(struct folio *folio, gfp_t gfp_mask);
 {
-	swp_entry_t entry;
-	entry.val = 0;
-	return entry;
+	return false;
 }
 
 static inline bool folio_free_swap(struct folio *folio)
diff --git a/mm/shmem.c b/mm/shmem.c
index b35ba250c53d..2aa206b52ff2 100644
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
+	if (folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
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
index 66c8869ef346..8449bd703bd8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1181,9 +1181,9 @@ static bool get_swap_device_info(struct swap_info_struct *si)
  * Fast path try to get swap entries with specified order from current
  * CPU's swap entry pool (a cluster).
  */
-static int swap_alloc_fast(swp_entry_t *entry,
-			   unsigned char usage,
-			   int order)
+static bool swap_alloc_fast(swp_entry_t *entry,
+			    unsigned char usage,
+			    int order)
 {
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
@@ -1203,47 +1203,31 @@ static int swap_alloc_fast(swp_entry_t *entry,
 	return !!found;
 }
 
-swp_entry_t folio_alloc_swap(struct folio *folio)
+/* Rotate the device and switch to a new cluster */
+static bool swap_alloc_rotate(swp_entry_t *entry,
+			      unsigned char usage,
+			      int order)
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
-		goto out_alloced;
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
-				goto out_alloced;
+				*entry = swp_entry(si->type, offset);
+				return true;
 			}
 			if (order)
-				goto out_failed;
+				return false;
 		}
 
 		spin_lock(&swap_avail_lock);
@@ -1262,20 +1246,68 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 			goto start_over;
 	}
 	spin_unlock(&swap_avail_lock);
-out_failed:
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
+bool folio_alloc_swap(struct folio *folio, gfp_t gfp)
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
+		return false;
+	}
+
+	local_lock(&percpu_swap_cluster.lock);
+	if (swap_alloc_fast(&entry, SWAP_HAS_CACHE, order))
+		goto out_alloced;
+	if (swap_alloc_rotate(&entry, SWAP_HAS_CACHE, order))
+		goto out_alloced;
 	local_unlock(&percpu_swap_cluster.lock);
-	return entry;
+	return false;
 
 out_alloced:
 	local_unlock(&percpu_swap_cluster.lock);
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		put_swap_folio(folio, entry);
-		entry.val = 0;
-	} else {
-		atomic_long_sub(size, &nr_swap_pages);
-	}
+	if (mem_cgroup_try_charge_swap(folio, entry))
+		goto out_free;
 
-	return entry;
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
+	return true;
+
+out_free:
+	put_swap_folio(folio, entry);
+	return false;
 }
 
 static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fcca38bc640f..71a6b597e469 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1289,7 +1289,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					    split_folio_to_list(folio, folio_list))
 						goto activate_locked;
 				}
-				if (!add_to_swap(folio)) {
+				if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOWARN)) {
 					int __maybe_unused order = folio_order(folio);
 
 					if (!folio_test_large(folio))
@@ -1305,9 +1305,21 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					}
 #endif
 					count_mthp_stat(order, MTHP_STAT_SWPOUT_FALLBACK);
-					if (!add_to_swap(folio))
+					if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOWARN))
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



Return-Path: <linux-kernel+bounces-529760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADFFA42A97
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826FA7A9E38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C225A65E;
	Mon, 24 Feb 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8SRc0eA"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D4265CB9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420201; cv=none; b=pQLMO8pas7vn4JVi2KHhTvlsmnFd5lBFbJwhGJVRj9N7H5Oi4i54VJ8axMLGspLLAZc7weI+5+1eQTV80xH5+VVIZrIzcH6t8STxUlt0yvoFDqabLLVBPzHSW9a+l0UVLeBY5eyc8eTzw0yCgSZoVJFFKMqSVUdvLxcAE08b+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420201; c=relaxed/simple;
	bh=ib4lDZF59793HGLQr65XX1VChB0fF9pxuSCAzGY0fJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbRz46nihMEAJ61C4+r85x89SxaBCGSWEwMZmJc4e9DoUziQ7IoXFvbh1LvBFE8D9TljCOoj3iPCnbaStGzTPUhK+GZuzh5664pLP+7UzNUiRfAcK22Arx18d2m/eo1q9Sv9Fio86UKOvNOEcyVx0u76PnmX2Buu5UJNlG2YJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8SRc0eA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c92c857aso81046165ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740420198; x=1741024998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0F3kezvsTBdwcMP4/p3aFmc/96fOBXv0a/r8BX7g49c=;
        b=d8SRc0eAmn2yrRruw/KR+qCLP1lZOhP5l5fGZEE2vhguzV9dHYckgK7T/WXekTpbSm
         9wO6oyqmNagUTlKuI8WGv6dtxkxqRXITW/WUUCzTRbl0iSbDMOI71ZBFpZFXFKRStCOZ
         dpRkKNmVC28G0WXH2keZn5zhcc8zdRklO4YPZGw21APRaTAhp2xVLiNkJfshYvWqJE8c
         3UzNoCYb+Kiw2Ntj5e+2fE9BYk4LLf7xgbmDnUD7GbNdrNIp2JDUqWcQVURdG23mg6DD
         BNXYVVCxhyIs3E/zGtDcAeLywrh8rvZV6ygDo+dmvcIZfA48Y8GUG/06sLIXZutrkMXh
         I79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420198; x=1741024998;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0F3kezvsTBdwcMP4/p3aFmc/96fOBXv0a/r8BX7g49c=;
        b=lhUDFwzVvrwZFfq4V30rcW8Ux4lEjORm+C2ajYNC4ozzoX2rqIOPU8HMqecBuYC8Jx
         fq9w086qSoBNFV84mEI0tvvIkA4ff6GJhXrD3YDw8QXmpWRFF4CLsJ7r5o0VtBRtGSgC
         6zF9fybcyCt8pg2fChvBk3wsJPXVw+zIUtKckXVPEUax5QAKmItA0YZj5yjAZmQPre5f
         sksfltC9Atr2hGhhKOLoW+110MNng2wvhYZ8KkO6yv+nLBDumPUMhI6LLUSDayymur0m
         t1/f+IRSIOE1jO47qx7j1Pt3m1Zb8yrcbvsYAMDqj+tBA/CtwcnZKLjQJ22osdFCzaLi
         x8HA==
X-Forwarded-Encrypted: i=1; AJvYcCVMMfytLUsjQSNX90RSr5d0QvT5J2PPAKnuvfQuA6xQSp1c99C86Ayzqt8Zd3tzvRv/ex4O5ruv1X9+QC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0wuEhGr/pVOt1jN3rlu3oMUXHBCjbYerJ0eV0RaQzKqT+S/z
	qH2y6Mu3mbqkyQHXKUZ4I9YlOKk9WKREOfhxOIcKlP5TnKqN2/Al
X-Gm-Gg: ASbGncuCKRTrK8KanX8nJ5Z382XRXXwjfI57dHVzJ7XXQ951DUIBiKxpAdeH2PXwtYH
	S0A7zVP/mhzRkdRkkkgrAZCX/e38ZsCb9zHSP9lEsniWmB1Lvua20Z09zda8Nzr6E88w/WqImjj
	7NTQTGo8Y2An53qrk4OPt+AAGBsZMy+Xe6zlB0JfGVpnnwc0GGnofyss4lQe5ml1PGN0ubiNyE1
	xVKzJZX5iMf48O4J+EH4M1h4koKBQfsdxf/D3H/0QmsC8R29E9WSZ5wssaTbxbg58Ien28749Rp
	nFwCgT6MmCpIdAgfyPr5rvXWdu1UNOHhqcDJp9njujkp
X-Google-Smtp-Source: AGHT+IFXam9uJQZb5hs3Hxkm0TWEoFuaGqLoECsuP+xjMxnP1x5Le2+i2A4Hq3TcsdGNfTd3wjKQnQ==
X-Received: by 2002:a17:902:fc4e:b0:21f:4c8b:c4da with SMTP id d9443c01a7336-2219fff87cbmr242938105ad.18.1740420197211;
        Mon, 24 Feb 2025 10:03:17 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([1.203.117.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556e15esm184834695ad.190.2025.02.24.10.03.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 10:03:16 -0800 (PST)
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
Subject: [PATCH v2 7/7] mm, swap: simplify folio swap allocation
Date: Tue, 25 Feb 2025 02:02:12 +0800
Message-ID: <20250224180212.22802-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180212.22802-1-ryncsn@gmail.com>
References: <20250224180212.22802-1-ryncsn@gmail.com>
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
index a0a262bcaf41..3a68da686c4e 100644
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
@@ -587,11 +587,9 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
-static inline swp_entry_t folio_alloc_swap(struct folio *folio)
+static int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
 {
-	swp_entry_t entry;
-	entry.val = 0;
-	return entry;
+	return -EINVAL;
 }
 
 static inline bool folio_free_swap(struct folio *folio)
diff --git a/mm/shmem.c b/mm/shmem.c
index 45dbcb69da0c..aad02132b75a 100644
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
index 1ba916109d99..628f67974a7c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1174,9 +1174,9 @@ static bool get_swap_device_info(struct swap_info_struct *si)
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
@@ -1206,47 +1206,31 @@ static int swap_alloc_fast(swp_entry_t *entry,
 	return !!found;
 }
 
-swp_entry_t folio_alloc_swap(struct folio *folio)
+/* Rotate the device and switch to a new cluster */
+static bool swap_alloc_slow(swp_entry_t *entry,
+			    unsigned char usage,
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
@@ -1265,20 +1249,68 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
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
+	if (swap_alloc_fast(&entry, SWAP_HAS_CACHE, order))
+		goto out_alloced;
+	if (swap_alloc_slow(&entry, SWAP_HAS_CACHE, order))
+		goto out_alloced;
 	local_unlock(&percpu_swap_cluster.lock);
-	return entry;
+	return -ENOMEM;
 
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
+	return 0;
+
+out_free:
+	put_swap_folio(folio, entry);
+	return -ENOMEM;
 }
 
 static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fcca38bc640f..be00af3763b5 100644
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



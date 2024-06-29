Return-Path: <linux-kernel+bounces-234906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2D91CC43
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F981C2129B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1564AEE9;
	Sat, 29 Jun 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqB+G6of"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A344F602
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719659451; cv=none; b=uhMEpctCpsaqyvem+9XUmYMs212B08IXRMLbjaSskdJqG9TRRkzSGYjdKaE7c/yP21NodsML+Vqyh8kVlKM2TidGAmnHQFN3m5IRt1nzJcGvqLQTwMCLCZ4BCLkU74CbmkTC9b/uIsA1P9pROTmiBKsR2fs94qToCqEzys4K3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719659451; c=relaxed/simple;
	bh=yMsRn7OCEWYdi+JWN7AzD0V2nZ3S/yW72D6bET0YZ7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uuDY8mfRhHcEASkVXuzI0LNRob8OL/dQ2y9EOChxZnEmKii2fvJPo14qYBDbmRKKmkpVeulyWoBBSzxQfoJYyNr21YN1DaZnnooajT3rwKmJ7j3xGwif/96tTqHjN/2bpB48CAaQlI7EtDZBIjOOK8U/TlsawQwWcDuzp1M4Rq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqB+G6of; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1faad2f1967so19615605ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719659449; x=1720264249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ew+Hn1X3ubfi24qMFkHWDEj0VD3/JfMS/ycW8uy8Ae0=;
        b=FqB+G6ofu3YyEDH9AnplxklOs8pZg2dSnv8NHgjp24Y0RW9hBGCIawpFBlag75A+st
         /lAyvnJogBr4UZsHpFUIX5CWsj1LUTIafZ0tONWQ7lFlNBxooweVuRgygEIGkBVgIXkv
         XUarbkbRA8a+8l//fWdv7zezNTgVv1D71zW7G5eV1l4z5oj2fRxZa1N/mbB5rK1g0o3P
         mHUZKIvp225RDtwiCGWGavWy1hstqbfBrKq8H6Z5CCkzFvmaSOxA4vN9DmT9xpRxKPWD
         5jb1xz6rfT5VeYAf+5jIuZvrvTQKPbTH2PMTXitBFkivAsv3isj/O9PgJcpnHqHtNEeQ
         cxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719659449; x=1720264249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ew+Hn1X3ubfi24qMFkHWDEj0VD3/JfMS/ycW8uy8Ae0=;
        b=KAj8mw6hoCRz0EEW6O+FLKVfobhnAysSrQ5XkzYbtBE1MB+wTg7AvH8hSTw0yy6BUl
         ln8EW8GdNYJ+DeEioMTgKXD9MGDtdCwXGxKwCQxlPYtg2orQLMhH0UnBZh7k+WeRhylx
         lN+ALZmIi8QLryZF53LyeP1vF6rmx6Y+a47ASvzf+BVqkgXTvcCCJ4bsHDImoVh++xkt
         Cs5HI0IHDpOH7cSW+CWopgIU9Ggu6JsZ4OsPcsobxC96RZm1Exl1hYaRtLf3pAzN4GAU
         Xr32VxPIRi2l8PeBQD2yhz9U6zEw4GpyhojYBEyVqmduHpF7tzlQFiBle7p90r/vegTl
         oYjw==
X-Forwarded-Encrypted: i=1; AJvYcCXHwzuRz1rQjIkHoRNu5h02CnqU3BcNEd08obyxISx8ncxAMCNT9ja+V/OGL+NqMIodmaOFbWxNyMFZI78WeuQMPcTxUnKGEFBhvK3m
X-Gm-Message-State: AOJu0Yxrl1/LdrPly/EDXIrjFjLvAi5U9eKwB8zzwIJIZieZa0NT7N86
	VDo4BBlTjQguajseFb4JulxUKO0ud3UYVLeCEFUAVlJjA3hUdi6Q
X-Google-Smtp-Source: AGHT+IF2LvXe/M/aBKc7IHeoM2uFyQ99DWns8BLeSfOB7NogMxfp7QfZubs9znaxk8dANr939azsTA==
X-Received: by 2002:a17:902:f68c:b0:1f9:e3fa:d932 with SMTP id d9443c01a7336-1fadb433a92mr15486365ad.9.1719659449115;
        Sat, 29 Jun 2024 04:10:49 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596920sm30068975ad.268.2024.06.29.04.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 04:10:48 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	kaleshsingh@google.com,
	hughd@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	baolin.wang@linux.alibaba.com,
	shakeel.butt@linux.dev,
	senozhatsky@chromium.org,
	minchan@kernel.org,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: [PATCH RFC v4 2/2] mm: support large folios swapin as a whole for zRAM-like swapfile
Date: Sat, 29 Jun 2024 23:10:10 +1200
Message-Id: <20240629111010.230484-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240629111010.230484-1-21cnbao@gmail.com>
References: <20240629111010.230484-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

In an embedded system like Android, more than half of anonymous memory is
actually stored in swap devices such as zRAM. For instance, when an app
is switched to the background, most of its memory might be swapped out.

Currently, we have mTHP features, but unfortunately, without support
for large folio swap-ins, once those large folios are swapped out,
we lose them immediately because mTHP is a one-way ticket.

This patch introduces mTHP swap-in support. For now, we limit mTHP
swap-ins to contiguous swaps that were likely swapped out from mTHP as
a whole.

Additionally, the current implementation only covers the SWAP_SYNCHRONOUS
case. This is the simplest and most common use case, benefiting millions
of Android phones and similar devices with minimal implementation
cost. In this straightforward scenario, large folios are always exclusive,
eliminating the need to handle complex rmap and swapcache issues.

It offers several benefits:
1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP after
   swap-out and swap-in.
2. Eliminates fragmentation in swap slots and supports successful THP_SWPOUT
   without fragmentation.
3. Enables zRAM/zsmalloc to compress and decompress mTHP, reducing CPU usage
   and enhancing compression ratios significantly.

Deploying this on millions of actual products, we haven't observed any
noticeable increase in memory footprint for 64KiB mTHP based on CONT-PTE
on ARM64.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/zswap.h |   2 +-
 mm/memory.c           | 210 +++++++++++++++++++++++++++++++++++-------
 mm/swap_state.c       |   2 +-
 3 files changed, 181 insertions(+), 33 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index bf83ae5e285d..6cecb4a4f68b 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -68,7 +68,7 @@ static inline bool zswap_is_enabled(void)
 
 static inline bool zswap_never_enabled(void)
 {
-	return false;
+	return true;
 }
 
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 0a769f34bbb2..41ec7b919c2e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3987,6 +3987,141 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
+/*
+ * check a range of PTEs are completely swap entries with
+ * contiguous swap offsets and the same SWAP_HAS_CACHE.
+ * ptep must be first one in the range
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
+{
+	struct swap_info_struct *si;
+	unsigned long addr;
+	swp_entry_t entry;
+	pgoff_t offset;
+	char has_cache;
+	int idx, i;
+	pte_t pte;
+
+	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
+	idx = (vmf->address - addr) / PAGE_SIZE;
+	pte = ptep_get(ptep);
+
+	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
+		return false;
+	entry = pte_to_swp_entry(pte);
+	offset = swp_offset(entry);
+	if (!IS_ALIGNED(offset, nr_pages))
+		return false;
+	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
+		return false;
+
+	si = swp_swap_info(entry);
+	has_cache = si->swap_map[offset] & SWAP_HAS_CACHE;
+	for (i = 1; i < nr_pages; i++) {
+		/*
+		 * while allocating a large folio and doing swap_read_folio for the
+		 * SWP_SYNCHRONOUS_IO path, which is the case the being faulted pte
+		 * doesn't have swapcache. We need to ensure all PTEs have no cache
+		 * as well, otherwise, we might go to swap devices while the content
+		 * is in swapcache
+		 */
+		if ((si->swap_map[offset + i] & SWAP_HAS_CACHE) != has_cache)
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Get a list of all the (large) orders below PMD_ORDER that are enabled
+ * for this vma. Then filter out the orders that can't be allocated over
+ * the faulting address and still be fully contained in the vma.
+ */
+static inline unsigned long get_alloc_folio_orders(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long orders;
+
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
+			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+	return orders;
+}
+#else
+static inline bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
+{
+	return false;
+}
+#endif
+
+static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	unsigned long orders;
+	struct folio *folio;
+	unsigned long addr;
+	spinlock_t *ptl;
+	pte_t *pte;
+	gfp_t gfp;
+	int order;
+
+	/*
+	 * If uffd is active for the vma we need per-page fault fidelity to
+	 * maintain the uffd semantics.
+	 */
+	if (unlikely(userfaultfd_armed(vma)))
+		goto fallback;
+
+	/*
+	 * a large folio being swapped-in could be partially in
+	 * zswap and partially in swap devices, zswap doesn't
+	 * support large folios yet, we might get corrupted
+	 * zero-filled data by reading all subpages from swap
+	 * devices while some of them are actually in zswap
+	 */
+	if (!zswap_never_enabled())
+		goto fallback;
+
+	orders = get_alloc_folio_orders(vmf);
+	if (!orders)
+		goto fallback;
+
+	pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address & PMD_MASK, &ptl);
+	if (unlikely(!pte))
+		goto fallback;
+
+	/*
+	 * For do_swap_page, find the highest order where the aligned range is
+	 * completely swap entries with contiguous swap offsets.
+	 */
+	order = highest_order(orders);
+	while (orders) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
+		if (can_swapin_thp(vmf, pte + pte_index(addr), 1 << order))
+			break;
+		order = next_order(&orders, order);
+	}
+
+	pte_unmap_unlock(pte, ptl);
+
+	/* Try allocating the highest of the remaining orders. */
+	gfp = vma_thp_gfp_mask(vma);
+	while (orders) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
+		folio = vma_alloc_folio(gfp, order, vma, addr, true);
+		if (folio)
+			return folio;
+		order = next_order(&orders, order);
+	}
+
+fallback:
+#endif
+	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address, false);
+}
+
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -4075,35 +4210,38 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/*
-			 * Prevent parallel swapin from proceeding with
-			 * the cache flag. Otherwise, another thread may
-			 * finish swapin first, free the entry, and swapout
-			 * reusing the same entry. It's undetectable as
-			 * pte_same() returns true due to entry reuse.
-			 */
-			if (swapcache_prepare(entry)) {
-				/* Relax a bit to prevent rapid repeated page faults */
-				schedule_timeout_uninterruptible(1);
-				goto out;
-			}
-			need_clear_cache = true;
-
 			/* skip swapcache */
-			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-						vma, vmf->address, false);
+			folio = alloc_swap_folio(vmf);
 			page = &folio->page;
 			if (folio) {
 				__folio_set_locked(folio);
 				__folio_set_swapbacked(folio);
 
+				nr_pages = folio_nr_pages(folio);
+				if (folio_test_large(folio))
+					entry.val = ALIGN_DOWN(entry.val, nr_pages);
+				/*
+				 * Prevent parallel swapin from proceeding with
+				 * the cache flag. Otherwise, another thread may
+				 * finish swapin first, free the entry, and swapout
+				 * reusing the same entry. It's undetectable as
+				 * pte_same() returns true due to entry reuse.
+				 */
+				if (swapcache_prepare_nr(entry, nr_pages)) {
+					/* Relax a bit to prevent rapid repeated page faults */
+					schedule_timeout_uninterruptible(1);
+					goto out_page;
+				}
+				need_clear_cache = true;
+
 				if (mem_cgroup_swapin_charge_folio(folio,
 							vma->vm_mm, GFP_KERNEL,
 							entry)) {
 					ret = VM_FAULT_OOM;
 					goto out_page;
 				}
-				mem_cgroup_swapin_uncharge_swap(entry);
+				for (swp_entry_t e = entry; e.val < entry.val + nr_pages; e.val++)
+					mem_cgroup_swapin_uncharge_swap(e);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
@@ -4210,6 +4348,22 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_nomap;
 	}
 
+	/* allocated large folios for SWP_SYNCHRONOUS_IO */
+	if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
+		unsigned long nr = folio_nr_pages(folio);
+		unsigned long folio_start = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
+		unsigned long idx = (vmf->address - folio_start) / PAGE_SIZE;
+		pte_t *folio_ptep = vmf->pte - idx;
+
+		if (!can_swapin_thp(vmf, folio_ptep, nr))
+			goto out_nomap;
+
+		page_idx = idx;
+		address = folio_start;
+		ptep = folio_ptep;
+		goto check_folio;
+	}
+
 	nr_pages = 1;
 	page_idx = 0;
 	address = vmf->address;
@@ -4341,11 +4495,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_add_lru_vma(folio, vma);
 	} else if (!folio_test_anon(folio)) {
 		/*
-		 * We currently only expect small !anon folios, which are either
-		 * fully exclusive or fully shared. If we ever get large folios
-		 * here, we have to be careful.
+		 * We currently only expect small !anon folios which are either
+		 * fully exclusive or fully shared, or new allocated large folios
+		 * which are fully exclusive. If we ever get large folios within
+		 * swapcache here, we have to be careful.
 		 */
-		VM_WARN_ON_ONCE(folio_test_large(folio));
+		VM_WARN_ON_ONCE(folio_test_large(folio) && folio_test_swapcache(folio));
 		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
 		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
 	} else {
@@ -4388,7 +4543,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
 	if (need_clear_cache)
-		swapcache_clear(si, entry);
+		swapcache_clear_nr(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4404,7 +4559,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_put(swapcache);
 	}
 	if (need_clear_cache)
-		swapcache_clear(si, entry);
+		swapcache_clear_nr(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4440,14 +4595,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	if (unlikely(userfaultfd_armed(vma)))
 		goto fallback;
 
-	/*
-	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
-	 * for this vma. Then filter out the orders that can't be allocated over
-	 * the faulting address and still be fully contained in the vma.
-	 */
-	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
-			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
-	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+	orders = get_alloc_folio_orders(vmf);
 
 	if (!orders)
 		goto fallback;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 994723cef821..7e20de975350 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -478,7 +478,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		/*
 		 * Swap entry may have been freed since our caller observed it.
 		 */
-		err = swapcache_prepare(entry);
+		err = swapcache_prepare_nr(entry, 1);
 		if (!err)
 			break;
 
-- 
2.34.1



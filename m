Return-Path: <linux-kernel+bounces-272550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C48945DC7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251F11C215F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A414B09F;
	Fri,  2 Aug 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egDK2FFX"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFD1DF66B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722601276; cv=none; b=e6e0mfXoqYv9y/h5zzbqSOfopi8S4HX6YRF4BQ4fw0ef/9o0WIXdW8UNoKHyiNv04wbn1PIfi1i+SgN43vUUvUGN8JvYqdI2UoRBuP1evLwX/miIITRDmV8H4muogyDNRIYMa86UCSe9pxSa5wFu7zDdLAdX6kesWXBxzODayzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722601276; c=relaxed/simple;
	bh=r4vhrPSWMt/E6o9WLjPLYuu7RkLcGCWzBd3h+Z4eMPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHRdw8JL5jqy52oBDmcMsc0YMsNSAfHKCojR8e4L1LcTxqZyGKYMuI8jwpcyadtwvRp3K7NcLv+Cygu9dztIsXkcvUyEwOmxzslxGGJY29IJRacsN3ZhE933g09rUdGEGsBN0gK/JkE7H8cYqFqFPJqRHc0yInJk5cTDzgyApIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egDK2FFX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ff1cd07f56so60163055ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722601274; x=1723206074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4kFGlQ3P9/qg9SMcB706prs3lrZrpD1NyU/I35BuaI=;
        b=egDK2FFXEqvKfScYgesHVij+PjQAzgbiEIH3LYAb8Xl8qnxiaObUuM/k0/yU+SqPlK
         mH7BNUVjbc2ErElCgLjdimD9omgOMhlEtNvkQQ+dBVIIsF8W6ssbUQDDvTaDel/NjSEa
         +Ewk5zGntxr//VBpFjyzLfm0FPI3QQL+INDI0FKrOXkU5t/SCN6r0q5nc6Vw/V+CyiPW
         UdBNfB/p8X/HPNRc5gybtW2NJRm1fWeacSKk9rRsClGz1Dn7kzICMt5PcppBFqZ7rDBs
         YBf8Dmps/Cn2RUtaHfJ4bJFABWoIsEhGZe7zDhtR+NIVERLRztDzo0PJIQdHJxRbrU8w
         TdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722601274; x=1723206074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4kFGlQ3P9/qg9SMcB706prs3lrZrpD1NyU/I35BuaI=;
        b=gzUG6+EC4WoHlDtddiKzjEAYquCl3vpab85agDOjp9haX0J7tyAh2hXfNsv7N9SFU9
         ADpSfMYcQOD6uGQzZQ9axuu9ufGsn//LTp7rX9mflT5bEdW7tsgcMLcCzRfEl1UEpj7f
         JZ6m63bG3Dz0YrtfV+fWbzr4OIewg37gZGQlMmdr7kVvDoFRMGEw4Tg0Y9ocVql/Q9ZG
         lyZfIr9wSXvsC8+rjScNWOKoZuLQL7XcF4lFchVk4TiP7wyw9FZ1zPxub7P2AxEqQYFT
         dzHdnUQ49PnfT/vONwhpyCUvv4NA/8pxweTf6ndh8+kT0hlwgAGeie/BCaG8/DiyaVDe
         ZV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSlWTnXrZtc8BhvKzxUkjlLgcI4OHhMTI/zO1xRvzMlljIMfjJRzcYc7H+yEfUcpF8CMsCE3VnAk+rsEad3IV4l2OZV9EG/+o/7R35
X-Gm-Message-State: AOJu0YyOUHtgOPNPU8zjBhVYaI5F0YH9y2V5dA6Lrwk/q9AufRgpJrKR
	hOQcKarDNClCCerxYXh8aNtN/XvoUHGiwVTmfIX4K9DVsZOT/TtK
X-Google-Smtp-Source: AGHT+IFspuGjo7i44LD4lZkqlOJD5G7rbdSrKoQkk+kKJkp83UHxDiHKjj4IanneYSzs6/eAxZtR1g==
X-Received: by 2002:a17:902:cec6:b0:1fb:1b16:eb7b with SMTP id d9443c01a7336-1ff57258abbmr49466575ad.16.1722601273549;
        Fri, 02 Aug 2024 05:21:13 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff590600e4sm15841875ad.144.2024.08.02.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:21:13 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	hch@infradead.org,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like devices
Date: Sat,  3 Aug 2024 00:20:31 +1200
Message-Id: <20240802122031.117548-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802122031.117548-1-21cnbao@gmail.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240802122031.117548-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

Currently, we have mTHP features, but unfortunately, without support for large
folio swap-ins, once these large folios are swapped out, they are lost because
mTHP swap is a one-way process. The lack of mTHP swap-in functionality prevents
mTHP from being used on devices like Android that heavily rely on swap.

This patch introduces mTHP swap-in support. It starts from sync devices such
as zRAM. This is probably the simplest and most common use case, benefiting
billions of Android phones and similar devices with minimal implementation
cost. In this straightforward scenario, large folios are always exclusive,
eliminating the need to handle complex rmap and swapcache issues.

It offers several benefits:
1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP after
   swap-out and swap-in. Large folios in the buddy system are also
   preserved as much as possible, rather than being fragmented due
   to swap-in.

2. Eliminates fragmentation in swap slots and supports successful
   THP_SWPOUT.

   w/o this patch (Refer to the data from Chris's and Kairui's latest
   swap allocator optimization while running ./thp_swap_allocator_test
   w/o "-a" option [1]):

   ./thp_swap_allocator_test
   Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 2: swpout inc: 131, swpout fallback inc: 101, Fallback percentage: 43.53%
   Iteration 3: swpout inc: 71, swpout fallback inc: 155, Fallback percentage: 68.58%
   Iteration 4: swpout inc: 55, swpout fallback inc: 168, Fallback percentage: 75.34%
   Iteration 5: swpout inc: 35, swpout fallback inc: 191, Fallback percentage: 84.51%
   Iteration 6: swpout inc: 25, swpout fallback inc: 199, Fallback percentage: 88.84%
   Iteration 7: swpout inc: 23, swpout fallback inc: 205, Fallback percentage: 89.91%
   Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percentage: 96.05%
   Iteration 9: swpout inc: 13, swpout fallback inc: 213, Fallback percentage: 94.25%
   Iteration 10: swpout inc: 12, swpout fallback inc: 216, Fallback percentage: 94.74%
   Iteration 11: swpout inc: 16, swpout fallback inc: 213, Fallback percentage: 93.01%
   Iteration 12: swpout inc: 10, swpout fallback inc: 210, Fallback percentage: 95.45%
   Iteration 13: swpout inc: 16, swpout fallback inc: 212, Fallback percentage: 92.98%
   Iteration 14: swpout inc: 12, swpout fallback inc: 212, Fallback percentage: 94.64%
   Iteration 15: swpout inc: 15, swpout fallback inc: 211, Fallback percentage: 93.36%
   Iteration 16: swpout inc: 15, swpout fallback inc: 200, Fallback percentage: 93.02%
   Iteration 17: swpout inc: 9, swpout fallback inc: 220, Fallback percentage: 96.07%

   w/ this patch (always 0%):
   Iteration 1: swpout inc: 948, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 2: swpout inc: 953, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 3: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 4: swpout inc: 952, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 5: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 6: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 7: swpout inc: 947, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 8: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 9: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 10: swpout inc: 945, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 11: swpout inc: 947, swpout fallback inc: 0, Fallback percentage: 0.00%
   ...

3. With both mTHP swap-out and swap-in supported, we offer the option to enable
   zsmalloc compression/decompression with larger granularity[2]. The upcoming
   optimization in zsmalloc will significantly increase swap speed and improve
   compression efficiency. Tested by running 100 iterations of swapping 100MiB
   of anon memory, the swap speed improved dramatically:
                time consumption of swapin(ms)   time consumption of swapout(ms)
     lz4 4k                  45274                    90540
     lz4 64k                 22942                    55667
     zstdn 4k                85035                    186585
     zstdn 64k               46558                    118533

    The compression ratio also improved, as evaluated with 1 GiB of data:
     granularity   orig_data_size   compr_data_size
     4KiB-zstd      1048576000       246876055
     64KiB-zstd     1048576000       199763892

   Without mTHP swap-in, the potential optimizations in zsmalloc cannot be
   realized.

4. Even mTHP swap-in itself can reduce swap-in page faults by a factor
   of nr_pages. Swapping in content filled with the same data 0x11, w/o
   and w/ the patch for five rounds (Since the content is the same,
   decompression will be very fast. This primarily assesses the impact of
   reduced page faults):

  swp in bandwidth(bytes/ms)    w/o              w/
   round1                     624152          1127501
   round2                     631672          1127501
   round3                     620459          1139756
   round4                     606113          1139756
   round5                     624152          1152281
   avg                        621310          1137359      +83%

[1] https://lore.kernel.org/all/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/
[2] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 211 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 188 insertions(+), 23 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4cf4902db1ec..07029532469a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3986,6 +3986,152 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
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
+static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
+		unsigned long addr, unsigned long orders)
+{
+	int order, nr;
+
+	order = highest_order(orders);
+
+	/*
+	 * To swap-in a THP with nr pages, we require its first swap_offset
+	 * is aligned with nr. This can filter out most invalid entries.
+	 */
+	while (orders) {
+		nr = 1 << order;
+		if ((addr >> PAGE_SHIFT) % nr == swp_offset % nr)
+			break;
+		order = next_order(&orders, order);
+	}
+
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
+	swp_entry_t entry;
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
+	 * A large swapped out folio could be partially or fully in zswap. We
+	 * lack handling for such cases, so fallback to swapping in order-0
+	 * folio.
+	 */
+	if (!zswap_never_enabled())
+		goto fallback;
+
+	entry = pte_to_swp_entry(vmf->orig_pte);
+	/*
+	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
+	 * and suitable for swapping THP.
+	 */
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
+			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+	orders = thp_swap_suitable_orders(swp_offset(entry), vmf->address, orders);
+
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
@@ -4074,35 +4220,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
-			if (swapcache_prepare(entry, 1)) {
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
+				if (swapcache_prepare(entry, nr_pages)) {
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
-				mem_cgroup_swapin_uncharge_swap(entry, 1);
+				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
@@ -4209,6 +4357,22 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -4340,11 +4504,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -4387,7 +4552,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
 	if (need_clear_cache)
-		swapcache_clear(si, entry, 1);
+		swapcache_clear(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4403,7 +4568,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_put(swapcache);
 	}
 	if (need_clear_cache)
-		swapcache_clear(si, entry, 1);
+		swapcache_clear(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
-- 
2.34.1



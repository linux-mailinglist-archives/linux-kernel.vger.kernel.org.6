Return-Path: <linux-kernel+bounces-263070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C663993D09A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0A628237D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E7814F122;
	Fri, 26 Jul 2024 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1tqeRqq"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0521EF01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987248; cv=none; b=THSVz11nttlmJBAIwZj6WSwedgwGJJ91cWyrnCVIDJVjxNpCR+ZLVjL0ySQfc2kgoJNetKclBBb81rUlrJ4aopUApWBIYa3G6kvqVJBA7SWjN+wXwmqgvd+TmuODY8GxynmlNYJJdSpoR2LDh3NfFlYHCxQ5fjQ3sL2YOnk9ZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987248; c=relaxed/simple;
	bh=FL0DQLlqOty5LHC8u2KEfUvSaAULygAFyXpxIIXIak0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RyHIs2NWSIikR9UmiX74ybtb2yYkUXeZAzqffgynbcCDEf+/icWdh+KZudCXUcXy7N31nuNE/OCx+sUEQx7zVNhR7qxYKdlT0fUengjfcadWi/C5Eevpl39pcI42eqOL5Wlu154a2rbpD//559nX/JMQMGZJowROqXNAOPdRobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1tqeRqq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd90c2fc68so4150205ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721987246; x=1722592046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gT1UL0dJwOaNKYiFjA7EC0yRYS8xQDfFpNmhEqLpJwk=;
        b=E1tqeRqqmVGSb/Rt2gkAE5VH736ehbcevJVcLyZs3e/Q+W933LLKsU9ZpsFDnG+gD3
         uYS5b7cRnMTVwv5PeNqezP1aY/3opbbnHc6f/CXakzTUqdBUPkzJwwqvsvReaqmO+zr8
         4Jol3nV6rwjg2erPnAVDGi/JkNVlecWNpSR/TeqLud4G93R+d/rXgrzmjsPTjT2l7kJB
         CXZ6GzOCJvXUFoWw/mb3jdUr4w2EetzjoBHH+HOjFOPwsMTwYyp1RLgADXqD08i0H3bG
         RShINeYqXmqlhVSUswOL2/iPdF1TlJfFfzvNH+mFIfx7XAN1plfgTJo3tb8XPHPIoZMj
         xv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721987246; x=1722592046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT1UL0dJwOaNKYiFjA7EC0yRYS8xQDfFpNmhEqLpJwk=;
        b=NURWDFODVcvI+9i+SShDmAcmbU9lQ/1zOu6jjt4WKLuZt4GbWrb2jo/IR9hQZ8WTvf
         RiuJmgDSo0y919Jat0TnQ0IqZOom9e4r9L46lvTzm1J3JAfr7s85KI2IoQTFLhKOtBuJ
         yWtwrnCFwbvzH3l1eh9tzotb1UJpnwgtmU2L64ssE97B2VO/fRiuT9t+P9hanh2iHrJu
         tnjNlovTFeLdqXWdTSudYnZiTGrV11UaELHa+VC1NQvyaxSW+UNz/22nf9FYo5W5D52E
         zs5+BmQS0ooQqc4bt/Hh7y4XUx8DtimO9iBqKrWzHVDx4z9fPjGkCi+HCmx5bKqk5JO/
         KEDA==
X-Forwarded-Encrypted: i=1; AJvYcCULU9I9FOVXdDtL+8Iq+1qqPptglG72Bscj0XAgMjnA5s9VIDVkTmUATsdQoasRl2k4CBlGpvKztvEsFqQ3OGOqftIXbTkqkC/FKDU9
X-Gm-Message-State: AOJu0Ywnzyd5QIfjMRQ84vaXulMyNSV9C9SCyIi/HYcP03NndEnLgGD3
	DArHNZXcHPDt0HQz/q8+DK1XEC1/U4sbupep2ajxgXCvpxxolMUU
X-Google-Smtp-Source: AGHT+IFk/zzhxB/vWOVfPadjTGBbJvMnp6xOZwuxd7f6freLAGGRqyTe1ovwigii5sLP/MuWd1JkEQ==
X-Received: by 2002:a17:902:ecd1:b0:1fd:7293:3d70 with SMTP id d9443c01a7336-1fed35301e8mr63985595ad.8.1721987246237;
        Fri, 26 Jul 2024 02:47:26 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d15e98sm28127455ad.99.2024.07.26.02.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 02:47:25 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: ying.huang@intel.com,
	baolin.wang@linux.alibaba.com,
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
	yosryahmed@google.com,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: [PATCH v5 3/4] mm: support large folios swapin as a whole for zRAM-like swapfile
Date: Fri, 26 Jul 2024 21:46:17 +1200
Message-Id: <20240726094618.401593-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726094618.401593-1-21cnbao@gmail.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
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
2. Eliminates fragmentation in swap slots and supports successful
   THP_SWPOUT without fragmentation.
3. Enables zRAM/zsmalloc to compress and decompress mTHP, reducing CPU usage
   and enhancing compression ratios significantly.

Deploying this on millions of actual products, we haven't observed any
noticeable increase in memory footprint for 64KiB mTHP based on CONT-PTE
on ARM64.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 211 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 188 insertions(+), 23 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 833d2cad6eb2..14048e9285d4 100644
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
+				mem_cgroup_swapin_uncharge_swap_nr(entry, nr_pages);
 
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
-		swapcache_clear(si, entry);
+		swapcache_clear_nr(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4403,7 +4568,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_put(swapcache);
 	}
 	if (need_clear_cache)
-		swapcache_clear(si, entry);
+		swapcache_clear_nr(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
-- 
2.34.1



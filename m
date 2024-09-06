Return-Path: <linux-kernel+bounces-317981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F7696E6A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABE81F23FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611E10E0;
	Fri,  6 Sep 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3aMzp6y"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E6EC2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581497; cv=none; b=XxsrnAWwMxZtlbVDcrtcoTQiRJj89wo7hXPNBQBX46aW7ciuHRf/xETZW0HiuUJQ8hsAu0xjXThA5a87rEOxq2IBDG0YfQ7PeBmP2BBh9t2r/NeNxSFXaZa2MgQwiNYMWsBSOo9J8fFnl35iUku4Bi3VgH9iuoiRcIHWTmfAqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581497; c=relaxed/simple;
	bh=2IEesW/JBIfF/kzi7UC9vArzc7cARt7TQnQPOk18wqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqjjhquSiSzJpS00coxMcUjFKPjrAsdYgPxPEwoXvh2FnKWa9AYUauen4CSc2+ud9WPvMhUJcm8XNOet5TeFNUS9PZx3gidvWyoCe73jhyx0cBbOWfNk8QJYr9Od0fOpm4CG2yA76hVOGEzo7rAr2RPdJIYSc0IvtV+FYA4zSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3aMzp6y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-206e614953aso8390825ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725581494; x=1726186294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV2tR4Goy2aJJyrtdQU+NgrOzgVlBcOxf/RbnCByfrk=;
        b=I3aMzp6yi/aeLwsS+7JEKW41G9LAAvrU2IXB8P+UXDmvY5LLFTBLizSQVJgvjQHMHT
         MNsztyF9AymOqBwH3EGySZkPSTBYZgle/ROOQcrh/hWLscJNI37Tm1KLBMFlpbbyY2UB
         9T4fKV++Evknekf/FWvNRjQo6gfi6R6/g56d9Ir6qzYUsPS4k8RAcUz5dBJ4ZkagHOcQ
         RqsC3WrF2pz68zOpM4ceiPTomcd9aFUUgk/toGgyf2zofS+ukMgArJHY8znomLN/fsXD
         o+GRLzLNGfnaoqsVdqPQI3Fv6yvTXVo7EAMWWHFsV0R/GTsvrTHbq2TANQmKe+YIWCbJ
         WCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725581494; x=1726186294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV2tR4Goy2aJJyrtdQU+NgrOzgVlBcOxf/RbnCByfrk=;
        b=RKe0BHJdeBw1Ip3Idf8SXCm2wH7asLpZNgigxGvPlinTPnpx+L3UoKIMSPdJ14KbvR
         3WrT4vZeBuhv4W4zTh8BKXlUNiQwq/PR7Hz6Y1u6V++ljeblDE5RPHi9FvVpeXtF5oQR
         i+FWL9eXNjruk15iA1h+BPOuSFE11eYLdEGNzqsFkgtL01vEjqe2SmTM/00/R1tWR1AP
         pDqZHLsMaYd7CChx2tLRdvw2kUKZOZMLuWRMASDcku6hGOq1ezDzmnKJx5Rtbw12UMAk
         +a1NdvvKVARVeamuDEhzdZO9H9+22xHF810ZZYTHWZubDM4fxsBvD5iKqxZuolp2VI9x
         cOCw==
X-Forwarded-Encrypted: i=1; AJvYcCWogSoVdWhVOQuwk6DF8wJaYXMnCQQvKFu7KsWXXmT3BHEU3Q65E5v/5QbPlueFijEQMOFuZqpS3aqU7MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWUuXfIY8G0WB2Av92MU4stPgqoRi0DOSPnYmYLG7mgr3dyRT
	DISvsRdZzYMcQv5lXalMtmBTQ6W3aAL1XuEkhOAD767wP2nzBD7W
X-Google-Smtp-Source: AGHT+IE/5ayyT4POxf05BK1qR6oZpfvzYds6J6RnEONZo79n5nJXkDSyQzBIZMs/m4aOfyev07e4jg==
X-Received: by 2002:a17:903:18d:b0:206:b5b8:25ef with SMTP id d9443c01a7336-206b5b82940mr86841055ad.15.1725581494216;
        Thu, 05 Sep 2024 17:11:34 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:cd42:f8ae:5222:5ab7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3548dsm33447445ad.140.2024.09.05.17.11.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Sep 2024 17:11:33 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hanchuanhua@oppo.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hch@infradead.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	Usama Arif <usamaarif642@gmail.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Subject: [PATCH v8 3/3] mm: support large folios swap-in for sync io devices
Date: Fri,  6 Sep 2024 12:10:47 +1200
Message-Id: <20240906001047.1245-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240906001047.1245-1-21cnbao@gmail.com>
References: <20240906001047.1245-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

Currently, we have mTHP features, but unfortunately, without support for
large folio swap-ins, once these large folios are swapped out, they are
lost because mTHP swap is a one-way process.  The lack of mTHP swap-in
functionality prevents mTHP from being used on devices like Android that
heavily rely on swap.

This patch introduces mTHP swap-in support.  It starts from sync devices
such as zRAM.  This is probably the simplest and most common use case,
benefiting billions of Android phones and similar devices with minimal
implementation cost.  In this straightforward scenario, large folios are
always exclusive, eliminating the need to handle complex rmap and
swapcache issues.

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

5. With both mTHP swap-out and swap-in supported, we offer the option to enable
   hardware accelerators(Intel IAA) to do parallel decompression with which
   Kanchana reported 7X improvement on zRAM read latency[3].

[1] https://lore.kernel.org/all/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/
[2] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/
[3] https://lore.kernel.org/all/cover.1714581792.git.andre.glover@linux.intel.com/

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Gao Xiang <xiang@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/memory.c | 261 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 234 insertions(+), 27 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index cdf03b39a92c..d35dd8d99c8a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3985,6 +3985,194 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
+static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio;
+	swp_entry_t entry;
+
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
+				vmf->address, false);
+	if (!folio)
+		return NULL;
+
+	entry = pte_to_swp_entry(vmf->orig_pte);
+	if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
+					   GFP_KERNEL, entry)) {
+		folio_put(folio);
+		return NULL;
+	}
+
+	return folio;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
+{
+	struct swap_info_struct *si = swp_swap_info(entry);
+	pgoff_t offset = swp_offset(entry);
+	int i;
+
+	/*
+	 * While allocating a large folio and doing swap_read_folio, which is
+	 * the case the being faulted pte doesn't have swapcache. We need to
+	 * ensure all PTEs have no cache as well, otherwise, we might go to
+	 * swap devices while the content is in swapcache.
+	 */
+	for (i = 0; i < max_nr; i++) {
+		if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
+			return i;
+	}
+
+	return i;
+}
+
+/*
+ * Check if the PTEs within a range are contiguous swap entries
+ * and have consistent swapcache, zeromap.
+ */
+static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
+{
+	unsigned long addr;
+	swp_entry_t entry;
+	int idx;
+	pte_t pte;
+
+	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
+	idx = (vmf->address - addr) / PAGE_SIZE;
+	pte = ptep_get(ptep);
+
+	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
+		return false;
+	entry = pte_to_swp_entry(pte);
+	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
+		return false;
+
+	/*
+	 * swap_read_folio() can't handle the case a large folio is hybridly
+	 * from different backends. And they are likely corner cases. Similar
+	 * things might be added once zswap support large folios.
+	 */
+	if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) != nr_pages))
+		return false;
+	if (unlikely(non_swapcache_batch(entry, nr_pages) != nr_pages))
+		return false;
+
+	return true;
+}
+
+static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
+						     unsigned long addr,
+						     unsigned long orders)
+{
+	int order, nr;
+
+	order = highest_order(orders);
+
+	/*
+	 * To swap in a THP with nr pages, we require that its first swap_offset
+	 * is aligned with that number, as it was when the THP was swapped out.
+	 * This helps filter out most invalid entries.
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
+
+static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
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
+	orders = thp_swap_suitable_orders(swp_offset(entry),
+					  vmf->address, orders);
+
+	if (!orders)
+		goto fallback;
+
+	pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+				  vmf->address & PMD_MASK, &ptl);
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
+		if (folio) {
+			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
+							    gfp, entry))
+				return folio;
+			folio_put(folio);
+		}
+		order = next_order(&orders, order);
+	}
+
+fallback:
+	return __alloc_swap_folio(vmf);
+}
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
+static inline bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
+{
+	return false;
+}
+
+static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+{
+	return __alloc_swap_folio(vmf);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -4073,34 +4261,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
 			if (folio) {
 				__folio_set_locked(folio);
 				__folio_set_swapbacked(folio);
 
-				if (mem_cgroup_swapin_charge_folio(folio,
-							vma->vm_mm, GFP_KERNEL,
-							entry)) {
-					ret = VM_FAULT_OOM;
+				nr_pages = folio_nr_pages(folio);
+				if (folio_test_large(folio))
+					entry.val = ALIGN_DOWN(entry.val, nr_pages);
+				/*
+				 * Prevent parallel swapin from proceeding with
+				 * the cache flag. Otherwise, another thread
+				 * may finish swapin first, free the entry, and
+				 * swapout reusing the same entry. It's
+				 * undetectable as pte_same() returns true due
+				 * to entry reuse.
+				 */
+				if (swapcache_prepare(entry, nr_pages)) {
+					/*
+					 * Relax a bit to prevent rapid
+					 * repeated page faults.
+					 */
+					schedule_timeout_uninterruptible(1);
 					goto out_page;
 				}
-				mem_cgroup_swapin_uncharge_swap(entry, 1);
+				need_clear_cache = true;
+
+				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
@@ -4206,6 +4394,24 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_nomap;
 	}
 
+	/* allocated large folios for SWP_SYNCHRONOUS_IO */
+	if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
+		unsigned long nr = folio_nr_pages(folio);
+		unsigned long folio_start = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
+		unsigned long idx = (vmf->address - folio_start) / PAGE_SIZE;
+		pte_t *folio_ptep = vmf->pte - idx;
+		pte_t folio_pte = ptep_get(folio_ptep);
+
+		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
+		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
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
@@ -4337,11 +4543,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_add_lru_vma(folio, vma);
 	} else if (!folio_test_anon(folio)) {
 		/*
-		 * We currently only expect small !anon folios, which are either
-		 * fully exclusive or fully shared. If we ever get large folios
-		 * here, we have to be careful.
+		 * We currently only expect small !anon folios which are either
+		 * fully exclusive or fully shared, or new allocated large
+		 * folios which are fully exclusive. If we ever get large
+		 * folios within swapcache here, we have to be careful.
 		 */
-		VM_WARN_ON_ONCE(folio_test_large(folio));
+		VM_WARN_ON_ONCE(folio_test_large(folio) && folio_test_swapcache(folio));
 		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
 		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
 	} else {
@@ -4384,7 +4591,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
 	if (need_clear_cache)
-		swapcache_clear(si, entry, 1);
+		swapcache_clear(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4400,7 +4607,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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



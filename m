Return-Path: <linux-kernel+bounces-278573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA1B94B200
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FAD1F218BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A81552E4;
	Wed,  7 Aug 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="EgQb9UCj"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E84149E0E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065578; cv=none; b=ugNmaLj+kZvV2vBNCLmr2cVVNuyvE89Wn6NlBK9VOqEonSxPTdK0BCGWihTSOJGljsoe++U8F/Bro0vQL11PxjbyCHIeX4hOmKfSyQYARroqotLg7YYhc9HOjp9ZM0Uod6VcP1/GB3yfQn8qL2xbZZFuYFkDSR993EPqAALOG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065578; c=relaxed/simple;
	bh=VSfdnlkU/rsZFdvFZi+IhQ4wyB2eLDqM36lXHVZ8y0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVh6gnnEq+fRUOlJAk6NJCLaOi7yf+j/gvTYxzEOe/6TpfHA7dNTE/cs/lAd7T4plFOQ0adPAtdFP0nvnE2VIFvjP0owlKOCY70WXN65SdNyDY33vbfHrRTb+LPYAV0X0gFPkZfYUrIVYz8AeMfr1qrysCCNSB6jSc7KOKkdQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=EgQb9UCj; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6bba6ced3d4so1933886d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723065575; x=1723670375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMYAklW02P/DcMlwBhwf3Eib1+5kNLt8UcMJSghVYnc=;
        b=EgQb9UCjMKGH3YjAbaLv1H9pP31gXOZRnmLvsME/+Dcx7wK+0l76YVwWENE2RDS6W0
         iiMfzY4yYwI79wRXNHLS1XlvaunBz+oZQ9DFjxfi8gX39zTBEEuEONDnsDylTAaUBvBI
         HOksc+WKeSWJ4DtdtwKWBPVTL/cwGRj8dG3FMNmFpczFPHeqhrAGyuUmsAX/YLdkWvWE
         Bwuv8mhG1WMO49Lm4RcOuZzwj3FnDo9bu3tPhlVWCNqMELQQ2h/IK+5UMSEnREa5xz4r
         yoRma2xjZWGQDWxh0X4Qx3KTRE0R/L51vVyuMvIET8qQ4gMpBpfNAUNN2M31I0oEfGBR
         NzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065575; x=1723670375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMYAklW02P/DcMlwBhwf3Eib1+5kNLt8UcMJSghVYnc=;
        b=i75AOepG5KJ8d+t2pH+Uq7zdjPhYcZTUnsx8Ogz7Bt5ExNIsEyK3zLGCIubs9LxToh
         cGakKrH8jamu8MqwMZxLu9ktXC6ijC/+f4B46xEY/oVJMzN5mRzVzW9Kjgte0ySDkLH5
         j0NWZa4GeCkp0FTQCqheXm1KnollJx2NPSE9HeOPzQCEeqMwE/OGVWQ5+1SGOyJ52BYE
         0bYN4qfY2qH3yPmDNArh2t8BFgNobhtMCN0QlBF88Ml7dWm3hzM1fsRxkaIMIFIKfadF
         PR1lkSoV1ljoeM4FE0fVEqt9KIdU2KD3ySagq3WH19duM8EA3p/YmqL9Y6SOaxcM7FqQ
         vaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWi/TlLSAGD6NK8hY4kbiRrgzYIA2xkwfAaitkj9bfOkpxCUegIiTjklUPrMzpe0THF6CwIWCeOa+fiwXZNEfQtwRmS/9An6py9UFp
X-Gm-Message-State: AOJu0YzjFZ9Boud3QmD/ahezp9ZQ4Ov+GwqJzqFHUSBj1//IT6GNcs8+
	8aReAs9H6V4CAQcwfnJE9eKsB5JayBL6u6iD5OdYZNHxDfuFfXhn0k5lLMtDTqE=
X-Google-Smtp-Source: AGHT+IHX0P53AXLSrpya3nHqG+XEXCDIzG+nu1l2vvgDK33GmfZQge38TJm5ph8bU9ymSBMQTKHlMw==
X-Received: by 2002:a05:6214:4a82:b0:6bb:be58:f278 with SMTP id 6a1803df08f44-6bbbe58f530mr40641846d6.47.1723065575417;
        Wed, 07 Aug 2024 14:19:35 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c839ee1sm59976976d6.89.2024.08.07.14.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:19:35 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org
Subject: [PATCH v2 3/3] mm: don't account memmap per node
Date: Wed,  7 Aug 2024 21:19:29 +0000
Message-ID: <20240807211929.3433304-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when memory is hot-plugged or hot-removed the accounting is
done based on the assumption that memmap is allocated from the same node
as the hot-plugged/hot-removed memory, which is not always the case.

In addition, there are challenges with keeping the node id of the memory
that is being remove to the time when memmap accounting is actually
performed: since this is done after remove_pfn_range_from_zone(), and
also after remove_memory_block_devices(). Meaning that we cannot use
pgdat nor walking though memblocks to get the nid.

Given all of that, account the memmap overhead system wide instead.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
Reported-by: Alison Schofield <alison.schofield@intel.com>
Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl2/#t

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/mmzone.h        |  2 --
 include/linux/vm_event_item.h |  2 ++
 include/linux/vmstat.h        |  7 ++++--
 mm/hugetlb_vmemmap.c          |  8 +++----
 mm/mm_init.c                  |  3 +--
 mm/page_alloc.c               |  1 -
 mm/page_ext.c                 | 15 ++++--------
 mm/sparse-vmemmap.c           | 11 ++++-----
 mm/sparse.c                   |  5 ++--
 mm/vmstat.c                   | 45 ++++++++++++++++-------------------
 10 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 41458892bc8a..1dc6248feb83 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -220,8 +220,6 @@ enum node_stat_item {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
-	NR_MEMMAP, /* page metadata allocated through buddy allocator */
-	NR_MEMMAP_BOOT, /* page metadata allocated through boot allocator */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 747943bc8cc2..89d091d5da19 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -154,6 +154,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		VMA_LOCK_RETRY,
 		VMA_LOCK_MISS,
 #endif
+		NR_MEMMAP, /* page metadata allocated through buddy allocator */
+		NR_MEMMAP_BOOT, /* page metadata allocated through boot allocator */
 		NR_VM_EVENT_ITEMS
 };
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 23cd17942036..b978df3992f2 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -625,7 +625,10 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
 	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
 }
 
-void __meminit mod_node_early_perpage_metadata(int nid, long delta);
-void __meminit store_early_perpage_metadata(void);
+void mod_memmap_boot(long delta);
+static inline void mod_memmap(long delta)
+{
+	count_vm_events(NR_MEMMAP, delta);
+}
 
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 70027869d844..60a5faa1f341 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -185,10 +185,10 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 static inline void free_vmemmap_page(struct page *page)
 {
 	if (PageReserved(page)) {
-		mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
+		mod_memmap_boot(-1);
 		free_bootmem_page(page);
 	} else {
-		mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
+		mod_memmap(-1);
 		__free_page(page);
 	}
 }
@@ -341,7 +341,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, vmemmap_pages);
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, 1);
+		mod_memmap(1);
 	}
 
 	/*
@@ -396,7 +396,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 			goto out;
 		list_add(&page->lru, list);
 	}
-	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
+	mod_memmap(nr_pages);
 
 	return 0;
 out:
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..29677274e74e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1623,8 +1623,7 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 		panic("Failed to allocate %ld bytes for node %d memory map\n",
 		      size, pgdat->node_id);
 	pgdat->node_mem_map = map + offset;
-	mod_node_early_perpage_metadata(pgdat->node_id,
-					DIV_ROUND_UP(size, PAGE_SIZE));
+	mod_memmap_boot(DIV_ROUND_UP(size, PAGE_SIZE));
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 		 __func__, pgdat->node_id, (unsigned long)pgdat,
 		 (unsigned long)pgdat->node_mem_map);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 28f80daf5c04..875d76e8684a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5755,7 +5755,6 @@ void __init setup_per_cpu_pageset(void)
 	for_each_online_pgdat(pgdat)
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
-	store_early_perpage_metadata();
 }
 
 __meminit void zone_pcp_init(struct zone *zone)
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 962d45eee1f8..a4b485b39330 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -214,8 +214,7 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
-	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
-			    DIV_ROUND_UP(table_size, PAGE_SIZE));
+	mod_memmap_boot(DIV_ROUND_UP(table_size, PAGE_SIZE));
 	return 0;
 }
 
@@ -275,10 +274,8 @@ static void *__meminit alloc_page_ext(size_t size, int nid)
 	else
 		addr = vzalloc_node(size, nid);
 
-	if (addr) {
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
-				    DIV_ROUND_UP(size, PAGE_SIZE));
-	}
+	if (addr)
+		mod_memmap(DIV_ROUND_UP(size, PAGE_SIZE));
 
 	return addr;
 }
@@ -330,14 +327,12 @@ static void free_page_ext(void *addr)
 	if (is_vmalloc_addr(addr)) {
 		page = vmalloc_to_page(addr);
 		pgdat = page_pgdat(page);
-		mod_node_page_state(pgdat, NR_MEMMAP,
-				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
+		mod_memmap(-1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		vfree(addr);
 	} else {
 		page = virt_to_page(addr);
 		pgdat = page_pgdat(page);
-		mod_node_page_state(pgdat, NR_MEMMAP,
-				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
+		mod_memmap(-1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 1dda6c53370b..307f6fe83598 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,13 +469,10 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
-	if (system_state == SYSTEM_BOOTING) {
-		mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(end - start,
-								  PAGE_SIZE));
-	} else {
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
-				    DIV_ROUND_UP(end - start, PAGE_SIZE));
-	}
+	if (system_state == SYSTEM_BOOTING)
+		mod_memmap_boot(DIV_ROUND_UP(end - start, PAGE_SIZE));
+	else
+		mod_memmap(DIV_ROUND_UP(end - start, PAGE_SIZE));
 
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index e4b830091d13..9cc80ba1f7c1 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -463,7 +463,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
-	mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE));
+	mod_memmap_boot(DIV_ROUND_UP(size, PAGE_SIZE));
 #endif
 }
 
@@ -643,8 +643,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
-			    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
+	mod_memmap(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 04a1cb6cc636..7bee38347f10 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1255,8 +1255,6 @@ const char * const vmstat_text[] = {
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
-	"nr_memmap",
-	"nr_memmap_boot",
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
@@ -1417,6 +1415,8 @@ const char * const vmstat_text[] = {
 	"vma_lock_retry",
 	"vma_lock_miss",
 #endif
+	"nr_memmap",
+	"nr_memmap_boot",
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
@@ -2117,6 +2117,24 @@ static int vmstat_cpu_dead(unsigned int cpu)
 
 #endif
 
+/* nr_memmap_boot that is used prior to setup_per_cpu_areas() call */
+static atomic_long_t early_memmap_boot;
+static bool early_memmap_boot_finished;
+
+void mod_memmap_boot(long delta)
+{
+	if (early_memmap_boot_finished)
+		count_vm_events(NR_MEMMAP_BOOT, delta);
+	else
+		atomic_long_add(delta, &early_memmap_boot);
+}
+
+static void __init finish_early_memmap_boot(void)
+{
+	early_memmap_boot_finished = true;
+	mod_memmap_boot(atomic_long_read(&early_memmap_boot));
+}
+
 struct workqueue_struct *mm_percpu_wq;
 
 void __init init_mm_internals(void)
@@ -2149,6 +2167,7 @@ void __init init_mm_internals(void)
 	proc_create_seq("vmstat", 0444, NULL, &vmstat_op);
 	proc_create_seq("zoneinfo", 0444, NULL, &zoneinfo_op);
 #endif
+	finish_early_memmap_boot();
 }
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_COMPACTION)
@@ -2285,25 +2304,3 @@ static int __init extfrag_debug_init(void)
 module_init(extfrag_debug_init);
 
 #endif
-
-/*
- * Page metadata size (struct page and page_ext) in pages
- */
-static unsigned long early_perpage_metadata[MAX_NUMNODES] __meminitdata;
-
-void __meminit mod_node_early_perpage_metadata(int nid, long delta)
-{
-	early_perpage_metadata[nid] += delta;
-}
-
-void __meminit store_early_perpage_metadata(void)
-{
-	int nid;
-	struct pglist_data *pgdat;
-
-	for_each_online_pgdat(pgdat) {
-		nid = pgdat->node_id;
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
-				    early_perpage_metadata[nid]);
-	}
-}
-- 
2.46.0.76.ge559c4bf1a-goog



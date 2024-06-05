Return-Path: <linux-kernel+bounces-203352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7688FD9DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B951F2788A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BA715FCEB;
	Wed,  5 Jun 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KqW38Ejg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F217345B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717626480; cv=none; b=UbjWWGR+AiIzdVPcL7kzOtSaqvtoqIkxSLcaBd7XQYDRfiYaxxYzrxExwemqO8GfcYj33WdmLQCsEeKDBqA9zcPlregK6jcNHK2znNueGeuZbeh6xsO1ZEnDNs+w0wkMEO/fE/j2lzQeHIopPgxazh38dc8Z50CwTMd/c5qaqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717626480; c=relaxed/simple;
	bh=8Hrj4TE5RX/UsvOIVaysSs8C+8zfkTre2syHaB0tSac=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mNxYKYtoCqGLpvneXMFJdSlJPdgf1rPW6oB5zM5XToelSrhSIH8lVJ3agU8eRE43gaYcX9DxVThUPXjAjvrvYiBTeMs1Vz0ZA9eMjjzHAX3qbi8jqxznOrDCl6eefXgitl+n9zppzowFcBZ6Lp7zr1Mh8arMZj2kqq0fbScKUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KqW38Ejg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfabcc256cdso578285276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717626477; x=1718231277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Q0Q0wa3tfXSBoL1NsxTXiZdJjSmKxrHbLhP2Xd5cpY=;
        b=KqW38Ejgj/asA36T5auFRPaXDEE6Q1M5AWJAg7vfps5icZ8DaPvdy2VYsYhTDoU4mU
         P27EVRWmpK7bdynUbPT6WBFga7sEGE8hfHIicy66YvgER3RzBmNFQU9exBaV1XlcyQkY
         UblkRNS4/poqWMIJLAIODwvz9uC5XlUIvds/z4XIkkaD1rZnB2BOnrDcV4U/GCdTVwHj
         AaBSK5ikOmQywltHDhVgYQl3hNOs9rSqd2IYTUY1VObn3l01tzheXHrFR93DnMX17syt
         uCDVg31oKrbwVsxW0dxBDsE22gYg3r/UJgcAVLBC3cyO7Jj43QJZLnNZgWQCkMom4Kf7
         g+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717626477; x=1718231277;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Q0Q0wa3tfXSBoL1NsxTXiZdJjSmKxrHbLhP2Xd5cpY=;
        b=U9SDMaLjqntVskY2AjImzL+D43kAPKvoOQXQmL7SwukVFb1rCnLkV10KNRf5cruTV2
         twqgDH9r+OibNQYzwOXxZtYB+FpT+NyTrXw9rRWTIONdAXWiqOgSzUEC7ZPQdrCbLjeu
         fR/Dix0+9ZEHcS8oDsPJ3IFuBjYWBb9SvLIJuqIiaZBURy0xYrFDzVL9gLGR3bBH4PVw
         ePvAWpTDFdTdHEaDNUFxMVVaMnRpV6LkKYwVAhkt8rv+YSMC8Sg3PreloKSrjA6ldOcT
         1+m1/zaqwly3Q20DVnLV4RFfFS4JoVeMEmABE5yHW9JMGo25cTdd4HNx6/I8KO2/KRj5
         Am/w==
X-Forwarded-Encrypted: i=1; AJvYcCVJDvgsYgR36Q4ROo7S7yJFgFObl3OvdSrja+f/Aoi3Y6HJMllIiFqOT3tHQK4jlBW3+u+oxf9wfiPstKI7pC0R4rfr4K167JRb9Rlu
X-Gm-Message-State: AOJu0YxBHeaMZnza5yYT4YjIZKUEGGzNpiXChghXJjZF9ax8VaaEAPXE
	Mz1UnCzCvE4doZYfGmHlMCgDbRGEd9cGgT+bnWucvZr5Ak+EJhKBLmaZE17y86qyVQUzxNA8lh8
	hjASpaio6kaOnl2hEDNaEKw==
X-Google-Smtp-Source: AGHT+IGXPjMjFJ10zc2uvGKtEO6W0CWWKU5zbG/sUKhreQen3kRGgueDSN0isP4pHhblea5BrhqzoA7QHfMiINiLmA==
X-Received: from souravbig.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b3a])
 (user=souravpanda job=sendgmr) by 2002:a05:6902:18d3:b0:dfa:6e39:95c6 with
 SMTP id 3f1490d57ef6-dfacad065a2mr1151837276.8.1717626477317; Wed, 05 Jun
 2024 15:27:57 -0700 (PDT)
Date: Wed,  5 Jun 2024 22:27:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605222751.1406125-1-souravpanda@google.com>
Subject: [PATCH v13] mm: report per-page metadata information
From: Sourav Panda <souravpanda@google.com>
To: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, souravpanda@google.com, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org, 
	shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Cc: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"

Today, we do not have any observability of per-page metadata
and how much it takes away from the machine capacity. Thus,
we want to describe the amount of memory that is going towards
per-page metadata, which can vary depending on build
configuration, machine architecture, and system use.

This patch adds 2 fields to /proc/vmstat that can used as shown
below:

Accounting per-page metadata allocated by boot-allocator:
	/proc/vmstat:nr_memmap_boot * PAGE_SIZE

Accounting per-page metadata allocated by buddy-allocator:
	/proc/vmstat:nr_memmap * PAGE_SIZE

Accounting total Perpage metadata allocated on the machine:
	(/proc/vmstat:nr_memmap_boot +
	 /proc/vmstat:nr_memmap) * PAGE_SIZE

Utility for userspace:

Observability: Describe the amount of memory overhead that is
going to per-page metadata on the system at any given time since
this overhead is not currently observable.

Debugging: Tracking the changes or absolute value in struct pages
can help detect anomalies as they can be correlated with other
metrics in the machine (e.g., memtotal, number of huge pages,
etc).

page_ext overheads: Some kernel features such as page_owner
page_table_check that use page_ext can be optionally enabled via
kernel parameters. Having the total per-page metadata information
helps users precisely measure impact. Furthermore, page-metadata
metrics will reflect the amount of struct pages reliquished
(or overhead reduced) when hugetlbfs pages are reserved which
will vary depending on whether hugetlb vmemmap optimization is
enabled or not.

For background and results see:
lore.kernel.org/all/20240220214558.3377482-1-souravpanda@google.com

Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Sourav Panda <souravpanda@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
Changelog:
Synchronized with 6.10-rc2.
Added David Rientjes's Ack.

v12:
https://lore.kernel.org/all/20240512010611.290464-1-souravpanda@google.com
---
 include/linux/mmzone.h |  2 ++
 include/linux/vmstat.h |  4 ++++
 mm/hugetlb_vmemmap.c   | 17 +++++++++++++----
 mm/mm_init.c           |  3 +++
 mm/page_alloc.c        |  1 +
 mm/page_ext.c          | 32 +++++++++++++++++++++++---------
 mm/sparse-vmemmap.c    |  8 ++++++++
 mm/sparse.c            |  7 ++++++-
 mm/vmstat.c            | 26 +++++++++++++++++++++++++-
 9 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8f9c9590a42c..b7546dd8c298 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -220,6 +220,8 @@ enum node_stat_item {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
+	NR_MEMMAP, /* page metadata allocated through buddy allocator */
+	NR_MEMMAP_BOOT, /* page metadata allocated through boot allocator */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 735eae6e272c..16b0cfa80502 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -624,4 +624,8 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
 {
 	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
 }
+
+void __meminit mod_node_early_perpage_metadata(int nid, long delta);
+void __meminit store_early_perpage_metadata(void);
+
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b9a55322e52c..fa00d61b6c5a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -184,10 +184,13 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
  */
 static inline void free_vmemmap_page(struct page *page)
 {
-	if (PageReserved(page))
+	if (PageReserved(page)) {
 		free_bootmem_page(page);
-	else
+		mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
+	} else {
 		__free_page(page);
+		mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
+	}
 }
 
 /* Free a list of the vmemmap pages */
@@ -338,6 +341,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, vmemmap_pages);
+		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, 1);
 	}
 
 	/*
@@ -384,14 +388,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
 	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
+	int i;
 
-	while (nr_pages--) {
+	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page)
+		if (!page) {
+			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i);
 			goto out;
+		}
 		list_add(&page->lru, list);
 	}
 
+	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
+
 	return 0;
 out:
 	list_for_each_entry_safe(page, next, list, lru)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f72b852bd5b8..ca2daf0a6993 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -29,6 +29,7 @@
 #include <linux/cma.h>
 #include <linux/crash_dump.h>
 #include <linux/execmem.h>
+#include <linux/vmstat.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -1618,6 +1619,8 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 		panic("Failed to allocate %ld bytes for node %d memory map\n",
 		      size, pgdat->node_id);
 	pgdat->node_mem_map = map + offset;
+	mod_node_early_perpage_metadata(pgdat->node_id,
+					DIV_ROUND_UP(size, PAGE_SIZE));
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 		 __func__, pgdat->node_id, (unsigned long)pgdat,
 		 (unsigned long)pgdat->node_mem_map);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e22ce5675ca..1f747319f76d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5715,6 +5715,7 @@ void __init setup_per_cpu_pageset(void)
 	for_each_online_pgdat(pgdat)
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
+	store_early_perpage_metadata();
 }
 
 __meminit void zone_pcp_init(struct zone *zone)
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 95dd8ffeaf81..c191e490c401 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -214,6 +214,8 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
+	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
+			    DIV_ROUND_UP(table_size, PAGE_SIZE));
 	return 0;
 }
 
@@ -268,12 +270,15 @@ static void *__meminit alloc_page_ext(size_t size, int nid)
 	void *addr = NULL;
 
 	addr = alloc_pages_exact_nid(nid, size, flags);
-	if (addr) {
+	if (addr)
 		kmemleak_alloc(addr, size, 1, flags);
-		return addr;
-	}
+	else
+		addr = vzalloc_node(size, nid);
 
-	addr = vzalloc_node(size, nid);
+	if (addr) {
+		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
+				    DIV_ROUND_UP(size, PAGE_SIZE));
+	}
 
 	return addr;
 }
@@ -316,18 +321,27 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
 
 static void free_page_ext(void *addr)
 {
+	size_t table_size;
+	struct page *page;
+	struct pglist_data *pgdat;
+
+	table_size = page_ext_size * PAGES_PER_SECTION;
+
 	if (is_vmalloc_addr(addr)) {
+		page = vmalloc_to_page(addr);
+		pgdat = page_pgdat(page);
 		vfree(addr);
 	} else {
-		struct page *page = virt_to_page(addr);
-		size_t table_size;
-
-		table_size = page_ext_size * PAGES_PER_SECTION;
-
+		page = virt_to_page(addr);
+		pgdat = page_pgdat(page);
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
+
+	mod_node_page_state(pgdat, NR_MEMMAP,
+			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
+
 }
 
 static void __free_page_ext(unsigned long pfn)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a2cbe44c48e1..1dda6c53370b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,5 +469,13 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
+	if (system_state == SYSTEM_BOOTING) {
+		mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(end - start,
+								  PAGE_SIZE));
+	} else {
+		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
+				    DIV_ROUND_UP(end - start, PAGE_SIZE));
+	}
+
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index de40b2c73406..973d66a15062 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -14,7 +14,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
-
+#include <linux/vmstat.h>
 #include "internal.h"
 #include <asm/dma.h>
 
@@ -465,6 +465,9 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 */
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+	mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE));
+#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -643,6 +646,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
+			    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8507c497218b..73d791d1caad 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1255,7 +1255,8 @@ const char * const vmstat_text[] = {
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
-
+	"nr_memmap",
+	"nr_memmap_boot",
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
@@ -2282,4 +2283,27 @@ static int __init extfrag_debug_init(void)
 }
 
 module_init(extfrag_debug_init);
+
 #endif
+
+/*
+ * Page metadata size (struct page and page_ext) in pages
+ */
+static unsigned long early_perpage_metadata[MAX_NUMNODES] __meminitdata;
+
+void __meminit mod_node_early_perpage_metadata(int nid, long delta)
+{
+	early_perpage_metadata[nid] += delta;
+}
+
+void __meminit store_early_perpage_metadata(void)
+{
+	int nid;
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		nid = pgdat->node_id;
+		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
+				    early_perpage_metadata[nid]);
+	}
+}
-- 
2.45.1.467.gbab1589fc0-goog



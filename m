Return-Path: <linux-kernel+bounces-280809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4994CF80
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E746F284226
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0619409A;
	Fri,  9 Aug 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDRE0yQF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C02193091
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204152; cv=none; b=qXixcyV4MBQd+9jZKV30sbbmQCH703m/eZsx1adzVxXQW4mon3IedlA247/HqwnAlOFza09GlHyf2HATUVuoIUZAo3QgrRl8nXvOPamPmBaBkEJHWlxdmjP6L2jva9cOdoO7WKKCzhwtLpCXRi0yEWQnKi6MZDmKqZEJqP4w1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204152; c=relaxed/simple;
	bh=acTVWN+uIbt5wIMQ6n+U5b8XonpliA5KJhBSmKOHvF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7l92w3fOTV2Shx83CHVEOU0DmtXsupoPWl4SK1HIFP7NBUutq3eh/woE2K27r+oRrX6odl427hQpVHzsW47td+UZG9PW+Zg9Fb2/ueiHBbVDPz6EAIqsgcHBX+FqcGfHBHA8e4Xaek2qk5H3hcZCIwBDyu7rPjkoXecvMIOA1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDRE0yQF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204150; x=1754740150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=acTVWN+uIbt5wIMQ6n+U5b8XonpliA5KJhBSmKOHvF8=;
  b=XDRE0yQFBTR+yr7R1grSH/sgQhUza7ToFnefO2s82NzcFKr0z23hKLp0
   3UaQ+6wYv0JoxMx+FMB1AHJ8CxDL/lrBi28V8uOehxol4Q5molaoKXBL7
   wpRx7HZS23+gJO0UNUEfo40G75yXiDtJ0Tj/q4Ym/WewJw9qtNmTxKpRW
   SkHTh7vA06c04BZxy7+7DimP/EiHmGkmeKFjIaPnVh7rxWbFZ5vqtqQ4Z
   IkhzE53Ec7Vtgot+FQ6NeObVGIwvSAeYOejYNyXj+5197EcNW1I38U4Cj
   9VhHnZYnT9ZKNPyDH6vuKWmyy5EVuNPxE0ERGbRMOkEL9jpEb2rxnuKmT
   w==;
X-CSE-ConnectionGUID: 6lN8DVTOSgWgdc/b5H7hhA==
X-CSE-MsgGUID: Y8q+u9pESjOqFeGgYG3FSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31999753"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="31999753"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:10 -0700
X-CSE-ConnectionGUID: HrJbWXijSgeDGakcMm7nDg==
X-CSE-MsgGUID: vzukHdihTHeKv189XVMudw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="58108832"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 09 Aug 2024 04:49:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5D9029E0; Fri, 09 Aug 2024 14:49:02 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 5/8] mm: Rework accept memory helpers
Date: Fri,  9 Aug 2024 14:48:51 +0300
Message-ID: <20240809114854.3745464-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
References: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make accept_memory() and range_contains_unaccepted_memory() take 'start'
and 'size' arguments instead of 'start' and 'end'.

Remove accept_page(), replacing it with direct calls to accept_memory().
The accept_page() name is going to be used for a different function.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/boot/compressed/misc.c               |  2 +-
 arch/x86/boot/compressed/misc.h               |  2 +-
 drivers/firmware/efi/libstub/efistub.h        |  2 +-
 .../firmware/efi/libstub/unaccepted_memory.c  |  3 ++-
 drivers/firmware/efi/unaccepted_memory.c      | 18 ++++++++++--------
 include/linux/mm.h                            | 12 +++++-------
 mm/memblock.c                                 |  2 +-
 mm/mm_init.c                                  |  2 +-
 mm/page_alloc.c                               | 19 +++----------------
 tools/testing/memblock/internal.h             |  2 +-
 10 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 944454306ef4..04a35b2c26e9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -511,7 +511,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 
 	if (init_unaccepted_memory()) {
 		debug_putstr("Accepting memory... ");
-		accept_memory(__pa(output), __pa(output) + needed_size);
+		accept_memory(__pa(output), needed_size);
 	}
 
 	entry_offset = decompress_kernel(output, virt_addr, error);
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index b353a7be380c..dd8d1a85f671 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -256,6 +256,6 @@ static inline bool init_unaccepted_memory(void) { return false; }
 
 /* Defined in EFI stub */
 extern struct efi_unaccepted_memory *unaccepted_table;
-void accept_memory(phys_addr_t start, phys_addr_t end);
+void accept_memory(phys_addr_t start, unsigned long size);
 
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d33ccbc4a2c6..685098f9626f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1229,7 +1229,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
 efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 					struct efi_boot_memmap *map);
 void process_unaccepted_memory(u64 start, u64 end);
-void accept_memory(phys_addr_t start, phys_addr_t end);
+void accept_memory(phys_addr_t start, unsigned long size);
 void arch_accept_memory(phys_addr_t start, phys_addr_t end);
 
 #endif
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index c295ea3a6efc..757dbe734a47 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -177,9 +177,10 @@ void process_unaccepted_memory(u64 start, u64 end)
 		   start / unit_size, (end - start) / unit_size);
 }
 
-void accept_memory(phys_addr_t start, phys_addr_t end)
+void accept_memory(phys_addr_t start, unsigned long size)
 {
 	unsigned long range_start, range_end;
+	phys_addr_t end = start + size;
 	unsigned long bitmap_size;
 	u64 unit_size;
 
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 50f6503fe49f..c2c067eff634 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -30,11 +30,12 @@ static LIST_HEAD(accepting_list);
  *  - memory that is below phys_base;
  *  - memory that is above the memory that addressable by the bitmap;
  */
-void accept_memory(phys_addr_t start, phys_addr_t end)
+void accept_memory(phys_addr_t start, unsigned long size)
 {
 	struct efi_unaccepted_memory *unaccepted;
 	unsigned long range_start, range_end;
 	struct accept_range range, *entry;
+	phys_addr_t end = start + size;
 	unsigned long flags;
 	u64 unit_size;
 
@@ -74,13 +75,13 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	 * "guard" page is accepted in addition to the memory that needs to be
 	 * used:
 	 *
-	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
-	 *    checks up to end+unit_size if 'end' is aligned on a unit_size
-	 *    boundary.
+	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, size)
+	 *    checks up to the next unit_size if 'start+size' is aligned on a
+	 *    unit_size boundary.
 	 *
-	 * 2. Implicitly extend accept_memory(start, end) to end+unit_size if
-	 *    'end' is aligned on a unit_size boundary. (immediately following
-	 *    this comment)
+	 * 2. Implicitly extend accept_memory(start, size) to the next unit_size
+	 *    if 'size+end' is aligned on a unit_size boundary. (immediately
+	 *    following this comment)
 	 */
 	if (!(end % unit_size))
 		end += unit_size;
@@ -156,9 +157,10 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
 }
 
-bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
+bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
 {
 	struct efi_unaccepted_memory *unaccepted;
+	phys_addr_t end = start + size;
 	unsigned long flags;
 	bool ret = false;
 	u64 unit_size;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ee8cea73d415..b1eed30fdc06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4062,18 +4062,18 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 
-bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end);
-void accept_memory(phys_addr_t start, phys_addr_t end);
+bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size);
+void accept_memory(phys_addr_t start, unsigned long size);
 
 #else
 
 static inline bool range_contains_unaccepted_memory(phys_addr_t start,
-						    phys_addr_t end)
+						    unsigned long size)
 {
 	return false;
 }
 
-static inline void accept_memory(phys_addr_t start, phys_addr_t end)
+static inline void accept_memory(phys_addr_t start, unsigned long size)
 {
 }
 
@@ -4081,9 +4081,7 @@ static inline void accept_memory(phys_addr_t start, phys_addr_t end)
 
 static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 {
-	phys_addr_t paddr = pfn << PAGE_SHIFT;
-
-	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
+	return range_contains_unaccepted_memory(pfn << PAGE_SHIFT, PAGE_SIZE);
 }
 
 void vma_pgtable_walk_begin(struct vm_area_struct *vma);
diff --git a/mm/memblock.c b/mm/memblock.c
index 3b9dc2d89b8a..0a77a748a8eb 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1500,7 +1500,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	 *
 	 * Accept the memory of the allocated buffer.
 	 */
-	accept_memory(found, found + size);
+	accept_memory(found, size);
 
 	return found;
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 66e596c0129b..7a1a05cb048e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1933,7 +1933,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 	}
 
 	/* Accept chunks smaller than MAX_PAGE_ORDER upfront */
-	accept_memory(PFN_PHYS(pfn), PFN_PHYS(pfn + nr_pages));
+	accept_memory(PFN_PHYS(pfn), nr_pages * PAGE_SIZE);
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f4368c2fa395..e7e304d9e739 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -286,7 +286,6 @@ EXPORT_SYMBOL(nr_online_nodes);
 #endif
 
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
-static void accept_page(struct page *page, unsigned int order);
 static bool cond_accept_memory(struct zone *zone, unsigned int order);
 static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
@@ -1268,7 +1267,7 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
 		if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
 			return;
 
-		accept_page(page, order);
+		accept_memory(page_to_phys(page), PAGE_SIZE << order);
 	}
 
 	/*
@@ -6977,16 +6976,8 @@ early_param("accept_memory", accept_memory_parse);
 static bool page_contains_unaccepted(struct page *page, unsigned int order)
 {
 	phys_addr_t start = page_to_phys(page);
-	phys_addr_t end = start + (PAGE_SIZE << order);
 
-	return range_contains_unaccepted_memory(start, end);
-}
-
-static void accept_page(struct page *page, unsigned int order)
-{
-	phys_addr_t start = page_to_phys(page);
-
-	accept_memory(start, start + (PAGE_SIZE << order));
+	return range_contains_unaccepted_memory(start, PAGE_SIZE << order);
 }
 
 static bool try_to_accept_memory_one(struct zone *zone)
@@ -7011,7 +7002,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	__ClearPageUnaccepted(page);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-	accept_page(page, MAX_PAGE_ORDER);
+	accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
 
 	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
 
@@ -7083,10 +7074,6 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
 	return false;
 }
 
-static void accept_page(struct page *page, unsigned int order)
-{
-}
-
 static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	return false;
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index f6c6e5474c3a..1cf82acb2a3e 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -20,7 +20,7 @@ void memblock_free_pages(struct page *page, unsigned long pfn,
 {
 }
 
-static inline void accept_memory(phys_addr_t start, phys_addr_t end)
+static inline void accept_memory(phys_addr_t start, unsigned long size)
 {
 }
 
-- 
2.43.0



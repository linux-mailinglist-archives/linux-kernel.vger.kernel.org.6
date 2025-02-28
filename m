Return-Path: <linux-kernel+bounces-539175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2745CA4A1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F033AB733
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E5277810;
	Fri, 28 Feb 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K72UMv8P"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B09E277022
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767430; cv=none; b=tzFJVB3AOHo859EbSQ1Rbt+Cbk9xJTCMWBxBguFsfWGe5re+tDnbaBv+ygq+5FyUFAijjUD7Odvl+KBB/wtuHoJhR/lDvGN8lW5ZZTLCD2Pzv5rogRHtzJFHxQV/oLsrjZHaof3a4uu+CA9Ux6v/QDp1L/5j1VItkODdP6ahrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767430; c=relaxed/simple;
	bh=XAMDomxjWmWZdFEDOhshq2O5uzA8ImsIbgaRw92mkBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZTN8XQk4uw9NBTkfCOwH3alVZVVQCYvuJKaEwPWaBUcu/YrCf43kVqTmA5Wn9Z/FURVcgnc3vnb80SAlbyzhWn6KHVJASN7NiHwB9nn8zFMpidWC5/Kpb+q6PdV5TI9VTceMojQRr3ONMMT3ynWsdSmgeuMIGu/G9M9iqLW6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K72UMv8P; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so5261684a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767428; x=1741372228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/PlrUHdXBS5aQMGQGUAn/25QTwI04y5T00xCw9SgH8=;
        b=K72UMv8PCcsKcGBWkFMr58BStg2JlHYO4W+DvAcA270/9GNsKeDm4wCtlX2itJV2dG
         NJcEj3HqBYH1iPG2TTY+557xiCR3gp0KXyosxw1JovxPusOYXwopPT0tq9vms2J5b48s
         DbBYehrUVahrBOuhZmHy2mgP+Y0U02zDazG4TW1g/GK3mBQpLOkKjxAaKn0mD4i9EL2O
         1u+nwCaRSOUPUJhIelgBksbUfkjBl/cvXi2CXbPUSQXN8tMkWHQUsrYdfmMIIpOIqm2m
         IowxLMlinNYqfNl1R6X5g192I0JakcSTRuIOW+hk/YfmljVDXOaX2/j1FAL8ppiJedXp
         ZCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767428; x=1741372228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/PlrUHdXBS5aQMGQGUAn/25QTwI04y5T00xCw9SgH8=;
        b=ts0IbiJ6++I27tbf3cEOFdHEgWzVLzbqWI/cLfh6y/afCcIe2tQImWyrS1NYVgtpHT
         T5lWbyS5LlRQ+9ZuYGZSyPgKsjFzpG1CK5RZ5xRs9pvPqtyZg2BAsueLJxMSx84P6ra5
         z2Vwl5Pk4gKKutoadFgGXfsB85cTFE9jGj+gZtb+MGHtllkvHCONK4EGf+tpN4EP85Wt
         YaQngUST5ow3dba2jQc0Atn28WyKr4d6ZVIkQ+/tm7KbRfHI9Yx6HTN6PVe2VzXWgFY+
         oCfuYyMCERhRj9ksCJ0Vy5flg2ct4uvFb+pAbBHfKWY6+pfeuU/d3Zonk+ggPvBJogIi
         IwOw==
X-Forwarded-Encrypted: i=1; AJvYcCW2S2SAWakVu8ZySeb0BoCk+e81TW3LUuC80p+9UuwbHXxFLNt0ibSsCPGfUbG5kjjQEiL7/sxUxAsxzmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9VIHVfskVjGVVHyzZBj7rvpb0wsMB6Xr3SEWhWpwvwRvjxlS
	r9SU2tP7NHd2bvGypT0TyqH32v3lF4n2H4X1BMfCFdNiam5EJV6xdzvHDAB4nAksZ/63dA==
X-Google-Smtp-Source: AGHT+IE9hv4JieOLsrmBlcdFHGW2nIb9erq5H77qZHSPmE2pf3XgwT3SfOsT16N+0hOwK5A8lx3Kobsp
X-Received: from pjbpd10.prod.google.com ([2002:a17:90b:1dca:b0:2fa:15aa:4d1e])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3845:b0:2ee:b6c5:1def
 with SMTP id 98e67ed59e1d1-2febab3e271mr7456963a91.8.1740767427793; Fri, 28
 Feb 2025 10:30:27 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:25 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-25-fvdl@google.com>
Subject: [PATCH v5 24/27] mm/cma: introduce interface for early reservations
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

It can be desirable to reserve memory in a CMA area before
it is activated, early in boot. Such reservations would
effectively be memblock allocations, but they can be
returned to the CMA area later. This functionality can
be used to allow hugetlb bootmem allocations from a
hugetlb CMA area.

A new interface, cma_reserve_early is introduced. This allows
for pageblock-aligned reservations. These reservations are
skipped during the initial handoff of pages in a CMA area
to the buddy allocator. The caller is responsible for making
sure that the page structures are set up, and that the migrate
type is set correctly, as with other memblock allocations that
stick around. If the CMA area fails to activate (because it
intersects with multiple zones), the reserved memory is not
given to the buddy allocator, the caller needs to take care
of that.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/cma.c      | 83 ++++++++++++++++++++++++++++++++++++++++++++++-----
 mm/cma.h      |  8 +++++
 mm/internal.h | 16 ++++++++++
 mm/mm_init.c  |  9 ++++++
 4 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 5e1d169e24fa..09322b8284bd 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -144,9 +144,10 @@ bool cma_validate_zones(struct cma *cma)
 
 static void __init cma_activate_area(struct cma *cma)
 {
-	unsigned long pfn, base_pfn;
+	unsigned long pfn, end_pfn;
 	int allocrange, r;
 	struct cma_memrange *cmr;
+	unsigned long bitmap_count, count;
 
 	for (allocrange = 0; allocrange < cma->nranges; allocrange++) {
 		cmr = &cma->ranges[allocrange];
@@ -161,8 +162,13 @@ static void __init cma_activate_area(struct cma *cma)
 
 	for (r = 0; r < cma->nranges; r++) {
 		cmr = &cma->ranges[r];
-		base_pfn = cmr->base_pfn;
-		for (pfn = base_pfn; pfn < base_pfn + cmr->count;
+		if (cmr->early_pfn != cmr->base_pfn) {
+			count = cmr->early_pfn - cmr->base_pfn;
+			bitmap_count = cma_bitmap_pages_to_bits(cma, count);
+			bitmap_set(cmr->bitmap, 0, bitmap_count);
+		}
+
+		for (pfn = cmr->early_pfn; pfn < cmr->base_pfn + cmr->count;
 		     pfn += pageblock_nr_pages)
 			init_cma_reserved_pageblock(pfn_to_page(pfn));
 	}
@@ -173,6 +179,7 @@ static void __init cma_activate_area(struct cma *cma)
 	INIT_HLIST_HEAD(&cma->mem_head);
 	spin_lock_init(&cma->mem_head_lock);
 #endif
+	set_bit(CMA_ACTIVATED, &cma->flags);
 
 	return;
 
@@ -184,9 +191,8 @@ static void __init cma_activate_area(struct cma *cma)
 	if (!test_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags)) {
 		for (r = 0; r < allocrange; r++) {
 			cmr = &cma->ranges[r];
-			for (pfn = cmr->base_pfn;
-			     pfn < cmr->base_pfn + cmr->count;
-			     pfn++)
+			end_pfn = cmr->base_pfn + cmr->count;
+			for (pfn = cmr->early_pfn; pfn < end_pfn; pfn++)
 				free_reserved_page(pfn_to_page(pfn));
 		}
 	}
@@ -290,6 +296,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 		return ret;
 
 	cma->ranges[0].base_pfn = PFN_DOWN(base);
+	cma->ranges[0].early_pfn = PFN_DOWN(base);
 	cma->ranges[0].count = cma->count;
 	cma->nranges = 1;
 	cma->nid = NUMA_NO_NODE;
@@ -509,6 +516,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 		    nr, (u64)mlp->base, (u64)mlp->base + size);
 		cmrp = &cma->ranges[nr++];
 		cmrp->base_pfn = PHYS_PFN(mlp->base);
+		cmrp->early_pfn = cmrp->base_pfn;
 		cmrp->count = size >> PAGE_SHIFT;
 
 		sizeleft -= size;
@@ -540,7 +548,6 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 		pr_info("Reserved %lu MiB in %d range%s\n",
 			(unsigned long)total_size / SZ_1M, nr,
 			nr > 1 ? "s" : "");
-
 	return ret;
 }
 
@@ -1034,3 +1041,65 @@ bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end)
 
 	return false;
 }
+
+/*
+ * Very basic function to reserve memory from a CMA area that has not
+ * yet been activated. This is expected to be called early, when the
+ * system is single-threaded, so there is no locking. The alignment
+ * checking is restrictive - only pageblock-aligned areas
+ * (CMA_MIN_ALIGNMENT_BYTES) may be reserved through this function.
+ * This keeps things simple, and is enough for the current use case.
+ *
+ * The CMA bitmaps have not yet been allocated, so just start
+ * reserving from the bottom up, using a PFN to keep track
+ * of what has been reserved. Unreserving is not possible.
+ *
+ * The caller is responsible for initializing the page structures
+ * in the area properly, since this just points to memblock-allocated
+ * memory. The caller should subsequently use init_cma_pageblock to
+ * set the migrate type and CMA stats  the pageblocks that were reserved.
+ *
+ * If the CMA area fails to activate later, memory obtained through
+ * this interface is not handed to the page allocator, this is
+ * the responsibility of the caller (e.g. like normal memblock-allocated
+ * memory).
+ */
+void __init *cma_reserve_early(struct cma *cma, unsigned long size)
+{
+	int r;
+	struct cma_memrange *cmr;
+	unsigned long available;
+	void *ret = NULL;
+
+	if (!cma || !cma->count)
+		return NULL;
+	/*
+	 * Can only be called early in init.
+	 */
+	if (test_bit(CMA_ACTIVATED, &cma->flags))
+		return NULL;
+
+	if (!IS_ALIGNED(size, CMA_MIN_ALIGNMENT_BYTES))
+		return NULL;
+
+	if (!IS_ALIGNED(size, (PAGE_SIZE << cma->order_per_bit)))
+		return NULL;
+
+	size >>= PAGE_SHIFT;
+
+	if (size > cma->available_count)
+		return NULL;
+
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+		available = cmr->count - (cmr->early_pfn - cmr->base_pfn);
+		if (size <= available) {
+			ret = phys_to_virt(PFN_PHYS(cmr->early_pfn));
+			cmr->early_pfn += size;
+			cma->available_count -= size;
+			return ret;
+		}
+	}
+
+	return ret;
+}
diff --git a/mm/cma.h b/mm/cma.h
index bddc84b3cd96..df7fc623b7a6 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -16,9 +16,16 @@ struct cma_kobject {
  * and the total amount of memory requested, while smaller than the total
  * amount of memory available, is large enough that it doesn't fit in a
  * single physical memory range because of memory holes.
+ *
+ * Fields:
+ *   @base_pfn: physical address of range
+ *   @early_pfn: first PFN not reserved through cma_reserve_early
+ *   @count: size of range
+ *   @bitmap: bitmap of allocated (1 << order_per_bit)-sized chunks.
  */
 struct cma_memrange {
 	unsigned long base_pfn;
+	unsigned long early_pfn;
 	unsigned long count;
 	unsigned long *bitmap;
 #ifdef CONFIG_CMA_DEBUGFS
@@ -58,6 +65,7 @@ enum cma_flags {
 	CMA_RESERVE_PAGES_ON_ERROR,
 	CMA_ZONES_VALID,
 	CMA_ZONES_INVALID,
+	CMA_ACTIVATED,
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
diff --git a/mm/internal.h b/mm/internal.h
index 63fda9bb9426..8318c8e6e589 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -848,6 +848,22 @@ void init_cma_reserved_pageblock(struct page *page);
 
 #endif /* CONFIG_COMPACTION || CONFIG_CMA */
 
+struct cma;
+
+#ifdef CONFIG_CMA
+void *cma_reserve_early(struct cma *cma, unsigned long size);
+void init_cma_pageblock(struct page *page);
+#else
+static inline void *cma_reserve_early(struct cma *cma, unsigned long size)
+{
+	return NULL;
+}
+static inline void init_cma_pageblock(struct page *page)
+{
+}
+#endif
+
+
 int find_suitable_fallback(struct free_area *area, unsigned int order,
 			int migratetype, bool only_stealable, bool *can_steal);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f7d5b4fe1ae9..f31260fd393e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2263,6 +2263,15 @@ void __init init_cma_reserved_pageblock(struct page *page)
 	adjust_managed_page_count(page, pageblock_nr_pages);
 	page_zone(page)->cma_pages += pageblock_nr_pages;
 }
+/*
+ * Similar to above, but only set the migrate type and stats.
+ */
+void __init init_cma_pageblock(struct page *page)
+{
+	set_pageblock_migratetype(page, MIGRATE_CMA);
+	adjust_managed_page_count(page, pageblock_nr_pages);
+	page_zone(page)->cma_pages += pageblock_nr_pages;
+}
 #endif
 
 void set_zone_contiguous(struct zone *zone)
-- 
2.48.1.711.g2feabab25a-goog



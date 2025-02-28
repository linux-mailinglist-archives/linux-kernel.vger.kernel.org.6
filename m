Return-Path: <linux-kernel+bounces-539164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB77A4A1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED203AAE22
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0741230BEA;
	Fri, 28 Feb 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXl1N/58"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C911F874E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767413; cv=none; b=h7xCI1y1wiaiDlw6SAM7yroIcyJt1DG7kEbaObf2NBM/bIr6yeH2MUD9FTRX61oAN7TwJ+bbDMMhdMmAJrFHF7P9G/vOhe47KifXH1XtYIZdaK0HPc5yqpczhGG8XzDaJg0CMCRfPtDfo52IE4zqnwINfmusGnDaymnCAcp8xYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767413; c=relaxed/simple;
	bh=nk+w7m9EFQ6Dot3B6gOWwpxoc4h88RVejZ123Fmm/mw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duEOJ1JeSGL4gaP89IIy+eNaP+xEbAgsUbmiZ0MDkPM30VES9IpXqzCNrFrkDE7JXqz7H4I9Qc1bUe5XZtrNKE2WZhRQU18gpFU21Rc0bvpCJFzacE1MNCZ5QOMYAWiIxZuZ4wH3g88+X62JcfUJSQhdMpHNtGGe3WewXXqejXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXl1N/58; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe86c01f5cso5129849a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767410; x=1741372210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BnmSyjAWl8KyXjU3dkeSbWxZ2sVLeXlaOuN4oJvYMc=;
        b=TXl1N/58XUV01vIt6mbcaNF9i70uldmR/COBcIdD8hrQoMS7BkJNOQnR3dnAu9etoG
         9DuHsuakY6aUbGoB7U0qLVLGc3a2IZmQTT6O92UsJzp+7jlZvymV0ralMyNGd/AoywSi
         uv0On7Dd+3KwI6uTidyoEzyIpArxvN02z3PYC5gESF2zcSiWUc3mD60llEqQTrRFvYpB
         UUgpsBkw4uhxgfS0bnlcG0tp01JgrTSviwERNRLOUzWqAhVoMJTWllm+WVbxLRaWMrVv
         BAWIh8puAADMVFzDE2YpJlt8t/RNd1BNOEHH7exXu0vUoTvmfk0TGQlAbFDWmxBLWiSz
         3lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767410; x=1741372210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BnmSyjAWl8KyXjU3dkeSbWxZ2sVLeXlaOuN4oJvYMc=;
        b=pxqsc9+lVZbptYrTl7VuuLH/YgAqnEEcdFB+insxdH5h+TDdheiveJAJbZz5Qgxllb
         DEihHWvWk0PB4UgCW9YmB0IMO7c/QfdxFAJwzIEcsI9ZlY2Hk7s7P7343IqXxssEhgh4
         zn+Z6PhZOOaSqZTo3rimtY72q8fNPZV1YeAEfNUpYA8JVhCbEn7OaHmKaDP6mebihJge
         i9JTbU2p+5UfIuHfU2oDA9/XvD+oeAjb1Kxa7jd0q/b5rDd4Eau7w7i4TvC8qEczu4Oi
         OeHNG9jVVPMn9OjNWNZ+KSET3aj7f/t12kaVWhfvcSbuq/dWLqhFKULLgxZrbiyD/1vo
         13bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJr5gJYP044WT9Kuc+01NIM+R7mQCeLSYwUC6RX15HHb8owwUC6u+ysv8BpUeTxPzHu3BTp+04MRY+HXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyocpdGr6hDLqsPRl01kkBE5vLN8F3I4KeKJYLpQv29VMscuW7g
	Eufm4ldWngFqGzzlvcgKBDYrEJIE6FeDnlWqJgjDaIkxy1GZ5k/iOzXTz5kOrBGQ/9Vrsw==
X-Google-Smtp-Source: AGHT+IHkA2l5A4sRrVBTdd/1UDvjktTBUXrR2r60wNN+pEhOugKCAuRSJ2vy2XoSkO7SYrkW3vFR2Pm+
X-Received: from pgmm31.prod.google.com ([2002:a05:6a02:551f:b0:ad5:52c1:c4d0])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1595:b0:1ee:d6a7:e341
 with SMTP id adf61e73a8af0-1f2f4e45091mr9004502637.30.1740767410238; Fri, 28
 Feb 2025 10:30:10 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:14 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-14-fvdl@google.com>
Subject: [PATCH v5 13/27] mm/hugetlb: check bootmem pages for zone intersections
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Bootmem hugetlb pages are allocated using memblock, which isn't
(and mostly can't be) aware of zones.

So, they may end up crossing zone boundaries. This would create
confusion, a hugetlb page that is part of multiple zones is bad.
Worse, HVO might then end up stealthily re-assigning pages to a
different zone when a hugetlb page is freed, since the tail page
structures beyond the first vmemmap page would inherit the zone
of the first page structures.

While the chance of this happening is low, you can definitely
create a configuration where this happens (especially using
ZONE_MOVABLE).

To avoid this issue, check if bootmem hugetlb pages intersect
with multiple zones during the gather phase, and discard
them, handing them to the page allocator, if they do. Record
the number of invalid bootmem pages per node and subtract them
from the number of available pages at the end, making it easier
to do these checks in multiple places later on.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c  | 61 +++++++++++++++++++++++++++++++++++++++++++++++++--
 mm/internal.h |  2 ++
 mm/mm_init.c  | 25 +++++++++++++++++++++
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 19a7a795a388..f9704a0e62de 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -62,6 +62,7 @@ static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
 static unsigned long hugetlb_cma_size __initdata;
 
 __initdata struct list_head huge_boot_pages[MAX_NUMNODES];
+static unsigned long hstate_boot_nrinvalid[HUGE_MAX_HSTATE] __initdata;
 
 /*
  * Due to ordering constraints across the init code for various
@@ -3304,6 +3305,44 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	}
 }
 
+static bool __init hugetlb_bootmem_page_zones_valid(int nid,
+						    struct huge_bootmem_page *m)
+{
+	unsigned long start_pfn;
+	bool valid;
+
+	start_pfn = virt_to_phys(m) >> PAGE_SHIFT;
+
+	valid = !pfn_range_intersects_zones(nid, start_pfn,
+			pages_per_huge_page(m->hstate));
+	if (!valid)
+		hstate_boot_nrinvalid[hstate_index(m->hstate)]++;
+
+	return valid;
+}
+
+/*
+ * Free a bootmem page that was found to be invalid (intersecting with
+ * multiple zones).
+ *
+ * Since it intersects with multiple zones, we can't just do a free
+ * operation on all pages at once, but instead have to walk all
+ * pages, freeing them one by one.
+ */
+static void __init hugetlb_bootmem_free_invalid_page(int nid, struct page *page,
+					     struct hstate *h)
+{
+	unsigned long npages = pages_per_huge_page(h);
+	unsigned long pfn;
+
+	while (npages--) {
+		pfn = page_to_pfn(page);
+		__init_reserved_page_zone(pfn, nid);
+		free_reserved_page(page);
+		page++;
+	}
+}
+
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
@@ -3311,14 +3350,25 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 static void __init gather_bootmem_prealloc_node(unsigned long nid)
 {
 	LIST_HEAD(folio_list);
-	struct huge_bootmem_page *m;
+	struct huge_bootmem_page *m, *tm;
 	struct hstate *h = NULL, *prev_h = NULL;
 
-	list_for_each_entry(m, &huge_boot_pages[nid], list) {
+	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
 
 		h = m->hstate;
+		if (!hugetlb_bootmem_page_zones_valid(nid, m)) {
+			/*
+			 * Can't use this page. Initialize the
+			 * page structures if that hasn't already
+			 * been done, and give them to the page
+			 * allocator.
+			 */
+			hugetlb_bootmem_free_invalid_page(nid, page, h);
+			continue;
+		}
+
 		/*
 		 * It is possible to have multiple huge page sizes (hstates)
 		 * in this list.  If so, process each size separately.
@@ -3590,13 +3640,20 @@ static void __init hugetlb_init_hstates(void)
 static void __init report_hugepages(void)
 {
 	struct hstate *h;
+	unsigned long nrinvalid;
 
 	for_each_hstate(h) {
 		char buf[32];
 
+		nrinvalid = hstate_boot_nrinvalid[hstate_index(h)];
+		h->max_huge_pages -= nrinvalid;
+
 		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
 		pr_info("HugeTLB: registered %s page size, pre-allocated %ld pages\n",
 			buf, h->free_huge_pages);
+		if (nrinvalid)
+			pr_info("HugeTLB: %s page size: %lu invalid page%s discarded\n",
+					buf, nrinvalid, nrinvalid > 1 ? "s" : "");
 		pr_info("HugeTLB: %d KiB vmemmap can be freed for a %s page\n",
 			hugetlb_vmemmap_optimizable_size(h) / SZ_1K, buf);
 	}
diff --git a/mm/internal.h b/mm/internal.h
index 57662141930e..63fda9bb9426 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -658,6 +658,8 @@ static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
 }
 
 void set_zone_contiguous(struct zone *zone);
+bool pfn_range_intersects_zones(int nid, unsigned long start_pfn,
+			   unsigned long nr_pages);
 
 static inline void clear_zone_contiguous(struct zone *zone)
 {
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 925ed6564572..f7d5b4fe1ae9 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2287,6 +2287,31 @@ void set_zone_contiguous(struct zone *zone)
 	zone->contiguous = true;
 }
 
+/*
+ * Check if a PFN range intersects multiple zones on one or more
+ * NUMA nodes. Specify the @nid argument if it is known that this
+ * PFN range is on one node, NUMA_NO_NODE otherwise.
+ */
+bool pfn_range_intersects_zones(int nid, unsigned long start_pfn,
+			   unsigned long nr_pages)
+{
+	struct zone *zone, *izone = NULL;
+
+	for_each_zone(zone) {
+		if (nid != NUMA_NO_NODE && zone_to_nid(zone) != nid)
+			continue;
+
+		if (zone_intersects(zone, start_pfn, nr_pages)) {
+			if (izone != NULL)
+				return true;
+			izone = zone;
+		}
+
+	}
+
+	return false;
+}
+
 static void __init mem_init_print_info(void);
 void __init page_alloc_init_late(void)
 {
-- 
2.48.1.711.g2feabab25a-goog



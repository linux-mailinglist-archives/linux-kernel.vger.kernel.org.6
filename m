Return-Path: <linux-kernel+bounces-539169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77205A4A1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21536169EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5637E279E57;
	Fri, 28 Feb 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLq0BIfO"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D30279E29
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767421; cv=none; b=MvaVuudSipKURnCgwcZoijDGn1L73ymVP2N6A+y0hCU89FSo2y95VbBMplYOzlFMSEBoGbyIqcjLVs9XhfJu3B6ZnKhf1u/6iE5GqgfGhGAIKNckb8I9aA1V7DVXvj+mg8mSHUXiUwBSfsw71qciXBJ56HgRwt9QyWzX1VRl50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767421; c=relaxed/simple;
	bh=BTBW1tDeHJiufkXqfh5GFKAfdZqamOsTHrNHihF2tbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AB7sYz0S2xZcwlLa6w0qtYovH0mDx8hivPb1wn2tdGosI17GBiy3MrTEuQmQUAHET82r/LSkGMiXk0pvuDUNZw8ahJL1O98rK9CyNdpWUtS+mamY83/CzFy0Ipl/xPynK3xxivjGzKR7tQQ399F8+byI9T0stVPAjMlKlOTQYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLq0BIfO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22349ce68a9so77550215ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767417; x=1741372217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+u9YpCDfOddo7IoooZ06HWMpfAumbRB14bwYiVvX4Wo=;
        b=gLq0BIfOL6DAf5PJzIMuE3ucUmpHKdZNxbetwBLNfBchb3e9uHlQ01lUtzWZlbJbPw
         NaS8WolnD8C7nEOsVOdqEwu/kBT9LvKs/g6xsmgsRKj6UI06bLbPvTf06qRmpZKv6DFn
         afEz97bZwqWwectkKxZzJmpZYZTwpwyOkYrwzjZD4CsGDr2l+QX+pwxAXo8jEZ1gUJXN
         4plPU5lE/DB2M+IuPw9/Le4YZAeTRbBKKGXMsnbGHeGS94ptn/GHDBUWRSLvay99kqjI
         nB4xMgPrTA/ZNdJaFzP8tt0bnreBYmyvIy08MU7BVXoAY0obaOQkRavMs4CMCL7jTlPk
         vGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767417; x=1741372217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+u9YpCDfOddo7IoooZ06HWMpfAumbRB14bwYiVvX4Wo=;
        b=n5+Lu+kQUCMiRQiCf+9df8kq3lONaeYN1myzhi8hoAHPxLWZjfsK1hzXuPAhP2ximB
         B0Oqn2TL89KCvMsUe9gBh4yeLMYawbP+Gu8QGruzeogdX09LvlZ6NxUzkD4sA41RRCkP
         m6WBB0AKkEQXVh7zUoch00WNotNSBaHit/Sd7y/RyUy44ZuDaouU5wCUs5u7TQiJxMZn
         Zg79jVGbq3fKwGki7c5y9jc3cLJFU2GEwNoFxuIc1CU8J971OtR2FVCRCpb1aOo26yRr
         YRAIULbifIUZ4C5ezgpjftclG3jVZ8wy3vrTi34W6f+3yWqy6m3zLlI7nHWEVRGg83YN
         uwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Du71L1sUUaf8FHqsG4z2ntyqV5vEhlWS2Wj+3ucR+8wYgD4KFU3bMXT7Fdcp+q1UV0VbZoXzLK7ntF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bPv2bmPVQfAaICW1tCGoYir6l+Q/05QSGyZpDBnOjrL6RB1y
	GQqU1YQFrW8hYAbfhYxHFTIxdTWWKDYTyfO6IxrLNoynzQ03OPNfWU9rYHIpOGycy8380Q==
X-Google-Smtp-Source: AGHT+IHTbxxgSRmI9JPbjqv6YVWrtnqd2U549w4/Q1RWPys+2AxjBGjQpLOqvUpKa1VvMDtiAePntETH
X-Received: from pgc16.prod.google.com ([2002:a05:6a02:2f90:b0:aeb:ac4a:ebf6])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:788a:b0:1ee:d438:3fb4
 with SMTP id adf61e73a8af0-1f2f4e0142emr6186292637.28.1740767416720; Fri, 28
 Feb 2025 10:30:16 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:18 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-18-fvdl@google.com>
Subject: [PATCH v5 17/27] mm/hugetlb: add pre-HVO framework
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Define flags for pre-HVOed bootmem hugetlb pages, and act on them.

The most important flag is the HVO flag, signalling that a bootmem
allocated gigantic page has already been HVO-ed. If this flag is
seen by the hugetlb bootmem gather code, the page is marked
as HVO optimized. The HVO code will then not try to optimize
it again. Instead, it will just map the tail page mirror pages
read-only, completing the HVO steps.

No functional change, as nothing sets the flags yet.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/powerpc/mm/hugetlbpage.c |  1 +
 include/linux/hugetlb.h       |  4 +++
 mm/hugetlb.c                  | 24 ++++++++++++++++-
 mm/hugetlb_vmemmap.c          | 50 +++++++++++++++++++++++++++++++++--
 mm/hugetlb_vmemmap.h          |  7 +++++
 5 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 6b043180220a..d3c1b749dcfc 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -113,6 +113,7 @@ static int __init pseries_alloc_bootmem_huge_page(struct hstate *hstate)
 	gpage_freearray[nr_gpages] = 0;
 	list_add(&m->list, &huge_boot_pages[0]);
 	m->hstate = hstate;
+	m->flags = 0;
 	return 1;
 }
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5061279e5f73..10a7ce2b95e1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -681,8 +681,12 @@ struct hstate {
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
+	unsigned long flags;
 };
 
+#define HUGE_BOOTMEM_HVO		0x0001
+#define HUGE_BOOTMEM_ZONES_VALID	0x0002
+
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0f14a7736875..40c88c46b34f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3215,6 +3215,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	INIT_LIST_HEAD(&m->list);
 	list_add(&m->list, &huge_boot_pages[node]);
 	m->hstate = h;
+	m->flags = 0;
 	return 1;
 }
 
@@ -3282,7 +3283,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	struct folio *folio, *tmp_f;
 
 	/* Send list for bulk vmemmap optimization processing */
-	hugetlb_vmemmap_optimize_folios(h, folio_list);
+	hugetlb_vmemmap_optimize_bootmem_folios(h, folio_list);
 
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
 		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
@@ -3311,6 +3312,13 @@ static bool __init hugetlb_bootmem_page_zones_valid(int nid,
 	unsigned long start_pfn;
 	bool valid;
 
+	if (m->flags & HUGE_BOOTMEM_ZONES_VALID) {
+		/*
+		 * Already validated, skip check.
+		 */
+		return true;
+	}
+
 	start_pfn = virt_to_phys(m) >> PAGE_SHIFT;
 
 	valid = !pfn_range_intersects_zones(nid, start_pfn,
@@ -3343,6 +3351,11 @@ static void __init hugetlb_bootmem_free_invalid_page(int nid, struct page *page,
 	}
 }
 
+static bool __init hugetlb_bootmem_page_prehvo(struct huge_bootmem_page *m)
+{
+	return (m->flags & HUGE_BOOTMEM_HVO);
+}
+
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
@@ -3383,6 +3396,15 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		hugetlb_folio_init_vmemmap(folio, h,
 					   HUGETLB_VMEMMAP_RESERVE_PAGES);
 		init_new_hugetlb_folio(h, folio);
+
+		if (hugetlb_bootmem_page_prehvo(m))
+			/*
+			 * If pre-HVO was done, just set the
+			 * flag, the HVO code will then skip
+			 * this folio.
+			 */
+			folio_set_hugetlb_vmemmap_optimized(folio);
+
 		list_add(&folio->lru, &folio_list);
 
 		/*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 5b484758f813..be6b33ecbc8e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -649,14 +649,39 @@ static int hugetlb_vmemmap_split_folio(const struct hstate *h, struct folio *fol
 	return vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
 }
 
-void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
+					      struct list_head *folio_list,
+					      bool boot)
 {
 	struct folio *folio;
+	int nr_to_optimize;
 	LIST_HEAD(vmemmap_pages);
 	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH | VMEMMAP_SYNCHRONIZE_RCU;
 
+	nr_to_optimize = 0;
 	list_for_each_entry(folio, folio_list, lru) {
-		int ret = hugetlb_vmemmap_split_folio(h, folio);
+		int ret;
+		unsigned long spfn, epfn;
+
+		if (boot && folio_test_hugetlb_vmemmap_optimized(folio)) {
+			/*
+			 * Already optimized by pre-HVO, just map the
+			 * mirrored tail page structs RO.
+			 */
+			spfn = (unsigned long)&folio->page;
+			epfn = spfn + pages_per_huge_page(h);
+			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
+					HUGETLB_VMEMMAP_RESERVE_SIZE);
+			register_page_bootmem_memmap(pfn_to_section_nr(spfn),
+					&folio->page,
+					HUGETLB_VMEMMAP_RESERVE_SIZE);
+			static_branch_inc(&hugetlb_optimize_vmemmap_key);
+			continue;
+		}
+
+		nr_to_optimize++;
+
+		ret = hugetlb_vmemmap_split_folio(h, folio);
 
 		/*
 		 * Spliting the PMD requires allocating a page, thus lets fail
@@ -668,6 +693,16 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			break;
 	}
 
+	if (!nr_to_optimize)
+		/*
+		 * All pre-HVO folios, nothing left to do. It's ok if
+		 * there is a mix of pre-HVO and not yet HVO-ed folios
+		 * here, as __hugetlb_vmemmap_optimize_folio() will
+		 * skip any folios that already have the optimized flag
+		 * set, see vmemmap_should_optimize_folio().
+		 */
+		goto out;
+
 	flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
@@ -693,10 +728,21 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		}
 	}
 
+out:
 	flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+	__hugetlb_vmemmap_optimize_folios(h, folio_list, false);
+}
+
+void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list)
+{
+	__hugetlb_vmemmap_optimize_folios(h, folio_list, true);
+}
+
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 2fcae92d3359..71110a90275f 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -24,6 +24,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *non_hvo_folios);
 void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
+void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
+
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
@@ -64,6 +66,11 @@ static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list
 {
 }
 
+static inline void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h,
+						struct list_head *folio_list)
+{
+}
+
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
-- 
2.48.1.711.g2feabab25a-goog



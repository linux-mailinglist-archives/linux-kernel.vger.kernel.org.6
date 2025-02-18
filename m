Return-Path: <linux-kernel+bounces-520062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7BEA3A52C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65E47A1E39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220B1F5826;
	Tue, 18 Feb 2025 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyF2YVok"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A41EB5E3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902655; cv=none; b=QzFuSljVp5nUBLTx5U3lVEkw3Sp2cqmQsE7yGGfY+8Ii/YgxYHmIkO/0XXMKeWtTLJ1DDIpJkO8nRpiqzmsKPt5KSDRAEFZ6gPruu/rIZRjyzJZ4mDQ50mtpIzOyhqGSdwvJcbBA86s2HFwgerlJRpGW4cT3V4mOEz+Ui8okUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902655; c=relaxed/simple;
	bh=6rL5XsQqLmAM3/QTv5Pq3435H2aSbjq4wyksyHLtiUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8J78zQ/fRReKV926tv6mZaRfHswrUfqWcBtZX3lvJ3VNkAcQHB6M7JH7ebfCg0vTqu5/byMc2gcxh9+BFwT0jMTUp5h/uGj7l/5RSHBxeW3w2OHlNybIt7iPw9YkWaHnx5qphFv4b0CUo/IpO1tYkFY+MVMUzjQx80wAx7ryBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyF2YVok; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220cb5924a4so186591075ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902653; x=1740507453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H28KJe5MgacBIfLyyRLl5z2RjmgjIpFaHKUhXqFLNBk=;
        b=eyF2YVokoUfBXhN+lIudQ4czHMP2QGjuhJSM7nSxe0B0yze8AMrDzSz5+mei4dwhfR
         YNxfFAZGP6OyAphzZC4MVoq1QI4YkJAEH11q8JRR1SXAhsnbKBs6azVwM11jiWy6os/G
         VGVb5CBUcvjDSVYyaRxMS6m467Jg1aPbMg4Ci25oxpVmctr+9DI8cURgz8pOb2SSVMov
         OaD5s00cd/Ty3jtpzKht6+SnqaibM6rRqcdd1FyfMa5acBtnfit94uRUHz9mFsaI95sb
         lxn4D3QbazgO5eOLTbcNR9sViWl9QoK1CQslJIsmKck7IDMDamHsRZQi482Yy8bxqW3k
         /grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902653; x=1740507453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H28KJe5MgacBIfLyyRLl5z2RjmgjIpFaHKUhXqFLNBk=;
        b=m0BkHyKgAa5trxLU5fymGUdRaqqWEvEVn+nEkARpQNSvC/j5iISGIuaDSukSM/XSmb
         glJH8JeUI1mSbdQd1iVTP9sbL645xeE2dLFcAAw4MjyYjOkNDNV+NWIzzgsEO3JdQ3Wm
         K0p3y3dp1qgSB1SUUi/Byv3tADyJa43+9BMvNeFx2WRZ3Ct6hpx5YI0H8gqOsLpdoxjT
         9LLhd75ZUJViqS6WxHPpDEvqjl93guALPdnP0zi85uTqlCeMwBsMo6aN7NKn/lnaMGxp
         czLuySjybW6cszBq8p1Gp/FecdV3Bxy+FqL221BNhNetrRpMQhuzVfvoGfiBWTesckHH
         JQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEjE0lPIpsNyGT5nxg+TnlQUzqhI03VlbkejnNJP0fdw2P5g3RAKPQfHA9a0V5bhGZikzHthsn5bh3Z/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3QMlzN5kuOsvhlxAdGb5NIQ/lcO3RbN7ASMxxr44rcAec55T
	1YQtSgf284X1zgZyDubTfZSXcVym45f/+5Et9U1CQQwS4V8ULhiKxZ1ctIi+gu0wxOPM0A==
X-Google-Smtp-Source: AGHT+IG4XHG+Obo1vJ71xPprSQ0S+R8qkhjNyCp62AyEMPWnIwuFAP+MCFzfVR2WL5XMuvsvHBwfCzzT
X-Received: from pfnd20.prod.google.com ([2002:aa7:8154:0:b0:732:730c:9012])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a121:b0:1ee:c3dc:974f
 with SMTP id adf61e73a8af0-1eec3dc9937mr8778861637.25.1739902653508; Tue, 18
 Feb 2025 10:17:33 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:45 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-18-fvdl@google.com>
Subject: [PATCH v4 17/27] mm/hugetlb: add pre-HVO framework
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
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
2.48.1.601.g30ceb7b040-goog



Return-Path: <linux-kernel+bounces-539170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508AA4A1A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542C016F1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8017E2777FC;
	Fri, 28 Feb 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AA705Mj9"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE741279E36
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767422; cv=none; b=CX13vQ+9deP1JTIbc13T/bEzBVeL2vMmVYYATmvwyeOXwbRnuDZVkyliaJ+d5yiG+iu0goFlob4nhKtz+X9x8BKnPYEABBzD0r6glVocXDxSTbz1PjPx5sgOWfLzv57swpaFuD/0CRqpZ7mrnOBQ0qyrzO2dM4WH3ys8jK42+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767422; c=relaxed/simple;
	bh=Lq9yOdzTuKonlpg6YK+v4ZwOLE7IS6wsYR5j/gMXWB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hs7v0Bcvv2+5yAPNl7tTEOPB6+GFFuRzSGA2bCcCXYYE5t2mg1LnsdSN8PQy9Jbfi9fBoSK99yl/lql1fooiskWq4hgryS+YzNppWHkQG9gPf2xydV14lugxYBpZBQ//j52ygAgu1JZFI07L3fdEYRevMMzmByqNAM9TnFHFgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AA705Mj9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fec1f46678so2976160a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767420; x=1741372220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bilRBQrQ392Fbxoju7upbE9+OCkgy4821gbuoMPJZmQ=;
        b=AA705Mj9rb8cLHCZWdawFM26Lax9mBZbIUacHg0p1eY71Eut1CemBBkzAZVew/0JXi
         pSPBEXwwmtYUXXmBD6r/eG80id5xu4ZWusHEyceR341NLZX6F9GUrJztCKSsF/u32DiJ
         PWJTzYjl4WcDTRSXvmOq0ML5gxok7OzM4CtU6fA0i5x4rHEbzekiC9j6pOZdYAj0fksL
         xM7DQpmJHhZBRZR5rqk8MPeFYH3BPngLphmApruztdBmwuZmuWs2VviR2Yvxz4pbuKBf
         fCJOTacexQ8XIpWStwru08gaOvY/j55IyQek5IOSrplg+4qZ73U9yBvg5EUl3DfL3p8B
         /fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767420; x=1741372220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bilRBQrQ392Fbxoju7upbE9+OCkgy4821gbuoMPJZmQ=;
        b=rAHQm20qxDVsMgI+BJFwhLSeeZvinQIdRe942rCN1R28SERYdx6uQ4bbIsbZ8TNtzn
         5GjL5xxXUOHSmESHdfRKDvC01dQfDQKG3lcqLDQZ+gv9f+eqw2SlXLNr1L2lG6oGmZ8G
         +zRsIWsP982LLGj6sYAkLQPFDdujVCYu3cpLd9jlxP7/9hnjrgOrm+zzIa26AfuMOgQI
         MB+ncoqdh1jyFFjMTXlePbb6MEB9SwV7FPsph4LN1xc2gArUISNwwF8ivQ6RG9N0PElQ
         aS3BkfyYs0YB8gSTMQkWoeTZHpXCZgrK1dPtilB53mDVy+P/49CBlbVfzWcnimJNdX2U
         jvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+xF5dqEdwI6MD+VX93yexUuWXfQNGuSK/dzNaSqqCCZXgZrHNBJ07iylDcWGDwEnJl0a8pS6Vou/P02c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Vel4xn5VlhTBGEuT8Qw6dQLwix9RQiHbJZZuNsic9rqX9TWE
	7bEAgwzfqu45OHWnDWOp+AZvVaOvd6qCKyjxrWXVSDdEE9oTQWwE+6IvO2Vu4cTjdsi2Dw==
X-Google-Smtp-Source: AGHT+IHZH9jgpRWIq6i/MFnGQz3hWlzoaLJhHTlF5N5208y0nznHeVTLTF4A3tr7Hamk1dVEU9yqERiZ
X-Received: from pjbqa8.prod.google.com ([2002:a17:90b:4fc8:b0:2fa:210c:d068])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fd0:b0:2ee:aed6:9ec2
 with SMTP id 98e67ed59e1d1-2febab5e11dmr8140944a91.14.1740767420048; Fri, 28
 Feb 2025 10:30:20 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:20 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-20-fvdl@google.com>
Subject: [PATCH v5 19/27] mm/hugetlb: do pre-HVO for bootmem allocated pages
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

For large systems, the overhead of vmemmap pages for hugetlb
is substantial. It's about 1.5% of memory, which is about
45G for a 3T system. If you want to configure most of that
system for hugetlb (e.g. to use as backing memory for VMs),
there is a chance of running out of memory on boot, even
though you know that the 45G will become available later.

To avoid this scenario, and since it's a waste to first
allocate and then free that 45G during boot, do pre-HVO
for hugetlb bootmem allocated pages ('gigantic' pages).

pre-HVO is done by adding functions that are called from
sparse_init_nid_early and sparse_init_nid_late. The first
is called before memmap allocation, so it takes care of
allocating memmap HVO-style. The second verifies that all
bootmem pages look good, specifically it checks that they
do not intersect with multiple zones. This can only be done
from sparse_init_nid_late path, when zones have been
initialized.

The hugetlb page size must be aligned to the section size,
and aligned to the size of memory described by the number
of page structures contained in one PMD (since pre-HVO
is not prepared to split PMDs). This should be true for
most 'gigantic' pages, it is for 1G pages on x86, where
both of these alignment requirements are 128M.

This will only have an effect if hugetlb_bootmem_alloc was
called early in boot. If not, it won't do anything, and
HVO for bootmem hugetlb pages works as before.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/hugetlb.h |   2 +
 mm/hugetlb.c            |  17 ++++-
 mm/hugetlb_vmemmap.c    | 143 ++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    |  14 ++++
 mm/sparse-vmemmap.c     |   4 ++
 5 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 10a7ce2b95e1..2512463bca49 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -687,6 +687,8 @@ struct huge_bootmem_page {
 #define HUGE_BOOTMEM_HVO		0x0001
 #define HUGE_BOOTMEM_ZONES_VALID	0x0002
 
+bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
+
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 40c88c46b34f..634dc53f1e3e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3211,7 +3211,18 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	 */
 	memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
 		huge_page_size(h) - PAGE_SIZE);
-	/* Put them into a private list first because mem_map is not up yet */
+
+	/*
+	 * Put them into a private list first because mem_map is not up yet.
+	 *
+	 * For pre-HVO to work correctly, pages need to be on the list for
+	 * the node they were actually allocated from. That node may be
+	 * different in the case of fallback by memblock_alloc_try_nid_raw.
+	 * So, extract the actual node first.
+	 */
+	if (nid == NUMA_NO_NODE)
+		node = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
+
 	INIT_LIST_HEAD(&m->list);
 	list_add(&m->list, &huge_boot_pages[node]);
 	m->hstate = h;
@@ -3306,8 +3317,8 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	}
 }
 
-static bool __init hugetlb_bootmem_page_zones_valid(int nid,
-						    struct huge_bootmem_page *m)
+bool __init hugetlb_bootmem_page_zones_valid(int nid,
+					     struct huge_bootmem_page *m)
 {
 	unsigned long start_pfn;
 	bool valid;
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index be6b33ecbc8e..9a99dfa3c495 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -743,6 +743,149 @@ void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head
 	__hugetlb_vmemmap_optimize_folios(h, folio_list, true);
 }
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
+
+/* Return true of a bootmem allocated HugeTLB page should be pre-HVO-ed */
+static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
+{
+	unsigned long section_size, psize, pmd_vmemmap_size;
+	phys_addr_t paddr;
+
+	if (!READ_ONCE(vmemmap_optimize_enabled))
+		return false;
+
+	if (!hugetlb_vmemmap_optimizable(m->hstate))
+		return false;
+
+	psize = huge_page_size(m->hstate);
+	paddr = virt_to_phys(m);
+
+	/*
+	 * Pre-HVO only works if the bootmem huge page
+	 * is aligned to the section size.
+	 */
+	section_size = (1UL << PA_SECTION_SHIFT);
+	if (!IS_ALIGNED(paddr, section_size) ||
+	    !IS_ALIGNED(psize, section_size))
+		return false;
+
+	/*
+	 * The pre-HVO code does not deal with splitting PMDS,
+	 * so the bootmem page must be aligned to the number
+	 * of base pages that can be mapped with one vmemmap PMD.
+	 */
+	pmd_vmemmap_size = (PMD_SIZE / (sizeof(struct page))) << PAGE_SHIFT;
+	if (!IS_ALIGNED(paddr, pmd_vmemmap_size) ||
+	    !IS_ALIGNED(psize, pmd_vmemmap_size))
+		return false;
+
+	return true;
+}
+
+/*
+ * Initialize memmap section for a gigantic page, HVO-style.
+ */
+void __init hugetlb_vmemmap_init_early(int nid)
+{
+	unsigned long psize, paddr, section_size;
+	unsigned long ns, i, pnum, pfn, nr_pages;
+	unsigned long start, end;
+	struct huge_bootmem_page *m = NULL;
+	void *map;
+
+	/*
+	 * Noting to do if bootmem pages were not allocated
+	 * early in boot, or if HVO wasn't enabled in the
+	 * first place.
+	 */
+	if (!hugetlb_bootmem_allocated())
+		return;
+
+	if (!READ_ONCE(vmemmap_optimize_enabled))
+		return;
+
+	section_size = (1UL << PA_SECTION_SHIFT);
+
+	list_for_each_entry(m, &huge_boot_pages[nid], list) {
+		if (!vmemmap_should_optimize_bootmem_page(m))
+			continue;
+
+		nr_pages = pages_per_huge_page(m->hstate);
+		psize = nr_pages << PAGE_SHIFT;
+		paddr = virt_to_phys(m);
+		pfn = PHYS_PFN(paddr);
+		map = pfn_to_page(pfn);
+		start = (unsigned long)map;
+		end = start + nr_pages * sizeof(struct page);
+
+		if (vmemmap_populate_hvo(start, end, nid,
+					HUGETLB_VMEMMAP_RESERVE_SIZE) < 0)
+			continue;
+
+		memmap_boot_pages_add(HUGETLB_VMEMMAP_RESERVE_SIZE / PAGE_SIZE);
+
+		pnum = pfn_to_section_nr(pfn);
+		ns = psize / section_size;
+
+		for (i = 0; i < ns; i++) {
+			sparse_init_early_section(nid, map, pnum,
+					SECTION_IS_VMEMMAP_PREINIT);
+			map += section_map_size();
+			pnum++;
+		}
+
+		m->flags |= HUGE_BOOTMEM_HVO;
+	}
+}
+
+void __init hugetlb_vmemmap_init_late(int nid)
+{
+	struct huge_bootmem_page *m, *tm;
+	unsigned long phys, nr_pages, start, end;
+	unsigned long pfn, nr_mmap;
+	struct hstate *h;
+	void *map;
+
+	if (!hugetlb_bootmem_allocated())
+		return;
+
+	if (!READ_ONCE(vmemmap_optimize_enabled))
+		return;
+
+	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
+		if (!(m->flags & HUGE_BOOTMEM_HVO))
+			continue;
+
+		phys = virt_to_phys(m);
+		h = m->hstate;
+		pfn = PHYS_PFN(phys);
+		nr_pages = pages_per_huge_page(h);
+
+		if (!hugetlb_bootmem_page_zones_valid(nid, m)) {
+			/*
+			 * Oops, the hugetlb page spans multiple zones.
+			 * Remove it from the list, and undo HVO.
+			 */
+			list_del(&m->list);
+
+			map = pfn_to_page(pfn);
+
+			start = (unsigned long)map;
+			end = start + nr_pages * sizeof(struct page);
+
+			vmemmap_undo_hvo(start, end, nid,
+					 HUGETLB_VMEMMAP_RESERVE_SIZE);
+			nr_mmap = end - start - HUGETLB_VMEMMAP_RESERVE_SIZE;
+			memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
+
+			memblock_phys_free(phys, huge_page_size(h));
+			continue;
+		} else
+			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
+	}
+}
+#endif
+
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 62d3d645a793..18b490825215 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -9,6 +9,8 @@
 #ifndef _LINUX_HUGETLB_VMEMMAP_H
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
+#include <linux/io.h>
+#include <linux/memblock.h>
 
 /*
  * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
@@ -25,6 +27,10 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
+void hugetlb_vmemmap_init_early(int nid);
+void hugetlb_vmemmap_init_late(int nid);
+#endif
 
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
@@ -71,6 +77,14 @@ static inline void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h,
 {
 }
 
+static inline void hugetlb_vmemmap_init_early(int nid)
+{
+}
+
+static inline void hugetlb_vmemmap_init_late(int nid)
+{
+}
+
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 8cc848c4b17c..fd2ab5118e13 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -32,6 +32,8 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
+#include "hugetlb_vmemmap.h"
+
 /*
  * Flags for vmemmap_populate_range and friends.
  */
@@ -594,6 +596,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
  */
 void __init sparse_vmemmap_init_nid_early(int nid)
 {
+	hugetlb_vmemmap_init_early(nid);
 }
 
 /*
@@ -604,5 +607,6 @@ void __init sparse_vmemmap_init_nid_early(int nid)
  */
 void __init sparse_vmemmap_init_nid_late(int nid)
 {
+	hugetlb_vmemmap_init_late(nid);
 }
 #endif
-- 
2.48.1.711.g2feabab25a-goog



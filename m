Return-Path: <linux-kernel+bounces-520064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E2A3A532
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627641733BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B64271291;
	Tue, 18 Feb 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPg2F1Dz"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439081F5835
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902658; cv=none; b=bMvfJmWIyhPkCcj2sRkAkzsRQeiWHq8TBecswBu6QhHncxwWxpx5cWC1c7hlB2P+jLmbxMXOt6ABqFfgjmVYuYE22rTelxpK6YEFOQU4oD3LVvxoP5UA3mKFw7KB9m0T9kOxGY7tihVyX7loTbiKCgza6SeGxCbzGuciOgLRjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902658; c=relaxed/simple;
	bh=PWz643S4xzWNqtCqNmZZ4yeU7MVQVBVcR8BxJv+D9tg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nigvFSz3GoHQWW8ec88pWvMC7bEvMDXpm+RWGZMY3CGLqKDlTc6B1qVT/7yfVFjqjw0qsg3ty0SOX0nRsLiVWki802OSCcz0ViSiP2CJHEK8kC7dG8vjcEnd9egxdQI6ivGPmq02dBEdGS5WLpkm5NwPsbQ9dGqX+U7ylF4GAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPg2F1Dz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1c3b3dc7so10609563a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902656; x=1740507456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eP0AuGGA/jTNyPHaz+0221ekTfSMUwsfV2inUw2T3XU=;
        b=TPg2F1DzFwdtBS+lrE25H4cpotPrC7n8OCdjEmHRFjTTRU7S4FYUnQF0Lxf0p1r+O6
         BDKAg1Z9LVp9ceWse9rhRisZ8yMoveMPz1a1IYDjmjKamBWqBTRiP7Mf5ByUCDmHerkb
         64JvuvF653xaZmYRko79Y+wLb6lUupdta5tkefI9NDktIGFpNeM90jvPzMmiFvfyz+VD
         tvLByRS04OqX8FKrKcFEkfF8rx/ycPMvicxMJcAsSLnciThPhtdcDVBpep1C0MPmwrJT
         i7/WCWjWXkJlFaGQEHytd6ZjqM3nOmolebKoH4Xdv4rx7GLHm0xh2KX2M5CzC0h+17ua
         S11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902656; x=1740507456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eP0AuGGA/jTNyPHaz+0221ekTfSMUwsfV2inUw2T3XU=;
        b=ZwWVuIpfdijfkkHQgrlnQJOCnbbfqw0RIM5DGCnlcmR7hi0LiKtMg2WsFGMRqFh4XC
         xDib6C4gFCj2T1eFWYT6toWjviOeJNlzNKWmFyKKmy1dPXY+vuiaGXb2Ou3PryLUTO8b
         UdNhdtnSlUuHgkHrfWfVe9uN2VSko732Vz+C2bf9qC6WnmKDPjVzOaZ/twWPirBJTYGB
         EPDQWS01R1I8LhioK8Ce+NSFWaR0FMiq5bGduMmGX48O6RGBNLkVWeLs2a32GVEaMY5O
         Om5A8AgkCKRRluR3O3Ybkt9KSUtXsZ7FbiLYRhDKnHw+WMgU8WGzkQNMMci84u1FIBE3
         NH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa5usYtyoaUE5SN6shk/UQDlpEjE+uwvxHF//vYk7fcm47zVJxjVz+dzRXM3KL3JG3Y65EVYAHRfeOHOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAkZmi8iF6eGnTvPS+moabBqxQJ8zCHFtmajQCcgd6iWlM7k9
	KTYY1AA54meHt7zVnkPxq1do3pp6ZsQbSEhwq19XYYdCXScc47fSPK6Yl5hLrRPIRKwF1A==
X-Google-Smtp-Source: AGHT+IFduQgbCRNLRZnaXpDInvEojX9LUGLV+zf9Z4pRhPbL38b/THp8EijDiXQ4hiilnJVfp24fh2cB
X-Received: from pfbji12.prod.google.com ([2002:a05:6a00:8f0c:b0:730:50c0:136d])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c8e:b0:732:288b:c049
 with SMTP id d2e1a72fcca58-7329de4ec7emr452685b3a.1.1739902656672; Tue, 18
 Feb 2025 10:17:36 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:47 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-20-fvdl@google.com>
Subject: [PATCH v4 19/27] mm/hugetlb: do pre-HVO for bootmem allocated pages
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
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
2.48.1.601.g30ceb7b040-goog



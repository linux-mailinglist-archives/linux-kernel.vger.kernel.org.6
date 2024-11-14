Return-Path: <linux-kernel+bounces-408793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8737E9C8396
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00242831F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2F01F472D;
	Thu, 14 Nov 2024 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ChZ8+bP9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1751EE01E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567684; cv=none; b=jZu8QhfzIoZgLcSw/+Uuj+R5tX2ynFTcjbu/Nj6LL5LEf83mCqwYad41uXUKtsna+dpWfQvPN/S1CBxZKVoCK3X2cNWvaIMwJnnnvYQZuGhN7OWdX8PcVV93DfAyoM1eVc3DGycLFxuzgcn5VRWoIfBVRkrbLy0hMQPLoEL/rcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567684; c=relaxed/simple;
	bh=lbosdsiQeVFGrA4rAtzINXGrCPnihfDpcv5YshmmcJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJgk45Yg7Ed93P6bdbCfgA6sMFmUUCWS6vLV/zVi3kL2YLVfoAgGCiIN8GaQXmzrSflGvBU3lVzFPy85zctY3Y+Yv6efUw57jlsQvtmX7paUxR+53j9xp615wUvpWEbkHBw/mk1iok5dI/pS2UO/itpQ/UM43Q8cXg6oicmh6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ChZ8+bP9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-210e5369b7dso2348805ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567682; x=1732172482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao15XNwWqfhJRpavPj5UJluLHg99Tu4ljFLM7T2kOsA=;
        b=ChZ8+bP9v97XCFPXrCpMQLalnI3c7cFWfi4JoZDWAw26KSLmTp9w0AKRxAYuLv/NEX
         ZIpPEBPi9XoKuxEc0v2hVF3LdPuxuCkC+rOeQPSP+hg7E3BCx3MDOl+4eQyK7jEeKAN9
         NucUgMZY9e6szZnaosTHP5/ndfq4/dBebdd/620ho+0a4n9OpSDKPYn7aIyYJj5X2HQG
         CLJ+Jsy/lJN6XeYxsFgtJps7mCPHpk/tKeAEgNM9bUcH2c4F5hDwMCXHSUgCpps7cDjk
         Rjo4mQD/rQGPy4HbwJWnuCrreKy1mMY4frpPXO0A5wEo9mgkYyC/6eIHJTSIujSsIZVw
         10UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567682; x=1732172482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao15XNwWqfhJRpavPj5UJluLHg99Tu4ljFLM7T2kOsA=;
        b=Cby0jf41kLGUEaMUfFhC6AFNUlH6V0EVFVZKMpgyzukVmjJdopgcagqurBXvLlsGTt
         SerapWUVQ31lmQhq+uGxcWBMwQpw7AeNGftpCu68YpsY19XxRTNXnI86fGhoOq1IWM9r
         GguTrglaHQn6+vEWMIzAjJtumc6EwTy+RY7LeIFosXezoiAthU7T1FAubZttUq4GL+o7
         qfkLSxDzlok4SkvJ3PIbeb37kvG28gjcoCCzeMMkUSt32h09Ru7+84h4/ZBWWws40Iff
         zxXcPmAv5Huk1R6cDD5VX6Q25V9s+vvk9xJac7eCh66m7Vjn6MqswXjYUcm13S0xleRf
         KOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHlJzhews2kN9Abz5+xLfbkt85op9q+GdwEj1Gwhkaep85kMTxOXtWGNgTl3ZytzNy81Fw/XscK0j4NIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdADzetFCYAQvSPzlKAJvXzam+0dHmTtqGZnrdJNhyesuKKghU
	JTQspmmlnKX4hSolhLuTdYCx8JdSBeIasiQ7aCE8/VQcrjeZXqAdI4E8Gthht0I=
X-Google-Smtp-Source: AGHT+IHw+F+4TmogLhrbU8N9wTkF2jmE4YHNJryvizmOe98BZRuryF1Qlfv8KxZRs6BXORJTlrQqRA==
X-Received: by 2002:a17:902:e892:b0:20b:7210:5859 with SMTP id d9443c01a7336-211c50b0c51mr15181305ad.38.1731567681854;
        Wed, 13 Nov 2024 23:01:21 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:01:21 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	peterx@redhat.com
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zokeefe@google.com,
	rientjes@google.com,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 7/9] mm: pgtable: try to reclaim empty PTE page in madvise(MADV_DONTNEED)
Date: Thu, 14 Nov 2024 14:59:58 +0800
Message-Id: <9e6f0cff7ae29cd8bd1812d3a0e3513de3f42f42.1731566457.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1731566457.git.zhengqi.arch@bytedance.com>
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now in order to pursue high performance, applications mostly use some
high-performance user-mode memory allocators, such as jemalloc or
tcmalloc. These memory allocators use madvise(MADV_DONTNEED or MADV_FREE)
to release physical memory, but neither MADV_DONTNEED nor MADV_FREE will
release page table memory, which may cause huge page table memory usage.

The following are a memory usage snapshot of one process which actually
happened on our server:

        VIRT:  55t
        RES:   590g
        VmPTE: 110g

In this case, most of the page table entries are empty. For such a PTE
page where all entries are empty, we can actually free it back to the
system for others to use.

As a first step, this commit aims to synchronously free the empty PTE
pages in madvise(MADV_DONTNEED) case. We will detect and free empty PTE
pages in zap_pte_range(), and will add zap_details.reclaim_pt to exclude
cases other than madvise(MADV_DONTNEED).

Once an empty PTE is detected, we first try to hold the pmd lock within
the pte lock. If successful, we clear the pmd entry directly (fast path).
Otherwise, we wait until the pte lock is released, then re-hold the pmd
and pte locks and loop PTRS_PER_PTE times to check pte_none() to re-detect
whether the PTE page is empty and free it (slow path).

For other cases such as madvise(MADV_FREE), consider scanning and freeing
empty PTE pages asynchronously in the future.

The following code snippet can show the effect of optimization:

        mmap 50G
        while (1) {
                for (; i < 1024 * 25; i++) {
                        touch 2M memory
                        madvise MADV_DONTNEED 2M
                }
        }

As we can see, the memory usage of VmPTE is reduced:

                        before                          after
VIRT                   50.0 GB                        50.0 GB
RES                     3.1 MB                         3.1 MB
VmPTE                102640 KB                         240 KB

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h |  1 +
 mm/Kconfig         | 15 ++++++++++
 mm/Makefile        |  1 +
 mm/internal.h      | 19 +++++++++++++
 mm/madvise.c       |  7 ++++-
 mm/memory.c        | 45 ++++++++++++++++++++++++++++-
 mm/pt_reclaim.c    | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 157 insertions(+), 2 deletions(-)
 create mode 100644 mm/pt_reclaim.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ca59d165f1f2e..1fcd4172d2c03 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2319,6 +2319,7 @@ extern void pagefault_out_of_memory(void);
 struct zap_details {
 	struct folio *single_folio;	/* Locked folio to be unmapped */
 	bool even_cows;			/* Zap COWed private pages too? */
+	bool reclaim_pt;		/* Need reclaim page tables? */
 	zap_flags_t zap_flags;		/* Extra flags for zapping */
 };
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 84000b0168086..7949ab121070f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1301,6 +1301,21 @@ config ARCH_HAS_USER_SHADOW_STACK
 	  The architecture has hardware support for userspace shadow call
           stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
 
+config ARCH_SUPPORTS_PT_RECLAIM
+	def_bool n
+
+config PT_RECLAIM
+	bool "reclaim empty user page table pages"
+	default y
+	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
+	select MMU_GATHER_RCU_TABLE_FREE
+	help
+	  Try to reclaim empty user page table pages in paths other than munmap
+	  and exit_mmap path.
+
+	  Note: now only empty user PTE page table pages will be reclaimed.
+
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index dba52bb0da8ab..850386a67b3e0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -146,3 +146,4 @@ obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
+obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
diff --git a/mm/internal.h b/mm/internal.h
index 5a7302baeed7c..5b2aef61073f1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1530,4 +1530,23 @@ int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private);
 
+/* pt_reclaim.c */
+bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdval);
+void free_pte(struct mm_struct *mm, unsigned long addr, struct mmu_gather *tlb,
+	      pmd_t pmdval);
+void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		     struct mmu_gather *tlb);
+
+#ifdef CONFIG_PT_RECLAIM
+bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
+			   struct zap_details *details);
+#else
+static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
+					 struct zap_details *details)
+{
+	return false;
+}
+#endif /* CONFIG_PT_RECLAIM */
+
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index 0ceae57da7dad..49f3a75046f63 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -851,7 +851,12 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
-	zap_page_range_single(vma, start, end - start, NULL);
+	struct zap_details details = {
+		.reclaim_pt = true,
+		.even_cows = true,
+	};
+
+	zap_page_range_single(vma, start, end - start, &details);
 	return 0;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 8b3348ff374ff..fe93b0648c430 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1436,7 +1436,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 static inline bool should_zap_cows(struct zap_details *details)
 {
 	/* By default, zap all pages */
-	if (!details)
+	if (!details || details->reclaim_pt)
 		return true;
 
 	/* Or, we zap COWed pages only if the caller wants to */
@@ -1698,6 +1698,30 @@ static inline int do_zap_pte_range(struct mmu_gather *tlb,
 					 details, rss);
 }
 
+static inline int count_pte_none(pte_t *pte, int nr)
+{
+	int none_nr = 0;
+
+	/*
+	 * If PTE_MARKER_UFFD_WP is enabled, the uffd-wp PTEs may be
+	 * re-installed, so we need to check pte_none() one by one.
+	 * Otherwise, checking a single PTE in a batch is sufficient.
+	 */
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	for (;;) {
+		if (pte_none(ptep_get(pte)))
+			none_nr++;
+		if (--nr == 0)
+			break;
+		pte++;
+	}
+#else
+	if (pte_none(ptep_get(pte)))
+		none_nr = nr;
+#endif
+	return none_nr;
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1709,6 +1733,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	spinlock_t *ptl;
 	pte_t *start_pte;
 	pte_t *pte;
+	pmd_t pmdval;
+	unsigned long start = addr;
+	bool can_reclaim_pt = reclaim_pt_is_enabled(start, end, details);
+	bool direct_reclaim = false;
+	int none_nr = 0;
 	int nr;
 
 retry:
@@ -1726,6 +1755,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 		nr = skip_none_ptes(pte, addr, end);
 		if (nr) {
+			if (can_reclaim_pt)
+				none_nr += nr;
 			addr += PAGE_SIZE * nr;
 			if (addr == end)
 				break;
@@ -1734,12 +1765,17 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 		nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
 				      rss, &force_flush, &force_break);
+		if (can_reclaim_pt)
+			none_nr += count_pte_none(pte, nr);
 		if (unlikely(force_break)) {
 			addr += nr * PAGE_SIZE;
 			break;
 		}
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
+	if (can_reclaim_pt && addr == end && (none_nr == PTRS_PER_PTE))
+		direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
+
 	add_mm_rss_vec(mm, rss);
 	arch_leave_lazy_mmu_mode();
 
@@ -1766,6 +1802,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		goto retry;
 	}
 
+	if (can_reclaim_pt) {
+		if (direct_reclaim)
+			free_pte(mm, start, tlb, pmdval);
+		else
+			try_to_free_pte(mm, pmd, start, tlb);
+	}
+
 	return addr;
 }
 
diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
new file mode 100644
index 0000000000000..6540a3115dde8
--- /dev/null
+++ b/mm/pt_reclaim.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/hugetlb.h>
+#include <asm-generic/tlb.h>
+#include <asm/pgalloc.h>
+
+#include "internal.h"
+
+bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
+			   struct zap_details *details)
+{
+	return details && details->reclaim_pt && (end - start >= PMD_SIZE);
+}
+
+bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdval)
+{
+	spinlock_t *pml = pmd_lockptr(mm, pmd);
+
+	if (!spin_trylock(pml))
+		return false;
+
+	*pmdval = pmdp_get_lockless(pmd);
+	pmd_clear(pmd);
+	spin_unlock(pml);
+
+	return true;
+}
+
+void free_pte(struct mm_struct *mm, unsigned long addr, struct mmu_gather *tlb,
+	      pmd_t pmdval)
+{
+	pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
+	mm_dec_nr_ptes(mm);
+}
+
+void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		     struct mmu_gather *tlb)
+{
+	pmd_t pmdval;
+	spinlock_t *pml, *ptl;
+	pte_t *start_pte, *pte;
+	int i;
+
+	pml = pmd_lock(mm, pmd);
+	start_pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &ptl);
+	if (!start_pte)
+		goto out_ptl;
+	if (ptl != pml)
+		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+
+	/* Check if it is empty PTE page */
+	for (i = 0, pte = start_pte; i < PTRS_PER_PTE; i++, pte++) {
+		if (!pte_none(ptep_get(pte)))
+			goto out_ptl;
+	}
+	pte_unmap(start_pte);
+
+	pmd_clear(pmd);
+
+	if (ptl != pml)
+		spin_unlock(ptl);
+	spin_unlock(pml);
+
+	free_pte(mm, addr, tlb, pmdval);
+
+	return;
+out_ptl:
+	if (start_pte)
+		pte_unmap_unlock(start_pte, ptl);
+	if (ptl != pml)
+		spin_unlock(pml);
+}
-- 
2.20.1



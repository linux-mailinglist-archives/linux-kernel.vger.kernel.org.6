Return-Path: <linux-kernel+bounces-390151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF139B7628
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E051C20ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A357A156F24;
	Thu, 31 Oct 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kk1OlZS8"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542AB156236
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362481; cv=none; b=KU6aMKMxHkXjDmlR2pvhIt8PmKeArsr0Qx7OWsQrTS3B0nmlZ0sZCoVCAOvIvJx6falCl/l4WV+qlBrkvoU0O78GZPqMgCa5O9V8NsgXY6diaNeCRPA82XXFC7WNArDu6kmPAK4Crcx7ex3/3lTB6t/huBG1yYiGcT1hbaOuHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362481; c=relaxed/simple;
	bh=rk0n6Li3l9bZTxRdjRis1jk0+ha5cdrGYnE5BpDgaeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSjooZICdn121ejeDkkTbq0vh1gx1oxoWVRlQEaueck/cIX6ZDpPmAeoJxiuPkVxcN/x/0v4/zQmdEK0fyskJDVRbOU5sEcLP89cqukqSbEVW9DNLwzUp3Kz9gNBueXuLLv40c1ezLBJIjA4SdCqkIc66K/R4mdEmXyB1pdYXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kk1OlZS8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so584524a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730362478; x=1730967278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4RftZhl83d9xOlPt19CbxNfudxdUAgo7jhJTmA1K/8=;
        b=Kk1OlZS8TH3TNwXrW7IpF17mdmo3aW1oPpf4rZCuRXK83jYqksyukYUUceuudufkbM
         KQhe6T6NawpgMTSVllHI7xKFxFDJep0sXq9M4WaIFL0MkiUfMpm2iBmZ7CVEO+wSPiZk
         WYCNAF1IOaxx6Nzz5+wMqBjV5W7bDJe/NwOBAmJuIcqyIwsgjXJTcVI8E1+zHTO0T1RZ
         wN2KBySf8WPdBacr/saCr3XUe5jx6oaohgKpCeC0LuCB6hVyoGT+JT76ujBqjDL0wycB
         bdSR12OuiT0U2Awm1hhLM8nswcX+/f3nD5P823yKGZGueMldWORA5kFxUbYVAX+Dgtkw
         pbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362478; x=1730967278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4RftZhl83d9xOlPt19CbxNfudxdUAgo7jhJTmA1K/8=;
        b=nf3hJovBz3cAEuypkYbRnf3rVkqtM3rPx4dXnrPT+GxpcnwlTi+9wA+1dWKDhBeJb6
         seMfp0UIOeyz3jfwPfUXfNB9Oxv9bSlVp2S0qwoXIcpM7QaCKqknv/wFNJwcQvqUetCP
         R5/88ROorz8jeu3IWv1+XyklEcJD8fEXJ3v7Z6fHyAX6j1oXY59Xtbiq7+8pLPpu/fmY
         m2hKio6hHuggpOJX0+Uc3EuayAtB4rTUkmyPEOA/p6wN/Ydr4rFWA8l8c0MegcfNL+PY
         tpjxeGQyZBlU6RhKxOtDtUJ0hZg3G9TuA6PMjgs3XDlT+DfiZ1DH9Xp6dhI/cRRdXuCf
         AmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV78qAJ7XQy38fYpx7xrqLb0sEGJWe8BKr2d4Whh410UHLSOp9m8BpCZXX4olLGWrtr1RDWCOAyC1BfL40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzRrTZnnghw6TWSY9I2pD3iy3gXgs3s+N8fxaCx1fk8sx4XCkY
	jW5B+TN80WyF/uZc2D9TJugYLFrsvDB1ESM0spD4KGGE8nBlNGGtbuvI4l7K3so=
X-Google-Smtp-Source: AGHT+IG9/W35C0GmYjhqi67a7cjSq3d8MXDjUDLzpnbNphLEBFgOx4BfbHz6qsffBssbygHke8ycIQ==
X-Received: by 2002:a17:90b:1fc3:b0:2e2:a661:596a with SMTP id 98e67ed59e1d1-2e93c1860femr3011162a91.13.1730362478602;
        Thu, 31 Oct 2024 01:14:38 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9201b2586sm5163996a91.0.2024.10.31.01.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:14:38 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	peterx@redhat.com,
	catalin.marinas@arm.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 5/7] mm: pgtable: try to reclaim empty PTE page in madvise(MADV_DONTNEED)
Date: Thu, 31 Oct 2024 16:13:21 +0800
Message-Id: <c0199a7d7097521bbc183739b1fa6793081d726b.1730360798.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1730360798.git.zhengqi.arch@bytedance.com>
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
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
 mm/internal.h      | 23 ++++++++++++++++
 mm/madvise.c       |  4 ++-
 mm/memory.c        | 45 +++++++++++++++++++++++++++++-
 mm/pt_reclaim.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 155 insertions(+), 2 deletions(-)
 create mode 100644 mm/pt_reclaim.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3e4bb43035953..ce3936590fe72 100644
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
index 84000b0168086..681909e0a9fa3 100644
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
+	  Try to reclaim empty user page table pages in paths other that munmap
+	  and exit_mmap path.
+
+	  Note: now only empty user PTE page table pages will be reclaimed.
+
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index d5639b0361663..9d816323d247a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -145,3 +145,4 @@ obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
+obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
diff --git a/mm/internal.h b/mm/internal.h
index d5b93c5b63648..7aba395a9940f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1508,4 +1508,27 @@ int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private);
 
+#ifdef CONFIG_PT_RECLAIM
+bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdval);
+void free_pte(struct mm_struct *mm, unsigned long addr, struct mmu_gather *tlb,
+	      pmd_t pmdval);
+void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		     struct mmu_gather *tlb);
+#else
+static inline bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd,
+					 pmd_t *pmdval)
+{
+	return false;
+}
+static inline void free_pte(struct mm_struct *mm, unsigned long addr,
+			    struct mmu_gather *tlb, pmd_t pmdval)
+{
+}
+static inline void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd,
+				   unsigned long addr, struct mmu_gather *tlb)
+{
+}
+#endif /* CONFIG_PT_RECLAIM */
+
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index 0ceae57da7dad..ee88652761d45 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -851,7 +851,9 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
-	zap_page_range_single(vma, start, end - start, NULL);
+	struct zap_details details = {.reclaim_pt = true,};
+
+	zap_page_range_single(vma, start, end - start, &details);
 	return 0;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 002aa4f454fa0..c4a8c18fbcfd7 100644
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
@@ -1678,6 +1678,30 @@ static inline int do_zap_pte_range(struct mmu_gather *tlb,
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
@@ -1689,8 +1713,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	spinlock_t *ptl;
 	pte_t *start_pte;
 	pte_t *pte;
+	pmd_t pmdval;
+	bool can_reclaim_pt = false;
+	bool direct_reclaim = false;
+	unsigned long start = addr;
+	int none_nr = 0;
 	int nr;
 
+	if (details && details->reclaim_pt && (end - start >= PMD_SIZE))
+		can_reclaim_pt = true;
+
 retry:
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	init_rss_vec(rss);
@@ -1706,12 +1738,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 		nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, rss,
 				      &force_flush, &force_break);
+		none_nr += count_pte_none(pte, nr);
 		if (unlikely(force_break)) {
 			addr += nr * PAGE_SIZE;
 			break;
 		}
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
+	if (addr == end && can_reclaim_pt && (none_nr == PTRS_PER_PTE))
+		direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
+
 	add_mm_rss_vec(mm, rss);
 	arch_leave_lazy_mmu_mode();
 
@@ -1738,6 +1774,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
index 0000000000000..fc055da40b615
--- /dev/null
+++ b/mm/pt_reclaim.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/hugetlb.h>
+#include <asm-generic/tlb.h>
+#include <asm/pgalloc.h>
+
+#include "internal.h"
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
+	start_pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &ptl);
+	if (!start_pte)
+		return;
+
+	pml = pmd_lock(mm, pmd);
+	if (ptl != pml)
+		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd))))
+		goto out_ptl;
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
+	pte_unmap_unlock(start_pte, ptl);
+	if (pml != ptl)
+		spin_unlock(pml);
+}
-- 
2.20.1



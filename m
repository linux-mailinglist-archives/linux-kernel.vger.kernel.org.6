Return-Path: <linux-kernel+bounces-369561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF389A1EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0225B25F67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E080C1DA618;
	Thu, 17 Oct 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HRhKvX7a"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D631DC194
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158502; cv=none; b=ceKTTemDXA/P+quVdX3sNxYvTmwxU1gXXyScW99Wt9p+wbyu8o7FbgwCLMP2Bkl80MaE6Wk+WOZ2x74d3RBidaezyMxBjQF3nL8QWsTH+wwJzypd4LzmzZBiilUIoJtLKm5XHz+9tNUzf3QxK3sr592eUaBshRkFjmqq3QN0LZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158502; c=relaxed/simple;
	bh=78BqYEISZJiwjRYZkHzdiLqKPfoOhPjYtJX2SXEkwWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCY6yOXgyrdmhFqHmybFBMjDL43uSCnhLYmVK/NbVMhD3N0UZ/WfCaFr1G8H5KjeBptEL9panGhsosD+AI5TeyBCta2cdV0y3wvCDbn/ER8fbuk7HxeOib2gTGy5HG5l050gw6RXzHN9LePX19c9OWEyPolkB/amqHwVI4r/bXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HRhKvX7a; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so620958a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729158499; x=1729763299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MI+cLF01LX1jQYVjU1/jISHOw23BC0/0O3KrEoCWt0=;
        b=HRhKvX7anOVDTebT7vF0jYME88Ekx73JrnKE2bXhXgMYP1rKUOybIhscIdHR22eoP6
         77pp23XKzAeVQ3CbXAJOdMMe9rnCRA3RD9ygyxnAoXB6AIyfVxwGqn1uOK2BLqGKRLLt
         G2WungFHIREJAG8T1o2taiVNbTf8WNO76Z8hKUfcYdjOfbjmXJ+Sg7dXfOe8PbuyRTuJ
         tIumJHY686RaLRRMaPyAWwnAhA+lWfMgkL9YZWnCv2mkkTeuFH0A1TZGf7zaB0oNMmAQ
         lVDQmtEwS+aaKkH3oyy1qwBGE3Zb4iLoBVlcxfPXLHt1V3dawyZ6m62zqlajlCv65lho
         jtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158499; x=1729763299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MI+cLF01LX1jQYVjU1/jISHOw23BC0/0O3KrEoCWt0=;
        b=ErpLzAkRuy2deKyzaj6RKXxutKNRR2JWC+UlebV0lIES/x633IDsu1hEA7/VTKsU5r
         IpOpLFRzn4ebCDyeSczrq2g80Tg3rCiLa0QnyczfeNLQsKlut2cH1gemDgm7qSjbpq07
         P7vY5nJ35nug+1cgFxkC5wplZ/AjI2igXXHR0Oj1ApniCNnIHudbxQqHpSnQX0OvsOLN
         FGc8WyyjiDTqm72ubyu05mYiu+BcVz5Qw6uTPVz27Arqjn941v+l/xxN949jGp4VZaxW
         dQVhTGt7rCWyDZqltiVj1CsIfPEhMIJYlH0x7cx221AuiHMFGSGpLJYw0TcLgozWwmhl
         7aOw==
X-Forwarded-Encrypted: i=1; AJvYcCXXRBKYL4HGPcI73EDzfMe2D7FxDx1eLMK9HXVZYvFoDDyyEf4muWMIkelTDQ1Dq/XkvgZUmm323hnyOfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04/P02PhEFeZxXQ68pOSVLJiBgwSfD6tdE0HedyyctXNODEPO
	hJD/Z+FNR5Svmr42R7BKua6KEINMEd5sekklqaDTDwEI9ZlPqoqbKCjOX9o3Go0=
X-Google-Smtp-Source: AGHT+IG3h20lu4G0QNcRMk+sLLhl4rVPjvK7yVrB3CQ6qr+/Kwo1iZ1STapCyXTOLaWUcuJN2AVvmg==
X-Received: by 2002:a05:6a21:3998:b0:1d9:21c7:5af7 with SMTP id adf61e73a8af0-1d921c75b3dmr1711810637.15.1729158499347;
        Thu, 17 Oct 2024 02:48:19 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4218sm4385365b3a.120.2024.10.17.02.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:48:18 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	jannh@google.com,
	peterx@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 5/7] mm: pgtable: try to reclaim empty PTE page in madvise(MADV_DONTNEED)
Date: Thu, 17 Oct 2024 17:47:24 +0800
Message-Id: <6c7fe15b0434a08a287c400869f9ba434e1a8fa3.1729157502.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1729157502.git.zhengqi.arch@bytedance.com>
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
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
 mm/Kconfig         | 14 ++++++++++
 mm/Makefile        |  1 +
 mm/internal.h      | 29 ++++++++++++++++++++
 mm/madvise.c       |  4 ++-
 mm/memory.c        | 47 +++++++++++++++++++++++++++-----
 mm/pt_reclaim.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 156 insertions(+), 8 deletions(-)
 create mode 100644 mm/pt_reclaim.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index df0a5eac66b78..667a466bb4649 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2321,6 +2321,7 @@ extern void pagefault_out_of_memory(void);
 struct zap_details {
 	struct folio *single_folio;	/* Locked folio to be unmapped */
 	bool even_cows;			/* Zap COWed private pages too? */
+	bool reclaim_pt;
 	zap_flags_t zap_flags;		/* Extra flags for zapping */
 };
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 4b2a1ef9a161c..f5993b9cc2a9f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1302,6 +1302,20 @@ config ARCH_HAS_USER_SHADOW_STACK
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
index 906da6280c2df..4adaaea0917c0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1445,4 +1445,33 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
+#ifdef CONFIG_PT_RECLAIM
+static inline void set_pt_unreclaimable(bool *can_reclaim_pt)
+{
+	*can_reclaim_pt = false;
+}
+bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdval);
+void free_pte(struct mm_struct *mm, unsigned long addr, struct mmu_gather *tlb,
+	      pmd_t pmdval);
+void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		     struct mmu_gather *tlb);
+#else
+static inline void set_pt_unreclaimable(bool *can_reclaim_pt)
+{
+}
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
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index e871a72a6c329..82a6d15429da7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -843,7 +843,9 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
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
index cc89ede8ce2ab..77774b34f2cde 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1437,7 +1437,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 static inline bool should_zap_cows(struct zap_details *details)
 {
 	/* By default, zap all pages */
-	if (!details)
+	if (!details || details->reclaim_pt)
 		return true;
 
 	/* Or, we zap COWed pages only if the caller wants to */
@@ -1611,8 +1611,18 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	pmd_t pmdval;
+	bool can_reclaim_pt = false;
+	bool direct_reclaim;
+	unsigned long start = addr;
 	int nr;
 
+	if (details && details->reclaim_pt)
+		can_reclaim_pt = true;
+
+	if ((ALIGN_DOWN(end, PMD_SIZE)) - (ALIGN(start, PMD_SIZE)) < PMD_SIZE)
+		can_reclaim_pt = false;
+
 retry:
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	init_rss_vec(rss);
@@ -1641,6 +1651,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
 					      addr, details, rss, &force_flush,
 					      &force_break, &is_pt_unreclaimable);
+			if (is_pt_unreclaimable)
+				set_pt_unreclaimable(&can_reclaim_pt);
 			if (unlikely(force_break)) {
 				addr += nr * PAGE_SIZE;
 				break;
@@ -1653,8 +1665,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		    is_device_exclusive_entry(entry)) {
 			page = pfn_swap_entry_to_page(entry);
 			folio = page_folio(page);
-			if (unlikely(!should_zap_folio(details, folio)))
+			if (unlikely(!should_zap_folio(details, folio))) {
+				set_pt_unreclaimable(&can_reclaim_pt);
 				continue;
+			}
 			/*
 			 * Both device private/exclusive mappings should only
 			 * work with anonymous page so far, so we don't need to
@@ -1670,14 +1684,18 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			max_nr = (end - addr) / PAGE_SIZE;
 			nr = swap_pte_batch(pte, max_nr, ptent);
 			/* Genuine swap entries, hence a private anon pages */
-			if (!should_zap_cows(details))
+			if (!should_zap_cows(details)) {
+				set_pt_unreclaimable(&can_reclaim_pt);
 				continue;
+			}
 			rss[MM_SWAPENTS] -= nr;
 			free_swap_and_cache_nr(entry, nr);
 		} else if (is_migration_entry(entry)) {
 			folio = pfn_swap_entry_folio(entry);
-			if (!should_zap_folio(details, folio))
+			if (!should_zap_folio(details, folio)) {
+				set_pt_unreclaimable(&can_reclaim_pt);
 				continue;
+			}
 			rss[mm_counter(folio)]--;
 		} else if (pte_marker_entry_uffd_wp(entry)) {
 			/*
@@ -1685,21 +1703,29 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			 * drop the marker if explicitly requested.
 			 */
 			if (!vma_is_anonymous(vma) &&
-			    !zap_drop_file_uffd_wp(details))
+			    !zap_drop_file_uffd_wp(details)) {
+				set_pt_unreclaimable(&can_reclaim_pt);
 				continue;
+			}
 		} else if (is_hwpoison_entry(entry) ||
 			   is_poisoned_swp_entry(entry)) {
-			if (!should_zap_cows(details))
+			if (!should_zap_cows(details)) {
+				set_pt_unreclaimable(&can_reclaim_pt);
 				continue;
+			}
 		} else {
 			/* We should have covered all the swap entry types */
 			pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
 			WARN_ON_ONCE(1);
 		}
 		clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
-		zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
+		if (zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent))
+			set_pt_unreclaimable(&can_reclaim_pt);
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
+	if (addr == end && can_reclaim_pt)
+		direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
+
 	add_mm_rss_vec(mm, rss);
 	arch_leave_lazy_mmu_mode();
 
@@ -1724,6 +1750,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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



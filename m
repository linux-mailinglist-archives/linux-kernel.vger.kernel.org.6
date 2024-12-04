Return-Path: <linux-kernel+bounces-431055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448D9E387E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02052160518
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2A61B86CC;
	Wed,  4 Dec 2024 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N1MnfBuW"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F31B6D1B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310690; cv=none; b=N9n0mJ1FLHnGvH+YgcS0xGVUG9RXvHtcGeTNcK46HInL9fpjs+J5egHRqO4KVgDhPXohYingEnH2sLyGRPu5PRp/ZXuBYpfDFB2SgRduFMghFpbA3m+MkPSQgjyPmWsh/PsKd84NngjpeKkOCCZ8AJEjW+FBx9Rg51bmmIoIgbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310690; c=relaxed/simple;
	bh=zuWwq/UD6z+SpGWIzqBoOdqBvQAMZV2JNFy05FDkYmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uNYunZ6DfTppF6Zw4jE7si2AmvOGRPTL06f67/J9G5CcqQ+ltuIpRxf5D14RjiIf15SJg9R1GkmqoFgufTmFWmbGJlcIcemke9/1XIfg3+CzIlugM+1RkxaGj6d1rTc0v0mfyYOU4qktuZ9SqgkDOv6UMNPUxY7wXvwdsGqfW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N1MnfBuW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215b0582aaeso20471075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310688; x=1733915488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoapVpNXl28ZG5UuJ7jnDD6Hy269eKhZbzIlX0dbMls=;
        b=N1MnfBuWGfgnSktBsZGV7xZ+35dpH5eUDcuc8yge8YGjG02h+TEgan6GdCIrEbyUjE
         9ZsO0d5CJK7N2hczeRVJaqaxnVYIZElvVuU/Vc25VLfBaAxpBJ+lFKCdhur7O6fzFdiG
         G299oDEhOM56bfYnDlzH6XESy5hAWC+JxD4exqX+VFeSscuPaYZHDY70ovOOG/HGVUUc
         MScqyx001Bex7Lo8yE6BysUcrv0X+bFV59bFEh5o9Exr/3QvH674NK4UO3vRIJgJNE3x
         r8clIlelEg7umK0yxG0qNFxO7mnuV32s+uStucTAfYwQZ5kDRPw7PqIkCE0Q3exJ5mW7
         AsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310688; x=1733915488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoapVpNXl28ZG5UuJ7jnDD6Hy269eKhZbzIlX0dbMls=;
        b=YrFX+I9Cw3dPe8jKHgIB+uuOawq6El7d74YCbnyFDeIAgAQ9T30JiLe4xHfK0SXK5C
         q8opcPmbtAfefEcXDumvkwLbkFWqfeSF5LQjy4wgHGTvSN1hvjMGfqQx49M0dCiiip6f
         gxubrmf3AQIkkLuZEJNPbdMWrjDNKf0NXDGxLspQ1BsXrAP22fLJFFrSX55d5FkFoPCG
         xsuJNHwyveb50zOscSn5/1omX+kMbcXiC9id7A+19d8lBPrj+8hd1502Vt6nDd8kV5RG
         3r70I1MW9XavwN9zBSO54HrbH4cNFvThAXiaaPix0f5q8ZjZy80/rKWKSYwHRV94cIWh
         7yPw==
X-Forwarded-Encrypted: i=1; AJvYcCU0yum6I2thZ37ck5iDIpGdw5Im7SB40KaaExDeyrwEB2FpDdLFtJUwaeaMY6n4p5gwUxpZKh3fm3cfruI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjnshTsJnzu8A21c4M8p4fJF+h1ojhk7+GvdkEzluIkB5wefa
	EFR24sxMWDldqwTbZSWffGfUamJ+hY/8s5N3zcErWXr8c+hafnaMuZHhdJXQhIc=
X-Gm-Gg: ASbGncsDRusOc4UXJxjR+Gq+fgZ2D9myvp3Rz5/wyPQ6Iq9jFvpmkL6t1Z5mhluGBHx
	BIbTLEDbNscen+lisiYDylPHYyBkPqFfyD5zv0wk605kN4XTEMPP9dCseKjrckCBuKv9o4LPIBf
	smAdz7v2wsXYRrJTuAqSm85Il/TisVkdqglI7x489ueCAPffjVoo5hlAiU1mRvz/utsL1OFs1gI
	II1RWhnmDOTQPwcgq2s3mLpDlnuoZx/IspCBO9XF/Oi2Mfk47+uqIuAkWiZOCDQdta0t5FVhthu
	sNBmbJgs9kgsmbw=
X-Google-Smtp-Source: AGHT+IEfEQGVP8Gt1483n1zkgrWVjfWQwHKtLl/KnEOEh9tvsaCxkNv7R/GEU8g81pmpLtGbqUrK9w==
X-Received: by 2002:a17:903:2442:b0:215:a98c:aabb with SMTP id d9443c01a7336-215bd0e66a5mr90103075ad.24.1733310688006;
        Wed, 04 Dec 2024 03:11:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:11:27 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 09/11] mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)
Date: Wed,  4 Dec 2024 19:09:49 +0800
Message-Id: <92aba2b319a734913f18ba41e7d86a265f0b84e2.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
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
 mm/memory.c        | 21 ++++++++++++--
 mm/pt_reclaim.c    | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 132 insertions(+), 3 deletions(-)
 create mode 100644 mm/pt_reclaim.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 12fb3b9334269..8f3c824ee5a77 100644
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
index 74713b44bedb6..3958a965e56e1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1545,4 +1545,23 @@ int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
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
index 36a59bea289d1..1fc1f14839916 100644
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
@@ -1710,12 +1710,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct zap_details *details)
 {
 	bool force_flush = false, force_break = false;
-	bool any_skipped = false;
 	struct mm_struct *mm = tlb->mm;
 	int rss[NR_MM_COUNTERS];
 	spinlock_t *ptl;
 	pte_t *start_pte;
 	pte_t *pte;
+	pmd_t pmdval;
+	unsigned long start = addr;
+	bool can_reclaim_pt = reclaim_pt_is_enabled(start, end, details);
+	bool direct_reclaim = false;
 	int nr;
 
 retry:
@@ -1728,17 +1731,24 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	do {
+		bool any_skipped = false;
+
 		if (need_resched())
 			break;
 
 		nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, rss,
 				      &force_flush, &force_break, &any_skipped);
+		if (any_skipped)
+			can_reclaim_pt = false;
 		if (unlikely(force_break)) {
 			addr += nr * PAGE_SIZE;
 			break;
 		}
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
+	if (can_reclaim_pt && addr == end)
+		direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
+
 	add_mm_rss_vec(mm, rss);
 	arch_leave_lazy_mmu_mode();
 
@@ -1765,6 +1775,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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



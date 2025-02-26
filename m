Return-Path: <linux-kernel+bounces-533757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A0A45E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0884D16E597
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2CD22ACCE;
	Wed, 26 Feb 2025 12:04:00 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285C221D9E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571439; cv=none; b=UriGlI+ZVN8+6P1Es5Swh5R5Sy2Jlf3wS45VaEWiKMSPOUCpxdhW42qC3O/IL+cUF9cjud3F9/+w/hgeBiOwa5fGlLlB4+Y1G++vMcfViXQ3IUnRkgb1IWbKI/sL/WUltZHG14fqzVhs1U0UNwmv+T1kCuu3Q7/AwBc2Q26kCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571439; c=relaxed/simple;
	bh=8W37aPYdpIkD+raLCuj2CN9mAIByLtRwfAEsdpRCF/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=baxTzOAtY+qf7wZG/enLv9qi8Qy7UJyLbJW7fIg/USqfW3bnZW+Hohh0Z0hsYJCmrYNbew48C/pBdZl8eNbm7EJHmiANQwW5VIa/+XXlBZXmiaIGmY1R2RIXqjiZGmP0C4yogp4F4A8a3rXWSj73zdxk2yfSVkCtCVUaqKooXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-57-67bf03235d70
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on v6.14-rc4 20/25] mm, fs: skip tlb flushes for luf'd filemap that already has been done
Date: Wed, 26 Feb 2025 21:03:31 +0900
Message-Id: <20250226120336.29565-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC9ZZnka4y8/50g31/BCzmrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2PFfPeCSQEVx+ffZ2pgPOvQxcjB
	ISFgIrG5XbmLkRPMPLNqMTOIzSagLnHjxk8wW0TATOJg6x/2LkYuDmaBZUwSe080sIEkhAXK
	JeY13WcDmcMioCrRMJkTJMwLVH//7W5miJnyEqs3HACzOYHin6YdA2sVEkiW2Pn7DxPITAmB
	22wSZ1d8gWqQlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECA3pZ7Z/oHYyf
	LgQfYhTgYFTi4X1wZm+6EGtiWXFl7iFGCQ5mJRFezsw96UK8KYmVValF+fFFpTmpxYcYpTlY
	lMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoY5V/du9Iu/bKyJq488K5c2IaPKt1vNAz6WXwO
	qyi7C1g8v/7oGYtLFsfGAKGNk3smxjvf577y6zXPlVr37Bk5IcvdZyRxbhIRdau81vburUtJ
	tTRfYoFxdvr22kMRJw+tiVU1Ff3jlrUqsbEi+UXj43DNk1rntJ887/ivLHkrnGeiydKskDNK
	LMUZiYZazEXFiQC5VIXpZAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsXC5WfdrKvMvD/d4O4zDos569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyVsx3L5gUUHF8
	/n2mBsazDl2MnBwSAiYSZ1YtZgax2QTUJW7c+AlmiwiYSRxs/cPexcjFwSywjEli74kGNpCE
	sEC5xLym+0A2BweLgKpEw2ROkDAvUP39t7uZIWbKS6zecADM5gSKf5p2DKxVSCBZYufvP0wT
	GLkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzQZbV/Ju5g/HLZ/RCjAAejEg/vgzN7
	04VYE8uKK3MPMUpwMCuJ8HJm7kkX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKa
	nZpakFoEk2Xi4JRqYDQ/sezjhw4ej9n/Xil8v/VwjzvPUr6req925djce2K1plTcLvLBg6ec
	3Vnfp13LOHf3a23C8YSbea1Lb89fs9x0Eg+rrsSpjGWMsybtniiSqLn1Y9Ueh+z9lzj189a1
	Vh5mLi1739+R/kZJ8MeTSX2B7Z0/muqVT/w9Zt/q/uE/V+j8bf1P6syVWIozEg21mIuKEwGV
	Kex8TAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For luf'd filemap, tlb shootdown is performed when updating page cache,
no matter whether tlb flushes required already has been done or not.

By storing luf meta data in struct address_space and updating the luf
meta data properly, we can skip unnecessary tlb flush.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 fs/inode.c               |  1 +
 include/linux/fs.h       |  4 ++-
 include/linux/mm_types.h |  2 ++
 mm/memory.c              |  4 +--
 mm/rmap.c                | 59 +++++++++++++++++++++++++---------------
 mm/truncate.c            | 14 +++++-----
 mm/vmscan.c              |  2 +-
 7 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 5587aabdaa5ee..752fb2df6f3b3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -475,6 +475,7 @@ static void __address_space_init_once(struct address_space *mapping)
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->i_private_list);
 	spin_lock_init(&mapping->i_private_lock);
+	luf_batch_init(&mapping->luf_batch);
 	mapping->i_mmap = RB_ROOT_CACHED;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 78aaf769d32d1..a2f014b31028f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -498,6 +498,7 @@ extern const struct address_space_operations empty_aops;
  * @i_private_lock: For use by the owner of the address_space.
  * @i_private_list: For use by the owner of the address_space.
  * @i_private_data: For use by the owner of the address_space.
+ * @luf_batch: Data to track need of tlb flush by luf.
  */
 struct address_space {
 	struct inode		*host;
@@ -519,6 +520,7 @@ struct address_space {
 	struct list_head	i_private_list;
 	struct rw_semaphore	i_mmap_rwsem;
 	void *			i_private_data;
+	struct luf_batch	luf_batch;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
 	 * On most architectures that alignment is already the case; but
@@ -545,7 +547,7 @@ static inline int mapping_write_begin(struct file *file,
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
 	if (!ret)
-		luf_flush(0);
+		luf_flush_mapping(mapping);
 
 	return ret;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2ac93d4f67c15..96015fc68e4f5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1348,10 +1348,12 @@ extern void tlb_finish_mmu(struct mmu_gather *tlb);
 void luf_flush(unsigned short luf_key);
 void luf_flush_mm(struct mm_struct *mm);
 void luf_flush_vma(struct vm_area_struct *vma);
+void luf_flush_mapping(struct address_space *mapping);
 #else
 static inline void luf_flush(unsigned short luf_key) {}
 static inline void luf_flush_mm(struct mm_struct *mm) {}
 static inline void luf_flush_vma(struct vm_area_struct *vma) {}
+static inline void luf_flush_mapping(struct address_space *mapping) {}
 #endif
 
 struct vm_fault;
diff --git a/mm/memory.c b/mm/memory.c
index 52bd45fe00f55..6cdc1df0424f3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6261,10 +6261,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	if (flush) {
 		/*
 		 * If it has a VM_SHARED mapping, all the mms involved
-		 * should be luf_flush'ed.
+		 * in the struct address_space should be luf_flush'ed.
 		 */
 		if (mapping)
-			luf_flush(0);
+			luf_flush_mapping(mapping);
 		luf_flush_mm(mm);
 	}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index d68cfd28e0939..58dfc9889b1ee 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -691,7 +691,7 @@ void fold_batch(struct tlbflush_unmap_batch *dst,
 #define NR_LUF_BATCH (1 << (sizeof(short) * 8))
 
 /*
- * Use 0th entry as accumulated batch.
+ * XXX: Reserve the 0th entry for later use.
  */
 struct luf_batch luf_batch[NR_LUF_BATCH];
 
@@ -936,7 +936,7 @@ void luf_flush_vma(struct vm_area_struct *vma)
 		mapping = vma->vm_file->f_mapping;
 
 	if (mapping)
-		luf_flush(0);
+		luf_flush_mapping(mapping);
 	luf_flush_mm(mm);
 }
 
@@ -962,6 +962,29 @@ void luf_flush_mm(struct mm_struct *mm)
 	try_to_unmap_flush();
 }
 
+void luf_flush_mapping(struct address_space *mapping)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct luf_batch *lb;
+	unsigned long flags;
+	unsigned long lb_ugen;
+
+	if (!mapping)
+		return;
+
+	lb = &mapping->luf_batch;
+	read_lock_irqsave(&lb->lock, flags);
+	fold_batch(tlb_ubc, &lb->batch, false);
+	lb_ugen = lb->ugen;
+	read_unlock_irqrestore(&lb->lock, flags);
+
+	if (arch_tlbbatch_diet(&tlb_ubc->arch, lb_ugen))
+		return;
+
+	try_to_unmap_flush();
+}
+EXPORT_SYMBOL(luf_flush_mapping);
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -1010,7 +1033,8 @@ void try_to_unmap_flush_dirty(void)
 
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 		unsigned long uaddr,
-		struct vm_area_struct *vma)
+		struct vm_area_struct *vma,
+		struct address_space *mapping)
 {
 	struct tlbflush_unmap_batch *tlb_ubc;
 	int batch;
@@ -1032,27 +1056,15 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 		tlb_ubc = &current->tlb_ubc;
 	else {
 		tlb_ubc = &current->tlb_ubc_ro;
+
 		fold_luf_batch_mm(&mm->luf_batch, mm);
+		if (mapping)
+			fold_luf_batch_mm(&mapping->luf_batch, mm);
 	}
 
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
 	tlb_ubc->flush_required = true;
 
-	if (can_luf_test()) {
-		struct luf_batch *lb;
-		unsigned long flags;
-
-		/*
-		 * Accumulate to the 0th entry right away so that
-		 * luf_flush(0) can be uesed to properly perform pending
-		 * TLB flush once this unmapping is observed.
-		 */
-		lb = &luf_batch[0];
-		write_lock_irqsave(&lb->lock, flags);
-		__fold_luf_batch(lb, tlb_ubc, new_luf_ugen());
-		write_unlock_irqrestore(&lb->lock, flags);
-	}
-
 	/*
 	 * Ensure compiler does not re-order the setting of tlb_flush_batched
 	 * before the PTE is cleared.
@@ -1134,7 +1146,8 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
 #else
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 		unsigned long uaddr,
-		struct vm_area_struct *vma)
+		struct vm_area_struct *vma,
+		struct address_space *mapping)
 {
 }
 
@@ -1503,7 +1516,7 @@ int folio_mkclean(struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 
 	return cleaned;
 }
@@ -2037,6 +2050,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	struct address_space *mapping = folio_mapping(folio);
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -2174,7 +2188,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pteval, address, vma);
+				set_tlb_ubc_flush_pending(mm, pteval, address, vma, mapping);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
@@ -2414,6 +2428,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	struct address_space *mapping = folio_mapping(folio);
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -2563,7 +2578,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pteval, address, vma);
+				set_tlb_ubc_flush_pending(mm, pteval, address, vma, mapping);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
diff --git a/mm/truncate.c b/mm/truncate.c
index 2bf3806391c21..b2934c4edebf1 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -128,7 +128,7 @@ void folio_invalidate(struct folio *folio, size_t offset, size_t length)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(folio->mapping);
 }
 EXPORT_SYMBOL_GPL(folio_invalidate);
 
@@ -169,7 +169,7 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 	return 0;
 }
 
@@ -219,7 +219,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(folio->mapping);
 
 	if (!folio_test_large(folio))
 		return true;
@@ -281,7 +281,7 @@ long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 
 	return ret;
 }
@@ -416,7 +416,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
 
@@ -536,7 +536,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 	return count;
 }
 
@@ -706,7 +706,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2_range);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 461e7643898e7..a31a7cf87315f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -843,7 +843,7 @@ long remove_mapping(struct address_space *mapping, struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 
 	return ret;
 }
-- 
2.17.1



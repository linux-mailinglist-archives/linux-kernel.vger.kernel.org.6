Return-Path: <linux-kernel+bounces-523002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02717A3D0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2492C188546D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299FE1E3DF2;
	Thu, 20 Feb 2025 05:36:15 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAEA1EB181
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029773; cv=none; b=XxCXZplPuRTMcnLx589IbwJhq/KKWZjmVdyjzxUhpY+ZTuH2qjMEj1qUXB/HHeKK2UeHs5+ZF8M9UeD6rvfYBKRt5nanH3D43XH7vNfT0dFwGb9RVMeGDjXH+y5XztJnwFxNg+N0KBx0dLBwMXMBtMdDLJGnuntZDE+YhtV6jRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029773; c=relaxed/simple;
	bh=aNFdWmd/IwFyCddRF7YVe0SPx1Jlwdld/eJ0DPmsUqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k/1CPTuIcLJL6TMxjYHgtg0GYPsqLQEPcdIVsJtokHCDw/z9I9Axwi4r2sgqVRDCGGlCWr2iU58jvN/8c0+c8wsSmgEpVGSs358nJXAuQ4ksMLU9llBwcR0VTBzYRLcf6JjpeZBoxPFdUdVo4CRGk6RdAKA+OkNgLIm2zPfBtlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-12-67b6bba718ad
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 20/26] mm, fs: skip tlb flushes for luf'd filemap that already has been done
Date: Thu, 20 Feb 2025 14:20:21 +0900
Message-Id: <20250220052027.58847-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe7y3dvSDZp3CFrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	pQ8WMBdcCqg4uG8XWwPjWYcuRk4OCQETiRNP3zPC2NN3XGUBsdkE1CVu3PjJDGKLCJhJHGz9
	ww5iMwvcZZI40M/WxcjBISyQInHgnQZImEVAVeJn4zEmEJsXqLx31TUmiJHyEqs3HAAbwwkU
	/zGjlw3EFhIwlXi34BJQDRdQzWc2ieOfnrFCNEhKHFxxg2UCI+8CRoZVjEKZeWW5iZk5JnoZ
	lXmZFXrJ+bmbGIGBv6z2T/QOxk8Xgg8xCnAwKvHwzmjdli7EmlhWXJl7iFGCg1lJhLetfku6
	EG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsbci8EnElQl
	DrVo5kx1c7znJDjZ69em24H5IUe2TjyfVqzNoRQUsO3uk65EXcGqxWFWphq/r24SXFta/TWy
	eSrDwUOn/u+/EmHZvIRRacoZf73l8k0njgot+vV6vx1T0v4Kn9ky329dmBq9+Ijylr4/nEZX
	lj+fNYNR0ER60e6c4HjnyPrctNtKLMUZiYZazEXFiQAFu6/BeAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrLt897Z0g18f2S3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlbH0wQLmgksBFQf37WJrYDzr0MXIySEhYCIxfcdVFhCbTUBd4saNn8wgtoiA
	mcTB1j/sIDazwF0miQP9bF2MHBzCAikSB95pgIRZBFQlfjYeYwKxeYHKe1ddY4IYKS+xesMB
	sDGcQPEfM3rZQGwhAVOJdwsuMU1g5FrAyLCKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMIyX
	1f6ZuIPxy2X3Q4wCHIxKPLwPHm9NF2JNLCuuzD3EKMHBrCTC21a/JV2INyWxsiq1KD++qDQn
	tfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qBsXjb1Vn7X9zP7HIrCK5ZZTFlypzJ
	M4wau3MnvGIL6AqOfmtlybexSN9Q9+PB1faP5WZlvl7IqnFE4cNH9xUbJwj33597NlE3b8GD
	sNY5zREfZu1WevJla3F5+beOdU2GeQoro/xOf2ap12VSXiftE73WgEH6zsada+Z99zj4SIB/
	t8weiZ7VN5RYijMSDbWYi4oTAR3U4EpfAgAA
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
index 46fbd5b234822..e155e51be2d28 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -404,6 +404,7 @@ static void __address_space_init_once(struct address_space *mapping)
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->i_private_list);
 	spin_lock_init(&mapping->i_private_lock);
+	luf_batch_init(&mapping->luf_batch);
 	mapping->i_mmap = RB_ROOT_CACHED;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec88270221bfe..0cc588c704cd1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -461,6 +461,7 @@ extern const struct address_space_operations empty_aops;
  * @i_private_lock: For use by the owner of the address_space.
  * @i_private_list: For use by the owner of the address_space.
  * @i_private_data: For use by the owner of the address_space.
+ * @luf_batch: Data to track need of tlb flush by luf.
  */
 struct address_space {
 	struct inode		*host;
@@ -482,6 +483,7 @@ struct address_space {
 	struct list_head	i_private_list;
 	struct rw_semaphore	i_mmap_rwsem;
 	void *			i_private_data;
+	struct luf_batch	luf_batch;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
 	 * On most architectures that alignment is already the case; but
@@ -508,7 +510,7 @@ static inline int mapping_write_begin(struct file *file,
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
 	if (!ret)
-		luf_flush(0);
+		luf_flush_mapping(mapping);
 
 	return ret;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8de4c190ad514..c50cfc1c6282f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1279,10 +1279,12 @@ extern void tlb_finish_mmu(struct mmu_gather *tlb);
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
index b02f86b1adb91..c98af5e567e89 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6161,10 +6161,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
index e0304dc74c3a7..0cb13e8fcd739 100644
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
-				      struct vm_area_struct *vma)
+				      struct vm_area_struct *vma,
+				      struct address_space *mapping)
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
-				      struct vm_area_struct *vma)
+				      struct vm_area_struct *vma,
+				      struct address_space *mapping)
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
index 14618c53f1910..f9a3416610231 100644
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
 
@@ -170,7 +170,7 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 	return 0;
 }
 
@@ -220,7 +220,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(folio->mapping);
 
 	if (!folio_test_large(folio))
 		return true;
@@ -282,7 +282,7 @@ long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 
 	return ret;
 }
@@ -417,7 +417,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
 
@@ -537,7 +537,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 	return count;
 }
 
@@ -704,7 +704,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2_range);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ffc4a48710f1d..cbca027d2a10e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -836,7 +836,7 @@ long remove_mapping(struct address_space *mapping, struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 
 	return ret;
 }
-- 
2.17.1



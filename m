Return-Path: <linux-kernel+bounces-533732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312EA45E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5004F7A791F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022BC222565;
	Wed, 26 Feb 2025 12:01:58 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D929221734
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571317; cv=none; b=OEMEHpfITBkTFnjBJDIyA6W+EeHZGTawbeSuCanhD3/TZwb6zYVN7EH9b4UIMSOZxlQXsgTTcYJ8w/GRLSuEjmnh2OkRU9xq0XlywMbxgF9q/5ywvoBYW9x7JycPP7TgKZ6GmeQOugPIHHp7EHq6UGk9OEu+3LntY4unqQ7TXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571317; c=relaxed/simple;
	bh=xZaFTfDj6f+Tw7SeAVUikX/92NjufAsgTDqFPjktrag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ah0vhg0k2HqcB3op5oK3qVf54w3/sWtJ06kXVfPhfZ01oWPRMPOSk/nJjunlCt5Oe2VdQoS3TqxEVl8mHc67uBhF64InWYXxIVo7/ClQ3NOWJmpAIwpi5ycphjJ71RUJDRfLbf5faUqSk/aXaY1e6b9+CxaXRfskPiwwEdxbi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-27-67bf02a7fd3a
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 20/25] mm, fs: skip tlb flushes for luf'd filemap that already has been done
Date: Wed, 26 Feb 2025 21:01:27 +0900
Message-Id: <20250226120132.28469-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBt0NShZz1q9hs/i84R+b
	xdf1v5gtnn7qY7G4vGsOm8W9Nf9ZLc7vWstqsWPpPiaLSwcWMFkc7z3AZDH/3mc2i82bpjJb
	HJ8yldHi9485bA58Ht9b+1g8ds66y+6xYFOpx+YVWh6bVnWyeWz6NInd4925c+weJ2b8ZvF4
	v+8qm8fWX3YejVOvsXl83iQXwBPFZZOSmpNZllqkb5fAlbFux132gq7AimnNvA2Mmxy7GDk5
	JARMJBY132CHsb9vfccKYrMJqEvcuPGTGcQWETCTONj6B6iGi4NZYBmTxN4TDWwgjrBAD6PE
	hR9nwKpYBFQlLvU9ZQGxeYE6znR+ZISYKi+xesMBsBpOoPi/3b/BtgkJJEu0rP/NAjJIQuA2
	m8Tev63MEA2SEgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZgWC+r/RO9g/HT
	heBDjAIcjEo8vA/O7E0XYk0sK67MPcQowcGsJMLLmbknXYg3JbGyKrUoP76oNCe1+BCjNAeL
	kjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOjkpimz+0/0Vk8D+aJCt9cYnX6rIdB0Jm06VON
	eidnd26Q3SSVWuwjUJUZJCYVzrD8le3RvaqtT1I2Tup8tU6yOpj3dueDzJPLs7YtrhA2/rz8
	/M31erNqq5alqLTNu1ufvPASuz3Tx/g5Hv8Sb9xbsXTRzAV3+Fi61u1M6zrldGXFrZ4stfkm
	SizFGYmGWsxFxYkAIuzsUmcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLucaX+6wYnZkhZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlrNtxl72gK7Bi
	WjNvA+Mmxy5GTg4JAROJ71vfsYLYbALqEjdu/GQGsUUEzCQOtv5h72Lk4mAWWMYksfdEAxuI
	IyzQwyhx4ccZsCoWAVWJS31PWUBsXqCOM50fGSGmykus3nAArIYTKP5v9292EFtIIFmiZf1v
	lgmMXAsYGVYximTmleUmZuaY6hVnZ1TmZVboJefnbmIEBumy2j8TdzB+uex+iFGAg1GJh/fB
	mb3pQqyJZcWVuYcYJTiYlUR4OTP3pAvxpiRWVqUW5ccXleakFh9ilOZgURLn9QpPTRASSE8s
	Sc1OTS1ILYLJMnFwSjUwzs147Xe3kiX9JXe5GGcV66b/y/6+OBKeMCPe5l1whs7XY8vPK99b
	c8w185Jjm8j5FubbwU8qdaff7BUOVpFPY42SjFGb+vmJws3FWm+dF1v5ZlwTnfSCP/N19coD
	jDffvOy5fk17Oa/uBrtXhyO2SXuY53htcedU73sda/7q18vHe9eLJoSKKrEUZyQaajEXFScC
	AOtgG4hOAgAA
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
index c32ef19a25056..d73a3eb0f7b21 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1362,10 +1362,12 @@ extern void tlb_finish_mmu(struct mmu_gather *tlb);
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
index 93e5879583b07..62137ab258d2c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6296,10 +6296,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
index fe9c4606ae542..f5c5190be24e0 100644
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
 		unsigned long start, unsigned long end,
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
 
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, start, end);
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
 		unsigned long start, unsigned long end,
-		struct vm_area_struct *vma)
+		struct vm_area_struct *vma,
+		struct address_space *mapping)
 {
 }
 
@@ -1511,7 +1524,7 @@ int folio_mkclean(struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 
 	return cleaned;
 }
@@ -2198,6 +2211,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	unsigned long nr_pages = 1, end_addr;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	struct address_space *mapping = folio_mapping(folio);
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -2359,7 +2373,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * and traps if the PTE is unmapped.
 			 */
 			if (should_defer_flush(mm, flags))
-				set_tlb_ubc_flush_pending(mm, pteval, address, end_addr, vma);
+				set_tlb_ubc_flush_pending(mm, pteval, address, end_addr, vma, mapping);
 			else
 				flush_tlb_range(vma, address, end_addr);
 			if (pte_dirty(pteval))
@@ -2611,6 +2625,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	struct address_space *mapping = folio_mapping(folio);
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -2758,7 +2773,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pteval, address, address + PAGE_SIZE, vma);
+				set_tlb_ubc_flush_pending(mm, pteval, address, address + PAGE_SIZE, vma, mapping);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
diff --git a/mm/truncate.c b/mm/truncate.c
index 68c9ded2f789b..8c133b93cefe8 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -142,7 +142,7 @@ void folio_invalidate(struct folio *folio, size_t offset, size_t length)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(folio->mapping);
 }
 EXPORT_SYMBOL_GPL(folio_invalidate);
 
@@ -183,7 +183,7 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 	return 0;
 }
 
@@ -234,7 +234,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(folio->mapping);
 
 	if (!folio_test_large(folio))
 		return true;
@@ -324,7 +324,7 @@ long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 
 	return ret;
 }
@@ -459,7 +459,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
 
@@ -579,7 +579,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 	return count;
 }
 
@@ -749,7 +749,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2_range);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 422b9a03a6753..f145c09629b97 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -853,7 +853,7 @@ long remove_mapping(struct address_space *mapping, struct folio *folio)
 	/*
 	 * Ensure to clean stale tlb entries for this mapping.
 	 */
-	luf_flush(0);
+	luf_flush_mapping(mapping);
 
 	return ret;
 }
-- 
2.17.1



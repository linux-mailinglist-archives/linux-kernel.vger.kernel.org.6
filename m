Return-Path: <linux-kernel+bounces-371078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF529A3604
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E7F2818F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274F18D64B;
	Fri, 18 Oct 2024 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiGunNIg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F0188722
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234095; cv=none; b=SL4TZ8RgjlENT0dcHEVdffHJEJAfNZzy3zlviIdzdgzLoPu+EI6kFUIvHW4XAxj0bRnROiAQe+RXMn1p3atvnsFLVagVzy8QcEQ+K6SVcS6VBpSqZYrATa/qg0/VcmDrIealCj+TulmUF5HouRvYWFsRFiM2L6k63Y7fk9GDLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234095; c=relaxed/simple;
	bh=NVsoZ0G+h+yCIJer8I6ApzubS8LAuLTzsZjgRgzHJ0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSJavP0grXQsqquc9+z3u2stuoeHYOF1zzT6agmLxQnac7lvrYWpKcjeWk9gVKD06lhl2ykPZ9QLgTePxqmTm/74pTSY/OkZUkgVvrzI5dkN/3jQYAAZ9c2PDRd7il9XvGJsN8j7/X9gUtwVoPejeNbivooNoM13pMuNvBvpEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiGunNIg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729234093; x=1760770093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NVsoZ0G+h+yCIJer8I6ApzubS8LAuLTzsZjgRgzHJ0A=;
  b=aiGunNIgOF6wLW7ueRED/2a/T/wgOiIBHWgou3FYtJbO9Di8/5mZS8xp
   rN+Qs8WU9z/gWYonQTA0Knhi+cz3Jr7kkR8A9OwT9GayhklBEjAwCgaxn
   uJY068CDo/hA2GE3e0Vbjo5Gn8WQPf10Slz1468CQ2lpnA15fynV/RL/f
   EZ66U/G4iV8Z70C5SsOB1LufSKJThpwxAqWlMjsBC29LusbRCGXO9ABRx
   YbOyoTv5N4P2LmmGpHvbpgUYAzci2zHZ+flV270atGPkDDRTqsuThmZgs
   tNALWxgcx9DFsUWK1rNZOsw+mR3yDtsEJpFrnL9y0aEsDfcF1L6NM6OZh
   Q==;
X-CSE-ConnectionGUID: FFMTDIK3RfCsKeY2q3rfrQ==
X-CSE-MsgGUID: Hxr+1EOJREesOyHFsZ6/GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28963374"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28963374"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:48:10 -0700
X-CSE-ConnectionGUID: 9smf1lgiQ5GrHRanDYY+1g==
X-CSE-MsgGUID: vZzx9IQOSxa3k9xr46CDBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82744530"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 23:48:09 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	bfoster@redhat.com,
	dchinner@redhat.com,
	chrisl@kernel.org,
	david@redhat.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 6/7] mm: do_swap_page() calls swapin_readahead() zswap load batching interface.
Date: Thu, 17 Oct 2024 23:48:04 -0700
Message-Id: <20241018064805.336490-7-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
References: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch invokes the swapin_readahead() based batching interface to
prefetch a batch of 4K folios for zswap load with batch decompressions
in parallel using IAA hardware. swapin_readahead() prefetches folios based
on vm.page-cluster and the usefulness of prior prefetches to the
workload. As folios are created in the swapcache and the readahead code
calls swap_read_folio() with a "zswap_batch" and a "non_zswap_batch", the
respective folio_batches get populated with the folios to be read.

Finally, the swapin_readahead() procedures will call the newly added
process_ra_batch_of_same_type() which:

 1) Reads all the non_zswap_batch folios sequentially by calling
    swap_read_folio().
 2) Calls swap_read_zswap_batch_unplug() with the zswap_batch which calls
    zswap_finish_load_batch() that finally decompresses each
    SWAP_CRYPTO_SUB_BATCH_SIZE sub-batch (i.e. upto 8 pages in a prefetch
    batch of say, 32 folios) in parallel with IAA.

Within do_swap_page(), we try to benefit from batch decompressions in both
these scenarios:

 1) single-mapped, SWP_SYNCHRONOUS_IO:
      We call swapin_readahead() with "single_mapped_path = true". This is
      done only in the !zswap_never_enabled() case.
 2) Shared and/or non-SWP_SYNCHRONOUS_IO folios:
      We call swapin_readahead() with "single_mapped_path = false".

This will place folios in the swapcache: a design choice that handles cases
where a folio that is "single-mapped" in process 1 could be prefetched in
process 2; and handles highly contended server scenarios with stability.
There are checks added at the end of do_swap_page(), after the folio has
been successfully loaded, to detect if the single-mapped swapcache folio is
still single-mapped, and if so, folio_free_swap() is called on the folio.

Within the swapin_readahead() functions, if single_mapped_path is true, and
either the platform does not have IAA, or, if the platform has IAA and the
user selects a software compressor for zswap (details of sysfs knob
follow), readahead/batching are skipped and the folio is loaded using
zswap_load().

A new swap parameter "singlemapped_ra_enabled" (false by default) is added
for platforms that have IAA, zswap_load_batching_enabled() is true, and we
want to give the user the option to run experiments with IAA and with
software compressors for zswap (swap device is SWP_SYNCHRONOUS_IO):

For IAA:
 echo true > /sys/kernel/mm/swap/singlemapped_ra_enabled

For software compressors:
 echo false > /sys/kernel/mm/swap/singlemapped_ra_enabled

If "singlemapped_ra_enabled" is set to false, swapin_readahead() will skip
prefetching folios in the "single-mapped SWP_SYNCHRONOUS_IO" do_swap_page()
path.

Thanks Ying Huang for the really helpful brainstorming discussions on the
swap_read_folio() plug design.

Suggested-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/memory.c     | 187 +++++++++++++++++++++++++++++++++++++-----------
 mm/shmem.c      |   2 +-
 mm/swap.h       |  12 ++--
 mm/swap_state.c | 157 ++++++++++++++++++++++++++++++++++++----
 mm/swapfile.c   |   2 +-
 5 files changed, 299 insertions(+), 61 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b5745b9ffdf7..9655b85fc243 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3924,6 +3924,42 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	return 0;
 }
 
+/*
+ * swapin readahead based batching interface for zswap batched loads using IAA:
+ *
+ * Should only be called for and if the faulting swap entry in do_swap_page
+ * is single-mapped and SWP_SYNCHRONOUS_IO.
+ *
+ * Detect if the folio is in the swapcache, is still mapped to only this
+ * process, and further, there are no additional references to this folio
+ * (for e.g. if another process simultaneously readahead this swap entry
+ * while this process was handling the page-fault, and got a pointer to the
+ * folio allocated by this process in the swapcache), besides the references
+ * that were obtained within __read_swap_cache_async() by this process that is
+ * faulting in this single-mapped swap entry.
+ */
+static inline bool should_free_singlemap_swapcache(swp_entry_t entry,
+						   struct folio *folio)
+{
+	if (!folio_test_swapcache(folio))
+		return false;
+
+	if (__swap_count(entry) != 0)
+		return false;
+
+	/*
+	 * The folio ref count for a single-mapped folio that was allocated
+	 * in __read_swap_cache_async(), can be a maximum of 3. These are the
+	 * incrementors of the folio ref count in __read_swap_cache_async():
+	 * folio_alloc_mpol(), add_to_swap_cache(), folio_add_lru().
+	 */
+
+	if (folio_ref_count(folio) <= 3)
+		return true;
+
+	return false;
+}
+
 static inline bool should_try_to_free_swap(struct folio *folio,
 					   struct vm_area_struct *vma,
 					   unsigned int fault_flags)
@@ -4215,6 +4251,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swp_entry_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
+	bool single_mapped_swapcache = false;
 	void *shadow = NULL;
 	int nr_pages;
 	unsigned long page_idx;
@@ -4283,51 +4320,90 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/* skip swapcache */
-			folio = alloc_swap_folio(vmf);
-			if (folio) {
-				__folio_set_locked(folio);
-				__folio_set_swapbacked(folio);
-
-				nr_pages = folio_nr_pages(folio);
-				if (folio_test_large(folio))
-					entry.val = ALIGN_DOWN(entry.val, nr_pages);
-				/*
-				 * Prevent parallel swapin from proceeding with
-				 * the cache flag. Otherwise, another thread
-				 * may finish swapin first, free the entry, and
-				 * swapout reusing the same entry. It's
-				 * undetectable as pte_same() returns true due
-				 * to entry reuse.
-				 */
-				if (swapcache_prepare(entry, nr_pages)) {
+			if (zswap_never_enabled()) {
+				/* skip swapcache */
+				folio = alloc_swap_folio(vmf);
+				if (folio) {
+					__folio_set_locked(folio);
+					__folio_set_swapbacked(folio);
+
+					nr_pages = folio_nr_pages(folio);
+					if (folio_test_large(folio))
+						entry.val = ALIGN_DOWN(entry.val, nr_pages);
 					/*
-					 * Relax a bit to prevent rapid
-					 * repeated page faults.
+					 * Prevent parallel swapin from proceeding with
+					 * the cache flag. Otherwise, another thread
+					 * may finish swapin first, free the entry, and
+					 * swapout reusing the same entry. It's
+					 * undetectable as pte_same() returns true due
+					 * to entry reuse.
 					 */
-					add_wait_queue(&swapcache_wq, &wait);
-					schedule_timeout_uninterruptible(1);
-					remove_wait_queue(&swapcache_wq, &wait);
-					goto out_page;
+					if (swapcache_prepare(entry, nr_pages)) {
+						/*
+						 * Relax a bit to prevent rapid
+						 * repeated page faults.
+						 */
+						add_wait_queue(&swapcache_wq, &wait);
+						schedule_timeout_uninterruptible(1);
+						remove_wait_queue(&swapcache_wq, &wait);
+						goto out_page;
+					}
+					need_clear_cache = true;
+
+					mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
+
+					shadow = get_shadow_from_swap_cache(entry);
+					if (shadow)
+						workingset_refault(folio, shadow);
+
+					folio_add_lru(folio);
+
+					/* To provide entry to swap_read_folio() */
+					folio->swap = entry;
+					swap_read_folio(folio, NULL, NULL, NULL);
+					folio->private = NULL;
+				}
+			} else {
+				/*
+				 * zswap is enabled or was enabled at some point.
+				 * Don't skip swapcache.
+				 *
+				 * swapin readahead based batching interface
+				 * for zswap batched loads using IAA:
+				 *
+				 * Readahead is invoked in this path only if
+				 * the sys swap "singlemapped_ra_enabled" swap
+				 * parameter is set to true. By default,
+				 * "singlemapped_ra_enabled" is set to false,
+				 * the recommended setting for software compressors.
+				 * For IAA, if "singlemapped_ra_enabled" is set
+				 * to true, readahead will be deployed in this path
+				 * as well.
+				 *
+				 * For single-mapped pages, the batching interface
+				 * calls __read_swap_cache_async() to allocate and
+				 * place the faulting page in the swapcache. This is
+				 * to handle a scenario where the faulting page in
+				 * this process happens to simultaneously be a
+				 * readahead page in another process. By placing the
+				 * single-mapped faulting page in the swapcache,
+				 * we avoid race conditions and duplicate page
+				 * allocations under these scenarios.
+				 */
+				folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+							 vmf, true);
+				if (!folio) {
+					ret = VM_FAULT_OOM;
+					goto out;
 				}
-				need_clear_cache = true;
-
-				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
-
-				shadow = get_shadow_from_swap_cache(entry);
-				if (shadow)
-					workingset_refault(folio, shadow);
-
-				folio_add_lru(folio);
 
-				/* To provide entry to swap_read_folio() */
-				folio->swap = entry;
-				swap_read_folio(folio, NULL, NULL, NULL);
-				folio->private = NULL;
-			}
+				single_mapped_swapcache = true;
+				nr_pages = folio_nr_pages(folio);
+				swapcache = folio;
+			} /* swapin with zswap support. */
 		} else {
 			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						vmf);
+						 vmf, false);
 			swapcache = folio;
 		}
 
@@ -4528,8 +4604,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * yet.
 	 */
 	swap_free_nr(entry, nr_pages);
-	if (should_try_to_free_swap(folio, vma, vmf->flags))
+	if (should_try_to_free_swap(folio, vma, vmf->flags)) {
 		folio_free_swap(folio);
+		single_mapped_swapcache = false;
+	}
 
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
 	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
@@ -4619,6 +4697,30 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (waitqueue_active(&swapcache_wq))
 			wake_up(&swapcache_wq);
 	}
+
+	/*
+	 * swapin readahead based batching interface
+	 * for zswap batched loads using IAA:
+	 *
+	 * Don't skip swapcache strategy for single-mapped
+	 * pages: As described above, we place the
+	 * single-mapped faulting page in the swapcache,
+	 * to avoid race conditions and duplicate page
+	 * allocations between process 1 handling a
+	 * page-fault for a single-mapped page, while
+	 * simultaneously, the same swap entry is a
+	 * readahead prefetch page in another process 2.
+	 *
+	 * One side-effect of this, is that if the race did
+	 * not occur, we need to clean up the swapcache
+	 * entry and free the zswap entry for the faulting
+	 * page, iff it is still single-mapped and is
+	 * exclusive to this process.
+	 */
+	if (single_mapped_swapcache &&
+		data_race(should_free_singlemap_swapcache(entry, folio)))
+		folio_free_swap(folio);
+
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4638,6 +4740,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (waitqueue_active(&swapcache_wq))
 			wake_up(&swapcache_wq);
 	}
+
+	if (single_mapped_swapcache &&
+		data_race(should_free_singlemap_swapcache(entry, folio)))
+		folio_free_swap(folio);
+
 	if (si)
 		put_swap_device(si);
 	return ret;
diff --git a/mm/shmem.c b/mm/shmem.c
index 66eae800ffab..e4549c04f316 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1624,7 +1624,7 @@ static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
 	struct folio *folio;
 
 	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
-	folio = swap_cluster_readahead(swap, gfp, mpol, ilx);
+	folio = swap_cluster_readahead(swap, gfp, mpol, ilx, false);
 	mpol_cond_put(mpol);
 
 	return folio;
diff --git a/mm/swap.h b/mm/swap.h
index 2b82c8ed765c..2861bd8f5a96 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -199,9 +199,11 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
-		struct mempolicy *mpol, pgoff_t ilx);
+		struct mempolicy *mpol, pgoff_t ilx,
+		bool single_mapped_path);
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
-		struct vm_fault *vmf);
+		struct vm_fault *vmf,
+		bool single_mapped_path);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -304,13 +306,15 @@ static inline void show_swap_cache_info(void)
 }
 
 static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
-			gfp_t gfp_mask, struct mempolicy *mpol, pgoff_t ilx)
+			gfp_t gfp_mask, struct mempolicy *mpol, pgoff_t ilx,
+			bool single_mapped_path)
 {
 	return NULL;
 }
 
 static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf)
+			struct vm_fault *vmf,
+			bool single_mapped_path)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0aa938e4c34d..66ea8f7f724c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -44,6 +44,12 @@ struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static bool enable_vma_readahead __read_mostly = true;
 
+/*
+ * Enable readahead in single-mapped do_swap_page() path.
+ * Set to "true" for IAA.
+ */
+static bool enable_singlemapped_readahead __read_mostly = false;
+
 #define SWAP_RA_WIN_SHIFT	(PAGE_SHIFT / 2)
 #define SWAP_RA_HITS_MASK	((1UL << SWAP_RA_WIN_SHIFT) - 1)
 #define SWAP_RA_HITS_MAX	SWAP_RA_HITS_MASK
@@ -340,6 +346,11 @@ static inline bool swap_use_vma_readahead(void)
 	return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
 }
 
+static inline bool swap_use_singlemapped_readahead(void)
+{
+	return READ_ONCE(enable_singlemapped_readahead);
+}
+
 /*
  * Lookup a swap entry in the swap cache. A found folio will be returned
  * unlocked and with its refcount incremented - we rely on the kernel
@@ -635,12 +646,49 @@ static unsigned long swapin_nr_pages(unsigned long offset)
 	return pages;
 }
 
+static void process_ra_batch_of_same_type(
+	struct zswap_decomp_batch *zswap_batch,
+	struct folio_batch *non_zswap_batch,
+	swp_entry_t targ_entry,
+	struct swap_iocb **splug)
+{
+	unsigned int i;
+
+	for (i = 0; i < folio_batch_count(non_zswap_batch); ++i) {
+		struct folio *folio = non_zswap_batch->folios[i];
+		swap_read_folio(folio, splug, NULL, NULL);
+		if (folio->swap.val != targ_entry.val) {
+			folio_set_readahead(folio);
+			count_vm_event(SWAP_RA);
+		}
+		folio_put(folio);
+	}
+
+	swap_read_zswap_batch_unplug(zswap_batch, splug);
+
+	for (i = 0; i < folio_batch_count(&zswap_batch->fbatch); ++i) {
+		struct folio *folio = zswap_batch->fbatch.folios[i];
+		if (folio->swap.val != targ_entry.val) {
+			folio_set_readahead(folio);
+			count_vm_event(SWAP_RA);
+		}
+		folio_put(folio);
+	}
+
+	folio_batch_reinit(non_zswap_batch);
+
+	zswap_load_batch_reinit(zswap_batch);
+}
+
 /**
  * swap_cluster_readahead - swap in pages in hope we need them soon
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @mpol: NUMA memory allocation policy to be applied
  * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
+ * @single_mapped_path: Called from do_swap_page() single-mapped path.
+ * Only readahead if the sys "singlemapped_ra_enabled" swap parameter
+ * is set to true.
  *
  * Returns the struct folio for entry and addr, after queueing swapin.
  *
@@ -654,7 +702,8 @@ static unsigned long swapin_nr_pages(unsigned long offset)
  * are fairly likely to have been swapped out from the same node.
  */
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				    struct mempolicy *mpol, pgoff_t ilx)
+				     struct mempolicy *mpol, pgoff_t ilx,
+				     bool single_mapped_path)
 {
 	struct folio *folio;
 	unsigned long entry_offset = swp_offset(entry);
@@ -664,12 +713,22 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
+	struct zswap_decomp_batch zswap_batch;
+	struct folio_batch non_zswap_batch;
 	bool page_allocated;
 
+	if (single_mapped_path &&
+		(!swap_use_singlemapped_readahead() ||
+		 !zswap_load_batching_enabled()))
+		goto skip;
+
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
 
+	zswap_load_batch_init(&zswap_batch);
+	folio_batch_init(&non_zswap_batch);
+
 	/* Read a page_cluster sized and aligned cluster around offset. */
 	start_offset = offset & ~mask;
 	end_offset = offset | mask;
@@ -678,6 +737,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	if (end_offset >= si->max)
 		end_offset = si->max - 1;
 
+	/* Note that all swap entries readahead are of the same swap type. */
 	blk_start_plug(&plug);
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
@@ -687,14 +747,22 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		if (!folio)
 			continue;
 		if (page_allocated) {
-			swap_read_folio(folio, &splug, NULL, NULL);
-			if (offset != entry_offset) {
-				folio_set_readahead(folio);
-				count_vm_event(SWAP_RA);
+			if (swap_read_folio(folio, &splug,
+					    &zswap_batch, &non_zswap_batch)) {
+				if (offset != entry_offset) {
+					folio_set_readahead(folio);
+					count_vm_event(SWAP_RA);
+				}
+				folio_put(folio);
 			}
+		} else {
+			folio_put(folio);
 		}
-		folio_put(folio);
 	}
+
+	process_ra_batch_of_same_type(&zswap_batch, &non_zswap_batch,
+				      entry, &splug);
+
 	blk_finish_plug(&plug);
 	swap_read_unplug(splug);
 	lru_add_drain();	/* Push any new pages onto the LRU now */
@@ -1009,6 +1077,9 @@ static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
  * @mpol: NUMA memory allocation policy to be applied
  * @targ_ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
  * @vmf: fault information
+ * @single_mapped_path: Called from do_swap_page() single-mapped path.
+ * Only readahead if the sys "singlemapped_ra_enabled" swap parameter
+ * is set to true.
  *
  * Returns the struct folio for entry and addr, after queueing swapin.
  *
@@ -1019,10 +1090,14 @@ static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
  *
  */
 static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
-		struct mempolicy *mpol, pgoff_t targ_ilx, struct vm_fault *vmf)
+		struct mempolicy *mpol, pgoff_t targ_ilx, struct vm_fault *vmf,
+		bool single_mapped_path)
 {
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
+	struct zswap_decomp_batch zswap_batch;
+	struct folio_batch non_zswap_batch;
+	int type = -1, prev_type = -1;
 	struct folio *folio;
 	pte_t *pte = NULL, pentry;
 	int win;
@@ -1031,10 +1106,18 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	pgoff_t ilx;
 	bool page_allocated;
 
+	if (single_mapped_path &&
+		(!swap_use_singlemapped_readahead() ||
+		 !zswap_load_batching_enabled()))
+		goto skip;
+
 	win = swap_vma_ra_win(vmf, &start, &end);
 	if (win == 1)
 		goto skip;
 
+	zswap_load_batch_init(&zswap_batch);
+	folio_batch_init(&non_zswap_batch);
+
 	ilx = targ_ilx - PFN_DOWN(vmf->address - start);
 
 	blk_start_plug(&plug);
@@ -1057,16 +1140,38 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		if (!folio)
 			continue;
 		if (page_allocated) {
-			swap_read_folio(folio, &splug, NULL, NULL);
-			if (addr != vmf->address) {
-				folio_set_readahead(folio);
-				count_vm_event(SWAP_RA);
+			type = swp_type(entry);
+
+			/*
+			 * Process this sub-batch before switching to
+			 * another swap device type.
+			 */
+			if ((prev_type >= 0) && (type != prev_type))
+				process_ra_batch_of_same_type(&zswap_batch,
+							      &non_zswap_batch,
+							      targ_entry,
+							      &splug);
+
+			if (swap_read_folio(folio, &splug,
+					    &zswap_batch, &non_zswap_batch)) {
+				if (addr != vmf->address) {
+					folio_set_readahead(folio);
+					count_vm_event(SWAP_RA);
+				}
+				folio_put(folio);
 			}
+
+			prev_type = type;
+		} else {
+			folio_put(folio);
 		}
-		folio_put(folio);
 	}
 	if (pte)
 		pte_unmap(pte);
+
+	process_ra_batch_of_same_type(&zswap_batch, &non_zswap_batch,
+				      targ_entry, &splug);
+
 	blk_finish_plug(&plug);
 	swap_read_unplug(splug);
 	lru_add_drain();
@@ -1092,7 +1197,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * or vma-based(ie, virtual address based on faulty address) readahead.
  */
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				struct vm_fault *vmf)
+				struct vm_fault *vmf, bool single_mapped_path)
 {
 	struct mempolicy *mpol;
 	pgoff_t ilx;
@@ -1100,8 +1205,10 @@ struct folio *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	folio = swap_use_vma_readahead() ?
-		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
-		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf,
+				   single_mapped_path) :
+		swap_cluster_readahead(entry, gfp_mask, mpol, ilx,
+				       single_mapped_path);
 	mpol_cond_put(mpol);
 
 	return folio;
@@ -1126,10 +1233,30 @@ static ssize_t vma_ra_enabled_store(struct kobject *kobj,
 
 	return count;
 }
+static ssize_t singlemapped_ra_enabled_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  enable_singlemapped_readahead ? "true" : "false");
+}
+static ssize_t singlemapped_ra_enabled_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &enable_singlemapped_readahead);
+	if (ret)
+		return ret;
+
+	return count;
+}
 static struct kobj_attribute vma_ra_enabled_attr = __ATTR_RW(vma_ra_enabled);
+static struct kobj_attribute singlemapped_ra_enabled_attr = __ATTR_RW(singlemapped_ra_enabled);
 
 static struct attribute *swap_attrs[] = {
 	&vma_ra_enabled_attr.attr,
+	&singlemapped_ra_enabled_attr.attr,
 	NULL,
 };
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b0915f3fab31..10367eaee1ff 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2197,7 +2197,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			};
 
 			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						&vmf);
+						&vmf, false);
 		}
 		if (!folio) {
 			swp_count = READ_ONCE(si->swap_map[offset]);
-- 
2.27.0



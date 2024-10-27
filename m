Return-Path: <linux-kernel+bounces-383778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47DB9B2021
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850E7281F81
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E11741CB;
	Sun, 27 Oct 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HGT0pIL"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4C7DA79
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059340; cv=none; b=rFhH26U335ElZWVAnzaTzJ6N/0TXte6HrwAEU3WOHw9Hzk2HkXD5i7/0D5sokeCsOvXEdbsmboSZE2g+u4lizNv2QIlxM1d0NN/FvBmRsJOqOsxkVwbxPHkY56P4785a58ouHn3Ib6iVvx9x1DHYLFPdjRroCbfnjcnzfEhhG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059340; c=relaxed/simple;
	bh=xUvwuZX0vJ+FIPy60UsfYPZQTdhx9uwZ0X0RVU+VuS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tbxWy5e+SDc1VxvxZj+9ssjIscovevrdky2Rrw3WEms25Kd3MKmh4uKCiEycVXCCrTQNHtMrnHsMHhgtSjRiLpX3m3wmdL7fbnQ5mT7pT56oAQWRqsqrZNUQk2VYm0O3vSYo4CjI557RGqOk6nLNO17StjBLZO+/XdJ69jsJkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HGT0pIL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-207115e3056so29391375ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730059337; x=1730664137; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5xhn7RSTWM2lUg8fS/XXmeMk68KKIj9kU8T8Vkq0vE=;
        b=1HGT0pIL4cx0SLhlfbyaIPGarHz8oKjnGCJdIjtgxKBf6XQVwz3uehbgwO7Vmll65Z
         mgGAC6QeWm1794FOPOOnJk3gwsVHFw2ytjGc+Ig/QV6irEzlKTL7cLDMpXbUg+Ye5dWb
         +Bxg1egYZ2Y3rR+GFn4BLO7LwMunh9nb7KgPnWF713xlxEq7eMSiOMvG6hDzVnU1CdAM
         I67vkIzbHxIW1082l8udryCyaMOyOfuJGxI1JcRDWIbDJ6tPgv6YSiS6VUVy+Ny9O2wD
         L7jIU+PBpYFKbOmKx/6jZ4hsngE68pl6gTiN699lu+hunG3yM50P2zOAjiUNxSF4I3Kl
         Ectw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059337; x=1730664137;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5xhn7RSTWM2lUg8fS/XXmeMk68KKIj9kU8T8Vkq0vE=;
        b=j/3vPj8evTrk6h56dkADnwQzprlaUOD4U7fACHM37c0fWbgyFf8r7HfnZsZ9WACazH
         tWCgGD9dhrg/e0kXI2O1FLWmILUiJuGWhIUSC7eOeirkFQGlui5lJN5bGMvycbpj5WjL
         FdGt6aF70LmE7gAy1cyEI6Ur8oN/9eFHhyfUe28Wa+C4PGrDuWXwz7uXBT+/i0lGGsQI
         X0tRGNpWg+4hoEkkCW8HtDd8YitGYpwCuaFyWxmPBYoVcISzDZARPUzD0KojD7b7f3Fx
         ysATn+RvhImX5CKSE4uAR/FV+okgkVdsD6MT/igT4wMM8pSXnSy2ri4FYx3xeYVZb1/o
         hrKA==
X-Forwarded-Encrypted: i=1; AJvYcCXaYmlj5U5wwcsSkSuUSSGNp7YCDirwDTke4B4CdBljcIjmcKSyuIvpZursMW5QUoPbVMN1vLixeqeIHDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8+sVL0jVd94fnE3LDT0iuLZvqSLZC3YYMIqZFhR/rXAuaA0/
	qN6AiV+LAjTK2acTub6Oy5KtWHhnJNn9ct/zx316HGl8nIi+M68C7pxMKjjkcSp9iHxBEQShhml
	a+g==
X-Google-Smtp-Source: AGHT+IFXtBky9M44SnX3mQY4FJdgBxzvChjhDvJFPpQvhFVYc7LnC9xewMls9dbjbG2N/cnCVIf+Sg==
X-Received: by 2002:a17:90a:b111:b0:2e2:d16e:8769 with SMTP id 98e67ed59e1d1-2e8f106926emr7546123a91.15.1730059336486;
        Sun, 27 Oct 2024 13:02:16 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555b67sm5611114a91.9.2024.10.27.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:02:14 -0700 (PDT)
Date: Sun, 27 Oct 2024 13:02:13 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH hotfix v2 2/2] mm/thp: fix deferred split unqueue naming and
 locking
In-Reply-To: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
Message-ID: <8dc111ae-f6db-2da7-b25c-7a20b1effe3b@google.com>
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Recent changes are putting more pressure on THP deferred split queues:
under load revealing long-standing races, causing list_del corruptions,
"Bad page state"s and worse (I keep BUGs in both of those, so usually
don't get to see how badly they end up without).  The relevant recent
changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
improved swap allocation, and underused THP splitting.

Before fixing locking: rename misleading folio_undo_large_rmappable(),
which does not undo large_rmappable, to folio_unqueue_deferred_split(),
which is what it does.  But that and its out-of-line __callee are mm
internals of very limited usability: add comment and WARN_ON_ONCEs to
check usage; and return a bool to say if a deferred split was unqueued,
which can then be used in WARN_ON_ONCEs around safety checks (sparing
callers the arcane conditionals in __folio_unqueue_deferred_split()).

Just omit the folio_unqueue_deferred_split() from free_unref_folios(),
all of whose callers now call it beforehand (and if any forget then
bad_page() will tell) - except for its caller put_pages_list(), which
itself no longer has any callers (and will be deleted separately).

Swapout: mem_cgroup_swapout() has been resetting folio->memcg_data 0
without checking and unqueueing a THP folio from deferred split list;
which is unfortunate, since the split_queue_lock depends on the memcg
(when memcg is enabled); so swapout has been unqueueing such THPs later,
when freeing the folio, using the pgdat's lock instead: potentially
corrupting the memcg's list.  __remove_mapping() has frozen refcount to
0 here, so no problem with calling folio_unqueue_deferred_split() before
resetting memcg_data.

That goes back to 5.4 commit 87eaceb3faa5 ("mm: thp: make deferred split
shrinker memcg aware"): which included a check on swapcache before adding
to deferred queue, but no check on deferred queue before adding THP to
swapcache.  That worked fine with the usual sequence of events in reclaim
(though there were a couple of rare ways in which a THP on deferred queue
could have been swapped out), but 6.12 commit dafff3f4c850 ("mm: split
underused THPs") avoids splitting underused THPs in reclaim, which makes
swapcache THPs on deferred queue commonplace.

Keep the check on swapcache before adding to deferred queue?  Yes: it is
no longer essential, but preserves the existing behaviour, and is likely
to be a worthwhile optimization (vmstat showed much more traffic on the
queue under swapping load if the check was removed); update its comment.

Memcg-v1 move (deprecated): mem_cgroup_move_account() has been changing
folio->memcg_data without checking and unqueueing a THP folio from the
deferred list, sometimes corrupting "from" memcg's list, like swapout.
Refcount is non-zero here, so folio_unqueue_deferred_split() can only be
used in a WARN_ON_ONCE to validate the fix, which must be done earlier:
mem_cgroup_move_charge_pte_range() first try to split the THP (splitting
of course unqueues), or skip it if that fails.  Not ideal, but moving
charge has been requested, and khugepaged should repair the THP later:
nobody wants new custom unqueueing code just for this deprecated case.

The 87eaceb3faa5 commit did have the code to move from one deferred list
to another (but was not conscious of its unsafety while refcount non-0);
but that was removed by 5.6 commit fac0516b5534 ("mm: thp: don't need
care deferred split queue in memcg charge move path"), which argued that
the existence of a PMD mapping guarantees that the THP cannot be on a
deferred list.  As above, false in rare cases, and now commonly false.

Backport to 6.11 should be straightforward. Earlier backports must take
care that other _deferred_list fixes and dependencies are included.
There is not a strong case for backports, but they can fix cornercases.

Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
Fixes: dafff3f4c850 ("mm: split underused THPs")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
Based on 6.12-rc4
v2: adjusted commit message following info from Yang and David
    reinstated deferred_split_folio swapcache check, adjusting comment
    omitted (mem_cgroup_disabled) unqueue from free_unref_folios

 mm/huge_memory.c   | 35 ++++++++++++++++++++++++++---------
 mm/internal.h      | 10 +++++-----
 mm/memcontrol-v1.c | 25 +++++++++++++++++++++++++
 mm/memcontrol.c    |  8 +++++---
 mm/migrate.c       |  4 ++--
 mm/page_alloc.c    |  1 -
 mm/swap.c          |  4 ++--
 mm/vmscan.c        |  4 ++--
 8 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a1d345f1680c..03fd4bc39ea1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3588,10 +3588,27 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
 	return split_huge_page_to_list_to_order(&folio->page, list, ret);
 }
 
-void __folio_undo_large_rmappable(struct folio *folio)
+/*
+ * __folio_unqueue_deferred_split() is not to be called directly:
+ * the folio_unqueue_deferred_split() inline wrapper in mm/internal.h
+ * limits its calls to those folios which may have a _deferred_list for
+ * queueing THP splits, and that list is (racily observed to be) non-empty.
+ *
+ * It is unsafe to call folio_unqueue_deferred_split() until folio refcount is
+ * zero: because even when split_queue_lock is held, a non-empty _deferred_list
+ * might be in use on deferred_split_scan()'s unlocked on-stack list.
+ *
+ * If memory cgroups are enabled, split_queue_lock is in the mem_cgroup: it is
+ * therefore important to unqueue deferred split before changing folio memcg.
+ */
+bool __folio_unqueue_deferred_split(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
 	unsigned long flags;
+	bool unqueued = false;
+
+	WARN_ON_ONCE(folio_ref_count(folio));
+	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
 
 	ds_queue = get_deferred_split_queue(folio);
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
@@ -3603,8 +3620,11 @@ void __folio_undo_large_rmappable(struct folio *folio)
 				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 		}
 		list_del_init(&folio->_deferred_list);
+		unqueued = true;
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+
+	return unqueued;	/* useful for debug warnings */
 }
 
 /* partially_mapped=false won't clear PG_partially_mapped folio flag */
@@ -3627,14 +3647,11 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 		return;
 
 	/*
-	 * The try_to_unmap() in page reclaim path might reach here too,
-	 * this may cause a race condition to corrupt deferred split queue.
-	 * And, if page reclaim is already handling the same folio, it is
-	 * unnecessary to handle it again in shrinker.
-	 *
-	 * Check the swapcache flag to determine if the folio is being
-	 * handled by page reclaim since THP swap would add the folio into
-	 * swap cache before calling try_to_unmap().
+	 * Exclude swapcache: originally to avoid a corrupt deferred split
+	 * queue. Nowadays that is fully prevented by mem_cgroup_swapout();
+	 * but if page reclaim is already handling the same folio, it is
+	 * unnecessary to handle it again in the shrinker, so excluding
+	 * swapcache here may still be a useful optimization.
 	 */
 	if (folio_test_swapcache(folio))
 		return;
diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..16c1f3cd599e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -639,11 +639,11 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 #endif
 }
 
-void __folio_undo_large_rmappable(struct folio *folio);
-static inline void folio_undo_large_rmappable(struct folio *folio)
+bool __folio_unqueue_deferred_split(struct folio *folio);
+static inline bool folio_unqueue_deferred_split(struct folio *folio)
 {
 	if (folio_order(folio) <= 1 || !folio_test_large_rmappable(folio))
-		return;
+		return false;
 
 	/*
 	 * At this point, there is no one trying to add the folio to
@@ -651,9 +651,9 @@ static inline void folio_undo_large_rmappable(struct folio *folio)
 	 * to check without acquiring the split_queue_lock.
 	 */
 	if (data_race(list_empty(&folio->_deferred_list)))
-		return;
+		return false;
 
-	__folio_undo_large_rmappable(folio);
+	return __folio_unqueue_deferred_split(folio);
 }
 
 static inline struct folio *page_rmappable_folio(struct page *page)
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 81d8819f13cd..f8744f5630bb 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -848,6 +848,8 @@ static int mem_cgroup_move_account(struct folio *folio,
 	css_get(&to->css);
 	css_put(&from->css);
 
+	/* Warning should never happen, so don't worry about refcount non-0 */
+	WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
 	folio->memcg_data = (unsigned long)to;
 
 	__folio_memcg_unlock(from);
@@ -1217,7 +1219,9 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	enum mc_target_type target_type;
 	union mc_target target;
 	struct folio *folio;
+	bool tried_split_before = false;
 
+retry_pmd:
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		if (mc.precharge < HPAGE_PMD_NR) {
@@ -1227,6 +1231,27 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
 		if (target_type == MC_TARGET_PAGE) {
 			folio = target.folio;
+			/*
+			 * Deferred split queue locking depends on memcg,
+			 * and unqueue is unsafe unless folio refcount is 0:
+			 * split or skip if on the queue? first try to split.
+			 */
+			if (!list_empty(&folio->_deferred_list)) {
+				spin_unlock(ptl);
+				if (!tried_split_before)
+					split_folio(folio);
+				folio_unlock(folio);
+				folio_put(folio);
+				if (tried_split_before)
+					return 0;
+				tried_split_before = true;
+				goto retry_pmd;
+			}
+			/*
+			 * So long as that pmd lock is held, the folio cannot
+			 * be racily added to the _deferred_list, because
+			 * __folio_remove_rmap() will find !partially_mapped.
+			 */
 			if (folio_isolate_lru(folio)) {
 				if (!mem_cgroup_move_account(folio, true,
 							     mc.from, mc.to)) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2703227cce88..06df2af97415 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4629,9 +4629,6 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
-	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
-			!folio_test_hugetlb(folio) &&
-			!list_empty(&folio->_deferred_list), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
@@ -4678,6 +4675,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
 
+		WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
 		folio->memcg_data = 0;
 	}
 
@@ -4789,6 +4787,9 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 
 	/* Transfer the charge and the css ref */
 	commit_charge(new, memcg);
+
+	/* Warning should never happen, so don't worry about refcount non-0 */
+	WARN_ON_ONCE(folio_unqueue_deferred_split(old));
 	old->memcg_data = 0;
 }
 
@@ -4975,6 +4976,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	VM_BUG_ON_FOLIO(oldid, folio);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
+	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
 
 	if (!mem_cgroup_is_root(memcg))
diff --git a/mm/migrate.c b/mm/migrate.c
index df91248755e4..691f25ee2489 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -489,7 +489,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		    folio_test_large_rmappable(folio)) {
 			if (!folio_ref_freeze(folio, expected_count))
 				return -EAGAIN;
-			folio_undo_large_rmappable(folio);
+			folio_unqueue_deferred_split(folio);
 			folio_ref_unfreeze(folio, expected_count);
 		}
 
@@ -514,7 +514,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	}
 
 	/* Take off deferred split queue while frozen and memcg set */
-	folio_undo_large_rmappable(folio);
+	folio_unqueue_deferred_split(folio);
 
 	/*
 	 * Now we know that no one else is looking at the folio:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4b21a368b4e2..815100a45b25 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2681,7 +2681,6 @@ void free_unref_folios(struct folio_batch *folios)
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
-		folio_undo_large_rmappable(folio);
 		if (!free_pages_prepare(&folio->page, order))
 			continue;
 		/*
diff --git a/mm/swap.c b/mm/swap.c
index 835bdf324b76..b8e3259ea2c4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -121,7 +121,7 @@ void __folio_put(struct folio *folio)
 	}
 
 	page_cache_release(folio);
-	folio_undo_large_rmappable(folio);
+	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
 	free_unref_page(&folio->page, folio_order(folio));
 }
@@ -988,7 +988,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 			free_huge_folio(folio);
 			continue;
 		}
-		folio_undo_large_rmappable(folio);
+		folio_unqueue_deferred_split(folio);
 		__page_cache_release(folio, &lruvec, &flags);
 
 		if (j != i)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eb4e8440c507..635d45745b73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1475,7 +1475,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 */
 		nr_reclaimed += nr_pages;
 
-		folio_undo_large_rmappable(folio);
+		folio_unqueue_deferred_split(folio);
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
@@ -1863,7 +1863,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 		if (unlikely(folio_put_testzero(folio))) {
 			__folio_clear_lru_flags(folio);
 
-			folio_undo_large_rmappable(folio);
+			folio_unqueue_deferred_split(folio);
 			if (folio_batch_add(&free_folios, folio) == 0) {
 				spin_unlock_irq(&lruvec->lru_lock);
 				mem_cgroup_uncharge_folios(&free_folios);
-- 
2.35.3


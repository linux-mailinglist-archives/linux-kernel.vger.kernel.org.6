Return-Path: <linux-kernel+bounces-533759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245DA45E43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F80189C8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA922DF8B;
	Wed, 26 Feb 2025 12:04:02 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750EB22A4D5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571441; cv=none; b=nwKLW8yapwYLZsX2SxMnuLvu9ujpeMdD0w+BZnIObr1U7FkwrIqzJms6M/odKU3nJpAKbTXvQQSMRF0M9+TtYTa6ZWJpw4UoNGO4le/VSolkVm9d8NsrMXKcb9QjM4K6Q/j9nB7r6yVGzWaQCZ3EmBaqH+b6PRTcl3lVEq3BJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571441; c=relaxed/simple;
	bh=p4X/EQiGspAcWrpvXzGnLoppd5Ru3YKGr9u4Z0pP5e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=P0hbuFfH8t9w3Ckxl0+WvISlrUNVJwt0GigRDPQ5MVJUt04/eUotSHngUNdsW9lOjtLFLdsstH5pvTqlT8oYWfbFCqPpZ7wyMR+cwMPqBKvLMjkyZcfZRUnrQDidyL9oNaTlsmxC9Vy4aLr3xMZ6nhvAnfFp314r5igtmeexZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-66-67bf032324af
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
Subject: [RFC PATCH v12 based on v6.14-rc4 23/25] mm/migrate: apply luf mechanism to unmapping during migration
Date: Wed, 26 Feb 2025 21:03:34 +0900
Message-Id: <20250226120336.29565-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnka4y8/50gw29shZz1q9hs/i84R+b
	xdf1v5gtnn7qY7G4vGsOm8W9Nf9ZLc7vWstqsWPpPiaLSwcWMFkc7z3AZDH/3mc2i82bpjJb
	HJ8yldHi9485bA58Ht9b+1g8ds66y+6xYFOpx+YVWh6bVnWyeWz6NInd4925c+weJ2b8ZvF4
	v+8qm8fWX3YejVOvsXl83iQXwBPFZZOSmpNZllqkb5fAlfFxwV+Wgn8BFX/37GZpYJzo2MXI
	ySEhYCLx9tctFhh71s92JhCbTUBd4saNn8wgtoiAmcTB1j/sXYxcHMwCy5gk9p5oYANJCAvk
	S1ye+AyogYODRUBV4uplP5AwL1D9q/utzBAz5SVWbzgAZnMCxT9NOwbWKiSQLLHz9x8mkJkS
	ArfZJJ4cPgR1hKTEwRU3WCYw8i5gZFjFKJSZV5abmJljopdRmZdZoZecn7uJERjUy2r/RO9g
	/HQh+BCjAAejEg/vgzN704VYE8uKK3MPMUpwMCuJ8HJm7kkX4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwLjmyq818vf3sfz67aZbLvr3tfg2Ka2Vc9an
	u7WLzZ/xhiHwwzwZo9ZjU9cUcrwolBXkkC6yUPGuN978jKVDWf/kfAWmi08+Pz0e1s6zyn7p
	AU7j67xnXvRxupw2WZnKfrxLmPFRDcvfdU95nR+wSfn1nmF6dPOddfu38Dr3kypxP6/vcD78
	6aASS3FGoqEWc1FxIgCdmyVNZgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvMvD/d4MYBIYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyPi74y1LwL6Di
	757dLA2MEx27GDk5JARMJGb9bGcCsdkE1CVu3PjJDGKLCJhJHGz9w97FyMXBLLCMSWLviQY2
	kISwQL7E5YnPgBo4OFgEVCWuXvYDCfMC1b+638oMMVNeYvWGA2A2J1D807RjYK1CAskSO3//
	YZrAyLWAkWEVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYIguq/0zcQfjl8vuhxgFOBiVeHgf
	nNmbLsSaWFZcmXuIUYKDWUmElzNzT7oQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w1AQhgfTE
	ktTs1NSC1CKYLBMHp1QDIwtLfybnL7GM1RkLL8z/sTH6I/P2ovVMDFvKOzKM5stf28n92lpt
	er5M2JGLD7Oaz7fZH567zVJtVUJdis/TTXNVHgldiPVpDYt+X8pSpLjd5xd/qtmH05/WXmY7
	6ORjGHGkK0c0MCX5oPnjIxy2dc77lVW3XWi4t8Le4rbFt/uJD3XOzu+ZrcRSnJFoqMVcVJwI
	AOzi2bhNAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read only and were unmapped, since
the contents of the folios don't change while staying in pcp or buddy
so we can still read the data through the stale tlb entries.

Applied the mechanism to unmapping during migration.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h   |  2 ++
 include/linux/rmap.h |  2 +-
 mm/migrate.c         | 66 ++++++++++++++++++++++++++++++++++----------
 mm/rmap.c            | 15 ++++++----
 mm/swap.c            |  2 +-
 5 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e8e6562abc77d..1577bc8b743fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1489,6 +1489,8 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+void page_cache_release(struct folio *folio);
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 683a04088f3f2..cedba4812ccc7 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -660,7 +660,7 @@ static inline int folio_try_share_anon_rmap_pmd(struct folio *folio,
 int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
-void try_to_migrate(struct folio *folio, enum ttu_flags flags);
+bool try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
 
 int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18892c89..7ce4d3dbcb1af 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1164,7 +1164,8 @@ static void migrate_folio_undo_dst(struct folio *dst, bool locked,
 
 /* Cleanup src folio upon migration success */
 static void migrate_folio_done(struct folio *src,
-			       enum migrate_reason reason)
+			       enum migrate_reason reason,
+			       unsigned short luf_key)
 {
 	/*
 	 * Compaction can migrate also non-LRU pages which are
@@ -1175,16 +1176,31 @@ static void migrate_folio_done(struct folio *src,
 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
 				    folio_is_file_lru(src), -folio_nr_pages(src));
 
-	if (reason != MR_MEMORY_FAILURE)
-		/* We release the page in page_handle_poison. */
+	/* We release the page in page_handle_poison. */
+	if (reason == MR_MEMORY_FAILURE)
+		luf_flush(luf_key);
+	else if (!luf_key)
 		folio_put(src);
+	else {
+		/*
+		 * Should be the last reference.
+		 */
+		if (unlikely(!folio_put_testzero(src)))
+			VM_WARN_ON(1);
+
+		page_cache_release(src);
+		folio_unqueue_deferred_split(src);
+		mem_cgroup_uncharge(src);
+		free_frozen_pages(&src->page, folio_order(src), luf_key);
+	}
 }
 
 /* Obtain the lock on page, remove all ptes. */
 static int migrate_folio_unmap(new_folio_t get_new_folio,
 		free_folio_t put_new_folio, unsigned long private,
 		struct folio *src, struct folio **dstp, enum migrate_mode mode,
-		enum migrate_reason reason, struct list_head *ret)
+		enum migrate_reason reason, struct list_head *ret,
+		bool *can_luf)
 {
 	struct folio *dst;
 	int rc = -EAGAIN;
@@ -1200,7 +1216,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_clear_unevictable(src);
 		/* free_pages_prepare() will clear PG_isolated. */
 		list_del(&src->lru);
-		migrate_folio_done(src, reason);
+		migrate_folio_done(src, reason, 0);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1317,7 +1333,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
+		*can_luf = try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
 		old_page_state |= PAGE_WAS_MAPPED;
 	}
 
@@ -1345,7 +1361,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 			      struct folio *src, struct folio *dst,
 			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
+			      struct list_head *ret, unsigned short luf_key)
 {
 	int rc;
 	int old_page_state = 0;
@@ -1399,7 +1415,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 	folio_unlock(src);
-	migrate_folio_done(src, reason);
+	migrate_folio_done(src, reason, luf_key);
 
 	return rc;
 out:
@@ -1694,7 +1710,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 		struct list_head *ret_folios,
 		struct migrate_pages_stats *stats,
 		int *retry, int *thp_retry, int *nr_failed,
-		int *nr_retry_pages)
+		int *nr_retry_pages, unsigned short luf_key)
 {
 	struct folio *folio, *folio2, *dst, *dst2;
 	bool is_thp;
@@ -1711,7 +1727,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 
 		rc = migrate_folio_move(put_new_folio, private,
 				folio, dst, mode,
-				reason, ret_folios);
+				reason, ret_folios, luf_key);
 		/*
 		 * The rules are:
 		 *	Success: folio will be freed
@@ -1788,7 +1804,11 @@ static int migrate_pages_batch(struct list_head *from,
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
+	LIST_HEAD(unmap_folios_luf);
+	LIST_HEAD(dst_folios_luf);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
+	unsigned short luf_key;
+	bool can_luf;
 
 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
 			!list_empty(from) && !list_is_singular(from));
@@ -1863,9 +1883,11 @@ static int migrate_pages_batch(struct list_head *from,
 				continue;
 			}
 
+			can_luf = false;
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
 					private, folio, &dst, mode, reason,
-					ret_folios);
+					ret_folios, &can_luf);
+
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
@@ -1911,7 +1933,8 @@ static int migrate_pages_batch(struct list_head *from,
 				/* nr_failed isn't updated for not used */
 				stats->nr_thp_failed += thp_retry;
 				rc_saved = rc;
-				if (list_empty(&unmap_folios))
+				if (list_empty(&unmap_folios) &&
+				    list_empty(&unmap_folios_luf))
 					goto out;
 				else
 					goto move;
@@ -1925,8 +1948,13 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_thp_succeeded += is_thp;
 				break;
 			case MIGRATEPAGE_UNMAP:
-				list_move_tail(&folio->lru, &unmap_folios);
-				list_add_tail(&dst->lru, &dst_folios);
+				if (can_luf) {
+					list_move_tail(&folio->lru, &unmap_folios_luf);
+					list_add_tail(&dst->lru, &dst_folios_luf);
+				} else {
+					list_move_tail(&folio->lru, &unmap_folios);
+					list_add_tail(&dst->lru, &dst_folios);
+				}
 				break;
 			default:
 				/*
@@ -1946,6 +1974,8 @@ static int migrate_pages_batch(struct list_head *from,
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
+	/* Should be before try_to_unmap_flush() */
+	luf_key = fold_unmap_luf();
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
@@ -1959,7 +1989,11 @@ static int migrate_pages_batch(struct list_head *from,
 		migrate_folios_move(&unmap_folios, &dst_folios,
 				put_new_folio, private, mode, reason,
 				ret_folios, stats, &retry, &thp_retry,
-				&nr_failed, &nr_retry_pages);
+				&nr_failed, &nr_retry_pages, 0);
+		migrate_folios_move(&unmap_folios_luf, &dst_folios_luf,
+				put_new_folio, private, mode, reason,
+				ret_folios, stats, &retry, &thp_retry,
+				&nr_failed, &nr_retry_pages, luf_key);
 	}
 	nr_failed += retry;
 	stats->nr_thp_failed += thp_retry;
@@ -1970,6 +2004,8 @@ static int migrate_pages_batch(struct list_head *from,
 	/* Cleanup remaining folios */
 	migrate_folios_undo(&unmap_folios, &dst_folios,
 			put_new_folio, private, ret_folios);
+	migrate_folios_undo(&unmap_folios_luf, &dst_folios_luf,
+			put_new_folio, private, ret_folios);
 
 	return rc;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index b6613b48669ac..284fc48aef2de 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2750,8 +2750,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
  *
  * Tries to remove all the page table entries which are mapping this folio and
  * replace them with special swap entries. Caller must hold the folio lock.
+ * Return true if all the mappings are read-only, otherwise false.
  */
-void try_to_migrate(struct folio *folio, enum ttu_flags flags)
+bool try_to_migrate(struct folio *folio, enum ttu_flags flags)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_migrate_one,
@@ -2769,11 +2770,11 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 	 */
 	if (WARN_ON_ONCE(flags & ~(TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
 					TTU_SYNC | TTU_BATCH_FLUSH)))
-		return;
+		return false;
 
 	if (folio_is_zone_device(folio) &&
 	    (!folio_is_device_private(folio) && !folio_is_device_coherent(folio)))
-		return;
+		return false;
 
 	/*
 	 * During exec, a temporary VMA is setup and later moved.
@@ -2793,10 +2794,12 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 	else
 		rmap_walk(folio, &rwc);
 
-	if (can_luf_test())
+	if (can_luf_test()) {
 		fold_batch(tlb_ubc_luf, tlb_ubc_ro, true);
-	else
-		fold_batch(tlb_ubc, tlb_ubc_ro, true);
+		return true;
+	}
+	fold_batch(tlb_ubc, tlb_ubc_ro, true);
+	return false;
 }
 
 #ifdef CONFIG_DEVICE_PRIVATE
diff --git a/mm/swap.c b/mm/swap.c
index 0c6198e4a8ee4..e322670c30041 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -84,7 +84,7 @@ static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
  * This path almost never happens for VM activity - pages are normally freed
  * in batches.  But it gets used by networking - and for compound pages.
  */
-static void page_cache_release(struct folio *folio)
+void page_cache_release(struct folio *folio)
 {
 	struct lruvec *lruvec = NULL;
 	unsigned long flags;
-- 
2.17.1



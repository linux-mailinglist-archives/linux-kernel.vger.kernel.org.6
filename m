Return-Path: <linux-kernel+bounces-523004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C5CA3D0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECBE7A91B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7737F1EEA49;
	Thu, 20 Feb 2025 05:36:15 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9851EB1A6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029773; cv=none; b=r0WvEUGPdHFY2eTd+KpiT7oWmbMhSIL3pNHUUAzQvmbu0s7VMgsOlF/bz/rA9s+kf8jN6ifEJfWC/3PcLH5P2H9v5HQ0l3lcng3o6P/v0cvuQqSxahXVU6Jrd6FXAcQmPWbi/6gYOwR02JbeAmjzAaParwvYh5/y9bd4k5T//aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029773; c=relaxed/simple;
	bh=A6kHinvGbcpszadU980q9bBOHrb8jZD1A7j8NRJzceg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hq6JUTYsDKqB6DagrGU4FEUvwybXJOHBnE2KOPD9frrFDkQGPXQZbcAWWl9/KwtbuA24QQtloUUwLJAzPCp0jb2jSVdLpxPRaYiWt5IjvukFFTNk227LdxsUZoQvtlTNO5rsTd7OXOGadIYcK11F7Atgs3GXmFXfKsW51OC3HQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-26-67b6bba76383
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
Subject: [RFC PATCH v12 24/26] mm/migrate: apply luf mechanism to unmapping during migration
Date: Thu, 20 Feb 2025 14:20:25 +0900
Message-Id: <20250220052027.58847-25-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoe7y3dvSDbbfU7CYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	a+ZsZCq4GlCx6sx8pgbGNw5djJwcEgImEt2vpjLD2Ee+T2MFsdkE1CVu3PgJFhcRMJM42PqH
	HcRmFrjLJHGgnw3EFhaIkdh8oAeshkVAVWL2h32MIDYvUP3CiefZIWbKS6zecACshhMo/mNG
	L1ivkICpxLsFl5i6GLmAat6zSfS/fccE0SApcXDFDZYJjLwLGBlWMQpl5pXlJmbmmOhlVOZl
	Vugl5+duYgSG/rLaP9E7GD9dCD7EKMDBqMTDO6N1W7oQa2JZcWXuIUYJDmYlEd62+i3pQrwp
	iZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhjVTWtvvjIv25Tn
	LrrsZ0FYmYfr2UY1pbZzv9eE3lRy0WV9mMlgrqWqujx0d7bGJPWi+ltxH/Nj97zwfSIZfvXT
	ymvbGXyuO7+8fe7kzFOCnboV3A8d7mcekZQyXbj2f8hHqVtpIduKNLP3xjPnO6rc1hc3/MUi
	19V90LjTUEOt+NqCXuVHBUosxRmJhlrMRcWJAF4LOdZ5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrLt897Z0g8Z/ohZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgylgzZyNTwdWAilVn5jM1ML5x6GLk5JAQMJE48n0aK4jNJqAucePGT2YQW0TA
	TOJg6x92EJtZ4C6TxIF+NhBbWCBGYvOBHrAaFgFVidkf9jGC2LxA9QsnnmeHmCkvsXrDAbAa
	TqD4jxm9YL1CAqYS7xZcYprAyLWAkWEVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYCAvq/0z
	cQfjl8vuhxgFOBiVeHgfPN6aLsSaWFZcmXuIUYKDWUmEt61+S7oQb0piZVVqUX58UWlOavEh
	RmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDI4PEzeR3q75x/Pd+/fmll+1bdZ+87Gt6
	P017ZdpuXi5ZLhdkNY1n18KEHaea2jaZWVjkJrxqNY20m85muV2qY8YB5q+Xfk9dsXRR3Ud3
	NpaOQ5bfAx6Gr9j5+lDjb/ko+dzzCSUac82t/keH1k23j2WbwHXt89ubwVNa757c4P9yVV+3
	+O3wM0osxRmJhlrMRcWJAO3GVDlgAgAA
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
 mm/migrate.c         | 65 ++++++++++++++++++++++++++++++++++----------
 mm/rmap.c            | 15 ++++++----
 mm/swap.c            |  2 +-
 5 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 46638e86e8073..5c81c9831bc5d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1476,6 +1476,8 @@ static inline void folio_put(struct folio *folio)
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
index 5e12023dbc75a..6b77efee4ebd7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1172,7 +1172,8 @@ static void migrate_folio_undo_dst(struct folio *dst, bool locked,
 
 /* Cleanup src folio upon migration success */
 static void migrate_folio_done(struct folio *src,
-			       enum migrate_reason reason)
+			       enum migrate_reason reason,
+			       unsigned short luf_key)
 {
 	/*
 	 * Compaction can migrate also non-LRU pages which are
@@ -1183,16 +1184,30 @@ static void migrate_folio_done(struct folio *src,
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
+		mem_cgroup_uncharge(src);
+		free_unref_page(&src->page, folio_order(src), luf_key);
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
@@ -1208,7 +1223,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_clear_unevictable(src);
 		/* free_pages_prepare() will clear PG_isolated. */
 		list_del(&src->lru);
-		migrate_folio_done(src, reason);
+		migrate_folio_done(src, reason, 0);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1325,7 +1340,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
+		*can_luf = try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
 		old_page_state |= PAGE_WAS_MAPPED;
 	}
 
@@ -1353,7 +1368,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 			      struct folio *src, struct folio *dst,
 			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
+			      struct list_head *ret, unsigned short luf_key)
 {
 	int rc;
 	int old_page_state = 0;
@@ -1407,7 +1422,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 	folio_unlock(src);
-	migrate_folio_done(src, reason);
+	migrate_folio_done(src, reason, luf_key);
 
 	return rc;
 out:
@@ -1702,7 +1717,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 		struct list_head *ret_folios,
 		struct migrate_pages_stats *stats,
 		int *retry, int *thp_retry, int *nr_failed,
-		int *nr_retry_pages)
+		int *nr_retry_pages, unsigned short luf_key)
 {
 	struct folio *folio, *folio2, *dst, *dst2;
 	bool is_thp;
@@ -1719,7 +1734,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 
 		rc = migrate_folio_move(put_new_folio, private,
 				folio, dst, mode,
-				reason, ret_folios);
+				reason, ret_folios, luf_key);
 		/*
 		 * The rules are:
 		 *	Success: folio will be freed
@@ -1796,7 +1811,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1871,9 +1890,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1919,7 +1940,8 @@ static int migrate_pages_batch(struct list_head *from,
 				/* nr_failed isn't updated for not used */
 				stats->nr_thp_failed += thp_retry;
 				rc_saved = rc;
-				if (list_empty(&unmap_folios))
+				if (list_empty(&unmap_folios) &&
+				    list_empty(&unmap_folios_luf))
 					goto out;
 				else
 					goto move;
@@ -1933,8 +1955,13 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1954,6 +1981,8 @@ static int migrate_pages_batch(struct list_head *from,
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
+	/* Should be before try_to_unmap_flush() */
+	luf_key = fold_unmap_luf();
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
@@ -1967,7 +1996,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1978,6 +2011,8 @@ static int migrate_pages_batch(struct list_head *from,
 	/* Cleanup remaining folios */
 	migrate_folios_undo(&unmap_folios, &dst_folios,
 			put_new_folio, private, ret_folios);
+	migrate_folios_undo(&unmap_folios_luf, &dst_folios_luf,
+			put_new_folio, private, ret_folios);
 
 	return rc;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index ebe91ff1bcb16..b6b61b8103655 100644
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
index 54b0ba10dbb86..d6c29fdc67ca5 100644
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



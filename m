Return-Path: <linux-kernel+bounces-533734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A188FA45E28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173181887D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD1221D3F5;
	Wed, 26 Feb 2025 12:01:59 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE134221F16
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571318; cv=none; b=nE3+a6JiP00ijrbASNTkyF3tbZtqEvw4BZBdAhVoBtqLxcxRw2mPBpsjKgnRxgobGNgHslZX4waglAjaLUImkGfMLIFyk85ZGpx5qxUcHiMRi4eVL0gCHba7l1fWzKk2A8qXdB5HuN5qOf9DGo1MmYL5RTdEeA+h8Kg8e0uDEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571318; c=relaxed/simple;
	bh=kH5EqBVOftht7y89XT+HXFB1VSLRW6Ml9C7ObYEE/vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uE/FWCHPaX3mTZStXUM7kXOIgtFRYRrOF/ERwmfMA/0ffmP6kzI6qJcvASIzMGwh12xXs1xsgNqhaokf9/GUo/FE7vDgYZat6kDh23BO/YkjOYumUIldnwGLOgBbnj82XUpwyGUB3JsbG850dudOJ3PaIYxyZowB/cAngkuFP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-37-67bf02a70812
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 23/25]  mm/migrate: apply luf mechanism to unmapping during migration
Date: Wed, 26 Feb 2025 21:01:30 +0900
Message-Id: <20250226120132.28469-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBouOGVjMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8b5/WdZChoCKy7sPMrYwDjJsYuR
	k0NCwESi6dMqJhj7y9EFrCA2m4C6xI0bP5lBbBEBM4mDrX/Yuxi5OJgFljFJ7D3RwAbiCAu0
	Mkp82/cDyOHgYBFQlZjYVgLSwAvU0PriPRvEUHmJ1RsOgA3iBIr/2/2bHcQWEkiWaFn/mwVk
	joTAfTaJ9k/r2CEaJCUOrrjBMoGRdwEjwypGocy8stzEzBwTvYzKvMwKveT83E2MwLBeVvsn
	egfjpwvBhxgFOBiVeHgfnNmbLsSaWFZcmXuIUYKDWUmElzNzT7oQb0piZVVqUX58UWlOavEh
	RmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxjW6OpsO1jryLxfZJVdqah4ac86a5eJ/
	ve61z1l0L7sfm3vzjsh85gahXuYVS1IyeQr7Xxy7vdf6QJ+gNoPjhot3D786374osHca+3qr
	gmksu8VOpJnU1bw22ulbvfXx2j+vWVcdmLOFl6uLmcftbMDE4C16DomuledCHWrqHm42M1z2
	Ve3SayWW4oxEQy3mouJEAK0R8WtnAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLucaX+6wanXahZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlnN9/lqWgIbDi
	ws6jjA2Mkxy7GDk5JARMJL4cXcAKYrMJqEvcuPGTGcQWETCTONj6h72LkYuDWWAZk8TeEw1s
	II6wQCujxLd9P4AcDg4WAVWJiW0lIA28QA2tL96zQQyVl1i94QDYIE6g+L/dv9lBbCGBZImW
	9b9ZJjByLWBkWMUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREYpMtq/0zcwfjlsvshRgEORiUe
	3gdn9qYLsSaWFVfmHmKU4GBWEuHlzNyTLsSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUgg
	PbEkNTs1tSC1CCbLxMEp1cDIa29wK/ymecbRHynKTbPXdK+55+J/4aqCUeO2wj67Y9Y6R01f
	Mp+d9cJKqeW91/Kr712+X/T6c0QjrSdYatrufA6P3uJu20UPHly+9X39NIucoyav3M5XFW6J
	nG/ALjBV2/HTmyUlr4N2Tj99+PGt+zn/7Z37tUwOrgs9P1GHVelhrtAMH04HJZbijERDLeai
	4kQAW73xwE4CAAA=
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
index 2fa5185880105..b41d7804a06a2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1566,6 +1566,8 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+void page_cache_release(struct folio *folio);
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 6abf7960077aa..bfccf2efb9000 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -675,7 +675,7 @@ static inline int folio_try_share_anon_rmap_pmd(struct folio *folio,
 int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
-void try_to_migrate(struct folio *folio, enum ttu_flags flags);
+bool try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
 
 struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
diff --git a/mm/migrate.c b/mm/migrate.c
index 365c6daa8d1b1..7d6472cc236ae 100644
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
index a2dc002a9c33d..e645bb0dd44b5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2925,8 +2925,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -2944,11 +2945,11 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
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
@@ -2968,10 +2969,12 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
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
index bdfede631aea9..21374892854eb 100644
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



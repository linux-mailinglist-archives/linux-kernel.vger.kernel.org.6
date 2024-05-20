Return-Path: <linux-kernel+bounces-183350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182F18C97DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394D61C21556
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33EA1F94C;
	Mon, 20 May 2024 02:18:03 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13F819BBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171483; cv=none; b=O5LSge4O8HQfc1xivsVjBeKzxWb65lmbaB6EKbFhjRiuw9QEdsrh8nNj9SU4xvWNMR3joHd3KylKPM2+83juTR8aeWPaLfWxoFn6CCmnqBRoc0b461nB9//aWWSZB4tGGJL11JkriFTJjxL1asf5YXkvdXiGDC2UuLRzhYUp/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171483; c=relaxed/simple;
	bh=a+6izv3w7GQSzyMYL9bIBmapH4TuRMbaTGJAg0oSBz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Msvi9lm4dYIAnMNYFC2k+haz5ciD9yNuXzu7o5oNU4bSLe6bkf+1a3Ghw/LaiYDqokVOESd1DByrV9g+cBKkn1X7X5gcsMlDO3m0R3uoxl+7KlLUWoo7Qe4FNqHku6y6aLBizd+BnLArtjmEBXLtMIGSdYmK6/c+tgKza9mK3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-cc-664ab2c941db
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
Subject: [RESEND PATCH v10 11/12] mm, migrate: apply luf mechanism to unmapping during migration
Date: Mon, 20 May 2024 11:17:33 +0900
Message-Id: <20240520021734.21527-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe7JTV5pBs/miVnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	t/susRQ0u1WsOr+YvYFxoUUXIyeHhICJxPI/e5lg7DmX9jCC2GwC6hI3bvxkBrFFBMwkDrb+
	YQexmQXuMkkc6GcDsYUFEiRebNwLVM/BwSKgKvHnViVImBeofOP1H2wQI+UlVm84ADaGEyg+
	Y9VOFhBbSMBU4sfRr0A1XEA1n9kkjs14DnWDpMTBFTdYJjDyLmBkWMUolJlXlpuYmWOil1GZ
	l1mhl5yfu4kRGPjLav9E72D8dCH4EKMAB6MSD++OR55pQqyJZcWVuYcYJTiYlUR4N20BCvGm
	JFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamCcL/tY8NmdXAfv
	13+Ob9ipebXn+sSpF7jXW+3U+d04oaF6al7F68d3cjzYFt522bOka8U5rYU8q8pf3RSaoVW2
	hX9lIUe/ifEfnw3Hu7onftL5d8L+/aLvS2vWL1nCff4+K8Pu3TaX4uP7ExfYXk9ZG9BjHnT9
	lg5rQkqO1ZWFQV/Pp/up31hmocRSnJFoqMVcVJwIAMFQjwF4AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrHtyk1eawaQ13BZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyni77xJLQbNbxarzi9kbGBdadDFyckgImEjMubSHEcRmE1CXuHHjJzOILSJg
	JnGw9Q87iM0scJdJ4kA/G4gtLJAg8WLjXqB6Dg4WAVWJP7cqQcK8QOUbr/9ggxgpL7F6wwGw
	MZxA8RmrdrKA2EICphI/jn5lm8DItYCRYRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgGC+r
	/TNxB+OXy+6HGAU4GJV4eDfc9kwTYk0sK67MPcQowcGsJMK7aQtQiDclsbIqtSg/vqg0J7X4
	EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgXGif6/1p/rYzTHfZn/d28hQ57fbMUh+
	PfNWr3eakZZfcm7dSO24Vj7fYf2yn3f/v2qWOe5ssbY0/OeJxpMC6+2mnIpMfhVxQX0O9wTm
	E7OeGpiozdgp+0Gqo2cGs+7TzXZ7W8rWV66cGud943ft/q1Cn9++lfW83aYyRXuf/8T43UeN
	IyQDV55UYinOSDTUYi4qTgQA9OaanF8CAAA=
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
 include/linux/rmap.h |  2 +-
 mm/migrate.c         | 56 ++++++++++++++++++++++++++++++++------------
 mm/rmap.c            |  9 ++++---
 3 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0f906dc6d280..1898a2c1c087 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -657,7 +657,7 @@ static inline int folio_try_share_anon_rmap_pmd(struct folio *folio,
 int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
-void try_to_migrate(struct folio *folio, enum ttu_flags flags);
+bool try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
 
 int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
diff --git a/mm/migrate.c b/mm/migrate.c
index f9ed7a2b8720..c8b0e5203e9a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1090,7 +1090,8 @@ static void migrate_folio_undo_dst(struct folio *dst, bool locked,
 
 /* Cleanup src folio upon migration success */
 static void migrate_folio_done(struct folio *src,
-			       enum migrate_reason reason)
+			       enum migrate_reason reason,
+			       unsigned short int ugen)
 {
 	/*
 	 * Compaction can migrate also non-LRU pages which are
@@ -1101,8 +1102,12 @@ static void migrate_folio_done(struct folio *src,
 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
 				    folio_is_file_lru(src), -folio_nr_pages(src));
 
-	if (reason != MR_MEMORY_FAILURE)
-		/* We release the page in page_handle_poison. */
+	/* We release the page in page_handle_poison. */
+	if (reason == MR_MEMORY_FAILURE)
+		check_luf_flush(ugen);
+	else if (ugen)
+		folio_put_ugen(src, ugen);
+	else
 		folio_put(src);
 }
 
@@ -1110,7 +1115,8 @@ static void migrate_folio_done(struct folio *src,
 static int migrate_folio_unmap(new_folio_t get_new_folio,
 		free_folio_t put_new_folio, unsigned long private,
 		struct folio *src, struct folio **dstp, enum migrate_mode mode,
-		enum migrate_reason reason, struct list_head *ret)
+		enum migrate_reason reason, struct list_head *ret,
+		bool *can_luf)
 {
 	struct folio *dst;
 	int rc = -EAGAIN;
@@ -1126,7 +1132,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_clear_unevictable(src);
 		/* free_pages_prepare() will clear PG_isolated. */
 		list_del(&src->lru);
-		migrate_folio_done(src, reason);
+		migrate_folio_done(src, reason, 0);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1244,7 +1250,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
+		*can_luf = try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
 		old_page_state |= PAGE_WAS_MAPPED;
 	}
 
@@ -1272,7 +1278,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 			      struct folio *src, struct folio *dst,
 			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
+			      struct list_head *ret, unsigned short int ugen)
 {
 	int rc;
 	int old_page_state = 0;
@@ -1326,7 +1332,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 	folio_unlock(src);
-	migrate_folio_done(src, reason);
+	migrate_folio_done(src, reason, ugen);
 
 	return rc;
 out:
@@ -1616,7 +1622,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 		struct list_head *ret_folios,
 		struct migrate_pages_stats *stats,
 		int *retry, int *thp_retry, int *nr_failed,
-		int *nr_retry_pages)
+		int *nr_retry_pages, unsigned short int ugen)
 {
 	struct folio *folio, *folio2, *dst, *dst2;
 	bool is_thp;
@@ -1633,7 +1639,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 
 		rc = migrate_folio_move(put_new_folio, private,
 				folio, dst, mode,
-				reason, ret_folios);
+				reason, ret_folios, ugen);
 		/*
 		 * The rules are:
 		 *	Success: folio will be freed
@@ -1710,7 +1716,11 @@ static int migrate_pages_batch(struct list_head *from,
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
+	LIST_HEAD(unmap_folios_luf);
+	LIST_HEAD(dst_folios_luf);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
+	unsigned short int ugen;
+	bool can_luf;
 
 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
 			!list_empty(from) && !list_is_singular(from));
@@ -1773,9 +1783,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1821,7 +1833,8 @@ static int migrate_pages_batch(struct list_head *from,
 				/* nr_failed isn't updated for not used */
 				stats->nr_thp_failed += thp_retry;
 				rc_saved = rc;
-				if (list_empty(&unmap_folios))
+				if (list_empty(&unmap_folios) &&
+				    list_empty(&unmap_folios_luf))
 					goto out;
 				else
 					goto move;
@@ -1835,8 +1848,13 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1856,6 +1874,8 @@ static int migrate_pages_batch(struct list_head *from,
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
+	/* Should be before try_to_unmap_flush() */
+	ugen = try_to_unmap_luf();
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
@@ -1869,7 +1889,11 @@ static int migrate_pages_batch(struct list_head *from,
 		migrate_folios_move(&unmap_folios, &dst_folios,
 				put_new_folio, private, mode, reason,
 				ret_folios, stats, &retry, &thp_retry,
-				&nr_failed, &nr_retry_pages);
+				&nr_failed, &nr_retry_pages, 0);
+		migrate_folios_move(&unmap_folios_luf, &dst_folios_luf,
+				put_new_folio, private, mode, reason,
+				ret_folios, stats, &retry, &thp_retry,
+				&nr_failed, &nr_retry_pages, ugen);
 	}
 	nr_failed += retry;
 	stats->nr_thp_failed += thp_retry;
@@ -1880,6 +1904,8 @@ static int migrate_pages_batch(struct list_head *from,
 	/* Cleanup remaining folios */
 	migrate_folios_undo(&unmap_folios, &dst_folios,
 			put_new_folio, private, ret_folios);
+	migrate_folios_undo(&unmap_folios_luf, &dst_folios_luf,
+			put_new_folio, private, ret_folios);
 
 	return rc;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index e42783c02114..d25ae20a47b5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2600,8 +2600,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -2620,11 +2621,11 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
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
@@ -2649,6 +2650,8 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 		fold_ubc(tlb_ubc_luf, tlb_ubc_ro);
 	else
 		fold_ubc(tlb_ubc, tlb_ubc_ro);
+
+	return can_luf;
 }
 
 #ifdef CONFIG_DEVICE_PRIVATE
-- 
2.17.1



Return-Path: <linux-kernel+bounces-196572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1AB8D5E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062AFB25E51
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F223152178;
	Fri, 31 May 2024 09:20:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3F1422BC
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147232; cv=none; b=YrlHmPvtPduNuiiueKNSJknIzYWIXwdSqYclGh3konhfAh+3XE/+IEmnljfL3tWly43MUOjzdSY2jza4HLQRxPJqYKTQHda7K12CrAduX/aswXF4ejoTPswJO2BLDRggl0UbM3kAMuRMBqyJFzdaiC/39LccwTQpcM1VjVA+j0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147232; c=relaxed/simple;
	bh=GzAf4Y90WeRo9D9nE172IAwb4UoA9BTM0Xvn2vhsks0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MRqxq1Eq0XQWbJqiEoYGXv9QXMGs5Bb3uLvVJQ5/mQSwAYyjo7HJAETlCVsw72G4B8Wh+7t0QEz6gySuC0vxIFCQQ+3/2nqkHN6ChIOJ1o+1sL7YluR7lK8YYgzWW2kAHsvnauwspCWL7IV+A29g/vTEvoXR8OmPLXIGAA8oiz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-76-6659964c68c9
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
Subject: [PATCH v11 11/12] mm, migrate: apply luf mechanism to unmapping during migration
Date: Fri, 31 May 2024 18:20:00 +0900
Message-Id: <20240531092001.30428-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnka7PtMg0g+dTVSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	ivkTWAqa3SqmnX3E2sC40KKLkZNDQsBE4uf/E4ww9pO+YywgNpuAusSNGz+ZQWwRATOJg61/
	2EFsZoG7TBIH+tm6GDk4hAUiJVb9SwMxWQRUJT53GoBU8AJVX23sY4WYKC+xesMBsCmcQPED
	f++AbRISMJVY9L8XyOYCqnnPJnHy3T42iAZJiYMrbrBMYORdwMiwilEoM68sNzEzx0QvozIv
	s0IvOT93EyMw7JfV/onewfjpQvAhRgEORiUe3oCKiDQh1sSy4srcQ4wSHMxKIry/0oFCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGK3/aSwp6u+uLisV
	Cd725dPDnmsmFcV87JOzbvk9DtLmvvd6eqv1/F3r9NQuxUz7sbU46YNKTG3WlaqseO6S5uk9
	dlOmMmWvbnjFuiyM5db9m3cZQnvWplt7PMwL+jMjt+N3zeplDpqeL64IPrt1MVC1WEQmNHHh
	nSuFx5inWuoemR6YdFH8mBJLcUaioRZzUXEiAOcOLfV3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrOszLTLNoPmlpMWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4MlbMn8BS0OxWMe3sI9YGxoUWXYycHBICJhJP+o6xgNhsAuoSN278ZAaxRQTM
	JA62/mEHsZkF7jJJHOhn62Lk4BAWiJRY9S8NxGQRUJX43GkAUsELVH21sY8VYqK8xOoNB8Cm
	cALFD/y9wwhiCwmYSiz638s4gZFrASPDKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMAgXlb7
	Z+IOxi+X3Q8xCnAwKvHwBlREpAmxJpYVV+YeYpTgYFYS4f2VDhTiTUmsrEotyo8vKs1JLT7E
	KM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgvDH3m6fsxadPdXK/X/Z2O8Z0kOHE/O6Z
	GtEfWWX/d7MUlVqvlY1/lPUuo1rhqF+PaMy2zODzFs/sfn6S3nbvEq/n3bki7ybZ/qkWlr2+
	kW8h8+QYv3ibgKDaurkKrd+59xww2tSUwf+24uyluA7zq0avffRPp3r+4J11ni8yaElWkZqE
	1O9zSizFGYmGWsxFxYkAOqgFhV4CAAA=
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
index bb53e5920b88..6aca569e342b 100644
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
index 6c22a1402923..6da8335cdf4c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1067,7 +1067,8 @@ static void migrate_folio_undo_dst(struct folio *dst, bool locked,
 
 /* Cleanup src folio upon migration success */
 static void migrate_folio_done(struct folio *src,
-			       enum migrate_reason reason)
+			       enum migrate_reason reason,
+			       unsigned short int ugen)
 {
 	/*
 	 * Compaction can migrate also non-LRU pages which are
@@ -1078,8 +1079,12 @@ static void migrate_folio_done(struct folio *src,
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
 
@@ -1087,7 +1092,8 @@ static void migrate_folio_done(struct folio *src,
 static int migrate_folio_unmap(new_folio_t get_new_folio,
 		free_folio_t put_new_folio, unsigned long private,
 		struct folio *src, struct folio **dstp, enum migrate_mode mode,
-		enum migrate_reason reason, struct list_head *ret)
+		enum migrate_reason reason, struct list_head *ret,
+		bool *can_luf)
 {
 	struct folio *dst;
 	int rc = -EAGAIN;
@@ -1103,7 +1109,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_clear_unevictable(src);
 		/* free_pages_prepare() will clear PG_isolated. */
 		list_del(&src->lru);
-		migrate_folio_done(src, reason);
+		migrate_folio_done(src, reason, 0);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1220,7 +1226,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
+		*can_luf = try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
 		old_page_state |= PAGE_WAS_MAPPED;
 	}
 
@@ -1248,7 +1254,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 			      struct folio *src, struct folio *dst,
 			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
+			      struct list_head *ret, unsigned short int ugen)
 {
 	int rc;
 	int old_page_state = 0;
@@ -1302,7 +1308,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 	folio_unlock(src);
-	migrate_folio_done(src, reason);
+	migrate_folio_done(src, reason, ugen);
 
 	return rc;
 out:
@@ -1591,7 +1597,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 		struct list_head *ret_folios,
 		struct migrate_pages_stats *stats,
 		int *retry, int *thp_retry, int *nr_failed,
-		int *nr_retry_pages)
+		int *nr_retry_pages, unsigned short int ugen)
 {
 	struct folio *folio, *folio2, *dst, *dst2;
 	bool is_thp;
@@ -1608,7 +1614,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 
 		rc = migrate_folio_move(put_new_folio, private,
 				folio, dst, mode,
-				reason, ret_folios);
+				reason, ret_folios, ugen);
 		/*
 		 * The rules are:
 		 *	Success: folio will be freed
@@ -1685,7 +1691,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1748,9 +1758,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1796,7 +1808,8 @@ static int migrate_pages_batch(struct list_head *from,
 				/* nr_failed isn't updated for not used */
 				stats->nr_thp_failed += thp_retry;
 				rc_saved = rc;
-				if (list_empty(&unmap_folios))
+				if (list_empty(&unmap_folios) &&
+				    list_empty(&unmap_folios_luf))
 					goto out;
 				else
 					goto move;
@@ -1810,8 +1823,13 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1831,6 +1849,8 @@ static int migrate_pages_batch(struct list_head *from,
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
+	/* Should be before try_to_unmap_flush() */
+	ugen = try_to_unmap_luf();
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
@@ -1844,7 +1864,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1855,6 +1879,8 @@ static int migrate_pages_batch(struct list_head *from,
 	/* Cleanup remaining folios */
 	migrate_folios_undo(&unmap_folios, &dst_folios,
 			put_new_folio, private, ret_folios);
+	migrate_folios_undo(&unmap_folios_luf, &dst_folios_luf,
+			put_new_folio, private, ret_folios);
 
 	return rc;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 459d4d1631f0..b8b977278a1b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2635,8 +2635,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -2655,11 +2656,11 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
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
@@ -2684,6 +2685,8 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 		fold_ubc(tlb_ubc_luf, tlb_ubc_ro);
 	else
 		fold_ubc(tlb_ubc, tlb_ubc_ro);
+
+	return can_luf;
 }
 
 #ifdef CONFIG_DEVICE_PRIVATE
-- 
2.17.1



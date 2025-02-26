Return-Path: <linux-kernel+bounces-533735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D53A45E27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134C53B12D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8EE223716;
	Wed, 26 Feb 2025 12:01:59 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7855221F21
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571318; cv=none; b=ercm7I8+mibe9yZSs+Bfm3dIRUon5AzTQyciEw5YpN++1Ej2HsTjHV9vblJsEXLAkMCXu4acMlJXFxphIJHcwUAvgG2pqjmz+qOAsA+BIUzExjAudE1k0QcjIR9FfTfPiRAS8qSMkiJl4c2w674iBaPIUenc1hKl1q901+4Pl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571318; c=relaxed/simple;
	bh=tkGWUuChjloLd4tRfjAJN6Xcp+jh+QNq1DBhzfMD3Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SpwM5e1wMmMnpeWE80rNp8yM35CrFqSlvx0vRgSJVtFt2RyTD0t5fQpOPCKwwsYj2IR1r1U+5e4Nlx/wU2wh3LOuw5xwiZFgtRE0TVMzPCUix8LtYLd9aouYiOGuVGQ94tjob6wmMPkUW14XFRJZcz4+gcYmTg3rv5DvthlwuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-3c-67bf02a74622
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 24/25]  mm/vmscan: apply luf mechanism to unmapping during folio reclaim
Date: Wed, 26 Feb 2025 21:01:31 +0900
Message-Id: <20250226120132.28469-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBtM+G1vMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8bxC6+YCs7pV5zqUG9gfKHWxcjJ
	ISFgIrH+2w9WGPvF9h9MIDabgLrEjRs/mUFsEQEziYOtf9i7GLk4mAWWMUnsPdHABuIIC3Qw
	SizecJ0dpIpFQFXi9KuHbCA2L1DH1v932SGmykus3nAAbBInUPzf7t9gcSGBZImW9b9ZQAZJ
	CNxmk3jybioLRIOkxMEVN1gmMPIuYGRYxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREY1stq/0Tv
	YPx0IfgQowAHoxIP74Mze9OFWBPLiitzDzFKcDArifByZu5JF+JNSaysSi3Kjy8qzUktPsQo
	zcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cDYtoa1uC3nse63A6XM6hs/dgTozZCy+bPt
	n6+4S6XQrKU82ztsilbc/tg9w/nq7aQDtsqx05iTlf4zqSyxm+be93jhr0+T3q3d0HshRNlW
	N2b52823fZ71zuZ7auMTs7Kzq+liYNHfgzJB3E8t97ltyVtZYceSab3wpndfz6veuPWffNkd
	1eYqsRRnJBpqMRcVJwIAJmWse2cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLucaX+6wa8N2hZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlHL/wiqngnH7F
	qQ71BsYXal2MnBwSAiYSL7b/YAKx2QTUJW7c+MkMYosImEkcbP3D3sXIxcEssIxJYu+JBjYQ
	R1igg1Fi8Ybr7CBVLAKqEqdfPWQDsXmBOrb+v8sOMVVeYvWGA2CTOIHi/3b/BosLCSRLtKz/
	zTKBkWsBI8MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwCBdVvtn4g7GL5fdDzEKcDAq8fA+
	OLM3XYg1say4MvcQowQHs5IIL2fmnnQh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJ
	JanZqakFqUUwWSYOTqkGxgvzY940GM4+l3F8vbCuUNxePsMZ+zgWff7YzPH1WIqDlfi155XT
	2nVWyU9d87zfZffk7dMO2L74mhlpvdHTr+XL/RW5PT+63mms6WgxW2gYWpLPpHiszVW2UZoh
	6ucCUbm7xhuuyFcdFFpw0snb0mvnheUn9iga7DTbxur8eAPDf2eTHeIxK5RYijMSDbWYi4oT
	AWF+U4dOAgAA
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

Applied the mechanism to unmapping during folio reclaim.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/rmap.h |  5 +++--
 mm/rmap.c            | 11 +++++++----
 mm/vmscan.c          | 37 ++++++++++++++++++++++++++++++++-----
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index bfccf2efb9000..8002f4b2a2d14 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -676,7 +676,7 @@ int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
 bool try_to_migrate(struct folio *folio, enum ttu_flags flags);
-void try_to_unmap(struct folio *, enum ttu_flags flags);
+bool try_to_unmap(struct folio *, enum ttu_flags flags);
 
 struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 		void *owner, struct folio **foliop);
@@ -811,8 +811,9 @@ static inline int folio_referenced(struct folio *folio, int is_locked,
 	return 0;
 }
 
-static inline void try_to_unmap(struct folio *folio, enum ttu_flags flags)
+static inline bool try_to_unmap(struct folio *folio, enum ttu_flags flags)
 {
+	return false;
 }
 
 static inline int folio_mkclean(struct folio *folio)
diff --git a/mm/rmap.c b/mm/rmap.c
index e645bb0dd44b5..124ef59afa25e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2583,10 +2583,11 @@ static int folio_not_mapped(struct folio *folio)
  * Tries to remove all the page table entries which are mapping this
  * folio.  It is the caller's responsibility to check if the folio is
  * still mapped if needed (use TTU_SYNC to prevent accounting races).
+ * Return true if all the mappings are read-only, otherwise false.
  *
  * Context: Caller must hold the folio lock.
  */
-void try_to_unmap(struct folio *folio, enum ttu_flags flags)
+bool try_to_unmap(struct folio *folio, enum ttu_flags flags)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_unmap_one,
@@ -2605,10 +2606,12 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
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
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f145c09629b97..a24d2d05df43a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1102,14 +1102,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		struct reclaim_stat *stat, bool ignore_references)
 {
 	struct folio_batch free_folios;
+	struct folio_batch free_folios_luf;
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(demote_folios);
 	unsigned int nr_reclaimed = 0, nr_demoted = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
 	struct swap_iocb *plug = NULL;
+	unsigned short luf_key;
 
 	folio_batch_init(&free_folios);
+	folio_batch_init(&free_folios_luf);
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
 	do_demote_pass = can_demote(pgdat->node_id, sc);
@@ -1121,6 +1124,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		bool can_luf = false;
 
 		cond_resched();
 
@@ -1354,7 +1358,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			if (folio_test_large(folio))
 				flags |= TTU_SYNC;
 
-			try_to_unmap(folio, flags);
+			can_luf = try_to_unmap(folio, flags);
 			if (folio_mapped(folio)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked &&
@@ -1498,6 +1502,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					 * leave it off the LRU).
 					 */
 					nr_reclaimed += nr_pages;
+					if (can_luf)
+						luf_flush(fold_unmap_luf());
 					continue;
 				}
 			}
@@ -1530,6 +1536,19 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		nr_reclaimed += nr_pages;
 
 		folio_unqueue_deferred_split(folio);
+
+		if (can_luf) {
+			if (folio_batch_add(&free_folios_luf, folio) == 0) {
+				mem_cgroup_uncharge_folios(&free_folios);
+				mem_cgroup_uncharge_folios(&free_folios_luf);
+				luf_key = fold_unmap_luf();
+				try_to_unmap_flush();
+				free_unref_folios(&free_folios, 0);
+				free_unref_folios(&free_folios_luf, luf_key);
+			}
+			continue;
+		}
+
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
@@ -1564,9 +1583,21 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		list_add(&folio->lru, &ret_folios);
 		VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
 				folio_test_unevictable(folio), folio);
+		if (can_luf)
+			luf_flush(fold_unmap_luf());
 	}
 	/* 'folio_list' is always empty here */
 
+	/*
+	 * Finalize this turn before demote_folio_list().
+	 */
+	mem_cgroup_uncharge_folios(&free_folios);
+	mem_cgroup_uncharge_folios(&free_folios_luf);
+	luf_key = fold_unmap_luf();
+	try_to_unmap_flush();
+	free_unref_folios(&free_folios, 0);
+	free_unref_folios(&free_folios_luf, luf_key);
+
 	/* Migrate folios selected for demotion */
 	nr_demoted = demote_folio_list(&demote_folios, pgdat);
 	nr_reclaimed += nr_demoted;
@@ -1600,10 +1631,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
 
-	mem_cgroup_uncharge_folios(&free_folios);
-	try_to_unmap_flush();
-	free_unref_folios(&free_folios, 0);
-
 	list_splice(&ret_folios, folio_list);
 	count_vm_events(PGACTIVATE, pgactivate);
 
-- 
2.17.1



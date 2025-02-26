Return-Path: <linux-kernel+bounces-533761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3231A45E44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B66189DD45
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C922DFAC;
	Wed, 26 Feb 2025 12:04:02 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1118922A4EC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571442; cv=none; b=KWWdSv3sIqh9Ludx2vdjUnzgf3dhFmDwb7PjXQ2GRBZ93hIQ0x1UmVQpXilMkc81sdjxbQtRWuRNeDscXM2t1LyO/H2UZ0jbGWkYY+JTOq1MrteWR5Ak+oa949KVfXqi0g3yGqEuKYVw8eDt+aJFyW+OKg8bt7wIyp/acNYcvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571442; c=relaxed/simple;
	bh=u+FnsDkL7CE8oSHJ+f4cRGS8tMOkPxkaXe3H1qSNSGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rsNsqM2QFSuTrVFBYOTR9li8C4x+d8oSw54PSQcSF1AnGmNLnF7iGZViVgjDCYwe7iZtIqLEvKqGDmLDewWBPFgvGiDpZltXVoriUght28iYRdPFLzKuO6j36VkCNitZMctYuAiX43fnZr76HirHqe76hnlKmCBpJlQFP4/iNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-6b-67bf03231e30
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
Subject: [RFC PATCH v12 based on v6.14-rc4 24/25] mm/vmscan: apply luf mechanism to unmapping during folio reclaim
Date: Wed, 26 Feb 2025 21:03:35 +0900
Message-Id: <20250226120336.29565-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsXC9ZZnoa4y8/50gy8TFCzmrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2PGkeiCi/oVfw7uZWxgfKnWxcjB
	ISFgIrHyuGoXIyeYObP3PxuIzSagLnHjxk9mEFtEwEziYOsf9i5GLg5mgWVMEntPNIAVCQsU
	Scw7tAysiEVAVaJ/xX0WkJm8QA0XbltDzJSXWL3hAFgJJ1D407RjYK1CAskSO3//YYKouc0m
	cfKOH4QtKXFwxQ2WCYy8CxgZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIEhvOy2j/ROxg/XQg+
	xCjAwajEw/vgzN50IdbEsuLK3EOMEhzMSiK8nJl70oV4UxIrq1KL8uOLSnNSiw8xSnOwKInz
	Gn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwlnBuvvlQl/FCLrPVDpXC9z/8t5VH3yzl9rogreWy
	a+ufdPXahAVnvPbs+vvh3AK7a+ULnycdZVYTD5ee1M1nax71c8EX/sVtZckuuUIegp1fjdp+
	fOgRSuGKmZrUyhzGIXh+Z1VMS8r3pPxO5Rtzve1fzd3Gk+Sw+1/VSVE+39Pnl+w/tfqfEktx
	RqKhFnNRcSIAU/DYKmMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsXC5WfdrKvMvD/d4Mh0cYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyZhyJLrioX/Hn
	4F7GBsaXal2MnBwSAiYSM3v/s4HYbALqEjdu/GQGsUUEzCQOtv5h72Lk4mAWWMYksfdEA1iR
	sECRxLxDy8CKWARUJfpX3GfpYuTg4AVquHDbGmKmvMTqDQfASjiBwp+mHQNrFRJIltj5+w/T
	BEauBYwMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQIDdFntn4k7GL9cdj/EKMDBqMTD++DM
	3nQh1sSy4srcQ4wSHMxKIrycmXvShXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5ak
	ZqemFqQWwWSZODilGhiLZwdfDuLnLb1rvft3XuJ+b+ktxnnHWh5OXZt8JmfBwTzfxHMnq94d
	vii+K2bBlPN9F5Zfk1I1eHDBb6WdHlut2LKCqhcdDIzOt2f8uXPrk9J6rdcvpY0jr0+RjrF+
	lxsukePCrdScYvJhQgjn3tAy8flWSxxf5HtHX16ocnDSMq2Fgv83V/sosRRnJBpqMRcVJwIA
	9alR/EwCAAA=
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
index cedba4812ccc7..854b41441d466 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -661,7 +661,7 @@ int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
 bool try_to_migrate(struct folio *folio, enum ttu_flags flags);
-void try_to_unmap(struct folio *, enum ttu_flags flags);
+bool try_to_unmap(struct folio *, enum ttu_flags flags);
 
 int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, struct page **pages,
@@ -794,8 +794,9 @@ static inline int folio_referenced(struct folio *folio, int is_locked,
 	return 0;
 }
 
-static inline void try_to_unmap(struct folio *folio, enum ttu_flags flags)
+static inline bool try_to_unmap(struct folio *folio, enum ttu_flags flags)
 {
+	return false;
 }
 
 static inline int folio_mkclean(struct folio *folio)
diff --git a/mm/rmap.c b/mm/rmap.c
index 284fc48aef2de..df350b4dfddd0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2386,10 +2386,11 @@ static int folio_not_mapped(struct folio *folio)
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
@@ -2408,10 +2409,12 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
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
index a31a7cf87315f..065b40f36bbdd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1092,14 +1092,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
@@ -1111,6 +1114,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		bool can_luf = false;
 
 		cond_resched();
 
@@ -1344,7 +1348,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			if (folio_test_large(folio))
 				flags |= TTU_SYNC;
 
-			try_to_unmap(folio, flags);
+			can_luf = try_to_unmap(folio, flags);
 			if (folio_mapped(folio)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked &&
@@ -1488,6 +1492,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					 * leave it off the LRU).
 					 */
 					nr_reclaimed += nr_pages;
+					if (can_luf)
+						luf_flush(fold_unmap_luf());
 					continue;
 				}
 			}
@@ -1520,6 +1526,19 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
@@ -1554,9 +1573,21 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
@@ -1590,10 +1621,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
 
-	mem_cgroup_uncharge_folios(&free_folios);
-	try_to_unmap_flush();
-	free_unref_folios(&free_folios, 0);
-
 	list_splice(&ret_folios, folio_list);
 	count_vm_events(PGACTIVATE, pgactivate);
 
-- 
2.17.1



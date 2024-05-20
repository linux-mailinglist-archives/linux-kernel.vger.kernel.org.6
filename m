Return-Path: <linux-kernel+bounces-183351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D48C97DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1409C1F21F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF6208A5;
	Mon, 20 May 2024 02:18:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51E1BDDB
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171483; cv=none; b=PyeeT1WjBJcuLfa6fl92JWacqXqLBAFaLB8RJKOtAD4FGwpZB9BvanTlinFe9hepKVRarSqn6zjZmdAQcX2HOiTsLMD8YZxVmSIyY27vpXsFF3VGMYH1Qz77LPinyoiOaPadsphdLQH0p7bHZT4I/NLG/T+o3sqE3W2gy+jYXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171483; c=relaxed/simple;
	bh=xHQ+I0rvQ/aXac1SAUEKaqX98bcd3OelkmI2+09FF90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ox9teEBr7y/evyvojyT/OckDbj5NLwePgFgvudYvVlaB9jzwnBdRt6UNdb1MJtuOiPplwxIVdbL0HzkfM04d24XBf5KWjWKzl/xTuoidPzBF8h6B/h8zg0euXFTdsRusWBgWmPNsJ0SDFbyFfHmVtJGiU9klGH0wdze42derReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-d1-664ab2c9763c
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
Subject: [RESEND PATCH v10 12/12] mm, vmscan: apply luf mechanism to unmapping during folio reclaim
Date: Mon, 20 May 2024 11:17:34 +0900
Message-Id: <20240520021734.21527-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke7JTV5pBm9mi1vMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	ub83MRX8V6t4tvQrUwPjV/kuRk4OCQETieXrW5hh7P557xlBbDYBdYkbN36CxUUEzCQOtv5h
	B7GZBe4ySRzoZwOxhQWSJfp/PAWLswioSrz8+Busnheofvn2z0wQM+UlVm84ABbnBIrPWLWT
	BcQWEjCV+HH0K9AcLqCa92wSn9oXMkI0SEocXHGDZQIj7wJGhlWMQpl5ZbmJmTkmehmVeZkV
	esn5uZsYgaG/rPZP9A7GTxeCDzEKcDAq8fDueOSZJsSaWFZcmXuIUYKDWUmEd9MWoBBvSmJl
	VWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZGpQVfFrHfkz+fMuvW
	locZB/dOnnk/y/nFP+1Pgbr/ZhfEdUjv5wzXur/2ioienMUUN9dz3T4dC0tYRF2t1u74Wmir
	ZSg0eXnrmm9nJs/ctD34oEnNaa4pb/aH3RCeOI0/W+2d2+mkq57lR89Eib99uo5z2ifjSIY9
	O5oXzdWaIpJrM/eehJrFMSWW4oxEQy3mouJEAGOoIUV5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrHtyk1eawcNPvBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgypj7exNTwX+1imdLvzI1MH6V72Lk5JAQMJHon/eeEcRmE1CXuHHjJzOILSJg
	JnGw9Q87iM0scJdJ4kA/G4gtLJAs0f/jKVicRUBV4uXH32D1vED1y7d/ZoKYKS+xesMBsDgn
	UHzGqp0sILaQgKnEj6Nf2SYwci1gZFjFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGMjLav9M
	3MH45bL7IUYBDkYlHt4Ntz3ThFgTy4orcw8xSnAwK4nwbtoCFOJNSaysSi3Kjy8qzUktPsQo
	zcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamA8qquh/+/PghOfblkJyjay72M1Wjjt0sxl
	1W3rfKbYPTM/4phe1mSjvpDpwqNzagfeuCTouZdqfnyo8rLhyqvVtc94tl5vczrONO3mq65r
	rqte5G/iqXmcXR5da8xWKXV607z8q98OS3C+7K/+6Fu2q5dBqvV4MZPjX9XE+n3c4htc7wp8
	yf6kxFKckWioxVxUnAgAxnKitWACAAA=
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
 mm/rmap.c            |  5 ++++-
 mm/vmscan.c          | 21 ++++++++++++++++++++-
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 1898a2c1c087..9ca752f8de97 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -658,7 +658,7 @@ int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
 bool try_to_migrate(struct folio *folio, enum ttu_flags flags);
-void try_to_unmap(struct folio *, enum ttu_flags flags);
+bool try_to_unmap(struct folio *, enum ttu_flags flags);
 
 int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, struct page **pages,
@@ -777,8 +777,9 @@ static inline int folio_referenced(struct folio *folio, int is_locked,
 	return 0;
 }
 
-static inline void try_to_unmap(struct folio *folio, enum ttu_flags flags)
+static inline bool try_to_unmap(struct folio *folio, enum ttu_flags flags)
 {
+	return false;
 }
 
 static inline int folio_mkclean(struct folio *folio)
diff --git a/mm/rmap.c b/mm/rmap.c
index d25ae20a47b5..571e337af448 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2237,10 +2237,11 @@ static int folio_not_mapped(struct folio *folio)
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
@@ -2265,6 +2266,8 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 		fold_ubc(tlb_ubc_luf, tlb_ubc_ro);
 	else
 		fold_ubc(tlb_ubc, tlb_ubc_ro);
+
+	return can_luf;
 }
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bb0ff11f9ec9..4e2e9d07cd96 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1031,14 +1031,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		struct reclaim_stat *stat, bool ignore_references)
 {
 	struct folio_batch free_folios;
+	struct folio_batch free_folios_luf;
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(demote_folios);
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
 	struct swap_iocb *plug = NULL;
+	unsigned short int ugen;
 
 	folio_batch_init(&free_folios);
+	folio_batch_init(&free_folios_luf);
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
 	do_demote_pass = can_demote(pgdat->node_id, sc);
@@ -1050,6 +1053,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		bool can_luf = false;
 
 		cond_resched();
 
@@ -1292,7 +1296,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
 				flags |= TTU_SYNC;
 
-			try_to_unmap(folio, flags);
+			can_luf = try_to_unmap(folio, flags);
 			if (folio_mapped(folio)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked &&
@@ -1457,6 +1461,18 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (folio_test_large(folio) &&
 		    folio_test_large_rmappable(folio))
 			folio_undo_large_rmappable(folio);
+
+		if (can_luf) {
+			if (folio_batch_add(&free_folios_luf, folio) == 0) {
+				mem_cgroup_uncharge_folios(&free_folios_luf);
+				ugen = try_to_unmap_luf();
+				if (!ugen)
+					try_to_unmap_flush();
+				free_unref_folios(&free_folios_luf, ugen);
+			}
+			continue;
+		}
+
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
@@ -1526,8 +1542,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
 
 	mem_cgroup_uncharge_folios(&free_folios);
+	mem_cgroup_uncharge_folios(&free_folios_luf);
+	ugen = try_to_unmap_luf();
 	try_to_unmap_flush();
 	free_unref_folios(&free_folios, 0);
+	free_unref_folios(&free_folios_luf, ugen);
 
 	list_splice(&ret_folios, folio_list);
 	count_vm_events(PGACTIVATE, pgactivate);
-- 
2.17.1



Return-Path: <linux-kernel+bounces-175361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A18C1E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDBB1C21F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C86168B15;
	Fri, 10 May 2024 06:52:39 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA3165FA9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323959; cv=none; b=HNRZuInFe7llZVzXMEALe4BZK5HJ1meTBjeBJ5sHobkRG0PWPqBok4J81P9lmZ7sEKVMW6x2MFjTrpdCdvAbUeB6B7COHIh9ccPwGAfn3AZj55LGV9eJuQKdboCQnrZQobabFz7Qxuw2sYWYmEQDzq6clgTGGnpRxmc/+Vjw+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323959; c=relaxed/simple;
	bh=xHQ+I0rvQ/aXac1SAUEKaqX98bcd3OelkmI2+09FF90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Dh0YOGBCRmUL2v4UFpKXXtxHBsHmmDMTSVKxdZj93cwFC1AmqoQrYIKXgbKDQmQue0cVX6Wm46vGs5Do6f61XFf0r65WMRu77Wf4OSbkzZhs/58siFTTkHdU9BJTCfZixKzlp3LEZ5nxB8PN95bU59kkb4V3K1ntTjDKl817SDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-fb-663dc4212e01
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
Subject: [PATCH v10 12/12] mm, vmscan: apply luf mechanism to unmapping during folio reclaim
Date: Fri, 10 May 2024 15:52:06 +0900
Message-Id: <20240510065206.76078-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
References: <20240510065206.76078-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoa7iEds0gz/dVhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugStj
	7u9NTAX/1SqeLf3K1MD4Vb6LkZNDQsBE4vnS2eww9sLdK1lBbDYBdYkbN34yg9giAmYSB1v/
	gNUwC9xlkjjQz9bFyMEhLBAjcWO3A0iYRUBV4n/XTbBWXqDy/dPnsECMlJdYveEA2BhOoPiH
	ZTOYQGwhAVOJjgcTGbsYuYBqPrNJzJ+2ngmiQVLi4IobLBMYeRcwMqxiFMrMK8tNzMwx0cuo
	zMus0EvOz93ECAz8ZbV/oncwfroQfIhRgINRiYd3x2abNCHWxLLiytxDjBIczEoivFU11mlC
	vCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGHNYt97wlz75
	cObhK/+vfDzAx962eZ19e3V/RyKD9l6mu/+L5da5Rmeytjt5VBmv0w09Y5HnNr0k0Log9P2u
	mGn23WZPNLVe5PSKJrw6ctZq0cw/eq2c1j+XLIszkgqISTxlpOU1MUpopcfSBbJacnMEM5Jn
	dqaeS+pXSfv8nv/51kUe9n8NlFiKMxINtZiLihMBg1oHsXgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKt4xDbNYMo/PYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZcz9vYmp4L9axbOlX5kaGL/KdzFyckgImEgs3L2SFcRmE1CXuHHjJzOILSJg
	JnGw9Q87iM0scJdJ4kA/WxcjB4ewQIzEjd0OIGEWAVWJ/103wVp5gcr3T5/DAjFSXmL1hgNg
	YziB4h+WzWACsYUETCU6HkxknMDItYCRYRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgGC+r
	/TNxB+OXy+6HGAU4GJV4eHdstkkTYk0sK67MPcQowcGsJMJbVWOdJsSbklhZlVqUH19UmpNa
	fIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cBY/mprpuqtSdfUXY3+uu6Wjvz1+OpH
	tpWHpm3eO+3KRPn9/YvSLjeu7L0bfzaOp0qSzXb3kz2rnSRUik6nTD6zWcZyyp79mqy7dl4y
	iJ+o/q+9JzGowfXhToXL32/Iq7w0fl5o7idRpLGK/X1n+Y/iy6ar7v+qLli89/GOhfUHO4RE
	NdsFTd96K7EUZyQaajEXFScCAKtg/rVfAgAA
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



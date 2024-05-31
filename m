Return-Path: <linux-kernel+bounces-196574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5558D5E20
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA1B21CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F06680BE5;
	Fri, 31 May 2024 09:20:34 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2251420A8
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147233; cv=none; b=K5bUleuUK+WH+PBor5GXjsMlKwASCNczPQ8Gxtd7L4Igw9iFJNcUS5J6Bcxl1I0Obrx8RBt4+CFmprJPaK9WY+CHL44OYMhr7SB31LAWVnnu8vd0//0s60edAmBnPX0iRsNtZRu6RR+S8Oo3F0Nq3krIv/QB1RgIgFbDQcCImIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147233; c=relaxed/simple;
	bh=2qGNSW3KdM44HWff9yLzL1bREhePCprdjakSuzSQq5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JxmpmLjgRYsP+9cqt9o2B2k6MUwM18ScrOGF9KfwwhSwdP2Z0oIay1rYtqIhG/aW5gKf433FbPbHF4YT8RcFMRsR3HaZwQo5JQs5WvITQBbwkpR8ivCkX2VbSgJiTZG1x8WK4r0QJ1ETESXiye1gLxWHf8BSsShTllYk3ebz8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7b-6659964cd3e1
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
Subject: [PATCH v11 12/12] mm, vmscan: apply luf mechanism to unmapping during folio reclaim
Date: Fri, 31 May 2024 18:20:01 +0900
Message-Id: <20240531092001.30428-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnka7PtMg0g8Pr1SzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	jFdXGQsuqlVs/zeDrYHxnHwXIweHhICJxLoXcV2MnGDmjqe72UFsNgF1iRs3fjKD2CICZhIH
	W/+AxZkF7jJJHOhnA2kVFoiRmNsGFmYRUJX4faaBFcTmBSo/vfcYO8RIeYnVGw6AjeEEih/4
	e4cRxBYSMJVY9L8XyOYCqnnPJrHn30w2iAZJiYMrbrBMYORdwMiwilEoM68sNzEzx0QvozIv
	s0IvOT93EyMw7JfV/onewfjpQvAhRgEORiUe3oCKiDQh1sSy4srcQ4wSHMxKIry/0oFCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGKNeWKy/Om+nn+ID
	R8GFHXlp5xU9TapyL8XUhD2MPqIk2pm32WkpY4tW2cqAk2cW3z9vccEkMnFOQtMdvp7+gNIA
	o241mX+ck0JeHQnyPr1YPz9D7rjz7hYJkQVtYm+33pz8a0LTRtnwN835gj/CA1/Fe/7U2cC3
	+8GN5xltyeonBcTObL1dqMRSnJFoqMVcVJwIAK+DkQR3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrOszLTLN4MBGGYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZcx4dZWx4KJaxfZ/M9gaGM/JdzFyckgImEjseLqbHcRmE1CXuHHjJzOILSJg
	JnGw9Q9YnFngLpPEgX62LkYODmGBGIm5bWBhFgFVid9nGlhBbF6g8tN7j7FDjJSXWL3hANgY
	TqD4gb93GEFsIQFTiUX/exknMHItYGRYxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERjGy2r/
	TNzB+OWy+yFGAQ5GJR7egIqINCHWxLLiytxDjBIczEoivL/SgUK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MzfbJLtFvJyd0h0l0NtYEFppJFzVEpM+Z
	ebh1xv/4+ZLy6anXpFgTEn5etXazS5Pk2RGS8GwJ5/J6LYVn14t48s7aRk9nmGXnecXAfonp
	bmuNBXec3xpVvmJi8tFbyVGlqCLU/j/3OOPyg+zP5YROX3INunbiWJb0jbcH83MTK2zEH978
	HK3EUpyRaKjFXFScCAARIRXIXwIAAA==
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
index 6aca569e342b..9f3e66239f0a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -661,7 +661,7 @@ int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
 bool try_to_migrate(struct folio *folio, enum ttu_flags flags);
-void try_to_unmap(struct folio *, enum ttu_flags flags);
+bool try_to_unmap(struct folio *, enum ttu_flags flags);
 
 int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, struct page **pages,
@@ -770,8 +770,9 @@ static inline int folio_referenced(struct folio *folio, int is_locked,
 	return 0;
 }
 
-static inline void try_to_unmap(struct folio *folio, enum ttu_flags flags)
+static inline bool try_to_unmap(struct folio *folio, enum ttu_flags flags)
 {
+	return false;
 }
 
 static inline int folio_mkclean(struct folio *folio)
diff --git a/mm/rmap.c b/mm/rmap.c
index b8b977278a1b..6f90c2adc4ae 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2272,10 +2272,11 @@ static int folio_not_mapped(struct folio *folio)
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
@@ -2300,6 +2301,8 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 		fold_ubc(tlb_ubc_luf, tlb_ubc_ro);
 	else
 		fold_ubc(tlb_ubc, tlb_ubc_ro);
+
+	return can_luf;
 }
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 15efe6f0edce..d52a6e605183 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1034,14 +1034,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
@@ -1053,6 +1056,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		bool can_luf = false;
 
 		cond_resched();
 
@@ -1295,7 +1299,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
 				flags |= TTU_SYNC;
 
-			try_to_unmap(folio, flags);
+			can_luf = try_to_unmap(folio, flags);
 			if (folio_mapped(folio)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked &&
@@ -1458,6 +1462,18 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		nr_reclaimed += nr_pages;
 
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
@@ -1527,8 +1543,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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



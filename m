Return-Path: <linux-kernel+bounces-523005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99C2A3D0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85C93A629F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0911EEA43;
	Thu, 20 Feb 2025 05:36:15 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442781EB9ED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029773; cv=none; b=HkRkA+LS0iQShT1DYSXwF1BklH5yVlHzPzeHKzNtpRQ8WP0blyAz1P4t1M4DHDvZf+pFAghRGmJe37GV83jK8HnjgiSEKg+dFJyhvzPh73ImHUHAkzZovdiwOpgncopD4tmtUDP4cxVC2D7IqoRNrR1KpG3fCtm0gud/ZVjVOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029773; c=relaxed/simple;
	bh=R/34JHDbuoMfx94XJV9RCFhRV7+t316aSkMsBuloTdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gVZQKRGFay2LYKxHNFGeNyFAyUCkXPp9EvU+VUN2X6BJyXHnn7oI6VY8t8sC9Lf5I46l9wixCNv4rMxptTWMseKBTdmJ5plwlZVufpWmURt69bZiTw5wgI7f7q3VQGfekuW9ItbiNypUAKOs5D0TEGS7fDts2Si2qvjx4sHzv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-2c-67b6bba7d1ea
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
Subject: [RFC PATCH v12 25/26] mm/vmscan: apply luf mechanism to unmapping during folio reclaim
Date: Thu, 20 Feb 2025 14:20:26 +0900
Message-Id: <20250220052027.58847-26-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe7y3dvSDfYsVbGYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	u9doF5zVr7i1YCZzA+MLtS5GTg4JAROJaw8OscLYD4/+ZQGx2QTUJW7c+MkMYosImEkcbP3D
	DmIzC9xlkjjQzwZiCwvESxz5dgOshkVAVWLb+gVgNbxA9aeu34eaKS+xesMBsBpOoPiPGb1g
	vUICphLvFlxi6mLkAqp5zyaxZe9ydogGSYmDK26wTGDkXcDIsIpRKDOvLDcxM8dEL6MyL7NC
	Lzk/dxMjMPCX1f6J3sH46ULwIUYBDkYlHt4ZrdvShVgTy4orcw8xSnAwK4nwttVvSRfiTUms
	rEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAyFX5TjnlXPL5P/Ut
	60vypuxwao5Wehad11vRnWXHJdyptnizjfrGEvOZZ7hamJb0Wd1nmXTRWL+74uDx7tT9RwTn
	cIo6PFWVX2fEoqv9UHM7s0unQPIx3cWHVPUDDvxRq92nJ3IxQI/hydNE05/7t+XbTUwT41rh
	9LVthuqtos81brffbdRSYinOSDTUYi4qTgQAC5qRB3gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrLt897Z0g3kvpSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlbF7jXbBWf2KWwtmMjcwvlDrYuTkkBAwkXh49C8LiM0moC5x48ZPZhBbRMBM
	4mDrH3YQm1ngLpPEgX42EFtYIF7iyLcbYDUsAqoS29YvAKvhBao/df0+K8RMeYnVGw6A1XAC
	xX/M6AXrFRIwlXi34BLTBEauBYwMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQLDeFntn4k7
	GL9cdj/EKMDBqMTD++Dx1nQh1sSy4srcQ4wSHMxKIrxt9VvShXhTEiurUovy44tKc1KLDzFK
	c7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhjvrs+bpHgq486nzRm/9aO03u18/FdCTu2P
	qvi/uDmye99Zcy5sL809s/uc0j5JabWXBrMPn1xhqeK30fDMrHdr7sk5z2M38da4Xlt49vq3
	P6yzjN0CDu/iq5HYu/Oc7MSWT0e+d6zaXiZxc/3816fuHvNY+qTqEOeelW3mTEstnMRfZUU1
	rzg4SYmlOCPRUIu5qDgRAMF1a/tfAgAA
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
index b6b61b8103655..55003eb0b4936 100644
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
index cbca027d2a10e..1ece0ccfccefb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1052,14 +1052,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
+	unsigned short luf_key;
 
 	folio_batch_init(&free_folios);
+	folio_batch_init(&free_folios_luf);
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
 	do_demote_pass = can_demote(pgdat->node_id, sc);
@@ -1071,6 +1074,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		bool can_luf = false;
 
 		cond_resched();
 
@@ -1309,7 +1313,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			if (folio_test_large(folio))
 				flags |= TTU_SYNC;
 
-			try_to_unmap(folio, flags);
+			can_luf = try_to_unmap(folio, flags);
 			if (folio_mapped(folio)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked &&
@@ -1453,6 +1457,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					 * leave it off the LRU).
 					 */
 					nr_reclaimed += nr_pages;
+					if (can_luf)
+						luf_flush(fold_unmap_luf());
 					continue;
 				}
 			}
@@ -1485,6 +1491,19 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
@@ -1519,9 +1538,21 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
 	stat->nr_demoted = demote_folio_list(&demote_folios, pgdat);
 	nr_reclaimed += stat->nr_demoted;
@@ -1554,10 +1585,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
 
-	mem_cgroup_uncharge_folios(&free_folios);
-	try_to_unmap_flush();
-	free_unref_folios(&free_folios, 0);
-
 	list_splice(&ret_folios, folio_list);
 	count_vm_events(PGACTIVATE, pgactivate);
 
-- 
2.17.1



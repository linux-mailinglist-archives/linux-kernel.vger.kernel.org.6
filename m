Return-Path: <linux-kernel+bounces-436991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAF9E8DBC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422D7161D48
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3367215703;
	Mon,  9 Dec 2024 08:46:22 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E291EB3D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733982; cv=none; b=qioQNT5v0AjiR71cQVVbf1mEbu+u8p4+bgZoy/KDwJWtFbQ0f1+5hq/zaNMhYzdowHi87tME4dAtkW6A/C+2DKKyyAgDX4lPRssKO0Brc5dpJVr8meBvkGcLcne6jIyxeIXe2HnT/QntkgxscfOrstzGW4RvJTpUM80fQIV6Cnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733982; c=relaxed/simple;
	bh=gPlR3uToWK/TaVjyZPDvmRpre4m+8uxkdiE9gRjRAP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOqk4SpCPIfYkZz1jyfUfr0RN7+CH3joATWVhmg2OpYiXel/beCCuFaW5/Zu5b2BBlwAi+CoM4GgvjtlLIpZGk51YRTRybWLuO+KBfR7UyS1mMvlPqS/8pZQUGPP+XTXnj7qeJ6P1+bwAqJKzwAT3Qn9H8bpoDr4AlDlMMvA0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y6FnW6HFcz4f3jsY
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:45:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 06EE31A018C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:46:11 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgAX8oVArlZn1gthEA--.6675S3;
	Mon, 09 Dec 2024 16:46:10 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	david@redhat.com,
	willy@infradead.org,
	ryan.roberts@arm.com,
	baohua@kernel.org,
	21cnbao@gmail.com,
	wangkefeng.wang@huawei.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com,
	xieym_ict@hotmail.com
Subject: [PATCH v4 1/1] mm: vmascan: retry folios written back while isolated for traditional LRU
Date: Mon,  9 Dec 2024 08:36:18 +0000
Message-Id: <20241209083618.2889145-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209083618.2889145-1-chenridong@huaweicloud.com>
References: <20241209083618.2889145-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAX8oVArlZn1gthEA--.6675S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DWFWfur4UAFyxXr4rAFb_yoWxKr1fpF
	Z8Krnrta18AryfKrsxXF1Uur1akas8Wr4UJFy2kr42yF1Yqw4YgFyIk345tF43WrWkZFyS
	qa12gFyUXa1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written back
while isolated") only fixed the issue for mglru. However, this issue
also exists in the traditional active/inactive LRU. This issue will be
worse if THP is split, which makes the list longer and needs longer time
to finish a batch of folios reclaim.

This issue should be fixed in the same way for the traditional LRU.
Therefore, the common logic was extracted to the 'find_folios_written_back'
function firstly, which is then reused in the 'shrink_inactive_list'
function. Finally, retry reclaiming those folios that may have missed the
rotation for traditional LRU.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/mmzone.h |   3 +-
 mm/vmscan.c            | 108 +++++++++++++++++++++++++++++------------
 2 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b36124145a16..47c6e8c43dcd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -391,6 +391,7 @@ struct page_vma_mapped_walk;
 
 #define LRU_GEN_MASK		((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
 #define LRU_REFS_MASK		((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
+#define LRU_REFS_FLAGS		(BIT(PG_referenced) | BIT(PG_workingset))
 
 #ifdef CONFIG_LRU_GEN
 
@@ -406,8 +407,6 @@ enum {
 	NR_LRU_GEN_CAPS
 };
 
-#define LRU_REFS_FLAGS		(BIT(PG_referenced) | BIT(PG_workingset))
-
 #define MIN_LRU_BATCH		BITS_PER_LONG
 #define MAX_LRU_BATCH		(MIN_LRU_BATCH * 64)
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76378bc257e3..1f0d194f8b2f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -283,6 +283,48 @@ static void set_task_reclaim_state(struct task_struct *task,
 	task->reclaim_state = rs;
 }
 
+/**
+ * find_folios_written_back - Find and move the written back folios to a new list.
+ * @list: filios list
+ * @clean: the written back folios list
+ * @skip: whether skip to move the written back folios to clean list.
+ */
+static inline void find_folios_written_back(struct list_head *list,
+		struct list_head *clean, bool skip)
+{
+	struct folio *folio;
+	struct folio *next;
+
+	list_for_each_entry_safe_reverse(folio, next, list, lru) {
+		if (!folio_evictable(folio)) {
+			list_del(&folio->lru);
+			folio_putback_lru(folio);
+			continue;
+		}
+
+		if (folio_test_reclaim(folio) &&
+		    (folio_test_dirty(folio) || folio_test_writeback(folio))) {
+			/* restore LRU_REFS_FLAGS cleared by isolate_folio() */
+			if (lru_gen_enabled() && folio_test_workingset(folio))
+				folio_set_referenced(folio);
+			continue;
+		}
+
+		if (skip || folio_test_active(folio) || folio_test_referenced(folio) ||
+		    folio_mapped(folio) || folio_test_locked(folio) ||
+		    folio_test_dirty(folio) || folio_test_writeback(folio)) {
+			/* don't add rejected folios to the oldest generation */
+			if (lru_gen_enabled())
+				set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS,
+					      BIT(PG_active));
+			continue;
+		}
+
+		/* retry folios that may have missed folio_rotate_reclaimable() */
+		list_move(&folio->lru, clean);
+	}
+}
+
 /*
  * flush_reclaim_state(): add pages reclaimed outside of LRU-based reclaim to
  * scan_control->nr_reclaimed.
@@ -1907,6 +1949,25 @@ static int current_may_throttle(void)
 	return !(current->flags & PF_LOCAL_THROTTLE);
 }
 
+static inline void acc_reclaimed_stat(struct reclaim_stat *stat,
+		struct reclaim_stat *curr)
+{
+	int i;
+
+	stat->nr_dirty += curr->nr_dirty;
+	stat->nr_unqueued_dirty += curr->nr_unqueued_dirty;
+	stat->nr_congested += curr->nr_congested;
+	stat->nr_writeback += curr->nr_writeback;
+	stat->nr_immediate += curr->nr_immediate;
+	stat->nr_pageout += curr->nr_pageout;
+	stat->nr_ref_keep += curr->nr_ref_keep;
+	stat->nr_unmap_fail += curr->nr_unmap_fail;
+	stat->nr_lazyfree_fail += curr->nr_lazyfree_fail;
+	stat->nr_demoted += curr->nr_demoted;
+	for (i = 0; i < ANON_AND_FILE; i++)
+		stat->nr_activate[i] = curr->nr_activate[i];
+}
+
 /*
  * shrink_inactive_list() is a helper for shrink_node().  It returns the number
  * of reclaimed pages
@@ -1916,14 +1977,16 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 		enum lru_list lru)
 {
 	LIST_HEAD(folio_list);
+	LIST_HEAD(clean_list);
 	unsigned long nr_scanned;
 	unsigned int nr_reclaimed = 0;
 	unsigned long nr_taken;
-	struct reclaim_stat stat;
+	struct reclaim_stat stat, curr;
 	bool file = is_file_lru(lru);
 	enum vm_event_item item;
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	bool stalled = false;
+	bool skip_retry = false;
 
 	while (unlikely(too_many_isolated(pgdat, file, sc))) {
 		if (stalled)
@@ -1957,10 +2020,20 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	if (nr_taken == 0)
 		return 0;
 
-	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false);
+	memset(&stat, 0, sizeof(stat));
+retry:
+	nr_reclaimed += shrink_folio_list(&folio_list, pgdat, sc, &curr, false);
+	find_folios_written_back(&folio_list, &clean_list, skip_retry);
+	acc_reclaimed_stat(&stat, &curr);
 
 	spin_lock_irq(&lruvec->lru_lock);
 	move_folios_to_lru(lruvec, &folio_list);
+	if (!list_empty(&clean_list)) {
+		list_splice_init(&clean_list, &folio_list);
+		skip_retry = true;
+		spin_unlock_irq(&lruvec->lru_lock);
+		goto retry;
+	}
 
 	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
 					stat.nr_demoted);
@@ -4567,8 +4640,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	int reclaimed;
 	LIST_HEAD(list);
 	LIST_HEAD(clean);
-	struct folio *folio;
-	struct folio *next;
 	enum vm_event_item item;
 	struct reclaim_stat stat;
 	struct lru_gen_mm_walk *walk;
@@ -4597,34 +4668,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 			scanned, reclaimed, &stat, sc->priority,
 			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
 
-	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
-		if (!folio_evictable(folio)) {
-			list_del(&folio->lru);
-			folio_putback_lru(folio);
-			continue;
-		}
-
-		if (folio_test_reclaim(folio) &&
-		    (folio_test_dirty(folio) || folio_test_writeback(folio))) {
-			/* restore LRU_REFS_FLAGS cleared by isolate_folio() */
-			if (folio_test_workingset(folio))
-				folio_set_referenced(folio);
-			continue;
-		}
-
-		if (skip_retry || folio_test_active(folio) || folio_test_referenced(folio) ||
-		    folio_mapped(folio) || folio_test_locked(folio) ||
-		    folio_test_dirty(folio) || folio_test_writeback(folio)) {
-			/* don't add rejected folios to the oldest generation */
-			set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS,
-				      BIT(PG_active));
-			continue;
-		}
-
-		/* retry folios that may have missed folio_rotate_reclaimable() */
-		list_move(&folio->lru, &clean);
-	}
-
+	find_folios_written_back(&list, &clean, skip_retry);
 	spin_lock_irq(&lruvec->lru_lock);
 
 	move_folios_to_lru(lruvec, &list);
-- 
2.34.1



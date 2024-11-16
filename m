Return-Path: <linux-kernel+bounces-411656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CFD9CFD76
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67105284CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E975B194ACF;
	Sat, 16 Nov 2024 09:26:25 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C101917E6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731749185; cv=none; b=tJs7dGD+hKPdUxJiG0vH3hqoCoxYeWVvZOfSgvVXAT8n3FD1eE/WSFgU6tOkq44xN+o9vAN+Z75+lqV2RGKnNDjob6omo57YC2zdYG89HGU3E9QieuDbby/J4QdO1h7basLaNVVBGHHxLsMt3Rg4qKGZKEOmasF3l9nKojDAaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731749185; c=relaxed/simple;
	bh=5oNeMkCgIzCrsho4/ypfkfi+SXp2dOsifS2qoioq/1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tv9ifb3js7ilJ0gZ2BuPjl3zA0Kgof+2XXdVzg9cMZOvYAgn4xNRE56bgHWOROnDF7ZzHqvNDZrlshifxuQhtAZGpXUhjmAlar46yGk4N/K15Xjhk7mSxYpFT3TZHZktd6VsflCsxO6SWozLVNyxZeVFRx2BuUmFO16qwLr0DBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xr7mY3y9tz4f3l8M
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 17:26:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CE1711A0196
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 17:26:18 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDnDoMoZThnJYjBBw--.28482S3;
	Sat, 16 Nov 2024 17:26:18 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	david@redhat.com,
	willy@infradead.org,
	ryan.roberts@arm.com,
	baohua@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com,
	xieym_ict@hotmail.com
Subject: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the tail of LRU after shrinking
Date: Sat, 16 Nov 2024 09:16:58 +0000
Message-Id: <20241116091658.1983491-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241116091658.1983491-1-chenridong@huaweicloud.com>
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnDoMoZThnJYjBBw--.28482S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyfKrWxGrWftr13uw43trb_yoWfJF47pF
	Z8W3sFyrWkJrnIqr13JF4q9ryFkrW8Xr4UJFW3ur12yF13W340gFyDC340qFW5JrykAF1x
	ZF9rCry5Wa1YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07jnpnQUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

An issue was found with the following testing step:
1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=y
2. Mount memcg v1, and create memcg named test_memcg and set
   usage_in_bytes=2.1G, memsw.usage_in_bytes=3G.
3. Create a 1G swap file, and allocate 2.2G anon memory in test_memcg.

It was found that:

cat memory.usage_in_bytes
2144940032
cat memory.memsw.usage_in_bytes
2255056896

free -h
              total        used        free
Mem:           31Gi       2.1Gi        27Gi
Swap:         1.0Gi       618Mi       405Mi

As shown above, the test_memcg used about 100M swap, but 600M+ swap memory
was used, which means that 500M may be wasted because other memcgs can not
use these swap memory.

It can be explained as follows:
1. When entering shrink_inactive_list, it isolates folios from lru from
   tail to head. If it just takes folioN from lru(make it simple).

   inactive lru: folio1<->folio2<->folio3...<->folioN-1
   isolated list: folioN

2. In shrink_page_list function, if folioN is THP(2M), it may be splited
   and added to swap cache folio by folio. After adding to swap cache,
   it will submit io to writeback folio to swap, which is asynchronous.
   When shrink_page_list is finished, the isolated folios list will be
   moved back to the head of inactive lru. The inactive lru may just look
   like this, with 512 filioes have been move to the head of inactive lru.

   folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1

   It committed io from folioN1 to folioN512, the later folios committed
   was added to head of the 'ret_folios' in the shrink_page_list function.
   As a result, the order was shown as folioN512->folioN511->...->folioN1.

3. When folio writeback io is completed, the folio may be rotated to tail
   of the lru one by one. It's assumed that filioN1,filioN2, ...,filioN512
   are completed in order(commit io in this order), and they are rotated to
   the tail of the LRU in order (filioN1<->...folioN511<->folioN512).
   Therefore, those folios that are tail of the lru will be reclaimed as
   soon as possible.

   folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512

4. However, shrink_page_list and folio writeback are asynchronous. If THP
   is splited, shrink_page_list loops at least 512 times, which means that
   shrink_page_list is not completed but some folios writeback have been
   completed, and this may lead to failure to rotate these folios to the
   tail of lru. The lru may look likes as below:

   folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
   folioN51<->folioN52<->...folioN511<->folioN512

   Although those folios (N1-N50) have been finished writing back, they
   are still at the head of the lru. This is because their writeback_end
   occurred while it were still looping in shrink_folio_list(), causing
   folio_end_writeback()'s folio_rotate_reclaimable() to fail in moving
   these folios, which are not in the LRU but still in the 'folio_list',
   to the tail of the LRU.
   When isolating folios from lru, it scans from tail to head, so it is
   difficult to scan those folios again.

What mentioned above may lead to a large number of folios have been added
to swap cache but can not be reclaimed in time, which may reduce reclaim
efficiency and prevent other memcgs from using this swap memory even if
they trigger OOM.

To fix this issue, the folios whose writeback has been completed should be
move to the tail of the LRU instead of always placing them at the head of
the LRU when the shrink_page_list is finished. It can be realized by
following steps.
1. In the shrink_page_list function, the folios whose are committed to
   are added to the head of 'folio_list', which will be return to the
   caller.
2. When shrink_page_list finishes, it is known that how many folios have
   been pageout, and they are all at the head of 'folio_list', which is
   ready be moved back to LRU. So, in the 'move_folios_to_lru function'
   function, if the first 'nr_io' folios (which have been pageout) have
   been written back completely, move them to the tail of LRU. Otherwise,
   move them to the head of the LRU.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76378bc257e3..04f7eab9d818 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1046,6 +1046,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	struct folio_batch free_folios;
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(demote_folios);
+	LIST_HEAD(pageout_folios);
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
@@ -1061,7 +1062,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		struct address_space *mapping;
 		struct folio *folio;
 		enum folio_references references = FOLIOREF_RECLAIM;
-		bool dirty, writeback;
+		bool dirty, writeback, is_pageout = false;
 		unsigned int nr_pages;
 
 		cond_resched();
@@ -1384,6 +1385,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					nr_pages = 1;
 				}
 				stat->nr_pageout += nr_pages;
+				is_pageout = true;
 
 				if (folio_test_writeback(folio))
 					goto keep;
@@ -1508,7 +1510,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 keep_locked:
 		folio_unlock(folio);
 keep:
-		list_add(&folio->lru, &ret_folios);
+		if (is_pageout)
+			list_add(&folio->lru, &pageout_folios);
+		else
+			list_add(&folio->lru, &ret_folios);
 		VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
 				folio_test_unevictable(folio), folio);
 	}
@@ -1551,6 +1556,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	free_unref_folios(&free_folios);
 
 	list_splice(&ret_folios, folio_list);
+	list_splice(&pageout_folios, folio_list);
 	count_vm_events(PGACTIVATE, pgactivate);
 
 	if (plug)
@@ -1826,11 +1832,14 @@ static bool too_many_isolated(struct pglist_data *pgdat, int file,
 
 /*
  * move_folios_to_lru() moves folios from private @list to appropriate LRU list.
+ * @lruvec: The LRU vector the list is moved to.
+ * @list: The folio list are moved to lruvec
+ * @nr_io: The first nr folios of the list that have been committed io.
  *
  * Returns the number of pages moved to the given lruvec.
  */
 static unsigned int move_folios_to_lru(struct lruvec *lruvec,
-		struct list_head *list)
+		struct list_head *list, unsigned int nr_io)
 {
 	int nr_pages, nr_moved = 0;
 	struct folio_batch free_folios;
@@ -1880,9 +1889,21 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 		 * inhibits memcg migration).
 		 */
 		VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
-		lruvec_add_folio(lruvec, folio);
+		/*
+		 * If the folio have been committed io and writed back completely,
+		 * it should be added to the tailed to the lru, so it can
+		 * be relaimed as soon as possible.
+		 */
+		if (nr_io > 0 &&
+		    !folio_test_reclaim(folio) &&
+		    !folio_test_writeback(folio))
+			lruvec_add_folio_tail(lruvec, folio);
+		else
+			lruvec_add_folio(lruvec, folio);
+
 		nr_pages = folio_nr_pages(folio);
 		nr_moved += nr_pages;
+		nr_io = nr_io > nr_pages ? (nr_io - nr_pages) : 0;
 		if (folio_test_active(folio))
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
@@ -1960,7 +1981,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false);
 
 	spin_lock_irq(&lruvec->lru_lock);
-	move_folios_to_lru(lruvec, &folio_list);
+	move_folios_to_lru(lruvec, &folio_list, stat.nr_pageout);
 
 	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
 					stat.nr_demoted);
@@ -2111,8 +2132,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	 */
 	spin_lock_irq(&lruvec->lru_lock);
 
-	nr_activate = move_folios_to_lru(lruvec, &l_active);
-	nr_deactivate = move_folios_to_lru(lruvec, &l_inactive);
+	nr_activate = move_folios_to_lru(lruvec, &l_active, 0);
+	nr_deactivate = move_folios_to_lru(lruvec, &l_inactive, 0);
 
 	__count_vm_events(PGDEACTIVATE, nr_deactivate);
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
@@ -4627,7 +4648,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 
 	spin_lock_irq(&lruvec->lru_lock);
 
-	move_folios_to_lru(lruvec, &list);
+	move_folios_to_lru(lruvec, &list, 0);
 
 	walk = current->reclaim_state->mm_walk;
 	if (walk && walk->batched) {
-- 
2.34.1



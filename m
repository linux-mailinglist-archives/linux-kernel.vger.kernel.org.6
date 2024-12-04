Return-Path: <linux-kernel+bounces-430546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6BA9E3298
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8485A2852E2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05CA183CC2;
	Wed,  4 Dec 2024 04:11:42 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F216A395
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285502; cv=none; b=pCATZxYEdPYkKYAvUlNBLYtJOmM4guGYmq1u2tCVbvId4buN+YGrQyzCxowvYrW3HUmUYz+KyxSOAZ34BTYtrC3FNAw4Lmc7Gdr3GlTve7iLKt7waCnkEJRzPv6SKLVJ3v8UwkpmyEPEvorpIDPfHaRg1UhW8cz1zGfwR9MsoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285502; c=relaxed/simple;
	bh=3GLWyhu0YZVht/fKGDEC/zZXHUf2abAIUmz6UtIC8Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3wutuPsb41qDtBG7rjYizVD4ZPvZ/POO+JgOGN0eBMiyG4Pg2I42nUGfQdktx7EsEGQqAXTaVEBFq86pJZbx5wyHOAsMXgUbViLQZ5MQG0j6u7U3DSA6R0ZGAFKHNoOF7ovQwZugsu5DrfSl7SJusSrCbPv045rnOK350RuRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y33x5225Nz4f3jqY
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:11:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 437C21A07B6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:11:35 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBnQ8Bt1k9nusICDg--.38617S3;
	Wed, 04 Dec 2024 12:11:35 +0800 (CST)
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
Subject: [RFC PATCH v3 1/2] mm: vmascan: add find_folios_written_back() helper
Date: Wed,  4 Dec 2024 04:01:57 +0000
Message-Id: <20241204040158.2768519-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204040158.2768519-1-chenridong@huaweicloud.com>
References: <20241204040158.2768519-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnQ8Bt1k9nusICDg--.38617S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw48JF4ruFyfWr4rAF18Xwb_yoWrJryUpF
	Z3KrnFyFW8ZryagrsxXF15ur1YkF95Xr4UJFW2kr4xCF15Cw4UKrW7Kw1UJFW3GrWkZF1S
	qw1UWFy0g3WUJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0xRhU
	UUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add find_folios_written_back() helper, which will be called in the
shrink_inactive_list function in subsequent patch.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 73 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76378bc257e3..af1ff76f83e7 100644
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
@@ -4567,8 +4609,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	int reclaimed;
 	LIST_HEAD(list);
 	LIST_HEAD(clean);
-	struct folio *folio;
-	struct folio *next;
 	enum vm_event_item item;
 	struct reclaim_stat stat;
 	struct lru_gen_mm_walk *walk;
@@ -4597,34 +4637,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
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



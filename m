Return-Path: <linux-kernel+bounces-196568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990498D5E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0631C25122
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E0813F437;
	Fri, 31 May 2024 09:20:29 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92112FB3B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147228; cv=none; b=fF800nau/hU2RtiUIRa0bRXAEajShnKR3TY90kGPLII53kt5lqLLLXtmM4suvbRn4P3PslsMjM6tRBzHnkR65kkiFet7qjvwP9UOmw8rIBdvF5U6DtJosZibHUnXueeiGKqHKM0SnaGCGj9TFv9mX0I3NKxly2WWADXFIEFoOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147228; c=relaxed/simple;
	bh=3Qa06/bNSuGqk/lF+w8XivvbfZPxyLfhmfvPOs6TN6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FE8RkDAnBfIuDUYnQTeEhKd6zjTJHaA3YT7qS96zakvZgTv2ENPC62g9R7NC9klupIeXRuZA4x5SdLev5fPF+KSQ4240np8wUNYEYaHM78LLqV3ELSN2kLhmyvuwEu3BuftMe/xyCxQsA6T/2BaoPvtqzW1hVKOMHgi4PHbM/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-61-6659964c009f
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
Subject: [PATCH v11 07/12] mm: add a parameter, unmap generation number, to free_unref_folios()
Date: Fri, 31 May 2024 18:19:56 +0900
Message-Id: <20240531092001.30428-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoa7PtMg0g0lThC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	3D2rWAvuqlU86TzC0sC4U76LkZNDQsBE4vXki8ww9qmTT1hAbDYBdYkbN36CxUUEzCQOtv5h
	B7GZBe4ySRzoZwOxhQXiJWa8hoizCKhK7Pm3AyzOK2Aq8fXmCxaImfISqzccAJvDCTTnwN87
	jCC2EFDNov+9QDYXUM17NolDF2dAHSEpcXDFDZYJjLwLGBlWMQpl5pXlJmbmmOhlVOZlVugl
	5+duYgSG/rLaP9E7GD9dCD7EKMDBqMTDG1ARkSbEmlhWXJl7iFGCg1lJhPdXOlCINyWxsiq1
	KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDo1NnzjGhvF3zvnLovXVh
	f3zizEvvR1q+Ztc/ZJrf+WnvEv2H89H07cGTmvdqPvo8T0lgmsws5hOVuxc9l5ZdLrSl64Xy
	m9Vm16a+8JtrP2XtNamir8fvXr5fuK72lrrQ7bPLzB1c/74yVrrQbyLwWLxlzcfKnjW+AtHF
	7r+32+5Z7HN6QypjznklluKMREMt5qLiRAAo08rMeQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrOszLTLNYNsjdos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZczds4q14K5axZPOIywNjDvluxg5OSQETCROnXzCAmKzCahL3LjxkxnEFhEw
	kzjY+ocdxGYWuMskcaCfDcQWFoiXmPEaIs4ioCqx598OsDivgKnE15svWCBmykus3nAAbA4n
	0JwDf+8wgthCQDWL/vcyTmDkWsDIsIpRJDOvLDcxM8dUrzg7ozIvs0IvOT93EyMwkJfV/pm4
	g/HLZfdDjAIcjEo8vAEVEWlCrIllxZW5hxglOJiVRHh/pQOFeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGCe+PnHw2aOZX14+ZYx7ZyVbVFf4OZ+dyUyp
	yIBv5k6HzPhNi1SlbYJtmqt9fz3KvLTp07+9fvsvifsdCe4N+2sbd3dldH9p1Cmf/nk9GueM
	79YGzIg4apnc7r1mS3Tz5SV3dHQU7CZ/zl+7zlm/o1vxX/913jVrFh3c2fx71aOwOQ3H/6gK
	zFBiKc5INNRiLipOBAC//IG9YAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Unmap generation number is used by luf mechanism to track need of tlb
flush for each page residing in pcp or buddy.

The number should be delivered to pcp or buddy via free_unref_folios()
that is for releasing folios that have been unmapped during reclaim in
shrink_folio_list().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 10 +++++-----
 mm/swap.c       |  6 +++---
 mm/vmscan.c     |  8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 380ae980e4f9..dba6d0eb7b6d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -662,7 +662,7 @@ extern bool free_pages_prepare(struct page *page, unsigned int order);
 extern int user_min_free_kbytes;
 
 void free_unref_page(struct page *page, unsigned int order, unsigned short int ugen);
-void free_unref_folios(struct folio_batch *fbatch);
+void free_unref_folios(struct folio_batch *fbatch, unsigned short int ugen);
 
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6fbbe45be5ae..c9acb4da91e0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2698,7 +2698,7 @@ void free_unref_page(struct page *page, unsigned int order,
 /*
  * Free a batch of folios
  */
-void free_unref_folios(struct folio_batch *folios)
+void free_unref_folios(struct folio_batch *folios, unsigned short int ugen)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp = NULL;
@@ -2720,7 +2720,7 @@ void free_unref_folios(struct folio_batch *folios)
 		 */
 		if (!pcp_allowed_order(order)) {
 			free_one_page(folio_zone(folio), &folio->page,
-				      pfn, order, FPI_NONE, 0);
+				      pfn, order, FPI_NONE, ugen);
 			continue;
 		}
 		folio->private = (void *)(unsigned long)order;
@@ -2756,7 +2756,7 @@ void free_unref_folios(struct folio_batch *folios)
 			 */
 			if (is_migrate_isolate(migratetype)) {
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE, 0);
+					      order, FPI_NONE, ugen);
 				continue;
 			}
 
@@ -2769,7 +2769,7 @@ void free_unref_folios(struct folio_batch *folios)
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE, 0);
+					      order, FPI_NONE, ugen);
 				continue;
 			}
 			locked_zone = zone;
@@ -2784,7 +2784,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype,
-				order, 0);
+				order, ugen);
 	}
 
 	if (pcp) {
diff --git a/mm/swap.c b/mm/swap.c
index dae169b19ab9..67605bbfc95c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -161,11 +161,11 @@ void put_pages_list(struct list_head *pages)
 		/* LRU flag must be clear because it's passed using the lru */
 		if (folio_batch_add(&fbatch, folio) > 0)
 			continue;
-		free_unref_folios(&fbatch);
+		free_unref_folios(&fbatch, 0);
 	}
 
 	if (fbatch.nr)
-		free_unref_folios(&fbatch);
+		free_unref_folios(&fbatch, 0);
 	INIT_LIST_HEAD(pages);
 }
 EXPORT_SYMBOL(put_pages_list);
@@ -1027,7 +1027,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 
 	folios->nr = j;
 	mem_cgroup_uncharge_folios(folios);
-	free_unref_folios(folios);
+	free_unref_folios(folios, 0);
 }
 EXPORT_SYMBOL(folios_put_refs);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b9170f767353..15efe6f0edce 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1461,7 +1461,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
-			free_unref_folios(&free_folios);
+			free_unref_folios(&free_folios, 0);
 		}
 		continue;
 
@@ -1528,7 +1528,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 	mem_cgroup_uncharge_folios(&free_folios);
 	try_to_unmap_flush();
-	free_unref_folios(&free_folios);
+	free_unref_folios(&free_folios, 0);
 
 	list_splice(&ret_folios, folio_list);
 	count_vm_events(PGACTIVATE, pgactivate);
@@ -1868,7 +1868,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 			if (folio_batch_add(&free_folios, folio) == 0) {
 				spin_unlock_irq(&lruvec->lru_lock);
 				mem_cgroup_uncharge_folios(&free_folios);
-				free_unref_folios(&free_folios);
+				free_unref_folios(&free_folios, 0);
 				spin_lock_irq(&lruvec->lru_lock);
 			}
 
@@ -1890,7 +1890,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 	if (free_folios.nr) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		mem_cgroup_uncharge_folios(&free_folios);
-		free_unref_folios(&free_folios);
+		free_unref_folios(&free_folios, 0);
 		spin_lock_irq(&lruvec->lru_lock);
 	}
 
-- 
2.17.1



Return-Path: <linux-kernel+bounces-175355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D780E8C1E76
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D5B1C20B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0066316131A;
	Fri, 10 May 2024 06:52:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654815F301
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323953; cv=none; b=BWYeNWWshvSe/OBGlZxvrASjP3mKVPoQ1SbO8HpuwYwdkjmydrKwqtDxfAalhHjpUTVkUuCdkl+th8yM3V8jj5dqY2pB4+M34ogxepWxS+tBI9TgVnLGsPkILPatuTrakrXLHgt3Qh8LkKKC6N3O5t4MVoSdr2u7DLCh9XV6Wd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323953; c=relaxed/simple;
	bh=U4C6hgege4A70iJyvoq3+WAv26Y57xC3oCvCrAAOIQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JVXfe69RHD2pfntxLQn1Vb0Tu9vbwq+RzW37w7KFn+vIzOmeu4oFQQTUbZDLUutx/YuMqfltWh9a3QrPkG5IGM7FvXQf7QO1qdlAPxzzkp/QIZdS5HZDRzalTul+yEkiItGb74/yC2dEdDwrU9Ln0oBCp+jEHrJrR+F3R83bqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-e2-663dc4213de4
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
Subject: [PATCH v10 07/12] mm: add a parameter, unmap generation number, to free_unref_folios()
Date: Fri, 10 May 2024 15:52:01 +0900
Message-Id: <20240510065206.76078-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
References: <20240510065206.76078-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnka7iEds0gz8v1S3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	pm8T2AruqlV03fFvYNwp38XIySEhYCLR9OYNI4zduOYlE4jNJqAucePGT2YQW0TATOJg6x92
	EJtZ4C6TxIF+NhBbWCBeYu25DWBxFgFViZN7p7J0MXJw8AqYSvw4rAkxUl5i9YYDYGM4gcZ8
	WDYDbLwQUEnHg4lAa7mAat6zSfy7sJcJokFS4uCKGywTGHkXMDKsYhTKzCvLTczMMdHLqMzL
	rNBLzs/dxAgM+2W1f6J3MH66EHyIUYCDUYmHd8dmmzQh1sSy4srcQ4wSHMxKIrxVNdZpQrwp
	iZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhhbmLIy56/pml1h
	klWpybhetmq1VL30mpuecbt7lzwN3dpdeuWbZnbpyswgfpfIdxtFhL9o5S9NfP/v9sykSUoz
	FU8m2jdGLvoktfm8RtvJmzoNXyc0leu8q3qV83OHjfmUy027BWrm25u+vrv83bme12cWsdsH
	/nXaEaKwcpoLT4ne3WIBnjdKLMUZiYZazEXFiQArqVPSdwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrKt4xDbNYP5cOYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZWz6NoGt4K5aRdcd/wbGnfJdjJwcEgImEo1rXjKB2GwC6hI3bvxkBrFFBMwk
	Drb+YQexmQXuMkkc6GcDsYUF4iXWntsAFmcRUJU4uXcqSxcjBwevgKnEj8OaECPlJVZvOAA2
	hhNozIdlM8DGCwGVdDyYyDiBkWsBI8MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwCBeVvtn
	4g7GL5fdDzEKcDAq8fDu2GyTJsSaWFZcmXuIUYKDWUmEt6rGOk2INyWxsiq1KD++qDQntfgQ
	ozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qBsf7FjoWTtidEVrX2HOhfUaE1h+frgeUy
	/65/v2G/ZFfFwdtPPrmu/sCTI3j2+cP9ueyK3Nxmpb3L6pX89wYda+Osc40veJQupFaU1Wkb
	eDylkuv8kVXiXTWzE2QtbPle+BX4q4VFLfrr8PhC+ucJ/yOT6z6yWh21yw++J7SkKOjPjjDB
	pQ93K7EUZyQaajEXFScCAFRkCp5eAgAA
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
index 332662047c17..0d4c74e76de6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -639,7 +639,7 @@ extern bool free_pages_prepare(struct page *page, unsigned int order);
 extern int user_min_free_kbytes;
 
 void free_unref_page(struct page *page, unsigned int order, unsigned short int ugen);
-void free_unref_folios(struct folio_batch *fbatch);
+void free_unref_folios(struct folio_batch *fbatch, unsigned short int ugen);
 
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2cd278c207d1..63f14305f4de 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2706,7 +2706,7 @@ void free_unref_page(struct page *page, unsigned int order,
 /*
  * Free a batch of folios
  */
-void free_unref_folios(struct folio_batch *folios)
+void free_unref_folios(struct folio_batch *folios, unsigned short int ugen)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp = NULL;
@@ -2729,7 +2729,7 @@ void free_unref_folios(struct folio_batch *folios)
 		 */
 		if (!pcp_allowed_order(order)) {
 			free_one_page(folio_zone(folio), &folio->page,
-				      pfn, order, FPI_NONE, 0);
+				      pfn, order, FPI_NONE, ugen);
 			continue;
 		}
 		folio->private = (void *)(unsigned long)order;
@@ -2765,7 +2765,7 @@ void free_unref_folios(struct folio_batch *folios)
 			 */
 			if (is_migrate_isolate(migratetype)) {
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE, 0);
+					      order, FPI_NONE, ugen);
 				continue;
 			}
 
@@ -2778,7 +2778,7 @@ void free_unref_folios(struct folio_batch *folios)
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE, 0);
+					      order, FPI_NONE, ugen);
 				continue;
 			}
 			locked_zone = zone;
@@ -2793,7 +2793,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype,
-				order, 0);
+				order, ugen);
 	}
 
 	if (pcp) {
diff --git a/mm/swap.c b/mm/swap.c
index 0fc5a5e8457f..1937ac937b8f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -163,11 +163,11 @@ void put_pages_list(struct list_head *pages)
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
@@ -1029,7 +1029,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 
 	folios->nr = j;
 	mem_cgroup_uncharge_folios(folios);
-	free_unref_folios(folios);
+	free_unref_folios(folios, 0);
 }
 EXPORT_SYMBOL(folios_put_refs);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 49bd94423961..bb0ff11f9ec9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1460,7 +1460,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
-			free_unref_folios(&free_folios);
+			free_unref_folios(&free_folios, 0);
 		}
 		continue;
 
@@ -1527,7 +1527,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 	mem_cgroup_uncharge_folios(&free_folios);
 	try_to_unmap_flush();
-	free_unref_folios(&free_folios);
+	free_unref_folios(&free_folios, 0);
 
 	list_splice(&ret_folios, folio_list);
 	count_vm_events(PGACTIVATE, pgactivate);
@@ -1869,7 +1869,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 			if (folio_batch_add(&free_folios, folio) == 0) {
 				spin_unlock_irq(&lruvec->lru_lock);
 				mem_cgroup_uncharge_folios(&free_folios);
-				free_unref_folios(&free_folios);
+				free_unref_folios(&free_folios, 0);
 				spin_lock_irq(&lruvec->lru_lock);
 			}
 
@@ -1891,7 +1891,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 	if (free_folios.nr) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		mem_cgroup_uncharge_folios(&free_folios);
-		free_unref_folios(&free_folios);
+		free_unref_folios(&free_folios, 0);
 		spin_lock_irq(&lruvec->lru_lock);
 	}
 
-- 
2.17.1



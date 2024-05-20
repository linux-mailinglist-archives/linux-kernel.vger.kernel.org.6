Return-Path: <linux-kernel+bounces-183345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420EC8C97D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653501C214BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABAE18B04;
	Mon, 20 May 2024 02:18:00 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60AFDF51
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171479; cv=none; b=iDYh05PaXAi2wI+VZpeNHZ+Tkt7m+6zcGLOx0Hn2A/PltNKXwIee3sDxcKlIkZTZjlw8S9u5yTLqQ+fDjxMvkmuxw5AV6tsmXwJwqVkSouqLYclmC8WjUXlZYg/dfNbgN6SOqnOxiutwjmfBVSgc5gONutMUkh6asjVsbocBcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171479; c=relaxed/simple;
	bh=U4C6hgege4A70iJyvoq3+WAv26Y57xC3oCvCrAAOIQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oAOUq1W/k7fXysyNPFTE9s10MoDUAYB8vEHT6zFx2XKES9wfLs7E/aVb3Zu2bu/qm9XLwghW6oPlmBYiQCuBoVGPNOzyrYbdBC1tyr9juHar/cLhuGZ1VmHy/GTLeGr8urHCKqxQwRNSEha++6m37hjLeDBEImbWtqKADaM4Ezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-b8-664ab2c98732
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
Subject: [RESEND PATCH v10 07/12] mm: add a parameter, unmap generation number, to free_unref_folios()
Date: Mon, 20 May 2024 11:17:29 +0900
Message-Id: <20240520021734.21527-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnke7JTV5pBn/WcVrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	Td8msBXcVavouuPfwLhTvouRk0NCwETi+ZJX7DD21ZX3mEBsNgF1iRs3fjKD2CICZhIHW/+A
	1TAL3GWSONDPBmILC6RJ3J84H8xmEVCVONV1GqyXV8BUYsvHx4wQM+UlVm84ADaHE2jOjFU7
	WUBsIaCaH0e/AvVyAdW8Z5M4+r6LBaJBUuLgihssExh5FzAyrGIUyswry03MzDHRy6jMy6zQ
	S87P3cQIDPxltX+idzB+uhB8iFGAg1GJh3fHI880IdbEsuLK3EOMEhzMSiK8m7YAhXhTEiur
	Uovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTAGKB97+tTbeKZ1XSHr
	239H9e70ewTlztj+MHhjlLnD+l9/xd83Zj1dYSQ7oSx1x7NJtyrrp6u3b5D/2+/SklL528zs
	2G+d84+y9+XxFTHbSbEK6J+4ciLj5rE1kbmqF89qMNufnbW8QHjTnK2aWTM2GzYFH9s8d2qs
	7jPj622LpiVsv/rYaPFJJZbijERDLeai4kQAutg0mngCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrHtyk1eawXZeiznr17BZfN7wj83i
	xYZ2Rouv638xWzz91MdicXjuSVaLy7vmsFncW/Of1eL8rrWsFjuW7mOyuHRgAZPF8d4DTBbz
	731ms9i8aSqzxfEpUxktfv8AKj45azKLg6DH99Y+Fo+ds+6yeyzYVOqxeYWWx+I9L5k8Nq3q
	ZPPY9GkSu8e7c+fYPU7M+M3iMe9koMf7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwR3HZpKTm
	ZJalFunbJXBlbPo2ga3grlpF1x3/Bsad8l2MnBwSAiYSV1feYwKx2QTUJW7c+MkMYosImEkc
	bP3DDmIzC9xlkjjQzwZiCwukSdyfOB/MZhFQlTjVdRqsl1fAVGLLx8eMEDPlJVZvOAA2hxNo
	zoxVO1lAbCGgmh9Hv7JNYORawMiwilEkM68sNzEzx1SvODujMi+zQi85P3cTIzCIl9X+mbiD
	8ctl90OMAhyMSjy8G257pgmxJpYVV+YeYpTgYFYS4d20BSjEm5JYWZValB9fVJqTWnyIUZqD
	RUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAeL/BPtem2GmeynLu1j/Pl07tLPnMoqUxpajs
	TFXDe+s1nzbm+Kl71hUU9vSWXv04ne2IZp2MwvtTD3NMLk86wTznpuC96mK5czoHVwg8yT3J
	eWD+9AU3t71Yf3lHS9lvgc4VMRsPVQcJHmW4yFT68vU3q5jNFxwcevdMUxVftWEb++P2M+Uv
	liixFGckGmoxFxUnAgB0MP5JXgIAAA==
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



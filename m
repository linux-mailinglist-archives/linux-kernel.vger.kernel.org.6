Return-Path: <linux-kernel+bounces-240429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C798926D83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C27B22AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C614285;
	Thu,  4 Jul 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0L7gFjY0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0B14F90
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060538; cv=none; b=Ykq0vIMdMU6+CMn8DSPDQJBCXVh96sR1HNoj7u/9gysZ2n/zrkGsmIB6YODks8X/MkTVhxxQbp1+vvpvDPT/aCaZPwB7UgJOeyo+QztXASwrwQTprN0wxo0Ht1osPZtyTkvpZbJAXe0BWc2SNMCIM/DtDkYxqkAWxZ/CGj5OvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060538; c=relaxed/simple;
	bh=CCdptDblgEDJMwdJ2hZx/MZmumuPKe3fT1gLmOBxzCQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fG8wk153qO0egIYBO5RLiG/3Af/9QbJTG1qTiHKNHLaWyqJ4Oc2bj7kqReOMw4oE/2NULX9/KtIlRtENoQrdSiyAto5PfXo4OqlYI3zF0XuFoTZNHStI3OUCkGBSoUx/8PeYI+JiebVnNB6hUGdCYXqB4S4/Jx+6lTch3X8Poxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0L7gFjY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8F1C2BD10;
	Thu,  4 Jul 2024 02:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720060537;
	bh=CCdptDblgEDJMwdJ2hZx/MZmumuPKe3fT1gLmOBxzCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0L7gFjY0jppfIMjs4LcHJgPXYk/O9ZobxUzbn20XCZ/thrU9PJRTfAo2xN6iQqSqe
	 /Hmt0K+E89a98lfBuBxj/tFNsy4WiQ3kNT0pE1TAIJD+hHBJnS6FH3p9a9nicBO5w+
	 kIJtRQG6DPAVHL2hrBljqFBWd/DR8GY6rYsQ9XJg=
Date: Wed, 3 Jul 2024 19:35:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham
 <nphamcs@gmail.com>, Yang Shi <shy828301@gmail.com>, Zi Yan
 <ziy@nvidia.com>, Barry Song <baohua@kernel.org>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, David Hildenbrand <david@redhat.com>, Matthew
 Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
Message-Id: <20240703193536.78bce768a9330da3a361ca8a@linux-foundation.org>
In-Reply-To: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 00:40:55 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
> flags when freeing, yet the flags shown are not bad: PG_locked had been
> set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) == 0)s from
> deferred_split_scan()'s folio_put(), and a variety of other BUG and WARN
> symptoms implying double free by deferred split and large folio migration.
> 
> 6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when large
> folio migration") was right to fix the memcg-dependent locking broken in
> 85ce2c517ade ("memcontrol: only transfer the memcg data for migration"),
> but missed a subtlety of deferred_split_scan(): it moves folios to its own
> local list to work on them without split_queue_lock, during which time
> folio->_deferred_list is not empty, but even the "right" lock does nothing
> to secure the folio and the list it is on.
> 
> Fortunately, deferred_split_scan() is careful to use folio_try_get(): so
> folio_migrate_mapping() can avoid the race by folio_undo_large_rmappable()
> while the old folio's reference count is temporarily frozen to 0 - adding
> such a freeze in the !mapping case too (originally, folio lock and
> unmapping and no swap cache left an anon folio unreachable, so no freezing
> was needed there: but the deferred split queue offers a way to reach it).

There's a conflict when applying Kefeng's "mm: refactor
folio_undo_large_rmappable()"
(https://lkml.kernel.org/r/20240521130315.46072-1-wangkefeng.wang@huawei.com)
on top of this hotfix.

--- mm/memcontrol.c~mm-refactor-folio_undo_large_rmappable
+++ mm/memcontrol.c
@@ -7832,8 +7832,7 @@ void mem_cgroup_migrate(struct folio *ol
 	 * In addition, the old folio is about to be freed after migration, so
 	 * removing from the split queue a bit earlier seems reasonable.
 	 */
-	if (folio_test_large(old) && folio_test_large_rmappable(old))
-		folio_undo_large_rmappable(old);
+	folio_undo_large_rmappable(old);
 	old->memcg_data = 0;
 }

I'm resolving this by simply dropping the above hunk.  So Kefeng's
patch is now as below.  Please check.

--- a/mm/huge_memory.c~mm-refactor-folio_undo_large_rmappable
+++ a/mm/huge_memory.c
@@ -3258,22 +3258,11 @@ out:
 	return ret;
 }
 
-void folio_undo_large_rmappable(struct folio *folio)
+void __folio_undo_large_rmappable(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
 	unsigned long flags;
 
-	if (folio_order(folio) <= 1)
-		return;
-
-	/*
-	 * At this point, there is no one trying to add the folio to
-	 * deferred_list. If folio is not in deferred_list, it's safe
-	 * to check without acquiring the split_queue_lock.
-	 */
-	if (data_race(list_empty(&folio->_deferred_list)))
-		return;
-
 	ds_queue = get_deferred_split_queue(folio);
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (!list_empty(&folio->_deferred_list)) {
--- a/mm/internal.h~mm-refactor-folio_undo_large_rmappable
+++ a/mm/internal.h
@@ -622,7 +622,22 @@ static inline void folio_set_order(struc
 #endif
 }
 
-void folio_undo_large_rmappable(struct folio *folio);
+void __folio_undo_large_rmappable(struct folio *folio);
+static inline void folio_undo_large_rmappable(struct folio *folio)
+{
+	if (folio_order(folio) <= 1 || !folio_test_large_rmappable(folio))
+		return;
+
+	/*
+	 * At this point, there is no one trying to add the folio to
+	 * deferred_list. If folio is not in deferred_list, it's safe
+	 * to check without acquiring the split_queue_lock.
+	 */
+	if (data_race(list_empty(&folio->_deferred_list)))
+		return;
+
+	__folio_undo_large_rmappable(folio);
+}
 
 static inline struct folio *page_rmappable_folio(struct page *page)
 {
--- a/mm/page_alloc.c~mm-refactor-folio_undo_large_rmappable
+++ a/mm/page_alloc.c
@@ -2661,8 +2661,7 @@ void free_unref_folios(struct folio_batc
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
-		if (order > 0 && folio_test_large_rmappable(folio))
-			folio_undo_large_rmappable(folio);
+		folio_undo_large_rmappable(folio);
 		if (!free_pages_prepare(&folio->page, order))
 			continue;
 		/*
--- a/mm/swap.c~mm-refactor-folio_undo_large_rmappable
+++ a/mm/swap.c
@@ -123,8 +123,7 @@ void __folio_put(struct folio *folio)
 	}
 
 	page_cache_release(folio);
-	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
-		folio_undo_large_rmappable(folio);
+	folio_undo_large_rmappable(folio);
 	mem_cgroup_uncharge(folio);
 	free_unref_page(&folio->page, folio_order(folio));
 }
@@ -1021,10 +1020,7 @@ void folios_put_refs(struct folio_batch
 			free_huge_folio(folio);
 			continue;
 		}
-		if (folio_test_large(folio) &&
-		    folio_test_large_rmappable(folio))
-			folio_undo_large_rmappable(folio);
-
+		folio_undo_large_rmappable(folio);
 		__page_cache_release(folio, &lruvec, &flags);
 
 		if (j != i)
--- a/mm/vmscan.c~mm-refactor-folio_undo_large_rmappable
+++ a/mm/vmscan.c
@@ -1439,9 +1439,7 @@ free_it:
 		 */
 		nr_reclaimed += nr_pages;
 
-		if (folio_test_large(folio) &&
-		    folio_test_large_rmappable(folio))
-			folio_undo_large_rmappable(folio);
+		folio_undo_large_rmappable(folio);
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
@@ -1848,9 +1846,7 @@ static unsigned int move_folios_to_lru(s
 		if (unlikely(folio_put_testzero(folio))) {
 			__folio_clear_lru_flags(folio);
 
-			if (folio_test_large(folio) &&
-			    folio_test_large_rmappable(folio))
-				folio_undo_large_rmappable(folio);
+			folio_undo_large_rmappable(folio);
 			if (folio_batch_add(&free_folios, folio) == 0) {
 				spin_unlock_irq(&lruvec->lru_lock);
 				mem_cgroup_uncharge_folios(&free_folios);
_



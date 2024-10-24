Return-Path: <linux-kernel+bounces-379156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF549ADACD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C351A1C219ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF0166315;
	Thu, 24 Oct 2024 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9VR1WRa"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362191EB3D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729743042; cv=none; b=UqhjcGUJSgfX/lW+LkqaQ6T/NxqT/Mnq8kxowD0QfoEyN4VCjItBW9KFDJ822ZrGA++Ty4VLhpjQdGPC9k7ofi6NfoCEEUvZaw7HJAJv8vnEhIh9sgGXUOQR0O+KUl22smXGIEWgEPPWZx2lXzJ7ETn3Wh05kpu1MDeirDYQ1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729743042; c=relaxed/simple;
	bh=fGWa+CQAsSc+p5lStud76Dv7qi6VEHXlBoluDXnt+ZU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Fy5Jypt4oYbPGqi1oyRMHiMbwSp5S+5AEnIe9ZSKPdrDFbD8yZrAUCzVGPmywqLgWPll08SdC6VUEvC7s9DQuXy1xSHSF8U1Q/uaDOyGSXbsEWMl0zGwoptRLnRhHo5ovNvfggYNqST0DGjwv38/+WzOPKNXLsP3wM3VIR83h9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9VR1WRa; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-288d74b3a91so356825fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729743039; x=1730347839; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yn77C/xxzSi/PdOkEd//aGH6uiDZj6/qHoCDJkjxx3E=;
        b=A9VR1WRaLuvISrxahaEXPK2uMrt/9RHZIoslP5wKiOYr1g+Kl+2kAxjD5d383oGEPD
         3CkXcvzdraMTBRUDiWssPFYxvibPbbXSi4JTapS3nzJ/5Yk3FkS+hBGHQgVW79NjcIlS
         qN9O4ufp8DCapX5+GfZdhX0TsuLusYOuxNkE3cNs0NhWtpmDdWpvZntf5X+zEIR2xukg
         FMi8A4R4AipAXZ4I59lvsQcHw5hDwSlbpV7zJWmAQ4qUrgrWRECiuH2ONKRU9wOwp9HX
         E0oFGAim0uGnGbtJfY3UVzPCbD/6GkVJpsZbJbIGDPvp+B0fgRotEELhVlhMDDDLNeRs
         NehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729743039; x=1730347839;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yn77C/xxzSi/PdOkEd//aGH6uiDZj6/qHoCDJkjxx3E=;
        b=Fpz0WFV8b8xEhb5cR8LK5hn4AIT2mjxSx+zISj1iHjBKHaoS3NASCW00WchPU7YZIk
         MWatCZRP5SMTcXSZ7bRwuf7I6/wjH13OPWAKw7znw/L93FEQZzK4pLo4E+P/VsZUSY/t
         TDvyF2cKYs3fUGOQo6XtW3kflk/u3DZraXBTUAEKDmeXh9mPipav/UH/k5wAbZvAySrq
         6Zk5G7vxO0oZucX4GSrt6Pc5DzwFc+eYNlxa6IHmk7lpQnGkdx6sWLOlOn1OanfV/Krm
         71dNHUkXdG94LfnWPKLg4FRicFgMaAQ9f5MoxMri4/TNLYwkT317LuEnCEu/nGTLGWmu
         nOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFOx67uwYlS+7xlxuMIqynrFREmmGfbpT7YpokXwN5ZdXAyM1eJiGJcdunGyvDXlJe/NDtUQ9gZ17D7sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBh6bciZyd3EeIHl9MGjWTOmsix+WB3y8XAdo4vUGOR+istRbK
	OqhvvWTsTxEIunVhdmXqisU2Ernbmo0Fol3DM+e3HNbHtiQj05bv4Xm5MpWLRg==
X-Google-Smtp-Source: AGHT+IGQwUlPD8ns9Utb2tr/HtMk8Wi4zrqUznuOyTeg9/Yu++uaYuMFy7qcbOdOO8AfMjUddXM2gw==
X-Received: by 2002:a05:6870:a79b:b0:268:9f88:18ef with SMTP id 586e51a60fabf-28ced27ba4cmr529116fac.13.1729743039120;
        Wed, 23 Oct 2024 21:10:39 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb3ec69sm2039774a34.22.2024.10.23.21.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:10:37 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:10:20 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not
 partially_mapped
Message-ID: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Recent changes are putting more pressure on THP deferred split queues:
under load revealing long-standing races, causing list_del corruptions,
"Bad page state"s and worse (I keep BUGs in both of those, so usually
don't get to see how badly they end up without).  The relevant recent
changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
improved swap allocation, and underused THP splitting.

The new unlocked list_del_init() in deferred_split_scan() is buggy.
I gave bad advice, it looks plausible since that's a local on-stack
list, but the fact is that it can race with a third party freeing or
migrating the preceding folio (properly unqueueing it with refcount 0
while holding split_queue_lock), thereby corrupting the list linkage.

The obvious answer would be to take split_queue_lock there: but it has
a long history of contention, so I'm reluctant to add to that. Instead,
make sure that there is always one safe (raised refcount) folio before,
by delaying its folio_put().  (And of course I was wrong to suggest
updating split_queue_len without the lock: leave that until the splice.)

And remove two over-eager partially_mapped checks, restoring those tests
to how they were before: if uncharge_folio() or free_tail_page_prepare()
finds _deferred_list non-empty, it's in trouble whether or not that folio
is partially_mapped (and the flag was already cleared in the latter case).

Fixes: dafff3f4c850 ("mm: split underused THPs")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/huge_memory.c | 21 +++++++++++++++++----
 mm/memcontrol.c  |  3 +--
 mm/page_alloc.c  |  5 ++---
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2fb328880b50..a1d345f1680c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3718,8 +3718,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
 	unsigned long flags;
 	LIST_HEAD(list);
-	struct folio *folio, *next;
-	int split = 0;
+	struct folio *folio, *next, *prev = NULL;
+	int split = 0, removed = 0;
 
 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
@@ -3775,15 +3775,28 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		 */
 		if (!did_split && !folio_test_partially_mapped(folio)) {
 			list_del_init(&folio->_deferred_list);
-			ds_queue->split_queue_len--;
+			removed++;
+		} else {
+			/*
+			 * That unlocked list_del_init() above would be unsafe,
+			 * unless its folio is separated from any earlier folios
+			 * left on the list (which may be concurrently unqueued)
+			 * by one safe folio with refcount still raised.
+			 */
+			swap(folio, prev);
 		}
-		folio_put(folio);
+		if (folio)
+			folio_put(folio);
 	}
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	list_splice_tail(&list, &ds_queue->split_queue);
+	ds_queue->split_queue_len -= removed;
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
+	if (prev)
+		folio_put(prev);
+
 	/*
 	 * Stop shrinker if we didn't split any page, but the queue is empty.
 	 * This can happen if pages were freed under us.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7845c64a2c57..2703227cce88 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4631,8 +4631,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
 			!folio_test_hugetlb(folio) &&
-			!list_empty(&folio->_deferred_list) &&
-			folio_test_partially_mapped(folio), folio);
+			!list_empty(&folio->_deferred_list), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8afab64814dc..4b21a368b4e2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -961,9 +961,8 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 		break;
 	case 2:
 		/* the second tail page: deferred_list overlaps ->mapping */
-		if (unlikely(!list_empty(&folio->_deferred_list) &&
-		    folio_test_partially_mapped(folio))) {
-			bad_page(page, "partially mapped folio on deferred list");
+		if (unlikely(!list_empty(&folio->_deferred_list))) {
+			bad_page(page, "on deferred list");
 			goto out;
 		}
 		break;
-- 
2.35.3


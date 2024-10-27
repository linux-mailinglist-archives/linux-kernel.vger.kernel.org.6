Return-Path: <linux-kernel+bounces-383769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F6F9B2002
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778E028158B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D7B17C7BE;
	Sun, 27 Oct 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjnUEMYd"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CA8460
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059192; cv=none; b=m56sXv/W3yjHhzbQFqrGdG8Ub7BdUphhbw2ARrJLaTfYfxrMDgQ7H30uKguyYD/EiucI5Sg1TngjduAJ/r/bWlhtDzxM0Q04MYq9W+ry0V7Yjhsy8F1kt8kFWP+n/+UANsQXZvix/dgxV8uwyQatmOgkpHdepaC8TI5o9XoxsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059192; c=relaxed/simple;
	bh=TEb8LFy6WXxbhiQNe1m3pK6LHJAr3m3KzUeK5FGPBQ0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=GF1lTjTcXOVBqzSLwYbDKOtQr4OU3QCY3RZffCy4KvnYjquefqTfAneRhrxQo3HisdPGKxjVpS/VorL6ORQKowjK8H1QR67RkWg6xBNN5+bKdJi63GiEzyp4WY1mQejwpassXIJpFrfATIo3SW9JxapS71vztx5fevrA6e1FQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjnUEMYd; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea8d7341e6so2722569a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730059190; x=1730663990; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2K0ZF9zx/iXF4BSeP4voI6OccaK4WNY3EiJpX9l6QVQ=;
        b=mjnUEMYdIf8X/lVfijmskhvVZ+I4jgQxbkIdku9AFpFnxbgnCiR86Z/FRydxNUMVlV
         OpWo6bUIhpwlNlAX8w4XRaEfHqWGxjAikb+ZOqOJmRCOYHn6OMphvgEVLfWQhP7/zthH
         HSw5YmGgfaYVjeNfoOdAPaQEUp4pTlt65WJtF2iJjlowqc0ftfxJqh/xANfkh3smYDF6
         7drIAWvFvi27fXHWMpy7TJJvkllhYBnSjhGntGC1hAgxNf6Di0R+9RBFbv6ZzAz6kKN7
         NkPmSUcsUNKdFInde6xtFPFvn+RJf5Y4F4slsUX9pqnK9uJNERZs5XWhhF6Yb0D6pHPZ
         fIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059190; x=1730663990;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2K0ZF9zx/iXF4BSeP4voI6OccaK4WNY3EiJpX9l6QVQ=;
        b=FL1xuWL9dLH3zOVeWRbaZVE1swALmrC5Ta/2Lyonk7+lgNUmTvCT0BKdo9K0y9mtYa
         teh5U0tE1shUUtB+cA6aev5PdfSqaipfYusK1+dNqMKipEbSiqf4mGB08vJInEjIcw/s
         LSu7Rve0uaNmG/J+pHEVrvvilPt6YutBtC1gcpoyxCxZArM+6ZnVmtI9drMcUDCm3bkT
         Dww7wmG9ec2p6AYSrsL+XMr/KLG+DSnjJrDc+ZE2IPawoa0zCjnwgh8rhx5/8QhB5SV5
         n9/zRgwuHv9ae+wiR8QGB4iNnycw4HKtA+9jEy6Aomkk1Rwl5d+LbzCuqhx5yVoS+WXg
         j4rA==
X-Forwarded-Encrypted: i=1; AJvYcCWyFn0QQyPq4AwTwbCujleK+HoD4cp8fAJP2BhyqLb/3gHTct7hOMs1ejj5jx5nHmDLuzNMWpLBoZxgfKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuw62FCgBbtPponUXAbrPPQfceDpsNro1X1RyQ3UZ61r5u3mTw
	gG4l2/lK40qM1IQ2T+xh8tI2x3Kle8Ypz/x80QSOrxyJgScdekI1wZ/Cq4hQVw==
X-Google-Smtp-Source: AGHT+IEzH36YOXESM9Up0rNVkNIoEgpliyHU+RcGa54EOHpi5Nqa7gJZnKWl/7+xW3c5Q/LPMwj5Xw==
X-Received: by 2002:a05:6a20:9f95:b0:1d7:ca7:bfce with SMTP id adf61e73a8af0-1d9a850a3c8mr9259258637.42.1730059189495;
        Sun, 27 Oct 2024 12:59:49 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a2493bsm4476650b3a.179.2024.10.27.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 12:59:48 -0700 (PDT)
Date: Sun, 27 Oct 2024 12:59:34 -0700 (PDT)
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
    Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH hotfix v2 1/2] mm/thp: fix deferred split queue not
 partially_mapped
Message-ID: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
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
Acked-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Based on 6.12-rc4
v2: added ack and reviewed-bys

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


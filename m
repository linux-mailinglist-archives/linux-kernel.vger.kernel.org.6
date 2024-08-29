Return-Path: <linux-kernel+bounces-306365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF9963E08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BDA1C224D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E25318A6BF;
	Thu, 29 Aug 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J44MvGKz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B918A6B1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918856; cv=none; b=U3dJAEiWhhkGKdgsuCCBfx1Q/K2WglkJ0l/HfbwGQIxlbN3XMc5qs5FqYVVZmy5HwhWlgbrKoMuvB7fKNn3m42dCDqF/vbivSiEzD8PIuMZo1JAOPpzgC56DKZf6RO3HJwKmhL6F9BNzoO5Xcrbnh/eVZrCJJ59egX1hrDe4q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918856; c=relaxed/simple;
	bh=UorijSIgxkd8csrJbZ9aVw5gpKWYep6BTId7bOVp6JY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t+zf2e4wirqqAMVPR3/RkoGqSYeo+ZQIunCNXgY3hqfseHDP7sI0vjYc/itRfwNv/bLR6xKtcr2FjHhiwCfimiUESOSI0F0VVQo0vse/iMwHpN3XDq1fi7yZ4Fd3J/t6V/Rsjg+X0qBK5Zo277xjeqvZhgiQmbcsgvZbrIeaeus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J44MvGKz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201df0b2df4so2774355ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724918854; x=1725523654; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXvClmAij1L1JVrPb3Y+ThrTxtkUcnsEqbcNJq45kWA=;
        b=J44MvGKzDVbYilyL8F8Rd3ZWboGe0wP9OJSghPibnOEhHfQ1v11DTNmyqvVc1nEXyH
         Xn8HuJe6Fk32EHTagOCftMNvohkKKeFKP04V//LODf9xosfvHMekBY95D0PDMNOPJGA+
         fOsfOqiaz6eYue6zaO+Z3weVhPtXu4p+3OzM/LilKBvgIdUseLUFKPClkMjSdpyybkNV
         cB4gSOIg807VSGs6srQIBuyXBkiVym4Xz0aLaRW5WuLFRkT+RzLcOzJDBiHuZ0RD80/a
         7dMvvTO1FoRlYutOfjX4t1JbCo0Mm3uWsRDKLuX18VgQwEzl1rMrQgeuhiGJK15An/q8
         uIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724918854; x=1725523654;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXvClmAij1L1JVrPb3Y+ThrTxtkUcnsEqbcNJq45kWA=;
        b=InIJ1whV7LKRMzEBEHkUXnIZ8aZ1iMb0obSY64YIFpLaA6WRyQA4uSQwLf/Ge2kU1o
         +c+t/+SeP8+Jymo+R9c21j1/XfXfW80FRO/pBOXdYHh78nyKL4fVptmKsDdwqMAmqLFV
         rBBNxvWWQV8BfR/sFdnTZXqUECNKm4yDfeTdu/bAPJOojQ763bPVSxGP9Ddf3jW7XWDq
         VJC1mQtkFc4ct5SPu+A4nJNTSeGLZOQgK+nXc/l+DOQsjNFPJCNyCDdN4jakl55VS5Ap
         1LI4+p7X/CXqpaTA0IvwpmCL6fvuKSK8oyYcLO0DN6vzSm/N5Bm4HnkE2BFuYNcShfgr
         1J+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3+f7If5EFF+t0HtmHabcKVINr0zsKVoDf80+LFsgldqJH1x8pHom7vWFCBFi9LnxibSxKVMnk0VJ3Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5Z813F8jVvF6WIfurZMdGLW6lMn3xhxh7GknK6aQSeo6fd65
	fzPtdI3Hm09/dTXHRPIuVnnO8A+1dMnMS0F2ynRgugj3giyqJIueejpT97lkUg==
X-Google-Smtp-Source: AGHT+IFUSVbVLMuBqYsYJmxwJ/WBiZsUfZKt1gLKSFrMdL/2uNQ2Dg4lweTg36h9vyeT+RpNkIVrzg==
X-Received: by 2002:a17:902:e80c:b0:202:2f24:1445 with SMTP id d9443c01a7336-2050c3cd55fmr21900525ad.33.1724918853258;
        Thu, 29 Aug 2024 01:07:33 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051554541fsm6229705ad.228.2024.08.29.01.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:07:32 -0700 (PDT)
Date: Thu, 29 Aug 2024 01:07:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Andrew Morton <akpm@linux-foundation.org>
cc: Hugh Dickins <hughd@google.com>, willy@infradead.org, david@redhat.com, 
    wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com, 
    21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, 
    ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com, 
    p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] mm: filemap: use xa_get_order() to get the swap
 entry order
In-Reply-To: <3c020874-4cf3-418c-b89b-4e6ed158e5b9@linux.alibaba.com>
Message-ID: <c336e6e4-da7f-b714-c0f1-12df715f2611@google.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com> <6876d55145c1cc80e79df7884aa3a62e397b101d.1723434324.git.baolin.wang@linux.alibaba.com> <d3dc75e2-40a7-8439-734c-19d83707164c@google.com>
 <3c020874-4cf3-418c-b89b-4e6ed158e5b9@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Aug 2024, Baolin Wang wrote:
> On 2024/8/26 05:55, Hugh Dickins wrote:
> > On Mon, 12 Aug 2024, Baolin Wang wrote:
> > 
> >> In the following patches, shmem will support the swap out of large folios,
> >> which means the shmem mappings may contain large order swap entries, so
> >> using xa_get_order() to get the folio order of the shmem swap entry to
> >> update the '*start' correctly.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>   mm/filemap.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/mm/filemap.c b/mm/filemap.c
> >> index 4130be74f6fd..4c312aab8b1f 100644
> >> --- a/mm/filemap.c
> >> +++ b/mm/filemap.c
> >> @@ -2056,6 +2056,8 @@ unsigned find_get_entries(struct address_space
> >> *mapping, pgoff_t *start,
> >>     folio = fbatch->folios[idx];
> >>     if (!xa_is_value(folio))
> >>   			nr = folio_nr_pages(folio);
> >> +		else
> >> +			nr = 1 << xa_get_order(&mapping->i_pages,
> >> indices[idx]);
> >>    	*start = indices[idx] + nr;
> >>    }
> >>    return folio_batch_count(fbatch);
> >> @@ -2120,6 +2122,8 @@ unsigned find_lock_entries(struct address_space
> >> *mapping, pgoff_t *start,
> >>     folio = fbatch->folios[idx];
> >>     if (!xa_is_value(folio))
> >>   			nr = folio_nr_pages(folio);
> >> +		else
> >> +			nr = 1 << xa_get_order(&mapping->i_pages,
> >> indices[idx]);
> >>    	*start = indices[idx] + nr;
> >>    }
> >>    return folio_batch_count(fbatch);
> >> -- 
> > 
> > Here we have a problem, but I'm not suggesting a fix for it yet: I
> > need to get other fixes out first, then turn to thinking about this -
> > it's not easy.
> 
> Thanks for raising the issues.
> 
> > 
> > That code is almost always right, so it works well enough for most
> > people not to have noticed, but there are two issues with it.
> > 
> > The first issue is that it's assuming indices[idx] is already aligned
> > to nr: not necessarily so.  I believe it was already wrong in the
> > folio_nr_pages() case, but the time I caught it wrong with a printk
> > was in the swap (value) case.  (I may not be stating this correctly:
> > again more thought needed but I can't spend so long writing.)
> > 
> > And immediately afterwards that kernel build failed with a corrupted
> > (all 0s) .o file - I'm building on ext4 on /dev/loop0 on huge tmpfs while
> > swapping, and happen to be using the "-o discard" option to ext4 mount.
> > 
> > I've been chasing these failures (maybe a few minutes in, maybe half an
> > hour) for days, then had the idea of trying without the "-o discard":
> > whereupon these builds can be repeated successfully for many hours.
> > IIRC ext4 discard to /dev/loop0 entails hole-punch to the tmpfs.
> > 
> > The alignment issue can easily be corrected, but that might not help.
> > (And those two functions would look better with the rcu_read_unlock()
> > moved down to just before returning: but again, wouldn't really help.)
> > 
> > The second issue is that swap is more slippery to work with than
> > folios or pages: in the folio_nr_pages() case, that number is stable
> > because we hold a refcount (which stops a THP from being split), and
> > later we'll be taking folio lock too.  None of that in the swap case,
> > so (depending on how a large entry gets split) the xa_get_order() result
> > is not reliable. Likewise for other uses of xa_get_order() in this series.
> 
> Now we have 2 users of xa_get_order() in this series:
> 
> 1) shmem_partial_swap_usage(): this is acceptable, since racy results are not
> a problem for the swap statistics.

Yes: there might be room for improvement, but no big deal there.

> 
> 2) shmem_undo_range(): when freeing a large swap entry, it will use
> xa_cmpxchg_irq() to make sure the swap value is not changed (in case the large
> swap entry is split). If failed to cmpxchg, then it will use current index to
> retry in shmem_undo_range(). So seems not too bad?

Right, I was missing the cmpxchg aspect. I am not entirely convinced of
the safety in proceeding in this way, but I shouldn't spread FUD without
justification. Today, no yesterday, I realized what might be the actual
problem, and it's not at all these entry splitting races I had suspected.

Fix below.  Successful testing on mm-everything-2024-08-24-07-21 (well,
that minus the commit which spewed warnings from bootup) confirmed it.
But testing on mm-everything-2024-08-28-21-38 very quickly failed:
unrelated to this series, presumably caused by patch or patches added
since 08-24, one kind of crash on one machine (some memcg thing called
from isolate_migratepages_block), another kind of crash on another (some
memcg thing called from __read_swap_cache_async), I'm exhausted by now
but will investigate later in the day (or hope someone else has).

[PATCH] mm: filemap: use xa_get_order() to get the swap entry order: fix

find_lock_entries(), used in the first pass of shmem_undo_range() and
truncate_inode_pages_range() before partial folios are dealt with, has
to be careful to avoid those partial folios: as its doc helpfully says,
"Folios which are partially outside the range are not returned".  Of
course, the same must be true of any value entries returned, otherwise
truncation and hole-punch risk erasing swapped areas - as has been seen.

Rewrite find_lock_entries() to emphasize that, following the same pattern
for folios and for value entries.

Adjust find_get_entries() slightly, to get order while still holding
rcu_read_lock(), and to round down the updated start: good changes, like
find_lock_entries() now does, but it's unclear if either is ever important.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/filemap.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 885a8ed9d00d..88a2ed008474 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2047,10 +2047,9 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		if (!folio_batch_add(fbatch, folio))
 			break;
 	}
-	rcu_read_unlock();
 
 	if (folio_batch_count(fbatch)) {
-		unsigned long nr = 1;
+		unsigned long nr;
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
@@ -2058,8 +2057,10 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 			nr = folio_nr_pages(folio);
 		else
 			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
-		*start = indices[idx] + nr;
+		*start = round_down(indices[idx] + nr, nr);
 	}
+	rcu_read_unlock();
+
 	return folio_batch_count(fbatch);
 }
 
@@ -2091,10 +2092,17 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 
 	rcu_read_lock();
 	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
+		unsigned long base;
+		unsigned long nr;
+
 		if (!xa_is_value(folio)) {
-			if (folio->index < *start)
+			nr = folio_nr_pages(folio);
+			base = folio->index;
+			/* Omit large folio which begins before the start */
+			if (base < *start)
 				goto put;
-			if (folio_next_index(folio) - 1 > end)
+			/* Omit large folio which extends beyond the end */
+			if (base + nr - 1 > end)
 				goto put;
 			if (!folio_trylock(folio))
 				goto put;
@@ -2103,7 +2111,19 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 				goto unlock;
 			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
 					folio);
+		} else {
+			nr = 1 << xa_get_order(&mapping->i_pages, xas.xa_index);
+			base = xas.xa_index & ~(nr - 1);
+			/* Omit order>0 value which begins before the start */
+			if (base < *start)
+				continue;
+			/* Omit order>0 value which extends beyond the end */
+			if (base + nr - 1 > end)
+				break;
 		}
+
+		/* Update start now so that last update is correct on return */
+		*start = base + nr;
 		indices[fbatch->nr] = xas.xa_index;
 		if (!folio_batch_add(fbatch, folio))
 			break;
@@ -2115,17 +2135,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 	}
 	rcu_read_unlock();
 
-	if (folio_batch_count(fbatch)) {
-		unsigned long nr = 1;
-		int idx = folio_batch_count(fbatch) - 1;
-
-		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio))
-			nr = folio_nr_pages(folio);
-		else
-			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
-		*start = indices[idx] + nr;
-	}
 	return folio_batch_count(fbatch);
 }
 
-- 
2.35.3


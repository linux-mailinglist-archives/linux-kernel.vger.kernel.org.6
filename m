Return-Path: <linux-kernel+bounces-221928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6FD90FABD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82798B2191B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E27DD531;
	Thu, 20 Jun 2024 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyw6vWj0"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8CBA42;
	Thu, 20 Jun 2024 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718845411; cv=none; b=S6g3P2kBUAnU+4FdFxp1GxQDWBLladKBSVa7cTjtxv5krqqyMA3fFJ6w9EhvsWM6kSRNAp6OmIZ6O3zDtTNtM8AoOAU+5OLWYPwvSKRHSka1kY+J9TLjYOfNchNMqgYzfCeT6FspcxzB01yJbezVoLhFe7oXnI3c2dgJZndeiQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718845411; c=relaxed/simple;
	bh=+a0baQ4eH8AAE5Qmin8BcQVjVDIGRXY73C1U63ljAWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr7LyvKs4+0FkdYBfGr0u+PsNtJnqQpwCoNaeDO3z6QhYInasUgIKP8L84kj/62dewgsM4ooVcq4Pjn0WbRWEEMe+GAfFZdm+IWDob+X2rW5LTgM+xldh7ZHFSbc+Eieg2w5s4Yvtg3s0UZe1q+D38sgxWnJMJ7aWN3Pddyh02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyw6vWj0; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62fe76c0a61so12158837b3.0;
        Wed, 19 Jun 2024 18:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718845409; x=1719450209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhWxKolSYbWNcrT/1SveOjzmHhN+xyIexXLfZ7wMR/8=;
        b=Cyw6vWj0aD8eQ9FPALfniYadBgu1B7myyMpe8fpbOUKIFi+cUaVAOx5NZcxreJJMaR
         EBYJtmW0qr1cCAxRN2eF5iH64ziODqN66dIu+GBsphBVJUS+MiBhtbZ6vKqttHjRgZaJ
         tKrXPtW29IahHfxlDJ8Ph+wo83QrO6FouJKQIDAKov67EDP8QmuxTMC1Pu34W1Tb2i0a
         bcMTVkjFeBqkrV2frSXUcpepI2kmXirHV6i4eTCauyRmXRIATGtWdMBSClbNMKAgAmm4
         exWWZhwIGP7YrVu+FwB4S4lo1Q38QkkK7T70sJhtBXELNuezR8xOdrMZPV+FgRxysb7/
         DVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718845409; x=1719450209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhWxKolSYbWNcrT/1SveOjzmHhN+xyIexXLfZ7wMR/8=;
        b=VyyYsNCM0503RpTvoIyh8YTtn1ISPwVx6VRQinBxebTk/Sy/tRpvjdZS1ZIccuNaDJ
         pS/A8+9KKARtGys6HGhyHG5HY19P5jSYmTVpyabVDzaDl/vLBwR+hNv8xa9wd/hDbvDY
         OULzDAh4Yeq7fT3wIrYHY4Xfy7rn2TdfKN9Y5x60/ioBiSyvzTCmeK/neiomnTRPPuBh
         If9p/1n8yen0veASA/WSZjt2DYhxRmm7C6DP0KSZMPh7BbiThQgR1hlo/RdFg1ge2X2R
         uLCUh4i4twEWwt+gVsEte3NqgVrdtA53utst2UqweZDc/80WUzrc9pTK8HJH6YQIrGjC
         aFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/zPDCr65lb1ZYznsGRgg7KWKdW61LL+WZmwSnW58B87hCBZQDL5lqytxTgK6eYOe1AE5sBVdaZhMZEoOe69VytZvOxXTsxmKO+lpJCqWnDIi4V2FeyWxVSvzSSBYNOci8julFi3Kl
X-Gm-Message-State: AOJu0YznM0H81iiV2smU2R/05C8qv91DUrle0FC51ICTsT1NBtIIH4+o
	9YStzag/57r+qs5vP4+0TU9j4Ua7rQGR1epQXu73TV5n3Xmg8+JHHLq8EWWo2ifaVNCjPOCcnJL
	wSRvQYPb+WV61xHkJfyl6IsUSOIQ=
X-Google-Smtp-Source: AGHT+IH98WYwGefTTl8Sq0i5gl8rM6kdrUFsndm+3ob135vkAeO2h0wlD/gE2lCgv3fq1T5ehBdoD+4FqsTfaVylBI8=
X-Received: by 2002:a05:6902:1081:b0:dff:3215:3d20 with SMTP id
 3f1490d57ef6-e02bdf5eb3emr3430660276.0.1718845408759; Wed, 19 Jun 2024
 18:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <CAKEwX=PsmuPQUvrsOO7a+JGd=gDmjP5_XDGD+z-0R6dBea+BOg@mail.gmail.com>
 <CAPpoddcgmZs6=s1MrzLgOAJxoVW5_bLa4CGxHq3KhF3GOi8VBw@mail.gmail.com> <CAJD7tkYD+y54-KYEotWspRdNL_AC0SxE147tR+dSLvY-=9jJyg@mail.gmail.com>
In-Reply-To: <CAJD7tkYD+y54-KYEotWspRdNL_AC0SxE147tR+dSLvY-=9jJyg@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Thu, 20 Jun 2024 10:03:17 +0900
Message-ID: <CAPpodddcGsK=0Xczfuk8usgZ47xeyf4ZjiofdT+ujiyz6V2pFQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mm: zswap: global shrinker fix and proactive shrink
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Sorry for the late reply. I am currently investigating a
responsiveness issue I found while benchmarking with this series,
possibly related to concurrent zswap writeback and pageouts.

This series cannot be applied until the root cause is identified,
unfortunately. Thank you all for taking the time to review.

The responsiveness issue was confirmed with 6.10-rc2 with all 3
patches applied. Without patch 3, it still happens but is less likely.

When allocating much larger memory than zswap can buffer, and
writeback and rejection by pool_limit_hit happen simultaneously, the
system stops responding. I do not see this freeze when zswap is
disabled or when there is no pool_limit_hit. The proactive shrinking
itself seems to work as expected as long as the writeback and pageout
do not occur simultaneously.

I suspect this issue exists in current code but was not visible
without this series since the global shrinker did not writeback
considerable amount of pages.


2024=E5=B9=B46=E6=9C=8815=E6=97=A5(=E5=9C=9F) 7:48 Nhat Pham <nphamcs@gmail=
.com>:
>
> BTW, I'm curious. Have you experimented with increasing the pool size?
> That 20% number is plenty for our use cases, but maybe yours need a
> different cap?
>

Probably we can allocate a bit more zswap pool size. But that will
keep more old pages once the pool limit is hit. If we can ensure no
pool limit hits and zero writeback by allocating more memory, I will
try the same amount of zramswap.

> Also, have you experimented with the dynamic zswap shrinker? :) I'm
> actually curious how it works out in the small machine regime, with
> whatever workload you are running.
>

It seems the dynamic shrinker is trying to evict all pages. That does
not fit to my use case that prefer balanced swapin and swapout
performance


2024=E5=B9=B46=E6=9C=8815=E6=97=A5(=E5=9C=9F) 9:20 Yosry Ahmed <yosryahmed@=
google.com>:
> >
> > 1.
> > The visible issue is that pageout/in operations from active processes
> > are slow when zswap is near its max pool size. This is particularly
> > significant on small memory systems, where total swap usage exceeds
> > what zswap can store. This means that old pages occupy most of the
> > zswap pool space, and recent pages use swap disk directly.
>
> This should be a transient state though, right? Once the shrinker
> kicks in it should writeback the old pages and make space for the hot
> ones. Which takes us to our next point.
>
> >
> > 2.
> > This issue is caused by zswap keeping the pool size near 100%. Since
> > the shrinker fails to shrink the pool to accept_thr_percent and zswap
> > rejects incoming pages, rejection occurs more frequently than it
> > should. The rejected pages are directly written to disk while zswap
> > protects old pages from eviction, leading to slow pageout/in
> > performance for recent pages on the swap disk.
>
> Why is the shrinker failing? IIUC the first two patches fixes two
> cases where the shrinker stumbles upon offline memcgs, or memcgs with
> no zswapped pages. Are these cases common enough in your use case that
> every single time the shrinker runs it hits MAX_RECLAIM_RETRIES before
> putting the zswap usage below accept_thr_percent?
>
> This would be surprising given that we should be restarting the
> shrinker with every swapout attempt until we can accept pages again.
>
> I guess one could construct a malicious case where there are some
> sticky offline memcgs, and all the memcgs that actually have zswap
> pages come after it in the iteration order.
>
> Could you shed more light about this? What does the setup look like?
> How many memcgs there are, how many of them use zswap, and how many
> offline memcgs are you observing?
>

Example from ubuntu 22.04 using zswap:
root@ctl:~# find /sys/fs/cgroup/ -wholename
\*service/memory.zswap.current | xargs grep . | wc
     31      31    2557
root@ctl:~# find /sys/fs/cgroup/ -wholename
\*service/memory.zswap.current | xargs grep ^0 | wc
     11      11     911

This indicates 11 out of 31 services have no pages in zswap. Without
patch 2, shrink_worker() aborts shrinking in the second tree walk,
before evicting about 40 pages from the services. The number varies,
but I think it is common to see a few memcg that has no zswap pages

> I am not saying we shouldn't fix these problems anyway, I am just
> trying to understand how we got into this situation to begin with.
>
> >
> > 3.
> > If the pool size were shrunk proactively, rejection by pool limit hits
> > would be less likely. New incoming pages could be accepted as the pool
> > gains some space in advance, while older pages are written back in the
> > background. zswap would then be filled with recent pages, as expected
> > in the LRU logic.
>
> I suspect if patches 1 and 2 fix your problem, the shrinker invoked
> from reclaim should be doing this sort of "proactive shrinking".
>
> I agree that the current hysteresis around accept_thr_percent is not
> good enough, but I am surprised you are hitting the pool limit if the
> shrinker is being run during reclaim.
>
> >
> > Patch 1 and 2 make the shrinker reduce the pool to accept_thr_percent.
> > Patch 3 makes zswap_store trigger the shrinker before reaching the max
> > pool size. With this series, zswap will prepare some space to reduce
> > the probability of problematic pool_limit_hit situation, thus reducing
> > slow reclaim and the page priority inversion against LRU.
> >
> > 4.
> > Once proactive shrinking reduces the pool size, pageouts complete
> > instantly as long as the space prepared by shrinking can store the
> > direct reclaim. If an admin sees a large pool_limit_hit, lowering
> > accept_threshold_percent will improve active process performance.
>
> I agree that proactive shrinking is preferable to waiting until we hit
> pool limit, then stop taking in pages until the acceptance threshold.
> I am just trying to understand whether such a proactive shrinking
> mechanism will be needed if the reclaim shrinker for zswap is being
> used, how the two would work together.

For my workload, the dynamic shrinker (reclaim shrinker) is disabled.
The proposed global shrinker and the existing dynamic shrinker are
both proactive, but their goals are different.

The global shrinker starts shrinking when the zswap pool exceeds
accept_thr_percent + 1%, then stops when it reaches
accept_thr_percent. Pages below accept_thr_percent are protected from
shrinking.

The dynamic shrinker starts shrinking based on memory pressure
regardless of the zswap pool size, and stops when the LRU size is
reduced to 1/4. Its goal is to wipe out all pages from zswap. It
prefers swapout performance only.

I think the current LRU logic decreases nr_zswap_protected too quickly
for my workload. In zswap_lru_add(), nr_zswap_protected is reduced to
between 1/4 and 1/8 of the LRU size. Although zswap_folio_swapin()
increments nr_zswap_protected when page-ins of evicted pages occur
later, this technically has no effect while reclaim is in progress.

While zswap_store() and zswap_lru_add() are called, the dynamic
shrinker is likely running due to the pressure. The dynamic shrinker
reduces the LRU size to 1/4, and then a few subsequent zswap_store()
calls reduce the protected count to 1/4 of the LRU size. The stored
pages will be reduced to zero through a few shrinker_scan calls.


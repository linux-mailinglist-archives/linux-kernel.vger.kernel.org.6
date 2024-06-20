Return-Path: <linux-kernel+bounces-223634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EF39115CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C69C1F239DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540513D278;
	Thu, 20 Jun 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6S3uP6t"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A55FEE4;
	Thu, 20 Jun 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923534; cv=none; b=qId7xZ5X8Pq2K0UqfX1keZdG3vx9vtCiplon4JPELXu/yrAaEVHiyoutMidyLAxEH5WAbHaAcLr1vEHrcVNKNCBq0cbXfu9eOlKOMwVe06/7rfQaM2jv2sDF/yBZzps0Z4ZKi3euUy1DmJrtfJu+zMDX5kP1BcB/URDG/mWx+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923534; c=relaxed/simple;
	bh=QW6EneRYCvq4hKgo60WKJgekOPm3qGdx/dlnJ0LDfPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHdyD8fSyRq52/hvVgHmGoabt+eC+QX1JyHm5UXCvC++RYz6CwKytsmTMwV9/DSMTafVm3fqSB+oNHveeQqer3GFkg3akGjITpW5ShUVopfARIkExTBjoHeOr5DqlIplugnKPTEvPHecMvigBz7eIjQU25GA5UK6mRSgsa4Q+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6S3uP6t; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79bc769b014so79738685a.1;
        Thu, 20 Jun 2024 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718923530; x=1719528330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnmrlYlrxRh9vivFD+6NtUoULUx1ZAai45xa/zONLMY=;
        b=E6S3uP6t9oxqbb9AL6IhuODAzsSIKKLR4AkYihOTQ1wRAPb34qvhGrMa0k0pJtIjJ0
         4Wg3SOGTGxECQvZgDm+47bwHi/sOBgh6f5IFnDBOb3G6fqdNfkYE1oU2QxH52zVd+F5K
         BV4Laph3DPuG5jPJs/JP49O4Av7sV1tVTRWa1KscEDeypv5ZasNMFKvRWJ13dDovrXVS
         TX8Vyyc5oOLBwxkrDG5fmdIsiwvtJbn0Ye9yEj271lK98VmDnBOlpg6XcurS/1G102ov
         uEAzwPespRIpK/RnZNPbCqWgz14LttBXL7STd+xqhj4poluThhDn5iFubujD6OcOOooQ
         Kh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718923530; x=1719528330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnmrlYlrxRh9vivFD+6NtUoULUx1ZAai45xa/zONLMY=;
        b=HTW30hl5FnEdMljYRwoIFveL0HtkdSWVNsmgG3SGlYxPJGnivwx0ytBZnLHedLhsQ7
         dXrXTDSx9bKAkA8UEljIQw1F9u7ycqXxpSA1l1sxBZRLFxhoceU9upzbqojbDrmS9Tzn
         DJ7pch+93p6P40EQ4eReiyM+pXLN1W4lBEYNVBuHT3S4g4zdgJ56ef8v4UnXQ3mprDBm
         OZgdFrshGQDiHEIUTEgv9MAaTOQZfSKVbuGrxIRjGpzoXyGWoXR5tVA6q5uQqFEcyv9L
         0Ef1qJzyMZNUt4Vt0c6XqVD+bsdJZm6CKkPr0wp5HOLmpC30ltKDfofi2pEqZW+b6Aja
         8P7g==
X-Forwarded-Encrypted: i=1; AJvYcCV9pU7TItQhZJPG/i4OkmUkju4UeDbgaKS/HubrrtBCUhHykuKOl7FzivhRhTrFVG/odQevCd9t47lrWjJshqiKLqXDpnDoOAbvLN5Db3Zva2UB3BmPNKc1cXabWgGfIr7gPL8ly19X
X-Gm-Message-State: AOJu0Yzc1TQ237ZwH3ciTrFYbPoytZTitJdboT3GYFbGtP1e3nqR0CNU
	LhxhBJ3LpHmH/UTQVJnQujuLTZBCQTStFbj93A0saFc7ILK4coMKe3jJzn5nt7Evon2ZL4UWD38
	VrjeeeI8ryB/ognz8D48xLL4lAmA=
X-Google-Smtp-Source: AGHT+IHUHiKhuO3lflJiK1mEtBHHQQANwPa3f18lchzyH5vGRdVxN8b4X5W0wRN32prRqb0Z1SVcif1uQeeWXATBtg8=
X-Received: by 2002:ad4:420c:0:b0:6b2:b997:6513 with SMTP id
 6a1803df08f44-6b5019b852emr115022296d6.7.1718923530320; Thu, 20 Jun 2024
 15:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <CAKEwX=PsmuPQUvrsOO7a+JGd=gDmjP5_XDGD+z-0R6dBea+BOg@mail.gmail.com>
 <CAPpoddcgmZs6=s1MrzLgOAJxoVW5_bLa4CGxHq3KhF3GOi8VBw@mail.gmail.com>
 <CAJD7tkYD+y54-KYEotWspRdNL_AC0SxE147tR+dSLvY-=9jJyg@mail.gmail.com> <CAPpodddcGsK=0Xczfuk8usgZ47xeyf4ZjiofdT+ujiyz6V2pFQ@mail.gmail.com>
In-Reply-To: <CAPpodddcGsK=0Xczfuk8usgZ47xeyf4ZjiofdT+ujiyz6V2pFQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 20 Jun 2024 15:45:17 -0700
Message-ID: <CAKEwX=NFAh95smCyJidENLytQjU8xDbosqahM6OOzYrnmJ5ojg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 6:03=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> Hello,
>
> Sorry for the late reply. I am currently investigating a
> responsiveness issue I found while benchmarking with this series,
> possibly related to concurrent zswap writeback and pageouts.
>
> This series cannot be applied until the root cause is identified,
> unfortunately. Thank you all for taking the time to review.
>
> The responsiveness issue was confirmed with 6.10-rc2 with all 3
> patches applied. Without patch 3, it still happens but is less likely.
>
> When allocating much larger memory than zswap can buffer, and
> writeback and rejection by pool_limit_hit happen simultaneously, the
> system stops responding. I do not see this freeze when zswap is
> disabled or when there is no pool_limit_hit. The proactive shrinking
> itself seems to work as expected as long as the writeback and pageout
> do not occur simultaneously.
>
> I suspect this issue exists in current code but was not visible
> without this series since the global shrinker did not writeback
> considerable amount of pages.
>
>
> 2024=E5=B9=B46=E6=9C=8815=E6=97=A5(=E5=9C=9F) 7:48 Nhat Pham <nphamcs@gma=
il.com>:
> >
> > BTW, I'm curious. Have you experimented with increasing the pool size?
> > That 20% number is plenty for our use cases, but maybe yours need a
> > different cap?
> >
>
> Probably we can allocate a bit more zswap pool size. But that will
> keep more old pages once the pool limit is hit. If we can ensure no
> pool limit hits and zero writeback by allocating more memory, I will
> try the same amount of zramswap.
>
> > Also, have you experimented with the dynamic zswap shrinker? :) I'm
> > actually curious how it works out in the small machine regime, with
> > whatever workload you are running.
> >
>
> It seems the dynamic shrinker is trying to evict all pages. That does
> not fit to my use case that prefer balanced swapin and swapout
> performance

Hmm not quite. As you have noted earlier, it (tries to) shrink the
unprotected pages only,

>
>
> 2024=E5=B9=B46=E6=9C=8815=E6=97=A5(=E5=9C=9F) 9:20 Yosry Ahmed <yosryahme=
d@google.com>:
> > >
> > > 1.
> > > The visible issue is that pageout/in operations from active processes
> > > are slow when zswap is near its max pool size. This is particularly
> > > significant on small memory systems, where total swap usage exceeds
> > > what zswap can store. This means that old pages occupy most of the
> > > zswap pool space, and recent pages use swap disk directly.
> >
> > This should be a transient state though, right? Once the shrinker
> > kicks in it should writeback the old pages and make space for the hot
> > ones. Which takes us to our next point.
> >
> > >
> > > 2.
> > > This issue is caused by zswap keeping the pool size near 100%. Since
> > > the shrinker fails to shrink the pool to accept_thr_percent and zswap
> > > rejects incoming pages, rejection occurs more frequently than it
> > > should. The rejected pages are directly written to disk while zswap
> > > protects old pages from eviction, leading to slow pageout/in
> > > performance for recent pages on the swap disk.
> >
> > Why is the shrinker failing? IIUC the first two patches fixes two
> > cases where the shrinker stumbles upon offline memcgs, or memcgs with
> > no zswapped pages. Are these cases common enough in your use case that
> > every single time the shrinker runs it hits MAX_RECLAIM_RETRIES before
> > putting the zswap usage below accept_thr_percent?
> >
> > This would be surprising given that we should be restarting the
> > shrinker with every swapout attempt until we can accept pages again.
> >
> > I guess one could construct a malicious case where there are some
> > sticky offline memcgs, and all the memcgs that actually have zswap
> > pages come after it in the iteration order.
> >
> > Could you shed more light about this? What does the setup look like?
> > How many memcgs there are, how many of them use zswap, and how many
> > offline memcgs are you observing?
> >
>
> Example from ubuntu 22.04 using zswap:
> root@ctl:~# find /sys/fs/cgroup/ -wholename
> \*service/memory.zswap.current | xargs grep . | wc
>      31      31    2557
> root@ctl:~# find /sys/fs/cgroup/ -wholename
> \*service/memory.zswap.current | xargs grep ^0 | wc
>      11      11     911
>
> This indicates 11 out of 31 services have no pages in zswap. Without
> patch 2, shrink_worker() aborts shrinking in the second tree walk,
> before evicting about 40 pages from the services. The number varies,
> but I think it is common to see a few memcg that has no zswap pages
>
> > I am not saying we shouldn't fix these problems anyway, I am just
> > trying to understand how we got into this situation to begin with.
> >
> > >
> > > 3.
> > > If the pool size were shrunk proactively, rejection by pool limit hit=
s
> > > would be less likely. New incoming pages could be accepted as the poo=
l
> > > gains some space in advance, while older pages are written back in th=
e
> > > background. zswap would then be filled with recent pages, as expected
> > > in the LRU logic.
> >
> > I suspect if patches 1 and 2 fix your problem, the shrinker invoked
> > from reclaim should be doing this sort of "proactive shrinking".
> >
> > I agree that the current hysteresis around accept_thr_percent is not
> > good enough, but I am surprised you are hitting the pool limit if the
> > shrinker is being run during reclaim.
> >
> > >
> > > Patch 1 and 2 make the shrinker reduce the pool to accept_thr_percent=
.
> > > Patch 3 makes zswap_store trigger the shrinker before reaching the ma=
x
> > > pool size. With this series, zswap will prepare some space to reduce
> > > the probability of problematic pool_limit_hit situation, thus reducin=
g
> > > slow reclaim and the page priority inversion against LRU.
> > >
> > > 4.
> > > Once proactive shrinking reduces the pool size, pageouts complete
> > > instantly as long as the space prepared by shrinking can store the
> > > direct reclaim. If an admin sees a large pool_limit_hit, lowering
> > > accept_threshold_percent will improve active process performance.
> >
> > I agree that proactive shrinking is preferable to waiting until we hit
> > pool limit, then stop taking in pages until the acceptance threshold.
> > I am just trying to understand whether such a proactive shrinking
> > mechanism will be needed if the reclaim shrinker for zswap is being
> > used, how the two would work together.
>
> For my workload, the dynamic shrinker (reclaim shrinker) is disabled.
> The proposed global shrinker and the existing dynamic shrinker are
> both proactive, but their goals are different.
>
> The global shrinker starts shrinking when the zswap pool exceeds
> accept_thr_percent + 1%, then stops when it reaches
> accept_thr_percent. Pages below accept_thr_percent are protected from
> shrinking.
>
> The dynamic shrinker starts shrinking based on memory pressure
> regardless of the zswap pool size, and stops when the LRU size is
> reduced to 1/4. Its goal is to wipe out all pages from zswap. It
> prefers swapout performance only.
>
> I think the current LRU logic decreases nr_zswap_protected too quickly
> for my workload. In zswap_lru_add(), nr_zswap_protected is reduced to
> between 1/4 and 1/8 of the LRU size. Although zswap_folio_swapin()
> increments nr_zswap_protected when page-ins of evicted pages occur
> later, this technically has no effect while reclaim is in progress.
>
> While zswap_store() and zswap_lru_add() are called, the dynamic
> shrinker is likely running due to the pressure. The dynamic shrinker
> reduces the LRU size to 1/4, and then a few subsequent zswap_store()
> calls reduce the protected count to 1/4 of the LRU size. The stored
> pages will be reduced to zero through a few shrinker_scan calls.

Ah this is a fair point. We've been observing this in
production/experiments as well - there's seems to be a positive
correlation between zswpout rate and zswap_written_back rate. Whenever
there's a spike in zswpout, you also see a spike in writtenback pages
too - looks like the flood of zswpout weaken zswap's lru protection,
which is not quite the intended effect.

We're working to improve this situation. We have a couple of ideas
floating around, none of which are too complicated to implement, but
need experiments to validate before sending upstream :)


Return-Path: <linux-kernel+bounces-266731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F9940602
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A825D1F23918
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44E914831F;
	Tue, 30 Jul 2024 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NNFOrEik"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61C22315
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310779; cv=none; b=UMiw1keFc8o2TGxepDQVLHPRlw5gdTUcX+BX2UMPZZUWJ4GmQVGEs3mkt9FjOOsxmHkbwaSzgm7s36yA8EYc0U4V6L5S1FGo8eR1x5hhvj/TH7tCYgYgw2WElngArsAQgL6eo9hnMW2zYxVHpkVVMJIID/mMTPCvHxC8GIdPkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310779; c=relaxed/simple;
	bh=7aOycTC2Sm16z6l9xat6JtE1zwINkNKHiPO+gWwNdSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faP9ZSLSL2u1llY8gdMARuvY6p6ueIj4Pb9rO76iDuLi9ITKf0mC95cN3EszDx6ant4k4hKjj2CFwdjo6y5fPGSjuI3QxFsOOppWSpxXk4U5wtwO/5AItJyc/hrdbvf+BWxK8U9KwC+mcCJvSmGiylCFzF7RedZnOhHD1/iCHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NNFOrEik; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7a0ef0dfcso22592716d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722310775; x=1722915575; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fmUkdyMiuUGo/jhP6zW85emotRS/41cjiPX/2udCqHg=;
        b=NNFOrEikB4wcHnTW/nz4+Hw6Yi/OYb6uJo2W8N44YuZC2rs8/7GtPzWew2rTAkdgtl
         2fvhu9DcdZFNcN/Iwog1bWwISXR9AhHi1qPu+/JIYtrVmCLB1aY/RfqIw1elBfquMTCA
         AKsbA52oOY8lNNblJJJJ5zfVtYlI5dO9OFOwytmyPps7rQvb2AtERLQ9NxKf9EMxwB5A
         coArraETtqvvB6mPICB+L0j2yE8WO+32FFELS8zDsg6Vfgy59V0AlKay/R+Eeluc5KVg
         L72rrVY0YWpI/WQ2ykcJfzQ7ONzYzXKbTOjUVZ+ekZPimkjxm8rmngDgNXFo57e3rHF3
         vaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722310775; x=1722915575;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmUkdyMiuUGo/jhP6zW85emotRS/41cjiPX/2udCqHg=;
        b=FvmHDuDmJDvDQIu0QDCDwOLfaRpyV4EaoxHUtoqBPisQFnkLerFYxwa3dSq3ToePHV
         YFa5N0/PhuIqOBN1PpL4rqkpGvZM/2dOWk7GpJfGYqWUex3YNITbshWSQoy/xlvWZptH
         MGzDmQb9cCLxO2O9UI8+/9H4XTvUe6y0U1NgHYiwpGxMqAy9caX/3MYG/+eqpwch+ol5
         vS6pvFCdYhfTom5ZpVS9V7jIf8vwIl1QqRNtLdlE9RLLHQS3joWQEQ0Y8zsawAeJEL22
         8C5PyN6KROdpCyu+By9HhFNRxVDIhq9tDi5BOlSaKVuCJNIY9X/lcxvWkMte3Ta6GzQr
         9Amg==
X-Forwarded-Encrypted: i=1; AJvYcCV/nmfDknW8bOF0bqWqkFlR759cqcZLeB5tgqrpI55sM4gIAxnfOLemLogkE9YTznhViNb+KycPw2MOVvOQuLWB44D88fiVp0neRJ4v
X-Gm-Message-State: AOJu0YwBkBIKs7pj4JwQK9TnLAHpCIXQmCrzmL8UTh29mLOjWLZ2FV8E
	CCIqS2oe2+pJpEHomiBQ2StV7cvHjTlz/NQctsc5bZpu2GZCFW774GTzZl5Nrpc=
X-Google-Smtp-Source: AGHT+IFuzlTSw7d9MNyYAga3U32REepEaANOkKDahwecQ2OxWx4SqDhJ3yJ/ZuuKFSJZoYn+mZq2NA==
X-Received: by 2002:a05:6214:2527:b0:6b5:6a1:f89a with SMTP id 6a1803df08f44-6bb55977e17mr105020936d6.2.1722310774757;
        Mon, 29 Jul 2024 20:39:34 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d81d7sm59017836d6.1.2024.07.29.20.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 20:39:34 -0700 (PDT)
Date: Mon, 29 Jul 2024 23:39:29 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	shakeelb@google.com, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, flintglass@gmail.com
Subject: Re: [PATCH 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
Message-ID: <20240730033929.GB2866591@cmpxchg.org>
References: <20240725232813.2260665-1-nphamcs@gmail.com>
 <20240725232813.2260665-2-nphamcs@gmail.com>
 <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com>

On Fri, Jul 26, 2024 at 02:58:14PM -0700, Yosry Ahmed wrote:
> On Thu, Jul 25, 2024 at 4:28 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > Current zswap shrinker's heursitics to prevent overshrinking is brittle
> > and inaccurate, specifically in the way we decay the protection size
> > (i.e making pages in the zswap LRU eligible for reclaim).
> 
> Thanks for working on this and experimenting with different
> heuristics. I was not a huge fan of these, so I am glad we are trying
> to replace them with something more intuitive.
> 
> >
> > We currently decay protection aggressively in zswap_lru_add() calls.
> > This leads to the following unfortunate effect: when a new batch of
> > pages enter zswap, the protection size rapidly decays to below 25% of
> > the zswap LRU size, which is way too low.
> >
> > We have observed this effect in production, when experimenting with the
> > zswap shrinker: the rate of shrinking shoots up massively right after a
> > new batch of zswap stores. This is somewhat the opposite of what we want
> > originally - when new pages enter zswap, we want to protect both these
> > new pages AND the pages that are already protected in the zswap LRU.
> >
> > Replace existing heuristics with a second chance algorithm
> >
> > 1. When a new zswap entry is stored in the zswap pool, its reference bit
> >    is set.
> > 2. When the zswap shrinker encounters a zswap entry with the reference
> >    bit set, give it a second chance - only flips the reference bit and
> >    rotate it in the LRU.
> > 3. If the shrinker encounters the entry again, this time with its
> >    reference bit unset, then it can reclaim the entry.
> 
> At the first look, this is similar to the reclaim algorithm. A
> fundamental difference here is that the reference bit is only set
> once, when the entry is created. It is different from the conventional
> second chance page reclaim/replacement algorithm.
> 
> What this really does, is that it slows down writeback by enforcing
> that we need to iterate entries exactly twice before we write them
> back. This sounds a little arbitrary and not very intuitive to me.

This isn't different than other second chance algorithms. Those
usually set the reference bit again to buy the entry another round. In
our case, another reference causes a zswapin, which removes the entry
from the list - buying it another round. Entries will get reclaimed
once the scan rate catches up with the longest reuse distance.

The main goal, which was also the goal of the protection math, is to
slow down writebacks in proportion to new entries showing up. This
gives zswap a chance to solve memory pressure through compression. If
memory pressure persists, writeback should pick up.

If no new entries were to show up, then sure, this would be busy
work. In practice, new entries do show up at a varying rate. This all
happens in parallel to anon reclaim, after all. The key here is that
new entries will be interleaved with rotated entries, and they consume
scan work! This is what results in the proportional slowdown.

> Taking a step back, what we really want is to writeback zswap entries
> in order, and avoid writing back more entries than needed. I think the
> key here is "when needed", which is defined by how much memory
> pressure we have. The shrinker framework should already be taking this
> into account.
> 
> Looking at do_shrink_slab(), in the case of zswap (seek = 2),
> total_scan should boil down to:
> 
> total_scan = (zswap_shrinker_count() * 2 + nr_deferred) >> priority
> 
> , and this is bounded by zswap_shrinker_count() * 2.
> 
> Ignoring nr_deferred, we start by scanning 1/2048th of
> zswap_shrinker_count() at DEF_PRIORITY, then we work our way to 2 *
> zswap_shrinker_count() at zero priority (before OOMs). At
> NODE_RECLAIM_PRIORITY, we start at 1/8th of zswap_shrinker_count().
> 
> Keep in mind that zswap_shrinker_count() does not return the number of
> all zswap entries, it subtracts the protected part (or recent swapins)
> and scales by the compression ratio. So this looks reasonable at first
> sight, perhaps we want to tune the seek to slow down writeback if we
> think it's too much, but that doesn't explain the scenario you are
> describing.
> 
> Now let's factor in nr_deferred, which looks to me like it could be
> the culprit here. I am assuming the intention is that if we counted
> freeable slab objects before but didn't get to free them, we should do
> it the next time around. This feels like it assumes that the objects
> will remain there unless reclaimed by the shrinker. This does not
> apply for zswap, because the objects can be swapped in.

Hm.

_count() returns (objects - protected) * compression_rate, then the
shrinker does the >> priority dance. So to_scan is expected to be a
small portion of unprotected objects.

_scan() bails if to_scan > (objects - protected).

How often does this actually abort in practice?

> Also, in the beginning, before we encounter too many swapins, the
> protection will be very low, so zswap_shrinker_count() will return a
> relatively high value. Even if we don't scan and writeback this
> amount, we will keep carrying this value forward in next reclaim
> operations, even if the number of existing zswap entries have
> decreased due to swapins.
> 
> Could this be the problem? The number of deferred objects to be
> scanned just keeps going forward as a high value, essentially
> rendering the heuristics in zswap_shrinker_count() useless?
> 
> If we just need to slow down writeback by making sure we scan entries
> twice, could something similar be achieved just by tuning the seek
> without needing any heuristics to begin with?

Seek is a fixed coefficient for the scan rate.

We want to slow writeback when recent zswapouts dominate the zswap
pool (expanding or thrashing), and speed it up when recent entries
make up a small share of the pool (stagnating).

This is what the second chance accomplishes.


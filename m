Return-Path: <linux-kernel+bounces-266550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79F940183
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E312835D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97718EFC0;
	Mon, 29 Jul 2024 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPmGthKi"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0463D9E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294456; cv=none; b=L09EFp1iKhj0G47xewo7dJaQYHf6K5N0I5I2jYd0WqcnY58OxTpBPRDH1c9wkOfcXaJ/CLVLifGIuteTpYrIbMV5dAW44DPlAnGoeBIpkmUcDngq08Fbw8UdvZSEsuOCjXyUEARSswwWfqGAS4gOwdE6ZjX+JOgU1YcCfZEv/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294456; c=relaxed/simple;
	bh=2Bmjqgz5gHjtmWNU0OAXtyQ0ok/NvIic4SUNNEJnbZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Euhe895s7tF4LXFvokrszhb56vM98yV3J56RKittg6d72ebO11Q7QaYbh/p1yRx6DlQtXPlEEJDe1NzOkvsWUmYUJH+jTC53zaY1ryBtPfAfL85zVNFMoD5e16xyyhRZJn3ngqN7EOuW20PSPw/Hku/+9XXorKATHzYHfdqpIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPmGthKi; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b797fb1c4aso27046836d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722294453; x=1722899253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydYJtvQrJ/JfGQyZJdwtEdgizH4szpD5fm9hX5jFpLI=;
        b=XPmGthKiBDDdfCb8ReCBhN/PF9dIKmbcj7aJ5fFlW7Sm1MAZXxPap9vnIsSB4B4+fo
         iLmK9PcGrZglIgnAlJ9sD9L0kfsomI0pdGCPwWLiKtPkhu6D+0Y8dH4AEd0M7dqpiJuR
         lXbq9/YqBMgRAj6Uebjga7ZQlms8aJCSXxV3ab8s93vacWCOsvfFiGk+mKvO6PO7W/Hn
         c+9RV/TxzUq3Mi/wwomVD5SER/KU8eOaVxPfIyC7r1g1K3fFa29Y9oaxyNX5LI4JkbI/
         taTto7kkbYRfZIZaWvmpYUzXBD4iiG06r/HqPuCsoaSPHGbE1L78bOj5Eg0klRLUUOj4
         QZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722294453; x=1722899253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydYJtvQrJ/JfGQyZJdwtEdgizH4szpD5fm9hX5jFpLI=;
        b=F0XSkSaeUsBtu6S3zjLwBOsWgk1l2eAl40KpwVWRBd6R9dnQcs8NKBfkUuh6v/g4hr
         PuUbtGWqyjW0vo6cEkpZWfNtniVw5vBdcY0j7sNzGEfewghGkrB4s/0yDHtJsfAXGbTL
         ww1Yij61kWKp50n6NTdqSCFNeD/jOz4K1xpSAH1srbbaTKny/9RBpdJp3T6YqFJ9ZCUj
         kFbpEJytDon6x95EMXPJanV2h/5GwFEQSxLgfVz2rYa82Imq82sSiBcnj9eJlc1CgdiA
         72w/VwrriEMKMHNpKYZLQ/6R6EOGsxbbKTotve4SeYK3KIzg31JX33VcHVDXPGsCNXxQ
         chAA==
X-Forwarded-Encrypted: i=1; AJvYcCVWS0WWMXDO8xb7SuCRqojt4PZORbX4wD7uipsODa8UxJM66x3ZsEeD8DanucpNkMnHTiMVnh/rtf1GV/vQs33Z62Xz5Er6tsjk8v4H
X-Gm-Message-State: AOJu0YyWH0wqFGkM5t74RL3myHL1YQWWCqhCuN4/jgvCrCHDifYf/e+t
	rcQ9NCu++ndsvQqzu02aWEr+bdoFyfBQLQgGkqa8SY1U9ZP/DoG64J3+tCkmk3IpY6bjmun/I5G
	1C1mslJ5MzXwzQjSI6I7rY2rKj3xuALKyi1k=
X-Google-Smtp-Source: AGHT+IHOPg/Ri1+4pMqwSj3cDIRMulNPnDlt3ExA3ddX4BIn7ofVWEaNOH6/OH0ycQh6LYFuv5kZshgiy2Tl2GqUddI=
X-Received: by 2002:a05:6214:2502:b0:6b2:b4d2:984d with SMTP id
 6a1803df08f44-6bb559b814fmr157542716d6.15.1722294453134; Mon, 29 Jul 2024
 16:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725232813.2260665-1-nphamcs@gmail.com> <20240725232813.2260665-2-nphamcs@gmail.com>
 <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com>
In-Reply-To: <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 29 Jul 2024 16:07:19 -0700
Message-ID: <CAKEwX=PsqfYcfwzuhdx-hzHXE7cujf7DQT8vcN7v_M0gOb1uPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 2:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Jul 25, 2024 at 4:28=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > Current zswap shrinker's heursitics to prevent overshrinking is brittle
> > and inaccurate, specifically in the way we decay the protection size
> > (i.e making pages in the zswap LRU eligible for reclaim).
>
> Thanks for working on this and experimenting with different
> heuristics. I was not a huge fan of these, so I am glad we are trying
> to replace them with something more intuitive.

That is certainly the intention :) I'm not a huge fan of those
heuristics either - they seem fairly brittle and arbitrary to me even
back then (as you have pointed out).

>
> >
> > We currently decay protection aggressively in zswap_lru_add() calls.
> > This leads to the following unfortunate effect: when a new batch of
> > pages enter zswap, the protection size rapidly decays to below 25% of
> > the zswap LRU size, which is way too low.
> >
> > We have observed this effect in production, when experimenting with the
> > zswap shrinker: the rate of shrinking shoots up massively right after a
> > new batch of zswap stores. This is somewhat the opposite of what we wan=
t
> > originally - when new pages enter zswap, we want to protect both these
> > new pages AND the pages that are already protected in the zswap LRU.
> >
> > Replace existing heuristics with a second chance algorithm
> >
> > 1. When a new zswap entry is stored in the zswap pool, its reference bi=
t
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

I suppose, yeah. We no longer have non-exclusive loading (in most
scenarios), so the reference bit is only set once, on store attempt.

The interpretation/justification is still there though (somewhat). We
are still giving each object another "chance" to stay in the zswap
pool, in case it is needed soon, before it is reclaimed.

> Taking a step back, what we really want is to writeback zswap entries
> in order, and avoid writing back more entries than needed. I think the
> key here is "when needed", which is defined by how much memory
> pressure we have. The shrinker framework should already be taking this
> into account.
>
> Looking at do_shrink_slab(), in the case of zswap (seek =3D 2),
> total_scan should boil down to:
>
> total_scan =3D (zswap_shrinker_count() * 2 + nr_deferred) >> priority
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

Note that this "protection" decays rather aggressively with zswap
stores. From zswap_lru_add():

new =3D old > lru_size / 4 ? old / 2 : old;

IOW, if the protection size exceeds 25% lru_size, half it. A couple of
zswap_stores() could easily slash this to 25% of the LRU (or even
below) rapidly.

I guess I can fiddle with this decaying attempt + decouple the
decaying from storing (i.e moving it somewhere else). But any formula
I can come up with (another multiplicative factor?) seems as arbitrary
as this formula, and any places that I place the decaying could
potentially couple two actions, which lead to unintended effect.

The second chance algorithm creates a similar two-section LRU
configuration as the old scheme - protected/unprotected (or, analogous
to the page reclaim algorithm, active/inactive). However, it bypasses
the need for such an artificially constructed formula, which you can
think of as the rate of objects aging. It naturally ties the aging of
objects (i.e moving the objects from one section to another) in the
zswap pool with memory pressure, which makes sense to me, FWIW.

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
>
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

Interesting theory. I wonder if I can do some tracing to investigate
this (or maybe just spam trace_printk() lol).

But yeah, this nr_deferred part seems suspicious. The number of
freeable objects returned by the shrinker_count() function (at least
the one implemented by zswap) doesn't really track which object is
newly freeable since the last shrinker_count() invocation. So an
object can be accounted for in a previous invocation, fail to be
reclaimed in that invocation yet still count towards future shrinker
invocation? That sounds wrong :) Even without zswapin, that's still
double counting, no? Future shrinker_count() call will still consider
the previously-failed-to-reclaim object. Do other shrinkers somehow
track the objects that have been accounted for in previous shrinker
attempts, and use this in the freeable computation?

That said, how bad it is in practice depends on the rate of reclaim
failure, since the nr_deferred only increments when we fail to scan.
Which is actually not very high - for instance, this is the statistics
from a couple of my benchmark runs (using the old zswap shrinker
protection scheme, i.e the status quo):

/sys/kernel/debug/zswap/reject_reclaim_fail:292
/sys/kernel/debug/zswap/written_back_pages:6947364

IIRC, exclusive loading really lowers the number of reclaim rejection
(you're less likely to observe a page that is already loaded into
memory and in swap cache - its zswap entry is already invalidated).

This could be a problem, and probably should be fixed (for instance,
by adding a no-defer mode for shrinkers similar to zswap), but there
seems to be an additional/orthogonal reason for overshrinking.

>
> If we just need to slow down writeback by making sure we scan entries
> twice, could something similar be achieved just by tuning the seek
> without needing any heuristics to begin with?

Ah but this is a good point. My only defence for not using seek would
be I have no clue how to interpret the seek value :) Based on the
documentation:

int seeks; /* seeks to recreate an obj */

So I'm guessing this sorta kinda represents the number of disk seeks
(or IO?) required to reconstruct the object. Which makes sense in the
special case of 0. But it seems really arbitrary otherwise -
DEFAULT_SEEKS is 2, but zswap does not really take 2 seeks/IOs to
reconstruct the object, no?

It might have been different in the past - I don't know the historical
context here. But now, I guess this is just a shorthand for writeback
pace. The second chance algorithm has a (nominal) justification that
backs it, even though in effect it's the same.

But yeah, if we only think about actual effects, perhaps we don't even
need the reference bit manipulation - just halving the writeback pace
by half is good enough. There might be some differences with
non-exclusive loading, but now that's gone (for the most part). The
other difference I can think of is in the aging-reclaiming ordering:

1. With the reference bit scheme, shrinkers will age the entire LRU
before reclaiming anything (due to LRU rotation).
2. WIth increasing seek value, we will start reclaiming right away
(albeit half of our old pace).

Average reclaim rate should stay the same, but the former gives the
objects on the zswap pool more chance to be loaded into main memory at
the beginning. Or maybe I'm overthinking this and it doesn't really
matter - benchmarking time? :)

>
> I am just trying to understand if the main problem is that zswap does
> not fit well into the shrinker framework as it is, and how we can
> improve this.

Agree. Another potential problem is under highly concurrent settings,
we can have many shrinker instances hitting the same zswap LRU. And
since the protection mechanism is racy/best-effort at best, we can
easily write back well into the protection area.

I was seriously considering physically separating the protected
(active) and unprotected (inactive) LRUs for zswap, but the second
chance algorithm seems a natural way to implement this separation, and
plays quite well with the current shrinker framework - aging and
reclaiming are all serialized via the lru lock.

> Just to be clear, I am in favor of changing those heuristics to
> something more intuitive and simpler, but I really want to understand
> what is going on. The approach taken by this patch is definitely
> simpler, but it doesn't feel more intuitive to me (at least not yet).

Thanks, yeah I agree. I was actually thinking that the second chance
algorithm would be a bit more natural than some protection decaying
formulae I pull out of thin air, but perhaps there are still problems
with it.

> If we take this approach, this needs to be placed in the hole after
> the length, to avoid increasing the size of the zswap_entry.

Very good point - I was actually thinking about this the other day,
but somehow forgot to fix it before submission :) I'll fix this.


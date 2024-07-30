Return-Path: <linux-kernel+bounces-266581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837F9401E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCCF1F231A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4E63D;
	Tue, 30 Jul 2024 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHqC+DUZ"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199C173
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722298047; cv=none; b=Oa0eCIWJp7TuCX90j6dfX73pLb6falD2vtt34HUpxn0PpeD+tkjbziV6HW53bTH35pIJ/JbOxuS//zixhhIkn2D6b4rczet0aGfTVkl192K+LYAL5f5u9xX2QMhLHe9cGAgsogKFubKJBpIYkBqAJdrguF6zGk/jFSBt5zWAE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722298047; c=relaxed/simple;
	bh=B33/YuoiL8rxG5Bqra5dd9P7mGRGdEG/VQEkbK1XJSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eX2/vQqMICG+XMcXwlD5U8t71I26lHQh+L11T78Jj0cSZgMPuE24GoS5sabMGXo2Gu0NIszD3UIJA/BDPv3QskG0rsC4w6uubnOjCR8r+iiPb7WCimjiiJdyI9YoZUF+TtlCcuRQWT3auyr/BjWs2Q4J57Rhtd6a0lLUPcwDl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHqC+DUZ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d984ed52so221485885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722298044; x=1722902844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf58E/eylA0+2Cy7cmMYdD/Le/LOPNLJjLq0qHzbTiU=;
        b=GHqC+DUZpaaehfi4qiLjD9FKjcfEi18+K/VPNp7p/JJ6fo1Gs/WKtY/s279Byt0Ad+
         75y6l2mVxhe4n7mXE7KrTm+4qlgta7wIAZ3RlUOORRw8OtbzTz7ftHAqH/ENLzNzIpmz
         QmiSaOKsgD9SA9Jq2CHvD2tnF3RFgqjqUd8j2VSAAgltPo0UsTSwpKIWYwBBy33eyrBw
         wl7cqLZV24mZRJzzf7z4D/vsYjaPQHMITy0C2MG2CKn6DHDalM7KPPNrYgzO5bGfJS9q
         aGB5rh4xUT3xFldT73F3UoUgxd+VyrGAy0LlKkAloxvwip5B2TKuC2as5djHeAGMLr45
         oDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722298044; x=1722902844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uf58E/eylA0+2Cy7cmMYdD/Le/LOPNLJjLq0qHzbTiU=;
        b=HM3YWG83yVI1/VOeidburkJSqHJkJVZEhzfPEONBFibN9G8/K6SxPMVVie0qNVHXFD
         tS7bVMfNGhkMzwSs8mXx0SY5OSzFioUFQYhlfH2Z19iKi8RLVnVq92O9rANHSJThBF6N
         V2Ow0eInXgROfcQmuloM/5tzK4mJZe4B3DHYczGP3cjBmke0l3Tocvk1hz1Xz4ZpRmaI
         WNmTlOLDRxCOzuEjXI5zYRb/Gy1EI+A9ltHv1Q8rl5fqCi173vM3n5Eholq3Ov7KebHe
         cGqmybr4f5j5wmBftOQLh+javocVrU3pPN1DuLZK4j9a6LHfrnw/TWv/S0+zsj6hctWG
         AZ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOcfHqY6WhkhDO7ioLIUhnOrQoNGjvq+5RFRMWH6e30JaMn6MDdfTtw11pBE65DpwEvcXnMWWVhClln+rbmid+gwq6rnRa4imFantx
X-Gm-Message-State: AOJu0YxmcfAqkRzCfd+WSwN1S0jphpBW2phfKWL8MienTb3tfEk3n48l
	hs90uTmaSRcOfdk8nWT1kPBY/bvrxGgSePFXfv61ySS1pvnB5NRT3YmldYa1i1UR2ZI9spTamlu
	9PCOx55Bx7hy8zi5MlHTZZnYq+q8=
X-Google-Smtp-Source: AGHT+IHUvUYEC6/5IYxB+EFnDlJ5wjo4798gdsIFS7DehCwH06pIHxknwUGmC/f0V3bf/SUX6+cBePrbRiSC6XprFss=
X-Received: by 2002:a05:6214:2609:b0:6b7:ad38:2df3 with SMTP id
 6a1803df08f44-6bb55aa5049mr110889266d6.39.1722298044131; Mon, 29 Jul 2024
 17:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725232813.2260665-1-nphamcs@gmail.com> <20240725232813.2260665-2-nphamcs@gmail.com>
 <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com> <CAKEwX=PsqfYcfwzuhdx-hzHXE7cujf7DQT8vcN7v_M0gOb1uPA@mail.gmail.com>
In-Reply-To: <CAKEwX=PsqfYcfwzuhdx-hzHXE7cujf7DQT8vcN7v_M0gOb1uPA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 29 Jul 2024 17:07:11 -0700
Message-ID: <CAKEwX=PvmTugsswpLhM=Fxhc1Su036oqHtWjwCQ0bF4Ed5tuvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 4:07=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Fri, Jul 26, 2024 at 2:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Jul 25, 2024 at 4:28=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > Current zswap shrinker's heursitics to prevent overshrinking is britt=
le
> > > and inaccurate, specifically in the way we decay the protection size
> > > (i.e making pages in the zswap LRU eligible for reclaim).
> >
> > Thanks for working on this and experimenting with different
> > heuristics. I was not a huge fan of these, so I am glad we are trying
> > to replace them with something more intuitive.
>
> That is certainly the intention :) I'm not a huge fan of those
> heuristics either - they seem fairly brittle and arbitrary to me even
> back then (as you have pointed out).
>
> >
> > >
> > > We currently decay protection aggressively in zswap_lru_add() calls.
> > > This leads to the following unfortunate effect: when a new batch of
> > > pages enter zswap, the protection size rapidly decays to below 25% of
> > > the zswap LRU size, which is way too low.
> > >
> > > We have observed this effect in production, when experimenting with t=
he
> > > zswap shrinker: the rate of shrinking shoots up massively right after=
 a
> > > new batch of zswap stores. This is somewhat the opposite of what we w=
ant
> > > originally - when new pages enter zswap, we want to protect both thes=
e
> > > new pages AND the pages that are already protected in the zswap LRU.
> > >
> > > Replace existing heuristics with a second chance algorithm
> > >
> > > 1. When a new zswap entry is stored in the zswap pool, its reference =
bit
> > >    is set.
> > > 2. When the zswap shrinker encounters a zswap entry with the referenc=
e
> > >    bit set, give it a second chance - only flips the reference bit an=
d
> > >    rotate it in the LRU.
> > > 3. If the shrinker encounters the entry again, this time with its
> > >    reference bit unset, then it can reclaim the entry.
> >
> > At the first look, this is similar to the reclaim algorithm. A
> > fundamental difference here is that the reference bit is only set
> > once, when the entry is created. It is different from the conventional
> > second chance page reclaim/replacement algorithm.
>
> I suppose, yeah. We no longer have non-exclusive loading (in most
> scenarios), so the reference bit is only set once, on store attempt.
>
> The interpretation/justification is still there though (somewhat). We
> are still giving each object another "chance" to stay in the zswap
> pool, in case it is needed soon, before it is reclaimed.
>
> > Taking a step back, what we really want is to writeback zswap entries
> > in order, and avoid writing back more entries than needed. I think the
> > key here is "when needed", which is defined by how much memory
> > pressure we have. The shrinker framework should already be taking this
> > into account.
> >
> > Looking at do_shrink_slab(), in the case of zswap (seek =3D 2),
> > total_scan should boil down to:
> >
> > total_scan =3D (zswap_shrinker_count() * 2 + nr_deferred) >> priority
> >
> > , and this is bounded by zswap_shrinker_count() * 2.
> >
> > Ignoring nr_deferred, we start by scanning 1/2048th of
> > zswap_shrinker_count() at DEF_PRIORITY, then we work our way to 2 *
> > zswap_shrinker_count() at zero priority (before OOMs). At
> > NODE_RECLAIM_PRIORITY, we start at 1/8th of zswap_shrinker_count().
> >
> > Keep in mind that zswap_shrinker_count() does not return the number of
> > all zswap entries, it subtracts the protected part (or recent swapins)
>
> Note that this "protection" decays rather aggressively with zswap
> stores. From zswap_lru_add():
>
> new =3D old > lru_size / 4 ? old / 2 : old;
>
> IOW, if the protection size exceeds 25% lru_size, half it. A couple of
> zswap_stores() could easily slash this to 25% of the LRU (or even
> below) rapidly.
>
> I guess I can fiddle with this decaying attempt + decouple the
> decaying from storing (i.e moving it somewhere else). But any formula
> I can come up with (another multiplicative factor?) seems as arbitrary
> as this formula, and any places that I place the decaying could
> potentially couple two actions, which lead to unintended effect.
>
> The second chance algorithm creates a similar two-section LRU
> configuration as the old scheme - protected/unprotected (or, analogous
> to the page reclaim algorithm, active/inactive). However, it bypasses
> the need for such an artificially constructed formula, which you can
> think of as the rate of objects aging. It naturally ties the aging of
> objects (i.e moving the objects from one section to another) in the
> zswap pool with memory pressure, which makes sense to me, FWIW.
>
> > and scales by the compression ratio. So this looks reasonable at first
> > sight, perhaps we want to tune the seek to slow down writeback if we
> > think it's too much, but that doesn't explain the scenario you are
> > describing.
> >
> > Now let's factor in nr_deferred, which looks to me like it could be
> > the culprit here. I am assuming the intention is that if we counted
> > freeable slab objects before but didn't get to free them, we should do
> > it the next time around. This feels like it assumes that the objects
> > will remain there unless reclaimed by the shrinker. This does not
> > apply for zswap, because the objects can be swapped in.
> >
> > Also, in the beginning, before we encounter too many swapins, the
> > protection will be very low, so zswap_shrinker_count() will return a
> > relatively high value. Even if we don't scan and writeback this
> > amount, we will keep carrying this value forward in next reclaim
> > operations, even if the number of existing zswap entries have
> > decreased due to swapins.
> >
> > Could this be the problem? The number of deferred objects to be
> > scanned just keeps going forward as a high value, essentially
> > rendering the heuristics in zswap_shrinker_count() useless?
>
> Interesting theory. I wonder if I can do some tracing to investigate
> this (or maybe just spam trace_printk() lol).

OK, I found this trace:

sudo echo 1 > /sys/kernel/debug/tracing/events/vmscan/mm_shrink_slab_end/en=
able

I'll give this a shot, and report any interesting findings in the data
collected :)


>
> But yeah, this nr_deferred part seems suspicious. The number of
> freeable objects returned by the shrinker_count() function (at least
> the one implemented by zswap) doesn't really track which object is
> newly freeable since the last shrinker_count() invocation. So an
> object can be accounted for in a previous invocation, fail to be
> reclaimed in that invocation yet still count towards future shrinker
> invocation? That sounds wrong :) Even without zswapin, that's still
> double counting, no? Future shrinker_count() call will still consider
> the previously-failed-to-reclaim object. Do other shrinkers somehow
> track the objects that have been accounted for in previous shrinker
> attempts, and use this in the freeable computation?
>
> That said, how bad it is in practice depends on the rate of reclaim
> failure, since the nr_deferred only increments when we fail to scan.
> Which is actually not very high - for instance, this is the statistics
> from a couple of my benchmark runs (using the old zswap shrinker
> protection scheme, i.e the status quo):
>
> /sys/kernel/debug/zswap/reject_reclaim_fail:292
> /sys/kernel/debug/zswap/written_back_pages:6947364
>
> IIRC, exclusive loading really lowers the number of reclaim rejection
> (you're less likely to observe a page that is already loaded into
> memory and in swap cache - its zswap entry is already invalidated).
>

Actually, on closer inspection, we also increasing the deferred count
when we short-circuit in each of the following scenario:

a) When we disable zswap shrinker or zswap writeback in general. I
don't think this matters too much in practice - we're not reclaiming
here anyway :)
b) When we detect that there are less unprotected objects than the batch si=
ze.

FWIW, the second case also goes away with the new scheme :)

> This could be a problem, and probably should be fixed (for instance,
> by adding a no-defer mode for shrinkers similar to zswap), but there
> seems to be an additional/orthogonal reason for overshrinking.

I can also just implement this and benchmark it :)


Return-Path: <linux-kernel+bounces-268065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E3941FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEB0285AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5A1AA3F7;
	Tue, 30 Jul 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Spe0peT7"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691D1AA3C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365219; cv=none; b=KArYVL7RE/YZW8Ch0y37s2ujB2ulQMzxDqchdFF/5HlulrFohrxvKKaSACgdiAOB41sWauU6TvwYANX4milGJfgBJVH2lVnuzh5mCs4fI39AH/tyyabUTTzoXMbgSvCQatbOkL0XiXpMI8ZbpWx8xreMwXa6gZwmTrAKLoPlNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365219; c=relaxed/simple;
	bh=EEStnciUomi5/VB0dIHAI6oD5AXXvOtuLUCifZvFJuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h76kaW31ErRNlIiJiy+Ev6ExGSRBFAE7utY/x3h99aCgTT3cfzSPcHxCndTEXV+83fa0QS6ZtnO9Y4oTAVWgHq5KyIJN03NxP3mY3t3rJ6T3AF1+YfoKMseNN9Zo8W+3wtBiDRwRhYXackGuaEgt6KWLx3W/ccjVhYZleoTn7vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Spe0peT7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so7243876e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722365216; x=1722970016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVdGunqTifJ0ucf5dI3wogex/JXMYi66FPjHcH+FSlM=;
        b=Spe0peT7khqwJyI2d2EIZ8k37PO2oMIvMIbbz5DFeSivJVLQrpX8rYQTK6kYtTkB0M
         TMukPOLqLxY11Oukd2FNpXYK6rD39sfhsh1GUlzvJLoB//Q60ojoYtPGskpAfvOGVBWu
         a5CFDPdzjhAiivs6WpZ6+jiI8yrEY879UBc0zS6nK1k4n7UU42RJsJbak3NuRkqcveQZ
         HZ20JZUeXTdcuNFva18R6x2nB8yCrXNNgl065X94mr47lYqtV6TlKnQaEM4lTGX9S2O9
         iInXUCHOvY8GQYkCDijVMxJvSxypwbO85Xf7F6gxSazzxLBBIRl0kW4/YVukuNwuylFr
         x5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722365216; x=1722970016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVdGunqTifJ0ucf5dI3wogex/JXMYi66FPjHcH+FSlM=;
        b=RboYNt4VAHrW3gIVTfUdDUoMR22BrEovI9xJ7tO5+Awi4c6aFwU9v6iquSaTEV/n3E
         0ViVD+IrSNsN/lu+ATx7+HZzVeVP9V5cZq/HxGdHY1TTGZzYdQMdeuqvE5XJNld3n53v
         7xQseezkbvBVM/3XwYKnp6E28KrGBoC/3hNJasKJ1BQrHEG5sx+quQCFaN9foIpCNlU+
         UZV24SLJBLxHn+NHTdZXtWpFbBYSSL9R9V5//hch3ULZCpBzbbdX/NnfU9gPTHBdZClV
         Z6fuyBvh1LvL5NKyxkPvTeenQwZ03yvZne+Ll2TVDIpELtfNmFtVB2o64+ImLh4p+43u
         DUOw==
X-Forwarded-Encrypted: i=1; AJvYcCXIAnO1/mCe9IWJfgxYruzuS6VT7q7aJdw3MUyQzCLIBZ+nbvwpsb80KENXwL4MXMhsEvaWjX6OnfStQYNpt31CaNhcwe1rz2AgVyE4
X-Gm-Message-State: AOJu0Yy9LnkUZDLoozfjl7qZMe43GeA0n0GFqeoV9+y6KroYvoL+4OLc
	miIpp0lXKPDVEPwJ+lD37S6ZOoDCnXnMY2kafXsCQBCSGSv7ZuywawND1y9X7oj12oAUFz5+t2d
	k3frFz7xc5X4rW7OBXDnXKy4CwoVIzcqb011Uq/khaSB/5KxFAA==
X-Google-Smtp-Source: AGHT+IEr6GbEIq6h3DhcPrrgRNvxSdc2v8ceb+Op4xbNm+ZPkrMPBmM696siHnXJSv4oWEeDgjPO33WOrGQ3P8breGk=
X-Received: by 2002:a05:6512:2c8b:b0:52c:812b:6e72 with SMTP id
 2adb3069b0e04-5309b259b68mr8215718e87.1.1722365215298; Tue, 30 Jul 2024
 11:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725232813.2260665-1-nphamcs@gmail.com> <20240725232813.2260665-2-nphamcs@gmail.com>
 <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com> <20240730033929.GB2866591@cmpxchg.org>
In-Reply-To: <20240730033929.GB2866591@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 30 Jul 2024 11:46:17 -0700
Message-ID: <CAJD7tka1tPA=qGFJcf4n1MM20A4WoL0cA28jDcyoc0y+48+0bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, shakeelb@google.com, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:39=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Jul 26, 2024 at 02:58:14PM -0700, Yosry Ahmed wrote:
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
> >
> > What this really does, is that it slows down writeback by enforcing
> > that we need to iterate entries exactly twice before we write them
> > back. This sounds a little arbitrary and not very intuitive to me.
>
> This isn't different than other second chance algorithms. Those
> usually set the reference bit again to buy the entry another round. In
> our case, another reference causes a zswapin, which removes the entry
> from the list - buying it another round. Entries will get reclaimed
> once the scan rate catches up with the longest reuse distance.
>
> The main goal, which was also the goal of the protection math, is to
> slow down writebacks in proportion to new entries showing up. This
> gives zswap a chance to solve memory pressure through compression. If
> memory pressure persists, writeback should pick up.
>
> If no new entries were to show up, then sure, this would be busy
> work. In practice, new entries do show up at a varying rate. This all
> happens in parallel to anon reclaim, after all. The key here is that
> new entries will be interleaved with rotated entries, and they consume
> scan work! This is what results in the proportional slowdown.

The fact that in practice there will be new entries showing up because
we are doing anon reclaim is exactly what I had in mind. My point is
that in practice, for most cases, the reference bit could just be
causing a steady slowdown, which can be achieved just by tuning the
seek. But I have a better idea now about what you mean with the
proportional slowdown.

(more below)

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
>
> Hm.
>
> _count() returns (objects - protected) * compression_rate, then the
> shrinker does the >> priority dance. So to_scan is expected to be a
> small portion of unprotected objects.
>
> _scan() bails if to_scan > (objects - protected).
>
> How often does this actually abort in practice?

Good question :)

>
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
> >
> > If we just need to slow down writeback by making sure we scan entries
> > twice, could something similar be achieved just by tuning the seek
> > without needing any heuristics to begin with?
>
> Seek is a fixed coefficient for the scan rate.
>
> We want to slow writeback when recent zswapouts dominate the zswap
> pool (expanding or thrashing), and speed it up when recent entries
> make up a small share of the pool (stagnating).
>
> This is what the second chance accomplishes.

Yeah I am more convinced now, I wanted to check if just tuning the
seek achieves a similar result, but the complexity from the reference
bit is not much anyway -- so maybe it isn't worth it.

I still think the nr_deferred handling in the shrinker framework does
not seem compatible with zswap. Entries could be double counted, and
previously counted entries could go away during swapins. Unless I am
missing something, it seems like the scanning can be arbitrary, and
not truly proportional to the reclaim priority and zswap LRUs size.

I also think it's important to clarify that there are two mechanisms
that control the writeback rate with this patch, the reference bit
proportional slowdown (protecting against writeback of recently
swapped out pages), and nr_swapins protection (feedback from swapins
of recently written back pages).

Maybe we can move things around to make it more obvious how these
mechanisms work hand in hand, or have a comment somewhere describing
the writeback mechanism.


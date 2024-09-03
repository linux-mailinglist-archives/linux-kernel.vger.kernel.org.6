Return-Path: <linux-kernel+bounces-313509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9C696A664
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDDB1C23E97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8AF190660;
	Tue,  3 Sep 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1oqugHx"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551818B47A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387756; cv=none; b=ubA5rAaycdSL8V/o1n+1N61CLDOxNQUK4oAZm0DCpEKW9pYrW+EfY0IZcUJ9N6N2fNdTxn9jaFBsa5H5Bx/5llSesw2MDsMxEivZfEltwqTxTzBCeDyB8gnhY8GG+5GHN7TQ+NPply1MgC0Jor5cwnE8WT+wm+P6dv357g3Kzv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387756; c=relaxed/simple;
	bh=j/AgDVl0aV2X6LZMdYELNpCZVlZJv6m/AJQsX0nCjDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ooh/Crxpczn0V8e5TP4cRWb2rS7qSC3K1enSjJETxwQhI37od72lYsSTq6XeKCBBbYQQR24Lf4J5J8qXEWwc/RmAaNSZCQfAp4mhjB7TrutmOC7fHUKLResSLA974gDYg9xejSUjHpqZZuJ4+K5TL9qAe+iq/ApZBs9MPEWa6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1oqugHx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso2519778a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725387753; x=1725992553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/yp8CiL0UcLnIp52yOcCmHdqZK8t377asrmTXqlCiiw=;
        b=V1oqugHx/IGNXiUWKxfWFv/XHUIsGs4h0f/Ab2u14SLEVWgET/H3gUPty8pRTKH7ql
         MQIywH3og++a3IlrrcJh01x3//1N6uHR7VrKL4JjoE2jRgeYKSiDgJMr9CuwNDNqUxzf
         LMKDjtBSNsoF9yzmrYLtTIR9yHgKXev3bIPamwTDVXyf2F0p21XtJY2mrc59z7gsftjD
         uq3hchWoBwnrIYZKU7BV87YILjIfw82Izz8cywZ3oUrTabu6/ieq1jV6mExLoBMvHQk7
         t1gfov2STRNraZP/Jwi0ImvCKuGAcCnjBA1HGIeYuWOhKfQsgve4nh7lc7aJyc247nbW
         wbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387753; x=1725992553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yp8CiL0UcLnIp52yOcCmHdqZK8t377asrmTXqlCiiw=;
        b=oPHTVu2c71a7c4Pk2C6W3VzlT6OvjPDndYBtByFPY1MnqKgL4wlpf7Hxcac90ALhjq
         7q6bi9eGIJal4HFj0fdFGpcj9CNWvcQ6tANZN1kEHKr7U6xUNWWNQ3BdY52yEirk5hQj
         /UpU7EQvYVGwqqNxkbWkrj3bbuSAqKvzYQAUXGIsd2AVore5WmErKpF0Gz/CSIdU/0Ii
         jDdvw6Hpwt29tOhkR1k8zDpTP7JqDKpVD8AxhoN921S++xF3NLWXekFU9JHYOJv6QN2g
         2pIeDJVCTyaGG18m8/M/GdSxwKZAOIIWb0nfJg8HQwUmW1+XHMUzv6V/9DbbRkJA7Fou
         jRow==
X-Forwarded-Encrypted: i=1; AJvYcCUb988x6znVlplvCwLMzX24hEdZBD8/bP+3GhjZejNuc8nrMlX9kRcBlcZPnymbmArNoHfMIIdbaQobrx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJu30KkVGIMmCJs5HXmwx1wp+vRwBe+L/2JU4GLhxEInNUOgX
	k4KvVaEuVbvUcfNnkgWri63sv0A5iCH+gFRJXw9XX5as9BE9+NgXvqwNq/f5uw6jIYpf483I46A
	PxO/gV5xXEKIiw3rREwfU+PiJHwRgAyWAaQOz
X-Google-Smtp-Source: AGHT+IFHvMdFDKlxIvsbzpLhWEYvw+lnB+wugQBy+pmpBeKazA2M5sczKftzS5aKcLQSx4VQHoiBEHHjijXqEOOgd+k=
X-Received: by 2002:a17:907:7e94:b0:a86:9d14:dbb8 with SMTP id
 a640c23a62f3a-a89b93d6c20mr738280066b.6.1725387751956; Tue, 03 Sep 2024
 11:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
 <20240821054921.43468-1-21cnbao@gmail.com> <CAMgjq7Czvr+PXF7Q5eSChAdmiLH-uvd7HTred63T8JPCCYzTSQ@mail.gmail.com>
 <CAJD7tkYxAUVhvb_khBngRg5d504-KYVbW-v=GNfUPR-6_f-rVQ@mail.gmail.com>
In-Reply-To: <CAJD7tkYxAUVhvb_khBngRg5d504-KYVbW-v=GNfUPR-6_f-rVQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Sep 2024 11:21:56 -0700
Message-ID: <CAJD7tkamz0RHzv3yy7833GhhhBzGB1ozRo085wB4xZjXppEBWg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"

[..]
> > > > > > I am not closely following the latest changes so I am not sure. CCing
> > > > > > folks who have done work in that area recently.
> > > > > >
> > > > > > I am starting to think maybe it would be more reliable to just call
> > > > > > zswap_invalidate() for all freed swap entries anyway. Would that be
> > > > > > too expensive? We used to do that before the zswap_invalidate() call
> > > > > > was moved by commit 0827a1fb143f ("mm/zswap: invalidate zswap entry
> > > > > > when swap entry free"), and that was before we started using the
> > > > > > xarray (so it was arguably worse than it would be now).
> > > > > >
> > > > >
> > > > > That might be a good idea, I suggest moving zswap_invalidate to
> > > > > swap_range_free and call it for every freed slot.
> > > > >
> > > > > Below patch can be squash into or put before "mm: attempt to batch
> > > > > free swap entries for zap_pte_range()".
> > > >
> > > > Hmm, on second thought, the commit message in the attachment commit
> > > > might be not suitable, current zswap_invalidate is also designed to
> > > > only work for order 0 ZSWAP, so things are not clean even after this.
> > >
> > > Kairui, what about the below? we don't touch the path of __try_to_reclaim_swap() where
> > > you have one folio backed?
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index c1638a009113..8ff58be40544 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -1514,6 +1514,8 @@ static bool __swap_entries_free(struct swap_info_struct *si,
> > >         unlock_cluster_or_swap_info(si, ci);
> > >
> > >         if (!has_cache) {
> > > +               for (i = 0; i < nr; i++)
> > > +                       zswap_invalidate(swp_entry(si->type, offset + i));
> > >                 spin_lock(&si->lock);
> > >                 swap_entry_range_free(si, entry, nr);
> > >                 spin_unlock(&si->lock);
> > >
> >
> > Hi Barry,
> >
> > Thanks for updating this thread, I'm thinking maybe something will
> > better be done at the zswap side?
> >
> > The concern of using zswap_invalidate is that it calls xa_erase which
> > requires the xa spin lock. But if we are calling zswap_invalidate in
> > swap_entry_range_free, and ensure the slot is HAS_CACHE pinned, doing
> > a lockless read first with xa_load should be OK for checking if the
> > slot needs a ZSWAP invalidation. The performance cost will be minimal
> > and we only need to call zswap_invalidate in one place, something like
> > this (haven't tested, comments are welcome). Also ZSWAP mthp will
> > still store entried in order 0 so this should be OK for future.
>
>
> While I do agree with this change on a high level, it's essentially
> reverting commit 0827a1fb143f ("mm/zswap: invalidate zswap entry when
> swap entry free") which fixed a small problem with zswap writeback.
> I'd prefer that we don't if possible.
>
> One thing that I always wanted to do is to pull some of the work done
> in swap_entry_range_free() and swap_range_free() before the slots
> caching layer. The memcg uncharging, clearing shadow entries from the
> swap cache, arch invalidation, zswap invalidation, etc. If we can have
> a hook for these pre-free callbacks we can call it for single entries
> before we add them to the slots cache, and call them for the clusters
> as we do today. This should also reduce the amount of work done under
> the lock, and move more work to where the freeing is actually
> happening vs. the cache draining.
>
> I remember discussing this briefly with Ying before. Anyone have any thoughts?

Kairui, Barry, any thoughts on this? Any preferences on how to make
sure zswap_invalidate() is being called in all possible swap freeing
paths?


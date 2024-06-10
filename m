Return-Path: <linux-kernel+bounces-208667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 129079027E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802EF286118
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14100147C85;
	Mon, 10 Jun 2024 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2pKnG6Ge"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A1142E79
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041368; cv=none; b=CdsvLD9XXy9M+LFASVKeiT8KpRU/D9C7k3sWD1opBCINkHLPPnKl5nCqJzvLOkir8nwLR98gqw264X9FDko4QVHh3jxWdQhl8iQNKQvACuwlNBrVEd3PJdtblg99M6hAi0IHyrSNCytOStlUlvc/uNAHbsJbcQqQ+8mS8ey354w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041368; c=relaxed/simple;
	bh=WzkqOv9Qn1MitH0m55OtzLNh3PguHTHqIO3Y2UZcIkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acrleSigsnMZVpm13XKuKVt9odRJt89r/9K9+PiaLvXiJ0ZfvX9nCF540hvpri+9azO1UIdIQnS/ykxDJfmgucNTI40iomP+eEOr7xUIME8XEdBHBfXOS1BnLtanaypd5YsgIHlrG7gGIaXVFs+D72BG9RHFYTcE68jjJagHhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2pKnG6Ge; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f04afcce1so21218666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718041364; x=1718646164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPVtbHVilMLAau0cNSGD+gf6ZMhtpojpd/Id7uBZgUI=;
        b=2pKnG6GeH+rKPRhCcmBMwAgOXY6Wx6TpeP373f9D9Q5gx+7qw1yu2WfqOP+/j5XOpe
         fBHQ43+sFSCk52VWAizah5X60U7dpzBCeyxk+QmWuyLyKnyuAJbCpurH3smyBQtUT6jy
         089qqiCeph2yRKhH+tJGrybgNLW97jTZBwUwRdtwwJ3wL/goJfd9a8/XwDPaCN1kjIqJ
         o7w/f9715Kn9fpWH8hEYZ9FzDHbuAf2NwXrwm7JqyluEHGSAYpR0aTtICCWrz+WWHJdq
         J9pjSrHrQZvi9kMNuJWljEqH9x6OC9E/FfctT6f5nZggEOd1lkHTsWX4zeq+vJR/+/Ey
         gxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718041364; x=1718646164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPVtbHVilMLAau0cNSGD+gf6ZMhtpojpd/Id7uBZgUI=;
        b=bClqcjwfrm84GKKds96oEf0Se8JwPLvifUg+IqYCjiRrzlhWZYw1FBWxNHa59EUsaQ
         bfAmWXxpd3RtRlRny85U50XgS3Ir77v/uW4vj+YfwGDqRhnpEmyW8935PHKu04ITbGPk
         f9I8T27UCe8tOrHlfzsMXutgPd0OfdbsVZc/s1DUA1PX28nFXzYwd+SJ3jEjjcCz4cAh
         45ZugFqLvBnEaixSAuts9uyeVnJ5nC7ZZTa6XjpK1d4cMzY2qEaNgmrtX8MpXvwM4HBo
         vG4X3eiensGAqBt4eR2hRnEZW1dKVntqR//Tk/q9HAO4n6TW0KW7KqmWthf/qJdgE99I
         BFrA==
X-Forwarded-Encrypted: i=1; AJvYcCW6LaJZucc/EPYkLJotw2ESzzF+uVInwvEhllIOXjQO9hPkO/oi71A4cvnoFKf2R2m9hH+rxkAHZWW2l3PFvx1Kmvl1WxXTFPGukFiZ
X-Gm-Message-State: AOJu0YwDPAzOVmmdYdrs4COkqMxgXqDm0HLpSCs269bbgqcIQv3lSQXL
	10XtO3YZ03icrm1JDO0gSWeCJRLgfL0B074isYMF0FzQWlRVEMU/VFQdl7+gee5t2AsZyFxOWhH
	aNQCQp71dTLTsh0AZ+9VQHfGN6ONhet+Tl6jX
X-Google-Smtp-Source: AGHT+IG6K1bGK51cmUt+3hrWMx6GldnLsLDe7xgAvOxfnkcoy5CHJA8UsmQAcM9wSa7WBsw41ULyOob4eHhEvOxcypo=
X-Received: by 2002:a17:906:3da2:b0:a6a:ab5:6f2a with SMTP id
 a640c23a62f3a-a6cd560fe5emr833555666b.11.1718041364229; Mon, 10 Jun 2024
 10:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com> <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com>
In-Reply-To: <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 10:42:05 -0700
Message-ID: <CAJD7tkaHLVcjUgiUFfBK+ztCqxBTRfyVbSVH9vytK=5JYOw+Sw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 9:13=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Sat, Jun 8, 2024 at 10:37=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > Zswap does not support storing or loading large folios. Until proper
> > support is added, attempts to load large folios from zswap are a bug.
> >
> > For example, if a swapin fault observes that contiguous PTEs are
> > pointing to contiguous swap entries and tries to swap them in as a larg=
e
> > folio, swap_read_folio() will pass in a large folio to zswap_load(), bu=
t
> > zswap_load() will only effectively load the first page in the folio. If
> > the first page is not in zswap, the folio will be read from disk, even
> > though other pages may be in zswap.
> >
> > In both cases, this will lead to silent data corruption. Proper support
> > needs to be added before large folio swapins and zswap can work
> > together.
> >
> > Looking at callers of swap_read_folio(), it seems like they are either
> > allocated from __read_swap_cache_async() or do_swap_page() in the
> > SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so
> > everything is fine for now.
> >
> > However, there is ongoing work to add to support large folio swapins
> > [1]. To make sure new development does not break zswap (or get broken b=
y
> > zswap), add minimal handling of incorrect loads of large folios to
> > zswap.
> >
> > First, move the call folio_mark_uptodate() inside zswap_load().
> >
> > If a large folio load is attempted, and any page in that folio is in
> > zswap, return 'true' without calling folio_mark_uptodate(). This will
> > prevent the folio from being read from disk, and will emit an IO error
> > because the folio is not uptodate (e.g. do_swap_fault() will return
> > VM_FAULT_SIGBUS). It may not be reliable recovery in all cases, but it
> > is better than nothing.
> >
> > This was tested by hacking the allocation in __read_swap_cache_async()
> > to use order 2 and __GFP_COMP.
> >
> > In the future, to handle this correctly, the swapin code should:
> > (a) Fallback to order-0 swapins if zswap was ever used on the machine,
> > because compressed pages remain in zswap after it is disabled.
> > (b) Add proper support to swapin large folios from zswap (fully or
> > partially).
> >
> > Probably start with (a) then followup with (b).
> >
> > [1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gma=
il.com/
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >
> > v1: https://lore.kernel.org/lkml/20240606184818.1566920-1-yosryahmed@go=
ogle.com/
> >
> > v1 -> v2:
> > - Instead of using VM_BUG_ON() use WARN_ON_ONCE() and add some recovery
> >   handling (David Hildenbrand).
> >
> > ---
> >  mm/page_io.c |  1 -
> >  mm/zswap.c   | 22 +++++++++++++++++++++-
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index f1a9cfab6e748..8f441dd8e109f 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct sw=
ap_iocb **plug)
> >         delayacct_swapin_start();
> >
> >         if (zswap_load(folio)) {
> > -               folio_mark_uptodate(folio);
> >                 folio_unlock(folio);
> >         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> >                 swap_read_folio_fs(folio, plug);
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index b9b35ef86d9be..ebb878d3e7865 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
> >
> >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >
> > +       /*
> > +        * Large folios should not be swapped in while zswap is being u=
sed, as
> > +        * they are not properly handled. Zswap does not properly load =
large
> > +        * folios, and a large folio may only be partially in zswap.
> > +        *
> > +        * If any of the subpages are in zswap, reading from disk would=
 result
> > +        * in data corruption, so return true without marking the folio=
 uptodate
> > +        * so that an IO error is emitted (e.g. do_swap_page() will sig=
fault).
> > +        *
> > +        * Otherwise, return false and read the folio from disk.
> > +        */
> > +       if (folio_test_large(folio)) {
> > +               if (xa_find(tree, &offset,
> > +                           offset + folio_nr_pages(folio) - 1, XA_PRES=
ENT)) {
> > +                       WARN_ON_ONCE(1);
> > +                       return true;
> > +               }
> > +               return false;
>
> IMHO, this appears to be over-designed. Personally, I would opt to
> use
>
>  if (folio_test_large(folio))
>                return true;

I am sure you mean "return false" here. Always returning true means we
will never read a large folio from either zswap or disk, whether it's
in zswap or not. Basically guaranteeing corrupting data for large
folio swapin, even if zswap is disabled :)

>
> Before we address large folio support in zswap, it=E2=80=99s essential
> not to let them coexist. Expecting valid data by lunchtime is
> not advisable.

The goal here is to enable development for large folio swapin without
breaking zswap or being blocked on adding support in zswap. If we
always return false for large folios, as you suggest, then even if the
folio is in zswap (or parts of it), we will go read it from disk. This
will result in silent data corruption.

As you mentioned before, you spent a week debugging problems with your
large folio swapin series because of a zswap problem, and even after
then, the zswap_is_enabled() check you had is not enough to prevent
problems as I mentioned before (if zswap was enabled before). So we
need stronger checks to make sure we don't break things when we
support large folio swapin.

Since we can't just check if zswap is enabled or not, we need to
rather check if the folio (or any part of it) is in zswap or not. We
can only WARN in that case, but delivering the error to userspace is a
couple of extra lines of code (not set uptodate), and will make the
problem much easier to notice.

I am not sure I understand what you mean. The alternative is to
introduce a config option (perhaps internal) for large folio swapin,
and make this depend on !CONFIG_ZSWAP, or make zswap refuse to get
enabled if large folio swapin is enabled (through config or boot
option). This is until proper handling is added, of course.

>
> > +       }
> > +
> >         /*
> >          * When reading into the swapcache, invalidate our entry. The
> >          * swapcache can be the authoritative owner of the page and
> > @@ -1590,7 +1610,7 @@ bool zswap_load(struct folio *folio)
> >                 zswap_entry_free(entry);
> >                 folio_mark_dirty(folio);
> >         }
> > -
> > +       folio_mark_uptodate(folio);
> >         return true;
> >  }
> >
> > --
> > 2.45.2.505.gda0bf45e8d-goog
> >
>
> Thanks
> Barry


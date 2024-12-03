Return-Path: <linux-kernel+bounces-428753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E172F9E12EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5ADB22E35
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C5154C0B;
	Tue,  3 Dec 2024 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJuBUqqd"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A152B9A2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733204092; cv=none; b=j9kgHdEFxZml/r0XuVe+8IvhoS5rknBm4JEiYrI75fDoPk2WzUeJkxwJNtc6UllZ8X+dwhOEKLgEDJU1gPtPzXNqY0AI7UfI2rYHEQmr/ZOnyQqY9XeoN/3CUxB/54M3gcSGmtLk1GmphRcwJhjv4lxrqj0Gktwt70LFvsQ7Srs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733204092; c=relaxed/simple;
	bh=QSb6sDRxv+4S4xM25Ho10z7tY4yY1I302OHfwwPJnjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G13s2VASJBAdcqy8biDWFZ/lfoSZE6jodcmhXXD0NfE1ezA+GgktK3fgx4tqf64qJIG7Mu/EbGKIqoOeSa1NY/i23LbfONMmySuSD5dmwNPRcmZbeLyD4IYIeBptX8pjzl+pgMR882mqATvdutU0B+nMcfYLgfs5PQ5gad2vmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJuBUqqd; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef4b6719d1so47721247b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 21:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733204090; x=1733808890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJNCj+uh9klufOQ1xByZwnI7VLbBQeWlMH2kBkaAN4M=;
        b=RJuBUqqdQrOt4dNj/GnkTZCdmqGJuoMXAMlH+TtpkNZvzuwptFVHqajCoIHai6RVqN
         GLe+G+NddyNsj+F/gLhFObbA4JGuBr24IMOTi71MGy6OQ0YxAPzQeB7eyhlyh2EkjOro
         vvxksjw9oGv1c8T3K+It8XWcK3QZX8qp9b2EWYa2DEnAig5HKXC2Xt2IVPnCGihJ2JJW
         p9JRsBSM7vbvRlYbuSbnMkH9104zWYEvuwoqK8DvZrEFaO3PDHWpTttt2b9GCvLxclj4
         xX9ay7CFVBnaYeDSu4jQ/gusl6dIq4M+HaPWPyiXRthFKI3imeylYfkW5ydcrgDcESF6
         pR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733204090; x=1733808890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJNCj+uh9klufOQ1xByZwnI7VLbBQeWlMH2kBkaAN4M=;
        b=OkynGJXBGu5Ia59tzJd6i2k+eB7hsh++TDTwgw44R+Cs0GW7EKzAQl2RfXjM1bQ5wh
         lpbhG5B0O58olM3P2dmSAiCSqHn5PlWrD4cXCQUyTKGE4DQoJGTCeENzJ6RbTZ5lSQZ5
         Z/oAs0IcI1e9SLVdPeGc4Ytr5H/0woPRnksMDj1AoJHIiTf7w+gTvTsR2zWxx87zMc+z
         kK7rlRYjgf/Enb3p76pOhUxre7gSmN36JeB5UI9dlUzgyDh3KxJI88+hB4NfMcmV91ff
         O4Ajeu36mhm9O+qL97DsGdqsbXBggXRzFP6i3Lqq/saulQzl++g91k6D+RAV6AEtNcVp
         uZ0Q==
X-Gm-Message-State: AOJu0YySwZQW0bfgzrNfjuiP7jqHeASZR/hriGvoSgXLUk9qBN9ov+Vb
	b9MSwBAJMHEOnxETN09I1vFMWgnKX/llcUGHxV7WvIZvKUxNLNgkYPkpFiHZpOm0DJtuGh1pNEL
	nj80r0+uS6vDXMuplTo2LAhGA8cJUWGPTAtmP
X-Gm-Gg: ASbGncst+L5vv7RLLpUPRS+jmOicrvsaiO0QjYYGxA8qcAJfpMP4ipg7IFW3A4zHMh+
	POP428/lTOW3fxWAnWxq/k2g48/L1
X-Google-Smtp-Source: AGHT+IFVS0+686xfkJkz3Ni0rcQ6kFCbqnTgmutwtLIbKBx85HDDFrnjFwn9cLymCgTplIULZcE8wd1+dj1nwK7xikM=
X-Received: by 2002:a05:690c:9985:b0:6ee:7797:672 with SMTP id
 00721157ae682-6eface05a9emr20561557b3.7.1733204089842; Mon, 02 Dec 2024
 21:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-2-kanchana.p.sridhar@intel.com> <CAJD7tkYZSWL9WQ9X9UMLNTbDcF0hX=t90Ouf22WWHrcUvXyPRg@mail.gmail.com>
 <SJ0PR11MB5678D7B05A23EB9DB9ACC267C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678D7B05A23EB9DB9ACC267C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 21:34:13 -0800
Message-ID: <CAJD7tkZMzHXWDPsAhd+JTm24LfKG+MT+kOm167EjzuYjCiBq5A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm: zswap: Modified zswap_store_page() to process
 multiple pages in a folio.
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 5:13=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Monday, December 2, 2024 11:34 AM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> > usamaarif642@gmail.com; ryan.roberts@arm.com; 21cnbao@gmail.com;
> > akpm@linux-foundation.org; Feghali, Wajdi K <wajdi.k.feghali@intel.com>=
;
> > Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v1 1/2] mm: zswap: Modified zswap_store_page() to
> > process multiple pages in a folio.
> >
> > On Wed, Nov 27, 2024 at 2:53=E2=80=AFPM Kanchana P Sridhar
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > > Modified zswap_store() to store the folio in batches of
> > > SWAP_CRYPTO_BATCH_SIZE pages. Accordingly, refactored
> > zswap_store_page()
> > > into zswap_store_pages() that processes a range of pages in the folio=
.
> > > zswap_store_pages() is a vectorized version of zswap_store_page().
> > >
> > > For now, zswap_store_pages() will sequentially compress these pages w=
ith
> > > zswap_compress().
> > >
> > > These changes are follow-up to code review comments received for [1],=
 and
> > > are intended to set up zswap_store() for batching with Intel IAA.
> > >
> > > [1]: https://patchwork.kernel.org/project/linux-
> > mm/patch/20241123070127.332773-11-kanchana.p.sridhar@intel.com/
> > >
> > > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > > ---
> > >  include/linux/zswap.h |   1 +
> > >  mm/zswap.c            | 154 ++++++++++++++++++++++++----------------=
--
> > >  2 files changed, 88 insertions(+), 67 deletions(-)
> > >
> > > diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> > > index d961ead91bf1..05a81e750744 100644
> > > --- a/include/linux/zswap.h
> > > +++ b/include/linux/zswap.h
> > > @@ -7,6 +7,7 @@
> > >
> > >  struct lruvec;
> > >
> > > +#define SWAP_CRYPTO_BATCH_SIZE 8UL
> > >  extern atomic_long_t zswap_stored_pages;
> > >
> > >  #ifdef CONFIG_ZSWAP
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index f6316b66fb23..b09d1023e775 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1409,78 +1409,96 @@ static void shrink_worker(struct work_struct
> > *w)
> > >  * main API
> > >  **********************************/
> > >
> > > -static ssize_t zswap_store_page(struct page *page,
> > > -                               struct obj_cgroup *objcg,
> > > -                               struct zswap_pool *pool)
> > > +/*
> > > + * Store multiple pages in @folio, starting from the page at index @=
si up to
> > > + * and including the page at index @ei.
> > > + */
> > > +static ssize_t zswap_store_pages(struct folio *folio,
> > > +                                long si,
> > > +                                long ei,
> > > +                                struct obj_cgroup *objcg,
> > > +                                struct zswap_pool *pool)
> > >  {
> > > -       swp_entry_t page_swpentry =3D page_swap_entry(page);
> > > +       struct page *page;
> > > +       swp_entry_t page_swpentry;
> > >         struct zswap_entry *entry, *old;
> > > +       size_t compressed_bytes =3D 0;
> > > +       u8 nr_pages =3D ei - si + 1;
> > > +       u8 i;
> > > +
> > > +       for (i =3D 0; i < nr_pages; ++i) {
> > > +               page =3D folio_page(folio, si + i);
> > > +               page_swpentry =3D page_swap_entry(page);
> > > +
> > > +               /* allocate entry */
> > > +               entry =3D zswap_entry_cache_alloc(GFP_KERNEL,
> > page_to_nid(page));
> > > +               if (!entry) {
> > > +                       zswap_reject_kmemcache_fail++;
> > > +                       return -EINVAL;
> > > +               }
> >
> > I think this patch is wrong on its own, for example if an allocation
> > fails in the above loop we exit without cleaning up previous
> > allocations. I think it's fixed in patch 2 but we cannot introduce
>
> I think there might be a misunderstanding. zswap_store_pages() will
> clean up local resources allocated during an iteration of the for loop,
> upon an error in that iteration. If you see the "goto store_failed" and
> "goto compress_failed" this would explain what I mean. If an allocation
> fails for an iteration, we simply return -EINVAL, and zswap_store()
> will goto the "put_pool" label with "ret" still false, which will delete
> all zswap entries for the folio (allocated up until the error iteration i=
n
> zswap_store_pages(); or potentially already in the xarray).
>
> Hence, there is no bug and each of the two patches are correct by
> themselves AFAICT, but please let me know if I am missing anything. Thank=
s!

Uh yes, the cleanup is in zswap_store().

>
> > bugs in-between patches. I think the helpers in patch 2 don't really
> > help as I mentioned. Please combine the changes and keep them in the
> > main series (unless you have a reason not to).
>
> Sure. As noted in my earlier response to comments received for patch 2,
> I can either inline all iterations or create helpers for all iterations o=
ver
> the pages in a batch. Appreciate your suggestions on which would be a
> better approach.

I think leaving them open-coded will be clearer for now. We can
revisit the code organization later if it gets out of hand.


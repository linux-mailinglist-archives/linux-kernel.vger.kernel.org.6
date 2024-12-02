Return-Path: <linux-kernel+bounces-428265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD09E0C30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BA3164FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108691DE3C0;
	Mon,  2 Dec 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4zCJPSF"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03751DE3BC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167989; cv=none; b=pimr3kHQ8qUo++3wIg5kJxzjquNOJvzRpzwcgf8pnCgWJUsy3utgQB4JQee/I32V4RfRcVlNgQ1XOQ72REcpdN1qsehg+KOR6fRxfUwafieay0AeMqAGGXpU6cO5ZMDuCio7lThlfHclQvwpMHKLL0kQxejmEv0WMggYzGAf9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167989; c=relaxed/simple;
	bh=b6/YuCkPftGoVNH4JHM9NHGaT3knFaDYg30nE2NpkXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnFdgLo3GiLytfNA0UD9hooAac78UDOV2dapAo7QNHZlMDWCVAEBQyT4ggvKkwX3m6m/dkRksSNWC/R/HXQ3IQ5tdZJA4qkTvccYIUhdrlk2zJMmOZlxZ3qVeWwA+lW6UdPG4PwWf/q4nSCTaabPbAraHQY1ifcBHLds0Lxw+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4zCJPSF; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8878ec049so33586626d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733167987; x=1733772787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdtA92Ho53WMr/THBgIAcGsJxtWtxWl/L8Qi6nJCOxQ=;
        b=g4zCJPSFBH/NN1481W+AJhNZ6dGrDcjNerZLWNFBvf5ZncAKmC9jdslnkitM+ZpreK
         gK+AsoEVZyNMiXnBYuF/3015cY51JXH7wNO5eKo8XlM8GxfiAmRAuLFFCNgvPk0QG7Bt
         E9lNxQ8NlwoAaaCoWh7jfZPSzBdnScadMtSqLfdGw9GKet8QYhjYKRs2qzaPOo9dfFzq
         a7hjD0eHmNxYiSJdKqxhcbRaL4m1aRIsRje8gFEhOyr17uo0dkUXEqDprGwX+H7m2Kjk
         XfPejKFkYYJKMwFZvo+raFCXsUvNCplY5XoSJhzgo1fY6Qc3KWgs//nlFv3n9Zdp+NQF
         +ocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167987; x=1733772787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdtA92Ho53WMr/THBgIAcGsJxtWtxWl/L8Qi6nJCOxQ=;
        b=SPHbjnBsx0oeA9oGdJYJtTOiaAgTYbqUSIhukJywVlAMzOFnu8lg2/SXtbF7GqhwjQ
         NTaTOZFGBhK3jvtoW9OLhRJgck6Kz2FyVJFds83eOKd22dTo7YerWM248y2h7zTG3jsn
         orroMjG0UT7BcLltQKZ/sKt4k6aehrZE5JIOL1C36+dvkF2nnmLFOGDr5swezlF0ILpd
         PXqBf7cnSgkB5llFRnSRWn5OZjFzrT+sNb9pKLC45E8hj1qDWkFSix4kdlu1/zjJJhUy
         GDS4pNE6oxMrK7lQuXxb+Ao6oukGNkf5tO6cxv2bzYGUYBHIaTKJzGBSQ9JId5pesRJj
         UV8g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Tomm/nZP/eAo91rjel0EwbdqPXLycFZnqP1Nfi4NhK+uGfisR5rqti+O/UDJLklNRKX+FI2a86EunxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46mbR/FExTszh90jmq0OTEdNgQcwJjx7/QKG/Z507aW3PgV3S
	XhHVLU0AeGdHGj5EloWmJ93GkN8k1oUoKMmxeoOQL++DRPUK/Lfz5f3hINAh0MtuHHJmzqSG9/J
	chPtv7kEoQXpxaEMnSjxe1wG+IOr84kOMDPxz
X-Gm-Gg: ASbGncs7lQIS+InBsXrJBLKJjhdutTnI9F9UDB3ZwzTGLx6+aXSl7dM7wbhqWhJOxEo
	hG5hYvd2sA6+cQYxTgW84aQVa948u
X-Google-Smtp-Source: AGHT+IHY8ctFLgKGLm/LcZcbqEoyVHKHqk9XggBNBWIV+HXSFJn3nG/9pn9Mn2Pgbdd21WF/0O/oEXMiAQhyoAW3hcU=
X-Received: by 2002:a05:6214:c28:b0:6d8:a7e1:e270 with SMTP id
 6a1803df08f44-6d8a7e1e37dmr79457666d6.40.1733167986497; Mon, 02 Dec 2024
 11:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-3-kanchana.p.sridhar@intel.com> <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
In-Reply-To: <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 11:32:30 -0800
Message-ID: <CAJD7tkbPSQguHegkzN65==GHuNN9_RPm1FonnF8Bi=BsQDhxng@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for batching.
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	usamaarif642@gmail.com, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 11:00=E2=80=AFPM Chengming Zhou
<chengming.zhou@linux.dev> wrote:
>
> On 2024/11/28 06:53, Kanchana P Sridhar wrote:
> > In order to set up zswap_store_pages() to enable a clean batching
> > implementation in [1], this patch implements the following changes:
> >
> > 1) Addition of zswap_alloc_entries() which will allocate zswap entries =
for
> >     all pages in the specified range for the folio, upfront. If this fa=
ils,
> >     we return an error status to zswap_store().
> >
> > 2) Addition of zswap_compress_pages() that calls zswap_compress() for e=
ach
> >     page, and returns false if any zswap_compress() fails, so
> >     zswap_store_page() can cleanup resources allocated and return an er=
ror
> >     status to zswap_store().
> >
> > 3) A "store_pages_failed" label that is a catch-all for all failure poi=
nts
> >     in zswap_store_pages(). This facilitates cleaner error handling wit=
hin
> >     zswap_store_pages(), which will become important for IAA compress
> >     batching in [1].
> >
> > [1]: https://patchwork.kernel.org/project/linux-mm/list/?series=3D91193=
5
> >
> > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > ---
> >   mm/zswap.c | 93 +++++++++++++++++++++++++++++++++++++++++------------=
-
> >   1 file changed, 71 insertions(+), 22 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index b09d1023e775..db80c66e2205 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1409,9 +1409,56 @@ static void shrink_worker(struct work_struct *w)
> >   * main API
> >   **********************************/
> >
> > +static bool zswap_compress_pages(struct page *pages[],
> > +                              struct zswap_entry *entries[],
> > +                              u8 nr_pages,
> > +                              struct zswap_pool *pool)
> > +{
> > +     u8 i;
> > +
> > +     for (i =3D 0; i < nr_pages; ++i) {
> > +             if (!zswap_compress(pages[i], entries[i], pool))
> > +                     return false;
> > +     }
> > +
> > +     return true;
> > +}
>
> How about introducing a `zswap_compress_folio()` interface which
> can be used by `zswap_store()`?
> ```
> zswap_store()
>         nr_pages =3D folio_nr_pages(folio)
>
>         entries =3D zswap_alloc_entries(nr_pages)
>
>         ret =3D zswap_compress_folio(folio, entries, pool)
>
>         // store entries into xarray and LRU list
> ```
>
> And this version `zswap_compress_folio()` is very simple for now:
> ```
> zswap_compress_folio()
>         nr_pages =3D folio_nr_pages(folio)
>
>         for (index =3D 0; index < nr_pages; ++index) {
>                 struct page *page =3D folio_page(folio, index);
>
>                 if (!zswap_compress(page, &entries[index], pool))
>                         return false;
>         }
>
>         return true;
> ```
> This can be easily extended to support your "batched" version.
>
> Then the old `zswap_store_page()` could be removed.
>
> The good point is simplicity, that we don't need to slice folio
> into multiple batches, then repeat the common operations for each
> batch, like preparing entries, storing into xarray and LRU list...

+1

Also, I don't like the helpers hiding some of the loops and leaving
others, as Johannes said, please keep all the iteration over pages at
the same function level where possible to make the code clear.

This should not be a separate series too, when I said divide into
chunks I meant leave out the multiple folios batching and focus on
batching pages in a single large folio, not breaking down the series
into multiple ones. Not a big deal tho :)

>
> Thanks.


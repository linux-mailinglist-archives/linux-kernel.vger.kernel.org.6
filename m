Return-Path: <linux-kernel+bounces-282144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E2194E01C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 07:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850262813F2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67517740;
	Sun, 11 Aug 2024 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbFbaMUZ"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2805E56A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723353651; cv=none; b=W4L/3USl4oXDuzCXYaOKThhdsf/MJFKmEzKfADt8pXfMRizJusin0srFRPvmezSsUJx5vRVXx+RboD7NrWPYAM6o2amJDJAUxVGCRsjadTiiLa+QBwo+JhCXh71kVQjWx/tvsSLF/KZrHcLJsYbREDMw1XtRKhrBC8t1FyCaKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723353651; c=relaxed/simple;
	bh=vSAtaYgtzU8WvMzlvCAm+gV1WF/xhjdPrI8JDzfjRY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbICNJjB1yuQ4OMpZO8BURCc5bSqiSCNJ94NJZkJMq06JOJ+73jfXaSi5r62U/T7NtnrR6KUzY5L62PZH6KgOYaU0kyCBvU8bnNNqE5tTwQTaKnzYHUAPOS90hajdqomgpxe0sfKAyZHfyDV41mFQHHYXPprUepCUBjcvMI1BYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbFbaMUZ; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f6ac477ff4so1934494e0c.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 22:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723353648; x=1723958448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RevC54WGHITOMl6WLV6J8Ojm15LinFzCuYl4UNPBWi8=;
        b=DbFbaMUZznr68+Ch70gcSv4QGmj6MuLNeAJzTNsbcP55ee8x2LAoEbqW2Vv2eDXmdU
         EvcJZkJSqAXYl8LgRGwy7RGCjuMC2+jQ6pVX5sxMqqFSyMhVptjqCiLETk7qCOCQvjW+
         tirTiNKEOP/3lTtoYvQ8gSt9ptKqoREjpxU1bFwabim55UXeOFTTGm2zhNKtY193xJ0H
         3N3M3txsf6vQgzN9tHbEyyVVphYnUmT1xjS/rdnGqyih4/ZXPIFGkBBdz5HeOCTdUA8u
         35C/EHGNrFj1oI1nBmxfI3Pz96JT97HIwQtPBd9BiR0kWWxqoa/0lMkIihsjhkwTPo2e
         IdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723353648; x=1723958448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RevC54WGHITOMl6WLV6J8Ojm15LinFzCuYl4UNPBWi8=;
        b=bO7oSXus2icL9UhWiPqGsMsPwYwDVKwNYjoctoArazwYA392/Dfjlw9etCVx3/hg6J
         SldOQMKdmhQEjXCaxCBvBEqupSuiKHktYRpyBOb0H8pRsBa/0HGwpf/AKJqtDicJHrTg
         1avxl44vRdXtXwzCpUbZRI7AvL/S1vyIo+jH63Nkh0RzbKq428w9yVNoldcRi1Eh2OVV
         O9cuWMkoUgZRJUo9TKzwyG/DLUIW/InzFuAwuAbyJafhDrqXN43N5yU6a9T1l6RLD5Gx
         CIFUvoMG41M9l0mZm2WcSRGZ/AuNkBvJWr4ujHNC8yw0Tzsc//a4Dl01Aa1n2notK3il
         ZEPg==
X-Forwarded-Encrypted: i=1; AJvYcCWVZWRYMt/QSmrvlopWx8jRECvj25WdcogVT9fnoptGhCsq+RzCAp9uKuIW5Pt7BRQ2KPdh/sOjHGYe6lMyGWuNPG1oUzOmhj7M/wjP
X-Gm-Message-State: AOJu0YzrnjPZRpzwBY1vxGmuP8zC9b2wndaz/wySiem3TajrPF5tDyS2
	Z/1WokpUZ9xDwii0zXydCVsx76EwMqUEv03WFs0GckpqjXoXj9oYt6LCZBAWdL3G3cE9KUkKFsd
	dgV92oLNbRSvAm4V/6PY/zkUEBaM=
X-Google-Smtp-Source: AGHT+IGkeQaUTtML4BAUSknZ/hBerb+DXBKsTJxJ9HJGdHKaCjW0i004NcOl8UENx+Mx7weGwmwsaIpcn7zI/0kuIRQ=
X-Received: by 2002:a05:6102:3588:b0:48f:e5d1:241d with SMTP id
 ada2fe7eead31-495d84855e9mr7514227137.14.1723353648360; Sat, 10 Aug 2024
 22:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
 <20240809070412.33847-1-21cnbao@gmail.com> <62d758b1-595a-4c05-ab89-3fe43d79f1bf@redhat.com>
In-Reply-To: <62d758b1-595a-4c05-ab89-3fe43d79f1bf@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 11 Aug 2024 17:20:37 +1200
Message-ID: <CAGsJ_4z-bCSSQecYq=L4U1QuoQUCtgY1WXbAX=eCEO9rXv8eNQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, hanchuanhua@oppo.com, ioworker0@gmail.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 7:22=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 09.08.24 09:04, Barry Song wrote:
> >>>> I would appreciate if we leave the rmap out here.
> >>>>
> >>>> Can't we handle that when actually freeing the folio? folio_test_ano=
n()
> >>>> is sticky until freed.
> >>>
> >>> To be clearer: we increment the counter when we set a folio anon, whi=
ch
> >>> should indeed only happen in folio_add_new_anon_rmap(). We'll have to
> >>> ignore hugetlb here where we do it in hugetlb_add_new_anon_rmap().
> >>>
> >>> Then, when we free an anon folio we decrement the counter. (hugetlb
> >>> should clear the anon flag when an anon folio gets freed back to its
> >>> allocator -- likely that is already done).
> >>>
> >>
> >> Sorry that I am talking to myself: I'm wondering if we also have to
> >> adjust the counter when splitting a large folio to multiple
> >> smaller-but-still-large folios.
> >
> > Hi David,
> >
> > The conceptual code is shown below. Does this make more
> > sense to you? we have a line "mod_mthp_stat(new_order,
> > MTHP_STAT_NR_ANON, 1 << (order - new_order));"
> >
> > @@ -3270,8 +3272,9 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >       struct deferred_split *ds_queue =3D get_deferred_split_queue(foli=
o);
> >       /* reset xarray order to new order after split */
> >       XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_o=
rder);
> > -     struct anon_vma *anon_vma =3D NULL;
> > +     bool is_anon =3D folio_test_anon(folio);
> >       struct address_space *mapping =3D NULL;
> > +     struct anon_vma *anon_vma =3D NULL;
> >       int order =3D folio_order(folio);
> >       int extra_pins, ret;
> >       pgoff_t end;
> > @@ -3283,7 +3286,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >       if (new_order >=3D folio_order(folio))
> >               return -EINVAL;
> >
> > -     if (folio_test_anon(folio)) {
> > +     if (is_anon) {
> >               /* order-1 is not supported for anonymous THP. */
> >               if (new_order =3D=3D 1) {
> >                       VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> > @@ -3323,7 +3326,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >       if (folio_test_writeback(folio))
> >               return -EBUSY;
> >
> > -     if (folio_test_anon(folio)) {
> > +     if (is_anon) {
> >               /*
> >                * The caller does not necessarily hold an mmap_lock that=
 would
> >                * prevent the anon_vma disappearing so we first we take =
a
> > @@ -3437,6 +3440,10 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >                       }
> >               }
> >
> > +             if (is_anon) {
> > +                     mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> > +                     mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << =
(order - new_order));
> > +             }
> >               __split_huge_page(page, list, end, new_order);
> >               ret =3D 0;
> >       } else {
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 408ef3d25cf5..c869d0601614 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1039,6 +1039,7 @@ __always_inline bool free_pages_prepare(struct pa=
ge *page,
> >       bool skip_kasan_poison =3D should_skip_kasan_poison(page);
> >       bool init =3D want_init_on_free();
> >       bool compound =3D PageCompound(page);
> > +     bool anon =3D PageAnon(page);
> >
> >       VM_BUG_ON_PAGE(PageTail(page), page);
> >
> > @@ -1130,6 +1131,9 @@ __always_inline bool free_pages_prepare(struct pa=
ge *page,
> >
> >       debug_pagealloc_unmap_pages(page, 1 << order);
> >
> > +     if (anon && compound)
> > +             mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> > +
> >       return true;
>
> I'd have placed it here, when we are already passed the "PageMappingFlags=
" check and
> shouldn't have any added overhead for most !anon pages IIRC (mostly only =
anon/ksm pages should
> run into that path).
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 408ef3d25cf5..a11b9dd62964 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1079,8 +1079,11 @@ __always_inline bool free_pages_prepare(struct pag=
e *page,
>                          (page + i)->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP=
;
>                  }
>          }
> -       if (PageMappingFlags(page))
> +       if (PageMappingFlags(page)) {
> +               if (PageAnon(page) && compound)
> +                       mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>                  page->mapping =3D NULL;
> +       }
>          if (is_check_pages_enabled()) {
>                  if (free_page_is_bad(page))
>                          bad++;
>

This looks better, but we're not concerned about the bad pages, correct?
For bad pages, we're reducing the count by 1, but they aren't actually
freed. We don't need to worry about this since it's already considered
a bug, right?

> Conceptually LGTM. We account an anon folio as long as it's anon,
> even when still GUP-pinned after unmapping it or when temporarily
> unmapping+remapping it during migration.

right. but migration might be a problem? as the dst folio doesn't
call folio_add_new_anon_rmap(), dst->mapping is copied from
src. So I suspect we need the below (otherwise, src has been put
and got -1, but dst won't get +1),

diff --git a/mm/migrate.c b/mm/migrate.c
index 7e1267042a56..11ef11e59036 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1102,6 +1102,8 @@ static void migrate_folio_done(struct folio *src,
                mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
                                    folio_is_file_lru(src),
-folio_nr_pages(src));

+       mod_mthp_stat(folio_order(src), MTHP_STAT_NR_ANON, 1);
+
        if (reason !=3D MR_MEMORY_FAILURE)
                /* We release the page in page_handle_poison. */
                folio_put(src);


>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry


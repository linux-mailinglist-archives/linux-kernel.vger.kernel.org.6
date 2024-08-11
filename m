Return-Path: <linux-kernel+bounces-282164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E841294E053
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE61C20EB3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 06:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4B1C6B4;
	Sun, 11 Aug 2024 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STkdL8+5"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C11CA81
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723359287; cv=none; b=ZJyP1YrNR3tl+1KIJEGjgsN/8ZhhLLS+VKsq9bzpRNlBulPMOfcpAHcBOrITokV9DFlN8Bx0V52UoOz8fC7QPXD7b/6bqx7XjWWi3FIwr07evC4hvplOgS+v8tMriFowsYmSbTZTDV9UhNRoFrwsO+WI9lVkB5Ir7XspOGpExzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723359287; c=relaxed/simple;
	bh=FqC7fHrcoI0PmekV5gEilqbsC44Qn99WLa99B3AURZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip5Eq1/uXsBVoMsQH6/2uwxQtDtdYyRkBMCiqEwFlM/7wVt3Ts77ZOc8d9gbAJqeefGPvS7/PN8MeLQ9DdPMkja3sHhSIwXLMwrzBF1xY7R9gqn2vzmsRbdL21rYnTOUp+O7r9//fs3oRP8d0KUKMM76k5jlbDCpPAivj4RUCCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STkdL8+5; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f6ac477ff4so1954575e0c.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723359285; x=1723964085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvYfG4NOD4+u+oRm1bZpwNy583HTuo0lhAApM0Sh81U=;
        b=STkdL8+5/3moBQQ9hacNnzzBcluphHzJ9xlBBP3R9+/zV5Eygcv6rHeF5pSSVsbjW5
         Frtpu3UbeeX7K8UIep7GQdasTH5EIH937kxv/5vXeMa8c3BVIWZ8YECjKPyfF7mS6qHm
         UpU2sMXEqPxQspTfP1sqoTaZVdRqI0J26zcbVycCqKO1cZ8rffoBSgV3IO8GyzHRj/sO
         nkv2D1Jn7hEGI2Wo/7ysRxs42TK8y86bXMcFyzOJWj6L9puPhbgh0UP5BlNMVuL3fK/h
         STXI/KYfBT7RPlEsCMb+Q7ZPbKHxscUYCmflfN0+JHkZrIRr+8BUxG36tu2Rb8L0wxbe
         awig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723359285; x=1723964085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvYfG4NOD4+u+oRm1bZpwNy583HTuo0lhAApM0Sh81U=;
        b=skLbjtSTLEioLwUTi+7+brb/a6Ib/OrPK9gvsXijNKjblHWW0lzwHhn67AzEd7D6yr
         AdUbECI0VXH8tVH0lWRdT6OxjgNGyo4uTarB+SPy0o+2ZVbwcBz7CxXKUYBkGiDYQ8SP
         Ymi/Btw+cdttP+4yyMvJYhU+jh4o7ixN+W//O8pVPu14S/sfYPiCNiQu6Ak5ao0zuZQu
         FYLROiB7wrP1EdC/1mfeQlFfrCctaqZdurk2Ak2xXoio/YijSt8meqlJR/G2A6CMgw+O
         3SzU1iBhwiRQ8uc7Anwu9zUD4ikhIXdD8x9F2AqbEjo8t7keKJOw0bl4lXrPsWl2sL0Y
         e5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIIvLBriaFjr9+GxbWXixytRTqJPeat94M8Q+9IRVP4h0tKAHKh8y5h2t39HAyV4gfaLUa6jmx5yjj4A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXz0aG3fyfvnnqE/Med+P7SspSuRoqMX37/zzTD4Hh5QikP4T
	D/eZFDpqIZAI/HBvj7b7EZ4XMHfnKXNBb3FW4AbM6QHmVUxObhKlQTYfbahZkfVlorhyU1HAHmC
	H65ynpuPaFNoNN5VfZu2GuSxNugE=
X-Google-Smtp-Source: AGHT+IG7BJlAPZsht5CTEkJaVPxxHI+IovbEAhOc29WjktBxephyHnhq91P9aUqgOcQZzaSFz8IIVdSSIPis2Y/SYP8=
X-Received: by 2002:a05:6122:2784:b0:4ef:4b35:896f with SMTP id
 71dfb90a1353d-4f9130394bbmr7039571e0c.7.1723359284615; Sat, 10 Aug 2024
 23:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
 <20240809070412.33847-1-21cnbao@gmail.com> <62d758b1-595a-4c05-ab89-3fe43d79f1bf@redhat.com>
 <CAGsJ_4z-bCSSQecYq=L4U1QuoQUCtgY1WXbAX=eCEO9rXv8eNQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4z-bCSSQecYq=L4U1QuoQUCtgY1WXbAX=eCEO9rXv8eNQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 11 Aug 2024 18:54:33 +1200
Message-ID: <CAGsJ_4w0SzyA50zNcGAgUc36GOEVr3L6gcZntw4ejBogC9b6+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, hanchuanhua@oppo.com, ioworker0@gmail.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 5:20=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Aug 9, 2024 at 7:22=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 09.08.24 09:04, Barry Song wrote:
> > >>>> I would appreciate if we leave the rmap out here.
> > >>>>
> > >>>> Can't we handle that when actually freeing the folio? folio_test_a=
non()
> > >>>> is sticky until freed.
> > >>>
> > >>> To be clearer: we increment the counter when we set a folio anon, w=
hich
> > >>> should indeed only happen in folio_add_new_anon_rmap(). We'll have =
to
> > >>> ignore hugetlb here where we do it in hugetlb_add_new_anon_rmap().
> > >>>
> > >>> Then, when we free an anon folio we decrement the counter. (hugetlb
> > >>> should clear the anon flag when an anon folio gets freed back to it=
s
> > >>> allocator -- likely that is already done).
> > >>>
> > >>
> > >> Sorry that I am talking to myself: I'm wondering if we also have to
> > >> adjust the counter when splitting a large folio to multiple
> > >> smaller-but-still-large folios.
> > >
> > > Hi David,
> > >
> > > The conceptual code is shown below. Does this make more
> > > sense to you? we have a line "mod_mthp_stat(new_order,
> > > MTHP_STAT_NR_ANON, 1 << (order - new_order));"
> > >
> > > @@ -3270,8 +3272,9 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
> > >       struct deferred_split *ds_queue =3D get_deferred_split_queue(fo=
lio);
> > >       /* reset xarray order to new order after split */
> > >       XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new=
_order);
> > > -     struct anon_vma *anon_vma =3D NULL;
> > > +     bool is_anon =3D folio_test_anon(folio);
> > >       struct address_space *mapping =3D NULL;
> > > +     struct anon_vma *anon_vma =3D NULL;
> > >       int order =3D folio_order(folio);
> > >       int extra_pins, ret;
> > >       pgoff_t end;
> > > @@ -3283,7 +3286,7 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
> > >       if (new_order >=3D folio_order(folio))
> > >               return -EINVAL;
> > >
> > > -     if (folio_test_anon(folio)) {
> > > +     if (is_anon) {
> > >               /* order-1 is not supported for anonymous THP. */
> > >               if (new_order =3D=3D 1) {
> > >                       VM_WARN_ONCE(1, "Cannot split to order-1 folio"=
);
> > > @@ -3323,7 +3326,7 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
> > >       if (folio_test_writeback(folio))
> > >               return -EBUSY;
> > >
> > > -     if (folio_test_anon(folio)) {
> > > +     if (is_anon) {
> > >               /*
> > >                * The caller does not necessarily hold an mmap_lock th=
at would
> > >                * prevent the anon_vma disappearing so we first we tak=
e a
> > > @@ -3437,6 +3440,10 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
> > >                       }
> > >               }
> > >
> > > +             if (is_anon) {
> > > +                     mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> > > +                     mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 <=
< (order - new_order));
> > > +             }
> > >               __split_huge_page(page, list, end, new_order);
> > >               ret =3D 0;
> > >       } else {
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 408ef3d25cf5..c869d0601614 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1039,6 +1039,7 @@ __always_inline bool free_pages_prepare(struct =
page *page,
> > >       bool skip_kasan_poison =3D should_skip_kasan_poison(page);
> > >       bool init =3D want_init_on_free();
> > >       bool compound =3D PageCompound(page);
> > > +     bool anon =3D PageAnon(page);
> > >
> > >       VM_BUG_ON_PAGE(PageTail(page), page);
> > >
> > > @@ -1130,6 +1131,9 @@ __always_inline bool free_pages_prepare(struct =
page *page,
> > >
> > >       debug_pagealloc_unmap_pages(page, 1 << order);
> > >
> > > +     if (anon && compound)
> > > +             mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> > > +
> > >       return true;
> >
> > I'd have placed it here, when we are already passed the "PageMappingFla=
gs" check and
> > shouldn't have any added overhead for most !anon pages IIRC (mostly onl=
y anon/ksm pages should
> > run into that path).
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 408ef3d25cf5..a11b9dd62964 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1079,8 +1079,11 @@ __always_inline bool free_pages_prepare(struct p=
age *page,
> >                          (page + i)->flags &=3D ~PAGE_FLAGS_CHECK_AT_PR=
EP;
> >                  }
> >          }
> > -       if (PageMappingFlags(page))
> > +       if (PageMappingFlags(page)) {
> > +               if (PageAnon(page) && compound)
> > +                       mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> >                  page->mapping =3D NULL;
> > +       }
> >          if (is_check_pages_enabled()) {
> >                  if (free_page_is_bad(page))
> >                          bad++;
> >
>
> This looks better, but we're not concerned about the bad pages, correct?
> For bad pages, we're reducing the count by 1, but they aren't actually
> freed. We don't need to worry about this since it's already considered
> a bug, right?
>
> > Conceptually LGTM. We account an anon folio as long as it's anon,
> > even when still GUP-pinned after unmapping it or when temporarily
> > unmapping+remapping it during migration.
>
> right. but migration might be a problem? as the dst folio doesn't
> call folio_add_new_anon_rmap(), dst->mapping is copied from
> src. So I suspect we need the below (otherwise, src has been put
> and got -1, but dst won't get +1),
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7e1267042a56..11ef11e59036 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1102,6 +1102,8 @@ static void migrate_folio_done(struct folio *src,
>                 mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
>                                     folio_is_file_lru(src),
> -folio_nr_pages(src));
>
> +       mod_mthp_stat(folio_order(src), MTHP_STAT_NR_ANON, 1);
> +
>         if (reason !=3D MR_MEMORY_FAILURE)
>                 /* We release the page in page_handle_poison. */
>                 folio_put(src);
>

sorry. wrong place as migrate_folio_done() doesn't necessarily mean
migration is done. it could be "Folio was freed from under us"

        if (folio_ref_count(src) =3D=3D 1) {
                /* Folio was freed from under us. So we are done. */
                folio_clear_active(src);
                folio_clear_unevictable(src);
                /* free_pages_prepare() will clear PG_isolated. */
                list_del(&src->lru);
                migrate_folio_done(src, reason);
                return MIGRATEPAGE_SUCCESS;
        }


the correct place should be:

@@ -1329,6 +1326,10 @@ static int migrate_folio_move(free_folio_t
put_new_folio, unsigned long private,
        if (anon_vma)
                put_anon_vma(anon_vma);
        folio_unlock(src);
+
+       if (folio_test_anon(src))
+               mod_mthp_stat(folio_order(src), MTHP_STAT_NR_ANON, 1);
+
        migrate_folio_done(src, reason);

        return rc;

Without this modification in migration code, my tests fail, anon_num can
become negative.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

Thanks
Barry


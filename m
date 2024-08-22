Return-Path: <linux-kernel+bounces-296324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E595A93C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A085EB21A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2158C5684;
	Thu, 22 Aug 2024 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR+trwI9"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CF6AAD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287980; cv=none; b=UD1hWD+/yPq0iBv0c9JwIEpjo44UGoXTiz8FciLEXrcRB/G4Jh+evJdqI+QUtgz6SVtGi/oYi0wv8LZW5TKEi+G0lANBzFKFVchK6hqd6zhA2qnm+oCUuvpgvV4tFqNhqwPIGGk339QjK2j7JDRaVaN90Q5wiwwQy5JGU+Q4fJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287980; c=relaxed/simple;
	bh=VSkrQUydtfBFweXylJFC2xlyhZXtbf8kJBOpMOnqOEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpdSSRS+g3hQdMRq23wJwwDfJ+VlzTcEVu2rEvBR1pQyTrnPBQ1Rp+ix2TFsxNBfTYgJMv0ahDkHKz0y4cT1OaAOfLs19KSAqG1UzLYhQahZy+uG9bmelwzo4guI0WLSrdY8KzDUH2PKwJJu0tayhBR8EnYDR9PTFfbzx8A1bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR+trwI9; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-83446a5601bso116868241.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724287977; x=1724892777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvNUmXh6QYHC9p2pKnLZfslXEAtuHNdoak5tt5thDe0=;
        b=YR+trwI9O5sUUOE4f59yv1wrIJnuWiqpxGuJaAzo+B/JYIQpoyAENIaqHjjZIjWZPQ
         vEcu1GyFgyKxEfk6Nfv4BLsEgIv40j5w6nkc56CJbX7uVa0GLtk/xXIAVvqIbP4lnno5
         imUD+HvrfJnshZnHdZyCDk5B+3ODRFXmhsBJUwA5uLPJnhHjXYAceGmlWRiftcPDUBgw
         lI8D/6fo25lqmEeiuvx2EV8o3pVaGW+ly3cMsf6UwaC741+XJXOmA/zXHvYYiiUghsfK
         67Oef335tV3VD6HC08dburM8NQ4XD9qIluKx9wI7lNUpiH83DAfi0KITWTjOtAdjIEk5
         HpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724287977; x=1724892777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvNUmXh6QYHC9p2pKnLZfslXEAtuHNdoak5tt5thDe0=;
        b=EOV40EYTAiS95wgbFL5aRNtFpjmDffxHubywis+nJczY+aXj9oYAYD6fOWL46u7iDj
         BjfPKoY62Ot4ScHJJIHi5veJCrrvy9DdPXh3NQofIEo7v8oSg4QcVF5R0QrZ/powgNxL
         H+YjWJyRSxKMh5/k8JyRGTTc5o71Wgta95+DdC2DzATKi5+LEuD2XhgwgR6OPpWJFu5P
         wlkDtP5WaBvTwUNx+uPU3nWr8AIZR24Kt0ybc3+9doERUwliKXCwsvyXC0agyWogZc7T
         kPJsbUNzKzTuBXn7XyMWtCpkn4ppNNaikZ9Li8pepq3H8nop53Iy1pXdosm49aCrrMk9
         b1WA==
X-Forwarded-Encrypted: i=1; AJvYcCUbsb1qcg5pvpxWXHNu6VY4OJSZNp6M824ZnXYPnt79Iq/qlSNRP4/2rxgvDrW0t7+ZmYCtmSbcUTfEsjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9Ei+c7EWPmeBafmDoIvTGYPUWN74DzkCdSpvxiVTMnX6TVH6
	5YLsUAL6OSdakVbcsOTWEp+V6IkN9Xybhf8fFQbPK1KCJ2VmoJZdJRfvoihN9nH/bXus1aAqufC
	bc0MU+/qbIDUxxMxpOhvaH2wSCyI=
X-Google-Smtp-Source: AGHT+IEl3MsbTYZQIajgTxyKIGV+TI3/pnxNw23DZ/6DGgfoWTK+gno5G+goww3B/BQ8SjYp+OzkBtSV2gx+2xET4I0=
X-Received: by 2002:a05:6102:e0b:b0:493:b2b4:3708 with SMTP id
 ada2fe7eead31-498d2ffd644mr5148601137.27.1724287977448; Wed, 21 Aug 2024
 17:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811224940.39876-1-21cnbao@gmail.com> <20240811224940.39876-2-21cnbao@gmail.com>
 <3572ae2e-2141-4a70-99da-850b2e7ade41@redhat.com>
In-Reply-To: <3572ae2e-2141-4a70-99da-850b2e7ade41@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Aug 2024 08:52:44 +0800
Message-ID: <CAGsJ_4w9gg=z6KgAZ4Tur+t-ZhpXdvmq4A5tOQiUZLeuPFSupg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: collect the number of anon large folios
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ziy@nvidia.com, yuanshuai@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:34=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.08.24 00:49, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Anon large folios come from three places:
> > 1. new allocated large folios in PF, they will call folio_add_new_anon_=
rmap()
> > for rmap;
> > 2. a large folio is split into multiple lower-order large folios;
> > 3. a large folio is migrated to a new large folio.
> >
> > In all above three counts, we increase nr_anon by 1;
> >
> > Anon large folios might go either because of be split or be put
> > to free, in these cases, we reduce the count by 1.
> >
> > Folios that have been added to the swap cache but have not yet received
> > an anon mapping won't be counted. This is consistent with the AnonPages
> > statistics in /proc/meminfo.
>
> Thinking out loud, I wonder if we want to have something like that for
> any anon folios (including small ones).
>
> Assume we longterm-pinned an anon folio and unmapped/zapped it. It would
> be quite interesting to see that these are actually anon pages still
> consuming memory. Same with memory leaks, when an anon folio doesn't get
> freed for some reason.
>
> The whole "AnonPages" counter thingy is just confusing, it only counts
> what's currently mapped ... so we'd want something different.
>
> But it's okay to start with large folios only, there we have a new
> interface without that legacy stuff :)

We have two options to do this:
1. add a new separate nr_anon_unmapped interface which
counts unmapped anon memory only
2. let the nr_anon count both mapped and unmapped anon
folios.

I would assume 1 is clearer as right now AnonPages have been
there for years. and counting all mapped and unmapped together,
we are still lacking an approach to find out anon memory leak
problem you mentioned.

We are right now comparing nr_anon(including mapped folios only)
with AnonPages to get the distribution of different folio sizes in
performance profiling.

unmapped_nr_anon should be normally always quite small. otherwise,
something must be wrong.

>
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   Documentation/admin-guide/mm/transhuge.rst |  5 +++++
> >   include/linux/huge_mm.h                    | 15 +++++++++++++--
> >   mm/huge_memory.c                           | 13 ++++++++++---
> >   mm/migrate.c                               |  4 ++++
> >   mm/page_alloc.c                            |  5 ++++-
> >   mm/rmap.c                                  |  1 +
> >   6 files changed, 37 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 058485daf186..9fdfb46e4560 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -527,6 +527,11 @@ split_deferred
> >           it would free up some memory. Pages on split queue are going =
to
> >           be split under memory pressure, if splitting is possible.
> >
> > +nr_anon
> > +       the number of anon huge pages we have in the whole system.
>
> "transparent ..." otherwise people might confuse it with anon hugetlb
> "huge pages" ... :)
>
> I briefly tried coming up with a better name than "nr_anon" but failed.
>
>

if we might have unmapped_anon counter later, maybe rename it to
nr_anon_mapped? and the new interface we will have in the future
might be nr_anon_unmapped?

> [...]
>
> > @@ -447,6 +449,8 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
> >        */
> >       newfolio->index =3D folio->index;
> >       newfolio->mapping =3D folio->mapping;
> > +     if (folio_test_anon(folio) && folio_test_large(folio))
> > +             mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
> >       folio_ref_add(newfolio, nr); /* add cache reference */
> >       if (folio_test_swapbacked(folio)) {
> >               __folio_set_swapbacked(newfolio);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 84a7154fde93..382c364d3efa 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1084,8 +1084,11 @@ __always_inline bool free_pages_prepare(struct p=
age *page,
> >                       (page + i)->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
> >               }
> >       }
> > -     if (PageMappingFlags(page))
> > +     if (PageMappingFlags(page)) {
> > +             if (PageAnon(page) && compound)
> > +                     mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>
> I wonder if you could even drop the "compound" check. mod_mthp_stat
> would handle order =3D=3D 0 just fine. Not that I think it makes much
> difference.

i think either is fine as mod_mthp_stat will filter out order=3D=3D0
right now.

>
>
> Nothing else jumped at me.
>
> Acked-by: David Hildenbrand <david@redhat.com>
>

Thanks!

> --
> Cheers,
>
> David / dhildenb
>

Barry


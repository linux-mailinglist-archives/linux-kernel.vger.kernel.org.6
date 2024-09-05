Return-Path: <linux-kernel+bounces-316515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BE696D091
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A5E1C217FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A21619309A;
	Thu,  5 Sep 2024 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bgwx/6vq"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68DA18A94F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521963; cv=none; b=EhEVG9H6XXs02QX9zyvtC+Q59aI/Bg5IyOPqmNNCZVv2FxfYd8wrJ3vYclTG3lVeeFoNA4WFGjvXFFGwdFNY2lIMZf3kFkLdPNy2hNxLR/zqgV+8jQobKqcusW69C07qwJgTzotDI6gHUVasE0QFHSsxUJ8BgDg3YlERAKtVt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521963; c=relaxed/simple;
	bh=xCj2z8G3Q4eCRBp/5cn7riDEHKsf7rczaDCf+USPHmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVHdnTwAuqfmNx3VcN3wM09MHBX9QrPQOVjD/qCV1kl1pKAt+Bxq5hIdPuWRhZih3NZ4HsyP2GFjfdLd6Q2iMGykAgSVVtbhaI5jo1mpkrT6oHnUvYTeuW0PYAmPPPNx/ylfZcONlw6ttua+FhXdonhF/gRT4yiCrMGa8pv/N2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bgwx/6vq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a843bef98so60522066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725521960; x=1726126760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDy1iJqXHORqufKOt/lM2FthAPTJ7F0XYzMDKso6N5Q=;
        b=Bgwx/6vqpDYPfmX0YS83jbOuqPdgQ+WGfS5TY/Y479FtKQVKOTQSvIvrZUi3xQ7Zh7
         eqymiJkM5Y4xQaQcfMZdp0txgq0260lNlZrwESSEu4EJ/qKEjfsuas1eg8RiVui3gfqx
         sCbqo23fHUwjM7Mbbh6oh2ZNZ6nC/XscDvXr99Pkp/f3BSCXcVsimG11AuH2KU4wdtTO
         oJQhfRCDL2hfD0BIwF9M3Sd9Nis+SDn60CI9aHCeSFhl9ldkIX61KLXVqOi5jbdMMpys
         49Fzm8OgZB+cbV/Q7hoVycQWBPZJcK6I4rPxsfOWc2mXu19AgLfq+wPougDDknyMhGRg
         5WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725521960; x=1726126760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDy1iJqXHORqufKOt/lM2FthAPTJ7F0XYzMDKso6N5Q=;
        b=Dvi+G9+Tjz6Et10lGemhKVj7ys+ZsGLiiAWXdN/+HEkyihl3QKirHUaIx3rmYr3/a2
         VkjyPBhW9+y5Ng1YfPRateYFrpODTFFLpjDMt6PvvFDGyKWpGN7KtFFOnCYVTvaLAMdM
         zw8B99MF4sATn9lKDO7fHEsIhmdPTy/DMYYuB4eZ/mLnlsX+WaNtLy3EQBJv7UZs3tKs
         rUHLDNm0x0xKaSvP7axfShmsWyfGgY43g5Cq7BJF5hDzUjiLIbN+2qlMUQQYDSYwCNRc
         R5dIbYE/WhFrIL5WIKC2cWE4Ml7UbMWb57FCEo4Q/JE0yxNBnol4YqqaXTmy42rv+V5B
         d3TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAHc65V+cdSUjBgBeMr6OG+N36os+LIa0pOBpptBXx7q443d5SnTUdWfRwA+bzpd2Pf2BSSx20Ngo0xIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cA0dSjuX/nNdrCUmm/E/FRUbBSNUoOJ4MubBfu6pILvkHmPH
	Acl0HqpYpwPe2YhC94G16qg3ZnIoGQGs+cCvZ35fvz1IRX3pVWo6R3I5bujSxX9oFyTG9R4i0ky
	6VYBwkIYrMiPIWrlY55gTTUiwlHKuiVgDVwT77EgCtsF2vxfxcw==
X-Google-Smtp-Source: AGHT+IEK71SW+38TwgBUkw+J1TEOWXLzwIJkR7hNQmXRs0b8u9HsgCN5rqc3JAoiaK/4NLi7jKy7E7geKpnm9TnHbfA=
X-Received: by 2002:a17:907:12cd:b0:a89:f171:8dc0 with SMTP id
 a640c23a62f3a-a89f171926fmr697246566b.11.1725521959655; Thu, 05 Sep 2024
 00:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tkYK3ecG7cuJcxSF-cw-0K=JPnoE3L4Y=7xUp_R8apqueg@mail.gmail.com>
 <20240905002926.1055-1-21cnbao@gmail.com>
In-Reply-To: <20240905002926.1055-1-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 5 Sep 2024 00:38:43 -0700
Message-ID: <CAJD7tkbSe+pb_2uhGz5pYTgi9QBzROrfxNM+4qs=JswON31QTA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, shakeel.butt@linux.dev, usamaarif642@gmail.com, 
	willy@infradead.org, ying.huang@intel.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:29=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Thu, Sep 5, 2024 at 11:57=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > [..]
> > > well. i feel i have a much cheaper way to implement this, which
> > > can entirely iteration even in your original code:
> > >
> > > +/*
> > > + * Return the number of entries which are zero-filled according to
> > > + * swap_info_struct->zeromap. It isn't precise if the return value
> > > + * is 1 for nr > 1. In this case, it means entries have inconsistent
> > > + * zeromap.
> > > + */
> > > +static inline unsigned int swap_zeromap_entries_count(swp_entry_t
> > > entry, int nr)
> >
> > FWIW I am not really a fan of the count() function not returning an
> > actual count. I think an enum with three states is more appropriate
> > here, and renaming the function to swap_zeromap_entries_check() or
> > similar.
> >
>
> Make sense to me, what about the below?

LGTM from a high level, but I didn't look closely at the bitmap
interface usage. I am specifically unsure if we can pass 'end' as the
size, but it seems like it should be fine. I will let Usama take a
look.

Thanks!

>
> From 24228a1e8426b8b05711a5efcfaae70abeb012c4 Mon Sep 17 00:00:00 2001
> From: Barry Song <v-songbaohua@oppo.com>
> Date: Thu, 5 Sep 2024 11:56:03 +1200
> Subject: [PATCH] mm: fix handling zero for large folios with partial zero=
map
>
> There could be a corner case where the first entry is non-zeromap,
> but a subsequent entry is zeromap. In this case, we should not
> return false.
>
> Additionally, the iteration of test_bit() is unnecessary and
> can be replaced with bitmap operations, which are more efficient.
>
> Since swap_read_folio() can't handle reading a large folio that's
> partially zeromap and partially non-zeromap, we've moved the code
> to mm/swap.h so that others, like those working on swap-in, can
> access it.
>
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap"=
)
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/page_io.c | 27 ++++-----------------------
>  mm/swap.h    | 29 +++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 23 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 4bc77d1c6bfa..46907c9dd20b 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *f=
olio)
>         }
>  }
>
> -/*
> - * Return the index of the first subpage which is not zero-filled
> - * according to swap_info_struct->zeromap.
> - * If all pages are zero-filled according to zeromap, it will return
> - * folio_nr_pages(folio).
> - */
> -static unsigned int swap_zeromap_folio_test(struct folio *folio)
> -{
> -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> -       swp_entry_t entry;
> -       unsigned int i;
> -
> -       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> -               entry =3D page_swap_entry(folio_page(folio, i));
> -               if (!test_bit(swp_offset(entry), sis->zeromap))
> -                       return i;
> -       }
> -       return i;
> -}
> -
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -524,9 +504,10 @@ static void sio_read_complete(struct kiocb *iocb, lo=
ng ret)
>
>  static bool swap_read_folio_zeromap(struct folio *folio)
>  {
> -       unsigned int idx =3D swap_zeromap_folio_test(folio);
> +       unsigned int nr_pages =3D folio_nr_pages(folio);
> +       zeromap_stat_t stat =3D swap_zeromap_entries_check(folio->swap, n=
r_pages);
>
> -       if (idx =3D=3D 0)
> +       if (stat =3D=3D SWAP_ZEROMAP_NON)
>                 return false;
>
>         /*
> @@ -534,7 +515,7 @@ static bool swap_read_folio_zeromap(struct folio *fol=
io)
>          * currently handled. Return true without marking the folio uptod=
ate so
>          * that an IO error is emitted (e.g. do_swap_page() will sigbus).
>          */
> -       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> +       if (WARN_ON_ONCE(stat =3D=3D SWAP_ZEROMAP_PARTIAL))
>                 return true;
>
>         folio_zero_range(folio, 0, folio_size(folio));
> diff --git a/mm/swap.h b/mm/swap.h
> index f8711ff82f84..f8e3fa061c1d 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -4,6 +4,12 @@
>
>  struct mempolicy;
>
> +typedef enum {
> +       SWAP_ZEROMAP_NON,
> +       SWAP_ZEROMAP_FULL,
> +       SWAP_ZEROMAP_PARTIAL
> +} zeromap_stat_t;
> +
>  #ifdef CONFIG_SWAP
>  #include <linux/swapops.h> /* for swp_offset */
>  #include <linux/blk_types.h> /* for bio_end_io_t */
> @@ -80,6 +86,24 @@ static inline unsigned int folio_swap_flags(struct fol=
io *folio)
>  {
>         return swp_swap_info(folio->swap)->flags;
>  }
> +
> +/*
> + * Check if nr entries are all zeromap, non-zeromap or partially zeromap
> + */
> +static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_t entr=
y, int nr)
> +{
> +       struct swap_info_struct *sis =3D swp_swap_info(entry);
> +       unsigned long start =3D swp_offset(entry);
> +       unsigned long end =3D start + nr;
> +
> +       if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
> +               return SWAP_ZEROMAP_NON;
> +       if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end)
> +               return SWAP_ZEROMAP_FULL;
> +
> +       return SWAP_ZEROMAP_PARTIAL;
> +}
> +
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
>  static inline void swap_read_folio(struct folio *folio, struct swap_iocb=
 **plug)
> @@ -171,6 +195,11 @@ static inline unsigned int folio_swap_flags(struct f=
olio *folio)
>  {
>         return 0;
>  }
> +
> +static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_t entr=
y, int nr)
> +{
> +       return SWAP_ZEROMAP_NONE;
> +}
>  #endif /* CONFIG_SWAP */
>
>  #endif /* _MM_SWAP_H */
> --
> 2.34.1
>
>


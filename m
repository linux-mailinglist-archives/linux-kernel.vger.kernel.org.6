Return-Path: <linux-kernel+bounces-316092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5396CAFA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C245289E22
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CFE17B4E5;
	Wed,  4 Sep 2024 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMyFKaIC"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122651487DD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493664; cv=none; b=tQatGSORRu3ez5VY3+lycP+4j3SoCd7pXijwg9QWlROrqbbptqY53ySJPDx+vWIm5K8juQ7qDtj+klzr7g8lm1c/Slw/mkNrTCGlrkqdr9i8FX1WREvp+ccqJ+rkafrG1a1hFEddOmmY7oUnRbIiXFe4DKpDoU68nYD5lS58DHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493664; c=relaxed/simple;
	bh=PmIq6uBPSgfKxZQa3MEuoSfzg1WZnkWjkKrUF45F2/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7FcTO+a4bEKA+Vyg+NGVUYngPOannyjRbGcJvNei1uKThVwrDdEOsRQXQR7oAD3YMtWvXU+L0gu+SPeWCaabWVUmWNZDQozMJkRbDcbCWMBK/HfDkyZMJXBU93wdO4LpQcHChPxhEaIlqa2BnpXuT1vwssEiEi4EIFkvFXgNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMyFKaIC; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-498debdf653so51365137.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725493662; x=1726098462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6E895Ok1QuyQoeazIxFZMtuIiFRwRLhjoM/FP2eCn4=;
        b=hMyFKaICEUAegGQYo1/EKBYXGsazaCozo3qbybQYesdscD1XFumDylky2giRVMZfHE
         sbQz38T0AnSfp+X3Wvxtc+3S4A6kNpuccmJ3jAs1G1GvhT20kIrq3wILvD2URyeY9d7k
         8oL8xLZCK61XDWM5wt5ixu3M7Bh6UGm0e4VuU4Kuc2bhZ0UuwbryX0IsDI9+OYl5lirE
         rZL2jiAEwQ3pDSHV0hQdSP37hJ/jgVLYE2NrzWFL1VN1CywyooJy5MfYU/tTPcBQpPdF
         d5VhD6ho19cWACxfxnagZGsyFnGm9JTQ27REuIYAM+s4jfDIuVF64QDVZ8b/mGx6XY/1
         1TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725493662; x=1726098462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6E895Ok1QuyQoeazIxFZMtuIiFRwRLhjoM/FP2eCn4=;
        b=pE1zI6BpdiH0jGzdBpKwoDyC3rakS6+T3jQ/zSmtgQsCZ6vIFi5r+nkwx0roq56glI
         l5T8YOzIrrCYSyocj8s4oZHGdB/L92hJGw77j42B3nKru4HvsHrsQRDEtdWerwGPUmkg
         HvoS+/tEWCkjJtSzL20ZNvlr1Wy0f/MOSB8JumszZMYbaK1/5hWsNNyfmqVMFqvS6L2/
         lk1riu6TH8vAeidOZpVQkhp+IsTVC/zFsAvcq//OfUL+5AYIiezgrNPJCv9Uuq262W0y
         XeOpWfIah+89mEHNqxYUBWX9P+0xvB8nKllyeyXFPhPePE0N0kMSabzkw61nqvFw8kCe
         4Hbw==
X-Forwarded-Encrypted: i=1; AJvYcCWTRQNrjSYP8o6wuI09SUvPxSSrmAwOplmlVrz3RybI3eUjADz1iVt937v6FsK8j1xacZAYhR9MHdXb/Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsEdGXdG51He1ZUWu0bQqg597+qDM/L8BEpHC/V9kOFNeF9qie
	WRHqGzuk/GWDQ7EtuyMx7YnYQH9wzxcuJEFssPwPGktKIomq0CSI758VohUv0MUdaUxgg9zWV7y
	Y85V2kS0VW7/jHlox/JWTvvijLp4=
X-Google-Smtp-Source: AGHT+IEaYtL9V90Z8En3PSeIRoPpridOyNjBm/1un/Z1It3AnyYv/A8yaMQuHaNqiTFi8W0VbdHhc1HokzLNTVCnORE=
X-Received: by 2002:a05:6102:38d2:b0:498:9b16:234e with SMTP id
 ada2fe7eead31-49bad53823dmr9350659137.24.1725493661786; Wed, 04 Sep 2024
 16:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <7a91ff31-1f56-4d0c-a4a7-a305331ba97a@gmail.com>
 <CAGsJ_4xkbOP9UCDW8sqTeXJ-=V82CEyxbz2gEr_1BUgDwzw1_g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xkbOP9UCDW8sqTeXJ-=V82CEyxbz2gEr_1BUgDwzw1_g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Sep 2024 11:47:31 +1200
Message-ID: <CAGsJ_4w3mr9z1hoU=cbKKbnFeMEupfwmErp7gfULne=v+WZO+A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	shakeel.butt@linux.dev, willy@infradead.org, ying.huang@intel.com, 
	yosryahmed@google.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:44=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Sep 4, 2024 at 11:14=E2=80=AFPM Usama Arif <usamaarif642@gmail.co=
m> wrote:
> >
> >
> >
> > On 04/09/2024 06:55, Barry Song wrote:
> > > On Thu, Jun 13, 2024 at 12:48=E2=80=AFAM Usama Arif <usamaarif642@gma=
il.com> wrote:
> > >>
> > >> Approximately 10-20% of pages to be swapped out are zero pages [1].
> > >> Rather than reading/writing these pages to flash resulting
> > >> in increased I/O and flash wear, a bitmap can be used to mark these
> > >> pages as zero at write time, and the pages can be filled at
> > >> read time if the bit corresponding to the page is set.
> > >> With this patch, NVMe writes in Meta server fleet decreased
> > >> by almost 10% with conventional swap setup (zswap disabled).
> > >>
> > >> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258d=
e3d03d1344dde9fce0@epcms5p1/
> > >>
> > >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > >> ---
> > >>  include/linux/swap.h |   1 +
> > >>  mm/page_io.c         | 114 ++++++++++++++++++++++++++++++++++++++++=
++-
> > >>  mm/swapfile.c        |  24 ++++++++-
> > >>  3 files changed, 136 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> > >> index a11c75e897ec..e88563978441 100644
> > >> --- a/include/linux/swap.h
> > >> +++ b/include/linux/swap.h
> > >> @@ -299,6 +299,7 @@ struct swap_info_struct {
> > >>         signed char     type;           /* strange name for an index=
 */
> > >>         unsigned int    max;            /* extent of the swap_map */
> > >>         unsigned char *swap_map;        /* vmalloc'ed array of usage=
 counts */
> > >> +       unsigned long *zeromap;         /* vmalloc'ed bitmap to trac=
k zero pages */
> > >>         struct swap_cluster_info *cluster_info; /* cluster info. Onl=
y for SSD */
> > >>         struct swap_cluster_list free_clusters; /* free clusters lis=
t */
> > >>         unsigned int lowest_bit;        /* index of first free in sw=
ap_map */
> > >> diff --git a/mm/page_io.c b/mm/page_io.c
> > >> index a360857cf75d..39fc3919ce15 100644
> > >> --- a/mm/page_io.c
> > >> +++ b/mm/page_io.c
> > >> @@ -172,6 +172,88 @@ int generic_swapfile_activate(struct swap_info_=
struct *sis,
> > >>         goto out;
> > >>  }
> > >>
> > >> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> > >> +{
> > >> +       unsigned long *data;
> > >> +       unsigned int pos, last_pos =3D PAGE_SIZE / sizeof(*data) - 1=
;
> > >> +       bool ret =3D false;
> > >> +
> > >> +       data =3D kmap_local_folio(folio, i * PAGE_SIZE);
> > >> +       if (data[last_pos])
> > >> +               goto out;
> > >> +       for (pos =3D 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
> > >> +               if (data[pos])
> > >> +                       goto out;
> > >> +       }
> > >> +       ret =3D true;
> > >> +out:
> > >> +       kunmap_local(data);
> > >> +       return ret;
> > >> +}
> > >> +
> > >> +static bool is_folio_zero_filled(struct folio *folio)
> > >> +{
> > >> +       unsigned int i;
> > >> +
> > >> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> > >> +               if (!is_folio_page_zero_filled(folio, i))
> > >> +                       return false;
> > >> +       }
> > >> +       return true;
> > >> +}
> > >> +
> > >> +static void folio_zero_fill(struct folio *folio)
> > >> +{
> > >> +       unsigned int i;
> > >> +
> > >> +       for (i =3D 0; i < folio_nr_pages(folio); i++)
> > >> +               clear_highpage(folio_page(folio, i));
> > >> +}
> > >> +
> > >> +static void swap_zeromap_folio_set(struct folio *folio)
> > >> +{
> > >> +       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > >> +       swp_entry_t entry;
> > >> +       unsigned int i;
> > >> +
> > >> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> > >> +               entry =3D page_swap_entry(folio_page(folio, i));
> > >> +               set_bit(swp_offset(entry), sis->zeromap);
> > >> +       }
> > >> +}
> > >> +
> > >> +static void swap_zeromap_folio_clear(struct folio *folio)
> > >> +{
> > >> +       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > >> +       swp_entry_t entry;
> > >> +       unsigned int i;
> > >> +
> > >> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> > >> +               entry =3D page_swap_entry(folio_page(folio, i));
> > >> +               clear_bit(swp_offset(entry), sis->zeromap);
> > >> +       }
> > >> +}
> > >> +
> > >> +/*
> > >> + * Return the index of the first subpage which is not zero-filled
> > >> + * according to swap_info_struct->zeromap.
> > >> + * If all pages are zero-filled according to zeromap, it will retur=
n
> > >> + * folio_nr_pages(folio).
> > >> + */
> > >> +static unsigned int swap_zeromap_folio_test(struct folio *folio)
> > >> +{
> > >> +       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > >> +       swp_entry_t entry;
> > >> +       unsigned int i;
> > >> +
> > >> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> > >> +               entry =3D page_swap_entry(folio_page(folio, i));
> > >> +               if (!test_bit(swp_offset(entry), sis->zeromap))
> > >> +                       return i;
> > >> +       }
> > >> +       return i;
> > >> +}
> > >> +
> > >>  /*
> > >>   * We may have stale swap cache pages in memory: notice
> > >>   * them here and get rid of the unnecessary final write.
> > >> @@ -195,6 +277,13 @@ int swap_writepage(struct page *page, struct wr=
iteback_control *wbc)
> > >>                 folio_unlock(folio);
> > >>                 return ret;
> > >>         }
> > >> +
> > >> +       if (is_folio_zero_filled(folio)) {
> > >> +               swap_zeromap_folio_set(folio);
> > >> +               folio_unlock(folio);
> > >> +               return 0;
> > >> +       }
> > >> +       swap_zeromap_folio_clear(folio);
> > >>         if (zswap_store(folio)) {
> > >>                 folio_start_writeback(folio);
> > >>                 folio_unlock(folio);
> > >> @@ -426,6 +515,26 @@ static void sio_read_complete(struct kiocb *ioc=
b, long ret)
> > >>         mempool_free(sio, sio_pool);
> > >>  }
> > >>
> > >> +static bool swap_read_folio_zeromap(struct folio *folio)
> > >> +{
> > >> +       unsigned int idx =3D swap_zeromap_folio_test(folio);
> > >> +
> > >> +       if (idx =3D=3D 0)
> > >> +               return false;
> > >> +
> > >> +       /*
> > >> +        * Swapping in a large folio that is partially in the zeroma=
p is not
> > >> +        * currently handled. Return true without marking the folio =
uptodate so
> > >> +        * that an IO error is emitted (e.g. do_swap_page() will sig=
bus).
> > >> +        */
> > >> +       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> > >> +               return true;
> > >
> > > Hi Usama, Yosry,
> > >
> > > I feel the warning is wrong as we could have the case where idx=3D=3D=
0
> > > is not zeromap but idx=3D1 is zeromap. idx =3D=3D 0 doesn't necessari=
ly
> > > mean we should return false.
> > >
> > > What about the below change which both fixes the warning and unblocks
> > > large folios swap-in?
> > >
> > Hi Barry,
> >
> > I remembered when resending the zeromap series about the comment Yosry =
had made earlier, but checked that the mTHP swap-in was not in mm-unstable.
> > I should have checked the mailing list and commented!
> >
> > I have not tested the below diff yet (will do in a few hours). But ther=
e might be a small issue with it. Have commented inline.
> >
> > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > index 4bc77d1c6bfa..7d7ff7064e2b 100644
> > > --- a/mm/page_io.c
> > > +++ b/mm/page_io.c
> > > @@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct foli=
o *folio)
> > >       }
> > >  }
> > >
> > > -/*
> > > - * Return the index of the first subpage which is not zero-filled
> > > - * according to swap_info_struct->zeromap.
> > > - * If all pages are zero-filled according to zeromap, it will return
> > > - * folio_nr_pages(folio).
> > > - */
> > > -static unsigned int swap_zeromap_folio_test(struct folio *folio)
> > > -{
> > > -     struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > > -     swp_entry_t entry;
> > > -     unsigned int i;
> > > -
> > > -     for (i =3D 0; i < folio_nr_pages(folio); i++) {
> > > -             entry =3D page_swap_entry(folio_page(folio, i));
> > > -             if (!test_bit(swp_offset(entry), sis->zeromap))
> > > -                     return i;
> > > -     }
> > > -     return i;
> > > -}
> > > -
> > >  /*
> > >   * We may have stale swap cache pages in memory: notice
> > >   * them here and get rid of the unnecessary final write.
> > > @@ -524,9 +504,10 @@ static void sio_read_complete(struct kiocb *iocb=
, long ret)
> > >
> > >  static bool swap_read_folio_zeromap(struct folio *folio)
> > >  {
> > > -     unsigned int idx =3D swap_zeromap_folio_test(folio);
> > > +     unsigned int nr_pages =3D folio_nr_pages(folio);
> > > +     unsigned int nr =3D swap_zeromap_entries_count(folio->swap, nr_=
pages);
> > >
> > > -     if (idx =3D=3D 0)
> > > +     if (nr =3D=3D 0)
> > >               return false;
> > >
> > >       /*
> > > @@ -534,7 +515,7 @@ static bool swap_read_folio_zeromap(struct folio =
*folio)
> > >        * currently handled. Return true without marking the folio upt=
odate so
> > >        * that an IO error is emitted (e.g. do_swap_page() will sigbus=
).
> > >        */
> > > -     if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> > > +     if (WARN_ON_ONCE(nr < nr_pages))
> > >               return true;
> > >
> > >       folio_zero_range(folio, 0, folio_size(folio));
> > > diff --git a/mm/swap.h b/mm/swap.h
> > > index f8711ff82f84..2d59e9d89e95 100644
> > > --- a/mm/swap.h
> > > +++ b/mm/swap.h
> > > @@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct=
 folio *folio)
> > >  {
> > >       return swp_swap_info(folio->swap)->flags;
> > >  }
> > > +
> > > +/*
> > > + * Return the number of entries which are zero-filled according to
> > > + * swap_info_struct->zeromap. It isn't precise if the return value
> > > + * is larger than 0 and smaller than nr to avoid extra iterations,
> > > + * In this case, it means entries haven't consistent zeromap.
> > > + */
> > > +static inline unsigned int swap_zeromap_entries_count(swp_entry_t en=
try, int nr)
> > > +{
> > > +     struct swap_info_struct *sis =3D swp_swap_info(entry);
> > > +     unsigned long offset =3D swp_offset(entry);
> > > +     unsigned int type =3D swp_type(entry);
> > > +     unsigned int n =3D 0;
> > > +
> > > +     for (int i =3D 0; i < nr; i++) {
> > > +             entry =3D swp_entry(type, offset + i);
> > > +             if (test_bit(offset + i, sis->zeromap)) {
> >
> > Should this be if (test_bit(swp_offset(entry), sis->zeromap))
> >
>
> well. i feel i have a much cheaper way to implement this, which
> can entirely iteration even in your original code:
>
> +/*
> + * Return the number of entries which are zero-filled according to
> + * swap_info_struct->zeromap. It isn't precise if the return value
> + * is 1 for nr > 1. In this case, it means entries have inconsistent
> + * zeromap.
> + */
> +static inline unsigned int swap_zeromap_entries_count(swp_entry_t
> entry, int nr)
> +{
> +       struct swap_info_struct *sis =3D swp_swap_info(entry);
> +       unsigned long start =3D swp_offset(entry);
> +       unsigned long end =3D start + nr;
> +       unsigned long idx =3D 0;
> +
> +       idx =3D find_next_bit(sis->zeromap, end, start);
> +       if (idx =3D=3D end)
> +               return 0;
> +       if (idx > start)
> +               return 1;

missed a case here:
        if (nr > 1 && find_next_zero_bit(sis->zeromap, end, start) !=3D end=
)
                return 1;

> +       return nr;
> +}
> +
>
>
> >
> > Also, are you going to use this in alloc_swap_folio?
> > You mentioned above that this unblocks large folios swap-in, but I don'=
t see
> > it in the diff here. I am guessing there is some change in alloc_swap_i=
nfo that
> > uses swap_zeromap_entries_count?
> >
> > Thanks
> > Usama
> >
> > > +                     if (i !=3D n)
> > > +                             return i;
> > > +                     n++;
> > > +             }
> > > +     }
> > > +
> > > +     return n;
> > > +}
> > > +
> > >  #else /* CONFIG_SWAP */
> > >  struct swap_iocb;
> > >  static inline void swap_read_folio(struct folio *folio, struct swap_=
iocb **plug)
> > > @@ -171,6 +197,11 @@ static inline unsigned int folio_swap_flags(stru=
ct folio *folio)
> > >  {
> > >       return 0;
> > >  }
> > > +
> > > +static inline unsigned int swap_zeromap_entries_count(swp_entry_t en=
try, int nr)
> > > +{
> > > +     return 0;
> > > +}
> > >  #endif /* CONFIG_SWAP */
> > >
> > >  #endif /* _MM_SWAP_H */
> > >
>
> Thanks
> Barry


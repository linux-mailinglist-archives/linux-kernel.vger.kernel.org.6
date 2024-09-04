Return-Path: <linux-kernel+bounces-316091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553AE96CAF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7996B1C2531C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BBF18453F;
	Wed,  4 Sep 2024 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWR2kKt6"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E55179958
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493458; cv=none; b=t2kFb40LDtTWeqdVjjs/Tgj8qASaXSyRKjZlxCsDzvwUlrtQyWsY4t/2z8B0vwWD1pLrRjRTtOe9McR0Azcs0yU8zIvTiqxxCetwXUfn4PutFWb8RDmZU1ymQ1BnRa3YRIflp5PxkY9t/pmV33Wab4FRs8U40w5LZiQFCQoNB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493458; c=relaxed/simple;
	bh=S9w8lugChK2Nstr+XW69hyN2R2V+OC1AdTT6/hRZK9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSTIn2SPXwEYprQYPYcLqUMBJ+7DyoogOfYMjMcInwkmcZEnn74BIe7fIqaT5ebdPQBl6IaQxKlKooBaK/aNM45eszMvc/S5ylJikwckt0f/cyZKuS6w3VnAvJPEVaJ8h2TSYVSyBFuiI5rdDsSVMyJVwxNetYVdcekRs0/r+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWR2kKt6; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4fd0d7fe6f6so67237e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725493455; x=1726098255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zB5UVch4ksIaA7qcUV1eGK3Oio2m7SaBWkqGsGQFfDA=;
        b=mWR2kKt6joLKgWy8iv3EuVD1R83atpH/6b6YTvEZpdq7iHz5Q2foZSQWJ/3pxRLjGb
         QMI1jvQNCwOp7qRwczRG2kUs1f6rCXIn+DqLpBkcZ+BIfEygod68xRWmTKPBgWs7dkip
         k+z4ZPNl5UW0J3hOpDALNMBQZZ1en8oQVn6CcZj+5C/P/4XgRyfeFmhsSFgGnjjLTl7k
         rwNf1rwA5t2X1ePKSTqYGBIv/02+iO4A+RqOjrhDQ8UE0QXYHlZRYKH1A79fongt0XSE
         W3U14Txv3Cegu0NAyJJLStToWF/vEBN80HwORLwRpL70QLwp7azAHqaEdGRRs+fmNmUV
         XAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725493455; x=1726098255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zB5UVch4ksIaA7qcUV1eGK3Oio2m7SaBWkqGsGQFfDA=;
        b=Uf7vp48EDPvmvvdTLZNLciSxPn+CoBYcCaFb/m1zfrWSdsgEaMDCs0Ue8ZGLQEDCt4
         DQtJEzB8D0CU3/bRJcHLpVpyUIFbQVIALHL7r+v2Si/TSo79q1uj2B/4EMUGxeoSugXE
         KMmxt8XGkJUNj9fom3snfOwxg4tuiD/NVWWu5VSLuDyDwG6/r5GZQtTF941i9V/dDl2W
         Oks+N4xCEyQvgj4t744po1+8s42jK7RvBjXjC55kZzDTBCHZQ5N4FnO2Zdary5AiHEOr
         v/p59aNKZ7syP09+pRxbdsC4svSjn8d2g2tjxHXGb8RxtKIm+vNTH53YvEElyQeD//TR
         cyIg==
X-Forwarded-Encrypted: i=1; AJvYcCUE92Cn/8uhmw0BpI6k8YKPE91+A8Oh/+gXe4FJzlcjJGZicqpHqieREOIdpxL/T1jJSllloD8IVImkbCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/xbh1JyZb3TqrP9esUc5H+3eFbsUh3uR0wHDJoFIcjADWf/U
	rSlkCkbcKKsxkE99zfqTtF9J82or8ZmjGwkHDa4CBWVuADsb7v1lYGK6nApD2sVt+6ORe7iM/0P
	uRUZx+iuFtozxUA7Q29QGHA8wEhk=
X-Google-Smtp-Source: AGHT+IEl7Mgtu0ZTre+YOtBOTfct0K77RB3XEeqrk62nBVuULXQYddih66G0J115d+M2qGKe2UGroXm1CxwagJCTsHw=
X-Received: by 2002:a05:6122:168e:b0:4f5:2276:136d with SMTP id
 71dfb90a1353d-5009affded1mr19415526e0c.1.1725493454742; Wed, 04 Sep 2024
 16:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <7a91ff31-1f56-4d0c-a4a7-a305331ba97a@gmail.com>
In-Reply-To: <7a91ff31-1f56-4d0c-a4a7-a305331ba97a@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Sep 2024 11:44:03 +1200
Message-ID: <CAGsJ_4xkbOP9UCDW8sqTeXJ-=V82CEyxbz2gEr_1BUgDwzw1_g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	shakeel.butt@linux.dev, willy@infradead.org, ying.huang@intel.com, 
	yosryahmed@google.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:14=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 04/09/2024 06:55, Barry Song wrote:
> > On Thu, Jun 13, 2024 at 12:48=E2=80=AFAM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >>
> >> Approximately 10-20% of pages to be swapped out are zero pages [1].
> >> Rather than reading/writing these pages to flash resulting
> >> in increased I/O and flash wear, a bitmap can be used to mark these
> >> pages as zero at write time, and the pages can be filled at
> >> read time if the bit corresponding to the page is set.
> >> With this patch, NVMe writes in Meta server fleet decreased
> >> by almost 10% with conventional swap setup (zswap disabled).
> >>
> >> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3=
d03d1344dde9fce0@epcms5p1/
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  include/linux/swap.h |   1 +
> >>  mm/page_io.c         | 114 ++++++++++++++++++++++++++++++++++++++++++=
-
> >>  mm/swapfile.c        |  24 ++++++++-
> >>  3 files changed, 136 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index a11c75e897ec..e88563978441 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -299,6 +299,7 @@ struct swap_info_struct {
> >>         signed char     type;           /* strange name for an index *=
/
> >>         unsigned int    max;            /* extent of the swap_map */
> >>         unsigned char *swap_map;        /* vmalloc'ed array of usage c=
ounts */
> >> +       unsigned long *zeromap;         /* vmalloc'ed bitmap to track =
zero pages */
> >>         struct swap_cluster_info *cluster_info; /* cluster info. Only =
for SSD */
> >>         struct swap_cluster_list free_clusters; /* free clusters list =
*/
> >>         unsigned int lowest_bit;        /* index of first free in swap=
_map */
> >> diff --git a/mm/page_io.c b/mm/page_io.c
> >> index a360857cf75d..39fc3919ce15 100644
> >> --- a/mm/page_io.c
> >> +++ b/mm/page_io.c
> >> @@ -172,6 +172,88 @@ int generic_swapfile_activate(struct swap_info_st=
ruct *sis,
> >>         goto out;
> >>  }
> >>
> >> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> >> +{
> >> +       unsigned long *data;
> >> +       unsigned int pos, last_pos =3D PAGE_SIZE / sizeof(*data) - 1;
> >> +       bool ret =3D false;
> >> +
> >> +       data =3D kmap_local_folio(folio, i * PAGE_SIZE);
> >> +       if (data[last_pos])
> >> +               goto out;
> >> +       for (pos =3D 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
> >> +               if (data[pos])
> >> +                       goto out;
> >> +       }
> >> +       ret =3D true;
> >> +out:
> >> +       kunmap_local(data);
> >> +       return ret;
> >> +}
> >> +
> >> +static bool is_folio_zero_filled(struct folio *folio)
> >> +{
> >> +       unsigned int i;
> >> +
> >> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> >> +               if (!is_folio_page_zero_filled(folio, i))
> >> +                       return false;
> >> +       }
> >> +       return true;
> >> +}
> >> +
> >> +static void folio_zero_fill(struct folio *folio)
> >> +{
> >> +       unsigned int i;
> >> +
> >> +       for (i =3D 0; i < folio_nr_pages(folio); i++)
> >> +               clear_highpage(folio_page(folio, i));
> >> +}
> >> +
> >> +static void swap_zeromap_folio_set(struct folio *folio)
> >> +{
> >> +       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> >> +       swp_entry_t entry;
> >> +       unsigned int i;
> >> +
> >> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> >> +               entry =3D page_swap_entry(folio_page(folio, i));
> >> +               set_bit(swp_offset(entry), sis->zeromap);
> >> +       }
> >> +}
> >> +
> >> +static void swap_zeromap_folio_clear(struct folio *folio)
> >> +{
> >> +       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> >> +       swp_entry_t entry;
> >> +       unsigned int i;
> >> +
> >> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> >> +               entry =3D page_swap_entry(folio_page(folio, i));
> >> +               clear_bit(swp_offset(entry), sis->zeromap);
> >> +       }
> >> +}
> >> +
> >> +/*
> >> + * Return the index of the first subpage which is not zero-filled
> >> + * according to swap_info_struct->zeromap.
> >> + * If all pages are zero-filled according to zeromap, it will return
> >> + * folio_nr_pages(folio).
> >> + */
> >> +static unsigned int swap_zeromap_folio_test(struct folio *folio)
> >> +{
> >> +       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> >> +       swp_entry_t entry;
> >> +       unsigned int i;
> >> +
> >> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> >> +               entry =3D page_swap_entry(folio_page(folio, i));
> >> +               if (!test_bit(swp_offset(entry), sis->zeromap))
> >> +                       return i;
> >> +       }
> >> +       return i;
> >> +}
> >> +
> >>  /*
> >>   * We may have stale swap cache pages in memory: notice
> >>   * them here and get rid of the unnecessary final write.
> >> @@ -195,6 +277,13 @@ int swap_writepage(struct page *page, struct writ=
eback_control *wbc)
> >>                 folio_unlock(folio);
> >>                 return ret;
> >>         }
> >> +
> >> +       if (is_folio_zero_filled(folio)) {
> >> +               swap_zeromap_folio_set(folio);
> >> +               folio_unlock(folio);
> >> +               return 0;
> >> +       }
> >> +       swap_zeromap_folio_clear(folio);
> >>         if (zswap_store(folio)) {
> >>                 folio_start_writeback(folio);
> >>                 folio_unlock(folio);
> >> @@ -426,6 +515,26 @@ static void sio_read_complete(struct kiocb *iocb,=
 long ret)
> >>         mempool_free(sio, sio_pool);
> >>  }
> >>
> >> +static bool swap_read_folio_zeromap(struct folio *folio)
> >> +{
> >> +       unsigned int idx =3D swap_zeromap_folio_test(folio);
> >> +
> >> +       if (idx =3D=3D 0)
> >> +               return false;
> >> +
> >> +       /*
> >> +        * Swapping in a large folio that is partially in the zeromap =
is not
> >> +        * currently handled. Return true without marking the folio up=
todate so
> >> +        * that an IO error is emitted (e.g. do_swap_page() will sigbu=
s).
> >> +        */
> >> +       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> >> +               return true;
> >
> > Hi Usama, Yosry,
> >
> > I feel the warning is wrong as we could have the case where idx=3D=3D0
> > is not zeromap but idx=3D1 is zeromap. idx =3D=3D 0 doesn't necessarily
> > mean we should return false.
> >
> > What about the below change which both fixes the warning and unblocks
> > large folios swap-in?
> >
> Hi Barry,
>
> I remembered when resending the zeromap series about the comment Yosry ha=
d made earlier, but checked that the mTHP swap-in was not in mm-unstable.
> I should have checked the mailing list and commented!
>
> I have not tested the below diff yet (will do in a few hours). But there =
might be a small issue with it. Have commented inline.
>
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index 4bc77d1c6bfa..7d7ff7064e2b 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio =
*folio)
> >       }
> >  }
> >
> > -/*
> > - * Return the index of the first subpage which is not zero-filled
> > - * according to swap_info_struct->zeromap.
> > - * If all pages are zero-filled according to zeromap, it will return
> > - * folio_nr_pages(folio).
> > - */
> > -static unsigned int swap_zeromap_folio_test(struct folio *folio)
> > -{
> > -     struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > -     swp_entry_t entry;
> > -     unsigned int i;
> > -
> > -     for (i =3D 0; i < folio_nr_pages(folio); i++) {
> > -             entry =3D page_swap_entry(folio_page(folio, i));
> > -             if (!test_bit(swp_offset(entry), sis->zeromap))
> > -                     return i;
> > -     }
> > -     return i;
> > -}
> > -
> >  /*
> >   * We may have stale swap cache pages in memory: notice
> >   * them here and get rid of the unnecessary final write.
> > @@ -524,9 +504,10 @@ static void sio_read_complete(struct kiocb *iocb, =
long ret)
> >
> >  static bool swap_read_folio_zeromap(struct folio *folio)
> >  {
> > -     unsigned int idx =3D swap_zeromap_folio_test(folio);
> > +     unsigned int nr_pages =3D folio_nr_pages(folio);
> > +     unsigned int nr =3D swap_zeromap_entries_count(folio->swap, nr_pa=
ges);
> >
> > -     if (idx =3D=3D 0)
> > +     if (nr =3D=3D 0)
> >               return false;
> >
> >       /*
> > @@ -534,7 +515,7 @@ static bool swap_read_folio_zeromap(struct folio *f=
olio)
> >        * currently handled. Return true without marking the folio uptod=
ate so
> >        * that an IO error is emitted (e.g. do_swap_page() will sigbus).
> >        */
> > -     if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> > +     if (WARN_ON_ONCE(nr < nr_pages))
> >               return true;
> >
> >       folio_zero_range(folio, 0, folio_size(folio));
> > diff --git a/mm/swap.h b/mm/swap.h
> > index f8711ff82f84..2d59e9d89e95 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct f=
olio *folio)
> >  {
> >       return swp_swap_info(folio->swap)->flags;
> >  }
> > +
> > +/*
> > + * Return the number of entries which are zero-filled according to
> > + * swap_info_struct->zeromap. It isn't precise if the return value
> > + * is larger than 0 and smaller than nr to avoid extra iterations,
> > + * In this case, it means entries haven't consistent zeromap.
> > + */
> > +static inline unsigned int swap_zeromap_entries_count(swp_entry_t entr=
y, int nr)
> > +{
> > +     struct swap_info_struct *sis =3D swp_swap_info(entry);
> > +     unsigned long offset =3D swp_offset(entry);
> > +     unsigned int type =3D swp_type(entry);
> > +     unsigned int n =3D 0;
> > +
> > +     for (int i =3D 0; i < nr; i++) {
> > +             entry =3D swp_entry(type, offset + i);
> > +             if (test_bit(offset + i, sis->zeromap)) {
>
> Should this be if (test_bit(swp_offset(entry), sis->zeromap))
>

well. i feel i have a much cheaper way to implement this, which
can entirely iteration even in your original code:

+/*
+ * Return the number of entries which are zero-filled according to
+ * swap_info_struct->zeromap. It isn't precise if the return value
+ * is 1 for nr > 1. In this case, it means entries have inconsistent
+ * zeromap.
+ */
+static inline unsigned int swap_zeromap_entries_count(swp_entry_t
entry, int nr)
+{
+       struct swap_info_struct *sis =3D swp_swap_info(entry);
+       unsigned long start =3D swp_offset(entry);
+       unsigned long end =3D start + nr;
+       unsigned long idx =3D 0;
+
+       idx =3D find_next_bit(sis->zeromap, end, start);
+       if (idx =3D=3D end)
+               return 0;
+       if (idx > start)
+               return 1;
+       return nr;
+}
+


>
> Also, are you going to use this in alloc_swap_folio?
> You mentioned above that this unblocks large folios swap-in, but I don't =
see
> it in the diff here. I am guessing there is some change in alloc_swap_inf=
o that
> uses swap_zeromap_entries_count?
>
> Thanks
> Usama
>
> > +                     if (i !=3D n)
> > +                             return i;
> > +                     n++;
> > +             }
> > +     }
> > +
> > +     return n;
> > +}
> > +
> >  #else /* CONFIG_SWAP */
> >  struct swap_iocb;
> >  static inline void swap_read_folio(struct folio *folio, struct swap_io=
cb **plug)
> > @@ -171,6 +197,11 @@ static inline unsigned int folio_swap_flags(struct=
 folio *folio)
> >  {
> >       return 0;
> >  }
> > +
> > +static inline unsigned int swap_zeromap_entries_count(swp_entry_t entr=
y, int nr)
> > +{
> > +     return 0;
> > +}
> >  #endif /* CONFIG_SWAP */
> >
> >  #endif /* _MM_SWAP_H */
> >

Thanks
Barry


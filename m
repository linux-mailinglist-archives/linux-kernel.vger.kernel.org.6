Return-Path: <linux-kernel+bounces-314393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE796B2A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF764282E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E9146018;
	Wed,  4 Sep 2024 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlEQvCtE"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B4130ADA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434251; cv=none; b=l8jdzBCMxXRBe/psLd7f7EOADbn0t9Ql+SAAWlZPxAhTlGLbn59F2ZJixgdT5NkrACDLGuBdk0wsSu/2g1v5zYaR8kVjMdx9cO8SGB5OF/BRExFulf3C5O9kMI4jrtanuhcoxRKNWqqcyW41k8GBJT25U0TWkxar0SKzQqX71JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434251; c=relaxed/simple;
	bh=bF3ZjD/tw+QGFCGtAx26RgjeRP4Zzre87khmU+x9URg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/DfSY+JzvDDB1lA/KJI830wIWkjqKW4256+f+iQeIuWvOZnAQiLXBXU+L6j0ZnVXYdIeD3jecks8QJvlIZdlFm7faj+lRFWsNyAG93CqusugsTqQ/eTeceydSq3LlR9WUM0SEPTPT1zQbxUcMAt0hbHWzZ2h3TP/0ujdWEz6Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlEQvCtE; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-846c4ec2694so1000902241.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725434249; x=1726039049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m53gn9oU2Gmb4XGafm+y8O/WGo92nnWgTKjnY2RkI3c=;
        b=BlEQvCtEtuLrBVxSGmgjI3n3uKnitxPEYnrhHkoIC8Uvs8zuJs39+4y+wESKDPc+6L
         XxJRX1a+rstCklEakvQ6Jo7aPf+Z4k9Uauxu/OdtVIyg/mB0u76vjetF28KbEg4Cwo5P
         AcDSbWy+NgkRTsITwiAO4pfIpp0Puc6xbGKK/hn0oM3r6/6X+pAN95RH0z67nVuXyl/X
         oC+hw4/ByFnqlS2I9MBPqlCHrNJucGD2/KPUH+ue18cew8dihsqo9J1xauFB604IjCub
         WKc08AwT2OPeJ+3rFXnJXIf7heZMDiTPNVBFWNLyPjBJ0hNFQG0drIn3A19WUVmKATzA
         8NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434249; x=1726039049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m53gn9oU2Gmb4XGafm+y8O/WGo92nnWgTKjnY2RkI3c=;
        b=VIOEApSmoCUlZv65N9TOfqpbU29D5Yb5+3s3arIuZcSQPa1Wcoy86a9coOwHDID/fm
         eECjcBUhzg3qoElA2q/Tt06z8g2e8iOZNvkJlYq21lhIunwQ0eKFwX0xZu9Ky2wWw4P+
         n0tAnqevMc7NL0TeVrcmS2idgIyKFStXTCTvzrdjkKjDjg94FFzkEiABTKUmDdlAEOhG
         Xg9lPxHKMU5HEcAGS0fLXZuv6DfmMKcyrja+8wFKwblSh461uX8bXVejg/IjKO+/bZ4V
         k/lCFHAzzY5KyqjA1QGWB4M3vDGPm4pscD71/gzEp5kQuTSRx5OXMxzkYzq3BpxuqeDl
         IUvA==
X-Forwarded-Encrypted: i=1; AJvYcCVyaQZqbOqOlmxktR+xVLZAuRqD/PNDvJm08CHWS6LFi43xyVi/TwBNnLP6id/htioYF8gFMB0g2oDSxJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPzNShw9U5APsq3U4rvn4wknBIT3LE76C5QzMEvBUl8M3/IJpC
	WPyxz5B003NF9BWKHoHs4QOpT2xBPZzC4hVYh0GQ4MrXuIVyJCG1dpPSxwomumMq3z9vp2PC5cl
	6hqAxSYT31Lm/4i90+gGbTeCl9d0=
X-Google-Smtp-Source: AGHT+IGT/af0TrsVSNkBeCAbwaAQwZphy+O2CC3+7hz7TlUrzzYtI0q9KoADO0Sdp+wRToUZlG4ZVG0NgrwEUcRexC4=
X-Received: by 2002:a05:6122:3695:b0:4f5:2a41:d10e with SMTP id
 71dfb90a1353d-5009dc39752mr14108187e0c.10.1725434248701; Wed, 04 Sep 2024
 00:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
In-Reply-To: <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 4 Sep 2024 19:17:17 +1200
Message-ID: <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 7:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> [..]
> > > @@ -426,6 +515,26 @@ static void sio_read_complete(struct kiocb *iocb=
, long ret)
> > >         mempool_free(sio, sio_pool);
> > >  }
> > >
> > > +static bool swap_read_folio_zeromap(struct folio *folio)
> > > +{
> > > +       unsigned int idx =3D swap_zeromap_folio_test(folio);
> > > +
> > > +       if (idx =3D=3D 0)
> > > +               return false;
> > > +
> > > +       /*
> > > +        * Swapping in a large folio that is partially in the zeromap=
 is not
> > > +        * currently handled. Return true without marking the folio u=
ptodate so
> > > +        * that an IO error is emitted (e.g. do_swap_page() will sigb=
us).
> > > +        */
> > > +       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> > > +               return true;
> >
> > Hi Usama, Yosry,
> >
> > I feel the warning is wrong as we could have the case where idx=3D=3D0
> > is not zeromap but idx=3D1 is zeromap. idx =3D=3D 0 doesn't necessarily
> > mean we should return false.
>
> Good catch. Yeah if idx =3D=3D 0 is not in the zeromap but other indices
> are we will mistakenly read the entire folio from swap.
>
> >
> > What about the below change which both fixes the warning and unblocks
> > large folios swap-in?
>
> But I don't see how that unblocks the large folios swap-in work? We
> still need to actually handle the case where a large folio being
> swapped in is partially in the zeromap. Right now we warn and unlock
> the folio without calling folio_mark_uptodate(), which emits an IO
> error.

I placed this in mm/swap.h so that during swap-in, it can filter out any la=
rge
folios where swap_zeromap_entries_count() is greater than 0 and less than
nr.

I believe this case would be quite rare, as it can only occur when some sma=
ll
folios that are swapped out happen to have contiguous and aligned swap
slots.

>
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index 4bc77d1c6bfa..7d7ff7064e2b 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio =
*folio)
> >         }
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
> > -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > -       swp_entry_t entry;
> > -       unsigned int i;
> > -
> > -       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> > -               entry =3D page_swap_entry(folio_page(folio, i));
> > -               if (!test_bit(swp_offset(entry), sis->zeromap))
> > -                       return i;
> > -       }
> > -       return i;
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
> > -       unsigned int idx =3D swap_zeromap_folio_test(folio);
> > +       unsigned int nr_pages =3D folio_nr_pages(folio);
> > +       unsigned int nr =3D swap_zeromap_entries_count(folio->swap, nr_=
pages);
> >
> > -       if (idx =3D=3D 0)
> > +       if (nr =3D=3D 0)
> >                 return false;
> >
> >         /*
> > @@ -534,7 +515,7 @@ static bool swap_read_folio_zeromap(struct folio *f=
olio)
> >          * currently handled. Return true without marking the folio upt=
odate so
> >          * that an IO error is emitted (e.g. do_swap_page() will sigbus=
).
> >          */
> > -       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> > +       if (WARN_ON_ONCE(nr < nr_pages))
> >                 return true;
> >
> >         folio_zero_range(folio, 0, folio_size(folio));
> > diff --git a/mm/swap.h b/mm/swap.h
> > index f8711ff82f84..2d59e9d89e95 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct f=
olio *folio)
> >  {
> >         return swp_swap_info(folio->swap)->flags;
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
> > +       struct swap_info_struct *sis =3D swp_swap_info(entry);
> > +       unsigned long offset =3D swp_offset(entry);
> > +       unsigned int type =3D swp_type(entry);
> > +       unsigned int n =3D 0;
> > +
> > +       for (int i =3D 0; i < nr; i++) {
> > +               entry =3D swp_entry(type, offset + i);
> > +               if (test_bit(offset + i, sis->zeromap)) {
> > +                       if (i !=3D n)
> > +                               return i;
> > +                       n++;
> > +               }
> > +       }
> > +
> > +       return n;
> > +}
> > +
> >  #else /* CONFIG_SWAP */
> >  struct swap_iocb;
> >  static inline void swap_read_folio(struct folio *folio, struct swap_io=
cb **plug)
> > @@ -171,6 +197,11 @@ static inline unsigned int folio_swap_flags(struct=
 folio *folio)
> >  {
> >         return 0;
> >  }
> > +
> > +static inline unsigned int swap_zeromap_entries_count(swp_entry_t entr=
y, int nr)
> > +{
> > +       return 0;
> > +}
> >  #endif /* CONFIG_SWAP */
> >
> >  #endif /* _MM_SWAP_H */
> >
> > > +
> > > +       folio_zero_fill(folio);
> > > +       folio_mark_uptodate(folio);
> > > +       return true;
> > > +}
> > > +
> > >  static void swap_read_folio_fs(struct folio *folio, struct swap_iocb=
 **plug)
> > >  {
> > >         struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > > @@ -515,8 +624,9 @@ void swap_read_folio(struct folio *folio, bool sy=
nchronous,
> > >                 psi_memstall_enter(&pflags);
> > >         }
> > >         delayacct_swapin_start();
> > > -
> > > -       if (zswap_load(folio)) {
> > > +       if (swap_read_folio_zeromap(folio)) {
> > > +               folio_unlock(folio);
> > > +       } else if (zswap_load(folio)) {
> > >                 folio_mark_uptodate(folio);
> > >                 folio_unlock(folio);
> > >         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index f1e559e216bd..48d8dca0b94b 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -453,6 +453,8 @@ static unsigned int cluster_list_del_first(struct=
 swap_cluster_list *list,
> > >  static void swap_cluster_schedule_discard(struct swap_info_struct *s=
i,
> > >                 unsigned int idx)
> > >  {
> > > +       unsigned int i;
> > > +
> > >         /*
> > >          * If scan_swap_map_slots() can't find a free cluster, it wil=
l check
> > >          * si->swap_map directly. To make sure the discarding cluster=
 isn't
> > > @@ -461,6 +463,13 @@ static void swap_cluster_schedule_discard(struct=
 swap_info_struct *si,
> > >          */
> > >         memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> > >                         SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> > > +       /*
> > > +        * zeromap can see updates from concurrent swap_writepage() a=
nd swap_read_folio()
> > > +        * call on other slots, hence use atomic clear_bit for zeroma=
p instead of the
> > > +        * non-atomic bitmap_clear.
> > > +        */
> > > +       for (i =3D 0; i < SWAPFILE_CLUSTER; i++)
> > > +               clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
> > >
> > >         cluster_list_add_tail(&si->discard_clusters, si->cluster_info=
, idx);
> > >
> > > @@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struc=
t *si, unsigned long idx)
> > >  static void swap_do_scheduled_discard(struct swap_info_struct *si)
> > >  {
> > >         struct swap_cluster_info *info, *ci;
> > > -       unsigned int idx;
> > > +       unsigned int idx, i;
> > >
> > >         info =3D si->cluster_info;
> > >
> > > @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap=
_info_struct *si)
> > >                 __free_cluster(si, idx);
> > >                 memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> > >                                 0, SWAPFILE_CLUSTER);
> > > +               for (i =3D 0; i < SWAPFILE_CLUSTER; i++)
> > > +                       clear_bit(idx * SWAPFILE_CLUSTER + i, si->zer=
omap);
> > >                 unlock_cluster(ci);
> > >         }
> > >  }
> > > @@ -1059,9 +1070,12 @@ static void swap_free_cluster(struct swap_info=
_struct *si, unsigned long idx)
> > >  {
> > >         unsigned long offset =3D idx * SWAPFILE_CLUSTER;
> > >         struct swap_cluster_info *ci;
> > > +       unsigned int i;
> > >
> > >         ci =3D lock_cluster(si, offset);
> > >         memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> > > +       for (i =3D 0; i < SWAPFILE_CLUSTER; i++)
> > > +               clear_bit(offset + i, si->zeromap);
> > >         cluster_set_count_flag(ci, 0, 0);
> > >         free_cluster(si, idx);
> > >         unlock_cluster(ci);
> > > @@ -1336,6 +1350,7 @@ static void swap_entry_free(struct swap_info_st=
ruct *p, swp_entry_t entry)
> > >         count =3D p->swap_map[offset];
> > >         VM_BUG_ON(count !=3D SWAP_HAS_CACHE);
> > >         p->swap_map[offset] =3D 0;
> > > +       clear_bit(offset, p->zeromap);
> > >         dec_cluster_info_page(p, p->cluster_info, offset);
> > >         unlock_cluster(ci);
> > >
> > > @@ -2597,6 +2612,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, s=
pecialfile)
> > >         free_percpu(p->cluster_next_cpu);
> > >         p->cluster_next_cpu =3D NULL;
> > >         vfree(swap_map);
> > > +       bitmap_free(p->zeromap);
> > >         kvfree(cluster_info);
> > >         /* Destroy swap account information */
> > >         swap_cgroup_swapoff(p->type);
> > > @@ -3123,6 +3139,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, s=
pecialfile, int, swap_flags)
> > >                 goto bad_swap_unlock_inode;
> > >         }
> > >
> > > +       p->zeromap =3D bitmap_zalloc(maxpages, GFP_KERNEL);
> > > +       if (!p->zeromap) {
> > > +               error =3D -ENOMEM;
> > > +               goto bad_swap_unlock_inode;
> > > +       }
> > > +
> > >         if (p->bdev && bdev_stable_writes(p->bdev))
> > >                 p->flags |=3D SWP_STABLE_WRITES;
> > >
> > > --
> > > 2.43.0
> > >
> > >

Thanks
barry


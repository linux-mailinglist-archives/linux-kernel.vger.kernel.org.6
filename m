Return-Path: <linux-kernel+bounces-314379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F94E96B288
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1598B23DE5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044114658C;
	Wed,  4 Sep 2024 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fF36zebq"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8683CA3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433974; cv=none; b=WbNrFinD6olIlhbF3x2tiunhVS68+9TewL4y3CeoqVb/+qZeCrdlIFHsU4WIsB9MR75QnovEr6ztCkDvmurvhphTCEnevKKX6Wy9kzZABGX00VB+Q492POcR6L1wXwJ64KMUBdpzRNrfaNk+AEqK6DeQowrm77WeOFqqgujDgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433974; c=relaxed/simple;
	bh=2tGsZYQUgcA/aT+AaxW1gVv062mbeC5r4UF7TsePd+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa+dx4my41xUnue5/BL7Ae9AwnBt8KmKX+hTFvAQm6iNg8FX+TEnz3kzzb3CbP1mwXGQ/RRSpduseoPbe6flB+L3UC12aFXHn4P0440DlxicpnYiPwr3yHI9R0kos7RC6knZtvSZObYVjTPhXyohYttAoCbZL0lo78MeUONWVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fF36zebq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a866cea40c4so719457766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725433970; x=1726038770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sF9gTMDRoHUxjCGKUN8c1P0f0J3cAsJjaAYSD6V8Zuc=;
        b=fF36zebqAuFbcIPREnqJ0ystiUVRWg/uac+NAfdZfmywERdp4BZ61WEW0KatmkrjVK
         GgJtLiMn52k/VOHFasnkH03eX8lkiqJNrMfmYKxx/5CiSA9ll6cTAgdD6NCwdwKfn3du
         +NGQmEeP4MoZNhzw8ZZ0pA+SVU/q2KJ9rm5c3/oHZ/T6E+7dmFtD2UDvIcvI7VrYo1w7
         fgiLAaLgiTgbMIPGeSnCYpBrbOWvt1RcsG7P+LRT9hi5ZMJxTmbHU2tv3trP/r07E2sB
         H8Yg5r11O/reVVgJWVzfNvMCG70gfYKLd6oHMSEsxmGuKpxqsXhYsRC/S+yeq2PuhEIw
         pg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725433970; x=1726038770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sF9gTMDRoHUxjCGKUN8c1P0f0J3cAsJjaAYSD6V8Zuc=;
        b=J/jlQimeugUtyGMDthw4yKUL+lBlGDJi8AecIfV795oTBnxXub8nZiCvMF6x4T4rtY
         Daz9GstIWon7Cw7DCSjIYZkHrQVGGMUra+3eVzaBjbYqLS9v4DwHIxyPciIGKcqA19BA
         kIuyo6Lbi4vz4Gg8OvajHmupo4KiISyRVmQDJz16dZ9hOmczVUkgIrnvZNNXduQhXgDe
         AHSvZy+QnJpe4LwKXsNNbX7Rg4zCMT7zCyggjmuQKEFsjkB04jVi4mRb7z7Kky/J9cNC
         d8wJQbkwQkcc8MRIsHf4X8LF+kN9sXzaUM+49c2tbH5ZOP/CM4OO1YW1oQxUTjtgDcBb
         2ojg==
X-Forwarded-Encrypted: i=1; AJvYcCWQEPKLR8t+IHxZl+8ZrpP/gvcJmGNncUMaQJucAfSyOqWE7HimIMzCyvn5pb0Bfpns3G/JRcHKw0RPbWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WowzPGdmmM4KiRjgRdltybJdvQ+zECKH1cy5jpU0YSUctS9s
	uHXlOFvoHRcBScGq+cUjt73Wla/WdE9a3c86zmvSEzsSbmRO8FfgpTdaUPGQk6C3ceJQ+lw8nXk
	pCOanisye3OSaotKeMSESzMwMBpydcyKcU8Qn
X-Google-Smtp-Source: AGHT+IGiKM8mRZKEWT/jJk3tEjBXHT0LpeR7ppkJxsh5gN6YpzFOyN1Wbo9+rxShvu6DKlg4OS7p30BqqlN/dPBXoOk=
X-Received: by 2002:a17:907:7290:b0:a86:ac86:1e17 with SMTP id
 a640c23a62f3a-a8a1d4c3496mr419921866b.54.1725433969516; Wed, 04 Sep 2024
 00:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com> <20240904055522.2376-1-21cnbao@gmail.com>
In-Reply-To: <20240904055522.2376-1-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 00:12:13 -0700
Message-ID: <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"

[..]
> > @@ -426,6 +515,26 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
> >         mempool_free(sio, sio_pool);
> >  }
> >
> > +static bool swap_read_folio_zeromap(struct folio *folio)
> > +{
> > +       unsigned int idx = swap_zeromap_folio_test(folio);
> > +
> > +       if (idx == 0)
> > +               return false;
> > +
> > +       /*
> > +        * Swapping in a large folio that is partially in the zeromap is not
> > +        * currently handled. Return true without marking the folio uptodate so
> > +        * that an IO error is emitted (e.g. do_swap_page() will sigbus).
> > +        */
> > +       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> > +               return true;
>
> Hi Usama, Yosry,
>
> I feel the warning is wrong as we could have the case where idx==0
> is not zeromap but idx=1 is zeromap. idx == 0 doesn't necessarily
> mean we should return false.

Good catch. Yeah if idx == 0 is not in the zeromap but other indices
are we will mistakenly read the entire folio from swap.

>
> What about the below change which both fixes the warning and unblocks
> large folios swap-in?

But I don't see how that unblocks the large folios swap-in work? We
still need to actually handle the case where a large folio being
swapped in is partially in the zeromap. Right now we warn and unlock
the folio without calling folio_mark_uptodate(), which emits an IO
error.

>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 4bc77d1c6bfa..7d7ff7064e2b 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *folio)
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
> -       struct swap_info_struct *sis = swp_swap_info(folio->swap);
> -       swp_entry_t entry;
> -       unsigned int i;
> -
> -       for (i = 0; i < folio_nr_pages(folio); i++) {
> -               entry = page_swap_entry(folio_page(folio, i));
> -               if (!test_bit(swp_offset(entry), sis->zeromap))
> -                       return i;
> -       }
> -       return i;
> -}
> -
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -524,9 +504,10 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>
>  static bool swap_read_folio_zeromap(struct folio *folio)
>  {
> -       unsigned int idx = swap_zeromap_folio_test(folio);
> +       unsigned int nr_pages = folio_nr_pages(folio);
> +       unsigned int nr = swap_zeromap_entries_count(folio->swap, nr_pages);
>
> -       if (idx == 0)
> +       if (nr == 0)
>                 return false;
>
>         /*
> @@ -534,7 +515,7 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>          * currently handled. Return true without marking the folio uptodate so
>          * that an IO error is emitted (e.g. do_swap_page() will sigbus).
>          */
> -       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> +       if (WARN_ON_ONCE(nr < nr_pages))
>                 return true;
>
>         folio_zero_range(folio, 0, folio_size(folio));
> diff --git a/mm/swap.h b/mm/swap.h
> index f8711ff82f84..2d59e9d89e95 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
>         return swp_swap_info(folio->swap)->flags;
>  }
> +
> +/*
> + * Return the number of entries which are zero-filled according to
> + * swap_info_struct->zeromap. It isn't precise if the return value
> + * is larger than 0 and smaller than nr to avoid extra iterations,
> + * In this case, it means entries haven't consistent zeromap.
> + */
> +static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry, int nr)
> +{
> +       struct swap_info_struct *sis = swp_swap_info(entry);
> +       unsigned long offset = swp_offset(entry);
> +       unsigned int type = swp_type(entry);
> +       unsigned int n = 0;
> +
> +       for (int i = 0; i < nr; i++) {
> +               entry = swp_entry(type, offset + i);
> +               if (test_bit(offset + i, sis->zeromap)) {
> +                       if (i != n)
> +                               return i;
> +                       n++;
> +               }
> +       }
> +
> +       return n;
> +}
> +
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
>  static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
> @@ -171,6 +197,11 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
>         return 0;
>  }
> +
> +static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry, int nr)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_SWAP */
>
>  #endif /* _MM_SWAP_H */
>
> > +
> > +       folio_zero_fill(folio);
> > +       folio_mark_uptodate(folio);
> > +       return true;
> > +}
> > +
> >  static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
> >  {
> >         struct swap_info_struct *sis = swp_swap_info(folio->swap);
> > @@ -515,8 +624,9 @@ void swap_read_folio(struct folio *folio, bool synchronous,
> >                 psi_memstall_enter(&pflags);
> >         }
> >         delayacct_swapin_start();
> > -
> > -       if (zswap_load(folio)) {
> > +       if (swap_read_folio_zeromap(folio)) {
> > +               folio_unlock(folio);
> > +       } else if (zswap_load(folio)) {
> >                 folio_mark_uptodate(folio);
> >                 folio_unlock(folio);
> >         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index f1e559e216bd..48d8dca0b94b 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -453,6 +453,8 @@ static unsigned int cluster_list_del_first(struct swap_cluster_list *list,
> >  static void swap_cluster_schedule_discard(struct swap_info_struct *si,
> >                 unsigned int idx)
> >  {
> > +       unsigned int i;
> > +
> >         /*
> >          * If scan_swap_map_slots() can't find a free cluster, it will check
> >          * si->swap_map directly. To make sure the discarding cluster isn't
> > @@ -461,6 +463,13 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
> >          */
> >         memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >                         SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> > +       /*
> > +        * zeromap can see updates from concurrent swap_writepage() and swap_read_folio()
> > +        * call on other slots, hence use atomic clear_bit for zeromap instead of the
> > +        * non-atomic bitmap_clear.
> > +        */
> > +       for (i = 0; i < SWAPFILE_CLUSTER; i++)
> > +               clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
> >
> >         cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
> >
> > @@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
> >  static void swap_do_scheduled_discard(struct swap_info_struct *si)
> >  {
> >         struct swap_cluster_info *info, *ci;
> > -       unsigned int idx;
> > +       unsigned int idx, i;
> >
> >         info = si->cluster_info;
> >
> > @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
> >                 __free_cluster(si, idx);
> >                 memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >                                 0, SWAPFILE_CLUSTER);
> > +               for (i = 0; i < SWAPFILE_CLUSTER; i++)
> > +                       clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
> >                 unlock_cluster(ci);
> >         }
> >  }
> > @@ -1059,9 +1070,12 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
> >  {
> >         unsigned long offset = idx * SWAPFILE_CLUSTER;
> >         struct swap_cluster_info *ci;
> > +       unsigned int i;
> >
> >         ci = lock_cluster(si, offset);
> >         memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> > +       for (i = 0; i < SWAPFILE_CLUSTER; i++)
> > +               clear_bit(offset + i, si->zeromap);
> >         cluster_set_count_flag(ci, 0, 0);
> >         free_cluster(si, idx);
> >         unlock_cluster(ci);
> > @@ -1336,6 +1350,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
> >         count = p->swap_map[offset];
> >         VM_BUG_ON(count != SWAP_HAS_CACHE);
> >         p->swap_map[offset] = 0;
> > +       clear_bit(offset, p->zeromap);
> >         dec_cluster_info_page(p, p->cluster_info, offset);
> >         unlock_cluster(ci);
> >
> > @@ -2597,6 +2612,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
> >         free_percpu(p->cluster_next_cpu);
> >         p->cluster_next_cpu = NULL;
> >         vfree(swap_map);
> > +       bitmap_free(p->zeromap);
> >         kvfree(cluster_info);
> >         /* Destroy swap account information */
> >         swap_cgroup_swapoff(p->type);
> > @@ -3123,6 +3139,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
> >                 goto bad_swap_unlock_inode;
> >         }
> >
> > +       p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
> > +       if (!p->zeromap) {
> > +               error = -ENOMEM;
> > +               goto bad_swap_unlock_inode;
> > +       }
> > +
> >         if (p->bdev && bdev_stable_writes(p->bdev))
> >                 p->flags |= SWP_STABLE_WRITES;
> >
> > --
> > 2.43.0
> >
> >


Return-Path: <linux-kernel+bounces-210452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001F89043CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049421C24B05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D97174F;
	Tue, 11 Jun 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl/d8ifD"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385F73473
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131162; cv=none; b=suY9iZPfRDjCwJK7kNFKkRBbLXZsqOaAbBFXmEX0to1WNzDqRlWaBocdnYUlUwlRMN1opj63OAx5woP7y1e5PWC5d0NvWqYErWX6Q02eo1dBQj2emvMTfWUHvzXCGTT8ygB+qoO8OTJRg1rW1hs85KX2haLz9RhsezKFwbL5pKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131162; c=relaxed/simple;
	bh=wbAaoWLPx2Oy80fYPSmUt15AboIsGp9JOTASkLDpdkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cE8pgFlA6Zi6GNv3JN0N+sweG/YwFvFGa9fyfm0XM6XRvscPnEyfZC7Z/tumMGxRcX75BJRPu15A7L/oIibbelmwOA/DinqsHi1/H9LvgEdMSEvh1mwYTIqpKiOhYcSY9lKn3ii08GkCORpIQhI7gll4AiEN1l0QyL/S23in6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl/d8ifD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7955dc86cacso160571485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718131159; x=1718735959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDkH2vvU0sx/oCEzi9/YBrjDW0qvg23Vl0BqpbWQ76E=;
        b=Dl/d8ifD2ImvNwHxbm39ea/9e99lioHQzgdARs6ZfZrN5FoIY6B5Y1AZVg+aw50p1g
         64+zCV1/WqNRmE4ToABTggiLK8tBbV2afBuGeyJlPWdpDDZ8Rds8yKiAjIFlGll8GixX
         fD+o7xdHeKKtvqSDad7udrejulf2+/gjn5zyMyAcdjWbMBbacs8zydNirBEOvdg9I+Dy
         gkMt6DBQSvUACBWxdHEJYN3SW4vAPNuqfIXgS5SnbAeQE/6rJrwuYInHVDx+4JaUCnZF
         4bNnmm5jvzkXrd209bqH9gvE0E9+FfK/J8i63d0xWt9tVdzSxfodbS2m6jeH5uOfNd8V
         1AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718131159; x=1718735959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDkH2vvU0sx/oCEzi9/YBrjDW0qvg23Vl0BqpbWQ76E=;
        b=iKGVCi1WdSGqeyobd8y+0SB37zkpBuMpZsjVUEDcWdiQ1yUMmJDz+ex71Zbr1CLalj
         LKNnB2jcxQJLshX92Xvre0oQfkRnHhEQxUXJMH2aShuT2MERrH6x3ic1rUrdy3Fr9JWn
         ck4x16KvLKMJ3sRHA1ankHbli3kDM/FRbbJ4cyHBlZsG5qR006TRlRHAbx6v/ppjFph3
         eZLopYwx1Q4dFHyF4J1eLg1bO/rfUHcf4YN0hiZx48zY+75AE45ljUeIO/Fjt62E+fBf
         M9B8VUR3abyOUcx0MPopPbpZa4ch1XvG4hYzvd9FV3Z8XE8fi0kbC7/s7G7FzKLZkzYj
         NvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsWJPcha6jKL3m1velqn/MjQsz3Srqh2Lp2SappLgs3Juv5mYKEBRM5ADgGhS2ZIfWcQ5IQllY64AfzwIeJHgswnStP19xfc5Bn2o6
X-Gm-Message-State: AOJu0YxnLz7avVyJJt4iVSUxsQ3/XKEeE1ep4+eJxt1iEnFV7bGc+9Pr
	tSfwC0tD6iDAHBu5NIVVbTfRvxpmbhDoGcjU/xS5u84haObkNJVRgGwQ20hk9z4QvEm9FA8cLC5
	7gX741UNUWiFqzsbL75zJkO+c9F8KqEHv
X-Google-Smtp-Source: AGHT+IE+NIIz+mkqTDA5bfcLoCUUMwh3Cs61+jxaywiEL9W/NJzHnHqaQgukA/NOFwUC2ffP9m7uK8A4usyeOXTvrBk=
X-Received: by 2002:ad4:5cc4:0:b0:6b0:71c0:cbaa with SMTP id
 6a1803df08f44-6b071c0cd62mr117404576d6.33.1718131159311; Tue, 11 Jun 2024
 11:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com> <20240610121820.328876-2-usamaarif642@gmail.com>
In-Reply-To: <20240610121820.328876-2-usamaarif642@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Jun 2024 11:39:08 -0700
Message-ID: <CAKEwX=PnwjmZKPLX2=ubD6+-+ZAqpXnczkHe4=1QY1hizOE8WQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:18=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).
>
> [1]https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d=
1344dde9fce0@epcms5p1/
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/swap.h |  1 +
>  mm/page_io.c         | 92 +++++++++++++++++++++++++++++++++++++++++++-
>  mm/swapfile.c        | 21 +++++++++-
>  3 files changed, 111 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a11c75e897ec..e88563978441 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -299,6 +299,7 @@ struct swap_info_struct {
>         signed char     type;           /* strange name for an index */
>         unsigned int    max;            /* extent of the swap_map */
>         unsigned char *swap_map;        /* vmalloc'ed array of usage coun=
ts */
> +       unsigned long *zeromap;         /* vmalloc'ed bitmap to track zer=
o pages */
>         struct swap_cluster_info *cluster_info; /* cluster info. Only for=
 SSD */
>         struct swap_cluster_list free_clusters; /* free clusters list */
>         unsigned int lowest_bit;        /* index of first free in swap_ma=
p */
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a360857cf75d..2cac1e11fb85 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -172,6 +172,82 @@ int generic_swapfile_activate(struct swap_info_struc=
t *sis,
>         goto out;
>  }
>
> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> +{
> +       unsigned long *data;
> +       unsigned int pos, last_pos =3D PAGE_SIZE / sizeof(*data) - 1;
> +       bool ret =3D false;
> +
> +       data =3D kmap_local_folio(folio, i * PAGE_SIZE);
> +       if (data[last_pos])
> +               goto out;
> +       for (pos =3D 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
> +               if (data[pos])
> +                       goto out;
> +       }
> +       ret =3D true;
> +out:
> +       kunmap_local(data);
> +       return ret;
> +}
> +
> +static bool is_folio_zero_filled(struct folio *folio)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> +               if (!is_folio_page_zero_filled(folio, i))
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +static void folio_zero_fill(struct folio *folio)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < folio_nr_pages(folio); i++)
> +               clear_highpage(folio_page(folio, i));
> +}
> +
> +static void swap_zeromap_folio_set(struct folio *folio)
> +{
> +       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       swp_entry_t entry;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> +               entry =3D page_swap_entry(folio_page(folio, i));
> +               set_bit(swp_offset(entry), sis->zeromap);
> +       }
> +}
> +
> +static void swap_zeromap_folio_clear(struct folio *folio)
> +{
> +       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       swp_entry_t entry;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> +               entry =3D page_swap_entry(folio_page(folio, i));
> +               clear_bit(swp_offset(entry), sis->zeromap);
> +       }
> +}
> +
> +static bool swap_zeromap_folio_test(struct folio *folio)
> +{
> +       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       swp_entry_t entry;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> +               entry =3D page_swap_entry(folio_page(folio, i));
> +               if (!test_bit(swp_offset(entry), sis->zeromap))
> +                       return false;
> +       }
> +       return true;
> +}
> +
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -195,6 +271,15 @@ int swap_writepage(struct page *page, struct writeba=
ck_control *wbc)
>                 folio_unlock(folio);
>                 return ret;
>         }
> +
> +       if (is_folio_zero_filled(folio)) {
> +               swap_zeromap_folio_set(folio);
> +               folio_start_writeback(folio);
> +               folio_unlock(folio);
> +               folio_end_writeback(folio);
> +               return 0;
> +       }
> +       swap_zeromap_folio_clear(folio);
>         if (zswap_store(folio)) {
>                 folio_start_writeback(folio);
>                 folio_unlock(folio);
> @@ -515,8 +600,11 @@ void swap_read_folio(struct folio *folio, bool synch=
ronous,
>                 psi_memstall_enter(&pflags);
>         }
>         delayacct_swapin_start();
> -
> -       if (zswap_load(folio)) {
> +       if (swap_zeromap_folio_test(folio)) {
> +               folio_zero_fill(folio);
> +               folio_mark_uptodate(folio);
> +               folio_unlock(folio);
> +       } else if (zswap_load(folio)) {
>                 folio_mark_uptodate(folio);
>                 folio_unlock(folio);
>         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f1e559e216bd..90451174fe34 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -453,6 +453,8 @@ static unsigned int cluster_list_del_first(struct swa=
p_cluster_list *list,
>  static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>                 unsigned int idx)
>  {
> +       unsigned int i;
> +
>         /*
>          * If scan_swap_map_slots() can't find a free cluster, it will ch=
eck
>          * si->swap_map directly. To make sure the discarding cluster isn=
't
> @@ -461,6 +463,13 @@ static void swap_cluster_schedule_discard(struct swa=
p_info_struct *si,
>          */
>         memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>                         SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> +       /*
> +        * zeromap can see updates from concurrent swap_writepage() and s=
wap_read_folio()
> +        * call on other slots, hence use atomic clear_bit for zeromap in=
stead of the
> +        * non-atomic bitmap_clear.
> +        */
> +       for (i =3D 0; i < SWAPFILE_CLUSTER; i++)
> +               clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
>
>         cluster_list_add_tail(&si->discard_clusters, si->cluster_info, id=
x);
>
> @@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struct *s=
i, unsigned long idx)
>  static void swap_do_scheduled_discard(struct swap_info_struct *si)
>  {
>         struct swap_cluster_info *info, *ci;
> -       unsigned int idx;
> +       unsigned int idx, i;
>
>         info =3D si->cluster_info;
>
> @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_inf=
o_struct *si)
>                 __free_cluster(si, idx);
>                 memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>                                 0, SWAPFILE_CLUSTER);
> +               for (i =3D 0; i < SWAPFILE_CLUSTER; i++)
> +                       clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap=
);
>                 unlock_cluster(ci);
>         }
>  }
> @@ -1336,6 +1347,7 @@ static void swap_entry_free(struct swap_info_struct=
 *p, swp_entry_t entry)
>         count =3D p->swap_map[offset];
>         VM_BUG_ON(count !=3D SWAP_HAS_CACHE);
>         p->swap_map[offset] =3D 0;
> +       clear_bit(offset, p->zeromap);

Hmm so clear_bit() is done at the swap_entry_free() point. I wonder if
we can have a problem, where:

1. The swap entry has its zeromap bit set, and is freed to the swap
slot cache (free_swap_slot() in mm/swap_slots.c). For instance, it is
reclaimed from the swap cache, and all the processes referring to it
are terminated, which decrements the swap count to 0 (swap_free() ->
__swap_entry_free() -> free_swap_slots())

2. The swap slot is then re-used in swap space allocation
(add_to_swap()) - its zeromap bit is never cleared.

3. swap_writepage() writes that non-zero page to swap

4. swap_read_folio() checks the bitmap, sees that the zeromap bit for
the entry is set, so populates a zero page for it.

zswap in the past has to carefully invalidate these leftover entries
quite carefully. Chengming then move the invalidation point to
free_swap_slot(), massively simplifying the logic.

I wonder if we need to do the same here?


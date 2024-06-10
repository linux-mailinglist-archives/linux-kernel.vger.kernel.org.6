Return-Path: <linux-kernel+bounces-208686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A1090281E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32861F232FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBEA1494B9;
	Mon, 10 Jun 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SsFUHLu"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978D1487F1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042276; cv=none; b=qK4RcYv/6uBPbyxWs6NY+n/hKmDfJB9iGPfjAC7diD6uvzTYlQho5WVgnn6wtCzZYo1+f6uE+DhsV5khznL41pv8+YD0cpu9BU2allmtzf8aLsQ2B2iwcNQy6XLQvwd9lJeYYSjrq+9YH7tH0vukYMIxIiH7UHs2agr0gjpb5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042276; c=relaxed/simple;
	bh=mwbaPY1tRyJxqqtoXiO5Znk5Z8EDlwAoWZwuT8B83Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otiTN8D+/KWsU9nwkW9E39Q64i5Rc4zy18sm/nMbC5xPILpOo+YhauYwXcz8LaY93xYeBPIqB10klKSIlUjWfpboIw3NPUrTyUBdy3Wdg5qotOBqWWlwKQ4TePc0gCvpTiyhw28LcmnWbenF9tbdYTeno6YxBQD1qrmrgEvrzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SsFUHLu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6265d48ec3so21408466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718042273; x=1718647073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my8rBSDNFMXTy2B3X50hr+IfkPRJN6JsCasbIN3wKCY=;
        b=0SsFUHLuwXqvhSGGOuCEHVUzPD+fej3OlVBc8QTachcyKowDAt/MsDxvRQqqkSfiG/
         tZGh2FCMqDgTPTAg4IHOQR3NRQIKCXYDpw0vqmTcHVnZnhozG8KYUY+0xJYzucT+YiZe
         l+SxyWsT/T4Ia14NKIvlJNKQI66rAiesnGjAzI3OHJxbYybHcGQOERb6DNskKmscDCmx
         WIps4IgtppBHT0fqGtEu94MvaxWlkSSz8/mJsPRYeRFCdQPPJF1c1Ndhunn97G4zN1XI
         EM1Vd4dLH70jROJjEeUFQuoT0CUvWMk3kIrMxXN8ydbXBmyHC90AbhkH8TbayfMBDVqb
         wuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042273; x=1718647073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my8rBSDNFMXTy2B3X50hr+IfkPRJN6JsCasbIN3wKCY=;
        b=pETiCRvGbyDsdw2xlGygeTJUOexa2Y1tU24hX9GPWZ8wb2laoPgKQ9cdLIigTLdsQH
         pKG+tx8OKnyyh0z1bGohWPFWrdHDMxhTg6I7EalzQ81LE2mc1ked7zXeqXRrRej1zlBj
         ZLGyqJ6/7jyYO/x5ej+VkASXV0f92+jmVVp5pkDZLiT6vffM0j7r3JjGCaEl86ofXm+b
         WctezOQw26YftG+w7zL32VKXsjbt9fQ1eScA0rQhauwewKeI9MDGCwU6JynWc2RoSiEq
         FIgl+Koyk7wTd1r82HW8NevVUsGdXzDssukI/5Auv7Oy0uw+kpL52EnClDs1gNWWlszP
         9Ytw==
X-Forwarded-Encrypted: i=1; AJvYcCX2H9d8gdJyDrVLoZULELJ2RtIJwydlBfwgNeUdugkRTi4HYmGjfpE+nesYVRRHgpBO6jZOMOT1iaGZiYCLIAtKsoAlBwLpB8SWT5TI
X-Gm-Message-State: AOJu0YzkLtWa7zFNJYV5BC4O9n2jtBcE7Pq6FlehxDmfPxosZw+mQWqb
	qS1cqPwZCtElPvkZU/J8CeJrz4iJYAn8eq0MQU3z5wxe3nGjJF+cAhJT5/1/c18V/GPn6FoZGgX
	Cw68iYyFvZhoSg7xP3TnaE6TG60ef3nlbLMyB
X-Google-Smtp-Source: AGHT+IEBHfoQhL6F9zBaAsTCyLUpr7BxcNYNgJmRd1FpTSD+czzESlJV7rT5+JJFYF5xpx806TcIqxu7NPu8+1yeUzU=
X-Received: by 2002:a17:906:2a14:b0:a6f:2448:a274 with SMTP id
 a640c23a62f3a-a6f2448a3f6mr172591966b.59.1718042272587; Mon, 10 Jun 2024
 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com> <20240610121820.328876-2-usamaarif642@gmail.com>
In-Reply-To: <20240610121820.328876-2-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 10:57:16 -0700
Message-ID: <CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
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

Is there any benefit to iterating on the folio in pages (i.e. have
both is_folio_zero_filled() and is_folio_page_zero_filled())? Why
don't we just kmap the entire folio and check it all at once?

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

We don't currently support swapping in large folios, but it is a work
in progress, and this will break once we have it.
swap_zeromap_folio_test() will return false even if parts of the folio
are in fact zero-filled. Then, we will go read those from disk swap,
essentially corrupting data.

The same problem can happen for zswap, if a large folio being swapped
is only partially in zswap. In both cases, it's really easy to miss
the problem if we're testing with zswap disabled, with incompressible
data, or with non-zero data. Silent data corruption is not very
debuggable.

I proposed adding handling for this case in zswap here:
https://lore.kernel.org/lkml/20240608023654.3513385-1-yosryahmed@google.com=
/

The discussions there hadn't settled yet, but depending on how it pans
out I suspect we will want something similar for the zeromap case as
well.

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
>         dec_cluster_info_page(p, p->cluster_info, offset);
>         unlock_cluster(ci);
>
> @@ -2597,6 +2609,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         free_percpu(p->cluster_next_cpu);
>         p->cluster_next_cpu =3D NULL;
>         vfree(swap_map);
> +       bitmap_free(p->zeromap);
>         kvfree(cluster_info);
>         /* Destroy swap account information */
>         swap_cgroup_swapoff(p->type);
> @@ -3123,6 +3136,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, speci=
alfile, int, swap_flags)
>                 goto bad_swap_unlock_inode;
>         }
>
> +       p->zeromap =3D bitmap_zalloc(maxpages, GFP_KERNEL);
> +       if (!p->zeromap) {
> +               error =3D -ENOMEM;
> +               goto bad_swap_unlock_inode;
> +       }
> +
>         if (p->bdev && bdev_stable_writes(p->bdev))
>                 p->flags |=3D SWP_STABLE_WRITES;
>
> --
> 2.43.0
>


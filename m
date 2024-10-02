Return-Path: <linux-kernel+bounces-346907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 941D198CADB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB5E2860A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB572107;
	Wed,  2 Oct 2024 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+kNCpUY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D248F40
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832833; cv=none; b=Dxut9vgBIvPXzQGVVVVXda+Sv4sVi9ios4tFlBBsVCFVpNteYy8oYyYyU/cY7KaTOD7ctyBOsjLqteO9RFzSHF7MtPUS2WcqsDBZ+GK6n7e+L04StUrzJMpOX6S76FTXzbP+fAy6ux6f6KeK0ns0Zo3cO7+fNZWiqWoAiyhz084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832833; c=relaxed/simple;
	bh=rZZ7rDg7oUWWXHSiW1MWM7VdFi4prDPtEizhmvJhiyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpj2RmSIZ+5Lve3YbthmGbFDwNA/SGW8OnrQOQhjy0VAAxiAKvBkYUopcpXNKo4m+34n+8vLmFogMwJjT/f5mbBJtKb4EFUITFiN9hDZ9BLy1gogEQIE4yQ8VSEEeyufmnGeeL/wksJ2O//4L3Xgt6QRgmE3iHiWFl1Pb+vIymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+kNCpUY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d60e23b33so907341666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727832830; x=1728437630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTSnTMyNZTOwo0t32cs6MGbO9x8fhKc49DjoEIEGpnw=;
        b=i+kNCpUYBz/Qhlufc/nZWTLO4MwrhavmfBwlP5dDaR+ohaJmpLs35ZowqIuRPKeEFy
         owLqqiHoGYoUybUKSMkWzJK0IJwgYG67pgY2XMBJgQ9yx3+mUW9sw7K3UG7RpI5lrseI
         z5bGaxXW/6WEtBDSV4cnvd93IufcOVbLZZjWf/BkNChxq07543mxglUJT/i5phyizicx
         Wrm+2V09DjG3YHyvJo05tCaUORKk9wI3k3FClMwAibVaGwqsCIWUIpitw383Vt5v+sXR
         QykPKcE50yT3P4jcqviTQP79btKoNq9rDuUA86eDDsi0qfDByGSWb42IVjoQ0pKrmnJQ
         ijBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832830; x=1728437630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTSnTMyNZTOwo0t32cs6MGbO9x8fhKc49DjoEIEGpnw=;
        b=CrpugBXx2nunaXApNIot40p+oPPe4FYqsCgOK7YbyR+K45c17r+YBmU/El/Hqhe+3i
         bJcctA9qWIUXKX7kOBfJ/+O9EIHw+RZjwAEoIMOmsmCEg0PDTBPy7DFBrniPS2C6PEI8
         SL0b7g91ANsARC50nDcbOVLCsKMMOvV03XHXSJ5czofaq/xL34pBJ4Y3l6+CX501hZY6
         Atcq8aeC9E6LVAmxGdYSF/klPi9chE1vaJRJSwQ67GrNqmB+L1xxikuVyu9sZyxFVjlA
         Onh3oFgvA8FKaFF7p5jndOs3OXJJycRqC3xumNx9rhksf1ZItCb6GFqMoszEym+vuIAp
         p8Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWoezGP8bJiZ8PCmMsHB1ZpLaZ75pblJ0eu4j+0U2nhdo5hOPFyg53XICmq35+K7jJc+bv6buCz8GpLZIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqgL/q7pj0U8ytSMCwKKx3/jggqS9JwXwmxGKv2fL0+ctk9tpl
	4csHQfX9n8IjcVgWdA7YQauTvGpudlKM8QYYrWbdo9ln48KN6CvJ8ldp0BtYL7/7EmDs/c8IXVB
	sjcfOpLZBVRXDj47D0LeENjhcxpKs1Kezdpcx
X-Google-Smtp-Source: AGHT+IGTDQRoOwxwmBuGYVvNXvu/jxHtkl/Zpt9fVApOACkOXvRtX2CraxUrT0FgEQnBRBEG5AWEot9k5sl9DNH+ESg=
X-Received: by 2002:a17:907:96a1:b0:a86:7e2d:f10b with SMTP id
 a640c23a62f3a-a98f8264d7amr112888766b.37.1727832829476; Tue, 01 Oct 2024
 18:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <20241002012042.2753174-2-nphamcs@gmail.com>
In-Reply-To: <20241002012042.2753174-2-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 1 Oct 2024 18:33:12 -0700
Message-ID: <CAJD7tkaFv_KmF4gM=wb_Rwi7S1Dt4yy+TU=TyMd1R=gx=3eWuA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:20=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> The SWAP_MAP_SHMEM state was introduced in the commit aaa468653b4a
> ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if a swap entry
> belongs to shmem during swapoff.
>
> However, swapoff has since been rewritten in the commit b56a2d8af914
> ("mm: rid swapoff of quadratic complexity"). Now having swap count =3D=3D
> SWAP_MAP_SHMEM value is basically the same as having swap count =3D=3D 1,
> and swap_shmem_alloc() behaves analogously to swap_duplicate(). The only
> difference of note is that swap_shmem_alloc() does not check for
> -ENOMEM returned from __swap_duplicate(), but it is OK because shmem
> never re-duplicates any swap entry it owns. This will stil be safe if we
> use (batched) swap_duplicate() instead.
>
> This commit adds swap_duplicate_nr(), the batched variant of
> swap_duplicate(), and removes the SWAP_MAP_SHMEM state and the
> associated swap_shmem_alloc() helper to simplify the state machine (both
> mentally and in terms of actual code). We will also have an extra
> state/special value that can be repurposed (for swap entries that never
> gets re-duplicated).
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/swap.h | 16 ++++++++--------
>  mm/shmem.c           |  2 +-
>  mm/swapfile.c        | 41 +++++++++++++++++++++--------------------
>  3 files changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index ca533b478c21..017f3c03ff7a 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -232,7 +232,6 @@ enum {
>  /* Special value in first swap_map */
>  #define SWAP_MAP_MAX   0x3e    /* Max count */
>  #define SWAP_MAP_BAD   0x3f    /* Note page is bad */
> -#define SWAP_MAP_SHMEM 0xbf    /* Owned by shmem/tmpfs */
>
>  /* Special value in each swap_map continuation */
>  #define SWAP_CONT_MAX  0x7f    /* Max count */
> @@ -482,8 +481,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t =
entry);
>  extern swp_entry_t get_swap_page_of_type(int);
>  extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> -extern void swap_shmem_alloc(swp_entry_t, int);
> -extern int swap_duplicate(swp_entry_t);
> +extern int swap_duplicate_nr(swp_entry_t, int);
>  extern int swapcache_prepare(swp_entry_t entry, int nr);
>  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> @@ -549,11 +547,7 @@ static inline int add_swap_count_continuation(swp_en=
try_t swp, gfp_t gfp_mask)
>         return 0;
>  }
>
> -static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
> -{
> -}
> -
> -static inline int swap_duplicate(swp_entry_t swp)
> +static inline int swap_duplicate_nr(swp_entry_t swp, int nr)
>  {
>         return 0;
>  }
> @@ -606,6 +600,12 @@ static inline int add_swap_extent(struct swap_info_s=
truct *sis,
>  }
>  #endif /* CONFIG_SWAP */
>
> +static inline int swap_duplicate(swp_entry_t entry)
> +{
> +       return swap_duplicate_nr(entry, 1);
> +}
> +
> +

Nit: extra blank line.

>  static inline void free_swap_and_cache(swp_entry_t entry)
>  {
>         free_swap_and_cache_nr(entry, 1);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0613421e09e7..e3f72f99be32 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1561,7 +1561,7 @@ static int shmem_writepage(struct page *page, struc=
t writeback_control *wbc)
>                         __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
>                         NULL) =3D=3D 0) {
>                 shmem_recalc_inode(inode, 0, nr_pages);
> -               swap_shmem_alloc(swap, nr_pages);
> +               swap_duplicate_nr(swap, nr_pages);
>                 shmem_delete_from_page_cache(folio, swp_to_radix_entry(sw=
ap));
>
>                 mutex_unlock(&shmem_swaplist_mutex);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0cded32414a1..9bb94e618914 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1381,12 +1381,6 @@ static unsigned char __swap_entry_free_locked(stru=
ct swap_info_struct *si,
>         if (usage =3D=3D SWAP_HAS_CACHE) {
>                 VM_BUG_ON(!has_cache);
>                 has_cache =3D 0;
> -       } else if (count =3D=3D SWAP_MAP_SHMEM) {
> -               /*
> -                * Or we could insist on shmem.c using a special
> -                * swap_shmem_free() and free_shmem_swap_and_cache()...
> -                */
> -               count =3D 0;
>         } else if ((count & ~COUNT_CONTINUED) <=3D SWAP_MAP_MAX) {
>                 if (count =3D=3D COUNT_CONTINUED) {
>                         if (swap_count_continued(si, offset, count))
> @@ -3626,7 +3620,6 @@ static int __swap_duplicate(swp_entry_t entry, unsi=
gned char usage, int nr)
>
>         offset =3D swp_offset(entry);
>         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> -       VM_WARN_ON(usage =3D=3D 1 && nr > 1);
>         ci =3D lock_cluster_or_swap_info(si, offset);
>
>         err =3D 0;
> @@ -3652,6 +3645,13 @@ static int __swap_duplicate(swp_entry_t entry, uns=
igned char usage, int nr)
>                                 err =3D -EEXIST;
>                 } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
>                         err =3D -EINVAL;
> +               } else {
> +                       /*
> +                        * The only swap_duplicate_nr() caller that passe=
s nr > 1 is shmem,
> +                        * who never re-duplicates any swap entry it owns=
. So this should

nit: I think "which" is the right word here, but I am not a native speaker =
:)

> +                        * not happen.
> +                        */
> +                       VM_WARN_ON(nr > 1 && (count & ~COUNT_CONTINUED) =
=3D=3D SWAP_MAP_MAX);

Why not return an error in this case? I think we should add recovery
for bugs when it's possible and simple, which I believe is the case
here.

In shmem_writepage() we can add a WARN if swap_duplicate_nr() fails,
or propagate an error to the caller as well (perhaps this belongs in a
separate patch that does this for swap_shmem_alloc() first).

Sorry if I am being paranoid here, please let me know if this is the case.

>                 }
>
>                 if (err)
> @@ -3686,27 +3686,28 @@ static int __swap_duplicate(swp_entry_t entry, un=
signed char usage, int nr)
>         return err;
>  }
>
> -/*
> - * Help swapoff by noting that swap entry belongs to shmem/tmpfs
> - * (in which case its reference count is never incremented).
> - */
> -void swap_shmem_alloc(swp_entry_t entry, int nr)
> -{
> -       __swap_duplicate(entry, SWAP_MAP_SHMEM, nr);
> -}
> -
> -/*
> - * Increase reference count of swap entry by 1.
> +/**
> + * swap_duplicate_nr() - Increase reference count of nr contiguous swap =
entries
> + *                       by 1.

Can we avoid the line break by using "refcount" instead of "reference count=
"?

> + *
> + * @entry: first swap entry from which we want to increase the refcount.
> + * @nr: Number of entries in range.
> + *
>   * Returns 0 for success, or -ENOMEM if a swap_count_continuation is req=
uired
>   * but could not be atomically allocated.  Returns 0, just as if it succ=
eeded,
>   * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), =
which
>   * might occur if a page table entry has got corrupted.
> + *
> + * Note that we are currently not handling the case where nr > 1 and we =
need to
> + * add swap count continuation. This is OK, because no such user exists =
- shmem
> + * is the only user that can pass nr > 1, and it never re-duplicates any=
 swap
> + * entry it owns.

Do we need this comment when we have the WARN + comment in __swap_duplicate=
()?

>   */
> -int swap_duplicate(swp_entry_t entry)
> +int swap_duplicate_nr(swp_entry_t entry, int nr)
>  {
>         int err =3D 0;
>
> -       while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM)
> +       while (!err && __swap_duplicate(entry, 1, nr) =3D=3D -ENOMEM)
>                 err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
>         return err;
>  }
> --
> 2.43.5


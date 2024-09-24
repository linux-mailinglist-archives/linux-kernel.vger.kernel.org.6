Return-Path: <linux-kernel+bounces-336417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9E983A98
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C43E1C2171C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 00:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D871C32;
	Tue, 24 Sep 2024 00:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xd2XEVpx"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F718D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727137974; cv=none; b=exNDQ1gU5sExlkUrIav/US8xkcQVulGFJrPPgjhGRc3AW5BTGyZroS6wqM01uOrQP9b+p/wRZSiyWHluiGZU4QBMOIdyrUhc+vMZ3qjFMC7PB0G7JLaNZhIaKi/xB6p2OBKOgEYn3CeqDFqxd63C3ghwWPodmFJtBnPHwA25n7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727137974; c=relaxed/simple;
	bh=wCld+delo5SrbK4WPqtjaVJB23guheh/8FDyLz3W8ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6PEo/8936TF+qhq1Uhqav7PIi9QVy9Qcfedpg8EvLEnGxYEpQld4+BpVTvkyarFfxbrRd3R43P44Tac8yDuFrztvI+TCOnzPlvjsjns4Do7tuoigdhrHL6CNNyNILlP+tOBYbNC6jnNcQzDSkCKHusqp2sbUAgkVsko/s7IeLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xd2XEVpx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d2daa2262so641218366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727137971; x=1727742771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7mc2p+2Jck8sDD3ZoIb1R82s20ZBjvKNc7tKmgur9M=;
        b=Xd2XEVpxjezQqY5G9JLWBzOO8b4swwpVmjzv/P4f1Hcii4W5L8hUnOJfTyN18/QzmY
         HnxqaJPeEd8viDHLsygIGakUF3F/ucql0qxYNvvAlF1E+7IYMCFJm1YjAm9bd/8803FG
         hQo0zxIyrK/ObipI7tZUpyloHksok8u8lqP3BBY09+aZVqZYd076KkbGKzGg31oLcbgx
         mUHFYsMxbY0GC///ry55Gqujq/7aA/2ELX9e+NDtYNnIBzDrv3KjwvvldoS95lO9vaZC
         DfQUEoP76MJo1DKMYAiNdku7hWx82Uxp4XFXr0zY8A9xvYrMxhzLziQCooxM+Qmc5bZ7
         WH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727137971; x=1727742771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7mc2p+2Jck8sDD3ZoIb1R82s20ZBjvKNc7tKmgur9M=;
        b=b+lZeVQ8Z1/0HiDi2wR3AObULzyWrNW6gkGw1Yu124QAkj2IsgisUtSG2aU0iQS6El
         l84vk8xrdf8mgxv7Dy5HqeCUXMwlUD43j8F2/xmUxgfB+tAf715CuHS3eb4Dl5suFwJc
         mly5jyt6L+SeyGMoEjYOIyrA3y/aWPx/QkG6IaCB5sc2HVIqGXdkfarQM14Hc5Uv6pb8
         /ecDac46NpkQYsl0Zh7Z8sbbOQ9OGOEFNHUrU1mfNqOUPLQWcx7luGp/GhdSUZD0PFBL
         9WL8FfxiMJHlmqjWXUgOdVHafbI3bpMnHUhIjUdhm2GUhw62RJiteTgWLxEEKltpA/zY
         nqWA==
X-Forwarded-Encrypted: i=1; AJvYcCXvuMNTnyhYwc3UKmVK51ThY4Y+wianKypYGwrX5toU3k1j0Tv58mIppwfAuUsboGPskn8zD5LGT4qWSgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyyaDiX9Xi/sm666RINZy3PhShcfhH0dMEhm1TvJ6FAmZO0+wy
	aLmxFuiAS/TirZjbOd9XAZdJ7CAVPKpjCJk7DOM+yvXCx+qx8jaVfHNXj4TFggTF3aFUdfvT/QI
	Z7bf7LaF2yznEXhNDi3MXzIzGsSWFpvUk2YOo
X-Google-Smtp-Source: AGHT+IFd4kw9b/7lDpmusBy8E04RK0NQNVnjwp3zx4Jo21hSTepyuUd1A7R6O/pR/57fGcI+h3W8VRP01s4zgQkUhcM=
X-Received: by 2002:a17:906:d7d0:b0:a8a:926a:cfff with SMTP id
 a640c23a62f3a-a90d501ad26mr1374564866b.27.1727137970215; Mon, 23 Sep 2024
 17:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <20240923231142.4155415-3-nphamcs@gmail.com>
In-Reply-To: <20240923231142.4155415-3-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 23 Sep 2024 17:32:14 -0700
Message-ID: <CAJD7tkZziEBd7QAiNXsZgd27k_tRSYNOC72iyojmG2aJD=mwYw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] swap: shmem: remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> The SWAP_MAP_SHMEM state was introduced in the commit aaa468653b4a
> ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if a swap entry
> belongs to shmem during swapoff.
>
> However, swapoff has since been rewritten in the commit b56a2d8af914
> ("mm: rid swapoff of quadratic complexity"). Now having swap count =3D=3D
> SWAP_MAP_SHMEM value is basically the same as having swap count =3D=3D 1,
> and swap_shmem_alloc() behaves analogously to swap_duplicate().

It's probably useful to point out that swap_shmem_alloc() is
equivalent to swap_duplicate() because __swap_duplicate() should never
return -ENOMEM for shmem, as we only ever increment the swap count by
1 (for each entry).

>
> Remove this state and the associated helper to simplify the state
> machine (both mentally and in terms of actual code). We will also have
> an extra state/special value that can be repurposed (for swap entries
> that never gets re-duplicated).
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/swap.h |  6 ------
>  mm/shmem.c           |  2 +-
>  mm/swapfile.c        | 15 ---------------
>  3 files changed, 1 insertion(+), 22 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index e6ab234be7be..017f3c03ff7a 100644
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
> @@ -482,7 +481,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t =
entry);
>  extern swp_entry_t get_swap_page_of_type(int);
>  extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> -extern void swap_shmem_alloc(swp_entry_t, int);
>  extern int swap_duplicate_nr(swp_entry_t, int);
>  extern int swapcache_prepare(swp_entry_t entry, int nr);
>  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> @@ -549,10 +547,6 @@ static inline int add_swap_count_continuation(swp_en=
try_t swp, gfp_t gfp_mask)
>         return 0;
>  }
>
> -static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
> -{
> -}
> -
>  static inline int swap_duplicate_nr(swp_entry_t swp, int nr)
>  {
>         return 0;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 361affdf3990..1875f2521dc6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1559,7 +1559,7 @@ static int shmem_writepage(struct page *page, struc=
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
> index 47a2cd5f590d..cebc244ee60f 100644
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
> @@ -3686,15 +3680,6 @@ static int __swap_duplicate(swp_entry_t entry, uns=
igned char usage, int nr)
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
>  /**
>   * swap_duplicate_nr() - Increase reference count of nr contiguous swap =
entries
>   *                       by 1.
> --
> 2.43.5


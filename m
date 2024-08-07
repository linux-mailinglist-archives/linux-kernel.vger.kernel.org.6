Return-Path: <linux-kernel+bounces-277508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615F94A254
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33CB285502
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C71C9DE0;
	Wed,  7 Aug 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ7XTtpg"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847AB1C9DD9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017758; cv=none; b=Umhcf8A80Sf06de0bmIM5Sl20y9A3Q1ANFU/55Ql5VW3jDTNvxG+sXN/UE77F3CyooDTC8mepjBhmmbCUGfM9ADNZopK4dYOQGt3R/vrNjjtpaLrgJWIdtEPXmKd3QELXg0VGpJkg9FkuXTw42ybOOs6I0MWW12BBjKOds2NIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017758; c=relaxed/simple;
	bh=aIMiyZiVaHy10m8mxq1vpUxxSsxkODEwGQFmQgbwAUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4FT1aITHJC7LCCcG6/J9lpNZuEVQIpH/+HVuoeSoD/4drimv8yg5WcbpBSPVvfJHm6Pj676GNVfH4E1NwHnMzV96I2W7Ot6TpQEnbIv5kQThe8AwTtYfhp4SkUL/VU52tdPGfsdTexjQUptWlmYGqs9OgSeI4xbDlz/B2xuvpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ7XTtpg; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-492a76c0cfbso439801137.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723017755; x=1723622555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrC1zyhgI13/nLN4qEM/vJhW0qbHo7qD5kYtXY0vUn4=;
        b=SQ7XTtpgm7O00z1HurkVthnGhy2SRuwUkBHw7rL2ctmM0DtrqoGw5c3BqL9kivGX6Y
         PDhaMQkJH+Ol/oxdHBlLjhOd1wUauNytxRedOwhkznosPnXrypoN79NWw+4RF0GOmO7D
         wyk4P4vAyfbGp4PrLriMn12XlpjM9W9T6oucPdubnecjvLqcNbCGqDXkVgs0OdrdStqP
         dNZLmXzFd0+ys1O+/6JKByA1VWrfR0n78JcWmuK6hJRS3Wa1F2O4guSHBF+WfP8KnMQ1
         A25FTAuek7g99Y8EZlYcauoth+hstAZljBUNbhxk7pUDF/5YSA6ilj3a+QRzWpL2N7vg
         HseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017755; x=1723622555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrC1zyhgI13/nLN4qEM/vJhW0qbHo7qD5kYtXY0vUn4=;
        b=aMUMNYBO61TPMnoIewQNWk2im6nG17Sz1Y8OW002bcDzirJRQiALODZZkK02xNe+vn
         hTWDs7IYRs9jhtJ/I0C/feWaRnkAQgwJINrkTBdb4iJLv3nr2jHgDSzepvqgoFMRYyQ8
         jQtqNLcQdQXiKpUbsqX4weKsyD6981k8x4LdarfrGZbjGwGij2LddlZiLfXlqmXZPrkQ
         OXzGBPLdLJBl1HFz166qaaVMfkVzoxSQWixdC8bBWMSVVgVuLhulIejkivw4U5tHpj8q
         uoJ4UgNUzncbwsvaRUmcgrI4LcDbyhoW3DO2B3QhLQb1fXWF67/2fb3T0iOMfU7T/Z2b
         15mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnXNJ6O6Kf+8slX580pnMtbgzcpjfZCMwVAFxvhRe7Bp3MmviP52kP0fdmTsd9eRteGv+GsNYhyo2T6IRo73Mjf2cnA1Oqzs8i+12t
X-Gm-Message-State: AOJu0YxD3Xcq9r/RNq55F5xu2AHG/vFaDYYoG8vLnw5FVf5qMybTsM4+
	zZBKZ0QfwDTb2dYnCI0+1NXDBm1ra/SFI/k7oAlmFMV2B1A/Mt+t4Ctas1pEVQOw3bwpIqoKe8q
	aGTUAf5M/ohet9KLZyHRgcelzTAk=
X-Google-Smtp-Source: AGHT+IGDeVEkcFRK2EhFGcYSbbGbZ0gsGUWaUdS6Ykzr5I4kI8nBtwdDG6GYt/r1raX/X/atHihbdcuNWrW3pR7Vshc=
X-Received: by 2002:a05:6102:f0f:b0:492:aa42:e0cd with SMTP id
 ada2fe7eead31-4945bf24f3amr22339260137.29.1723017755163; Wed, 07 Aug 2024
 01:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com> <af23b3bdee8ade5bb44706c7c3058d07d6d369ac.1723012159.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <af23b3bdee8ade5bb44706c7c3058d07d6d369ac.1723012159.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Aug 2024 20:02:24 +1200
Message-ID: <CAGsJ_4wFNDQ8vJDjt70kG+pShi13_BDa7P2=DtoNZ8Ypy+Gd0w@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] mm: swap: extend swap_shmem_alloc() to support
 batch SWAP_MAP_SHMEM flag setting
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org, 
	ying.huang@intel.com, ryan.roberts@arm.com, shy828301@gmail.com, 
	ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com, 
	p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:31=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> To support shmem large folio swap operations, add a new parameter to
> swap_shmem_alloc() that allows batch SWAP_MAP_SHMEM flag setting for
> shmem swap entries.
>
> While we are at it, using folio_nr_pages() to get the number of pages
> of the folio as a preparation.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/swap.h | 4 ++--
>  mm/shmem.c           | 6 ++++--
>  mm/swapfile.c        | 4 ++--
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 1c8f844a9f0f..248db1dd7812 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -481,7 +481,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t =
entry);
>  extern swp_entry_t get_swap_page_of_type(int);
>  extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> -extern void swap_shmem_alloc(swp_entry_t);
> +extern void swap_shmem_alloc(swp_entry_t, int);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t entry, int nr);
>  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> @@ -548,7 +548,7 @@ static inline int add_swap_count_continuation(swp_ent=
ry_t swp, gfp_t gfp_mask)
>         return 0;
>  }
>
> -static inline void swap_shmem_alloc(swp_entry_t swp)
> +static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
>  {
>  }
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4a5254bfd610..22cdc10f27ea 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1452,6 +1452,7 @@ static int shmem_writepage(struct page *page, struc=
t writeback_control *wbc)
>         struct shmem_sb_info *sbinfo =3D SHMEM_SB(inode->i_sb);
>         swp_entry_t swap;
>         pgoff_t index;
> +       int nr_pages;
>
>         /*
>          * Our capabilities prevent regular writeback or sync from ever c=
alling
> @@ -1484,6 +1485,7 @@ static int shmem_writepage(struct page *page, struc=
t writeback_control *wbc)
>         }
>
>         index =3D folio->index;
> +       nr_pages =3D folio_nr_pages(folio);
>
>         /*
>          * This is somewhat ridiculous, but without plumbing a SWAP_MAP_F=
ALLOC
> @@ -1536,8 +1538,8 @@ static int shmem_writepage(struct page *page, struc=
t writeback_control *wbc)
>         if (add_to_swap_cache(folio, swap,
>                         __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
>                         NULL) =3D=3D 0) {
> -               shmem_recalc_inode(inode, 0, 1);
> -               swap_shmem_alloc(swap);
> +               shmem_recalc_inode(inode, 0, nr_pages);
> +               swap_shmem_alloc(swap, nr_pages);
>                 shmem_delete_from_page_cache(folio, swp_to_radix_entry(sw=
ap));
>
>                 mutex_unlock(&shmem_swaplist_mutex);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ea023fc25d08..88d73880aada 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3604,9 +3604,9 @@ static int __swap_duplicate(swp_entry_t entry, unsi=
gned char usage, int nr)
>   * Help swapoff by noting that swap entry belongs to shmem/tmpfs
>   * (in which case its reference count is never incremented).
>   */
> -void swap_shmem_alloc(swp_entry_t entry)
> +void swap_shmem_alloc(swp_entry_t entry, int nr)
>  {
> -       __swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
> +       __swap_duplicate(entry, SWAP_MAP_SHMEM, nr);
>  }
>
>  /*
> --
> 2.39.3
>


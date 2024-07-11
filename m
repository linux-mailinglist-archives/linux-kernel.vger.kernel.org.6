Return-Path: <linux-kernel+bounces-248786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED692E1FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A521F262F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9641514E0;
	Thu, 11 Jul 2024 08:20:26 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC709150991
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686026; cv=none; b=VmUmd+iE5UXlEBdZyuZQcpNaQJ6NOfRyclGoroI9lgcvgLDfdsAquzthLHGO2PEG+X6KRvMR16VzUtoRUqSckbX1lDptvAAHlBhU9vdnBUpR4aCrbTNg+8EklSDjhGXIh6DcdCpkDt8mC01Rw32TOI8bbfIzKrPjGwt50hdjpxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686026; c=relaxed/simple;
	bh=KveHD5jbOQSZxWufNAA3bAkBfec+cpCYz7p5urYAGCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JV9pMXMsAB4lyqBAdn3EMhcG80ULTXqffEKF26N3sOfjJGjm0tmWrSs24lP8EH1IXEN18NCnfMthbTJaWXdcaYeN/wSIPVytLKOAan+cGJumm71iT14jAqOVponJn6MedXlPbxGBET+KvaCM6eptLbMylMwexCPehTAwfE1cJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-80d61a602f2so212763241.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686024; x=1721290824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9V55ZdXNpFXSzjKazk2BYhj7255MteXQT8lNoXNpGQ=;
        b=IjWkc+u2KJ37QJX1NIubHANeI166u9zQiBitYZNFwSoEHGiBIvimnTum9BkH5bwlFA
         kDVQojCx8rSMkFeXHz/dSwCtmi8aHdSsOwz12voOhz2F1L6KRnfQ42xXiJFjtQXzYR1O
         KCKguLOuaSDDQsw2VMzU3CbSKi1dTxOzz1SFeuXR+PoX+mwFuc3yYP2oe2Uu+IwiUF8u
         oSfG02Lf7XF5GjWaQqzAyicajIndI3oohh65mVg5L4t8c5RPHDHXUbo819CjiVEVAfOr
         CjPzqZaopxmpUD5/+PsKtx6oDFyOwoFUrNphtrVuC913ke8kK1G60lSHXMgis2zbU20R
         waAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9jDaVbHIGx1Zm52LafGwSJcQPXSG66zhvJXMKlEMsyaEd/+T56PLMGH9yTf3m4Eg0ISskSZRsqTBgQd2GOCD+wwTuWnTR5A5Nrqux
X-Gm-Message-State: AOJu0Yx9afmDZ6z+EsMqmkwBA686BGWIiOVPjshZX06vQlZedwGn8gtH
	wcZeLMv4R6Xwb2RDwoeEfN6ccbKyOvyQyGRd7raWvqBcEraK39lQj/Las/qzCg4Da5owjF2Vn5H
	DLmmvbSVYY6bLhMkTH2QmLitQNOg=
X-Google-Smtp-Source: AGHT+IFNBlRV01qSTvUsWyfoF8g9J4oirMD1z8dQwaHLBy8K+0V9gAVsMNYkNJYu5EBpY4r8z8Ad5pQGJ14uh/6bzuU=
X-Received: by 2002:a05:6102:4413:b0:48f:e638:270f with SMTP id
 ada2fe7eead31-490321166b4mr9803091137.9.1720686023612; Thu, 11 Jul 2024
 01:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711072929.3590000-1-ryan.roberts@arm.com> <20240711072929.3590000-2-ryan.roberts@arm.com>
In-Reply-To: <20240711072929.3590000-2-ryan.roberts@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 11 Jul 2024 20:20:11 +1200
Message-ID: <CAGsJ_4zzZAjsBU0H9yL55pKW5yym4D+YExTVqXC=wkyC4ixnMQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm: Cleanup count_mthp_stat() definition
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 7:29=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Let's move count_mthp_stat() so that it's always defined, even when THP
> is disabled. Previously uses of the function in files such as shmem.c,
> which are compiled even when THP is disabled, required ugly THP
> ifdeferry. With this cleanup, we can remove those ifdefs and the
> function resolves to a nop when THP is disabled.
>
> I shortly plan to call count_mthp_stat() from more THP-invariant source
> files.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/huge_mm.h | 70 ++++++++++++++++++++---------------------
>  mm/memory.c             |  2 --
>  mm/shmem.c              |  6 ----
>  3 files changed, 35 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index cff002be83eb..cb93b9009ce4 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -108,6 +108,41 @@ extern struct kobj_attribute thpsize_shmem_enabled_a=
ttr;
>  #define HPAGE_PUD_MASK (~(HPAGE_PUD_SIZE - 1))
>  #define HPAGE_PUD_SIZE ((1UL) << HPAGE_PUD_SHIFT)
>
> +enum mthp_stat_item {
> +       MTHP_STAT_ANON_FAULT_ALLOC,
> +       MTHP_STAT_ANON_FAULT_FALLBACK,
> +       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +       MTHP_STAT_SWPOUT,
> +       MTHP_STAT_SWPOUT_FALLBACK,
> +       MTHP_STAT_SHMEM_ALLOC,
> +       MTHP_STAT_SHMEM_FALLBACK,
> +       MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> +       MTHP_STAT_SPLIT,
> +       MTHP_STAT_SPLIT_FAILED,
> +       MTHP_STAT_SPLIT_DEFERRED,
> +       __MTHP_STAT_COUNT
> +};
> +
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
> +struct mthp_stat {
> +       unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUN=
T];
> +};
> +
> +DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> +
> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> +{
> +       if (order <=3D 0 || order > PMD_ORDER)
> +               return;
> +
> +       this_cpu_inc(mthp_stats.stats[order][item]);
> +}
> +#else
> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> +{
> +}
> +#endif
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>
>  extern unsigned long transparent_hugepage_flags;
> @@ -263,41 +298,6 @@ struct thpsize {
>
>  #define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
>
> -enum mthp_stat_item {
> -       MTHP_STAT_ANON_FAULT_ALLOC,
> -       MTHP_STAT_ANON_FAULT_FALLBACK,
> -       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> -       MTHP_STAT_SWPOUT,
> -       MTHP_STAT_SWPOUT_FALLBACK,
> -       MTHP_STAT_SHMEM_ALLOC,
> -       MTHP_STAT_SHMEM_FALLBACK,
> -       MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> -       MTHP_STAT_SPLIT,
> -       MTHP_STAT_SPLIT_FAILED,
> -       MTHP_STAT_SPLIT_DEFERRED,
> -       __MTHP_STAT_COUNT
> -};
> -
> -struct mthp_stat {
> -       unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUN=
T];
> -};
> -
> -#ifdef CONFIG_SYSFS
> -DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> -
> -static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> -{
> -       if (order <=3D 0 || order > PMD_ORDER)
> -               return;
> -
> -       this_cpu_inc(mthp_stats.stats[order][item]);
> -}
> -#else
> -static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> -{
> -}
> -#endif
> -
>  #define transparent_hugepage_use_zero_page()                           \
>         (transparent_hugepage_flags &                                   \
>          (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> diff --git a/mm/memory.c b/mm/memory.c
> index 802d0d8a40f9..a50fdefb8f0b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4597,9 +4597,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>
>         folio_ref_add(folio, nr_pages - 1);
>         add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
> -#endif
>         folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
>         folio_add_lru_vma(folio, vma);
>  setpte:
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f24dfbd387ba..fce1343f44e6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1776,9 +1776,7 @@ static struct folio *shmem_alloc_and_add_folio(stru=
ct vm_fault *vmf,
>
>                         if (pages =3D=3D HPAGE_PMD_NR)
>                                 count_vm_event(THP_FILE_FALLBACK);
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>                         count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
> -#endif
>                         order =3D next_order(&suitable_orders, order);
>                 }
>         } else {
> @@ -1803,10 +1801,8 @@ static struct folio *shmem_alloc_and_add_folio(str=
uct vm_fault *vmf,
>                                 count_vm_event(THP_FILE_FALLBACK);
>                                 count_vm_event(THP_FILE_FALLBACK_CHARGE);
>                         }
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>                         count_mthp_stat(folio_order(folio), MTHP_STAT_SHM=
EM_FALLBACK);
>                         count_mthp_stat(folio_order(folio), MTHP_STAT_SHM=
EM_FALLBACK_CHARGE);
> -#endif
>                 }
>                 goto unlock;
>         }
> @@ -2180,9 +2176,7 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>                 if (!IS_ERR(folio)) {
>                         if (folio_test_pmd_mappable(folio))
>                                 count_vm_event(THP_FILE_ALLOC);
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>                         count_mthp_stat(folio_order(folio), MTHP_STAT_SHM=
EM_ALLOC);
> -#endif
>                         goto alloced;
>                 }
>                 if (PTR_ERR(folio) =3D=3D -EEXIST)
> --
> 2.43.0
>


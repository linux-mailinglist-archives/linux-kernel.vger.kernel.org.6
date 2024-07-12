Return-Path: <linux-kernel+bounces-250604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7892F9C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D37E1F21EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE1316B395;
	Fri, 12 Jul 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOY0Nmtj"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161D2BB15
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785475; cv=none; b=pJwTyDZB0ybAamPyW0e4KCYBfeaByH9H/X874yPZCWaOv054O632zYrsG2a0CPk/lUHoUczr1a7UCA5SlaHyKxcrNFfBXcDxvzdxZ/xgfS3/a1cne+qq9WkG338ekuqndp68sifJveNhgJWYlyDT21R8mOHE4oeWr+9fgxEtVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785475; c=relaxed/simple;
	bh=7Qqy+IG8HfTOjrRLFebwJ1QuWP1RWx3EgQY3EYfBte4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmjPbqYz0D5mpc17y/suSnRVwSP3X4ZDleI8eUn4MW0qKULdupCju8R4wLHwMpGOU0FFU5LCgAFyy+IMiFB38zPFwbyq2kScz8JfRnev+fp2Ut3UI4Po4qngaZ4BoRKMwa+c4TGf7/Sf/e2ABRUobakHnMKs46v6JrwSrvwF6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOY0Nmtj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so2384102a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720785472; x=1721390272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb168vXXnQI2V8n1uRl3KKSKYvLL9f0nbmEpaLbcWdc=;
        b=iOY0NmtjDKnO5UscSBCZJ2CGWQQQh+mH8y/v4u1esKT6fL4/D0N6ZaoFah2ALulgbL
         U+PTooKzq5CdzFwNjaoLz7xuXsWyu3wPu0jCDbnW+V6IyXzz1DQuLt9KtEACVmHr1DMW
         bcux/e+3Fmhrbvip820pA/+LJ7URV/y0AfprGMzkFQK70gz3Rrk9w+FMVAdYqJIFUb+h
         hGmW6bW2k0XPFI36e6wRiHoRWGRB4ySp3yuwbIqW8Y6NPbxCSBsw3sK0IVqya+ajW5M7
         Hy9tXCbGTlFlkE2Y7XeeuXxq8KWr+q0kccZd6r6Lv2qDdj02g2GE/eqGXyDwE+FzwWwV
         8GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720785472; x=1721390272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vb168vXXnQI2V8n1uRl3KKSKYvLL9f0nbmEpaLbcWdc=;
        b=tNiE9ZgfksvdyJi6IyV0yujARDHwm8uVgT2g6ziiuzPkAclz7loUlJjJLfqVumSQ/+
         44kyfg89R5ReV5vhWD8aKoXw9vCpwchDUj8fFvA3BtZjDlj42clL2Pu+fPW00Kgg+lxs
         37z5RHiTPSiqBHERvCSgv59p0SXo261bhtrdQi1IEzVxhMOV8UG3EmOYXH0o2i3VJa19
         OUJU1eXM2gMZD64b+LQfjTwmXNTzO/axdH1GZyegaB2kOJhQWRfGEOzXDISLDn3EmzB6
         WZEWUDzzLf/g4XDXe6RrdginaAtwnkvlKTrCrGBxi4yHyRdI6+sr8Kq4oPXtF7S/f0gM
         JYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOa5N75aqUGZ5Mt4MqIuWSoyQkiMyBXmk2An8CLArPmwosx0sR27C6Bi5SnEptsA6qFpJWXUajWMCAwYNqO0sdIKH2EgAqBTIsdZ5A
X-Gm-Message-State: AOJu0Ywgbs6hbw3cDafVCgMevOb89hA0zGGyt3uwUCmU2FpoM0+pxZCO
	oLAN/Ywub4sXgmpZXjrfzzgg+lrn6mLvqxUSP+Druqyq2PAt55NrgT+JPcfq5zY3UHWOt8j4YD9
	ColyKpLJO6fHZTxP/vPEkFbG/KSg=
X-Google-Smtp-Source: AGHT+IFaomkXOuM9XjTzQrrVc5d4DV3ytdrZ0q1r67q8x7HFSvLZmmvJLfSdqpVjkt0y1naLZRhvyYp0eoRtdHKGt+M=
X-Received: by 2002:aa7:c346:0:b0:57d:30b6:4281 with SMTP id
 4fb4d7f45d1cf-594bc7c811amr6655873a12.29.1720785471662; Fri, 12 Jul 2024
 04:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711072929.3590000-1-ryan.roberts@arm.com> <20240711072929.3590000-2-ryan.roberts@arm.com>
In-Reply-To: <20240711072929.3590000-2-ryan.roberts@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 12 Jul 2024 19:57:40 +0800
Message-ID: <CAK1f24=PLew0zzpWWy4kEAr6qr2G+u3iJdr=wcv1-W5KVq3C6w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm: Cleanup count_mthp_stat() definition
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 3:29=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
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

LGTM. Feel free to add:

Reviewed-by: Lance Yang <ioworker0@gmail.com>


Thanks,
Lance

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


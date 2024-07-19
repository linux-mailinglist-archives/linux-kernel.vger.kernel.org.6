Return-Path: <linux-kernel+bounces-256859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F58937172
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C96A2818A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B3A47;
	Fri, 19 Jul 2024 00:12:29 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BB161
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721347949; cv=none; b=qcs3EPcCFsqcMCpoOIQE2OVeAsYwJ5FATLFNSGgstO7W9Zi9wpXuXfFi7q/z8euVM1LR1COqwAnRhGIxuzvbJV7bCvPE1EXuyhU5qfF/xmNcmXaHaXfJKonNqY5pka/LrTYSe+rcOs5G7kIMg3dSjaX4FfB4N6OfYj02mC/z/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721347949; c=relaxed/simple;
	bh=WZ4IsgZdPLMw2NfAXtR0EfRwrb6s7VWu2GAufhb5AlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPwLIYerEtXa2GL9dLNOzwZsMoWNBjdV/aTqcQNLyFRGxy1QnLPphIKXWkobIp4ib3cnpJa6qrJwQDaIgFnPAl8J4hnA9L02qsLa0cZD27dAxw1Lk0eB+DGAFwxLQUc/g2t34gfbN372jeTOwgf3kfnwZIvKDWXOyIJ1FFkLD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-80fc4fe7a8eso633636241.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721347946; x=1721952746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwRbeEDrk/1wNx9bV9ON1gbANQ3HFETpf7KZdJnrPVU=;
        b=rSfKZuw60XVxwc9msxWbo9A7nr9RWK53RuSfux6J8HuR7nwh5+4ifuHhbG8QSML137
         0aiUMtEAMhISoZY1alVD1cWRs7tPITVvoXbFAMOxUxj+d+lHDCaUq7l3y5/pnCoeL1Gs
         yMSw4lCY2g7HADpm2owRdD1vLQH4K7iI1nRrtJ59dgOcMnrp1sAqZO/NamC31m9OIGfz
         McBQ9hoTJH3jP0qV+GeVMQq6I/J232lv0/dVoOr4wp0d8UACWiTtA/DhSXsWjSTMWDWp
         X8hz2ro+155K+mmg7w9r+iYVbPx7rKw5n+rK3OPX0YnYFLQ5xd2v1/Wo5NP0mY3g45pQ
         dR5w==
X-Forwarded-Encrypted: i=1; AJvYcCUc2IAwWNCu0VGJrKy9d7sHQurnqWUMSVuX+XWAojo8WCoPjq6Dct/desoGCulkbXSzoj8FSV2/CoNke4imqDhiBLET5ZLIcr3Y0cZQ
X-Gm-Message-State: AOJu0YwsJbANjpWLCfFLXBwRdsxSetIlgXPNzNtIyiStIrAYaEKRvp+r
	4M5wXaqT8LCwHvzzEKxv10vpt0eF1HAPQMdxanufXKWDe4bWvuvNvSVYq6BMz/69sgFdpQvSZjS
	R9tHPSOAHjUkBb+loBTon2oyHS+0=
X-Google-Smtp-Source: AGHT+IGcC4f4akF/lDVIeZVidNIqfNqfjNRQGAIuZgaWAIRA+xrVqVT/El1EwmjXD9f0YBaSNvGYXrbmizb9aw2uHQY=
X-Received: by 2002:a05:6102:3f12:b0:48d:a44a:aa00 with SMTP id
 ada2fe7eead31-492629920e3mr4998093137.14.1721347946275; Thu, 18 Jul 2024
 17:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716135907.4047689-1-ryan.roberts@arm.com> <20240716135907.4047689-4-ryan.roberts@arm.com>
In-Reply-To: <20240716135907.4047689-4-ryan.roberts@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 19 Jul 2024 12:12:15 +1200
Message-ID: <CAGsJ_4xfiVNH-cQtD_rMrHvzx1a9Ap6CcqsqbxyAEOTB-9Jvhw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: mTHP stats for pagecache folio allocations
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 1:59=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Expose 3 new mTHP stats for file (pagecache) folio allocations:
>
>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_alloc
>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback
>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback_c=
harge
>
> This will provide some insight on the sizes of large folios being
> allocated for file-backed memory, and how often allocation is failing.
>
> All non-order-0 (and most order-0) folio allocations are currently done
> through filemap_alloc_folio(), and folios are charged in a subsequent
> call to filemap_add_folio(). So count file_fallback when allocation
> fails in filemap_alloc_folio() and count file_alloc or
> file_fallback_charge in filemap_add_folio(), based on whether charging
> succeeded or not. There are some users of filemap_add_folio() that
> allocate their own order-0 folio by other means, so we would not count
> an allocation failure in this case, but we also don't care about order-0
> allocations. This approach feels like it should be good enough and
> doesn't require any (impractically large) refactoring.
>
> The existing mTHP stats interface is reused to provide consistency to
> users. And because we are reusing the same interface, we can reuse the
> same infrastructure on the kernel side.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 13 +++++++++++++
>  include/linux/huge_mm.h                    |  3 +++
>  include/linux/pagemap.h                    | 16 ++++++++++++++--
>  mm/filemap.c                               |  6 ++++--
>  mm/huge_memory.c                           |  7 +++++++
>  5 files changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 058485daf186..d4857e457add 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -512,6 +512,19 @@ shmem_fallback_charge
>         falls back to using small pages even though the allocation was
>         successful.
>
> +file_alloc
> +       is incremented every time a file huge page is successfully
> +       allocated.
> +
> +file_fallback
> +       is incremented if a file huge page is attempted to be allocated
> +       but fails and instead falls back to using small pages.
> +
> +file_fallback_charge
> +       is incremented if a file huge page cannot be charged and instead
> +       falls back to using small pages even though the allocation was
> +       successful.
> +

I realized that when we talk about fallback, it doesn't necessarily mean
small pages; it could also refer to smaller huge pages.

anon_fault_alloc
        is incremented every time a huge page is successfully
        allocated and charged to handle a page fault.

anon_fault_fallback
        is incremented if a page fault fails to allocate or charge
        a huge page and instead falls back to using huge pages with
        lower orders or small pages.

anon_fault_fallback_charge
        is incremented if a page fault fails to charge a huge page and
        instead falls back to using huge pages with lower orders or
        small pages even though the allocation was successful.

This also applies to files, right?

                do {
                        gfp_t alloc_gfp =3D gfp;

                        err =3D -ENOMEM;
                        if (order > 0)
                                alloc_gfp |=3D __GFP_NORETRY | __GFP_NOWARN=
;
                        folio =3D filemap_alloc_folio(alloc_gfp, order);
                        if (!folio)
                                continue;

                        /* Init accessed so avoid atomic
mark_page_accessed later */
                        if (fgp_flags & FGP_ACCESSED)
                                __folio_set_referenced(folio);

                        err =3D filemap_add_folio(mapping, folio, index, gf=
p);
                        if (!err)
                                break;
                        folio_put(folio);
                        folio =3D NULL;
                } while (order-- > 0);


>  split
>         is incremented every time a huge page is successfully split into
>         smaller orders. This can happen for a variety of reasons but a
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index b8c63c3e967f..4f9109fcdded 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -123,6 +123,9 @@ enum mthp_stat_item {
>         MTHP_STAT_SHMEM_ALLOC,
>         MTHP_STAT_SHMEM_FALLBACK,
>         MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> +       MTHP_STAT_FILE_ALLOC,
> +       MTHP_STAT_FILE_FALLBACK,
> +       MTHP_STAT_FILE_FALLBACK_CHARGE,
>         MTHP_STAT_SPLIT,
>         MTHP_STAT_SPLIT_FAILED,
>         MTHP_STAT_SPLIT_DEFERRED,
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 6e2f72d03176..95a147b5d117 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -562,14 +562,26 @@ static inline void *detach_page_private(struct page=
 *page)
>  }
>
>  #ifdef CONFIG_NUMA
> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
> +struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order=
);
>  #else
> -static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsign=
ed int order)
> +static inline struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsi=
gned int order)
>  {
>         return folio_alloc_noprof(gfp, order);
>  }
>  #endif
>
> +static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsign=
ed int order)
> +{
> +       struct folio *folio;
> +
> +       folio =3D __filemap_alloc_folio_noprof(gfp, order);
> +
> +       if (!folio)
> +               count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
> +
> +       return folio;
> +}

Do we need to add and export __filemap_alloc_folio_noprof()? In any case,
we won't call count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK) and
will only allocate the folio instead?

> +
>  #define filemap_alloc_folio(...)                               \
>         alloc_hooks(filemap_alloc_folio_noprof(__VA_ARGS__))
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 53d5d0410b51..131d514fca29 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -963,6 +963,8 @@ int filemap_add_folio(struct address_space *mapping, =
struct folio *folio,
>         int ret;
>
>         ret =3D mem_cgroup_charge(folio, NULL, gfp);
> +       count_mthp_stat(folio_order(folio),
> +               ret ? MTHP_STAT_FILE_FALLBACK_CHARGE : MTHP_STAT_FILE_ALL=
OC);
>         if (ret)
>                 return ret;

Would the following be better?

        ret =3D mem_cgroup_charge(folio, NULL, gfp);
         if (ret) {
                 count_mthp_stat(folio_order(folio),
MTHP_STAT_FILE_FALLBACK_CHARGE);
                 return ret;
         }
       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);

Anyway, it's up to you. The code just feels a bit off to me :-)

>
> @@ -990,7 +992,7 @@ int filemap_add_folio(struct address_space *mapping, =
struct folio *folio,
>  EXPORT_SYMBOL_GPL(filemap_add_folio);
>
>  #ifdef CONFIG_NUMA
> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
> +struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order=
)
>  {
>         int n;
>         struct folio *folio;
> @@ -1007,7 +1009,7 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp,=
 unsigned int order)
>         }
>         return folio_alloc_noprof(gfp, order);
>  }
> -EXPORT_SYMBOL(filemap_alloc_folio_noprof);
> +EXPORT_SYMBOL(__filemap_alloc_folio_noprof);
>  #endif
>
>  /*
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 578ac212c172..26d558e3e80f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -608,7 +608,14 @@ static struct attribute_group anon_stats_attr_grp =
=3D {
>         .attrs =3D anon_stats_attrs,
>  };
>
> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHAR=
GE);
> +
>  static struct attribute *file_stats_attrs[] =3D {
> +       &file_alloc_attr.attr,
> +       &file_fallback_attr.attr,
> +       &file_fallback_charge_attr.attr,
>  #ifdef CONFIG_SHMEM
>         &shmem_alloc_attr.attr,
>         &shmem_fallback_attr.attr,
> --
> 2.43.0
>

Thanks
Barry


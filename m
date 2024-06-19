Return-Path: <linux-kernel+bounces-220843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E2A90E811
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97481B22DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6748286D;
	Wed, 19 Jun 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHYoVbVK"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C17824B2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792044; cv=none; b=VNzzT0KGvbQwtR3Qg6mKblgXQLMIqDHwmuPnjxoI9IccmCObK+vGXXONKsJNagyvjpbLU/fKNyngNvvJLbkLZOLOjTMY5pNwZcVgeLd+95+rOWb5IEJ0OLYUiHN3RNCOTiPp1hRpHrtYiJAuvHIGCAMDl/nNXbdNff3tN3a818g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792044; c=relaxed/simple;
	bh=4EGNH+EZmxPWT9lmaQ8vJOntiLtZSIoxKvEA95bhO3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLT/NSg/FPqmV3TbKwjvhZfjj9bimJaa82ilHaS/Yj1wn8H6y5LR9iySv0ownADoACMYll3UhiEm64/8PxnqYCS8pCQVinNyKeSR16KoihYTOgN5+VwV5tJLcez8AzHniQo9KB/29nokSl0wprLBQWREUw93IUDAleldR9H37z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHYoVbVK; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-80b8a8b06b9so1646090241.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718792041; x=1719396841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuZeMhgyDbj4Vj/SJ3SA8UCb/5gKLQ+XAJUVVoR6RnY=;
        b=gHYoVbVKuEOTUXFcTPZ50Ne1QpuzFD8dlvI7ZBXcmy5PqtGI5pBwUIWd1dka76OqPz
         vwba///0akIVX69mH3x4kqdXSNEtht7oPwJY4jDlQ8mYxcBUbK7TiPEV1WxnSJZXK7bu
         OxyPyAc+Q8cIelh0oi6sYBKJ1Cm2KbCnLeKxNmMMQKauveaCrWTP6oRmRrtLAUbGX1u7
         LaEGKtP2ZJeSg25aX8XMQMCvGhh11ZppfhJGZ8AU/ILJx1JpxDj7sIOe2Pu6FlVbaZta
         +eeFVQvpO7m454nMDbCG0te8iKiDgG6o0PUF7vU2iMIoEOdvOUbO0oVUPBkhApnJe9dN
         EpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718792041; x=1719396841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuZeMhgyDbj4Vj/SJ3SA8UCb/5gKLQ+XAJUVVoR6RnY=;
        b=ePtynWQaH6OXJV0u8ltfVDSxroR0Dyjdg0gw+cl+0avmoTJABgOaeXuqZBA/YP2aWd
         CV8k1Qu/32A9876aD/06LabFlhHmx+GDI5cezAC0ultnM8ZqBYAqCtoRPndnXrN2Xu+a
         eqXXuU+dOldUpjQw5XzLA+rbCxz2jxQtfgnfudmkFK+TucEVDRma+wRh7nwB6RAkzQYP
         NdrwtNrbFrwHx+Axjp+EvYMJlKXxr+c16hbU5tX1zUGXiiv3sFRDDO3gQw2NShGldSbL
         ZUn2mqbTo0LQSD/1CgbrTzqSXIN4zXhxL5WP/p1PNrZyQLd8Mrzuv1z6uRdzaefCUfk/
         c7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCV8+f1fP/1jX6lVN9YmPqlGKIuLxp1GCBvGKcq9CP+D2x5tF6CbqgAegaNT4/vVoh5ZnifSX8fNI/flnp6XKl/NbiXhXUhZdUZH9vRT
X-Gm-Message-State: AOJu0YyeWppR5C3yoaN7J/zkhVnXUTzSmab7Zkk6cxW5etO5dovcR6Vf
	FqTGXNtB5qCqGqqpTUJTBIm7bTp7sq5mvA59ElSqzjrLSHr1fJyXSO6+DMD9MXDW8K3a7Qla7w6
	aBn9WxkISH1B4Qm+RJhSuDBit7xnyEZgz
X-Google-Smtp-Source: AGHT+IGqhOfEodhIqdPObmAOCxJYsofDFl0wxJwXrVRUXoPdREis6EiObX9MZB2Mh9s5T33p+07wlRdyaYHfNUcw6qQ=
X-Received: by 2002:a05:6102:2745:b0:48c:43f2:4f29 with SMTP id
 ada2fe7eead31-48f13140ed9mr2244373137.34.1718792041497; Wed, 19 Jun 2024
 03:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718790499-28151-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1718790499-28151-1-git-send-email-yangge1116@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 19 Jun 2024 22:13:50 +1200
Message-ID: <CAGsJ_4zAg_Ui3uNUz6rwRPeERo6PskthGUB2V=4Yr+c+AU8iqA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: add one PCP list for THP
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn, Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Mel, the original author of commit 5d0a661d808f
('mm/page_alloc: use only one PCP list..."


On Wed, Jun 19, 2024 at 9:48=E2=80=AFPM <yangge1116@126.com> wrote:
>
> From: yangge <yangge1116@126.com>
>
> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> THP-sized allocations") no longer differentiates the migration type
> of pages in THP-sized PCP list, it's possible that non-movable
> allocation requests may get a CMA page from the list, in some cases,
> it's not acceptable.
>
> If a large number of CMA memory are configured in system (for
> example, the CMA memory accounts for 50% of the system memory),
> starting a virtual machine with device passthrough will get stuck.
> During starting the virtual machine, it will call
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory. Normally
> if a page is present and in CMA area, pin_user_pages_remote() will
> migrate the page from CMA area to non-CMA area because of
> FOLL_LONGTERM flag. But if non-movable allocation requests return
> CMA memory, migrate_longterm_unpinnable_pages() will migrate a CMA
> page to another CMA page, which will fail to pass the check in
> check_and_migrate_movable_pages() and cause migration endless.
> Call trace:
> pin_user_pages_remote
> --__gup_longterm_locked // endless loops in this function
> ----_get_user_pages_locked
> ----check_and_migrate_movable_pages
> ------migrate_longterm_unpinnable_pages
> --------alloc_migration_target
>

Please also describe its potential negative impact to cma_alloc().

> To fix the problem above, we add one PCP list for THP, which will
> not introduce a new cacheline. THP will have 2 PCP lists, one PCP

not introduce a new cacheline for struct per_cpu_pages.

> list is used by MOVABLE allocation, and the other PCP list is used
> by UNMOVABLE allocation. MOVABLE allocation contains GPF_MOVABLE,
> and UNMOVABLE allocation contains GFP_UNMOVABLE and GFP_RECLAIMABLE.
>
> Link: https://lore.kernel.org/all/1717492460-19457-1-git-send-email-yangg=
e1116@126.com/

no this tag.

> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized =
allocations")

Cc: <stable@vger.kernel.org> ?

> Signed-off-by: yangge <yangge1116@126.com>
> ---
>  include/linux/mmzone.h | 9 ++++-----
>  mm/page_alloc.c        | 9 +++++++--
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b7546dd..cb7f265 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -656,13 +656,12 @@ enum zone_watermarks {
>  };
>
>  /*
> - * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional =
list
> - * for THP which will usually be GFP_MOVABLE. Even if it is another type=
,
> - * it should not contribute to serious fragmentation causing THP allocat=
ion
> - * failures.
> + * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. Two additional =
lists
> + * are added for THP. One PCP list is used by GPF_MOVABLE, and the other=
 PCP list
> + * is used by GFP_UNMOVABLE and GFP_RECLAIMABLE.
>   */
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define NR_PCP_THP 1
> +#define NR_PCP_THP 2
>  #else
>  #define NR_PCP_THP 0
>  #endif
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8f416a0..0ecbde3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -504,10 +504,15 @@ static void bad_page(struct page *page, const char =
*reason)
>
>  static inline unsigned int order_to_pindex(int migratetype, int order)
>  {
> +       bool __maybe_unused movable;
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (order > PAGE_ALLOC_COSTLY_ORDER) {
>                 VM_BUG_ON(order !=3D HPAGE_PMD_ORDER);
> -               return NR_LOWORDER_PCP_LISTS;
> +
> +               movable =3D migratetype =3D=3D MIGRATE_MOVABLE;
> +
> +               return NR_LOWORDER_PCP_LISTS + movable;
>         }
>  #else
>         VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> @@ -521,7 +526,7 @@ static inline int pindex_to_order(unsigned int pindex=
)
>         int order =3D pindex / MIGRATE_PCPTYPES;
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -       if (pindex =3D=3D NR_LOWORDER_PCP_LISTS)
> +       if (order > PAGE_ALLOC_COSTLY_ORDER)

pindex >=3D NR_LOWORDER_PCP_LISTS

>                 order =3D HPAGE_PMD_ORDER;
>  #else
>         VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> --
> 2.7.4
>

Thanks
Barry


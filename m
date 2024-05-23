Return-Path: <linux-kernel+bounces-186953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B708CCB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81106B2207D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EAF12B14A;
	Thu, 23 May 2024 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FonYZArD"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B126AF6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434525; cv=none; b=AWFvFlhRXp+9dusmsNYUJ7axHtzYmvrG0dXwy4XUtHobzPZlQv2o7Dg+B8LtjQ8h76jOKBGeBKpjDiFJprBsksE/t5r923yv6elG+kNB4zsV9WSVwwEjUXo1sUNjPjs7wOacoQeLvLryqgIH0AWZv0YtGDjkmRWUPBxX+ObMgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434525; c=relaxed/simple;
	bh=3boAGRMvf3jbGONMwxHiwTZ3kyfv5q7izkn9Z2CircI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+ElEcp81QrTghPTmZWlQTrw0UG6fS+jl9P12wtIz2T2BkVeEjzycpItC2jzXy3LvglmxfXTqN5e5DIBeX2Lzi3MZxq/1pBU7FBIaf08jwrvqICIKh1KbEMKH6QdjraE7sm/zYNYycJZWVNHEt/iQxF++uKXEwWwKyfPN/2vWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FonYZArD; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47efcb120feso2322611137.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716434522; x=1717039322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cBMgH/meb7DXHpqDFrMQs3sMI8ZwAwTzDkQlsuKAC8=;
        b=FonYZArDDQAvEHNe11QoXRADp2v1ImGoPBhp4oaqBG0j0+qOJcXAEcDZ8wks2k2+Pg
         g+zLMwuQJxrD9dGajhmF7cCwgL/zfGk1H6LTkXBItlBKsKXbQRzof2yNT3Zg3wwpsgk6
         yX9sNMRYosFvAPzOVww7D6dXsc9SCP+3zWYeyGpczaLHxBN2L7WEJUYusXSDVRsDjTSZ
         Tvpvz15BrLI4xLjmQyEe9KYYwEcl1XyzjDPA87o1DcZ8Uf93Dk8nb4PEt6daaJW4fM4J
         Z0KYgFjrgLb2NSITgMuD6q+Z+H9hdhBQeBOqIim0anJTmS90UaqyFVEMtD7ah5weVMsU
         3F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716434522; x=1717039322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cBMgH/meb7DXHpqDFrMQs3sMI8ZwAwTzDkQlsuKAC8=;
        b=PVAjTJHwsbblhtHTwCrSHAv3psTOETOeQqGbu1Xa0F/rWREkyxIVMMS5D6keoSIluL
         ct1cqr7g9iWJniJ0LxIalVyqKw8JoT7hIwHB8zJusDZ/6bIekCDRlCUX2rAdzLphVaU9
         bZRqn0wLX1DR0FytjRH7yuSBk1FbEtfXDzDsQGdwzmJ8qVe1LxOeALSpNrhefyDPQHx9
         iO+E456uuA47auARsOIhp3VU0EhUjBdfyF2qZ2VHfwbannmE8I/GjIOkkXQczkMZjK+E
         t8FMOZQ6s5uDFez3bJzLgm1O9FUIejWkrD793nHa33cAcC5UrcA/l0ubOwHupw3DeyZ7
         D1tg==
X-Forwarded-Encrypted: i=1; AJvYcCXLUKK5v1V+fGe4UQl8NLKDk2GMW/51RO9kFxxSrAyhLv+ZvGHJEYiJGCWzcG9oKDNZkJFS35aSQkFkUeNqwxen7nEIYfKpp4/i09I7
X-Gm-Message-State: AOJu0YwLH8J2iA5PC1Oc0q1qOMQpUINkb9yW2t42bcbaq7NEOVx1eRIR
	0RXhbffPs3Fais3qz06eC3kJO0dQeFmIurGf5OaxO1c6qPAwUuAyQTsdJLNNBZOMCGBat5FAyzY
	FrjOmho/dsiU6v9q2Q+4NDyUUbbE=
X-Google-Smtp-Source: AGHT+IFcH/gCwsAZh05Z9mcAv7Lon2D94TeRNOA6KqgmMMrmWQHTwznzdaCwb5CQJw6jDVriF5EfR7RacvHkkKRox38=
X-Received: by 2002:a05:6102:6cb:b0:47f:2dde:2304 with SMTP id
 ada2fe7eead31-489009364f8mr3889758137.5.1716434522508; Wed, 22 May 2024
 20:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a8989c13299920d7589007a30065c3e2c19f0e0.1716431702.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <7a8989c13299920d7589007a30065c3e2c19f0e0.1716431702.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 23 May 2024 15:21:51 +1200
Message-ID: <CAGsJ_4x0CnEdmo=Nk8Gp8a0Rjeiny3tX8PSk9X2SLLx6946YJg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: drop the 'anon_' prefix for swap-out mTHP counters
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com, 
	ying.huang@intel.com, ryan.roberts@arm.com, ziy@nvidia.com, 
	ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 2:37=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> The mTHP swap related counters: 'anon_swpout' and 'anon_swpout_fallback' =
are
> confusing with an 'anon_' prefix, since the shmem can swap out non-anonym=
ous
> pages. So drop the 'anon_' prefix to keep consistent with the old swap co=
unter
> names.
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Barry Song <baohua@kernel.org>

> ---
> Hi Andrew,
>
> Hope this patch can be merged into kernel 6.10-rc to maintain ABI compati=
bility.
> Thanks.
>
> Changes from v1:
>  - Update the documentation per Barry Song.
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 4 ++--
>  include/linux/huge_mm.h                    | 4 ++--
>  mm/huge_memory.c                           | 8 ++++----
>  mm/page_io.c                               | 2 +-
>  mm/vmscan.c                                | 2 +-
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 076443cc10a6..d414d3f5592a 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -467,11 +467,11 @@ anon_fault_fallback_charge
>         instead falls back to using huge pages with lower orders or
>         small pages even though the allocation was successful.
>
> -anon_swpout
> +swpout
>         is incremented every time a huge page is swapped out in one
>         piece without splitting.
>
> -anon_swpout_fallback
> +swpout_fallback
>         is incremented if a huge page has to be split before swapout.
>         Usually because failed to allocate some continuous swap space
>         for the huge page.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c8d3ec116e29..8c72d3786583 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -269,8 +269,8 @@ enum mthp_stat_item {
>         MTHP_STAT_ANON_FAULT_ALLOC,
>         MTHP_STAT_ANON_FAULT_FALLBACK,
>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> -       MTHP_STAT_ANON_SWPOUT,
> -       MTHP_STAT_ANON_SWPOUT_FALLBACK,
> +       MTHP_STAT_SWPOUT,
> +       MTHP_STAT_SWPOUT_FALLBACK,
>         __MTHP_STAT_COUNT
>  };
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 317de2afd371..89932fd0f62e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -558,15 +558,15 @@ static struct kobj_attribute _name##_attr =3D __ATT=
R_RO(_name)
>  DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK=
);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_F=
ALLBACK_CHARGE);
> -DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> -DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBA=
CK);
> +DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> +DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>
>  static struct attribute *stats_attrs[] =3D {
>         &anon_fault_alloc_attr.attr,
>         &anon_fault_fallback_attr.attr,
>         &anon_fault_fallback_charge_attr.attr,
> -       &anon_swpout_attr.attr,
> -       &anon_swpout_fallback_attr.attr,
> +       &swpout_attr.attr,
> +       &swpout_fallback_attr.attr,
>         NULL,
>  };
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 46c603dddf04..0a150c240bf4 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -217,7 +217,7 @@ static inline void count_swpout_vm_event(struct folio=
 *folio)
>                 count_memcg_folio_events(folio, THP_SWPOUT, 1);
>                 count_vm_event(THP_SWPOUT);
>         }
> -       count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
> +       count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
>  #endif
>         count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6981a71c8ef0..18b796605aa5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1244,7 +1244,7 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>                                                         THP_SWPOUT_FALLBA=
CK, 1);
>                                                 count_vm_event(THP_SWPOUT=
_FALLBACK);
>                                         }
> -                                       count_mthp_stat(order, MTHP_STAT_=
ANON_SWPOUT_FALLBACK);
> +                                       count_mthp_stat(order, MTHP_STAT_=
SWPOUT_FALLBACK);
>  #endif
>                                         if (!add_to_swap(folio))
>                                                 goto activate_locked_spli=
t;
> --
> 2.39.3
>


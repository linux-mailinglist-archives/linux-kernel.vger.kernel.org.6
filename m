Return-Path: <linux-kernel+bounces-434940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E209C9E6D36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C49188246F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E691FBC95;
	Fri,  6 Dec 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3fX21VE"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5FC46426;
	Fri,  6 Dec 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484100; cv=none; b=DQMuqNJKDIKf2juTQ0JK2fWZlUMLb0bH5z+zZhe3+pZbVzPQeXgKYXePADaJWxWVTW0IvKt+SevQ5V0pFLXfQ6VVc8d4p3/a+fwfe+UIl19oAW7OJnxFYt6TUWg3j04PJK9ePWMvGoLPRnpBWJLBLL8iQKxiFGYU/nE+K18JPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484100; c=relaxed/simple;
	bh=9govWh8sxEZ4qZQeHT2kA7yvMBsZti2fI5uD6rgjm5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bu6LHbmOXp0LtYKS3Yy5wB0VlTDEifd1sF6/tfc75c2thTIh09cwtA6l1RgeiILcYAgYa8j7R6hWldZ//40XfWHDy+lUMOe33MerHRSrJLspw7Z0CoCyiqa+xe6ZDRXmP7eSSD8VTtumBO+FRK9DwEMsadovnyrZqq1gLrb/ECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3fX21VE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so2327035a12.2;
        Fri, 06 Dec 2024 03:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733484096; x=1734088896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyzXuvxRpwFrV1nRnI/J4fk27w/kJSEXBODmElH5NDM=;
        b=L3fX21VENstNp3cxFmz7DEvDGexnYp677E8hVitzn/Grj7uHxPiY5PbVaf73Bhjnap
         4faCoa/U2kNmanbFUOrwrfnqdRuYIMqddbvalHLjOuttjcalQAPS+30Kpe5azowTihvd
         qp0W0o+yCMb0PzNtKZvfsDqHohHilLVKDQVsUut+v92hrvpzpNaHoTkIKV5jyKMm/ygu
         ook0Nn2UZaKeR9eKBo879rTajPCt1NXRSzdT8ZSnolQGA9pyCXwSdJ05MDX88wj54opT
         1lmv60EKV1vcSbESW7lNySow8vaHwDDEEjB1k9YQHXctSjEFXm/FVj6EmMIKgg9QU3p2
         0QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733484096; x=1734088896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyzXuvxRpwFrV1nRnI/J4fk27w/kJSEXBODmElH5NDM=;
        b=hFciD0ZGPs488g5BDf/VxtCtMfZTEJOpVqvWzqKPs/6sQ9u8Pp/m7hXoyRYErXdJHp
         p5zHHEhiaVoSCFCkaxyVOp3Q3pR8SxjIXcY1s4q3LGmG6kpX56bj39H+lCR2CVpy+rYX
         qiuV5u4G/KJ26u4Sy4iA+WVX4OIeJcMx4TJx+09UIDvcxHezrSu4O6AxLDiNf2/W4uhf
         JeJvFCUYOLl+EV2qDiTE+Jl6b46FSY9lXobXVzl+CYonib5M2r4p/JpPIjv8QyRymkgZ
         u5vNldXq/KFZPSPH2Lg+XqWlKfwXQefSfvxD19IyJCbUdvqomyCHSHFw/FoHvof6z13g
         GnUw==
X-Forwarded-Encrypted: i=1; AJvYcCUPU0n2Sqqr6LBf4amtj5FRVFbmv6+gwuzg2EfyZFnpClpVKHgq77v2Hl3gCO5iAiTcaTb3vnPZ0hnL/s7S@vger.kernel.org, AJvYcCWAdISe7zilSMhcdxdVckPnc87JvXV/dhCdf4cgzx2/dkVjviesJFQLpemaJdLaW/MUxrCCM3LPG24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZJ3v1YAtPByOee1g5uOvWkp69NxUF4TatYYtNc6hWV1jLbIt
	dTmbZdTWaP73cy1I9OUeNx//tGA0CRw2WprRLvYi/YC3Us3I/8ant4eIfqY78z3natCxoFztrCg
	7I/y9bund0xwjGCUWVgAeLMRMRpo=
X-Gm-Gg: ASbGncvLlD9+8+/aSg9YZpWaJO2WXLjfaS3HFsmeCNgV0O/LW84ScU6GjI9NrqeLtd9
	+Am+NyqLyPuneFy2bUoAoDvMBxaOnSxre0A==
X-Google-Smtp-Source: AGHT+IFL429JqXIboRvzssamCzQ6I+a9lCKCvQULS8lNCRXBuWoGme3cYGF5xMWYLcAq6Fjkq7suXMdMvs/rWVbY51c=
X-Received: by 2002:a05:6402:4497:b0:5d0:e877:764e with SMTP id
 4fb4d7f45d1cf-5d3be71f257mr2571986a12.24.1733484096457; Fri, 06 Dec 2024
 03:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202124730.2407037-1-haowenchao22@gmail.com>
In-Reply-To: <20241202124730.2407037-1-haowenchao22@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 6 Dec 2024 19:21:00 +0800
Message-ID: <CAK1f24=qks5M=Wca9wkjb06HX9BteEGSFynZozCS378S4jMf9A@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add per-order mTHP swap-in fallback/fallback_charge
 counters
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Usama Arif <usamaarif642@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 8:47=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com>=
 wrote:
>
> Currently, large folio swap-in is supported, but we lack a method to
> analyze their success ratio. Similar to anon_fault_fallback, we introduce
> per-order mTHP swpin_fallback and swpin_fallback_charge counters for
> calculating their success ratio. The new counters are located at:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
>         swpin_fallback
>         swpin_fallback_charge
>
> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>

LGTM. Feel free to add:

Reviewed-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance

> ---
> V3:
>  Update description about swpin_fallback and swpin_fallback_charge
>
> V2:
>  Introduce swapin_fallback_charge, which increments if it fails to
>  charge a huge page to memory despite successful allocation.
>
>  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
>  include/linux/huge_mm.h                    |  2 ++
>  mm/huge_memory.c                           |  6 ++++++
>  mm/memory.c                                |  2 ++
>  4 files changed, 20 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 333958ef0d5f..156a03af0a88 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -591,6 +591,16 @@ swpin
>         is incremented every time a huge page is swapped in from a non-zs=
wap
>         swap device in one piece.
>
> +swpin_fallback
> +       is incremented if swapin fails to allocate or charge a huge page
> +       and instead falls back to using huge pages with lower orders or
> +       small pages.
> +
> +swpin_fallback_charge
> +       is incremented if swapin fails to charge a huge page and instead
> +       falls back to using  huge pages with lower orders or small pages
> +       even though the allocation was successful.
> +
>  swpout
>         is incremented every time a huge page is swapped out to a non-zsw=
ap
>         swap device in one piece without splitting.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index b94c2e8ee918..93e509b6c00e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -121,6 +121,8 @@ enum mthp_stat_item {
>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>         MTHP_STAT_ZSWPOUT,
>         MTHP_STAT_SWPIN,
> +       MTHP_STAT_SWPIN_FALLBACK,
> +       MTHP_STAT_SWPIN_FALLBACK_CHARGE,
>         MTHP_STAT_SWPOUT,
>         MTHP_STAT_SWPOUT_FALLBACK,
>         MTHP_STAT_SHMEM_ALLOC,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ab46ef718b44..d062b257376d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_=
ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_F=
ALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FALLBACK_CH=
ARGE);
>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>  #ifdef CONFIG_SHMEM
> @@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] =3D {
>  #ifndef CONFIG_SHMEM
>         &zswpout_attr.attr,
>         &swpin_attr.attr,
> +       &swpin_fallback_attr.attr,
> +       &swpin_fallback_charge_attr.attr,
>         &swpout_attr.attr,
>         &swpout_fallback_attr.attr,
>  #endif
> @@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] =3D {
>  #ifdef CONFIG_SHMEM
>         &zswpout_attr.attr,
>         &swpin_attr.attr,
> +       &swpin_fallback_attr.attr,
> +       &swpin_fallback_charge_attr.attr,
>         &swpout_attr.attr,
>         &swpout_fallback_attr.attr,
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index d5a1b0a6bf1f..a44547600c02 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(struct vm_fa=
ult *vmf)
>                         if (!mem_cgroup_swapin_charge_folio(folio, vma->v=
m_mm,
>                                                             gfp, entry))
>                                 return folio;
> +                       count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_C=
HARGE);
>                         folio_put(folio);
>                 }
> +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
>                 order =3D next_order(&orders, order);
>         }
>
> --
> 2.45.0
>


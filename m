Return-Path: <linux-kernel+bounces-428477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA79B9E0EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B87B2269D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A201DF731;
	Mon,  2 Dec 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI3eW8N9"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786B1D5AC0;
	Mon,  2 Dec 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179511; cv=none; b=YQ1omiQNqwd9jtaDGBg48jtqPb3Urk0LmWwQgVQYDYUFvtv/RJ3NlNcBF2h65fei6pXuHzU+0BX+RjKBV3Fwotji9OmQPFDudC0t7TNUjuMz19ZD4eBuE+IRqL+jUyKzkjp3w8XlfOaEz/uiEHSluMwOTNHxGHoxHOLcR0z/4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179511; c=relaxed/simple;
	bh=qr9FVVRLF7cbMJ+TwK8u3adkAvme45zAHyCmiBPx8aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL3XhPC4SHIHrbSooVl+U3G/8cu0rlb/EqIg7HUglD0dsXlLpimUnO1Pdr+YH0sWLPhjsMBktIvRxoix5Lw10hLN3715/1pWO8E4C+O6pPt9iBcDJw8AheV3K2gBdQ1zQsnIGFG3N9tkLRUeszXrYmYkMH7oO/SeTqXdHpWP4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI3eW8N9; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4af638e3e66so866706137.0;
        Mon, 02 Dec 2024 14:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733179509; x=1733784309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUEcxtWUkTObrNKrksQ5hyJNqC1rP3KkyBtBAQWtcU8=;
        b=hI3eW8N9meu01xrCFafdWKDjrS3hq4JshVTP6LFmHscRo1wPHT/8Od+4sR6XcBGLTm
         E3IO4aql4lZwb6HZ3zaE0FMD2l8OTl0CClXENmQJKF56NGkUtmF7sV9c09dbmNhgLSqL
         XOqrtZY6WBv2HKSQfTBf/bUvTFhMtZ5q9LxnLfXMfZ9cZl6V2S5cUsGhhtco/pZuRhtg
         tEBEESGZfLfx1+DzMnGGduNz9Z8C9QT8fpzhSsWKjkPgCJ66JmK6/4n9OV0+0kac4ZhE
         JRaU95+yUN1Y1/6fUxw4vfWI0RXlKKBeOnzkqBW9HOr5HBlftKlH8rB8IH77Mc2UMQVb
         wkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733179509; x=1733784309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUEcxtWUkTObrNKrksQ5hyJNqC1rP3KkyBtBAQWtcU8=;
        b=t+UsokTx3sHEeX5Tw0l0vEs+BLq5hOyOeoXEPYzkiFtqUTKD6WY4Js6755JDgvtAIu
         K2eaBSY2Iik8ef6skifZK0tGzGqQ/UjoGNtz4qBMx80D8vlLypvncrLi07Q19VAU15yc
         6HqwznjCBS+I3U5lHpctoNANSaIOH9K8f8N8ppTQ7+lyJ8a20QZkVA2b152PZUN0weew
         TE7oDC5WNH5Rme550S2gg9An5BqXNfhf7t/Su520cDUfZ+8K4TSVYAT3O66xjuStEPY2
         e3Kfmkjwvx5IXgXvw0Pzp/X4K5nwzAwITJ1RGdLMj90R0W7IrwMfbXHsX8dP1RbZIWcJ
         Zx/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5MHOqtaINTamHs1O3AidWKHZVh7fOr8pa0ds860ut2cHajp4BD2jLIj5tquQ9mmsyp+1o/eeAe+0=@vger.kernel.org, AJvYcCWsbgji1kODijbnYRvIfZmvaJpuOVLEthf6alUsYGCPDRfJw9magzX227Q3OiYxxrhQk97qqpU/EQrMIK7h@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUoAKWq05A/kMLF8COKhrDo8IXO71hdFBamYwlA+nuq5U2xv5
	TNNuVu20FgpaxUzMyW1/cnoPclkcJE1oTX8WjqAAj3dP29M1JcT9jNv2YEuZhCxhTUTP74vj3Gg
	hoURLpAyV2J5El0/q0UgMb0dEz34=
X-Gm-Gg: ASbGncs3Vpx9AOLMlCVZzKr7BwhLOVn8vA9rTmrfsshKCW00zcHPJPDhdPiBnHkHEFT
	wR5NpUFXis5vaBT5rDNEofZC8eZP/PsF1yFEtvq6vDPle+AcXfOwzAwb4EeTShcvgTA==
X-Google-Smtp-Source: AGHT+IFmULI0ThdR9ckUys9YQgFREDAKM/TwDr9B8+dEWXe4rChjO7jy0fv9Y/h2ZsRP2HB6OBgpWdz1iZZhoPHfpp4=
X-Received: by 2002:a05:6102:292a:b0:4af:4aff:7fd0 with SMTP id
 ada2fe7eead31-4af97198522mr662883137.10.1733179508702; Mon, 02 Dec 2024
 14:45:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202124730.2407037-1-haowenchao22@gmail.com>
In-Reply-To: <20241202124730.2407037-1-haowenchao22@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 3 Dec 2024 11:44:57 +1300
Message-ID: <CAGsJ_4yOYY_Quu3Up2-h+L2775=nfENvkd6_pKmW7pYbbFq-_g@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add per-order mTHP swap-in fallback/fallback_charge
 counters
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Usama Arif <usamaarif642@gmail.com>, 
	Lance Yang <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:47=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.com>=
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

LGTM, thanks!

Reviewed-by: Barry Song <baohua@kernel.org>

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


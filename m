Return-Path: <linux-kernel+bounces-418920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AEC9D672F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 03:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4799CB21B5B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059AC2D057;
	Sat, 23 Nov 2024 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIz4p1Pc"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A4817;
	Sat, 23 Nov 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732329409; cv=none; b=NdyexMot8AhWF07xD4ju76fUVw/fbVM976hlvlwx17TfzT0488p/g/1Z3WSs7ZRj3lmP/RE9Ev0ixZLvLIOCyhvf8xe5Ttz+5hmWRm0zP74kKS5CpUv0NvfgJhhoVrkxdv0DV7w0W0N3Z1kvgM+Vm+PNhhkrH2t83amqhflgj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732329409; c=relaxed/simple;
	bh=7z2Q203ERLjoNfDcHGfqDcgsWzc//gbfXlLWU2WPLRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzNCavLeHHLCpvkYfnt9OQL1bKZTXs/dRTbML9TDjdHVSIrRzXQFJJVGPG3V2iSEl3KxelTV/eo7zGqPjMlhqq5gUDezBzUehDoageOvA642ZykLDShsyHZ2Cg+3Neyq+F+iCDrm0gEargpQ6QABKMWxMS9hq0JwQfjr/GYRa40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIz4p1Pc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so3016046a12.3;
        Fri, 22 Nov 2024 18:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732329406; x=1732934206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwAIYJiCi7vkj35O92N4pBX1EN9ewd8Gkt1H/zhirm8=;
        b=XIz4p1PcvS7R5zQB/35Wr+K1BSbzPRbR31IObT2OMOssvB+v4nLOkkEdFGS1cnei5T
         7Rf9sN0oArA98ezh//agvKQi0huBuUJ+EHu6Y2bNwoVbpL3LNbQBvCVv0SRvHi/kQtf7
         uMJmerTn+XAwIzV0WwV2HXZKqG+7rW7betNET48xx7xLVfoOXD58Ae5xxHJPm2YuKg6A
         hM59hFgq7MkwqWaWJn0vqk7WfBNLGY6+ClgKCI54XWCK/CJLbrqI8naIZL7Zy5qxlZ3q
         0FJ54Air014YShlwOwQuLJ4KhhTdO469Soth0qtzMdumaBCEh2FlaLe6UDRUcRbaUGsN
         l80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732329406; x=1732934206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwAIYJiCi7vkj35O92N4pBX1EN9ewd8Gkt1H/zhirm8=;
        b=OaimXI45xRV1vnZMgpb6PKNO0F60iKYdf8Pm0nz88Xg8St3IwkKzi+sxbGutdnzCot
         WwYqhMKsFDqUGmsHyLB4A/vSRj2jvO3a8w5k/rQR8BlEtyW0IqRutJMixOTO7hFYsci2
         Yg9xKC8E39pJKIYZRohUit8jgTLneRaFjtaPq6/O7JYilUsR1KnUmMAOULeOTO2Gc/ER
         sqeI+ndP40lREQMhWJGJvw3NenGlLmoJ2g9VaBDOZyG6jO99QD5kUszj1tzrl3H25P3U
         ybfJtSIukVaxSbAi6GtKthIArbEXF4DSs8ok7XjdjjTTlc5tOMXn+oZM1Naypc+wpfnd
         Kx2g==
X-Forwarded-Encrypted: i=1; AJvYcCVhTk1PW8DwGiMYjogdMRbiwxp74LWRmP8XLnRY3KHPl3RiC2Eex1areeoG49IIuDcc/dMszwRFgCs=@vger.kernel.org, AJvYcCW0wkk3buqf+IZ8IsqQ63Lsb8DBshfzcpdAcG+C5DUI2JkOiArQmzmbYhZ19NOXaFOTMzsiOCC7hjHFjeiY@vger.kernel.org
X-Gm-Message-State: AOJu0YyUnSVVhbZzas4hbZsnKjk+lEpdRk/gxxIhXBr5U9gyvxzOk8eu
	IJixmM4vM061yp1rYOeAjr8LQWESOkwPPaiMHPhbIJCTDFaIQGrQLWBZ4Ej5rY8JyUECgnaCq/X
	7LCLHOC7YfiN9qGrSHroiQDX0XbQ=
X-Gm-Gg: ASbGnctAK9Lym4mRzblXyJTYByA7GW58Bf1aSy1UAWMZBp3Nf0bmJWKr88xUhVNOawD
	IkfEHYTqGFHN+H6YZg58qQWxaVlPXBYM=
X-Google-Smtp-Source: AGHT+IGbwtMLT9zLGAmt+b/YRisjA1ks3t80ako207ZcbbrXuRR2QLaW8MTHtUvTwQkNtV8pOJqEdcuIc1XqbTKt+kc=
X-Received: by 2002:a05:6402:270e:b0:5c2:6d16:ad5e with SMTP id
 4fb4d7f45d1cf-5d020629874mr3416136a12.19.1732329405487; Fri, 22 Nov 2024
 18:36:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122161443.34667-1-haowenchao22@gmail.com>
In-Reply-To: <20241122161443.34667-1-haowenchao22@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 23 Nov 2024 10:36:09 +0800
Message-ID: <CAK1f24k6n1ngSicrSCv5jX+xa75t-7a3zZB4A95fUvDhteshEQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add per-order mTHP swap-in fallback/fallback_charge
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

Hi Wenchao,

On Sat, Nov 23, 2024 at 12:14=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.co=
m> wrote:
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
> ---
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
> index 5034915f4e8e..9c07612281b5 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -561,6 +561,16 @@ swpin
>         is incremented every time a huge page is swapped in from a non-zs=
wap
>         swap device in one piece.
>

Would the following be better?

+swpin_fallback
+       is incremented if a huge page swapin fails to allocate or charge
+       it and instead falls back to using small pages.

+swpin_fallback_charge
+       is incremented if a huge page swapin fails to charge it and instead
+       falls back to using small pages even though the allocation was
+       successful.

Thanks,
Lance

> +swpin_fallback
> +       is incremented if a huge page swapin fails to allocate or charge
> +       a huge page and instead falls back to using huge pages with
> +       lower orders or small pages.
> +
> +swpin_fallback_charge
> +       is incremented if a page swapin fails to charge a huge page and
> +       instead falls back to using huge pages with lower orders or
> +       small pages even though the allocation was successful.
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
> index ee335d96fc39..46749dded1c9 100644
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
> index 209885a4134f..774dfd309cfe 100644
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


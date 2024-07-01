Return-Path: <linux-kernel+bounces-235414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AFF91D4CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B4E1C20ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5610F9;
	Mon,  1 Jul 2024 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDXfrCLr"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59327387
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792149; cv=none; b=NgB9jThJGLqAKW+DODpSSLX7Dk70kFzZpwy8hl2pN0wMfyNFvl3jE900LL1vL4N694Ib7DjzmBfixAZCVK6bDwpCz2rqKI69CPPOsSVWsNgcZGEeen6oGhMnmsf2TneqGXTHGbyZsacNo9E0fNMpCiz3EJesEbc51roiakR9d9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792149; c=relaxed/simple;
	bh=NbgkfrTDAiPMFVVs0YSeT9ayus6njpTHVQtt6B8eRv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dj2/geH9igHIRdT9CGgN83YPfGKYSKgRixRltxSt+qJ8IpuFpjOFEmMt4no7YYzO/M7oW5IJwcKfKaBHV/t68C7xvQYHYSe0AK5LGel/fwkSzc5fRlUyUXM7R9611cLb9x10UnHs2UyCQGegZFxS91xn6j/I9MXRojEM93qhCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDXfrCLr; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4ef5f4e3f56so768767e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 17:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719792145; x=1720396945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhN9AvD496DDfdjwo2Jpu2JMzYfWFg3K+lNbZSu8nz0=;
        b=aDXfrCLrrz7BVYZReKrHtqYIberssV2zlyF+ITBlzS8vN06+DUQNs6rDQYC9M84SPo
         TgU+qHh0gfPHjpbVrQgtf0xqkKesfqyN8Sk/Of4yI7L5XYxCKAapwNpj2zwqWHR5wukg
         0qxPrJJkdhb/5yS82DUtKmQakmvHttN85TZLmW0l4C9s0DPq34ViF13a3gC5H1DdJX95
         8/6NY1vx2oZHFsdCLscl6br+18LT4cSe4ca1pdFgcWjmDcd432AslKm8uEIvJgpNzR8m
         /nkPlWjkLvIogi0LBGmK+fkgNip9QeFqCozWldnHs5+hj8W6e2YulbNH1WLMWr3tanh5
         puZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719792145; x=1720396945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhN9AvD496DDfdjwo2Jpu2JMzYfWFg3K+lNbZSu8nz0=;
        b=MGzFZ/75PuQmBVuVx8JIOkqgjPjkRzypFT8vDehdno5DN9cipS+PyZQHYXTzeB1vmT
         HtggLiiE2eoaZI8XhJKOa1MTBzQ8fSXpB3AmNDebf50XoEVvEjLIQnuvHeyouErFb4vC
         ST+qktwIYkaxH4tGaLRgv5yjSIoRvUPlpbkD/yCoFgwqkRUIUkpN59AugdFajoLIUZvV
         YWst85/X9wgi9CxjvH1DldWSUOXkNPAXftTcV6T8MTwG/vlD3pzA3OXxkByssXgGWE+w
         evqLil4DA74FBueZF2YVyGtvu35cwXZY4RxSlSK0C0cWRQKDkjA1U7ks0onqADdxV+2o
         QcTA==
X-Forwarded-Encrypted: i=1; AJvYcCUlfmfV4GWsS21FUSSXMcyToRfeIKhtsLP2TPjiLXne7l5fHz3kzEHgY0Wrd94gFn9PhtwL7pdfGSIyQNehctObA4g/trVC6IEkzBK3
X-Gm-Message-State: AOJu0YwVh4Y++lCDm1MaTcDTx/cPiKIXNk9y3EP1YqFY6WSNvCAGtFvy
	blXxDMPG15R5wUDsUNjwCOOmHFLlBo530AOP6bTNC9gRIYzKPpNQ+ZGbWSPGHkdE6+PGx5ZWYNo
	LENCFENevYdJXsXSThqgDUDfANWU=
X-Google-Smtp-Source: AGHT+IFkYOZAIccehM4mD5dWvZy3ssCMdsjnZYfbVnoRIM94K1dOA5MX7p4didYbA0msMSHMQoipe2OMdh8UBaXpttc=
X-Received: by 2002:a05:6122:1b85:b0:4ef:6b47:3570 with SMTP id
 71dfb90a1353d-4f2a56addcbmr5108954e0c.8.1719792145192; Sun, 30 Jun 2024
 17:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628130750.73097-1-ioworker0@gmail.com> <20240628130750.73097-2-ioworker0@gmail.com>
In-Reply-To: <20240628130750.73097-2-ioworker0@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 1 Jul 2024 12:02:14 +1200
Message-ID: <CAGsJ_4yF6ucmLpMpdfjEgZXB6CP7vQkidqfugsmo1vGiaUb97g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: add per-order mTHP split counters
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, dj456119@gmail.com, ryan.roberts@arm.com, 
	david@redhat.com, shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 1:09=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> Currently, the split counters in THP statistics no longer include
> PTE-mapped mTHP. Therefore, we propose introducing per-order mTHP split
> counters to monitor the frequency of mTHP splits. This will help develope=
rs
> better analyze and optimize system performance.
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>         split
>         split_failed
>         split_deferred
>
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>

Personally, I'm not convinced that using a temporary variable order
makes the code
more readable. Functions like folio_test_pmd_mappable() seem more readable =
to
me. In any case, it's a minor issue.

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/huge_mm.h |  3 +++
>  mm/huge_memory.c        | 19 ++++++++++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 212cca384d7e..cee3c5da8f0e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -284,6 +284,9 @@ enum mthp_stat_item {
>         MTHP_STAT_FILE_ALLOC,
>         MTHP_STAT_FILE_FALLBACK,
>         MTHP_STAT_FILE_FALLBACK_CHARGE,
> +       MTHP_STAT_SPLIT,
> +       MTHP_STAT_SPLIT_FAILED,
> +       MTHP_STAT_SPLIT_DEFERRED,
>         __MTHP_STAT_COUNT
>  };
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c7ce28f6b7f3..a633206375af 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -559,6 +559,9 @@ DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPO=
UT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHAR=
GE);
> +DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> +DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> +DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>
>  static struct attribute *stats_attrs[] =3D {
>         &anon_fault_alloc_attr.attr,
> @@ -569,6 +572,9 @@ static struct attribute *stats_attrs[] =3D {
>         &file_alloc_attr.attr,
>         &file_fallback_attr.attr,
>         &file_fallback_charge_attr.attr,
> +       &split_attr.attr,
> +       &split_failed_attr.attr,
> +       &split_deferred_attr.attr,
>         NULL,
>  };
>
> @@ -3068,7 +3074,7 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
>         XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_o=
rder);
>         struct anon_vma *anon_vma =3D NULL;
>         struct address_space *mapping =3D NULL;
> -       bool is_thp =3D folio_test_pmd_mappable(folio);
> +       int order =3D folio_order(folio);
>         int extra_pins, ret;
>         pgoff_t end;
>         bool is_hzp;
> @@ -3076,7 +3082,7 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>         VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>
> -       if (new_order >=3D folio_order(folio))
> +       if (new_order >=3D order)
>                 return -EINVAL;
>
>         if (folio_test_anon(folio)) {
> @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
>                 i_mmap_unlock_read(mapping);
>  out:
>         xas_destroy(&xas);
> -       if (is_thp)
> +       if (order >=3D HPAGE_PMD_ORDER)
>                 count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAI=
LED);
> +       count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_F=
AILED);
>         return ret;
>  }
>
> @@ -3278,13 +3285,14 @@ void deferred_split_folio(struct folio *folio)
>  #ifdef CONFIG_MEMCG
>         struct mem_cgroup *memcg =3D folio_memcg(folio);
>  #endif
> +       int order =3D folio_order(folio);
>         unsigned long flags;
>
>         /*
>          * Order 1 folios have no space for a deferred list, but we also
>          * won't waste much memory by not adding them to the deferred lis=
t.
>          */
> -       if (folio_order(folio) <=3D 1)
> +       if (order <=3D 1)
>                 return;
>
>         /*
> @@ -3305,8 +3313,9 @@ void deferred_split_folio(struct folio *folio)
>
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         if (list_empty(&folio->_deferred_list)) {
> -               if (folio_test_pmd_mappable(folio))
> +               if (order >=3D HPAGE_PMD_ORDER)
>                         count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +               count_mthp_stat(order, MTHP_STAT_SPLIT_DEFERRED);
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
>                 ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
> --
> 2.45.2
>


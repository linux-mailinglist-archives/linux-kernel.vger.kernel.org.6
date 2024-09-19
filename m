Return-Path: <linux-kernel+bounces-333033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 168FC97C274
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7FE3B21C22
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2B14A82;
	Thu, 19 Sep 2024 01:34:15 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EA81E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709655; cv=none; b=Ri5mioiu+5YdrvjtXw8Bc0UL8mFtOqHy394r+Aeignyil0TaK9VoVQsIRiPwoaAJVfsh6w/MYTZgBnOX3ybi69lj8hak8FPkY1huuXavDQhLcHNubDZD7k5jIWgsjK4jG+YM/xMahCQrbJMF+aJ9ZxmBg7tVWtwTofYs4jZnpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709655; c=relaxed/simple;
	bh=ykOTfw5zso1+0VIQV5rtCpBpA3CaAiBzq75mFIuOssw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYoptQzAb55JMPO1rS20pjEJcw8FlBP54suFNOVuTpJ4POM7VQW5JFAdmOZGk6PtdzU5/HQT3/yE+wXGFktrUFzlLMjsmVbjO7r3Pe0Xldk4BK5FQRyxsv8dKOhQlZApHWU7qZIM9mHvjVkG7g+8ZDckNccLgI9TtluALsj4+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49bcfbc732eso109861137.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 18:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726709652; x=1727314452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBad09+wpx5AmVzF0EpKxcrxl3VCINq6sl7VTRT01To=;
        b=AniOXR8/icl8cPJb6zB28WP8EqhH42rN84RGzWYnBtbvqEMj9EO2Kl9uWf/ymVOf2l
         2CV8mG6++j+qE5Pmbb1oswnmu4fM/04CjNULSFTabXQZ959DNt2/7EKJKt0WVBNuTo1e
         ywETtggAbduVY2oEEWqnkXf5oftbTGrB5MJo6MM3aCkVgJYJPmsvLsZh0k7ZKQcNzsZ+
         FCBhor4qdIh9VEIWmFY2ytnKlbG3XrAqzLl23NSorRiLgI2R5DnhYIrFFOau9mfCN0KD
         ok5IdjZgoLWht4Q7lX8YsjTH53bJMH7UBsuQBQL+EBfWvLHfORxqnLKIwz1sLVgTXzJ7
         3s2g==
X-Forwarded-Encrypted: i=1; AJvYcCXn4lW1MStciyutM3xi5klNpABrAX5pe5q7vchyt4SQ0Q6WD8U88UWEBmNFamhAcAxEXFNrRIOgn0niv/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2pyuOFAqxtwXcy/HnbZNVXWvKNdAoG/7AkcVJx4GhZNF2d+V
	iIJV7FiJZSDwChpme4M2KZ2n11Q5ZeZyhE+M6HkxyvS/wOdZnPahIqGrt5CPMjG95ezkHWn2pxY
	JqWUB9GVZsY+UULxxk56ybFr2ZwE=
X-Google-Smtp-Source: AGHT+IFpxDivPgV0RcZZM7jjnKj7YzNnBdRJMbkQFPtAH+YGnBAqnYoheQ8i+U1mH8m2BW0Q2HIjg8xzhcYGdt6x7Bo=
X-Received: by 2002:a05:6102:3a0e:b0:49b:f52d:4922 with SMTP id
 ada2fe7eead31-49d4f6f4a03mr14422220137.27.1726709652294; Wed, 18 Sep 2024
 18:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916110754.1236200-1-dev.jain@arm.com> <20240916110754.1236200-3-dev.jain@arm.com>
In-Reply-To: <20240916110754.1236200-3-dev.jain@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 19 Sep 2024 13:34:01 +1200
Message-ID: <CAGsJ_4wuSqA8vzHCTH6rnVrppQ4k0FUcSu-=6HfAf+oYqz15bQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: Compute first_set_pte to eliminate evaluating
 redundant ranges
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, hughd@google.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, 
	baolin.wang@linux.alibaba.com, gshan@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 11:08=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> For an mTHP allocation, we need to check, for every order, whether for
> that order, we have enough number of contiguous PTEs empty. Instead of
> iterating the while loop for every order, use some information, which
> is the first set PTE found, from the previous iteration to eliminate
> some cases. The key to understanding the correctness of the patch
> is that the ranges we want to examine form a strictly decreasing
> sequence of nested intervals.

Could we include some benchmark data here, as suggested by Ryan in this thr=
ead?

https://lore.kernel.org/linux-mm/58f91a56-890a-45d0-8b1f-47c4c70c9600@arm.c=
om/

>
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

> ---
>  mm/memory.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 8bb1236de93c..e81c6abe09ce 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4633,10 +4633,11 @@ static struct folio *alloc_anon_folio(struct vm_f=
ault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       pte_t *first_set_pte =3D NULL, *align_pte, *pte;
>         unsigned long orders;
>         struct folio *folio;
>         unsigned long addr;
> -       pte_t *pte;
> +       int max_empty;
>         gfp_t gfp;
>         int order;
>
> @@ -4671,8 +4672,23 @@ static struct folio *alloc_anon_folio(struct vm_fa=
ult *vmf)
>         order =3D highest_order(orders);
>         while (orders) {
>                 addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -               if (pte_range_none(pte + pte_index(addr), 1 << order) =3D=
=3D 1 << order)
> +               align_pte =3D pte + pte_index(addr);
> +
> +               /* Range to be scanned known to be empty */
> +               if (align_pte + (1 << order) <=3D first_set_pte)
> +                       break;
> +
> +               /* Range to be scanned contains first_set_pte */
> +               if (align_pte <=3D first_set_pte)
> +                       goto repeat;
> +
> +               /* align_pte > first_set_pte, so need to check properly *=
/
> +               max_empty =3D pte_range_none(align_pte, 1 << order);
> +               if (max_empty =3D=3D 1 << order)
>                         break;
> +
> +               first_set_pte =3D align_pte + max_empty;
> +repeat:
>                 order =3D next_order(&orders, order);
>         }
>
> --
> 2.30.2
>

Thanks
barry


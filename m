Return-Path: <linux-kernel+bounces-268573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722EC942666
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32A41C2339B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA4F16D30E;
	Wed, 31 Jul 2024 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH8JSCYW"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987916D306
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406696; cv=none; b=ZIkkhhndIAc8k7K/eaCVosAR0VTGWtFnUmOChnES+Q/kWff5xpYwkaj8HglhwZ3ir7Yb4r7S9mcL6BUmhs3tpNHMPdrmlpnQwmxqozFFhNc8uJm3knH/Q2Z5wWVNyNvvQgERFlmACfui1GxVbW9C87zq2F/RKDX5AfqfbY5b9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406696; c=relaxed/simple;
	bh=I/TzUtGm5dsjC2bY7Pvx5LOWjpD7aJ9uRi1SCaNT/+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjLcLmAXbIvGywz2KztVbclJkbelcfkW1LlIgIOCykkYWipiyszZvb48AQYw0sKgm28GXkT+IQwMXMjTcOHqFmtPVZl+9YL0i+9iTGv92p/hABqcLuQ38RGWC7Uu5zOFNuCv4CqFcQTvvEgPG9/FxDcN6lqX1zMzGQJItpnBgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH8JSCYW; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4928fb6fdceso1256677137.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722406693; x=1723011493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQOA432Rv2c5W9i9LzMUmIPMyKCH0QxKTf51rYbywUs=;
        b=aH8JSCYWl4ra2CCf4+Onq+L9s2qCOnmth7uFdRJCXhDzv/srdEoCd50TtdUIqnPVMH
         C3d3IlSknme3CaIpTom0ycC9x6E9iy27BP+icSL2Br55eXK0u9q5Ak2bBsMZw9dgUPR9
         3t47YQHUHuzPYrh393twvPXcd8ayUpgyvxIp6xuYJ7gTCBXuGSo0VatTxHXszajwHURr
         SMMHMcc0EquwUfwt9dp29SlKryZpwQaKme7PLUzzxnXCQZhBlSpXcXePv8QcA5wRLG+z
         h0Sc8P3jVxJHbtPXICjeQdqLy773euSruzrGXOgWaRbjw+u2miVG7O+xvLeiEUmKoMOy
         0AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722406693; x=1723011493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQOA432Rv2c5W9i9LzMUmIPMyKCH0QxKTf51rYbywUs=;
        b=idMfnV+MM8oby/+UJha6adWa5KroVvcRhsUSZw5OVRgMQLyDURmllZaNZLTqKg/E27
         AuP61HhIH9xSG0IxXS8uhpL3hg9Y6SU6btecv+Ua38JJilLLilis2JKrY1uQufD7LH5P
         //Vuz8XzayErWNqGhZ10xve1AtJs4iRatzDteZsZLbaAfqhG9wMoK42bGgmZEsTi1cb/
         +2AtX+IfGyf5cfavUDCBAdLG2bs8882YSV2MO3m9Xg2Wt55TzUPhMLJnZ0dDVuva1PED
         Lut5bXrAw03GqlHdeNM8ZeRck3qa6gOmJ6v9ie1kgUf1qrDfg5+qPBt+KblfON3StwSo
         s+2A==
X-Forwarded-Encrypted: i=1; AJvYcCVnM3Vvv0QeKhIqkfmRWPA7uaqe+bbS6rGK4fglI5ZxL5SMCkeOVZpoRIMl0KjEJH431S9xzSRDYaNkhobu62fV4a52VqIcJl0PcBUY
X-Gm-Message-State: AOJu0Yy4MPKVAkFFIwLictOd+i8NOo2rZhV7ZTGW9uxbpa0TqfIsBGcy
	3QKkxGdZbbO9E38wfofblG8sf3E/5PnKStyDQpCGdGW3YZIsTTGnwQYDFsKepvgLwn58r5pqOqE
	Wwo6F5tO88O0pu662XfEXrmlTck4=
X-Google-Smtp-Source: AGHT+IFxlvDFGFPzwYiaEvEcfgvj+lJ/K4qT6SPGE+9amWJjxCy0bEBUZfNtT5zuXRffrH77Ich77/Bb8zEE2vazO5s=
X-Received: by 2002:a05:6102:3589:b0:48f:e5d1:241d with SMTP id
 ada2fe7eead31-493faa40575mr16294359137.14.1722406693487; Tue, 30 Jul 2024
 23:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 31 Jul 2024 14:18:02 +0800
Message-ID: <CAGsJ_4xmHY06VAKzXxCFcovPkrR0WOR28jXbaeD5VyUBHWzn_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com, gshan@redhat.com, 
	ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:46=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Similar to commit d659b715e94ac ("mm/huge_memory: avoid PMD-size page cac=
he
> if needed"), ARM64 can support 512MB PMD-sized THP when the base page siz=
e is
> 64KB, which is larger than the maximum supported page cache size MAX_PAGE=
CACHE_ORDER.
> This is not expected. To fix this issue, use THP_ORDERS_ALL_FILE_DEFAULT =
for
> shmem to filter allowable huge orders.
>
> Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/shmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 2faa9daaf54b..a4332a97558c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1630,10 +1630,10 @@ unsigned long shmem_allowable_huge_orders(struct =
inode *inode,
>         unsigned long within_size_orders =3D READ_ONCE(huge_shmem_orders_=
within_size);
>         unsigned long vm_flags =3D vma->vm_flags;
>         /*
> -        * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
> +        * Check all the (large) orders below MAX_PAGECACHE_ORDER + 1 tha=
t
>          * are enabled for this vma.

Nit:
THP_ORDERS_ALL_FILE_DEFAULT should be self-explanatory enough.
I feel we don't need this comment?

>          */
> -       unsigned long orders =3D BIT(PMD_ORDER + 1) - 1;
> +       unsigned long orders =3D THP_ORDERS_ALL_FILE_DEFAULT;
>         loff_t i_size;
>         int order;
>
> --
> 2.39.3
>

Thanks
Barry


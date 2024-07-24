Return-Path: <linux-kernel+bounces-260720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42293AD62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187FF1C226A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9148060D;
	Wed, 24 Jul 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WENq/h+9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7322046B91
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807173; cv=none; b=BZVZTI0owqykAg2WWSSq7H+5ZFcpj/EM5nEiJPHgM/sIOcqNBrzOcknPvqgbBLtzqDFZd3ok7nPBoWn/ZTZJx9FoizzWiJooK0xx3hbGUTWRKYiM28VoBCcX1xyltVy6qoOhND47WUXMquxQS1tGYLt1dC1Y+bKntnLyRZo0F+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807173; c=relaxed/simple;
	bh=FBMMrtHEP4jAsvlmIUxSauMRnMpG7zi4alT23X5pUEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feWwRQiZtvgV48LpFGrJ43CqNwFU4C/SINr5i25Bo4MOJnC4igDk0m0XUDcyBXMCk4IVYQ4Q5kXK2KjpWceqZ/YYHvmPn86mYYKwq2r/n4lqGJJLKp6cX5RbLhKZsbmWMuLbzAsfyy8sA5sl2MSs65Ewd5J8d2ZjMfr9w25jtO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WENq/h+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D14CC4AF12
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721807173;
	bh=FBMMrtHEP4jAsvlmIUxSauMRnMpG7zi4alT23X5pUEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WENq/h+9Z063qDnGjK7VO+nxj/hVaAr2NE4CLGYRp/DnsQpAH29eVcFQsmFiY7l3r
	 HLTH8oqy2ojqR+4GZ29dE12vGbf1akWj4/oh71XZP1CAyJ4NzCfWDFuuSqE60uUYUs
	 EhIlUJ0WgnnKgXfrKhvmksEJOmWNsmHISKqT28jQccfycs7VpQEltwzD6K+pVB/YoV
	 Y/1lDP9gy732k7bTukrUPyEN/5EBccP65kyvU8wZw5f9YGoHNm1KN70CUIM2cLAYDH
	 lWxbVijQAwg3vmV9VLDRtE1ZCd7yurMBrtYjB4onVeA0wu1vcUf5KtLJbIDmkpUD7y
	 evn/cSucZ7Www==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65faa0614dbso65833627b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:46:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmoCIP0nATehef8Z1jLB1nk1r6IQJAqX15xYzU1AYMABl98bTcZ6s4VfUd9t/B1mq0P9F7DVfoFblDN9NIHcCYQQUFNxDDH9Y+Q9N8
X-Gm-Message-State: AOJu0YzVeGcFWJfgGDqh0lsfJE99vJBEji6vCjvwkhShLxM6ZckW/aMI
	smG0jvMjRrzO8WTGjkOrwjU6n84VaZOTpZ5ldSnWctwf22Bx01z5fmKLtH6UZyifX6nTh3fnhGG
	TVMV2/CyxzyCjXmbTnEIOxfGDGMIOnc3Jq8D6Aw==
X-Google-Smtp-Source: AGHT+IGop+rJ/oNopZpk4iSvJN5Yseo4mIWhH9RSmTEcfv93mywNA5w4BXIDkdNiOh0h5D8lLV6JPPSUaqTN6NB0qiU=
X-Received: by 2002:a05:690c:c:b0:65f:8f77:720f with SMTP id
 00721157ae682-671f09def59mr29089367b3.5.1721807172248; Wed, 24 Jul 2024
 00:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724020056.65838-1-21cnbao@gmail.com>
In-Reply-To: <20240724020056.65838-1-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 24 Jul 2024 00:46:01 -0700
X-Gmail-Original-Message-ID: <CACePvbUihp+tuCaRh5LbRW+eFmeQbzp0K+BWHUHObytrkTUVyw@mail.gmail.com>
Message-ID: <CACePvbUihp+tuCaRh5LbRW+eFmeQbzp0K+BWHUHObytrkTUVyw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Extend 'usage' parameter so that
 cluster_swap_free_nr() can be reused
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@redhat.com, 
	hanchuanhua@oppo.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	ryan.roberts@arm.com, v-songbaohua@oppo.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Tue, Jul 23, 2024 at 7:01=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Extend a usage parameter so that cluster_swap_free_nr() can be reused by
> both swapcache_clear() and swap_free().
> __swap_entry_free() is quite similar but more tricky as it requires the
> return value of __swap_entry_free_locked() which cluster_swap_free_nr()
> doesn't support.
>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Chuanhua Han <hanchuanhua@oppo.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  -v3: resend &collect Ryan's reviewed-by
>
>  mm/swapfile.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 38bdc439651a..5f73a8553371 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1344,7 +1344,8 @@ static void swap_entry_free(struct swap_info_struct=
 *p, swp_entry_t entry)
>  }
>
>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
> -               unsigned long offset, int nr_pages)
> +               unsigned long offset, int nr_pages,
> +               unsigned char usage)
>  {
>         struct swap_cluster_info *ci;
>         DECLARE_BITMAP(to_free, BITS_PER_LONG) =3D { 0 };
> @@ -1354,7 +1355,7 @@ static void cluster_swap_free_nr(struct swap_info_s=
truct *sis,
>         while (nr_pages) {
>                 nr =3D min(BITS_PER_LONG, nr_pages);
>                 for (i =3D 0; i < nr; i++) {
> -                       if (!__swap_entry_free_locked(sis, offset + i, 1)=
)
> +                       if (!__swap_entry_free_locked(sis, offset + i, us=
age))
>                                 bitmap_set(to_free, i, 1);
>                 }
>                 if (!bitmap_empty(to_free, BITS_PER_LONG)) {
> @@ -1388,7 +1389,7 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
>
>         while (nr_pages) {
>                 nr =3D min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % S=
WAPFILE_CLUSTER);
> -               cluster_swap_free_nr(sis, offset, nr);
> +               cluster_swap_free_nr(sis, offset, nr, 1);
>                 offset +=3D nr;
>                 nr_pages -=3D nr;
>         }
> @@ -3472,15 +3473,9 @@ int swapcache_prepare(swp_entry_t entry)
>
>  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
>  {
> -       struct swap_cluster_info *ci;
>         unsigned long offset =3D swp_offset(entry);
> -       unsigned char usage;
>
> -       ci =3D lock_cluster_or_swap_info(si, offset);
> -       usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> -       unlock_cluster_or_swap_info(si, ci);
> -       if (!usage)
> -               free_swap_slot(entry);
> +       cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
>  }
>
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
> --
> 2.34.1
>


Return-Path: <linux-kernel+bounces-383851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED39B20F1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FABC1F2139A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F61885B8;
	Sun, 27 Oct 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl7p+BJD"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F7538A;
	Sun, 27 Oct 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730066074; cv=none; b=hY88Lug0MLOUAJjTDU+3naxLaRBkZYnNUEHhIH7M02svIait7l1HLWGJUFCXbUGl+YfsQ/23jwbg9OZ/ZDJvJT/YkaotKAaM4GfZZTN37liCmYC7hX6EEahMsI17nDgGhvlD0jhkYHxa8KjytfXPXSb9Lvjt+Lc4vzmyfPYLb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730066074; c=relaxed/simple;
	bh=lP2p6HUVVCc965DSTSO4R0dYcfXbzJP2vNz+GGd43K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJY5N1Hs/SAFHrDbvBQM8iNY6Rr3TyXHWoxQN0bSoe64sCJ1+M+6YdNDNkQTigHESV0q8QiA5qabSHLpiAuVvuM12LrFTzk/8l0faAuTjiEog5lukzVSH+ZiRVLLpw+0BbZWjq7zInSFbnTg3JbjvnrOJzfJi0NBFGHkoDnXO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl7p+BJD; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a47177cf6bso1236589137.3;
        Sun, 27 Oct 2024 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730066070; x=1730670870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4LBARO2VWUVfjfQOMm1iO16EEmOYiq18g4Z+k4irkM=;
        b=dl7p+BJDjPTceADs6R+L6LQ+TQSSzGE+SjCnRaS3zClDfIk5A7IS1sCjXuZGHjmbqu
         smCmX0vRW4oVcdpopPzTCgAlCJKCe/JRDLa+P7kghGNXYGXoiXRFQkBus3Qy4vlTKTgL
         zpHcyRwLclj8rTCFbTbEUo5dva25hgvEz1k8K0VBDK/+SOleeZR0GmqbFVjk6BUqclAu
         I67jngN+Ym8B6+OY3NTifXU7bLJBxmQjZA5HOgcF1eTwa8tCo9OyCSEn0L+VIj7X9Hrl
         TUnwf7WAXhUUSp7z/CLueXkW4hvvR38k1Lu8lO7iY3GMy2QhFyGPaHpW0vOack6mAUmE
         XOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730066070; x=1730670870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4LBARO2VWUVfjfQOMm1iO16EEmOYiq18g4Z+k4irkM=;
        b=Y75bEMC42EXgXWaDMyfb18EsObAzDz6mdPsJslWK3TZ7Mg1CqoDw3QCjtEdo910d9H
         l653jKqtp9qnyZPzoDgZJ2yf6dV5Av6EgN7i+1eSlUTMCr9EfHE446sfihTBiOSDSoTR
         Uuwpk46cdJzJcXIuXvSo0x2FhZeKVcpRxMKMSM2DzTZSvfrCwKzetfMnlgsGRQy1Xdab
         LC29kNqMLxQxvu7szI3s8seLxoTTYUKiqEgh45COTv8wfDjIZKcDREHX2/5SBhESytYu
         ltfHLjZRgITfi3hUouev/FBUpNUFcPPuW+rPlP24acF0bbCH/bwaEBvOo3HS7pRMDfz5
         e8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1T/iFJrf/7PY7p+rdnoIctEQ96bZ3bKngsfa/8h8AoHfUM1Qk5yGS/QtLXc8mYJ8KQOnT5WyyvDcdyG5@vger.kernel.org, AJvYcCWjz7SyNfOC3QCcccYDNn6uWw2zcf+DiIPlIA5p1t37GCF9fOcfPkJJNjM5EhcDiAljm01S0TmRt3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Z6N9WhPO0OfKhHG1nBd2tmuTS43v281uzoP6ljcRi+zG0Q5X
	PLE7AS5p+HU2bA0MjdHa7GsdOoejHwgb0dTeD5UBYFkqloSb5Dj5s5mNx9arEgYF4m8jKWxboW4
	kdYxYxYfH3EOAwqEgnr/FPqsHBcI=
X-Google-Smtp-Source: AGHT+IEpmLTD4g+THx4mqPFX4Zc1dkM6ydFdYrW6KOFru8Qg3FBmXgclL1JPebcHwOhqBqrB92Mvsy5hkiYKBiJmqhg=
X-Received: by 2002:a05:6122:1ad5:b0:50a:36ab:c788 with SMTP id
 71dfb90a1353d-51014ff5f55mr3245260e0c.3.1730066070273; Sun, 27 Oct 2024
 14:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027175743.1056710-1-mcanal@igalia.com> <20241027175743.1056710-4-mcanal@igalia.com>
In-Reply-To: <20241027175743.1056710-4-mcanal@igalia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Oct 2024 10:54:19 +1300
Message-ID: <CAGsJ_4xCw3OvkMo6cVr+U97C3SO+n+5c1j5XRodLDaLXW4ALjg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: shmem: override mTHP shmem default with a kernel parameter
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 6:58=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Add the ``thp_shmem=3D`` kernel command line to allow specifying the
> default policy of each supported shmem hugepage size. The kernel paramete=
r
> accepts the following format:
>
> thp_shmem=3D<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<pol=
icy>
>
> For example,
>
> thp_shmem=3D16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M-8=
M:within_size
>
> By configuring the default policy of several shmem huge pages, the user
> can take advantage of mTHP before it's been configured through sysfs.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  10 ++
>  Documentation/admin-guide/mm/transhuge.rst    |  17 +++
>  mm/shmem.c                                    | 109 +++++++++++++++++-
>  3 files changed, 135 insertions(+), 1 deletion(-)
>

Hi Ma=C3=ADra,

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index acabb04d0dd4..595fa096e28b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6700,6 +6700,16 @@
>                         Force threading of all interrupt handlers except =
those
>                         marked explicitly IRQF_NO_THREAD.
>
> +       shmem_anon=3D     [KNL]
> +                       Format: <size>[KMG],<size>[KMG]:<policy>;<size>[K=
MG]-<size>[KMG]:<policy>
> +                       Control the default policy of each hugepage size =
for the
> +                       internal shmem mount. <policy> is one of policies=
 available
> +                       for the shmem mount ("always", "inherit", "never"=
, "within_size",
> +                       and "advise").
> +                       It can be used multiple times for multiple shmem =
THP sizes.
> +                       See Documentation/admin-guide/mm/transhuge.rst fo=
r more
> +                       details.

I'm not sure this is the right name. How about "thp_shmem"?

> +
>         topology=3D       [S390,EARLY]
>                         Format: {off | on}
>                         Specify if the kernel should make use of the cpu
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 9b5b02c4d1ab..47e7fc30e22d 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -332,6 +332,23 @@ allocation policy for the internal shmem mount by us=
ing the kernel parameter
>  seven valid policies for shmem (``always``, ``within_size``, ``advise``,
>  ``never``, ``deny``, and ``force``).
>
> +In the same manner as ``thp_anon`` controls each supported anonymous THP
> +size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shmem`=
`
> +has the same format as ``thp_anon``, but also supports the policy
> +``within_size``.
> +
> +``thp_shmem=3D`` may be specified multiple times to configure all THP si=
zes
> +as required. If ``thp_shmem=3D`` is specified at least once, any shmem T=
HP
> +sizes not explicitly configured on the command line are implicitly set t=
o
> +``never``.
> +
> +``transparent_hugepage_shmem`` setting only affects the global toggle. I=
f
> +``thp_shmem`` is not specified, PMD_ORDER hugepage will default to
> +``inherit``. However, if a valid ``thp_shmem`` setting is provided by th=
e
> +user, the PMD_ORDER hugepage policy will be overridden. If the policy fo=
r
> +PMD_ORDER is not defined within a valid ``thp_shmem``, its policy will
> +default to ``never``.
> +
>  Hugepages in tmpfs/shmem
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 24cdeafd8260..0a7a7d04f725 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always __read_=
mostly;
>  static unsigned long huge_shmem_orders_madvise __read_mostly;
>  static unsigned long huge_shmem_orders_inherit __read_mostly;
>  static unsigned long huge_shmem_orders_within_size __read_mostly;
> +static bool shmem_orders_configured __initdata;
>  #endif
>
>  #ifdef CONFIG_TMPFS
> @@ -5013,7 +5014,8 @@ void __init shmem_init(void)
>          * Default to setting PMD-sized THP to inherit the global setting=
 and
>          * disable all other multi-size THPs.
>          */
> -       huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
> +       if (!shmem_orders_configured)
> +               huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
>  #endif
>         return;
>
> @@ -5174,6 +5176,26 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
=3D
>
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
>
> +static inline int get_order_from_str(const char *size_str)
> +{
> +       unsigned long size;
> +       char *endptr;
> +       int order;
> +
> +       size =3D memparse(size_str, &endptr);
> +
> +       if (!is_power_of_2(size))
> +               goto err;
> +       order =3D get_order(size);
> +       if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
> +               goto err;
> +
> +       return order;
> +err:
> +       pr_err("invalid size %s in thp_shmem boot parameter\n", size_str)=
;
> +       return -EINVAL;
> +}
> +
>  static int __init setup_transparent_hugepage_shmem(char *str)
>  {
>         int huge, ret =3D 0;
> @@ -5206,6 +5228,91 @@ static int __init setup_transparent_hugepage_shmem=
(char *str)
>  }
>  __setup("transparent_hugepage_shmem=3D", setup_transparent_hugepage_shme=
m);
>
> +static char str_dup[PAGE_SIZE] __initdata;
> +static int __init setup_thp_shmem(char *str)
> +{
> +       char *token, *range, *policy, *subtoken;
> +       unsigned long always, inherit, madvise, within_size;
> +       char *start_size, *end_size;
> +       int start, end, nr;
> +       char *p;
> +
> +       if (!str || strlen(str) + 1 > PAGE_SIZE)
> +               goto err;
> +       strcpy(str_dup, str);
> +
> +       always =3D huge_shmem_orders_always;
> +       inherit =3D huge_shmem_orders_inherit;
> +       madvise =3D huge_shmem_orders_madvise;
> +       within_size =3D huge_shmem_orders_within_size;
> +       p =3D str_dup;
> +       while ((token =3D strsep(&p, ";")) !=3D NULL) {
> +               range =3D strsep(&token, ":");
> +               policy =3D token;
> +
> +               if (!policy)
> +                       goto err;
> +
> +               while ((subtoken =3D strsep(&range, ",")) !=3D NULL) {
> +                       if (strchr(subtoken, '-')) {
> +                               start_size =3D strsep(&subtoken, "-");
> +                               end_size =3D subtoken;
> +
> +                               start =3D get_order_from_str(start_size);
> +                               end =3D get_order_from_str(end_size);
> +                       } else {
> +                               start =3D end =3D get_order_from_str(subt=
oken);
> +                       }
> +
> +                       if (start < 0 || end < 0 || start > end)
> +                               goto err;
> +
> +                       nr =3D end - start + 1;
> +                       if (!strcmp(policy, "always")) {
> +                               bitmap_set(&always, start, nr);
> +                               bitmap_clear(&inherit, start, nr);
> +                               bitmap_clear(&madvise, start, nr);
> +                               bitmap_clear(&within_size, start, nr);
> +                       } else if (!strcmp(policy, "advise")) {
> +                               bitmap_set(&madvise, start, nr);
> +                               bitmap_clear(&inherit, start, nr);
> +                               bitmap_clear(&always, start, nr);
> +                               bitmap_clear(&within_size, start, nr);
> +                       } else if (!strcmp(policy, "inherit")) {
> +                               bitmap_set(&inherit, start, nr);
> +                               bitmap_clear(&madvise, start, nr);
> +                               bitmap_clear(&always, start, nr);
> +                               bitmap_clear(&within_size, start, nr);
> +                       } else if (!strcmp(policy, "within_size")) {
> +                               bitmap_set(&within_size, start, nr);
> +                               bitmap_clear(&inherit, start, nr);
> +                               bitmap_clear(&madvise, start, nr);
> +                               bitmap_clear(&always, start, nr);
> +                       } else if (!strcmp(policy, "never")) {
> +                               bitmap_clear(&inherit, start, nr);
> +                               bitmap_clear(&madvise, start, nr);
> +                               bitmap_clear(&always, start, nr);
> +                               bitmap_clear(&within_size, start, nr);
> +                       } else {
> +                               pr_err("invalid policy %s in thp_shmem bo=
ot parameter\n", policy);
> +                               goto err;
> +                       }
> +               }
> +       }
> +
> +       huge_shmem_orders_always =3D always;
> +       huge_shmem_orders_madvise =3D madvise;
> +       huge_shmem_orders_inherit =3D inherit;
> +       huge_shmem_orders_within_size =3D within_size;
> +       shmem_orders_configured =3D true;
> +       return 1;
> +
> +err:
> +       pr_warn("thp_shmem=3D%s: error parsing string, ignoring setting\n=
", str);
> +       return 0;
> +}

Can we share source code with thp_anon since there's a lot of duplication?

> +__setup("thp_shmem=3D", setup_thp_shmem);
> +
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  #else /* !CONFIG_SHMEM */
> --
> 2.46.2
>

Thanks
barry


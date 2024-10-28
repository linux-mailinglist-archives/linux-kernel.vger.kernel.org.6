Return-Path: <linux-kernel+bounces-384798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF29B2E92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825BCB22DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710481DB92E;
	Mon, 28 Oct 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AccJTgfd"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74631DB534;
	Mon, 28 Oct 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113792; cv=none; b=Fym1ftWCCGaZe6KsEfIixwqwbtcjLt0FexXRxpHz4sBNHs9k7G5BgDvpXRoMBUaU7wSn51lI+PcjSyljUSQr9SIRU2Roouwh2q4eaf+KYgMebktoAVPDpsH1kSciIeMMOzY/44NcbUXoxTLMAqsv4J5ia34ZxtYbCmJVx/HqSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113792; c=relaxed/simple;
	bh=E+PHdGDltxU1euCLrGi91frNFbi58aaQcoh6Bhqap/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3e0I6GaB+OaD2w0N/I7BvYFp0Mbe1AAzWkpsJESueuh0S1Ptuga0tAb35HA8zAwN+LDLF+xkwqAXF2WGLgpbVahZB/NRsHUOVs01XYFRyBDlSXYrb3VXpNz9zzdbtS8BqqPz3ZMwqOvOVltBvepHgKDiYo1xxb2dl9zrZGbyzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AccJTgfd; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-851d2a36e6dso2653794241.0;
        Mon, 28 Oct 2024 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113789; x=1730718589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DLP4K9pPqTa9mg1HyxWl56HscCu6UOOsW3HKODy+ow=;
        b=AccJTgfddwghILl+abSzoV6nqFH/6rpLvO8JjyRkTyLofajBGZnFkUvWZJiRdYrU9g
         eoEoJYmWpPQDJ+UCC0BzAFvaao73JVLYZaptpYyE5DBHYnFKjo5mGRZsCEFGFfVbmuq4
         2qOcMovKjyucztQUUCye+j5k4Hx8RnUB9jB8u2gRCERhR8pl4qoj2ttW+QvQg85Llf/b
         ovz8ACmID4Ct/AKQTpkIPhpqs5QJNM106xt3hqjj0TkGJIxMFamXgBXARBaEWc/0arh3
         z0Q8f1rz4QXAy3yyTTsIHmQ9YH9bFEifrLkh/ZcOgK1IE/GMYpGMBnRVGGd1z8k+VjKx
         nJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113789; x=1730718589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DLP4K9pPqTa9mg1HyxWl56HscCu6UOOsW3HKODy+ow=;
        b=Qnf8GsY1jF8dhJxu71sO/HlhaSaLvHwlJkNNu2Olxa2MuqS9B3DrvwxkwCfA9Lmr+t
         Sb2HXvr6c55XFJJdLkJ9Ane0DPX5IRyf38rQwL2Uc1Djri/lpLTbhfrb3o4UTlLOSSoi
         A10pskRXAWd/dlk/bY95wKekOo148xRTEtlXA4w7WgqSv72lqjTrQYcNoVHeMxHsmlD3
         XLsptolinJHLQVjx5i5Ci32HXMwYpYmxdigk8yx1qQirWNKrDYjrNPMFdTfHPA6U+Ow/
         Pal4+7c19TqkGfG7Buzt+kusd1MZToxtuSVEgY/Yyk38egC/N//RqexasZoWjfV3HFqK
         g9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjTodsF5RmZaoiyVxpC42k3lweSi3vRo5ApBxRytY6v8c5K8mnqWkeWQxEcU1vsQ6NarrDD2AbfKI=@vger.kernel.org, AJvYcCXQMMvtoUV0b80gZYXUCrhGkC7adKRtWR6Urj4ygYA+D3DDquN/zHa/k4nuJFZmvsGhry3kgGmfrDhPQy8b@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDScnwfrpN2LH3IIgt999QqDBWHNF+pIhdYHTeqQ5LaiplLmM
	Jx+S1GtqQw4o3HI3gfiPwWGaveCpe5+chWHwVD51m2ctAd7o2zZZc/eI/A3zwQxQt0+0YrHR/ef
	1m3GF4ShciJ5m3zqDpP+zbnkPHRI=
X-Google-Smtp-Source: AGHT+IFTG/DHIoyWwfm3i/7TVknzqpD9DN97MwLJKo6kniJxde0K916lgZsLVYrQTYhIIfNvhqs3HFHATappFb845l8=
X-Received: by 2002:a05:6122:7cc:b0:50c:ef20:6bed with SMTP id
 71dfb90a1353d-51013858e9cmr4429271e0c.3.1730113788620; Mon, 28 Oct 2024
 04:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027175743.1056710-1-mcanal@igalia.com> <20241027175743.1056710-4-mcanal@igalia.com>
 <CAGsJ_4xCw3OvkMo6cVr+U97C3SO+n+5c1j5XRodLDaLXW4ALjg@mail.gmail.com> <2505d52c-3454-4892-8c90-e3d9b2f0c84f@igalia.com>
In-Reply-To: <2505d52c-3454-4892-8c90-e3d9b2f0c84f@igalia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Oct 2024 19:09:37 +0800
Message-ID: <CAGsJ_4y13T+KE1hJPb=14LBvGixd4uQTcN5pS=Hok6Ca6RD+7g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: shmem: override mTHP shmem default with a kernel parameter
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 6:10=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Hi Barry,
>
> On 27/10/24 18:54, Barry Song wrote:
> > On Mon, Oct 28, 2024 at 6:58=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia=
.com> wrote:
> >>
> >> Add the ``thp_shmem=3D`` kernel command line to allow specifying the
> >> default policy of each supported shmem hugepage size. The kernel param=
eter
> >> accepts the following format:
> >>
> >> thp_shmem=3D<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<=
policy>
> >>
> >> For example,
> >>
> >> thp_shmem=3D16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4=
M-8M:within_size
> >>
> >> By configuring the default policy of several shmem huge pages, the use=
r
> >> can take advantage of mTHP before it's been configured through sysfs.
> >>
> >> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >> ---
> >>   .../admin-guide/kernel-parameters.txt         |  10 ++
> >>   Documentation/admin-guide/mm/transhuge.rst    |  17 +++
> >>   mm/shmem.c                                    | 109 ++++++++++++++++=
+-
> >>   3 files changed, 135 insertions(+), 1 deletion(-)
> >>
> >
> > Hi Ma=C3=ADra,
> >
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documen=
tation/admin-guide/kernel-parameters.txt
> >> index acabb04d0dd4..595fa096e28b 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -6700,6 +6700,16 @@
> >>                          Force threading of all interrupt handlers exc=
ept those
> >>                          marked explicitly IRQF_NO_THREAD.
> >>
> >> +       shmem_anon=3D     [KNL]
> >> +                       Format: <size>[KMG],<size>[KMG]:<policy>;<size=
>[KMG]-<size>[KMG]:<policy>
> >> +                       Control the default policy of each hugepage si=
ze for the
> >> +                       internal shmem mount. <policy> is one of polic=
ies available
> >> +                       for the shmem mount ("always", "inherit", "nev=
er", "within_size",
> >> +                       and "advise").
> >> +                       It can be used multiple times for multiple shm=
em THP sizes.
> >> +                       See Documentation/admin-guide/mm/transhuge.rst=
 for more
> >> +                       details.
> >
> > I'm not sure this is the right name. How about "thp_shmem"?
>
> Oops, sorry about that.
>
> >
> >> +
> >>          topology=3D       [S390,EARLY]
> >>                          Format: {off | on}
> >>                          Specify if the kernel should make use of the =
cpu
> >> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentatio=
n/admin-guide/mm/transhuge.rst
> >> index 9b5b02c4d1ab..47e7fc30e22d 100644
> >> --- a/Documentation/admin-guide/mm/transhuge.rst
> >> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >> @@ -332,6 +332,23 @@ allocation policy for the internal shmem mount by=
 using the kernel parameter
> >>   seven valid policies for shmem (``always``, ``within_size``, ``advis=
e``,
> >>   ``never``, ``deny``, and ``force``).
> >>
> >> +In the same manner as ``thp_anon`` controls each supported anonymous =
THP
> >> +size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shm=
em``
> >> +has the same format as ``thp_anon``, but also supports the policy
> >> +``within_size``.
> >> +
> >> +``thp_shmem=3D`` may be specified multiple times to configure all THP=
 sizes
> >> +as required. If ``thp_shmem=3D`` is specified at least once, any shme=
m THP
> >> +sizes not explicitly configured on the command line are implicitly se=
t to
> >> +``never``.
> >> +
> >> +``transparent_hugepage_shmem`` setting only affects the global toggle=
. If
> >> +``thp_shmem`` is not specified, PMD_ORDER hugepage will default to
> >> +``inherit``. However, if a valid ``thp_shmem`` setting is provided by=
 the
> >> +user, the PMD_ORDER hugepage policy will be overridden. If the policy=
 for
> >> +PMD_ORDER is not defined within a valid ``thp_shmem``, its policy wil=
l
> >> +default to ``never``.
> >> +
> >>   Hugepages in tmpfs/shmem
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index 24cdeafd8260..0a7a7d04f725 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always __re=
ad_mostly;
> >>   static unsigned long huge_shmem_orders_madvise __read_mostly;
> >>   static unsigned long huge_shmem_orders_inherit __read_mostly;
> >>   static unsigned long huge_shmem_orders_within_size __read_mostly;
> >> +static bool shmem_orders_configured __initdata;
> >>   #endif
> >>
> >>   #ifdef CONFIG_TMPFS
> >> @@ -5013,7 +5014,8 @@ void __init shmem_init(void)
> >>           * Default to setting PMD-sized THP to inherit the global set=
ting and
> >>           * disable all other multi-size THPs.
> >>           */
> >> -       huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
> >> +       if (!shmem_orders_configured)
> >> +               huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
> >>   #endif
> >>          return;
> >>
> >> @@ -5174,6 +5176,26 @@ struct kobj_attribute thpsize_shmem_enabled_att=
r =3D
> >>
> >>   #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
> >>
> >> +static inline int get_order_from_str(const char *size_str)
> >> +{
> >> +       unsigned long size;
> >> +       char *endptr;
> >> +       int order;
> >> +
> >> +       size =3D memparse(size_str, &endptr);
> >> +
> >> +       if (!is_power_of_2(size))
> >> +               goto err;
> >> +       order =3D get_order(size);
> >> +       if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
> >> +               goto err;
> >> +
> >> +       return order;
> >> +err:
> >> +       pr_err("invalid size %s in thp_shmem boot parameter\n", size_s=
tr);
> >> +       return -EINVAL;
> >> +}
> >> +
> >>   static int __init setup_transparent_hugepage_shmem(char *str)
> >>   {
> >>          int huge, ret =3D 0;
> >> @@ -5206,6 +5228,91 @@ static int __init setup_transparent_hugepage_sh=
mem(char *str)
> >>   }
> >>   __setup("transparent_hugepage_shmem=3D", setup_transparent_hugepage_=
shmem);
> >>
> >> +static char str_dup[PAGE_SIZE] __initdata;
> >> +static int __init setup_thp_shmem(char *str)
> >> +{
> >> +       char *token, *range, *policy, *subtoken;
> >> +       unsigned long always, inherit, madvise, within_size;
> >> +       char *start_size, *end_size;
> >> +       int start, end, nr;
> >> +       char *p;
> >> +
> >> +       if (!str || strlen(str) + 1 > PAGE_SIZE)
> >> +               goto err;
> >> +       strcpy(str_dup, str);
> >> +
> >> +       always =3D huge_shmem_orders_always;
> >> +       inherit =3D huge_shmem_orders_inherit;
> >> +       madvise =3D huge_shmem_orders_madvise;
> >> +       within_size =3D huge_shmem_orders_within_size;
> >> +       p =3D str_dup;
> >> +       while ((token =3D strsep(&p, ";")) !=3D NULL) {
> >> +               range =3D strsep(&token, ":");
> >> +               policy =3D token;
> >> +
> >> +               if (!policy)
> >> +                       goto err;
> >> +
> >> +               while ((subtoken =3D strsep(&range, ",")) !=3D NULL) {
> >> +                       if (strchr(subtoken, '-')) {
> >> +                               start_size =3D strsep(&subtoken, "-");
> >> +                               end_size =3D subtoken;
> >> +
> >> +                               start =3D get_order_from_str(start_siz=
e);
> >> +                               end =3D get_order_from_str(end_size);
> >> +                       } else {
> >> +                               start =3D end =3D get_order_from_str(s=
ubtoken);
> >> +                       }
> >> +
> >> +                       if (start < 0 || end < 0 || start > end)
> >> +                               goto err;
> >> +
> >> +                       nr =3D end - start + 1;
> >> +                       if (!strcmp(policy, "always")) {
> >> +                               bitmap_set(&always, start, nr);
> >> +                               bitmap_clear(&inherit, start, nr);
> >> +                               bitmap_clear(&madvise, start, nr);
> >> +                               bitmap_clear(&within_size, start, nr);
> >> +                       } else if (!strcmp(policy, "advise")) {
> >> +                               bitmap_set(&madvise, start, nr);
> >> +                               bitmap_clear(&inherit, start, nr);
> >> +                               bitmap_clear(&always, start, nr);
> >> +                               bitmap_clear(&within_size, start, nr);
> >> +                       } else if (!strcmp(policy, "inherit")) {
> >> +                               bitmap_set(&inherit, start, nr);
> >> +                               bitmap_clear(&madvise, start, nr);
> >> +                               bitmap_clear(&always, start, nr);
> >> +                               bitmap_clear(&within_size, start, nr);
> >> +                       } else if (!strcmp(policy, "within_size")) {
> >> +                               bitmap_set(&within_size, start, nr);
> >> +                               bitmap_clear(&inherit, start, nr);
> >> +                               bitmap_clear(&madvise, start, nr);
> >> +                               bitmap_clear(&always, start, nr);
> >> +                       } else if (!strcmp(policy, "never")) {
> >> +                               bitmap_clear(&inherit, start, nr);
> >> +                               bitmap_clear(&madvise, start, nr);
> >> +                               bitmap_clear(&always, start, nr);
> >> +                               bitmap_clear(&within_size, start, nr);
> >> +                       } else {
> >> +                               pr_err("invalid policy %s in thp_shmem=
 boot parameter\n", policy);
> >> +                               goto err;
> >> +                       }
> >> +               }
> >> +       }
> >> +
> >> +       huge_shmem_orders_always =3D always;
> >> +       huge_shmem_orders_madvise =3D madvise;
> >> +       huge_shmem_orders_inherit =3D inherit;
> >> +       huge_shmem_orders_within_size =3D within_size;
> >> +       shmem_orders_configured =3D true;
> >> +       return 1;
> >> +
> >> +err:
> >> +       pr_warn("thp_shmem=3D%s: error parsing string, ignoring settin=
g\n", str);
> >> +       return 0;
> >> +}
> >
> > Can we share source code with thp_anon since there's a lot of duplicati=
on?
>
> I'm not a regular mm contributor and I'm most usually around drivers, so
> I don't know exactly here I could add shared code. Should I add the
> headers to "internal.h"?

My comment isn't related to drivers or memory management. It's solely about
avoiding code duplication. For example, we could create a shared function t=
o
handle both controls, reducing redundant code :-)

>
> Best Regards,
> - Ma=C3=ADra
>
> >
> >> +__setup("thp_shmem=3D", setup_thp_shmem);
> >> +
> >>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >>
> >>   #else /* !CONFIG_SHMEM */
> >> --
> >> 2.46.2
> >>
> >
> > Thanks
> > barry
>


Return-Path: <linux-kernel+bounces-383918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CEB9B21EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08084281170
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 01:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109113D281;
	Mon, 28 Oct 2024 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQdNGoKk"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7ED36C;
	Mon, 28 Oct 2024 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078536; cv=none; b=upz94wCSP/apCEPxlYR4aWeOzoly4+bYjlxZ0s/2qUHqgMG7sJDmcHUHKEMZo01MzB/erjnJJsouqLOCH/szHxOESNFkxDSpC+EoOa2SMcHii5cUbJMQNGDhWYURERjvHogG574d1lQqu3ZFfUE6sjzJa+pz0eCQsiBB39J5Wts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078536; c=relaxed/simple;
	bh=ioL0LDm1XQoj/TX8NVsrVDojnr+XylCWobnzuvr4c0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEdgRb1wtfasoKltuKQwIkO+WuT38Vo0A5tzkD2istmZeCNC21qD1JrAD+6d2td59TZ3G7XyU4fDS/87aSfVKjnZ8MWvqWOE4z32x7hOOg1pNAxQ8rMwEXYDDn2w+0ttRXndMQykzg5yayNCZMTYuLN0ULqGj94sFR99OEZAceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQdNGoKk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso7315892a12.3;
        Sun, 27 Oct 2024 18:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730078532; x=1730683332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6f/AWr5zkxqWz29d7KMm4yvU9ly5dS9dQi/PANUNoQ=;
        b=KQdNGoKk6AM7av7sE6SHkXamcQDPd1XwyfLCB9WOGwbFiozHk+afodLHnwnVwOpzDZ
         ZKwXeRy1D0DKrQaVuFXp0mJoIFgnRd7nApPvTIZrCncn8cHEp6KLEHQ7gqVJMfeKqp+S
         8YQi994s8+ro2sua4AgvQ6OKsWEBr29ICtBOcqway0agk/Ps05LYSCvUJxnfWpolWYM7
         A8vmaXY5keYzWCYeBbSAeV3TX+tb5gm9hLVLfbB2+RPO5omKviroh19VYuqMC0qV59mx
         S9Owuh2T8BcOA48GVyp5C8z0kn9ivqbbbkE4A4GYVFuouBfEXJHcEHnjt7wcjG8U7y8F
         bSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730078532; x=1730683332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6f/AWr5zkxqWz29d7KMm4yvU9ly5dS9dQi/PANUNoQ=;
        b=gMcneIlN8w/wrHtSRrEi4tLgCCTTcw6FoluocFIAb0IXf1EgZPDmyG23P1Y6PFdGaz
         VQFVvVph9l8xHEiKpyzfEFFg2A0CEamO7/QHe/hbBjPp/6ig5v2PXlb8F0DQucWQ0Aks
         w4H4527BVosb2MzrOgeJgmZ6Ep/jWukytR5uGJA/nRXLsFuwtyEbPSfCEwxxuMd5oH1D
         tKbpR2AkbGoP68+n1geUPLSO0xDioTE9wYISf2WNgbFWiLqjK3vSPLYgLu/FQ4Cl7BLN
         zrLKNMSkBjMQEh2tT1zOr5znRALDb8HVJ0VoBjBmrJ6fnqlLbz1fH/gg0Yf1nF/ZgwtM
         LTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfuvqhZiH6LMVTo9O3bCvokvSP+EEQfgnmwKSc2MrBsBng7qI6W0h7yUplOukPrKq7Pu/R6WDaTN0=@vger.kernel.org, AJvYcCWXs26H8GXkKddug5TJKsQ4hhOsjZ3/JoeFA0CHPyfGv5Iqkkp2+gFNnKPNM77x4/CKPxM5fHGIVk7bypyW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmci24NsTvcWfzWGTRq95iXfWTPFYy0Celjo13uAW+AoaxUTrf
	S/moY5A6PwngKSTb6OnZVFfUPcoj1EutdBsgrsGAMi6WAcAEdCEMtw8j+b4m46QWmLoUYS+8L4q
	Y7cEhrWGzQ4oNp0Z0xxLWZ8kTVYM=
X-Google-Smtp-Source: AGHT+IGHIspl0PUcPKyvAKfduJM0LgJ3OcZ24A+1rCnVANY0jKnUh36q4516dA33L2ENFJ94s6JdhUhSiEdZvRPlhYc=
X-Received: by 2002:a05:6402:2803:b0:5c9:6ae4:332e with SMTP id
 4fb4d7f45d1cf-5cbbf8b11ffmr5063792a12.8.1730078531832; Sun, 27 Oct 2024
 18:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027175743.1056710-1-mcanal@igalia.com> <20241027175743.1056710-4-mcanal@igalia.com>
 <CAGsJ_4xCw3OvkMo6cVr+U97C3SO+n+5c1j5XRodLDaLXW4ALjg@mail.gmail.com>
In-Reply-To: <CAGsJ_4xCw3OvkMo6cVr+U97C3SO+n+5c1j5XRodLDaLXW4ALjg@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 28 Oct 2024 09:21:35 +0800
Message-ID: <CAK1f24m9rfgWK-hXBD8nestq6BZ6eQpR6O=PZhAU3VnR54gz=A@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: shmem: override mTHP shmem default with a kernel parameter
To: Barry Song <21cnbao@gmail.com>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ma=C3=ADra,

On Mon, Oct 28, 2024 at 5:54=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Oct 28, 2024 at 6:58=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.c=
om> wrote:
> >
> > Add the ``thp_shmem=3D`` kernel command line to allow specifying the
> > default policy of each supported shmem hugepage size. The kernel parame=
ter
> > accepts the following format:
> >
> > thp_shmem=3D<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<p=
olicy>
> >
> > For example,
> >
> > thp_shmem=3D16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M=
-8M:within_size
> >
> > By configuring the default policy of several shmem huge pages, the user
> > can take advantage of mTHP before it's been configured through sysfs.
> >
> > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  10 ++
> >  Documentation/admin-guide/mm/transhuge.rst    |  17 +++
> >  mm/shmem.c                                    | 109 +++++++++++++++++-
> >  3 files changed, 135 insertions(+), 1 deletion(-)
> >
>
> Hi Ma=C3=ADra,
>
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index acabb04d0dd4..595fa096e28b 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6700,6 +6700,16 @@
> >                         Force threading of all interrupt handlers excep=
t those
> >                         marked explicitly IRQF_NO_THREAD.
> >
> > +       shmem_anon=3D     [KNL]
> > +                       Format: <size>[KMG],<size>[KMG]:<policy>;<size>=
[KMG]-<size>[KMG]:<policy>
> > +                       Control the default policy of each hugepage siz=
e for the
> > +                       internal shmem mount. <policy> is one of polici=
es available
> > +                       for the shmem mount ("always", "inherit", "neve=
r", "within_size",
> > +                       and "advise").
> > +                       It can be used multiple times for multiple shme=
m THP sizes.
> > +                       See Documentation/admin-guide/mm/transhuge.rst =
for more
> > +                       details.
>
> I'm not sure this is the right name. How about "thp_shmem"?

+1

IHMO, it seems like 'thp_shmem' would be better, as it appears to fit well
with 'thp_anon' in naming style ;)

Thanks,
Lance

>
> > +
> >         topology=3D       [S390,EARLY]
> >                         Format: {off | on}
> >                         Specify if the kernel should make use of the cp=
u
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 9b5b02c4d1ab..47e7fc30e22d 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -332,6 +332,23 @@ allocation policy for the internal shmem mount by =
using the kernel parameter
> >  seven valid policies for shmem (``always``, ``within_size``, ``advise`=
`,
> >  ``never``, ``deny``, and ``force``).
> >
> > +In the same manner as ``thp_anon`` controls each supported anonymous T=
HP
> > +size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shme=
m``
> > +has the same format as ``thp_anon``, but also supports the policy
> > +``within_size``.
> > +
> > +``thp_shmem=3D`` may be specified multiple times to configure all THP =
sizes
> > +as required. If ``thp_shmem=3D`` is specified at least once, any shmem=
 THP
> > +sizes not explicitly configured on the command line are implicitly set=
 to
> > +``never``.
> > +
> > +``transparent_hugepage_shmem`` setting only affects the global toggle.=
 If
> > +``thp_shmem`` is not specified, PMD_ORDER hugepage will default to
> > +``inherit``. However, if a valid ``thp_shmem`` setting is provided by =
the
> > +user, the PMD_ORDER hugepage policy will be overridden. If the policy =
for
> > +PMD_ORDER is not defined within a valid ``thp_shmem``, its policy will
> > +default to ``never``.
> > +
> >  Hugepages in tmpfs/shmem
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 24cdeafd8260..0a7a7d04f725 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always __rea=
d_mostly;
> >  static unsigned long huge_shmem_orders_madvise __read_mostly;
> >  static unsigned long huge_shmem_orders_inherit __read_mostly;
> >  static unsigned long huge_shmem_orders_within_size __read_mostly;
> > +static bool shmem_orders_configured __initdata;
> >  #endif
> >
> >  #ifdef CONFIG_TMPFS
> > @@ -5013,7 +5014,8 @@ void __init shmem_init(void)
> >          * Default to setting PMD-sized THP to inherit the global setti=
ng and
> >          * disable all other multi-size THPs.
> >          */
> > -       huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
> > +       if (!shmem_orders_configured)
> > +               huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
> >  #endif
> >         return;
> >
> > @@ -5174,6 +5176,26 @@ struct kobj_attribute thpsize_shmem_enabled_attr=
 =3D
> >
> >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
> >
> > +static inline int get_order_from_str(const char *size_str)
> > +{
> > +       unsigned long size;
> > +       char *endptr;
> > +       int order;
> > +
> > +       size =3D memparse(size_str, &endptr);
> > +
> > +       if (!is_power_of_2(size))
> > +               goto err;
> > +       order =3D get_order(size);
> > +       if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
> > +               goto err;
> > +
> > +       return order;
> > +err:
> > +       pr_err("invalid size %s in thp_shmem boot parameter\n", size_st=
r);
> > +       return -EINVAL;
> > +}
> > +
> >  static int __init setup_transparent_hugepage_shmem(char *str)
> >  {
> >         int huge, ret =3D 0;
> > @@ -5206,6 +5228,91 @@ static int __init setup_transparent_hugepage_shm=
em(char *str)
> >  }
> >  __setup("transparent_hugepage_shmem=3D", setup_transparent_hugepage_sh=
mem);
> >
> > +static char str_dup[PAGE_SIZE] __initdata;
> > +static int __init setup_thp_shmem(char *str)
> > +{
> > +       char *token, *range, *policy, *subtoken;
> > +       unsigned long always, inherit, madvise, within_size;
> > +       char *start_size, *end_size;
> > +       int start, end, nr;
> > +       char *p;
> > +
> > +       if (!str || strlen(str) + 1 > PAGE_SIZE)
> > +               goto err;
> > +       strcpy(str_dup, str);
> > +
> > +       always =3D huge_shmem_orders_always;
> > +       inherit =3D huge_shmem_orders_inherit;
> > +       madvise =3D huge_shmem_orders_madvise;
> > +       within_size =3D huge_shmem_orders_within_size;
> > +       p =3D str_dup;
> > +       while ((token =3D strsep(&p, ";")) !=3D NULL) {
> > +               range =3D strsep(&token, ":");
> > +               policy =3D token;
> > +
> > +               if (!policy)
> > +                       goto err;
> > +
> > +               while ((subtoken =3D strsep(&range, ",")) !=3D NULL) {
> > +                       if (strchr(subtoken, '-')) {
> > +                               start_size =3D strsep(&subtoken, "-");
> > +                               end_size =3D subtoken;
> > +
> > +                               start =3D get_order_from_str(start_size=
);
> > +                               end =3D get_order_from_str(end_size);
> > +                       } else {
> > +                               start =3D end =3D get_order_from_str(su=
btoken);
> > +                       }
> > +
> > +                       if (start < 0 || end < 0 || start > end)
> > +                               goto err;
> > +
> > +                       nr =3D end - start + 1;
> > +                       if (!strcmp(policy, "always")) {
> > +                               bitmap_set(&always, start, nr);
> > +                               bitmap_clear(&inherit, start, nr);
> > +                               bitmap_clear(&madvise, start, nr);
> > +                               bitmap_clear(&within_size, start, nr);
> > +                       } else if (!strcmp(policy, "advise")) {
> > +                               bitmap_set(&madvise, start, nr);
> > +                               bitmap_clear(&inherit, start, nr);
> > +                               bitmap_clear(&always, start, nr);
> > +                               bitmap_clear(&within_size, start, nr);
> > +                       } else if (!strcmp(policy, "inherit")) {
> > +                               bitmap_set(&inherit, start, nr);
> > +                               bitmap_clear(&madvise, start, nr);
> > +                               bitmap_clear(&always, start, nr);
> > +                               bitmap_clear(&within_size, start, nr);
> > +                       } else if (!strcmp(policy, "within_size")) {
> > +                               bitmap_set(&within_size, start, nr);
> > +                               bitmap_clear(&inherit, start, nr);
> > +                               bitmap_clear(&madvise, start, nr);
> > +                               bitmap_clear(&always, start, nr);
> > +                       } else if (!strcmp(policy, "never")) {
> > +                               bitmap_clear(&inherit, start, nr);
> > +                               bitmap_clear(&madvise, start, nr);
> > +                               bitmap_clear(&always, start, nr);
> > +                               bitmap_clear(&within_size, start, nr);
> > +                       } else {
> > +                               pr_err("invalid policy %s in thp_shmem =
boot parameter\n", policy);
> > +                               goto err;
> > +                       }
> > +               }
> > +       }
> > +
> > +       huge_shmem_orders_always =3D always;
> > +       huge_shmem_orders_madvise =3D madvise;
> > +       huge_shmem_orders_inherit =3D inherit;
> > +       huge_shmem_orders_within_size =3D within_size;
> > +       shmem_orders_configured =3D true;
> > +       return 1;
> > +
> > +err:
> > +       pr_warn("thp_shmem=3D%s: error parsing string, ignoring setting=
\n", str);
> > +       return 0;
> > +}
>
> Can we share source code with thp_anon since there's a lot of duplication=
?


>
> > +__setup("thp_shmem=3D", setup_thp_shmem);
> > +
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> >  #else /* !CONFIG_SHMEM */
> > --
> > 2.46.2
> >
>
> Thanks
> barry


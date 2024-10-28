Return-Path: <linux-kernel+bounces-385990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A19B3DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB601F22E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336F11F4297;
	Mon, 28 Oct 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOpSFolF"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576B1EE02A;
	Mon, 28 Oct 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154973; cv=none; b=WRgpoblBEC9V06r1vLgI4pJ2jjmIkhwlFV17zQ5k+lgI35td/S0dFpFK4Orh/Kpqm7cJnAFKNgn3I1w3sW40V+UkfXIEPqaB+IsTwm9pritX2JdAfAfcY26yCasErUEsKvJvCcSF9A7HJ+N9xQnWikeczY+W0gIyggIfB6WeJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154973; c=relaxed/simple;
	bh=wbhdZC6Z89reeMwCeY5MJEvFiZ3WcNwnaTzW5+GquY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9FavSYQqY1fIzY+OeFfxaow3vsqWROxE3CqPV2cORGxdWj/Q0bnZ1ZpLH1RtizO6tlfViwuGqX7lIS9AogWNyvPDsKoDo0K6cMubLUdTVRkTKePN7ufnB2eNWGL1Qe40i7ViQOLE/Vd95ChzOwUt9KNZ4pJ2ff7VzPYnqJV9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOpSFolF; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d494ac189so1373753e0c.3;
        Mon, 28 Oct 2024 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730154969; x=1730759769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruanekakymRz5BAdcZ4X/lBPdAj5pXrys4sR3ewuFz4=;
        b=BOpSFolFFg8G34Pkp8AUtKEhdhF9X8XkZcLLxPHGSBhvSylX0s58XR11TDwOSYs5/J
         95uJHvKvup4ltMO/71s+BR5pVNrcYmnNvEw5TieOYM62BIzrXLfZdIF4eFzw06OA+Hdx
         WTeDudW6XrwG0s8ozqwV2VBCC+QsTuNod2gcF+itcKQ4P+VevsnDoEsZqqmqBVqo0NIO
         xCFkUtc0VnUsc+BZEjk+hwl1DQ1JJjSJEXUxQVwlYtHknQMWggGfkoc5feLgKZjMD+Kd
         1Jas0UEErauD16HWqq9Z2KfpczjOGaD1YKyLJ/fMYkrTIrEKkVkaa5dEGIC8ohcoRAz8
         WvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730154969; x=1730759769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruanekakymRz5BAdcZ4X/lBPdAj5pXrys4sR3ewuFz4=;
        b=n2W6KHa9OcABeo8O/MFlc0Xdx91FDnj8Bc9MB3i9KopFXRHPtNYbO6NRNsxALBp5fO
         m1MsJHzVnFOnHod+vf243eq4VQeVWN19EWjwbMGgHlk+D9crbbsS7EL6TQw+UxbO0qaZ
         7rWjOVcN4rsUGMNU5ulNk/pIwNk8G+x72kalHJyOEMyY5hYZFt7KnObJkYjwpH2Xn77x
         3VqrWfbE8CrxI87B+PTGqM03WmI6qxaUyYu5zBC9aBZ3YcLXqZnTL5Z5zEqzah9iwg+P
         +Nu+VRN8DbLM0LIzt6bhyuo1DtAoGCfohMW+rDnWzQoCgkePddp1OPE84HuouipmC5l5
         9Ypg==
X-Forwarded-Encrypted: i=1; AJvYcCUAc7mAQCgOjjjkflc1PXZKGIByJc0Uw5OR3Rf583p6M8rW4KvacBXgwRNy0PCWA/IBYEf2sfgs1Kg=@vger.kernel.org, AJvYcCV7nmweSZ2k3O/GSpuT9CzeA8geP3K++dad4I+M8oyKsVd4OzNDiEdi/f6iesPkeIAq/vOKwEkAkwF+uGhW@vger.kernel.org
X-Gm-Message-State: AOJu0YyxP0nEyibRugTbGGsJDDrnse5D2FzlWO8uc+jadLkgzTQB3/02
	dMPHC3q6TJgpbIdfqRn5QAs9+a2QhXsKUbamCv7JXH+XIdKQZwLIFdpm8OIHoEjaSvDYzSFbzDj
	J/cWagvvz9dD93A0vv6DH6vR15RM=
X-Google-Smtp-Source: AGHT+IFwD/SdrQv0Dd5YYxYWS6K93sh3LWdxo8AeuPPutZ/ZdZN4h84VpKl95axI38SS8MoNcn2ehxkCY6a+bgThV0g=
X-Received: by 2002:a05:6122:889:b0:50d:535b:a18a with SMTP id
 71dfb90a1353d-510150459a6mr6315726e0c.6.1730154969575; Mon, 28 Oct 2024
 15:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027175743.1056710-1-mcanal@igalia.com> <20241027175743.1056710-4-mcanal@igalia.com>
 <CAGsJ_4xCw3OvkMo6cVr+U97C3SO+n+5c1j5XRodLDaLXW4ALjg@mail.gmail.com>
 <2505d52c-3454-4892-8c90-e3d9b2f0c84f@igalia.com> <CAGsJ_4y13T+KE1hJPb=14LBvGixd4uQTcN5pS=Hok6Ca6RD+7g@mail.gmail.com>
 <f1c35067-9381-424b-b962-526b85d59ea9@igalia.com>
In-Reply-To: <f1c35067-9381-424b-b962-526b85d59ea9@igalia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 06:35:57 +0800
Message-ID: <CAGsJ_4wJ2xoNRLMNkmLL3x1t2YiqQJ1=saXa+HNxRUbSNivRCw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: shmem: override mTHP shmem default with a kernel parameter
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 7:34=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Hi Barry,
>
> On 28/10/24 08:09, Barry Song wrote:
> > On Mon, Oct 28, 2024 at 6:10=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia=
.com> wrote:
> >>
> >> Hi Barry,
> >>
> >> On 27/10/24 18:54, Barry Song wrote:
> >>> On Mon, Oct 28, 2024 at 6:58=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igal=
ia.com> wrote:
> >>>>
> >>>> Add the ``thp_shmem=3D`` kernel command line to allow specifying the
> >>>> default policy of each supported shmem hugepage size. The kernel par=
ameter
> >>>> accepts the following format:
> >>>>
> >>>> thp_shmem=3D<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]=
:<policy>
> >>>>
> >>>> For example,
> >>>>
> >>>> thp_shmem=3D16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never=
;4M-8M:within_size
> >>>>
> >>>> By configuring the default policy of several shmem huge pages, the u=
ser
> >>>> can take advantage of mTHP before it's been configured through sysfs=
.
> >>>>
> >>>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >>>> ---
> >>>>    .../admin-guide/kernel-parameters.txt         |  10 ++
> >>>>    Documentation/admin-guide/mm/transhuge.rst    |  17 +++
> >>>>    mm/shmem.c                                    | 109 +++++++++++++=
++++-
> >>>>    3 files changed, 135 insertions(+), 1 deletion(-)
> >>>>
> >>>
> >>> Hi Ma=C3=ADra,
> >>>
> >>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docum=
entation/admin-guide/kernel-parameters.txt
> >>>> index acabb04d0dd4..595fa096e28b 100644
> >>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>> @@ -6700,6 +6700,16 @@
> >>>>                           Force threading of all interrupt handlers =
except those
> >>>>                           marked explicitly IRQF_NO_THREAD.
> >>>>
> >>>> +       shmem_anon=3D     [KNL]
> >>>> +                       Format: <size>[KMG],<size>[KMG]:<policy>;<si=
ze>[KMG]-<size>[KMG]:<policy>
> >>>> +                       Control the default policy of each hugepage =
size for the
> >>>> +                       internal shmem mount. <policy> is one of pol=
icies available
> >>>> +                       for the shmem mount ("always", "inherit", "n=
ever", "within_size",
> >>>> +                       and "advise").
> >>>> +                       It can be used multiple times for multiple s=
hmem THP sizes.
> >>>> +                       See Documentation/admin-guide/mm/transhuge.r=
st for more
> >>>> +                       details.
> >>>
> >>> I'm not sure this is the right name. How about "thp_shmem"?
> >>
> >> Oops, sorry about that.
> >>
> >>>
> >>>> +
> >>>>           topology=3D       [S390,EARLY]
> >>>>                           Format: {off | on}
> >>>>                           Specify if the kernel should make use of t=
he cpu
> >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentat=
ion/admin-guide/mm/transhuge.rst
> >>>> index 9b5b02c4d1ab..47e7fc30e22d 100644
> >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>> @@ -332,6 +332,23 @@ allocation policy for the internal shmem mount =
by using the kernel parameter
> >>>>    seven valid policies for shmem (``always``, ``within_size``, ``ad=
vise``,
> >>>>    ``never``, ``deny``, and ``force``).
> >>>>
> >>>> +In the same manner as ``thp_anon`` controls each supported anonymou=
s THP
> >>>> +size, ``thp_shmem`` controls each supported shmem THP size. ``thp_s=
hmem``
> >>>> +has the same format as ``thp_anon``, but also supports the policy
> >>>> +``within_size``.
> >>>> +
> >>>> +``thp_shmem=3D`` may be specified multiple times to configure all T=
HP sizes
> >>>> +as required. If ``thp_shmem=3D`` is specified at least once, any sh=
mem THP
> >>>> +sizes not explicitly configured on the command line are implicitly =
set to
> >>>> +``never``.
> >>>> +
> >>>> +``transparent_hugepage_shmem`` setting only affects the global togg=
le. If
> >>>> +``thp_shmem`` is not specified, PMD_ORDER hugepage will default to
> >>>> +``inherit``. However, if a valid ``thp_shmem`` setting is provided =
by the
> >>>> +user, the PMD_ORDER hugepage policy will be overridden. If the poli=
cy for
> >>>> +PMD_ORDER is not defined within a valid ``thp_shmem``, its policy w=
ill
> >>>> +default to ``never``.
> >>>> +
> >>>>    Hugepages in tmpfs/shmem
> >>>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>>>
> >>>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>>> index 24cdeafd8260..0a7a7d04f725 100644
> >>>> --- a/mm/shmem.c
> >>>> +++ b/mm/shmem.c
>
> [...]
>
> >>>>    static int __init setup_transparent_hugepage_shmem(char *str)
> >>>>    {
> >>>>           int huge, ret =3D 0;
> >>>> @@ -5206,6 +5228,91 @@ static int __init setup_transparent_hugepage_=
shmem(char *str)
> >>>>    }
> >>>>    __setup("transparent_hugepage_shmem=3D", setup_transparent_hugepa=
ge_shmem);
> >>>>
> >>>> +static char str_dup[PAGE_SIZE] __initdata;
> >>>> +static int __init setup_thp_shmem(char *str)
> >>>> +{
> >>>> +       char *token, *range, *policy, *subtoken;
> >>>> +       unsigned long always, inherit, madvise, within_size;
> >>>> +       char *start_size, *end_size;
> >>>> +       int start, end, nr;
> >>>> +       char *p;
> >>>> +
> >>>> +       if (!str || strlen(str) + 1 > PAGE_SIZE)
> >>>> +               goto err;
> >>>> +       strcpy(str_dup, str);
> >>>> +
> >>>> +       always =3D huge_shmem_orders_always;
> >>>> +       inherit =3D huge_shmem_orders_inherit;
> >>>> +       madvise =3D huge_shmem_orders_madvise;
> >>>> +       within_size =3D huge_shmem_orders_within_size;
> >>>> +       p =3D str_dup;
> >>>> +       while ((token =3D strsep(&p, ";")) !=3D NULL) {
> >>>> +               range =3D strsep(&token, ":");
> >>>> +               policy =3D token;
> >>>> +
> >>>> +               if (!policy)
> >>>> +                       goto err;
> >>>> +
> >>>> +               while ((subtoken =3D strsep(&range, ",")) !=3D NULL)=
 {
> >>>> +                       if (strchr(subtoken, '-')) {
> >>>> +                               start_size =3D strsep(&subtoken, "-"=
);
> >>>> +                               end_size =3D subtoken;
> >>>> +
> >>>> +                               start =3D get_order_from_str(start_s=
ize);
> >>>> +                               end =3D get_order_from_str(end_size)=
;
> >>>> +                       } else {
> >>>> +                               start =3D end =3D get_order_from_str=
(subtoken);
> >>>> +                       }
> >>>> +
> >>>> +                       if (start < 0 || end < 0 || start > end)
> >>>> +                               goto err;
> >>>> +
> >>>> +                       nr =3D end - start + 1;
> >>>> +                       if (!strcmp(policy, "always")) {
> >>>> +                               bitmap_set(&always, start, nr);
> >>>> +                               bitmap_clear(&inherit, start, nr);
> >>>> +                               bitmap_clear(&madvise, start, nr);
> >>>> +                               bitmap_clear(&within_size, start, nr=
);
> >>>> +                       } else if (!strcmp(policy, "advise")) {
> >>>> +                               bitmap_set(&madvise, start, nr);
> >>>> +                               bitmap_clear(&inherit, start, nr);
> >>>> +                               bitmap_clear(&always, start, nr);
> >>>> +                               bitmap_clear(&within_size, start, nr=
);
> >>>> +                       } else if (!strcmp(policy, "inherit")) {
> >>>> +                               bitmap_set(&inherit, start, nr);
> >>>> +                               bitmap_clear(&madvise, start, nr);
> >>>> +                               bitmap_clear(&always, start, nr);
> >>>> +                               bitmap_clear(&within_size, start, nr=
);
> >>>> +                       } else if (!strcmp(policy, "within_size")) {
> >>>> +                               bitmap_set(&within_size, start, nr);
> >>>> +                               bitmap_clear(&inherit, start, nr);
> >>>> +                               bitmap_clear(&madvise, start, nr);
> >>>> +                               bitmap_clear(&always, start, nr);
> >>>> +                       } else if (!strcmp(policy, "never")) {
> >>>> +                               bitmap_clear(&inherit, start, nr);
> >>>> +                               bitmap_clear(&madvise, start, nr);
> >>>> +                               bitmap_clear(&always, start, nr);
> >>>> +                               bitmap_clear(&within_size, start, nr=
);
> >>>> +                       } else {
> >>>> +                               pr_err("invalid policy %s in thp_shm=
em boot parameter\n", policy);
> >>>> +                               goto err;
> >>>> +                       }
> >>>> +               }
> >>>> +       }
> >>>> +
> >>>> +       huge_shmem_orders_always =3D always;
> >>>> +       huge_shmem_orders_madvise =3D madvise;
> >>>> +       huge_shmem_orders_inherit =3D inherit;
> >>>> +       huge_shmem_orders_within_size =3D within_size;
> >>>> +       shmem_orders_configured =3D true;
> >>>> +       return 1;
> >>>> +
> >>>> +err:
> >>>> +       pr_warn("thp_shmem=3D%s: error parsing string, ignoring sett=
ing\n", str);
> >>>> +       return 0;
> >>>> +}
> >>>
> >>> Can we share source code with thp_anon since there's a lot of duplica=
tion?
> >>
> >> I'm not a regular mm contributor and I'm most usually around drivers, =
so
> >> I don't know exactly here I could add shared code. Should I add the
> >> headers to "internal.h"?
> >
> > My comment isn't related to drivers or memory management. It's solely a=
bout
> > avoiding code duplication. For example, we could create a shared functi=
on to
> > handle both controls, reducing redundant code :-)
>
> Let me rephrase it.
>
> I completely agree that we should avoid code duplication. I'm asking
> where is the best place to add the headers of the shared functions.
> "linux/shmem_fs.h" doesn't look appropriate to me, so I believe the
> remaining options would be "linux/huge_mm.h" or "internal.h".

Both locations seem quite odd. I have a feeling that these boot command
elements are purely internal, yet internal.h contains something that is
actually 'external' to mm. The shared code isn't 'external' enough to belon=
g
in internal.h.

I didn't realize that shmem has placed these controls in its own file;
I thought they
were also located in mm/huge_memory.c. Given the current situation, I would
prefer to keep the code as it is and tolerate the code duplication.

Unless we are going to place controls for shmem and other thp controls in
one place, I feel your code is better than having a shared function either =
in
internal.h or linux/huge_mm.h.

>
> I would like to know your opinion about those two options.
>
> Best Regards,
> - Ma=C3=ADra
>
> >
> >>
> >> Best Regards,
> >> - Ma=C3=ADra
> >>
> >>>
> >>>> +__setup("thp_shmem=3D", setup_thp_shmem);
> >>>> +
> >>>>    #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >>>>
> >>>>    #else /* !CONFIG_SHMEM */
> >>>> --
> >>>> 2.46.2
> >>>>
> >>>

Thanks
barry


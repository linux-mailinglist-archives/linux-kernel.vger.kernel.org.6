Return-Path: <linux-kernel+bounces-256871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2AC93719E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D868B215C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A3F1C32;
	Fri, 19 Jul 2024 00:46:48 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0F0184D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350007; cv=none; b=iso2qmvbi5qADrDiEh1pm+8COsCY4pSpEAtkMNQsqDaTDD5dpIqxJLTnD64hDmIZ6eloEMNgFt/rK+1Vqveys+IOVPLIyhkECD92PcG+iWFXbvZGqmeamTnNZI6ecifFkRE1Zc7Y+UpyCYqqfC5bnUw01GMHB+ZVxX8EFrVBcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350007; c=relaxed/simple;
	bh=9SUohBpJUeqg24Mdd8wtr2AafpRDkgxuJjdcNwzUNEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWB+A8U4nJblXk48z+BKD2WHHu+/FGN+AHn0QWGNrmYvUKjFKVwqXZJkUtKFmKeD3l8vPTCF+ei1jdOSlDPuqUDmV/U2zmHRbn7XdVRRNxGUzmYAcMCQ5nbH4ASNNvI6qMy94+BHhQXdWRdjZyjyaTK4miztK9J9GjiWGXGk324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so369318241.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350005; x=1721954805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXQ+IO8iuumbpDwvRCDXC4/iQuI0xJQGtKu8Dv5HDVs=;
        b=sA8ViQQOspRXQuSDveJ4XZDYuRrSwQfhiGNBXYZk/WjE068VuOYEk64RH6UE+w5n0i
         FkBKFNgf8VZX/3h9HrIuiD1s0srnoPtnHKzXenmQfWxAr6LzVquqFgbo42axePZ41sP1
         oVu9yS9ro5tU0S63yvIkn4wbHIyPE9p4F5ObSvBdT5wdMehWQFAyOTsWZPxIKpM++YuV
         IQE5Wrc/p0lBHbbk99/TbUF2ioihsXwPHq2DOGcMPLAP/4xZrE+u3eGY8C+PeOsuAOEn
         /zxwi8imhul9Gmre85ieFuB4gypLXkJwOfT2KxR4q1qlfbAsrgQ17udZLouTly284B7R
         s8ow==
X-Forwarded-Encrypted: i=1; AJvYcCUCvcFreHkRn6D8a8peJXyM+f1lYy2byF2ytp07Vh/g+e4RD0wBXkwRMDGvXfXhdsz99hDmw9Y3JK8A8qzkVFiQewC94K5Xu0w5b26t
X-Gm-Message-State: AOJu0Yy6Up0cdpywwnB0b6Vgm7ohLH+5LZIpr3A1HM5lpn5qo/qDSp4A
	UTYEZlg8+jkTH2NaiE858y/GC4/3w6g+4awpI/RnlaRCA29oAblcqVqfdzyEBCTUKcyGotdPAGr
	NXVmamChjwKGJ2tUvgZ3h0Q3vjtA=
X-Google-Smtp-Source: AGHT+IFT7TFRyWG+4EjCRpKUw7n6DPN0+TItRo/kZEQUnluoetN3fJUk0pXIeT7pPSnPEG51sD9+mp57BP2qUJ66a0g=
X-Received: by 2002:a67:e709:0:b0:48f:3e67:78d2 with SMTP id
 ada2fe7eead31-49159901cd2mr8312047137.26.1721350004799; Thu, 18 Jul 2024
 17:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717071257.4141363-1-ryan.roberts@arm.com> <20240717071257.4141363-4-ryan.roberts@arm.com>
In-Reply-To: <20240717071257.4141363-4-ryan.roberts@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 19 Jul 2024 12:46:33 +1200
Message-ID: <CAGsJ_4wiZRP9siEk9WpAYRjj-gehxptGY9XWC8k3N4QHBppAhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/4] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>, 
	Pankaj Raghav <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 7:13=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Add thp_anon=3D cmdline parameter to allow specifying the default
> enablement of each supported anon THP size. The parameter accepts the
> following format and can be provided multiple times to configure each
> size:
>
> thp_anon=3D<size>[KMG]:<value>
>
> See Documentation/admin-guide/mm/transhuge.rst for more details.
>
> Configuring the defaults at boot time is useful to allow early user
> space to take advantage of mTHP before its been configured through
> sysfs.

This is exactly what I need and want to implement, as the current behavior
is problematic. We need to boot up the system and reach the point where
we can set up the sys interfaces to enable mTHP. Many processes miss the
opportunity to use mTHP.

On the other hand, userspace might have been tuned to detect that mTHP
is enabled, such as a .so library. However, it turns out we have had
inconsistent settings between the two stages - before and after setting
mTHP enabled by sys interfaces.

>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 +++
>  Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
>  mm/huge_memory.c                              | 55 ++++++++++++++++++-
>  3 files changed, 82 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index bc55fb55cd26..48443ad12e3f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6592,6 +6592,14 @@
>                         <deci-seconds>: poll all this frequency
>                         0: no polling (default)
>
> +       thp_anon=3D       [KNL]
> +                       Format: <size>[KMG]:always|madvise|never|inherit
> +                       Can be used to control the default behavior of th=
e
> +                       system with respect to anonymous transparent huge=
pages.
> +                       Can be used multiple times for multiple anon THP =
sizes.
> +                       See Documentation/admin-guide/mm/transhuge.rst fo=
r more
> +                       details.
> +
>         threadirqs      [KNL,EARLY]
>                         Force threading of all interrupt handlers except =
those
>                         marked explicitly IRQF_NO_THREAD.
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 1aaf8e3a0b5a..f53d43d986e2 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -311,13 +311,27 @@ performance.
>  Note that any changes to the allowed set of sizes only applies to future
>  file-backed THP allocations.
>
> -Boot parameter
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Boot parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -You can change the sysfs boot time defaults of Transparent Hugepage
> -Support by passing the parameter ``transparent_hugepage=3Dalways`` or
> -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever``
> -to the kernel command line.
> +You can change the sysfs boot time default for the top-level "enabled"
> +control by passing the parameter ``transparent_hugepage=3Dalways`` or
> +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever`` t=
o the
> +kernel command line.
> +
> +Alternatively, each supported anonymous THP size can be controlled by
> +passing ``thp_anon=3D<size>[KMG]:<state>``, where ``<size>`` is the THP =
size
> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
> +``inherit``.
> +
> +For example, the following will set 64K THP to ``always``::
> +
> +       thp_anon=3D64K:always
> +
> +``thp_anon=3D`` may be specified multiple times to configure all THP siz=
es as
> +required. If ``thp_anon=3D`` is specified at least once, any anon THP si=
zes
> +not explicitly configured on the command line are implicitly set to
> +``never``.
>
>  Hugepages in tmpfs/shmem
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4249c0bc9388..794d2790d90d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -82,6 +82,7 @@ unsigned long huge_anon_orders_madvise __read_mostly;
>  unsigned long huge_anon_orders_inherit __read_mostly;
>  unsigned long huge_file_orders_always __read_mostly;
>  int huge_file_exec_order __read_mostly =3D -1;
> +static bool anon_orders_configured;
>
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>                                          unsigned long vm_flags,
> @@ -763,7 +764,10 @@ static int __init hugepage_init_sysfs(struct kobject=
 **hugepage_kobj)
>          * disable all other sizes. powerpc's PMD_ORDER isn't a compile-t=
ime
>          * constant so we have to do this here.
>          */
> -       huge_anon_orders_inherit =3D BIT(PMD_ORDER);
> +       if (!anon_orders_configured) {
> +               huge_anon_orders_inherit =3D BIT(PMD_ORDER);
> +               anon_orders_configured =3D true;
> +       }
>
>         /*
>          * For pagecache, default to enabling all orders. powerpc's PMD_O=
RDER
> @@ -955,6 +959,55 @@ static int __init setup_transparent_hugepage(char *s=
tr)
>  }
>  __setup("transparent_hugepage=3D", setup_transparent_hugepage);
>
> +static int __init setup_thp_anon(char *str)
> +{
> +       unsigned long size;
> +       char *state;
> +       int order;
> +       int ret =3D 0;
> +
> +       if (!str)
> +               goto out;
> +
> +       size =3D (unsigned long)memparse(str, &state);
> +       order =3D ilog2(size >> PAGE_SHIFT);
> +       if (*state !=3D ':' || !is_power_of_2(size) || size <=3D PAGE_SIZ=
E ||
> +           !(BIT(order) & THP_ORDERS_ALL_ANON))
> +               goto out;
> +
> +       state++;
> +
> +       if (!strcmp(state, "always")) {
> +               clear_bit(order, &huge_anon_orders_inherit);
> +               clear_bit(order, &huge_anon_orders_madvise);
> +               set_bit(order, &huge_anon_orders_always);
> +               ret =3D 1;
> +       } else if (!strcmp(state, "inherit")) {
> +               clear_bit(order, &huge_anon_orders_always);
> +               clear_bit(order, &huge_anon_orders_madvise);
> +               set_bit(order, &huge_anon_orders_inherit);
> +               ret =3D 1;
> +       } else if (!strcmp(state, "madvise")) {
> +               clear_bit(order, &huge_anon_orders_always);
> +               clear_bit(order, &huge_anon_orders_inherit);
> +               set_bit(order, &huge_anon_orders_madvise);
> +               ret =3D 1;
> +       } else if (!strcmp(state, "never")) {
> +               clear_bit(order, &huge_anon_orders_always);
> +               clear_bit(order, &huge_anon_orders_inherit);
> +               clear_bit(order, &huge_anon_orders_madvise);
> +               ret =3D 1;
> +       }
> +
> +       if (ret)
> +               anon_orders_configured =3D true;
> +out:
> +       if (!ret)
> +               pr_warn("thp_anon=3D%s: cannot parse, ignored\n", str);
> +       return ret;
> +}
> +__setup("thp_anon=3D", setup_thp_anon);
> +
>  pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>  {
>         if (likely(vma->vm_flags & VM_WRITE))
> --
> 2.43.0
>

Thanks
Barry


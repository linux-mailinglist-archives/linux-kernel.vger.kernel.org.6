Return-Path: <linux-kernel+bounces-280138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323CE94C639
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE81C22014
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1AC15A4B5;
	Thu,  8 Aug 2024 21:17:44 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE37E1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151864; cv=none; b=ZMtQnaqA+WVQNGVDEHI0VZUG+T5Pmaik1kLaG0sQRF/8QqNrq/exL/BGsdIOrDygyRPuDT69fmiETWFeBpgXtJHDUmMnXI4YNaV4ZLPqGX+zY+EzDuo6DSQkmVidD+iedqQAO8ujRXIs5Xv+T8IQzbRKVrp0aw26SluqsabDsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151864; c=relaxed/simple;
	bh=3Ac6dOz8+/j9p2Pbl5zL0BNQnIizd0Ht/Iu6abdSrtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MceSca+aOAN2yctflpVKEIPuw9ihs5ci9q2XA7RGLWFFx4TT/KHCePcOgb173kNrLeWubLSNqECvE25jNHrj02tFvRK4tYq10Wo0+ZlrFuU77mKYFckMcp5fhEiUN7e9PK54tAAbpbwie5I+K34nhnbA+LpsggQP+Nb3CjzEwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4929754aee9so404202137.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723151861; x=1723756661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3i88Dul16VavwkAKUPCrLIM9o/ypPMslqMvVr6K5nQ=;
        b=pBUbCGfYCtf7eCl/BStqOMAwgbHNr5aFPDWQogbcSaG+GRCcaoNe+2S5+aiRfZNQ48
         JTNbKuhiJmxSWHKAGFWTO3dEefDgB6iWso7ZxBwNPMIeW9a2yuqht3Cf75FiZtmyR90E
         3uVQ0Yu4FfYC79ekg68lUdzQY6F2w9N2QaLVlaOZq99kXQRJ8YvLdbRnLLV7XIr1u0cQ
         U/ActbxpiysshZn5JO5RqJ4yvcXKH+h64k4wWFj8TVjsVnBrn3FKg2DtubTTQ9hVn09/
         X3eO1F+/An0++pCJBZ8vFQlM2q8HKKV6sduZS0n7ZVeEVBdu7ALgl1ROsChyXphxIZaK
         UeVg==
X-Forwarded-Encrypted: i=1; AJvYcCUZipUaKn6Df0w3qKJCzkaszGtlEv/v78JXN0s10eHMOe1JX96AGWlzsJir3J76LzCFj0ZADKyTxbl6xZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoWGjhdnA4qyzsTxAfiwDEkhX9XLdINowRLVguSAZ6mVUPT5y0
	T8xDui5OFM4NG08973S+82UiAnyUi7xo2fetjEEGF5rlJqjNVaagHTbe1TcDarodylq3Vlgu/SO
	hLqN62ZS094xdPx9mR2Vc5xkI3+/M6Eie
X-Google-Smtp-Source: AGHT+IFeA9viFZH66P67fXjg1b2CwuDP+UUx1CC9d00hMo51pKQX9mXZwWO+JAYjn0dEoKPCnUvOzTX0lyzKIlXnSTM=
X-Received: by 2002:a05:6102:b15:b0:495:6b7f:1ec4 with SMTP id
 ada2fe7eead31-495c5affa46mr3734103137.7.1723151860993; Thu, 08 Aug 2024
 14:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808101700.571701-1-ryan.roberts@arm.com>
In-Reply-To: <20240808101700.571701-1-ryan.roberts@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 9 Aug 2024 09:17:30 +1200
Message-ID: <CAGsJ_4zPCFhngM0R5X6zGSw6KHPYqT8b7izQZt2xoFPSxCpRng@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 10:17=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
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
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> Hi All,
>
> I've split this off from my RFC at [1] because Barry highlighted that he =
would
> benefit from it immediately [2]. There are no changes vs the version in t=
hat
> series.
>
> It applies against today's mm-unstable (275d686abcb59). (although I had t=
o fix a
> minor build bug in stackdepot.c due to MIN() not being defined in this tr=
ee).
>
> Thanks,
> Ryan
>
>
>  .../admin-guide/kernel-parameters.txt         |  8 +++
>  Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
>  mm/huge_memory.c                              | 55 ++++++++++++++++++-
>  3 files changed, 82 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index bcdee8984e1f0..5c79b58c108ec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6631,6 +6631,14 @@
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
> index 24eec1c03ad88..f63b0717366c6 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would bloc=
k the collapse::
>
>  A higher value may increase memory footprint for some workloads.
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
> index 0c3075ee00012..c2c0da1eb94e6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -82,6 +82,7 @@ unsigned long huge_zero_pfn __read_mostly =3D ~0UL;
>  unsigned long huge_anon_orders_always __read_mostly;
>  unsigned long huge_anon_orders_madvise __read_mostly;
>  unsigned long huge_anon_orders_inherit __read_mostly;
> +static bool anon_orders_configured;
>
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>                                          unsigned long vm_flags,
> @@ -672,7 +673,10 @@ static int __init hugepage_init_sysfs(struct kobject=
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

If a user configures 64KB and doesn't adjust anything for PMD_ORDER,
then PMD_ORDER will  be set to "never", correct? This seems to change
the default behavior of PMD_ORDER. Could we instead achieve this by
checking if PMD_ORDER has been explicitly configured?

>
>         *hugepage_kobj =3D kobject_create_and_add("transparent_hugepage",=
 mm_kobj);
>         if (unlikely(!*hugepage_kobj)) {
> @@ -857,6 +861,55 @@ static int __init setup_transparent_hugepage(char *s=
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

I mean:

if (ret && order =3D=3D PMD_ORDER)
            anon_pmd_order_configured =3D true;

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


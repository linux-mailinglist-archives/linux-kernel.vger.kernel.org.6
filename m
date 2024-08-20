Return-Path: <linux-kernel+bounces-293504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0361695809D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DA81F23527
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D169189F47;
	Tue, 20 Aug 2024 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkP5ZkuS"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755C189B99
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141498; cv=none; b=pBAAuck7oNx9c8oy5Tt8WOCA97kB9yFQnOLcwczFR2VS0n9ZHp/+kMbXAKSBAAj/45yqnvs1lfBLuZzto5UoOPCr9P6pEjrn4RzbXLub8abSpySGIhDEMeIIyKQPOVY6GBDgPJbXFnWJGoXQ939Dz37mVerQG973IVsVTXioGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141498; c=relaxed/simple;
	bh=LXM3VU0eX7tYl2evdtoSREKJcClPSx5bBgir8DcPjO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljXqe7peExuSWgaaHfi0kQXNkkuNBoqZHR38r+dmmKXuz3TWPRGhNtdZIan1KfKF2903b4aQ6K1nEV/Jz5UZSkeVky0CYgFpMSsiVXMan+SkC6yX+c3OthCi24B5Ze1McNnbmIvIx00hGCKm1AsuFJqnpBEGvrGID6FJtEUQsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkP5ZkuS; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8430670f247so1275289241.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724141495; x=1724746295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d798u9gz+fV/mIDRL/mYw7YhZt+WDnqYTUXk6WZw9ZY=;
        b=RkP5ZkuSq53MLF2ET2iDW9UPgENju/W/ab827m9Czu6hKzsRkigDQwZeIbz/jqHnMR
         malD1E8DYHfXO/9PPi59LXwP1jACOsi6WQngQRNGlmi4PGqr3VhVNPImYdURVv6szzbD
         GYk2DwIggISOgghjZWxJt8PMH6UsPeQl0WBcEth+00/xhPwGWf2cDW2U20x15rcXenaT
         yf899LYQ7k1sTRU9tNN8VPLWo9pa21piK9/YmbewHft2EIqoM31zvI0SQLt+OS43FYK/
         nY1gaFnZsjhDv2RmEbLhTcQH9ZLtlxwdmDlZoLYHfxT4kZybinImjbpFfHshJp0vvkbE
         +OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141495; x=1724746295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d798u9gz+fV/mIDRL/mYw7YhZt+WDnqYTUXk6WZw9ZY=;
        b=ndevLvN9hgJgR92AMwlp7cFyyUprFY993pOxKAlkanTS/vmMzKKr8A3xDHIS5m6n12
         MvlF7l6GLCygvHxUwdEjnLvAYm4WY54zhqaGwRa5rpbjwU5yF7K/gN8TGUlcSkcz8B3b
         imABf07OlRFp9jBQgQKtMUaStEkL0dMk6reDMirNSazuqTnQkZSy6no1kRLB0dWDvy35
         f0l1IjE5BEg+jIRGa2YYw9sxLqJ/puplCYMc6GkCZU5kh96MpSepsZeN9XKXPGVSY5/q
         SeLHRpFCI2taU1LsnhJG/y1urhnZ7yYai9pJGJ57eqg8Yh7kQe4cDsf5NihR9K7Xvo2r
         bKRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAsp1+nj83c1rX6k8Uz2nuVG3EHPQ+JMl8KpBz6hjF3lUihM4G38U15eyY3ObQf4DDQdhWWUN5OsBy9Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6h4UBEhEdC9VXRBhOYtr1rzkT+SJCnQb2iPIcLxTaTaAOTM1u
	zevRodEHnL9193P96zZkD5QgIvEfdnix/bVci8WYtgxYj3ap/veew8mxh624oLZg/qRgOGFm7nc
	TcT0YotohWQgjLSOifrI8smLzEOU=
X-Google-Smtp-Source: AGHT+IE6c4lVuITUWP2AnCS+3U+vimCfcb/vR/r7OmZl1XoOvvfYaZSnjW4MG7xjOGG/qEfZPhP4klY5s9xwAhVNuT8=
X-Received: by 2002:a05:6122:d99:b0:4f5:27ac:ce85 with SMTP id
 71dfb90a1353d-4fc6c71d87fmr16089723e0c.3.1724141494985; Tue, 20 Aug 2024
 01:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817045516.58037-1-21cnbao@gmail.com> <e36e4157-ba42-432f-aebe-7c2c36917e57@redhat.com>
In-Reply-To: <e36e4157-ba42-432f-aebe-7c2c36917e57@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 20:11:23 +1200
Message-ID: <CAGsJ_4xC+ixRB0n8yOQeQz_YndmtGcDcjjv8bLwcgmkj2XW+1w@mail.gmail.com>
Subject: Re: [PATCH v5] mm: override mTHP "enabled" defaults at kernel cmdline
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, corbet@lwn.net, ioworker0@gmail.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 7:53=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 17.08.24 06:55, Barry Song wrote:
> > From: Ryan Roberts <ryan.roberts@arm.com>
> >
> > Add thp_anon=3D cmdline parameter to allow specifying the default enabl=
ement
> > of each supported anon THP size.  The parameter accepts the following
> > format and can be provided multiple times to configure each size:
> >
> > thp_anon=3D<size>,<size>[KMG]:<value>;<size>-<size>[KMG]:<value>
> >
> > An example:
> >
> > thp_anon=3D16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
> >
> > See Documentation/admin-guide/mm/transhuge.rst for more details.
> >
> > Configuring the defaults at boot time is useful to allow early user
> > space to take advantage of mTHP before its been configured through
> > sysfs.
> >
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Lance Yang <ioworker0@gmail.com>
>
>
> Acked-by: David Hildenbrand <david@redhat.com>
>

thanks!

> Some nits:
>
> > ---
> >   -v5:
> >   * collect Baolin's reviewed-by and tested-by tags, thanks!
> >   * use get_order and check size is power 2, David, Baolin;
> >   * use proper __initdata
> >
> > .../admin-guide/kernel-parameters.txt         |   9 ++
> >   Documentation/admin-guide/mm/transhuge.rst    |  38 +++++--
> >   mm/huge_memory.c                              | 100 +++++++++++++++++=
-
> >   3 files changed, 139 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index f0057bac20fb..d0d141d50638 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6629,6 +6629,15 @@
> >                       <deci-seconds>: poll all this frequency
> >                       0: no polling (default)
> >
> > +     thp_anon=3D       [KNL]
> > +                     Format: <size>,<size>[KMG]:<state>;<size>-<size>[=
KMG]:<state>
> > +                     state is one of "always", "madvise", "never" or "=
inherit".
> > +                     Can be used to control the default behavior of th=
e
>
> s/Can be used to control/Control/

ack

>
> > +                     system with respect to anonymous transparent huge=
pages.
> > +                     Can be used multiple times for multiple anon THP =
sizes.
> > +                     See Documentation/admin-guide/mm/transhuge.rst fo=
r more
> > +                     details.
> > +
> >       threadirqs      [KNL,EARLY]
> >                       Force threading of all interrupt handlers except =
those
> >                       marked explicitly IRQF_NO_THREAD.
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 60522f49178b..4468851b6ecb 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -284,13 +284,37 @@ that THP is shared. Exceeding the number would bl=
ock the collapse::
> >
> >   A higher value may increase memory footprint for some workloads.
>
> [...]
>
> >   unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >                                        unsigned long vm_flags,
> > @@ -756,7 +757,10 @@ static int __init hugepage_init_sysfs(struct kobje=
ct **hugepage_kobj)
> >        * disable all other sizes. powerpc's PMD_ORDER isn't a compile-t=
ime
> >        * constant so we have to do this here.
> >        */
> > -     huge_anon_orders_inherit =3D BIT(PMD_ORDER);
> > +     if (!anon_orders_configured) {
> > +             huge_anon_orders_inherit =3D BIT(PMD_ORDER);
> > +             anon_orders_configured =3D true;

I realized this is redundant since anon_orders_configured won't be
accessed later.
so i would like to also drop  "anon_orders_configured =3D true" in v6.

> > +     }
> >
> >       *hugepage_kobj =3D kobject_create_and_add("transparent_hugepage",=
 mm_kobj);
> >       if (unlikely(!*hugepage_kobj)) {
> > @@ -941,6 +945,100 @@ static int __init setup_transparent_hugepage(char=
 *str)
> >   }
> >   __setup("transparent_hugepage=3D", setup_transparent_hugepage);
> >
> > +static inline int get_order_from_str(const char *size_str)
> > +{
> > +     unsigned long size;
> > +     char *endptr;
> > +     int order;
> > +
> > +     size =3D memparse(size_str, &endptr);
> > +
> > +     if (!is_power_of_2(size))
> > +             goto err;
> > +     order =3D get_order(size);
> > +     if ((1 << order) & ~THP_ORDERS_ALL_ANON)
>
> Could do
>
> "if (BIT(order) & ~THP_ORDERS_ALL_ANON)"

ack

>
> > +             goto err;
> > +
> > +     return order;
> > +err:
> > +     pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
> > +     return -EINVAL;
> > +}
> > +
> > +static char str_dup[PAGE_SIZE] __initdata;
> > +static int __init setup_thp_anon(char *str)
> > +{
> > +     char *token, *range, *policy, *subtoken;
> > +     unsigned long always, inherit, madvise;
> > +     char *start_size, *end_size;
> > +     int start, end, nr;
> > +     char *p;
> > +
> > +     if (!str || strlen(str) + 1 > PAGE_SIZE)
> > +             goto err;
> > +     strcpy(str_dup, str);
> > +
> > +     always =3D huge_anon_orders_always;
> > +     madvise =3D huge_anon_orders_madvise;
> > +     inherit =3D huge_anon_orders_inherit;
>
> Should we only pickup these values if "anon_orders_configured",
> otherwise start with 0? Likely that's implicit right now.

My point is that, initially, those values are always 0, so copying
them won't cause any issues.

Of course, we could add a check like
if (anon_orders_configured)
     copy...

but it doesn't seem to be a hot path by any means? in
that case, i will have to initialize:

unsigned long always =3D 0, inherit =3D 0, madvise =3D 0;

>
> > +     p =3D str_dup;
> > +     while ((token =3D strsep(&p, ";")) !=3D NULL) {
> > +             range =3D strsep(&token, ":");
> > +             policy =3D token;
> > +
> > +             if (!policy)
> > +                     goto err;
> > +
> > +             while ((subtoken =3D strsep(&range, ",")) !=3D NULL) {
> > +                     if (strchr(subtoken, '-')) {
> > +                             start_size =3D strsep(&subtoken, "-");
> > +                             end_size =3D subtoken;
> > +
> > +                             start =3D get_order_from_str(start_size);
> > +                             end =3D get_order_from_str(end_size);
> > +                     } else {
> > +                             start =3D end =3D get_order_from_str(subt=
oken);
> > +                     }
> > +
> > +                     if (start < 0 || end < 0 || start > end)
> > +                             goto err;
> > +
> > +                     nr =3D end - start + 1;
>
> This only works as long as we don't have any "Holes", which is the case
> right now.

Right. If a gap appears in the future, I can verify that all bits from star=
t
to end are valid against THP_ORDERS_ALL_ANON.

>
> > +                     if (!strcmp(policy, "always")) {
> > +                             bitmap_set(&always, start, nr);
> > +                             bitmap_clear(&inherit, start, nr);
> > +                             bitmap_clear(&madvise, start, nr);
> > +                     } else if (!strcmp(policy, "madvise")) {
> > +                             bitmap_set(&madvise, start, nr);
> > +                             bitmap_clear(&inherit, start, nr);
> > +                             bitmap_clear(&always, start, nr);
> > +                     } else if (!strcmp(policy, "inherit")) {
> > +                             bitmap_set(&inherit, start, nr);
> > +                             bitmap_clear(&madvise, start, nr);
> > +                             bitmap_clear(&always, start, nr);
> > +                     } else if (!strcmp(policy, "never")) {
> > +                             bitmap_clear(&inherit, start, nr);
> > +                             bitmap_clear(&madvise, start, nr);
> > +                             bitmap_clear(&always, start, nr);
> > +                     } else {
> > +                             pr_err("invalid policy %s in thp_anon boo=
t parameter\n", policy);
> > +                             goto err;
> > +                     }
> > +             }
> > +     }
> > +
> > +     huge_anon_orders_always =3D always;
> > +     huge_anon_orders_madvise =3D madvise;
> > +     huge_anon_orders_inherit =3D inherit;
> > +     anon_orders_configured =3D true;
> > +     return 1;
> > +
> > +err:
> > +     pr_warn("thp_anon=3D%s: cannot parse, ignored\n", str);
>
> "cannot parse, ignored" -> "error parsing string, ignoring setting" ?

Ack.

>
> > +     return 0;
> > +}
> > +__setup("thp_anon=3D", setup_thp_anon);
> > +
> >   pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
> >   {
> >       if (likely(vma->vm_flags & VM_WRITE))
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry


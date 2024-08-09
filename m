Return-Path: <linux-kernel+bounces-280618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1B94CCE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A0AB21145
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583B918FDC5;
	Fri,  9 Aug 2024 09:04:31 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89EBA41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194270; cv=none; b=Wa3O7IadfbVB10DR7hz8drTQhgMSmXIB7VJKSMmZqzjkOp7c9Kor5P0sco4fTLnAHnOrMdiZrINDDQuRlVrnESmuRrvHl/ZRuCPAO54pB/2UbSHN5Bh06o7D1pfSTg30DfAPKwAPZzHCXV0GiRLExbW3R5zu24qTcHfM6p1XLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194270; c=relaxed/simple;
	bh=H+z8E41Cq7BoCs4BRWX1fcH+z6y4o3+tFymdi/iNmeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPR013rtkWf984safsgjUKdvqpytBysDQ5ATomnXBK/fJfshasoeX9eMsxsNUQ1No5u69Y7wUPiUUoOgbUeZNX3DFwgOVOrodz86Z3FcdMGlaf251sIx/Lg913ci2IptZ4Ic9Z6nDLYR63ASHGqkXKGBGbzTp5z1cFCnxjy6Xys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f8b5e4c631so781818e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723194268; x=1723799068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQgvN8x7zaxI0q1kLK2PPMTGN/QVO8NMPgeZcIw1CHk=;
        b=iMZ7KxwhEpzJeuBdt9uH5UfJHHNINLkWaKYgN4BTD2L7FjIz/ABOJ9r6B6ahfMzVwN
         x43JvC67eijFrgIP3JG6uaVUeDyNMWFxr0zjNHVCOByMDMzNjHCI2NCnCUDY0CTr1GOt
         RbmPKzZzwWZQeu0+9vg6Ix9Qr645UfH9I7IXo4bgM9FkuzLGppPcC7zyFc5hGRZu9xmV
         jETF3MQQjyUPOcFt9GWI+LDYW9e56fHEkod1r3SjL8EhUixrvdDHObEFO148d4+W7Zhz
         DhoD+wyFXWJhiWgFrO3Zr7IYIIKFW1JFcFqpFBKEJiiWbUQr3QWeP774+d2Ifpyap6l7
         d1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVfRgk/a/OWDXLacsP9BrtM4DSCtHOloPSPuOaHRAZlGelOk1btZVTMZWoyiPPNZvfHtqDCN/zGnE6loP1oC6XkekZH/fiS0mmjPXyp
X-Gm-Message-State: AOJu0YyUxmyHdFF19p0NVbG+7K3P1tnJDQ/KFq6TZUCrp4W5Tuhx2vrX
	Yn8pF73YnS5ThFZu7vpbhpIyU+vkTeYcD+RbfytKEmTE9jDNPLaC05m+p5faYh/w24Z/jl0P2JC
	DjIV4kRk7IrnL6YKOyCH48LiDWSM8nxJ4
X-Google-Smtp-Source: AGHT+IGnvkc9o05KWmhisA2GJLS04VxK9exbouzBsblXB2JOEPLt84fg2cV6LN2kDwyDW8t6Fdg8gVC5A5C1Y2xnUQI=
X-Received: by 2002:a05:6122:470b:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-4f912ee0aafmr1124697e0c.12.1723194267473; Fri, 09 Aug 2024
 02:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808101700.571701-1-ryan.roberts@arm.com> <CAGsJ_4zPCFhngM0R5X6zGSw6KHPYqT8b7izQZt2xoFPSxCpRng@mail.gmail.com>
 <fe784034-0321-481b-96c0-ac5c48e0fb84@arm.com> <CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-Dt7Ewt3ExqTw@mail.gmail.com>
 <f50a4630-c3bf-4af5-a17f-133ef599e705@arm.com>
In-Reply-To: <f50a4630-c3bf-4af5-a17f-133ef599e705@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 9 Aug 2024 17:04:15 +0800
Message-ID: <CAGsJ_4xYjFCtAYNXTN2Md7XoWuN6ep_oU5zWErhypS6f1Vc8OQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 4:57=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 09/08/2024 09:31, Barry Song wrote:
> > On Fri, Aug 9, 2024 at 3:58=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 08/08/2024 22:17, Barry Song wrote:
> >>> On Thu, Aug 8, 2024 at 10:17=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> Add thp_anon=3D cmdline parameter to allow specifying the default
> >>>> enablement of each supported anon THP size. The parameter accepts th=
e
> >>>> following format and can be provided multiple times to configure eac=
h
> >>>> size:
> >>>>
> >>>> thp_anon=3D<size>[KMG]:<value>
> >>>>
> >>>> See Documentation/admin-guide/mm/transhuge.rst for more details.
> >>>>
> >>>> Configuring the defaults at boot time is useful to allow early user
> >>>> space to take advantage of mTHP before its been configured through
> >>>> sysfs.
> >>>>
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>
> >>>> Hi All,
> >>>>
> >>>> I've split this off from my RFC at [1] because Barry highlighted tha=
t he would
> >>>> benefit from it immediately [2]. There are no changes vs the version=
 in that
> >>>> series.
> >>>>
> >>>> It applies against today's mm-unstable (275d686abcb59). (although I =
had to fix a
> >>>> minor build bug in stackdepot.c due to MIN() not being defined in th=
is tree).
> >>>>
> >>>> Thanks,
> >>>> Ryan
> >>>>
> >>>>
> >>>>  .../admin-guide/kernel-parameters.txt         |  8 +++
> >>>>  Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
> >>>>  mm/huge_memory.c                              | 55 ++++++++++++++++=
++-
> >>>>  3 files changed, 82 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docum=
entation/admin-guide/kernel-parameters.txt
> >>>> index bcdee8984e1f0..5c79b58c108ec 100644
> >>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>> @@ -6631,6 +6631,14 @@
> >>>>                         <deci-seconds>: poll all this frequency
> >>>>                         0: no polling (default)
> >>>>
> >>>> +       thp_anon=3D       [KNL]
> >>>> +                       Format: <size>[KMG]:always|madvise|never|inh=
erit
> >>>> +                       Can be used to control the default behavior =
of the
> >>>> +                       system with respect to anonymous transparent=
 hugepages.
> >>>> +                       Can be used multiple times for multiple anon=
 THP sizes.
> >>>> +                       See Documentation/admin-guide/mm/transhuge.r=
st for more
> >>>> +                       details.
> >>>> +
> >>>>         threadirqs      [KNL,EARLY]
> >>>>                         Force threading of all interrupt handlers ex=
cept those
> >>>>                         marked explicitly IRQF_NO_THREAD.
> >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentat=
ion/admin-guide/mm/transhuge.rst
> >>>> index 24eec1c03ad88..f63b0717366c6 100644
> >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>> @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would=
 block the collapse::
> >>>>
> >>>>  A higher value may increase memory footprint for some workloads.
> >>>>
> >>>> -Boot parameter
> >>>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +Boot parameters
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> -You can change the sysfs boot time defaults of Transparent Hugepage
> >>>> -Support by passing the parameter ``transparent_hugepage=3Dalways`` =
or
> >>>> -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dneve=
r``
> >>>> -to the kernel command line.
> >>>> +You can change the sysfs boot time default for the top-level "enabl=
ed"
> >>>> +control by passing the parameter ``transparent_hugepage=3Dalways`` =
or
> >>>> +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dneve=
r`` to the
> >>>> +kernel command line.
> >>>> +
> >>>> +Alternatively, each supported anonymous THP size can be controlled =
by
> >>>> +passing ``thp_anon=3D<size>[KMG]:<state>``, where ``<size>`` is the=
 THP size
> >>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
> >>>> +``inherit``.
> >>>> +
> >>>> +For example, the following will set 64K THP to ``always``::
> >>>> +
> >>>> +       thp_anon=3D64K:always
> >>>> +
> >>>> +``thp_anon=3D`` may be specified multiple times to configure all TH=
P sizes as
> >>>> +required. If ``thp_anon=3D`` is specified at least once, any anon T=
HP sizes
> >>>> +not explicitly configured on the command line are implicitly set to
> >>>> +``never``.
> >>>>
> >>>>  Hugepages in tmpfs/shmem
> >>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 0c3075ee00012..c2c0da1eb94e6 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -82,6 +82,7 @@ unsigned long huge_zero_pfn __read_mostly =3D ~0UL=
;
> >>>>  unsigned long huge_anon_orders_always __read_mostly;
> >>>>  unsigned long huge_anon_orders_madvise __read_mostly;
> >>>>  unsigned long huge_anon_orders_inherit __read_mostly;
> >>>> +static bool anon_orders_configured;
> >>>>
> >>>>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma=
,
> >>>>                                          unsigned long vm_flags,
> >>>> @@ -672,7 +673,10 @@ static int __init hugepage_init_sysfs(struct ko=
bject **hugepage_kobj)
> >>>>          * disable all other sizes. powerpc's PMD_ORDER isn't a comp=
ile-time
> >>>>          * constant so we have to do this here.
> >>>>          */
> >>>> -       huge_anon_orders_inherit =3D BIT(PMD_ORDER);
> >>>> +       if (!anon_orders_configured) {
> >>>> +               huge_anon_orders_inherit =3D BIT(PMD_ORDER);
> >>>> +               anon_orders_configured =3D true;
> >>>> +       }
> >>>
> >>> If a user configures 64KB and doesn't adjust anything for PMD_ORDER,
> >>> then PMD_ORDER will  be set to "never", correct? This seems to change
> >>> the default behavior of PMD_ORDER. Could we instead achieve this by
> >>> checking if PMD_ORDER has been explicitly configured?
> >>
> >> Yes, that's how it's implemented in this patch, and the accompanying d=
ocs also
> >> state:
> >>
> >>   If ``thp_anon=3D`` is specified at least once, any anon THP sizes
> >>   not explicitly configured on the command line are implicitly set to
> >>   ``never``.
> >>
> >> My initial approach did exactly as you suggest. But in the original se=
ries, I
> >> also had a similar patch to configure file thp with "thp_file=3D". And=
 for file,
> >> all of the orders default to `always`. So if taking the same approach =
with that
> >> control, the user would have to explicitly opt-out of all supported or=
ders
> >> rather than just opt-in to the orders they want. And I thought that co=
uld get
> >> tricky in future if support is added for more orders. I felt that was
> >> potentially very confusing so decided it was clearer to have the above=
 rule and
> >> make both controls consistent.
> >>
> >> What do you think?
> >
> > If this is the intention, once the user sets the command line, they sho=
uld
> > realize that the default settings have been overridden. I am perfectly =
fine
> > with this strategy.
>
> OK. I can see it from both sides to be honest. Let's see if anyone else h=
as
> issue with this approach.
>
> >
> > with the below cmdline:
> >  thp_anon=3D64K:always thp_anon=3D8K:inherit thp_anon=3D32K:madvise
> > thp_anon=3D1M:inherit thp_anon=3D2M:always
> >
> > I am getting:
> >   / # cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
> >   [always] inherit madvise never
> >   / # cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enabled
> >   always inherit [madvise] never
> >   / # cat /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/enabled
> >   always [inherit] madvise never
> >   / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> >   [always] inherit madvise never
>
> And you should also be seeing a warning in the boot log that thp_anon=3D8=
K:inherit
> is unrecognised (since anon doesn't support order-1).

Indeed.
I am even seeing "Unknown kernel command line parameters
"thp_anon=3D8K:inherit", will be passed to user space."

[    0.000000] huge_memory: thp_anon=3D8K:inherit: cannot parse, ignored
[    0.000000] Unknown kernel command line parameters
"thp_anon=3D8K:inherit", will be passed to user space.
[    0.000000] random: crng init done
[    0.000000] Dentry cache hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 13107=
2
[    0.000000] Policy zone: DMA

>
> >
> > Thus,
> >
> > Tested-by: Barry Song <baohua@kernel.org>
>
> Thanks!
>
> >
> >>
> >>
> >>>
> >>>>
> >>>>         *hugepage_kobj =3D kobject_create_and_add("transparent_hugep=
age", mm_kobj);
> >>>>         if (unlikely(!*hugepage_kobj)) {
> >>>> @@ -857,6 +861,55 @@ static int __init setup_transparent_hugepage(ch=
ar *str)
> >>>>  }
> >>>>  __setup("transparent_hugepage=3D", setup_transparent_hugepage);
> >>>>
> >>>> +static int __init setup_thp_anon(char *str)
> >>>> +{
> >>>> +       unsigned long size;
> >>>> +       char *state;
> >>>> +       int order;
> >>>> +       int ret =3D 0;
> >>>> +
> >>>> +       if (!str)
> >>>> +               goto out;
> >>>> +
> >>>> +       size =3D (unsigned long)memparse(str, &state);
> >>>> +       order =3D ilog2(size >> PAGE_SHIFT);
> >>>> +       if (*state !=3D ':' || !is_power_of_2(size) || size <=3D PAG=
E_SIZE ||
> >>>> +           !(BIT(order) & THP_ORDERS_ALL_ANON))
> >>>> +               goto out;
> >>>> +
> >>>> +       state++;
> >>>> +
> >>>> +       if (!strcmp(state, "always")) {
> >>>> +               clear_bit(order, &huge_anon_orders_inherit);
> >>>> +               clear_bit(order, &huge_anon_orders_madvise);
> >>>> +               set_bit(order, &huge_anon_orders_always);
> >>>> +               ret =3D 1;
> >>>> +       } else if (!strcmp(state, "inherit")) {
> >>>> +               clear_bit(order, &huge_anon_orders_always);
> >>>> +               clear_bit(order, &huge_anon_orders_madvise);
> >>>> +               set_bit(order, &huge_anon_orders_inherit);
> >>>> +               ret =3D 1;
> >>>> +       } else if (!strcmp(state, "madvise")) {
> >>>> +               clear_bit(order, &huge_anon_orders_always);
> >>>> +               clear_bit(order, &huge_anon_orders_inherit);
> >>>> +               set_bit(order, &huge_anon_orders_madvise);
> >>>> +               ret =3D 1;
> >>>> +       } else if (!strcmp(state, "never")) {
> >>>> +               clear_bit(order, &huge_anon_orders_always);
> >>>> +               clear_bit(order, &huge_anon_orders_inherit);
> >>>> +               clear_bit(order, &huge_anon_orders_madvise);
> >>>> +               ret =3D 1;
> >>>> +       }
> >>>> +
> >>>> +       if (ret)
> >>>> +               anon_orders_configured =3D true;
> >>>
> >>> I mean:
> >>>
> >>> if (ret && order =3D=3D PMD_ORDER)
> >>>             anon_pmd_order_configured =3D true;
> >>>
> >>>> +out:
> >>>> +       if (!ret)
> >>>> +               pr_warn("thp_anon=3D%s: cannot parse, ignored\n", st=
r);
> >>>> +       return ret;
> >>>> +}
> >>>> +__setup("thp_anon=3D", setup_thp_anon);
> >>>> +
> >>>>  pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
> >>>>  {
> >>>>         if (likely(vma->vm_flags & VM_WRITE))
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>> Thanks
> >>> Barry
> >>
>
>


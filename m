Return-Path: <linux-kernel+bounces-280571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5694CC39
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47851C235E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2732B175D2C;
	Fri,  9 Aug 2024 08:31:26 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335B1863F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192285; cv=none; b=s4EMcvVrFEEddQl8uz53jo/iyC161JUeF+ZXmRIVBPgsktVXi7rJStL+Lv60z78YM0YH7diz6l0gKuYQVey0TyHSB/z+BVAnf6ro6adoqhQXWD55ATU713saDV+wVBeqkzLdocqy/8FptjvGXgQD9Rzhv+J/rV+OGkp8+p+l/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192285; c=relaxed/simple;
	bh=1RmneqfMb3O+a7nEmVuQ6g58EZqwJ7BwS89rf+ninpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXbLEwYnSv2c7zaXckZODIWB0MXvbseAcbBjsDTQG4NBE1SpGCDVJlVsHIeWjgiR7ZoZ/5Y7PtAcFMMAEUdXP3Z0iHRm98XH/ILEpujAZXwCjBdNggPcJMrgYllmHrEH5hpgWuKh3D1TkUWZyPvSzl66cPs7g6dFBbUmcROoR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f6c136a947so919881e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192282; x=1723797082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZK40ZjLkKvk1lhIvy8UiH7XWxOMBEix3uHnz9d9mU0=;
        b=QiAU3xu5bpzoIxlCcPWGO2UdiKiTDX2qoCt91i/l/Rx26ioMosg7+StuynGoPm7qA4
         99sZWkcCdmBByrUFb7QtUJyVVwR9Bw9DnKVielUjYZoNNQoOpKkWPHLJ9i/VOKifFxWF
         +AN7oEa1qGU8a6QvOrhivp7w+wLhEt7MBXRPHwdBJ22ZiLFvBkh/xVwSgsG43V4q3aKe
         hRy3FT9fxApy6T5cqhmUgJah24yXx4kxN7r1qJOaS8jV9acvU/h1hlC9pXpBq5OqZ1PG
         h+yG/voySg/nB6YzBP2cp77VaPsSFYuRL5nWRjt6onTuM9fu6fv9pLS5i+QJX/YDCnjb
         hTXw==
X-Forwarded-Encrypted: i=1; AJvYcCVBODE5hinp7tYcpsZZr4ijNHHcVpgh0igxUfwh+zxEedJATOAZcm2LiL1WhFDukNFZWupOVHpC8xnNOmIE9/1NWxaG2fWiutNemXC+
X-Gm-Message-State: AOJu0YyccIDOUvEU1bcquDa/xAG13HsnlvVp693vEms1+oW0MNJdN4CX
	EL1xw7aqMGFfdzIyCaDlFVj+QlzOHAB0xqORQCRam35ARBCnj6tRVoVvpXOnnMsSBHQfmFqZd81
	VIfhd56Vr2l9R8FIgtAN4nPOH84I=
X-Google-Smtp-Source: AGHT+IGwGBq4Ll1rOYyofTagZ08OgmVLUQt5o3URGGPtwKZRwWhaiWTeVq8rh4xlhLxfEkp9pCYN8g8pllaIpmpqe44=
X-Received: by 2002:a05:6122:21ac:b0:4ed:12b:ec99 with SMTP id
 71dfb90a1353d-4f912bc752bmr981548e0c.3.1723192282219; Fri, 09 Aug 2024
 01:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808101700.571701-1-ryan.roberts@arm.com> <CAGsJ_4zPCFhngM0R5X6zGSw6KHPYqT8b7izQZt2xoFPSxCpRng@mail.gmail.com>
 <fe784034-0321-481b-96c0-ac5c48e0fb84@arm.com>
In-Reply-To: <fe784034-0321-481b-96c0-ac5c48e0fb84@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 9 Aug 2024 16:31:10 +0800
Message-ID: <CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-Dt7Ewt3ExqTw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:58=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 08/08/2024 22:17, Barry Song wrote:
> > On Thu, Aug 8, 2024 at 10:17=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> Add thp_anon=3D cmdline parameter to allow specifying the default
> >> enablement of each supported anon THP size. The parameter accepts the
> >> following format and can be provided multiple times to configure each
> >> size:
> >>
> >> thp_anon=3D<size>[KMG]:<value>
> >>
> >> See Documentation/admin-guide/mm/transhuge.rst for more details.
> >>
> >> Configuring the defaults at boot time is useful to allow early user
> >> space to take advantage of mTHP before its been configured through
> >> sysfs.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>
> >> Hi All,
> >>
> >> I've split this off from my RFC at [1] because Barry highlighted that =
he would
> >> benefit from it immediately [2]. There are no changes vs the version i=
n that
> >> series.
> >>
> >> It applies against today's mm-unstable (275d686abcb59). (although I ha=
d to fix a
> >> minor build bug in stackdepot.c due to MIN() not being defined in this=
 tree).
> >>
> >> Thanks,
> >> Ryan
> >>
> >>
> >>  .../admin-guide/kernel-parameters.txt         |  8 +++
> >>  Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
> >>  mm/huge_memory.c                              | 55 ++++++++++++++++++=
-
> >>  3 files changed, 82 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documen=
tation/admin-guide/kernel-parameters.txt
> >> index bcdee8984e1f0..5c79b58c108ec 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -6631,6 +6631,14 @@
> >>                         <deci-seconds>: poll all this frequency
> >>                         0: no polling (default)
> >>
> >> +       thp_anon=3D       [KNL]
> >> +                       Format: <size>[KMG]:always|madvise|never|inher=
it
> >> +                       Can be used to control the default behavior of=
 the
> >> +                       system with respect to anonymous transparent h=
ugepages.
> >> +                       Can be used multiple times for multiple anon T=
HP sizes.
> >> +                       See Documentation/admin-guide/mm/transhuge.rst=
 for more
> >> +                       details.
> >> +
> >>         threadirqs      [KNL,EARLY]
> >>                         Force threading of all interrupt handlers exce=
pt those
> >>                         marked explicitly IRQF_NO_THREAD.
> >> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentatio=
n/admin-guide/mm/transhuge.rst
> >> index 24eec1c03ad88..f63b0717366c6 100644
> >> --- a/Documentation/admin-guide/mm/transhuge.rst
> >> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >> @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would b=
lock the collapse::
> >>
> >>  A higher value may increase memory footprint for some workloads.
> >>
> >> -Boot parameter
> >> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +Boot parameters
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> -You can change the sysfs boot time defaults of Transparent Hugepage
> >> -Support by passing the parameter ``transparent_hugepage=3Dalways`` or
> >> -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever`=
`
> >> -to the kernel command line.
> >> +You can change the sysfs boot time default for the top-level "enabled=
"
> >> +control by passing the parameter ``transparent_hugepage=3Dalways`` or
> >> +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever`=
` to the
> >> +kernel command line.
> >> +
> >> +Alternatively, each supported anonymous THP size can be controlled by
> >> +passing ``thp_anon=3D<size>[KMG]:<state>``, where ``<size>`` is the T=
HP size
> >> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
> >> +``inherit``.
> >> +
> >> +For example, the following will set 64K THP to ``always``::
> >> +
> >> +       thp_anon=3D64K:always
> >> +
> >> +``thp_anon=3D`` may be specified multiple times to configure all THP =
sizes as
> >> +required. If ``thp_anon=3D`` is specified at least once, any anon THP=
 sizes
> >> +not explicitly configured on the command line are implicitly set to
> >> +``never``.
> >>
> >>  Hugepages in tmpfs/shmem
> >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 0c3075ee00012..c2c0da1eb94e6 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -82,6 +82,7 @@ unsigned long huge_zero_pfn __read_mostly =3D ~0UL;
> >>  unsigned long huge_anon_orders_always __read_mostly;
> >>  unsigned long huge_anon_orders_madvise __read_mostly;
> >>  unsigned long huge_anon_orders_inherit __read_mostly;
> >> +static bool anon_orders_configured;
> >>
> >>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >>                                          unsigned long vm_flags,
> >> @@ -672,7 +673,10 @@ static int __init hugepage_init_sysfs(struct kobj=
ect **hugepage_kobj)
> >>          * disable all other sizes. powerpc's PMD_ORDER isn't a compil=
e-time
> >>          * constant so we have to do this here.
> >>          */
> >> -       huge_anon_orders_inherit =3D BIT(PMD_ORDER);
> >> +       if (!anon_orders_configured) {
> >> +               huge_anon_orders_inherit =3D BIT(PMD_ORDER);
> >> +               anon_orders_configured =3D true;
> >> +       }
> >
> > If a user configures 64KB and doesn't adjust anything for PMD_ORDER,
> > then PMD_ORDER will  be set to "never", correct? This seems to change
> > the default behavior of PMD_ORDER. Could we instead achieve this by
> > checking if PMD_ORDER has been explicitly configured?
>
> Yes, that's how it's implemented in this patch, and the accompanying docs=
 also
> state:
>
>   If ``thp_anon=3D`` is specified at least once, any anon THP sizes
>   not explicitly configured on the command line are implicitly set to
>   ``never``.
>
> My initial approach did exactly as you suggest. But in the original serie=
s, I
> also had a similar patch to configure file thp with "thp_file=3D". And fo=
r file,
> all of the orders default to `always`. So if taking the same approach wit=
h that
> control, the user would have to explicitly opt-out of all supported order=
s
> rather than just opt-in to the orders they want. And I thought that could=
 get
> tricky in future if support is added for more orders. I felt that was
> potentially very confusing so decided it was clearer to have the above ru=
le and
> make both controls consistent.
>
> What do you think?

If this is the intention, once the user sets the command line, they should
realize that the default settings have been overridden. I am perfectly fine
with this strategy.

with the below cmdline:
 thp_anon=3D64K:always thp_anon=3D8K:inherit thp_anon=3D32K:madvise
thp_anon=3D1M:inherit thp_anon=3D2M:always

I am getting:
  / # cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
  [always] inherit madvise never
  / # cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enabled
  always inherit [madvise] never
  / # cat /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/enabled
  always [inherit] madvise never
  / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
  [always] inherit madvise never

Thus,

Tested-by: Barry Song <baohua@kernel.org>

>
>
> >
> >>
> >>         *hugepage_kobj =3D kobject_create_and_add("transparent_hugepag=
e", mm_kobj);
> >>         if (unlikely(!*hugepage_kobj)) {
> >> @@ -857,6 +861,55 @@ static int __init setup_transparent_hugepage(char=
 *str)
> >>  }
> >>  __setup("transparent_hugepage=3D", setup_transparent_hugepage);
> >>
> >> +static int __init setup_thp_anon(char *str)
> >> +{
> >> +       unsigned long size;
> >> +       char *state;
> >> +       int order;
> >> +       int ret =3D 0;
> >> +
> >> +       if (!str)
> >> +               goto out;
> >> +
> >> +       size =3D (unsigned long)memparse(str, &state);
> >> +       order =3D ilog2(size >> PAGE_SHIFT);
> >> +       if (*state !=3D ':' || !is_power_of_2(size) || size <=3D PAGE_=
SIZE ||
> >> +           !(BIT(order) & THP_ORDERS_ALL_ANON))
> >> +               goto out;
> >> +
> >> +       state++;
> >> +
> >> +       if (!strcmp(state, "always")) {
> >> +               clear_bit(order, &huge_anon_orders_inherit);
> >> +               clear_bit(order, &huge_anon_orders_madvise);
> >> +               set_bit(order, &huge_anon_orders_always);
> >> +               ret =3D 1;
> >> +       } else if (!strcmp(state, "inherit")) {
> >> +               clear_bit(order, &huge_anon_orders_always);
> >> +               clear_bit(order, &huge_anon_orders_madvise);
> >> +               set_bit(order, &huge_anon_orders_inherit);
> >> +               ret =3D 1;
> >> +       } else if (!strcmp(state, "madvise")) {
> >> +               clear_bit(order, &huge_anon_orders_always);
> >> +               clear_bit(order, &huge_anon_orders_inherit);
> >> +               set_bit(order, &huge_anon_orders_madvise);
> >> +               ret =3D 1;
> >> +       } else if (!strcmp(state, "never")) {
> >> +               clear_bit(order, &huge_anon_orders_always);
> >> +               clear_bit(order, &huge_anon_orders_inherit);
> >> +               clear_bit(order, &huge_anon_orders_madvise);
> >> +               ret =3D 1;
> >> +       }
> >> +
> >> +       if (ret)
> >> +               anon_orders_configured =3D true;
> >
> > I mean:
> >
> > if (ret && order =3D=3D PMD_ORDER)
> >             anon_pmd_order_configured =3D true;
> >
> >> +out:
> >> +       if (!ret)
> >> +               pr_warn("thp_anon=3D%s: cannot parse, ignored\n", str)=
;
> >> +       return ret;
> >> +}
> >> +__setup("thp_anon=3D", setup_thp_anon);
> >> +
> >>  pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
> >>  {
> >>         if (likely(vma->vm_flags & VM_WRITE))
> >> --
> >> 2.43.0
> >>
> >
> > Thanks
> > Barry
>


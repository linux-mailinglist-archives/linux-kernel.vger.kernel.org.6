Return-Path: <linux-kernel+bounces-419349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82819D6CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 07:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8D3B21325
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 06:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0751632E7;
	Sun, 24 Nov 2024 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU0uIkpu"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2721FDA;
	Sun, 24 Nov 2024 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732431369; cv=none; b=qtqS97fhhDqpZ0L+uwOy8e/o2+E1aRLEN+neETkttQisgJtmsWEAQMvt8T19BDAirzzpyEfcMCToKQu48KaaIrzKVBWFWKX8brE3a9b2BpFUBw8+qkz5LrbLRkr4W29eFsNFFPcm11womyqXT1G8gmvPvHJtLEOLAx7H0kUeSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732431369; c=relaxed/simple;
	bh=3Za1GLBFnFwONUWEViSA7JPbzhK6WxWOAY6ScGO0avQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUt7oPc3qeZ1nggpRWMZZGC32t0ze1hakmL798//Tyw3e81KmQ7m2Ql5JZHKhcfKaiLhfJ/dnXdot9c0qdu2J48LaaO4LxIhVOalrJpfjB+HIa7+KfCCUl5EjnhxWj+GgbBP0/rmva33xCr64VfE3vlMmVrCWeg4nIrdgbWmEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU0uIkpu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfcd99846fso4506076a12.1;
        Sat, 23 Nov 2024 22:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732431366; x=1733036166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZMrYJW3fr4hyXvkEVlCX5Cs2x5+zPWq/vgYLWx4O1U=;
        b=fU0uIkpuMcA1O4OXcD9O0/FfuImvPjmI52l/gcrzKupGM/8kJCBKw4DxciOtvkInDA
         OCkHhqBP276ATyFk5oOMSibrHW8QIezrB6sRTzLoxAjT8FBWZ6Jw/Rxc42cvLYP6Ndra
         ZTJXn7Rm0XgkmSTTI8Tnk2Bn5ICMmboq2F3wGBSh1lVNurKXvhJ+MzOmi3/3Icge1X2F
         vHDjuP4hbVK0rJ3TY4cyOGcxUCnql9IOEwv5bXS6Rh6WKxftCfvJIfL9QkeVYPfRNLlT
         e8HLqK8k55pzjJQVVyJw5gNzfC61Uczq6/dMx9VIPh+4Vpchrx62h9K4Ci4q4Vtoyva4
         YTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732431366; x=1733036166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZMrYJW3fr4hyXvkEVlCX5Cs2x5+zPWq/vgYLWx4O1U=;
        b=jUzMHY+loBrjdFtv9KV4Z3XB8HJlpgLDvv0mP4uV9i0Ir3hriM5c8u575oKDEtsvds
         CeLJIidjUWmf2lDS+7jgIKX0GYEVm44W9erbh8+gkg3F7LSjGJDGS0v4vJne9zm6IrYV
         F2g44Ka7ZNJ8YzlN4tKVbS2pDm1N8uQeQsaKSjFfD3c5XlhlSUmKPXS13oJ54QBBMF6Y
         y4j1CvEGGE5EFDq6Zx5jk62Y5Mn7yibXbLcFGOSfEa9q/kmQFJiv32pQY2kIt0O09i28
         CNwrpVBMAk1n7NrHGHMMXcxRByvxApAS0uE5kGd6RYSp5UHVnK+OvObc30DtyYtsXsUs
         9sog==
X-Forwarded-Encrypted: i=1; AJvYcCVO6y4p64e4KMyDTirNBPjp2JFKMVYJte+8TT3KVJmX0JAHFQcus1GWNZOReCye613CMC3VA6OxcHs=@vger.kernel.org, AJvYcCXbk3zeCZGEfWNLqHo39TKAk/NdhX7/MG2vw0MSIzQSo6dX4zyyM35LCBZDagTOV/f4k07xcitTOWgbpkSc@vger.kernel.org
X-Gm-Message-State: AOJu0YzgaJaSDbNmTqSQZpVj+9oRu5rwdhHzXAsbqtB/+iOZggTTSUbD
	l8fE2wCGu9oCleBscGTcdj3glzOya6goTlKCUt14swpMgIjxddMHHZ8EizlmrS/UPKM2a/3snyF
	xc9cJefSgM9/tCXhwTErMOGTNn4U=
X-Gm-Gg: ASbGnctomzEc+EtUsHHPOj0P1WXAaF18OVeLEeSoY3vM5Ai3kSi6i4y3BuTcOy4MsK8
	hh/dc0K3t9OBbHMNLQr3jpIARAfuWTkc=
X-Google-Smtp-Source: AGHT+IFbxUU/f/KL6GhITyqXaHQ+rfg8Hdle3mjV/ep9AVq3aimLQV09GJHEn4AgzoiE6QEnRBHlN8/41whXH4MRKqk=
X-Received: by 2002:a05:6402:1e93:b0:5cf:e26b:566c with SMTP id
 4fb4d7f45d1cf-5d0205f8ec7mr6180594a12.10.1732431365982; Sat, 23 Nov 2024
 22:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122161443.34667-1-haowenchao22@gmail.com>
 <CAK1f24k6n1ngSicrSCv5jX+xa75t-7a3zZB4A95fUvDhteshEQ@mail.gmail.com>
 <CAGsJ_4w-u703LbrmnsgkNVzpFwFwY7tO9mFoo1RXGk3rb_r3mw@mail.gmail.com>
 <CAK1f24meJBDA1wzX56=2y2NQm7BVP6OudFXJuGnZuUFnZKUh+A@mail.gmail.com> <24ea047a-7294-4e7a-bf51-66b7f79f5085@gmail.com>
In-Reply-To: <24ea047a-7294-4e7a-bf51-66b7f79f5085@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sun, 24 Nov 2024 14:55:29 +0800
Message-ID: <CAK1f24kj_0DsVYgZj3nH699jt2MN4AQ55w7gGoFaWM_zgceYSQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add per-order mTHP swap-in fallback/fallback_charge
 counters
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Usama Arif <usamaarif642@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 9:17=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> On 2024/11/23 19:52, Lance Yang wrote:
> > On Sat, Nov 23, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Sat, Nov 23, 2024 at 10:36=E2=80=AFAM Lance Yang <ioworker0@gmail.c=
om> wrote:
> >>>
> >>> Hi Wenchao,
> >>>
> >>> On Sat, Nov 23, 2024 at 12:14=E2=80=AFAM Wenchao Hao <haowenchao22@gm=
ail.com> wrote:
> >>>>
> >>>> Currently, large folio swap-in is supported, but we lack a method to
> >>>> analyze their success ratio. Similar to anon_fault_fallback, we intr=
oduce
> >>>> per-order mTHP swpin_fallback and swpin_fallback_charge counters for
> >>>> calculating their success ratio. The new counters are located at:
> >>>>
> >>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
> >>>>         swpin_fallback
> >>>>         swpin_fallback_charge
> >>>>
> >>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> >>>> ---
> >>>> V2:
> >>>>  Introduce swapin_fallback_charge, which increments if it fails to
> >>>>  charge a huge page to memory despite successful allocation.
> >>>>
> >>>>  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
> >>>>  include/linux/huge_mm.h                    |  2 ++
> >>>>  mm/huge_memory.c                           |  6 ++++++
> >>>>  mm/memory.c                                |  2 ++
> >>>>  4 files changed, 20 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentat=
ion/admin-guide/mm/transhuge.rst
> >>>> index 5034915f4e8e..9c07612281b5 100644
> >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>> @@ -561,6 +561,16 @@ swpin
> >>>>         is incremented every time a huge page is swapped in from a n=
on-zswap
> >>>>         swap device in one piece.
> >>>>
> >>>
> >>> Would the following be better?
> >>>
> >>> +swpin_fallback
> >>> +       is incremented if a huge page swapin fails to allocate or cha=
rge
> >>> +       it and instead falls back to using small pages.
> >>>
> >>> +swpin_fallback_charge
> >>> +       is incremented if a huge page swapin fails to charge it and i=
nstead
> >>> +       falls back to using small pages even though the allocation wa=
s
> >>> +       successful.
> >>
> >> much better, but it is better to align with "huge pages with
> >> lower orders or small pages", not necessarily small pages:
> >>
> >> anon_fault_fallback
> >> is incremented if a page fault fails to allocate or charge
> >> a huge page and instead falls back to using huge pages with
> >> lower orders or small pages.
> >>
> >> anon_fault_fallback_charge
> >> is incremented if a page fault fails to charge a huge page and
> >> instead falls back to using huge pages with lower orders or
> >> small pages even though the allocation was successful.
> >
> > Right, I clearly overlooked that ;)
> >
>
> Hi Lance and Barry,
>
> Do you think the following expression is clear? Compared to my original
> version, I=E2=80=99ve removed the word =E2=80=9Chuge=E2=80=9D from the fi=
rst line, and it now
> looks almost identical to anon_fault_fallback/anon_fault_fallback_charge.

Well, that's fine with me. And let's see Barry's opinion as well ;)

Thanks,
Lance

>
> swpin_fallback
>        is incremented if a page swapin fails to allocate or charge
>        a huge page and instead falls back to using huge pages with
>        lower orders or small pages.
>
> swpin_fallback_charge
>        is incremented if a page swapin fails to charge a huge page and
>        instead falls back to using huge pages with lower orders or
>        small pages even though the allocation was successful.
>
> Thanks,
> Wencaho
>
> > Thanks,
> > Lance
> >
> >>
> >>>
> >>> Thanks,
> >>> Lance
> >>>
> >>>> +swpin_fallback
> >>>> +       is incremented if a huge page swapin fails to allocate or ch=
arge
> >>>> +       a huge page and instead falls back to using huge pages with
> >>>> +       lower orders or small pages.
> >>>> +
> >>>> +swpin_fallback_charge
> >>>> +       is incremented if a page swapin fails to charge a huge page =
and
> >>>> +       instead falls back to using huge pages with lower orders or
> >>>> +       small pages even though the allocation was successful.
> >>>> +
> >>>>  swpout
> >>>>         is incremented every time a huge page is swapped out to a no=
n-zswap
> >>>>         swap device in one piece without splitting.
> >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>> index b94c2e8ee918..93e509b6c00e 100644
> >>>> --- a/include/linux/huge_mm.h
> >>>> +++ b/include/linux/huge_mm.h
> >>>> @@ -121,6 +121,8 @@ enum mthp_stat_item {
> >>>>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>>>         MTHP_STAT_ZSWPOUT,
> >>>>         MTHP_STAT_SWPIN,
> >>>> +       MTHP_STAT_SWPIN_FALLBACK,
> >>>> +       MTHP_STAT_SWPIN_FALLBACK_CHARGE,
> >>>>         MTHP_STAT_SWPOUT,
> >>>>         MTHP_STAT_SWPOUT_FALLBACK,
> >>>>         MTHP_STAT_SHMEM_ALLOC,
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index ee335d96fc39..46749dded1c9 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_=
STAT_ANON_FAULT_FALLBACK);
> >>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FA=
ULT_FALLBACK_CHARGE);
> >>>>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> >>>>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> >>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> >>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FALLBA=
CK_CHARGE);
> >>>>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> >>>>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> >>>>  #ifdef CONFIG_SHMEM
> >>>> @@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] =3D =
{
> >>>>  #ifndef CONFIG_SHMEM
> >>>>         &zswpout_attr.attr,
> >>>>         &swpin_attr.attr,
> >>>> +       &swpin_fallback_attr.attr,
> >>>> +       &swpin_fallback_charge_attr.attr,
> >>>>         &swpout_attr.attr,
> >>>>         &swpout_fallback_attr.attr,
> >>>>  #endif
> >>>> @@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] =3D {
> >>>>  #ifdef CONFIG_SHMEM
> >>>>         &zswpout_attr.attr,
> >>>>         &swpin_attr.attr,
> >>>> +       &swpin_fallback_attr.attr,
> >>>> +       &swpin_fallback_charge_attr.attr,
> >>>>         &swpout_attr.attr,
> >>>>         &swpout_fallback_attr.attr,
> >>>>  #endif
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index 209885a4134f..774dfd309cfe 100644
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>> @@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(struct =
vm_fault *vmf)
> >>>>                         if (!mem_cgroup_swapin_charge_folio(folio, v=
ma->vm_mm,
> >>>>                                                             gfp, ent=
ry))
> >>>>                                 return folio;
> >>>> +                       count_mthp_stat(order, MTHP_STAT_SWPIN_FALLB=
ACK_CHARGE);
> >>>>                         folio_put(folio);
> >>>>                 }
> >>>> +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> >>>>                 order =3D next_order(&orders, order);
> >>>>         }
> >>>>
> >>>> --
> >>>> 2.45.0
> >>>>
> >>
> >> Thanks
> >> Barry
>


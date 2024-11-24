Return-Path: <linux-kernel+bounces-419358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339229D6CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD1616054D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC00189B9D;
	Sun, 24 Nov 2024 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXCeCVML"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55584189B9C;
	Sun, 24 Nov 2024 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732432280; cv=none; b=kj5YE9bkprcasWDmX35V9mIOyimm1Bt4gAR/7pVm9rQVDC6+demiaogEJ4VWp5HJ+i3jmUbFvl7s24DRjf5Yy+VLAeu9/J18++U4GRyu9RDyTpT69TjoCak3ROU8aW6AuACaouFjxWncKrHAAP48wVjFagQNHSLFryhJ6yC4aMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732432280; c=relaxed/simple;
	bh=Cp/BC5qYgAp6rUX+aXu6ha4sAuDkvRH8L88Sj/GL8o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amK1JxoN1KuKV5C80apLeCI7kNf16e/j8Oj5Qp+omehCZ+oLsA4ZJY5lfUDe1CUZM3SHD1NxxSHDuOpowZpeQVYSpN+sSqJMtBkE/gVNCsgo9+wc693/ObMjcOOdYSY1LHEbQw/lPGsOOhkKPGnlQt7ZNFCkTk/ObsXJ9cdqreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXCeCVML; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5152e0a0ff5so2730e0c.3;
        Sat, 23 Nov 2024 23:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732432277; x=1733037077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLzWC7PIwcFcnJcsDsiHmrWmwtgiy+vFsNne+lF+MOA=;
        b=EXCeCVMLMDHqaxDMMrfggCGGqeuhf2nKDjOLDrnLIXrsJUxqdvduFuHPK+xvyPp/hr
         NssBzlJ87P07qxTSzZx8JoYbez2buhqZXI+xVJMlE5NI55k81Bo6bq+6BMBhDgdYjEgP
         QudDhQ3EEJsqXNumr91pm+kSSIa2OAy0gQ+Uc/7iBPZBnARnQstRTSRW9wdXYaTlZGwu
         zXfxihZnTtmN+7dJc3rHS3JWTI9uKB1F7zE/tRyaqV7tjbuuG3b4tYdIFkCkOE1bCfR6
         Q1X9tKAnkD75sQXqoe7dbIXXjbwIbOgbLvt2/4xHej/bcUXiaU87tuAWn0N6m/M06ke7
         zWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732432277; x=1733037077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLzWC7PIwcFcnJcsDsiHmrWmwtgiy+vFsNne+lF+MOA=;
        b=PGLQ4RPkKBQXIH9lj7QA0b/BKk2OCXRuipCIW0GzLkfylwASpBI1eOmawOMrbWBYhD
         RcJhbGYA18hq7XELCOhOqFph5Zupla2V1k1mJEI8vNIwH3DkglKEEj9rK8eLOb+KtIKR
         crAt4Kgv2bZdbDoh3/hcufduAhQmFAY0YgffiRpP/gSgfzyhMCzNsSqWLulQqLGWdCnm
         azTIeAyQoIV6cFmqmMi3xPpOurcKZmq8rIdoik3MV2Q+DEaKA611ip+t7CbvBEA1K91i
         pj91gm//1jLwsvDLWO4L+LTbIWDdbBap1Ri66okk69jtqGaoIE7yZznY9yV0DTcBs3Su
         AcOA==
X-Forwarded-Encrypted: i=1; AJvYcCUP4Z+Zd3xEOe9+b39EtDp3DwXmZ0aSFHc/HFMofg2ixiyP0Q7npmi+s/vpVtmK8TleHPB+WN3uzBacIxms@vger.kernel.org, AJvYcCUo2XAFnrxq4SawsgdWnQSVEa0c3MI5ydYwpSt5hSxmBwzeUfWGH5BCc4gebOwvb+4PjfDMKcXv2Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Hh3be22KlB35msTNg490ztxbQf175TaxFZE236/P+GDIYxCW
	/7CYKfzEzsB0Q9Qw/X/gpvtygj62Hv4S49tYW36s9DxsIRUDpdcodIXDFHadkpdAHcv14moHX3w
	3YIy3KlqRvgJSZVyCdbH+OVvxmPzHkdQg
X-Gm-Gg: ASbGncsiRO1qQKLQ16ATy3srpVuPVIK1AB1ovN33G7zxz++Buj8eXemPrIcWbStusFf
	zjBVwTmJzGoBCp13vfQy3OzP0ihv5MjVA9TVc52rYeZHPc8mftMjsbhTdBKLDvSmM3w==
X-Google-Smtp-Source: AGHT+IEM0MIsZ6PBBeeeFX0gjDh35wvArpcl66cKwh1CS3kKhICjwIBFKhYzisYss2ktb2IzdxqhjmcDB+mk8vXFVaE=
X-Received: by 2002:a05:6122:4d82:b0:50d:2769:d757 with SMTP id
 71dfb90a1353d-51500b6c0b6mr8219721e0c.11.1732432277004; Sat, 23 Nov 2024
 23:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122161443.34667-1-haowenchao22@gmail.com>
 <CAK1f24k6n1ngSicrSCv5jX+xa75t-7a3zZB4A95fUvDhteshEQ@mail.gmail.com>
 <CAGsJ_4w-u703LbrmnsgkNVzpFwFwY7tO9mFoo1RXGk3rb_r3mw@mail.gmail.com>
 <CAK1f24meJBDA1wzX56=2y2NQm7BVP6OudFXJuGnZuUFnZKUh+A@mail.gmail.com>
 <24ea047a-7294-4e7a-bf51-66b7f79f5085@gmail.com> <CAK1f24kj_0DsVYgZj3nH699jt2MN4AQ55w7gGoFaWM_zgceYSQ@mail.gmail.com>
In-Reply-To: <CAK1f24kj_0DsVYgZj3nH699jt2MN4AQ55w7gGoFaWM_zgceYSQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 24 Nov 2024 15:11:05 +0800
Message-ID: <CAGsJ_4yxuV77bR72PHs-_78qb3iud-mQ75VJAAGAsiD4ZsXP4A@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add per-order mTHP swap-in fallback/fallback_charge
 counters
To: Lance Yang <ioworker0@gmail.com>
Cc: Wenchao Hao <haowenchao22@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Usama Arif <usamaarif642@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 2:56=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> On Sat, Nov 23, 2024 at 9:17=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.c=
om> wrote:
> >
> > On 2024/11/23 19:52, Lance Yang wrote:
> > > On Sat, Nov 23, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > >>
> > >> On Sat, Nov 23, 2024 at 10:36=E2=80=AFAM Lance Yang <ioworker0@gmail=
.com> wrote:
> > >>>
> > >>> Hi Wenchao,
> > >>>
> > >>> On Sat, Nov 23, 2024 at 12:14=E2=80=AFAM Wenchao Hao <haowenchao22@=
gmail.com> wrote:
> > >>>>
> > >>>> Currently, large folio swap-in is supported, but we lack a method =
to
> > >>>> analyze their success ratio. Similar to anon_fault_fallback, we in=
troduce
> > >>>> per-order mTHP swpin_fallback and swpin_fallback_charge counters f=
or
> > >>>> calculating their success ratio. The new counters are located at:
> > >>>>
> > >>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
> > >>>>         swpin_fallback
> > >>>>         swpin_fallback_charge
> > >>>>
> > >>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> > >>>> ---
> > >>>> V2:
> > >>>>  Introduce swapin_fallback_charge, which increments if it fails to
> > >>>>  charge a huge page to memory despite successful allocation.
> > >>>>
> > >>>>  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
> > >>>>  include/linux/huge_mm.h                    |  2 ++
> > >>>>  mm/huge_memory.c                           |  6 ++++++
> > >>>>  mm/memory.c                                |  2 ++
> > >>>>  4 files changed, 20 insertions(+)
> > >>>>
> > >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Document=
ation/admin-guide/mm/transhuge.rst
> > >>>> index 5034915f4e8e..9c07612281b5 100644
> > >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> > >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> > >>>> @@ -561,6 +561,16 @@ swpin
> > >>>>         is incremented every time a huge page is swapped in from a=
 non-zswap
> > >>>>         swap device in one piece.
> > >>>>
> > >>>
> > >>> Would the following be better?
> > >>>
> > >>> +swpin_fallback
> > >>> +       is incremented if a huge page swapin fails to allocate or c=
harge
> > >>> +       it and instead falls back to using small pages.
> > >>>
> > >>> +swpin_fallback_charge
> > >>> +       is incremented if a huge page swapin fails to charge it and=
 instead
> > >>> +       falls back to using small pages even though the allocation =
was
> > >>> +       successful.
> > >>
> > >> much better, but it is better to align with "huge pages with
> > >> lower orders or small pages", not necessarily small pages:
> > >>
> > >> anon_fault_fallback
> > >> is incremented if a page fault fails to allocate or charge
> > >> a huge page and instead falls back to using huge pages with
> > >> lower orders or small pages.
> > >>
> > >> anon_fault_fallback_charge
> > >> is incremented if a page fault fails to charge a huge page and
> > >> instead falls back to using huge pages with lower orders or
> > >> small pages even though the allocation was successful.
> > >
> > > Right, I clearly overlooked that ;)
> > >
> >
> > Hi Lance and Barry,
> >
> > Do you think the following expression is clear? Compared to my original
> > version, I=E2=80=99ve removed the word =E2=80=9Chuge=E2=80=9D from the =
first line, and it now
> > looks almost identical to anon_fault_fallback/anon_fault_fallback_charg=
e.
>
> Well, that's fine with me. And let's see Barry's opinion as well ;)

I still prefer Lance's version. The fallback path in it only needs to
be adjusted to
include huge pages with lower orders. In contrast, Wenchao's version feels =
less
natural to me because "page swapin" sounds quite odd - we often hear
"page fault,"
but we have never encountered "page swapin."

So I mean:

 swpin_fallback
        is incremented if swapin fails to allocate or charge a huge
page and instead
        falls back to using huge pages with lower orders or small pages.

 swpin_fallback_charge
        is incremented if swapin fails to charge a huge page and instead
        falls back to using  huge pages with lower orders or small
pages even though
        the allocation was successful.

>
> Thanks,
> Lance
>
> >
> > swpin_fallback
> >        is incremented if a page swapin fails to allocate or charge
> >        a huge page and instead falls back to using huge pages with
> >        lower orders or small pages.
> >
> > swpin_fallback_charge
> >        is incremented if a page swapin fails to charge a huge page and
> >        instead falls back to using huge pages with lower orders or
> >        small pages even though the allocation was successful.
> >
> > Thanks,
> > Wencaho
> >
> > > Thanks,
> > > Lance
> > >
> > >>
> > >>>
> > >>> Thanks,
> > >>> Lance
> > >>>
> > >>>> +swpin_fallback
> > >>>> +       is incremented if a huge page swapin fails to allocate or =
charge
> > >>>> +       a huge page and instead falls back to using huge pages wit=
h
> > >>>> +       lower orders or small pages.
> > >>>> +
> > >>>> +swpin_fallback_charge
> > >>>> +       is incremented if a page swapin fails to charge a huge pag=
e and
> > >>>> +       instead falls back to using huge pages with lower orders o=
r
> > >>>> +       small pages even though the allocation was successful.
> > >>>> +
> > >>>>  swpout
> > >>>>         is incremented every time a huge page is swapped out to a =
non-zswap
> > >>>>         swap device in one piece without splitting.
> > >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > >>>> index b94c2e8ee918..93e509b6c00e 100644
> > >>>> --- a/include/linux/huge_mm.h
> > >>>> +++ b/include/linux/huge_mm.h
> > >>>> @@ -121,6 +121,8 @@ enum mthp_stat_item {
> > >>>>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> > >>>>         MTHP_STAT_ZSWPOUT,
> > >>>>         MTHP_STAT_SWPIN,
> > >>>> +       MTHP_STAT_SWPIN_FALLBACK,
> > >>>> +       MTHP_STAT_SWPIN_FALLBACK_CHARGE,
> > >>>>         MTHP_STAT_SWPOUT,
> > >>>>         MTHP_STAT_SWPOUT_FALLBACK,
> > >>>>         MTHP_STAT_SHMEM_ALLOC,
> > >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > >>>> index ee335d96fc39..46749dded1c9 100644
> > >>>> --- a/mm/huge_memory.c
> > >>>> +++ b/mm/huge_memory.c
> > >>>> @@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTH=
P_STAT_ANON_FAULT_FALLBACK);
> > >>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_=
FAULT_FALLBACK_CHARGE);
> > >>>>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> > >>>>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> > >>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> > >>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FALL=
BACK_CHARGE);
> > >>>>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> > >>>>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK)=
;
> > >>>>  #ifdef CONFIG_SHMEM
> > >>>> @@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] =
=3D {
> > >>>>  #ifndef CONFIG_SHMEM
> > >>>>         &zswpout_attr.attr,
> > >>>>         &swpin_attr.attr,
> > >>>> +       &swpin_fallback_attr.attr,
> > >>>> +       &swpin_fallback_charge_attr.attr,
> > >>>>         &swpout_attr.attr,
> > >>>>         &swpout_fallback_attr.attr,
> > >>>>  #endif
> > >>>> @@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] =3D=
 {
> > >>>>  #ifdef CONFIG_SHMEM
> > >>>>         &zswpout_attr.attr,
> > >>>>         &swpin_attr.attr,
> > >>>> +       &swpin_fallback_attr.attr,
> > >>>> +       &swpin_fallback_charge_attr.attr,
> > >>>>         &swpout_attr.attr,
> > >>>>         &swpout_fallback_attr.attr,
> > >>>>  #endif
> > >>>> diff --git a/mm/memory.c b/mm/memory.c
> > >>>> index 209885a4134f..774dfd309cfe 100644
> > >>>> --- a/mm/memory.c
> > >>>> +++ b/mm/memory.c
> > >>>> @@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(struc=
t vm_fault *vmf)
> > >>>>                         if (!mem_cgroup_swapin_charge_folio(folio,=
 vma->vm_mm,
> > >>>>                                                             gfp, e=
ntry))
> > >>>>                                 return folio;
> > >>>> +                       count_mthp_stat(order, MTHP_STAT_SWPIN_FAL=
LBACK_CHARGE);
> > >>>>                         folio_put(folio);
> > >>>>                 }
> > >>>> +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> > >>>>                 order =3D next_order(&orders, order);
> > >>>>         }
> > >>>>
> > >>>> --
> > >>>> 2.45.0
> > >>>>
> > >>

Thanks
Barry


Return-Path: <linux-kernel+bounces-426348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FF99DF1FB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BF5162B8E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6249F1A0BF1;
	Sat, 30 Nov 2024 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ5qLC/p"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846FD42AA4;
	Sat, 30 Nov 2024 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732983792; cv=none; b=ln7/gyxbpeYHAo1GMUyjezKswcX8Nb69hgwZ5CBQ2sCau6SU64ZowD3JuEjEPl+SvdAgQjw/kcJzHSp+Cll3V/5BuUNby1bAxkqGwjqkHuceHADcRrP9Ec1YC5BojUD51U3CScQVDjWy3RD7WBH/YugtHK0/I9pcBCIUilBzM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732983792; c=relaxed/simple;
	bh=VuglfRL5ZYnrptPh3zU3mj7m0WbyoiU8/ThPlfdFOWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQVXbXr9+Fn5Ava1EkSzTu8Yd9LsBho6W/Bi0HQC9YZFu/5KhXbrAdM3fk6eOYr9cCxCUI/Mx6xHPCKmOMtt9+zUzAb9OQnkf06ZKD2RTXNFmOSEQ2EsSVYgncJeIlkh2rvrsEcHxKhcw3w32zjt6AE0I7LZY0sQzGGOyy6nzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ5qLC/p; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0cd8a0e91so775842a12.3;
        Sat, 30 Nov 2024 08:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732983789; x=1733588589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMscJ3aDp4dhi8HIAQTRmiFd/2KnaoYEk2ldSvVqDVY=;
        b=QJ5qLC/pyfDUfzzRpfo7v9uajCbd9m2KQQlvW7v4W142VV/R5qsklw6ajTgOcTS/pV
         cuWzsIPr9UYkegInW5nzvYYrzbIHOxjUOOa68TGiKg06+bwA86SqNUF9FJQJHOWgmiQq
         l/85ADng8HIt06yATj03ldY4CWJavt4J3Pz0COcIUXFnDrQFHMlOR9XM83AkMCHkz7Yu
         mRk1F7bFPrgB7aEKrI3Uz31XDq15v3TasdZQiCLe+HRrHzVPfM0L5BsG4A8iCkyBj3+Z
         2Qo4Jhs2BXKLtgYs6a/QUlvVtW1eiz6ZbKopTngp1ftdFoW30/f0lWT6mox6dO3N1Tx2
         wAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732983789; x=1733588589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMscJ3aDp4dhi8HIAQTRmiFd/2KnaoYEk2ldSvVqDVY=;
        b=WSr4suzzyUWf09wja8hHppyN1AbjU4PeQVCFFQb9/aGVSune9nRhxod5GhLLrzK2Dq
         7KVUgMs7qSFSk0xQkh1r6xnq3IxtxVYOVqAY5H0evEzuFv80UbIcEGhx1zXpWukNbZg+
         +yvsbPKpiPoYFXx9lSkpkpm7Q/a760a18JkrdSjjbVtREET86NwqdDo9lD/Wn1/tSbwT
         xfVeP71I51dS12kVjK8TzNDfQZ729LuNpBrsEGEouI7swl36YfonIaKXhO5/By0clcN0
         d19tNTKhXGyDdRc3q6wX8pl1TwqpWluqQOqEsj2QGhEw1qwF0w7bv9izBH0phu+qp4J9
         qpUg==
X-Forwarded-Encrypted: i=1; AJvYcCVKefglHq8ZeAfhaWGZJcMMuiIsjHbHt8PLiN3q1p2iAaup7Vq43TCkRdPQwdYZHp6yfz5wY6+zhS8=@vger.kernel.org, AJvYcCVjd2DlTpfR8mQYggRPzFo+tfKhDkYr/iI/fBIWrnG86yecauf4hwkYF3ZP2XSrOFsXZ1IM9kOHrIbO9mUu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxizvn2pcwb/EX2++5+Yi6AewIgJn6ERdVCUUJE4aOh+U9lXf1J
	1fN85xPMSKit6x6a4GBGe6ln57Tczx1lQdqkx3Q3DqY7wgct75SzWSv/XWHR1umXVQYRzsYiyEP
	pdYzcHzggU8KE4RYDCfHpjEAfomU=
X-Gm-Gg: ASbGncu6CKJSNTXwqB98J6+vNGIGg3Av4NVegBae3S3UYwc+Xnmvo6q0I3o4Q7H41dy
	4HqSfWbBuCYjr2ZjhUfDSqyRF00myf+0=
X-Google-Smtp-Source: AGHT+IElUhN1m91qkf7Y5KCjWIivvHiPfvnAws+ucdGjEd6YBrf1frJvYOQNEYM6C2ZgeLY0rZFXd+X7C0Lytx5DMIQ=
X-Received: by 2002:a05:6402:280a:b0:5d0:cea1:931e with SMTP id
 4fb4d7f45d1cf-5d0cea19806mr2262324a12.23.1732983788395; Sat, 30 Nov 2024
 08:23:08 -0800 (PST)
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
 <CAGsJ_4yxuV77bR72PHs-_78qb3iud-mQ75VJAAGAsiD4ZsXP4A@mail.gmail.com>
 <CAK1f24n-HW_Rp5FRXrm3nVrzz=4w2=sL_PO9aoa9F3fvL1_1aw@mail.gmail.com> <6dbd2d37-91ca-4566-af4a-7b4153d2001c@gmail.com>
In-Reply-To: <6dbd2d37-91ca-4566-af4a-7b4153d2001c@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sun, 1 Dec 2024 00:22:32 +0800
Message-ID: <CAK1f24nGQMKYus9pqywUr6FKh+KyRd-RXsArBgdL1ecOEBsT6w@mail.gmail.com>
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

On Fri, Nov 29, 2024 at 7:49=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> On 2024/11/24 15:28, Lance Yang wrote:
> > On Sun, Nov 24, 2024 at 3:11=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Sun, Nov 24, 2024 at 2:56=E2=80=AFPM Lance Yang <ioworker0@gmail.co=
m> wrote:
> >>>
> >>> On Sat, Nov 23, 2024 at 9:17=E2=80=AFPM Wenchao Hao <haowenchao22@gma=
il.com> wrote:
> >>>>
> >>>> On 2024/11/23 19:52, Lance Yang wrote:
> >>>>> On Sat, Nov 23, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.c=
om> wrote:
> >>>>>>
> >>>>>> On Sat, Nov 23, 2024 at 10:36=E2=80=AFAM Lance Yang <ioworker0@gma=
il.com> wrote:
> >>>>>>>
> >>>>>>> Hi Wenchao,
> >>>>>>>
> >>>>>>> On Sat, Nov 23, 2024 at 12:14=E2=80=AFAM Wenchao Hao <haowenchao2=
2@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> Currently, large folio swap-in is supported, but we lack a metho=
d to
> >>>>>>>> analyze their success ratio. Similar to anon_fault_fallback, we =
introduce
> >>>>>>>> per-order mTHP swpin_fallback and swpin_fallback_charge counters=
 for
> >>>>>>>> calculating their success ratio. The new counters are located at=
:
> >>>>>>>>
> >>>>>>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
> >>>>>>>>         swpin_fallback
> >>>>>>>>         swpin_fallback_charge
> >>>>>>>>
> >>>>>>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> >>>>>>>> ---
> >>>>>>>> V2:
> >>>>>>>>  Introduce swapin_fallback_charge, which increments if it fails =
to
> >>>>>>>>  charge a huge page to memory despite successful allocation.
> >>>>>>>>
> >>>>>>>>  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
> >>>>>>>>  include/linux/huge_mm.h                    |  2 ++
> >>>>>>>>  mm/huge_memory.c                           |  6 ++++++
> >>>>>>>>  mm/memory.c                                |  2 ++
> >>>>>>>>  4 files changed, 20 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Docume=
ntation/admin-guide/mm/transhuge.rst
> >>>>>>>> index 5034915f4e8e..9c07612281b5 100644
> >>>>>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>>>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>>>>>> @@ -561,6 +561,16 @@ swpin
> >>>>>>>>         is incremented every time a huge page is swapped in from=
 a non-zswap
> >>>>>>>>         swap device in one piece.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Would the following be better?
> >>>>>>>
> >>>>>>> +swpin_fallback
> >>>>>>> +       is incremented if a huge page swapin fails to allocate or=
 charge
> >>>>>>> +       it and instead falls back to using small pages.
> >>>>>>>
> >>>>>>> +swpin_fallback_charge
> >>>>>>> +       is incremented if a huge page swapin fails to charge it a=
nd instead
> >>>>>>> +       falls back to using small pages even though the allocatio=
n was
> >>>>>>> +       successful.
> >>>>>>
> >>>>>> much better, but it is better to align with "huge pages with
> >>>>>> lower orders or small pages", not necessarily small pages:
> >>>>>>
> >>>>>> anon_fault_fallback
> >>>>>> is incremented if a page fault fails to allocate or charge
> >>>>>> a huge page and instead falls back to using huge pages with
> >>>>>> lower orders or small pages.
> >>>>>>
> >>>>>> anon_fault_fallback_charge
> >>>>>> is incremented if a page fault fails to charge a huge page and
> >>>>>> instead falls back to using huge pages with lower orders or
> >>>>>> small pages even though the allocation was successful.
> >>>>>
> >>>>> Right, I clearly overlooked that ;)
> >>>>>
> >>>>
> >>>> Hi Lance and Barry,
> >>>>
> >>>> Do you think the following expression is clear? Compared to my origi=
nal
> >>>> version, I=E2=80=99ve removed the word =E2=80=9Chuge=E2=80=9D from t=
he first line, and it now
> >>>> looks almost identical to anon_fault_fallback/anon_fault_fallback_ch=
arge.
> >>>
> >>> Well, that's fine with me. And let's see Barry's opinion as well ;)
> >>
> >> I still prefer Lance's version. The fallback path in it only needs to
> >> be adjusted to
> >> include huge pages with lower orders. In contrast, Wenchao's version f=
eels less
> >> natural to me because "page swapin" sounds quite odd - we often hear
> >> "page fault,"
> >> but we have never encountered "page swapin."
> >
> > Yeah, it makes sense to me ~
> >
> >>
> >> So I mean:
> >>
> >>  swpin_fallback
> >>         is incremented if swapin fails to allocate or charge a huge
> >> page and instead
> >>         falls back to using huge pages with lower orders or small page=
s.
> >>
> >>  swpin_fallback_charge
> >>         is incremented if swapin fails to charge a huge page and inste=
ad
> >>         falls back to using  huge pages with lower orders or small
> >> pages even though
> >>         the allocation was successful.
> >
> > IHMO, much better and clearer than before ;)
> >
>
> Hi,
>
> Thank you both very much for your valuable suggestions. I am only
> now able to respond to your emails due to a network issue.
>
> I will make the revisions based on your feedback and send the third
> version of the patch.

Thanks for following up.

>
> Should I include a "Reviewed-by" or any other tags?

Seems like there is no RB yet. I think we just tweak the doc as Barry
suggested, resend out the new version, and then wait for the folks to
review it ;)

Thanks,
Lance

>
> Thanks again,
> Wenchao
>
>
> > Thank,
> > Lance
> >
> >>
> >>>
> >>> Thanks,
> >>> Lance
> >>>
> >>>>
> >>>> swpin_fallback
> >>>>        is incremented if a page swapin fails to allocate or charge
> >>>>        a huge page and instead falls back to using huge pages with
> >>>>        lower orders or small pages.
> >>>>
> >>>> swpin_fallback_charge
> >>>>        is incremented if a page swapin fails to charge a huge page a=
nd
> >>>>        instead falls back to using huge pages with lower orders or
> >>>>        small pages even though the allocation was successful.
> >>>>
> >>>> Thanks,
> >>>> Wencaho
> >>>>
> >>>>> Thanks,
> >>>>> Lance
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Lance
> >>>>>>>
> >>>>>>>> +swpin_fallback
> >>>>>>>> +       is incremented if a huge page swapin fails to allocate o=
r charge
> >>>>>>>> +       a huge page and instead falls back to using huge pages w=
ith
> >>>>>>>> +       lower orders or small pages.
> >>>>>>>> +
> >>>>>>>> +swpin_fallback_charge
> >>>>>>>> +       is incremented if a page swapin fails to charge a huge p=
age and
> >>>>>>>> +       instead falls back to using huge pages with lower orders=
 or
> >>>>>>>> +       small pages even though the allocation was successful.
> >>>>>>>> +
> >>>>>>>>  swpout
> >>>>>>>>         is incremented every time a huge page is swapped out to =
a non-zswap
> >>>>>>>>         swap device in one piece without splitting.
> >>>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>>>>>> index b94c2e8ee918..93e509b6c00e 100644
> >>>>>>>> --- a/include/linux/huge_mm.h
> >>>>>>>> +++ b/include/linux/huge_mm.h
> >>>>>>>> @@ -121,6 +121,8 @@ enum mthp_stat_item {
> >>>>>>>>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>>>>>>>         MTHP_STAT_ZSWPOUT,
> >>>>>>>>         MTHP_STAT_SWPIN,
> >>>>>>>> +       MTHP_STAT_SWPIN_FALLBACK,
> >>>>>>>> +       MTHP_STAT_SWPIN_FALLBACK_CHARGE,
> >>>>>>>>         MTHP_STAT_SWPOUT,
> >>>>>>>>         MTHP_STAT_SWPOUT_FALLBACK,
> >>>>>>>>         MTHP_STAT_SHMEM_ALLOC,
> >>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>>>>>> index ee335d96fc39..46749dded1c9 100644
> >>>>>>>> --- a/mm/huge_memory.c
> >>>>>>>> +++ b/mm/huge_memory.c
> >>>>>>>> @@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, M=
THP_STAT_ANON_FAULT_FALLBACK);
> >>>>>>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANO=
N_FAULT_FALLBACK_CHARGE);
> >>>>>>>>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> >>>>>>>>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> >>>>>>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK)=
;
> >>>>>>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FA=
LLBACK_CHARGE);
> >>>>>>>>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> >>>>>>>>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBAC=
K);
> >>>>>>>>  #ifdef CONFIG_SHMEM
> >>>>>>>> @@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] =
=3D {
> >>>>>>>>  #ifndef CONFIG_SHMEM
> >>>>>>>>         &zswpout_attr.attr,
> >>>>>>>>         &swpin_attr.attr,
> >>>>>>>> +       &swpin_fallback_attr.attr,
> >>>>>>>> +       &swpin_fallback_charge_attr.attr,
> >>>>>>>>         &swpout_attr.attr,
> >>>>>>>>         &swpout_fallback_attr.attr,
> >>>>>>>>  #endif
> >>>>>>>> @@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] =
=3D {
> >>>>>>>>  #ifdef CONFIG_SHMEM
> >>>>>>>>         &zswpout_attr.attr,
> >>>>>>>>         &swpin_attr.attr,
> >>>>>>>> +       &swpin_fallback_attr.attr,
> >>>>>>>> +       &swpin_fallback_charge_attr.attr,
> >>>>>>>>         &swpout_attr.attr,
> >>>>>>>>         &swpout_fallback_attr.attr,
> >>>>>>>>  #endif
> >>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>>>>>> index 209885a4134f..774dfd309cfe 100644
> >>>>>>>> --- a/mm/memory.c
> >>>>>>>> +++ b/mm/memory.c
> >>>>>>>> @@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(str=
uct vm_fault *vmf)
> >>>>>>>>                         if (!mem_cgroup_swapin_charge_folio(foli=
o, vma->vm_mm,
> >>>>>>>>                                                             gfp,=
 entry))
> >>>>>>>>                                 return folio;
> >>>>>>>> +                       count_mthp_stat(order, MTHP_STAT_SWPIN_F=
ALLBACK_CHARGE);
> >>>>>>>>                         folio_put(folio);
> >>>>>>>>                 }
> >>>>>>>> +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK)=
;
> >>>>>>>>                 order =3D next_order(&orders, order);
> >>>>>>>>         }
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> 2.45.0
> >>>>>>>>
> >>>>>>
> >>
> >> Thanks
> >> Barry
>


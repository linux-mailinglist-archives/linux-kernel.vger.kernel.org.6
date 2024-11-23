Return-Path: <linux-kernel+bounces-419020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F079D689D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21921613C6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF71885A0;
	Sat, 23 Nov 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCW148zs"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71139187342;
	Sat, 23 Nov 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732357664; cv=none; b=cnDmoNaC5fxgcAa9QOglY4arz5nyFnx7J4MdVS9O9sZ9N6+fwe7OjH9gabynzVIuSUQ1cQe9Us/cdkxYUXmxB8oFhyiyu48ZpT6dBIVJfg2yOpiwuNUzOD/itecZhcTayd+QKUVL4woJNe2JidhUInTmAJrF+YNngqrlboDPrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732357664; c=relaxed/simple;
	bh=ZdW4OMHSn6JOtvfo2KgWViiFGcrRptSBaLiLnJ3pAIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tjn9uVWNGgsh+uW9dlIsxycmSXqLFDZGYD46qZ3p9S1QTy8Njwi0i6YI0W2x/St4cnxG3wAKYkjZ4UtjYlB522X1vAaPTJgpyjzqTCYGcqLP2DYH0V32cUKQ4YLmhM9D8j09WFEDF+FeYWVsK/rzUpgmO/JLGCty2nu/qBFiKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCW148zs; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4af0e05b6a0so14817137.2;
        Sat, 23 Nov 2024 02:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732357661; x=1732962461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er+B/vMbUNBHjwLGeOqjfngDnFXhQWZvKB9zekZc58w=;
        b=iCW148zsH0VaDTVzqViWHsNyWEsN6v581dPwoC/Od98LrPuGne1Bv/zBGEXo9b3SDk
         NXIcNSibN34vJEfOG2OiouSwPINEMjt/D1wbjVoShbjnEgM5BKRIJv3miV1vfJrFy48q
         wwp6ZoavKeeZxERWmNMiFReb3haGPVFxwVdl/v2D+veyJasdwJhzEVH36FBYsBBZORqJ
         uqDLAV1WbtyUsSIKkMQiF0apRn/gEKDEeTmW3apXM41QJAjT/fztQb30mE3PobcWWq0X
         xk3rr8B3AxFZN+PbMuyEY7zHC0dfy08j+j2WVX4/LbnoaG4CbcoK9ALxeSkg9izw/BZw
         f3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732357661; x=1732962461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=er+B/vMbUNBHjwLGeOqjfngDnFXhQWZvKB9zekZc58w=;
        b=Kqf+Ps8d0ePQr2rLWS4VM21JF+y8XqmrdeN0l5LtypZfEVlpowwYnFkS/No6x9Bx/U
         N2DgYLECjPIS4ugkCgrEQwCKQzWUxmx+yNF2W/DZP+nVzyVJ3fEXslD77MLe/i8T/93I
         zEAfbzsUFMO0b5CsWoSHV+ygs8sfMt1wZvAeVk1HLgLoNKQL9YxiU7vbO8N9ySxXxlml
         bWeJ6qTx6m39XtWAPlN0Eh1LkuKN7R64tC7vttZSOsGMCfBBEZ16bzPU5Dw3JigVJteP
         HeAGth2GCj8m25ityNmZd+wKV6ktqqxONsHzlq16eMOedakev+7lbfUGh2kYnkf7d0i+
         HUqw==
X-Forwarded-Encrypted: i=1; AJvYcCU4FFMM/7/WVmkCF7vcr5wXjTkRJe6XbxdAv3B6G6rdglZtvarF4uqtCGnck1pi+FhEYKqNi4nr5mY=@vger.kernel.org, AJvYcCVjc0t+Elgi3hznctpeef0LhTCuSynB5/PQnahoFc1ZCMb3l61W8dZLcL/oqwFQnqcWzdT9G71sJ8QK+j2R@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XUGaGbHEVF/Ug8+pkIgxecDY2v2ITrIaWs6xX+awSlH5aiwu
	7kE442LlWcifc2+XNMIS3a5W0Iq1bYj671Fs92CwbWgYYbXxp6k29+a/bReM6xMj7tm13bD0G1p
	rnu4qWXUoqCpzItVJjPAAq04kFmI=
X-Gm-Gg: ASbGncuL9M1ePv+bbPq1kpAQc0Kui8EaeBDzTQnw6ucBgioTN/OorLpRCnKILtMqGgU
	/0ZTBUhLXlklZ9gM/mR9e93vQ3WFvyu6ATGsNvQtoBTT69kFiES/9L3OpAHLEur2iew==
X-Google-Smtp-Source: AGHT+IFucNPYZs/JNZpVyYFVmUJCqsmAS7paUSqzbxQSqVTYDACoKrU0a/ZTmz7MiJHAOkmfRzsp7pOWzUEEuUANTcA=
X-Received: by 2002:a05:6102:942:b0:4ad:635b:8a38 with SMTP id
 ada2fe7eead31-4addcbefa07mr6585253137.14.1732357661052; Sat, 23 Nov 2024
 02:27:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122161443.34667-1-haowenchao22@gmail.com> <CAK1f24k6n1ngSicrSCv5jX+xa75t-7a3zZB4A95fUvDhteshEQ@mail.gmail.com>
In-Reply-To: <CAK1f24k6n1ngSicrSCv5jX+xa75t-7a3zZB4A95fUvDhteshEQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 23 Nov 2024 18:27:28 +0800
Message-ID: <CAGsJ_4w-u703LbrmnsgkNVzpFwFwY7tO9mFoo1RXGk3rb_r3mw@mail.gmail.com>
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

On Sat, Nov 23, 2024 at 10:36=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> Hi Wenchao,
>
> On Sat, Nov 23, 2024 at 12:14=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.=
com> wrote:
> >
> > Currently, large folio swap-in is supported, but we lack a method to
> > analyze their success ratio. Similar to anon_fault_fallback, we introdu=
ce
> > per-order mTHP swpin_fallback and swpin_fallback_charge counters for
> > calculating their success ratio. The new counters are located at:
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
> >         swpin_fallback
> >         swpin_fallback_charge
> >
> > Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> > ---
> > V2:
> >  Introduce swapin_fallback_charge, which increments if it fails to
> >  charge a huge page to memory despite successful allocation.
> >
> >  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
> >  include/linux/huge_mm.h                    |  2 ++
> >  mm/huge_memory.c                           |  6 ++++++
> >  mm/memory.c                                |  2 ++
> >  4 files changed, 20 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 5034915f4e8e..9c07612281b5 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -561,6 +561,16 @@ swpin
> >         is incremented every time a huge page is swapped in from a non-=
zswap
> >         swap device in one piece.
> >
>
> Would the following be better?
>
> +swpin_fallback
> +       is incremented if a huge page swapin fails to allocate or charge
> +       it and instead falls back to using small pages.
>
> +swpin_fallback_charge
> +       is incremented if a huge page swapin fails to charge it and inste=
ad
> +       falls back to using small pages even though the allocation was
> +       successful.

much better, but it is better to align with "huge pages with
lower orders or small pages", not necessarily small pages:

anon_fault_fallback
is incremented if a page fault fails to allocate or charge
a huge page and instead falls back to using huge pages with
lower orders or small pages.

anon_fault_fallback_charge
is incremented if a page fault fails to charge a huge page and
instead falls back to using huge pages with lower orders or
small pages even though the allocation was successful.

>
> Thanks,
> Lance
>
> > +swpin_fallback
> > +       is incremented if a huge page swapin fails to allocate or charg=
e
> > +       a huge page and instead falls back to using huge pages with
> > +       lower orders or small pages.
> > +
> > +swpin_fallback_charge
> > +       is incremented if a page swapin fails to charge a huge page and
> > +       instead falls back to using huge pages with lower orders or
> > +       small pages even though the allocation was successful.
> > +
> >  swpout
> >         is incremented every time a huge page is swapped out to a non-z=
swap
> >         swap device in one piece without splitting.
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index b94c2e8ee918..93e509b6c00e 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -121,6 +121,8 @@ enum mthp_stat_item {
> >         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >         MTHP_STAT_ZSWPOUT,
> >         MTHP_STAT_SWPIN,
> > +       MTHP_STAT_SWPIN_FALLBACK,
> > +       MTHP_STAT_SWPIN_FALLBACK_CHARGE,
> >         MTHP_STAT_SWPOUT,
> >         MTHP_STAT_SWPOUT_FALLBACK,
> >         MTHP_STAT_SHMEM_ALLOC,
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index ee335d96fc39..46749dded1c9 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STA=
T_ANON_FAULT_FALLBACK);
> >  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT=
_FALLBACK_CHARGE);
> >  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> >  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> > +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> > +DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FALLBACK_=
CHARGE);
> >  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> >  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> >  #ifdef CONFIG_SHMEM
> > @@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] =3D {
> >  #ifndef CONFIG_SHMEM
> >         &zswpout_attr.attr,
> >         &swpin_attr.attr,
> > +       &swpin_fallback_attr.attr,
> > +       &swpin_fallback_charge_attr.attr,
> >         &swpout_attr.attr,
> >         &swpout_fallback_attr.attr,
> >  #endif
> > @@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] =3D {
> >  #ifdef CONFIG_SHMEM
> >         &zswpout_attr.attr,
> >         &swpin_attr.attr,
> > +       &swpin_fallback_attr.attr,
> > +       &swpin_fallback_charge_attr.attr,
> >         &swpout_attr.attr,
> >         &swpout_fallback_attr.attr,
> >  #endif
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 209885a4134f..774dfd309cfe 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(struct vm_=
fault *vmf)
> >                         if (!mem_cgroup_swapin_charge_folio(folio, vma-=
>vm_mm,
> >                                                             gfp, entry)=
)
> >                                 return folio;
> > +                       count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK=
_CHARGE);
> >                         folio_put(folio);
> >                 }
> > +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> >                 order =3D next_order(&orders, order);
> >         }
> >
> > --
> > 2.45.0
> >

Thanks
Barry


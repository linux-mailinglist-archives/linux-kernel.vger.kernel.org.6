Return-Path: <linux-kernel+bounces-419359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54379D6CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD40161138
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 07:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE01386B4;
	Sun, 24 Nov 2024 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB1eWNUl"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B03C12;
	Sun, 24 Nov 2024 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732433341; cv=none; b=OB5MflmG30/Y142ra0UI9l5dRW8PZLcFIenuTELE6kavy6qF0whuZOoKTRITz34FraVjZp1503VMhqMlRE//1AH18bsEw9HfwE0pf01XpD0oUrw+O+/OUe+2ICfu4VJfnEGy+gYGHgu3DCEE1Fb3WKY+KgyiUEnZE3aiKhoHMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732433341; c=relaxed/simple;
	bh=uTVbuc+bMHExdoKVtkcmKGF/SFBadhDRTV0lD1poI70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJx9hZechfCEc/pPlZW7U6zE2IOFKopxGxkFK1BbHQlGF4unu4y5PydR/AhBx6OeNem9Cb+RlmB8Q6/ffq4l0DlBqk13lG1wGDXfr7P2Q1lmUKtF80VzIi6IALyp/PBhHfGfHCsbBHVutL+nZcMKyW/zksdAJeW5ZFFUhRhKmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB1eWNUl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so3990791a12.3;
        Sat, 23 Nov 2024 23:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732433338; x=1733038138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN8zRcfhE6ALGBdKKjyOrLy2sDPTD/bNAD8E4U8U+TA=;
        b=DB1eWNUlhWGmzCHAgvzTYekJSvMVT0uGbmlddsaF9ur9HZ00IfF8qe0w+gUbS1PS82
         7p4HpAY5BuaLIYNPfi7+JcDlPdnGWWE4D8cfRuTbmi5SGLMlckEPgkrr2Tg5H3BoNf8l
         JmO4tRWGB1Q+2oaD1TyCNifr+QDi1moWVvkQc2f3h5VE1Jj8WrtYupubiG0V5Y6jZj6C
         0/HWq/3n72pl3QSpnY4WdzbhYnDrQRcb12S/WU4Qr3Ig01Z0x94FWf+QTwI5yjlUCU/F
         DnejohZc41G4YjZ4+UEgiquvm7q9iRHhNGCyks5pSN9ZIB/RXNwhgGoNlnq0sRzUTXf6
         2p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732433338; x=1733038138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN8zRcfhE6ALGBdKKjyOrLy2sDPTD/bNAD8E4U8U+TA=;
        b=dHv4ShS7digXkO9Mw6bcN/OBqypmjWS3VtpzYdV7AWkWMACzHogu2uHxukS2o/lWSM
         ldOa+KW0v/WyK8c3iURH3WwNWhHPWdSajq/URSrTap28dQFZSc2DpB9uMruVuHBQ49ik
         x+/J+2zhXBK8QTXNPT1lBmgptGz95uwMKj78+j/ZX4JfeOUYCaj2cRVLu0r/NrrBE1Of
         43CNYEB4Nm4aiNoW/33OtsvRlZ3AW0ljZvdcuRu8FysmZp6VlgHeRbOXx9BvxYTdnYuZ
         pA8ypyGImg7VYN1ZHLkxx4BiFcPXJxWOe5k9OGXcLrmUnMNMk3MPjzMXPdbbunUEI61k
         6qOw==
X-Forwarded-Encrypted: i=1; AJvYcCVgzNfKHOzOt0yEuCF7RoOplDgILwB5nagDMSdhoCm7+O7y5063v9kFHqFib22ecf5aOa5wU08c9b8=@vger.kernel.org, AJvYcCXsz+yeqj7IGELt5+BMt1HxKnjXWYef7SGn1rO1hmJfmm/kNp2Tcfae63kT9LTYclwikKD+PkRX8xF89nPb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/16zNGOB5Lt4JpGjZAKIDpczHwTAXrXEpDXLKkP5kwzC+Giy
	sGY77EBEVAO5sT2pmF3s42k75ObZywruijN7MCxGaljiRE4piDoVxTOMzhFdVeuLD8yYPliTGwy
	dGMnhf5SaOPB0pG12431Xm+QRiS4=
X-Gm-Gg: ASbGncukDImNFESWVKx/XABHIKPtqY9lGdC6iJO6bClFO1VXVrLZVzep5DM8Ya6QD1G
	O7N42rRRnRCXsekS0sDzjp7cxlIWf3XM=
X-Google-Smtp-Source: AGHT+IHQhXPpC7w3S+OsrD9bMx3Bl7PdOgS9WEILMbAxdgTosfcsQynYpY+AL5kStwp3O5oT+MZE72YqOWeioPkEtws=
X-Received: by 2002:a05:6402:3489:b0:5cf:e240:4065 with SMTP id
 4fb4d7f45d1cf-5d0205f7449mr7488876a12.8.1732433337457; Sat, 23 Nov 2024
 23:28:57 -0800 (PST)
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
In-Reply-To: <CAGsJ_4yxuV77bR72PHs-_78qb3iud-mQ75VJAAGAsiD4ZsXP4A@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sun, 24 Nov 2024 15:28:21 +0800
Message-ID: <CAK1f24n-HW_Rp5FRXrm3nVrzz=4w2=sL_PO9aoa9F3fvL1_1aw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add per-order mTHP swap-in fallback/fallback_charge
 counters
To: Barry Song <21cnbao@gmail.com>
Cc: Wenchao Hao <haowenchao22@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Usama Arif <usamaarif642@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 3:11=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sun, Nov 24, 2024 at 2:56=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > On Sat, Nov 23, 2024 at 9:17=E2=80=AFPM Wenchao Hao <haowenchao22@gmail=
.com> wrote:
> > >
> > > On 2024/11/23 19:52, Lance Yang wrote:
> > > > On Sat, Nov 23, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.c=
om> wrote:
> > > >>
> > > >> On Sat, Nov 23, 2024 at 10:36=E2=80=AFAM Lance Yang <ioworker0@gma=
il.com> wrote:
> > > >>>
> > > >>> Hi Wenchao,
> > > >>>
> > > >>> On Sat, Nov 23, 2024 at 12:14=E2=80=AFAM Wenchao Hao <haowenchao2=
2@gmail.com> wrote:
> > > >>>>
> > > >>>> Currently, large folio swap-in is supported, but we lack a metho=
d to
> > > >>>> analyze their success ratio. Similar to anon_fault_fallback, we =
introduce
> > > >>>> per-order mTHP swpin_fallback and swpin_fallback_charge counters=
 for
> > > >>>> calculating their success ratio. The new counters are located at=
:
> > > >>>>
> > > >>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
> > > >>>>         swpin_fallback
> > > >>>>         swpin_fallback_charge
> > > >>>>
> > > >>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> > > >>>> ---
> > > >>>> V2:
> > > >>>>  Introduce swapin_fallback_charge, which increments if it fails =
to
> > > >>>>  charge a huge page to memory despite successful allocation.
> > > >>>>
> > > >>>>  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
> > > >>>>  include/linux/huge_mm.h                    |  2 ++
> > > >>>>  mm/huge_memory.c                           |  6 ++++++
> > > >>>>  mm/memory.c                                |  2 ++
> > > >>>>  4 files changed, 20 insertions(+)
> > > >>>>
> > > >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Docume=
ntation/admin-guide/mm/transhuge.rst
> > > >>>> index 5034915f4e8e..9c07612281b5 100644
> > > >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> > > >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> > > >>>> @@ -561,6 +561,16 @@ swpin
> > > >>>>         is incremented every time a huge page is swapped in from=
 a non-zswap
> > > >>>>         swap device in one piece.
> > > >>>>
> > > >>>
> > > >>> Would the following be better?
> > > >>>
> > > >>> +swpin_fallback
> > > >>> +       is incremented if a huge page swapin fails to allocate or=
 charge
> > > >>> +       it and instead falls back to using small pages.
> > > >>>
> > > >>> +swpin_fallback_charge
> > > >>> +       is incremented if a huge page swapin fails to charge it a=
nd instead
> > > >>> +       falls back to using small pages even though the allocatio=
n was
> > > >>> +       successful.
> > > >>
> > > >> much better, but it is better to align with "huge pages with
> > > >> lower orders or small pages", not necessarily small pages:
> > > >>
> > > >> anon_fault_fallback
> > > >> is incremented if a page fault fails to allocate or charge
> > > >> a huge page and instead falls back to using huge pages with
> > > >> lower orders or small pages.
> > > >>
> > > >> anon_fault_fallback_charge
> > > >> is incremented if a page fault fails to charge a huge page and
> > > >> instead falls back to using huge pages with lower orders or
> > > >> small pages even though the allocation was successful.
> > > >
> > > > Right, I clearly overlooked that ;)
> > > >
> > >
> > > Hi Lance and Barry,
> > >
> > > Do you think the following expression is clear? Compared to my origin=
al
> > > version, I=E2=80=99ve removed the word =E2=80=9Chuge=E2=80=9D from th=
e first line, and it now
> > > looks almost identical to anon_fault_fallback/anon_fault_fallback_cha=
rge.
> >
> > Well, that's fine with me. And let's see Barry's opinion as well ;)
>
> I still prefer Lance's version. The fallback path in it only needs to
> be adjusted to
> include huge pages with lower orders. In contrast, Wenchao's version feel=
s less
> natural to me because "page swapin" sounds quite odd - we often hear
> "page fault,"
> but we have never encountered "page swapin."

Yeah, it makes sense to me ~

>
> So I mean:
>
>  swpin_fallback
>         is incremented if swapin fails to allocate or charge a huge
> page and instead
>         falls back to using huge pages with lower orders or small pages.
>
>  swpin_fallback_charge
>         is incremented if swapin fails to charge a huge page and instead
>         falls back to using  huge pages with lower orders or small
> pages even though
>         the allocation was successful.

IHMO, much better and clearer than before ;)

Thank,
Lance

>
> >
> > Thanks,
> > Lance
> >
> > >
> > > swpin_fallback
> > >        is incremented if a page swapin fails to allocate or charge
> > >        a huge page and instead falls back to using huge pages with
> > >        lower orders or small pages.
> > >
> > > swpin_fallback_charge
> > >        is incremented if a page swapin fails to charge a huge page an=
d
> > >        instead falls back to using huge pages with lower orders or
> > >        small pages even though the allocation was successful.
> > >
> > > Thanks,
> > > Wencaho
> > >
> > > > Thanks,
> > > > Lance
> > > >
> > > >>
> > > >>>
> > > >>> Thanks,
> > > >>> Lance
> > > >>>
> > > >>>> +swpin_fallback
> > > >>>> +       is incremented if a huge page swapin fails to allocate o=
r charge
> > > >>>> +       a huge page and instead falls back to using huge pages w=
ith
> > > >>>> +       lower orders or small pages.
> > > >>>> +
> > > >>>> +swpin_fallback_charge
> > > >>>> +       is incremented if a page swapin fails to charge a huge p=
age and
> > > >>>> +       instead falls back to using huge pages with lower orders=
 or
> > > >>>> +       small pages even though the allocation was successful.
> > > >>>> +
> > > >>>>  swpout
> > > >>>>         is incremented every time a huge page is swapped out to =
a non-zswap
> > > >>>>         swap device in one piece without splitting.
> > > >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > >>>> index b94c2e8ee918..93e509b6c00e 100644
> > > >>>> --- a/include/linux/huge_mm.h
> > > >>>> +++ b/include/linux/huge_mm.h
> > > >>>> @@ -121,6 +121,8 @@ enum mthp_stat_item {
> > > >>>>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> > > >>>>         MTHP_STAT_ZSWPOUT,
> > > >>>>         MTHP_STAT_SWPIN,
> > > >>>> +       MTHP_STAT_SWPIN_FALLBACK,
> > > >>>> +       MTHP_STAT_SWPIN_FALLBACK_CHARGE,
> > > >>>>         MTHP_STAT_SWPOUT,
> > > >>>>         MTHP_STAT_SWPOUT_FALLBACK,
> > > >>>>         MTHP_STAT_SHMEM_ALLOC,
> > > >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > >>>> index ee335d96fc39..46749dded1c9 100644
> > > >>>> --- a/mm/huge_memory.c
> > > >>>> +++ b/mm/huge_memory.c
> > > >>>> @@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, M=
THP_STAT_ANON_FAULT_FALLBACK);
> > > >>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANO=
N_FAULT_FALLBACK_CHARGE);
> > > >>>>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> > > >>>>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> > > >>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK)=
;
> > > >>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FA=
LLBACK_CHARGE);
> > > >>>>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> > > >>>>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBAC=
K);
> > > >>>>  #ifdef CONFIG_SHMEM
> > > >>>> @@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] =
=3D {
> > > >>>>  #ifndef CONFIG_SHMEM
> > > >>>>         &zswpout_attr.attr,
> > > >>>>         &swpin_attr.attr,
> > > >>>> +       &swpin_fallback_attr.attr,
> > > >>>> +       &swpin_fallback_charge_attr.attr,
> > > >>>>         &swpout_attr.attr,
> > > >>>>         &swpout_fallback_attr.attr,
> > > >>>>  #endif
> > > >>>> @@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] =
=3D {
> > > >>>>  #ifdef CONFIG_SHMEM
> > > >>>>         &zswpout_attr.attr,
> > > >>>>         &swpin_attr.attr,
> > > >>>> +       &swpin_fallback_attr.attr,
> > > >>>> +       &swpin_fallback_charge_attr.attr,
> > > >>>>         &swpout_attr.attr,
> > > >>>>         &swpout_fallback_attr.attr,
> > > >>>>  #endif
> > > >>>> diff --git a/mm/memory.c b/mm/memory.c
> > > >>>> index 209885a4134f..774dfd309cfe 100644
> > > >>>> --- a/mm/memory.c
> > > >>>> +++ b/mm/memory.c
> > > >>>> @@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(str=
uct vm_fault *vmf)
> > > >>>>                         if (!mem_cgroup_swapin_charge_folio(foli=
o, vma->vm_mm,
> > > >>>>                                                             gfp,=
 entry))
> > > >>>>                                 return folio;
> > > >>>> +                       count_mthp_stat(order, MTHP_STAT_SWPIN_F=
ALLBACK_CHARGE);
> > > >>>>                         folio_put(folio);
> > > >>>>                 }
> > > >>>> +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK)=
;
> > > >>>>                 order =3D next_order(&orders, order);
> > > >>>>         }
> > > >>>>
> > > >>>> --
> > > >>>> 2.45.0
> > > >>>>
> > > >>
>
> Thanks
> Barry


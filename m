Return-Path: <linux-kernel+bounces-419018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D079D6899
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AB516110C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FB518953D;
	Sat, 23 Nov 2024 10:26:10 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FA17084F;
	Sat, 23 Nov 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732357570; cv=none; b=cV+9QzmTEr0HqWVDSgppaaogJTFP3NwrUES4F61uyDUfKOq15BUId9/EBY20zpeg2dr5JCfbKqhe2HKoh/sntpya68v/u485OLIDCjLMgp7QKWW4KgNT755RYM+RQ5zlWokNBCvU2UG1vmYkdPS0XiucM370z/4/1ASOP2K38r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732357570; c=relaxed/simple;
	bh=MYse441jOikI1onDBXLQyLshzo26VxR/1BRptl2uHck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlqBCnbXHq4dYMkQKAp/ka0dEDDFiuri75Es00oVIRjHi5QbDPID2hOYremB9+B7U/p+oSOmI+1JraZPXmQBY2FeR4x0Wg7Kyo5C5jwn1vgxaov2uXMZBilWL0LIcR761QX/OcqH4BX4P+Wn7rr2j5FifXewriVn3nXwhPskJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-514c3c41bafso884991e0c.2;
        Sat, 23 Nov 2024 02:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732357567; x=1732962367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWUfXqOrZo2/I4JzB9FKdD4EUvZ7gqdQ6KPKW0PSx94=;
        b=ZRFAQ3blfkJBhMUEa4W59X5gFvkj4YZ61WEcz9Lda+UH93/4/rSd+XABafiSi+rcPk
         RbV4hQD+GO3lOtO3vbL6fFdq/j5DCSzqiXZJ9oZZz47PxxbeybeoSU7Yc59LArjvEW1C
         8ySCvHd8W1DjL4Dkw9zKMD7nEQx5q9h179ToKXYDsvhH/hJLmdGif3a07llmmji219pA
         5eOHX1+AWLzYyXMnnSS8o3jGT+XTt7yk6zcvvYvyKrZmJAa0dXjCpZEp6nYZx8/eEzaG
         bpfZT31n+ecMljDqCWT7IoTX69j7OuQhmWfk3ioNtadSDpjb7V+b0o/288zxMABQd+pf
         SznQ==
X-Forwarded-Encrypted: i=1; AJvYcCULbln3yiERU6uEHz5LyiSiCMiLs5ndlTfRIzAwBwW/wbPnif1Fmcf2RzXBtWr9YgzKdYIWwO1VO+RSBwBS@vger.kernel.org, AJvYcCVcr+1r+jjZiJhoQXA11XQXROgZEmOFCgxWK1G3PdhHT+pb7r24dUgSGcelySXt+EtJD6Jt/2llYEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+2cs/4+R23dGeL2c/QPUm7V/2JFLU05l12lTzAplD+4a1adV
	XTmJdvUkR9Jupvb38RN8WG6GyLfzLsFhNVpLRSxDR8G5VpF9lGTfO/cGZDvzwz45YEHVj+9BZz6
	dX6dcTzJlf/Xf3GHI5GBeb0DtTvY=
X-Gm-Gg: ASbGnctBVz9dVRaiI6ynvU9rRWJnkReflj/l+2xBZ3tzFDa+91qnSz0sQf2+8ZQ2FDR
	YHNXLqSGFv0Ywu4RyJLIjr2KrrnUqnFoMHcNeC17d0+K5UBJ2MFjpROH4JJ9HEs3EQA==
X-Google-Smtp-Source: AGHT+IEJzdZzyU/zaYBfMHxaG78xR9zWpUSwUDkfhOQ63vKtC6AXbm4seazdiWm8jn8eO3JJ3GN533F0XKPgFPSOWe0=
X-Received: by 2002:a05:6122:2687:b0:50d:35d9:ad60 with SMTP id
 71dfb90a1353d-515007edcc6mr6450173e0c.5.1732357567428; Sat, 23 Nov 2024
 02:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122161443.34667-1-haowenchao22@gmail.com> <CAK1f24k6n1ngSicrSCv5jX+xa75t-7a3zZB4A95fUvDhteshEQ@mail.gmail.com>
In-Reply-To: <CAK1f24k6n1ngSicrSCv5jX+xa75t-7a3zZB4A95fUvDhteshEQ@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 23 Nov 2024 18:25:53 +0800
Message-ID: <CAGsJ_4zDXPzKp8Gynig8LasEmRkf6i5RxQL81Seb6cZVXfs2CQ@mail.gmail.com>
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
lower orders or small pages."

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


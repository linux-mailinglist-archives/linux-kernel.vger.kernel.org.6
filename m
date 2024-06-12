Return-Path: <linux-kernel+bounces-211650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EEE9054DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB18CB2228B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F5417DE04;
	Wed, 12 Jun 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdi/516v"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E23A17BB27
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201795; cv=none; b=Tx9kcOiunZLAqVncDR4Lz+Rg0BtK2bXABKBO7gdlezeGOBWSmC9W8xNb/KKzsyhaWTUauz+XRlfBvt+ksS8PDAh5uexKxHA65L8djSmqpLIVoa3PBEIvrSBAk0lWSRS/f4fSBN5KV/jpUij7KdQ6YmYHmDWm14e64RHr0Q1HvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201795; c=relaxed/simple;
	bh=WQWaU2XPSa7u7FY7PxELttfz2xxEozi/YyFkdxy44JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox/aZkKn2q3QbGCA+1NgsSn5jP6xQh/CspsJry+9qMfde5IVX038BCBTd88oCFaR5vsjQMM7flsjynTGrI7novjOvZ1uHQyHqc0Q98E3hN3hcYf6zM/Jh5UU6OOXUiIKlvm1TjKGppJ+tEwRM7cPbTwx5Q0uVoSGgG2LohelYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdi/516v; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so3088550a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201792; x=1718806592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXFeQu/InAtcwu283qRDGnx+2udBV3ofp/Fn0b8L8Uw=;
        b=Gdi/516v/lyCNq9XEN/ghjprrGnukQkYq3Is8xeAdoj5G2Vx7ZeqvScRaKZnZIbzfo
         3CxQWpQryC3rDH7vlQXDNoILlYiLsMUTjv7IjIUvtidzO9SZyC/PecaQnQKHIIxQmDiT
         VR0vudCatrOkAkniLO6uFA4ErBQXy2zy7NFlTWt9Wz/qvakltNT+PRxFB80EVO8qP+nH
         8QKB9N47AepXxToLAgMU+IYX5wGwvhndfluJ8khO53gUtRCksBBtG6D+A5k5E9NeXiAF
         MVuTMKp1tg6Ox69y6/t/7e6yJbJMYONPnIrQFxfF/BOiZ3hi8pCMaSxGrUBsEnyuwm20
         gj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201792; x=1718806592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXFeQu/InAtcwu283qRDGnx+2udBV3ofp/Fn0b8L8Uw=;
        b=dj2SYPTlNkyVR6qLpN192GQAYDgt1snH/WqkMh4M5bed1Je2sbeYI9sgaHH8+mJ8IB
         5Cis26D+MFT/7IsTWvdFmW5ixJT63k5b8AUFTQXEiUJ9ODDAJxz8ZaeVU3W9fEqxinf2
         3040Y2SEMbuoJVzP83wGqHfVnteXw7yPgALD7k6BEj2X1KnhV0mqxe8t9YU5ggTW3r61
         xcFP1hZ4PLLIW1dlQ28pin2T8GNzjzFkvrwWBwzPEi9HkaZzBBMNEepZxyn80sMcpNU5
         MGvHfPASHp+8Vw+fsT+nvApaWeDogaS6UZ2PRKy7CQr5m56OQKy0+asBxO0dARHsnAnE
         udug==
X-Forwarded-Encrypted: i=1; AJvYcCW/G7vI505aa1gVkdt6vSW+Cd1IRVHAvfK7fyoRdRDFLfKv6VqI2BFpIcVpPZWRuajdY6XyxxAR+Nqsmvv2d0hUBJg7sPMaiID9Bm+U
X-Gm-Message-State: AOJu0YxpMOSN+niZiVOke3/z0RlejqQIjeUL4NXs2SVxwMcTGzS2CSQp
	WUYE2dROasbNsezpnBf24MeG6fOGpaOFNIZ8DvoSvlviocbzLzfuQv+soPmmHrDprpPjbucF/76
	+MaYifNzpH/bNC8kJloe9/1l/66I=
X-Google-Smtp-Source: AGHT+IHW/hXJG+TBumCiBmHqhgd87pgriARFMrlfHwt20rM+xtCGUrKlVfeGKfk0StJxgwQF6b7D2BSQv+6WeSAyOU8=
X-Received: by 2002:a50:9308:0:b0:57c:947c:f9cf with SMTP id
 4fb4d7f45d1cf-57ca975348cmr1205743a12.11.1718201792124; Wed, 12 Jun 2024
 07:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
 <CAK1f24=Rz4qPyw9pfTHTAuQO6Yv9mFHccjCd75a0kvHvCBH3uA@mail.gmail.com> <df06474c-110f-459d-a093-76074e0b5666@linux.alibaba.com>
In-Reply-To: <df06474c-110f-459d-a093-76074e0b5666@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 12 Jun 2024 22:16:20 +0800
Message-ID: <CAK1f24=4tNTvT0Kr2wuERe11M1ZkYorv9rTNTtehOFmGSSt+Nw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: shmem: add mTHP counters for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com, 
	21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:28=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/6/12 16:04, Lance Yang wrote:
> > Hi Baolin,
> >
> > On Tue, Jun 11, 2024 at 6:11=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >> Add mTHP counters for anonymous shmem.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>   include/linux/huge_mm.h |  3 +++
> >>   mm/huge_memory.c        |  6 ++++++
> >>   mm/shmem.c              | 18 +++++++++++++++---
> >>   3 files changed, 24 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 909cfc67521d..212cca384d7e 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -281,6 +281,9 @@ enum mthp_stat_item {
> >>          MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>          MTHP_STAT_SWPOUT,
> >>          MTHP_STAT_SWPOUT_FALLBACK,
> >> +       MTHP_STAT_FILE_ALLOC,
> >> +       MTHP_STAT_FILE_FALLBACK,
> >> +       MTHP_STAT_FILE_FALLBACK_CHARGE,
> >>          __MTHP_STAT_COUNT
> >>   };
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 1360a1903b66..3fbcd77f5957 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -555,6 +555,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_ST=
AT_ANON_FAULT_FALLBACK);
> >>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAU=
LT_FALLBACK_CHARGE);
> >>   DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> >>   DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> >> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> >> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> >> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_C=
HARGE);
> >>
> >>   static struct attribute *stats_attrs[] =3D {
> >>          &anon_fault_alloc_attr.attr,
> >> @@ -562,6 +565,9 @@ static struct attribute *stats_attrs[] =3D {
> >>          &anon_fault_fallback_charge_attr.attr,
> >>          &swpout_attr.attr,
> >>          &swpout_fallback_attr.attr,
> >> +       &file_alloc_attr.attr,
> >> +       &file_fallback_attr.attr,
> >> +       &file_fallback_charge_attr.attr,
> >>          NULL,
> >>   };
> >>
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index f5469c357be6..99bd3c34f0fb 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -1773,6 +1773,9 @@ static struct folio *shmem_alloc_and_add_folio(s=
truct vm_fault *vmf,
> >>
> >>                          if (pages =3D=3D HPAGE_PMD_NR)
> >>                                  count_vm_event(THP_FILE_FALLBACK);
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +                       count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK=
);
> >> +#endif
> >
> > Using the conditional compilation directives here is a bit weird :)
> > Would there be any issues if we were to drop them?
>
> Will cause building errors if CONFIG_TRANSPARENT_HUGEPAGE is not enabled.

Sorry, I got it wrong :p

>
> >
> > Since THP_FILE_FALLBACK is working as expected, MTHP_STAT_FILE_FALLBACK
> > should work as well without the conditional compilation directives, IIU=
C.
>
> No, you should take a look at how count_mthp_stat() is defined :)

You're correct. count_mthp_stat() does cause a compilation error without th=
em
when CONFIG_TRANSPARENT_HUGEPAGE is not defined.

Thanks,
Lance


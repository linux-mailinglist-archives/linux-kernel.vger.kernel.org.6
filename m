Return-Path: <linux-kernel+bounces-305720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9896335D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07D41F21B81
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919CE1AC89F;
	Wed, 28 Aug 2024 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI8p9cA+"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB6158A26
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878975; cv=none; b=DOS3/PH5j19IRiNQfjYFHelnehJs1fWywkZsIz10UlijVzX8eQPtqUUCDUyUQaVa4ipmtx9gspDzqGM0rGvVkMltsoHAIeFIXilPoplFySldBNcTuOriFmDu+rsDRSuw8t7whI545RNd4LWmJm1QAkLA2bhuSOpzU83T6pkRA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878975; c=relaxed/simple;
	bh=mJRgKkDiz+7y4GSw46vtKeS0O1aFErkLK7gJELgpE74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYE8XU81XfFHx4XPSLDNVLJthvU5NNiEY0OT1muhc+ATXorUOZOdyGq5gKEWYJHMGjUTP/hh9q1VICpsCyNLOb/Q9D9IvOGI/2dRjS43o2L1NlrLIAoCENsY+1IQZ2AGkChdDqrLyBrcRvxCkTOxo8qwQRikbfE++vBY7hGqgZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI8p9cA+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so8234427a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878972; x=1725483772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCaH1KaRawGByB0NtRqHaeIEYFf5awkEOY5yS4shy5k=;
        b=PI8p9cA+f//Yb/InNSG4kqvq5IO0SxMNQbzTBa9hkMiuhLEJQwOiBRpanDRZjmlWbP
         CXTQJFyQKe8AWf17sQFqU0hFRED7LPb1mSnRPcUWHUHUFC4IMi0MZi8nxEdjyPChlOVP
         96x2K1zE5H8Ovps4Z0Z56eQRzb6lGe1clDxZ8EECeSZbqBd2X3Rz1s11b61OtTrNMOyY
         /u3+lT04wFCQp32nm8h2bqvcoamox/Kigv2KKKDXKF3Vm2vpg1rF3FntMpPCDNNiwsx4
         PQm5dZF0QE5So91xUksoJwAuNFz1Uf2VpesdnVCwLOedBQBb4633/KVwiJ3YEQuIzGAC
         rRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878972; x=1725483772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCaH1KaRawGByB0NtRqHaeIEYFf5awkEOY5yS4shy5k=;
        b=w0ZK6csi7pRVgCeaLx3wNkHPMUCD4YTVGHjL679rTqSV1aoQSxrcVZe3/nuNv0PuZl
         /b2hQTBj/ck2WR5J4re2+DvRdT60BITmGvRYI9SgvNI9qM2XzLYI+0O4jRYWG6Ue8vf2
         twzdYbc50+jfUL7uAmhBPRVosP8xCPooWQ6oWkyPPF8GYcBlCAt+l6QVR7ASmywvgSHw
         LchQ3j0n1D8VB3cID1peR91aMiRlwOJLujbWDzZIhHKLuHrAZTVZm2dOjc69nPImk9bj
         vtkAflM7Yc4LTb2PHDZQjdocc9vAMdbjbg/srzyArvpcEYJByX0elNJZjooxikrDv5W+
         gJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCWPa2eXtvwFfY5R8qz62vTvTMgx2wWHv8p7fvYgQZbYOIZ7j9Y48OXIeF2eWoOVqgkc0TANz98W9H7KT3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7D0jPI1EhLYpgbbjYcD8vPuIRRigNbB/g7RUumKl9sqgA3fRT
	fWOHa+CNg2p3ZhZE6TWFCXuR1Sx/ZbvZAOmuugMkAAbXj8L7ZfdgkEPoMOQHMhIi9cUlE6ScBeL
	GNTxSLJQTOuhzAj5ZYDl7QxnXjGFd3yuV
X-Google-Smtp-Source: AGHT+IFhHK8zbeXAR3a4yCGVr6+EUruQt5vkVACUuRVky5v8fzuR+SJIDe3mMrBw7+3ZADyklUCu9NrrA7X2w/xWhEY=
X-Received: by 2002:a17:907:3ea2:b0:a7a:cc10:667c with SMTP id
 a640c23a62f3a-a897f835ca1mr52551166b.16.1724878971928; Wed, 28 Aug 2024
 14:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828160704.1425767-1-mjguzik@gmail.com> <20240828124929.db332259c2afad1e9e545b1f@linux-foundation.org>
 <CAGudoHE73o5oK77iOFKqH4D4Cz6t9TAu4882+_F9vHH7muNH-A@mail.gmail.com> <20240828134435.443d7f7ec65eba1db4436434@linux-foundation.org>
In-Reply-To: <20240828134435.443d7f7ec65eba1db4436434@linux-foundation.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 28 Aug 2024 23:02:39 +0200
Message-ID: <CAGudoHH3hFu=7_ouHz+HY8djBxZj3-Zw30gE-F0H_2t1=sv_0A@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: sort out global lock annotations
To: Andrew Morton <akpm@linux-foundation.org>
Cc: muchun.song@linux.dev, dave@stgolabs.net, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:44=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 28 Aug 2024 22:13:49 +0200 Mateusz Guzik <mjguzik@gmail.com> wrot=
e:
>
> > > It's conventional (within MM, at least) to put the section thing at t=
he
> > > end of the definition, so tweak:
> > >
> > > --- a/mm/hugetlb.c~mm-hugetlb-sort-out-global-lock-annotations-fix
> > > +++ a/mm/hugetlb.c
> > > @@ -72,14 +72,14 @@ static unsigned int default_hugepages_in
> > >   * Protects updates to hugepage_freelists, hugepage_activelist, nr_h=
uge_pages,
> > >   * free_huge_pages, and surplus_huge_pages.
> > >   */
> > > -__cacheline_aligned_in_smp DEFINE_SPINLOCK(hugetlb_lock);
> > > +DEFINE_SPINLOCK(hugetlb_lock) __cacheline_aligned_in_smp;
> > >
> >
> > I tried things in this order and this does not compile for me:
> > In file included from ./arch/x86/include/asm/current.h:10,
> >                  from ./arch/x86/include/asm/preempt.h:7,
> >                  from ./include/linux/preempt.h:79,
> >                  from ./include/linux/spinlock.h:56,
> >                  from ./include/linux/mmzone.h:8,
> >                  from ./include/linux/gfp.h:7,
> >                  from ./include/linux/mm.h:7,
> >                  from mm/hugetlb.c:8:
> > ./include/linux/cache.h:80:3: error: expected =E2=80=98,=E2=80=99 or =
=E2=80=98;=E2=80=99 before =E2=80=98__attribute__=E2=80=99
> >    80 |   __attribute__((__aligned__(SMP_CACHE_BYTES),                 =
 \
> >       |   ^~~~~~~~~~~~~
> > ./include/linux/cache.h:86:36: note: in expansion of macro =E2=80=98__c=
acheline_aligned=E2=80=99
> >    86 | #define __cacheline_aligned_in_smp __cacheline_aligned
> >       |                                    ^~~~~~~~~~~~~~~~~~~
> > mm/hugetlb.c:75:31: note: in expansion of macro =E2=80=98__cacheline_al=
igned_in_smp=E2=80=99
> >    75 | DEFINE_SPINLOCK(hugetlb_lock) __cacheline_aligned_in_smp;
> >       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Well that's annoying.  It's because DEFINE_SPINLOCK includes an initializ=
er.
>
> --- a/mm/hugetlb.c~mm-hugetlb-sort-out-global-lock-annotations-fix-fix
> +++ a/mm/hugetlb.c
> @@ -72,7 +72,7 @@ static unsigned int default_hugepages_in
>   * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_=
pages,
>   * free_huge_pages, and surplus_huge_pages.
>   */
> -DEFINE_SPINLOCK(hugetlb_lock) __cacheline_aligned_in_smp;
> +spinlock_t hugetlb_lock __cacheline_aligned_in_smp =3D __SPIN_LOCK_UNLOC=
KED(hugetlb_lock);
>
>  /*
>   * Serializes faults on the same logical page.  This is used to
> _
>
> We'd need a new DEFINE_SPINLOCK_ALIGNED() or something.
>
> Ho hum, I'll fix.

that would be a nice addition

so as is this triviality grew to 3 patches which I consider rather
extreme, and the middle one breaks the build

In the vfs land this would get squashed into one commit with a
maintainer note that some tweaking was performed, which I would
suggest here

alternatively, given the trivial nature of the entire thing, if you
add DEFINE_SPINLOCK_ALIGNED and do the annotation tweak, you may as
well commit this as your own patch. I don't need any credit

--=20
Mateusz Guzik <mjguzik gmail.com>


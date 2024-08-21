Return-Path: <linux-kernel+bounces-296203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2048195A786
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD02E281624
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A28176FAC;
	Wed, 21 Aug 2024 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7b4frfv"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFB2B9AF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277693; cv=none; b=VpCl/zEFrKjeewYzmgt1N5ZVgO21r1XmPSX4fPtWlryScKS/cXfqX3eYdCKXRSg/HDhpaXWTx/LkaIjkeHJsYtUcVdY9/YYT/fDGi85DNUuZrSU8dFdgNjunQlFFKDNbRioM2qYMpat83c5cx3i//OVM4Hv8JhB4jMOpflqsLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277693; c=relaxed/simple;
	bh=bXm/m9iOBvNenEQp2YgLjG2WHpwSnrGrk3UlJYlTHQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aj2f9eTV7ZHfsj2bjzfGnkPWIb/fTqsrZQM47z4X49E/wh027j3xL9ZRYS3lzDKMipDJXIDVoRmqGAkuT59WOhqBs+ondT61DVHWthPLgTGB6bsPxUC5diZt6Ww7NiEfIWKFv9QxYMLfj0wHA9M1Sr+Rd8Udn602Jtdjbs3Vgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7b4frfv; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-842f95b73daso65414241.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277690; x=1724882490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xiDXoQEA5WD8m2OrzH2w9aiIuJAwD4Zi8v/UbhlaFY=;
        b=c7b4frfv4IAb1N39Db0H7MDa+GFcEnhgkH+R1OGi4+8bChRjT3MNa+rUsYJ5T6zDJs
         xK8U1OzUDGZpn70VkO99AkyEb41Ntd1Uc7+awnxWJEXpm8ZNusBJ3Sb3cVn2IfxZZkLR
         59ccXhJJyaYGlyqPuIoR9j4kZ+8xigx/pMxqqbdXCji036e/LwQ/7itqEpzRpqhWG9Zm
         NhVmrElgsjqrleMf9FsLTfpQOfgh0u/ECYlCCehyZtn//K7+f47DILPXJDvxd/zRgK9G
         GJLUDmY6ZG2+vKoJT7t93BPLTIrRoyPgTTUP5fQFaLPzpnEjbCxlz8+7DkwpWODn0d6K
         7q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277690; x=1724882490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xiDXoQEA5WD8m2OrzH2w9aiIuJAwD4Zi8v/UbhlaFY=;
        b=FXL1lCKkVOt1XEDELboPHsQxMVrEUmvgCvUvYDJb3fhMUv+jUGvW9AHi01mZTrOL9Z
         Nim8e6UpmCKaOf4QkMFd4sDAo42adHS3voWX6CBM17891NXPUwgU4MEB+azfhjSswx2b
         +4CAiNkY8KkZSxK4aGU7wsZo3hCZsHSsbE0XBlEMEsn6MnrfetOmAhSdvswflIUaGiNM
         057Jm1mMD2FRBGOkc/xIfwtS/PPBWVUB7pfkxL13xmiPFunWgyLwIsZ4r2oqSzFEV9RI
         b50W1bnbn/RhXSRMXMvcDJhLe5p2SQqIfEkZW+pkLd46OwYtGtW//Dc+px1qvUOecTBP
         6Y0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjgcYrrMGR63zm1PJi2CFYmGmwyqFxMBsV5i06+r0vlx0KYXeF2o2ml952mOMln+TZ5nYCXalAFlTKNJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTasofiXMjh4XIow/hsqhA8ZstQBdsH62bohPgWvrUNDQuInv
	EHOYiGwkrW4agZwZkQ8wHGwSGpn6SQAF8C/A9FuvMr5Na6fDG1NvM0FPmhtl+0epxKsHOakPxLX
	HRKTqti5e9rXXNV6w3kob7tst/s0E/GpY
X-Google-Smtp-Source: AGHT+IFl8/Nb4/OFNkFzwnNqwpdgtU6aBk7AbiBON0n9ZJpFmcLJSZBOlkh2SIwm32Xg/4M/9Vjj7Hd1sF1x64Fe0GU=
X-Received: by 2002:a05:6122:1806:b0:4f5:12d3:799a with SMTP id
 71dfb90a1353d-4fcf359a7b0mr5076941e0c.2.1724277690161; Wed, 21 Aug 2024
 15:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811224940.39876-1-21cnbao@gmail.com> <20240811224940.39876-3-21cnbao@gmail.com>
 <6c01b794-7c51-4d90-a215-210ac21401d2@redhat.com>
In-Reply-To: <6c01b794-7c51-4d90-a215-210ac21401d2@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Aug 2024 06:01:17 +0800
Message-ID: <CAGsJ_4x4ngLS4kW-e7_DTykZSAmk3DeQ6CuZ4zGEiGBd99fbrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: collect the number of anon large folios on
 split_deferred list
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ziy@nvidia.com, yuanshuai@oppo.com, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:39=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.08.24 00:49, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When an mTHP is added to the deferred_list, its partial pages
> > are unused, leading to wasted memory and potentially increasing
> > memory reclamation pressure.
> >
> > Detailing the specifics of how unmapping occurs is quite difficult
> > and not that useful, so we adopt a simple approach: each time an
> > mTHP enters the deferred_list, we increment the count by 1; whenever
> > it leaves for any reason, we decrement the count by 1.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   Documentation/admin-guide/mm/transhuge.rst | 5 +++++
> >   include/linux/huge_mm.h                    | 1 +
> >   mm/huge_memory.c                           | 6 ++++++
> >   3 files changed, 12 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 9fdfb46e4560..7072469de8a8 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -532,6 +532,11 @@ nr_anon
> >          These huge pages could be entirely mapped or have partially
> >          unmapped/unused subpages.
> >
> > +nr_split_deferred
> > +       the number of anon huge pages which have been partially unmappe=
d
> > +       and put onto split queue. Those unmapped subpages are also unus=
ed
> > +       and temporarily wasting memory.
>
> The name suggests something else ... like a counter of how many have
> been deferred split :)
>
> Would "nr_anon_partially_mapped" "nr_anon_split_pending" (or something
> less mouthful) be clearer?
>
> (likely "anon" really should be part of the name in any case)
>
> The name we chose (and the implied semantics) will likely have
> implications on the handling of Usamas series.
>

Hi David,

Your point is quite similar to my V1, though not exactly the same. I aimed =
to
make the name more meaningful for users.
https://lore.kernel.org/all/20240808010457.228753-3-21cnbao@gmail.com/

Ryan felt that the name should be consistent with the existing split_deferr=
ed.
https://lore.kernel.org/all/36e8f1be-868d-4bce-8f32-e2d96b8b7af3@arm.com/#t

It seems that the existing split_deferred may now be less optimal with
Usama's series, as entirely_mapped folios might also be on the list.

Ryan is out right now, but I suppose he will be convinced that
"nr_anon_partially_mapped" is probably a better name once
he returns and reviews Usama's series. :-)

> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry


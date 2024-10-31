Return-Path: <linux-kernel+bounces-390161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA69B7649
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985D91C2137C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83086154445;
	Thu, 31 Oct 2024 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpKYTvTC"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9D14884D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362898; cv=none; b=kPbKMAv53TuJcOwEtrNk3pqR2aa5Vc70CvuxyWx8VyXJZbohSYQjqkVCUjxwn9+Cidm0fkNh6oYZbbCwIfm4tzqiNac65vpuO4GA2QEMi2Q1qrDzvBVCSdn0+nBUhsNQTfUXgtU/ktuADLBQmP/eKn89Vs99xX2EVNoF4oETaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362898; c=relaxed/simple;
	bh=cVk2LaTJQkMtF4GkdSD4SJ65LCQe1sWWcaigaF/n020=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqeluDhaRqDFFC3mbbvVY4s9slnEhH83GcS+1YrQqTdc6hYlw+mb6+qePgHhMEau5GIxcBzmF/ikp3jaq8awb7TaRe3hkCV8tf16zsiAzt7By3rrsEorNuqb5WA0pfj1/NGcHDdd0ZJGH1irfGH/6ojIldlAKffHITmQpwbhe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpKYTvTC; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50d58e5bfd2so215883e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730362895; x=1730967695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDCd5xrXH973PgUiiNflQUyEcb5wHDWnzkZRvUd+oi8=;
        b=HpKYTvTCDl7yNsfxIkFTnWsUcgEbOlzKJVgfzmLftShKpeef/ievRbbww3GoRD+pTC
         uYUDO6i2hYz8QlkUxDrkDgur5rOGfnwgjXuX5Avmfcx7YJrCPzt8oTvZFFhjlPKhBYpw
         e7BsypCJthXziWlooLsk4WAzbcrLwyctWuekgSbmgz6/zEkbnEIXsWTKyuBZIPlH11lp
         ODwCpDUW1R9FweTFpXKbQTK6Nik3s4KAMrh+l6jetYlA3GwS8h2/mbBDaihdvXxvRSA3
         Cy+Rzwnqshk5CkUNrXzWExC20CKRHGqUevnRFLx80IvAfxbhDaCCPxfBM/1IwatNIUCn
         Z/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362895; x=1730967695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDCd5xrXH973PgUiiNflQUyEcb5wHDWnzkZRvUd+oi8=;
        b=OKz5qvsi3bwyKG3Dkb2CRkVq2R5pWQGeSTRbHhJMOOeOg8vNs/9Eqw2cAOI2RKGuie
         5YxNWfOmOpDewmHqM98Kk7T05ef/al92iaeCliXaFNEKBMngUkoNxGMNXKEKjJVDhgvz
         25Pmhbbl0Osn6GBrHwfljgMdO/j1FxoeniXFsNVhgyX341TLqxSCdT6aKSW1hMCXann7
         yEik32oPhJZ+py9WvYyqNQsJfK9rytRcRFqEPGVXPGcVf2lRruGlCuDmPWq3tEELZDtZ
         Kxw8/afpvRFLB2xPOAaTgc2H151ALeF2QXA4l2o30AFzOWCgEIPa5kk3C02y2AJXBlf0
         8awg==
X-Forwarded-Encrypted: i=1; AJvYcCX9AldeQkq8h1gtK0UHzk7WH9wxS0KX0bcb+bbLwhIohQN9ZS5uJTeEkFeTXZdNdyZmwQ49IFFg5Z3F1KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpO6KZ/juEdNqMpqHZLGGriZc0ag6x0m6VEDBTNVUf4iC0j2R+
	7Rja3AGpDTQhHrSX0QIVjIqT0atdefh94xh1e8fm2rsXC+XVsuy5VwhI0iRzAXVQDCcsL1rW/3y
	7GqYpw2cafARXfY6tMhCEQTXiBIs=
X-Google-Smtp-Source: AGHT+IEn7Nd7ktAUrffEigFShW9caWs2hR3+bx+Dz4T79PlwM4rCw499HvHwxgNBR3sCJohjZn8lLZsE2VH4HLp8zOE=
X-Received: by 2002:a05:6122:8003:b0:4fc:e3c2:2c71 with SMTP id
 71dfb90a1353d-51014ff7a65mr14179081e0c.2.1730362895459; Thu, 31 Oct 2024
 01:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031075325.1037-1-21cnbao@gmail.com> <874j4sae8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874j4sae8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 31 Oct 2024 21:21:24 +1300
Message-ID: <CAGsJ_4yoH2qVpiVmYhYH6WTN4yueQ4yYw+P-CG4Q-dKjc9VVRQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add per-order mTHP swpin counters
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:09=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > This helps profile the sizes of folios being swapped in. Currently,
> > only mTHP swap-out is being counted.
> > The new interface can be found at:
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin
> > For example,
> > $ cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
> > 12809
> > $ cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
> > 4763
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > Cc: Usama Arif <usamaarif642@gmail.com>
> > ---
> >  -v3: minor refine changelog per Huang, Ying. thanks!
> >
> >  Documentation/admin-guide/mm/transhuge.rst | 4 ++++
> >  include/linux/huge_mm.h                    | 1 +
> >  mm/huge_memory.c                           | 3 +++
> >  mm/page_io.c                               | 3 +++
> >  4 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 2a171ed5206e..5caa3fb2feb1 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -534,6 +534,10 @@ zswpout
> >       is incremented every time a huge page is swapped out to zswap in =
one
> >       piece without splitting.
> >
> > +swpin
> > +     is incremented every time a huge page is swapped in from a non-zs=
wap
> > +     swap device in one piece.
> > +
> >  swpout
> >       is incremented every time a huge page is swapped out to a non-zsw=
ap
> >       swap device in one piece without splitting.
>
> In Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage, I
> found
>
> "
> What:           /sys/kernel/mm/transparent_hugepage/
> Date:           April 2024
> Contact:        Linux memory management mailing list <linux-mm@kvack.org>
> Description:
>                 /sys/kernel/mm/transparent_hugepage/ contains a number of=
 files and
>                 subdirectories,
>
>                         - defrag
>                         - enabled
>                         - hpage_pmd_size
>                         - khugepaged
>                         - shmem_enabled
>                         - use_zero_page
>                         - subdirectories of the form hugepages-<size>kB, =
where <size>
>                           is the page size of the hugepages supported by =
the kernel/CPU
>                           combination.
>
>                 See Documentation/admin-guide/mm/transhuge.rst for detail=
s.
> "
>
> So, Documentation/admin-guide/mm/transhuge.rst will be used as ABI
> document?

Yes. this follows:

sysfs-kernel-mm-hugepages:              See
Documentation/admin-guide/mm/hugetlbpage.rst for details.
sysfs-kernel-mm-ksm:            See Documentation/mm/ksm.rst for more
information.
sysfs-kernel-mm-transparent-hugepage:           See
Documentation/admin-guide/mm/transhuge.rst for details.


>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

Thanks
barry


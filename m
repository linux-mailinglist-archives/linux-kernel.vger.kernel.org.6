Return-Path: <linux-kernel+bounces-391389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F39B860B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517C01C219D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB381D12E7;
	Thu, 31 Oct 2024 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqMLNFGa"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2E13AD32;
	Thu, 31 Oct 2024 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412984; cv=none; b=KPMiISdcaEYikwrSholMjBi8qvJVHkXT5nFaLdoDVqKqj1RX/6ok7kLJz626d4qNHEw2wABerBTm+GiXysngmEopuIm1/mQyL9LgtvisjqUWj6hwnNAIP6gDUs5YAn9d1Q8HNVo0P8B8vf8z5Cps8p1SysKvO1KNmnwPcZrdPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412984; c=relaxed/simple;
	bh=xGj6SyYTGlSmaOCg9dZ12pTsR/xuCvN9gVBYeO7XoxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4AlNe/8PiFJNBL28qxrRl1QNYMW8b+G9R1ABHVtlllzSDJUMlGKVNLGd91Qsqy5a46T0qynjYzi+5+6ubwpYZ1O5ny5LYU5Fo+K+s8OMH+Q/vF9vkAw2yLAa5i4WmXObKXQxEzHWSMR3tCOKcy7A+6xEACTF8E5dENbz+dwvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqMLNFGa; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fcb020503so632264241.0;
        Thu, 31 Oct 2024 15:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412976; x=1731017776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At8ovDf+5lHEpcARWPf57j7UUROFTNc1zmMWeWGQGKU=;
        b=OqMLNFGaKLGZAvCgQ9F7d/H9bEhrZYVVN1EyIIrBGDTy0L5RnLXU4P7bIY4XcZHgMR
         zNZQEP0zwgeFHPlUvI0s8kYMn957jJpJlLO6CJCodZbxbpIGprVp7VlrJTjTMNWWsHyz
         ogAUXuDKsPA22jnDhCx1LO0V8gljSE+0ZTeBMZVtwi1zm1vdt6bWk/bkkrbGNoP+191v
         J4HDU/A5Q4C1PBoXNHIzqKkv4tIH2UdPNBOrnTHS07F6ldOgkYwVwU0BrCSlZDjIhjtl
         yCFRvBA7YiZQPEHaK22XsSbzPjLneAhvmn44H+dcRKKZSlDs6ewYZ4qwcEwotOjqvn92
         Ieiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412976; x=1731017776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At8ovDf+5lHEpcARWPf57j7UUROFTNc1zmMWeWGQGKU=;
        b=UauYDuYWDqJtMtIPfxQwaKr32GkvA0jy67ubGtIxc85nJ3DHkjMfw5NII3hoFDKnJ+
         1wJzjLIWKLya+0h9m9cys8q6hBOEEiLyxErlv/MEh9wQgVAXvQHeJg9Zo85Mcq1/QeEi
         7F8M9VMFSr4bk7tq+9rTDN7KFdrp7UopsAhkhWcgVdDLdMY8pv9zJ36KwyiPPITEWVRE
         SUlHL35xQsTP4waPyCDCrMQ1BifbVSA+FmnaUCnIs9Nb3FFT1n2GzU33HlHoA5k/fWuO
         DUbQv2ScWV/BnsDwiWMoDJAUatkC1I1oRrTS6crm41OgbYELpTEM0x6/MuATETmH68ch
         r4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVghEUMucnzzUT+L+wc5JIaOl5J0GSbHqfsKDGNrYQVUTkH6EwAcTuFU1IHMHXa/KIPC+OY6mLIwKg=@vger.kernel.org, AJvYcCXEsoS3EvKSaDB4vHNiv60UQX840Sf8a4PBjqR8PujNyn4pkfj38lf2Y5IsMZWdZVdNyo5y/efIZZPXsJ3w@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDiw4wvFFybg3VBi0QICuHp4bxdmexHWGVhVdsRnEfx4Dk1pV
	4VMyqCMWPc+1U4ZBWP3dkz9/3b3Mv8UpogndeV9p6zwDcJdoz8T3DZ5BYEil+028NCqfe9CbD2r
	BqxxmeKVcgeHwiNPZmtzsY0t8VNs=
X-Google-Smtp-Source: AGHT+IF5s362VZFuoEzcTPgJzHq2ZjpzoixUU5YIbWzRRZOjmbUvgPZkiYW1zW66g2j1XaM34aY6EiLzimNFpcj7x/8=
X-Received: by 2002:a05:6102:14a1:b0:4a4:77c7:9471 with SMTP id
 ada2fe7eead31-4a961b0577amr2292088137.5.1730412976254; Thu, 31 Oct 2024
 15:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030130308.1066299-1-mcanal@igalia.com> <20241030130308.1066299-4-mcanal@igalia.com>
 <2c507326-3267-431e-936a-23e2ab6a3baf@redhat.com> <899284fa-953f-48a1-af29-222d0d55881c@igalia.com>
 <cfcfaed5-8612-46f4-b3dd-67e1d81d049f@redhat.com> <95c48a30-0696-4110-950e-e81afb4ffc2a@igalia.com>
 <5745d2ca-4d87-4d1f-b38f-734c7086f462@redhat.com> <d65176f1-df6f-4e21-b281-469ec958f26f@igalia.com>
 <CAGsJ_4zObE7hsFangzmKK0c6wZ7xZS3fCEYdx5W6HkAHqcP20g@mail.gmail.com> <ec69b1ee-89f4-47d2-a223-f277b7aad76b@redhat.com>
In-Reply-To: <ec69b1ee-89f4-47d2-a223-f277b7aad76b@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 1 Nov 2024 11:16:05 +1300
Message-ID: <CAGsJ_4wMZbRAYDzu9QVZDeu2WS9zfLH4r9yVqXHu2UsZiG0RKQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: shmem: override mTHP shmem default with a
 kernel parameter
To: David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:39=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 31.10.24 22:12, Barry Song wrote:
> > On Fri, Nov 1, 2024 at 3:20=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.=
com> wrote:
> >>
> >> On 31/10/24 10:33, David Hildenbrand wrote:
> >>> On 31.10.24 14:24, Ma=C3=ADra Canal wrote:
> >>>> Hi David,
> >>>>
> >>>> On 31/10/24 09:57, David Hildenbrand wrote:
> >>>>> On 31.10.24 13:51, Ma=C3=ADra Canal wrote:
> >>>>>> Hi David,
> >>>>>>
> >>>>>> On 31/10/24 09:37, David Hildenbrand wrote:
> >>>>>>> On 30.10.24 13:58, Ma=C3=ADra Canal wrote:
> >>>>>>>> Add the ``thp_shmem=3D`` kernel command line to allow specifying=
 the
> >>>>>>>> default policy of each supported shmem hugepage size. The kernel
> >>>>>>>> parameter
> >>>>>>>> accepts the following format:
> >>>>>>>>
> >>>>>>>> thp_shmem=3D<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-
> >>>>>>>> <size>[KMG]:<policy>
> >>>>>>>>
> >>>>>>>> For example,
> >>>>>>>>
> >>>>>>>> thp_shmem=3D16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:n=
ever;4M-8M:within_size
> >>>>>>>>
> >>>>>>>> By configuring the default policy of several shmem hugepages, th=
e
> >>>>>>>> user
> >>>>>>>> can take advantage of mTHP before it's been configured through s=
ysfs.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >>>>>>>> ---
> >>>>>>>>      .../admin-guide/kernel-parameters.txt         |  10 ++
> >>>>>>>>      Documentation/admin-guide/mm/transhuge.rst    |  17 +++
> >>>>>>>>      mm/shmem.c                                    | 109 +++++++=
++++++
> >>>>>>>> ++++-
> >>>>>>>>      3 files changed, 135 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>>>>>>> index dfcc88ec6e34..c2299fa0b345 100644
> >>>>>>>> --- a/mm/shmem.c
> >>>>>>>> +++ b/mm/shmem.c
> >>>>>>>> @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_alway=
s
> >>>>>>>> __read_mostly;
> >>>>>>>>      static unsigned long huge_shmem_orders_madvise __read_mostl=
y;
> >>>>>>>>      static unsigned long huge_shmem_orders_inherit __read_mostl=
y;
> >>>>>>>>      static unsigned long huge_shmem_orders_within_size __read_m=
ostly;
> >>>>>>>> +static bool shmem_orders_configured __initdata;
> >>>>>>>>      #endif
> >>>>>>>>      #ifdef CONFIG_TMPFS
> >>>>>>>> @@ -5027,7 +5028,8 @@ void __init shmem_init(void)
> >>>>>>>>           * Default to setting PMD-sized THP to inherit the glob=
al
> >>>>>>>> setting and
> >>>>>>>>           * disable all other multi-size THPs.
> >>>>>>>>           */
> >>>>>>>> -    huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
> >>>>>>>> +    if (!shmem_orders_configured)
> >>>>>>>> +        huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
> >>>>>>>>      #endif
> >>>>>>>>          return;
> >>>>>>>> @@ -5180,6 +5182,26 @@ struct kobj_attribute
> >>>>>>>> thpsize_shmem_enabled_attr =3D
> >>>>>>>>      #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
> >>>>>>>> +static inline int get_order_from_str(const char *size_str)
> >>>>>>>> +{
> >>>>>>>> +    unsigned long size;
> >>>>>>>> +    char *endptr;
> >>>>>>>> +    int order;
> >>>>>>>> +
> >>>>>>>> +    size =3D memparse(size_str, &endptr);
> >>>>>>>> +
> >>>>>>>> +    if (!is_power_of_2(size))
> >>>>>>>> +        goto err;
> >>>>>>>> +    order =3D get_order(size);
> >>>>>>>> +    if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
> >>>>>>>> +        goto err;
> >>>>>>>> +
> >>>>>>>> +    return order;
> >>>>>>>> +err:
> >>>>>>>> +    pr_err("invalid size %s in thp_shmem boot parameter\n",
> >>>>>>>> size_str);
> >>>>>>>> +    return -EINVAL;
> >>>>>>>> +}
> >>>>>>>
> >>>>>>> Hm, mostly copy and paste. You could reuse existing
> >>>>>>> get_order_from_str()
> >>>>>>> simply by passing in the supported orders and moving error
> >>>>>>> reporting to
> >>>>>>> the caller.
> >>>>>>>
> >>>>>>
> >>>>>> Can I use functions from mm/huge_memory.c here?
> >>>>>
> >>>>> Yes, that's the idea.
> >>>>>
> >>>>
> >>>> Unfortunately, it isn't possible without adding the function to a
> >>>> header.
> >>>
> >>> Well ... sure, what's the problem with that?
> >>
> >> David & Barry, how do you feel about adding `get_order_from_str()` to
> >> lib/cmdline.c?
> >
> > I'd vote to leave it as is. If, at some point, the controls for shared =
memory
> > and anonymous memory are moved to a file, that would be the right time
> > to call the same get_order_from_str() for both.
>  > > This is too trivial to warrant being an exposed API in huge_memory.h
> > or cmdline.
>
> I ... don't quite agree. cmdline.c is probably a bit excessive and I
> wouldn't suggest that at this point.
>
> This seems like a reasonable helper function to have as inline in
> mm/internal.h.

For get_order_from_str() specifically, I agree that it's fine to keep
it in internal.h,
as it could be considered a general need. However, anything larger than tha=
t
in parse bootcmd seems too trivial and not general enough to qualify as an =
API.

>
> ... unless I am missing something important and the obvious code
> duplication is warranted.
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
barry


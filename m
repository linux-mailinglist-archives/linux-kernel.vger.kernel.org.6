Return-Path: <linux-kernel+bounces-391312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361519B8508
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6B22837BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23181CCEF0;
	Thu, 31 Oct 2024 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG1+KUoN"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609B1CEABA;
	Thu, 31 Oct 2024 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409189; cv=none; b=aAV86lKIDpT+sxIzfcGNDk6OWC2t1njlYuDm8F3fCo+NbUEnfygZGla5p0KnM+0IBtzNgRimFtShRsj5CSAgr0+li7KdkiFaAVHn1R7YpGRPZRwiOaXks56VsIN7VNnxis/2HsSIqQRKTQWVQlXc7xS30I1X/F/BQ0+W8YVMDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409189; c=relaxed/simple;
	bh=+oMUPWTZIUiw+q9ms3O0oyXDBWNUgtgzQKrScEZXvso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpEKIkP3Y3dAOibkJ9YlNyCuq9/JPhSttpcndueYQajCmzxB6KjEu9Ede+u6roLlF8VbbZI95vXeYSfWthfiK2+5CcJsBRqoxwFiH/sdYOjn0jQpOnGcH1UzzKl0VlA8JmGQcYYqf5of3/TAwpcbRLXo/HHqffA2eSwVtCEvVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG1+KUoN; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a4789662c1so302281137.3;
        Thu, 31 Oct 2024 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730409182; x=1731013982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6oUOGw1MCk75rICOdPoO2zRRK9TEXCzt+8DXEz3OxE=;
        b=GG1+KUoNX8XD/jzJ9yuAAy+0S7Vypy8iz00sqzqJRpb7fseqmBaCLAxjUiv/LTiUbJ
         YZJsmGJWnTLTyRFwBIyKVcuX8OuFL1rtPTqD665/WVTbasZKSpGL/afwmRdjX7N0Ol9a
         Z1bfNrgAVCXzDVdbzaUJ3gfDHlSMk+V2SasVvHX93Uc4H2v+ZgKvctAz6Spmi/2ympKG
         m1jvoW1RzT4CPZtWQdxGrVNbkABqRInrzWo75r84I7BvYdvaXVAUfEHbdhLs/sCjKx5G
         afVU9JEQo0NV3ckApMwjnPQ4ObRz8GKOyROAh81SJe+mkJie2auxp9btg+l6KcGIX1tZ
         xraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409182; x=1731013982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6oUOGw1MCk75rICOdPoO2zRRK9TEXCzt+8DXEz3OxE=;
        b=TYBim8eUHbSjWeD9Ymfn0uNEvh+cznMeaL81E8wqbBXDT3hD3rIkeVHSIKrhLTaI7m
         TNU0GuMOmwVsEFO3lGGLMRNFMYCnytG/icmuxryPPGUUQSPNezgeJVmQtxRAkzY/X85n
         UTWYRpu8ILDWxfc/Z+FMwCc2Eov4qQOb1rmgL6R64bb3i+5MkoNkvHDteH/IgHpjhybc
         5uN0bIM9pDJhjKpB0mlQgHIHvlxxp9E2A7Lm+6NTf9eYT+ZzoQpiyybTckjx0oqjpPQT
         rcERQPHRv/QySZurGPCtuSN3rGR9W3iupUJy0gO9eNPWaLm5NtEVbaHATwMhr1OAVzzl
         BkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyI0kl1AQpWByCXCN4nM3pKJJ+y92uVIkxoqqwyKoNCE/c4c1H2Cw34N+YjTt/d32nfiUyuyRHM7jtC28f@vger.kernel.org, AJvYcCXUHmrqR5gClkE9gJuI4Bi4Cyir1R+WKrflfL7X3pIqpoE0eRNOJjKrConhRFToRMMVKT1L6zkeyuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTIuK7V2lxuuY633hBP2f+uwU8zJH1sMadtZ6qnUwvlNJopQ4M
	odDR2CF1xZPPoyigX6lS3yawGyKFoeoLNqm2On+vVeavzHyE4zDSsCiZ+y+6DAVPxYrcyhmQiU9
	Yk75HADsoHLNJZvcOV9srd+Vg6dQ=
X-Google-Smtp-Source: AGHT+IHMtUOKVU5QyV2KXcwvIbruPZDa7es/IlnYGnmxoYGwx2LP7kEkB4SbMGC6ZTYUcnGUu9GcOd29xDxhvfZ2Mnc=
X-Received: by 2002:a05:6102:548d:b0:4a3:d46a:3590 with SMTP id
 ada2fe7eead31-4a95425990amr5989147137.1.1730409181893; Thu, 31 Oct 2024
 14:13:01 -0700 (PDT)
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
In-Reply-To: <d65176f1-df6f-4e21-b281-469ec958f26f@igalia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 1 Nov 2024 10:12:51 +1300
Message-ID: <CAGsJ_4zObE7hsFangzmKK0c6wZ7xZS3fCEYdx5W6HkAHqcP20g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: shmem: override mTHP shmem default with a
 kernel parameter
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: David Hildenbrand <david@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 3:20=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com>=
 wrote:
>
> On 31/10/24 10:33, David Hildenbrand wrote:
> > On 31.10.24 14:24, Ma=C3=ADra Canal wrote:
> >> Hi David,
> >>
> >> On 31/10/24 09:57, David Hildenbrand wrote:
> >>> On 31.10.24 13:51, Ma=C3=ADra Canal wrote:
> >>>> Hi David,
> >>>>
> >>>> On 31/10/24 09:37, David Hildenbrand wrote:
> >>>>> On 30.10.24 13:58, Ma=C3=ADra Canal wrote:
> >>>>>> Add the ``thp_shmem=3D`` kernel command line to allow specifying t=
he
> >>>>>> default policy of each supported shmem hugepage size. The kernel
> >>>>>> parameter
> >>>>>> accepts the following format:
> >>>>>>
> >>>>>> thp_shmem=3D<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-
> >>>>>> <size>[KMG]:<policy>
> >>>>>>
> >>>>>> For example,
> >>>>>>
> >>>>>> thp_shmem=3D16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:nev=
er;4M-8M:within_size
> >>>>>>
> >>>>>> By configuring the default policy of several shmem hugepages, the
> >>>>>> user
> >>>>>> can take advantage of mTHP before it's been configured through sys=
fs.
> >>>>>>
> >>>>>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >>>>>> ---
> >>>>>>     .../admin-guide/kernel-parameters.txt         |  10 ++
> >>>>>>     Documentation/admin-guide/mm/transhuge.rst    |  17 +++
> >>>>>>     mm/shmem.c                                    | 109 ++++++++++=
+++
> >>>>>> ++++-
> >>>>>>     3 files changed, 135 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>
> >>>> [...]
> >>>>
> >>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>>>>> index dfcc88ec6e34..c2299fa0b345 100644
> >>>>>> --- a/mm/shmem.c
> >>>>>> +++ b/mm/shmem.c
> >>>>>> @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always
> >>>>>> __read_mostly;
> >>>>>>     static unsigned long huge_shmem_orders_madvise __read_mostly;
> >>>>>>     static unsigned long huge_shmem_orders_inherit __read_mostly;
> >>>>>>     static unsigned long huge_shmem_orders_within_size __read_most=
ly;
> >>>>>> +static bool shmem_orders_configured __initdata;
> >>>>>>     #endif
> >>>>>>     #ifdef CONFIG_TMPFS
> >>>>>> @@ -5027,7 +5028,8 @@ void __init shmem_init(void)
> >>>>>>          * Default to setting PMD-sized THP to inherit the global
> >>>>>> setting and
> >>>>>>          * disable all other multi-size THPs.
> >>>>>>          */
> >>>>>> -    huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
> >>>>>> +    if (!shmem_orders_configured)
> >>>>>> +        huge_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
> >>>>>>     #endif
> >>>>>>         return;
> >>>>>> @@ -5180,6 +5182,26 @@ struct kobj_attribute
> >>>>>> thpsize_shmem_enabled_attr =3D
> >>>>>>     #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
> >>>>>> +static inline int get_order_from_str(const char *size_str)
> >>>>>> +{
> >>>>>> +    unsigned long size;
> >>>>>> +    char *endptr;
> >>>>>> +    int order;
> >>>>>> +
> >>>>>> +    size =3D memparse(size_str, &endptr);
> >>>>>> +
> >>>>>> +    if (!is_power_of_2(size))
> >>>>>> +        goto err;
> >>>>>> +    order =3D get_order(size);
> >>>>>> +    if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
> >>>>>> +        goto err;
> >>>>>> +
> >>>>>> +    return order;
> >>>>>> +err:
> >>>>>> +    pr_err("invalid size %s in thp_shmem boot parameter\n",
> >>>>>> size_str);
> >>>>>> +    return -EINVAL;
> >>>>>> +}
> >>>>>
> >>>>> Hm, mostly copy and paste. You could reuse existing
> >>>>> get_order_from_str()
> >>>>> simply by passing in the supported orders and moving error
> >>>>> reporting to
> >>>>> the caller.
> >>>>>
> >>>>
> >>>> Can I use functions from mm/huge_memory.c here?
> >>>
> >>> Yes, that's the idea.
> >>>
> >>
> >> Unfortunately, it isn't possible without adding the function to a
> >> header.
> >
> > Well ... sure, what's the problem with that?
>
> David & Barry, how do you feel about adding `get_order_from_str()` to
> lib/cmdline.c?

I'd vote to leave it as is. If, at some point, the controls for shared memo=
ry
and anonymous memory are moved to a file, that would be the right time
to call the same get_order_from_str() for both.

This is too trivial to warrant being an exposed API in huge_memory.h
or cmdline.

>
> Best Regards,
> - Ma=C3=ADra
>

Thanks
Barry


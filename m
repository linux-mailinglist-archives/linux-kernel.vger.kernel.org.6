Return-Path: <linux-kernel+bounces-391310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD819B8503
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19AF2B2337B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5141CCB5E;
	Thu, 31 Oct 2024 21:12:26 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202F1C2DA4;
	Thu, 31 Oct 2024 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409145; cv=none; b=mIWEyt0w6Wp+fsy8Xn416bPrk/kFhIkunzMHujfJ5Hw7y4zC0XhdJlXvQ8R4075Cz+GifbsZQ+tQl2h8AOUsKZugCiGXFJc9KW4sgoC1ljoDJG6ruUaCuOJAJx+NCKbJ6jNShojyBkdjskvc8m05algrbgNlc3kfFuzfaurMrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409145; c=relaxed/simple;
	bh=LOO8Qcu5v9KnoozUC+ugL4ZcHeDRN5l1czcKfs8GW2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD9BWEVZuvZXXn6Y20LYh3C305VPw2vcGNokYS/27b6x+jr+FyudFvI3hAnjoPj69iviV+4G3PadnVG6S1ws/8CutnJGhfx4Ji4e+d4ucESrW5hGEt8fGsDWCymTMz6mvZsKP7JQjRbjZsT5UEapO1DXtBGipSsnQMS0n4qAXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fc818f518so376668241.2;
        Thu, 31 Oct 2024 14:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409138; x=1731013938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1Z1M9ebfF+XErr/w1JTQtKXBgDlrbNSW0zBIf4bs/8=;
        b=trmvCP7Hx+9EMcUeIlkIFk9sJbbFMx0bEcDYILc0NleJg6ZD1209xyj+SN3Yr1Bahc
         zpWbDrvzV3qYfRBZqPPMYJ+1PGtbbk2g2lmYf2+cBOIpUaXP8ukW4wV7oikE/0GYaohT
         3fa8AYwyChvDKqz7dtAOs0gvXH3xTafv5X8hNuwM/Otf2loZxoeI+cm+BZgpjpugMjIp
         T8G/5iWu8AB2RzA1R/WcDgxIgEi7dKCS2d3HpWMZrqFXxs78bbwkcasv97iz67GeR/zS
         LpD0+9Lsr2ZDGUnZNZB1HNg0n9q0PSxHMuYTSLubK1JED6jBpAkOehOGRIQRLWHiAY/O
         sm0w==
X-Forwarded-Encrypted: i=1; AJvYcCWcPmr1jC8t5hTpZZCVi/aANLtO/IVp0Qq+nDm1ML6jegq4j8b9rmLgUINBgQg/7KlmmvK2FttJsF7cTR+5@vger.kernel.org, AJvYcCXnjeyusrnK/V47AvCiEWhsbdUhxAR1Ogcop1PLcsPpKlguSQkJ7JHQRXd2yZb4Tb6+DcwGxhkFcQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygGPdeMzcZ7//YXWQdSXeSV0x5oB7vw5oJHG3ZITZWhgTDtt8x
	NooaHyjIoc2GtB9562HQVLjXrqm7NzACPFiMNCiktlN2N6FYV/NjobiEEyguLtET5SBsmGc+qF4
	5TzYI2nH8T/fqrS0KNDjRqOi2xEA=
X-Google-Smtp-Source: AGHT+IER5i1rvtj8TljmyV11M4PPglRC2MIe6CsIKyOdZ5JcFWOe7+jSeXLNTeEiHBtfLABtNCxYXVv1W2z0gw/NAGQ=
X-Received: by 2002:a05:6102:290b:b0:4a3:cf4f:e19 with SMTP id
 ada2fe7eead31-4a962f34f2emr1287276137.24.1730409137629; Thu, 31 Oct 2024
 14:12:17 -0700 (PDT)
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
From: Barry Song <baohua@kernel.org>
Date: Fri, 1 Nov 2024 10:12:06 +1300
Message-ID: <CAGsJ_4yLbTqg1csQsGL_b7o9+P93fAE94pVSnUOQwUuO4DZ5FA@mail.gmail.com>
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

Thanks
barry


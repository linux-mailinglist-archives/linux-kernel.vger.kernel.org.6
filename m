Return-Path: <linux-kernel+bounces-286135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701095170F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BECE1F237E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7767213E8A5;
	Wed, 14 Aug 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5PKGJSP"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B113D502
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625666; cv=none; b=BwkAaGqxbgVbQpT8t5Ngqk+rQDMNgYpVf18p7fgoTneNN53Bmc9LgrML8/mAm6O/diVD17Girj27bAhU3bqhvils1KTvNdBe4LAwO8UbpBOkPDQ05jg4hAF/U6Hqm/mR/576dAUMy6B5OwFXd8W6TjfbZPQhmcfluvuWd/5U1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625666; c=relaxed/simple;
	bh=3B9YFCmV3YOHxXUcRpJroFEFxVxNC2xKT6w+GASfvTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4liXk5tPVXweBw3SvWgScIa54ddnU+LZ3bA4wxBbtKiYU5WnKB5OLy5GJ03du2nu0w58y19E9GBCtcSTnxxtqzTLeIM0WVn6Hw5PSOizBvtd3tl9DZq5BfistqXuHRDQApgtOAxNspz3m4q14cL+dGPU1UJmpgOYi7wwsQVRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5PKGJSP; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-261112c303bso4692539fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723625664; x=1724230464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkMx4p1nJS669ykPG42HHrqlvkwWooNpild6e+mzsQs=;
        b=e5PKGJSP+rFt/LOV7AeVX9lEXokuaJUz1a2fSrR8vEtxr4OHtu5RuCKRlHXWIEe+ys
         8SevHT+/aAJB1mYQh+KFi3xZuTPP/cW5WA8yI34I94pJmsRsSb0svd1DaNrtvvuirFEO
         JYOaoDsdcQ/GRCxSkMdM+p1SxYmEpuUiW6ul5hmzHhFNtE8Fj5hNH/nnP6g4WnYe1LC7
         /5hWnYNqdMrcVQe8vgjMdpedT7LJ9b+C5JzMZld4jhRXTD9cWttpZMO5DnqdOEruIpwd
         bs4FDRgvtYNeApHrXR367QcPMbpGRXmzqtADyh6HKro/DiivBJVFEDWQ1wIfzkB6dbuO
         BSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625664; x=1724230464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkMx4p1nJS669ykPG42HHrqlvkwWooNpild6e+mzsQs=;
        b=SrHJlr7aVYK544f8SfiKX43AQQCW1J8vZUtCX7UWPZf0YkkjJLGVDknyfkKwHbrUfj
         x0ecsxJ7/7akDCBEvdFZp+4O1b5yzdQzodgccUL2sjKvputRqcAOBe1TjcRWNsvWsc+T
         z8+Ain7JlgjUI8SQllA0ct7w6JEIkBMml6h3kxnF30Ak+pAReo5U/QavCQKcUAzN1Jfn
         ln6ysiU44euCZJNVQn/SHIhwGRr+5CMnXmjcksZBq/H8r/DxGMR2V9wCDrdmcjQ9pETM
         3RdLBm/9YwV+6PHFKXptRezpM5l6he0+9RrkByNZOd20dB4q9M4wSr+uu8sMLkNQBCLE
         7+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzspFvoEhifeunvdJ6A19GiqUSXeJiIh4N1gQmp0ICwl/c0z07opp1uitWqHxKyRbmzb8UQ7fcuSaYYV+qJEp77n2CUjMM0tywTUXw
X-Gm-Message-State: AOJu0YwSvxnWI4Khw7TgwKNGziSwaesfDwTHa+X9fnccunA/s0OQCdy9
	OhrIKjlFm1J7ki58Rk3DMlROZfrNir2MNcRIfvDrmwmDDnrWGSZ2
X-Google-Smtp-Source: AGHT+IH+GATAJY6H4OqhoorVin3vKHpP3+mvZviBR56XQ6yy+kBvmtt3OK9zcFpDUHtBWu2J4W233Q==
X-Received: by 2002:a05:6870:4690:b0:25e:7a1:ea8f with SMTP id 586e51a60fabf-26fe5c65bfcmr2595496fac.47.1723625663692;
        Wed, 14 Aug 2024 01:54:23 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab352fsm6918088b3a.189.2024.08.14.01.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:54:23 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	corbet@lwn.net,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com
Subject: Re: [PATCH v4] mm: Override mTHP "enabled" defaults at kernel cmdline
Date: Wed, 14 Aug 2024 20:54:09 +1200
Message-Id: <20240814085409.124466-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ca3aaa3f-f018-46e4-aad1-c6a4fb8c7f11@redhat.com>
References: <ca3aaa3f-f018-46e4-aad1-c6a4fb8c7f11@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Wed, Aug 14, 2024 at 8:18 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 14.08.24 04:02, Barry Song wrote:
> > From: Ryan Roberts <ryan.roberts@arm.com>
> >
> > Add thp_anon= cmdline parameter to allow specifying the default
> > enablement of each supported anon THP size. The parameter accepts the
> > following format and can be provided multiple times to configure each
> > size:
> >
> > thp_anon=<size>,<size>[KMG]:<value>;<size>-<size>[KMG]:<value>
> >
> > An example:
> >
> > thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
> >
> > See Documentation/admin-guide/mm/transhuge.rst for more details.
> >
> > Configuring the defaults at boot time is useful to allow early user
> > space to take advantage of mTHP before its been configured through
> > sysfs.
> >
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   -v4:
> >   * use bitmap APIs to set and clear bits. thanks very much for
> >     David's comment!
> >
> >   .../admin-guide/kernel-parameters.txt         |  9 ++
> >   Documentation/admin-guide/mm/transhuge.rst    | 37 +++++--
> >   mm/huge_memory.c                              | 96 ++++++++++++++++++-
> >   3 files changed, 134 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f0057bac20fb..d0d141d50638 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6629,6 +6629,15 @@
> >                       <deci-seconds>: poll all this frequency
> >                       0: no polling (default)
> >  
> > +     thp_anon=       [KNL]
> > +                     Format: <size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>
> > +                     state is one of "always", "madvise", "never" or "inherit".
> > +                     Can be used to control the default behavior of the
> > +                     system with respect to anonymous transparent hugepages.
> > +                     Can be used multiple times for multiple anon THP sizes.
> > +                     See Documentation/admin-guide/mm/transhuge.rst for more
> > +                     details.
> > +
> >       threadirqs      [KNL,EARLY]
> >                       Force threading of all interrupt handlers except those
> >                       marked explicitly IRQF_NO_THREAD.
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> > index 7072469de8a8..528e1a19d63f 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -284,13 +284,36 @@ that THP is shared. Exceeding the number would block the collapse::
> >  
> >   A higher value may increase memory footprint for some workloads.
> >  
> > -Boot parameter
> > -==============
> > -
> > -You can change the sysfs boot time defaults of Transparent Hugepage
> > -Support by passing the parameter ``transparent_hugepage=always`` or
> > -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
> > -to the kernel command line.
> > +Boot parameters
> > +===============
> > +
> > +You can change the sysfs boot time default for the top-level "enabled"
> > +control by passing the parameter ``transparent_hugepage=always`` or
> > +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
> > +kernel command line.
> > +
> > +Alternatively, each supported anonymous THP size can be controlled by
> > +passing ``thp_anon=<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>``,
> > +where ``<size>`` is the THP size and ``<state>`` is one of ``always``,
> > +``madvise``, ``never`` or ``inherit``.
> > +
> > +For example, the following will set 16K, 32K, 64K THP to ``always``,
> > +set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
> > +to ``never``::
> > +
> > +     thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
> > +
> > +``thp_anon=`` may be specified multiple times to configure all THP sizes as
> > +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
> > +not explicitly configured on the command line are implicitly set to
> > +``never``.
> > +
> > +``transparent_hugepage`` setting only affects the global toggle. If
> > +``thp_anon`` is not specified, PMD_ORDER THP will default to ``inherit``.
> > +However, if a valid ``thp_anon`` setting is provided by the user, the
> > +PMD_ORDER THP policy will be overridden. If the policy for PMD_ORDER
> > +is not defined within a valid ``thp_anon``, its policy will default to
> > +``never``.
> >  
> >   Hugepages in tmpfs/shmem
> >   ========================
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 1a12c011e2df..c5f4e97b49de 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -81,6 +81,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
> >   unsigned long huge_anon_orders_always __read_mostly;
> >   unsigned long huge_anon_orders_madvise __read_mostly;
> >   unsigned long huge_anon_orders_inherit __read_mostly;
> > +static bool anon_orders_configured;
> >  
> >   unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >                                        unsigned long vm_flags,
> > @@ -737,7 +738,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
> >        * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
> >        * constant so we have to do this here.
> >        */
> > -     huge_anon_orders_inherit = BIT(PMD_ORDER);
> > +     if (!anon_orders_configured) {
> > +             huge_anon_orders_inherit = BIT(PMD_ORDER);
> > +             anon_orders_configured = true;
> > +     }
> >  
> >       *hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
> >       if (unlikely(!*hugepage_kobj)) {
> > @@ -922,6 +926,96 @@ static int __init setup_transparent_hugepage(char *str)
> >   }
> >   __setup("transparent_hugepage=", setup_transparent_hugepage);
> >  
> > +static inline int get_order_from_str(const char *size_str)
> > +{
> > +     unsigned long size;
> > +     char *endptr;
> > +     int order;
> > +
> > +     size = memparse(size_str, &endptr);
>
> Do we have to also test if is_power_of_2(), and refuse if not? For
> example, what if someone would pass 3K, would the existing check catch it?

no, the existing check can't catch it.

I passed thp_anon=15K-64K:always, then I got 16K enabled:

/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
[always] inherit madvise never

I can actually check that by:

static inline int get_order_from_str(const char *size_str)
{
	unsigned long size;
	char *endptr;
	int order;

	size = memparse(size_str, &endptr);

	if (!is_power_of_2(size >> PAGE_SHIFT))
		goto err;
	order = get_order(size);
	if ((1 << order) & ~THP_ORDERS_ALL_ANON)
		goto err;

	return order;
err:
	pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
	return -EINVAL;
}

>
> > +     order = fls(size >> PAGE_SHIFT) - 1;
>
> Is this a fancy way of writing
>
> order = log2(size >> PAGE_SHIFT);
>
> ? :)

I think ilog2 is implemented by fls ?

>
> Anyhow, if get_order() wraps that, all good.

I guess it doesn't check power of 2?

>
> > +     if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
> > +             pr_err("invalid size %s(order %d) in thp_anon boot parameter\n",
> > +                     size_str, order);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return order;
> > +}
>
> Apart from that, nothing jumped at me.

Please take a look at the new get_order_from_str() before I
send v5 :-)

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry



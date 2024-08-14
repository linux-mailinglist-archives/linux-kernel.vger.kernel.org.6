Return-Path: <linux-kernel+bounces-286072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B495162F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCF22838DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4EA13D88E;
	Wed, 14 Aug 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpwmjInI"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3F13CA8D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622959; cv=none; b=iY475rq/YZBaoruc47hDs1f9fWw0fBY097h1f8FcWaXRvkMDcw2ImWA/ufrAveyfrN8rl4yZmXFJnZHEx74Efurn4TQagRMhzoECVxJq8b48KWa3pu+zJapzQPb0UR5LD6ScnZA+8UytnukvEhNAkftSwMGCosOLTt1wvG8qmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622959; c=relaxed/simple;
	bh=+3Uy5tVsS1xYJ4Ajxols5h7sv6WqoGWkNmxA3z9JgIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jp5Oc/JgvOirm4o83S20hz1672xW5HpJDBbGN1a36oRhbtjg4rHbqtAsIMBwESo+X9yj1SCDmafwtHsskB3i9Mw5mElvgoGvfN/ITnwZqznA2l+8n+FXZeJMnwrktoe0ZalR8wmtFD/h37mKNc5rm3IZGulx2Mrh/aTDsTfMUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpwmjInI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc60c3ead4so42991005ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723622957; x=1724227757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37oHXzv1vWgVfvyci6NXVgh8uUW+FtKN9bgTbkcfqjw=;
        b=HpwmjInI9e3uo1+xO0fJuzlfC4v2/q51SpoYOpxLWKgOZVQYcceNy8fc2Sc+ovPwcx
         WppZpuw0nOxZxAeTEBNpLsMMRbkr/qtG7CcyB/rPUuT0+eV7vHd4XBPKsgX6nQYMMDfk
         FhHxGiL6qYUP3Wa1xtLOARG52qcoGFAO7Vbhqhkx3PI3MywCzUBHY6KDmgkIt+2XDnrs
         aDUGrrbitWo3eZJd5aRiwTo/i8kU81n6ux/WzBqfpqF8N/BwfLGCDJ0EKwUfrUQDw41/
         0cqddNUYfM9rrUFQ7XE0iQBGwDJrnGFTGBzQQ7B97AeA5VGR+wBvWwOEdFxFn6ZT9FFC
         I1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622957; x=1724227757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37oHXzv1vWgVfvyci6NXVgh8uUW+FtKN9bgTbkcfqjw=;
        b=UkLhtsQjoZ/OTho48WG3MbFhYAfldWRFCZIlc+dCNzNWEli1BXqBQL/3z4mt52+kOJ
         A0n9oDEuljFnR8cLv1Bw9h/O71FXZvMq2Z4Q0nyskVMYnlqp8XksZlmQ9mWZmy7hxQlN
         syM3oAYTFVPvkxBUdWCfyxm2MP5/O3dvDRW4nQzYzRRgHqqLppV91vt9SgeHjJe0TNRO
         4/KdbNY4e1u6gG+TT8UbUGYaIm/Zelf+odUxkrmFpI/FQY01wDrk5l7gfIGekjTr5SrM
         rK3JNiLJGiMIuclmPamzG31dVQLA9mYT2yQtAlYNsUK+i6j+vWtgmBMwCL8F615U6xIE
         ukbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8TjCWNs9hO6eFHkOAq8wZcPQjYgL1BtA1+u7kwsZMa6HW0DhDZ2OnxNs6zKbn89S+M/1FcSZMX/XrayFaNqak9cFZrkBeIwyfVMLl
X-Gm-Message-State: AOJu0Yw6B+D64IDf83oe7pwOeYMbav8bhiFzyqgEce5gVfQPLqtD595n
	OCXq2bmIEltW4SCtzEVtjYigr00fBrisgyOkUw+D8ysqyX08ylB8
X-Google-Smtp-Source: AGHT+IG7aon1+lVeRD7X2n0PFqqeR3pEbCgpMc9AOTnlPovkqRuRYZjLtQ8wJIEDR9mo4iBU+mwKlg==
X-Received: by 2002:a17:903:35cf:b0:1fd:91b1:7883 with SMTP id d9443c01a7336-201d63abef6mr24922655ad.14.1723622956728;
        Wed, 14 Aug 2024 01:09:16 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd12ecb1sm24708325ad.11.2024.08.14.01.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:09:16 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: baolin.wang@linux.alibaba.com
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com
Subject: Re: [PATCH v4] mm: Override mTHP "enabled" defaults at kernel cmdline
Date: Wed, 14 Aug 2024 20:09:01 +1200
Message-Id: <20240814080901.87898-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c82a3834-f1c9-472f-9900-0d8885092943@linux.alibaba.com>
References: <c82a3834-f1c9-472f-9900-0d8885092943@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Aug 14, 2024 at 7:53 PM Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/8/14 10:02, Barry Song wrote:
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
>
> LGTM. Feel free to add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>

Thanks, Baolin!

> Just a small nit as below.
>
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
> > +     order = fls(size >> PAGE_SHIFT) - 1;
>
> Nit: using get_order() seems more robust?

Yes. I agree get_order() is better:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c5f4e97b49de..0f398d0dbaad 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -933,7 +933,7 @@ static inline int get_order_from_str(const char *size_str)
 	int order;
 
 	size = memparse(size_str, &endptr);
-	order = fls(size >> PAGE_SHIFT) - 1;
+	order = get_order(size);
 	if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
 		pr_err("invalid size %s(order %d) in thp_anon boot parameter\n",
 			size_str, order);
>
> > +     if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
> > +             pr_err("invalid size %s(order %d) in thp_anon boot parameter\n",
> > +                     size_str, order);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return order;
> > +}
> [snip]


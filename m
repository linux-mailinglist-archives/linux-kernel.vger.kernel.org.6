Return-Path: <linux-kernel+bounces-170776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A668BDBE4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C861C21574
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CECE78C8C;
	Tue,  7 May 2024 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlz54wGe"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC778C7E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064648; cv=none; b=UAs82Nblstr9pB0qmK8obBB+kOQ83b8ocqe7xU7p33NqGlgkpV+0ixGqUMOiPy4wrVhd24JJclAMoogC65kCVl6Wr/Z9RgnwLsyGFramakTW96JV5DhrjfiRZMpcYH6u9qebTh5dXWtvkrwKkxXqi/kXEJiyWS5I/qS+xv57tsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064648; c=relaxed/simple;
	bh=B54nSfabufPf3bZUalOfLCZ3eIx8sLMVhlJmwFA+bkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB6gRcazKT5M5hfFVzbzvAGw43VvNfdNPrzq5l6WwXhlPQxIPNoBTZ6WHP1ggClFnhX6yJwwFX7MMDSU35WFSON0DCeJHM1Err2Q+t7FiAPLZtUhRfxO11GvrMu8YWZMC6Hu47+4b3pSeaRlbf3SsaWqxWyIFbUf4TKSQqZtSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlz54wGe; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a5f81af4so698596466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 23:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715064645; x=1715669445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtf9JTxvmEium7Z5IYrhPwaVkYIMsaQSn2TAuNeOINo=;
        b=nlz54wGeOOT96Saim//9XtEwgqbVrcuKyCB+lqqUeKr0QbblIqg3xu2oTMTxxRGjVe
         HyTtWL/Xmp8nadfvzV1SHJmpum7ZrB/BYBQfK2D0MOh1ZN/5d3DZbMLupr8cxXlQvlUR
         htEOeZbBzd2K5Mm7ik70XwJvJYIJa6YuFS7tk1HueEzZVBSZw5YqY+3df2vvdTGFEK0n
         TU34N5jRJbYZW+rUjTxfC5t6JQDsgQeL9pHl2JMrJSN9IW8xoh5J1CDM3EhRnWjUA3ih
         OxIZ31EI+wDDfD6JVnywAy1IEJLVtKj1U77tUTWzTyDtU3w8PzmGNg2Fbh1oHLzL3s7F
         JyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715064645; x=1715669445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtf9JTxvmEium7Z5IYrhPwaVkYIMsaQSn2TAuNeOINo=;
        b=flSHm+Q5EE2sZO8rBBkVcfa/VK0Ig6gAZIUWVpdCrIoRG3jnKICoGcJ0Ro8YxRbWQm
         QW4aux6tMf9q2MnijYg74bfkdzWP/ZTn8kDq2rz24gt7K3JmR0pNjneaFN697XSf0211
         Ucp6oqInE/oTZkGv5MAQucajwD+omMfNGq9LIUtHCh8yr9iX9z66sKxglXrtwV6UKiEA
         Ij8c+nP00+YANPQgUGe87WMqrWEc2kVxULS9yXA4jPPylKEBqtJlwKPPVTh94dK4fCCE
         HVXt94ZcnQeZdjR1TUuAC1eAUoBEjrvDkEwaRzwV0+AzziP5l13m7KxZJ5OfvwD90xcw
         LtDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuAQn1TnYhk4nltngVCZedfXKP3pZJS4sJvdtx9dR7IFE3Z/37GL8qfGKvD8jByhbR+Hv2Vkr6vsadk3P4xypx4qWS5ux8BU6YR/jy
X-Gm-Message-State: AOJu0YwtFJw7PGh5pSjnKRMELtXgNHtUc2oTCuORaQQbfKAegbXVK2bu
	3tbhDqxdjS3bDrb70dO5elUSt9TFgOB53iIa4yekpGGHor+L9hsKUsIkSUl14LLfiP0zlcpm+Er
	6XYoFMHxumkRCPt0+85Dl1q9zeos=
X-Google-Smtp-Source: AGHT+IFdfdm61Vn8oi+xzryCzRzJSFLKb1UrL2QHh03A24gevJJW27V1tPShZQ9It2eEb4A0AnspboCZwuS1463YKFs=
X-Received: by 2002:a50:a404:0:b0:570:1de9:4cd7 with SMTP id
 u4-20020a50a404000000b005701de94cd7mr8065600edb.15.1715064645064; Mon, 06 May
 2024 23:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <20240506105447.1171-1-ioworker0@gmail.com> <eaddd00d-8160-4800-b60f-25280dfe339b@linux.alibaba.com>
In-Reply-To: <eaddd00d-8160-4800-b60f-25280dfe339b@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 7 May 2024 14:50:33 +0800
Message-ID: <CAK1f24nB8D+zgphX3XXLWRq0_xwT+7EfV8dfxNmkHh_CCQrA-A@mail.gmail.com>
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com, 
	hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, shy828301@gmail.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, ying.huang@intel.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:47=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Hi Lance,
>
> On 2024/5/6 18:54, Lance Yang wrote:
> > Hey Baolin,
> >
> > I found a compilation issue that failed one[1] of my configurations
> > after applying this series. The error message is as follows:
> >
> > mm/shmem.c: In function =E2=80=98shmem_get_unmapped_area=E2=80=99:
> > ././include/linux/compiler_types.h:460:45: error: call to =E2=80=98__co=
mpiletime_assert_481=E2=80=99 declared with attribute error: BUILD_BUG fail=
ed
> >          _compiletime_assert(condition, msg, __compiletime_assert_, __C=
OUNTER__)
> >                                              ^
> > ././include/linux/compiler_types.h:441:25: note: in definition of macro=
 =E2=80=98__compiletime_assert=E2=80=99
> >                           prefix ## suffix();                          =
   \
> >                           ^~~~~~
> > ././include/linux/compiler_types.h:460:9: note: in expansion of macro =
=E2=80=98_compiletime_assert=E2=80=99
> >          _compiletime_assert(condition, msg, __compiletime_assert_, __C=
OUNTER__)
> >          ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=
=98compiletime_assert=E2=80=99
> >   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                       ^~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:59:21: note: in expansion of macro =E2=80=
=98BUILD_BUG_ON_MSG=E2=80=99
> >   #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >                       ^~~~~~~~~~~~~~~~
> > ./include/linux/huge_mm.h:97:28: note: in expansion of macro =E2=80=98B=
UILD_BUG=E2=80=99
> >   #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> >                              ^~~~~~~~~
> > ./include/linux/huge_mm.h:104:35: note: in expansion of macro =E2=80=98=
HPAGE_PMD_SHIFT=E2=80=99
> >   #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
> >                                     ^~~~~~~~~~~~~~~
> > mm/shmem.c:2419:36: note: in expansion of macro =E2=80=98HPAGE_PMD_SIZE=
=E2=80=99
> >          unsigned long hpage_size =3D HPAGE_PMD_SIZE;
> >                                     ^~~~~~~~~~~~~~~
> >
> > It seems like we need to handle the case where CONFIG_PGTABLE_HAS_HUGE_=
LEAVES
> > is undefined.
> >
> > [1] export ARCH=3Darm64 && make allnoconfig && make olddefconfig && mak=
e -j$(nproc)
>
> Thanks for reporting. I can move the use of HPAGE_PMD_SIZE to after the
> check for CONFIG_TRANSPARENT_HUGEPAGE, which can avoid the building error=
:

I confirmed that the issue I reported before has disappeared after applying
this change. For the fix,

Tested-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance

>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 1af2f0aa384d..d603e36e0f4f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2416,7 +2416,7 @@ unsigned long shmem_get_unmapped_area(struct file
> *file,
>          unsigned long inflated_len;
>          unsigned long inflated_addr;
>          unsigned long inflated_offset;
> -       unsigned long hpage_size =3D HPAGE_PMD_SIZE;
> +       unsigned long hpage_size;
>
>          if (len > TASK_SIZE)
>                  return -ENOMEM;
> @@ -2446,6 +2446,7 @@ unsigned long shmem_get_unmapped_area(struct file
> *file,
>          if (uaddr =3D=3D addr)
>                  return addr;
>
> +       hpage_size =3D HPAGE_PMD_SIZE;
>          if (shmem_huge !=3D SHMEM_HUGE_FORCE) {
>                  struct super_block *sb;
>                  unsigned long __maybe_unused hpage_orders;


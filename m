Return-Path: <linux-kernel+bounces-248000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF6392D741
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29C81C20DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8816E194C7D;
	Wed, 10 Jul 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/hfAjpj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B431190472
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631565; cv=none; b=AthUGwe49kpPhnm/v/EbLW4i04iiTYCQHERwR1kg0jvSkGAI7GP96RWgGGsjC6/gPL4CGxcVRmIhn+S6znx4CcmRx1I1wWx/lrdnt/Mj9n8N4/YW6arL1XwI8aYwlbMblc/7BBHVBJk4vz71JPHU/RzIPPUmR1iG86mtEIM1UuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631565; c=relaxed/simple;
	bh=fc4MYrkpKqcitXmd/lUlYOlh1/29UVlMTdFmD2Jh8Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpKqrINhVhLRVyKjfCzTbF3PyzRoOQ+9uaG0LKmAKO0fbsLzB1XLzKNfutd9pJgRCVbrXy68btsrNb2WRWb2MPCFn6Dfd4uabww4N32sY+eHbpSTQ8+VeW5X+LwnRTIKPL6+yL80/UQ0yCWDlTnACK2HXtY0oky0GgShsNSf58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/hfAjpj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42725f8a789so1325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631562; x=1721236362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPwiABRO0gJOFSW7TMavO+8O7Q4qhArDFONeWxtkC/4=;
        b=M/hfAjpjSK0b5Hlzd4ONW7JnBsMgMty6d6i95OxYj1oX9idsTZstFmHqwVWUqgufmc
         qAkyGFQu1K6trnEPadGjJ4ufkzgxGcvw76lEPpfN5LrRjPqnQg65I7MbsZaeBgqOaq2R
         9auNlGZOp+/kGZV4XVDORDpoCsJOyp5wJwGMI1W/q0wnhhCaUP6xwGMazp4ytMWmLwd8
         YWZcwgRXSlg6VPCY/h2HA3Lk4qAlT4o6j49MXT2S30equqDghfti+eIG5gNdqy7Y2EZc
         BaUZSIM3b7KxNCqggdpw4x1kCNEN6ayyHpvSzW5YlAWnTxPpiphwE0n6jfqNviHSJEgd
         2wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631562; x=1721236362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPwiABRO0gJOFSW7TMavO+8O7Q4qhArDFONeWxtkC/4=;
        b=AZINRV9Mfo/YG3UlVi1Xm7CHIFTtEOav1n7BvsYPZJBDBeCoy3g/h47icBUQVWOnMu
         b6pCro+5zNrR2tdrmqTEtrds8CyzVG+PBkF3oIFMkdlRhSBI3dwTU7rDFlkk+dtfmToR
         H/Dp3wyjpqDpiKdorJq8W9N8yc2mxNlk6/uci352TjCPoMaguK9N7X4ZBX8sIucnBRnh
         VDovznmjQmH7xSiwXscjuxlM1YXTaivO8Q1e6ZQN5B+vSpbBui5Fs6bHM6EpWYa0bngr
         cd9qJ/+xwHMgjEc4ebtxapsFMwJ3tyR3Pb5LCvn0Rjr0DmbZt3ve005nQxSLwJaL2WgC
         cNGA==
X-Forwarded-Encrypted: i=1; AJvYcCVSfAl9LgwWI8MsPR+Fx6Nl1UbXuRVBtaQPm1phKgPUDo7Oqt65YZuZIglFYbkaMWDcUrhuEPkDtytbsPFqGrq4OOhr+Ybyewc1ZyMn
X-Gm-Message-State: AOJu0Yx7lrGwb8NEV3HzKx0kRaM4rUc4pv9HdnS8Cy4nlp4ZNuIuo0k2
	QaufEUYj7L7A019C8Dwxe5v5NxB6XY66qasKAw9GooglqpU6PukrESHn0Iwf6hakcm41FphTqYb
	S8zFZFhiAQG3KePUTdJY0LP9JFkSfIbiCdd3Z
X-Google-Smtp-Source: AGHT+IFp/Qq+1y0meIj9pymlqXMiS+2/rtF+O2LmyGTaDm/g/qYw3Oop34bWO4Zb1vn1Iw7Kt13tULjmbZtjNce0nwU=
X-Received: by 2002:a7b:ce99:0:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-427942230e7mr1686105e9.1.1720631562070; Wed, 10 Jul 2024
 10:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <ZcN7P0CGUOOgki71@arm.com> <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>
 <ZogV9Iag4mxe6enx@arm.com> <CAOUHufYwoTTsRBF_wWZU_jWzb8e6FF=vN8UKtVHBeXLBkwHWzA@mail.gmail.com>
 <Zo68DP6siXfb6ZBR@arm.com>
In-Reply-To: <Zo68DP6siXfb6ZBR@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 10 Jul 2024 11:12:01 -0600
Message-ID: <CAOUHufZC0Jn=bTpc0JhqONXbYXgyBOVZ4j8bbKSJWv1dOSmQEA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	willy@infradead.org, wangkefeng.wang@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:51=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Jul 05, 2024 at 11:41:34AM -0600, Yu Zhao wrote:
> > On Fri, Jul 5, 2024 at 9:49=E2=80=AFAM Catalin Marinas <catalin.marinas=
@arm.com> wrote:
> > > If I did the maths right, for a 2MB hugetlb page, we have about 8
> > > vmemmap pages (32K). Once we split a 2MB vmemap range,
> >
> > Correct.
> >
> > > whatever else
> > > needs to be touched in this range won't require a stop_machine().
> >
> > There might be some misunderstandings here.
> >
> > To do HVO:
> > 1. we split a PMD into 512 PTEs;
> > 2. for every 8 PTEs:
> >   2a. we allocate an order-0 page for PTE #0;
> >   2b. we remap PTE #0 *RW* to this page;
> >   2c. we remap PTEs #1-7 *RO* to this page;
> >   2d. we free the original order-3 page.
>
> Thanks. I now remember why we reverted such support in 060a2c92d1b6
> ("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP"). The main
> problem is that point 2c also changes the output address of the PTE
> (and the content of the page slightly). The architecture requires a
> break-before-make in such scenario, though it would have been nice if it
> was more specific on what could go wrong.
>
> We can do point 1 safely if we have FEAT_BBM level 2. For point 2, I
> assume these 8 vmemmap pages may be accessed and that's why we can't do
> a break-before-make safely.

Correct

> I was wondering whether we could make the
> PTEs RO first and then change the output address but we have another
> rule that the content of the page should be the same. I don't think
> entries 1-7 are identical to entry 0 (though we could ask the architects
> for clarification here). Also, can we guarantee that nothing writes to
> entry 0 while we would do such remapping?

Yes, it's already guaranteed.

> We know entries 1-7 won't be
> written as we mapped them as RO but entry 0 contains the head page.
> Maybe it's ok to map it RO temporarily until the newly allocated hugetlb
> page is returned.

We can do that. I don't understand how this could elide BBM. After the
above, we would still need to do:
3. remap entry 0 from RO to RW, mapping the `struct page` page that
will be shared with entry 1-7.
4. remap entry 1-7 from their respective `struct page` pages to that
of entry 0, while they remain RO.

> If we could get the above work, it would be a lot simpler than thinking
> of stop_machine() or other locks to wait for such remapping.

Steps 3/4 would not require BBM somehow?

> > To do de-HVO:
> > 1. for every 8 PTEs:
> >   1a. we allocate 7 order-0 pages.
> >   1b. we remap PTEs #1-7 *RW* to those pages, respectively.
>
> Similar problem in 1.b, changing the output address. Here we could force
> the content to be the same

I don't follow the "the content to be the same" part. After HVO, we have:

Entry 0 -> `struct page` page A, RW
Entry 1 -> `struct page` page A, RO
...
Entry 7 -> `struct page` page A, RO

To de-HVO, we need to make them:

Entry 0 -> `struct page` page A, RW
Entry 1 -> `struct page` page B, RW
...
Entry 7 -> `struct page` page H, RW

I assume the same content means PTE_0 =3D=3D PTE_1/.../7?

> and remap PTEs 1-7 RO first to the new page,
> turn them RW afterwards and it's all compliant with the architecture
> (even without FEAT_BBM).

It'd be great if we could do that. I don't fully understand it though,
at the moment.


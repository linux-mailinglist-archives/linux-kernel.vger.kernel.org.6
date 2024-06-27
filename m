Return-Path: <linux-kernel+bounces-233040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA891B16F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B238FB2553C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA719A2A3;
	Thu, 27 Jun 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0TqN1kj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9B1A00CE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523235; cv=none; b=KYZ5Vs5EBoKMTF26S0VuYgsGqX0s5nNOZ3+lVPQhN4iRdlBX5jddq/OTFN1aLqKe6KXAUeCSyz0vrKGF5yZfaTPGyTY6AJqP3Xlbad7UyDjP1PE1cQ5uyhQpisvy5jvOwx7ngNkXYR3S5/+kyXAn7fDIep+VALpO7okp8UD8FQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523235; c=relaxed/simple;
	bh=NJHc3Fc2WHs5HcofJ/qZL6udQ6dkgbA3HIk9nTiz4wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8DSfLjQboZUTdGpqruaU6kIc2U7KIo0QvqfhS5q+9IbTinFqeLcWpaQkMgdPsIN/9x6hwCA9dCDr027xkdX/aqrqD+Tkwsr8mWYU1misUfEdchtU3XqgpWgYr6sK9KfKfyzCYw945HnaAdCGza/4mMiR3Q/aK7DCA9TCLs+UFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0TqN1kj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4255f915611so5985e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719523232; x=1720128032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gAULreh3rtOC1d/4Wogmb8c1fsZXcK3zxj4Xt1tx6M=;
        b=R0TqN1kj/VmUakIS5b7/zwG3PwrycQgyIouNJQRxp8ZqgLA/B0F1ctY+GsO5uBmNX9
         dXTVR8pBFKvLjvwz5gTQIRDW3UoZ7kFZ9KF2l3oG148f4ZY42Co0c3vkRBtrnSiNJSpf
         rUCOyjdhYjYsEzTaJHikLbFB8/bYKGKtb4ElAejxUE/2QI9g9KnWowQp/+HBFka2PMui
         blpIcSA9drfh8pxV7SiJV4d04iLp/UkGlHYws4njMdyfd5Nyym3fq3vyFrzO5uVmms9W
         R3yrBwNd3PrSnUD+UvuKKlYZYieUAeu5Pee7K/A/kDep8fq6wVcDVO3nf//R/2lTlECr
         jx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719523232; x=1720128032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gAULreh3rtOC1d/4Wogmb8c1fsZXcK3zxj4Xt1tx6M=;
        b=ctwW2FRSr/gv6vWprelJ3bhBh6rIiGNqSRblwsdPpMekR57bZkbaCHTaypZbDn0DZT
         Gsi9xZdO9m2Gj2EcHYEUEzJNTc2jOh5+qj/pn0olb6SH7axJTBe23H4UiW4XGnpgka94
         7DopgPNpt4gl7BK7HufmvkmDH/tcAJi/U9w1hU3am5ksKTC6HWH9T0L0jGqMAM1n0gvg
         WpI4ct8mJF39EnhwpDqm2Pp/NBKRp06MZagWszf5/wuHpU7k7yvv9p8NM3tHmHJSKOkL
         hyYBDSU9hI2nGeyoI5Xb+ohEeG+/nvvlQm4+XQCUu5BPXVcDeJY+F5ORxDr7j89gz5rE
         6Q4g==
X-Forwarded-Encrypted: i=1; AJvYcCWVPPrtr5sNKKf+Q3nBfG5rfW8deIxupLsYTdSe8BpurOuqqe6YgVED7mfBGdSzRVM1dJYhYLh7g9BNAsYRj/Qw5De53gP1S2NWmEN1
X-Gm-Message-State: AOJu0YweFGW4FYzewhg5JGzLrdiU2H6YiD5uFWHMme1bTCB2xQP8/+z9
	kn89bGd71k5d95oyq/fnd9ivkTPPJO9slKF3p8brxriC0Eo6N8cpJpuJ9BfoukKjeE++9K87Mt1
	3LydCzqCrZKzXqGqv2P6Yhb+tUuF/kxJe3i+D
X-Google-Smtp-Source: AGHT+IEQcYI4tMC/xVU9fpIjsQD17XpzU0FPLZXu1rA9iwcI/OwI+pd94ZomravD1sIA6yr6hGJYGrOBHgIKqlGjzZI=
X-Received: by 2002:a05:600c:5113:b0:421:6c54:3a8 with SMTP id
 5b1f17b1804b1-4256c2a9e25mr158255e9.7.1719523231932; Thu, 27 Jun 2024
 14:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com> <ZcN7P0CGUOOgki71@arm.com>
In-Reply-To: <ZcN7P0CGUOOgki71@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 27 Jun 2024 15:19:55 -0600
Message-ID: <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	willy@infradead.org, wangkefeng.wang@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:44=E2=80=AFAM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> > On 2024/1/26 2:06, Catalin Marinas wrote:
> > > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > > HVO was previously disabled on arm64 [1] due to the lack of necessa=
ry
> > > > BBM(break-before-make) logic when changing page tables.
> > > > This set of patches fix this by adding necessary BBM sequence when
> > > > changing page table, and supporting vmemmap page fault handling to
> > > > fixup kernel address translation fault if vmemmap is concurrently a=
ccessed.
> [...]
> > > How often is this code path called? I wonder whether a stop_machine()
> > > approach would be simpler.
> > As long as allocating or releasing hugetlb is called.  We cannot limit =
users
> > to only allocate or release hugetlb
> > when booting or not running any workload on all other cpus, so if use
> > stop_machine(), it will be triggered
> > 8 times every 2M and 4096 times every 1G, which is probably too expensi=
ve.
>
> I'm hoping this can be batched somehow and not do a stop_machine() (or
> 8) for every 2MB huge page.

Theoretically, all hugeTLB vmemmap operations from a single user
request can be done in one batch. This would require the preallocation
of the new copy of vmemmap so that the old copy can be replaced with
one BBM.

> Just to make sure I understand - is the goal to be able to free struct
> pages corresponding to hugetlbfs pages?

Correct, if you are referring to the pages holding struct page[].

> Can we not leave the vmemmap in
> place and just release that memory to the page allocator?

We cannot, since the goal is to reuse those pages for something else,
i.e., reduce the metadata overhead for hugeTLB.

> The physical
> RAM for those struct pages isn't going anywhere

This is not the case.


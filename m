Return-Path: <linux-kernel+bounces-242786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE139928D24
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16081C20DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333816D331;
	Fri,  5 Jul 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01o3Gc6R"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF8A955
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201335; cv=none; b=IfZ/w37ibcyZp3vW8C5klzb2GtGMV8BmFk8gGWKyjCWM7qTOw2xYzyB1cQl1BXhYwX0JL8BMngbxIgppO1zxGGWIsdS/uiG/LLo3yXIDbny9GcKFQJ2o4/qD9aTf/WwVqvnUrVGpQVqKpd4DayTk2hYqPkg2RCT9RrcmsB0M+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201335; c=relaxed/simple;
	bh=Y1+zacs5TVMRhJob78BHvQF5zAh8wQEx+Ri+TVfwNK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePFAA+dFFp45TRsHjpnhS1OtJnkCsN0lI8VsTtrpNDusVfgm6eseTB3Hs8E6SLQDcnrmN47lJqN4SJDsQ9vCCOmWc+yar2PjnPoUBxCQSWYdu9NQNmTSWtoV0nZozhZHHux/SR0qhOGxaqyyBFFQTvtoBCOBDGisbSOKLd/bc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01o3Gc6R; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447def0c4e7so40971cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720201333; x=1720806133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx6t+420ZDZCraDFpW85LzdL9pA2qdlTORVzQJ7eiy0=;
        b=01o3Gc6R3aMet5RFPvnX7HkEuXhMJIUF2c4MxZ2OoTJX0bvrzZOB1wqpZ4ZDsUGtgK
         b7zUcqdY0tK3iutTIwpBR038E3gUw/mU8JG12Yn08yz3JaflmGsfv3IucGBaJaDbJqbg
         yjugUJy5ceHewKlqPOQrEhZPDfzXOfi7r0O718eums+c0YncOVsR1QsZ8oe/i9acKwsX
         1hCcvNRCV3mm81ACYjMWN6sWtYgMCKkZA9UviIKmswxo9y8ap0po2n8HfRlIv1AHeT2L
         auqfJpHgHMWhAk6lJavwxT6V8fjptOH2jww2XdWTaIdZzSHtVkC9xmNykZfbN6LMU7as
         rv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720201333; x=1720806133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx6t+420ZDZCraDFpW85LzdL9pA2qdlTORVzQJ7eiy0=;
        b=BDrPJZu1Myk36oN6pdfDAOrtVMa+umrEdpOqqs1YjgCXG3Reo/yuBDMyCalUlzD6ZI
         L9mzrT4cjl7DmOR7XnRTvndcgijmzEqCSyJ0A8C9snr1wl+SLlzXf2ZNThsN3gBqkFCp
         GJ34U7qJezzq31ZYUVGnubFgG8RQKjTQXSmHFU1Uzemah/6E1IP2ftIvN7GE6ge42pzu
         cpWg/AJ6WxMSmtCA+9Peww+wrxt66D19MxXh/kbG0TnWw53ZPwJt2M+28xpHiwDHnQ4L
         HUTdlgzrdpTYmFjgRecIaYpIIG3bQXq5Po5n8ezunZV8tqv/hMF/twUTeRHvR6AQJ7rx
         e3/A==
X-Forwarded-Encrypted: i=1; AJvYcCW2wxu363EII462t7XXhcx0BDSUmNGPqiwfeCQMj76alXpMuqc7apVx5ZVFYbh5mUaiR3Aqihkk50fLMpp7kdGaS4sIUlxu6wJibXrg
X-Gm-Message-State: AOJu0Yw2aOVUUkE14l6r+IoRguVX+94Y8j4xeE96iVUmeJucKVzGIu0I
	fwJxnPRfPlKUaov9lZ4vwRgYw0oEBl8j6hxd8CYHQXBY0KEmuX5q9cO8sYMYZ3r7Oui6gOauapQ
	6PDgHkz3VGZB9dSFs9MiZ1vBFkNzSSjOlTcLa
X-Google-Smtp-Source: AGHT+IFH+FEn/il/MFGc9qCTllR3mQ+txUjFoNG8+hZggbiPPwy6pLBbbda7EE+80q41BUgsC0ffSk6XRqhDhb0Myh8=
X-Received: by 2002:ac8:750c:0:b0:447:dd54:2cd4 with SMTP id
 d75a77b69052e-447dd54374amr511811cf.22.1720201332702; Fri, 05 Jul 2024
 10:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <ZcN7P0CGUOOgki71@arm.com> <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>
 <ZogV9Iag4mxe6enx@arm.com>
In-Reply-To: <ZogV9Iag4mxe6enx@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 5 Jul 2024 11:41:34 -0600
Message-ID: <CAOUHufYwoTTsRBF_wWZU_jWzb8e6FF=vN8UKtVHBeXLBkwHWzA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	willy@infradead.org, wangkefeng.wang@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 9:49=E2=80=AFAM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Thu, Jun 27, 2024 at 03:19:55PM -0600, Yu Zhao wrote:
> > On Wed, Feb 7, 2024 at 5:44=E2=80=AFAM Catalin Marinas <catalin.marinas=
@arm.com> wrote:
> > > On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> > > > On 2024/1/26 2:06, Catalin Marinas wrote:
> > > > > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > > > > HVO was previously disabled on arm64 [1] due to the lack of nec=
essary
> > > > > > BBM(break-before-make) logic when changing page tables.
> > > > > > This set of patches fix this by adding necessary BBM sequence w=
hen
> > > > > > changing page table, and supporting vmemmap page fault handling=
 to
> > > > > > fixup kernel address translation fault if vmemmap is concurrent=
ly accessed.
> > > [...]
> > > > > How often is this code path called? I wonder whether a stop_machi=
ne()
> > > > > approach would be simpler.
> > > >
> > > > As long as allocating or releasing hugetlb is called.  We cannot
> > > > limit users to only allocate or release hugetlb when booting or
> > > > not running any workload on all other cpus, so if use
> > > > stop_machine(), it will be triggered 8 times every 2M and 4096
> > > > times every 1G, which is probably too expensive.
> > >
> > > I'm hoping this can be batched somehow and not do a stop_machine() (o=
r
> > > 8) for every 2MB huge page.
> >
> > Theoretically, all hugeTLB vmemmap operations from a single user
> > request can be done in one batch. This would require the preallocation
> > of the new copy of vmemmap so that the old copy can be replaced with
> > one BBM.
>
> Do we ever re-create pmd block entries back for the vmmemap range that
> was split or do they remain pmd table + pte entries? If the latter, I
> guess we could do a stop_machine() only for a pmd, it should be self
> limiting after a while.

It's the latter for now, but it can change in the future: we do want
to restore the original mapping at the PMD level; instead, we do it at
the PTE level because high-order pages backing PMD entries are not as
easy to allocate, compared with order-0 pages backing PTEs.

> I don't want user-space to DoS the system by
> triggering stop_machine() when mapping/unmapping hugetlbfs pages.

The operations are privileged, and each HVO or de-HVO request would
require at least one stop_machine(). So in theory, a privileged user
still can cause DoS.

> If I did the maths right, for a 2MB hugetlb page, we have about 8
> vmemmap pages (32K). Once we split a 2MB vmemap range,

Correct.

> whatever else
> needs to be touched in this range won't require a stop_machine().

There might be some misunderstandings here.

To do HVO:
1. we split a PMD into 512 PTEs;
2. for every 8 PTEs:
  2a. we allocate an order-0 page for PTE #0;
  2b. we remap PTE #0 *RW* to this page;
  2c. we remap PTEs #1-7 *RO* to this page;
  2d. we free the original order-3 page.

To do de-HVO:
1. for every 8 PTEs:
  1a. we allocate 7 order-0 pages.
  1b. we remap PTEs #1-7 *RW* to those pages, respectively.

We can in theory restore the original PTE or even PMD mappings at an
acceptable success rate by making changes on the MM side, e.g., only
allow movable allocations in the area backing the original PMD. Again,
we don't do it for now because high-order pages are not as easy to
allocate.

> > > Just to make sure I understand - is the goal to be able to free struc=
t
> > > pages corresponding to hugetlbfs pages?
> >
> > Correct, if you are referring to the pages holding struct page[].
> >
> > > Can we not leave the vmemmap in
> > > place and just release that memory to the page allocator?
> >
> > We cannot, since the goal is to reuse those pages for something else,
> > i.e., reduce the metadata overhead for hugeTLB.
>
> What I meant is that we can leave the vmemmap alias in place and just
> reuse those pages via the linear map etc. The kernel should touch those
> struct pages to corrupt the data. The only problem would be if we
> physically unplug those pages but I don't think that's the case here.

Set the repercussions of memory corruption aside, we still can't do
this because PTEs #1-7 need to map meaningful data, hence step 2c
above.


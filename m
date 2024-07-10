Return-Path: <linux-kernel+bounces-248340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27A92DBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556BCB25A82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBEE14A0B2;
	Wed, 10 Jul 2024 22:29:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E01EB40
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720650578; cv=none; b=M4veKgca0j+5egXFTGyJMPWrK9/MPYTpmuD1xXA5n9ccfGv950Y9Thlh1hGjvflrA3NSb5szC/bHGp68/A23fh5cUnx1S0awpAEO5VrFVp5kG0EEQEuphpWv3efwzRn1dfRpzQdye3Bye3sfuAKuX12rt6NnoZa1gH+zJ6Q32qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720650578; c=relaxed/simple;
	bh=sX8Ya7ibeN3Sp19U8X4Q/bM2HG3cFHIHzW1iLlQnFII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOd+kKUufw680ooM23kiQNmBomnA3SxKZIh2ohY8PpJ2UoX4ou2YeCeAipL9kW/8D4cN2svRlToX4f4Xxj/Q81ydUnepRtoKOqC5v7MF4BJG6bol2dK/GSeBv68eLEFH20OUE+JKIuHSy9o1YGlpWceyc+pf8h0BmcWOgWar/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E622FC32781;
	Wed, 10 Jul 2024 22:29:35 +0000 (UTC)
Date: Wed, 10 Jul 2024 23:29:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org,
	mike.kravetz@oracle.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	willy@infradead.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <Zo8LTaP-6-zIcc9v@arm.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <ZcN7P0CGUOOgki71@arm.com>
 <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>
 <ZogV9Iag4mxe6enx@arm.com>
 <CAOUHufYwoTTsRBF_wWZU_jWzb8e6FF=vN8UKtVHBeXLBkwHWzA@mail.gmail.com>
 <Zo68DP6siXfb6ZBR@arm.com>
 <CAOUHufZC0Jn=bTpc0JhqONXbYXgyBOVZ4j8bbKSJWv1dOSmQEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufZC0Jn=bTpc0JhqONXbYXgyBOVZ4j8bbKSJWv1dOSmQEA@mail.gmail.com>

On Wed, Jul 10, 2024 at 11:12:01AM -0600, Yu Zhao wrote:
> On Wed, Jul 10, 2024 at 10:51 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, Jul 05, 2024 at 11:41:34AM -0600, Yu Zhao wrote:
> > > On Fri, Jul 5, 2024 at 9:49 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > If I did the maths right, for a 2MB hugetlb page, we have about 8
> > > > vmemmap pages (32K). Once we split a 2MB vmemap range,
> > >
> > > Correct.
> > >
> > > > whatever else
> > > > needs to be touched in this range won't require a stop_machine().
> > >
> > > There might be some misunderstandings here.
> > >
> > > To do HVO:
> > > 1. we split a PMD into 512 PTEs;
> > > 2. for every 8 PTEs:
> > >   2a. we allocate an order-0 page for PTE #0;
> > >   2b. we remap PTE #0 *RW* to this page;
> > >   2c. we remap PTEs #1-7 *RO* to this page;
> > >   2d. we free the original order-3 page.
> >
> > Thanks. I now remember why we reverted such support in 060a2c92d1b6
> > ("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP"). The main
> > problem is that point 2c also changes the output address of the PTE
> > (and the content of the page slightly). The architecture requires a
> > break-before-make in such scenario, though it would have been nice if it
> > was more specific on what could go wrong.
> >
> > We can do point 1 safely if we have FEAT_BBM level 2. For point 2, I
> > assume these 8 vmemmap pages may be accessed and that's why we can't do
> > a break-before-make safely.
> 
> Correct
> 
> > I was wondering whether we could make the
> > PTEs RO first and then change the output address but we have another
> > rule that the content of the page should be the same. I don't think
> > entries 1-7 are identical to entry 0 (though we could ask the architects
> > for clarification here). Also, can we guarantee that nothing writes to
> > entry 0 while we would do such remapping?
> 
> Yes, it's already guaranteed.
> 
> > We know entries 1-7 won't be
> > written as we mapped them as RO but entry 0 contains the head page.
> > Maybe it's ok to map it RO temporarily until the newly allocated hugetlb
> > page is returned.
> 
> We can do that. I don't understand how this could elide BBM. After the
> above, we would still need to do:
> 3. remap entry 0 from RO to RW, mapping the `struct page` page that
> will be shared with entry 1-7.
> 4. remap entry 1-7 from their respective `struct page` pages to that
> of entry 0, while they remain RO.

The Arm ARM states that we need a BBM if we change the output address
and: the old or new mappings are RW *or* the content of the page
changes. Ignoring the latter (page content), we can turn the PTEs RO
first without changing the pfn followed by changing the pfn while they
are RO. Once that's done, we make entry 0 RW and, of course, with
additional TLBIs between all these steps. Can we leave entry 0 RO? This
would save an additional TLBI.

Now, I wonder if all this is worth it. What are the scenarios where the
8 PTEs will be accessed? The vmemmap range corresponding to a 2MB
hugetlb page for example is pretty well defined - 8 x 4K pages, aligned.

> > If we could get the above work, it would be a lot simpler than thinking
> > of stop_machine() or other locks to wait for such remapping.
> 
> Steps 3/4 would not require BBM somehow?

If we ignore the 'content' requirement, I think we could skip the BBM
but we need to make sure we don't change the permission and pfn at the
same time.

> > > To do de-HVO:
> > > 1. for every 8 PTEs:
> > >   1a. we allocate 7 order-0 pages.
> > >   1b. we remap PTEs #1-7 *RW* to those pages, respectively.
> >
> > Similar problem in 1.b, changing the output address. Here we could force
> > the content to be the same
> 
> I don't follow the "the content to be the same" part. After HVO, we have:
> 
> Entry 0 -> `struct page` page A, RW
> Entry 1 -> `struct page` page A, RO
> ...
> Entry 7 -> `struct page` page A, RO
> 
> To de-HVO, we need to make them:
> 
> Entry 0 -> `struct page` page A, RW
> Entry 1 -> `struct page` page B, RW
> ...
> Entry 7 -> `struct page` page H, RW
> 
> I assume the same content means PTE_0 == PTE_1/.../7?

That's the content of the page at the corresponding pfn before and after
the pte change. I'm pretty sure the Arm ARM states this in case the
hardware starts a load (e.g. unaligned) from one page and completes it
from another, the software should not see any difference. But for the
fields we care about in struct page, I assume they'd be the same (or
that we just don't care about inconsistencies during this transient
period).

-- 
Catalin


Return-Path: <linux-kernel+bounces-242709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FF928BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C804C1F24DE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A448516CD1F;
	Fri,  5 Jul 2024 15:49:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3418414B075
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720194553; cv=none; b=ZxGKJTHDwMN+EHsmntPos1H13oifpIm5Qo7QZs09QxcEOU2XyjdTbguqE+E1rVapnYwQDRZaScMVTdtqkB0uBr/itb2EjLW+ShQcLUChBb7E/e5GWWgasSbsHHRlxT7KoyQQOAbXn6suCbjxVQyfcqghyh3LBJOhBst6bNNHWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720194553; c=relaxed/simple;
	bh=KZ2hwB0YzC8jiIQReaTNZvM8jdvzAcBuZ6b8keK5eWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvhOUjJwy/MgHgeZvRhQ9g2i1nGjpuuYs2kxGB+I9UO8Rdzdekp2rE3y6DzB8KiiLAFEcF8oiZ6M4jGmgbeTgXa2blWjHFSERQcRC5xbSTCKyAlvTKvUFZhGuJbHYYH0odAae/fqfryWaRAV4nGXEJYh9CY8px8TTF/dDoy23GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B508C116B1;
	Fri,  5 Jul 2024 15:49:10 +0000 (UTC)
Date: Fri, 5 Jul 2024 16:49:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org,
	mike.kravetz@oracle.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	willy@infradead.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <ZogV9Iag4mxe6enx@arm.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <ZcN7P0CGUOOgki71@arm.com>
 <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>

On Thu, Jun 27, 2024 at 03:19:55PM -0600, Yu Zhao wrote:
> On Wed, Feb 7, 2024 at 5:44 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> > > On 2024/1/26 2:06, Catalin Marinas wrote:
> > > > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > > > HVO was previously disabled on arm64 [1] due to the lack of necessary
> > > > > BBM(break-before-make) logic when changing page tables.
> > > > > This set of patches fix this by adding necessary BBM sequence when
> > > > > changing page table, and supporting vmemmap page fault handling to
> > > > > fixup kernel address translation fault if vmemmap is concurrently accessed.
> > [...]
> > > > How often is this code path called? I wonder whether a stop_machine()
> > > > approach would be simpler.
> > > 
> > > As long as allocating or releasing hugetlb is called.  We cannot
> > > limit users to only allocate or release hugetlb when booting or
> > > not running any workload on all other cpus, so if use
> > > stop_machine(), it will be triggered 8 times every 2M and 4096
> > > times every 1G, which is probably too expensive.
> >
> > I'm hoping this can be batched somehow and not do a stop_machine() (or
> > 8) for every 2MB huge page.
> 
> Theoretically, all hugeTLB vmemmap operations from a single user
> request can be done in one batch. This would require the preallocation
> of the new copy of vmemmap so that the old copy can be replaced with
> one BBM.

Do we ever re-create pmd block entries back for the vmmemap range that
was split or do they remain pmd table + pte entries? If the latter, I
guess we could do a stop_machine() only for a pmd, it should be self
limiting after a while. I don't want user-space to DoS the system by
triggering stop_machine() when mapping/unmapping hugetlbfs pages.

If I did the maths right, for a 2MB hugetlb page, we have about 8
vmemmap pages (32K). Once we split a 2MB vmemap range, whatever else
needs to be touched in this range won't require a stop_machine().

> > Just to make sure I understand - is the goal to be able to free struct
> > pages corresponding to hugetlbfs pages?
> 
> Correct, if you are referring to the pages holding struct page[].
> 
> > Can we not leave the vmemmap in
> > place and just release that memory to the page allocator?
> 
> We cannot, since the goal is to reuse those pages for something else,
> i.e., reduce the metadata overhead for hugeTLB.

What I meant is that we can leave the vmemmap alias in place and just
reuse those pages via the linear map etc. The kernel should touch those
struct pages to corrupt the data. The only problem would be if we
physically unplug those pages but I don't think that's the case here.

-- 
Catalin


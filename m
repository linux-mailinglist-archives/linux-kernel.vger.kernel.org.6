Return-Path: <linux-kernel+bounces-249120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6733092E72C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9919F1C218BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88C15B0FA;
	Thu, 11 Jul 2024 11:39:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2B15ADB6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697996; cv=none; b=KOBZM/Dj2GwDM5LqrxNnKOLRzMduVmHqAmfaARLOuRJFczE540XTIICj99TRzaDjrXQZF99pvJGhI4fslISTrhX28cGGI8OQBFECbhF15GPx9ZDEn0rwP0eA/3PtMmloztDXcpDrfaChjZdFJRTylBGOFTfZtU53bJCaHjVmpFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697996; c=relaxed/simple;
	bh=jHGPtbpo/xmnLcNAei8qo1dp2N3vvBVljiSvVjZBd1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE3I4VUkWVjO0aq6Xz/vPlCaazkFx/BdKa9Qun+OFFT5Hk99Pg5nI9LKb6dhcVpQru56TZDxp8FY3TjESij9Hled69vCp7Wy47BzpEB2rcsxoTUmSDOnx2bMTSoibA0HmxL0ybnxo76HWIKO22o69Ns0XNWjw87UjFlgUterzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1D1C32786;
	Thu, 11 Jul 2024 11:39:54 +0000 (UTC)
Date: Thu, 11 Jul 2024 12:39:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org,
	mike.kravetz@oracle.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	willy@infradead.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <Zo_EiIm4ylNqO2ZR@arm.com>
References: <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <ZcN7P0CGUOOgki71@arm.com>
 <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>
 <ZogV9Iag4mxe6enx@arm.com>
 <CAOUHufYwoTTsRBF_wWZU_jWzb8e6FF=vN8UKtVHBeXLBkwHWzA@mail.gmail.com>
 <Zo68DP6siXfb6ZBR@arm.com>
 <CAOUHufZC0Jn=bTpc0JhqONXbYXgyBOVZ4j8bbKSJWv1dOSmQEA@mail.gmail.com>
 <Zo8LTaP-6-zIcc9v@arm.com>
 <CAOUHufawuXOifhrULx6mC0Kv0_sbjT0y16QMePiw=gH9b6xxAw@mail.gmail.com>
 <CAOUHufb3CHLCo54fZcPSG+mrXD-kRsa0Foi8=vL5=q+YHpQ+Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufb3CHLCo54fZcPSG+mrXD-kRsa0Foi8=vL5=q+YHpQ+Rg@mail.gmail.com>

On Thu, Jul 11, 2024 at 02:31:25AM -0600, Yu Zhao wrote:
> On Wed, Jul 10, 2024 at 5:07 PM Yu Zhao <yuzhao@google.com> wrote:
> > On Wed, Jul 10, 2024 at 4:29 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > The Arm ARM states that we need a BBM if we change the output address
> > > and: the old or new mappings are RW *or* the content of the page
> > > changes. Ignoring the latter (page content), we can turn the PTEs RO
> > > first without changing the pfn followed by changing the pfn while they
> > > are RO. Once that's done, we make entry 0 RW and, of course, with
> > > additional TLBIs between all these steps.
> >
> > Aha! This is easy to do -- I just made the RO guaranteed, as I
> > mentioned earlier.
> >
> > Just to make sure I fully understand the workflow:
> >
> > 1. Split a RW PMD into 512 RO PTEs, pointing to the same 2MB `struct page` area.

I don't think we can turn all of them RO here since some of those 512
PTEs are not related to the hugetlb page. So you'd need to keep them RW
but preserving the pfn so that there's no actual translation change. I
think that's covered by FEAT_BBM level 2. Basically this step should be
only about breaking up a PMD block entry into a table entry.

> > 2. TLBI once, after pmd_populate_kernel()
> > 3. Remap PTE 1-7 to the 4KB `struct page` area of PTE 0, for every 8
> >    PTEs, while they remain RO.

You may need some intermediate step to turn these PTEs read-only since
step 1 should leave them RW. Also, if we want to free and order-3 page
here, it might be better to allocate an order 0 even for PTE entry 0 (I
had the impression that's what the core code does, I haven't checked).

> > 4. TLBI once, after set_pte_at() on PTE 1-7.
> > 5. Change PTE 0 from RO to RW, pointing to the same 4KB `struct page` area.
> > 6. TLBI once, after set_pte_at() on PTE 0.
> > 
> > No BBM required, regardless of FEAT_BBM level 2.
> 
> I just studied D8.16.1 from the reference manual, and it seems to me:
> 1. We still need either FEAT_BBM or BBM to split PMD.

Yes.

> 2. We still need BBM when we change PTE 1-7, because even if they
> remain RO, the content of the `struct page` page at the new location
> does not match that at the old location.

Yes, in theory, the data at the new pfn should be the same. We could try
to get clarification from the architects on what could go wrong but I
suspect it's some atomicity is not guarantee if you read the data (the
CPU getting confused whether to read from the old or the new page).

Otherwise, since after all these steps PTEs 1-7 point to the same data
as PTE 0, before step 3 we could copy the data in page 0 over to the
other 7 pages while entries 1-7 are still RO. The remapping afterwards
would be fully compliant.

> > > Can we leave entry 0 RO? This would save an additional TLBI.
> >
> > Unfortunately we can't. Otherwise we wouldn't be able to, e.g., grab a
> > refcnt on any hugeTLB pages.

OK, fair enough.

> > > Now, I wonder if all this is worth it. What are the scenarios where the
> > > 8 PTEs will be accessed? The vmemmap range corresponding to a 2MB
> > > hugetlb page for example is pretty well defined - 8 x 4K pages, aligned.
> 
> One of the fundamental assumptions in core MM is that anyone can
> read or try to grab (write) a refcnt from any `struct page`. Those
> speculative PFN walkers include memory compaction, etc.

But how does this work if PTEs 1-7 are RO? Do those walkers detect it's
a tail page and skip it. Actually, if they all point to the same vmemmap
page, how can one distinguish a tail page via PTE 1 from the head page
via PTE 0?

BTW, I'll be on holiday from tomorrow for two weeks and won't be able to
follow up on this thread (and likely to forget all the discussion by the
time I get back ;)).

-- 
Catalin


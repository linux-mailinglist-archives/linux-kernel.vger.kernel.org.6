Return-Path: <linux-kernel+bounces-247981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A64B92D6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAB31C20F80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5250194AF8;
	Wed, 10 Jul 2024 16:51:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026219347D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630289; cv=none; b=Dzwb9YuJko4S0MH0/JsgKceGxT5TGT+zvso88vZeJW0HRnfxZvGKCM1BPCOAHa+GespKBL0mlMFP63CI/MRxsDQwnR9L/sHzNLV8NW4MKXX387UGqzDbLe7BR+eV0qMtdVUggPILIMOsinPPa+6MS9FJFITf4Ij5rWPfY2mH9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630289; c=relaxed/simple;
	bh=KMbR7EfVzwB9D5ZTMLl+uZI4Ij2acwu5IGFUS8yCHQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZtmlsghRT4TBnJkk9WI5hL8LSfFsv9mJ1g4i0iIRlAxHmcYT7W4aQP6yepBMRMRbHgLA3BCrHhow6bplBhK5ef7C2sOGeMNzSXUxFYs0cmqbw1YcaoPYCCXqFunqtIiM6OtcQ4DfQ8j1F/BtIF/a8VbAcFFwMq988sOxFWa7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DCBC32781;
	Wed, 10 Jul 2024 16:51:26 +0000 (UTC)
Date: Wed, 10 Jul 2024 17:51:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org,
	mike.kravetz@oracle.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	willy@infradead.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <Zo68DP6siXfb6ZBR@arm.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <ZcN7P0CGUOOgki71@arm.com>
 <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>
 <ZogV9Iag4mxe6enx@arm.com>
 <CAOUHufYwoTTsRBF_wWZU_jWzb8e6FF=vN8UKtVHBeXLBkwHWzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYwoTTsRBF_wWZU_jWzb8e6FF=vN8UKtVHBeXLBkwHWzA@mail.gmail.com>

On Fri, Jul 05, 2024 at 11:41:34AM -0600, Yu Zhao wrote:
> On Fri, Jul 5, 2024 at 9:49 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > If I did the maths right, for a 2MB hugetlb page, we have about 8
> > vmemmap pages (32K). Once we split a 2MB vmemap range,
> 
> Correct.
> 
> > whatever else
> > needs to be touched in this range won't require a stop_machine().
> 
> There might be some misunderstandings here.
> 
> To do HVO:
> 1. we split a PMD into 512 PTEs;
> 2. for every 8 PTEs:
>   2a. we allocate an order-0 page for PTE #0;
>   2b. we remap PTE #0 *RW* to this page;
>   2c. we remap PTEs #1-7 *RO* to this page;
>   2d. we free the original order-3 page.

Thanks. I now remember why we reverted such support in 060a2c92d1b6
("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP"). The main
problem is that point 2c also changes the output address of the PTE
(and the content of the page slightly). The architecture requires a
break-before-make in such scenario, though it would have been nice if it
was more specific on what could go wrong.

We can do point 1 safely if we have FEAT_BBM level 2. For point 2, I
assume these 8 vmemmap pages may be accessed and that's why we can't do
a break-before-make safely. I was wondering whether we could make the
PTEs RO first and then change the output address but we have another
rule that the content of the page should be the same. I don't think
entries 1-7 are identical to entry 0 (though we could ask the architects
for clarification here). Also, can we guarantee that nothing writes to
entry 0 while we would do such remapping? We know entries 1-7 won't be
written as we mapped them as RO but entry 0 contains the head page.
Maybe it's ok to map it RO temporarily until the newly allocated hugetlb
page is returned.

If we could get the above work, it would be a lot simpler than thinking
of stop_machine() or other locks to wait for such remapping.

> To do de-HVO:
> 1. for every 8 PTEs:
>   1a. we allocate 7 order-0 pages.
>   1b. we remap PTEs #1-7 *RW* to those pages, respectively.

Similar problem in 1.b, changing the output address. Here we could force
the content to be the same and remap PTEs 1-7 RO first to the new page,
turn them RW afterwards and it's all compliant with the architecture
(even without FEAT_BBM).

> > What I meant is that we can leave the vmemmap alias in place and just
> > reuse those pages via the linear map etc. The kernel should touch those
> > struct pages to corrupt the data. The only problem would be if we
> > physically unplug those pages but I don't think that's the case here.
> 
> Set the repercussions of memory corruption aside, we still can't do
> this because PTEs #1-7 need to map meaningful data, hence step 2c
> above.

Yeah, I missed this one.

-- 
Catalin


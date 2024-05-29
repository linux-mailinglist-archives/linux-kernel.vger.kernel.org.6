Return-Path: <linux-kernel+bounces-194320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0AD8D3A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D421F27A98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C016A379;
	Wed, 29 May 2024 14:59:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2E9D27E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994776; cv=none; b=DbIMFFsktmP4vMHYattwKxJUq0EaGZ01pDtYXtmHBGeZ1hRNy2Lsvfg7iZBxkrSAnrOIRq6PGV/hWQ/okhnMCfXGAoJGnCBpZ5wdcAUSXj6N3ZtRmBjzgegQFVA9p/8YKszDdd/0SV4Pa4sXqsXRmgeEzriSDtS5MB5p/rb65t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994776; c=relaxed/simple;
	bh=UHKZjpf1skOJpdAtuiUa+OI8N7rmSURssgbMjmMrXZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXCDWwNzQoTO5HCjpdhAbbk/vglBF25I9nIuN33FNz93DfPPuDAn6qRrV8Ro3w0RrkeFgZ8BT9sXbsb/cjoifJ2+0PvXWfG7N04TBc3+BFyh88Jnzi0MQT5D3Shjb0yjYeyhUlqARXw10GbPj4WpiDg4mKz47BJyk944nMo0TTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7475F339;
	Wed, 29 May 2024 07:59:58 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC97F3F762;
	Wed, 29 May 2024 07:59:31 -0700 (PDT)
Date: Wed, 29 May 2024 15:59:13 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Jeff Xie <xiehuan09@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Zach O'Keefe <zokeefe@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] mm: arm64: Fix the out-of-bounds issue in
 contpte_clear_young_dirty_ptes
Message-ID: <ZldCwWqI0JVIqh_3@J2N7QTR9R3.cambridge.arm.com>
References: <20240524005444.135417-1-21cnbao@gmail.com>
 <ZlWVHC0e2OadjwIa@J2N7QTR9R3>
 <CAGsJ_4xMdyBxwwh1AQeFM5a_ZMV2=y68M9eEuJf-D6NtYP-8dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xMdyBxwwh1AQeFM5a_ZMV2=y68M9eEuJf-D6NtYP-8dA@mail.gmail.com>

On Tue, May 28, 2024 at 08:39:55PM +1200, Barry Song wrote:
> On Tue, May 28, 2024 at 8:26 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, May 24, 2024 at 12:54:44PM +1200, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > We are passing a huge nr to __clear_young_dirty_ptes() right
> > > now. While we should pass the number of pages, we are actually
> > > passing CONT_PTE_SIZE. This is causing lots of crashes of
> > > MADV_FREE, panic oops could vary everytime.
> > >
> > > Fixes: 89e86854fb0a ("mm/arm64: override clear_young_dirty_ptes() batch helper")
> >
> > I was seeing ths same thing on v6.10-rc1 (syzkaller splat and reproducer
> > included at the end of the mail). The patch makes sense to me, and fixed the
> > splat in testing, so:
> >
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks!
> 
> > Since this only affects arm64 and is already in mainline, I assume the fix
> > should go via the arm64 tree even though the broken commit went via mm.
> 
> Either mm or arm64 is fine with me, but I noticed that Andrew has already
> included it in mm-hotfixes-unstable. If it works, we may want to stick with
> that. :-)

Going via mm is also fine by me, I had just expected it'd be quicker to
go via arm64 (and evidently I was wrong there!). :)

Mark.


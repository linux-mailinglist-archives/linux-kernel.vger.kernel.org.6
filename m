Return-Path: <linux-kernel+bounces-424791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48209DB97C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB561633C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2571AB533;
	Thu, 28 Nov 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnhZS14a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0906192D77
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803635; cv=none; b=tPsMY+gOjjZJFYNvccmYrKP0njo8bxKDIh5aTilvcI7RiPVwNf82Hsi4ZQiKb40MTzsnNy1vNno+q14qGKlZ330ssA2QHetOFe6XJ55GmoaqeuBv++7kpg4ky89+kjNUEXDYHxwkpZdigeM3QymWBWV6qeq2PmTQI5ZchgYWuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803635; c=relaxed/simple;
	bh=qLn7KCjfeNms18fyJ3R4Q7z/HaY/qcbgERgC7rBSsrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzlGkgj+3/AMGUOVNsIaFAdP85kBQiFEjHsk4hq6OEBj/1mRMQ02pyIpbbywMxydDgimhnmyJkNZezcVAuec4gettyjwms2wQXYBgNv615RECpbj/+figr2YaqFp8AwyQNkaI7rwzkqZugsdJ9mbZ1K5q1J7r/b/rR07LLaRVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnhZS14a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6D3C4CECE;
	Thu, 28 Nov 2024 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732803634;
	bh=qLn7KCjfeNms18fyJ3R4Q7z/HaY/qcbgERgC7rBSsrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnhZS14aE5CoghTDrv+dKiJwvpB9YXrZuVykroRSy9YysOGGCj0sGW1lbtqp5rxGE
	 E2szlbIyPkxndDXy6WDDz+5pQIpCQxO2/ue+2b10hELPyifwRFA150KkZIj0sATc3e
	 9LbIwSZI1OJDANcRomO7I2aF+owml7Lo9HMBg65LWXGfgfW2MI+6ckPLFeMMy7lkPn
	 gJYAoLN4sscAXjMOHJBZ+Q1XCO3vfy7230pNkFexFrHUTNYXU1kGI80o7iiWkvTpCC
	 Odt9M6KdWxJfgJ5hlw1WHKuetIRjZTyxsZmG2FXwt7ErUJe+YRQvSLTONY81VgCX9a
	 O776BICHiG4GQ==
Date: Thu, 28 Nov 2024 14:20:28 +0000
From: Will Deacon <will@kernel.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nanyong Sun <sunnanyong@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/6] mm/arm64: re-enable HVO
Message-ID: <20241128142028.GA3506@willie-the-truck>
References: <20241107202033.2721681-1-yuzhao@google.com>
 <20241125152203.GA954@willie-the-truck>
 <CAOUHufYUMYcf=uF7=2zj-PsGXePCDdsRHJGa8t-e-k9VUvYyQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYUMYcf=uF7=2zj-PsGXePCDdsRHJGa8t-e-k9VUvYyQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Nov 25, 2024 at 03:22:47PM -0700, Yu Zhao wrote:
> On Mon, Nov 25, 2024 at 8:22 AM Will Deacon <will@kernel.org> wrote:
> > On Thu, Nov 07, 2024 at 01:20:27PM -0700, Yu Zhao wrote:
> > > HVO was disabled by commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable
> > > HUGETLB_PAGE_OPTIMIZE_VMEMMAP") due to the following reason:
> > >
> > >   This is deemed UNPREDICTABLE by the Arm architecture without a
> > >   break-before-make sequence (make the PTE invalid, TLBI, write the
> > >   new valid PTE). However, such sequence is not possible since the
> > >   vmemmap may be concurrently accessed by the kernel.
> > >
> > > This series presents one of the previously discussed approaches to
> > > re-enable HugeTLB Vmemmap Optimization (HVO) on arm64.
> >
> > Before jumping into the new mechanisms here, I'd really like to
> > understand how the current code is intended to work in the relatively
> > simple case where the vmemmap is page-mapped to start with (i.e. when we
> > don't need to worry about block-splitting).
> >
> > In that case, who are the concurrent users of the vmemmap that we need
> > to worry about?
> 
> Any speculative PFN walkers who either only read `struct page[]` or
> attempt to increment page->_refcount if it's not zero.
> 
> > Is it solely speculative references via
> > page_ref_add_unless() or are there others?
> 
> page_ref_add_unless() needs to be successful before writes can follow;
> speculative reads are always allowed.
> 
> > Looking at page_ref_add_unless(), what serialises that against
> > __hugetlb_vmemmap_restore_folio()? I see there's a synchronize_rcu()
> > call in the latter, but what prevents an RCU reader coming in
> > immediately after that?
> 
> In page_ref_add_unless(), the condtion `!page_is_fake_head(page) &&
> page_ref_count(page)` returns false before a PTE becomes RO.
> 
> For HVO, i.e., a PTE being switched from RW to RO, page_ref_count() is
> frozen (remains zero), followed by synchronize_rcu(). After the
> switch, page_is_fake_head() is true and it appears before
> page_ref_count() is unfrozen (become non-zero), so the condition
> remains false.
> 
> For de-HVO, i.e., a PTE being switched from RO to RW, page_ref_count()
> again is frozen, followed by synchronize_rcu(). Only this time
> page_is_fake_head() is false after the switch, and again it appears
> before page_ref_count() is unfrozen. To answer your question, readers
> coming in immediately after that won't be able to see non-zero
> page_ref_count() before it sees page_is_fake_head() being false. IOW,
> regarding whether it is RW, the condition can be false negative but
> never false positive.

Thanks, but I'm still not seeing how this works. When you say "appears
before", I don't see any memory barriers in page_ref_add_unless() that
enforce that e.g. the refcount and the flags are checked in order and
I can't see how the synchronize_rcu() helps either as it's called really
earlyi (I think that's just there for the static key).

If page_is_fake_head() is reliable, then I'm thinking we could use that
to steer page_ref_add_unless() away from the tail pages during the
remapping operations and it would be fine to use a break-before-make
sequence.

Will


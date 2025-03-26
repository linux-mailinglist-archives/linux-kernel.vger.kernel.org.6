Return-Path: <linux-kernel+bounces-576930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C797CA71626
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3624189027E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE021DE3B7;
	Wed, 26 Mar 2025 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhPUdmq1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738819E992;
	Wed, 26 Mar 2025 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990386; cv=none; b=sxrfXv4IE56yuGYXlezVUnTcwmEX237Av2YK5Ftbec4K5LyUiQlwHsNeocTd4unRgIuugfpN5WMkRyRWpGW4I3pXpg4wbhJbmP1e0D26oUfuDvKhWbHmBhn0bBPGBx0s0qQYeioZCr5UV4TZBJItGh6VRNTSbvmOonMWtpOnNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990386; c=relaxed/simple;
	bh=cjxrsIzX/WPyXr7qdJpErRGIpF/kZxl22HylGb7mEwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks1Quqh5GN6SeuNLLtKuMA8hC1dPRBassCMCa0YzxCMT1JiNEPCgX/dRGiXlMkNBvLYhiw7targ8AXWQKxdrWJn1bWUK2dPJEcZMKFnuiG2aiWSsQGPr+FHPItEnMknBgRGNf/DnurFXUBcjd6oKvKpVNSYQnvYavpOJXRrXGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhPUdmq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8AEC4CEE2;
	Wed, 26 Mar 2025 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742990385;
	bh=cjxrsIzX/WPyXr7qdJpErRGIpF/kZxl22HylGb7mEwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhPUdmq1h7gvCSyDJ4n5B+4eRaGO5moH9CfG7jg7AQW5aPyeCDq2hBlFxoYjjVSlZ
	 VC/V+Bixj8HZzyowNqA066Z5Np/7rN3pTPMilK3q5mgy0LnHOq+14v86HCYR2l+yn6
	 e6g8oVWNq4Oy9Ij3p/6BCYiNZnS5659ckKwyTePqMI8tZZz0VPq9KTqvsWWEwQ9zsJ
	 f/61VbQQ9B4OxQWSMiWDMS+ss5uyO8eyB1ZikVuHGAoUaYZ7BLWyzPftmXh+1uIeY+
	 ru6EG6DyITSaRWZbJTdd9xC6DquohsYrSIlfLjsLjC60xDWGZmxOIvftTBoNzZfTMB
	 7ZVrb394mhsAg==
Date: Wed, 26 Mar 2025 07:59:40 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Frank van der Linden <fvdl@google.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation
 helpers
Message-ID: <Z-PsLDv-DkxitRv1@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-8-changyuanl@google.com>
 <CAPTztWbFXajArSN8yKu32eSoR=xsk1CHM_4V7MJ0eQxydFqPUQ@mail.gmail.com>
 <Z-MB0Cj4tM6QgOAg@kernel.org>
 <CAPTztWbDtDhKZS89-aEBaZoPW2jZM2CAWW1Y_m3OnNE26=d9UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWbDtDhKZS89-aEBaZoPW2jZM2CAWW1Y_m3OnNE26=d9UQ@mail.gmail.com>

On Tue, Mar 25, 2025 at 02:56:52PM -0700, Frank van der Linden wrote:
> On Tue, Mar 25, 2025 at 12:19 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Mar 24, 2025 at 11:40:43AM -0700, Frank van der Linden wrote:
> [...]
> > > Thanks for the work on this.
> > >
> > > Obviously it needs to happen while memblock is still active - but why
> > > as close as possible to buddy initialization?
> >
> > One reason is to have all memblock allocations done to autoscale the
> > scratch area. Another reason is to keep memblock structures small as long
> > as possible as memblock_reserve()ing the preserved memory would quite
> > inflate them.
> >
> > And it's overall simpler if memblock only allocates from scratch rather
> > than doing some of early allocations from scratch and some elsewhere and
> > still making sure they avoid the preserved ranges.
> 
> Ah, thanks, I see the argument for the scratch area sizing.
> 
> >
> > > Ordering is always a sticky issue when it comes to doing things during
> > > boot, of course. In this case, I can see scenarios where code that
> > > runs a little earlier may want to use some preserved memory. The
> >
> > Can you elaborate about such scenarios?
> 
> There has, for example, been some talk about making hugetlbfs
> persistent. You could have hugetlb_cma active. The hugetlb CMA areas
> are set up quite early, quite some time before KHO restores memory. So
> that would have to be changed somehow if the location of the KHO init
> call would remain as close as possible to buddy init as possible. I
> suspect there may be other uses.

I think we can address this when/if implementing preservation for hugetlbfs
and it will be tricky. 
If hugetlb in the first kernel uses a lot of memory, we just won't have
enough scratch space for early hugetlb reservations in the second kernel
regardless of hugetlb_cma. On the other hand, we already have the preserved
hugetlbfs memory, so we'd probably need to reserve less memory in the
second kernel.

But anyway, it's completely different discussion about how to preserve
hugetlbfs.
 
> > > current requirement in the patch set seems to be "after sparse/page
> > > init", but I'm not sure why it needs to be as close as possibly to
> > > buddy init.
> >
> > Why would you say that sparse/page init would be a requirement here?
> 
> At least in its current form, the KHO code expects vmemmap to be
> initialized, as it does its restore base on page structures, as
> deserialize_bitmap expects them. I think the use of the page->private
> field was discussed in a separate thread, I think. If that is done
> differently, it wouldn't rely on vmemmap being initialized.

In the current form KHO does relies on vmemmap being allocated, but it does
not rely on it being initialized. Marking memblock ranges NOINT ensures
nothing touches the corresponding struct pages and KHO can use their fields
up to the point the memory is returned to KHO callers.
 
> A few more things I've noticed (not sure if these were discussed before):
> 
> * Should KHO depend on CONFIG_DEFERRED_STRUCT_PAGE_INIT? Essentially,
> marking memblock ranges as NOINIT doesn't work without
> DEFERRED_STRUCT_PAGE_INIT. Although, if the page->private use
> disappears, this wouldn't be an issue anymore.

It does. 
memmap_init_reserved_pages() is called always, no matter of
CONFIG_DEFERRED_STRUCT_PAGE_INIT is set or not and it skips initialization
of NOINIT regions.

> * As a future extension, it could be nice to store vmemmap init
> information in the KHO FDT. Then you can use that to init ranges in an
> optimized way (HVO hugetlb or DAX-style persisted ranges) straight
> away.
 
These days memmap contents is unstable because of the folio/memdesc
project, but in general carrying memory map data from kernel to kernel is
indeed something to consider.

> - Frank

-- 
Sincerely yours,
Mike.


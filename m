Return-Path: <linux-kernel+bounces-198916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40EF8D7F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F5C1C20DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3CA84A32;
	Mon,  3 Jun 2024 09:35:24 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E453B84A2F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407324; cv=none; b=N8JXjRyOgPLpAne7o9AoAsctRwv9Spt1Wg0UB+2zkx18r04OT9IXk7yKRuyBb3Ms+qQEXNI+QKH83J+vV4cyG8DulNg7VoDY2ouanjva1U9+J2mv4bOmxUBAYHglVzn4NHbojy6Z+E2rNfDoWH0gmt4dtOrI+GM1OVEcHOtbd98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407324; c=relaxed/simple;
	bh=BrWArai6JPydr1Fs/+Dkieqx/1gPi2kBDlb48gbbQpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb5rBVigM7IkRJrvG6QK+blMT+O57BGfouwnuHXU84CwNhzZT9QGw4cwdkYUYW1Ln//gqbfysbaFU4f+XzfqaKFJpcoo/wClRAzp+AGTLHqFDcfMbhhvB8T2ZIEz+wXtBnljzrt6tHx9qBcriJpwHE43yBCrnsUi20lA/BHfRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-a8-665d8e4e60ff
Date: Mon, 3 Jun 2024 18:35:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Byungchul Park <lkml.byungchul.park@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
Message-ID: <20240603093505.GA12549@system.software.com>
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXC9ZZnoa5fX2yaweTJyhZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFpd3zWGzuLfmP6vF0c5NzBbnd61ltdixdB+TxaUDC5gs
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH1l51H49RrbB6fN8kF8EVx2aSk
	5mSWpRbp2yVwZcy9+pStYKNkxeNZwQ2MN4S7GDk5JARMJB513maEsY/MncIKYrMIqEgs+PSd
	HcRmE1CXuHHjJzOILSKgIbGpbQOYzSxwjFni/35VEFtYoEDi1YRJYPW8AhYSv1dvAZsjJHCY
	SeLV9QiIuKDEyZlPWCB6tSRu/HvJ1MXIAWRLSyz/xwES5hSwk2g6dRbsHFEBZYkD244DlXAB
	nbaNXWJt5yImiDslJQ6uuMEygVFgFpKxs5CMnYUwdgEj8ypGocy8stzEzBwTvYzKvMwKveT8
	3E2MwMhcVvsnegfjpwvBhxgFOBiVeHgv5MSkCbEmlhVX5h5ilOBgVhLh7auLThPiTUmsrEot
	yo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAmDdbXKq4s7PwlPuEeg8/
	Z615WztzsmdH6ytoTamfNdHS7XLN5Mqajw7vfjl1CpnveO4Qz7g9aWPEihWlB9p7T/feWFi5
	+9acVTnRCzjWvH3E8SLcatVMD7aFAgVLv711VOC6yXm0yZyp8b2U3P7P8wJFm8+3uDhNaxPq
	CdU/ejH6Y+KUc8W6SizFGYmGWsxFxYkAyYmT/sgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsXC5WfdrOvXF5tm0LJQzGLO+jVsFp83/GOz
	+PTyAaPFiw3tjBZf1/9itnj6qY/F4vDck6wWl3fNYbO4t+Y/q8XRzk3MFud3rWW12LF0H5PF
	pQMLmCyO9x5gsph/7zObxeZNU5ktjk+Zymjx+wdQx8lZk1kchD2+t/axeOycdZfdY8GmUo/N
	K7Q8Fu95yeSxaVUnm8emT5PYPd6dO8fucWLGbxaPeScDPd7vu8rmsfjFByaPrb/sPBqnXmPz
	+LxJLoA/issmJTUnsyy1SN8ugStj7tWnbAUbJSsezwpuYLwh3MXIySEhYCJxZO4UVhCbRUBF
	YsGn7+wgNpuAusSNGz+ZQWwRAQ2JTW0bwGxmgWPMEv/3q4LYwgIFEq8mTAKr5xWwkPi9egvY
	HCGBw0wSr65HQMQFJU7OfMIC0aslcePfS6YuRg4gW1pi+T8OkDCngJ1E06mzjCC2qICyxIFt
	x5kmMPLOQtI9C0n3LITuBYzMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQLjbFntn4k7GL9c
	dj/EKMDBqMTD+yIpNk2INbGsuDL3EKMEB7OSCG9fXXSaEG9KYmVValF+fFFpTmrxIUZpDhYl
	cV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+Oytzv4Psem5O2clRTjzuxfxukRUvatkfOV7/zI
	JdHnzZkcs1x4wyznZE05xnTg0f8579N6XmbE/bWbM3+L8FvJl0f1jW7oX7CwO2LfE5d++sLD
	5eKM85YHttccKssL+KXGfVNsx7wlvEffZmgsnX/hq555/Sfzh2Xdx9cw8OeLcfncbq/+pK3E
	UpyRaKjFXFScCABmvynUrwIAAA==
X-CFilter-Loop: Reflected

On Sat, Jun 01, 2024 at 09:22:17AM +0200, David Hildenbrand wrote:
> On 31.05.24 23:46, Dave Hansen wrote:
> > On 5/31/24 11:04, Byungchul Park wrote:
> > ...
> > > I don't believe you do not agree with the concept itself.  Thing is
> > > the current version is not good enough.  I will do my best by doing
> > > what I can do.
> > 
> > More performance is good.  I agree with that.
> > 
> > But it has to be weighed against the risk and the complexity.  The more
> > I look at this approach, the more I think this is not a good trade off.
> > There's a lot of risk and a lot of complexity and we haven't seen the
> > full complexity picture.  The gaps are being fixed by adding complexity
> > in new subsystems (the VFS in this case).
> > 
> > There are going to be winners and losers, and this version for example
> > makes file writes lose performance.
> > 
> > Just to be crystal clear: I disagree with the concept of leaving stale
> > TLB entries in place in an attempt to gain performance.
> 
> There is the inherent problem that a CPU reading from such (unmapped but not
> flushed yet) memory will not get a page fault, which I think is the most
> controversial part here (besides interaction with other deferred TLB
> flushing, and how this glues into the buddy).
> 
> What we used to do so far was limiting the timeframe where that could
> happen, under well-controlled circumstances. On the common unmap/zap path,
> we perform the batched TLB flush before any page faults / VMA changes would
> have be possible and munmap() would have returned with "succeess". Now that
> time frame could be significantly longer.
> 
> So in current code, at the point in time where we would process a page
> fault, mmap()/munmap()/... the TLB would have been flushed already.
> 
> To "mimic" the old behavior, we'd essentially have to force any page
> faults/mmap/whatsoever to perform the deferred flush such that the CPU will
> see the "reality" again. Not sure how that could be done in a *consistent*

In luf's point of view, the points where the deferred flush should be
performed are simply:

	1. when changing the vma maps, that might be luf'ed.
	2. when updating data of the pages, that might be luf'ed.

All we need to do is to indentify the points:

	1. when changing the vma maps, that might be luf'ed.

	   a) mmap and munmap e.i. fault handler or unmap_region().
	   b) permission to writable e.i. mprotect or fault handler.
	   c) what I'm missing.

	2. when updating data of the pages, that might be luf'ed.

	   a) updating files through vfs e.g. file_end_write().
	   b) updating files through writable maps e.i. 1-a) or 1-b).
	   c) what I'm missing.

Some of them are already performing necessary tlb flush and the others
are not.  luf has to handle the others, that I've been focusing on.  Of
course, there might be what I'm missing tho.

Worth noting again, luf is working only on *migration* and *reclaim*
currently.  Thing is when to stop the pending initiated from migration
or reclaim by luf.

	Byungchul

> way (check whenever we take the mmap/vma lock etc ...) and if there would
> still be a performance win.
> 
> -- 
> Cheers,
> 
> David / dhildenb


Return-Path: <linux-kernel+bounces-189998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D358CF83F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE73B20DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B542FD528;
	Mon, 27 May 2024 04:03:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09612D502
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782584; cv=none; b=oWApTT3b8X3TH+fDWyBYc2iMDmfdkVECgwdg/rLLXfkWEJrMWZm6UO8E6e5FiWgj3wHVYGoDK+EG4UtLUuTshj8wDzYehotND83GE7LG6gWr8Src9HwkufIKSbaMwunENFdXVuQaYBlcQoIm6aPJ1+nInH0Y4Isn4UueJF/fTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782584; c=relaxed/simple;
	bh=iFsO/uDenGFjNxv/Aedsr/2qc9SLqkBaJgizzpFNTHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvJkyLZ/L18PqTSVGZV4dzF2jb1G1/TtIFWIuyY+tAnX8O3GwKFe4jMH2g8YX7KD3lW5zzfda9wxXDbP/m5fHNjJ9KoWXmX1rPAMBEgXBL4q/70K0+q5O0y6ul6rWxuU7tqTLLB7NfYFwjcTx0z7eYW8VyrTtIXTteLytrGzXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-eb-6654045d84c7
Date: Mon, 27 May 2024 12:56:08 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240527035608.GB12937@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXC9ZZnoe4H1pA0g7dfdSzmrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkAviiuGxSUnMyy1KL
	9O0SuDI+HbvGWvBGouL1ssUsDYyPhboYOTkkBEwkGietZu9i5ACzL7eLgYRZBFQlJr/8zApi
	swmoS9y48ZMZxBYR0JD4tHA5UDkXB7NAH7PEmsWHGEESwgIhEtM+rGECsXkFLCQuLN0PZgsJ
	nGaU2NrmChEXlDg58wkLiM0soCVx499LJpC9zALSEsv/cYCYnAJ2Eg93SIJUiAooSxzYdpwJ
	ZJWEwC52iU37z7FCnCwpcXDFDZYJjAKzkEydhWTqLISpCxiZVzEKZeaV5SZm5pjoZVTmZVbo
	JefnbmIExuOy2j/ROxg/XQg+xCjAwajEw5vhHpwmxJpYVlyZe4hRgoNZSYRXZF5gmhBvSmJl
	VWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZGAQW3lAO/3WLNZB3u
	b5lx7H1wh+018V0q2m98bGUuKvn1s1/j2vx/j3VNS9/JiTP2Sd29ciUswPPU8kMdr1jEa431
	rzHHqr+49VaCfdo3oa+le74dXCAeWMAgtYIzSi1cSlD0KnsIT2D71IYlNVqu35UXrPWe63un
	rbOUPaFuJ8OsG4+4t/xQYinOSDTUYi4qTgQAiJQRe8MCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXC5WfdrBvLEpJmcGKFuMWc9WvYLD5v+Mdm
	8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/Vovzu9ayWuxYuo/J4tKBBUwW
	x3sPMFnMv/eZzWLzpqnMFsenTGW0+P0DqPjkrMksDkIe31v7WDx2zrrL7rFgU6nH5hVaHov3
	vGTy2LSqk81j06dJ7B7vzp1j9zgx4zeLx7yTgR7v911l81j84gOTx9Zfdh6NU6+xeXzeJBfA
	H8Vlk5Kak1mWWqRvl8CV8enYNdaCNxIVr5ctZmlgfCzUxcjBISFgInG5XayLkZODRUBVYvLL
	z6wgNpuAusSNGz+ZQWwRAQ2JTwuXs3cxcnEwC/QxS6xZfIgRJCEsECIx7cMaJhCbV8BC4sLS
	/WC2kMBpRomtba4QcUGJkzOfsIDYzAJaEjf+vWQC2cssIC2x/B8HiMkpYCfxcIckSIWogLLE
	gW3HmSYw8s5C0jwLSfMshOYFjMyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAqNrWe2fiTsY
	v1x2P8QowMGoxMOb4R6cJsSaWFZcmXuIUYKDWUmEV2ReYJoQb0piZVVqUX58UWlOavEhRmkO
	FiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QD4/zrMn9mpt5cXHXij9nO8hUH/L6cSeTd8XhJ
	yp8V3jyfPr3q+SLn/m/L9N3quYFm1xMu1P8Qn9fZdUH00MtLbSly9hMdU5wXPP8SqK/2XKom
	ZVP1pt06Xaf4/+rWpVYeVXeZem/imTdN09ZMn9Tss6XcZqd/2q46c3f7KyY/ll2qq/mscvxN
	vasSS3FGoqEWc1FxIgDJUBi2qgIAAA==
X-CFilter-Loop: Reflected

On Mon, May 27, 2024 at 11:10:15AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Fri, May 24, 2024 at 10:16:39AM -0700, Dave Hansen wrote:
> >> On 5/9/24 23:51, Byungchul Park wrote:
> >> > To achieve that:
> >> > 
> >> >    1. For the folios that map only to non-writable tlb entries, prevent
> >> >       tlb flush during unmapping but perform it just before the folios
> >> >       actually become used, out of buddy or pcp.
> >> 
> >> Is this just _pure_ unmapping (like MADV_DONTNEED), or does it apply to
> >> changing the memory map, like munmap() itself?
> >
> > I think it can be applied to any unmapping of ro ones but LUF for now is
> > working only with unmapping during folio migrion and reclaim.
> >
> >> >    2. When any non-writable ptes change to writable e.g. through fault
> >> >       handler, give up luf mechanism and perform tlb flush required
> >> >       right away.
> >> > 
> >> >    3. When a writable mapping is created e.g. through mmap(), give up
> >> >       luf mechanism and perform tlb flush required right away.
> >> 
> >> Let's say you do this:
> >> 
> >> 	fd = open("/some/file", O_RDONLY);
> >> 	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
> >> 	foo1 = *ptr1;
> >> 
> >> You now have a read-only PTE pointing to the first page of /some/file.
> >> Let's say try_to_unmap() comes along and decides it can_luf_folio().
> >> The page gets pulled out of the page cache and freed, the PTE is zeroed.
> >>  But the TLB is never flushed.
> >> 
> >> Now, someone does:
> >> 
> >> 	fd2 = open("/some/other/file", O_RDONLY);
> >> 	ptr2 = mmap(ptr1, size, PROT_READ, MAP_FIXED, fd, ...);
> >> 	foo2 = *ptr2;
> >> 
> >> and they overwrite the old VMA.  Does foo2 have the contents of the new
> >> "/some/other/file" or the old "/some/file"?  How does the new mmap()
> >
> > Good point.  It should've give up LUF at the 2nd mmap() in this case.
> > I will fix it by introducing a new flag in task_struct indicating if LUF
> > has left stale maps for the task so that LUF can give up and flush right
> > away in mmap().
> >
> >> know that there was something to flush?
> >> 
> >> BTW, the same thing could happen without a new mmap().  Someone could
> >> modify the file in the middle, maybe even from another process.
> >
> > Thank you for the pointing out.  I will fix it too by introducing a new
> > flag in inode or something to make LUF aware if updating the file has
> > been tried so that LUF can give up and flush right away in the case.
> >
> > Plus, I will add another give-up at code changing the permission of vma
> > to writable.
> 
> I guess that you need a framework similar as
> "flush_tlb_batched_pending()" to deal with interaction with other TLB
> related operations.

Thank you.  I will check it.

	Byungchul

> --
> Best Regards,
> Huang, Ying
> 
> > Thank you very much.
> >
> > 	Byungchul
> >
> >> 	fd = open("/some/file", O_RDONLY);
> >> 	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
> >> 	foo1 = *ptr1;
> >> 	// LUF happens here
> >> 	// "/some/file" changes
> >> 	foo2 = *ptr1; // Does this see the change?


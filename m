Return-Path: <linux-kernel+bounces-189933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500D38CF75B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD221B20D78
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 01:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A77C2CA9;
	Mon, 27 May 2024 01:57:52 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF111FAA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716775072; cv=none; b=fIf/Y+60dNHy2Zq4FHB/8x3acKJNNeMv22ePIw0q+n9IfPvfNlVWqbFNj0LOfK2IUwgl0s02aOuEo5WsPJ/CyqMBq1QvgWBaML0fKq9s0K1AQynbb4pvEcYrq1ZX/4g4u9R/kBrrbiQ1XmyXpG1w9wFUYyyS8XhO0Bb64l7omw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716775072; c=relaxed/simple;
	bh=kpaceyumnWQ5sTnWHpRvrFJyT/NosuIbx7jC3ZS1lqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhB4BVyFqNEO1T+Mbq3sLNW2rSSknK31XtFoxPb7OlY2ca9fDXfhfs4yk3GRYBIDauD7z1y9xJdDDKZlci/vpiR/5YKd4T5EcWIP24COefk620EPPiVX4WxSCmx20+Joq97Cf/HoXZEhUtsOvBy5oRwpVEhMaQA8XAC7YyVXaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-f4-6653e89109d3
Date: Mon, 27 May 2024 10:57:32 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240527015732.GA61604@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsXC9ZZnoe7EF8FpBh83m1nMWb+GzeLzhn9s
	Fp9ePmC0eLGhndHi6/pfzBZPP/WxWFzeNYfN4t6a/6wW53etZbXYsXQfk8WlAwuYLI73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DxyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJBfBFcdmkpOZklqUW
	6dslcGV83LGDvWCXSMXSP9/YGxgv8HcxcnJICJhInPh+kB3GnjJ3AwuIzSKgKtHU1c8MYrMJ
	qEvcuPETzBYBsk+tXA5Uz8XBLPCfSeL+w1awhLBAiMS0D2uYQGxeAQuJFed3sIHYQgIZEjNu
	XGSHiAtKnJz5BGwBs4CWxI1/L4HqOYBsaYnl/zhAwpwCthLLmnaCjREVUJY4sO04E8guCYFN
	7BLzLz5ngzhUUuLgihssExgFZiEZOwvJ2FkIYxcwMq9iFMrMK8tNzMwx0cuozMus0EvOz93E
	CIzJZbV/oncwfroQfIhRgINRiYc3wz04TYg1say4MvcQowQHs5IIr8i8wDQh3pTEyqrUovz4
	otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjPE1S//+lcrOtw9za/m1V21u
	ifNVTbkZmzYYpun9jzF4Vv1VfbHStcM1P1U3/JHhz+yOWtdQVnDno95FiVnaU73SMoyYbq6N
	+bpu1xWpWYbf03TqeHY9fP1wqn326fMKJtfFPryTrOIOylzt895m9wQlTfHHcy4wqqu2ZGwN
	iPiWf0lwedjM90osxRmJhlrMRcWJAIzPxWrFAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5WfdrDvxRXCawa25ahZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFofnnmS1uLxrDpvFvTX/WS3O71rLarFj6T4mi0sHFjBZ
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoOKTsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k1wA
	fxSXTUpqTmZZapG+XQJXxscdO9gLdolULP3zjb2B8QJ/FyMnh4SAicSUuRtYQGwWAVWJpq5+
	ZhCbTUBd4saNn2C2CJB9auVy9i5GLg5mgf9MEvcftoIlhAVCJKZ9WMMEYvMKWEisOL+DDcQW
	EsiQmHHjIjtEXFDi5MwnYAuYBbQkbvx7CVTPAWRLSyz/xwES5hSwlVjWtBNsjKiAssSBbceZ
	JjDyzkLSPQtJ9yyE7gWMzKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECI2xZ7Z+JOxi/XHY/
	xCjAwajEw5vhHpwmxJpYVlyZe4hRgoNZSYRXZF5gmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
	r/DUBCGB9MSS1OzU1ILUIpgsEwenVANjjPK/Bl4XLqVLqjmZa/dPObNwldCji599L+x+HloQ
	POfuCsW73RnFStHZLa8/G7/5nSnheNiuqDeiZMOX06/fnha5NNG16ZjQ8jhWWb81xQLVXb/N
	Jpjuqb9dd52xTyr/VwyjCFOjtmVrV1Xonj/Mkw3MXlmWrf22KlUt+vL2is9xzmpCD5crsRRn
	JBpqMRcVJwIAdZB/vawCAAA=
X-CFilter-Loop: Reflected

On Fri, May 24, 2024 at 10:16:39AM -0700, Dave Hansen wrote:
> On 5/9/24 23:51, Byungchul Park wrote:
> > To achieve that:
> > 
> >    1. For the folios that map only to non-writable tlb entries, prevent
> >       tlb flush during unmapping but perform it just before the folios
> >       actually become used, out of buddy or pcp.
> 
> Is this just _pure_ unmapping (like MADV_DONTNEED), or does it apply to
> changing the memory map, like munmap() itself?

I think it can be applied to any unmapping of ro ones but LUF for now is
working only with unmapping during folio migrion and reclaim.

> >    2. When any non-writable ptes change to writable e.g. through fault
> >       handler, give up luf mechanism and perform tlb flush required
> >       right away.
> > 
> >    3. When a writable mapping is created e.g. through mmap(), give up
> >       luf mechanism and perform tlb flush required right away.
> 
> Let's say you do this:
> 
> 	fd = open("/some/file", O_RDONLY);
> 	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
> 	foo1 = *ptr1;
> 
> You now have a read-only PTE pointing to the first page of /some/file.
> Let's say try_to_unmap() comes along and decides it can_luf_folio().
> The page gets pulled out of the page cache and freed, the PTE is zeroed.
>  But the TLB is never flushed.
> 
> Now, someone does:
> 
> 	fd2 = open("/some/other/file", O_RDONLY);
> 	ptr2 = mmap(ptr1, size, PROT_READ, MAP_FIXED, fd, ...);
> 	foo2 = *ptr2;
> 
> and they overwrite the old VMA.  Does foo2 have the contents of the new
> "/some/other/file" or the old "/some/file"?  How does the new mmap()

Good point.  It should've give up LUF at the 2nd mmap() in this case.
I will fix it by introducing a new flag in task_struct indicating if LUF
has left stale maps for the task so that LUF can give up and flush right
away in mmap().

> know that there was something to flush?
> 
> BTW, the same thing could happen without a new mmap().  Someone could
> modify the file in the middle, maybe even from another process.

Thank you for the pointing out.  I will fix it too by introducing a new
flag in inode or something to make LUF aware if updating the file has
been tried so that LUF can give up and flush right away in the case.

Plus, I will add another give-up at code changing the permission of vma
to writable.

Thank you very much.

	Byungchul

> 	fd = open("/some/file", O_RDONLY);
> 	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
> 	foo1 = *ptr1;
> 	// LUF happens here
> 	// "/some/file" changes
> 	foo2 = *ptr1; // Does this see the change?


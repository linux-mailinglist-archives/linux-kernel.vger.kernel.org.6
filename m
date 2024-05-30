Return-Path: <linux-kernel+bounces-194818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8708D427E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B231F2837D7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B3E56C;
	Thu, 30 May 2024 00:50:40 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD75C83
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030239; cv=none; b=ociZoLulNkhtcKVyiD90eA8WaAc5IIRRUHLj7Ncd1jZWJVlNE8Ut52i/YVk+4N4/RjTX+ywNHa19IL3Mi+3Y7XlhWhCHS+StkodOF5jjkE9cPzvAiuG0XKvsLLEpZMDks1jKsHvU+usuzghnQXpKGiXmWRfKFViwGVUy3pM8Jdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030239; c=relaxed/simple;
	bh=p7gDlyNVjk3zWfjBzeWurQQOWBTRjMGzOOudmWRdDHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjhKOQDxk3flbh04JFwcHV4pMVRe5d8x5lTKVN1o62cSchmEZjCyPs4q6Lx4fpyQIv5BF42ERqFKWOAoYspZE0K++0ktVz7b9tNGpV+N3NR04MlVK3jM2MUP2VcW1ZE6lf1hKGKQL4/5lTD/bz9/vcmmiscVx6FRNE5134MryyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-d4-6657cd57fc10
Date: Thu, 30 May 2024 09:50:26 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240530005026.GA47476@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
 <20240529050046.GB20307@system.software.com>
 <961f9533-1e0c-416c-b6b0-d46b97127de2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961f9533-1e0c-416c-b6b0-d46b97127de2@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsXC9ZZnkW742fA0g0PTjC3mrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkAviiuGxSUnMyy1KL
	9O0SuDLWbhEs6BKomH5zH3sD4yqeLkZODgkBE4kTZ5azwdg3915kBbFZBFQlGtbtYAGx2QTU
	JW7c+MkMYosA2adWLmfvYuTiYBboZ5b4/w7E4eQQFgiRmPZhDROIzStgIbHg22ImkCIhgQdM
	ErO/PmSESAhKnJz5BGwqs4CWxI1/L4GKOIBsaYnl/zhAwpwCthInFp8CKxcVUJY4sO04E8Rx
	m9glPjwUh7AlJQ6uuMEygVFgFpKps5BMnYUwdQEj8ypGocy8stzEzBwTvYzKvMwKveT83E2M
	wIhcVvsnegfjpwvBhxgFOBiVeHgPSISnCbEmlhVX5h5ilOBgVhLhPTMpNE2INyWxsiq1KD++
	qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QD45RzflkfSlbcZcq9n71Etn6L
	z53sf7wCoSy7pnMJP+ThOf3719NvR5h/6mTfZmz+M+/8PXXVuzldS+QZQ7t/Tb8zrbKbU+dg
	9rU3L7JzmyOuf5KcnTXNZ+MGE02tlVGnW5ZyL5zZkbpWQbbcdrMx9+5ptgenlgV6Lmu+XPk9
	cN2lM06dDxYuklViKc5INNRiLipOBABnIQgrxAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5WfdrBt+NjzNoPGqisWc9WvYLD5v+Mdm
	8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/Vovzu9ayWuxYuo/J4tKBBUwW
	x3sPMFnMv/eZzWLzpqnMFsenTGW0+P0DqPjkrMksDkIe31v7WDx2zrrL7rFgU6nH5hVaHov3
	vGTy2LSqk81j06dJ7B7vzp1j9zgx4zeLx7yTgR7v911l81j84gOTx9Zfdh6NU6+xeXzeJBfA
	H8Vlk5Kak1mWWqRvl8CVsXaLYEGXQMX0m/vYGxhX8XQxcnJICJhI3Nx7kRXEZhFQlWhYt4MF
	xGYTUJe4ceMnM4gtAmSfWrmcvYuRi4NZoJ9Z4v87EIeTQ1ggRGLahzVMIDavgIXEgm+LmUCK
	hAQeMEnM/vqQESIhKHFy5hOwqcwCWhI3/r0EKuIAsqUllv/jAAlzCthKnFh8CqxcVEBZ4sC2
	40wTGHlnIemehaR7FkL3AkbmVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIERtqz2z8QdjF8u
	ux9iFOBgVOLhPSARnibEmlhWXJl7iFGCg1lJhPfMpNA0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK
	4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsY6kekStporl8bt+6xrMsN0ww/jFWscrCv7J3p9
	njlZzvvO9Xze3qqOXsk9NVXzs5NyIv3mGS1ra/vm9DRHe95C2aNpfHbLlLU93P1cJ3j+Cwue
	yZq4o3yTU/vOmi8TT+abz3M5LaHIqmlxVPax9e0t4Z+NVHktVwh/Db5YK742km+J4L8VYUos
	xRmJhlrMRcWJAD8c/HisAgAA
X-CFilter-Loop: Reflected

On Wed, May 29, 2024 at 09:41:22AM -0700, Dave Hansen wrote:
> On 5/28/24 22:00, Byungchul Park wrote:
> > All the code updating ptes already performs TLB flush needed in a safe
> > way if it's inevitable e.g. munmap.  LUF which controls when to flush in
> > a higer level than arch code, just leaves stale ro tlb entries that are
> > currently supposed to be in use.  Could you give a scenario that you are
> > concering?
> 
> Let's go back this scenario:
> 
>  	fd = open("/some/file", O_RDONLY);
>  	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
>  	foo1 = *ptr1;
> 
> There's a read-only PTE at 'ptr1'.  Right?  The page being pointed to is
> eligible for LUF via the try_to_unmap() paths.  In other words, the page
> might be reclaimed at any time.  If it is reclaimed, the PTE will be
> cleared.
> 
> Then, the user might do:
> 
> 	munmap(ptr1, PAGE_SIZE);
> 
> Which will _eventually_ wind up in the zap_pte_range() loop.  But that
> loop will only see pte_none().  It doesn't do _anything_ to the 'struct
> mmu_gather'.
> 
> The munmap() then lands in tlb_flush_mmu_tlbonly() where it looks at the
> 'struct mmu_gather':
> 
>         if (!(tlb->freed_tables || tlb->cleared_ptes ||
> 	      tlb->cleared_pmds || tlb->cleared_puds ||
> 	      tlb->cleared_p4ds))
>                 return;
> 
> But since there were no cleared PTEs (or anything else) during the
> unmap, this just returns and doesn't flush the TLB.
> 
> We now have an address space with a stale TLB entry at 'ptr1' and not
> even a VMA there.  There's nothing to stop a new VMA from going in,
> installing a *new* PTE, but getting data from the stale TLB entry that
> still hasn't been flushed.

Thank you for the explanation.  I got you.  I think I could handle the
case through a new flag in vma or something indicating LUF has deferred
necessary TLB flush for it during unmapping so that mmu_gather mechanism
can be aware of it.  Of course, the performance change should be checked
again.  Thoughts?

Thanks again.

	Byungchul


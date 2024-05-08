Return-Path: <linux-kernel+bounces-172918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE08BF8A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7540CB24BD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA554663;
	Wed,  8 May 2024 08:36:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDDCBA27
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157410; cv=none; b=AE4vp3XVwVq9IjXUttKRFEz4mjs8QHRlO2+eQd+H2zROPJmlzXJ67jdmpfkdZIUAwlz4t7oTUo2xYItgNokCv0c4hkTKxx+bMyHC3ymK0xC4EunOrxf+NL6073W/UZB7kNxry+NaDbZDov+sJJBf8SKBiFHoEcnKbq4AC+VMSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157410; c=relaxed/simple;
	bh=HpZR7tFB30tKv89Pj2dG2MwTUhlzU4NPvXkL7BlsNTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVh0UV2kP20bVscJqI1/JID4PUV7JBSiYdV7gezOxczXvMud70PPz+c4cLEOH17Ul7EC+F91kFOfy9Km8yK4kTiyRjN1xD+fAYRx5zBmLkoZ1d1e6IqXi+BgIejeh49/RBgyDN+66vPM43ziN5fBSRQZB7I3XnC1sVmrEt5I20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4EBC1063;
	Wed,  8 May 2024 01:37:13 -0700 (PDT)
Received: from [10.57.67.194] (unknown [10.57.67.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 902823F762;
	Wed,  8 May 2024 01:36:46 -0700 (PDT)
Message-ID: <219cb8e3-a77b-468b-9d69-0b3e386f93f6@arm.com>
Date: Wed, 8 May 2024 09:36:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Content-Language: en-GB
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Yang Shi <shy828301@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>,
 riel@surriel.com, cl@linux.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ze Zuo <zuoze1@huawei.com>
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
 <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
 <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
 <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com>
 <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
 <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com>
 <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
 <2c14d9ad-c5a3-4f29-a6eb-633cdf3a5e9e@redhat.com>
 <da24d8bb-3723-48fa-86f4-8b24457d3556@huawei.com>
 <2b403705-a03c-4cfe-8d95-b38dd83fca52@arm.com>
 <CAHbLzkq9BQFfpjxG_ozrgzWOO3XJmtre-mgY03McY6guVn7U9g@mail.gmail.com>
 <281aebf1-0bff-4858-b479-866eb05b9e94@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <281aebf1-0bff-4858-b479-866eb05b9e94@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/05/2024 08:48, Kefeng Wang wrote:
> 
> 
> On 2024/5/8 1:17, Yang Shi wrote:
>> On Tue, May 7, 2024 at 8:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> On 07/05/2024 14:53, Kefeng Wang wrote:
>>>>
>>>>
>>>> On 2024/5/7 19:13, David Hildenbrand wrote:
>>>>>
>>>>>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
>>>>>>
>>>>>>> suggest. If you want to try something semi-randomly; it might be useful
>>>>>>> to rule
>>>>>>> out the arm64 contpte feature. I don't see how that would be interacting
>>>>>>> here if
>>>>>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
>>>>>>> ARM64_CONTPTE (needs EXPERT) at compile time.
>>>>>> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE,
>>>>>> but will have a try.
>>>>
>>>> After ARM64_CONTPTE disabled, memory read latency is similar with ARM64_CONTPTE
>>>> enabled(default 6.9-rc7), still larger than align anon reverted.
>>>
>>> OK thanks for trying.
>>>
>>> Looking at the source for lmbench, its malloc'ing (512M + 8K) up front and using
>>> that for all sizes. That will presumably be considered "large" by malloc and
>>> will be allocated using mmap. So with the patch, it will be 2M aligned. Without
>>> it, it probably won't. I'm still struggling to understand why not aligning it in
>>> virtual space would make it more performant though...
>>
>> Yeah, I'm confused too.
> Me too, I get a smaps[_rollup] for 0.09375M size, the biggest difference
> for anon shows below, and all attached.

OK, a bit more insight; during initialization, the test makes 2 big malloc
calls; the first is 1M and the second is 512M+8K. I think those 2 are the 2 vmas
below (malloc is adding an extra page to the allocation, presumably for
management structures).

With efa7df3e3bb5 applied, the 1M allocation is allocated at a non-THP-aligned
address. All of its pages are populated (see permutation() which allocates and
writes it) but none of them are THP (obviously - its only 1M and THP is only
enabled for 2M). But the 512M region is allocated at a THP-aligned address. And
the first page is populated with a THP (presumably faulted when malloc writes to
its control structure page before the application even sees the allocated buffer.

In contrast, when efa7df3e3bb5 is reverted, neither of the vmas are THP-aligned,
and therefore the 512M region abutts the 1M region and the vmas are merged in
the kernel. So we end up with the single 525328 kB region. There are no THPs
allocated here (due to alignment constraiints) so we end up with the 1M region
fully populated with 4K pages as before, and only the malloc control page plus
the parts of the buffer that the application actually touches being populated in
the 512M region.

As far as I can tell, the application never touches the 1M region during the
test so it should be cache-cold. It only touches the first part of the 512M
buffer it needs for the size of the test (96K here?). The latency of allocating
the THP will have been consumed during test setup so I doubt we are seeing that
in the test results and I don't see why having a single TLB entry vs 96K/4K=24
entries would make it slower.

It would be interesting to know the address that gets returned from malloc for
the 512M region if that's possible to get (in both cases)? I guess it is offset
into the first page. Perhaps it is offset such that with the THP alignment case
the 96K of interest ends up straddling 3 cache lines (cache line is 64K I
assume?), but for the unaligned case, it ends up nicely packed in 2?

Thanks,
Ryan

> 
> 1) with efa7df3e3bb5 smaps
> 
> ffff68e00000-ffff88e03000 rw-p 00000000 00:00 0
> Size:             524300 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                2048 kB
> Pss:                2048 kB
> Pss_Dirty:          2048 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:      2048 kB
> Referenced:         2048 kB
> Anonymous:          2048 kB // we have 1 anon thp
> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:      2048 kB

Yes one 2M THP shown here.

> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:           1
> VmFlags: rd wr mr mw me ac
> ffff88eff000-ffff89000000 rw-p 00000000 00:00 0
> Size:               1028 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                1028 kB
> Pss:                1028 kB
> Pss_Dirty:          1028 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:      1028 kB
> Referenced:         1028 kB
> Anonymous:          1028 kB // another large anon

This is not THP, since you only have 2M THP enabled. This will be 1M of 4K page
allocations + 1 4K page malloc control structure, allocated and accessed by
permutation() during test setup.

> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:           0
> VmFlags: rd wr mr mw me ac
> 
> and the smap_rollup
> 
> 00400000-fffff56bd000 ---p 00000000 00:00 0 [rollup]
> Rss:                4724 kB
> Pss:                3408 kB
> Pss_Dirty:          3338 kB
> Pss_Anon:           3338 kB
> Pss_File:             70 kB
> Pss_Shmem:             0 kB
> Shared_Clean:       1176 kB
> Shared_Dirty:        420 kB
> Private_Clean:         0 kB
> Private_Dirty:      3128 kB
> Referenced:         4344 kB
> Anonymous:          3548 kB
> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:      2048 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> 
> 2) without efa7df3e3bb5 smaps
> 
> ffff9845b000-ffffb855f000 rw-p 00000000 00:00 0
> Size:             525328 kB

This is a merged-vma version of the above 2 regions.

> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                1128 kB
> Pss:                1128 kB
> Pss_Dirty:          1128 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:      1128 kB
> Referenced:         1128 kB
> Anonymous:          1128 kB // only large anon
> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:           1
> VmFlags: rd wr mr mw me ac
> 
> and the smap_rollup,
> 
> 00400000-ffffca5dc000 ---p 00000000 00:00 0 [rollup]
> Rss:                2600 kB
> Pss:                1472 kB
> Pss_Dirty:          1388 kB
> Pss_Anon:           1388 kB
> Pss_File:             84 kB
> Pss_Shmem:             0 kB
> Shared_Clean:       1000 kB
> Shared_Dirty:        424 kB
> Private_Clean:         0 kB
> Private_Dirty:      1176 kB
> Referenced:         2220 kB
> Anonymous:          1600 kB
> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> 
>>
>> I just ran the same command on 6.6.13 (w/o the thp alignment patch and
>> mTHP stuff) and 6.9-rc4 (w/ the thp alignment patch and all mTHP
>> stuff) on my arm64 machine, but I didn't see such a pattern.
>>
>> The result has a little bit fluctuation, for example, 6.6.13 has
>> better result with 4M/6M/8M, but 6.9-rc4 has better result for
>> 12M/16M/32M/48M/64M, and the difference may be quite noticeable. But
>> anyway I didn't see such a regression pattern.
> 
> Although it is not fluctuation, but on our arm64, it is very noticeable.
> 
>>
>> The benchmark is supposed to measure cache and memory latency, its
>> result strongly relies on the cache and memory subsystem, for example,
>> hw prefetcher, etc.
> 
> Yes, I will try another type of arm64 if possible, no available machine now.
> 
> 
>>
>>>
>>> Is it possible to provide the smaps output for at least that 512M+8K block for
>>> both cases? It might give a bit of a clue.
> 
> Will collect more smaps.
> 
>>>
>>> Do you have traditional (PMD-sized) THP enabled? If its enabled and unaligned
>>> then the front of the buffer wouldn't be mapped with THP, but if it is aligned,
>>> it will. That could affect it.
> 
> Yes, PMD-sized THP enabled. at least for above smaps, without efa7df3e3bb5, the
> anon don't be mappped with THP.



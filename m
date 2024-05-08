Return-Path: <linux-kernel+bounces-173323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8C48BFEF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535F9289BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F71482D9F;
	Wed,  8 May 2024 13:37:13 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1582D91
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175432; cv=none; b=Vpb9Vsz/f8oSjdoMvaBd9rDTxTMF4TtRcK+BSDrpdPbwJ25dAsT15WRQ7iCdGGYIwvWeD136oNRU4ZXR6un1tkhLe53ZoLiWBVlEC4miRsfMCvB0+WMLibCVcpy6X04dLt2xLS97HkdhgucK6ZEVSvtv2qaRJutP8phVhuBXtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175432; c=relaxed/simple;
	bh=DI1tB3pspDdLN35QjJOlr/h6q9KNdKBxf6MN7kGGpY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a5cYZIM1Gc0CP6lTGfNCEePWken9GSsN3vYA8Qm75nedX9Ysgyj33jbPxnNu1WGHQ1iQTU1011ZlYnvEeffCAfVJRAuPmi+t8/OQDG00/QXfOhqYI466yQPZWbcCtCIyzo37Qp5L1FxW9xtahT7cWtkrYJLSE6sTeTFRU7B/4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VZGM104CBz1RCcK;
	Wed,  8 May 2024 21:33:49 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E7550180A9F;
	Wed,  8 May 2024 21:37:08 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 21:37:08 +0800
Message-ID: <7d8c43b6-b1ef-428e-9d6a-1c26284feb26@huawei.com>
Date: Wed, 8 May 2024 21:37:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <shy828301@gmail.com>
CC: David Hildenbrand <david@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>,
	<riel@surriel.com>, <cl@linux.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Ze Zuo
	<zuoze1@huawei.com>
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
 <219cb8e3-a77b-468b-9d69-0b3e386f93f6@arm.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <219cb8e3-a77b-468b-9d69-0b3e386f93f6@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/8 16:36, Ryan Roberts wrote:
> On 08/05/2024 08:48, Kefeng Wang wrote:
>>
>>
>> On 2024/5/8 1:17, Yang Shi wrote:
>>> On Tue, May 7, 2024 at 8:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 07/05/2024 14:53, Kefeng Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/5/7 19:13, David Hildenbrand wrote:
>>>>>>
>>>>>>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
>>>>>>>
>>>>>>>> suggest. If you want to try something semi-randomly; it might be useful
>>>>>>>> to rule
>>>>>>>> out the arm64 contpte feature. I don't see how that would be interacting
>>>>>>>> here if
>>>>>>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
>>>>>>>> ARM64_CONTPTE (needs EXPERT) at compile time.
>>>>>>> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE,
>>>>>>> but will have a try.
>>>>>
>>>>> After ARM64_CONTPTE disabled, memory read latency is similar with ARM64_CONTPTE
>>>>> enabled(default 6.9-rc7), still larger than align anon reverted.
>>>>
>>>> OK thanks for trying.
>>>>
>>>> Looking at the source for lmbench, its malloc'ing (512M + 8K) up front and using
>>>> that for all sizes. That will presumably be considered "large" by malloc and
>>>> will be allocated using mmap. So with the patch, it will be 2M aligned. Without
>>>> it, it probably won't. I'm still struggling to understand why not aligning it in
>>>> virtual space would make it more performant though...
>>>
>>> Yeah, I'm confused too.
>> Me too, I get a smaps[_rollup] for 0.09375M size, the biggest difference
>> for anon shows below, and all attached.
> 
> OK, a bit more insight; during initialization, the test makes 2 big malloc
> calls; the first is 1M and the second is 512M+8K. I think those 2 are the 2 vmas
> below (malloc is adding an extra page to the allocation, presumably for
> management structures).
> 
> With efa7df3e3bb5 applied, the 1M allocation is allocated at a non-THP-aligned
> address. All of its pages are populated (see permutation() which allocates and
> writes it) but none of them are THP (obviously - its only 1M and THP is only
> enabled for 2M). But the 512M region is allocated at a THP-aligned address. And
> the first page is populated with a THP (presumably faulted when malloc writes to
> its control structure page before the application even sees the allocated buffer.
> 
> In contrast, when efa7df3e3bb5 is reverted, neither of the vmas are THP-aligned,
> and therefore the 512M region abutts the 1M region and the vmas are merged in
> the kernel. So we end up with the single 525328 kB region. There are no THPs
> allocated here (due to alignment constraiints) so we end up with the 1M region
> fully populated with 4K pages as before, and only the malloc control page plus
> the parts of the buffer that the application actually touches being populated in
> the 512M region.
> 
> As far as I can tell, the application never touches the 1M region during the
> test so it should be cache-cold. It only touches the first part of the 512M
> buffer it needs for the size of the test (96K here?). The latency of allocating
> the THP will have been consumed during test setup so I doubt we are seeing that
> in the test results and I don't see why having a single TLB entry vs 96K/4K=24
> entries would make it slower.

It is strange, and even more stranger, I got another machine(old machine
128 core and the new machine 96 core, but with same L1/L2 cache size
per-core), the new machine without this issue, will contact with our
hardware team, maybe some different configurations(prefetch or some
other similar hardware configurations) , thank for all the suggestion
and analysis!


> 
> It would be interesting to know the address that gets returned from malloc for
> the 512M region if that's possible to get (in both cases)? I guess it is offset
> into the first page. Perhaps it is offset such that with the THP alignment case
> the 96K of interest ends up straddling 3 cache lines (cache line is 64K I
> assume?), but for the unaligned case, it ends up nicely packed in 2?

CC zuoze, please help to check this.

Thank again.
> 
> Thanks,
> Ryan
> 
>>
>> 1) with efa7df3e3bb5 smaps
>>
>> ffff68e00000-ffff88e03000 rw-p 00000000 00:00 0
>> Size:             524300 kB
>> KernelPageSize:        4 kB
>> MMUPageSize:           4 kB
>> Rss:                2048 kB
>> Pss:                2048 kB
>> Pss_Dirty:          2048 kB
>> Shared_Clean:          0 kB
>> Shared_Dirty:          0 kB
>> Private_Clean:         0 kB
>> Private_Dirty:      2048 kB
>> Referenced:         2048 kB
>> Anonymous:          2048 kB // we have 1 anon thp
>> KSM:                   0 kB
>> LazyFree:              0 kB
>> AnonHugePages:      2048 kB
> 
> Yes one 2M THP shown here.
> 
>> ShmemPmdMapped:        0 kB
>> FilePmdMapped:         0 kB
>> Shared_Hugetlb:        0 kB
>> Private_Hugetlb:       0 kB
>> Swap:                  0 kB
>> SwapPss:               0 kB
>> Locked:                0 kB
>> THPeligible:           1
>> VmFlags: rd wr mr mw me ac
>> ffff88eff000-ffff89000000 rw-p 00000000 00:00 0
>> Size:               1028 kB
>> KernelPageSize:        4 kB
>> MMUPageSize:           4 kB
>> Rss:                1028 kB
>> Pss:                1028 kB
>> Pss_Dirty:          1028 kB
>> Shared_Clean:          0 kB
>> Shared_Dirty:          0 kB
>> Private_Clean:         0 kB
>> Private_Dirty:      1028 kB
>> Referenced:         1028 kB
>> Anonymous:          1028 kB // another large anon
> 
> This is not THP, since you only have 2M THP enabled. This will be 1M of 4K page
> allocations + 1 4K page malloc control structure, allocated and accessed by
> permutation() during test setup.
> 
>> KSM:                   0 kB
>> LazyFree:              0 kB
>> AnonHugePages:         0 kB
>> ShmemPmdMapped:        0 kB
>> FilePmdMapped:         0 kB
>> Shared_Hugetlb:        0 kB
>> Private_Hugetlb:       0 kB
>> Swap:                  0 kB
>> SwapPss:               0 kB
>> Locked:                0 kB
>> THPeligible:           0
>> VmFlags: rd wr mr mw me ac
>>
>> and the smap_rollup
>>
>> 00400000-fffff56bd000 ---p 00000000 00:00 0 [rollup]
>> Rss:                4724 kB
>> Pss:                3408 kB
>> Pss_Dirty:          3338 kB
>> Pss_Anon:           3338 kB
>> Pss_File:             70 kB
>> Pss_Shmem:             0 kB
>> Shared_Clean:       1176 kB
>> Shared_Dirty:        420 kB
>> Private_Clean:         0 kB
>> Private_Dirty:      3128 kB
>> Referenced:         4344 kB
>> Anonymous:          3548 kB
>> KSM:                   0 kB
>> LazyFree:              0 kB
>> AnonHugePages:      2048 kB
>> ShmemPmdMapped:        0 kB
>> FilePmdMapped:         0 kB
>> Shared_Hugetlb:        0 kB
>> Private_Hugetlb:       0 kB
>> Swap:                  0 kB
>> SwapPss:               0 kB
>> Locked:                0 kB
>>
>> 2) without efa7df3e3bb5 smaps
>>
>> ffff9845b000-ffffb855f000 rw-p 00000000 00:00 0
>> Size:             525328 kB
> 
> This is a merged-vma version of the above 2 regions.
> 
>> KernelPageSize:        4 kB
>> MMUPageSize:           4 kB
>> Rss:                1128 kB
>> Pss:                1128 kB
>> Pss_Dirty:          1128 kB
>> Shared_Clean:          0 kB
>> Shared_Dirty:          0 kB
>> Private_Clean:         0 kB
>> Private_Dirty:      1128 kB
>> Referenced:         1128 kB
>> Anonymous:          1128 kB // only large anon
>> KSM:                   0 kB
>> LazyFree:              0 kB
>> AnonHugePages:         0 kB
>> ShmemPmdMapped:        0 kB
>> FilePmdMapped:         0 kB
>> Shared_Hugetlb:        0 kB
>> Private_Hugetlb:       0 kB
>> Swap:                  0 kB
>> SwapPss:               0 kB
>> Locked:                0 kB
>> THPeligible:           1
>> VmFlags: rd wr mr mw me ac
>>
>> and the smap_rollup,
>>
>> 00400000-ffffca5dc000 ---p 00000000 00:00 0 [rollup]
>> Rss:                2600 kB
>> Pss:                1472 kB
>> Pss_Dirty:          1388 kB
>> Pss_Anon:           1388 kB
>> Pss_File:             84 kB
>> Pss_Shmem:             0 kB
>> Shared_Clean:       1000 kB
>> Shared_Dirty:        424 kB
>> Private_Clean:         0 kB
>> Private_Dirty:      1176 kB
>> Referenced:         2220 kB
>> Anonymous:          1600 kB
>> KSM:                   0 kB
>> LazyFree:              0 kB
>> AnonHugePages:         0 kB
>> ShmemPmdMapped:        0 kB
>> FilePmdMapped:         0 kB
>> Shared_Hugetlb:        0 kB
>> Private_Hugetlb:       0 kB
>> Swap:                  0 kB
>> SwapPss:               0 kB
>> Locked:                0 kB
>>


Return-Path: <linux-kernel+bounces-174025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A088C0945
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1601F21E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418913B5B3;
	Thu,  9 May 2024 01:47:20 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656482C184
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219239; cv=none; b=iu6+dxDSza+WVGPXw7J22fBlubCnxbomvr4EDuWjLxcWTy3ONvpLgZAS9njUVG0Xn/NU81fHGH4/s2W700TBteXOOlZfh1ui/W2nhnDvc+QNoDTjBfhetpo1jDkgegpV4aLR7WON7I9Sbu5AgIxeQSG5aQNTbYqlG2SRGiy3E2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219239; c=relaxed/simple;
	bh=KeHPrs4pW+t1XtkdnCJ1pc1+inm1Hl3eeey3OvNnWac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tz60Hh9XJphq8Pe8B2gqjOT6S7K0onms+UIgxgRiZaXX5IezEVZhKi52nCHpafK2huSOFiOAUJ+NVJnp6v87v3ydLT7lFKJ2c/0wJZnbnnbjf5hXxkmcbh/T0m4JMuPTnkChsPZk6Js8aXcM7jwUuv1gq/N2WlAP2l4cPAaqtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VZZZ14vYxzNwN3;
	Thu,  9 May 2024 09:44:25 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EA491400D7;
	Thu,  9 May 2024 09:47:13 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 09:47:12 +0800
Message-ID: <51d48776-ac72-432a-b768-92e7fa0ecd4b@huawei.com>
Date: Thu, 9 May 2024 09:47:12 +0800
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
To: Yang Shi <shy828301@gmail.com>
CC: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>,
	<riel@surriel.com>, <cl@linux.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Ze Zuo
	<zuoze1@huawei.com>
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
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
 <7d8c43b6-b1ef-428e-9d6a-1c26284feb26@huawei.com>
 <CAHbLzkpYWusx85nPD_Ywxvg5cLuxVLMhu91NO8-zidgBjKN7yg@mail.gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAHbLzkpYWusx85nPD_Ywxvg5cLuxVLMhu91NO8-zidgBjKN7yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/8 23:25, Yang Shi wrote:
> On Wed, May 8, 2024 at 6:37 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>>
>>
>> On 2024/5/8 16:36, Ryan Roberts wrote:
>>> On 08/05/2024 08:48, Kefeng Wang wrote:
>>>>
>>>>
>>>> On 2024/5/8 1:17, Yang Shi wrote:
>>>>> On Tue, May 7, 2024 at 8:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> On 07/05/2024 14:53, Kefeng Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2024/5/7 19:13, David Hildenbrand wrote:
>>>>>>>>
>>>>>>>>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
>>>>>>>>>
>>>>>>>>>> suggest. If you want to try something semi-randomly; it might be useful
>>>>>>>>>> to rule
>>>>>>>>>> out the arm64 contpte feature. I don't see how that would be interacting
>>>>>>>>>> here if
>>>>>>>>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
>>>>>>>>>> ARM64_CONTPTE (needs EXPERT) at compile time.
>>>>>>>>> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE,
>>>>>>>>> but will have a try.
>>>>>>>
>>>>>>> After ARM64_CONTPTE disabled, memory read latency is similar with ARM64_CONTPTE
>>>>>>> enabled(default 6.9-rc7), still larger than align anon reverted.
>>>>>>
>>>>>> OK thanks for trying.
>>>>>>
>>>>>> Looking at the source for lmbench, its malloc'ing (512M + 8K) up front and using
>>>>>> that for all sizes. That will presumably be considered "large" by malloc and
>>>>>> will be allocated using mmap. So with the patch, it will be 2M aligned. Without
>>>>>> it, it probably won't. I'm still struggling to understand why not aligning it in
>>>>>> virtual space would make it more performant though...
>>>>>
>>>>> Yeah, I'm confused too.
>>>> Me too, I get a smaps[_rollup] for 0.09375M size, the biggest difference
>>>> for anon shows below, and all attached.
>>>
>>> OK, a bit more insight; during initialization, the test makes 2 big malloc
>>> calls; the first is 1M and the second is 512M+8K. I think those 2 are the 2 vmas
>>> below (malloc is adding an extra page to the allocation, presumably for
>>> management structures).
>>>
>>> With efa7df3e3bb5 applied, the 1M allocation is allocated at a non-THP-aligned
>>> address. All of its pages are populated (see permutation() which allocates and
>>> writes it) but none of them are THP (obviously - its only 1M and THP is only
>>> enabled for 2M). But the 512M region is allocated at a THP-aligned address. And
>>> the first page is populated with a THP (presumably faulted when malloc writes to
>>> its control structure page before the application even sees the allocated buffer.
>>>
>>> In contrast, when efa7df3e3bb5 is reverted, neither of the vmas are THP-aligned,
>>> and therefore the 512M region abutts the 1M region and the vmas are merged in
>>> the kernel. So we end up with the single 525328 kB region. There are no THPs
>>> allocated here (due to alignment constraiints) so we end up with the 1M region
>>> fully populated with 4K pages as before, and only the malloc control page plus
>>> the parts of the buffer that the application actually touches being populated in
>>> the 512M region.
>>>
>>> As far as I can tell, the application never touches the 1M region during the
>>> test so it should be cache-cold. It only touches the first part of the 512M
>>> buffer it needs for the size of the test (96K here?). The latency of allocating
>>> the THP will have been consumed during test setup so I doubt we are seeing that
>>> in the test results and I don't see why having a single TLB entry vs 96K/4K=24
>>> entries would make it slower.
>>
>> It is strange, and even more stranger, I got another machine(old machine
>> 128 core and the new machine 96 core, but with same L1/L2 cache size
>> per-core), the new machine without this issue, will contact with our
>> hardware team, maybe some different configurations(prefetch or some
>> other similar hardware configurations) , thank for all the suggestion
>> and analysis!
> 
> Yes, the benchmark result strongly relies on cache and memory
> subsystem. See the below analysis.
> 
>>
>>
>>>
>>> It would be interesting to know the address that gets returned from malloc for
>>> the 512M region if that's possible to get (in both cases)? I guess it is offset
>>> into the first page. Perhaps it is offset such that with the THP alignment case
>>> the 96K of interest ends up straddling 3 cache lines (cache line is 64K I
>>> assume?), but for the unaligned case, it ends up nicely packed in 2?
>>
>> CC zuoze, please help to check this.
>>
>> Thank again.
>>>
>>> Thanks,
>>> Ryan
>>>
>>>>
>>>> 1) with efa7df3e3bb5 smaps
>>>>
>>>> ffff68e00000-ffff88e03000 rw-p 00000000 00:00 0
>>>> Size:             524300 kB
>>>> KernelPageSize:        4 kB
>>>> MMUPageSize:           4 kB
>>>> Rss:                2048 kB
>>>> Pss:                2048 kB
>>>> Pss_Dirty:          2048 kB
>>>> Shared_Clean:          0 kB
>>>> Shared_Dirty:          0 kB
>>>> Private_Clean:         0 kB
>>>> Private_Dirty:      2048 kB
>>>> Referenced:         2048 kB
>>>> Anonymous:          2048 kB // we have 1 anon thp
>>>> KSM:                   0 kB
>>>> LazyFree:              0 kB
>>>> AnonHugePages:      2048 kB
>>>
>>> Yes one 2M THP shown here.
> 
> You have THP allocated. W/o commit efa7df3e3bb5 the address may be not
> PMD aligned (it still could be, but just not that likely), the base
> pages were allocated. To get an apple to apple comparison, you need to
> disable THP by setting /sys/kernel/mm/transparent_hugepage/enabled to
> madvise or never, then you will get base pages too (IIRC lmbench
> doesn't call MADV_HUGEPAGE).

Yes, we tested no THP(disable by sysfs) before, no different w/ or w/o
this efa7df3e3bb5.

> 
> The address alignment or page size may have a negative impact to your
> CPU's cache and memory subsystem, for example, hw prefetcher. But I
> saw a slight improvement with THP on my machine. So the behavior
> strongly depends on the hardware.
> 
I hope this efa7df3e3bb5 could improve performance so I backport it
into our kernel, but found the above issue, and same result when retest
with the 6.9-rc7, since different hardware show different results, we
will test more hardware and try to contact with hardware team, thanks 
for your help.



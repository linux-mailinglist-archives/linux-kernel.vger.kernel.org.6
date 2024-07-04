Return-Path: <linux-kernel+bounces-240992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EDC927570
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4224D282275
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DB61AC24D;
	Thu,  4 Jul 2024 11:47:15 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A091ABC29
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093634; cv=none; b=YE2Xgtp3Msc89MQKgFZSe8LXTiGqWSSzP4iNZXFaohQuQ/X3Dht84N02UDcFd5gm+J8tpcQhQyvzJuJgq3Y0DH53zQiJs7chc/V/FIgVXB1OuRugFejZmstGfWI62XhZRyz0RFy3gYnt4R2R9cp0vlOiEFPG/98Pw7fp+xpNyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093634; c=relaxed/simple;
	bh=4TKceVkUM5b+k0leUKHtwoBweDjUkXtFZuWN5+5kqD8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LrB9DizTtavB9cs0XGI9aTl1NeinEFBNj6CcXcLmrGwawpBnv5gAdEaqZyBCmh+GqKK4L1qXeIjvqeQSvOpN5KUk4vBYIqh8pQ/azYWmRmXZ5kwCBmCqDHsU1GkieIDqe1Mnh2e3S3XHar38VLMQkN3JfRFgzZrePKL8kddR/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WFFBD6TQcz1T4xc;
	Thu,  4 Jul 2024 19:42:28 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 93C5E180A9C;
	Thu,  4 Jul 2024 19:47:03 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 19:47:02 +0800
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Yu Zhao <yuzhao@google.com>
CC: David Rientjes <rientjes@google.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Matthew Wilcox
	<willy@infradead.org>, <muchun.song@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
	<wangkefeng.wang@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Yosry Ahmed
	<yosryahmed@google.com>, Sourav Panda <souravpanda@google.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org> <ZcN1hTrAhy-B1P2_@arm.com>
 <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com>
 <20240208131734.GA23428@willie-the-truck>
 <f8a643a9-4932-9ba4-94f1-4bc88ee27740@google.com>
 <22c14513-af78-0f1d-5647-384ff9cb5993@huawei.com>
 <ZnkGps-vQbiynNwP@google.com>
 <17232655-553d-7d48-8ba1-5425e8ab0f8b@huawei.com>
 <CAOUHufY8AZ7Td=OKg+Bbbnk+B-XspJQH2XDsEeZsiDJ-GuQgcQ@mail.gmail.com>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <06252b78-2b61-73d1-ddf8-920dd744c756@huawei.com>
Date: Thu, 4 Jul 2024 19:47:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOUHufY8AZ7Td=OKg+Bbbnk+B-XspJQH2XDsEeZsiDJ-GuQgcQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)

On 2024/6/28 5:03, Yu Zhao wrote:
> On Thu, Jun 27, 2024 at 8:34 AM Nanyong Sun <sunnanyong@huawei.com> wrote:
>>
>> 在 2024/6/24 13:39, Yu Zhao 写道:
>>> On Mon, Mar 25, 2024 at 11:24:34PM +0800, Nanyong Sun wrote:
>>>> On 2024/3/14 7:32, David Rientjes wrote:
>>>>
>>>>> On Thu, 8 Feb 2024, Will Deacon wrote:
>>>>>
>>>>>>> How about take a new lock with irq disabled during BBM, like:
>>>>>>>
>>>>>>> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
>>>>>>> +{
>>>>>>> +     (NEW_LOCK);
>>>>>>> +    pte_clear(&init_mm, addr, ptep);
>>>>>>> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>>>>>> +    set_pte_at(&init_mm, addr, ptep, pte);
>>>>>>> +    spin_unlock_irq(NEW_LOCK);
>>>>>>> +}
>>>>>> I really think the only maintainable way to achieve this is to avoid the
>>>>>> possibility of a fault altogether.
>>>>>>
>>>>>> Will
>>>>>>
>>>>>>
>>>>> Nanyong, are you still actively working on making HVO possible on arm64?
>>>>>
>>>>> This would yield a substantial memory savings on hosts that are largely
>>>>> configured with hugetlbfs.  In our case, the size of this hugetlbfs pool
>>>>> is actually never changed after boot, but it sounds from the thread that
>>>>> there was an idea to make HVO conditional on FEAT_BBM.  Is this being
>>>>> pursued?
>>>>>
>>>>> If so, any testing help needed?
>>>> I'm afraid that FEAT_BBM may not solve the problem here
>>> I think so too -- I came cross this while working on TAO [1].
>>>
>>> [1] https://lore.kernel.org/20240229183436.4110845-4-yuzhao@google.com/
>>>
>>>> because from Arm
>>>> ARM,
>>>> I see that FEAT_BBM is only used for changing block size. Therefore, in this
>>>> HVO feature,
>>>> it can work in the split PMD stage, that is, BBM can be avoided in
>>>> vmemmap_split_pmd,
>>>> but in the subsequent vmemmap_remap_pte, the Output address of PTE still
>>>> needs to be
>>>> changed. I'm afraid FEAT_BBM is not competent for this stage. Perhaps my
>>>> understanding
>>>> of ARM FEAT_BBM is wrong, and I hope someone can correct me.
>>>> Actually, the solution I first considered was to use the stop_machine
>>>> method, but we have
>>>> products that rely on /proc/sys/vm/nr_overcommit_hugepages to dynamically
>>>> use hugepages,
>>>> so I have to consider performance issues. If your product does not change
>>>> the amount of huge
>>>> pages after booting, using stop_machine() may be a feasible way.
>>>> So far, I still haven't come up with a good solution.
>>> I do have a patch that's similar to stop_machine() -- it uses NMI IPIs
>>> to pause/resume remote CPUs while the local one is doing BBM.
>>>
>>> Note that the problem of updating vmemmap for struct page[], as I see
>>> it, is beyond hugeTLB HVO. I think it impacts virtio-mem and memory
>>> hot removal in general [2]. On arm64, we would need to support BBM on
>>> vmemmap so that we can fix the problem with offlining memory (or to be
>>> precise, unmapping offlined struct page[]), by mapping offlined struct
>>> page[] to a read-only page of dummy struct page[], similar to
>>> ZERO_PAGE(). (Or we would have to make extremely invasive changes to
>>> the reader side, i.e., all speculative PFN walkers.)
>>>
>>> In case you are interested in testing my approach, you can swap your
>>> patch 2 with the following:
>> I don't have an NMI IPI capable ARM machine on hand, so I think this feature
>> depends on a higher version of the ARM cpu.
> (Pseudo) NMI does require GICv3 (released in 2015). But that's
> independent from CPU versions. Just to double check: you don't have
> GICv3 (rather than not have CONFIG_ARM64_PSEUDO_NMI=y or
> irqchip.gicv3_pseudo_nmi=1), is that correct?
>
> Even without GICv3, IPIs can be masked but still works, with a less
> bounded latency.
Oh，I misunderstood. Pseudo NMI is available. We have 
CONFIG_ARM64_PSEUDO_NMI=y
but did not set irqchip.gicv3_pseudo_nmi=1 by default. So I can test 
this solution after
opening this in cmdline.

>> What I worried about was that other cores would occasionally be interrupted
>> frequently(8 times every 2M and 4096 times every 1G) and then wait for the
>> update of page table to complete before resuming.
> Catalin has suggested batching, and to echo what he said [1]: it's
> possible to make all vmemmap changes from a single HVO/de-HVO
> operation into *one batch*.
>
> [1] https://lore.kernel.org/linux-mm/ZcN7P0CGUOOgki71@arm.com/
>
>> If there are workloads
>> running on other cores, performance may be affected. This implementation
>> speeds up stopping and resuming other cores, but they still have to wait
>> for the update to finish.
> How often does your use case trigger HVO/de-HVO operations?
>
> For our VM use case, it's generally correlated to VM lifetimes, i.e.,
> how often VM bin-packing happens. For our THP use case, it can be more
> often, but I still don't think we would trigger HVO/de-HVO every
> minute. So with NMI IPIs, IMO, the performance impact would be
> acceptable to our use cases.
>
> .
We have many use cases so that I'm not thinking about a specific use case,
but rather a generic one. I will test the performance impact of different
HVO trigger frequencies, such as triggering HVO while running redis.


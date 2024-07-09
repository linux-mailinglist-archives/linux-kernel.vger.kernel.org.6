Return-Path: <linux-kernel+bounces-245405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C592B221
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80221282DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983651527A9;
	Tue,  9 Jul 2024 08:28:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B581745
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513736; cv=none; b=EqoRyzkbUA/TlKH+irUkqYNU5AtM6m+yKuMr+GF+kevikhfefZ5bDC2cwxmThEURiOg+EudgchX8M8YP7GQeETJSiBCSX7yVXgcrDTKuyibfRLOYsBGhcBq/74y0Xj9LZbzww3gNo2EfHsoNnntnyrTTsEJqAC2saZJux8Yedas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513736; c=relaxed/simple;
	bh=mIfGA3E/9k3NFi1S87fJxL84SR6lyTPXWI++NBvOgyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aND/8KyDj2Dn/okUgGmsR4Iv+UMB0PGQUhhHGixRfLugjjP6d2ZgocoLUSiIUkUG7gz47Ib2130BxjvzC8pIuOuPdLOrRpaPHBhipxfR49IwdH9XDeKHkaLNNR4OidoEFDXh8dGMi7PA4XwbafioHjwgClsNlcKOnnev6HVIgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 151381042;
	Tue,  9 Jul 2024 01:29:18 -0700 (PDT)
Received: from [10.57.76.194] (unknown [10.57.76.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F89C3F762;
	Tue,  9 Jul 2024 01:28:50 -0700 (PDT)
Message-ID: <e83e1687-3e3c-40d0-bf0e-225871647092@arm.com>
Date: Tue, 9 Jul 2024 09:28:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] add mTHP support for anonymous shmem
Content-Language: en-GB
To: Daniel Gomez <da.gomez@samsung.com>, David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <ZobtTmzj0AmNXcav@casper.infradead.org>
 <27beaa0e-697e-4e30-9ac6-5de22228aec1@redhat.com>
 <6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>
 <Zob8xI-LWe9H_iJs@casper.infradead.org>
 <e08b8245-bc8c-4a18-a1e0-53a139258826@linux.alibaba.com>
 <e826368d-499a-483b-8991-8c25aff88f00@arm.com>
 <CGME20240705085911eucas1p17f1e79c871c6290b426737ca1738e529@eucas1p1.samsung.com>
 <32f04739-0cd0-4a9e-9419-c5a13c333c28@redhat.com>
 <ihgsmfaqgpjcewxpjnpoo3ibdhm72s2balhpedkgr2aou5l355@ps7vb3l5j54n>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ihgsmfaqgpjcewxpjnpoo3ibdhm72s2balhpedkgr2aou5l355@ps7vb3l5j54n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/07/2024 17:39, Daniel Gomez wrote:
> On Fri, Jul 05, 2024 at 10:59:02AM GMT, David Hildenbrand wrote:
>> On 05.07.24 10:45, Ryan Roberts wrote:
>>> On 05/07/2024 06:47, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/7/5 03:49, Matthew Wilcox wrote:
>>>>> On Thu, Jul 04, 2024 at 09:19:10PM +0200, David Hildenbrand wrote:
>>>>>> On 04.07.24 21:03, David Hildenbrand wrote:
>>>>>>>> shmem has two uses:
>>>>>>>>
>>>>>>>>      - MAP_ANONYMOUS | MAP_SHARED (this patch set)
>>>>>>>>      - tmpfs
>>>>>>>>
>>>>>>>> For the second use case we don't want controls *at all*, we want the
>>>>>>>> same heiristics used for all other filesystems to apply to tmpfs.
>>>>>>>
>>>>>>> As discussed in the MM meeting, Hugh had a different opinion on that.
>>>>>>
>>>>>> FWIW, I just recalled that I wrote a quick summary:
>>>>>>
>>>>>> https://lkml.kernel.org/r/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com
>>>>>>
>>>>>> I believe the meetings are recorded as well, but never looked at recordings.
>>>>>
>>>>> That's not what I understood Hugh to mean.  To me, it seemed that Hugh
>>>>> was expressing an opinion on using shmem as shmem, not as using it as
>>>>> tmpfs.
>>>>>
>>>>> If I misunderstood Hugh, well, I still disagree.  We should not have
>>>>> separate controls for this.  tmpfs is just not that special.
>>>
>>> I wasn't at the meeting that's being referred to, but I thought we previously
>>> agreed that tmpfs *is* special because in some configurations its not backed by
>>> swap so is locked in ram?
>>
>> There are multiple things to that, like:
>>
>> * Machines only having limited/no swap configured
>> * tmpfs can be configured to never go to swap
>> * memfd/tmpfs files getting used purely for mmap(): there is no real
>>   difference to MAP_ANON|MAP_SHARE besides the processes we share that
>>   memory with.
>>
>> Especially when it comes to memory waste concerns and access behavior in
>> some cases, tmpfs behaved much more like anonymous memory. But there are for
>> sure other use cases where tmpfs is not that special.
> 
> Having controls to select the allowable folio order allocations for
> tmpfs does not address any of these issues. The suggested filesystem
> approach [1] involves allocating orders in larger chunks, but always
> the same size you would allocate when using order-0 folios. 

Well you can't know that you will never allocate more. If you allocate a 2M
block, you probably have some good readahead data that tells you you are likely
to keep reading sequentially, but you don't know for sure that the application
won't stop after just 4K.

> So,
> it's a conservative approach. Using mTHP knobs in tmpfs would cause:
> * Over allocation when using mTHP and/ord THP under the 'always' flag.
> * Allocate in bigger chunks in a non optimal way, when
> not all mTHP and THP orders are enabled.
> * Operate in a similar manner as in [1] when all mTHP and THP orders
> are enabled and 'within_size' flag is used (assuming we use patch 11
> from [1]).

Large folios may still be considered scarce resources even if the amount of
memory allocated is still the same. And if shmem isn't backed by swap then once
you have allocated a large folio for shmem, it is stuck in shmem, even if it
would be better used somewhere else.

And it's possible (likely even, in my opinion) that allocating lots of different
folio sizes will exacerbate memory fragmentation, leading to more order-0
fallbacks, which would hurt the overall system performance in the long run, vs
restricting to a couple of folio sizes.

I'm starting some work to actually measure how limiting the folio sizes
allocated for page cache memory can help reduce large folio allocation failure
overall. My hypothesis is that the data will show us that in an environment like
Android, where memory pressure is high, limiting everything to order-0 and
order-4 will significantly improve the allocation success rate of order-4. Let's
see.

> 
> [1] Last 3 patches of these series:
> https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
> 
> My understanding of why mTHP was preferred is to raise awareness in
> user space and allow tmpfs mounts used at boot time to operate in
> 'safe' mode (no large folios). Does it make more sense to have a large
> folios enable flag to control order allocation as in [1], instead of
> every single order possible?

My intuition is towards every order possible, as per above. Let's see what the
data tells us.

> 
>>
>> My opinion is that we need to let people configure orders (if you feel like
>> it, configure all), but *select* the order to allocate based on readahead
>> information -- in contrast to anonymous memory where we start at the highest
>> order and don't have readahead information available.
>>
>> Maybe we need different "order allcoation" logic for read/write vs. fault,
>> not sure.
> 
> I would suggest [1] the file size of the write for the write
> and fallocate paths. But when does make sense to use readahead
> information? Maybe when swap is involved?
> 
>>
>> But I don't maintain that code, so I can only give stupid suggestions and
>> repeat what I understood from the meeting with Hugh and Kirill :)
>>
>> -- 
>> Cheers,
>>
>> David / dhildenb



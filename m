Return-Path: <linux-kernel+bounces-242200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738049284E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2808D28DEE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884C514659D;
	Fri,  5 Jul 2024 09:13:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338513665A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170795; cv=none; b=N+iN7Nkc22qGl7WooDVhjvJTn8gHEyw3poO8nc2IztPp811ox1EPuz9disGaPeRj1mRdImUjewsb3xjZwkyxI0Y8oW44SSIaQ9Y6rcgwXvSeR7CWEtF5QVkWhx1yHQk/mpQ1o+8B7tvxJeQEHVM3APDdb7uF8loWciMKebhYczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170795; c=relaxed/simple;
	bh=HG9ZkdgE7pSY045N6ZYHW+Jsdvm0IIq0KWQCw3uFPsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUG9+SSkek68ho3S+c1EMYcyI+SLO72J/qV9yeYR7DW6nxlhnkQEFzERBvsK7KOtR2S9F7LT/xIBH2nGeVVTJGGQlNilF8SLBp4xX/m9FvdlOsKREronaRPaD/PkY8rPnWfduZzIRMxV/B4PLzmMVdePs5umL8JjKhRyih6MNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A4C3367;
	Fri,  5 Jul 2024 02:13:37 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366AF3F762;
	Fri,  5 Jul 2024 02:13:09 -0700 (PDT)
Message-ID: <8d3804ad-14c8-4041-8f52-58fd9dd8d4b4@arm.com>
Date: Fri, 5 Jul 2024 10:13:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] add mTHP support for anonymous shmem
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hughd@google.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <ZobtTmzj0AmNXcav@casper.infradead.org>
 <27beaa0e-697e-4e30-9ac6-5de22228aec1@redhat.com>
 <6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>
 <Zob8xI-LWe9H_iJs@casper.infradead.org>
 <e08b8245-bc8c-4a18-a1e0-53a139258826@linux.alibaba.com>
 <e826368d-499a-483b-8991-8c25aff88f00@arm.com>
 <32f04739-0cd0-4a9e-9419-c5a13c333c28@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <32f04739-0cd0-4a9e-9419-c5a13c333c28@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/07/2024 09:59, David Hildenbrand wrote:
> On 05.07.24 10:45, Ryan Roberts wrote:
>> On 05/07/2024 06:47, Baolin Wang wrote:
>>>
>>>
>>> On 2024/7/5 03:49, Matthew Wilcox wrote:
>>>> On Thu, Jul 04, 2024 at 09:19:10PM +0200, David Hildenbrand wrote:
>>>>> On 04.07.24 21:03, David Hildenbrand wrote:
>>>>>>> shmem has two uses:
>>>>>>>
>>>>>>>      - MAP_ANONYMOUS | MAP_SHARED (this patch set)
>>>>>>>      - tmpfs
>>>>>>>
>>>>>>> For the second use case we don't want controls *at all*, we want the
>>>>>>> same heiristics used for all other filesystems to apply to tmpfs.
>>>>>>
>>>>>> As discussed in the MM meeting, Hugh had a different opinion on that.
>>>>>
>>>>> FWIW, I just recalled that I wrote a quick summary:
>>>>>
>>>>> https://lkml.kernel.org/r/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com
>>>>>
>>>>> I believe the meetings are recorded as well, but never looked at recordings.
>>>>
>>>> That's not what I understood Hugh to mean.  To me, it seemed that Hugh
>>>> was expressing an opinion on using shmem as shmem, not as using it as
>>>> tmpfs.
>>>>
>>>> If I misunderstood Hugh, well, I still disagree.  We should not have
>>>> separate controls for this.  tmpfs is just not that special.
>>
>> I wasn't at the meeting that's being referred to, but I thought we previously
>> agreed that tmpfs *is* special because in some configurations its not backed by
>> swap so is locked in ram?
> 
> There are multiple things to that, like:
> 
> * Machines only having limited/no swap configured
> * tmpfs can be configured to never go to swap
> * memfd/tmpfs files getting used purely for mmap(): there is no real
>   difference to MAP_ANON|MAP_SHARE besides the processes we share that
>   memory with.
> 
> Especially when it comes to memory waste concerns and access behavior in some
> cases, tmpfs behaved much more like anonymous memory. But there are for sure
> other use cases where tmpfs is not that special.
> 
> My opinion is that we need to let people configure orders (if you feel like it,
> configure all), but *select* the order to allocate based on readahead
> information -- in contrast to anonymous memory where we start at the highest
> order and don't have readahead information available.

That approach is exactly what I proposed to start playing with yesterday [1] for
regular pagecache folio allocations too :)

[1] https://lore.kernel.org/linux-mm/bdde4008-60db-4717-a6b5-53d77ab76bdb@arm.com/

> 
> Maybe we need different "order allcoation" logic for read/write vs. fault, not
> sure.
> 
> But I don't maintain that code, so I can only give stupid suggestions and repeat
> what I understood from the meeting with Hugh and Kirill :)
> 



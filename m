Return-Path: <linux-kernel+bounces-241375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D19C927A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFFDB22355
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFDD1B11F4;
	Thu,  4 Jul 2024 15:54:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043131A2C1E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108498; cv=none; b=ozfVQa3A9L/yoo0TuMyZZiAIvJhSo3aLfWdEtM8ChGhETzn6qVUvngghU9PThKPWUc9+eajYOz72qNghUMgTgeLpsqnDwiCrgXK29fiGnk7vVzj/2h24rBVjyoK8kz97asvuUOKrkh/kCaw+9eeE1nNi8SRNXkkScLYOezIg86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108498; c=relaxed/simple;
	bh=GYVjXUMXWOSB0S5uEJ5hsnw6MGDS9cy7pdS0qsPlUFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMd/vbQxYye5EqGutdtuKkAEqawM7t+rRcEaBZFh6EitdtvI2yUKU4WoXHx+oO5sTrJniSZOzU6TcZ7kFc5bbNeEn5WLjg+oD5ZBDNqbCKXeun4+QggW9fsdhxTch5Dddm/vcmG5lTmBRoJftYTSM9H9P1p+7J+dvLMtyxUmgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E862367;
	Thu,  4 Jul 2024 08:55:21 -0700 (PDT)
Received: from [10.1.29.168] (XHFQ2J9959.cambridge.arm.com [10.1.29.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F399A3F762;
	Thu,  4 Jul 2024 08:54:53 -0700 (PDT)
Message-ID: <ed383686-e71a-453c-b751-182531b46a76@arm.com>
Date: Thu, 4 Jul 2024 16:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: shmem: add mTHP support for anonymous shmem
Content-Language: en-GB
To: Bang Li <libang.linux@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <65796c1e72e51e15f3410195b5c2d5b6c160d411.1718090413.git.baolin.wang@linux.alibaba.com>
 <65c37315-2741-481f-b433-cec35ef1af35@arm.com>
 <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
 <b33b94bb-38c7-4b54-bdd3-51dec0535438@arm.com>
 <33d04365-c129-453e-b3b3-0691cfecd36e@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <33d04365-c129-453e-b3b3-0691cfecd36e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/07/2024 16:05, Bang Li wrote:
> Hey Ryan,
> 
> On 2024/7/4 21:58, Ryan Roberts wrote:
>>>> Then for tmpfs, which doesn't support non-PMD-sizes yet, we just always use the
>>>> PMD-size control for decisions.
>>>>
>>>> I'm also really struggling with the concept of shmem_is_huge() existing along
>>>> side shmem_allowable_huge_orders(). Surely this needs to all be refactored into
>>>> shmem_allowable_huge_orders()?
>>> I understood. But now they serve different purposes: shmem_is_huge() will be
>>> used to check the huge orders for the top level, for*tmpfs*  and anon shmem;
>>> whereas shmem_allowable_huge_orders() will only be used to check the per-size
>>> huge orders for anon shmem (excluding tmpfs now). However, as I plan to add mTHP
>>> support for tmpfs, I think we can perform some cleanups.
>>>
>>>>> +    /* Allow mTHP that will be fully within i_size. */
>>>>> +    order = highest_order(within_size_orders);
>>>>> +    while (within_size_orders) {
>>>>> +        index = round_up(index + 1, order);
>>>>> +        i_size = round_up(i_size_read(inode), PAGE_SIZE);
>>>>> +        if (i_size >> PAGE_SHIFT >= index) {
>>>>> +            mask |= within_size_orders;
>>>>> +            break;
>>>>> +        }
>>>>> +
>>>>> +        order = next_order(&within_size_orders, order);
>>>>> +    }
>>>>> +
>>>>> +    if (vm_flags & VM_HUGEPAGE)
>>>>> +        mask |= READ_ONCE(huge_shmem_orders_madvise);
>>>>> +
>>>>> +    if (global_huge)
>>>> Perhaps I've misunderstood global_huge, but I think its just the return value
>>>> from shmem_is_huge()? But you're also using shmem_huge directly in this
>>> Yes.
>>>
>>>> function. I find it all rather confusing.
>>> I think I have explained why need these logics as above. Since mTHP support for
>>> shmem has just started (tmpfs is still in progress). I will make it more clear
>>> in the following patches.
>> OK as long as you have a plan for the clean up, that's good enough for me.
> 
> Can I continue to push the following patch [1]? When other types of shmem mTHP
> are supported, we will perform cleanups uniformly.

I guess that makes sense.

> 
> [1] https://lore.kernel.org/linux-mm/20240702023401.41553-1-libang.li@antgroup.com/
> 
> Thanks,
> Bang



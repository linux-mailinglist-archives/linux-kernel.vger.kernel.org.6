Return-Path: <linux-kernel+bounces-203586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9813D8FDD82
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0171C22743
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4E61DFD1;
	Thu,  6 Jun 2024 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iMGWWlbI"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3341C6A5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644670; cv=none; b=hoqKB2QDkL9Uu1j99D8Oc6ZNIeIexlMfXZ7RE0ZzQqSrLfFF1MgL/NQ0beQHVzSMfdU44dWudSJt9xaRKHMd+PQSCFuRz4XNiXnmS8c1zcD/8/sYIwRqPGAhgyuNgflgaE57twQk9Im17hyRC9Bfi2kp5lW76BnfHUGFUHM+Yrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644670; c=relaxed/simple;
	bh=77I7MOowuR63tjAnme5PFeXdSJ8HCpXTRt1h1MLFHuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3HdtmY+h1MEEpW9JKd24evtkDnLl6iH5fIzfKpyrJuXxHlTgfB2jlXBus+bW26gpSU0NJ4tLmZuDc4JXgqvjML2Fo7VYi8ehuZIqrsCusXIghzV217WEQvnibS929YfAnII65gPYUjw7PRvSOlSlxdOa6VrMzhBQrdUz/guGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iMGWWlbI; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717644664; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8bvsBpySglCFgXdNC5I77P307WaretQBqm5HvmnfVMg=;
	b=iMGWWlbInsSMyQ+OfgVMT6ndG4eJ/t+pqL82C+sGk3IMCHze9PxGpReGy6AZPZ35zOlBNtr6WI1d9hz79HMEaOJXgUri65xy89mZap83vNTm32nBY42sTzVsGZPKOTMxzXwhgPQxH0o3ePnfKf80KyqsZFNDYcQrIXSgSilz284=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7wss4x_1717644661;
Received: from 30.97.56.72(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7wss4x_1717644661)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 11:31:02 +0800
Message-ID: <e7b4aaa1-170d-4500-bf7a-63672e4d81b8@linux.alibaba.com>
Date: Thu, 6 Jun 2024 11:31:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>
Cc: David Hildenbrand <david@redhat.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
 <db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
 <CGME20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db@eucas1p2.samsung.com>
 <502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
 <slkkien5nc3weyzebdlxs5jjvealqzmctbom7sfvijvkolhsjj@athcc2aqq77p>
 <f11c1b52-67d1-4c2a-834b-47302b0054bc@linux.alibaba.com>
 <5mezgqzg7wmd4iq2d2q3aentziosetwcll3tgdbl3mhriseyv3@pgxsux7qvxno>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5mezgqzg7wmd4iq2d2q3aentziosetwcll3tgdbl3mhriseyv3@pgxsux7qvxno>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/4 20:05, Daniel Gomez wrote:
> On Tue, Jun 04, 2024 at 05:45:20PM +0800, Baolin Wang wrote:
>>
>>
>> On 2024/6/4 16:18, Daniel Gomez wrote:
>>> On Fri, May 31, 2024 at 01:13:48PM +0200, David Hildenbrand wrote:
>>>>>>
>>>>>> As a default, we should not be using large folios / mTHP for any shmem,
>>>>>> just like we did with THP via shmem_enabled. This is what this series
>>>>>> currently does, and is aprt of the whole mTHP user-space interface design.
>>>>>>
>>>>>> Further, the mTHP controls should control all of shmem, not only
>>>>>> "anonymous shmem".
>>>>>
>>>>> Yes, that's what I thought and in my TODO list.
>>>>
>>>> Good, it would be helpful to coordinate with Daniel and Pankaj.
>>>
>>> I've integrated patches 11 and 12 from the lsf RFC thread [1] on top of Baolin's
>>> v3 patches. You may find a version in my integration branch here [2]. I can
>>> attach them here if it's preferred.
>>>
>>> [1] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
>>> [2] https://protect2.fireeye.com/v1/url?k=a23e7c06-c3b56926-a23ff749-74fe485fb347-371ca2bfd5d9869f&q=1&e=6974304e-a786-4255-93a7-57498540241c&u=https%3A%2F%2Fgitlab.com%2Fdkruces%2Flinux-next%2F-%2Fcommits%2Fnext-20240604-shmem-mthp
>>>
>>> The point here is to combine the large folios strategy I proposed with mTHP
>>> user controls. Would it make sense to limit the orders to the mapping order
>>> calculated based on the size and index?
>>
>> IMO, for !anon shmem, this change makes sense to me. We should respect the
>> size and mTHP should act as a order filter.
> 
> What about respecing the size when within_size flag is enabled? Then, 'always'
> would allocate mTHP enabled folios, regardless of the size. And 'never'
> would ignore mTHP and size. So, 'never' can be used for this 'safe' boot case
> mentioned in the discussion.

Looks reasonable to me. What do you think, David?

And what about 'advise' option? Silimar to 'within_size'?

>> For anon shmem, we should ignore the length, which you always set it to
>> PAGE_SIZE in patch [1].
>>
>> [1] https://protect2.fireeye.com/v1/url?k=0d75a0c6-6cfeb5e6-0d742b89-74fe485fb347-904fa75c8efebdc2&q=1&e=6974304e-a786-4255-93a7-57498540241c&u=https%3A%2F%2Fgitlab.com%2Fdkruces%2Flinux-next%2F-%2Fcommit%2Fedf02311fd6d86b355d3aeb74e67c8da6de3c569
> 
> Since we are ignoring the length, we should ignore any value being passed.
> 
>>
>>> @@ -1765,6 +1798,10 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>>
>>>                   order = highest_order(suitable_orders);
>>>                   while (suitable_orders) {
>>> +                       if (order > mapping_order) {
>>> +                               order = next_order(&suitable_orders, order);
>>> +                               continue;
>>> +                       }
>>>                           pages = 1UL << order;
>>>                           index = round_down(index, pages);
>>>                           folio = shmem_alloc_folio(gfp, order, info, index);
>>>
>>> Note: The branch still need to be adapted to include !anon mm.


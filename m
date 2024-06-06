Return-Path: <linux-kernel+bounces-204012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F28FE2E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384D928222D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383F715357A;
	Thu,  6 Jun 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eiXEEJDn"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE9153517
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666296; cv=none; b=I7hau2YZkGbxUT8ZUAzxxoZ4y9EbfokMYgKAEZU051/HQfIIEubEKCFahiD/vAVi2m1jy8B4aHBt2BvQ7YjjKVhc3HVSNG2hZvwwtEBHKJl3fMGyzYPQhV74pR/bLSG6c7uJdC/FjRXEZaR+hICturUNmH0PmaMdX35aPsC28F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666296; c=relaxed/simple;
	bh=lhNvlZLKk6LbkWN2wiQs55+WfQxtSjp304vt1wWAFNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiPoOyjCwWZvCVebRTLKBwTbGsjvJoqKBKjkJv8d0l9G65xs7/GbgHNpbSZcOkicir3eo803VJZW9sgwfGmGbQuIuL4xVb7oft6/4eBnxOewQBDBErAc7GhyWc4KFvUJt73IeMq9H2fjvD59raick643QTweLSxdKSjk6J06goo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eiXEEJDn; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717666286; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8q8Fkl2jA1U5hSAvLLBPc/Mm5V5YlZfvuHx62cOLGLY=;
	b=eiXEEJDnRadImuDaFAYchG6cd16iRfW/i4iqCeEbr0Y0IBEoKrzWGv6+Qc4dUPTi9MhN6TfGF7BcZKyiAkphIvRvVnPpjX95Utx9Er2h6d8zzb643BWNx1bIv3b0h1Oo4WyaH587tGhaJpz8cbLT/E9Wmxv97UE/DlU0J32J5Iw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7xuZWn_1717666283;
Received: from 30.97.56.72(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7xuZWn_1717666283)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 17:31:24 +0800
Message-ID: <cc73bbfe-b61f-4e81-aa47-670d3db29dbe@linux.alibaba.com>
Date: Thu, 6 Jun 2024 17:31:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: David Hildenbrand <david@redhat.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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
 <e7b4aaa1-170d-4500-bf7a-63672e4d81b8@linux.alibaba.com>
 <d5a22158-e663-43d2-a43e-8ad54bae16c8@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d5a22158-e663-43d2-a43e-8ad54bae16c8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/6 16:38, David Hildenbrand wrote:
> On 06.06.24 05:31, Baolin Wang wrote:
>>
>>
>> On 2024/6/4 20:05, Daniel Gomez wrote:
>>> On Tue, Jun 04, 2024 at 05:45:20PM +0800, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/6/4 16:18, Daniel Gomez wrote:
>>>>> On Fri, May 31, 2024 at 01:13:48PM +0200, David Hildenbrand wrote:
>>>>>>>>
>>>>>>>> As a default, we should not be using large folios / mTHP for any 
>>>>>>>> shmem,
>>>>>>>> just like we did with THP via shmem_enabled. This is what this 
>>>>>>>> series
>>>>>>>> currently does, and is aprt of the whole mTHP user-space 
>>>>>>>> interface design.
>>>>>>>>
>>>>>>>> Further, the mTHP controls should control all of shmem, not only
>>>>>>>> "anonymous shmem".
>>>>>>>
>>>>>>> Yes, that's what I thought and in my TODO list.
>>>>>>
>>>>>> Good, it would be helpful to coordinate with Daniel and Pankaj.
>>>>>
>>>>> I've integrated patches 11 and 12 from the lsf RFC thread [1] on 
>>>>> top of Baolin's
>>>>> v3 patches. You may find a version in my integration branch here 
>>>>> [2]. I can
>>>>> attach them here if it's preferred.
>>>>>
>>>>> [1] 
>>>>> https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
>>>>> [2] 
>>>>> https://protect2.fireeye.com/v1/url?k=a23e7c06-c3b56926-a23ff749-74fe485fb347-371ca2bfd5d9869f&q=1&e=6974304e-a786-4255-93a7-57498540241c&u=https%3A%2F%2Fgitlab.com%2Fdkruces%2Flinux-next%2F-%2Fcommits%2Fnext-20240604-shmem-mthp
>>>>>
>>>>> The point here is to combine the large folios strategy I proposed 
>>>>> with mTHP
>>>>> user controls. Would it make sense to limit the orders to the 
>>>>> mapping order
>>>>> calculated based on the size and index?
>>>>
>>>> IMO, for !anon shmem, this change makes sense to me. We should 
>>>> respect the
>>>> size and mTHP should act as a order filter.
>>>
>>> What about respecing the size when within_size flag is enabled? Then, 
>>> 'always'
>>> would allocate mTHP enabled folios, regardless of the size. And 'never'
>>> would ignore mTHP and size. So, 'never' can be used for this 'safe' 
>>> boot case
>>> mentioned in the discussion.
>>
>> Looks reasonable to me. What do you think, David?
>>
> 
> That mimics existing PMD-THP behavior, right?
> 
> With "within_size", we must not exceed the size, with "always", we may 
> exceed the size.

Yes, I think so.

>> And what about 'advise' option? Silimar to 'within_size'?
> 
> Good question. What's the behavior of PMD-THP? I would assume it behaves 
> like "within_size", because in the common case we mmap (+advise) only 
> within the size of the file, not exceeding it.

Yes, that is also my understanding.

> (the always option, as I learned during the meeting, is primarily 
> helpful when writing to tmpfs files in an append-fashion. With 
> mmap()+madvise() that doesn't quite happen)
> 


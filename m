Return-Path: <linux-kernel+bounces-173006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B64C8BF9EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFC61C20B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA1C7E105;
	Wed,  8 May 2024 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mBNYTKZH"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EEA79949
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162218; cv=none; b=h+1u5tLdlm6yZ3UIE2HEjzrKdkYpcw06Pca7pbfrrVEXTRssUfgFOn6EBkwmLtR7OScFA9F5dB8OVontuHa5hM8JfsS/eLO3A9m6MC51DZyVz0ZqaG+0qITc5Yb/EI1DcEnGP9dRb75Su94coIXDHipZYa/9aehv66rOqqnoQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162218; c=relaxed/simple;
	bh=9xNyjQkipGmx1mN5SWcI9+/ajbVZSr+JzYwwStd2HpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PA3rtM6uY9292MdUCMUVqqRqNSGdYHQo8DC4BhwwclgHdh0LGhcYZnmhY7O2UQ/zoypa0WndVoIjVWG8VX4n2kZJuuKqzmrTdDwobaAQz3Gm/v/WvaVGdW6k6iu1GUYbqXlSjo5NZALvVnphRQ7sMPCK7cXut9jZuBFduvlawI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mBNYTKZH; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715162213; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9mDT2UAsElMka1cWBGabDh1k3Fz10LnTvOvoW1OfKOU=;
	b=mBNYTKZH+bmd49LqRhJXZACvWk+Ac3Ad55rLLtxeXIeVz/1B9vSkBXNLCVXXEZV/3r/g9tqwOLgIJTmh27+QyEYG7UTKS1EXTej7xZBb1I3pp1gqqfwktqnr2jASbkbBgFTXy+QT+0LZJM42sLgOfDu2rAFAfRkrWx3hynuyzrE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W63AqH0_1715162209;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W63AqH0_1715162209)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 17:56:51 +0800
Message-ID: <5b23a706-5fb3-41b4-ba2e-d38a29b51820@linux.alibaba.com>
Date: Wed, 8 May 2024 17:56:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm: shmem: add multi-size THP sysfs interface for
 anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand
 <david@redhat.com>, akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <6b4afed1ef26dbd08ae9ec58449b329564dcef3e.1714978902.git.baolin.wang@linux.alibaba.com>
 <30329a82-45b9-4e78-8c48-bd56af113786@arm.com>
 <0b3735bc-2ad7-44f8-808b-37fc90d57199@linux.alibaba.com>
 <cb458b62-e27d-47d6-8efd-bacdb9da7530@redhat.com>
 <ff1908f8-0887-403b-8d2a-d83a17895523@redhat.com>
 <eb3aa3dc-42ee-475a-8b95-d27951c362a1@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <eb3aa3dc-42ee-475a-8b95-d27951c362a1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/8 17:02, Ryan Roberts wrote:
> On 08/05/2024 08:12, David Hildenbrand wrote:
>> On 08.05.24 09:08, David Hildenbrand wrote:
>>> On 08.05.24 06:45, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/5/7 18:52, Ryan Roberts wrote:
>>>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>>>> To support the use of mTHP with anonymous shmem, add a new sysfs interface
>>>>>> 'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
>>>>>> directory for each mTHP to control whether shmem is enabled for that mTHP,
>>>>>> with a value similar to the top level 'shmem_enabled', which can be set to:
>>>>>> "always", "inherit (to inherit the top level setting)", "within_size",
>>>>>> "advise",
>>>>>> "never", "deny", "force". These values follow the same semantics as the top
>>>>>> level, except the 'deny' is equivalent to 'never', and 'force' is equivalent
>>>>>> to 'always' to keep compatibility.
>>>>>
>>>>> We decided at [1] to not allow 'force' for non-PMD-sizes.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-mm/533f37e9-81bf-4fa2-9b72-12cdcb1edb3f@redhat.com/
>>>>>
>>>>> However, thinking about this a bit more, I wonder if the decision we made to
>>>>> allow all hugepages-xxkB/enabled controls to take "inherit" was the wrong one.
>>>>> Perhaps we should have only allowed the PMD-sized enable=inherit (this is just
>>>>> for legacy back compat after all, I don't think there is any use case where
>>>>> changing multiple mTHP size controls atomically is actually useful). Applying
>>>>
>>>> Agree. This is also our usage of 'inherit'.
>>
>> Missed that one: there might be use cases in the future once we would start
>> defaulting to "inherit" for all knobs (a distro might default to that) and
>> default-enable THP in the global knob. Then, it would be easy to disable any THP
>> by disabling the global knob. (I think that's the future we're heading to, where
>> we'd have an "auto" mode that can be set on the global toggle).
>>
>> But I am just making up use cases ;) I think it will be valuable and just doing
>> it consistently now might be cleaner.
> 
> I agree that consistency between enabled and shmem_enabled is top priority. And
> yes, I had forgotten about the glorious "auto" future. So probably continuing
> all sizes to select "inherit" is best.
> 
> But for shmem_enabled, that means we need the following error checking:
> 
>   - It is an error to set "force" for any size except PMD-size
> 
>   - It is an error to set "force" for the global control if any size except PMD-
>     size is set to "inherit"
> 
>   - It is an error to set "inherit" for any size except PMD-size if the global
>     control is set to "force".
> 
> Certainly not too difficult to code and prove to be correct, but not the nicest
> UX from the user's point of view when they start seeing errors.
> 
> I think we previously said this would likely be temporary, and if/when tmpfs
> gets mTHP support, we could simplify and allow all sizes to be set to "force".
> But I wonder if tmpfs would ever need explicit mTHP control? Maybe it would be
> more suited to the approach the page cache takes to transparently ramp up the
> folio size as it faults more in. (Just saying there is a chance that this error
> checking becomes permanent).

The strategy for tmpfs supporting mTHP will require more discussions and 
evaluations in the future. However, regardless of the strategy (explicit 
mTHP control or page cache control), I think it would be possible to use 
'force' to override previous strategies for some testing purposes. This 
appears to be permissible according to the explanation in the current 
documentation: "force the huge option on for all - very useful for 
testing". So it seems not permanent?


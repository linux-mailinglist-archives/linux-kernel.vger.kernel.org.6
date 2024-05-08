Return-Path: <linux-kernel+bounces-172949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78D8BF933
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AADB2408F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963CB71B50;
	Wed,  8 May 2024 09:02:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA123A1BE
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158968; cv=none; b=aCRAlADGaxXLRMk1xwHiW6X4mDHzWs6kg42FO6cAD7ON4R2baVzr2cpqFwvUDIYm+p2evw6tu4vGn9wZ6JbIptYNNwzwjjlSLaqz2foWaAaXWRESdZDhZGTPWLoB4iQN1rDxwCPv63sxdxY1RNKeYHI5j2yOHMmjq9/bACjDDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158968; c=relaxed/simple;
	bh=qdVURWUQTSFjr2TDtJ9VB2HmxpiC61kP72lHZ5Sh/9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J63+AM6GYPhPd6iL7PUPdgRMTSyZ3kwhJrbJQq1vDMguW1pJ7c0MMa9hrB4MWvo+bO0zmauufYE5KnbkXXLcvPa0q+ILTjiEhsubabhCjNAhrRtZZbR9HDjTgEcGyHxX3dqeY3TXQCWGtyhYPD05qBAcvYihzMTaELYl9ucAJSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ECFD1063;
	Wed,  8 May 2024 02:03:10 -0700 (PDT)
Received: from [10.57.67.194] (unknown [10.57.67.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43F0C3F6A8;
	Wed,  8 May 2024 02:02:43 -0700 (PDT)
Message-ID: <eb3aa3dc-42ee-475a-8b95-d27951c362a1@arm.com>
Date: Wed, 8 May 2024 10:02:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm: shmem: add multi-size THP sysfs interface for
 anonymous shmem
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <6b4afed1ef26dbd08ae9ec58449b329564dcef3e.1714978902.git.baolin.wang@linux.alibaba.com>
 <30329a82-45b9-4e78-8c48-bd56af113786@arm.com>
 <0b3735bc-2ad7-44f8-808b-37fc90d57199@linux.alibaba.com>
 <cb458b62-e27d-47d6-8efd-bacdb9da7530@redhat.com>
 <ff1908f8-0887-403b-8d2a-d83a17895523@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ff1908f8-0887-403b-8d2a-d83a17895523@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2024 08:12, David Hildenbrand wrote:
> On 08.05.24 09:08, David Hildenbrand wrote:
>> On 08.05.24 06:45, Baolin Wang wrote:
>>>
>>>
>>> On 2024/5/7 18:52, Ryan Roberts wrote:
>>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>>> To support the use of mTHP with anonymous shmem, add a new sysfs interface
>>>>> 'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
>>>>> directory for each mTHP to control whether shmem is enabled for that mTHP,
>>>>> with a value similar to the top level 'shmem_enabled', which can be set to:
>>>>> "always", "inherit (to inherit the top level setting)", "within_size",
>>>>> "advise",
>>>>> "never", "deny", "force". These values follow the same semantics as the top
>>>>> level, except the 'deny' is equivalent to 'never', and 'force' is equivalent
>>>>> to 'always' to keep compatibility.
>>>>
>>>> We decided at [1] to not allow 'force' for non-PMD-sizes.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-mm/533f37e9-81bf-4fa2-9b72-12cdcb1edb3f@redhat.com/
>>>>
>>>> However, thinking about this a bit more, I wonder if the decision we made to
>>>> allow all hugepages-xxkB/enabled controls to take "inherit" was the wrong one.
>>>> Perhaps we should have only allowed the PMD-sized enable=inherit (this is just
>>>> for legacy back compat after all, I don't think there is any use case where
>>>> changing multiple mTHP size controls atomically is actually useful). Applying
>>>
>>> Agree. This is also our usage of 'inherit'.
> 
> Missed that one: there might be use cases in the future once we would start
> defaulting to "inherit" for all knobs (a distro might default to that) and
> default-enable THP in the global knob. Then, it would be easy to disable any THP
> by disabling the global knob. (I think that's the future we're heading to, where
> we'd have an "auto" mode that can be set on the global toggle).
> 
> But I am just making up use cases ;) I think it will be valuable and just doing
> it consistently now might be cleaner.

I agree that consistency between enabled and shmem_enabled is top priority. And
yes, I had forgotten about the glorious "auto" future. So probably continuing
all sizes to select "inherit" is best.

But for shmem_enabled, that means we need the following error checking:

 - It is an error to set "force" for any size except PMD-size

 - It is an error to set "force" for the global control if any size except PMD-
   size is set to "inherit"

 - It is an error to set "inherit" for any size except PMD-size if the global
   control is set to "force".

Certainly not too difficult to code and prove to be correct, but not the nicest
UX from the user's point of view when they start seeing errors.

I think we previously said this would likely be temporary, and if/when tmpfs
gets mTHP support, we could simplify and allow all sizes to be set to "force".
But I wonder if tmpfs would ever need explicit mTHP control? Maybe it would be
more suited to the approach the page cache takes to transparently ramp up the
folio size as it faults more in. (Just saying there is a chance that this error
checking becomes permanent).



Return-Path: <linux-kernel+bounces-173350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D48BFF31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0D31F2841E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93784E0C;
	Wed,  8 May 2024 13:44:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08884FB0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175894; cv=none; b=EJ61nhqFVbP9TRWP/SiIPCS/AlAnPbHuspmd0KyJkaa3hMKjRdbBxM9NqXGxOHJq7SeZANSx23artH1ix+Vlm5RdG5TRz0kv1Wiw0NYRdmhVIdoKiPmQgp4upOGBNXjkKGPrzXXim88YpEuZzl00ukooxboyiYUTe+S51yC/YlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175894; c=relaxed/simple;
	bh=QQkuAYK+QN4dGi4nt9lryKu3Nr4bzKUPv783mZFrhQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPBlBo3tonASWQmFIBCg8FWQRLz5pKsFWdN1ValO2HYsOGsiiapRKeJdzE9ZhsRgEB35BRhLaob6rN5cvmHgBG0N1MGAdL/onsneEYrIQlcGdEbF1vrnS1Li8yvQVyj/pJTvMC3E6uADi+rz9Rw8AkWckhk+QYhiykrFcnSDe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE5B1007;
	Wed,  8 May 2024 06:45:05 -0700 (PDT)
Received: from [10.57.67.194] (unknown [10.57.67.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42FDC3F6A8;
	Wed,  8 May 2024 06:44:38 -0700 (PDT)
Message-ID: <a26caf5f-81be-4760-9724-9772d5ec339c@arm.com>
Date: Wed, 8 May 2024 14:44:36 +0100
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
 <eb3aa3dc-42ee-475a-8b95-d27951c362a1@arm.com>
 <928c73de-76b0-40d6-a0c3-23d72270ac5c@redhat.com>
 <28f311ec-9b46-4f28-991c-ac74177acf32@redhat.com>
 <5c2c70fd-a291-4ca4-b229-dc54e92b3471@arm.com>
 <f7efdbf6-958c-4576-a375-8f7548f58dec@redhat.com>
 <578e878b-259e-4944-99c2-9caf578e9642@arm.com>
 <6e412cee-be0c-4c94-b576-ebdd897e6e05@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6e412cee-be0c-4c94-b576-ebdd897e6e05@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/05/2024 14:07, David Hildenbrand wrote:
> On 08.05.24 14:54, Ryan Roberts wrote:
>> On 08/05/2024 13:45, David Hildenbrand wrote:
>>> On 08.05.24 14:43, Ryan Roberts wrote:
>>>> On 08/05/2024 13:10, David Hildenbrand wrote:
>>>>> On 08.05.24 14:02, David Hildenbrand wrote:
>>>>>> On 08.05.24 11:02, Ryan Roberts wrote:
>>>>>>> On 08/05/2024 08:12, David Hildenbrand wrote:
>>>>>>>> On 08.05.24 09:08, David Hildenbrand wrote:
>>>>>>>>> On 08.05.24 06:45, Baolin Wang wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2024/5/7 18:52, Ryan Roberts wrote:
>>>>>>>>>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>>>>>>>>>> To support the use of mTHP with anonymous shmem, add a new sysfs
>>>>>>>>>>>> interface
>>>>>>>>>>>> 'shmem_enabled' in the
>>>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
>>>>>>>>>>>> directory for each mTHP to control whether shmem is enabled for that
>>>>>>>>>>>> mTHP,
>>>>>>>>>>>> with a value similar to the top level 'shmem_enabled', which can be
>>>>>>>>>>>> set to:
>>>>>>>>>>>> "always", "inherit (to inherit the top level setting)", "within_size",
>>>>>>>>>>>> "advise",
>>>>>>>>>>>> "never", "deny", "force". These values follow the same semantics as
>>>>>>>>>>>> the top
>>>>>>>>>>>> level, except the 'deny' is equivalent to 'never', and 'force' is
>>>>>>>>>>>> equivalent
>>>>>>>>>>>> to 'always' to keep compatibility.
>>>>>>>>>>>
>>>>>>>>>>> We decided at [1] to not allow 'force' for non-PMD-sizes.
>>>>>>>>>>>
>>>>>>>>>>> [1]
>>>>>>>>>>> https://lore.kernel.org/linux-mm/533f37e9-81bf-4fa2-9b72-12cdcb1edb3f@redhat.com/
>>>>>>>>>>>
>>>>>>>>>>> However, thinking about this a bit more, I wonder if the decision we
>>>>>>>>>>> made to
>>>>>>>>>>> allow all hugepages-xxkB/enabled controls to take "inherit" was the
>>>>>>>>>>> wrong
>>>>>>>>>>> one.
>>>>>>>>>>> Perhaps we should have only allowed the PMD-sized enable=inherit
>>>>>>>>>>> (this is
>>>>>>>>>>> just
>>>>>>>>>>> for legacy back compat after all, I don't think there is any use case
>>>>>>>>>>> where
>>>>>>>>>>> changing multiple mTHP size controls atomically is actually useful).
>>>>>>>>>>> Applying
>>>>>>>>>>
>>>>>>>>>> Agree. This is also our usage of 'inherit'.
>>>>>>>>
>>>>>>>> Missed that one: there might be use cases in the future once we would start
>>>>>>>> defaulting to "inherit" for all knobs (a distro might default to that) and
>>>>>>>> default-enable THP in the global knob. Then, it would be easy to disable
>>>>>>>> any
>>>>>>>> THP
>>>>>>>> by disabling the global knob. (I think that's the future we're heading to,
>>>>>>>> where
>>>>>>>> we'd have an "auto" mode that can be set on the global toggle).
>>>>>>>>
>>>>>>>> But I am just making up use cases ;) I think it will be valuable and just
>>>>>>>> doing
>>>>>>>> it consistently now might be cleaner.
>>>>>>>
>>>>>>> I agree that consistency between enabled and shmem_enabled is top priority.
>>>>>>> And
>>>>>>> yes, I had forgotten about the glorious "auto" future. So probably
>>>>>>> continuing
>>>>>>> all sizes to select "inherit" is best.
>>>>>>>
>>>>>>> But for shmem_enabled, that means we need the following error checking:
>>>>>>>
>>>>>>>      - It is an error to set "force" for any size except PMD-size
>>>>>>>
>>>>>>>      - It is an error to set "force" for the global control if any size
>>>>>>> except
>>>>>>> PMD-
>>>>>>>        size is set to "inherit"
>>>>>>>
>>>>>>>      - It is an error to set "inherit" for any size except PMD-size if the
>>>>>>> global
>>>>>>>        control is set to "force".
>>>>>>>
>>>>>>> Certainly not too difficult to code and prove to be correct, but not the
>>>>>>> nicest
>>>>>>> UX from the user's point of view when they start seeing errors.
>>>>>>>
>>>>>>> I think we previously said this would likely be temporary, and if/when tmpfs
>>>>>>> gets mTHP support, we could simplify and allow all sizes to be set to
>>>>>>> "force".
>>>>>>> But I wonder if tmpfs would ever need explicit mTHP control? Maybe it
>>>>>>> would be
>>>>>>> more suited to the approach the page cache takes to transparently ramp up
>>>>>>> the
>>>>>>> folio size as it faults more in. (Just saying there is a chance that this
>>>>>>> error
>>>>>>> checking becomes permanent).
>>>>>>
>>>>>> Note that with shmem you're inherently facing the same memory waste
>>>>>> issues etc as you would with anonymous memory. (sometimes even worse, if
>>>>>> you're running shmem that's configured to be unswappable!).
>>>>>
>>>>> Also noting that memory waste is not really a problem when a write to a shmem
>>>>> file allocates a large folio that stays within boundaries of that write;
>>>>> issues
>>>>> only pop up if you end up over-allocating, especially, during page faults
>>>>> where
>>>>> you have not that much clue about what to do (single address, no real range
>>>>> provided).
>>>>>
>>>>> There is the other issue that wasting large chunks of contiguous memory on
>>>>> stuff
>>>>> that barely benefits from it. With memory that maybe never gets evicted, there
>>>>> is no automatic "handing back" of that memory to the system to be used by
>>>>> something else. With ordinary files, that's a bit different. But I did not
>>>>> look
>>>>> closer into that issue yet, it's one of the reasons MADV_HUGEPAGE was added
>>>>> IIRC.
>>>>
>>>> OK understood. Although, with tmpfs you're not going to mmap it then randomly
>>>> extend the file through page faults - mmap doesn't permit that, I don't think?
>>>> So presumably the user must explicitly set the size of the file first? Are you
>>>> suggesting there are a lot of use cases where a large tmpfs file is created,
>>>> mmaped then only accessed sparsely?
>>>
>>> I don't know about "a lot of use cases", but for VMs that's certainly how it's
>>> used.
>>
> 
> There are more details around that and the sparsity (memory ballooning,
> virtio-mem, free page reporting), but it might distract here :) I'll note that
> shmem+THP is known to be problematic with memory ballooning.
> 
>> Gottya, thanks. And out of curiosity, what's the benefit of using tmpfs rather
>> than private (or shared) anonymous memory for VMs?
> 
> The primary use case I know of is sharing VM memory with other processes
> (usually not child processes): DPDK/SPDK and other vhost-user variants (such as
> virtiofs) mmap() all guest memory to access it directly (some sort of
> multi-process hypervisors). They either use real-file-based shmem or memfd
> (essentially the same without a named file) for that.
> 
> Then, there is live-hypervisor upgrade, whereby you start a second hypervisor
> process that will take over. People use shmem for that, so you can minimize
> downtime by migrating guest memory simply by mmap'ing the shmem file into the
> new hypervisor.
> 
> Shared anonymous memory is basically never used (I only know of one corner case
> in QEMU).
> 
> I would assume that there are also DBs making use of rather sparse shmem? But no
> expert on that.
> 

That all makes sense - thanks for the lesson!



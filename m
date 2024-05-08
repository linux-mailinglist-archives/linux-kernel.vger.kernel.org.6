Return-Path: <linux-kernel+bounces-173238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED48BFD73
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F93B225CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816D54F89;
	Wed,  8 May 2024 12:43:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD851C5E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172204; cv=none; b=V6iiaaK4JdtYkqRTjpDsBRzXQso5k+NXi/xPDllTTJI7RjycEyOCCqG8G6Z5pZhAZ3n7qpCySqvqdz02N1aEVIZ0N5Zdh8k6fHYdnr3cS1B2zfZooUcJWHCz3B7obYf0h4SbuUy4gm06cyamWWcR5fkU7shqzE72gO8GKqX3QKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172204; c=relaxed/simple;
	bh=siMa5/wUwvisBwU0iCVyBGFBjNUzxMzAbJQZJBk1IpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4+IAyN5oD8amDasdipW7mJThWcJ3QouEbi4m7rkVA74M7uh7l/Hj9sVc2yDCRq8v5kQHa0iwcUXWTbiH5pEBVHwzcr/yXjFir3BV7ShnwZtP3xlT6oXXO3oToVPDUBhy8FXvdu90a9UKANCgk7/b7grNbmLyMQJXs2uJi+dRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A6401007;
	Wed,  8 May 2024 05:43:47 -0700 (PDT)
Received: from [10.57.67.194] (unknown [10.57.67.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2D4E3F587;
	Wed,  8 May 2024 05:43:19 -0700 (PDT)
Message-ID: <5c2c70fd-a291-4ca4-b229-dc54e92b3471@arm.com>
Date: Wed, 8 May 2024 13:43:18 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <28f311ec-9b46-4f28-991c-ac74177acf32@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/05/2024 13:10, David Hildenbrand wrote:
> On 08.05.24 14:02, David Hildenbrand wrote:
>> On 08.05.24 11:02, Ryan Roberts wrote:
>>> On 08/05/2024 08:12, David Hildenbrand wrote:
>>>> On 08.05.24 09:08, David Hildenbrand wrote:
>>>>> On 08.05.24 06:45, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/5/7 18:52, Ryan Roberts wrote:
>>>>>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>>>>>> To support the use of mTHP with anonymous shmem, add a new sysfs interface
>>>>>>>> 'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
>>>>>>>> directory for each mTHP to control whether shmem is enabled for that mTHP,
>>>>>>>> with a value similar to the top level 'shmem_enabled', which can be set to:
>>>>>>>> "always", "inherit (to inherit the top level setting)", "within_size",
>>>>>>>> "advise",
>>>>>>>> "never", "deny", "force". These values follow the same semantics as the top
>>>>>>>> level, except the 'deny' is equivalent to 'never', and 'force' is
>>>>>>>> equivalent
>>>>>>>> to 'always' to keep compatibility.
>>>>>>>
>>>>>>> We decided at [1] to not allow 'force' for non-PMD-sizes.
>>>>>>>
>>>>>>> [1]
>>>>>>> https://lore.kernel.org/linux-mm/533f37e9-81bf-4fa2-9b72-12cdcb1edb3f@redhat.com/
>>>>>>>
>>>>>>> However, thinking about this a bit more, I wonder if the decision we made to
>>>>>>> allow all hugepages-xxkB/enabled controls to take "inherit" was the wrong
>>>>>>> one.
>>>>>>> Perhaps we should have only allowed the PMD-sized enable=inherit (this is
>>>>>>> just
>>>>>>> for legacy back compat after all, I don't think there is any use case where
>>>>>>> changing multiple mTHP size controls atomically is actually useful).
>>>>>>> Applying
>>>>>>
>>>>>> Agree. This is also our usage of 'inherit'.
>>>>
>>>> Missed that one: there might be use cases in the future once we would start
>>>> defaulting to "inherit" for all knobs (a distro might default to that) and
>>>> default-enable THP in the global knob. Then, it would be easy to disable any
>>>> THP
>>>> by disabling the global knob. (I think that's the future we're heading to,
>>>> where
>>>> we'd have an "auto" mode that can be set on the global toggle).
>>>>
>>>> But I am just making up use cases ;) I think it will be valuable and just doing
>>>> it consistently now might be cleaner.
>>>
>>> I agree that consistency between enabled and shmem_enabled is top priority. And
>>> yes, I had forgotten about the glorious "auto" future. So probably continuing
>>> all sizes to select "inherit" is best.
>>>
>>> But for shmem_enabled, that means we need the following error checking:
>>>
>>>    - It is an error to set "force" for any size except PMD-size
>>>
>>>    - It is an error to set "force" for the global control if any size except
>>> PMD-
>>>      size is set to "inherit"
>>>
>>>    - It is an error to set "inherit" for any size except PMD-size if the global
>>>      control is set to "force".
>>>
>>> Certainly not too difficult to code and prove to be correct, but not the nicest
>>> UX from the user's point of view when they start seeing errors.
>>>
>>> I think we previously said this would likely be temporary, and if/when tmpfs
>>> gets mTHP support, we could simplify and allow all sizes to be set to "force".
>>> But I wonder if tmpfs would ever need explicit mTHP control? Maybe it would be
>>> more suited to the approach the page cache takes to transparently ramp up the
>>> folio size as it faults more in. (Just saying there is a chance that this error
>>> checking becomes permanent).
>>
>> Note that with shmem you're inherently facing the same memory waste
>> issues etc as you would with anonymous memory. (sometimes even worse, if
>> you're running shmem that's configured to be unswappable!).
> 
> Also noting that memory waste is not really a problem when a write to a shmem
> file allocates a large folio that stays within boundaries of that write; issues
> only pop up if you end up over-allocating, especially, during page faults where
> you have not that much clue about what to do (single address, no real range
> provided).
> 
> There is the other issue that wasting large chunks of contiguous memory on stuff
> that barely benefits from it. With memory that maybe never gets evicted, there
> is no automatic "handing back" of that memory to the system to be used by
> something else. With ordinary files, that's a bit different. But I did not look
> closer into that issue yet, it's one of the reasons MADV_HUGEPAGE was added IIRC.

OK understood. Although, with tmpfs you're not going to mmap it then randomly
extend the file through page faults - mmap doesn't permit that, I don't think?
So presumably the user must explicitly set the size of the file first? Are you
suggesting there are a lot of use cases where a large tmpfs file is created,
mmaped then only accessed sparsely?




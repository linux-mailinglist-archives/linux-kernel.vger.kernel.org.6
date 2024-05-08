Return-Path: <linux-kernel+bounces-173272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D388BFDF9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF22428252B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28226A33B;
	Wed,  8 May 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O67Sw037"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240D26AFF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173648; cv=none; b=WAt09e8s7i12HdSeZbF5tN/O9TwpBqrcBPgAdZayPnORfFNRJJsBb7+YRMiP/QVRgrRCbaMYeTZFnBKWWYrYQWNziYSgnHz5V1DIoIRJerbmtn0MmZ8c8H49hQCZkLQvUrWe+NmZHLVyLL//vlbBo/74UXDmM6Qoz4alTACq2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173648; c=relaxed/simple;
	bh=WlCXfJ9Yyl3crro6Nwo2a8hVUAyxtOrawteNnkLe15w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGUj4ufIB06IsgIj5Q3frrxbWlR367cjGK7s6EOaGnz9J81MCF4hoACqNkzfu0JDLFatXrHF/4mZ8s4EMIdn/fgkUmSBdMt0DRmb0iCzPAd71uQr/7+RlGxpa74Lo4uIOOJUdsMb61CeOK/NF4SA3Cb3wdWXcdo5WTQEvqiH9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O67Sw037; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715173646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rdBrx5WYu21KLTBYO2bUYFNypPxYiLADFrBWze4ykxo=;
	b=O67Sw037FQNxJ/hve7PWehj/GOM34CziM5jOdtk2H96G/K/m2BurrHxBPR1pPRp8Oxcd1E
	auqmahPiwRAGBPEFdAyg70EQf1j51UyuT22aO/f6xJwlM4Kl+W6K1T7ZcTdyMP3n+ASqOO
	ndVh7SoDw3HpLIpOFuBanEW0XKMnfIg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-iInz1WEzMx-t3q4U1yiQlw-1; Wed, 08 May 2024 09:07:24 -0400
X-MC-Unique: iInz1WEzMx-t3q4U1yiQlw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34dce5456c3so3501635f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 06:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715173643; x=1715778443;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rdBrx5WYu21KLTBYO2bUYFNypPxYiLADFrBWze4ykxo=;
        b=ZhfyO6OfMSm1aV+60YV6fPTNLQXNjvc1njHIGbKXfWVJaKwLeZ/WVHzHQK8OT1NS+f
         vjBpfBxjesA+iwtaf1a6f0P+pJHak2SqOa6ZMIO4fd4HwtzY8Kr/dMpBgWJUzV/b57ji
         jRgaoIA2f/mD3b7iLqJYG4/3VKz4hp785ZFW/nZijEW5QxMs8X18sMvSpGExx07kuD1v
         N+N5aAj2Zz8hBF2QP02ki9rxDyFjK1qlXRkf557q9AiTHOTCFBNOs7r+24+GXphBamwn
         zPn2B0pYxRwPB05eWEK/8SHkGDTaKYC6cisVwBMnUaYtukvRLYMLZOPkqIrl43GQWqgw
         6zZw==
X-Forwarded-Encrypted: i=1; AJvYcCWXOCFADS/vXpuLJOXrmAY7Uj3F1zpRZLAuLATmmlVaZ3bEoYP6kqpX92L1xVzLsPOHTGb4X/PnAJCOJVmiWDBtWnttGPtA2+HRc+fX
X-Gm-Message-State: AOJu0YxVnUtTpVn/p1NPgeAPsDGkqgKR18GWJh9e3VUGbnzIG/R7sUbT
	2VcoQKNb6FeXelyJ0/9U4sZsgIU6hDcg1t4sQILevSqDUmrQUBwdzPxtPUoPyZoK7ht5HzqM7EN
	AI3G+SMiufTEYHecuupKWTWiuuBSwi9LnT2UuIpX8vnYKCW+BNcQjMSg8/+NGjA==
X-Received: by 2002:a5d:640a:0:b0:34b:dc21:68f2 with SMTP id ffacd0b85a97d-34fca241885mr2425464f8f.28.1715173643336;
        Wed, 08 May 2024 06:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy3UlVgBprhsYFeBywnab2f04ycsfggrYA1QAvTpY9jPw+4Kw5eGW9KTTG5nbaIt8WEmzLwQ==
X-Received: by 2002:a5d:640a:0:b0:34b:dc21:68f2 with SMTP id ffacd0b85a97d-34fca241885mr2425445f8f.28.1715173642769;
        Wed, 08 May 2024 06:07:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3100:35c3:fc4b:669f:9ff9? (p200300cbc707310035c3fc4b669f9ff9.dip0.t-ipconnect.de. [2003:cb:c707:3100:35c3:fc4b:669f:9ff9])
        by smtp.gmail.com with ESMTPSA id s3-20020adfe003000000b0034e8a10039esm12271508wrh.10.2024.05.08.06.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 06:07:22 -0700 (PDT)
Message-ID: <6e412cee-be0c-4c94-b576-ebdd897e6e05@redhat.com>
Date: Wed, 8 May 2024 15:07:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm: shmem: add multi-size THP sysfs interface for
 anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <578e878b-259e-4944-99c2-9caf578e9642@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.05.24 14:54, Ryan Roberts wrote:
> On 08/05/2024 13:45, David Hildenbrand wrote:
>> On 08.05.24 14:43, Ryan Roberts wrote:
>>> On 08/05/2024 13:10, David Hildenbrand wrote:
>>>> On 08.05.24 14:02, David Hildenbrand wrote:
>>>>> On 08.05.24 11:02, Ryan Roberts wrote:
>>>>>> On 08/05/2024 08:12, David Hildenbrand wrote:
>>>>>>> On 08.05.24 09:08, David Hildenbrand wrote:
>>>>>>>> On 08.05.24 06:45, Baolin Wang wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2024/5/7 18:52, Ryan Roberts wrote:
>>>>>>>>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>>>>>>>>> To support the use of mTHP with anonymous shmem, add a new sysfs
>>>>>>>>>>> interface
>>>>>>>>>>> 'shmem_enabled' in the
>>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
>>>>>>>>>>> directory for each mTHP to control whether shmem is enabled for that
>>>>>>>>>>> mTHP,
>>>>>>>>>>> with a value similar to the top level 'shmem_enabled', which can be
>>>>>>>>>>> set to:
>>>>>>>>>>> "always", "inherit (to inherit the top level setting)", "within_size",
>>>>>>>>>>> "advise",
>>>>>>>>>>> "never", "deny", "force". These values follow the same semantics as
>>>>>>>>>>> the top
>>>>>>>>>>> level, except the 'deny' is equivalent to 'never', and 'force' is
>>>>>>>>>>> equivalent
>>>>>>>>>>> to 'always' to keep compatibility.
>>>>>>>>>>
>>>>>>>>>> We decided at [1] to not allow 'force' for non-PMD-sizes.
>>>>>>>>>>
>>>>>>>>>> [1]
>>>>>>>>>> https://lore.kernel.org/linux-mm/533f37e9-81bf-4fa2-9b72-12cdcb1edb3f@redhat.com/
>>>>>>>>>>
>>>>>>>>>> However, thinking about this a bit more, I wonder if the decision we
>>>>>>>>>> made to
>>>>>>>>>> allow all hugepages-xxkB/enabled controls to take "inherit" was the wrong
>>>>>>>>>> one.
>>>>>>>>>> Perhaps we should have only allowed the PMD-sized enable=inherit (this is
>>>>>>>>>> just
>>>>>>>>>> for legacy back compat after all, I don't think there is any use case
>>>>>>>>>> where
>>>>>>>>>> changing multiple mTHP size controls atomically is actually useful).
>>>>>>>>>> Applying
>>>>>>>>>
>>>>>>>>> Agree. This is also our usage of 'inherit'.
>>>>>>>
>>>>>>> Missed that one: there might be use cases in the future once we would start
>>>>>>> defaulting to "inherit" for all knobs (a distro might default to that) and
>>>>>>> default-enable THP in the global knob. Then, it would be easy to disable any
>>>>>>> THP
>>>>>>> by disabling the global knob. (I think that's the future we're heading to,
>>>>>>> where
>>>>>>> we'd have an "auto" mode that can be set on the global toggle).
>>>>>>>
>>>>>>> But I am just making up use cases ;) I think it will be valuable and just
>>>>>>> doing
>>>>>>> it consistently now might be cleaner.
>>>>>>
>>>>>> I agree that consistency between enabled and shmem_enabled is top priority.
>>>>>> And
>>>>>> yes, I had forgotten about the glorious "auto" future. So probably continuing
>>>>>> all sizes to select "inherit" is best.
>>>>>>
>>>>>> But for shmem_enabled, that means we need the following error checking:
>>>>>>
>>>>>>      - It is an error to set "force" for any size except PMD-size
>>>>>>
>>>>>>      - It is an error to set "force" for the global control if any size except
>>>>>> PMD-
>>>>>>        size is set to "inherit"
>>>>>>
>>>>>>      - It is an error to set "inherit" for any size except PMD-size if the
>>>>>> global
>>>>>>        control is set to "force".
>>>>>>
>>>>>> Certainly not too difficult to code and prove to be correct, but not the
>>>>>> nicest
>>>>>> UX from the user's point of view when they start seeing errors.
>>>>>>
>>>>>> I think we previously said this would likely be temporary, and if/when tmpfs
>>>>>> gets mTHP support, we could simplify and allow all sizes to be set to "force".
>>>>>> But I wonder if tmpfs would ever need explicit mTHP control? Maybe it would be
>>>>>> more suited to the approach the page cache takes to transparently ramp up the
>>>>>> folio size as it faults more in. (Just saying there is a chance that this
>>>>>> error
>>>>>> checking becomes permanent).
>>>>>
>>>>> Note that with shmem you're inherently facing the same memory waste
>>>>> issues etc as you would with anonymous memory. (sometimes even worse, if
>>>>> you're running shmem that's configured to be unswappable!).
>>>>
>>>> Also noting that memory waste is not really a problem when a write to a shmem
>>>> file allocates a large folio that stays within boundaries of that write; issues
>>>> only pop up if you end up over-allocating, especially, during page faults where
>>>> you have not that much clue about what to do (single address, no real range
>>>> provided).
>>>>
>>>> There is the other issue that wasting large chunks of contiguous memory on stuff
>>>> that barely benefits from it. With memory that maybe never gets evicted, there
>>>> is no automatic "handing back" of that memory to the system to be used by
>>>> something else. With ordinary files, that's a bit different. But I did not look
>>>> closer into that issue yet, it's one of the reasons MADV_HUGEPAGE was added
>>>> IIRC.
>>>
>>> OK understood. Although, with tmpfs you're not going to mmap it then randomly
>>> extend the file through page faults - mmap doesn't permit that, I don't think?
>>> So presumably the user must explicitly set the size of the file first? Are you
>>> suggesting there are a lot of use cases where a large tmpfs file is created,
>>> mmaped then only accessed sparsely?
>>
>> I don't know about "a lot of use cases", but for VMs that's certainly how it's
>> used.
> 

There are more details around that and the sparsity (memory ballooning, 
virtio-mem, free page reporting), but it might distract here :) I'll 
note that shmem+THP is known to be problematic with memory ballooning.

> Gottya, thanks. And out of curiosity, what's the benefit of using tmpfs rather
> than private (or shared) anonymous memory for VMs?

The primary use case I know of is sharing VM memory with other processes 
(usually not child processes): DPDK/SPDK and other vhost-user variants 
(such as virtiofs) mmap() all guest memory to access it directly (some 
sort of multi-process hypervisors). They either use real-file-based 
shmem or memfd (essentially the same without a named file) for that.

Then, there is live-hypervisor upgrade, whereby you start a second 
hypervisor process that will take over. People use shmem for that, so 
you can minimize downtime by migrating guest memory simply by mmap'ing 
the shmem file into the new hypervisor.

Shared anonymous memory is basically never used (I only know of one 
corner case in QEMU).

I would assume that there are also DBs making use of rather sparse 
shmem? But no expert on that.

-- 
Cheers,

David / dhildenb



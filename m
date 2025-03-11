Return-Path: <linux-kernel+bounces-556859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC10AA5CF93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B69C176908
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600732641F8;
	Tue, 11 Mar 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/mfVEjn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C407260A32
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721952; cv=none; b=JVOHxi0aT2L5iz/p29EpadUtEY6CsvWWYxYAxHvFebXOIgBsgfk6wJV1OKOEmZvNFdaw1QoNgnXLZoLMUcM/u4xcwJNCH5htseb9470rg7Cw24TQJ0+VkT3bN8ZYT9Sm6hj8I+0GvinBuLwFT94SObQ8F5V68zTj9lwiGxns+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721952; c=relaxed/simple;
	bh=YkZ/TcNv0HdWlRnXqnQM9gx41uhBgkaoZSH7qw1iyzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJywE1Q6BUqsg0ORL1BRBPNzTWHx+bWRMe41HL/tM0dne0ip8qm/vGPTzTE3wHTzACrGOck1Cjwnee7Vj63to+4U2VQzZN8wfbl188SyosNhzJTNq4Qzi7OFpo5LYlofNgK6Oi7mS8oO32FOKg7GIiiFyR475KL2DNomNXCR4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/mfVEjn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741721949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TkpiVDzbmBSYXzJH2N3ZtFv5FO4TW0Ld9CXfBOUouPI=;
	b=R/mfVEjn+e8xKCsqSHej5r2H6gFebrn4Mj1pta4z+3akd96bbf26k0vqFP6M0MZk2rSn9A
	ojiGwMIAiZ88BRf8nvSWTqbayS0rN9KNSRPGI0V2CypJ7zggzhUglUbeqIYZaWGDzXHWws
	9K9nWYe2EcclMolomBNHTkDkz8tlFQY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-_gc71P9nOy6B1bT_3K0NRA-1; Tue, 11 Mar 2025 15:39:08 -0400
X-MC-Unique: _gc71P9nOy6B1bT_3K0NRA-1
X-Mimecast-MFC-AGG-ID: _gc71P9nOy6B1bT_3K0NRA_1741721947
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43935e09897so40816775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741721947; x=1742326747;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TkpiVDzbmBSYXzJH2N3ZtFv5FO4TW0Ld9CXfBOUouPI=;
        b=u9ItTIqsFtAyegwC/39xxgf/ds2+kr6MZK7Lw1gpeiiCmpc7nebqdnbAUafqODGdLP
         ZtT4qmy5PzS/M/LsPptOUeOw4WiAXc7h7fhRpo88T2cDrf62HMqmjz/uBUUd3+uxHkKW
         3jzlxeJOZRaTJA3r1F7P8gUYSMxUvOkZDi95pQzwJ3doH31M+oWgjDlP7Oe0Y8FDUl7+
         3j+f39e6D+32WVBOgooSQ7vuOSjI/w950Ys8sno254gePeaRnDXU7qUaq6xKPJIaMYMP
         u6bmf+jC5aeDns9ddfIyXVtkalLqNY/8niiLwsfo1qLMUZqPGzoVT7jHH9L+sUndIYo/
         i8Rg==
X-Gm-Message-State: AOJu0YysHH+kIJ+Md7LdLb0BgIJBjChbTVogoY0tHTp5s059M6RPjYi8
	2Hmsu3jG8wROFksPrqEL23buukc7e95wsH+HQ6+xe6prV6zKo70JgAA1FJ/WHGq5wpQ3HYDuugp
	TerheryFF05Sy22qhwciocQNfkw0JWsnhxewmJfK2X7j8hT0mfhXqtPMeRH7TeQ==
X-Gm-Gg: ASbGncsr8lH2HXQi+wRAL7Unb8fpxkUPjXPMiaERwx4CJsdlv5NzOkTaAkwR9yOfhlM
	AwK9KZovz3zIVcItrGYpGrThA7XNUigR0KME+daPhBq9E3HeLNh23W5KkDYY0GxhONaztxybPWX
	G+FpAAMEZ+qM9CNs1DX45Qll5IoAcd7GpPDyzzBj28lpB4dWzlxk/7Sobcj4woT8Te3/61K6r1V
	CsmXCZ/hZ16tIjfRJHBleTqVMcym0mq6fH7SbV5v9LRtzOaQkH8YqaKVbHI6NGdSjOcErP/ypoW
	sDiO99czXSewePz1wuswFowSZgkXCsRgjASP7Eshgq36
X-Received: by 2002:a05:6000:1542:b0:38d:d0ea:b04c with SMTP id ffacd0b85a97d-39132dacdddmr17362008f8f.38.1741721946974;
        Tue, 11 Mar 2025 12:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5+M47aY9rTdZOSMZQ5BeysSrDDcGeOj01Lu7+fYXrsqqcWXAkHHcWA5UKCbyMETY0hSU2yQ==
X-Received: by 2002:a05:6000:1542:b0:38d:d0ea:b04c with SMTP id ffacd0b85a97d-39132dacdddmr17361984f8f.38.1741721946543;
        Tue, 11 Mar 2025 12:39:06 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23d1d.dip0.t-ipconnect.de. [79.242.61.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceaac390bsm121916255e9.35.2025.03.11.12.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:39:05 -0700 (PDT)
Message-ID: <2a3683e5-0812-4333-b793-3180c61b8bc7@redhat.com>
Date: Tue, 11 Mar 2025 20:39:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver/base/node.c: Fix softlockups during the
 initialization of large systems with interleaved memory blocks
To: Donet Tom <donettom@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
References: <20250310115305.13599-1-donettom@linux.ibm.com>
 <2025031051-gab-viability-e288@gregkh>
 <a30e4786-ed0e-4460-8b95-c56ab1d790ea@linux.ibm.com>
 <09f2a2bb-75ab-44e1-9e27-d4fa0c11a47b@redhat.com>
 <b426c9f0-9d63-4764-825c-6d95e89353c0@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b426c9f0-9d63-4764-825c-6d95e89353c0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.03.25 16:00, Donet Tom wrote:
> 
> On 3/11/25 2:59 PM, David Hildenbrand wrote:
>> On 11.03.25 09:56, Donet Tom wrote:
>>>
>>> On 3/10/25 6:22 PM, Greg Kroah-Hartman wrote:
>>>> On Mon, Mar 10, 2025 at 06:53:05AM -0500, Donet Tom wrote:
>>>>> On large systems with more than 64TB of DRAM, if the memory blocks
>>>>> are interleaved, node initialization (node_dev_init()) could take
>>>>> a long time since it iterates over each memory block. If the memory
>>>>> block belongs to the current iterating node, the first pfn_to_nid
>>>>> will provide the correct value. Otherwise, it will iterate over all
>>>>> PFNs and check the nid. On non-preemptive kernels, this can result
>>>>> in a watchdog softlockup warning. Even though CONFIG_PREEMPT_LAZY
>>>>> is enabled in kernels now [1], we may still need to fix older
>>>>> stable kernels to avoid encountering these kernel warnings during
>>>>> boot.
>>>>>
>>>>> This patch adds a cond_resched() call in node_dev_init() to avoid
>>>>> this warning.
>>>>>
>>>>> node_dev_init()
>>>>>        register_one_node
>>>>>            register_memory_blocks_under_node
>>>>>                walk_memory_blocks()
>>>>>                    register_mem_block_under_node_early
>>>>>                        get_nid_for_pfn
>>>>>                            early_pfn_to_nid
>>>>>
>>>>> In my system node4 has a memory block ranging from memory30351
>>>>> to memory38524, and memory128433. The memory blocks between
>>>>> memory38524 and memory128433 do not belong to this node.
>>>>>
>>>>> In  walk_memory_blocks() we iterate over all memblocks starting
>>>>> from memory38524 to memory128433.
>>>>> In register_mem_block_under_node_early(), up to memory38524, the
>>>>> first pfn correctly returns the corresponding nid and the function
>>>>> returns from there. But after memory38524 and until memory128433,
>>>>> the loop iterates through each pfn and checks the nid. Since the nid
>>>>> does not match the required nid, the loop continues. This causes
>>>>> the soft lockups.
>>>>>
>>>>> [1]:
>>>>> https://lore.kernel.org/linuxppc-dev/20241116192306.88217-1-sshegde@linux.ibm.com/
>>>>> Fixes: 2848a28b0a60 ("drivers/base/node: consolidate node device
>>>>> subsystem initialization in node_dev_init()")
>>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>>> ---
>>>>>     drivers/base/node.c | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>>> index 0ea653fa3433..107eb508e28e 100644
>>>>> --- a/drivers/base/node.c
>>>>> +++ b/drivers/base/node.c
>>>>> @@ -975,5 +975,6 @@ void __init node_dev_init(void)
>>>>>             ret = register_one_node(i);
>>>>>             if (ret)
>>>>>                 panic("%s() failed to add node: %d\n", __func__, ret);
>>>>> +        cond_resched();
>>>> That's a horrible hack, sorry, but no, we can't sprinkle this around in
>>>> random locations, especially as this is actually fixed by using a
>>>> different scheduler model as you say.
>>>>
>>>> Why not just make the code faster so as to avoid the long time this
>>>> takes?
>>>
>>>
>>> Thanks Greg
>>>
>>> I was checking the code to see how to make it faster in order to
>>> avoid the long time it takes.
>>>
>>> In below code path
>>>
>>> register_one_node()
>>>        register_memory_blocks_under_node()
>>>            walk_memory_blocks()
>>>                register_mem_block_under_node_early()
>>>
>>> walk_memory_blocks() is iterating over all memblocks, and
>>> register_mem_block_under_node_early() is iterating over the PFNs
>>> to find the page_nid
>>>
>>> If the page_nid and the requested nid are the same, we will register
>>> the memblock under the node and return.
>>>
>>> But if get_nid_for_pfn() returns a different nid (This means the
>>> memblock is part of different nid), then the loop will iterate
>>> over all PFNs of the memblock and check if the page_nid returned by
>>> get_nid_for_pfn() and the requested nid are the same.
>>>
>>> IIUC, since all PFNs of a memblock return the same page_nid, we
>>> should stop the loop if the page_nid returned does not match the
>>> requested nid.
>>
>> Nodes can easily partially span "memory blocks". So your patch would
>> break these setups?
> 
> 
> Does this mean one memory block can be part of two or
> more nodes ? Some PFNs belong to one node, and the remaining
> PFNs belong to another node?"

Exactly.

Consider the following qemu cmdline as one example:

qemu-system-x86_64 --enable-kvm -smp 10 -M q35 -m 4G -hda 
Fedora-Server-KVM-40-1.14.x86_64.qcow2 -nographic -object 
memory-backend-ram,size=2000M,id=mem0 -object 
memory-backend-ram,size=2096M,id=mem1 -numa node,cpus=0-4,memdev=mem0 
-numa node,cpus=5-9,memdev=mem1


Inside the VM:

[root@localhost ~]# ls /sys/devices/system/node/node0/
compact  cpu4       meminfo   memory12  memory3  memory8         subsystem
cpu0     cpulist    memory0   memory13  memory4  memory9         uevent
cpu1     cpumap     memory1   memory14  memory5  memory_failure  vmstat
cpu2     distance   memory10  memory15  memory6  numastat        x86
cpu3     hugepages  memory11  memory2   memory7  power
[root@localhost ~]# ls /sys/devices/system/node/node1/
compact  cpu9       meminfo   memory35  memory40  memory45        power
cpu5     cpulist    memory15  memory36  memory41  memory46        subsystem
cpu6     cpumap     memory32  memory37  memory42  memory47        uevent
cpu7     distance   memory33  memory38  memory43  memory_failure  vmstat
cpu8     hugepages  memory34  memory39  memory44  numastat        x86


Observer how memory15 shows up for both nodes.

[root@localhost ~]# ls /sys/devices/system/memory/memory15/
node0  online       phys_index  removable  subsystem  valid_zones
node1  phys_device  power       state      uevent

Observe how both nodes are listed

[root@localhost ~]# cat /sys/devices/system/memory/memory15/valid_zones
none

And "valid_zone = none" indicates that this memory block cannot get 
offlined because it spans multiple zones (here: from multiple nodes)

> 
> In that case, the current implementation adds the memory block to
> only one node. In register_mem_block_under_node_early(), if the
> first PFN returns the correct expected nid, the memory block will
> be registered under that node. It does not iterate over the other
> PFNs. Is this because of the assumption that one memory block
> cannot be part of multiple nodes?

See my example above. But note that my test VM has

]# uname -a
Linux localhost.localdomain 6.11.10-200.fc40.x86_64 #1 SMP 
PREEMPT_DYNAMIC Sat Nov 23 00:53:13 UTC 2024 x86_64 GNU/Linux


> 
> If one memory block cannot be part of multiple nodes, then we can
> break if get_nid_for_pfn() returns the wrong nid, right?

Again, see above. Hopefully that makes it clearer.

> 
> 
>>
>> But I agree that iterating all pages is rather nasty. I wonder if we
>> could just walk all memblocks in the range?
>>
>> early_pfn_to_nid()->__early_pfn_to_nid() would lookup the memblock ...
>> for each PFN. Testing a range instead could be better.
>>
>> Something like "early_pfn_range_spans_nid()" could be useful for that.
> 
> Do you mean we should do it section by section within a memory block?

All we want to know is if the memblock allocator ("early") thinks that 
any part of the memory block device (memory_block_size_bytes()) belongs 
to that node.

-- 
Cheers,

David / dhildenb



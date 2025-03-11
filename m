Return-Path: <linux-kernel+bounces-555750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E7A5BC49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899617A97EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A6222ACF2;
	Tue, 11 Mar 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpAfR9mf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E4622576C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685375; cv=none; b=PchUzSvOb2qM4ZP0YsuwJTRLx7iH9q9x/R1QSEdibLEOgI1WgWE1x6L5itVaZoRuOLqZ2vDRa/aTZuC2zhgstk/JnsFEL0z+sK7pMzd28lDSijb5jZoP8AbR8nC1kdQ1V5D0Gxxu1NyiBET5zogkWEpLBddgevN3cWCddJRvmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685375; c=relaxed/simple;
	bh=Hl/+UTpHiHogD1Z8Iq3IBZt4L7L/PHNkVjFJV87P8Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyN16wR84KpQhqDZZUKApWrm0nYMpQjGCelPsjDTxBOrjOS4RFmjA1Cg9beKf1k24qbFC1IfKd15AVOTGl6pcrwatDv1G+0oBH9OG2yemMPdAJTzB77mle0+0z3xItY9QvlXgS239udAn3J85Edxu7D9J5mrQ0F9GGBvPgbofy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpAfR9mf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741685372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TS2IEbS7XTEJUqwpY7Y07RDXahMrgWoQ1RubXDgh9Hg=;
	b=dpAfR9mfGCqfLXHP+Ij2uiJ6CAIknaH2UwKZWwjVEPaRy+xQbMBFzFq0rsexv+KwrqDTEk
	kAZwnrPIzbwFlQbUzFHhX+If9pyCNLRPvFWfw8q6aRJGIxD0Nq6n6FNG0SGsSeknOjUL9K
	rzPY/3iaIQSJjCJbOkFj/5q0Wte5Czs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-g2nN-nvXMR6Psft9zm4GUw-1; Tue, 11 Mar 2025 05:29:30 -0400
X-MC-Unique: g2nN-nvXMR6Psft9zm4GUw-1
X-Mimecast-MFC-AGG-ID: g2nN-nvXMR6Psft9zm4GUw_1741685369
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912a0439afso2016212f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685369; x=1742290169;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TS2IEbS7XTEJUqwpY7Y07RDXahMrgWoQ1RubXDgh9Hg=;
        b=bHlDewAGFAJ9+XFKcaYF9rzZwlBGZyG5h5qhAUCb10lt7lfZ50Hyxv95VzAoW3QE1z
         LwJDAsIKsxtM6byMIQEbPZBYWorTJ2hiXVLrdJqGQDGsKiCOfukAMQ3jqnEOxTf7DaeG
         TnieJFY05yH3EkVM1kHpLVYiqeRsUYTbGKJnsOXLT80uSDDpmL7wf0V/sYclgAXxiqkv
         u2p/4TsBRXOEW/SVeuCzlzDrJR5cxS3dun60omi+UB+9DCHVgEeeBROz4UFX0GOcbsh8
         FPPmUcenLXE5FHiOTgGpiEz4aKbUs58wr7/UYNtGxMfOvCA0SRYbD4V25gpqRtTnZNjb
         2Biw==
X-Gm-Message-State: AOJu0YxuZIAoVV0V089baFPD7Mj5o5PrAFqtqJoMenF4qt9pBOyposaN
	LmLDzV6rakdTw1mbHWdPAmdd0OMaEbZEoZM5jmPBN8IZs54IOMpviXCh2lboD9xRS/DvIog9Wzi
	44dGvCrOvRKWh/ORMA9K455/GIu+FgYysyj9ypsagVefTTVJ9BvlShA3FxJtVLV7btMfp30hE
X-Gm-Gg: ASbGnctyNGZz6RpwgP3ZGyX8tkQCEh9hW7t8YvukkGsTSUxFrL600zZYqRk2KQmca9b
	sydGrf/bsJG8vxxNIMdw3qFIOEppRZLrzDvqmJR2Hulh8Kxc4MxGqEQPCYOB8fOSnEZlWrIT3kA
	EQl3UCjBfE0U5YvtxYs89K+EzxANOa2/TMdOpxdMg87Kb0sKw5C5Iy+i32wpLmzeQ7Att5UAUPN
	WVMQi5iBmHBH0P4omwj7DLpR+LZw8P+SBRK5bRg6jvQf3lAJSCkFTGLydXSi1bRxX7nyim0Q44a
	+Jlax1F9kHx2Fl+Jy33HCHXSrLGCxIRXud74syZLGPksERWm/9hp72JXDLx3cCFm2lIJSL8yCEV
	br3bC12nT7TLBZdKDwlvJ4ZFWi2Cc9VSG35hYltDGk6I=
X-Received: by 2002:adf:a39c:0:b0:391:34ef:ae6f with SMTP id ffacd0b85a97d-39134efaf51mr8682850f8f.29.1741685369418;
        Tue, 11 Mar 2025 02:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl2gshcztUdZt7a3J1M65E8UeZZc8JfAkSF7nZ5gh7HThHiVVH3qWU3ORFCyYcbkqwO5lmDQ==
X-Received: by 2002:adf:a39c:0:b0:391:34ef:ae6f with SMTP id ffacd0b85a97d-39134efaf51mr8682829f8f.29.1741685369059;
        Tue, 11 Mar 2025 02:29:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:ed00:a9b3:5954:823e:3427? (p200300cbc720ed00a9b35954823e3427.dip0.t-ipconnect.de. [2003:cb:c720:ed00:a9b3:5954:823e:3427])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102d76sm17309592f8f.86.2025.03.11.02.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:29:28 -0700 (PDT)
Message-ID: <09f2a2bb-75ab-44e1-9e27-d4fa0c11a47b@redhat.com>
Date: Tue, 11 Mar 2025 10:29:27 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a30e4786-ed0e-4460-8b95-c56ab1d790ea@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.03.25 09:56, Donet Tom wrote:
> 
> On 3/10/25 6:22 PM, Greg Kroah-Hartman wrote:
>> On Mon, Mar 10, 2025 at 06:53:05AM -0500, Donet Tom wrote:
>>> On large systems with more than 64TB of DRAM, if the memory blocks
>>> are interleaved, node initialization (node_dev_init()) could take
>>> a long time since it iterates over each memory block. If the memory
>>> block belongs to the current iterating node, the first pfn_to_nid
>>> will provide the correct value. Otherwise, it will iterate over all
>>> PFNs and check the nid. On non-preemptive kernels, this can result
>>> in a watchdog softlockup warning. Even though CONFIG_PREEMPT_LAZY
>>> is enabled in kernels now [1], we may still need to fix older
>>> stable kernels to avoid encountering these kernel warnings during
>>> boot.
>>>
>>> This patch adds a cond_resched() call in node_dev_init() to avoid
>>> this warning.
>>>
>>> node_dev_init()
>>>       register_one_node
>>>           register_memory_blocks_under_node
>>>               walk_memory_blocks()
>>>                   register_mem_block_under_node_early
>>>                       get_nid_for_pfn
>>>                           early_pfn_to_nid
>>>
>>> In my system node4 has a memory block ranging from memory30351
>>> to memory38524, and memory128433. The memory blocks between
>>> memory38524 and memory128433 do not belong to this node.
>>>
>>> In  walk_memory_blocks() we iterate over all memblocks starting
>>> from memory38524 to memory128433.
>>> In register_mem_block_under_node_early(), up to memory38524, the
>>> first pfn correctly returns the corresponding nid and the function
>>> returns from there. But after memory38524 and until memory128433,
>>> the loop iterates through each pfn and checks the nid. Since the nid
>>> does not match the required nid, the loop continues. This causes
>>> the soft lockups.
>>>
>>> [1]: https://lore.kernel.org/linuxppc-dev/20241116192306.88217-1-sshegde@linux.ibm.com/
>>> Fixes: 2848a28b0a60 ("drivers/base/node: consolidate node device subsystem initialization in node_dev_init()")
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> ---
>>>    drivers/base/node.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>> index 0ea653fa3433..107eb508e28e 100644
>>> --- a/drivers/base/node.c
>>> +++ b/drivers/base/node.c
>>> @@ -975,5 +975,6 @@ void __init node_dev_init(void)
>>>    		ret = register_one_node(i);
>>>    		if (ret)
>>>    			panic("%s() failed to add node: %d\n", __func__, ret);
>>> +		cond_resched();
>> That's a horrible hack, sorry, but no, we can't sprinkle this around in
>> random locations, especially as this is actually fixed by using a
>> different scheduler model as you say.
>>
>> Why not just make the code faster so as to avoid the long time this
>> takes?
> 
> 
> Thanks Greg
> 
> I was checking the code to see how to make it faster in order to
> avoid the long time it takes.
> 
> In below code path
> 
> register_one_node()
>       register_memory_blocks_under_node()
>           walk_memory_blocks()
>               register_mem_block_under_node_early()
> 
> walk_memory_blocks() is iterating over all memblocks, and
> register_mem_block_under_node_early() is iterating over the PFNs
> to find the page_nid
> 
> If the page_nid and the requested nid are the same, we will register
> the memblock under the node and return.
> 
> But if get_nid_for_pfn() returns a different nid (This means the
> memblock is part of different nid), then the loop will iterate
> over all PFNs of the memblock and check if the page_nid returned by
> get_nid_for_pfn() and the requested nid are the same.
> 
> IIUC, since all PFNs of a memblock return the same page_nid, we
> should stop the loop if the page_nid returned does not match the
> requested nid.

Nodes can easily partially span "memory blocks". So your patch would 
break these setups?

But I agree that iterating all pages is rather nasty. I wonder if we 
could just walk all memblocks in the range?

early_pfn_to_nid()->__early_pfn_to_nid() would lookup the memblock ... 
for each PFN. Testing a range instead could be better.

Something like "early_pfn_range_spans_nid()" could be useful for that.

-- 
Cheers,

David / dhildenb



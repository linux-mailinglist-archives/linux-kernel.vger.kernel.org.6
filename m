Return-Path: <linux-kernel+bounces-407473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699769C6DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFA7B30728
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182271FF035;
	Wed, 13 Nov 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hB/DJxtf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D4189B9C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497199; cv=none; b=SGiMkADWIk5Ql5LQw6FqMsSMyzLSjX0CPze8Pp5zKQ1zsiAlUZn8Wqwop0PkNHikPdli+zprCb5fsIGHq2k9a/0yf6TnQosIbR65W5wDRIsS7H5haOvy0bvn7/d1emD/rbhp6E7S10o+rNt0jY1O0vdN6yVySbMVIfI0HIyTLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497199; c=relaxed/simple;
	bh=GNLxQhYHPDFPA/FEHUZLWbpSrW8fdFnXAl0oM7GIdsk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rsZs/nkqGEq0TZ7y4HFBM6Ud4kEfZkaJX6ts+kMdFIuAp8ONgbNvsg0G6St4VqDaWDdUCMY+rIV6XdMO2AiGISDyFoFLbxM/3b741971RN5Pw9tjiPmLLWovouXyOymkb3aWE4dqPRKxB1xjqyVVwIj/E8to9X6vbjOLbuMSk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hB/DJxtf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cf6eea3c0so64384205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731497197; x=1732101997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tShJdzek8oAlA+90S87xAJfh+0VNXgDy3EF5I1+WU8M=;
        b=hB/DJxtfugOdWbHG2YeTEkCXpUliaLr8dwSK75s3XeROypOYeVDBDT8+ssSliNB+fA
         V08jjqe6oN/fnDf8tVgMzz1fyfnYZq+C5FCgkTw7WUwmQgAiowNBF+++FtaC7wChE/im
         Z7xI2C3dWGp8klBRDbZCFQoqOw1LlkCa9lEdgfr/vAKPie5q3P1OWnKQS3KacTFPULBm
         jpVkN7rJ4Hu4zXzVT7eLu51po1lbRrO6+ma9uZP/b5iKvcJpgUjEtSVvZz4VR9yfzAmt
         uHvHOnUPfE464Frpphfhy5sceeBvPmzLNy15m/3xrVG+K5hAJDhKkVKh4h96wcPCT1Y6
         1yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731497197; x=1732101997;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tShJdzek8oAlA+90S87xAJfh+0VNXgDy3EF5I1+WU8M=;
        b=Av9brbPEaA9C9SlyoUhe4cQT8l9Q7tHozOxcVh4J7S5D39ZfMmOTVlx4eX6x2yGZn4
         JHECM0RQw+Sb+QI0WYGbFON5UauOMJjQq6RvTxrX4Ezc73AVbU1p+Zoqsy66uPPgx+ct
         pVHE7loCJiwcYQOo7hI3c7I2hGW9Y7UmI403vJsYh270bzmXCmPePQ1k66TqN6XrJODu
         sJHc+neiEOoIw1IrChxyOksWqUdfmECnHhKmo+KBAUgxGVi0KYZIugTXttaelrHZhaoP
         mbxo8xyPPSiHSHxOyzX6JDNokhbZmoJMg8E4mw7D4+vd5ugOI/0SdrOfljpFDGqf7Rl9
         p4VA==
X-Forwarded-Encrypted: i=1; AJvYcCXLfqwQMjkA0dMV8z379Uy/+S7DMvjOq/toJhdK8ZH+Y5OVW/vk8gP8hDTeZTw7QvfAkwOleW4NOkQnLpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCyLNnWCwLFW2nLu8kERmcMkn6GkuKj7d7wcmS54/wxkdy6j1t
	tJ5uQbzLurQmi2DBGhsR3EImCThi/zIgjgCZb3XKjTQEf1aMFaulRDSMX8bf2Ac=
X-Google-Smtp-Source: AGHT+IFOl3bo6SHoi3n53/dqsovcD4Ner0mogD3opsKCYo+OQWdzAbI60vxw3RQUaM7L9lTcGuxoOQ==
X-Received: by 2002:a17:902:fb46:b0:20d:27fa:1911 with SMTP id d9443c01a7336-211834e6bfcmr198791115ad.8.1731497196718;
        Wed, 13 Nov 2024 03:26:36 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c35dsm108944475ad.250.2024.11.13.03.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 03:26:36 -0800 (PST)
Message-ID: <2358f900-ae9a-47b5-8d49-9fda429115be@bytedance.com>
Date: Wed, 13 Nov 2024 19:26:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] x86: mm: free page table pages by RCU instead of
 semi RCU
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: Jann Horn <jannh@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <c45cf245592ad4ccc86429f71500d3fc378ac4a4.1730360798.git.zhengqi.arch@bytedance.com>
 <CAG48ez0XhKnr3uVODu+iihRi4XwLupy=YX8BHa==1Y-ZvrmKjg@mail.gmail.com>
 <e308363a-0c1e-421f-a35e-5bb750992554@bytedance.com>
Content-Language: en-US
In-Reply-To: <e308363a-0c1e-421f-a35e-5bb750992554@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/8 15:38, Qi Zheng wrote:
> Hi Jann,
> 
> On 2024/11/8 06:39, Jann Horn wrote:
>> +x86 MM maintainers - x86@kernel.org was already cc'ed, but I don't
>> know if that is enough for them to see it, and I haven't seen them
>> comment on this series yet; I think you need an ack from them for this
>> change.
> 
> Yes, thanks to Jann for cc-ing x86 MM maintainers, and look forward to
> their feedback!
> 
>>
>> On Thu, Oct 31, 2024 at 9:14 AM Qi Zheng <zhengqi.arch@bytedance.com> 
>> wrote:
>>> Now, if CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, the page table 
>>> pages
>>> will be freed by semi RCU, that is:
>>>
>>>   - batch table freeing: asynchronous free by RCU
>>>   - single table freeing: IPI + synchronous free
>>>
>>> In this way, the page table can be lockless traversed by disabling 
>>> IRQ in
>>> paths such as fast GUP. But this is not enough to free the empty PTE 
>>> page
>>> table pages in paths other that munmap and exit_mmap path, because IPI
>>> cannot be synchronized with rcu_read_lock() in pte_offset_map{_lock}().
>>>
>>> In preparation for supporting empty PTE page table pages reclaimation,
>>> let single table also be freed by RCU like batch table freeing. Then we
>>> can also use pte_offset_map() etc to prevent PTE page from being freed.
>>
>> I applied your series locally and followed the page table freeing path
>> that the reclaim feature would use on x86-64. Looks like it goes like
>> this with the series applied:
> 
> Yes.
> 
>>
>> free_pte
>>    pte_free_tlb
>>      __pte_free_tlb
>>        ___pte_free_tlb
>>          paravirt_tlb_remove_table
>>            tlb_remove_table [!CONFIG_PARAVIRT, Xen PV, Hyper-V, KVM]
>>              [no-free-memory slowpath:]
>>                tlb_table_invalidate
>>                tlb_remove_table_one
>>                  tlb_remove_table_sync_one [does IPI for GUP-fast]
> 
>             ^
>             It seems that this step can be ommitted when
>             CONFIG_PT_RECLAIM is enabled, because GUP-fast will
>             disable IRQ, which can also serve as the RCU critical
>             section.
> 
>>                  __tlb_remove_table_one [frees via RCU]
>>              [fastpath:]
>>                tlb_table_flush
>>                  tlb_remove_table_free [frees via RCU]
>>            native_tlb_remove_table [CONFIG_PARAVIRT on native]
>>              tlb_remove_table [see above]
>>
>> Basically, the only remaining case in which
>> paravirt_tlb_remove_table() does not use tlb_remove_table() with RCU
>> delay is !CONFIG_PARAVIRT && !CONFIG_PT_RECLAIM. Given that
>> CONFIG_PT_RECLAIM is defined as "default y" when supported, I guess
>> that means X86's direct page table freeing path will almost never be
>> used? If it stays that way and the X86 folks don't see a performance
>> impact from using RCU to free tables on munmap() / process exit, I
>> guess we might want to get rid of the direct page table freeing path
>> on x86 at some point to simplify things...
> 
> In theory, using RCU to asynchronously free PTE pages should make
> munmap() / process exit path faster. I can try to grab some data.
> 

I ran 'stress-ng --mmap 1 --mmap-bytes 1G', and grabbed the data with
bpftrace like this:

bpftrace -e 'tracepoint:syscalls:sys_enter_munmap /comm == 
"stress-ng"/{@start[tid] = nsecs;} tracepoint:syscalls:sys_exit_munmap 
/@start[tid]/ { @ns[comm] = hist(nsecs - @start[tid]); 
delete(@start[tid]); } interval:s:1 {exit();}'

The results are as follows:

without patch:

@ns[stress-ng]:
[1K, 2K)           99566 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2K, 4K)           77756 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[4K, 8K)           32545 |@@@@@@@@@@@@@@@@ 
      |
[8K, 16K)            442 | 
      |
[16K, 32K)            69 | 
      |
[32K, 64K)             1 | 
      |
[64K, 128K)            1 | 
      |
[128K, 256K)          14 | 
      |
[256K, 512K)          14 | 
      |
[512K, 1M)            68 | 
      |

with patch:

@ns[stress-ng]:
[512, 1K)             69 | 
      |
[1K, 2K)           53921 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2K, 4K)           47088 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[4K, 8K)           20583 |@@@@@@@@@@@@@@@@@@@ 
      |
[8K, 16K)            659 | 
      |
[16K, 32K)            93 | 
      |
[32K, 64K)            24 | 
      |
[64K, 128K)           14 | 
      |
[128K, 256K)           6 | 
      |
[256K, 512K)          10 | 
      |
[512K, 1M)            29 | 
      |

It doesn't seem to have much effect on munmap.

Thanks,
Qi



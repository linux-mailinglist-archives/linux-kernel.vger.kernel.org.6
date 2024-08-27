Return-Path: <linux-kernel+bounces-303426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD7960BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13901B27260
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496641C0DC2;
	Tue, 27 Aug 2024 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyTufA9p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01F1A0730
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764969; cv=none; b=fhDo02/MAWd3vtNVgAZFx66s/X9DcIXN5THj9vKmo/m5Khbarhppzw3g+ALc/xzyzLl5gP+FtEKTnmJvo+IOPvbDcqsFoVeNcGVq5CoxMxhsytqm5b7uSsTaD1CBD+rq5zJbk4C4GXHKFG5bDey+9uVyPuRDPjEQc+4VU5g/04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764969; c=relaxed/simple;
	bh=7n2mp822e2TDPeB2LBLULjPCSO3eb8sztRBwmhhtzZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ut27Tnr/08VBMneV3kQocN135iLvkoAPB5JeJiDJrqVuohC49svB8QNVxF0jTfdVT5o99oqvm93P6z9W+Wg6jKtJWJf6H2AX4aRZB1/Bta6WV8htwfgZHudgQLzeIGeeMZkzcRFdivDMCRVxzh6Z4WdbnmCFfdpS2E5wy6PUp3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyTufA9p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724764966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/5mqeJ4R62VkyljIs+81ibm5inooE9WIH5UhwtZWAjU=;
	b=EyTufA9pHkXx6m0KJDv8SeLKfrw7tRsWGuUZ2Lq0QX0ELawiwa+eLcjYt29Glhc5hRpFKl
	bOn/buLIUohwT4x3PsOBES6+0EXKbWxHV8IRb1g/ws+dG8+qevRh7tQZYgsHMBV6yuS6Wi
	1tpgGeVoY5Dn1xsDXfzMmnRpWseBGhc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-fUMS5CvjMYWCHON2uIQhhQ-1; Tue, 27 Aug 2024 09:22:45 -0400
X-MC-Unique: fUMS5CvjMYWCHON2uIQhhQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-371a82ceaa7so3129407f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764964; x=1725369764;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/5mqeJ4R62VkyljIs+81ibm5inooE9WIH5UhwtZWAjU=;
        b=BuFsMPu+KC7C7buGVjJB6LliizljAYQFNFpdzcGDcOuenyfNj1NTpZGiuJKEolf4XD
         v6/AtUyHIwEfMWtpqn9hrynrHDcttrUwKux+73HcfapapHfCnms7EDEfPFfi8eXWpYeN
         jG8XE/0mZumeV9m0t7RiDZTY3wVpgPA4IcChKOjbXkkR3IxJ0lM1FSwlk2/PkQ1FQmJ9
         joEvxKjKtaqDyhI6jhW1j03Op33xFpMAYpvA7P5nfIDjMXd4vJVOBzGTCCyZYwjXzPPG
         u5vV9oa7zJ1/gBvJfjHDYze67d3Ig5CJXRsxcmUMtlhGDnRHjtJh1ojCjMTOKz3arrmQ
         HzOg==
X-Forwarded-Encrypted: i=1; AJvYcCV9kOAc6tmLuFOqAMiTQesL6utMpcCf1nX5NsLC0oLe7VxoEqjl01Bq/8eI6u+aJtU0fg7qaTxexMwagcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTF0Qz5d7wLEprzHDadZ8nMRUvAm9zQ9Mhd6gCtpmaSPHyKdlu
	Uuql6NIr0Zm9AnplkvsIA++hrw0mUxsntStc8NZgZkwEILM0K8qOoCUvshBMIis2AJYWeZPCfh4
	UsFaUq2dbiIfUCuJCrMaqAF/w7dNwFQWLrqzcHLavneYnnJhxm44nXb1Gj4EClA==
X-Received: by 2002:a5d:5c87:0:b0:371:8ec6:f2f0 with SMTP id ffacd0b85a97d-37489b323bamr2370697f8f.16.1724764964015;
        Tue, 27 Aug 2024 06:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHts2INdzBY2CP2pcIwmcHjXqw5ASFrnuI1AZZtcyzl9WC2K2w7Qs0w+n9z0dWMUcm6LlugGw==
X-Received: by 2002:a5d:5c87:0:b0:371:8ec6:f2f0 with SMTP id ffacd0b85a97d-37489b323bamr2370654f8f.16.1724764963104;
        Tue, 27 Aug 2024 06:22:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:a100:9dd2:c523:f5fd:da19? (p200300cbc742a1009dd2c523f5fdda19.dip0.t-ipconnect.de. [2003:cb:c742:a100:9dd2:c523:f5fd:da19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821a8bcsm13087001f8f.90.2024.08.27.06.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:22:42 -0700 (PDT)
Message-ID: <693a2bf0-7c18-489b-a1b4-518cf35c5aa3@redhat.com>
Date: Tue, 27 Aug 2024 15:22:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Barry Song <baohua@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, Peter Xu <peterx@redhat.com>,
 Rafael Aquini <aquini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>
References: <20240729222727.64319-1-npache@redhat.com>
 <72320F9D-9B6A-4ABA-9B18-E59B8382A262@nvidia.com>
 <CAA1CXcCD798gkLoZuz3Cd5-Wf2MRfnAG_EB0U3nbScZeFv09dw@mail.gmail.com>
 <CAA1CXcCCOS8-aqcm+w8Aoqe2P5q005wMrgmtx=xjzJgjKFb7mg@mail.gmail.com>
 <61411216-d196-42de-aa64-12bd28aef44f@gmail.com>
 <CAA1CXcCe8QDir2KiWg=GmN4BErfXSDs_9kmnYfyK=X8H8U8QwA@mail.gmail.com>
 <698ea52e-db99-4d21-9984-ad07038d4068@gmail.com>
 <20240827110959.GA438928@cmpxchg.org>
 <b73961a2-87ec-45a5-b6fb-83d3505a0f39@redhat.com>
 <20240827130544.GA460210@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240827130544.GA460210@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.08.24 15:05, Johannes Weiner wrote:
> On Tue, Aug 27, 2024 at 01:46:26PM +0200, David Hildenbrand wrote:
>> On 27.08.24 13:09, Johannes Weiner wrote:
>>> On Tue, Aug 27, 2024 at 11:37:14AM +0100, Usama Arif wrote:
>>>>
>>>>
>>>> On 26/08/2024 17:14, Nico Pache wrote:
>>>>> On Mon, Aug 26, 2024 at 10:47 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 26/08/2024 11:40, Nico Pache wrote:
>>>>>>> On Tue, Jul 30, 2024 at 4:37 PM Nico Pache <npache@redhat.com> wrote:
>>>>>>>>
>>>>>>>> Hi Zi Yan,
>>>>>>>> On Mon, Jul 29, 2024 at 7:26 PM Zi Yan <ziy@nvidia.com> wrote:
>>>>>>>>>
>>>>>>>>> +Kirill
>>>>>>>>>
>>>>>>>>> On 29 Jul 2024, at 18:27, Nico Pache wrote:
>>>>>>>>>
>>>>>>>>>> We've seen cases were customers switching from RHEL7 to RHEL8 see a
>>>>>>>>>> significant increase in the memory footprint for the same workloads.
>>>>>>>>>>
>>>>>>>>>> Through our investigations we found that a large contributing factor to
>>>>>>>>>> the increase in RSS was an increase in THP usage.
>>>>>>>>>
>>>>>>>>> Any knob is changed from RHEL7 to RHEL8 to cause more THP usage?
>>>>>>>> IIRC, most of the systems tuning is the same. We attributed the
>>>>>>>> increase in THP usage to a combination of improvements in the kernel,
>>>>>>>> and improvements in the libraries (better alignments). That allowed
>>>>>>>> THP allocations to succeed at a higher rate. I can go back and confirm
>>>>>>>> this tomorrow though.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> For workloads like MySQL, or when using allocators like jemalloc, it is
>>>>>>>>>> often recommended to set /transparent_hugepages/enabled=never. This is
>>>>>>>>>> in part due to performance degradations and increased memory waste.
>>>>>>>>>>
>>>>>>>>>> This series introduces enabled=defer, this setting acts as a middle
>>>>>>>>>> ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
>>>>>>>>>> page fault handler will act normally, making a hugepage if possible. If
>>>>>>>>>> the allocation is not MADV_HUGEPAGE, then the page fault handler will
>>>>>>>>>> default to the base size allocation. The caveat is that khugepaged can
>>>>>>>>>> still operate on pages thats not MADV_HUGEPAGE.
>>>>>>>>>
>>>>>>>>> Why? If user does not explicitly want huge page, why bother providing huge
>>>>>>>>> pages? Wouldn't it increase memory footprint?
>>>>>>>>
>>>>>>>> So we have "always", which will always try to allocate a THP when it
>>>>>>>> can. This setting gives good performance in a lot of conditions, but
>>>>>>>> tends to waste memory. Additionally applications DON'T need to be
>>>>>>>> modified to take advantage of THPs.
>>>>>>>>
>>>>>>>> We have "madvise" which will only satisfy allocations that are
>>>>>>>> MADV_HUGEPAGE, this gives you granular control, and a lot of times
>>>>>>>> these madvises come from libraries. Unlike "always" you DO need to
>>>>>>>> modify your application if you want to use THPs.
>>>>>>>>
>>>>>>>> Then we have "never", which of course, never allocates THPs.
>>>>>>>>
>>>>>>>> Ok. back to your question, like "madvise", "defer" gives you the
>>>>>>>> benefits of THPs when you specifically know you want them
>>>>>>>> (madv_hugepage), but also benefits applications that dont specifically
>>>>>>>> ask for them (or cant be modified to ask for them), like "always"
>>>>>>>> does. The applications that dont ask for THPs must wait for khugepaged
>>>>>>>> to get them (avoid insertions at PF time)-- this curbs a lot of memory
>>>>>>>> waste, and gives an increased tunability over "always". Another added
>>>>>>>> benefit is that khugepaged will most likely not operate on short lived
>>>>>>>> allocations, meaning that only longstanding memory will be collapsed
>>>>>>>> to THPs.
>>>>>>>>
>>>>>>>> The memory waste can be tuned with max_ptes_none... lets say you want
>>>>>>>> ~90% of your PMD to be full before collapsing into a huge page. simply
>>>>>>>> set max_ptes_none=64. or no waste, set max_ptes_none=0, requiring the
>>>>>>>> 512 pages to be present before being collapsed.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This allows for two things... one, applications specifically designed to
>>>>>>>>>> use hugepages will get them, and two, applications that don't use
>>>>>>>>>> hugepages can still benefit from them without aggressively inserting
>>>>>>>>>> THPs at every possible chance. This curbs the memory waste, and defers
>>>>>>>>>> the use of hugepages to khugepaged. Khugepaged can then scan the memory
>>>>>>>>>> for eligible collapsing.
>>>>>>>>>
>>>>>>>>> khugepaged would replace application memory with huge pages without specific
>>>>>>>>> goal. Why not use a user space agent with process_madvise() to collapse
>>>>>>>>> huge pages? Admin might have more knobs to tweak than khugepaged.
>>>>>>>>
>>>>>>>> The benefits of "always" are that no userspace agent is needed, and
>>>>>>>> applications dont have to be modified to use madvise(MADV_HUGEPAGE) to
>>>>>>>> benefit from THPs. This setting hopes to gain some of the same
>>>>>>>> benefits without the significant waste of memory and an increased
>>>>>>>> tunability.
>>>>>>>>
>>>>>>>> future changes I have in the works are to make khugepaged more
>>>>>>>> "smart". Moving it away from the round robin fashion it currently
>>>>>>>> operates in, to instead make smart and informed decisions of what
>>>>>>>> memory to collapse (and potentially split).
>>>>>>>>
>>>>>>>> Hopefully that helped explain the motivation for this new setting!
>>>>>>>
>>>>>>> Any last comments before I resend this?
>>>>>>>
>>>>>>> Ive been made aware of
>>>>>>> https://lore.kernel.org/all/20240730125346.1580150-1-usamaarif642@gmail.com/T/#u
>>>>>>> which introduces THP splitting. These are both trying to achieve the
>>>>>>> same thing through different means. Our approach leverages khugepaged
>>>>>>> to promote pages, while Usama's uses the reclaim path to demote
>>>>>>> hugepages and shrink the underlying memory.
>>>>>>>
>>>>>>> I will leave it up to reviewers to determine which is better; However,
>>>>>>> we can't have both, as we'd be introducing trashing conditions.
>>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Just inserting this here from my cover letter:
>>>>>>
>>>>>> Waiting for khugepaged to scan memory and
>>>>>> collapse pages into THP can be slow and unpredictable in terms of performance
>>>>> Obviously not part of my patchset here, but I have been testing some
>>>>> changes to khugepaged to make it more aware of what processes are hot.
>>>>> Ideally then it can make better choices of what to operate on.
>>>>>> (i.e. you dont know when the collapse will happen), while production
>>>>>> environments require predictable performance. If there is enough memory
>>>>>> available, its better for both performance and predictability to have
>>>>>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>>>>>> to collapse it, and deal with sparsely populated THPs when the system is
>>>>>> running out of memory.
>>>>>>
>>>>>> I just went through your patches, and am not sure why we can't have both?
>>>>> Fair point, we can. I've been playing around with splitting hugepages
>>>>> and via khugepaged and was thinking of the trashing conditions there--
>>>>> but your implementation takes a different approach.
>>>>> I've been working on performance testing my "defer" changes, once I
>>>>> find the appropriate workloads I'll try adding your changes to the
>>>>> mix. I have a feeling my approach is better for latency sensitive
>>>>> workloads, while yours is better for throughput, but let me find a way
>>>>> to confirm that.
>>>>>
>>>>>
>>>> Hmm, I am not sure if its latency vs throughput.
>>>>
>>>> There are 2 things we probably want to consider, short lived and long lived mappings, and
>>>> in each of these situations, having enough memory and running out of memory.
>>>>
>>>> For short lived mappings, I believe reducing page faults is a bigger factor in
>>>> improving performance. In that case, khugepaged won't have enough time to work,
>>>> so THP=always will perform better than THP=defer. THP=defer in this case will perform
>>>> the same as THP=madvise?
>>>> If there is enough memory, then the changes I introduced in the shrinker won't cost anything
>>>> as the shrinker won't run, and the system performance will be the same as THP=always.
>>>> If there is low memory and the shrinker runs, it will only split THPs that have zero-filled
>>>> pages more than max_ptes_none, and map the zero-filled pages to shared zero-pages saving memory.
>>>> There is ofcourse a cost to splitting and running the shrinker, but hopefully it only splits
>>>> underused THPs.
>>>>
>>>> For long lived mappings, reduced TLB misses would be the bigger factor in improving performance.
>>>> For the initial run of the application THP=always will perform better wrt TLB misses as
>>>> page fault handler will give THPs from start.
>>>> Later on in the run, the memory might look similar between THP=always with shrinker and
>>>> max_ptes_none < HPAGE_PMD_NR vs THP=defer and max_ptes_none < HPAGE_PMD_NR?
>>>> This is because khugepaged will have collapsed pages that might have initially been faulted in.
>>>> And collapsing has a cost, which would not have been incurred if the THPs were present from fault.
>>>> If there is low memory, then shrinker would split memory (which has a cost as well) and the system
>>>> memory would look similar or better than THP=defer, as the shrinker would split THPs that initially
>>>> might not have been underused, but are underused at time of memory pressure.
>>>>
>>>> With THP=always + underused shrinker, the cost (splitting) is incurred only if needed and when its needed.
>>>> While with THP=defer the cost (higher page faults, higher TLB misses + khugepaged collapse) is incurred all the time,
>>>> even if the system might have plenty of memory available and there is no need to take a performance hit.
>>>
>>> I agree with this. The defer mode is an improvement over the upstream
>>> status quo, no doubt. However, both defer mode and the shrinker solve
>>> the issue of memory waste under pressure, while the shrinker permits
>>> more desirable behavior when memory is abundant.
>>>
>>> So my take is that the shrinker is the way to go, and I don't see a
>>> bonafide usecase for defer mode that the shrinker couldn't cover.
>>
>> Page fault latency? IOW, zeroing a complete THP, which might be up to
>> 512 MiB on arm64. This is one of the things people bring up, where
>> FreeBSD is different because it will zero fragments on-demand (but also
>> result in more pagefaults).
> 
> Good point, I suppose this could matter to some workloads. Would be
> interesting to get real world data on that if that's the argument.

IIRC, there is mentioning about some of these workloads in THP 
optimization papers, where even the cost of 
defragmenation+reclaim+zeroing of 2MiB apparently affects some 
latency-sensitive workloads.

But the challenge that THP-deferred and the shrinker is trying to solve 
right now is more towards memory over-allocation, and for the the 
shrinker should *mostly* be able to do what the deferred option would 
achieve.

There are these corner cases where a workload accesses some pages and 
then long-term pins them (e.g., iouring fixed buffers), where the 
over-allcoation cannot be reclaimed until the longterm pin is gone.

But it's not been raised to be a real problem in practice, so I'm just 
mentioning it as a key difference: the shrinker runs after memory 
over-allocation with the cost of memory scanning and temporary memory 
overallcoation+zeroing. "deferred" avoids memory over-allocation, with 
the cost of more page faults + relying on khugepaged making progress.

> 
> Btw, I'm curious if anybody actually uses or tried to use 512MB
> THPs. I understand it's technically possible, and there are usecases
> for 1G pages through static hugetlb management, but 512M seems wild
> for a "real" page size - real as in: allocated on-demand and actually
> paged to/from storage.

I think it's less a matter of "using" or trying", but more THPs being 
default enabled in many setups nowadays, and if you have sufficient 
memory in the system, even these weird 512MiB THPs will up in your 
address space if a (sparse) VMA is large enough :)

-- 
Cheers,

David / dhildenb



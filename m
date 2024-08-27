Return-Path: <linux-kernel+bounces-303116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2D960799
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881151F22E46
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB419DF74;
	Tue, 27 Aug 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDqtGZfB"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41E182B2;
	Tue, 27 Aug 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755039; cv=none; b=rMypqfitRViH5asIVNAerc3q+aT0natTV2vsUxc4pzdFHB0j6RpBl7aGNJhf7HoTzSV+gaQD+inCv3Pdu+buJAmLOg9Wrpkpcmv/RQY0UF2RnykK11q5Vbgn9B2ec0QoCH2IoT0ek7dVnVg/SYs/RMpxGP+8jGHXXuZLXzuLTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755039; c=relaxed/simple;
	bh=Sh5zOuwiJMgFQhNTKJ1Z32VBAs4+GkINb/51pejICi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLSYcr/ZZAop0F+H/iJD5JVvENgOc3BSZ8DHkoQ21xYarQsfwG/keu72QI7aV0Y4cK1XTW/eWrHynu541X/v4QRIRjv5DqrxLeGlf3fy3Fxc9GnxC1nw2U2Z6QXoRTO9NNwnVWQ9dFNZsnGWeY7kc3/vDN8SGCgSyUVRZjwUb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDqtGZfB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86b64ebd8aso181158066b.1;
        Tue, 27 Aug 2024 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724755036; x=1725359836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opxiKKyLHb/4iBgZR78xm1y1usfQmQulIUgiomWf9h4=;
        b=QDqtGZfBWO6NSREe7uJYrlDKNp1W2oNIRJqZn/ODVz3jYMAH0kgdMi6S078N3o7st3
         7gzVz2ICmLw6l8D5xxRTPxwljCd4LjbZAodWBVYhXQyPrBQW9EX0LHxGAvsybeQchzoH
         SoQGkeFAKu51WdMUVLg+zC7dDY6glf4RHPnra5s3zoXdXIacQXrfToNiC0XbIZzaB/SU
         tsIsgKREjclbV8fzgM1xXBRzmvgcjWPbJb6cGgMC29H4LmpFsl1+JYjYwUm9CHCS1UMj
         WrNiFvt19kj5W8sftZAyK3+WYhdulIKuReCbTGxWNqZuKwpIDSMpdtr5pgysXmj6KPdE
         qN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724755036; x=1725359836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opxiKKyLHb/4iBgZR78xm1y1usfQmQulIUgiomWf9h4=;
        b=m3JP+4u8O2IHCLNdSRlGxHnlp9PZgHgrGNI/zHXyYClllld3rXHmDAbQXmTscXn7EY
         n0seuOBNRnK4RMakifbi9cNLgUEEkwDlxe9htMHAMEByEwjdKJN6Ar/P1JMXuuQ8tK3G
         eYGp10YVkqcI3XOBOmwH7XY5hRbB/tYEYANXnwfX9e9MCYJN+qQWubheFJ//eMcnMhOW
         P8LwzttqKVUYk10qokkNzamLmiptyOiEmsst3UMI/49TSoaOGUAiHzKxkkmC1iWGWo1O
         FwEuoyFhE1pOCjm25BpHTVasJYuuY9wArh2KLd4h/ZgCCRp10Sx2R+BxWhNtiJQVLJTh
         knrA==
X-Forwarded-Encrypted: i=1; AJvYcCVtLNGTHVlHBepKm9GhK2rB7/yiqGF6lV06MBHXhQ1d8EuS5sZwYtYWbWf4GtWpAVZ0xXqH73VfQBs=@vger.kernel.org, AJvYcCWWm4CbnXBFXI7fgNW1kMhceHUodExzm7ooMvHOwUOiWSxQweITNrnzbrxPKzbRWeZPf/WjQQGms+lYelFU@vger.kernel.org
X-Gm-Message-State: AOJu0YxLeEdItkCtZzmNXegXhRx1zh9sVzpYLGow+ZhcOqxD9aAyhLxp
	sKH0ven+ehOipjHmsqF3Jh6dEWnWM0tFHaeg7fbb83gmMdkKzyGR
X-Google-Smtp-Source: AGHT+IEku9U2U/NVvN/TQJPPO9bK+rM9uSSg8W87bouYqV08SQd5l2wz0FjQI+0r3Oxnq7iQ4i5AGw==
X-Received: by 2002:a05:6402:350b:b0:5c0:9fd0:c87a with SMTP id 4fb4d7f45d1cf-5c09fd0c8d2mr6681956a12.25.1724755035291;
        Tue, 27 Aug 2024 03:37:15 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:ea25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb47237esm847266a12.77.2024.08.27.03.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 03:37:14 -0700 (PDT)
Message-ID: <698ea52e-db99-4d21-9984-ad07038d4068@gmail.com>
Date: Tue, 27 Aug 2024 11:37:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, Peter Xu <peterx@redhat.com>,
 Rafael Aquini <aquini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>
References: <20240729222727.64319-1-npache@redhat.com>
 <72320F9D-9B6A-4ABA-9B18-E59B8382A262@nvidia.com>
 <CAA1CXcCD798gkLoZuz3Cd5-Wf2MRfnAG_EB0U3nbScZeFv09dw@mail.gmail.com>
 <CAA1CXcCCOS8-aqcm+w8Aoqe2P5q005wMrgmtx=xjzJgjKFb7mg@mail.gmail.com>
 <61411216-d196-42de-aa64-12bd28aef44f@gmail.com>
 <CAA1CXcCe8QDir2KiWg=GmN4BErfXSDs_9kmnYfyK=X8H8U8QwA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAA1CXcCe8QDir2KiWg=GmN4BErfXSDs_9kmnYfyK=X8H8U8QwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/08/2024 17:14, Nico Pache wrote:
> On Mon, Aug 26, 2024 at 10:47 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 26/08/2024 11:40, Nico Pache wrote:
>>> On Tue, Jul 30, 2024 at 4:37 PM Nico Pache <npache@redhat.com> wrote:
>>>>
>>>> Hi Zi Yan,
>>>> On Mon, Jul 29, 2024 at 7:26 PM Zi Yan <ziy@nvidia.com> wrote:
>>>>>
>>>>> +Kirill
>>>>>
>>>>> On 29 Jul 2024, at 18:27, Nico Pache wrote:
>>>>>
>>>>>> We've seen cases were customers switching from RHEL7 to RHEL8 see a
>>>>>> significant increase in the memory footprint for the same workloads.
>>>>>>
>>>>>> Through our investigations we found that a large contributing factor to
>>>>>> the increase in RSS was an increase in THP usage.
>>>>>
>>>>> Any knob is changed from RHEL7 to RHEL8 to cause more THP usage?
>>>> IIRC, most of the systems tuning is the same. We attributed the
>>>> increase in THP usage to a combination of improvements in the kernel,
>>>> and improvements in the libraries (better alignments). That allowed
>>>> THP allocations to succeed at a higher rate. I can go back and confirm
>>>> this tomorrow though.
>>>>>
>>>>>>
>>>>>> For workloads like MySQL, or when using allocators like jemalloc, it is
>>>>>> often recommended to set /transparent_hugepages/enabled=never. This is
>>>>>> in part due to performance degradations and increased memory waste.
>>>>>>
>>>>>> This series introduces enabled=defer, this setting acts as a middle
>>>>>> ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
>>>>>> page fault handler will act normally, making a hugepage if possible. If
>>>>>> the allocation is not MADV_HUGEPAGE, then the page fault handler will
>>>>>> default to the base size allocation. The caveat is that khugepaged can
>>>>>> still operate on pages thats not MADV_HUGEPAGE.
>>>>>
>>>>> Why? If user does not explicitly want huge page, why bother providing huge
>>>>> pages? Wouldn't it increase memory footprint?
>>>>
>>>> So we have "always", which will always try to allocate a THP when it
>>>> can. This setting gives good performance in a lot of conditions, but
>>>> tends to waste memory. Additionally applications DON'T need to be
>>>> modified to take advantage of THPs.
>>>>
>>>> We have "madvise" which will only satisfy allocations that are
>>>> MADV_HUGEPAGE, this gives you granular control, and a lot of times
>>>> these madvises come from libraries. Unlike "always" you DO need to
>>>> modify your application if you want to use THPs.
>>>>
>>>> Then we have "never", which of course, never allocates THPs.
>>>>
>>>> Ok. back to your question, like "madvise", "defer" gives you the
>>>> benefits of THPs when you specifically know you want them
>>>> (madv_hugepage), but also benefits applications that dont specifically
>>>> ask for them (or cant be modified to ask for them), like "always"
>>>> does. The applications that dont ask for THPs must wait for khugepaged
>>>> to get them (avoid insertions at PF time)-- this curbs a lot of memory
>>>> waste, and gives an increased tunability over "always". Another added
>>>> benefit is that khugepaged will most likely not operate on short lived
>>>> allocations, meaning that only longstanding memory will be collapsed
>>>> to THPs.
>>>>
>>>> The memory waste can be tuned with max_ptes_none... lets say you want
>>>> ~90% of your PMD to be full before collapsing into a huge page. simply
>>>> set max_ptes_none=64. or no waste, set max_ptes_none=0, requiring the
>>>> 512 pages to be present before being collapsed.
>>>>
>>>>>
>>>>>>
>>>>>> This allows for two things... one, applications specifically designed to
>>>>>> use hugepages will get them, and two, applications that don't use
>>>>>> hugepages can still benefit from them without aggressively inserting
>>>>>> THPs at every possible chance. This curbs the memory waste, and defers
>>>>>> the use of hugepages to khugepaged. Khugepaged can then scan the memory
>>>>>> for eligible collapsing.
>>>>>
>>>>> khugepaged would replace application memory with huge pages without specific
>>>>> goal. Why not use a user space agent with process_madvise() to collapse
>>>>> huge pages? Admin might have more knobs to tweak than khugepaged.
>>>>
>>>> The benefits of "always" are that no userspace agent is needed, and
>>>> applications dont have to be modified to use madvise(MADV_HUGEPAGE) to
>>>> benefit from THPs. This setting hopes to gain some of the same
>>>> benefits without the significant waste of memory and an increased
>>>> tunability.
>>>>
>>>> future changes I have in the works are to make khugepaged more
>>>> "smart". Moving it away from the round robin fashion it currently
>>>> operates in, to instead make smart and informed decisions of what
>>>> memory to collapse (and potentially split).
>>>>
>>>> Hopefully that helped explain the motivation for this new setting!
>>>
>>> Any last comments before I resend this?
>>>
>>> Ive been made aware of
>>> https://lore.kernel.org/all/20240730125346.1580150-1-usamaarif642@gmail.com/T/#u
>>> which introduces THP splitting. These are both trying to achieve the
>>> same thing through different means. Our approach leverages khugepaged
>>> to promote pages, while Usama's uses the reclaim path to demote
>>> hugepages and shrink the underlying memory.
>>>
>>> I will leave it up to reviewers to determine which is better; However,
>>> we can't have both, as we'd be introducing trashing conditions.
>>>
>>
>> Hi,
>>
>> Just inserting this here from my cover letter:
>>
>> Waiting for khugepaged to scan memory and
>> collapse pages into THP can be slow and unpredictable in terms of performance
> Obviously not part of my patchset here, but I have been testing some
> changes to khugepaged to make it more aware of what processes are hot.
> Ideally then it can make better choices of what to operate on.
>> (i.e. you dont know when the collapse will happen), while production
>> environments require predictable performance. If there is enough memory
>> available, its better for both performance and predictability to have
>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>> to collapse it, and deal with sparsely populated THPs when the system is
>> running out of memory.
>>
>> I just went through your patches, and am not sure why we can't have both?
> Fair point, we can. I've been playing around with splitting hugepages
> and via khugepaged and was thinking of the trashing conditions there--
> but your implementation takes a different approach.
> I've been working on performance testing my "defer" changes, once I
> find the appropriate workloads I'll try adding your changes to the
> mix. I have a feeling my approach is better for latency sensitive
> workloads, while yours is better for throughput, but let me find a way
> to confirm that.
> 
> 
Hmm, I am not sure if its latency vs throughput.

There are 2 things we probably want to consider, short lived and long lived mappings, and
in each of these situations, having enough memory and running out of memory.

For short lived mappings, I believe reducing page faults is a bigger factor in
improving performance. In that case, khugepaged won't have enough time to work,
so THP=always will perform better than THP=defer. THP=defer in this case will perform
the same as THP=madvise?
If there is enough memory, then the changes I introduced in the shrinker won't cost anything
as the shrinker won't run, and the system performance will be the same as THP=always.
If there is low memory and the shrinker runs, it will only split THPs that have zero-filled
pages more than max_ptes_none, and map the zero-filled pages to shared zero-pages saving memory.
There is ofcourse a cost to splitting and running the shrinker, but hopefully it only splits
underused THPs.

For long lived mappings, reduced TLB misses would be the bigger factor in improving performance.
For the initial run of the application THP=always will perform better wrt TLB misses as
page fault handler will give THPs from start.
Later on in the run, the memory might look similar between THP=always with shrinker and
max_ptes_none < HPAGE_PMD_NR vs THP=defer and max_ptes_none < HPAGE_PMD_NR?
This is because khugepaged will have collapsed pages that might have initially been faulted in.
And collapsing has a cost, which would not have been incurred if the THPs were present from fault.
If there is low memory, then shrinker would split memory (which has a cost as well) and the system
memory would look similar or better than THP=defer, as the shrinker would split THPs that initially
might not have been underused, but are underused at time of memory pressure.

With THP=always + underused shrinker, the cost (splitting) is incurred only if needed and when its needed.
While with THP=defer the cost (higher page faults, higher TLB misses + khugepaged collapse) is incurred all the time,
even if the system might have plenty of memory available and there is no need to take a performance hit.

> 
> 
> 
>> Both use max_ptes_none as the tunable. If the number of zero-filled pages
>> is above max_ptes_none, the shrinker will split them, and khugepaged will not collapse
>> them (SCAN_EXCEED_NONE_PTE), so I don't see how it causes trashing?
>>
>>
>>> Cheers,
>>> -- Nico
>>>
>>>
>>>
>>>
>>>
>>>>
>>>> Cheer!
>>>> -- Nico
>>>>>
>>>>>>
>>>>>> Admins may want to lower max_ptes_none, if not, khugepaged may
>>>>>> aggressively collapse single allocations into hugepages.
>>>>>>
>>>>>> RFC note
>>>>>> ==========
>>>>>> Im not sure if im missing anything related to the mTHP
>>>>>> changes. I think now that we have hugepage_pmd_enabled in
>>>>>> commit 00f58104202c ("mm: fix khugepaged activation policy") everything
>>>>>> should work as expected.
>>>>>>
>>>>>> Nico Pache (2):
>>>>>>   mm: defer THP insertion to khugepaged
>>>>>>   mm: document transparent_hugepage=defer usage
>>>>>>
>>>>>>  Documentation/admin-guide/mm/transhuge.rst | 18 ++++++++++---
>>>>>>  include/linux/huge_mm.h                    | 15 +++++++++--
>>>>>>  mm/huge_memory.c                           | 31 +++++++++++++++++++---
>>>>>>  3 files changed, 55 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> Cc: Lance Yang <ioworker0@gmail.com>
>>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>> Cc: Rafael Aquini <aquini@redhat.com>
>>>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>>> --
>>>>>> 2.45.2
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>> Yan, Zi
>>>
>>
> 



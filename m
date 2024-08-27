Return-Path: <linux-kernel+bounces-303486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D9960CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0011C23203
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799CB1C3F19;
	Tue, 27 Aug 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA7wTGka"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB01C4619;
	Tue, 27 Aug 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767051; cv=none; b=h1VtFMfE+eA6b5jtkXrOwWfxrL02gCIF6y2vpyLvsNM4N0pK2eziOxa6x4HoJmBPGd+gx166x872z3rx5byg71/IC7k1vHeyL6WabC0TgaC+wyaJwieT9FNzT9XNpQSKvqnf2d9w12OMMEFZ8g6oy0tCDiU4u3aMMGtNrWpMFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767051; c=relaxed/simple;
	bh=5kCIQRNCrTFbwfxmSCIvIxA5TptRrfrD7ByglREyBpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIr2eZAB0YHKPUkq8EwKix6OVloZXflyt3Q0nb+eoi9NRKTrKGV09i+7HwnMSM1k2o8BI5OjjgeZoU5qkdHDc3yRf0TCQeRm6O3I25DzUpSLT1guBageu08PZGWdt+v0o8jO8ng/jMKHcxUeWboyZGHDKifukRVn+fzNcE7rBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA7wTGka; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8696e9bd24so585951066b.0;
        Tue, 27 Aug 2024 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724767047; x=1725371847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IM5tv1HAnGH0ypMsSbs2fmsVIoy7QBJi9O3AKInEEw=;
        b=CA7wTGkatoklqOMQFGcKzy3+YKJMPj4Rp/7RSYX9mtT8i1N/nbo1pbhWnDjBDMsi0d
         d7rniA1myiA0K/m5jvYDsZPumTWVlcBwq4hEK3ZHW54NjSLMfsO7FpAmmjeFmDUIIrxQ
         Gm1xhMi9QxgMkE7IbLCuZbMuDmserw76sWv/lLXFkzQC67HND/i0J5MNjlEloVz7IMFU
         wKef2KtDdsxaUwptBoVIB6U8BwdU4xAkailfyS1s5xknS6/UmBUdQIr1s3XeBOq0/JTH
         0CVs9r0JxWzSuRkdxJPQEx6OXTLGoTe+JO8Ydl/SP6pqnXbK14/+7cn/xLTBbSoyVBwS
         BS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767047; x=1725371847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IM5tv1HAnGH0ypMsSbs2fmsVIoy7QBJi9O3AKInEEw=;
        b=BIYBTKo1przS8QogQvKVpS32xfvJC/QV7WVxXuYrk/hgimhEK2fe5SWJ/VcXLTapYq
         BS1vP8jIXOqKBHjbkf/KbiRFzMhd1YZNzEDhhTUiH601NXZ6c7KgJVTDz7NCUNcRK20B
         mhrhtha1ShTJGxh//CC6OXmdpwzaH5fkzmi40avh3i64J8vOryAZhGwabUAALtbwdNz6
         Ac4OaFdhb4sUapWpMBncrPwZkqjgnNPc/dDyTmzFR2KWoB29ktzd3atbP3+usTSV2E1D
         Gs3ToHa2lE/PsGhbgtDzOy0ONmE9FkbbqgWQnbNOIsVm2wxax4gMMRDvtXcPd1Ic1Iuq
         lhfg==
X-Forwarded-Encrypted: i=1; AJvYcCVL9MkwieKirr0cdh8KEH7azHYXYOHdoXUNeMbRTlVHCfYJPS4pnTNqZLUn3Xlj8S1M0xjdwUnbnxcqLpA1@vger.kernel.org, AJvYcCXCW2/tfjDprbF0/uOQls9LZAbhQ9JD7KTEricF3d7TGPysiK6YwiFsE9k2y53SFlAwUw/480ldMJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6FG+I6Vf7u1TkfD7SMZo4wOYk9ptNjFsWYgSdwtaLx7b00D5
	+uWmxodCAlAbfj8DOg4R2mvoFnjz/a1vc4fLyDkSrH4r5m0/ET9s
X-Google-Smtp-Source: AGHT+IFm6Wfd8daqNxAaTp3xcwW9Xlv4VShtDa76THElt4pF49hklwH4an7tyrtEt3PMJls2V1OWoQ==
X-Received: by 2002:a17:907:ea0:b0:a86:8524:2558 with SMTP id a640c23a62f3a-a86e397f58cmr282815766b.12.1724767046489;
        Tue, 27 Aug 2024 06:57:26 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:ea25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549ce94sm113189666b.78.2024.08.27.06.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:57:26 -0700 (PDT)
Message-ID: <88b379f1-ad09-4fe5-b7a4-81fbf9d934b1@gmail.com>
Date: Tue, 27 Aug 2024 14:57:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
To: David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
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
 <693a2bf0-7c18-489b-a1b4-518cf35c5aa3@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <693a2bf0-7c18-489b-a1b4-518cf35c5aa3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/08/2024 09:22, David Hildenbrand wrote:
> On 27.08.24 15:05, Johannes Weiner wrote:
>> On Tue, Aug 27, 2024 at 01:46:26PM +0200, David Hildenbrand wrote:
>>> On 27.08.24 13:09, Johannes Weiner wrote:
>>>> On Tue, Aug 27, 2024 at 11:37:14AM +0100, Usama Arif wrote:
>>>>>
>>>>>
>>>>> On 26/08/2024 17:14, Nico Pache wrote:
>>>>>> On Mon, Aug 26, 2024 at 10:47 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 26/08/2024 11:40, Nico Pache wrote:
>>>>>>>> On Tue, Jul 30, 2024 at 4:37 PM Nico Pache <npache@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Zi Yan,
>>>>>>>>> On Mon, Jul 29, 2024 at 7:26 PM Zi Yan <ziy@nvidia.com> wrote:
>>>>>>>>>>
>>>>>>>>>> +Kirill
>>>>>>>>>>
>>>>>>>>>> On 29 Jul 2024, at 18:27, Nico Pache wrote:
>>>>>>>>>>
>>>>>>>>>>> We've seen cases were customers switching from RHEL7 to RHEL8 see a
>>>>>>>>>>> significant increase in the memory footprint for the same workloads.
>>>>>>>>>>>
>>>>>>>>>>> Through our investigations we found that a large contributing factor to
>>>>>>>>>>> the increase in RSS was an increase in THP usage.
>>>>>>>>>>
>>>>>>>>>> Any knob is changed from RHEL7 to RHEL8 to cause more THP usage?
>>>>>>>>> IIRC, most of the systems tuning is the same. We attributed the
>>>>>>>>> increase in THP usage to a combination of improvements in the kernel,
>>>>>>>>> and improvements in the libraries (better alignments). That allowed
>>>>>>>>> THP allocations to succeed at a higher rate. I can go back and confirm
>>>>>>>>> this tomorrow though.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> For workloads like MySQL, or when using allocators like jemalloc, it is
>>>>>>>>>>> often recommended to set /transparent_hugepages/enabled=never. This is
>>>>>>>>>>> in part due to performance degradations and increased memory waste.
>>>>>>>>>>>
>>>>>>>>>>> This series introduces enabled=defer, this setting acts as a middle
>>>>>>>>>>> ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
>>>>>>>>>>> page fault handler will act normally, making a hugepage if possible. If
>>>>>>>>>>> the allocation is not MADV_HUGEPAGE, then the page fault handler will
>>>>>>>>>>> default to the base size allocation. The caveat is that khugepaged can
>>>>>>>>>>> still operate on pages thats not MADV_HUGEPAGE.
>>>>>>>>>>
>>>>>>>>>> Why? If user does not explicitly want huge page, why bother providing huge
>>>>>>>>>> pages? Wouldn't it increase memory footprint?
>>>>>>>>>
>>>>>>>>> So we have "always", which will always try to allocate a THP when it
>>>>>>>>> can. This setting gives good performance in a lot of conditions, but
>>>>>>>>> tends to waste memory. Additionally applications DON'T need to be
>>>>>>>>> modified to take advantage of THPs.
>>>>>>>>>
>>>>>>>>> We have "madvise" which will only satisfy allocations that are
>>>>>>>>> MADV_HUGEPAGE, this gives you granular control, and a lot of times
>>>>>>>>> these madvises come from libraries. Unlike "always" you DO need to
>>>>>>>>> modify your application if you want to use THPs.
>>>>>>>>>
>>>>>>>>> Then we have "never", which of course, never allocates THPs.
>>>>>>>>>
>>>>>>>>> Ok. back to your question, like "madvise", "defer" gives you the
>>>>>>>>> benefits of THPs when you specifically know you want them
>>>>>>>>> (madv_hugepage), but also benefits applications that dont specifically
>>>>>>>>> ask for them (or cant be modified to ask for them), like "always"
>>>>>>>>> does. The applications that dont ask for THPs must wait for khugepaged
>>>>>>>>> to get them (avoid insertions at PF time)-- this curbs a lot of memory
>>>>>>>>> waste, and gives an increased tunability over "always". Another added
>>>>>>>>> benefit is that khugepaged will most likely not operate on short lived
>>>>>>>>> allocations, meaning that only longstanding memory will be collapsed
>>>>>>>>> to THPs.
>>>>>>>>>
>>>>>>>>> The memory waste can be tuned with max_ptes_none... lets say you want
>>>>>>>>> ~90% of your PMD to be full before collapsing into a huge page. simply
>>>>>>>>> set max_ptes_none=64. or no waste, set max_ptes_none=0, requiring the
>>>>>>>>> 512 pages to be present before being collapsed.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> This allows for two things... one, applications specifically designed to
>>>>>>>>>>> use hugepages will get them, and two, applications that don't use
>>>>>>>>>>> hugepages can still benefit from them without aggressively inserting
>>>>>>>>>>> THPs at every possible chance. This curbs the memory waste, and defers
>>>>>>>>>>> the use of hugepages to khugepaged. Khugepaged can then scan the memory
>>>>>>>>>>> for eligible collapsing.
>>>>>>>>>>
>>>>>>>>>> khugepaged would replace application memory with huge pages without specific
>>>>>>>>>> goal. Why not use a user space agent with process_madvise() to collapse
>>>>>>>>>> huge pages? Admin might have more knobs to tweak than khugepaged.
>>>>>>>>>
>>>>>>>>> The benefits of "always" are that no userspace agent is needed, and
>>>>>>>>> applications dont have to be modified to use madvise(MADV_HUGEPAGE) to
>>>>>>>>> benefit from THPs. This setting hopes to gain some of the same
>>>>>>>>> benefits without the significant waste of memory and an increased
>>>>>>>>> tunability.
>>>>>>>>>
>>>>>>>>> future changes I have in the works are to make khugepaged more
>>>>>>>>> "smart". Moving it away from the round robin fashion it currently
>>>>>>>>> operates in, to instead make smart and informed decisions of what
>>>>>>>>> memory to collapse (and potentially split).
>>>>>>>>>
>>>>>>>>> Hopefully that helped explain the motivation for this new setting!
>>>>>>>>
>>>>>>>> Any last comments before I resend this?
>>>>>>>>
>>>>>>>> Ive been made aware of
>>>>>>>> https://lore.kernel.org/all/20240730125346.1580150-1-usamaarif642@gmail.com/T/#u
>>>>>>>> which introduces THP splitting. These are both trying to achieve the
>>>>>>>> same thing through different means. Our approach leverages khugepaged
>>>>>>>> to promote pages, while Usama's uses the reclaim path to demote
>>>>>>>> hugepages and shrink the underlying memory.
>>>>>>>>
>>>>>>>> I will leave it up to reviewers to determine which is better; However,
>>>>>>>> we can't have both, as we'd be introducing trashing conditions.
>>>>>>>>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Just inserting this here from my cover letter:
>>>>>>>
>>>>>>> Waiting for khugepaged to scan memory and
>>>>>>> collapse pages into THP can be slow and unpredictable in terms of performance
>>>>>> Obviously not part of my patchset here, but I have been testing some
>>>>>> changes to khugepaged to make it more aware of what processes are hot.
>>>>>> Ideally then it can make better choices of what to operate on.
>>>>>>> (i.e. you dont know when the collapse will happen), while production
>>>>>>> environments require predictable performance. If there is enough memory
>>>>>>> available, its better for both performance and predictability to have
>>>>>>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>>>>>>> to collapse it, and deal with sparsely populated THPs when the system is
>>>>>>> running out of memory.
>>>>>>>
>>>>>>> I just went through your patches, and am not sure why we can't have both?
>>>>>> Fair point, we can. I've been playing around with splitting hugepages
>>>>>> and via khugepaged and was thinking of the trashing conditions there--
>>>>>> but your implementation takes a different approach.
>>>>>> I've been working on performance testing my "defer" changes, once I
>>>>>> find the appropriate workloads I'll try adding your changes to the
>>>>>> mix. I have a feeling my approach is better for latency sensitive
>>>>>> workloads, while yours is better for throughput, but let me find a way
>>>>>> to confirm that.
>>>>>>
>>>>>>
>>>>> Hmm, I am not sure if its latency vs throughput.
>>>>>
>>>>> There are 2 things we probably want to consider, short lived and long lived mappings, and
>>>>> in each of these situations, having enough memory and running out of memory.
>>>>>
>>>>> For short lived mappings, I believe reducing page faults is a bigger factor in
>>>>> improving performance. In that case, khugepaged won't have enough time to work,
>>>>> so THP=always will perform better than THP=defer. THP=defer in this case will perform
>>>>> the same as THP=madvise?
>>>>> If there is enough memory, then the changes I introduced in the shrinker won't cost anything
>>>>> as the shrinker won't run, and the system performance will be the same as THP=always.
>>>>> If there is low memory and the shrinker runs, it will only split THPs that have zero-filled
>>>>> pages more than max_ptes_none, and map the zero-filled pages to shared zero-pages saving memory.
>>>>> There is ofcourse a cost to splitting and running the shrinker, but hopefully it only splits
>>>>> underused THPs.
>>>>>
>>>>> For long lived mappings, reduced TLB misses would be the bigger factor in improving performance.
>>>>> For the initial run of the application THP=always will perform better wrt TLB misses as
>>>>> page fault handler will give THPs from start.
>>>>> Later on in the run, the memory might look similar between THP=always with shrinker and
>>>>> max_ptes_none < HPAGE_PMD_NR vs THP=defer and max_ptes_none < HPAGE_PMD_NR?
>>>>> This is because khugepaged will have collapsed pages that might have initially been faulted in.
>>>>> And collapsing has a cost, which would not have been incurred if the THPs were present from fault.
>>>>> If there is low memory, then shrinker would split memory (which has a cost as well) and the system
>>>>> memory would look similar or better than THP=defer, as the shrinker would split THPs that initially
>>>>> might not have been underused, but are underused at time of memory pressure.
>>>>>
>>>>> With THP=always + underused shrinker, the cost (splitting) is incurred only if needed and when its needed.
>>>>> While with THP=defer the cost (higher page faults, higher TLB misses + khugepaged collapse) is incurred all the time,
>>>>> even if the system might have plenty of memory available and there is no need to take a performance hit.
>>>>
>>>> I agree with this. The defer mode is an improvement over the upstream
>>>> status quo, no doubt. However, both defer mode and the shrinker solve
>>>> the issue of memory waste under pressure, while the shrinker permits
>>>> more desirable behavior when memory is abundant.
>>>>
>>>> So my take is that the shrinker is the way to go, and I don't see a
>>>> bonafide usecase for defer mode that the shrinker couldn't cover.
>>>
>>> Page fault latency? IOW, zeroing a complete THP, which might be up to
>>> 512 MiB on arm64. This is one of the things people bring up, where
>>> FreeBSD is different because it will zero fragments on-demand (but also
>>> result in more pagefaults).
>>
>> Good point, I suppose this could matter to some workloads. Would be
>> interesting to get real world data on that if that's the argument.
> 
> IIRC, there is mentioning about some of these workloads in THP optimization papers, where even the cost of defragmenation+reclaim+zeroing of 2MiB apparently affects some latency-sensitive workloads.
> 
> But the challenge that THP-deferred and the shrinker is trying to solve right now is more towards memory over-allocation, and for the the shrinker should *mostly* be able to do what the deferred option would achieve.
> 

I would say underused shrinker is trying to solve memory over-allocation due to THP=always *while* trying to preserve the performance benefits of THP=always,
which THP=defer might not achieve with the same performance due to more running costs?

> There are these corner cases where a workload accesses some pages and then long-term pins them (e.g., iouring fixed buffers), where the over-allcoation cannot be reclaimed until the longterm pin is gone.
> 
> But it's not been raised to be a real problem in practice, so I'm just mentioning it as a key difference: the shrinker runs after memory over-allocation with the cost of memory scanning and temporary memory overallcoation+zeroing. "deferred" avoids memory over-allocation, with the cost of more page faults + relying on khugepaged making progress.
> 
and the deferred option also has the cost of higher TLB misses (which can be quite significant) when the pages haven't collapsed yet,
and all of these are costs that shouldn't even be incurred if the system has plenty of memory.

If there aren't many underused pages, then for long-term mappings, the memory would look similar in both cases after sometime?
as khugepaged would just collapse pages that would just have been there from page fault in THP=always (especially if khugepaged
is made more affective). In that case, the shrinker solution would have had no cost for that time (or maybe just page fault
latency?), while THP=defer would incur all the 3 costs?

Both solutions do have their pros and cons and I am not against having THP=defer. But I do feel the shrinker is a better solution
with the experiments in Meta production [1] and only having to incur a cost if and when needed. I could be biased as well :) 

[1] https://lore.kernel.org/all/20240819023145.2415299-1-usamaarif642@gmail.com/#t

>>
>> Btw, I'm curious if anybody actually uses or tried to use 512MB
>> THPs. I understand it's technically possible, and there are usecases
>> for 1G pages through static hugetlb management, but 512M seems wild
>> for a "real" page size - real as in: allocated on-demand and actually
>> paged to/from storage.
> 
> I think it's less a matter of "using" or trying", but more THPs being default enabled in many setups nowadays, and if you have sufficient memory in the system, even these weird 512MiB THPs will up in your address space if a (sparse) VMA is large enough :)
> 

The page fault latency is a good point for ARM servers. I would imagine more ARM servers run with 64K page size compared to 4K, and if the default config option for THP is not changed, then we could run into 512M THPs!




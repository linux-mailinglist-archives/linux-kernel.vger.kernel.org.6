Return-Path: <linux-kernel+bounces-301899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9295F706
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1901F22CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629D2197A8B;
	Mon, 26 Aug 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko22VsWg"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFD5F873;
	Mon, 26 Aug 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690850; cv=none; b=J9/snlHwxl/l2kMWRLZzOFPAmLf/xWx/sh2KSF+54/1qQe8uB9E3g/vhNRlJtTsbdMzFoZlMLcz9Y0XvVb8FnBRmS253c7iWKUe+vlQgNpsE2Auc2//NlJrT0Ao8nTuTNRhr7n8AhJ6P4UM8QB428H/rpF7521tRKzy0jm+cOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690850; c=relaxed/simple;
	bh=1S7H2ZKpr97e45EbhSMdMR7X/7KfyCzA0o0Hzjc2xLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sb/4jUXoWTpOUZBkZz64xcjQZEaGUmAZYDAvilaE2n5juXLaSBhvIt2/NbPmdgDb9P1UV6K+qnyJKDSWnc6im67fY09SRYFmgxBrpSyPExj4vPnJxpPLWYmRPRKMVxSBGWBqnO6N7/Q9HS13j6ShQJ4XsAz4/hXEXtbj98bkO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko22VsWg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37196229343so2852737f8f.0;
        Mon, 26 Aug 2024 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690847; x=1725295647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKbf1ohA+1o/gWoQsuuL4/aWJwZFQVs/5SqMRPbJMT0=;
        b=ko22VsWgJModv7ELb/ivOqF3qtYEt2pMm02QqDQ9wtOi1S50tBywt3JiqtnLdH2xc2
         3Iew5ULMqdQARNEVo4lGpSmId7D8lSG8Ik4do+xyGiZlzV57Ihys4Sx3bHi/9dekfE39
         RgA5F0IXHB74DqidtejScjhGxlcLKhiJ0NjyxjYRwgKMQTRMkKArlKeJDr/EKUHCDKXc
         5s0DSIDwrkAs9B4dcv44yokQ0ahyQsWHhD3M5oftdyn+Lz37yF6q6TmgNeoKQi+EcM6y
         51x911PsH/fJXDd+zzEA25oNvSZOkO9T/+Co6bDG7TqNZGMov9fhc7iauCt8cTy92sZw
         D1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690847; x=1725295647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKbf1ohA+1o/gWoQsuuL4/aWJwZFQVs/5SqMRPbJMT0=;
        b=wOJWqdw+DVUzgd4k+C2V1nmrV91OZTh7SEO/pxYqWj6jS+r8/PH5ztKjCN74i8l26v
         cJou3AyNvrGX1JB1iJpX9FriwjkwIEbRFEHoNudnrLjIE7raKr9oR/S1sB7xrdJKtaun
         2uqKU+1ZzfnnEUBz8paDlKmnJwDAc+EYsL/bgXelrKyufPX8/m0sCNUsQOeu9ldfexeY
         DR1KvXnxkjXHbC9QuwqVgFEre7EizJiEQajRmOEa6QGyYf7sWFd25VsEWl/IT7cUy1ca
         l4CNDqgAQjqPmut6TGZY4Db4RN/aSPujd2Uxr+dMzBKhJkxbPbiTS1Iglb/1ZlwK90MN
         dDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGUDze7tDri6lSQzmzeHRLB8lVEUaaXrY0Qei3VHgC7WzTqdMKfks5o897wIwGVZethiL/YDvGLHkL7iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qwFDOk+i6+SNxVnhyyfpq/LGSJAfilpNERTStm8WHHEY3hwL
	1bwTvI44R5Mi8Vs5iZhiAx/5Z7ab2XJeXN1BVlBgIHEUhCfZ3Cnt
X-Google-Smtp-Source: AGHT+IHAHeB2IEbfkzBBPlNMahcqSaE8JIZRCZCEI0JWJ3AQHKPZ12JgsS5s1AgfAXtyLp4jFwvknA==
X-Received: by 2002:a5d:410a:0:b0:36c:ff0c:36d7 with SMTP id ffacd0b85a97d-373118580b7mr7217598f8f.2.1724690845950;
        Mon, 26 Aug 2024 09:47:25 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220d16sm687261366b.22.2024.08.26.09.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:47:25 -0700 (PDT)
Message-ID: <61411216-d196-42de-aa64-12bd28aef44f@gmail.com>
Date: Mon, 26 Aug 2024 17:47:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAA1CXcCCOS8-aqcm+w8Aoqe2P5q005wMrgmtx=xjzJgjKFb7mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/08/2024 11:40, Nico Pache wrote:
> On Tue, Jul 30, 2024 at 4:37 PM Nico Pache <npache@redhat.com> wrote:
>>
>> Hi Zi Yan,
>> On Mon, Jul 29, 2024 at 7:26 PM Zi Yan <ziy@nvidia.com> wrote:
>>>
>>> +Kirill
>>>
>>> On 29 Jul 2024, at 18:27, Nico Pache wrote:
>>>
>>>> We've seen cases were customers switching from RHEL7 to RHEL8 see a
>>>> significant increase in the memory footprint for the same workloads.
>>>>
>>>> Through our investigations we found that a large contributing factor to
>>>> the increase in RSS was an increase in THP usage.
>>>
>>> Any knob is changed from RHEL7 to RHEL8 to cause more THP usage?
>> IIRC, most of the systems tuning is the same. We attributed the
>> increase in THP usage to a combination of improvements in the kernel,
>> and improvements in the libraries (better alignments). That allowed
>> THP allocations to succeed at a higher rate. I can go back and confirm
>> this tomorrow though.
>>>
>>>>
>>>> For workloads like MySQL, or when using allocators like jemalloc, it is
>>>> often recommended to set /transparent_hugepages/enabled=never. This is
>>>> in part due to performance degradations and increased memory waste.
>>>>
>>>> This series introduces enabled=defer, this setting acts as a middle
>>>> ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
>>>> page fault handler will act normally, making a hugepage if possible. If
>>>> the allocation is not MADV_HUGEPAGE, then the page fault handler will
>>>> default to the base size allocation. The caveat is that khugepaged can
>>>> still operate on pages thats not MADV_HUGEPAGE.
>>>
>>> Why? If user does not explicitly want huge page, why bother providing huge
>>> pages? Wouldn't it increase memory footprint?
>>
>> So we have "always", which will always try to allocate a THP when it
>> can. This setting gives good performance in a lot of conditions, but
>> tends to waste memory. Additionally applications DON'T need to be
>> modified to take advantage of THPs.
>>
>> We have "madvise" which will only satisfy allocations that are
>> MADV_HUGEPAGE, this gives you granular control, and a lot of times
>> these madvises come from libraries. Unlike "always" you DO need to
>> modify your application if you want to use THPs.
>>
>> Then we have "never", which of course, never allocates THPs.
>>
>> Ok. back to your question, like "madvise", "defer" gives you the
>> benefits of THPs when you specifically know you want them
>> (madv_hugepage), but also benefits applications that dont specifically
>> ask for them (or cant be modified to ask for them), like "always"
>> does. The applications that dont ask for THPs must wait for khugepaged
>> to get them (avoid insertions at PF time)-- this curbs a lot of memory
>> waste, and gives an increased tunability over "always". Another added
>> benefit is that khugepaged will most likely not operate on short lived
>> allocations, meaning that only longstanding memory will be collapsed
>> to THPs.
>>
>> The memory waste can be tuned with max_ptes_none... lets say you want
>> ~90% of your PMD to be full before collapsing into a huge page. simply
>> set max_ptes_none=64. or no waste, set max_ptes_none=0, requiring the
>> 512 pages to be present before being collapsed.
>>
>>>
>>>>
>>>> This allows for two things... one, applications specifically designed to
>>>> use hugepages will get them, and two, applications that don't use
>>>> hugepages can still benefit from them without aggressively inserting
>>>> THPs at every possible chance. This curbs the memory waste, and defers
>>>> the use of hugepages to khugepaged. Khugepaged can then scan the memory
>>>> for eligible collapsing.
>>>
>>> khugepaged would replace application memory with huge pages without specific
>>> goal. Why not use a user space agent with process_madvise() to collapse
>>> huge pages? Admin might have more knobs to tweak than khugepaged.
>>
>> The benefits of "always" are that no userspace agent is needed, and
>> applications dont have to be modified to use madvise(MADV_HUGEPAGE) to
>> benefit from THPs. This setting hopes to gain some of the same
>> benefits without the significant waste of memory and an increased
>> tunability.
>>
>> future changes I have in the works are to make khugepaged more
>> "smart". Moving it away from the round robin fashion it currently
>> operates in, to instead make smart and informed decisions of what
>> memory to collapse (and potentially split).
>>
>> Hopefully that helped explain the motivation for this new setting!
> 
> Any last comments before I resend this?
> 
> Ive been made aware of
> https://lore.kernel.org/all/20240730125346.1580150-1-usamaarif642@gmail.com/T/#u
> which introduces THP splitting. These are both trying to achieve the
> same thing through different means. Our approach leverages khugepaged
> to promote pages, while Usama's uses the reclaim path to demote
> hugepages and shrink the underlying memory.
> 
> I will leave it up to reviewers to determine which is better; However,
> we can't have both, as we'd be introducing trashing conditions.
> 

Hi,

Just inserting this here from my cover letter:

Waiting for khugepaged to scan memory and
collapse pages into THP can be slow and unpredictable in terms of performance
(i.e. you dont know when the collapse will happen), while production
environments require predictable performance. If there is enough memory
available, its better for both performance and predictability to have
a THP from fault time, i.e. THP=always rather than wait for khugepaged
to collapse it, and deal with sparsely populated THPs when the system is
running out of memory.

I just went through your patches, and am not sure why we can't have both?
Both use max_ptes_none as the tunable. If the number of zero-filled pages
is above max_ptes_none, the shrinker will split them, and khugepaged will not collapse
them (SCAN_EXCEED_NONE_PTE), so I don't see how it causes trashing?


> Cheers,
> -- Nico
> 
> 
> 
> 
> 
>>
>> Cheer!
>> -- Nico
>>>
>>>>
>>>> Admins may want to lower max_ptes_none, if not, khugepaged may
>>>> aggressively collapse single allocations into hugepages.
>>>>
>>>> RFC note
>>>> ==========
>>>> Im not sure if im missing anything related to the mTHP
>>>> changes. I think now that we have hugepage_pmd_enabled in
>>>> commit 00f58104202c ("mm: fix khugepaged activation policy") everything
>>>> should work as expected.
>>>>
>>>> Nico Pache (2):
>>>>   mm: defer THP insertion to khugepaged
>>>>   mm: document transparent_hugepage=defer usage
>>>>
>>>>  Documentation/admin-guide/mm/transhuge.rst | 18 ++++++++++---
>>>>  include/linux/huge_mm.h                    | 15 +++++++++--
>>>>  mm/huge_memory.c                           | 31 +++++++++++++++++++---
>>>>  3 files changed, 55 insertions(+), 9 deletions(-)
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Barry Song <baohua@kernel.org>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: Lance Yang <ioworker0@gmail.com>
>>>> Cc: Peter Xu <peterx@redhat.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Rafael Aquini <aquini@redhat.com>
>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> --
>>>> 2.45.2
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
> 



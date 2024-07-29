Return-Path: <linux-kernel+bounces-265144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31F93ED4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D1AB20E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B35824BF;
	Mon, 29 Jul 2024 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JQj8X99I"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26EF78C8E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233975; cv=none; b=BG11xpMhfUMnyAddjxTlK67bBMsFOI2gZHLuLeR0KHIil+XArTqX3vADTEDMwMF1mbKhPijb5PnLnTNbve7nzoLvqR5RJ2E8IoPYJeMZdTO2PiIdfIU8ugfBIxqeBP9VrfBd0MXmDrKqNFPrxA7qR3tycl1aK5PrZVlCKTMHQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233975; c=relaxed/simple;
	bh=+B5B7Ea8uxLMKalcjNUpDUZoTG98BLQID69O1P0xr6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/K3ClDCbVr/N5FkKCNelCJ8wQHHvk8hvYpJspmCcMED6T19T6/+c6zHLhZCsTbUF/JPLXua+biXv73t+NZC49WtELu+AQPebrx1xzJVSHwwJEZD8l5CWVwRkO2SGDuireEwEROBViw/8M8ZnlEQXgNjgGtopd43AWa5QAauBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JQj8X99I; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc4b03fca0so1583765ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722233973; x=1722838773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+ej+mYre5gtHO05efMaQEUIHF+HSHHhoHKJ6E1Z3jg=;
        b=JQj8X99IFkJz5V+BFFKJbONF26E1+fL8rxTGGPMPYf0EWAaWP9mJJn2hEPbwNmz1FH
         2SVEilWu/OUoYbaU675rs48DlSm7CdgysaG0BFezt01B8BdnrvO5kWwMX888mkZxj/A1
         Khta9440cR8oYvzZnVuCyVCW1/t2FC442JN0IgK39YSEOZn7uzUs3158DWP1Nla67Sns
         AQVgbdQiIqHjpUuJ6YPxGCP+RRTd/CFZ10bYnyygHnR/oEgER6RW+50g6GZMjOX4ArTB
         1Ipfj13gC21c/ejTtn+nVC7DqwuuXkKFWaHQGzPwzSOZlBY5W+npKXO6xQKmeBapvu+K
         2UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722233973; x=1722838773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+ej+mYre5gtHO05efMaQEUIHF+HSHHhoHKJ6E1Z3jg=;
        b=P2kyos8gB29+iTX5ICUrqKak9lnQuGd22ETAT6uTg48daYdyHvGHtZj828aGSog/L0
         jbua94+/86jvmIzvrzu2gOxqQyD0pzbiO3+Wjlnvx458uJJ1lh9Gq0RSGn+2P7f1/4u2
         bQlR075Ql72oeko2cpLCai7gc+lDa0+tIqLm2i/UlP3PaTIKitneS8DIVWbrnFEy9JW5
         HtmBRarb+qHcgPsxFkx5POochLNPnIE8+A+EEoJ4h3koDHdBXLP6PfHW05twA+ZTyJgF
         lNG5uxwL0B+dKj0HzOOrT82x2wrrfTCqQOhhLF5axhV5eJMgfeOgnfGGRPqxlIgY8IRx
         Ol1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtbAtwe/mjAgHJOd4r6cB193SgkSJqhoCbIpdyQ+wTuiHOQOx8XpsRlDckbHYc+fv6+mN0uW0vnJdRC3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwPsCIb8v9a2c12PDNoNNVf8jsWGTPjZGpwEeXY5SlFNh/VcX
	J9xgQgCUyBqz0t9wH+L7FNK4a4ut8tXwQ8QZG4npHIOZ1lhdIRwioQPNTOruUw315JObrugs5vY
	y
X-Google-Smtp-Source: AGHT+IHP9yQ73+VVJMjlOmUNfggjrjH+6V00vvrQUWBo+pyJtk3PpYjxww3k2xmitRoahrST5LcUAQ==
X-Received: by 2002:a17:902:bf04:b0:1fc:611a:bca with SMTP id d9443c01a7336-1fed6cc7ac1mr90923705ad.8.1722233972829;
        Sun, 28 Jul 2024 23:19:32 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f3eb85sm74433105ad.214.2024.07.28.23.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 23:19:32 -0700 (PDT)
Message-ID: <12bae4c3-5dda-4798-9f6a-3ac040111551@bytedance.com>
Date: Mon, 29 Jul 2024 14:19:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com> <ZqPCjd35OdNRrcfl@x1n>
 <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com> <ZqQVDwv4RM-wIW7S@x1n>
 <9e671388-a5c6-4de1-8c85-b7af8aee7f44@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <9e671388-a5c6-4de1-8c85-b7af8aee7f44@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/7/27 05:48, David Hildenbrand wrote:
> On 26.07.24 23:28, Peter Xu wrote:
>> On Fri, Jul 26, 2024 at 06:02:17PM +0200, David Hildenbrand wrote:
>>> On 26.07.24 17:36, Peter Xu wrote:
>>>> On Thu, Jul 25, 2024 at 08:39:54PM +0200, David Hildenbrand wrote:
>>>>> pte_lockptr() is the only *_lockptr() function that doesn't consume
>>>>> what would be expected: it consumes a pmd_t pointer instead of a pte_t
>>>>> pointer.
>>>>>
>>>>> Let's change that. The two callers in pgtable-generic.c are easily
>>>>> adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
>>>>> pte_offset_map_nolock() to obtain the lock, even though we won't 
>>>>> actually
>>>>> be traversing the page table.
>>>>>
>>>>> This makes the code more similar to the other variants and avoids 
>>>>> other
>>>>> hacks to make the new pte_lockptr() version happy. pte_lockptr() users
>>>>> reside now only in  pgtable-generic.c.
>>>>>
>>>>> Maybe, using pte_offset_map_nolock() is the right thing to do because
>>>>> the PTE table could have been removed in the meantime? At least it 
>>>>> sounds
>>>>> more future proof if we ever have other means of page table reclaim.
>>>>
>>>> I think it can't change, because anyone who wants to race against this
>>>> should try to take the pmd lock first (which was held already)?
>>>
>>> That doesn't explain why it is safe for us to assume that after we 
>>> took the
>>> PMD lock that the PMD actually still points at a completely empty page
>>> table. Likely it currently works by accident, because we only have a 
>>> single
>>> such user that makes this assumption. It might certainly be a 
>>> different once
>>> we asynchronously reclaim page tables.
>>
>> I think it's safe because find_pmd_or_thp_or_none() returned SUCCEED, and
>> we're holding i_mmap lock for read.  I don't see any way that this pmd 
>> can
>> become a non-pgtable-page.
>>
>> I meant, AFAIU tearing down pgtable in whatever sane way will need to at
>> least take both mmap write lock and i_mmap write lock (in this case, a 
>> file
>> mapping), no?
> 
> Skimming over [1] where I still owe a review I think we can now do it 
> now purely under the read locks, with the PMD lock held.

Yes.

> 
> I think this is also what collapse_pte_mapped_thp() ends up doing: 
> replace a PTE table that maps a folio by a PMD (present or none, 
> depends) that maps a folio only while holding the mmap lock in read 
> mode. Of course, here the table is not empty but we need similar ways of 
> making PT walkers aware of concurrent page table retraction.
> 
> IIRC, that was the magic added to __pte_offset_map(), such that 
> pte_offset_map_nolock/pte_offset_map_lock can fail on races.
> 
> 
> But if we hold the PMD lock, nothing should actually change (so far my 
> understanding) -- we cannot suddenly rip out a page table.
> 
> [1] 
> https://lkml.kernel.org/r/cover.1719570849.git.zhengqi.arch@bytedance.com
> 
>>
>>>
>>> But yes, the PMD cannot get modified while we hold the PMD lock, 
>>> otherwise
>>> we'd be in trouble
>>>
>>>>
>>>> I wonder an open coded "ptlock_ptr(page_ptdesc(pmd_page(*pmd)))" 
>>>> would be
>>>> nicer here, but only if my understanding is correct.
>>>
>>> I really don't like open-coding that. Fortunately we were able to 
>>> limit the
>>> use of ptlock_ptr to a single user outside of arch/x86/xen/mmu_pv.c 
>>> so far.
>>
>> I'm fine if you prefer like that; I don't see it a huge deal to me.
> 
> Let's keep it like that, unless we can come up with something neater. At 
> least it makes the code also more consistent with similar code in that 
> file and the overhead should be  minimal.
> 
> I was briefly thinking about actually testing if the PT is full of 
> pte_none(), either as a debugging check or to also handle what is > currently handled via:
> 
> if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
> 
> Seems wasteful just because some part of a VMA might have a private page 
> mapped / uffd-wp active to let all other parts suffer.
> 
> Will think about if that is really worth it.
> 
> ... also because I still want to understand why the PTL of the PMD table 
> is required at all. What if we lock it first and somebody else wants to 
> lock it after us while we already ripped it out? Sure there must be some 
> reason for the lock, I just don't understand it yet :/.

For pmd lock, I think this is needed to clear the pmd entry
(pmdp_collapse_flush()). For pte lock, there should be the following two
reasons:

1. release it after clearing pmd entry, then we can capture the changed
    pmd in pte_offset_map_lock() etc after holding this pte lock.
    (This is also what I did in my patchset)

2. As mentioned in the comments, we may be concurrent with
    userfaultfd_ioctl(), but we do not hold the read lock of mmap (or
    read lock of vma), so the VM_UFFD_WP may be set. Therefore, we need
    to hold the pte lock to check whether a new pte entry has been
    inserted.
    (See commit[1] for more details)

[1]. 
https://github.com/torvalds/linux/commit/a98460494b16db9c377e55bc13e5407a0eb79fe8

Thanks,
Qi

> 


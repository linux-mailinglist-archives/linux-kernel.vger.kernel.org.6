Return-Path: <linux-kernel+bounces-425267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F989DBFA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD884281FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97135156F20;
	Fri, 29 Nov 2024 07:10:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D331386DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864219; cv=none; b=s/qF7ACudsO11JWs8DcVyX+l2t4KzmtQjR3Xqk1lGmhcthbsJDNWc02+CXdp7s0pd4RAKgOAh4uR0zcI0gVZiBXGzN7ehS/queLTX+orB2OZdDpF7gr1mA6JtnsixEsUei6n5M0Av0AVNk0qkBDbhJLPSgfg9P3emf9xRWebftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864219; c=relaxed/simple;
	bh=xbfnZRcUuTOjNsQ4uI5/JZw4O0jKOmASQFKzJmjcrt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JZRdZYkBgT6CDwm5PYBIOpgFFVBVJ51S6Tj6+7+XvF+K//gb10YMF5U6BcusqWtKXsq4/f/pGsXmQauVpeLVFw9vb8NuVPzXaTiUqblJWhe/cGol5MtLF8Hfcxjvi0OD8QPBYZDGufl4Kzzx1SDfxlj+58UIp0TVkp6ZLa8AAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F24212FC;
	Thu, 28 Nov 2024 23:10:44 -0800 (PST)
Received: from [10.162.41.11] (K4MQJ0H1H2.blr.arm.com [10.162.41.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59CAA3F58B;
	Thu, 28 Nov 2024 23:10:12 -0800 (PST)
Message-ID: <66bb7496-a445-4ad7-8e56-4f2863465c54@arm.com>
Date: Fri, 29 Nov 2024 12:40:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] mmap lock in khugepaged
To: David Hildenbrand <david@redhat.com>, ryan.roberts@arm.com,
 kirill.shutemov@linux.intel.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ziy@nvidia.com
References: <20241128062641.59096-1-dev.jain@arm.com>
 <d8d29152-ce3f-406d-9e95-a0e8ea2eabbf@redhat.com>
 <4cb26a06-d982-4ca3-a5f7-7c6a6c63428c@arm.com>
 <3d4c57dd-0821-4684-9018-db8274c170ec@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <3d4c57dd-0821-4684-9018-db8274c170ec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


+the list and Zi Yan.

On 28/11/24 5:04 pm, David Hildenbrand wrote:
>>
>>
>>> Maybe, we'd have to do the isolation+copy under the PMD lock. And
>>> currently, we have to drop the PMD lock in order to have the
>>> pte_offset_map_lock() work IIRC.
>>>
>>
>> Is there a problem in holding two page table locks simultaneously?
>
> Depending on CONFIG_SPLIT_PTE_PTLOCKS, it might not even be two locks 
> (I assume we could have such configs with khugepaged).
>
> Not sure if there could be an issue with lock inversion.
>
> So I suspect this no not be 100% trivial :)
>
>>
>>
>>>
>>> Most importantly, the copy that currently runs under no spinlocks
>>> would now run under spinlock. Up to 512 MiB on arm64 64K, not sure if
>>> that can be a problem ... we currently seem to take care of that
>>
>> But we already are taking mmap_write_lock(), so that should not matter?
>
> We are dealing with a spinlock vs. a rwsem.
>
> We usually want to avoid holding spinlocks for an excessive amount of 
> time, because all other CPUs waiting for that lock will ... spin with 
> preemption disabled instead of rescheduling and doing something useful.
>

Ah okay.


>
> Further, without CONFIG_SPLIT_PMD_PTLOCKS, in fact everybody who wnats 
> to take a PMD lock in that process would be spinning on the same PMD 
> lock :)
>
>
>> I mean, if we can get rid of the mmap exclusive lock, then the copying
>> would still be a bottleneck, and all fault handlers will back off, but
>
> I'm trying to digest it once again, but I'm afraid I don't see how 
> fault handlers will back off.
>
> Won't they either see pmd_none(), to then either call pte_alloc_one() 
> where they would spin on the PMD lock, or try allocating a PMD THP to 
> insert it, and then spin on the PMD lock, to figure out later that it 
> was all in vain?

Ya that's what I meant when I said "back off", sorry I wasn't clear, I 
didn't mean VM_FAULT_FALLBACK/RETRY or something...yes, the work will be 
in vain and the MMU will refault...
>
>
> Thinking about it, I am also not sure if most other code can deal with 
> temporary pmd_none(). These don't necessarily take the PMD lock, 
> because "why would they" right now.
>
> See walk_pmd_range() as one example, if it spots pmd_none() it assumes 
> "there really is nothing" without checking the PMD lock.
>
> As a more concrete example, assume someone calls MADV_DONTNEED and we 
> end up in zap_pmd_range(). If we assume "pmd_none() == really nothing" 
> we'll skip that entry without getting the PMD lock involved. That 
> would mean that you would be breaking MADV_DONTNEED if you managed to 
> collapse or not -- memory would not get discarded.
>
> This is a real problem with anonymous memory.
>
Yes, I thought of different locking fashions but the problem seems to be 
that any pagetable walker will choose an action path according to the value
it sees.

>
> Unless I am missing something it's all very tricky and there might be 
> a lot of such code that assumes "if I hold a mmap lock / VMA lock in 
> read mode, pmd_none() means there is nothing even without holding the 
> PMD lock when checking".

Yes, I was betting on the fact that, if the code assumes that pmd_none() 
means there is nothing, eventually when it will take the PMD lock to 
write to it, it will check whether
the PMD changed, and back off. I wasn't aware of the MADV_DONTNEED 
thingy, thanks.
>
>
>> at least processes will be able to mmap() and do stuff with their VMAs,
>> and I would guess that this is worth optimizing...
>
> It would certainly be interesting to get rid of the mmap lock in write 
> mode here, but it's all rater tricky (and the code has rather nasty 
> hidden implications).
>
>>>
>>> pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>>> if (pte) {
>>>      ...
>>>      spun_unlock(pte);
>>> } ...
>>>
>>> result = __collapse_huge_page_copy(...);
>>> pte_unmap(pte);
>>>
>>>
>>> Deep in __collapse_huge_page_copy() we seem to re-rake the PTL lock.
>>> No-split-spinlock confiogs might be problematic ...
>>
>> Could you elaborate a little? I haven't read about the older config...
>
> See above regarding CONFIG_SPLIT_PTE_PTLOCKS and friends.
>
>>>
>>>
>>> I recall that for shmem that's "easier", because we don't have to
>>> reinstall a PMD immediately, we cna be sure that the page table is
>>> kept empty/unmodified, ...
>>>
>>

All in all, the general solution seems to be that, if I can take all 
pagetable walkers into an invalid state and make them backoff, then I am 
safe.
For example, we do not zero out the PMD, we take the pte PTL, we do 
stuff, then instead of setting the PTEs to zero, we set it to a universal
invalid state upon which no pagetable walker can take an action; an 
instance of that can be to set the PTE to a swap entry such that the fault
handler ends up in do_swap_page() ->print_bad_pte(). So now we can take 
the PMD lock (in fact we don't need it since any pagetable walking
is rendered useless) and populate the PMD to resume the new pagetable 
walking. Another *ridiculous* idea may be to remember the PGD we
came from and nuke it (but I guess there is an alternate path for that 
in walk_pgd_range() and so on?)


>
>


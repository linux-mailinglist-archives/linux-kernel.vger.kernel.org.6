Return-Path: <linux-kernel+bounces-427186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C10169DFDD2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5768BB21EF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A01FBEA3;
	Mon,  2 Dec 2024 09:54:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9921FBCA2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133268; cv=none; b=c7Yiv9bEzGZ1w8MDH5AZvaxI7giBxXShFUgcd6WxnAx6Bnf1TlJEcXNSKluUOdXQ+c31BkOcF3Wk9VTVFScBkFiuaIaAfHdu7ys/cOdp5tJ7KEdOrSvBMGOV9z/Jmio/tvzDe26BOBg8PbdeL5L6iAqbi3Ls5nd5lZjHyGdjkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133268; c=relaxed/simple;
	bh=xIBAOgrDf2xjw1hxFTm+QGKs/3nShZCFNxZXIasKgLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oSJsB5+grOM7I2N51gPXzFY4CMYGEqBrt1giAUBM6eXrPmJEA7WX1c5nVVcBi2T1F/zdt/wHFgpqZf13WJV11/BD7ZWgbMmZVxcyuUrZ9mr5C7ThKFYHI5iI8ZalwsxDoSsdxFRE/nMyZENOgJnNecgRqoDKnGLjWvDkzxMqOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B2A4FEC;
	Mon,  2 Dec 2024 01:54:52 -0800 (PST)
Received: from [10.162.40.26] (K4MQJ0H1H2.blr.arm.com [10.162.40.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3DBD3F58B;
	Mon,  2 Dec 2024 01:54:21 -0800 (PST)
Message-ID: <fe96ea70-5796-483b-ac1f-e58feeb63676@arm.com>
Date: Mon, 2 Dec 2024 15:24:18 +0530
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
 <66bb7496-a445-4ad7-8e56-4f2863465c54@arm.com>
 <d5b827a4-81ae-4283-9bb4-2e38adc47d71@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <d5b827a4-81ae-4283-9bb4-2e38adc47d71@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 29/11/24 5:00 pm, David Hildenbrand wrote:
>>>
>>> Thinking about it, I am also not sure if most other code can deal with
>>> temporary pmd_none(). These don't necessarily take the PMD lock,
>>> because "why would they" right now.
>>>
>>> See walk_pmd_range() as one example, if it spots pmd_none() it assumes
>>> "there really is nothing" without checking the PMD lock.
>>>
>>> As a more concrete example, assume someone calls MADV_DONTNEED and we
>>> end up in zap_pmd_range(). If we assume "pmd_none() == really nothing"
>>> we'll skip that entry without getting the PMD lock involved. That
>>> would mean that you would be breaking MADV_DONTNEED if you managed to
>>> collapse or not -- memory would not get discarded.
>>>
>>> This is a real problem with anonymous memory.
>>>
>> Yes, I thought of different locking fashions but the problem seems to be
>> that any pagetable walker will choose an action path according to the 
>> value
>> it sees.
>>
>>>
>>> Unless I am missing something it's all very tricky and there might be
>>> a lot of such code that assumes "if I hold a mmap lock / VMA lock in
>>> read mode, pmd_none() means there is nothing even without holding the
>>> PMD lock when checking".
>>
>> Yes, I was betting on the fact that, if the code assumes that pmd_none()
>> means there is nothing, eventually when it will take the PMD lock to
>> write to it, it will check whether
>> the PMD changed, and back off. I wasn't aware of the MADV_DONTNEED
>> thingy, thanks.
>
> Note that this is just the tip of the iceberg. Most page table walkers 
> that deal with anonymous memory have the same requirement.
>
>>>>>
>>>>>
>>>>> I recall that for shmem that's "easier", because we don't have to
>>>>> reinstall a PMD immediately, we cna be sure that the page table is
>>>>> kept empty/unmodified, ...
>>>>>
>>>>
>>
>> All in all, the general solution seems to be that, if I can take all
>> pagetable walkers into an invalid state and make them backoff, then I am
>> safe.
> > For example, we do not zero out the PMD, we take the pte PTL, we do> 
> stuff, then instead of setting the PTEs to zero, we set it to a universal
>> invalid state upon which no pagetable walker can take an action; an
>> instance of that can be to set the PTE to a swap entry such that the 
>> fault
>> handler ends up in do_swap_page() ->print_bad_pte(). So now we can take
>> the PMD lock (in fact we don't need it since any pagetable walking
>> is rendered useless) and populate the PMD to resume the new pagetable
>> walking. Another *ridiculous* idea may be to remember the PGD we
>> came from and nuke it (but I guess there is an alternate path for that
>> in walk_pgd_range() and so on?)
>
>
> What might work is introducing a PMD marker (note: we don't have PMD 
> markers yet) for that purpose. Likely, the PMD marker may only be set 
> while the PMD lock is being held, and we must not drop the PMD lock 
> temporarily (otherwise people will spin on the value by repeadetly 
> (un)locking the PMD lock, which is stupid).
>
>
> Then you have to make sure that each and every page table walker 
> handles that properly.
>
> Then, there is the problem with holding the PMD lock for too long as I 
> mentioned.
>
> Last but not least, there are more issues that I haven't even 
> described before (putting aside the other issue):
>
>
> Our page table walkers can handle the transitions:
>
> PMD leaf -> PMD none
> * concurrent zap / MADV_DONTNEED / !anon PMD split
>
> PMD leaf -> PTE table
> * concurrent anon PMD split
> * concurrent zap / MADV_DONTNEED / !anon PMD split + PTE table
>   allocation
>
> PTE table (empty) -> PMD none
> * concurrent page table reclaim, part of collapsing file THPs
>  * collapse_pte_mapped_thp()
>  * retract_page_tables()
>
>
> I think they *cannot* tolerate the transition *properly*:
>
> PTE table (non-empty) -> PMD leaf
> * what you want do do ;)
>
> -> Observe how we skip to the next PMD in all page table walkers /  
> give up if pte_offset_map_lock() and friends fail! I even think there 
> are more issues hiding there with pte_offset_map_ro_nolock().
>
>
> Of course, on top of all of this, you should net significantly degrade 
> the ordinary page table walker performance ...
>
>
> I don't want to discourage you, but it's all extremely complicated.
>
Thanks for the detailed reply!


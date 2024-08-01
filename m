Return-Path: <linux-kernel+bounces-271058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BB99448F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDB0B22C59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07672183CA7;
	Thu,  1 Aug 2024 10:06:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B282AD25
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506763; cv=none; b=nnkvcGCTDyGOrk5MZMiQXQBsA6Q0BPJkCMbEy8ozN2SxsKI7/C9k3BZfr9gzYeTxzdHScENGWaynbtrOPbZAWgyKfgUqbmPDWF/4boqyFR2xMU7yMqKLIQPLywXFjVgAKHbTuIu5FFcKUok+n5x3HgTIyyw3OxNhBWnZlyGAIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506763; c=relaxed/simple;
	bh=JgdrEqMHMlwd4dqWq0GxMraTlhj3mQqNvQjCaHQathw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0XhlKacy9eeGcZ6PinrEbcVETIZa73RQVz2RRHkcnn4GJ6NeDZOIR9fF4OJ2JFE5hz+YbdcT2Qgiv/g7tRKLJwAD7p0XtVaS2Dt3YKY+/Qmr1udDzy4X0iXFgo3Q4EJxwiXdbIMLnT2ZwRpobLW3xyZJyj4/3Y5V4xQa1YCMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC7215A1;
	Thu,  1 Aug 2024 03:06:26 -0700 (PDT)
Received: from [10.162.42.27] (e116581.arm.com [10.162.42.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 014253F5A1;
	Thu,  1 Aug 2024 03:05:52 -0700 (PDT)
Message-ID: <92df0ee1-d3c9-41e2-834c-284127ae2c4c@arm.com>
Date: Thu, 1 Aug 2024 15:35:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
 <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/1/24 15:11, David Hildenbrand wrote:
> On 01.08.24 11:38, Dev Jain wrote:
>>
>> On 8/1/24 14:12, David Hildenbrand wrote:
>>> On 01.08.24 10:16, Dev Jain wrote:
>>>> I and Ryan had a discussion and we thought it would be best to get
>>>> feedback
>>>> from the community.
>>>>
>>>> The migration mm selftest currently fails on arm64 for shared anon
>>>> mappings,
>>>> due to the following race:
>>>
>>> Do you mean MAP_SHARED|MAP_ANON or MAP_PRIVATE|MAP_ANON_fork? Because
>>> you note shmem below, I assume you mean MAP_SHARED|MAP_ANON
>>
>>
>> Yes.
>>
>>>
>>>>
>>>> Migration:                        Page fault:
>>>> try_to_migrate_one():                    handle_pte_fault():
>>>> 1. Nuke the PTE                        PTE has been deleted =>
>>>> do_pte_missing()
>>>> 2. Mark the PTE for migration                PTE has not been deleted
>>>> but is just not "present" => do_swap_page()
>>>>
>>>
>>> In filemap_fault_recheck_pte_none() we recheck under PTL to make sure
>>> that a temporary pte_none() really was persistent pte_none() and not a
>>> temporary pte_none() under PTL.
>>>
>>> Should we do something similar in do_fault()? I see that we already do
>>> something like that on the "!vma->vm_ops->fault" path.
>>>
>>> But of course, there is a tradeoff between letting migration
>>> (temporarily) fail and grabbing the PTL during page faults.
>>
>>
>> To dampen the tradeoff, we could do this in shmem_fault() instead? But
>> then, this would mean that we do this in all
>>
>> kinds of vma->vm_ops->fault, only when we discover another reference
>> count race condition :) Doing this in do_fault()
>>
>> should solve this once and for all. In fact, do_pte_missing() may call
>> do_anonymous_page() or do_fault(), and I just
>>
>> noticed that the former already checks this using vmf_pte_changed().
>
> What I am still missing is why this is (a) arm64 only; and (b) if this 
> is something we should really worry about. There are other reasons 
> (e.g., speculative references) why migration could temporarily fail, 
> does it happen that often that it is really something we have to worry 
> about?


(a) See discussion at [1]; I guess it passes on x86, which is quite 
strange since the race is clearly arch-independent.

(b) On my machine, on an average in under 10 iterations of move_pages(), 
it fails, which seems problematic to

me assuming it is passing on other arches, since 10 iterations means 
this is failing very quickly.


[1]: 
https://lore.kernel.org/all/9de42ace-dab1-5f60-af8a-26045ada27b9@arm.com/



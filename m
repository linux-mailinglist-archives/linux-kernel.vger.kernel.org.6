Return-Path: <linux-kernel+bounces-271415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69005944DED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0321C230E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633011A488E;
	Thu,  1 Aug 2024 14:25:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9C3194AE6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522322; cv=none; b=U9AAVK9IIy48kQEd9mD5Mijvpeg1Tm9sSc/Y4HrYI44KFrOOJa2qJOvJkrlj7vIUEj+FqjIbzvOjw48skUQ277odTTwd4zprQrYInzq4lRnCRmAXhbJiUoQGLKDLar0S4Mkml0lvhJn1azjsdPWKXRLBe7M6XaZu/YRf9M/H+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522322; c=relaxed/simple;
	bh=EBQFRhjVzoLWgRpbsdJuOZKGl9c4BaEqLEqFJXnR4qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBRLYovdVdoKDEbrW6o8X7lj50oljjx8koHrGp9NGLdr5DntRo3afYsUfUbidxD9QeVXYkDcZ/CbwdPQND1V1tIYLy7tLlyKiCmjpBzjuSECB5knYv0o0bm4WG5GvVoJ/wDzdGdTdzQa+wJRPaKPN1eTBgzkRequneR1IFnVlZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2C7A15A1;
	Thu,  1 Aug 2024 07:25:45 -0700 (PDT)
Received: from [10.1.28.152] (XHFQ2J9959.cambridge.arm.com [10.1.28.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6576D3F766;
	Thu,  1 Aug 2024 07:25:16 -0700 (PDT)
Message-ID: <0321bc45-f577-49a7-be85-7dab8a9b350e@arm.com>
Date: Thu, 1 Aug 2024 15:25:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, baohua@kernel.org, ioworker0@gmail.com,
 gshan@redhat.com, mark.rutland@arm.com, kirill.shutemov@linux.intel.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
 <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
 <92df0ee1-d3c9-41e2-834c-284127ae2c4c@arm.com>
 <19902a48-c59b-4e3b-afc5-e792506c2fd6@redhat.com>
 <6486a2b1-45ef-44b6-bd84-d402fc121373@redhat.com>
 <20240801134358.GB4794@willie-the-truck>
 <9359caf7-81a8-45d9-9787-9009b3b2eed3@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9359caf7-81a8-45d9-9787-9009b3b2eed3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/08/2024 14:48, David Hildenbrand wrote:
> On 01.08.24 15:43, Will Deacon wrote:
>> On Thu, Aug 01, 2024 at 03:26:57PM +0200, David Hildenbrand wrote:
>>> On 01.08.24 15:13, David Hildenbrand wrote:
>>>>>>> To dampen the tradeoff, we could do this in shmem_fault() instead? But
>>>>>>> then, this would mean that we do this in all
>>>>>>>
>>>>>>> kinds of vma->vm_ops->fault, only when we discover another reference
>>>>>>> count race condition :) Doing this in do_fault()
>>>>>>>
>>>>>>> should solve this once and for all. In fact, do_pte_missing() may call
>>>>>>> do_anonymous_page() or do_fault(), and I just
>>>>>>>
>>>>>>> noticed that the former already checks this using vmf_pte_changed().
>>>>>>
>>>>>> What I am still missing is why this is (a) arm64 only; and (b) if this
>>>>>> is something we should really worry about. There are other reasons
>>>>>> (e.g., speculative references) why migration could temporarily fail,
>>>>>> does it happen that often that it is really something we have to worry
>>>>>> about?
>>>>>
>>>>>
>>>>> (a) See discussion at [1]; I guess it passes on x86, which is quite
>>>>> strange since the race is clearly arch-independent.
>>>>
>>>> Yes, I think this is what we have to understand. Is the race simply less
>>>> likely to trigger on x86?
>>>>
>>>> I would assume that it would trigger on any arch.
>>>>
>>>> I just ran it on a x86 VM with 2 NUMA nodes and it also seems to work here.
>>>>
>>>> Is this maybe related to deferred flushing? Such that the other CPU will
>>>> by accident just observe the !pte_none a little less likely?
>>>>
>>>> But arm64 also usually defers flushes, right? At least unless
>>>> ARM64_WORKAROUND_REPEAT_TLBI is around. With that we never do deferred
>>>> flushes.
>>>
>>> Bingo!
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index e51ed44f8b53..ce94b810586b 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -718,10 +718,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct
>>> *mm, pte_t pteval,
>>>    */
>>>   static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>>>   {
>>> -       if (!(flags & TTU_BATCH_FLUSH))
>>> -               return false;
>>> -
>>> -       return arch_tlbbatch_should_defer(mm);
>>> +       return false;
>>>   }
>>>
>>>
>>> On x86:
>>>
>>> # ./migration
>>> TAP version 13
>>> 1..1
>>> # Starting 1 tests from 1 test cases.
>>> #  RUN           migration.shared_anon ...
>>> Didn't migrate 1 pages
>>> # migration.c:170:shared_anon:Expected migrate(ptr, self->n1, self->n2) (-2)
>>> == 0 (0)
>>> # shared_anon: Test terminated by assertion
>>> #          FAIL  migration.shared_anon
>>> not ok 1 migration.shared_anon
>>>
>>>
>>> It fails all of the time!
>>
>> Nice work! I suppose that makes sense as, with the eager TLB
>> invalidation, the window between the other CPU faulting and the
>> migration entry being written is fairly wide.
>>
>> Not sure about a fix though :/ It feels a bit overkill to add a new
>> invalid pte encoding just for this.

If we want to fix the kernel, I think Dev's option 2 could work?

2. Prepare the migration swap entry and do an atomic exchange to fill the PTE
(this currently seems the best option to me, but I have not tried it out).

We could create a new helper, ptep_get_and_set_not_present() then we can
atomically change the pte to the migration entry so the fault handler never sees
pte_none(). On arm64 we are already using an atomic in ptep_get_and_clear() so
its no extra work. We could implement a non-atomic default version for other
arches. (Although I guess if we fix for arm64 we would want to fix for all).
That wouldn't require any new encoding, just refactoring the migration code to
call the helper.

But if we can convince ourselves that changing the test as David suggests below
is good enough and we won't still get spurious failures, then that seems
simplest. Dev, could you see if you can get the retry-the-test approach to fail?

Thanks,
Ryan


> 
> Something like that might make the test happy in most cases:
> 
> diff --git a/tools/testing/selftests/mm/migration.c
> b/tools/testing/selftests/mm/migration.c
> index 6908569ef406..4c18bfc13b94 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -65,6 +65,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
>         int ret, tmp;
>         int status = 0;
>         struct timespec ts1, ts2;
> +       int errors = 0;
>  
>         if (clock_gettime(CLOCK_MONOTONIC, &ts1))
>                 return -1;
> @@ -79,12 +80,17 @@ int migrate(uint64_t *ptr, int n1, int n2)
>                 ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
>                                 MPOL_MF_MOVE_ALL);
>                 if (ret) {
> -                       if (ret > 0)
> +                       if (ret > 0) {
> +                               if (++errors < 100)
> +                                       continue;
>                                 printf("Didn't migrate %d pages\n", ret);
> -                       else
> +                       } else {
>                                 perror("Couldn't migrate pages");
> +                       }
>                         return -2;
>                 }
> +               /* Progress! */
> +               errors = 0;
>  
>                 tmp = n2;
>                 n2 = n1;
> 
> 
> [root@localhost mm]# ./migration
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> #  RUN           migration.shared_anon ...
> #            OK  migration.shared_anon
> ok 1 migration.shared_anon
> # PASSED: 1 / 1 tests passed.
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> 



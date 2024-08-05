Return-Path: <linux-kernel+bounces-274783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66109947CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C8C1F223AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B18F13A265;
	Mon,  5 Aug 2024 14:15:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A653EA64
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867311; cv=none; b=sUQcpzISiwj/kToG/+SlAkZmcDgmICAuf3trHPRQsuInM0UMdiK7Bo3DNEUFlR1RbBErOtJ5itDZNpvPr1tb42kmLylEzqf0/ynXR+7mgANb16PCZLt6FsuykeOffLvSLMTfuHjnpz6TZwyHtrw4LlhPGCl91y2J7ooTe0vCA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867311; c=relaxed/simple;
	bh=GR49czBIzK9LqLdAMSHjjEooIfgMlDZx+3OV9K90HLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQeFSUMovGZzuydPuyKtpqRqvSU3Rol2vsxOz10qAV43eCp4wKoiVO5fjgvszzxwhrPtJdcStFZSAowAb31//kHKmNlLpNYXqL81oQCfhwcA8HCbXk6N3GU/1R2Q8ltfUBo6hQz/hvlhBgjlQ1Ek7j/GlVHNJ3PBMuy3pvXytwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48746106F;
	Mon,  5 Aug 2024 07:15:33 -0700 (PDT)
Received: from [10.162.41.18] (e116581.arm.com [10.162.41.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E4083F5A1;
	Mon,  5 Aug 2024 07:14:58 -0700 (PDT)
Message-ID: <cf8dc1c6-948a-42e7-8aef-c6183ca6cac0@arm.com>
Date: Mon, 5 Aug 2024 19:44:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
To: David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, osalvador@suse.de,
 baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
 baohua@kernel.org, ioworker0@gmail.com, gshan@redhat.com,
 mark.rutland@arm.com, kirill.shutemov@linux.intel.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@techsingularity.net
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
 <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
 <92df0ee1-d3c9-41e2-834c-284127ae2c4c@arm.com>
 <19902a48-c59b-4e3b-afc5-e792506c2fd6@redhat.com>
 <6486a2b1-45ef-44b6-bd84-d402fc121373@redhat.com>
 <20240801134358.GB4794@willie-the-truck>
 <9359caf7-81a8-45d9-9787-9009b3b2eed3@redhat.com>
 <f8d21caa-7a82-4761-8a78-d928ae8d0f24@arm.com>
 <418e818a-f385-459e-a84d-e3880ac08ad5@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <418e818a-f385-459e-a84d-e3880ac08ad5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/5/24 16:16, David Hildenbrand wrote:
> On 05.08.24 11:51, Dev Jain wrote:
>>
>> On 8/1/24 19:18, David Hildenbrand wrote:
>>> On 01.08.24 15:43, Will Deacon wrote:
>>>> On Thu, Aug 01, 2024 at 03:26:57PM +0200, David Hildenbrand wrote:
>>>>> On 01.08.24 15:13, David Hildenbrand wrote:
>>>>>>>>> To dampen the tradeoff, we could do this in shmem_fault()
>>>>>>>>> instead? But
>>>>>>>>> then, this would mean that we do this in all
>>>>>>>>>
>>>>>>>>> kinds of vma->vm_ops->fault, only when we discover another
>>>>>>>>> reference
>>>>>>>>> count race condition :) Doing this in do_fault()
>>>>>>>>>
>>>>>>>>> should solve this once and for all. In fact, do_pte_missing()
>>>>>>>>> may call
>>>>>>>>> do_anonymous_page() or do_fault(), and I just
>>>>>>>>>
>>>>>>>>> noticed that the former already checks this using
>>>>>>>>> vmf_pte_changed().
>>>>>>>>
>>>>>>>> What I am still missing is why this is (a) arm64 only; and (b) if
>>>>>>>> this
>>>>>>>> is something we should really worry about. There are other reasons
>>>>>>>> (e.g., speculative references) why migration could temporarily 
>>>>>>>> fail,
>>>>>>>> does it happen that often that it is really something we have to
>>>>>>>> worry
>>>>>>>> about?
>>>>>>>
>>>>>>>
>>>>>>> (a) See discussion at [1]; I guess it passes on x86, which is quite
>>>>>>> strange since the race is clearly arch-independent.
>>>>>>
>>>>>> Yes, I think this is what we have to understand. Is the race simply
>>>>>> less
>>>>>> likely to trigger on x86?
>>>>>>
>>>>>> I would assume that it would trigger on any arch.
>>>>>>
>>>>>> I just ran it on a x86 VM with 2 NUMA nodes and it also seems to
>>>>>> work here.
>>>>>>
>>>>>> Is this maybe related to deferred flushing? Such that the other CPU
>>>>>> will
>>>>>> by accident just observe the !pte_none a little less likely?
>>>>>>
>>>>>> But arm64 also usually defers flushes, right? At least unless
>>>>>> ARM64_WORKAROUND_REPEAT_TLBI is around. With that we never do 
>>>>>> deferred
>>>>>> flushes.
>>>>>
>>>>> Bingo!
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index e51ed44f8b53..ce94b810586b 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -718,10 +718,7 @@ static void set_tlb_ubc_flush_pending(struct
>>>>> mm_struct
>>>>> *mm, pte_t pteval,
>>>>>     */
>>>>>    static bool should_defer_flush(struct mm_struct *mm, enum
>>>>> ttu_flags flags)
>>>>>    {
>>>>> -       if (!(flags & TTU_BATCH_FLUSH))
>>>>> -               return false;
>>>>> -
>>>>> -       return arch_tlbbatch_should_defer(mm);
>>>>> +       return false;
>>>>>    }
>>>>>
>>>>>
>>>>> On x86:
>>>>>
>>>>> # ./migration
>>>>> TAP version 13
>>>>> 1..1
>>>>> # Starting 1 tests from 1 test cases.
>>>>> #  RUN           migration.shared_anon ...
>>>>> Didn't migrate 1 pages
>>>>> # migration.c:170:shared_anon:Expected migrate(ptr, self->n1,
>>>>> self->n2) (-2)
>>>>> == 0 (0)
>>>>> # shared_anon: Test terminated by assertion
>>>>> #          FAIL  migration.shared_anon
>>>>> not ok 1 migration.shared_anon
>>>>>
>>>>>
>>>>> It fails all of the time!
>>>>
>>>> Nice work! I suppose that makes sense as, with the eager TLB
>>>> invalidation, the window between the other CPU faulting and the
>>>> migration entry being written is fairly wide.
>>>>
>>>> Not sure about a fix though :/ It feels a bit overkill to add a new
>>>> invalid pte encoding just for this.
>>>
>>> Something like that might make the test happy in most cases:
>>>
>>> diff --git a/tools/testing/selftests/mm/migration.c
>>> b/tools/testing/selftests/mm/migration.c
>>> index 6908569ef406..4c18bfc13b94 100644
>>> --- a/tools/testing/selftests/mm/migration.c
>>> +++ b/tools/testing/selftests/mm/migration.c
>>> @@ -65,6 +65,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
>>>          int ret, tmp;
>>>          int status = 0;
>>>          struct timespec ts1, ts2;
>>> +       int errors = 0;
>>>
>>>          if (clock_gettime(CLOCK_MONOTONIC, &ts1))
>>>                  return -1;
>>> @@ -79,12 +80,17 @@ int migrate(uint64_t *ptr, int n1, int n2)
>>>                  ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
>>>                                  MPOL_MF_MOVE_ALL);
>>>                  if (ret) {
>>> -                       if (ret > 0)
>>> +                       if (ret > 0) {
>>> +                               if (++errors < 100)
>>> +                                       continue;
>>>                                  printf("Didn't migrate %d pages\n", 
>>> ret);
>>> -                       else
>>> +                       } else {
>>>                                  perror("Couldn't migrate pages");
>>> +                       }
>>>                          return -2;
>>>                  }
>>> +               /* Progress! */
>>> +               errors = 0;
>>>
>>>                  tmp = n2;
>>>                  n2 = n1;
>>>
>>>
>>> [root@localhost mm]# ./migration
>>> TAP version 13
>>> 1..1
>>> # Starting 1 tests from 1 test cases.
>>> #  RUN           migration.shared_anon ...
>>> #            OK  migration.shared_anon
>>> ok 1 migration.shared_anon
>>> # PASSED: 1 / 1 tests passed.
>>> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>
>>
>> This does make the test pass, to my surprise, since what you are doing
>> from userspace
>>
>> should have been done by the kernel, because it retries folio unmapping
>> and moving
>>
>> NR_MAX_MIGRATE_(A)SYNC_RETRY times; I had already tested pumping up 
>> these
>>
>> macros and the original test was still failing. Now, I digged in more,
>> and, if the
>>
>> following assertion is correct:
>>
>>
>> Any thread having a reference on a folio will end up calling 
>> folio_lock()
>>
>
> Good point. I suspect concurrent things like read/write would also be 
> able to trigger this (did not check, though).
>
>>
>> then it seems to me that the retry for loop wrapped around
>> migrate_folio_move(), inside
>>
>> migrate_pages_batch(), is useless; if migrate_folio_move() fails on the
>> first iteration, it is
>>
>> going to fail for all iterations since, if I am reading the code path
>> correctly, the only way it
>>
>> fails is when the actual refcount is not equal to expected refcount (in
>> folio_migrate_mapping()),
>>
>> and there is no way that the extra refcount is going to get released
>> since the migration path
>>
>> has the folio lock.
>>
>> And therefore, this begs the question: isn't it logical to assert the
>> actual refcount against the
>>
>> expected refcount, just after we have changed the PTEs, so that if this
>> assertion fails, we can
>>
>> go to the next iteration of the for loop for migrate_folio_unmap()
>> inside migrate_pages_batch()
>>
>> by calling migrate_folio_undo_src()/dst() to restore the old state? I am
>> trying to implement
>>
>> this but is not as straightforward as it seemed to me this morning.
>
> I agree with your assessment that migration code currently doesn't 
> handle the case well when some other thread does an unconditional 
> folio_lock(). folio_trylock() users would be handled, but that's not 
> what we want with FGP_LOCK I assume.
>
> So IIUC, your idea would be to unlock the folio in migration code and 
> try again their. Sounds reasonable, without looking into the details :)


(Adding Mel if at all he has any comments for a compaction use-case)

What I was trying to say is this (forgive me for the hard-coded value):

diff --git a/mm/migrate.c b/mm/migrate.c
index a8c6f466e33a..404af46dd661 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1262,6 +1262,8 @@ static int migrate_folio_unmap(new_folio_t 
get_new_folio,
}
if (!folio_mapped(src)) {
+ if (folio_ref_count(src) != 2)
+ goto out;
__migrate_folio_record(dst, old_page_state, anon_vma);
return MIGRATEPAGE_UNMAP;
}
This will give us more chances to win the race. On an average, now
the test fails on 100 iterations of move_pages(). If you multiply
the NR_MAX_PAGES_(A)SYNC_RETRY macros by 3, the average goes above
to 2000.
But if the consensus is that this is just pleasing the test without
any real use-case (compaction?) then I guess I am alright with making
the change in the test.



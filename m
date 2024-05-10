Return-Path: <linux-kernel+bounces-175277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DA8C1D70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813BF1C21078
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781114A63C;
	Fri, 10 May 2024 04:29:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C180046
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715315345; cv=none; b=RL9DEfmkeY8KiOMQb+rrXu9qCcAvqHmBALkrs9AU91S4WzyPvJ7oRIM7CKodCasJ8+JCXh5G8UNaXKSCoWrlXBldAxUka/vF0EHp/dJCVXvx/+SyBkz/z33SqLLVWOyyAKDwrk3ZivzHN4/EHon13qHSP3GwuaaZrWlchtvZ5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715315345; c=relaxed/simple;
	bh=O840MrsrAQB+7MaiiLKUB8HaKsvkvNE2dTnR+IXHXbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlhRMg2yvigdpQi65XhhOyzjDq5Rd3wj2d/rNkI7vvKHpOZMBIuuvtNnh6+Fo5EwGrNH6o7cNCowcnU3XbtBbVLEtiNY1BV381Wpfqyug9GE7DjIMxM7JbY+lbrAfF+BoIZe4KtR3uVnX5BrYiN+A0rS2HD+jzfHldBMQOKZSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33638106F;
	Thu,  9 May 2024 21:29:26 -0700 (PDT)
Received: from [10.163.37.102] (unknown [10.163.37.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FFBF3F762;
	Thu,  9 May 2024 21:28:47 -0700 (PDT)
Message-ID: <42837c05-c111-49fc-bf19-e690608f66da@arm.com>
Date: Fri, 10 May 2024 09:58:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
Content-Language: en-US
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <c9c3c0d5-bb61-4eed-8b89-b0341a2c6f5c@arm.com>
 <bb60d304-3341-472d-a4ee-d31b4754c39b@os.amperecomputing.com>
 <5e6158aa-09d3-4665-878e-17358aee10cb@arm.com>
 <328c4c86-96c8-4896-8b6d-94f2facdac9a@os.amperecomputing.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <328c4c86-96c8-4896-8b6d-94f2facdac9a@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/10/24 03:16, Yang Shi wrote:
> 
> 
> On 5/8/24 9:31 PM, Anshuman Khandual wrote:
>>
>> On 5/9/24 00:07, Yang Shi wrote:
>>>
>>> On 5/7/24 11:45 PM, Anshuman Khandual wrote:
>>>> Hello Yang,
>>>>
>>>> On 5/8/24 04:05, Yang Shi wrote:
>>>>> The atomic RMW instructions, for example, ldadd, actually does load +
>>>>> add + store in one instruction, it may trigger two page faults, the
>>>>> first fault is a read fault, the second fault is a write fault.
>>>> It may or it will definitely create two consecutive page faults. What
>>>> if the second write fault never came about. In that case an writable
>>>> page table entry would be created unnecessarily (or even wrongfully),
>>>> thus breaking the CoW.
>>>>
>>>> Just trying to understand, is the double page fault a possibility or
>>>> a certainty. Does that depend on architecture (please do provide some
>>>> links) or is it implementation defined.
>>> Christopher helped answer some questions, I will skip those if I have nothing to add.
>>>
>>> It is defined in ARM architecture reference manual, so it is not implementation defined.
>> Sure, but please replace the "may trigger" phrase above as appropriate.
> 
> Yeah, sure.
> 
>>
>>>>> Some applications use atomic RMW instructions to populate memory, for
>>>>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
>>>> But why cannot normal store operation is sufficient for pre-touching
>>>> the heap memory, why read-modify-write (RMW) is required instead ?
>>> Memory write is fine, but it depends on applications. For example, JVM may want to "permit use of memory concurrently with pretouch". So they chose use atomic instead of memory write.
>>>
>>>>> at launch time) between v18 and v22.
>>>> V18, V22 ?
>>> v18/v19/v20/v21/v22
>>>
>>>>> But the double page fault has some problems:
>>>>>
>>>>> 1. Noticeable TLB overhead.  The kernel actually installs zero page with
>>>>>      readonly PTE for the read fault.  The write fault will trigger a
>>>>>      write-protection fault (CoW).  The CoW will allocate a new page and
>>>>>      make the PTE point to the new page, this needs TLB invalidations.  The
>>>>>      tlb invalidation and the mandatory memory barriers may incur
>>>>>      significant overhead, particularly on the machines with many cores.
>>>>>
>>>>> 2. Break up huge pages.  If THP is on the read fault will install huge
>>>>>      zero pages.  The later CoW will break up the huge page and allocate
>>>>>      base pages instead of huge page.  The applications have to rely on
>>>>>      khugepaged (kernel thread) to collapse huge pages asynchronously.
>>>>>      This also incurs noticeable performance penalty.
>>>>>
>>>>> 3. 512x page faults with huge page.  Due to #2, the applications have to
>>>>>      have page faults for every 4K area for the write, this makes the speed
>>>>>      up by using huge page actually gone.
>>>> The problems mentioned above are reasonable and expected.
>>>>    If the memory address has some valid data, it must have already reached there
>>>> via a previous write access, which would have caused initial CoW transition ?
>>>> If the memory address has no valid data to begin with, why even use RMW ?
>>>>
>>>>> So it sounds pointless to have two page faults since we know the memory
>>>>> will be definitely written very soon.  Forcing write fault for atomic RMW
>>>>> instruction makes some sense and it can solve the aforementioned problems:
>>>>>
>>>>> Firstly, it just allocates zero'ed page, no tlb invalidation and memory
>>>>> barriers anymore.
>>>>> Secondly, it can populate writable huge pages in the first place and
>>>>> don't break them up.  Just one page fault is needed for 2M area instrad
>>>>> of 512 faults and also save cpu time by not using khugepaged.
>>>>>
>>>>> A simple micro benchmark which populates 1G memory shows the number of
>>>>> page faults is reduced by half and the time spent by system is reduced
>>>>> by 60% on a VM running on Ampere Altra platform.
>>>>>
>>>>> And the benchmark for anonymous read fault on 1G memory, file read fault
>>>>> on 1G file (cold page cache and warm page cache) don't show noticeable
>>>>> regression.
>>>>>
>>>>> Some other architectures also have code inspection in page fault path,
>>>>> for example, SPARC and x86.
>>>> Okay, I was about to ask, but is not calling get_user() for all data
>>>> read page faults increase the cost for a hot code path in general for
>>>> some potential savings for a very specific use case. Not sure if that
>>>> is worth the trade-off.
>>> I tested read fault latency (anonymous read fault and file read fault), I didn't see noticeable regression.
>> Could you please run a multi threaded application accessing one common
>> buffer while running these atomic operations. We just need to ensure
>> that pagefault_disable()-enable() window is not preventing concurrent
>> page faults and adding access latency to other threads.
> 
> I modified page_fault1 test in will-it-scale to make it just generate read fault (the original code generated write fault), and anonymous read fault should be the most sensitive case to this change. Then I ran the test with different number of threads (1 - 160 

Right, only with read data faults i.e (!FAULT_FLAG_WRITE and !FAULT_FLAG_INSTRUCTION)
code path enters the pagefault_disable/enable() window, but all others will skip it.

because total 160 cores on my test machine), please see the below table (hopefully my email client won't mess it)

Thanks for providing the test results.

> 
> nr_threads           before                after            +/-
> 1                      2056996            2048030        -0.4%
> 20                    17836422          16718606      -6.27%
> 40                    28536237          27958875      -2.03%
> 60                    35947854          35236884      -2%
> 80                    31646632          39209665      +24%
> 100                  20836142          21017796      +0.9%
> 120                  20350980          20635603      +1.4%
> 140                  20041920          19904015      -0.7%
> 160                  19561908          20264360      +3.6%
> 
> Sometimes the after is better than the before, sometimes opposite. There are two outliers, other than them there is not noticeable regression.

This does not look that bad, but will probably let others weigh in.

> 
> To rule out the worst case, I also ran the test 100 iterations with 160 threads then compared the worst case:
> 
>     N           Min           Max        Median           Avg Stddev
>  100         34770         84979         65536       63537.7 10358.873
>  100         38077         87652         65536      63119.02 8792.7399
> 
> Still no noticeable regression.

I guess to make things better, probably pagefault_enable() could be moved
before aarch64_insn_is_class_atomic() which might not need page faults to
be disabled ? Also what about non user mode atomic instructions, causing
similar scenarios ? Because get_user() will not be able to fetch those. 

> 
>>
>>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>>> ---
>>>>>    arch/arm64/include/asm/insn.h |  1 +
>>>>>    arch/arm64/mm/fault.c         | 19 +++++++++++++++++++
>>>>>    2 files changed, 20 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>>>>> index db1aeacd4cd9..5d5a3fbeecc0 100644
>>>>> --- a/arch/arm64/include/asm/insn.h
>>>>> +++ b/arch/arm64/include/asm/insn.h
>>>>> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)    \
>>>>>     * "-" means "don't care"
>>>>>     */
>>>>>    __AARCH64_INSN_FUNCS(class_branch_sys,    0x1c000000, 0x14000000)
>>>>> +__AARCH64_INSN_FUNCS(class_atomic,    0x3b200c00, 0x38200000)
>>>>>      __AARCH64_INSN_FUNCS(adr,    0x9F000000, 0x10000000)
>>>>>    __AARCH64_INSN_FUNCS(adrp,    0x9F000000, 0x90000000)
>>>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>>>> index 8251e2fea9c7..f7bceedf5ef3 100644
>>>>> --- a/arch/arm64/mm/fault.c
>>>>> +++ b/arch/arm64/mm/fault.c
>>>>> @@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>>        unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>>>>>        unsigned long addr = untagged_addr(far);
>>>>>        struct vm_area_struct *vma;
>>>>> +    unsigned int insn;
>>>>>          if (kprobe_page_fault(regs, esr))
>>>>>            return 0;
>>>>> @@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>>        if (!vma)
>>>>>            goto lock_mmap;
>>>>>    +    if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
>>>>> +        goto continue_fault;
>>>>> +
>>>>> +    pagefault_disable();
>>>>> +
>>>>> +    if (get_user(insn, (unsigned int __user *) instruction_pointer(regs))) {
>>>>> +        pagefault_enable();
>>>>> +        goto continue_fault;
>>>>> +    }
>>>>> +
>>>>> +    if (aarch64_insn_is_class_atomic(insn)) {
>>>>> +        vm_flags = VM_WRITE;
>>>>> +        mm_flags |= FAULT_FLAG_WRITE;
>>>>> +    }
>>>>> +
>>>>> +    pagefault_enable();
>>>>> +
>>>>> +continue_fault:
>>>>>        if (!(vma->vm_flags & vm_flags)) {
>>>>>            vma_end_read(vma);
>>>>>            goto lock_mmap;
> 


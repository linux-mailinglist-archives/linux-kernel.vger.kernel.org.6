Return-Path: <linux-kernel+bounces-174124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A3D8C0A7B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E17C283B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E43147C8B;
	Thu,  9 May 2024 04:31:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551672747D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715229071; cv=none; b=PcVS7lTFssepRSCLK5W+n5ceswbfxohYnv2Jn+E0Iqa94Iaovk90y+XHBam2WXpEAdMVSOX+J0eV0ZN7Lrup6HaM5idBHYOWV2hTeQQO80AxiSJbP38z0VO2xbcxq2RRMxd/iqyjgq5CiwxnKtBstRuWL5cIHhFGDUCe6tGRq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715229071; c=relaxed/simple;
	bh=TpxYtSUcBODED4LmWGerMpUhYr89X6W95tvQhFIAnZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlAmTrz3qp9VudPP7KQ+rAluj9xr/E1ETz/FYd6lBCM5ycuh7K3AI0iM0guc54hObwwBitiKttQmFMEZGjjknF0QaCxef/BvPdZuNr76NpIn8xMvYOeTedtcfBtKItihUNzXOS5JdXmbBwZbsS14OAoflizYcOdgveZ+lyyil98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 426B6106F;
	Wed,  8 May 2024 21:31:34 -0700 (PDT)
Received: from [10.163.37.187] (unknown [10.163.37.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E8E3F6A8;
	Wed,  8 May 2024 21:31:05 -0700 (PDT)
Message-ID: <5e6158aa-09d3-4665-878e-17358aee10cb@arm.com>
Date: Thu, 9 May 2024 10:01:09 +0530
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
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <bb60d304-3341-472d-a4ee-d31b4754c39b@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/9/24 00:07, Yang Shi wrote:
> 
> 
> On 5/7/24 11:45 PM, Anshuman Khandual wrote:
>> Hello Yang,
>>
>> On 5/8/24 04:05, Yang Shi wrote:
>>> The atomic RMW instructions, for example, ldadd, actually does load +
>>> add + store in one instruction, it may trigger two page faults, the
>>> first fault is a read fault, the second fault is a write fault.
>> It may or it will definitely create two consecutive page faults. What
>> if the second write fault never came about. In that case an writable
>> page table entry would be created unnecessarily (or even wrongfully),
>> thus breaking the CoW.
>>
>> Just trying to understand, is the double page fault a possibility or
>> a certainty. Does that depend on architecture (please do provide some
>> links) or is it implementation defined.
> 
> Christopher helped answer some questions, I will skip those if I have nothing to add.
> 
> It is defined in ARM architecture reference manual, so it is not implementation defined.

Sure, but please replace the "may trigger" phrase above as appropriate.

> 
>>
>>> Some applications use atomic RMW instructions to populate memory, for
>>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
>> But why cannot normal store operation is sufficient for pre-touching
>> the heap memory, why read-modify-write (RMW) is required instead ?
> 
> Memory write is fine, but it depends on applications. For example, JVM may want to "permit use of memory concurrently with pretouch". So they chose use atomic instead of memory write.
> 
>>
>>> at launch time) between v18 and v22.
>> V18, V22 ?
> 
> v18/v19/v20/v21/v22
> 
>>
>>> But the double page fault has some problems:
>>>
>>> 1. Noticeable TLB overhead.  The kernel actually installs zero page with
>>>     readonly PTE for the read fault.  The write fault will trigger a
>>>     write-protection fault (CoW).  The CoW will allocate a new page and
>>>     make the PTE point to the new page, this needs TLB invalidations.  The
>>>     tlb invalidation and the mandatory memory barriers may incur
>>>     significant overhead, particularly on the machines with many cores.
>>>
>>> 2. Break up huge pages.  If THP is on the read fault will install huge
>>>     zero pages.  The later CoW will break up the huge page and allocate
>>>     base pages instead of huge page.  The applications have to rely on
>>>     khugepaged (kernel thread) to collapse huge pages asynchronously.
>>>     This also incurs noticeable performance penalty.
>>>
>>> 3. 512x page faults with huge page.  Due to #2, the applications have to
>>>     have page faults for every 4K area for the write, this makes the speed
>>>     up by using huge page actually gone.
>> The problems mentioned above are reasonable and expected.
>>   If the memory address has some valid data, it must have already reached there
>> via a previous write access, which would have caused initial CoW transition ?
>> If the memory address has no valid data to begin with, why even use RMW ?
>>
>>> So it sounds pointless to have two page faults since we know the memory
>>> will be definitely written very soon.  Forcing write fault for atomic RMW
>>> instruction makes some sense and it can solve the aforementioned problems:
>>>
>>> Firstly, it just allocates zero'ed page, no tlb invalidation and memory
>>> barriers anymore.
>>> Secondly, it can populate writable huge pages in the first place and
>>> don't break them up.  Just one page fault is needed for 2M area instrad
>>> of 512 faults and also save cpu time by not using khugepaged.
>>>
>>> A simple micro benchmark which populates 1G memory shows the number of
>>> page faults is reduced by half and the time spent by system is reduced
>>> by 60% on a VM running on Ampere Altra platform.
>>>
>>> And the benchmark for anonymous read fault on 1G memory, file read fault
>>> on 1G file (cold page cache and warm page cache) don't show noticeable
>>> regression.
>>>
>>> Some other architectures also have code inspection in page fault path,
>>> for example, SPARC and x86.
>> Okay, I was about to ask, but is not calling get_user() for all data
>> read page faults increase the cost for a hot code path in general for
>> some potential savings for a very specific use case. Not sure if that
>> is worth the trade-off.
> 
> I tested read fault latency (anonymous read fault and file read fault), I didn't see noticeable regression.

Could you please run a multi threaded application accessing one common
buffer while running these atomic operations. We just need to ensure
that pagefault_disable()-enable() window is not preventing concurrent
page faults and adding access latency to other threads.

> 
>>
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>   arch/arm64/include/asm/insn.h |  1 +
>>>   arch/arm64/mm/fault.c         | 19 +++++++++++++++++++
>>>   2 files changed, 20 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>>> index db1aeacd4cd9..5d5a3fbeecc0 100644
>>> --- a/arch/arm64/include/asm/insn.h
>>> +++ b/arch/arm64/include/asm/insn.h
>>> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)    \
>>>    * "-" means "don't care"
>>>    */
>>>   __AARCH64_INSN_FUNCS(class_branch_sys,    0x1c000000, 0x14000000)
>>> +__AARCH64_INSN_FUNCS(class_atomic,    0x3b200c00, 0x38200000)
>>>     __AARCH64_INSN_FUNCS(adr,    0x9F000000, 0x10000000)
>>>   __AARCH64_INSN_FUNCS(adrp,    0x9F000000, 0x90000000)
>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>> index 8251e2fea9c7..f7bceedf5ef3 100644
>>> --- a/arch/arm64/mm/fault.c
>>> +++ b/arch/arm64/mm/fault.c
>>> @@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>       unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>>>       unsigned long addr = untagged_addr(far);
>>>       struct vm_area_struct *vma;
>>> +    unsigned int insn;
>>>         if (kprobe_page_fault(regs, esr))
>>>           return 0;
>>> @@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>       if (!vma)
>>>           goto lock_mmap;
>>>   +    if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
>>> +        goto continue_fault;
>>> +
>>> +    pagefault_disable();
>>> +
>>> +    if (get_user(insn, (unsigned int __user *) instruction_pointer(regs))) {
>>> +        pagefault_enable();
>>> +        goto continue_fault;
>>> +    }
>>> +
>>> +    if (aarch64_insn_is_class_atomic(insn)) {
>>> +        vm_flags = VM_WRITE;
>>> +        mm_flags |= FAULT_FLAG_WRITE;
>>> +    }
>>> +
>>> +    pagefault_enable();
>>> +
>>> +continue_fault:
>>>       if (!(vma->vm_flags & vm_flags)) {
>>>           vma_end_read(vma);
>>>           goto lock_mmap;
> 


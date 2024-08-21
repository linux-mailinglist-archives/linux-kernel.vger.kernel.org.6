Return-Path: <linux-kernel+bounces-295421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7E959AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888E51C20AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B421898E1;
	Wed, 21 Aug 2024 11:33:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0371547D7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239982; cv=none; b=kcGK7alfAeDyRY1VS4HnT0gfRrHX5YUAOeJwl9RjGYs3M3t2nX4E8KoE57p/ygCBlqqjRDsPx4kAHIOpZDxxW1Vx7wR5qTqZOrxEJvkbhskFm8noRyNofFH5xholhSX3qHjRtDlFyi0g8806U+O/hpQbCemV5yWxkK1u3Agb8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239982; c=relaxed/simple;
	bh=A+d2IkqE/9lA8Osr70dM/EhXwjsM5X8bqhvEMbn2NBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLfY5/OEt7y4ErYh0BAwXgJ7VqNiiFF8x9evdc+2XB0DNWjs+yHOSjxFEz+X5Mgf9CwA57MnXitVXrqzWHKIgicMqR3iOgIy/RN4HmTQc9jYWj/x7BVUi377kN4ww42cCSJp+tt+iS/BMpHKoajEc6aQns/nD/fW5NtII7SFsD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64A4EDA7;
	Wed, 21 Aug 2024 04:33:25 -0700 (PDT)
Received: from [10.163.88.35] (unknown [10.163.88.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B42283F73B;
	Wed, 21 Aug 2024 04:32:55 -0700 (PDT)
Message-ID: <e2e29986-59fe-447a-81a1-fd06308fe5dd@arm.com>
Date: Wed, 21 Aug 2024 17:02:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
 <Zo2C4eXr5_9kifyO@arm.com>
 <cb0bd817-6948-4944-ab09-4ec2aba41cfa@os.amperecomputing.com>
 <Zo5S1JE8B912SHya@arm.com>
 <6167c4ce-fef0-4af4-a6a1-9fe7b2eb023d@os.amperecomputing.com>
 <ZpAZ39VQhxfNepWT@arm.com>
 <cf0777ce-52ed-46e4-b666-50a04d5025e0@os.amperecomputing.com>
 <ZsW_AtR-X_CqCMOW@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ZsW_AtR-X_CqCMOW@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/21/24 15:48, Catalin Marinas wrote:
> On Thu, Jul 11, 2024 at 11:17:51AM -0700, Yang Shi wrote:
>> On 7/11/24 10:43 AM, Catalin Marinas wrote:
>>> On Wed, Jul 10, 2024 at 11:43:18AM -0700, Yang Shi wrote:
>>>> On 7/10/24 2:22 AM, Catalin Marinas wrote:
>>>>>> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
>>>>>> index 642bdf908b22..d30265d424e4 100644
>>>>>> --- a/arch/arm64/mm/mmap.c
>>>>>> +++ b/arch/arm64/mm/mmap.c
>>>>>> @@ -19,7 +19,7 @@ static pgprot_t protection_map[16] __ro_after_init = {
>>>>>>    ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ [VM_WRITE]ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ = PAGE_READONLY,
>>>>>>    ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ [VM_WRITE | VM_READ]ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ = PAGE_READONLY,
>>>>>>    ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ /* PAGE_EXECONLY if Enhanced PAN */
>>>>>> - ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ [VM_EXEC]ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ = PAGE_READONLY_EXEC,
>>>>>> +ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ [VM_EXEC]ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ = PAGE_EXECONLY,
>>>>>>    ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ [VM_EXEC | VM_READ]ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ = PAGE_READONLY_EXEC,
>>>>>>    ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ [VM_EXEC | VM_WRITE]ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ = PAGE_READONLY_EXEC,
>>>>>>    ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ [VM_EXEC | VM_WRITE | VM_READ]ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ = PAGE_READONLY_EXEC,
>>>>> In theory you'd need to change the VM_SHARED | VM_EXEC entry as well.
>>>>> Otherwise it looks fine.
>>>> Thanks. I just ran the same benchmark. Ran the modified page_fault1_thread
>>>> (trigger read fault) in 100 iterations with 160 threads on 160 cores. This
>>>> should be the worst contention case and collected the max data (worst
>>>> latency). It shows the patch may incur ~30% overhead for exec-only case. The
>>>> overhead should just come from the permission fault.
>>>>
>>>>   ï¿½ï¿½ï¿½ Nï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ Minï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ Maxï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ Medianï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ Avg Stddev
>>>> x 100ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 163840ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 219083ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 184471ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 183262 12593.229
>>>> + 100ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 211198ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 285947ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 233608ï¿½ï¿½ï¿½ï¿½ 238819.98 15253.967
>>>> Difference at 95.0% confidence
>>>>   ï¿½ï¿½ ï¿½55558 +/- 3877
>>>>   ï¿½ï¿½ ï¿½30.3161% +/- 2.11555%
>>>>
>>>> This is a very extreme benchmark, I don't think any real life workload will
>>>> spend that much time (sys vs user) in page fault, particularly read fault.
>>>>
>>>> With my atomic fault benchmark (populate 1G memory with atomic instruction
>>>> then manipulate the value stored in the memory in 100 iterations so the user
>>>> time is much longer than sys time), I saw around 13% overhead on sys time
>>>> due to the permission fault, but no noticeable change for user and real
>>>> time.
>>> Thanks for running these tests.
>>>
>>>> So the permission fault does incur noticeable overhead for read fault on
>>>> exec-only, but it may be not that bad for real life workloads.
>>> So you are saying 3 faults is not that bad for real life workloads but
>>> the 2 faults behaviour we have currently is problematic for OpenJDK. For
>>> the OpenJDK case, I don't think the faulting is the main issue affecting
>>> run-time performance but, over a longer run (or with more iterations in
>>> this benchmark after the faulting in), you'd notice the breaking up of
>>> the initial THP pages.
>> I meant the extra permission fault for exec-only should be ok since the
>> current implementation can't force write fault for exec-only anyway. It does
>> incur noticeable overhead for read fault, but I'm not aware of any real life
>> workloads are sensitive to read fault. The benchmark is for a very extreme
>> worst case.
> I agree microbenchmarks like this are not realistic but I wouldn't be
> surprised if we hear of some large file mmap() read or very sparse
> arrays read being affected.
>
> Sorry, I forgot the details from the previous discussions. Are there any
> benchmarks that show OpenJDK performing badly _and_ what the improvement
> is with this patch? We should do similar comparison with the THP kernel
> fix. If the THP fix gets us close to the same level of improvement, I
> don't think we should bother with this patch.

Just for the note, I am working on replacing the hugezeropage with a THP;
I will be posting that out (after some testing) soon.



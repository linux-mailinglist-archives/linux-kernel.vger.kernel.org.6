Return-Path: <linux-kernel+bounces-333954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90497D06B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9DF1F244F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723D222075;
	Fri, 20 Sep 2024 04:05:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16084B676
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726805105; cv=none; b=US195m8ylqqwk8N5jvWm8+EPXagnADevWgayzeFIiOIUlzseCrmjt0LF6PXurZzXxvq9ZoVYyj1BnfmiAB1Ya/fuIkweROzYTWrRzsxv7qhILFnXoCSPoPUnVDUZneYbLijOINhbujqRwu7PRQig9GmX1iqvbYxqHnTHtp9gyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726805105; c=relaxed/simple;
	bh=j7IAgeead1rCr7krXrXLziXRV99UjnK+dVi7TPGlxhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGH/UjcAiBaQSlK7ZLtctCwKnnZ7L7jB2YEv/P+eePI9wy24umPFHNvsT5/+EBSVLRrWpfZ47l8SC8WEmVn8ACqDjRtGJPQlNs5S7R6hkL4KhmkicIqTL5EXLVukIr9bSBjyDqxHOUfLuepRqNy5hZfVGlA/OjrhGdLwYdhOur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76F65FEC;
	Thu, 19 Sep 2024 21:05:30 -0700 (PDT)
Received: from [10.162.43.22] (e116581.arm.com [10.162.43.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDAD23F71A;
	Thu, 19 Sep 2024 21:04:56 -0700 (PDT)
Message-ID: <c07d1917-a460-440a-b843-a6866a87d261@arm.com>
Date: Fri, 20 Sep 2024 09:34:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: Compute first_set_pte to eliminate evaluating
 redundant ranges
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
 anshuman.khandual@arm.com, hughd@google.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, baolin.wang@linux.alibaba.com, gshan@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240916110754.1236200-1-dev.jain@arm.com>
 <20240916110754.1236200-3-dev.jain@arm.com>
 <CAGsJ_4wuSqA8vzHCTH6rnVrppQ4k0FUcSu-=6HfAf+oYqz15bQ@mail.gmail.com>
 <8700274f-b521-444e-8d17-c06039a1376c@arm.com>
 <ffa62217-8452-41e4-b7ee-0fbd7d3a44c5@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ffa62217-8452-41e4-b7ee-0fbd7d3a44c5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/19/24 22:25, Ryan Roberts wrote:
> On 19/09/2024 09:40, Dev Jain wrote:
>> On 9/19/24 07:04, Barry Song wrote:
>>> On Mon, Sep 16, 2024 at 11:08 PM Dev Jain <dev.jain@arm.com> wrote:
>>>> For an mTHP allocation, we need to check, for every order, whether for
>>>> that order, we have enough number of contiguous PTEs empty. Instead of
>>>> iterating the while loop for every order, use some information, which
>>>> is the first set PTE found, from the previous iteration to eliminate
>>>> some cases. The key to understanding the correctness of the patch
>>>> is that the ranges we want to examine form a strictly decreasing
>>>> sequence of nested intervals.
>>> Could we include some benchmark data here, as suggested by Ryan in this thread?
>>>
>>> https://lore.kernel.org/linux-mm/58f91a56-890a-45d0-8b1f-47c4c70c9600@arm.com/
>> Can you please verify and get some numbers for the following program,
>> because if I am doing this correctly, it would be a regression :)
>> https://www.codedump.xyz/cpp/Zuvf8FwvRPH21UO2
> Some brief comments on the test code:
>
> - You don't need to enable/disable the top-level control. Regardless, I don't
> think this breaks the benchmark.
>
> - I think you have an off-by-1 in your for loop condition:
>
> for (unsigned long i = 1; (i * border) < size; ++i) {
>
> I think this needs to be:
>
> for (unsigned long i = 1; (i * border) <= size; ++i) {
>
> It just means that the final 32K block will get a single 32K mapping.
>
> - You're measuring the whole program; including mmap/munmap and
> enabling/disabling mTHP. It would be much better to just measure the loop that
> writes to each page after mTHP is enabled.
>
>
> I modified the code to iterate for 10 seconds and on each iteration, measure
> only the time spent in the interesting loop. Running on Apple M2 VM:
>
> Before the change:
>
> ubuntu@ubuntuvm:~/scan-pte$ sudo ./scan-pte
> Average: 0.070028 seconds per GB (iterations=98)
> ubuntu@ubuntuvm:~/scan-pte$ sudo ./scan-pte
> Average: 0.068495 seconds per GB (iterations=96)
> ubuntu@ubuntuvm:~/scan-pte$ sudo ./scan-pte
> Average: 0.070207 seconds per GB (iterations=93)
>
> After the change:
>
> ubuntu@ubuntuvm:~/scan-pte$ sudo ./scan-pte
> Average: 0.076923 seconds per GB (iterations=88)
> ubuntu@ubuntuvm:~/scan-pte$ sudo ./scan-pte
> Average: 0.072206 seconds per GB (iterations=96)
> ubuntu@ubuntuvm:~/scan-pte$ sudo ./scan-pte
> Average: 0.072397 seconds per GB (iterations=89)
>
> So this looks pretty clearly slower to me. So suggest we shouldn't take this patch.

Thanks for testing!

>
>
>> The program does this: disable THP completely -> mmap 1G VMA -> touch the last
>> page of a 32K sized boundary. That is, 0th till 32K/4K - 2 pages are
>> empty, while the 32K/4K - 1'th page is touched, and so on -> madvise
>> the entire VMA -> enable all THPs except 2M -> touch all pages.
>>
>> Therefore, we have 0 - 6 PTEs empty, 7th is filled, and so on. Eventually,
>> kernel will fall down to finding 4 contiguous PTEs empty and allocate
>> 4K * 4 = 16K mTHP.
>>
>> The result without the patches:
>>
>> real: 8.250s
>> user: 0.941s
>> sys: 7.077s
>>
>> real: 8.175s
>> user: 0.939s
>> sys: 7.021s
>>
>> With the patches:
>>
>> real: 8.584s
>> user: 1.089s
>> sys: 7.234s
>>
>> real: 8.429s
>> user: 0.954s
>> sys: 7.220s
> What HW did you measure this on? I'm guessing this is measuring multiple
> iterations, otherwise it looks extremely slow. If you were measuring on FVP, for
> example, that would not give representative performance numbers.

I measured with qemu.

>
> Thanks,
> Ryan
>
>> You can change the #iterations in the for loop to magnify this,
>> and the current code surprisingly wins.
>>
>>
>>>> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>>    mm/memory.c | 20 ++++++++++++++++++--
>>>>    1 file changed, 18 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 8bb1236de93c..e81c6abe09ce 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4633,10 +4633,11 @@ static struct folio *alloc_anon_folio(struct vm_fault
>>>> *vmf)
>>>>    {
>>>>           struct vm_area_struct *vma = vmf->vma;
>>>>    #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +       pte_t *first_set_pte = NULL, *align_pte, *pte;
>>>>           unsigned long orders;
>>>>           struct folio *folio;
>>>>           unsigned long addr;
>>>> -       pte_t *pte;
>>>> +       int max_empty;
>>>>           gfp_t gfp;
>>>>           int order;
>>>>
>>>> @@ -4671,8 +4672,23 @@ static struct folio *alloc_anon_folio(struct vm_fault
>>>> *vmf)
>>>>           order = highest_order(orders);
>>>>           while (orders) {
>>>>                   addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>>> -               if (pte_range_none(pte + pte_index(addr), 1 << order) == 1 <<
>>>> order)
>>>> +               align_pte = pte + pte_index(addr);
>>>> +
>>>> +               /* Range to be scanned known to be empty */
>>>> +               if (align_pte + (1 << order) <= first_set_pte)
>>>> +                       break;
>>>> +
>>>> +               /* Range to be scanned contains first_set_pte */
>>>> +               if (align_pte <= first_set_pte)
>>>> +                       goto repeat;
>>>> +
>>>> +               /* align_pte > first_set_pte, so need to check properly */
>>>> +               max_empty = pte_range_none(align_pte, 1 << order);
>>>> +               if (max_empty == 1 << order)
>>>>                           break;
>>>> +
>>>> +               first_set_pte = align_pte + max_empty;
>>>> +repeat:
>>>>                   order = next_order(&orders, order);
>>>>           }
>>>>
>>>> -- 
>>>> 2.30.2
>>>>
>>> Thanks
>>> barry


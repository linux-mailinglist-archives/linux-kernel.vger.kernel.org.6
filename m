Return-Path: <linux-kernel+bounces-235843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C791DA58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A743F1C21359
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764DC84D37;
	Mon,  1 Jul 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ix6nHoS+"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0A83A14
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823612; cv=none; b=UOA8iLB5WpPyG5ldlRgptY0T2h+BHE1cIbdgzfJOmRUNZO1PJYqlz2oEUFD8s+G0HpuMZFDHT/hzUoPOmgyxirh2Iw4TesX0Q8Lcg0V7t6rC3FvDqYzv7/GvNVMNUqHjP0morGtujdAcdV7z2tVIRKaX9iNkSGajuA3iSBq9Rpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823612; c=relaxed/simple;
	bh=NQ0ndZ/vTdR6qLhrOP1+1QFH0dvbytTmfuQhDcWArWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvArKbeb745WCRuPHSBfyRGRqWRvBzme0+e2ItosfY5RX+PcaHQilVB9IdY4e1aDchwRp6h5s2MuNzQvejU2jXcI0j7wsKEOtVhmKpM0t2vQhvzzwcqamrX5lzgrBuwXkUyQccaJIlyIE2Rh/9DWtSld0He7oyNWZnu7U/IgJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ix6nHoS+; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719823607; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Sw5IgswMEuJV2XoSVcM0OJziGgFmvuhn48aAmj906Do=;
	b=Ix6nHoS+Yt/Ssxt5wvbcrOJgbP/JwJUVmamsHAcUP4iQwh4yBEStscgU3t+2UQqwWffYLiXJRGJWKBZ+TUAlx3pbbDQxzDV8Byaze32cQg28oe0EdHoXuRRuSrSOUrbTOQScsvYYsRjGmZ9j63/Zy8cgh0QLIbza1tAQCJ20IRs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9c7l2Y_1719823605;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9c7l2Y_1719823605)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 16:46:46 +0800
Message-ID: <03acea8b-b0d9-403f-8dc8-1f32ee02153e@linux.alibaba.com>
Date: Mon, 1 Jul 2024 16:46:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: Ryan Roberts <ryan.roberts@arm.com>, Bang Li <libang.li@antgroup.com>,
 hughd@google.com, akpm@linux-foundation.org
Cc: david@redhat.com, wangkefeng.wang@huawei.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <4b38db15-0716-4ffb-a38b-bd6250eb93da@arm.com>
 <4d54880e-03f4-460a-94b9-e21b8ad13119@linux.alibaba.com>
 <516aa6b3-617c-4642-b12b-0c5f5b33d1c9@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <516aa6b3-617c-4642-b12b-0c5f5b33d1c9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/1 16:40, Ryan Roberts wrote:
> On 01/07/2024 09:33, Baolin Wang wrote:
>>
>>
>> On 2024/7/1 15:55, Ryan Roberts wrote:
>>> On 28/06/2024 11:49, Bang Li wrote:
>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>>> anonymous shmem"), we can configure different policies through
>>>> the multi-size THP sysfs interface for anonymous shmem. But
>>>> currently "THPeligible" indicates only whether the mapping is
>>>> eligible for allocating THP-pages as well as the THP is PMD
>>>> mappable or not for anonymous shmem, we need to support semantics
>>>> for mTHP with anonymous shmem similar to those for mTHP with
>>>> anonymous memory.
>>>>
>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>>>> ---
>>>>    fs/proc/task_mmu.c      | 10 +++++++---
>>>>    include/linux/huge_mm.h | 11 +++++++++++
>>>>    mm/shmem.c              |  9 +--------
>>>>    3 files changed, 19 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index 93fb2c61b154..09b5db356886 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>>>>    {
>>>>        struct vm_area_struct *vma = v;
>>>>        struct mem_size_stats mss = {};
>>>> +    bool thp_eligible;
>>>>          smap_gather_stats(vma, &mss, 0);
>>>>    @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
>>>>          __show_smap(m, &mss, false);
>>>>    -    seq_printf(m, "THPeligible:    %8u\n",
>>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>>>> +    thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
>>>> +    if (vma_is_anon_shmem(vma))
>>>> +        thp_eligible = !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>> +                            vma, vma->vm_pgoff, thp_eligible);
>>>
>>> Afraid I haven't been following the shmem mTHP support work as much as I would
>>> have liked, but is there a reason why we need a separate function for shmem?
>>
>> Since shmem_allowable_huge_orders() only uses shmem specific logic to determine
>> if huge orders are allowable, there is no need to complicate the
>> thp_vma_allowable_orders() function by adding more shmem related logic, making
>> it more bloated. In my view, providing a dedicated helper
>> shmem_allowable_huge_orders(), specifically for shmem, simplifies the logic.
> 
> My point was really that a single interface (thp_vma_allowable_orders) should be
> used to get this information. I have no strong opinon on how the implementation
> of that interface looks. What you suggest below seems perfectly reasonable to me.
> 
>>
>> IIUC, I agree with David's suggestion that the shmem_allowable_huge_orders()
>> helper function could be used in thp_vma_allowable_orders() to support shmem
>> mTHP. Something like:
> 
> I hadn't seen David's suggestion until after I sent my mail. But I think we are > both suggesting the same thing.

OK. Great :)


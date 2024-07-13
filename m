Return-Path: <linux-kernel+bounces-251329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AFC93039D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF95BB21F62
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFBA171A7;
	Sat, 13 Jul 2024 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KplZNKmr"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CA23AD
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720843290; cv=none; b=Mx9CRONxgPx8Fe7TT+GiK9/IXiE5gVtwYALUnaYZ6C0xNC7jrZcTvXQylBiP6vUrAqZO9kHPXpC7H5HJda5j25nDwtebABYz6rHeYvwYne4HaBeNYqACpWMEsHBUhOc5OoeRS6K/BCAw6Dreex3wXt5sWHe9Pp3hHSGEpeSnqew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720843290; c=relaxed/simple;
	bh=r8Yhpjr5NboO/zGxXvko/WtS4lAmgEOW3o68UTjGljc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9ZUfgmG+H/i5L1QqowKR9on+RIFy+RSRPRKoU3dKPF6bCZGLRKZ0LA6wbDwxv7HqTN/i/tyWd4kMk2AD+yIZKR0U3Uwjv3BNOwEY5cg0q09lXyqhIILZ5HK4WfGu0jS2aCuwunYi/VRbNv7aWOzK7FVwNrYF/+7jSuVM0lwjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KplZNKmr; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720843280; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l1zz8KU0ZreEJ+A1Pk7yXjuLTLJQY3EYOHYwky64JnU=;
	b=KplZNKmrG+nXPNI+Wy5ADQ/yOyOQq9vatrxmyfZODjpcC0EDo/Pok5Cwv8IWRRfsmSwxR3lfKTsj09UWDBepPjtJp8Yu0f0K0au2p82QJJ1EBzhq0ZaEdOcnfvaXP81cGWT7AiBNV4itTX9i7BiynwHurcY8XtRYlPTntdf2UCU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAQ.UFK_1720843278;
Received: from 30.120.178.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAQ.UFK_1720843278)
          by smtp.aliyun-inc.com;
          Sat, 13 Jul 2024 12:01:19 +0800
Message-ID: <b11d6006-1efb-4329-baa0-75799935e019@linux.alibaba.com>
Date: Sat, 13 Jul 2024 12:01:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: Avoid PMD-size page cache if needed
To: David Hildenbrand <david@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, william.kucharski@oracle.com,
 ryan.roberts@arm.com, shan.gavin@gmail.com
References: <20240711104840.200573-1-gshan@redhat.com>
 <ZpBEwEn3swH7IFbI@casper.infradead.org>
 <f58433ee-7217-4f9e-91ba-c29f95cd56b0@redhat.com>
 <63a0364b-a2e0-48c2-b255-e976112deeb1@redhat.com>
 <df83a218-e2e5-496e-999a-e446a7d0b383@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <df83a218-e2e5-496e-999a-e446a7d0b383@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/13 09:03, David Hildenbrand wrote:
> On 12.07.24 07:39, Gavin Shan wrote:
>> On 7/12/24 7:03 AM, David Hildenbrand wrote:
>>> On 11.07.24 22:46, Matthew Wilcox wrote:
>>>> On Thu, Jul 11, 2024 at 08:48:40PM +1000, Gavin Shan wrote:
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -136,7 +136,8 @@ unsigned long __thp_vma_allowable_orders(struct 
>>>>> vm_area_struct *vma,
>>>>>            while (orders) {
>>>>>                addr = vma->vm_end - (PAGE_SIZE << order);
>>>>> -            if (thp_vma_suitable_order(vma, addr, order))
>>>>> +            if (!(vma->vm_file && order > MAX_PAGECACHE_ORDER) &&
>>>>> +                thp_vma_suitable_order(vma, addr, order))
>>>>>                    break;
>>>>
>>>> Why does 'orders' even contain potential orders that are larger than
>>>> MAX_PAGECACHE_ORDER?
>>>>
>>>> We do this at the top:
>>>>
>>>>           orders &= vma_is_anonymous(vma) ?
>>>>                           THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
>>>>
>>>> include/linux/huge_mm.h:#define THP_ORDERS_ALL_FILE     
>>>> (BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>>>
>>>> ... and that seems very wrong.  We support all kinds of orders for
>>>> files, not just PMD order.  We don't support PUD order at all.
>>>>
>>>> What the hell is going on here?
>>>
>>> yes, that's just absolutely confusing. I mentioned it to Ryan lately 
>>> that we should clean that up (I wanted to look into that, but am 
>>> happy if someone else can help).
>>>
>>> There should likely be different defines for
>>>
>>> DAX (PMD|PUD)
>>>
>>> SHMEM (PMD) -- but soon more. Not sure if we want separate ANON_SHMEM 
>>> for the time being. Hm. But shmem is already handles separately, so 
>>> maybe we can just ignore shmem here.
>>>
>>> PAGECACHE (1 .. MAX_PAGECACHE_ORDER)
>>>
>>> ? But it's still unclear to me.
>>>
>>> At least DAX must stay special I think, and PAGECACHE should be 
>>> capped at MAX_PAGECACHE_ORDER.
>>>
>>
>> David, I can help to clean it up. Could you please help to confirm the 
>> following
> 
> Thanks!
> 
>> changes are exactly what you're suggesting? Hopefully, there are 
>> nothing I've missed.
>> The original issue can be fixed by the changes. With the changes 
>> applied, madvise(MADV_COLLAPSE)
>> returns with errno -22 in the test program.
>>
>> The fix tag needs to adjusted either.
>>
>> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 2aa986a5cd1b..45909efb0ef0 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -74,7 +74,12 @@ extern struct kobj_attribute shmem_enabled_attr;
>>    /*
>>     * Mask of all large folio orders supported for file THP.
>>     */
>> -#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
> 
> DAX doesn't have any MAX_PAGECACHE_ORDER restrictions (like hugetlb). So 
> this should be
> 
> /*
>   * FSDAX never splits folios, so the MAX_PAGECACHE_ORDER limit does not
>   * apply here.
>   */
> THP_ORDERS_ALL_FILE_DAX ((BIT(PMD_ORDER) | BIT(PUD_ORDER))
> 
> Something like that
> 
>> +#define THP_ORDERS_ALL_FILE_DAX                \
>> +       ((BIT(PMD_ORDER) | BIT(PUD_ORDER)) & (BIT(MAX_PAGECACHE_ORDER 
>> + 1) - 1))
>> +#define THP_ORDERS_ALL_FILE_DEFAULT    \
>> +       ((BIT(MAX_PAGECACHE_ORDER + 1) - 1) & ~BIT(0))
>> +#define THP_ORDERS_ALL_FILE            \
>> +       (THP_ORDERS_ALL_FILE_DAX | THP_ORDERS_ALL_FILE_DEFAULT)
> 
> Maybe we can get rid of THP_ORDERS_ALL_FILE (to prevent abuse) and fixup
> THP_ORDERS_ALL instead.
> 
>>    /*
>>     * Mask of all large folio orders supported for THP.
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2120f7478e55..4690f33afaa6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -88,9 +88,17 @@ unsigned long __thp_vma_allowable_orders(struct 
>> vm_area_struct *vma,
>>           bool smaps = tva_flags & TVA_SMAPS;
>>           bool in_pf = tva_flags & TVA_IN_PF;
>>           bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
>> +       unsigned long supported_orders;
>> +
>>           /* Check the intersection of requested and supported orders. */
>> -       orders &= vma_is_anonymous(vma) ?
>> -                       THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
>> +       if (vma_is_anonymous(vma))
>> +               supported_orders = THP_ORDERS_ALL_ANON;
>> +       else if (vma_is_dax(vma))
>> +               supported_orders = THP_ORDERS_ALL_FILE_DAX;
>> +       else
>> +               supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
> 
> This is what I had in mind.
> 
> But, do we have to special-case shmem as well or will that be handled 
> correctly?

For anonymous shmem, it is now same as anonymous THP, which can utilize 
THP_ORDERS_ALL_ANON. For tmpfs, we currently only support PMD-sized THP 
(will support more larger orders in the future). Therefore, I think we 
can reuse THP_ORDERS_ALL_ANON for shmem now:

if (vma_is_anonymous(vma) || shmem_file(vma->vm_file)))
	supported_orders = THP_ORDERS_ALL_ANON;
......



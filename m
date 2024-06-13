Return-Path: <linux-kernel+bounces-212420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9155905FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FC628436C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479BB646;
	Thu, 13 Jun 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OreWM1oc"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2A652
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240462; cv=none; b=ceWluvJ4WAYHtJ2BqAP+SzHOHK1XVQ7x3QQ20txb0c2pMMPjOQ/k45r99tAi093ujh+WHr78Z6+1w09QcYwhbCXOcIvF+j6rXTTUOax8seP1Ol5sUdrrsjBVvyO3Ds4JE8pNz1ax9jm2iQW7v1z8l2mEaUO0Kzu/Yzgrl5LKiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240462; c=relaxed/simple;
	bh=2dVZ2VKYYxFiE5EetqZFnF70kjNdVQwXc8iG8IoqYYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAosvp23Kks0GD7cGTFbwL3tCiVHOz6LVQH2wQeJrKItzRcMc9IISq330N3xsP8Vjqk+BJHsKdw0QD2/nGNa3TFjJT/QXFiwzyz3/Q+h0b7NT5UcmXXYXOco+b2C19r/E6XMjiMndhNv0wT1u5bfcpMnkV7/X+ziuIM+/7bPxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OreWM1oc; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718240451; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aAWlJ3M4tOKjB01RLyyTgaKsXtqHNDmd0vljFJx8Ors=;
	b=OreWM1oc/Kwb/qtWhjMSHV5eRW4nJ5Tx9CcDr74wKMJU6tl+K2jrsIhdFLbZXFX0jIW8T6J4ZCySj3JBCCfk5WthuSX2umL2+XczdoV09vWtgPBg+gOunY90iyposlHK43jPe6Umnll5MAkCCCOCYdZBXApCRf2a0cvY1IWrgO4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8M4Sn5_1718240449;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8M4Sn5_1718240449)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 09:00:50 +0800
Message-ID: <d3580388-6ecb-428a-993f-b4afa811ca1b@linux.alibaba.com>
Date: Thu, 13 Jun 2024 09:00:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] mm: shmem: add mTHP counters for anonymous shmem
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
 <e60808c6-5d50-42c4-a736-f1f417f85327@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <e60808c6-5d50-42c4-a736-f1f417f85327@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/12 21:46, Kefeng Wang wrote:
> 
> 
> On 2024/6/11 18:11, Baolin Wang wrote:
>> Add mTHP counters for anonymous shmem.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/huge_mm.h |  3 +++
>>   mm/huge_memory.c        |  6 ++++++
>>   mm/shmem.c              | 18 +++++++++++++++---
>>   3 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 909cfc67521d..212cca384d7e 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -281,6 +281,9 @@ enum mthp_stat_item {
>>       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>>       MTHP_STAT_SWPOUT,
>>       MTHP_STAT_SWPOUT_FALLBACK,
>> +    MTHP_STAT_FILE_ALLOC,
>> +    MTHP_STAT_FILE_FALLBACK,
>> +    MTHP_STAT_FILE_FALLBACK_CHARGE,
>>       __MTHP_STAT_COUNT
>>   };
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 1360a1903b66..3fbcd77f5957 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -555,6 +555,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, 
>> MTHP_STAT_ANON_FAULT_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, 
>> MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>   DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>>   DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
>> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
>> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, 
>> MTHP_STAT_FILE_FALLBACK_CHARGE);
>>   static struct attribute *stats_attrs[] = {
>>       &anon_fault_alloc_attr.attr,
>> @@ -562,6 +565,9 @@ static struct attribute *stats_attrs[] = {
>>       &anon_fault_fallback_charge_attr.attr,
>>       &swpout_attr.attr,
>>       &swpout_fallback_attr.attr,
>> +    &file_alloc_attr.attr,
>> +    &file_fallback_attr.attr,
>> +    &file_fallback_charge_attr.attr,
>>       NULL,
>>   };
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index f5469c357be6..99bd3c34f0fb 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1773,6 +1773,9 @@ static struct folio 
>> *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>               if (pages == HPAGE_PMD_NR)
>>                   count_vm_event(THP_FILE_FALLBACK);
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +            count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
>> +#endif
>>               order = next_order(&suitable_orders, order);
>>           }
>>       } else {
>> @@ -1792,9 +1795,15 @@ static struct folio 
>> *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>           if (xa_find(&mapping->i_pages, &index,
>>                   index + pages - 1, XA_PRESENT)) {
>>               error = -EEXIST;
>> -        } else if (pages == HPAGE_PMD_NR) {
>> -            count_vm_event(THP_FILE_FALLBACK);
>> -            count_vm_event(THP_FILE_FALLBACK_CHARGE);
>> +        } else if (pages > 1) {
>> +            if (pages == HPAGE_PMD_NR) {
>> +                count_vm_event(THP_FILE_FALLBACK);
>> +                count_vm_event(THP_FILE_FALLBACK_CHARGE);
>> +            }
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +            count_mthp_stat(folio_order(folio), 
>> MTHP_STAT_FILE_FALLBACK);
>> +            count_mthp_stat(folio_order(folio), 
>> MTHP_STAT_FILE_FALLBACK_CHARGE);
> 
> pages > 1, we have correct order, count_mthp_stat(order, MTHP_XXX) ?

Yes, I can use 'order' instead if a new version is needed.


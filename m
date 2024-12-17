Return-Path: <linux-kernel+bounces-448637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB19F434C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD391680D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D7150994;
	Tue, 17 Dec 2024 06:09:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A9815380A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415747; cv=none; b=BXhNBwQulc6YhmGke/eqiFwR+ciAoMQMivo5K7qsj7QXk2zJuBFeUqRgKj+9JvwoOxyBtRxavN1Xh1UkYeW8a+83dxt8tD3JZqAsNWCKja+Z/SM6+EV12M0Gykem0ce3Ml9DNDH0RRD4sqHvpSEfh4tfkrEcUu7fOrhaWYVxVvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415747; c=relaxed/simple;
	bh=DqA4WM89z1WrORq9X4f4WttFGExmUEogLWQ1fM1DZiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEomD3MpKEmwgANkon1G+l1tIhgnQCKLzuAjiRbPS8H0VUiWOaLjicP/u0HiRg91lFHeZg6tcubf69hh8wN0/W4kFer/kLT0ULixviES7LmXzO/YypMI9b9WthBXlhHlSEZmp/joyyC7tup7XOz0d5vokhNFgI85rxRQdb+IjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62CBC1007;
	Mon, 16 Dec 2024 22:09:32 -0800 (PST)
Received: from [10.162.40.67] (K4MQJ0H1H2.blr.arm.com [10.162.40.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA66B3F528;
	Mon, 16 Dec 2024 22:08:54 -0800 (PST)
Message-ID: <2beb19c5-ead3-4934-81f6-00dd48e9156b@arm.com>
Date: Tue, 17 Dec 2024 11:38:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] khugepaged: Generalize alloc_charge_folio()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 david@redhat.com, willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-3-dev.jain@arm.com>
 <53073c25-a5c4-4292-832d-10e13cd53aa5@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <53073c25-a5c4-4292-832d-10e13cd53aa5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 17/12/24 8:21 am, Baolin Wang wrote:
>
>
> On 2024/12/17 00:50, Dev Jain wrote:
>> Pass order to alloc_charge_folio() and update mTHP statistics.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   include/linux/huge_mm.h |  2 ++
>>   mm/huge_memory.c        |  4 ++++
>>   mm/khugepaged.c         | 13 +++++++++----
>>   3 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 93e509b6c00e..8b6d0fed99b3 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -119,6 +119,8 @@ enum mthp_stat_item {
>>       MTHP_STAT_ANON_FAULT_ALLOC,
>>       MTHP_STAT_ANON_FAULT_FALLBACK,
>>       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>> +    MTHP_STAT_ANON_COLLAPSE_ALLOC,
>> +    MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED,
>>       MTHP_STAT_ZSWPOUT,
>>       MTHP_STAT_SWPIN,
>>       MTHP_STAT_SWPIN_FALLBACK,
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2da5520bfe24..2e582fad4c77 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -615,6 +615,8 @@ static struct kobj_attribute _name##_attr = 
>> __ATTR_RO(_name)
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, 
>> MTHP_STAT_ANON_FAULT_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, 
>> MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>> +DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc, 
>> MTHP_STAT_ANON_COLLAPSE_ALLOC);
>> +DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc_failed, 
>> MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
>>   DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>>   DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>>   DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
>> @@ -636,6 +638,8 @@ static struct attribute *anon_stats_attrs[] = {
>>       &anon_fault_alloc_attr.attr,
>>       &anon_fault_fallback_attr.attr,
>>       &anon_fault_fallback_charge_attr.attr,
>> +    &anon_collapse_alloc_attr.attr,
>> +    &anon_collapse_alloc_failed_attr.attr,
>>   #ifndef CONFIG_SHMEM
>>       &zswpout_attr.attr,
>>       &swpin_attr.attr,
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 95643e6e5f31..02cd424b8e48 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1073,21 +1073,26 @@ static int __collapse_huge_page_swapin(struct 
>> mm_struct *mm,
>>   }
>>     static int alloc_charge_folio(struct folio **foliop, struct 
>> mm_struct *mm,
>> -                  struct collapse_control *cc)
>> +                  int order, struct collapse_control *cc)
>>   {
>>       gfp_t gfp = (cc->is_khugepaged ? 
>> alloc_hugepage_khugepaged_gfpmask() :
>>                GFP_TRANSHUGE);
>>       int node = hpage_collapse_find_target_node(cc);
>>       struct folio *folio;
>>   -    folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, 
>> &cc->alloc_nmask);
>> +    folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>>       if (!folio) {
>>           *foliop = NULL;
>>           count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>> +        if (order != HPAGE_PMD_ORDER)
>> +            count_mthp_stat(order, 
>> MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
>>           return SCAN_ALLOC_HUGE_PAGE_FAIL;
>>       }
>>         count_vm_event(THP_COLLAPSE_ALLOC);
>> +    if (order != HPAGE_PMD_ORDER)
>> +        count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC);
>
> File collapse will also call alloc_charge_folio() to allocate THP, so 
> using term '_ANON_' is not suitable for both anon and file collapse.

But currently file collapse will only allocate a PMD-folio, and I have 
extended to mTHP only for anon, so it makes sense? Although
I get your point in general...


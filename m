Return-Path: <linux-kernel+bounces-448889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B991B9F46D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B4188DC42
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C5A1DDC05;
	Tue, 17 Dec 2024 09:07:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49548537F8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426434; cv=none; b=PIlZA8whcDjCI9YQ1mPx6slNi/rbIlnT8gIrxCQfRAFnramvF0ynlecU0ik9j2EbDNIBXfrz99t/vJ7czaY+HNdeBiuH8UZ6m5fj60M3AH91JzBdifUQGCYwyBqvj5lGegv74K0ozkLIGcax0aXYkDDD1kMKzX5Fq1UmSiwVpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426434; c=relaxed/simple;
	bh=qHjGpIK2CqJHzzexrluiUCs2W+xuhwGU1h/rN9xwFUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p23MdWPSvGwI0JxfqVn4rhN+k0p3BulTwHy/f7D+lNL9fdHZJLDa1E4BJx4ey97P/rNkhlTWvAD4WrSdY0KLwY80V1soePOECdrIirM24v22/Jqcvop1eGn58Wtwzm20A0F4hCoHiduJUbsSSAlMYTlpAMS3dQQlABpTXwCKGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FC911007;
	Tue, 17 Dec 2024 01:07:39 -0800 (PST)
Received: from [10.162.40.67] (K4MQJ0H1H2.blr.arm.com [10.162.40.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 245743F720;
	Tue, 17 Dec 2024 01:07:01 -0800 (PST)
Message-ID: <7834d1ef-bb82-41ed-9453-b49790ee8b5b@arm.com>
Date: Tue, 17 Dec 2024 14:36:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] khugepaged: Generalize alloc_charge_folio()
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 david@redhat.com, willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
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
 <46939efe-cf79-4dcd-9e47-9340956feb03@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <46939efe-cf79-4dcd-9e47-9340956feb03@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/12/24 12:23 pm, Ryan Roberts wrote:
> On 16/12/2024 16:50, Dev Jain wrote:
>> Pass order to alloc_charge_folio() and update mTHP statistics.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   include/linux/huge_mm.h |  2 ++
>>   mm/huge_memory.c        |  4 ++++
>>   mm/khugepaged.c         | 13 +++++++++----
>>   3 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 93e509b6c00e..8b6d0fed99b3 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -119,6 +119,8 @@ enum mthp_stat_item {
>>   	MTHP_STAT_ANON_FAULT_ALLOC,
>>   	MTHP_STAT_ANON_FAULT_FALLBACK,
>>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>> +	MTHP_STAT_ANON_COLLAPSE_ALLOC,
>> +	MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED,
>>   	MTHP_STAT_ZSWPOUT,
>>   	MTHP_STAT_SWPIN,
>>   	MTHP_STAT_SWPIN_FALLBACK,
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2da5520bfe24..2e582fad4c77 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -615,6 +615,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>> +DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc, MTHP_STAT_ANON_COLLAPSE_ALLOC);
>> +DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc_failed, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
>>   DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>>   DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>>   DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
>> @@ -636,6 +638,8 @@ static struct attribute *anon_stats_attrs[] = {
>>   	&anon_fault_alloc_attr.attr,
>>   	&anon_fault_fallback_attr.attr,
>>   	&anon_fault_fallback_charge_attr.attr,
>> +	&anon_collapse_alloc_attr.attr,
>> +	&anon_collapse_alloc_failed_attr.attr,
>>   #ifndef CONFIG_SHMEM
>>   	&zswpout_attr.attr,
>>   	&swpin_attr.attr,
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 95643e6e5f31..02cd424b8e48 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1073,21 +1073,26 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>>   }
>>   
>>   static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>> -			      struct collapse_control *cc)
>> +			      int order, struct collapse_control *cc)
>>   {
>>   	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>>   		     GFP_TRANSHUGE);
>>   	int node = hpage_collapse_find_target_node(cc);
>>   	struct folio *folio;
>>   
>> -	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
>> +	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>>   	if (!folio) {
>>   		*foliop = NULL;
>>   		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>> +		if (order != HPAGE_PMD_ORDER)
>> +			count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
> Bug? We should be calling count_mthp_stat() for all orders, but only calling
> count_vm_event(THP_*) for PMD_ORDER, as per pattern laid out by other mTHP stats.

Ah okay.

>
> The aim is for existing THP stats (which are implicitly only counting PMD-sized
> THP) to continue only to count PMD-sized THP. It's a userspace ABI and we were
> scared of the potential to break things if we changed the existing counters'
> semantics.
>
>>   		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>>   	}
>>   
>>   	count_vm_event(THP_COLLAPSE_ALLOC);
>> +	if (order != HPAGE_PMD_ORDER)
>> +		count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC);
> Same problem.
>
> Also, I agree with Baolin that we don't want "anon" in the title. This is a
> generic path used for file-backed memory. So once you fix the bug, the new stats
> will also be counting the file-backed memory too (although for now, only for
> PMD_ORDER).

Sure.

>> +
>>   	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
>>   		folio_put(folio);
>>   		*foliop = NULL;
>> @@ -1124,7 +1129,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>   	 */
>>   	mmap_read_unlock(mm);
>>   
>> -	result = alloc_charge_folio(&folio, mm, cc);
>> +	result = alloc_charge_folio(&folio, mm, order, cc);
> Where is order coming from? I'm guessing that's added later, so this patch won't
> compile on it's own? Perhaps HPAGE_PMD_ORDER for now?

Okay yes, this won't compile on its own. I'll ensure sequential buildability next time.

>
>>   	if (result != SCAN_SUCCEED)
>>   		goto out_nolock;
>>   
>> @@ -1850,7 +1855,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>>   	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
>>   	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>>   
>> -	result = alloc_charge_folio(&new_folio, mm, cc);
>> +	result = alloc_charge_folio(&new_folio, mm, HPAGE_PMD_ORDER, cc);
>>   	if (result != SCAN_SUCCEED)
>>   		goto out;
>>   
>


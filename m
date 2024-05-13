Return-Path: <linux-kernel+bounces-177192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3DA8C3B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157D71F21472
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F024214659C;
	Mon, 13 May 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DPt59pkM"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C84C81
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715581079; cv=none; b=cXJ0d3BhC/prmIBKQ0DV1Sunl9hnNoqkzqr3c0/r2mnhd1TmhlZ12rHXjda2LuBylnDrHcpLESKcnG+s2QgEIHFb07IjqNXZkomaodXU07WaqNQ5hDY0LSJpBXfjVr+Lw0qR1uJYXkaT6RCMMA2yFsY5kmHO8K+W1JXo/shdaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715581079; c=relaxed/simple;
	bh=xVUKmGb6QglYt63bNyR1uuMGJnTZs6cMx5FUQTxsqcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHk4ZCtzVM+wegBcPSFYWbZKpujzh7U71F1fHCGQwQPZd9ohNtHgQDp1FmHhEv4XTxQRG1AYSI9E7iHXq0+Py2N+l9fMq/mcGopqkK4GqHn7rjtFQO04+Pu7J/TovNPgHta8b5TI0z3syrXVVtulA0krWg0aSfTEmmbzCrKjAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DPt59pkM; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0d7b3dc-a955-45e2-a39d-a2e027480e53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715581074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTzXHgcN/78bzWT5jsvUxiYaU7ZcHofB3YgYoaDgwrE=;
	b=DPt59pkMD7wKr6zggyktQX0VSsBOPmTau18lCAfLQ9tLCeYYml9wT+bfmck1uoui805OH6
	GcQ/T9zrbVbwIm0j94EBm1TzrxqWxagKKIwnSCudMsB7TOCrJgiO18894hatcewo+21OEF
	KAz36oogpU23s6Q8m105sPDmcrpWjw8=
Date: Mon, 13 May 2024 14:17:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mm/ksm: fix ksm_zero_pages accounting
To: xu xin <xu.xin.sc@gmail.com>
Cc: aarcange@redhat.com, akpm@linux-foundation.org, david@redhat.com,
 hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 shr@devkernel.io, xu.xin16@zte.com.cn, zhouchengming@bytedance.com,
 si.hao@zte.com.cn
References: <20240513-b4-ksm-counters-v2-2-f2520183a8ca@linux.dev>
 <20240513060029.651050-1-xu.xin16@zte.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240513060029.651050-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/13 14:00, xu xin wrote:
>> We normally ksm_zero_pages++ in ksmd when page is merged with zero page,
>> but ksm_zero_pages-- is done from page tables side, which can't protected
>> by the ksmd mutex.
> 
>   "cant protected" -> "can't be protected".

Right, will fix.

> 
>   But It's better to say  "where there is no any accessing protection of
>   ksm_zero_pages" because ksmd mutex is to protect the flag of ksm_run, not to
>   protect the counters of KSM.

Ah, I thought the introduced ksm_zero_pages counters were protected by ksmd mutex
like all other ksm counters, no? But the difference with those ksm counters is
that ksm_zero_pages could be changed by the page table side operations, which
can't take ksmd mutex, this is the reason why we need to use atomic variables.

Thanks.

> 
> 
>   Anyway, The following code looks OK to me.
>>
>> So we can read very exceptional value of ksm_zero_pages in rare cases,
>> such as -1, which is very confusing to users.
>>
>> Fix it by changing to use atomic_long_t, and the same case with the
>> mm->ksm_zero_pages.
>>
>> Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
>> Fixes: 6080d19f0704 ("ksm: add ksm zero pages for each process")
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
>> ---
>>  fs/proc/base.c           |  2 +-
>>  include/linux/ksm.h      | 17 ++++++++++++++---
>>  include/linux/mm_types.h |  2 +-
>>  mm/ksm.c                 | 11 +++++------
>>  4 files changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 18550c071d71..72a1acd03675 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -3214,7 +3214,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>>  	mm = get_task_mm(task);
>>  	if (mm) {
>>  		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
>> -		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
>> +		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
>>  		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>>  		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>>  		mmput(mm);
>> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>> index 52c63a9c5a9c..11690dacd986 100644
>> --- a/include/linux/ksm.h
>> +++ b/include/linux/ksm.h
>> @@ -33,16 +33,27 @@ void __ksm_exit(struct mm_struct *mm);
>>   */
>>  #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
>>  
>> -extern unsigned long ksm_zero_pages;
>> +extern atomic_long_t ksm_zero_pages;
>> +
>> +static inline void ksm_map_zero_page(struct mm_struct *mm)
>> +{
>> +	atomic_long_inc(&ksm_zero_pages);
>> +	atomic_long_inc(&mm->ksm_zero_pages);
>> +}
>>  
>>  static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
>>  {
>>  	if (is_ksm_zero_pte(pte)) {
>> -		ksm_zero_pages--;
>> -		mm->ksm_zero_pages--;
>> +		atomic_long_dec(&ksm_zero_pages);
>> +		atomic_long_dec(&mm->ksm_zero_pages);
>>  	}
>>  }
>>  
>> +static inline long mm_ksm_zero_pages(struct mm_struct *mm)
>> +{
>> +	return atomic_long_read(&mm->ksm_zero_pages);
>> +}
>> +
>>  static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>>  {
>>  	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 24323c7d0bd4..af3a0256fa93 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -985,7 +985,7 @@ struct mm_struct {
>>  		 * Represent how many empty pages are merged with kernel zero
>>  		 * pages when enabling KSM use_zero_pages.
>>  		 */
>> -		unsigned long ksm_zero_pages;
>> +		atomic_long_t ksm_zero_pages;
>>  #endif /* CONFIG_KSM */
>>  #ifdef CONFIG_LRU_GEN_WALKS_MMU
>>  		struct {
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 0f9c491552ff..6f461411d070 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -296,7 +296,7 @@ static bool ksm_use_zero_pages __read_mostly;
>>  static bool ksm_smart_scan = true;
>>  
>>  /* The number of zero pages which is placed by KSM */
>> -unsigned long ksm_zero_pages;
>> +atomic_long_t ksm_zero_pages = ATOMIC_LONG_INIT(0);
>>  
>>  /* The number of pages that have been skipped due to "smart scanning" */
>>  static unsigned long ksm_pages_skipped;
>> @@ -1429,8 +1429,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>>  		 * the dirty bit in zero page's PTE is set.
>>  		 */
>>  		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
>> -		ksm_zero_pages++;
>> -		mm->ksm_zero_pages++;
>> +		ksm_map_zero_page(mm);
>>  		/*
>>  		 * We're replacing an anonymous page with a zero page, which is
>>  		 * not anonymous. We need to do proper accounting otherwise we
>> @@ -3373,7 +3372,7 @@ static void wait_while_offlining(void)
>>  #ifdef CONFIG_PROC_FS
>>  long ksm_process_profit(struct mm_struct *mm)
>>  {
>> -	return (long)(mm->ksm_merging_pages + mm->ksm_zero_pages) * PAGE_SIZE -
>> +	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
>>  		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
>>  }
>>  #endif /* CONFIG_PROC_FS */
>> @@ -3662,7 +3661,7 @@ KSM_ATTR_RO(pages_skipped);
>>  static ssize_t ksm_zero_pages_show(struct kobject *kobj,
>>  				struct kobj_attribute *attr, char *buf)
>>  {
>> -	return sysfs_emit(buf, "%ld\n", ksm_zero_pages);
>> +	return sysfs_emit(buf, "%ld\n", atomic_long_read(&ksm_zero_pages));
>>  }
>>  KSM_ATTR_RO(ksm_zero_pages);
>>  
>> @@ -3671,7 +3670,7 @@ static ssize_t general_profit_show(struct kobject *kobj,
>>  {
>>  	long general_profit;
>>  
>> -	general_profit = (ksm_pages_sharing + ksm_zero_pages) * PAGE_SIZE -
>> +	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
>>  				ksm_rmap_items * sizeof(struct ksm_rmap_item);
>>  
>>  	return sysfs_emit(buf, "%ld\n", general_profit);
>>
>> -- 
>> 2.45.0
>>


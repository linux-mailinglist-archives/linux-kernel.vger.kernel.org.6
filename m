Return-Path: <linux-kernel+bounces-173369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF98BFF89
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486931F245F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9179B9D;
	Wed,  8 May 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OiQpH/u4"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316B3B7A0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176374; cv=none; b=PN79xKnm2jNq3APF+dE0SrwYRqGssiFEdwy48jFRPrTnq8kXJTdb71/UxBPTo0BC7Z9ryQqWZ0f+FVIhKDH520SCQuNGcvCr0KZbjFcVhKjkug2ImIjup7J2xQcQNDZk6/WlagSquRFbUfDsAHUuporV0Pb86HukFwJ/H3/YZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176374; c=relaxed/simple;
	bh=jcglahS4fzZ1+iHXBUKcnnMVqkR05fQI1TKLF3Q4ky4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKFm9gcvaDis+he0AvPWzYBKYMJAL0Erg6kJYksPy0E2v6lvqcyxseLaedbVXYUpC/Bbwq7OT2fkGA46MHHodFdOFWKWA6LJvi3r5EdQjoFDaJB+Shrby5/yoINq9h+KBewBL++wH63hfPc5b1Y9KT4RJykAdwskjFy3ZQ+rnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OiQpH/u4; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7d8ad19a-dae8-4783-8f49-227ef8ca4857@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715176369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6nBa8Swb0pQAYgPUFjA9k+jIGdbE8D0Y0wHnw+ROds=;
	b=OiQpH/u4G74Br/DFrLL00699DNL62Tz4R1572g80K14ELUPcecmBqayJGmomJPpcCvYbTU
	9Cviqgs0cW3KN5kACszgo5zWUFaecBLIlLe9ehbI/uLN1df8aitjKdkUXpgiGKWrCKt1RQ
	OLYkMP/4SCWFuMl5N7gf2DcaOAeJyAk=
Date: Wed, 8 May 2024 21:52:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] mm/ksm: fix ksm_zero_pages accounting
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Stefan Roesch <shr@devkernel.io>,
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
 <20240508-b4-ksm-counters-v1-2-e2a9b13f70c5@linux.dev>
 <7cac6762-4486-4c42-885d-dd5715eb6ba4@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <7cac6762-4486-4c42-885d-dd5715eb6ba4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/8 20:36, David Hildenbrand wrote:
> On 08.05.24 11:55, Chengming Zhou wrote:
>> We normally ksm_zero_pages++ in ksmd when page is merged with zero page,
>> but ksm_zero_pages-- is done from page tables side, which can't protected
>> by the ksmd mutex.
>>
>> So we can read very exceptional value of ksm_zero_pages in rare cases,
>> such as -1, which is very confusing to users.
>>
>> Fix it by changing to use atomic_long_t, and the same case with the
>> mm->ksm_zero_pages.
>>
>> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
>> ---
>>   fs/proc/base.c           |  2 +-
>>   include/linux/ksm.h      | 22 +++++++++++++++++++---
>>   include/linux/mm_types.h |  2 +-
>>   mm/ksm.c                 | 11 +++++------
>>   4 files changed, 26 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 18550c071d71..72a1acd03675 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -3214,7 +3214,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>>       mm = get_task_mm(task);
>>       if (mm) {
>>           seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
>> -        seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
>> +        seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
>>           seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>>           seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>>           mmput(mm);
>> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>> index 52c63a9c5a9c..bfc2cf756b0d 100644
>> --- a/include/linux/ksm.h
>> +++ b/include/linux/ksm.h
>> @@ -33,16 +33,32 @@ void __ksm_exit(struct mm_struct *mm);
>>    */
>>   #define is_ksm_zero_pte(pte)    (is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
>>   -extern unsigned long ksm_zero_pages;
>> +extern atomic_long_t ksm_zero_pages;
>> +
>> +static inline void ksm_map_zero_page(struct mm_struct *mm)
>> +{
>> +    atomic_long_inc(&ksm_zero_pages);
>> +    atomic_long_inc(&mm->ksm_zero_pages);
>> +}
>>     static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
>>   {
>>       if (is_ksm_zero_pte(pte)) {
>> -        ksm_zero_pages--;
>> -        mm->ksm_zero_pages--;
>> +        atomic_long_dec(&ksm_zero_pages);
>> +        atomic_long_dec(&mm->ksm_zero_pages);
>>       }
>>   }
>>   +static inline long get_ksm_zero_pages(void)
>> +{
>> +    return atomic_long_read(&ksm_zero_pages);
>> +}
> 
> I suggest inlining that one. The naming of the function also is a bit inconsistent staring at the others.

Good point, I will inline it.

> 
>> +
>> +static inline long mm_ksm_zero_pages(struct mm_struct *mm)
>> +{
>> +    return atomic_long_read(&mm->ksm_zero_pages);
>> +}
>> +
> 
> Apart from that LGTM
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks!


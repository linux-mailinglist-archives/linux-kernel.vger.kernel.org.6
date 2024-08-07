Return-Path: <linux-kernel+bounces-278351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE2A94AF07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7628B23B99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7384DF1;
	Wed,  7 Aug 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ja0YGOaK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EB5473E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052521; cv=none; b=lagARiN4oUrrMnCjF9pK6GgfAsaw1tvsU5M/t8L6k4PDZDcLtr4wAMPt31ETQykBpv1IGq3lF3MUmoCEjl7roXX5/h71tw8Yt7UpGYhfM4FfTJv+7kZ0nvCOsIV3R6tWgDGwxpU1bQIgfOtnu3Saykm/+MMuq5wJ4kwxUFB5mCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052521; c=relaxed/simple;
	bh=CVxGnbYxyWdeq1to6LVJWzjdQVPDhffQ7txQylIs9U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMIhqOZSfj/xLdDqgZYoNJS1qoCexo6C+VYUNjABHmzudWOp6bDQcI2rnMSSsq+BNEJqYdVHBClmeUKMoGzkUjJJZgAoKrks98BxMT3zMFo7CoEfsckyiAXbVLt9Pa7ZDgrKGDqKEYOkfqh0VMCkxX8Q3ZbW0rOnR4X/p0GR9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ja0YGOaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723052518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+G1rF0xB5wVkdizZPldbuBkAl5Yi92S8O7hUPInPz4=;
	b=Ja0YGOaKdgGEe6cDgilsk0XeXHZMgUyXLu9y7Mbz/aIB0jIa27YJtkVW+PVwhn4ZL4hkD6
	8JvwNo6xhmMXUW++Y3+BCVBjQchpsAIR0gy7mXqNvHVAl6tCR/Ik5feGwBZbstJU80/XNO
	lB05SdHDIa5bsxN4sUJ9Ql5ii3ax74g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-AV0eZAM2OseFvj-03Z1NYg-1; Wed,
 07 Aug 2024 13:41:54 -0400
X-MC-Unique: AV0eZAM2OseFvj-03Z1NYg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2254A1944B2D;
	Wed,  7 Aug 2024 17:41:53 +0000 (UTC)
Received: from [10.2.16.123] (unknown [10.2.16.123])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BE4F300018D;
	Wed,  7 Aug 2024 17:41:50 +0000 (UTC)
Message-ID: <0ca188a3-9861-49a4-a6f1-ba6ad726c5f0@redhat.com>
Date: Wed, 7 Aug 2024 13:41:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: Use raw_spinlock_t in struct
 memory_failure_cpu
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Huang Ying <ying.huang@intel.com>, Len Brown <len.brown@intel.com>,
 Juri Lelli <juri.lelli@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>
References: <20240806164107.1044956-1-longman@redhat.com>
 <1ea73082-f8f0-6c6d-3c0c-9012520d1036@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <1ea73082-f8f0-6c6d-3c0c-9012520d1036@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/6/24 23:15, Miaohe Lin wrote:
> On 2024/8/7 0:41, Waiman Long wrote:
>> The memory_failure_cpu structure is a per-cpu structure. Access to its
>> content requires the use of get_cpu_var() to lock in the current CPU
>> and disable preemption. The use of a regular spinlock_t for locking
>> purpose is fine for a non-RT kernel.
>>
>> Since the integration of RT spinlock support into the v5.15 kernel,
>> a spinlock_t in a RT kernel becomes a sleeping lock and taking a
>> sleeping lock in a preemption disabled context is illegal resulting in
>> the following kind of warning.
>>
>>    [12135.732244] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>>    [12135.732248] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 270076, name: kworker/0:0
>>    [12135.732252] preempt_count: 1, expected: 0
>>    [12135.732255] RCU nest depth: 2, expected: 2
>>      :
>>    [12135.732420] Hardware name: Dell Inc. PowerEdge R640/0HG0J8, BIOS 2.10.2 02/24/2021
>>    [12135.732423] Workqueue: kacpi_notify acpi_os_execute_deferred
>>    [12135.732433] Call Trace:
>>    [12135.732436]  <TASK>
>>    [12135.732450]  dump_stack_lvl+0x57/0x81
>>    [12135.732461]  __might_resched.cold+0xf4/0x12f
>>    [12135.732479]  rt_spin_lock+0x4c/0x100
>>    [12135.732491]  memory_failure_queue+0x40/0xe0
>>    [12135.732503]  ghes_do_memory_failure+0x53/0x390
>>    [12135.732516]  ghes_do_proc.constprop.0+0x229/0x3e0
>>    [12135.732575]  ghes_proc+0xf9/0x1a0
>>    [12135.732591]  ghes_notify_hed+0x6a/0x150
>>    [12135.732602]  notifier_call_chain+0x43/0xb0
>>    [12135.732626]  blocking_notifier_call_chain+0x43/0x60
>>    [12135.732637]  acpi_ev_notify_dispatch+0x47/0x70
>>    [12135.732648]  acpi_os_execute_deferred+0x13/0x20
>>    [12135.732654]  process_one_work+0x41f/0x500
>>    [12135.732695]  worker_thread+0x192/0x360
>>    [12135.732715]  kthread+0x111/0x140
>>    [12135.732733]  ret_from_fork+0x29/0x50
>>    [12135.732779]  </TASK>
>>
>> Fix it by using a raw_spinlock_t for locking instead. Also move the
>> pr_err() out of the lock critical section to avoid indeterminate latency
>> of this call.
>>
>> Fixes: ea8f5fb8a71f ("HWPoison: add memory_failure_queue()")
> We shouldn't have this problem before RT spinlock is supported? If so, this Fixes tag might be wrong.
OK, I can take out the Fixes tag. It is hard to pinpoint a particular RT 
related commit.
>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memory-failure.c | 18 ++++++++++--------
>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 581d3e5c9117..7aeb5198c2a0 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2417,7 +2417,7 @@ struct memory_failure_entry {
>>   struct memory_failure_cpu {
>>   	DECLARE_KFIFO(fifo, struct memory_failure_entry,
>>   		      MEMORY_FAILURE_FIFO_SIZE);
>> -	spinlock_t lock;
>> +	raw_spinlock_t lock;
>>   	struct work_struct work;
>>   };
>>   
>> @@ -2443,19 +2443,21 @@ void memory_failure_queue(unsigned long pfn, int flags)
>>   {
>>   	struct memory_failure_cpu *mf_cpu;
>>   	unsigned long proc_flags;
>> +	bool buffer_overflow;
>>   	struct memory_failure_entry entry = {
>>   		.pfn =		pfn,
>>   		.flags =	flags,
>>   	};
>>   
>>   	mf_cpu = &get_cpu_var(memory_failure_cpu);
>> -	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
>> -	if (kfifo_put(&mf_cpu->fifo, entry))
>> +	raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
>> +	buffer_overflow = !kfifo_put(&mf_cpu->fifo, entry);
>> +	if (!buffer_overflow)
>>   		schedule_work_on(smp_processor_id(), &mf_cpu->work);
>> -	else
>> +	raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
>> +	if (buffer_overflow)
>>   		pr_err("buffer overflow when queuing memory failure at %#lx\n",
>>   		       pfn);
> Should we put pr_err() further under put_cpu_var()?

Yes, we should probably enable preemption first before calling pr_err(). 
Will make the change in v2.

Thanks,
Longman

>
>> -	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags)
>>   	put_cpu_var(memory_failure_cpu);
>>   }
> Will below diff be more straightforward?
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b68953dc9fad..be172cbc6ca9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2553,20 +2553,23 @@ void memory_failure_queue(unsigned long pfn, int flags)
>   {
>          struct memory_failure_cpu *mf_cpu;
>          unsigned long proc_flags;
> +       bool buffer_overflow = false;
>          struct memory_failure_entry entry = {
>                  .pfn =          pfn,
>                  .flags =        flags,
>          };
>
>          mf_cpu = &get_cpu_var(memory_failure_cpu);
> -       spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> +       raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
>          if (kfifo_put(&mf_cpu->fifo, entry))
>                  schedule_work_on(smp_processor_id(), &mf_cpu->work);
>          else
> +               buffer_overflow = true;
> +       raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
> +       put_cpu_var(memory_failure_cpu);
> +       if (buffer_overflow)
>                  pr_err("buffer overflow when queuing memory failure at %#lx\n",
>                         pfn);
> -       spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
> -       put_cpu_var(memory_failure_cpu);
>   }
>   EXPORT_SYMBOL_GPL(memory_failure_queue);
>
> But no strong opinion.
>
> Thanks.
> .
>



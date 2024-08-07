Return-Path: <linux-kernel+bounces-277227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C05949E32
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED3A2851CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1F2A1D6;
	Wed,  7 Aug 2024 03:15:25 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E3018D620
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000524; cv=none; b=hueHtTO1FEyN2FsN9ZTlzy85lx72EEpLfnAa8TdSsnWuwdlSavMr9y7wo0XgF4Kh0/eKyJIOqlzYac7zYWeqeRAV8zUHpJqA82ELFGiw9CzTMtLR5AEbYQ6xBWRbY/POZhQzlHrfQxqOGuk1Irdz8g9uTq+nDNnsEPje/20R7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000524; c=relaxed/simple;
	bh=GWu7tF3mqwnzz5fR9fNA7ElYBkMPGVwLO2/XKTG/Z5U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C7TefM9zGkZbuOfwCnDG98GE0Hh2X0dHowbGFPAWDEzs5yRV9WonUJgnJIEr6KUrSmWHUXV+zx6nJYV1XlDsHeHwHcT3azJ5dwt72dDJyZJ1RdHXgoFPteOMwVDCQeeVa8W7jSfsK0qPwhddSFD2KGDMjbDpoKIYOMjec7yBlj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WdwH8193JzfZP0;
	Wed,  7 Aug 2024 11:13:24 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id D676A14035E;
	Wed,  7 Aug 2024 11:15:17 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Aug 2024 11:15:17 +0800
Subject: Re: [PATCH v2] mm/memory-failure: Use raw_spinlock_t in struct
 memory_failure_cpu
To: Waiman Long <longman@redhat.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@intel.com>, Len Brown <len.brown@intel.com>, Juri Lelli
	<juri.lelli@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>
References: <20240806164107.1044956-1-longman@redhat.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1ea73082-f8f0-6c6d-3c0c-9012520d1036@huawei.com>
Date: Wed, 7 Aug 2024 11:15:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240806164107.1044956-1-longman@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/8/7 0:41, Waiman Long wrote:
> The memory_failure_cpu structure is a per-cpu structure. Access to its
> content requires the use of get_cpu_var() to lock in the current CPU
> and disable preemption. The use of a regular spinlock_t for locking
> purpose is fine for a non-RT kernel.
> 
> Since the integration of RT spinlock support into the v5.15 kernel,
> a spinlock_t in a RT kernel becomes a sleeping lock and taking a
> sleeping lock in a preemption disabled context is illegal resulting in
> the following kind of warning.
> 
>   [12135.732244] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>   [12135.732248] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 270076, name: kworker/0:0
>   [12135.732252] preempt_count: 1, expected: 0
>   [12135.732255] RCU nest depth: 2, expected: 2
>     :
>   [12135.732420] Hardware name: Dell Inc. PowerEdge R640/0HG0J8, BIOS 2.10.2 02/24/2021
>   [12135.732423] Workqueue: kacpi_notify acpi_os_execute_deferred
>   [12135.732433] Call Trace:
>   [12135.732436]  <TASK>
>   [12135.732450]  dump_stack_lvl+0x57/0x81
>   [12135.732461]  __might_resched.cold+0xf4/0x12f
>   [12135.732479]  rt_spin_lock+0x4c/0x100
>   [12135.732491]  memory_failure_queue+0x40/0xe0
>   [12135.732503]  ghes_do_memory_failure+0x53/0x390
>   [12135.732516]  ghes_do_proc.constprop.0+0x229/0x3e0
>   [12135.732575]  ghes_proc+0xf9/0x1a0
>   [12135.732591]  ghes_notify_hed+0x6a/0x150
>   [12135.732602]  notifier_call_chain+0x43/0xb0
>   [12135.732626]  blocking_notifier_call_chain+0x43/0x60
>   [12135.732637]  acpi_ev_notify_dispatch+0x47/0x70
>   [12135.732648]  acpi_os_execute_deferred+0x13/0x20
>   [12135.732654]  process_one_work+0x41f/0x500
>   [12135.732695]  worker_thread+0x192/0x360
>   [12135.732715]  kthread+0x111/0x140
>   [12135.732733]  ret_from_fork+0x29/0x50
>   [12135.732779]  </TASK>
> 
> Fix it by using a raw_spinlock_t for locking instead. Also move the
> pr_err() out of the lock critical section to avoid indeterminate latency
> of this call.
> 
> Fixes: ea8f5fb8a71f ("HWPoison: add memory_failure_queue()")

We shouldn't have this problem before RT spinlock is supported? If so, this Fixes tag might be wrong.

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memory-failure.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 581d3e5c9117..7aeb5198c2a0 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2417,7 +2417,7 @@ struct memory_failure_entry {
>  struct memory_failure_cpu {
>  	DECLARE_KFIFO(fifo, struct memory_failure_entry,
>  		      MEMORY_FAILURE_FIFO_SIZE);
> -	spinlock_t lock;
> +	raw_spinlock_t lock;
>  	struct work_struct work;
>  };
>  
> @@ -2443,19 +2443,21 @@ void memory_failure_queue(unsigned long pfn, int flags)
>  {
>  	struct memory_failure_cpu *mf_cpu;
>  	unsigned long proc_flags;
> +	bool buffer_overflow;
>  	struct memory_failure_entry entry = {
>  		.pfn =		pfn,
>  		.flags =	flags,
>  	};
>  
>  	mf_cpu = &get_cpu_var(memory_failure_cpu);
> -	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> -	if (kfifo_put(&mf_cpu->fifo, entry))
> +	raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> +	buffer_overflow = !kfifo_put(&mf_cpu->fifo, entry);
> +	if (!buffer_overflow)
>  		schedule_work_on(smp_processor_id(), &mf_cpu->work);
> -	else
> +	raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
> +	if (buffer_overflow)
>  		pr_err("buffer overflow when queuing memory failure at %#lx\n",
>  		       pfn);

Should we put pr_err() further under put_cpu_var()?

> -	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags)
>  	put_cpu_var(memory_failure_cpu);
>  }

Will below diff be more straightforward?

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b68953dc9fad..be172cbc6ca9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2553,20 +2553,23 @@ void memory_failure_queue(unsigned long pfn, int flags)
 {
        struct memory_failure_cpu *mf_cpu;
        unsigned long proc_flags;
+       bool buffer_overflow = false;
        struct memory_failure_entry entry = {
                .pfn =          pfn,
                .flags =        flags,
        };

        mf_cpu = &get_cpu_var(memory_failure_cpu);
-       spin_lock_irqsave(&mf_cpu->lock, proc_flags);
+       raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
        if (kfifo_put(&mf_cpu->fifo, entry))
                schedule_work_on(smp_processor_id(), &mf_cpu->work);
        else
+               buffer_overflow = true;
+       raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
+       put_cpu_var(memory_failure_cpu);
+       if (buffer_overflow)
                pr_err("buffer overflow when queuing memory failure at %#lx\n",
                       pfn);
-       spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
-       put_cpu_var(memory_failure_cpu);
 }
 EXPORT_SYMBOL_GPL(memory_failure_queue);

But no strong opinion.

Thanks.
.


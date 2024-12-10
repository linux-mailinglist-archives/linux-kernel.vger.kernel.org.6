Return-Path: <linux-kernel+bounces-439489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544539EAFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C9A290E00
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6102210F7F;
	Tue, 10 Dec 2024 11:31:57 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BF1DC9BA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830317; cv=none; b=MweHi1GnC37WJhJ/uXGp3LB4sTYZzFdOIdF9e5jUdC8wAb3TcTQ75/S9M6073GJ+gY7UmrnJ8UV1ryK0dtKgTTw+VWqD9CVfk/qF5ilhAlAD/XVfnNgXJXiGJdtMOV6X6FVK9vieE8ywumsmnUIUWquhR5q1s2b8D7mhpaRDTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830317; c=relaxed/simple;
	bh=H3f2+1ZzgvKyowWfNoPmQUGiI1XzBOcfQREvfQXC8z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZtUhhpnO61Eg9Nr/+jAZZsKqoYuC0yOMwERwup7FqCSX6xE/n/5RviRAVdWj/hWFK3U5O1Gfb/QhmUqUhj0W9ySp5oUPtZMKvLD6bFvDGWmySfFg5LQERv/eMGPRLxHA4+GXpga30d+/+rAlQr0MdjhTxTYfZVszx4UeBvGQIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y6xM126P7z1V63F;
	Tue, 10 Dec 2024 19:28:45 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E4EA14011B;
	Tue, 10 Dec 2024 19:31:49 +0800 (CST)
Received: from [10.84.144.227] (10.84.144.227) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 19:31:47 +0800
Message-ID: <c09f15a4-cdaa-457d-aaec-24bed7ba11fc@huawei.com>
Date: Tue, 10 Dec 2024 19:31:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Fix CPU bandwidth limit bypass during CPU
 hotplug
To: Vishal Chourasia <vishalc@linux.ibm.com>, <linux-kernel@vger.kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <sshegde@linux.ibm.com>, <srikar@linux.ibm.com>,
	<vineethr@linux.ibm.com>
References: <20241210102346.228663-2-vishalc@linux.ibm.com>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20241210102346.228663-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200007.china.huawei.com (7.202.181.34)



在 2024/12/10 18:23, Vishal Chourasia 写道:
> CPU controller limits are not properly enforced during CPU hotplug
> operations, particularly during CPU offline. When a CPU goes offline,
> throttled processes are unintentionally being unthrottled across all CPUs
> in the system, allowing them to exceed their assigned quota limits.
> 
> Consider below for an example,
> 
> Assigning 6.25% bandwidth limit to a cgroup
> in a 8 CPU system, where, workload is running 8 threads for 20 seconds at
> 100% CPU utilization, expected (user+sys) time = 10 seconds.
> 
> $ cat /sys/fs/cgroup/test/cpu.max
> 50000 100000
> 
> $ ./ebizzy -t 8 -S 20        // non-hotplug case
> real 20.00 s
> user 10.81 s                 // intended behaviour
> sys   0.00 s
> 
> $ ./ebizzy -t 8 -S 20        // hotplug case
> real 20.00 s
> user 14.43 s                 // Workload is able to run for 14 secs
> sys   0.00 s                 // when it should have only run for 10 secs
> 
> During CPU hotplug, scheduler domains are rebuilt and cpu_attach_domain
> is called for every active CPU to update the root domain. That ends up
> calling rq_offline_fair which un-throttles any throttled hierarchies.
> 
> Unthrottling should only occur for the CPU being hotplugged to allow its
> throttled processes to become runnable and get migrated to other CPUs.
> 
> With current patch applied,
> $ ./ebizzy -t 8 -S 20        // hotplug case
> real 21.00 s
> user 10.16 s                 // intended behaviour
> sys   0.00 s
> 

Could add a description of another issue[1] here？

This bug also has another symptom, when a CPU goes offline, the cfs_rq
is not in throttled state and the runtime_remaining still had plenty
remaining, but it was reset to 1 here, causing the runtime_remaining of
cfs_rq to be quickly depleted and the actual running time slice is
smaller than the configured quota limits.

[1]https://lore.kernel.org/all/fb488379-3965-496b-8c6f-259981f3d7e5@huawei.com/

> Note: hotplug operation (online, offline) was performed in while(1) loop
> > Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Suggested-by: Zhang Qiao <zhangqiao22@huawei.com>

--
thanks,
Zhang Qiao.

> 
> v2: https://lore.kernel.org/all/20241207052730.1746380-2-vishalc@linux.ibm.com
> v1: https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com
> ---
>  kernel/sched/fair.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa0238ee4857..2faf7dff2bc8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6687,25 +6687,30 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>  	rq_clock_start_loop_update(rq);
>  
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(tg, &task_groups, list) {
> -		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +	/* Traverse the thread group list only for inactive rq */
> +	if (!cpumask_test_cpu(cpu_of(rq), cpu_active_mask)) {
> +		list_for_each_entry_rcu(tg, &task_groups, list) {
> +			struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>  
> -		if (!cfs_rq->runtime_enabled)
> -			continue;
> +			if (!cfs_rq->runtime_enabled)
> +				continue;
>  
> -		/*
> -		 * clock_task is not advancing so we just need to make sure
> -		 * there's some valid quota amount
> -		 */
> -		cfs_rq->runtime_remaining = 1;
> -		/*
> -		 * Offline rq is schedulable till CPU is completely disabled
> -		 * in take_cpu_down(), so we prevent new cfs throttling here.
> -		 */
> -		cfs_rq->runtime_enabled = 0;
> +			/*
> +			 * Offline rq is schedulable till CPU is completely disabled
> +			 * in take_cpu_down(), so we prevent new cfs throttling here.
> +			 */
> +			cfs_rq->runtime_enabled = 0;
>  
> -		if (cfs_rq_throttled(cfs_rq))
> +			if (!cfs_rq_throttled(cfs_rq))
> +				continue;
> +
> +			/*
> +			 * clock_task is not advancing so we just need to make sure
> +			 * there's some valid quota amount
> +			 */
> +			cfs_rq->runtime_remaining = 1;
>  			unthrottle_cfs_rq(cfs_rq);
> +		}
>  	}
>  	rcu_read_unlock();
>  


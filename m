Return-Path: <linux-kernel+bounces-438985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1DC9EA91E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FEA1885F33
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527052309A1;
	Tue, 10 Dec 2024 06:55:46 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4622D4E8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813745; cv=none; b=hRRkBvV17U2+kOova6BVEx1GEqArr3P7fh6ssyoHU1oA00NPv6Y24Ea0QDoADHFg1zP5fnvdEjYJGZM8eo5Bh1+TVvFETgo+8W4R97fnpo4yAcxnCOcSq8L4v/174oY4C2ahuUvNwLELTUpQHcWpJTI1Xqd+HKsIa7iZwgyaG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813745; c=relaxed/simple;
	bh=evE0s2ghDjlm3qHsBhZYX5Ja8ObhNExQBkbEaOVwAPY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Ewsdyo2It8hZpRBCRQ5aM1LeUFQdCHhAprYj9fSM3Tc6ivgWk+IAe9PsrvTdUBcukBkVesM8qeYDqjAGL//htZs+cHilBacpOu/o6/GCyifODyNfxfXhaB5IO24egdZczYZS5dKXUTFb58iZP6Q5jXpKzJdqpJtVjDEzZD5qY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y6qDM43D5z1V5vL;
	Tue, 10 Dec 2024 14:52:35 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id A59B61802D1;
	Tue, 10 Dec 2024 14:55:39 +0800 (CST)
Received: from [10.84.144.227] (10.84.144.227) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 14:55:37 +0800
Message-ID: <fb488379-3965-496b-8c6f-259981f3d7e5@huawei.com>
Date: Tue, 10 Dec 2024 14:55:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhang Qiao <zhangqiao22@huawei.com>
Subject: Re: [PATCH v2] sched/fair: Fix CPU bandwidth limit bypass during CPU
 hotplug
To: Vishal Chourasia <vishalc@linux.ibm.com>, <linux-kernel@vger.kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <sshegde@linux.ibm.com>, <srikar@linux.ibm.com>,
	<vineethr@linux.ibm.com>
References: <20241207052730.1746380-2-vishalc@linux.ibm.com>
In-Reply-To: <20241207052730.1746380-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200007.china.huawei.com (7.202.181.34)

Hi Vishal,



在 2024/12/7 13:27, Vishal Chourasia 写道:
> CPU controller limits are not properly enforced during CPU hotplug
> operations, particularly during CPU offline. When a CPU goes offline,
> throttled processes are unintentionally being unthrottled across all CPUs
> in the system, allowing them to exceed their assigned quota limits.
> 

I encountered a similar issue where cfs_rq is not in throttled state and the runtime_remaining still
had plenty remaining, but it was reset to 1 here, causing the runtime_remaining of cfs_rq to be
quickly depleted and the actual running time slice is smaller than the configured quota limits.

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
> Note: hotplug operation (online, offline) was performed in while(1) loop
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> 
> v1: https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com
> 
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fbdca89c677f..e28a8e056ebf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6684,7 +6684,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>  	list_for_each_entry_rcu(tg, &task_groups, list) {
>  		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>  
> -		if (!cfs_rq->runtime_enabled)
> +		/* Only unthrottle the CPU being hotplugged */
> +		if (!cfs_rq->runtime_enabled || cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
>  			continue;

The cpu_of(rq) is  fixed value, so the ret of cpumask_test_cpu() is also a fixed value. We could
check this before traversing the task_groups list, avoiding unnecessary traversal, is right?

Something like this:
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d16c8545c71..79e9e5323112 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6687,25 +6687,29 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
        rq_clock_start_loop_update(rq);

        rcu_read_lock();
-       list_for_each_entry_rcu(tg, &task_groups, list) {
-               struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+       if (!cpumask_test_cpu(cpu_of(rq), cpu_active_mask)) {
+               list_for_each_entry_rcu(tg, &task_groups, list) {
+                       struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];

-               if (!cfs_rq->runtime_enabled)
-                       continue;
+                       if (!cfs_rq->runtime_enabled)
+                               continue;

-               /*
-                * clock_task is not advancing so we just need to make sure
-                * there's some valid quota amount
-                */
-               cfs_rq->runtime_remaining = 1;
-               /*
-                * Offline rq is schedulable till CPU is completely disabled
-                * in take_cpu_down(), so we prevent new cfs throttling here.
-                */
-               cfs_rq->runtime_enabled = 0;
+                       /*
+                        * Offline rq is schedulable till CPU is completely disabled
+                        * in take_cpu_down(), so we prevent new cfs throttling here.
+                        */
+                       cfs_rq->runtime_enabled = 0;

-               if (cfs_rq_throttled(cfs_rq))
+                       if (!cfs_rq_throttled(cfs_rq))
+                               continue;
+
+                       /*
+                        * clock_task is not advancing so we just need to make sure
+                        * there's some valid quota amount
+                        */
+                       cfs_rq->runtime_remaining = 1;
                        unthrottle_cfs_rq(cfs_rq);
+               }
        }


-- 
Zhang Qiao
>  
>  		/*


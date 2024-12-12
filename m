Return-Path: <linux-kernel+bounces-443909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2EB9EFD62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9C4188DF20
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA21A08DB;
	Thu, 12 Dec 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G89PwSrg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E21B2191
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035102; cv=none; b=WkszdlzDg1fmtjwaP+gYhitOhAOr3dHNzOtdps7SIRemKp+sK6AIIXweMF3n40FB6q7Dt++pFgrrsCl/d8365Cz9JiUAmyfbGe3vJPUDc/o1qLag7TE1Ae9lxpf1ZX8+zpDt487mLjJuJ5pMVTbaYX07X/xXo6nIDne7p/5e6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035102; c=relaxed/simple;
	bh=vJGwlc63+k/qoxGKLtLmGvsSEPA2rmyS2REwKogAx2E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=u8JtfwCQ9/K0aAvuCZx05Dsq+bpqf0eWhtrW3Ahxrou4M4GrMqM4hkd1u3DyAxYnD0V80wl/CXfR6zXwgNOtw8tJo0jag/N9H6lXP22pKV5Gaoq5byS2C6EsCneO0VHpZQVJ7UA6XtGJ5q50UOIeIiSHvVFYNzwJgu35+kFFCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G89PwSrg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGL8VG005447;
	Thu, 12 Dec 2024 20:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6czLNh
	TwlrPM3PoCi2+ECuQXL5M7Y3xSxGArZDH6QjU=; b=G89PwSrgr11rvXPCeZBRJh
	jVzDjZQ8JorvHQRl/znIG7H9hUDeR64qMCPUMrd6ZADT4Gy6HfnrG39vmsHD0ac2
	KYtV29FGzmbMO1zxqJNlycmppuObP5MpUgkekyCMavfJ27NaMMpOyVWMagvL4n1v
	wAS0IdgNnNTT3yI89HIaMUIX57AKOO0EUbAVtk+dsrjEYyudqnojd489EHF+1Hxz
	SJtqy6iSH2ap6dQNQ3egzUpkwg0EuAHiSwE44+wLdltCIPAa1simLvGyx46F5c8o
	vsfqo1tApIe3a2qYDyJ8jHN5Y3KQsBBD65ANfyVim/dzCBlVUPjSa835JU0EgHDw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqnn54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 20:24:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCKOdfB011964;
	Thu, 12 Dec 2024 20:24:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqnn51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 20:24:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGsXgD018602;
	Thu, 12 Dec 2024 20:24:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26kt997-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 20:24:38 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCKOblb17695408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 20:24:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3298658055;
	Thu, 12 Dec 2024 20:24:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31D495804B;
	Thu, 12 Dec 2024 20:24:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 20:24:36 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Dec 2024 01:54:35 +0530
From: samir <samir@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, sshegde@linux.ibm.com,
        srikar@linux.ibm.com, vineethr@linux.ibm.com, zhangqiao22@huawei.com
Subject: Re: [PATCH v4] sched/fair: Fix CPU bandwidth limit bypass during CPU
 hotplug
In-Reply-To: <20241212043102.584863-2-vishalc@linux.ibm.com>
References: <20241212043102.584863-2-vishalc@linux.ibm.com>
Message-ID: <84b732ac5ac564615930fd2e58aab445@linux.ibm.com>
X-Sender: samir@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G6etNxN0lab5hxkG4Ypwz1Eh8Z0w0O2E
X-Proofpoint-GUID: appd9wdwjEPuFjkUMUVJgzj3M45x5-nh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120145

On 2024-12-12 10:01, Vishal Chourasia wrote:
> CPU controller limits are not properly enforced during CPU hotplug
> operations, particularly during CPU offline. When a CPU goes offline,
> throttled processes are unintentionally being unthrottled across all 
> CPUs
> in the system, allowing them to exceed their assigned quota limits.
> 
> Consider below for an example,
> 
> Assigning 6.25% bandwidth limit to a cgroup
> in a 8 CPU system, where, workload is running 8 threads for 20 seconds 
> at
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
> sys   0.00 s                 // when it should have only run for 10 
> secs
> 
> During CPU hotplug, scheduler domains are rebuilt and cpu_attach_domain
> is called for every active CPU to update the root domain. That ends up
> calling rq_offline_fair which un-throttles any throttled hierarchies.
> 
> Unthrottling should only occur for the CPU being hotplugged to allow 
> its
> throttled processes to become runnable and get migrated to other CPUs.
> 
> With current patch applied,
> $ ./ebizzy -t 8 -S 20        // hotplug case
> real 21.00 s
> user 10.16 s                 // intended behaviour
> sys   0.00 s
> 
> This also has another symptom, when a CPU goes offline, and if the 
> cfs_rq
> is not in throttled state and the runtime_remaining still had plenty
> remaining, it gets reset to 1 here, causing the runtime_remaining of
> cfs_rq to be quickly depleted.
> 
> Note: hotplug operation (online, offline) was performed in while(1) 
> loop
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Suggested-by: Zhang Qiao <zhangqiao22@huawei.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> 
> v3: 
> https://lore.kernel.org/all/20241210102346.228663-2-vishalc@linux.ibm.com
> v2: 
> https://lore.kernel.org/all/20241207052730.1746380-2-vishalc@linux.ibm.com
> v1: 
> https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com
> 
> ---
>  kernel/sched/fair.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa0238ee4857..72746e75700c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6679,6 +6679,10 @@ static void __maybe_unused
> unthrottle_offline_cfs_rqs(struct rq *rq)
> 
>  	lockdep_assert_rq_held(rq);
> 
> +	// Do not unthrottle for an active CPU
> +	if (cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
> +		return;
> +
>  	/*
>  	 * The rq clock has already been updated in the
>  	 * set_rq_offline(), so we should skip updating
> @@ -6693,19 +6697,21 @@ static void __maybe_unused
> unthrottle_offline_cfs_rqs(struct rq *rq)
>  		if (!cfs_rq->runtime_enabled)
>  			continue;
> 
> -		/*
> -		 * clock_task is not advancing so we just need to make sure
> -		 * there's some valid quota amount
> -		 */
> -		cfs_rq->runtime_remaining = 1;
>  		/*
>  		 * Offline rq is schedulable till CPU is completely disabled
>  		 * in take_cpu_down(), so we prevent new cfs throttling here.
>  		 */
>  		cfs_rq->runtime_enabled = 0;
> 
> -		if (cfs_rq_throttled(cfs_rq))
> -			unthrottle_cfs_rq(cfs_rq);
> +		if (!cfs_rq_throttled(cfs_rq))
> +			continue;
> +
> +		/*
> +		 * clock_task is not advancing so we just need to make sure
> +		 * there's some valid quota amount
> +		 */
> +		cfs_rq->runtime_remaining = 1;
> +		unthrottle_cfs_rq(cfs_rq);
>  	}
>  	rcu_read_unlock();
> 
> 
> base-commit: 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b

Hello,

I have verified this issue using the ebizzy workload and a Podman 
container. The tests confirm that the problem is resolved, and the 
provided fix is working as expected. Below are the results for 
reference, where the ebizzy workload was executed within the container 
with --cpu-quota=50000 allocated.
Additionally, I tested the patch under load conditions both with and 
without hot-plug operations. Observations are as follows:

Test Results
Without Hot-Plug Operation:
Command: ./ebizzy -t 64 -S 20
	Performance: 43,506 records/s
	Execution Time:
       	Real: 20.00 s
	User: 10.46 s
	Sys: 0.00 s
With Hot-Plug Operation:
Command: ./ebizzy -t 64 -S 20
	Performance: 35,642 records/s
	Execution Time:
	Real: 20.00 s
	User: 10.45 s
	Sys: 0.01 s

Tested-by: Samir Mulani <samir@linux.ibm.com>

Thanks for the fix!



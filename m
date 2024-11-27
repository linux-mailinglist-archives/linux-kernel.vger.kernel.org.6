Return-Path: <linux-kernel+bounces-423817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5739DAD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7B2B20D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207A201017;
	Wed, 27 Nov 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XuY/Tlns"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6391BC3F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732732307; cv=none; b=t/Ag7buFA/UY8tKNeo25O878bZWlVC6dsdaXH7LxdJYGJlUTkYSdIVQFrPurXQVPHpnus7SzYoeNQcxyJgMSLor97wzoJYaaprNwtci4FQAE84C2/yEP2krWZIKaYmfFU9XLAZyygNCEwhMMDuluKog7hpLNWA1L1RTosVkV+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732732307; c=relaxed/simple;
	bh=H7ilfbEKwHZFW+OXhaTF8agmyZNIePxrdYkcdDoBhR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDXhwTjvhyViYL5ocAGR27vSR1MRXyvS4rEeo+NyKin9kZZRQqhEoJmn5AXgb3FwTBRKHogtJ6iegt9YEMaBHNQoScUmZo0OA8K6Ih1BQ5Jl+uAB+ireOlsSwMEhKNrTQ3NEFD7/kewSYLwXxpC5PqFtn8p+00MwV4iavczsABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XuY/Tlns; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARHXaQu017978;
	Wed, 27 Nov 2024 18:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=hNO8ANskpYar2KpQahF0FCws8jhxFg4QnmwfEWKVq/Q=; b=XuY/TlnsoGXk
	sEOSHxLmBEAC4zRgTO44MaeEofRH56rqXZI4g2jlnM+vn4CPxqLm/2kji3GboEzn
	c+bxxlI1tftGvM3Jf0ytt1tGdsj45KO6SJ8O6WZQTFEiHuF8cqnqWSKObLBVmHny
	xCTdguNSa2Yrz7qLT141/fq22PvCmoOleeI06bZhupbaMP1NzAYB+ejv43vrqWBy
	XkwSGQlkD+/Iq/LOZZTi9nJlI2pkyiS+FgS8SVpmVGE45LUCvUVZmWpyqc2IO2G9
	5Ly/sxlfxuqGxK0b1yneXz9HI/UIRRSZSCFenbwWWRXSfS3HwBX/PGMsI5Md3Hqz
	WF3Jd7gnEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366yx0h80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 18:31:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ARIVWPW008267;
	Wed, 27 Nov 2024 18:31:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366yx0h7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 18:31:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARGY7Ls025115;
	Wed, 27 Nov 2024 18:31:31 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43672eg4vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 18:31:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ARIVUAR2949886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 18:31:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52A665805C;
	Wed, 27 Nov 2024 18:31:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAE3958058;
	Wed, 27 Nov 2024 18:31:23 +0000 (GMT)
Received: from [9.43.13.174] (unknown [9.43.13.174])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 18:31:23 +0000 (GMT)
Message-ID: <fc570904-a9d0-4c86-b7c8-d47da6bf02dd@linux.ibm.com>
Date: Thu, 28 Nov 2024 00:01:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix CPU bandwidth limit bypass during CPU
 hotplug
To: Vishal Chourasia <vishalc@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, sshegde@linux.ibm.com,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20241126064812.809903-2-vishalc@linux.ibm.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 20241126064812.809903-2-vishalc@linux.ibm.com
In-Reply-To: <20241126064812.809903-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pXak4yOxb2JVEiK8Pp7Cb3Fi0SenUvVQ
X-Proofpoint-GUID: w5OmPJ1ZU9SDuFUuxH6_O3VnZdC4LD8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411270145

Hi Vishal,

On 26/11/24 12:18, Vishal Chourasia wrote:
> CPU controller limits are not properly enforced during CPU hotplug operations,
> particularly during CPU offline. When a CPU goes offline, throttled
> processes are unintentionally being unthrottled across all CPUs in the system,
> allowing them to exceed their assigned quota limits.
> 
> Assigning 6.25% bandwidth limit to a cgroup in a 8 CPU system, where, workload
> is running 8 threads for 20 seconds at 100% CPU utilization,
> expected (user+sys) time = 10 seconds.
> 
> # cat /sys/fs/cgroup/test/cpu.max
> 50000 100000
> 
> # ./ebizzy -t 8 -S 20        // non-hotplug case
> real 20.00 s
> user 10.81 s                 // intented behaviour
> sys   0.00 s
> 
> # ./ebizzy -t 8 -S 20        // hotplug case
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
> # ./ebizzy -t 8 -S 20        // hotplug case
> real 21.00 s
> user 10.16 s                 // intented behaviour
> sys   0.00 s
> 
> Note: hotplug operation (online, offline) was performed in while(1) loop

Tested with and without this patch for the ebizzy workload as mentioned.

Without the patch:
------------------
19376 records/s
real 20.00 s
user 12.49 s
sys   0.00 s

With the patch:
---------------
17708 records/s
real 20.00 s
user 10.07 s
sys   0.00 s

Hence,
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fbdca89c677f..c436e2307e6f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6684,7 +6684,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>  	list_for_each_entry_rcu(tg, &task_groups, list) {
>  		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>  
> -		if (!cfs_rq->runtime_enabled)
> +		/* Don't unthrottle an active cfs_rq unnecessarily */
> +		if (!cfs_rq->runtime_enabled || cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
>  			continue;
>  
>  		/*



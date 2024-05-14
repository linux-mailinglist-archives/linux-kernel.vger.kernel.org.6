Return-Path: <linux-kernel+bounces-178801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEBA8C57DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E821B218B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7AD144D39;
	Tue, 14 May 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ABDa9XQP"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E8144D0B
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696679; cv=none; b=updQQqdzD3lTjpqqBQwym+oL9sxliz1SQnKbJ/Y2+6ZkoL9Kz+xw40FkAU6XqqcGW1gq7sprJAKeNaP4KZP3fVL1XIKd5OAw2zrH/nyhMMtY1FGN5FvIZtffadNp2p+v7r+jcyLcRXZ+EkwRG5ROZCsyctVKQbWfG7rmeTqDA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696679; c=relaxed/simple;
	bh=CAI/Q+O7gZEq9om/A/A7hRhXWyKZi5yJD6oSXYGsU3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FptxCyskR3tSoMmUI71ijnUZ2ecF6/AwrI3hfVYHwLXTOlkD/UkI0Lp09r3YlMbTkp+EBOEdUQW/1AwgwxO6tvxGWjL3v2c5E1PXL4g70s43NjH+OQMKDeIiBg1R+2tqQ8J0uY0Z64L7FFPGKU+0Q6ErEADSJTBJuhmMr1uCW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ABDa9XQP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ECUkTN030352;
	Tue, 14 May 2024 14:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9Uk9sPwbu8Xnq7un5OWPPwl9F/6BF471v1lOmCrInZw=;
 b=ABDa9XQPQa0y2F0O+4I1YPYH5sHlUKApbZ/YR/vQAdrYO69VbZtIGh6VFhC++3wh47Fc
 /ZQN6ml/lvN6bx5WJVHeCEJkWhRy4Ev6+vtwY+L90ybhIft4PTwzB0RzX+sq0H9nG/IH
 d23kgI3SQX+rZJTF4ZbzNyuEO4s7Sl+CC+RqmGo7uG0AoFFJD6F01ntGrPsiZFh2uBd8
 1z2CboxprAU5rJ4P2LU8dna48YwPlURw15L6TcReF7FEzQsQO3CVSk8IxjSwU++BCM56
 VcSL7yrM5szSEhxnk/lXZ1/QJZS3D6vMDrZeZiAb6B9UorXBP+zkW/+eji6clMivscrs JA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y44hrrttg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 14:24:07 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44EEO6XH012082;
	Tue, 14 May 2024 14:24:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y44hrrttd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 14:24:06 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EBV5l9020460;
	Tue, 14 May 2024 14:24:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kcyx046-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 14:24:06 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EEO3rg45547948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 14:24:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 639B75805D;
	Tue, 14 May 2024 14:24:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B8EE58065;
	Tue, 14 May 2024 14:23:59 +0000 (GMT)
Received: from [9.79.191.48] (unknown [9.79.191.48])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 14:23:59 +0000 (GMT)
Message-ID: <e942abce-97ec-4bf1-8220-55bfed18c265@linux.ibm.com>
Date: Tue, 14 May 2024 19:53:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v3 1/1] sched: Report the different kinds of
 imbalances in /proc/schedstat
To: Chen Yu <yu.c.chen@intel.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, vincent.guittot@linaro.org,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com
References: <20240514044445.1409976-1-swapnil.sapkal@amd.com>
 <20240514044445.1409976-2-swapnil.sapkal@amd.com>
 <ZkNHshuGhY6nBGmJ@chenyu5-mobl2>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <ZkNHshuGhY6nBGmJ@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MZPGlk5qYo-ogM3PHwWoI8CpAWL1lwMR
X-Proofpoint-ORIG-GUID: CE5G7ZNpD9lpW7oB8mWrKK6uytvsQ-JB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_07,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405140102



On 5/14/24 4:44 PM, Chen Yu wrote:
> On 2024-05-14 at 04:44:45 +0000, Swapnil Sapkal wrote:
>> In /proc/schedstat, lb_imbalance reports the sum of imbalances
>> discovered in sched domains with each call to sched_balance_rq(), which is
>> not very useful because lb_imbalance does not mention whether the imbalance
>> is due to load, utilization, nr_tasks or misfit_tasks. Remove this field
>> from /proc/schedstat.
>>
>> Currently there is no field in /proc/schedstat to report different types
>> of imbalances. Introduce new fields in /proc/schedstat to report the
>> total imbalances in load, utilization, nr_tasks or misfit_tasks.
>>
>> Added fields to /proc/schedstat:
>>  	- lb_imbalance_load: Total imbalance due to load.
>> 	- lb_imbalance_util: Total imbalance due to utilization.
>> 	- lb_imbalance_task: Total imbalance due to number of tasks.
>> 	- lb_imbalance_misfit: Total imbalance due to misfit tasks.
>>
>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>  Documentation/scheduler/sched-stats.rst | 121 ++++++++++++++----------
>>  include/linux/sched/topology.h          |   5 +-
>>  kernel/sched/fair.c                     |  21 +++-
>>  kernel/sched/stats.c                    |   7 +-
>>  4 files changed, 99 insertions(+), 55 deletions(-)
> 
> [...]
> 
>> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
>> index 78e48f5426ee..a02bc9db2f1c 100644
>> --- a/kernel/sched/stats.c
>> +++ b/kernel/sched/stats.c
>> @@ -151,11 +151,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
>>  			seq_printf(seq, "domain%d %*pb", dcount++,
>>  				   cpumask_pr_args(sched_domain_span(sd)));
>>  			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
>> -				seq_printf(seq, " %u %u %u %u %u %u %u %u",
>> +				seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",
>>  				    sd->lb_count[itype],
>>  				    sd->lb_balanced[itype],
>>  				    sd->lb_failed[itype],
>> -				    sd->lb_imbalance[itype],
>> +				    sd->lb_imbalance_load[itype],
>> +				    sd->lb_imbalance_util[itype],
>> +				    sd->lb_imbalance_task[itype],
>> +				    sd->lb_imbalance_misfit[itype],
>>  				    sd->lb_gained[itype],
>>  				    sd->lb_hot_gained[itype],
>>  				    sd->lb_nobusyq[itype],
> 
> Do we need to increase SCHEDSTAT_VERSION to 16?

It's been increased already as part of below commit 

commit 11b0bfa5d463b17cac5bf6b94fea4921713530c3
Author: Ingo Molnar <mingo@kernel.org>
Date:   Fri Mar 8 11:58:55 2024 +0100

    sched/debug: Increase SCHEDSTAT_VERSION to 16
    
    We changed the order of definitions within 'enum cpu_idle_type',
    which changed the order of [CPU_MAX_IDLE_TYPES] columns in
    show_schedstat().


> 
> thanks,
> Chenyu


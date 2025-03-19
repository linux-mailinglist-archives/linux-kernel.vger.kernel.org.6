Return-Path: <linux-kernel+bounces-567380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900A9A68548
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04DF422B78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37396212B04;
	Wed, 19 Mar 2025 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XM2bFlIB"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C0E552
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367115; cv=fail; b=T6gTJ08J1cFK3ZWws0NMCQt9zZVqUVB5taWdEbgC9fYt74YwbfSvaaRpBfr48o4CnRPzg0AOx2xElIFUVsBOTSHOAS5krXYVVu0801tSPLxgFN+OeCxr51w/w8XD4aarClrEC6P5VdsmCWz2gyNJYrz5/zDMUvLu+AAcOSEebxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367115; c=relaxed/simple;
	bh=3o/ehNm+SDliZ3H6xHoC1/XvPs4vswkxla8rNV0bCqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RZRh5+aEOMn1c8SJdjkUAKCezZaKKfMBSo+G/M3YZDRGtJSBr8K1PGi/DzatRVTXTSqYCr4JxG5HSIvih6I0BBimmo9X6eHbwS/zhNl8RXChtSmSAklGdHzDyqj6efzatRqs1Far7/nWjCt6cqfIS/tpXX8+V46R27xfDbcd2D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XM2bFlIB; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geczIUY+yZ3MvV4XoACREYInIFv+aXOvGW++0/wNn0kbatfJmQq02iR7V5cxJHS7p1P7wyJqml7pfi0EPOtuEX1aGxFxEFloRzemSJxg9o2GUMGcbTGoOQrW6GO+WDAk4BzvPcBVoQstUeTaBUOz/56J272AO5H8+8G0xcgI3vIsFEWPv5RiMP7d2ugldbncc/uFOi3jnHXqaghz4FTl8B8YgqmzVjM4yf0IDavj7CnRx8qD/C5q4Y0T6nb6cvtGyerg2dE000UliV+llEz9ykkA41i4GHdI7kRUuoWy5l8txR5BGNpZxMNkU8dRGw272dtJ4eR4/wrVrOhlGycS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OARnuCrBVAc5WhvZS8YT3GUCGtFRI72vkacvJ22zgI=;
 b=FdTzcqoX9yApTJrrgF3bEIDz8Tm0gUm67yRwWE6jtY692uSAxeyfC4188K1oYQFwDGyBC2+QU09pNxxCsShN+SBHeKIHLTLVhJZwZqPdmOKUBn77AC09cVS9zg67e/8ERJzYSougtwaMj5w7782hvV5PE9GI4jjVxT1GPLdTYxEv1XuzVk8jpcot6Ek/Ge/ab3jUc5GhyGnTgE6D3KSS59y5UPIHcQ6xT4C0rolbQRiy+ZzeamSuKJyeK0SB4YUFklxLJ+ESu2aA1GHwJIVw5Q79tIsfshA9Q7B+pZ3iYM63XY0enygK66KqVI1seeOiUZ048eYSOlQdsctoNmyEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OARnuCrBVAc5WhvZS8YT3GUCGtFRI72vkacvJ22zgI=;
 b=XM2bFlIBnnwTSupSXACbyaciJLRRs5uGKjmByF5+o82OCuF9O5/L9lmuMDrCyBCT8IRGM3OKVzswKze2M32LhI5sjXPHK5vYUXKsdKbc3KAPwn92wIHyGsCQu+zifZnSVXNHdTtleEJN7OJN9IEDkhP77yfaXhH6iRdtKG6Nz6g=
Received: from CH2PR17CA0005.namprd17.prod.outlook.com (2603:10b6:610:53::15)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 06:51:49 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::47) by CH2PR17CA0005.outlook.office365.com
 (2603:10b6:610:53::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 06:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 06:51:49 +0000
Received: from [10.71.198.71] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 01:51:44 -0500
Message-ID: <75322a53-dd50-4046-afc1-f59cfa6f7164@amd.com>
Date: Wed, 19 Mar 2025 12:21:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/8] sched/fair: Increase probability of lb stats
 being reused
To: "Chen, Yu C" <yu.c.chen@intel.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, David Vernet
	<void@manifault.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>, <yu.chen.surf@foxmail.com>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
 <20250313093746.6760-7-kprateek.nayak@amd.com>
 <8d4edcf9-bcf6-4832-8840-dd8aed1639a1@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <8d4edcf9-bcf6-4832-8840-dd8aed1639a1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 64589231-0c40-4f28-9e40-08dd66b2861c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUhKUnlRRDdxWktzbEl2K3B4RVhaR0lvOG9aeHgvVlZldmNCaUs2VWtWOWdF?=
 =?utf-8?B?VEV0WnZpNlhzNWFIcm56K3JVRk1tdlR1WkN3eHBvektERVgzWncvZ1M1VFJR?=
 =?utf-8?B?OGlENTdTQVpwamk5U3dhSDNZblpEZEFHL2RpeS9Ka1hSN3lYVTBleUt5NjVD?=
 =?utf-8?B?SW5Gcno5blB6b1VxcWh4ZTBaZ1FSNHNTbmFqU3ZERmp2ZUZtc1hDQVVYZjhD?=
 =?utf-8?B?YnQ3YTJTTWhjT2xWcWxSZnZ6Qk5LWEtEOUlFYnVnNTJTelYveVk3N3BJK01J?=
 =?utf-8?B?eHd4eXJ1VFBOQjdRc0xoSUd2UEJqSGExVjZIRjRqTmpEdUJsQTB1UkwyLzJH?=
 =?utf-8?B?Vk1nVzVtSGNPY202b0pNOVpBVnhhY2UxcEJ5WUkxNFFiSDdhRUxqaDM2eTNi?=
 =?utf-8?B?VGRETEo0TEJZQ05hQkZBMmsvVWphZUN3Skx0LzN3RFJCZGRKdUE5ZlBGcnlk?=
 =?utf-8?B?VUgweDEvSlZybnBDU2QxZGNHbkRpSHVNYjhWb3JCRDNIaDJUdWxpU2tDZ2NR?=
 =?utf-8?B?N3hSV3RJcytOais0N2w5OTMxbUw1bEdJYjkwK0ltRndmMnY0MWd2Mm8zNURI?=
 =?utf-8?B?MS8veDRGMmZBNUp6R3RrSHgvTDhvRm5LRWl5cnBGNzRqSFZWVVlSN20yM0hj?=
 =?utf-8?B?Y1BmQkoyOU91OGE1NGdlNGNQOG9ySWdZMDdzOUgyd0hVK2lUQndhaXRTUmtY?=
 =?utf-8?B?citXUjlPbzdqRTZqWUxRK3BHOTVpSFBCbjhmb2dOZ3VLM0dERTVhWm40S0dZ?=
 =?utf-8?B?QVM0V0oxOXcvcDdRY3ZEUHkrYUdqSFFSa0NYNkd3QXJwUEw2UDNLTEp5REhI?=
 =?utf-8?B?Skx1RXQySHVNY3YxSkcxSEFFaHZnWmcwVTJsWjhET3ZWVnJYUjEwRDc5Ny9B?=
 =?utf-8?B?SFJ5VmFjMHZ3eDhpSDlwM3MrQU9SNGtySWxSM0J4ekZPUkI1aUFhQm1zbWtu?=
 =?utf-8?B?ODNIU0d4RGM4aTNSTC83aVppbE81SERrdDRES1RPVjFkL2Q5dWw2U2c3TTV2?=
 =?utf-8?B?QUNUckVsUmdiVkhuRlNoRHpBQVQ2bjhlRzZTRFpnS3JsdHErN0hmOUlzc0ZN?=
 =?utf-8?B?TWRwYlBSY2NYM1NyK3dXTUhLR29hSEtIeWdiSWQvdU1Bb3FzUmJvcDdTVEFM?=
 =?utf-8?B?WVp2SlRZdExlcWlrNDR1N0oyenBuZ1J4SFFCcjE5b1Qxb0VYYWVyYStSWWxQ?=
 =?utf-8?B?c2x4RUlPZUE3Z3RxNmkxakRSVC83bTBlUTB2YmYwWlBvVTJsdnRNcVNtWjFV?=
 =?utf-8?B?TnMxQXhpNzVYcjVTdTZzNnp2d2h3Rjl4akxMZC9ONGN1ajB1NUsrYmt5a1pu?=
 =?utf-8?B?dUpNR3dWMHJZZ3pBTkppa2JZSExOOW81SlVJeW5DMmYweHNMOUg2K3hmaTBQ?=
 =?utf-8?B?SkVKVUR6VGNnTllKYmthK0FaV0dhbHEyMzU4RlduZlo5V0E0ZGMwVjR2WlVz?=
 =?utf-8?B?SVVPdWVSdmt2U3k2dytsalZQOEo3VEVKeGlqMjRqNGgvVitKb3ZlK2VSK01M?=
 =?utf-8?B?MGNDK0tCYndMczFNNWZ0aDVPN2hFQi9qYm5zcDRxVXlkYVc2dlY1Q0FOWGg3?=
 =?utf-8?B?eEgxWmRTNVBOb0NaR3FIeHdOZTFvY1IxT2ZlMWZmMWJ6eFhxK2hWRVZSeTFO?=
 =?utf-8?B?VlRRbkYvdy8xYVZ6aXY1T1l2QmYrbFBoT1dKa3hRaktVQzlDbjAzRU1mUXVG?=
 =?utf-8?B?cDJiblI0bFp3cDFrM2xxbmRwVFZ5RXZyVHYzdS9QbVJOYy95N25KWm9wSjV6?=
 =?utf-8?B?RWd3THZYRG1NNlFwTXlNQXkvNURtZ1NpSWo2eFlLaHdmQ3VBY3krU0M1cWhR?=
 =?utf-8?B?TGdEeStldlc1OWhCVTk5bFY5aGx4eHMvYnVtSzNZOVUwYXJnbFZZdW5KNGRz?=
 =?utf-8?B?d2pYYjZwemVqYlNsZHNjMUZVeDhTNG9GWVhONEdLckJSWFJBOUVCak52ZUlx?=
 =?utf-8?B?QkpodVN0UGtVUGZZRXVaWlNzLytEcmwxTXhSMnFuWmY4RFNVNkswelJzUmpq?=
 =?utf-8?Q?232/2RE5qzQHD5Y637CXSay06M4vAE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 06:51:49.6087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64589231-0c40-4f28-9e40-08dd66b2861c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348

Hello Chenyu,

On 3/17/2025 11:37 PM, Chen, Yu C wrote:
> On 3/13/2025 5:37 PM, K Prateek Nayak wrote:
>> The load balancer will start caching the sg_lb_stats during load
>> balancing and propagate it up the sched domain hierarchy in the
>> subsequent commits.
>>
>> Increase the probability of load balancing intervals across domains to
>> be aligned to improve the reuse efficiency of the propagated stats.
>> Go one step further and proactively explore balancing at a higher domain
>> if the next update time for a higher domain in before the next update
>> time for its children.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>   kernel/sched/fair.c | 18 +++++++-----------
>>   1 file changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 3b1ed14e4b5e..60517a732c10 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11956,15 +11956,6 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
>>       /* scale ms to jiffies */
>>       interval = msecs_to_jiffies(interval);
>> -
>> -    /*
>> -     * Reduce likelihood of busy balancing at higher domains racing with
>> -     * balancing at lower domains by preventing their balancing periods
>> -     * from being multiples of each other.
>> -     */
>> -    if (cpu_busy)
>> -        interval -= 1;
>> -
>>       interval = clamp(interval, 1UL, max_load_balance_interval);
>>       return interval;
>> @@ -12126,7 +12117,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>>       int continue_balancing = 1;
>>       int cpu = rq->cpu;
>>       int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
>> -    unsigned long interval;
>> +    unsigned long interval, prev_sd_next_balance = 0;
>>       struct sched_domain *sd;
>>       /* Earliest time when we have to do rebalance again */
>>       unsigned long next_balance = jiffies + 60*HZ;
>> @@ -12136,6 +12127,8 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>>       rcu_read_lock();
>>       for_each_domain(cpu, sd) {
>> +        unsigned long next_interval;
>> +
>>           /*
>>            * Decay the newidle max times here because this is a regular
>>            * visit to all the domains.
>> @@ -12162,7 +12155,9 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>>                   goto out;
>>           }
>> -        if (time_after_eq(jiffies, sd->last_balance + interval)) {
>> +        next_interval = sd->last_balance + interval;
>> +        if (time_after_eq(jiffies, next_interval) ||
>> +            (prev_sd_next_balance && time_after(prev_sd_next_balance, next_interval))) {
> 
> (prev_sd_next_balance && time_after(jiffies, prev_sd_next_balance))?

So the rationale here is to sync the balancing at different levels if the
load balancing interval at the parent is somewhere between now and the
next load balancing interval of the child domain:

                                            Move MC balance
                                             here for more
                                                 reuse
                                                   v
     jiffies <---------------------------------------------
                  ^                 ^              ^
             Next balance      Next balance   Current balance
             at SMT domain     at MC domain    at SMT domain


On some topology, it can mean slightly more aggressive load balancing at
higher domains but the goal is that cost savings of a stats reuse will
eventually hide this jitter of doing load balancing at multiple domains
at once.

I would like to fo one step further and modify the cpumask_first() is
should we balance to instead return the last CPU doing load balancing
for this tick but it became slightly harder to cover the case of delay
in SOFTIRQ handler being executed so I left it out of this prototype.
I'll try to add something in proper v2.

-- 
Thanks and Regards,
Prateek

> 
> thanks,
> Chenyu
> 
>>               if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
>>                   /*
>>                    * The LBF_DST_PINNED logic could have changed
>> @@ -12174,6 +12169,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>>               }
>>               sd->last_balance = jiffies;
>>               interval = get_sd_balance_interval(sd, busy);
>> +            prev_sd_next_balance = sd->last_balance + interval;
>>           }
>>           if (need_serialize)
>>               atomic_set_release(&sched_balance_running, 0);





Return-Path: <linux-kernel+bounces-442997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABE49EE548
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955B818870C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E640F211A1A;
	Thu, 12 Dec 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fo6xiZd2"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65720C01A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003854; cv=fail; b=WJWmoxduBPenFQU8q46PAsLxqhbL0p+AaS1FvRpPiMh+sX2pKhc5SlFj46v4fYWR0a9yIU4ojBGS1gJug5PMxjQzJo4o4Ly2wTboYHTr4rFtIW+e6v0/B27duLsq5vtKqvNn90Ey4obMEAOLMDXejdtR2/J2XqeHffEtkMsAAsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003854; c=relaxed/simple;
	bh=fCoctXxG7Zq0ExnRsiaVftlIE/6LWh+GOfVwlJNrQy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QxysSl2VUTACQw0NVYhS6QhSsi0uGVCtz83T9pecsfWux1GPUrJVRlCxgNQdSPq/QK2tDkh6q+/5BLJkCaZkjKSkONwsqQDW2WbbcVGvCpnJU9UAWSiW93mT+UQNfhFTZmqTBEFF3KQIYM2+8v+N7FmLMGrT6uyLg6S6C2EFNnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fo6xiZd2; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs25hYYgmZYgb6VRxbt5hoEyCOnaHPC/57neV43baz7sOqEsERyFxBVJGYw04wq/IpseczZTnaytzicJyZJJ84hb3GVg42N6h6w5p+7SQ3vb6Az40GreSwPqa79RA9G7MrM8XbOkqwAZ2uwrwit9WNgM+a+KOzRHAuCIuNhesZ6F59PMDqoI3++dRntWa+siJROPVNBRQk+LayyIX0FBJaujZ0VtrEuRKuYuE14++nr5ALnuAdM8Qi47n8mAmumMKwq4R7YeQIxC0TtX1/RH9YU8dvg0ApzRBLHUIqMPz3Mp8vFtROfcxBZFG8npxGbOXC3VKYv5RmMo+mjLaKGofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP8brSjUAz9BaWNkU+rK1vealnOG/E8oN4JIWnPRfGo=;
 b=q1bLHa4oNHgqQ6th67DpvJiOlCSZWUWtkZwMZmld1/bQKHWEUbLCS7wAgnv4hlO+KOwK+NbjTFxvNLNkvpIfF6pMWOGUMiJ2VymviCgvsCKoff1faPRLXN1r76I/onJya/Vp/52MJBrrmndRceBAY8agyLq2PFf+zIVMQm48scEtYR2r+1lka34uy3CaUgIjl4pCKVr26rRWL9L/+NzE7gVZjF/1e270P1LKKKtR6Q/vpc5kbYC5UGhS38/iYjgyQlvIFzmEKAac0oHPrLvL9W2/QiTk38jGVtgYI7mJcFw9GV4axwQV5zEq9JIn/71ELkKEj8pKEvCrnJ+1/SJxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP8brSjUAz9BaWNkU+rK1vealnOG/E8oN4JIWnPRfGo=;
 b=Fo6xiZd2okRHki3boQad6y0tVWi5bIMavhh6xMXfZ9rUmKXq1BfzdCQ1i1G3Wx0qT99bApzJIhnWDNrWIfuIPKFmNEcoHFB+nQ25PRoakadfA/qyJh8VHKsvyFX8wxJJdM9/Pg5X2mpjKw7qOVB05ClFO/zLqg+2spYPTM6Ow4k=
Received: from PH7P220CA0090.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::13)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 11:44:09 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::78) by PH7P220CA0090.outlook.office365.com
 (2603:10b6:510:32c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 11:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 11:44:08 +0000
Received: from [10.136.35.10] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 05:44:02 -0600
Message-ID: <b9315505-efcf-479f-b8ee-c660265c8e53@amd.com>
Date: Thu, 12 Dec 2024 17:13:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] sched/fair: Do not compute NUMA Balancing stats
 unnecessarily during lb
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
 <20241211185552.4553-7-kprateek.nayak@amd.com>
 <CAKfTPtAd-0e4B6qh3e5VeK0N1Q+zsXkV5WdCunV6x9yzY7Y_Ow@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtAd-0e4B6qh3e5VeK0N1Q+zsXkV5WdCunV6x9yzY7Y_Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbf315e-7a0f-4445-3d34-08dd1aa24a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkNCb2JLOXFFR0hNWC9rYS9NKzU3dm9PUDFncTlOT2k5WGdTNnJwZC9vL0w3?=
 =?utf-8?B?Uk1EbVBCM3JNcDNnTnpWQUI5RENvNnIxL1FmblRuZDhNKzRRNjAzdmt2RFpW?=
 =?utf-8?B?Y2JQVXEreXFmNjcvRmhwVnZMWXZoSllkYmNSVldVbEtjS3RINWxoUmFCUkwx?=
 =?utf-8?B?K3Q4SisrQ1dVVFQ4eVlTcElCUFZYdUpFcHlyVXYwUUl6MW4xcVdiOFhla3Rk?=
 =?utf-8?B?LzhjMlYrb3NTRlJ5OVZ4cWE1VHpqZ05HR2lDS3djcHlUOWtLdFBkUmMyd3RT?=
 =?utf-8?B?K3FoaitoY21VZTMxUkwwWURCaG94OHpCbjRtb0xmU3M3STRtbGJuelhZdjdH?=
 =?utf-8?B?bnpIVWx3ZXZ5VmJQZ1RGNGc0UFp3NHpCWWx2VTNIOFM5WnNhZDEwV0FMcjdM?=
 =?utf-8?B?eENwcU50bGVGTDJyQVZVeUx6cTh5OTlCVjMwdFRwSDFSUEJVVk1LSTFXSFJY?=
 =?utf-8?B?dGV2U01mbjU0TmdpNUs2TjlocDl6dnJoTFBJOEc2VmFla2pOQXIrUmZheWRr?=
 =?utf-8?B?bHBDai9rRTJ4YUxHZ0IwcDRrMnc0UnozZlZuMUdEMUhwZ1FwV2w4RU9zQkF5?=
 =?utf-8?B?Mis0bEh1c1REMDV4OGNUQ3k4YmYzK2NrZ293VFFydlFCbjVnSUx2aW8zQXRo?=
 =?utf-8?B?VXJiWkFsR3JpQ2szek1uNDgzYjFsQ3BGSzlDOC9CMCt4NHJkcE5CR0NYTU85?=
 =?utf-8?B?Z3dNdzdEQ3NjdUkrT0N3WTE2ZW5Ja3AxL3hRRng5UjF2RzN4dThSeFRuYm40?=
 =?utf-8?B?dTJXd0c5OFM4SkRvQlgzcnNwMzJ6UjE0eENTemd3cEk1NXdFemcvS281SGNM?=
 =?utf-8?B?bE5qRllCRTVkSXhxb2tjN1Y5NjhlQWlWZmszd051SEV6NWZVMlc4S1RnWVRE?=
 =?utf-8?B?cnBHYW45Rjg5dCtQVW1LZ3VMWk9UL054T1hzcDA1czNkNFpFdFZGVHpBalNi?=
 =?utf-8?B?aDJWQ2FMeUY5emMxYU44TmZPOHlLS1VNdm9uaXB0NCtEUmdUNno2UkhjczJL?=
 =?utf-8?B?cW82aStJQWl5SGYrVzgxN0k5YkdpL1VTTFlyMEU1M3hoTDcybVl1ZFZ4OTdX?=
 =?utf-8?B?SjBvMitJUWJQanBzN2xhSC82aWs0eXZMQWVFTnR1YWJ2QnVxSVFGaDMzMUZr?=
 =?utf-8?B?RlMvYWlwZEhETmRXWU5Odi80YWw4R0sySDdnOUxLUkRuZmpDcW1YVGtkRnU1?=
 =?utf-8?B?NTFhUkMyV2plTHl1RVJRRGtaSmNZUUpPU2RhNEY0SWdYZGpDazVjN09JNzY4?=
 =?utf-8?B?d1hhTWZ3TGxJMW5yY3R1UTFGVTBlY2E3ajRIYlMzKzBxeUw1citTYnFSYjVZ?=
 =?utf-8?B?eWJNNy9LU2lGbGZoVTdiZHBBVUZuS2RCZDdnVld4NktlRUc2MkJlaUM0RnhY?=
 =?utf-8?B?aS9LVnNnTzFJcC9GYlhGMGQ5NDVld0dpYnZoOFhRd01icnFxaXExM0ZFY09V?=
 =?utf-8?B?SFZybnBqSDlxZmFvbVQ3ZWFxbmQybFdteVIyZ1ZFemN6UC9PVU1sWlo1OXRN?=
 =?utf-8?B?RndlVmtsODBZVXZQakFzN2Z6MDluOHFQYkVBdzRndHJBbnpEN3RjQ0ZIRFBK?=
 =?utf-8?B?OStqTzRkOXQ3THAzYWtGTlA2Wng4NXdqbCtHMVVWdDdqSVpoUVhnb2NWcktJ?=
 =?utf-8?B?bjlidUlWdlR4dmVjM3NlNWNobEVVd1F0N1N2N0RJdXBtOUlkWjRCZzd2bTVq?=
 =?utf-8?B?Rk9vVm4zZTJFZzVYYThPWk83WDN5VnVJQ0diaFV4RExvR3k0Q29YUnRFOVor?=
 =?utf-8?B?dTBmTlZPekdyU0JJK09IWGx0ZnVJNHRZT1A0MUZtVWN5aUh0WFlpNEtVTEUv?=
 =?utf-8?B?RXRRaVJkSDFHTUk4WUhMaFJ5VXJlQ01zbWM0YmFhVnRzRTJpb3IvYW9pY3Vn?=
 =?utf-8?B?QlpVaGFHVG94dTRweU9HbGRJSmF0ZHMrc3lkMkc3RWhxY2w3bmd6VFVlbERY?=
 =?utf-8?Q?e3STLP6qOiNY50c8myN6NvSp0K6Dt+DP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:44:08.5057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbf315e-7a0f-4445-3d34-08dd1aa24a1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

Hello Vincent,

On 12/12/2024 4:35 PM, Vincent Guittot wrote:
> On Wed, 11 Dec 2024 at 19:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Aggregate nr_numa_running and nr_preferred_running when load balancing
>> at NUMA domains only. While at it, also move the aggregation below the
>> idle_cpu() check since an idle CPU cannot have any preferred tasks.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>   kernel/sched/fair.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2c4ebfc82917..ec2a79c8d0e7 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10340,7 +10340,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>                                        bool *sg_overloaded,
>>                                        bool *sg_overutilized)
>>   {
>> -       int i, nr_running, local_group;
>> +       int i, nr_running, local_group, sd_flags = env->sd->flags;
>>
>>          memset(sgs, 0, sizeof(*sgs));
>>
>> @@ -10364,10 +10364,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>                  if (cpu_overutilized(i))
>>                          *sg_overutilized = 1;
>>
>> -#ifdef CONFIG_NUMA_BALANCING
>> -               sgs->nr_numa_running += rq->nr_numa_running;
>> -               sgs->nr_preferred_running += rq->nr_preferred_running;
>> -#endif
>>                  /*
>>                   * No need to call idle_cpu() if nr_running is not 0
>>                   */
>> @@ -10377,10 +10373,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>                          continue;
>>                  }
>>
>> +#ifdef CONFIG_NUMA_BALANCING
>> +               /* Only fbq_classify_group() uses this to classify NUMA groups */
> 
> and fbq_classify_rq() which is also used by non-NUMA groups.

Yup but that just looks at rq's "nr_numa_running" and
"nr_preferred_running".

> AFAICT
> It doesn't change anything at the end because group type is "all" for
> non numa groups but we need some explanations why It's ok to skip numa
> stats and default behavior will remain unchanged

I'll elaborate that comment with complete details:

	/*
	 * Only fbq_classify_group() uses these NUMA stats to derive the
	 * fbq_type of NUMA groups. By default, it is initialized to
	 * "all" - the highest type. sched_balance_find_src_rq() inhibits
	 * load balancing from runqueue whose fbq_type is found to be
	 * higher than the busiest group's fbq_type but since it is
	 * always initialized to the largest value, and remains same for
	 * non-NUMA groups, skip this aggregation when balancing at
	 * non-NUMA domains.
	 */

-- 
Thanks and Regards,
Prateek

> 
>> +               if (sd_flags & SD_NUMA) {
>> +                       sgs->nr_numa_running += rq->nr_numa_running;
>> +                       sgs->nr_preferred_running += rq->nr_preferred_running;
>> +               }
>> +#endif
>>                  if (local_group)
>>                          continue;
>>
>> -               if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
>> +               if (sd_flags & SD_ASYM_CPUCAPACITY) {
>>                          /* Check for a misfit task on the cpu */
>>                          if (sgs->group_misfit_task_load < rq->misfit_task_load) {
>>                                  sgs->group_misfit_task_load = rq->misfit_task_load;
>> --
>> 2.34.1
>>




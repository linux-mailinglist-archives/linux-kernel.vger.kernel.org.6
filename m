Return-Path: <linux-kernel+bounces-445512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DA29F171D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A44B161FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77C1EBFF0;
	Fri, 13 Dec 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gPrAjeDd"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDA1990CE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120043; cv=fail; b=ep8LVZahBINIEuclxLfrPjE/twVZf4/3+E7b8pNlbA+2JxOZAu0TkqOCwP6tlDNT7LQ50fkRQIzSsLm6HBdByh/KrIMk7fM0uZYG9uEbZ618syBHeQbiMtKbeDlDfmGPlnpjAoqT1q4DGiKH8pqs0XA+F4pdVUrxIDwysFSBjvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120043; c=relaxed/simple;
	bh=sGtEzavHkZFOv+f0q39G7FmbM8sFke4nAHASZOQ/r1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RDJMx2MdA6NBnyAgQTnDmyGG6dtcv7HPDO9gFVEmZjHCgxB+f5Qf0tErakLa3NjY/4QerQZ8EQ9nnFTIXlRZo/e7joUa7v30N7/g9XzzEdRaAuaEkYYpudE5jOH7rcOzUDzGbZ0qM1ukGRhjDXBJJw0XjCmf2oxo3jVKAbugd1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gPrAjeDd; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDC1CfUTb+9TWA9j84pFDpyEWAceh8sNXyqog+IEIXx+pltv4IfW825X7Xjag9hsAA/RRqWevPFWtWdYNDZZ12FNiDwFd7QKxcyfcHzQ6pbBP5i4bxm6A3SUB988aEPheuJRXfmITTvgX89WfJSyckqneXrEJbxbyg39vN81EhZrQDSM+cSvukHqpQVZ8UlBbx8N5kWhni4lZ3dNmbJhXkYnIdMgANYsfuTxTYrgWEr8JuswYnF3wyAiRq/uiUQEJb2Yw/cN99XlUW8sygZln9ogR3097Rw+olzsTqjEt4ZgLdw0IHme6cqHpBVwDw6Cdj3GB4s1jAV0xEBwhhpoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QomHxdwEdEIhJIaRnm+rkniTOWEdrCMP5yj3sKv3us=;
 b=mjqy1WRcSVhcppAssTVsPPdBACU+bHaI49zqBEx1PfCvMF7hIpX1IqAnNOWZVAffKA48Q62DGT2cmapvWRBUkTTb2UaIz7QPirirEJyGrWurVE+LyPhK9T+j+wX6kCM07lhzGSJpP1i5rePlhxC7UECnzenYORYGunKeHwzOOUT19c+p6IS6w3uRo4srGEPPiO/JApIhLNt4AaFAHv57n34ScZqBKuXc8FYp99cm33mMT/zUpKaKlIoCKjgfBpTdTdcYIQ0Y9csJvQsODjCEGUOkCLlB8VRjAeTagw9eQFecayL6iZLjhgCJfnnGNGgtZKY/mQ0tUg06mE+DCJX1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QomHxdwEdEIhJIaRnm+rkniTOWEdrCMP5yj3sKv3us=;
 b=gPrAjeDd+/EE4X6RknDa+irqNJ4PG/hUk9kbv8TlhBiSkvR2tzeiLkLphZMmKyXghUhgClkhmchB6O0yH3go/lr2ouFVWNEHUPmsIArHt+KKGQ7o5qWmY/pzIuwo0yEafoBaMK2ocpvyakZjHRq4vPwm7MX28WeDsOvotITycpQ=
Received: from BY3PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:254::34)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 20:00:38 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::5) by BY3PR05CA0029.outlook.office365.com
 (2603:10b6:a03:254::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 20:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 20:00:38 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 14:00:31 -0600
Message-ID: <778f6247-749a-47c0-bc37-c42ced4c078b@amd.com>
Date: Sat, 14 Dec 2024 01:30:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] sched/fair: Uncache asym_prefer_cpu and find it
 during update_sd_lb_stats()
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
 <20241211185552.4553-9-kprateek.nayak@amd.com>
 <de1c97e0-9dd7-4e7f-b6f8-ce3f856c96f3@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <de1c97e0-9dd7-4e7f-b6f8-ce3f856c96f3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 903a04c9-c1aa-4901-4e57-08dd1bb0d072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlVlem9PbnBqK0NUT3VaZjFPT3orRHFJbHF6VTZmalFweGZBaUYvRWxoMTdM?=
 =?utf-8?B?TVR4a3dZMjE5RFdDRkdIN0FWdHdXQmRGZW1USnd5SFJqZVg4WG9iazlQMzFz?=
 =?utf-8?B?eWZXMXQwRGU5STg1TVV0ZXdpa3JmNkhlR1RSdjV1VnNaTi9YNmVDUkhlRGNV?=
 =?utf-8?B?ZkZUOHhaYmI3dU9TN1Q0T0NGd091aWJkUmdGSk5ETlExMHhCemxNQTN4NUkv?=
 =?utf-8?B?Wkl5QVo2VDhBM3QvRlA0ZjZBTzhkelArVEZtZW5FeEhCaVpUR0RyZlVyNlVB?=
 =?utf-8?B?ZlUwUk13L21lUVZ6dWVObDZ2TjNoZitMRUdTTDJObnNqaHdHdjlFamorRFcv?=
 =?utf-8?B?K3RyQkx5WFFaSWloWCszaVdwUGZkaG9mM3U1YVJGS0phaWtBWVBWS2RmVStU?=
 =?utf-8?B?OTRnc3A2STF4enkrRTRCWXNFbkZjN2tXZGhWdCtXUVdEMm1yd2hFR0ZtMTVS?=
 =?utf-8?B?Q0liWTVacTl1NlNKa3Y5WFE1bkdyeXNIbGVpTm54Q1YxODd0N0hOS01XWDR2?=
 =?utf-8?B?cXkvbjdDcm5mS25XV0s1V1dNYzYvU0RXbWFOTDBOa1pPSm14N2JkODlEWGJU?=
 =?utf-8?B?T3h0ZGRJVTMycGFmcFRSSUlWMjRvbjZzd0hDNks3bm05VnBRSlZOT2hvcUFr?=
 =?utf-8?B?UllIbmUrcjZEYXBXZytEQnpmbTdXRUxzbXBQSEtidWpKTjRpVGpIRy96K2FV?=
 =?utf-8?B?SkppMjFaMzd3L29IUHR3ZlhxMTRJek5ITXRmSnVGRlVvMHVGM0U4Q3B4SDRH?=
 =?utf-8?B?RjJvSklwSzNXRnVoc2FHRWlOVXlJQzdvQmVzTVgvZDhSZVdrY252SEJjaEQ3?=
 =?utf-8?B?REFOZXYzeno3ZXpmVU1hNll1cC9BcW9uU20rbXdqc3dUMXFDbDk0UzZKaUtS?=
 =?utf-8?B?djZ4M1pLR2dqTkNBQ2JLWFkxT3dTNlh3MGpxSmRNRDFPYzZaemV6UHIyQ0hK?=
 =?utf-8?B?U1V2ZkorRjRldUQvelAwdHhZSHpFMGFDQUlIcnF6TUFNTjYzTUxHSmlWTHhn?=
 =?utf-8?B?eU5SZFdYTGlnSXBVRFZwalF0aWNRQ1UvUmdSZFlFNmRacEdBNHk1YjRqYWRE?=
 =?utf-8?B?VHBVVko4cWNpL09MM0ZvSmwyVHRja3ZHYnljMnVtQnZSSEpyclJlNHZhYTZr?=
 =?utf-8?B?ZmM1cGNCZUdsd2ZTenN5cjM0M0syeE5hejF1OENmQnF1NTZpNk0vRDRoUHRP?=
 =?utf-8?B?M0t3dXZ0bHpIa3hKdkFuQjFJV1hDSitmRmJlUEpmSG5lenE2UnMwSjZWSnVF?=
 =?utf-8?B?VTRvcUNUK24xalg2OHBCZjlNTWE2NDdDRGJibnRzOUpKUnZpdEVQNDUwYWND?=
 =?utf-8?B?dnRUci9CeUYxdUpSK1ZUUmJ2RmF4UFBiQnM2Z2NaRzZsYm0ydjZ4Y3ZETGFw?=
 =?utf-8?B?TDBtZEY3RnRJSVU5THU0OURpbFdTZTNSeTZiVjhRd1p3V3ZvRUt4amFSSkNw?=
 =?utf-8?B?UTlKNnovb1c4bmFSUlFTemEwbVZQVWdsb3NGb0JMNFhiSlZ0b3R0YXVESnlx?=
 =?utf-8?B?UFFnUkJCekh3cmU3VytSTEt4dGt0YThHakNYTElrM3lKRXdERlNFdXhGd1Nm?=
 =?utf-8?B?RmU1VzNLcjdQWUVoK0xHUE1xeUp4WG9mMnVOSC9LSk8waXl0Vngyb0EvWDdx?=
 =?utf-8?B?SlFoSDNKVytvTDc4Q2swNjBZSTVvUDI4eGNDUU44OElsQlU2eHhmVmFlKytt?=
 =?utf-8?B?YktsKzhORUZvTWlWZ0pRc2YyRnIvTmRrbUhEQ09NdmR0NVhpNy9haFRpNUFq?=
 =?utf-8?B?TWpuY0hEcDIzelQwYmdiSk1rQjgrUEo0Z1F4ajY5cmpXTW44RmEvSXA2NWZs?=
 =?utf-8?B?aVZCekJHOUZLcUt6TkFQRzRWY1VpRTE2RUhkdmo3NW5ZM2pFOTV1cW9iV2dM?=
 =?utf-8?B?TjBudll6MGhualRRMS9SV3hhQ3Z5aWhFVzNGenZvN2Z5WWJ6cEMyakQ3ZmVL?=
 =?utf-8?Q?7CpTsHybFm/mofOJEuExeiPu8hMCVoV7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:00:38.0105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903a04c9-c1aa-4901-4e57-08dd1bb0d072
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

Hello Shrikanth,

On 12/13/2024 8:32 PM, Shrikanth Hegde wrote:
> 
> 
> On 12/12/24 00:25, K Prateek Nayak wrote:
>> On AMD processors supporting dynamic preferred core ranking, the
>> asym_prefer_cpu cached in sched_group can change dynamically. Since
>> asym_prefer_cpu is cached when the sched domain hierarchy is built,
>> updating the cached value across the system would require rebuilding
>> the sched domain which is prohibitively expensive.
>>
>> All the asym_prefer_cpu comparisons in the load balancing path are only
>> carried out post the sched group stats have been updated after iterating
>> all the CPUs in the group. Uncache the asym_prefer_cpu and compute it
>> while sched group statistics are being updated as a part of sg_lb_stats.
>>
>> Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>   kernel/sched/fair.c     | 21 +++++++++++++++++++--
>>   kernel/sched/sched.h    |  1 -
>>   kernel/sched/topology.c | 15 +--------------
>>   3 files changed, 20 insertions(+), 17 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 3f36805ecdca..166b8e831064 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9911,6 +9911,8 @@ struct sg_lb_stats {
>>       unsigned int sum_nr_running;        /* Nr of all tasks running in the group */
>>       unsigned int sum_h_nr_running;        /* Nr of CFS tasks running in the group */
>>       unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
>> +    unsigned int asym_prefer_cpu;        /* CPU with highest asym priority */
>> +    int highest_asym_prio;            /* Asym priority of asym_prefer_cpu */
> 
> Its better to move this after group_asym_packing field, so all related fields are together.

Sure, I'll move the around in the next iteration if folks are okay
with this approach.

> 
>>       unsigned int group_weight;
>>       enum group_type group_type;
>>       unsigned int group_asym_packing;    /* Tasks should be moved to preferred CPU */
>> [..snip..]
> 
> Tried minimal testing of ASYM_PACKING behavior on Power10 Shared VM. It is working as expected with the patch as well. (functionality wise, performance isn't tested)

Thank you for testing! Let me know if there are any visible regressions
in which case lets see if the alternate approach suggested in the cover
letter fares any better.

Thanks a ton for reviewing and testing the series.

-- 
Thanks and Regards,
Prateek



Return-Path: <linux-kernel+bounces-445473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3E9F16C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA250188441C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E8518FC65;
	Fri, 13 Dec 2024 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mPcTxVdB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087518027
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119527; cv=fail; b=ged1LdO6l3k6UW7XK2uyoMqRGgvdlswpfdFiwgu760Ln/4n3qINTKJP70e7Ix5/YsVsGo8rNwNuE4s7To93YunJIG1IyzPyBZQjPXleDIk+Fn9ezy05jmSpl7DsCC9ou3zeYOo00x2AXAcSyYJN8DZYOd8G9xJFQt4nrC9qZ3BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119527; c=relaxed/simple;
	bh=O1uHzKE8EF+Dmr8U5NV0aKAeFbv61IHJ+EkeXl1e4yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ang09f0xxQQVvjToRqs7G5lAfsTfgs0XFDdt4rAe3Ag31plUcZS2Frl6pBHdQo4QpaBrqxaC4AnlR4lrvQkNc26KA7eUxFqa9K+hoDdD33MIFO9yV94ezrnMWyVjvu2ihTHGvb+aFeHfXUWrYR/+D4wo7AhTsflZbvEBtP0sEcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mPcTxVdB; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMq8t7l9Sa3kUEg/RnFXTcuTfx82RXH9p/X+1xhzqxycgAwWmx7YQby0/A3fSPWQFzgeNaEVNIYF1of+gMeOboPhp5G4vgWkwsYbke5YiU2apVI5QkcHlnypuQEWtkRd8aYVBQOz7LFDohue54Lang/6GXj9tJWX+lAOLAxiCwhMtuxelabRppKIld/pvF8xl8hdn4ybKyGtV13/z2+Z7mE4axBKGMPiZiydYHXwRvtHrnJAE1YbewuO3uoOuFgTkYq8kY9Is6O6gCugqc2XDITbXf5Onv3u5u74yXtnY976X6aCMW7wC2yfplQ44+vIXEyUqjnoP0q18kAdTvmYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8W7t20Uwdr0H9CcYOqoyopC5q4wjxx76DwT5qT/v4A=;
 b=u1Srarg4bBIP348f2XOhyVCIlHHBJNAikESDAWN4EUSStklp70A89FftIP6EX8emf+ShQ3yGkcGgT7JhuXiftsjbepfmbv6prD6rPsxIAieHWlWuyY0Y+dp9HCRGzlbojt5kRaG/aQCW+aYzrxjYKFWtoeBxa2BHJv4sO51g2QC5GS6tnic7a598uBileqeMQlwcXzoeEQSTQ6/zSyosLDWsd7VY1pIcgjnulZ6pDOporTjpC+me3g89J4fgFlheHtEyHVaDkwelx1biaZ0rnGEVndb7Ziu53vvf5DlpS0W+f8phE/l9y4Kn6TomAM6GKXFSqlIMd0hly1Oc7dEB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8W7t20Uwdr0H9CcYOqoyopC5q4wjxx76DwT5qT/v4A=;
 b=mPcTxVdBWX9iQ1k+QdaLrZvwiqm0plt5sgTeZs8QSb2Cps8ZpZiyam7vvc3xXnYEbk5YTANhawq+k8Y2W3aHG9Tf5cNsdkMC+jVhYNst4LE7NH8OlySPjj0SXAT9TdaS09Pwit6pHPjrSqL5Gnb0xhfbBf3EsM0FZGtaixd1HEM=
Received: from MN0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:208:530::20)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 19:52:00 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::99) by MN0PR02CA0030.outlook.office365.com
 (2603:10b6:208:530::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 19:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 19:52:00 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 13:51:54 -0600
Message-ID: <ef5d950e-81bb-49c8-89ab-4f62a9529994@amd.com>
Date: Sat, 14 Dec 2024 01:21:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] sched/fair: Do not compute overloaded status
 unnecessarily during lb
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
 <20241211185552.4553-8-kprateek.nayak@amd.com>
 <3ce396ad-162c-4e60-90ee-01fd58a514de@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <3ce396ad-162c-4e60-90ee-01fd58a514de@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdf3022-6b6e-4e19-cca5-08dd1baf9bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzFsT1k2bHlwR0tTU1pBTVpmeUFUOGNMV3ZuSDBPT2VJdHJMRFRKRkJyNE9E?=
 =?utf-8?B?Z0N4emhzdW01eW1oTWhCYmZ0SkRoY05rQUFaSlJjdGhPRWZYVm5nN0N1VElj?=
 =?utf-8?B?Qlltd2QvOHZ6bFk3ZzVYaWlwMXJ2THZPT1NLelpTREoxc0RFdGxtRTFGREdI?=
 =?utf-8?B?VzAzTHFlK20yR1pVZEJOUFlSSTJvcmJNYmd3R0NjWFNscDkrR0d1OFE5SFlG?=
 =?utf-8?B?NndSM1pSVjRPYURjNTl5RnY3OSs1a0xpOStNZXR3dlVpRWc2UXlMMXIxdTJQ?=
 =?utf-8?B?WlZnd1ZKUHF6QkRjMzRoRWFsdEVOSEV2a1ppcHRkdkFNaUgyYkt2RkpXSWJD?=
 =?utf-8?B?NThvSzVmNklrM09kY1BWZTZkMk95UUd5MnhkV0YyV25GSVdTeWoxd0hIdDNj?=
 =?utf-8?B?S0k2ZVJjRHdCYW9GYktIVTJGbGM3ZHNlL3FmcEluc0dqd25sU3lCcDJmOG96?=
 =?utf-8?B?UGtBdFhtUW1oTXdvcVR0Uy9GTGhLUnFkTm53N0NRRVM3ekV4RktvMEltOVo2?=
 =?utf-8?B?d2pyb05LR2xMeTdtcW5hQ3ZlUkIrSjdKY2pQZmhVN3RLN2JiVXNGSVV6WFor?=
 =?utf-8?B?V25Ubk9vOVdFS0ZrWGpDOVZmTVJsSXh1c0REOWpZN0ZESGJtM0FLNzJ0dHlO?=
 =?utf-8?B?Mm03d1QvMXFGWGRvM1Y4cWtuaTdycllqYXVZT05EeTI5clc4R0UzTzFsZlg2?=
 =?utf-8?B?eGhQVWJvRTJhNXpJMTlEWEpFWmlXejYyVHowV1NuYmxMS1IyRHkvY2gxM0xr?=
 =?utf-8?B?ZkltbFdZMWtoOURCOGpYQWgzcTNhUGNORXFka2NEeENCTjdmYVQ3MmZOUE0x?=
 =?utf-8?B?UEpyak14bU1sa3FxNm9QOEpGVmVEUWFWdlNldEpjSWhlaHR6bzZvRFZrT0J0?=
 =?utf-8?B?enRmc001UHAzQk1uMUZINllISkczdjF1aUh1aCs0V3UyNlZVeU14Ym90NHZ4?=
 =?utf-8?B?SGVrem4zMzZMSmtJaVNJL25NclU3aFMzQzBiU05hMklpMmN0dG1ZazF3R2dX?=
 =?utf-8?B?UE03endUbWJsL2QrVjhIQ0NUemFLa1QzTDN4bERKZlY3cXA1djlGcGpxSlox?=
 =?utf-8?B?MjFOZFdRamZaU0xBbEdOM0hFRUdBVGIzU0NvQ2phMnNiSVJQYTlzOTFieTFW?=
 =?utf-8?B?dGJLZlZCRzdQbTdYN1BJaGY1U3JWeVN6Vzk0Wk1TT1phT2pKOG5YQ2R3cUln?=
 =?utf-8?B?WnFDOHdSaEV0RVZsbUlrd2VOd1JVeHoyVElTUjBYNDJ4emhJL3FOUU8rMnha?=
 =?utf-8?B?dWpZYVF1c0tkeEx6MVdxNCtHSHdNUXJuZWxnSER0UGZ6U2dvRjE2QjhsV3dv?=
 =?utf-8?B?dzM1TlpGVXFKV3NpMUdKTHdsSGVXMVNxbWZpeW1ENFZaalRTVDc2NWVMc2lm?=
 =?utf-8?B?NS9INjRuOTZ3UTkwUHcwRCsraExKQnFFWXlqWXFZOEVkRldUVjJEaWd0YTQ5?=
 =?utf-8?B?d29zWTRYNmNaVWRwV1RxZEZldTBaM0h6OFREaUZkMTkybTY5TmtxcDZCZmFa?=
 =?utf-8?B?WXZDTGZ1UWovUU4vQSsrU0h3VEw3TFlOQmdpZ3FOWVdXTCt6SlEzV0E5Uncr?=
 =?utf-8?B?aENsVklIdEFaQnZBNEdncFl0S0tNbWV1SkRXdlcwcnd5OHNzbzJGcGRtYjdm?=
 =?utf-8?B?ZEhsa2I4cUxNVEsvamVkTTBXdUtWelVXenJWL2VaWUc3dTgrcjkza1hNM1Fv?=
 =?utf-8?B?dmd2Lys5dDdobTl0Si9yOFFQWnpsYzBvcGpoUVd1b3p4WThJdFE5OHIwZ1RX?=
 =?utf-8?B?dDJxQWVsaWNkaE1yRFVWWEJMeUMrQmFSUUZjRW1QQnBQUmRqaEhxakFNMCtm?=
 =?utf-8?B?eWdnbXNobnBPdVE4T2xmbHdDeG1mQzEyYTd2YklkZXd0SGdDdVRySFJMQkN3?=
 =?utf-8?B?UmZpSmp3T0QvMEE1YXdRbnFXZE9jSFhyaFR1OXBBWDNGaTRXUFRkWVlyN1FY?=
 =?utf-8?B?ZHRKWmxnR3pGQlVOZTBxd1FINFRuS3cxVGkwVmx0bm5wVlUwZWJHYzhPOVMz?=
 =?utf-8?Q?Jc3rUVD6bamSxtzHKjvQk3HkJ8F5i0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 19:52:00.3560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdf3022-6b6e-4e19-cca5-08dd1baf9bd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

Hello Shrikanth,

Thank you for reviewing the series.

On 12/13/2024 8:27 PM, Shrikanth Hegde wrote:
> 
> 
> On 12/12/24 00:25, K Prateek Nayak wrote:
>> Only set sg_overloaded when computing sg_lb_stats() at the highest sched
>> domain since rd->overloaded status is updated only when load balancing
>> at the highest domain. While at it, move setting of sg_overloaded below
>> idle_cpu() check since an idle CPU can never be overloaded.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>   kernel/sched/fair.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ec2a79c8d0e7..3f36805ecdca 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10358,9 +10358,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>           nr_running = rq->nr_running;
>>           sgs->sum_nr_running += nr_running;
>> -        if (nr_running > 1)
>> -            *sg_overloaded = 1;
>> -
>>           if (cpu_overutilized(i))
>>               *sg_overutilized = 1;
> 
> Maybe its worth moving the overutilized too after the idle checks. An idle cpu can't be overutilized right?

Since there are no tasks on the CPU, there are no UCLAMP constraints
which means the cpu_overutilized() boils down to:

	!fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu))

But the averages can capture blocked averages and capacity_of(cpu) can
also change with arch_scale_cpu_capacity() so I cannot say for sure
with 100% confident that an idle CPU cannot appear overutilized.

Vincent, Dietmar, do you think it is possible for an idle CPU to be
overutilized? If not, I'll move this update below idle_cpu() check too.

> 
>> @@ -10373,6 +10370,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>               continue;
>>           }
>> +        /* Overload indicator is only updated at root domain */
>> +        if (!env->sd->parent && nr_running > 1)
>> +            *sg_overloaded = 1;
>> +
>>   #ifdef CONFIG_NUMA_BALANCING
>>           /* Only fbq_classify_group() uses this to classify NUMA groups */
>>           if (sd_flags & SD_NUMA) {
> 
> Other than the point above,
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Thank you!

-- 
Thanks and Regards,
Prateek



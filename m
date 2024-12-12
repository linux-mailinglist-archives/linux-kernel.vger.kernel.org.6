Return-Path: <linux-kernel+bounces-442959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7625F9EE49F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A47C188511D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FFC20B1E8;
	Thu, 12 Dec 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pKzZ3F7L"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAB1E9B36
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001308; cv=fail; b=K1D7kQNnwWgxgiSjiPBO8k5bmvjj1tuXlKGYR2vlGBUb9qfB4y2QqBhJW4+GEZPr14sg7MXtvlttyDvkGaBAC14rGVdM5Fz04/1EFesWY9FhrMAuEiTr+Op5kNXVMy3auEbcLOWekLkTVLo5guU4iIa26F155Y0sI9/3vsUjFNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001308; c=relaxed/simple;
	bh=L0h7knlFD5VDSe2xPKSj3vK0+PzNbHLKpW9nUMrp3uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ui7UQx3TSYYKRbEqJVIAYHtLqzmvWblEqOjcaM/uCFqk5Z8weqVJUMBR05kksm+F9OtDWUXRtbGCiGj7fo70EIQGZhmZI5y4VGwfAmkKYW6snv/zOkklpOfTkOG9oXRDoY2WO67/RkzMv/f8p6WofuTEHAWEFQc3TvitsS2JCZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pKzZ3F7L; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7A/jETjFzMWtb08F8Tmhpeti86GUaBbPLxCgRCNWGtMd+x2gM65EcqTq87q8mIGp+6k268ce7oBmmLfT9yMWc12OF7QF8RXrsc+7Z9RzaoXqxzrY8ZychtLIKGuPQhM52OFL6W8dY9qAKcjYjoMysV+4tqEsxH8yopDAcKktGdI5R0I4k4P9Ri8vVNRp++jM2xVnXJwBZDEA+9djeyUYRnbVKcdUwDaUt18f4W9Apz8Ns4Z/+LIVrr6cj9+gDaM9YB5Lso7nmcmd0aPXaxLfSeEhxfmUi5Dw+ct4OFT7yfLvAo8fcFQX85bY4l1pXSeMCTn2v6BFO3+m8zoETcMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1wj1sUQNOguRu4V2wejRn3CEOpvAigDbt5NAkyTmNo=;
 b=rpSiw49or/7nvv9Q9iSDJorawXbzQs/TIAUx9o7dY6tjaxPgWl3MyuUBequEdtbxWK24Dv8XbeCFrq7f5b9EErZJvVZDiHNdH3bE/FEerZoI61nK0w+mOwqut30IhGMn1vtD/9+wvajEBY6XGJVYH9+X7/KnvTXn0Y9U37HzyBgXLwnI61bUM5wN9OXaAfE8zeX53YFEo7ReMDTYBzssupZgP7w36iUzguar6TpoNBLChxokY0solUHE1WQNDQhFnguU1RyWIQI+ZVdALOR7Fw4Fn89u3k3/RwGdjvmAoAfqZC8wL3YI0PTL5vxJSaYH0Cdie1neMU5X3JTbHIsHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1wj1sUQNOguRu4V2wejRn3CEOpvAigDbt5NAkyTmNo=;
 b=pKzZ3F7LRG8ImzCfJeP3SfoMyom73znHNWN5T1rkNRvc5Q6TNTqFLTKRxd10ogtLVqdugnR/zItSz5OLun/vdq9+ibD54ZKQ6GsBQscWWLPzEDKeutW9xkx5NAX2RrxNs1j7rUIxWSwq3BdBy+AXS7aRWKba/YVaVdNnGQDUnaw=
Received: from BN9PR03CA0583.namprd03.prod.outlook.com (2603:10b6:408:10d::18)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Thu, 12 Dec
 2024 11:01:41 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::fa) by BN9PR03CA0583.outlook.office365.com
 (2603:10b6:408:10d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 11:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 11:01:41 +0000
Received: from [10.136.35.10] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 05:01:34 -0600
Message-ID: <a79e0e83-d1e8-4a16-a317-599e063d4797@amd.com>
Date: Thu, 12 Dec 2024 16:31:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] sched/fair: Do not compute overloaded status
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
 <20241211185552.4553-8-kprateek.nayak@amd.com>
 <CAKfTPtDQy=VfH3Ta8zLSACX7QV+LWaRvj_ueN=iSu5i4t8oBtQ@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtDQy=VfH3Ta8zLSACX7QV+LWaRvj_ueN=iSu5i4t8oBtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b75434-bfe9-47ef-08b2-08dd1a9c5bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ny9vUm1uVnRYQXpkeXB6NXJoMzN3Tk11dFA0TUhxMmo2aUVicEMvbDE5UitT?=
 =?utf-8?B?aUNheUtFbzNSQmcrSmFzbzBqWmpGbVJueDAxNElaOEl3UUZsUGE4djlqeTFC?=
 =?utf-8?B?bEFJdzdyYXhuSjZZdDNtNDl6dmhjTk1tSElCNkpSQ25vQnpuSXFMK0hZcWJn?=
 =?utf-8?B?UW9hV0R4eHVoUzdFZzdqaGxtMVJkMVNvQmlJNVJvVk1ZOXBlcDAwbHZlTjhS?=
 =?utf-8?B?N3h3UHVRUGFlTzlVSm93QzgzbG1IN1M2LzNyUmNkL3JHMmRuWnFHK3N6RFI4?=
 =?utf-8?B?NkJQbTdsTThwd1JQbUJWQ3VXS21ZdVI1L0lHbXROMkhNbzBRTkowQU5Fc3A1?=
 =?utf-8?B?OEFVdDc2WTdxSTRZL0NJVWpxVkRCaW1kcVJUTjA0VzVTQnBKVytkY2wwK0dz?=
 =?utf-8?B?d0FTN28yMmJEdEVOL0FicXdGekxXbFpYZGRwdWtxY2hzK2w0WTB6WHFId1A1?=
 =?utf-8?B?OWhVY0N6amw0dElsdGY5Z1doak5HdTNzNkJQTS9Vc0RJZUNhRHEwZDJ1K294?=
 =?utf-8?B?QWJhZ3B2cGRzUk1QQVExQWNLMG9EaWpZQXdrOWtuWjVJckJ4K3RzKysxVjd5?=
 =?utf-8?B?TXlQVHB5OTZWRmFEVlkxSHFUYjZQZnZlejY4bkJsNHVJZmE1enN4eDJ4cXQ2?=
 =?utf-8?B?T250ZS9aZE80NXpsR05ycXdKc2c3R3RHY0J4bEZzT0ZtMzZtc3BYeDlKMzQz?=
 =?utf-8?B?ek95b3ZRbXRYamI5RVZ3cFJxdmtrcGIrbkVXVHIrS1JsMTVCUWFVQ010OXVp?=
 =?utf-8?B?SS9kdXhZS1Q3VSs2V0UrY2RCbDZ4QzZRd1U5bVcxazZhcU94Y1ppQjJkRzc1?=
 =?utf-8?B?UnBwNWZMaTNwQVh1TkJybkRZU2VyaTZaQ2JMQ1o4dVk4L1Jhb0pxTFg2b3M2?=
 =?utf-8?B?T2FNKzYyWDJJUWpBUjBYcUcrNGxnKzVKK1BGd0xuMGJXOTM4a2F0K2tRUXE5?=
 =?utf-8?B?U3lSYkhoTUl6TmNBeXpWYUhYQzVEUWI4Nmx4cVh3OEN5TWtPN3Btc2YxdFZK?=
 =?utf-8?B?TUkvb1hDcWVDQ1Y5RjRXT1dKVnJQeTA5b2NXSjlLNTFjeTFoYjZjNUxWRjZt?=
 =?utf-8?B?MG9KdXY2S1VFKzUvZWM2bll1d2NwREg3cnZwRlpjaW9Ldm1lMjJ4L0FERmJl?=
 =?utf-8?B?K3ZNVTI0eFUybnJYNkNWM2lRaC8yNkZPZDA4V3MyVkY2eHFnSzBYTkVUU3p1?=
 =?utf-8?B?S1dGY1JOS0o2RWs5ZkkvSExXN1o1b3kyMmgxVVROT2N4SDBqbTlHOFp0R2li?=
 =?utf-8?B?b3VNT3JOSkwxNHRZY1h1M1B1MDJqWkZKczk5STd5aHpZNUlVNFZncEE4UGNT?=
 =?utf-8?B?eXN3OHJZTUNGWlNmb3JPbzAxbVlEblBHajAyYTBEOHE4WDVuU3hWWXlEV0tR?=
 =?utf-8?B?dUhJbllEODRJWEhFeFhGTG9FQnNIeFJHbnp4ZHlqNW51dk9lRGd6N1huM0Zr?=
 =?utf-8?B?SUxvU1M3VjhOZ3B3S1dha1liUWxwSFFid0M0S2FTbkRJOU9ZdkxLTnBrbWdX?=
 =?utf-8?B?dDQ1WFlNaTYwTXQ3UHFBS1J3NDMrczh4N3hNbG9aZXJqbmFTOGczUW1ReUlL?=
 =?utf-8?B?REVOMUdwbkJvUkdhRTFoSEhwaDFFK2srdVY3bEZnejlIcXJJaVhRRDg3ekhU?=
 =?utf-8?B?ZDZNOVkvem9hNlFaUDVkSHVSNnFES1F1MDV1YnNuSlFwdU1DdWZVTHhrMjZK?=
 =?utf-8?B?SjIxN05qSFZ6WGJLS1NzdzNEenFweStKQy8rRXNCSU84TFFLYTRmWTIycjdG?=
 =?utf-8?B?NzgvUGdvYmIyWWxRWENFbmFQTDdEY2VrMkg1Myt5bXo0N1NrWnpMRzVBMTlY?=
 =?utf-8?B?bUlQRU8xdVg1THhLZzcwRHUvcUtVYkpsNnhYbkVQQ29hNGdJZTNoZXFna3dk?=
 =?utf-8?B?QVFOaDd2VEk2a1Nhc05KWkxza3d0NTdzNmxaVlkyRlFmcjVUWHZkQ0tVeEE1?=
 =?utf-8?Q?lP4SmGFCc72v3cy4Fy3nblggNxtz8RA1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:01:41.0227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b75434-bfe9-47ef-08b2-08dd1a9c5bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549

Hello Vincent,

Thank you for reviewing the patch.

On 12/12/2024 3:26 PM, Vincent Guittot wrote:
> On Wed, 11 Dec 2024 at 19:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Only set sg_overloaded when computing sg_lb_stats() at the highest sched
>> domain since rd->overloaded status is updated only when load balancing
>> at the highest domain. While at it, move setting of sg_overloaded below
>> idle_cpu() check since an idle CPU can never be overloaded.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>   kernel/sched/fair.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ec2a79c8d0e7..3f36805ecdca 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10358,9 +10358,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>                  nr_running = rq->nr_running;
>>                  sgs->sum_nr_running += nr_running;
>>
>> -               if (nr_running > 1)
>> -                       *sg_overloaded = 1;
>> -
>>                  if (cpu_overutilized(i))
>>                          *sg_overutilized = 1;
>>
>> @@ -10373,6 +10370,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>                          continue;
>>                  }
>>
>> +               /* Overload indicator is only updated at root domain */
>> +               if (!env->sd->parent && nr_running > 1)
> 
> nit: may be worth checking local variable 1st which should be cheaper
> than env->sd->parent

What are your thoughts on passing NULL for "sg_overloaded" when calling
update_sg_lb_stats() at non-root domains? Would it be equally cheap to
do:

	if (sg_overloaded && nr_running > 1)
		*sg_overloaded = 1;

> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thank you.

> 
> 
>> +                       *sg_overloaded = 1;
>> +
>>   #ifdef CONFIG_NUMA_BALANCING
>>                  /* Only fbq_classify_group() uses this to classify NUMA groups */
>>                  if (sd_flags & SD_NUMA) {
>> --
>> 2.34.1
>>

-- 
Thanks and Regards,
Prateek



Return-Path: <linux-kernel+bounces-258642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27473938AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7039281F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4062B167296;
	Mon, 22 Jul 2024 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SOlBMXF9"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92746161326
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636130; cv=fail; b=t/ZrGAx3ErdLmCw7RFHIXA0wQXD7mIAbEkM5b9FhCoRyiUR/s+3N0kJIPsdW+5NPiDESaUS2aTHSCh646t4QalFPtwv4AXQPcNhz5Lst4jta4UMCNnNaThQZ2Jh3GbrFOHRjcGVUJjBTjXfl2p9qsw5TJlR4lII4081q69l/2tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636130; c=relaxed/simple;
	bh=k8BaEkgbz54z9mDsaAnDFQ1r2lUpZUweRLBJlaEY5Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aI9HapU5KZSe8tqEm99y/3DkFkbOcnZj3nFm4GABDdJthY8rx2hBd2Mh//wYLXUmjUZhhxvkqOn8Ldek3z/QJ8Nb3AJRBqOU2JcVv1pv4AWXaigNszsFRNNiV/f82yPXy7iV5NSNXJWkPL19ETONyjI6O11rwG2x1w0QlUBMJ4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SOlBMXF9; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pstbS0rkjD6gkU+OY+R5LA/Sd7KEX87Z7BOy1x41stXnVqCwvwzReS+OCQzt3uKNbLm2DvWvI0/R1KTDV7pt9CH6+JVfq2lQZlBG/R3ZSS9QRn47nq6T7Vs7otOIzI+OAzhCyQjmCeA4Ij7uCd4+CtuQLkjCPWJsM5BpHCd/ePW1j1JxYO/bB6ir5OJ3tVYAaSywcj3Au4RBx63VftGCUm+sXTeNk4BU0SEkjcHaUYoeGT0siiujwNqD61xUIBGboYd050xvsUaBXXhYucsBFnZiycNWbLtBMcsOFQ+RNP27NMJEJcywE/RSoUTvrGw3/CUMuPbhig6D4d/UMhMZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDBiiEFYAvzrny7bqcepyYwJkRTJoxU2ZHi6agICJ7A=;
 b=f6Il2+q7iY2zc5zF5KrOEasuAOXgfoJHLyVu4HUwyMNWiVtLIyz49TLDB9t+SuhOUuzUO4S1cBo21UgFUbTTrKrKCpo5aCU9eYZ8b6RXUxdrSxuCwjjLx+7h/Aez8P+JKY8aCyXmWwx8ugXC4YgsJbi5MJhWQVTUIIQwKShw0QbYoBE61KiJ4AQvt9Qud9Kiz6Q8trCNrYjWvPGAqksLyc+hR5ad/Puci3B+8lwKWqpQdVx+u2C2xsB1k3LuVZRDk7ODQ/Jik2dvBTbweAQBpd7r53oh/JQjHWhJUNQSRCkUw060d0tKdf1/oZyZ/h3eI1Ve78oUUZRvxqAXp7nZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDBiiEFYAvzrny7bqcepyYwJkRTJoxU2ZHi6agICJ7A=;
 b=SOlBMXF9bcYJx4PvWPlT9xgrhN8ayD8VN8orqJAPUcE+Vzr/a/9Y8+5xmI85+RDuHIWeGaR2gXCVdMcJJwGPeKPj+bPvewkqITEwf2XnxP/6IKhoqX/Uw3jQC4sV/zPc5DZNMhoTY4wnjuqVZtaG7YEBcEEf2LHr+j3M4iQQToQ=
Received: from BY5PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:1d0::38)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 08:15:25 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::33) by BY5PR04CA0028.outlook.office365.com
 (2603:10b6:a03:1d0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Mon, 22 Jul 2024 08:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 08:15:25 +0000
Received: from [10.136.40.40] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 03:15:21 -0500
Message-ID: <a98d66a7-2513-424e-a4c0-84980b9dbde8@amd.com>
Date: Mon, 22 Jul 2024 13:45:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>, Chuyi Zhou
	<zhouchuyi@bytedance.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Qais Yousef
	<qyousef@layalina.io>
References: <20240720051248.59608-1-zhouchuyi@bytedance.com>
 <3e88f113-e7b9-9b26-a4c1-52cf92b820c5@amd.com>
 <20bd07c6-2d39-44a0-951b-83aa57a84432@linux.dev>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20bd07c6-2d39-44a0-951b-83aa57a84432@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a511c43-94c5-4424-8787-08dcaa267079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enNoaHQ5K0RENGk4OWpnVnVpWkFEaHVzTUZlQ0p0ZDlPYytwMFZZdGR3aU43?=
 =?utf-8?B?cEgvNlowS2V3YlF1c25zOVhDNXRoK3F3WE5RWkN3UWtQbC95UVhnMVJHM3du?=
 =?utf-8?B?anZUcVZ6VTJCaEUrcE8zYWlLditrSjU4OHU0NTlxN2lQRG4wU2pRbEI3NGlF?=
 =?utf-8?B?eVplVlc0YnVLTlJ0SFFML0RwT0tKWStxeTlDNm01Ni9mM0EraEJqTkJWSEFk?=
 =?utf-8?B?L3dnRnQwRTR3cS8raGg3SWcrdjBwcUtGbkhxS2lNOENRRGk1aTlYWEJ0V1h0?=
 =?utf-8?B?TytyZFZXRFZ5dUV0RENZVlFDdWh2V0FkU25PNzB4bG9iQU1HTUxsL3UvRngv?=
 =?utf-8?B?c2xUbjhtZkI3R0lHTWc4N2ZtOEk3TW9BK2dYQWc5V0x2azc4ZWprRzJDL1M3?=
 =?utf-8?B?enEwTUkrRTJvUXRxd3NlK2lGd2JwMnpKamREdlZVcW5ncWhRaXpyQ2o2VC9o?=
 =?utf-8?B?bUp1M1VtUDk2Wnd4YXhqamUxQWo4ZzAyYUQvK1I1cVFLb3V0S3ZBVGhLd2lB?=
 =?utf-8?B?RjVvcW92UnNPMmc4My9lVlMySU5zeTNmWEdvNFB3Q0VEcHAwWjJucWZjN1V3?=
 =?utf-8?B?WGJmVGk0TnkxRTZmTzE3TTdOcDYxRk1jdUVFUzhNNXhSQ0pNTjk0cFZFcDVE?=
 =?utf-8?B?dVJHckVyUUFXMWN5QndoZ25NVW5vNVRoZkVLUnBNTDhaWC9QSUdmUzd4UmNv?=
 =?utf-8?B?YWRqbjd5QmdtekVkOUpJZ2FZSzF1ei80YnQ1c1lPMTEwdjlqZCs5MjVlMWF4?=
 =?utf-8?B?YU5hdi9pU3R5N2pKeGxzUDNYZGRTQXUraURtUEhMd3pWSG1OM1VHOTJaL0hp?=
 =?utf-8?B?SFVBb1lyT1V5LzhYVWMvY2VkRGsvOGJUSVZVKzBnS3BLOFJVTjArR05Eblpo?=
 =?utf-8?B?YlRRdjdJaTQ3T0JOZDhvM1Q0MnV0YmxJQ1JNaktuKytIcEVkcVVzc2RlL2Vk?=
 =?utf-8?B?bGFuVm1taTdXc1ZBUjd1d2VjTXA0dzFVdnNFZ3ZaUmtQWHZUTmkvNTU3L2lI?=
 =?utf-8?B?aHYzZXRPMVRPaEpEaGhQek0waXFFdUs2d3hrNFNjME5OeXJPUzhYbHdqcTZr?=
 =?utf-8?B?VzJzUlZNNFY5RUxmRzFiUFI3ZHhHNUx0emZ4YjZXaXpacmxmMUJYVHRHcmVB?=
 =?utf-8?B?cEl3QUowL01ob2I5eVJRVDh0b3g5aEdhUGx0Wng5VmRDUTZsSWx6eklPWXJD?=
 =?utf-8?B?K1dGdUMyTHJrYkNkQllic3Ywa3Y4cFNDemFIc2FBQkx3ZnNqUDJBVVBUTXFH?=
 =?utf-8?B?OS9weFAzMXczSTFxcUNQK0p6RjdQVEJocmtzc2JkUUI1N0VZNnVNdjRJa21Z?=
 =?utf-8?B?K2VzeGlmSk81QlVkRCtDL3p3WlpPc3ZGNTNNU3M4cHdaUytSQTVLS1V4V2Jp?=
 =?utf-8?B?UU5Fbk82eEFsVktxemFrSWFuaXRuYlhDZDNpVG1ibjMrYk1nTk9weDRLbGpp?=
 =?utf-8?B?VWE3bmtQRWRodVZiMnFOSHJONUp0bXNGUnZYaCsvUFFrZHhmUjBMQlV0YXV2?=
 =?utf-8?B?bHF1Tzh5T25CMFhnMTUrV21WYk5zb1h4RStyalU4bFpsdlBBOHpPd3NBV2Rx?=
 =?utf-8?B?WForVUpoREMrL2tlRXR2MHgyQy92UEFpOTFVUnJKcE9HSWVTVytRb3V6V0g0?=
 =?utf-8?B?cVJHNDVNU2tNUGZ1cVNmRVFtVmFYL3VXRWhVNFNYdG5GRVFpVnhDME9kUVIv?=
 =?utf-8?B?UWhPc1dselZ6aUgzL043OTdxeVVEK2E4ajFYY0V1S25nK0toVnphZ0IyZ2Fq?=
 =?utf-8?B?RUwwWGlFanZnYnRqemR4NHVDSFpucDl0UUdLZ1BOQktOY1lzSDdwVHZkWWFy?=
 =?utf-8?B?bnhTSkVIdkF6YXhYNFNFUlNWVXZlOU1MQUQ3VEFjS0lZYTdjSmF6Y1hnQkJS?=
 =?utf-8?Q?FSB/HNUT/3tyU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 08:15:25.1009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a511c43-94c5-4424-8787-08dcaa267079
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495

Hello Chengming,

On 7/22/2024 12:10 PM, Chengming Zhou wrote:
> On 2024/7/22 13:17, K Prateek Nayak wrote:
>> (+ Qais)
>>
>> Hello Chuyi,
>>
>> On 7/20/2024 10:42 AM, Chuyi Zhou wrote:
>>> In reweight_task(), there are two situations:
>>>
>>> 1. The task was on_rq, then the task's load_avg is accurate because we
>>> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
>>>
>>> 2. The task is sleeping, its load_avg might not have been updated for some
>>> time, which can result in inaccurate dequeue_load_avg() in
>>> reweight_entity().
>>>
>>> This patch solves this by using update_load_avg() to synchronize the
>>> load_avg of se with cfs_rq. For tasks were on_rq, since we already update
>>> load_avg to accurate values in dequeue_task(), this change will not have
>>> other effects due to the short time interval between the two updates.
>>>
>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>> ---
>>> Changes in v2:
>>> - change the description in commit log.
>>> - use update_load_avg() in reweight_task() rather than in reweight_entity
>>> suggested by chengming.
>>> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
>>> ---
>>>   kernel/sched/fair.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 9057584ec06d..b1e07ce90284 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -3835,12 +3835,15 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>>       }
>>>   }
>>> +static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
>>> +
>>>   void reweight_task(struct task_struct *p, const struct load_weight *lw)
>>>   {
>>>       struct sched_entity *se = &p->se;
>>>       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>       struct load_weight *load = &se->load;
>>> +    update_load_avg(cfs_rq, se, 0);
>>
>> Seems to be necessary when we reach here from __setscheduler_params() or
>> set_user_nice() for a sleeping task. Please feel free to add:
>>
>> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>
>> But since we are on the subject of accurate PELT accounting, one question
>> I have here is whether a reweight_task() for a sleeping task race with
>> its wakeup? Something like the following scenario:
> 
> These two paths are impossible to race, since we have the task->pi_lock.

Ah! Yes, you are right. Thank you for the clarification :)

-- 
Thanks and Regards,
Prateek

> 
> Thanks.
> 
>>
>> [..snip..]
>>




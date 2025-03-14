Return-Path: <linux-kernel+bounces-561945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0631A61901
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7711B6430E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235220371B;
	Fri, 14 Mar 2025 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LaTER75a"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3962046A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975503; cv=fail; b=gx98dcFEcvqpndzhGl4nQV/DSK8/PT3bo1ykfVdPIKOhriQOOhQfcKOJWwvIBNs3Ng9ohA7Wr5UBB/ylJS9GdO/SlGaxhIymPNjA9f6KBc1JmVgUaSFSF9SYO4V3kZILSAsjDwFBg6ANbisLw8bbGohqNdYNWiFMELR+MM4Jmpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975503; c=relaxed/simple;
	bh=I7NFWosUbqNituGWNbjk8R009Owrp7VHltiN7PL6zwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DhzfkAh56MrnTF+ZwIF8+AL58HeMZUBOvBvnnEtCKh7yiPAAcb7nvKsDHH98gsgMCRDOTfNvgAg/AewTjXubUFmLUQlmAcgcG1cZ68mS5KSceYaOJPFC0daGuFb1AhqLT/6eg4ZausaHY33xA9uk7zEoK1xIK9/ai878uMPYRrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LaTER75a; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bhv887jMgjK1MHd2YKKpA2tjY4xhX89V9jwX78B9mr8Imyxe5yRBVnULga6lrpVx6DvBApXAk+XAJRQWwLFLp079gchP+nLNJjCA171EUNx/6q8YB6GjTcc/0vw5Gur3eLvDd0t3bx4OvJdV5Y12mm+k7Cwhj5U8VvR0z+5Cb1U73qgoXrwWGBl/zCeqpaheLopjV76drTTDuAalm8GLj/l4wRKt5ROQktevoju6FcurRES1n3OLjXSr80kWubPEf4PHZnGC/aedfu+4ss1MMhTiEPN3m59mCdXh8rvYI0W233PhExQqXUtRpZK3R+BL7sh9bMDC7XZYwEJ6c3MLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8ptK7zKgASKKu+0kuyUwmmoLd2GkFCDzgybj/eZqEs=;
 b=uR0Rqoy8InmeQnBs1J5hUlCarnmIJ5nLMZcbos1Yo1uS+DLiAo/yydIycmVQsegOmK6ZNeSoTyrPriPb9ZVgwu1q2QJvULk463v7NlajXPHBOKDSbmE4GMJAHxFKYGRRYmwIrTtkgBecIlp7Er22FnLeVqnMbUXBVrJnFJCmM4Avzx5O2iHzXKgoO3WP6apgvZFbPm8ExxEEU5uCmi0vGaqlbchKozd6ic1p7gEEloj/A61aglaG9sBLlAtupfDavlKTl7/3GZzq+j5hSlNv3a/tUVsrAjl2HRV5T8W4aoVnvtIokxOh4xyYVJrcbmT3FCkdXMTPSFbHNDfh6DD0Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8ptK7zKgASKKu+0kuyUwmmoLd2GkFCDzgybj/eZqEs=;
 b=LaTER75aeOb5nx1HwOJQSSnyl5NsrmpKFzZN/XkUhsWIIhUU85eBSCBKECQZx/6BQmWmYfXhuS47rsmlCCcIlvs9rakVTeom6dgt5W/arWUm3OJGgJXwvHi5KPKbUPsbVTfXnM3gD6c5Zn23ArcVAvqDvA9FP2U6njgChIv7SFM=
Received: from BYAPR08CA0046.namprd08.prod.outlook.com (2603:10b6:a03:117::23)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 18:04:55 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::2b) by BYAPR08CA0046.outlook.office365.com
 (2603:10b6:a03:117::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Fri,
 14 Mar 2025 18:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 18:04:55 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 13:04:46 -0500
Message-ID: <2bd42110-a37f-4da1-bc9a-194f3ff909df@amd.com>
Date: Fri, 14 Mar 2025 23:34:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Aaron Lu <ziqianlu@bytedance.com>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>, John
 Stultz <jstultz@google.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>
 <20250314094249.GC1633113@bytedance>
 <6688eade-8eec-4d76-87f2-637425b1c2d2@amd.com>
 <20250314114738.GI1633113@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250314114738.GI1633113@bytedance>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bace316-7301-4515-51ab-08dd6322b9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anBBK0tpVzZVZytlWlFubGlDU2hxL0lYdUdBNjZHaWswV2h5OVh3NWMxMVBL?=
 =?utf-8?B?ekUxZVFoLzEyN0FBWElvZFdlclNNQTZ5Y3dzajA2dWhvR2ZtQjVvMkQxSThu?=
 =?utf-8?B?YnZid3c0QXZrc1Iybm5BSGJYYjlXVHFhQ0NIYy9lSWYxV1QwcmJ2Z2U2ZWJF?=
 =?utf-8?B?R28zUERFeVc1MWtqYTJGUWxnR0JiN3JnTjJnOURIY20xMTEwR3BzeU9EdFZJ?=
 =?utf-8?B?TW1YSmE1N0pzVEdNZVY0MGUxbnAvQUtjUHltU2FZOWtld2sxMWd6TVRXVVJT?=
 =?utf-8?B?SnExTlZRNkF3VXFhdThjV0RwdVVaRGdPdVJxeFVUeU9ialFWTmYwRm9OdUcy?=
 =?utf-8?B?VGx2R1d0bC9GSGdTelpaekpDdjBJYXRTbVVCMlZJVEFYT0JwQzU1ZzFPeEQz?=
 =?utf-8?B?cEZOM1FKWGJRUnJWVkZrTVIrUmJDdm9hOE1JbjNEV0dVd3JnRzB2TTdUakhw?=
 =?utf-8?B?K1BWZG1HSEM3a0ZQS3lmc3ZuYm13KzhhTUFWWFNlYXA5UzlWWEE0Y3NmMGdw?=
 =?utf-8?B?WXpaYlFkeVZYUlUzRUNUY1kzMGdBYmpYM0VsUmo5Sys2Z1p0VUdzYzRsMXUr?=
 =?utf-8?B?QjI1QWl0bU5Vc2d6ZTk2ZHFOa01GWWM0RmkyVVdvRlI0NEJhdXdlckRxRWtS?=
 =?utf-8?B?R0FJMFZiNDJoYndRUlR3M0NCYmxMS1FldHVuVHVGUjRoR05INXNZRUFyNHlZ?=
 =?utf-8?B?bGFKcDFlME5tbG1pTVZpb3lITDhtTHA4RmR2RUJFSE5kTmk3L0pSdy9KR0xn?=
 =?utf-8?B?eGtEN0lXcDAyMUMydDhLN3pkQTdya3g5Q2h5TG8yVnB4cnNIc1k3WWRuamI3?=
 =?utf-8?B?RmdZc0tZRUFaTFE0aWdmTUhVNXlrTC93eHBlVVJFUHpDeTdOZk51Q21VVjRM?=
 =?utf-8?B?MHJtYWJ4YXlPUjNkMlVMWEdVRTJmR2dTUUtzbkdJTkViWEVENFpxRHZaZDBB?=
 =?utf-8?B?aXJCem5kMUNHRDdITHpYTVN6K2xvc0pDV3BtZWFxUjNVbmYyakc2Zmc1Myty?=
 =?utf-8?B?WEZVaGZRZHRkSmVsZVUyaUwzdmVqUUlFMFArOWt6L01GODI1TVpxa0xHTnBK?=
 =?utf-8?B?Y3QrMjhxUFoyRGNmbEM2V0NoV3J1RmRNNGIxTk5veXF5c3VoQUEyVm0xUU9X?=
 =?utf-8?B?YUswankxVWV3eXFwUlJabXlnYzhxazd6OXhLanZiMkFhMlU0ZlNkbEpadGNZ?=
 =?utf-8?B?L2FVVXlXMUJrc0hkeG1xNmszRzNEaTlxNWhLOCtQRVNHbUhzZkFoQ0t4a1VF?=
 =?utf-8?B?Uk5TQ3VYdkxRWERIbm5tVy9pMk5LbDVXL2VCSzZxcWZxY0JGRXhnMDc0RW5W?=
 =?utf-8?B?QmtZZGRkdmlwWHJiaHlaODJmQmhCVHNNc0FmMmNxbi9oQmVVSm9oQktXM05m?=
 =?utf-8?B?bFczS2NwMzhNYk1tQnk0SzJwR2tRREh3QjJrR3ZubjZlNWJtdEd5NWM1emlo?=
 =?utf-8?B?c0tCa1hGbjV1eTdFSWI5c1VrU1FEdG1zbnloSkl3M3VpYzBvYUllK2VqTkdu?=
 =?utf-8?B?c1J3MWFZVnJyVHlGbm9odDVsRUNnMThOaW9ySE1hS1ZZUlhoRDFWRGxlRkhY?=
 =?utf-8?B?NG1aQTMzUnMvVmo5TDFuRCtodDVnOVhQNGdDK2U0SzdyN1EzQnNENHV4VUox?=
 =?utf-8?B?azRncFpQbWtSSVQyYzRKdDNndDdOYVIvcGc4K1FLLzN1bGxLRStCRldlRHdi?=
 =?utf-8?B?UTJ0OFJXU2QzNkdTRHltRzl0eFMvSCthMGZSdUtIMGtGY0NldmFUZTY1MldY?=
 =?utf-8?B?OUY5ejdjK3FXRktNTHdnSFZnaTZvUmFtbzg2MjJ6K0kyenUrNDd1VkFiN25G?=
 =?utf-8?B?Wk5OazhZcEpidHVvWThSQksyTTFySndBTHN5SUdhUzdHM0ZxZWRhR0g3RWdN?=
 =?utf-8?B?SFU2REJHUlVEak5SL1VNdTlQZmRQalV3RmJnSWJaWG5pamVyUWhpcTdiQTZM?=
 =?utf-8?B?QUlSWnRyTUZNRENsWWROb01raEV0SE5yMG1CaFhFallnQWwzejdGczB2bC8y?=
 =?utf-8?Q?AR9YeVObUBv954thqcy7H2fPLjTrYs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 18:04:55.0188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bace316-7301-4515-51ab-08dd6322b9ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080

(+jstultz for some clarification around rq->donor)

Hello Aaron,

On 3/14/2025 5:17 PM, Aaron Lu wrote:
> Hi Prateek,
> 
> On Fri, Mar 14, 2025 at 03:56:26PM +0530, K Prateek Nayak wrote:
>> Hello Aaron,
>>
>> On 3/14/2025 3:12 PM, Aaron Lu wrote:
>>>> Then then if we pick a task from a throttled cfs_rq subtree, we can setup task work
>>>> for it, so we don't botter with the delayed_dequeue task case that Prateek mentioned.
>>> If we add a check point in pick time, maybe we can also avoid the check
>>> in enqueue time. One thing I'm thinking is, for a task, it may be picked
>>> multiple times with only a single enqueue so if we do the check in pick,
>>> the overhead can be larger?
>>
>> I think it can be minimized to a good extent. Something like:
> 
> I see, thanks for the illustration.
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d646451d617c..ba6571368840 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5942,6 +5942,9 @@ static inline bool task_has_throttle_work(struct task_struct *p)
>>   static inline void task_throttle_setup_work(struct task_struct *p)
>>   {
>> +	if (task_has_throttle_work(p))
>> +		return;
>> +
>>   	/*
>>   	 * Kthreads and exiting tasks don't return to userspace, so adding the
>>   	 * work is pointless
>> @@ -5949,9 +5952,6 @@ static inline void task_throttle_setup_work(struct task_struct *p)
>>   	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
>>   		return;
>> -	if (task_has_throttle_work(p))
>> -		return;
>> -
>>   	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
>>   }
>> @@ -6000,12 +6000,6 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>>   		node = rb_next(node);
>>   	}
>> -	/* curr is not in the timeline tree */
>> -	if (cfs_rq->curr && entity_is_task(cfs_rq->curr)) {
>> -		p = task_of(cfs_rq->curr);
>> -		task_throttle_setup_work(p);
>> -	}
>> -
> 
> Should we also remove adding throttle work for those tasks in
> cfs_rq->tasks_timeline?

Yes. I don't think that is required with this approach suggested by
Chengming.

> 
>>   	return 0;
>>   }
>> @@ -6049,6 +6043,18 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>>   	SCHED_WARN_ON(cfs_rq->throttled_clock);
>>   	if (cfs_rq->nr_queued)
>>   		cfs_rq->throttled_clock = rq_clock(rq);
>> +
>> +	/*
>> +	 * If cfs_rq->curr is set, check if current task is queued
>> +	 * and set up the throttle work proactively.
>> +	 */
>> +	if (cfs_rq->curr) {
>> +		struct task_struct *p = rq->donor; /* scheduling context with proxy */
> 
> I'll have to check what rq->donor means.

Essentially "rq->donor" is the scheduling context (where the time
accounting happens) whereas "rq->curr" may point to a mutex-holder that
is running with the context of "rq->donor" to unblock itself as quickly
as possible.

If we experience a throttle, it is because the time accounting to
"rq->donor" hierarchy couldn't fetch anymore bandwidth.

TBH, adding the task work to either of them doesn't make sense since
the "rq->donor" will be picked to run again once mutex-holder does a
handoff and the throttle work can be added then too.

> I think the point is to proactively add throttle work for rq->curr if
> rq->curr is in this throttled hierarchy? Because the only check point to
> add throttle work will be at pick time and curr will probably not be
> picked anytime soon.

John knows these bits best and maybe he can correct me if I'm wrong
here. For the time being, rq->curr and rq->donor both point to the
same task but that will change when Part-2 of proxy execution series
lands. We can just clarify these bits now to avoid any conflicts later.

-- 
Thanks and Regards,
Prateek

> 
> Thanks,
> Aaron
> 
>> +
>> +		if (task_on_rq_queued(p))
>> +			task_throttle_setup_work(p);
>> +	}
>> +
>>   	return;
>>   }
>> @@ -8938,6 +8944,13 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>>   		struct sched_entity *pse = &prev->se;
>>   		struct cfs_rq *cfs_rq;
>> +		/*
>> +		 * Check if throttle work needs to be setup when
>> +		 * switching to a different task.
>> +		 */
>> +		if (throttled_hierarchy(cfs_rq_of(se)))
>> +			task_throttle_setup_work(p);
>> +
>>   		while (!(cfs_rq = is_same_group(se, pse))) {
>>   			int se_depth = se->depth;
>>   			int pse_depth = pse->depth;
>> @@ -13340,6 +13353,9 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>>   		account_cfs_rq_runtime(cfs_rq, 0);
>>   	}
>> +	if (throttled_hierarchy(cfs_rq_of(se)))
>> +		task_throttle_setup_work(p);
>> +
>>   	__set_next_task_fair(rq, p, first);
>>   }
>> --
>>
>> .. with the additional plumbing in place of course.
>>
>> -- 
>> Thanks and Regards,
>> Prateek
>>





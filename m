Return-Path: <linux-kernel+bounces-395878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F859BC44D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9BD2826DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E213418E023;
	Tue,  5 Nov 2024 04:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cu32Sdz4"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62143376E0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 04:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780673; cv=fail; b=ekfsPUzDLfRtUKqNgoMXfW1bZRfah+btNlG1q2Xsd59+fAKsYm0dMRIu42N+2fIjHYUkytT95EuVVwm4jyoBonHCUQxa4fzE/2zs1pP2BETYD/JSNZT92/dY0pJgpmNMV/s/9bRmGAvrDGqfjX1cDBcqczOp6yR8Fhk5/fBajDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780673; c=relaxed/simple;
	bh=mHj+3lTwj2c0SroMQuKDgL+rdi/xULfirhQnz4udVhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mUFhjpcxrUxWZgyn1LiT6QNIhnCBPK7A58nx313ZmNmL898Kb/iwaxbikcOP3IzSQs2kug1tijA9o67wEdcwgzl4DaZWy6v80E5TRWxge7Nl2kOBLysS+Fa1rZGaLSNnRY0fYZ3pUXVzcofg5h//EYs9Mfv8sHtSBwbaZILHIvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cu32Sdz4; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfTj4L9pUFwJJ+ofRL7+ncNNNdWotp7NJ9Csn9xi+jAqTvumQRkUW4R2ajog6PdgZhi2SCeYR+r9CQrObmi6uVyWT1k1VahlAK+llUfhh5qwjK8KlL79OHrX6m4n2zy1lkSjEaaQ+FL3m6fAPJugap0mp3UdtDrA7b3IqTDXa2gp4gv8KOSM7Ue6DyxZktlOlRkNCV0bIJwU9f5b8sh3Hh1yy3yTTjPT9S0ZuA7/8KqYggbu/ar/JtgDgYJ5H4yYpeFY01jFOizlNNTtZdt7cCL5wM5XANWKPOnLsAOcOfosl5jG1BVzx2mAHBs3TsuebioksrFL/vyp335apL+w4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw4jyjLeQj/mgdzRx+YNwNwEeMxFRtl7ztVKuDsohDY=;
 b=u0uaeQRCCdgYon1A3vVFrdxlzLQaDCj/MEt6U8NT06fv769H/cWAcvpYoGlxjw457/bQWQNwI0UQFJ+hykECmR4pHmra85bSVigdpGWZQQpTzWJosPKVn/16UiiE7Wpgza6IMtMgOYKfyojaaJNbNMdCkd/uaoUri2xr/MawklCQrnmhbJg6KaIXb9aEAEdVY5eLKxV7N53HSrFwB0yq5TlEMLZ5qJQ3B86gqKvFBNlwYTv9ZiJWphW0/oY1s90oqmdQCqGVBkmhQyM9ybgYiX1ksbo5PXn/qInWGRfauVDq77bH20qvX9/GOuwpsYbpNEASk6DB8JomDnlW97Pj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw4jyjLeQj/mgdzRx+YNwNwEeMxFRtl7ztVKuDsohDY=;
 b=cu32Sdz4gq7Dr4tDNUMmt3dEr5g63dr62JhSfj51fBLzfqQHRoXWbMK7VFm07gehahAuoy08CkVqZqu8KzeW98UnMXV7r0NpjUTtfRycwejs/3XBHX+wpJUJ1vg9pi+49Z/94WI+u30tWZmRBomFZRthwJwRQ+/mHtV5OY5hbEk=
Received: from BN0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:408:ea::31)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 04:24:24 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::fb) by BN0PR04CA0086.outlook.office365.com
 (2603:10b6:408:ea::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Tue, 5 Nov 2024 04:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 04:24:23 +0000
Received: from [10.136.47.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 22:23:25 -0600
Message-ID: <b8ed9d5d-4186-4b2a-aabf-d027d183c44a@amd.com>
Date: Tue, 5 Nov 2024 09:52:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Content-Language: en-US
To: Mike Galbraith <efault@gmx.de>, Phil Auld <pauld@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>, <tglx@linutronix.de>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
 <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ad534c-d062-495d-4dbb-08dcfd51ba25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dCs4SXp3clE3WHB1amVvZlRoQnJSdEk5Zk1UL3pFY0dTajdnNmlINDhVZXc5?=
 =?utf-8?B?TXlVN2NyRitKdnJJdkxTTThRV1ZtWGdTNDdBSk5iTE1kVGJzclp5M1E2MjF6?=
 =?utf-8?B?ZE5ZVnFFNTZIdXp6SDBnaTlIWll2elR2QzVHSHRtK3Jwd1pOMHVSTWI1WlU5?=
 =?utf-8?B?S3RjRGM5RG9LeXhKbHNQZjVvbXRURjVlQjA3T0h0RXNCTHJCVW9YVEtTeWVG?=
 =?utf-8?B?L0c1QVRXNSsxajRSWFNYNi9Ha29kZExjWHA1VmtNejczMFFCS1ZsV1AzRjB2?=
 =?utf-8?B?RzBUWk02bW1EajRRUFlGVTFsSUNYRldHVExFWERGSHVqRDRuRmNJUkpYN1Jn?=
 =?utf-8?B?UGRwdUx3ek9DYTgwQ3l0ZXljQ0dhN2NDV2JJY2E2YytObFBzTjEycVQ0K0c5?=
 =?utf-8?B?TEY3WDJ3eXg1TDdBaTVuemlYL3duM0hmSVF3Z1VMK2gyaGpGeHNZb2xEdHVr?=
 =?utf-8?B?Q0tVMUJ1YW4vd3BNU1ZLWDd5VlVQdFR1TXp3dUJ6Yi9JSXpqbVFFblJJWUty?=
 =?utf-8?B?Y0gyQXNrUVBDdFE3dEtPUDhuOUtobU5uaklvOEZQQUF6V2JWdGh2V2VReTNK?=
 =?utf-8?B?dUY4YUZVQ3FKejBUbU0wY2ZORGhHTHpEYlUxL3FtdjgyWGpyZWhhdzVZMjZx?=
 =?utf-8?B?dWI1R0dmbmtXNGVuUFhMQ2NneFQybmRrKzk2ZDVJeEtrSTE1K3pxMXMrY2Ey?=
 =?utf-8?B?c0VUcDcrTXJCOWRxWm1SWndhZlNKek9sOXRlMWtFVm1USGZsVTFLWW5PMGVw?=
 =?utf-8?B?aXZSTGJEVkp2eHVSQVA2d3c1ZjRDS21aTWgyZkptMEI4TEZvZjhGMGlYWUNU?=
 =?utf-8?B?aEFrZElNaTVVMHF5NWsrRncyekFxTDBvdzVnUDdZVEdXS2IyTXAwVE1Ub1NX?=
 =?utf-8?B?NEtQRjNmelhuNDRudCtBdU4wNk4vd0VZZUlsZVJsOEpEdzRPK0ZJempDdTNy?=
 =?utf-8?B?Q3ZnRW52cFpWWWYrM2hTSHJQZkpJK2d4a3U0UUJabXZVR0pMWnNLZG12T0Fm?=
 =?utf-8?B?bXlqRkxkWmhveHk1SEtnWXhFUytTa2FIMk9MWitRVFY0MGJoYjVHRzU1SDV0?=
 =?utf-8?B?WUEyTXFPcVhVNWNOdmhibFBCNm82M0t5bG93VlNGcUs1ZXpZc0d3YldVRmJI?=
 =?utf-8?B?VGk5R21nUVBpWXFndjJqaEhQZ0xpNE1RWFAwYWxTNlVCOTBQdXVPQThIVVg1?=
 =?utf-8?B?OWNxbW9rNUJ6aVNsK01RRjkrZk1Ra0dLaGllaU1RSTg4TDBTWFVETkM5S0Ju?=
 =?utf-8?B?anI0TTdaWlRWR21BVFRPUlVwcVJ2cTVZWnUwN0RraEgwQWNaMi9kaWRJRjdP?=
 =?utf-8?B?cDFzZ01Cbjh6dHIreWhFZ21VVDU4V1c2RStmZHRJSUsvYWlpTkNaMDNjRWs3?=
 =?utf-8?B?M0Z5bktTSHcvSWFxRnVPTDE5bmxuMGl4L3ovZVc3UXZMdHpuMTFPU1VmR05Z?=
 =?utf-8?B?VVlZaTc5SzYwMVdXeGozWFBEcEtDLytDcFRmVlBwa0RpZ21PQkhKZ2VxeVI1?=
 =?utf-8?B?N0RBalJlV0xCakx5aW4vMG80Y0FkeGQvSnNqb2dWbmxwUWIrdVF3bytLNm5H?=
 =?utf-8?B?eEJUL3Z0ZTF1enN5eWd2UitwbU1reDQ4WHVtaUJxekJzSURqTk5wdUFxNEsy?=
 =?utf-8?B?R0RUY3hHbE81UTdmOXppNDY1OXlqYWNmNlBucUFxMzlqUWtuem1UaCtJWTJL?=
 =?utf-8?B?ci9kK2NwcTBrUFM1b2dJVU5aZmZ1Q0YwbkxOQXJiYU90M284K3pDODZYK2Zh?=
 =?utf-8?B?S3hac3E0eEZJcTR2SDFMdWVDMWUzbjRieVJJbHhyOEhqVDRKZ24wZnc4VDRY?=
 =?utf-8?B?RHJVSGpPKzVScUFmaFBXT3RBOUFscHRCWlZsQy85dHdybTQwZTFxOFRTV2lR?=
 =?utf-8?B?cXpQbDRNU1gzTUlpbXNvbXhKeEYxd2RjSllOa0orN3JrZ1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 04:24:23.6171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ad534c-d062-495d-4dbb-08dcfd51ba25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897

Hello Mike,

On 11/5/2024 9:35 AM, Mike Galbraith wrote:
> On Mon, 2024-11-04 at 08:05 -0500, Phil Auld wrote:
>> On Sat, Nov 02, 2024 at 05:32:14AM +0100 Mike Galbraith wrote:
>>
>>>
>>> The buddy being preempted certainly won't be wakeup migrated...
>>
>> Not the waker who gets preempted but the wakee may be a bit more
>> sticky on his current cpu and thus stack more since he's still
>> in that runqueue.
> 
> Ah, indeed, if wakees don't get scraped off before being awakened, they
> can and do miss chances at an idle CPU according to trace_printk().
> 
> I'm undecided if overall it's boon, bane or even matters, as there is
> still an ample supply of wakeup migration, but seems it can indeed
> inject wakeup latency needlessly, so <sharpens stick>...

I had tried this out a while back but I was indiscriminately doing a
DEQUEUE_DELAYED and letting delayed tasks go through a full ttwu cycle
which did not yield any improvements on hackbench. Your approach to
selectively do it might indeed be better (more thoughts below)

> 
> My box booted and neither become exceptionally noisy nor inexplicably
> silent in.. oh, minutes now, so surely yours will be perfectly fine.
> 
> After one minute of lightly loaded box browsing, trace_printk() said:
> 
>    645   - racy peek says there is a room available
>     11   - cool, reserved room is free
>    206   - no vacancy or wakee pinned
> 38807   - SIS accommodates room seeker
> 
> The below should improve the odds, but high return seems unlikely.
> 
> ---
>   kernel/sched/core.c |    9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3790,7 +3790,13 @@ static int ttwu_runnable(struct task_str
>   	rq = __task_rq_lock(p, &rf);
>   	if (task_on_rq_queued(p)) {
>   		update_rq_clock(rq);
> -		if (p->se.sched_delayed)
> +		/*
> +		 * If wakee is mobile and the room it reserved is occupied, let it try to migrate.
> +		 */
> +		if (p->se.sched_delayed && rq->nr_running > 1 && cpumask_weight(p->cpus_ptr) > 1) {

Would checking "p->nr_cpus_allowed > 1" be enough instead of doing a
"cpumask_weight(p->cpus_ptr) > 1"?

I was thinking, since the task is indeed delayed, there has to be more
than one task on the runqueue right since a single task by itself cannot
be ineligible and be marked for delayed dequeue? The only time we
encounter a delayed task with "rq->nr_running == 1" is if the other
tasks have been fully dequeued and pick_next_task() is in the process of
picking off all the delayed task, but since that is done with the rq
lock held in schedule(), it is even possible for the
"rq->nr_running > 1" to be false here?

> +			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> +			goto out_unlock;
> +		} else if (p->se.sched_delayed)
>   			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
>   		if (!task_on_cpu(rq, p)) {
>   			/*
> @@ -3802,6 +3808,7 @@ static int ttwu_runnable(struct task_str
>   		ttwu_do_wakeup(p);
>   		ret = 1;
>   	}
> +out_unlock:
>   	__task_rq_unlock(rq, &rf);
> 
>   	return ret;
> 
> 

-- 
Thanks and Regards,
Prateek


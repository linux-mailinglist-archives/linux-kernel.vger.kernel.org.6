Return-Path: <linux-kernel+bounces-561019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD3AA60C83
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBAB461220
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20F1C6FF9;
	Fri, 14 Mar 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kzd3WIrO"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C18CA4B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942871; cv=fail; b=UzC64CtVtNNsHCJ5KHaqqfKW99IAjuuT0PzgnxyVk56P08yeoTUtj+Vy1CXVN8NOgF2IhQ5vCWXQ+D/OgsIyEp9yzQ2QBEJXHITeGme+0FxQuxLfBkNg3+JMAm1db0dV+1DxhASTdY/vxDuWEdMaQhprls4TROFSp+nu/UjNTd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942871; c=relaxed/simple;
	bh=gZs5R0CaoV8KsHjwimaO34k9nnFu3xm+8UFljb2Kpnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rie5XsCFiP3Wk2pduDOZvyBPFOUBkqXjS2ILa86XzUFzhpqlTalvtZ0J1kFAspCaZMVBQuGRp4ryPHpnl8/0fYooKFt2duBfpXK3h8VlBZFJS0UwsKlgQB7WazaFJaGZW3/iTMaSMt29DUpepV2R0GCeuD6ruDLTk+Ml24OnCgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kzd3WIrO; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEiPNHD63W9SxKWVjCtr0UG8ZGexk5PFgSCqxeKL4QWOvba0wSf8uOZXmVeeil4Bwkm764NuSEipuxeAgJfDhBA+dxPU0+cn/p2vVZBqjTxzzwHk6OMDQhLumrmaWLUbtLuXd9fCR4NWsdjDuLNjHnclf/rToBTZuB8Uojmo3Pyfo30eWvAYiZDqe1QYj0GX6vCvub3yWV1G6glDULRJ2uDfbSMGfG41uuauMYnKHgw8aH5afRBbsecAxjuv6nEgluI4mVqMeFjSbPM4xiBXuSUgWn6TqADZatBUn+cHY/CD4d86AT3s0ibrXLL2izW4hqXh6hi0471g/EOqwr4ZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvDDgdidXFNjOvS+Upyd5uwnX9X4UkHKQtONAOenTCc=;
 b=fmQhOSaKZJMZNsJlLdHwhSCqWYwUPZGTNBeabRIEG0XDe0isQrEPngxA4BC50gANZYWuBVbKCVd7UPzUj1bLNPzEXpzo//G0mXQbts2cvFulbKGZqRx5VR1BGsKvi+lzs4ZxEJpJ0iR3MT9ocSsTEapBq1An6xBTPAD+VoQ0MxgXFvXo2DFsQlezz9oc+DW8A9Uj0MAnRIrbRcfUIoZYSpjBMIy5YM221fVPeRQBPFwE0I9yx2pyPEvOUavaZaf/DtG26FYExKqiRBXJP9CqeLrotIczXOdf9rimQOtGZojXc+vICTZn9s9FzWHhs9mPSEyAj9llqk92pne16I1+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvDDgdidXFNjOvS+Upyd5uwnX9X4UkHKQtONAOenTCc=;
 b=kzd3WIrOzcIUdaEqqBEq1qQxBlWxi6bcSfZHmDg77gQdBreok7NAuOikjH8A2DSbS4EX6s22w1OYHXBmHTDIMMk7G2ySsWadhtx8FtzaPqNCi2zIbzuzws6LStZTpylwokFtb4BHbHT3bYVCEHWq/hcO84DN6GaaJqM24Fklwkg=
Received: from PH0PR07CA0112.namprd07.prod.outlook.com (2603:10b6:510:4::27)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:01:05 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::98) by PH0PR07CA0112.outlook.office365.com
 (2603:10b6:510:4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Fri,
 14 Mar 2025 09:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 09:01:03 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 04:01:00 -0500
Message-ID: <737edc45-5f56-4df5-b328-168980d744db@amd.com>
Date: Fri, 14 Mar 2025 14:30:52 +0530
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
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <c9b1d117-2824-4238-bb8c-6390ec3e931b@amd.com>
 <20250314084854.GA1633113@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250314084854.GA1633113@bytedance>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: fd61b429-a5ce-4f6e-f726-08dd62d6bfef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3gySlQ0bmVTUHpaYlNrRTNRTGZjMWRkNHhJNGJ5eEttYWo2cmZpdUpSOTZN?=
 =?utf-8?B?RXdhdy9pMlJ2aG0xVnFzWWZFTWQ5Z29GRVZEZ2ViczRWdjZLZjdiNXR1clJG?=
 =?utf-8?B?d2krYlFTb1lUeFRxcEJmdjZ0VHpQV3lSaFp0YXZWVkRKZDhuR1VpcHRZTUN2?=
 =?utf-8?B?RWx0YTZINTg5TWRyMHRkaXByZEJtSEVtVzZtNjRKMmNMYmxOV3dValROaUNZ?=
 =?utf-8?B?WllkUjJUd2wrQjkvYXdQSWNHQXFzeU5lSWorY1lNZUVYUzhmaWhVOXE3UjJD?=
 =?utf-8?B?V0kxOTAyYlZvK0FTNnRUNWw2WTg2TDAwcjlEMW5QNWx1bHY1ek1XM0V0N2tn?=
 =?utf-8?B?bG5xU3pudWkwb2NUZUk5c2txUTd6TzIxVFNIbmxCa3pzSnp2bEIrcStOemRr?=
 =?utf-8?B?VHdBRjIxb0I3WmxMYkVxSVNaOU0zRXRESkJJVzk4MGExbnloK20rbG0waE1Y?=
 =?utf-8?B?cWFGdm4xQ2E0ZEhJZ2UwdkVJa2p2S0FsYlhUaFJwQmpsL2hvaDljK1FIN3pJ?=
 =?utf-8?B?V1VPZStQakxQVFdtS3RmN0xacUpyMkFYZnJ5NWZ1M0xscjVmUFNzWFl5emdH?=
 =?utf-8?B?Yng2bDY5aFl3T3FPNTlhSHYvd0ZidHdUT0VrdzFKaFZwcmxxQ2tST05iaWNX?=
 =?utf-8?B?cDJKSUF6d3BKTDc3OHRxbmdLNG9nY0tPdy9penRwdHBOQjR2KzlBZEUyelRZ?=
 =?utf-8?B?bWduajBvT3ZGcE56emFUMGo2UmQ4US9BcXpPNXJMbEhOVWUyZC9ZNm9CbjRo?=
 =?utf-8?B?NXgxdEY3YkEwd3dsbGYrNW9vdUR3TkwrUUM4YVkzTVh6TER2QWlnVnRQKzI2?=
 =?utf-8?B?RXZNbjgzV0VpOGg0aTNva3ZVajZuZTZ4UXNKSTRCNkQyb28zMGlYdW95WFVn?=
 =?utf-8?B?NXRuRTN5NDBDbzVBWXpHWWlZSk1maS9KK0szYXplZDFySTM5V1N5RHNYWW83?=
 =?utf-8?B?eStqTGFOa2huWEkvQTBPVGU4VGVjRHNoWnJXRmVXbXNGMlNNSm5ud3pXcHhx?=
 =?utf-8?B?MFhoSG9jc0tqK2x1YTg5dHFSQ1JHOUd1WVpTTEVlU1k4NjNQV0x6NUhuRldi?=
 =?utf-8?B?RkRLTWkybGhRT2haY3pkVWFHR3N4OHZZS1puQ2tRZ28rU3FBeHhaQUloZ0Jp?=
 =?utf-8?B?NHd4Nmd6eWJJeG8vOVErV0RjaEdETTZGakNxemVFRXRuVGhybVBJbGxjK3Np?=
 =?utf-8?B?akNoTmZ0VEdGNGFZeGFabGVnSXJSaW1FNWQ4SmJ1dHJ2SnNoSEVPcTJ4cUE4?=
 =?utf-8?B?bFdERjBzcTFNVFMzVjB2NmFqRkRlQ0xzRWY1VENjeXRkUjQzL1FULytBV0N5?=
 =?utf-8?B?LzdZZ3NwamlBTW1JU2VYOHI1YlRkeUVFR2J4QTBBZlNzZUJXNmlUM21BR3Z5?=
 =?utf-8?B?MjZCRmUxamt6U1BxeVcrNnBBL21qSHo0Y1RPdklMUUxUZjJxTnlJUlp3Mytp?=
 =?utf-8?B?eklSMUVCZHRKeHFadmhWRElOSjNrUHBRTDY0dGVuR1V5VFV2UnZTSWZva3lk?=
 =?utf-8?B?YndzUURvRlhQdEpSeHpUSkJUNUVKTDdMdWtTRDl6aEpXRmlDWDdjanlhNGNU?=
 =?utf-8?B?NmVBOVlCQjU5T3paOXV0TGkzeGg4UHdJdUMrakhSdjZ1Ri9wZ3dwMXNwZnNF?=
 =?utf-8?B?ZEcxOEpVRnh3MkUzZERJcDQ0clEyRS9GMXBZL3pKRmhVTmdpOUVpdDRaZGhD?=
 =?utf-8?B?ZncyeWdteVQzQWhDNExUbml4QmgrRlNNVW1vY0pwU0FzcHEvUnNFc0g1UVBR?=
 =?utf-8?B?MEszNllFaTVhRzlsWnV6TzdOT3JBdDJKRDdxdkZmcTZ0NEU1Nkx1WEpkazNF?=
 =?utf-8?B?bWcxYWQ3ZEllU0Q2T0h2ZllrMmtlcjVaclNwamxjN2NUZ1RxTkRNa3MvSzhX?=
 =?utf-8?B?QTV5YVA4U3pibkJNWUllUnRmd3lyNERtekNTRVlPb1F6a0l4TmZ1STNpVUYw?=
 =?utf-8?B?N1dTWFdQcXFQcUhzQUVRSS9JTFh6d1B1NGRmSkhVc25lbVpMQW1QbjZ3b016?=
 =?utf-8?Q?vcE77jYo9NtFmi8QBaEE2Yd1YPpgHM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:01:03.8551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd61b429-a5ce-4f6e-f726-08dd62d6bfef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531

Hello Aaron,

On 3/14/2025 2:18 PM, Aaron Lu wrote:
>>>    static int tg_throttle_down(struct task_group *tg, void *data)
>>>    {
>>>    	struct rq *rq = data;
>>>    	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>>> +	struct task_struct *p;
>>> +	struct rb_node *node;
>>> +
>>> +	cfs_rq->throttle_count++;
>>> +	if (cfs_rq->throttle_count > 1)
>>> +		return 0;
>>>
>>>    	/* group is entering throttled state, stop time */
>>> -	if (!cfs_rq->throttle_count) {
>>> -		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>>> -		list_del_leaf_cfs_rq(cfs_rq);
>>> +	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>>
>> Once cencern here is that the PELT is seemingly frozen despite the
>> hierarchy being runnable. I've still not tracked down whether it'll
>> cause any problems once unthrottled and all throttled time is negated
>> from the pelt clock but is there any concerns here?
>   
> I chose to do it this way because:
> 1 I expect most of the time, if a task has to continue to run after its
> cfs_rq gets throttled, the time is relatively small so should not cause
> much impact. But I agree there can be times a task runs relatively long;
> 2 I think the original intent to freeze cfs_rq's pelt clock on throttle
> is so that on unthrottle, it can retore its loada(without its load being
> decayed etc.). If I chose to not freeze its pelt clock on throttle
> because some task is still running in kernel mode, since some of this
> cfs_rq's tasks are throttled, its load can become smaller and this can
> impact its load on unthrottle.
> 
> I think both approach is not perfect, so I chose the simple one for now
> :) Not sure if my thinking is correct though.
> 
>> Maybe this can be done at dequeue when cfs_rq->nr_queued on a
>> throttled_hierarchy() reached 0.
> 
> Yes, this looks more consistent, maybe I should change to this approach.

I agree the time might be small in most cases but some syscalls with
enough contention in the system can take a while to exit to user mode.
Even I'm not sure what the correct approach is here - should a
subtree's PELT be frozen when the last task dequeues or should we
freeze it for the whole hierarchy once the throttled cfs_rq dequeues?

I'll wait for other folks to chime in since they know these bits
better than me.

> 
>>> +	list_del_leaf_cfs_rq(cfs_rq);
>>>
>>> -		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>>> -		if (cfs_rq->nr_queued)
>>> -			cfs_rq->throttled_clock_self = rq_clock(rq);
>>> +	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>>> +	if (cfs_rq->nr_queued)
>>> +		cfs_rq->throttled_clock_self = rq_clock(rq);
>>> +
>>> +	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
>>> +	/*
>>> +	 * rq_lock is held, current is (obviously) executing this in kernelspace.
>>> +	 *
>>> +	 * All other tasks enqueued on this rq have their saved PC at the
>>> +	 * context switch, so they will go through the kernel before returning
>>> +	 * to userspace. Thus, there are no tasks-in-userspace to handle, just
>>> +	 * install the task_work on all of them.
>>> +	 */
>>> +	node = rb_first(&cfs_rq->tasks_timeline.rb_root);
>>> +	while (node) {
>>> +		struct sched_entity *se = __node_2_se(node);
>>> +
>>> +		if (!entity_is_task(se))
>>> +			goto next;
>>> +
>>> +		p = task_of(se);
>>> +		task_throttle_setup_work(p);
>>> +next:
>>> +		node = rb_next(node);
>>> +	}
>>> +
>>> +	/* curr is not in the timeline tree */
>>> +	if (cfs_rq->curr && entity_is_task(cfs_rq->curr)) {
>>
>> I believe we can reach here from pick_next_task_fair() ->
>> check_cfs_rq_runtime() -> throttle_cfs_rq() in which case cfs_rq->curr
>> will still be set despite the task being blocked since put_prev_entity()
>> has not been called yet.
>>
>> I believe there should be a check for task_on_rq_queued() here for the
>> current task.
> 
> Ah right, I'll see how to fix this.

It may not be necessary with the recent suggestion from Chengming where
you can just add the task work if the task was picked on a throttled
hierarchy.

-- 
Thanks and Regards,
Prateek

> 
> Thanks,
> Aaron
> 
>>> +		p = task_of(cfs_rq->curr);
>>> +		task_throttle_setup_work(p);
>>>    	}
>>> -	cfs_rq->throttle_count++;
>>>
>>>    	return 0;
>>>    }
>>>
>>
>> [..snip..]
>>
>> -- 
>> Thanks and Regards,
>> Prateek
>>




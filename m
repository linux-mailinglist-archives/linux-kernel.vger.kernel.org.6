Return-Path: <linux-kernel+bounces-560653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC81A607C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747BE19C2EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8C130AC8;
	Fri, 14 Mar 2025 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JAfyB4LU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CB770FE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741922906; cv=fail; b=mzYOpoFtVoC+4g5B/JbVgBBW8SXJ8nCUSJxSLd1tT2L7Ho7uVdIZ+SIm96wnkKe/p0aQ6M0yRcoSHlT1wntgOPwlMAkilMbEvAXEhaI4bZqmRhFFXEkLoNXC4t9/icvCObhSOcaBm76bXvmM6n8BoaTIy/T5nUO5K+2Zr16Pe7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741922906; c=relaxed/simple;
	bh=QEPRW2UVTb2YaO7O/3cr2mEyUEUNGPsLJYbSoDQEIC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jhzwk5yoBZN+X8W+L0gzxDCRc+5kAkb6XPjr6eYtGo0LReKlzKqZK2eye/4uAMoaWvm858ZC9PQ2Yqdf2xG6JoYA2evkxP6E/zTtfpiJrac5yqU5CCDWnAdeQ5SWg15DMeh0hpgFsbn59k7dylCztA9t8fpeiOw73pLPCA0vvVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JAfyB4LU; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaeRdJuTyM21ApQVXEkDG8gjzJB81DCmRwqe8SxgoWausgJaAta4rLku1Ze5xjADpbyZXosOGi+5Av837n7OVNiz4lciv75UzbiEo1+TsyUp4MYfptt3SvaiYQiK/7zKO+P+WO7KJhR5XUqm7Lh8GzN5BTR30VqfEl2B+Qv/wdWy6PmQPV45unl2eSLVs72lq1hUltXnW/F0pDTu7psJY+Z6a9srhRjCPgAhz61ijbgX2NOtLmtKLeRV3fcfYBdsw5y5LJQatk8yvrpjyfheHt6SuvEF+bhXDKhpi/GdHS4AlCcnLZ65V+uz0WWMsMH+iMt/jFCsSJ+0aK2Ij4FJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaelWoVQH78yhxVbbNFN79ZUotJsDoF9WOJ9I7jDTnY=;
 b=nRgEmq0x3UQg6BYAZxHXb5aAEcTvXF4XdJ6wc/Bidj87gbxJJwZ0Io1M4NV7VoOfA+l51FJKSoXi2SnkwvMpzSQo8dlz4W1ihHgA+AIwkBy6hMkkFVn3w7nQXrWP1t3DwKETjkK4OJ79rdISznWY4Q5n47yJFuaNp99dcy7UQuhKHDuYx4phgPumtWtQLujyH+o/Idn/VSAvxosIkgtIrStH8e+T3XI3gqlaKGhNx6VrJv1Ze3m1GMqLfrSUN/xNcqMAuYWeKbzt4VVXE7Zlm88pgS7Sv3tsJVIiQDBotQO4OdIGlYdcj4sjk27LQTz4+i7rJf+PM1MLtvkKQkD58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaelWoVQH78yhxVbbNFN79ZUotJsDoF9WOJ9I7jDTnY=;
 b=JAfyB4LUq2Rmz9YPLq7MRqDACfZb9iHpOi/6iM0ZRAcIsxg4YmGuxB6EL/NcwK8/3VqJeVdfuLM24f7w0p1wJ14pruX57vp2vluoXqX2WDbq7HYG9gvQ7G5hBzEAwQhjaV5DXAEEyZfuc7WxMq8bgGlWEcyaAxUkvdpC1vionjg=
Received: from BY5PR17CA0030.namprd17.prod.outlook.com (2603:10b6:a03:1b8::43)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 03:28:21 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::bc) by BY5PR17CA0030.outlook.office365.com
 (2603:10b6:a03:1b8::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 03:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 03:28:20 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 22:28:16 -0500
Message-ID: <ddd839a6-916b-4a23-a998-0d44486588ab@amd.com>
Date: Fri, 14 Mar 2025 08:58:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chengming Zhou
	<chengming.zhou@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 027aeca2-9baf-4fcf-ff98-08dd62a844fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmsyZmFlL2UzRW9FNUgrWFpKOSthTGtvRUZJYm84cUxvQVZFYnBUaDl0RENB?=
 =?utf-8?B?ME5aWkNvM0xNdWRNQ1FhTXdMaXVidnc1SGtYUlRLNGpScjlKd2FBSVRxOXVw?=
 =?utf-8?B?a3pLbDZWMzE3dHB6b2Z6b0t3b2ZwUzJ2dWN3TG1ucnVhanprTDhUQ1NNbDIv?=
 =?utf-8?B?eG5EYlNZT09tMlVoaFZDcVpvbTJjQTVQV1JVeGIzbCtweEpuYkdFdCt1UGZk?=
 =?utf-8?B?TE0wcVN3TFc1SVBnclFuZVptRHVhcmRlcHI3bGI5UGpnZGlBTUlnUTN5SjdK?=
 =?utf-8?B?TkNZcWxCQldZc0JnQm1qdUM3TW9rU3A0clAvMURRT0FPY25wdUV6MUcxTDhB?=
 =?utf-8?B?cEFQSUJjZkV5QmhBditPSXM4ampFaHN2OVYrekFtdHRIWGhlc0ZYMU1pZVli?=
 =?utf-8?B?b1JPZkZrSERXU1ZNRGNmVnJhOUNLVmUwc3FvUzJScEJUZ0JVTEJoUThpaE8x?=
 =?utf-8?B?QnBNV05qVlorUE1rbGV4SDRpcWM2NHRYTVNYNHNyTHk1MlY0c2lic0xtaXU3?=
 =?utf-8?B?MndQb1Bna0tJTjNyT1pCYXpyZU90bHk3Zzl0MFY1MlQ3amc0L0ZrVXd0MXM4?=
 =?utf-8?B?R2l4Z2hXMGpvLy9weDVpcDRxRzZvZGE1QTRFZEJTYW9rMjVzci8zZFhVSWhu?=
 =?utf-8?B?TzRVcURVUlBMSTBneUNFK1g0QzRJckVDYUpGWEx2WWhweVVPOWdXaTA4THh4?=
 =?utf-8?B?RHFjQ090SXRGdHFsb29CQ21qYitnSnVLR0hucEg0WDR1VExFbEExNjBFaStN?=
 =?utf-8?B?OWxWMzZGR2t1d0RQRVpWZmZIKzEyTkxFM1gwelg1ekZWcWNoS1hzaDN3Z0tU?=
 =?utf-8?B?V3UxOUxhYjhBQTA2dnYvZ2F0am9WcnlUZHJ2b1h4ZnR1OTAxeUlJSnFYZkl3?=
 =?utf-8?B?WXBvYjhpNHI4cncyeUdzbG5uOTdieEZLbGpSYytUd2x2ZHN0eU9TTlBhVlZH?=
 =?utf-8?B?R3FBWVNFc3FvVXdJS2pBTXk4SzBCcUJEbW9pcFBsb2NodkMwcDZwMUxPQjFm?=
 =?utf-8?B?Y0xXb2NlNFEwcU83WGFjbHRlTzVVcVpZY2pUTGEvRmhwK2NYSmx5WlQ3Nm5k?=
 =?utf-8?B?eURDNzNkc0dTVW1HZWllTUdLYUNjYWVEeGxUb3ZrNlFFY3FCcG1qTmgzQmhZ?=
 =?utf-8?B?K0dBWW9xSXdFMElnYVZXNWUwQ1lOSVQxQ3dYOGFUbGI1N2NyMGFuQU1paE41?=
 =?utf-8?B?Z1F4Q1FHNFR2QVgwMGVyUGxlR1lZWDdvWHJnUWcwQWV6NndMREkxSUNDcVNN?=
 =?utf-8?B?OGlpUTltNFMxYXh4bU4veFZSSUhDT283WEVFTVkyZWQ4NURVeU9xZUYyclph?=
 =?utf-8?B?VkZ2cnRJNkt0c3lhcHpMMGllNitUTzV3ek91bzlmUVVDbmgxTzdUcEtndWg5?=
 =?utf-8?B?NmdxdWRXRS9Gdk1reURqakdPT28wWm1hQy84Z0hkcHpRNDhkSkVyaWkzSU13?=
 =?utf-8?B?UmsxTkJSZll0UnRpT25UT1BvZFNBc3htUkpmZjJoRDZXdE1rSlc3eGJoRGVS?=
 =?utf-8?B?MENWVDhTbHpNSWsxWWZWZUpMbVRDTm1mUjhEWmorMU1ReEtJSUVJbndFaS91?=
 =?utf-8?B?OWlhN0FyQ1VpQjBia05vWlZ0cFphMmVNWjhDZXVGRjNqbFZzN3ZQeVlYbU0w?=
 =?utf-8?B?SzFxd3JnZ29ocUNRQWYwN0xUV0NsRDNHZlhxNDJ2NmRtREpYZUNadG54d1dx?=
 =?utf-8?B?dnVUOWtxTFFxVjgyM1UwVGdpOVBBZzVxT1p4RTRsWExhdHBkRHJ1d1pDYkFI?=
 =?utf-8?B?OUcvUTcxY0VzRU0wSlg2enhWQWZIMXpwY0p4KzNXZi9hbzRnbGw1QkIxKzU2?=
 =?utf-8?B?U3diOVU0aUxVNzNnVGQxRmpmZUU4elg2SjdyLy9hY1pvM1V5UXdCV0FYdDlw?=
 =?utf-8?B?dVBiRUZ3VXk2ZlNyY2hVNkRaT0JXNTNNTTluMlVhL0tCK1hyeWRmMlh0S0lC?=
 =?utf-8?B?dmt4VTcra2hpUEZmZDJPUmk4SUFxTnVZSGlUdFV2M2l2R2N0UXpvd2ZhSXcv?=
 =?utf-8?B?QldrZzhHTmRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 03:28:20.6596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027aeca2-9baf-4fcf-ff98-08dd62a844fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530

Hello Aaron,

On 3/13/2025 12:51 PM, Aaron Lu wrote:

[..snip..]

> 
> +static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags);
>   static void throttle_cfs_rq_work(struct callback_head *work)
>   {
> +	struct task_struct *p = container_of(work, struct task_struct,
> sched_throttle_work);
> +	struct sched_entity *se;
> +	struct cfs_rq *cfs_rq;
> +	struct rq *rq;
> +	struct rq_flags rf;
> +
> +	WARN_ON_ONCE(p != current);
> +	p->sched_throttle_work.next = &p->sched_throttle_work;
> +
> +	/*
> +	 * If task is exiting, then there won't be a return to userspace, so we
> +	 * don't have to bother with any of this.
> +	 */
> +	if ((p->flags & PF_EXITING))
> +		return;
> +
> +	rq = task_rq_lock(p, &rf);

nit. With CLASS(task_rq_lock, rq_guard)(p), you can fetch the rq with
"rq_gurad.rq" and the "goto out_unlock" can be replaced with simple
return.

> +
> +	se = &p->se;
> +	cfs_rq = cfs_rq_of(se);
> +
> +	/* Raced, forget */
> +	if (p->sched_class != &fair_sched_class)
> +		goto out_unlock;
> +
> +	/*
> +	 * If not in limbo, then either replenish has happened or this task got
> +	 * migrated out of the throttled cfs_rq, move along
> +	 */
> +	if (!cfs_rq->throttle_count)
> +		goto out_unlock;
> +
> +	update_rq_clock(rq);
> +	WARN_ON_ONCE(!list_empty(&p->throttle_node));
> +	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> +	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);> +	resched_curr(rq);
> +
> +out_unlock:
> +	task_rq_unlock(rq, p, &rf);
>   }
> 
>   void init_cfs_throttle_work(struct task_struct *p)
> @@ -5873,32 +5914,81 @@ static int tg_unthrottle_up(struct task_group
> *tg, void *data)
>   	return 0;
>   }
> 
> +static inline bool task_has_throttle_work(struct task_struct *p)
> +{
> +	return p->sched_throttle_work.next != &p->sched_throttle_work;
> +}
> +
> +static inline void task_throttle_setup_work(struct task_struct *p)
> +{
> +	/*
> +	 * Kthreads and exiting tasks don't return to userspace, so adding the
> +	 * work is pointless
> +	 */
> +	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
> +		return;
> +
> +	if (task_has_throttle_work(p))
> +		return;
> +
> +	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
> +}
> +
>   static int tg_throttle_down(struct task_group *tg, void *data)
>   {
>   	struct rq *rq = data;
>   	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +	struct task_struct *p;
> +	struct rb_node *node;
> +
> +	cfs_rq->throttle_count++;
> +	if (cfs_rq->throttle_count > 1)
> +		return 0;

General question: Do we need the throttled_lb_pair() check in
can_migrate_task() with the per-task throttle? Moving a throttled task
to another CPU can ensures that the task can run quicker and exit to
user space as quickly as possible and once the task dequeues, it will
remove itself from the list of fair tasks making it unreachable for
the load balancer. Thoughts?

> 
>   	/* group is entering throttled state, stop time */
> -	if (!cfs_rq->throttle_count) {
> -		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> -		list_del_leaf_cfs_rq(cfs_rq);
> +	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> +	list_del_leaf_cfs_rq(cfs_rq);
> 
> -		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> -		if (cfs_rq->nr_queued)
> -			cfs_rq->throttled_clock_self = rq_clock(rq);
> +	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> +	if (cfs_rq->nr_queued)
> +		cfs_rq->throttled_clock_self = rq_clock(rq);
> +
> +	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
> +	/*
> +	 * rq_lock is held, current is (obviously) executing this in kernelspace.
> +	 *
> +	 * All other tasks enqueued on this rq have their saved PC at the
> +	 * context switch, so they will go through the kernel before returning
> +	 * to userspace. Thus, there are no tasks-in-userspace to handle, just
> +	 * install the task_work on all of them.
> +	 */
> +	node = rb_first(&cfs_rq->tasks_timeline.rb_root);
> +	while (node) {
> +		struct sched_entity *se = __node_2_se(node);
> +
> +		if (!entity_is_task(se))
> +			goto next;
> +
> +		p = task_of(se);
> +		task_throttle_setup_work(p);
> +next:
> +		node = rb_next(node);
> +	}
> +
> +	/* curr is not in the timeline tree */
> +	if (cfs_rq->curr && entity_is_task(cfs_rq->curr)) {
> +		p = task_of(cfs_rq->curr);
> +		task_throttle_setup_work(p);
>   	}
> -	cfs_rq->throttle_count++;
> 
>   	return 0;
>   }
> 

[..snip..]

-- 
Thanks and Regards,
Prateek



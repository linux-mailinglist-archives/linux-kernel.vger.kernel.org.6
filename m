Return-Path: <linux-kernel+bounces-560180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E1A5FF06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0311D3AE938
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557B1EEA27;
	Thu, 13 Mar 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41nGl47/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2B1F0E27
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889714; cv=fail; b=a+6JxVIn7TLHrREXdyjMfme0WA0yBMaVli5Kj27WUXNzyky4uuAbNe3Ms8++q94Y8HPu21+FkRjloFsDWwK4iaxlzD8Uj3D9cikRUABFVcT51X1sD8/IsU4QYIOUPbzWOmoPWGSD95HvxKVJd5jtWmaKNdRZD6usMwynXEmIBSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889714; c=relaxed/simple;
	bh=fi/WTZAYQPQLuqHMKgE7vkmY526crvUvCfq6rZAEMNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E/mruk7yJXfYxIcoNDdIwRiWBtfHjLa43iE9yFQaZ9i17yxNiYR0CR1PnrXBeB1PQykWSii8IQXE9wr+xzXK8SutN0pKouPzk+fVJgaKGRwJkZOQgRuNr4ScBhPSTYSqcuy9SX/vdbyYVfUnIs28OYA2crxtC4JpdKaJj3Vk2iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41nGl47/; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4uS9au/Ph6p5bPZs+p62RIqH6hgtvM61reCP0Ly8Zf2fkMJcukQp6WAUqRDhs0F4LkyXDBzWmmZWFwANiRAeZp4c+1qXauOnCgFkmaDRp5sLZ3NjzcvvM7LRvk7aQvVEydMvB8Kf0KoV+CtZXHwby4FDa9W/Y/1Qeet8tr/cwEzqojBtBT8rnm/UrUpPrTWN8g6HiL8gsBLKvw4hrFXV0nVGpZkYC2ghBTqiutpz0LIwC/OKZRSaoSwmBAz1zNWiQdZU9VHkyWpSPevkA//yo17i49VbG1lWb1FEZWfVwyrnOxr29KjiuP0jPt2Lp7SoEZe40LoWDoCZyGWqFDYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmFaiIWoEMVzk08vBUW3BM6kwDDw9O6do6x3Rsy42eo=;
 b=x/koPgGsh8pT0lWxz6ajpIXGEdHKcojPTGARduC1/3FurwuR/DG7IskjtcsnDWqdHp9BNFo0PUWA/2EBSW1Zbgm5CRwULOKR2tCn35Vo0LtHd2D/xihGOZGa6qseRPeaTYRvzREpXKFOq4GaQFNdlmy6X5dAOWIPbAJZbOMu9l4XLh42yE3WtGTYOO/tKk/JzJJsGueOayVl9iUDmTg1Am54iHhEQrWCA9eMyaeqif2oREnFxJfcAW8V1BW4bX4a7nXjs3o+YkHlUwB9YYaiHyoKbbJ8NElnTDZKEudt1ttExAz8vgCT0ySpZQ+p4brWnTfjghAJ5w5ZJjVGLYgnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmFaiIWoEMVzk08vBUW3BM6kwDDw9O6do6x3Rsy42eo=;
 b=41nGl47/061tcym7J1ga08PeMI56sTDeC5nJKpb9BkBroZimB/1GONZ042R5z3edtk2vqlV5N1kvEFma0C9Ks2sHVXErRSW5SBzktmnB5KirEwqS1IgT62bsVZTXlu1RG3I3bW8j7LPYt42xBdHf+tWuaNkNpPXpk4DoQJ3JrrU=
Received: from CY8PR11CA0003.namprd11.prod.outlook.com (2603:10b6:930:48::29)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 18:14:58 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::c4) by CY8PR11CA0003.outlook.office365.com
 (2603:10b6:930:48::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Thu,
 13 Mar 2025 18:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:14:56 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:14:51 -0500
Message-ID: <c9b1d117-2824-4238-bb8c-6390ec3e931b@amd.com>
Date: Thu, 13 Mar 2025 23:44:49 +0530
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
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb01a8b-ba4a-489e-4048-08dd625af5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlRiRmF6UUNzOXNxZGF6c0JBcjlkYWZ3d1NOZHV6QW1ZdGFVV2UrWWJiUmdC?=
 =?utf-8?B?SVFEZ2lHR2ZXaHFEU1BLdHV0bXlDRXNmU21YOVErcklCcThlMWJsWnExOFhv?=
 =?utf-8?B?aTBoL1hpNUlwSno2R2crRlJlSFJxcnlpV1oxSjVVK1l6aE55Z1ptNThYMGJz?=
 =?utf-8?B?S0FVdnFudEVCNUVNdGtaVHRVL1N2VGp2SFg5NjRYcWp4OXljbTZMR1ZrTmRD?=
 =?utf-8?B?bEZIdnRpWTIxSGFDMnZYRHcyNFpsRHcwQXM3MzYwOVdpaGRzbGM0YTZ6eHV4?=
 =?utf-8?B?VHpabUlkcStQUVd3SmpzUDVwTDM4SndtMytOWUN4blhpUFdvTnRYWGN4aHdj?=
 =?utf-8?B?MnVOTVc2OXM5cWJWL1BWbTdYVHNEQVBIQzNUT2tEZWtOOTZ3N3U4ODJ1T2tN?=
 =?utf-8?B?aE9sN0NVYTc0Z2U3cC9QbkR1ZmYrL2FNMko2ZUx4eDFrMS9lWHR1WFlRdWtk?=
 =?utf-8?B?ZzcvMlhLVDN5aGUxakVxbitaMWFFeU1KSFlJQSt1OGdGVkVuUWJESDZIbnU0?=
 =?utf-8?B?NDVGMUlHSHBHc2czeVdsN0xGbUZsSVdHMUFSbFB3WWpLbnc3ZGxMaG9aWXkx?=
 =?utf-8?B?em96dnU4d011Rmd3ODNZL2lCbFVOaUs5S3dqelBYTWZicVVXSm5aOGxBTnVt?=
 =?utf-8?B?bVloZUtLZC9EUkVaVWdiajdvU0tSSURrU05GNHc2Rm9lb3dleUhod1N4WUhP?=
 =?utf-8?B?eDJDQUtOWWd5WE9aSDlCdVVJUXhUb3RTQ2pVYTFZQ3pZOFl0eGVJOEJvdXBE?=
 =?utf-8?B?TE9xbmtJZk1aSmc4VVV3aGE1dW80ZXNLWkpSYzlHQzI0ZDNDdDV4KzVFaGd3?=
 =?utf-8?B?akZLbmtGRVpXZ3JJS1g3ZnBBZExhak4wdGJoYllBRVpYR2krT0M2eEhGRktl?=
 =?utf-8?B?UHZyMFZsaUNGV2RNenUyZVU5SHdzOGhyNDdISFkyQXYvU2w2TzZXdTJQUjdY?=
 =?utf-8?B?T1JwMFA5ZWY3UGxpeGJjL1FmOUd4L3RtQ2RBRlBOSTNRUW44SWFySlBSTXRa?=
 =?utf-8?B?ZlVyZlgrT0RKa3Azd25xNEZJaEZSQXdUR2tHdlJ5bGh3bno3N0NqcThsc0NR?=
 =?utf-8?B?WE5HM3NWSUt4RjRYM3ZkZ1B2anl0Ty9Ua09GWk5nWGt1b2Znd3RSTjlCaGJX?=
 =?utf-8?B?QjFlaEx6ZVQ2U2RaaVk3WTJNYlRRdmpNTE51aWxFaTdNaU5iL0lxWUZ4dnRo?=
 =?utf-8?B?aDRyWUJBdzJkdjVTSUxTOTBBcm5ubzQzOUwyUkplNytvaXQ1Vk5iYWdYRzZ6?=
 =?utf-8?B?dU9TUFIwREg4Z1duT01GWE5TcHdPOHFGc2xBTjV5aStHTGNVNGFYOG5yaG5B?=
 =?utf-8?B?R0drRFJHYjZSaFFPV0NDcXBKckkvYkJpK245WGlBNkxNaG9BWk1Xa3cxOFdT?=
 =?utf-8?B?bFpGNUdaMW5mQ3hsT1JTMGY3MnNRT3hIOUJNVTZ5UlppaEx2bXBHc0RVSGtp?=
 =?utf-8?B?SElieWd1WkpScnFHbDNhRUhHZCs2aGs3bjNKQ0hlRHlxTVQzS0lZZE5sTHpM?=
 =?utf-8?B?eFhOUWI5MkhNSkdBTm5lWDA2V0tKeWk4WmVzTzZ5MndwRldyT1prOGEwVEZG?=
 =?utf-8?B?MU1NWUl4Y1BKL1Y2ZkZYdGZSNVQvbGt6VTRBUVRKWXIxVVcwQ2ZnRDB1STdi?=
 =?utf-8?B?MklqakJiaTRFSTExbVJ0eE9nWFNmekRNdnJCQ1NmSEJMTU1teXBabThFaStl?=
 =?utf-8?B?Q3poRThxMklOSXkxWjcxUlpsM2Y4SEV5dzVMZ3F6R1BDQlE2S3MwRjF2cGZL?=
 =?utf-8?B?dWNtTjR2TWxBMytHZVlGKy9iTUxkQnkwMitOQ3YrUTE4K0kzQ3BZZ09iRWJ0?=
 =?utf-8?B?WlRoaEZ2OU5ZOFNTaVN1RW1iNFhGQk9adGJJYnZ0bXJsdS9pcEY4YWhvdWt4?=
 =?utf-8?B?TTB3V2EwbTdBSThiazMxMFZCaHpBVmZ1SGZoVHVrVWhvZTRiekZwcDVZUG1H?=
 =?utf-8?B?ZEtKTnJVWXpWb0pGN1dBRm9xc25NQ1AxUG5MNFBncmlCQ28xbUFqSHI1dUgw?=
 =?utf-8?B?UUJBOUszdStnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:14:56.8141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb01a8b-ba4a-489e-4048-08dd625af5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

Hello Aaron,

P.S. I've fixed the wrapped lines and have been testing the series. So
far I haven't run into any issues yet on my machine. Will report back if
anything surface.

I've few comments inlined below.

On 3/13/2025 12:51 PM, Aaron Lu wrote:

[..snip..]

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

Does it make sense to add a throttle work to a delayed task? It may be
dequeued soon and when it is queued back, the throttle situation might
have changed but the work is unnecessarily run. Could the throttle work
be instead added at the point of enqueue for delayed tasks?

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
> 
>   	/* group is entering throttled state, stop time */
> -	if (!cfs_rq->throttle_count) {
> -		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> -		list_del_leaf_cfs_rq(cfs_rq);
> +	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);

Once cencern here is that the PELT is seemingly frozen despite the
hierarchy being runnable. I've still not tracked down whether it'll
cause any problems once unthrottled and all throttled time is negated
from the pelt clock but is there any concerns here?

Maybe this can be done at dequeue when cfs_rq->nr_queued on a
throttled_hierarchy() reached 0.

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

I believe we can reach here from pick_next_task_fair() ->
check_cfs_rq_runtime() -> throttle_cfs_rq() in which case cfs_rq->curr
will still be set despite the task being blocked since put_prev_entity()
has not been called yet.

I believe there should be a check for task_on_rq_queued() here for the
current task.

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



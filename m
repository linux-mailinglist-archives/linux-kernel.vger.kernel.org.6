Return-Path: <linux-kernel+bounces-560671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6FA607F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F608804B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC80136327;
	Fri, 14 Mar 2025 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ydiq+gpU"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B3BA38
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741924444; cv=fail; b=h6wFi4urnhgxR1mE3Pfc0MSQ/QGg254a9ebcq70cOPUzQhfcw8rVKHHxBRi5Ax77AGDlJWXag4bfhHNq6PSz6ifYK1s1bJuxZUUfQQ+KqbcaQ3j7JgzpBz7eJXtTL5I1uzwte8YOg3Fxj94XSJYdOUmHoa86cXR/s6EqgD2/voE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741924444; c=relaxed/simple;
	bh=fhS6v8qEXJnRDiTd0ajktQ881vshWPEmU/OTowNoooU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f5GJWyhy2GdRdonxiN4RXXCXG9hfvm0UA5PW34sm7VYickwa9hRXKU9u2wRG5EQqs/gf007Pg+J+jG0+PWjtPFhWZNyWXSP+Clsm2aarnNSCKWZDXWst9ocK2JIQozUX9M8MJ7Ti0NtICxLYa8UC3hE7WXIEACD2vW0XkL90T54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ydiq+gpU; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh49IggH19I6osB2bTpcGKOdnbW2txKp2o+M1E9vmoRPspTWoygJ/aHMvtkQploNqWSLEmqbTTA4aPSVruGfOrZgy9NHV2qktDpJYhWew5gD7Aoe10USNCuyR4IWJT4RquGWGK5IYQHztKkNAYEOn1PVthzgWGa1nEAtw8xG0TysE/7sJZr387sKyvitoH7dnfFudSKon98qqPLEVhKz1vTlSbQqTW3ZsN5r+6GrtqsHyUwM4WKd0xPhxaPEFnFLiIy38uQdN2OynqnQh/K7L6CVcNNwkuDhS5ElZUQZpTgQ0UqFXnYgTzBSouCWQwc6B+Ul+SOS4+RVRRQ1y/UUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWycRZhtt2QlM2l99B5XYzOK1h7Ysf3u+0cik/mz5m0=;
 b=VoDsGpu1qUMFdlYOISKRU10ePY45kHV81vHYSaY+ulaWdyUlWUj6Wc81hoN6AZz4hv/ZeRIdcOAsuBqmW7g/8Ru/L4tj9LwhY4NJK6B3PcDiLqexiiaVin0gNOiOWG4Lu4R/2D1xpED2X543LESDGy6CC63wM5cXA8pLxV0WqmhlC93SrKtf2cvZNQDCHikdLsbTO4JJyXtIBqn3izpeCsxMN5Go5Fbs/7UEorX2FR9WMnWGKbnoe6caJQ20v6ugMe6TEePdemOV7P3YkSuYowajauEa3n8l6XxZdoJOwE2CSzne3YIxNkuyIuCIfjNps76+hiuUuBbJtjIAikOLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWycRZhtt2QlM2l99B5XYzOK1h7Ysf3u+0cik/mz5m0=;
 b=ydiq+gpU7NNDVtPyctv2+L/NdV3w+MvJDd7iiP8MnoE5T1G2lis3mNz0uaDlqP0jiYdc6GXmfzhq4bU7kKS1oQuyD+Y4rzTUnWoTU3M5VYT3zK9Txq/39m5OXro3atcFVKcGiyuOS61bMXpyZvJx+F5/MIMD+i4apSDdzeJDkBU=
Received: from SA1PR02CA0022.namprd02.prod.outlook.com (2603:10b6:806:2cf::29)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 03:53:54 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::da) by SA1PR02CA0022.outlook.office365.com
 (2603:10b6:806:2cf::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 03:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 03:53:53 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 22:53:50 -0500
Message-ID: <3fdb7163-d1f0-45c8-89fa-7c904b567696@amd.com>
Date: Fri, 14 Mar 2025 09:23:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/7] sched/fair: Handle unthrottle path for task based
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
 <CANCG0GcAic5QThYG-r9CaXPgZtXJuB0RuCW5Y0SyBn7VyOQi=g@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANCG0GcAic5QThYG-r9CaXPgZtXJuB0RuCW5Y0SyBn7VyOQi=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2e4041-6337-4a70-347d-08dd62abd6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHVhdW1hY2JBWCs5SWxYb1REdEtXeHdoY2tXNFVJN25LQTdrdElQZ0QzQVBw?=
 =?utf-8?B?MmgwMDZvMTVVNEF5cGkvTktzMEVqUGpSUVk0Y1hQNnFOd1lPMDNsYVA0aDl6?=
 =?utf-8?B?WUh5cWpOanpQRlB6MnBBZDBHamVHY2I1eFcreEFGcnc1dXFGbERNUEZ2UGJx?=
 =?utf-8?B?UW5NalkzYlNUYW5HT01NWmQzMm12NFlEdDBYTjgvbHc4N09mRVIrK21JcHE5?=
 =?utf-8?B?U1cxdEJqVVUzd3l0QTBEekt6SXIrcFdad2J5RVBnYVhOSmJOWC82SzUydEIw?=
 =?utf-8?B?bU5ndm9yNzhZNFQzUGRqQXlDUDArOVhkVG51SVBmUWs1NytCRG9lU2FiRHkr?=
 =?utf-8?B?M01MVFhpU1haT1Q0dlV6Y1pnbW54Mk5MVnNqN29WWlRxMHF0R2t6bFdyMUlJ?=
 =?utf-8?B?MGJBd1kxd1FTRkNEa0Z1cGFZQW5tRmdJYWtvT2ZPcjFBdG50bVdEVDhvclVU?=
 =?utf-8?B?d09Kek5YM1JaYjB1SWRZYXpFR0Q2UWorRGl3R3ZadmJFdmN5QXlZNGliNzIz?=
 =?utf-8?B?U24zK09ldTNMZUtldHNWRjJGRzk0UmFxZUhFMjgzOVJWN1l4K1RvQS9LditC?=
 =?utf-8?B?dG5Na00yakhtR2E3bk9xUWFGSHZMUDRWdmZ4aTIrWC83THV3eGlxeTNUbVlq?=
 =?utf-8?B?TFBYaXVZaVRwaGhLUDhRd0wzTjN1aFB2YUlhZjlrcjl3S2JGVDBoZlNSM1Br?=
 =?utf-8?B?YTc2aFJEZFNCMCswVllydndvSGNGVng2czVERmJpUDNNY1dobkdBUTBSMjlw?=
 =?utf-8?B?cmxnaWxsKzlwRllaSlFRQktVR0hTcWkxMmlPWFJzVXpHSEVwWldSTkN3TVEr?=
 =?utf-8?B?dDlBQXJpMSszV296UGQvNUM3aFZJQ2psS2FVM0cxUUdXNk92T1JrRGZUVXpt?=
 =?utf-8?B?bklZVWtMUjNMek1pZTQ1R0JVdmE2MkJwVEJKNU10VXV1T1UvU3N0VlFqNDhJ?=
 =?utf-8?B?VFA3Z09vQ09kZnJpd1ZiNW1ScEdnbktPQkVJR2dhbWdwK0ZicGJxRWZyZzUy?=
 =?utf-8?B?S3VKemY0V2EyMUpZVHFvZEx0cW9uOTh0UE1yNG1MRmhRNjdwRjRpQWhLVk9h?=
 =?utf-8?B?UGtGVW5rT0xiTm9FU0pGT2R0bElkUzdLYlVqcjQvL2NRSHRCMFk1elRuYjY2?=
 =?utf-8?B?ZnQxMG12Uk5xR3BCbGVMd2hNWlVlck12MTEydE9QTmJDQmZNWVZhOGxVbU5z?=
 =?utf-8?B?VnFKUmlyaUNESXB4WGhXSGNhRTQzT0wrTVQ5VThWT1BYVzRhc1pINjhzMG1m?=
 =?utf-8?B?ZVBzYjkvbmdnL1pZeDJzNXh0clNHemxIZG1CT1JYMEgrVFJmV2pFbWVaUnoy?=
 =?utf-8?B?VTIwb2xWeUFwbFFpTExucTFwSFNMcEw2Y21JTnYzcGV4MWx0Sjg0YWEvc1Rt?=
 =?utf-8?B?c3FjUUJLUnE2TXg0R2M1NWVBZjhKNGg4azlpTC95SDFFMnExcmt6SHVyaU1Z?=
 =?utf-8?B?Njd2dDd3UllwZXI5L1hxendraGtpaHNoV3BvcmZZaXRQWUZDS05tdUZCeGpY?=
 =?utf-8?B?cGtLd1VtKzlVa1QraGVxbTM4VDg4Ny9kTTB4NkVvMitkWVcwL3Iya0JXVWhR?=
 =?utf-8?B?cnVmR2IyWFNTcGdaUWNiVXlhWHhXTTNRcnIzUEFmQUZ6U3QxeVp6NGtPSm5L?=
 =?utf-8?B?QXhVUDhoTVRJeWNtWXlPd21Oa1ZheEsvWVZTY3ZpOEUrSmNBM0FuTnJsencz?=
 =?utf-8?B?TStIK3BEL2RWVVRnR0dOaklUVXMvdUh1dndpbGorOWpsN0Q1bks5VHd1RUdr?=
 =?utf-8?B?L3IrUHMybk5rUy90eGViQU80RTYwUWJ0bVdOZ3lWM1lBNHNCNjNyOGdIRFRC?=
 =?utf-8?B?K2tJbXpIWmY2dlBiWDdRa0JaU3BZUnRtN2ZzZm96U0NEbkt3USs1TXJvTzBv?=
 =?utf-8?B?MXhSb3Joa29MUTVkWk9DVDl6UTNJTzVDR1kzdm9JMGlYSXN0Zm5Ca0dhSGgv?=
 =?utf-8?B?aURuTy9xTlNiQWdCME1qMHdBTS8rNEp4RDIxMWdOTlJxM0FuYkI5MzE3bTAx?=
 =?utf-8?B?cXVnQUNYdEN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 03:53:53.8162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2e4041-6337-4a70-347d-08dd62abd6c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

Hello Aaron,

On 3/13/2025 12:51 PM, Aaron Lu wrote:

[..snip..]

> ---
>   kernel/sched/fair.c | 132 +++++++++++++++-----------------------------
>   1 file changed, 45 insertions(+), 87 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ab403ff7d53c8..4a95fe3785e43 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5366,18 +5366,17 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct
> sched_entity *se, int flags)
> 
>   	if (cfs_rq->nr_queued == 1) {
>   		check_enqueue_throttle(cfs_rq);
> -		if (!throttled_hierarchy(cfs_rq)) {
> -			list_add_leaf_cfs_rq(cfs_rq);
> -		} else {
> +		list_add_leaf_cfs_rq(cfs_rq);
>   #ifdef CONFIG_CFS_BANDWIDTH
> +		if (throttled_hierarchy(cfs_rq)) {
>   			struct rq *rq = rq_of(cfs_rq);
> 
>   			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
>   				cfs_rq->throttled_clock = rq_clock(rq);
>   			if (!cfs_rq->throttled_clock_self)
>   				cfs_rq->throttled_clock_self = rq_clock(rq);

These bits probabaly need revisiting. From what I understand, these
stats were maintained to know when a task was woken up on a
throttled hierarchy which was not connected to the parent essentially
tracking the amount of time runnable tasks were waiting on the
cfs_rq before an unthrottle event allowed them to be picked.

With per-task throttle, these semantics no longer apply since a woken
task will run and dequeue itself when exiting to userspace.

Josh do you have any thoughts on this?

> -#endif
>   		}
> +#endif
>   	}
>   }
> 
> @@ -5525,8 +5524,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct
> sched_entity *se, int flags)
>   	if (flags & DEQUEUE_DELAYED)
>   		finish_delayed_dequeue_entity(se);
> 
> -	if (cfs_rq->nr_queued == 0)
> +	if (cfs_rq->nr_queued == 0) {
>   		update_idle_cfs_rq_clock_pelt(cfs_rq);
> +		if (throttled_hierarchy(cfs_rq))
> +			list_del_leaf_cfs_rq(cfs_rq);
> +	}
> 
>   	return true;
>   }
> @@ -5832,6 +5834,11 @@ static inline int throttled_lb_pair(struct
> task_group *tg,
>   	       throttled_hierarchy(dest_cfs_rq);
>   }
> 
> +static inline bool task_is_throttled(struct task_struct *p)
> +{
> +	return !list_empty(&p->throttle_node);
> +}
> +
>   static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags);
>   static void throttle_cfs_rq_work(struct callback_head *work)
>   {
> @@ -5885,32 +5892,45 @@ void init_cfs_throttle_work(struct task_struct *p)
>   	INIT_LIST_HEAD(&p->throttle_node);
>   }
> 
> +static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags);
>   static int tg_unthrottle_up(struct task_group *tg, void *data)
>   {
>   	struct rq *rq = data;
>   	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +	struct task_struct *p, *tmp;
> 
>   	cfs_rq->throttle_count--;
> -	if (!cfs_rq->throttle_count) {
> -		cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> -					     cfs_rq->throttled_clock_pelt;
> +	if (cfs_rq->throttle_count)
> +		return 0;
> 
> -		/* Add cfs_rq with load or one or more already running entities to
> the list */
> -		if (!cfs_rq_is_decayed(cfs_rq))
> -			list_add_leaf_cfs_rq(cfs_rq);
> +	cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> +		cfs_rq->throttled_clock_pelt;
> 
> -		if (cfs_rq->throttled_clock_self) {
> -			u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
> +	if (cfs_rq->throttled_clock_self) {
> +		u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
> 
> -			cfs_rq->throttled_clock_self = 0;
> +		cfs_rq->throttled_clock_self = 0;
> 
> -			if (SCHED_WARN_ON((s64)delta < 0))
> -				delta = 0;
> +		if (SCHED_WARN_ON((s64)delta < 0))
> +			delta = 0;
> 
> -			cfs_rq->throttled_clock_self_time += delta;
> -		}
> +		cfs_rq->throttled_clock_self_time += delta;
>   	}
> 
> +	/* Re-enqueue the tasks that have been throttled at this level. */
> +	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list,
> throttle_node) {
> +		list_del_init(&p->throttle_node);
> +		/*
> +		 * FIXME: p may not be allowed to run on this rq anymore
> +		 * due to affinity change while p is throttled.
> +		 */

Using dequeue_task_fair() for throttle should ensure that the core now
sees task_on_rq_queued() which should make it go throgh a full dequeue
cycle which will remove the task from the "throttled_limbo_list" and
the enqueue should put it back on the correct runqueue.

Is the above comment inaccurate with your changes or did I miss
something?

> +		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
> +	}
> +
> +	/* Add cfs_rq with load or one or more already running entities to the list */
> +	if (!cfs_rq_is_decayed(cfs_rq))
> +		list_add_leaf_cfs_rq(cfs_rq);
> +
>   	return 0;
>   }
> 
> @@ -5947,12 +5967,16 @@ static int tg_throttle_down(struct task_group
> *tg, void *data)
> 
>   	/* group is entering throttled state, stop time */
>   	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> -	list_del_leaf_cfs_rq(cfs_rq);
> 
>   	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>   	if (cfs_rq->nr_queued)
>   		cfs_rq->throttled_clock_self = rq_clock(rq);
> 
> +	if (!cfs_rq->nr_queued) {
> +		list_del_leaf_cfs_rq(cfs_rq);
> +		return 0;
> +	}
> +

This bit can perhaps go in Patch 2?

>   	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
>   	/*
>   	 * rq_lock is held, current is (obviously) executing this in kernelspace.
> @@ -6031,11 +6055,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>   {
>   	struct rq *rq = rq_of(cfs_rq);
>   	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
> -	struct sched_entity *se;
> -	long queued_delta, runnable_delta, idle_delta;
> -	long rq_h_nr_queued = rq->cfs.h_nr_queued;
> -
> -	se = cfs_rq->tg->se[cpu_of(rq)];
> +	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
> 
>   	cfs_rq->throttled = 0;
> 

[..snip..]

-- 
Thanks and Regards,
Prateek



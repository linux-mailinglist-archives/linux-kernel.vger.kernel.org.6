Return-Path: <linux-kernel+bounces-515229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5F7A3620D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDEF3B29BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2105126738E;
	Fri, 14 Feb 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nO3W9CDO"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70554266F05
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547787; cv=fail; b=JhzHoRAwkv8YYkCM9nmvuXsfKUOX8RS8Iygr/E1wYP7Z1Y5U9rRhpbJ2NrSpmiMYeOoxSbnq11WqXH9J+GR+0Tva2kF8vmHm0IC/vPcS8ZqtLSlDsQ3v5WN9hsVqcy21cIVPZzPy4G7awJZ3elAGsX9f98kP7HCt3rR7BfpueHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547787; c=relaxed/simple;
	bh=BuyVj78XzZCgw4ldIxDWukJF5PCUwUHZ/xONZn05XqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kSeUi3aXO1bozBFrZg4UNFjZpZ67Ae0xJ3b42BHXOOUShQkclzwGPL6LEfLPcfr19Q9pD465aiTebZkRzPVZWdpcB7BKn86/J4zr0MKP7AFPsAjryJ3jc8pBaEe4Ca7/TFH3HL8JO9EPt7UogdCgbAC5WJQ3IV6jn/vtBa9kBs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nO3W9CDO; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNbXglPzEXCtLfAbMikLTUy/2Z3aELKgeQLvhkXCx1ZFezZbXgxiR7JvibKvrgEB1oe6/I/abqBHU7j8fLmHBq/9ebm7ACoLhLig0Xznbj6/+ohrDnAeGbPdkU4xnNJBSq7vkQs4xAearezzwT0ecgN2x8TkoR/rUOf2d9tin8d+V9G7ufWIee0bgWCV6XrTX2QMgSA0iZLCuQZC1MAhvwCaWTvfyoAPGjL34Eco9hsslqqExRyIVWDxNI4xZYG/N5PX/hzX23ITrF1WAC2zwa90XSejtkR7lln46f1fA48AjZV/NsGicUSRTQQ6c/Fo+F+quwm5TkHM49FFTrQE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCzWo4/WUdSmFkb2SS1qUdzZbtzfzN8UrZM3dQNV+wM=;
 b=chbkgLSfWiQYLTIZs0cUINB7m7RktPVOWCFtqw6QL9NkOYcAbz5rB/T1jiq66Q9k1G4wfl/C+sz5FrDtjt7UEaC/tnDu+LH8Uft9TK3fQ9oWi3N11RxP/dnCc1ZekCw7uAyWex1XV8lDgNEVI3np8kJRbn1H16VWxgoZRzPXIzETEfkURzfRKWgnPaVDgWBarjvZRmL9RdI2fxtGXQxa2B4sfFVOXEGCQL5xy+L2WOjOoDlh73j9k1FyoHrxVDuZTPEJGqjb06J0rQi9yA06H3ZgHeVOIumtoi4PNh0UmGvzjKqBFULPs1VTrRZue9I7XfJhIoFVMG52kJ4PvbvhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCzWo4/WUdSmFkb2SS1qUdzZbtzfzN8UrZM3dQNV+wM=;
 b=nO3W9CDO8jjPrQdAyUE6Z7RKzRXt6fRni3Zx667P9R/BJvQnT+03f0HF83Br8A/uOpjA7JliJasiq0jh9iOAHF8LYRmBUM8bMTqr3D3TfBmA0+asTAItkN9nB2Elt7YZvzJyq0BrvNYbvnqkvHymhnbGNs0s9U1acR8fiCIZY/o=
Received: from DM6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:5:1b3::36)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 15:43:01 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::ed) by DM6PR17CA0023.outlook.office365.com
 (2603:10b6:5:1b3::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Fri,
 14 Feb 2025 15:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:43:00 +0000
Received: from [10.143.196.137] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:42:56 -0600
Message-ID: <610e209d-5c12-44d5-898c-f18dffbc2062@amd.com>
Date: Fri, 14 Feb 2025 21:12:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/eevdf: Force propagating min_slice of cfs_rq
 when {en,de}queue tasks
To: Tianchen Ding <dtcccc@linux.alibaba.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250211063659.7180-1-dtcccc@linux.alibaba.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250211063659.7180-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc59327-162e-4b0c-6f50-08dd4d0e4359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZytVMUhBUHZ1UXI2d1dLVWNubjlVc0owRkxCMWxpMUx2WTd5eVMvU3RjZWRv?=
 =?utf-8?B?U0dVKzRrU3F0Rkk5MDdjWFA2aU44SnJKVWhmQlRvRE1qMDNrekpLa1VTbzMv?=
 =?utf-8?B?UkRyRGFPbldyV1FyOEVEV2NWbTJlTENzZDI2aEhGOWRwVkxKbWl4ZkRyUVM4?=
 =?utf-8?B?RnVCVUVVcWNCKzUwN3kvclYvbmJXdnFza084OG10SWtjZ29oTE1TZ3EySzRJ?=
 =?utf-8?B?N1B6S0VvSmJuT3BxeERLaE1zVm1XQ0VBWFRaanZDSUdURDhwRU1PV2k0NGVN?=
 =?utf-8?B?UEtaZ3hXcU5ScEZuV2RVUUROQXdBa0NpQ09KVWhtem9ZbnF3Y2REUXVxSG5k?=
 =?utf-8?B?blVwcEc4NmNpaSt0dGR3UGppZ1J3NGtLOW1RendsVUhFYTdTOGtmNnd3ajFx?=
 =?utf-8?B?eXk5c0w2WVJ4QjF2ZzI2Mm4vQ2VJZ2s5Yk16WnNSKzR2Q3ZKZkppRHFTYTB2?=
 =?utf-8?B?dmZPS09DMk1qaWJOYjRxeHFVbzJVYm01SVgzYy9rbUhlQzRESXRRNnF6bVFZ?=
 =?utf-8?B?SVVRd1d2SFArbzFOaTg5VENuTkoyT3dGRFpjcXRVYUNtWDVVUU13dnFxcG5O?=
 =?utf-8?B?UTFscWRvTFA4elh0dHN4ZHVLaGk1TXpQS2s4anpmTm9aVm4xRE9vVnAvL0pV?=
 =?utf-8?B?QW1hR1JlTlZ5bnpwV1lKODk1WFltZ2JhQmZIRUlFbWdkTUFuL3BLZGQvNHdW?=
 =?utf-8?B?S0lETkdleDBlcTFVK3oxTWJsOTYySU50dkZLb24rOXVEaGtVYkp1Syt5bGps?=
 =?utf-8?B?amFtQ3g4OFBSNS9hSlgxMVlxblpLRUFOTnJ4UkI4eG9RNXQ4VTN4ZVFiY3hy?=
 =?utf-8?B?L0ZIQUR6YkljaDZPYTdNTVJhMWlyK2xNVXVGZUZyZGlZQ05aQUp0UWNYOE1O?=
 =?utf-8?B?QUxpQ29EQURmRnM3U28zS2sxZ2VvZkNLSy9aT2xjZU1FWTRwdlBET2gwNjJo?=
 =?utf-8?B?TEpXWWtZWkhJb2V2V2hoOEtsdms3R1JYRlkrQzBFYzFDUW9EMW0xTk1xSjlK?=
 =?utf-8?B?aUlZR21EK25UWDRJU05obGdEYmIxTjhXTlJlWUd1MTdJcXU3QnR0MHlzcVRw?=
 =?utf-8?B?WVJ1dUN2VHRKdXpzWkV5aVRLU0xkSXpqRDhDRXlmNk4wSFBlSWZvVThUZzNa?=
 =?utf-8?B?QW14SytucUZZM09ieFE3cTZicVhocHZqOUZNWnF3c3B3cFM5UUo5enRhVWJx?=
 =?utf-8?B?NXlUeGhKWUxDcFlGQ3Z0a0xLTUx5N3E5NWVFeVRRREJ1Z2hObktTR0djZnVI?=
 =?utf-8?B?eVlYYlJrZUdUQU0vY0hKRjJCZjk5SFhaaEN1VEx0enIvREJ3Y3BCRGxSTjBp?=
 =?utf-8?B?Y2NneTNhYUllTUJ1UXBqeERWVTJHMnhXWW5LSUFxRGExUXU0VXhaYmRvK0U2?=
 =?utf-8?B?OUlrRWtsOWYrTEc3T21KUGxIV3QxZC9VbGh5dzlKNGVsSEFOMDUzcFpFQlRh?=
 =?utf-8?B?UFdNa2d1dkNMbGdvU1VlVW42RWJYYUdZdVJndmRDWlB2Q0pyNVh2WG8zWU5k?=
 =?utf-8?B?SFJOWTNHaytVV0R5cXhYWTN6dENTdFNqdjNSRVZKblNMc0tqTlhMdVpwUE1M?=
 =?utf-8?B?dEE1RlFMUUgyVUlxM20xNEhLaDFiRVVxa0lxVytVb2wvaVhhemdZODJnZHQ5?=
 =?utf-8?B?UWlGWnArcC9Pb1pVSGRMeW9ndURBN1VNYStvNGpXSkJSTVYvUkRXalc1RHdi?=
 =?utf-8?B?Y3preVFyU084QmtQWURSVU83aFp2VlNlSUUrTXh4aXdGUnZFWnY1QitMNUE3?=
 =?utf-8?B?eEZHUS90U3MwSmNDUWFGUjNxREhkSXRISkJlT2xDL0pNSDVSbXpuRnNyeXFn?=
 =?utf-8?B?Ym4xUHZaa09IZW1idjRMa0RRTGIwUHRQUnJVT0JiczZxME9jeFhkcXovaWdy?=
 =?utf-8?B?YWt5cE4rMXh3d1M0clpnQjV0eDQrc25DYjZQOUViMG1QUGkwR2VIT2lEVmcy?=
 =?utf-8?B?MWw1elFxT0FyNXdOQnQ0c251ZUs0TGd5bWR5VTQ4eVB2cFlhdDRxR2YzTHc0?=
 =?utf-8?Q?lc93XzjGIQfBKAwLNMfuGG2pWPZpf8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:43:00.9731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc59327-162e-4b0c-6f50-08dd4d0e4359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

Hello Tianchen,

On 2/11/2025 12:06 PM, Tianchen Ding wrote:
> When a task is enqueued and its parent cgroup se is already on_rq, this
> parent cgroup se will not be enqueued again, and hence the root->min_slice
> leaves unchanged. The same issue happens when a task is dequeued and its
> parent cgroup se has other runnable entities, and the parent cgroup se
> will not be dequeued.
> 
> Force propagating min_slice when se doesn't need to be enqueued or
> dequeued. Ensure the se hierarchy always get the latest min_slice.
> 
> Fixes: aef6987d8954 ("sched/eevdf: Propagate min_slice up the cgroup hierarchy")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
> v3:
> I modified some descriptions in commit log, and rebased to the latest
> tip branch. The old version of patch can be found in [1].
> 
> The original patchset wants to add a feature. As the 2nd patch may be
> hard to be accepted, I think at least the bugfix should be applied.
> 
> The issue about this patch was described detailly in [2].
> 
> [1]https://lore.kernel.org/all/20241031094822.30531-1-dtcccc@linux.alibaba.com/
> [2]https://lore.kernel.org/all/a903d0dc-1d88-4ae7-ac81-3eed0445654d@linux.alibaba.com/
> ---
>   kernel/sched/fair.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1e78caa21436..0d479b92633a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6970,6 +6970,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   		update_cfs_group(se);
>   
>   		se->slice = slice;
> +		if (se != cfs_rq->curr)
> +			min_vruntime_cb_propagate(&se->run_node, NULL);

Should we check if old slice matches with the new slice before
propagation to avoid any unnecessary propagate call? Something like:

		if (se->slice != slice) {
			se->slice = slice;
			if (se != cfs_rq->curr)
				min_vruntime_cb_propagate(&se->run_node, NULL);
		}

Thoughts?

Other than that, the fix looks good. Feel free to add:

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

>   		slice = cfs_rq_min_slice(cfs_rq);
>   
>   		cfs_rq->h_nr_runnable += h_nr_runnable;
> @@ -7099,6 +7101,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>   		update_cfs_group(se);
>   
>   		se->slice = slice;
> +		if (se != cfs_rq->curr)
> +			min_vruntime_cb_propagate(&se->run_node, NULL);
>   		slice = cfs_rq_min_slice(cfs_rq);
>   
>   		cfs_rq->h_nr_runnable -= h_nr_runnable;




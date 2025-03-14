Return-Path: <linux-kernel+bounces-560679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6ABA6080A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DC77ABC74
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BAD84D08;
	Fri, 14 Mar 2025 04:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oh+1lfyw"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE12AEE1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741925920; cv=fail; b=MZIYUaThHx5mmcO5k83oOwihZbBOsEEKQHsVQR0vQpa6yU5J/7ma1DPZd9Pc6U3/fhd+41n70xQqxW1IBNhoHK1JbiCwVIPKM7pU0ChXeR2dhdYOrTN1+zDE47fNtadtkatzN7jtJ+EjC0QSSQriRLsmxcWHN83KCQR4iP9nTMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741925920; c=relaxed/simple;
	bh=fSL3YgR1Nrl7wLxrGEGZR+vkwfSBUgfd3xXkxnRg6cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XYUjdHGREPECHWpMOACEI73hn+SmSM6JLfGpPC0RwaAFTZarPBawUpFFVlqfREvJi3E/bwpYZilQRDhzEfrhAw0VRV9CAm1d6LteKxLzuUz92zLX546Tfyzd46mndF5q+fM/t+RylL4oO/tX3MBuHQXAzj3zwoJrgo6D8Y7R/Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oh+1lfyw; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn8gOge5v0oz8dyzbr5yUjEADdI/rHT/AfPq5e65/mOOMcFkuAOTtAUnI/4u2TM3XeMEUL7/L9xyr14jAuJkKktrYa44yJf0Pr06E5AmMTktdLaiQwP2AOYg+JCwzEVlzj3gimKyW/z5nnzH1JMWW0ZaN/4BMOCBZaXiWfyYHPOxabNtVx7T7RZk39Cg61J36u8SuAjVjfDOHjt631bU68OFCqkH2esO0tX6apAVcuQIAsOdsHLBOkw2RWL9gsG3ejUcsIUgMKzB7OleCG//5FLXzBfEbBFDSIMVxLpZoSNxbtPhlAOUTYmK/B4Bzq4B9fsJ7PPzrn3Covs8Ni54Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJHuBwEG8opC2Te8iJgwGupSaSZuq/PUfX1YVC+jCD0=;
 b=pHUt0Ej07rEeZXk5C+7e1XQu+6E7iwh8KFQH2+sARLJHS6emQ4AVoAbQh+jH0ZMLrUHxZYT5XUANPum8RYl8K4Qg+3VaAugpW/N7rbzjMIzAFPuG65bqIcWRVzmcPyMFGC6irkl0QQVjfh5f8YeTi5tOorahSfsptkl6Ay/a0hNGzwBHCuDTABSpI4+F6Ln9rvvkxrrzHEwnph2sKmvIMQA5euOMBZkZGbm14hM5dheJ6mylMlWyRYSCL6O93EuhOeKzyphmP10go3u9/sE8BsPQ6rVSnB2oQMsblUnA/CmZKzFAQmJ7sp000xn8s7IztKZVScBV6GStflleK1AT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJHuBwEG8opC2Te8iJgwGupSaSZuq/PUfX1YVC+jCD0=;
 b=oh+1lfywUseXKnv2XjR0ife9nGzqsseHY0xQWw+QObB0SeoKCoOzgGOpgJwA1+bBfOGOYKI/AWXyNy59nbYMvb58RVSJldc2Ta/4IMsRhjM3AijI/fJdiwTfJHdzqevukAyYIaLmToVJbhxkGjS6y5HHCc6M2LxbTqmYV1mev14=
Received: from BL0PR02CA0119.namprd02.prod.outlook.com (2603:10b6:208:35::24)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 04:18:35 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::94) by BL0PR02CA0119.outlook.office365.com
 (2603:10b6:208:35::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 04:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 04:18:34 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 23:18:03 -0500
Message-ID: <947ab5ab-3fbe-4a5c-bff5-6c257c7c5ba1@amd.com>
Date: Fri, 14 Mar 2025 09:48:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] sched/fair: Make sure cfs_rq has enough
 runtime_remaining on unthrottle path
To: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chengming Zhou
	<chengming.zhou@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0Gf2ZbnffwNVoBSu_+y4sq0MoMYPwwgsnfg53Pf2enwJZw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANCG0Gf2ZbnffwNVoBSu_+y4sq0MoMYPwwgsnfg53Pf2enwJZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: f83f6af7-4853-4cbc-588f-08dd62af4960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWtlYTdxakxOWnNnaFJ0d0R1Sk1GakRWKzFvaDg4UlVDNG5PUjI0ZlV5bS9B?=
 =?utf-8?B?V2piSCtyZGxnQ2FNWUhuREUwVC9VMlB4anRDNG9MRmpaODZ6ZS9XbFdrc2x4?=
 =?utf-8?B?OU8yOHVSdXpMTm9wMTNkUGIwMHg2ZzIwZCtEdFBxVXoyalZtQlNUMC9RTTgw?=
 =?utf-8?B?K0ZSMzN2QVRSeWV1UTdRM3B5eWdBNUthclJycjNJeTMvOXY1TWQyOEFCK21S?=
 =?utf-8?B?Rzg0ZEdKb3pkWmUwQXFlLzZDUUdSZjBZQVNjMGZYSGJqT1dLMW9DUDBzbnFt?=
 =?utf-8?B?QWJTakhhL3pId0pkTURJQUlJcUM0Wjhpdk9WUkJsWXAyUENKSzVoczg0NGpj?=
 =?utf-8?B?SW1qL3ExMDhpYmZoa3ozMDRYZG5jRnpvN2I2NkFTSlhTOW14NEdYcWlUU0Fn?=
 =?utf-8?B?MUE3L2Nmd1dodjB1VVpGL2MrRU1mNlhBOERhZ3ZKdWp1azdaWnZZQk9jSHJj?=
 =?utf-8?B?aUtjZG0xR0NPQ05MZCtLeWVGZTd2NWRaYlNjUW5KUWdpaDR0b1dDL05IUGg3?=
 =?utf-8?B?Wkk0dTNaN3o5aTNVVS9mbDBSWkNwOGlOZk14cTFrTWpCd1BiMHdKT3JJZ1Fq?=
 =?utf-8?B?UHVvRjg1bU5SWVY2citvSmZKT3ZUNmpqRTlLOEVsd3VGTmZJbDV2Qm1Da2h3?=
 =?utf-8?B?cm9uM3Q4ODhsR3NER09HUzY5WFVteEd4ajZLVGxXYlk4ZkN4cERoUGNJYVlx?=
 =?utf-8?B?L292L1Zqbm51ODc0a1FiYnc2R3JaVkZTSVVoajBSM252bWFUUFpoQk9oeklH?=
 =?utf-8?B?b29wZDQ0OFE2ZEhRSWJMQ1hCSDRCdFAzSFBvT0Y1YU9ZdDBreVlDYmdJeVhD?=
 =?utf-8?B?OE9vaFh0emhuNEl0ZGhhRUo2ZFJqOG13ZnQyNWdYcG8rcm1xcDlDWElLRmFt?=
 =?utf-8?B?UjFEdmpuUHBIQ1RpM1Q3dTBHNGJpWk1vR0JaVnRMaTNjTkxyODhXY2lTOGt6?=
 =?utf-8?B?Y3F1WXF4dTBqaWRCOEUzL1d3MGxjYzRKQnVTVmlEZVV5aG9BS1NoVlVKMjFC?=
 =?utf-8?B?S2JLRUtEVVMwTmNocm4xSzZuVTZST29WSlNtNlZHOWNHV0VOOFFmd01CUXov?=
 =?utf-8?B?a0UycmVBdTZVelVrR2I1NDdKT1VzZ2R0TDNONHlBbDN1VTcwUmU1R3hVRnFF?=
 =?utf-8?B?bmlWcXI4aHdNaDJLOHdNSm5FdHhrYUJKblR0TGE0U09lQitGZS9xUElLUGxm?=
 =?utf-8?B?NDNSWFhjNlk4czNJblJQbnFsNWVjamNRUGJ5b1EvalduQXZvSlRBaDdiT0dN?=
 =?utf-8?B?L2lISGc5SzdRUmd2V3hiYXVYTk9TeFd0QjNseTZSNXA1dUxBNktDeGFCT2Mv?=
 =?utf-8?B?Sm8vMkZpdTNKc09kcnBVdW9hMWJzUlppRzMwMFgrL2F6V0pWT0xXSzl4QXZ2?=
 =?utf-8?B?OVRRTWc2ZWdiK2dSMnA5RVVZRjFscC9wcDNGa1ZkbFdPV00wRk1zM3h3NVlU?=
 =?utf-8?B?T21jYkxiZlFPTWIzaFRFOU1jeW9xQ01ncUpScE5zMUhsT0VTbmJRelM0MGcw?=
 =?utf-8?B?Q0Q1L29Xd25lT3JkdDVUeTgxMUdKUTdqeENLQ0w1dXRzdFZWeTBYYUhjVzlE?=
 =?utf-8?B?UHlCcUxrbzZjV1FZajdEUmczRzJWVmZaRERBZkl4S0IzSVpOVDZKSkRWbU0v?=
 =?utf-8?B?Y0F1R1FZY3FJTlBCclFWZjk3MW12VkhJUk5IQ24rbnpLUlJqNUNqMllWakdJ?=
 =?utf-8?B?b2piUlgzVTk2KzlRb1JEY210anF2dTRxRGV2WGtuL1pZcmRLTnJ1enpkeWkz?=
 =?utf-8?B?VGRpdWpOWkY0YjdFY3VZS0xjZjBFVFdkazVQVkRHeUhxZEhLTHlNeFg1NXkz?=
 =?utf-8?B?ZC9jVUZjNFhuU2p3SDRvbCtTS0pFR2RwU0l4eWdIQTI0cU9QL1hEa0huTUZB?=
 =?utf-8?B?RzFPcXdlYmVEYkwvWlk4K25aRDJSbmZRWU0yaGhBemxkZ0NHdUE1UHRueVBr?=
 =?utf-8?B?ZjZPR09OWUZVWXdBVzVMRFZGWEcxQUNSa1BVblpCWlpHMVhTREJMMnVTSUlL?=
 =?utf-8?Q?mupquPi8vZuXEeiuLvWYi2UveEAoNU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:18:34.6015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83f6af7-4853-4cbc-588f-08dd62af4960
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853

Hello Aaron,

On 3/13/2025 12:52 PM, Aaron Lu wrote:
> It's possible unthrottle_cfs_rq() is called with !runtime_remaining
> due to things like user changed quota setting(see tg_set_cfs_bandwidth())
> or async unthrottled us with a positive runtime_remaining but other still
> running entities consumed those runtime before we reach there.
> 
> Anyway, we can't unthrottle this cfs_rq without any runtime remaining
> because task enqueue during unthrottle can immediately trigger a throttle
> by check_enqueue_throttle(), which should never happen.
> 
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> ---
>   kernel/sched/fair.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index be96f7d32998c..d646451d617c1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6058,6 +6058,19 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>   	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
>   	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
> 
> +	/*
> +	 * It's possible we are called with !runtime_remaining due to things
> +	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
> +	 * unthrottled us with a positive runtime_remaining but other still
> +	 * running entities consumed those runtime before we reach here.
> +	 *
> +	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
> +	 * because any enqueue below will immediately trigger a throttle, which
> +	 * is not supposed to happen on unthrottle path.
> +	 */
> +	if (cfs_rq->runtime_enabled && !cfs_rq->runtime_remaining)

Should this be "cfs_rq->runtime_remaining <= 0" since slack could have
built up by that time we come here?

> +		return;
> +
>   	cfs_rq->throttled = 0;
> 
>   	update_rq_clock(rq);

-- 
Thanks and Regards,
Prateek



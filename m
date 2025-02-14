Return-Path: <linux-kernel+bounces-514326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F6A35593
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8858E1695C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787FC154C08;
	Fri, 14 Feb 2025 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3X3wxksr"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3492753E4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506081; cv=fail; b=t08S0ujXVl8a0RBpZskcXPO1t0b47hkspHyzEl+fW6QmFwFookKVXqdW75gjm0gFciS6koAtd7GjrGErz+DerNi0j5FsTg2d3yRN0QsLZubQIrWL2zk7zpRL4HsLnl0EveHPz4CeLw5zr7nWvCJnfunQYypYeMwpl9Z2v6t77Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506081; c=relaxed/simple;
	bh=qqhBemiu1mBbpSK5F6V0dpRLe8Bbp8W2k4BIbnxDkX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LGwvP+uuBV8W6PGZBqhxGApy3mTQ5b9oF1clrt5KobJ7hYk0OiWpS/kLa8OyLdn47TP7a7CrRLSZ/PGgTK87hAYZrZgjsPtszwJApU5LwegFN8MH2edLeGtz1Oz/rWdi+qLL8f+pSl9POgC9VCoC+WMkS67UGR6rCPxiZIYgz2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3X3wxksr; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqsN4KJ8XbEZ6RnHlFEV4BT/PZllm2azyzLh1evaXGcX/UwACrzHbcXC4LSAhCU0FpKJZg7R4mq7aw8jSS3Lz/ov1Me2NZKY8J8baRqWOrLrVPo3r6Jq4HOi1kaI+KR6JgLG0uw7Eix5Iildu0zTJTR9FPzZqNa92eYLMNKfjJMmQQKL5KgM2CLuZcxZ8Ejw/L/t+xcTAWD3/vJ8khIWy3QDNISQVtAhjooQ1+8C70lwypyu5rifwVkQvsjiIqzHvOVZh/nWYVz5jIB7tHxFr0mpc7dzF6y7o9VTXrh57p6AncpUP3MSsRHqVpgaWLcCRyqLUj+q0fNUu5VZqsFJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7j5WpBZgFMwCY1XUEVOdis9DPJSDXUs4W+VARcgpr0=;
 b=y/odT9BBdhdqUtaxGjsQid1h309fFGxuG/BmhVgoKOTW0yDWYAnFM6nQENZj2kBmHd9Txh6NO2lLoG3QpoQpjIIF//5zkP6Bn4ALuC5POoyyaImhMAI+gF+DfuHrFosj3jYA/Vg674+1ITMe6diFsz7+r1OPvf8lUFriIrneH+xUxqH+56yHOC0LmiQsh2d7CLKUnhrS+dpvxUtwt5tgREKUHNL+UfT/n3zy7FsyYzJKEfSRhtRJ5GbyQQTwOJBAAWu/9THbqQagkGlS2fEG3WOTtIqzXHuShW/+aX+XEatmKmbbzCIFBUQcxofSiKrXOQBg5lxk8BtBnFrGgTxjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7j5WpBZgFMwCY1XUEVOdis9DPJSDXUs4W+VARcgpr0=;
 b=3X3wxksrPOSi/IFYyaO8R1toinXMkISxgCkRQCSIG/wh59q6s/bYl7xMavYZf2PVnuaO6ryVtjMFTPjR2hY0t9WU++8xCrDYJyqjRVN72tYqv3I9spxOVhIq3AdWaQyq0EQuumBInMyk7GBXhsovird5pWWHtWw+YSTsl6Yo1P4=
Received: from BN8PR04CA0007.namprd04.prod.outlook.com (2603:10b6:408:70::20)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Fri, 14 Feb
 2025 04:07:57 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::93) by BN8PR04CA0007.outlook.office365.com
 (2603:10b6:408:70::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 04:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 04:07:56 +0000
Received: from [10.136.34.113] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 22:07:53 -0600
Message-ID: <f35dbe78-1165-42ae-80fa-3465fec100ee@amd.com>
Date: Fri, 14 Feb 2025 09:37:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: fix potential use-after-free with cfs bandwidth
To: Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250210195117.1074569-1-joshdon@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250210195117.1074569-1-joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fb8b87-f39b-4da0-579c-08dd4cad29bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGg5aDN5TVhxamRONTNDL2JQTnVWUHRJa2lnQ1lSREdGVnFHYmQ3UnF1SXMr?=
 =?utf-8?B?OXN1dks0Y0cyamRpNlNCM05RdXRGNjB1cVpwMjgwc1lXU252MXVPVjNmNzJp?=
 =?utf-8?B?U3FzK3NnOGo3elB0MDlMREV4SnZSWkJhVWRsOEhuQmY0dVFPMGlGZkQzRUdW?=
 =?utf-8?B?OFhPYXhRcHorWnpGU083L1JKbVFnbkttUWFnVDdoK2JONGtYRDVVYWZJQVI4?=
 =?utf-8?B?ODBBeVNja25SYkswYjhyNC9vM04wakRFUmxIVUhyNDBLMzlWS2szMjU1Sk9V?=
 =?utf-8?B?RktjWEtmbjdzYUZZS3ZyM0Q0V1p2TU9ZRXdqV3gzcW8yTExMRWYyOVVwZWxD?=
 =?utf-8?B?bGJpdjJycjc0QmZkN2crVlNyeDYzS3U5Y0ErR0d5M3hpdDBjUnBxV1E1Vm0z?=
 =?utf-8?B?VXQxR0hUbE9vWkZqdFc1RDFHWEdNWjNIaGhqTVhsOGtyVmhsN3FSS2lRK3dT?=
 =?utf-8?B?SXFsTllRa2p5WnhLVndnVnU3WDZtcmwrQXZiZURIZ0xpVzBySHdDNStvTXhF?=
 =?utf-8?B?dHF6SllNU285dDZhdXFwSDd2YlN6T3I0ckdlNnB5NzIxcWhrWE1YMTd3UktQ?=
 =?utf-8?B?UlMvc21sdjFjSWZGZklDOC9ZU2owbGh5VU5BOHhCTEpvTjY4TE5vWUhmOFp6?=
 =?utf-8?B?aVgyTURUWVlqcUNlZy9CNlZZWjZwWWt4Z0YrNS9qdHN4aFZwREVXWElwZElp?=
 =?utf-8?B?WDFrRW52MXBVS0kzcmdXclBvSTU0UUhPYnNreko3RXhuVlJVWFhjVG9PeHM0?=
 =?utf-8?B?WlF2eVE0WmlXaU0xcDY0dVpIL2N6UmdaK1ZHbUVMN0ZQL2JwYXhPVmsxU1JB?=
 =?utf-8?B?eEFKaTZhUTIvdDJiWDZESnpmN0NkUFJHQlM3QitGbEF2N2JHNklEQ0VWN3Y4?=
 =?utf-8?B?dVEzc1VZc2pwVWF2MWFXVkt4MlpNRTIwY1hVYWtqcC96eURJcFZpVXplWXEy?=
 =?utf-8?B?S1FGVWM5dzdzcUg0K09CT3JZVDZEcFFvSmdXekwxanBSU3REUkxGRTd0RURB?=
 =?utf-8?B?VlVaOTd0U3A1enFXOTI1T0RNTXR0Wm9VSWs5ZEdZck5EVW1NWjBPTEZEZ3dm?=
 =?utf-8?B?RndMc3pnR3ZZZWhhNmU0MFRVVk1BVHVQLzhMejRYdzNPdkd0MHl3Z3RhazFq?=
 =?utf-8?B?TVN0Tyt5TUltRzBMM0RiZzZlenBSanphTm05emp2cEVqT2E1dGQ3RTFrR2Fp?=
 =?utf-8?B?LysrVnVpenB2bjBLQ0tYcjhMQXR3bzVQY21lc2x2UUcrc2k1MDkwTG1GMTZk?=
 =?utf-8?B?Z29yKzQ4YzQxc28vaVlWYWFLbDI4ZHZiaTYzQ1VpaTRabHVtbnFhUzB1dGh5?=
 =?utf-8?B?dDRlOUY5bTdJWDJicFNFeHIvNHZ0VkhOMnM0Zm9LdEJYRUxhaHoybThRWFVE?=
 =?utf-8?B?SzJaL1EyaVBianBmVmpENmxXZlNNS3JhOHI2L3pXN21aMUVrOUpObTVxVDhH?=
 =?utf-8?B?UU9kVGxFdzBoNjY5U00zYm9HREorL2xjaE02b0xRV3RlNnJic3V0QUJ1S280?=
 =?utf-8?B?aHU0dnhVQTRiaEpQMHMwMG1ML1Q2QW9QZHJWYkJremNaRDd6cXllTUFXOHBR?=
 =?utf-8?B?NkttVm56ekxnbDhraDlzWWdZcFlGcGFVSW1aS1lrWHErMkNQSytMbzJYYkRs?=
 =?utf-8?B?bWNvNlNVbkl6VHhNR0pZOGtJT2VKdjIzQ0JJYkdkR0R1QnNxcmxCNFFJaGdm?=
 =?utf-8?B?cEUvT1ovSHZiVStNWXBDbjdXQTRpdnpVaWlZR2s2UHJZOWZQOXZIMzRzYkEv?=
 =?utf-8?B?OWwzajY2allhWUsycWNsRGxBYWRyY25YUHdDNW1jZ0gxN1lXbGFCN3hZWkV0?=
 =?utf-8?B?T080WFM0OXd3dFlwL3dRV2RNV3gxOUg1K0QyNzl0S1ZVZy9mdFI2eFVKVGhu?=
 =?utf-8?B?Zmd5QXhjdE9TdVJBYjVkdThrOVhwVm9DTVVmS0NhanlnYkNlYjJBZ2J1R3NG?=
 =?utf-8?B?NDhkQmpFeHRVZG91SkhmU2kvRGpNWDlxWUVicElzU2RBQWxlcTJiUnpIenlt?=
 =?utf-8?Q?m0+YPgWBs2IsyLXR/U7AZQXq26rwzU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 04:07:56.9312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fb8b87-f39b-4da0-579c-08dd4cad29bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

Hello Josh,

On 2/11/2025 1:21 AM, Josh Don wrote:
> We remove the cfs_rq throttled_csd_list entry *before* doing the
> unthrottle. The problem with that is that destroy_bandwidth() does a
> lockless scan of the system for any non-empty CSD lists. As a result,
> it is possible that destroy_bandwidth() returns while we still have a
> cfs_rq from the task group about to be unthrottled.
> 
> For full correctness, we should avoid removal from the list until after
> we're done unthrottling in __cfsb_csd_unthrottle().
> 
> For consistency, we make the same change to distribute_cfs_runtime(),
> even though this should already be safe due to destroy_bandwidth()
> cancelling the bandwidth hrtimers.
> 
> Signed-off-by: Josh Don <joshdon@google.com>

Other than a small nit: s/destroy_bandwidth/destroy_cfs_bandwidth/g
please feel free to add:

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
>   kernel/sched/fair.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 34fe6e9490c2..78f542ab03cf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5917,10 +5917,10 @@ static void __cfsb_csd_unthrottle(void *arg)
>   
>   	list_for_each_entry_safe(cursor, tmp, &rq->cfsb_csd_list,
>   				 throttled_csd_list) {
> -		list_del_init(&cursor->throttled_csd_list);
> -
>   		if (cfs_rq_throttled(cursor))
>   			unthrottle_cfs_rq(cursor);
> +
> +		list_del_init(&cursor->throttled_csd_list);
>   	}
>   
>   	rcu_read_unlock();
> @@ -6034,11 +6034,11 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>   
>   		rq_lock_irqsave(rq, &rf);
>   
> -		list_del_init(&cfs_rq->throttled_csd_list);
> -
>   		if (cfs_rq_throttled(cfs_rq))
>   			unthrottle_cfs_rq(cfs_rq);
>   
> +		list_del_init(&cfs_rq->throttled_csd_list);
> +
>   		rq_unlock_irqrestore(rq, &rf);
>   	}
>   	SCHED_WARN_ON(!list_empty(&local_unthrottle));


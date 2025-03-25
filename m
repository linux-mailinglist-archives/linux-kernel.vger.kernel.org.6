Return-Path: <linux-kernel+bounces-575811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061ADA70777
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2A33A860C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909E225E834;
	Tue, 25 Mar 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gJZ9TyZj"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED819EED3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921675; cv=fail; b=D0gII2Cx2WkSQWYRx9XiOaDqHwRY7NjIG1BWaHZHiZXazgZWFaDr/90hzYMYE49Q6JG1LUEkesHJoXgNUO7PgzYqPYnVPNPZevrcVM7eIX/51CRrvKaDuInvzOrGpsloS+s/X/D4xCqFoTqQILMHcKWc1WF2vjiKJ9d7CYFgHEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921675; c=relaxed/simple;
	bh=zc+fBoQmMjIug7AQqCYyTp978UdSAMCRvn4aHUdm0zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OiiuX5aBafGi+6TC2fywMWZas416cH24We842OR422uw+fNzJu3IOPSkOYpr+a7rgbCWBdwabNDI8ym6+BBxfN9eIXFiMbNLrTsExzqZQ4K7WGDIdEYZlxK42GuE0HzgHyHu2PW5X33SzJKR95LHLYUXCLax6Tv87z20CAMEjiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gJZ9TyZj; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyKP/0gQ03G/zKPTxFwskamod4FJN2kgajgAlnFvkL7iErST2ckAQNpiCkZQ1BC0BIH7ZBBPxE/baE84IYdSf9rkfaQAhLpSjK8eFldKFAxDSSRKH1aMwT/aJ/qHSuIQZ//RVXqTPGJ2LqhtUPUN2jUGI4gUZbY9Ebf+K8lkogrMMDThozV63C/25mWm2rvHb7SDvw8ihW3EF+tZFmD6MN98ieHtylS1HEvwd3+2ERbyUEfSraLHhcxRZjGHTW1w9s99llG/+oQRm2hBhresz8SUaqpYoBp3qL8wKPeE5BvOFMCYVl7HygecAlqK0cEqaFWTEsrPFc04XR9u6Oettg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9OsIMASwZMwxWg0dmAIAY0N/BxnkCKvL8vpBTUxVVk=;
 b=xM6DrpBlweWON39dduT+Mdb3L+ahlu6YfyHNPdyLGqSA4xJeJrdR1iTtft9WrdaD9QJrtRmS4QQdkStIpceXc1iS8qcmcuw6wiGximj8BJZfTiis6gkhBrDfpnaiEW0fy99n9rmons4gLVcxfdEQMIEvyx5Z1A27AXGul/rtsU457Uto86VqkhjaAmi0sSpn5aHE7ZX/yGlnddZLM5eM8WKW0xBZWt6F4Aay7vwNcoFMSkT0tT5Di7T35lu4MvENu5aE6Hf94qxKyfWZGnuSphj5Fu8lB1EPRWTgQm24g+7DHRQQ4Qh6R7GtK7nlnu8j5EOmVmIO4hiaD8dbZE1N7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=unisoc.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9OsIMASwZMwxWg0dmAIAY0N/BxnkCKvL8vpBTUxVVk=;
 b=gJZ9TyZjSxDO13I7kTgvo1nRXJjHC9aMVhaf7kQ6lfJlTOGTUD7j80ncijyRGlwAPSb0hvtPib8WZGaiu/9tHYrbLFT81SmjH6Tr9L82J/kkmj2C41lNGxTJHVSQJmJR3gWc0eeSForu3zi+Y5ydgQBpF/Qd1cL0ooJkXeg+OsU=
Received: from BN0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:408:ea::30)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 16:54:29 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::c8) by BN0PR04CA0085.outlook.office365.com
 (2603:10b6:408:ea::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 16:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 16:54:28 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 11:54:23 -0500
Message-ID: <03344e80-4ed2-41f1-9d2b-f7ed2e201eba@amd.com>
Date: Tue, 25 Mar 2025 22:24:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/uclamp: Align uclamp and util_est and call
 before freq update
To: Xuewen Yan <xuewen.yan@unisoc.com>, <dietmar.eggemann@arm.com>,
	<mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <hongyan.xia2@arm.com>, <qyousef@layalina.io>,
	<ke.wang@unisoc.com>, <di.shen@unisoc.com>, <linux-kernel@vger.kernel.org>,
	<xuewen.yan94@gmail.com>
References: <20250325014733.18405-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250325014733.18405-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3f06b3-5a70-4580-1020-08dd6bbdb4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUMxY3BMY1NYRUQveEMrVU5tT1FkcWZDUmpKa1lMZW9Wc0dITUk0K2xoY0Fq?=
 =?utf-8?B?VlFvMEtCNThkenpVRVRHenJnaUxuWmV3N0Z2MURhbUxmOGVsbnJ0ZEppNmxy?=
 =?utf-8?B?Unl3bjg3K2tQUVFkanVxVSt4eXFROExhbHpNc1krcitXd1FQYjZUamQxYUZP?=
 =?utf-8?B?RTduN0tmSjdiY0JEcnlHZ2lCUWltMmxxMGZnNTlqYWJhclRVa0ZMaFVHTjA2?=
 =?utf-8?B?V08rM2NENGVTclMxWTV5U3F5TXpDUjBTWjMyY1BmdEpxSFF1OUFJUmNpbEVl?=
 =?utf-8?B?VFI5N0h2UXZwL20yL2tuYVo4N2tsTm9BWWNsVFNqYzFrWXpmdXZLRWFGZXZM?=
 =?utf-8?B?a3doZkZnd3dJc1BoM01KUlFGeWw1akJYUERlOFY4ZHMrZHc0VEVnYlVoMHll?=
 =?utf-8?B?WllXMlVUMkxjTjBJaHB3dVpxeVZkM0VrOTgxeFpZNStlQlYzNTdVWGVkbzFQ?=
 =?utf-8?B?WGQrc1NwMXJ0M0kzaHdOb3A0RVFVeDZDSUZ3UkN1SHdNK2J6ak9uenJRMHdL?=
 =?utf-8?B?SHNXQUhNZnh5VHBMYm1OREF5NURud0w3cC9yWWVaUFBENWg5UjZXOWQ0MmFw?=
 =?utf-8?B?T0tvMGpVVFJPSmxVd0dxVDZRbXZLenN1TU1VSElDd3doRk04OG1nWG1idG5K?=
 =?utf-8?B?ZCtnZ3ppMGJFVy9mTGFpenJ1MGFsUGUybld0TGRyNDZYWm4vSTZCZDlvUzdF?=
 =?utf-8?B?d01KTVROdE44cTNLME9FZnFFYnR0dGJINkVmRDBDcTcrc25lSEpWNVlJNzIw?=
 =?utf-8?B?bzRDTlhXQUdkdTFFbUtNWldOeHhLRUs5VndURklySUE0NlE1NGVsblh6VWp6?=
 =?utf-8?B?SEpEeVd6SCtxeWNGTldLMyt5SGRZaXUyekpMZFZudXZEUDdNZTJrRk9nQ2E0?=
 =?utf-8?B?OU9VcUliZ3ovSU9UMnhXbUxmRDdNK2NXVjIzWVRtNWw0WXYrMmp4dHNTTTRJ?=
 =?utf-8?B?RUdVTW9lcEJFbXY1Q082VGtENGtyei95ak1yVVAzZmQ3TjZVd0x4T0d2Mmtq?=
 =?utf-8?B?bVVXdi9lZEFOdzVHS2lKUTFia1ZaM3hFSXRQbkhibXJsMjhVNUl0UjdWTGlF?=
 =?utf-8?B?d3VOeG84ZlBLTDVRSTN2djJ5UTBta2lRdXR4U3FHajEwWlRxZUpod0JYeUlJ?=
 =?utf-8?B?bk5CM0xTUVlDUSsxRHp0SkJCcjIyYk9vUlZ0ZDl0d0g5d0s1TmwzMmxuRFY1?=
 =?utf-8?B?dUlkOXpDbVU0WlN5eU80MDlWNVk3TCt0bThjbU5nM3hSUUlyMDhhM2s0a1NU?=
 =?utf-8?B?bE5OTFFSSFh2djN2RFR2MTFONmd2LzI2aEFHZFM4ZU15NkljRi9ndUYyV1lW?=
 =?utf-8?B?b2lHT2t4T3hnaHJSMXBuNjhlbEd2VndmaUtEaWJCc3RzbXJrOGU5RnlSQnhw?=
 =?utf-8?B?VXZtLzRHRU5FNkV1WTYySEdvcGV6RkVxb1NuRjJCOWlUeVpsaGpIa25BbnZC?=
 =?utf-8?B?bTFvcVM4TmtmSzZmeDBPSWl5L1o3ckV2MXdmT2pxa0xMRHNBVEFTVUlaUXdl?=
 =?utf-8?B?VldSeGtxZTZnbXlMT3lnbnpsUUJWNG1KK1FtTlZUbFBvMVpQVzZmZW1uYndw?=
 =?utf-8?B?NTZZQmNtSEZ0VlVaa1hhanM0eWdXeUdvNkwyV2tYbml1YTZ3SWFaRytCV3JZ?=
 =?utf-8?B?enlXTnp3UTN1Q3RnM1MrUWt1R3JObEkyRm40OG43bkdiR1YxcVBvU21KQyt2?=
 =?utf-8?B?U0s1dXo1OWtpcTBIUXAzcExGcE5YQVNnUmdCN2hiMzh2NHNqaG5yL3hLcVhU?=
 =?utf-8?B?Uno0REJRdzJtcUdHVDZYNGxFeGxpSjMzRWE5TFFDdmZGeFFzZitENmpSYUZo?=
 =?utf-8?B?RjhtRlBRU1Z6MlVCR2hYSnJ6aTJTSTM0S0N5WXJBV2ZmRFFOakhEZno4T1A2?=
 =?utf-8?B?QnFPUkh3bEVXOUZGcWVtWWNEd2IwT0Z5NEE5cURaYUxySVoxbFJNTS8veGll?=
 =?utf-8?Q?92iliWKmr4VVggB8m2QIEQgR9BdEazXa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 16:54:28.2167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3f06b3-5a70-4580-1020-08dd6bbdb4c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

Hello Xuewen,

On 3/25/2025 7:17 AM, Xuewen Yan wrote:
> When task's uclamp is set, we hope that the CPU frequency
> can increase as quickly as possible when the task is enqueued.
> Because the cpu frequency updating happens during the enqueue_task(),
> so the rq's uclamp needs to be updated before the task is enqueued,
> just like util_est.
> So, aline the uclamp and util_est and call before freq update.
> 
> For sched-delayed tasks, the rq uclamp/util_est should only be updated
> when they are enqueued upon being awakened.
> So simply the logic of util_est's enqueue/dequeue check.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> v2:
> - simply the util-est's en/dequeue check;
> ---
> Previous discussion:
> https://lore.kernel.org/all/CAB8ipk8pEvOtCm-d0o1rsekwxPWUHk9iBGtt9TLTWW-iWTQKiA@mail.gmail.com/
> https://lore.kernel.org/all/84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com/T/#u
> https://lore.kernel.org/all/CAB8ipk9LpbiUDnbcV6+59+Sa=Ai7tFzO===mpLD3obNdV4=J-A@mail.gmail.com/T/#u
> https://lore.kernel.org/all/aa8baf67-a8ec-4ad8-a6a8-afdcd7036771@arm.com/
> ---
>   kernel/sched/core.c | 17 ++++++++++-------
>   kernel/sched/fair.c |  4 ++--
>   2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 042351c7afce..72fbe2031e54 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1747,7 +1747,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>   	}
>   }
>   
> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p, int flags)
>   {
>   	enum uclamp_id clamp_id;
>   
> @@ -1763,7 +1763,8 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>   	if (unlikely(!p->sched_class->uclamp_enabled))
>   		return;
>   
> -	if (p->se.sched_delayed)
> +	/* Only inc the delayed task which being woken up. */
> +	if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
>   		return;
>   
>   	for_each_clamp_id(clamp_id)
> @@ -2031,7 +2032,7 @@ static void __init init_uclamp(void)
>   }
>   
>   #else /* !CONFIG_UCLAMP_TASK */
> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p, int flags) { }
>   static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
>   static inline void uclamp_fork(struct task_struct *p) { }
>   static inline void uclamp_post_fork(struct task_struct *p) { }
> @@ -2067,12 +2068,14 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>   	if (!(flags & ENQUEUE_NOCLOCK))
>   		update_rq_clock(rq);
>   
> -	p->sched_class->enqueue_task(rq, p, flags);
>   	/*
> -	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
> -	 * ->sched_delayed.
> +	 * Can be before ->enqueue_task() because uclamp considers the
> +	 * ENQUEUE_DELAYED task before its ->sched_delayed gets cleared
> +	 * in ->enqueue_task().
>   	 */
> -	uclamp_rq_inc(rq, p);
> +	uclamp_rq_inc(rq, p, flags);
> +
> +	p->sched_class->enqueue_task(rq, p, flags);
>   
>   	psi_enqueue(p, flags);
>   
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c798d2795243..c92fee07fb7b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6930,7 +6930,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   	 * Let's add the task's estimated utilization to the cfs_rq's
>   	 * estimated utilization, before we update schedutil.
>   	 */
> -	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
> +	if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
>   		util_est_enqueue(&rq->cfs, p);

Wouldn't this do a util_est_{dequeue,enqueue}() for a save restore
operation too of a non-delayed task? Is that desired?

On a larger note ...

An enqueue of a delayed task will call requeue_delayed_entity() which
will only enqueue p->se on its cfs_rq and do an update_load_avg() for
that cfs_rq alone.

With cgroups enabled, this cfs_rq might not be the root cfs_rq and
cfs_rq_util_change() will not call cpufreq_update_util() leaving the
CPU running at the older frequency despite the updated uclamp
constraints.

If think cfs_rq_util_change() should be called for the root cfs_rq
when a task is delayed or when it is re-enqueued to re-evaluate
the uclamp constraints.

Please let me know if I missed something.

>   
>   	if (flags & ENQUEUE_DELAYED) {
> @@ -7168,7 +7168,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>    */
>   static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   {
> -	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
> +	if (!p->se.sched_delayed)
>   		util_est_dequeue(&rq->cfs, p);
>   
>   	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);

-- 
Thanks and Regards,
Prateek



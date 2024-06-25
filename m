Return-Path: <linux-kernel+bounces-228296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7089915DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2A51C2199B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48E13C9BD;
	Tue, 25 Jun 2024 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sdLfdzbS"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4751EB3D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290927; cv=fail; b=X3orzpLW6MVu19tFDRR7HHp8RgWdTTeiWOc57nKZe3f8GnbTuw6VM7utVMcJoYQcNBGwVZrzIjO56vmd5Kk2FWq6ggvfk78IG7iMVnyFWyIYJ9BlRSAGEM3/Bo+Rf/VQenCGo9wqkjMBup9BjcaSOTkJUTVdl1lrSWqHMVpavPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290927; c=relaxed/simple;
	bh=Uo8eHV1Mtiy47eCky6vDqksMpQptvqhmEK4FkFyT4Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LsP2y81f2GiRoOAlFsItyNyrw2ZAr8oA3vls9wM6TyqCzRsQbIs5WQqedjxlj35kNkPIM0F8O0ft9r3/Dyql4a6dLO/Mn+t0qJTGEpMgZJoQFZhRgc8bOfNhxGK65FFxn10QiWjH9uZ+gLp6cD4dKV0CC4+MKM+iOQBo4qv0V1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sdLfdzbS; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrYl0GvnZvrrn5VXMNWeCtl/6vB4zI32cCJu0y232QWxJNGDLm0cSX59AiTkSOXLYxIIjsSai/S2S1gbgep/COG0Yb0BETAH0bqd+9IniRXz4ned3IjO/0CgcrPcX/MHdXukJodpFf9LuG/8/dP1nc7JrHTEwSBdJkUX1bk46+6JQHkB3QA1UOmRZp7yFT2Zl7qKQdjWHF2WFbUFJI64udXUfBrhOtn852TkWlb5WZfEF9hzYMDshk+X1dYzBLQjlDbjKk26eHoG88EjbB/7YGSTFR8FMwCyWT00ZoNBj6nA2IQ4NZbg61b4rgIkznJLG+/QhORm8SODX9mwIyz+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOTomIDgPYh9DBSWR+lkserbNaVevvr2llrnF0+lMYw=;
 b=CFLe7u8INKwI0VhUJs1pg8VfPOykfb5ccyFxaZl/MJHvX9gfx/EQJkZv7oq5iKKpwOJfl0SEp2Kx82WgQEoOtaKzFTsPKqTvukCyTXlyhK17ZvxXK6kPmeU4kD0LCdQ3xoknG+0+Lsq3dNdMurPTBO5GyBxV4XqUB7AJEIOGa/ryyXBXga710p504mCx2LChxaB3meWArHZ9nUaVlkdZ1pqH2jZMqT3i1NKt2pSgNzBL96P0yaYh9513qxa3dDbf87TzVxsPi/uPTrPxih23Ml4MUFwWyQSVryiDiGLg7bUiX+Po14qLzSj+lJK1NFM7eW9C5HTpGTlWTAzjCACj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOTomIDgPYh9DBSWR+lkserbNaVevvr2llrnF0+lMYw=;
 b=sdLfdzbStumzFMnttdFH5VBn4jZLKv2GMtHIbI/DqSNclW/DjXO/zf/dHW+93JqWuD/tOz0/Kp+UvDLw6A0VtPSMOc0nfXBiQXUYY7Z6vRy+AICmnLsN0ic2kOKt45TC7vbez1RVWD1Mh5TF3jZCtgdtK26uQl9cSiq2lu1CBlU=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Tue, 25 Jun 2024 04:48:42 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::f0) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 04:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 04:48:42 +0000
Received: from [10.136.36.140] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 23:48:37 -0500
Message-ID: <0aa84916-bf29-2207-e0b4-a99fefba5a2e@amd.com>
Date: Tue, 25 Jun 2024 10:18:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 7/7] Propagate negative bias
Content-Language: en-US
To: Hongyan Xia <hongyan.xia2@arm.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Qais Yousef <qyousef@layalina.io>, Morten
 Rasmussen <morten.rasmussen@arm.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>, Pierre Gondois
	<pierre.gondois@arm.com>, Youssef Esmat <youssefesmat@google.com>,
	<linux-kernel@vger.kernel.org>
References: <cover.1719223916.git.hongyan.xia2@arm.com>
 <60985d07acd8a2daf4f3adf31ce4bf3be2982306.1719223916.git.hongyan.xia2@arm.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <60985d07acd8a2daf4f3adf31ce4bf3be2982306.1719223916.git.hongyan.xia2@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b736ee9-5678-4d03-68d1-08dc94d216e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1UyQ081bEE5dXZmNXRVbjJWOUhNTkI3ZlVKRFRnUzNocU1TbDNNVVIycUtX?=
 =?utf-8?B?UkZBZXphT1JabFkzdnBTM21sOUt0R3RoUkttSVM3WVVxOWsrRU1DZmI1MTlN?=
 =?utf-8?B?Z1Z2ZkpROXY5bS9YYTYxRDNCaU9TMEN4RDhnL0cyRUdJK2lKSUlXZlZjVHZi?=
 =?utf-8?B?WmEwUHlCVnVTSVloRHk3eU91cHdQNmV1Yk1tYkpnWHA2czVwOXFxT2FOYmZF?=
 =?utf-8?B?cUlLQmZuWVRNRW9ESVNzL1BYMkNiaHBoRkFPUW16YjA3dSswbUU3dmN0dTFG?=
 =?utf-8?B?cVNNYWJFcHJrd2RNRzltaVpYVm1iamNQeFNCYTZUOHZuQUFHWm5meENuNkc1?=
 =?utf-8?B?ejFpZm9ZUEswZzBPOGJMd2VvbkFXYnJ5NWFncmxuSnAvblUvNVY3US9PS1ND?=
 =?utf-8?B?THB5Zlh6OVNTOGpJeElHSDY2emd6UVVRdEFORHYrV3cwWmtWSTFYZFFvVzJq?=
 =?utf-8?B?YXJyc1NadWtSNzlDTlVabUduUURXeG1qRUdsa1NUWXVodU1QdjAzZHM0c1o1?=
 =?utf-8?B?MldxSW9WUW9DWkYwUE1kNmltNVh4ZzZWa29zNGhWWXJDd2h6YlZ6YTVndFNP?=
 =?utf-8?B?Y1NvRi83b2lWTm41SzBaK1dNZU1yMElVWDY4cWlOZzJlOGhwTmtBZFpSZ0Vy?=
 =?utf-8?B?UUZ2T0FpM1p1ejNNQ2xoc3k5c1JUVk5IMkdybzBFWE5Fbmk2NGsxZkJsRDFI?=
 =?utf-8?B?UFNBVFFKdjQ5eFlSeFBTNGJUWFRQNHBTNkN3alVrNUkyVGFTL1B5cWNrY21X?=
 =?utf-8?B?NEdoSFJhZ2pDOTdJS1owNVVlZ3d4Q29uZWljdDJUbmlnNVZMWFhoTC91OXRx?=
 =?utf-8?B?ME5mK2JOMjZYc0NmNlpVbGRGUytXYnpoT0lRL045VUcvY0FPZkxPNUpGU1Fp?=
 =?utf-8?B?cXhUUmw5cUlCd2xkZmczeEVTdDdtS2dFTVczVE1yMWl5Q2lrcm1tMUFkUHY5?=
 =?utf-8?B?aVRkbnN5UlAyRE9FTEZzbXdaeFZ3cFV0ZWE1UGJPMzdvUXREK3JrYlJuS2Vu?=
 =?utf-8?B?Tnc5NTVRVGJoM2diNEg5R0hGNkV4TnpKRmNURTEvZy9Lb0g3eGF3aURsSGQ4?=
 =?utf-8?B?RnB4dlBBK0diR0p5Ym1oSnR3TVI3OWFOWmNISG9ZYTBMbExHVE1BNTR5ckgy?=
 =?utf-8?B?ZytQNnBDdnZBdXl3YTU2aE15T1NvblN2Q2kvVkgrWnBYUHdQN0t5WUtWSDBm?=
 =?utf-8?B?dFNZWTR2UzRWZ3NEU3BJWm1aazdNQTNIRVBObnhhNTlxcXVkU0hpb1djTXdm?=
 =?utf-8?B?cm9Tb1lhRmZoY3Vaa1Y0OWZyMkt3c1VUYVhtY2wvWkZ4Y0FMM24wSVIweXov?=
 =?utf-8?B?VHlqU2YrekIyeDk5c29qK0VmS0pxTzVHNlAzTmJKMGdRbnozNEk0NEcxbmNo?=
 =?utf-8?B?SjNOTjBjd0xzb1FtcFZ1NlJUR082Y2JaR082eWYrNEtITHZWZW5PMWNVcVFJ?=
 =?utf-8?B?ZG5CcWgwTzlZZWtWUGsyNnp5Rk9mZndNY2FicEVpMGRNYkhTQjUyeEZIZVow?=
 =?utf-8?B?MWQ0NTdrRCtKVHJJWFYrMzdRU0lTclRGWGlSWDVVWWJja3h2UTM1ZC9rTk1q?=
 =?utf-8?B?L2RpaHg5N1Mya3dYdXE2bVNrL1M3RCtrWnhJRGlqYnVYUHR1L282bWFXYlRN?=
 =?utf-8?B?d2tHZjN4Q202Z01vQzZzYkpjNjdTT1hTU2Z1OHBVOXY4Wnltc21ndlNlL3g5?=
 =?utf-8?B?Q3BQK1dTRWROMUxURHRjMHEweGFqSy9zelNoejlGcCtuM2dxcTdiNVVxd2t0?=
 =?utf-8?B?MHhrZXJVQzQxSVJnTTlBeXlFUlZxN253R2RBUHcrZ2tuOEJqa1BuOUtKS3BT?=
 =?utf-8?B?MFNTT0djQS90TDdXdkdCaTNzRlR2QjRoS2pBeW43eU9LU1VPRHNhS3ZuLzRY?=
 =?utf-8?B?bFlHQ2tGTWpYL0xsZVNCdGloSmVYNkdYemUrS29ITXpZL2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 04:48:42.6678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b736ee9-5678-4d03-68d1-08dc94d216e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

Hello Hongyan,

On 6/24/2024 3:53 PM, Hongyan Xia wrote:
> Negative bias is interesting, because dequeuing such a task will
> actually increase utilization.
> 
> Solve by applying PELT decay to negative biases as well. This in fact
> can be implemented easily with some math tricks.
> 
> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
> ---
>   kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/sched.h |  4 ++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3bb077df52ae..d09af6abf464 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4878,6 +4878,45 @@ static inline unsigned long root_cfs_util_uclamp(struct rq *rq)
>   
>   	return max(ret, 0L);
>   }
> +
> +/*
> + * Negative biases are tricky. If we remove them right away then dequeuing a
> + * uclamp_max task has the interesting effect that dequeuing results in a higher
> + * rq utilization. Solve this by applying PELT decay to the bias itself.
> + *
> + * Keeping track of a PELT-decayed negative bias is extra overhead. However, we
> + * observe this interesting math property, where y is the decay factor and p is
> + * the number of periods elapsed:
> + *
> + *	util_new = util_old * y^p - neg_bias * y^p
> + *		 = (util_old - neg_bias) * y^p
> + *
> + * Therefore, we simply subtract the negative bias from util_avg the moment we
> + * dequeue, then the PELT signal itself is the total of util_avg and the decayed
> + * negative bias, and we no longer need to track the decayed bias separately.
> + */
> +static void propagate_negative_bias(struct task_struct *p)
> +{
> +	if (task_util_bias(p) < 0 && !task_on_rq_migrating(p)) {
> +		unsigned long neg_bias = -task_util_bias(p);
> +		struct sched_entity *se = &p->se;
> +		struct cfs_rq *cfs_rq;
> +
> +		p->se.avg.util_avg_bias = 0;
> +
> +		for_each_sched_entity(se) {
> +			u32 divider, neg_sum;
> +
> +			cfs_rq = cfs_rq_of(se);
> +			divider = get_pelt_divider(&cfs_rq->avg);
> +			neg_sum = neg_bias * divider;
> +			sub_positive(&se->avg.util_avg, neg_bias);
> +			sub_positive(&se->avg.util_sum, neg_sum);

Most cases where I've seen "get_pelt_divider()" followed by
"add_positive()" or "sub_positive()" on "util_avg" and "util_sum" I've
seen a correction step that does:

	util_sum = max_t(u32, util_sum, util_avg * PELT_MIN_DIVIDER)

There is a comment on its significance in "update_cfs_rq_load_avg()".
Would it also apply in this case?

> +			sub_positive(&cfs_rq->avg.util_avg, neg_bias);
> +			sub_positive(&cfs_rq->avg.util_sum, neg_sum);
> +		}
> +	}
> +}
>   #else
>   static inline long task_util_bias(struct task_struct *p)
>   {
> @@ -6869,6 +6908,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   	/* At this point se is NULL and we are at root level*/
>   	sub_nr_running(rq, 1);
>   	util_bias_dequeue(rq, p);
> +	propagate_negative_bias(p);

Perhaps I'm pointing to a premature optimization but since the hierarchy
is traversed above in "dequeue_task_fair()", could the "neg_bias" and
"neg_sum" removal be done along the way above instead of
"propagate_negative_bias()" traversing the hierarchy again? I don't see
a dependency on "util_bias_dequeue()" (which modifies
"rq->cfs.avg.util_avg_bias") for "propagate_negative_bias()" (which
works purely with task_util_bias() or "p->se.avg.util_avg_bias") but if
I'm missing something please do let me know.

Since you mentioned this patch isn't strictly necessary in the cover
letter, I would wait for other folks to chime in before changing this :)

>   
>   	/* balance early to pull high priority tasks */
>   	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
> [..snip..]

-- 
Thanks and Regards,
Prateek


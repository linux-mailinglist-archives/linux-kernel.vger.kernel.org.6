Return-Path: <linux-kernel+bounces-258466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDA93883C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391A7B20DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF1D1759F;
	Mon, 22 Jul 2024 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KFmrkGaR"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723347FD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721625477; cv=fail; b=W1csh2J7iO+t0bWHieEQlp6J/Ub3v+ES7RsRIrSDX4VzIucSbMaAbFAn4dUakRAK8N2Yq1rK0rjRScJ7pZhpvmsfyVa4fG3eE0xzB2ridTPNuSqtdoeNcN2LcNYXMPCqNF4HIALOWfmbboFE6KAc75iwfv18CvSoYDgaAusfavE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721625477; c=relaxed/simple;
	bh=1ZcKYLH5uE1nmsD8CR58mBmMNkzKkxOOPvBnQBlyrhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=baI2hZZXyNEJSCWTX5z68rwupIanQ+/n63KEhnI7iUYxYkXoaHfchjeuqiyptuqtgdva3bLAn6icqNsCMRzvYLyO0/gnLR5HeGYWfgTJwybi/Nbw2sXzu/awq378zWTlYg2jeqlr0PDYNkLUyui2L2/PlvJBhSl33OXF5h9UWBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KFmrkGaR; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qF0NRUeSrvpvpKXL/X0Nh4O60JB4l7TcUfSr+hOG+zUTr00oBsgKB0AOXKpRvBUo1Tou1I8HD0fV6NO5UhsAc9nnbvUW9/rPaNYKej+QcvqN+JCuXPUPM5mFH4jmqlb9pNitlE+RzWZI/NgF+a/XJBxl0zIv9Bqs3CU3o371M9eIbFyuvF7XIvH+8MPDNG/VmAtjhXFlGi4Hif324vhEiJs8vavjk8ibj0G4vMRHBH2upc5HcltvnvJVu2aZPt8V+bioyputyGInWckkBsjEnT78C82YIOicUBBO2V+DfQuVOhSl3wfBDzNe9kPNBD21lJSCs2GFIkTibpwNLTdrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4An52tyVmbkrtojd3QYMufVFk/exfNQQIoMHfwJNPU=;
 b=EZidiDK1aOPuun2aLd1xbgaZHZQxMAhuRfL4RLQ4EYNuu/6Dcu/6y9E7LnQXZ9rgy5Ozir2vJ6OK0liTse6Tt1LX975VmDj/W3Kr9tFslepTEHaP3bmqa3P649lI4zT5byRt8lTSGBRZ+kb1KKIj6y7Y0kXziy0bRfHfaUef51SSsijWnzJLPAq5nXcmyK6V9XJlAlRwSq4RHceiqu3oNhEQaxr7bXuqSCf4Ml5BIpC48HigoOlK2w68w35BRJVwF29ZQlkZiZfeIl8LqwUg7OxS3fJ0KU+HUIq5YCrz+vyHEIiBbU4PTfu7bOrPOxhYj9+hdJSZ2uOrH+OcHQJtxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4An52tyVmbkrtojd3QYMufVFk/exfNQQIoMHfwJNPU=;
 b=KFmrkGaRePLSur2PrKtnUCvLbhOYIUzeyK+xJsRE/SsuwUbRzUt7Hqzo0fHu1uSmX7/JEHTRYJKEwP+McVnvdrOv0B4ymQxdmadwSmT2mYzWgmM0cmN9oDYTLjfMeFzVhTUtA6wHxgR33u2wu5H5UB4dW80VucZ8gW8a/5dS75M=
Received: from PH8PR07CA0001.namprd07.prod.outlook.com (2603:10b6:510:2cd::26)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 05:17:52 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::c9) by PH8PR07CA0001.outlook.office365.com
 (2603:10b6:510:2cd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Mon, 22 Jul 2024 05:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 05:17:51 +0000
Received: from [10.136.40.40] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 00:17:48 -0500
Message-ID: <3e88f113-e7b9-9b26-a4c1-52cf92b820c5@amd.com>
Date: Mon, 22 Jul 2024 10:47:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
Content-Language: en-US
To: Chuyi Zhou <zhouchuyi@bytedance.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <chengming.zhou@linux.dev>,
	<linux-kernel@vger.kernel.org>, Qais Yousef <qyousef@layalina.io>
References: <20240720051248.59608-1-zhouchuyi@bytedance.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240720051248.59608-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: de86316e-3135-4837-08fb-08dcaa0da2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RytUbzd1cUlJYTBqclR3R1pSNTZ4bFM2MmZsNUZYdmdpT1poRE5oakE4QmVL?=
 =?utf-8?B?R0k1eFBLaE5CTk5aOHhzR3d2T0ZJcjhERE9zQlVTZWxIK2pwTUF4SVhZanRY?=
 =?utf-8?B?WE9uSCtaS2VlN1pvUUNRTGJCY1c5Sk9wZ1lhYTk1a0o2NFd5M2dvT0trQmVq?=
 =?utf-8?B?bEdrQkJlMjM3UTgyNWtTbjY2aDVEOUo2bHRBZEwyblJvUm04bDlzQ2FndDVP?=
 =?utf-8?B?bUxwQ1Z4Z01KUE10QmI4WGJkRTFlOTNMZWI2RU1ZUzhybXFvSU1sazhFekVu?=
 =?utf-8?B?V1I4K1g3bjVFVzN3cUg5aXB0VjBaNW02R1VOMXJERnVLM3ZoU1dIN3drWUNY?=
 =?utf-8?B?Mi84QzNsY1BpQ2JJamdKY2dsNi9vQ0NZM1ZQc3FKUTZZYWhSTGFweTRFWjRH?=
 =?utf-8?B?L0FVMHFIaVoyaFBYUE9Gb0hvSjBxSXBSL2JPc1hMYXZ0NXd4SE5Vc0VSMEpN?=
 =?utf-8?B?d3NpUjkzVlFWTWk4bXFUdG1UdVhDUkJZdkkvRUJubVRrVUNFa3oxZzNhZFJD?=
 =?utf-8?B?NFdZV2xXVU9ONHJQQVVjKzJudVNCZmJ1TkFvSkJyS0d2NkRLVStKTDJ2Q0Nv?=
 =?utf-8?B?enlzTUs0UmNVcnIrbUZWUDVOc2JkL3lHeU50OEcwdU4vTDR1QVVYM2g4cGFK?=
 =?utf-8?B?ZVc0NW5nQ0hwRkpYWUVEV2lvZkRaOHFiTHNZa3NUL1ZBK2Z0enA2YkJlazBC?=
 =?utf-8?B?MU8xMEtTSmQzWGtwSWJOdkFQcVA1Wlh3cGlqaTFPbnF2LzFFSWZlM1lrYnZm?=
 =?utf-8?B?VWlqclR4OG9OSzRETDRVNFFqUnlnZngxTHBWNEZmWDZGT3hQSFVMV2crL21M?=
 =?utf-8?B?MXBxOHg4YllGeFd6clFRQWtQVGlwSDhSMmRxU2VSYVExRjVCZDhTMUFseGdh?=
 =?utf-8?B?dnFSUGo5bTR5UGRTTG5LQTl1dUsxRG5DdkRobVBwWXA5Y0I4RTFMVG1qMngv?=
 =?utf-8?B?dTFaVmorMGxBZG9Sak9hMHdYcXViWmhLN1M5VEJReThTcllTUk4zK3AybDlC?=
 =?utf-8?B?QUhhd0xaNVloUDZzaWJsb3VsZEFmV3ZZbWRzWkZBYzQ0blFyZUNmVk4yd0sy?=
 =?utf-8?B?alZrdjFFaTJ4VzhzSGpwZXZLM2FYTkhtSmxaZmE3VUVmUmJPTUhaUVNiMXNK?=
 =?utf-8?B?a3FkdFVub0VtWXU3SVV2VXZWNTdMeGVhWjB0Q1FqcVI1UUVTTUxVLzFGQ3NR?=
 =?utf-8?B?K0N6bzFweFBwOVhlY280YmJBdExZZ2VzbGUxeVNrV1lNY3ZNUENSZERVMVBt?=
 =?utf-8?B?eHhmQTBnMW11eldpd1JCRTFoN0FSam1veCtsaUNWRzYyaHI4SXhJbHg3YWNO?=
 =?utf-8?B?bjlENnU1eHdDTkRKcllnYjlOQkNiQnQvYjRjM2trTE8yS094VC9SSmhxaFBv?=
 =?utf-8?B?VzR5Q2NWRWhWQ1czbDdmVnlFekY4dzRaWmd5ck5OcUJFRjd1Z3hla3V5azdD?=
 =?utf-8?B?VkxadnJ2WXJZWEl1QndiWkhSWmdSazJHS3ZFT3lQVWhSSWNDSTJIV1UrZmJW?=
 =?utf-8?B?RW9UTHpMdy9TREF6SWprazM0K2JWRHRFc09acWVyQzRnbFBXTHBMcHRlMDNx?=
 =?utf-8?B?YmxkSUk2R3VRbkxKV2tjd1pxdXpOUmVXR0NjWWl0R3RZekU1bmJsRnZXVERH?=
 =?utf-8?B?bEthaGlOU3ovb0hmQkFqMVd5Y1dhVG1WY2VKZk1zK0tPYUV6d2JPWnoyRW16?=
 =?utf-8?B?WUlxUDZnK3VYL1UxMEFWbGgvQUhtVmxEaHBocE51QTFhVEQzVFNjYzNTbjV6?=
 =?utf-8?B?Sk9weHVkSVRIRkliS1JKQkJJc2JmVXVFekQ2ckFUTi9zN0ZEZ3Z0Wmt4TXZR?=
 =?utf-8?B?Umc0cGUwVGg5Mm9kZjY2ZVFKdEJHS0tnditlemVNTmw4aUlUV05TSVBkQmFE?=
 =?utf-8?B?NVFmL3FQYktiSmFsYXRHV1VISCt2V29mNW5rV3pHTWRhK2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 05:17:51.9703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de86316e-3135-4837-08fb-08dcaa0da2b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150

(+ Qais)

Hello Chuyi,

On 7/20/2024 10:42 AM, Chuyi Zhou wrote:
> In reweight_task(), there are two situations:
> 
> 1. The task was on_rq, then the task's load_avg is accurate because we
> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
> 
> 2. The task is sleeping, its load_avg might not have been updated for some
> time, which can result in inaccurate dequeue_load_avg() in
> reweight_entity().
> 
> This patch solves this by using update_load_avg() to synchronize the
> load_avg of se with cfs_rq. For tasks were on_rq, since we already update
> load_avg to accurate values in dequeue_task(), this change will not have
> other effects due to the short time interval between the two updates.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
> Changes in v2:
> - change the description in commit log.
> - use update_load_avg() in reweight_task() rather than in reweight_entity
> suggested by chengming.
> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
> ---
>   kernel/sched/fair.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..b1e07ce90284 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3835,12 +3835,15 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   	}
>   }
>   
> +static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
> +
>   void reweight_task(struct task_struct *p, const struct load_weight *lw)
>   {
>   	struct sched_entity *se = &p->se;
>   	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>   	struct load_weight *load = &se->load;
>   
> +	update_load_avg(cfs_rq, se, 0);

Seems to be necessary when we reach here from __setscheduler_params() or
set_user_nice() for a sleeping task. Please feel free to add:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

But since we are on the subject of accurate PELT accounting, one question
I have here is whether a reweight_task() for a sleeping task race with
its wakeup? Something like the following scenario:

CPU0										CPU1
====										====
/* No rq locks held until ttwu_queue() */
try_to_wake_up(p) {
	...
	/* Migrating task */
	set_task_cpu(p, cpu) {
		/* p->sched_class->migrate_task_rq(p, new_cpu); */		/* Called with task_cpu(p)'s rq lock held */
		migrate_task_rq_fair() {					reweight_task(p) {
			/* p is still sleeping */					...
			if (!task_on_rq_migrating(p)) {					dequeue_load_avg(cfs_rq, se);
                 		remove_entity_load_avg(se);				update_load_set(&se->load, weight);
				...							enqueue_load_avg(cfs_rq, se);
			}								...
		}								}
		/* task_cpu() is updated here */
		__set_task_cpu(p, new_cpu);
	}
	ttwu_queue();
}

In theory, the remove_entity_load_avg() could record stale value of
"load_avg" that gets removed at the next dequeue if I'm not mistaken?
But I believe these small inaccuracies are tolerable since they'll decay
in a while anyways?

>   	reweight_entity(cfs_rq, se, lw->weight);
>   	load->inv_weight = lw->inv_weight;
>   }

-- 
Thanks and Regards,
Prateek


Return-Path: <linux-kernel+bounces-560677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAA0A60804
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826C719C0D32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17E413D279;
	Fri, 14 Mar 2025 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lY4C/O45"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97113A244
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741925705; cv=fail; b=P+QnxYbdW9rQ/X7iS59SWauallKfiIgzEataXLoSo4z9dDbcggb32AAwSZtKWuoGfpoqJjO+Xijobtv05ojCaEAMUwXtbc+l9VJPKYz+WZGIqANESHG3JPocxiwV1y1AgzKPFPh54D5l3iBf7zWBhsZS0xLNRpyQlmf+OMqbKWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741925705; c=relaxed/simple;
	bh=6lxS0wj8NOqqJ95YQoEvGzdMFdQoLO1dqR779hdoblM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c6EBcf2L3TXVmz6uHBGWqT9dIcw0FRaGOwTE55VhUWbAslT5zs0uk/6VrArHtoncPNmz9eVYJNVmh5e4mt81sJdTIcDYMTKIACGC1X3lMAzk6cGdTMTY/im2Lnw5lYFd1lv74QCyKIU4OQKkwxkbmTrbk3kCxZHsrYJciFB4WuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lY4C/O45; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuSXlwoIWEaiNY5EzCihomaOlABxr2qUllF19ag8+Le9KLLRL36TZRUH0nX5Uj0zfP7qH+ey0QvRWkpuccLCPMgWqyxijqOdcssnienxqcsmRqzgXqkS561veuKcaiBFkMzQSM2OSuxLEzKCNFwP6mm8IYYCaZKu39Usga//69ybDfiff4mhrPMB0+ZX+OoKF9VY1I3a9f1JeD8ec/X/3GKvBJzALvHuteQ5s2ZmLSAkELN2kbEOKfTwB8cgUPoUvKHMevl4UV0WPsyBPvuXvEPsdQKMhBHCinke8FWi9eJEnrcZCobC8vXLBga/2U+w9mUF/rPzSAUc2Iuw18m6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEGK3Mq3y7aMOQld68Py9cdjPq0T3RJIg4xD+G8q5Nk=;
 b=fb0IyfS+UGZICeJPIiDqhY3qQph2Ld2UfzjoZesvyfbZOrHXJbnmCxL+S6K+4cUmP7L3QmWZ8UsEo+Givj3/YonGfLqwLsG7anlQNLRDW8gQQ+Ix9o9oxbBQ2RwSxDteduoz7Ps44pKJBXRd2tKPSbEBDlDT9wWTGXgMVF6asAYBhuxiaOlMVroVoyR2xEJcbVXrtn+947mRSDySjklZkq+t11sboXgQqmBplLRcOvEQUZe2Nr6ZvwZbzyMY5RKCtTJIk7sFaTq8YR2ZgbOqAFv0pyihOU+n2/7PC0UaEly5LO3wjaOjWvIUHjLwwKoJ71HrcvE4e3YRtw/U0v3VfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEGK3Mq3y7aMOQld68Py9cdjPq0T3RJIg4xD+G8q5Nk=;
 b=lY4C/O45GOT8svylGN0ePvqpAleleG+peSBvZUh93JwIFtWJftj8lrpA7rV1CT+7Gnp2x5Al5CO3yik9id5ghiJwrj/26+xqxJGjqL5IzDrW34sHdHDBZQ1hWBeCQ45I7HM5pY3h4aWmrldtnlaDNzewhnriD2oUonrXhotXHmE=
Received: from BLAPR03CA0140.namprd03.prod.outlook.com (2603:10b6:208:32e::25)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:14:57 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::c) by BLAPR03CA0140.outlook.office365.com
 (2603:10b6:208:32e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Fri,
 14 Mar 2025 04:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 04:14:56 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 23:14:53 -0500
Message-ID: <28267ba4-94a2-4a77-9c34-7273a102c183@amd.com>
Date: Fri, 14 Mar 2025 09:44:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] sched/fair: fix tasks_rcu with task based
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
 <CANCG0GehTMm3sbtXMy9MMFtG=kPYpHiFwy63OO4+dmXh68bWfA@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANCG0GehTMm3sbtXMy9MMFtG=kPYpHiFwy63OO4+dmXh68bWfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 374c0ba4-ccfb-4e09-a6f2-08dd62aec795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emdER1FoaUlUdXRKV2ZwU0ttUTRSM0tVVi96QnRDYWRVczZnNjg5czdadEtP?=
 =?utf-8?B?akRiVVozT05HTkl2YkxwOVZRRmRWSnRETlF2N2RSK3VRRytjM3ArV1lkeVVv?=
 =?utf-8?B?UkRHdWFUQWgxN3ZpNTBrWC92MnF1VTdPUVBDMUs0LzhWYnFaaktKQjJvb090?=
 =?utf-8?B?WERJZ2ZlanV1K1k4VEZNZDRiQXRvZjRVRGV4eHQ0Wld2aUFmQ2NFYUlFRUhN?=
 =?utf-8?B?Y281ZlJzM1J6cm1rU3o0MEozVkVaSnVGM0x3UG9Tc3R6b3J5VS8ybGthVE8v?=
 =?utf-8?B?dStWQlNHMkQ5SEQyYXp2WnFHcGhzZEVjSmFxNHR4UjcvYm5QaFF4TXRJY2ZZ?=
 =?utf-8?B?K0hVUXVQdlMvK3hXTko2YkROc3RDem9WRTBjdXdUdkJwbkhXalZRL3pjLy9R?=
 =?utf-8?B?Q216NHRhSmF4RTBWQnVkOWVkbzZhN1ZHVXlrZG1rWGkreWJLbzhBdE1lOXFE?=
 =?utf-8?B?azMyZE1NMHhvMWRhVkxKMDRtZ3plUmVYWHA2RzB0Rm9xNGVlL25OTG1pdHQr?=
 =?utf-8?B?NlFnT2dPbVd2bjNTdzFlUnVnRlJ3eVoyMWR6VGtEbUhQNVB2MFcvNVc2SnpW?=
 =?utf-8?B?YmY2V2NCZXhnVWRwTzIvTUJlODJQYnUzZFVRbStJSm5tVGNXZENLeEF2ZGYw?=
 =?utf-8?B?Zjh2S1g3MTR3blArQmVHZnppamZrM2gwUEdNMTcyb0NhcnlaUnUwTW93dEJG?=
 =?utf-8?B?N2FmL2pxT2RZY1F6MFE3OStMNHlQbUhzbFBubm9RWjU1R2pFUUd6ZmVlZldT?=
 =?utf-8?B?RGNJY1phWlV3MmZMWE1qZ0hJV0lWN3ErTzZxUUlMZmcrcGFtQ3VjSzNTTXI0?=
 =?utf-8?B?ZUNqVklGUjYxYnhzYWpnSmhWcEtQZ2REZ2FVWTBsZ1lzMWVsNDBtRERWeHR0?=
 =?utf-8?B?cC8wYzIvb0Nsa09GT2FiR3RRRnFuM2RxRUhxclJHL2UydjhlSjRSY2x0VStP?=
 =?utf-8?B?bHhXakNzM0tnMkp1QlpKTWd1cXZZLzVITGZrL1prYThUdG5DVGEyWVl1c1RT?=
 =?utf-8?B?MWNMMEsyaU11bytaRmdpY1RMYUUzK0ZGNUg5UzFkVG80Mnlpb21hSVVBVFkz?=
 =?utf-8?B?SkZJL2kyUHVZVWRDdFF5Rms4M05LVjlTV1dxbjBPSmJhMTJHRU1vL24rVW8w?=
 =?utf-8?B?NzRWQS9wNXVzYU1pM1Fpc244NnZicXBEVEpvWnNLbVJPOW9vcVlMVlJwakZP?=
 =?utf-8?B?TEFPeDQ0Tnk1OGhndCtPM0tvajF1bWlTMVB3WVN0UWh3cVVVeXJFSENIOWZq?=
 =?utf-8?B?aWV1L3pMZFN2UGtRYy9KaC9SNklaNEl3Yy9VRXI5b0FkdjlqZ3JpUGpWQmF5?=
 =?utf-8?B?eGVZbUdFS0RFTDRsLzdkZnRJNnNISG1tbkRnWENKV0VNNUdCQy90VHVjSGty?=
 =?utf-8?B?cDZvclNOa2oxR0R0QU43KzRqR1RITU9tbllhN1lkaWQzRTJtb2ZmSGRjd3cr?=
 =?utf-8?B?dFdlQ3YvMklrcEFaczVWZWhUVUFZR2V1ZTdIalNEUkIzd2hvN3E1TnpvbmRT?=
 =?utf-8?B?eEV0ejA0d2praUErL3MvbzB6MklOQ0t2cnp1S0lJM3UwZUJRWEpUSk5wa3k5?=
 =?utf-8?B?d2swMGVDdGF4ZjRjVitqdVRDK1I4eCtLUWx2YlFGK044QWVzcHFiQTN2cjE4?=
 =?utf-8?B?VkJGUHVlM2dBQVhLRndzZ3ljZXNkci9WZ0JWcUlHcm9PQXF3bCtRcUoxZmwv?=
 =?utf-8?B?OFh1TVpRdFd1MU9SRWhwTVg4Vk12emNtVFdJWU5SUWhsb093RDdFUXB2WTZW?=
 =?utf-8?B?eVpIbWo4c0J5V2Jrd3ZLUEVWVGNDczJEeEE4R3I3R05KbTZpcVBvVTNjSDlO?=
 =?utf-8?B?MktxeVpPZDZWSTIwVzBDSE1IOG81alltclZhV1ZKYjg3M2hOK2JTNkNWbGd0?=
 =?utf-8?B?VGFkb0xCM3dDaGs2RzJDMFhKR01wRjdLbFpJWlp1YUdJZk9XM2JSS2tkc3Rs?=
 =?utf-8?B?T0tKc0NoQ2tUTWQ2a25GblhyWDRDTU16N3FSNDlIVEc3akZzZGZmU3NHS1lr?=
 =?utf-8?B?U2dZZ3JBWTdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:14:56.8314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374c0ba4-ccfb-4e09-a6f2-08dd62aec795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371

Hello Aaron,

On 3/13/2025 12:52 PM, Aaron Lu wrote:
> Taskes throttled on exit to user path are scheduled by cond_resched() in
> task_work_run() but that is a preempt schedule and doesn't mark a task
> rcu quiescent state.
> 
> Fix this by directly calling schedule() in throttle_cfs_rq_work().

Perhaps that can be gotten around by just using set_ti_thread_flag()
resched_curr() will also call set_preempt_need_resched() which allows
cond_resched() to resched the task.

Since exit_to_user_mode_loop() will run once again seeing that
TIF_NEED_RESCHED is set, schedule() should follow soon. Thoughts?

> 
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> ---
>   kernel/sched/fair.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f26d53ac143fe..be96f7d32998c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5847,6 +5847,7 @@ static void throttle_cfs_rq_work(struct
> callback_head *work)
>   	struct cfs_rq *cfs_rq;
>   	struct rq *rq;
>   	struct rq_flags rf;
> +	bool sched = false;
> 
>   	WARN_ON_ONCE(p != current);
>   	p->sched_throttle_work.next = &p->sched_throttle_work;
> @@ -5879,9 +5880,13 @@ static void throttle_cfs_rq_work(struct
> callback_head *work)
>   	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
>   	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>   	resched_curr(rq);
> +	sched = true;
> 
>   out_unlock:
>   	task_rq_unlock(rq, p, &rf);
> +
> +	if (sched)
> +		schedule();
>   }
> 
>   void init_cfs_throttle_work(struct task_struct *p)

-- 
Thanks and Regards,
Prateek



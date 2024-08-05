Return-Path: <linux-kernel+bounces-274133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0369473CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6971F21486
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591BB13D250;
	Mon,  5 Aug 2024 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VQncLP5W"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2763FBB2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722828076; cv=fail; b=Wr8muRGbC9vaCqUXByt19ANWsUWS7eJKSRY+XTV8LCucBz0pK3k+QUHBxcEmfIBiwE3OcJc2TmBR62h2CJuYrDMni658ckmgkPZk+aA8kb5cIrmkMK1MH4MDbVsbvQlUnA47RZ7wBB0GdA5RHciUTncNbLx5PxaQctG11wZlP9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722828076; c=relaxed/simple;
	bh=Tn1+zuIxq6F1SUg8CgBBYihJTYM3x2RFIozEziTlGQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XOp48m/un9JT+aC5Bw0d65FOwz9ii4U/NLGD8BGTWRu3fi0A0b/gQQnqxDK/iiHA5qjhi+zxpkAR+sIZa/mFr2kvVvOc/Aj53c4cre2lY/QNsQeA+q9zpiu8moUBTK0rqfkxjThVcBwNT7QJvTTzV9J2nxJ7fvD3rJ86wD4yjRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VQncLP5W; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQJIXxsgAeK69rARnUxFpjZVp/KmMIEdFM3RQr1/mdR79NXkdib7UH25ay/m9qIutoIfpqYrzh0OwbCIFuFy3i+aeAKmPWF8hVFlpJ8SpPkNhzTM+6incQQLvuIkPGIhW8atdRoGKLqi/g0Gin6dPE1Vyy/AUo8sFyxI0KZ+68cXnwmGzbar4+jV7QumtF37iJi5XoTi5j6ylf6bKQb9T6wegHTQQ0nLqKFsbwdFhhxQelo2fCw7AkB17X5VSpjPOkcpy+BFtP2YkYw6TrwekdUl8VXVOLaYaBVTbmbAKVzJBZFEI+MTdk2YgCkOcsWRpyQWNgFSdEJEoiOsGQg11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQeY7866ToSLOD4VNIbzwEJNCSYiHuX5VnjNnIrIAVg=;
 b=e/kGozmBjUWpvHPRNo2KssA/2hoY57uECf7fiHp30pPSo89GwKAyyfYGsF3zKLLNKfZhlGQdAiN83pE6dsLjUWiHUb/sQFo+xuPlo309YO8rW5mjmeICv0yaIinxs5TVt3dgBMItlqdiw9KU0sO02J2qWANj7rPTb/Ee/sZoWow9PeSLbCQxUIDaI5PDsTQz4o0zYxuXhBvRt/1Y/Bn8SqkoLF+nCiyG6ioNbcgU9BgOPet5zSfarAvVI6VZoV+iVk4DuAm3i+mLe3koTjY7jT9wFwYhBupGGHn8lO1xqhOyiCXFtrOOLo1HCe67eztpm/l/rxdtICTE4NhT+Ycjmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQeY7866ToSLOD4VNIbzwEJNCSYiHuX5VnjNnIrIAVg=;
 b=VQncLP5WQTmtHDfkC1RlWN8Jhmiqg+1E8KaX013GIRxJasHtx9ckaHXfFyiyqZcVRLMXozISITlA7W2ldWbROftoYUEbjKHH0g8n/MuZ9d4KmbaY8ON0pRlGTINEX1l8bWV0yp44E3H5SwqRb6MJBh56Vd3pnUHaXbbPfPMsCmY=
Received: from SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::32)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 03:21:10 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1d) by SJ0P220CA0024.outlook.office365.com
 (2603:10b6:a03:41b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 03:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 03:21:10 +0000
Received: from [10.136.40.92] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 4 Aug
 2024 22:21:07 -0500
Message-ID: <0b8d4584-6ca2-f810-16fb-e989a0723bdc@amd.com>
Date: Mon, 5 Aug 2024 08:51:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH tip/sched/core] sched/fair: Make balance_fair() test
 sched_fair_runnable() instead of rq->nr_running
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, David Vernet <void@manifault.com>
References: <Zq2GJMEl0nG0DMyX@slm.duckdns.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <Zq2GJMEl0nG0DMyX@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5fabfc-749e-4ea1-0074-08dcb4fda71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGlWOVN5elNPN1dYM25uazhiMmJkK1RnaWpaWDZ0ZDQvUncrd3lTSmRLZUZJ?=
 =?utf-8?B?ZWQ2QTN4bXNoMjk4MFJ2MExRZ0pQSVJES0w2MThVS2FHZVd0dG5PMHduT00w?=
 =?utf-8?B?L2ZMVE5mNG1RVEpieWdlMWc3QmFDRlRoZm9OMnJwaWc5MWxVdlZrekxweDdx?=
 =?utf-8?B?cGZzQTJ5Y0JhejRrU0pHd0RxUEhCdW5BQ2VGdjB2S2xRdTJwYnVnL3RqSi9V?=
 =?utf-8?B?WGhELzdvak9UQU11SFU3R2NZZjdvMStTUG1SN1hlcWRudnJaRmxIZTc2MW1s?=
 =?utf-8?B?byt0UlFvU0k4Sy96SEtWSkFDMDJjZStZTG5DU3dTaGZ3RE9KTVRRR1AwbS8z?=
 =?utf-8?B?SExoeVJ0Wis0bUI2YXN5LzRHTjZJUzRMTTRwL09vMmNDRXNrOWh2Y1ljWXF3?=
 =?utf-8?B?Rk9JK1ozcjBDcVQ2dGd1V0lQNHR2Y29DemNXNllkV2Q5ZFFuaFc5SFdpRnZO?=
 =?utf-8?B?bHJERHREVXAzdDVoamxXSDBmaGVhbGZRSWM1S1VPZmwwY3REc00wYVIvZUJP?=
 =?utf-8?B?T3hOOFdicnRpczBpbGlWR3BQYTJnR1NYUS9XMWNxNjFmZGVtT2JKQUMxb1BG?=
 =?utf-8?B?RXZlYSsvUG80OXM3UzdOckFSMTBEUmt1YzJ0QWNObDJuZDE4VG5VKzJZcTcy?=
 =?utf-8?B?b3V3dC9qcGt0VkZrZlVUbGJEYVpndVlUZXlQWE1WanFtbnl3aGNScXNlRDZO?=
 =?utf-8?B?aGRTM01YcG10M0FjdVFvNjJ2TFloVzBKa0VmTHZ4TW9lMUE5eEUyYjluSmVT?=
 =?utf-8?B?UFhEVFVWOHlVeGZPb3U3L25pWmtTZmNuZlFhUWhHZ28zMFROMzFoVVV4WXlW?=
 =?utf-8?B?bnpUai9sc3AreHlVTXRJbDZ1bGxxSUhLUUltNzdFSHhTSTdNNUdaNExPRDFI?=
 =?utf-8?B?bnpncVF3dGZmbEE1T1hNS1JLNWUyUzRiWjkxbTg4em56M3FUejZGYzZ1L0Ju?=
 =?utf-8?B?VDRDaWhxVnhWNGFhalJWZjZpeTl0cWJXTmtNUEI2QTZzZndwR292MmNBeUdD?=
 =?utf-8?B?eDgwNmZ6Y2pKV1dpRDEzS2tmeEZqUENtcGY5S1J3NDVOTmNMRk04QXN6RjJL?=
 =?utf-8?B?MG55NjdxRVgzM0toVEIxZ3BIdVBEWWhkVDgzWWhXS3cxVW5PcnA1K2pMZVpN?=
 =?utf-8?B?cVpudTl5aG4rbFZJSjJJbkRzM01LL3NEUVNydHpQVWFGU2JOc1hCSFJlSkY3?=
 =?utf-8?B?QzNyQmZSQzZ5bHE5QWNEYjdJdmlrVE1HODdXbGVxc21JbXJ0cWgwL2FGQWwy?=
 =?utf-8?B?TmxLRElvMXNXNnJRMTRYdkVab1dqT25TVE93b2ZZSnhnUEIvc1JqQmp5anpO?=
 =?utf-8?B?V3dVeDhKOWtaNlhBTWNqVkNueTY1K1hMWHNkZWFGd3cwNG5qK2J1SGc3Rjk0?=
 =?utf-8?B?ZmFnbU9nWk5BekVGRWcrOStJODZZTFlWTnR2d3RjUXlTaHJKeE84NHAzdVQ5?=
 =?utf-8?B?TTRubUxLNzVzd0VJOVRoM0tSdjNYelhhcjRrZlQ2U0RtS2U3UHNGWUJjOGtV?=
 =?utf-8?B?ejJ4MDN1d082UEM0NTZRc1c1d0VzdThleUkxeHhuMHNRaGF1a1NTdndlanNo?=
 =?utf-8?B?bFlUOWJXOStRcS9Hc09aNUx6TFlFSUJ3UEY0NnI1WURIak5vQUY5dm80UFBl?=
 =?utf-8?B?elE2MVltQWFiNURINlFoVDhqdFVCaHpGbzJkOTdlc3NkK0pVQ3J5UENEbVlT?=
 =?utf-8?B?NjN4MVJ0eE10M0pVS2VSKzZjSTJoTXo3bGZ3Ull3TVF5YlFpWW1JMXY5SFNB?=
 =?utf-8?B?N0NIR000N2IrYXU4ZStUdUVjY1ZRSjFMZ1VqZDdZSXVyanM2L0pHd05USity?=
 =?utf-8?B?N0o3ODhRQ2VVV2d2ZExxM1JYUWFreXVTbjBWYlFIY0svU0lMWlVYSm9EcTNR?=
 =?utf-8?B?dzFlRE9aZ2NmZ2tSVzRKdFV4Ym5nOHh0bXRYQ3F1VTFZUllybjRueXVZTVlE?=
 =?utf-8?Q?AJKR3OnTgCGg/PfH67XDjkquw0gFEJ+H?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 03:21:10.1404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5fabfc-749e-4ea1-0074-08dcb4fda71c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196

Hello Tejun,

On 8/3/2024 6:51 AM, Tejun Heo wrote:
> balance_fair() skips newidle balancing if rq->nr_running - there are already
> tasks on the rq, so no need to try to pull tasks. However, this doesn't seem
> correct when bandwidth throttling is in use. When an entity gets throttled,
> rq->nr_running is not decremented, so a CPU could end up in a situation
> where rq->nr_running is not zero but there are no runnable tasks.

When does this happen exactly? throttle_cfs_rq() calls sub_nr_running()
negating the "h_nr_running" of the throttled entity from the
rq->nr_running. Even deadline entities on being throttled dequeue the
entity (or don't enqueue them at all in enqueue_dl_entity()) and would
have the correct "rq->nr_running". Could you please highlight the path
that might hit this scenario?

-- 
Thanks and Regards,
Prateek

> Theoretically, skipping newidle balance in this condition can lead to
> increased latencies although I couldn't come up with a scenario where this
> could be demonstrated reliably.
> 
> Update balance_fair() to use sched_fair_runnable() which tests
> rq->cfs.nr_running which is updated by bandwidth throttling. Note that
> pick_next_task_fair() already uses sched_fair_runnable() in its optimized
> path for the same purpose.
> 
> This also makes put_prev_task_balance() avoid incorrectly skipping lower
> priority classes' (such as sched_ext) balance(). When a CPU has only lower
> priority class tasks, rq->nr_running would still be positive and
> balance_fair() would return 1 even when fair doesn't have any tasks to run.
> This makes put_prev_task_balance() skip lower priority classes' balance()
> incorrectly which may lead to stalls.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> ---
>   kernel/sched/fair.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8323,7 +8323,7 @@ static void set_cpus_allowed_fair(struct
>   static int
>   balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   {
> -	if (rq->nr_running)
> +	if (sched_fair_runnable(rq))
>   		return 1;
>   
>   	return sched_balance_newidle(rq, rf) != 0;
> 



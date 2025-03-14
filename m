Return-Path: <linux-kernel+bounces-560673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79094A607FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FA01797A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D6640855;
	Fri, 14 Mar 2025 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1tesayRQ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F122D052
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741925003; cv=fail; b=CT2KXoF3dp48s4TnEppBElUiROySt9bsOGYgVAJvxVhRiMEK2GQi/I/iIn9r+xRFFdriyLiGu3FXW/c0rVczMc67G/XRbFMWoWnIwG50qhzvlRw5E44uELFJXkqpUaiUDw+MzSoEiSxXLl4ppnEogw0D3glcBAxIzCKftXygpEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741925003; c=relaxed/simple;
	bh=mSIQk1mmBiBrN2QjdxJIB0zeLmAIFKf7V/l2phxEXxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QuPI51KnvMkOYx4ZxF1pYCFO5BZ/GrKfZQ8M7H5LzDWJrNR6q1QeexPvs/LLvSleRzPJmc7D1A4JJgLnKe9K6YbbotJ8G1URMwJj0sRS4x75wvUNpHzlwRs1QheBnF0Ba3AXeahUY1ChBJx9OejCio3An+noxcfDGNiuVhoVPQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1tesayRQ; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPbXt2kpmTC+zNe9yl3CVuQV9sVpkkGK7KLwmbjSqg708uml5swRHjeQgvthTQi8oGCpqJ3AsmLovKM44yBkmo00U9DrV9OqB17gyry5YilxH3hAxQuHP5+kzfBSpw4wTRV1cRaSHpg1oAFR+fdt0Dk7PQRGqMtbfe/HDItwn85+hpV2tUvYfPge9sYdxKFDL2a2kSHoF11vistvclvU5EIgoMTdsDi5+KRqrz55xrrOFz/SOmb0ux7Z8adJsY2/Hw/lNHRWfCrExiSBPSGQIAx9z8CMgzh024hFjoJ4oBxgbxV0CIUtDG7C2+2bDC8Ayc4uVECcLy26qGYBRBdLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJGJqFj6E/z3XCW+1vObHEKSPfFxNtmKzcvzlxY51E8=;
 b=WBo28xVwo1IuVnFD5Ja6+8FFVAv6j6O60WTHv+czfyfxCTWXnupudYe05wlBrfNQFIW3ZG9HGqHemkgscUnIBEbbVMbhxB4ClbnGL4/AXn0u0pOUm2VGNHiAWoVlAuFbzh0AeFKE+bmn7qwMWmFh5oxT7akXC0gxdy50MpPcnrsTslP/UPXt3VNzCH5numQXly2JsU7P2ygjlarrlzSja/FrdYb1a3S8/nVD5WZkSNKqDzSmkRa83iCmUwBDTyKM1GT81EhqKn8GjBl+8B/1yN/kQVoCe3AQuRpRPRs7U3P6M7GESgyzQdVphMknSMEc0x/0K2nSfapD/ggPc3pL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJGJqFj6E/z3XCW+1vObHEKSPfFxNtmKzcvzlxY51E8=;
 b=1tesayRQu5EqQefxmY0m0wIaIhMstSvpgd7YPP93my8UrKexuF1XMOFsXMP1bUQnHo3Yhb2MycI+dPdvfyJBepHDkflycmNVeixExBDTv48vj1hmyd0va575WrrcuAEokJ1R7NxyRRmUDhieusQVSEEN6WrHmKxleGR2+QjmkCw=
Received: from CH5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:610:1f0::12)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 04:03:17 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::6a) by CH5PR05CA0007.outlook.office365.com
 (2603:10b6:610:1f0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Fri,
 14 Mar 2025 04:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 04:03:16 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 23:03:12 -0500
Message-ID: <f091f0e8-ead5-4fed-afbf-45be29db8e2e@amd.com>
Date: Fri, 14 Mar 2025 09:33:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/7] sched/fair: Take care of migrated task for task
 based throttle
To: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chengming Zhou
	<chengming.zhou@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0Gc2vAMO_5x8wYhA-=34n0vChrSdUvnd+Cf56MXfq2YFfQ@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANCG0Gc2vAMO_5x8wYhA-=34n0vChrSdUvnd+Cf56MXfq2YFfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d94ab6-cca8-4169-7f26-08dd62ad2624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejR4emVHOVBnOXBMREtZYnJWVTdGa2M3dUZIVzZodXowZ0VxU3VxMnF6bElv?=
 =?utf-8?B?amQrOFlyWjZKaE9iajNaVXgxMDhJeW1PRTNxSFNiNzNLNWRVbzNqQno1VlhQ?=
 =?utf-8?B?dU90WkFQeGwvMm5RMTFPcS8yQ1doMmxLbXVTdmIrZ0NUcmY3OTBwSllCOERY?=
 =?utf-8?B?VnV5WXlYNEdCOVdOS1RwdjJHb2JIMHdYT1lMNzFWaWpxTlZFT1dZL2dJMFJT?=
 =?utf-8?B?SnFLR0NJNTRnTmZkamx0QU5PTVBkVksxczhPY1FTVW1CMC8wL3ZDSmlsNCtU?=
 =?utf-8?B?Y0ZpcTNVZk5kOG9RMDBwWVFlZElYc0JrcGVwdnc4Sm5XdkxrUmQ4MW9qMU5t?=
 =?utf-8?B?dDZESGRDbzNPNUtXNjdoZDhUcjg0TWUvaWRyOW95RFhaRnBJU1d0MXhxNDZE?=
 =?utf-8?B?UUZiUFE5MENKVDFjR25wT0V2RE11N09kVkxFS2FwcjlYK3FWM284MlhIQU81?=
 =?utf-8?B?bnFNTWh1dTFWbUkzUW5sR3dZbHVVZ3hJQ3RlQTRqUXpzVWoyOFJHTHZES2Ft?=
 =?utf-8?B?UzRZMjlZM1pRYkFVc2FNckJ3b0NEYzhNQlFxZjQwbkNVbjNKb1ZkYUEvVjIz?=
 =?utf-8?B?MjFaeDY1OUVwZnJRSmhFdHJHY09xK2JsVjEwUDJTZURvRWt2aHNqaytteDhX?=
 =?utf-8?B?MWhDd215c1VwYndTdTF2VXRoc2xLS0t1eDBOK0FTQ2VWZjc5cEJQMEpacVk0?=
 =?utf-8?B?Sm94OHRVamZjajd0YldxWCt1aW5xR00xSnB0RkhQbCtZZ3g5SzY1TnJvUjhD?=
 =?utf-8?B?bThKNG9EdEJ6ZExESUIwTDhRNmRLOHYvN3ZyMGJZVXRWcHl3cDhUcjE3b3Jw?=
 =?utf-8?B?UmgyVHRtNkQrTUtuTFgvL0h1aU5YcTJybHpOQlVDNlFKVmhFNHZISlM3ZUp3?=
 =?utf-8?B?QW9oai9nTGpRUWdaYlE3Wks0K1VpU3JRNVNuV2tlbTBsNktLYzMxS1VaY0tU?=
 =?utf-8?B?Y3IrSXpKclFxTUdlOEdTbjM4Z3ZsZXpVVUpVM3hmUDRJS2FGVDFCcWROYjhu?=
 =?utf-8?B?R2RFRUlIOWRDRENqWXY1WjlnT2ZLWmEvQ0FmM0N3clNaSmJobzNaWlluWTgw?=
 =?utf-8?B?cXBlVFZ5MVZ0S041SVlOSnd6VGl0WVk4eGlBZThJV2RURkM5VGpZMWo0d1du?=
 =?utf-8?B?V0RvWWhqUHV0ajJkSWlpekFZTEc3Y1c3NHhYTGtITzFaNFRTVWsxSUlpSWFz?=
 =?utf-8?B?akFoOW5xK2xFZTNJeDBLMGppd3FpNHZFcXdzYnB3bkhyekt3RTJMbmg2ZUtq?=
 =?utf-8?B?K1MzNHhlR2UwcUZoZEpPekN0bU8xN3RTaVBhWEQyaE93MnRmWElCb2o3MTBx?=
 =?utf-8?B?Z21YQ01SREFPdG93eWhJcERIREtlcFBKUVNLMnJWbFdiWExFc1h0QXNmcTB1?=
 =?utf-8?B?aENEWkQxcm9UNlJ0RkJoZkI4cXVJczZra05jMk5IZWNXazhBUWxZTzdMMlZN?=
 =?utf-8?B?TEVYR25XbDVZdUJBaVErb3B3cENwN1Y1bUo1TnBqT09VQlhGVktUalJ6V0VC?=
 =?utf-8?B?REFXNDZXQ0hhL1ZPR2tqcGdLSmpIWmtYYWVwanZGZmo0S1VQKyt4cC96TDk2?=
 =?utf-8?B?WERVenA2RklNN1JSNWo3S3cwMy9ydmcwQTRnby9Zamt1Y2krTmE5UW4wT2ht?=
 =?utf-8?B?V0c4cU1GcFlzaFU1aXczYXFPbjRHSng2a2pTYmRJbVpGZUFaYkl3U2p1SjFN?=
 =?utf-8?B?Ri9LaklYZnA0QVpQTEdkWis0OXdCM0xsT01veWxVN0t1QzdKUlZUNmNNaUVB?=
 =?utf-8?B?QnQxRjlVcjVxR1JIV1NNUXZXUTRsNGE0ZXA3SC94QVd3TkJCUmZSMEt4Rmc0?=
 =?utf-8?B?TjVPWGVod2JyWHVKRjFJa1o5SXd0T1h2V2x5RnRDa2kvUms5NmRtTzljUXlC?=
 =?utf-8?B?SW4yUWhYdWhmOGdCdFNxS2FCZnF3MmtkbzZzVXY5UXRVM2ZtSitjT1g0ZHdh?=
 =?utf-8?B?cHZldzRhT2E2VE5Yc2hQZGpoZXIrRGliMldkZnJKS2VjcktkTzZRdW91QlFW?=
 =?utf-8?Q?vwSvUVUVSketM8PJBamgI+qi4qtCTg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:03:16.4643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d94ab6-cca8-4169-7f26-08dd62ad2624
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454

Hello Aaron,

On 3/13/2025 12:51 PM, Aaron Lu wrote:
> If a task is migrated to a new cpu, it is possible this task is not
> throttled but the new cfs_rq is throttled or vice vesa. Take care of
> these situations in enqueue path.
> 
> Note that we can't handle this in migrate_task_rq_fair() because there,
> the dst cpu's rq lock is not held and things like checking if the new
> cfs_rq needs throttle can be racy.
> 
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> ---
>   kernel/sched/fair.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4a95fe3785e43..9e036f18d73e6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7051,6 +7051,23 @@ enqueue_task_fair(struct rq *rq, struct
> task_struct *p, int flags)
>   	assert_list_leaf_cfs_rq(rq);
> 
>   	hrtick_update(rq);
> +
> +	if (!cfs_bandwidth_used())
> +		return;
> +
> +	/*
> +	 * This is for migrate_task_rq_fair(): the new_cpu's rq lock is not held
> +	 * in migrate_task_rq_fair() so we have to do these things in enqueue
> +	 * time when the dst cpu's rq lock is held. Doing this check in enqueue
> +	 * time also takes care of newly woken up tasks, e.g. a task wakes up
> +	 * into a throttled cfs_rq.
> +	 *
> +	 * It's possible the task has a throttle work added but this new cfs_rq
> +	 * is not in throttled hierarchy but that's OK, throttle_cfs_rq_work()
> +	 * will take care of it.
> +	 */
> +	if (throttled_hierarchy(cfs_rq_of(&p->se)))
> +		task_throttle_setup_work(p);

Any reason we can't move this to somewhere towards the top?
throttled_hierarchy() check should be cheap enough and we probably don't
need the cfs_bandwidth_used() guarding check unless there are other
concerns that I may have missed.

>   }
> 
>   static void set_next_buddy(struct sched_entity *se);

-- 
Thanks and Regards,
Prateek



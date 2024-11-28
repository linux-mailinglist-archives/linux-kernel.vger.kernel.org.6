Return-Path: <linux-kernel+bounces-424335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517229DB32D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1228228208B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A5485956;
	Thu, 28 Nov 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HqkafB9Q"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49222146A71
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779012; cv=fail; b=l+1x0MMzsTmEyv4VwLBF6UF/6zCz4RObW3fJUyMN+8zTSJIqLvxGm0hXILC3zzJRI/SjHWRiLLveg5ZNC+LN5iL9O5qHcfV0+rFnsn2Sime6MDc9vro/OwNVliZOaBmNAY+mjBKE6Gih6tT0dzpEF21wLLTfUfrYybSGpGDaZFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779012; c=relaxed/simple;
	bh=B8810IxikUxt7S0FRtAQEAdXH1QElOQjRbYSz8BEs+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SrVUfsI5Uqk6z+j5haUdpXqONowhXortm3axltCcTJLeXuIBo55vKhOfAa7HtDf7XSNrZDRkTtB3Cx8nugaCyeF4TfJUu9Y/m2HdJWF8kv6M429YaTQoLfALxF8XJ9cmobgNMryJBlAlcOtPP4sW3NPL7mcoejbW6Fs887PGnUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HqkafB9Q; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlueewgdBnxnMJ+1rT9HDXdHo7Ofd5ANup7Ooh1AB7im0ahfGi+PZ66kYB2rCvjQv0EDEL5uuyQZAPLElK5iKWtoXA89GaZg8F0gRP6D2AOxDzxxU4jUh/Vdrf5enPqGbIWjAz3btGZ/eXrUWL0pXQQcjekoTCIKhMhDvB43LSO06SXnBhNiF3xMChZKrPcM/ibBRPJ1Pdahyt47ETlaZJjRHbK0a5F15UiCDSJZ9Xq6TALsHzrIyOMSE7iyDeZtn5+DTv+ik+JM0IfHLui6OYNag9Xb3ECige++0Yhv78KdKS+ZWl1UJiz7oKdTx6SPrLBP5OGBosuq67Ao34M25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCPwlyTpkD+BQIdbsSM3S/PuGHsEStp6Q1zyF2ZjjL0=;
 b=PDsuwlZy5WXzGXFTzUumffxP0661SotF+5yEwSnZGcVTSEzyucNu9OdkWQ3zoUFnxJt+EDQ0BfAGzYbqmL+UtNqFN2vXN7QdtXiMZj5oU7hFOYgUGYHrLhrpmmuYUkeDLsfHlxYB7fIeMOPRpqUuFQA2eAw8qyKuSnq2WfSeQ7MMQOgkqgEoB/1MMSSLaI2xLQnbtjD8HTUQjeFBMtM2WQIV9OeZnxurRFQsFCX2YgMeCr1plxXWtzsE3ZWxfekOynfBw5ZrQTr/1JVu0AWoeHEJkGk23vFasGDddT0ny242Ssz/OHbScgO0SOiDLiJxy8eGeXxrSb+27KZSSdqLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCPwlyTpkD+BQIdbsSM3S/PuGHsEStp6Q1zyF2ZjjL0=;
 b=HqkafB9QHNGXRJti4RQtxZ7m+myVEZEwffu8/lCoodUaVqt+z8Yy5ntH5lCHoYKKjiTHDmk8JRazbtYQtOQGbC94a8wQez/fRjBZNqHkVM7MpLewIjVUxoBMiICiBG/VpQTMAK4CYV0jPPyt8D9c3CleU+EbBoqqDNKsGnUW74Y=
Received: from MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 07:30:07 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::eb) by MN2PR14CA0010.outlook.office365.com
 (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Thu,
 28 Nov 2024 07:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 07:30:06 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 01:29:57 -0600
Message-ID: <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
Date: Thu, 28 Nov 2024 12:59:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] sched/fair: Fix warning if NEXT_BUDDY enabled
To: Adam Li <adamli@os.amperecomputing.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<patches@amperecomputing.com>, <cl@linux.com>, <christian.loehle@arm.com>,
	<vineethr@linux.ibm.com>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241127055610.7076-2-adamli@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: fcaa8143-a8e2-4d84-58d0-08dd0f7e7b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnR1clZRUkl6VHJhcHVYdzI4V256emROUCtCM280MUwvR0hsOFZPbytIdGVL?=
 =?utf-8?B?NlZHbFdVSDU4ZHJPUzBXZ3NBTlJQUkpXd2I3MGxKTW1CQi9lL3RCWTMwR3Y4?=
 =?utf-8?B?RDdXRDF1MG4xNzR6aXM4SnRxZ1JIWG8ydXIwN1BETjhmaE1vejlnMFpwNEwx?=
 =?utf-8?B?RGp6amNwb1FwRlc0YnBjSkIwQUR0ak9oWjF5MG41TjhLZS9wNXc1a09rckth?=
 =?utf-8?B?cERkTGxzVWhoV1FQdVJwbUN0bU9CaEtQZm0weU4vcXIvVzZra0huWjlWSGI4?=
 =?utf-8?B?bEhyV3l5d2ZKbGthWmZDUWlML2IrRDI0YkltK1NtSlBNeFlDRXIwbXVicFRk?=
 =?utf-8?B?WEdmVkk4dk5TcE1MM0lQUjR5TVJodW9lTnlwVnFUT1NnLzE4bDMrTUp1WDN2?=
 =?utf-8?B?U0VCMXVnUzZDWVE1ejBDd0p6TFM5SWdYRWNTUEhzRU5lTElKOFFLWlJnS1du?=
 =?utf-8?B?Ynk1cWJVUW12S2RKdGJienRwWDZCcUg2ZW1kOXhrSUg1NFo4aHZZb3hJd1hh?=
 =?utf-8?B?T2dnT1hiUXo0Qk9sNms4dUttTDRNMzlJQXR2enhwYkVoR1QvYTlBYjdsSFc3?=
 =?utf-8?B?d21IRXMxTUxheGZ3Vk1hVk5ZQXBBRGtVVTRvQktYWU94aUdtSmdiYWxLaUw4?=
 =?utf-8?B?S2JnaXBXYi96U1hGblJjRjZpY0VsaGFVNjhrbzlxMTVVRmJsSFlSTkRGcGJj?=
 =?utf-8?B?WU1UTDdoMkVBbUQzWDNUSzVoQ3oyZHo5TmVkQVlPTE9LWlA4VjlxZ3RsSWoz?=
 =?utf-8?B?MThFWHRJclRDdW94NlIwTUJvOFJubmJxQ1pUZmovSUxIM0w1L2ExT3h5ZW1M?=
 =?utf-8?B?UHBlZkVBY3d1RlBOaHBzaUFrZUZCRnA4TTRoRHdWWDd1RHZrWGhMZHFXVjVJ?=
 =?utf-8?B?dVV0N0VrQWI2eEl3bVloMTFCRmRKaUJWLy9GaXlIcEpJcVVpUjlFK2V3VjI1?=
 =?utf-8?B?VWtsNTNDY25ucUFmdkRjUHh1WWg0dm0vTFFMSThRVnR0NkgwaHo0ZTBjc1FH?=
 =?utf-8?B?UVFTdG9sWkFnTFhUb3dMaVdjQ2RjYm8weFQrb2hSSDdrZkhYbExublhxdC9t?=
 =?utf-8?B?TzI1MWlpT09sVWpnZlpwVVRYVWZjeDVLeVRwVkYxRmtOZFRIZC94TU9sTmFU?=
 =?utf-8?B?ZUw3Rm1TUnZjTFhHUVFZdE53RVNwbmNvTFZFeDg5MkNlZmtya20waHRDQXRF?=
 =?utf-8?B?SC9uTkQ4T3NZbm1oVHk1N0g1M2o0ZDZwN09HbEJpNm12Mm13OVYxQTZXNHp6?=
 =?utf-8?B?a3JmZCt1bDBxUU4yUk9GTHVDZ3R1cm1xUlMwTXA5WlJhOTArYmJCSTJybFhK?=
 =?utf-8?B?WmR5TW5USjg4YWMyblU5RnlSZGpkL0xlWHZRemNVb3Yrd0FQUVF6Znk1dXhB?=
 =?utf-8?B?TXVpaGpXV2dMeHlDR29hSTBFMkxjM2tkbzVKbEdiaWtJcFNCeGVPM282UWNn?=
 =?utf-8?B?dWJEd25hWWJ6T3R2T015TDZHWFFhVDVCYWxYWkpQaTY1MjJXa29sSWlUY3Nh?=
 =?utf-8?B?a0VWYmhXTUExQndBcU5WbUt6L0J0eXF1b3R1ZGF0dEtkU2U4T1FtYkpPbjF0?=
 =?utf-8?B?anNGQWd3dUFjY2VEV1puT1Myb0ZHWnVUQ2IxTFhYZTNmZSs3a05ERnRiMXgx?=
 =?utf-8?B?SVJXaUoxNk0reldRNUhTS0VrSmc5c3FUNFJUWjBIbmJ5Uk13ZXFPOWY4MnBu?=
 =?utf-8?B?NWo5ZE16UG13VkIyK2hFdm4wcmlSQjhjcjMyamxCRUwrdEV6RnJDMkhpS08w?=
 =?utf-8?B?QVZLb0Zkd1BuUVFXaTJUMjdkcUhBUUVhM3VsTW5TL2Jpc2pHMHdjNzNqd0JK?=
 =?utf-8?B?aGczZGNQaHNTd1VjaFlHZ2RlRVdQWlJIeHd1eW9JMHRKOCtNbTdOZy9ad2x5?=
 =?utf-8?B?ek80MXlFM3BleGZydEkzWFU4L3JleVovWnMrNTRMc29jV2J3MmpIYUV1STBy?=
 =?utf-8?Q?zKjgfRJbs7xtbxAfehladgFHkUJY+RMj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 07:30:06.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaa8143-a8e2-4d84-58d0-08dd0f7e7b80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082

Hello Adam,

On 11/27/2024 11:26 AM, Adam Li wrote:
> Enabling NEXT_BUDDY triggers warning, and rcu stall:
> 
> [  124.977300] cfs_rq->next->sched_delayed

I could reproduce this with a run of "perf bench sched messaging" but
given that we hit this warning, it also means that either
set_next_buddy() has incorrectly set a delayed entity as next buddy, or
clear_next_buddy() did not clear a delayed entity.

I also see PSI splats like:

     psi: inconsistent task state! task=2524:kworker/u1028:2 cpu=154 psi_flags=10 clear=14 set=0

but the PSI flags it has set "(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL)" and
the flags it is trying to clear
"(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL | TSK_RUNNING)" seem to be only
possible if you have picked a dequeued entity for running before its
wakeup, which is also perhaps why the "nr_running" computation goes awry
and pick_eevdf() returns NULL (which it should never since
pick_next_entity() is only called when rq->cfs.nr_running is > 0)

> [  124.977310] WARNING: CPU: 51 PID: 2150 at kernel/sched/fair.c:5621 pick_task_fair+0x130/0x150
> [  125.049547] CPU: 51 UID: 0 PID: 2150 Comm: kworker/51:1 Tainted: G            E      6.12.0.adam+ #1
> <snip>
> [  125.163561] Call trace:
> [  125.165996]  pick_task_fair+0x130/0x150 (P)
> [  125.170167]  pick_task_fair+0x130/0x150 (L)
> [  125.174338]  pick_next_task_fair+0x48/0x3c0
> [  125.178512]  __pick_next_task+0x4c/0x220
> [  125.182426]  pick_next_task+0x44/0x980
> [  125.186163]  __schedule+0x3d0/0x628
> [  125.189645]  schedule+0x3c/0xe0
> [  125.192776]  worker_thread+0x1a4/0x368
> [  125.196516]  kthread+0xfc/0x110
> [  125.199647]  ret_from_fork+0x10/0x20
> [  125.203213] ---[ end trace 0000000000000000 ]---
> <snip>
> [  211.151849] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  211.159759] rcu:     (detected by 141, t=15003 jiffies, g=5629, q=26516 ncpus=384)
> <snip>
> 
> Do not set next buddy if sched_delayed is set.
> 
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
> ---
>   kernel/sched/fair.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fbdca89c677f..cd1188b7f3df 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8748,6 +8748,8 @@ static void set_next_buddy(struct sched_entity *se)
>   			return;
>   		if (se_is_idle(se))
>   			return;
> +		if (se->sched_delayed)
> +			return;

I tried to put a SCHED_WARN_ON() here to track where this comes from and
seems like it is usually from attach_task() in the load balancing path
pulling a delayed task which is set as the next buddy in
check_preempt_wakeup_fair()

Can you please try the following diff instead of the first two patches
and see if you still hit these warnings, stalls, and pick_eevdf()
returning NULL?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff7cae9274c5..61e74eb5af22 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5478,6 +5478,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  	bool sleep = flags & DEQUEUE_SLEEP;
  
  	update_curr(cfs_rq);
+	clear_buddies(cfs_rq, se);
  
  	if (flags & DEQUEUE_DELAYED) {
  		SCHED_WARN_ON(!se->sched_delayed);
@@ -5520,8 +5521,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  
  	update_stats_dequeue_fair(cfs_rq, se, flags);
  
-	clear_buddies(cfs_rq, se);
-
  	update_entity_lag(cfs_rq, se);
  	if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
  		se->deadline -= se->vruntime;
@@ -8767,7 +8766,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
  	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
  		return;
  
-	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
+	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
  		set_next_buddy(pse);
  	}
  
--

If you are still encountering pick_eevdf() returning NULL, there could
be a larger issues (with eligibility computation, etc.) that the second
patch can hide which can lead to bigger problems later. Thank you.

>   		cfs_rq_of(se)->next = se;
>   	}
>   }

-- 
Thanks and Regards,
Prateek



Return-Path: <linux-kernel+bounces-429877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9840E9E2805
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681E21621B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFE1F8ADB;
	Tue,  3 Dec 2024 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xHqiBuTW"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAC61F1313
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244535; cv=fail; b=oEuIolCRlEbbsfzU9034lo+JXd43iWjBHu2UbzHq9fBSM+Gb9aaHCKDdNnL/Lvq1Qv9MR6dixW9YhNGM3OV8WAecauGeT738TWqrojdm+oREQQdRk6wsXeNZ3JRkrF8QkoL5ZXrAo/OT1rKMj6VjnLRAeuMKQYMTgwPKxTde01Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244535; c=relaxed/simple;
	bh=oE5bRxYjnUZWTxXAewkqOKkhkTKGk5snsMz/2uAb0Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lOsAl+amjy15R40WIq9pmgK7FiliRE1+4wmftrNynLdyhDFc/PvuEoDVjQifJx2RSEB11TOs5C4RwGwH42OTHjjxe7aLZzR6lY+QWmqjVbi8NQdnUjly1aeNfLSs9Y6sP/UP9l6tcLjeTIjeX+9g/BPCBCVsnXzIeYezZlPfxys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xHqiBuTW; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNhrAj9sgXeOc8OXda5CFgqStsW0Opn9Vw3cMXHgArR2kYPfdYBOo0DkQZE0DsVMVmdwbW5CQC1YcxOnsIxG4e23uaa94nx3qL75xVYIPB16bn3HncoLu1wm9TsWTOgucV1e5Jb238k786XIV1QoP8T3n8WbI8n5NH7lnTwIbfab2Dy3p5LA49RT8W5MCXmFFv3baMvWghvQD9G6AFYaV0iy/k3e91iXI8odcjm4nue1MW6dQBATAb4Or/6sWy4R4B1YFM5EGHhYBRoro9XMxlJXBHPLamRBwb2/T5UyEEsOCNUxphtCBBfbAV25DKKyXLZhV7+FsrB6PlCcx5qrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1MH1/37qx92ctZzQutfeYzj8cA/5VJ5US0fj0pBGbY=;
 b=uIQuofSasDmtSVYrwIo6PI9e4nYxwF6b8BXtQPh/W0HTjXUBL6poZLtGDSKm741OzbwhI+Sj35PQ+ymBnab39Wf/M4OgUxrTkv5JZrd6Wm89xq66psqz23LAxSlJLIs6THjEHtP6uqHmdwKo9lZY3pxRsoUlooscbM8df3zGmQ8VNg21PSkXsmz83jx4/SKIWB/153gQsbiSMOz5vyGumyWIHHMQeLzrktVJlBB7LAd8zU7cUuX/dfcpVoggTtP7F9r+aV6yoGJvDg33bgm7xsr9vcWFgky/HyrYSm5JfEwFTxWg8UuA9865DxwGiIJho1XJTRpLLB//JL60bX6eYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1MH1/37qx92ctZzQutfeYzj8cA/5VJ5US0fj0pBGbY=;
 b=xHqiBuTWOQ4XfPePSzg8WQBknQO42HrQgdhaxE7O6isyGxzlWxkU0GCp6PzOpvwKBsKKIIKv5WBh3TkFInzCrgBTOdsgyo9WpKcsfHJncv84Ecy71dDgmFDetdULuuDwC8ELNj324DxtQfrP5ktdjDAH8QliMSlO+bHknM9AQBs=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 16:48:47 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com (2603:10b6:408:f5::4)
 by BN9PR03CA0285.outlook.office365.com (2603:10b6:408:f5::20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.15
 via Frontend Transport; Tue, 3 Dec 2024 16:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 16:48:47 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 10:48:43 -0600
Message-ID: <d1047c7a-4e94-4ba4-a9a2-d2ed6778be8f@amd.com>
Date: Tue, 3 Dec 2024 22:18:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] sched/fair: Fix warning if NEXT_BUDDY enabled
To: Peter Zijlstra <peterz@infradead.org>
CC: Adam Li <adamli@os.amperecomputing.com>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<patches@amperecomputing.com>, <cl@linux.com>, <christian.loehle@arm.com>,
	<vineethr@linux.ibm.com>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
 <20241203160514.GI35539@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241203160514.GI35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: f253af9f-cfcc-4b2f-3f69-08dd13ba5b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHNYaWhZQnR2b0FBQThyMThZcEVtWjBWdURGaW5Uc0JQZ2o5VmpkOURZQU4x?=
 =?utf-8?B?QkhvSUkrdDVkeVY0NGhaVGpCR1lTQkhjZmNtZ1JrRnNzQXJLd2pWVGhIU3R3?=
 =?utf-8?B?c01uc2FzcXlkUlAwVmdoUGcwSGk3dzdrNTJFVlBFaHJ4bHRCUXVOQ0NQZ0pI?=
 =?utf-8?B?enQzNFVGVTM0SVBZTGc3T1pGenk0dUNSQkVteXlsVndhVWRuQjdJNjQ4WGRx?=
 =?utf-8?B?RFdxNjgvR3hWT2RXd1g0LzFDQVRpYjdWTXNMaFNkekNuZGdsTmNKZy9Ba1Z2?=
 =?utf-8?B?eUdYTmF4d1h2N0JhT3ZGZmwyL2VHcEc4SkxFWWVrMDV5Ni9PczBOVkdIRUtq?=
 =?utf-8?B?QWRSNFZKSFhZeVMyRHowL0hqTFVwRDhIdTM0SklTUklScUQrUGFXdWxNMCs3?=
 =?utf-8?B?ZU5JZmhYUnVPL0lVYy9jUUgrWDN1bjNVY3NGOTMva2VxNk5FL20vVHZpSno4?=
 =?utf-8?B?N0p2dzFYSGFmL2N1NE05TEtKRmhHWklnNDlSR2REMmVEWGNsdmZmWW5SR1F2?=
 =?utf-8?B?eXVPbThVK0QyaDhMNmMxRGphWDNHRk9hQkdBWnNQdWxzNEFmUThjeXhyb2ts?=
 =?utf-8?B?WFZsR2U1WDl5Z282Zm9MZ2lVdGFOYThRbFJxUkIxTDRncUpxdHl2eDJCUGNa?=
 =?utf-8?B?Nko5NWwxUWlnbDBYOExxcVh3TkJCTlQxbVAySGVlWmtaV2IvVDNSS0hOa0ky?=
 =?utf-8?B?VWNuOXpESkZyY1ZhR2dUeW4yVmtLQmhPaHF2SEh1bjVqcXRSYm5QcXVLRzVR?=
 =?utf-8?B?dGpLcFEzRmV2Q1BleUNDWFZ6THJNbWR0RmFOS3UvUjg5OXdjRjZib01BSjlS?=
 =?utf-8?B?Umc1angvU2JNK2Jvekw2eUVnQkE2QWh0Z01OOWgrVkdTcHhmWUtLSGdLSmp2?=
 =?utf-8?B?enJJQTlQRHZVdzR1ZURZcHlOMVIvRjFNVURqdnM0YjdnTXlhRHZGeHZ0cjVE?=
 =?utf-8?B?b1ZhTjU2aU52VHZEajgwd0tLQk5yYmwra3Z3SGFJRmpnYmc2OGVHa0ZZV2Uz?=
 =?utf-8?B?L1NUQ2p2cmNBTEFHbFBheWhuRU03SW5oNXl1UmRpME9EOHJRcUtmT3dlSUwz?=
 =?utf-8?B?QXErZGtUQ0dzNWdnUlprQ0JjakFjelVHa0VRTFhUWTZaNE8yajVPTUpoYjVq?=
 =?utf-8?B?TGc3NGllYVZYNDdwUjFMdFJHWTlROGErenF1RWxnazZ6cWhuSlNJdnpBZjRw?=
 =?utf-8?B?YVZ4dnovQ0VIMmZFR241L3RoYTU5QVhPTlkzMVRKUXlGTVJpcW1FNTJsTGMw?=
 =?utf-8?B?alNXSGhnSmdvT2hIUnBJWlpQWjYzZFhKYzhHa2EyT3cwQlRoc20yV29JQ1RL?=
 =?utf-8?B?Mk9EYzkxZ0JCVzBrVUdaRHNpWFVtR1V6eDZyTi8yeUFsODBaK0ptY1k2RUdZ?=
 =?utf-8?B?elhRSTk0dnRCcngyMFdWdklMNi83Sy9YRnZ3M2tiMlE2WnJrTmcvRWtWM0p0?=
 =?utf-8?B?MU1yV1RtQ3pqNGdGUlR5cW5LWWpYbEFjZFh0cXg2SkxsN0RWcERyY29yNWJv?=
 =?utf-8?B?dzJ0dnpMT0N1MGEzNGFPTkFKMlhFNXVPSmt0b2VpZ1FFa1BQQlFDUWpFVmdM?=
 =?utf-8?B?VFJPdkhpZDZIMmI4OXFLeWhCaHNCU0JNSnBvYm5yRVJVZG1tRHM4ZXJ2eUZS?=
 =?utf-8?B?VGhQdjloc3E3OW9Zb3Z0S3NHMDgyTGkra2ZISWxwSld0ejh1RG5lRjRHWWR0?=
 =?utf-8?B?WnFYaGpBdTNNMktzN3p2bTJIZ00vY0hiOFc4TEVJaElKY3orcU50a3Q4aVU5?=
 =?utf-8?B?bDA2ZWpZaW5BVmZ5WnNUZVBtNjMwSng2bzlINTc0enFoSUZKRUlFTG5PVGMw?=
 =?utf-8?B?UjRqaWdVdUwzV3JkUmxNTllIbVg1RmVXd2pTcDAxazcwV0p4NVZES3Y3cmFo?=
 =?utf-8?B?bVBKcjUzVU90Sk1tZ1YzT0Fvc1NDcXZTTXVjdGttRmNzVVNjOFMxUUlUdXdq?=
 =?utf-8?Q?XtZUv18+Zoh61TCwdk5BM+USDlJZLYJc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 16:48:47.3445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f253af9f-cfcc-4b2f-3f69-08dd13ba5b5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052

Hello Peter,

On 12/3/2024 9:35 PM, Peter Zijlstra wrote:
> On Thu, Nov 28, 2024 at 12:59:54PM +0530, K Prateek Nayak wrote:
> 
>> Can you please try the following diff instead of the first two patches
>> and see if you still hit these warnings, stalls, and pick_eevdf()
>> returning NULL?
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ff7cae9274c5..61e74eb5af22 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5478,6 +5478,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>   	bool sleep = flags & DEQUEUE_SLEEP;
>>   	update_curr(cfs_rq);
>> +	clear_buddies(cfs_rq, se);
>>   	if (flags & DEQUEUE_DELAYED) {
>>   		SCHED_WARN_ON(!se->sched_delayed);
>> @@ -5520,8 +5521,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>   	update_stats_dequeue_fair(cfs_rq, se, flags);
>> -	clear_buddies(cfs_rq, se);
>> -
>>   	update_entity_lag(cfs_rq, se);
>>   	if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
>>   		se->deadline -= se->vruntime;
>> @@ -8767,7 +8766,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>   	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
>>   		return;
>> -	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
>> +	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
>>   		set_next_buddy(pse);
>>   	}
> 
> 
> Prateek, I've presumed your SoB on this change:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/urgent&id=d1139307fe97ffefcf90212772f7516732a11034

No objections from my side! While at it, perhaps you can also squash in:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ed4af8be76b..eadcd64c03e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5519,8 +5519,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  
  		if (sched_feat(DELAY_DEQUEUE) && delay &&
  		    !entity_eligible(cfs_rq, se)) {
-			if (cfs_rq->next == se)
-				cfs_rq->next = NULL;
  			update_load_avg(cfs_rq, se, 0);
  			set_delayed(se);
  			return false;
--

Since we do a clear_buddy() upfront, we no longer need this special case
for delayed entities. Tested it on top of queue:sched/urgent with
hackbench and I didn't run into any problems / splats. Thank you.

> 
> Holler if you want it modified.
> 
> Thanks!

-- 
Thanks and Regards,
Prateek



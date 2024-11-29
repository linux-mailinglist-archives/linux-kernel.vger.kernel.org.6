Return-Path: <linux-kernel+bounces-425849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66699DEBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA5F163A58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6519D084;
	Fri, 29 Nov 2024 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gsvQ+eHJ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9E13D520
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732902424; cv=fail; b=P15/ewU614rM7N6flgQPprICI0/EpXGUXv+aDJlnUew2ef8j9muzg106UgQqP+zVOgmMgEeF86xnblo78lc9Y1zSUAux40M3NTkR06W5rxlB16ID94kgWww7GJfqD1K03x1yDDwrNsKgbYpbfxreIpyZlh4Qm2nADVonJs+eaFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732902424; c=relaxed/simple;
	bh=pZLKu87X2Ajy1mfDXiTiDVnwBm0gfnYdj7IFVpcaNuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CP+4qIlWJQabdZv8EgL7t2O8+3eo3zcM66Pk+lQs/RbsfM5ZdlVn9IgsE7pxluYvWKOORc8KCm33qvAXvZ4TPxmPqlt9PLScMtZVDvcvOw5agK4DNLIsaDHo9PzKcUKw66TgVaok0qhmmoBuDpLRBHcOFY2vrBx1fmKQd8mNRP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gsvQ+eHJ; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8U9Gvt18dX0y7T2dc8zbpbA9Cy+QwTmFa7NbR8nNL7GE6KNNbwbG31G6n6JEEBOuF6EDp05Up37VN9cQsXrp2Url4TP5wZk+gJ3XvfXNeyhsr0/hEWiaZqD8hYa/RH2f7+srwynGjUhjOoL3p3haa/EQw85Ex8fGu5Tgw3MjpGUQHO8nJsnU32Zd2T3LNPcRgRCEdjUfPklP1aSWQtuHb0K6aVGR5PH/oLbUHo0m8N5OCXtY4ZcTScDztkMtclA4INZx3IenN50lT3pKtRUQuJA9NfO3JgOppJ5lwXRNMJnb66yi2AOr2oEZdlPZWxCoM7Wq1fH7xMHh30fQzXAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYH6ClKjShNsz+KCMMylIs6ClfD4FUsSL8Ld+a4EMGk=;
 b=kld7oIA0jyaCd6uTZdWc0PNIEC/2fqKNcCSqZLa2QQ0EoynTsmseR9XCg3YQD7xqZAT7JefnMQFJq5KuL3cVkDmYzy45C3mzDKuIj1AYO+k6vs/o2+iVNb2LdqGb/SBM2bPB+lLMJ/Q0Hrzs23L2obC59MF86KRvuEsTz0y4wFAR+GPmSf5zBdpiZj2vCAiup4Led3kHZsDqo10sndZb+i2IbIjgqXYI9tTZgRMnU6zcESYv5vgpJPCokO7qYW6AcpnN0A+2xO/eMhVlb4nYPMEKF9MY5JedZgk/CXxsxiK411sY2MDZvh4xU+i53Bk7PacYf8zxZxFWuWSMAJSe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYH6ClKjShNsz+KCMMylIs6ClfD4FUsSL8Ld+a4EMGk=;
 b=gsvQ+eHJTkFOt7y+8gdvmD8hMvy03mAXvXEzqoaygxBSMvjF7W8NF8CGEU1/BfTy2YmHkin2Yt5YvVUDblPfyp4om+X1VSB31VVdN7aUIH1d9Hl5Y6AozHcW3uRjsCzryMS3NWVNawr94Rbdadbn+nkml6iBw3DAXB0FVYEARZU=
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 17:46:57 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::8e) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Fri,
 29 Nov 2024 17:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 17:46:56 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 11:46:50 -0600
Message-ID: <6683a7dc-b83b-489c-bdfc-ad225ab816c6@amd.com>
Date: Fri, 29 Nov 2024 23:16:47 +0530
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
 <20241129095500.GD15382@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241129095500.GD15382@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e27acc3-ba64-4766-f71b-08dd109dd16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzhrRngzOTBhNWhjb1NoYkE3eFN3L1JBay9IUkl6Q3hUdXZqQkxPQVBBdzdY?=
 =?utf-8?B?bUl3WjFweFk0cW5mdllWUlJoa0hqTS9tUS9qSkFYTWFkNWxpRU4xTURYOVp4?=
 =?utf-8?B?M0JpRTgxeTNJOHUvOW9VZFQ3S3hnckdjNnR3S2RmcVgxakI5dmczVFo5L0Ur?=
 =?utf-8?B?YWF2dHZ2QXhQME5GMHI2NlpqZUt0VmdvQThMQ2FSRzZFRWJ2NEJMVnJzWGhZ?=
 =?utf-8?B?UWtDeDJXWkZPc1NoRUpvd0o2YVV0cGJNYWlsRUs2M1Jmc05jSlhBQmZNb0x4?=
 =?utf-8?B?UlAzVWg1akJ2R1RHcHlGNWNONjltUXJvY3orUkkyUzRzNkJtSUduWmRCNHhY?=
 =?utf-8?B?VFVlNU82bEVNbExXbEZMV1NmelFNcUpheXRjRDNJeDNwY09KdFM4QWRveDB3?=
 =?utf-8?B?bHY5NFdhS0c3U1dMTUY2aU5zK2sxQnJSdnZyb3FJWmVtbmRJckh5M3Z1QXlI?=
 =?utf-8?B?aTF4eHRkVGE0WHQ2REFPR2dhd1VGNzNPUTI1aE52WWxFME9lT21JSjR5aWt5?=
 =?utf-8?B?SUdXZFBZZTEzamlzZ2lRUC8xM1BVUkgzOUpUUDFBeGVPek52dmJDNHo1aDRG?=
 =?utf-8?B?U01zQ2dIZVVwMlN3ZzJ0UlNtNWxtbDd5UlRRMkc3SVdZUE9nOWRtTkFmMG90?=
 =?utf-8?B?U1gxZVBLQVV2WmlrVkRTOFJNUi9ZZUdETUtjYnNOR0RoNVJoVWtjYXhGOVNj?=
 =?utf-8?B?ZFNNU04xQkR4SlVZam9TbkU2V0RmN21JV1JPcGNPaW40N25TbmxqNzVRbTcw?=
 =?utf-8?B?NlpoRmI1Q3NhV21zMmRublhiV0daSEx4Z2VTR3ZEVnk1TnRXWkxyS1hIK01T?=
 =?utf-8?B?NkMxbVViQUlMbGlaSjVoMzRlUjNjZ3M2ZXE0Nndkam9ZZmxNMVBnNW1wSklq?=
 =?utf-8?B?dFdJT2xNZmZ2NEJYTHVZRVpVSTVGRUt0NVdXQ2NQN1Q5ZmtpK0FXMzR0OWI3?=
 =?utf-8?B?eldQc0VuVWNmMFVVbjZDd05DTVgyam40Wjh5REVXdGtSRS9Ca1V3bE1aK3Bw?=
 =?utf-8?B?cDdqWmxYZ2dwSm96ZXZrc2ZhZVhFWmR2eDhRMlNMUGhQNzdKSnlsOEw4cUlN?=
 =?utf-8?B?ZklBTU1Ib0FIUlBJS1ZldHhqTzM1RW1xbS9pN01aUUhlc1FaZWlUa3NIVTlP?=
 =?utf-8?B?cE5pV1Z2UDRwL0NPZkhhOG1mR2MvZE1jemIzUi83OTlOYmtuM1pMSDAzb0VC?=
 =?utf-8?B?SDJoRWlldkZiZ2tmaTBkRUljTHdXTDRvck1GVTlWWDVsM1M5SEhDbktIazRv?=
 =?utf-8?B?VjZsb09MQTNVL1V6Ni9paUxPR1VWUXhOcWJsSjFBcEVMYmYrWG56VDhMcUYv?=
 =?utf-8?B?dEpneXlTMzEzSFRoRWdIMzZDYXA5d0ZMVnU0TXc1b1ArQmZwWnNkRVpkWnhN?=
 =?utf-8?B?QlNUYkcwL3c5aDZRenlNd2M1WGMyQWNjMTVOT1oxS0FUbFpIVDh0V29FUFUr?=
 =?utf-8?B?RC9uRGI3RkZPWXlYcEhwZ1d1WllBTXAwU1JQbHBUbElGOWcrb3pYQ01TU2o0?=
 =?utf-8?B?SmVab3crbmx0ZVlqS1BIRi9pbzBlUjBHUDNLc0ZJK2NzWHc1TWVxeEV0RWJv?=
 =?utf-8?B?ejYyT2piMUZaUDRzL1V5NlNWRTFsQWNhVm82UDdmN1Z0a0dDMFRMQ2RuTHhy?=
 =?utf-8?B?SW05d1FweWxFN3BnaTlJQVNYZWpmemlFeXUraXYxa3dQL0dIdm85MEIzbjc4?=
 =?utf-8?B?Q1NNcFF0S0pqaHc5WjRCWDhQZld5STJvNURYK284V3kyQklIVTV0elpWV0xD?=
 =?utf-8?B?dEZQZS9HMjZUZWhJaTBRNUtzdUgwOHYxVkQwRVpRQnd4a09MTitZQnprN01Z?=
 =?utf-8?B?Q0VLd0xsaWJUclFLdFRvOEpsdC9NSTB0SlpqbWgvbWZFaVY3OXJrRHJ4ZDFT?=
 =?utf-8?B?bzhOcmJQYnUzcXpLMUk5WmFkTS9YcXVteENoMllXNGJWVVZMeWxDdnBTdDJD?=
 =?utf-8?Q?vdnHUxpkK2WehJ0Edz5Klm+ZMx6X+dL2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 17:46:56.4445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e27acc3-ba64-4766-f71b-08dd109dd16f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013

Hello Peter,

On 11/29/2024 3:25 PM, Peter Zijlstra wrote:
> On Thu, Nov 28, 2024 at 12:59:54PM +0530, K Prateek Nayak wrote:
> 
>> I tried to put a SCHED_WARN_ON() here to track where this comes from and
>> seems like it is usually from attach_task() in the load balancing path
>> pulling a delayed task which is set as the next buddy in
>> check_preempt_wakeup_fair()
>>
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
> 
> So this puts the clear_buddies() before the whole delayed thing, and
> should be sufficient afaict, no?
> 
>> @@ -8767,7 +8766,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>   	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
>>   		return;
>> -	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
>> +	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
>>   		set_next_buddy(pse);
>>   	}
> 
> But then this should never happen, which is after a wakeup, p and the
> whole hierarchy up should be runnable at this point.
> 
> Or should I go find more wake-up juice and try again :-)

The motivation there was this splat from my testing:

     Kernel panic - not syncing: Encountered delayed entity in check_preempt_wakeup_fair()
     CPU: 190 UID: 1000 PID: 4215 Comm: sched-messaging Tainted: G        W          6.12.0-rc4-test+ #156
     Tainted: [W]=WARN
     Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
     Call Trace:
      <TASK>
      panic+0x399/0x3f0
      check_preempt_wakeup_fair+0x21b/0x220
      wakeup_preempt+0x64/0x70
      sched_balance_rq+0x970/0x12e0
      ? update_load_avg+0x7e/0x7e0
      sched_balance_newidle+0x1e2/0x490
      pick_next_task_fair+0x32/0x3b0
      __pick_next_task+0x3d/0x1a0
      __schedule+0x1da/0x1540
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? aa_file_perm+0x121/0x4d0
      schedule+0x28/0x110
      pipe_read+0x345/0x470
      ? __pfx_autoremove_wake_function+0x10/0x10
      vfs_read+0x2f1/0x330
      ksys_read+0xaf/0xe0
      do_syscall_64+0x6f/0x110
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? current_time+0x31/0xf0
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? atime_needs_update+0x9c/0x110
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? touch_atime+0x1e/0x100
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? pipe_read+0x3ec/0x470
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? vfs_read+0x2f1/0x330
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? ksys_read+0xcc/0xe0
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? syscall_exit_to_user_mode+0x51/0x1a0
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? do_syscall_64+0x7b/0x110
      ? ksys_read+0xcc/0xe0
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? syscall_exit_to_user_mode+0x51/0x1a0
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? do_syscall_64+0x7b/0x110
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? ksys_read+0xcc/0xe0
      ? do_syscall_64+0x7b/0x110
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? syscall_exit_to_user_mode+0x51/0x1a0
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? do_syscall_64+0x7b/0x110
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? do_syscall_64+0x7b/0x110
      entry_SYSCALL_64_after_hwframe+0x76/0x7e
     RIP: 0033:0x7fa8b851481c
     Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 e9 c1 f7 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 2f c2 f7 ff 48
     RSP: 002b:00007fa8ae0d8cb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
     RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa8b851481c
     RDX: 0000000000000064 RSI: 00007fa8ae0d8cf0 RDI: 0000000000000027
     RBP: 00007fa8ae0d8d90 R08: 0000000000000000 R09: 00007ffee0fdf97f
     R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000064
     R13: 00007fa8ae0d8cf0 R14: 00000000000005aa R15: 000055c2e80accb0
      </TASK>
--

newidle balance pulls a delayed entity which goes through the
check_preempt_wakeup_fair() path in attach_task() and is set as the next
buddy. On a second thought this is perhaps not required since even if
this delayed entity is picked, it'll go thorough a full dequeue and the
clear_buddies() change above should take care of it.

> 
> 
> 
> Anyway..  I'm sure I started a patch series cleaning up the whole next
> buddy thing months ago (there's more problems here), but I can't seem to
> find it in a hurry :/
> 
> 
> 

-- 
Thanks and Regards,
Prateek



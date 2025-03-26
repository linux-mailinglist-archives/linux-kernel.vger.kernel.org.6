Return-Path: <linux-kernel+bounces-576489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC62EA70FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435D71788F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBBC15C15F;
	Wed, 26 Mar 2025 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="knZAzupi"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678FB4A05
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742963854; cv=fail; b=lMaoAhbdPYKvc4jgYQhwU4dza9X/4sVBBCvKl272idzawB1p3Y0WhPRhI1HVvdue3Lo3jogr/h/pHkY+0cyhMFkbuOGJV5EVlXSkz+VayNblxLXUzeYacDjkavQnGaDjnydmT2lKYtX44I2gFb176ZTM5nHQb3Ol8vjQ31Go3H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742963854; c=relaxed/simple;
	bh=gEKoG6NEFnO6m2QYBp31o8G3AJnWCDa13cMI1ibBS4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uIIRuyrAHkNSGs5mnfXz2T0PBR9HkneqdrU9e5CmV959eMICkIvqa4qMvzoz36QkLOONsJYfA3JQiLxilpv7jn48Z9RW6erUCoPbQRkrbw535u60j9gsSIgEfQcceHv8Od9e9KoIuGMmh2ZyN6uUaP7Q2u9qhUCXkii6XHHjDWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=knZAzupi; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5YOYFXSRsmTjJVZ51CITVqG84WB7DQHqh4Nvv0QZfC1P9erQlF+yDMRxYfxce4Z+IL+ShRsAd1Pq4l/szDLmDeO4m9BpAOOqkmu/wN5ZqtuPqRFi+3xI9xkdM8Rseo8YvGzW9BPJNOdaFjFRulvruMT9neSpdUSQ72AYodBBFAWQEjcbN7zpqxVdMNX4gJorUNIHJXC9LMcq2dBl3QobwAdTLZ2BGA1LT0ZjLa9J7bj4XUaJ93poONrNr9K+AoSyQkHEKuoE3PGk/E12s4J85wHCFvfX/cRokwy/vt0Rs1jOr7dhV6+Fn7+bgy1picJCN6XRMZj3fkUyHOl1jQ/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMK/3OzTxLjfJ24992giqaJfJoxZGTWWrON2hyVlwBk=;
 b=lBBfLZmk63DRhUcZ3Kmlo0826Q8vmywD1vN8ACsme4uUo9bfI3Ch3eZq0VVOZ89CUEiavGqLHrIgrc/Jd4jpfaeEpyJErrOHTeyXLX4VccwdPEZLgxFTQnL7mUdz6IV/y0TGuTq9jEouuGFLeZxPP2n4DmPJeCFkJQ/fUJqT6RosoXxuUSeS/te42rtUZuFZ326O19fJpzAvuZhkfSCRxrzHU3+QPcpf4cH+oYAvQSOGFxEx1QaksgLqzzggLXIwIlj7q6VNLOFCrYCk71sz1zBTV5082LbUA1ZRIriKCbfUjecuV2Ibl/K0kpo655Bl67uX2rcInZuc3S3UYlLUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMK/3OzTxLjfJ24992giqaJfJoxZGTWWrON2hyVlwBk=;
 b=knZAzupiwyOsT27WqH1H127DPLFivyPpooLGFZ6/NeUk3NK0ayB0Fq5iZUeJ0cF72xh9MrdRXLeLW1uZxFIpYXA4YgvbF2VI7SFHa73r6mZzk3C2G+31/KthhEGhvoMNDj3dYbZhqHh6+C5EyozUzLE3UWXQzPBZEl3BP1WJCi0=
Received: from DM6PR06CA0102.namprd06.prod.outlook.com (2603:10b6:5:336::35)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 04:37:28 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::24) by DM6PR06CA0102.outlook.office365.com
 (2603:10b6:5:336::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 04:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 04:37:27 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 23:37:22 -0500
Message-ID: <d19cc24f-32a4-4d10-a51c-466476616e7d@amd.com>
Date: Wed, 26 Mar 2025 10:07:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/uclamp: Align uclamp and util_est and call
 before freq update
To: Xuewen Yan <xuewen.yan94@gmail.com>
CC: Xuewen Yan <xuewen.yan@unisoc.com>, <dietmar.eggemann@arm.com>,
	<mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <hongyan.xia2@arm.com>,
	<qyousef@layalina.io>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
	<linux-kernel@vger.kernel.org>
References: <20250325014733.18405-1-xuewen.yan@unisoc.com>
 <03344e80-4ed2-41f1-9d2b-f7ed2e201eba@amd.com>
 <CAB8ipk_1=U_HgVQrfQ4VRUDrcHJBQd2LJ9aXh8PG6E-Z4_xS+g@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAB8ipk_1=U_HgVQrfQ4VRUDrcHJBQd2LJ9aXh8PG6E-Z4_xS+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: ba642a69-9f29-44e6-6cba-08dd6c1fe9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjU1MndmdlZva3RpSlBnSVVSZndiM09XajJ0MElPVnE5VVVUV1VsbkJ0Rysy?=
 =?utf-8?B?M205UC9XUTJrMTdlYy9KbDdwYXA4bjF6VER3S3lONmNVb2hPRWV4ZExrWmU3?=
 =?utf-8?B?ZGxaS0NtenR1NFJHVnBKVFg2clVtdzlKQWR4am44ekxXbkFRdm11ZlFiOGdO?=
 =?utf-8?B?ZlRUaWlMbm1qbjQ2bGI1d0xwQ0V6QVBIbndpdjBreHowL3FyN0pKeGVxeWpB?=
 =?utf-8?B?WWU3NExrRHVRa1JkZ2Z6QjFwV2o1cWNFM2hWQTJqZEZwVDFxY2xZR01vZGZN?=
 =?utf-8?B?OTl2WUl1R0NzR2ZmaEtoc2EzYkFqS09EaDVmbW9vR296MW11M1dHRWgzZVoz?=
 =?utf-8?B?TXhVWnFMOEsrbEZvekFxS1pNM0twTENSeFF5UHoxUVpNOVFXVGlGOUNUYnNK?=
 =?utf-8?B?TWFvTnJ6bjlvU0U5WFFkZldVejFFMzAwQzBROXVrNUd0ZEh2VFozbm5DaW00?=
 =?utf-8?B?MkJIc0ZLei84TzI4a283eWhmQnlIWkRyK1Vzd2YxL1VGVVRPUlRKMFMyZHU1?=
 =?utf-8?B?dGdnQXJ5ZVc5d3A0Zzd6QXVodTJJb0IvRDludm5rRUFjUWxJN2hTTXlSUjR3?=
 =?utf-8?B?S1RZdzRwcTJ2S2Qyd3ptR1NTRXV3Nm8wNk9jYVA0REZkOExPVkV2ZitFZHZT?=
 =?utf-8?B?VFR6VmJDRnNvNTNISGxLTDdNM01wK3hCMHVzQ1FwQXRtcG9SZGpmbWMrajZ0?=
 =?utf-8?B?dEFNczh4QUlSeTRkS0hRRkpsRVl5ejl0Ykl0cGxreDFSdGROelBySVhuMGRj?=
 =?utf-8?B?SnBNb1kzQUJvazZwSldkdHhkOVloQ1BLQVZ4L2FES0tOeWpYU3Z3dHFhS29m?=
 =?utf-8?B?MWhTOE1XaVVsTnF4WVgzSWR0WjRINUxEMGZEdi9wN2FwNS81dGFRV0xpM1Na?=
 =?utf-8?B?T282Y3lrNFVMa3ZwcHFjUVNvWld0K0wvdGgwb2E2RExnOVJpeTF1NzVHbWpp?=
 =?utf-8?B?bUx2ZHgrWGN4K1VTZVJSeUEzWVNEendUNm9hazI0OVFjS1I0eXpiVEFaSW5R?=
 =?utf-8?B?dXFwY05vRmhBN3JFTk5FSTlJWjRpYU1NU3lEU3ZsQWxqWC83cXFieUNFeHdG?=
 =?utf-8?B?VEVzL0w2QlJ6Vm5oUkJZNm9YVWFiLy8zRm5LTnR2Q0NYZklqZkdaMU9qVlBw?=
 =?utf-8?B?aGQzTWdncEVCRHdZVjlBalpFd0JjbUFkU2xMS3dMd1RDNUxRMktZcUR3cVhT?=
 =?utf-8?B?bnBadDBndHcrTjJhQXNPTjBiOFVpTFJscWNtNnpxWk5ZQjlvbmdsY2t2TzE5?=
 =?utf-8?B?UVJuYmcvWWlKblgyaGExWTJuSVJCbXhBVmxzb0xCYW5GRHVWOVBRUDdXUTN5?=
 =?utf-8?B?SGlrY2s4R2FzMW8xMDhZbTcvNmt6cnZjbm9xUmR1eXJrNzRTZzFvaUplaC9K?=
 =?utf-8?B?b0lndmJYSGthNTFiYklGNFZWR3p1UGtpVmZWWmpkTzBRWUZzUEpxZFBLZVlm?=
 =?utf-8?B?UXQ5UkJxajhJZStKeUlML0ZxNFZqWXpzODZULzBQS3VreklIdFRFa0tXMENV?=
 =?utf-8?B?SGZEczY2dklYOTBKaFk3OEVmSU14Zm0xYTEwZWN6TWROVTRra0kwZVZqeE9E?=
 =?utf-8?B?QUd0eFY2enRLSk9Fek9TMVRjcTFSMVN2M0JKK3A4VWVLNStHSmE4aFNEenRS?=
 =?utf-8?B?NFdsbi85VHRVN3pxYVVaeXBqVW1vMWJPZXNjdDRxa21xS0Z5enpRdW1Gcmd5?=
 =?utf-8?B?alZuUDcxem1EZkwxcHg0dGUwcGZBamZCYktUeHA3azF3cXBLYWw5S1hMQ2h5?=
 =?utf-8?B?bGppTnN1Y1VTR21tY08yVE1xOGZHZGkxa0UvWTk0TUNBc242MXdMMkRrV0lJ?=
 =?utf-8?B?MnYrb013M3NmRFprU0NDY2Q2VmxQNzFNbFd0QmdqV2dWN0VqTFVlLzNZOGpt?=
 =?utf-8?B?T2txR2NaY2dqTUo1ekM1VWU3NklHeUwvaVZmOGNvZ3hwNG9OVm85YmxLSGZv?=
 =?utf-8?Q?4sNUCfUMUP4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 04:37:27.6207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba642a69-9f29-44e6-6cba-08dd6c1fe9bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279

Hello Xuewen,

On 3/26/2025 8:27 AM, Xuewen Yan wrote:
> Hi Prateek,
> 
> On Wed, Mar 26, 2025 at 12:54 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Hello Xuewen,
>>
>> On 3/25/2025 7:17 AM, Xuewen Yan wrote:
>>> When task's uclamp is set, we hope that the CPU frequency
>>> can increase as quickly as possible when the task is enqueued.
>>> Because the cpu frequency updating happens during the enqueue_task(),
>>> so the rq's uclamp needs to be updated before the task is enqueued,
>>> just like util_est.

I thought the frequency ramp up / ramp down was a problem with
delayed tasks being requeued.

>>> So, aline the uclamp and util_est and call before freq update.
>>>
>>> For sched-delayed tasks, the rq uclamp/util_est should only be updated
>>> when they are enqueued upon being awakened.
>>> So simply the logic of util_est's enqueue/dequeue check.
>>>
>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

[..snip..]

>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index c798d2795243..c92fee07fb7b 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6930,7 +6930,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>         * Let's add the task's estimated utilization to the cfs_rq's
>>>         * estimated utilization, before we update schedutil.
>>>         */
>>> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
>>> +     if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
>>>                util_est_enqueue(&rq->cfs, p);
>>
>> Wouldn't this do a util_est_{dequeue,enqueue}() for a save restore
>> operation too of a non-delayed task? Is that desired?
> 
> For delayed-task, its util_est should dequeue/enqueue only for its
> sleeping and waking up,
> For the save restore operation, there is no need to enqueue it,
> because it is not woken up.
> So the condition of enqueue actually is:
> if (!p->se.sched_delayed || (p->se.sched_delayed && (flags & ENQUEUE_DELAYED)))
> And, this is equal to :
> if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
> 
> More details here:
> https://lore.kernel.org/all/84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com/T/#ma2505e90489316eb354390b42dee9d053f6fd1e9
> 

Ah! Correct! I got my "&&"s and "||"s confused. Sorry about that.

>>
>> On a larger note ...
>>
>> An enqueue of a delayed task will call requeue_delayed_entity() which
>> will only enqueue p->se on its cfs_rq and do an update_load_avg() for
>> that cfs_rq alone.
>>
>> With cgroups enabled, this cfs_rq might not be the root cfs_rq and
>> cfs_rq_util_change() will not call cpufreq_update_util() leaving the
>> CPU running at the older frequency despite the updated uclamp
>> constraints.
>>
>> If think cfs_rq_util_change() should be called for the root cfs_rq
>> when a task is delayed or when it is re-enqueued to re-evaluate
>> the uclamp constraints.
> 
> I think you're referring to a different issue with the delayed-task's
> util_ets/uclamp.
> This issue is unrelated to util-est and uclamp, because even without
> these two features, the problem you're mentioning still exists.
> Specifically, if the delayed-task is not the root CFS task, the CPU
> frequency might not be updated in time when the delayed-task is
> enqueued.
> Maybe we could add the update_load_avg() in clear_delayed to solve the issue?

I thought something like:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a0c4cd26ee07..007b0bb91529 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5473,6 +5473,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  		if (sched_feat(DELAY_DEQUEUE) && delay &&
  		    !entity_eligible(cfs_rq, se)) {
  			update_load_avg(cfs_rq, se, 0);
+			/* Reevaluate frequency since uclamp may have changed */
+			if (cfs_rq != rq->cfs)
+				cfs_rq_util_change(rq->cfs, 0);
  			set_delayed(se);
  			return false;
  		}
@@ -6916,6 +6919,9 @@ requeue_delayed_entity(struct sched_entity *se)
  	}
  
  	update_load_avg(cfs_rq, se, 0);
+	/* Reevaluate frequency since uclamp may have changed */
+	if (cfs_rq != rq->cfs)
+		cfs_rq_util_change(rq->cfs, 0);
  	clear_delayed(se);
  }
  
---

to ensure that schedutil knows about any changes in the uclamp
constraints at the first dequeue, at reenqueue.

> 
> -->8--
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a0c4cd26ee07..c75d50dab86b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5435,6 +5435,7 @@ static void clear_delayed(struct sched_entity *se)
>          for_each_sched_entity(se) {
>                  struct cfs_rq *cfs_rq = cfs_rq_of(se);
> 
> +               update_load_avg(cfs_rq, se, UPDATE_TG);

For finish_delayed_dequeue_entity() calling into clear_delayed(),
UPDATE_TG would be done already in dequeue_entity().

For requeue, I believe the motivation to skip UPDATE_TG was for
the entity to compete with its original weight to be picked off
later.

>                  cfs_rq->h_nr_runnable++;
>                  if (cfs_rq_throttled(cfs_rq))
>                          break;
> 
> ---
> 
> BR
> xuewen

-- 
Thanks and Regards,
Prateek



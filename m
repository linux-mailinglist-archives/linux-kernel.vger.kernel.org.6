Return-Path: <linux-kernel+bounces-569210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD6A69FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1D81895D12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84191EA7C2;
	Thu, 20 Mar 2025 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eh0pdtKo"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD61BE251
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453592; cv=fail; b=Io/ArLy8qPnMsAdmTXZCEpNe/JLF85FJJpfHeV41fKUkGi24bCVNSHeqq1TjE0Pa7vVTLxCflUiWxpvND7YblUyQZ2jjy+ldVePD4M1EahF7/C3WVRFA+joomQRYZeCRWHwr4MfwH+yNd3K5mKe6vge4qat01XFL71oI6Te09WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453592; c=relaxed/simple;
	bh=SOkr019ifrMDblfBdzxJ3FWWJ5w1LjTVUfnbQLZYbbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OBhj4GWw3gO8BMaZ2c0K7tensIQpHJSc5FKP5ZukINEouGhdwclZumj0/9/ASoxiKrEB2gXxf04Sr0zJkigk8P1AsQxXaF4twyUHOhi2miSegXS1/kznDl26oKPkyyyPwxJyt09agt+Y0Yh30Bmt+7wfNQCxWyK1DcKkTuSHeLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eh0pdtKo; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtGhhxzagqJwzCFcESdZ9SnQLoO9rBPGlpQBZyp1QDl7kfF8lJqsqYv4H+Vy4Z7BKSyIny1Rk3wobbT2eGrra8KppDQdHMR1XgS+VwEE0udT3HKLKPr+Tk9dgnAqaOjgch6MNg/GPrqPQt6IPFCZtvqDemhlxX1unSFpUdFShczpVv6tnl1MkET4BIyTWv0crU1ir22jmApzZLF1zGc3Y4OiOPymHYwKOGSHH7u2LPOrzLU0m5oJ+rfa0yFcwuwcItYdUscZSzkIjUZfldlgBoDju00I2ZEzEHciXuw+jJVi2YOZn0gsGQV7fcZrUaXr86dVHBa9rm5oaoHVKnzvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjhnnOU0Lv1uZ4Hu6CH1QI6+al1YCAskjlIeFtBlPGo=;
 b=X5MiXSkrTy/HwXgjZhbHUTsqsBtHrf227ZW/UcnyPKaN5uwRsRUHmQUdELC1d0PqzcfxyBogRM6dDYi+r5Uv+7tvEefGa6mLqX23xePrXtiz5mGKdcnkmjnGTsMkpGSKsbUCTBbTWsSLB6QJDMCXsOoPIdftA/x8tVAQE5yfLBy26locUimxjBnwQrTx8gZBwXPyQutjapcXeBLs3MLTnYB1XJv0103qkTuTJyVPVcWYzlXGQbAt0bvI/l0P8BoA+CMHNP6zzElAtgiGQhdv6gw0gfzpgbpXtyIoRIZ8rf87gCt5YM+878bonUTLEfl61LSq/8SHm84x6cboAM7HPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjhnnOU0Lv1uZ4Hu6CH1QI6+al1YCAskjlIeFtBlPGo=;
 b=eh0pdtKoSK6ttG7UBrh+9QiMOQU//CGzWLjWUb9dEdTwOH/0Okb7VyF6wiM66joRk0S4/cPu4r5IxvqxxyaQIJKLZ63r7UbXG7zIXTnt+9osJjwoi/1Wk30kWv1k9v3GDCDiqnrNvXzRCpT3DaCpDoDGdDlMwnLdIqqQ++6sQBo=
Received: from SN6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:805:66::37)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 06:53:06 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::88) by SN6PR08CA0024.outlook.office365.com
 (2603:10b6:805:66::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 06:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 06:53:06 +0000
Received: from [172.31.50.139] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 01:53:03 -0500
Message-ID: <ab91bfe1-4331-4e33-87fa-4f4fe96adb00@amd.com>
Date: Thu, 20 Mar 2025 12:23:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Josh Don <joshdon@google.com>, Aaron Lu <ziqianlu@bytedance.com>
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman
	<mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Xi Wang <xii@google.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4e933a-9a89-4bcb-962b-08dd677bde76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzVGWFBITWVrWDNXVFZKS2Q2bElBRGNYZjJzenpOamRsbzVaVG5XUU9OS2ZE?=
 =?utf-8?B?M2ZvVzZkRnRtVk5aYkx0YWhsdjlOd3kyMzEvMU9yMEQ2OUk0aTFNWmtXeE04?=
 =?utf-8?B?UVNjYW54ekh2L1BieTF6NWZvbnNCWDhDcDQwVnE3TWxoWGNyYndJV1pQSDBR?=
 =?utf-8?B?ZEhhNDUwRmdzdWZmME1QRGFISk1oNWRwR1c2bmZ3SkNBTWtjUXhuNjlUcWow?=
 =?utf-8?B?WUgvRWs1YTlmSG5xY1JHSERld29PdlVySUxqY2M1dklIcWJGNXptRlU5Q09B?=
 =?utf-8?B?WVZPRVR1OEticENOc2VJcDB2dUpjUkZnNEhmTUtzK1hsUFdiaXJkZlhFNFRy?=
 =?utf-8?B?SUN0OXpkclVWS0xMQmFVbko0YTFZV1NIYzNXbnpmdGZjRmFyYlVDUlJJNXJV?=
 =?utf-8?B?MjFGWkhXZ3A4S2NvQmZtTzJTdTJHZkFZcXRSWDh0d0d2ZmU4a29Bam5Nd1di?=
 =?utf-8?B?dFNsd3kzUGx3N002cVdmUFhSam5TOVdOTkdQLzUzc0xYanFtNW0zaWpQRzc3?=
 =?utf-8?B?cEpLV2g1cDJ5ZHZYWTJpYWNYS3F5emZnOFlUblo2Z2RhbnJkeUFLQWFqZjJI?=
 =?utf-8?B?dVg3NW11QjAzWWRnNDhuQ3JtLytLaXJMaXBhYWh0dno3MUlpUGsyRTVDWmFk?=
 =?utf-8?B?bDVISVgzT2twOG0yRjRSNmIyWXViV3VJRXkvSmhNc3pkK0d6WkdDbTBVaVQv?=
 =?utf-8?B?b0diTVlrUVF1NGRZeUhsbzlwTnlSZ25oV0pVL095K2JzMzRBTWVQSWgxYzVH?=
 =?utf-8?B?NGlHR01Makd5VTZQY0V1dE5yYnJWdUpBbW1xekNvZlFUYUI1eU5mSHVSMGJj?=
 =?utf-8?B?SHBiU2F4dDVjS3RtSElQWDVVdSsvdkZRaXFKL0dzNER6ZVhwOG5JajJkUXVD?=
 =?utf-8?B?UlA0a2oyQmJzYzg2Ky9PMmo3QjdaWGZHQkxTQWdwa1BiTTN4cEt1MWRaMndq?=
 =?utf-8?B?YlVieVFOMVdobXJGU3V6Q3JpWURQT3ZLcUpPdUdtd1F4L1JJdjVrWmZTSlo0?=
 =?utf-8?B?bm5ZN2lSS0N4WlEvNUpiUTYyLzFCTzR5Q3RmbFJ6Wm5mbitUc1d2NnZXRG9K?=
 =?utf-8?B?Z1ZRdWhDTzhYbmtUWG81aDQ1cmc0bTlQV2RwdzlKTnAvbWpVQWRFQVRQSnVM?=
 =?utf-8?B?WTREb1lDQXU5TFFReE1DdUNNYkZtc2U4aWxmNTBlb0p5bnBGU29QdEdscWlY?=
 =?utf-8?B?RCtITkN3UnlldCtrdHZ0aWhodjN6SjNUY1lVWDE0dmhhcE52SUNrSENPaFJY?=
 =?utf-8?B?aGRzK0dYT1JOcWhYRWZPWWRqUnVnbXArcEc1eC9rZDZYM2V4c1RGclVNbm5Q?=
 =?utf-8?B?U1VQT1paemNoVG1ZK0FySjhRc2lad3dUOEYrd1VWQkIyRjJjVTQwLy96OHJB?=
 =?utf-8?B?bm8xWVp6VU43b3ZXMHlWcW5JVklLT1d4YkxLZlVMeU9tRU0wbm5sV01wWHRh?=
 =?utf-8?B?NkM3b0h2eWhzRjlLMXBJQVEyZlIrRmJSK2JpdWJnei9rdytCZ0lZYnRPNC9w?=
 =?utf-8?B?REEvNGR4emtvNUtCYVlsckNxeXdZa2oyU0xPNWx5ODZsZktIejJSVUpmbHVk?=
 =?utf-8?B?MXNFdVNLSHhRalBEMGZFQk9BRmlEMkRSSkFVYnpkYk55SWpvNllYV3hoRFNT?=
 =?utf-8?B?cUFZdThTOGkrY2J2cGtkcnlveFZlY1JjdVZRL011VWd3VHZMOVIxTzR3eGNz?=
 =?utf-8?B?MTAzZXhydm80VUQxNTZpd2M0R1dUaXVyaFk4QVdTRjduVmZITnFzR2NnMUlP?=
 =?utf-8?B?VHV0aE9MMWp1NGNXUDdDY2h6Q29XY2pBeTNnRnZuOUs5cVBoVFRrV2w4RDJt?=
 =?utf-8?B?VjFWNEZua3JNUEVJdkhRK3NQK1pBaWtWRHZvcG1qRERMV1NUOHBsckpuWVFO?=
 =?utf-8?B?WmhCZXBxS0ZJTTUzRktqTHBTUFpPbnErOWFxVnhNTjZzaFI2OHhKK09hQ3FI?=
 =?utf-8?B?dkJvZ2lZZTlQTnI2U0lVNzhCREZOU0tNVEFwYUlyRUMzRTBGT1F5alZKZ29J?=
 =?utf-8?Q?b1BnDSqsM7UDbaVpfqpoRPclaEuNdc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 06:53:06.6805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4e933a-9a89-4bcb-962b-08dd677bde76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322

Hello Josh,

On 3/16/2025 8:55 AM, Josh Don wrote:
> Hi Aaron,
> 
>>   static int tg_throttle_down(struct task_group *tg, void *data)
>>   {
>>          struct rq *rq = data;
>>          struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>> +       struct task_struct *p;
>> +       struct rb_node *node;
>> +
>> +       cfs_rq->throttle_count++;
>> +       if (cfs_rq->throttle_count > 1)
>> +               return 0;
>>
>>          /* group is entering throttled state, stop time */
>> -       if (!cfs_rq->throttle_count) {
>> -               cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>> -               list_del_leaf_cfs_rq(cfs_rq);
>> +       cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>> +       list_del_leaf_cfs_rq(cfs_rq);
>>
>> -               SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>> -               if (cfs_rq->nr_queued)
>> -                       cfs_rq->throttled_clock_self = rq_clock(rq);
>> +       SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>> +       if (cfs_rq->nr_queued)
>> +               cfs_rq->throttled_clock_self = rq_clock(rq);
>> +
>> +       WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
>> +       /*
>> +        * rq_lock is held, current is (obviously) executing this in kernelspace.
>> +        *
>> +        * All other tasks enqueued on this rq have their saved PC at the
>> +        * context switch, so they will go through the kernel before returning
>> +        * to userspace. Thus, there are no tasks-in-userspace to handle, just
>> +        * install the task_work on all of them.
>> +        */
>> +       node = rb_first(&cfs_rq->tasks_timeline.rb_root);
>> +       while (node) {
>> +               struct sched_entity *se = __node_2_se(node);
>> +
>> +               if (!entity_is_task(se))
>> +                       goto next;
>> +
>> +               p = task_of(se);
>> +               task_throttle_setup_work(p);
>> +next:
>> +               node = rb_next(node);
>> +       }
> 
> I'd like to strongly push back on this approach. This adds quite a lot
> of extra computation to an already expensive path
> (throttle/unthrottle). e.g. this function is part of the cgroup walk
> and so it is already O(cgroups) for the number of cgroups in the
> hierarchy being throttled. This gets even worse when you consider that
> we repeat this separately across all the cpus that the
> bandwidth-constrained group is running on. Keep in mind that
> throttle/unthrottle is done with rq lock held and IRQ disabled.

On this note, do you have any statistics for how many tasks are
throttled per-CPU on your system. The info from:

     sudo ./bpftrace -e "kprobe:throttle_cfs_rq { \
         @nr_queued[((struct cfs_rq *)$1)->h_nr_queued] = count(); \
         @nr_runnable[((struct cfs_rq *)$1)->h_nr_runnable] = count(); \
     }"

could help estimate the worst case times with per-task throttling
we are expecting.

> 
> In K Prateek's last RFC, there was discussion of using context
> tracking; did you consider that approach any further? We could keep
> track of the number of threads within a cgroup hierarchy currently in
> kernel mode (similar to h_nr_runnable), and thus simplify down the
> throttling code here.

Based on Chengming's latest suggestion, we can keep tg_throttle_down()
as is and tag the task at pick using throttled_hierarchy() which will
work too.

Since it'll most likely end up doing:

     if (throttled_hierarchy(cfs_rq_of(&p->se)))
             task_throttle_setup_work(p);

The only overhead for the users not using CFS bandwidth is just the
cfs_rq->throttle_count check. If it was set, you are simply moving
the overhead to set the throttle work from the throttle path to
the pick path for the throttled tasks only and it also avoids
adding unnecessary work to task that may never get picked before
unthrottle.

> 
> Best,
> Josh

-- 
Thanks and Regards,
Prateek



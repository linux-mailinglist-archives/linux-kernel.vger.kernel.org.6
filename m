Return-Path: <linux-kernel+bounces-569214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2787AA6A00A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622F11897F59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230861EA7C2;
	Thu, 20 Mar 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BqOpFnzo"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80138B665
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454000; cv=fail; b=upFXQLdDk661vhoLqyuO2W5XASmv8F/1R/HBrnK2KJtDBydpayJpYz3w2m6TaSr78uzh87YtFFIbAfS2K1KzZgs+KC56S/9yGEQ4+C35mcgklpfCJ3tOQQ8dEqUvvsC1/uMSO7yVSLWFRZHUOojRbU0s4Nmuu2jJ+Wc7zr1r1GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454000; c=relaxed/simple;
	bh=fg8Nc8zjIH+HOKxtYjntD9pWcFRvx9wbKFmZ/SEMalo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hvmrX9pdioyHxvFi0dqvHdf/WFIa+jOciHn5cva5E5bU9u8ZafZ9BDdhq45yVdDMTEBgLI4yNENmtYg+4CR3gRcZLFWyJ6slylVxyRukUxH/eX1UK6Y6Zgw677o3SBgegvQWyuWhOerPKFAo5BBr8aEUcNPAssTFVb7t85R32sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BqOpFnzo; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROdwAUR99qVg7XvcZmunBe05tNLA1b+10xNvhUY/e8gzzJlWDhulvjEO06AgouzOF5MkjMxdiYWmSlhlw4iQtK9UhjGy0cZswsgaSCSAeNqDmKI8PLuXXMD568herP7+Ox7e8KppJogOjEs/awzyUgvjkGYfRCltOwJeQH0y9IbQuPki6nt3kvftj7IC80h8nKlLzTKhN4ecBtjw9HoW1s5g3O6X14kcvTzZBclgBeVcCzD+LYBH2y2uOmYfWYnVECifycvm8PeKSP7w7twGZkQGitR4f5rXP4BtD2z75UqeuJJbv/xr14pke4ndX52yDSizw54OiqqHah/00YODxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qEaeXkfn850aFbtSn8+UnYpyZ0JuXX5EctlbqdZE0Q=;
 b=wPA3Ob5NRLS+C5sdODY9O7Vn/BjhAQf+lsxpMa8egNVGy/XLs+HsZXkkHhidwvKTYNRnw7uLhO5ctcseqwZWA7WOb8qhabyRYqZG5CpGjTVogIR4Y3tNTojfTXyaiqo7R8/wGxg4W3yNwgr4DoFsMNsg5/yQYEAPkMB00iomRu43Yl1ft3a8dS/MsKL3U9r8VvKjcfdSEJ8/ztKnW6N5kp0is7Xfs2CkvDnk5+buKr+wTaFxoKQLXaOiDqTgMIYxc/JfkudEGBilkO8wHBGwDfkDDDJZTkM32AC3ojsUxsrFayX+w9d79XcFlz+Gdun5xItRnm+UTsuNE/XFl5PsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qEaeXkfn850aFbtSn8+UnYpyZ0JuXX5EctlbqdZE0Q=;
 b=BqOpFnzomyCWknRQlr2umD1evlFHJJKjT46WXZL8PFnjuthmrinLI4wEiEuAag24MB6A/Rj+EY+GmdKpFwg3/WWEwOwJKrUqCugB/ukTYl+QEf+pqx33fIB4pfZcD8OY64ckV504JeFBKeV12BCfHe4W6CRTjtbtYxno9IkgIis=
Received: from CH2PR15CA0022.namprd15.prod.outlook.com (2603:10b6:610:51::32)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 06:59:53 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::d5) by CH2PR15CA0022.outlook.office365.com
 (2603:10b6:610:51::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 06:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 06:59:52 +0000
Received: from [172.31.50.139] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 01:59:49 -0500
Message-ID: <66a69f8e-6f0c-48d0-b8d6-6438092f9377@amd.com>
Date: Thu, 20 Mar 2025 12:29:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Chengming Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>,
	Aaron Lu <ziqianlu@bytedance.com>
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman
	<mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>, Xi Wang
	<xii@google.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
 <f121fdf9-aa0d-419f-9323-bd8b0c9682f3@linux.dev>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <f121fdf9-aa0d-419f-9323-bd8b0c9682f3@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 34571747-e080-4f29-7560-08dd677cd043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkhBWSs0dCt4WTMzbGo1UTBMRFRxdndKOXRkT3MzM1orUFNVS3RuMWZ3b1VS?=
 =?utf-8?B?WHBsTHNyWXU4Y3JFOG5SZ3BHbVJpYWg4S3hVcENhd05aRk1MZ2F6Z2RIVXJ3?=
 =?utf-8?B?SHg2WUVEeUxhRDAvOGdEOFdIVmIxV1lIaStUMVpadmtORVExSC9reEFmYmVN?=
 =?utf-8?B?Y29mOGNUaDUzaU5mZ0xaTW5lMXZ2ekQ0WUtmcUI2Z09XNi8xM0o0cnNKL2FN?=
 =?utf-8?B?cnJmT05FVG9aQ1Nzdktsc3VLanhnVnZ1enorSzhaQmx6NnJUVTljeFlwSHd0?=
 =?utf-8?B?UnlJZXVLVFRrc2IwbzFLS2NjM0ZqWnN3OG5lbHNkZ2xTNCtEOXpGUklKT3VM?=
 =?utf-8?B?OVE1R3dOVVpwV0F5aWpKcUFYcjk5QzZGY3YzcjhxZTZmZVZiM3YxTkxaQlZJ?=
 =?utf-8?B?R0pmYUtDTTVGaDhJOG9USTdzd2dvWlZXRXk3MUQyQ2lsMUx4S2J5QXNNaHNj?=
 =?utf-8?B?VnBHTG9hektUNzg4bjZZd0VHdmF1a1ZDb0RsM1Q0TUZTMXFnVzVuSDZXMHlL?=
 =?utf-8?B?dlBlS1B6bmZzZlhKM1d2Q25BOFk4MkFsUUVETDlyc0hPcXcvQnp4UGlXcENB?=
 =?utf-8?B?K3huY3BLNmdrWnNxdTNOU1I0UjZHWmpHTzFxNk4vZ2NGN2lQaG50WGYvbmNj?=
 =?utf-8?B?MzVocWRJTE1jOGl1dXJocWhTSkEwRHlURW4wT0dHTmRUeWFVQ2tVUFVDbkhi?=
 =?utf-8?B?YzExQ0xBdm5pMG1DLzl2MkZQQWpTMGU3cHVnalBSeVlqeGU5WjJ5VzJNcWJ2?=
 =?utf-8?B?bDVGTjVsVUVzZEpnZ2RzUUF4QkRXZmFmY21PTnBBOWc3aHlEZjV2Yk1WcjVK?=
 =?utf-8?B?Z01yWXl2T3gzMHlQd3hBU005OHlzd1JiNXlOWVRLSHdTK2N6VUVwMXZCK0J2?=
 =?utf-8?B?SmZOK1JGbFUwcDN1NUU0R2g1ZVRQMFhBckNadXA2cWcxRnZLOUVNWk1CL1pu?=
 =?utf-8?B?OENDbUkzRFo1NlFVaU1yRjZLaVRxQ0xIb2ZEMjR6N0oxYy9QRnpXWFRjTUdH?=
 =?utf-8?B?eWtsMDk5OXVPSnovQjJHWWJPbXg1NTl2cm1keVU1Y1Q3ZVAvSWJhYzRZZXA1?=
 =?utf-8?B?ekZRYmlmNkIrdDlLSjZjN0xBcnVKQ0d6Lzl6VlVWK2I0RXk1cHlOczZMczBy?=
 =?utf-8?B?Nm5tYUw1RVpaRjJGNnhmZFBuY1JGbUtHWGJ6U3ZVTXpxNmZNd3dGVjByb2FF?=
 =?utf-8?B?SGI5T2ZzTE9wSGNCSUlKaWM5Ny84Z1lYR0pQaW4wRlUyamhOWWZIMnMrbzFh?=
 =?utf-8?B?MjhUd25HZmRjWEpQUWw1RU9GNDlOZy9UZVBiZ2k4cWdlbWg1OGZpRE5MKzl2?=
 =?utf-8?B?ZW96M0ZpajBGZS95VngwZlRETlQ2dmwyM2doY0JKK0pwb2puUVAva1RKVkRJ?=
 =?utf-8?B?R3hyOVJaUWl1Qm9yVWRDMTVYYStZNTIxTldaZDBBWEJVWDZXWVdEZmg2eTJJ?=
 =?utf-8?B?L0lEL3ZaTFErVzM5djNkYlVOOWVEVWowR2t0WEpqMzdqWUZFSWY5dGZVTUs2?=
 =?utf-8?B?UThHZHBZdHJ3ZGRQTDZva2xYRXZiS3V6RlhCQWtEdlViQ1Izaklld0Q4M1RI?=
 =?utf-8?B?MFNRa1VtdnM0VVZDMjhWZHZ1QU85SXBFN3E3b1N5UGN4ZU9LQmx1VU5sM2hq?=
 =?utf-8?B?Rkd6VHN2a2ZyWGFpYlFjVWMxMjFCUCtXeFFxazl0Um1jaU8xRmdGaklDUVdJ?=
 =?utf-8?B?dlVFTGMweXowSGlJMHd1UG1BTzg2bVIxWmxiTlZpMXR3NFg3cHd3cWhEREpm?=
 =?utf-8?B?eFhRMTd5Szg5aVlEOXc1MmtVakVBZitRRGxZM1JxREZGMkF1UjVSS1BVY2tK?=
 =?utf-8?B?ajJhN3lYU0FzWTk5L1FDLzhZR1Y5dXJqd2FOb0NKQXJuMTF3Sk16MHB6Z1Rp?=
 =?utf-8?B?QldYUVVyNFl5cUIrV1ZzN21ORS92U1pnczlQcG9tYzVrQUpFYW9nK0VwUEF5?=
 =?utf-8?B?bWI2RTRBbExYWXlwTXZLcHFKOGZLQzZJaXo1cmU4akpydVR0R0FUbFI5UWx6?=
 =?utf-8?Q?D03BpXHhzVEgKnAuaxgVd6nA4HPWOg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 06:59:52.3540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34571747-e080-4f29-7560-08dd677cd043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309

Hello Chengming,

On 3/17/2025 8:24 AM, Chengming Zhou wrote:
> On 2025/3/16 11:25, Josh Don wrote:
>> Hi Aaron,
>>
>>>   static int tg_throttle_down(struct task_group *tg, void *data)
>>>   {
>>>          struct rq *rq = data;
>>>          struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>>> +       struct task_struct *p;
>>> +       struct rb_node *node;
>>> +
>>> +       cfs_rq->throttle_count++;
>>> +       if (cfs_rq->throttle_count > 1)
>>> +               return 0;
>>>
>>>          /* group is entering throttled state, stop time */
>>> -       if (!cfs_rq->throttle_count) {
>>> -               cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>>> -               list_del_leaf_cfs_rq(cfs_rq);
>>> +       cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>>> +       list_del_leaf_cfs_rq(cfs_rq);
>>>
>>> -               SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>>> -               if (cfs_rq->nr_queued)
>>> -                       cfs_rq->throttled_clock_self = rq_clock(rq);
>>> +       SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>>> +       if (cfs_rq->nr_queued)
>>> +               cfs_rq->throttled_clock_self = rq_clock(rq);
>>> +
>>> +       WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
>>> +       /*
>>> +        * rq_lock is held, current is (obviously) executing this in kernelspace.
>>> +        *
>>> +        * All other tasks enqueued on this rq have their saved PC at the
>>> +        * context switch, so they will go through the kernel before returning
>>> +        * to userspace. Thus, there are no tasks-in-userspace to handle, just
>>> +        * install the task_work on all of them.
>>> +        */
>>> +       node = rb_first(&cfs_rq->tasks_timeline.rb_root);
>>> +       while (node) {
>>> +               struct sched_entity *se = __node_2_se(node);
>>> +
>>> +               if (!entity_is_task(se))
>>> +                       goto next;
>>> +
>>> +               p = task_of(se);
>>> +               task_throttle_setup_work(p);
>>> +next:
>>> +               node = rb_next(node);
>>> +       }
>>
>> I'd like to strongly push back on this approach. This adds quite a lot
>> of extra computation to an already expensive path
>> (throttle/unthrottle). e.g. this function is part of the cgroup walk
> 
> Actually, with my suggestion in another email that we only need to mark
> these cfs_rqs throttled when quote used up, and setup throttle task work
> when the tasks under those cfs_rqs get picked, the cost of throttle path
> is much like the dual tree approach.
> 
> As for unthrottle path, you're right, it has to iterate each task on
> a list to get it queued into the cfs_rq tree, so it needs more thinking.
> 
>> and so it is already O(cgroups) for the number of cgroups in the
>> hierarchy being throttled. This gets even worse when you consider that
>> we repeat this separately across all the cpus that the
>> bandwidth-constrained group is running on. Keep in mind that
>> throttle/unthrottle is done with rq lock held and IRQ disabled.
> 
> Maybe we can avoid holding rq lock when unthrottle? As for per-task
> unthrottle, it's much like just waking up lots of tasks, so maybe we
> can reuse ttwu path to wakeup those tasks, which could utilise remote
> IPI to avoid holding remote rq locks. I'm not sure, just some random thinking..
> 
>>
>> In K Prateek's last RFC, there was discussion of using context
>> tracking; did you consider that approach any further? We could keep
>> track of the number of threads within a cgroup hierarchy currently in
>> kernel mode (similar to h_nr_runnable), and thus simplify down the
> 
> Yeah, I think Prateek's approach is very creative! The only downside of
> it is that the code becomes much complex.. on already complex codebase.
> Anyway, it would be great that or this could be merged in mainline kernel.

I think the consensus is to move to per-task throttling since it'll
simplify the efforts to move to a flat hierarchy sometime in the near
future.

My original approach was complex since i wanted to seamlessly resume the
pick part on unthrottle. In Ben;s patch [1] there is a TODO in
pick_next_entity() and that probably worked with the older vruntime based
CFS algorithm but can break EEVDF guarantees.

[1] https://lore.kernel.org/all/xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com/

Unfortunately keeping a single rbtree meant replicating the stats and
that indeed adds to complexity.

> 
> At last, I wonder is it possible that we can implement a cgroup-level
> bandwidth control, instead of doing it in each sched_class? Then SCX
> tasks could be controlled too, without implementing it in BPF code...
> 
> Thanks!
> 
>> throttling code here.
>>
>> Best,
>> Josh

-- 
Thanks and Regards,
Prateek



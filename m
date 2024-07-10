Return-Path: <linux-kernel+bounces-248058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991AB92D7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506C8281BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED8C1957F2;
	Wed, 10 Jul 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ACL1uKE8"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C69848E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634286; cv=fail; b=mr8wbZGvChLSYlT16w2GtOzwq+zflEVOe2SkZXV0V7CgvlWuCPBNbKZzR3D1fgiPEEodBQvAA/uw8kVgOBFRFSnsTmP5c3QoDd5dwXpQ5MNStlhWEJVFl8VOpRTSfpI+U8uFvW4L0MutfI4wQlLPxOEp1o0Sp2GGsOXHHSIT+00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634286; c=relaxed/simple;
	bh=Ic+SiV2RyrTHUhC86+Qb4OCuLw9su6JhxYm2AL9WVls=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B4gKmOcXA6O23x4kORJf8kt0WdRXHM9o/zSvz6AQa2cksSvvr7bEjEMiZHNDClVr5oS1mlJvRaxFo3TL0S0UMP+nlBvnVNVbOFj4c13zPl0i3MPAjY8eW/4DEQzy2x1eWai7obcGA1iwDgd+LJILPhsf9xokUvRnuumjbh6RnSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ACL1uKE8; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3mkyzsOazzDtZKkoK41zrWtIdlTBRhkDLjnbFJ8ao3iwvccExdak3RGkmKgNtAKx0sqi2EAyjYNFB/TEWHHRvL+tbQmIZ701AhsDAJtjyfhZmGHkb8pgrru5JlJvzGfn3f5fPzhuwhrL5x4yVYoGT3L16P+4eUL1gpIinYw80CWhu9cnJLOKOmeE/4EvTcGjS9Q9y0jct4ZIyv6sC+KV5XqfwXhB6iqm991NqbcsN1xlTUM3m8M0Dh6An2ko2fdvKXu1tgrI3ka7hBEYOR6uva1qb2Sh5FzNjUX966dg6hSzYsxkDDziqQtZ8Bo2bEQoYOyJjC9q+uLHQCPfdfYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkv1nH/H3yA6wBcPoJ5AtFSnv5moNiOCeGlLGM4nh+M=;
 b=KFsZHASokumraZeF8kPBX+15EiSYfuggQUJf+LbkCXaVvW2GviOXODxqxGEtasAzhYl5ezlZMdzTeTdrcQGdJ8WaGOA+QFASQL1SbkDKRiMSkTS2dx8QqMB9I0wOutEDUEQ6Rd04xt9LINKBLhLg9CFqba2gKPHg3FeUblMJYPM8o/OIBnB1T/tpqeAp8FIL38JPSo1qzRl7BeHJDCA2kRjnJZJV4W2wcTOJ6yqhcfNGmakP4bNNApKOG9gbBVUIvSNKlc0PAzUYrcQDCzXMxD0HTAvblWK+m1VSyQqw1iZWp/08jWnugR26nrkjV1fwp0wfWq3KNOr4ASyOOSmoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkv1nH/H3yA6wBcPoJ5AtFSnv5moNiOCeGlLGM4nh+M=;
 b=ACL1uKE8lc8EI7gDGKGK94v1R4W/98AJ2Ex3X6DqovtcvwL4Jkr6NAQBljOV/XE6edI0bNnpaEN3Q3cqGGYLm3mTDzUA+SFJdDG6V8FygeVAD8b5wugaYQqxYDYKLCazmkmPnU1xS0PZuP873w7DDRJQg0txvt3P2CSbvwyCo9w=
Received: from MN2PR10CA0005.namprd10.prod.outlook.com (2603:10b6:208:120::18)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 17:58:01 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::ca) by MN2PR10CA0005.outlook.office365.com
 (2603:10b6:208:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 17:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 17:58:00 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 12:57:52 -0500
Message-ID: <027912c1-c158-8a3a-6d50-9c08dcf4db31@amd.com>
Date: Wed, 10 Jul 2024 23:27:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] sched/core: Remove the unnecessary need_resched()
 check in nohz_csd_func()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>, Leonardo Bras <leobras@redhat.com>,
	"Guo Ren" <guoren@kernel.org>, Rik van Riel <riel@surriel.com>, Tejun Heo
	<tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-2-kprateek.nayak@amd.com>
 <20240710145320.GA27299@noisy.programming.kicks-ass.net>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240710145320.GA27299@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 6091e52c-e03f-4fe6-019f-08dca109d6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTBXME9nanNhY0pLM0MvRnVEZENlMDllYytnenluTTlsQXJVa0o2SDloL1RX?=
 =?utf-8?B?c2djL2ZwWmRKYllmTWc4emFIdEF6UzRRYWM0UlpLcVpnTzFMcDc2dnZNdmV2?=
 =?utf-8?B?S0NhSlNTRWE3a2paRTdtQkdEZVRrM3d5TmhZMVZtQnlubmNXNCtaNi9XOElx?=
 =?utf-8?B?RWVmSi91Y09TRWZaM0loV29pWkVlLzB4ZmM5ZTVtdHlqQnlwcFVjWWpSVEhV?=
 =?utf-8?B?emdncnJUK1I2VUtTbkFKWXBSUi9ZbTZMR1RxZVdMVDNRMWR4cisrdVVHekY2?=
 =?utf-8?B?TVV6TXJVVW02dklvUVdpdXZCbytXTWloTlRGWVZCODZselFzK0JFd1NZdTA5?=
 =?utf-8?B?WGtWU3kxajk5bzBLT1lUdXdXY3ROMWEzT013Y1FZeFhvMmpFQ25HWWtEUkZl?=
 =?utf-8?B?bUJBWElwb1c4ZXkzQ2dRU2RBTU9IL3U1TzB0OTRZYm9RNlVjbXc2eXJzamNv?=
 =?utf-8?B?VmhoMnZFam93ZWs0d0x6cFdpVm15a2piL3ExN29wdXZCZjIvTW5QVHpTYWhH?=
 =?utf-8?B?RDZ6b2RFL0MyQUxsNmpWV3B6dm9UNExHVVBYZC9wSmhzeUd3WmpPb1dVNmwy?=
 =?utf-8?B?WlJKQXFpWXhObUYydVJJVEtJQk1jUW9qUFhPaURicURWTEQxSmozcTBwSmdW?=
 =?utf-8?B?ck4wTmMrNGp5OUZrL3dvSXRYTGh2bDY4S2F1TE0vcVlLQVRUNEZ4bnBjSGNw?=
 =?utf-8?B?RzhGTHBKUDJzYmluaURjbzFnbWdRL2habXJyVzNXTVJmSnlIa3BBNElKekZP?=
 =?utf-8?B?NHVLaVBVY0dsNjlkVnFWY3YvTjF6YlpjUk1tRzUvcGFGdWd2a2lnOUhNbjdy?=
 =?utf-8?B?bE9Vd01DM0ZrY012WDdMMjNCZHNyOFh3blBsRFBsY1VvNnZRVDN2QXlEemtY?=
 =?utf-8?B?ZGx5UUp3ZXp6NkdyaHQzZk1jMWpuQmRJWUZaUnlmaEVsY1dyazVpOVBZN2xh?=
 =?utf-8?B?T0l2WXJoNHp5OHNBaWNhWFhDRWpaOFFvNElBWTcrczZIZ3YrWlp4bXpYTGpW?=
 =?utf-8?B?T0xTUmcrei9jWXRIU2FOWGFYRTRlNGY4RzBjVFBTK1g0Q3EwckRqdW9meGhh?=
 =?utf-8?B?aG9wcEh5TXZObjBQbjRGcEtoRzZWRXhlMjdmaWhMeVlMM1cwT2JueDlLMjlY?=
 =?utf-8?B?SndPY0poWXRqdk9LWlFjb1ZDS0pxeFFNbHJST0JMWU90K0taR3gzNnVBV1N1?=
 =?utf-8?B?S04rTnZWWU9TckNoVEVndVV4NVl4NmFlUkdaWEpGMHhubVVqdmZsY0hyRW5F?=
 =?utf-8?B?U056K2Q0SFRBUE1Xd1d4azBCdmN1T2FkcU9qcFErNFIrak1VYzB0SU9qSXlj?=
 =?utf-8?B?NEgxV09KOXlsVUtFTHZLZ0FOWUkzT3Z6aFFrWUplSlhmV0JSci9zbkZaY3JW?=
 =?utf-8?B?QVFaNXBpQ1N0UklHVTVjVS9DTk9IV2s1L2htWVpQck9XVXE3cWtWVjNCdjRl?=
 =?utf-8?B?K0EyNTVSSEd1YmN4WCtKc2NRTXczRzVhbEo4dmlMV3o2bCs4NnZheXJUa2Ix?=
 =?utf-8?B?dVcxdkFhS2lyMU1sekNxaEFhZDFab3htTHM4NTZHVnpBYlFDeEhQQm9YRjVZ?=
 =?utf-8?B?M2x0TE1leWhJdVluSTdPVVZFbEtUTWljWCtTNFkwR2djbWJ1L1RHNC9HRlpI?=
 =?utf-8?B?WGJSVm91Zm4wUVVYWjVrK2gwTDBuYUlBbkN5L2tIMTJJMFlNblY5Q0E3S2pI?=
 =?utf-8?B?TVhjUWFWTi8wbDJWWmhwMnNHR0xHUVhtRHk0Sm40bGkzSEtvS280Y2FpY1R5?=
 =?utf-8?B?eDJ3WW1NbXYwaVo2b1NabUR2OXhEL2tzSFJtdVQ5V2k1b2srV2lFR29SZGFF?=
 =?utf-8?B?VlNwbG5RTytPWjk1K0djYXJzY3UzV29WdE9BWTJHNWxHejZBeUVPNENyRFVC?=
 =?utf-8?B?T2NFUUROUUZDQ3ZGVFpod0cydWpvOWdxNHVQWmdqZk1TVXNhWjY4TnVOT0Mr?=
 =?utf-8?Q?5wrqJTYfor6oO2M74x5a9jeC9iJUjmMm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 17:58:00.9846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6091e52c-e03f-4fe6-019f-08dca109d6e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

Hello Peter,

On 7/10/2024 8:23 PM, Peter Zijlstra wrote:
> On Wed, Jul 10, 2024 at 09:02:08AM +0000, K Prateek Nayak wrote:
>> The need_resched() check currently in nohz_csd_func() can be tracked
>> to have been added in scheduler_ipi() back in 2011 via commit
>> ca38062e57e9 ("sched: Use resched IPI to kick off the nohz idle balance")
>>
>> Since then, it has travelled quite a bit but it seems like an idle_cpu()
>> check currently is sufficient to detect the need to bail out from an
>> idle load balancing. To justify this removal, consider all the following
>> case where an idle load balancing could race with a task wakeup:
>>
>> o Since commit f3dd3f674555b ("sched: Remove the limitation of WF_ON_CPU
>>    on wakelist if wakee cpu is idle") a target perceived to be idle
>>    (target_rq->nr_running == 0) will return true for
>>    ttwu_queue_cond(target) which will offload the task wakeup to the idle
>>    target via an IPI.
>>
>>    In all such cases target_rq->ttwu_pending will be set to 1 before
>>    queuing the wake function.
>>
>>    If an idle load balance races here, following scenarios are possible:
>>
>>    - The CPU is not in TIF_POLLING_NRFLAG mode in which case an actual
>>      IPI is sent to the CPU to wake it out of idle. If the
>>      nohz_csd_func() queues before sched_ttwu_pending(), the idle load
>>      balance will bail out since idle_cpu(target) returns 0 since
>>      target_rq->ttwu_pending is 1. If the nohz_csd_func() is queued after
>>      sched_ttwu_pending() it should see rq->nr_running to be non-zero and
>>      bail out of idle load balancing.
>>
>>    - The CPU is in TIF_POLLING_NRFLAG mode and instead of an actual IPI,
>>      the sender will simply set TIF_NEED_RESCHED for the target to put it
>>      out of idle and flush_smp_call_function_queue() in do_idle() will
>>      execute the call function. Depending on the ordering of the queuing
>>      of nohz_csd_func() and sched_ttwu_pending(), the idle_cpu() check in
>>      nohz_csd_func() should either see target_rq->ttwu_pending = 1 or
>>      target_rq->nr_running to be non-zero if there is a genuine task
>>      wakeup racing with the idle load balance kick.
> 
> For completion sake, we should also consider the !TTWU_QUEUE case, this
> configuration is default for PREEMPT_RT, where the wake_list is a source
> of non-determinism.
> 
> In quick reading I think that case should be fine, since we directly
> enqueue remotely and ->nr_running adjusts accordingly, but it is late in
> the day and I'm easily mistaken.

 From what I've seen, an enqueue will always update "rq->nr_running"
before setting the "NEED_RESCHED" flag but I'll go confirm that again
and report back in case what that is false.

> 
>> o The waker CPU perceives the target CPU to be busy
>>    (targer_rq->nr_running != 0) but the CPU is in fact going idle and due
>>    to a series of unfortunate events, the system reaches a case where the
>>    waker CPU decides to perform the wakeup by itself in ttwu_queue() on
>>    the target CPU but target is concurrently selected for idle load
>>    balance (Can this happen? I'm not sure, but we'll consider its
>>    possibility to estimate the worst case scenario).
>>
>>    ttwu_do_activate() calls enqueue_task() which would increment
>>    "rq->nr_running" post which it calls wakeup_preempt() which is
>>    responsible for setting TIF_NEED_RESCHED (via a resched IPI or by
>>    setting TIF_NEED_RESCHED on a TIF_POLLING_NRFLAG idle CPU) The key
>>    thing to note in this case is that rq->nr_running is already non-zero
>>    in case of a wakeup before TIF_NEED_RESCHED is set which would
>>    lead to idle_cpu() check returning false.
>>
>> In all cases, it seems that need_resched() check is unnecessary when
>> checking for idle_cpu() first since an impending wakeup racing with idle
>> load balancer will either set the "rq->ttwu_pending" or indicate a newly
>> woken task via "rq->nr_running".
> 
> Right.
> 
>> [..snip..]

-- 
Thanks and Regards,
Prateek


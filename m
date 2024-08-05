Return-Path: <linux-kernel+bounces-274159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF894742E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0992B21C32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A2757F3;
	Mon,  5 Aug 2024 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p1TJ3RsL"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6E1422C3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722830638; cv=fail; b=WYp3u5Ddk+UaHemcM8G++MQPVxoRTC6bC9gg6DWAHtP8yk4vFJ32F3K2nyTLPGS2p4lC1oPzFAFwIq7hoZEVlC6K1k+/o6ZL6yEsw10cs5relKenTlXnpOYLqB765zMNvdINfObrrLpTI5zOf0uW758sxlMgWS0AvirOJgnxjcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722830638; c=relaxed/simple;
	bh=D8ntfMtEBBlujJFW/e72RfVuB3zdO//fu8MFs0TAj2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AgWsdXvTyjrVO4jJpB3MFy7kDdlUH2w2J1DiG3PFRNxdLemG71lABtr5y6tyqkeRKgFsqpI/hvd5lcQbfOOLk2MmupB6vEY7d5ei6g8Eo3KruE+mnwTJ1/XvRlY51DJMCpGyQb8wPEJep2zUvs5xTWo/lWjMFCh5MhDdn+VijVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p1TJ3RsL; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMX64g7SQE7lUZL5tWLiSN9zstt7FwjZ+cpkaC6XchSb1R+pNTe/x6Q38QKDqJKk899/RiL2uKaZuFl/MB5zuOy2ftrYxacjqdvMuTlJZPEY6FOpwahAIu2UusD4Lc9hVwQQy999LzjUaNbySzZsSZ5C+8EdMQUrs8xhpSUeVLREBBIdYD5Td1doR3J2h2chQPYb+ZO/W0frnE5yq8+HcFqRwUwkzyuJgi3p05SWKh76wIWewznLMKCicOy7yMX8vQhjDHoEriStpyp3c8h4NJJogjv3dYfQS1QEbeSN2mJWiK+99STqcE9DMcHUGnX5AvKYhuE1RbbqkfpyKBxPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phI5BsIa+4Htli5CY/DeVB/wulYOKde1WoZ9ooI+B50=;
 b=J0zfbkBiC7omwb2D8KvaaeW8Tlb1JEATOPyYk/ePQINcqvsSMSGjUFX0KJRBIbQWQGwBT2P2nyZ7V9L18YTLaoaPYvXeLuvAX4cgbtEJoqmFB8aTPtIJkbLG/BSURUa4Kc3SitREP4QZT6FhxvGZ88x9mEgLid9MYgojwdkpifba6Xb3q4ByRUKq7fpW9Ag1TKl3IWIgCslGTPcgImZzxhPY03ej9hSGaC3P0I4DOi5lNhav6ixXaK4bdNgpPp/Dgy4aP2biwAzNtbJbh7ViwEY0eGcNRhoQQ1otcrfrzpHL8j2bmJhbnQFesAotP7wN/voNFQYvqabI+EIKa0qEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phI5BsIa+4Htli5CY/DeVB/wulYOKde1WoZ9ooI+B50=;
 b=p1TJ3RsLLkzQw1juGgcxcxkPg4Jmc8jIsozJktmg7ueh1JPUeOPjnEyDLw4CAygt4NE09Pdlkc4T4S3zDhnwnk/PJLDbDH0OAy2thbqOlfkj8rLWeWXBvEo8USt+ak0ezVoouEJXW6Yyq+AU+RjoPVJgMXExyTeXm9LeEKiQN4w=
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 04:03:53 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::9f) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10 via Frontend
 Transport; Mon, 5 Aug 2024 04:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 04:03:53 +0000
Received: from [10.136.40.92] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 4 Aug
 2024 23:03:47 -0500
Message-ID: <8bcdee16-88d5-7ec5-7d88-1ac11566c28a@amd.com>
Date: Mon, 5 Aug 2024 09:33:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/3] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel
 Bristot de Oliveira" <bristot@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Imran Khan
	<imran.f.khan@oracle.com>, Leonardo Bras <leobras@redhat.com>, Guo Ren
	<guoren@kernel.org>, Rik van Riel <riel@surriel.com>, Tejun Heo
	<tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-3-kprateek.nayak@amd.com>
 <ZqkRNGLEHIsgxtSt@chenyu5-mobl2> <Zq7+G1YmKG71WIQ5@chenyu5-mobl2>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <Zq7+G1YmKG71WIQ5@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0476c8-992e-406a-2b10-08dcb5039ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWJlQXc1UzhMczY0amRJbGhLMy9TbUtVbUN0OXZISVNKc0NOK3JGY215Lyty?=
 =?utf-8?B?WmRiWStCN0w0UWF6UjlxT3ZqbDFWNXRnbndkSjNXb3BFbUZJMTlmTEFGMCtn?=
 =?utf-8?B?V05HY2NGOFE1cTl3T3dNZVVHbTd1dmx6MysrM2U2b0tBelNWS0NORE9nZis5?=
 =?utf-8?B?Z2xaemMrR043Wm0waEN4UC9TUzA5dExXVDJYb0NnOWNzSGozZUVPNllxK1du?=
 =?utf-8?B?bXpiVjNyZGR3TG1WQkZJTWtwbHlmc2pURHg5UVVidUl6cnRkVjFYN2lKNDEx?=
 =?utf-8?B?emJGb3pnWlU3N1lHdWd2dHJsS0tER0RZeXdqWnA2U0JRSFdZcXpWR0lrN01u?=
 =?utf-8?B?UzlOL3Bna2Y0clYzSk1ubmpjaDhOKzFSTGVNeTFxajJPelFzQTd5VkVYRXVq?=
 =?utf-8?B?TlFuZ2pWNmN4T3Z2WUdGRDBPYy9QYTFpVm01WVUrS09aejRlQ1JzTnJoeFp0?=
 =?utf-8?B?SGFiMmxybUVOWkppT2FLK1EzWGo3ZGdReE42TFlSbDBMbWZBM01LWm5adFRH?=
 =?utf-8?B?WkRWSDJOd0dLWXU3WGlTWVRqNEhWL1dlZVg1UERnZEI1ZVN1M09GVHZkTG0x?=
 =?utf-8?B?blZHYkhFdEY2YW1OWndMRFo5U2lnRTkyREtMbnZ5M0tuZElPczBiblRkdy9D?=
 =?utf-8?B?bUVKb0NvZUF5MlVhcktVNEVnYU9jY0psY2NZOG5SaTRhdVFncGwxNCtBVU44?=
 =?utf-8?B?Rm0wUGxSS0I4OUI0dGpqamZFcE1XdEwyU0M2R2svYXk1S2luUDgxQ0EyRzA3?=
 =?utf-8?B?dWJ6RFNBTjNzVnY3KzFKcGY1QVpwbmZ4OE0wSDlKQXIyMGkwZWRTSEtxSkFW?=
 =?utf-8?B?RzQya1ZjMjNQMXdnUDQvRXYyaWMxMm1JaEQyYmJMOEI4NUQ0d2JMVGhYQzlv?=
 =?utf-8?B?bWs4bUlwQndOUG9jSXdCUDNuNTJoMnkxazlRbzRVcTl4M01FOVpaWE1YK1dO?=
 =?utf-8?B?VE9SNk94UFVTb3JKUFdMZ1ZsTStGWUhPaDdrRTBoSThSK0doQkY1citHR1gx?=
 =?utf-8?B?dmJOS1ZEODc2RHQ2WExXTnZ5V05KRWg0cXlNVHFEQ0RYTk0yZ3VGQnpiekcz?=
 =?utf-8?B?cnFYbFBEelYxVXpkYW1yV3RNdUF3ZlEvbGRrNnV6ay9VQ2VqSjJHS1NaOHdu?=
 =?utf-8?B?YSswRlNTK3gveSs2Z3ZqOFZVR2F3ZWsxeURRKytkZjg5VVljRmVlOFZCc29j?=
 =?utf-8?B?NG1DN1dmbkF0bVJSWFVPVks2aGRnU21mMGNIbGRYUUJzKzBCMCtDTldFd0l4?=
 =?utf-8?B?b2VuaUNvTWUzeFllRjZGVzB6c0VreWJOTi9FL0syZ0xDekZMWW1ydGdTS0VD?=
 =?utf-8?B?M1U4Mm82TzU3amFPeVlQeFFMYXFGbUk3OWg4bzlXWUl4TDNkdGN0TzlkNE95?=
 =?utf-8?B?eWIyUXVmZk1pZTBtTVdxWlE0eVNONFl5ZFZXb0ZyU2NkVEZDUmFIREZHejMw?=
 =?utf-8?B?ZldxV09VUGQvSTQxN1hhcjFVMlFyNXY2VzI4SDVaaE9QYjhYamxpS3ZKMXR1?=
 =?utf-8?B?VkZ3Ky9jMG9LVkNoMVhPUTdPTFQ4b3QxajBnSkltdEg4c1hxTDhLcFZXTEhu?=
 =?utf-8?B?ZllDZEV3ZVM5clhQSXRIVldUWlRGZ1Y1aHR1MUROb3c4ZTlDejNCcTlJNnFj?=
 =?utf-8?B?aEFsL0NvenArRXVoOTFaNWY0NzJjY2Nib0wrYnQwNk02UzJlQmMybzZncmls?=
 =?utf-8?B?cFA3UHRhNWZQU0Fwdmh5RElLdFRaOHd1ZlBBNWpNYWpLaGJidkJmd3VnVm1y?=
 =?utf-8?B?aGRDeU5iQUI4Y0xQbkVSSlRTMXJRQW4yOS81eVZPdVpIQkxHM3JOd04zVWVG?=
 =?utf-8?B?Vk1zZVYvS3hrTWJUbjJuWW5Lam1rK0UrUVU3RFhDWTRGU1BaN1BxZDdpY1ZT?=
 =?utf-8?B?Qlg5bW9PbXRwa01wNTJidDhjUE5XRTV5bFdDV1hNZEg5dEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 04:03:53.4823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0476c8-992e-406a-2b10-08dcb5039ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316

Hello Chenyu,

Thank you for testing the series. I'll have a second version out soon.

On 8/4/2024 9:35 AM, Chen Yu wrote:
> On 2024-07-31 at 00:13:40 +0800, Chen Yu wrote:
>> On 2024-07-10 at 09:02:09 +0000, K Prateek Nayak wrote:
>>> From: Peter Zijlstra <peterz@infradead.org>
>>>
>>> Since commit b2a02fc43a1f ("smp: Optimize
>>> send_call_function_single_ipi()") an idle CPU in TIF_POLLING_NRFLAG mode
>>> can be pulled out of idle by setting TIF_NEED_RESCHED flag to service an
>>> IPI without actually sending an interrupt. Even in cases where the IPI
>>> handler does not queue a task on the idle CPU, do_idle() will call
>>> __schedule() since need_resched() returns true in these cases.
>>>
>>> Introduce and use SM_IDLE to identify call to __schedule() from
>>> schedule_idle() and shorten the idle re-entry time by skipping
>>> pick_next_task() when nr_running is 0 and the previous task is the idle
>>> task.
>>>
>>> With the SM_IDLE fast-path, the time taken to complete a fixed set of
>>> IPIs using ipistorm improves significantly. Following are the numbers
>>> from a dual socket 3rd Generation EPYC system (2 x 64C/128T) (boost on,
>>> C2 disabled) running ipistorm between CPU8 and CPU16:
>>>
>>> cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1
>>>
>>>     ==================================================================
>>>     Test          : ipistorm (modified)
>>>     Units         : Normalized runtime
>>>     Interpretation: Lower is better
>>>     Statistic     : AMean
>>>     ==================================================================
>>>     kernel:				time [pct imp]
>>>     tip:sched/core			1.00 [baseline]
>>>     tip:sched/core + SM_IDLE		0.25 [75.11%]
>>>
>>> [ kprateek: Commit log and testing ]
>>>
>>> Link: https://lore.kernel.org/lkml/20240615012814.GP8774@noisy.programming.kicks-ass.net/
>>> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>>
>>
>> Only with current patch applied on top of sched/core commit c793a62823d1,
>> a significant throughput/run-to-run variance improvement is observed
>> on an Intel 240 CPUs/ 2 Nodes server. C-states >= C1E are disabled,
>> CPU frequency governor is set to performance and turbo-boost disabled.
>>
>> Without the patch(lower the better):
>>
>> 158490995
>> 113086433
>> 737869191
>> 302454894
>> 731262790
>> 677283357
>> 729767478
>> 830949261
>> 399824606
>> 743681976
>>
>> (Amean): 542467098
>> (Std):   257011706
>>
>>
>> With the patch(lower the better):
>> 128060992
>> 115646768
>> 132734621
>> 150330954
>> 113143538
>> 169875051
>> 145010400
>> 151589193
>> 162165800
>> 159963320
>>
>> (Amean): 142852063
>> (Std):    18646313
>>
>> I've launched full tests for schbench/hackbench/netperf/tbench
>> to see if there is any difference.
>>
> 
> Tested without CONFIG_PREEMPT_RT, so issue for SM_RTLOCK_WAIT as mentioned
> by Vincent might not bring any impact. There is no obvious difference
> (regression) detected according to the test in the 0day environment. Overall
> this patch looks good to me. Once you send a refresh version out I'll re-launch
> the test.

Since SM_RTLOCK_WAIT is only used by schedule_rtlock(), which is only
defined for PREEMPT_RT kernels, non RT build should have no issue. I
could spot at least one case in rtlock_slowlock_locked() where the
pre->__state is set to "TASK_RTLOCK_WAIT" and schedule_rtlock() is
called. With this patch, it would pass the "sched_mode > SM_NONE" check
and call it an involuntary context-switch but on tip,
(preempt & SM_MASK_PREEMPT) would return false and eventually it'll
call deactivate_task() to dequeue the waiting task so this does need
fixing.

 From a brief look, all calls to schedule with "SM_RTLOCK_WAIT" already
set the task->__state to a non-zero value. I'll look into this further
after the respin and see if there is some optimization possible there
but for the time being, I'll respin this with the condition changed
to:

	...
     } else if (preempt != SM_PREEMPT && prev_state) {
	...

just to keep it explicit.

Thank you again for testing this version.
-- 
Thanks and Regards,
Prateek

> 
> Tested on Xeon server with 128 CPUs, 4 Numa nodes, under different
> 
>        baseline                  with-SM_IDLE
> 
> hackbench
> load level (25% ~ 100%)
> 
> hackbench-pipe-process.throughput
> %25:
>      846099            -0.3%     843217
> %50:
>      972015            +0.0%     972185
> %100:
>     1395650            -1.3%    1376963
> 
> hackbench-pipe-threads.throughput
> %25:
>      746629            -0.0%     746345
> %50:
>      885165            -0.4%     881602
> %100:
>     1227790            +1.3%    1243757
> 
> hackbench-socket-process.throughput
> %25:
>      395784            +1.2%     400717
> %50:
>      441312            +0.3%     442783
> %100:
>      324283 ±  2%      +6.0%     343826
> 
> hackbench-socket-threads.throughput
> %25:
>      379700            -0.8%     376642
> %50:
>      425315            -0.4%     423749
> %100:
>      311937 ±  2%      +0.9%     314892
> 
> 
> 
>        baseline                  with-SM_IDLE
> 
> schbench.request_latency_90%_us
> 
> 1-mthread-1-worker:
>        4562            -0.0%       4560
> 1-mthread-16-workers:
>        4564            -0.0%       4563
> 12.5%-mthread-1:
>        4565            +0.0%       4567
> 12.5%-mthread-16-workers:
>       39204            +0.1%      39248
> 25%-mthread-1-worker:
>        4574            +0.0%       4574
> 25%-mthread-16-workers:
>      161944            +0.1%     162053
> 50%-mthread-1-workers:
>        4784 ±  5%      +0.1%       4789 ±  5%
> 50%-mthread-16-workers:
>      659156            +0.4%     661679
> 100%-mthread-1-workers:
>        9328            +0.0%       9329
> 100%-mthread-16-workers:
>     2489753            -0.7%    2472140
> 
> 
>        baseline                  with-SM_IDLE
> 
> netperf.Throughput:
> 
> 25%-TCP_RR:
>     2449875            +0.0%    2450622        netperf.Throughput_total_tps
> 25%-UDP_RR:
>     2746806            +0.1%    2748935        netperf.Throughput_total_tps
> 25%-TCP_STREAM:
>     1352061            +0.7%    1361497        netperf.Throughput_total_Mbps
> 25%-UDP_STREAM:
>     1815205            +0.1%    1816202        netperf.Throughput_total_Mbps
> 50%-TCP_RR:
>     3981514            -0.3%    3970327        netperf.Throughput_total_tps
> 50%-UDP_RR:
>     4496584            -1.3%    4438363        netperf.Throughput_total_tps
> 50%-TCP_STREAM:
>     1478872            +0.4%    1484196        netperf.Throughput_total_Mbps
> 50%-UDP_STREAM:
>     1739540            +0.3%    1744074        netperf.Throughput_total_Mbps
> 75%-TCP_RR:
>     3696607            -0.5%    3677044        netperf.Throughput_total_tps
> 75%-UDP_RR:
>     4161206            +1.3%    4217274 ±  2%  netperf.Throughput_total_tps
> 75%-TCP_STREAM:
>      895874            +5.7%     946546 ±  5%  netperf.Throughput_total_Mbps
> 75%-UDP_STREAM:
>     4100019            -0.3%    4088367        netperf.Throughput_total_Mbps
> 100%-TCP_RR:
>     6724456            -1.7%    6610976        netperf.Throughput_total_tps
> 100%-UDP_RR:
>     7329959            -0.5%    7294653        netperf.Throughput_total_tps
> 100%-TCP_STREAM:
>      808165            +0.3%     810360        netperf.Throughput_total_Mbps
> 100%-UDP_STREAM:
>     5562651            +0.0%    5564106        netperf.Throughput_total_Mbps
> 
> thanks,
> Chenyu



Return-Path: <linux-kernel+bounces-567376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F01A6853F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499B819C598D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963724EF6A;
	Wed, 19 Mar 2025 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="izR73lkA"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA92211A0E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366588; cv=fail; b=Dw9SVd8/nF3sSQZ/Ppxjep+F2N4N+oC6SLboRrEtAf5GR6AhSgywrCbmu1iqtBst4KjGuik3cQNH8FfzH6wA2DopllVLGRoED+XPWUaGr57C9vAyTN8zv7dC6GB/7SQL8aFHpyrPUxENK1DQQNcz4gCFb4nBbDbYr0YMryB9Ep4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366588; c=relaxed/simple;
	bh=8iX9yToyeEehIuV54Vul5ZX/9HqgmZtw2NY20EuI6gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WYs2SQN0UwaVcc4WaZN6n6FEqrKMyi0cgsVOBr2jXbfVQY70qEfpS65J38eVO0RPHlNLbTZJfSuegoow31EjJeefilSRY/ZJ0OueRbugTRpx0CD/IhuW5MyOmzji0FQRxlL5kVMH/DaJqYwj3QJ4gHaOYXKtPkot8gnfdD3mRqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=izR73lkA; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czx0tv51JIIKA3v1OlBZVL491MWwOfQNuK5pt6ENinWvtQS1X1hw9qeUSNPB1Fk0shZ688BXaMSy7BV+p/WknQRpO1vXUPX9fDv6MYaSAiBikAlsviUDdTH3yU00N73ebIxNu75FzF/b5JMi5zKg0F9ctpU9/ehwTak9VHSehpw/xm7IVC9uuHKmRMvYwoHu6insQRaNYzl2AawqRujIlbuu+Mz3OV0itb+pw95BFCr6lidz6OoNsZ43qFwWAAqmkaQtISRZuC0FtMALY+rzIgNSrBQFWH/tomtVO9EVCKyya8PxJE9JXEfbq5Y0GkcAOhGNI6O1S8Y3uwSNaj0OOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIAyzosYq3gs/ZdrWTDu5LjraFuK/n4AHenCF1M6MLk=;
 b=vzRAp9foCPZcMdbTK+oGsfqLonHoLPkDj+mTYthDDq+SI+hkaqLpPHpimqax/R53me0ClSzygGcGwZuUr3cbCrhUBiCxHCAqYNtRRaxxlT114Cp+wtZanoI/r4EGX1SOh96+W+TgrOP0gWzhEFBYIDc8843xTe2tPm4IAWVrXbRVToQGVlsbtex41hrtdIn0x+HnBWwqCpFDLPSF0yvZlotMocI7fLq0c1F+fdjWpXcG7p9uBehMnFG8+PQ4Vrq5+uvQ4dOoWXdKkhjX+s2NhHAaY6W3nBAgRCP4LRt4m+jZIetcuEN95WQ6qEoUU4mIUCHEKjBsqPpM4+nASVigmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIAyzosYq3gs/ZdrWTDu5LjraFuK/n4AHenCF1M6MLk=;
 b=izR73lkAU4KvZp5lhIIdGaQTrv814ZH7lH8s8uIuy6ehVt/cWWDCTYEY+wmGvj04GaPd5CMQcZ78YM5H60iaLi2dbpsf1cNEs47m5hHvZcAjtilVRSdkCFjQDy1GiEFIox3w5iGbSN9/yM8pN4fwJaPO3M4QiWZy1QpG34fHQSA=
Received: from BL6PEPF00013DF7.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:9) by IA1PR12MB8554.namprd12.prod.outlook.com
 (2603:10b6:208:450::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 06:43:01 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2a01:111:f403:f901::3) by BL6PEPF00013DF7.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 06:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 06:43:00 +0000
Received: from [10.71.198.71] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 01:42:55 -0500
Message-ID: <beaf9eca-33d9-4fc5-ae9f-64e50b2663cc@amd.com>
Date: Wed, 19 Mar 2025 12:12:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] sched/fair: Retrieve cached group stats from
 sg_lb_stats_prop
To: "Chen, Yu C" <yu.c.chen@intel.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, David Vernet
	<void@manifault.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	<yu.chen.surf@foxmail.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
 <20250313093746.6760-8-kprateek.nayak@amd.com>
 <3915af7f-fe05-4a1b-a8b2-e9690827b916@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <3915af7f-fe05-4a1b-a8b2-e9690827b916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: db3c9fa4-8e09-4710-e6d5-08dd66b14aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVpqcFhDektCNXcyeDJjVjduV3N4Wm10TUxHZWNEZHBpQ2MwcHpFeUhVajZ5?=
 =?utf-8?B?Mk1RZWFqUHF3Yk5BSWNTV2ExNlVzV0xsakFHRzVkZUlwT2diVGxaNkh4eWNO?=
 =?utf-8?B?REF0SFVHYVBJNnVvOTdmTUVFR0NhNXNHVjhMR1AxeDdibnFuY3l2MTU2NkNl?=
 =?utf-8?B?R3ZUT0hDNVczZ1o5anVpU0NwVzJqV29lc01aVXdRcTU4Z3V0T052NVZWMFBv?=
 =?utf-8?B?REhHdjI5V1NuNGtmTXhESnEvekI3ZGh4aVFLN0hlYWpPQWxxZXpzb05hdWlM?=
 =?utf-8?B?c1QxdXoxL3g0TjR1ZkJ1MXhWQ2JWcDVpR1RQaUhmY1Q0OUc1TnZOS0UrdElH?=
 =?utf-8?B?S3VHZ3lFVkF5WXR1U1E3NEMwWldEbWJLLzlQTnduUDZlM3Q2ejBoZWdyN0Jo?=
 =?utf-8?B?SEcycmlZVnhybFJsbWNRQm55QUNGTitHc3BGTHFhT2N4c0VmamtJZ2ZsdjlG?=
 =?utf-8?B?SGpJUnZGRlY3QzlxMys2MmdsSnJOSnAxQzRDM0FMTDd6emdIYzFVektCZ0Nj?=
 =?utf-8?B?RTBqdnZkcTl6SUxiSVFGSkVxakJESG1qbTZROUtrSUEyRlZaNTQvbXdyOTEv?=
 =?utf-8?B?a1VZSFlzTnVRbE1ZeWZoVkZrRlN0cnA1Zlk1bGpSR3VIMGtSSUtCVXVqL0gz?=
 =?utf-8?B?SVg4cVZSaGlkY2J1ZlgzN0M0VW1BSGVsY25xVmlqYWFGQzFNNVQyVUQ1OFU5?=
 =?utf-8?B?eERRS2FnSUN4cHdxMmpxbkkwUHQzVlFFclFkajUwSHI4K3M5dVAwd0ZkNHNx?=
 =?utf-8?B?alk4TzhEUDYrQTV3U3dpNE1pVzBhcVJQTjlLK2cwcmZCNUx6Q2JTL2dIdW5G?=
 =?utf-8?B?T3ZoZjFuVmJlNXR2cVpyeHNnQ1U2bUpLUXRzQ1p2aGlOT0Era3ZFU2pLWStP?=
 =?utf-8?B?YjFXVlJ3MVpCcVlXM3dRSXlXNDhacVpIaU8rc0VFb3ZXYUpTTENXVmFhNUw3?=
 =?utf-8?B?WWlwaGg2VGEyN21vRFExR1R0bmFITUF5NW1nSnZYam1JSGhSa1RTS1puNzlS?=
 =?utf-8?B?b2M2QklVY3IvNVcxZHlMTWFWUGFQNzJnWFdTQW9EdC9NbER0RkRhRXVBUUNz?=
 =?utf-8?B?TEpBdjV4RUNSMFRxQnM1ZENvZHVDMjNYTldkOFZpZDBWK2djZ2ZTVW9jeU1x?=
 =?utf-8?B?c2gyMHRkV2dyRVFLamhMTWRyRG1hcS93WUpKZHg5VXJBSGNiVTdqOHl0NEVR?=
 =?utf-8?B?ME9nNmd4UDRQSmhQdlBUbndqNmtwUXhmWUpQckhDV1FkTjRNMTV1VlNTbEJV?=
 =?utf-8?B?ZVdaZzJJL2M1d2toOUM2TGphcHJieEE0SldCYmgyWkN3T2NOeldmdlJPbkcz?=
 =?utf-8?B?YUFyV2g5ZklFd25YRlZwRFJlNGNSQWlhRm9lL3VNQnVtZTViMWQ4d1Nodmxp?=
 =?utf-8?B?SExzWmFjbm54ekF2SkMvMVFnR1Bpa0FBb3FwQnRzTEFZS3ZabUw5WjVNcHh1?=
 =?utf-8?B?K0tGTW5vWVFwVzhmZEpFbmRTZ0ZZSDF1cG51MG52bks4S0NrOCsyQ1FCdlo5?=
 =?utf-8?B?M0xqK0oyajdGVmFXdWFwNGxlc1Y1UFdPSTY5dEhQa3V6Y2M3bDdqRnlBQUQ3?=
 =?utf-8?B?K3RDbEE4VFJaZmRPcWN5eTFXemdKTmFaOU4rcWkxRTk0Q004NXJzNnZOWU5Z?=
 =?utf-8?B?TTlZdUhrVGtNZ1pIcmN2UWlGaWFNZjJSSVJIaXpyUFgyUVhBTUZ1enE0NVZS?=
 =?utf-8?B?M2FhSmE3ZnZpcGVIWVRKS0JGYWgwZDNoZHZkYXRhVmd3dE5ZeDRMTnpUeUhK?=
 =?utf-8?B?SDlpeUtwN0JLNHpRK0M2SlBFM2lRb2xENU9CUUZjcm0vb3JNOHJkUEVmZDZv?=
 =?utf-8?B?dWtZdXFvU3pzd0k1dmVNSnRoQ3NPbCtCQ0I3RlUxVXBKUjdlTXdGVVRTM1g3?=
 =?utf-8?B?ZklSbnJNRWtPN29oUHRyUXJrWFV3NWJVaGFVRVJVanN2Wnc1ejZMeUpWb3FI?=
 =?utf-8?B?QnF2Y1o0dVRRZFQ4NThTQkY1RkhXaHZjMFYzYWFJbFNObWl3b0dUaGVOY2JO?=
 =?utf-8?B?NklTbnZ5dTNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 06:43:00.3575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3c9fa4-8e09-4710-e6d5-08dd66b14aa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554

Hello Chenyu,

Thank you for taking a look at the series.

On 3/17/2025 11:34 PM, Chen, Yu C wrote:
> On 3/13/2025 5:37 PM, K Prateek Nayak wrote:
>> Allow update_sg_lb_stats() to retrieve the group stats cached in
>> sg_lb_stats_prop saved by another CPU performing load balancing around
>> the same time (same jiffy)
>>
> 
> If I understand correctly, we allow update_sg_lb_stats() to retrieve
> cached sg stats if another CPU in the same sched group has just done
> load balance within a jiffy ago, say 10ms for CONFIG_100_HZ.

Quick disclaimer: All of this is best effort currently.

Periodic load balancing is easy to start since it only happens once a
jiffy at the maximum so "last_update" as a jiffy counter should be
good enough (in most cases).

Secondly, and this is slightly harder to solve for, is to get all the
CPUs to actually sync. Currently it is a best effort case since the
tick can fire late due to disabled interrupts on CPU, SCHED_SOFTIRQ
may run at different times depending on how much work is done at tick
prior to reaching the softirq handler etc.

But assuming some amount of sync, I would like:

- During busy balance only one CPU gets to proceed as per
   should_we_balance() heuristics. In addition to that, since all CPUs
   are busy (should_we_balance() would have allowed the first idle CPU
   to go ahead otherwise) the "idle_cpus" and "overloaded" situations
   may change and those are hard to propagate.

- By the time this CPU does busy balancing, other groups below it
   hopefully had enough time to reach update_sd_lb_stats() and cache
   their copy for this jiffy in there. If not - the load balancing CPU
   will recompute.

- Since stats at a higher domain is used only once, there was no need
   to invalidate them which I couldn't get right back then (or maybe
   even now :)

> 
> There are two roles,  writer who updates the cached stats,
> the reader who reads the cache stats. For both cache writer and
> the cache reader, do we trigger them only when it is in busy periodic
> load balance? If yes, consider the periodic load balance is usually
> triggered on 1 CPU in each SD(should_we_balance()),  and the
> interval increases with the number of CPUs in that sd, just wonder
> if 10 ms is a little short to find a cached stats on large LLC?

So the reader is always the CPU going to the higher domain and
recomputing stats. The writer should have updated the stats by then
or the reader won't care and recompute it.

At the very least, since the CPU has to look at local stats too, the
logic ensures at least that is reused and not recomputed.

Beyond the annotated PATCH 9, I've moved to a versioning scheme that
could also be reused for newidle balancing with stats invalidation
and that should help reuse stats more. There are some stats on the
empty PATCH 9.

-- 
Thanks and Regards,
Prateek

> thanks,
> Chenyu
> 
> 
>> Current implementation without invalidation of cached stats have few
>> limitations namely that the stats reuse is limited to busy load
>> balancing since stats can only be updated once a jiffy. Newidle Balance
>> can happen frequently and concurrently on many CPUs which can result in
>> readers seeing inconsitent values for the propagated stats.
>>
>> For this iteration, the focus is to reduce the time taken for busy load
>> balancing allowing the busy CPU to resume renning the task as quickly as
>> possible.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---





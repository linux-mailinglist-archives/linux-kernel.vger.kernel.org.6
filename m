Return-Path: <linux-kernel+bounces-315193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA61896BF0E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCEA288E21
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FB1D9357;
	Wed,  4 Sep 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PtMWiDg6"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92301D04AF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457810; cv=fail; b=gOZb+5tuuWDpY8TOJtxNVsj1O0428QOwZUPs8WywTK87h4S9RaXHcpGuMZ0B1V2/Xl+lUmdHXQkqzkDW9Xp1wcTkQnPUFXUlm+Yv1vPRrJAHvowbOPT5Usz6TOR58+OmsrQuOVONjqat2lm30L49LadVoAV5UMHQdoReCyc3dUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457810; c=relaxed/simple;
	bh=GGJe181Wgd0Z2LJj4tezKVw76TDblLWgyBBNaWtFcCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gS1R6D0Fo4ihgIJPJ3CZ2igWh1HMadk5dnFHMyFP8WdpRuMhk4RbT8/pJKRD7g9iB0zh+8ZcHufvkZtsLJn/EQnN2v4TjPHSZTXQmqz/IeE7oJDc4ThbiR2ZmyDsBGYzIgPEGSm0nrVz9zKwonhBZPVmvOIYa/HBESs+FQbls6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PtMWiDg6; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+Fk1M9d5AgEDbkyotUuAC9ApFZ7Xn9++6tZcCMB6hJoutpErbpq48GZJhJDlmPGkCWyvqRsWyZN37k17/dQHl5G7VKewi1Il/Ix580XPQnFLmGc772wUEQHFuF6tVkrjZNliuWw/PJ3EezHj5wesE+LcwHLQKjTwsM/wppzo8KPNI8rEJg4PSgdgvvXktyhP9eluc5KC9+DRU2YrIl+ihOfrKVyLFpWiyZi8wGDgfZHHZFqL115geA18VHk0Z01UGpNJ5ze0He18B+QZs2QkEUj1nYDBrM4EG4+pCxLXgK5wcdlL6BL46UGNtBrJvuwfPWPF/Y7w5MpHQTboSyuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQzDM8DIOdYRcqgA1M+VuCbRRTFHvVbwinOGtYRtjqQ=;
 b=EWJIF5K/5zJUphcL6KykWPFjISv5Z0UYm7qmKQcmiMqwT5GxWNHFZpFLNTM1qVr9cMk0PA1JsIcZDwwq+IhGeFn5SQSN6iHfPvMuL0mUDroP5W7QRFbhhYsneYdDnVr0TpbF1TBUpxiWvr32ixOOO0ryG0ffuJ5PvrbRpokvpRNtIarVkvREz09oDJfcmX7J29cp8Ba0Nw40YEOCr4E+Iq/h3DN3BJ9dFIO9qWsqCbj3OgUtWOyDrIqzyfJbOrUW4AXWkT7XSilkp3CZ99cQYYT/OfCKL8uxo7i6MlH0gVRmkLARe/x2DF96S5j/iuGLDmh9yLKNg+UbktJ/7Z0ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQzDM8DIOdYRcqgA1M+VuCbRRTFHvVbwinOGtYRtjqQ=;
 b=PtMWiDg6GSPanovmEYk6BORUzbkdXX4k2avxjjDva4UGGC53kApmMKTzZ7tv9ddvHM82VT/2eXNCOzOsfjb6UbS6Y5jhuMjLmmw+23Xl/tdPW+9ZQrOVIKCGcECOu1E27e4sd7kDc23Z/dcP7SzcwXVEE2sgif+VWdcDCjTrxRI=
Received: from BN9PR03CA0215.namprd03.prod.outlook.com (2603:10b6:408:f8::10)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 13:50:03 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::ef) by BN9PR03CA0215.outlook.office365.com
 (2603:10b6:408:f8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 13:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 13:50:03 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 08:49:55 -0500
Message-ID: <fdce27c2-ecf0-6c89-a372-3f93ce99ca61@amd.com>
Date: Wed, 4 Sep 2024 19:19:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v2 0/5] Idle Load Balance fixes and softirq
 enhancements
Content-Language: en-US
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
CC: Leonardo Bras <leobras@redhat.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, Thorsten Blum
	<thorsten.blum@toblux.com>, Zqiang <qiang.zhang1211@gmail.com>, Tejun Heo
	<tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Caleb Sander Mateos
	<csander@purestorage.com>, <linux-kernel@vger.kernel.org>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Chen Yu <yu.c.chen@intel.com>, Julia Lawall
	<Julia.Lawall@inria.fr>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240904111223.1035-1-kprateek.nayak@amd.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240904111223.1035-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 0813a6a0-7c07-4808-72ab-08dccce87a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVNGNWxnenhkaW5RT2JSb21OVG1jZmFWMmM4REtZM1l2LzZFK2JSVWZIYjJp?=
 =?utf-8?B?Q0ZGVjA3WkdDK0l1bVA1clRyU1Q3MWtISnJCYVI3UUlHMTQwOVhpblYxaldD?=
 =?utf-8?B?R3FUL3M5SmFqVVR4MnpqU01Qb3U2MFFFTmhkT0ozSXR3Qnk4eVVkdlF3cFg2?=
 =?utf-8?B?V2M2VUZYL09ZVUdwb0dwaTdJZFdmdFphVU9oRHNGVVVIaHdRS0xleU9rTCs1?=
 =?utf-8?B?ZE1BVGllOFkweWdieEcyT2orTkFZUGhPU2RQM3R2UTQ4OVpWVU9LditsR2lV?=
 =?utf-8?B?ZGdBenJJSElrYStqL2Z3K0hxMTE0aTJJUE8rTFpHRzkvVEE2R0xVN1U3VFFC?=
 =?utf-8?B?eGVnenFGNUx5SGd5dm55NFlkZmxxZzFBaFdYZzhKdElILy9CUlQ0akIyUlZu?=
 =?utf-8?B?eGtWMWFTeU5RaHNySDNlUjlJRUMzSzI1cDVGRjgva2Y3eGl4bDdkWVJCR1FL?=
 =?utf-8?B?MzlDMXBEa0Yvd3lrUGFNc3dQTGRoaC82QTE5cHR4aEZrc3NoVmYvNkpvdXlh?=
 =?utf-8?B?M1VDbEpXNmo5T29kK3AxR3VqNHcxVnNWL1Y1ZFM2cW1Tbjl3YmYyZzZ0WFFa?=
 =?utf-8?B?WFhZU3pYamFoa2VsbnZ4SytnSkNqQXUyU04rcEY3UFhHaFRKcXlyNmd4THNL?=
 =?utf-8?B?SGFtc05WUVlsLzQ4MkhaNzd0aGo2UFZwM3kzTzFCSzVNTE93TFVwVW9YUGdU?=
 =?utf-8?B?WXUyUkc3MXVnRDlGMkpsTGRaaFR3RzJSSjhxZk1ScGlpbXlKa0wvMGtQOUEz?=
 =?utf-8?B?VSs4NzlkOXpvdFh2ZGsvTzUvZ1MyS2ErMUxWMTVXQXZsVWowM2E1UDhwK1VH?=
 =?utf-8?B?TC8wd0RvZXVwTlAyV0E2cUtwWTFWRThuTjNXR2MzY3RSd0ZyY1FBVkdEbkNQ?=
 =?utf-8?B?eFlKZXlWaldTSUZYR2kzQ2NDT3l4N0xmU3gzVWtYSkx5UVRsWk5ieFRicGdk?=
 =?utf-8?B?OWpSam9xVk5YL0YycWhndDFqbngwR1Z3RHNDdTlvakVOZmk5K3RLMEttNFR1?=
 =?utf-8?B?UlQ2dmZTeEpUUzlVN2x4YlgraG9QcGcwVG84RXE5ZWcyOWJBM21kMmoxL1RO?=
 =?utf-8?B?eGlwSDNZOG9FclVNNjNGZ2h0T1NUWVlzNXRzcFFHRWNINzFrVk9XSThISnpS?=
 =?utf-8?B?MEU0R2NYY0R3bm9QZUhHdCtQOHlvNnRjeGg4UmdZTFpDajdCVnBJZ3l0aHpH?=
 =?utf-8?B?ZHZ3S3diS0dxTEVyOHExYkUvSHhFc1JhMTE0eHA2QkJXOGg5ZUJyd1hzVjBr?=
 =?utf-8?B?aU9PUzBTNVA2SjAwRkExQjhMSmZqY2RPVlV4WTQ1Wm1sdCtBcmEvQzhEQ01J?=
 =?utf-8?B?NTRVbFFGQXUwdnF1amxYc3JPZ2VpcjhqTDRxZGFHWEM5Z2wybTdyalZjYW1u?=
 =?utf-8?B?VmxzN3RCNklNSlRlVWQvODV4aWthUGx2blhCVmNGZUxoQTFyN2hsSVNhRUMy?=
 =?utf-8?B?QXg5SzdOZm9IYUtDbEJzNnRlYW1kRGc3TW1OMFZEVGRXUjVPaXhFV3NQeWpq?=
 =?utf-8?B?ckl6K2VVYmRIKzlnY0xhQnZ1SklwKzNkWUp4OVVEY0ZOa2pMTzNaczRsUGRM?=
 =?utf-8?B?RU9DZW9YK0ZxS05ZL0w1U0lIKzgzbEwwUzlFQ1JDTWtFVjVIRmVUanVQcXRz?=
 =?utf-8?B?L3VIaG9mZzQ2Ni93dmx1dnZyZFZoK0tBbEV5NUY1OWxDd0ZnSnZaMnlyOTNs?=
 =?utf-8?B?cjF5eEhMQ2I4L0pSOVExUFVWbE9sZlJMSG9IZ0xYN1B3MlRZbzdjcE9pekVZ?=
 =?utf-8?B?eFhsalhxQlRJczFaV0I5bFRGMFliVXk3VE5aRVRETXE0Y0NBaUJtenZ5OWJL?=
 =?utf-8?B?a0luZTUyc2xxWlpvRlBDZVpkeFY0Sk04OXBuR1djTlZ3VW5kdlorcW12SlFt?=
 =?utf-8?B?L0o3NTJHdjR0cDVwUzVBdjR3alJVRlh1VW9lOGtaVy8zSUY1eWpRdDUySVRj?=
 =?utf-8?Q?Ujx+3pfMUBA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:50:03.5845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0813a6a0-7c07-4808-72ab-08dccce87a52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721

On 9/4/2024 4:42 PM, K Prateek Nayak wrote:
> Hello folks,
> 
> [..snip..]
> 
> Chenyu had reported a regression when running a modified version of
> ipistorm that performs a fixed set of IPIs between two CPUs on his
> setup with the whole v1 applied. I've benchmarked this series on both an
> AMD and an Intel system to catch any significant regression early.
> Following are the numbers from a dual socket Intel Ice Lake Xeon server
> (2 x 32C/64T) and 3rd Generation AMD EPYC system (2 x 64C/128T) running
> ipistorm between CPU8 and CPU16 (unless stated otherwise with *):
> 
> base: tip/master at commit 5566819aeba0 ("Merge branch into tip/master:
>        'x86/timers'") based on v6.11-rc6 + Patch from [1]

So that should have been the SM_IDLE fast path patch in [3]
https://lore.kernel.org/lkml/20240809092240.6921-1-kprateek.nayak@amd.com/

> 
>     ==================================================================
>     Test          : ipistorm (modified)
>     Units         : % improvement over base kernel
>     Interpretation: Higher is better
>     ======================= Intel Ice Lake Xeon ======================
>     kernel:					[pct imp]
>     performance gov, boost on			  -3%
>     powersave gov, boost on			  -2%
>     performance gov, boost off			  -3%
>     performance gov, boost off, cross node *	  -3%
>     ==================== 3rd Generation AMD EPYC =====================
>     kernel:					[pct imp]
>     performance gov, boost on, !PREEMPT_RT	  36%
>     performance gov, boost on,  PREEMPT_RT	  54%
>     ==================================================================

PREEMPT_RT kernel is based on:

     git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-6.11.y-rt-rebase

at commit 01ab72c93f63 ("Add localversion for -RT release") with the
addition of commit e68ac2b48849 ("softirq: Remove unused 'action'
parameter from action callback") from tip:irq/core and the SM_IDLE
fast-path patch from [3].

> 
> * cross node setup used CPU 16 on Node 0 and CPU 17 on Node 1 on the
>    dual socket Intel Ice Lake Xeon system.
> 
> Improvements on PREEMPT_RT can perhaps be attributed to cacheline
> aligning the per-cpu softirq_ctrl variable.
> 
> This series has been marked RFC since this is my first attempt at
> dealing with PREEMPT_RT nuances. Any and all feedback is appreciated.
> 
> [1] https://lore.kernel.org/lkml/20240710090210.41856-1-kprateek.nayak@amd.com/
> [2] https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/
> [3] https://lore.kernel.org/lkml/20240809092240.6921-1-kprateek.nayak@amd.com/
> [4] https://lore.kernel.org/lkml/225e6d74-ed43-51dd-d1aa-c75c86dd58eb@amd.com/
> [5] https://lore.kernel.org/lkml/20240710150557.GB27299@noisy.programming.kicks-ass.net/
> ---
> [..snip..]
> 

-- 
Thanks and Regards,
Prateek


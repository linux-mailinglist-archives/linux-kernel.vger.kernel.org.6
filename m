Return-Path: <linux-kernel+bounces-397664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4689BDEC2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13C9B2343E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877011922E5;
	Wed,  6 Nov 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pb63l/Xj"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A6D190676
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874025; cv=fail; b=jfez961vnwJzXU/2E0DQldxZpLeinQ68UMXtjHKCWg0eXz293U/IcIn+2Tzclc5efJyN/5rQqtVqUmJawljPUlRuRF751ZxijTu6s0WdHE/wtVFVmL3KjDNdPHJ/kVYaOdhNRUXg/6MDfby3b3ERcQdBW+/IVIRlabUMXezrVfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874025; c=relaxed/simple;
	bh=FcFcvh5zC7Elc4Z9X/4M3v9IQMmRNRsdxh+vdwPe5Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f9z/Ou44xL/BRPL9J5XCKX+pNUP5r8zdCUw73MJKaU+yx76MUsn+gTH3jSTAHDBKEmEwOM4Zm9AClAQEdEQvR3mcyoXYUMwsHCPn2TxR+UmAzPEhDMIvRII+auYvCEiqB++lqgn6nxq2AXu2r/2t5+MXKYpdP3nNXU58Xrcc0Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pb63l/Xj; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F72Dkx5yJDOj2FXpOhbp65TxkM9FhggZXlQn0J2iWxRuejpHk0TGLpgoNSWPCrHWn/y7gHZQE1IN3eXU8Xm+Wuoo0DCZIy2gihyO5ZYlJJpzyEsAm7eYgKaTr+5OxKtddJjRLYaQFml8u++v7RiL84mELLkPeAk5zcVePrkMxq/DYhJo9CnXdFCjTsIyb1C/9z041dBX6PtJx/xKS5cP6vhKCsulL018J3Q1ygaw8gwuOulH36NdeEGcE8fMpU/UJHj9xFvsbScTRrb8+GLlNdPXbLRmapk2McgEeRByhT8dl55ftomwdZ+uLxqBAYjv+JmuIj+80xxaoufgDqjVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/yEadHbshYLDAWXDn0Hyn7w4EH8fDqgyXQYiTHyy2A=;
 b=QSMj5MrOtx+HVvNhyXuV6X9ssb1S8QiqDPrlSgzxDQjgmyj+gR3Tcjtpp3b1uaqXB3SezKAGWc//Ctio2AdUeHwXozcUdT97QScyH0ovgNf4ZLiRutGxMRK2kOmfWKhZz91EBd/FYbO5zUsrEd7n29J74lP0h/7UN5XTSLAOB+ZALoCDGK7P+ZEhSs5aQ1kWlIaAc94s3WyDJgVqcKI36MCq0xzZ9zGbnl17fAgR5e/RLdx6evaIR2lxcmNiW4fODCedrVUPxB/TVDAEzsgAozD6bnRNNwU06QftZEJsw9pcnsrJlILSUxioeFUEFZKHHN9MBki0KRObU9jsINcyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/yEadHbshYLDAWXDn0Hyn7w4EH8fDqgyXQYiTHyy2A=;
 b=Pb63l/XjiZPbIkw3PmftGWWiQy9oBSd1G0Zp997vhWMsQx54ZlkAqareH2MudXoIxyKb73iuRw/iQUUJJQZ7OokKKKCzXhAuGmGiLxXt4c/rGU/rnF6Z9+WqPdxK+E6Pv8sFIJD3hO8x20RPlG7B43gI5MIm2mnJe+vbY03WrIo=
Received: from SN4PR0501CA0129.namprd05.prod.outlook.com
 (2603:10b6:803:42::46) by CH2PR12MB4310.namprd12.prod.outlook.com
 (2603:10b6:610:a9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 06:20:16 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::b5) by SN4PR0501CA0129.outlook.office365.com
 (2603:10b6:803:42::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.12 via Frontend
 Transport; Wed, 6 Nov 2024 06:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 06:20:16 +0000
Received: from [10.136.47.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 00:19:02 -0600
Message-ID: <4a3dac53-69e5-d3cd-8bc0-3549af4932b3@amd.com>
Date: Wed, 6 Nov 2024 11:49:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/24] Complete EEVDF
Content-Language: en-US
To: Saravana Kannan <saravanak@google.com>, Samuel Wu <wusamuel@google.com>,
	David Dai <davidai@google.com>, Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>,
	<tglx@linutronix.de>, <efault@gmx.de>, Android Kernel Team
	<kernel-team@android.com>, Qais Yousef <qyousef@google.com>, Vincent
 Palomares <paillon@google.com>, John Stultz <jstultz@google.com>, Mike
 Galbraith <efault@gmx.de>, Luis Machado <luis.machado@arm.com>
References: <20240727102732.960974693@infradead.org>
 <CAGETcx97SEHP5MspzBHsMkmSExnY870DQ-F5L077vzOGnPx0UA@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAGETcx97SEHP5MspzBHsMkmSExnY870DQ-F5L077vzOGnPx0UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e559503-fcfd-40ee-7869-08dcfe2b14d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWI4YlE4OUxuVTdDZ2s5YjB6U0tRanhhZ1l4MkhzQUFIL1RzOE15RXFRdytK?=
 =?utf-8?B?bTJXYjlveWYzTHk0b3FlSzVhRFZPZ0VwS29yeFVEY1Z2d2Q2OGlONkJuWkE2?=
 =?utf-8?B?empub1NHUHU4THZva3N5NzFWYktPUkQwMEdXS21FZ1FveUh5ZEFWcmdWVUc4?=
 =?utf-8?B?WU5OMUFMeWRBSGsrQ3N4WENEQ2QzQ0F4aTJEd1RLSGdVNFh2dEVXMnZqaGdI?=
 =?utf-8?B?UVVZTXArQUgrRWpJSE9BMHFEekZUVXZrZnh4akl3U1hCYTIzY0lKUnlUcHFi?=
 =?utf-8?B?STJ3dXRrY2lSaFpiRWZvUVNzbmt1Mk9OQXBPdGZXQWNxYlpxNW5wUzQzQ2xC?=
 =?utf-8?B?WG5oTEU4MitCcUxrRzdNZG5VU3RoNUxQQm9pdEpMcnlKKzMyN0RxSHJUZ3pH?=
 =?utf-8?B?QWhpVnVvb2pFTWtCWHg3Z1BYdTVhNU10TllCSGRTMmRxMjVJQmhodlBXaWh5?=
 =?utf-8?B?L1oyZWJlV1FlQzA5Tk8wSkpjdWNHUjRtaUc2S003cURIblUzdXNsdnZmZk9V?=
 =?utf-8?B?WWE1SkJwc0JadmdDcTZUR3NMYW9LWEltei9JQjRnSlFySWtuN3pmdkhkMk9N?=
 =?utf-8?B?cDlxcDU0Qk1IMnNnN2srWXNwcm05dFlQRWJkNEdtQkdCMEFWM3pORThNeUxR?=
 =?utf-8?B?bE5EOHhzWHN2Qi9menJ0YkhRQ04wcWhZV2oxVk9MMm1wZ1R1WDZnN0pwUy84?=
 =?utf-8?B?RVJHMEYrMU5aT3JTanNJRjdmMFFpcms5YjYrVmNHeXNETllEM3hZc240WHEv?=
 =?utf-8?B?UUpmNGgzbFpmb0tXRnVwakV3MENjcE81aU1JVFI5bVhYaVlYb1BKT3JjUUI1?=
 =?utf-8?B?Z1dyRG9QU25kSEd4NzIzMXEwYVd1NURtL2FnVnRFRVpiTmRHQ3BQZ09OdGR6?=
 =?utf-8?B?TWV1MWM4OXI3SGVIN25ueHlvUFZzMzgvaHQzL0pxc2xpdkRWbld0RWt4bE5K?=
 =?utf-8?B?OXhSdXdSOUN2NEJYR2pmY3A3Qk5obGwrYUlHWmc4dmJPR1d2UFhwVVovdkFI?=
 =?utf-8?B?aHA2eWp4K2MwdjJUYmNhcVdHU241cDJ6UUh4Mkg1RTVPMGtIZUV2K2xISG91?=
 =?utf-8?B?L09LNUp2MURIVEppbDNEaXlDL1paYWpFUGNjUFFaSFg4VXo3RlZaNDdzUnlK?=
 =?utf-8?B?cmdYVDFmbm1kN2xLWXkvd2ZmeHBVaTlPUEFlR00xV095cHkvY3VFbHlFT3VY?=
 =?utf-8?B?dzY5ZWpPRXFVVEkzTGhkN2Vldk5rNGdxSlZ3Z3lOL2FibGhoU3R5R21RNzBa?=
 =?utf-8?B?MzNCeDJERG9SWmYwRmVEZ3lxZGgzUnp6MDZ3blRCS0Mzcm55MEUyRHZTMkRx?=
 =?utf-8?B?VFZRZDFJNFdJNnVyWGkzZkVPYlNNRGJzQnVaN3U4YVdQbXFVeU5NNXprVlB6?=
 =?utf-8?B?bGlMT1YyNmNNbG5lLzY0dXpmVTUxNWpCQ3lCQkRtKytKQ081TXk0S2I2YlRH?=
 =?utf-8?B?V3lVVXU0d05rbmgxeG91d0hkU0pab3BuaFZvU1BqOUh4MStYbmxSWXA3RUlp?=
 =?utf-8?B?bWd5cXdtOFdIVGdta2YvSGQwZGdJS1Byc1NCOW9jbTYvQ01MbkV3QmZ0ZHFE?=
 =?utf-8?B?K0JNU0JpM2lLTy9JcmxnWGdzTWJXV2tuUWdNY01abHRtNmUvOHRZTVlBUURs?=
 =?utf-8?B?cy8zZ3RKaWNWd2E5Wk8xaFQzaEhDTFZUMisyRFZKanNseTV5SWtpMm96NHZo?=
 =?utf-8?B?UjY4VElCVGxvWER3bldaS1FLeWc1VkFiMkNwOTJBZzFEdGUvRTNMSithL090?=
 =?utf-8?B?MHRmU0FwNG9JVzZhL0NvQlErbVl3MWhIK3o1YmVqZENnaWVGWWpGVk96bG1o?=
 =?utf-8?Q?ny6iq659gjpbNdCAYWXueKtEF+t6rgLSf7I/g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 06:20:16.5544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e559503-fcfd-40ee-7869-08dcfe2b14d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

(+ Mike, Luis)

Hello Saravana, Sam, David,

On 11/6/2024 6:37 AM, Saravana Kannan wrote:
> On Sat, Jul 27, 2024 at 3:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> Hi all,
>>
>> So after much delay this is hopefully the final version of the EEVDF patches.
>> They've been sitting in my git tree for ever it seems, and people have been
>> testing it and sending fixes.
>>
>> I've spend the last two days testing and fixing cfs-bandwidth, and as far
>> as I know that was the very last issue holding it back.
>>
>> These patches apply on top of queue.git sched/dl-server, which I plan on merging
>> in tip/sched/core once -rc1 drops.
>>
>> I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.
>>
>>
>> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>>
>>   - split up the huge delay-dequeue patch
>>   - tested/fixed cfs-bandwidth
>>   - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>>   - SCHED_BATCH is equivalent to RESPECT_SLICE
>>   - propagate min_slice up cgroups
>>   - CLOCK_THREAD_DVFS_ID
>>
> 
> Hi Peter,
> 
> TL;DR:
> We run some basic sched/cpufreq behavior tests on a Pixel 6 for every
> change we accept. Some of these changes are merges from Linus's tree.
> We can see a very clear change in behavior with this patch series.
> Based on what we are seeing, we'd expect this change in behavior to
> cause pretty serious power regression (7-25%) depending on what the
> actual bug is and the use case.

Do the regressions persist with NO_DELAY_DEQUEUE? You can disable the
DELAY_DEQUEUE feature added in EEVDF Complete via debugfs by doing a:

     # echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features

Since delayed entities are still on the runqueue, they can affect PELT
calculation. Vincent and Dietmar have both noted this and Peter posted
https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.tip-bot2@tip-bot2/
in response but it was pulled out since Luis reported observing -ve
values for h_nr_delayed on his setup. A lot has been fixed around
delayed dequeue since and I wonder if now would be the right time to
re-attempt h_nr_delayed tracking.

There is also the fact that delayed entities don't update the tg
loadavg since the delayed path calls update_load_avg() without
UPDATE_TG flag set which can again cause some changes in PELT
calculation since the averages are used to estimate the entity
shares when running with cgroups.

> 
> Intro:
> We run these tests 20 times for every build (a bunch of changes). All
> the data below is from the 20+ builds before this series and 20 builds
> after this series (inclusive). So, all the "before numbers" are from
> (20 x 20) 400+ runs and all the after numbers are from another 400+
> runs.
> 
> Test:
> We create a synthetic "tiny" thread that runs for 3ms and sleeps for
> 10ms at Fmin. We let it run like this for several seconds to make sure
> the util is low and all the "new thread" boost stuff isn't kicking in.
> So, at this point, the CPU frequency is at Fmin. Then we let this
> thread run continuously without sleeping and measure (using ftrace)
> the time it takes for the CPU to get to Fmax.
> 
> We do this separately (fresh run) on the Pixel 6 with the cpu affinity
> set to each cluster and once without any cpu affinity (thread starts
> at little).
> 
> Data:
> All the values below are in milliseconds.
> 
> When the thread is not affined to any CPU: So thread starts on little,
> ramps up to fmax, migrates to middle, ramps up to fmax, migrates to
> big, ramps up to fmax.
> +----------------------------------+
> | Data            | Before | After |
> |-----------------------+----------|
> | 5th percentile  | 169    | 151   |
> |-----------------------+----------|
> | Median          | 221    | 177   |
> |-----------------------+----------|
> | Mean            | 221    | 177   |
> |-----------------------+----------|
> | 95th percentile | 249    | 200   |
> +----------------------------------+
> 
> When thread is affined to the little cluster:
> The average time to reach Fmax is 104 ms without this series and 66 ms
> after this series. We didn't collect the individual per run data. We
> can if you really need it. We also noticed that the little cluster
> wouldn't go to Fmin (300 MHz) after this series even when the CPUs are
> mostly idle. It was instead hovering at 738 MHz (the Fmax is ~1800
> MHz).
> 
> When thread is affined to the middle cluster:
> +----------------------------------+
> | Data            | Before | After |
> |-----------------------+----------|
> | 5th percentile  | 99     | 84    |
> |-----------------------+----------|
> | Median          | 111    | 104   |
> |-----------------------+----------|
> | Mean            | 111    | 104   |
> |-----------------------+----------|
> | 95th percentile | 120    | 119   |
> +----------------------------------+
> 
> When thread is affined to the big cluster:
> +----------------------------------+
> | Data            | Before | After |
> |-----------------------+----------|
> | 5th percentile  | 138    | 96    |
> |-----------------------+----------|
> | Median          | 147    | 144   |
> |-----------------------+----------|
> | Mean            | 145    | 134   |
> |-----------------------+----------|
> | 95th percentile | 151    | 150   |
> +----------------------------------+
> 
> As you can see, the ramp up time has decreased noticeably. Also, as
> you can tell from the 5th percentile numbers, the standard deviation
> has also increased a lot too, causing a wider spread of the ramp up
> time (more noticeable in the middle and big clusters). So in general
> this looks like it's going to increase the usage of the middle and big
> CPU clusters and also going to shift the CPU frequency residency to
> frequencies that are 5 to 25% higher.
> 
> We already checked the rate_limit_us value and it is the same for both
> the before/after cases and it's set to 7.5 ms (jiffies is 4ms in our
> case). Also, based on my limited understanding the DELAYED_DEQUEUE
> stuff is only relevant if there are multiple contending threads in a
> CPU. In this case it's just 1 continuously running thread with a
> kworker that runs sporadically less than 1% of the time.

There is an ongoing investigation on delayed entities possibly not
migrating if they are woken up before they are fully dequeued. Since you
mention there is only one task, this should not matter but could you
also try out Mike's suggestion from
https://lore.kernel.org/lkml/1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de/
and see if it makes a difference on your test suite?

-- 
Thanks and Regards,
Prateek

> 
> So, without a deeper understanding of this patch series, it's behaving
> as if the PELT signal is accumulating faster than expected. Which is a
> bit surprising to me because AFAIK (which is not much) the EEVDF
> series isn't supposed to change the PELT behavior.
> 
> If you want to get a visual idea of what the system is doing, here are
> some perfetto links that visualize the traces. Hopefully you have
> access permissions to these. You can use the W, S, A, D keys to pan
> and zoom around the timeline.
> 
> Big Before:
> https://ui.perfetto.dev/#!/?s=01aa3ad3a5ddd78f2948c86db4265ce2249da8aa
> Big After:
> https://ui.perfetto.dev/#!/?s=7729ee012f238e96cfa026459eac3f8c3e88d9a9

P.S. I only gave a quick glance but I do see the frequency ramp up with
larger deltas and reach Fmax much quickly in case of "Big After"

> 
> Thanks,
> Saravana, Sam and David


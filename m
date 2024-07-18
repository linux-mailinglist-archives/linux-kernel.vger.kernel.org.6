Return-Path: <linux-kernel+bounces-256218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE2934AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B21B22F65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5A28DD1;
	Thu, 18 Jul 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lxia5MKS"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38393399B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294927; cv=fail; b=OcgGWlp/N+y9UhOQJ0MGIOB32KFNkjuOdmA9pbsV52zaPFshZ4ehg3xXzs8xnAVNDR05dYGKiuBVIxWSodwVV80bMWj8C7HvB+oHnZRGPEU0Uc7HHq0+faXEKNGatSYvYLEmEBWwHmoLWAhCfAm+wgTlY8q4B0QSAsnA2TRCmUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294927; c=relaxed/simple;
	bh=SheHAVl1A5OvQLcus1/DVxf8oakD0OTSSEAPuPsAqzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=izjNKSmH50XYuHnLQY8YI+SxGvfYnbu0H3jE0NiJLtSJdo9OKxaC8t1/NLqCWDjBCxjiwdmp4/Bat/x88MCk4z2rNSrqoMru5yGho5ygrUaaGQ1pDhfITFFdZR55pvOZe/TMFu/Vj/YloHP/fdxup3i0LDOCCUVKygo4dA8yo7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lxia5MKS; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnHITlax5qSbsopo2P2cJpGIApNpXkfZhL7HFDWc6jxhloSIQFYYbJ/qBDY5qmheuO4SbWiYqyl7XtrCID62sz2ry2mSzQJwBcS0Jgx+Jza1MvB+7kGOXmjA4ko9yZxA3fzcf9rB2LdAKJv9PkfQjT5AjqG/XBtigDQrdC0zZhEqEdLMkghm+qSXtm4AFgwJUkEU9wvr5Sp6yF5riFk1Po5Z0EEk9YAi0O/2YwAwnHRqagwUXEa+b7qB+EwjFVa4J4h600VVfeUaTAJfGlBa9ATt02BeS0m41YddJjfG7TmcwNP0o+q43qU7yp+IW5VsVRsOkSxZqA7uh/dO93X51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Nmdyc6UTZn/ndbyGjGosK2kIkxxXdIv8IMnqI0YFBk=;
 b=QtftEaHxb2TKMNE5bWOJhSPhnuN8mkZF/MM8Qrty4Kaxz+yAdh1NCzknkL4OGFBwiJq3zGKtb+9/cGkeiQYMgNrtjkHLTUiVhNZ6Rc4fInB+PdKnFx+Za1O/X1nEspPlNfRhurMuWdOEJF0z9dFDBneJmvNKn0FNrLJDYmrsWcBXqXpuQfD51hbHQ6dWlGrRFOWmFhm8B58nf13JkeWsjCWouYmqqFK+AKuLr8BJR9JjH39hvWwC9rbbNM96EQEm+xDM0fJstd3NZf+E8LcbY2818/fg7xE41fzCBP55KUw0q9RLAU1/OA9d93QojJ4j+Q0bYCSPoYURRmlsZgSJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Nmdyc6UTZn/ndbyGjGosK2kIkxxXdIv8IMnqI0YFBk=;
 b=lxia5MKSGT4hrdnOz7GFBd+vnB4sPRq2rh+TLyWgBawD5wmv4zfI6GcHJgDhRPL1vJsA1t5hWcEFvBZ56mIjggIft+m13WIpUxRhiJgwWL0igzJ9UdXHHs9Y+A1/u0rC/doxUPgKUQz5VBYN5Kv2YFOrkthNAWKRBp08R01FMY0=
Received: from SJ0PR13CA0112.namprd13.prod.outlook.com (2603:10b6:a03:2c5::27)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 09:28:42 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::19) by SJ0PR13CA0112.outlook.office365.com
 (2603:10b6:a03:2c5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 09:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 09:28:41 +0000
Received: from [10.136.40.40] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 04:28:33 -0500
Message-ID: <29172279-ac5e-4860-921f-2905639dd8bf@amd.com>
Date: Thu, 18 Jul 2024 14:58:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle
 balance
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Mel Gorman <mgorman@techsingularity.net>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Chen Yu <yu.chen.surf@gmail.com>, Aaron Lu
	<aaron.lu@intel.com>, <linux-kernel@vger.kernel.org>, <void@manifault.com>,
	Matt Fleming <matt@readmodwrite.com>
References: <cover.1690273854.git.yu.c.chen@intel.com>
 <20240717121745.GF26750@noisy.programming.kicks-ass.net>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240717121745.GF26750@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b291cd6-0eab-4eb3-6153-08dca70c031d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0J5cHFaTjRYcU4zSFNDVW1kQ3g2aHVwMUp1SEZZQ2dFeURTbU0zL2haZmVa?=
 =?utf-8?B?cEJIL2ZOeXl5bVUrdDViaUUvWm9QTVlPSmNBQzVsY2F6ZDIrWXlMdU9VTjZC?=
 =?utf-8?B?L0MzVFJVYlZha3RvdWhWQmZBaitKVng2R2V1VVVBYytxSGl2K3V6aW9hOTNJ?=
 =?utf-8?B?NVlMSjBXSmNhc0JpcjBXWEw5TWxLd0FzaEJTRXFaNXhUcjBMb05Pd0l6V2xH?=
 =?utf-8?B?OXRlYXA1OG0wa2NQTXhrNkdua1lXU0NiRkZvbmZBVVoyWGZncEp3RDNmZm42?=
 =?utf-8?B?Yit3WVNudnlTcUJhUjBRVFQyQVZsUnY5ZWEvZVpKeElmUHcwTytyZWFacWZi?=
 =?utf-8?B?QXFYUy9ZSC95ZE85UU81QnJLYy8yR1dhNDlaUXZHMnBIbWhIanNaOFZWbXBF?=
 =?utf-8?B?NTVlSGUyLy9ZOG9PZVord095bnVhZkZKMFg2Z05qbGZMK3lzUFRPaTRaSWh4?=
 =?utf-8?B?eXUwR1lndHNCN3NLeHdVTklKeXNhYTh1UGYyTEtDcE5kU1FmTHJtcElETnox?=
 =?utf-8?B?ZEZVQ0dEaWNTVWJqNjZFKzdxYTAwZWdMN09kS3BQVHFiQm9lbVNuMWtLK2Vu?=
 =?utf-8?B?cFAvZU8wY0c0YmpaRy8wcStCNFo5eUlYV2k3S0ZJbDlkNDMzRWRWcHhvUkxk?=
 =?utf-8?B?YkJZYTZtZ3N0MlppcUFRWGUxcERsODV3Y215WmpRSzQ1VG9pYkk3SFdJSU1Z?=
 =?utf-8?B?Tzk4K2ZUQ3hRM2R4YU5aNmJzVnBNb3AxVzFDVlhDYWtwb1hLV0Z2NXNKOFA3?=
 =?utf-8?B?MkxNSEtVMkpPQWYwVVdoeVNzcFdRUVBmZkxna0NTL3pSOEE0RnZpRmJIZ2sr?=
 =?utf-8?B?OFR5RWNGUnR4YnVXc0FmU1BNYVMrSGlCWmdoVVpaVXZpdGlRbFdRWXBCdXF4?=
 =?utf-8?B?SlZ6WTBNcEtzTG1zcUlIWWJaRW1wQVZVMllPczZINnVnYzRHdDIwRE1NSmpM?=
 =?utf-8?B?aG01SHorRklZVnowUW1iVzZCOElnS05ZWUJLNS90U0YzRFMrb0tSQ3ZLRzF4?=
 =?utf-8?B?TFQ2Y1gwOXBYKzExQzJMVGN4YkFzalpDSUUwdHdkUi9XdGJMdmxnNWJjeUtw?=
 =?utf-8?B?dzFOS3FJaEJ3c2RtanVQSFRUVWFSbTNhd3BpMzdLaFcxYVNJdGJVaHdDWVZz?=
 =?utf-8?B?Nkp1dnNsNW5KKzhBanBSSklaejB3MFdVWS9Wdk11dFAxR2dRUm1zMVJvL1R0?=
 =?utf-8?B?V3YweTVYYWJIRk9oR0lZOVlIa0EvdE5wREt0RUthSXYvNlgrTllNS3JSeHRv?=
 =?utf-8?B?V1hDUkpxenZQb1l0Q1FxNVNPaXhDb1ZQVUVZSm5HQkNoZ0JqMllTS3NvQys2?=
 =?utf-8?B?am1CcXpWQTdXaTloVTJNY1hxYlMxOWovQjBxV2lpcUZCNHJFSlhYRW1OVzhv?=
 =?utf-8?B?Um1seklmdGtYMkt0TFR4cUJ4aEp1QUx4eXJxdCtDSmJLTVdqc2lPVE03bGtl?=
 =?utf-8?B?cGZMcFYzYlN2UndlSk1YdURPOHNRdWNtamV2blZ0d0JpSjRGVmMwbTNKd0Jy?=
 =?utf-8?B?RjR0eTlpUjZadmxaQnYrTVdueWkrak0veE1aT21YVVJ3UmRDczYxeEhpUjdw?=
 =?utf-8?B?RFUxcVM1bmlpK0trRVc3REpGNVFIeG5QT2RTMlFRc2NERmRTeThnZ0NjK0xK?=
 =?utf-8?B?K3NxYWtiNE5UVTc3bWlqWSthYk96Qms5KytWTTJTV1J4MjY1bllqS1dLMmU3?=
 =?utf-8?B?dkVUZ0dNNGJod2RRMEN4MGcwVFNVQ0hIam9zdFVxeWRFNm11OG80ZlRSUXg0?=
 =?utf-8?B?dGNobzFzOW1udlVLOVgyNG51dkRsLzgrRm45aG9tcWE2cC9sckVsaHo2NnR3?=
 =?utf-8?B?ZHhXU2VhaE9SbjJFL0FCTE1rNlZmMEgvTHpNMUxpZm4yeDB5RkdwUkRuWG1Q?=
 =?utf-8?B?M3hyOXhUcnI4OEoxbWtTQWlKUTFvaUlVUDd1dG92cjJMdFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 09:28:41.1439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b291cd6-0eab-4eb3-6153-08dca70c031d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550

Hello Peter,

On 7/17/2024 5:47 PM, Peter Zijlstra wrote:
> On Thu, Jul 27, 2023 at 10:33:58PM +0800, Chen Yu wrote:
>> Hi,
>>
>> This is the second version of the newidle balance optimization[1].
>> It aims to reduce the cost of newidle balance which is found to
>> occupy noticeable CPU cycles on some high-core count systems.
>>
>> For example, when running sqlite on Intel Sapphire Rapids, which has
>> 2 x 56C/112T = 224 CPUs:
>>
>> 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
>> 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
>>
>> To mitigate this cost, the optimization is inspired by the question
>> raised by Tim:
>> Do we always have to find the busiest group and pull from it? Would
>> a relatively busy group be enough?
> 
> So doesn't this basically boil down to recognising that new-idle might
> not be the same as regular load-balancing -- we need any task, fast,
> rather than we need to make equal load.
> 
> David's shared runqueue patches did the same, they re-imagined this very
> path.
> 
> Now, David's thing went side-ways because of some regression that wasn't
> further investigated.

In case of SHARED_RUNQ, I suspected frequent wakeup-sleep pattern of
hackbench at lower utilization seemed to raise some contention somewhere
but perf profile with IBS showed nothing specific and I left it there.

I revisited this again today and found this interesting data for perf
bench sched messaging running with one group pinned to one LLC domain on
my system:

- NO_SHARED_RUNQ

     $ time ./perf bench sched messaging -p -t -l 100000 -g 1
     # Running 'sched/messaging' benchmark:
     # 20 sender and receiver threads per group
     # 1 groups == 40 threads run
     
          Total time: 3.972 [sec] (*)
     
     real    0m3.985s
     user    0m6.203s	(*)
     sys     1m20.087s	(*)

     $ sudo perf record -C 0-7,128-135 --off-cpu -- taskset -c 0-7,128-135 perf bench sched messaging -p -t -l 100000 -g 1
     $ sudo perf report --no-children

     Samples: 128  of event 'offcpu-time', Event count (approx.): 96,216,883,498 (*)
       Overhead  Command          Shared Object  Symbol
     +   51.43%  sched-messaging  libc.so.6      [.] read
     +   44.94%  sched-messaging  libc.so.6      [.] __GI___libc_write
     +    3.60%  sched-messaging  libc.so.6      [.] __GI___futex_abstimed_wait_cancelable64
          0.03%  sched-messaging  libc.so.6      [.] __poll
          0.00%  sched-messaging  perf           [.] sender


- SHARED_RUNQ

     $ time taskset -c 0-7,128-135 perf bench sched messaging -p -t -l 100000 -g 1
     # Running 'sched/messaging' benchmark:
     # 20 sender and receiver threads per group
     # 1 groups == 40 threads run
     
          Total time: 48.171 [sec] (*)
     
     real    0m48.186s
     user    0m5.409s	(*)
     sys     0m41.185s	(*)

     $ sudo perf record -C 0-7,128-135 --off-cpu -- taskset -c 0-7,128-135 perf bench sched messaging -p -t -l 100000 -g 1
     $ sudo perf report --no-children

     Samples: 157  of event 'offcpu-time', Event count (approx.): 5,882,929,338,882 (*)
       Overhead  Command          Shared Object     Symbol
     +   47.49%  sched-messaging  libc.so.6         [.] read
     +   46.33%  sched-messaging  libc.so.6         [.] __GI___libc_write
     +    2.40%  sched-messaging  libc.so.6         [.] __GI___futex_abstimed_wait_cancelable64
     +    1.08%  snapd            snapd             [.] 0x000000000006caa3
     +    1.02%  cron             libc.so.6         [.] clock_nanosleep@GLIBC_2.2.5
     +    0.86%  containerd       containerd        [.] runtime.futex.abi0
     +    0.82%  containerd       containerd        [.] runtime/internal/syscall.Syscall6


(*) The runtime has bloated massively but both "user" and "sys" time
     are down and the "offcpu-time" count goes up with SHARED_RUNQ.

There seems to be a corner case that is not accounted for but I'm not
sure where it lies currently. P.S. I tested this on a v6.8-rc4 kernel
since that is what I initially tested the series on but I can see the
same behavior when I rebased the changed on the current v6.10-rc5 based
tip:sched/core.

> 
> But it occurs to me this might be the same thing that Prateek chased
> down here:
> 
>    https://lkml.kernel.org/r/20240710090210.41856-1-kprateek.nayak@amd.com
> 
> Hmm ?

Without the nohz_csd_func fix and the SM_IDLE fast-path (Patch 1 and 2),
currently, the scheduler depends on the newidle_balance to pull tasks to
an idle CPU. Vincent had pointed it out on the first RCF to tackle the
problem that tried to do what SM_IDLE does but for fair class alone:

     https://lore.kernel.org/all/CAKfTPtC446Lo9CATPp7PExdkLhHQFoBuY-JMGC7agOHY4hs-Pw@mail.gmail.com/

It shouldn't be too frequent but it could be the reason why
newidle_balance() might jump up in traces, especially if it decides to
scan a domain with large number of CPUs (NUMA1/NUMA2 in Matt's case,
perhaps the PKG/NUMA in the case Chenyu was investigating initially).

> 
> Supposing that is indeed the case, I think it makes more sense to
> proceed with that approach. That is, completely redo the sub-numa new
> idle balance.
> 
> 

-- 
Thanks and Regards,
Prateek


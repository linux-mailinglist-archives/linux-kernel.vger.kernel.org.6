Return-Path: <linux-kernel+bounces-576528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBEAA7107B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DD8189971B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C4C17A2F8;
	Wed, 26 Mar 2025 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qeHEkLXW"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5414D2A0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969906; cv=fail; b=KazdBYO3vLAnmekB7PSG+Ntk6OV6oZZQLoYkElPYKHF2bTfpcAIV9eul8z7irLcyyKzDYHwjIaoO0W1yuOVFPn5R8F0Ru4OcFoD20aGZ+TZxtmyksYMOPeTX4hALhDtkB4X+wHASgrmqwm5fMVz8nQfE/Rj61w+GeacYu/Zz+d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969906; c=relaxed/simple;
	bh=7ffHK5IcJ6Jv5kUwcN8cmjh8OH+oOIsUaNgp1sF8fsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=czl2srJ6vkxK/j88uWchC9uT9Q2mysv2AGBhI1jIvNh/eHxitOwPIbPGZMFlmDNclATtiKD3hyxgRgdZgilDiCEA8Qe3C5D3G/qOPYUlULl/8621jg63JeDFV8P0P0QD25GheK1DmBPP5MsKdsOG4FAJmz3xt69F2RLyAfKhU5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qeHEkLXW; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJmeZuhWbrVr0WtSFNVRyvl0WJ3ci4aPYmF07R2DDVrO6OdvCe4mX9Q7pPtBfVD1pMZSIJAIitzLfpuvdPiv3A5G/ctVYpL1pOCzJH6NSQMwEZ1S/Ka+GQuj087sp2XdIpPr7Pjp0hhKTPMwKWdBmn6T3QHFKkqOyza71NCuHoy69utcJNCxQaYz4JQwZio6SDO8eLWprAAG3FFVIS1XVh2n4JkVrOo/pZR6oFbMU2U1k5vNemo6DH26QykJ4wCSZo80PLxwfmuESy8KnCReBhe7Rs2Zo4IYBoT/qjv6TzQR7Z6gzgt0yHnllZ/yrLVJ4CDhRXHvTCaAiHd6v5QoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPFkmskyP7ceJpUVzZiCo+Q9ZbOUPgcLnpzMTaR4RWQ=;
 b=P27dP8lDTB1Bnq3BOwGsRjMY0xqvXrZMx6JP2O+Ug6PxeVTv4Drz0LwHI6MbrQNsPduaCVV6eMh8flLCUBEAEtffryo/x3lgxZnuuVg1lKXDjwq439zoDzIi0ZXhyXNoOQCTWW6VlnlksaudHg+j4JAhv02WA/gUnND8yK3BQcoawaT9sCGa6iYUOVeYaDMHCFpXDNyjjAC03bz9yTmqPnqf1LD/IzmZ7TM1N8XhboPHih3AUePjkfvZEV8nsfHMw+M2Zwr6HmrfioTyk1zQ2I416QSJp6BwYWLNEy4ZQ6auaX3Z+c4RRpzgaFyPqjBVgDs3GLPUCvJSVY810ZcwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPFkmskyP7ceJpUVzZiCo+Q9ZbOUPgcLnpzMTaR4RWQ=;
 b=qeHEkLXW3FBpHqZ3C2UMEDT6/BrKNLsa+axRAhOYlqlqzylAYfZUiPR/ykWmrDcOmRVXg3/OH6ERFLuLhaqnta32Hn1xdDvgubo1MsCMXmFjt+YVjCjOxVBLYtKcF0kFTSkdB0TfoidRO76ti3fl8C/xgJ4ygPZOrhqi98Im/k0=
Received: from BN9PR03CA0114.namprd03.prod.outlook.com (2603:10b6:408:fd::29)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 06:18:20 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::97) by BN9PR03CA0114.outlook.office365.com
 (2603:10b6:408:fd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 06:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 06:18:17 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 01:18:13 -0500
Message-ID: <17d0e2be-6130-496f-9a80-49a67a749d01@amd.com>
Date: Wed, 26 Mar 2025 11:48:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
To: Peter Zijlstra <peterz@infradead.org>, "Chen, Yu C" <yu.c.chen@intel.com>
CC: <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<tim.c.chen@linux.intel.com>, <tglx@linutronix.de>, <len.brown@intel.com>,
	<gautham.shenoy@amd.com>, <mingo@kernel.org>, <yu.chen.surf@foxmail.com>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
 <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>
 <20250325184429.GA31413@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250325184429.GA31413@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b966211-9510-4452-9356-08dd6c2dffe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVBpK09yU29oYnAvY1p2SXN5bitHcEZrbUFmNm9KaWNhU2NyOWVZMnZuKzRF?=
 =?utf-8?B?VmFERldPWW54YXFCNmVaVnlYb1E2OG1MNG9LSnJHMk4xSTVBQ1l2eHM5TTRz?=
 =?utf-8?B?UVVNVTJhVjl3QWEzUzZ1S1FySzNsQWIrTnJkOTR5TUNuaHc3OWE2K1UvRWxC?=
 =?utf-8?B?MmJhRm1EejkyRktycEw2VjhtWmNrTWlEUEdQTVhWMlVhdTNnblNkNExKWG56?=
 =?utf-8?B?eVM5WWZxTzFJVkl4U1c3MkdNTzFRS0pFN0VpcjM0eFdmbGttU2lMRDhFc1Jo?=
 =?utf-8?B?V2NBMndKeFhmT3IrVW83UlN4bzAvQWZ6b2pScGZRNzZpWnh3TFpGalZnVUdQ?=
 =?utf-8?B?Y0JxanNickFiY282MXBYMEZnNHpPWk52Q0JDbWd0eG5qcWdNQy9FU2RUNXZZ?=
 =?utf-8?B?SHZVdkgrSkdsNkdpOXJMQmlnVGV5eisrZEpldjgveCt6QzZOSi90QWl2a0xJ?=
 =?utf-8?B?VTZHcjM5TmdidDBCVlRmaVVDMUdBTEl0ck13Z3E3bFVqemNqcDZiMjR0MVNF?=
 =?utf-8?B?cytnaU9aTUlaUTE3MzNGM0Q4TDZXeCtUaTljTWZ5czdKUWtGNTFSbS8rUUVr?=
 =?utf-8?B?U3VxelQ2YUlSMERiTDFtdFEwNGhJNXFITm01RG04M1AzRC96bEFuUHNuZVBl?=
 =?utf-8?B?a1I4NjdrRjNWMVNHMXdZd0Q1UHIwNEd1aVJyRDJWQU1ZcWNsNG1udS9tUHlw?=
 =?utf-8?B?bi9SVUpUTm1GOFc4eURVNlY4M3ZXZWlHelYwWTBjcnh6aXhnbC9hM0ptREo5?=
 =?utf-8?B?TE80S052VmFjK3NJRmhaeTZxVjJ6b1V4c2orTTNBdkVya2NzSk95RTV5M1Va?=
 =?utf-8?B?VHZCQUJENHdzVUN1MFk1eFN4UHd5MVlxRmRDdnNITXhyWm9DWW5kdTRpbDBw?=
 =?utf-8?B?Y0JVMlpxYU5zN0lNR2Z5ZFdHQko3WkpCelFVVjFudmRsWG80QUNjcDJSbUNZ?=
 =?utf-8?B?alJJQWl5NldzYWdmY0NxRFdHb2NkbUVpYkVxUUdWbWo3M2tidHNlMjB0bm4v?=
 =?utf-8?B?TnZud0FvdTgzTEIraEhwa21mNmsrU2twUVVQV1RhMktVdkN0UXoyNDB6dG9R?=
 =?utf-8?B?Zk02anJqcGV6enVZSnN0NktaK1V1VHFzd2kvT2pNNGo3Y2xkQlczUzRPUXhJ?=
 =?utf-8?B?dCtPQTRJYXRwODUxWFFBUWZrVkhZTnR6djRNYy9KelVubTFyQzZrcW1ZQ0Jj?=
 =?utf-8?B?R0I5QVFsV1BVUkQvK3dkUW5FZU5adlJudmM1WFRjL0Y2VyttL3NNRUlmZG5N?=
 =?utf-8?B?Vnc1Mm5Yb0xtbHRJTEMxM1ZVYWxOOWdDYmdaRnBkem84d3FvWE5xZkQzOGly?=
 =?utf-8?B?bEtFY3lYcDViNWZRN0NVbnJEeURRZUpUY0RQTmErK1ZMaUtpRFRxdm9jcHps?=
 =?utf-8?B?aFlFVlYvbUJrbzloSFV0VDNwSHdlNER3VndhK3ZTQ3RuNmtWNGMvZm1qZUVY?=
 =?utf-8?B?Wnc4VzZIRjk2aGxJQW0ra0k4dUZ2SkUraW9sUW5pZHVlNnBaMmd1ODZ4eW5V?=
 =?utf-8?B?TGoxMVZKUGFKVjhaMGFoZTNVdGhVNGU4ODJJQmxnekl2TWVQVXlLelcyV3pP?=
 =?utf-8?B?Wlc4U2w4bUxQdWY2RmVXYThuN1ZocVQ4c3JGRUNOZld2TFFHTG8xZ2xaalVQ?=
 =?utf-8?B?bkE2cFhlWmltVmR6VXYwNjhHM2hTL2hLL1NOclI0elFCUnovT0RmOUJNcEdK?=
 =?utf-8?B?cStCOVBRc25LVkhucWhaUlFSSUNTRmJZRXhkS0x2OTBxTkRaaWVqY1MyUlpB?=
 =?utf-8?B?SlVZTStJS1Vrd2RJRWxya2JoVUVlTy9vRFRGUXI1cWxGb0ptdXRmRXpUc1M3?=
 =?utf-8?B?N3lQekt1UGpjK2N6bUxPQmVzWWcvNElNcXp1SVlJTDlIMjFvRDBwQnJ6SFpt?=
 =?utf-8?B?TUdObUdJU1lYYXdlWVlqT2tsSzZLbkpWNnJMeFZLelRxZURUZWh4cFJndXRH?=
 =?utf-8?B?K1VKRFF6ZmRabkJZcWhIT3lVNlRPQThiS0pIL0ZXZ2E5VTB4NlVaS0J4S3Zx?=
 =?utf-8?B?a2poVUN1SGlvc0ptV09ZNFNWRzUwRkl0YjlNTmo1Q2dvUk9tOHE3a1llYW9q?=
 =?utf-8?Q?k3yfF2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 06:18:17.8442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b966211-9510-4452-9356-08dd6c2dffe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

Hello Peter, Chenyu,

On 3/26/2025 12:14 AM, Peter Zijlstra wrote:
> On Tue, Mar 25, 2025 at 11:19:52PM +0800, Chen, Yu C wrote:
>>
>> Hi Peter,
>>
>> Thanks for sending this out,
>>
>> On 3/25/2025 8:09 PM, Peter Zijlstra wrote:
>>> Hi all,
>>>
>>> One of the many things on the eternal todo list has been finishing the
>>> below hackery.
>>>
>>> It is an attempt at modelling cache affinity -- and while the patch
>>> really only targets LLC, it could very well be extended to also apply to
>>> clusters (L2). Specifically any case of multiple cache domains inside a
>>> node.
>>>
>>> Anyway, I wrote this about a year ago, and I mentioned this at the
>>> recent OSPM conf where Gautham and Prateek expressed interest in playing
>>> with this code.
>>>
>>> So here goes, very rough and largely unproven code ahead :-)
>>>
>>> It applies to current tip/master, but I know it will fail the __percpu
>>> validation that sits in -next, although that shouldn't be terribly hard
>>> to fix up.
>>>
>>> As is, it only computes a CPU inside the LLC that has the highest recent
>>> runtime, this CPU is then used in the wake-up path to steer towards this
>>> LLC and in task_hot() to limit migrations away from it.
>>>
>>> More elaborate things could be done, notably there is an XXX in there
>>> somewhere about finding the best LLC inside a NODE (interaction with
>>> NUMA_BALANCING).
>>>
>>
>> Besides the control provided by CONFIG_SCHED_CACHE, could we also introduce
>> sched_feat(SCHED_CACHE) to manage this feature, facilitating dynamic
>> adjustments? Similarly we can also introduce other sched_feats for load
>> balancing and NUMA balancing for fine-grain control.
> 
> We can do all sorts, but the very first thing is determining if this is
> worth it at all. Because if we can't make this work at all, all those
> things are a waste of time.
> 
> This patch is not meant to be merged, it is meant for testing and
> development. We need to first make it actually improve workloads. If it
> then turns out it regresses workloads (likely, things always do), then
> we can look at how to best do that.
> 

Thank you for sharing the patch and the initial review from Chenyu
pointing to issues that need fixing. I'll try to take a good look at it
this week and see if I can improve some trivial benchmarks that regress
currently with RFC as is.

In its current form I think this suffers from the same problem as
SIS_NODE where wakeups redirect to same set of CPUs and a good deal of
additional work is being done without any benefit.

I'll leave the results from my initial testing on the 3rd Generation
EPYC platform below and will evaluate what is making the benchmarks
unhappy. I'll return with more data when some of these benchmarks
are not as unhappy as they are now.

Thank you both for the RFC and the initial feedback. Following are
the initial results for the RFC as is:

   ==================================================================
   Test          : hackbench
   Units         : Normalized time in seconds
   Interpretation: Lower is better
   Statistic     : AMean
   ==================================================================
   Case:           tip[pct imp](CV)      sched_cache[pct imp](CV)
    1-groups     1.00 [ -0.00](10.12)     1.01 [ -0.89]( 2.84)
    2-groups     1.00 [ -0.00]( 6.92)     1.83 [-83.15]( 1.61)
    4-groups     1.00 [ -0.00]( 3.14)     3.00 [-200.21]( 3.13)
    8-groups     1.00 [ -0.00]( 1.35)     3.44 [-243.75]( 2.20)
   16-groups     1.00 [ -0.00]( 1.32)     2.59 [-158.98]( 4.29)


   ==================================================================
   Test          : tbench
   Units         : Normalized throughput
   Interpretation: Higher is better
   Statistic     : AMean
   ==================================================================
   Clients:    tip[pct imp](CV)     sched_cache[pct imp](CV)
       1     1.00 [  0.00]( 0.43)     0.96 [ -3.54]( 0.56)
       2     1.00 [  0.00]( 0.58)     0.99 [ -1.32]( 1.40)
       4     1.00 [  0.00]( 0.54)     0.98 [ -2.34]( 0.78)
       8     1.00 [  0.00]( 0.49)     0.96 [ -3.91]( 0.54)
      16     1.00 [  0.00]( 1.06)     0.97 [ -3.22]( 1.82)
      32     1.00 [  0.00]( 1.27)     0.95 [ -4.74]( 2.05)
      64     1.00 [  0.00]( 1.54)     0.93 [ -6.65]( 0.63)
     128     1.00 [  0.00]( 0.38)     0.93 [ -6.91]( 1.18)
     256     1.00 [  0.00]( 1.85)     0.99 [ -0.50]( 1.34)
     512     1.00 [  0.00]( 0.31)     0.98 [ -2.47]( 0.14)
    1024     1.00 [  0.00]( 0.19)     0.97 [ -3.06]( 0.39)


   ==================================================================
   Test          : stream-10
   Units         : Normalized Bandwidth, MB/s
   Interpretation: Higher is better
   Statistic     : HMean
   ==================================================================
   Test:       tip[pct imp](CV)     sched_cache[pct imp](CV)
    Copy     1.00 [  0.00](11.31)     0.34 [-65.89](72.77)
   Scale     1.00 [  0.00]( 6.62)     0.32 [-68.09](72.49)
     Add     1.00 [  0.00]( 7.06)     0.34 [-65.56](70.56)
   Triad     1.00 [  0.00]( 8.91)     0.34 [-66.47](72.70)


   ==================================================================
   Test          : stream-100
   Units         : Normalized Bandwidth, MB/s
   Interpretation: Higher is better
   Statistic     : HMean
   ==================================================================
   Test:       tip[pct imp](CV)     sched_cache[pct imp](CV)
    Copy     1.00 [  0.00]( 2.01)     0.83 [-16.96](24.55)
   Scale     1.00 [  0.00]( 1.49)     0.79 [-21.40](24.10)
     Add     1.00 [  0.00]( 2.67)     0.79 [-21.33](25.39)
   Triad     1.00 [  0.00]( 2.19)     0.81 [-19.19](25.55)


   ==================================================================
   Test          : netperf
   Units         : Normalized Througput
   Interpretation: Higher is better
   Statistic     : AMean
   ==================================================================
   Clients:         tip[pct imp](CV)     sched_cache[pct imp](CV)
    1-clients     1.00 [  0.00]( 1.43)     0.98 [ -2.22]( 0.26)
    2-clients     1.00 [  0.00]( 1.02)     0.97 [ -2.55]( 0.89)
    4-clients     1.00 [  0.00]( 0.83)     0.98 [ -2.27]( 0.46)
    8-clients     1.00 [  0.00]( 0.73)     0.98 [ -2.45]( 0.80)
   16-clients     1.00 [  0.00]( 0.97)     0.97 [ -2.90]( 0.88)
   32-clients     1.00 [  0.00]( 0.88)     0.95 [ -5.29]( 1.69)
   64-clients     1.00 [  0.00]( 1.49)     0.91 [ -8.70]( 1.95)
   128-clients    1.00 [  0.00]( 1.05)     0.92 [ -8.39]( 4.25)
   256-clients    1.00 [  0.00]( 3.85)     0.92 [ -8.33]( 2.45)
   512-clients    1.00 [  0.00](59.63)     0.92 [ -7.83](51.19)


   ==================================================================
   Test          : schbench
   Units         : Normalized 99th percentile latency in us
   Interpretation: Lower is better
   Statistic     : Median
   ==================================================================
   #workers: tip[pct imp](CV)       sched_cache[pct imp](CV)
     1     1.00 [ -0.00]( 6.67)      0.38 [ 62.22]    ( 5.88)
     2     1.00 [ -0.00](10.18)      0.43 [ 56.52]    ( 2.94)
     4     1.00 [ -0.00]( 4.49)      0.60 [ 40.43]    ( 5.52)
     8     1.00 [ -0.00]( 6.68)    113.96 [-11296.23] (12.91)
    16     1.00 [ -0.00]( 1.87)    359.34 [-35834.43] (20.02)
    32     1.00 [ -0.00]( 4.01)    217.67 [-21667.03] ( 5.48)
    64     1.00 [ -0.00]( 3.21)     97.43 [-9643.02]  ( 4.61)
   128     1.00 [ -0.00](44.13)     41.36 [-4036.10]  ( 6.92)
   256     1.00 [ -0.00](14.46)      2.69 [-169.31]   ( 1.86)
   512     1.00 [ -0.00]( 1.95)      1.89 [-89.22]    ( 2.24)


   ==================================================================
   Test          : new-schbench-requests-per-second
   Units         : Normalized Requests per second
   Interpretation: Higher is better
   Statistic     : Median
   ==================================================================
   #workers: tip[pct imp](CV)      sched_cache[pct imp](CV)
     1     1.00 [  0.00]( 0.46)     0.96 [ -4.14]( 0.00)
     2     1.00 [  0.00]( 0.15)     0.95 [ -5.27]( 2.29)
     4     1.00 [  0.00]( 0.15)     0.88 [-12.01]( 0.46)
     8     1.00 [  0.00]( 0.15)     0.55 [-45.47]( 1.23)
    16     1.00 [  0.00]( 0.00)     0.54 [-45.62]( 0.50)
    32     1.00 [  0.00]( 3.40)     0.63 [-37.48]( 6.37)
    64     1.00 [  0.00]( 7.09)     0.67 [-32.73]( 0.59)
   128     1.00 [  0.00]( 0.00)     0.99 [ -0.76]( 0.34)
   256     1.00 [  0.00]( 1.12)     1.06 [  6.32]( 1.55)
   512     1.00 [  0.00]( 0.22)     1.06 [  6.08]( 0.92)


   ==================================================================
   Test          : new-schbench-wakeup-latency
   Units         : Normalized 99th percentile latency in us
   Interpretation: Lower is better
   Statistic     : Median
   ==================================================================
   #workers: tip[pct imp](CV)       sched_cache[pct imp](CV)
     1     1.00 [ -0.00](19.72)     0.85  [ 15.38]    ( 8.13)
     2     1.00 [ -0.00](15.96)     1.09  [ -9.09]    (18.20)
     4     1.00 [ -0.00]( 3.87)     1.00  [ -0.00]    ( 0.00)
     8     1.00 [ -0.00]( 8.15)    118.17 [-11716.67] ( 0.58)
    16     1.00 [ -0.00]( 3.87)    146.62 [-14561.54] ( 4.64)
    32     1.00 [ -0.00](12.99)    141.60 [-14060.00] ( 5.64)
    64     1.00 [ -0.00]( 6.20)    78.62  [-7762.50]  ( 1.79)
   128     1.00 [ -0.00]( 0.96)    11.36  [-1036.08]  ( 3.41)
   256     1.00 [ -0.00]( 2.76)     1.11  [-11.22]    ( 3.28)
   512     1.00 [ -0.00]( 0.20)     1.21  [-20.81]    ( 0.91)


   ==================================================================
   Test          : new-schbench-request-latency
   Units         : Normalized 99th percentile latency in us
   Interpretation: Lower is better
   Statistic     : Median
   ==================================================================
   #workers: tip[pct imp](CV)      sched_cache[pct imp](CV)
     1     1.00 [ -0.00]( 1.07)     1.11 [-10.66]  ( 2.76)
     2     1.00 [ -0.00]( 0.14)     1.20 [-20.40]  ( 1.73)
     4     1.00 [ -0.00]( 1.39)     2.04 [-104.20] ( 0.96)
     8     1.00 [ -0.00]( 0.36)     3.94 [-294.20] ( 2.85)
    16     1.00 [ -0.00]( 1.18)     4.56 [-356.16] ( 1.19)
    32     1.00 [ -0.00]( 8.42)     3.02 [-201.67] ( 8.93)
    64     1.00 [ -0.00]( 4.85)     1.51 [-51.38]  ( 0.80)
   128     1.00 [ -0.00]( 0.28)     1.83 [-82.77]  ( 1.21)
   256     1.00 [ -0.00](10.52)     1.43 [-43.11]  (10.67)
   512     1.00 [ -0.00]( 0.69)     1.25 [-24.96]  ( 6.24)


   ==================================================================
   Test          : Various longer running benchmarks
   Units         : %diff in throughput reported
   Interpretation: Higher is better
   Statistic     : Median
   ==================================================================
   Benchmarks:                 %diff
   ycsb-cassandra             -10.70%
   ycsb-mongodb               -13.66%

   deathstarbench-1x           13.87%
   deathstarbench-2x            1.70%
   deathstarbench-3x           -8.44%
   deathstarbench-6x           -3.12%

   hammerdb+mysql 16VU        -33.50%
   hammerdb+mysql 64VU        -33.22%

---

I'm planning on taking hackbench and schbench as two extreme cases for
throughput and tail latency and later look at Stream from a "high
bandwidth, don't consolidate" standpoint. I hope once those cases
aren't as much in the reds, the larger benchmarks will be happier too.

-- 
Thanks and Regards,
Prateek



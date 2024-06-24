Return-Path: <linux-kernel+bounces-226685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB2914256
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142011C20E14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02818C05;
	Mon, 24 Jun 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PKJC+bP9"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405A208B6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208631; cv=fail; b=XqcYzcI/0SW0ReWv2O2kVY4CIzjnPKpELWM/oLSvsZc4nbQ+DE+meRAq44/bC1CVIdYZ+yXU4WYk2xaCme39OQq+ZkHszIPBCdqgc7b4ARKerOTcKgbwVB1P/EFx5l9BtNRMVLey4Qz0WVxxBcraCt3tIWhK42mxiaNMc5nLYBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208631; c=relaxed/simple;
	bh=lq0sYDEwHb+T6tJcV+r2lvvA9XNiadTlREzeH74F/jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qjENgF1SWQcvsKuDJhp2Fqow3z5u235HjpAGMF1AqoAuZUWq1O5oQ/BAuLnU5oOHxG0vk0MAsMJelZYij4uyv67HdZmxEv5mJ9LVyS840SwA8QeIJnFDPUvGrr1G8TGzoZe3nadSYIW4owGxSjG8xgb9pTB7SuzmxbPd9ZIYdVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PKJC+bP9; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5iM3C7vZrnwsZtmDoBS1fnOWjl2W+k/dQgKWeDvGM6l5BhEtNWbbfgVVhZQhChx9kTVSj3ltlTeMa51Ip7puV3xtsxz6E7ZtrRz7TsT2ux7r9/5UoPiGaq0dfvBaqwjCz0KW5A1f9BeFJfybyrDfzYZbuCQ7EZA2M/L9bBfPbjhI1EOMCdoC51zSIIBEroZENJqcj4wSoQecA1zM4Ck7eFdvhiVtwbtT4HjUknvj5RuHAt7sIfzouZ+KchpsslxU6AWy+Cbz8cpHDs9YRuhr6BbdqEOhzosmwuOUim21PUsI7cLkyE0AviT4zvvxq8xWgCR3eXVa5AsdeDsIh6Irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHkcH/vuSJb5PEMZ3m44CsH7JZUOk6wyp+2Ugz/9fRg=;
 b=bfoZipMuERNiwi6Pl7auEFRJk9p2Eww2ybBquF/mUPokeDhxtUUpJn+goaKtA7+NNmcmRH6H5GCS50UoqvgwjwUpdgwc5N4+jAoaMg18L0LQ3CjG52CqeebP3/ZSA43JK/91+Iiaq5xJftvaC+oamFpZTJbilVwkh5DDFN/Tub5Va+TUhuVuVBOmNQfHdZmgVoXUfch4YoUlxgLSQhFQ6UE8yZ+AXqsfthTwFuuxoiOaekAtcJ4wF5jys0U95BzYWp1CjdW4rDhMDk6FPTLknWuQ3LLNuS192yDYqABiaaSqtwbO2Es1Sh2hvQw0ap6Fc0krcQYHySuCCY5OrvT9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHkcH/vuSJb5PEMZ3m44CsH7JZUOk6wyp+2Ugz/9fRg=;
 b=PKJC+bP9j6275msA+IwcxIqWZYpdinGmrgXMMjCFlCL3D92EWmMvG3BVSnlDKAAJusqs8Uox3Z62prsfRjqhs8QtwulP5JC6XMVHY/LVLQwEKMz2ggh42tepf6qjwy0oaJhILbyYkUt5RKs9tLnOKXNzYpjwZLLHDbhESxd6eLQ=
Received: from CH2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:5a::31)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 05:57:06 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::c8) by CH2PR08CA0021.outlook.office365.com
 (2603:10b6:610:5a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 05:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 05:57:06 +0000
Received: from [10.143.204.114] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 00:57:02 -0500
Message-ID: <b6c85c1d-0f67-4cb1-d1fa-0cee7e70885a@amd.com>
Date: Mon, 24 Jun 2024 11:26:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH] sched/numa: scan the vma if it has not been scanned
 for a while
Content-Language: en-US
To: Yujie Liu <yujie.liu@intel.com>
CC: Chen Yu <yu.c.chen@intel.com>, Mel Gorman <mgorman@techsingularity.net>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Chen Yu <yu.chen.surf@gmail.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240614045649.133878-1-yu.c.chen@intel.com>
 <021e0e63-7904-b952-af9c-7e1764e524dd@amd.com> <ZnEk3yARRPP9WXr9@yujie-X299>
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <ZnEk3yARRPP9WXr9@yujie-X299>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ddbc78-56fa-4eb1-0042-08dc94127a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3pWVW5YS2pDU0Jsd29tVlF2VlBLWGZ1ZzBsNWg0L3NtbG1ySkMzbVVjaDJ0?=
 =?utf-8?B?U1lha3krR1N5T09GbTBUcjlYT2dReXNrOTZ2TW91SThSdmJydEZKQ0k2TWpW?=
 =?utf-8?B?ay9yci85ZDlmRDUvL05HVE5iQkJKVysraFZyY1plRThXeGp3SnVhM1M4QXFz?=
 =?utf-8?B?Mk1YMTcrQWVVLy9sWUw4TzhpQ1J2c0NBazVkWWRYT3ZLcE94UndtRkN1aU9X?=
 =?utf-8?B?eUp4bUhVV0tJRVk0MDU2S3dIS1diV0VhaHVoOHRKN1BnMDVFV3JCNEQwa1VD?=
 =?utf-8?B?eng5Q3B5WGM3TjZVT2dYSWI4bTVieTlaM3ZzclB0NEgrWHBQN0NNcDU5QVBj?=
 =?utf-8?B?ajNSRjl1cFlObjlMNmpvRVdZSXlJejlBTDN3ZDZ2VzgzOVhUMHpFTStZMU1y?=
 =?utf-8?B?UGVKVk5sc091dnFWV3JHRVoybGdRYjFQNkIrNXJkMkdmckN4LzAyWWVOOVlM?=
 =?utf-8?B?dk5Jb3VKOVdJVXBuQkc2VzBMd1lsRUZzbG9zdVZjOElxSVFwVXVaN0EwY0lM?=
 =?utf-8?B?RnltWUNDN1ZPcHg1eW4yY05oRTNvVWxCUG1WSHRENjNLWkRxY09kUnJiTW1y?=
 =?utf-8?B?eU8rT1hpWnY5U1JubXBYSWpwZit1QVRGbnpMc0JjWERFK3EzV2xGeDdNYVQv?=
 =?utf-8?B?N3Vhb1Z5SEJjTkpVWGhkbGhKVDVrWmhmMDVoODF1YStqY291RmYrSXFMcTFt?=
 =?utf-8?B?Q1dXT3NjeDFzSjZYc0twYXU5KzlSRE9vWU80S0xneGFta0w0SC9FcjRpK0xB?=
 =?utf-8?B?azNRSk9RWUxiU3JDREk1VXpiMlZJeHlMZk9jWCsyaXVTNGlhUFhDUDNUUi9W?=
 =?utf-8?B?bldCTzZ5RXZCTW9Ia2dvMkhjVmZ1UlhHUTYvMzFMc015Z2k4eUxtTHJ4ZnNi?=
 =?utf-8?B?cm9iTzlZT01BL2gvU3h4RHMrcDl4aFJaQzhDUnF3NHVGeVRWRDJpcThqb2Y2?=
 =?utf-8?B?bWpWY0EyakpxWGF2NlFxdUV5cHpVbUZETVVpVmR1ZCtFaFZYRlNTNllaY3Bw?=
 =?utf-8?B?SDJYNDA2VjBrRS9YTmVuRTl4d2xRZndBRG12Q0R0SkJHblFqYVBWS1ZuZm44?=
 =?utf-8?B?ZXFVbHB4WWNBQnNtTXc4dTlHMnZ4c1BrUlZhdHVvSUh5clAyQjUydGRFUzJr?=
 =?utf-8?B?MFJFK1BDSWowYkdrMFU0L0YwdjRwT2p5U214ZWJINnlYYWE5eDl2OE9BMHJv?=
 =?utf-8?B?QWx1VTB4MExyRUNFWE81VXJpQlhrQnVsQW9qaWtIZ3YxNmpFN1JhcHlGUlVS?=
 =?utf-8?B?RGU5bjlGdzBmdi82NEJxWXo4YlVsYktnZS9jVmRWYkpocmdQUjdKcEljVE1B?=
 =?utf-8?B?WThUK0Y5Wkdtb0Y5L1lpbWhRUnl0L0VZU2NHNDdQZmd3OGZiUTZLL2xHcXdU?=
 =?utf-8?B?SHhiVmVLR2tRTFk3NUxpdFg2M0lxMVlvUk1LbmgrQnpwa04wT2w1TVNEcUZN?=
 =?utf-8?B?OGRPci9jK2RWaDdFVDltanQ5SFJ4VnordXhDY2dHZDdRNjlDMG1rV0E2RXc1?=
 =?utf-8?B?QUV6SFZUV28vb09iNk0zeC9sTDdvMWc0N21WUE5oQTREejh4U21NUzNhdmJC?=
 =?utf-8?B?RFc2UzhUWnhhaS82YjNVVnBHUUhqVnU1UURmRXlwVy9weGRqNzdXd1N0cmhH?=
 =?utf-8?B?M0Q0RVZPSjcxTjNKUWlGTHNqWHNzMXdSOFdtTitVdCtMMXlnYit4SzRjSFl4?=
 =?utf-8?B?UWt1ZFhJU05lQkpQemx0YmlmQW03RWV6alV1WkUvSmtvMUJkTlVNem1kbGl4?=
 =?utf-8?B?WGt1WmVwTDQ4MkJQck82ZEJidXlsOHIrdTBkWHZkYU9CYThHVFRLMnZOcEtW?=
 =?utf-8?Q?gVN1MJXpwzQjDurKBmBWYPgBHwcvckCayyZFU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 05:57:06.0323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ddbc78-56fa-4eb1-0042-08dc94127a40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811



On 6/18/2024 11:40 AM, Yujie Liu wrote:
> Hi Raghu,
> 
> On Tue, Jun 18, 2024 at 12:41:05AM +0530, Raghavendra K T wrote:
>> On 6/14/2024 10:26 AM, Chen Yu wrote:
>>> From: Yujie Liu <yujie.liu@intel.com>
>>>
>>> Problem statement:
>>> Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic"), the
>>> Numa vma scan overhead has been reduced a lot. Meanwhile, it could be
>>> a double-sword that, the reducing of the vma scan might create less Numa
>>> page fault information. The insufficient information makes it harder for
>>> the Numa balancer to make decision. Later,
>>> commit b7a5b537c55c08 ("sched/numa: Complete scanning of partial VMAs
>>> regardless of PID activity") and commit 84db47ca7146d7 ("sched/numa: Fix
>>> mm numa_scan_seq based unconditional scan") are found to bring back part
>>> of the performance.
>>>
>>> Recently when running SPECcpu on a 320 CPUs/2 Sockets system, a long
>>> duration of remote Numa node read was observed by PMU events. It causes
>>> high core-to-core variance and performance penalty. After the
>>> investigation, it is found that many vmas are skipped due to the active
>>> PID check. According to the trace events, in most cases, vma_is_accessed()
>>> returns false because both pids_active[0] and pids_active[1] have been
>>> cleared.
>>>
>>
>> Thank you for reporting this and also giving potential fix.
>> I do think this is a good fix to start with.
> 
> Thanks a lot for your valuable comments and suggestions.
> 
>>> As an experiment, if the vma_is_accessed() is hacked to always return true,
>>> the long duration remote Numa access is gone.
>>>
>>> Proposal:
>>> The main idea is to adjust vma_is_accessed() to let it return true easier.
>>>
>>> solution 1 is to extend the pids_active[] from 2 to N, which has already
>>> been proposed by Peter[1]. And how to decide N needs investigation.
>>>
>>
>> I am curious if this (PeterZ's suggestion) implementation in PATCH1 of
>> link:
>> https://lore.kernel.org/linux-mm/cover.1710829750.git.raghavendra.kt@amd.com/
>>
>> get some benefit. I did not see good usecase at that point. but worth a
>> try to see if it improves performance in your case.
> 
> PATCH1 extends the array size of pids_active[] from 2 to 4, so the
> history info can be kept for a longer time, but it is possible that the
> scanning could still be missed after the task sleeps for a long enough
> time. It seems that the N could be task-specific rather than a fixed
> value.
> 
> Anyway, we will test PATCH1 to see if it helps in our benchmark and
> come back later.
> 
>>> solution 2 is to compare the diff between mm->numa_scan_seq and
>>> vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
>>> scan the vma.
>>>
>>> solution 2 can be used to cover process-based workload(SPECcpu eg). The
>>> reason is: There is only 1 thread within this process. If this process
>>> access the vma at the beginning, then sleeps for a long time, the
>>> pid_active array will be cleared. When this process is woken up, it will
>>> never get a chance to set prot_none anymore. Because only the first 2
>>> times of access is regarded as accessed:
>>> (current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
>>> and no other threads can help set this prot_none.
>>>
>>
>> To Summarize: (just thinking loud on the problem IIUC)
>> The issue overall is, we are not handling the scanning of a single
>> (fewer) thread task that sleeps or inactive) some time adequately.
>>
>> one solution is to unconditionally return true (in a way inversely
>> proportional to number of threads in a task).
>>
>> But,
>> 1. Does it regress single (or fewer) threaded tasks which does
>>   not really need aggressive scanning.
> 
> We haven't observed such regression so far as we don't have a suitable
> workload that can well represent the scenario of "tasks that do not
> need aggressive scanning."
> 
> In theory, it will bring extra scanning overhead, but the penalty of
> missing the necessary scanning for the tasks that do need to be migrated
> may be more serious since it can result in long time remote node memory
> access. This is more likely a trade-off between the scanning cost and
> coverage.
> 
>> 2. Are we able to address the issue for multi threaded tasks which
>> show similar kind of pattern (viz., inactive for some duration regularly).
> 
> Theoretically it should do. If multi-threads access different VMAs of
> their own, like autonuma bench THREAD_LOCAL, each thread can only help
> itself to do the pg_none tagging. We have observed slight performance
> improvement with this patch applied when running autonuma bench
> THREAD_LOCAL.
> 
> In common use cases, tasks with multiple threads are likely to share
> some vmas, so there could be higher chance that other threads help tag
> the pg_none for the current thread, thus we can tolerate more vma skip,
> and vice versa.
> 

Agree with above points, meanwhile when I ran my normal mmtest,
Results:

base = 6.10-rc4

autonumabench NUMA01
                            base                  patched
Amean     syst-NUMA01      194.05 (   0.00%)      165.11 *  14.92%*
Amean     elsp-NUMA01      324.86 (   0.00%)      315.58 *   2.86%*

Duration User      380345.36   368252.04
Duration System      1358.89     1156.23
Duration Elapsed     2277.45     2213.25


autonumabench NUMA02

Amean     syst-NUMA02        1.12 (   0.00%)        1.09 *   2.93%*
Amean     elsp-NUMA02        3.50 (   0.00%)        3.56 *  -1.84%*

Duration User        1513.23     1575.48
Duration System         8.33        8.13
Duration Elapsed       28.59       29.71

kernbench
Amean     user-256    22935.42 (   0.00%)    22535.19 *   1.75%*
Amean     syst-256     7284.16 (   0.00%)     7608.72 *  -4.46%*
Amean     elsp-256      159.01 (   0.00%)      158.17 *   0.53%*

Duration User       68816.41    67615.74
Duration System     21873.94    22848.08
Duration Elapsed      506.66      504.55

( I have not done bench-marking with smaller threads, some larger
workload run is TBD)

But overall results look promising.
Also on the plus side we have a very simple patch, So

If PeterZ/Mel are okay with using nr_thread notion,
please feel free to add.

Reviewed-and-Tested-by: Raghavendra K T <raghavendra.kt@amd.com>


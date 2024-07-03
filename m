Return-Path: <linux-kernel+bounces-239053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65C8925576
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AD41C22ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105F13B2AC;
	Wed,  3 Jul 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uUuomjmu"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746DA13B280
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995706; cv=fail; b=IN9gkEwixvn+6wPIV12HiwV6C8lrS4GnlQ7W5uIOhboVgboJJzePsU2B7Hw4u59bEt2TDTOXCtgoSolm2pmau8OBwtbZvrEniMxYzDkiei4r4Sec/9vopkRssFc3fo9BQlKGN2YgiCyNmLOjQsnwPsH2Kyj8aaPbuq1wKLIBJi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995706; c=relaxed/simple;
	bh=5SKD45lMXez15+IUYLSIrjstJ3sDcwMHfDbyRSwmZcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MuZUU9DY34ZIp1b7WLSvFmPwmZUuIZW+nG9hzAeVFGQFH5O3UIN7t+uV+mCkoXWSOONq1y3vjFrjUSaqursxsQqK48poDYxpMZC02FsvmzHXwzQobXGUFrv7pGMYGjNjQqjr8kUaX4znZ4VdhInvdtfm2up4eQzDCbhqMiTGTZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uUuomjmu; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTuTyfQQj6cdZanc9h6cQBeUNshQxXzB929Fn6dgO1xzInUegCvq7mJmbX3lne4RFs8mIMivYHwtx6O8+JAPXF+RmPurZ0A2EKWiojuuW4W05SK4UoRcR5MDdS1E/LH2YGOj8iNnk4T5cdFvUqltzxX6yMvqArchGteiV9fXwmt6J6JJXDgbopv2rb7AcxsdiDzd2f7qgjvx922RAciX0Aqg0oCK0rqcI9cGTY8yK2C8Mv0g90pqS8DE0zhIMpHapX9p/I68xpC+pbln9zAphOAufn9uuxb2SKkfSAku0bbpa+/mQDTCalVLVz7uzq+ii/GKcHKBzP5+hbOz76ZCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6lURpFmi/2vrK1XO0v8dC3SMSXCZ20BhNtYWv4kgKQ=;
 b=id5nngXqdvIHxST5Iyu2mWB+JAfe/SIP6tQXeVFV7EJAjce+/RImRoLlvvrUXIcDJ/M64dMdJFdHe/lKpKoP2gneui11YEFw8IB4C0LL7OykDz0wBbaBJ6KIhEAzGg0puqtqIJCMl7JtIitlAnwbs46Km47T40mQCR3mfbKmHWPJOacYNdKR2LVFBayzV5c7Oyl64+JWxg6jfmpvb50bGeM8qz3tmsUc4C3iv14Du3KObVKzxdRNfr3cISER1d60BCJB4OTQ8iFWLTxRKwSGJ6OFbjFHBEUeMCSKHNMI18it5Qf3VmY8c5n5iZ4M6ldoP+MVDQZgMmjhggNAv5eSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6lURpFmi/2vrK1XO0v8dC3SMSXCZ20BhNtYWv4kgKQ=;
 b=uUuomjmujAbejeFK4rFrFH8JqwT4zf4jqM91I8ffWlpsPumX+Us8irniKyxIYNJzpcdsU0fUr8+aQVcI0ZN+2Dow0DMGCdzXCOyVbIARw3PQLsZhZ+OEws5zAJdaJXutbgmT8kd/G1hb+8aujiWG5qVevmZaO0mVYzsW6u6Gb9w=
Received: from BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::6)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 08:34:58 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::84) by BN9P223CA0001.outlook.office365.com
 (2603:10b6:408:10b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 08:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Wed, 3 Jul 2024 08:34:58 +0000
Received: from [10.136.18.229] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 03:34:54 -0500
Message-ID: <683663e3-cef0-bb45-e1c7-5bf1cf44209c@amd.com>
Date: Wed, 3 Jul 2024 14:04:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
To: Chen Yu <yu.c.chen@intel.com>, Mike Galbraith <efault@gmx.de>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>, Yujie Liu
	<yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<linux-kernel@vger.kernel.org>
References: <cover.1719295669.git.yu.c.chen@intel.com>
 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
 <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
 <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: afb74169-cff3-4094-690b-08dc9b3b0625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlhnZ3Bma1pHNExvcXBJTmw4a2J3aFBYNTFaMzZIU3k1VDIyV2EvSGJIRDJI?=
 =?utf-8?B?Ym9QVU9NRjhNUTdUN0J6bE5lQ0loUE5KVnU2b1BUbDZ0WkM3UWUxRGZHTUhH?=
 =?utf-8?B?OHhDaGZZVnRIeVRYTjhnOW4xay93MkpUakpQS3ladzJJQWduc29IbzJ2cFFv?=
 =?utf-8?B?VDg1QnRwdzZMaFdvNlpwODdoWVNhWUYzM2pab3ovNXBma21pZGtUMHl5YkM2?=
 =?utf-8?B?WnZKMVhTTGo5aGNGSS9jNUh4MVREaVVGQWJPZG5PQzVGcER4MmVaWDRCV3o4?=
 =?utf-8?B?TWFRWDBsaFVqSm9sZGhnNGJIMGxHQlBnZ0lFam1mWU1jZENEUVBYNWtmeThV?=
 =?utf-8?B?Tjl1bmRmbWZmZzUxY253SnIydm1qYXoxK3hFNzl6ME1SMnQ4TlhDdTRpU1BL?=
 =?utf-8?B?aVh2dGRyZ00zOTc5T3Z2dkRBc3JWYXFMVktHSjEva0MvTmxKd05TMVFPWVo4?=
 =?utf-8?B?cFVkdlJqSTllZU02TzZvaXFLaU1nY09nVFJXVkREcUtnTjZIMGQwRGkrWUpN?=
 =?utf-8?B?TWRWQUtaa0Mzbjk5UTNGUysxSitKNzYySlhoY0lta0szQWk1L3hUWU5Rc0Z5?=
 =?utf-8?B?MThnWlU5dkQzVjJFNkFONmo5OGZkRFJkZk9YM0dLb2wybFJVK1Q5QTM2SE9i?=
 =?utf-8?B?dWw0ZGlMOVlXOUpaQklBQWhoeTZ6R0VnbG1RM01Tdk1LTlBwejJBWVdqTVdh?=
 =?utf-8?B?TFI4RHBkY0pOUkJ0ZnNoS2l0b2d6a1llancyTmhQbitmc0xqSUd2RXhtbEFa?=
 =?utf-8?B?bkdJckFzZWdZRzdNUmp1OWhRQkdJcFBPV2g5aG9zMmpFK0ttcEZKdUhIQkU4?=
 =?utf-8?B?YTVGMFJ2ckU0U3NPRWJEY0xzWjZ2dUpMeVFKODk0R0RDNjh3MTdTank5MXBs?=
 =?utf-8?B?Lzd3b2tjOG1MUVJ6MXdLcDBMZ1NkTTl1TmxnNFpHY2xhRUN2WCtZNWRNQjAr?=
 =?utf-8?B?aGp6cGE0ZG5MMDhtMTQ1VEpwbDM3UysyRk4rRU1LL2o2L0VyN3ZPSnF0Ylht?=
 =?utf-8?B?V01yNzgvY0J3K3NtY3ZZQzg4TS9SMDZOZmo2M3V3TWUwSUUzcEFPYThJSFFE?=
 =?utf-8?B?d2VQRmQrK3NNelk2Y0pkM0tHd0RwalNzUHBuNHh1dDVGRFExMDVDOThvWUxk?=
 =?utf-8?B?dG1oL3U0QnZ5UzJHbTBwK3lPZzdFU0RuTGFOV2JLT3pONDZINEpMNkd2bC9K?=
 =?utf-8?B?cVIzK2Z4MzVid2pPUjlCd296YWdyZnZQYm1Od0NkS0k0YkJ2aGNISmNqZzVh?=
 =?utf-8?B?WjdzVmVjV0VNVWlNcDlINXhNZFNGQ1JUbGpFQTlUM0duaGU1NnZwZ3F6TDBC?=
 =?utf-8?B?TTRyZnVEb2lQZEVETVdLNFNZUDVYSkdGbXhjUGRPZkZsVE9teWVmWTFmRU55?=
 =?utf-8?B?b2RGaVpKOEEwRDZGY29DbnUySkt3MXVnbzBvbmhuMVlMQWFqYUVXSXU4QnVL?=
 =?utf-8?B?VXlNUXZGOGQwY21ZNHVVaThEeEFhSkhaU05TTmxuYUljNTRVbmpTMzhkZWYy?=
 =?utf-8?B?NzBGUDJRT0dDMExRYUdIYnBuaTRuanFMRTViUXR1VGk3VzZ4SlF1b2xjWGJo?=
 =?utf-8?B?aEU5bHJzbHZ0YlN0Ry9yNWJvUVBsbjVDSjhCZXBHcTdIU0w0eHpLWHliVTI2?=
 =?utf-8?B?Qys0aXpoUnI1ajF6RzZrR0ppelpLalJXOEFmdVozd0JNeUVzT2VPNmNkZ01C?=
 =?utf-8?B?U0FZS05QeWVQSDdtZC82dmkva1FWWDgzbTRRWkVObXk2aXpWOE9ZUkFwa3JO?=
 =?utf-8?B?SFFyZnVRLys5c0p6L21TUmJyNVdZd2wzQUxWUXpSSk9ESmhBZ1BCT1UrckpE?=
 =?utf-8?B?ZVZ4MEFQcExYRUwxQlU3aXJiSGhiQlZQVFFBTmZpdVpNRFd0c2hFK0FLWms0?=
 =?utf-8?B?NzBCSVg4d1F0LzhsaHd4RGNBbU10WklKeVNuMC96bEM3RHdrRFRWVkxvQkMz?=
 =?utf-8?Q?KO0eNdyv/sSqlI262wYTK+ezBpIFBiDx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 08:34:58.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb74169-cff3-4094-690b-08dc9b3b0625
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173



On 7/1/2024 8:27 PM, Chen Yu wrote:
> Hi Mike,
> 
> On 2024-07-01 at 08:57:25 +0200, Mike Galbraith wrote:
>> On Sun, 2024-06-30 at 21:09 +0800, Chen Yu wrote:
>>> Hi Mike,
>>>
>>> Thanks for your time and giving the insights.
> 
> According to a test conducted last month on a system with 500+ CPUs where 4 CPUs
> share the same L2 cache, around 20% improvement was noticed (though not as much
> as on the non-L2 shared platform). I haven't delved into the details yet, but my
> understanding is that L1 cache-to-cache latency within the L2 domain might also
> matter on large servers (which I need to investigate further).
> 
>> 1:N or M:N
>> tasks can approach its wakeup frequency range, and there's nothing you can do
>> about the very same cache to cache latency you're trying to duck, it
>> just is what it is, and is considered perfectly fine as it is.  That's
>> a bit of a red flag, but worse is the lack of knowledge wrt what tasks
>> are actually up to at any given time.  We rashly presume that tasks
>> waking one another implies a 1:1 relationship, we routinely call them
>> buddies and generally get away with it.. but during any overlap they
>> can be doing anything including N way data share, and regardless of
>> what that is and section size, needless stacking flushes concurrency,
>> injecting service latency in its place, cost unknown.
>>
> 
> I believe this is a generic issue that the current scheduler faces, where
> it attempts to predict the task's behavior based on its runtime. For instance,
> task_hot() checks the task runtime to predict whether the task is cache-hot,
> regardless of what the task does during its time slice. This is also the case
> with WF_SYNC, which provides the scheduler with a hint to wake up on the current
> CPU to potentially benefit from cache locality.
> 
> A thought occurred to me that one possible method to determine if the waker
> and wakee share data could be to leverage the NUMA balance's numa_group data structure.
> As numa balance periodically scans the task's VMA space and groups tasks accessing
> the same physical page into one numa_group, we can infer that if the waker and wakee
> are within the same numa_group, they are likely to share data, and it might be
> appropriate to place the wakee on top of the waker.
> 
> CC Raghavendra here in case he has any insights.
> 

Agree with your thought here,

So I imagine two possible things to explore here.

1) Use task1, task2 numa_group and check if they belong to same
numa_group, also check if there is a possibility of M:N relationship
by checking if t1/t2->numa_group->nr_tasks > 1 etc

2) Given a VMA we can use vma_numab_state pids_active[] if task1, task2
(threads) possibly interested in same VMA.
Latter one looks to be practically difficult because we don't want to
sweep across VMAs perhaps..

> thanks,
> Chenyu


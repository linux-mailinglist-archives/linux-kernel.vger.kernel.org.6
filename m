Return-Path: <linux-kernel+bounces-537962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C217A492ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC7C165356
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D441DE4DF;
	Fri, 28 Feb 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WxMEhXmd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0381DE4D0
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729962; cv=fail; b=uLu0/hs3Rh/wLkYdevd9j9aTBsHuc8ymtSxzjLmaT6Iw5mqvPdWfRMm/7R5K/vWvmDvmiJMt1PfEjSUsCc+/c7CZCzGF5mzjBuBb6IMrYf4TG005vcpyR+Xql4mi3r28gocIORdx0s9ZbSTKAobJRsv4KS0J+b1Rz9PADaSOTSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729962; c=relaxed/simple;
	bh=FZdaTBotAx8Z5ykZPS1CrVXFcxwsX9QM4CfkzNtquJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KiTHDwwbhB8DEZNiwYBbBm1JXKytIE4fDqwhNvC+L6hs45KZZwHnFym+nRdZrS05QlzP1TR8I2ga1OTz1CGBlA+2yen9dUo3v+GtDNQRLpWXiNbGMnKjBUOpTt7MoftQhseJv0csj37InwnYx3Jm3BtabXxsoWGJ/h+EJmnwToY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WxMEhXmd; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEzXuE9+99+8AibUEaitsURs+gBuuohY4vv68158CAu53CR2AI070DIvNsP3vi7KIj6Eh3C84c+qB3cwSYpC4XdXXZEm3unhA4UblfrkIbGpm3r+QhdWRB19E981Dik7krw170OrqtgDwd9J5m7qtw+LBzWdZ1H42ODL/kHAf4N5aPrK4gdSXrwVJl2FVVsKcKxkNYXTTzAejFGttI7IuBUo52RiTQVh9zdIwLKIvCUFwlYBSOenKt6frXMCuXqpz1A7rK3WHXp/kOZcDmbPNhT/Gg+/MH02bT7ARdrr2oTImTTxXmzPI934zh+gjyTq01V0GpltUYHkFBj+7WWjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtx6ST5JEqWmNXCtMa5/7dXTvKOV22OsLm9y33xpsuc=;
 b=fD0/ou0CF3+nn3o0AMIoN6su74A7VYF67j9F0GQgcVtwYfvHiELzhComuAHr5gv+o5BftCNanPdWJsPps5iWnjJSacaT+GTlwo6qf9kFvHe8SY1AzyGoM7snDC0rEPUZUXyeeW1FgEmI/ARKKz5MDcm+i2JEk/eq03dairf1eukw64785+q98nzaRwDlJvr7lO6b+qC/UqfnEJ8fohdNoDazbpBcymN+JbMiUdf4pjGSAgHtu4FTmk1O6/9Lh0l77atmou9n77Fa8l2/rQQ+bhsg950j+vEBLEQ0U8ZtFK90hHFwhgEXKUjXu+s+yQCsQ/WkPXKBrjm0M/1gOQNWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtx6ST5JEqWmNXCtMa5/7dXTvKOV22OsLm9y33xpsuc=;
 b=WxMEhXmdrYZKwsGkoUgRux10VuImjbH6sxTq3tEry0dyKlDLNissgbSC9A1FAw5s2CiJls2FFwd8wjew8juAkkIBbc5We1WP9hAOT94MTKY2wfRHgf6GUM0H4IrVBmXrhTVzTJuhnJFE8AjxBCP5qRyDRISlzPx0OhZ9Y+KSJX4=
Received: from PH7PR10CA0017.namprd10.prod.outlook.com (2603:10b6:510:23d::10)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 08:05:56 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::23) by PH7PR10CA0017.outlook.office365.com
 (2603:10b6:510:23d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 08:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 08:05:55 +0000
Received: from [10.136.38.22] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 02:05:49 -0600
Message-ID: <3ce5065e-8b9b-46a8-b7c1-5f9b8f118b06@amd.com>
Date: Fri, 28 Feb 2025 13:35:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix SCHED_IDLE behavior on wakeup preemption
To: Abel Wu <wuyun.abel@bytedance.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Phil Auld <pauld@redhat.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Josh Don
	<joshdon@google.com>, Tianchen Ding <dtcccc@linux.alibaba.com>
CC: "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250227085815.18131-1-wuyun.abel@bytedance.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250227085815.18131-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: e6065510-e6c2-409e-3c37-08dd57ceba66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFBZUmRaYkJXYkhneEhoQ1RzR3FQMzlHWWxrbGtWbDl5bWxyK0c3MS9GdDJC?=
 =?utf-8?B?VFJiT2ZnQ0JrNUN4QWlZMzZibW0rWmhGRE5wQklDQWVlV1MvKzdKY09FMkN5?=
 =?utf-8?B?S3k1eVJ3a3hlaGpRREdHM3NYVnNQT2MvbkJ5ekRwQ3k2dzZSb0w5ZEJIb2xP?=
 =?utf-8?B?NDI4a3ZGZG9GNzFSS0RkMTgwNUZmMiswaHEvWVI4VE9USjZSVzB6L2YzWEhB?=
 =?utf-8?B?OVVtY0RhaUt1WTRFb0NXOTBmblRJU2Nnd1NJa1lrRTRLUjlXN3dTTUREc2lI?=
 =?utf-8?B?Z1FSVjA1ZkxTSUZwWHRlaHgzcHFOM3ZTSmhYL0RtRXRML2lvaFVwTmdmd01s?=
 =?utf-8?B?UGU2T1p2RlNFdElqakt1UEc1ZHNuM1Nrb1N2OWVncnFXNjNlL0Ivbk5ZNkJR?=
 =?utf-8?B?b3gwc0tzeVdYZmhUYWJLR2RCTFFvMGJEU09IdkdkNDNybGNkZVlDRUlBMUV0?=
 =?utf-8?B?QkRQZGIxWkVqK2IrS3BPemRIVUJaM0NtS2RYVFUvWlJuOUNCb0VsOWF2d1Fn?=
 =?utf-8?B?Rmx0YjdHVTBQaVlaWDZYcm5McG0ySkxwVURQVzZ3WWVMbTNxSldCTnBPSC9S?=
 =?utf-8?B?SExsK0R4UTJuWEFnMXh1ZlhsbkxOSUZYNHJtbVhZekhsN21ML1NmYkM0SmVp?=
 =?utf-8?B?YmI2ZDBYTHQwb2drS3pNby9PdXRWTXU4N01pVnJvUTdKcTh5bXhzeTl1RlJJ?=
 =?utf-8?B?M0lzbFh3cVExcFVZNTc1cC9EQk03bnFqcjBKdW5ldlptWGhwa2NRaWVMMkh4?=
 =?utf-8?B?NEJpRXU4djVja1k4Z0FOcFN4SGpZZWJqaXBmZVpwaG94S2JnWlUxTThoQmdF?=
 =?utf-8?B?anorc25RcWZYTld3NzVJa0xwL1BRam5qQjVRemdqY2FSWkxndytGbi9rWmcr?=
 =?utf-8?B?VllHaDZkM0YwK3FwdGVQWDkrL3lqVHNvUVdGRDFBVnY3bXZJYVhienNOQ0lO?=
 =?utf-8?B?dGJiTlh3QmlSQlJRaEU2dll1R21ISFgybkl2aXkxRVZXeXRwRWxHS1B4dG41?=
 =?utf-8?B?Si9WWmovS1JwbmN4K3ZvOXlIQ29YRmhDWmNhM2l1NTE0NGZvSSsyUE1tc2da?=
 =?utf-8?B?Sy8vOStReVp0RjFkWitKR2F3UE0wTXZXYi9RYjFDVytzbnZFRmFvRk04NUkv?=
 =?utf-8?B?WkZITDBUOFE1MkxZUFEzSHMyTGxhcFR0YmpMMzdrL2FTQlpGMzQ0VDk1c0hl?=
 =?utf-8?B?QjdSNk0yQWdFQUpoTUFoaC9MZGt0cStGaDMyVjBHbUtkTFRmU1p4cVZ4UTh5?=
 =?utf-8?B?NUtZQlF6bkZmLzlkTmIvQi9NSEdOWEZWdjlEQWVDZ0pvQ1daUy9EMko3STRj?=
 =?utf-8?B?VlRJRkM0TXc2eEYwU1hUUTlWZnl4WFRJN3JVNmQ0VTg0YkFDajhLUnBMWFVh?=
 =?utf-8?B?bkM3VjZGYXVSdXlKWmVkL2hJV2U3QjQ3RURwakF6cklsTnZWQVIwYWFLSUxG?=
 =?utf-8?B?b0ZNTWR0OUxFUGJCUThYb2RxS045YWpxYjE2YVdZNENwN0ZmUzFrVHY5dHpq?=
 =?utf-8?B?eE1ERUlsbHNMTWJIMjNFQTVCenhCa0ZaTmpSbDJ4SjI0eWgxVk1oSWM0WERa?=
 =?utf-8?B?UVU1Tk9xYzNkeDdjNmRnclJ1RU00M3NKeFVHMUpHOFp6eURHOU9iVFZxeVdG?=
 =?utf-8?B?SU1aeS9YeXNSUGtRbFhIekhoYXJDdk1wQXd6Skx6cEhlSkZwQVk2ZUJWcWtr?=
 =?utf-8?B?MUJPaDl5c3RQQjVxaGl5T0c3Q0xJci92OEdjd1lvQTR1a1hWUHAxVkxBV1E5?=
 =?utf-8?B?QkxTRm9kL3JWVVJDZ2kyUTRNU1czNGJvKzQrcElKRU52U2p1SkpzTXlxbW1s?=
 =?utf-8?B?Y2RKWUdVcUJzVVRyWmpNdTFCejJ5d0F5TXgvQ3dmeFlkTFNWVDBwbXd1cWZ1?=
 =?utf-8?B?RGRob0YzNEV4TmtmWHFoV0QxZFdhbTNrMkIxY1VIc3NWU1hMNXpzcnFoUjFV?=
 =?utf-8?B?dlFTNXNpc1NyTExQbHpqaExkNGdFY3pwZzI4bHZvakYxMG5NWjlvSWs4SnN2?=
 =?utf-8?B?cE9WQXVPRXFYdWF1YlNDbTdvNlJ5ZEphdGp5YjlzMmVTM1gzcWVBaGM1cG9s?=
 =?utf-8?Q?O2yBRo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:05:55.6588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6065510-e6c2-409e-3c37-08dd57ceba66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516

Hello Abel,

On 2/27/2025 2:28 PM, Abel Wu wrote:
> The commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
> defines the behavior of SCHED_IDLE as following:
> 
>   - no SCHED_IDLE buddies
>   - never let SCHED_IDLE preempt on wakeup
>   - always preempt SCHED_IDLE on wakeup
>   - limit SLEEPER fairness for SCHED_IDLE
> 
> and the middle two of them are broken now.

Feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
-- 
Thanks and Regards,
Prateek

> 
> v2:
>   - Collect Reviewed-by tags from Vincent, Josh and Madadi, thanks!
>   - Rebased to up-to-date tip. (Madadi)
>   - Folded some discussion with Vincent into commit log.
> 
> Abel Wu (2):
>    sched/fair: Do not let idle entities preempt others
>    sched/fair: Fix premature check of WAKEUP_PREEMPTION
> 
>   kernel/sched/fair.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 




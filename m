Return-Path: <linux-kernel+bounces-560683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8146A60819
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4845719C3763
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34924136327;
	Fri, 14 Mar 2025 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wryUbDf7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90F34545
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741927889; cv=fail; b=Noc2yxu4H1d3uz1cO4TIq7rZKN6IWOYUhx942t2x+AT9fDmTWqYabs2/zYNBRWomx4jkJuau+PDKwxBibFkwtBywATo6Q+S7fkx2LQ4eRe85MEo07qR90CjSqeKNFpmIeS7ZGtUv4azU4KYkQ0QOL20WlS/JcucsmwzBtt9xXKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741927889; c=relaxed/simple;
	bh=xp4HjfyFZ+sMtvLwLbyFQrcXkOc9Os3g0ECzNnltE3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EjkmAW5kSbjfuJhY6gdg6DV+od3YI9m7gLjBlu2UwBbtC62oFEdmdTd8kgrT9593w+AmswpF81HvPI0dkA8vXMyZ2Lg4aFFamnikVZPtZdTN4TWR2dLqJ9fM6DEn6YDk0bPy1+Yr3W3yWB24IHGHMw2yYZDBULCbUgOti8t5e4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wryUbDf7; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/Q1dboUhNvtyaVGKaOB1cZruzLDwY45j4lePu+32DkUXSw4lp3UOgvuC/PVgn3yBlan04Kj2RIO0x8UlHoSkCxqkRqbXZ+1rE6EKwAucvP/j0X9vzOPXwkMECqlucualb2cRCjtpQJijwJ5eZpgbdFRl9Njab3UzB5p6GdKXjBpcC8DtIjm40UMvvbQ8TiaAAkyuVHcJwOehpdK32N59XXs6G2GTHHiyh1W2mFT0W7BpcwNg5QsoNNW8cOS10BmftMPVTH5/nDEmrbZlhgJNrapD12zl2O1Fl1kD7g0Zfg/NkcHHhRTn2/DkKKAXv4y28S4hxURGPbAK7GjvCSA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n94075STmO3h965jTC8pFCQ3HDWmVRSyfC1OsHamJ24=;
 b=j66Pt6DIxnsCUOOHkK515NmTos00BkmLNy/DHyqIq8XXeWQPximsh7mMRknEGtpEhtkliG6lt69S4+BpCinArgM0vn+39Oj6HBMyPXaB5y9pnuKe6vZqG9dm/LYsyJjGelnCr8xZ/YjaK8jHnq0fCHqzHkC5frKicwDnUgzRi3zAvzCmWUwfNtX7ly4hdetYM0sUvhcHl7KS+APWQ65NK0usu81i9r5gMr4VIH6RLObH9otFlGEVpmwXmoevHGsQUbqQH4QBG6qXUsTF2IU2xoMo6+r9b3cLhnMTUOmxQHaWbDCqZS0HOzl37tKgqLXT5/o/TwwsI1WV79XG8SqVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n94075STmO3h965jTC8pFCQ3HDWmVRSyfC1OsHamJ24=;
 b=wryUbDf7vEogNi4pxBoaPUUYZQOfLhQAU0jSX1r8U7Qa8frL7jzPYWAdsIcrE00U7lT8RERnQJHyyiGOl6AGyOvx9DT8njJGLf4VHUhV0Ckxti79vAl0L6/q+QVDPoY5sdNx1nGt6uaKn+68x2wRKqkv/vEfLincWXgWLIdHyIE=
Received: from PH8PR15CA0016.namprd15.prod.outlook.com (2603:10b6:510:2d2::26)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:51:23 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::27) by PH8PR15CA0016.outlook.office365.com
 (2603:10b6:510:2d2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Fri,
 14 Mar 2025 04:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 04:51:22 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 23:51:18 -0500
Message-ID: <360430bb-1fda-40b8-b1bb-971025d4866c@amd.com>
Date: Fri, 14 Mar 2025 10:21:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] sched/fair: Take care of
 group/affinity/sched_class change for throttled task
To: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chengming Zhou
	<chengming.zhou@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0Gcm92LNtei5yLym-5dK96gb5GF2-tDoLJ+YS0fMx8jADg@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANCG0Gcm92LNtei5yLym-5dK96gb5GF2-tDoLJ+YS0fMx8jADg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8de309-360e-4716-8d5c-08dd62b3dea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm1jbUhQbkg2ekJYK2RESE4wSXhQbWlEZXlzdWpRRmNLeHh2WFYrT2NEa3JB?=
 =?utf-8?B?NDM3c1N1alNOdTFoU3oxMlRiQVNsV2NuaTFNOGpxcjFQenpiaVk0TDNmdjBo?=
 =?utf-8?B?d01pejJlUk1KbFk2YXpRcWJUaTNybThLZGJSN1hsMFVYa09FSk92eUpqWllB?=
 =?utf-8?B?U1VGYlFsS09SaWx2bThOTXFmZk5RUVdqZzVYWlFwaXlwYWxLZ3ozMkV6elhs?=
 =?utf-8?B?Rkt0Wkh0VjlZUjBGYjBUUDJGUmVFTVE3ME80cGx6OVBnMDhHYnhodHlIb3Nk?=
 =?utf-8?B?NExUVGMvSnZGbENOZ1RRUmRQMWhsa25oaW1VTnU1L2NzZXMwcXlseitUb0JD?=
 =?utf-8?B?clBLTzFySis3UkVYNXNKS24rUWN4MEVVY0p0R1RmVUk0eHlQRE01Mk94WEJz?=
 =?utf-8?B?WjVUZ1JIN2llNHpDWlNSTHJoSTNnWnNHelRrcTJnS1BCQys4dDlyRFU5OWVq?=
 =?utf-8?B?a3ZpVFJHRVF4L3dxaGdpT0NSRDNOU0NUR0dPbkxHK3NRVThUcExXMWN2YlBo?=
 =?utf-8?B?d0RVbEVTRzE3SVZjRFRyYXZocjd0Y1d0Y0NDYmN5NGI1Ui92ODZTV0tkV2pj?=
 =?utf-8?B?Y0tleE1tc2htZUwzeG9ySjllRFdTUGtNNC9RcDE1NHQ1NVI0OXdEYnA4V2pu?=
 =?utf-8?B?TUJ0dk5JRkpqUkppWVVUYnBqdFRwaFhPeDQvM1pVRllVZGlMSENuc1lvRnVP?=
 =?utf-8?B?cSttQllydHFYOXVsMjJrekVyUUxFYndZeDVlV2F0WWxJNDJ0RWo2N3lFUHpK?=
 =?utf-8?B?RE9vUkpFKzRHcG1qSDhMOEVXUnhnQUNrdk9LREdaZm84bFBNY3VaeTJHay9K?=
 =?utf-8?B?WXkvU3hYdXEvTWxFbFYrYmlXd045WTlzZDJ5WEdKY0paRnl1WHluSjYrYjVo?=
 =?utf-8?B?ajcvOWlmSkZMdnYwWTV1MjZ5ZHJOSFp5UmJHeVZ3aWlBNkdTRHBIZlgwRFBv?=
 =?utf-8?B?Z1lyZHhtOFNwZzhHUGVXR3Zsb011Q2pFaDZCemxpZktvaVprQytGYTlFVzNZ?=
 =?utf-8?B?MFliVWxyZlYrOFBEellmSVcvU3U0VWp3U3VtRHhIMnlYNkJSR3NEbTc2K21h?=
 =?utf-8?B?NG1PNHNwTlRPbVJXcm1kbG5qci9DMDlIRWxzeVNHQWRmL25vTkJqSXc2NmF5?=
 =?utf-8?B?cEVJeWYyQTdHNmpML1NwT0M0VnR4SmdXc1NGUW9tbTZLL2VaSjVyeUFBd2Yx?=
 =?utf-8?B?Z1NCQWQ1NitFeGkyS2lwV3JwWjZFUEpuZ1NnbHBBU25UQUdoVzArWHB1QkpC?=
 =?utf-8?B?OFRwamUranpOK0xuY2xycW1FSGRPb1JpWHRNaVRkQ2IwRDlXOXl2ODZHbStK?=
 =?utf-8?B?R1pEenRUUEZIZ2t6ZjluNXloQnN0YzZTbkZSNEdYWjJiazNJQk4vY0UxOG95?=
 =?utf-8?B?RzcvT1I4ZWZ5TlVwVFN2bG1QbEROR0dYVjVwOTdZWGFEYkF3VTBGZlY3WEZx?=
 =?utf-8?B?ekxYZWpseHVsaDVBRXJSMkhYMFB3U2p0QW9GaXhUVXdtWExNb0FETHpJcG1M?=
 =?utf-8?B?VHVJVHhzbDNkWFpObm9yakl3NVpaNWRYL2ZCUFlNZ3JicDRBV2x4R05Na1Jm?=
 =?utf-8?B?bVd0UldXS3owMktmUU0yTWxVR0dlaitBdUJQWXNleUV2Mis1SlptZU96STNm?=
 =?utf-8?B?MG5YWENSL2xFOFB2RjZxMGVkZDJ0MlpUQnVabDNxdTZxbWUvcnZDaTRQYUJG?=
 =?utf-8?B?RTNxQThxSHY0dlAxWW9kWDhLdDNiR1BGZlN3MDFNOVh5RGEwcmNJNWg3c3ZX?=
 =?utf-8?B?azJFOTI5UWFKVDhnT2thbHpyUUhOZG90NEZzL1E5eXk3MlhlOWk2Z0g2KzR5?=
 =?utf-8?B?aUVST0lUNklncEVNY29tV1JXK3U4OXBNWlZGazY4b21PVytoTU1XVzNLRk9z?=
 =?utf-8?B?VGF4R2phRnVGMC9aQmVOZi8xLzZQSXhpSWZaQWxnV3FjQ3RsaURkcHltcG5p?=
 =?utf-8?B?U0k0b2QybGtSYk1VMTdwWGFKWGtsSnMxS0xBWk1sSmVySnVtaWNPWUVzai81?=
 =?utf-8?B?UVRYbHJDbHhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:51:22.9131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8de309-360e-4716-8d5c-08dd62b3dea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782

Hello Aaron,

On 3/13/2025 12:51 PM, Aaron Lu wrote:
[..snip..]

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5876,8 +5876,8 @@ static void throttle_cfs_rq_work(struct
> callback_head *work)
> 
>   	update_rq_clock(rq);
>   	WARN_ON_ONCE(!list_empty(&p->throttle_node));
> -	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>   	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
> +	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>   	resched_curr(rq);

nit. Perhaps this bit can be moved to Patch 2 to consolidate all
changes in throttle_cfs_rq_work()

> 
>   out_unlock:

[..snip..]

-- 
Thanks and Regards,
Prateek



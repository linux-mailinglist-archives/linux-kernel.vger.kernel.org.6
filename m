Return-Path: <linux-kernel+bounces-255927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E881A9346B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E681F2223F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9463A1C9;
	Thu, 18 Jul 2024 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LyVfzpNX"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CA259C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721273338; cv=fail; b=e+tNZ4L/YeVNE1XCtME7FziK7pnDj/bztcX4XhqTABpV7HiJFqkxe/ifEMhoKePSd2UCNNNJJ9zOz2xyq7q/e0NGX/X5esvBMtGp49u11XOZwiDTAyCRWh/kkJ+2nYnBhi+BjPWfHidisFLLSfakC4wiucgAW+eAQrkomroqu6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721273338; c=relaxed/simple;
	bh=UWDfX3cJOlGAy4F/0Q890B/zIgYLsBIR4l2lpPfxLwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SQbzyg4DGOU+YhelZsUYCrn9NgGB4pEhTv0VH6dp/s+xMAO1/Jqng3YWmB9RTisohOTolMz5h2rdCdnvjdTUo3/nwEnALIiZMHuvnAzMS48ce35TpwBwPSXxWbSN1ACXkd81S5goQdDJyS6gR1Asexxec4MWO0tU3lyXYsuh7j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LyVfzpNX; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdrzZ36TCvdhH4vmR4F5dNyTHjD6i81OUYfb61EVS1DklnX084PBRCVplOrRjfMNRifLMUPUCOqjD8lDh+Xnj53Ycm9QATry2DU2P8ZbjF5eA7cqCLfu0Uu8fGY4jZQ1nJobGbwQcIh8D6BiZ5/B6rOOflGcsyF0XWPGd2y7rwFx62PDc39A2ohcNWhXZiJMJhJNcLMY5Ryboo1/J7wsFUMsL6jU4mPqUy4ZxyEwXQL/fQsDF4ImzULpu7sbU7hFU+h8Uz4kVaNlloUst0VUH6u149bXYYX+bvX7Pi8IBkNS2eXC/Sqg0ZA7m6zxS+ZgeCw/A9loagzQKYAKLa9+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auGXVcGE8fqsl4EvlITIFFf4ZWyBxvg9YdLx04wRAjA=;
 b=GBbSnC4TCF3GjqCUzXiEOpIL4KZ2GB7k1iAY04zFwHEI3Te5LZCfzg33clqK4EWfK4xxC36R1fQN6xZZJ8wB78rMcxK9b8WqpBt3II6tTV6lN6N3fUHx4qmIoO9uEu/pMIeUq63vFKLdo7aPyGhJSJOcSqzExS0ig9wjcV3QffRHrUhpbl9o7l9+M53iLldJhBAEWFCqm8PO5X4iu975G9ZB8z7yYrsr1JCpMOoI/OZzFzwd5fvwJeoT4ac2ta/I0cNnSnVub5aqBuYjoS05P/m6e9eUldn6RhYDenMxarJH4aQeqvQLnBBIKrHumfMN8EphbWGLIgnqBBbBTuHl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auGXVcGE8fqsl4EvlITIFFf4ZWyBxvg9YdLx04wRAjA=;
 b=LyVfzpNXHj6tGyCu+H5htyF66HZzX5s45T8IZwuXDBVfh3+l2lPuJs0O+jsm+OKMW9yE5YTtdBY1XpllsQ8V8qRTWb3CTQMdckFpsvYMT6S5mRTHgtjHmK1vCDWMW/5BV01xs9YyrA+UeKCuvMzYwbIGkEuSqVS1lG5nWGMdZlA=
Received: from SA0PR11CA0136.namprd11.prod.outlook.com (2603:10b6:806:131::21)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 03:28:53 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:131:cafe::76) by SA0PR11CA0136.outlook.office365.com
 (2603:10b6:806:131::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 03:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 03:28:53 +0000
Received: from [10.136.40.40] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 22:28:50 -0500
Message-ID: <3a2efbd7-075c-2a93-0ea7-51566362f17e@amd.com>
Date: Thu, 18 Jul 2024 08:58:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] sched/fair: Remove cfs_rq::nr_spread_over and
 cfs_rq::exec_clock
Content-Language: en-US
To: Chuyi Zhou <zhouchuyi@bytedance.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <chengming.zhou@linux.dev>, <linux-kernel@vger.kernel.org>, Vishal
 Chourasia <vishalc@linux.ibm.com>
References: <20240717143342.593262-1-zhouchuyi@bytedance.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240717143342.593262-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da0c6d2-3901-4012-45e4-08dca6d9bfb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDNXdEEvMkNUY3VyaHVONDZ1VlRBeHFQdzNEL2Y2ZjNCNS93UUNLb0IrRHQz?=
 =?utf-8?B?cU4vSGtIaUhQUnd6RmFEZ1htTG9FeCtCUU9kOVFvMmNmSWhyUDc2SkxIMmIx?=
 =?utf-8?B?Q0k2VkhKSWt3WktaOEUxN0tkSE9iMnBLQVJHSGszYXZQTzdybUpCVVBKOXFs?=
 =?utf-8?B?NFdkYmh4S2Jmb0NWcC9EZFEyTG9FaHN1SnlRd1U4dzlpNkVxdWJWVkhUWWwy?=
 =?utf-8?B?Ny9wemdwMklIQ2hDbGtlcmNWLzVaUWQxbm5zRndlSWc2WFFPcDdFUTlsZ3hY?=
 =?utf-8?B?bW03YzBqbkk4L3MxWE43Q21JVHF0UXo2RkxtaFUyYWlUUm0xeEpOMXExSks1?=
 =?utf-8?B?M0JvSVFkTm9KalVmLzgzUUtwOUhZdkVaYWtVNG5TV1g2amdWYStMTkhLR25v?=
 =?utf-8?B?RHpKaVZuK2kzeDNKWXZwOUVjdjRiU2NBRVNrbU12SVB5cUpxNWQxMFFINm5W?=
 =?utf-8?B?eWh2OVlRVkdSbE5aTktrYVBCdVBRQTNFM1YyN1FDOVpWaFU4Mk1tREJTNlUr?=
 =?utf-8?B?QTlRcE1QL3J2Qm5uUFBES2dwVlA0V3d5YUlibFZqMTRwNXYyYjYxUUorRXow?=
 =?utf-8?B?NTdlNWNndDMyKzROZk9QNE5GU05XTitSSlo3bVlRYmN5dGNVUUhtZFF3NHg4?=
 =?utf-8?B?cU02Q3ZwdExUR1ZneW5uaFZIeEI5RmtYM1gyM0ZmeHZBVXU3bElYVG5VK2Ju?=
 =?utf-8?B?dTROWGpPQ1U2aGRtV1U3Wk53czcyVnc2V1pybnY0VmE3OFJqWEdNanNRWkZZ?=
 =?utf-8?B?ckZua3VoRXlUVGhjdEpqVXZ0RzVDUDNLYkZiR0NRNXBWL0g2U1NORmFBeCsx?=
 =?utf-8?B?MzZPNXRIUE8zWVVlNkt0WFBPajk5YkpIbWcyVVFXYW91REZ2NlZ4L0FBVEEv?=
 =?utf-8?B?MEZrSEc1b01iQUZBSTV5S2JoYkxkcDFodzMyMXBkVU1ZaElLdEFCOFJ0cmNC?=
 =?utf-8?B?QUdRaTJtNlNRT2c3cHI3ZjErb0ZQVUNKWklpMVdKNzl4ZlloVXlwNmxodGNL?=
 =?utf-8?B?Mm51eGd1N2ZZWDZUMDdEZGFGczF0QnB0K0lmUVVnQUpEM0pydUE1NE5RZFBE?=
 =?utf-8?B?WWkzb0I1Y2lFbHVETVlDT2R0dGdFdW10OWYvTkt5NEx4L242UUJCZk1tRDMx?=
 =?utf-8?B?RTlhNGRhaGU2RG5TNWFPVEUyS1lZajZrc2ZFS3ZjbmZHcENzaFJPTXpVeHVm?=
 =?utf-8?B?cGdzQ0UxOXQwckFSeXJERU5GK1dJN2FkOHk1Syt6MUJsSE50R2wyTU9VRUo0?=
 =?utf-8?B?aTh6N1pnRUFCcS8xR2h5eWdIUFZMY2l1T3lpbktFcks2dnBUMzN0VEI3SGNz?=
 =?utf-8?B?SXIwVlBqYXBkUmNla094aGFWTEQxMmt2UTROUlNkRFRDS3FrL3dNSmpzd0FH?=
 =?utf-8?B?RXViZFVOanRrOXNtMXRXbUYxWG1XVU82WjkzcHY3R2F3aWtsQWFJaDY3L3Av?=
 =?utf-8?B?VmJDL3hXd3JTVmZyK1VhZ0VENi8yYVppUU1kMTZUTG1oVnAveTBFNzVyNTFa?=
 =?utf-8?B?MXAvSkxjaURYdEhldjVzUmZ3Qm1lK0JiNHB5Mm5xZUJ5eDYwa2NUd0tMRndE?=
 =?utf-8?B?QmNzUWxZVmJBK1lGOGZBckp6clQ0ZlRlWFY5TzJMR3NJNVFId0s4bWhkTmVR?=
 =?utf-8?B?cDhtMkV0dmd0WHpncGoxQk00YVYxK216MkVROFZ1M0p4MFYrMUhmK3Q0eDFY?=
 =?utf-8?B?ZFhUelZBOE43MzVBK2YyY0kyWDJwU3JkRFNrYzhMVndIb0s4N0NoeGg3STc3?=
 =?utf-8?B?SnBITEszYnhhSkJVbjArZUd1cFFDbnRRWU53RGZvVGpRcytLT0dBVm9OL3dO?=
 =?utf-8?B?WVlkQjZlajV0cXVxMm54bWV0ZEFGNU1iU0VaTWpjZWxSS3pncTFPNXRlTEFP?=
 =?utf-8?B?alJDdkNIeTJuQ3dBT3dTNFlmUkFlTDRGTFVhRm9KVWhiWlRsaE94dVNkSDlR?=
 =?utf-8?Q?0oR9DyJz3o/e/XhWYVbqWPCn/jqhNy4h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 03:28:53.3297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da0c6d2-3901-4012-45e4-08dca6d9bfb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268

Hello Chuyi,

On 7/17/2024 8:03 PM, Chuyi Zhou wrote:
> nr_spread_over tracks the number of instances where the difference
> between a scheduling entity's virtual runtime and the minimum virtual
> runtime in the runqueue exceeds three times the scheduler latency,
> indicating significant disparity in task scheduling.
> Commit that removed its usage: 5e963f2bd: sched/fair: Commit to EEVDF

scripts/checkpatch.pl complains about the commit description style here.
The above can be reworded as:

Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed its usage.

> 
> cfs_rq->exec_clock was used to account for time spent executing tasks.
> Commit that removed its usage: 5d69eca542ee1 sched: Unify runtime
> accounting across classes

And this as:

Commit 5d69eca542ee ("sched: Unify runtime accounting across classes")
removed its usage.

> 
> cfs_rq::nr_spread_over and cfs_rq::exec_clock are not used anymore in
> eevdf. Remove them from struct cfs_rq.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> Acked-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Apart from those nits,

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
>   kernel/sched/debug.c | 4 ----
>   kernel/sched/sched.h | 6 ------
>   2 files changed, 10 deletions(-)
> 
> [..snip..]


Return-Path: <linux-kernel+bounces-510486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E96A31DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF17188A5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797A613C9B3;
	Wed, 12 Feb 2025 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N04RWCI0"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0902D600
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739336822; cv=fail; b=e1BRvdx+FbN8RVnT0ykS1TJRmM8uSWFnPRkWqedapTlXJu0tHVlOjxzNrl+BYlL7T/9pryUKzuBEcNMrh+3TxjPYPfLZuq4IH5QZC2+nAKgnIqw3DLBmk3v/LDdJT71jBojD2p0XTE08GtbygBDYPPdibvjJD1hsn6eEh2ryNAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739336822; c=relaxed/simple;
	bh=iJp2JqYfvz112r3gF+5yTVpgvLLhd29Z5hUYPUsUr3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrYtEIZnsBPbLfF68zbcwjbO6NBSB11E17waglp5aiFrwtvIDzhuws0091zGTKOEB0t9FVx0HrxCNlERkyIKnq3VcwzfW+383k9V2cw6AseSB50MfD5ubNyw7faSJOldln0qFXNFbFGWeHi+APldZKm0+Lbt+MBUaedgusIuuRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N04RWCI0; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLp32P0id/Beb0sedpZHQiNPzx1u0i11WMEWTkgOQwJcpxU1QLOeDDrmGgVgmHYNn2gqNG2cKoNw+3pUy7mc/T8N3LG7LZND8lY6wDJMKRej37eIjCmwkO4NEdYmjVqPgbm+j5L5RerpoJKrH4peuufO4n6KRbdoKhylXbto5yXplr8eZ3wRwBcxcUxRR2xNwewBEGRbMM3LFC+QRQvguR9DWUAOw5o9ZmRXQa9z4QG25gKCPmBVTwcvG4RKZ5l097QsT4ACOaryOEJiHKt85TfLCL+eExhVSL+h5mwsUzjHn28Gz6UsYEWf1hGf8Q7wwW++N7tassFNJoE/ipy2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN8jbZyFVNduMkvFYCOcG3rUaT9KM2Pt4n6mpoCTmt8=;
 b=RhRLHUtQMrcjDmS4URiIw65LPjrcGh0loO+xt5KxpGY5IZpHnByXSvEGhxh1TudRLSQyhG1kiP7+958v+lbCgPZlnTilXFFsa5ZVEH+Z5iB1YKkaZvDjySCQAN0sYuAxOZKVA4th3FDk2mObq9W7gJigWzogJtKtnUBrtrDTOV0vsKDLLFuryVDgTlq+aPXd3eWshOm9cpHV97LMwL6Ut8Kj3K+JzYDLZCoBYA32r/NIzLpM9BRBLxWKOw8HQ5QhgFWjbq5IrNLAwLXAlNtU47kNVkkeHFzX9PPuzw67ozC5yXQKbuLaR6n2t2dU2PmHFw2lzJPqTqT1CR3ytJ4e8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN8jbZyFVNduMkvFYCOcG3rUaT9KM2Pt4n6mpoCTmt8=;
 b=N04RWCI08UK5Ae7p/iIDnzMEDZQ94KfPR1ZWCM1kLNVk2Hex2EfpzhylEwWXLaH76LCLxncSaal/07RkEcQ4cN8WWE32SLyMpoMYmqwOITmuo4+JwyDwJFsBunMjQz4rxUXznhpZVi1GZfIBmc6RhafTMAAMo9qSJEXv/ECOK7w=
Received: from SJ0PR05CA0132.namprd05.prod.outlook.com (2603:10b6:a03:33d::17)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 05:06:58 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::bb) by SJ0PR05CA0132.outlook.office365.com
 (2603:10b6:a03:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Wed,
 12 Feb 2025 05:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 05:06:57 +0000
Received: from spgblr-titan-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:04:53 -0600
From: Nikhil Dhama <nikhil.dhama@amd.com>
To: <akpm@linux-foundation.org>
CC: <bharata@amd.com>, <huang.ying.caritas@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <nikhil.dhama@amd.com>,
	<raghavendra.kodsarathimmappa@amd.com>, <ying.huang@linux.alibaba.com>
Subject: Re: [FIX PATCH] mm: pcp: fix pcp->free_count reduction on page allocation
Date: Wed, 12 Feb 2025 10:34:03 +0530
Message-ID: <20250212050403.17504-1-nikhil.dhama@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128203118.578a46182beea6a82dcd0b1d@linux-foundation.org>
References: <20250128203118.578a46182beea6a82dcd0b1d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 61105f2d-9cd9-4cf7-8fc4-08dd4b231355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ajc+cVFj7C9Q1S0LNw0a0TOFpfiOQpO8FutpwarHl69HrPWHcyb5ERr38pXZ?=
 =?us-ascii?Q?ydqiV7aIKwsT6UZrYbw8eNuZUbco9qeOvCksLwBwPudN9tQqqGfWP4w79uhZ?=
 =?us-ascii?Q?xfmi0UHSWMtd/WhJdho6ZTg2T4K+AuHnnt94ual8gOr1sVQSMuHXqU///3Ln?=
 =?us-ascii?Q?2ldcR5annYreT1axehAdCU3ZLJRtCl2YvBw6Apsv7Opb0GRPf4qGWTsbt+eB?=
 =?us-ascii?Q?pVwvv4hCg56cs5Y2ZWnJDoUrR48EZM1AACr3QMU4F1++ZkZu2hkvS0vI/jU2?=
 =?us-ascii?Q?UZrEzGJQIdar6zxgyzQ1DRu8CzC/R2VZwoHefnqPxROs37EMZZdFLdlP/+zY?=
 =?us-ascii?Q?B9povv+LgcGT/i7WRV2x2H/R4O1nP0LSzTRFVZEkwbckdDkq+73qQeuLMhwm?=
 =?us-ascii?Q?fBIr/0o2E0OEakfo0v7IUg3XViKXsqDixMXLVeYCqvhDHDwS7H39dn6s1tYT?=
 =?us-ascii?Q?O5KR/GT2XIJ6n7uK17G7bJhsZzW/GhWpEQ+9MySAuTVJL/dGGfXcLQUlquPO?=
 =?us-ascii?Q?R9zADooN1V9lZdNayuw5QrYvJUJ71/1xUo+6L/RRxuULgKbB/Ckb8NhdI7V9?=
 =?us-ascii?Q?TVVX5voX13haV2Yberi+uJq6Kf2NgG8fo4xMMRF4kUsPRhUd+VcDe9Xok9jA?=
 =?us-ascii?Q?RhA4J9IZNT7U/rlDOCpdsAfljXm38a7Qhc7vMMM5jRvzYpb/u/g3phSR1loL?=
 =?us-ascii?Q?/Nw1+YZGBCwDTe8mBK1NzLV6gvKON0GHAV6xI4ErW7YYN0ujJGSfnoJVIucs?=
 =?us-ascii?Q?Ka9Gra7CglT08G6EIFGRDbzv5Fz1FPm7E4SZTVqjiazxs5cUrdPtuFIXC34L?=
 =?us-ascii?Q?2fRWZvNNFZa5+WRBRj8DvFthqtAzJRI+Kv1JJQpJ8PlrNRTJzeQdupFATVT3?=
 =?us-ascii?Q?M7neXc683BIuNdRuMprc7TMTR6fABfSM6otrpz/ZqXN/nFavYMNBQZy9uTN8?=
 =?us-ascii?Q?P3aRX2ZxMlNKF6xh1IXSpJ7ac0vX0hTSytPFgXg5DJ/AtYUINgazu6xULdXq?=
 =?us-ascii?Q?eqR0lpd5nWuoW8r9dOmp4IIBD9XH3Nzi4Lpm4iCXW0FGlMmTiM5ghTW6fXfF?=
 =?us-ascii?Q?/evjRtGgtjZ+yBtUB81xospv7iV+pmSTHU21yzJjBgnhzPaykQOXQlfHTK/w?=
 =?us-ascii?Q?KuzCpiDPaEwBcXNq3lijR9bpf0+b1/sf+7lm7lrllkY20MlF4V3CmVi3Xwz3?=
 =?us-ascii?Q?mSzGwalyx8M1qLOHPj6nUi0daxrM/GJczj1b+vwrsitfZF+QP2oS+legdLjL?=
 =?us-ascii?Q?JJ96a9R/bCGGUsTJD8rEZBtZFy1I5Md0ohgNyf1txb1fHO63imAB2s5GdnxF?=
 =?us-ascii?Q?PE6GBzGDQemARf49pp3D+HbLwaCggEWwe+nTEqVOW3dHunR2FvIrQ1TwOJGM?=
 =?us-ascii?Q?OcR47Xnp6bwPnU0GpSfDAsLnRBwz5YsaBSh3FSP67YzzOxkkcWCtjUGcWdqK?=
 =?us-ascii?Q?WNP6hArfJOhWR6hKUetfTZxIME/QTSZKGqif3KV0Uzr5zdtQrXS2Pz6zkebW?=
 =?us-ascii?Q?XCFQKaCRpB6yr0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:06:57.5228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61105f2d-9cd9-4cf7-8fc4-08dd4b231355
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026


On 1/29/2025 10:01 AM, Andrew Morton wrote:
>
> On Wed, 15 Jan 2025 19:19:02 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
>> Andrew Morton <akpm@linux-foundation.org> writes:
>>
>>> On Tue, 7 Jan 2025 14:47:24 +0530 Nikhil Dhama <nikhil.dhama@amd.com> wrote:
>>>
>>>> In current PCP auto-tuning desgin, free_count was introduced to track
>>>> the consecutive page freeing with a counter, This counter is incremented
>>>> by the exact amount of pages that are freed, but reduced by half on
>>>> allocation. This is causing a 2-node iperf3 client to server's network
>>>> bandwidth to drop by 30% if we scale number of client-server pairs from 32
>>>> (where we achieved peak network bandwidth) to 64.
>>>>
>>>> To fix this issue, on allocation, reduce free_count by the exact number
>>>> of pages that are allocated instead of halving it.
>>> The present division by two appears to be somewhat randomly chosen.
>>> And as far as I can tell, this patch proposes replacing that with
>>> another somewhat random adjustment.
>>>
>>> What's the actual design here?  What are we attempting to do and why,
>>> and why is the proposed design superior to the present one?
>> Cc Mel for the original design.
>>
>> IIUC, pcp->free_count is used to identify the consecutive, pure, large
>> number of page freeing pattern.  For that pattern, larger batch will be
>> used to free pages from PCP to buddy to improve the performance.  Mixed
>> free/allocation pattern should not make pcp->free_count large, even if
>> the number of the pages freed is much larger than that of the pages
>> allocated in the long run.  So, pcp->free_count decreases rapidly for
>> the page allocation.
>>
>> Hi, Mel, please correct me if my understanding isn't correct.
>>
> hm, no Mel.
>
> Nikhil, please do continue to work on this - it seems that there will
> be a significant benefit to retuning this.


Hi Andrew,

I have analyzed the performance of different memory-sensitive workloads for these
two different ways to decrement pcp->free_count. I compared the score amongst
v6.6 mainline, v6.7 mainline and v6.7 with our patch.

For all the benchmarks, I used a 2-socket AMD server with 382 logical CPUs.

Results I got are as follows:
All scores are normalized with respect to v6.6 (base).


For all the benchmarks below (iperf3, lmbench3 unix, netperf, redis, gups, xsbench),
a higher score is better.

                    iperf3    lmbench3 Unix       1-node netperf       2-node netperf
                                  (AF_UNIX)   (SCTP_STREAM_MANY)   (SCTP_STREAM_MANY)
                   -------   --------------   ------------------   ------------------
v6.6 (base)            100              100                  100                  100
v6.7                    69            113.2                   99                98.59
v6.7 with my patch     100            112.1                100.3               101.16


                  redis standard    redis core    redis L3 Heavy    Gups    xsbench
                  --------------    ----------    --------------    ----    -------
v6.6 (base)                  100           100              100      100        100
v6.7                       99.45        101.66            99.47      100      98.14
v6.7 with my patch         99.76        101.12            99.75      100      99.56


and for graph500, hashjoin, pagerank and Kbuild, a lower score is better.

                     graph500     hashjoin      hashjoin    pagerank     Kbuild
                               (THP always)   (THP never)
                    ---------  ------------   -----------   --------     ------
v6.6 (base)              100           100           100         100        100
v6.7                  101.08         101.3         101.9         100       98.8
v6.7 with my patch     99.73           100        101.66         100       99.6

from these result I can conclude that this patch is performing better
or as good as base v6.7 on almost all of these workloads.


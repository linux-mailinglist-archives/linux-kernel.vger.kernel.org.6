Return-Path: <linux-kernel+bounces-567471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A4FA68676
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068327A8180
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966AB2505CE;
	Wed, 19 Mar 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y9TZ6TzM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9721E552
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372095; cv=fail; b=RZtu+5+9fKvhfn8vUs1K/YNUUNZZ7GdzAbwdH+UtyiNQtm3/1MaIgl19z4N7s3heh6aj6GqpjRc67+lhdLTsMfrD0cxsa6h6AxH/OMJuz9BCovdL+cvQpo9mT+2rbJh1gcvopKCAJcHxBuHVKp/MQ5SqIy4qIU4+pK4o5RVcgeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372095; c=relaxed/simple;
	bh=Abv7b7Ls1+LMLYfe+4tZha11E2SHg8HZNG8mb/YOBD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThxWpyLizb8whldFANivGmFQKZR8QwULjQr+fEhJx9tAU4wmE6s5T2SuP5EocpH5G99ZXI9lotYIbGkhvecHKevgMDlUL8tgFMiItDyLfgF294yghl4JG/m0rZk8AjnSoJdnxO5/d7HMrLJTUcQf87kMmmBrUtwnJZcBLCg/tjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y9TZ6TzM; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9xB4LngceMTLJ+A3SPixMH48PJAQftRZp9DgTCcDWNTXB5YKzrZbTdNgyfKAzkTMpWcHFAF1D+htEPNNtMqkTF3psW730sKNZZgEe0ND/n44lLAMzVJHqvdgoytaKCg3e/XYQMY60ygOYY/wkFAh5q5Q9Zj9a+B3kkEoJoW6zLfk5VwXHHPnlEkJfwqbZ5APqn86vCpMBDdvm98B3zDrPr1yXPqBbwoi6nsvxOX/Ceq9kpH6wneVGpt3pyJJ7jpPp19NPszquVe2/f9qNuePE5iJmyVtxnkuByYunb2lOCK1eL8GEThmLZkbux4/Q+RMVDMg1i5msTfK5eQIAOZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7NhgrxPEkWCRFnLmBgMH6va5kjrHWzHEh9+SwXYnYg=;
 b=m1GvzFXS+IlV1F5s7N2mC6dCsztfJIT+Uox+A/Tv0dlfc1cjW+K0/Wod/x7nbwcgkuRruv9TMZclcZ0DmJehSQf49yPekyt3rzlsuJYGAo+pPWdR0peCDc8uqtfulrT6yoCgDZda6sfYDJGZGZaoB++V/yn8slIMfWk8mDwj/fiKt8N5WTr5I6dyMWSGBYMTHlzyaKS7miItgPiG37DRUsjomweJf1mRgT8O49BioaOSz6al2Cm3nLrLENB4eKpHCkXJLBOH5XMqQE+rQ2qTdiz0ziebjXcCDCgn6GJpowAYnGuTP+Yx/7ocVWS7iNAZXUQIQfYKUb85Y7kpyK5gXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7NhgrxPEkWCRFnLmBgMH6va5kjrHWzHEh9+SwXYnYg=;
 b=y9TZ6TzMJ823N0ZQLOK7BUST4+H3IYrgCf49wq670MDFOYprzsBiEzu8Vq2UUHkmR5ugl9m5xR+URNLDAeew3QwYrGJgmqVZf+M2UEbpoUNifysVPjd6Rqf6I2fQ4UXo41ffLa9wC8WE1hoJVAeoqwu4FQWWYlhNYu4ppMPeJbc=
Received: from DM6PR04CA0019.namprd04.prod.outlook.com (2603:10b6:5:334::24)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 08:14:48 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::c2) by DM6PR04CA0019.outlook.office365.com
 (2603:10b6:5:334::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 08:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 08:14:48 +0000
Received: from spgblr-titan-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 03:14:45 -0500
From: Nikhil Dhama <nikhil.dhama@amd.com>
To: <akpm@linux-foundation.org>, <ying.huang@linux.alibaba.com>
CC: Nikhil Dhama <nikhil.dhama@amd.com>, Ying Huang
	<huang.ying.caritas@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Bharata B Rao <bharata@amd.com>, Raghavendra
	<raghavendra.kodsarathimmappa@amd.com>
Subject: [PATCH -V2] mm: pcp: scale batch to reduce number of high order pcp flushes on deallocation
Date: Wed, 19 Mar 2025 13:44:32 +0530
Message-ID: <20250319081432.18130-1-nikhil.dhama@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <871pw33695.fsf@DESKTOP-5N7EMDA>
References: <871pw33695.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: c906c7fb-1afa-4854-1ce0-08dd66be1db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oacccStbXeDy76IQoxTrcm7F94e19ZpTODMCaxbllnIDmimofeDI5kjAnAha?=
 =?us-ascii?Q?kge33Za6xU9l68lC3oWGzjNttPJh08tMuqTlThg3LHGqFAupJalTW3sShnUB?=
 =?us-ascii?Q?fcaHgP2A4zR4Ggjlc+YxFO+3jVOPyGHUVTL89clb8ipb92lIou9cFYuLfvBd?=
 =?us-ascii?Q?/aqiW+wcZqVz5GXZRcPvphHaN/mx4sUqBH4Pmqcno/+9tC4qDr8re6Kyrx+3?=
 =?us-ascii?Q?IOYWxPODLdnLYyZQezgLRhJgQL66+75P7MzdLB+NVlWpXgRVI9K7WwGgI6sC?=
 =?us-ascii?Q?yDy5+I5RrGkL1Jq9oanL+IKp1Dwij0wSZJAtZYRmyPl8KF9caX2J0pOWyMuq?=
 =?us-ascii?Q?8xsPg0nFT3EP3F+YnIQbLjKUsg2zpKr3ugz1WjK1oK4sMvsM+sgS7HSSXqHI?=
 =?us-ascii?Q?ZzFGsWTUEyYUDEyRwtvK4c4e7O1//yA8vVO/Lv/Jtf5Vx62vZ2Bqp4PUY8Ag?=
 =?us-ascii?Q?FxyElULfKrt87h1C3GD5iPL4Zd6EiBNE9d9T/0hYjd5BLnyOsnsDmD/vRW9x?=
 =?us-ascii?Q?1jPCSWjHz3l0wCuax4JVKJpHFwpfyuzZ8fe3lhnbMErNw1tjMqD5ykRjXw2d?=
 =?us-ascii?Q?fb0JHgKmLXiBgcqurrKMrR/jEcxhMEKzKT+Z0FPdNKrm3PLbp3USCOwycYNp?=
 =?us-ascii?Q?8M2YBmHn6FYd9yCv5yVGgebiuJYj6dMjls86eoqOzFImsrCv8mmjqyDdnaMT?=
 =?us-ascii?Q?jFLQt+kR4cYlnnHc8eyRG0QSYKX0dQpMLuCg8bkkZTh7CFhXOXKAYk5DwBzD?=
 =?us-ascii?Q?o3Y+fpMoA/GdAJGBS4id9rfMFHkxMTzqRcMJxabvEzk/16sOneE1gBK+j6CF?=
 =?us-ascii?Q?l6vR6wz88yIbw5nXB/HmJCIyVJuRCVIhTclUHjVP8JPukhfw8bqxs2crJb5S?=
 =?us-ascii?Q?5giXY/T1sAwX/mHp92SQVIFKTF9/Ncv7Aw6wYWvA8+Rktqt/TGCdIiCbkpBq?=
 =?us-ascii?Q?JGJbYnbEtzKoLfhxJqco8BKF+OZ7f5JTYaLwgkVVmvegE/GDhdxrvTx60uoE?=
 =?us-ascii?Q?ZYigMCOx+B+OliwE5sfgmbOa3YEEoPUsRVx4uQi7MEDodog+Vh5I7cgnKbXU?=
 =?us-ascii?Q?yU0rPTiWFMebKY4AgElfHIFvEL+lyenG+Z0eoueSI1oQ9RopE+pJIvLHsIKd?=
 =?us-ascii?Q?XP3W6AMW0BgST5Xs1kfWaPr13gbDw4ZDtVDveFQ3IVMRJqckhW/SyQZTFshL?=
 =?us-ascii?Q?ijVLFNzrx9BS8Xt9V+j2NJ0jD+a4DB1Cl0VznjjrWPHEPKZM6NfO3zrQT532?=
 =?us-ascii?Q?J+IFxE0u0CFtDXwrk0kV8fxl5NK+Age5VPYh+9xeQikAvYYgm5fwyPHciE4J?=
 =?us-ascii?Q?7kAC+7Y7oz0w2rItWxuUXZfX59+OCElOtYCx6UNcRye3E7H1OC8S4XJ4CEOl?=
 =?us-ascii?Q?Cv2//iThlikxodJROjJFtU0koHVIohiZxrt7iso930JE4ySXTNpFdepCxlun?=
 =?us-ascii?Q?KaUkLQrSX5DQmyKXHUpmAH0DCnV1gNuOCXHPro3z/StpCPF0IEnccXkbDbVJ?=
 =?us-ascii?Q?saWibsYsLfysJfU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 08:14:48.3169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c906c7fb-1afa-4854-1ce0-08dd66be1db3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842

On 2/12/2025 2:10 PM, Huang, Ying <ying.huang@linux.alibaba.com> wrote:
>
> Nikhil Dhama <nikhil.dhama@amd.com> writes:
>
>> On 1/29/2025 10:01 AM, Andrew Morton wrote:
>>> On Wed, 15 Jan 2025 19:19:02 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>>>
>>>> Andrew Morton <akpm@linux-foundation.org> writes:
>>>>
>>>>> On Tue, 7 Jan 2025 14:47:24 +0530 Nikhil Dhama <nikhil.dhama@amd.com> wrote:
>>>>>
>>>>>> In current PCP auto-tuning desgin, free_count was introduced to track
>>>>>> the consecutive page freeing with a counter, This counter is incremented
>>>>>> by the exact amount of pages that are freed, but reduced by half on
>>>>>> allocation. This is causing a 2-node iperf3 client to server's network
>>>>>> bandwidth to drop by 30% if we scale number of client-server pairs from 32
>>>>>> (where we achieved peak network bandwidth) to 64.
>>>>>>
>>>>>> To fix this issue, on allocation, reduce free_count by the exact number
>>>>>> of pages that are allocated instead of halving it.
>>>>> The present division by two appears to be somewhat randomly chosen.
>>>>> And as far as I can tell, this patch proposes replacing that with
>>>>> another somewhat random adjustment.
>>>>>
>>>>> What's the actual design here?  What are we attempting to do and why,
>>>>> and why is the proposed design superior to the present one?
>>>> Cc Mel for the original design.
>>>>
>>>> IIUC, pcp->free_count is used to identify the consecutive, pure, large
>>>> number of page freeing pattern.  For that pattern, larger batch will be
>>>> used to free pages from PCP to buddy to improve the performance.  Mixed
>>>> free/allocation pattern should not make pcp->free_count large, even if
>>>> the number of the pages freed is much larger than that of the pages
>>>> allocated in the long run.  So, pcp->free_count decreases rapidly for
>>>> the page allocation.
>>>>
>>>> Hi, Mel, please correct me if my understanding isn't correct.
>>>>
>>> hm, no Mel.
>>>
>>> Nikhil, please do continue to work on this - it seems that there will
>>> be a significant benefit to retuning this.
>>
>> Hi Andrew,
>>
>> I have analyzed the performance of different memory-sensitive workloads for these
>> two different ways to decrement pcp->free_count. I compared the score amongst
>> v6.6 mainline, v6.7 mainline and v6.7 with our patch.
>>
>> For all the benchmarks, I used a 2-socket AMD server with 382 logical CPUs.
>>
>> Results I got are as follows:
>> All scores are normalized with respect to v6.6 (base).
>>
>>
>> For all the benchmarks below (iperf3, lmbench3 unix, netperf, redis, gups, xsbench),
>> a higher score is better.
>>
>>                      iperf3    lmbench3 Unix       1-node netperf       2-node netperf
>>                                    (AF_UNIX)   (SCTP_STREAM_MANY)   (SCTP_STREAM_MANY)
>>                     -------   --------------   ------------------   ------------------
>> v6.6 (base)            100              100                  100                  100
>> v6.7                    69            113.2                   99                98.59
>> v6.7 with my patch     100            112.1                100.3               101.16
>>
>>
>>                    redis standard    redis core    redis L3 Heavy    Gups    xsbench
>>                    --------------    ----------    --------------    ----    -------
>> v6.6 (base)                  100           100              100      100        100
>> v6.7                       99.45        101.66            99.47      100      98.14
>> v6.7 with my patch         99.76        101.12            99.75      100      99.56
>>
>>
>> and for graph500, hashjoin, pagerank and Kbuild, a lower score is better.
>>
>>                       graph500     hashjoin      hashjoin    pagerank     Kbuild
>>                                 (THP always)   (THP never)
>>                      ---------  ------------   -----------   --------     ------
>> v6.6 (base)              100           100           100         100        100
>> v6.7                  101.08         101.3         101.9         100       98.8
>> v6.7 with my patch     99.73           100        101.66         100       99.6
>>
>> from these result I can conclude that this patch is performing better
>> or as good as base v6.7 on almost all of these workloads.
> Sorry, this change doesn't make sense to me.
>
> For example, if a large size process exits on a CPU, pcp->free_count
> will increase on this CPU.  This is good, because the process can free
> pages quicker during exiting with the larger batching.  However, after
> that, pcp->free_count may be kept large for a long duration unless a
> large number of page allocation (without large number of page freeing)
> are done on the CPU.  So, the page freeing parameter may be influenced
> by some unrelated workload for long time.  That doesn't sound good.
>
> In effect, the larger pcp->free_count will increase page freeing batch
> size.  That will improve the page freeing throughput but hurt page
> freeing latency.  Please check the page freeing latency too.  If larger
> batch number helps performance without regressions, just increase batch
> number directly instead of playing with pcp->free_count.

> And, do you run network related workloads on one machine?  If so, please
> try to run them on two machines instead, with clients and servers run on
> different machines.  At least, please use different sockets for clients
> and servers.  Because larger pcp->free_count will make it easier to
> trigger free_high heuristics.  If that is the case, please try to
> optimize free_high heuristics directly too.

I agree with Ying Huang, the above change is not the best possible fix for
the issue. On futher analysis I figured that root cause of the issue is
the frequent pcp high order flushes. During a 20sec iperf3 run
I observed on avg 5 pcp high order flushes in kernel v6.6, whereas, in
v6.7, I observed about 170 pcp high order flushes.
Tracing pcp->free_count, I figured with the patch v1 (patch I suggested 
earlier) free_count is going into negatives which reduces the number of 
times free_high heuristics is triggered hence reducing the high order
flushes.

As Ying Huang Suggested, it helps the performance on increasing the batch size
for free_high heuristics. I tried different scaling factors to find best
suitable batch value for free_high heuristics,


			score	# free_high
-----------		-----	-----------
v6.6 (base)		100	 	4
v6.12 (batch*1)		 69	      170
batch*2			 69	      150
batch*4			 74	      101
batch*5			100	       53
batch*6			100	       36
batch*8			100		3
  
scaling batch for free_high heuristics with a factor of 5 restores the 
performance. 

On AMD 2-node machine, score for other benchmarks with patch v2
are as follows:

                     iperf3    lmbench3            netperf         kbuild
                              (AF_UNIX)      (SCTP_STREAM_MANY)
                    -------   ---------      -----------------     ------
v6.6 (base)            100          100                  100          100
v6.12                   69          113                 98.5         98.8
v6.12 with patch v2    100        112.5                100.1         99.6 

for network workloads, clients and server are running on different
machines conneted via Mellanox Connect-7 NIC. 

number of free_high:
		     iperf3    lmbench3            netperf         kbuild
                              (AF_UNIX)      (SCTP_STREAM_MANY)
                    -------   ---------      -----------------     ------
v6.6 (base)              5          12                   6           2
v6.12                  170          11                  92           2
v6.12 with patch v2    	58          11                	34           2


Signed-off-by: Nikhil Dhama <nikhil.dhama@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ying Huang <huang.ying.caritas@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: Bharata B Rao <bharata@amd.com>
Cc: Raghavendra <raghavendra.kodsarathimmappa@amd.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b6958333054d..326d5fbae353 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2617,7 +2617,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	 * stops will be drained from vmstat refresh context.
 	 */
 	if (order && order <= PAGE_ALLOC_COSTLY_ORDER) {
-		free_high = (pcp->free_count >= batch &&
+		free_high = (pcp->free_count >= (batch*5) &&
 			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) &&
 			     (!(pcp->flags & PCPF_FREE_HIGH_BATCH) ||
 			      pcp->count >= READ_ONCE(batch)));
-- 
2.25.1



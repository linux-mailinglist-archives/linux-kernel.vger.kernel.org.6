Return-Path: <linux-kernel+bounces-397615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057709BDE12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CBC1C22D67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383D18FDAA;
	Wed,  6 Nov 2024 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jRK6WMcG"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309613541B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868593; cv=fail; b=Ohhk53bKKUbgDYsmIyBbCVvOeL9yZ0usDYdfdU9luecsm4yBDDI5Od9jaWMSsuMhIgpb15lX1rPQRbNjPWAb/HY5+y1TbWS7yI3CVNs1DKxu6JUwXn6yfriMfs8frBcmb9xqrD9Pu2qGba4gPtEOHgi438jlidPpbwcGrwPIVnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868593; c=relaxed/simple;
	bh=hQnQ5oBxT2qr2RqlqTUEuMcdjdXvIGho0ClvVsnRa1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RyPqYxm7JZjp3HVdcyBGOvn1qUj1x4hnwtL4prCZciZbvCMCI6/KXV6RNHi0E0r6g7/6hwOjb3Uk1rJ9GBxmq08z1QAIRlT1ABAR5Ie6XecTvcVZW8zUIy4AFDK3Giv+2Y8tRYWEuXe4T/rqfQFkJKHp/JFd1wbruCvvEJAV5Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jRK6WMcG; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wc6hUcbKH0/t65Dobs7ouzuXC5s9TrR6JglosfqT23+681bLVn4ONGRTolj80BsWHSKI3vFuCV1yG4SDO3ixA2yX36jah2biQwwMr/RYbOGkCYA1ruMYF7zisxh8OZCPDOhPDsJggOgssT2QvCB13Y2QYBQBDHbaXhx/WF+jtiqwwrUlCEGN5goSIoLeSfNilt78rHHfwNnp2azWhjNSUYPf8GWQgzDKR/DA2K+awfgkEmgkbud2bNBDoXzxkSZtzKJpSUD7K1PJLdfoltEZyORgwlvRP0se8QuzTwoiF3KgVIHJsabc3PuFvBvLecJZHCLRW0ylTg8XYRK9n0lVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMZLmuERallg/XGUfulgKV7mwo5l7ODvZ/oYJdveM0s=;
 b=Cu+dFTQg3HIWCPkwseYUBm3E9YcG1ZucqYHEZ3MMIe+k+oPlykUPnI++YytQdTTFATYHIGSqUcTUkPLrgCveQ0Ou6IoGYwqpOpOzwDvOUcxS9rt8TIeTW5FVUMq1lK8ETuBjBL2cpfICHWU/COgDGPHNAHuWIiG46hqlk4tveyT6dfluu1y0n0dIH8xSnLEUAOpEDH3yt3cmA9AKsGfRuO4YcbojSXJAl8ajx1KNJS4VrFlblF0wQrvXGGtJ+AVs/BwHC97qawCQAcKft5gnmIbiJ8RKF4423Cs0N07jddZww/gjrDmiunprGKFl5MJcP/4hm4m10kBn8RIBj2Ad3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hpe.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMZLmuERallg/XGUfulgKV7mwo5l7ODvZ/oYJdveM0s=;
 b=jRK6WMcGhEPc4LuRIGdc63j81q+aIDCuB7oJf8L7mLvfzAPUsdHVWMU/KJBVk2TXydpsAdLkmNbvA+q1IJfXr77nkzjJGNpUcAWQSKKi6MYJ/tsTbSKNGPvVkBYdoGfYlbkMAd3Lk/QL0plQalKlOgh6ilseVQD1bh4fUr8Wo9Y=
Received: from DM6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:40::21) by
 SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 04:49:47 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::46) by DM6PR03CA0008.outlook.office365.com
 (2603:10b6:5:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29 via Frontend
 Transport; Wed, 6 Nov 2024 04:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 04:49:46 +0000
Received: from [10.136.47.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 22:49:41 -0600
Message-ID: <19ae802e-fada-68ee-8a78-fbd61f85d7ed@amd.com>
Date: Wed, 6 Nov 2024 10:19:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] sched/topology: improve topology_span_sane speed
Content-Language: en-US
To: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Vishal Chourasia
	<vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>
CC: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
References: <20241031200431.182443-1-steve.wahl@hpe.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241031200431.182443-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: a17e5ae1-9c3b-435c-b082-08dcfe1e7048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXBMaDdLVW1jUXN5dkJhSlh1VC9CME1WT3J4NkZQMFBKK0pIekU3QnVVMlF6?=
 =?utf-8?B?K3d5cE5IaVlYRnhUc3ZyK1JOYThhQ0pQWG9BUnlvUS9UcFdYK1p5VVh0LzJi?=
 =?utf-8?B?L0l5MGNzTGprRTVXYllicWZpdTQ2Vzc3ejM1Yk5xc3BzcE9SSnVibUdaaHlr?=
 =?utf-8?B?Z1BpN2k3Z2ljdkwrSzFoLzZpcHlETnVsVFZ0SC9zaWU5T0pZbDhjYzNOV0lI?=
 =?utf-8?B?Y2toSUNLWnJ4eTRlc2tXVFFHY3ZnSGl0MmNYV2Q2TTVCL1ZlRXZrS1dRcXFP?=
 =?utf-8?B?R2w3cVZHRTMvd2lTNi9DRmtLb1NONUgwMS9BVmNaejFCYkx3bk5UN2Q3MDBI?=
 =?utf-8?B?dktyNXNSbTN6NnZramt3WjAxRjY2MVVNNm8vdTlDUzhlTzlXb2YrZXExZllW?=
 =?utf-8?B?VkVaeXJ6TERhcnhmRUZrY2dxSmQrVFVDVUkxakRmN1RIbllZSlp0MWxaeUVD?=
 =?utf-8?B?NEhsLzF3bktsSFhBUXk2UndVTjROYk54Z0hQWUZGeG5PK2E5Smovb25VVlRC?=
 =?utf-8?B?TVpsZWw3dWNERWFpTXM0RHE1SjhMcnE1TUZ4UTBNK1RyaUIzQVl5eklKeXhj?=
 =?utf-8?B?S0VxeGpIcWNLRGxCKzVuVkppN3JBYWNVckdpd21SdjZKME96VjJSWHJaemg0?=
 =?utf-8?B?K282SUNucHozU0dOaDNmd2lEdk5JNVVHZWpZaUxvR21hYjZjdlBISFNSczNK?=
 =?utf-8?B?b2NwU2NKVkNDeUs0NEFLc1ZmQzJiY0NwMFRtb1RsT2lXeFJyWi9uRHpJdlFu?=
 =?utf-8?B?MEJwN1VnaHg1c1RWUWNUU1I1WmJDMjhZVk5zcUc5eUFaRy9wWTNOSWVqSlU0?=
 =?utf-8?B?dXNjZC9NZ3J1cGUrUnlOc2pRNkRvY3N0Ynd4ZHBmQ0VNdi95TXpuSXF4R3ZL?=
 =?utf-8?B?UUt4Nm1DVUFuOTFkNnNjUjRGMGwrb1FySmhXajBSeERaekppbGNhWVJ3R1Ey?=
 =?utf-8?B?TTNYZDV2QmpvRitHMmtGVnNzcXJpSTgzRGYvRGppZHJ6K2hhS0VvNUJsdHVW?=
 =?utf-8?B?QXQ4bE9STHRTK3ZUSmVNSTY2TzM3MkhydU1XNGZGcThpOHYrbE1nZ2xJSGdn?=
 =?utf-8?B?aFRhcW16MkVyVFpUUCt2MHhDYllFTnJUR1hrdHlVTmtlNDl2MkwvaERsVjRM?=
 =?utf-8?B?SVFvcnpLTmdDbVVvaWRFeSs5RzIxWVJuU2xEVm4wdzBLMHdqaUxzTGVubkls?=
 =?utf-8?B?bmUyWkFNK04vTXlYczFhZjA3bFZ1bDBRZ0pDakVNUGwrUUppNW9wMWxlYUhx?=
 =?utf-8?B?K1plR3EwSk9jMzVWMnJ1YnVrMzN5ZjVySEVlb1FsZXFqSXp4bS80aldNa2ta?=
 =?utf-8?B?NmRISkxTd05EVVk1a2toWDBTUXY1UlBKVFNuK3pDM295SURaL2hHTjlrbjIr?=
 =?utf-8?B?VzIyQ1B4aW9BV2FxZlU5Szg2RlZXay9FM21IOGk1TVZjS3EyL0pvNHpRMk9K?=
 =?utf-8?B?dG9mRE00d0Q2NUZacHUvQkE3bC81WDNHWmNnc05FZ1FnRGlGZ3NEMVllSTdp?=
 =?utf-8?B?WURhMDdraUFvSDl6bU5QWHZtb2VNam9qZUxJU2tjekJOZGVRK2pwNWtNZmtQ?=
 =?utf-8?B?RTE2dTlnU2tpeThBcjhaUmJNdUtOV0E2YTFqUVhnc0ZXMDY5dzkyL1hCQXZX?=
 =?utf-8?B?S3RjMks1REZOU0VXZFoxRlRjRlNXRmZFb24xb1FhMDE5dnhWN0wwbWlsVHRx?=
 =?utf-8?B?MGZJdkh0UVp3YTFsdFk1dWsxRVo3aGx5ODZBRU5mQjRoL0tkOEM2aklzWnZr?=
 =?utf-8?B?bVh2a2dOQ0tQOXY1U0ZsTW80WjdGYzF5N01IS0xzSXdHM0R5dWNndHVBOXg4?=
 =?utf-8?B?MVhJbS94UFlZclRsZHFMQVdJMjNLam5ydlBFTWd1ZVlmdWNYOVV1Z3V3a2lo?=
 =?utf-8?B?UWNWaWRCZFU4dlJIVldVeUhmRkthdmVBTHFJNUZ6L241Yk9LWlhJWUdCc2N2?=
 =?utf-8?Q?1JeLrX5W7V4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 04:49:46.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17e5ae1-9c3b-435c-b082-08dcfe1e7048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125

Hello Steve,

On 11/1/2024 1:34 AM, Steve Wahl wrote:
> Use a different approach to topology_span_sane(), that checks for the
> same constraint of no partial overlaps for any two CPU sets for
> non-NUMA topology levels, but does so in a way that is O(N) rather
> than O(N^2).
> 
> Instead of comparing with all other masks to detect collisions, keep
> one mask that includes all CPUs seen so far and detect collisions with
> a single cpumask_intersects test.
> 
> If the current mask has no collisions with previously seen masks, it
> should be a new mask, which can be uniquely identified ("id") by the
> lowest bit set in this mask.  Mark that we've seen a mask with this
> id, and add the CPUs in this mask to the list of those seen.
> 
> If the current mask does collide with previously seen masks, it should
> be exactly equal to a mask seen before, identified once again by the
> lowest bit the current mask has set.  It's an error if we haven't seen
> a mask with that id, or if the current mask doesn't match the one we
> get by looking up that id.
> 
> Move the topology_span_sane() check out of the existing topology level
> loop, let it do its own looping to match the needs of this algorithm.
> 
> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> the average time to take one processor offline is reduced from 2.18
> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> 34m49.765s without this change, 16m10.038s with this change in place.)
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> 
> Version 2: Adopted suggestion by K Prateek Nayak that removes an array and
> simplifies the code, and eliminates the erroneous use of
> num_possible_cpus() that Peter Zijlstra noted.
> 
> Version 1 discussion:
>      https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/
> 
>   kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
>   1 file changed, 48 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..6a2a3e91d59e 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2356,35 +2356,58 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>   
>   /*
>    * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
> - * any two given CPUs at this (non-NUMA) topology level.
> + * any two given CPUs on non-NUMA topology levels.
>    */
> -static bool topology_span_sane(struct sched_domain_topology_level *tl,
> -			      const struct cpumask *cpu_map, int cpu)
> +static bool topology_span_sane(const struct cpumask *cpu_map)
>   {
> -	int i = cpu + 1;
> +	struct sched_domain_topology_level *tl;
> +	struct cpumask *covered, *id_seen;
> +	int cpu;
>   
> -	/* NUMA levels are allowed to overlap */
> -	if (tl->flags & SDTL_OVERLAP)
> -		return true;
> +	lockdep_assert_held(&sched_domains_mutex);
> +	covered = sched_domains_tmpmask;
> +	id_seen = sched_domains_tmpmask2;
> +
> +	for_each_sd_topology(tl) {
> +
> +		/* NUMA levels are allowed to overlap */
> +		if (tl->flags & SDTL_OVERLAP)
> +			continue;
> +
> +		cpumask_clear(covered);
> +		cpumask_clear(id_seen);
>   
> -	/*
> -	 * Non-NUMA levels cannot partially overlap - they must be either
> -	 * completely equal or completely disjoint. Otherwise we can end up
> -	 * breaking the sched_group lists - i.e. a later get_group() pass
> -	 * breaks the linking done for an earlier span.
> -	 */
> -	for_each_cpu_from(i, cpu_map) {
>   		/*
> -		 * We should 'and' all those masks with 'cpu_map' to exactly
> -		 * match the topology we're about to build, but that can only
> -		 * remove CPUs, which only lessens our ability to detect
> -		 * overlaps
> +		 * Non-NUMA levels cannot partially overlap - they must be either
> +		 * completely equal or completely disjoint. Otherwise we can end up
> +		 * breaking the sched_group lists - i.e. a later get_group() pass
> +		 * breaks the linking done for an earlier span.
>   		 */
> -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> -			return false;
> +		for_each_cpu(cpu, cpu_map) {
> +			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
> +			int id;
> +
> +			/* lowest bit set in this mask is used as a unique id */
> +			id = cpumask_first(tl_cpu_mask);
> +
> +			/* if this mask doesn't collide with what we've already seen */
> +			if (!cpumask_intersects(tl_cpu_mask, covered)) {
> +				/* Really odd case when cpu != id, likely not sane */
> +				if ((cpu != id) && !cpumask_equal(tl_cpu_mask, tl->mask(id)))

I was wondering, since we are doing a "for_each_cpu(cpu, cpu_map)",
wouldn't we always see the "id" cpu first since "id" is nothing but the
first CPU of the topology level mask? Maybe I'm not thinking creatively
enough but I cannot see a scenario where the sanity check will trip
here and not in the "else if" clause down below :)

I've done some basic testing on my system on all NPS modes and also
with "numa=fake" cmdline and I do not see any splats in my case. Please
feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

I'll try to hack the kernel to trip the topology check, with and without
the patch, and also try to get back with some hotplug perf numbers but
for the time being I do not see any false negatives with the approach on
my dual socket 3rd Generation EPYC system (2 x 64C/128T)

-- 
Thanks and Regards,
Prateek

> +					return false;
> +				if (cpumask_test_and_set_cpu(id, id_seen))
> +					return false;
> +				cpumask_or(covered, tl_cpu_mask, covered);
> +			} else if ((!cpumask_test_cpu(id, id_seen)) ||
> +				    !cpumask_equal(tl->mask(id), tl_cpu_mask)) {
> +				/*
> +				 * a collision with covered should have exactly matched
> +				 * a previously seen mask with the same id
> +				 */
> +				return false;
> +			}
> +		}
>   	}
> -
>   	return true;
>   }
>   
> @@ -2417,9 +2440,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>   		sd = NULL;
>   		for_each_sd_topology(tl) {
>   
> -			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> -				goto error;
> -
>   			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
>   
>   			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
> @@ -2433,6 +2453,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>   		}
>   	}
>   
> +	if (WARN_ON(!topology_span_sane(cpu_map)))
> +		goto error;
> +
>   	/* Build the groups for the domains */
>   	for_each_cpu(i, cpu_map) {
>   		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {



Return-Path: <linux-kernel+bounces-365527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9199E3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8032846B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984411E490B;
	Tue, 15 Oct 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IJwEAxfs"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D4C1E1C33
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987662; cv=fail; b=uyDVMXgse4mXS9Hw4tGNRCvSpNM1D7xx3Ujq96uOahY5sByEbUoTdRpH55BCeGvfwP6MDpoyvVnsLDh2vNg4YVPj4sLNfZ9pPfgBXaafykhIBCREcb1tdnW+iwD/MXfISXGkIXKio6nMvZmTPelp57Kf7IJQD/7zB5h11RlRfss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987662; c=relaxed/simple;
	bh=45Hb0cR7qDYKU2nsS+c4Teyn4w7jEoxjJgPyB/BFXXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZU4pZm8480kmHERNqI0njp4pCqtTsAZzm6n0tsu4rXR0Qm1TtrS++zyfvwKzeCpLiWdFk4gxmOslYTHqAxEcbv9vGeW2s9n7lv7Q+DQ7Edb3kB5o6k+4+cvqFGjHuxU2cA/0rnE35XejDX6j/bxOMNx5aULYQ/o1VUdF/iXRNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IJwEAxfs; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIlRc+EBTRXgdLwZTXzGS/xDNimt2eD7fhXQEdHTu7zoHPd9ABj9oCV6l+AJV/3m9TdgxULNqcutxaVh1koLiqegai45A1P2xyAyGybzL7+LAZ8d6326xLkPZ7ULggo0/do08q7yorVFzmJVXTUyniF8hqIFLQLttwA95nbrM6gvpohrwayq3oZSfIN39l9/4OCnuTJ94TCeNW72dDHHARQ8yq1zgmKONdvghWlUDUQ1sLg7XXXeAmZKKzmgUPytC5GtATG/FbiX83j7Q4EMqZj/pn0jZfGNiUZv/low+H1l/o1w731Pn3OTWnfpha0Zu8KUJBEnL9IGrIZaemtCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LqU+MDH+2N779Fl/8M51VUWZ36TcDMWuAHj1RJ7zkY=;
 b=gVCGb1TBqgNiFgB5ZOCU9fwyQyV3vs5DMTHKu+rhsYqpVnY2Ai/gFT/mg4r6S5Y7JBa6uN/nOeWFJyhgUUwSR+05nzUmiJmDlmAMTklecC5a2X8iCF/44ymr4XVV1bRiuSkZ3QxxsiDiv27MiQF40yDpNQosa/Ks4lteukmlGMAc4/Ei/n/gd2q55Rp2dkWh5lygqgHJSaTHaTI7kejrV74pfsG67gMPGRnXntiKFnBdif/PmlZY/Bw366OBfzr6hcAt9Tp6yPepH+bDR+irrrzZXwCGfxBOnxJWTSDuRsRCjxFqVCESx+Ie2SUpKta36QwScoV7k2QQUHqOYHLtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hpe.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LqU+MDH+2N779Fl/8M51VUWZ36TcDMWuAHj1RJ7zkY=;
 b=IJwEAxfsH1J6jgfHf+1ehUx9kavpycuBJXBHDuQIw+5ubmeoC0cMYyqYwt8At2phMdI9N14/heNYCUJCyDD8sBaMwQAwj5QnjnfpFbrhKlRksExEyIIO+ePtXLqf0se1zQQB2B/a5yVcUYxUmISW2iS+uyEdeNmlTAYqWamZ1iI=
Received: from BN9PR03CA0472.namprd03.prod.outlook.com (2603:10b6:408:139::27)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:20:56 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::db) by BN9PR03CA0472.outlook.office365.com
 (2603:10b6:408:139::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 10:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:20:56 +0000
Received: from [10.136.43.96] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 05:20:52 -0500
Message-ID: <60473622-e6f9-561b-a269-9da64add4966@amd.com>
Date: Tue, 15 Oct 2024 15:50:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Content-Language: en-US
To: Steve Wahl <steve.wahl@hpe.com>
CC: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241010155111.230674-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: a9065f9b-bc5e-4de1-c584-08dced030e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUZsUmxXQ2ZTM2xSZ1lZUXJZdTdSOGRWVitYRncvVUQyUy9IMVFBNHNiSWI2?=
 =?utf-8?B?WHp5WXMrek9SSzNOTXhpODRnSXRnN2dCN016c0R0QW9VbC9BdGdGNk5ab1dm?=
 =?utf-8?B?eHJ3SEYwcmFNeGlxZ0tKT25BUGdrT0x5UzJMaGtRQkZhTk9wcDU4UGZpR2Q1?=
 =?utf-8?B?ZEhFQ3dIZjVVeFFPZERKMys1VTdHUGY2Y0oxTDdndTJ0RHhBK0NtWlZNY3J3?=
 =?utf-8?B?T3lOMFExU0pTU2ZJUyt5ZEdRNjYwUy96di9SeE5BdWtvMkEyRnNRNlQ3eTcr?=
 =?utf-8?B?cVk2dW03VFdtZkhGUHFWM2Q5Qm5SRlBvZklXWnVIZDZrSm82aTdzUnd6QUdT?=
 =?utf-8?B?aVROa0NQRms0QWlwb2x5aFRRVHNCL2QrMUtWNHdRNDlER1ZUS1FDZEp3U0Q3?=
 =?utf-8?B?NjBqb2xXM0VISngyU25CV1Z1ODIvTG1relNLRnZ0Vk9LM0lkenFVYTVKK3pV?=
 =?utf-8?B?UVNDZFJ2VUgrNHc5TUV5b0VEQWNrZ1o1N2hteHlEdTRmaVUyeXNXVDNMTVg5?=
 =?utf-8?B?eDBHKy8wakRqZURhTnN2VmdlRXFYMjlFTEhFK0VEbjZhcE9JOThEOFZmQmNi?=
 =?utf-8?B?akhoWkhpRUN4V3U3Z1ZrR042djRWVU90ZE5XdjB1SGNTZ3lVNGFuc1Y2dkZ0?=
 =?utf-8?B?WmFYMVEyVUUzUTdWU0pVQ1hHdENZdE5tVEF3blIzZzcvRktyVDAxR0I5V2Qr?=
 =?utf-8?B?dkMzVnJRUnZJQzk3L1FiOGVSdStwbDBMTnlyVjIyYzBEVnNXekF5RHhwdk52?=
 =?utf-8?B?czI1K0tORm9MbnBpOFBOWDlFcUhVQ1FCdWVKZUtkVmdiR3cxTEZpVlpHZzFs?=
 =?utf-8?B?aVh6WGlHdzN1OUNoZ2lsTG9iM01QQ3g4RVVvZHZpbmZOWUdRbWdQUVdTeVlv?=
 =?utf-8?B?SlVCVlNTa1NKRTgvdFk5bVRHOGhIR1o1VDUwejZUckVlRUh2OE1wbU12V2xs?=
 =?utf-8?B?SUwyNGNvWkVyK1hBRU8ydDd6b1NvMVhlcldiNDAwQ1RpV3p3c2h6ZndjY3dB?=
 =?utf-8?B?V2taNVBlM1pwMnVTYnluM21ZbkFxbXRPYWZEZFVEZzRYR0ZHTVBGNGFPZUUv?=
 =?utf-8?B?Q3paM2tmckRYVklGYlh6Wm9pdHplSHhXT3V1WTViV3VvQ004MFRTdGczMVBj?=
 =?utf-8?B?OGR5T3pmOTlNMTFmZEsyaGwzUFYrdVE1WEYzdXNsSnhlT1d5S21FcTRLRXYr?=
 =?utf-8?B?SHYyRHRleWhDQmg0ak82ckEyYUJFajQzVzBpT0pPVU1QOWxIZkxvTnlJSFlR?=
 =?utf-8?B?cVQ5cGRZa3NhakJJWHZDOWk3MFU5a2FEV3k5MW9CRzdxQTRRMTB0VklLS1BB?=
 =?utf-8?B?K1UwSUNNek5jMFRvU25PS0tmQzdrQkI5Z2dzbTBpalg1dDVML04yWjJPYWZG?=
 =?utf-8?B?YlU0VnRqdnVTVnpac2FubDBvblpTVnpveXVWd3JFKzFyUUJKYlU3TTlONkhn?=
 =?utf-8?B?S0FFaW81S0p6VmxTVWNiWmNOQkpYb0UreFlERWErYjM3ZjVJZkxHd1llMjdP?=
 =?utf-8?B?NmNic2tSdjJNS25uWEtOaVl1KzA3cGJ4azFkbGpORVpFMXZSaXdZMUJoYmZw?=
 =?utf-8?B?S0IwU0MxSnJvcnVvVEdUc093M3A1bDk3WTFoVWZOME9yY2RPc2V2RjNxbVRP?=
 =?utf-8?B?cXk4YUIwMzJJUGZobFhCV1poNkpsYnVYOExIS0VCZXU4eFNjR0xGS0pWWmZW?=
 =?utf-8?B?L0hGV0lLZ0pDK1BYeCtTcldoK2pUZUd3WU4wOTlENit2M1kwckhpdFdjamJa?=
 =?utf-8?B?T3dYUTk2YjNpRHpLOElwNnhDRzA4OHQwNnJEKzFpZWZQVWhST2xpc2ovSzd0?=
 =?utf-8?B?S0JqZ0l1Q0h1MGlyOHd6aS94bXNFU2NobFRtWHk2U0FTdXBLem93UEpGSjR1?=
 =?utf-8?Q?jalVil0tJi8E2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:20:56.2754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9065f9b-bc5e-4de1-c584-08dced030e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522

Hello Steve,

On 10/10/2024 9:21 PM, Steve Wahl wrote:
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
> should be a new mask, which can be uniquely identified by the lowest
> bit set in this mask.  Keep a pointer to this mask for future
> reference (in an array indexed by the lowest bit set), and add the
> CPUs in this mask to the list of those seen.
> 
> If the current mask does collide with previously seen masks, it should
> be exactly equal to a mask seen before, looked up in the same array
> indexed by the lowest bit set in the mask, a single comparison.
> 
> Move the topology_span_sane() check out of the existing topology level
> loop, let it use its own loop so that the array allocation can be done
> only once, shared across levels.
> 
> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> the average time to take one processor offline is reduced from 2.18
> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> 34m49.765s without this change, 16m10.038s with this change in place.)
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>   kernel/sched/topology.c | 79 ++++++++++++++++++++++++++++-------------
>   1 file changed, 54 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..c150074033d3 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2356,36 +2356,65 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
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
> +	const struct cpumask **masks;
> +	struct cpumask *covered;
> +	int cpu, id;
> +	bool ret = false;
>   
> -	/* NUMA levels are allowed to overlap */
> -	if (tl->flags & SDTL_OVERLAP)
> -		return true;
> +	lockdep_assert_held(&sched_domains_mutex);
> +	covered = sched_domains_tmpmask;
> +
> +	masks = kmalloc_array(num_possible_cpus(), sizeof(struct cpumask *), GFP_KERNEL);
> +	if (!masks)
> +		return ret;

That looks like a very large array that seems unnecessary. Instead, is
it possible to use "tl->mask(id)" down blow to check for equality? (I'll
elaborate more below)

> +
> +	for_each_sd_topology(tl) {
> +
> +		/* NUMA levels are allowed to overlap */
> +		if (tl->flags & SDTL_OVERLAP)
> +			continue;
> +
> +		cpumask_clear(covered);
> +		memset(masks, 0, num_possible_cpus() * sizeof(struct cpumask *));
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
> +			/* lowest bit set in this mask is used as a unique id */
> +			id = cpumask_first(tl->mask(cpu));

nit. "id" can be declared in this scope since it is not used anywhere
outside. Also perhaps you can store "tl->mask(cpu)" instead of calling
the function multiple times below. Thoughts?

> +
> +			/* if this mask doesn't collide with what we've already seen */
> +			if (!cpumask_intersects(tl->mask(cpu), covered)) {
> +				/* this failing would be an error in this algorithm */
> +				if (WARN_ON(masks[id]))
> +					goto notsane;
> +
> +				/* record the mask we saw for this id */
> +				masks[id] = tl->mask(cpu);
> +				cpumask_or(covered, tl->mask(cpu), covered);
> +			} else if ((!masks[id]) || !cpumask_equal(masks[id], tl->mask(cpu))) {

Elaborating the above point, instead of caching cpumask in an array with:

	masks[id] = tl->mask(cpu);

how about, having a single "struct cpumask *id_seen" that is cleared at
the same time as "covered" cpumask, and a bit corresponding to every
"id" seen is set. If there is an intersection, and this bit against the
"id" seen is not set or if the "tl->mask(cpu)" is not same as
"tl->mask(id)", one can detect if the range is overlapping. This
requires much less space compared to an array of cpumasks but I'm not
sure how much more expensive it is to access "tl->mask(id)" compared
to reading it from the array of cpumasks.

-- 
Thanks and Regards,
Prateek

> +				/*
> +				 * a collision with covered should have exactly matched
> +				 * a previously seen mask with the same id
> +				 */
> +				goto notsane;
> +			}
> +		}
>   	}
> +	ret = true;
>   
> -	return true;
> + notsane:
> +	kfree(masks);
> +	return ret;
>   }
>   
>   /*
> @@ -2417,9 +2446,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>   		sd = NULL;
>   		for_each_sd_topology(tl) {
>   
> -			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> -				goto error;
> -
>   			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
>   
>   			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
> @@ -2433,6 +2459,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>   		}
>   	}
>   
> +	if (WARN_ON(!topology_span_sane(cpu_map)))
> +		goto error;
> +
>   	/* Build the groups for the domains */
>   	for_each_cpu(i, cpu_map) {
>   		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {


Return-Path: <linux-kernel+bounces-561311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05017A60FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B28A173CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80201FAC25;
	Fri, 14 Mar 2025 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="NFYxmnNB"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2075.outbound.protection.outlook.com [40.107.255.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E41519B0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951943; cv=fail; b=FYnBHPARM1W5qtwRSM9s1UsdoRGWBxropsapwfC39H3+EVppu+a/Z/uGo9dWTSuzedarXo3na2fpBgJjXNhrlCr9QmcMCVnA/XLdP4JQVETNao0sUqob8/tX2/Oq+HDZJ9tzoqLVw10bycJMqcUaDLi5FOi6kaqA5nRUfr8OARA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951943; c=relaxed/simple;
	bh=OIMuPzsKdvMFQL6yqms0MNYcAYmj5WuhVkzxHgQls0I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCZeUukkJPvYEA9h9ZZJF/qUoMlCMfrG529KHJTon4jpR7k5MViv6/tJh/ylvlu0c8P75spppQNR/9/2tZEMl6+wxHLcbFWDKWXOyWnkrg3QK/xi3UOoszOxBmzZtq84De5CY7geg6ZfhLlFkrY5YV1ecy2+WJSl5J6gcXPMdr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=NFYxmnNB; arc=fail smtp.client-ip=40.107.255.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CldaikPpVCk22oOqeIDmsOD9DToerCyU62ntSCGyl30ZL0I+r0U8VwYxlAx/V7TOMomaYIBbdUI9R/Rd26mEHppQKOG+A9seKZ2VSrja3oRGCByhHq/qqWyBVOSBiD13ITofEJBtC+7m1DJkFwLRtSL6TiyDM9aA0i1f+Vgel0dcRX37iIwN8/uAsqAobEt240bvBDeG3vQ1yFxuROfTDeELBSiyuYJN547WVt2sGqhwe6p3VwDdIN0URnW2il/VV0hcDSK905VWQdTBs/mdOW+gIY35J5f2ddRc99EViUnFXPXr4N786bI+QFsbGaOHtDHx6k1KQH+NLCjce65VhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHMZmsHtHEyPryQbAb7cHERH06sU+TSzrvYzxFgU0g8=;
 b=QeV5QkH48E6jAzZPnrHPFK3L302SphO9HU3BYHbRo4TUwaLsqXlfvfWpZxc+rN48K1ZeuZDuHyUrCqe1VInji7PmnkXDP+pMkVcaLapyWOhO8ffRC5cRrfJrWioFOalbLfya5nQgwUXXPzpFx1FkLtlHdxGRbPoFICGAXGKBouZ96R8y0eEy5b55yQ6vzGvfSZXGGH4CAdGz5ob7UtUaZ95l/PqOBxpMczP5jlfF6VekISdU3dZ8JI3WCuCW3QvdMO8rUI06P4Dy45tZg1qXDirjU9ct0jFQcauUIKwWTqyCbB6I5r+y+xWQC6dSFZtSjmFGMMSjnefvAuL68WGx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=bytedance.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHMZmsHtHEyPryQbAb7cHERH06sU+TSzrvYzxFgU0g8=;
 b=NFYxmnNBCFN0t/a9D+8WwwPCasey8WY6+Yn/Y7A0kF3h11k4eHP0dA/NCxGIc5vwk51neK2o8hHK+kr+9qLe3wnMckFgXCYM7BGIQ4PXhuE8z0vnQnE6MJ8IqvY/X/IzrlzXBRqar/AA+2dKKMaL67R/zGln/UCl0tZFtDQKfRo=
Received: from SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) by SEZPR02MB6279.apcprd02.prod.outlook.com
 (2603:1096:101:e4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 11:32:16 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:40:cafe::7b) by SG2PR01CA0132.outlook.office365.com
 (2603:1096:4:40::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Fri,
 14 Mar 2025 11:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 11:32:16 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 19:32:15 +0800
Date: Fri, 14 Mar 2025 19:32:10 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <hannes@cmpxchg.org>,
	<muchun.song@linux.dev>, <yosry.ahmed@linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
Message-ID: <20250314113210.2z36hilxwfbnl4ms@oppo.com>
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|SEZPR02MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0d3163-9eb9-4c86-94bc-08dd62ebdf9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ByAbImgIu7TxWf5wKFWSXe4T2HMZsLRp/J3I1ZhkbNiLZCXl/ICS9sgI09PB?=
 =?us-ascii?Q?xbKaYqcOSWQz+Q8ygBM7ez6HyVbMVX17xKkIXqp/iOSwNk85KLbECVeewUzv?=
 =?us-ascii?Q?rKt6SC4q8DSUmZwjIqdzTcZV81oym/q4tDXNb7jH1n/9rp90yMNg58WlJg4v?=
 =?us-ascii?Q?C4UwddWj2g5c3Uh9QZvVO/PHBgoh9UHwikDKGJOkxPPtViUFIuvDLkKyeDYw?=
 =?us-ascii?Q?73AxsIcVGI21eL+xMrC1zA/t8UKebPPM9+7sscDT8VUwUtafUCblOWI1bEwi?=
 =?us-ascii?Q?WTiSbYj0NmCWciPhkO1aulXYzPjNUQSEdJ8dn8ly+Mb2Dij/hhYdelKc5pMC?=
 =?us-ascii?Q?VZKDW2zaC9HJUKbn2zhfIXN9b0jkWr5IXCfshqm10thgPmjXGseQp1GWjDW4?=
 =?us-ascii?Q?/9S1O0egUes2pKdwGDph0U5Xw2ORJ98G5+vsaHFVrbA/ETsMzz5CeX1/4m5o?=
 =?us-ascii?Q?dHGvKl/vyS3zuH0IpsGQw04WHdDBDtptvOsw8phyq1YGf5EPOl4nzIz6GcFS?=
 =?us-ascii?Q?kficnObhdezRfLOCvLZLXp0DX8oViH6aLqgFAqemtrPZ7/ShjXVUB/8d+tvq?=
 =?us-ascii?Q?kxn5tjapGHcn78lXAjm8xEbqwtt57ThrYe30jItYpNELhA2jaFmoRLo5EWAR?=
 =?us-ascii?Q?1eFQJ4N/7pB840BqnG2+4T1hU2T/yXGSI4SY5PllLSXVn6q2VpsytJ3DQrwd?=
 =?us-ascii?Q?qS0tEwD9QC1pwGvErn1EETsnXwj8LhpMorTJksS3Ov7BLC3HLaTXXSGWNg/R?=
 =?us-ascii?Q?IZhr6v7wYXRxPTzSbt15tbxY3G902fMKXNoU/qaaBzbNoYjRtoIR+VU7fr0a?=
 =?us-ascii?Q?z7LD+BNUzIl3jueLnBcszgU9DA+wdQVfwidbmtOaHO1szsTU9wQgNltOLNyT?=
 =?us-ascii?Q?fPnEVSiSUeAyK9lWp0HD/aLmHPMYajSyC5/HvBhwniNsMalcNIV96HiI6DTl?=
 =?us-ascii?Q?+6lPV1VKs/tp7VT408k9hBrmY5hZIhYm0ziYm0V/ghQMg0RnNiid7lOKM7M9?=
 =?us-ascii?Q?V+vlDjPt1VnScBT+qrzVPYd9QTfJgd4jS02PhzmcL25pBMhGIFZNeWPNhQQg?=
 =?us-ascii?Q?WDJFL7oYREKceXZiGdtxYk084+dIbZTAlBu7owfZAbajUg53eh5V1u1ds5Wy?=
 =?us-ascii?Q?+cWCGYPxU6uU212rZW1h3LMZBse0kQuPrJ2kSNWfhq1YuVvn995KjuRDgJ6S?=
 =?us-ascii?Q?AUPXEW8iKFZl5gcShlrfpNUoM3QkQ8yBaFnUxo3xAV2stAQJLY0juAnQfJbY?=
 =?us-ascii?Q?X4uJVDNHRvg7tFxDB4c6+2V4rZ60bYbCdpJKX/AIkk+u1HJkJZVGMlzktKcw?=
 =?us-ascii?Q?xl2BQbE9H4L96ozx2IrAJ6IhsCh5zy0jIci6ot6NtwbZskssdwOlzI3jEgDE?=
 =?us-ascii?Q?T0dMIGuCd3CHqXuLr21/EQdAVXAk8mfLKwuX5xBDla/w0o3N3Eku94Xkljs7?=
 =?us-ascii?Q?uy9MfFYgdIo=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:32:16.3776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0d3163-9eb9-4c86-94bc-08dd62ebdf9e
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6279

On Fri, 14. Mar 11:33, Zhongkun He wrote:
> With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> memory.reclaim")', we can submit an additional swappiness=<val> argument
> to memory.reclaim. It is very useful because we can dynamically adjust
> the reclamation ratio based on the anonymous folios and file folios of
> each cgroup. For example,when swappiness is set to 0, we only reclaim
> from file folios.
>
> However,we have also encountered a new issue: when swappiness is set to
> the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> to the knob of cache_trim_mode, which depends solely on the ratio of
> inactive folios, regardless of whether there are a large number of cold
> folios in anonymous folio list.
>
> So, we hope to add a new control logic where proactive memory reclaim only
> reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS.
> For example, something like this:
>
> echo "2M swappiness=200" > /sys/fs/cgroup/memory.reclaim
>
> will perform reclaim on the rootcg with a swappiness setting of 200 (max
> swappiness) regardless of the file folios. Users have a more comprehensive
> view of the application's memory distribution because there are many
> metrics available. For example, if we find that a certain cgroup has a
> large number of inactive anon folios, we can reclaim only those and skip
> file folios, because with the zram/zswap, the IO tradeoff that
> cache_trim_mode is making doesn't hold - file refaults will cause IO,
> whereas anon decompression will not.
>
> With this patch, the swappiness argument of memory.reclaim has a more
> precise semantics: 0 means reclaiming only from file pages, while 200
> means reclaiming just from anonymous pages.
>
> V1:
>   Update Documentation/admin-guide/cgroup-v2.rst --from Andrew Morton
>   Add more descriptions in the comment.   --from Johannes Weiner
>
> V2:
>   Add reviewed from Yosry Ahmed.
>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  4 ++++
>  mm/vmscan.c                             | 10 ++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index cb1b4e759b7e..6a4487ead7e0 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1343,6 +1343,10 @@ The following nested keys are defined.
>  	same semantics as vm.swappiness applied to memcg reclaim with
>  	all the existing limitations and potential future extensions.
>
> +	The swappiness have the range [0, 200], 0 means reclaiming only
> +	from file folios, 200 (MAX_SWAPPINESS) means reclaiming just from
> +	anonymous folios.
> +
mglru ?
https://elixir.bootlin.com/linux/v6.13-rc1/source/mm/vmscan.c#L4533
>    memory.peak
>  	A read-write single value file which exists on non-root cgroups.
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c767d71c43d7..f4312b41e0e0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2438,6 +2438,16 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  		goto out;
>  	}
>
> +	/*
> +	 * Do not bother scanning file folios if the memory reclaim
> +	 * invoked by userspace through memory.reclaim and the
> +	 * swappiness is MAX_SWAPPINESS.
> +	 */
> +	if (sc->proactive && (swappiness == MAX_SWAPPINESS)) {
> +		scan_balance = SCAN_ANON;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Do not apply any pressure balancing cleverness when the
>  	 * system is close to OOM, scan both anon and file equally
> --
> 2.39.5
>
>

--

Help you, Help me,
Hailong.


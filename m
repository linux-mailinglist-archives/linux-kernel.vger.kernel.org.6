Return-Path: <linux-kernel+bounces-561986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D4A619DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0DE19C3328
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9CC2046BB;
	Fri, 14 Mar 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nCCVdflV"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC71FF601
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978451; cv=fail; b=HghS5J2WIX2+/l1NuVMrfvr+Zt6ExZ+9l8vj7HmR5hX6auAAiKvcnclBi4sRsI0mxctfj4DytSvj0ZV9Xk1STIJdg5cmr3CvFw86JOEvLYQpp77hUyYKzbtjgGU02UwPdLB7xOsT7TIxU0r4SUFMf6dIBB9mjTOOiT44K1fub0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978451; c=relaxed/simple;
	bh=vLQV6DJNro8Nf8RsU+UT4eb590Tz0xfVeGmhBPQR4A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cthnsA2AU1l/QQDThheDsigGS8YRSpHEp6Resi+0PaAVoNEbQoENXIfb4BjX6AATDWyVEIQZnUkkX9MoJN0bMkEXyuVuGGI/rT6467dAjv02zqJU/6trpMhNh5OKgR4qlELzenALZ2T1e6/MacjQwEwdfZCCnE9EsmcK+zDkA18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nCCVdflV; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWQT2LAC1+iOeIZWxiX7wFjX0Dj7uFlk3ycaHCifL/UkU+Ufxnqg7MSEr0pkKOibEh1ukAh7dItMFtl23Mrjgr4DGeLerV7hRw7fmb9s+oBMHcRlDzKIZu0YjAuoC0eToJqRtsAbn4z3MaEsvemlbV9tbpXfu7Lj7fQbSsQb8AtzZbDHeP7yHRtdIV1kM+E14ETQkz6RZoK3pCgsjAQtxalI9gIvnBTqD/1GSGP2VmxNeMdV27QHNaMHCQYyd4KtgJO6RhYBzjvPOXV0jq734csVQ9/VY/xP4SqZDFA3DObvjpQzPcrLCN5+smQPAuXpPI2ktTgEIJc2r3OdzWboIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVO7VsRHYgXa/iayMjpvwprp3A9eAzMhTyDSxfayYhs=;
 b=qnqeYqLf/WbtEfxbJH++DcZsS8xaKQf17Wd/L96uWwkQp5gTGzGGvAKAdqvqz/EsyebElRvbDY4J+sWtFxLjEMFfxSZ23iSKj9H8tjPG/PvuI0yXOz2T3VIbM39kHsSWiUaQm7sCm2cKhxNmlx2Q6GYuc+AA+hizyMl7nC9VQgk1R9tKeHj+jK5fdg7Ym4JA21gYCEh6j60EkxP7EW+vyj3OlvHkB2aPIzMo1MUs2colGX3b3qEZcSqBV6duDWA8wdCPNmcwDCcq72lbIsvbnLioHlTfEYYMnnDOfdtSdmsCgoFLpn9iaHtV7h66Ip/1qwnzOCOM705s+aypWWczqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVO7VsRHYgXa/iayMjpvwprp3A9eAzMhTyDSxfayYhs=;
 b=nCCVdflVWaTH9XBit6kc+rAp6T9v4nP8QpazfEYVbmqiZGVLfOH/yyRyIBvwCDxrhv+1W3YFl8tyoo6qjbHftfI+0vCpNTyQxm2K4Z5crgZKaIkQOuuSyIgf+mabIlk4nvmy7E35wEqjFkXlK4A+xssqwzlzeyba1gfGbafrnfgDykvLMkHpV2Pg/gGIYkk7HpLwOykGtmdz31oKsAU/hlaukUo8sEV7O2oiNa6tZhgr4qvNrq78MxWrwLC4OpY9LFR/5PG7tZBZE18nlOEagNPidSuA2yBjFN5L/e079A1lTngH88/Kqns4pXLoYodn0qzWvtj5X4DxsC9uoXrsVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.28; Fri, 14 Mar 2025 18:54:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 18:54:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: page_alloc: defrag_mode
Date: Fri, 14 Mar 2025 14:54:03 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <E0358860-624D-4C9F-84E8-4887EE4DD8D4@nvidia.com>
In-Reply-To: <20250313210647.1314586-4-hannes@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-4-hannes@cmpxchg.org>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e1486e-a965-44be-58a1-08dd63299905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKVxw/CeM3+HAVzML6yCYzH4PsQcQrBCsyCO45TD0+/Dcd2pmMHBgDy2NWTk?=
 =?us-ascii?Q?Gg50t+Hu6Ge/Ogni4WZi0xuvrKaLDb/3DjRT3x8Dde+5LJufMAb5vOyE6LFD?=
 =?us-ascii?Q?eQS8Ssbc53tfioqtUhoZqCOuL3TTmpaAmRI1MfMbGchl1zgbIasTh26tmHvu?=
 =?us-ascii?Q?3ztc9DT2N2R/VLKIclHNzRkJwx10HFXMFhheJe60AAARK0vgKLMq4KOk1ZVE?=
 =?us-ascii?Q?E/B4wrsKC583xMmZpR3Xh47IkE6uB/6XzMx0NFNeQ7rFytY1AlYZs2cnW0+8?=
 =?us-ascii?Q?Q2NLeOlCwCoOG0UmGATgxro2ai/JykmuLkJqH4Jeq3n+Fzt0HhqMcj9mv2I1?=
 =?us-ascii?Q?Q5P22sc2dOKmaNfgeLinq6wp5X1/7ESEHtxGVwRVk0GmaK/ZRGY1twLfqHrI?=
 =?us-ascii?Q?6jZT/wPX9CSjFdw8ifPIwvo98/yqBIVqlkuBo9EBQz5UZHURSa7HorW1Ay4g?=
 =?us-ascii?Q?DsOQXct6bq9Qf+MyRQMZ4QrwKyQJPMaMuCriIALgJZm4KMZ7jVd2K+DK58SO?=
 =?us-ascii?Q?MBMcGIdeqNWwk8Guu36pFqK3fodDyjnNKJa1DHK6NIOIVVRppblbyLv6Bqrr?=
 =?us-ascii?Q?uEoFN/RMxdlYqOacCH9rojzWIv7wt6GiLQ5arUZuTW78DaqMJOXcargr6/ft?=
 =?us-ascii?Q?y8dfaMNMGabKt2XpOikjz1ayEi+HOWGftaV1mwM/hkg/KumD3NiNag4Twp9C?=
 =?us-ascii?Q?rEAx0GU8YEqKdhUA7ny/xi2rJ7wIGuwjDQNEiADKB2qxnyDUrSLtNKXaiHhF?=
 =?us-ascii?Q?rm6GYDx6rhyllihxjOqLkfpmliIL8pgkZUtc/g51Y2kh04CPcToGcW+c1Xk+?=
 =?us-ascii?Q?NdI+mc6rG9UX/gNWxfCv8pwG6QeUWzO0MFe9l9Ep6wnhI7Gz3Jx+mya/4J8G?=
 =?us-ascii?Q?ym6nHr5K4xTKNiXqT3UtWPhHcyiyLwz/byXaoF6zes34Fx+J8HOQzBLBjZyH?=
 =?us-ascii?Q?uDJOYpR4b9mvxPPjosp8XYCbqRxcJpb24CCUVtnaCNwQsoCLjTOQZomzRlsl?=
 =?us-ascii?Q?VSAXGZNThshkfH5gYi5O1m2iFcqxME6F7y5NQg4TulkKVBSbV2BB7JN4FHpb?=
 =?us-ascii?Q?XC9OFe783/h3/yLUS/a6zIFiQ4YS5sVuAuaAHf9me22sh8KcNx1x7o0fD8XQ?=
 =?us-ascii?Q?zMjsJ00ktHYY0YiIsRXpExa3u+lnhQc6JGE9lK1NpnesjA82sGRDWcsc3Qky?=
 =?us-ascii?Q?+OxPUAbvg+HR6SwnO0T9hevPvEeDdQg8kLN3/LSeBrzEEx/CFqdXO7b0mtSd?=
 =?us-ascii?Q?uhtAG4Ge2xZTJl3K7YTiO21nz1Vt+FnCJliBRpp7R1Ztr5F9+KPEleCjChpK?=
 =?us-ascii?Q?rB/HRjI4r4WaT+u7klVPLNY7/pjt0Ctcm/XFL8xZJ9Cg+n75x7bF/A5lHkqT?=
 =?us-ascii?Q?JzFxGf2mirNo4k6nc/IjPyjkJ52m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Am4o57N8PsYQ86RcNYs5JOEpnbGlOTKbEHAgyut18fTj7pW5Z4gBUY/Dc8ws?=
 =?us-ascii?Q?VxzaBchO5ILXeoC8+f+mg3FdlMyRAxwCcal8f1OYhaAtU0OtWKiNE5Rx5ZZr?=
 =?us-ascii?Q?++sXlmsxSgVBHVr7gl6xuNbBWB8Hco1RTIi7axsmR7v50/cV721TAyc0uuDg?=
 =?us-ascii?Q?3TkoFJhStVoelJJf6GaimH2vAcLd8I13pbZwH+kmqbsHGped/ORjFhsG7P8T?=
 =?us-ascii?Q?QGMKSDqRQfw7EoYCIulyF519ROJOwaPktBftGFfE3Iu6ThxW8aHcN4rdTdWE?=
 =?us-ascii?Q?d3Xj0uoFv1OAnJCkY9fayAW2i+6eswzZh++6ZNMb2jcpwCoyL+DoDhzzCHQC?=
 =?us-ascii?Q?z4TVb2tPL1ehDM2dR9OygoQU+1JZCt3qnHfefypLSvI+OMpJdBUKM3w01HWu?=
 =?us-ascii?Q?xaRnmfsbD1GTawGrt8KDMo5hkmub0YxiWgdhK628ghHkE80vLuBhmT5ZqtbD?=
 =?us-ascii?Q?0QprkeYcG9L6TMLPPqNy6PZ938HnkSUz3tYFGn6A7fvO9hmQyqLQXE2EOy58?=
 =?us-ascii?Q?E48eESCacRV5R8ppwyGhTp7Cc1UnmgdO5gIGBWu3nJbPnbXhcbaVvZZoFIfB?=
 =?us-ascii?Q?YUw67yCymAm2X+pYHJuXkAwNsO4UabQMYZD1Sd+DBum/r+oHE1X2WTRgtOoZ?=
 =?us-ascii?Q?SlJ44DQXbaWtU13vuKAcCf9ahLFn9Gx6fiDv2+jBALjIllQcGNvxQUnHJtTg?=
 =?us-ascii?Q?dEh6iv2zNHtfon1yNMiux2lGk88oyQi/9V6iFWNkmmpj6mL6mdY+JUCdvcIK?=
 =?us-ascii?Q?1ysbdrK57cfOLgJEdleNUQkI3wuaG+dHmDBVNgOib2CE4jEsE8St47uU3Jjm?=
 =?us-ascii?Q?Zu5FqF7OyYRmJjDq0YiBAiw3FOqQeKbz3rfQA+FXPFcsrJH1FRvI8QCWxHgX?=
 =?us-ascii?Q?uJr6XdAKVVtX+4Z5Sajm/IEbEHGFfE0JaRHpN9Ti6n/PF3ZjDDsgKkyUEGZQ?=
 =?us-ascii?Q?SxKb6l8FMpZ1kGZLah61ml82DF1m+ovRPn1SPTK4A89zcpykrN6quAV1I2hw?=
 =?us-ascii?Q?WLkALfntrStVOeb0gzjMRJUF1qbL4sMqtSOMSud5TrBQxAo4Dqh3u5Rb9Y6I?=
 =?us-ascii?Q?7lJrO2wkjFvRDFKMJ1EzBLbU5idXs5731W8dAXsWGcny3i8r5FCh5t9Ebyb1?=
 =?us-ascii?Q?wLRhp5aWon1LszmbRy/yRe5C786ksZ/KtIHjcmb6+K4YBcuuCsGzhxuEZFxX?=
 =?us-ascii?Q?N8s6R1BX6TiRiVgVlLWyOywE7cyuDBE3LFbKSQtLqs6q7TZRcm5TOSehTX5P?=
 =?us-ascii?Q?Yc3ehBhUDsV9+qNv0MxJcC4H6G8Z1s808zsmu1whCdi8SNfb8mRR99sPUJNt?=
 =?us-ascii?Q?uY/kK2YUGXIqSeKu7FkhlqZ7/RnkH3Y6/oZpKY8mjz2JGDK1Ee5xBLNHZmvr?=
 =?us-ascii?Q?Z7ep4qBRXy8x+UgD7VwEqYt0PK4oymMzmNUaPKwPuby9p7vlMvsFTalJX1a7?=
 =?us-ascii?Q?kfs/IDrCoYlno/doK7Y4POSh0xgHsdwog+XV8qs3j25/JX8XDIsmbQzMG7zZ?=
 =?us-ascii?Q?UrqV0z/gCXx2CHV1856lDuCTs1O9XCri0JlSSqzbrfYtabBwTZIp/wmJqRLx?=
 =?us-ascii?Q?VJMv1V9OxQgWQmJXuLfXi0NvKBC1y+/cBuC2DZF9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e1486e-a965-44be-58a1-08dd63299905
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 18:54:06.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGIp0ERXHKgicgkur2GY7xEFBtEBnOynVqpkgyuAeXIiYBoEpXikPBWd+Plp2jyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

On 13 Mar 2025, at 17:05, Johannes Weiner wrote:

> The page allocator groups requests by migratetype to stave off
> fragmentation. However, in practice this is routinely defeated by the
> fact that it gives up *before* invoking reclaim and compaction - which
> may well produce suitable pages. As a result, fragmentation of
> physical memory is a common ongoing process in many load scenarios.
>
> Fragmentation deteriorates compaction's ability to produce huge
> pages. Depending on the lifetime of the fragmenting allocations, those
> effects can be long-lasting or even permanent, requiring drastic
> measures like forcible idle states or even reboots as the only
> reliable ways to recover the address space for THP production.
>
> In a kernel build test with supplemental THP pressure, the THP
> allocation rate steadily declines over 15 runs:
>
>     thp_fault_alloc
>     61988
>     56474
>     57258
>     50187
>     52388
>     55409
>     52925
>     47648
>     43669
>     40621
>     36077
>     41721
>     36685
>     34641
>     33215
>
> This is a hurdle in adopting THP in any environment where hosts are
> shared between multiple overlapping workloads (cloud environments),
> and rarely experience true idle periods. To make THP a reliable and
> predictable optimization, there needs to be a stronger guarantee to
> avoid such fragmentation.
>
> Introduce defrag_mode. When enabled, reclaim/compaction is invoked to
> its full extent *before* falling back. Specifically, ALLOC_NOFRAGMENT
> is enforced on the allocator fastpath and the reclaiming slowpath.
>
> For now, fallbacks are permitted to avert OOMs. There is a plan to add
> defrag_mode=2 to prefer OOMs over fragmentation, but this requires
> additional prep work in compaction and the reserve management to make
> it ready for all possible allocation contexts.
>
> The following test results are from a kernel build with periodic
> bursts of THP allocations, over 15 runs:
>
>                                         vanilla    defrag_mode=1
> @claimer[unmovable]:                        189              103
> @claimer[movable]:                           92              103
> @claimer[reclaimable]:                      207               61
> @pollute[unmovable from movable]:            25                0
> @pollute[unmovable from reclaimable]:        28                0
> @pollute[movable from unmovable]:         38835                0
> @pollute[movable from reclaimable]:      147136                0
> @pollute[reclaimable from unmovable]:       178                0
> @pollute[reclaimable from movable]:          33                0
> @steal[unmovable from movable]:              11                0
> @steal[unmovable from reclaimable]:           5                0
> @steal[reclaimable from unmovable]:         107                0
> @steal[reclaimable from movable]:            90                0
> @steal[movable from reclaimable]:           354                0
> @steal[movable from unmovable]:             130                0
>
> Both types of polluting fallbacks are eliminated in this workload.
>
> Interestingly, whole block conversions are reduced as well. This is
> because once a block is claimed for a type, its empty space remains
> available for future allocations, instead of being padded with
> fallbacks; this allows the native type to group up instead of
> spreading out to new blocks. The assumption in the allocator has been
> that pollution from movable allocations is less harmful than from
> other types, since they can be reclaimed or migrated out should the
> space be needed. However, since fallbacks occur *before*
> reclaim/compaction is invoked, movable pollution will still cause
> non-movable allocations to spread out and claim more blocks.
>
> Without fragmentation, THP rates hold steady with defrag_mode=1:
>
>     thp_fault_alloc
>     32478
>     20725
>     45045
>     32130
>     14018
>     21711
>     40791
>     29134
>     34458
>     45381
>     28305
>     17265
>     22584
>     28454
>     30850
>
> While the downward trend is eliminated, the keen reader will of course
> notice that the baseline rate is much smaller than the vanilla
> kernel's to begin with. This is due to deficiencies in how reclaim and
> compaction are currently driven: ALLOC_NOFRAGMENT increases the extent
> to which smaller allocations are competing with THPs for pageblocks,
> while making no effort themselves to reclaim or compact beyond their
> own request size. This effect already exists with the current usage of
> ALLOC_NOFRAGMENT, but is amplified by defrag_mode insisting on whole
> block stealing much more strongly.
>
> Subsequent patches will address defrag_mode reclaim strategy to raise
> the THP success baseline above the vanilla kernel.

All makes sense to me. But is there a better name than defrag_mode?
It sounds very similar to /sys/kernel/mm/transparent_hugepage/defrag.
Or it actually means the THP defrag mode?

>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/admin-guide/sysctl/vm.rst |  9 +++++++++
>  mm/page_alloc.c                         | 27 +++++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>

When I am checking ALLOC_NOFRAGMENT, I find that in get_page_from_freelist(),
ALLOC_NOFRAGMENT is removed when allocation goes into a remote node. I wonder
if this could reduce the anti-fragmentation effort for NUMA systems. Basically,
falling back to a remote node for allocation would fragment the remote node,
even the remote node is trying hard to not fragment itself. Have you tested
on a NUMA system?

Thanks.

Best Regards,
Yan, Zi


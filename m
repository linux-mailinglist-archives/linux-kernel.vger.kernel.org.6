Return-Path: <linux-kernel+bounces-561974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA26EA61992
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0033AD7D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45F1F3BAE;
	Fri, 14 Mar 2025 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tj0Xakmu"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24A2E3389
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977397; cv=fail; b=cDtt+upMFnftSIB+F30hI6d+efiNhafXS6aD4pWoIJrwcKzRKxUdIt66c+/WT+uQNsXGU33/Is+haMrMkbjB4U2PDDvJADanGlRfUGFhQY4GucFt/rVfCVrpIcS5be69qoR7rp0Hh5ckeJvsjGHtETkh3CVP269PfDzl6CU3Qx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977397; c=relaxed/simple;
	bh=TLAXvLcoB21lG2HvpU8B7gBerQMhDpU76P5JQJXzoUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PB5PkfQcjGBLUlurOMUi5jr6CkE4THO4+ZaxaFu8qQJDdXQuFCBh7qGlJg8EgaGHCNVvLZ5VEN5/H4OZcsg5Bb0F6S8BkRam5MN2YM0E4LtKuOWeliOdvSQEZZUatcv9gc/L/s664vtEjKkwOCp/NLlsniLCwBw4iMZIjHWt5y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tj0Xakmu; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPEnS01qpJaWrihFjepgjgjyoKbxfXGAoYHM+pfKwA56PZQXHDo0yxupHn6YCWa5yVTZcH23Xup9SOgQqwoZTS38BqEg91HfOkwHKOtQ2UFw8R3wKJrxVWLDlqVS44Gj0zXeI+MSgFfcuUAN51uayOXSyWy2JUOlo/5blATk/kQCcalH2p5JJq1YNk7iNv/JfuvR0SJeKKQeIL031fLZoUUVbDm7bu8PVVWqirF2/5iylnWFOMpPaCF+kVg4Ffu2ucU1agwqymkKMEts/EzbU7DGOT78diF6oFngNwVN19CSoXyf5uLxBydYvdgP4KbPjQRqA1Ab2Nhehhz0ItALKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jXdL+pwVN2aQmsvhyqR6De++YyjAF/nWdD4A/Y8/eo=;
 b=rvkvflvuuk90WzXrYBTrgaWz1f5wq+rwFPMgF5ARntLnQfh/5KxD8PWBeKvMfIk+0tEzZJABhlp1q7OCFC1YCZehB5XgCCLjHxqneJOzAwG37R6gSaWiQBFyaWOtS5iKu7CS6Ak9nHs/6iTkRRUvqBsnFddAi8ea1ROjjV2QIC0nTjjchB3n/qT3l3J1EVKGHlWxi7o44UqXcPn64QJGgO9p1hKZrNj5/TS9LvGROKxx+0t7ZvlxFHKEF9OSl883N43vPmSW4BqH8V46sQCxzxKxVNsLuhu0b5sjkfNDVouWlnxq94GWEF2zc+fgGDallLIsq3QofpRw+/EmysNL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jXdL+pwVN2aQmsvhyqR6De++YyjAF/nWdD4A/Y8/eo=;
 b=tj0XakmuFCzIxAJf8/Nx+uerwcMRSa4c+UIbikJNCGvZ97dRxQXLFYx7h5twaC3IDTO8jfFmeKjHrTvQcS5ohz4Egga8IAkQmkxiFqJYK38XjUB2q/s9nInC4ZBTbEBUayMl+Qy7XBbGnU6+0TezG10SvN5XJ60AK/Lv27r045PsHPIsqIOfkUnz+1rAwecTdWIT3LL4I54nI7uGbKSZBZZc+w1atk2DWaSylCxqSitO6wZ3NvDiLtZpv0FPoNujhjBli3fYviQWev38tcJth54CPZ5hT/nVOkDmzVdQRutt01FUhXHP5/LCMcHGW3qXjuOp6W+92K182V/+6RJDYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 18:36:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 18:36:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: page_alloc: trace type pollution from compaction
 capturing
Date: Fri, 14 Mar 2025 14:36:28 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <9AFC1858-947B-46A7-A332-EEBCA456670F@nvidia.com>
In-Reply-To: <20250313210647.1314586-3-hannes@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-3-hannes@cmpxchg.org>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:a03:333::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc4e268-887b-4cd0-0381-08dd6327246d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7lWhjyHX3b/kx3QZxogaxGePRuVL7KX/cBxBBg2KdEDD7D3+UCEVEjGUo1s6?=
 =?us-ascii?Q?AdRhk+2T7guSMdqB813Q+H7XgjVcHS5nNgumV9hfjjp8DpLd8aNmGO1R6B4e?=
 =?us-ascii?Q?VUa4+dlHfLx+EZQnmcYIBoKZyrNCLiefKoQr3t3NQxg7Lyc4xtsOKgznIEhx?=
 =?us-ascii?Q?40Z7sKgKU2ILOgBqsUgr4OQAQQoV4qcRosXea6TQs2haPx+w22XfJxzqAxOj?=
 =?us-ascii?Q?bDiWBbUuCS9LcsYM3+evtrL0PdnisXRRmOkRaMl1Amm2RTMgkBQoT578A2RH?=
 =?us-ascii?Q?xf3VCsJmIyOn1e8O9bqsX8Bz4YKzTCW/atFoFb5Zz5fZfv8gnfMahzZMFAlW?=
 =?us-ascii?Q?h1NmU4JPwWaG4Wt2454UHrAcpk75K1acghAc3MFIKZRGVCUOSL23W/KqBsUi?=
 =?us-ascii?Q?xyPW/+e5KqIHF7zketmGE9iMT0E51xkZ6kWCsmS3PZuQKhQxZzg7UHnla6tQ?=
 =?us-ascii?Q?1TrLHo7+mIWUcYvLPndkPutm+/FONimrwXJGjz2S+n3VXwIZ5p0LIJX/AcA+?=
 =?us-ascii?Q?uHLFKQWb+bKzL2KLlanDrrZN6zGnZLMHIIhmrT3R1TQsV04KXsdtu9xWS7wA?=
 =?us-ascii?Q?9KPdBp48a4lQdyewYQOv6scgO2W60bfjQQX21fKMXqGmPZ6VxhWBOgrt1oI8?=
 =?us-ascii?Q?JoMzVLv8CgKm4Rh6Hh6oR6jzGG3qd/xWYAzoyJlNfCsa3qQumbXkDH409cnj?=
 =?us-ascii?Q?I+wSUIHP4c23OOCrpbgvLIMflvKPZi32BZ40zWSozCmIBIFF6qBIBo7rDkJf?=
 =?us-ascii?Q?dWrIKvDWx9cM6cyGkjUBIACQyRV4kUS0bGMZCEV3FxgYLwtwei1wd6biaFOx?=
 =?us-ascii?Q?nk4oRcqoUktF+H8OJAsuixsEcnxkdAnzvHq1rVmAXCePn3+SLHDLukETCS0F?=
 =?us-ascii?Q?ym1WiDadBlckzXzROOelV3ej+Ybenc76DGfOQXP+kNCexu5POIWpKhbq8jIM?=
 =?us-ascii?Q?M0gUv+5bP1WgOUXZxluqFduQVG40647eijainwqpfgz3S0rJODoCbyoUS01m?=
 =?us-ascii?Q?/E7DTrFJ6VgQ5Js8Ip4kIawIutVJbMdmjtCdJpZL0t6S51WNP8DEhUvPZGEc?=
 =?us-ascii?Q?pfsdZgS81McgCGsV6CPiQvLJg2g2MnMTe483ykiGSydZUoZPlMrHyrcIhbaS?=
 =?us-ascii?Q?YIYagyiOidwgLjJXYa3b0aqi7dpG9JP66C4+ywnlQTUvWWHknFbGMaT0zBbD?=
 =?us-ascii?Q?S/3NIcIQpOJPfOhPaVM3OX3VdCqub1bvDi+APsy7iT1o4c9qgUoxj/qeD/r1?=
 =?us-ascii?Q?5436RjNOzRYvgbKk8aicnLdfeWX1t/SGLh5MSxOqhUTeJleTswr+/LX1vhKQ?=
 =?us-ascii?Q?a3jZQC+ZxcfYuCM98piSz9aAsAgrgVyjdGPtXsqz0NTONbGCrvIvtxWmKaLT?=
 =?us-ascii?Q?0xIwvfd3CzzRywIxz8SV/K/H6htM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MjTxkgIp9exV/BGNvf1PLfoeyE4bxHRyjEbVUxqAbYLv/X8lxwawu4Vl9L0V?=
 =?us-ascii?Q?GnUe9MYhYJK0c5bYn4y3s2reBNdSVRIKUE4rrAxTp1UFb+YIHZnmQZTKFnTl?=
 =?us-ascii?Q?GaKmu/RZ4jpw3vdmNp5z1Ce5UmTfr0AuTBCxwSejPuSKJjKUVrHW4tYrffa1?=
 =?us-ascii?Q?U8govgTumIo6SMyLgEAVmIgdYhYZ+IrDqv/NEs3ESEGo5O3urmAy7Su5SQXM?=
 =?us-ascii?Q?JDCxaenvf6dBLB/erKZB8+5NTx0C855+J3o+T7YqKxZs3QWgavd1t59LXJxA?=
 =?us-ascii?Q?9bfdXKLvvK9qmQydOAMdhYq6kFnaDsHlU3/E99poQHRpXjn9ILyCKO7IDUjE?=
 =?us-ascii?Q?8kPf6M6WO2zDIxcow1GAKwB5GGqR6/GQxcWixkcBaHSYDob/awtf4EUhKDa0?=
 =?us-ascii?Q?7BUUtPoKmmptxfMQTbQ30LSI1X80kUiJjgRC2xO/8wfb/r8rUCC9RMyuTiT9?=
 =?us-ascii?Q?IYb1flMeu8DunibcEJl9dzSHavXkSH0sO/sTDAj+Y7O5SmIxJKeBpyRC/KJH?=
 =?us-ascii?Q?2qbOB8J1w5PD+Mj8dDx86De4CbZia5iL/4mrTt4tY6u88j3zMm3oSbtXef8b?=
 =?us-ascii?Q?+QgroR5Eaf2zmoM8XVk0sPEE6/NNSbSSxsVi4FlAub718NJl1D+peclWOqHf?=
 =?us-ascii?Q?9WHxr3NpiHyYJjhV4oqajGeMFyakO18NjRhEJRsAbnq0CuEx60lOadmCfqVI?=
 =?us-ascii?Q?cvfWDQQmjOTmCqE66XJ8stv7fvfTv5k2GfysBDdAyScJ1i+lPG1IvLjXAlyv?=
 =?us-ascii?Q?muxVgHvCwZtnZDbnF4GgQ9RIpvaAgeiKm9Jy4dgvzTwP6QzDGThGaxc18uJN?=
 =?us-ascii?Q?FhLyFqMa5TWDYNl7GfYDgouVrWB/vn8q1yVN6dRYmPmOsbxWCZLP67sxdcX0?=
 =?us-ascii?Q?PuhcX8Z13ItB7oi+Gmm4Cs+6G9nDjIUGZshvEXjF+iqA0kxkzcCSeJaXJsmk?=
 =?us-ascii?Q?poOoaaW1Za5nX+pj16gS//IC9db/klkAiFcuZubQm6pAm1jyMyTVG7HnXekz?=
 =?us-ascii?Q?LV67Lcbr3CLBn2TRYpgE3afzDaNRYuoIMaC7CYdGvfGNc27o17JVeLatnOfg?=
 =?us-ascii?Q?JAJWXWrNcqJEG5DHHsd/oy8p3rohF/cVrJ3DQJgsyuWlAnZoFGSK02THBHN0?=
 =?us-ascii?Q?XLeiuzdbgERx/1L3B8nq4OFdROQb5MAieg0ilEi/L49tRFv5BxqesZPS6cZc?=
 =?us-ascii?Q?H5h4TGUvfJ8UJ2vob+4k09r/nWFNo75c6V1t6RpAINc3rYGAbN+21ZUG1I53?=
 =?us-ascii?Q?hN/icelTbkJ5iWNSsyYdutuwx3JT70lUk6doMxhZw56EdqqZvDYGhdcI38jo?=
 =?us-ascii?Q?4DOdR6qb46Ovqa808Ax7ytJ1M8nnAbp2t+ygA7wfyfu99KKOrp9WT2/brSHP?=
 =?us-ascii?Q?LEcb2EcKdtYOFpgFUlR/yCSXRa8mZMJjgYnTb4Sah6HrrmoFWFdedAqWzurQ?=
 =?us-ascii?Q?MInQCXxuwzTa65DhLInvhm4waVHE8WTxZerNE6ut0fu4LmckLNHDskdfJgXD?=
 =?us-ascii?Q?UMiuh/OxXj7+kI666IpbGd9Iis+Be2tqLxSEO/DtX/prdagGXRsxRlA+d3gZ?=
 =?us-ascii?Q?X51D+WJOhvjQRdcitVk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc4e268-887b-4cd0-0381-08dd6327246d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 18:36:32.3335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk4f3jTFG+gnC2kfWD73EplZbUZhu4FX87j30ZDrlZGKUtAB1sARF3NjySrROm1+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522

On 13 Mar 2025, at 17:05, Johannes Weiner wrote:

> When the page allocator places pages of a certain migratetype into
> blocks of another type, it has lasting effects on the ability to
> compact and defragment down the line. For improving placement and
> compaction, visibility into such events is crucial.
>
> The most common case, allocator fallbacks, is already annotated, but
> compaction capturing is also allowed to grab pages of a different
> type. Extend the tracepoint to cover this case.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi


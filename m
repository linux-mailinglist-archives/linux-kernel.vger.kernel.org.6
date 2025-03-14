Return-Path: <linux-kernel+bounces-561647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B19A61484
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F61F17F808
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2620103A;
	Fri, 14 Mar 2025 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZAFobDpq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148C28DB3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964939; cv=fail; b=nG6pfCOhPrV2BtZA1PSZpsLfIj+wBDphDZhI+0oA+L86Uiyxy0JCKzBmR7MWI33udz5l06QZrAnUCJaU0AQqveSueoBs7P3nDuVae17dK63qzFhBwalOxHOJm42OIQxqXFLxx4cLOyTjFrHjNK8qG9yoL50OwPx8a3bu5lVaYMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964939; c=relaxed/simple;
	bh=/yLOde2LvRyZuqRyE+Gn5lIhdvVl0kAPqPt4wvyPgFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PyWxPBgRp0Zt5iOr22EuEfB1KdLFq4L2/YXP0vSvVOAYOTSC8WfvMXkVwL9LdkusJ/xp7xJlYd1g1V6DKmgw1HjT/cZMhSg1BkwnExcQu/+d+4optum4VLbhSr5zCip76oPD5M79b0scwRPtJxqWrKTcciG/T0UqpRWduIlZbFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZAFobDpq; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5lBt77goTg7m2+tAXVOO1R1q8unOTQahqo8OA5pHPxy8AmBtTTo6hOYz6Jk1+jy36UCmcN6HGdH0GXQQdi2HZngAhD8LdJDq2yOnIhD4lqRAVtD23CJs7cyMMk23emlfc7YX/jzcwMeZG8UrifHfgJysV1f5Q21q6hOWLSn+VdiliLJpJl8XTTp8p8QhF8W5f7ZDRASIXUYhaNvayZMmny17ElBfDW4RAdsNXzcqhfIVKDy4tdR8tpmRSgXyfj8e/eiwqErz8mRzhsAaHfqOzmG4Gvdgrs5xVlU9e3izO2m99ZQLUg2kIL8eGRxBmo/zc4Nh+a825lqSnJ0BTM8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYsmTHHAGSeJAGb+bjsdcsQUOFIK/LEL/cdltOn6VVo=;
 b=Y9TzJOChXeeTH93hxNfPSmevRM2xzhAXkAHqb6PRfg2ww6VU/e0YXH7VHGfsJ2LgUuVm0QiuQWwbFdnyG9bjT9k/QL7nfVdvkD4xEWGzBfiyGx1eFOlTgo6Fvkby9dJ0yY1zpMYnp+iZG9QM9t4rUAl5PRBu+ikKGM8GcErmT/+TkjLAuVGRqPl1fFc/JLi62jx/0QmVsro5/aF1nk4hELG8XnYnPvmCAb0RgLnThC/hSbstmYMJdb/3MDSdubmCr+7Nozrk+tU6SYGXxe6onslm+wQrKB6Wz/jhw7eS9ssSy8EXrdYy5qkeNGWujSayKluVQ5Z4qKouHRLE/xmFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYsmTHHAGSeJAGb+bjsdcsQUOFIK/LEL/cdltOn6VVo=;
 b=ZAFobDpq0EQODHe9PY5TYp4bU/QyUzETRJxfMKbJCfYb+HENM9/UnH0QxF2ziasMY/3YccWrStFXD321mtwil85CwTEhGP7T76aP0G610MmWof+6j6qDW8fbolvV+y9UndQzaygRgMmY0cW8MfuTFp+VH3CzRkkZ8EGk0741MEy1dumGUL2sZ8rWEGw9v94IgYvfFtg1DOmFK8mqjxLL5ArEyF9sgK1UN4joEEJf/DIi9zYUq/pFMSuLgGvDTu1trgXlcsETW8FcaBQb9Mpvr+gqqtr9VYur/gj5HWZjFd3zQtMgqRlcTzF9DrccM+OmvSoZIYfh9gk1UlRE0GdO9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.29; Fri, 14 Mar 2025 15:08:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 15:08:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: compaction: push watermark into
 compaction_suitable() callers
Date: Fri, 14 Mar 2025 11:08:48 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <467D1D90-000F-47F1-BA76-B5539EB727CE@nvidia.com>
In-Reply-To: <20250313210647.1314586-2-hannes@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-2-hannes@cmpxchg.org>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e803cf-37b0-47b6-4da3-08dd630a22bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YEaGX4bjPEeuvwgiJQjqFxTSaqP2B7qWyYRcC99dkNKWaIQveNelgYixNlos?=
 =?us-ascii?Q?PJmvTsOwC7fEc2cf9pAA6rnwcMnCtSUloh/grsPXoi3j0kKHAfP057Ifnrfv?=
 =?us-ascii?Q?ebuvQKcQp/KqrdBug2IPxq/+XSJV/OYJI3kaqbmWbQvnCzYqsvN/bRZKHMnl?=
 =?us-ascii?Q?N6F+YZK9b4X2uNVX2lzUrbdcarErZgwhYGzNm9yK7fkqOEfuKT9hahwKx2lW?=
 =?us-ascii?Q?MSFcvQ7m00Kqd5TKfamWq3bBuHuF1nvpWGrdGhbAqiue5Enb4a38454xkfqr?=
 =?us-ascii?Q?gdw7cscoMCrAUmnw+IYmJNOeWVKSFxZ1pDobYTYpwCSVvkqf6D8acGOsDKk5?=
 =?us-ascii?Q?1h1OyXyECr5ILeU5xsCNvNQmQRBuBmFqmdHPhp9D8xlSxtRf5gwYBTZ78XX/?=
 =?us-ascii?Q?2AMZDciM9nz2IQMAdPCgbBu4OEtc5y3GMJYBmM+ibwm0TOfIoEi6P6WMLw79?=
 =?us-ascii?Q?Hl+6y0vleRwpZe3OnmBocNjLzlDdRW+Mq238QXtdFcUeFK/4Ld2EoWqsZn3w?=
 =?us-ascii?Q?AsZG21t2EAbi26jMPBAo3f1N23R/0v7bJoKfdnUsjTyuSfw8d4Er7Wmr72tD?=
 =?us-ascii?Q?Y+27VDkW8IQ5OrE24Y9eGf4sO4SKMvn5A2djl4un4RQvlp6eZ11unW5DnUqd?=
 =?us-ascii?Q?Fep6Jc1513343xjKyqi+/qbUrErWR1SKkYDoVsNC+LVekK5vjRvxMpdJONT3?=
 =?us-ascii?Q?o1ya/Y9q/US7aq9MCo1jPWTK2DxsPlTrMISUs62CYoiNpfRdiAtyCA9xq5Rt?=
 =?us-ascii?Q?kasYJ4fAjKi6smx+IgEeuEe4lgeYj7UfTMC7uqG00UjO/f5Yotrgsze+/SFP?=
 =?us-ascii?Q?HytUzk2Gay+5oO5C4zZR413Qof7ouz3TB/mi4nnDIsKfAAjVjZxWlh/9uKZD?=
 =?us-ascii?Q?3aacvFRFnOBLgaW3WvWPBV4TxEXojpgXTov1X/EZStL3a2f5OdCQXlvsf9Y7?=
 =?us-ascii?Q?dnYT6szKN8LaxQihvkH9lkXAclKegcQwEawamwjS0C7blS6l54VOVBC00T2p?=
 =?us-ascii?Q?kuKtHZZrlnVhsGi7zkyNKcgfdeH32vHUUCNZC+wIP4XyQViEmE1nGcIE6hWw?=
 =?us-ascii?Q?lY1/87tbE/joErsQdciYc+zSIZjWRb/N3MOniEkqh1nhW94U5P0ihL7mPeld?=
 =?us-ascii?Q?uQNVDqefAHP8JEfHYkXPnfzY+p5PQJXxkmMaw3IE8sSfkD6zUuNDWIhagHK5?=
 =?us-ascii?Q?KlKPHXcCcgJIG1rMri1IcsWY5MpAks37xkQWQoKjcT9fWS86Yt0C6tM0j8N4?=
 =?us-ascii?Q?0xSMEKE/hoAOUx2MvEQKdQ6vvW6ZaPd+yDUIzHzPjM/LukLX1xpODpe9B46g?=
 =?us-ascii?Q?1sDWSmLvTzcklk3813n2BAr0/lydoVVQ3yU2ZX7pm2YyClq0c3FInKDmu8G4?=
 =?us-ascii?Q?fCVupoZPZ3NQZzsSosyjuZM/R5hf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kx89+EPn2TJ4tfFrDhp7OX2LAAIKtaznTgO4Ot5LYyZRWls2kgE8+zpXSRbC?=
 =?us-ascii?Q?9QYnI2tTAw1In2kxDzsMvA3Kl893fN6e4n/zPuI6r0/uFrKEfwuAqDqrXLka?=
 =?us-ascii?Q?2/10ei+eANZXlOycqxv8Zwz4Z/yo8qK87V8WMF/BfXIm8W3qpbXY3Hnp8ajm?=
 =?us-ascii?Q?6iydcBUVBex3i1dW3P//V1ra0WiNR74eL9vR9DWj22CuZ4tq6up7/dQUEM8R?=
 =?us-ascii?Q?kc+LwGfyXHlC1BahFlDn0CPXuDscY/pTRGJvR8Kje3w6O1rIVkAm8+a5je3g?=
 =?us-ascii?Q?VAplrzDQDtGd/u4u75p35I69E89p+F/8kO25osktYfAgQTDgesNfaMmQNxf1?=
 =?us-ascii?Q?dQVCNN73vTFk3PKOmjCHcKch49/55QvEcQArbQe30hbYAsqxMugFb0QiCNEQ?=
 =?us-ascii?Q?+X/ZsvIIJgWmX3IKj7X+gCqm8yIlGLYucd3645oFLmGM+VKXE3Pm/uCYU+Kj?=
 =?us-ascii?Q?F8AXyVECSv2I4pr1LShTtNvQ2v43wpUXqlW/R/ZMT+MWdzImVW2XpJ42o0mv?=
 =?us-ascii?Q?iyGn4zgs2sYhWFdnkKlSJ6Us/2Zi2Prdd8iyV7IliW/V9G71bSY0qwxKkvdB?=
 =?us-ascii?Q?vHl35oarZcnewatnZX20cxpIwRVjzBLzGPf6KqAEKzCuklFZBSUUbD2Qdb6s?=
 =?us-ascii?Q?7Z5S268l2hbQ2oK8BB4JfI3DxE6+IPxSFWYnXN6YiD9EjasgSaEyxd9CX5KH?=
 =?us-ascii?Q?BvZzyXi2y9UoSM9LsPDBQ8E+v+lRaXG9Sqf2dwrrCa7tgS98maSa7rsl6i3L?=
 =?us-ascii?Q?86U5Mo1LF8aSPGd9g/mYyWg0HF4Z9pQA6m2FHZDr16hO1cUsvCm9s9jjU6ng?=
 =?us-ascii?Q?W1PDa6YyfKE0tpkYSeKm9AwXv+3rjVI2j7voe3Vuy7CwRKF+k4UZgrmK1lwe?=
 =?us-ascii?Q?KTofMj7Q7hdPU9C1dXQ5kkqsqT4iHIJiEmhYzWJSzZ+FkrCtQ5eUghFt4qtn?=
 =?us-ascii?Q?54Tn1Qrl6mXBPULKehyyQfdPBO8/4EEwH7IOM3LzR8GREaHxLwJ7jvrZokZx?=
 =?us-ascii?Q?uNJ/s9w2HwXQiJWI6hyORJhR5/hD2ZK7LQkz1P7hS17+nFY2UoP+HaN6MzK0?=
 =?us-ascii?Q?gCfdW7QxZWw8iEJUrLCcQsUHDFdZ+OBo8Dmr6TJD/Fg7l6IsSZVSjFHC41ou?=
 =?us-ascii?Q?9kzbLTLOhw6mv6n39mXobeuBT3cKkUq5PPN1YdwcAMT4dn6hPEwa1rt/Uf20?=
 =?us-ascii?Q?kMwMAvowUCHksvyUnzpmMBJJT/CVLDpFCAO/Q+YEYVJG9HEcjF81O3tXwyNX?=
 =?us-ascii?Q?FHU2ZFyc9jMiaZJuPFw+WXU32O8hfhXM0WF+O73wDog/i/7rXJDayVwnMYYY?=
 =?us-ascii?Q?9DcEY6t51FFy92f6e5AShjV0Q+RAyX7igduC2uGIgqeeSoQe4OojBIMXOTQA?=
 =?us-ascii?Q?zFWZ6d0WT1oqp/wTABiHNd8rvsOCEBYF/+9sqbTDpOEknFAZUfNxsyW/RsJX?=
 =?us-ascii?Q?sZ38d4eBUnSxHA7G46glLzkrtVqIu8IfUFZgSD168MDzoWV+bqKco5Cg8XUX?=
 =?us-ascii?Q?yZvoTP1yxHo/HedqO3lbTvI3QGDcjHv+FhutLvS9/kjbbtoM+s6TfZ4+kGsK?=
 =?us-ascii?Q?cwyLEZsoBYyxiibvoI8q0NWgp1NU56yJc6AWswda?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e803cf-37b0-47b6-4da3-08dd630a22bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:08:54.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuZKA/xkHWCJQDqxSZwg4nM9IbkQOi57yizaT0usfzLZNrITqrarqfT1qUPOFzoT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473

On 13 Mar 2025, at 17:05, Johannes Weiner wrote:

> compaction_suitable() hardcodes the min watermark, with a boost to the
> low watermark for costly orders. However, compaction_ready() requires
> order-0 at the high watermark. It currently checks the marks twice.
>
> Make the watermark a parameter to compaction_suitable() and have the
> callers pass in what they require:
>
> - compaction_zonelist_suitable() is used by the direct reclaim path,
>   so use the min watermark.
>
> - compact_suit_allocation_order() has a watermark in context derived
>   from cc->alloc_flags.
>
>   The only quirk is that kcompactd doesn't initialize cc->alloc_flags
>   explicitly. There is a direct check in kcompactd_do_work() that
>   passes ALLOC_WMARK_MIN, but there is another check downstack in
>   compact_zone() that ends up passing the unset alloc_flags. Since
>   they default to 0, and that coincides with ALLOC_WMARK_MIN, it is
>   correct. But it's subtle. Set cc->alloc_flags explicitly.
>
> - should_continue_reclaim() is direct reclaim, use the min watermark.
>
> - Finally, consolidate the two checks in compaction_ready() to a
>   single compaction_suitable() call passing the high watermark.
>
>   There is a tiny change in behavior: before, compaction_suitable()
>   would check order-0 against min or low, depending on costly
>   order. Then there'd be another high watermark check.
>
>   Now, the high watermark is passed to compaction_suitable(), and the
>   costly order-boost (low - min) is added on top. This means
>   compaction_ready() sets a marginally higher target for free pages.
>
>   In a kernelbuild + THP pressure test, though, this didn't show any
>   measurable negative effects on memory pressure or reclaim rates. As
>   the comment above the check says, reclaim is usually stopped short
>   on should_continue_reclaim(), and this just defines the worst-case
>   reclaim cutoff in case compaction is not making any headway.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/compaction.h |  5 ++--
>  mm/compaction.c            | 52 ++++++++++++++++++++------------------
>  mm/vmscan.c                | 26 ++++++++++---------
>  3 files changed, 45 insertions(+), 38 deletions(-)
>

The changes look good to me. Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi


Return-Path: <linux-kernel+bounces-435361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA49E768C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF9C284495
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D51F3D5B;
	Fri,  6 Dec 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JoCxJMuk"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB320626A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504321; cv=fail; b=gigtA7mG8Ove9/1WKfHjV8L7isxmHRpF9Ma7EaRwj1zMRfsFkF2+cqSC02yxDIIXoscfLWlF4VR0wFN1uXXB3THhEImLGBBo730LE/cOshU/ylIBxUjWrrFak3JTmcj0PAsvqRJ1HWdfAfxLZojsMJMAFzrjI6cOC/iqOjtVV24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504321; c=relaxed/simple;
	bh=4gv9zYbEEsr6xnXJBoMaHpB10xnP+BVIQiIaY+ex3z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m74pTjF14GHGAyLsgb/eLurp3aLcjE1UiFyDmM1Hg7H9vfYjjPCqqXwVa6vI8P0x0Eov+IeXMpm9IzMKe7EGFWEWp+VjNEJzgV3bMrExr2B+Fja4RaKVJrDXY7FXQSJqQHifS4jtjEMNYPUfL+uxTnllZJHQSmEMruz/s+Z/uHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JoCxJMuk; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpzAW4y3n+wIT/qPcLiBFBrJ4ugumG1AubPpMYHn/sZgOuvTMr9HOKcRwKthzD52oiiPVTsKmsexzkz/xfKJHCTCoBxZdC9lVHeTC2CtEcLDe5MFsOKAdAjs9D315B/sd6Lts4RSx32H++xHo/mONWhlA9RD1sfGXUPU0Hc4ETZLAeocoBkP46S6DoPls8p2xtjIJ44USNayrZAeFq51axqaoLhO/hVpbp6ofwbY3UitXP8B+L0M8lQwi7twiqDvBHSjtfNOdXULGMsE/N12Zo3NoEIDiFy56o7w3Z7QpCjCZky8ODGKDQskctC8xAHuzfPNriHxQlvQvNcd0f+rnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5jvv2sh1kMtga3qcTgJtyeV1eepW2ZTx2jwTxQfPmg=;
 b=e+SH7kauNRfIcwhaVywvQ87fI4IllLWeaNKFCn5+Az9aA0IwUTGinQbJPP2mBT6aHLR/rAPPWyW7MqHlLkzxDXVeemEuusIn8+3SAoMxy8hYkwP1ydd5SUQLIKMGVTELBJE3PppehxdPw7TWpR05Dt77HmUEASgjcUl6BnqsoHIPd74OJBwBG6Ayds8ibeEC4CDTVDI02MGzIzqxrPfJ6ujAGqb2GcvRuLJ/30RjpKmlw5Hdt/bFZlq3U/R+HS+RlISka9mgMiaSWH/s2TTUgFArzMBAyPgDssBz0a/KvFZrRagmWU303agz5FdDuy1Zi/aKUX6g46YRGP+yjj0y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5jvv2sh1kMtga3qcTgJtyeV1eepW2ZTx2jwTxQfPmg=;
 b=JoCxJMukdL1HT4cwUUpaKtk0lNOJENZ/6vsMrABmCi04ou/OuPnWVBn2vTWFOoZm41FAzopa2YquqTjoZZ5ccuHFkT3ZWBhldCcsY/2cntbRk6ON4fex8VFHn6fscR3R0ngMJ3wXveHhojuwJTok1BRB/oDcMjemJ/6FBZBs2+AGwAW/NFAZLj9+s95qdMWj+1jxmpEcAVjxU+DoELWaiImWop9nSUxVCaj0z44jfI7YUfEgwQKMhknahprCjvhrWkgX8kWcOnS/wCLmdYvR6LG4ww/EsXRQOSER3PeB0o3guoEkatNyA2x/g0MceRU05DDlXor0TWhKSyPzWDYwOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Fri, 6 Dec 2024 16:58:36 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 16:58:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
Date: Fri, 06 Dec 2024 11:58:34 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <6B9E52F3-1893-4D0D-AC7A-BC1CA96F0247@nvidia.com>
In-Reply-To: <20241206095951.98007-2-david@redhat.com>
References: <20241206095951.98007-1-david@redhat.com>
 <20241206095951.98007-2-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:52f::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3c2ad1-0e06-4ede-eec9-08dd1617395e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SsF8WukAJjHFGBkLODQPnEfMKLWwTpdlQ2GkXe4s2jRNuQMI/znedrgUe3oR?=
 =?us-ascii?Q?uE3Hu5AnQ5FlCYHgFpR2Q/X48+YdT2KT31EDCJV00CDPFwfSzoi5rhEKW/Fn?=
 =?us-ascii?Q?j7jriq+Wr6I04zL6BYMU4y5Y+b31OS7EfjPFbriU420GU7NllMBAyCiIJgjc?=
 =?us-ascii?Q?tCj3igUVbBwgjcgxab2yOuY2MmOpUIBp0wc/+3k2j+Ewgs39hGASU1+pR9XU?=
 =?us-ascii?Q?Y5WN+FVENiQshoBpwcn7i/vF4C69/Off3IUqpfgrGmnwkMVH/WtwRElTmw7g?=
 =?us-ascii?Q?f0Bx8bp386Tm1cLkYnA8YeuPUQXJrF1lCeeflxWndVvaltCX78/72H5pXegM?=
 =?us-ascii?Q?H4b5T0aE2lDd+A5S1XIDY3I+TR4bbZm8m+G9ahtfkcAWwR5LGXMsQHgAcLP8?=
 =?us-ascii?Q?/ZqCEXXhtzBJxXs1RE+ZAHXTngkY3HVm6zHS6zQAQ35SziKctSm9j2M334AN?=
 =?us-ascii?Q?FCjWaNRRDjKHMVxo5T0pC/hQP3PuQjog+cHwq5l1OW9sgb/jEMnq5IyT0CrX?=
 =?us-ascii?Q?+00jJfvu/RmKnGJJG45vHfozRKd/0Jzf99mPQH5K0d3NGKPkzOu3DLE99KnE?=
 =?us-ascii?Q?zROcYF2DDeLWZCt/cHSasUqsZ6c1qmkqd5INmCpZPLqeOxmGWk8kqpICPlgF?=
 =?us-ascii?Q?kVjuZCqohsia4xk+RqekWShqz+n2X5ZBqUXReLO4bLtP2yK2PTk/2iBqcI8+?=
 =?us-ascii?Q?g0MQ2ARxwjKANbrTERBoZzPK/mglaP4NdOaUiqPcSe+qliV5BaGga150pRhM?=
 =?us-ascii?Q?fUIZtmNuEOPRvjPuS5Jh/mHmprD9s+nX18UkjAeVb+AI9RIHjedOb5kSsWua?=
 =?us-ascii?Q?zFw7xPb+irKYdoM362974UfFcmaHAwwrjsgpbm0FxdWAUiIBenDwQjvJpET2?=
 =?us-ascii?Q?xHqHVrFaUlBT/kxMvqm4pgTUq3g/nN/Dx7i6Si+5BTDcad5raAqwsHMhYO7Y?=
 =?us-ascii?Q?qLEM7tGJDm1lxQGGCj/gCQxyp54SWodBW5kjGAq9HYc+AqA77DRE9E8GvjNa?=
 =?us-ascii?Q?oIx15nPiftIFnH80395XT9zJAo1hbqHPmv78bPAJq7TlIJaxBXEeY6XJe+eQ?=
 =?us-ascii?Q?pDxm9jbNhnbqQuoXgka6lgOYE3w6I0WfKDoEvMcWGJPp85+7s/rKEPub9Dvz?=
 =?us-ascii?Q?eoqQIWR7lP33x2z6Fkr0c/+b5DSfgU5x+x3VhC0lNerMJXVaOcbKR+9i0BeM?=
 =?us-ascii?Q?xR3lVTfY/Nz7SWJbShcZeO/HkllPFEffGvOHoaNQKr8808njC1fEDIR2wObo?=
 =?us-ascii?Q?+2OTll0werBnHtit6R53w+4jV1yPFHZ7mTg8JD5tAH5fUBng/AjuLehY6YYU?=
 =?us-ascii?Q?iYa+rwDMMwmM2XIEe3dZtu48kBvC5PPHUT+WyDo01LLh7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A3Qd8IHrDBJGHAZBDpMqmB35p5sMtLqyRR5Aa9iK6BH2DdlbCol/F1i8qhBb?=
 =?us-ascii?Q?1BytliVPqgqV2Fn/0ulkWr0xO4VXlZhTKSr3lC0gFnncWqHOGICdyvNmOQfx?=
 =?us-ascii?Q?xMurR9ixFjIM1zvzcv64ITt3i1s0YZN6N+rvj4XrGDhFuPpnQW1D5D61Kbhv?=
 =?us-ascii?Q?XD0PvBYkq4mm8fLaYPFlxSUabFRzFQV+c2KvuRJurBpAVXLuFoipdJ9ENg3B?=
 =?us-ascii?Q?ceDV9BBOFc+XjkCb/4FlryFbtp6KFwxYVfy+zFT3LJzyl77lbG6rizFidX8q?=
 =?us-ascii?Q?QQJa71VaLAAKps6XvTxwVc1RpRVAKQFQ8tsr0a3G1d9z7kdvJ7Sr/QkcekV9?=
 =?us-ascii?Q?Txe14PGlCxD/va1/JGW9F3ZIz2UlIigtJVnrCDxbeRgoQO60t0YNAGpaZ/T7?=
 =?us-ascii?Q?u8Iyio8Igu613ozFeivcgdxba2CytV9DK1bdmTUYxxJinof+KAN+rTWGyS4f?=
 =?us-ascii?Q?G7ya96K2DnOgLBCgZqDklwI4fi5mNirUNizUbOxXhj0sUPttdFY2xaFP366L?=
 =?us-ascii?Q?OHIn8e0g4yzN9h1WstR/dnvhsCz2y2KPGYpkkEseFwdCPgBjxZD5AqlRtJI/?=
 =?us-ascii?Q?5Dj9e3UgrsWoPqeYVibXXruLDWo1DdfyIhsdVqbRt+md/OnOBHlE602wU24x?=
 =?us-ascii?Q?+uEgqIb9kX70ONrgi21od8U2WOW89q22xBVT+4vNYgLxH4Jv7jQDlKbKFP53?=
 =?us-ascii?Q?NAa3642RCbVY/x56GD17ohROj/37EjsgUtv+wkVnjRprebs9VBu4DELiCu0e?=
 =?us-ascii?Q?OzjOdSQsxbn9idtb7ekBcPNBLpQK+wQ06pD7zzsMvF5jMGR8BcwSd1tYpKy/?=
 =?us-ascii?Q?RbU8pBoFOarrYAAckoleE26lcYZBQC8SzEXpeHNKeYgMbsi8uFCnXN+AJYHf?=
 =?us-ascii?Q?SdIXyogeCDyJQXs1Kbc8KS+ITIIcFaFaI0d5y1N5kzvmUVQeGeWVJfD18yUj?=
 =?us-ascii?Q?VcaHAFwRzH0aKam9L9bYKi1AUZfPJOqxftSV8uqy1ftSbd6OLBeHMP1T+y3g?=
 =?us-ascii?Q?0QtbiJ11VtBfj/scV9c+Oi6+asgaqRpFZ+L/5IHgCnhm1OpH9QN5LIs/P+j7?=
 =?us-ascii?Q?JvaQSGpBqz28jgxvjUW0VwAM6g+fkvq3pQ7YqCusggnddK2W0pRxfedvhSpN?=
 =?us-ascii?Q?09wW9jSaM9F5Gr3oAvkH6QCwGRMMWLmA9mWMsIZAMop3qMGetGOKM0WDwkKx?=
 =?us-ascii?Q?Pab4mDpJEbgdeClkfU0WEITmql6OLKHGq63lml0zlipqkQ4f+1LKJSr6tjND?=
 =?us-ascii?Q?w2fLDHXrvksoiPTUQyrxJKsCM8kTldLUb9RDnqphGnvEjKx4+1dtvCGb4SK6?=
 =?us-ascii?Q?wkoMOwUzqmA+EPMLW+vc6+KJp6Nc5fnzvqfkyf3mi2+foAFchWV/VB+H3wM7?=
 =?us-ascii?Q?fQ9rPXrsSD+wTEc3yy4yNQCAKBfh76gYSloRxUTGct1/6YcEQvi+yK3exevh?=
 =?us-ascii?Q?kvCFvPAR0GWALq8kQmHqS8nTugXBva+f/UUo9qq/oyz1W1CGiID7gtxgEy9J?=
 =?us-ascii?Q?9GUS1Ci4cmLzTg4TTSv1UQELXbrT8LUlaiHE2CQD1ktq+PbKBK8oLILUe2ok?=
 =?us-ascii?Q?z4hJaZ8vNC7tzsxLbWfU64K9FxvvXQTh/2rOXrp7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3c2ad1-0e06-4ede-eec9-08dd1617395e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:58:35.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u18d4uFBsPQnh+G0Qlpx+9wwtkLNbC1pnZOSRrkwXXnnbndsMbbvVqcZbC5Yx2DN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

On 6 Dec 2024, at 4:59, David Hildenbrand wrote:

> Let's special-case for the common scenarios that:
>
> (a) We are freeing pages <= pageblock_order
> (b) We are freeing a page <= MAX_PAGE_ORDER and all pageblocks match
>     (especially, no mixture of isolated and non-isolated pageblocks)
>
> When we encounter a > MAX_PAGE_ORDER page, it can only come from
> alloc_contig_range(), and we can process MAX_PAGE_ORDER chunks.
>
> When we encounter a >pageblock_order <= MAX_PAGE_ORDER page,
> check whether all pageblocks match, and if so (common case), don't
> split them up just for the buddy to merge them back.
>
> This makes sure that when we free MAX_PAGE_ORDER chunks to the buddy,
> for example during system startups, memory onlining, or when isolating
> consecutive pageblocks via alloc_contig_range()/memory offlining, that
> we don't unnecessarily split up what we'll immediately merge again,
> because the migratetypes match.
>
> Rename split_large_buddy() to __free_one_page_maybe_split(), to make it
> clearer what's happening, and handle in it only natural buddy orders,
> not the alloc_contig_range(__GFP_COMP) special case: handle that in
> free_one_page() only.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 71 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 57 insertions(+), 14 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi


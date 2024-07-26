Return-Path: <linux-kernel+bounces-263015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED593CFD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5D31F222A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057413CA99;
	Fri, 26 Jul 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="tPzCykfy"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2064.outbound.protection.outlook.com [40.107.117.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DD36D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983711; cv=fail; b=QLL7hlLnKPV5BHT3Y8kytdAmD2pGDGG+IhsNNxxXDTwGIIRdr/WErQDRnTZTuS50Iu/cYO8JI7Tftaht0f0siSiGeC+BCrrNersgna0whFn1l71yechvsIy1SnraCoH4nLQE475X2TvW6H2pnTjWSbMHuG7xzgK5VXaDG99kL/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983711; c=relaxed/simple;
	bh=zheN4/uiOXbpYawVZ1R27/1w37YEOtzaILcSoZCYgYc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8BqBvx1ZxdgU5UOaczUAvaUduwOT8ls3IBj6+hLaDBtowytpAYmdnEek3HHj3uaUBbS2DmzLaH7RWve/7+NdTZdiLoYCgqdzTtw4kWLezX6bFDzPNOFJLNgsdNF1tZhwmV4IYGbgMMZtOKrhsAjih8+R0UNcq+hZQsNB0s1KvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=tPzCykfy; arc=fail smtp.client-ip=40.107.117.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7My5CBCOAFUy9MdrbbKnXZwq1qyok+NxBiFpnhhHo0QLQVdTAqohU2RXgITwR3I9GT+BlE0FENj4zQe9PxIECCppZFla5BJga0gXNAlhqK6yuY6yt2MIOAh7QRnjXN/UTPGr0HugRRdNZVpvL0U9zkFUyK3Yy5hZxY5MK3yqFy8ahObyy9nSTiARn0qhnRLe5wWXN5BvUMcFYH1sfYNN5r4ESK2/XLlIa9iQSt4xc/1weZ8POcfrwK2kSCx/PokIXILfHeIu6efLSwsOvBi37qOEJyxBNsCA1rEGJpld8LYRZnpP+eksuiW9OMusjZlU45q9uSW8+89CnvO91rp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HP6o3kqP4U4ZuSHd6uUFOutIlvSzfe7+FrcG0AqfP0=;
 b=Uy5C3a1GFzmeMNtth/FdTHMvUTAgKzhl5pT6Dc5OOmTL+eYmqpiuy1LEHHVbXpGfXiuc528lov2g+5FP78N/GdmwgVc/WFX3fo1/ipM5c+HmJlAYFQLVX6MtDhCu0HLAJcZCkwz61sjxN2fk0U0+s1HdV6iDiZaoQ5fwBs0JB7B2LQivVlzjFPbNKM6gpTgmCRY0Nb9vZHFqnto2KgdOqz6gtqfoKrS4O1vwZve+zME7zg1RaJ5p3YgS8aJ3rzGuVY/DmXzfRHlRHmCGSKdDcCpvG+JbgT8zgwe4haAq1nt/1HA+tn+OqbFg8GuEURC9aWfX+YNA9sRUgaEKD7slhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HP6o3kqP4U4ZuSHd6uUFOutIlvSzfe7+FrcG0AqfP0=;
 b=tPzCykfyUNMhf5HQaERyyynpmp1xMPIgUN23V1t50sIcJyuLvVqHwFLv9+ZXzETI5j693nMeNekUNiV2SS/0TnNprRh6mHrKJEfrNikfoi0GiuIOaDOBfVV0KWj5pb3jYpB9aOCb1e2JwyzWGA98t+FAp23d233i3nnFcJ8nDGc=
Received: from KL1PR01CA0073.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::13) by TY0PR02MB5792.apcprd02.prod.outlook.com
 (2603:1096:400:1b7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 08:48:26 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:2:cafe::64) by KL1PR01CA0073.outlook.office365.com
 (2603:1096:820:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Fri, 26 Jul 2024 08:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 08:48:25 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 16:48:14 +0800
Date: Fri, 26 Jul 2024 16:48:09 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Baoquan He <bhe@redhat.com>
CC: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <20240726084809.gdz2axvawwwekpu6@oppo.com>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
 <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
 <20240726040052.hs2gvpktrnlbvhsq@oppo.com>
 <20240726050356.ludmpxfee6erlxxt@oppo.com>
 <CAGsJ_4xOauOwkHO5MTKHBP=fpeoNiP_9VJ31G4gBECFvLG4y0g@mail.gmail.com>
 <ZqNgY1T/VuWQvtfL@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqNgY1T/VuWQvtfL@MiWiFi-R3L-srv>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TY0PR02MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 137bccf0-1952-409f-12b0-08dcad4fb69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Si80dE1zcjRJS2hnTFlOZUVlUVJpK0xMVDFZZDdFWUxaaWtmSG8yNjB0Tmd2?=
 =?utf-8?B?WEhaRnU5QUpYR0U4cUlHSWtESWdodmp5ejVYY2k3N0tuUjlnM0JYVmJIOXph?=
 =?utf-8?B?WklmREMrK0pGdTAvZjNySTlwWXJRV1VtaExtWFNJLzB4cjJGdytaUmJOZmJw?=
 =?utf-8?B?SERVMUx0Zm1WSWR3a2pxM0p0NG1xbzdtZFhpUWp0S2Jmb0d4ZWw4c0pKVXcy?=
 =?utf-8?B?UHdXWW1vbUY1aGNOWE1CaWNYTjZzQUpjU3o3VWoyOWZ1TTNUeW1MMkFyNDF1?=
 =?utf-8?B?TnpVY1lnQWt6WWVsSTg4STlrMHBpbWFzUmQxOWI1WXB6Z2NFYnRLbmR5Qk9i?=
 =?utf-8?B?ejZRd1Q5UlJyaUZnQ3hnd09RcjNHUkl4QXZlMDhXbGlmaFJzMCtUWHpVRWJm?=
 =?utf-8?B?Y25kaDROYUUrbmk4NVkzT2o5YVVsVlN4ZVJQdk9jNUgzcm9FSFd6Z1pWYWNJ?=
 =?utf-8?B?c1E1SmZsaUZ2RFdZU0k1b083ZUZ3STFsTDdUN2orRGUvNjAyb0duRVA5ZXRM?=
 =?utf-8?B?SkRLb1Y2R3dHc1VUc0d0ajgrR0Q3TCtTVWtSdTJvNjdLcVhicDdlcW05dVQz?=
 =?utf-8?B?amdqZ1FlUm5pUWZ2QXVpMFJJak0wdHRGOUlTby9rQ0x2c0grNHgxZTdDbmMx?=
 =?utf-8?B?dUI0aXB5MW8yc0N6dWlrMDlLN0FsemxRT2ZyNk5JNTh2YnFHOXdReFlYVEd4?=
 =?utf-8?B?T1did3NKY1dZRG4vd1h0a1pIUzI5UG13YnRPT3lEbHY0c3Jia2RWcGZLTDg2?=
 =?utf-8?B?SkFHRDhzMm9QREFtUjQ1M0pjeDE1K29NVm1rczB2bEdNdnFmcXREcmQwQWt2?=
 =?utf-8?B?ckZ4Sks2emVMTGF6d1MzYk1VbmxOVFhvZHc0QnY5aERlN0ovb0g0UHpDenVj?=
 =?utf-8?B?Vi96VXJIZVdpL0dGbmpScjFieE8vdWRXMGVIQm90a0F1cnIwemhPalE0cTRq?=
 =?utf-8?B?S013cndGTXYrejlnMHh4RnpwYkFYejkzdElMenYzUTY5cDJJazAxMFhPL2RI?=
 =?utf-8?B?R3Z1VFFQK1lzQUkzT0dXRjd4cWJHcGFXc3lsSzVoZ0Uyd09MOHl2YndVNFMx?=
 =?utf-8?B?MWRPRERER0J6bkx6dWc4Z0hZRmZqZG5UTC8zczBLdUJ2VWRraVJ6OVNPK1E5?=
 =?utf-8?B?OVNxVng1eVBuN3lyUHlnM254Mi8zTWc3cWJpdGd6dHF6Z2loR2VjSUxXLzBI?=
 =?utf-8?B?U0ovWkN5WDVFdU9BcDl6cW9SMDBqWndkT253cUpZV1J3N1d1TzdQTUIza1pY?=
 =?utf-8?B?cVdGdXY2aUlJOEVKMHlYZjdTSkFBa1FPTHdoNXlqN2NVL0F6NmM4ZnppUm5R?=
 =?utf-8?B?NE9RMFFNYjA5bTEwME0vZExkSit3cDhFdWpSWGxKR3p6RytkRnBxMkZQbklr?=
 =?utf-8?B?eWhUTVpBaSt4K2Nhd1JyZWxMVDVEVllWTXVtK0VYUlQvWksyYktOR1VPQWgr?=
 =?utf-8?B?N0VqRmJudkFlQVM4aXRsSGNaUEg5UUFXd0pLU24rWmZpOXE1MUhFekdGbjEx?=
 =?utf-8?B?QmR4ZDlpNnd1ZWVBTldtaU1WL0pTSytRWjZmc0hVaU4rWXd2ZzZISzhacGhU?=
 =?utf-8?B?Mi9vR1AxOGI3eitkZUVzN3ZSeE5GSzZ0dUJOMEhmNXlFT3Q4R2FidlB1L1cx?=
 =?utf-8?B?ZU1lc09SQTR3b0VXZ0ZJRzdPOStYNlpHZE56RVl1czE1S0hrajdDOWFNcVBP?=
 =?utf-8?B?czBHcHBUREJPYjhrcWJkRWJNZHJUT2J1eHJBSmdNRUNReGVzWU5WN0FQODdu?=
 =?utf-8?B?ZHhSSlErRTZiYVd6R21tWEJHNFpEVEVveUkydjF1aXRtQlNKY2JJblpnWG5L?=
 =?utf-8?B?cWwwOXJuQ3IrRUIvSlVHaVpoRC81OVJ4MXhuTU84OXBCRVhaUGZwUlU5N2c4?=
 =?utf-8?B?bUl5cUxTMU1yMlJ3VlhyZTF0d0h3dldIZ3ZmTktaYk5DQlRRdU1SMGVOU1pp?=
 =?utf-8?Q?TZULuZgLWUPSH14LIYcHR4mCAnVHPDT6?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 08:48:25.5686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137bccf0-1952-409f-12b0-08dcad4fb69b
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5792

On Fri, 26. Jul 16:37, Baoquan He wrote:
> On 07/26/24 at 05:29pm, Barry Song wrote:
> > On Fri, Jul 26, 2024 at 5:04 PM Hailong Liu <hailong.liu@oppo.com> wrote:
> > >
> > > On Fri, 26. Jul 12:00, Hailong Liu wrote:
> > > > On Fri, 26. Jul 10:31, Baoquan He wrote:
> > > > [...]
> > > > > > The logic of this patch is somewhat similar to my first one. If high order
> > > > > > allocation fails, it will go normal mapping.
> > > > > >
> > > > > > However I also save the fallback position. The ones before this position are
> > > > > > used for huge mapping, the ones >= position for normal mapping as Barry said.
> > > > > > "support the combination of PMD and PTE mapping". this  will take some
> > > > > > times as it needs to address the corner cases and do some tests.
> > > > >
> > > > > Hmm, we may not need to worry about the imperfect mapping. Currently
> > > > > there are two places setting VM_ALLOW_HUGE_VMAP: __kvmalloc_node_noprof()
> > > > > and vmalloc_huge().
> > > > >
> > > > > For vmalloc_huge(), it's called in below three interfaces which are all
> > > > > invoked during boot. Basically they can succeed to get required contiguous
> > > > > physical memory. I guess that's why Tangquan only spot this issue on kvmalloc
> > > > > invocation when the required size exceeds e.g 2M. For kvmalloc_node(),
> > > > > we have told that in the code comment above __kvmalloc_node_noprof(),
> > > > > it's a best effort behaviour.
> > > > >
> > > > Take a __vmalloc_node_range(2.1M, VM_ALLOW_HUGE_VMAP) as a example.
> > > > because the align requirement of huge. the real size is 4M.
> > > > if allocation first order-9 successfully and the next failed. becuase the
> > > > fallback, the layout out pages would be like order9 - 512 * order0
> > > > order9 support huge mapping, but order0 not.
> > > > with the patch above, would call vmap_small_pages_range_noflush() and do normal
> > > > mapping, the huge mapping would not exist.
> > > >
> > > > >  mm/mm_init.c <<alloc_large_system_hash>>
> > > > >  table = vmalloc_huge(size, gfp_flags);
> > > > >  net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
> > > > >  new_hashinfo->ehash = vmalloc_huge(ehash_entries * sizeof(struct inet_ehash_bucket),
> > > > >  net/ipv4/udp.c <<udp_pernet_table_alloc>>
> > > > >  udptable->hash = vmalloc_huge(hash_entries * 2 * sizeof(struct udp_hslot)
> > > > >
> > > > > Maybe we should add code comment or document to notice people that the
> > > > > contiguous physical pages are not guaranteed for vmalloc_huge() if you
> > > > > use it after boot.
> > > > >
> > > > > >
> > > > > > IMO, the draft can fix the current issue, it also does not have significant side
> > > > > > effects. Barry, what do you think about this patch? If you think it's okay,
> > > > > > I will split this patch into two: one to remove the VM_ALLOW_HUGE_VMAP and the
> > > > > > other to address the current mapping issue.
> > > > > >
> > > > > > --
> > > > > > help you, help me,
> > > > > > Hailong.
> > > > > >
> > > > >
> > > > >
> > > I check the code, the issue only happen in gfp_mask with __GFP_NOFAIL and
> > > fallback to order 0, actuaally without this commit
> > > e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> > > if __vmalloc_area_node allocation failed, it will goto fail and try order-0.
> > >
> > > fail:
> > >         if (shift > PAGE_SHIFT) {
> > >                 shift = PAGE_SHIFT;
> > >                 align = real_align;
> > >                 size = real_size;
> > >                 goto again;
> > >         }
> > >
> > > So do we really need fallback to order-0 if nofail?
> >
> > Good catch, this is what I missed. I feel we can revert Michal's fix.
> > And just remove __GFP_NOFAIL bit when we are still allocating
> > by high-order. When "goto again" happens, we will allocate by
> > order-0, in this case, we keep the __GFP_NOFAIL.
>
> With Michal's patch, the fallback will be able to satisfy the allocation
> for nofail case because it fallback to 0-order plus __GFP_NOFAIL. The

Hi Baoquan:

int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
		pgprot_t prot, struct page **pages, unsigned int page_shift)
{
	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;

	WARN_ON(page_shift < PAGE_SHIFT);

	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
			page_shift == PAGE_SHIFT)
		return vmap_small_pages_range_noflush(addr, end, prot, pages);

	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {  ---> huge mapping
		int err;

		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
					page_to_phys(pages[i]), prot, ---------> incorrect mapping would occur here if nofail and fallback to order0
					page_shift);
		if (err)
			return err;

		addr += 1UL << page_shift;
	}

	return 0;
}
> 'if (shift > PAGE_SHIFT)' conditional checking and handling may be
> problemtic since it could jump to fail becuase vmap_pages_range()
> invocation failed, or partially allocate huge parges and break down,
> then it will ignore the already allocated pages, and do all the thing again.
>
> The only thing 'if (shift > PAGE_SHIFT)' checking and handling makes
> sense is it fallback to the real_size and real_align. BUT we need handle
> the fail separately, e.g
> 1)__get_vm_area_node() failed;
> 2)vm_area_alloc_pages() failed when shift > PAGE_SHIFT and non-nofail;
> 3)vmap_pages_range() failed;
>
> Honestly, I didn't see where the nofail is mishandled, could you point
> it out specifically? I could miss it.
>
> Thanks
> Baoquan
>

--
help you, help me,
Hailong.


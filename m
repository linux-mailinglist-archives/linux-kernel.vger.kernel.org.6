Return-Path: <linux-kernel+bounces-174015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DCC8C092E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF111F22617
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EFE13C819;
	Thu,  9 May 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Uv/Uxqbh"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2069.outbound.protection.outlook.com [40.107.117.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E902213BC3F
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715218267; cv=fail; b=eVAq6qOUDClTvnHjS1bqZMSC8YnV30aoDCMC83IQ4i9DvMLWodPCxpelQA/h1WyHRijP9Kfe0zyMLiQhJhD2IswJSwjoA+4n23sm9GApuH5SX2hEzrVK8mTAp/h0/Rdtubs/UZ6Tb4omqJNKIFsGj6WLpcpzY6kuR2yGQcY23K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715218267; c=relaxed/simple;
	bh=LWLY4wGdFFjc7xAmt0DwrtpBPg5epL5SuHLWIELOtmM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOf9fiUG4zaEW7HysCYNOfRhNtvcY1Trvfpq2qhed9cCGGChhXnLhUhLIc8gZF2AufqiFe0K6PBf/ynpCAYf5e8Lk5/LwKmHg2J/4Ejwz8H2LK4JulCHsqLQPKnDFkXDbMQsllit6tcAmDwq52aBUaxadN00eaAhJUNF6vX+Uh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Uv/Uxqbh; arc=fail smtp.client-ip=40.107.117.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVR5pUtohfiaWZUPyH3I9aQpgAn84YpJJYelZ6xDuPNjVpiMiPCIdhLLjZD4wNH3U5d/dZ/v26A5Sc8fE/c5Vj6RyZEUM/3i2Dqo63Cw1Z0amlO1kGutXclSwuJ/c3+Eqjf9MdlE2zAvOrK0irqXnRzJEB59u/iY/Uu4ZnMx2BtKhh1T0U9vxryE+J0oteFDMnaxP1T0esuK8GBRD/kM9QWcsLkS7k24VTDiIfr3EEyuQN5Hr4+SNZnnN4h8b4QLe9UXSvnfQQ6X9yRKS9DXWIxxckeFSMuMpTfqhSSL4EEVjaTOh4sSkvrgQmVke0HN2xTNxUHu21zFABQg1SmohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf38O6dMuZsoi9p2rFkT0hL0R7xYh8pPpv/EryKrpyM=;
 b=Rn6LRKoz1Ad+uK+vADnA8twWWPFxaS+b3dAWMiJ1arnEgwG4rc8xJwnSDPNwiIZkYPS2DU6zSvz3icNP01wZ7CiPV4hreKcqEljMEo6wfhEwzIt+gdh2R1jpQF6CCbjj0ZdIJmabVBi1bNnP6qZ+KElTMws3Uhi1bWBv+um7sWA8L7qz26jqpCv1hajgXzzp3JWqrIRRxb5WCxWvHUGq2ux6hpri2W4hk6rnUMD0tlMzd1zeeM1DNNBQSV6/IjxO8NpqeHODdRg3Suh3KtC6gOJV6iLMMTBnxanh/ax+pHdD0dY+ufeQ33k45xffaFLqo7LVz1znu0Csc3wAc18XNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf38O6dMuZsoi9p2rFkT0hL0R7xYh8pPpv/EryKrpyM=;
 b=Uv/Uxqbh1AHBxpclXheG/DLqYf35MjIEkuScMQtdPC/UwoLNGb8XElZDw4JJtlxjBhlWUUc2Mnj1gpEN5iEHul4Pp94YFxcWgisH2XTlpKesGrN2bVGGSn8u0LmBsAXuMusUA85GjZYXUwYrGFblDX2JCtqh7xRLoa8/C0+SXSE=
Received: from SG2PR02CA0002.apcprd02.prod.outlook.com (2603:1096:3:17::14) by
 TYZPR02MB5914.apcprd02.prod.outlook.com (2603:1096:400:1fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 01:31:01 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::47) by SG2PR02CA0002.outlook.office365.com
 (2603:1096:3:17::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Thu, 9 May 2024 01:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 01:31:01 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 09:31:00 +0800
Date: Thu, 9 May 2024 09:30:59 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
	<urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <chao@kernel.org>, Oven <liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <20240509013059.vegko7dlty7vppy5@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
 <20240508144321.ymnhn54daaabalhe@oppo.com>
 <90a127e5-d884-44b5-bb76-773a7485c2f1@linux.alibaba.com>
 <20240508153136.x4rxildsgza234uv@oppo.com>
 <52f9e300-4ab9-43c1-abae-cbe3da27e5b0@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52f9e300-4ab9-43c1-abae-cbe3da27e5b0@linux.alibaba.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYZPR02MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dac591-7ae9-4d22-69dc-08dc6fc7af5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlFKaU0yZ3NGVGNNTStWbk9YVi9Fa2RJbFY3M2NDU1JQVEFMMkRLaSt2b2dv?=
 =?utf-8?B?VHBQOW9mdjBKLzBHRlNvL3ZYNWN6Ym1VbHlFVzhWUEU3emcwR1JxanZPZjZr?=
 =?utf-8?B?RDAxNVhJU3E3aGFBbnRJSGRoTGhIUWdja09qWkRjSnJjcnZsWTRXdHhIRC82?=
 =?utf-8?B?TUs5N0dPQ3BhcWQzVWVZUGQ0SzNBY2VFM3ZNZDA3L2dnMzJ0UnMxSy91V00y?=
 =?utf-8?B?emh1MGZJMzZHSlZaTFVnaGUxSXNudkxXZ1V0cUZOS2NOOGFBT3dXaEVZc2RY?=
 =?utf-8?B?aWlzMElsdUpJSVZ1dzkrNnRPeU1taWhEdTlDYTkzdWF6ZzBsS2d3UnRKYVVw?=
 =?utf-8?B?YzJJT0ZhWWtZZzZPaGZjcXpyamVEbzdCd0Ird1c4VHhJTkJDWVNoV2t4RlVZ?=
 =?utf-8?B?QmdiUFlPVFlKcUQ1YlE1aEtDSzdheTBwaTc1Mkl3UVZHeU9SNGhtS3E5QS9C?=
 =?utf-8?B?Z0tnVklPbWRoWkxoWVYxSWJBV2RBODZVS1dFK0p1bmxZbkNYOGF2ZjBCVXAw?=
 =?utf-8?B?QXNmOFE5Qm1WK1BVZmxpZzNaYUdlRVJjUXVmMXFqRWdzQ0t6NDVNZSsxeHV5?=
 =?utf-8?B?amxjcnhYU09vMVZ1ZEFYRGcyNmxNZ21TUkdGN05LOEh6UXhMb0NZRjB3VGdS?=
 =?utf-8?B?RW9XNnFZVmp5NjFiSGpvaWJZMERHNFAvYjdPYms4ODNHUklXc2dMZUJUNXcv?=
 =?utf-8?B?NS9WYktzZVA0NjNDUGdjKzZmanQ3SVNvZkxCMXhYSmROZVFIZEFPOXM4WFFJ?=
 =?utf-8?B?R0hnc3JYWk8zTExXbmZUelg1WjA2NXBmcFFjTlBmODV3WU5jc250VG10NEJS?=
 =?utf-8?B?RlYyaXVqU283dklJVUtOUDF0SXhaSkFLNmNncTJ1MGFCT21tbURXd29ybVJB?=
 =?utf-8?B?bTZOOUVDNDFPYmwzenZqYkllMU8rZzZ2YlFJNDQyM090TDk5dlQwaVpaSFFz?=
 =?utf-8?B?eTZYRGpTWlR2eWdYUjlRSy9sVTdkZGJRSFVzMkpKdEYzTDlDNnBsdFlTZklt?=
 =?utf-8?B?M2I0YXF1R0xDTFdtMHRhbnZjSGhKbHl2ZG5rdGEzaVBvNGRyTUJOM01YMXpu?=
 =?utf-8?B?MzZWeGhBQXZidmhZK1dBOHFjb1ljQzBUbVVYb2VIMXNDOFdtNzdlVjA2aStJ?=
 =?utf-8?B?ZmxReCtrNmNJUWRaallkclRsR3dqVlFHOEpoWWhvTEhyNHZGV2pJMXVaSHJh?=
 =?utf-8?B?Rk5YRFkwN3BLTHV3Z1RuNVJxWDEwTkVxcno0V255aUs0RFFYOEZ5M3JBRm8x?=
 =?utf-8?B?Yy90enlJZEZEamVYYjBoUDB0VkZkREtCR0FteWp2dWNZR1FBdUlwOU10QlhU?=
 =?utf-8?B?U1AycGRwalVXQ3dzVkx6RVlPRVFQUWpuYXZPcTVlZ0l0NzFhUVQyRUJhUFFk?=
 =?utf-8?B?UkVRY1VFOGl1bElpWFhvMFBoZGM5dEpQQjlrR2QzNXlHOERkYk50aDdhMmRY?=
 =?utf-8?B?dEg3QTVNS2JGWi9pZExkKzREYTZVWTB4N2pxMWFtOHloWjNpM1JPa2tpbGJn?=
 =?utf-8?B?K1dSY0VWc01Gc21aNGVmNnAxUmdOS2pacFJYZ1lMaHZZdDBHUmFabjBBYXJa?=
 =?utf-8?B?anA1UTB6U0xJTHhQdmRGaS83cCt5NEY0VmExa0cxOXh3dmkvSXhyZndIZS80?=
 =?utf-8?B?THV0OTRycUtvVEZtemZGdFAzcExlbWNqT2dXZW1UU3pxbTZPWityUWZIYllx?=
 =?utf-8?B?TkdtYnFPdytwNUhuUE9HS21UUHgySW1idUVtNStUMktkalRyQTFKN21ibElL?=
 =?utf-8?Q?VEpBIzx1AfCxRgxal3IhPuNy0IKdoRKl+QTXzHr?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 01:31:01.0140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dac591-7ae9-4d22-69dc-08dc6fc7af5d
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5914

On Wed, 08. May 23:40, Gao Xiang wrote:
>
>
> On 2024/5/8 23:31, Hailong Liu wrote:
> > On Wed, 08. May 23:10, Gao Xiang wrote:
> > > Hi,
> > >
> > > On 2024/5/8 22:43, Hailong Liu wrote:
> > > > On Wed, 08. May 21:41, Gao Xiang wrote:
> > > > >
> > > > > +Cc Michal,
> > > > >
> > > > > On 2024/5/8 20:58, hailong.liu@oppo.com wrote:
> > > > > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > > > > >
> > > > > > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> > > > > > includes support for __GFP_NOFAIL, but it presents a conflict with
> > > > > > commit dd544141b9eb ("vmalloc: back off when the current task is
> > > > > > OOM-killed"). A possible scenario is as belows:
> > > > > >
> > > > > > process-a
> > > > > > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> > > > > >        __vmalloc_node_range()
> > > > > > 	__vmalloc_area_node()
> > > > > > 	    vm_area_alloc_pages()
> > > > > >                --> oom-killer send SIGKILL to process-a
> > > > > >                if (fatal_signal_pending(current)) break;
> > > > > > --> return NULL;
> > > > > >
> > > > > > to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> > > > > > if __GFP_NOFAIL set.
> > > > > >
> > > > > > Reported-by: Oven <liyangouwen1@oppo.com>
> > > > > > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > > > >
> > > > > Why taging this as RFC here?  It seems a corner-case fix of
> > > > > commit a421ef303008
> > > > >
> > > > > Thanks,
> > > > > Gao Xiang
> > > > >
> > > >
> > > > Hi Gao Xiang:
> > > >
> > > > RFC here to wait for a better way to handle this case :).
> > > > IMO, if vmalloc support __GFP_NOFAIL it should not return
> > > > null even system is deadlock on memory.
> > >
> > > The starting point is that kmalloc doesn't support __GFP_NOFAIL
> > > if order > 1 (even for very short temporary uses), see:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/page_alloc.c?h=v6.8#n2896
> > >
> > > but it is possible if we have such page pointer array (since two
> > > (order-1) pages can only keep 1024 8-byte entries, it can happen
> > > if compression ratios are high), and kvmalloc(__GFP_NOFAIL) has
> > > already been supported for almost two years, it will fallback to
> > > order-0 allocation as described in commit e9c3cda4d86e
> > > ("mm, vmalloc: fix high order __GFP_NOFAIL allocations").
> > >
> > > With my limited understanding, I'm not sure why it can cause
> > > deadlock here since it will fallback to order-0 allocation then,
> > > and such allocation is just for short temporary uses again
> > > because kmalloc doesn't support order > 1 short memory
> > > allocation strictly.
> > >
> >
> > deadlock on memory meands there is a memory leak causing
> > system to be unable to allocate memory not actual
> > *deadlock*.
>
> Where is memory leak? If it's caused by kvmalloc(__GFP_NOFAIL)
> callers, then it's bugs of callers and we should fix the callers.
>
> Also why kmalloc(__GFP_NOFAIL) (for example, also order-0
> allocation) differs?
>
> Thanks,
> Gao Xiang
>

I’m not suggesting that erofs would cause a memleak. What I mean is
that if kvmalloc is invoked with __GFP_NOFAIL, it must ensure a non-NULL
return, even in scenarios where memory leaks caused by other processes
result in the inability to allocate a page. In such a situation, it
should result in “Kernel panic - not syncing: System is deadlocked
on memory”.
>
> >
> > > Thanks,
> > > Gao Xiang
> > >
> >
> > --
> >
> > Best Regards,
> > Hailong.

--
Best Regards,
Hailong.


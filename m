Return-Path: <linux-kernel+bounces-263033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6693D005
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97CEDB20A46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0C3178389;
	Fri, 26 Jul 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="qTkJyc5w"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2085.outbound.protection.outlook.com [40.107.255.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B772582
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984434; cv=fail; b=amay7QQZu4fOALRFURrmTCaVAqGRs0CKfUaeiyASuyIZsW42ZwZS6BvShum4e8fOQPcuYpl3i9SGMkoacgfdUpWBla8obH+xVMDaNQZOModwo9Go4IlBp70gtcZgzoPrh8e/ypnd4CIKX009GeOwfwyrgj2hTCQxy471sVI8lwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984434; c=relaxed/simple;
	bh=GOhTkKtVsnM0Mct2NX8cPXH+8kIDfK8vHJUnORbcBG0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSVZMQyLS9pglFU09rqv6Majzk2Owun7wdii6pc2BDXwqGZ5qsygKqKTvf2Eostfv6OOQYiRDgZUPjPQKxUSafz9Dss1Ld2/ea/GS+uk4pBBeCGVm3z3DnR94BM3o4iZMvWbczJocv24C3ZkhGrzW9wYeb+YhC2ebDnIaMDULqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=qTkJyc5w; arc=fail smtp.client-ip=40.107.255.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvLTarW+xtaFf9IRLEuHahMIPTmJYvVUIXcDaVSIwFioxicA0kKBOyN1Jnk3pSNMnK42NB7uXHKljs73Fgi4gyWTuda1lismSzv9zPxU8rJMA7eDu8lewCzHERPZ1192F5XhLbx68P4MVlMjngaPPLlOHeVYv9w8BTdmEoC9cjQ0Rg/tzvo/54nK+vvHjO5VdOuCMeJHj62IFV7h0nm4v+ZLoU2TxRmrQE0+k0XBHGWxikbBsyTEffOcoJ3474Fs59QfmiQRdsRBFBGgb+5gsaEKydWy+0IWaq8G3bLHwaS3H37I1k8gTUh5Xu1xsxpMniCAs5vlzCqro+axMOGXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDA/cOAUxNe0JPPRuNsmyrUWXEHMM633B0hjyVHU8xw=;
 b=Pln/iYdJi7tPlpe6Ii/zaiJ5CEgKW72nGgdSAw7JIP/60eM4ExvpmfYew3gi6xXqnt4p9weo/x74zYHSPe68EZOa9TF2GzXuT6nztEJ0sSbAmDL0zo+hIHlHo6OPQ2NEwC8GDJp58mM69iPcDWgWCfA4Atx3DlnnHmsQzqqVsMAtquM3LyPjL0OOg/gGBC4UvqGATG3osYUI+Yzx1shvm6AkUOfVqSOQykqaal1AhdRQbojGGXb25spb5SC/YbtQ8jeDz3Kbp/jc6XG62ZsYcYHAoxbRYJkLDvKku2hnQtKk7xW7o6VcftI6NUFFJYLytQXN9LGuXWkPtRzZTuE+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDA/cOAUxNe0JPPRuNsmyrUWXEHMM633B0hjyVHU8xw=;
 b=qTkJyc5wYGcNVcOsvkRvjHu+H4KUrGMeggxnhZ+I4HCfeSrQicB628VRRQcMiSmHKOINbo6tHzTmUygVCE6jEfE3kTQjp2aS3NZFi9ftTxjV+/k9vVYPfh5bDT4LBYGnMMt7EGa3hNSWumriFcDMe7R7Z4ur/vtfVEmWr4BUrPQ=
Received: from SI2PR06CA0014.apcprd06.prod.outlook.com (2603:1096:4:186::11)
 by TY0PR02MB6838.apcprd02.prod.outlook.com (2603:1096:405:11::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 09:00:28 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:186:cafe::ba) by SI2PR06CA0014.outlook.office365.com
 (2603:1096:4:186::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Fri, 26 Jul 2024 09:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 09:00:28 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 17:00:27 +0800
Date: Fri, 26 Jul 2024 17:00:26 +0800
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
Message-ID: <20240726090026.b73smaydaixhypzs@oppo.com>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
 <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
 <20240726040052.hs2gvpktrnlbvhsq@oppo.com>
 <20240726050356.ludmpxfee6erlxxt@oppo.com>
 <CAGsJ_4xOauOwkHO5MTKHBP=fpeoNiP_9VJ31G4gBECFvLG4y0g@mail.gmail.com>
 <ZqNgY1T/VuWQvtfL@MiWiFi-R3L-srv>
 <20240726084809.gdz2axvawwwekpu6@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726084809.gdz2axvawwwekpu6@oppo.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TY0PR02MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: b859eacb-5b7c-45af-7be0-08dcad51655b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVhiWHl5Rm5WbDZkLzdFSnlKUnFlMUxHRm0wcUZlNGl1RlRYdnJxWjE4Nmwr?=
 =?utf-8?B?QVlJbUY3SmY4K0JQd2UzVEJ5anYzUTVsTnJrUU10MFFFMVFTbUR0azVoVkNW?=
 =?utf-8?B?ZkZHRklDcFpid1U5MDBxN25hMjJNUm4vVC8zZGhIVS9VVVhmcytwYlAxeW5N?=
 =?utf-8?B?enpNTXlNbVhJMDlwVGw4UlhzNkNrZlNpSDFoQ25jSEhxTTIydjBoMGxPWGcw?=
 =?utf-8?B?YkdoTjExVkxFWktLdEFWOUZ2QnVmUEFNYXBYVm44Sk5VRmNib2VMdXdiL2RL?=
 =?utf-8?B?dDRFWGk2Y1pUeWtLU0FvYktwTVU2OEJQZzFHZC9ubEUySWUvQjN5YXhsMWJu?=
 =?utf-8?B?dFMrM2pzbUx2bGI4eFhlV2JaLy81QUFYY2pGd0JyV3lEQ3l3NUgvOGkyYTQ5?=
 =?utf-8?B?RVBwd0tDSmM1VmQvaU11M1NnTkhEaTNPNHprZmMrTGMxckpweW9JczR3cWJr?=
 =?utf-8?B?OFM2WCtEbS9tSHdYaTBOdGhYb2dtTjY2WVFpaVhBTnByWHZXcTFzWnUwVjkv?=
 =?utf-8?B?aklSOFRYdkNIdXVwZWlpMk5hOFVvSDNwalZSOWYyU1o4UjFhbnFOV3hMa1Ft?=
 =?utf-8?B?WXUybzJ1OFpuY2FaVG8wZ3J6SVBZUTFuVmthR3laWlhCbVNFZmJqeVBMNUFU?=
 =?utf-8?B?SzFUOFkvbU1LVWQ1cTB6N2tBaWFmTHBwOEFjOEdnYlg0OEgyVUlJNHNTaXpZ?=
 =?utf-8?B?MWZtTGJzcHZaQnpQNzBFM1BtRnBYTE1wZVQ0WVVYaXJtcGNrM0pTS1JRNEho?=
 =?utf-8?B?RU8rZG1XbWx3LzlJbE8vZ3hOdUcrLzJQTEl2Kzh2WVB6bmJkeDA1cTNCTU9T?=
 =?utf-8?B?bTZwNWFoV1g1VjgwVVRLVkVhVU91RkdGVVVYSE0yZitOLzFaSkxJRGlFNlc2?=
 =?utf-8?B?T2V0dFhFWFZWSzFMdWVObDhES3p6dEVoYnY0d2NmaE5OVWdKMEVPeCtEakpt?=
 =?utf-8?B?dG81TE9SYnR2TGw2Y1IwS3haNTgvWnR3VjVSdFRpaVg0eHhBQWd0TjdQSHp6?=
 =?utf-8?B?dU5laFY4b2x0UTNmOTduVjlBWXljOWZobHhaZzJPejEzcVpHTU50VXU1Z25X?=
 =?utf-8?B?VDF2TVY4Q0FjeG9NZnVXcVFETDlsUEtWMDV1UE96ZkhTL3k0emp3TXBDYy9w?=
 =?utf-8?B?VVFEakQrVEZuY2FjLzBUU0tBUWlsV3g2Z0t1eklJNmFCbTB0ZFVYTTRKNisy?=
 =?utf-8?B?MlZTa3RNd1RnV20xbk1uTzl5RXhEV21MNlpLeEoySXFmQjdBYTY2dTNXcFpS?=
 =?utf-8?B?bm1JZkpWekh3dUFITG9NMG5FRSsrYkQwNmlGMDlTTnl6eUFPR2YzWXV2TjVH?=
 =?utf-8?B?ZTRjcXFaYjY5cndzbWRtRmVxaHJkcDhZRjhzVWxKQmtodkkrVFBiMzI4anJk?=
 =?utf-8?B?UjZTRnhUdHlUNGd0L1gxZ3o4dmszVEo4YWljR2VaTFJzTkgrNUErZ0p2azl2?=
 =?utf-8?B?TVNIQnBldjQ4UUJTQ0locnlLNkxHVzZsdjV4VjFZMm9wSTNYSTREWVpPSzlD?=
 =?utf-8?B?WXNaajFxVkFjam8vbWpWNXR3SjNrMHZQVWdzNGUyWHByN1dUaTN6WUR1OTJK?=
 =?utf-8?B?WnJUcklxdE1UTmpEaWd2amptY0FBV0lFaW9XNzlmcUZCbG83cGhhV2hqc20w?=
 =?utf-8?B?M2dlYU1wcjd3NWZ4Syttc0sxN3pQU0ZLYUdoZzZaQ3JSdmMwT0IveW9JSHZS?=
 =?utf-8?B?dmZjdUNRZFlDL1pzczlFMTliVElvNXAzQlZaM1J5YjRKamJzYXhXM3JoUml5?=
 =?utf-8?B?Y0ZXN1BCMWZtbGV6WjRGNGRRcVhBWUJDNSsrS0w5ZC9wbnZNVXAwd3NTRDZR?=
 =?utf-8?B?SWlobnpoQW16MUljZ05vUTZtVkR4S2ExcUFpRGYzVHZlQWd4ekx5M3NBTksv?=
 =?utf-8?B?UUNTaFNmRzQ5RGNpNnkvZTVvbUdhYzFPT05rbGpjTVJtOTA1YXlCUTdjWHox?=
 =?utf-8?Q?F7wNCXF5DfHRvxw//HpOE3kN8dk9xJjd?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 09:00:28.3124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b859eacb-5b7c-45af-7be0-08dcad51655b
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6838

On Fri, 26. Jul 16:48, Hailong Liu wrote:
> On Fri, 26. Jul 16:37, Baoquan He wrote:
> > On 07/26/24 at 05:29pm, Barry Song wrote:
> > > On Fri, Jul 26, 2024 at 5:04 PM Hailong Liu <hailong.liu@oppo.com> wrote:
> > > >
> > > > On Fri, 26. Jul 12:00, Hailong Liu wrote:
> > > > > On Fri, 26. Jul 10:31, Baoquan He wrote:
> > > > > [...]
> > > > > > > The logic of this patch is somewhat similar to my first one. If high order
> > > > > > > allocation fails, it will go normal mapping.
> > > > > > >
> > > > > > > However I also save the fallback position. The ones before this position are
> > > > > > > used for huge mapping, the ones >= position for normal mapping as Barry said.
> > > > > > > "support the combination of PMD and PTE mapping". this  will take some
> > > > > > > times as it needs to address the corner cases and do some tests.
> > > > > >
> > > > > > Hmm, we may not need to worry about the imperfect mapping. Currently
> > > > > > there are two places setting VM_ALLOW_HUGE_VMAP: __kvmalloc_node_noprof()
> > > > > > and vmalloc_huge().
> > > > > >
> > > > > > For vmalloc_huge(), it's called in below three interfaces which are all
> > > > > > invoked during boot. Basically they can succeed to get required contiguous
> > > > > > physical memory. I guess that's why Tangquan only spot this issue on kvmalloc
> > > > > > invocation when the required size exceeds e.g 2M. For kvmalloc_node(),
> > > > > > we have told that in the code comment above __kvmalloc_node_noprof(),
> > > > > > it's a best effort behaviour.
> > > > > >
> > > > > Take a __vmalloc_node_range(2.1M, VM_ALLOW_HUGE_VMAP) as a example.
> > > > > because the align requirement of huge. the real size is 4M.
> > > > > if allocation first order-9 successfully and the next failed. becuase the
> > > > > fallback, the layout out pages would be like order9 - 512 * order0
> > > > > order9 support huge mapping, but order0 not.
> > > > > with the patch above, would call vmap_small_pages_range_noflush() and do normal
> > > > > mapping, the huge mapping would not exist.
> > > > >
> > > > > >  mm/mm_init.c <<alloc_large_system_hash>>
> > > > > >  table = vmalloc_huge(size, gfp_flags);
> > > > > >  net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
> > > > > >  new_hashinfo->ehash = vmalloc_huge(ehash_entries * sizeof(struct inet_ehash_bucket),
> > > > > >  net/ipv4/udp.c <<udp_pernet_table_alloc>>
> > > > > >  udptable->hash = vmalloc_huge(hash_entries * 2 * sizeof(struct udp_hslot)
> > > > > >
> > > > > > Maybe we should add code comment or document to notice people that the
> > > > > > contiguous physical pages are not guaranteed for vmalloc_huge() if you
> > > > > > use it after boot.
> > > > > >
> > > > > > >
> > > > > > > IMO, the draft can fix the current issue, it also does not have significant side
> > > > > > > effects. Barry, what do you think about this patch? If you think it's okay,
> > > > > > > I will split this patch into two: one to remove the VM_ALLOW_HUGE_VMAP and the
> > > > > > > other to address the current mapping issue.
> > > > > > >
> > > > > > > --
> > > > > > > help you, help me,
> > > > > > > Hailong.
> > > > > > >
> > > > > >
> > > > > >
> > > > I check the code, the issue only happen in gfp_mask with __GFP_NOFAIL and
> > > > fallback to order 0, actuaally without this commit
> > > > e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> > > > if __vmalloc_area_node allocation failed, it will goto fail and try order-0.
> > > >
> > > > fail:
> > > >         if (shift > PAGE_SHIFT) {
> > > >                 shift = PAGE_SHIFT;
> > > >                 align = real_align;
> > > >                 size = real_size;
> > > >                 goto again;
> > > >         }
> > > >
> > > > So do we really need fallback to order-0 if nofail?
> > >
> > > Good catch, this is what I missed. I feel we can revert Michal's fix.
> > > And just remove __GFP_NOFAIL bit when we are still allocating
> > > by high-order. When "goto again" happens, we will allocate by
> > > order-0, in this case, we keep the __GFP_NOFAIL.
> >
> > With Michal's patch, the fallback will be able to satisfy the allocation
> > for nofail case because it fallback to 0-order plus __GFP_NOFAIL. The
>
> Hi Baoquan:
>
> int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> 		pgprot_t prot, struct page **pages, unsigned int page_shift)
> {
> 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
>
> 	WARN_ON(page_shift < PAGE_SHIFT);
>
> 	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> 			page_shift == PAGE_SHIFT)
> 		return vmap_small_pages_range_noflush(addr, end, prot, pages);
>
> 	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {  ---> huge mapping
> 		int err;
>
> 		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
> 					page_to_phys(pages[i]), prot, ---------> incorrect mapping would occur here if nofail and fallback to order0
> 					page_shift);
> 		if (err)
> 			return err;
>
> 		addr += 1UL << page_shift;
> 	}
Sorry, I missunderstand.
>
> 	return 0;
> }
> > 'if (shift > PAGE_SHIFT)' conditional checking and handling may be
> > problemtic since it could jump to fail becuase vmap_pages_range()
> > invocation failed, or partially allocate huge parges and break down,
> > then it will ignore the already allocated pages, and do all the thing again.
> >
> > The only thing 'if (shift > PAGE_SHIFT)' checking and handling makes
> > sense is it fallback to the real_size and real_align. BUT we need handle
> > the fail separately, e.g
> > 1)__get_vm_area_node() failed;
> > 2)vm_area_alloc_pages() failed when shift > PAGE_SHIFT and non-nofail;
> > 3)vmap_pages_range() failed;

Right, this might run twice. But it also have a negative effect here,
__get_vm_area_node & vm_area_alloc_pages may waste vmap space and pages.
Actually if we fallback to order0, we don't need to aligh to PMD_SIZE.

> >
> > Honestly, I didn't see where the nofail is mishandled, could you point
> > it out specifically? I could miss it.

> >
> > Thanks
> > Baoquan
> >
>
> --
> help you, help me,
> Hailong.
>

--
help you, help me,
Hailong.


Return-Path: <linux-kernel+bounces-262450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE793C748
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DB91F21512
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5A19DF72;
	Thu, 25 Jul 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="D4WJd17M"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE119D082
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925609; cv=fail; b=aspdKS+ekxGs08g5SmCi3blKIPlAWMW/b0iOsNpHEGpi6bR0RO0FZ/iPQ9W+jyoUBaA4mfIXaizorLVoQdHV5SFYIRXT1zegi1+4M3FE3MIzTLmZ0zshlBKS221eMPNZ+em3kCd1nngkh0p3XcZXKkxZtxzR+/BFheYawR50Fuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925609; c=relaxed/simple;
	bh=xV2OwNFOIcpZhTwmxzJstELeAbjRI5IsLCt/XG08X1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R97TAaevnRQ9B5gZpwVAOuwrJFH7lPSlpldp2hpNdhw0COPHlFrq3+O10BKevB8IIjG9wGKhcMqa5w3RlMkfMeeIkL3Ii/C4fvp3V8Se/jWtosAAnT0/7oAr0PUwDn4jqni0PhGVk0eUThpTpB6KTBXd5dSMzuJd4DnRsWaaJfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=D4WJd17M; arc=fail smtp.client-ip=40.107.215.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKy3aaR5XPhPu3lk9lNqibOWID57UD9olXkri0rFJuY5eSSaJADgL6gKeidNWTWSq+qCsLx/DvziJWFiIB2EOxa29JXuQJsDHTMikpRTCni8CZT2yeBc7trqBm59se+uRKTCGUWy86TBxv6Arj48g2rwDv6e5fyKxSM7yqinWlontMveP6rfLOZsa92TpcMXNQT37mNBZqzEQYm2wwjTvXuNIuSZgEoxY+fR6+iPgClTYD5DwQaGOv9Q+yT/nu3xcENFqnHs1QAGCAiwpYvdEXVffOa9MncoW8GTFWvZvJaiDYh+nEsIVQba6BaX52WudS4Q6CsYitafqEpDN1FKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o78vdk7elYj6Cu2loA4EQA0d2AsvrMwsjSF2eu/ieIg=;
 b=UAnSfpZPoy7UVxXT+3Ezh8mZ1+K4qq9clOuDwVAIkajsMgndOqY0CPMwDPaur875axN3kRdg40PRB7tFBDoGyh7yAZxjsddW1qwRTLfpEJmOG1z/i5KAaCa2JGi0K54W8B7HSBI7LC86ucrs3dB8NneO8uIBfsKv30rVNFeJ6fXifAa4ycF7ChQnkPhC56ZrzJVyQmD/fGScY3nQtB9y5yQlYqLijIQIcMv/KqRYRRxwbkgmLiv/yhje243xpUp1YEpFWuiGL88EYKyBGZgKAf6HG45/HQc2wvXU8WUVwKqMlyfRzT2B1XaLp7UOrYckf8zYWX7QlG6YjPpn1dcZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o78vdk7elYj6Cu2loA4EQA0d2AsvrMwsjSF2eu/ieIg=;
 b=D4WJd17MHi1PNtNeBed62SolF4NZNQdxVY0Dvu+LSynwFt3CPuDnupQUhl5VQmNbLue+LLD1McjuFlxuV/NkNR+wAUW7mZ+Ib49EfrL7Du+PvTdXKGAO3GDwOlRIKRbnfQLOiySArQ1K0dhcPQa7vMvg/epVQaJ62SoNthnLJsc=
Received: from SG2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:4:54::34) by
 JH0PR02MB7334.apcprd02.prod.outlook.com (2603:1096:990:71::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Thu, 25 Jul 2024 16:40:04 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:54:cafe::2b) by SG2PR02CA0070.outlook.office365.com
 (2603:1096:4:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 16:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 16:40:04 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 00:40:03 +0800
Date: Fri, 26 Jul 2024 00:40:03 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Baoquan He <bhe@redhat.com>, Barry Song <21cnbao@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
	<mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, Tangquan Zheng
	<zhengtangquan@oppo.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <20240725164003.ft6huabwa5dqoy2g@oppo.com>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|JH0PR02MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: f316e0d6-e965-4153-82e1-08dcacc86f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GkJAl4zpU3eTJSD8yLMtJ8Q0Xlp8oCsgPOjU7/R2+7ktVEaje0fmfOulAzxx?=
 =?us-ascii?Q?H0yi+ZcQl5NMqKOO0pbcXgRfOmw9DoJOEQU17p/FVSgFdJ89s3sH/DDEPuqs?=
 =?us-ascii?Q?sosAfbN8f+O7aN0IYlCcAvNpSP2CUIXOmb4hKIV9XjIxoY7nWpTO1A5d1BWh?=
 =?us-ascii?Q?nW8rKKHL+9Aqljp/umhrbVVygcp90JRdGryogns5pwstVpmHvelhweiZgEik?=
 =?us-ascii?Q?rxbiJ0kXh2ofH1lwmmdC5vddavdtucLRZzjmQO759ZahBcTswpLAgYVigA9/?=
 =?us-ascii?Q?XO76BQBY496dACjxxEcpjwzeCN+RG0tr/854hXQHln51QDjf1CiOIJwIdF5u?=
 =?us-ascii?Q?3hTniyIeUFS8/6U231cQwN+4kD237YYNYBp9rsay2bjS2IUd+BTB5Y4KI55p?=
 =?us-ascii?Q?PANa9EEqxS80TIjkJehdFaMnT21w9PeJbS1eyfLM4Gyx0ml+KDQdmvJwXq9z?=
 =?us-ascii?Q?HCrsA09ZlhWISQG7IhtgcfZfLswypfz9XZGTJ6Sn1gQm/8oDKFDayHgugrse?=
 =?us-ascii?Q?4xsrD8CTvNwY9KZSM0zJobQSyQQzYvSHxPV6Ph/DYNQiM5PBQkgwNOIA2n5W?=
 =?us-ascii?Q?YImOL+ViLpKqVk9ngJgvXPqdz2s1WFCUoJYv6aWq0jciSrJ/RgYVyILxAxxg?=
 =?us-ascii?Q?HOqo/pAsRoVCiQ05RRVQ8GBaRCDsUsxSAc9ns2bzKNXFBHGY+Ydr6sWEoVoE?=
 =?us-ascii?Q?IQqbfG2NQ2nXaUwsh+EQ2AOvUs/pBrRzH6qkD2dh8dsIjh5D4SplHVv1WOC0?=
 =?us-ascii?Q?CGo1FsUAGW19McUxSD99EG7hfQb6o5QHetNO6Gaq9GL7ybEatkgsNXrtCiu+?=
 =?us-ascii?Q?IIyxv9kb8lr5aF1dNIP1SZtvSgNOdP0+ieHRQfko5DCMsxDYAurkiduwg1kw?=
 =?us-ascii?Q?6/3/Uw5WmtxwRkf0yW8V2AjLk+fo2NYfOmnFRrcxdSgjlqP0tpyYHb4+RBrr?=
 =?us-ascii?Q?W/D18a8a3xcgGSvn2X+Sv42lvQHL5r25k4Tf6pBwh8n58KpLqw5DIqA/fGi8?=
 =?us-ascii?Q?9/eGWuN++o/29+mzt3663RteQugxnmzJgHJ18shkzRllepjXqVYdZExDHPqi?=
 =?us-ascii?Q?IhltBmS6TEk6H9P+/j2NZEM7imde5LAtNvcebw2Av+DJQ35O94Dwr1sniPgA?=
 =?us-ascii?Q?/+z2/bA3OI5LOlNjdREL2drw9G5LDMFZc2BM73Ci6iDm0H5cuPSkRF9nCNlO?=
 =?us-ascii?Q?G0zPikOH5+y4IwW/KY71OjKVxrAwWAGJUTkIe9xu/1xp5KvK5i35aQdno2Rn?=
 =?us-ascii?Q?5Xm2XltxCbFeddPMZATdM/1WaDj2cBT6VrQkTQjAgqgdwy9ESLS3z66NMKG+?=
 =?us-ascii?Q?imli1cyA41o7Xx+zCoUCx7D81B05UMQEXaxGD1vI5uJ07fKhh/3BFfhkmT5H?=
 =?us-ascii?Q?kZ+oqHUz0mF9lWscYc0CXX/IK7brSb5MWlMCpRE/2j9cleFzWibTb5DvtvPT?=
 =?us-ascii?Q?2H+UQgo8O4NJRK3IwQ4xIRlHafmADCBJ?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 16:40:04.1820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f316e0d6-e965-4153-82e1-08dcacc86f71
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7334

On Thu, 25. Jul 19:39, Baoquan He wrote:
> On 07/25/24 at 11:53am, hailong.liu@oppo.com wrote:
> > From: "Hailong.Liu" <hailong.liu@oppo.com>
> >
> > The scenario where the issue occurs is as follows:
> > CONFIG: vmap_allow_huge = true && 2M is for PMD_SIZE
> > kvmalloc(2M, __GFP_NOFAIL|GFP_XXX)
> >     __vmalloc_node_range(vm_flags=VM_ALLOW_HUGE_VMAP)
> >         vm_area_alloc_pages(order=9) --->allocs order9 failed and fallback to order0
> >                                         and phys_addr is aligned with PMD_SIZE
> >             vmap_pages_range
> >                 vmap_pages_range_noflush
> >                     __vmap_pages_range_noflush(page_shift = 21) ----> incorrect vmap *huge* here
> >
> > In fact, as long as page_shift is not equal to PAGE_SHIFT, there
> > might be issues with the __vmap_pages_range_noflush().
> >
> > The patch also remove VM_ALLOW_HUGE_VMAP in kvmalloc_node(), There
> > are several reasons for this:
> > - This increases memory footprint because ALIGNMENT.
> > - This increases the likelihood of kvmalloc allocation failures.
> > - Without this it fixes the origin issue of kvmalloc with __GFP_NOFAIL may return NULL.
> > Besides if drivers want to vmap huge, user vmalloc_huge instead.
>
> Seem there are two issues you are folding into one patch:
Got it. I will separate in the next version.

>
> one is the wrong informatin passed into __vmap_pages_range_noflush();
> the other is you want to take off VM_ALLOW_HUGE_VMAP on kvmalloc().
>
> About the 1st one, do you think below draft is OK to you?
>
> Pass out the fall back order and adjust the order and shift for later
> usage, mainly for vmap_pages_range().
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 260897b21b11..5ee9ae518f3d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3508,9 +3508,9 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
>
>  static inline unsigned int
>  vm_area_alloc_pages(gfp_t gfp, int nid,
> -		unsigned int order, unsigned int nr_pages, struct page **pages)
> +		unsigned int *page_order, unsigned int nr_pages, struct page **pages)
>  {
> -	unsigned int nr_allocated = 0;
> +	unsigned int nr_allocated = 0, order = *page_order;
>  	gfp_t alloc_gfp = gfp;
>  	bool nofail = gfp & __GFP_NOFAIL;
>  	struct page *page;
> @@ -3611,6 +3611,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		cond_resched();
>  		nr_allocated += 1U << order;
>  	}
> +	*page_order = order;
>
>  	return nr_allocated;
>  }
> @@ -3654,7 +3655,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	page_order = vm_area_page_order(area);
>
>  	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> -		node, page_order, nr_small_pages, area->pages);
> +		node, &page_order, nr_small_pages, area->pages);
>
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
>  	if (gfp_mask & __GFP_ACCOUNT) {
> @@ -3686,6 +3687,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		goto fail;
>  	}
>
> +
> +	set_vm_area_page_order(area, page_order);
> +	page_shift = page_order + PAGE_SHIFT;
> +
>  	/*
>  	 * page tables allocations ignore external gfp mask, enforce it
>  	 * by the scope API
>
The logic of this patch is somewhat similar to my first one. If high order
allocation fails, it will go normal mapping.

However I also save the fallback position. The ones before this position are
used for huge mapping, the ones >= position for normal mapping as Barry said.
"support the combination of PMD and PTE mapping". this  will take some
times as it needs to address the corner cases and do some tests.

IMO, the draft can fix the current issue, it also does not have significant side
effects. Barry, what do you think about this patch? If you think it's okay,
I will split this patch into two: one to remove the VM_ALLOW_HUGE_VMAP and the
other to address the current mapping issue.

--
help you, help me,
Hailong.


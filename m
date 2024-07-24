Return-Path: <linux-kernel+bounces-261390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9293B6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078AF1F21146
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EEC16B3B8;
	Wed, 24 Jul 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="jmQ1YEoJ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2089.outbound.protection.outlook.com [40.107.215.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884016A955
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845722; cv=fail; b=o4gZ7iLbNhMRBFauHKd1y8VjA9DbGFJx83WKY7dUfv6gROFq3jySKbQMsa2lJQaRnwUtgS4xLLww0Cw902ZEQ+oAcwpps+znRVgRZv4rd2eUHAXIVQHugOt3xzo3YdhpTfcTmn8I4S8zvmSgZrMkFgBVVp7oHTiTtMWrxADDrqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845722; c=relaxed/simple;
	bh=zSOv1GdyCrbHZ1Q81/2Ni5Xv+zQxvi04rnNS/9UyCU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+NboNh4yiMBEP9tLxyBP7u4UxLoytkQtB1jHj//nV3Q/yT24KllW67WHwXuc7I3EDju73UAUPtu4URG7anzMIqbcNZJJdxXweDBtFjEcnYWe6BScJW4u97EYjS1hXZZoaZAa8QvAqamMHVVvNnBCSNGblZHuVsYIxci2apu3ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=jmQ1YEoJ; arc=fail smtp.client-ip=40.107.215.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnASu0ojR4E1urG5zdCgx30ZLRZD71EE/ulefX1Q/TFS6NsCx4c3zA3HfB+mLpL2nlPFNl5FrgUTcf7WLd3Ic5tZfv0LGuUKLs+vYRT1ZZuRuzTBpfPcYlrR+7+oqY7F6BAH/gUrfN7rGojKxRQJqVnn5lc54jq051tYQoqr+3RXWY9/Bu9Vq5Bs5JNhqeWCKgVLWnYbtMs3XJTji9y6uQRyUOqDTpR6tESDIQVqLXrFczuBOmOXvFduzCS/NodgbZubGAbpUmAFg+8PttorYPuKHO+kVP3Cn38ygamPA0jT5JILlnzG3IWxretfP3vEvx3mPjs0rsn2odIoMXIgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPtU3HLcrmbARxN8wvJoxrgVPPrInk57j6sq96cRong=;
 b=SDznoeLPYJO0zXiLY3Mm4w6srBTD9Pndt803NLcvjEApf9DJBGoqtNKftbzTKM949cwtxXUfF4MQkLsUjx0cg7S/eKCDRpaUJG+MUF1L4mK20vzdSVR752g+OmVA+lSaSuY+OmEzJxuxgr+vhDIePc6cX1AKOEVEXMM+c9vX1y67mfk37SANrNEjy4goTojbd2mKzaXwW9Pl8JlsWNz6cOkMZVqIzIKf8lHwk24R1KTn2BEoFnZ3fXuh0oy1BMqCTkgCOO8kRMaZRxC0peJa4OVHlVoBKR16TrSTZT6EcwaVIHN0JerxLIdvf2u8DoGLZ9YJQrSdBgqz1JZ2Omry/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPtU3HLcrmbARxN8wvJoxrgVPPrInk57j6sq96cRong=;
 b=jmQ1YEoJ8o7TP+i9e34VT42jWt9s4kAaiEvrKszxACSDnVzhuoRyENUVBumUu00aY7O2KmRCUT9u4l2cjRE/i8vetqZ7Smt4YrkXeoEEyduTrE586zEazY/uMQuzeb81txwEh+OrzGhdRa6G5xS9H9NG82ZM7s7Ee6rQFtnzMqI=
Received: from SI2PR06CA0017.apcprd06.prod.outlook.com (2603:1096:4:186::15)
 by PUZPR02MB6288.apcprd02.prod.outlook.com (2603:1096:301:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 24 Jul
 2024 18:28:34 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:4:186:cafe::62) by SI2PR06CA0017.outlook.office365.com
 (2603:1096:4:186::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Wed, 24 Jul 2024 18:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 18:28:33 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 02:28:32 +0800
Date: Thu, 25 Jul 2024 02:28:27 +0800
From: Hailong.Liu <hailong.liu@oppo.com>
To: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
	<mhocko@suse.com>
CC: Barry Song <21cnbao@gmail.com>, "Tangquan . Zheng"
	<zhengtangquan@oppo.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <20240724182827.nlgdckimtg2gwns5@oppo.com>
References: <20240724181916.31776-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240724181916.31776-1-hailong.liu@oppo.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|PUZPR02MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: bace865b-94c6-4ddd-403a-08dcac0e6cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J0CckuhFKnIcB65id4JxjoaNrRirKGYmdFInw28kwyOJ56iLjWx0AnXMkNBo?=
 =?us-ascii?Q?3CUu/qsrYSZYvjecShG+6nTsSbWicxV7a9h4Xoh4rdMv4llN11mpovzJV7J+?=
 =?us-ascii?Q?MAraUPTKailxHIGEAB6OItshT0LhSXLfalZpjq1EfUXKlNwwMnwTKK15+o/y?=
 =?us-ascii?Q?FvF4UZxFsXv0RFvTGrSDCUC8SGSv4JnEUXv9gIssVVSI9ZhL09rOHhFMj7rq?=
 =?us-ascii?Q?0JZu4pmeB8VenekXmwEbdgvMGeOLRZ+33oDM4YmhfxOCHc/qiZ6TRELqQNmx?=
 =?us-ascii?Q?Am1Bq+/DQz6dB/ejhutxjQIAsxj/a/UHDb/XtT++e+iYNZqAnM6JEpGx+vBm?=
 =?us-ascii?Q?eo39P2KZKlXp7BLlUMRrs61WOMtOl284jjfkOXSIlwMe8rLvSAmQsHP8H31T?=
 =?us-ascii?Q?5TSPQAkH5uPv9MxpCksWoAi9q6eWDjItJvhLFSkJzwdBR4CtiO+soNXnQ065?=
 =?us-ascii?Q?FhsaESuwLqb87WN8Yll/kApzljl+HJiD837nRGvdnSnKrJYUcUY8dLSj9gBl?=
 =?us-ascii?Q?gOPJ5fxV7nEmRSN9TZpCSqgfqA5Btil6yY3YnjKjc5hpeyEBb380F4F1QJgq?=
 =?us-ascii?Q?j3cMlujomuQeCWcBC9lbznEbhxW++CDIUXI/Fk1Unz7gUpiB8thDvbfe2JZW?=
 =?us-ascii?Q?GLATkcTh5HB+x5Z6W1Qe4bJdERkmRGTSleYfJM+rxUQaJ9hTHBVQFsN+yeqd?=
 =?us-ascii?Q?TPww+PtQMM6gembWBfhk29JP3C3rWsyR1kgEMJ1Z6yXfFvM3+lBBo1IJUWyE?=
 =?us-ascii?Q?tyc4oZdiJJ2u4uS7tnPdVPJZu6PSkynpEcTyv1i0V4bkpPMHVdCxQV69EAa2?=
 =?us-ascii?Q?RJPdjm7orF0cfDjyvoo4VWHid2D1VlpYfoXpZgJCjmtzb7OGn1gBseKkO9Wq?=
 =?us-ascii?Q?awgwWncvVQWy917a7jvFwzPhyt7sqQwa+/6Ji1OXaFfuQ9ad/CoSFSCzTfro?=
 =?us-ascii?Q?x5Sx97Sb9iWLCSVixIGUZMwkFfytE/ogzLGoBQ4S/74GMMNo343DaY6kspKB?=
 =?us-ascii?Q?LxlKIAnJo/auGjn1AX/bjmftyIupc7gQT5nYrUY+Jnc6Bm2XKj2otswXkH8g?=
 =?us-ascii?Q?nGnrDxfBxe403dhYaiD5m28aZRWIuUs+lO2yP9xahtd0dnj2aYEmM22H6IF7?=
 =?us-ascii?Q?Uo6ftVWQMTSDeZGY0k0X7H/r1D4hepkWdVg4MXKMJQ0epnqjCACZwnjqyI5c?=
 =?us-ascii?Q?0WdY7eXrqXBqe9JpVkB2FzWo/yDJyO51jaW20yqS37P0wRDo5lOcTmLZlIk8?=
 =?us-ascii?Q?B+nFwXeziI19E5XkTChwDWWdccJJHwUBs2pJ1Rcq0gtz89TZTeM2yyTjtjp3?=
 =?us-ascii?Q?fKy69WHUagJx7S2d0SNKWFRtI86kX/WT7TTufOeH4gyYbIn3c9gt6TcfC/Fc?=
 =?us-ascii?Q?ConcHcUafphf/nTmw/fSRXGb4BdlenvWGK1SPGkSDkcPRiHsDGHcN+P6lU7N?=
 =?us-ascii?Q?fMC+i5USD1ZjaeLcXdPAUwXW2dP9Q5lp?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:28:33.5605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bace865b-94c6-4ddd-403a-08dcac0e6cf3
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6288

On Thu, 25. Jul 02:19, hailong.liu@oppo.com wrote:
> From: "Hailong.Liu" <hailong.liu@oppo.com>
>
> The scenario where the issue occurs is as follows:
> CONFIG: vmap_allow_huge = true && 2M is for PMD_SIZE
> kvmalloc(2M)
>     __vmalloc_node_range(vm_flags=VM_ALLOW_HUGE_VMAP)
>         vm_area_alloc_pages(order=9) --->allocs order9 failed and fallback to order0
>                                         and phys_addr is aligned with PMD_SIZE
>             vmap_pages_range
>                 vmap_pages_range_noflush
>                     __vmap_pages_range_noflush(page_shift = 21) ----> incorrect vmap *huge* here
>
> Fix it by introducing VM_AREA_ALLOC_PAGES_FALLBACK in page->private if fallback to 0.
> Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
>
> CC: Barry Song <21cnbao@gmail.com>
> Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> ---
>  mm/vmalloc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 03c78fae06f3..b35dfd3eeee3 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -75,6 +75,8 @@ early_param("nohugevmalloc", set_nohugevmalloc);
>  static const bool vmap_allow_huge = false;
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
>
> +#define VM_AREA_ALLOC_PAGES_FALLBACK 0x1
> +
>  bool is_vmalloc_addr(const void *x)
>  {
>  	unsigned long addr = (unsigned long)kasan_reset_tag(x);
> @@ -604,8 +606,13 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>  	WARN_ON(page_shift < PAGE_SHIFT);
>
>  	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> -			page_shift == PAGE_SHIFT)
> -		return vmap_small_pages_range_noflush(addr, end, prot, pages);
> +			page_shift == PAGE_SHIFT ||
> +			page_private(pages[0]) == VM_AREA_ALLOC_PAGES_FALLBACK) {
> +		int ret = vmap_small_pages_range_noflush(addr, end, prot, pages);
> +
> +		set_page_private(pages[0], 0);
> +		return ret;
> +	}
>
>  	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
>  		int err;
> @@ -3583,6 +3590,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>
>  			/* fall back to the zero order allocations */
>  			alloc_gfp |= __GFP_NOFAIL;
> +			fallback = true;
Sry for my mistake, I forget define fallback here.
BTW, This is not the optimal solution. Does anyone have a better idea? Glad to
hear:)
>  			order = 0;
>  			continue;
>  		}
> @@ -3608,6 +3616,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		cond_resched();
>  		nr_allocated += 1U << order;
>  	}
> +	if (nr_allocated && fallback)
> +		set_page_private(pages[0], VM_AREA_ALLOC_PAGES_FALLBACK);
>
>  	return nr_allocated;
>  }
> --
> 2.34.1
>

--
help you, help me,
Hailong.


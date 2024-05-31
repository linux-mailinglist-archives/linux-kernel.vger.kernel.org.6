Return-Path: <linux-kernel+bounces-196136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B98D57BF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285CCB26052
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F905848D;
	Fri, 31 May 2024 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="gavwqSWl"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2074.outbound.protection.outlook.com [40.107.255.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D7C156
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118849; cv=fail; b=SOGuT3KYo77C8EFilGPEhFGL/7n/ybTrIKffaJboi2y4WGGBNFDEMZ+cWtgfv6QRg6PE8HpZjiBIdZx4a7IRuglBi//o6WRI60ek3BjTL5bMJt0qLtqSddRm+7QVNAWrdBWoXIYz2IZ3ip7t8Kp0y0xACQBqrsMn0X7HXD0c68Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118849; c=relaxed/simple;
	bh=eKKIPp6Uw9pY9r2kAGmZbN8uNgDtt6Vj0p+LcyIBy3A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKP71ZMFmjyvYBg0GCF5ITipSXx2gugenflKuXnhFff7NEEqxzcbsk1FEZvHSGQA9l7E2bTB98fo3WK3Kc3joQnMU7eR0WW1A4cjaAO9JRodNFId11cE3mj5Lx9HY6U+wWPavoV57UD3HPM02+frq+hdEYi5G7k2OaTHCYVTm0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=gavwqSWl; arc=fail smtp.client-ip=40.107.255.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tti8xW1BsKcjz2nSpibaTV7mrFW8c5wxwpZDa7COGAUySDsJe0O8xb9xDxflTFV66AnuxGeYlmWVB4w0JxJnvJbDRfAzkrNyvNOugIdKMK4+4QAD/XANRUl9DJXWwCW57siYg0vuuDImdinle3tG8KUa0TmUJP9dk+Gi510xr/6zHJSwuHgClw5eVsptD4J2sHtfXpq/nKHQbGPLB+Eguu8T5Hd0fkxiXjqB+d3/exzS2p5DdGUCfwNRGx/XEx4ZtYNjm4aeWKGOHMvaCAhNm9SJBsCTPh+gVWaR3WJL8RSQRKdeNTdQzZIDt012NY/HQqLzcDqoU1HoL6p2t8+ezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0Ki4pZI9xDSsPn6vqaVovxDtBvF8cge3SmtC4lIyEE=;
 b=SFoSvlpaZaV9t16VQvieyJ4cUYAGYpWfkIBd+Jy2HCEnfFMSQ8u1Ks4Pj4SXsNRReSCkYK2cqCIP+ViDQiGs9t2vo4Vy+l/X/b6lXvi2jSlYqyP0USzDQ0unCJFF7PzuJmrZTPgDeEJOxi32oKAx3rjy5J+cO//3zGXNywI7Biww5STUEzrwf744rfYZDYNsazgNZTGw9663E2I89rebdZ0Y6GnTMsLUBSZIDSczN9Ax/+TpgbM5Q/2epMtD23XSwjo0OrAEuEeHu+n/spYTsLwY3n7jGhCukv0fbH+95nmaFLyy+reZK9sbuwKgM++TWTmUofMbIuJJdyxZkPBJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=unisoc.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Ki4pZI9xDSsPn6vqaVovxDtBvF8cge3SmtC4lIyEE=;
 b=gavwqSWlP1Wtyv3n3eBsYRk/cbCM2/sUkmnULhmp2hFOJf2x4a23ac1606MDwaWBkNo0QlxdpNafyjb5izYE48GTp1RZOnffqK9vLZc5HMoEVZu4CN52LFz30M3eSFovdmWe/uaOUZdICKBQTb+IgCg44QvERthSZRksnSsEjl4=
Received: from PS2PR04CA0013.apcprd04.prod.outlook.com (2603:1096:300:55::25)
 by JH0PR02MB6869.apcprd02.prod.outlook.com (2603:1096:990:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 01:27:20 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:300:55:cafe::ac) by PS2PR04CA0013.outlook.office365.com
 (2603:1096:300:55::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23 via Frontend
 Transport; Fri, 31 May 2024 01:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 01:27:19 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 May
 2024 09:27:18 +0800
Date: Fri, 31 May 2024 09:27:18 +0800
From: hailong liu <hailong.liu@oppo.com>
To: zhaoyang.huang <zhaoyang.huang@unisoc.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: Re: [PATCHv2] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <20240531012718.ogitylhpsrrvvczo@oppo.com>
References: <20240531005007.1600287-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240531005007.1600287-1-zhaoyang.huang@unisoc.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|JH0PR02MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d782c7f-d592-44fa-6f3f-08dc8110d093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X6x/HTouiH88Od/MR30Q+4TjTGu1hgP/HlRxrfcQ4IWeHAMIjhYgDl7RPI8p?=
 =?us-ascii?Q?l7hj4T0PgMQq7BhA9OZuJx5AjK1u7hIb1eAUh5a/JgLN9dFZQLtKEcMsNPnx?=
 =?us-ascii?Q?KX/IbOyUJY+Yxho38E/9VYA9Pn3noHjrxPytGXu4FXnAqMKmhQ/x2EgxxcPZ?=
 =?us-ascii?Q?PpQok+eAnVYLpbLAjy6MDfNWNXL7U5SPqEWXTKJm0gw1xFqt7CqxRXU9k7c6?=
 =?us-ascii?Q?pRDucKPRRUKGfOXCblkEoo0tujAZr+Fk/RsJjEXep8XJJyZzw3aPJdplIFeb?=
 =?us-ascii?Q?e7iTGmQ3Jn9ZXRRU/dTOtGXKOXf+NTP5+ezPBdMDMn5/y8bNEb7w9W//kz3h?=
 =?us-ascii?Q?zy/woXwUunnyTjyYB0Jpw4tgc/gkJW0jlJn106mORiouMC0pc0ePO6SBbSYC?=
 =?us-ascii?Q?bBEnD1t97Ahy2BP6oMl08PorQYe8YqyqsQVZ46tHy4wRuDcqnXTl1W/EhdNh?=
 =?us-ascii?Q?OYD5JizegbbuEf16QMj0fwEaWuLDDvlpMF5IH2D2w/xCylLaNmD7aYpdou8t?=
 =?us-ascii?Q?4RnlL7fgw7qFowxkrLDcQeDVxsQ1sYetgnM/hWWKwzvwi55pTZZrvXf/+3VJ?=
 =?us-ascii?Q?YYFgsof6PbofuOCSDALMARoZoaMnaYQqchgFyeJoIBKF7/XagIrxDp8Jf+nx?=
 =?us-ascii?Q?+zUkLWymxNylYY6sdcrcPALn5xoT+LGhW/sktOWXZjHB0MFs2ShHI34DCck1?=
 =?us-ascii?Q?DM0q7FrgyGmzkegvP5QQmtl/wv3mClg2pyhoV4wJgpi9OsFZzv8R+F84BUa1?=
 =?us-ascii?Q?SGkeRrpJ7/uqXiniT5kJ6zYW6Jh9FWNm+XjxMmLi1LWCyNwI5DMj/GRQgOXi?=
 =?us-ascii?Q?NS4F6p5T5paEBLM7C5tpv8YbsqTU5+TcRaLLbUJxHv9xQUPlnsk89Ho20o7s?=
 =?us-ascii?Q?8SZOg6Nj5RoHaivX2oe1koh0So4l42gAmF+J3kYooI7HOXLvIpH7lwQNw8jz?=
 =?us-ascii?Q?VsRmgC2Wx/iLfGeEt/r05Pw3p5fSQ80dhhy2MjmTAWebUS8Us5flokyz2FwI?=
 =?us-ascii?Q?jcE44AySMOm+ZHTee3qJ5ABP8pVCvHK34bGE1h7gwJZC7yVbjmPMJCgst1us?=
 =?us-ascii?Q?7IibCjq90BfGUtw+YpE35t8Sdt/Q5cLVSvgXbCyRSkikkvhrcLTY/xAwdL8D?=
 =?us-ascii?Q?0cVDbqjwerrrl7CNtY62xMnQVqsP9c9CdNTNV59wFy1iEh5NRUMkvT4sfmvx?=
 =?us-ascii?Q?2itdi8J0WACrHtPlqMr6jJWkUY1lVYUSdTXQuJMXznaOTmnvikFW6S0xnHYL?=
 =?us-ascii?Q?2g74Y4s2OJoouDjGsNflWEzTsVbrhnaCe/RhOiW7tSDeMu/mO/MZA1lDP/98?=
 =?us-ascii?Q?KYsyELSCk7u78UIm+xKWWf0SxT9Q6nWk/hGBpFbNBpyIEGAchX/FHWDo6Hal?=
 =?us-ascii?Q?bmQ0hQD8ZagOHPYkDEtRMuqwDztw?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 01:27:19.6832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d782c7f-d592-44fa-6f3f-08dc8110d093
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6869

On Fri, 31. May 08:50, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> vmalloc area runs out in our ARM64 system during an erofs test as
> vm_map_ram failed[1]. By following the debug log, we find that
> vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> when vbq->free->next points to vbq->free. That is to say, 65536 times
> of page fault after the list's broken will run out of the whole
> vmalloc area. This should be introduced by one vbq->free->next point to
> vbq->free which makes list_for_each_entry_rcu can not iterate the list
> and find the BUG.
>
> [1]
> PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
>  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
>  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
>  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
>  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
>  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
>  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
>  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
>  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
>  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
>  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
>
> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: introduce cpu in vmap_block to record the right CPU number
> ---
> ---
>  mm/vmalloc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..ca962b554fa0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2458,6 +2458,7 @@ struct vmap_block {
>  	struct list_head free_list;
>  	struct rcu_head rcu_head;
>  	struct list_head purge;
> +	unsigned int cpu;
>  };
>
>  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> @@ -2574,6 +2575,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	vb->dirty = 0;
>  	vb->dirty_min = VMAP_BBMAP_BITS;
>  	vb->dirty_max = 0;
if task migration to other CPU at this time, this may lead to get incorrect vbq.
> +	vb->cpu = smp_processor_id();
>  	bitmap_set(vb->used_map, 0, (1UL << order));
>  	INIT_LIST_HEAD(&vb->free_list);
>
> @@ -2614,9 +2616,10 @@ static void free_vmap_block(struct vmap_block *vb)
>  }
>
>  static bool purge_fragmented_block(struct vmap_block *vb,
> -		struct vmap_block_queue *vbq, struct list_head *purge_list,
> -		bool force_purge)
> +		struct list_head *purge_list, bool force_purge)
>  {
> +	struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, vb->cpu);
> +
>  	if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
>  	    vb->dirty == VMAP_BBMAP_BITS)
>  		return false;
> @@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
>  			continue;
>
>  		spin_lock(&vb->lock);
> -		purge_fragmented_block(vb, vbq, &purge, true);
> +		purge_fragmented_block(vb, &purge, true);
>  		spin_unlock(&vb->lock);
>  	}
>  	rcu_read_unlock();
> @@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
>  			 * not purgeable, check whether there is dirty
>  			 * space to be flushed.
>  			 */
> -			if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
> +			if (!purge_fragmented_block(vb, &purge_list, false) &&
>  			    vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
>  				unsigned long va_start = vb->va->va_start;
>  				unsigned long s, e;
> --
> 2.25.1
>
>

--

Best Regards,
Hailong.


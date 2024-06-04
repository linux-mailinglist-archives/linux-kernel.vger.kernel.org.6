Return-Path: <linux-kernel+bounces-199989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E28FA8DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFAC1C23578
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F013D62B;
	Tue,  4 Jun 2024 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Ra0lCoug"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2049.outbound.protection.outlook.com [40.107.117.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB58C1D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717472997; cv=fail; b=KTS4m8OY0eOGeXrdQ6JXIQSttdL5iNuPYpQdGfKLvzSxp2DWDf9hv6/eAMN9sZY8QyO0Tg6cW61JAYgS1r7z9oON3I/hV5hOQiGIGsenfGDHLgcqvyVW4PkxEFFxDGPgtusJFCWiU2SzbjpxExjJ8xcHaaLoaBHWi48smotgMlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717472997; c=relaxed/simple;
	bh=ZscAbpXuUbT164qecLEZPqi49NFBVZ/EJKBK/+MSE7k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEk42SczAx6NlGhJzJq+K0aO/Y1WUQQKmKQHW4B+cwPfJOTCln9mxwxV80hyDcWlT8kX4s3yDS+Ez6ivFwedxW3I/ofwsFXOgvz+ufBTlj9vnirSJZor/iQdenV3OYhmqLuiauPx5r4JO0yVrp52nTdrvNDIJuL06km7jk4guUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Ra0lCoug; arc=fail smtp.client-ip=40.107.117.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nq8O4UdnEgE02++XZrsAcvyYCL6lG+VN4EqYJtRNPMFA5h3FRKU4uFebr0ZxlCzU2QvHVneAQlPMmkcTUf8sGxg+jEenD66GkG6CK/BsUwyD2N+ZWSOBVzxHYrlwjSiSFLz6kHSIyX1G9R+zCoODQaItRKgytuc/jsmcJmGl30UhRjPweK+Of/fLwQ8heWefR8WArS2vjL9/uWmtX5Oi4OBQMtTSxsQJu//FX+ZZTIkF63Ro2U1bHbLmA80Ql80mT3Oj7x2jnaT53QX3p7Q44ZCZtcUmNBYGiw0PueqkNms5h0Jh1pi2b2weR+Xrjg5oTd++UY/XZFXB4BuLivtQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K0tSdYnCEfkwYgUEGEhhrQrk0tlXhoqej1xccMl7/w=;
 b=C16OB3lS9n+JPUBS+nYD7AW3bxKHRyAHgG0J0uAqPTE6HmdQloPtuuQy1Ix+JeOKO39u8ijGNwKAB0tw3oYISjt/3Z1ZJMQJby2cIdOuaKC1nKwKyiqOP4yCTTR4+keZNM8X03AI3a3p3zYKvLmnBN2Ch1aXS2bFIb54jhozLFVFAQNhi/g3Mw1g0TS7lYbJ3Xl747dzrXIJ0TfgkSDgIO46A1O/ZmRq6OkqcUBBNtNUMP1YB/ej1GXLadwz7P0jXSZ7yp8KvL1kZ0sWZ8UEfe3t+9lscBRMGefnq0MKZScnRXiTDBonQrq+VzetSjCaNm37TIO0ZiTeK5DxA/hfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=unisoc.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K0tSdYnCEfkwYgUEGEhhrQrk0tlXhoqej1xccMl7/w=;
 b=Ra0lCougsAS+yQn3uLeDyYxCr6nOut9pElDI3Ui5ccRUfSleft4Apxq4C8pULmKYBXEpO8HFo6rmX4d3kW3oIr+1Q3SslWhZElYjGoOWo/cPAx2QCwhKs5FuV75fmktW+1ARRjx5n6PEej16QylwqejOPJgyXJ7eueEaGtqbPZk=
Received: from PU1PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::23) by TYZPR02MB7795.apcprd02.prod.outlook.com
 (2603:1096:405:6c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 03:49:53 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:803:16:cafe::51) by PU1PR01CA0035.outlook.office365.com
 (2603:1096:803:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Tue, 4 Jun 2024 03:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 03:49:52 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Jun
 2024 11:49:51 +0800
Date: Tue, 4 Jun 2024 11:49:45 +0800
From: hailong liu <hailong.liu@oppo.com>
To: zhaoyang.huang <zhaoyang.huang@unisoc.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: Re: [PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <20240604034945.tqwp2sxldpy6ido5@oppo.com>
References: <20240604022232.1669983-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240604022232.1669983-1-zhaoyang.huang@unisoc.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYZPR02MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2b0d98-2fa0-4c6c-eb9b-08dc84496449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kV6PhdYPe95Hw5NGzI99eLAqw8E1D9frByUvLLjnIKq55edqm/kxReanvMox?=
 =?us-ascii?Q?L+W8Tgx5d95IQrnwLIgSphpF3geoAOsmWGC+0YdzggPOZDIFJqS2qG+znUqv?=
 =?us-ascii?Q?XpzLTXhOC64qQRx+97eY2eoDTyByzwMke/QQSCFcpSAfi6K3qaTQoeVW7lNT?=
 =?us-ascii?Q?hMVWIU4y8jywUlxoKyEdF7OvArhcdkNjgsK3RnYfvco16N1f+OKAgGAREgqc?=
 =?us-ascii?Q?BdSQyAW9sXH/YwHmGRXFoTC/rT8Pnitmh/03VLTmDja1nwiLcTuyycvyo1wn?=
 =?us-ascii?Q?VZScBytgY3+pjQ3QXf7I9E94XRV9+ZwDOcLGKEHZN2b7QNiTCDr2y3zrjhvH?=
 =?us-ascii?Q?gMPNzxMJfTtK2xYAQc9kj6phOAgxSHqXxO8EUMURYaLb0CDqifdAzA9XuJwi?=
 =?us-ascii?Q?3u5C/rA8mqufhAJxxx9vGu5JTtxZhsALd72X/X5ZLEkHWo4H6GvLbhUISNmG?=
 =?us-ascii?Q?vv7krvV0lghlrNclul68bRuXZYhaJGWDKBzyoY3+jTqh7KQYJTvbj68epom1?=
 =?us-ascii?Q?Y2n22pnh8xgmLhjWSNi2UnGaGfcIKdrDwTnnh0TiC6/pu+HUlCJd5AdaGwqV?=
 =?us-ascii?Q?EnO7TyD9xpSSM1QxGfhXcwSqGaU/2J6uHYD1xv+9uimd9bX8WUtG2PUOJ46F?=
 =?us-ascii?Q?sPWhMaG4Jy1ubj271LntO7hx4ugehR7qO0rNMiikoJMp03JSn0u8/iWxhROX?=
 =?us-ascii?Q?KVIp9xxuF78JyG+NyxXasIfk8KuO4zUsrOYfyopw7pheGPyzjfY1w4TTNUUC?=
 =?us-ascii?Q?V+qp/VDrc8hlDWO+KY3YE7bMU8ULhf241AxhU3UgTILKlTxb9GX5bbt+0Y3N?=
 =?us-ascii?Q?YCSauHKmZEkPVPhoVDfsTuE1yct8B+MFZiV2WRIlQPf+MaLui/HZFedS1Xq2?=
 =?us-ascii?Q?oeQuB4LtjmLezFzUuiANfSEPC8b42bNrPHcWn1h6XMfOdOWrtExKtcZudPCl?=
 =?us-ascii?Q?W0HXmxqEJwH7iWu4GmsHxbYm6dt3nruwCkRFPFN/M2qrLgqPaaV7v3stA5mo?=
 =?us-ascii?Q?DcfRH4EedMqeDdAdQtflu1PHFZ+DlhXloeXkIDdqND8yN3QZ0kBX5vlQZi6g?=
 =?us-ascii?Q?SER8NMXu0CGw1R3Zaq9CYLp1kQdFT1Yp7ZBvxSdH9GspQcfvO5jGD8kv+MlN?=
 =?us-ascii?Q?iAQ6+ON3Jk57AH3hbOaY0Y8HqtVmsepVYNXWn7VlJGUiV4FjWfRVoQJpjv0x?=
 =?us-ascii?Q?kIV/ZxwqOzBM1seOGtSF5nZIRmdNhgUQC+Z1APLGOy4WAt5xnT1eLl85uDlH?=
 =?us-ascii?Q?2OVB5sWw89etMhuANQbmxDwYwdnDOL3uAp8MiXXoB9CuiNW2nJ9lLiP3rznm?=
 =?us-ascii?Q?b9QGsOTvU+yflSKRP2BEh4B3uBMH3Jk/5HEesdwtEX/24PGf4xx8+9WNlpiQ?=
 =?us-ascii?Q?Ka/EIOM=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 03:49:52.7937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2b0d98-2fa0-4c6c-eb9b-08dc84496449
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7795

On Tue, 04. Jun 10:22, zhaoyang.huang wrote:
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
> For detailed reason of broken list, please refer to below URL
> https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/
>
> Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Hi Zhaoyang:

OPPO test lab also encountered this problem on erofs & f2fs. Waiting for others suggestion.
you can add Cc: <stable@vger.kernel.org> here to help others to fix thie same issue.
> ---
> v2: introduce cpu in vmap_block to record the right CPU number
> v3: use get_cpu/put_cpu to prevent schedule between core
> v4: replace get_cpu/put_cpu by another API to avoid disabling preemption
> ---
> ---
>  mm/vmalloc.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..89eb034f4ac6 100644
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
> @@ -2585,8 +2586,15 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  		free_vmap_area(va);
>  		return ERR_PTR(err);
>  	}
> -
> -	vbq = raw_cpu_ptr(&vmap_block_queue);
> +	/*
> +	 * list_add_tail_rcu could happened in another core
> +	 * rather than vb->cpu due to task migration, which
> +	 * is safe as list_add_tail_rcu will ensure the list's
> +	 * integrity together with list_for_each_rcu from read
> +	 * side.
> +	 */
> +	vb->cpu = raw_smp_processor_id();
myabe put this line in vb's initialization before xa_insert looks more reasonable for me.
> +	vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
>  	spin_lock(&vbq->lock);
>  	list_add_tail_rcu(&vb->free_list, &vbq->free);
>  	spin_unlock(&vbq->lock);
> @@ -2614,9 +2622,10 @@ static void free_vmap_block(struct vmap_block *vb)
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
> @@ -2664,7 +2673,7 @@ static void purge_fragmented_blocks(int cpu)
>  			continue;
>
>  		spin_lock(&vb->lock);
> -		purge_fragmented_block(vb, vbq, &purge, true);
> +		purge_fragmented_block(vb, &purge, true);
>  		spin_unlock(&vb->lock);
>  	}
>  	rcu_read_unlock();
> @@ -2801,7 +2810,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
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


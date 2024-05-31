Return-Path: <linux-kernel+bounces-196220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2124A8D58FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD15B288A37
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1D7BB0A;
	Fri, 31 May 2024 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="iAKpc4Hi"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2076.outbound.protection.outlook.com [40.107.117.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDCA79945
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717125822; cv=fail; b=huoC7sO6p/eN9Svyeoeq/Gm25L5QJ+nTYtd8mM31+Rq9aqzrzeZctYoHQBrJaFejKrkoRXKv9z8di/oE1dUQn4vEKOJ2kTiwBHAT7MKsNfX3ulyDdCqGYI9lGScoV0URQsJ8firVxAf1ZzO3eyIJTZFR1MtR3ij4setc+rZDYSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717125822; c=relaxed/simple;
	bh=9/w1ecyKo7QG+wXHgs65/ovR1/RiU3LeR2ryBtNGGHE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKykVjQl81DHRzXiKqxEKQRla/qv9+AZbQWHq4RMwKdVpBzXoHWDGIG2Tsnd59WsaSq96v8oKW4tkVSWwqlFc7aqgGbAtX8Jxg/o1PbDunjo5Txr90yDvUUWxlzojMn3ZP3d0qGuoTb3F9TUlgcI5PF+T9lbHqHg7/H8JwoQTN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=iAKpc4Hi; arc=fail smtp.client-ip=40.107.117.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkBKu6ZzzG61y2FtvpGDNgDx944UIR71ldF+0xC+AR1PYalHPjIoLurNXVy8TZncPcHYeJlh0SBYw9Tw5BPmNrQeF2zb1DHAvBTFK5n9eWe0JEGZucvNfQ2ApEUSzDJ97+3AwBoQPcoyOkaYaO3nKDBZIY1hWpcIt5yhFiLjwivLzhFfSY5WFl7xjZpSyDK8dtGHuAa4Kuh0fpUJmxbcM8jX+nXHEc4+nO3vVciX/jXSQGbia+aMKPEZDGpR6u1jEK6/+fFzioR1PMCeGt9uR1P1Nis8RYygTewtheiiQx/i5Uj1ZFta8EadP3UtmYeWrlKDbMTRzU4RVxH6PovJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGys5S5HSSNEIPcp9ogvGbsmm8TME5ZfwLcta3OhRfg=;
 b=AcZcLlhDDv1Yi5D0hmMGpxNwR+Y4d1vD850VEFYOh7M5d7YQHGFJY7jnSLtqxCLmbhPd0hUMX4KabEaWuE3loWeSunaaoEwe8uD6WZ8Q757iX0lYonlTr++Gi/DBwixiT0Ln6TPuWcFMzABOUaP65STR5yw2hV2an0f0neXAZu/XbWpLWrI9SKlervyC+Gtjr6NfNC97baZKp+MrWPnadA0qO98LFIKedJ8TZ64aD+QwjvGgCmAAE/q7ZvAXuvelPxeQuITlR15jdumrarjbqA9H3iesrkBWhGbkK7hv4VkhGyzgfTzTNHrWVLzlyZatDfN91moSIFhBA/QFApHrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=unisoc.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGys5S5HSSNEIPcp9ogvGbsmm8TME5ZfwLcta3OhRfg=;
 b=iAKpc4Him9sblJt/Y91CUgSQhRiBXnyBriqL0/7GW/4NQzJWByxRLU7gZNeYOXWnFh8Czooxx/7TzKmCUzl9v2OpSj1LOpqIPQ3iUTO7XbVaeFRRBGuL4Xq+RscbeRl3XWADTsI1t5ZrMYu4RReLRME7uqJ7e7JUdCD45YvfT40=
Received: from PS2PR02CA0009.apcprd02.prod.outlook.com (2603:1096:300:41::21)
 by SEZPR02MB6773.apcprd02.prod.outlook.com (2603:1096:101:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 31 May
 2024 03:23:34 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:41:cafe::ee) by PS2PR02CA0009.outlook.office365.com
 (2603:1096:300:41::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23 via Frontend
 Transport; Fri, 31 May 2024 03:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 03:23:33 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 May
 2024 11:23:24 +0800
Date: Fri, 31 May 2024 11:23:19 +0800
From: hailong liu <hailong.liu@oppo.com>
To: zhaoyang.huang <zhaoyang.huang@unisoc.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <20240531032319.n2zqerooq7qe7osk@oppo.com>
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|SEZPR02MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: b5486bc3-1c7b-43bb-231c-08dc81210d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydoR9C1C6f+Sm5824gRvX/ZzU+qldWGCl13bSicGIbDyf0ww4PrcUxSbQ7RQ?=
 =?us-ascii?Q?fc9R4UWehLObSfWgL/dOXRfxBmUilio1IahF1HSz8IAbzhDLyuDWxDHt+Q+z?=
 =?us-ascii?Q?o/xX5r/sEHNXzb2G/wCcpIAzjc+wmtXheg0H58qQVNzz5P+FIRxK+gfV8Fi+?=
 =?us-ascii?Q?J6wqx2ZqF9DrbloXuNalFtV3Ge5fLAKLuoSFWPjSqw1arycF0qwzcS76G1/o?=
 =?us-ascii?Q?CqJkkc6xzlNQoegMrTn6JMwbiTBtnqFdTsetSwq26QXXcMgbcBGZqbo4PDaU?=
 =?us-ascii?Q?HaeKPjn8jAma5U0b9Bd6rs1imUyrGVllM/1yLjAQBWEalw/mD5XN7orIibv9?=
 =?us-ascii?Q?O3pqyK4IbQfUF53jp6i+2d7zh6sc+9Ah/hLezWD2c9MP2USsiZBR0r3mAg69?=
 =?us-ascii?Q?vM7c5aTMLpqxRAyiAfiphfrXXQWWnDoUn+HUBIjZAnJkb2W1EwVVEOczVKjy?=
 =?us-ascii?Q?ur8CTpG+JVhz/06FY0gSAckAvaYV8k3R/ZYOkztymfg1+iaVMVUXliRKr9rx?=
 =?us-ascii?Q?bD77y+3OErc64k4lkfWlsqrPb32lQ9bqknQ26WH9hgwhFVemIGFw7BguVqiN?=
 =?us-ascii?Q?NqTQ9MvLtPbFF4DuOpH3xe8EpIxlalMPQAlYhA+TrRL3wOaNRJXPr8SQJGUc?=
 =?us-ascii?Q?iQ/k2K9Fqhb+AiPZQX36DHPFzvujWzcHqkvEUG+XlSGfN+KiFZ34wAok6mE+?=
 =?us-ascii?Q?nGd6S+31pqGUgIr/8n9f7xSaGb8V6UopjM8AntP7WOC61SJOfAf7uPSjUqB3?=
 =?us-ascii?Q?dVTQE4ud7XBovusx1cpxdiat/is+JNy7cDacqMIZvELyFhD9TP1H8y7iio4K?=
 =?us-ascii?Q?uYqI/P8pVIgrJm6PY9SJ/EVsakKxo8bkq5n9Ie3zigxvIPhwKgb0HJy3OR7L?=
 =?us-ascii?Q?rz0xJBfY6Ji0fCq9kmaXzMySLWKvImUPBaE9VIHGz5ms5DThFXT3qEhAqGei?=
 =?us-ascii?Q?gRsrWy6laL8p0wGU5pTeDnNig7bBSkIJc7nlG0i9hWHDGrZ/kpwFfOJ9ZVVc?=
 =?us-ascii?Q?o/Cdioj0EnJl/aGHqrjZIEmXH6Jd3VUXYiSh1/u6GTcHWocJtmtiPrmFfRJX?=
 =?us-ascii?Q?SYik9NOPnBRTuAbs7Qszbd7O07+H/fUuRtPy8FPzb1obOkmlO7b7Gsenze39?=
 =?us-ascii?Q?EAp7m/CUBJ2NY+m1anwxH6azr2PzhzW9+YhcehbB2/GS75wLTQHOQAuBGC0f?=
 =?us-ascii?Q?rMnrQaNifX+3+IiVUfNml4jd0hcrjb1QiSxtqIXfL5CopPXsehA3BYXUcJkb?=
 =?us-ascii?Q?5GhSEOzmx0bapzKOYf75MC6a1w3fFO6jZjA96ZNebgWljLHOJakJFdT0Z2uC?=
 =?us-ascii?Q?1DcGmAYLGpxRbGDkua7sgiQp?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 03:23:33.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5486bc3-1c7b-43bb-231c-08dc81210d3d
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6773

On Fri, 31. May 11:05, zhaoyang.huang wrote:
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
> Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: introduce cpu in vmap_block to record the right CPU number
> v3: use get_cpu/put_cpu to prevent schedule between core
> ---
> ---
>  mm/vmalloc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..ecdb75d10949 100644
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
> @@ -2586,10 +2587,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  		return ERR_PTR(err);
>  	}
>
> +	vb->cpu = get_cpu();
>  	vbq = raw_cpu_ptr(&vmap_block_queue);
>  	spin_lock(&vbq->lock);
>  	list_add_tail_rcu(&vb->free_list, &vbq->free);
>  	spin_unlock(&vbq->lock);
> +	put_cpu();
>
>  	return vaddr;
>  }
> @@ -2614,9 +2617,10 @@ static void free_vmap_block(struct vmap_block *vb)
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
> @@ -2664,7 +2668,7 @@ static void purge_fragmented_blocks(int cpu)
>  			continue;
>
>  		spin_lock(&vb->lock);
> -		purge_fragmented_block(vb, vbq, &purge, true);
> +		purge_fragmented_block(vb, &purge, true);
>  		spin_unlock(&vb->lock);
>  	}
>  	rcu_read_unlock();
> @@ -2801,7 +2805,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
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
feel free to include my commit msg to help others.
https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/

Best Regards,
Hailong.


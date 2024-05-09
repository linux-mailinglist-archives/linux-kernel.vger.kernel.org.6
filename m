Return-Path: <linux-kernel+bounces-174282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABAC8C0C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5532282518
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E23149E18;
	Thu,  9 May 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="kmg+8+xL"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2057.outbound.protection.outlook.com [40.107.215.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A45149C7E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242904; cv=fail; b=dinuUy/ZcaO/vIbeNBxM7pHwUrRyrJafki/Rrl0bN63tO84BpAccbrlBG2p3ptoTx12BgG7vuhRQtAf+r5flhzj4HKhuR7kGjJ6MQWMhXpfgIegaQ9s3m5lzfLX/DPvsIPqebcpngmhd507gazPHNt/gpm1SPk3MNNFRdK/g69o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242904; c=relaxed/simple;
	bh=14MuJjEWh2lgkCA7iGhFGxnTbyhNmc/IWjREbomv3eU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNn13jKhBgrIQRk3AO3O3pK/3lvM1Zbx4l4xnMh3Q24N6909FNaKEqmEUSmklOZdPc+6EdWksOcHfdSHELzBptByVEqYeA9zPPWfuKYL+celOwIkHbfJas+Hz7hVV2xk5mvDgM0HK5AJp1OZh6ffpfbYBfNsts1wYw/P0ulGrXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=kmg+8+xL; arc=fail smtp.client-ip=40.107.215.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtFJy3ScapUDv7c9O9/jYEkTOECCdWpN9HbEq2tNFBui44jcFceLBk/Gyr+G21bpsLuqfxGVXDpTLiy9I/mmCTKddS6xmIB6ckklMxK1dcGoO9lt/+mQuttqpQgBV141lfjePamPY1C0zXzPrQoFoYtsx4HnN2hVYr80/0VYoBpLRc5FZ9oVXxP2VkF38qPSkmwm2acHfhLcCGm8c0mP8DERRKP3x+pEN9luyn+pab28aSdHOU+Lk0OB7Bupx/8mD9eKZOEKhf2QLx32tde/zh4yOGAmurxPvU19IOnvEk5nTe5g2p4MjYrCsEpjaHDTNayN+/KWKxeIkjsiz5j8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krgnfcxgmEXuTMUq4Z0rK9aA40IKgS1fjPSAbICbBsc=;
 b=KAUSqyxWeWMb9N1VxpufRsWSZ7FbU/0biO/R4Xesbk9s0nN5x0MBFUO4kQNCO9os+AkeKlmepQ61wBLgL2XwO+0FdHpzWpXX4UV1Ki1h+PqKw1igx0Sor9lkpspZywm7uEnleeHzCkZlKCsKT4HeaKQ8KO3ZsQAc1+gRDD0SBeb5ZkAN8exKnTvIjdAlHFMr54MZchSHQuSdd+d5CVOq8WC4mumYUG4v3TENapNzjMbDRpqHiCqrBbQnZ4th9+XGn8sXeMZIQ0cgSi1LBf1ylHAmuCRlRmpcVbKqRX4Az/wM1YCHnrFK9YMRMCvewYqaSeXcJnZWV1ThYRJ16Kte5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=suse.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krgnfcxgmEXuTMUq4Z0rK9aA40IKgS1fjPSAbICbBsc=;
 b=kmg+8+xLeJSEJS/ivy6KBSnzG2QYm5KRgPcmvGr8EKocFUleADNL4X+XQYCJIWrAxyNNa+zbLS+2LVJNxBTU/rt/WSIYyCxHne4p71B7Veh0Khgk/Rp3/FjffAw5vm5Dct01aFU34aAKRw0VLRDrvJTMu2Zt/8wylESvLl/V5Ag=
Received: from SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16) by
 SEZPR02MB6412.apcprd02.prod.outlook.com (2603:1096:101:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 08:21:38 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::bc) by SG2PR06CA0184.outlook.office365.com
 (2603:1096:4:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Thu, 9 May 2024 08:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 08:21:37 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 16:06:36 +0800
Date: Thu, 9 May 2024 16:06:36 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Michal Hocko <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <urezki@gmail.com>, <hch@infradead.org>,
	<lstoakes@gmail.com>, <21cnbao@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <xiang@kernel.org>, <chao@kernel.org>, Oven
	<liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <20240509080636.bauxbgpqdluzpein@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <Zjx_6F3Fti_EBD_e@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zjx_6F3Fti_EBD_e@tiehlicka>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEZPR02MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e47d76c-137b-4cd6-beea-08dc70010c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B8AN/UTzokJRBBaHAWOli/Wnx2F3er4SyMfBxBKfwRJi5Su1hNz1MV+xBE42?=
 =?us-ascii?Q?iY8mJyg3pGEXpAwwahf/2ddlWMywZTMf/k88DBHwL19x+vjcpDO6mUSZL98G?=
 =?us-ascii?Q?kuzRgKXVKNWf+vZv7Dp0neWM2EASS76yCM0KH6lm0G4j8TrDbOUM0lFkzTxc?=
 =?us-ascii?Q?9d4ETsJdxXL4owVquseXxjA8in4y3yImhGcgulY+9xlIks9KMjnQiHnUZ0/e?=
 =?us-ascii?Q?Fei7FRv6a1d+pldcrqm16v7x/rh92Y/tgBKzqqjfTQwsn6S275O5AjdCOrdP?=
 =?us-ascii?Q?M9kekj5+XOWKxByYJZHIfHf+7daZGKs/ZNx/c23yPT7rRRQkhthVd/QFUXBB?=
 =?us-ascii?Q?61ijaDPxFAJcFl/Nu9owkUDIXEIqShaJ7XMh0FTHatNpYstOM8pEidIUAFu/?=
 =?us-ascii?Q?0LGvlzFAST76wEXVgV+e7DyAuMHDD4xCeTYW0UOYMVaVoJ330DbHZQ86v6XT?=
 =?us-ascii?Q?gHm1Y6t11N9QxaHQYJldIbhDNiDghdLqG7iVGmrzR5fRREFwWzA9pn1DqYS6?=
 =?us-ascii?Q?Uy+e0peP1eoerYEn+dlnz/d6K401Qa/sFMdrA5DgboOM8iuXRLK8d86FgW/k?=
 =?us-ascii?Q?/PQeAI/HzPa6y0FynkysDqOqizgV9nOsNeCfXkWrr1kWschitHZI+6ZWTLAd?=
 =?us-ascii?Q?RJy24APLgVD4s12cPEbO02KluCKuSDQYFUxFXUU9F/siM0Urm29oVWyfSW5+?=
 =?us-ascii?Q?0X29iRO0at75Yz/iqXxtc4XMis6zJCAjqrb6yfFRKcpyWz54aTgA63sgVf91?=
 =?us-ascii?Q?8KlVJJwkFR5Zh0JSyjxwzCZRk6+FBGN8KpSm2Nw8KYgV9jz1qo+fslGFUa/2?=
 =?us-ascii?Q?dpNhu5pKkC/14mAyLP6hU+64H+B6TlmABDUclt36Qc/XF1ktyxYskAHeqGJa?=
 =?us-ascii?Q?8/LA5mZQ5s30+U/C9IIg8Ak4/2WoRE0rihr1xb4TArHK6gT4thv4hBNlMddA?=
 =?us-ascii?Q?leHFcG9iPFAChQ8pS+pB7MEWIJlTHNWYsWBNRA0AP/yiw1Q4Y+u4Re/XQJtk?=
 =?us-ascii?Q?gBewX+ts6a9zZzBhWrA68b2bN6noqHzSBhJApQHueqGrNAfj9EwvmDWnqNq/?=
 =?us-ascii?Q?9ev6ZOS4n/MugXjx7N4pL5i3ZJh/f7+QAnQU7d9PbyNTd8D7IgJIP6ZhO1pa?=
 =?us-ascii?Q?Ji+GYRF1JdL3GAn8LxyTDGH1yj8qmzgvwK5H4JcfJd39ZCTeit+rXkbryXA+?=
 =?us-ascii?Q?m5h+r/qrmJoK61fxDPQWTiqalFLVVzCbImNA83IdvlkkZEwZab0x8V37khkz?=
 =?us-ascii?Q?5ykl53BYj/lEbN2evqgylgKEHSQTKF+Ea98nR8d5KdDEoTC0QU0ivRkdK0vL?=
 =?us-ascii?Q?Wg8nbmROKJ/3AKlkFj4DNXJFDlipTyS00n2qyo3TN1LgjNG2HXGr5vrla79b?=
 =?us-ascii?Q?UKEYQj4sb5ES/AEcQBXWPwbJAirL?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 08:21:37.9137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e47d76c-137b-4cd6-beea-08dc70010c1e
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6412

On Thu, 09. May 09:48, Michal Hocko wrote:
> On Wed 08-05-24 20:58:08, hailong.liu@oppo.com wrote:
> > From: "Hailong.Liu" <hailong.liu@oppo.com>
> >
> > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> > includes support for __GFP_NOFAIL, but it presents a conflict with
> > commit dd544141b9eb ("vmalloc: back off when the current task is
> > OOM-killed"). A possible scenario is as belows:
> >
> > process-a
> > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> >     __vmalloc_node_range()
> > 	__vmalloc_area_node()
> > 	    vm_area_alloc_pages()
> >             --> oom-killer send SIGKILL to process-a
> >             if (fatal_signal_pending(current)) break;
> > --> return NULL;
> >
> > to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> > if __GFP_NOFAIL set.
> >
> > Reported-by: Oven <liyangouwen1@oppo.com>
> > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > ---
> >  mm/vmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 6641be0ca80b..2f359d08bf8d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >
> >  	/* High-order pages or fallback path if "bulk" fails. */
> >  	while (nr_allocated < nr_pages) {
> > -		if (fatal_signal_pending(current))
> > +		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
>
> Use nofail instead of gfp & __GFP_NOFAIL.
>
> Other than that looks good to me. After that is fixed, please feel free
> to add Acked-by: Michal Hocko <mhocko@suse.com>
>
> I believe this should also have Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
> --
> Michal Hocko
> SUSE Labs

Thanks for the review and the Ack!

Add Fixes in V2 patch.

IIUC, nofail could not used for this case.

	/*
	 * For order-0 pages we make use of bulk allocator, if
	 * the page array is partly or not at all populated due
	 * to fails, fallback to a single page allocator that is
	 * more permissive.
	 */
	if (!order) {
		/* bulk allocator doesn't support nofail req. officially */
		xxx
-> nofail = false;
	} else if (gfp & __GFP_NOFAIL) {
		/*
		 * Higher order nofail allocations are really expensive and
		 * potentially dangerous (pre-mature OOM, disruptive reclaim
		 * and compaction etc.
		 */
		alloc_gfp &= ~__GFP_NOFAIL;
		nofail = true;
	}

	/* High-order pages or fallback path if "bulk" fails. */
	while (nr_allocated < nr_pages) {

-> nofail is false here if bulk allocator fails.
		if (fatal_signal_pending(current))
			break;

--

Best Regards,
Hailong.


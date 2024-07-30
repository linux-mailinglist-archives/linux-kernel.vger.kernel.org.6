Return-Path: <linux-kernel+bounces-266719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E249405D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C01C2169B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E01465A2;
	Tue, 30 Jul 2024 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="S+y4Bz0R"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B31854
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309896; cv=fail; b=A+aQwJhhZWEsCWyHSlUFZ8OGBzWrDQltySSqIO7kj46LNba1S9ZeO0tobKtoGygeJRGqBEub3Yx9GDS4OUQwO3rfcwHqOA5YgF4PKjz6vmTKUx4Bd9IXyMyM3Y6yd0LQZg01rc38aeNqHTSGlTjfo6NHSqyl0xGSUQq3R3GHzpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309896; c=relaxed/simple;
	bh=5RH2E0B+oMV3na90A4cQXLYfVz8Bz39ACULOQRj7QDg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atUO9AqUQD0waoG89rUU2usacQ0RydxdmTbkbcl8ZtbfKRjgrPOXw/83MqAtszAXR+DpTaoyxxf9mVLtDnE5YTgRscj0/r5PTzFd+3RT3gDsXU2pEJBb8hP78JxZzRp2cVr88C21DayFJ2qBvAjNuS3MxfiCwYUOzYU8obm23G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=S+y4Bz0R; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaA34OCkIZskZ5uNUGFXoxgoof/qQ+sFSpgkaSkuiDSPPg/DdSDFKnxBkVP2cqlnDmf3TJS7QXewxWXJe8hdPKaI/V2qvaLmoxXWpEeQ6GdGR9ikFvegUP65+Rwz6BSNOnr1CxprdnwC8uTtuDX6ofoeMR8So04seYQD+CEg230ys664jU/RgiKWhC9QzVm7T2lWpIXFSvN4liV9Oo2eaP6XdD/5hbm2Oc6d1wgMq2lAUFP/7TMygOiHwb8TyBEDwC/UJ6k06FhQIrovmOUEh3RrRsFlFQx6pEFoN/JCklKQeHeMIa9/LFCgJiKvGUmCbN4wSEbd+8rHGluYhm1nGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RH2E0B+oMV3na90A4cQXLYfVz8Bz39ACULOQRj7QDg=;
 b=PKGDkAr/dGXr5q7buw/0cuMTm+OtbZSk0+lLjUhgTJfzIdDwnqtVGlk0q9wv1z241ekzHxNuIZ93C8BMqkBr3WGf8EAh9wTfaSS+ezx5mbTB0LCLxoI4hkzwKTBZr7XPGeZfB2dib9Kv5UcQ/qXV89CGDHdg1hjf/bEsmnXtqTOEBdWZ4FD17p9Du3CIbyKrMPVmKAc9bSKaYRRfaHa5iw/ZtuCk0UJld3wZs7HodItHxmzEjMcYw1irFhwScRiso/tmhhFyr2Q2jgwchpw2ccFMQ/04UGhUsA2x9O2p07yGz1jxdf9TyfeYnOZsCoWVPf0M3fFE9qrpHPvdwMASKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RH2E0B+oMV3na90A4cQXLYfVz8Bz39ACULOQRj7QDg=;
 b=S+y4Bz0RSL+VF48Ej+eZK8/Ltrk1aES449BJznhxRincP9YBBQtymJ6RprWTYqFeer1nQPmkdRZqpWEyBKzk8x1SGqZfjlJ8WeJhsTsZXHWo7LYzbCOas/yB3Lje3jnnjH1qBRQ5HtRlAf6WxOGMZBuzGScbA0t4VbsQbtIkkp4=
Received: from SL2P216CA0190.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1a::16)
 by SEYPR02MB7198.apcprd02.prod.outlook.com (2603:1096:101:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Tue, 30 Jul
 2024 03:24:48 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:101:1a:cafe::eb) by SL2P216CA0190.outlook.office365.com
 (2603:1096:101:1a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 03:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 03:24:48 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 11:24:47 +0800
Date: Tue, 30 Jul 2024 11:24:47 +0800
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
Message-ID: <20240730032447.avaoa5uhcxdkcjzs@oppo.com>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
 <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
 <CAGsJ_4z0AYTVoCJjTyZsku24kPfOTnu1KCms_NPevdNKW+6sdg@mail.gmail.com>
 <Zqb0+L/21/AKUagd@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zqb0+L/21/AKUagd@MiWiFi-R3L-srv>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|SEYPR02MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 611191ac-e4c1-46f1-e3a3-08dcb0472ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zt9jWdpiQ3nePCJqgQCnleV/01pkydUJ7F73ezCPQpT6uWCRps4+M9kJ/9fM?=
 =?us-ascii?Q?CvI0QjlEXNOxAzSSC4Ldw9fUbgApPMi2yr1A+xhUyjY61v1XTlQgSggv2gCB?=
 =?us-ascii?Q?rORJFMeT4nXlpQoKgaleplGE+YvIW3UZplQLsmcQCjIhDpvJv628aNuGC3Um?=
 =?us-ascii?Q?zhTkpVXkVrt5FZx6cb7G7peBzz3WlbmuRbIwLgSoIegLOjJeIJQYcZWQeVQR?=
 =?us-ascii?Q?0+9BVgXaUS7UGt23c21C73jbdgWrwPwnSNxH6XNkt8HbkafdpGq+6XdqeTgJ?=
 =?us-ascii?Q?vss8w2RRgv+TPL+JoAmy6f56Bur4mEgcqLqNxRAXhKtfCTKE8Os+fP/pbFF9?=
 =?us-ascii?Q?aXXKua7aklUcVfamdUc7YoPZC0vSxLtXr4ZCmGeh0d/i56a/sIl6+ORxWikH?=
 =?us-ascii?Q?ZkzttabL4p7hmOOO8h0QDBZuDVatG7zdli8YWPvA/8v/6mwFNfnRl52Qs0kU?=
 =?us-ascii?Q?NUwMYl17odcCn5oiiwq6HIcsDGCOQLBZb3Y0fhv+wfuApkZ1id/et+4EJ8Xd?=
 =?us-ascii?Q?kF0tbopbiwuxybEiHiytaONCClUV0Res6sPD5IkxjaVk0BikaPFHnUlrVxI4?=
 =?us-ascii?Q?7qqLUFYsB94Up4eoxs36vvWC7zBU7WuP0sXKn2Vu8bCwsWwEl3oj+oOY+bPH?=
 =?us-ascii?Q?7un35RGX/l3nbeahHWIv1DyCMCE14I1grfpsBrPhgM51sqMZ5Ma2votn6+Wg?=
 =?us-ascii?Q?VQ2zoSfzUHgxMZy12zKRoSWY6evjQ92LlWhCIjw8MsjGI9jtW4pP/34f5JFd?=
 =?us-ascii?Q?kIp2rr/iV5mRnhEmkTIyIYQdT31JP8OSWLgL9ZaCuf4zSsA0NuBoPUFfjGHc?=
 =?us-ascii?Q?qjRycO+97F+qLk06+yWy230cbE8J58QKvKhRgIklgKF5f7+eX67Ac9+7SDmI?=
 =?us-ascii?Q?MEJadwpQBa4nbhJRDjEJ4kVTIo0fdoTDvGdG+wleZRHWTPPRMtkXyQ2TU/bt?=
 =?us-ascii?Q?K4KCYj9TLVKWg24M4oMpqv8F/VgdLIO/1OXp0T4+Vxe5mSGOgXZP+659FfYM?=
 =?us-ascii?Q?/I8GTloBGJ0jiKWOhVlYjiCcKk3hprvPqQrFxO1DlWhUoPxXO04I4iAjAvZI?=
 =?us-ascii?Q?gJUhW8z4zLjY6oNDYQYi3nHAFFC7VlQS6pq1rc2srDLj/+uU/LB8C8dltY5A?=
 =?us-ascii?Q?dyN0ff+Du1PDQEgg4iF0AUIoWtFn/K3xbqUZeq50ONXVHrveoS04SAFKH1Lx?=
 =?us-ascii?Q?DD+dFG52bH208+HYQOJcuZLMFcyGqdVb42ilyKKsgqnJbAt+WRM84ODERCnL?=
 =?us-ascii?Q?0lOsGhmGPCNkPhGO3qSUmufuErDGxW0o53zVu08igbEGJiKaW5rS9B3V+3B2?=
 =?us-ascii?Q?JIiaQsRKeO7ub/kWNtuopLkutJMNU8ZbC5mj6xlAuVkX8FS/jYAbyFj7TNH6?=
 =?us-ascii?Q?fsxUsSrav7kmSUwXyvC7TUJhiok4w4vDGGtWbyVpRYmMCxPqjn7bVQLAlAGE?=
 =?us-ascii?Q?2HFXK1dcloyf1nTD2YlyNkX1iKY6jUxv?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 03:24:48.2891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 611191ac-e4c1-46f1-e3a3-08dcb0472ab1
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7198

On Mon, 29. Jul 09:48, Baoquan He wrote:
[...]
> Hi Hailong,
>
> Please feel free to collect them to post formal patch, maybe two
> patches, one is to allow non-nofail to fallback to order-0 in
> vm_area_alloc_pages(), the other is passing out the fallbacked
> page_order to vmap_pages_range() if it's OK.
Sorry for late response. I personally prefer to revert part of
the problematic patch. There are several reasons:
- Save memory usage if high order allocation failed.
- If nofail and fallback to order0 in vmalloc huge allocation,
actually the allocation is alighed with PMD_SIZE or not PAGE_SHIFT.

You might be concerned about performance issues. But IMO,
- If we fallback to order0, we can make use of bulk allocator.
- Maybe we can remove VM_ALLOW_HUGE_VMAP in kvmalloc.

I am not sure if I have misunderstood anything. If I have, please
let me know.
>
> Thanks
> Baoquan
>
>

--
help you, help me,
Hailong.


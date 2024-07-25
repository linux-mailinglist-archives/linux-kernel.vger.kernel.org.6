Return-Path: <linux-kernel+bounces-261975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A604193BEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4229B2106A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875617107E;
	Thu, 25 Jul 2024 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="sqDH2nIf"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2068.outbound.protection.outlook.com [40.107.117.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E10196D81
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899031; cv=fail; b=nuTSypDufO+5+ggT/3c1b7muE0mhx9bLq7j9pYnUifkZlCt+h2hejSF34uIOQPC1NdkoS8ZuESftS3J6aujCIJE4ASnsy9az1XelXtFNJl6OszwvUbEJDpbJt7iDblYBosFRR+pPI7QK2ouEUtfDcVK32UahqHIJ2XLbt2yHSos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899031; c=relaxed/simple;
	bh=t6Q5iAL8XhgbV3DW0MVplOO83USZ/NsON6d1XIGei2Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGoQuhGCR43H8g5ipuXvZIAdCUrXoyRtGBxl5NlDc7qvdGkzm5DQONQ88AYFY/WILd2UwGvl3f/Max7byfDvTGhV67nC3rnaMmcvAZasFH0PFNj/cFHKHam8NM/BU6Uj4E4SSw0IWG6dbKJncSAX/9cDUxW1tIdvoNtwBmRlqb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=sqDH2nIf; arc=fail smtp.client-ip=40.107.117.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAfbi48ojwKur952L3+VzmqBdGBes69Pag0bYzU1L1FYo88900Jxkj3h6jQ2wHPxy/1HF+w9l4HzNDjPzHnlmqKldwXdjlDJqlIdWySARblMdRxgWXAe4BY0lfrYdzz4bezGx2jcl0nFPclYICltKjVzeYl9sS2dbiyHByBqmv3kR87M10UgQzki2eXd9RsW0KzxJmKr/qrbQH7/xHC5+cRqQ3GcIExT+5QJX3cmXm8ruTenfLM8DWvL7gzzmJdcSm2rkI6kO6yFYT23/AeUnTraV0JZ4+Bw21WJJrdq7na5GQQbc7b5C07Hy3JBuiP5hfi8WFThvE/hVQlTUTA9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEgUM2hbZMDx8yMsyWZbrWzgShP/wWhFX/MLNQ9iwAw=;
 b=hKuXpOCFWDIk0dTdB0mOwTf+8M9LxvS43fv4yw1Obfoayl/85yDz+7gje9Ko/FFm5Z443hKLGgg0i8/Gom9R89M4nkvYNrgLkSx8c9K8X1i3E7FL3Z7JWjzmycThN+0beGE06IA85kR2NH8TIO9rbSXDCHKTN7rnk8os/jvLCEOfqzYTrm0N76Sflx+1veqgbRRKYoA3t0379e82j/UTdjifbUvcarPPpyXuskF1VwHpuTm6O0aczYnznFY4Dcqo051EFk0uOFDeN5L8V7DrEt7v3qCwulF5tdNrqRQNFRGQDMrNzZtOc7ux2r3SGdH5RvRPE3llmZeUgISi4J2WYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEgUM2hbZMDx8yMsyWZbrWzgShP/wWhFX/MLNQ9iwAw=;
 b=sqDH2nIfIxwCLs+cxLz9ykrwCzrlHMWnWY2BwaEycEMXmh8sVgy/lRvWU94ZphpHh4a4I2xN+kUFasUkLshA7VFCcsvaeo+kG4k3P9s8IRzFPYf3K+r5GSYopxTI+ldydE8WJd+uxvNhY4/RF2/poDIMiCvWsTdMFCg2GeKlbIA=
Received: from KL1PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::13) by JH0PR02MB6424.apcprd02.prod.outlook.com
 (2603:1096:990:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 09:17:05 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:820:1:cafe::4) by KL1PR01CA0025.outlook.office365.com
 (2603:1096:820:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 09:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 09:17:04 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 17:17:03 +0800
Date: Thu, 25 Jul 2024 17:17:03 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Barry Song <21cnbao@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
	<mhocko@suse.com>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, "Tangquan . Zheng" <zhengtangquan@oppo.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <20240725091703.tsjpgltwgu3jwy5e@oppo.com>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <CAGsJ_4zWsh50Pzp0ntskT=eyfStALxD5BMNdWFrYJewrrx7V5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zWsh50Pzp0ntskT=eyfStALxD5BMNdWFrYJewrrx7V5Q@mail.gmail.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|JH0PR02MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: f42ab3e3-255a-4a74-a468-08dcac8a8cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzFkcU53Mk1oUTJJT05ZVVcxYldibUpMNEk3NHpFUHNnR21JT0lidzBYMkJB?=
 =?utf-8?B?Q1BuczFkWUd5c0NodjBDUThhK1VIdUxQVXNPOSs4T2tqMWlkdS9rNnVhMVVr?=
 =?utf-8?B?U0pqeUpjbk50WWxsLzcyUUZSMi9BVnpwTTg3ajdkZFBCSjdhdC9ISnBBOEpY?=
 =?utf-8?B?NTVoNTltVXRlWWZGMlRwL2RnUlorZjlZV2xrZ0xCNnA1RXp4aTg0eks1M2lz?=
 =?utf-8?B?SzlOSUxMQjFvdkYrU2dna2l6RkRxVFRJcnRxa0lXRmVicUsvSDBsWHRKMEtx?=
 =?utf-8?B?Q3lDamVDSm9PVlpESWlqQkVjWlY3aHdLZW45K3ZjWnF1dG9wQklLN2c2eWVr?=
 =?utf-8?B?aVBCTTBybWhBemo5Z1NjbEhVQ0llMi9WN2hoR3NoRFRmQkt4TG1nUE5abW9B?=
 =?utf-8?B?cDRPVm02M1htUlBnekdMZlVWVlBJTXdpeTNtWHQ1cm96T1E4ZFN1Ui9FOTJI?=
 =?utf-8?B?aVNSL2p0OGZBRzZwVVMzNVhHdlRSQUxnRmFlOTJFaTRwRmhzcUZBSFpFVHpH?=
 =?utf-8?B?YmdUZDk3dHc0R0VZRFJWdHFDNUxFRnZMVmtQcFVSNVNrcnhDSFBPZkMzeitP?=
 =?utf-8?B?RVJmaVpmOWhmSnFmSkh1VG5jSE83bXVnNmozQ1UybEh5ZVhvcnZyUktOaStY?=
 =?utf-8?B?M1h5Q3N6M29SQ1dlKzhRcjRkcDZONkZma001RDhpY09YQ3NZbFdMbEdZb0pG?=
 =?utf-8?B?Z0xWM1hDUDhVMTl1WTAxalFtQ285amtEbDM0ZWhlaXlQUHhuakl3RXhLU0JN?=
 =?utf-8?B?YkFPazEvcVRaTUxiV0ZjNnVzSnA0NHpFcjJYdCtXYlY5bjJad3VJYTFnRjIv?=
 =?utf-8?B?ZW9aZkdRY0lWU3c1THVVL1NyUHZnSk90MTN2eEVOZmZ0UmQvM3pSZ1Y1dFpx?=
 =?utf-8?B?MEhnR3poNjFwS2xGaHJpVmMyenYvZEpFM2FqTzEvdXUxcVJqTU1PWUVYSTBi?=
 =?utf-8?B?cVJKWGVLRzhoQ1F2WHBIc1RVb3FEQjZJVGNsVUV4eVBnUU5EaDM4cXNQUWNP?=
 =?utf-8?B?WVZmeDBoeThsRis2blhldzJIMnZQWURRaWxsYitYTGtNVVRROEViMTJ5R0I0?=
 =?utf-8?B?ZzRwWFBHVEI2SWtOYXBmakZ1Sk1iUzZYYXJmVWM3TWVlVXN1WUlqZEFienph?=
 =?utf-8?B?SFgraWhqcm5NV3RkN2Y3ZitDcmdsQmdsODBjZzUvSHhUaWlYVHNPMWVmNFc1?=
 =?utf-8?B?cTNzOXZsNjA0dUpWd2FXUU1qWWwyZVJ4VEJOZnRFNy85RXc0N3VuOFRTbTdu?=
 =?utf-8?B?WUJXaFkwTWppQWtXOGNXOGZiRTNjS2VhdEJidzdCVFZ6MTFTVDJBM1A4LzJj?=
 =?utf-8?B?QjY1VWZPelJ2ODFzTkU3MGtJcnp0dksyQUljeVQ3VGNodFFOTDJuSEo1dHRK?=
 =?utf-8?B?Wmd2YklPNjQ4WTFNeDBveS9qbzYzbFpxbU1iODNQcnNoQzZmcjJWblVTVG1X?=
 =?utf-8?B?eUpEK2Rva0Q4RDRvV3dxRE1oekdYU0dueWRaL2paSk9XNUt2eElwV0gwajl5?=
 =?utf-8?B?Z09vQlpRTUdWT21KOStZT2FOck9TQkxTcStwemZ5dW1xNkJ1YmJyMEp4dHhM?=
 =?utf-8?B?YlA5VG45NmxWZUthVnR5aHhTUmVGWGpRcDNUbmFxdU5BOXJRQ2xHYkNOSXBC?=
 =?utf-8?B?UXVtNmFoNXROTUZBZm5pRSthYWRxY25VYzQ5Mkp0L1BHY08ySjR4MEkzZUFj?=
 =?utf-8?B?emF6Ni9Gb3BHMTZmL2swenl2S0lCWk9HMXh4TkVscDVCRFZtQzNoMkdzTHdt?=
 =?utf-8?B?TUNQbjVpc2ZMdXVHOTFOY1ZoZXY3d25oM1NyUnovK1YyOFgvUXlITjhvbGJK?=
 =?utf-8?B?dENLY0VZejdTWTlGbVRhK2M1SGU0dnF4VWNiVlgrZXYxeWR2Szl1WjhBcy9M?=
 =?utf-8?Q?9JL+ve/OO+sRu?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 09:17:04.4883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42ab3e3-255a-4a74-a468-08dcac8a8cbf
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6424

On Thu, 25. Jul 18:21, Barry Song wrote:
> On Thu, Jul 25, 2024 at 3:53 PM <hailong.liu@oppo.com> wrote:
[snip]
>
> This is still incorrect because it undoes Michal's work. We also need to break
> the loop if (!nofail), which you're currently omitting.

IIUC, the origin issue is to fix kvcalloc with __GFP_NOFAIL return NULL.
https://lore.kernel.org/all/ZAXynvdNqcI0f6Us@dhcp22.suse.cz/T/#u
if we disable huge flag in kmalloc_node, the issue will be fixed.
>
> To avoid reverting Michal's work, the simplest "fix" would be,
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index caf032f0bd69..0011ca30df1c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3775,7 +3775,7 @@ void *__vmalloc_node_range_noprof(unsigned long
> size, unsigned long align,
>                 return NULL;
>         }
>
> -       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> +       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP) &
> !(gfp_mask & __GFP_NOFAIL)) {
>                 unsigned long size_per_node;
>
>                 /*
> >
> > [1] https://lore.kernel.org/lkml/20240724182827.nlgdckimtg2gwns5@oppo.com/
> > 2.34.1
>
> Thanks
> Barry

--
help you, help me,
Hailong.


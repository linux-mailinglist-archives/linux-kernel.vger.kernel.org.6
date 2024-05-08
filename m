Return-Path: <linux-kernel+bounces-173436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32CE8C0064
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8931128C1FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBC12B163;
	Wed,  8 May 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="PTA/vjXk"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FD86621
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179418; cv=fail; b=FOqpHb4YHyK6oX6ApsnnZtDuiWnKlqiPyAIWxuDgqHdq2xYghtXMV3CftukAxCK/I7KquFfmj8HWCpMKpl09Or7o5AjckuGxpTM0jT52g7U1jtahONbiQmBVYqO8SGQm+iDiabzGSsNlN05+MogUR9pcpMTTqXD/vm9HO/GhkEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179418; c=relaxed/simple;
	bh=CyPQ0BXBlPbcvFvs2dFDQbWnMNLBR1AXN8a43XpcMaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K01BGaVyirnmwra2z++1MFMGyLFRD03o3PffrYFNLp4LLoWp/6iwSUIIhsz9t7R4lx3ihId75KAV3a56PzbMc8XIcgid+q5fybOgDbX5SEssRxo2mvb+ROTEaYkU83UqCq5GtNqGo/Pueamo4QuWlcoOFXWUv2MPPo18VzfvFHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=PTA/vjXk; arc=fail smtp.client-ip=40.107.117.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFDe0vXREJUQf3b3Fjjwvrm7gyxgJCKWCJcPoPUJkAd7dRW4ZbNgkN80PZdGw+92lV+4BJ747CvVgmgqLfF0OGJv04tXVPcj1ktugBbYXx6qv1yCe0wy6dh7vdnO2UMb5PuKsqP1hfUDKwr/DurxjkTxcm5fBSPJdRF6gXK4TAjhonSj4mKn2OCnEHh6XnysgwLBjleKbKIY5i0OVz5+Bu1H1BlDQmqTIMHTqxb95g+jOR8SgMpRKm7bkZbf9774b1fd97I9O2rVhpBGibkNa2pHly4QKUWq0Aw3GO3tKGKpiBLKTNS4ZpeOZ1wWGF31iAS0GVpny0eZRjdmdFKGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiXFFb2wR6td3f/0a4yxw9j8+tQQgkNqUf68E69UwPc=;
 b=ByKVAUEnc7FSBe4/4OTrh17QYBiUwKdVErC7P+2rlE7qzORKaw59nKZGHtqNaodibPWnURMjJrld9ky7WJzg65CBBHdz5Ou1kcBDfiM2tLmuUFUTHY57xmQYpjWXsD/zJ0T+c5nn01a+oMdUAv8h0d41rD4CRpv2q4Xcfr3q+esI9Zu/EyQOSTXJlCE1VFHOdzkFaOCK5xxMVhaWmzw6t2zcuBROg9lnGK3O4k3OFMDMUPMw3xDGzXcjC0fYWRPsWJLEUcD6vmCkDuXYFEU6dLrgV5wOkV9NcD1gw1ajS3PVXsaWPUZAZJzLM42m95GBXHKLAHJUobdPFXT5ulYAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiXFFb2wR6td3f/0a4yxw9j8+tQQgkNqUf68E69UwPc=;
 b=PTA/vjXkEpQCaiAWtFfzvhWCkPvSio9mVErhkxSaXtd6UvK0Q/NLs3d3wEEUlLOP8EqFtmxRzVXjpNTp25hNjppZKxlbFy2xO0BGliVZRb2uoYQs36CcXGnUsnVKLYqflCPsGv2dRO+RU0TxkVh/YJ7MGVJPUfTL9OcNy6MOJqE=
Received: from SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) by
 SEYPR02MB7173.apcprd02.prod.outlook.com (2603:1096:101:1a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 14:43:29 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:b6:cafe::e6) by SGAP274CA0014.outlook.office365.com
 (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Wed, 8 May 2024 14:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 14:43:28 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 8 May
 2024 22:43:27 +0800
Date: Wed, 8 May 2024 22:43:21 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
	<urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <chao@kernel.org>, Oven <liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <20240508144321.ymnhn54daaabalhe@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|SEYPR02MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b47cd1e-2f75-4d1b-1a1b-08dc6f6d397a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mfn5B1dz6IvB0kG5dEdwJrDlQlJIgVWp9XIjQkMAdMCAk21qzuGCK/R4IkZM?=
 =?us-ascii?Q?ydAM98I8Ovd2+tycm8zxmSAf/iWFLEQ8wsdIAEHpUw1/ZVHQBVAAOiqIgvY3?=
 =?us-ascii?Q?mGr36SXk6Zk1UGcwjQRE6m81KHcfTUXyjSbBBRmmsv+Cue6oDjsdd1El9zYr?=
 =?us-ascii?Q?IWlj4SBGTKPfJOgzep/ndFvuhfZRF0R5jkfnrNZgUIZhwqX/laIEPcOSw93A?=
 =?us-ascii?Q?aWISjMn8TpjTbiPqD0SXSTKxXwXpglnOhJ/lPK2yqtRslFTvKHijT/bols6j?=
 =?us-ascii?Q?Zp/g3PpuQK5pRVxkoocY8Cvi6cXUlhDWwFRh2VtOtuaSuy4PsOOp9RQtB02E?=
 =?us-ascii?Q?Rud6XsKL1nTfC6I61Ia8PtRPsXn4XaUexRvCU40TnLb5wpFRyQSN3KZSHwfy?=
 =?us-ascii?Q?U2IOZBzkSJ9bfhnKV+JMiSO1jJepZ2S3VZuZa7rXWrAyr6HMyDRQzU3/Z6YY?=
 =?us-ascii?Q?o3dh/MtZHHkeDTqrORhyymw8f78bNHyFakI73DebGym8Yu0DpwYSjBSNiOEb?=
 =?us-ascii?Q?uRA+2KM8CungrpzjqCOU6FEMcteKr6cXhbLSD3XQzHzJ3VcHhBhmwK0W/0jw?=
 =?us-ascii?Q?vFp9z5gAVatomArgtcjwAkJJvgI8IjtRn0NzSC0Go5JdKASE8OsSq3Djmxia?=
 =?us-ascii?Q?6VBxJaoa7zskxgpX4VNS9wllN9dKXW4PKKMGphJYKlCkdI6VY1GtW9Akjm1n?=
 =?us-ascii?Q?LaUtZU1Rv8GY/JKIfOOtzrPBByYctAAL6LlRHNcpWwPhi2NCwxtw5kjZspHy?=
 =?us-ascii?Q?nXcr/d6BrmkQVfJQugcrLll9tyP9rcCHxaIWgZQ1D5/z9sFMKPZRa35dEBGT?=
 =?us-ascii?Q?ACf8Fq4qAgj58Aee8i8MKX88K9XJHIF2tZun14ZKJR2uahpAsAeSSWtXbeIg?=
 =?us-ascii?Q?foUR4Qp7XHsWL4s6iAuWkqd/CNl4LDb/6owOwVc29ORym+HqZRgqZjJJUOan?=
 =?us-ascii?Q?GWAkpYvi63Nsk5JBqHSaChIOAb9ycOW23qVKrzg/Ne09XbH3HVk/05n2aFgu?=
 =?us-ascii?Q?6EqlA5H3bV5d9r9OUYMpD1w5uiMlk7RovSq3cbaYY1jNWn8QNRb8sFsGU3cZ?=
 =?us-ascii?Q?SUBfjMlCPCarqQquaahD6xlbbRgtkZYOl/udfY+0Vs7S3J8xWE9j4dJ0v1am?=
 =?us-ascii?Q?no3eOutPDNbJpZB24Sgn3//TwZ08dVmI+oD3zsMPPGRBdGVaJDjTEyifOJWt?=
 =?us-ascii?Q?v3ez8xC4ugXA481C+ntJDIsSYTBpc+P1MaWqUPjgnjl6HPVZo5ZYsY7jh0YS?=
 =?us-ascii?Q?TLIBxzwXBPRdOQknwcZFVrHjaiwwRlogxYQHehEMsHjNX0o3kXvcw3aDWfPM?=
 =?us-ascii?Q?83gCMdr0dCYIhnWafJhkWjEimoC3U8MyLhH01bzYG3K9v/p0YjJDgVUuH/XC?=
 =?us-ascii?Q?tDXaVtU=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:43:28.5252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b47cd1e-2f75-4d1b-1a1b-08dc6f6d397a
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7173

On Wed, 08. May 21:41, Gao Xiang wrote:
>
> +Cc Michal,
>
> On 2024/5/8 20:58, hailong.liu@oppo.com wrote:
> > From: "Hailong.Liu" <hailong.liu@oppo.com>
> >
> > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> > includes support for __GFP_NOFAIL, but it presents a conflict with
> > commit dd544141b9eb ("vmalloc: back off when the current task is
> > OOM-killed"). A possible scenario is as belows:
> >
> > process-a
> > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> >      __vmalloc_node_range()
> > 	__vmalloc_area_node()
> > 	    vm_area_alloc_pages()
> >              --> oom-killer send SIGKILL to process-a
> >              if (fatal_signal_pending(current)) break;
> > --> return NULL;
> >
> > to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> > if __GFP_NOFAIL set.
> >
> > Reported-by: Oven <liyangouwen1@oppo.com>
> > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
>
> Why taging this as RFC here?  It seems a corner-case fix of
> commit a421ef303008
>
> Thanks,
> Gao Xiang
>

Hi Gao Xiang:

RFC here to wait for a better way to handle this case :).
IMO, if vmalloc support __GFP_NOFAIL it should not return
null even system is deadlock on memory.

--

Best Regards,
Hailong.


Return-Path: <linux-kernel+bounces-261809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C787093BC66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38029B215F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3715EFC9;
	Thu, 25 Jul 2024 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="mWL96clu"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8461CA8A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721888127; cv=fail; b=gUE45A51QqLQgJHSbp8GCtIzQ9HxCFQ954q44CV8DZ82PSgkR71dW0UeneYWnsPpjoSerzvhUyI1v2xjtJLKYckddvefLEo9MbCpDX3KkbaPy7eRw40LUGDhXnCwNEFaNTvY6lAjyIhgSuxrpaLL7lsF/03iJ2DpiOgxz7HtxzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721888127; c=relaxed/simple;
	bh=yNm4Kcc5ZKGGwTVv/pw7b1Gj9Qryrvuhdh/4KFyNZFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZnHXvtKfsoKnmOMl/5YGtbbcePeJpUh5blQAWZGbtXzfJ7rLq3uNW5cJDgYdsS6rbVe5snNTPc9u9RLNt8xvZ6yeMAJGmp2ASfrsNNzdw6rYLN0i1D6kHF/4qd76Do2/8BOB3eE8f0jUbMot28KAisFtRdBzLihHG1FHFJRrz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=mWL96clu; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dziy0WHQnJZlavgQSofP0lbxhCDIUG9KxJV9VY7UOsTi5l/W1I7bgPyb2GYn+LQQmfcyLZTpMIUQNDZDVr/8n3aaJP/CG8R7nhw+rwa3yYPGHzYDa2f6qkgtJsYbY05t7OvrID3F4lazk+8uqTpWj3uYx21fv6oASRkF6OG9ij+EEIJPMeYMfZBRb74g+EXbLFzRII5DFRqpxjV+o6dAwnc9uF8WYkKWs36y7n8PBrdYuxLTFLClYUVFgS4nTmEcuiVG0B+tsTebS2RsXjwPhbjiGEJbuBAo/GPPizKnRbsqgkDTuB/aeM8LotZrbf9DoedUcyewsx0XT66qr1aHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi4wu7GC/INglxwYUHYbbkB5JKbj+2AlRO1PiI0QhOA=;
 b=tUO50XbXsJ/jLXjv9bKfdb7D2vQT7ax+A9JzOXiIpsIEipMNCxZhXWm8ufLR+AalFiObnA6QJ23+FEEL0io6khdPbuVA7R5SDn2aXjcSg0gJrvQrSVoV6N/WH6+hdQYY1++hrV1ZV1pFvxOcIiFB6CNbmi3bF3UvA4vVuMNkcnMEu5hGtxcGofXxzpL145z4bCX2Fa/raRv2UrvHHZjGlE6/PqbQpYfKJMsmO68j1UJYUx3S/MGbU5v9SVBKXT0maCp8UHX9KI/kN/KX1negTAQa+V1wy+vnZRMPhQcCD20k9zP/9y00/n8rH8X/vzOIdSldG1SUv/8VdSXW8CkYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=infradead.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi4wu7GC/INglxwYUHYbbkB5JKbj+2AlRO1PiI0QhOA=;
 b=mWL96cluQnKZDA9Hse8s0yWJrVEzXumX/vvnhZ9fDxE/6a2/LCOyo1KPRB2dhv1Esr/ZWraEeWyA2ux7K2VKbz86kGPpBlVDl/fZlt9iKVgSD2kDQyNXnvOPU9Qm9ExrtBq73SEgSJ3RzMM9a9udT2BmTGNhi85hNLXljWtTSbU=
Received: from SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32) by
 SI2PR02MB5636.apcprd02.prod.outlook.com (2603:1096:4:1ac::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Thu, 25 Jul 2024 06:15:16 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:b8:cafe::f8) by SGXP274CA0020.outlook.office365.com
 (2603:1096:4:b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 06:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 06:15:14 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 14:15:13 +0800
Date: Thu, 25 Jul 2024 14:15:13 +0800
From: Hailong.Liu <hailong.liu@oppo.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
	<mhocko@suse.com>, Barry Song <21cnbao@gmail.com>, "Tangquan . Zheng"
	<zhengtangquan@oppo.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <20240725061513.kiqu2k5z7rrl6a3f@oppo.com>
References: <20240724181916.31776-1-hailong.liu@oppo.com>
 <20240724182827.nlgdckimtg2gwns5@oppo.com>
 <ZqFdu73H3BguX4QG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZqFdu73H3BguX4QG@casper.infradead.org>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|SI2PR02MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e21b5b0-1814-4c3c-09f6-08dcac7125f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PyOkl4YXKsrBDgLQMajWVe1xYfEYZzou/CxcGmNwLfXTtRVTmXcK9l4vjTvw?=
 =?us-ascii?Q?eBi16Q+wXDq9gU5mKseGZ21umH7Kr552ab+49zdKZIzlkYE18U8d6BJ+qF+s?=
 =?us-ascii?Q?PQN26vZVZ5uPJS2j3Jwj15C5rBqRfW/3ZoOZG1cBw1OwlIDeFBWoe1Ji0+nh?=
 =?us-ascii?Q?Wwzg0ZLEMvLj0RQcEjwF9+wC3nh2sR3iBLlaFQ4we0R04e43cPwCSYgwtpoX?=
 =?us-ascii?Q?dmews1jTPMwoKsu+MScZrTbX2q1ZgpaAjnlvuxKE0eI4rCFlwN3gRdiFq+ra?=
 =?us-ascii?Q?LmXyCtA2EI5gseak22n6vy0bpHUbTBHsUYKIjpbqSRBPAgFnIoplosL6O2Db?=
 =?us-ascii?Q?eY6HEvCMyt4UeE07Pw6SPpAvwgstrchf3Sfd0PxUt7Hd87ZX9FdH6bLVKBI4?=
 =?us-ascii?Q?35fiLZ/A8pkYjdYvcey4JLrg45Yqq9Cui9Y3/HLwCuo+VD2KPSygB0Rw2RBf?=
 =?us-ascii?Q?DyRLd1ekVOT+g3Trb74SSRi0wYxUCMr9sGn7oPip5raOTkJfZFQbVaWrZH4G?=
 =?us-ascii?Q?VWOt8fD1FLrhhUzr9eL4AeC36AW9vxJDAp2eS4bAbKAr3z82eTyBAEd+2P9S?=
 =?us-ascii?Q?3bklxSOt2Y/dNIL9zznAAcNPzh2r/d7SMZu9rQ/eGGP+S1lVXattOwCJUHad?=
 =?us-ascii?Q?Ke0m62NUe8yoRDZo9CzlwgQU7qhPXePgowmMYZZvtG3vc188z8WE/aBFqLAq?=
 =?us-ascii?Q?nGvtQ4xZY2F7T8gXIpYFymq0/dQO17VRiDk1NtsN0hjMpvLXBefiSqrjLOiM?=
 =?us-ascii?Q?VFgMqSEsWSVYSZlirCkZXv7kidp9Yml2TnsTvL2nD+V47kWuLCdmgIVfLxG5?=
 =?us-ascii?Q?/ZN7IzsCKUQ9F9UaMvi2OC/E0vYrleL81pBNuWqir3HUK+xfjBoAxzDYg1cv?=
 =?us-ascii?Q?tWkrAEeGK2ajlBfae/1fvSSLtdrrQNK6hFSoHwa42Y9FBJ/H7H/atwngNifL?=
 =?us-ascii?Q?6s4QtBK24QBodGtTaGyA6N2ra58tWaBaRl2R6d8N/1e0Lhg/3Spl2Ryf8MGl?=
 =?us-ascii?Q?KisjfU7W1CcY02j1SecK7dHFOcjRw59dduHLzkEn0pnQZ2lXM1GtvrfXCGYi?=
 =?us-ascii?Q?q0b3VWbUM8cV6z7cwbninUZ31dDAYmsoSslZjfDS4qOpzBl/+j+Q35Jb2rOi?=
 =?us-ascii?Q?+Ui6T69ruCTQ5SOwbi7ghEeSSGFtcdadND1sFrvj5AAXVw1DpkUdslSYsGNz?=
 =?us-ascii?Q?7AfGPSr6BmIjDqvcy+pBIQ7Q0fpXBWZaFg83CIYDRnNWKf5+HSE87CTvTrar?=
 =?us-ascii?Q?pX362WflHQyPk5U8eunVezkKWKuyBQz0l5+9HS6+sV3IQDNHZ2jIKuHc2dZL?=
 =?us-ascii?Q?a+MpqffJQzQezIX5Q+4ndyLLaLJ22E2tMeIUGZRh/SdjA1DYRYlmgUFoaSeJ?=
 =?us-ascii?Q?hXWXS+J3KtJxgpX8zM6KRV88kZVWd7nYbqyKXi20PXtWs9T18A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 06:15:14.6509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e21b5b0-1814-4c3c-09f6-08dcac7125f1
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5636

On Wed, 24. Jul 21:02, Matthew Wilcox wrote:
> On Thu, Jul 25, 2024 at 02:28:27AM +0800, Hailong.Liu wrote:
> > >  	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> > > -			page_shift == PAGE_SHIFT)
> > > -		return vmap_small_pages_range_noflush(addr, end, prot, pages);
> > > +			page_shift == PAGE_SHIFT ||
> > > +			page_private(pages[0]) == VM_AREA_ALLOC_PAGES_FALLBACK) {
> > > +		int ret = vmap_small_pages_range_noflush(addr, end, prot, pages);
> > > +
> > > +		set_page_private(pages[0], 0);
> > > +		return ret;
> > > +	}
> > >
> > >  	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
> > >  		int err;
> > > @@ -3583,6 +3590,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >
> > >  			/* fall back to the zero order allocations */
> > >  			alloc_gfp |= __GFP_NOFAIL;
> > > +			fallback = true;
> > Sry for my mistake, I forget define fallback here.
> > BTW, This is not the optimal solution. Does anyone have a better idea? Glad to
> > hear:)
>
> Yeah, I really don't like this approach.  You could return a small
> struct indicating both nr_allocated and whether you had to fall back.
> Or you could pass a bool * parameter.  They're both pretty nasty.
Agree. Thanks for pointing out. I send a rfc-v2 patch with a different solution.
pls help review.
https://lore.kernel.org/all/20240725035318.471-1-hailong.liu@oppo.com/T/#u

--
help you, help me,
Hailong.


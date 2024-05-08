Return-Path: <linux-kernel+bounces-173487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56C28C00FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D5CB214D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DC127B5D;
	Wed,  8 May 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="kkAyf+7a"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2066.outbound.protection.outlook.com [40.107.117.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA0127B4D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182307; cv=fail; b=sqKj6LFjONgq8tAii6FRjJksfdm/mS+xvji/oj+7gw8ykh0MZjabDN4y1hn20hR7BvUMKC4fK/ETJ7Rb4Pzb7GAvM88pr9wSSFdiHKxNWaHm19Yoa1AqG6lTHQLsf6fG0JuOTf4/Vc3tFbtnnpki+ckuksYzKqJSLkQeHXMmnVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182307; c=relaxed/simple;
	bh=MXCoKDpRXyomjpLZXTK3dr5njaxRIkUPGvqkZA4vFMg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk8z0f6SvkQaCbq/TLqNX8L1xUWxN7pshkhoE9LWxI9hcGUTj7ywZD9dQpJiZDXAhOA/uSxag1VpljfNYXsyrMCxwxxnsm/yS8UXCAzu0mn+GU9uHucNMkychFZMt+mJfIHSMxaaRrZ7cvCtzni67bKkg3iyN5XnNnEpeJGkOrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=kkAyf+7a; arc=fail smtp.client-ip=40.107.117.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpsayA18I/PNmAgdX0RRk4te/ZiFRnplVZTs925f1Tn0Ht8cSh9sRBcAiKhtZvzbQxkjRUkN32UNNpZrrZMXhr/dFc3bWCk9VMaRKttWPd0cDWbo9ouR0dpZ4rm/P7+WQlZjPNWJAfy8IKAvVyJccD2VrFZEdzcXmaHIl3/SBUeljiiVqwxlSYjeM5+gB5ndeQkH/lbaPwyg+/H/KAlWGupSyQTTyyf7B97RZ0artVBJBjpC3Wd2wxQamYbfjLboc6lKiJEtDoKhT8uildj16UwSWBgJeGoh4d3PC8IssF+cM+YjGaonxcgb5dnVzx7Rh/Mhl/ij+Ycw3bwCOo9EhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcHCljWtIF97d9+FsoaVCPlRTiA8Jy6/alIXe/5Jjas=;
 b=nwaq1pB+YZ8+P1+bWrTDbLvyQ6nE3gWmW+jo6SDyAbBJfOUsj85q3qfeYTY/WFS79CS6BzAtmWQ4Cfkc3gWKItwHg5EtNTg1MNIWQCpbdQVVq2B/fZtlyC4lATrv/C40btGXh7niMoJFl/xb8WdzqlwzpzWMb7zT3wJxfd0CSIS9NoCeviNGBi565ts1YWuAcVoXjZtD6VYZBpqJFSA074UK/Z0/MIyBuJUV/b80EpcC1YQWNzJURC171SC2DhxgpMJl5u+r5oGxCmH3jMO7QnpPzcFoRLmrSjLvFjXLkU2cL+9cEv9fHXVe3y7rrlUPa39dUiSESDI9PTY70KaJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcHCljWtIF97d9+FsoaVCPlRTiA8Jy6/alIXe/5Jjas=;
 b=kkAyf+7afwGeoHQhe0wbzN/JA7Cn4MkpsoizEXMCcBDrRuzSWhee0z2pm4Gpr9gC3NI1ngeSQb89k5FwvPntXc0REH6yKTyxtqzW8JW8shQ8xAfZVLJ/q4tjyKcNmbJ/VpoaZIV54dQanWvg93uoP8AgBZp9puEevJDLqjs0NBk=
Received: from SI2PR06CA0014.apcprd06.prod.outlook.com (2603:1096:4:186::11)
 by TYZPR02MB5892.apcprd02.prod.outlook.com (2603:1096:400:1fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 15:31:41 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:4:186:cafe::5b) by SI2PR06CA0014.outlook.office365.com
 (2603:1096:4:186::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.44 via Frontend
 Transport; Wed, 8 May 2024 15:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 15:31:37 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 8 May
 2024 23:31:36 +0800
Date: Wed, 8 May 2024 23:31:36 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
	<urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <chao@kernel.org>, Oven <liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <20240508153136.x4rxildsgza234uv@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
 <20240508144321.ymnhn54daaabalhe@oppo.com>
 <90a127e5-d884-44b5-bb76-773a7485c2f1@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <90a127e5-d884-44b5-bb76-773a7485c2f1@linux.alibaba.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYZPR02MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 53df1b1d-43eb-46b9-ffe4-08dc6f73f3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tgzBI9HTknOwlV52XEr1DWvH5fMnvk9jWJT0OoydHsWJPUNXoLOy0xcLnQNZ?=
 =?us-ascii?Q?N4fnb/4zg+0/aFiuMEhRYR7PH9omMno5klaph2HSAIeLzeM892vL6Sdh1Nxb?=
 =?us-ascii?Q?q8iaXe48yYJBysCKiJAhmLYi99wERE2rwYqe/nn5e4yCmuY2Qj9iY0K7WaDW?=
 =?us-ascii?Q?wLuu1xNWN3TmkYzJuon8sw+7PESO50Lb647H7gytZyvlJ+d3witYURN3xA6P?=
 =?us-ascii?Q?/YOkAbtUhGPRMn20+hSWz35MaqQfZCY6xb6z9MwaW7syhFp0tI7I6u2RcIfE?=
 =?us-ascii?Q?TEe283ivpXvY2vxJT8MrsvZKXZ0mWgMZGhvXZN/Gbv3/BBlBgita2APTundW?=
 =?us-ascii?Q?y41KBcMgR6WMyWt5iHYd4L6K0WT6YPD71DgQGwIKbKxAGqkbctO+5tUt0Gxw?=
 =?us-ascii?Q?eYAeHGSEA45w7zduX1UhhynWLCGNxy87Yd/6R8yvR/SG/HE/gusFR5s9R2es?=
 =?us-ascii?Q?/SXjTDn1oS2WQCiflBFXh67PmxkAjy4qJ8VUepWmzFrW/8AZbMgusmLAJaKW?=
 =?us-ascii?Q?yBOSM6dqL2cMfO5iC7ObRAoRZ6gVC7E8SXcCuzeQToTAgw/z8vPXXjmoqw3/?=
 =?us-ascii?Q?e7Sxcbuq0eeK92qFLmZgsUZD0W3l23Yib0qpesm1idivH4mmz1NqW9bnvto2?=
 =?us-ascii?Q?6oXP8Xj8dTFjZE/RHtrPoz87mA1/2KqDYnk/lN7Vrzz1AuYR9bXU/7/xfuoT?=
 =?us-ascii?Q?2t1afc0FdmxC30kd34APMAzB+oQQ4ZqcgTp6ShUkSF62rNztP/yLvlnETNxM?=
 =?us-ascii?Q?F2xkDYTjaYCdHDzHHXzFEIZpUz2g9aN7La7bf3kCGGtHEugGJzLWu78vFAhv?=
 =?us-ascii?Q?KcBYM0tUUao9yCBu5cTFEgcPjLU2I8V9lCgO8P7sAm5/u1jW74gQENZUKdN7?=
 =?us-ascii?Q?oUfa1zX/zZd+55nfakBdZfAWkhiDEfbZIg/LmgZLXltvyiRoGZoTVM0p4CuR?=
 =?us-ascii?Q?2+T5FXvludi/YDWbqAyhWYEEsmUVYK/+WXra+iXSWghlyY7bh2/QoJcB8DeS?=
 =?us-ascii?Q?VFTFqlW9gKo/51cUAYugDree/cOVuWTWqNt2BWOpYVQqqEq1dtlmzAhznREA?=
 =?us-ascii?Q?wKZM6pK6nQ+4Y5aO2K3a7Wp005ILCoxW5QyzHWSXbojcYwQ2Hmxuukrv/X0d?=
 =?us-ascii?Q?GRS+LZjlfcuE6ap7n5c3JWxDTMakwxvlAmA0cmGBPd7jgZhOIMgDY3FiZeO+?=
 =?us-ascii?Q?GwpuqcvjAMgfzaLoxDTPiF6pWx2GbtYLf9Qfgu6OhPdBMUkkRV51jHQgCIKv?=
 =?us-ascii?Q?Ds2FiiqssGcQuyYLxE/vX59QGo3s5N+13ys+w4JAnbK3VMic37Nfqkj2J+RC?=
 =?us-ascii?Q?fEuJY+ySs4h8tLpkmAU+/sQZ?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:31:37.9614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53df1b1d-43eb-46b9-ffe4-08dc6f73f3c2
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5892

On Wed, 08. May 23:10, Gao Xiang wrote:
> Hi,
>
> On 2024/5/8 22:43, Hailong Liu wrote:
> > On Wed, 08. May 21:41, Gao Xiang wrote:
> > >
> > > +Cc Michal,
> > >
> > > On 2024/5/8 20:58, hailong.liu@oppo.com wrote:
> > > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > > >
> > > > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> > > > includes support for __GFP_NOFAIL, but it presents a conflict with
> > > > commit dd544141b9eb ("vmalloc: back off when the current task is
> > > > OOM-killed"). A possible scenario is as belows:
> > > >
> > > > process-a
> > > > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> > > >       __vmalloc_node_range()
> > > > 	__vmalloc_area_node()
> > > > 	    vm_area_alloc_pages()
> > > >               --> oom-killer send SIGKILL to process-a
> > > >               if (fatal_signal_pending(current)) break;
> > > > --> return NULL;
> > > >
> > > > to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> > > > if __GFP_NOFAIL set.
> > > >
> > > > Reported-by: Oven <liyangouwen1@oppo.com>
> > > > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > >
> > > Why taging this as RFC here?  It seems a corner-case fix of
> > > commit a421ef303008
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> >
> > Hi Gao Xiang:
> >
> > RFC here to wait for a better way to handle this case :).
> > IMO, if vmalloc support __GFP_NOFAIL it should not return
> > null even system is deadlock on memory.
>
> The starting point is that kmalloc doesn't support __GFP_NOFAIL
> if order > 1 (even for very short temporary uses), see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/page_alloc.c?h=v6.8#n2896
>
> but it is possible if we have such page pointer array (since two
> (order-1) pages can only keep 1024 8-byte entries, it can happen
> if compression ratios are high), and kvmalloc(__GFP_NOFAIL) has
> already been supported for almost two years, it will fallback to
> order-0 allocation as described in commit e9c3cda4d86e
> ("mm, vmalloc: fix high order __GFP_NOFAIL allocations").
>
> With my limited understanding, I'm not sure why it can cause
> deadlock here since it will fallback to order-0 allocation then,
> and such allocation is just for short temporary uses again
> because kmalloc doesn't support order > 1 short memory
> allocation strictly.
>

deadlock on memory meands there is a memory leak causing
system to be unable to allocate memory not actual
*deadlock*.

> Thanks,
> Gao Xiang
>

--

Best Regards,
Hailong.


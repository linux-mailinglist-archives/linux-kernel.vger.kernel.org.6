Return-Path: <linux-kernel+bounces-262827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AEC93CD68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D4AB21EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173AD38385;
	Fri, 26 Jul 2024 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="vI12S0yg"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2047.outbound.protection.outlook.com [40.107.215.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E81381B8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970244; cv=fail; b=mssmwCQ9Y8Fkx/4KCGLzbxBkgrrLj20ky1Nju0Ayn+iphe7Mjm7cH05/e+X+jdr0RIthpfgyO6sRLnb7klb7ImV00SyPd53/FL7LfB1+H8a68nLH56OkWkB1d3f7x+74HHQl9eKowkwIfthxAZaBVz3ctj7hiOHG3eec9Rm9Haw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970244; c=relaxed/simple;
	bh=a5EunrreR/8AaayXEo7Is5ihO6lxIm+eJDhurmwqcFQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgZYODmS0PhUbUGoZB89eHsVqTuBor4M3Iqi9x9rFH9HgCTECxlJHC80193kfyTUXfChlw+VAI2inNGAxwd3UPjsOvVAC30kLjt9nEbN+10VS2CKFcfQX5LQ/guP+5bgxx0qBJFBjOz3iTedN2kc5bOGOGe9FRuUfE2jYjxEtco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=vI12S0yg; arc=fail smtp.client-ip=40.107.215.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3bOSYq6PvJ4byHt/HihYStCsHq6U82cG/hsD9OOUEYquGqvzJUGCJcy7z+JJ6ea7aXxSDlodA3fk+qZa5y9HCEg+//Cquqbou7X+3r9Utbv8K8GzPSmvzcG48KYBJ/LSQv4+R+pGS3/C+6jz2uqc+X1S1tva5LzpkaTX4CZWAqL723pOxspJOH3Bnq45rOURPHeeMpnAYoQ8kdyiq2m7olTtuf0yTRTGnpv3bFQSjTO3n0lzQqGEx3q2mEYaqqYtLwGZCbfjAMFtZRBvvYB5oWoPD5FuU+QPlyRRUf9qftFeWYQPucZ8bUl3gCQtrwKQScGGs+jTJKiNeSXnDZEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7bt0vKm/ma/3T57CTHgQWnM/qal+tsztK/1r97N5OQ=;
 b=yweMP6Dds2fik935fRPHRSmzoz2rjaXNIELv661wQbEcz0Aad2Z1r47QNkn5v7pYPWH0CKaIE+hJeH+o+BsxxaksnMizhkP1VA3GV5JUdn80y0luzts4DedWjd6icpkz1S4+hO0TDEqmFDMjB2j0myXyblWP9kdmHNfRGjstOTW+QaXZddIevZKhp++NYsvp3Tt9M9nfLEFrCXpmZyancvUhysqz83F2dVNPDmjX6ynOIJ3KrjKBwUXHDJ5txHDTnQ8LlYWXbOpxSJO7ur0JOdRXjdZkmxQTxVHsw5ozCzHJx4k5rbx0dlKp/PI2+11Rb00wfxZW6mpFOzQaTRKJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7bt0vKm/ma/3T57CTHgQWnM/qal+tsztK/1r97N5OQ=;
 b=vI12S0ygr1NZh9AQBz8Zs9ihX4w4JuGoEIEkuaVgS+kkY8/0zim3pcdORLJMrpLcpsnCWX6s/iSXI2ZgXLf/pPELsfPuQnizXkBpnM/GHa1GfaOnjOriFgKCPN9ImtBLhGncPAMZ5H28yxmhnZ6dvkKHWUa5z6nbc6NMAnD5DjE=
Received: from SI2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::20) by
 TYZPR02MB6935.apcprd02.prod.outlook.com (2603:1096:405:2a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Fri, 26 Jul 2024 05:03:58 +0000
Received: from HK2PEPF00006FAE.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::a2) by SI2P153CA0003.outlook.office365.com
 (2603:1096:4:140::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.11 via Frontend
 Transport; Fri, 26 Jul 2024 05:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FAE.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 05:03:57 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 13:03:56 +0800
Date: Fri, 26 Jul 2024 13:03:56 +0800
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
Message-ID: <20240726050356.ludmpxfee6erlxxt@oppo.com>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
 <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
 <20240726040052.hs2gvpktrnlbvhsq@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240726040052.hs2gvpktrnlbvhsq@oppo.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAE:EE_|TYZPR02MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 23af7a75-9bad-49a3-369e-08dcad305b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vpdu2uiuGSQTAHa2ZfFddRj6mHsiAtrcYbQi0BrXZjyxljj+XV66HyRgPEJs?=
 =?us-ascii?Q?RwyijOq87ylSp+lLtFmZJVtM6LEThTUYdh98WaBzJR0dMDD6HuTJN8OsYW+A?=
 =?us-ascii?Q?D5fkHaeunH87k5oHRtpOhxv8wMW5kyIVkylJoKF2bWEqwXWYOWnSm4if889k?=
 =?us-ascii?Q?8guJpks8ZtAMJyZ4Z+lHyMTqh83XXy6gU3VT/YXVNBzF/gun1p9GpkPKMfTy?=
 =?us-ascii?Q?A52G7cczO1F0POLtI57OZVRJ67qDKkAQ0v8a4jfLmuelagip4iuN9r67Wg0V?=
 =?us-ascii?Q?dHqze+tdJiDAtiXzgLSD5x4NsAvAsBx4AnqBLMvWI4VQgQUBviKBrVcqSE96?=
 =?us-ascii?Q?u8YnuwaUmXYF0bRc9pdLwnE6HwAbU2dCwYXTAZqwm8p//0n77V439gr/1RMm?=
 =?us-ascii?Q?JC5Ho3BCNzMBnohw3d34MOw0gSlpcbq17CtY+03Hugzr0EpEY9S/70jFEXti?=
 =?us-ascii?Q?gD+Z+slMPcZiRngdUQodXgr97RZtcvoDc8agMYqKSGSiZrcQYpR3e5CrmUEM?=
 =?us-ascii?Q?2nxtlsYMhu3Vl0QMb4qy08+0war2M3AWjLAFmALhZqJP9xY2fIxLbWGZcyK/?=
 =?us-ascii?Q?Ialz2VD7xdJwsh+Csgu7bzEYyNQpOeAPhjOkDdsQsvV9gZ4c80Wp5GGEueHn?=
 =?us-ascii?Q?XjVCNKDGkJ0WTbCvV64x9UnFXPWBTpHWaPPPlAwgT9RUnaMRw78v950rUCMq?=
 =?us-ascii?Q?sy/n2Ovq289Gz0uf8zmmavz0f353OAItMt3/5Xz/YIdzO1pgySFnwagQUqHU?=
 =?us-ascii?Q?lRuHGlznYN0ey+6RQxK3wfFrDwQTOxApxMGyLZBrHLNXoDgSlHGyc7425v+v?=
 =?us-ascii?Q?rc7awxLdihBePbNvznrUSpZWC2oxXzbeA+6j9tqLXm9L9Yke5f/EZNC1CSvp?=
 =?us-ascii?Q?YCxUJLwnqDj+pMJl164mlJXGcpS7UadwtV99V7Qi1tv2HyUARYsk59Wne5Hl?=
 =?us-ascii?Q?2+9gFrZd6AIvOxjME3b1MLIEtRR9NscyKpcJzgZD7xg4/nDjiG6NOsIop077?=
 =?us-ascii?Q?EYV1wKyBUiF8Ro4HuI2cyNfEHZy0SWFAYUiEO2LcYAH/myLlh2UGpngd5+Bi?=
 =?us-ascii?Q?vFVoFa5ai2vflZi8kJzcMqbZh37x8zws4yPDXq0utXLuog3+smkSOCRVMF1R?=
 =?us-ascii?Q?kicPKUPQf73E1soow6u2GQ0lCqLWkX4IatNaHqJwCmgdpZaBUj2uVDG9sUuU?=
 =?us-ascii?Q?KZTpZ2XJVpOqmtyXM+mWO5WKMOYPK7Qrxf3N/qWlddyXQlb+2ZONBY2d2Idv?=
 =?us-ascii?Q?4lleBDoBinzMlZ2E8j/4gw9GwBlUZQ2fJdbE408WSqJnkDSCG9YRzPuydqDF?=
 =?us-ascii?Q?R3M/sFHMJSuQwd68w22eQWjv4XCPD+67EelVgzgTvVtwRu69NxC7kClYW2eZ?=
 =?us-ascii?Q?DK7rA8yL1YXn7F8fMsPK3yTwgspTgrbf+NX5Y7I2hKv7BUYBw9B5is0iJOwi?=
 =?us-ascii?Q?E7irLjaJ9K+b5J/9DEXx4Dw3HK2FiblA?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 05:03:57.6110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23af7a75-9bad-49a3-369e-08dcad305b16
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FAE.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6935

On Fri, 26. Jul 12:00, Hailong Liu wrote:
> On Fri, 26. Jul 10:31, Baoquan He wrote:
> [...]
> > > The logic of this patch is somewhat similar to my first one. If high order
> > > allocation fails, it will go normal mapping.
> > >
> > > However I also save the fallback position. The ones before this position are
> > > used for huge mapping, the ones >= position for normal mapping as Barry said.
> > > "support the combination of PMD and PTE mapping". this  will take some
> > > times as it needs to address the corner cases and do some tests.
> >
> > Hmm, we may not need to worry about the imperfect mapping. Currently
> > there are two places setting VM_ALLOW_HUGE_VMAP: __kvmalloc_node_noprof()
> > and vmalloc_huge().
> >
> > For vmalloc_huge(), it's called in below three interfaces which are all
> > invoked during boot. Basically they can succeed to get required contiguous
> > physical memory. I guess that's why Tangquan only spot this issue on kvmalloc
> > invocation when the required size exceeds e.g 2M. For kvmalloc_node(),
> > we have told that in the code comment above __kvmalloc_node_noprof(),
> > it's a best effort behaviour.
> >
> Take a __vmalloc_node_range(2.1M, VM_ALLOW_HUGE_VMAP) as a example.
> because the align requirement of huge. the real size is 4M.
> if allocation first order-9 successfully and the next failed. becuase the
> fallback, the layout out pages would be like order9 - 512 * order0
> order9 support huge mapping, but order0 not.
> with the patch above, would call vmap_small_pages_range_noflush() and do normal
> mapping, the huge mapping would not exist.
>
> >  mm/mm_init.c <<alloc_large_system_hash>>
> >  table = vmalloc_huge(size, gfp_flags);
> >  net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
> >  new_hashinfo->ehash = vmalloc_huge(ehash_entries * sizeof(struct inet_ehash_bucket),
> >  net/ipv4/udp.c <<udp_pernet_table_alloc>>
> >  udptable->hash = vmalloc_huge(hash_entries * 2 * sizeof(struct udp_hslot)
> >
> > Maybe we should add code comment or document to notice people that the
> > contiguous physical pages are not guaranteed for vmalloc_huge() if you
> > use it after boot.
> >
> > >
> > > IMO, the draft can fix the current issue, it also does not have significant side
> > > effects. Barry, what do you think about this patch? If you think it's okay,
> > > I will split this patch into two: one to remove the VM_ALLOW_HUGE_VMAP and the
> > > other to address the current mapping issue.
> > >
> > > --
> > > help you, help me,
> > > Hailong.
> > >
> >
> >
I check the code, the issue only happen in gfp_mask with __GFP_NOFAIL and
fallback to order 0, actuaally without this commit
e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
if __vmalloc_area_node allocation failed, it will goto fail and try order-0.

fail:
	if (shift > PAGE_SHIFT) {
		shift = PAGE_SHIFT;
		align = real_align;
		size = real_size;
		goto again;
	}

So do we really need fallback to order-0 if nofail?
>
> --
> help you, help me,
> Hailong.
>

--
help you, help me,
Hailong.


Return-Path: <linux-kernel+bounces-562270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61322A620EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE14461B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345611EEA33;
	Fri, 14 Mar 2025 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Il3GXSLx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DE1B0F2C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741992944; cv=fail; b=C2lkJO4oNbF3PL8D3TKxJTdB9dRBaWLS9kCRdilnY+8jEuPLYd2VwRW5PRBe6JZwE8mILj/JLRiFmKKej0NPz6ziIzOey23VGevDdNPlXaWIOevh29qdOBpfj2tTfbQbnUnodReBl7H04NQ71Wbdq297bTaHc8MBxc6wMBwdKaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741992944; c=relaxed/simple;
	bh=geSoRdnlE/bBaIVgLCK7KbBZXEZMOyapjrqZEPN13cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/yJM6+JdlvQ/3T2KxcfYWmVt0gfd/83GA62RTaM+UIv/O93MmNJsqWExz19tuNSZnzcpW/meVe+hrCL2d/ZPaWTbW1U/NT0IxEOZuNjLs0NhWwi3Jfr06SXVCumQm3s/50SzZKVxoMWEd4Iu5SIHXGoUcePnNfQWD7ijGmMOrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Il3GXSLx; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5/l7MA0prs4+EcykXYK98qqXy1bcOn7arOddppWhFI9TvbfF5ooxv28Tw67bl6JMu2UHs2QiHYxfBC2GvoZ4tEhIwCTAZ5aQHbgc70RFaOesdVqfKgdx90G2RBIzRoU+5WmI3ZdSCZizTewIhkz74qzzfZpvuxa96ROoKI+JNstGf+0GtLS56heAADoPpV0xcMPY2uYlg5luZpIrqeyqVhauBznfRrB+6aoKI7yZp3fYoIho9b1HTUtCvZcMl7+tdo4dy0gTkgZNj9BiYR69FoyySglBSziIhdkunH4wFnATwiC+aIKDR7mchxKKU90CgvZ15fFptXaqqChHZl7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G78MQ0WfCjM5sh42Q/ksmefmRLYRTlz1zLDOHyuC78M=;
 b=tBxkRBipjkvGCCpVOudC5vFpHCEaZiLwSkUBLO6quM5j1Sz4ioWrxQ7v1vbhcR/lUUJTtKWM45PUc6SFmdsGWLDSlWGziPrNpA01QQzC2/NAGT8qkDU3nl44qhL++ds2+k6MVF0Wx3hB0B2/NwuUg1by6utSn7O9hbaFS/YU3ggHIH5Hu1w/OtbBDPul7CiRxhvb9cPQvzP+b4Sb4CBgvUS2j5F53DpMfHNCvBUwUD4/zCtVvO9/AeVHEnIDrH7hlth/Z2mYBXRMr3ljPm/4rRwjSsiLx36BVsQeH7pqC4gH5nLaBfsWvH82IShJ1yMDt0TRF5iq4xBygUG4Bi6kGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G78MQ0WfCjM5sh42Q/ksmefmRLYRTlz1zLDOHyuC78M=;
 b=Il3GXSLx+L9qoIOfGNujH1eCYhf//pHU9bUJ/OOmmLEjvwuhicfNINA1GU9ZJijjPQJw5zWmPm4bjy53f9kIZuu0c93993Zr5FDGkHH49WD/6nnlv4tOnt9ET+frJw4jN10PBfmxrvlsCovVKXaNDmFoNM+6omaVIidGggXWNXxCznlDHQPsDRR6qUOnV2RpwObZxQqxbf3N+O+wihWSq1w4nbQ+gNZ7Ox+qT7eKE9larplL6Q0aClNPkUe4CbbMMeTAJrG+iffTIW+Tr3XpykWUR3pSMf2vZ1gcDEeC8QaA/QSrY2Mw91yoIa6Cyech6j8Jgeo6cV3DQm3VUe0osw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PPF864563BFB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 22:55:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 22:55:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: page_alloc: defrag_mode
Date: Fri, 14 Mar 2025 18:54:43 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <FC6F2207-E1A0-4AD1-86B9-E6CAA1C281C4@nvidia.com>
In-Reply-To: <20250314205039.GC1316033@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-4-hannes@cmpxchg.org>
 <E0358860-624D-4C9F-84E8-4887EE4DD8D4@nvidia.com>
 <20250314205039.GC1316033@cmpxchg.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR1501CA0026.namprd15.prod.outlook.com
 (2603:10b6:207:17::39) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PPF864563BFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b771e32-24e9-4617-8d0d-08dd634b5689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5WjdGpybAALDiLv7H5TQQp14jTeCS9DCAd0tzgL5PaH53B0oyDa8+Kyhu5m?=
 =?us-ascii?Q?lMJHUS8QRAjZ1p4tbExZBNexNT1H7LG/8GctDikmgaHoW5lMAeWhr6sPNIa5?=
 =?us-ascii?Q?aM3hwU/IeHRTzpTn0LAuOsK4zmNEqAY1F6Ob068IKFKhH+OW8E9FnmuhNfrG?=
 =?us-ascii?Q?wpGwEY+c/0prjRFF6ThZMOwIoZb4w6muydLsQUkcNptY2V0wDzO3jzUj3QAv?=
 =?us-ascii?Q?vBsKQvgf6b4Ii4VGXw9yQoZrp49+RVvJ/wmf9UcGwClfohMyiX5StaxsF4Yc?=
 =?us-ascii?Q?u5qioLOns/ES3zhYLxuS4ZQa9vpenZBJeQ5LBxf/XJoVftLYYhuK07mqtdz4?=
 =?us-ascii?Q?5B4VAdiPyitir86E7RrL9U/JmYJk8PQf0FQlnA5+tn7QE59SpzWw5s3qnK0a?=
 =?us-ascii?Q?UmMrrsWEuIvFKKSL4yyDWVY6YnonUFQ1sCDDGkz01OHeHg8xobrAseyN17Fv?=
 =?us-ascii?Q?GhVTI4LYdz+mFMeKxJXRAR3yyurDZ0SmK/5uQhFtDC9dMBBf19pFi6zt9uBa?=
 =?us-ascii?Q?CGt4TSiXAKy+O/TupgdnCSOwNVEMnSGuNJXbbEjFSVv6Ydm747tAHXVUFdBQ?=
 =?us-ascii?Q?yOgg8cGhS+5pz7Km52YDx4IKS7R59h5OTksX9YhZTXP0UIRKXiaU7r53RGeA?=
 =?us-ascii?Q?0G/gFr761kmQqSZamNsMePIFPamVcB/qM6tWYPiNhLVe9ELz7LHXWmW+dtnP?=
 =?us-ascii?Q?Hl2THya7HpJYM1Xbj728O6XNMp7vTkffWJwrxRI8HWBPhPY0zBh6eiwd4R0l?=
 =?us-ascii?Q?fUr5Vo6B8A4sMDxLyTKgRFdR33X4YrIMbEiN3C1ju4v/g0JC0U08XrnFvC5J?=
 =?us-ascii?Q?x9O/aBkfqs8+qakD+eca/msoor6ECB084mqsPkc/MHUufxCkrslSQBkK+nxC?=
 =?us-ascii?Q?YvjYko08T/s3svG+LYNAVaN2K+SQydFvUu+y20Uuiv0aeciVKyoHgpZ+1x0T?=
 =?us-ascii?Q?MvuE8lZh9svuq7bZ15M8k32WIXAICVc/QW3AGOsObrk+LwW6wGj529Qng9SR?=
 =?us-ascii?Q?bVZbiFBRNAKqEloIsPHzN5yz4kDOVvO/rlQ67pVcXyu3N5ZMXv19nqFE9vfa?=
 =?us-ascii?Q?Gx6ZFvqbahoJDU20ZmOykDlegXxsiucgBmMPScUvlz05UT0FPxckPMO5lwaS?=
 =?us-ascii?Q?UwBw7Lk01SvAWd8nzGxIXIM5VxAuK4gjgVS0J987xd37xY5Se+WZuH08YSD6?=
 =?us-ascii?Q?Ph5bVrHX9V+ozr2SsUW5p2rmpTbcIQiKhj44bSB94qjF6fV6yf0Jn7a3bTRw?=
 =?us-ascii?Q?iPIV/f5eJWp6V2QvBzoN8WTRcNQ274BsGWE8o0L1y++KtftiGcE8/DpWuiAu?=
 =?us-ascii?Q?st5bcMvfyjkTmPp/fuKQXhcS0w3lTm2L/MhOCkqNly5bE7+9h83+8WYXqjwa?=
 =?us-ascii?Q?SncmAEOWVy8kiYyEW/p1+kRtKXI8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RTFquVD9t4Xkmg3nju2actBZDvWOsEcMMpWA2WgEuojNTkxH+Qq5Q9tB+EAt?=
 =?us-ascii?Q?RxYseSDx28vpsHp/Lx+7VAubHRdLuUW814FNrugouJHLSti4JMxilN+i8Bql?=
 =?us-ascii?Q?JvacUtIU8iDcA1YDL3H0lERdyLHU0Z00GxB/mNvUSJ/5dLUcEO+bw49QMFxM?=
 =?us-ascii?Q?Kra3MOCzmFSnHP4MafkkFNRpZPFnh/qkUw7WMdAjWuxA8sGQXAflVZKOqeCE?=
 =?us-ascii?Q?rL34kX9NVriUmDsdAYKuCUW5mwL58f/1OcxzqaEsj3cPkW9mGNO06AeSnLYa?=
 =?us-ascii?Q?pL+bfUaUuk//St2aUxLKtzLKZawS4gKmdWHWdDIEs4z3s/zMIquvdwpxzYHl?=
 =?us-ascii?Q?Z7+kuv8vgY0IjQLZw/Oj0EevbYsvNkhMdTt8osuheBvc6m3YF09HmC3VyV8K?=
 =?us-ascii?Q?UFxDsLfquvD2K/oK545a8CRWE8UDnWEcHdZAGFZAfPnY0/65WLiZe/I03PMb?=
 =?us-ascii?Q?WAMqWDLi1iTGv7lTchss3qciE2salwHp9qQTv/xKSb10EMchL6iEcYNAk3vE?=
 =?us-ascii?Q?5UxI3kmxs2LS1klvVLexJQOYpNrbFqbo4S9Emelsydz3JO4anuF7z++LfHTx?=
 =?us-ascii?Q?/8U48wN1SAAo9bmBsQymeQwNnE9BClrSZPXNoeXOTa5bfJE4rgztRdF5Q6dw?=
 =?us-ascii?Q?CKsS2DkE0l5SUvMX5G9cl6Tio8Qw3V/KI5Rz7amHm32epwSqg/4K6Cs4VPfd?=
 =?us-ascii?Q?svexJKTtiWXoXpWp4YEF7i35LRS+fAQBkpTJJsvCWaweQ6cneVoglci4g8us?=
 =?us-ascii?Q?JIOyPnVKjlZo0DHG/a5VE1Vhw+r2LmkFDPCjPtmdiW82zHGhAQ41/ByA8aMi?=
 =?us-ascii?Q?IG8mg9aHcclJ+L8QQ7KLhxqnJJN2OeCyUkVTvsSR11kjv7lrZVKhXoc7MI4g?=
 =?us-ascii?Q?IAe9d63B5E+TWlbInLhLPqG4GacR+tqcHUZ6EEKRT5+xiE82xUQh4wUhDrLI?=
 =?us-ascii?Q?vbr2unPeEVGfL34ppvaWj9z7U07rxDcUm08tUvPcGWn5pozJUPimHa9klg7v?=
 =?us-ascii?Q?qHQq1bn5Cs0YrCG3t0YVcxRMCx8Pi+MgBnZGaFiEmqjSzNZFU+GJke5OP51B?=
 =?us-ascii?Q?A3DUFJGhWlMEWUuc+1syONVbAD5evgxH2U/ysjkw5LPfZFACRzkvH0lY5nD2?=
 =?us-ascii?Q?u/nohmKU3MTkcW3S8R14V6+eBJS6vcJmDrdgKi8CgqoSc9J6f3v9KuPcwewp?=
 =?us-ascii?Q?T8rbQyKgXQLbAbvNFhaW41I6bD7cTpekUTE2UkSujbHVWI5yPvTj8bZg2feX?=
 =?us-ascii?Q?HY63Zhhm03p5+VafQOJN82+DDY0f/mezN/QlMKbAHGN7KiaWk8V4sw3BPH0U?=
 =?us-ascii?Q?dGNvr4k7ZTmBaMO3AFvh0PQV5+YBWP/g2NJFphtmXGW0TLzcZ3dvDOWE/Hf1?=
 =?us-ascii?Q?O1DI76i/UTqLeTqYKAlk2KDT/WpWKmzlBdbvuDEzAONl5Sa8ke0lLxY/mHHh?=
 =?us-ascii?Q?8cNDQJoXcRREU3x0u7tnOurgBBMpheRn9XCjpXBpFhFwUND29MYHof4tt6lU?=
 =?us-ascii?Q?k+COTqpEE8+Xn03N9Ir7WSryhC816AvzLfcPAeMeOx164RB9oalvE6pE3cHW?=
 =?us-ascii?Q?9iZTJ3193fkVudROu/WLgmiaSP14jght/0EBfIti?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b771e32-24e9-4617-8d0d-08dd634b5689
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 22:55:38.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zC6LF9CPxFQ3mRwlneSA8wwFet8ycbk+H2X5ZAqFlV+LnNENiXXYCFa+5Rq4Y1OW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF864563BFB

On 14 Mar 2025, at 16:50, Johannes Weiner wrote:

> On Fri, Mar 14, 2025 at 02:54:03PM -0400, Zi Yan wrote:
>> On 13 Mar 2025, at 17:05, Johannes Weiner wrote:
>>
>>> The page allocator groups requests by migratetype to stave off
>>> fragmentation. However, in practice this is routinely defeated by the=

>>> fact that it gives up *before* invoking reclaim and compaction - whic=
h
>>> may well produce suitable pages. As a result, fragmentation of
>>> physical memory is a common ongoing process in many load scenarios.
>>>
>>> Fragmentation deteriorates compaction's ability to produce huge
>>> pages. Depending on the lifetime of the fragmenting allocations, thos=
e
>>> effects can be long-lasting or even permanent, requiring drastic
>>> measures like forcible idle states or even reboots as the only
>>> reliable ways to recover the address space for THP production.
>>>
>>> In a kernel build test with supplemental THP pressure, the THP
>>> allocation rate steadily declines over 15 runs:
>>>
>>>     thp_fault_alloc
>>>     61988
>>>     56474
>>>     57258
>>>     50187
>>>     52388
>>>     55409
>>>     52925
>>>     47648
>>>     43669
>>>     40621
>>>     36077
>>>     41721
>>>     36685
>>>     34641
>>>     33215
>>>
>>> This is a hurdle in adopting THP in any environment where hosts are
>>> shared between multiple overlapping workloads (cloud environments),
>>> and rarely experience true idle periods. To make THP a reliable and
>>> predictable optimization, there needs to be a stronger guarantee to
>>> avoid such fragmentation.
>>>
>>> Introduce defrag_mode. When enabled, reclaim/compaction is invoked to=

>>> its full extent *before* falling back. Specifically, ALLOC_NOFRAGMENT=

>>> is enforced on the allocator fastpath and the reclaiming slowpath.
>>>
>>> For now, fallbacks are permitted to avert OOMs. There is a plan to ad=
d
>>> defrag_mode=3D2 to prefer OOMs over fragmentation, but this requires
>>> additional prep work in compaction and the reserve management to make=

>>> it ready for all possible allocation contexts.
>>>
>>> The following test results are from a kernel build with periodic
>>> bursts of THP allocations, over 15 runs:
>>>
>>>                                         vanilla    defrag_mode=3D1
>>> @claimer[unmovable]:                        189              103
>>> @claimer[movable]:                           92              103
>>> @claimer[reclaimable]:                      207               61
>>> @pollute[unmovable from movable]:            25                0
>>> @pollute[unmovable from reclaimable]:        28                0
>>> @pollute[movable from unmovable]:         38835                0
>>> @pollute[movable from reclaimable]:      147136                0
>>> @pollute[reclaimable from unmovable]:       178                0
>>> @pollute[reclaimable from movable]:          33                0
>>> @steal[unmovable from movable]:              11                0
>>> @steal[unmovable from reclaimable]:           5                0
>>> @steal[reclaimable from unmovable]:         107                0
>>> @steal[reclaimable from movable]:            90                0
>>> @steal[movable from reclaimable]:           354                0
>>> @steal[movable from unmovable]:             130                0
>>>
>>> Both types of polluting fallbacks are eliminated in this workload.
>>>
>>> Interestingly, whole block conversions are reduced as well. This is
>>> because once a block is claimed for a type, its empty space remains
>>> available for future allocations, instead of being padded with
>>> fallbacks; this allows the native type to group up instead of
>>> spreading out to new blocks. The assumption in the allocator has been=

>>> that pollution from movable allocations is less harmful than from
>>> other types, since they can be reclaimed or migrated out should the
>>> space be needed. However, since fallbacks occur *before*
>>> reclaim/compaction is invoked, movable pollution will still cause
>>> non-movable allocations to spread out and claim more blocks.
>>>
>>> Without fragmentation, THP rates hold steady with defrag_mode=3D1:
>>>
>>>     thp_fault_alloc
>>>     32478
>>>     20725
>>>     45045
>>>     32130
>>>     14018
>>>     21711
>>>     40791
>>>     29134
>>>     34458
>>>     45381
>>>     28305
>>>     17265
>>>     22584
>>>     28454
>>>     30850
>>>
>>> While the downward trend is eliminated, the keen reader will of cours=
e
>>> notice that the baseline rate is much smaller than the vanilla
>>> kernel's to begin with. This is due to deficiencies in how reclaim an=
d
>>> compaction are currently driven: ALLOC_NOFRAGMENT increases the exten=
t
>>> to which smaller allocations are competing with THPs for pageblocks,
>>> while making no effort themselves to reclaim or compact beyond their
>>> own request size. This effect already exists with the current usage o=
f
>>> ALLOC_NOFRAGMENT, but is amplified by defrag_mode insisting on whole
>>> block stealing much more strongly.
>>>
>>> Subsequent patches will address defrag_mode reclaim strategy to raise=

>>> the THP success baseline above the vanilla kernel.
>>
>> All makes sense to me. But is there a better name than defrag_mode?
>> It sounds very similar to /sys/kernel/mm/transparent_hugepage/defrag.
>> Or it actually means the THP defrag mode?
>
> Thanks for taking a look!
>
> I'm not set on defrag_mode, but I also couldn't think of anything
> better.
>
> The proximity to the THP flag name strikes me as beneficial, since
> it's an established term for "try harder to make huge pages".
>
> Suggestions welcome :)
>
>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>> ---
>>>  Documentation/admin-guide/sysctl/vm.rst |  9 +++++++++
>>>  mm/page_alloc.c                         | 27 +++++++++++++++++++++++=
--
>>>  2 files changed, 34 insertions(+), 2 deletions(-)
>>>
>>
>> When I am checking ALLOC_NOFRAGMENT, I find that in get_page_from_free=
list(),
>> ALLOC_NOFRAGMENT is removed when allocation goes into a remote node. I=
 wonder
>> if this could reduce the anti-fragmentation effort for NUMA systems. B=
asically,
>> falling back to a remote node for allocation would fragment the remote=
 node,
>> even the remote node is trying hard to not fragment itself. Have you t=
ested
>> on a NUMA system?
>
> There is this hunk in the patch:
>
> @@ -3480,7 +3486,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned i=
nt order, int alloc_flags,
>  				continue;
>  		}
>
> -		if (no_fallback && nr_online_nodes > 1 &&
> +		if (no_fallback && !defrag_mode && nr_online_nodes > 1 &&
>  		    zone !=3D zonelist_zone(ac->preferred_zoneref)) {
>  			int local_nid;
>
> So it shouldn't clear the flag when spilling into the next node.
>
> Am I missing something?

Oh, I missed that part. Thank you for pointing it out.

Best Regards,
Yan, Zi


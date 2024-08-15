Return-Path: <linux-kernel+bounces-288271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE5995382F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFFC284EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904A21B3F2C;
	Thu, 15 Aug 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="My0iIbGe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411F37703
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739116; cv=fail; b=LpSwW1B6M1tOnEVKCOfwUz/nNjjB8pswPXr1q/UrSigua1WRcWIjKtDXJTrr4F7daGJcF2p+9PbAiBkhGAqe1IQyZYG4LJd0+Fo2D74y4I9NMJRdMjTeYPqPTuxTB4QfnVia/yIR6p3YbgiDEwX1sgSNLlfx2cJIyPKxxQs+Nm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739116; c=relaxed/simple;
	bh=P/+AnA0xhs8/EXuFPZkMu+IxWNX0AENMK0Espzoh2wE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kj05MFNod48Aq0ZdhwZEI7UCcvV1jrja4OoV7GiWwGJRisRYMyC1tHLvqHPEVgrwNwHducUkR4k+aHArp5MKq+ASQKsg9rfYUTEZRefpG1mkGFV0pEZdmGSfNfQQf4alX2p1A8vYUIDbjcU2qLnktKVm+VLWJXfTaSEQFL56WdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=My0iIbGe; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723739114; x=1755275114;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P/+AnA0xhs8/EXuFPZkMu+IxWNX0AENMK0Espzoh2wE=;
  b=My0iIbGef69/fkSq4kLSOJgWdgzQyAsaKtTo7j5VlcIfTZC9HKU26zgn
   OjPUdWjE/RJg1y+hXjlRNF52xBkH2nW+0r/CT529WROFzcLppeI1lN63Z
   OovhPF/+ftzYC5cQz+MAvRGj8QbytTGLs55ulQsVRdLxR9CZsJ9iIabzB
   F7BX5CZ6ZKFFUrqjTyzflLI7EcarmrOHSi+7iGJ6S5J2LrVopjXsLMEEN
   qz1GAANOMZ4VTfXxVtsqrm9XG386BKPC8JAPwqxFaTx8Pt3pyDLXrnzW2
   BqcZI0gq1rM6QAMJjdwVAiqZcADFQx5DMwWSMNhjouqWNqyGQt5z1O26w
   g==;
X-CSE-ConnectionGUID: tos5Y+L4QvODqCIVbnhIVw==
X-CSE-MsgGUID: 5OabFRzGTqq81wLXxkB6Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="47411888"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="47411888"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 09:25:13 -0700
X-CSE-ConnectionGUID: 7aLdHeF7Tlms2XlXbvIjhg==
X-CSE-MsgGUID: icx0esQlSIStFqKgW3Auvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="59967064"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 09:25:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 09:25:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 09:25:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 09:25:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 09:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg67tGP748CHQEdwPoLq6ZT2EdXlgxXGGB7QarKPRtMCJJGShgY3ddh+SpSLZLT+68PYeDm052pOduESKEbz9dZuUK+Bd/60wW3LlCL7sWv98ttVK/zGVGiD857U9mezoHQy4CeSEJOEGjsua8tOLYb0+shSM7bu+QxY3KtJNydN6lL1SfFS/cMvUnhmmPSotKoIz9a+61FbU45LD+T04jbgxehih6zU7z0b+TobCXdAh9aJ4/m/OLtgPuInyshl8NYm8SH7Um37a9nLV/pj/mvAVxjhe0Evg14icSMBfY9I02+cQHUjAZaNZp12+GA2oEBm+TvhOcBC0MLRIS5AAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl88s6xymxoWjmmFQhYAw6ShH9jb5rHOOh78pnjIjNE=;
 b=YzFpnXyqsN8T/RpYibPfec+ZuKD0aoQC/sVxBbZ56Y3fr4P6GCqTEPHjyyRFgtAaBTYszpSapRe+ssD2ORapzOeQWOStvLgjFWFX72mGXAkfz6Kpkz2l95eYxNHnd6O5hzu2whP5R18myfIHytdpN26T6ZKJT8ivMwqGB6hQAFSydpw0Sz9fmjzSyQQVVuGKPSr/AHOgAYh5A9Tk/u2r+JtKY5NdRX362Y7haZ2TkT/bS3aq19tzx7pvg+C9d+IBai7ozTZUBIMYZ5QQUmk7vQmHj2ij9DydZ+BFci9oG7WdRM4WFw/ekYQiCLlvCu4Bsj3VH3k6Ai/BRg9u5dsDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA1PR11MB6871.namprd11.prod.outlook.com (2603:10b6:806:2b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Thu, 15 Aug
 2024 16:25:08 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%5]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 16:25:08 +0000
Date: Thu, 15 Aug 2024 16:24:02 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
X-ClientProxiedBy: SJ0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::34) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA1PR11MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 3209a013-1b6c-476a-3e49-08dcbd46d3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PoTM2bzLNHgxAASks3wav90FWc8Mh+p2sPYmR4ALKPB7FoEOv5dhfvwnMPzS?=
 =?us-ascii?Q?sPGV3ZxBHyhmjqvIkDcxHNyUj3XVnBP5lz5mZiV3kHxaLcRg/8+dEqmgP9QL?=
 =?us-ascii?Q?2qERHzTSTPqiDpnXEoz3zQ0Tw8TdHdyc3lcoQXREkK/ON+iqa7sIJQsfi07s?=
 =?us-ascii?Q?7YD1Mbm4sBUaVqHXF+DnqgNP6DjuNFgF8wezxGQc9laIrgxUNeqzCW9Wg8Fj?=
 =?us-ascii?Q?Wr/aMrC0eDvA03qWR7p5eJf9BX//ET5boBHCie5AXKB6ZSihXPKDU7l5066r?=
 =?us-ascii?Q?Yt3+9z18h46wk9B1IUFJbcqzO4AjWrxUMQekcwA/rT54xA2R5kHGjW4Yh2La?=
 =?us-ascii?Q?7Mqz9Uj67hyoVe13ZcWFIQlheHRZaqJQUYiCEyvAcuGTBK0fOdmlF3UWf6tX?=
 =?us-ascii?Q?MMS7vt4DHQJDMmY0VpxeodzlhK8Yyz17rWx1xPGZ2O6dE0S/ndtzt6Ij2MnY?=
 =?us-ascii?Q?jBJ+VDH6Trljgg2KcgkbWF4SHeSe7DJMzLUK4/2OXDH0jwBKhaFmU6PDNbj1?=
 =?us-ascii?Q?zp/yP7VXuqlCLVsi/Qejd8/FgLtj/4acTl02Avgg97I1t2WWTnC/QG/xGRK0?=
 =?us-ascii?Q?uXzgyUoHLEoxzrQQAZlu8zjXjtv3YTBbNJ3PusDV1hom83sIvSTrxi/aldfu?=
 =?us-ascii?Q?VqulCi64zJ/vwdpgQpGdTzu3B6KGt7HDKzUCXQ5eU0/9lIQPUcReBHlCxr5P?=
 =?us-ascii?Q?PxvOyrItzsJMruL+qJH1U3O2KFPkOZpfaGGAP/Jg4MSpzqCaTkiSK0hgiuBB?=
 =?us-ascii?Q?KCZaoVx/fRqrVhkOuDjXijpNu4zLmuQf/72zc90tGSqZszayDOCnsDEyPeQt?=
 =?us-ascii?Q?PNfAFtBbqO9EBfFdm47Bm1m5SzpgJBp1L92bO/q2i4rzv8sLGM+EGf0c/ss4?=
 =?us-ascii?Q?qD+12tbK7DmscM8g3DI6dvrQ73RDdwEF+7LiezHcu2tLty4VjomBVrCu8qWX?=
 =?us-ascii?Q?bHBdfu7SiJ1qYhb57WGJ6CTT9x+TJ2ZRGLtwCG1HR65YmDIf/K1CgaDcGBSd?=
 =?us-ascii?Q?1/fqYCifPZSa8E5cJKxQHwoVMhdJVuB4R/5IZEC8bmMQdNSayVgClAjqrXSi?=
 =?us-ascii?Q?g19Egic+c29B8yaCzJ19Zu5IL/HqaLG/EK6x0IwlRtb+/pGEcScwcz8AGCtc?=
 =?us-ascii?Q?VEs/N6JAQuQfLnCfXFFWKwIaaJoTWQLpjWJqUSTh0zMNz8Km3HYfM2+L1vw/?=
 =?us-ascii?Q?pfWiimWxnh7ALqMNTK65qUozsb1qZnFeQAVb1/YRz0mCB+eis/Ij8T5YRmnU?=
 =?us-ascii?Q?QUiVONoD2XdF86FCOBmyUvVN6U+r92fvMT/TLRXMr3WTyWygPQonZbw8/Bl5?=
 =?us-ascii?Q?5p0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UyIxOZ6Z35MF7TVSuXCtZQHGJzH03OpUsKNDhIXd9YmF6X0QVWd2KqUdiGie?=
 =?us-ascii?Q?z17g5SiGDuXoGX6y6EXctaL67I46aNRrsWZSjEx/nEn0GiCNrH4d6An8Beq7?=
 =?us-ascii?Q?ishOZKkkcPHAjHbLLkcyXxM8XmhowfOSiOqEyhM5BlZmxaC6rC5zENWyOcbM?=
 =?us-ascii?Q?u4A+VPDOHj5pFQle8IGsxpYbVIwiTzKtwMVAdfklYBePsO/IiXxJEEmqeKZq?=
 =?us-ascii?Q?Pze0FS2AHqs2mcMRyu2d1gzZemB23Z+EVJtzgNPRxpmAQ/569tgXNoT9GMAs?=
 =?us-ascii?Q?PjqYkRJXn88mbPBswackplPZpSjTM9Xm7ZRpWf5BK5QPtYXzCWP4qyYxLlOe?=
 =?us-ascii?Q?O8SlzDz0Xf51S6StV5snHT6TU5pXln8SCHJuaIWpjriTOQIKEyEuScyKUdIh?=
 =?us-ascii?Q?U7XmTLzL+egSqQgMs65+dWOz0jrHowRcxunNji/CfzX3yt6Ny0unLOHlN9Dl?=
 =?us-ascii?Q?vA1aLvZPj+uHLmuvGkUupvAAlDN6h3rKK8+48hUq5Wt1Mvwxg99+vIDfvZJ1?=
 =?us-ascii?Q?NhisV0fnl0JGuF8ERmxsafNV4mpTdWpfWIPUOKRhsaMpYdNl/KfxVh0MRNrc?=
 =?us-ascii?Q?yahpKe0NtUjAMiG/cccEXEKeawF21un+NC5x+4w9SkRSH7c3VZVg4Wl4Ctr1?=
 =?us-ascii?Q?3ox7eCRCebEdc+kwaKj9VM0Mx8lHK8wT7QcHnB7EwCCIvi5yIQuPqXeT2vBp?=
 =?us-ascii?Q?8qGV9bkvGoaFUizqySgZRqVJoBKi1ukJnrpyRPgWrvZ6fqSoFUkJIPXBZNDk?=
 =?us-ascii?Q?vBcsu8WWahuXi0gR0RRLR+bQN84lmW6WNj4dZRxk68+n5TLu6hqmNLvEwygr?=
 =?us-ascii?Q?K5u6w9ZhL+cJSWJUzUjJF5AbLlRSjVNrdOzs9DGoJFlnq2lpnLue/ekFIN/J?=
 =?us-ascii?Q?5hch59RW1/L2betrRycyz00ysAivJvxvD3jeZLq3FEki7ktpz+72quIy6ujq?=
 =?us-ascii?Q?1FbWNyTb3GiFZFq+sLx5Mqfi8LMk0s8EA7hsaQBW8GfeBE4LgU6dX0uROgln?=
 =?us-ascii?Q?NOtjDtTjE7RMwQJMQ6EFUHJPx8AVhxvySM4x3zBm2ld7jgcOBIDD8yB8Wejc?=
 =?us-ascii?Q?EbWxxUMGcpMTozI8wlPoB+i9P+Fbs0W3bZZvOCr3QxvLORwf4kAL3bjjg0d4?=
 =?us-ascii?Q?E4au0gGfi5SigaeoMrb736b5faQpJuYyDNGV3LzilEWlQuqvP+Vzbpjrq9dh?=
 =?us-ascii?Q?LAm+zRkF8OV7GREP0TDxOx0aTQhlv2/gxyq3xW6tXpZwAH3WTLHXAKKTTexC?=
 =?us-ascii?Q?jGhOubsY75rhptQcLviqjzH0c+goyKPpRNwSjOgYmHnsCYWmOy9j6Jbig3Wr?=
 =?us-ascii?Q?g0pSBLsSfeLBrIBJblQNJr6M9ScM2mct+k3G6iYl1fKbcDNvEj8y9Gi+ztkO?=
 =?us-ascii?Q?EcG8rD4tj9x+K7tpXypFcdVnfG2hXNZjuFHGCWkIiyXCBgHSXrrwheVy6lxC?=
 =?us-ascii?Q?jP5DV4R9qW/FrKMUqvvKzDyHEI+R4V3ldcjYJSESRsT0hFpB3HLZIjzzD1/n?=
 =?us-ascii?Q?pQ4cAcM0+TlA8W8Bal7+Crws7IRSnqsZgM3n//dwHAJdn/uUiMhV8lqNEZxB?=
 =?us-ascii?Q?9qLxVVGryn3EtfJg/iLlG1zlzAfg27/vN5fyJq5Ra8/xHyDDiFcH27rxv+ey?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3209a013-1b6c-476a-3e49-08dcbd46d3fe
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 16:25:08.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXLii7z1iCBty9fdexiRGMnGb6XA6FkIKeEBC79tx0IjUicuBwmOrj3RiXmuMk5SFqsnEbFThr0U3rvGgcMSJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6871
X-OriginatorOrg: intel.com

On Thu, Aug 15, 2024 at 03:56:39PM +0000, Matthew Brost wrote:
> On Thu, Aug 15, 2024 at 04:24:27PM +0900, Sergey Senozhatsky wrote:
> > On (24/08/15 16:09), Sergey Senozhatsky wrote:
> > > On (24/08/15 16:02), Sergey Senozhatsky wrote:
> > > Oh, okay, so this is related to [1]
> > > 
> > > 	workqueue: Split alloc_workqueue into internal function and lockdep init
> > > 
> > > Cc-ing Matthew on this.
> > > 
> > > [1] https://lore.kernel.org/all/20240809222827.3211998-2-matthew.brost@intel.com/
> > 
> > Matthew, did you mean to do something like below instead?
> > Otherwise it breaks boot for me.
> > 
> 
> Yikes, my bad. My change worked locally and in Intel's CI for Xe [2]. So
> I did not realize this was an issue the way I had it coded. 
> 
> I believe you when you say this is an issue.
> 
> With that, the way I coded alloc_ordered_workqueue_lockdep_map could
> also be dangerous. Thinking that also should also be changed back to a
> macro too.
> 

Sergey,

Sorry double reply. Looked into this and va_start / va_end should only
be called once, so I think the change you have is correct.

The change wrt to alloc_ordered_workqueue_lockdep_map should look like
this I think:

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 8ccbf510880b..5e818eae092d 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -534,7 +534,7 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)
  * @lockdep_map: user-defined lockdep_map
- * @args: args for @fmt
+ * @...: args for @fmt
  *
  * Same as alloc_ordered_workqueue but with the a user-define lockdep_map.
  * Useful for workqueues created with the same purpose and to avoid leaking a
@@ -543,20 +543,9 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
  * RETURNS:
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
-__printf(1, 4) static inline struct workqueue_struct *
-alloc_ordered_workqueue_lockdep_map(const char *fmt, unsigned int flags,
-                                   struct lockdep_map *lockdep_map, ...)
-{
-       struct workqueue_struct *wq;
-       va_list args;
-
-       va_start(args, lockdep_map);
-       wq = alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | flags,
-                                        1, lockdep_map, args);
-       va_end(args);
+#define alloc_ordered_workqueue_lockdep_map(fmt, flags, lockdep_map, args...)  \
+       alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, lockdep_map, ##args)

-       return wq;
-}
 #endif

Matt

> Let's see what Tejon thinks?
> 
> Matt
> 
> [2] https://patchwork.freedesktop.org/series/136701/ 
> 
> > ---
> > 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 7a2f4cbbe8b2..55e0e69ee604 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -5615,12 +5615,11 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
> >  	} while (activated);
> >  }
> >  
> > -__printf(1, 4)
> >  static struct workqueue_struct *__alloc_workqueue(const char *fmt,
> >  						  unsigned int flags,
> > -						  int max_active, ...)
> > +						  int max_active,
> > +						  va_list args)
> >  {
> > -	va_list args;
> >  	struct workqueue_struct *wq;
> >  	size_t wq_size;
> >  	int name_len;
> > @@ -5652,9 +5651,7 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
> >  			goto err_free_wq;
> >  	}
> >  
> > -	va_start(args, max_active);
> >  	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> > -	va_end(args);
> >  
> >  	if (name_len >= WQ_NAME_LEN)
> >  		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",


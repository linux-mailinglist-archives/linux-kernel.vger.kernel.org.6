Return-Path: <linux-kernel+bounces-196304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4128D5A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0B3B22BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EA7C6DF;
	Fri, 31 May 2024 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwYrZ1K6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05B1CD3C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717134778; cv=fail; b=hZJ2J7AWI0qobdFvXlkGk3sEMm7PM2ixbdhq+Z0F6Ei43CO/JCngpuO0yBFCa43vSDsqmEuOYKtYsBk9M1aHS0NBwuBtyE33NvJ2TZOgZpQ7AuqYQbeEW7ie6icwjl73WZrEpK7zhum/iKNCD05RaUyTy2FUGIzZhCWcKLqVm34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717134778; c=relaxed/simple;
	bh=cX25Q1fu8tj3a16PBKfV35h97KmoWpVCKR6K6WnsM6E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=XITT0/tPE53T6foOLSWatXuKJMUaVne4qMNONiNYnmfQzpUnELp5KpsH6br9Isxd3kb+zWOpn6rznKi/7z2fOKFwfX62a3IkPhYNO/XsONqG2jvz/qzKNhk8QtGsE7904go31/IW9HcFHcRh86K7DlehxS+im09Qt9TqE2++vyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwYrZ1K6; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717134776; x=1748670776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cX25Q1fu8tj3a16PBKfV35h97KmoWpVCKR6K6WnsM6E=;
  b=VwYrZ1K6B7bInZ+rSQN5235qfaZvg0eIZzN3j2l1GryY7Op0V2k5WQcA
   wFXQ6vYNmdt0fNk4xW9eMgEBGHZci8C6HY6AEAvxjh9CyOBkZ06F1RHvQ
   XAnhDEvOfsoY2K+WsEFwVkmnP1hRoCuZhW/XogUw8+whUzxbXCejWzTsm
   RnXeg3+expbj6/X0jgeZnstRO1W/TgmzeL8mOUxHF0ADgqVv6lnhD6cu3
   LonYIQ6jmzYxIk7kB8XvN2Gz66shMum/4uv4zSXnyu2HOnPEkT19hh/wl
   n0mzDQdvBUE43ojA8CQO02BatfBA3CHa+JfRKOQs32F+rQMVPdqKTgBnE
   w==;
X-CSE-ConnectionGUID: nFdoH0pbRluObJbIH5yX3A==
X-CSE-MsgGUID: H/2P+5k3QB+GfmNomONPJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="16611345"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="16611345"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:52:55 -0700
X-CSE-ConnectionGUID: 8ESkwaTRR/idonpFe+Jh2g==
X-CSE-MsgGUID: jgnxFy7dTxysroATE8ikiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36092997"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 22:52:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 22:52:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 22:52:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 22:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZGU/ZGlfr1hTTA5Z3ZA6M6kgHuaw86H0ppb7z5OjC1H+BPUeNYDzejYJOIP2iHr6Zc1guGwM5hod+OWfh/8ixxZSIMS7qw702nxaxLkt5ko5VEgOMdbqkbpmJavBKDWvBCQpCdMa6x3CVvlThImYWYCGjON8nS3hwYj8VB/jBS7myuucZMa24y1ZcJiMUxrVxujFUIZTJw1TTCrytAtYr4Nj5f9qTx3B6tDXBuPKmXwqsCQmxVyirALl4ZGo/322inZFOs7oEmrLgVSRHO79vsQRc3jCwmEaAeDnemVxloiDsl3DREJ17WxXYeZtO9gT8t72aep29veyO30/J4g9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ttAIU1RHvtxmeHyiYnjc+3YVOI5XMarf9u7hhg69uY=;
 b=Qi+i7TGajFDPiMAL3DaRO/9djaBAhl+ohC9d8eP3ylokkUbLHd1lK1MFvMiiY2lFTAkmBqeZNlCSopAMjHAeupNGCoeHSk4NpatwId/XklW6DEuOA9L7EBvUpx0SpLRb6cBhZBYfL/h8OKAOppE1LiMV1ZNsWOtJusZcmSMiQJfoNjmHbhRAQO/ZJx0lrgJGh2gmQdQO+vYkYkOsFsLbhc0xW0vOH3ZD7pNWUfI5sNrsmeaZZ7ZpxmwM0AtQSy4vklMHWDDsh9y5revztW0zK8tj99+lwsLncohHiMEb3UMR9px+yAb3MnYKRJzQ/P7tjQiw+x252NFqUTIXwOOMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL3PR11MB6338.namprd11.prod.outlook.com (2603:10b6:208:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 05:52:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 05:52:52 +0000
Date: Fri, 31 May 2024 13:52:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Hugh Dickins <hughd@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Tim Chen
	<tim.c.chen@intel.com>, Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong"
	<djwong@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, "Carlos
 Maiolino" <cem@kernel.org>, Christian Brauner <brauner@kernel.org>, "Chuck
 Lever" <chuck.lever@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>,
	"Matthew Wilcox" <willy@infradead.org>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [shmem,percpu_counter]  beb9868628:
 BUG:KCSAN:data-race_in__percpu_counter_limited_add/__percpu_counter_limited_add
Message-ID: <202405311100.d46f2cc1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL3PR11MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9c5122-ad04-46a8-73bb-08dc8135e8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ByaWmGxY0t6JvG0KIpDLoIjn1pS5YLs2YIv5MzlmGuk0sOrM5ncgqc+MVE1v?=
 =?us-ascii?Q?CWlXbgxqX+oA8oz7k6PEjJ4NHulHd5AXEK9TJYYwCNzVwVyTQno08jwXXCBt?=
 =?us-ascii?Q?LrUD00VinHlt+6/f+CCa03Q17FgGMrQ4O86PBcGoNenX5lbb3pI7D7syXKRu?=
 =?us-ascii?Q?d7FG4ebcOHAq7LPp+6B/+Vo3pdkqkaxBOvvpchBu+nccK4en2sK6up17VHPW?=
 =?us-ascii?Q?iu9SrhAZPjiq7Oes6Uo4B0rRsqYVtQjwi2nI4LQjcOtZKo2lbZX4prwQKTJv?=
 =?us-ascii?Q?T7KefBGMqk6UctOOH7HsFg9yY+jOmKEII+HTTcaXhx0YnkGCTBqlHAk595Sp?=
 =?us-ascii?Q?P/vXxXMGi0J7DS5j9jsMLDblxCXuShQZJmqvcqEYb8fy9ttGVDc1AA0/vm46?=
 =?us-ascii?Q?Hrx64ZGUBLkLkn3ZWuHrlq/L7wdB/MOZJYJyGyKdiJKtw50C6+dIpZ6BBEqx?=
 =?us-ascii?Q?op58bxw1F1qmostNaifuxgvmJJ55ohUtO9OuS1hgqGi6767SRx6TZ4kvnjfn?=
 =?us-ascii?Q?plQHfIT9JqepY3Y+xsveByviuzKNETP5MbBTPs1K60o/boAqaHNBsBhgwNMt?=
 =?us-ascii?Q?UaZl6UrvLxJOc4Wz6W1BUws/1MdTFgb2907MpcOHL50PNtnkWo7PSHH3EZCA?=
 =?us-ascii?Q?AhOgeOegTcj7BA388FjT6QVkkgVVmmCR9IAIuFgyj38xVhytk7AlOSly9Oxp?=
 =?us-ascii?Q?nCYnvOtjx70fw7XXIdaD5fRzhMjPL4PJXevyWm6i9sTLxMASc7qmVU9suX4W?=
 =?us-ascii?Q?x1oOXKJZiiKcIycPP60/nPaWrpo2JmG/QVxSguMCA48Xbb3U4x7+3WGGppn5?=
 =?us-ascii?Q?dF0PCmLL7ZDtslTa3cb1WH3PiqVp6SGTtg1XMdRYqBmxTsKaHb8ET9o6GDsn?=
 =?us-ascii?Q?vNG4sr2WbMOsp+4y6CoMGGf1ISqJJIFDmQOJTM/HChAYOquqroICVZGdxi+s?=
 =?us-ascii?Q?U7JhZoCAbDbPO3E8P5J96IEAUdq+Q0GiWOQTXiRA45pA6liDtoI+3tzqZn9/?=
 =?us-ascii?Q?oT2tFjNMtrslVpSOrXOkHM7jswvWslbwTGwGHvifTvT0XMYEMvJM39CnCPhK?=
 =?us-ascii?Q?0+kQwgo29QmqyKBtQqb1rahQba7GT0wP1jBZVcLqzjJwrZDYcunhFS9tbqbG?=
 =?us-ascii?Q?sYG59nGtR5o9JI6chIOV+ijIZ2JBegUtRljBR0GGZ56jjEA9qbwp2RP91kMu?=
 =?us-ascii?Q?b6J0hrL/ghd/sxHmNyxEFDs/MpQ8Oqw4HKS3cLsE2+kRqRDQyEa9aXkEheo?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U5P9lv1mSaqZzvDKEF69D3j+/Lp1C/H8fw+AmJHg7HF9PqoJ/s44i3Zt+OU0?=
 =?us-ascii?Q?e2AmTEL0IvE4JLNNlsSbACvOPxCFiMJ8qxqp7Sr5h/8zOukCeRHjjvkqbJ4m?=
 =?us-ascii?Q?60e5ZH/mGAvHSuf09qwS/cB8sx8LKMnBS/+NWlzDuJAJckSVjxqINablvbfL?=
 =?us-ascii?Q?7ciq38eh1GTRwJU+QM8SDU69QBrOyyHVQaad1RuMHvGqCszoOdW7usdC/zgw?=
 =?us-ascii?Q?kguxsDBkCR/x3isLG2KIahruNf9fPMRWH2XFmlS49+V5Zrxis/7H4HH2Aai1?=
 =?us-ascii?Q?ga0Dgxj9x00KrNyvFFp1N6f5xWqDzztCwizSio5kOhWpQNElQ87yry1Uau9L?=
 =?us-ascii?Q?C0QsCTBK8zneLbHwfG1AfB9z8swVjYJrUEf+AqSO6L4KXeGMzN0GoFQB/qcX?=
 =?us-ascii?Q?DP0WNzEdp++6mBvXIJnr4Jx1xOpxTxQ8lrpADaabCpJN1s60EgK0sU/9WPHw?=
 =?us-ascii?Q?gQA/SIbW6ED03RvKw1VZz//+WrVTr1Gj/uuPNTcseq0U08Ld3PXp70O8bAL3?=
 =?us-ascii?Q?warkSAaCqwFmC/wMv9sMUS/mbfT+cJu4q82tnuuSTFg5s2hbxVLZLGNKDzMD?=
 =?us-ascii?Q?Ue36CWhD+W0JWb4VG6VBRer93knRgHqtEjxfykOrye8PtWC1V+F9GPswrd3m?=
 =?us-ascii?Q?uDhuiQeuPQBqQ31scwEc771+ln39KA8vlAdj8irVb1Vw+z/DWWmPgnB2hFaF?=
 =?us-ascii?Q?JGDjKI6YxOpLmpT0/p1mnaIaySZSDQCiRl60tDC0PQO3a2wcW5veSR6FTtUP?=
 =?us-ascii?Q?PsWreeGWkq1QcuRUerKcRXkTyyNmEUkmPLUf1hkFGZfQZfd89ttWH2sQB+QG?=
 =?us-ascii?Q?bUgK6gY3WYoz4sGT6yAZrJIr1eHv8d9yjsln6TY1mIVsNUcwZ7YpRdyZYvIC?=
 =?us-ascii?Q?XBnPLVqQyaHg59ny5vJD4f6O3EzlhC8heDpCiMjezCO1Cd7ZSkE6LtdlXuD5?=
 =?us-ascii?Q?GQIdHQkEJ14H+xsoMMkd64bf+EAWAkLG+P2fI+2HJbhK/Hr+SJ8EDhH2Ayy9?=
 =?us-ascii?Q?YbnLwi9HQ4sK3jNiq/LlhlrD9Ecn86Ct4AkQ0635oXGaU4/B3HN6ERS+OF+Z?=
 =?us-ascii?Q?SQ7JrLIkANtygKvHtr7dOBkta1y4rZJ6SB7ltNoGyoHkLNw/zdbEkrXFs0R7?=
 =?us-ascii?Q?eb7tvLAf0vmm5SfoPUomoCVpK4k2p/9p34o7i+9TY3LPeO/HRRxRtnDnTYfJ?=
 =?us-ascii?Q?Sv+408hVEeVoyo6QY5v0icPHKMWOeONDsnojE9Bwi7V6DFvIrwNKZ9QNXHrj?=
 =?us-ascii?Q?Mhz16zFv5p+HPKsoulKzEf6XuzcjJjHtCVulNg5JaL+iYiQYP/NC2wQXmpvt?=
 =?us-ascii?Q?81VSNhohkVH7IsRrvIw0U6KnR79l5XZcH80eUJDB954yKwDWtZKjI0NOUvHw?=
 =?us-ascii?Q?ufqzwnE03KNu3QMKSdxK2Rfq/T3dXPvRkCGZaRh2fBzrmxMsCn/kNiogH6zS?=
 =?us-ascii?Q?olBOV3tbiMcFOOmKOksbN/bcP6vjae15DBcY+8/kiVw9l+DMpCNWXiMbtexx?=
 =?us-ascii?Q?u73JCWTb0bX3fJcAUYY9x5jXv54a366O2ee2nj1MEF6WN02Lk8o5NPbVYvWG?=
 =?us-ascii?Q?rpQk5Ke3UuYCBf8SEjxzLXjaHAU1RFtnA6aNOkbCOB36DYvzPnRCm6GJv7Je?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9c5122-ad04-46a8-73bb-08dc8135e8d2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 05:52:52.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKe84iUhqsmoUXMDFJwqPv6LTWtlN1Y6a5moSY4HsJ+UVpTSxKQx+SlUQA8RIPCZi8CEQbihaxpz7Uy91N2Nnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6338
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KCSAN:data-race_in__percpu_counter_limited_add/__percpu_counter_limited_add" on:

commit: beb9868628445306958fd7b2da1cd369a4a381cc ("shmem,percpu_counter: add _limited_add(fbc, limit, amount)")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      2bfcfd584ff5ccc8bb7acde19b42570414bf880b]
[test failed on linux-next/master 6dc544b66971c7f9909ff038b62149105272d26a]

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


in our tests,
  dmesg.BUG:KCSAN:data-race_in__percpu_counter_limited_add/__percpu_counter_limited_add
does not always happen, 88 times out of 150 runs as below.


3022fd7af9604d44 beb9868628445306958fd7b2da1
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :60         147%          88:150   dmesg.BUG:KCSAN:data-race_in__percpu_counter_limited_add/__percpu_counter_limited_add



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405311100.d46f2cc1-lkp@intel.com



[  301.127451][ T4651] ==================================================================
[  301.128485][ T4651] BUG: KCSAN: data-race in __percpu_counter_limited_add / __percpu_counter_limited_add
[  301.129715][ T4651]
[  301.130014][ T4651] write to 0xffff88810ffc3450 of 8 bytes by task 4674 on cpu 0:
[ 301.130981][ T4651] __percpu_counter_limited_add (lib/percpu_counter.c:325) 
[ 301.131692][ T4651] shmem_inode_acct_blocks (mm/shmem.c:220) 
[ 301.132319][ T4651] shmem_get_folio_gfp+0x3a9/0x750 
[ 301.133054][ T4651] shmem_write_begin (mm/shmem.c:2135 mm/shmem.c:2692) 
[ 301.133690][ T4651] generic_perform_write (mm/filemap.c:3962) 
[ 301.134347][ T4651] shmem_file_write_iter (mm/shmem.c:2868) 
[ 301.134956][ T4651] do_iter_readv_writev (include/linux/fs.h:1956 fs/read_write.c:735) 
[ 301.135628][ T4651] do_iter_write (fs/read_write.c:860) 
[ 301.136178][ T4651] vfs_writev (fs/read_write.c:933) 
[ 301.136716][ T4651] __x64_sys_pwritev2 (fs/read_write.c:1030 fs/read_write.c:1089 fs/read_write.c:1080 fs/read_write.c:1080) 
[ 301.139719][ T4651] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 301.140316][ T4651] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  301.141129][ T4651]
[  301.141465][ T4651] read to 0xffff88810ffc3450 of 8 bytes by task 4651 on cpu 1:
[ 301.142436][ T4651] __percpu_counter_limited_add (lib/percpu_counter.c:302 (discriminator 1)) 
[ 301.143222][ T4651] shmem_inode_acct_blocks (mm/shmem.c:220) 
[ 301.143931][ T4651] shmem_get_folio_gfp+0x3a9/0x750 
[ 301.144696][ T4651] shmem_write_begin (mm/shmem.c:2135 mm/shmem.c:2692) 
[ 301.145370][ T4651] generic_perform_write (mm/filemap.c:3962) 
[ 301.146112][ T4651] shmem_file_write_iter (mm/shmem.c:2868) 
[ 301.146697][ T4651] do_iter_readv_writev (include/linux/fs.h:1956 fs/read_write.c:735) 
[ 301.147330][ T4651] do_iter_write (fs/read_write.c:860) 
[ 301.147918][ T4651] vfs_writev (fs/read_write.c:933) 
[ 301.148480][ T4651] __x64_sys_pwritev2 (fs/read_write.c:1030 fs/read_write.c:1089 fs/read_write.c:1080 fs/read_write.c:1080) 
[ 301.149047][ T4651] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 301.149629][ T4651] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  301.150358][ T4651]
[  301.150643][ T4651] value changed: 0x0000000000059e35 -> 0x0000000000059e56
[  301.151483][ T4651]
[  301.151778][ T4651] Reported by Kernel Concurrency Sanitizer on:
[  301.152559][ T4651] CPU: 1 PID: 4651 Comm: trinity-c7 Not tainted 6.6.0-rc4-00235-gbeb986862844 #1
[  301.153676][ T4651] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  301.154962][ T4651] ==================================================================

..

[  341.345671][ T4958] ==================================================================
[  341.346844][ T4958] BUG: KCSAN: data-race in __percpu_counter_limited_add / __percpu_counter_limited_add
[  341.348131][ T4958]
[  341.348468][ T4958] write to 0xffff88810ffc3450 of 8 bytes by task 4967 on cpu 0:
[ 341.349472][ T4958] __percpu_counter_limited_add (lib/percpu_counter.c:325) 
[ 341.350219][ T4958] shmem_inode_acct_blocks (mm/shmem.c:220) 
[ 341.350902][ T4958] shmem_get_folio_gfp+0x3a9/0x750 
[ 341.351630][ T4958] shmem_write_begin (mm/shmem.c:2135 mm/shmem.c:2692) 
[ 341.352270][ T4958] generic_perform_write (mm/filemap.c:3962) 
[ 341.352893][ T4958] shmem_file_write_iter (mm/shmem.c:2868) 
[ 341.353521][ T4958] do_iter_readv_writev (include/linux/fs.h:1956 fs/read_write.c:735) 
[ 341.354170][ T4958] do_iter_write (fs/read_write.c:860) 
[ 341.354738][ T4958] vfs_writev (fs/read_write.c:933) 
[ 341.355289][ T4958] __x64_sys_pwritev2 (fs/read_write.c:1030 fs/read_write.c:1089 fs/read_write.c:1080 fs/read_write.c:1080) 
[ 341.355926][ T4958] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 341.356511][ T4958] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  341.357277][ T4958]
[  341.357592][ T4958] read to 0xffff88810ffc3450 of 8 bytes by task 4958 on cpu 1:
[ 341.358556][ T4958] __percpu_counter_limited_add (lib/percpu_counter.c:302 (discriminator 1)) 
[ 341.359312][ T4958] shmem_inode_acct_blocks (mm/shmem.c:220) 
[ 341.360021][ T4958] shmem_get_folio_gfp+0x3a9/0x750 
[ 341.360772][ T4958] shmem_write_begin (mm/shmem.c:2135 mm/shmem.c:2692) 
[ 341.361417][ T4958] generic_perform_write (mm/filemap.c:3962) 
[ 341.362106][ T4958] shmem_file_write_iter (mm/shmem.c:2868) 
[ 341.362751][ T4958] do_iter_readv_writev (include/linux/fs.h:1956 fs/read_write.c:735) 
[ 341.363443][ T4958] do_iter_write (fs/read_write.c:860) 
[ 341.364025][ T4958] vfs_writev (fs/read_write.c:933) 
[ 341.364585][ T4958] __x64_sys_pwritev2 (fs/read_write.c:1030 fs/read_write.c:1089 fs/read_write.c:1080 fs/read_write.c:1080) 
[ 341.365226][ T4958] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 341.365824][ T4958] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  341.366587][ T4958]
[  341.366921][ T4958] value changed: 0x000000000008c0e8 -> 0x000000000008c109
[  341.367883][ T4958]
[  341.368191][ T4958] Reported by Kernel Concurrency Sanitizer on:
[  341.369014][ T4958] CPU: 1 PID: 4958 Comm: trinity-c5 Not tainted 6.6.0-rc4-00235-gbeb986862844 #1
[  341.370255][ T4958] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  341.371512][ T4958] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240531/202405311100.d46f2cc1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



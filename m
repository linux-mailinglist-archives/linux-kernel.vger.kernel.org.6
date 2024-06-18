Return-Path: <linux-kernel+bounces-218568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38AA90C205
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80444284867
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820D19B3C8;
	Tue, 18 Jun 2024 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hM1iJa3k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8AC19ADAD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679464; cv=fail; b=eVjv4iTqqaWeWkMir2L5JiSszFQsUQ7Exqd8jQNs7L9cTKalcxblgWQC65zcKF2gAaqVE3+oOsASPz7R3RhDQQVcKIcm1ZGe+JMVjqpePo9usGoptoh7q9z1RO9pA/kMhBuu2L3kaWM3SK/FNIuxDjDxunC9aGP2cEwjU7oB3lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679464; c=relaxed/simple;
	bh=tDsd0p1WVCjsrcq/BxsDzpYVm8TODRXcniT8221QsoQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ImQbuJNGL+ssuh4o/aHz7mWz5IZIk2k3KYfn+ZjcTcxHY3JGg/xrcD1H1h9O0FD9HtX71EzdBMnLSdghEo75aoa8PwtD7wPyzv6+6Lc7Emq7VFYXg3UR1n3p6cVxCjkuUPCDVzqlcS9i+A3ZaWaWX4kNlqRbVxTQeh/2ll/jHIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hM1iJa3k; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718679462; x=1750215462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tDsd0p1WVCjsrcq/BxsDzpYVm8TODRXcniT8221QsoQ=;
  b=hM1iJa3kLbafqTshPOxEY2wjLSwne06kmKTKsAyV1t4D07oprk9RfHJf
   1SPfiJchoe/WPwPSlnQOsH/NoeA8JmtVG0oHLPqxcuag4qF2HVYI+ENfi
   myrfCazn79f1cDQIrh7fSMEFr0SGirm4XGZZyXeKXqgCoirMXqRPyWwme
   nK+3j7QweXqPXDCyrbZEUlNZk9e+4Fy/5oIpuuWs9Xq17kfxAavrG8ik8
   4pMAPti5pdriW9NEPHqiAFajDevMJ6m8aNyVTeKMXP+jz7G/sgs5x4pCv
   vgqOwDPKpTF9oFd+pkXE//3GKM4Bm0FVMr5C8QOwztlG/gxs8pCTf6R9y
   Q==;
X-CSE-ConnectionGUID: j0CLHMmGTMyPP64ZNsXLDA==
X-CSE-MsgGUID: 3DxJobWPSluBRlhDmxZ5cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="33004745"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="33004745"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 19:57:42 -0700
X-CSE-ConnectionGUID: iRpEthcGSUmIKgM+4X4EFg==
X-CSE-MsgGUID: LED7xd4ORquYo5XhX9qliQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41870711"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 19:57:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 19:57:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 19:57:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 19:57:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 19:57:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/y5zTsmQ17OUjovAsCMZ/VxvSlfSsHCSIzHuorgIqunmHIe0Ksm72nH9Fc0XxHwcxidqmtPUEt6RdEUwjtfbSbad6aRcSOiH0tfuAHNKm4IsjcYXJF9pEEyv/5/0yFaI8HHQQqofboaUE7QrIe0R1hek5sri7cX0J9fR+YRL0+lbzGMwLYBS/+NMjfM3qld9DZT73VJU5NZypWBWndDGZAwcqE5Kc34puohARRiqr/WCxJA6PLUMA0S7QGJr7ombvfKlFMjUX8LRgOdRNXnFXylFgkCnuIjkl7ZcViu/JTyftXMxVrf+7/+wze7L3UwLw07OozmTrQpGCBHQ0zthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7jiPscOthRYvvghqxW3wU3ibyEY6O3PZ65oRFIctrs=;
 b=ggeLa+Ok03Gn6uxqt9FcBTrSuQ5Lc1YFN/eE8ErTEwl8zheVWdXS/z1AFHIsu5U9/wit8tUu+ZkvSwd0r336lIfeRPw1essfT6o/ErJUGjY5DZuFKRBFcun0SLnxYk2ynH6mDlrVOwsCEJMLY/j1R+9urNoOoU3eQZAAJtyi0iQeqL5PBLKoSWHvG3iP2EVMZoJpEJKwOpZwTPRNcDKyeIQ9m6qNZMFsFrFFrWe3NzLYwo+vJBWGmSs70PfxF0/1FplPnUscp5dd6TmpyABbkvdFL/3cJ6RBcscqOJnHZfVphAa+JnIrnk0mTvzF5yRXDaKASsDgQrw3aRDaeTbUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 02:57:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:57:39 +0000
Date: Tue, 18 Jun 2024 10:57:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [vbabka:b4/fault-injection-statickeys] [fault] 1ab5c34bcc:
 BUG:KASAN:stack-out-of-bounds_in_debugfs_prob_set
Message-ID: <202406181001.86c775d7-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: a223047a-a4f6-4b6a-9cf9-08dc8f426a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kz4DMQ8XYrtBlkgcOKNUJPUs9CTdEFlu2ijUO90ppT2gR/dTSBnfSbqMLcfp?=
 =?us-ascii?Q?B3OJjxVYQtjlf5eEWjVRuQWz6up14XicRZeSSBwhhNsY+jwx4CaaFGfYf3MF?=
 =?us-ascii?Q?U1lNbVDdTuuVP4VU6/jTcpfgETJTKQWavcWRItGBNyHO7qziS8vq47xDVg4i?=
 =?us-ascii?Q?L9rU8LNAgaIBpDu8Xc/EedqZraJvaP0O/3kBGUQ9RZp860vUD5na20qMXdh/?=
 =?us-ascii?Q?05ZFWZE4/6mRzuB0YzIqXhMTDYJoHWpreiQyr8GGqzIHh2RbFOBESWpDvWE/?=
 =?us-ascii?Q?ZdDQvrm7sYkiBa7Cyt4F0mHlW6Kfyuf8fo6oK+dpSeBkW0mSXJAYxV08xPFm?=
 =?us-ascii?Q?Q27HVeST/24T0a/dWsp+i1SG3VrzbSO5z0JQdi9Y6iCY1u4maYSvp46Lv/49?=
 =?us-ascii?Q?cpZLO1rH+YDPzbvhn/WHt6/DhLiaeXte/nB4B0LB9Ns9Nl/K2P4DguGYAHD9?=
 =?us-ascii?Q?AD5EAVlTFnLFuw/Iff2pSX2AIIjc0D+7Il7W8cFvXNo0a2aGbNWYBphJiBwe?=
 =?us-ascii?Q?eEVWML1Hjz2F3Byg1n183cGThxNaxVfsSmMEa6Tv+O9/iyDutIKI/IHVi98j?=
 =?us-ascii?Q?EQ97lBobGN+/nne8NaU2qkn51cZddXPe4fNg+zU+TYCC0aAjJgu8goZ/Ip8s?=
 =?us-ascii?Q?ke+rJmzqMPcjtTPRjCQ+Cnyh4kogcSvV3yi1tWwhB8fItE8pagZO4gU5SFe6?=
 =?us-ascii?Q?p41/cFUth2PjZD3cppWoeAnystP/avTL+ExACowC+YIQ8qxIFkKIBCSLuBGp?=
 =?us-ascii?Q?qZdZzZjTXhzkFEJh/pkSFgC2N38rWggBKJwEmzl2drJjUppICLNJL6L/vBI3?=
 =?us-ascii?Q?CALYQ0mZe/BIiHO/pywgPustF8pYlcH8XDp0GxmF7VHTmZ9MLQEWGAbgnGt2?=
 =?us-ascii?Q?tDAluiFep0H/zMfQTM32RkLC+Cu/IanF2dS8nHmhhftP9e/5ESEB6gSMy6ML?=
 =?us-ascii?Q?SioxxAsuRbbgR+zgkF5Jh2t8UUW7D4R57FZ6p6WZzgtzMzcMjBCs7Gm20/kt?=
 =?us-ascii?Q?mrI/sQ/cdRAfxTnDC5ru9zc756+aWM9zOctziIm+f9U5+eOAz6cGz1ZHoA1+?=
 =?us-ascii?Q?R5dIr46Bv5fSLkWmYmFjtroOOZ2RP9ugmn12eOAbvVWV6JzVy3Odzg23l6H6?=
 =?us-ascii?Q?H5O5GZqUpwnwweChenAP7nXvrT9IvXJRuq1UiYaAxtQRgtKDhqdyCI5X2huS?=
 =?us-ascii?Q?ie/RPyHNCgqFmhW4mHScLZHb9emtvhq11xsPRP4MzUMLTwDIdWFXozUn+Gpv?=
 =?us-ascii?Q?9E6Kyld41YYEGGTjRTdJ8GIeeongRfjX781/b/Z0yA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MEDA0rz8fpV3eAcugnh6tZrvUwEmmjnYeglu5RjVe65qvt5WZuBGauzV7DmN?=
 =?us-ascii?Q?hBzXfFsjk0wjvfT/vWNaKfUTI9QxfdyQKyogkJu8N9zz4H7+jmCdCM46ZLuE?=
 =?us-ascii?Q?N6h7nHdgVOs7U6fYnDiWT76kLw6JaXnMkJ34WPBgAKR6AO7zw4SuuWEvcqLb?=
 =?us-ascii?Q?8Q16qUrN4YWBnlMCnDBY0NjJUVCyQRXHy1OlPnmsXMmmkLshOUQGWHbeREPY?=
 =?us-ascii?Q?ALnqyHzJiG69wlcf1csm4+Osi6xYk4O2VbAEMJW24nwf+t0aZqbv2PJX6Vk3?=
 =?us-ascii?Q?7NNqVrl0HXFtw3EK5AoRrSgLuAap3F0hdVPx86ceKQ0saVLOa7W8TqbJ9iGy?=
 =?us-ascii?Q?12sUKIcEdDfLNEzeBiAaZsDZeD4g5JfwpCTbYThzg7fsFoWo/YFjDSBNID68?=
 =?us-ascii?Q?LM0ypb/+idLnA6ZbtV5IYNDfpyiZNLTME2kWtRv86TkLwTxlidw6lHiE8+FV?=
 =?us-ascii?Q?japmuK+yrf15DJPFY5tbNSPZ9g+cLfWEtyZVFf6WhPmrlniRyHAsrBt+0ORG?=
 =?us-ascii?Q?Bg3xgzyRSlgn7LtVb+XmWsD1eGFnjzHPm41VLMYSkHwff4uJE3kB6ZUL+6OA?=
 =?us-ascii?Q?O64744hupF2AnoqWrNYZkmpp97jb3pH3QPXLPYvz2xxklhqpYo+ZQzYHNXsw?=
 =?us-ascii?Q?4keffBhyrS6TUEQQDCho8oTiXkEqQo83QG0LxnlcT2z4UtH0xuPXeR9F3TU8?=
 =?us-ascii?Q?/i9ppmiMVHtSnv2YgPtT3wqmDKxubv8YrNd6l8/jNJ9hCLvLYCgPEhbYiQ3t?=
 =?us-ascii?Q?fLsrxObzCzvBrVCAJ7Tdkg9CbhSWqljgW/9QXorGvkfEZe+8cxsGQ+8089aI?=
 =?us-ascii?Q?23Ja3WO//ZFLvJtY04VH8vMTsPqMvXha1rHLFkVOBPjABptlJ+jApnwWgM7d?=
 =?us-ascii?Q?kB3i6j8F5CSwTaJvY2I9qTLrvZ3HtruXiabfbSl5hp5pSSl8CAl5+n7AQvCp?=
 =?us-ascii?Q?0qUgbaCKy6hKTL1Ako3nWcY6Lf3qs7CPvT3wcoKd/oYSeNKkuhf7L1/wGrJL?=
 =?us-ascii?Q?xb1swigNJ4gzhiIvf7yy0oq4d8iFPYl7887Xizp74kQaPjW388nWpv5Qd+2s?=
 =?us-ascii?Q?WFnJFzT9ZTog7IY2WLJ8HuKPXn4JSIwvMHUA5Ramo6584eFesOYcveuPmyYy?=
 =?us-ascii?Q?UWXqeXVbfptxDWC+lA+Rs7is+NliL5zL1fjjyJuhPnZPybzySZdInxS0Jfdq?=
 =?us-ascii?Q?ySif2E491jkgtrDAChT3fNGXFJ7DdkawAi4k4iJzpc8rxzl7pdbfAHCpzIbU?=
 =?us-ascii?Q?cBiuJh1boJOb23Mpq9KEUovWwOvH+cSeA8wvJkujm5CZE+OKHQkmIfNd1e+g?=
 =?us-ascii?Q?474rfRcDBeRoJ4A0ArBvCluWdPQAlYKAiMPiMhfDqUGlUXiRce30jaQpfG1t?=
 =?us-ascii?Q?+ShQoG4We/3nrSpmLiA0Ty1nTK//gV187mkKXnpJxkAU/zssnepvd5B2GX0k?=
 =?us-ascii?Q?+2/ECoEtrOdz00JQhxlcSKBMHkAXBfN3lyi2HURJjJ2enn2voEMKzOmN6heL?=
 =?us-ascii?Q?pvjzdAIpwzxE0xRN1kSBIcFNkPnGX68JfBdHn8J4NK/kNJ3i5s5mrsyoZwuZ?=
 =?us-ascii?Q?QJH20G7SWcpL3CqrpftINP6mTjk+eb2On3ZnioaIrz14dMegHGaQb6GLOtxz?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a223047a-a4f6-4b6a-9cf9-08dc8f426a0c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:57:39.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfbkhSG7jKZ2JmxRmXgiXeRnTUg3hfTz0ymJwHdOC+RUO05zvxmr62nM5/FkdfJ08czGZ7/tcDC8ak2ylHyHjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:stack-out-of-bounds_in_debugfs_prob_set" on:

commit: 1ab5c34bcc6c6d033cfac4aa89846ffb3eb49e3f ("fault-inject: add support for static keys around fault injection sites")
https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git b4/fault-injection-statickeys

in testcase: blktests
version: blktests-x86_64-1c4ae4f-1_20240611
with following parameters:

	disk: 1SSD
	test: block-group-01



compiler: gcc-13
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406181001.86c775d7-oliver.sang@intel.com


[ 313.831312][ T3950] BUG: KASAN: stack-out-of-bounds in debugfs_prob_set (lib/fault-inject.c:204) 
[  313.838759][ T3950] Read of size 8 at addr ffffc90000037d68 by task check/3950
[  313.845940][ T3950]
[  313.848115][ T3950] CPU: 3 PID: 3950 Comm: check Not tainted 6.10.0-rc1-00002-g1ab5c34bcc6c #1
[  313.856680][ T3950] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  313.864726][ T3950] Call Trace:
[  313.867849][ T3950]  <TASK>
[ 313.870627][ T3950] dump_stack_lvl (lib/dump_stack.c:117) 
[ 313.874962][ T3950] print_address_description+0x30/0x410 
[ 313.881371][ T3950] ? debugfs_prob_set (lib/fault-inject.c:204) 
[ 313.886049][ T3950] print_report (mm/kasan/report.c:489) 
[ 313.890296][ T3950] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 313.895061][ T3950] ? debugfs_prob_set (lib/fault-inject.c:204) 
[ 313.899739][ T3950] kasan_report (mm/kasan/report.c:603) 
[ 313.903987][ T3950] ? debugfs_prob_set (lib/fault-inject.c:204) 
[ 313.908667][ T3950] ? __pfx_debugfs_prob_set (lib/fault-inject.c:199) 
[ 313.913865][ T3950] debugfs_prob_set (lib/fault-inject.c:204) 
[ 313.918374][ T3950] ? __pfx_debugfs_prob_set (lib/fault-inject.c:199) 
[ 313.923567][ T3950] simple_attr_write_xsigned+0x1a1/0x260 
[ 313.929629][ T3950] ? __pfx_simple_attr_write_xsigned+0x10/0x10 
[ 313.936205][ T3950] ? folio_unlock (arch/x86/include/asm/bitops.h:101 include/asm-generic/bitops/instrumented-lock.h:80 include/linux/page-flags.h:762 mm/filemap.c:1508) 
[ 313.940548][ T3950] full_proxy_write (fs/debugfs/file.c:328 (discriminator 1)) 
[ 313.945161][ T3950] vfs_write (fs/read_write.c:588) 
[ 313.949243][ T3950] ? down_read_trylock (arch/x86/include/asm/atomic64_64.h:20 include/linux/atomic/atomic-arch-fallback.h:2629 include/linux/atomic/atomic-long.h:79 include/linux/atomic/atomic-instrumented.h:3224 kernel/locking/rwsem.c:176 kernel/locking/rwsem.c:181 kernel/locking/rwsem.c:1288 kernel/locking/rwsem.c:1565) 
[ 313.954192][ T3950] ? __pfx_vfs_write (fs/read_write.c:571) 
[ 313.958791][ T3950] ? __fget_light (include/linux/atomic/atomic-arch-fallback.h:479 (discriminator 2) include/linux/atomic/atomic-instrumented.h:50 (discriminator 2) fs/file.c:1145 (discriminator 2)) 
[ 313.963221][ T3950] ksys_write (fs/read_write.c:643) 
[ 313.967298][ T3950] ? __pfx_ksys_write (fs/read_write.c:633) 
[ 313.971978][ T3950] ? do_user_addr_fault (arch/x86/mm/fault.c:1342) 
[ 313.977004][ T3950] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[ 313.981340][ T3950] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  313.987057][ T3950] RIP: 0033:0x7f563926c240
[ 313.991304][ T3950] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
All code
========
   0:	40 00 48 8b          	add    %cl,-0x75(%rax)
   4:	15 c1 9b 0d 00       	adc    $0xd9bc1,%eax
   9:	f7 d8                	neg    %eax
   b:	64 89 02             	mov    %eax,%fs:(%rdx)
   e:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  15:	eb b7                	jmp    0xffffffffffffffce
  17:	0f 1f 00             	nopl   (%rax)
  1a:	80 3d a1 23 0e 00 00 	cmpb   $0x0,0xe23a1(%rip)        # 0xe23c2
  21:	74 17                	je     0x3a
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	retq   
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	retq   
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[  314.010655][ T3950] RSP: 002b:00007fff65b08d98 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  314.018875][ T3950] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f563926c240
[  314.026658][ T3950] RDX: 0000000000000004 RSI: 0000556c73d1f0f0 RDI: 0000000000000001
[  314.034442][ T3950] RBP: 0000556c73d1f0f0 R08: 0000000000000007 R09: 0000000000000073
[  314.042228][ T3950] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000004
[  314.050013][ T3950] R13: 00007f5639347760 R14: 0000000000000004 R15: 00007f56393429e0
[  314.057802][ T3950]  </TASK>
[  314.060668][ T3950]
[  314.062843][ T3950] The buggy address belongs to the virtual mapping at
[  314.062843][ T3950]  [ffffc90000030000, ffffc90000039000) created by:
[ 314.062843][ T3950] dup_task_struct (kernel/fork.c:1116) 
[  314.080302][ T3950]
[  314.082489][ T3950] The buggy address belongs to the physical page:
[  314.088733][ T3950] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10d62b
[  314.097382][ T3950] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  314.104576][ T3950] raw: 0017ffffc0000000 0000000000000000 dead000000000122 0000000000000000
[  314.112965][ T3950] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[  314.121355][ T3950] page dumped because: kasan: bad access detected
[  314.127585][ T3950]
[  314.129759][ T3950] Memory state around the buggy address:
[  314.135214][ T3950]  ffffc90000037c00: 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3 f3 00 00
[  314.143086][ T3950]  ffffc90000037c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  314.150958][ T3950] >ffffc90000037d00: 00 00 00 00 00 00 f1 f1 f1 f1 f1 f1 00 f2 f2 f2
[  314.158832][ T3950]                                                           ^
[  314.166099][ T3950]  ffffc90000037d80: 00 00 00 00 00 f3 f3 f3 f3 f3 00 00 00 00 00 00
[  314.173969][ T3950]  ffffc90000037e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
[  314.181851][ T3950] ==================================================================
[  314.189769][ T3950] Disabling lock debugging due to kernel taint



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240618/202406181001.86c775d7-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



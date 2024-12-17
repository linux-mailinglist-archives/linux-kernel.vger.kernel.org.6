Return-Path: <linux-kernel+bounces-448778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC259F4559
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E747D168FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433A1D1724;
	Tue, 17 Dec 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFlNSoSw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A59152514
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421381; cv=fail; b=Po3poN2l4i1mwkcvzco+nafHx4YfpdliQN5egsKUONsjdGp+HMoimfoKNwOUasTmKN8NW5gbOUnYG7yCvmvZUREORwrL+g3okVc2uJv5vN3I7yQuIqDFa8AO1FtV4aqZD+YRm6PbedX2c1uSHw+Q2xGaVMlOQPG9DbAMeQKz0Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421381; c=relaxed/simple;
	bh=Ce5GM3qZ3Opz2oWcYYMqYxGtJva76/XryIGgW1geV2E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kGh8KNU9zSHarwOK//JZTdw4pkRO/TogdGMbmCtDBduoRIci0UFAimtHH17OgcDJNGQk8V3NPoAUnCAVf63+ZzG94ZQ2GHgPZZwNOXZi9WuXLp+32d1tYfRjetfpb+QmujFoV2FX7ltxWzDYs8Qs5OEa1zK0phJLnw71PyeTS1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFlNSoSw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734421379; x=1765957379;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ce5GM3qZ3Opz2oWcYYMqYxGtJva76/XryIGgW1geV2E=;
  b=cFlNSoSwSl2kNUXLyNLzuwC3QCqLXFPe8wjg1ram/RIh+caVtXTJzvET
   CbwtV8Af3dIXa8r5kh4++UFgobXOsQMPZ2jehR6z9i2YQJjuXWqL3gCAY
   VQ4YJF5CI45mynUR77SMpzWG9W+dM12jwb+TuCxwkmEnQZegcRYfIT+KY
   vPttp4yLfgWjIU1t7A395gI1ubf6ALlTvh9ICQGmIT/hIWj/XGrLacgsC
   jZE663Ec1xIN7FHIzXvEKBPwpLtzuF08swlfWTJohgfvI+PjbK7+xdDDq
   R24l3z/FK14xbRkwPhz3a8QiMn2yBsUKyttCXWtSa+hzYGGMEo7Vz6KQt
   A==;
X-CSE-ConnectionGUID: azXblNfkSlG5EYY+xMEhVA==
X-CSE-MsgGUID: HtwmIPk5SjGsIhFERRTcug==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34870467"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="34870467"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 23:42:59 -0800
X-CSE-ConnectionGUID: aGiaBwVwRde6GM+mId5DHA==
X-CSE-MsgGUID: lV3n7TV4QOe0LCJGHwH+nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="97334991"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 23:42:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 23:42:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 23:42:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 23:42:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eElH/9JXocRabrny89LEgBM87bKVTiRi5r+fuUwktAZUDimP5gql5VSUmy1g4MAJ/G64B196iiyznCrVGp2Bny6lUUm+SyHk8BVzLDxL7fCl/QYH4DWBEjU7R4Eg8ma98f2Z7hArOsQJSN15bl3RTY+7EdFPzKxgmEvrw/PL5LLaiEJIjfTe31Dkf81IT/KKR6J60Lgt0MsUOSg6bTpuPNUBAK/R66NRY+huA2U9TRa9XhCIKEVUEWfhdSBYgFsaSF9cZ1ZNGvXBrewuIfngI/LMR1UuXMewyWHGEC68RL7/mOKsqM27l4YW3i2TDtjRJxni7MArGu9ft4Fc+RYrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmyCDdre4t1jkgTqayvenRnUe15H3cfzfe5pZtntAWE=;
 b=mtzXNMMXUVLbZseI3Sl5xOxjN2xUWPyByEkO/R62Vk4yXANy4CafsXhorKOszRoiGba4mYQY8ooa/XpkZykixiajWngubuSevbwVG748diLFY/xfh+Jxsd8GthWHTjXu8DCuCYWMYqWpjzHbzjFD5ttrnBqCFsYZM7GeY+opWOSJ6oKCVzRS/xEf16xsD6DHLZmtIikHYfkM6vDVfDC09KYCjXgkHwSQ6bwtBxgtCxBXJ11y0eZCJ4Z3AneMkG3X8dreKBD9549IJVDGmm6ST3PgpU3UzJYZXPHQDywX31fcRtlWUCPTLWy5usKDPPNetXCWooq+Rfv71T1Pelmgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CH3PR11MB8545.namprd11.prod.outlook.com (2603:10b6:610:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 07:42:54 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 07:42:54 +0000
Date: Tue, 17 Dec 2024 15:42:45 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Masahiro Yamada <masahiroy@kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: kernel/reboot.c:226: warning: Function parameter or struct
 member 'cmd' not described in 'do_kernel_restart'
Message-ID: <Z2Erda0/c62UwolB@rli9-mobl>
References: <202412171248.ro76Gqt1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202412171248.ro76Gqt1-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CH3PR11MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: ba56f81c-c22d-4380-19d9-08dd1e6e6a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k9EhUOVrmF7Lk1Zv8Yl6IPiawyJle37qt5zRIM7+pgC+cLJQfmhXUCi46c9g?=
 =?us-ascii?Q?Lx59Sn6c0ENp1hBwSfgESdP8TrVe/tDJ/hovjnhCw2YgL5eu2sEG0N6TUoCm?=
 =?us-ascii?Q?UJuXTDeTi5oIKtPLQgQ/ZVs9idaxRGZsdJ+jrZeWsfvB0Po3w/6WZEYcdUTG?=
 =?us-ascii?Q?w8HHI8XjBqROSrJ2oXnoES1t1bJ74u0mN98S/qujoPlGMBra3v/Wkfa8l7Cy?=
 =?us-ascii?Q?q01E/tz5vpqG8vHyMz7U3q7XXVcuGpFjquBPiHycNWZUQUliJs+oMLChPPwa?=
 =?us-ascii?Q?YmPMEOvK1Y3/KwjyTk5W9opAFO87spMczJ2op+oggyOUMDNfQr8x74NdEkaI?=
 =?us-ascii?Q?r9IlccGNo4ByWhFCMukra0JnK9KrozjKOiA2N+LGPOSfMw9WDuux14FzFBoJ?=
 =?us-ascii?Q?IQKjlGoFZda06MrRfRcjixx3TBMqHod8eM1muErZLf+vJWEFQCM3oqg4Z6hF?=
 =?us-ascii?Q?MPjchBpKR2FBk766hqgwgV1mXYMNNh6nPa5yqwrDseptMKMfAq9vJKPcoXmh?=
 =?us-ascii?Q?viNhUuKt0OleEv67tMlSKg7e4IkLFC5a94uokeff3dwoKHEg0Xk0CZ1LqobR?=
 =?us-ascii?Q?rpOC7G4ny1j0DoYjDtJDescQR2Z4iYf0NGLNjnQlQxiN7AYA2WNFzbBuwQKk?=
 =?us-ascii?Q?YAjZ7RABJ8vkfAulrwye3ek+VFwXYToT//EMgRBp23Qhn9yf/PeZmbLS/v+5?=
 =?us-ascii?Q?Erz+mWgrcGzFozecTy4tLpZJlB/F+ukK7LtLsYg6rnGctzDv9eDkzK5VyREg?=
 =?us-ascii?Q?H7fHwjd3yUlEA9TRN24WEsSsjNlkaLdBUocwrFwyCOmg0hiCg7w3ylWAA1IM?=
 =?us-ascii?Q?5mI4jlw6Wok5Wmq4IhBGqTz6tsbdpotNqG7iFC6AmLDuWnpoPtneCosEaDsJ?=
 =?us-ascii?Q?wtvS4rtdHdaMj8jk6j+D3h8ehiHXjsFECJPhyegVaXz3gaU01dQf8H/AE2yT?=
 =?us-ascii?Q?xMjrDI+gYUh/ckyk7CjWfDkLquXzpP39grp7Si9a0CnEMqClunwaTeLvlr2S?=
 =?us-ascii?Q?TyInhOmc4iT1gEl5V2xvZT4lstBU9m9etsHBeRfsxM7msGEHpHNiCUpXXo4D?=
 =?us-ascii?Q?HjP1jAf8Y5MjrqVMvfTJ6iERkjctKW42QiHbY5w644o8pKTUhrvqMauNv/gH?=
 =?us-ascii?Q?9jw6bQiTYqFyPv+a3ep0RnFwo5uT8FRwYqWb63Ws67/lpgxy8L+comVmnO2p?=
 =?us-ascii?Q?1HShrmI5ucpOB5UHNTDCsfv5zZ7dbH6zdXDCrXRnbUIX+9fikMktD5pHluc1?=
 =?us-ascii?Q?0tC6gMeZKkt4I5nWn9SN3EiJSVQyRjN8O4DITKKJPwb/lT1kmKghve8eYLI6?=
 =?us-ascii?Q?Ss9Hg/W9nyHA7v7UMX/3prV5QUDN0frQWGE9oqgSH+ZA+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/pBv49eoQbgTWThoFLsmlJ+iec3y/tcyrm+u5ycT2BH0bqhQ5msWTGsfI7OG?=
 =?us-ascii?Q?oQVIm6foxl0vSQTGZwKAR9aVXreSuBVNZPGfQ2KDrK3x8Du3gUNJ6fuLnBmj?=
 =?us-ascii?Q?Dzlxj1DCmGUycp3T0aSE0XSJPXRvbPb+6yTtS3vREow7iqlUWCGvl+GNK/Pz?=
 =?us-ascii?Q?k5b3wkBSSPry0bjMAHDhmfIRPBykXH04HMQFP9qivuLSe8W/OIlstPSgFgdm?=
 =?us-ascii?Q?4kvNPFDnT7TIiqRgsgTx+tHZIYrtAV+QaizUXznQ8xBU6mP3QTPOLCxsj9Xg?=
 =?us-ascii?Q?JICJ/RvB8qNu3zrVKrz+0YJ2nMLT49Du6mIfFjy9vWoM5lD6npRpGUnt8wLV?=
 =?us-ascii?Q?Tnvw7ux9khQC2wtfFAkuM5xV2WXZ3YDCAmL4uZlthNxoVyd4g0wOdV8xrzst?=
 =?us-ascii?Q?LQYFpBJAA+OcR2cJi9N+3cO6c3JPwXzmYc65eHoy7JdRFhmmTDs+5aT9HK6L?=
 =?us-ascii?Q?EffGPokSDd+5vsClbKPCXxISA1IFa9Homo3/946JzMFKHph3sw7ABNE0dviI?=
 =?us-ascii?Q?qed9gFYRsjtvZSA9U9RcPD4Qd2B81TL7tqWhEdkFtTVgn/YKfM6X5PiTmrbs?=
 =?us-ascii?Q?lQJmbBPcxvESTOUpXVjIu3JVC5joqNRmzUPV4XuTKF710QeJfBenpIQfiHBF?=
 =?us-ascii?Q?GON/RjBuLGvmaS0/DD0lXi5R8tz4b7fQSFxhXgGxmavygIpOiYJyOUJ7PYKA?=
 =?us-ascii?Q?GNGtkeox0TwqZfppBxyrxnlrZT+y47c7FTwxSGHN4pOI/TjAZ5BMTitPK9+5?=
 =?us-ascii?Q?81ZJzOKh0sHy0yPMg6gB75ITTV4o6SJpQFpXlZgOFjDbZ1Im8IGRY7U0FJPF?=
 =?us-ascii?Q?LuKbUJpxRTZlS/jmhLRqyd8E92NBum7ElhPcdWZybDaSln/OM3pd3ET2CAbI?=
 =?us-ascii?Q?m57EPDfKLUjODAtbpyPnMR7p51WlW6lGnX2Ax2T7TR86wTiKo21qVB7BSyst?=
 =?us-ascii?Q?iHVgCcCJutDH2RktRZ24yonWdHkZVeMgWNOuaf0If6rocCLDsTKbcRFFPVR5?=
 =?us-ascii?Q?kj7Bs6F77TjFgnXgGRHq/P7B+Zx5MYV3KCQSnG6ZkfvOzyba0N8jlvQbYcEE?=
 =?us-ascii?Q?7jMdFIGj4EZnf8eZB87XyoXahfV9hgZaUwiMrLjUHY9tH1SAZE1jMpkbmDuc?=
 =?us-ascii?Q?5N5e3xyMFQU+dp6UtOsn76+qr9NFUZpqfc/3VGCT06Umia4kwjw55pj0tGqa?=
 =?us-ascii?Q?FRKit/xi1c7VR/ktadMvQ1WdtnWdXmtOVoN3PplYnFRaMb9iACtGkA3g8nlu?=
 =?us-ascii?Q?XqNfuTUlcWaxiG5aiQ7TD8rIwqQBwoXg1HvAZq255XVvKd8rgXO6MuaNZXEH?=
 =?us-ascii?Q?3jx24Lq8l2p1p0EnwSRWjfcl3eTPDnOmhlFRVl6D2KPxJqJkCVIk7gQO60Sx?=
 =?us-ascii?Q?kU3RZLK0pLr6tXoRTniuSVcv/dZx+WZyyy9IL1wdNXPev1o37HU7aMWzBKCF?=
 =?us-ascii?Q?qHSVtuVsonsqnkA/jTUkDHVmQUVRb0zHT5PZUi2RY2kZU849sK96Rrt/lIUf?=
 =?us-ascii?Q?SpVOEFBZDu42YyKtVrZWD2upidTc17X1/srM2WdXYP3LVE5f2l2sS6NIUSK9?=
 =?us-ascii?Q?C+aU6kotMKtO0YbSxbmVjM4hXVGlddJ7m+CRmvWP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba56f81c-c22d-4380-19d9-08dd1e6e6a7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 07:42:54.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cml8uOdwhPqZpbV2xysnguUuuU3t0g0pNsxIDaiQCQGAK0a8oKslzfv/h9KlMRZESl9mAikNw8Sv6rk/4GBtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8545
X-OriginatorOrg: intel.com

On Tue, Dec 17, 2024 at 01:02:37PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f44d154d6e3d633d4c49a5d6aed8a0e4684ae25e
> commit: 92ef432f027cffe0ff91ff2cbe9258d89ca53968 kbuild: support W=c and W=e shorthands for Kconfig
> date:   1 year ago
> config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20241217/202412171248.ro76Gqt1-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241217/202412171248.ro76Gqt1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412171248.ro76Gqt1-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

Sorry, kindly ignore this report that the commit is not the right one for the issue.

> 
> >> kernel/reboot.c:226: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
> >> kernel/reboot.c:952: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
> --
>    lib/vsprintf.c: In function 'va_format':
> >> lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>     1683 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
>          |         ^~~
> --
> >> lib/hweight.c:14: warning: Function parameter or struct member 'w' not described in '__sw_hweight32'
> >> lib/hweight.c:14: warning: expecting prototype for hweightN(). Prototype was for __sw_hweight32() instead
> --
>    drivers/clk/clkdev.c: In function 'vclkdev_alloc':
> >> drivers/clk/clkdev.c:173:17: warning: function 'vclkdev_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>      173 |                 vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
>          |                 ^~~~~~~~~~
> 
> 
> vim +226 kernel/reboot.c
> 
> b63adb979583ef Guenter Roeck 2014-09-26  213  
> b63adb979583ef Guenter Roeck 2014-09-26  214  /**
> b63adb979583ef Guenter Roeck 2014-09-26  215   *	do_kernel_restart - Execute kernel restart handler call chain
> b63adb979583ef Guenter Roeck 2014-09-26  216   *
> b63adb979583ef Guenter Roeck 2014-09-26  217   *	Calls functions registered with register_restart_handler.
> b63adb979583ef Guenter Roeck 2014-09-26  218   *
> b63adb979583ef Guenter Roeck 2014-09-26  219   *	Expected to be called from machine_restart as last step of the restart
> b63adb979583ef Guenter Roeck 2014-09-26  220   *	sequence.
> b63adb979583ef Guenter Roeck 2014-09-26  221   *
> b63adb979583ef Guenter Roeck 2014-09-26  222   *	Restarts the system immediately if a restart handler function has been
> b63adb979583ef Guenter Roeck 2014-09-26  223   *	registered. Otherwise does nothing.
> b63adb979583ef Guenter Roeck 2014-09-26  224   */
> b63adb979583ef Guenter Roeck 2014-09-26  225  void do_kernel_restart(char *cmd)
> b63adb979583ef Guenter Roeck 2014-09-26 @226  {
> b63adb979583ef Guenter Roeck 2014-09-26  227  	atomic_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
> b63adb979583ef Guenter Roeck 2014-09-26  228  }
> b63adb979583ef Guenter Roeck 2014-09-26  229  
> 
> :::::: The code at line 226 was first introduced by commit
> :::::: b63adb979583ef185718d774d8162387db5589c0 kernel: add support for kernel restart handler call chain
> 
> :::::: TO: Guenter Roeck <linux@roeck-us.net>
> :::::: CC: Guenter Roeck <linux@roeck-us.net>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


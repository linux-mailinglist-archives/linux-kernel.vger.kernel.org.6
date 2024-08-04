Return-Path: <linux-kernel+bounces-273760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFA9946DAD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DF11C2097B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11F208D0;
	Sun,  4 Aug 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQIDsGAb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B7200AF
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722761818; cv=fail; b=tPEkAFYtc1wK5bxXcR3yY+nGRLeNC5dIp7z5vbws1+eCC4v3kcVLB5Tpufaj1rdTyzgFDIEHDmYsAnNykyPP6s/F3y0VtHvuVkyGWtMUZBaH7tKkwdwXBRmG/+9V8xAY1RSZZnxYJABl2iI3HMpq38warZB/D/OJYrkuTAWgjHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722761818; c=relaxed/simple;
	bh=JteJEtcyKZsgYWHS4BONAlcjzdJSA94rDEa75YlLlW8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=U/LLSfaGee7M8IfJPxVQ7WxGiZINI6sMD5zVt6qqJYMPJsFcgqK4o1ZEj+Eqs9OE30rNuCcygDHPmYULJDl5FL2FehFQwrV0z3K3HoSpOCXOftXb6jHXE6ReDEYpNwD6/tjfPZw7R7hN/T5MzpmAv9cwz8srqq6mDhVpd4XSvac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQIDsGAb; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722761816; x=1754297816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JteJEtcyKZsgYWHS4BONAlcjzdJSA94rDEa75YlLlW8=;
  b=ZQIDsGAbFilA0rNbMVJdjwtY/N1gyhvjXPa2y+dCWSo0riSKdA+vpX4y
   1LNYjnaERxFtNAuig5OFmqO6YPs2v6z+ZRhqcbDq/Gr4Me/ifchhzgVmz
   u0LNRYrxa4PYIGswoPKP1obJ4eAvk2li45LFMdYthgelHjUIn5Ii6ploY
   GLKPplMjjWsgsICS345as0rBRslasA64b9NKkl5e0ApjRCqUX02mnHFkQ
   sIXOWwllPjdbHODuse5ByNlw3qJg4yTG9WowF+QXWXqCcdvr0JJU5SD2a
   y3V8vb4vPIt1K41Fl7i3CB59SCnSEcUGCB2qFnk1GWHpe9QKfffUWamfD
   g==;
X-CSE-ConnectionGUID: ufUovgvZRLuV9JP7tWen4g==
X-CSE-MsgGUID: O64Y/5+vRJeDMXfmczkzcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="24604340"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="24604340"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 01:56:56 -0700
X-CSE-ConnectionGUID: 8eumCFTvRSyayZO2ne94eQ==
X-CSE-MsgGUID: X6VkgFEZTmmjOSb9ZwIIFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="60864742"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Aug 2024 01:56:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 01:56:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 01:56:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 4 Aug 2024 01:56:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 4 Aug 2024 01:56:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0pCc8sxWDHWp25o7I6KjQLsvATZ1ATqYDTxNty+Fb9P78jFa240myb3cUfnm/HbavZImaXDD94QGKMZyjnaS/Sf8FgG+Oco9EUkoYd138dsvvzXf8p73aH6gSUFTYfRzjA3Z6n7ty5eKhvoVE1SVN3+S3je22hjdGH8i/RNswoDgn1Cuc2S7rI0FwySpg+MI/CIFtrwvr/Vcl++DvzySxEKDXAOQehhMvIV3dX1YfL7SApTb8dXu+OulyOwW+FQGdeQEtt91eF9kwcg9S6m3FINn+CG0UVuz+/d6Ht4Kb71J3NCEzWwaP/kFbevpQeCHBR2EKVgFmijcrFEDhK5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdWLkuS0SuGgW8saKWADuy90GpBHtRgMasRNptSTq9M=;
 b=Q1ePjy5Jvkm0RPq2tuBRm3SbESvxKceP239KvQIPcaCcdUXii8RpH8gDylrwGqtzbUcNnCYn/omJqAIoFjrDwDjkrYxMhjw3WIYDVPpH0KUlIMpQIjcveLNcBJQ6oIHT4Y25VcwhcOJcUYxx6pwrub5nr46kKbJlWBVgnDelrPgv8aeW2Zwpif3d10t2E/YK5nZfW91hwcbe+4bni4IYVvx8m57+BmOBn/hxbvPA3z5y0rDGbJTkmql/eMBA/UhkF/nR+UowbEDDRu89Cs0X+p/pGwwcpQAscvIhQa9fh3Pfl8kZb2vYM+Rr4qZSAqyR/xxB8vovQb0pjzK+mOaMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB7982.namprd11.prod.outlook.com (2603:10b6:a03:530::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Sun, 4 Aug
 2024 08:56:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 08:56:51 +0000
Date: Sun, 4 Aug 2024 16:56:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kees Cook <kees@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [mm/slab] 2e8000b826:
 WARNING:at_mm/util.c:#__kvmalloc_node_noprof
Message-ID: <202408041614.dbe4b7fd-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fb43b2-fd3f-41da-e40b-08dcb46361a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b3HPnWG3ndaY1F2XMGqBwfqSSPCP8yTSu75IS535Zuwb4/WfFROtmwxEJ5+0?=
 =?us-ascii?Q?XLjq1Syj4TtG75HieoMflHdHi2m+4rngOuah3Gg0B7Owqn+sI+bs1i5Ld8ds?=
 =?us-ascii?Q?FDECVZuQDgHEhOQjEYG6FqoGaafK9hkXzDsOQMz6kw5o4CDgdu68UIYrSueJ?=
 =?us-ascii?Q?pQ1O3Fny1doQ/xVhhohwuQwI53vT9K9IelaeSbkfsJTyM0NdXNEZLGrHyE0J?=
 =?us-ascii?Q?bZsmEfn6S7028FBG/I3xeR7AxFqm4cwQ3U9omKQ3hHhKOxvJcR9wovrJp06o?=
 =?us-ascii?Q?yTJPLYtpUWXAZB5LX/fPw6BHmxqnS5Ib/VXmcPOIlgeZn8m1J0PB4ht4mwGg?=
 =?us-ascii?Q?KtX2mFI5G+h2AG/F6+VsRFDJPTb3vHmNznSWDTC1zThvA8XOkw+ayGB4rK11?=
 =?us-ascii?Q?T9X3Wj9CQ4Judi0VqCfB3i2yS6HYNZ/IhgtqKdvledfh54JsHRAh6Pye+yTt?=
 =?us-ascii?Q?cYKn3wKtB5pSQlh1vBKlrvYnId5KmqIKE0DDfMddmQRJahNRDqRvyHkAQ1Av?=
 =?us-ascii?Q?bGUr/rF7l2HSdYAsDhQItfGR62d2Ra9D9CnlJ2zu1Mzrr5RcP+2LqcsRmP1S?=
 =?us-ascii?Q?LlLmvaby231b+vIbm44dl1gyfX/mLn1jq9yfoiYYTaI3qZC/NzfGUxJFs7Pw?=
 =?us-ascii?Q?13TxafWSD/Rc4l7mFPLHv5+ESIinjGWtxElWODQNAGeFefFVlKeYOik8JikK?=
 =?us-ascii?Q?Hvr2fqAsB3i5WpflvYxTQpwS5yKW/oynnfeZNq4HInXRwHSAqAKXPcsTPaJV?=
 =?us-ascii?Q?hpIFzewMiivNHiiXwmq7qkgZ7RJdO/LQAxXWTwq9xrXHDqAoPN4kLUT6X34+?=
 =?us-ascii?Q?8sdWAR8SPfJUFfy+lVbCr8F07TEhUuKAmZ/TorY7lmFax29yrBqFHjfsV0DA?=
 =?us-ascii?Q?ZXcuefyFWObXNVFBSwsRT5IqkGl4NU0dSrUo1ZaCQ7aCwLdLAkK/WpnPOvGT?=
 =?us-ascii?Q?KzTLuy/nB6WjPL9xPshy22Prm2/h6m7CbVd+pwHn+QlxWO6M+2u4raydzJ7x?=
 =?us-ascii?Q?sh8mFgGpS5fi/snvB30Rof2DSa3J2yEZdZrRBDAObwqS4isE9rbqf5rnGE83?=
 =?us-ascii?Q?Ja33wy8mpLrrlBbJZKPzFsR5CDvSy6p296hFUMratCjYuMKKpcJEI/gLoAYe?=
 =?us-ascii?Q?8EW39XB58++HvI36gALiIgLiOvvOc/3ZTSgc6Slm3q5krEzATfRbjVjDM2jp?=
 =?us-ascii?Q?Tmk/BfVhS49tJ7465iH3I2lS+PnwXnUcTLmjJ1gtaTpS6kSpUYmbQfBP60vD?=
 =?us-ascii?Q?rA9f6ntNV0W4yaziit+81GYEqVIZdeBQYnemDx66ADYyQnaaX/dWgfiH2D99?=
 =?us-ascii?Q?dx0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9UT9rpoQxJH7hjIW8jYV/AYtWiIXEdusXieJSGEWjr1gyF8Dv67wDVYjVCSz?=
 =?us-ascii?Q?ji9SRRwIlU4U+5v/+YlldVKNYFaZpJOJ7ytAn4FbELdwb/7s2bh7eVzNjNup?=
 =?us-ascii?Q?DuE1ucxGPNnP/wudqoTAKxl8sUjJ6101F6R0Q54J7+FurfY/3g6Ne+OnV8AI?=
 =?us-ascii?Q?lOBWpOPEpsTepikpRvCbR6PnSe0r9GaIXpVY3GdAcaqgbhnGa4q0hY8eW9zD?=
 =?us-ascii?Q?SSNY4NZKnKxkWXu2ZKB5u5//+oDkxuQqdiUdkorWZv3ZOOY2cXIBCSns8puj?=
 =?us-ascii?Q?e22X63rnEo10qrbzs0Zxvm/dDwv+3XODCzuqyZb4PYepKnci8P0xwLJPed75?=
 =?us-ascii?Q?ON1r5AuCKZDm7THcicbh3h0SO/rToZuJ1LklSOGEY8tW3/jAMmEDw5jpGd8k?=
 =?us-ascii?Q?tIOBQ1qxOcEj5fZdg6ne1hbXG1n1zVl1w9Vh/w9vt517jw1IbAgHvQskv6Dc?=
 =?us-ascii?Q?lkZSBQOZjbMz3lLRXEt2hEtyy9QCQAJrMWEitRI4Tm5rg+3eV2y5detUtOsa?=
 =?us-ascii?Q?rL3hzuMUhOhnffbxDti6LGXtB/8uvrK9qQxFwewfnztwke0LVrrzhP2PRWF9?=
 =?us-ascii?Q?HUPwk6Nkuy1kcVnCWPvFly01HlppVjOyYbbxF0oADjZVMVdc6LKDU/JSJPdp?=
 =?us-ascii?Q?2k0GmwMmO3CzujHHV5L/oJqwJCJAbD/aVimaSqFwUUIsHGS2b5/c1MkckfNS?=
 =?us-ascii?Q?a+ZfrHCLRXhBok9kZNyZBI3BW8jHOT12sn0oZi9UnWWAi9ooIfg7BCf1QrEk?=
 =?us-ascii?Q?Mo52S0JcDufqwcmjEMSG5c0R/Dz/EG5uXH1b6JxGeuzic+ndV+zOZ8lWYlps?=
 =?us-ascii?Q?heO8u3VsZFjlh5nOoC/sRL3R95bbw4RYxvt4dLOtPIrAL9vSjAS/aRgYP7oh?=
 =?us-ascii?Q?CznpVKLRD7n9By82w+vErpAiZ3Q0aauSmXega8TzWpNc3gfiS63jwzdXN3/Y?=
 =?us-ascii?Q?R0r3VeL/TWzxP3poykHsfOftJOAB76K7lcQkVsKDgbX1tTAGywZzXe5EuLnu?=
 =?us-ascii?Q?hY2NQhpXW4+jpIyvxPYQIXTL3gIxJBheq2pBRH4kNoeoMoUSD7l7kKuGX0+1?=
 =?us-ascii?Q?pxbsl3Hi51Bk7F/BOp6NNTeX9uNs1rL3MyKyRTCq7iMqxVQC9FpAvQz4qEUd?=
 =?us-ascii?Q?+286YNr9D7e/7NPmqcbhB8LajNPPjhz1DQylsFg2PFAfpxnrjnBSZ2FRs3q/?=
 =?us-ascii?Q?sRtbm19cUsSygOiy77vly6kJb+dkxgmjw3qbhS4GHUU1zFfXskr4hqxJ31ml?=
 =?us-ascii?Q?7o3AZgqoESWlg87iIdfOIWvHDdw0zpSUdo6mBn8XqI2S1+t0GMLrKvMixaWs?=
 =?us-ascii?Q?0t7FFkcT0STj4z8Rtc265Iiadid18xMIgR/OFDkeC5u5RMLZkGtO/QhhA0TJ?=
 =?us-ascii?Q?kvLOBF46zmakOs7rsp9i8gkuZIBj0a4UFX6Z7+nSUNXOA3FUiEuWMxJ+VWP9?=
 =?us-ascii?Q?h6S4csAIVtxB23YgEklmTWqeXUyqJuKzF9rsfunpgw1vHnxn3rQFJvQSN0/K?=
 =?us-ascii?Q?xtO5eem5vu8LJR24BS2dFnIGfwZaGTlF5JJ3zGFAkWtmc2dysDDlwbAufEMU?=
 =?us-ascii?Q?J5wch0m6y0dKxm9KWMCi1lhefb8rCxLM6ggtyTv9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fb43b2-fd3f-41da-e40b-08dcb46361a9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 08:56:51.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0K159HOcAYZUArJFv7G3ZWVV9qA84sZvdHE33GkPgEnpI7lhj68nhUAvCNb02AA7/EihQ/c1/XiCd0u5GDXCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7982
X-OriginatorOrg: intel.com


hi, Kees Cook,

as we understand, this commit is not the root cause of WARNING. the WARNING just
changes the form from (2) to (1) due to this commit.

67f2df3b82d091ed 2e8000b826fcd2716449d09753d
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     dmesg.WARNING:at_mm/util.c:#__kvmalloc_node_noprof  <--- (1)
          6:6          -67%            :6     dmesg.WARNING:at_mm/util.c:#kvmalloc_node_noprof    <--- (2)

however, we failed to bisect (2). so below report is FYI what we observed in our
tests. not sure if it can give any hint to some real issues.



Hello,

kernel test robot noticed "WARNING:at_mm/util.c:#__kvmalloc_node_noprof" on:

commit: 2e8000b826fcd2716449d09753d5ed843067881e ("mm/slab: Introduce kvmalloc_buckets_node() that can take kmem_buckets argument")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      786c8248dbd33a5a7a07f7c6e55a7bfc68d2ca48]
[test failed on linux-next/master 9ec6ec93f2c1e6cd2911e2a4acd5ac85e13bb3e2]

in testcase: igt
version: igt-x86_64-73e21b2bb-1_20240623
with following parameters:

	group: gem_exec_reloc



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408041614.dbe4b7fd-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240804/202408041614.dbe4b7fd-lkp@intel.com


[  928.741334][ T5136] ------------[ cut here ]------------
[  928.747005][ T5136] WARNING: CPU: 2 PID: 5136 at mm/util.c:650 __kvmalloc_node_noprof+0x142/0x190
[  928.755967][ T5136] Modules linked in: btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal ipmi_devintf ipmi_msghandler sd_mod intel_powerclamp t10_pi coretemp crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg i915 kvm crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy ghash_clmulni_intel intel_gtt sha512_ssse3 drm_display_helper mei_wdt ttm rapl drm_kms_helper ahci wmi_bmof libahci mei_me video intel_cstate intel_uncore idma64 libata mei i2c_designware_platform i2c_i801 i2c_designware_core i2c_smbus pinctrl_sunrisepoint wmi acpi_pad binfmt_misc loop drm fuse dm_mod ip_tables
[  928.812981][ T5136] CPU: 2 PID: 5136 Comm: gem_exec_reloc Tainted: G S                 6.10.0-rc1-00009-g2e8000b826fc #1
[  928.823924][ T5136] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[  928.832080][ T5136] RIP: 0010:__kvmalloc_node_noprof+0x142/0x190
[  928.838186][ T5136] Code: c4 06 0e 00 48 83 c4 18 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 49 be 00 00 00 00 00 20 00 00 eb 9f 80 e7 20 75 de <0f> 0b eb da 48 c7 c7 f0 fe cf 84 e8 5e 2c 19 00 e9 3f ff ff ff 48
[  928.857727][ T5136] RSP: 0018:ffffc9000e82f6f8 EFLAGS: 00010246
[  928.863744][ T5136] RAX: 0000000000000000 RBX: 00000000000000c0 RCX: 0000000000000013
[  928.871647][ T5136] RDX: 000000000007ffff RSI: ffffffff81a13806 RDI: 0000000000000000
[  928.879565][ T5136] RBP: 0000000080000000 R08: 0000000000000001 R09: 0000000000000000
[  928.887466][ T5136] R10: ffffc9000e82f6f8 R11: 0000000000000000 R12: 00000000ffffffff
[  928.895375][ T5136] R13: 0000000000000000 R14: 0000000004000000 R15: ffffc9000e82f9b0
[  928.903288][ T5136] FS:  00007f0ff830d8c0(0000) GS:ffff88879db00000(0000) knlGS:0000000000000000
[  928.912151][ T5136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  928.918679][ T5136] CR2: 00007f0ff8100000 CR3: 00000008162e0004 CR4: 00000000003706f0
[  928.926595][ T5136] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  928.934489][ T5136] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  928.942382][ T5136] Call Trace:
[  928.945631][ T5136]  <TASK>
[  928.948499][ T5136]  ? __warn+0xcc/0x260
[  928.952503][ T5136]  ? __kvmalloc_node_noprof+0x142/0x190
[  928.957994][ T5136]  ? report_bug+0x261/0x2c0
[  928.962429][ T5136]  ? handle_bug+0x6d/0x90
[  928.966692][ T5136]  ? exc_invalid_op+0x17/0x40
[  928.971327][ T5136]  ? asm_exc_invalid_op+0x1a/0x20
[  928.976295][ T5136]  ? __kmalloc_node_noprof+0x3b6/0x4e0
[  928.981709][ T5136]  ? __kvmalloc_node_noprof+0x142/0x190
[  928.987199][ T5136]  ? __kvmalloc_node_noprof+0x53/0x190
[  928.992590][ T5136]  eb_copy_relocations+0x166/0x450 [i915]
[  928.998467][ T5136]  eb_relocate_parse_slow+0xd5/0x860 [i915]
[  929.004513][ T5136]  i915_gem_do_execbuffer+0xaa5/0x2420 [i915]
[  929.010657][ T5136]  ? unwind_get_return_address+0x5e/0xa0
[  929.016135][ T5136]  ? arch_stack_walk+0xac/0x100
[  929.020836][ T5136]  ? __pfx_i915_gem_do_execbuffer+0x10/0x10 [i915]
[  929.027424][ T5136]  ? kasan_save_track+0x14/0x30
[  929.032147][ T5136]  ? __kasan_kmalloc+0x8f/0xa0
[  929.036759][ T5136]  ? __pfx___might_resched+0x10/0x10
[  929.041892][ T5136]  ? check_heap_object+0x6f/0x4b0
[  929.046766][ T5136]  i915_gem_execbuffer2_ioctl+0x2b2/0x680 [i915]
[  929.053171][ T5136]  ? __pfx_i915_gem_execbuffer2_ioctl+0x10/0x10 [i915]
[  929.060100][ T5136]  drm_ioctl_kernel+0x16f/0x2e0 [drm]
[  929.065417][ T5136]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
[  929.071239][ T5136]  drm_ioctl+0x4d0/0xad0 [drm]
[  929.075948][ T5136]  ? __pfx_i915_gem_execbuffer2_ioctl+0x10/0x10 [i915]
[  929.082882][ T5136]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
[  929.088119][ T5136]  ? __fget_light+0x57/0x420
[  929.092587][ T5136]  __x64_sys_ioctl+0x137/0x1b0
[  929.097212][ T5136]  do_syscall_64+0x5f/0x170
[  929.101572][ T5136]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  929.107321][ T5136] RIP: 0033:0x7f0ffa6b7c5b
[  929.111603][ T5136] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  929.131013][ T5136] RSP: 002b:00007ffda154ae00 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  929.139261][ T5136] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f0ffa6b7c5b
[  929.147077][ T5136] RDX: 00007ffda154af10 RSI: 0000000040406469 RDI: 0000000000000004
[  929.154890][ T5136] RBP: 00007ffda154af10 R08: 0000000000000004 R09: 0000000100000000
[  929.162704][ T5136] R10: 00007f0ffa7a8298 R11: 0000000000000246 R12: 0000000040406469
[  929.170515][ T5136] R13: 0000000000000004 R14: 00007f0f78200000 R15: 0000000000000002
[  929.178329][ T5136]  </TASK>
[  929.181207][ T5136] ---[ end trace 0000000000000000 ]---


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



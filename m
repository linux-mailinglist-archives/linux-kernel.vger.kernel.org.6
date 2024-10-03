Return-Path: <linux-kernel+bounces-349181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13C98F241
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B371F22AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7B1A0AE9;
	Thu,  3 Oct 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUuis6NK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985541A0719
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968452; cv=fail; b=om22IBeIoXfqSW6htpr8NCjyCLSPfvU2hLjojCYXwQQpO68yCEfgvQl/wM50Ig7Tm/DD035IlaxLNPRdLsKr4bLJZjMkyn5IKbcQYNiLreVXtHF9hdGCdYCZW07+YtiAhYXPF+EW88zZMGKiSJqd73TWfF5L3z8OFPLVIyHVi4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968452; c=relaxed/simple;
	bh=UQycPe+2wpMsF+fUHJYM+SG8ep5i+FAMIahBNzdv66s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huVoyqLdxjdFyd8pU4TOmXMS38I5CLF9/6diAi2HNcHDu+r99a3npIrCYTQe6t9J10Y2DJllZJ06SEwg9FbJMKs0+mZN8m54cZbK2Nlplv/RA26ZeeFD61CdX9eQV1mDnZ7iBBru6uIvWD5hREzraqhQDv9PHmBc5V1Ru4RcMYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUuis6NK; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727968450; x=1759504450;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UQycPe+2wpMsF+fUHJYM+SG8ep5i+FAMIahBNzdv66s=;
  b=BUuis6NK8sMqh4xe25/aJBtjujm7mfBRGDI8xEmCqk+0G9epyqiFWXoL
   cnmeHao+wJAVAzv1L2KRpa55qn5MfpUJE7mMi5VI5t6M9pcq8HmOL++FX
   WQKWNrpcgxkmj4hbcKbsQJzE2GAKehAIWlg2FGu7hePvaOHvawQcBM3Oz
   d8x2RGLQcdcLzgKUxN8qXGGutuwNG63HSNGvhxeFMJBaN7jD/Fv7W3rf1
   QzJGAyXQ52b8YtRi1+5mhg4g5m5WlJVWv7849Z8ie6v32Dq6sXi/gWPi4
   QTva1+nVTknvV86iqYfKMcuj83sL3AcJGZbJhKEtyKA+aeynWgp/Dn2yE
   w==;
X-CSE-ConnectionGUID: 5IYPbv2sRAOEz4rzpVyWLw==
X-CSE-MsgGUID: omtBh84sTESVNCMHqOXSgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="30876359"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="30876359"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 08:13:48 -0700
X-CSE-ConnectionGUID: sQGFj5dcTpSkre0FrIvJWw==
X-CSE-MsgGUID: VC/nbqptQNCixRXIBA++EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74625654"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 08:13:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 08:13:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 08:13:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 08:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdFRQBXb/q2voOzM+cECtzWdkDN8B0X3pnMOai0zgiwobDCG6GCqeiUkJnRNTr7OLB761m1V2Qt6w/p9sAL05hlLX0djQOy/xFfAMXEooa25+kyghDeSNuL2i1Ye0LLoaby+aHUBRgqzBcQa+vJh46aGK9XYUeQvqTo0WpwQrAU8BOM1GSrbgrCnkuNhhoO32XmBzPd/uVmqlCDNudz1eO10cr+r49J0u1DjTIbdfSOwPCsVOgmjwoHwme5sBQ1+Cy7o/muwyGlq3MTVyZTjdUZZSCspiZxfRxKn1Gtpzw+4mhDhhoylLJRt0DxlNHM9MIjT/hWmNCt9scH5RoZl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u99LyapZPIvWEUzVqVU1XEAzCxv/x1i+h0iApY49uUs=;
 b=WhTh3iVv1dzNncOhfQXvjVkcSKpixZDMhITYjHF8+9HXtssn8nWtexAhM59DuETGObNf7158AEs3l07YUBXhGz567jI4JJRqfuRO8S/OZkXhBDE6IvJs7GFphC9VYrqkIWXnGi19XLGhXkr2VPVOmZBNC/AxuIlj7cNOO4oomTHdqQOmVt0NumLJHdqGzBnyVkQB8QARwTerWg9U++E36Z/ttsFNpZ8+rjtzjIbBg07I0OH9EWEQEbRvXTCD3GinU4eBJaJtqh0E1oumIMWnQzxKHSH3gdhzV5xjfK003DL+AttOjzk7ThrDXDgoj70y2D4hpr/GvowoyL2+JMtvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:13:35 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 15:13:35 +0000
Date: Thu, 3 Oct 2024 23:13:27 +0800
From: Philip Li <philip.li@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct
 regmap_bus' has no member named 'read'
Message-ID: <Zv60l6y4ij6C6U2J@rli9-mobl>
References: <202410021111.LknEX9ne-lkp@intel.com>
 <6e935f30-6dc5-4422-842d-068c08d31333@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6e935f30-6dc5-4422-842d-068c08d31333@gmail.com>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|IA1PR11MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: bca0ca22-02f8-499a-9547-08dce3bdf387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UZ65n77w8xjQXX4k45IbS9DoGpI+KQbgOcIefJJ0r7AfvneDrcWI9tJofFZK?=
 =?us-ascii?Q?JKw/PIQNUiOVN+gmBFY76DZp7LsudYVA/jMzm2MHYvO4Eqz8pL2xUgyJiNg8?=
 =?us-ascii?Q?qwHexPGoMsfctE0qMe6usG7jJdCIXwY3XlDu/WG8ZSK0RTI7dgXEfeL/3fMv?=
 =?us-ascii?Q?ASGHnQbXpS3fXiojDlYPwOxE4A2+agXZl3gHjwftI3QN1L8WwzuGo4G5W5bC?=
 =?us-ascii?Q?qXWbCE7Sijh4mEpLc1tCtwLM92MSAMfftMg8pupri0IGtxaK1AtF8CwrGbTV?=
 =?us-ascii?Q?DWf98FcYwNMfYd1jJidvCdT7JpaIf1KBD12j3znx7dKIyF2YecGnZungGDDf?=
 =?us-ascii?Q?IjPZbtIzTh8UkdGJvMoO0pdgE5hxwZKpeLw9XzmvLRuVx3vnWRaFvkiZQLIS?=
 =?us-ascii?Q?7qeO7vlmLh+mcKBqlp5iOi+0M94e7VqQ4ntb8f/SQNJdNlyOgOoYmwVcqRbe?=
 =?us-ascii?Q?tAkYz7IGxPqTvRYjHXPNXzJerhslMQK/A6PfJh3vrlfvX1Y5iHPHECmfnych?=
 =?us-ascii?Q?LLlYMZMoL/uDFNdWbf+g97T4ZMbD4Gsv0GpMF8bgkGEi/CuJK6PVU4Uool80?=
 =?us-ascii?Q?RLLRLEYJ62dlJm3fJRJP5jMYRtN+id5M3Zt0xZ/bB66V9exIxm2SjocrhCld?=
 =?us-ascii?Q?3o0GhrMAqIYtDnkyLMNFjB7J157DltDhD6xWc6idVyjx0+PMq5gLXi8VGvoO?=
 =?us-ascii?Q?FYiS0dPKDuUEDXFigsVSsZvAhUcK7irtGuDlyOxuXGhiYCsxYQVgPgx1fbdE?=
 =?us-ascii?Q?FQCTwXQb/eNQDr7zJARtSI/ARS+S/zESX3Ar8/8fYtzeBul/ZpsSR386Px4O?=
 =?us-ascii?Q?A4UVpkJxhR6Eb/nP/cidYbDyd2LHzr7kMOhGl9WfvvOV78TdUFcHzlgeo7Pd?=
 =?us-ascii?Q?cuEu3DKcxsXIBVflS6WGPrTA+Hy5nl082FcFpF5CtJWvXCzzH3f/WT6tbwKp?=
 =?us-ascii?Q?fTXIFV5mVSlu43lEYrCdgtKZdQu5vOP0ZUrL4g9Xr2D2Bj0+uBf6kNMwI61J?=
 =?us-ascii?Q?0Yg6+PiR/499Lq0ILqdnq9JPu8QWmLEQUOpX8Eqs3fWFQjEG/uDhloYzNRx3?=
 =?us-ascii?Q?WjEQ9GRJiCF4CLfI4YDRThDW9AMIfo+Z51vSv/z+xfJ42Q5E/+MfY+cp7PH/?=
 =?us-ascii?Q?xcd+XZI7GJz2cv0+fTzaLmDWsvE3DfVVz54kx7uNnIadE0wzOt6CKf7/5gVI?=
 =?us-ascii?Q?X2mZqOQ+HOYbjVs5I2LnfkkdhTXviGuOQ1Iy5dx/Vymc+suVVet9XCWeOdQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PD+MStxA+DwR14Q7WyIv4Zo9dtpJ6t+UiaRTyahErOQi6MJUp1XELWiuNM5X?=
 =?us-ascii?Q?Go8atalmMvclHZel1FzXi8T81L/iHKo9+iAsbdqU4bNY+z9S82JmKARuCN2o?=
 =?us-ascii?Q?fC7JkcBDbOHX+9NjkIWqrBX0dm9uInHZ1KEl5oPv/8rggQfAxi5W49tjw1nF?=
 =?us-ascii?Q?cnqj6z6iSt2thFvPF/dOnPdvizcJ7VLhKpOtoj/0T28YN3U/73xSCQA4Fx+h?=
 =?us-ascii?Q?GWdj/09rewmcjME166E6aBKrJWVwaV+x0gREx4FN2zpA8yqYkzX35yaABSbI?=
 =?us-ascii?Q?onmATTCXqMtSBbWdA/KkyETXlIn+glO8rOC489dupp+pPy49oMF1igWBsJ+C?=
 =?us-ascii?Q?UyUu79/gSecJCwgnRpawI7rFuoKe2n8WEJphJNJK7YkUZxaUfrS7HIXWpv5m?=
 =?us-ascii?Q?WC+vq7ahoLbtdj3JlEpSCnZSiHWwAncM5h/EkqOI3c1H2UmFjOu9xGlqFtoE?=
 =?us-ascii?Q?dXGBNKdanombfO6WlrQtlejV4jlKXQf6lmKtFoVWwd2gwrSyPouT6ZAH+N4s?=
 =?us-ascii?Q?iCgXps+xA8D0L4GyUI+/hI/gtBI/8LZZdhpVr9yfeR1rE7x6vmnpCpKgg3oR?=
 =?us-ascii?Q?hKrapujy1iahY3qGHkhe7lXvTN6c9XQZWNU8laraERLOmEVp1ger0c40363x?=
 =?us-ascii?Q?++kp4F/1s/XZlnssqndGzXX5lHBmaTdhTbVm2svyXbd6C8bhwkLxWBOCXdwO?=
 =?us-ascii?Q?pdfdO+Y4freTZbaQ4S/hU9huCAyalS6Si6b7dVdujT/VlYdsyh+TF3aqp5ve?=
 =?us-ascii?Q?eJz3OwFmvoO33JQkkBB9IjfKQugBnO1x5BKDoGEMwiTdsLyO/XO7ungQoatS?=
 =?us-ascii?Q?L8N7ZhS8v0IBHthWUrA4JfHtLO9NwBoeAgjb1F+Mi6oJL5e1y+UVwITLxJJg?=
 =?us-ascii?Q?WZPKX2QekCIyHM2JHYWqwSm62+YutrYHGj2WDjNqlj+NGi9gcZpGS8zj8DVZ?=
 =?us-ascii?Q?LOMMDElgeBMD7/I+UkfXPgEXMJSdepHHzl+QtEq2MJAzotm3XqepSYzVJyce?=
 =?us-ascii?Q?4sYtVvlIhXSaA0pBcuaKbrYUkbWDSac1Qhiy8rNrAVQzoEaA+q+FIECBq77C?=
 =?us-ascii?Q?m4XN7egl1wTtlc9HCCtP2gerzTM+K22HK9CsGj3Ti6AiBGU2XxiK8etdWcAo?=
 =?us-ascii?Q?aWaX58N4+cdFGkfhp0UOlc41DgW7Cs0RW9mn7ACEZwVMf5M1F/+UZsXQpT2g?=
 =?us-ascii?Q?WfkF5Ef4hbngGmh5Z7ONv7MOHI8Aed4l53ebgmDr10TE1aJsqr/b/L9O5YTD?=
 =?us-ascii?Q?EFmzvoMOpv5VrU7g/1An8dT0plA42kElITxk0rG54lq9DnS++oU97U8MkKOy?=
 =?us-ascii?Q?Cs1IAiqz5cuuWeeDy4flLdcMM1JMJp5vLEgQa1gB/6h99Rcpjn3RB2tYBIn1?=
 =?us-ascii?Q?fOxa+u07HK0/w/pLAwMlJmnay9FVURAIXcLcD9SDTEFlRDIR7xh/MtUlIvW3?=
 =?us-ascii?Q?Lq2ngnyrUo97AXi3iA5D8nIJnZOuHMCOQ4qdlPngs+ZhS2BcKRd4cSEmB55s?=
 =?us-ascii?Q?xZi9SUW6a4BR8A+0hDHCbokcNRgwFgtAfpEjrcw4hAUcsGx1yS/ESRIYh+QB?=
 =?us-ascii?Q?5Bd9cOKFXyk5YnxwgZfkMIwOvMsKEkQB5FCssEZE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bca0ca22-02f8-499a-9547-08dce3bdf387
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:13:35.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZUCNFv9qteIl8VV+ELylOHhDm/RxAfshNtwA1uQMBEFLr4EtJ99LavvSNOGIFkLV1ZWbcc+/R4pKnIHiSsarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8804
X-OriginatorOrg: intel.com

On Wed, Oct 02, 2024 at 09:01:50AM +0200, Javier Carrasco wrote:
> On 02/10/2024 05:21, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> > commit: c922c634bd926d84967275efbb7275b8645aa343 iio: accel: adxl367: Constify struct regmap_bus
> > date:   9 weeks ago
> > config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410021111.LknEX9ne-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from include/linux/sched.h:38,
> >                     from include/linux/percpu.h:12,
> >                     from arch/x86/include/asm/msr.h:15,
> >                     from arch/x86/include/asm/tsc.h:10,
> >                     from arch/x86/include/asm/timex.h:6,
> >                     from include/linux/timex.h:67,
> >                     from include/linux/time32.h:13,
> >                     from include/linux/time.h:60,
> >                     from include/linux/stat.h:19,
> >                     from include/linux/module.h:13,
> >                     from drivers/iio/accel/adxl367_spi.c:8:
> >    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
> >       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
> >          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/mm.h:2888:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
> >     2888 | #if USE_SPLIT_PTE_PTLOCKS
> >          |     ^~~~~~~~~~~~~~~~~~~~~
> >    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
> >       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
> >          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
> >       20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
> >          |                                  ^~~~~~~~~~~~~~~~~~~~~
> >    include/linux/mm.h:3010:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
> >     3010 | #if USE_SPLIT_PMD_PTLOCKS
> >          |     ^~~~~~~~~~~~~~~~~~~~~
> >    drivers/iio/accel/adxl367_spi.c:75:21: error: variable 'adxl367_spi_regmap_bus' has initializer but incomplete type
> >       75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
> >          |                     ^~~~~~~~~~
> >>> drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct regmap_bus' has no member named 'read'
> >       76 |         .read = adxl367_read,
> >          |          ^~~~
> >    drivers/iio/accel/adxl367_spi.c:76:17: warning: excess elements in struct initializer
> >       76 |         .read = adxl367_read,
> >          |                 ^~~~~~~~~~~~
> >    drivers/iio/accel/adxl367_spi.c:76:17: note: (near initialization for 'adxl367_spi_regmap_bus')
> >>> drivers/iio/accel/adxl367_spi.c:77:10: error: 'const struct regmap_bus' has no member named 'write'
> >       77 |         .write = adxl367_write,
> >          |          ^~~~~
> >    drivers/iio/accel/adxl367_spi.c:77:18: warning: excess elements in struct initializer
> >       77 |         .write = adxl367_write,
> >          |                  ^~~~~~~~~~~~~
> >    drivers/iio/accel/adxl367_spi.c:77:18: note: (near initialization for 'adxl367_spi_regmap_bus')
> >    drivers/iio/accel/adxl367_spi.c:80:21: error: variable 'adxl367_spi_regmap_config' has initializer but incomplete type
> >       80 | static const struct regmap_config adxl367_spi_regmap_config = {
> >          |                     ^~~~~~~~~~~~~
> >    drivers/iio/accel/adxl367_spi.c:81:10: error: 'const struct regmap_config' has no member named 'reg_bits'
> >       81 |         .reg_bits = 8,
> >          |          ^~~~~~~~
> >    drivers/iio/accel/adxl367_spi.c:81:21: warning: excess elements in struct initializer
> >       81 |         .reg_bits = 8,
> >          |                     ^
> >    drivers/iio/accel/adxl367_spi.c:81:21: note: (near initialization for 'adxl367_spi_regmap_config')
> >    drivers/iio/accel/adxl367_spi.c:82:10: error: 'const struct regmap_config' has no member named 'val_bits'
> >       82 |         .val_bits = 8,
> >          |          ^~~~~~~~
> >    drivers/iio/accel/adxl367_spi.c:82:21: warning: excess elements in struct initializer
> >       82 |         .val_bits = 8,
> >          |                     ^
> >    drivers/iio/accel/adxl367_spi.c:82:21: note: (near initialization for 'adxl367_spi_regmap_config')
> >    drivers/iio/accel/adxl367_spi.c: In function 'adxl367_spi_probe':
> >    drivers/iio/accel/adxl367_spi.c:132:18: error: implicit declaration of function 'devm_regmap_init' [-Werror=implicit-function-declaration]
> >      132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
> >          |                  ^~~~~~~~~~~~~~~~
> >    drivers/iio/accel/adxl367_spi.c:132:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >      132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
> >          |                ^
> >    drivers/iio/accel/adxl367_spi.c: At top level:
> >    drivers/iio/accel/adxl367_spi.c:75:32: error: storage size of 'adxl367_spi_regmap_bus' isn't known
> >       75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
> >          |                                ^~~~~~~~~~~~~~~~~~~~~~
> >    drivers/iio/accel/adxl367_spi.c:80:35: error: storage size of 'adxl367_spi_regmap_config' isn't known
> >       80 | static const struct regmap_config adxl367_spi_regmap_config = {
> >          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> > 
> > 
> > vim +76 drivers/iio/accel/adxl367_spi.c
> > 
> > cbab791c5e2a58 Cosmin Tanislav 2022-02-14  74  
> > c922c634bd926d Javier Carrasco 2024-07-03  75  static const struct regmap_bus adxl367_spi_regmap_bus = {
> > cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @76  	.read = adxl367_read,
> > cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @77  	.write = adxl367_write,
> > cbab791c5e2a58 Cosmin Tanislav 2022-02-14  78  };
> > cbab791c5e2a58 Cosmin Tanislav 2022-02-14  79  
> > 
> > :::::: The code at line 76 was first introduced by commit
> > :::::: cbab791c5e2a58c123d84bd9202c054e5449bc96 iio: accel: add ADXL367 driver
> > 
> > :::::: TO: Cosmin Tanislav <demonsingur@gmail.com>
> > :::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> 
> Strange. I followed the "how to reproduce" guide step by step, but it
> compiled just fine (gcc-12.3.0 instead of 12.2.0, though).

Sorry about false report, kindly ignore this. The bot side will look
into the detail to resolve the issue asap.

> 
> On the other hand, there has been a similar bug in hwmon[1] and it had
> nothing to do with making the struct const, which actually uncovered a
> missing select (in that case REGMAP_I2C).
> 
> In this particular case, 'select REGMAP_SPI' is present in the Kconfig
> entry for the driver, and the header is included in adxl367_spi.c. The
> only thing is that the driver uses devm_regmap_init() instead of
> devm_regmap_init_spi(), and other drivers that include REGMAP_SPI use
> that one. Does that make sense?
> 
> Best regards,
> Javier Carrasco
> 


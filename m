Return-Path: <linux-kernel+bounces-386395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E999B42EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C971C21D65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EC62022D3;
	Tue, 29 Oct 2024 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTM0mwmr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CEC7464
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186164; cv=fail; b=c6RznLp486Xjorl/F8MofZd3kO+7Tbxx9CfJhcfp197m58BH+MC5SltBbyP1PvxZ8fkPmnymGaSKSQseZNUHJayuUZf6jq3cGxh7gETFmNHf+vNuhYTAAEG8tki0OsVaK6bB3tqrXsBiEfakDpnxB9axaOul6LtVZerml7BlhWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186164; c=relaxed/simple;
	bh=Cpbw1b4M0PZTxS+fyZ+xSF+2JC5bkcGIWJ/DCt+16wQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iLq6sjr1TdBXONyqCDZ5oP+ZlrzqrBIyR6pSilJlf/JdWmwt/cFILy+iD8l04tM9iXRmUzTnAfxQHPihGHaCmw2q9utjY3jNt6mwxv6dSlYrHjwpuHmodVaoUVHVVQg9Ua+1E0vMoRs5qY45JPgJVHrOZ77wap/7wnKVeiyMotE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTM0mwmr; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730186162; x=1761722162;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cpbw1b4M0PZTxS+fyZ+xSF+2JC5bkcGIWJ/DCt+16wQ=;
  b=nTM0mwmr0AVqy8msUOldoK7ZVhIQvzad6JKJOCTxB8Hd8Z/M+d0akN9u
   TYhTUe2M2E6XOXbe+zv8rXO/SQCE4LbxQM0dBkEvZhdVMdkmnztN6mFQH
   Aw74ODao3BTNFVGKSGgwUTUE0xlRSNca175JC4K1sF795oQuK5XBAfG6W
   T87slNg5Wnh+hYYnXwFCTgqyDPD/ndCwUChO1adUpyOKYADoM8M1Pb49F
   NYqf7ytTH4Ybhkh9y7qZognrBkZ1RV5X+VuUS6DAUoWz+NPTv7yV7La7D
   yPUWt8cekej0S1TUv5cv9FkPkxm0zwotWG6teBiDRIz6DvjeUPQGOtaOb
   w==;
X-CSE-ConnectionGUID: JdAzI0OFSNC1d5DFVubVLg==
X-CSE-MsgGUID: AH5faLMHTjSsyoRH9PdByA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40907393"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40907393"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 00:16:02 -0700
X-CSE-ConnectionGUID: Q4VoUcWlQv2w/Cywa+6RKg==
X-CSE-MsgGUID: OK2WkEPtSeGkQJRxfm3KYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82193498"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 00:16:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 00:16:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 00:16:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 00:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFr6yx4yLY+5yYqTB1hPHom7S6HMS3Wutw7ZMyZT6+eH5Ct/PSc9WYUf2zCvlZ1YzXgStO2MyxEQY4/lPv/c+6THNTa82GsR75hGIu3w/H6KbV8L8ASxzprUsx5qT40fjIJxkjAbmdEbnXig8s7voHYA12d8xAJEVDoRRnBDMEDKf/e4fuDOqBeJseJ0RDgyuUeed9TpVV0KEtlHYzcRYfyMMtRiMcd15BKWTkT+Qy8fuooJ6CZEU2PoPEe7p+Eg35sgvDX82gzQZ5Qq0EJkmryl9pzuJEjheXdGqbASHCgDDeAvzMdoV0HsRjfm3u0QPZ/HXdbly+p0glEV6JOeFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffnY/4m1xLin8ocAG/7/eQJ3iwrAIT/XuDzkJ5XIquk=;
 b=lIZzcjJZwK70TQVm6/POaoU3CsiO+ZpMiDNKFPludvDvXfGnRWJhLC28vyG8CS48EoiRlsY7P9TtnkiZdE6tPb6b0KfBh+4Sj2JqLUWWJkEws1zGVRvhphkuHdPFo2G8afGMVqmvyVnMLt7uJEjTkqAq/e3GYCeVU1Jyh/ej0apABBq3ojP5wRXSbRqzVw/pOXtwz1mEV70D0dgFQueRlelAy689zgNwQSohqH+9ZZQJB1rPn8qZTGvPOIO9FkqzWXOfHMjtZDIt/GhI0qL11cazKCKCP+7uIp1iizA9k/6IcMz909O7Ah6+Ht893QiOiZx4ErpdAHhRhD5UiiWDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by MN0PR11MB6087.namprd11.prod.outlook.com (2603:10b6:208:3cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 07:15:57 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8093.021; Tue, 29 Oct 2024
 07:15:57 +0000
Date: Tue, 29 Oct 2024 15:15:47 +0800
From: Philip Li <philip.li@intel.com>
To: Matthew Sakai <msakai@redhat.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, <oe-kbuild@lists.linux.dev>,
	Mike Snitzer <snitzer@kernel.org>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn:
 inconsistent returns '&pool->lock'.
Message-ID: <ZyCLo51ZyjxX7eQK@rli9-mobl>
References: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
 <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
 <ZyBQa45RTWXiXJke@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZyBQa45RTWXiXJke@rli9-mobl>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|MN0PR11MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: c9380f3d-9b10-487e-26dc-08dcf7e9889c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9+6aNpYQkamry7pme4li91s+uxQbvqRFIODciH3nkYB58RGAjoBc6gyij/+p?=
 =?us-ascii?Q?Oeo39dX3L8ib81rGmm8jHkTiAvRbfBwJ/i96H9NHmYm+X5GZb8Rs0hqD0fqo?=
 =?us-ascii?Q?F/XzVLG+2/iEzRAIEF/+h1moXNbdi+ceB2fzTGrNNsrjqzc6CaKnc/fGb/ut?=
 =?us-ascii?Q?X13mqpBuyo7oS7eu5vfJEkazVV6kl90/BfThZPQSOG553wVqTGxS8dJp2+0j?=
 =?us-ascii?Q?5JtOal3b58bgPqIrzazrSkg+oD5MnDb2EqvL+U2VMxfztBTfPevKvhdGopLU?=
 =?us-ascii?Q?wfaF0fu7csb2SN0JXJtikQV6jtim5sTfafaMgG1khcLhS+fPGeFH8I7P2Jx2?=
 =?us-ascii?Q?hPk2/BDpgJcM6IpX343GpDd0t+aAejCQGvfbE4vsOqTILyZ6y4jl2rQvEdxa?=
 =?us-ascii?Q?CQ56ZBU5xFPrtR90tXcPoPe6zd1cKvhWcntt+boaXxrTTni0rzxDq9VYxTGE?=
 =?us-ascii?Q?HOSg8Se1Fwxsp/mLMBhlteSuDIDAWhx1nUrQxca0e0K78amzRID3qU+iA74+?=
 =?us-ascii?Q?3Tx0uF95yfb+n4K7QvR8cnjxuHMu/hQn3CuVZVIXVIYXkrBRFmf1FvfvMCz/?=
 =?us-ascii?Q?hgsNIVHcb0ZtElTc+5WkrFJbJh6nmKRo3OS+oWsf1J6kgVSyn0On/YHn9e3y?=
 =?us-ascii?Q?+DX1KwjQRmpRpaeo4ILjR+ldkhLMVTqMzOzsiTZYFaxaMr/OKmpI7vErhRBg?=
 =?us-ascii?Q?yqiA96vj55UyTQp6CE4s1a6MilCARI2j1DAF9HVBydn8bF8fAIT+R9fpDOga?=
 =?us-ascii?Q?LZOm12cOEYeR6xQ7ajoUcb5ns7XPApEpkRqToxxlVtnBi33GAc8lLX/8hr9l?=
 =?us-ascii?Q?Q+ObLjpa6JbyLEWaEwct/9f70RHC09acsJVkUFdBEnCP+JEafYcRHXn9m2f6?=
 =?us-ascii?Q?QEinfmuLl/zauxWPf28L53sj8JKWrXuXz6T9FQK1S2Jo+vzvD+I/x92xRaYn?=
 =?us-ascii?Q?oXj+NUXsf9nCU1RXeGk9bmPN22UvPo2lP4SMFqnPT6b+2pv24+PTOHkD7sPL?=
 =?us-ascii?Q?Xtp6PsdckCVhXyc3tlMOkoIP9ZqN+y7AY84mtVzd6ZaqNP6/ZFuJKm+gOw7W?=
 =?us-ascii?Q?CnIGfdcNOQ81wlyjoigpL9QhpCE6ItBoKU8CAOVkPrpSQl6HGdJGMjVQzyrS?=
 =?us-ascii?Q?MXID/id0tH9XUzuiVRm35TbdiC4BR+45aU1cELWwr/lXcrbrgD7tr247hNRX?=
 =?us-ascii?Q?ZPcJ+HOJgfhzJ193sIl0nlnI4gfSNRp8KKvA+KxOdl2gXKvRZCTcogJnFNXd?=
 =?us-ascii?Q?rdfTKlgD5lx2bIUP5F8c1aQA/N+LWYW1grgMMB8Q5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rJ9dmYGaMOgq0RdaPccgiCHV/a5FNARTLtb0VUKzqA+Q+KKEGTdnwFlc2t2m?=
 =?us-ascii?Q?qPsKAQLnir00APZkZz7uinFCMBxPnPf8+olSQxGdAx6LJZ/jS6v0ZDGe1RI9?=
 =?us-ascii?Q?qKA5NJyKbIzbnpWXRezgu6OlHXegTTYZmh+5q7Plx8Oc/B8CMWbAXAd3iEgg?=
 =?us-ascii?Q?FLJpRCr0WgDgvkCMnPwJ1xpyWi9GsKqdmjzpm9PhXa+LSSsLrAAIBFtAVXb9?=
 =?us-ascii?Q?0XslJdK3lGS2T7GmIOkUgDlszjdPYcW6Tin79evgUCbuliNkz8VNNEii2dvH?=
 =?us-ascii?Q?PtOEXamP9zicOQDIFyk3bm1lWRo+wKehzH0B2LGFYonumNHgZUsoPYT/vYn5?=
 =?us-ascii?Q?xpqiLiLuYLsoJgDEkSz1wcVe/xnmI9VrjnFQ4JBafX/KS/WoADEUHJ4V1m2A?=
 =?us-ascii?Q?cyU3iub1ZS1PCAFqHZmSml9CdJSY6YBilugau6msH4lNcog4rHO3K4HaxuY+?=
 =?us-ascii?Q?75P/yYjdbx8caOsUzrOFyUbWHSUnVIULXFZK5yI5HlcQ/JFBFkw4pjUvL6KL?=
 =?us-ascii?Q?bQrV+TZb4327tRshSCmXrd84GKA+4FzEmWkSfXdZrG4DhKfkXdQrDIJE//U3?=
 =?us-ascii?Q?2k4SguLyDVctTRsS99oAxdwnL5/YeXbbebDRYgO2RR2ZY/vCZPGkKdZV0NiU?=
 =?us-ascii?Q?UwvIT+acDlx4ocS7tQqZY3jIZFPnLeDKrk8Ge+g5kDg9VfnabEcaqaCSLvPh?=
 =?us-ascii?Q?ySKRsfjOYr00rNoT5mv/U5k8LJeEByp7T8lHxhtN+MYMP2UCOuugcfl709D/?=
 =?us-ascii?Q?j4xFbATBYdmhLJ2OOxmfw1ChLY7QgVBTeVUbb1aqtF0eOAEWp2gc5P0Ibl8c?=
 =?us-ascii?Q?1afxC38BC5Q/5m5k4jwJsEXiPxvjI62kYYRFZvxwAYrSMP/2FCLimCdqOkjh?=
 =?us-ascii?Q?1hEOb4DfNh3ERUrv606aoUL8p1s0kzXwJSnUBnkkF4UgUFcrN3PuDwxvGIZU?=
 =?us-ascii?Q?tbEncYPr38H8jxeJRqiC1WBsBHEcrYR+xDatxHbbWLNUpeUA5WPf/MhdrX98?=
 =?us-ascii?Q?WayPiqXg+A3ZG1YIobgZHr82CABCoXBZ+Rk+dUebOjf+LjeZrvTFn9abti6s?=
 =?us-ascii?Q?cqr2CEcyw0DkxuWDrYu/yfCNsyeZquwAjklxyao/NJRon5Vti9La4Vd2j1fo?=
 =?us-ascii?Q?elmkwyGcfWdHYED0VUroZmhTeGHNFwRlq5m0SMgrYq6K2VQRW/K5NHrD0F3V?=
 =?us-ascii?Q?6tuf/nWMulhhDPul1j1vKdQUFVCOVa8mmUE2pEOCYIC+xLoOy/K8/voJcnw9?=
 =?us-ascii?Q?ctzFKiYF1b4MwKJHXabU1IB4SFYJ8PICyHUYQH5teDZj11vb+po9xSRY4fwb?=
 =?us-ascii?Q?ZOgkVc7NKy6MnxirhyWfqOuQaj+E0hO5tva16ytxSoKD33nfp6Iraq68irnq?=
 =?us-ascii?Q?8uhZYLl8uFJ1cfD3JpxveE2v2FUGqH5Pxgg0Q84KAz8Ft2UCuKl1ywT7t1O6?=
 =?us-ascii?Q?FJkruQtkwAXip4//5t1v0TGym/o/Qh07qn/pCz18RSf+hAwJD1lXrnrD+gv3?=
 =?us-ascii?Q?ZqVBX2TqUUVpbT4rAdknpbXJr/FbTWEfStbghObOEbef9eyMquatsBMvcw8m?=
 =?us-ascii?Q?w+kKEQaT/P1JssuiRn55YxYZd1cZHlC318O5u4at?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9380f3d-9b10-487e-26dc-08dcf7e9889c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 07:15:57.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3HRe5nSSXOc90B/qurAGtfpyT2G8TDX+bfa89KrLhlsLcKekouNxCf+r5ivLc248Nvhdov6ajmFNJDQa/MX4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6087
X-OriginatorOrg: intel.com

On Tue, Oct 29, 2024 at 11:03:07AM +0800, Philip Li wrote:
> On Mon, Oct 28, 2024 at 07:00:40PM -0400, Matthew Sakai wrote:
> > This should be addressed upstream by commit
> > 872564c501b72ae0c84af51084753e8652e4a84b ("dm vdo data-vio: silence sparse
> > warnings about locking context imbalances")
> > 
> > That commit is from February. Would it be possible for these checks to use a
> > more up-to-date version of the code before warning us about things that have
> > already been addressed?
> 
> Sorry about this Matt, the bot side will check why this happens and fix
> the issue asap to avoid meaningless report.

Hi Matt and Dan, would you mind do a further check of this, per the re-test,
smatch warns as below on v6.12-rc3

	drivers/md/dm-vdo/data-vio.c:982 vdo_launch_bio() warn: inconsistent returns '&pool->lock'.
	  Locked on  : 972,977
	  Unlocked on: 982

The corresponding code of drivers/md/dm-vdo/data-vio.c is below

 942 static void wait_permit(struct limiter *limiter, struct bio *bio)
 943         __releases(&limiter->pool->lock)
 944 {
 945         DEFINE_WAIT(wait);
 946
 947         bio_list_add(&limiter->new_waiters, bio);
 948         prepare_to_wait_exclusive(&limiter->blocked_threads, &wait,
 949                                   TASK_UNINTERRUPTIBLE);
 950         spin_unlock(&limiter->pool->lock);
 951         io_schedule();
 952         finish_wait(&limiter->blocked_threads, &wait);
 953 }
 954
 955 /**
 956  * vdo_launch_bio() - Acquire a data_vio from the pool, assign the bio to it, and launch it.
 957  *
 958  * This will block if data_vios or discard permits are not available.
 959  */
 960 void vdo_launch_bio(struct data_vio_pool *pool, struct bio *bio)
 961 {
 962         struct data_vio *data_vio;
 963
 964         VDO_ASSERT_LOG_ONLY(!vdo_is_state_quiescent(&pool->state),
 965                             "data_vio_pool not quiescent on acquire");
 966
 967         bio->bi_private = (void *) jiffies;
 968         spin_lock(&pool->lock);
 969         if ((bio_op(bio) == REQ_OP_DISCARD) &&
 970             !acquire_permit(&pool->discard_limiter)) {
 971                 wait_permit(&pool->discard_limiter, bio);
 972                 return;
 973         }
 974
 975         if (!acquire_permit(&pool->limiter)) {
 976                 wait_permit(&pool->limiter, bio);
 977                 return;
 978         }
 979
 980         data_vio = get_available_data_vio(pool);
 981         spin_unlock(&pool->lock);
 982         launch_bio(pool->completion.vdo, data_vio, bio);
 983 }

Thanks

> 
> > 
> > Matt
> > 
> > On 10/21/24 3:19 AM, Dan Carpenter wrote:
> > > Hi Mike,
> > > 
> > > First bad commit (maybe != root cause):
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   3d5ad2d4eca337e80f38df77de89614aa5aaceb9
> > > commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
> > > config: x86_64-randconfig-161-20241019 (https://download.01.org/0day-ci/archive/20241019/202410191209.osrd8z9H-lkp@intel.com/config)
> > > compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > | Closes: https://lore.kernel.org/r/202410191209.osrd8z9H-lkp@intel.com/
> > > 
> > > smatch warnings:
> > > drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn: inconsistent returns '&pool->lock'.
> > > 
> > > vim +976 drivers/md/dm-vdo/data-vio.c
> > > 
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  958  void vdo_launch_bio(struct data_vio_pool *pool, struct bio *bio)
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  959  {
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  960  	struct data_vio *data_vio;
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  961
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  962  	ASSERT_LOG_ONLY(!vdo_is_state_quiescent(&pool->state),
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  963  			"data_vio_pool not quiescent on acquire");
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  964
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  965  	bio->bi_private = (void *) jiffies;
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  966  	spin_lock(&pool->lock);
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  967  	if ((bio_op(bio) == REQ_OP_DISCARD) &&
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  968  	    !acquire_permit(&pool->discard_limiter, bio))
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  969  		return;
> > >                                                          ^^^^^^
> > > 
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  970
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  971  	if (!acquire_permit(&pool->limiter, bio))
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  972  		return;
> > >                                                          ^^^^^^
> > > Still holding pool->lock on these paths.
> > > 
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  973
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  974  	data_vio = get_available_data_vio(pool);
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  975  	spin_unlock(&pool->lock);
> > > 79535a7881c0cb Matthew Sakai 2023-11-16 @976  	launch_bio(pool->completion.vdo, data_vio, bio);
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  977  }
> > > 79535a7881c0cb Matthew Sakai 2023-11-16  978
> > > 
> > 
> > 


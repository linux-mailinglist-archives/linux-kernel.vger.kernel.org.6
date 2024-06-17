Return-Path: <linux-kernel+bounces-217831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBC290B747
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D47B3D732
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AA515625D;
	Mon, 17 Jun 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzLucrLs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619815623D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637230; cv=fail; b=H75ET+7lC06gGQzsxJS0IR84Q/Hn1GGYAYpYiL84iOxJp5Zs8CCHfx6RrHD8yCMc5+pgdvvzxv5mqbXwHYip8+/kdYVBAodCHLs61o1RweGsc4ZFpD4x8t03sfVMheY9HeLSR38aOvQKPwIaaS2OYBxUxZefXHJN65S7GDRa+f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637230; c=relaxed/simple;
	bh=K9VPPKzwbeCmoaf8cpJe1BR7741tsKG2NGMzaj34/BU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZukxyVR0G9O0gVRN+ndhv8oGPkuUMObhkSz1kvqPVZDmDlODVQUKESu8BDuerV2TQYWG7nSuxFsXQOqF9qWqE1D34W4sUZnC0IiOF1G8anCRQ2rPMic1a07ElpExx7IoCaHCFSBIQ1m4E6AWPY2aFG8KO5X61hZTf/PVxAWF9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzLucrLs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718637229; x=1750173229;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=K9VPPKzwbeCmoaf8cpJe1BR7741tsKG2NGMzaj34/BU=;
  b=KzLucrLscerhs5YS5/LtFG9+5PciNeT/xzKx/NCxCoERQ6c+3FoDrVnM
   y1dXZdMPq3FEdC3AYIsazAxI1v3FL5v3fu1c56y9lH+URD97geOVH+mwf
   +gYwg6AhRLAz0uNHMIQz8x7zATep6lFhLwcx0KXbZDpgprhf683sHdbdZ
   2ro/f4Ocgmq4rTlaAQtejRPZG1oJDIEZ9dxssXqBHvFkBHRY7CH6VKcZ9
   CA5bgXP6dtkdjbaNQKEySYkdRGs77NAtsZYyyue0nXP2VxU/4F68LZRYk
   Lq7FTK/LCEscMdtZydd5oG+dM8P/4SYpONhUBmfd9vo1YQR1dEEbVVibM
   w==;
X-CSE-ConnectionGUID: ZFUui2dtSKexFb/4q79BiQ==
X-CSE-MsgGUID: AL+cfDTZQIK0hL+wuZz26A==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15433592"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15433592"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 08:13:48 -0700
X-CSE-ConnectionGUID: k+Ng2oBtSTuJgRHjD8H8tA==
X-CSE-MsgGUID: aWNKzJJkQu26C/xOf3IeQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41313545"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 08:13:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 08:13:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 08:13:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 08:13:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 08:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3pVVtJr+elpVu4LXl89eUQLN66ozKdUsgH0z3qxEzMV0M8uQkK1vJb+dX1kdYZJcvklzxhRpR7zqbflKNcu68taY+v1J89zIl7hj0vucfTufNtBUlYBDfBfvqPYwrc+g6ZBIJklCNufHat9qV1G/1GM7AdlXRa05vmuWoan8pFTVarXYb0rZPbEaOf+exyieNJZ9cMsHKinhup2d6vMC6hgVoUcJApCI8mGoql6qXUbXUyjMOrGE1zhm5KDYH4mAx0T0GvRl2dfdxmbGcTPoA4Ab9841TyJ7dZuv4XHvlJklXurcqoK7R9358LS20jLV+4EbUSpPWkWoH7Jq+X5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk24T+bqae/Y2q24afKI3euAkYwPB1fAK/qw0Bc0xis=;
 b=TSlVTTJKwqfoEqWV9nQoO3ctdO6f/btN8vi7N1hZu+K3zqb3o4ZGNGRAeykgrNJsjTpAaucRz03bKTmefk7tFKOGb+s0COJpqm4VIsNbDRoofheG5hVfWAEr7LOHSolXNkzSVBAvocv0dUj1X33t1tMchemBc8RZiM/LmQNMBow3P0nkUndC0GhOufuDy83CG1C9kSCfnGJBo4y+sPyh39FG+9XzJldcOrShdIQqAzpDr/Qs9gut0pA6FqewlBzmcmHeBzK4x07PnDTlVw1DBlOz6T2AYWmLWMSDl/bnYAhRxm8iT6bJZuPfUBSxpeRgvX0iquNq0dyYC5jOGbackQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:13:44 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 15:13:44 +0000
Date: Mon, 17 Jun 2024 10:13:41 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/2] drm/xe: Introduce PM guard classes
Message-ID: <cvtgixxwu2jkctez7pwgba4j7tbt527k7feglsonyfeicfnovq@vbskrox76acr>
References: <20240617140120.597-1-michal.wajdeczko@intel.com>
 <20240617140120.597-2-michal.wajdeczko@intel.com>
 <kczbmwizw3vd5sw4yj34sftjfgif5yyoomo4tmlbd7lq2xwy77@punlz6twxwvl>
 <b6181da9-abc4-4756-b476-81f34fe6f06e@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6181da9-abc4-4756-b476-81f34fe6f06e@intel.com>
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA1PR11MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 7062705f-0e14-461e-c6fe-08dc8ee01448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lh875lcOmIgzNT70BRzPLOOAALveh1lfOMpJOUdI2QTcJv5p2qJk2eqbx3?=
 =?iso-8859-1?Q?aM7UtIMxgXsO1HlrPz0xRWKWbWLrTmUDPYHYFvnfjFML3EgQctmUVW8jff?=
 =?iso-8859-1?Q?gQKSPS3PGC1WJnC8wprDuZrssTRK+rDTJ7wjSMWhY/g+bINPewQ8kaxwU8?=
 =?iso-8859-1?Q?7JzFVM13ieXhkhEINaqvz0qA3M/AGS7njEYxlni5fAytTIpoOTscTiByaO?=
 =?iso-8859-1?Q?dTkaFsgjh/ZDX18rgRIYxXk1vod58Z9Q8uwEB2CWtX5Iw5xqFM4HR11BVd?=
 =?iso-8859-1?Q?Tnjphq8nCEsGKG/4dmX6TM2c8cRL5mWJ6Xny6iHUTUVd8uNHNoCcBL81vJ?=
 =?iso-8859-1?Q?4xDvlpLvyJdoR52fEbKiinNyOilWDfKYjqrZFzg46AbV1ahSPkpOw1s0zO?=
 =?iso-8859-1?Q?IMpbXo/2penDywN/DAMn2PPjTiaMPnmk2cOTGuDEQ2fQv+AopSvBpB3dlW?=
 =?iso-8859-1?Q?/iAc1F/lKb9FVMQiqK51EWERJtrVgJXBxoQesrT9JwRmydkxAPHSpjrqoN?=
 =?iso-8859-1?Q?s8CVaJwyPsyhRDjr1ehoj5322oi3EVS9XL8HHQ4X9Dsyfsvv1dFP8WKYGC?=
 =?iso-8859-1?Q?KE7xcVvR/92FjEEDFpNz0cHhGoSsx81OAlJGGWZbsqgjgVoWoU1tWoI9uD?=
 =?iso-8859-1?Q?eXPf6h+pynl6TRM1dWVJ60wGkhP47XVPqnTw9qrEM4YL8c0jFh3rk5O6y3?=
 =?iso-8859-1?Q?7NQgT0OLodjw31tmkVP2eNzlFV8drYBK7nUPKd2USR5dyYwcmoVTsU2Qw4?=
 =?iso-8859-1?Q?Xs+4Cq0wHzqgpPlqwYe+Gh8VA+lSsslRHvicPJPfkkX0KtgXRHCNDsTjIt?=
 =?iso-8859-1?Q?to5O6KsfmiqDIB4OvYhrF80GiqkS/wDHKBbPB+S80r3+upQE8tMAYwDWjg?=
 =?iso-8859-1?Q?agKBHT7f9YXb1eJAlk/lW1/2NedCV8lzq6cyJzaxsq1VWFF1ieI6XUNmv5?=
 =?iso-8859-1?Q?oXfBm2JFyak9arD/Vt5VA2UQ95fR4NpZBI9J09vXE1Ry8WuZIrmi7Gdh9j?=
 =?iso-8859-1?Q?MoqqzwGEqFkpUv5uHFd9aSw+HukrMQKF+Zua0iz+N064DRORhqlFoXTUP7?=
 =?iso-8859-1?Q?HuCl740By3YMA2l9d/00+TUC+RnmJiaXwnFy0ev0VpMkhAGs9KG54dtJYF?=
 =?iso-8859-1?Q?VQe4n2YRn31XYdCFGCOUARFbB9E+f8yjjdTn4MwYVnvQSMHNmeTzBWxJPh?=
 =?iso-8859-1?Q?J4ivKhmhOu6g6wEwsOU+kt7GQfUhueMdwkO0WMkJi8EWyL+EdHumR5zpRJ?=
 =?iso-8859-1?Q?9g4VYB24eMsKfGfkiLQm7tj6D57wjtBEGtqXoorLg5Yuq1tYXpvYqk9eMq?=
 =?iso-8859-1?Q?eE3kmtB6QeN58j5lDuYTVQC2CZ90JYfS5a47bkSiWSQA5hdJqvRa+0XiGR?=
 =?iso-8859-1?Q?K9nXIEPU2W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BvQXBC4z3jweWPNkoXpE9PCIP1MJTCjo5AI0vMK09NdBVnX4pdtQ/IvMMI?=
 =?iso-8859-1?Q?C62GufYnMZ8Uz7AyZjFe7sCvTUJfaeV4Ov6jiouL+aYj8dcC6bNUiX3KNv?=
 =?iso-8859-1?Q?ZGtrAy1rzM2DvGHTbe/Klgc5aKRD1rPJSzF6oPUnlsgU/OEiaz8Z8vHWll?=
 =?iso-8859-1?Q?Sp8UyjCNXJejn1iKTfIdXe200fiw4fsvnR2YUTEldjp4Bpvkut00vd+v1w?=
 =?iso-8859-1?Q?MgSkjLZQUrk2Wl+hi6gWMdIPQt2dzPHO2nufnc1DFbCF3FZ9rrWl8xfryi?=
 =?iso-8859-1?Q?0GgeYrnYumnvtPjsCiiROaFj+oEEfImIUbRArkuZ7bwHdAtL9y3ZCC23z9?=
 =?iso-8859-1?Q?SSPqm/WbfyMd+hnytZfmyZsR224A/Z/jiKTEXhmHFELmXVwXX8xvNK1Y9q?=
 =?iso-8859-1?Q?RKgdCwZbh/+O347krf32sLCW4VaxEpgxKq99SyQi6x32YacfrSAJSNGbvw?=
 =?iso-8859-1?Q?eDnDD1L32YYi9DBPZucqaqmWuK6uFcS+PeZuwCGrTkGiO4fESu7SjoEksv?=
 =?iso-8859-1?Q?D2b+1OwMQkCXUGXlFDKBAKepDICi8QiWq5KauGW0dClyUAVZXk2IsWq2+G?=
 =?iso-8859-1?Q?QCKUASalYXgBGK1WQcdTrQ4Z4niYOPORkFMfr9nbLiEyKEcu3FXZD4iZaw?=
 =?iso-8859-1?Q?3rHocC5v2FBtrAc7sYGX7rY8jS1i8WdBgFSzghfJWHhzV/yoOz3Cb3BrqR?=
 =?iso-8859-1?Q?ibiVgSR9ywU5WPS2DPk/O++Tp7N2E+AWVAE/kQVq0GfVQ4vukAH9mni5iO?=
 =?iso-8859-1?Q?BfIvu4KIW1h6H+rQw8O2T+XNBZuvSJQ7k6Okjh8LEwAjp7SGLSaYoXgjEj?=
 =?iso-8859-1?Q?C9u5IobANtP55XQHryxBzkpBEaDl0hgAFlny5EqLVDrbcEm2q3rvlhUVw1?=
 =?iso-8859-1?Q?GyQOZd3t4ZeAJHKkoAluKAODs0xnSC8J30bix/GwEGcgSJ1f5886tVap/j?=
 =?iso-8859-1?Q?6LD44AFBFSmvyVOscIK2F0ZIQdkT5v2Rm0YTtfDYHKTCTeT2Y/6yb9y+E5?=
 =?iso-8859-1?Q?y5nmKWJErAZOJ2I1kbutE1sj0Pgi05hlyuqbCrCXoI7u+zMjKZVgIrR0zA?=
 =?iso-8859-1?Q?xjsWnLG0FAEgkKnd0+TrJG+xN9s8wI8AFFmI4o1GPnLZ8xAPMJ6jES4kXt?=
 =?iso-8859-1?Q?WaVkbcRt2FqXxr1Ba8nr9FMBbkDF8yR0zRPWkQWysXzYmHK4td0Y2zBk38?=
 =?iso-8859-1?Q?GIz9R1Yw2sPPPUhQKSGamCODAGN1GA9w+Ce4oHXLYWBTjbZuE/ZWck90tp?=
 =?iso-8859-1?Q?1eMcWRUUcWXzTnS0mG0fkbG+ALBTouuQzT4nbjToZaFx9jI/lZoUyc3+9V?=
 =?iso-8859-1?Q?c4c5HLRQnDHt9ECSP8JTL9g0vcZ8EljWShgwBP8zVT1rUBt9d5fn6hgi8x?=
 =?iso-8859-1?Q?5xzoMF161OjPrJrsdFM7otKEabHqOqUJUjMumMOYCDUr0+am1gNmMTkWRH?=
 =?iso-8859-1?Q?S94zpxqAr7VwzGMF1M06tgO+1ZNakWNrntuzmL1hgbfvqwMjSMbxVH/yPU?=
 =?iso-8859-1?Q?ZVl8wvfbkCbHJeOmXgOnV33Tk91OqS4t2EHiAm1GNCV2QSzuIG2Evz6UkH?=
 =?iso-8859-1?Q?wOeNtS8A6jhtANsUthq1R4SEF192w4vP+1hec0LNP1z/SRgeKkyRyfVGK1?=
 =?iso-8859-1?Q?QPYaAPVvKE7iKq8ZWdbo1CBQ0MUBoT9D3dCKx6us5qtLcKI86AvPBVLg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7062705f-0e14-461e-c6fe-08dc8ee01448
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:13:44.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuORkhdj70nJmEbnnL0fjy833ucSBcD98Z0ERIxulGLhkCxNAQ1CnDBVfK8LOvcTISF+rFViUKJAW7AVfFmWJ99f1Q9BXg8qdwjBK9jkN4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
X-OriginatorOrg: intel.com

On Mon, Jun 17, 2024 at 04:55:30PM GMT, Michal Wajdeczko wrote:
>
>
>On 17.06.2024 16:37, Lucas De Marchi wrote:
>> On Mon, Jun 17, 2024 at 04:01:19PM GMT, Michal Wajdeczko wrote:
>>> There is support for 'classes' with constructor and destructor
>>> semantics that can be used for scope-based resource management,
>>> like our device power management.
>>>
>>> Use provided macros from linux/cleanup.h to generate required
>>> code definitions.
>>>
>>> This should allow us to use:
>>>
>>>     scoped_guard(xe_pm, xe)
>>>         foo();
>>> or
>>>     CLASS(xe_pm, var)(xe);
>>>
>>> without any concern of leaking the pm reference.
>>>
>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> ---
>>> drivers/gpu/drm/xe/xe_pm.h | 5 +++++
>>> 1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
>>> index 104a21ae6dfd..26293a3b18af 100644
>>> --- a/drivers/gpu/drm/xe/xe_pm.h
>>> +++ b/drivers/gpu/drm/xe/xe_pm.h
>>> @@ -6,6 +6,7 @@
>>> #ifndef _XE_PM_H_
>>> #define _XE_PM_H_
>>>
>>> +#include <linux/cleanup.h>
>>
>> Cool, I didn't know we had  helpers in the kernel for attribute cleanup
>> and friends.
>>
>>> #include <linux/pm_runtime.h>
>>>
>>> #define DEFAULT_VRAM_THRESHOLD 300 /* in MB */
>>> @@ -33,4 +34,8 @@ int xe_pm_set_vram_threshold(struct xe_device *xe,
>>> u32 threshold);
>>> void xe_pm_d3cold_allowed_toggle(struct xe_device *xe);
>>> struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
>>>
>>> +DEFINE_GUARD(xe_pm, struct xe_device *, xe_pm_runtime_get(_T),
>>> xe_pm_runtime_put(_T))
>>
>> per linux/cleanup.h doc it seems DEFINE_GUARD() was intended
>> specifically for locks though:
>>
>>  * DEFINE_GUARD(name, type, lock, unlock):
>>  *      trivial wrapper around DEFINE_CLASS() above specifically
>>  *      for locks.
>>
>> we probably shouldn't abuse it or get the doc changed
>
>probably the latter as this is exactly what we want
>
>besides, maybe we can argue that what we do is actually 'locking' since
>this is a required step, like obtaining mutex, before we start to use
>the device

the problem is that if then later there's something really specific to
locks like plugging lockdep into these. Then our abuse of these
interfaces would probably make people angry. Let's Cc maintainers and
get their opinion. Cc'ing lkml and maintainers.

thanks
Lucas De Marchi

>
>>
>> Lucas De Marchi
>>
>>> +DEFINE_GUARD_COND(xe_pm, _if_active, xe_pm_runtime_get_if_active(_T))
>>> +DEFINE_GUARD_COND(xe_pm, _if_in_use, xe_pm_runtime_get_if_in_use(_T))
>>> +
>>> #endif
>>> -- 
>>> 2.43.0
>>>


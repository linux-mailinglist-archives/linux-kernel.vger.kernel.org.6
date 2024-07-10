Return-Path: <linux-kernel+bounces-246857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9BD92C80E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC58282E59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9CD6FBF;
	Wed, 10 Jul 2024 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAWhPJ4/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD58494
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576075; cv=fail; b=qGNZSMkP2BVmicjrPkwqnqK3KCXLXtFPosQWYKmGOpBhX+wSSD1HkEMWV/fB0Df251+vGiT4ADu9E9FP6hIAcltdJMk9GCsXOdm/iAQnNSTl7i2xelcjSXEyX2S9BzwaBf8xLs18kb+VRNMLQBQ7Ut7hTiRvW+XyXSiCus2l1Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576075; c=relaxed/simple;
	bh=TH8ekRL8065Uglg0Ch0RpOTwp7bIILYJUUtMxA0W0ec=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cxt6KHJY/q5YcrplCZ1OCLeMcNM4NnQoPMDRrlVsjzO9qf+AojOQ51idwRcx/AZTDzWznRjlb0S/ZRfs31McK2jwjDuW5oPBMEfKutGdvEh+QPJ2o+tn0ZIoIQaC0LjqiucEC2QvjTiiZTwZ4Y/myHRfeC0iMQMke52Yb3e5RgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAWhPJ4/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720576074; x=1752112074;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TH8ekRL8065Uglg0Ch0RpOTwp7bIILYJUUtMxA0W0ec=;
  b=eAWhPJ4/C5zZCQ+nsbpY6AxGqccl260YStn6UNVjtDCSEaNf5allGw3G
   4anervYJ8iHFuSHSz6gbvo5WCNOPy4gMHujAr2zYiNjwGRgmzhyepq9w2
   WePnTltiysU9aByxKczjkNM6bv4UhjchLzTn85Ao1UjpxmRTl18b5Gff5
   5WLc2UMjkduUVP3sKxt7D0zyDeU+ZqKo7j50yA4UMN8wUoaQ+fFo/PybE
   lOvUL8zJ3Z175Av12Hqaq4KaDqr1pz9lCoC6TyhQXk0vupTXC7Cq2QmjL
   W7Bd/9Hv+HLMFNxyw7N3rDEt90tCKHsHYpJqTtdoS3U5nDGv45ugubmDq
   w==;
X-CSE-ConnectionGUID: /teBL/mURM6I5xau3u7q+Q==
X-CSE-MsgGUID: ZQXhkH+FSbKDgvXoCKgzpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17820957"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="17820957"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 18:47:53 -0700
X-CSE-ConnectionGUID: 7BQOaCkVTQ+zQnyNrxqZZA==
X-CSE-MsgGUID: BqNKpHTHQj29MYA1fq5cJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="48129054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 18:47:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 18:47:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 18:47:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 18:47:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 18:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qub6eUgUZgJacwjPGI/MUynI1nnitaEvD744EI3uMpp3aJQABDvUV9cpXQvq8yG+KszDxRWO9uvovg5J3pUieYVRB0Jsy+wUXSN90FfgRNBzcFw2lb4gnU++Ui1zlsh86Q27BPk1Ymu+ks6Dki+XOa6BIeSjyGlJdZV6UkmeU2lIk5tzC2VoKB9VUm66bT2/UJuI+9BPx12nzjdLNCf9LiawBUfE+V5m+MCJpXcwiaOwlky908ON/MeCqqMCAXlxefy2W6ZXUbaWf8hQVlr3i9ZXTBspOnq8boyeJZwKaEf7Ij8g9p5FXFovMedjNYz5ZXxt7lGxTWFrQmj8tBc4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IzZCeKUqtyPlCLFOnwSKiIYdtM3tLiUYmv4OZWFh0c=;
 b=BTTgYrq47CbPeWqdgJ3Zu7k307dh2jJhKIFLp+aFYA/xqTrG4GIL5CgjuoPbb7k3sndO+quFQ5t0jkOlKjvo58gdX84iUFu8uHvsZ1uAgbzieltZGc51XR5CNftZXr/BBIezjg3UDK3l77ImIrKiiaVCQFBv7aeCA3Nw7DDfhU4pR7yXVWqPAbu+PNwFLAbzfM6o+SFE6WsSBWYUTAFkbevhS9GLs4/4In28dy9ZbjtEzCUuOgz6enJ7dKPQfnqF5bHyxlarVL5MH3vjVOTDuPnOejD+ZYspgh7ohBx7R/6PTx5u/EY2Y+NJzQ14dxfuiVH5Ipx1bvhE/RtRjs5ATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 01:47:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 01:47:46 +0000
Date: Wed, 10 Jul 2024 09:47:36 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Nikunj A Dadhania <nikunj@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, <oliver.sang@intel.com>
Subject: Re: [tip:x86/sev] [x86/sev]  06685975c2:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <Zo3oOK6RH2OJO3rC@xsang-OptiPlex-9020>
References: <202407091342.46d7dbb-oliver.sang@intel.com>
 <20240709090323.GAZoz822G64Mr9M9lV@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240709090323.GAZoz822G64Mr9M9lV@fat_crate.local>
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1f1bf4-4474-4d21-3260-08dca0824c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XBAzoeDcPV0CX6yM2/g10q5yehE7wLQ2xo9MzvhizuGXqI5w/5Qk7jIX7Hi+?=
 =?us-ascii?Q?CkrBMcAWmjKPhkblaXFM7/g5GokX3pfk4HUPF2sNfKX/AaHeGk+OUWFYU4sA?=
 =?us-ascii?Q?xiDcU/noK+zzIHDW/e+tFOijozYwW+d62UcijHLjVghAtJpQBMR9L7fBOkZT?=
 =?us-ascii?Q?3XNywNIq5Aff5uUqQ1neuFFYH11riBgF5vNy5/6gZ0cNrx1VBClfYuDTzLzy?=
 =?us-ascii?Q?0oYev+ztPekdPrRloXRq/v/4DBr+OwO9I/n5wor8UNniO2VfhCK/oecZxNFm?=
 =?us-ascii?Q?xXv0WZwmE9HNmu+BWKW06HbRygoXoKP9OCrC1E1fpchnmOqVQntgjBG/t5Ug?=
 =?us-ascii?Q?0DseXEX6nW4SwYDLbyl7Kl3BOLZTB7GfsyBcPzVzjAyRf50uEIyiPoQnOOjK?=
 =?us-ascii?Q?xr7Ma1hRvcK4DN3ATAJ+GwCk6LLEzUtmkhIlAJoECtXUZzx12nS0Jic5AVFx?=
 =?us-ascii?Q?+MRpvzUOKbKf1wNGAU6dRrDWUwsOr9YvTfJwWcfB39NChDTZzt0Fk3klRctN?=
 =?us-ascii?Q?pDvdcziBLJd7NHpSXwIAJJHNNxGO0Kt7L+Nq+sRhhtNW+G9pCFePtEa49ZQ8?=
 =?us-ascii?Q?3w/3dOyQrWIn/2C6q5t8B68+exJ6gwUYboC01IgPjz48J2JdWw/SV+MKAter?=
 =?us-ascii?Q?5RoeG+qJtqGwjVt5oAIDygAp/EgL7BCooKhdhBV9M3kARCQ7FCe7qVDa0eOz?=
 =?us-ascii?Q?jNhAlWQ2FV/1kLvWYzpzG2/wvuqz3wUJNAUvGTufQl8KlA3DrD56NGmAPdjO?=
 =?us-ascii?Q?QGdkM3smydFpwYJdegPUSes9FUBMYtZgx5D4G/23XkmhK9p3orSpmTOe+CQe?=
 =?us-ascii?Q?T1aDi7nq35VrM70gXGNfY53RBijCMBVUHK5xLJpNGHsfKpdc9qgbiKWBNi5/?=
 =?us-ascii?Q?Z8dq3Jba+f5LWUtRxRpUrRPsDqJ8O+wbr9/u/GlxdMEcAK9QmTB9Yg78dXfl?=
 =?us-ascii?Q?MMMoTxSPta6OEz+Y8USq6Hc42aqTmqttq0HF63UwkeC35Nrmdj92t9VF1Xqj?=
 =?us-ascii?Q?XV+Sj/hO9TsVK2/assqiAUvwHb80LcFdUs9gnFB0Ec6RZeUTd8TOEXzl2ls9?=
 =?us-ascii?Q?Nnv4cMh7oO3XaYPbQ+zgolsStkqoK75PgpnMyS1TddLO6teBuChuk/gNMCvg?=
 =?us-ascii?Q?+ObFtRq+AJ3qbLgBjguGWyCar5Lbk6IPSUZP7t9Wwdm1B/67WX15JTCLJSrE?=
 =?us-ascii?Q?cVvxamg6B8AVpAP2XLto0DoYG7Dqrp+Wvp4+/uSRLNoaJ9ShkPHz9Eyv9OGp?=
 =?us-ascii?Q?7BY6Pb0DZ+F4I+inf8Dka7fVLD6BGNdLtFxaxblPqbomPgZp9HGzqcp69QUd?=
 =?us-ascii?Q?u0Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5x7qLs678n7NvfiAaShP7PKJ+/4BckBB7zXp71tCHnqIzgsD20I6/oZF4blu?=
 =?us-ascii?Q?N9LLaTCE2O0grAjjcaDWWJ/YpcRqyGg8VVus36hmjLMFNB/T1zFw/2Vu8Gbl?=
 =?us-ascii?Q?3pH1fODhfXVBrIoJY70W9/jXKCOlcVHKVLRVoesiIxNjiv8M8P3Vj3wOwlI1?=
 =?us-ascii?Q?hJ1uW+YpsMhs4pujGKjLE24UkantNWbaB04D5+fcdR5SsH9FpTmYquXgtG8s?=
 =?us-ascii?Q?8Ba4ereQ3UTdTBEHoEu+7GjOwvd64nfjUYHMQEGJ3ijzeVEZuVQ+LzLo4hwO?=
 =?us-ascii?Q?Hoog+fSuC5sZQ5DC53SkvFgvqj0hEw8tjWjRCxYe6LRpllx9mPT0czNQV9FL?=
 =?us-ascii?Q?Y3D25RgnDLp1t1NcvswA3v5jfNcRmjXBOMwMS8M9TW8oSC7/niPCFRlS+QWp?=
 =?us-ascii?Q?okF2qRNMO6IOeBMm09Nsk0Q+npm+yplB1XVu3mm2vyZEld2maA7s1WKKU8gp?=
 =?us-ascii?Q?+jffXyGfyTtjjQkafoVmTpGIjoTBpgns01LjrocQkR39eiLhc64+iIZn6VTS?=
 =?us-ascii?Q?kwQ/zJOeYQocgoruJhvb1eSLrU5/Z8Cou+QabnqaIHNrIpJF+kPAvwMVcYRs?=
 =?us-ascii?Q?LwqdtO3PNf5cL3t4nhoY/ISQOmjBO9Lnl3Hq8+9l6R+GBrhnmAXhLpf0e24C?=
 =?us-ascii?Q?3e9X6HlxRaZ0O/vBLLZuPxBt0NuDirtdDO3UzXcsxt4qY1yfmtLVncVN7oeF?=
 =?us-ascii?Q?Wb5sj42LjTmxdoZRU8PuaTKP0/hp94g3Elff+Q62keZETPEiS3yolhkWYKKq?=
 =?us-ascii?Q?bS0fMxJoUDMKoaVFQSoct84ur0fgxfxP6tkYNswQ1UQWqnq4K7BDCueOZz7H?=
 =?us-ascii?Q?1TNo8PemlLP8P4632HBDdLaX2ssf7JSTssv86iIrLZDchhytlVz7uUKubZnX?=
 =?us-ascii?Q?WrJJzCiqqYSHeAQL92sp8f0scKhACQ62DYYtSi6+jvlDTUl5xQv3oUTt+RcA?=
 =?us-ascii?Q?B/uQ9D4jgoAJT77d96kdPVQvooqjpaphC+QIdFbusBdRAP8aVhe0f1leF1D2?=
 =?us-ascii?Q?KNNz8k7okxWSQIyd4Zi5n/pbYx2qHLoh5+zcddNRU97WknxkGSi2CBovQ6no?=
 =?us-ascii?Q?U3GnCqgjfi/Ztq38nRHvcGkBjIIX0L0XFqDYb7dZc+z6adwXynTt8P6y0okg?=
 =?us-ascii?Q?dWBep75bUggP9ELnWumYgRCQV8+OMSgDCoGRBKFNJMCc8DF6Oi7Jjko3u2O3?=
 =?us-ascii?Q?F/+iRl2IhoDOiWLK586fTs0Y6mp1bGgZc4W1QdNt2Wx/zSjta1rzVMoAtLU3?=
 =?us-ascii?Q?ALAKi8eEfZzhWHpyVxL2jP65Vb8WwGm0Sd/uphvjsZHhrgGmO8Ry6JpNzubh?=
 =?us-ascii?Q?KLnyKSPz8v0/V5f/CCC1OWKFtstBm0NaDTDVqGhEO3fmetedOuL0vmKCi93V?=
 =?us-ascii?Q?wEsjB+ZlZWcRxac+VPQBb51X0S2Rmi3omtGFdwkm/VlmSIStO62spKYgXjV5?=
 =?us-ascii?Q?7zT0i/uUuSH8vGfOmfvQsn0hi2MgvobY4Q8JYVWD+DBqfUOBi2e89VTCFu35?=
 =?us-ascii?Q?+Nf5tqDH3puBZq7BqDOabG4N6s/lzM6pXKhCjeD8F9/ufpTRwDwXPtEA41vv?=
 =?us-ascii?Q?2JLUXj7ROljJEYMB7I6awqkrfPCe5sO1K9+1pd4rHNHbx1J5tlN9y9T+8lZM?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1f1bf4-4474-4d21-3260-08dca0824c53
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 01:47:46.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/N6YVbQVBXsDMFswrJk6KQnQYV5cTAioSOYT3bN+nKs0SR9gaibJ2w+voLCCLiCggt3zHoaXdsrgzkXc8zlkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
X-OriginatorOrg: intel.com

hi, Boris,

On Tue, Jul 09, 2024 at 11:03:23AM +0200, Borislav Petkov wrote:
> On Tue, Jul 09, 2024 at 02:43:29PM +0800, kernel test robot wrote:
> > kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)" on:
> > 
> > commit: 06685975c2090e180851a0ff175c140188b6b54a ("x86/sev: Move SEV compilation units")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/sev
> 
> Does it go away when you try two patches after it:
> 
> a7e7185ccd2a ("x86/sev: Move the instrumentation exclusion bits too")
> 
> ?

no. when this bisect done, we tested the branch tip 8434cf006ceae,
the issue is still persistent.


* 8434cf006ceae (tip/x86/sev) Documentation/ABI/configfs-tsm: Fix an unexpected indentation silly
* a7e7185ccd2ac x86/sev: Move the instrumentation exclusion bits too
* 6a7d32f3a205f x86/sev: Do RMP memory coverage check after max_pfn has been set
* 06685975c2090 x86/sev: Move SEV compilation units
* 3991b04d4870f virt: sev-guest: Mark driver struct with __refdata to prevent section mismatch


> 
> I might have to merge the two if so.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-172882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6348BF81F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83456285590
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013F3FBAF;
	Wed,  8 May 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnodLaJy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0D3D96D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155718; cv=fail; b=rmvzDfmtbLeaJpqB5A3ASMJ1A7/xKgaEyERtkhoF/WJ1LR/iFGDRdhfri/YIZmrTLBFIavvnJkE8J3dFGjLKftMBY27iR3V98mssp4AJrbLZsLP/6wnhB1iiDUAWju0ngXjkvPYYLtyrGE2UATfYHWoXrROaRpH5aL/g7dO/634=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155718; c=relaxed/simple;
	bh=Q14USvhaSpKG9nByaKpDt1MqKyswciz4qcgqjk6JGLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iEk3uoFpDPlt5m3FfXNStR7m3UQpuUok+Ki4bizxnUjKbkiU9e331xpue5oIoB6qshzClACr8vq2872ZUFN/y3TD0MPU0qPw3kRakql+sYKORa00edByGgHIMl1C7ncL94XhdCbwW0dOMUikyQCopcN5UIHtkl6+dQvCDCFHvp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnodLaJy; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715155717; x=1746691717;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q14USvhaSpKG9nByaKpDt1MqKyswciz4qcgqjk6JGLA=;
  b=SnodLaJydeWBr1CprVZb6pTJaObJ5ANBaqQfwmwCeOsH4/ZDcNrIrSlD
   tfuJ4fNm6Qj07bAGg0w9D63r3aO1icUxnJsHKziExElLhT/wX8/J7mu0z
   XQWJqvH8IIC83kseg5a+r64md0JnidnK+UginhPc/dFZA+jBfatTePA+A
   XtU/5I/JHFq63oqcAEuKmlx6o98NYCEXXRIWMjDi6RZjViNeXKUq0rKFn
   WXiF4Yl4c8gGXkgtg6xXKEV49a2JB/zxSfq6VymrRT86kBOAodyuyPgSY
   HlT72Xw08XYuxCmQkUwlWRUi2ctAM67ieIklJu89Q5VRMRB1LoJMqOEwm
   w==;
X-CSE-ConnectionGUID: uZgukERZTUaXFn1dQF3+VQ==
X-CSE-MsgGUID: DnGSGZDQQl2sSSH8lq1hJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="28473821"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28473821"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:08:36 -0700
X-CSE-ConnectionGUID: oM+2jbGCTuekV3WSD+g3xA==
X-CSE-MsgGUID: uQ0DLjHDQgy1DQqqOEdpPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="59661241"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 01:08:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 01:08:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 01:08:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 01:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSeYLLD9VLmr83Yt54aGTMuZKlusoCJ5zZtJcgFYcH9hcYET/GrejRH10n24IjCS9iATRcPt/iMu+1XAKyA0MSS8MvhAWWnY9+LF4xHRZIMGR+DsKQcx0uVtKbWM5lZBA5zHYMouEh49vvaZDp98iD9i5nm7JbcySUkf1GYu5rUiegBgWvvHXVtZKI4/5Mdl2Mm2+pr2ehSHk/jYDbu7B/W+V+pwitnkyIBn19yFNLXp5Bm7vkqrLI0zYSsV6s2UeZEwpiVtnSOQUbnbWExc0RIF45OuA70kBAqdlk6YO0xMNBfCNs4wYyv/w+AOHtakTGtuFxNQi55r0AAmahjlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEh/ASiwVlormKnoE1BWiJpoS4a0HbuywwdaINoi0TA=;
 b=bvhlPsfte88lo8Wm8W4+aYGURDZilq4/lcWtlmbqrjz5yXgBJbYh4wdeFK7GWRo4fq4wxlr9/P7BQ3iAVKIoazdclf/zFq7mBcgyCfh1w0YXmv6iBwbDdGZ7JHDYIVxOPUQA69eYYWyboDCQLGt5f+uODd97420+hU9R9I+aJ235m+sECJB4x0rDTj1uLc6o/uZeIV3JnaXQysbwJ6pPAZSddsJAfnz3ojXHkfQ7Akf/6HeHNYQmdMuZktKDEQKNzSiSAA8wH2l7DTDPVUl8T8M/8o7Er2JA2nwy0rdWDPxc5xa3q7qmyu5uyUnxXM7j1ni5q0K9Ej1+1VwAzEaIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7382.namprd11.prod.outlook.com (2603:10b6:8:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 08:08:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 08:08:28 +0000
Date: Wed, 8 May 2024 16:08:18 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Sean Christopherson <seanjc@google.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, "Ingo
 Molnar" <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>,
	<fengwei.yin@intel.com>, <yujie.liu@intel.com>, <oliver.sang@intel.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <Zjsy8v0pZHPMkjPY@xsang-OptiPlex-9020>
References: <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
 <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
 <Zjj3Lrv2NNHLEzzk@google.com>
 <20240506155759.GOZjj-B_Qrz4DCXwmb@fat_crate.local>
 <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020>
 <20240507114814.GBZjoU_u5kYBhLips3@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240507114814.GBZjoU_u5kYBhLips3@fat_crate.local>
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c41509a-ff29-4dcf-71d2-08dc6f360ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y8wrAACuRNfpQDn4unQELfMrNlocylgtyzLOpj5TFZCCvqpbzLB4APR1zmLB?=
 =?us-ascii?Q?rW+9Vwi5Y4T/k7TQoirJJG8yBaGE1WPDPo5A/qhUBCcH5gvHmrilqR25m4cI?=
 =?us-ascii?Q?7xTcTmjqr353wxU9NNsMPnA4nWN9YktiNbd70zwUI08RXtGpnXF+1xnno01M?=
 =?us-ascii?Q?BRir6rcowDMV1VRt0+Wk61xv3faPv+iqeuYEB5030pcPJt1eYIUe3x+DyXmT?=
 =?us-ascii?Q?VHl6UR64BWesO9M03M1oD8l7Q4C2WwJuvydSH32usPeTpR4kaYF3KuoHfRZI?=
 =?us-ascii?Q?h/7YjqrehMz5gTRrwQ9ZJE+IJ78+yWqj7RX0i/X7h4Jcn3Oof6T3/Wa8wvyc?=
 =?us-ascii?Q?li3zrc6DkoG7XXK+B9hgMCe4oRhqU5N7Val7bfjBPAuUIq0h6JRS0fzzueGr?=
 =?us-ascii?Q?3x0oMuva9yOKxsfPjAHr7c089kZHK+aL8X43aNv6fr67HmkuUaGe4uOa6JZt?=
 =?us-ascii?Q?bPqlo+++V8mb4B/Aeb+I0oeykHAfIzq7m/qK/0MLnucHUh6GRHM7XaYN3M15?=
 =?us-ascii?Q?DwNg7/NoerWkavsFM750qGWaf0k44QCROr1iDkc5C57uDLzwv+ZsZhNvQ3YA?=
 =?us-ascii?Q?HtOTNJZUHa7zuGg2Bgq+hgpHdkNSc33eOZPDpATGSTa/N8qSxMzvN9LlK2rn?=
 =?us-ascii?Q?2EFt/9LeWhuveWl19fTrdM9mNgFOOLvTSiPg1Zq13pSde27Mo7xI7JwV9P3t?=
 =?us-ascii?Q?SdsR0ML51K8W2X69NJhFnKJZhL516V4iNxuuoyktOlUdgqhH3DPBS4oJkGRr?=
 =?us-ascii?Q?ljARpbzOuZ3bcPFONtxMGywjF7cBHLUfWlrVbNbeCx06BsNvTxLW27MZ2Fj9?=
 =?us-ascii?Q?Smi1KU55U1myfJmfiuIarIdoo0DoHcCrjHWy3ZS6i1SX6OHunlN2XohWgKts?=
 =?us-ascii?Q?Ov6wHeJnZBCRxvVEY+wl39DgrOepAPNuqzwvy/+dSc/6Ut+gwU7KCDw1faTl?=
 =?us-ascii?Q?uiNW0oAJudoJXAs+lAUW9KFOqrXv8JUr3AfPBAzaXi+8oBd3b6PGHtqmlov0?=
 =?us-ascii?Q?0ZhjLEjoAdCF1jLsZuOY9ZkiTv0lc1uVCV9EAd6BKS+jM1piXYgu1mbAQpD7?=
 =?us-ascii?Q?FDc8JrJ9tXHnMaZ0k2tvpbAXi0rNRsAtXkuO+ef3cxq2p+x6af/lgKNnnOIM?=
 =?us-ascii?Q?YBA1uCvMG91QQZn8HihyOakrck+lH+jW2lSkmuaI/5+4grhz5wvcsPtnhtNG?=
 =?us-ascii?Q?vExsuTMvhuHnH+P6pcQr3iwRNl2Sh2dKmvYvjYvJ+ZsIWoYAWtaphHmYObc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7l4VqsarEaUrtwPIu5JYBsoab/F/PT3xnzalkvlV94Fm/bixyc6Tcg8lD3C?=
 =?us-ascii?Q?2UyWMN7961YjwVUTpQeihuq3Z4ueS4NEkkkIsKGgxM9M3pVcSgyRW2OjmytQ?=
 =?us-ascii?Q?0v/cEFizPSHNz73LLN4Tz0Gqf5dAhpLHNuxJiZs5eb6Wfo+lcxrNmn7o2TKB?=
 =?us-ascii?Q?YTLM0vTfyTgTAADVH+gI2s/LKD5CGRbukyJ+bFDyoIe3xNz52sIWcs+qhhJZ?=
 =?us-ascii?Q?cMsTa9K39dUMdA8kkVXeo/WH74MYJPTWS4mgypPLSEeHGzZ2QcOSIMzbOoE3?=
 =?us-ascii?Q?fJr9aa8XMrd4PTx08FEZLYqXkEPHhrT97FCzkpZiIFQPYWJ01llEk0+ZBozh?=
 =?us-ascii?Q?jfdAtmXinNIyZUi7iFy4A638YrKVBz7RsycVGZc42Lt0daLQzYWqMuHKdFdS?=
 =?us-ascii?Q?4w61Fy/lnflqZzs3g9jfhCdZ23sdZGDomXwddrcSUSS002B2KKyaMYDD1JJA?=
 =?us-ascii?Q?fVpKGxhqKEy0oEuqOgHRrdtmYsCkyboO+SFeK6wDhFyPvcf9KmYvljF+iWer?=
 =?us-ascii?Q?2GLNRdzPZLUVFz8B/WfLx4ns3L90eXxQTR/x6tDw6w46F5APCZIswJjmlyTd?=
 =?us-ascii?Q?ZPyr/w4yZDWH3tmkbfp+zQa0AYFe/spB6BH4Iahqow+WP8IDV+87h2Po4Mkw?=
 =?us-ascii?Q?k1ZLyGx9t548fWe8lsSap3a+mgI/m8Z+jbiiVSjFigyK4C8HVcQp90djvTuB?=
 =?us-ascii?Q?HpElo7KGkq5uNzPmL1rdNjMcxpC+s1wGWjPvswTaIUK4V8yrNM15lEedBQPD?=
 =?us-ascii?Q?MXGQ3FAXDgTZeBr5+ZBBfQT/2i+YZIJa+J4n4NuLLes8W/+k4sDJ6pepxTW7?=
 =?us-ascii?Q?eyXsD8spu4wkFm/p3M32BlTO3rYJ1fto31wB/H/RzXFC64EQt46nWmdhTRG1?=
 =?us-ascii?Q?kb6AHLdHGvIGlLEktSEd8kFlJ6XN3xO0d0ls64DUznf/iBvdzLZTh5Muo1+V?=
 =?us-ascii?Q?PE4zJTW3BhSd8I16vNM7tL67hqM8t+eDfaoNiHh5eHKGn0hueUGyQOF6LA5L?=
 =?us-ascii?Q?j4lsu4an25eMFCpgX+anwOvJAlN3DWCdhm7f7S9lLtZ2hZJ2RcQCx6J9ayzF?=
 =?us-ascii?Q?31Rg+j4r2ZZnC4Dy2e97dw7cvSE21n+r5nJJ56RN4ua927ApVbuQnpbwxbu8?=
 =?us-ascii?Q?QTK1D2w1aPx7/qSppMdj5OpS18QzyXqYmHrPHdQdSJF7SNiM2QiuWE1N+366?=
 =?us-ascii?Q?NqXsLhe/7QBM7u+5M3nxjmA8NzE778D1jFP9YvuEH9w6H8RZVI/H61eITj5Q?=
 =?us-ascii?Q?RVh79trZAf/MdumF+m/xRADm+7ylkibfMfgFuUjpmLAPTswkOKMziwXHDtRi?=
 =?us-ascii?Q?zaBBrhq6y3stBSneqI9eBeXTKyrvdh7SmvvxfG8CcZLdhTEoD+X7tjCqZmTL?=
 =?us-ascii?Q?OlkS5Pzpj5uyztkz64Kn46yQQDnr7ncCO0eEFYZfngQJBiDzQ/v53UH/fbci?=
 =?us-ascii?Q?N13T4fY26bS6a3g9Ejr/FVihav/7K/F4ygwv/o8MPmNuxTkos9dPuudVbslY?=
 =?us-ascii?Q?cwG6bva9G/SsqmjxtKj857py839EVCAJgBK7Qz5b9m8GCjDoRdvljnly6BSL?=
 =?us-ascii?Q?TNDYNmAXQXK58Sa7jDnUJW8ntbK1L5l/J7KjgUF9nXreeY2yWWMp94r3iTp3?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c41509a-ff29-4dcf-71d2-08dc6f360ae9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 08:08:28.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXJOs1f3s1C9KiWiHqonNw5h1PcvNoqSjGzhHsVux1j5bh3aXDiey6qBWEZdSJT0CFuYQ4GmXl+eJmjSgQfOow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7382
X-OriginatorOrg: intel.com



hi, Boris,


very sorry that this could be a wrong report due to BIOS issues.
please just ignore it.


thanks a lot for reminding us below:

> BUT(!), look what the original dmesg said:
> 
> [    0.055225][    T0] x86/cpu: VMX (outside TXT) disabled by BIOS
> 
> So that FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX bit was not set back then. Why?
> 
> Oliver, have you done any BIOS config changes in the meantime?

we really don't do any manual change recently, however, per your reminding,
we rerun tests on both ee8962082a and its parent v6.9-rc3 again.

while we made original report, we always saw below for both commits.
"x86/cpu: VMX (outside TXT) disabled by BIOS"

by rerun today, we cannot see it again, on both commits.

then for ee8962082a, the reported
  WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
disappeared also while no "x86/cpu: VMX (outside TXT) disabled by BIOS"

we are using kexec to boot into kernel, and the kernel images keep same,
so we are sure this strage phenomenon is not caused by kernel build.

now we doubt it's really a bios issue, we found another similar machine,
which also show "x86/cpu: VMX (outside TXT) disabled by BIOS", but after
several rounds of cold reboot, the message disappeared, too.

we will investigate this BIOS further and avoid this kind of misleading
report in the future.

sorry again :(


On Tue, May 07, 2024 at 01:48:14PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@alien8.de>
> To: Oliver Sang <oliver.sang@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>, oe-lkp@lists.linux.dev,
> 	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
> 	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
> Bcc: bp@alien8.de
> Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
>  WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
> Reply-To: 
> In-Reply-To: <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020>
> 
> On Tue, May 07, 2024 at 03:08:11PM +0800, Oliver Sang wrote:
> > I applied the debug pach ontop of lastest Linus master:
> > 
> > 1621a826233a7 debug patch from Boris for ee8962082a
> > dccb07f2914cd (HEAD, linus/master) Merge tag 'for-6.9-rc7-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> > 
> > attached dmesg and cpuinfo (a little diff, so I attached it again)
> 
> Thanks, now what are we seeing here:
> 
> [    0.763720][    T0] x86/cpu: init_ia32_feat_ctl: CPU0: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU1: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU2: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU3: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU4: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU5: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU6: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU7: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU8: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU9: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU10: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU11: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU12: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU13: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU14: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU15: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU16: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU17: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU18: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU19: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU20: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU21: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU22: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU23: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU24: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU25: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU26: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU27: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU28: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU29: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU30: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU31: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU32: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU33: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU34: FEAT_CTL: 0x5, tboot: 0
> [    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU35: FEAT_CTL: 0x5, tboot: 0
> 
> So following the code in init_ia32_feat_ctl(), the BSP'll get to
> 
> 	if (msr & FEAT_CTL_LOCKED)
> 		goto update_caps;
> 
> and that is the case - FEAT_CTL_LOCKED, bit 0, is set.
> 
> It'll go to the update_caps label and there it'll do:
> 
> 	if (!cpu_has(c, X86_FEATURE_VMX))
> 		goto update_sgx;
> 
> VMX is set if I judge by the attached cpuinfo-2 so the next check comes:
> 
>         if ( (tboot && !(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)) ||
>             (!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {
>                 if (IS_ENABLED(CONFIG_KVM_INTEL))
>                         pr_err_once("VMX (%s TXT) disabled by BIOS\n",
>                                     tboot ? "inside" : "outside");
>                 clear_cpu_cap(c, X86_FEATURE_VMX);
> 
> tboot is 0, so the second conditional:
> 
> 	(!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))
> 
> FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX, bit 2 is set. So that conditional is
> not true either. And the pr_err_once() doesn't appear in dmesg.
> 
> BUT(!), look what the original dmesg said:
> 
> [    0.055225][    T0] x86/cpu: VMX (outside TXT) disabled by BIOS
> 
> So that FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX bit was not set back then. Why?
> 
> Oliver, have you done any BIOS config changes in the meantime?
> 
> This all looks really weird.
> 
> The other possibility would be if something changed between -rc3
> (the branch x86/alternatives is based on) and -rc7. Unlikely but by now
> everything's possible.
> 
> What could also be the case is, the BSP's FEAT_CTL is 0x0 (unconfigured,
> whatever), we'd go in, set FEAT_CTL_LOCKED and that'll lock the bit in
> all FEAT_CTLs on all cores, then it'll set
> FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX. I'm presuming microcode forces this
> and am obviously grasping at straws...
> 
> Then CPU1 will come, FEAT_CTL_LOCKED will be set but
> FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX won't be set, leading to the warn.
> 
> But then again, SDM says that that MSR's scope is "Thread" which means,
> locking that MSR on the BSP won't have effect on the same MSR on the
> other HT thread.
> 
> Weird.
> 
> Ok, here's a bit modified debug patch ontop of the alternatives branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=feat_ctl
> 
> please run it and send me dmesg again.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


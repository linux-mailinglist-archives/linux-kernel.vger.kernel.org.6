Return-Path: <linux-kernel+bounces-425168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505C9DBE69
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D2716489E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D7182D0;
	Fri, 29 Nov 2024 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6e0QRvk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD721C2BD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732844663; cv=fail; b=gf7L99+NRz3zMbkMjSQps/4TuSdWeJgH2jwiXcGyswDryZK6XRgcT7NGh/Lq6n654Eb6cwssvjCFxbjz/C1K8H5mWj7sxm1GV3B9rnpujgAf5F8UBuncPhYYkXv7mGiedH7pFmd6ThsM1BxZUnRxqE04+Gu+myNf+4PxjaSLiuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732844663; c=relaxed/simple;
	bh=N3aGFP7Gv+kfxSRqrRJssP1Oh4oGyeq8HT3nYNpjils=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uk5+CmI7QmPP/NQQufrkM6WK7kFRrFufEMNChaGwmufwCTlgCUI/nc1jNiU9hl3LmMQOJ9BRl/M6AtsceEgdtq0XLYOzzsZRTBbr5u28DcSJ6QuRGG7m3Uz52uIizt18DQufvpcfnUlqWBLR15/15/yK4/en/vQF52NOMMNVyCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6e0QRvk; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732844661; x=1764380661;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N3aGFP7Gv+kfxSRqrRJssP1Oh4oGyeq8HT3nYNpjils=;
  b=f6e0QRvkJIAjdjDAp30SuxeLcxcLrZXW+6E813AfXTnWDHdAF+mbGfjY
   QkRNkoFz0h4DGFjpvkT24hTA8ieIq7Q6rQ+1QjTem4/fisySrV1qVkHls
   jFwFPVKs09j6XD4a9NXq2/B08+kr8py2TcHODPnO5VTkF5LMnVPySBPhG
   6cugIOL3Nk0QfIPBR3s+UnduxPGA7LIZlKTLEGQtDfRmi2t/H+tLphq8F
   452dh4Eksv/hkyTInVoByXEjl2WHbNZp+L4vN6aCozkvd6c1wflmhdUUu
   HhpT3MCXM9qkmseVd+xYi/YT4jpVCult3iNpYtuZoGX9jDn4qEppAtakF
   w==;
X-CSE-ConnectionGUID: E0JE1lErTtC3DDBZc0RTKg==
X-CSE-MsgGUID: IDZRsmKvQOO2aNvZheNYIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="44134882"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="44134882"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 17:44:20 -0800
X-CSE-ConnectionGUID: W0F9AKwDTTajmxhBucDMXg==
X-CSE-MsgGUID: rCFpTWwsRHS3t6d4KkgDPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="96443525"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2024 17:44:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 17:44:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 28 Nov 2024 17:44:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 17:44:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VurQ9BkFKNWcV2O+9RZ+i2TDsUzNQDySSx06EftF9HtZlTSI9pQrYik3eQkGzvEZdqYURL0A5SWKuAYR/ZVL32mtxi6S3n2yDQd8bwIKiK7hqpG+YwDGRKL7qNlacx3p4FakYS4HgSN3I7q7tU8mpbzK1o62whazf2jYKjK7EHbZqSLpVCtZJJrQNf90n/qKkif4qPajYoH7BqLgx+2afYQqAM6rUV5Pjo/3fG+LtVUfhNbuWiLRqqRfH0+gqcHzZAjbXN1XUv89H6048L/gS0jXc2FzExADveVd/vgTT2MkN8sf03g6h1tMOdAqXwbOmnHjleLWDBMRe6txOylE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+siZj8ZnvBKdWUi8DsBY3sR07GvjixyvGWmFX5c7F1I=;
 b=oKnbhWtBX7pr+8cXcqyL4n2R5YTNSABwM1XQkEzBK8bUcw+0FhgKRttB4OSgAgjj5WqbXxoCWfcI5Y4M99ztjGe9SDvsUy4ncSTXsA/56AvY6DY15RoMHK2fY8qzihPnTC9W8egmEmhGJqY30lLpfahNEJhEjaIQksrhvgyUegqh57G8CzBGLeb8hb1O/b21uouTa1K0e1ZCRHnXnw4pWgxD2+YPOR64Ijc3f6vbuUoDgZGLwM9PFcFrKeRoK6WMZyva5IfkwT4pU4oU/8YSjzijBZn/3EIaF+ltyIEJ/R71C83GfpBqBaBQwbUf2PFLMAKf36cj2XVM09uPa8o2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8495.namprd11.prod.outlook.com (2603:10b6:610:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 01:44:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 01:44:16 +0000
Date: Fri, 29 Nov 2024 09:44:06 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Rik van Riel <riel@surriel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, "Ingo
 Molnar" <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
	<oliver.sang@intel.com>
Subject: Re: [tip:x86/mm] [x86/mm/tlb]  209954cbc7:
 will-it-scale.per_thread_ops 13.2% regression
Message-ID: <Z0kcZhRuDYQc9Yfu@xsang-OptiPlex-9020>
References: <202411282207.6bd28eae-lkp@intel.com>
 <20241128162128.GE35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241128162128.GE35539@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c17049-39b1-40ab-77b5-08dd10175576
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9L+HupYiHuPb0CopAP134kkzQynodJlnbGMIQTaBF4+dlpVYM97UBoEvK12+?=
 =?us-ascii?Q?YTxZK210fecKGjHnexXJIbd7qN/fzwxKqGGpyu+ictcfkzMIZ6S11tzOQC1J?=
 =?us-ascii?Q?sXa9HZJ8rZrs7uyoevMSETnLhVvFiVyfaCI5cjqHZ8sNndLPAywj/Rk0UAjV?=
 =?us-ascii?Q?Ww4/sWz0vZ2n7Z11bflFnQUmLyk782bcTtd4Aqitj+V8XYg53vOGuWAmNzhh?=
 =?us-ascii?Q?8wWotG1LvrWmR8IKGWKSXBfHWQjiCW++5/V+FwcznYfw20LmQgLoaWBbSCCl?=
 =?us-ascii?Q?HFgTSi8LGMK3VrIEW9i5xPHAhc65VPk2jn2hePGTtRO3Pjh+p8E/YE/FWVzi?=
 =?us-ascii?Q?NcuGvsYsPnsuiX1i476dkDpQtXrQ8eNrI36o2R7D8hP3lmQSY+TavdbrmpHH?=
 =?us-ascii?Q?Ef9S98Xl5Q6qJ/YnubyrFi7JrV7S8YO4z9FpFjfBQmIbAnaLOqmePFzulMMA?=
 =?us-ascii?Q?DH9gM13iaN/OeyJ8DdVmavs15LNThgbtgC+qf0gZe+GMGQXpwV0WQf9NZDLm?=
 =?us-ascii?Q?omZS/rX7Vb+aOSPI5LfVb4PsLcMgPfF3kbOF9++fZws8HgQq7SUYdNp1l8ME?=
 =?us-ascii?Q?MNlnsmCiQyTkgXxRSfGEjK1wVy6zsLYNRZra2xLVa2+mAhrNL5pPKft+1JtQ?=
 =?us-ascii?Q?xESmyAJoSBmPne50oK5zO9q+TDlXaAEQmD9cx7QsVdAzM2G+scSZ3q4UuHOO?=
 =?us-ascii?Q?5K+9KuOHQSy1MiyO3akjyTxsvnXtMbjw4OHm8falWzyc1tMAyPV+4FeSm+zF?=
 =?us-ascii?Q?GSY0HffthMgeIGqD8TFmMQ5oI6rGhT8X4VrcASRRRFFcVBvOpd9s4NmwdW92?=
 =?us-ascii?Q?MU1AWvhov+XPextE1eHoUm/eYqSjAvbISpuARtDlOmV97TfWtDWKKDwM4sxH?=
 =?us-ascii?Q?Hui8g0iPFDA7icGaSXO8xUME0Ew8AyQIOJPdiltBjW7maIhzkccBfF8+HkIb?=
 =?us-ascii?Q?taHWtNfZRXwCl6kE/P91Bbu4p+cXsBoNdUxQNJrBV7SUpmwCHwpxmXwJr2Wt?=
 =?us-ascii?Q?ZqSgkXUo/nYBFm1SFA6nRWpqiHjZPrHbATEgHX0VwFc5k37VGDF0V3UrN+zM?=
 =?us-ascii?Q?dY0AMjYOkutu7kd86Y99xT65LCKK2+Kwcv6NFiD4shsqtE+7kVgSiry35ZAI?=
 =?us-ascii?Q?cqwcgLpI3tDuQj5vt880EdulJZ0N2FhGZyq404QBfif2uoAFzWvVKa56HwNF?=
 =?us-ascii?Q?NgKaD7jMUSwtABMRzezhUXvNvt/mX0bcnC2WKBIfiQ0SSs/puX7vvXQ7waTC?=
 =?us-ascii?Q?zmlYNG1rGN1Wif3Q0jMnp+OPfYTIJGiSTcJlWgoolXefwec4Nb6KHwnEHTjR?=
 =?us-ascii?Q?JgzeT5hKv8hQwZOagU5PUaUq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ob+G5TE9RHrZp1ft7iJBqb/El5TlccZVOBQNNulGCKriI8Vyd9MYpJ2Nu1+h?=
 =?us-ascii?Q?1WdVNiatG938anEOwlkpNKm2m31WcDvaZofxqfVaHprKrHTMjVo2e6Y6Luv2?=
 =?us-ascii?Q?oPmJKunykXBQODghtZm0oMAsabDojZOF77XqcZcO2WV/RZGNkdKgAbLqpArE?=
 =?us-ascii?Q?fvJPu8k32G5tcS1n7yJEjFAnWqwTWS2Kzvw/KCGbG+bsUavneevGaSpGdyAE?=
 =?us-ascii?Q?zwtyZwIMQAKpo65CKDnJtzhSjpxaOS7GM9nwYf/vfD5PkT3VXzJ0hiOCfXsz?=
 =?us-ascii?Q?T/kbT4wIoCQ2l8iCvDd70g5VWpAZRbQV+flNr0Cfokp28SNP/sv6CpjopTtc?=
 =?us-ascii?Q?YUK1Cn7uGNzyxaKW8qwg4fgH7mLfoSwlpqf0+x1WiUpb/IJDpUcjwxBF6UT1?=
 =?us-ascii?Q?9YT7XXGzqR+iBy8zImNETWpgOWdvW3fUgZghcAvhpPPCID6JQqOHimweZyJT?=
 =?us-ascii?Q?r0uexdw3amO9x+jSc33pEIH0pRWbDMPLNVF8yJA927T5y28/GI7meucgeZ8q?=
 =?us-ascii?Q?8bZdxz8knBT56d4rgtg1mTKuYAL5OGlXzhTppFwHGfFyOVGitKCWXBiszbPY?=
 =?us-ascii?Q?9Jc0S8t4Q+vztbSgdEw135fwZmp1ekbbVqiPtVMD6x3sJ/aDA/mBP/w3Wt0h?=
 =?us-ascii?Q?/S510XkYrBKT3Swz1l2eytJxNT+6bzxMoYdBeJ0lDA9mVHoC0gFlH6C0rQMW?=
 =?us-ascii?Q?harKbCsEs6UgTpfw7LKZ89ZQoHondeoPa70H+wYrMPWP45wArYHXQIAIY1Fr?=
 =?us-ascii?Q?qIW/fMv9osBT64EvWrBjImBhXaH1OLc9CCHeBd8/nYxnixMnZQLhUSh8KRo7?=
 =?us-ascii?Q?2lhQayWYBXwYFawJmPfLyHGu8ECTc4RDFdj6/fyOXmoLLKO2yr9wWNOAh90O?=
 =?us-ascii?Q?Gk02gBVT31OSV9kSwzL6PmnCDdBGfk9kyolQAsdg48MN09eH2o+rKkquwAkR?=
 =?us-ascii?Q?kq7yZlC7ipUWcpYY5rkHD0n24mERbt5FrLT4aBjNM1kpNv9suCvs3hGh8qVJ?=
 =?us-ascii?Q?i2cZZ2WcI+bEyzRjaiv9tnH4ST7p7Hh3FWEhjxgmvfH7AGex/mWUEeuVPEDD?=
 =?us-ascii?Q?2L2cixL8ivDg64m0XTCsj+0kK3XlIhYzdBNwinC/5me2saf7o5TP4hdW7KIV?=
 =?us-ascii?Q?QaRxWTpPNy9DdqlCGcYYQEUka6N9XaviEHF7wzEkbirjxipfZqnx069eMwQm?=
 =?us-ascii?Q?8cEBJjqVn8m4cwzpclzxsD7u8kBECaFscIMn9qJ2sN/li4l3h/LVl8alHWua?=
 =?us-ascii?Q?E9ceLioEOqdIpMzDV/qI1ENJuXnztFPdvelXDEmv8kygxUdVTc9sgJekXcHJ?=
 =?us-ascii?Q?RUuUlhbC5HNyqOh0WNJxMgLGTNVTT/Yyh+WCBSs9kxKylC3CxreIcQMf6nwE?=
 =?us-ascii?Q?Ykhxdybbj+HVfLcVmdfUhcyBqbkgmOBPJ3x5YtkzBSpFDUaSvnh6KsbsQA78?=
 =?us-ascii?Q?utKR8O20oaAkV7qvL8yU7YU5tsIwfCftOSu1YJnURV1PtWQLc5LAj/NZ0229?=
 =?us-ascii?Q?C/OS4I+BSmwZU3j4WqnymUv59+9eQMU2i1jjbIAWiAsJ5Z5XzHLGe97nB66v?=
 =?us-ascii?Q?IsUxZuK9TlXfW0++OtQs0YjM6pgv44fXt9vrXFweqp8ul09UJJIsukVUD7ps?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c17049-39b1-40ab-77b5-08dd10175576
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 01:44:16.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZWvzxvnUK2fZ0tinlMo22jvxchdI1eoXBMOMstEm7XlPB7IBXeLwHvA1SOBhguz1QSebQf6tjIHxHcbhVFI9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8495
X-OriginatorOrg: intel.com

hi, Peter Zijlstra,

On Thu, Nov 28, 2024 at 05:21:28PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 28, 2024 at 10:57:35PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 13.2% regression of will-it-scale.per_thread_ops on:
> > 
> > 
> > commit: 209954cbc7d0ce1a190fc725d20ce303d74d2680 ("x86/mm/tlb: Update mm_cpumask lazily")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
> > 

[...]

> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20241128/202411282207.6bd28eae-lkp@intel.com
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> >   gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/tlb_flush2/will-it-scale
> > 
> > commit: 
> >   7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
> >   209954cbc7 ("x86/mm/tlb: Update mm_cpumask lazily")
> 
> I got a bit lost in the actual jobs descriptions. Are you running this
> test with or without affinity? AFAICT will-it-scale itself defaults to
> being affine (-n is No Affinity).

with affinity. we don't change this default setting.

the command is
python3 ./runtest.py tlb_flush2 295 thread 0 0 104

the first '0' keeps affinity as 'yes'


    print('Usage: runtest.py <testcase> <duration> <mode> <no_affinity> <smt> <threads...>', file=sys.stderr)
    sys.exit(1)
...

affinity = "  "
if int(sys.argv[4]) == 1:
    affinity = " -n "


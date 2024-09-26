Return-Path: <linux-kernel+bounces-339930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC184986C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB311C22342
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF980185E6E;
	Thu, 26 Sep 2024 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6Q1+AXZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76AB17C223
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331259; cv=fail; b=OjO/x3k+o/Kc95YfEkmU5NK64G9GkN0s6QvbC7YztZJL3UgqFMaO1b6Fg4m5DSHXuDqKCRexp/oxi38/8lzVMJucvT+DpaemhFaqYuhSKizYOaAUxfVCjOFJzib3wxcHoJNO9LCxAsgl1r0y38HpkSQ29ywwIPSBhPiT2QdLXBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331259; c=relaxed/simple;
	bh=z76WCMoD5oYl8Fr0fTRa4qoU8RSvBLRg2XWlNbrkODk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IBcux6gyGee5NSitVltPegbemP7R4hkPKjtH2DW+ESgNnaXown4TZPOsFPVzWJl+ZyS2OesNFjzuDUT0LtYRhyofUe0FjQAoihCHaV35EgS31L3occ+duTAx+ADCeZwyf+BEMXZve8U9GuqMGT29XobyUS3JWm78GGneeOLli5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6Q1+AXZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727331258; x=1758867258;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=z76WCMoD5oYl8Fr0fTRa4qoU8RSvBLRg2XWlNbrkODk=;
  b=j6Q1+AXZDqvYj92x6A2jLCs/D4dvhXcPIfnHyWZ6LfqEXFCD7hahVCQD
   O3p0PeRwo6jCg5Jckc0qDjiMQ0q43w0dNZQ3c1mVy7G3ZHKhN/QtlKzEO
   J7H92tg0ZVDL941N+jwhpqqA1yP792axVPBDgV6JVeC9ZVwVrA9CV+QUw
   bQY7QL5nzRWZa/xoNeT4SFravDYysbIQedc9PSyL/YJytLumxJKOXCSRa
   rAGpp5sG55r0D5AzhgAUmQU+obzCTDR2LNPCAcL9wcmlNpZqGeB7u3/VM
   MUiCIECP2vOYeKrsA8264bo+ZWafLP5xqObP1CEH8/Z0L9BdntzDqn0Q6
   A==;
X-CSE-ConnectionGUID: g7mk/mo2TM2ZqmlHpQCU4Q==
X-CSE-MsgGUID: 9PPLHjNbRZe1g2n9USOKEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="30293955"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="30293955"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 23:14:17 -0700
X-CSE-ConnectionGUID: 4cK/GMtaSz+z1hmb3TpZFg==
X-CSE-MsgGUID: 779XCgLJSWGcTRXdl1+BVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="76941236"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 23:14:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 23:14:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 23:14:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 23:14:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 23:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZhHba8LvWKC32jxPKtHcWo/LjgOdFsBvSsfmn5mtbChUBm5stDTRujkQKl/rLLBHIQgfsrvogPN2BCgohUA3huWuCiS2g1N8bICtrGOshAamrZjd1QDwEJYXHO4QgKa8jEr9epcjzfnLV3XGhbjOylOvYpFR0rb/YozTkI2aKaeIeNo/IOWN+AH0IeqRCReXK76LeDV4bLQI2yq8FLa6rgppuiWjVlGJO1w075/zMHLIiMMkMWpelwuURT7Mo3bPJ6dFd/4hh4wuQpKjbSo5Kuswxig2tenpfNgnZBRumXvqzS8KcZ2laQfw4SQpr8KsCalYio/26RyqDJifTjQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNWtQ9iNO8cXnamm1EtVr4kGPSXAUDOf1MPRFFlIInY=;
 b=d/eq/4+LFxv4wQdH0ihO4j25jbAul/dHOpR6t9/llWvQaVgRP5lB1LySY8f13lMfeUq7xbeSNNRtINCZaLldcGsUyLhJr4Z5KjEB/lK4KFUjh5xw5W/w/99XRneSjpsYtPXnaWEUYgpjFHFCwD4tj5rdnoQcOmD0MMPPk6zM8tS5xpjzYNP+lVyX3y1l4NOh/emPaZAWQ7ED0IO9vHsaByY+nNv19P6mzE2KdNRuG4GOt3OvBPRnG4dP+xhnpWB6xdOeuQsdxwHQBqkODtQj21NR41ArlcQeMrnZoORnN+4vA2fWZonvWJMaze7eoOj+3Rm/6iucHZRlLKs+8cZQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 06:14:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 06:14:07 +0000
Date: Thu, 26 Sep 2024 14:13:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, Yafang Shao <laoar.shao@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 1/3] sched: Fix cgroup irq accounting for
 CONFIG_IRQ_TIME_ACCOUNTING
Message-ID: <202409261230.c7f0e4eb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240923090028.16368-2-laoar.shao@gmail.com>
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 252f769a-f177-4d0e-6bfd-08dcddf26dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZE7gfmG+jYQsAoUdl5qKP+qAdXE3GdV271Sz9f1r9tvWBdR5MtABc5VwlWpx?=
 =?us-ascii?Q?KZ0w5y2RIDsQxSSN5sKq9gzHhsLhAahYTT4tTaBSy6gkoGR2isxfGP7UnqnB?=
 =?us-ascii?Q?NXTpo8heriASDKoV5NN3n6Wo1e1my9UIOJduHR/EUAbwTZt4ItMTD46kmhIY?=
 =?us-ascii?Q?CUcGicybACAy+p0kCEfHO9CSRXxfr6109XQI4CNrwQLhUzdNO6RHlQDPCNoi?=
 =?us-ascii?Q?zqkhj8Xb516b/HQBzRnQ92WfvwPGM3rdXkFTM6eGe1QW5IrYrHzxael4MYwa?=
 =?us-ascii?Q?ZswFTNQ67J5+Lp48A2JYATN7pI3us3mn3YLe5ujtwlJER/NKcf6ZEa+kZqFP?=
 =?us-ascii?Q?ky/dB+/zHywcYDAbOUsan0Kgmnv6do7eIY2wrPUZwNBdl4Gkw0DJNeSassvp?=
 =?us-ascii?Q?vxactKk7XVahsze2pO2Vhrg/6fqUakiD3sx5wP2RCcyTedWnE9zcW70n0//q?=
 =?us-ascii?Q?1CiN84Nf0hWGZE6ibS2Pk24IbW4AawnjUURndolrTKayWTBd8Qkag6Zixp+T?=
 =?us-ascii?Q?EdSaJWs5MZDc6vpV8D//dx+C25L7inc5BG3nAYbTmm0H/A1ffa1lgjl5jTa3?=
 =?us-ascii?Q?b8+VgvIcVQ9iSlmREIr5mf+Cn4nSXyNSa7sbehlRsyVNufwCKO1X4FUGr1p8?=
 =?us-ascii?Q?VgWTaqdP8wT4dESHOxu0PA9Co2lmdtXhz9XZul4VN5Ni23UWWeRE19PXYE9n?=
 =?us-ascii?Q?ac7GvF8CqBqNJE/XxJIeqPUQty1aTP/PU17Kw7QmDx/aSTR2LxJSTomfLPNl?=
 =?us-ascii?Q?7UBYmu8YAKqdlB6q43PHA+NYKbJKGnCdLYsp+RmrKvusGj6XlFwDqJV0eW8v?=
 =?us-ascii?Q?RtzHJyujcDxWJrYZosCVoeEFB9Yvjf/sC8dcWRFyP+iRialAYxrcrqMzZMwe?=
 =?us-ascii?Q?HvTh8Em6Xgw0QFVfhdnTjad9swKxBc5TnqB03PpGDRLHXTAAC/SwlrerHLru?=
 =?us-ascii?Q?kwiUm/3jHay2BoO6Bc4jSeqTQx1gqWE8ESJ0L0QauZfhR7kz7Q+Bi8/fU1Qj?=
 =?us-ascii?Q?7aAdtVq94m5zQTTjDJmhEuSZ0A2SXG+UE8Nzmm/Z6iQsbvYjezUDBvfgHQWV?=
 =?us-ascii?Q?4PhTkkgtaS0g6cIr4dOgbhjU6+hwQNrJnHAyp/tp5m3sPunuAxtj318C8ukr?=
 =?us-ascii?Q?2Wnx7Mk9KsqYZ2Y9HT1AagfoGTJnwMUK4IN29FhgTzXZylQuopQYa2RB4bK1?=
 =?us-ascii?Q?RC7IATicp1V4vYBFjZPrOthOcitcJ1Q5yXX0dK8n7Xr4AQIVJghbaAmECJk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZVq10QUfuC5VP6e+Pg2dBFrYAaTlk48Y84CB9/RmF6p2DUhRKrbhroQwQPvR?=
 =?us-ascii?Q?uxgF3Uma4WoVZ+PhhNx2NOtRRD1SLy+KEDQKzrw2jkPBderdEwFbCao2EaEU?=
 =?us-ascii?Q?RRKRjJEe/b+pj6xyrhqSU3cRS0HqsyRYjYLRZao8R5hv86lrNzI0X+4QWAxh?=
 =?us-ascii?Q?jNkxeE0VyvkGG8ClpYpd0ICIXcQ4f87wLaj8ZL7xv8gtjUKXdEocJXN4QJmf?=
 =?us-ascii?Q?bzsZJCg+BPxAmC2Kfr/xOrz1+XX5bit4qFOhnA+DUNIgn4CV4sGRD11ATA1u?=
 =?us-ascii?Q?n0/sZBRvt4J7WRwQY8xYHTcNK9gDgBedgBkWstD3/OKanhrUKf9y/0Z1+1o3?=
 =?us-ascii?Q?PryrJ91vjOh5CP6I3DfQdXiIQEHyHpy/onLRYlDfUxWb8RHtIgIZXms9teGN?=
 =?us-ascii?Q?K6EAD3XvEB2lmkobCHMHL+PBJQHF/NvmbU3NknCz8he/OXZaGKZW5Fb+kckJ?=
 =?us-ascii?Q?VyevBy8WfSlyZMGEM1SblZqhzFif01OafPC6XsnsD1nuBfwXBvqziYROuhi1?=
 =?us-ascii?Q?NmgP1iIIPiOtEpw58z5HW7m4Ap0EAFSlcHtUQpxodPi5KD+zn2lisHKEcfN4?=
 =?us-ascii?Q?YTLon9GpWVtJc9OThU5RaxcDiQDKtWLJN885OfwyrX7V5n4WGhawsLDgdox7?=
 =?us-ascii?Q?w5atzOJ4iRzE9dQPRYk88AWUgBDNT31cyT3yfoE4ZnCED17WbYUojef6nRxP?=
 =?us-ascii?Q?UBhNyErxrRPB2ozkC6aZUsiFHOzpbLacXoRU000wbNe2PNz/4+QQWz4sN1P0?=
 =?us-ascii?Q?NP3/F/xWL0hP5vvx1nIOwZcZ6ON9DNJ2CGkVi0e8vANgdnan1c75zHhAF44k?=
 =?us-ascii?Q?KpN+IwWd5VH7giGaX91YhHnujah2m1wpnuqigk0i4u7ke5q8ErtJw3/UYshD?=
 =?us-ascii?Q?DpJNrNuhJQQOxZeoyBPwBoIUgLtgLdoedGRGtBrIL1ZygKX9UJtOMD4+WFH3?=
 =?us-ascii?Q?+374cSjH78r0Me2g/Put0lU5d34wVw7fmF6yeucy4xhDbpEGBF2XNdJnpp1V?=
 =?us-ascii?Q?k2QB9VWg0D/rbn1E+F0GLftyuLgmwDW1x8o1DX9IL8CDKltXYqSi4gUScyX9?=
 =?us-ascii?Q?D5bKKhbhikJ+QNvLKZgXy0TGelALnGFBMDofdU5N7xwhlGfJogpqHfoopCBb?=
 =?us-ascii?Q?a+3gEWl9ej5qeeXZtsaO8fFZf3ZuIYiKitPRwO4zgf09rKOefxmpQnGXQBYv?=
 =?us-ascii?Q?MVYiGDKHVlp/ua/DXncJZRI4NQLqAolTC2536kWcWAVspHVJf30cjOAPUWBl?=
 =?us-ascii?Q?QeT2lnPUGq7mGaslzE9l4q0jjeS5zdRM08KdtXyMKH6/1MQixZMrDyL3mThz?=
 =?us-ascii?Q?dZ+9xy28Fu6RgR+egRszIuCyHoJX6u+R0yv14+lPCPtyg3WoyXS+02QDHHMS?=
 =?us-ascii?Q?hdgIovCvGx4GIVqq3pgQILxw/Tzcakvv4Q/hUijyQ9pc8iei32NOdAU0UWUC?=
 =?us-ascii?Q?3AQ/fWRU/bmcnyxBhvbpZziJV50cWKxSuF9jrgItS4VAMzSH+15AQWdneObA?=
 =?us-ascii?Q?/VezpRGOW48M313gzyuN2pzl17JAvZkJfolIVe8p/ze8u9WBE4KEon9HYK7B?=
 =?us-ascii?Q?98D2FZf//2TqM+IBBtD+1y1wBLpjdWdBeCZZ37Jw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 252f769a-f177-4d0e-6bfd-08dcddf26dab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 06:14:07.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4JoN4m7gc8fBjPuG0P85VEyhRNLQ89P5uTUkcDuQydxtfSirQijL5tF8tUr/ZkoXRL47ezpyabSEUDlt/KcJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/sched.h:#cpuacct_charge" on:

commit: e5633f7cf7d093cf5bb191663054441fbc745a5a ("[PATCH 1/3] sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING")
url: https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/sched-Fix-cgroup-irq-accounting-for-CONFIG_IRQ_TIME_ACCOUNTING/20240923-170321
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git bc9057da1a220ff2cb6c8885fd5352558aceba2c
patch link: https://lore.kernel.org/all/20240923090028.16368-2-laoar.shao@gmail.com/
patch subject: [PATCH 1/3] sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------+------------+------------+
|                                                 | bc9057da1a | e5633f7cf7 |
+-------------------------------------------------+------------+------------+
| boot_successes                                  | 12         | 0          |
| boot_failures                                   | 0          | 12         |
| RIP:cpuacct_charge                              | 0          | 12         |
| WARNING:at_kernel/sched/sched.h:#cpuacct_charge | 0          | 12         |
| RIP:console_flush_all                           | 0          | 12         |
| RIP:ftrace_likely_update                        | 0          | 12         |
| RIP:desc_read                                   | 0          | 12         |
| RIP:handle_softirqs                             | 0          | 12         |
| RIP:kasan_check_range                           | 0          | 12         |
| RIP:_prb_read_valid                             | 0          | 12         |
+-------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409261230.c7f0e4eb-lkp@intel.com


[    6.485339][    C0] ------------[ cut here ]------------
[ 6.485374][ C0] WARNING: CPU: 0 PID: 0 at kernel/sched/sched.h:1414 cpuacct_charge (kernel/sched/sched.h:1414) 
[    6.485389][    C0] Modules linked in:
[    6.485398][    C0] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G                T  6.11.0-rc1-00070-ge5633f7cf7d0 #1
[    6.485406][    C0] Tainted: [T]=RANDSTRUCT
[    6.485408][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 6.485412][ C0] RIP: 0010:cpuacct_charge (kernel/sched/sched.h:1414) 
[ 6.485419][ C0] Code: ff ff e8 26 8e 4d 02 85 c0 0f 94 c0 eb 02 31 c0 0f b6 e8 48 c7 c7 30 88 c2 85 31 d2 31 c9 89 ee e8 38 23 21 00 40 84 ed 74 02 <0f> 0b 48 c7 c7 60 88 c2 85 89 ee 31 d2 31 c9 e8 1f 23 21 00 4d 8d
All code
========
   0:	ff                   	(bad)
   1:	ff                   	(bad)
   2:	e8 26 8e 4d 02       	call   0x24d8e2d
   7:	85 c0                	test   %eax,%eax
   9:	0f 94 c0             	sete   %al
   c:	eb 02                	jmp    0x10
   e:	31 c0                	xor    %eax,%eax
  10:	0f b6 e8             	movzbl %al,%ebp
  13:	48 c7 c7 30 88 c2 85 	mov    $0xffffffff85c28830,%rdi
  1a:	31 d2                	xor    %edx,%edx
  1c:	31 c9                	xor    %ecx,%ecx
  1e:	89 ee                	mov    %ebp,%esi
  20:	e8 38 23 21 00       	call   0x21235d
  25:	40 84 ed             	test   %bpl,%bpl
  28:	74 02                	je     0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 c7 c7 60 88 c2 85 	mov    $0xffffffff85c28860,%rdi
  33:	89 ee                	mov    %ebp,%esi
  35:	31 d2                	xor    %edx,%edx
  37:	31 c9                	xor    %ecx,%ecx
  39:	e8 1f 23 21 00       	call   0x21235d
  3e:	4d                   	rex.WRB
  3f:	8d                   	.byte 0x8d

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 c7 c7 60 88 c2 85 	mov    $0xffffffff85c28860,%rdi
   9:	89 ee                	mov    %ebp,%esi
   b:	31 d2                	xor    %edx,%edx
   d:	31 c9                	xor    %ecx,%ecx
   f:	e8 1f 23 21 00       	call   0x212333
  14:	4d                   	rex.WRB
  15:	8d                   	.byte 0x8d
[    6.485424][    C0] RSP: 0000:ffffc90000007f68 EFLAGS: 00010002
[    6.485431][    C0] RAX: 0000000000000000 RBX: 0000000000007ab8 RCX: 0000000000000000
[    6.485435][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    6.485439][    C0] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[    6.485442][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
[    6.485446][    C0] R13: dffffc0000000000 R14: ffffffff84c8c080 R15: ffffffff84d62f90
[    6.485451][    C0] FS:  0000000000000000(0000) GS:ffffffff84cdd000(0000) knlGS:0000000000000000
[    6.485456][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.485459][    C0] CR2: ffff88843ffff000 CR3: 0000000004cb9000 CR4: 00000000000000b0
[    6.485467][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.485470][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.485475][    C0] Call Trace:
[    6.485478][    C0]  <IRQ>
[ 6.485483][ C0] ? __warn (kernel/panic.c:240 kernel/panic.c:735) 
[ 6.485490][ C0] ? cpuacct_charge (kernel/sched/sched.h:1414) 
[ 6.485496][ C0] ? cpuacct_charge (kernel/sched/sched.h:1414) 
[ 6.485503][ C0] ? report_bug (lib/bug.c:?) 
[ 6.485529][ C0] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 6.485534][ C0] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 6.485540][ C0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 6.485555][ C0] ? cpuacct_charge (kernel/sched/sched.h:1414) 
[ 6.485562][ C0] ? cpuacct_charge (kernel/sched/sched.h:1414) 
[ 6.485569][ C0] irqtime_account_delta (include/linux/cgroup.h:420) 
[ 6.485579][ C0] __irq_exit_rcu (arch/x86/include/asm/preempt.h:84 kernel/softirq.c:635) 
[ 6.485586][ C0] irq_exit_rcu (kernel/softirq.c:651) 
[ 6.485591][ C0] common_interrupt (arch/x86/kernel/irq.c:278) 
[    6.485597][    C0]  </IRQ>
[    6.485600][    C0]  <TASK>
[ 6.485605][ C0] asm_common_interrupt (arch/x86/include/asm/idtentry.h:693) 
[ 6.485610][ C0] RIP: 0010:console_flush_all (kernel/printk/printk.c:3055) 
[ 6.485619][ C0] Code: 1d 00 4d 85 f6 74 05 e8 7e 94 49 02 44 0f b6 74 24 07 f7 c3 00 02 00 00 48 bb 00 00 00 00 00 fc ff df 74 01 fb 48 8b 44 24 38 <0f> b6 04 18 84 c0 0f 85 ec 01 00 00 41 80 7d 00 00 4c 8b 7c 24 50
All code
========
   0:	1d 00 4d 85 f6       	sbb    $0xf6854d00,%eax
   5:	74 05                	je     0xc
   7:	e8 7e 94 49 02       	call   0x249948a
   c:	44 0f b6 74 24 07    	movzbl 0x7(%rsp),%r14d
  12:	f7 c3 00 02 00 00    	test   $0x200,%ebx
  18:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  1f:	fc ff df 
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
  2a:*	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 ec 01 00 00    	jne    0x222
  36:	41 80 7d 00 00       	cmpb   $0x0,0x0(%r13)
  3b:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax
   4:	84 c0                	test   %al,%al
   6:	0f 85 ec 01 00 00    	jne    0x1f8
   c:	41 80 7d 00 00       	cmpb   $0x0,0x0(%r13)
  11:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
[    6.485623][    C0] RSP: 0000:ffffffff84c07c68 EFLAGS: 00000206
[    6.485630][    C0] RAX: 1ffffffff0980fa8 RBX: dffffc0000000000 RCX: 0000000000000000
[    6.485633][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    6.485637][    C0] RBP: ffffffff85620b00 R08: 0000000000000000 R09: 0000000000000000
[    6.485640][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000016
[    6.485644][    C0] R13: ffffffff84c07d47 R14: 0000000000000001 R15: 00000000ffffffff
[ 6.485660][ C0] ? console_flush_all (arch/x86/include/asm/irqflags.h:142) 
[ 6.485670][ C0] ? console_flush_all (include/linux/rcupdate.h:331 include/linux/srcu.h:267 kernel/printk/printk.c:286 kernel/printk/printk.c:3041) 
[ 6.485686][ C0] console_unlock (kernel/printk/printk.c:3119) 
[ 6.485697][ C0] vprintk_emit (kernel/printk/printk.c:?) 
[ 6.485708][ C0] _printk (kernel/printk/printk.c:2376) 
[ 6.485724][ C0] __clocksource_register_scale (kernel/time/clocksource.c:1224) 
[ 6.485739][ C0] tsc_init (arch/x86/kernel/tsc.c:1566) 
[ 6.485750][ C0] x86_late_time_init (arch/x86/include/asm/cpufeature.h:178 arch/x86/kernel/time.c:85) 
[ 6.485756][ C0] start_kernel (init/main.c:1066) 
[ 6.485765][ C0] x86_64_start_reservations (arch/x86/kernel/ebda.c:57) 
[ 6.485771][ C0] x86_64_start_kernel (arch/x86/kernel/head64.c:437) 
[ 6.485778][ C0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    6.485795][    C0]  </TASK>
[    6.485798][    C0] irq event stamp: 2166
[ 6.485801][ C0] hardirqs last enabled at (2165): console_flush_all (arch/x86/include/asm/irqflags.h:19) 
[ 6.485807][ C0] hardirqs last disabled at (2166): common_interrupt (arch/x86/include/asm/ptrace.h:214 arch/x86/kernel/irq.c:278) 
[ 6.485813][ C0] softirqs last enabled at (1370): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:582) 
[ 6.485818][ C0] softirqs last disabled at (1359): __irq_exit_rcu (include/linux/sched.h:2183 kernel/softirq.c:620 kernel/softirq.c:639) 
[    6.485822][    C0] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240926/202409261230.c7f0e4eb-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



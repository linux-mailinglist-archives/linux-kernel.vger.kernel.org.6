Return-Path: <linux-kernel+bounces-265138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5922293ED3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB891C21828
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0E8287E;
	Mon, 29 Jul 2024 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2Jxsmie"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FAC823AF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233708; cv=fail; b=MIkN3AuxYv2bkV7tT1s5kGgPfVnarzPFgUiaDOaIRkbmzen9OJnluaGaYOJ2Xmu0DN9efhiqN+wq9KM0zm4RC5QCg72z9rIqRybP9IYbLUEDKxuBwOSaTVRmLBdy9le6GY5DaORXX01AlsAWUvPiMDgz7zCm7H2jsdMVfYZESxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233708; c=relaxed/simple;
	bh=HDkzdvXuuPQiEhXcsn+Y1Z4RfntS4VbJBi3hYY0vnKA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eRGDCjrmFP3LyP6+0aQxeUGDa8l019mkXBlEntJwu0dPHlggbRYLidC47deK3t5F/UyhYCN0fmgMCqxqPFlZ2Kbq4jf9bqZtamT1fYz2yh1F6jLGbsleJx3UDaAayUgl8aIN/N/eupMElJJ2WlvOhePnZM0Ug59SI3rHT7K6REA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2Jxsmie; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722233706; x=1753769706;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HDkzdvXuuPQiEhXcsn+Y1Z4RfntS4VbJBi3hYY0vnKA=;
  b=c2JxsmieyGrYhX+X+u273AABsGnOxPF5H30wehtslfD0tPIkLZYzwhAb
   3Wi6otsIS44jKEzTNig7Nc0DBiuqObpnrWjGkPJ5mBY4rQlxlWbkE8wqN
   Y7fW62157UEBSdZYIH41z1bahTrcRmd/N8tP4VvAe7witnikJeYc5IYht
   sGCCNKFtlxUniq7UfJR+64wL5jcxAa3CuH1bxvTnCjDqqG4ZKc9K1etLi
   PxGH0QsoYu4eo50CmMJSFy1VusFxIIEjGqATydm7r3R/mAI/dhZBGcbdM
   iMKhdsI52FtjSKsj+eVR53UGhW6697aMEGc7V5h4g3j6+E7q6c+9MEyY+
   g==;
X-CSE-ConnectionGUID: IvGdVZHaTXigs3IFfnXD9w==
X-CSE-MsgGUID: W/JQpjUFR8eFmFBpnu4Pkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="30555470"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30555470"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 23:15:05 -0700
X-CSE-ConnectionGUID: Bq1fnelVRWms0NjlX2kRgg==
X-CSE-MsgGUID: UvhFSZUISf+eFlTFQFldPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="53515430"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jul 2024 23:15:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 23:15:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 28 Jul 2024 23:15:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 23:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYTqjUu5r3SVV3udFLo90jooQj6LdIoyh1v2Mpqqw6GFARyiVyszqKxBcXux7cZ0MLSvmaqDUGanHfAxHu5DGC7LTcPhi2xzKpJSCMILuLNFsDp5lNqHXMsrsX6sHlLOqD1VkZTSa47naGidVWQw+P9Wo5GPD5Ldb0MruUHh+R1+iBrBm6bTNHAvihWSPW8NtEWYKuNFcOxq5bmrEQm+FJ3P1PSTHirIOTPDCnT4bJdTJWhgMGZFINpMZ6hv7dTl8XKHZYi/138xKp+txQi7kH74ph799AUIOulIvq/XgNviQUQtIfRaEqyoQuX/Ph2+AQUuMxILVj8nJt1gxjm5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB3C8/KFiqRHMkJJsADxW623XUA20GSJiJNOwsxjXUM=;
 b=U4wTxUZJ3SbOYH0qNuFyUfTUw8gib5kJmeeCQxrYWrXRiJTjEr+46TVLONhagKAMV2JfLYbB0hQV6pdaQvWAHAgA+zhLGDe2pdqeeVbl/EZLXYXQam69K8cnvAazpCzi3bHxlVvQeXN0PKyTgaTs3t8zz7lsg78AQNh81v/KJ10+fTl0nyT9a2wuVlNV+Vh9fOlroixYNrzeoQWSKFB6yoI2oGIxE45pPhmekYRW4TAPkdejnbFxgOFbeAbnWNEOO4TK9hD2pVdOAN4ZZWwP3FEbaBH/p6+5uhvl+7QEUxZRVdkKZ69kjK7MGa+qU3JKi9oRLZplq6FD/ZEEEV72Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 06:15:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 06:15:01 +0000
Date: Mon, 29 Jul 2024 14:14:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [peterz-queue:sched/prep] [sched/fair]  124c8f4374:
 WARNING:at_kernel/sched/sched.h:#update_load_avg
Message-ID: <202407291328.761441a7-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 05056f57-982c-4a29-a262-08dcaf95c7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vfE/ACQVgzAn3xvyTcHdbqLgpuAPGBkHCNajITMfuoYPkTIRNNxKZ8VtTA+U?=
 =?us-ascii?Q?ejxRZwKZwZmvlmjKvn6g1EglP+Hjyjfv7glIlKWMCzU+Q0gVbl4jEo2PvdZG?=
 =?us-ascii?Q?u7Kb1Kou4Z+o7QrWPInhKv0jXh4Td4pX8fOOBU5EoLxdyRPC3bcFRKSLDJy1?=
 =?us-ascii?Q?BMYspIMAOYVCEhPx6a/RMeyogNIFI2NnleY7Jk+37unYjwTrC8qmuzMWjNLB?=
 =?us-ascii?Q?Yg4Be546b2tftuVSWNDNAO+7HM182B8hTXJCeoc6jhzz78mAW0rEp15aOs01?=
 =?us-ascii?Q?h1aAXxtWKiAVQOwa8EMPNIA9uvoAtQA7Y569nNhKsdeX+vbgJ2+pasL5Q1+G?=
 =?us-ascii?Q?PigWUORGxueGsDCyB/RhUBWsgjvfnCfRXUtfdKtCfOfw7JO73nb/JP6iQHzr?=
 =?us-ascii?Q?R0alh29fZgzneoSPHFFG6RCJm4sYdICbqvxHOCaAuM0h7wGOoFtnjI2CSVMK?=
 =?us-ascii?Q?qvRUsDZ/gOTAg65r2sJdJJEF/bDLPkIfN7X6LojQtYtBwsQE29yCuxvbRYhd?=
 =?us-ascii?Q?M2BAQw/A/YqVSal4dkHVJVveYK7hveVNmw0y7KWvtPLiogQoy8LTXr/G5293?=
 =?us-ascii?Q?zWfIS/X0BW0a2j2WenbhkOvFNKjfGtukxRTN0j/wSsT4Bm2j9hH8L6APVJD8?=
 =?us-ascii?Q?WsCn+Yv88eS9UCGEQPkeuXuZU9a7yvwNN0Kof+xFM3tW8T1zVYTawG+bOC3m?=
 =?us-ascii?Q?FIO5w1Mee9tJQ8LJ6uOxc9iBGZxa3sgyacf97vF/1EHMtZasgeuaZeSlCXTX?=
 =?us-ascii?Q?w74NMiq5UkeFX/T+vKSGqemPItE+vcBxR6Vxbs1aoTikQklqTxCMVRbXXduG?=
 =?us-ascii?Q?jBcf7YYI6lGSmTYqmUexJHV3/zVGR5TzLo7v6D14hGEf8PGytZkHv1xApFdk?=
 =?us-ascii?Q?CgyvQdP4tj5qq6GIgdv834R/IFm4uedG3FuX+Obc+xeE8CECD3286yT13kEI?=
 =?us-ascii?Q?v4Xg+ddnorvc/q242U0JVTxZOpdMxGyuegyigDXW5InRKvABKYDuFycFOvK/?=
 =?us-ascii?Q?szPeKRjDLwazMXyUTA8zM9ADgwE+65PFRkBTITQH5XIsTMPox55DAei5UE/r?=
 =?us-ascii?Q?vyn8CyXcHX39B3SOGJh9gtmgOZDRDslIZGOgVe87nDC7SnxHXMw3Thar7k76?=
 =?us-ascii?Q?rCJvpquPD8e9OLQWh8qxkYjyCSfa4Megma62qy/yWiGRv+sB2QvhvFgXxIfk?=
 =?us-ascii?Q?YzqNontahk9DPbEiMuPiolFjsEPC7DBD0ax3BBP6lqNylJ7aMX0jxBhJCOZ+?=
 =?us-ascii?Q?fzN2kmb/3U9byDp+A9ZZBCF4MuHHjwnvCQoAByCma18DineONucpFDvRLYMR?=
 =?us-ascii?Q?Icp9+BEmnVW/Jvc61PI2YghB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?stWDyigr0V8c+oNr4lYcMDXvWkhL39PWOTnYMTydHnh75A6lXpVz/Kl4k/E6?=
 =?us-ascii?Q?6tJtdMpkVKzxpJFufPLtmvKvY/EUSvpoSz5Ksux38iZO8X5IhdvJIGrhcZBH?=
 =?us-ascii?Q?uqkrTIxQ7vGlY78GLY7U05d3QzHUPzGOeDjFc2EwZ3SvUEBt+ewJKIG10PBP?=
 =?us-ascii?Q?QtnkAlyFxY2zCkFTviGywGF3yFtscWRhlvzqygKxDpMhZxCeVW05kvCzV5A4?=
 =?us-ascii?Q?x5RBWKv3JudhOhelGNPYBtzJM5u29fRI1Eb5xm7vlblYZKDUtl93ZIEx/zVQ?=
 =?us-ascii?Q?nPqwtb1CznzZkPZVvlSFKSbdqI1SSqPAryNs1xVTAykf8E65KE0Zw/6y9aQ3?=
 =?us-ascii?Q?C4lWbxv5e+wPiOdAtM7gMFTeofD7gTYWt5sKtV9xG4NYNI1Le8Ix2LD+/UZr?=
 =?us-ascii?Q?Jt1NaDIqyEpspFAg3uBTHtJix4+/hspeFQIFZJN6XqonRyFSAogwCTRnsxqE?=
 =?us-ascii?Q?iZPqdnUmP4SImfy2nVKz3GzPtDiOFw8Tg/5Wa9yJQj0r3v3lI+LJ+bP25z7/?=
 =?us-ascii?Q?7Fse6uXCeNpX6+TOyzjqrpzMVHDKqBPoP0I53C2/qVGItbLFYCiGgtmzMAf+?=
 =?us-ascii?Q?hJJ0EH9XCKG8F0Ey0mkwgVve3YzxkHRhJMklhnLfQZgUdX8GWIaPs8/tYe6V?=
 =?us-ascii?Q?h/gy7hfDs6JFT2VS/azV4M51BXBlz+oy2aAqQYClBxGSNLa3zp4mkwe6bU9e?=
 =?us-ascii?Q?NqhFGApNRsSU3gpI124j1GccxrGUXvtyKGK0YnRFj2yY+RqEkTUiPTXCyArn?=
 =?us-ascii?Q?uvwcbtYMrI55nvlcn5wjPumdfq5DIifdqm5pkFXxmQ9BI3ed9y+a4tnc1N4j?=
 =?us-ascii?Q?Yt/4Ikd1rIyHimH++Gi9320EXv+r4pLEBCP01hL+zri5CEBzmGFZqsWu8uyG?=
 =?us-ascii?Q?hCtZrNHaHRNczWEEtHGnGZ+MtS5mKwulKJFBqTan34D8lgakPcxDAq7aalHJ?=
 =?us-ascii?Q?jlS2t3vprGPYAin+BiCE3jWZ87tb5N3OewPqR4IumT+u8+zhQ2t5RCizL++d?=
 =?us-ascii?Q?Z8/2fUm4uV+4d+75O1xCc1S2075/MMJAWlqVk02KAKnga2hJtXwY3pWLIhoY?=
 =?us-ascii?Q?x0PkfXe1nE2pgMUfxg1uWp6VwRKSG/5wHERc0kvRjbTDl99CTfRRPM4UnEPh?=
 =?us-ascii?Q?4vdWDua/FFH/r2RwI+hBnKyYa96w4DK8/TNf5OUa3f90yyPQQ1fMvd+Qv+5Z?=
 =?us-ascii?Q?bMqfOzffdYGkPZDBXfdsXvx3p2JmMuN17iCVTbELmocbrB7rOa/AZgG6iARj?=
 =?us-ascii?Q?4nHNAfpzmcW5IZ7OG+QhYfG6sG/WxGQAqUpfXvMu2E/qsc6a9Z5lIce1VcZR?=
 =?us-ascii?Q?yqOUKpqpedo5qx/AWlFmnjmN1jziCbS3MHT3Zdf8iLbzIICPfb8Oryw/r9oL?=
 =?us-ascii?Q?uEUOuglZhB0RaSxCYYqnRc0SJ8h4U40UIRBVUokbPXOQsEHnZsGMSzo9F/q4?=
 =?us-ascii?Q?t4wgcoXTW2+VU/CBSLyLymmTkdn5pe3WVciWW06POuNYhbWi+XU7qBFTm32+?=
 =?us-ascii?Q?+5oEkIt0tgdMd9LvVE1Zs9CcOTzGOlOJW7cvDUEX7SgqC+5BK/k3sxiKln45?=
 =?us-ascii?Q?i6b0B5YZ8IJWTyGheIbftCuQfvLU2C+Mwe36YTkR1ztW5aZrYtgoxrhIPShC?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05056f57-982c-4a29-a262-08dcaf95c7b7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 06:15:01.8553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPpuhSMITYAzryfekCrtr6bRsjSc/4RLwFF6/iLgycgeZG6tS5YJXCWi0mo/tyefaivqeDOFQ7I2U9p/9ufUXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/sched.h:#update_load_avg" on:

commit: 124c8f43740f3f1e3e2aeecd976bcf5ddd7bd435 ("sched/fair: Implement delayed dequeue")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/prep

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed the issue does not always happen, 60 times out of 150 runs as below.
but the parent keeps clean.

a1133ac6dc7c6bde 124c8f43740f3f1e3e2aeecd976
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :150         40%          60:150   dmesg.WARNING:at_kernel/sched/sched.h:#update_load_avg



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407291328.761441a7-oliver.sang@intel.com


[   13.522527][    C0] ------------[ cut here ]------------
[   13.523046][    C0] rq->clock_update_flags < RQCF_ACT_SKIP
[ 13.523055][ C0] WARNING: CPU: 0 PID: 158 at kernel/sched/sched.h:1550 update_load_avg (kernel/sched/sched.h:1550 kernel/sched/pelt.h:67 kernel/sched/pelt.h:174 kernel/sched/fair.c:4747) 
[   13.524265][    C0] Modules linked in: drm fuse ip_tables
[   13.524722][    C0] CPU: 0 UID: 0 PID: 158 Comm: openipmi Not tainted 6.10.0-12745-g124c8f43740f #1
[   13.525464][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 13.526307][ C0] RIP: 0010:update_load_avg (kernel/sched/sched.h:1550 kernel/sched/pelt.h:67 kernel/sched/pelt.h:174 kernel/sched/fair.c:4747) 
[ 13.526793][ C0] Code: 00 4c 2b bb 88 01 00 00 40 f6 c5 02 0f 84 b7 fa ff ff e9 ca fa ff ff c6 05 b9 1b e4 01 01 48 c7 c7 34 74 d6 a6 e8 a1 c7 fa ff <0f> 0b e9 78 fa ff ff 65 8b 0d 8f 83 91 5a 89 c9 48 0f a3 0d e9 7b
All code
========
   0:	00 4c 2b bb          	add    %cl,-0x45(%rbx,%rbp,1)
   4:	88 01                	mov    %al,(%rcx)
   6:	00 00                	add    %al,(%rax)
   8:	40 f6 c5 02          	test   $0x2,%bpl
   c:	0f 84 b7 fa ff ff    	je     0xfffffffffffffac9
  12:	e9 ca fa ff ff       	jmpq   0xfffffffffffffae1
  17:	c6 05 b9 1b e4 01 01 	movb   $0x1,0x1e41bb9(%rip)        # 0x1e41bd7
  1e:	48 c7 c7 34 74 d6 a6 	mov    $0xffffffffa6d67434,%rdi
  25:	e8 a1 c7 fa ff       	callq  0xfffffffffffac7cb
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 78 fa ff ff       	jmpq   0xfffffffffffffaa9
  31:	65 8b 0d 8f 83 91 5a 	mov    %gs:0x5a91838f(%rip),%ecx        # 0x5a9183c7
  38:	89 c9                	mov    %ecx,%ecx
  3a:	48                   	rex.W
  3b:	0f                   	.byte 0xf
  3c:	a3                   	.byte 0xa3
  3d:	0d                   	.byte 0xd
  3e:	e9                   	.byte 0xe9
  3f:	7b                   	.byte 0x7b

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 78 fa ff ff       	jmpq   0xfffffffffffffa7f
   7:	65 8b 0d 8f 83 91 5a 	mov    %gs:0x5a91838f(%rip),%ecx        # 0x5a91839d
   e:	89 c9                	mov    %ecx,%ecx
  10:	48                   	rex.W
  11:	0f                   	.byte 0xf
  12:	a3                   	.byte 0xa3
  13:	0d                   	.byte 0xd
  14:	e9                   	.byte 0xe9
  15:	7b                   	.byte 0x7b
[   13.528234][    C0] RSP: 0000:ffffbaef40003d90 EFLAGS: 00010046
[   13.528723][    C0] RAX: b53834d2850b7b00 RBX: ffff9ef2efd34640 RCX: 0000000000000027
[   13.529379][    C0] RDX: 0000000000000002 RSI: 00000000ffff7fff RDI: ffff9ef2efc20b88
[   13.530029][    C0] RBP: 0000000000000001 R08: 0000000000007fff R09: ffffffffa7053610
[   13.530685][    C0] R10: 0000000000017ffd R11: 0000000000000004 R12: ffff9ef2efd345c0
[   13.531344][    C0] R13: ffff9ef2efd34640 R14: ffff9eefc0e26400 R15: 0000000000000000
[   13.532001][    C0] FS:  0000000000000000(0000) GS:ffff9ef2efc00000(0063) knlGS:00000000f7f5f180
[   13.532720][    C0] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   13.533242][    C0] CR2: 00000000577c51ac CR3: 0000000162e6c000 CR4: 00000000000406f0
[   13.533891][    C0] Call Trace:
[   13.534215][    C0]  <IRQ>
[ 13.534504][ C0] ? __warn (kernel/panic.c:240 kernel/panic.c:735) 
[ 13.534863][ C0] ? update_load_avg (kernel/sched/sched.h:1550 kernel/sched/pelt.h:67 kernel/sched/pelt.h:174 kernel/sched/fair.c:4747) 
[ 13.535278][ C0] ? report_bug (lib/bug.c:? lib/bug.c:219) 
[ 13.535695][ C0] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 13.536079][ C0] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 13.536498][ C0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 13.536920][ C0] ? update_load_avg (kernel/sched/sched.h:1550 kernel/sched/pelt.h:67 kernel/sched/pelt.h:174 kernel/sched/fair.c:4747) 
[ 13.537334][ C0] dequeue_entity (kernel/sched/sched.h:817 kernel/sched/fair.c:5429) 
[ 13.537729][ C0] dequeue_entities (kernel/sched/fair.c:6972) 
[ 13.538130][ C0] unregister_fair_sched_group (kernel/sched/fair.c:379 kernel/sched/fair.c:13159) 
[ 13.554647][ C0] ? __pfx_sched_unregister_group_rcu (kernel/sched/core.c:8759) 
[ 13.555167][ C0] sched_unregister_group_rcu (kernel/sched/core.c:8707 kernel/sched/core.c:8761) 
[ 13.555621][ C0] rcu_do_batch (arch/x86/include/asm/preempt.h:26 kernel/rcu/tree.c:2576) 
[ 13.556008][ C0] rcu_core (kernel/rcu/tree.c:2845) 
[ 13.556373][ C0] handle_softirqs (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:555) 
[ 13.556775][ C0] __irq_exit_rcu (kernel/softirq.c:617 kernel/softirq.c:639) 
[ 13.557166][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 arch/x86/kernel/apic/apic.c:1043) 
[   13.557638][    C0]  </IRQ>
[   13.557920][    C0]  <TASK>
[ 13.560463][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 13.560957][ C0] RIP: 0010:irqentry_exit_to_user_mode (kernel/entry/common.c:? include/linux/entry-common.h:328 kernel/entry/common.c:231) 
[ 13.561465][ C0] Code: 90 41 57 41 56 53 48 89 fb e8 63 90 1f ff 65 4c 8b 34 25 40 37 03 00 49 8b 3e f7 c7 0e 30 02 00 74 7c 49 89 ff e8 97 8f 1f ff <4c> 89 f8 a8 08 75 38 a9 00 10 00 00 75 40 a9 00 20 00 00 75 4b a9
All code
========
   0:	90                   	nop
   1:	41 57                	push   %r15
   3:	41 56                	push   %r14
   5:	53                   	push   %rbx
   6:	48 89 fb             	mov    %rdi,%rbx
   9:	e8 63 90 1f ff       	callq  0xffffffffff1f9071
   e:	65 4c 8b 34 25 40 37 	mov    %gs:0x33740,%r14
  15:	03 00 
  17:	49 8b 3e             	mov    (%r14),%rdi
  1a:	f7 c7 0e 30 02 00    	test   $0x2300e,%edi
  20:	74 7c                	je     0x9e
  22:	49 89 ff             	mov    %rdi,%r15
  25:	e8 97 8f 1f ff       	callq  0xffffffffff1f8fc1
  2a:*	4c 89 f8             	mov    %r15,%rax		<-- trapping instruction
  2d:	a8 08                	test   $0x8,%al
  2f:	75 38                	jne    0x69
  31:	a9 00 10 00 00       	test   $0x1000,%eax
  36:	75 40                	jne    0x78
  38:	a9 00 20 00 00       	test   $0x2000,%eax
  3d:	75 4b                	jne    0x8a
  3f:	a9                   	.byte 0xa9

Code starting with the faulting instruction
===========================================
   0:	4c 89 f8             	mov    %r15,%rax
   3:	a8 08                	test   $0x8,%al
   5:	75 38                	jne    0x3f
   7:	a9 00 10 00 00       	test   $0x1000,%eax
   c:	75 40                	jne    0x4e
   e:	a9 00 20 00 00       	test   $0x2000,%eax
  13:	75 4b                	jne    0x60
  15:	a9                   	.byte 0xa9
[   13.562938][    C0] RSP: 0000:ffffbaef40613f38 EFLAGS: 00000202
[   13.563444][    C0] RAX: ffff9ef0287dd080 RBX: ffffbaef40613f58 RCX: 000000000000080b
[   13.564125][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000008
[   13.564796][    C0] RBP: 0000000000000000 R08: 000000000000002b R09: 000000000000002b
[   13.565456][    C0] R10: 0000000000000296 R11: 00000000ff8772ac R12: 0000000000000000
[   13.566115][    C0] R13: 0000000000000000 R14: ffff9ef0287dd080 R15: 0000000020000008
[ 13.566782][ C0] ? irqentry_exit_to_user_mode (kernel/entry/common.c:? include/linux/entry-common.h:328 kernel/entry/common.c:231) 
[ 13.567254][ C0] asm_sysvec_reschedule_ipi (arch/x86/include/asm/idtentry.h:707) 
[   13.567709][    C0] RIP: 0023:0x56652630
[ 13.568072][ C0] Code: ff ff 83 c4 10 85 c0 74 05 83 c4 08 5b c3 83 ec 0c 8d 83 8d 6b ff ff 50 e8 cd 7c ff ff 8d b4 26 00 00 00 00 8d b6 00 00 00 00 <55> 57 56 53 e8 e7 61 ff ff 81 c3 13 38 01 00 83 ec 0c 8b 44 24 20
All code
========
   0:	ff                   	(bad)  
   1:	ff 83 c4 10 85 c0    	incl   -0x3f7aef3c(%rbx)
   7:	74 05                	je     0xe
   9:	83 c4 08             	add    $0x8,%esp
   c:	5b                   	pop    %rbx
   d:	c3                   	retq   
   e:	83 ec 0c             	sub    $0xc,%esp
  11:	8d 83 8d 6b ff ff    	lea    -0x9473(%rbx),%eax
  17:	50                   	push   %rax
  18:	e8 cd 7c ff ff       	callq  0xffffffffffff7cea
  1d:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  24:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  2a:*	55                   	push   %rbp		<-- trapping instruction
  2b:	57                   	push   %rdi
  2c:	56                   	push   %rsi
  2d:	53                   	push   %rbx
  2e:	e8 e7 61 ff ff       	callq  0xffffffffffff621a
  33:	81 c3 13 38 01 00    	add    $0x13813,%ebx
  39:	83 ec 0c             	sub    $0xc,%esp
  3c:	8b 44 24 20          	mov    0x20(%rsp),%eax

Code starting with the faulting instruction
===========================================
   0:	55                   	push   %rbp
   1:	57                   	push   %rdi
   2:	56                   	push   %rsi
   3:	53                   	push   %rbx
   4:	e8 e7 61 ff ff       	callq  0xffffffffffff61f0
   9:	81 c3 13 38 01 00    	add    $0x13813,%ebx
   f:	83 ec 0c             	sub    $0xc,%esp
  12:	8b 44 24 20          	mov    0x20(%rsp),%eax


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240729/202407291328.761441a7-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



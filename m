Return-Path: <linux-kernel+bounces-181776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8868C812B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1385028292C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0315AE0;
	Fri, 17 May 2024 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDGJyLKN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C514F64
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929570; cv=fail; b=uC6+h9UZDA6gNzH0kWufSF1BJ1KCoBE3di0PvGkeTO7mYxjiqiDFKNseR1dbPaPWYzxHWzJavXqtPTf21AxPk2TtGU/Ak832r2mPS6CYI255rslBOJB0YkOgnGJaoTivqbRxhvrEea4G6M+0gR5VRl9JYiEcpG5jmsV+/ZH3xps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929570; c=relaxed/simple;
	bh=2oEmcArWbqq3+ALEJ0Z1hP3UjNqGcLLs5cRm0AajHeo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zx3Akv16yJecxQdtj+4NbnKvtzuethx8RrYAhfregJjgiFqXof9TRNE1ArgQ7oyxZzQ91v6VthvokDvRV6ENoAul7nLWo6x7yqO06Zc5cLwPr8vUc35aEV7CeCY23fWeWeGAYN5RdMXFIzPjWCV4magwTeE2y2i7KUodHxhxJsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDGJyLKN; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715929569; x=1747465569;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=2oEmcArWbqq3+ALEJ0Z1hP3UjNqGcLLs5cRm0AajHeo=;
  b=MDGJyLKNavdp2m2H8jHDgyok2jKh2fQdq9/SjxU6S6eRZJCet0yKPnQu
   avlZz8eLy7khN/j/UF5zBXEIo3tbsr8jRodn5TfkChoyLuzXrdz7rZc6J
   Ck2PStqocXO7Lviw2XW++shXin6Y4/XvX8NjQhPIMldpCn5lkKlZOeoyy
   EJbGcRvhfbW2AeTmgSwHSWnmYutKeDqQAWqWjFwV0zPZIskxULJBsZE2H
   yVE1bbAx9925r218nmpPytzr0DMaPx+A13QeSyA0C4MqyLXEbAMq31jRp
   8fjoPNdmVtl6IVirIIOY8KIWFnoSuiGy0lZPStbB1wyYzdgXR1WSLl6FO
   g==;
X-CSE-ConnectionGUID: 3ddI3kTyRXql/flSvn5yrA==
X-CSE-MsgGUID: o8LXszsgRZu+bgrDLvwuWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29591171"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="29591171"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP; 17 May 2024 00:06:07 -0700
X-CSE-ConnectionGUID: Tpc10Rx5Tl2Y6ZLPDOwQrQ==
X-CSE-MsgGUID: 0gT9MMVfTSWlbu76wa0iFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="36601547"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 00:06:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 00:06:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 00:04:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 00:04:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 00:03:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ftqq4CHLVrSU6WvonIsqNZRhxyH5B3yItqU9sxGifGsjZrr9KH2Jo7o1GpANP99wqE12Cscqqi7xsGddUcbiojWiHdsdqaufNaajhRl1h9J5FsS/eQnYsrxSRYslxALs5oOVGKZb/W4hteYFs2WYis5LV0NCEViQpH46IL0uQegNfOzUYuxzug3rcaZQmqaAUxQiBDQ3ueJMmpUU3//mUsbWwm0UTo1FCFoL3bdbE/6BTZJTcZqBGj7BtE5j+Xu4wEy7tnf0VEds9h1YJ0qbpbX/JUPz8gHFxk8zDdgo7ibZpRr+NPHLM+ZSgU7UaNBB6YSMl8FPprQ9Frs7SDT02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjF+ODJVL5/Kw5T3fuSOo0meDpTmRTYvSE+WxlPAwB4=;
 b=ecaUgrzt6xFwiYWrx5nbQvUj3FW/Gl/z5crNpuKF+dXYRAA9koW98PPY5vq7XSlr7efL7zzPN8gEV80SfE4RF0zhVurLp9cJYy+n+lLi9BfSGLii8qbPRMn47757bdlMCFtr2aMhbx38kzi0fU9V6X+HpRfL3FCDdgxKZJ0OObs0UJywOFI/0oWp5pW8ByN78THGudGwDMbC09V83JjdF6b5NZi+hOgH5AAgmdCDx+bNHlTfuKG4jo/34ltDOPi86gOCYCZXALKGDmxl9gC28YpbbnmYHSm1T+F7TeNbYd9sgtpGaw48a7Oqvdq18TZwMP1RuEKMdJigzSTdzbYVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 07:03:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 07:03:30 +0000
Date: Fri, 17 May 2024 15:03:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <shy828301@gmail.com>,
	<nao.horiguchi@gmail.com>, <xuyu@linux.alibaba.com>, <linmiaohe@huawei.com>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved
Message-ID: <202405171417.1bb0856a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240511035435.1477004-1-linmiaohe@huawei.com>
X-ClientProxiedBy: KL1PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:820:f::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 9193af58-f4d1-4b6a-45fb-08dc763f7548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ipHMleD6VPGf1PLqmyEy25qxIbc5qOHnt8kEC7eosbNsXLjGwF35kjFUPx14?=
 =?us-ascii?Q?GEJlX4ogx7X8086qLuWNms8AJ1b/xfAeoDRecXtaI0QybbYaxw7LpFLB4fRw?=
 =?us-ascii?Q?+12HHcHivG0BzI7jCY7i8MuRO7wY1wEKQAOpl8huD/WdeE8teejZpk+UpM3I?=
 =?us-ascii?Q?gZ5sjxw8vrDcGCKlGyEujXyWNLyL/r8/7m6nyjHWcuftzEH1U8QzYH1rLxQh?=
 =?us-ascii?Q?DPLeK+Oy9g/dJ5tkD4XNbESq8x05/0rd0vEtIeeayAvvkxL8uACEJkWBupal?=
 =?us-ascii?Q?aFpFDhbM4X5Z1z+UoBeCKeaVvg0327UQ7poENk9CD2BT/kjuulHuwB4OIgz6?=
 =?us-ascii?Q?IKAclShTI2XnbpWg4JZb6BSV/zZFAOwE+DrW1jpMIi8kNfIhvABgododvbmJ?=
 =?us-ascii?Q?EZZ0Qi93htMjsk7LWwbbofvjhUciNfhRcP4Z9z6RUl+hbkKBUR6mdB7C/opc?=
 =?us-ascii?Q?Xz4D/5znICfXqCOm0lTFc5VZfJGoHthr/zEStgjyKLJzaesGExF/7D54qBUf?=
 =?us-ascii?Q?ZGzHPn0RmWdMQRF99YcPqSk8f+hE39KMcz/LTOOHp/DpBYe/sFD5WmnZztRm?=
 =?us-ascii?Q?o/Jbqi5jMNqcykNroPB+8R3kwkY+gbmiWQdtPuSgFtoyKGWuGZhpFzET75aC?=
 =?us-ascii?Q?/U7TZEL0yRDvkCeBHviox97qqv74mS28YTEhgJwcSBP6jg7kaiB7ToxRU3Am?=
 =?us-ascii?Q?WvOc2ID8EPDaF9+d6KN4qcWa8SXd8dVD/lTQt4YxXtk4C1VvumoOuqg1Dv+l?=
 =?us-ascii?Q?Tu5+f0VxbizYiTXumY/VUvJnz7ZreXTPTwaRbRry7W5TPY1BaGBpjEcZ01jp?=
 =?us-ascii?Q?29VL4HLUM31o8dyo8Ae0nekRGk5cs/Ki/T6h+DrZSKzzYn1iZUW1/uhbf3Rm?=
 =?us-ascii?Q?m4+5ZwbuEY6DpbKLxBLa+LhLYrXzfo+wTZBp5wQbsfMHMa8vs0lm8Nrsemb/?=
 =?us-ascii?Q?RviqIQ8lUzgpCnUkdtnhNAZIMLj+2CDMI2h64aMdd90c5od7uG2mMGrg/9v6?=
 =?us-ascii?Q?j+Y65GFhe/Rm+M/kwGbmWqIyGZiTxPC2EIuHQXwrh6t7AwLbRV8QeJ0LfA/t?=
 =?us-ascii?Q?59OS//nNqVfyjR4HeHVeaygsmzPbuoAIBjqTktv0WXC/SRtfIglzn7SpE2LD?=
 =?us-ascii?Q?XzPE5M5cvjK5g5ZdwjRWFQmNuAJlfVylvjkTvU6yqGdyGyTpnhilqVoVkXPC?=
 =?us-ascii?Q?PHLMP893O8bCYoa/mmpAq8GRusMIBucNaXtSfyKl7SCn+jGHcQec3yfP2xk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6UYB99OLUX0plfsc1aC6xSMJ5B2Pd6t6/Rimi7ftK0/uCBAO2IRs63Meuoky?=
 =?us-ascii?Q?srCT/o7PKlK/dEdKaNoC+hloDFB4n4AhpzbUoMMW0NKAef2GNsfAhFL2D+zj?=
 =?us-ascii?Q?HuWojbAWhqGLBe8gDbQNdh/DvZviL5u/F+wPnGmBgVFf4E0HE/vTLkeK3VJK?=
 =?us-ascii?Q?AeIEFiCo3x6IFBXWMkJs3yx92hhA7vRY87iid3YAhrn8dCLSq9+X1aRS+nL0?=
 =?us-ascii?Q?Bs4W96DYPGhUUm0fPuON97KtxRJWdJbi19vWmXsTwLKtJ7kqIwDdjHB/4dWy?=
 =?us-ascii?Q?bK2kLXE/PceNWOTKEzAjMbKPxPs7RHiiI9uv0zF/EyuSL9Vkpqpdl/IVVNze?=
 =?us-ascii?Q?GEG4RGy2LPJeBmXGjyKPAl+aPjGZdeezBed/xOHxZqkdZv87JLMNei7o3zb5?=
 =?us-ascii?Q?WNUFI58GV69P/c/QUT7WrVXpoJvh1TDIFgbUPIFvJvm6PsGrdaqfYedlf/Vy?=
 =?us-ascii?Q?XqJ0Rr02xEHGHx3IravI8BtY979jCiI3oDyFChUf95cJDfkxBRO6chsZE4QE?=
 =?us-ascii?Q?JxyYGvR90VCbZ2nevZf6AHyTH+HiBQ/F56QI+AizSgnMFiYctrjWlFy4CWV8?=
 =?us-ascii?Q?2VK8SimMBB+Od9grKNsY5mukhaWLgRQ2wHyIKaYjFNrB1iJL3DJZnsxZt0lb?=
 =?us-ascii?Q?5GTHbctYqpIRFQWCs1NvTBDAyOJe0uk9qxnNe5SIu9xCp3vqI/IPTNlHFAtr?=
 =?us-ascii?Q?sMGfbbAHutvRZyn2vjSVfMOOvlTmBXP1LMqt/YTGzrKer+9oZMNFTC67xC5v?=
 =?us-ascii?Q?VCVEPSSfdK96xH45dLli9uGPT6PJI+cHluUj/d+qlpmkbNAGuWgwly0xM1uL?=
 =?us-ascii?Q?Vkd/T/KO0DHi87THbXFaz42zZZbQ8zxpmBhbZEhnxsFdUKDNwHHgoeG/MLyK?=
 =?us-ascii?Q?DeDO2ziOTauFnUbRqixKOp+u4UoEWQD+L1p6PKRr+J4HAqCyXNsAszCJpl3G?=
 =?us-ascii?Q?ve8Di3ICd8waYdPmADnR06raTCgdgMw1fYn+AvagumvuLTo0sUecnt4W4d8E?=
 =?us-ascii?Q?TVK0BvIlBqytcMO+a1Z3xMfavDurmuQTYEySdVQWC/J9nTqq60y2W2u/mOHI?=
 =?us-ascii?Q?VCk97d+VhitrNUtc0W3gLJAg0ywS0uD6tu21RrudkxbeJhBZr4VD9TdLRAal?=
 =?us-ascii?Q?XzpRR6IUkLHqGRSYldZanvqSGzRaZVhlL+pF8wmXWWCVYxsQe+d3NrSAHYRZ?=
 =?us-ascii?Q?v8s4URseLeyPhe0KkgvJwQiaPXdGsz64dE6YxQ7p49U3BLCuxRl8S5zrtPQB?=
 =?us-ascii?Q?ZvmVpyMWCkqpawkqyy/BZpNShgRWNtQoGw2FFII7/jAATykQT2uGZNF2fMDZ?=
 =?us-ascii?Q?4X50TLP2Jb/JFMQGDYjuhX0W5lhhC1ASpbP5CtRV+TdNalmjs97OfbHH6M/3?=
 =?us-ascii?Q?u1dmj+0p9KX4f6x+z7MektS62fjwM2MTIYx+4B+ZbJwTFqt/gYU39n+obQIU?=
 =?us-ascii?Q?OWpSBl9KdPsKtUeWKHWeCQJPa2S9PCFTv9HjYwuNrmgl6jgdb6XkL6UT1BA0?=
 =?us-ascii?Q?aUcQBicipWSU8VR7Kjqt4c33lfaoVj7et1QrGp/NpDBLLu3Da6ENyDDOHoBL?=
 =?us-ascii?Q?Gx5zOFf0BhbGG33eQJ6JMUs9YyAoxj8tE+nst/Hrv96Z0pQEEQO9hA2ukahd?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9193af58-f4d1-4b6a-45fb-08dc763f7548
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 07:03:30.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqcKu5vR6oy3uMadNOVC4pxQA+mWeexhTnwE6HH4zIL/Q1J2eEB5VxY0tTHALm9dkllNz6RoTrj6hzzHzJwFIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:

commit: 8e6ff9c4aad2c677c53f70d9e193c35cbbafcb88 ("[PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved")
url: https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/mm-huge_memory-mark-huge_zero_page-reserved/20240511-115840
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git cf87f46fd34d6c19283d9625a7822f20d90b64a4
patch link: https://lore.kernel.org/all/20240511035435.1477004-1-linmiaohe@huawei.com/
patch subject: [PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | cf87f46fd3 | 8e6ff9c4aa |
+------------------------------------------+------------+------------+
| kernel_BUG_at_include/linux/page-flags.h | 0          | 11         |
| invalid_opcode:#[##]                     | 0          | 11         |
| RIP:get_huge_zero_page                   | 0          | 11         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 11         |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405171417.1bb0856a-lkp@intel.com


[  272.633454][ T3838] ------------[ cut here ]------------
[  272.634362][ T3838] kernel BUG at include/linux/page-flags.h:540!
[  272.635422][ T3838] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  272.636518][ T3838] CPU: 0 PID: 3838 Comm: trinity-c2 Not tainted 6.9.0-rc7-00184-g8e6ff9c4aad2 #1
[  272.638008][ T3838] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 272.639707][ T3838] RIP: 0010:get_huge_zero_page (include/linux/page-flags.h:540 (discriminator 1) mm/huge_memory.c:211 (discriminator 1)) 
[ 272.650951][ T3838] Code: 04 02 00 00 00 65 ff 0d 0a 0b 75 7e 74 1e 65 48 ff 05 50 e5 74 7e e9 5c fe ff ff 48 c7 c6 a0 bb 52 83 48 89 df e8 64 89 f2 ff <0f> 0b 0f 1f 44 00 00 eb db 48 c7 c6 40 bc 52 83 48 89 df e8 4c 89
All code
========
   0:	04 02                	add    $0x2,%al
   2:	00 00                	add    %al,(%rax)
   4:	00 65 ff             	add    %ah,-0x1(%rbp)
   7:	0d 0a 0b 75 7e       	or     $0x7e750b0a,%eax
   c:	74 1e                	je     0x2c
   e:	65 48 ff 05 50 e5 74 	incq   %gs:0x7e74e550(%rip)        # 0x7e74e566
  15:	7e 
  16:	e9 5c fe ff ff       	jmp    0xfffffffffffffe77
  1b:	48 c7 c6 a0 bb 52 83 	mov    $0xffffffff8352bba0,%rsi
  22:	48 89 df             	mov    %rbx,%rdi
  25:	e8 64 89 f2 ff       	call   0xfffffffffff2898e
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  31:	eb db                	jmp    0xe
  33:	48 c7 c6 40 bc 52 83 	mov    $0xffffffff8352bc40,%rsi
  3a:	48 89 df             	mov    %rbx,%rdi
  3d:	e8                   	.byte 0xe8
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   7:	eb db                	jmp    0xffffffffffffffe4
   9:	48 c7 c6 40 bc 52 83 	mov    $0xffffffff8352bc40,%rsi
  10:	48 89 df             	mov    %rbx,%rdi
  13:	e8                   	.byte 0xe8
  14:	4c                   	rex.WR
  15:	89                   	.byte 0x89
[  272.654159][ T3838] RSP: 0000:ffffc90001507988 EFLAGS: 00010246
[  272.655196][ T3838] RAX: 0000000000000000 RBX: ffffea00068d8000 RCX: 0000000000000000
[  272.656504][ T3838] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  272.657799][ T3838] RBP: ffff8881b94fdf08 R08: 0000000000000000 R09: 0000000000000000
[  272.659142][ T3838] R10: 0000000000000000 R11: 0000000000000000 R12: ffffea00043fb100
[  272.660533][ T3838] R13: ffff888109ecdb08 R14: ffffc90001507a70 R15: 0000000000100173
[  272.661849][ T3838] FS:  0000000000000000(0000) GS:ffff8883af200000(0063) knlGS:00000000f7f1a280
[  272.663303][ T3838] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  272.664430][ T3838] CR2: 00000000ff7fffff CR3: 00000001ba4ca000 CR4: 00000000000406b0
[  272.665759][ T3838] Call Trace:
[  272.666325][ T3838]  <TASK>
[ 272.666824][ T3838] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 272.667483][ T3838] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[ 272.668253][ T3838] ? get_huge_zero_page (include/linux/page-flags.h:540 (discriminator 1) mm/huge_memory.c:211 (discriminator 1)) 
[ 272.669128][ T3838] ? get_huge_zero_page (include/linux/page-flags.h:540 (discriminator 1) mm/huge_memory.c:211 (discriminator 1)) 
[ 272.669985][ T3838] ? do_error_trap (arch/x86/kernel/traps.c:176) 
[ 272.670793][ T3838] ? get_huge_zero_page (include/linux/page-flags.h:540 (discriminator 1) mm/huge_memory.c:211 (discriminator 1)) 
[ 272.671731][ T3838] ? handle_invalid_op (arch/x86/kernel/traps.c:214) 
[ 272.672551][ T3838] ? get_huge_zero_page (include/linux/page-flags.h:540 (discriminator 1) mm/huge_memory.c:211 (discriminator 1)) 
[ 272.673411][ T3838] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 272.674224][ T3838] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 272.675064][ T3838] ? get_huge_zero_page (include/linux/page-flags.h:540 (discriminator 1) mm/huge_memory.c:211 (discriminator 1)) 
[ 272.679035][ T3838] ? get_huge_zero_page (include/linux/page-flags.h:540 (discriminator 1) mm/huge_memory.c:211 (discriminator 1)) 
[ 272.679922][ T3838] mm_get_huge_zero_page (mm/huge_memory.c:235 (discriminator 1)) 
[ 272.680764][ T3838] do_huge_pmd_anonymous_page (mm/huge_memory.c:1020) 
[ 272.681694][ T3838] ? mt_find (include/linux/rcupdate.h:339 (discriminator 1) include/linux/rcupdate.h:814 (discriminator 1) lib/maple_tree.c:6954 (discriminator 1)) 
[ 272.682432][ T3838] __handle_mm_fault (mm/memory.c:5175 mm/memory.c:5412) 
[ 272.683260][ T3838] ? handle_pte_fault (mm/memory.c:5352) 
[ 272.684150][ T3838] ? find_vma (mm/mmap.c:1889) 
[ 272.684891][ T3838] ? vma_link_file (mm/mmap.c:1889) 
[ 272.685676][ T3838] ? handle_mm_fault (mm/memory.c:5576) 
[ 272.686461][ T3838] handle_mm_fault (mm/memory.c:5466 mm/memory.c:5622) 
[ 272.687265][ T3838] do_user_addr_fault (arch/x86/mm/fault.c:1384) 
[ 272.688116][ T3838] exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1482 arch/x86/mm/fault.c:1532) 
[ 272.689202][ T3838] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 272.690523][ T3838] RIP: 0010:rep_movs_alternative (arch/x86/lib/copy_user_64.S:57) 
[ 272.692228][ T3838] Code: 83 f9 08 73 25 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <48> 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08
All code
========
   0:	83 f9 08             	cmp    $0x8,%ecx
   3:	73 25                	jae    0x2a
   5:	85 c9                	test   %ecx,%ecx
   7:	74 0f                	je     0x18
   9:	8a 06                	mov    (%rsi),%al
   b:	88 07                	mov    %al,(%rdi)
   d:	48 ff c7             	inc    %rdi
  10:	48 ff c6             	inc    %rsi
  13:	48 ff c9             	dec    %rcx
  16:	75 f1                	jne    0x9
  18:	c3                   	ret
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  24:	00 00 00 00 
  28:	66 90                	xchg   %ax,%ax
  2a:*	48 8b 06             	mov    (%rsi),%rax		<-- trapping instruction
  2d:	48 89 07             	mov    %rax,(%rdi)
  30:	48 83 c6 08          	add    $0x8,%rsi
  34:	48 83 c7 08          	add    $0x8,%rdi
  38:	83 e9 08             	sub    $0x8,%ecx
  3b:	74 db                	je     0x18
  3d:	83 f9 08             	cmp    $0x8,%ecx

Code starting with the faulting instruction
===========================================
   0:	48 8b 06             	mov    (%rsi),%rax
   3:	48 89 07             	mov    %rax,(%rdi)
   6:	48 83 c6 08          	add    $0x8,%rsi
   a:	48 83 c7 08          	add    $0x8,%rdi
   e:	83 e9 08             	sub    $0x8,%ecx
  11:	74 db                	je     0xffffffffffffffee
  13:	83 f9 08             	cmp    $0x8,%ecx


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240517/202405171417.1bb0856a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



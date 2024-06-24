Return-Path: <linux-kernel+bounces-226891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A491454C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5571C2120C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B917E76D;
	Mon, 24 Jun 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngQixEpd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705812E1D1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218963; cv=fail; b=N+nuanoAZaUByjP9+kQemZOIqwgAm7jawpMfx8faO6/ifThP4C6q2r3ESudvCzfgVPs639hgrSUhkV6MyWZO1Czk9wd9kWSUoR0cHRHu1Uaosh9Jh/6be3e0y9KuC4wqWrMNuZLEzmSgG/nwFErrxMTe9g/P3Zmadma1NDkJCsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218963; c=relaxed/simple;
	bh=lbK02vCA7CyOYfhuVVZa4zxwwFZncQEJv2zLdH5Jh7A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=F1D1N0+M6ZcYPxM9VdDTAsjdbnxba/1qx2w06vYIygtnF8ZJcM+Ks4AO+BNpLToToRu6uutvesyGjHyDZNelJRdSWjbm8oeN6J8aE3kmOjwjbO5rHsqhx/UaWw85p0WCVxQkijJmH/7HyYFkhrIr/3jjnjPgyBHWQfaG7bDIUOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngQixEpd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719218961; x=1750754961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lbK02vCA7CyOYfhuVVZa4zxwwFZncQEJv2zLdH5Jh7A=;
  b=ngQixEpdatdzCV3CdwJ/GaL0avEMhqKH3heqA7D0WyBtn5PGZ3QJ3im2
   OwyOoxBBbqlE+2QzatRMAdJt7RjKk4ySjKyAL9wiK5XH9oNdDPIQMx7tX
   OIs5Zi1dWbJrJ+oB7pOe6JNJTA4XvV59VSWyXjheO76kjFG0mKH1n9nT3
   jhTBaP8voDvmjNNgCENMtsHIk3DaPIX15CCGVqEY1fbSfvuVSqG7OIBBC
   X+6fg5TqkTQzkJYwed9s2BHCtA4ldYTYF6Dw4YmXxxXPARWMBWHfPcag/
   FgXYWWlXgdw3wsd3NB7pXzsfg2S2TnHmK5iJskoCr036LQsb8neQBux20
   Q==;
X-CSE-ConnectionGUID: uRx/Xjp9S4mM/joWL9dk5g==
X-CSE-MsgGUID: s/7SUtFYQoCc/P7OBIVxzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16322226"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16322226"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:49:20 -0700
X-CSE-ConnectionGUID: dW86TEcIRbmygaax51CuFw==
X-CSE-MsgGUID: tpa0JKaOQDqAkcAlDCCpmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43105641"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 01:49:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 01:49:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 01:49:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 01:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrKiguUKpcmdlluJL4GaEpgZ2v59Msrcmted+kdzZeSCpjJcbXlOIdlOaWTeaFF8hpqKi9x1yltq3cMSawmc9ttwhjv/ARAhHP1eGZPoX9WsBEZ2EnhR3VqeD+us9w6ZmGijD3dwJd6GiK9VATgFrh2eBzedBZg3A/B0Y5uQAEPBiSdw9Cq8diHwu4npWotQtXDASXlTX29z1bYuMKaSJTsTrw+a7M+X5wIaxzmACKde78y7GFcVtS+UlPvne/9wyatLAqqPopVPLs+2r8qRgH+3OpWOg9eOnNYlJlF8UpMCaaQ5F5XScP/pJhVvJx4sxjJPdF2ju+V1b9VfCLFbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB2tuf8jo0CGHY41pyPKXJA+NDk2C4rQvpN/6jtD0hU=;
 b=lby5urHnpolDNGWxbvngFI3LA5n6b6wUPnTv00jrZKZHaqXNzPS6lEY3uPCDNIzs9x7Cccr9lznEfaWRSIBIJsGoUL/AbxHe1nDsRAUjhAnrHNhaxpivhmNdTv9KE4CFhM1MUmcCqGgfO/FF4hZoZoklXvaenEjoR1e3n0yNiDmiIEX8BbgEf4gsOzuuvHG0m6SATBwtQuq8sujp/u/it0lucmSrvCIyNaH3Zlf7YxzlA6P4IOCUwd6UkVu+m7KAHQq4cqScU/P2w7XEQjtiVqK1I2crpyYYzSRD3/vX7ThDcHJvFJaz63eiHLTPOzFR1asI94GbIIu+urF3vjv2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8561.namprd11.prod.outlook.com (2603:10b6:610:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 08:49:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:49:17 +0000
Date: Mon, 24 Jun 2024 16:49:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Usama Arif <usamaarif642@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Chengming
 Zhou" <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, "Nhat
 Pham" <nphamcs@gmail.com>, David Hildenbrand <david@redhat.com>, "Huang,
 Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Shakeel
 Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
Message-ID: <202406241651.963e3e78-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3970ca-f3b1-4d2c-23c9-08dc942a87f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wp4NWrgLK36IXeZNKZ99Z87JxC83qdB9U1eNGNcYGkJTVNFdQ4fwhb+htiBn?=
 =?us-ascii?Q?hym/DmnKREjMIi6UuY6smHrrhxc9vo+7fg350g82JsbZjpmiRunDqXx8WtW7?=
 =?us-ascii?Q?xeuXXRDylDnOCgDRo1I7PPFhOby/cRJq+7Qm8ElOWJohMCw2mVBBTIXeUE3W?=
 =?us-ascii?Q?TUSjMq5mZhUiitaIZeq+QJnD00wSVE39iKBJCSWqXsldnguIAmT2+fbRS1AL?=
 =?us-ascii?Q?XPM+bTry8aY0Z83uf7B2nHsAqUFVptcS4mNljsJ1FdbMsByO6723Xw/DYUFc?=
 =?us-ascii?Q?438kf0dNnrjcM3Jam9o7xdYjsrO+h0O4MgcUobBT3eCeDBWExJ6FRDsXY+0B?=
 =?us-ascii?Q?HdhVU4G8cEX1duiC6kgc2FCInydyeGyTVrGfvAYM+si3F7BLMpW2qIFVpcVl?=
 =?us-ascii?Q?VaAHiZTwszQz2fppkRX0ui4wImyHfky56UkG4QGm927VzOAv20umTAKMO+mJ?=
 =?us-ascii?Q?gUto+7U/28HH6Po/Q84K2wQR500lmO7XIea0gu0QDdUUKblQJh01nV96B5HJ?=
 =?us-ascii?Q?n+Z+0LAvUG5tOcaCaGrziKYWpxMHFVG0igQCs+MLPt1xHvEHxX24/OFClIB1?=
 =?us-ascii?Q?NZULQ9QoPtRPS5m1/F3vzqOf1U8bNWwzTrjuQSOArTa/DGh0rBXpLCO47Pbe?=
 =?us-ascii?Q?E7hGhmqEbwTulba0DVfwbZx7hpd8/UYc2hLtj4txJBizKKolLF4cBjFIMR7i?=
 =?us-ascii?Q?NDY4w95yl898OZ8ir8HdWoBV+hwgFcjwO9RCHN+eJp7Y7WkKsJJLUNskRUef?=
 =?us-ascii?Q?fkGfHGw24TASgMD/19Z4D2SEd234bop/zt0Fh3hMxJUIN3rITwXwSTkZmefr?=
 =?us-ascii?Q?jf263uGpeg7mr2Tr76GOGmFyL1t+L+VWs6risSriChY6ucuc4mc4y6xpp6sX?=
 =?us-ascii?Q?rS+Nybb/URPLLYKP2RxjEVZwtIs89xADZqc8oMfll/GPVF13NWGGPEc9ra6C?=
 =?us-ascii?Q?NBZl/KOHjmhm1/nMVAT7jkOEFqkK4NTTjwsc0acBorFEXfolGDYrrfRq4dDZ?=
 =?us-ascii?Q?zsS5Lza9K4hzDelxvlFsr+pg71ewtlK5x/LdhMICjdkqMNQgCMZRTBfU+sIs?=
 =?us-ascii?Q?YGoMk8n9HvX5PBmVVPO5Jzq2pIdeCYtCCEW3RWcPQIzyNhnagihq6kmiIpYs?=
 =?us-ascii?Q?PCKvr8thSIoBK/DMWwenev1GJs2EDdV1UaBqKjBfMk+adZn1VVnCVu0FjfHx?=
 =?us-ascii?Q?hK7LvBBu7wZTyXhwfYGoa2WV0V3uBGnLYW+PsPT+1cUyJQc0wVPDGNYBc3P3?=
 =?us-ascii?Q?fsq1kTLrlA7NvBuLv4NPalvLUi0uZpGZN8iHqQDo8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pr1V8URh1WEzI1L2/0Wxxi/uMUsT/d5RxNS9jKIWj30rtcLcI9SoZ+4ETwXd?=
 =?us-ascii?Q?+WrYMnSj2mGDVQSKUHQWg2tfqoCRLI3CT8hzweErwS2kj7PrJcStd08pQA9D?=
 =?us-ascii?Q?/+uhyNMqzxSp2VKHKe4t319OeE4np5J4UZSVjJMJ8vmA42A52pmOI8t7fsoc?=
 =?us-ascii?Q?UycBROn+qhJa3hLFGK4oWbonXsWk/14j7ugiFV0InADAPpoYoXBi6/7I+zAZ?=
 =?us-ascii?Q?VWNdUII1XZ+cXzSYy/c6rN9XQcJeH7GZ94Uinz5+WEkiHDGHDmRkSOyM+NdD?=
 =?us-ascii?Q?ao4nfpHAT9VhS42JiW+oFe2Drr/aY3yZShnAXQPyAV6BS7nhKR41QT2DLK9G?=
 =?us-ascii?Q?sylld1i8D3J5BDJlTi+4wezoTIy/SLiDicXM6aglPu7ONtWi+TZvu8qottSn?=
 =?us-ascii?Q?/8mQlsPdEiiPViQQtW/zXakitMEexMEUlPU6qj9t7WU163l28mVV7Mvy66uC?=
 =?us-ascii?Q?jiGuJrjlI6nDITHo2lADCELtoggj9CplFiYZMpzfw/KvVvLtRKu7TIbep9ox?=
 =?us-ascii?Q?UNDYT+mdwCutnZZA5bhGfGXS4NwBFp5JCiwDWopHe45CdtOJqm8qvlJ4yEO9?=
 =?us-ascii?Q?0lhY5Y+a6/qmt2BKob8yGn3J7YKXb0n/OAewVNPYKigfhzoB2ay6GH7Dofmp?=
 =?us-ascii?Q?AnFQ/GN+rmmoiBIx3DGzU//VhlpmJhYi//x3Ucsnea09t2ZEcyIHiLH7IZ/4?=
 =?us-ascii?Q?2a1dQ3Dk+oro71Sx/0DxylXr5bjmeSxVW7Pg6dIPsPeeHIlM8eAlmsaz3BVH?=
 =?us-ascii?Q?9chiwskYIzuKF0EBlwSUWjGUTQuQVXXUs7I/+inSAHf8jz3Ond2DII5RLIgo?=
 =?us-ascii?Q?5rms8CqkoiLSWmpoTTNcMCKz0Pc/AOsdp2i38YVlQ+xh3EMXfHi9vVL7OX39?=
 =?us-ascii?Q?W6oXYktsz1WB9eVFBhy1DGTc57xp7FP2poKrAnpmTYn1YZnRhoNUL8wwmU42?=
 =?us-ascii?Q?emtJpkHgP6GqxZs+OnuC1o5/crahODtmTG6MwvrqsRKJjpuCSGViWfjylosg?=
 =?us-ascii?Q?Z75fCNWZQ6YIBwo/4D51ubr6IZU7sxRNcPSgGpYr+hDHrW4zJzjM1zaX6wfY?=
 =?us-ascii?Q?FlGjyTk79Gym3wLXtDO/DT3M7BJhcUUyVEO5P7YUFN3mJ7fmyUUoOOYqib7u?=
 =?us-ascii?Q?OR89aY9JdGM/nYRzSL/j6M6BWxGkS/5lpX53WlOiloOHSK6t9Es2xZWEb1TH?=
 =?us-ascii?Q?Aez7bEJ9txz2o/9nrhO90ret0mOC4QRfTXjKLd6mNbwJJLN8Iv7KozH3WtyF?=
 =?us-ascii?Q?GBdKarG9ngjjn9yzp0ivbKBXk0OPMGH52soIeUQD0gr1Lkd6dcfcAi/mcgaI?=
 =?us-ascii?Q?8eV2dDY2uc2KVJ0eHsydexeruG/7zBB//m8bJltPUs0RZ+QXwp3KywDVPAC6?=
 =?us-ascii?Q?3IcNTUR5zFQFB5a8xC8hwOHaPWDxxBP1+TbVkoUTUhfk8JQdFgDUdxTn2L5u?=
 =?us-ascii?Q?x2Z2ZLunoISDYvg7hyqO2sIXZw1/xZ9x5oyjjMqrq1gY3kwiBoYKFQw7vY/y?=
 =?us-ascii?Q?TeOZqXdZYv6qKrYwSDR7J4Z8rX0s4Ako/RyjLe9t0TDtraIyHcG5zwuYr+vo?=
 =?us-ascii?Q?IHWl/+3d5fLdMGRwEI3Run6Pc11MjBhzFRlZtlzufTduTjQl8FsRh6SM33eo?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3970ca-f3b1-4d2c-23c9-08dc942a87f6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:49:17.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9M3AiSx97V7WiY4agaukwLvboCuVmJWpI51roSO1BEhMd6LWzVHQXe+LzLmc4utOANkdfGeprN0qqDvHDM6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8561
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof" on:

commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pages to be swapped out in a bitmap")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master f76698bd9a8ca01d3581236082d786e9a6b72bb7]

in testcase: vm-scalability
version: vm-scalability-x86_64-6f4ef16-0_20240303
with following parameters:

	runtime: 300
	thp_enabled: always
	thp_defrag: always
	nr_task: 32
	nr_ssd: 1
	priority: 1
	test: swap-w-rand-mt
	cpufreq_governor: performance



compiler: gcc-13
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406241651.963e3e78-oliver.sang@intel.com


[   34.776816][ T2413] ------------[ cut here ]------------
[ 34.782497][ T2413] WARNING: CPU: 11 PID: 2413 at mm/page_alloc.c:4685 __alloc_pages_noprof (mm/page_alloc.c:4685 (discriminator 11)) 
[   34.792245][ T2413] Modules linked in: btrfs blake2b_generic xor raid6_pq libcrc32c sd_mod t10_pi intel_rapl_msr intel_rapl_common crc64_rocksoft_generic crc64_rocksoft x86_pkg_temp_thermal crc64 intel_powerclamp sg coretemp binfmt_misc kvm_intel ipmi_ssif kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 ahci ast libahci rapl drm_shmem_helper intel_cstate mei_me intel_th_gth ioatdma acpi_power_meter i2c_i801 intel_th_pci libata intel_uncore drm_kms_helper ipmi_si acpi_ipmi dax_hmem mei i2c_smbus intel_th intel_pch_thermal dca wmi ipmi_devintf ipmi_msghandler acpi_pad joydev drm fuse loop dm_mod ip_tables
[   34.849370][ T2413] CPU: 11 PID: 2413 Comm: swapon Not tainted 6.10.0-rc4-00263-g0fa2857d23aa #1
[ 34.858458][ T2413] RIP: 0010:__alloc_pages_noprof (mm/page_alloc.c:4685 (discriminator 11)) 
[ 34.864602][ T2413] Code: 00 00 00 48 89 54 24 08 e9 83 fe ff ff 83 fd 0a 0f 86 f6 fd ff ff 80 3d 8a f4 d6 01 00 0f 85 7f fe ff ff c6 05 7d f4 d6 01 01 <0f> 0b e9 71 fe ff ff f7 c1 00 00 80 00 75 61 f7 c1 00 00 08 00 74
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 48 89             	add    %cl,-0x77(%rax)
   5:	54                   	push   %rsp
   6:	24 08                	and    $0x8,%al
   8:	e9 83 fe ff ff       	jmpq   0xfffffffffffffe90
   d:	83 fd 0a             	cmp    $0xa,%ebp
  10:	0f 86 f6 fd ff ff    	jbe    0xfffffffffffffe0c
  16:	80 3d 8a f4 d6 01 00 	cmpb   $0x0,0x1d6f48a(%rip)        # 0x1d6f4a7
  1d:	0f 85 7f fe ff ff    	jne    0xfffffffffffffea2
  23:	c6 05 7d f4 d6 01 01 	movb   $0x1,0x1d6f47d(%rip)        # 0x1d6f4a7
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 71 fe ff ff       	jmpq   0xfffffffffffffea2
  31:	f7 c1 00 00 80 00    	test   $0x800000,%ecx
  37:	75 61                	jne    0x9a
  39:	f7 c1 00 00 08 00    	test   $0x80000,%ecx
  3f:	74                   	.byte 0x74

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 71 fe ff ff       	jmpq   0xfffffffffffffe78
   7:	f7 c1 00 00 80 00    	test   $0x800000,%ecx
   d:	75 61                	jne    0x70
   f:	f7 c1 00 00 08 00    	test   $0x80000,%ecx
  15:	74                   	.byte 0x74
[   34.884371][ T2413] RSP: 0018:ffa000000ce8fda8 EFLAGS: 00010246
[   34.890619][ T2413] RAX: 0000000000000000 RBX: 0000000000040dc0 RCX: 0000000000000000
[   34.898766][ T2413] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000040dc0
[   34.906910][ T2413] RBP: 000000000000000b R08: ffa000000ce8fd44 R09: ff11000104e13bc0
[   34.915074][ T2413] R10: ffa000000ce8feb0 R11: ffa0000023201000 R12: 0000000000000000
[   34.923264][ T2413] R13: 0000000000000001 R14: 0000000000000dc0 R15: 0000000003200000
[   34.931414][ T2413] FS:  00007f8ac1a03840(0000) GS:ff1100103e780000(0000) knlGS:0000000000000000
[   34.940527][ T2413] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.947348][ T2413] CR2: 000056306078b000 CR3: 00000001307f4001 CR4: 0000000000771ef0
[   34.955505][ T2413] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   34.963661][ T2413] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   34.971815][ T2413] PKRU: 55555554
[   34.975551][ T2413] Call Trace:
[   34.979030][ T2413]  <TASK>
[ 34.982179][ T2413] ? __warn (kernel/panic.c:693) 
[ 34.986427][ T2413] ? __alloc_pages_noprof (mm/page_alloc.c:4685 (discriminator 11)) 
[ 34.991965][ T2413] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 34.996643][ T2413] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 35.001163][ T2413] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 35.006011][ T2413] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 35.011233][ T2413] ? __alloc_pages_noprof (mm/page_alloc.c:4685 (discriminator 11)) 
[ 35.016765][ T2413] __kmalloc_large_node (mm/slub.c:4069) 
[ 35.022043][ T2413] __kmalloc_noprof (arch/x86/include/asm/bitops.h:417 include/asm-generic/getorder.h:46 mm/slub.c:4113 mm/slub.c:4136) 
[ 35.027066][ T2413] ? __do_sys_swapon (mm/swapfile.c:3173) 
[ 35.032196][ T2413] ? __do_sys_swapon (mm/swapfile.c:3173) 
[ 35.037290][ T2413] ? __do_sys_swapon (mm/swapfile.c:3167) 
[ 35.042379][ T2413] __do_sys_swapon (mm/swapfile.c:3173) 
[ 35.047300][ T2413] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[ 35.051955][ T2413] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   35.058002][ T2413] RIP: 0033:0x7f8ac1bcef97
[ 35.062571][ T2413] Code: 73 01 c3 48 8b 0d 69 2e 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 2e 0d 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	retq   
   3:	48 8b 0d 69 2e 0d 00 	mov    0xd2e69(%rip),%rcx        # 0xd2e73
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	retq   
  14:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  23:	b8 a7 00 00 00       	mov    $0xa7,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 39 2e 0d 00 	mov    0xd2e39(%rip),%rcx        # 0xd2e73
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 39 2e 0d 00 	mov    0xd2e39(%rip),%rcx        # 0xd2e49
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   35.063745][ T1492] is_virt=false
[   35.082007][ T2413] RSP: 002b:00007fffa761ac08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
[   35.082010][ T2413] RAX: ffffffffffffffda RBX: 000056306077c190 RCX: 00007f8ac1bcef97
[   35.082010][ T2413] RDX: 0000000000008001 RSI: 0000000000008001 RDI: 000056306077c190
[   35.082011][ T2413] RBP: 0000000000008001 R08: 0000000000000ff6 R09: 0000000000001000
[   35.082012][ T2413] R10: 4e45505355533253 R11: 0000000000000246 R12: 00007fffa761ae3c
[   35.082012][ T2413] R13: 0000000000000001 R14: 0000003200000000 R15: 000056306077cfe0
[   35.082014][ T2413]  </TASK>
[   35.082015][ T2413] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240624/202406241651.963e3e78-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



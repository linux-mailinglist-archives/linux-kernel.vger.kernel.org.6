Return-Path: <linux-kernel+bounces-196994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60948D64B2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83AF1C2426B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E1255E48;
	Fri, 31 May 2024 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYxloHv4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79F56448
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166483; cv=fail; b=g76e3cY4grs1E5fqq0uJSEvz0KZktDXEHIzXI9e/JrWHdOAnJiMFMq2hq5kBkT628hnzbqnI/emiO3E/29sq+DcLtUFYpLYpv+JKg8mAgCXfRuU1gD/dwIV5W3Hk8SwJeiogLvPMBb23bTl1y8GGCKEqEhBh16w7HF6/2NHia2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166483; c=relaxed/simple;
	bh=Ry29SFnShEbWvIGeTcC1uewpouTdf9X45cBmFLW54Vg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ftmzD7B7TAmMtaqGpwydOmYiJ27xoj7+VWIT2DR2LmJwefiUqjXQVupuRIP/oQ8YE3vOBd6RRZrLtde8uJCVcvAarZiNSIm079gzp1x+NnbYINoNBUec+U1+YkvNC6G8Qoc/77e2oradZfaNFyon8wIMRdVtRh67aC2XpHtaSMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYxloHv4; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717166480; x=1748702480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ry29SFnShEbWvIGeTcC1uewpouTdf9X45cBmFLW54Vg=;
  b=kYxloHv49PhBYV/toim8ADvaTUL3YevHaL2izhDu/rkeLvEKQ56kxLl4
   l6jquAduf/ptxNlTzPIsJ6nd8woPTS3Hky820WavZYXi2iSxl+bkdJhp0
   WP/0wdA9RFi+lEPpES5x/V0rtJ05+K0cw3xV2LCgWEbAsCaX2M9nSpnFT
   9bjk6/b4aWBapcuM+BRfo63gS/nzv+/bQSPy06axm1uaN/BTGBSxRLtwZ
   /2Ji0Y3tAJIfRoQZPn5vSuj+z/PJ2nDZC0jn5MqttohJZmfpVV3/+hAR4
   qR65z5LzBt8sEMFJF86iqTIHs4dsL6EeBCdhH5Eoeel0gdX/uYsedDae7
   A==;
X-CSE-ConnectionGUID: Gb9nrTBIQDWgeTx5w2EOgQ==
X-CSE-MsgGUID: 4cbKyRR1RzuOrrX4xZ38WQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13580572"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13580572"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:41:19 -0700
X-CSE-ConnectionGUID: vL9AKyNBTHiya8lttzt0iw==
X-CSE-MsgGUID: 8mWiimy6Qo2R5mWLSN+PaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36284388"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 07:41:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 07:41:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 07:41:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 07:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHpfdc5bLZQTzgSamZNCuVRcp2l/HTl10DZqdgerlvvI87L3zK1mr8RtKKPIGASZJzrAgc4WkAwd/Vpld8xypHgM/9anykMNuq1QSbK57i7mR50L04Hk9mLZEFEkZyj37W88M4umB3YIdjKwvHMPlQfuh8GxsG8AZI9P9MHCKaoG5fXfOEO4rxMQli/+XiytTILw+BzRini15AwZ5iO2kojwcI2v3IHEx+l7Oo0J5bHODEghlbNNMP4j4gBgRnFo2WNLm8NTfNBJYPdi2Pmrbz9Zr1R3omb1zCJ6lLkNDQmK+IDuB+JoR+zP9n/8ohdvR29xH1qqBsKICzC26/SXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3NPGKafv2ai6sQi6kb8keydLrCVN22Ij9LT9yQJRoc=;
 b=Yhyrx3awQ03HbRsIsKFj5ihfXdrepAll8mLZZ/uJ/c1NVw1LTwpx9scC3Yq2yXCde0JgyU/bFKjEaNmn4lrlJEB1Tuds9JJQvF1SnuNKMGRmKOouz2NrkV7oO57Vz5bKWEIHJDXs23nR+Fmxf1ceW0IABSGr4IyYCfXLuVSEte8nUUtmoWYK8WSMB6DBheZNxqyjk8pJWnRK62/QmHFnAmIsWEmqmdukY2MQ/54DZbpSwOUYtH2IqPyKSYG1sluzwktGhFND2QLUmxf9IXgvuH8MAZ3EbnfayJMkmqX1v+2Y9PHw2ZtSV62Rrg2+L4MHj6lzcnT0C7iXCsJvCs+FWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 14:41:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 14:41:16 +0000
Date: Fri, 31 May 2024 22:41:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, <oliver.sang@intel.com>
Subject: [linus:master] [timekeeping]  fcf190c369:
 BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
Message-ID: <202405312203.a36824e7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TYAPR01CA0072.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4651:EE_
X-MS-Office365-Filtering-Correlation-Id: a08b97c6-a7e3-468b-3e40-08dc817fba31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gnxi4/h19eplvum/Co5lJbY9WGdcEKoLl3jDNku6d+RcGVoJSsV+e5Et8o+M?=
 =?us-ascii?Q?BHnP5lmb60eZP9vwftxdOYm1hM6quNTd549EHQrWJVRv19KCTGX31q7Ru7Dd?=
 =?us-ascii?Q?jzAcD7bqCs8XagoebtTbNNfv/aXMQmmljdq25rApC8mkzZ8VlKtLsmpBL00B?=
 =?us-ascii?Q?u2crckYI6bi4YAP4FddqgRYCn5Ba0K86FEEXYjlMtHzjy7AGN3KiTS0LIObe?=
 =?us-ascii?Q?eSqlOgXmoFGRUjR7cYnb+G5nvyztL4MtNtBR7nga1ucldn0HVLHehysghe/R?=
 =?us-ascii?Q?5OkFJ2RvTYUEGe65cV2XbsMBAeAdLGZmrnx8shl/r4rNHDbxQg0dI4NSOCH8?=
 =?us-ascii?Q?3pSYUBcyUDntQOEuKQzWcqQa4pDOUT7TtkZZNR3hDnre/sKvC7fU+VBh2Rmy?=
 =?us-ascii?Q?Lu2sj22uxPwmqBHOp0rEESCo8iXQ2VG6piQ4723ObYD3JBXLVCPQplZl9JIS?=
 =?us-ascii?Q?ZFswL812f2KCbZGjY6TppW3nMJo59LWUo1Afv6j2TlErJbkrrQhocs5M36LZ?=
 =?us-ascii?Q?NVn0V4qqinun2agm86ZbC97wNAYqT5L1PjjqiHfa+laRDj3+E82kr5U8iVka?=
 =?us-ascii?Q?1g/aNEEub+V42tRyrh0vSToG1bWSvuOZkER2HmqJpkIL58hkgKSaUW4eZS/8?=
 =?us-ascii?Q?TFiYLyuhWQ2lT4ME2atY9C0B2AGeUtfqs2nr6OxXYZpgG/8TlKQFFO9xuGIw?=
 =?us-ascii?Q?FB9pGjbpz0pW+67j1TKmmIsxHyGV24bx1kT/btfQQcoedtlnhoZxN636PJBv?=
 =?us-ascii?Q?Gmwm902MNhigVmEgNo2bsgMcwbUwkEoJw7G9y+Op0MW3xodJ1TQAQJLJVzFs?=
 =?us-ascii?Q?ANguT6uHuVfGJp63Vq/G08TTnEU7u/pSk/Yw0+xgtiNS4JWORebK2wgiXQi3?=
 =?us-ascii?Q?bLVIdsEK90qIoJcyj/awJ51EqfNkBJZGHU0wbPFyb+U0la9bmlUbulN7z44s?=
 =?us-ascii?Q?Pfg/ab3FLNZJ1tMWg1hxred58wlIb5lx+SlCntgYi2sP9+GtjEyDagK6RXHb?=
 =?us-ascii?Q?jKYmGh8skojNlQHTbKjJRw1LXyHPZhZNoqOt4+02gLh+9jxbIuZirtHlhRCq?=
 =?us-ascii?Q?FvBrOaEdwDBuMhKQM8CNAF68m1RLqPdUOTYsbwDTVwt+GtmkFQAdih1fkSJ+?=
 =?us-ascii?Q?r8pK+ulxjB8pJMoyGs4rcUyIa2DmbbsMZoxPuQoyc8n86qy821/AQMLONfCs?=
 =?us-ascii?Q?oMgUXvpK56QWklbIYEHrCiiAzAwTIZAI0nLU+zZu7pzPEGahL2P/Skda8cw?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUg1t86/NVhiNebO+ye8IDbTr/DfJy/n3MNq6Fnp6dj82BuVWJMtKNyUYyqR?=
 =?us-ascii?Q?twjm6FBMutMaKqMijVb18ezA/uLfPV+w0Z52pLdppY3hr1dzqhvFtj0EYNJ7?=
 =?us-ascii?Q?GrBY/M+EPBPxQDyXiaRqnVOXXfiZDU1oJuquucuqXhgK9NGauRvqZEN1uTOt?=
 =?us-ascii?Q?Nqp9NPbAZ0HweN5LdVfWTBJfbVycN0/NOFN9hkMbMAB1X5W3iELPb0n3sSTo?=
 =?us-ascii?Q?Ato21/yMnAqPmW2SFBVNblN8oG2UTPVoSiOvpNiILdrK5mSbUg6UqaPCvuEj?=
 =?us-ascii?Q?nTqrK90esOKhIc9uhO4Sl12cbVnmr7m4aGWHAvwssu0MRMtek4XGbNKrMBpR?=
 =?us-ascii?Q?Q9rPWthbtffRP/UcCmr3L9ir8wIkKchAvHx56y8sYgdbukn54PDVplohZ3gc?=
 =?us-ascii?Q?EfJhh5cYq0YS7uLdZhKYMCNOjdPe9EqrhO3uH3xnJBD/Lqo8CmSqX284kblr?=
 =?us-ascii?Q?ZoM6xjXY+TDy/aLUkFE09wKiEl1ZgCfIRhgb/+4GqP2i/rEvyZsvYxpWTZWH?=
 =?us-ascii?Q?WQZcno7jwmyadb319yckQ2GIT9EHPcaGaq7Xa9qkyMsiOvqYhz4EDOAZfu9v?=
 =?us-ascii?Q?yYrzhyHFVzT3V0s6h48zII9ZGQgDEC07xQpGIwsSXkc5dXpO9Ph4fn787azJ?=
 =?us-ascii?Q?OnLCoeLGi3uXho7JSim4k0hdSf2WxSeEs+6ZU2P/f4KYi3g1DfNNJcBCCcdp?=
 =?us-ascii?Q?VsSOMALJy7EAo47eNy7LdcID59Ojll0ovQ5ALQyMMTzEENrRiMdbmV+cb4Bz?=
 =?us-ascii?Q?dfcBuNS+MtQ0rwBVbS+MOEF8c1dBPBkYN5Gf/c3ewkYasy3LX4DShScA6UWT?=
 =?us-ascii?Q?mHAKlAG/XLyznkv675mV2nycR7W8SnXqe8a8W2PcCmULfE4jznLsuhsN+9/F?=
 =?us-ascii?Q?QNbwWKcBKECPXlX2dWyNTw7vgILPOrVZ8vwAm9WdgkXRZmPXILTZcyoBw6HJ?=
 =?us-ascii?Q?qk2+Xd1cXadb4hzqJk7wiYqdaip2MIhPpebSXpA5VOAlvjeXzKWuGNzN/CTp?=
 =?us-ascii?Q?u7wlzrOMfuq7Oig81MCMlJReC5HgbnQKaoYOX14fTTGLk4d0iJJEqcnED5UZ?=
 =?us-ascii?Q?O2T8PhLcs3Krk4mun4rKtKkCGX5/zuuxNoI1e2ndmFTsfMWunHwKxdbwmnEF?=
 =?us-ascii?Q?B5naRile4bdCH62akC+oopyaDwJe6KAehONuIXhQwJoM1xUlsgXfUsh+WHn5?=
 =?us-ascii?Q?UkFceCeKfYEZ1W1RGF8eJ16nSvYj1aPT52TDhtCEiGzlnVPmEjC7DGfBudFQ?=
 =?us-ascii?Q?z3vQn0pRKLcfycVl31Jd4xgkeTWHh4UE8DT8AdSmX9Pkpdq+FdF+7czddWdH?=
 =?us-ascii?Q?fR22Jnu8EzCaTHsS7qjK8jGZMmFgflzxqMASA/T+gTfGqAKZLOXX4Cq7Nxf8?=
 =?us-ascii?Q?uQdb1XBVk0HM5JefHa4hLtIQHkQoaFS6ziSZGswxUJRfNyKjsiaPy6idRyUE?=
 =?us-ascii?Q?XNHsPdJ2kPlGU0dhvAqrYB+BNw4k8yie5DVvksFhtVJHTQ0QC+8HNBtTgnf2?=
 =?us-ascii?Q?ULFWovFDQcNEDARPlKSIyeD+qQHHkN4PCBs5xsmslL+UsudDFACvk/RrP/7u?=
 =?us-ascii?Q?ib2lxFcHQskiikOyn0ZjIH29UVkcgITaesFUnMDJsN8T9SMnzVwhWT6CGdlU?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a08b97c6-a7e3-468b-3e40-08dc817fba31
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 14:41:16.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlGtUVG4fWSXROYoMSvwAIztdsTt6jEsy/4zGRML1FQwPlytF+EN3tN04M5zqDGPHRfCEy/rR6vb3ZMVEm++LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4651
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns" on:

commit: fcf190c369149c3b04539797cedf28741eb14164 ("timekeeping: Make delta calculation overflow safe")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      4a4be1ad3a6efea16c56615f31117590fd881358]
[test failed on linux-next/master 9d99040b1bc8dbf385a8aa535e9efcdf94466e19]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


since we don't have enough knowledge to investigate KCSAN issues deeply, we
just run more times to make sure the issue is persistent on the commit and
clean on parent. for this one, below just FYI.


e809a80aa0bcf802 fcf190c369149c3b04539797ced
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         17:50         -34%            :50    dmesg.BUG:KCSAN:data-race_in_ktime_get/timekeeping_advance
         14:50         -28%            :50    dmesg.BUG:KCSAN:data-race_in_ktime_get_update_offsets_now/timekeeping_advance
         13:50          10%          18:50    dmesg.BUG:KCSAN:data-race_in_rb_get_reader_page/rb_move_tail
         50:50           0%          50:50    dmesg.BUG:KCSAN:data-race_in_rb_get_reader_page/ring_buffer_unlock_commit
           :50           6%           3:50    dmesg.BUG:KCSAN:data-race_in_rb_move_tail/ring_buffer_read_page
           :50          60%          30:50    dmesg.BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405312203.a36824e7-lkp@intel.com


[    7.317452][    C1] BUG: KCSAN: data-race in timekeeping_advance / timekeeping_debug_get_ns
[    7.319202][    C1]
[    7.319379][    C1] write to 0xffffffffaaa638b8 of 296 bytes by interrupt on cpu 0:
[ 7.320781][ C1] timekeeping_advance (kernel/time/timekeeping.c:2224 (discriminator 1)) 
[ 7.320781][ C1] update_wall_time (kernel/time/timekeeping.c:2239 (discriminator 1)) 
[ 7.320781][ C1] tick_periodic (kernel/time/tick-common.c:97) 
[ 7.320781][ C1] tick_handle_periodic (include/linux/clockchips.h:152 kernel/time/tick-common.c:122) 
[ 7.324712][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
[ 7.324712][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
[ 7.324712][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 7.328793][ C1] _raw_spin_unlock_irqrestore (arch/x86/include/asm/paravirt.h:699 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 7.328793][ C1] prepare_to_swait_event (kernel/sched/swait.c:122) 
[ 7.328793][ C1] rcu_gp_fqs_loop (kernel/rcu/tree.c:1577 kernel/rcu/tree.c:1663) 
[ 7.328793][ C1] rcu_gp_kthread (kernel/rcu/tree.c:1865 (discriminator 2)) 
[ 7.332714][ C1] kthread (kernel/kthread.c:388) 
[ 7.332714][ C1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 7.332714][ C1] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    7.332714][    C1]
[    7.336781][    C1] read to 0xffffffffaaa638d8 of 8 bytes by interrupt on cpu 1:
[ 7.336781][ C1] timekeeping_debug_get_ns (kernel/time/timekeeping.c:389 (discriminator 1) kernel/time/timekeeping.c:372 (discriminator 1) kernel/time/timekeeping.c:280 (discriminator 1)) 
[ 7.340722][ C1] ktime_get (kernel/time/timekeeping.c:406 kernel/time/timekeeping.c:855) 
[ 7.340722][ C1] sched_clock_tick (kernel/sched/clock.c:98 (discriminator 1) kernel/sched/clock.c:424 (discriminator 1) kernel/sched/clock.c:412 (discriminator 1)) 
[ 7.340722][ C1] scheduler_tick (kernel/sched/sched.h:1385 kernel/sched/sched.h:1699 kernel/sched/core.c:5679) 
[ 7.344805][ C1] update_process_times (kernel/time/timer.c:2493) 
[ 7.344805][ C1] tick_periodic (kernel/time/tick-common.c:101) 
[ 7.344805][ C1] tick_handle_periodic (kernel/time/tick-common.c:129) 
[ 7.344805][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
[ 7.348718][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2)) 
[ 7.348718][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 7.348718][ C1] _raw_spin_unlock_irqrestore (arch/x86/include/asm/paravirt.h:699 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 7.352782][ C1] swake_up_one_online (kernel/rcu/tree.c:1046) 
[ 7.352782][ C1] rcu_gp_kthread_wake (kernel/rcu/tree.c:1073) 
[ 7.352782][ C1] rcu_report_qs_rsp (kernel/rcu/tree.c:1889) 
[ 7.352782][ C1] rcu_report_qs_rnp (kernel/rcu/tree.c:1960) 
[ 7.356725][ C1] rcu_report_qs_rdp (kernel/rcu/tree.c:2062) 
[ 7.356725][ C1] rcu_core (kernel/rcu/rcu.h:138 (discriminator 2) kernel/rcu/tree.c:227 (discriminator 2) kernel/rcu/tree.c:2458 (discriminator 2)) 
[ 7.356725][ C1] rcu_core_si (kernel/rcu/tree.c:2489) 
[ 7.356725][ C1] __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:555) 
[ 7.360772][ C1] irq_exit_rcu (kernel/softirq.c:647 (discriminator 38)) 
[ 7.360772][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
[ 7.360772][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 7.364706][ C1] _raw_spin_unlock_irqrestore (arch/x86/include/asm/paravirt.h:699 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 7.364706][ C1] __delete_object (mm/kmemleak.c:798) 
[ 7.364706][ C1] kmem_cache_free (include/linux/kmemleak.h:48 mm/slub.c:2072 mm/slub.c:4280 mm/slub.c:4344) 
[ 7.364706][ C1] putname (fs/namei.c:274) 
[ 7.368775][ C1] kern_path (fs/namei.c:2627) 
[ 7.368775][ C1] init_stat (fs/init.c:133) 
[ 7.368775][ C1] clean_path (init/initramfs.c:334 (discriminator 1)) 
[ 7.368775][ C1] do_name (init/initramfs.c:367) 
[ 7.368775][ C1] flush_buffer (init/initramfs.c:452 (discriminator 1) init/initramfs.c:464 (discriminator 1)) 
[ 7.372705][ C1] __gunzip+0x36d/0x4d0 
[ 7.372705][ C1] gunzip (lib/decompress_inflate.c:207 (discriminator 1)) 
[ 7.372705][ C1] unpack_to_rootfs (init/initramfs.c:522) 
[ 7.372705][ C1] do_populate_rootfs (init/initramfs.c:714) 
[ 7.376757][ C1] async_run_entry_fn (kernel/async.c:136 (discriminator 1)) 
[ 7.376757][ C1] process_one_work (kernel/workqueue.c:3259) 
[ 7.376757][ C1] worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
[ 7.376757][ C1] kthread (kernel/kthread.c:388) 
[ 7.380720][ C1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 7.380720][ C1] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    7.380720][    C1]
[    7.380720][    C1] value changed: 0x000a914d14000000 -> 0x000ace5614000000
[    7.384767][    C1]
[    7.384767][    C1] Reported by Kernel Concurrency Sanitizer on:
[    7.384767][    C1] CPU: 1 PID: 30 Comm: kworker/u9:1 Not tainted 6.9.0-rc3-00018-gfcf190c36914 #2
[    7.388715][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    7.388715][    C1] Workqueue: async async_run_entry_fn
[    7.388715][    C1] ==================================================================
[   46.680358][   T30] Freeing initrd memory: 107964K
[   46.682005][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   46.683699][    T1] software IO TLB: mapped [mem 0x00000000b5671000-0x00000000b9671000] (64MB)
[   46.705499][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa3704c1a9, max_idle_ns: 440795296692 ns
[   46.711289][    T1] AVX2 or AES-NI instructions are not detected.
[   46.750407][    T1] Initialise system trusted keyrings
[   46.752155][    T1] Key type blacklist registered
[   46.754665][    T1] workingset: timestamp_bits=62 max_order=22 bucket_order=0
[   46.772327][    T1] debugfs: Directory 'file_lock_cache' with parent 'slab' already present!
[   46.818173][    T1] ntfs3: Max link count 4000
[   46.819226][    T1] ntfs3: Warning: Activated 64 bits per cluster. Windows does not support this
[   46.821239][    T1] ntfs3: Read-only LZX/Xpress compression included
[   46.827627][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   46.830338][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
[   46.848621][    T1] NILFS version 2 loaded
[   46.849689][    T1] befs: version: 0.9.3
[   46.855836][    T1] gfs2: GFS2 installed
[   46.860723][    T1] Key type asymmetric registered
[   46.861970][    T1] Asymmetric key parser 'x509' registered
[   46.864644][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[   46.867540][    T1] io scheduler mq-deadline registered
[   46.868771][    T1] io scheduler kyber registered
[   46.870314][    T1] io scheduler bfq registered
[   47.359071][   T49] ==================================================================
[   47.360665][   T49] BUG: KCSAN: data-race in rb_get_reader_page / ring_buffer_unlock_commit
[   47.360665][   T49]
[   47.360665][   T49] write to 0xffff8881093584a8 of 8 bytes by task 48 on cpu 0:
[ 47.360665][ T49] rb_get_reader_page (kernel/trace/ring_buffer.c:4598) 
[ 47.360665][ T49] rb_buffer_peek (kernel/trace/ring_buffer.c:4729) 
[ 47.360665][ T49] ring_buffer_consume (kernel/trace/ring_buffer.c:5013) 
[ 47.360665][ T49] ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:91 kernel/trace/ring_buffer_benchmark.c:205) 
[ 47.360665][ T49] ring_buffer_consumer_thread (kernel/trace/ring_buffer_benchmark.c:390 (discriminator 3)) 
[ 47.360665][ T49] kthread (kernel/kthread.c:388) 
[ 47.360665][ T49] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 47.360665][ T49] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[   47.372689][   T49]
[   47.372689][   T49] read to 0xffff8881093584a8 of 8 bytes by task 49 on cpu 1:
[ 47.372689][ T49] ring_buffer_unlock_commit (kernel/trace/ring_buffer.c:3067 kernel/trace/ring_buffer.c:3253) 
[ 47.372689][ T49] ring_buffer_producer (kernel/trace/ring_buffer_benchmark.c:255 (discriminator 1)) 
[ 47.372689][ T49] ring_buffer_producer_thread (kernel/trace/ring_buffer_benchmark.c:82 kernel/trace/ring_buffer_benchmark.c:414) 
[ 47.372689][ T49] kthread (kernel/kthread.c:388) 
[ 47.372689][ T49] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 47.372689][ T49] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[   47.372689][   T49]
[   47.372689][   T49] value changed: 0xffff888141aa3c40 -> 0xffff888141aa3b40
[   47.372689][   T49]
[   47.372689][   T49] Reported by Kernel Concurrency Sanitizer on:
[   47.372689][   T49] CPU: 1 PID: 49 Comm: rb_producer Not tainted 6.9.0-rc3-00018-gfcf190c36914 #2
[   47.372689][   T49] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   47.372689][   T49] ==================================================================
[   51.025622][   T49] ==================================================================
[   51.027409][   T49] BUG: KCSAN: data-race in rb_get_reader_page / ring_buffer_unlock_commit
[   51.028657][   T49]
[   51.028657][   T49] write to 0xffff8881093584a8 of 8 bytes by task 48 on cpu 0:
[ 51.028657][ T49] rb_get_reader_page (kernel/trace/ring_buffer.c:4598) 
[ 51.028657][ T49] rb_buffer_peek (kernel/trace/ring_buffer.c:4729) 
[ 51.028657][ T49] ring_buffer_consume (kernel/trace/ring_buffer.c:5013) 
[ 51.028657][ T49] ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:91 kernel/trace/ring_buffer_benchmark.c:205) 
[ 51.028657][ T49] ring_buffer_consumer_thread (kernel/trace/ring_buffer_benchmark.c:390 (discriminator 3)) 
[ 51.028657][ T49] kthread (kernel/kthread.c:388) 
[ 51.028657][ T49] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 51.028657][ T49] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[   51.028657][   T49]
[   51.028657][   T49] read to 0xffff8881093584a8 of 8 bytes by task 49 on cpu 1:
[ 51.028657][ T49] ring_buffer_unlock_commit (kernel/trace/ring_buffer.c:3067 kernel/trace/ring_buffer.c:3253) 
[ 51.028657][ T49] ring_buffer_producer (kernel/trace/ring_buffer_benchmark.c:255 (discriminator 1)) 
[ 51.028657][ T49] ring_buffer_producer_thread (kernel/trace/ring_buffer_benchmark.c:82 kernel/trace/ring_buffer_benchmark.c:414) 
[ 51.028657][ T49] kthread (kernel/kthread.c:388) 
[ 51.028657][ T49] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 51.028657][ T49] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[   51.028657][   T49]
[   51.028657][   T49] value changed: 0xffff888141aa3b40 -> 0xffff888141aa3d40
[   51.028657][   T49]
[   51.028657][   T49] Reported by Kernel Concurrency Sanitizer on:
[   51.028657][   T49] CPU: 1 PID: 49 Comm: rb_producer Not tainted 6.9.0-rc3-00018-gfcf190c36914 #2
[   51.028657][   T49] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   51.028657][   T49] ==================================================================
[   54.411601][   T49] ==================================================================
[   54.412673][   T49] BUG: KCSAN: data-race in rb_get_reader_page / ring_buffer_unlock_commit
[   54.412673][   T49]
[   54.412673][   T49] write to 0xffff8881093584a8 of 8 bytes by task 48 on cpu 0:
[ 54.412673][ T49] rb_get_reader_page (kernel/trace/ring_buffer.c:4598) 
[ 54.412673][ T49] rb_buffer_peek (kernel/trace/ring_buffer.c:4729) 
[ 54.412673][ T49] ring_buffer_consume (kernel/trace/ring_buffer.c:5013) 
[ 54.412673][ T49] ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:91 kernel/trace/ring_buffer_benchmark.c:205) 
[ 54.412673][ T49] ring_buffer_consumer_thread (kernel/trace/ring_buffer_benchmark.c:390 (discriminator 3)) 
[ 54.412673][ T49] kthread (kernel/kthread.c:388) 
[ 54.412673][ T49] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 54.412673][ T49] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[   54.412673][   T49]
[   54.412673][   T49] read to 0xffff8881093584a8 of 8 bytes by task 49 on cpu 1:
[ 54.412673][ T49] ring_buffer_unlock_commit (kernel/trace/ring_buffer.c:3067 kernel/trace/ring_buffer.c:3253) 
[ 54.412673][ T49] ring_buffer_producer (kernel/trace/ring_buffer_benchmark.c:255 (discriminator 1)) 
[ 54.412673][ T49] ring_buffer_producer_thread (kernel/trace/ring_buffer_benchmark.c:82 kernel/trace/ring_buffer_benchmark.c:414) 
[ 54.412673][ T49] kthread (kernel/kthread.c:388) 
[ 54.412673][ T49] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 54.412673][ T49] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[   54.412673][   T49]
[   54.412673][   T49] value changed: 0xffff888141a4ed40 -> 0xffff888141a5f340
[   54.412673][   T49]
[   54.412673][   T49] Reported by Kernel Concurrency Sanitizer on:
[   54.412673][   T49] CPU: 1 PID: 49 Comm: rb_producer Not tainted 6.9.0-rc3-00018-gfcf190c36914 #2
[   54.412673][   T49] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   54.412673][   T49] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240531/202405312203.a36824e7-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



Return-Path: <linux-kernel+bounces-291709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECA9565C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871781C21FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F315B13B;
	Mon, 19 Aug 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUdDF1cY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870715B130
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056865; cv=fail; b=bhFuSFBAuMeMKMe9alFkS5IFEHGZl46VBMiNro8z10g+Pc9lZMoAoFXEyk/xrMzq2eMHqOacDlWImqFkSGIJBSmxVPbeVz5q8ma3gwJ7K6A78FeDdOlk+WQ4d+Jf7LQznQgz0szpsp73oJm5zKnJf1UrlPdSn1RYTfZkQnsRpNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056865; c=relaxed/simple;
	bh=snnGUB5vSBB22yh3lT5G8+EgvyX3KKmYiTrc2A5cH6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uuBrOkBt3EUI5ZxgqjHkiOpb3DchMnPkV2rKJ2bzB9z0blO8gaKvB3AFljNzCd1P7+TT662b6KITOhcAIFY47yF3gStI2jiCVdViE6BOjyiqyCm4HagUy6WFLHwHZaXTXgortns5tdPtSVlXWg6f7hLUc2KRgOtU3R3qdIjBXwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUdDF1cY; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724056863; x=1755592863;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=snnGUB5vSBB22yh3lT5G8+EgvyX3KKmYiTrc2A5cH6Q=;
  b=AUdDF1cYWJfjVupLg0dleXU7fd4qsRVT6g8sjSlzqB4HgqpVQHhGj30t
   Su11679DOwQShEoKF9KmITRf223blnBRq1+ce7/dCQZEhZZ48DgiMqa2h
   INN1mqhHU+VVsgDwVVCubWxLhfHiwDR+2GGLHs15ZBfXSpm907ADNmYxZ
   Qp9KU3p7r6mJsZHv/XPru+/lvod9e5xbRswbuvxwwoTuadOCR86vaqfYI
   +HdI7DdMR/xSkmR6Db0f2MYvJnywIsY/VEKGFf7tfdZ9HmXbPFKAbBLNE
   r+5qnRtjvE8UopAJz2A0BN76zSTCRTow9i4ivrZrfMHs+x19G0jlF2z4u
   Q==;
X-CSE-ConnectionGUID: fHx/8zJqRgO0TmDPCCZxtw==
X-CSE-MsgGUID: 9E5ITGY6RuiKHvaV0uWl1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="47692640"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="47692640"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:41:02 -0700
X-CSE-ConnectionGUID: e9tu1zEuR2KgJS48yjOPCA==
X-CSE-MsgGUID: DPbfuuJvTka0+48KSCi/YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60356949"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 01:41:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 01:41:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 01:41:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 01:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCiy9b9cBtv66VlFgdgan3rdD16P1W9rHswmgZBdVB7X66aD0yveUHM3dFg8Rmx0iWo3AKVpmtBB5nQmEF/tM2ynokw6hkZl2sbeLxCSedUAMbN6ict3HxASFWaO5mXbCVvGNHD4M4yZ/QFKNEAHlPqjemLFnNbPbKyK9CdISev1HCw3Bm9AWBPuJM54GOTFQFIBCDBNBbgQofOO7p70P21VT+j5ytkI4Xql7/yOUDUhS1iSErluqrN8gaoW6zhvd5nJLuHZx4dKL/OV79Z5G6rcGaW/oZbI4ALra7bE/HUiZe6BCSPHuiBZ1X7B8YXzltm8FE6M/1mg+yu0kkAtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iI5YW2qDXUh2Fw40QzFwF5orFWGppV216CX3PV4gKM=;
 b=DPoTczH8TKkvHqfxuIbkhj602a6uDHzfDkYoN+WFfl2VbETzLXHfEhF7FWidVcmLzNHGtKgN9qJzCwGd/e+tsRvwxiz46TQjWI65DXJGJFyfy1QESuFk+MiHezHNJB7zYDX9pOjZQrPyHBFOxpcucCPi1vKf7UMCopsQy6fq8hrDEG+OFaGQ1lgvBamVl19tQSYfeDyg5fZ6qHCbYFWydH/LXyndEERDM62lFgZxU5Wx1OAIutTXJ7uIoK03gFFZNdZZ7U6rX/wSkb6TfWkDrXSEmoflyGK3EBZJUuRtfCPCT0XcaNMRAshBu/21WgCKBEe50WI/Pmn0QBqCTDQ6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7360.namprd11.prod.outlook.com (2603:10b6:8:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 08:40:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:40:59 +0000
Date: Mon, 19 Aug 2024 16:40:50 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Chen Yu <yu.c.chen@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [peterz-queue:sched/core] [sched/fair]  420356c350:
 WARNING:at_kernel/sched/core.c:#__might_sleep
Message-ID: <ZsMFEhfOJBz2fFHb@xsang-OptiPlex-9020>
References: <202408161619.9ed8b83e-lkp@intel.com>
 <20240817093329.GA32430@noisy.programming.kicks-ass.net>
 <ZsLNtymGVe5wk5vP@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsLNtymGVe5wk5vP@chenyu5-mobl2>
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: ccda04bf-f5eb-4883-290b-08dcc02aa669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SgmGvJVLsPyzxcIaahaxUgq1+97D53HkJ+QjLDCYduCB5oNRCxhWB9qLDE63?=
 =?us-ascii?Q?oxeuSWNt4bgJkjiDKFe23jdT9MiceL+26fb6lta/kJ8rhto580XRqYTToQHS?=
 =?us-ascii?Q?sGiPH8Dnh6CmewiDK56z21igW8TjjefLrJwhirvPxOH/qmcCTnyWDVgKFqi6?=
 =?us-ascii?Q?peaFrS+qHE0FZyrL3leDufoY5F6HXvnYAV4Su654vNLcuaVg8IofUUNspYn9?=
 =?us-ascii?Q?+Q69ZK2giTkuvvT3WN4NqNsM4kFIoN/FX4kladCttXlc7v+JWFxpAqDcxdki?=
 =?us-ascii?Q?LxL+BegBcUQgAat4zwoLr9pg+b45Q9UeE8hJVDbPaNg7MnL9G5UIBbhAdqGh?=
 =?us-ascii?Q?qpWbRug5euBLAGlx/NWVbZc5IJtZgvzECxFcSyTdkQkHkHDyjcdVXAbeXCqb?=
 =?us-ascii?Q?jGZHaSAKCPVrs+PpCfuSC2tge71baagRxy2voeIc9K48zHSkJAXM5WMDIULV?=
 =?us-ascii?Q?OTnLCm62q8oxghGUoX6mUpFB7+vWmruhkRQxf5bwSRQOkzTrSnmArjcUN20G?=
 =?us-ascii?Q?VaJ+t210w4R4ExIYdwAK/Jbfzww9qA/5AygvZ+xLg94m0AV91eoT+fkK7FV1?=
 =?us-ascii?Q?3uD7NEKeFGldwJy0YCfKNXYBWua2metccYbaCarhB6M/GhZVhFQLTzJ4NvrD?=
 =?us-ascii?Q?WCdLO1bPNd/WvnHlCmuJ/SEgMHVUhqxrFZYahSCChF6ij/3/F7Q692ARFC41?=
 =?us-ascii?Q?9yaGo7NClcKN4iF2mhAuBgQXiLWo8TJY+v56EyJvca/xoCPJiF0aI7dcIQ5x?=
 =?us-ascii?Q?WhDnzDcRsWm44YgfFQ8Fc9RY+84oBwcKKvzfAA4kSgPUSA97q4qpNAwV9EQ4?=
 =?us-ascii?Q?L3SpfcE5BfWT0VmdXpv/iu0SbI1jsboGjFjtG73RzJ4ntREjmXd24ofq58d8?=
 =?us-ascii?Q?y1+BkAwmcb5o4BUCXfCEFnbLRuwyX5txhs8OJy1veqKL02+eeBpWNH1Wk6/9?=
 =?us-ascii?Q?u7Sq66JAsep4d0z07dSJe8p026He0NR63wpCsFQ0lbVRbg69bT/HC+GyoUd4?=
 =?us-ascii?Q?nc/1ViwGpMfB0zQ9dT+0T8ZZI5oy4YEgZyqCmnSmZAcGjcLzHdR9LI5JM120?=
 =?us-ascii?Q?MNMxgN0b2FdUrQQwM971d5m/3vW0ZWaSK2i9VMVKdC8KkrSP/jSvkLX+Mh2/?=
 =?us-ascii?Q?T5xvITMsAyGkXs4DOFdCPDBsJ2eybHNIF+xrQECzvyD0EE40gzUAtgwcaQ01?=
 =?us-ascii?Q?Rr6x3m6H3E5X9HtrW3ZF/WIfO/Xdk7zi4pkdn4qcfIUCURVM6cn7aG9Edcri?=
 =?us-ascii?Q?aqoSN/7JogG1/DnkhFSV34FE6gganjy/d2Z2NPsTOGcvOpD46+ea4xuBib36?=
 =?us-ascii?Q?hP4uH5IqCLT1SaycnkOSU/I+vf//ox4eJEwmeSahMnhboQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Zi0yxxfXkxQPjCFAMWz1MzIGPF0gb8mbiN9k1M5WWmMkqzLVbIbnHyywQ0i?=
 =?us-ascii?Q?eu08slbM+t2EFnJPH4vZi6x1ga06GEE9vIgzPUnWBdwi6eL8itcO79JBNS6W?=
 =?us-ascii?Q?RW4nybJGx/BtOuvSyzJlCVFu9GsLWdfBj6l2NhQOyC1OrhylDeSMqtT/PJ6F?=
 =?us-ascii?Q?R2mqA8jPYYKyudvTRzi5pvm050k+fhLUXV35+VavHfR3zW3I9C5JH3FDTIuD?=
 =?us-ascii?Q?/0s8n+aCutcsh8VeBkYH9NF+Nx/q1lx/lGovgirEBYL4CQp4n1Zgz8WKKRfd?=
 =?us-ascii?Q?faQ7GsQVwlCpeYip/zFyPaHVw5VgcyrXUHoK10osxsOAw0RVp+dtBIw6bts7?=
 =?us-ascii?Q?QTfKutZUL7DXM/TSrlakjSRmImcjbOIHrcIvivEyKfI0wjOjHSM3paBQMzs0?=
 =?us-ascii?Q?BqjaY5iuDu7c2AjRGFw7fYe39mYRtcUsjHNaaDBW24TC0Icw4vXDrzHclMsE?=
 =?us-ascii?Q?gptxCrHF9t5uDAY7a4uydm8aq5K17pP4wbZHkaGd4Xz/KqqPGyfIAUNWMqKf?=
 =?us-ascii?Q?IgY1nVv+R+EBer38qjLS5I4W1cVKPvi4CslkNCjdhzXeWr9jhNZncsM1yNTB?=
 =?us-ascii?Q?Y8KJnP7cKaZQPchzgniI65paR/G2kDDsxGu9ay53I+PUNRKfl5pKOXKWeVje?=
 =?us-ascii?Q?6pIxYUeF2wX7pTiMZ3L0qJxR6IPTtaBqDtet62vU6SL756YAQdKqJn9MxSP3?=
 =?us-ascii?Q?z0vW1o+xPCJ53m0teK/2duhkv/qe2RAyko/I2TyGksMdw3FUl8m5aMenlQ//?=
 =?us-ascii?Q?/gqiSbCXVnSpkLlVbez77fQvkr2E20dntno/Dtefho65CkscS1kMLyF4kr/X?=
 =?us-ascii?Q?u/YAc0ivcN7v0ertYnSzt4RUsyMs8QVT7F8xM2kqwqbMXohi4JWEhDXDn8s2?=
 =?us-ascii?Q?g8w8pb+tvTBaU9Nw4oQV46JbL3yBMizxUIKnI3kt8pQPfpXoLd635KnQwcUR?=
 =?us-ascii?Q?fB+9DlHZEXGY2K+9OJGi4dFT30GyfP2a7XiyngMGMrxv8rovdOBX0qh8/NCn?=
 =?us-ascii?Q?gEmFBtZUOlTjYeHpta9kyjpXOoW4j9NQBx8/kshUnOvHaJHLihRkjZkm7kUk?=
 =?us-ascii?Q?idPCPNUO7aaoovCjiybJhRjSkb8nfgvlmoLCPoklgzoiOZ9qQgouHdPjTknH?=
 =?us-ascii?Q?Tuz5UQq++PXPh6fvLeZ/v+ztUc5q4sJW0IcJoDWq12qywE/0rTS/hsxc/Lh5?=
 =?us-ascii?Q?FAzfmIKl3NjUO4i4Yf6zk/lH/n3atlKBTJHdFGQVb24+iUN0V0b9/NB760Vj?=
 =?us-ascii?Q?IvPmAFosQjeq/UDrTbSvXv4Jxmse10ThWWfUYquGcnttwyk/wsbUe+vg/RA2?=
 =?us-ascii?Q?9JL1ifodrXQUSr2Y09ZARpcbLnM0evdTXi8Fca+rDnO8x3ox31zMaGQq9pea?=
 =?us-ascii?Q?A4fwQY9eOAw62EiVBDEtygTWkt18O3uUeiBgGoREcblxc80eRBAC5bVSFA5J?=
 =?us-ascii?Q?l9d5fMgr/e7/I0rO3Pq9jBeQGBGv9SKmczWFboBHx2LBe2nNPURooPRl4CEa?=
 =?us-ascii?Q?8VvFUoiGE5Uub8Lqr9he/+kxzIR37oySZj2xzghysRxPZkRut0pBVX4iOLRm?=
 =?us-ascii?Q?27v7VNcZudtUYpuiYQGECs4Al7MKpzGvW/CYGsf/MVu6NK1PEQs+Wp2w/wiP?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccda04bf-f5eb-4883-290b-08dcc02aa669
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 08:40:59.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5qBazFIJpn65HCCii71SyZ0rF/tUBQjS3u1z5m/DbsIXKQRASF+e3qIr720ef3I2z1jgvNS6//CZN9jkg2AKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7360
X-OriginatorOrg: intel.com

hi, Chen Yu,

On Mon, Aug 19, 2024 at 12:44:39PM +0800, Chen Yu wrote:
> On 2024-08-17 at 11:33:29 +0200, Peter Zijlstra wrote:
> > On Fri, Aug 16, 2024 at 05:15:12PM +0800, kernel test robot wrote:
> > > kernel test robot noticed "WARNING:at_kernel/sched/core.c:#__might_sleep" on:
> > > 
> > > commit: 420356c3504091f0f6021974389df7c58f365dad ("sched/fair: Implement delayed dequeue")
> > > https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/core
> > 
> > > [   86.252370][  T674] ------------[ cut here ]------------
> > > [ 86.252945][ T674] do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?) 
> > > [ 86.254001][ T674] WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep (kernel/sched/core.c:8465) 
> > 
> > > [ 86.283398][ T674] ? handle_bug (arch/x86/kernel/traps.c:239) 
> > > [ 86.283995][ T674] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
> > > [ 86.284787][ T674] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> > > [ 86.285682][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > > [ 86.286380][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > > [ 86.287116][ T674] kthread_worker_fn (include/linux/kernel.h:73 include/linux/freezer.h:53 kernel/kthread.c:851) 
> > > [ 86.287701][ T674] ? kthread_worker_fn (kernel/kthread.c:?) 
> > > [ 86.288138][ T674] kthread (kernel/kthread.c:391) 
> > > [ 86.288482][ T674] ? __cfi_kthread_worker_fn (kernel/kthread.c:803) 
> > > [ 86.288951][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > > [ 86.289560][ T674] ret_from_fork (arch/x86/kernel/process.c:153) 
> > > [ 86.290162][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > > [ 86.291465][ T674] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
> > 
> > AFAICT this is a pre-existing issue. Notably that all transcribes to:
> > 
> > kthread_worker_fn()
> >   ...
> > repeat:
> >   set_current_state(TASK_INTERRUPTIBLE);
> >   ...
> >   if (work) { // false
> >     __set_current_state(TASK_RUNNING);
> >     ...
> >   } else if (!freezing(current)) // false -- we are freezing
> >     schedule();
> > 
> >   // so state really is still TASK_INTERRUPTIBLE here
> >   try_to_freeze()
> >     might_sleep() <--- boom, per the above.
> >
> 
> Would the following fix make sense?
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f7be976ff88a..09850b2109c9 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -848,6 +848,12 @@ int kthread_worker_fn(void *worker_ptr)
>  	} else if (!freezing(current))
>  		schedule();
>  
> +	/*
> +	 * Explictly set the running state in case we are being frozen
> +	 * and skip the schedule() above. try_to_freeze() expects the
> +	 * current task to be in running state.
> +	 */
> +	__set_current_state(TASK_RUNNING);
>  	try_to_freeze();
>  	cond_resched();
>  	goto repeat;
> -- 
> 2.25.1
> 
> Hi Oliver,
> Could you please help check if above change would make the warning go away?

confirmed this patch could resolve the WARNING. thanks


> 
> thanks,
> Chenyu


Return-Path: <linux-kernel+bounces-518501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66576A39009
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A75A18926C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621512E5B;
	Tue, 18 Feb 2025 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiQAGOou"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114FF1DFFC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839365; cv=fail; b=hpIAmJaYnmW2gJ9edU/E7ARzW+JMrbJ40prcVOsQbVUgNOjJ5jG/Grm1sofq3GpTxibRQSsXCgX400yPP/rn8BgMxm/K4eTlD40fjugka+ihZs8GVVmT6hUzir2mtumbFDucyy1nc02jjdpmEwAf3PYzwTWfwFE2v1wFBVQlx5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839365; c=relaxed/simple;
	bh=CMbDgIMIDwd66yIJrFzPPAWaMn0GUNlpoRVVfksiDGs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R+UHiS595IUXzH8Z1tXvwnllQRPgy8jNtEXzE2NU8Jj4At3PkEmTS4IkRaNXEP6RkFqkZ5FDoZs083yVayF95v+XmMFpz5ZrAN8mftMihmh4vLuH8F0FIdWkTPlEqYxuENmiF2EaLO1flX23JE4BrevRka9AIxs3xU04IQw9dc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiQAGOou; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739839364; x=1771375364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CMbDgIMIDwd66yIJrFzPPAWaMn0GUNlpoRVVfksiDGs=;
  b=YiQAGOout1g1wN0Goowganjh/eulsdVWhH/+l3i43WsqhWdr4wBB6uNN
   5Rnx9kcb3cyyQbZcdwuCBCVTikkqYzCOmxqHs8C/AWRvrFZoCIs6+1Aa6
   KjfnOHYstYCNnq1r4QW4H5XqUQIgKCPuNoRCxkxoYVraQRzRvAGR7J/VD
   Jq/wcHQ9rJiTKlX63Cce4sD1/E2dwDEJblfSxIsolbRRrFlKaGDzfr/EF
   AFbnfkFCUAhKKxA8kUCTWpafcHozR4jMMcyZ9ePJ0D6RNuhM/sVQ2WQJ2
   Gh8ZrWBi2ws3SioLn4hgbHpukfsJIXqHLjN7IkyIHV7Zv6jUZ9dz1RscS
   w==;
X-CSE-ConnectionGUID: MZRKgYBlQgqao+cNTbMsDg==
X-CSE-MsgGUID: s2viZzNUROiuVm/XK8s2eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="43354971"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="43354971"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 16:42:43 -0800
X-CSE-ConnectionGUID: nCyXKsSORLiNx+KLE0fWBw==
X-CSE-MsgGUID: lUTum8VbSaGvkAWbcr3WaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137481425"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 16:42:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 16:42:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 16:42:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 16:42:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgOnxenMiUMcqKYzbhm0+t14X3cGhSV1ANT42W/uIsJ+uZaxc12VUMDjW9+qcdyjumLmCc/K/kpF1E+qAmMfMF0W47QmOJnVmLbQ9MjkCNVdCLhO6kzNx3KnMimYyogZyOm7O9K43PJdknFytooHtdTgqQ/J+Y+8I3Urlp4JHAgtHu7KOMdK1bIN6S4FmdttA6JaZqC48a/5LcokesmsrptugjPzXwCYMun0Rgl9kWEe73qkGELQ2Wzi5Q/FPP3ne3H7RbNSouP+TwlXDg7c/dECEJL1oCI2/8cax22C4pU0bVuYTUfpPP9hm3DhU8sovQ7Feum+I0/y+HqhosbFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO2Ne1zS3jipqK2xqbmgcg9bFSqNnfXlt29AQ2PaFOQ=;
 b=TnGef1Ky2kytoeDYNq/TtQqHqlQptCy2onWEGDfuwySSEPEf69JrVP2W4kM3VxeJy40SMO+D48zUV1m0N35u0K2xCQ1gSZUcKmAPrCIdPLWB/JrMKXNdR0FSAc9OidVAYa/SQDa8M5oSBpGUpxfAG/1ZpeqnCgGlqqpIyQF7lRStoXyXy5UwojAPSeijD1dJrJLMJFe8AlmwuTB42JMHZuahVflQil1B85/4hXLYWFr94o04EFX4JsoOPQKKzrA11dWNZcchhs19TCObpDH6iHehXoxnASzfjpSGRarsNU2Qe2yCHCqLtuzRiGpL8LnHFokLD6m42o94NFTwbd6rNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 00:42:13 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 00:42:13 +0000
Date: Tue, 18 Feb 2025 08:42:03 +0800
From: Philip Li <philip.li@intel.com>
To: Baoquan He <bhe@redhat.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>, Yang Li
	<yang.lee@linux.alibaba.com>
Subject: Re: kernel/vmcore_info.c:117 paddr_vmcoreinfo_note() warn: unsigned
 '_x' is never less than zero.
Message-ID: <Z7PXW0NHvgT5eWRu@rli9-mobl>
References: <202502141843.5QoKdQ7g-lkp@intel.com>
 <Z7Brcjzuh+SG/io1@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z7Brcjzuh+SG/io1@MiWiFi-R3L-srv>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|MW3PR11MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: dc900374-e073-4176-dd7d-08dd4fb515cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Zxjt3WvyjF8YVGelEy5QBm0AtJz+yh6zlIWNXZZVk1pa0PS/KI1KRhx7r/B?=
 =?us-ascii?Q?ewpVK6dQM2f3QtqkqPc5Rb0e+qwaJvn2lg6/Rbb+Qufur9Qh/laFwqpp9gxN?=
 =?us-ascii?Q?vc4VSa0n0k8GpcKmNWVdaXYq9RZiQsxNoJ81tmLNwvU+OJOUjIf+lJD5ndNW?=
 =?us-ascii?Q?a30McNm4BV5rJPC8EybMNeTauqjifvToBW/6IryXBSPB1Uozq/GMtd2M6zy6?=
 =?us-ascii?Q?4Kul4YtPl9kkgktRjCEXWAIxZONAcGw+l4XZpf/YzeawrqmevJN54HtqhyPx?=
 =?us-ascii?Q?J5lfNRs0u4ixszAI0BUUa8L+5EAR9C3N+Fp6g0rRW6k2DPRLB5k+0pKGPZKu?=
 =?us-ascii?Q?6e5gO7ZJSgZ738zYy1eP4Rmz0SPWx4+B1unO3RiDP/iXq60D49SOlTs/og7g?=
 =?us-ascii?Q?g2FAp6r2zYKYFXy449u9WxW/ReMirlNrDP/J8XjAzV7cqVSqW+tXf+4Sftow?=
 =?us-ascii?Q?mIAoSBF9Odm+xtz4PQe20zs1HLDW/rGvfWb2ItGVMMx6ywTtKSVmUfsFIHAx?=
 =?us-ascii?Q?pLsaypgpE8MqYUnsB22G43FZ+Vk+GrgYg4sbKO7ra0sXF1DHq+94QGI5ysyS?=
 =?us-ascii?Q?ygCEuc9PS+idk0Ni73vXy78ZCcmsE5BegTJo3X4uhUZZSo80F8yrvlwqhUtI?=
 =?us-ascii?Q?clBaGH+eutwfi0D+GNPsDFejNbikNulg498oOf29cYVdEBMTxGBUJyopfF4u?=
 =?us-ascii?Q?1iF61IqrbnyjyH4QyQGoTDO+DrO6EiQuc8pvrub+VyugqblK++Ww6StcJX+j?=
 =?us-ascii?Q?nwkFV6DpGmQwhqDAHry9A/9UzbmLphtAAKgehp+aqo4QjSuiNwLIObEWBdrY?=
 =?us-ascii?Q?wjHmLa5zlF9whzTmIwiEW260VoI0ePoT6n00kaLk3AEaed5POFwwMIOCsxkz?=
 =?us-ascii?Q?Z01XIqu6uIs0b830plz4/CQI2VkozMZfCfFnrGjyf3SWyVfKzTOFDQR6u3Qa?=
 =?us-ascii?Q?rtSbDuMGGSPL3wCd/55YMZCcaF/qhaZmKBJAUekyrF69LAQKr0bN+1ii5uie?=
 =?us-ascii?Q?0+sruZiYUJSgfFiWCK/SI97yNFW6dV1xv5/yI1hdehyNburczs+BFvwohKRR?=
 =?us-ascii?Q?zqR0v402WWmPLYDIoTcMvHocOdrUNzPM9LC70peV8CJehedsbv1nLWTaV/OB?=
 =?us-ascii?Q?e7idz4nN8CgBtYVlfZvYH5qPbd7F9CXmaZX2ZSDKiXwOQq8SdC6+AdzGloiZ?=
 =?us-ascii?Q?gxHw+2kKKdgIQs+QFh35707uci2aBenFr3fMA0qz15GvCYKJGe1iWFwddn4U?=
 =?us-ascii?Q?aZvaaGo3DaOvxddSjjX8+e1OjqKTdFW5LmqhKc9NRrCrNJRtiGgvpIUVPrOI?=
 =?us-ascii?Q?KyPylfgK3H8rCwjMKK/JMl6IFTdWlzZxgQ40NvmEBbDLOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCg1PRggF6iboSQG7lrNSwZjlF4zPLAby1zn8G9X/4AaKqH74epGogc7Zbzj?=
 =?us-ascii?Q?FPVN3m99ZUbkpXs4gX/gfJlCEOd1SJxeMfJzVdx5qkZZ/7A9jH6oRGNnw/si?=
 =?us-ascii?Q?O1y1Tu4pf5c5rhRySU4D+oXpHr1BXpvqba0GJ8nSZA0Zy5r3IcrE/MVAG9Nv?=
 =?us-ascii?Q?ui/p4LLeIsvvbl85mnb4I/LSyTrKw0qTisa0zOCkfkk124hPcRfvDJjpYSJj?=
 =?us-ascii?Q?14zLo0gS3ghCS4y21wwNSoSHzRttlbvI8jlBCjO+BK5ksKNCSQRVYkQkCX6m?=
 =?us-ascii?Q?92EjqBRs9CJeoBTHhAyN1nTkAru+FO8Gu90WvUvSv4mPHnFMhJbI2Cv+zwbH?=
 =?us-ascii?Q?cYz7UMNg1OaTDv42jMoWgsjcqQEE+sXELpBWnxMB/23lD9Fvbcan+v7OXu0C?=
 =?us-ascii?Q?m/+fr6jg2utpX8EhZiCKK2VeC+2vP3xHQG8SQ/EXod1W2OuzCUtq8uh7NJD1?=
 =?us-ascii?Q?Q3dCuTg1+sC8Tt+rjWuLuPeS1CEFOW5RUiCPla4M5FCjS/rgeuQukFK28Uhb?=
 =?us-ascii?Q?oakG5pCtMBHlYCEjePCdVKBst24DixvsZw2VBszxkPv2s1RGhrONoEO5+4z8?=
 =?us-ascii?Q?RgYpweQFCEDSjEj9w41HugeMgDUO4dcVFr5ci/xZuPGi5zaYooQ5Ara/qDNr?=
 =?us-ascii?Q?OCQZt9vxQvgN1oOEfwbkrEPJu7+cUNWmdewdjLTcspYf0vWCu4Mf3Vz05Ea5?=
 =?us-ascii?Q?6MDvSGm/hziYfXxjsLoCOMFOOMvI1A7Ra33ejDsLZ8Ks3O3e34rLd+0EBc9B?=
 =?us-ascii?Q?EXbO+FQtvNpCxNjnyInYMQq8plpyx4H6oi+BeJLZg9QHockpa05CPtgDulJj?=
 =?us-ascii?Q?W7oNCTmaYq+mVlcYqUFKHdeIVXKcTk++QAB/4mV2ZSovLbV4CMWW6eS+37AL?=
 =?us-ascii?Q?OxzkKqahTOmAsspHK9ZqQuIIzu9Wbn9YMklENmC1VW+feVpO+Hrvm0eYr67j?=
 =?us-ascii?Q?u2sU+AVXFQVM8Prki6knfRPtFacJnL8j3WQ19BgFMWWA8toO/THWzV5QGKdI?=
 =?us-ascii?Q?Oigi3pUg+gwZjXu0L5KsSd2IimdI/6yScM/ADdCPO2QbTjXEjT80r82KPuuW?=
 =?us-ascii?Q?Bh8NaTa+rHZM2x0PUrZMVgcOkhFws/BoW7W8zsTf36Qzzx/fKIsph7B8uV3t?=
 =?us-ascii?Q?NfXHObTGJ9UBKHtKhB4+WbiT7ud2yhSFbkztxozpdbDQOvbE87TamuIxZUhK?=
 =?us-ascii?Q?0WYHIGoG6swpu2zpaul8r5KoLFino1yIpw4oFxSrsOqr3XNx5JyzcRVh2hcC?=
 =?us-ascii?Q?KlqdC89U3ld1GHLZYcK95LlkvlUYKOkJ0oRa0rg2jSQAmZvo9aqF20vuJdb4?=
 =?us-ascii?Q?+k2v9R5xj3/cjJ3XxSs3/FdXrCFveRHtNJTv7Tv11F0Omn/G1gKUra/bq4Bc?=
 =?us-ascii?Q?lfeReB/YsNNFXuzpykoeWuCORhwQFF/WF575HLWXJ8ra2hNgyQXhO2Tj5TtK?=
 =?us-ascii?Q?a6Cjb5Vph8xVWnKyOmCRP3oYXI1QrxBjZhM9cO0UN9DDM08QDcYFzVb4HjgV?=
 =?us-ascii?Q?opfA3Js4nHCChrArdXApiE90+4J+VP2K7JBNL9NGCabTdMpR9SytBdXQriok?=
 =?us-ascii?Q?F7wWj7Sq97NrVREYQB4iRwrhrcFmefXfLRbW5HSh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc900374-e073-4176-dd7d-08dd4fb515cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 00:42:13.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgHsdlTHxKBG6Gau9crHTmM0xdfC5tZeeNSIkf3cQjGG8D+1AHTboIVL9rYANkCa7htcDEO65Ea+f54RznXmWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com

On Sat, Feb 15, 2025 at 06:24:50PM +0800, Baoquan He wrote:
> On 02/14/25 at 06:44pm, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   128c8f96eb8638c060cd3532dc394d046ce64fe1
> > commit: 443cbaf9e2fdbef7d7cae457434a6cb8a679441b crash: split vmcoreinfo exporting code out from crash_core.c
> > date:   12 months ago
> > config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250214/202502141843.5QoKdQ7g-lkp@intel.com/config)
> > compiler: riscv32-linux-gcc (GCC) 14.2.0
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202502141843.5QoKdQ7g-lkp@intel.com/
> > 
> > smatch warnings:
> > kernel/vmcore_info.c:117 paddr_vmcoreinfo_note() warn: unsigned '_x' is never less than zero.
> 
> Thanks for reporting this.
> 
> I am preparing to reproduce this issue, while I may not know what are
> the steps to reproduce.  Just run smatch or just build with the provided
> riscv-randconfig-r073-20250213?

Sorry for late reply, this is from smatch. There're multiple reports similar
to this, and one discussion is at [1], not sure whether this is a false positive.

[1] https://lore.kernel.org/oe-kbuild-all/Z7PWuSA4jtZnxp5J@rli9-mobl/T/#t

> 
> > 
> > vim +/_x +117 kernel/vmcore_info.c
> > 
> >    114	
> >    115	phys_addr_t __weak paddr_vmcoreinfo_note(void)
> >    116	{
> >  > 117		return __pa(vmcoreinfo_note);
> >    118	}
> >    119	EXPORT_SYMBOL(paddr_vmcoreinfo_note);
> >    120	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 
> 
> 


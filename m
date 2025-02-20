Return-Path: <linux-kernel+bounces-522958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C96A3D08F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BEB1897608
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F541C84A9;
	Thu, 20 Feb 2025 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B03KsjpM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765B3D69
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740026834; cv=fail; b=DZBHL4k2i33Qzqcq/13V5adp8hyBJdiyFtKWvls1w4kXNChx/yJyAS78Xuf5JjHMskfOuKUdVAxfDJHI5A3HTsUXUE53utOQe23rNAnMhWQVjJSy9drADAts39yxRXJQJqXJIj3Ab2EUR6OorkktT0IfSTuZYwEHPfXdWX3Q5VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740026834; c=relaxed/simple;
	bh=IG8GR/gh3GJq157dxztebE8lQSQoHEzm7v62O8ljzGs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DcFO+hFLVWBXoUaR+Ca3pDRLCPnmE3ZtwxJjm0D0Qg+q543m2O+vATCBrZpGjmg0ocs2CxhuH4qchjxprX65SVhIKLqdopyLYXrP6CQ5SlEK7SyaVuG4sZFvcVHP5JBKLOJcmUXxOKErsSv+GkqRx/ZgxSydZsqcWET3lzObI10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B03KsjpM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740026832; x=1771562832;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IG8GR/gh3GJq157dxztebE8lQSQoHEzm7v62O8ljzGs=;
  b=B03KsjpMhnMyRNx4JT+a9os3oRHC4ZoXICy1VGxAidwT0DJL3IJuUrT+
   WRwikZRGUu+sObStolRyTH99/iXlM15rNLfjBw2CbbO2vSUzZmfJXLhtj
   EEnPPdUlNdE/lxkrxCw2ZozIUGa3cLLaHsFpqT7TWLXRpD/ltXCk+fRBd
   fq69N3nr5qPcHKfrN53tVITvBInDxzHOUfu8CB/KchgNjVOWX43TgoxEV
   P1sQuFEeH1V3ecTGsZq9BUJcIa7VLoQ52FhK2IP01uKfB/2CfnoXJDfVl
   uswkUIUTXmbTofxRD05qA2Z6yWwhNW1TU/9xw49eTaDPmw8N7TuDnZBjX
   A==;
X-CSE-ConnectionGUID: Ky5uRdGxQLOBbHUE2c7jig==
X-CSE-MsgGUID: QpR21GyZT7i9Vjhh6xeTZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40021333"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40021333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:47:11 -0800
X-CSE-ConnectionGUID: XZ8bGf1ZSGCNbuaFyEEoLg==
X-CSE-MsgGUID: dAXIDzeiRDC1DYP1A3nZ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115125988"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:47:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 20:47:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 20:47:09 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:47:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+1Ish8bpNIClmljfZgduuX94vjjhLy1EsN5O0yv3gotimTK6MR1QcG/maneqhPVHPdvkztocq97C/olRdueJZxwr89pSUjjOSz/XZK4RKwIIcZoVMa783QZfwVTeedIt0hBd1m/RhASBcUjdTGkVCj4h5nSbihJbDDPyGfqUrNEhvp2iB06Yk5SpiwaqbFLjVG3OL5K5hDw5rfSaMOYZNdL0vA/cznmFKAc+M/TsiR6L8uK7not/dP/bOPk1CH1AkeY9a1m6UhclB6zVbE5az1rnydLybqW1xzDTBGAZdbLpBuyHNhSPSBr4yNXTke42zPxXP2bJhVupAWixwKtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbJbt6jQ8ewFYuA7zxf560KouOJcHQ7oRDAT4U8jc1Y=;
 b=BqKOjeQdRu0PBa5oocEzxS4Es3Yqryk0R6LpuuOBjrUy7hExfd/InSVX64GdazWiuyfBEfwZ9WWDocBI2ALI44P6jSlSsUcpGsfEvhKAcyppLH8a1EjcY9E++vqZzhXgnq394ZUgLgxarUnCtoLrSVpHVEQ51E8F7CqvWX+FzoUdmk7h8zM1k795oJN3gcEz1kh2JNiRmzQUJsuGbRJBdaFuqNA84ZuqEu8CzDZYWf6z43IXIlUZPjb4UFTADGv5hFrkV0HPB6zKD3AQhIgmIM9JxziZ+BVM6fgpmnDiFyW+NMPGZSGsNIfbG3CIGUqkXKwXPs7xBQZm8v2EtmzU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 04:46:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 04:46:28 +0000
Message-ID: <a55f2251-008e-4d50-bfe6-47719043ea00@intel.com>
Date: Wed, 19 Feb 2025 20:46:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 34/42] x86/resctrl: Drop __init/__exit on assorted
 symbols
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-35-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-35-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 183efbe1-b268-4c5e-60dd-08dd516989b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm5PRnJCQUlKckgzTGhQTVdLQlpBZkg5OU55SUhKMUIzTU82YUNPNFhQdTY2?=
 =?utf-8?B?S3NNNmdsOVRDRVVCQkRTSnVEZXVvV1E4bzRqa2FKdTBIY3JVMHM4WWpMamNy?=
 =?utf-8?B?QlduSGRNdlZ5RkRrRHowc2c5YVlTb1RkSlNKd3dQRmFKRnlhUmF0TVNiNXM1?=
 =?utf-8?B?QWVEVldwUHlGVVY5TVJKQlp4OFJVa1RjSjF5S1lkZi9HTzU2YmFrNnYxb3dX?=
 =?utf-8?B?Q2tiTzhjY3ZYUitoOWF2MTJXbW9RM3BEL2htc3ptMWVrcDNoSWI1L3lmeUsy?=
 =?utf-8?B?N1R1RjlVeE8wd3czbUVDUzBVRkgvMjFueXRBMzkzeWFneDlScFlFQ0RWVE9R?=
 =?utf-8?B?ZWlEMzYwL1g5TWpnOU44RENGclJ6NjdNVi9sNGl2bzllUEU1TTk0SUl2WmRF?=
 =?utf-8?B?eUVMTkkxczAvUDNHOVBRNDhScHBuNFplQXNNNFgvVUVnOFpMejFDaE10Z1RJ?=
 =?utf-8?B?UGNCZ3h6bnZRdnJNeG8yVUM3ODhBY2JobEFWRUF6bmx0dHZnOTNZRWltWU8z?=
 =?utf-8?B?T1ErTU1aRjZjelYrN2hFSFhMZUYyRCsxekdyS3Z3eDFjQTAySTFLOUVIRDRv?=
 =?utf-8?B?U1VJR3lBWXlxMm5pdVZCdzB3U1pHS29iWHRwN0JWSnZjcWxtc0RWMG4yVWZi?=
 =?utf-8?B?N1pOMVlLdjlpaU1pZ0JwUWpEQ3RPNXJ1SE9QdkZFUEJXQ3Q3SDhmWHBMN0M5?=
 =?utf-8?B?OEJleG9kQnJad0NMUUVGaEZIRlg3c1d6dXVkZVd2RWxVTzgwTnRQc0pqdGVj?=
 =?utf-8?B?UXNYSGN2RERBVjV3blc5OTdpbmx2cmxsU3VqY1VRc1haTUZSMnVxdERLMGhw?=
 =?utf-8?B?RmhuV2dLU1J3RzMyamtMN3B1SmFNOGJDaGovUjBqVVNKK3Q4bXF3MGEyL2s2?=
 =?utf-8?B?bzFJTVdRMHpyakpUZ2RjVGdZRmZBamZ5bG9NYWJTMGhGZ1B1eUZnTUZwbEFC?=
 =?utf-8?B?Wmp3NUdxVlh6VkhZV0hkRmlOMzUwM2RzdDV3VVdVUzEyN0Y2MHFQbHdPR01p?=
 =?utf-8?B?b3BSb1ZjT3l5OUY5aHFOWWo5TDFYWVNtWm1VWFRFUjhRUVdsOWlPZHE4cGs5?=
 =?utf-8?B?MnFxczQ4Vi9KYzRzS3o5RDFtekY4MGllL2dhL1Y4Y2R1N3JEbWlYVGFkZkpL?=
 =?utf-8?B?OWU3Y0FJMTdVTE9ZanVyNEMyMUx0cDczUFVrcWVySWVtUnBIck5pVWtHbUF0?=
 =?utf-8?B?ZWU5YTlvSzFNaXFRbVZVZGEzbkpRUGxNaFBmVm4rdDVEZVBlUXY1dStOSnM1?=
 =?utf-8?B?M1B5ejRpM29xWTRaOXpxOGM1Rnh6NElsSXRMK3lFQVpqZ0xwaDVkazduMndi?=
 =?utf-8?B?YkQ2UEd4WE01L0sxdnVVd1FFNDNic0dFYjdCVmI5eVd5cjRDOElTVWQ4UkRT?=
 =?utf-8?B?MzkrRHlXQnRvTzR2VTBDN2JUVllKT2Z0TkYyOHlrOHI2VmVUcWVZVmFLdjRi?=
 =?utf-8?B?RG92RnlxTDFpZUJQQWtiYWlzTjJOTFhzVWJldE8ydklXeUpKNURwTGg5V1Qv?=
 =?utf-8?B?RzZYQkdKbGhObTIvMGRVcjhYdmpPbW9pd0k4WjFjTDdJS2MwRE16N3NzNklU?=
 =?utf-8?B?OTFnVllyTjltRDJudU1sWFB4MDVReEt0ZEVkN3NBdkI3ZThoc041V3FqOFV1?=
 =?utf-8?B?d3RrckpzMHl4UnkwVWJzeU1rcEZqOEZuemVGbVBCb0RWeWJ3K2puYTBHampC?=
 =?utf-8?B?WGMweTNqZzVVUVQ2YWphWk11QmNCd2J4MDZSTzZsdkM1TjBsWSszcmNmbDI3?=
 =?utf-8?B?WStHenJ6M3g0Yjg1UGVUMUwwWExRSDJ1NFV4ay90ZlM0TC9SNzJNdFArR29t?=
 =?utf-8?B?L1dJZXVKSGVNU0RnckFMWnJJOGY3VENPMnhrN293Y0ZvNnArbzNZU2UxN3J3?=
 =?utf-8?Q?m7PzsDEIs1ggN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VCWTZVVEZoZ3NIVzBYVkcyVkdacVp4N2dQM3pvSWcvc3laaEZpb0pQNitW?=
 =?utf-8?B?bG5XN3ZjSEM0OFA4dGtROW5VWHJ0V3p4UStxN3luZk9SZFpLYVpnQkZEWTdN?=
 =?utf-8?B?ZG9FVGpEMDdBSGlsY2YrYnlmMWlXRGUycGJkS0VGYnJKNmdNTCt2MnFZVk5I?=
 =?utf-8?B?UzhWSUFrWUFFRUh6ZFBPZ1VjYkFCQ1JMLzZtRU93emhWdEc1d1dETWFpeG84?=
 =?utf-8?B?NlZTbWFXdHpCUm5xTkVHWVBDbjFyVDdqSFVEUlY3UFE0ZHRtWnVLZUVxZ3hB?=
 =?utf-8?B?VGU5eTJyNFFIUUJ0NmpSVU0zc1g1ZEZxZll2NkdMZzVFcnJwTHVZdEhKbFdZ?=
 =?utf-8?B?azRYd3RBaEhkM0ZmZ3JiUE5jTDBIcnlySVdNVm5oTDg1Nkx2M2VsdnE2Wm4r?=
 =?utf-8?B?R2E2T0hOSzhhK3RIMHhyUE5MV0tucjJ1MkphRzVhV2JNb2ZaVHh5UUUwQkVj?=
 =?utf-8?B?cU1PL1pyMmd4RVhPY2hERG0rOXczbzY4WkdxaTc5cmJDeExBSW1YSlJGYk9O?=
 =?utf-8?B?blYzRFFQcFRnZThLRzUrcXl6ZVpwaDhhWUJFb0QvbnJhVDhqTThFRkxTSEhh?=
 =?utf-8?B?S0pvNmQzOVhFM2ZNcXIycUVpU1FROHZSbzZjR2diQklWMlJ3UjdDQzJTSjI4?=
 =?utf-8?B?SUhaNXo4YkNIc0U1QVo2WkdTSmpiRDNrUzU0VjBHVGI1NFdHVVRRMU1xRmor?=
 =?utf-8?B?Zmw4b091dFlWYVJueEVYdjF1U0k1dVM3R0Z0dGtVZCtFM08vTzlhS2xiMlpE?=
 =?utf-8?B?REx1S3k5Z1VvRjN2U1hjRVJNVnYySkFIWHNGbWlPZGJKV0cydkZVWjJzZ3hB?=
 =?utf-8?B?VTYyNDhVNVZFRlpERmtLRlE2blBIYk1SUHBjY0Vsc3VhcFBnSWJ4RTJpS2po?=
 =?utf-8?B?a3Fad2Y5SUtNbkVDM0p3SmIwbTJiemRVRHUxZWRkQU5ValRyMmhPSHJ6TERw?=
 =?utf-8?B?NkxPcnpudmtVOGFzb0krck04cDVYaml0d2M1OUkrbC9wUmROa1JncUhKK3J5?=
 =?utf-8?B?MVVjT0xPRG1xUmRuS1lza1BvVDVjdFZZZ1FYcjFxQWVUMTFpcE9PaW9McjZt?=
 =?utf-8?B?UGlnbERxSFRQZS9YNTNvQ2VSWkViOGNCSHlhc3cyeWhHN0Z6a1dQOXFIak92?=
 =?utf-8?B?MkNiYWhRaGpvVDJQa0pURzhkMWhKcE13MzZzVDBKanlYdTI5NG1xSkFtQ1FE?=
 =?utf-8?B?RzFGc3lNR1RkdEo2ZGZMUVVEK2Ivb3cvcDVITkNRSXBOaEVyNElHQkJURXR5?=
 =?utf-8?B?aUlVajlsc2Nrd1NPR295cHpvTTJsZ1hmZzVqeE9sOTgvY3Y1WVFWK3BQd2Zn?=
 =?utf-8?B?dXZwVEZ0a2hWRVBGVWNXaHdEWkhjR2ZIZDFPUjcxWUhxc0dUeWJVQk1pTis4?=
 =?utf-8?B?ck9MdWVWTmd3NEVFWmJJY2dlRWU2bUdPemFDRW5zSlc1UlpUNHFDR3NlalFx?=
 =?utf-8?B?MmNCNCtuMjNET0hiQU5EVFV1eFdaeURnOE1temszYVRPMHFvWFd1QXRkYWdR?=
 =?utf-8?B?Q2YzY3p5SDRRNUtwOU9MWWVCVXc1Vmc1ZHpZdnZBMmRnNmpiZzMwL0hYdXkw?=
 =?utf-8?B?NnFQblZzcVBONWY0cjAxVkhGYnBKMlJQNnNoZnQ5bmdxV3NxUDFWUFhnTXps?=
 =?utf-8?B?eTZvTE4yQWJoMVBoU1dNT2dvNWxmZkQ0M1lOSklZaEMyNmxIVUNTd25DQkxV?=
 =?utf-8?B?ZStZMnN2NGJLZXQwaU5Oa01CVVh6cmpIOGZZQ0ZDbzNwL1BLeWtOYVVDVGpS?=
 =?utf-8?B?TWdzL0x5ZzV1Y0VOcGhNa2Y2WGJVUHltS2ZGdlgwMnBQQ3hpV0lBdjNGZVps?=
 =?utf-8?B?M21yZlByQ0dPN3V3YjlEVkNyZGFsNnd2cHNxd01NekZGWjNJNmRMR1FhL3ZV?=
 =?utf-8?B?Ym9YdkdadzczTjlGeldReWRzaHJERVdxUGh3aWpZbHVBVDhpbEZOblQ2UHBv?=
 =?utf-8?B?WFRwWFJiTTkxR3dJb1lCQUhpM3B6RU9iU2dLYThONzA0T0JNRlpyZFRtS2JY?=
 =?utf-8?B?S3dDNkNNdExlK1ppSEdpRHVmbWF6aENIdWI3N29lTnk5aWZJYW1PWXV6QVJT?=
 =?utf-8?B?MmMrTjhROGlNdW1xTlJyekZJemwwZERHc3A1MENPWG0va3hhVDVzTzRHOXJH?=
 =?utf-8?B?cUxabE4vbU5YcG1Bc1NDVk9CUkxCMkRIVHlpUERvTm5KY29IR3EzNVlzaE9Z?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 183efbe1-b268-4c5e-60dd-08dd516989b2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:46:28.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GNZiIIiEYFchsfnbVCfrWB92odnazRcTV1+UdtCpeFrjY6pVFl5jrGmIBrEIuRlrqkb0V6rhCP2tTXPWpjdvzbjbKLtvZXWjqtV+CeguCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> Because ARM's MPAM controls are probed using MMIO, resctrl can't be
> initialised until enough CPUs are online to have determined the
> system-wide supported num_closid. Arm64 also supports 'late onlined
> secondaries', where only a subset of CPUs are online during boot.
> 
> These two combine to mean the MPAM driver may not be able to initialise
> resctrl until user-space has brought 'enough' CPUs online.
> 
> To allow MPAM to initialise resctrl after __init text has been free'd,
> remove all the __init markings from resctrl.
> 
> The existing __exit markings cause these functions to be removed by the
> linker as it has never been possible to build resctrl as a module. MPAM
> has an error interrupt which causes the driver to reset and disable
> itself. Remove the __exit markings to allow the MPAM driver to tear down
> resctrl when an error occurs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



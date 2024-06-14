Return-Path: <linux-kernel+bounces-214196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911EC90810E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27A1B227B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6CA1836E2;
	Fri, 14 Jun 2024 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9v+VWJ0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1A1822F8;
	Fri, 14 Jun 2024 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329786; cv=fail; b=fGRsYm/I6dvj/Zm6Ziw/o5zGU+gDbDu1Jz3+345eP/lTw5cJFCiC9FxDGnGFo6ebaQDjNcAdjnvXO9qfMjeiPTsoXRixv9BDgvLk6/euixjO7TXvmZcWAslaFE1aqaiSvMmWFfj93bgaE+YUxkDo0xWEBtRqFRUlppeW4DIX2F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329786; c=relaxed/simple;
	bh=OEOXDGAGS75XF8EgsDDjuWlWXZsZARZa/LF54T31pv8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iPcOOLAY+bWawgNVmFD4ZYzmUR1dvlIFmBUTYLLUZZECZnJo4oLZeg8B+2Ijst5DvflroyeS/u2o02znDazJ4mzRvm4EMd7RZ5n5wAm+FPsaFRJImEFHcGnwE4X4vgRU15hrihPQAMitSG2jLEkt0uTPA9WYDUUsjz9+qN/4l/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9v+VWJ0; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718329786; x=1749865786;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OEOXDGAGS75XF8EgsDDjuWlWXZsZARZa/LF54T31pv8=;
  b=d9v+VWJ0mOzKF4wyG0CoL+4x0xzK7bEa9+ddRj60TEiKmVIRtPqAQ9Xl
   VktLnkzzvtF5WpLlZsT5IQgyBCJvAoFZfXvsrdOy0OuMONbbtEz/fAc1h
   mXoTlaZ9LVlOy6/WvtB0y+ohoUaY7REeiLzGpJBQzfnXGyE2x5ZyEJLUs
   Zz2t+qiQ5pHgYkISR9cd0rcVnt6VX6ELhuIckc/ARIMwiqkHq9hoOuXvs
   blBFP4DBP4l52LJAP0UX6KNx9NCjDRZ270JBzARnk0IPYRIqGxtE3C5b2
   JUvG6pRR2eD+uYmR+IdkzLbT3WV2txkb1eLd91JZgjHZElJ4UmUudUJm3
   g==;
X-CSE-ConnectionGUID: GGr3BvYBQSG7Lt3y2B9I/w==
X-CSE-MsgGUID: W4w4+EZGSjmBlx2PTAfNfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="19022753"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="19022753"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:49:45 -0700
X-CSE-ConnectionGUID: RqoPkTLdTv+5oR0jBAv3cQ==
X-CSE-MsgGUID: /A+6t+vORsSDOhShWkTYCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40271248"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:49:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:49:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:49:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:49:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:49:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mwuib5u5m/VubrnyIXQGQX6w6TjT5NaGXoolS2kGsdXwfS1AsF5tndaxMubscAJfFA4aLz8hmW53lzTYtJScbcX48GPf10h3Ab+CXn+2cc0Gsqyx2rpfha+dmWIe5sg+geMd2yMVOq3XOsiXNR2s2oLxOq6Yj+NnDC0PDw9gf8+K1szTK94DTYjXJoxVcZoikyU26VCXVPpdURrrxzVbuTU9l/8IbjM7SxOxXYZoKtm9oKpWz6tGouxX0YUMF0Mc4CfZpSuAyT/VjyD6Y/41zslCmaW/QcObdCMPZi5j9u/qcKhnzFlMbAGu6Pgde+ua3yq16RrkXsSw9Hr7qaO/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRHHjHgsk0Mflev+4JE8PIksbZch/RC2LELfJP163VM=;
 b=BYyxA+/ivrjjehCAHad3ASOCuSSQAFsIM3Csq+rVd+MFp7MUrD7rFcBQDvait0QTPOzXMmEMY+JteUi7NnRH0Ep0vwEvrE8TxCbEpQpovFHbwwjyp8KPEUZZUhO9T2kMWPNsCcjI203hiFp9aPi1z/4rr95iYvipSKURdWzHKwS58E4cpj1VgKpErSKrZ93ggqXShDuekNuXSKjUQSQA0GZfc542ABkrKhY1HaT/3nebqG3Fv+KC0toBZ0Kp7x1eCeKH3e2kSi/noRLQo7WJrQt3ed/UgtStTy0VH9WnOk8eegG55S/hmuS49wwz0bY3324nvSSfwuUoHQGxJqh+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 01:49:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:49:39 +0000
Message-ID: <333339e1-5b94-4fac-8d18-f18c7780e6e1@intel.com>
Date: Thu, 13 Jun 2024 18:49:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/19] x86/resctrl: Add the interface to unassign ABMC
 counter
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1716552602.git.babu.moger@amd.com>
 <1964d74c24b041e5c9589040701a6f6aaa839e19.1716552602.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1964d74c24b041e5c9589040701a6f6aaa839e19.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D07.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2c9a09-3714-474c-5c0a-08dc8c1440b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aE1nNmNnNnh1TnFQYVlMdjdORTYzbGdtd21BaDhxcTZGcTJmeWgveVJZVmdM?=
 =?utf-8?B?LzhocmlNaW9ZLzZMWEZ3OWlINHpHUC8vOVU5OFBVM2hiM1lKVlpGVnJoSjVX?=
 =?utf-8?B?SWNKT2YvcWx0UHJieWZpaGprWmFxSi8zSnZLdlNPajdXaVY1bm5mN0NFZENE?=
 =?utf-8?B?SjJWcXo1WXBCT2dSZkwvYnJ3Unl1SlVsK1QybW51ejBScEdsRXJ2aVh6Tm9H?=
 =?utf-8?B?c2tNVlpGaVlFZ1o4VU5kT0Y5aHk0NTZXTCthOUFHcFhSNThWM0RJaGY1YlVE?=
 =?utf-8?B?RXJUSVNkeW51alAwSSttWXVhdDNIL1pxaTdBMHFBUjg3UWEvYzdkUUpETUJh?=
 =?utf-8?B?eHBzdGk0SkE4aEc5c2Vwb0J1OU8zOTFGSVdpVzdEME1iZWtvdHN5NzlkT2Fv?=
 =?utf-8?B?eTBzRmVzVTA1ZGFvQUV6N3F2TytEbjRPY0NGOTc0dHgrSnJkZzJLTFpDLzZp?=
 =?utf-8?B?UUhMR3ZsRGhHYU9DUWUrMkcxa2w2NW5xMXhIY1hlSi8wcEhCdHl1WXQxL0pr?=
 =?utf-8?B?c253NUFtNjZGS3ZYdlozM0lIMExKUUI1eTlURjgvYm1HbXBVeStOSThlMjds?=
 =?utf-8?B?OUFtUThicjBKYkFjbHMxR21DVExQbDAvV1pHdDc1NE9Pamc5K0RDTUM5Szcw?=
 =?utf-8?B?dHJ4akdDWDVkakFaMXRkY3VvbmxvUXhEYkwxQWFBZWhxWFJjcU83bjZEdU1i?=
 =?utf-8?B?WUU4YWZCcG9pT0VYNjMvZmRpa1VoRmZGZFJoS2RzeGRzOWQ1NEhOSVV3NU9B?=
 =?utf-8?B?c1ZGbi9GRU1ZcGpxUkJVVGc4UHVlNzBTd0kwYmVKcTVrN0xFWU9mV1FHL1U3?=
 =?utf-8?B?ajNnSDhJYktpbFhpOUErZk9LZUpJVi91K3lwMmptNjZpdEQ0elFuUmMzN1R6?=
 =?utf-8?B?UjdYUVJEMVNVc1hKanI5WndBMVJDTFdGZ01sWkk4VjhFZGJVNEtIL1NZUWto?=
 =?utf-8?B?WmVnbTU1Z1hkbWRBb2hjR3psUnFKdXMxLzBkKzVQdEYzK2hTSnVhcjRSSWpy?=
 =?utf-8?B?OTMrS2N3blFWSkJza2xoSElpVmNJWFFWRnRlU1JOYURyUlhTWUl6OVB3WFdW?=
 =?utf-8?B?ZnVBdW9hV3FLK1JVdVVEZ05sT2JLeE1GQ1RKK1NtdjJNanprbVcrTGlWUWxr?=
 =?utf-8?B?WVJRL2RjQ0J1MGxxNWtDYTArdTQxa2tsM3ltSlFrNDl4VFA4N2NCK3NiTHVy?=
 =?utf-8?B?VWtNVTBucE9vUDhuQUFtYzYrZzZiYTJjYlVhdzRHYzlSL2dhSDNoQ0tMR042?=
 =?utf-8?B?Y3d2cDk5d2Z0ZXo5L3lXY2Q5Y1U0cHRHUjhWaEdDazlENWIvZHozWlZKL0hk?=
 =?utf-8?B?WGlzY1BrYXR0Q3d4eEkzbmo1ZzcvQWNFV3RML1FYcUJHOElmL2hyQXhwRWhk?=
 =?utf-8?B?d0lKeGpzZjVMTS95M2ViT2ZtYlRSUUI5S2FHQmFVUTZjcUF4WHJtOEt1aGFy?=
 =?utf-8?B?dlZxUEJZd2s2MkRIdWE4YSswMlFMZmp4ejFIR3pLaTY1VVNIbE5ESzBncDhl?=
 =?utf-8?B?VnE0WHdwbGZRT0FTQmdVdTRXcjhKNi9HbkZZNHR4aGpXd1RaNFRVWERWcjAx?=
 =?utf-8?B?eWNHdGI2NTNTWGxtRDlLcWpLTCtHUmhCUk1YMm9LQjlWQm9IMzQ2YXl4ajlt?=
 =?utf-8?B?VDBHcTJEWnVlQURoMGp3M2UzTitSOW1zc20xODlZWTA2eTVmd3VKRk5HaHRp?=
 =?utf-8?Q?AFjSmapYkq93LVLbXMZO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVdjUm1Pc0w0TUErUlRyUkxYOGd0dGNIcTJBMnErMW5zcDRSdkFlUFp4bnVz?=
 =?utf-8?B?Z0hEZGx2ODd1SFdpVUYwMklxWmVLcEdFK1VWaDBNS3d3azRKRVUrZWpUQzZj?=
 =?utf-8?B?SUxDY2pSTURHNTEzT2JsWThxc0xmbFhOYTVyOEhDZFZZRWJXMS9FYTduMGtK?=
 =?utf-8?B?cVZFYmhvS0d5TjdkU1JFSTVZTnZjZXNWejN6dkxYWTBWR01yUjZlTmtCRUhn?=
 =?utf-8?B?Y3VKS1oxTnZ4QXpYZEFnQzdjRmdyeXJDSDN5YnZSV3J0RmF4bnFTNDI1L29u?=
 =?utf-8?B?aUlFb2V3VFE0eTV2OGxrbUZNc0NaVWR3Ly9uUUNCL28vZERtUkJEVndwN2l5?=
 =?utf-8?B?aHF6QlFxckt5TWZsZFNuRFhxcXVmMDY5NGh1TmZpOVJBNUc2cUw0bE5BSm5J?=
 =?utf-8?B?bU9tUWUrbEVQOURwbDZBWjlSVVh4dnVZMnJITW5laktWT0RQRlloeEFRcWgr?=
 =?utf-8?B?Wk9UeUwyUVNJQ1BXZXgvaG1GM3ZGT05jM0JsSjhzQmVtZ2xER29lVi9uY2pG?=
 =?utf-8?B?SXcvbkVWV282VFpUUHNYNm5rejlvVHpSRlRmL0RERjhDT0U5UytkVzBtRnhT?=
 =?utf-8?B?VlRWcE5aS3FMMkpTYVlMZE92MG9uTGxOTDJySGNOWXpVWTZsMUVLZFNoYXBJ?=
 =?utf-8?B?VzkwK3FBTnh4Yk0rU0tpalpSTEhmMjlOMnp5RTBSY1hJbHh2N242azg2eWk5?=
 =?utf-8?B?cUlYM3NXQm5zUnllckRES0RkU0loeUZsTGNzWkRicS9qbW0vVkdRbEFmb0pI?=
 =?utf-8?B?ZGxNSFNONWhDdzM2bnBjdUpGNlBFZm5NelhuR0VwRGxLaGNvTHQ2YTB1M2xJ?=
 =?utf-8?B?MzkySzJVL0ZMWUVKUnVJSVR4U1BMSEpJNWpib1ljUW81dEpaV2dibkNjazVu?=
 =?utf-8?B?NUhLREZJYmhsL3pyek82MWhxRnlpbmJmN3dYVEhRM0ZPS3JZenFjc0tzS0ZM?=
 =?utf-8?B?cVlyYlkyNlV5am5BNEZtc0piNG1LMnhjUENRSkxGYnJIdElDN0lhY3R2UXlL?=
 =?utf-8?B?UllDb0ZxaUpzRXQyQnkwR0Q1RlFLZDFvd1E3Rk4xTHYxUzBhSEJ1eG5GbUhO?=
 =?utf-8?B?Q3J0ZG1vN3lkVHEzdXFvWVF4RFhWaEF3T01yTlRjNXJVK3AvR0l0NU9pT1Rj?=
 =?utf-8?B?NGluNWVBSXJucUZsaDRBODhzNWIva20wUUVIb2poMnhRbjJVZ3AvWjRtejRD?=
 =?utf-8?B?cXlkMXZPVUF6QXpNZFdMMFhONEw5ZkRMZkdpdUZHem9naDhOeXVlMjZyNGlT?=
 =?utf-8?B?MUNaQnJIaThYdFJzR1pXUHI3WVhoZzIwc2FrRDg4b0pYOGxPQVdhanlkdFJT?=
 =?utf-8?B?a1ZJVDZOZ0ZnZVRCclp1U1VXVDlFS01FTWViMmhHc0ZDYm9CZ016Q3ZndFNC?=
 =?utf-8?B?b3l6Z0hnOHYrY3kra2Y5VU5xOTZVbTM5dWZndkFTZElmVzhFa29XRmNad1NM?=
 =?utf-8?B?TE12RmtKdzhEcFk3RGd5ZFVRQTJ3NytZelVPd3c0SFNtVThCbFU0NFdQMlVn?=
 =?utf-8?B?dUZueHRXRUYwQWRHaTExWm84ZTR2Q0tWYnF4cThsRXFFSVE1NmtGTnpvU0Rm?=
 =?utf-8?B?VWM3LzZLQjhkRUluVHJ4UkppWVZrMUZ2MDJmL1dsN1NDQXBKVTVxQmpZRmw4?=
 =?utf-8?B?NFpVMk1vc0RkVGMyeXRwaVE2akd6c2toRWtFTWJ1bzJkbnRiOWRnbXdDWFJm?=
 =?utf-8?B?NG9WV3l0VHZyL1dsaEl1eHpvY09NZ2c3dmRBM0ZieG4rdnV4bXZMN2VKNnpB?=
 =?utf-8?B?ekFRSGVxdFNKMDdXYjFDZXROWjRhYVBGcUQvaG90Ky9DZU9IWElNLzBFTnZ6?=
 =?utf-8?B?RGFDc3FhUEhtUU53azRzTnRSVVlpVzJMYlJTa0ZWcVJvUWIrYi84TnNjTDdp?=
 =?utf-8?B?OU9YSWRyRnhIaG1rRzdzNnBveTdkdnJIYXVTUkt6NkRTc3c5SEJCdXpDZ1oy?=
 =?utf-8?B?NDh2SXFMQzh4WVgxSlZIQlYrNkJkOGxHWVdQTHFadmppV2ZMWlZxcVQ0eE81?=
 =?utf-8?B?MmpEWTM3UlpkNnVIeXd6U0pCTGVrSmZnMVZLM2pXZEpMRnl1Y1lubkdvUWxk?=
 =?utf-8?B?SkFUS2IwOHJzV0lEUEdnYXNyQXdNOXhpVUZVam00aFlZS21MamZlNHg2UHdR?=
 =?utf-8?B?anZJWm9ia3N6K0FvUG44dDBhMWx1cFNiYXRZcExUaDM0b1VrNWNQa09vR0hk?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2c9a09-3714-474c-5c0a-08dc8c1440b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:49:39.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cV8ITQXDuQIr9B1hLst59f6Bef0Ix90v6hZ+vetHalxmOVXxqO4P6wq0f2WPKfH8YxvU5r1RofuKY/ESnAmcqDYCrmJdrINrSUKjxiWadSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> Hardware provides a limited number of ABMC counters. Once all the
> counters are exhausted, counters need to be freed for new assignments.
> 
> Provide the interface to unassign the counter.

Please write a proper changelog. This needs information that explains
what this patch does and why.

> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>      Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v4: Added domain specific unassign feature.
>      Few name changes.
> 
> v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
>      The function is not called directly from user anymore. These
>      changes are related to global assignment interface.
> 
> v2: No changes.
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 ++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a88c8fc5e4df..e16244895350 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -660,6 +660,8 @@ void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
>   int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
>   			u32 ctr_id, u32 closid, bool enable);
>   int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid);
> +int resctrl_grp_unassign(struct rdtgroup *rdtgrp, u32 evtid);
> +void num_cntrs_free(u32 ctr_id);
>   void rdt_staged_configs_clear(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 48df76499a04..5ea1e58c7201 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -216,6 +216,11 @@ static int assign_cntrs_alloc(void)
>   	return ctr_id;
>   }
>   
> +void num_cntrs_free(u32 ctr_id)

The name does not reflect what it does. It neither frees the "num_cntrs" information
nor does it free "num_cntrs" of counters. How about "mon_cntr_free()"?


> +{
> +	__set_bit(ctr_id, &num_cntrs_free_map);
> +}
> +
>   /**
>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>    * @closid: closid if the resource group
> @@ -1931,6 +1936,43 @@ int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid)
>   	return 0;
>   }
>   
> +int resctrl_grp_unassign(struct rdtgroup *rdtgrp, u32 evtid)

Same comment wrt namespace. Also this function needs a description.

> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_domain *d;
> +	u32 mon_state;
> +	int index;
> +
> +	index = mon_event_config_index_get(evtid);
> +	if (index == INVALID_CONFIG_INDEX) {
> +		pr_warn_once("Invalid event id %d\n", evtid);
> +		return -EINVAL;
> +	}
> +
> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
> +		mon_state = ASSIGN_TOTAL;
> +	} else if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID) {
> +		mon_state = ASSIGN_LOCAL;
> +	} else {
> +		rdt_last_cmd_puts("Invalid event id\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rdtgrp->mon.mon_state & mon_state) {
> +		list_for_each_entry(d, &r->domains, list)
> +			resctrl_arch_assign(d, evtid, rdtgrp->mon.rmid,
> +					    rdtgrp->mon.ctr_id[index],
> +					    rdtgrp->closid, 0);
> +
> +		/* Update the counter bitmap */
> +		num_cntrs_free(rdtgrp->mon.ctr_id[index]);
> +	}
> +
> +	rdtgrp->mon.mon_state &= ~mon_state;
> +
> +	return 0;
> +}
> +
>   /* rdtgroup information files for one cache resource. */
>   static struct rftype res_common_files[] = {
>   	{


Reinette


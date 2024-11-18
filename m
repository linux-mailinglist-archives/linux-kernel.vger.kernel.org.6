Return-Path: <linux-kernel+bounces-413549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBF9D1AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086FD2823BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0571E7676;
	Mon, 18 Nov 2024 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMROwzbt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3323150981;
	Mon, 18 Nov 2024 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966709; cv=fail; b=rJOSG6f43BBbX643f7vwC//8okT2gGvNu7htVZn/naVc2RRDnyTg6HP0xplk3eQaW+xIvi0mKB54Dvr2JMJRh3TEb6zpKca2OxjG6o/z9aWwNZqaMA6heb8htRiym5mLquY6NcUBUmOHsT8NomOGyzXm18RdXfwzFN5ApbJeMBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966709; c=relaxed/simple;
	bh=WtwlLPeVtLfIWp79g9S1xB+f4OLvwapTJicWq6CH+1U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DA7PRkN+PCPvP3mgA2KDXltR9hkKcYOVYuxWEMr/1b3tFNtA72GGJB3zVinXRb95iSylgC41Mx4Kdk8VI21+NWjqBvf3bn0Qu9DOPJa76ExhPq82f2z4bv2WGRcrCsu/tvGy48hIOgbZwcFdvKI4DdY4oo3p9BdYgoQlYOq8d50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMROwzbt; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731966707; x=1763502707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WtwlLPeVtLfIWp79g9S1xB+f4OLvwapTJicWq6CH+1U=;
  b=CMROwzbt+dlwwd3VHYB+WHhDYi5Uiv7CuITkMN9bji9wsiWnn6WRPKxA
   xsyzrOcX5Xrc8zJTJtJ3aHR44Awxh05OifmVdaENthtbJmclv50TW0uW2
   9PggRYb95bzk4MLg3erQDvvaW6oYWtVuCiBWHL/iCuASOSUos6V+3+pD3
   KAn22FfvWlbptA1+VwjvjJb2QT4pUtS8vcebLbbtZqiMiF7foepaWq1nS
   fl5YaVNpyBU0SKljPPC01exeOmn9HPKfINMYrcbNfx2DUfex2FA6fWi2K
   vSScHVkqEHlq3NCFtEH0NNvIabPXwL6vNjMB+X9LXYm/dJfHwFuMGB402
   Q==;
X-CSE-ConnectionGUID: cq+IItHwRGSg5IEuPjPckQ==
X-CSE-MsgGUID: 57KLSPxXSVWGSKCnHXIAbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="35717414"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="35717414"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 13:51:46 -0800
X-CSE-ConnectionGUID: zY4H9N6zSwC3orU0+5SyOA==
X-CSE-MsgGUID: D03VFExPSvWvOFXkFU+pJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="94427023"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 13:51:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 13:51:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 13:51:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 13:51:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf69uUYv2qmscrWzbY1WxvXGvs/NzV1zfwdlwOiEhiy5jAIyqFe/THOReKtONYFQrynW0yxYRBKYcySTG9qb6msHuOxixBYoN2aAsEsDZ1CLJghD5waCri8zbNssZ1se8Bx1rR968pvLwPodQhqhQcLMB39gqxcL3QHgSGuTRW2aho4K5HJx7WUMKpBzIdXZZlFEU0j2qS94/30uWt9Ho/qHho8Crw7saCq0t0ztAtCYVvCfWGfsbQFKTbRqC1zN4zRhUX9uS6aV2dPfP47yNFouzO2Z86S3evQJUBKhE75ZlEtA4R5zrxCSVc7C8mo6E63zYsr/ZTy8utpusg6HOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5qNhXT+fZbYhzAWrw+AF6CLVuHDIxEanH/zCzaqoT8=;
 b=kbSSoZHGRSF8BdgR+3/6GvF/ZAyH4YLu93s4EZZJV0gSyiqwq5BmooJW5xBweVeYTedCBkuIdakiMaXsoeZlvO9d3xHi9gXN5rk+TSXDE9io8RFsTcoiFoPe/hxhYvsmBW+AlMd7JcZkHVsFsa5xwyt91j1NPqzGlpOIgmcAgodyQAz14W5/U+z+d540mVSXOOmbVegjKX939YXRTBJxWiF6tFCsa6NHtM9NzyEgo+lav7I22+g95PyhwGaMNYFEa05v8ZUnZ0lRVgvxdesMAosvKx0AwOswGk7Ri6ej9+epuFj6X2/d6hKwBZVg/VdkBtfItBR1jUDfhgfBiV+rFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 21:51:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 21:51:39 +0000
Message-ID: <45384d5f-a6e7-4a82-974d-84e189381b36@intel.com>
Date: Mon, 18 Nov 2024 13:51:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 26/26] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <1dfa8b184a00d94013470b2818c23fd8eab66baa.1730244116.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1dfa8b184a00d94013470b2818c23fd8eab66baa.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: cb819c83-b6a3-460e-cd6d-08dd081b2e79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2tJT1BWcVh5TUdnQ3hYMVc2TkdvemcxTGV3WkZLODhQMXdhekhZN2QzOXZB?=
 =?utf-8?B?Nm1CM1lPZWxJLzhFenU0R1VVYkRDdDY0RU9RTEd3M2FMZWkwTTd6YVBqQXVQ?=
 =?utf-8?B?Um5Ya1BHSWZVLzJSVWJ3VHdsV1JQdzVtelZ0eitvSTZwL01qK2xORjNoUnlY?=
 =?utf-8?B?c2ovNnIrMGpOMStDcEsxTGhxMzdyUHJBKzhyN0tXYitTdmFvSDUyeUgzWkRI?=
 =?utf-8?B?Q0tnc3FVaFduZkdTSER3V2lQc3ZUZUNQcUVWVUhPbVFTR0lEeE9VdmhJUGQx?=
 =?utf-8?B?Q2RHdUd1MFNsWWcrSWkzVFpiOFpOcXB1ZW1hZTJJWnRKQzIwTm4zSjVxWE5K?=
 =?utf-8?B?YWNmaVFJcGRoZnpNY3ZQQzA0M3VWSU5RcGZSS1VsSXhJRHdxSXFNeU4xS2Rk?=
 =?utf-8?B?TjI1ZHhDM1dveGQwR3ZhME5IamZnaG81Mmw1dFlnTXdkZFY2NGNyWXFyQWQ5?=
 =?utf-8?B?cTlBWDhyMTR6WGhXZFJEa2QrcTdGbGpGS3hjbFhhUHlBUDJxb21WcUkyWjIw?=
 =?utf-8?B?V1cwMnZodStsdGhOR0pqcFJtT2R1bGh3WEtGcHc3YzR5OVpIczNMUG1FeDVO?=
 =?utf-8?B?OCtobmIyeVY2SmtjV0JWNlYxNUlSNnhGV3pWcS9JT0UvUjA4azdyNDliSmZJ?=
 =?utf-8?B?azdxUy9qbXRZenhrODZ2UmJOdWEwRUwxZFRzVmVVRk90WnowNWV3VEUrNDNQ?=
 =?utf-8?B?M1FjNDlERk5VOUtpY0lsZFJQNGxlbFF1bUd2b0RSTWFmd0FWTGlFWnlLSXNW?=
 =?utf-8?B?dGlJY2VQTkp5WFJZQTUxdEdrNURrR0F4S1BNbjQ4T0VmUDJlNlpkajBMc2Va?=
 =?utf-8?B?NVlmVzZvMjhuc0dUb1BGMVhUMFBocmxyV3BjNUU3bkdYUE40amhOWHp6Y1Zs?=
 =?utf-8?B?V0ZNaEpBbzVRaGsvSnVYMmVoVCs1RUk4MXhHZ2ZPWWpoRmgyMVVwdlRhV2Zs?=
 =?utf-8?B?Z09ZVnFyUnVMRFhJMmc3NU80TURieXFQS2djS3dxbk5WbW9TOTd5WU9kd0xu?=
 =?utf-8?B?dG1vNVNWVUQzMEVxSEU4d21jWXlrZ09xOGdUeGFYYVVZcHBydS90SFlxcjVS?=
 =?utf-8?B?OW1nN1FYZXJYS2taN1pEQW0zc3RRR255M3c0dVExUktyVW16SkJvUU12aGdi?=
 =?utf-8?B?ekd5VjdmQmQrZUpwTmVFcDAzWHh6aHMzWWNxSUhGczcvUWRicHd6dStkS0sw?=
 =?utf-8?B?SUdDTWVaK2Nwb2dTUXRDby85MStFRGlUNkc0U21HUXgvbDBzR2FaUUlTaCt0?=
 =?utf-8?B?bkJMeDEwNEVlMXJUN28zT1ZqV1RRZGs3UmNMWEdVdk95UHQ0L1hWY3g1bDM4?=
 =?utf-8?B?V1Q1ZGRDendjQ3NHWkFTOUhzeWlua1JKMDI4S2ZRdnczVGNkaTd2R1BYUzMx?=
 =?utf-8?B?VkFhOERqcHFLdi8xenU3MlFHeXRnaXlOdG8vWTF4ZG1HTjlQT3hOc1QxRGor?=
 =?utf-8?B?VjNBWFAvMEQ0N0VlZ2tqaGxvNEQ3ODhSWFh2K1h0RmVBT0VxSXZvN3VKTjJw?=
 =?utf-8?B?aFJ5TFR6bEVtbkdqU3pPZXczLzd6dWVNK3dyS2JoK3FjdXZSTGVLbU9ZTk1R?=
 =?utf-8?B?dERvaUh2Y3RsdGU0bXlmMmxRNmlKZVFSQTh3SkY3WWYyNzd4MmdRc3FkRm0w?=
 =?utf-8?B?bUpKeVNYeGMxdld6Zk9iMDJOU29FU3ZoWmRicWhHTE9YTVJseE5aRFJ2OGhy?=
 =?utf-8?B?dDkxc3JXWXlDQXRER1NEZkN3VElueVU3V3orbnFtTUh2RGlHMGF4WDkzQk5U?=
 =?utf-8?Q?H6xk+cgalHWtGMWmrOvwsx/u6zSInkG1+9AgBoB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5iUkd1bjBZbi9LbUVIVG4xSy9YQlozVzJSRUxpczZPVVlMTlgwc3RJTTdI?=
 =?utf-8?B?NGVWZnZQRlQ0d0QzOUdGUjNCenZxYlNPNGxCaFFGN05SSjQydkxzM3o1Y09T?=
 =?utf-8?B?REtLZ09FeW9KNE9pakkwNTZmVDJjdmp2M0prSDl2L1dPQ1BUNmFQRFVOeCs4?=
 =?utf-8?B?Nzg2dWJFSHJkMURUalAyQUFzZnArd1pJaEdUL3J6aXd0MkZhUjZKa2hzUmw2?=
 =?utf-8?B?cmV1YWVjRXMxTVhXT2E0aW01Kzg1Q1dNNXhJWGZaQ0lCaFNzZVVtUk1CeEtW?=
 =?utf-8?B?Tm43WlJWM3Z4RFFPVHlaZmt3T2dBb1drVDViUERPbmtnVEM5Wnl3bitkMmxs?=
 =?utf-8?B?RWttRXZoUm9Ic2hJczlzZW81Yi9BLzVZUEU4YXVLL090QS9RR2lodjVBYzc1?=
 =?utf-8?B?OWg5VjFJRWZZZXJ0NHhXNHhqN2Y2Tm1QZ3E5NlN0bDEwaEVIOGpBUDYrU09v?=
 =?utf-8?B?VjRWS05zelAwaE5yMnFhSjhHVXBQbGQyaEdiMmtvOW4vT0M0NC9oMitmZTZk?=
 =?utf-8?B?TWNNR0lzbHBnWG01SThxRzVHb3czRGVaallLdzZoSStUMlVXdDV2UHdNdnJh?=
 =?utf-8?B?dUJhczlsaXZLQVFhZWF2U3k5Rzlqczc3bmYybHVMRmZqdG5aVWp5MHVUcEF3?=
 =?utf-8?B?YnBrTzlBeDUwNjNJa1p0T0hMZVROOEJGYjJCeG1tSG9vSDF6WVNzUnhKaEFq?=
 =?utf-8?B?MXJBaFJWZDRYV2FDT2plMzMxYXRXRWt1T2ZSVXg1R2JPSHhyZFlQYmgraUNy?=
 =?utf-8?B?TjFVa05DSHEvb1RENFlyRmxMekExK0pMcUVsRzNTMUJBVmdVYjFHTk5vWFAz?=
 =?utf-8?B?Q2x3R3BqYTkyU0l5VzhyMHl6NWlqTW50WDUvQ1lYSDZFQTdoeHpTVzl6N05Q?=
 =?utf-8?B?S3oyL3RFZHp3R0FmM1EzbDdJRitIOWMzaklMUmpNTU5VcWZ4V2JLdy9STFJk?=
 =?utf-8?B?U0crR0w3MlRoVVhUNG9HSmwwZXdlbUo1TXRPdnpjc3JURWhOSXdwR3R4MU14?=
 =?utf-8?B?T2tSNHdObk1MWEwwclN1K241dFBzWTI2Zkp6RExHVGF6M2NoL05LRmQvK2Mz?=
 =?utf-8?B?b01zaG1JTm53UjN4b1ZwTDFtYW0zaUFIaTRuM0hqMTUyOWx4TzA4SDNia29w?=
 =?utf-8?B?aThkcjd3Rm5hN1hianhESmFGQldGektaS05JdVJycE4vNThJZFZNN2pMUWt6?=
 =?utf-8?B?RG1qSjREOGdJeDVKdDc1bWdScHhHYTc5cjV3MEplZi8wR2xuM0x3MVJhU1Rs?=
 =?utf-8?B?M3hSQ3RXU3hHZE1WdWVKa0dPNUtsaDUxQzVOOGJMeDdxazgwL1c3TXBVWk9w?=
 =?utf-8?B?d3U0c3FVRjgxTi9BUklTQ3RqZ0VDYzVEZGRObDBMQ3BnTnpEVlBjaGNpSG9s?=
 =?utf-8?B?UkR6SkRCSEQyUW8wQi9TcVV3QVk3a2thY0l0UU1QWmNDcVJZaHMzMjg5ZW50?=
 =?utf-8?B?S2w0OVJhdE5qeXJtc2x2NXVrQ3ljSElLaFYwTWRJMEZrRDNhZXV3Z2FCcnk4?=
 =?utf-8?B?UUR0UVFLNGZ4ZU1pdEFlRlNPbFRhQlcrK1UrVFZxMnIvdCtEODR5UXpBVDhu?=
 =?utf-8?B?ZXluckJNcFJYL3ZaV0ZiaTdDanBUN0FLVHdNdnlURmt6dHlHTU9Ga0RjWFNP?=
 =?utf-8?B?b3pKOUVmczZNVkc2eXhJYmJrMVFDd1AxWkhmM3doc3RNRnlQUjhVek5Gc2sz?=
 =?utf-8?B?MlVkNXJRVDkxYnZaSDZHNWhmanNFZDdTOWRBWlQvVlpEUDFPQUN4ZCtEZFBT?=
 =?utf-8?B?TlpwWW92bjNQNzhQS05VNjkxNzBDeXNybEE5VnNGYlRmTmNXS2QrVVlpajkw?=
 =?utf-8?B?c3dWUU1OdHJGeW80N0tNS3JwSmdUdVF3SlJRZnNQUlhYdm9JVHZvRkh6dzJS?=
 =?utf-8?B?V3pwZmhpQzRvU2dRaTdFQ0hQV01KM0pOSTZSTUZHSDY2eEhoZ1lXM2JBanNh?=
 =?utf-8?B?aWZMYk5QZFV1aytJNmxxKzlMMld3VFB4Z0l3NnZjZGUvNGt4YUF2cnZmVlls?=
 =?utf-8?B?NG5zWFhmSmpyMFQyMlhCOE9ha21vT24vWVprSTJLb1E2M1B5QjJQTVR2ZXBN?=
 =?utf-8?B?NWZ6KzlWQ1dDeWliQXJOa2VkSjlKWmI2RTlQVTJYUFRkUHNkNTRlaUQ3ZmZD?=
 =?utf-8?B?QU5nMWZ2Y3UxVXpoWXdLaGpxRHFLdFRDVkRIaGN6eHI5TzVBbHcvSUhmUk1R?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb819c83-b6a3-460e-cd6d-08dd081b2e79
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 21:51:39.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnRkPoDmxw26CEtQULVDyNDWpVhp+3xGn4zbRzcpzBb6u2K2dqBwGMR19Aj74Y/hNQC2ZHQ4wy9A/78KmJtNzCdoTqA1FPESxW5MWwTi1eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> Introduce the interface to assign MBM events in mbm_cntr_assign mode.
> 
> Events can be enabled or disabled by writing to file
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> Format is similar to the list format with addition of opcode for the
> assignment operation.
>  "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Format for specific type of groups:
> 
>  * Default CTRL_MON group:
>          "//<domain_id><opcode><flags>"
> 
>  * Non-default CTRL_MON group:
>          "<CTRL_MON group>//<domain_id><opcode><flags>"
> 
>  * Child MON group of default CTRL_MON group:
>          "/<MON group>/<domain_id><opcode><flags>"
> 
>  * Child MON group of non-default CTRL_MON group:
>          "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Domain_id '*' will apply the flags on all the domains.
> 
> Opcode can be one of the following:
> 
>  = Update the assignment to match the flags
>  + Assign a new MBM event without impacting existing assignments.
>  - Unassign a MBM event from currently assigned events.
> 
> Assignment flags can be one of the following:
>  t  MBM total event
>  l  MBM local event
>  tl Both total and local MBM events
>  _  None of the MBM events. Valid only with '=' opcode. This flag cannot
>     be combined with other flags.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v9: Fixed handling special case '//0=' and '//".
>     Removed extra strstr() call.
>     Added generic failure text when assignment operation fails.
>     Corrected user documentation format texts.
> 
> v8: Moved unassign as the first action during the assign modification.
>     Assign none "_" takes priority. Cannot be mixed with other flags.
>     Updated the documentation and .rst file format. htmldoc looks ok.
> 
> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>     Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>     Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>     Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>     Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>     Removed ABMC reference in FS code.
>     Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>     Not sure if we need to change the behaviour here. Processed them sequencially right now.
>     Users have the liberty to pass the flags. Restricting it might be a problem later.
> 
> v6: Added support assign all if domain id is '*'
>     Fixed the allocation of counter id if it not assigned already.
> 
> v5: Interface name changed from mbm_assign_control to mbm_control.
>     Fixed opcode and flags combination.
>     '=_" is valid.
>     "-_" amd "+_" is not valid.
>     Minor message update.
>     Renamed the function with prefix - rdtgroup_.
>     Corrected few documentation mistakes.
>     Rebase related changes after SNC support.
> 
> v4: Added domain specific assignments. Fixed the opcode parsing.
> 
> v3: New patch.
>     Addresses the feedback to provide the global assignment interface.
>     https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
> ---
>  Documentation/arch/x86/resctrl.rst     | 116 +++++++++++-
>  arch/x86/kernel/cpu/resctrl/internal.h |  10 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 236 ++++++++++++++++++++++++-
>  3 files changed, 360 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 590727bec44b..d0a107d251ec 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -347,7 +347,8 @@ with the following files:
>  	 t  MBM total event is assigned.
>  	 l  MBM local event is assigned.
>  	 tl Both MBM total and local events are assigned.
> -	 _  None of the MBM events are assigned.
> +	 _  None of the MBM events are assigned. Only works with opcode '=' for write
> +	    and cannot be combined with other flags.
>  
>  	Examples:
>  	::
> @@ -365,6 +366,119 @@ with the following files:
>  	There are four resctrl groups. All the groups have total and local MBM events
>  	assigned on domain 0 and 1.
>  
> +	Assignment state can be updated by writing to the interface.

This is already a bit far from original definition so it may help to be specific what is
meant with "the interface". For example,

	Assignment state can be updated by writing to "mbm_assign_control".

> +
> +	Format is similar to the list format with addition of opcode for the
> +	assignment operation.
> +
> +		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> +
> +	Format for each type of groups:

"Format for each type of group"  or "Format of each type of group"?

> +
> +        * Default CTRL_MON group:
> +                "//<domain_id><opcode><flags>"
> +
> +        * Non-default CTRL_MON group:
> +                "<CTRL_MON group>//<domain_id><opcode><flags>"
> +
> +        * Child MON group of default CTRL_MON group:
> +                "/<MON group>/<domain_id><opcode><flags>"
> +
> +        * Child MON group of non-default CTRL_MON group:
> +                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> +
> +	Domain_id '*' will apply the flags on all the domains.

"apply the flags on all the domains" -> "apply the flags to all the domains"?

> +
> +	Opcode can be one of the following:
> +	::
> +
> +	 = Update the assignment to match the MBM event.
> +	 + Assign a new MBM event without impacting existing assignments.
> +	 - Unassign a MBM event from currently assigned events.
> +
> +	Examples:
> +	Initial group status:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +
> +	To update the default group to assign only total MBM event on domain 0:
> +	::
> +
> +	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +
> +	To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
> +	::
> +
> +	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to unassign
> +	both local and total MBM events on domain 1:
> +	::
> +
> +	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
> +			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	To update the default group to add a local MBM event domain 0.

"." -> ":"

> +	::
> +
> +	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all the
> +	MBM events on all the domains.

"." -> ":"

> +	::
> +
> +	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=_;1=_;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index b90d8c90b4b6..3ccaea6a2803 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -74,6 +74,16 @@
>   */
>  #define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>  
> +/*
> + * Assignment flags for mbm_cntr_assign feature
> + */

"mbm_cntr_assign feature" -> "mbm_cntr_assign mode"?

> +enum {
> +	ASSIGN_NONE	= 0,
> +	ASSIGN_TOTAL	= BIT(QOS_L3_MBM_TOTAL_EVENT_ID),
> +	ASSIGN_LOCAL	= BIT(QOS_L3_MBM_LOCAL_EVENT_ID),
> +	ASSIGN_INVALID,
> +};
> +
>  /**
>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>   *			        aren't marked nohz_full
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5cc40eacbe85..9fe419d0c536 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1082,6 +1082,239 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int rdtgroup_str_to_mon_state(char *flag)

It seems strange to me that a variable used to contain flag bits
is of type int. Why is it not unsigned?

> +{
> +	int i, mon_state = ASSIGN_NONE;
> +
> +	if (!strlen(flag))
> +		return ASSIGN_INVALID;
> +
> +	for (i = 0; i < strlen(flag); i++) {
> +		switch (*(flag + i)) {
> +		case 't':
> +			mon_state |= ASSIGN_TOTAL;
> +			break;
> +		case 'l':
> +			mon_state |= ASSIGN_LOCAL;
> +			break;
> +		case '_':
> +			return ASSIGN_NONE;
> +		default:
> +			return ASSIGN_INVALID;
> +		}
> +	}
> +
> +	return mon_state;
> +}
> +
> +static struct rdtgroup *rdtgroup_find_grp_by_name(enum rdt_group_type rtype,
> +						  char *p_grp, char *c_grp)
> +{
> +	struct rdtgroup *rdtg, *crg;
> +
> +	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
> +		return &rdtgroup_default;
> +	} else if (rtype == RDTCTRL_GROUP) {
> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
> +			if (!strcmp(p_grp, rdtg->kn->name))
> +				return rdtg;
> +	} else if (rtype == RDTMON_GROUP) {
> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +			if (!strcmp(p_grp, rdtg->kn->name)) {
> +				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +						    mon.crdtgrp_list) {
> +					if (!strcmp(c_grp, crg->kn->name))
> +						return crg;
> +				}
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int rdtgroup_process_flags(struct rdt_resource *r,
> +				  enum rdt_group_type rtype,
> +				  char *p_grp, char *c_grp, char *tok)
> +{
> +	int op, mon_state, assign_state, unassign_state;

Same comment about type ... these *_state variables are used to contain
bits representing the flags of the various states. An unsigned variable
seems more appropriate.

> +	char *dom_str, *id_str, *op_str;
> +	struct rdt_mon_domain *d;
> +	struct rdtgroup *rdtgrp;
> +	unsigned long dom_id;
> +	int ret, found = 0;

Could found be boolean?

> +
> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
> +
> +	if (!rdtgrp) {
> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
> +		return -EINVAL;
> +	}
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +
> +	op_str = strpbrk(dom_str, "=+-");
> +
> +	if (op_str) {
> +		op = *op_str;
> +	} else {
> +		rdt_last_cmd_puts("Missing operation =, +, - character\n");
> +		return -EINVAL;
> +	}
> +
> +	id_str = strsep(&dom_str, "=+-");
> +
> +	/* Check for domain id '*' which means all domains */
> +	if (id_str && *id_str == '*') {
> +		d = NULL;
> +		goto check_state;
> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Verify if the dom_id is valid */
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
> +		return -EINVAL;
> +	}

I am missing how "found" is handled on second iteration. If an invalid domain
follows a valid domain it seems like "found" remains set from previous iteration?

> +
> +check_state:
> +	mon_state = rdtgroup_str_to_mon_state(dom_str);
> +
> +	if (mon_state == ASSIGN_INVALID) {
> +		rdt_last_cmd_puts("Invalid assign flag\n");
> +		goto out_fail;
> +	}
> +
> +	assign_state = 0;
> +	unassign_state = 0;
> +
> +	switch (op) {
> +	case '+':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		assign_state = mon_state;
> +		break;
> +	case '-':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		unassign_state = mon_state;
> +		break;
> +	case '=':
> +		assign_state = mon_state;
> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (unassign_state & ASSIGN_TOTAL) {
> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (unassign_state & ASSIGN_LOCAL) {
> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (assign_state & ASSIGN_TOTAL) {
> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (assign_state & ASSIGN_LOCAL) {
> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	goto next;
> +
> +out_fail:
> +	rdt_last_cmd_printf("Assign operation '%c%s' failed on the group %s/%s/\n",
> +			    op, dom_str, p_grp, c_grp);
> +

Can the domain id be printed also? This seems only piece missing to understand what failed.

> +	return -EINVAL;
> +}
> +
> +static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
> +						 char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	char *token, *cmon_grp, *mon_grp;
> +	enum rdt_group_type rtype;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
> +		mutex_unlock(&rdtgroup_mutex);
> +		cpus_read_unlock();
> +		return -EINVAL;
> +	}
> +
> +	while ((token = strsep(&buf, "\n")) != NULL) {
> +		/*
> +		 * The write command follows the following format:
> +		 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
> +		 * Extract the CTRL_MON group.
> +		 */
> +		cmon_grp = strsep(&token, "/");
> +
> +		/*
> +		 * Extract the MON_GROUP.
> +		 * strsep returns empty string for contiguous delimiters.
> +		 * Empty mon_grp here means it is a RDTCTRL_GROUP.
> +		 */
> +		mon_grp = strsep(&token, "/");
> +
> +		if (*mon_grp == '\0')
> +			rtype = RDTCTRL_GROUP;
> +		else
> +			rtype = RDTMON_GROUP;
> +
> +		ret = rdtgroup_process_flags(r, rtype, cmon_grp, mon_grp, token);
> +		if (ret)
> +			break;
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  /*
> @@ -2383,9 +2616,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "mbm_assign_control",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= rdtgroup_mbm_assign_control_show,
> +		.write		= rdtgroup_mbm_assign_control_write,
>  	},
>  	{
>  		.name		= "mbm_assign_mode",

Reinette



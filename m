Return-Path: <linux-kernel+bounces-349852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7F498FC39
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F67B223DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947817C67;
	Fri,  4 Oct 2024 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrHXCqnj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970E29424;
	Fri,  4 Oct 2024 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728008271; cv=fail; b=mNXeeVPAWTzAvl1DZpzjjobjtpJyHl9ijbt6APN9a4BoZ7PRk0bCu3oZviRbhhLbzPgBUutq3TJrhgT33wJnAaWHWgFfi6DVtsulH3q/Sf3bHarLlZPBJMeEcrJbAh7GjeOllsdNJZVj3vxZ/u7rO322D4pu+aCua+RoDeG+zDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728008271; c=relaxed/simple;
	bh=4txzmGIlSOHsQEFgCQH2KKYXYHVTOr2jrer4/MqPgOY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ug/5qDZ6J1ntbbaszcRDOLabIwB2skYC0fULIr5nR3uG4FHSQDXa4Xz3pF23iMgAKPX5eyBq1FT2Ya2pdUfeYhpvOLYC5m/BJHPZEuUTAZ3EV/VksvNIW2QDX6AwERhVOjFeLq+Trzl1IvDxS1X9fGLLEHuC/5pv+paBAlZXmB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrHXCqnj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728008270; x=1759544270;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4txzmGIlSOHsQEFgCQH2KKYXYHVTOr2jrer4/MqPgOY=;
  b=lrHXCqnjGSIEaOd7s21A1EqRKqihRZx/nM4QB9pl/UemRFdkzrftPiBS
   KJLdlLrIeG0rRnAACEFW4gzvfb8g8hP2ko502eUCEynRFzVSCt24dRryj
   eELkrrhwFYkLotH5ZaGLry0RWwEfxxQiF26cs1dvan61MljgU5eqYEqef
   9korjklYxkHFoPGqCHDNLG3G1IqthEwKXGCQpN/105MzFiLuI46NjTOYq
   LvTLvIEGSCkoqmqQVKZ8pE53TkCjmDa/7nNkHzUzelUxuaDYc9qPpwu4/
   egYi5B7ffyw29bDaljSMlQIlb03ZPArxfzaH281c1zQe815uw85RWMj5y
   A==;
X-CSE-ConnectionGUID: OKKpYxG/SmqC9lVNg7tKyw==
X-CSE-MsgGUID: 25XOlTZwQR2/OnUWYqutNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27360555"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="27360555"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 19:17:49 -0700
X-CSE-ConnectionGUID: yTYTXkacTjSkoih/RRSymw==
X-CSE-MsgGUID: 0cP41GU2S/izxXLcGqaXhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="74812657"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 19:17:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 19:17:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 19:17:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 19:17:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohOpcaAgXl5bJYSuJPcHyjXPtU3q05x8eeaJU7Aijhy4ABQt8FVCzlEBOSgHSCilUNQbSC8W+kpkxaYvkzNupnhsS6c+9qPLrf0Cc027icsQ88gy/sO8R/uLosgcnoXjZ+4elgcM8KK+iILXpp3T/kwxMTPm2O+GrpdQJksmz8mMrhu8Xjuw94dquVfc7aEd+sHM1SnuQb1+w0SPEMYPQdC1cQ8QpBdD3rbFt04L+eB8BgCsc3oWB+fjfdmLffa3nJMZ6LEFfxYsnXy6jDq+WnwrrLpcFewF3EljY7whiMMGAsJXE8cMMyK2m3oDdrwMIVgNy6AZAolT/a0MEV6mSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyqTa8IG7r7SIDTwweTuAfp+UcWrLCkKvj5ctB/DrTg=;
 b=jaWDl/DauA3MRPVqCsdl/ecpW8lR1W7jYxKrN7hlJn52sj2kAGN7jTUKyyACmQHhMKL8ZjfJN1OUCg0vBrLpFghm3H1ybsVNlCGQ7WJgAPicJTzh4TDx7H/FwnXFjGtyAXvBz5NMi4Z3EhwWIJTbXUebaIOC8Szp01LkYQHRm7NsswTAWQAv3xtzFKw1GnAnRhCt39X9hWUsRxHV+PP1St4SNX2LVMB6Oa6Tj4mBeaiecooLhaCJffQDQhiDZ4yCIzVj+Sw8z+QCjFnl8NSuLbrK6QpexxJCTDAznHA5zCU4+eQoIbB4iCnFLD/TtJgJgin5OaLNS8Nwz89pj6ORQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 02:17:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 02:17:42 +0000
Message-ID: <cd2d835b-cc63-4416-b0ee-20334b9b43dd@intel.com>
Date: Thu, 3 Oct 2024 19:17:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
 <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
 <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
 <1d987ed1-0065-4e4b-a719-65af93907974@intel.com>
 <ca7b1d14-e37d-5f0d-9371-32d8506e51eb@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ca7b1d14-e37d-5f0d-9371-32d8506e51eb@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3b22d1-fa2d-4253-4d3b-08dce41aba01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tjc3MEgyaEdndTFrSTlNNGU3VjR6Vm02VVova1h3VHYyVVk1d004Y05RZGNR?=
 =?utf-8?B?aWJrZUp2NzIzOXNBK0FOTkhxbCtPeVpHaGxxc1ZsWk5DZ1AvNHpvOHFRNmRR?=
 =?utf-8?B?OFBKZTAweTVqMmxIYXhKdUh6b2ZKOE8yY1FnZnhrTm1MVmZzZU9VVjA1RUx2?=
 =?utf-8?B?ZHBYNXpjWExRUTRkVzZZSjdDV2IvQTRBRDF4dTI3M1J5MUJnN2Z5QXlPY0oy?=
 =?utf-8?B?d2FBeW4xd2d5MmhiVSs1azdiMlpzMCtrMlFjYWs3TFpoWjVjWjl3cmV0UXVY?=
 =?utf-8?B?MkRnRVNGTXIyZW9iNHhYVVZ4WkoxazFicElSRytoZXBNNnJmdlI2aTN4WStp?=
 =?utf-8?B?TGxvTkJxZzUwYVc5aHlPMllQZmFJOXUrRW5ub0V3d3UxWERuOFYzMXMxN0E3?=
 =?utf-8?B?YkFLT2pnSjE1QWpWaG12YXh4Zy9Xblg4bUpaMlo5RTBWRnpwcFZ1NldDb3Bk?=
 =?utf-8?B?K056SzJySjdOKzRyQmtMbXVuRUF6b09yTWVUSmxQRXY2VURKenVHYmlNNFc0?=
 =?utf-8?B?UjA2RGEyNEhtZW5ETmdpR0J1cE9sRVdIU29IU1RkMExCZU1sczJWMEk3a05N?=
 =?utf-8?B?dnpzT3dtUHJoRVkrZ1dLekxyNWFpTEg3NVM3eFdyOFpaOVNCVXlJbEZ3Nklm?=
 =?utf-8?B?dmI4SlYwczQ4bDVzbVNQdE9FaEZxc2VnUk8vRmV0NkdHRkFMaVk1amhnUjVY?=
 =?utf-8?B?dGV1V21HeEFqOE9BMGNpaThJNkVaQ3ZNMGVzZVRzVWlkL1VvTGRmdkhHaVZp?=
 =?utf-8?B?azlMbVNjZ1VjblRSTkhZODYxcFhZR2EyaDNLUWsvMTBMWmc3ZENUTDRKWVBp?=
 =?utf-8?B?MysrOEEybUVMTnQwcGQ0M28vb1Q2YVU0UHMwVVNrd2xMaDg2WW1pcXNjdis3?=
 =?utf-8?B?RTRhSmRIMlJVZi95L3QzR2dnN3ZvMk1nbUREbVNZL0NwYVVGNitUMTR1bW9z?=
 =?utf-8?B?TGZKWnNocklQOHVGL2RHZEdlYVZnK2NjL0NONFU2Qk92dVh4K3FnUERUWjRC?=
 =?utf-8?B?cVUvUGg3WUg1MG9LL1dEWlFEMjN2OEhWL3lQR3VPQzlKZGNKd2xoV3Z2VkZz?=
 =?utf-8?B?VFFzNVRpZDhwbHZDUmZEc0t2allnZDcvNUpGcU1zMEVyR1FKSHp4ZHJnekRk?=
 =?utf-8?B?YkZDeEZPNjZvNzVnN0lEdExDTzlOczNlR1pmMnJkR2Q5cDRxV0oyY0hkVSty?=
 =?utf-8?B?OFp1YndUUEZ1RWwvbktHYTJXTndCVmszcDQreERRZE1obW56NnhNNDVRMFN1?=
 =?utf-8?B?YkgxeHJMb0RWQ3IvSGNhVlQ0bUdtdzFqRmY0TG9HNytSRFlZZS9qWWZveWtr?=
 =?utf-8?B?WmNlTGo3VE81dnNyMXp2amh4aEtoVi9EaG54QWswaXRoWGtSMC8xUEpWNE4v?=
 =?utf-8?B?UGlramIrbC9CNmI5ZnYwTnUzTXV0NXdrQnBDR0VKakZWODJiTkhzaWlxaUk3?=
 =?utf-8?B?K3hvRU05cnJhUWo3Mmh0WjJncTF2ZkF6dWJkSWl6MEl6L3U1N0VTZ0RZU0VT?=
 =?utf-8?B?WGh4RmNoTHF0bkVVNmhiTmQrMlUyZXl2QzJRM0JSWUcwa3ZwdTRrMkZYSUZi?=
 =?utf-8?B?ZHVEcFEyWFk1b01RT0QweUpxM2xvRlFSM2lxRDlDRjZQRU5ETHhUYk1NcjB6?=
 =?utf-8?B?cWVMNzEvV3A1NTd6a1pvbndkVXdFQXp6WC9UWUdPUGVJZWlpTWZHUExyelFZ?=
 =?utf-8?B?S3dzQjc0VFBTbU9MSzlWeEZEaTI3eWFJam90djJ3T3EyRW9IOW0wdEpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnp2cWdzc2ROUUpqM0Z6aFVEY09SRXh0V0hPcVNvOWYvMFBJOUtmK1ErWkdN?=
 =?utf-8?B?MnJlMDYvRkFWYzUyWldtak13RFlDc1lPa3RFdFY4SitIMnFFdkxycU1qQlli?=
 =?utf-8?B?ZnFKSFZ3bW1PcElCR1FKckRDYU8vZTJWcnZMMTBXSUQzTVVLUjZiU3JYcHJh?=
 =?utf-8?B?RjhmbTFXSmp6bzBuSkVxV1hkN2hCTHNhRmk0Y214eXEzOWV1M0Vpb2k4bjQ5?=
 =?utf-8?B?SnhtTWhvMlZ4SFNZTDJJbnRJYU94N2w3T3hSTnpzNFdHRllFSFBqV0hpZ2Ju?=
 =?utf-8?B?VVlBemJiYjF5eWJuMUI5Z1RUNDY2NnoyTUxIK3VKR3hhQlFzMHorbXNkajNl?=
 =?utf-8?B?N1MydzRpcDBYblBMTC9zWVpyUTlCTldVelEzMnhDazVyNnpTRDl5QXBGQVpv?=
 =?utf-8?B?bU9rM1Y0b0ZTbUpuamtPNG9KTis5YzdHR2hvb2Z3eGNQTVJPalBKL21JUGx4?=
 =?utf-8?B?cmVLZU5TQ3ZzdHFBT1NFNTVrSytmUUpkcmFVSFdsekdZd2lWN0dRKzk5cXJ0?=
 =?utf-8?B?bkNOS2E4N0VyKzk3WHhTSFJqNVpuWkRtQnJ6ZDlZV0ppeUxiR3hHRnB3TTBL?=
 =?utf-8?B?NnlvQUJqR2FWWndlWEdqaXptVU9wc1hSK2NsY0hUTlpOLzkrTUcrYzh3R3Z2?=
 =?utf-8?B?a3ZNL0YzeGxWSHhvT2xkOHlZT3krY3M3UmEvR1ROU2lZMzI0Znhia2J2aUFz?=
 =?utf-8?B?eEY0d2JEMUVrTVVFdlZvcHVGejFnQWxSTGlyK0dxZ3BIVzROcFJ3S3p4QW9O?=
 =?utf-8?B?ckZkT2J1Y2VJN2NJd3JiSGd2OVRpZ2tpaVNUSnJBNDhuR0RWdTg2azhIQjNB?=
 =?utf-8?B?cEZ6RmVSQU9tOVFaS3JSaktOUjVJWkRZSFMwZHpPZk9kQUF2d21sOC95YUNP?=
 =?utf-8?B?aVJLMWgyVnpYZ1kyU05RVkpGMnd1QldmL3NDK0srZVhKUGVmMFRTVXc1Y3V0?=
 =?utf-8?B?eXZxcUt1MTJsbjJQQjBHblBWMjBIVmpuVjZ0VDVqUFpWRHNzVDlYN0FWNDBT?=
 =?utf-8?B?K2VWRXVLcExxT0lQblVoN3Fyb24rUmlNaTNLalhONmo5d1lieVhsQThSRVBq?=
 =?utf-8?B?MnZLVytEUm1uV2l4L3lGcEIvZlRuNlVwUjJBSXUrY0R2VEtWSTltRjZGNWFj?=
 =?utf-8?B?ZUs5QUovTUZzaWZLR1VWOG1YbDJFbmpRL21EVGNkZWVoNFNSWDJXS1BMVENS?=
 =?utf-8?B?bG00WUxXVEJBOU50UExkTXBhb3VLNWhoSFQzRkVxZlZDSWxxeURZZzRxTVdX?=
 =?utf-8?B?cmtnVW5nSEloRHYzSUMwNS85QXlzd3BRblArSTZlTW0yK0tqTGUyN09nQld0?=
 =?utf-8?B?eUJ4TlpHRytuZjVtYUVPSnBXTEJwdFh1b3J2YnpFODZFV2VzczFiMjMzT0o4?=
 =?utf-8?B?U0VSRGZLUm9rK0JBaTBFSmhqQkpudFpNbXhQUkdHTy91b3JEelF0Mi9tRm9Y?=
 =?utf-8?B?ZVA2ZGFvYk1LYndqRk1tb2JRaUhYZXVHQktEaUFRL3hpT1V5YUEyUERmQStx?=
 =?utf-8?B?VGRicG1tZEx6UUd4RkdadUN3SFFhTXZUdE12bWZ2blBPWGRCTUI4YUVramFh?=
 =?utf-8?B?all1UmU0SGxqdnIxM0NaNmdFc0FPUzVPTXgzeld4dWVOeXJ3dEU2RW9MU1hw?=
 =?utf-8?B?ZG1pSXdlelNDakU1MEd4Vzl1MktRWG9kK2luNjc2SW1DUk5pWDlxTHVwTXgv?=
 =?utf-8?B?Q2dJQ0dyRlNzKzZpVXVYVGZqZHF5dzRmY2U0TEROWUFrWitmdFZONFNYN3ZS?=
 =?utf-8?B?R0k4V1RGekM1R05NbkN4anNteWx0Q3I2dHE0SGxYaUx5Q2JsL24wV1RhUG03?=
 =?utf-8?B?MDhMaHpSaGNjOThBbXlWRlRseFVMQ01OcUhhSk13dkQraXZaNk0wMG9lUkFS?=
 =?utf-8?B?OG1Sam5RMXJlTGdZQk55b1RkNWtVSnJ5bHR0ZTE3SUU4WVlXK082bk0yaE5P?=
 =?utf-8?B?S0F0Yk1MOUJQbEZ1UmZhTG1GYm5zdUpHNjZ2Nlg4WTRURHN5Uy9ESWt2N2hV?=
 =?utf-8?B?ZVlLRmJRTDZ6bE5zMzlJRTdJWU5IWVpqc3lNeVpTYUdIc1p0Ly9tYzl1ZVBv?=
 =?utf-8?B?WVBKbVhCTmF6Q0g4NDNyTVIzRTh6bE1CekwwV2dyNkhTTkhnODZhZnNRaUZr?=
 =?utf-8?B?RkJFNzRaQ2FNTjFUU1Zaamx2QUt4UGhvMW9VYkFtTUc4ODVLcDRzRWxTd1p6?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3b22d1-fa2d-4253-4d3b-08dce41aba01
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 02:17:42.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SlEIOZ62CIJIELHEKm6N9ErqwUMJLcysVGhAjiqg0/t7wBP31Nbnv/C3708YgM+1Rq3+k83/qPnNSszlNbaNeMNsaxuVsessjn19pW72ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
X-OriginatorOrg: intel.com

Hi Babu,

On 10/3/24 6:11 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 10/2/2024 1:19 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/27/24 10:47 AM, Moger, Babu wrote:
>>> On 9/19/2024 12:59 PM, Reinette Chatre wrote:
>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>
>>>>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>>>>       Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>>>>       Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>>>>       Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>>>>       Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>>>>       Removed ABMC reference in FS code.
>>>>>       Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>>>>       Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>>>>       Users have the liberty to pass the flags. Restricting it might be a problem later.
>>>>
>>>> Could you please give an example of what problem may be encountered later? An assignment
>>>> like "domain=_lt" seems like a contradiction to me since user space essentially asks
>>>> for "None of the MBM events" as well as "MBM total event" and "MBM local event".
>>>
>>> I agree it is contradiction. But user is the one who decides to do that. I think we should allow it. Also, there is some value to it as well.
>>>
>>> "domain=_lt" This will also reset the counters if the total and local events are assigned earlier this action.
>>
>> The last sentence is not clear to me. Could you please elaborate what
>> you mean with "are assigned earlier this action"?
>>
> 
> I think I confused you here. "domain=_lt" is equivalent to "domain=lt".  My reasoning is handling all the combination in the code adds code complexity and leave it the user what he wants to do.

hmmm ... and how about "domain=lt_"? Do you think this should also be equivalent to
"domain=lt" or perhaps an expectation that counters should be assigned to the two events
and then immediately unassigned?

Giving user such flexibility may be interpreted as the assignment seen as acting
sequentially through the flags provided. Ideally the interface should behave in
a predictable way if the goal is to provide flexibility to the user. 

Reinette



Return-Path: <linux-kernel+bounces-294450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A9E958DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC390B21D51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD71C0DF8;
	Tue, 20 Aug 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpzJNHLY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447819005F;
	Tue, 20 Aug 2024 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177371; cv=fail; b=mdBQPQrkDFfiRS9Om2UvWLXfViHUkXTsqJLRwpCf5pDAsnfi6zUdcuACh+nm4RKk1mT9RXa90T0Ss1jJd648qrnm+9wZPwNEGu46QCf+qrf5p/5gLb8UBUMHE1yAVakpukKmgK+L7jd4LhueKgUUIFOGDrkPG6pX0rYaDQcZnu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177371; c=relaxed/simple;
	bh=s5IIyD+jm3ml4kJCG4sNXHZPuhqzt4xySLqLu6zPPJY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nxaKyDHwQlUOrBXYfgGOpxGN8/eNaFcXecYKu0/r8Y/LkFauWsDwhYackZTKO3QsaPdc2P9//H84vy6izqXbhDGBBBNzVxDPXr0xATY7FVp1MKF8PspXmeWzy51zpPTW9gS952cMqqLgWaHdXLA3mtP58lD2gpAnDR3zCTB+mEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpzJNHLY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724177370; x=1755713370;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s5IIyD+jm3ml4kJCG4sNXHZPuhqzt4xySLqLu6zPPJY=;
  b=jpzJNHLYM3SGfJ+//MzoLKNc73fA2B4kwslGLD0jsb0aZH7H9oiKp0/F
   m7u3N74v7uDtI8pil716QyqKVSoj3Rq9XW9r6ovWSt7CLoN2IP/pRbAQ4
   6I7iABXTBuu+owkhz5eB0Egsu/KhLZ2D4BlXhupUungIdXJGgiY974I+Z
   dNNoXInWBuWyBkc3/8Wz13s4VxvU5ndI/XHF6UU/oWLuniPVDYUFCCs2d
   uTwnSt37nF3QFT8FyqooZAJmDVpI5YKVXzepg4nxXNtoNpJeACXqYXpYB
   P8Cgs55E+InAjhoOC/UmtBZzRNDBHd9VJA9HT8KTCQcTUigRlwtIIX4qg
   A==;
X-CSE-ConnectionGUID: LnSYi8w8Q2atQnLf6YKSBA==
X-CSE-MsgGUID: 0kmUib7+Smi2q+uA0lAcSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33917156"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33917156"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 11:09:29 -0700
X-CSE-ConnectionGUID: d9JREAbkREmireHDgXpAzA==
X-CSE-MsgGUID: M1bjL05jQ6qn+AwAi3Z49A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60965311"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 11:09:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 11:09:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 11:09:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 11:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLunfRqEpJW2tx/2F73fCrjIPOoqTWLKY2mJBmFc7wj4bWjVEuPzkORFtg5gT6L/wkuJdZVh9LLgpWiwxUsu6TyOtShYU/QwlUj96M54jkR7zEvFA2YiRV3QI3AjVQYQsM4yiwPQ+vLvFxzQzwK08LHOBGCqllXpCPSJ3b4pW2Wn7jlGv7ixMCD/V2kaMk+rsJozv93vYEnqeHVgZPgLOvOM2VPrHiP7iNqiOzvOLIolf3/woXyjN5V2cvKKdiibJFcjgkft+eh5vUKwD5n4GNe98MjKXAoMP7zlTfUhbCZScDSI4cLhfalWPqb9hubD1XnGWqEx9RRmBcxn6N6lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbWPVbw4QZuki3wbv3KzxcF+R9gh5kbgUrt95hkq3Pg=;
 b=bMl+sRzuDdXlpnxnpKK2crKJUSavHSDCeURBWPpxYFdVtjUl4UDzkul/hyDHsTpstvvI6BzPO8GWiNXUK0kqC4Bwm/K5s8hoG1mVfB92GQrsQVM56AJN0RCw+YXkiDuEz05WZtmC+1FvUofxlMcFEKHVC8CmikIZ+ftZIHgXJz5wKEwLuUuYCfa1pPZBZvKLrLQzJ+UxOto230OERxAW7NhRDJEVG0XlB9RSjrAtJs5A5fY6EQ+scYfCFpFsv5cy3i2+Bn3xMCuIiRhA8jx4po+0Jkx7Eaq26BRs2+DuIia1Ts7RERpukqLdfo7jQA18DoTV0ruahiGd524nqT3ZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 18:09:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:09:24 +0000
Message-ID: <8b5aa79e-ab15-4d8d-a00f-3afb8ee21ad6@intel.com>
Date: Tue, 20 Aug 2024 11:09:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/22] x86/resctrl: Remove MSR reading of event
 configuration value
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <ce8ca46651c5488dff19ed59ba7c50009c90ac67.1722981659.git.babu.moger@amd.com>
 <57c27158-13ca-4f79-9ff5-58033e3e3b9a@intel.com>
 <654d1c0f-47e9-4bbe-8b7e-404dc1c746ee@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <654d1c0f-47e9-4bbe-8b7e-404dc1c746ee@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0411f1-ea9f-40d2-0dc4-08dcc14338b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDFMa1BnNVBlc3FxV1dMM1VVVGYrTDJFNS93WEtKUEZ0VENrTEJoZVFCV3NN?=
 =?utf-8?B?djhMaFJRclJZSjBpbHFHc1JINnBMTXhZWGpyREtJWitsck5HVVFFa3ZKeHhB?=
 =?utf-8?B?S2tPY3FqK3RORFB3QnJsNm1WbjVCbGZEa0ladzBHaDNSdG9QaFpPbDQvRnUy?=
 =?utf-8?B?T2I1YklpUVloRXh1MGNhY0VUYy9VZlUwYXJCL2t0NHFLYThmdkRHMUJOYmNQ?=
 =?utf-8?B?QVRXM3Bhb0tsYU1Jam92NVJlT1hJUTB0R043WFQ4Ym5tQ2RtNHVKNnVuYm9S?=
 =?utf-8?B?NUxWYnRoWXNpTms1bHo3Z3pYU04zcTdpNUdjRVVwQnZqMXNvL2ZPSHZOc1JJ?=
 =?utf-8?B?VERMTlRUWCtpTDJVak01ZVF3NE5HRkJaYWNId2xxdWhOK016eHVRUnNkTzZs?=
 =?utf-8?B?Vkw4UW5EMUxHWTRwVTBibTMzTis1bWVrRkRXRmY0NFoyNW1Jc3RybWNEL1Vm?=
 =?utf-8?B?KzgxK1gzcnJLZHIwT01DUnFqTGNGNjN0d1RSMDMzUFFGZ001RkhmcDRHQ1Js?=
 =?utf-8?B?cFI2ZjdXMGtlTlZMb1llWCtPQTM5N0JGcmVOSU9iUm5NaHlEd0dhakxFcEMw?=
 =?utf-8?B?RE02NGZNOXhOVHozd0M0WlBVQ2Q1aDlEOXBhM2JTcUpFRDQvcGpMT2E1bC9p?=
 =?utf-8?B?VzF2emoxdCs1aXhFVXZsdUx0bU5UMm1zY2dMOUs0UU5PWlVpcStGbFI4YWIz?=
 =?utf-8?B?RFRpTnQ3SGpwZXFqTDFMNXJNd1llN1ZZSDlhS1llTXpZVEVFQ01vZEEyRzF0?=
 =?utf-8?B?cGhTTFdiejZXVkNmTTkrdGtUM0Yyc1d3Q2FMQm5ySEs1S2xqQXo4aEtEZVpI?=
 =?utf-8?B?R01VSkZnU2dRYkdyV2hUQVl6TldxUHkzbXluZEZjc0VWbE1EL013RFBTNXRz?=
 =?utf-8?B?SVZFMURHdzRvZ0UzUllwaWlNWTk3SWVWMjJZVXQyVXdUMFpBeEFWbnJmVkpL?=
 =?utf-8?B?VTR6bVUycnN3K0RHbkpBYU9DeG9xaTRaUU1STmsvdXVGTHppSDNsenZDYjBX?=
 =?utf-8?B?WjFJZ05rbHc5NC8zY2NkOSt3b0tFOUhtc2xzZEtQZDhOc0NTQ0xaWW9YT0hh?=
 =?utf-8?B?R0NRR1JWR1FTVzJvZWZjRmhQYk11WUo1amFOU2MvSW5IenFEbENPMUlqaEw0?=
 =?utf-8?B?cHkyVUlxRmIzZlJHTzZaUDdrOFlVKzJrYWtzTzFYa3BnUXhmdkN5Wm9LRzRm?=
 =?utf-8?B?Q004dk80MG9vcjhXTVdDMjFoVm80SUJmV3BQaS9ZVGxKd0hvNkxMV3hFVFRB?=
 =?utf-8?B?N3FvdFFrOFB3K0tmR2dtQ1Bma3lsMnFISTdkRmFxYzlWTHU1R1ZlVVZiaCtE?=
 =?utf-8?B?c0lyTGJkM2hta2Nid2h2cTIwL1JTa1BqM0NyaTdWclRtZHVwN0FLalFuUkVk?=
 =?utf-8?B?REQ3Y1FUbWJ3WDB2WDVNanVxYlhKZzIrdG14T09Gbi9YZXBSMFo3cEJMSm9B?=
 =?utf-8?B?QTZnZUk4UmpVR1JkZm4zTHJzQmtwazU1YUcxQVd0bEV1TFpmUmNJSVc4c1ZR?=
 =?utf-8?B?azN3R1hNOGlieXFxcS9zUUxZMWVRclNnWGZLSVdibVB1TXlsU3Q0Z0Z0OHll?=
 =?utf-8?B?d3FaNWlFQ01YYW1BdlBrZ3dyR3FiWnY1dHZvb2g3SVRvbUJOaDdsZ0VPQktJ?=
 =?utf-8?B?OFE0U2ZFOVNBNTIzUFZlSEk0TXlkYk85OHdha2hjcE9GY20rbzZmVTU0Qlpv?=
 =?utf-8?B?Sm5pMFFDVEtMeHhTaERsUTZkZ2o5Qzh4OFU2TjVvNDk2djJXVlRrVER1V05H?=
 =?utf-8?B?dEluM01hR1BVK1phZGt4YUZ6UE1PekJjWlhTUDhOUXpzMnhlU3dXUG5pNnNS?=
 =?utf-8?B?TVFkNWlYSjNLVW9QZEYxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdBckNTbW9WWkR0cTJ4SlVicXMxSnBJYXJMMnQ3VnhHUDZLNnYrRTV5TnJx?=
 =?utf-8?B?U29yMGNJaTJQdzJLQVdRdWR5TlBZOVYrUTc0N2NiS1lKWnc4QWNXMDRCaHIv?=
 =?utf-8?B?V3FTYUdSV3g4VHQ3cWZhSXlFeHRMbW9jVGw4RW1DNGhMSy9VRXJySWkxaE8x?=
 =?utf-8?B?TlZqRDVZa3ZybzZsYUFLZjRaYy90VU16SHhocW9DN2RxLy9ZSWpGemZJQmND?=
 =?utf-8?B?YS9nbXg2NmRRK0xMeUQ1WVdqMWExMVFia1Fxa2syUityenlyeVZnKzVGaXh0?=
 =?utf-8?B?dzJKQnFHTmpWTlJRSVdyNE5mK0JyREl4dTJoMUM4TVovSWxVY0t4ZEFjTGpo?=
 =?utf-8?B?TCsrVmlDNlhRSTMwRlIrZ0JWU2RMcWFKRzBKTVlKZzdoanVjOGw5NmpMWjJE?=
 =?utf-8?B?SGloSExhSERVakptMHA3MVBoV21OZGl3N1ZEODJDaTRXWU4wWmZOUm5FbXZW?=
 =?utf-8?B?SkZhMnNOdlZhT3dLOWJSaXRwOGtOS0JjeTdrUEwySk11RnVTc3BlM2haUmpr?=
 =?utf-8?B?T0JMRG1ROURnN3ZXOWNWTzM4SDlvY2dIUVkrSFlkNlNFbW9UWVBTT2pzVEVG?=
 =?utf-8?B?S05rYnZMMTA5eUM5cFJsMkF6T1NKQkZ2TzJOVGVMakMxK1d5Vy9kUkVhdFpY?=
 =?utf-8?B?cW1SdS9LemphYWN4Vis0Y3lFZWpoWkJMQnpYZzhRd1lSeU1TSTlpREJxcnFy?=
 =?utf-8?B?aUVBMEVybU1PWmhrODBGTVZqM2s1Qk9ESVp2V29ZMlgySnBQVmx6M0lRcUVa?=
 =?utf-8?B?VkpsUE1kL0VhT0ZGTEw2UjNIbEJZQUhYTEV1anJ3aWIzL1diOVk3NmY0WmFi?=
 =?utf-8?B?KzZsZVVHZTFNcWZVOUhVOTA2RlVCdDUxS2szZHdzQzhqRkt2RTh4ZjlleGMz?=
 =?utf-8?B?Y3ljdzRQUEljNWpVRUVCcWVwdU5kaXIvTmIzYmpybThUNlB1MDR3VjNUTEI1?=
 =?utf-8?B?VzRsaWdaVnVxWjF2SHRPWVVCR01EL0N1cjh6cWdlRnlGK0JWUjUzNzZadTI1?=
 =?utf-8?B?b0Z1Mncvc3FrbFNnL1psS2g0V2krVXg5VDJzYVFhTXdxYTc4RXNLZlQxbTky?=
 =?utf-8?B?d1RPcGVHYlhwcGtGU29nYkN3REt1T0E3bWZCaXA0em92akRRRUhpaGphOGp6?=
 =?utf-8?B?TUxiQlQ1YlY4enZWcjA0dlhNYUtnRTR4M0dyQVd5OE41OEpZMndSQzRTU1ZV?=
 =?utf-8?B?UDBOckYxMkd1c3QrK0daeHdHTm5KTXYvNksyQWdESFdQdis1K2s0UkVzWDc4?=
 =?utf-8?B?T1grcmZHTk1KbEtTWGxIVGRrUXZHcDljOG1idXIvOVl1MUt6T21SODhMZkdZ?=
 =?utf-8?B?QkJIWUY4QTNpOHNQZU44K1FFY0pjTGtHSS9vdjNWSjVURU5kN0JuY1dVaXM4?=
 =?utf-8?B?bklmYmE4WGhtQWh4Vkp1SHc0ZDd1dFgxUDZ4UjRqdTFadWZWVDRqaXNqYzJp?=
 =?utf-8?B?bFRMekJaWnNSWG1PZFE2ZmVnRTVFWm1ZWVZxelVzcDhaRG9kOStFTW9lZlFy?=
 =?utf-8?B?TVorcmxXKzhwMEdsOUVYeXJRY2xCOUZyZTJXNlFtU28vVytWUTJKcUUrWjR4?=
 =?utf-8?B?UmdpM0xXYmdjMGZIYnFPVUc5eVhSV1JDZGt3U1c3empHbiswUm9lczFlQ1Bn?=
 =?utf-8?B?Q2trWVJ0MTNLMVUxKzlxTXVQWWxnS2FJVDBRMkxwMk1aNmk1RTFQaDBjayt2?=
 =?utf-8?B?RldmeDVUL1U3ZGMwTWVyT1lXK211WFJTMEt2cVdFRmxsNDBxcHA4V1c4RXdF?=
 =?utf-8?B?V04vbEUzWkJrS0xGU1l0TEs1eWhFUGVMeFBmcFo0WTZVZmpONSsxT29hbkVE?=
 =?utf-8?B?RWE4c0pvWVhIQ0JXL2ZYRTdwWmtZeFhTY0RiQVJLM1A2NWNsZWx0bEE0OFZj?=
 =?utf-8?B?SWZhajlnMThOZ2NGNUxVZzJhZ3dKeFgySVBjVml6Zm1QYmI3U2Z3QlVLbFpr?=
 =?utf-8?B?dUpsbFZtY0RGTlBnK1ZNTGoyMzFueG5SdnJxSUtNbG5jc2pXSWJQdE5UV1JU?=
 =?utf-8?B?VUlPUHBtUUZvRmZVZkNZVzlYQ3REZGl5NlFMNW1XMWdCMDRYaTh6NXcvOElW?=
 =?utf-8?B?bFRLSHRVU3RmUmJKRHA1WjRxK01IQVh2MmQyd3NTYk4ya28rNnB3QnpwVjFD?=
 =?utf-8?B?VTRMQ0xlNXNDU0ZUOGdzOTRBTytOZ0RPVFl1M05xVEt3VkY5Y2RkS2dGREJG?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0411f1-ea9f-40d2-0dc4-08dcc14338b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 18:09:23.9513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swemMEgqPh8ag9JY4c9au0kvIz+9+qLoisZD0sYN3y8qtDQj+MEoqLvAIgTUdIEU5CepinyyYARcV4hoydG2SLhiomxzFEHi8cVTY6SIK9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8118
X-OriginatorOrg: intel.com

Hi Babu,

On 8/20/24 9:19 AM, Moger, Babu wrote:
> On 8/16/24 16:36, Reinette Chatre wrote:
>> On 8/6/24 3:00 PM, Babu Moger wrote:

>>> Introduce resctrl_arch_event_config_get() and
>>> resctrl_arch_event_config_set() to get/set architecture domain specific
>>> mbm_total_cfg/mbm_local_cfg values. Also, remove unused config value
>>> definitions.
>>
>> hmmm ... while the config values are not used they are now established
>> ABI and any other architecture that wants to support configurable events
>> will need to follow these definitions. It is thus required to keep them
>> documented in the kernel in support of future changes. I
>> understand that they are documented in user docs, but could we keep them
>> in the kernel code also? Since they are unused they could perhaps be moved
>> to comments as a compromise?
> 
> How about just keeping them as is? I will just not remove it.
> 

I am not aware of any policy here. I'm ok with keeping them as is. I do not
know if there are any static checkers that may complain, if there are then
the defines can be moved to comments.

Reinette


Return-Path: <linux-kernel+bounces-294449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B07958DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EED2284838
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223F1C4602;
	Tue, 20 Aug 2024 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOO6uAaF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F11C3798;
	Tue, 20 Aug 2024 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177330; cv=fail; b=t0l9diLLtmHOFJyOyYsmE2zF3o8c++sXSURkGqvVyHnHZGR4RjA0UaBcfgutzTxnkfXjAGMn9cVp+AX486bsqRXrcXp1Ks6RVq/PZht7W/yV3rp2yvvpu6/zGdSCePnjHmOcIpPfpiKn37QL7xyTkO6AKzkLeBc7PIxClWfrK3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177330; c=relaxed/simple;
	bh=9KrrheLbyVxo3MD00Ggdr0/BkMKAx2oiVEexk+K7m9c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ECkQh0a1q8FqV7Sf0r2UCFzrqb3QMNsFQEI6F1W3kTy45MAX8JmQV7P0HFaASmpm5l7fP+i6dC5plmDvGg5BgedwUtVaMloit44znQEg0tXJ+5phhUvfsmnOVWkUlkGdfctsrb9H++/gS37mX2N3BHg/K3OX+QLEwFZ1s3dguA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOO6uAaF; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724177328; x=1755713328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9KrrheLbyVxo3MD00Ggdr0/BkMKAx2oiVEexk+K7m9c=;
  b=IOO6uAaFlG82jVw4T37kh7f++YFk8y+KEgBUoRJv6mHd8XTSdYvOszF5
   XMZxZqgHDCRboFUJc1JDBFwAK/kIEr2NxqrTmv18FMwc0VQ04ZYkjA5A4
   Kk4hRg6YiXkSiz2g+1ykvXGTCI01RulLaOi2U1kjVz11/wBpPSoo5QXPN
   wv9uydosA6hMYOY0DIVhW1uutfpGIStQCXZcwseEo3vPNdXl4PQ1VdpWw
   gA2zQq6/mjiwKiHrYIbtppZIdtJr5a2EKwzYodOWENyQpQ9ErvuyjwgYK
   B2P3eEcDbO7xM3s/9GTjdJIUKArarn8RAFSdTyMaSoC6WdQdFCIRHgw3D
   w==;
X-CSE-ConnectionGUID: sgfAe9smR+2kNpX26eIkDQ==
X-CSE-MsgGUID: 846YQwzDQgeRyFdzRXlgFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22633156"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22633156"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 11:08:47 -0700
X-CSE-ConnectionGUID: JwxDDI8qSF+lFudZrHu/RQ==
X-CSE-MsgGUID: whoT8PtAQiKgPyUtFaVpww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60666395"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 11:08:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 11:08:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 11:08:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 11:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxbCJkegq/Rdsci7/yjCVjUSj2dxc3wRtTGZYvYEpP0FGr3oGgt6jjtTaIOn1GISSNc6MYfiW496GdgeDkc8I+DJGMNQUZT7a/xZHIfWp1+DRrK8rf+Ry1aeRBFRidzevKYieIsnWfoc+aAzkhbEna+6vqGa06alF7pttifGDuW4V32mASWMhU3VjZv05D3LL0Zn+ApgWzdj5pNNW5vGHOoRdn+W4XowCPlYwWQWrvDcqg/obWUtOj+EP3mYF+L48rpZFIVsRyYr9CtVvziZMfIMJWsGs6JSq8dYoiSLT4sCUPvlQhaeXfTw/up/SUdYtNDtW5TRJIMwZCj6t/IPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sck7b1PsbCrsRt5rzPdtcftwZSYg1F5QKk7pA3DEgkE=;
 b=eOKkEyZwWdhfH0g7ZeFyT2eRYM2L/lasz6PJrdF94XJGoX2Pyt84Eu/FaobT0PkXql5Z/Jkggd8X4zrRGOiFgEW0SZ8m1nG0pXGKDw6xWLrmmYOtlVIEPAwCUIV8a8IGxsqPkQZh5enCMle/tHoWaxwXQs7OLufrHZlHg9DfyMzyjvR/6tDZOyi3Liji3gbE0BbbOK0p+YROSkXFmYtorWpJWuKiDX+TH1Dvt+n63oV+X5Y/R98t/6tLcf1a7+uHHLSVtGEQsQYM+TpIW8Cil2slpA3SpqXzwtn+f9ko03tPxRGueerNu8SNaluPEB7s5/BIMlcUdT+HgI8aQA1RyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5038.namprd11.prod.outlook.com (2603:10b6:a03:2d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 18:08:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:08:43 +0000
Message-ID: <c7e601f6-35cd-49fd-b120-62b9f4d99f13@intel.com>
Date: Tue, 20 Aug 2024 11:08:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/22] x86/resctrl: Introduce MBM counters bitmap
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
 <2bdc7920f9dfc24994fe280649cf26dc566a7a90.1722981659.git.babu.moger@amd.com>
 <8e6143e7-008b-4c9b-90d4-b2a8a56bb158@intel.com>
 <e82ae909-5c40-4c8c-887a-a1e0d0cfe448@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e82ae909-5c40-4c8c-887a-a1e0d0cfe448@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:303:6a::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: d30b636b-6d7f-4de7-c068-08dcc14320c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RC9EVkowaTA4M2F3dEUrVDl5K2cwU3B3MkhmTWF2YkdqaTVjRDQ4ZnRENUhn?=
 =?utf-8?B?OUJhU0xJUFlTV1FxRGx3WU9WbXlTMXF5UEVkYTlTSUw3OU5mK2d2Vit0MVd6?=
 =?utf-8?B?dGpWd1hNL1VkdVpwOTFkWHU2aDBvWHpxMmpBdGE2M3BBNWN1MzY3K1dHdEh2?=
 =?utf-8?B?bXF6YlV0UkwrcEI0SHBDTVRnK0JJWVBuMVBWMUR1TkJZOUE2b1E5SWFyamFH?=
 =?utf-8?B?L00yUUVSYXhzengrOGZYcVpVTWdIUzJmR0E1cGI2L08xNmc1SUlLaVh2QnU0?=
 =?utf-8?B?RkQ0YVZ5bHlsTFlvMlREU0M2NVF6dG9OM0ZHYlpFbmJ2Yys2RE55ajhBOW12?=
 =?utf-8?B?c09WWDFWSzA5eXoycXBpMldNcWgxMDQ1aUYwOWU2bGpETmp4Q3VJZDJFKzB3?=
 =?utf-8?B?MnhYMTVIY3ZWMUlObTRsV1VwcUh1QlZ2TW9YMk5YSUYrOEhNaHRoZFU5VmRL?=
 =?utf-8?B?ZFRaRUgxUkIwMW5DL1FGd0FxcmVQaU9OM0k0VVlMMlowZDVmRmdqSndyNU8w?=
 =?utf-8?B?cEFkSzN6aWEzeENOTmtlczRlOWFpNTV3OHJ3UzNNdmJNR0xKSi9YVG9WQ1pu?=
 =?utf-8?B?blgvbHRqYjFzTkpjN293VjcwcnpiUE9qQXBzM0FJM3FSSmtlTjhFVVR2VC9J?=
 =?utf-8?B?MzJjRzlZaHpzajVSQ3BLVHlPWVRiS1BUakhpbEtuMFFVWkpSRGd2WWpIOFJT?=
 =?utf-8?B?N05xWGdUb2pJclZLNGtXY0hQRUNZbEd0THpyUmVpWU0yeE5XK2wvNW1ZaEgw?=
 =?utf-8?B?bStkNUJKeUxCaERIL2ltQWREYnFoYXBNNDJRWVRERmd0cFJDVW8rSDdTZE9k?=
 =?utf-8?B?aGk0eTRLYnNpZ3lWSjhLWmpwTzlpYUNkaFdNZDcrUjRlYmZ6VUY4Q0N0RStK?=
 =?utf-8?B?QXJFS1FLcWR4T1dpYlp0OGF1a0I2MWxlMXFCL3RHZUNaelBLcWlrNmpLdDJ2?=
 =?utf-8?B?bGI5cloramZIOUpEUzhJMEJLWndqdG8zYmpXd3d6WTYvVnlrczNhUURFV2Ir?=
 =?utf-8?B?cS9BN0w2TUMybXpWNWp5bStSK1R4VjBwdXkwR3FpTjhUTmhSMnlWOHlxSG1m?=
 =?utf-8?B?aG8xb1hHc2dwYXIyY0dWMVN4T3FLbHhjbkRCUjdzcGpOK3MyOXJDcUpqd3ll?=
 =?utf-8?B?bXpoek00YzRKeHRjUmV2S00yTG0zT1Y5WkZkNUNiY2JkeDZWUmxNekRFdnBT?=
 =?utf-8?B?Zm5NVUdtMjcvRlJlNmhIdHhvczZHK0k5MTZLVDdYbXkrNGVTaUxwaytSMFFT?=
 =?utf-8?B?dzdJanBwOHJXOXJmOUpWK2NDOEZvNXY5VVprSm0vZER1TVpiVlVCcTg0emV5?=
 =?utf-8?B?cjZzWXFoVFJwNGxRZUN4b0JMTjlVc1U0RTlzTjUwQmFDN3NRcUx6WUNxaXls?=
 =?utf-8?B?bXFHZHdxa0N4cVpjYnFoM0lvTDYzckZ6TmxUcVFqTWxSQ2NIa0hhTkhIOFd6?=
 =?utf-8?B?MWhFOWgvOVBmdkF6UmQ2OGhaTkNhd0FUN2FWejFoUm13eGVHdXM4L3QwQjdn?=
 =?utf-8?B?UFJvY28vMFdndFZ4ZEJNM1lDYm9TQWd4dWxMN0htazhhSyt1RTh2aml3NnhY?=
 =?utf-8?B?MUx5VW1XdVp1OHFuQ3ZQbE5uQVl0akZIWkRDOWN3L3BLRjU0S0cvN2owelpu?=
 =?utf-8?B?VThRMDI2Q2k0a2hYNHlZcm5vYzZyOVVYMzlsbElIdElJNlNKWVpuUHBwZDFx?=
 =?utf-8?B?Uk9FL1ZSMHJmUTRQUkdEMFBLeG1PL25pYzVmWVlXSzcwOEtLWnl0REdJRnor?=
 =?utf-8?B?YyswdExDeGRYNlpPLy9vUUUyZWd3aXd1NTJpUUtEVE85ak1HVTdKajErMmIz?=
 =?utf-8?B?L0lRRFZySUM5dnpHUWhwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzRKUHhldW9veko1SWpqSE5DRjZhTm05UzRmL2NjSGwvTmtpOThUK2dPcVlM?=
 =?utf-8?B?U001dkFGQmFuUFIzUFdOeXJRUU5JR2QwUXdYM28vN21veS9JR2p6OVVrT21C?=
 =?utf-8?B?a3FmUkU3VGdBOGlwNG9KUC8xUk4rQUZyZWRDczVGUHlITmEwQ0RQT0lKSzlU?=
 =?utf-8?B?YlhQbENtaSt3MlFvaG9MeC9tU25xTUFtRThvSlUzbXU4SnhkL2VMRjV4dnN6?=
 =?utf-8?B?Z0RMMkdjYWF6OVRVVEdBRk1KakRWZEZrZlFIc243UC9RNmF0NnlralBWTld6?=
 =?utf-8?B?M2IxTmpuOVFTWnh1NnVKclBNQnR3OTQ1dGljZkEwRkUvRzFpS1lxNjZQN1Ji?=
 =?utf-8?B?MityVGpDZW9saFpMK3MrUU1EVVByMjJrbXdNclVaa1M0L3gxZGJ3YTRhNEdi?=
 =?utf-8?B?YWR1LzJxN1NvZ3VzQVJnN0dmaEorQVl6VGp6MkNRc2k2TWFXRWJUc2k2QkdP?=
 =?utf-8?B?WWtUd0NDRytNMms2SDBlNWtPZS96T3hQUldkdU5nOEhrZVVpMCszQVhDWTZP?=
 =?utf-8?B?ckFWSFRBdzRhVWFmb1ZvMC9CTDFVdUZEWTlqcUhwNUZMN3J0RkR5WDhHaUtD?=
 =?utf-8?B?RmtwUjMwSWFWbHpQcGQ4RXJPL1RNYTVBdnhvbHpYNDJnbmd4SmloTmg3UGpv?=
 =?utf-8?B?M21MMmI2WXcyeGdQOGNQcGlnbWt6M3RVY2hSTGZRNkZhcGZhZUl2VWQ4c0hB?=
 =?utf-8?B?Z0hmVmRYQ21HMnJ5VE9RS1NpNndNQ0lWNW1hSllVQjFmNWtrTmRiK1E5R3d6?=
 =?utf-8?B?TlAzeTE3bEtibTRnMURxWE51WUowbmR2MG9MMUxFamdyVys5RWlxbXQzczhu?=
 =?utf-8?B?K0VVd2hocWViQUpxUHBsY1h2L05yMzBSKzNvbHdjM3VNQkZIc2ZkRTBEeU8v?=
 =?utf-8?B?S2VDRHYvNVFWYllpTXBXeFVEbHc0d2srSGZQaEJLRmNUMExwV2dlLzNOazhD?=
 =?utf-8?B?aVB0NnVNYUs1TDdFN0hpNmlkdzZMOHNlOW9LSVFYWjVzUGRLWGNvNmxyMFg3?=
 =?utf-8?B?ZGNObnZRQ0ZpT3VJZnZ2SlVaVEYxekthaVp1Sm05K2F5bHppZm9vVnJlZUE1?=
 =?utf-8?B?STNwWTUxaGQ2ME5QTjhvTTIzL1JEamV0WmNwUEZBUGVVNXQ0angyV1FvNkZ3?=
 =?utf-8?B?M2xkKzErNEg5NEEyN1dPcnVGNVRKNTk0UXlwUHh4MDM0WjBPcWJFQzZydmJj?=
 =?utf-8?B?NTA5YmJpeWlNcWJoVXdYbmNXUGlKWE1iQzhuMDRIeEhyZC80VWowanB5R1la?=
 =?utf-8?B?b013bS9nUWNnSXVuOXVDTy9vZkRQa0gzSGV2MmNkT3lBd3laZ2hMV2hoOVlY?=
 =?utf-8?B?LzFITjM5c0N4VGFNRnFKcm04ZzI0YVVyc0NocG5MaFFieE9MUWRlbmtRWDJJ?=
 =?utf-8?B?ZHR4d2g3WktsQTVVLzRYUmV4TU5hbTIybUZCdWVBZGp0VWVXZU9lcTVlb2h3?=
 =?utf-8?B?Mm0wbGtqRlQ5SGJQcThydWRoNGRSaGk2WSsyaTNiTVMzTlQyRkk1M3lORVBp?=
 =?utf-8?B?WUhJSnFNZ0NtU21Yams2SXI5dFlPZk81cU02ZW95T1BIbmVFZ1QzQ2lBVThu?=
 =?utf-8?B?VXdhelk2aEQ0Y2ltczZ6YWxwM3hpRzFTejFLdkU0Q0QzOCtkUjBGMDNkWUFx?=
 =?utf-8?B?NzhzN01xUy9lWVlpcWFpN1lnUjNha0FMMERqSGJqTm0wcVd2UWZJZWFJRU1v?=
 =?utf-8?B?WVhpMHdaSWtBVHZ6eHhmbUNKYVYydUVFWFFuNHNwWDkrem1DcHJDMTlRL2NU?=
 =?utf-8?B?NXZXcTZoSGk5aVRMRlJybjVsOXdsRnVzUjc4Z1BFY3ltUGZxNWYvKzArUVg4?=
 =?utf-8?B?aU1uN0o3c3hPWUl6TWlUSVpRU0kwMEZUd1dKM1o5Rmc0anA0WHJQUWI5dE9k?=
 =?utf-8?B?SUNGTnI2dEx1Q2RSMmN1cmRCOCtKZlNFc3prS1NuUjZ2OUlOWnVCY1Q2TFQ1?=
 =?utf-8?B?QjlJbS9jZUM5OWFQUnFhT0JYR291YjZNNG9uV0RpTUI5U2FMY242T1FyaUtx?=
 =?utf-8?B?MVFveWRKN0xUdnc5QjBjTFZSRFJiK1llQk96RS9KeGhZcVRQZVJZREUrbmRj?=
 =?utf-8?B?dkQ2NE56d3dZd1d2WkYwcTJYY3psYlRWdG1jaHZJdUxoWTRyR3cvK05LY0M5?=
 =?utf-8?B?ZytadkpKVW1naS84bTU0N1UwVGFrdUYvK3M0aTJ0MWRGOWdJNnJDZVZ6bHY3?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d30b636b-6d7f-4de7-c068-08dcc14320c4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 18:08:43.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3izl5E0SezBfOh5IPFuM5C32yQMgsp3tEq9ZpJo1xx5Adi5kY2l7raZAyCHVIr1WHRBIIVEceMCrqcHZz4Q97MJnVoBpGg9/ncfDvLKIy1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5038
X-OriginatorOrg: intel.com

Hi Babu,

On 8/19/24 8:49 AM, Moger, Babu wrote:
> On 8/16/24 16:35, Reinette Chatre wrote:
>> On 8/6/24 3:00 PM, Babu Moger wrote:

>> resource
>> as parameter but freeing a counter does not. James already proposed different
>> treatment of the bitmap and L3 resource parameters, I expect with such
>> guidance
>> the interfaces will become more intuitive.
>>
> 
> How about making "mbm_cntrs_free_map" as part  of struct resctrl_mon?
> It will be pointer and allocated dynamically based on number of counters.
> All the related information (num_mbm_cntrs and mbm_cntr_assignable) is
> already part of this data structure.

That sounds good.

Reinette


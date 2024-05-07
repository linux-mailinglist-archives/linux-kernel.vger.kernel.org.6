Return-Path: <linux-kernel+bounces-172143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3066E8BEE0E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983AEB21F33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD1814B946;
	Tue,  7 May 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jujBo9VO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632318734D;
	Tue,  7 May 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113611; cv=fail; b=jRqBTSPlRRweSn+NQ9CpStcNWseQ2JIWe5wxSr0T/+Q7KVVm7+3epeG4EfylYLIksRCvAOxPO2Zf3NeO5L8BkDMLu1Y4BCOk28YbX+c+j95lG3RGBTtSlV0/pr5RV4qQgjpDxEt+RADTSG1/b//Kkmb8rkGvRIRiw4ZrKKk9pB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113611; c=relaxed/simple;
	bh=tfPDRRcPcLE1D66uGITe4rjLyD2xU1u6wTtFVyaxY8o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lwSyE346Fx/708vbTzRpC1c+3Air//EAB+nznC1cWI7eec6AcCf/vmKJgRgI8rJgO3UEKGczFnzqTYrr0ufflTPOgi7lkdglrywlkq8jB0Wq/hzSWJd6+7KzpNEpDODZzh9na+jc2p/oukeIiLCI9n5qn8X65k720boiG7sF2Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jujBo9VO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715113609; x=1746649609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tfPDRRcPcLE1D66uGITe4rjLyD2xU1u6wTtFVyaxY8o=;
  b=jujBo9VOSCydRzu+s4bPXfD0QBVkxHy5eh+MbWbM69WZ6fyzVSxD4KIY
   Cjjs4hNrVfwjaf5B4QxIMP1lAkmCw0odE8PD+QX10hK3gx1R63HHN77bD
   +K7Q7i+tcImbChEjuum7HsyV78BnkxhCc2HHCEGIvzsXgStb79EIv7Fb3
   Z4zwrOYds8czvhhfLVqLnxRdKHnaRkNVgsH9jKA+NY4Sb49EBERdQwucT
   /B+2z8NsYfWdbFGiobjW1fWFFONq63GyGMPZSLf/4AHMYVrqkfr4gEzRR
   xu3ckJlPbopVRzQOrnn4ZaX6QjTdURHRuJqveRD3RMpvkeyqhIEwV4jQS
   g==;
X-CSE-ConnectionGUID: I63ftGf7TxyG19VQEWI0Mw==
X-CSE-MsgGUID: 9IGjvJJOTNyaiao+MD1FRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22351520"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="22351520"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:26:47 -0700
X-CSE-ConnectionGUID: oEZ3ohUxTu2KBPaiqF9VGg==
X-CSE-MsgGUID: PAQX49JWS4qE3A5Gjj15bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33204250"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 13:26:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 13:26:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 13:26:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 13:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA6pZWr+hi5u9i7nEtn7R9sKCIqFEy3/oiouuapAK5j/P7HjDGaLGNfNirT9TKNdArS3Ztr9aTevhhYE+iW7429Vt/C8/CCUNteVm0t14lDja+mQgWkwlpz5uRF31Azd151HqHsYhDaEJ6lWenM8ISVIRbLjgmzSA+EoBSxeQ8EjstnV0+/OM6y8K1ifQHzmOOS/ykwepUAxuOEeBZZWWK9HuFggOh35Sg27a+Czwhg2qKtt6q/DNxxxuHv9nqTE8lx1aWCFne/Z+sYQnSGa2CgwHzNm5G+glJT1uWB0bAF2GdOX+eHhTurMFAxWakRiBLy4UMOQoy9qW/fLp4/ptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU4By3Lun5GKaiccnDzgfo/K2Cr/s0jLQIteCNVvydU=;
 b=Lv6TlzGklwKYS+Och4YX57VGzOHukXCKlv5TRt9uIcKMNrPBadPjWQWpGbxOklXov2pbHJbgHs6SEGFwnFx3u+q9zt62FpEKnMKORsdKcF9V99qnogO/O2+dqZLzAQJVKEB2LhKWn4zMZcmPe7MLLHnGP/F4UKPHqp1vv3Qk6WJuqR7jn9vERCtX0xohMEUwDaYDUQ/ORI6R/AX0AhN3zwViwgStKVm/DDiurz22FoLGRr26QHGQRGqUdsb7LyLh23r+U1EoEdzeTrCJQy9VBDn5Jlpvzl544mW/3oAxIeHJp7jhMBREfx8s+Ya5b/iwncggVyvKFabGxwLG0NK1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 20:26:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Tue, 7 May 2024
 20:26:38 +0000
Message-ID: <ea75801f-e56a-486d-85a4-85c57bce0c81@intel.com>
Date: Tue, 7 May 2024 13:26:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <48b595cc-5ffe-4507-bffd-335a60fdaab9@intel.com>
 <2016b830-64c7-43bd-8116-bdfd239221e3@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2016b830-64c7-43bd-8116-bdfd239221e3@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbe604e-f17d-44d6-0eb8-08dc6ed3ff3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVU1di9BSUdKVk9UUTYzME95eGpKV3QvVkZpN3dORDNhVHpNQ2MzT1AwRkFi?=
 =?utf-8?B?MlQraVh5Rk5IVk13UnVJOFNVajh0QUpFcEt3R1NESlNHa1Z4bzVzQXpoSjhZ?=
 =?utf-8?B?V213Y1FwUkhYbXF0Y0JFdnJXbi9iTUFZQUI5RUhuano0Rmg4SjRzckQrUElV?=
 =?utf-8?B?T28zRDgwazBmUXh5N20wc281em1Edkh0NmcvSDNtMkhrWU8yNlFpNkhPM1BQ?=
 =?utf-8?B?MlJYd0V5Z1N2NW53MTNLNWpnNWxBbnhFZVZSY0FUZEJ4cUtPcUhGVk5ybFJT?=
 =?utf-8?B?U0F2NDdsTzBWTDZsL0JnWUVmSXNCR0c0enJzZmd3emxaYjlxa04rbVNBWDNm?=
 =?utf-8?B?VWs4QmNGVW9YUXQ1M3oyUTVGTDhBck9mRVBFYzNFTklCWm5zZ1NyS3BsbkJ3?=
 =?utf-8?B?cTl2MVpJL1RIektZbk96OFMxeE5oQXdsSkp6eVdZMllJY28wQkhyWkJuQkd2?=
 =?utf-8?B?Vy8zZHAzTlhLZ010NTZPYjJ2UVdmNnhnVU95VkdRT0ZDZ2w3VzEwUXdZRnU2?=
 =?utf-8?B?WmxJUXNYSEFDVzR2MVU0VHlQMXJNMXpFRit0MDNZakNHQzZJVm0xd1FUS0Fp?=
 =?utf-8?B?OTBaR2pFQnZNdkltbVpHY3lSNjIxaDdWVjdzZDRnTlBVQmZkZTR4MFNMbGhK?=
 =?utf-8?B?dFRNN0hNaHJieDdMSEp3b1lCY05ZVTQzUDErRFF5eTR4L04vcDY3L1M3cm5E?=
 =?utf-8?B?dUxiazdRcUd5L1VieFZxMVRLV2JsdzUrbU95N3ZpMzNJMnBNR3ROQUoxU3Av?=
 =?utf-8?B?ek9WVUNMRitid2tZYmhRc0UxZ0wzMno5ek92Z2hidVZ2STVZY1QwdGk1RDhR?=
 =?utf-8?B?bWJ0SFQ3WkoveGNJc1J4Z01ZVUlaNnRpVWUxMXY5ZjBoVHVHa0J2a2pnMno0?=
 =?utf-8?B?WnhFclA5b3NNWnkwbkNDMzZXbUhGY3A2WHFiQ3BrdTNBcjRZOGdSOStRYThm?=
 =?utf-8?B?TXg3VDUzK3QyUjlSZWlrNlJhcWJSVlNTdFlyeEg5WEI2eFhUTy82RythdytS?=
 =?utf-8?B?aCtDZTYwbjBPd1U0Y1BtbENWNDdkajBYYzhCM2UxS1V1NllCQUJMZkx2aStN?=
 =?utf-8?B?NGZSN2haM1J2ai9pckdCWURpY3FMVzFCOUdnYm5yanFOaGhSd3RKUVY5eGpH?=
 =?utf-8?B?bVlEbG4xdU9Wc1FLOUZzTXN1ZW5FOGUzL3FCS1ltOXlhZk9XR3A1dTM3Mm5t?=
 =?utf-8?B?cGJvUkdTc2NaRVREdVZaL2lrSjVINTQ5TDNLVEhWMlp2b1Q0bTR4WUpFcEsv?=
 =?utf-8?B?Y0xUeU9FUjYvbEFMVHRncmhHZm8xRi91cWY3MGZYUVlFV0k3RFBBY2VSanQx?=
 =?utf-8?B?S2k2N1NlOGtOcnRSTmhmdVRCajdYY1hLbmxjbDRYUWFmMTc1MXp2S2lFeDUv?=
 =?utf-8?B?OXJ3cUk3bGo2TkxFL2xGWGtZODd0SFZNeTRoZldDTy9yVjRTKzQ1NTNmSDNs?=
 =?utf-8?B?RndaTUc2YTVkMGFqelVMaHV0c0MxWE5Uenk0YVB2ZmxUTktXNzhHOEowOEFL?=
 =?utf-8?B?cWhhcTg2QzBiMmNObXJpTFhrdjVJTis4Ly9qS0pJYmdsRk9aeG1OeTB1eGUw?=
 =?utf-8?B?Z2lncmROdFM4K05Xa2RHd1JSOVlGazc5c3pya1pWSHhjN0ljWGVxemFCNFZY?=
 =?utf-8?B?YjF4Z2ZuOU9wMmg2VWlUVEpJTERad1ZnSnVXaTNXdllyWGs2MmNOMm1qYjlm?=
 =?utf-8?B?ZWlNd3NmUFd2bi9BME5zbm9MM2FnVDJCaXZhb2VHS2xjT1V6RFlwUjZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxvNFdBcUVEdkJHTEtPM1VrS3gxK2hCN2ZibjhRR1dKWEp6Y2trMlo1b0FG?=
 =?utf-8?B?bWxrdWduN05pcWJQNnd1d0EzRGRXY2tESVlRZ2NKYVY4eUpkRG90cDBadmYz?=
 =?utf-8?B?QXlBY3dhaVlOdFE1ZzNKYWpmWVlwQTNyZTltcXB0YU9VYXpJVStZbzJHa3Bx?=
 =?utf-8?B?WFMwM3Nma3d5aVFOeUJqVEtVNlU4cFRmVlFXblhXc05neE15NWVwcU5DVkxs?=
 =?utf-8?B?RWl5QmtMQjhBcFpIcWhJZEwrRGJJR2c1MzJYeUZHZE5MNTMxczZ3N2hQbG1P?=
 =?utf-8?B?b2tLWXlLd1RkKy8wanUvUXk5WmdqMjJheExkL2R0dnU2ZTgra0ovQm13L3ZN?=
 =?utf-8?B?WUNvR2xMQzdiTlpTQzdQM2NwVmZKQ1IyR1QzNld5SmE1S0lqVGc0eHlFakJ2?=
 =?utf-8?B?ZUsreWN3UFRRYWlsZmUrbXJTUk84OVVkMkF0OGdWdzB6Tm8rZFFDSld1aEFp?=
 =?utf-8?B?S2N0MTJTK3lOR1dzbnZOMElPeFliTzFYdVY2WWxYcXJKbmU1K3JoY1dWdFdu?=
 =?utf-8?B?Ri9DMGtxdUR5bGFoSDIrTXZQcitMb1NPOGdPVTVLWnRpblRrNHhGU1gxelVG?=
 =?utf-8?B?VGM3YjhkR1JFME9nSHoxTWpwdVh6TEtUeDFZRHNqWlFGNjU4dmVoOUVubFRh?=
 =?utf-8?B?NEJmVU9sR0JUdE1Pd3kxMHRpZ05NSDZ0cUFweTJBMTNMamZaL0VVak5yblVv?=
 =?utf-8?B?Nzkzd29uaVBUVmxSTFlSbUQxUUk4cmNVQ2w3V1A0WDQxVXQ4bkNnOWFMMTky?=
 =?utf-8?B?UTQ3dUtGd0Z1SjRhRm5pMmgxYm10ZUt6cHNKQlBWSStMZ1QvR1BxWWlzUTdJ?=
 =?utf-8?B?R3dhbWFvZkpnakdjamlucy91YjQwSHZjdVdMcVlPZEtHZGdjM2pLQVl1WVA1?=
 =?utf-8?B?MHlFalNCVUtYRTNiMlp1OHcrcDJ1UUhZK01mVWlRY3VTRjdyUm4zTlNlcmdy?=
 =?utf-8?B?ZS9yM0swR3ZCVllzNS9TU2NFdEtMOVBINDFCUnJ0Y0c5VkVwcmxCU1Jmc3NC?=
 =?utf-8?B?WGFEUUxReEEzQ3B2aDFOOTBMUFJYTERnSjZ1WE9QU0V1c3hpWnhUa0xOL3Rw?=
 =?utf-8?B?RkFyb1k1R1hOSlpGcmo5YWNSalNGMVl1Z1dsTUhqNEcyK2N6TVRIdXNFSEhD?=
 =?utf-8?B?MkVjVlIwV2J3UWl0cW5sd0wzOEgxU09sem4wWTNnVU95RXpoTGZ1YThGYzBO?=
 =?utf-8?B?MjMrMWxyZEFJcGw0Ym11WXNZRURlWVhyT0FJTFpZdURobXYrQ2xNZ1MxMzM4?=
 =?utf-8?B?bHl5TmV5WFVTb1ZNUUZoUFlBc0htS3J2YVVXdEJON2s1VjNGL2Y5c3FOL2Jm?=
 =?utf-8?B?NE9oMFh6UVpaMWxOVGFMR3V0RGozZS9uRXJJQUUrVDViS3gxeVlqZEMvNHBN?=
 =?utf-8?B?OE1NaVVtTHczY3JHanB2NzUxWUM3b1B5VGZJZWZaUVpPK3ltOTIwTHJzc2la?=
 =?utf-8?B?bnlyejh3WURMd3RPN1E0eXJIUUFXWHhoZUZHa0tidis5UEN5WkZQVEJDdERa?=
 =?utf-8?B?OFFlZmJ1UHFFRE9OSmRSeStHcFVWai82a3hiZXZhNHdQNzJVUnQ4WnArZDlL?=
 =?utf-8?B?TGdad09aR3RocjlvRG8wZis5S2pKVks0OHFUa3U1M3RSeGFnUXdTaDBOV2VB?=
 =?utf-8?B?VjVydkc1YjZnNVZQYTgvZ2phNi9iZStUNlYvczRQR1dSQmtNRDNtWkIwQVJD?=
 =?utf-8?B?YWdZTHFuTWkyTjE3T1BPODg5czZhV2FIY2tmVVd2bitmVUNnY2xmeVBqWVNC?=
 =?utf-8?B?RlkxZ2JGVFRkNW0zZnpxVmRTNW5FSXk3aHcxQ2ZSMVI4ZTY2c2hkTHV1QTRV?=
 =?utf-8?B?R2g4QXJPTGJNNDM3Q3BoeE1OQnpWald3SHIzQlYvc0RjQU9rLzRHTVp6WVdq?=
 =?utf-8?B?RFJKYXVNb1hLdXFEVmkyYjBxUUdqc0Z2TUM5RjlkOElsS050aXFlV010Wm0r?=
 =?utf-8?B?ei9FU1Fkdmc0THdzYnNBTWVEdiswbDl5R2hhdlRWZWV2SUE1Q2szOUNqVUhw?=
 =?utf-8?B?NnhBYlJvR045ZC9DeEZtSlorTTJPZXNHYUpNeHN2MXZtSk1hTUh4aWdVWFZE?=
 =?utf-8?B?SUpkelp6K2RBMGt4bDhYbDdVZzFUN05jSE1tK3d5U2ZLbXFmKzVRY094NHdR?=
 =?utf-8?B?RnJoMUkzNU9XS2hxMjc2SkpOSndyVEZCa01GaE10TE42T2xhNWxZNHBSNUVt?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbe604e-f17d-44d6-0eb8-08dc6ed3ff3f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:26:38.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6rgXekA7DRwOEX75JaIXmyJPUAq178my+hbiyqX3DPEFoWTkXChfEPfhacMHx2y0uNhxFClOMr91VFKq1Y3D7yzu+/V3ibUehH1mORDlT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com

Hi Babu,

On 5/6/2024 10:18 AM, Moger, Babu wrote:
> On 5/3/24 18:24, Reinette Chatre wrote:
>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>
>>> a. Check if ABMC support is available
>>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>>
>>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>> 	[abmc] 
>>> 	legacy_mbm
>>>
>>> 	Linux kernel detected ABMC feature and it is enabled.
>>
>> Please note that this adds the "abmc" feature to the resctrl
>> *filesystem* that supports more architectures than just AMD. Calling the
>> resctrl filesystem feature "abmc" means that (a) AMD needs to be ok with
>> other architectures calling their features that are
>> similar-but-maybe-not-identical-to-AMD-ABMC "abmc", or (b) this needs
>> a new generic name.
> 
> It should not a problem if other architecture calling abmc for similar
> feature. But generic name is always better if there is a suggestion.

"should not a problem" does not instill confidence that AMD is
actually ok with this.

Reinette



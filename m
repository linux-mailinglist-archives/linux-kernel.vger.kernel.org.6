Return-Path: <linux-kernel+bounces-214193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F9908102
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817E01C215F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC418307F;
	Fri, 14 Jun 2024 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ds/sjEl+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695E2E62B;
	Fri, 14 Jun 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329740; cv=fail; b=DYtBiM0jI/ndN8PpT/Wv3A/Lv0rdVNytRZJtzY4CrfYjSHXaKKyiwycInnYKEBmO6KUvLpnafmIH4XJ7nFbu83KUJBCEjK1RPix3nkKXBghBSj3X3eQ1WtwV/tB6vTlxRJtzmnf0wgtC4532wLf9PXg7+TTEcxo3mS7eX8tXWrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329740; c=relaxed/simple;
	bh=y/GQ+zcQoGTaceNoI9TGT2rn98pvhLKRNJgbQn2K85w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKE1J5llj1cAqrz1uScTFbNnRaS9TaEg7V2ka1BeV0Fba4xPaHLqbWZOnTzURVfbmW3ItCGWFz/IqZx35hXY+7jm0yCB/fVnzqqIh4VTlk/JqZs11rfVHVW3vKqW4n3ctrp9AzPX+ZvOr/KYKC9BEcfnEC20MeUQQtnU+2QBe54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ds/sjEl+; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718329738; x=1749865738;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y/GQ+zcQoGTaceNoI9TGT2rn98pvhLKRNJgbQn2K85w=;
  b=ds/sjEl+RvY6moTG7s45VRx0NKcaSwQ14TE0vMpfMefiEGDD0AJpGpM7
   vEWq8GzUvWo96ZfoZh5gKUL5HLpqVio4VnHUN1bj8UKs+bZUvuaIOnGX5
   XN+79Td2kdQCxh963wOfPd5L7KArYQWqqgYhQTmq0IyRIKqIVDDylMHRx
   u4SaobpeBqzkYrm/kdQFVtsFCxFpwyBkkr0nPOIQiDO+ekE8SsU4oBTrv
   SyZAnNcPJdiXhGmW/8AgOMXqfAOAhbIrnMZ5w2BkeM9bYyDp0mUunkU+n
   MjV16t+pzDEBm0pS+Xz3/AjYfSlf0eTYifNKYBcc0ddZtfCOA59b5SAWx
   w==;
X-CSE-ConnectionGUID: NTLRU/KtR6CSP2YLXucZsg==
X-CSE-MsgGUID: 0i1/gGRCT/SrBcMWYKBP3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15030821"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15030821"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:48:57 -0700
X-CSE-ConnectionGUID: z1Oepw8CTZWlj9Lhxn9sbg==
X-CSE-MsgGUID: 2kCdQmmoRpOCOpAG0EIxPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44773559"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:48:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:48:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:48:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE9kWKVOKc64ylaty3mZrsze8SMpJIwHWdBOJ6RaeC9kX6Mqh2PwyWD5rnQBTPoJ/7Ynd4/ktVKsykZTSeIZsPvk0awprxu2OEF8yup4RmY1h4IWTw87EOZ2goMueO2Lo2ixL9kgFGMOc4sUDSQ7ngJBPnYmJIfgeoYaJW71uxA4123o80oa+LWsHsQvg+p6c2cWFXLX7+0eP8vdcOjWPxo53n/mUHolGUgfLldQoAKZSHZc6Iue3L3roKjmKxD1N4jt5C9sNYS8SEBLQoWy1ftB8ZoabYQAkAtwvzfS5GHIB23TCsbMV/zIrbGeChpbZ5FUg9SV80IVNleUZ6pQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk3kD31YuwpPBtnx9nQsdABnCy5kBl4AOkoVTEFfeVk=;
 b=BEUXk8hs3LjstfMsIpbZGgzhYuevoJ5n1/gaqfEqcl7Jp1JWZdKJvQUWDSgPsUilWAdad77KrOcUM6ixLiBqsGR5DavkXNsBf2aCpKRHykIUMkFJ4afKS5+0RSyPLvU2+hvPXn/r2zx/SUQn61LxwPl5cF8VGxmlfXXVcCWogXA7UxD0+HPoRwrw4GFoO2SVBXDGiCvPz7AbfMsF9/LgOhsEHEQFkyOWQSPlIpqOv4sYQis7AfYWhTTTvljnRVqiJ4RelteYuvpkC3ob88FkguINrwtJ4FZkf9goUjFxgEN08JjlLbPxJ49Q/epyaI9LdpeFYg8Gefdh94KkMckYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 01:48:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:48:52 +0000
Message-ID: <e649a49f-344f-4dbd-be2f-d70f932a80f4@intel.com>
Date: Thu, 13 Jun 2024 18:48:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] x86/resctrl: Add the interface to assign ABMC
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
 <631092558e7fe0ac2e6267070e40c4a97b300f57.1716552602.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <631092558e7fe0ac2e6267070e40c4a97b300f57.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D10.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf9d3bd-9878-4d85-4b11-08dc8c1424ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3lHdEdDWS80UmVOdGxLcnJYcFliRTd5aEFUMnNTMS9KZHRYNExzcHRkRFZE?=
 =?utf-8?B?MEM0MVBOK3Y5TnJyaGtGQ2xPY1B4RFp2UlFzQ21GdkxvTXQ1SHl0MkJocXlK?=
 =?utf-8?B?MTRVQ1ZsT0hSSTZPc0hqa1ZRbHdYTEVvOHFXZUI2WE9GZW1WNVNZakZXdk5T?=
 =?utf-8?B?NDVNbFhxUnVWMnRRWjBvNVdSME4wSVNqMUdGbXlTd0xmbDV0WmFkWlgzbVlw?=
 =?utf-8?B?NTB6VzZ5MHRHYTk3dE0zN0ZFVDdHVEo2Y3pORHZ1Uks1dDVzRTNRZzFjTkQ1?=
 =?utf-8?B?Q3RqaGFPK2tNWkxGa1NYTHQxMG5venQ2ZzJWMzN2Nm9hWFZTcTg0VEtKVmFJ?=
 =?utf-8?B?YUhxT3hWYWJGN2dBaFd1dW0yZ2VJRVNjVkNXODJTY0ptNSs4NktQZUVZcDVh?=
 =?utf-8?B?K1daMjduQmRJUUhaL2xYTWk3ZUl2QnU1ZWlpanBhdEZTUnFMZTgxdFRvRTFQ?=
 =?utf-8?B?ZjBaN1M3TWxMRTdEZGJOSis3RUNlR0lSdTV0UEVWWGp6NnNLMHAxTTVyckVh?=
 =?utf-8?B?cUtVak9UTHpYYzFBdy9VUjl5NU8vYWdLcXkxWHdpeFhVenJNVUs5Q2dQczVk?=
 =?utf-8?B?M0E4U3dWS2RSenlBdnBWanZYcTgxeVFSNEVjalVmTDF4NEZIc0RSVVkwRDI1?=
 =?utf-8?B?YU91MEdYL2IzWlhxM3JsOUFmQ2N3MHRIMklRRjA5V0ZsRCtSSFhiWHlCVDlK?=
 =?utf-8?B?ZmcvUGJhVkFvRTlDMkdZcVlIQzJINjRQTjMzQ2h6eGFSM09ERVdJbnFEVGZ0?=
 =?utf-8?B?ZnJpcG9CbVdJQ01ZbDNWYTBmQ243UmJWNlhlVFZyak5uVUROeDc5ZE93MmRv?=
 =?utf-8?B?NlpnblJyZVo1dWhZVTNQK0VvMnJtLzdGL0o1QWE3ZVBMSWw1K0d5cG1icnNy?=
 =?utf-8?B?Nm5pRnZJMmFvZzBPOUdqQk1PbzVvTHAyN3pxK3JTd0dFTmlWK2d1K0J5UWsw?=
 =?utf-8?B?NEtpQ0REazFMQ21BTTJqdGhwMHpicVhYVlJiY2o3MXhFS0cyR2o2YnMzK0Vi?=
 =?utf-8?B?ZFYxVlVOckRPZmVoVy81UDNuMFNwaFJ3dzRiajNLdGFrd0VXNkVhUFpldTVo?=
 =?utf-8?B?TkUvcE1lb01OU1lXNVU2OVRvb21PSG4xa2s0OXROdGxCYmZiOHQ1aEZJN0dJ?=
 =?utf-8?B?Snd2d0tOenNTRlBhM1doOFVyRmdvM0ZBWHFpUTlhNks3OWZxcXNuMVdLZGNv?=
 =?utf-8?B?eUY1TGI4MktZOFVqdW1JSHUyT0JYQ1laV3F0cXY1VXNaTVVFNkxqdHFQYTk1?=
 =?utf-8?B?S01GK0JnWm1vaWJ6ZlhjUCtDVnVBZVdDSitNL0k5YVRQd0ZMUXJVV3JvbVBt?=
 =?utf-8?B?Mkt0MkFZUlNsZ25SbytTMTJEUGc2UnpBQ1dQREFSZm5mbVIzQ3pBa2xodVp6?=
 =?utf-8?B?aTZMZDFPMHhRS0hidlpxYzBGY2REUHZkRVJWVTlOT2xNOGh2cytJbG80WS9Q?=
 =?utf-8?B?bTJWU0tsNDMrVmpCbHpnMlNqUU51Z0U2bWVKcWtKelh5RHdmVDMwYUd6T3Bj?=
 =?utf-8?B?d1BUUXgvY1dmd1NTWU5uTVJOQUlYcWdibXF5b3o1S09aUFluR1RQWi9FTWtW?=
 =?utf-8?B?Y3dlMjZkZkZVNzJHaG9kVHpFTG1aSmlPS1RtRkxkcGNIdnZySTJ2c1NReU1i?=
 =?utf-8?B?bHBkTVdTRnd0YVRGRE8xK3VRaWxHZk83Yyt4ejFTVHYxYk9xbnlVeXpwNmRS?=
 =?utf-8?Q?XjULZ3zKTUn0yPCtguQq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3U5b0lSQUZJandtL2hMV21yRFJ5VjZJTGZrck0rMS9zSC9vMnA3Y1dWVnRn?=
 =?utf-8?B?UldLYjZiQ1JPUjFyZC9vem9KMUQrRHMwOUJ0ZzE1K0V5MEZ2R1Z0Qk9lQTVY?=
 =?utf-8?B?Q1BLTktweTZQVU95Zm5VaFFQZVkwQ0x1R0lFUmdqc0ZPKy80VzErc05uQ2pY?=
 =?utf-8?B?b1B3QmF5c1ZBcnB0WExhaFd0dHFnaHFTRGlQOW8vVlUxTWRzSXJVZEk4NWxL?=
 =?utf-8?B?bVhUSWJ2N1ZhUk1wNHcvSHZpdlpuWVoyam9nOGtpZVJNWVJrc3BuaW9oRWFi?=
 =?utf-8?B?M3pPdVdqbFl3RkdZUzNTbVVxTldYb2lLVDFOc0FRTzB6Ui92aFlJbmVMdTkv?=
 =?utf-8?B?MXVnRStVbXVCTGtzdWJUWU5yRllHNmMralU3NEdsT1IxMGhwdnE1NlllcEtG?=
 =?utf-8?B?UmoyRHo3NnhzeUh1VWtLQ2poeFVYVzh2Sm9aVWp2MUhJR2hNbC9QaVJ5Y1Vr?=
 =?utf-8?B?a3hhaGNiWTY2OEkzVG1tRG1lTldGTG9BU1hLa29RdVhoOGJobjlRM1JLWnRL?=
 =?utf-8?B?Z0FFR2U0UVRoVENuTkZlZHNDS244U1Byd1FuR3J2ZzdacUx6V2F4bzhRczd1?=
 =?utf-8?B?ZHhGMGVZQUpzaEIrcGx0akEwRlNpN2F2bnh3SHcvMVRLMEtROVIwLzQ1NzdZ?=
 =?utf-8?B?djBlcmhxOUhVRnZQTDZuSmVrQ2htc3dZS3BGRm1IZitPelJZR3p2bzk0MkZk?=
 =?utf-8?B?L1RGOVRVRUdVZWtiekVUcHpROWprQWlmUzdTTVhCR3V1VnhLaFkwbkJrZjZC?=
 =?utf-8?B?RjN1T2YvcHMwbmF6SlNoTmZ1Wm8yWDY3Vk5vaFBlUGlvTGJaU0tHeWtjUGhZ?=
 =?utf-8?B?U1k5VElNaC9IOWR6dHpkbVc5ZlVWVXRNUk5NOXhxT0xWaEJ6QjFQeWNLa0FP?=
 =?utf-8?B?VVBWQmZOYVc3dk5TWXkzeGQ0NXY0LzVJQVpQYkhxbWt4VFU5NzRhaXptVzJX?=
 =?utf-8?B?UWJibVNqOU5aOGQram9ML09GZnU4ZkMxOU00S3dBWnRTU0hNTkR5YmJ3RVlu?=
 =?utf-8?B?Sk5YRVlLVmFyZWxERHRGemR0RmoxbStNVSs2K2tLNEw3RGc4RnQyQWdqUFBs?=
 =?utf-8?B?VHIzUUtLclhEQVV0bmxOdUtENy9SODdzOVB2eGpOVmZ6SFJyeEx2aFEwRyty?=
 =?utf-8?B?T0thS1NXeVA0V0MwN2tURFV4M1doZG1ZUWRJZmM1bFBqQVgxdkxOL1FzRFJm?=
 =?utf-8?B?bGd1cHcyd3M2Sjd4R0tOUE9JVUtOTG9CbGw2QkVmMThXSFF1eWJ3K1BoZkVZ?=
 =?utf-8?B?QWxhZG5VTzBQQ1htNWhGUEQ5aFMyek5wR2xqRlpERUh1WnJ1MDdtb2diR1Rz?=
 =?utf-8?B?YjhOanZVQ2JWMGdsMFZ1eVlGTkVRdmp2NWxxSjhaa2NuZ0d2SjljWVl6b05S?=
 =?utf-8?B?K2NPdms1cE96ZWFWT3ZPTWRQVzVRaFRUTUNQcEZmMXNtM3pEK1BuZGlIRjNQ?=
 =?utf-8?B?aFlXb0JDVnV2V2NablV2TGRWRGNYeDNwbXVvWUpQMUEzQVdUa0gyRTlpN2lB?=
 =?utf-8?B?NGVGTkJ4TzYzdDR3dzBSMmxkTDFQUnlYOVBObTk0ajN0OGkyUGgyTlQrVm9W?=
 =?utf-8?B?YTFRNWtDWGg1Zk1HZDVlWHdPbUZTWFdNZjFRblQ1YWt1TmFVVE1lZnFIRVlu?=
 =?utf-8?B?YTYrQlZYOFNaT2lyUDhDSStnSjR5bEo3Wng2ZEgyZFYzeGV4SUNxdzIvNGlG?=
 =?utf-8?B?NXZWWU1QUHM3ck9xcE82V04rcUcrenA4RHZFMTVaRlpMR2RMZEFpT3FTeHZD?=
 =?utf-8?B?QWJscnpyU0tZTmplaWFJRkJDQ2hWUGx5NWVWclhrRHVZR2NZNU5SbXA5TWdK?=
 =?utf-8?B?d3R5UFFtdzAvSTVFSmM4dmtCZjFHUU9maFlBVWFoNjZBMTFNbTc1NVhQZGpM?=
 =?utf-8?B?cHNUeDgxN3ZHTGd4V3AxM2pVWGFNTDBsaWhqTDRmakZ4clVzNEt5cDlPUU9D?=
 =?utf-8?B?Q1NOMjBZZ21wKzhDbnJlT2lhdWdLNVZSNUlqUzdYOVBreWVzeFZQQ0xaaDdF?=
 =?utf-8?B?QXVtKzFST0RRNnF2cGdSZnB5VTcvbHpQMUFZMkoyNzRMSncwSVBjMWdaZGZ4?=
 =?utf-8?B?SlRXTkg5dmVIaGY2VC9yS1hmeWdiNkRBZ2xoT3YzZVNQb2ZxeDVxL3FMNk9I?=
 =?utf-8?B?RXlhMGNCWFpyUmZMbUZYdTByYU9WMGV1MzhIV3dBLzNRczdwREhPZUhsbHd6?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf9d3bd-9878-4d85-4b11-08dc8c1424ed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:48:52.7600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrhgO5cR5yCNxeunKjpz7GLl2dmX2Zr4XdAZRmmyaayKA6EjiVbQ0u8Z+yYokkq42mLltnGOEOnVZ/QcWoH+lD6QN+gVTrFqbxnYb3x5B44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> ABMC feature requires to users to assign a hardware counter to an RMID

"requires to users" -> "requires users"?

> to monitor the events. Provide the interfaces to assign a counter.
> 
> Individual counters are configured by writing to L3_QOS_ABMC_CFG MSR
> and specifying the counter id, bandwidth source, and bandwidth types.

Where is discription of what this patch does and why?

This and following patches seem to introduce building blocks that
are only used later in series. These building blocks are introduced
without any information about what they do and why and that makes it
difficult to understand how this work will fall into place.

> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>      Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v4: Commit message update.
>      User bitmap APIs where applicable.
>      Changed the interfaces considering MPAM(arm).
>      Added domain specific assignment.
> 
> v3: Removed the static from the prototype of rdtgroup_assign_abmc.
>      The function is not called directly from user anymore. These
>      changes are related to global assignment interface.
> 
> v2: Minor text changes in commit message.
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |   3 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 101 +++++++++++++++++++++++++
>   2 files changed, 104 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 45ed33f4f0ff..a88c8fc5e4df 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -657,6 +657,9 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init resctrl_file_fflags_init(const char *config,
>   				     unsigned long fflags);
>   void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
> +int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
> +			u32 ctr_id, u32 closid, bool enable);
> +int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid);
>   void rdt_staged_configs_clear(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0e425c91fa46..48df76499a04 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -203,6 +203,19 @@ static void num_cntrs_init(void)
>   	num_cntrs_free_map_len = r->mon.num_cntrs;
>   }
>   
> +static int assign_cntrs_alloc(void)

Only one counter is allocated and "assign" is unexpected since it
seems to imply how this counter will be used.
It can just be "mon_cntr_alloc()"?

> +{
> +	u32 ctr_id = find_first_bit(&num_cntrs_free_map,
> +				    num_cntrs_free_map_len);
> +
> +	if (ctr_id >= num_cntrs_free_map_len)
> +		return -ENOSPC;
> +
> +	__clear_bit(ctr_id, &num_cntrs_free_map);
> +
> +	return ctr_id;
> +}
> +
>   /**
>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>    * @closid: closid if the resource group
> @@ -1830,6 +1843,94 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>   	return ret ?: nbytes;
>   }
>   
> +static void rdtgroup_abmc_cfg(void *info)
> +{
> +	u64 *msrval = info;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
> +}
> +

Please add comments to these functions to summarize what
they do.

> +int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
> +			u32 ctr_id, u32 closid, bool enable)
> +{
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct arch_mbm_state *arch_mbm;
> +
> +	abmc_cfg.split.cfg_en = 1;
> +	abmc_cfg.split.ctr_en = enable ? 1 : 0;
> +	abmc_cfg.split.ctr_id = ctr_id;
> +	abmc_cfg.split.bw_src = rmid;
> +
> +	/*
> +	 * Read the event configuration from the domain and pass it as
> +	 * bw_type.
> +	 */
> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_total[rmid];
> +	} else {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_local[rmid];
> +	}
> +
> +	smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_cfg, &abmc_cfg, 1);
> +
> +	/* Reset the internal counters */

"internal counters"? This needs a definition ... but since this is not
a new data structure the comment can be more specific about what is done
and why.

> +	if (arch_mbm)
> +		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
> +
> +	return 0;

If this function always succeeds then it can just be void?

> +}
> +
> +int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid)

Please use consistent naming. Note how the filename is "rdtgroup.c" and this
function operates on "struct rdtgroup" and if you take a closer look at
the functions in this file and the header where you add this function you
will notice a distinct pattern of "rdtgroup_" used as prefix. There really
is no reason to start a new namespace for this.

> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int ctr_id = 0, index;
> +	struct rdt_domain *d;
> +	u32 mon_state;
> +
> +	index = mon_event_config_index_get(evtid);
> +	if (index == INVALID_CONFIG_INDEX) {
> +		rdt_last_cmd_puts("Invalid event id\n");
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
> +	/* Nothing to do if event has been assigned already */
> +	if (rdtgrp->mon.mon_state & mon_state) {

Why is this mon_state needed? Is it not redundant when considering that
struct mongroup has an array of counter IDs that can already be used
to see if a counter is assigned or not?
What if there is a new:
#define MON_CNTR_UNSET U32_MAX

When cntr_id[index] == MON_CNTR_UNSET then it is not assigned.

> +		rdt_last_cmd_puts("ABMC counter is assigned already\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Allocate a new counter and update domains
> +	 */
> +	ctr_id = assign_cntrs_alloc();
> +	if (ctr_id < 0) {
> +		rdt_last_cmd_puts("Out of ABMC counters\n");
> +		return -ENOSPC;
> +	}
> +
> +	rdtgrp->mon.ctr_id[index] = ctr_id;
> +
> +	list_for_each_entry(d, &r->domains, list)
> +		resctrl_arch_assign(d, evtid, rdtgrp->mon.rmid, ctr_id,
> +				    rdtgrp->closid, 1);
> +
> +	rdtgrp->mon.mon_state |= mon_state;
> +
> +	return 0;
> +}
> +
>   /* rdtgroup information files for one cache resource. */
>   static struct rftype res_common_files[] = {
>   	{

Reinette


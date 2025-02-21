Return-Path: <linux-kernel+bounces-526574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1DFA4007D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936A54283E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12939253B73;
	Fri, 21 Feb 2025 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTpN0p07"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051821FF7CC;
	Fri, 21 Feb 2025 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168686; cv=fail; b=n2782xkUVkB+tsyi6Z3d4jkBlzpQgEK2wicdcJ8Km0gGM//SsWVjwRytmGPVWbmYZWnrU79vlqJiNLPFB5nRVXnanhNkyVwUaIMcYGeJjdDYT7SiCf1jnwBrpK35QSb2keTg+DgDoJEOn/t74MIYs2ozL3WqIzgghbkGqezgBgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168686; c=relaxed/simple;
	bh=iWy0kKBX5x84KIX912vboT6hm886R8EC3/SniVumeI8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGhyzxZLVar4ZaRZYFOxatuTSLGbYHB+EbP//y4rPo0haN+BLMojwffT56RIdM6f7D/KeTZKUrjU2eaymFzKgNxXLZ782AqZk0HSnx0SddviigCO/2Jq4g7GAOwZUYTIBMGLyRNh3v9UTzWwGVDjHEqzYnqLc6VEnGnYNjzyJeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTpN0p07; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740168684; x=1771704684;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iWy0kKBX5x84KIX912vboT6hm886R8EC3/SniVumeI8=;
  b=lTpN0p07j/NRt36qOV3jNc62rUrDfPBK0EjOCL8aY2WDwCRkfJf/trbb
   7LdHH0qKV7UZK2AhDiVXWKmmEFH+xxCnQukGt8tUkHqIYwTzErcDRAmIM
   xfI3djTAtb9k6qGGY09nU0iDJ9dokK1ilUmw7SKj1L4rDkMjbf88emikW
   UBZDjc1N0CCDeJRQ1vGUbWtukNqIQv/HVhLoTpYy3XuenLkWmm252bVfK
   h8Zpnr6gOWbZb25wAHaZH7Z24tMNqJsC380R6ACY/HhikMmPF+Cd3lPFz
   IcVa5uayU3PgVyNOVxXHS3y3EqjZQBjmT3rZPnSHb86/JzheRoUfJl6Sh
   Q==;
X-CSE-ConnectionGUID: QfQ0+O1IS02G272NUJRK8A==
X-CSE-MsgGUID: jsQ0arEIRBaSNan0HN+W0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41205009"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41205009"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:11:23 -0800
X-CSE-ConnectionGUID: y4Y+/QXbQwidvPLrEs+KrA==
X-CSE-MsgGUID: ASaMrg3DRs+YjLhevXPZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120704436"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 12:11:23 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 12:11:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 12:11:22 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 12:11:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZVj0zuupHkS0CgDnV/txbZP7KcUkzYn9fcSWGawqvF5RLFuGNf1VLoirVCb4yBIGIieWIABKDta1BrPjFxvOu1fLjCOwXXorMesUvIsTRJPkjEjeGG4rA2kxPFXbgPw50iTXFOGfajaHZMVXeiXKDbNNldqOhW3yL3adCUi/suPiErL+sNx9K276B7pK0PLn33bA4mwvNZPAIyN8f9w3PcIE5cEg47forVXzqdntflBCFr48AWJzLcIAM7/CX22rSi3i1q+yzK8m6HY29xtRd71jgtuB7awJek/sFWdNJBOmgI6UmodVmy32s5RTl/o6Uga3VmVetUKXgxNT9GCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqr1lPKin0Xhr7MnDwdzD7TwT16KyhGaFTrSe7hYON0=;
 b=FI+PAXlfB32wevCrgj8GszrUQdluX7WXVlNn03l5xeVvdUgm4rFZhSyAHxov3yJhJ2E4JXaStkmEstnNFYfusHsPgc/ovuVIE0LQkDXKWQ9/bthAoEFwYilgPhAYrcK9RtZgiQThPy7snPosgMoDBIdvvbeu5/+TuXHAbpwo148wy172LgP4/TLd9hMKe2CyqVn92rDRrtQAmVyj+5+ZW3KuRbqy1HrLeiqkSpGSELpKlOP6NpV+E1G6tOiP3jsejBB2wO3OFXK/rDmUac04PC39xe/CCNGgisn6Vwlfsaq4XlS5Uu7wVAA2eiRHXIfAqGgKOVPmLfrkhLztTXrDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6121.namprd11.prod.outlook.com (2603:10b6:208:3ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 20:10:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 20:10:48 +0000
Message-ID: <09f2f512-0428-4649-b8ef-33e5a03d5dcb@intel.com>
Date: Fri, 21 Feb 2025 12:10:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
To: Dave Martin <Dave.Martin@arm.com>, "Moger, Babu" <babu.moger@amd.com>
CC: <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <tony.luck@intel.com>,
	<peternewman@google.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
 <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
 <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
 <Z7dN2KpsQjVUb3KR@e133380.arm.com>
 <7802f9e9-9a63-463d-a51e-e9ad0e60f77f@amd.com>
 <Z7ijCphcSM58AqA6@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <Z7ijCphcSM58AqA6@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e04b292-3e69-48d0-a612-08dd52b3d4b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0I5Y3RXYk92OHJDSXVNY203Q2pqb1lPd1RXcTFrRlkwZzh0NTNONGJDWDdD?=
 =?utf-8?B?RG9NMEJteVZETnRaU3FVZFlBWG1KU0crMUdWYWgzTlh3aXZoaHdEcG1Qa2Fx?=
 =?utf-8?B?NUp4cnRGUldSeFNXd3BRM1E4Nld3WjBOK3FmbFJqY09CQnJTYngzVTNJSTdB?=
 =?utf-8?B?Y0JrZzFVaXQrS1lERk9WRFl5VStNWVVJOW96dkMwN0syVDQ1OHlWRDMwMHM0?=
 =?utf-8?B?R0g3K2Fkbjk4L3NyZ2tKbTJKbVNrTHhHc0s3eGtEdlhxSDVhNjk3U0hINkE4?=
 =?utf-8?B?VXBTYUFTblZjTFAwMWJDNm1YZ1RZS1RSbndUWEIyaUovWmJleHcrU0dwckNM?=
 =?utf-8?B?eWpRLzZTdEY2VnNVdXFIdHFLVFEyYmwyb1F4am50L0h2ZGZkL3FOYXdsd3pP?=
 =?utf-8?B?OTdMUHRObmZwSUlFcXhwNWs0Ukxob2piQnBsQTZGZVF3UTFJZnNlVWdZN1JB?=
 =?utf-8?B?d2tydjltY0dpeGd2K1VQZlV1citON1REckxUTjZkbnVyek1RajVQRlJLMWkv?=
 =?utf-8?B?SGdYWnRhUW9zeXM2TkFqU1E1Q1Arb25zWGF1ZnF5Z05yU1pjVDhZT00yUTNV?=
 =?utf-8?B?RXg5VHVwQmNrV0ptZk9ISmwzMDBzUjNNRG5kakpjVGxLYVk1cXZmdDhuYllp?=
 =?utf-8?B?aDBzUC9ZYVhRSmtQYU0waHcwNTkrL2pFUnlGTHgrSDhPOUVUZ2ZVdEtBampJ?=
 =?utf-8?B?c2Z0REEyVGdNc0N4NXdmYmhXMUNmdzhRanZtcWdnSld2MHRkYjg4ZDRlRXFt?=
 =?utf-8?B?cldQYktMREZSMXlVOEx4ZC83cUdDT0pCUXVFTFlrd29DSzdmMzJZdlQxUUox?=
 =?utf-8?B?TXVFeEhGaTcxN2hDYkdHV1lodko1bnZIL2phZzIwTDA1c0Vtc3I5SkQ3b0VO?=
 =?utf-8?B?M1hCbk0ydS9YNDhQZC9DRFpXanpMY3pXRlpqd3c5WTg2eFphSjdLT09MY0JW?=
 =?utf-8?B?ZGUxd2hlaVg1SEE3dHMyWjQzRnR3c0VGQUdyTnJJT1Boc0lwSW9NVkxYeUNF?=
 =?utf-8?B?NlRTSnhmYTU5cmE3elExMUlyUWpkdTVUWUFYTTd5YkxUSGNDNjdTQ2tOZUxF?=
 =?utf-8?B?TTFxZ3ZicnhaQlkyWTJrTllEY2k2ZVNLMmRzOU9RejMyT2R5ek1VVGZ6cDBy?=
 =?utf-8?B?QXZWR2lMWkNDTlJoY2pydTROejBWN0ZGQjRIbGVEcjdsUEJNaTh4S1F6cTZL?=
 =?utf-8?B?SVQxSmVxV3Nrb0lOTE1vd1J0TFBJb3JpTy8wSVRSVDJrZ0Z4MTR3VW1BdDFN?=
 =?utf-8?B?d1kzR2k5NHViYmxKbGIrYzhPTjdMUmtPNWp0RjZ1d0lUYVpTdW5EeUczSGxQ?=
 =?utf-8?B?QVZFVUd2VjRWbWVTbEdRY2krT2FTMC9lTVM3MUpYYlNHc2lheUFDSkhrbHB2?=
 =?utf-8?B?UU1ibHl2RXdwQlB2NXFLcUdweTZYd1E3M1JsODc5V0NHUS9uOHRtMVRSSlhZ?=
 =?utf-8?B?UVBQRkREUHpXZE1tSzkrVUYwbFZxZlF5UDFoZXZOMWdESE5wdFJKdEpxSEhy?=
 =?utf-8?B?K2hwRmxVeXlnc2ZlL0ZGV0xzejR0WWx6NDRBeG94VWE0M3dUdVQ2NWlEZDcv?=
 =?utf-8?B?VCtwOXYvNEtUVzhBRXU0enpyeVNoUmVZOXhHSWN4dXl1RXpSbWNYWTRyVDBX?=
 =?utf-8?B?b216WndWYy9SS2Vmam10NnkwNXdRMGdadjJyM3RJTmZ5SGNVTXRaQjl3VVJ5?=
 =?utf-8?B?VThxUFloS2xqWFBXeEtQaHB0UWsyUTloNjQwUGEwOHhKd0NpYnBDQyt6OW5X?=
 =?utf-8?B?V1dHUVIvM0ZqT21xMkpWOTZob3Q5VmxKNFJNeTdkaTVYYitDMSt4bEpCL29k?=
 =?utf-8?B?S0E2OHZ0VmJlQWpIYUQ3d1BiWEJrNEVkM3hWMENDSjdVNFo4YkRYUlJkbzNH?=
 =?utf-8?Q?zQKFZxE4PQtAi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJxVStmTUJWYmUxNy83emt2Sm8yRStYempySEJvWCtkTlc2VWljbWZWUmcx?=
 =?utf-8?B?a1hyVFlpcEZ3cnRqNnMxWDZLcU1VU01BM0YwNXhqU1pRSFh6RTlEVU1JcW5T?=
 =?utf-8?B?cWVsL1FnakNJNnR3TVUvNXljTFRSa1NWeHlESEtyWDA0MGhxSGI3T2ZZR0FF?=
 =?utf-8?B?VFBzSHN6L0M5OUpGcTVTeUNmMytzcUNEZXAxZFYycmxBMWdVK1Fwa0pES3gv?=
 =?utf-8?B?UFZpOGJJUGpQem5RUnVVK2pWWGlVNDdQM3B5NmttdjBMQTBMNHRwQm5NYnVk?=
 =?utf-8?B?b2didDZ6ZUg0ZDZieTlzL0lrVnV3U3V0TTMzcDh1TGtpY1V0MERKNkovQU8z?=
 =?utf-8?B?T1l5RFAwV29WbGRLVnNCeWEyMEdHUXhsSnhPRWdVOVdldWJOM1dBai9PZnJr?=
 =?utf-8?B?dUJ5S2xRaXQ5V3lnSVVXeTl1WUdNK04yVEVqbVhWeEJMVlkxRkk5dnloMHM5?=
 =?utf-8?B?SCtBanBPQlJMakUrTytBUmEycHlXNGg5ci9CaklzSG9ndTNPYjFmcXVCTWZT?=
 =?utf-8?B?dDRNWWFzMzFSOUdkeDFDOVNlSUtBN3A2WGhldkRCWE1TSTJ5L2VqTUVoK1Bk?=
 =?utf-8?B?SWh1VEgxNzBZYU1mUnJNcXNXRzUwb1MrV0lRelBnb1pUcVc2WmkvYVlUcEt5?=
 =?utf-8?B?a214dTZGdDlGdzJhblBiaEc3cGs5TEtqQ0czYkphbW5TNm1PR05FcmxaS3Ur?=
 =?utf-8?B?MUZHQ0ZoK1JPcmhIYWVyRW9ubDhCa0RoZGtoM2xiaU1JOVd5L1I0K3RqK2lU?=
 =?utf-8?B?WWZ3MklWOThsWWVpS08yaGttNFBaQ2NPSExnTU9uV1RaY3BFTUJuYjQwSjVX?=
 =?utf-8?B?Mko3WVR2eUE2blV3eHhVMnlzemhIUVNJQlRvM1RUcFRHVXo5ZnJkZVVGbmNN?=
 =?utf-8?B?QUR4QzdPdGJ1eFdmNUo0a2RmQmNwT2w1a0dlL0UrMGppb25IL1ZwSWF6Q0pG?=
 =?utf-8?B?akdVVGFUQXB6b3RFaGxqaHFIQ3RIcmRwdHFHaVlCcGVtNmlOT3hBSmVodkc3?=
 =?utf-8?B?dEpKL0JIZ3hrQWIrWUpoMWc3aEI3LzZIak5WdDdWOHJ0YU9EQTY3RjRXSktl?=
 =?utf-8?B?MXMrVVoyUnVpSk5rSWZjd0kvaGJoZmtXZUhtVGI2bUZ1TEdpcEM3TzJZc1FM?=
 =?utf-8?B?ekpSQXZZWVZDQmgyVERrSUFtTWlKdjhxVm9JU25EbFEyUmtDUk85ZGEyakYz?=
 =?utf-8?B?dGsvN2lJSzd1UDN3ZjBodExld1BObDlZUTg4K2lna1J4NWJXYXZGRXF3dTl0?=
 =?utf-8?B?cWY2S0pUNEIxb29vRDVndkR1eEdiTmZBbENuUVJURDNRbzY2Q2o0NDVaWlhn?=
 =?utf-8?B?OW1BTzVuRVR1cVlVQ254NFc5SS9xYnpnTGYzV3UzYWVoa3dSMHRIakN5bkF2?=
 =?utf-8?B?QU1MTS9sczhzZFYvOUkyMXpHeTZ3eTJVZERxTWJ5WEViY3RtSUFYWUJVY3Rq?=
 =?utf-8?B?QWdlUGlhYUdFV0VzdTJpMzNhV2k1Uk9tcVNQU3A3dmplTytvOWpkYmJCY2p5?=
 =?utf-8?B?ZG1LQkhrVG00NXVnM2tDUG8rVDVFK3p1Rk1ZR3h2ekN3bzE5S3F3UVdjemhJ?=
 =?utf-8?B?cWlBdHdsaDJZRHRtTUt3RXFWQ1RDb1E3RFgwN2VoQUJ3NElGeElMRnkxdkZv?=
 =?utf-8?B?cStwNklMZ3JndnAxY3FCcHQzZHhZZlQ3U3RjWS9TRjgyWHBHbmVkeksyVTl2?=
 =?utf-8?B?QmVTMkhkaEQxR1dOeHZDcXF4ZXZWd3cvaU1rRktSaWhhelpmWlA0cStxMnNX?=
 =?utf-8?B?VlBXUlFkWVFpS0RZeDJJMDVSVURCY2t5MWVPMXpKb0xzc1o3SG1ObmVENWd2?=
 =?utf-8?B?TGNzLzJjRnRrS0pSSzNIOXVzd0VCSnZMK0RERHpxSWpmZDhmOFFHM1RNeWlE?=
 =?utf-8?B?WDlmZU42YlJleDBDTWZqL2hUQ1AwcGFCOEVFVnd2ckNpZFdlK2hJNVhMRENs?=
 =?utf-8?B?MC9SNWwrYks5WUREVUh5QzY0V0Z0ckFKc3RsRk1CV2lPd25ZSTlkd1lJZGJp?=
 =?utf-8?B?RVNNamVoRXVFWTByeXRhdjBpclNGRFVIOFJkSzdYZ3J5RGRvYWJ1V2tpZmxw?=
 =?utf-8?B?WEdjMjBYYTZzWVY2bDNlWC9xTkJ1WHZiUDBER1RNZzJ3aWkvUXpDcVZOdVNL?=
 =?utf-8?B?WVdDbnIwUDUzcCsxU2pOK3RjeGZrSGxRK3lSQlhnaW1HNDBSTTZIRmN4T1N5?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e04b292-3e69-48d0-a612-08dd52b3d4b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 20:10:47.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LPW/gVVGvV3aThs1UnK+/WW24SPjeMgJcSkju1v3myaxqaoQV0hTDsX+rirhOFSxSw4PCP/dnZ09BVAD8L6SrkVixw7Y50LXmANgzamzYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6121
X-OriginatorOrg: intel.com

Hi Dave,

On 2/21/25 8:00 AM, Dave Martin wrote:
> On Thu, Feb 20, 2025 at 03:29:12PM -0600, Moger, Babu wrote:
>> Hi Dave,
>>
>> On 2/20/25 09:44, Dave Martin wrote:
>>> Hi,
>>>
>>> On Wed, Feb 19, 2025 at 03:09:51PM -0600, Moger, Babu wrote:
> 
> [...]
> 
>>>> Good catch.
>>>>
>>>> I see similar buffer overflow is handled by calling seq_buf_clear()
>>>> (look at process_durations() or in show_user_instructions()).
>>>>
>>>> How about handling this by calling rdt_last_cmd_clear() before printing
>>>> each group?
>>>
>>> Does this work?
>>>
>>> Once seq_buf_has_overflowed() returns nonzero, data has been lost, no?
>>> So far as I can see, show_user_instructions() just gives up on printing
>>> the affected line, while process_durations() tries to anticipate
>>> overflow and prints out the accumulated text to dmesg before clearing
>>> the buffer.
>>
>> Yea. Agree,
>>
>>>
>>> In our case, we cannot send more data to userspace than was requested
>>> in the read() call, so we might have nowhere to drain the seq_buf
>>> contents to in order to free up space.
>>>
>>> sysfs "expects" userspace to do a big enough read() that this problem
>>> doesn't happen.  In practice this is OK because people usually read
>>> through a buffered I/O layer like stdio, and in realistic
>>> implementations the user-side I/O buffer is large enough to hide this
>>> issue.
>>>
>>> But mbm_assign_control data is dynamically generated and potentially
>>> much bigger than a typical sysfs file.
>>
>> I have no idea how to handle this case. We may have to live with this
>> problem. Let us know if there are any ideas.
> 
> I think the current implication is that this will work for now provided
> that the generated text fits in a page.
> 
> 
> Reinette, what's your view on accepting this limitation in the interest
> of stabilising this series, and tidying up this corner case later?
> 
> As for writes to this file, we're unlikely to hit the limit unless
> there are a lot of RMIDs available and many groups with excessively
> long names.

I am more concerned about reads to this file. If only 4K writes are
supported then user space can reconfigure the system in page sized
portions. It may not be efficient if the user wants to reconfigure the
entire system but it will work. The problem with reads is that if
larger than 4K reads are required but not supported then it will be
impossible for user space to learn state of the system.

We may already be at that limit. Peter described [1] how AMD systems
already have 32 L3 monitoring domains and 256 RMIDs. With conservative
resource group names of 10 characters I see one line per monitoring group
that could look like below and thus easily be above 200 characters:

resgroupAA/mongroupAA/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;12=tl;13=tl;14=tl;15=tl;16=tl;17=tl;18=tl;19=tl;20=tl;21=tl;22=tl;23=tl;24=tl;25=tl;26=tl;27=tl;28=tl;29=tl;30=tl;31=tl;32=tl

Multiplying that with the existing possible 256 monitor groups the limit
is exceeded today.

I understand that all domains having "tl" flags are not possible today, but
even if that is changed to "_" the resulting display still looks to
easily exceed a page when many RMIDs are in use.

> 
> This looks perfectly fixable, but it might be better to settle the
> design of this series first before we worry too much about it.

I think it fair to delay support of writing more than a page of
data but it looks to me like we need a solution to support displaying
more than a page of data to user space.

Reinette

[1] https://lore.kernel.org/lkml/20241106154306.2721688-2-peternewman@google.com/


Return-Path: <linux-kernel+bounces-518764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90968A3942B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9423A422A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20BC1F3B8F;
	Tue, 18 Feb 2025 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNbUTXJZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F161D8DE1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865106; cv=fail; b=tyrDVhH+eksdurqr5sNkZJcUZXa3TG6xCLv0JTQlyRjrouib4A2EEtDJUGCtQw2H6zyHQD/wfLVP5I0wkgnLihs3GjiepRjVSXPamBoBdWI12EvxxvKsMjFqd7yfttxTpgJNXpj91Q/ImLdHSsXXohm1svEppVY3cK1q2j4E4AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865106; c=relaxed/simple;
	bh=gs15dLiQLePlGr0sVd+OaJWoQ+oYI/TZndm62x4enXo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I5Ob6RLgtbZqQ5rB6hbV6lf5fN/ISdWPTwyC0UaAoO0Xk7OW1BslNLcxJ+pS50HRry46vsLKCpeY0LtWN0iYnMhmpV0r4aUO+I4unQSJhCMDDQf5/q0XFZeNfYWXtKnP8hYccehC0dGoQUIxNmmvEetOM2h0C5D85Tjp5BS1JMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNbUTXJZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739865104; x=1771401104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gs15dLiQLePlGr0sVd+OaJWoQ+oYI/TZndm62x4enXo=;
  b=HNbUTXJZz8XLnkcu3tGXMzo9J7ds5UXj0CZw4VWp6qP4FhVLy0tQb+9E
   wppz0jL/j7Ux5U8cEYxcrIs82SAfsuNruCYJcLrAVVsuWK+mx+KFtfz58
   tV6S9zF7/pQG+DFxU2V8S4MNBWYof/f1bRH5kyL5/KpNawx9hveJw203q
   XpX2Qgs1dFtZnqiFQOBtc3hl66BZuBRQw56QzFP1lbbbrEd9fzqcbzpmd
   zlDj65f4rV0YMxdr71v65heTG4H4c3WFtiE/xEIr+QArL+X3G6+MKXw5u
   ROn5ZhKYVXctiFo+ZKcPWllaT1NCtvm/e5E0Ttx8nNAS5Lpem47Ojy9y1
   A==;
X-CSE-ConnectionGUID: 44cY/ObnTyuR9gdUMaQ6BQ==
X-CSE-MsgGUID: t4XEPNffRKOKiy/AEuAI8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40804739"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="40804739"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 23:51:38 -0800
X-CSE-ConnectionGUID: bjllLPShS4q+ctygDOPvLA==
X-CSE-MsgGUID: XpM2OCqAR6itA5f0klq0wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114784779"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 23:51:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Feb 2025 23:51:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Feb 2025 23:51:36 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 23:51:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNb9IKGRkG6vE1NBlBJ0xsB78e/66aZDumxnuA5/WkbrOC8uWHEWdzmIOzMskEz8MASELZ3TKJUjjG7VWuF7+U8rP5/7tcQOa0eUxmEWnjFcMvpxCItwb1USUDjwMxKKTQxp7GBNLFV7AQJ3wSi69z9mMCwG4YbLpuo1dnP2i3cKVPSqa7e1xeMWabamj4X6Fl4Qr94CyCueeQOtxSg4sVJIQ4lzfpPAarnBRQUHZolPLUzbLcMq4Ha+4rE4so9/2ZiKK2J5J+7RfQb+CZJt19+Rfb/duZcsJfAMYW+mz1sHuh7ov/Ce08yAh6FiuVoNXFCwbI7tH7VOLsUxbJLPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOV5zylZwmHq7PQxeHyQlADUQTK12o3MdWlwNsw86EM=;
 b=dlNtt1q2XxRn8QBF2rfRMEtLBhv8G3+kc8pIDVOw0tXYXSBFrFy4Zgbz/pGUBb2CkhEKdrxH3Z0zsgyNiGNYuegDu7v0ToPAKMzIQsznGI8VGF33L9FcNAx50w4scyxMw3HuD3S8M7VFVhu1DXeTYP2Pt0x8np+54LU+KvEoLAdIqnjCBc6CAn9zbUVhkz63h9uYk3wVWhwEhNyuTbjU6bcmkaPJ9iAXzpDcV03K/k6f8juXWH5Yst455MZUYA7LGLSV4w8wastjjc648A6t6SXupyXSRMoGXgueTmWmmTyg4bE1Cx/pSo1cflvue4XHNqe9oQRSB67JqY3uE7vbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
 by MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Tue, 18 Feb
 2025 07:51:31 +0000
Received: from IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::c689:71de:da2e:2d3]) by IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::c689:71de:da2e:2d3%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 07:51:31 +0000
Message-ID: <b88227ad-f5ed-4228-be08-29a4110a2478@intel.com>
Date: Mon, 17 Feb 2025 23:51:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] x86/microcode: Introduce staging option to reduce
 late-loading latency
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
 <20241211014213.3671-2-chang.seok.bae@intel.com>
 <20250217133348.GJZ7M6vFdZtXDd0lF0@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250217133348.GJZ7M6vFdZtXDd0lF0@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48)
 To IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7917:EE_|MW4PR11MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ac5c1f-5c25-442f-0162-08dd4ff10efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGEwNGN6UVM5c01hbXgzK0JqV3I5REl4SkhsUDd6V1JxMmRkZ3ZweTdyL3p4?=
 =?utf-8?B?dUtOR2FQc0VXUlVicnlCdkI0eXNlemdZQkx0ZC9RSkpQRzhTY1hRUmkzOUxu?=
 =?utf-8?B?bnBwcy9tSlRiUTdFK0xKTDRzREVxU2cvM1VOMnFsMU9HUkplbjN3QjhCUDVW?=
 =?utf-8?B?ODRYcGx4R0gweW1wYmlNenFlcmV1YjhnUXR3MlFIVy83aGx4N3hUZ2cwbXZu?=
 =?utf-8?B?L1d1dU1XdHpMbmg0VEcwdjlXcTV4QmdpOUtwSnMxc2paMkRTUVRONGxmR0xX?=
 =?utf-8?B?OEZxY3BzWjZGZWRLaWFoN3FUUVFzMFpDeGdIUnkrZFIxdmRCRGFvT0JCL215?=
 =?utf-8?B?LzBVNEFaSTh0ZEFPcW94em4xS283eHB6Y1I0V05YNlltS1lBV1N4RDhLaEZU?=
 =?utf-8?B?c1Y2YlRRU1dxY0dBQnRCME1TY2xYNFkveDZSSUkyZGZvZHRwSTJEYkFkYzVI?=
 =?utf-8?B?QklhZ2NHbU5WWjFGUitodzNkdjRuNDQzeWlJMDJ0S3hKdVFPKzVqcWVxTnVS?=
 =?utf-8?B?ejZSUS9ZSTRyUkdyd0JqcTRVNUVhRHRzQkFPVEIxVDR1cFhNZnZmWEhCMGtX?=
 =?utf-8?B?L21rckVNT2RobDBiQk5sV2dUY0hFWVBkNW1wbVZ3bHpNWFBOdEg3Y0NpVUJ1?=
 =?utf-8?B?K2lMelRRQkU5TzRJaldIMFVmVHk4RWcvNUtZWEdCUytwZ0pKdjJZOGE0c2p2?=
 =?utf-8?B?bFZXMUttVXZiY2VEeW42QVp6eU5Zdit0MDEwYmlhNE9UUEx5NERSWHVzZVk5?=
 =?utf-8?B?UUsvaTZuWWFjUDNTYXhpWHNEbkU2N2dNdWNWWklxblFkTzU0RUpPbllPU2U4?=
 =?utf-8?B?L0tJRUVKZzV3dTE1WG1tbDdjQU5SQ29VaTU1RVZBb0RSMVY2YnMzM1E4N29h?=
 =?utf-8?B?S3NaVUdITFljSFRsMU9TYmNXcWhTeUhUby9KWjYzcGpQZy9tMmRmTjNiWmp0?=
 =?utf-8?B?YXZiem1iaGR5VTREKzJQZHY3clZmUzJ0bHBJOFBGQWd1VnN3aWhCbjhMSEU4?=
 =?utf-8?B?Wk5Oa3lremVNUWp3VjI5UW9kZHJBQVh0SHpHNXM1OUZVRDJBRmdBNDBxK2N0?=
 =?utf-8?B?TVk4UXkydDQ5WUIvUFNZKzlNc1B3ajk0a3F0N2FGenUwSzRTZEhlRlYya295?=
 =?utf-8?B?QUVscDRuUlhtS3R0ZWVTN1RQNGVobUM1MWxwU3ZEVEN5TkZTTWlLL1VvdVhq?=
 =?utf-8?B?QU43VlhXUnJ2aHFZaFJuSWFNSnhsRGZQcU1IUm5tQ3VINTZZUTZ3VnoxVng3?=
 =?utf-8?B?cnB1VHl3QmczbTVoYkNvaDhKTS9yMWJLUWs3VnQxbjBGZ0FvdUpyVDVnL283?=
 =?utf-8?B?a0V6aU8xQ2tYc3UvUlNQRFkrUHNRYktoODdNTmtMSHdmb3ZRaHhNOWpjQzQy?=
 =?utf-8?B?cU5zd2RyOGZkMjFnK25tT25UYnFuNjMzYjg5dWRISlBpOGdxc1owZ1JENGlz?=
 =?utf-8?B?WlBDZDRqUEh1SjdNaWpWVlZxT1VmQjRPa1UxYyt6Y1Eya2gxcThXM1ZhN25C?=
 =?utf-8?B?SVVYVzA3YjEzaEkrd3d5U2FhcnppZ2h1Q1dIZy9RWnV1VmRJcFowdGdrMUJa?=
 =?utf-8?B?aTNNMTFsUTJiRDB6V3BVRFVIWUdjUklqeHlFQTN1SWtBM08rSFNSQlh4MlRL?=
 =?utf-8?B?T3JlMGh0amVqR0Y2U3RHdUtVbjdjLzZpbmF4SFB5ZXROVmxHWjdRUFFhL2hz?=
 =?utf-8?B?WTlkWm84aFI2RGxFbFdFZ2UrNXFrR1hkUTkxV0NuYkhnazZxNDQ0TmR1VkhW?=
 =?utf-8?B?RUkxTm0wMUppbUg1MTVjZS9ORzNxbEQwWHJkWkJTeS9kQndQcERYN2RFOWhP?=
 =?utf-8?B?enpXc0xRaGN0ME42QTZadGlrTVY0MzlvdjNSb2dxNkFGbUpydUEveEpCSmFk?=
 =?utf-8?Q?ZqRiu/Ubm6OaS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7917.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVsVGtLVkxPU1BhRTlHWE92RlIxZ2xNeTBxa2JzeTZWcitseDBaZ0FQRVAx?=
 =?utf-8?B?V2NkdGJwNE9QWDA4dDl0eUdETmdWaVFURHRWZUtPSThRNENWUG1wZEVMM2c4?=
 =?utf-8?B?ajQwQXBnNDFNaXlxRnZWbUhtR1ZuckFDSXl5anZKRTFjS1lMaC84b0pTQVRu?=
 =?utf-8?B?YTJEUm9jRTRlbjh3MVRCbm5rcUt2TDVLdFlhYmVDOVpFTTIzT1owUzZzL3hy?=
 =?utf-8?B?SVVsWWg5MWtoL1pTcnpEeWFWK09WcW5ibGMzVVRRNjZMeU5oaG1ObE4xaFVM?=
 =?utf-8?B?N0lsUWdKNHJ3bkdqdmhZbU82ekVhS0p4aXhkdW5CbjlkYy92VDF2VTB1eE1C?=
 =?utf-8?B?SDlzcWh5OG1qSk9GUjAxU0xQMGxYUlNscHUxWVovcXRGZ2hIejVNY3hiRE4z?=
 =?utf-8?B?SHE1cFp4RGRoVFRVSDN3eHRHTjVaL3cvekc2S2l6YXVUQmVhM2Znd3l0Rmpu?=
 =?utf-8?B?YTBINmM4eENrQWkxWEtDUlFZSmZMOGJqSjNpOGtlUUsvU1VjOHdVZXdnRTRI?=
 =?utf-8?B?ZEZhWmNrYko2Nm5xSTFVeEpXNTVzaFYyZVdHV2tnQVlBRGFqVEZwdThhWXRQ?=
 =?utf-8?B?K0lGdVpzbWQxaXhZUEtINlZYc0xPTHY4QWF5WENjYmo0Smk1VWdpQjBXcmlt?=
 =?utf-8?B?cytycnE4QklwemdoQTd1SmdKaGdjNzhwWmcrSEVPcURySUszY1ZDOEUxM1cy?=
 =?utf-8?B?N1lqZEJTWlZUejdlOXMrdzVvaGplaFArSnpIV0JDeHVUbTBiMmswVTRYQUNN?=
 =?utf-8?B?VWVXWG9NTTBXb0RTVnVFQ3hrcTR3eFN0cW5kVmdBYXJaZytXaWNyQnNWcHN3?=
 =?utf-8?B?NTlEai8vRldIOXVoUUxOM203RllQckFxcWVPTmZNSWsveVh0TUVlQVFGMjY3?=
 =?utf-8?B?OHFBb29HNEZUTG9Ed29nbE9GdjlwaDc5cEwyaW1pL0FSeG1BSDQ3MTlXMERQ?=
 =?utf-8?B?K3VTNmZhWUxxUVNFMGwvbWpYTHBIOHFBcXdiUlhtZXlaQXcrajJ0Wm4yOU8y?=
 =?utf-8?B?Rk9tR0JVTjBCdnpadzVVU0VGVE1VY0dGcEF4cFQ4QVFqd1NBQ1RxVGU0OVl0?=
 =?utf-8?B?NGhCVlN6ZUxucldsTUgxT0h6bXRlNXV5VmdKWWxNL1RSb0UySnRVQWF2MlRT?=
 =?utf-8?B?YnJaTnlvL0Mwemc0bm81U0VhSFVTVVh0elArTUVpNVJ6eHRrUER2RTBCT05l?=
 =?utf-8?B?OXBUVzh5dlZDTmptTU52Y2VnT2lLb0tYR3Y5Y0VabnNsT3Qra2JQdU9MbktS?=
 =?utf-8?B?SDBkeHNTSjZkY2pjbC9mWnpHRE5tRTlibEFDckR2ZmR0WnhNZ0VHL01LNWZJ?=
 =?utf-8?B?V2ZXNlZHSWpQVVdyWW5ZR2ZOTjNucEk4OXNBaHBvZEF5d2ZDNjVpWnlJSXZo?=
 =?utf-8?B?SXRMZ3dCNW9XTVRHMjdydHB0TEJNUVVlUDFlbTE1L200WjRQbGsyQ0VkMnN6?=
 =?utf-8?B?NEwyQ0Zqa2lSdzBzMnpkcEhERVVGQ2JXU2o1TlU1ay9SeERyWjRieXNDYzlO?=
 =?utf-8?B?UklQTVEvZ3p0aXJrTWV5N3A2TGVLVFhpNWQ5aDNrSy8zWkNUODkvTk9HRVNi?=
 =?utf-8?B?cHN0amsvNVpCUHhqb2lWVFRQdnNRVHZFT1pqRTdMRjJRczMxUW9reDZ6a3lx?=
 =?utf-8?B?UUd2QTBWMFpubDA5UzRjS29nMU50dlpSc01JZEVZNExCV1RmMkpjUWZUTnJo?=
 =?utf-8?B?eGR4cCtEeXdhL0VaK20rMmhsZUVEZEpubStSdCtMUkVZS0dURHNQQ0hiT1U2?=
 =?utf-8?B?TnhKSUlDZjVQNG5wK1F3dFJPY01QSG5Pa3lLemdUNWgwNHRyUmsvMDRXL28w?=
 =?utf-8?B?RGJVUjBvS3Q4TUhlQUFsWWE3d1FNRW9aSUJmc2F0OWdJQ05XWmNFUWQ3VlVE?=
 =?utf-8?B?MlZiUWNxdCtTYXg0ZE9IQnRZeFBCemQ4OFhKVklXMzN2eVRqT0dZTWlsWk9R?=
 =?utf-8?B?dUlyQXBacFpvbjlFRHptRVYvd082Ty94N1NueTdROEhleEMybS9vMFRLUmlZ?=
 =?utf-8?B?RHc4RDJSMlYrOTRYc1ZacS9kMFBMWEpUbXJ4L0pOVjE5TzQxTGdnOGRuUVlt?=
 =?utf-8?B?UXdWNGpyRDllV1pyMHJEdU0veFB2MGNNaTNNSVY3ZE40ZFNHWkJzb29CNnFJ?=
 =?utf-8?B?K1VWWkR2N3pYWFAyZVRUOG4wNU5LNk8vQVgxdGRjcStmSnBzdEdTeXk5b1hz?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ac5c1f-5c25-442f-0162-08dd4ff10efe
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7917.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 07:51:31.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXYwxKzVCvOB1LuJFuBPzEHaqcIWrfc621Vepbi7OSOW6OGlYomY6Vl399/jKetGY44Il2fwE1cZExwg1s5VLG02FXo+3UDa7IWpElAzYJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7125
X-OriginatorOrg: intel.com

On 2/17/2025 5:33 AM, Borislav Petkov wrote:
> 
> Why are you even touching this function instead of doing the staging in the
> beginning of load_late_stop_cpus()?

I thought staging is logically distinguishable. While 
load_late_stop_cpus() currently performs loading when CPUs are 
_stopped_, staging occurs on a non-critical path and remains 
interruptible. So, the function name itself seems misaligned with the 
staging process.

It looks like commit 4b753955e915 ("x86/microcode: Add per CPU result 
state") renamed microcode_reload_late() to the current name:

   -/*
   - * Reload microcode late on all CPUs. Wait for a sec until they
   - * all gather together.
   - */
   -static int microcode_reload_late(void)
   +static int load_late_stop_cpus(void)

which primarily narrowed the function’s scope to microcode rendezvous 
for late loading.


Given them all, maybe another option is to introduce a wrapper, instead 
of modifying load_late_locked() directly, like:

@@ -536,11 +536,6 @@ static int load_late_stop_cpus(bool is_safe)
         int old_rev = boot_cpu_data.microcode;
         struct cpuinfo_x86 prev_info;

-       if (!is_safe) {
-               pr_err("Late microcode loading without minimal revision 
check.\n");
-               pr_err("You should switch to early loading, if 
possible.\n");
-       }
-
         atomic_set(&late_cpus_in, num_online_cpus());
         atomic_set(&offline_in_nmi, 0);
         loops_per_usec = loops_per_jiffy / (TICK_NSEC / 1000);
@@ -674,6 +669,20 @@ static bool setup_cpus(void)
         return true;
  }

+static int load_late_apply(bool is_safe)
+{
+       if (!is_safe) {
+               pr_err("Late microcode loading without minimal revision 
check.\n");
+               pr_err("You should switch to early loading, if 
possible.\n");
+       }
+
+       /* Stage microcode without stopping CPUs */
+       if (microcode_ops->use_staging)
+               microcode_ops->stage_microcode();
+
+       return load_late_stop_cpus(is_safe);
+}
+
  static int load_late_locked(void)
  {
         if (!setup_cpus())
@@ -681,9 +690,9 @@ static int load_late_locked(void)

         switch (microcode_ops->request_microcode_fw(0, 
&microcode_pdev->dev)) {
         case UCODE_NEW:
-               return load_late_stop_cpus(false);
+               return load_late_apply(false);
         case UCODE_NEW_SAFE:
-               return load_late_stop_cpus(true);
+               return load_late_apply(true);
         case UCODE_NFOUND:
                 return -ENOENT;
         default:

Thanks,
Chang


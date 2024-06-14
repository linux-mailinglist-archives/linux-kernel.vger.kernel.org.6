Return-Path: <linux-kernel+bounces-214191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 145649080ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853AD1F21B11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F311822F9;
	Fri, 14 Jun 2024 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpwcbPpI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CDD2E62B;
	Fri, 14 Jun 2024 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329512; cv=fail; b=RkwSynrmGEWesuEG/1GDcTeJjfuQaZcWAye6o4DIouiqQrGQRBGE951A7wHmkUwyeQ7sK2KSGJe0pO0NA2NQ/qW0FP5Rr1Nw9BRpFGk/I/V7pqTydx+5wx9OPv8dcehRxHkva8ipzNJfUQLr3YU6QBTUYj0Zm1glTcUg5aU/VS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329512; c=relaxed/simple;
	bh=N+j5tl7CKmeb8EMy0gey+b9RglQI651BwEwaUOQ4zFw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SsYU1McfDhkCgnVoJFYpkbYOAOrogiocjF7ADtr9DMs4Dhp1LrC26wSMryqWWIB+f7fUbg2j2q3fyhVVZybrxvW2Ld/NY/aQcQiFS3VRQc7JvUApoqaqBY981PwJ1HvETKjXh5niEQw2IhsC1/fv38BbYG3PGWvnykfJJWEahC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpwcbPpI; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718329510; x=1749865510;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N+j5tl7CKmeb8EMy0gey+b9RglQI651BwEwaUOQ4zFw=;
  b=kpwcbPpIBMiWhW0mgAUvCuV7xNf9LzkqwdP8bk2oXPPuz7O0o+EL2MUy
   wTyGhO+K3vdiN1/pCVAIfQmKGTKBQ/1JnmCMgB8kRidav6jCxtem8C8+j
   5QVOz84eZQFgI/z86lDZZ3CCEOa5tjTPqMhnI6f0fnCeyRHBq9w1P30AT
   G/fvhWFQ9PFGwYy5vEc1+tx6bG0T8lXW6ntSe1fYHcnfjWZ6TsgP6gHcN
   VR8YlBwjrtcFIHpiuQANzo1DFVXRyGXXN8/8ZQsyoEVtwltGLwtzVbAuR
   Au1hjhOxNdxqe4qW/CpEgbb4+jFPUBF1sWXOeUX29ujSiffdjg7nr3CkL
   A==;
X-CSE-ConnectionGUID: amLBqjh9Ra28qxKJg8BLjg==
X-CSE-MsgGUID: CV4vWyiIQ0G8G8gQqQq8JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15428182"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15428182"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:45:09 -0700
X-CSE-ConnectionGUID: RKwhbXxXTeKtjcnuzQb15w==
X-CSE-MsgGUID: /GRsB4pqSWm6klp3PlJcWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40481366"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:45:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:45:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:45:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:45:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:45:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj/1zPTlKX0EIjtb60jSVlP4iVrcXnpVESTZVhJc13WP+GL4lQLrd/6qw8UEDz4JOt3Vl8cYSD43VOOtVmgnOCeXCY5WkuFiIKEkYpMJh9zDYGIFrDTa6cTO0QwAHXc4epZDwwFIUw9Wi/Lw/Vfm08q5Tm8LgD1JCMKwgvOVOyN1lA1UQjuEVGozwIBi8TSOJJ3+4t2PEF03yjaMQoU8U8wsPdLkRoK1XdXGR3pyrDCYvckF6g5RVXIY7a03T45Iaami/IjaCKcybsk+pYbUfNlZWNw/e46ZjG4y0V9Cbx4XXtVWOPVmwm994vSnatHezbghCzCGpeFwspE1LBwA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCEpm30NiNFx3f1zqGtlyldnChILm6CiegpBNG7xtVw=;
 b=Dw94pHbD4a1hnBDZGktUrW5BH4QVaEYTezMD6oud/6pyKrYBhrE8Nrbr2b2fbIOszGgYNBCS+opY91XmuMvrpcAQ7kDcoFYYlpu5UYqtVhKCcfdRV7qQMWAUVlo8W682LPWeUR60X/clycoiT+XTRNpybD2B3DeKr7ROFgWGZLUln7DEu1r7See8D7Mvq6j7wgxU5LGiT9ax0btiKg/yztRDasWMpe5nGQzq+/ucr1Vf08wXq4MsMUzBCw7c2XEup431xdkg7zN0S+FmYT/0tBFVs/0WuShN9uRPoGEXLkfWhNpyIRvw/hGQREejg7zkqyxjjUNlYFlwWEhEJstlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 01:45:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:45:03 +0000
Message-ID: <31497c62-fe32-43a6-ba8d-361c4c89422b@intel.com>
Date: Thu, 13 Jun 2024 18:44:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/19] x86/resctrl: Add data structures for ABMC
 assignment
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
 <a68ff64d52eff2de91a3c6030c2650396ea7fb8c.1716552602.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a68ff64d52eff2de91a3c6030c2650396ea7fb8c.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:303:83::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc3003a-b6bd-4930-d970-08dc8c139c40
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUR6QjBXcDNEeFFVUm8xZm1kd3M5c2pwQkFyVkxyNVdYSWlGcVJSNHMwUlF5?=
 =?utf-8?B?ZmczWUlkWWx4TVExOU5LYnJJcWxiek5zdENadVFFYUJscGdzcGNJQ0VhaXcz?=
 =?utf-8?B?NFZudWxRZVU4SndyUmJsb0pQcmlicTlSNGEvYjUrZExDMERxa0ljVHIwd3pK?=
 =?utf-8?B?bTZiR01FSHc3ZUc0bDhFalNQUFVqYUc4eUhiVHpYSWozUkJrUCs2QitkTTJP?=
 =?utf-8?B?TmNXN3ZkbVFZWG82Tm90SVkvRnMxTTJXRVpoV0cyVGh2QndzdldwM3JRVUJV?=
 =?utf-8?B?eHUyU3N2c2FjZ0lmUGJZZjdlRUZ5QkViQzNMcTlod1lwWjlEYm5lcWw2SGlt?=
 =?utf-8?B?aEpEVGEwNmpHSkJldFVrVnRrQW9OQktiYmdyMnZKSHEwOGM0OEY0S0ZIbGZV?=
 =?utf-8?B?NnVMeGNqR0ZrbW1HR053RFhGTWo4WjkwNzI4U3hXWXRTd0dscTRxT2hpL3F4?=
 =?utf-8?B?ZDh4Qk5yUTQwbEF5MG1iYWV3eHM5UlR6QjZTa0VLSEFMaEpZYU95MWNWK3Bt?=
 =?utf-8?B?c0JMeXdHSDFQRGVWaG1MSnB6SnJBV2pIVS9KZ1JFZkxkbEo2SHdDUUtQWWli?=
 =?utf-8?B?L3Zyd3c3L2xsb0xjdkRDU1l1czROdVo2dkZ2bzhpWFcwVUhFQkp0K0pGU1BL?=
 =?utf-8?B?YXd3TUhPcWMwNFFGMUx0Qmt6ZVIxZzVaMWE0bS8zOWl2RkJkYUt6U2JMVklU?=
 =?utf-8?B?MFZoZHFFN3hvM2pXMnNhNEl3RU1ScEtGcDUrbGNTSUsxeldXWWRBU2cyWkYv?=
 =?utf-8?B?anNvTFJXNkt6WTFRWld0dURGb0Y5T0d1WnNtNCtkaDZoTDlscmRvZUd3RG9W?=
 =?utf-8?B?UGpoWkR2UHFmaEtCZ3locFFPeWEwZDgwNDBNWlV2RG9DZ3lKTWc0a0w3WjMv?=
 =?utf-8?B?bDBkQzRQMndlWEdWWE05ZDcvVDlJU0J0QUJtQkg4Y3IyOFdTbitXWHlHZ1ZD?=
 =?utf-8?B?T0dZNTk2MjZTaFR1Ykx3MG1Va2tESnVqeWtlcTByeEpXNStBeXJXQlJ1eGV1?=
 =?utf-8?B?NGR6aE5HVTA1ZWYzTzZ3Uk4rZDcwdXh3amJQYnNBbHVhbFpsWUxDSUk4dlpV?=
 =?utf-8?B?Ym5NNVhwYVB3UGw2QytNYzdzeTI3NTA0dnBRdmFOTWZWcXR0QVlPZ3l5Zzhr?=
 =?utf-8?B?ZUMzdVBmMHFqU0ZIREVJUnMza3UzRWNRTysyL21BYWFhR1NsTHlCWlppdXpm?=
 =?utf-8?B?RFFUZU50OGI2M2lOdUNqM1hTSW1ZcXBUNloyaTJFWDE1WG5mbEZQWVBBdURZ?=
 =?utf-8?B?eDJEMU01bWF3cEh4NUtXMDlhYzZ5MHJlN0J2WDlVSXBwc3lQYUdaMUFvaDdO?=
 =?utf-8?B?K1J1MUVWNFY3R3dqcXBKNGNGZWk5K2tqRlVGWHVsVUtBRHMwR2JTcHhqOXAr?=
 =?utf-8?B?czVHcFVLQWY5VDBRcDNuMUFwWGRpaXBjUkFoQUdXWlR0QmJ2NFNNa3JGclFy?=
 =?utf-8?B?c2QzYmFENzhJOXphc2VVMUdWU3ZKRDI4SHROaHBrY3VQcVZickdmNmJ4QUtO?=
 =?utf-8?B?RHF2OTN5cllieHFCR283QmhtWi9udjMvcUFuYzM5SGJoMmFNWG5NdlByWFl4?=
 =?utf-8?B?dmFPaUZlMGVBMWROQTY4WlNJVEY1WllqZnVueVkwUlNOMThjMm4vQkxMalI5?=
 =?utf-8?B?dzNhSS8zblVsZldrKzRXY0ZLNVhnV05GdVhLdjl0OTZxSEZnTDJzUXQxZmFV?=
 =?utf-8?Q?jEi/sl88UcJI/YOrOOJr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3hiUUVkR3V6T0FWbXhKRDNTclN4OGlJRUl6MlpPcEJCbEd3LzBUWldKL29h?=
 =?utf-8?B?YmRHcnRBYUNCNGFRTEw1YkQ2UWxBeWZDVmoySGFnOVQ0RGRWamh6REZBZWZZ?=
 =?utf-8?B?cGU3Uk1vb2xyWEp4T0Rja3k5VGtRSDhRT3N1YmZLTTZiUkFlalBvMmttNVcx?=
 =?utf-8?B?Ry84c3dFeEczbm01eXpuZTl3aUk3amo2NTBBb1dpbU12MXM4bjN1N2p4eVJ2?=
 =?utf-8?B?THFRZHc4QXcwYTNrSGxQZGppZ1pXZTc1TnhRV2E3SmxuUFFrMWd1YjFHc0Ns?=
 =?utf-8?B?WTdtY2dlOFFncjNpM0E2WVZOOEZJcjlqenNkZmM3d0pGWk9WWHh4cU1ET0ZF?=
 =?utf-8?B?ZnFXUEtMdDhuL2pTempYdmlhbXJDN1c2N2hHYkZSSEdJTEdhdldWUXZ1eDZP?=
 =?utf-8?B?ZEpwdTN1MnFzclh4V1RNNVkrQmVqdkRCbVkzS2gwbTF3SlVBSldYRGhVTXpJ?=
 =?utf-8?B?ckVYby9GR3hBZjJ2UENrR3AxVTFOZ3RHTjlDN3dMMzhXZXVxUjR5OTM2QTZJ?=
 =?utf-8?B?RmMxWjU3bWtpS2s1Z0pHcm9rdEh0c25WTVA0b25LZklWbFd6SEM2K25POFRZ?=
 =?utf-8?B?TklLMFBMTngvU0JFVzFXekZXQnBOMDQ5YUlMMmlYNklZL1BHS01pdmRvTUs0?=
 =?utf-8?B?OWlkR29OdmYrM3Z2MEpEbWswc2YwNzR0VndDL3p2c2VyZWFUTUEvRlpDeHVC?=
 =?utf-8?B?dDI2MWhPZ0Zza01IYlZCU0VIV3VwZTJqUjhFRnMrTHErdjhScWxtMkVSQTdl?=
 =?utf-8?B?OTZVc3pIb05UV3FBdTlPVEo3VnZZRDR3SGhTUWpFNjZlSzBpbjVnQm1HNVVC?=
 =?utf-8?B?bG9DZ3VVRlpUZE5Ia2J2UnpyY01JeURmTmxrOS9PZGZMZW1MdVhZNXQyb1VG?=
 =?utf-8?B?MVlYTkhZVVZqbWpLL0MvdU9KajhNejI1NHc2Vy80NGpDcXFESDhBb3VXS0Zi?=
 =?utf-8?B?MHpvT081TWVqZ0JlV2RpZXVISzZ5RTQwV2ZKZWtlRWdSTzZveUcyNjZaUjRt?=
 =?utf-8?B?OGh1VVNpVDZJR0hJeFZtUi9DUWtnNzg5ZVVaWXg5TU41L2d1ZDRYS0VTRWpN?=
 =?utf-8?B?Q2VwSGJQNFNET1A0TnNkQW84RGZqV0t3aW0vRTQxdUFKamZ4dGhlWkdFTytl?=
 =?utf-8?B?L2w2Q2IxYlVkbThlNjJyWk5wTER1cHlFS1J5NnpoZXVPRzBXMEI3QlpRWVFN?=
 =?utf-8?B?dncwd2JrRC9ESHFpUnhlUWdrb0pPNTJkYTdnVWVVSWRFRStJb1ZRbmZSMzZh?=
 =?utf-8?B?TWFiaU9OYkhUTEZ4OUxIWUswVi81Qk9BUzRGTURscllZdFNCQVcxNkZNU1ky?=
 =?utf-8?B?VnFTTHBaeWdPYjd0by9uYWs0dzNFZ1ZqTGhXcXcxNWpYdkFUYUx0QXhZN0RB?=
 =?utf-8?B?aVVMWGdqZEcvMk53SGg4K1EyM1JOeXpQRXMyeUZ4MUdtb3FEMmQ4U0NGRGVn?=
 =?utf-8?B?amYwTWxIQTBtQjlRU0g3TTZ4VnNMMmpyNjN0S2FQRGxQQ2JnUElDaUtaZFd4?=
 =?utf-8?B?Y0R0Znk1YU9QbWYyUFhvQ1BZeklvNEF1bmwxR3pqb09nR09IZytyMzRMVzNR?=
 =?utf-8?B?a0Z0aFFlRlRUYlNFeEx6d0ZuTnFndDRxeTVybW9mOFhzUjROYjdpMFRMWGhT?=
 =?utf-8?B?UDhvVTRDeUUwTm1pMUFPTzVyeUpOTmhDUnR2WFZUblRvUlU4Mm5obmY3RmIy?=
 =?utf-8?B?YlZscDg0RDhiOVBLbDFMOFh5a1FDdi9XVkZxVjJEQkdlK3J0M0ExSjQ0b3dS?=
 =?utf-8?B?akRmc2J2ZzN0V09hQ3h2VGdXOHpzbTdUazRTVCtONklER2xhRHdRZ0t6Zk9m?=
 =?utf-8?B?dDBHaGhUeDliOEpQbTBnUzkyMGRVN0M1cG8vWnUzZjh6eFcvZlBDbjNrSDdl?=
 =?utf-8?B?WE1lT2xhVHIxYmdmMVh6Zm9MRkxtSGxkNllCUDZrUHdDQ1E4WmlsRlhEMTh1?=
 =?utf-8?B?R3psSEk4aUg1U2Y5WHR2TFQ5Z1cybnBwVStrNU9FcW53UTA2QTdoMkMvdmV6?=
 =?utf-8?B?emYwUk1UWVdCQW4wL1A3OTZBZVNmYjN5ZVA3Mm9SQndzUFFRMmRuQWhUSUFD?=
 =?utf-8?B?T0hlaHE4bEk4TGhYc0dnT3ZMSGNPaFBFN1VzODYzOW1JajQzaCtXNG9yZ0o0?=
 =?utf-8?B?TUdoWXMyUU1ZRld2OGZRM2JWM3REVXFRenBLSllHMFo1MXYvMW5LaGgraml3?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc3003a-b6bd-4930-d970-08dc8c139c40
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:45:03.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHjis9ZIFBi5jhPCdR8uY8gFGxT/NV6bjZ+G6itVGYXAbRQEPzT9TI3VhMh2ndqLIikaEwlR2t6V8jdTMs8NAYQUFoCRljCltQbUoi/8DfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as the counter
> is assigned. The bandwidth events will be tracked by the hardware until
> the user changes the configuration. Each resctrl group can configure
> maximum two counters, one for total event and one for local event.
> 
> The counters are configured by writing to MSR L3_QOS_ABMC_CFG.
> Configuration is done by setting the counter id, bandwidth source (RMID),
> bandwidth types. Reading L3_QOS_ABMC_DSC returns the configuration of

What is a "bandwidth type" here?

> the counter id specified in L3_QOS_ABMC_CFG.
> 
> Attempts to read or write these MSRs when ABMC is not enabled will result
> in a #GP(0) exception.
> 
> MSR L3_QOS_ABMC_CFG (0xC000_03FDh) and L3_QOS_ABMC_DSC (0xC000_03FEh)
> details.
> ==========================================================================
> Bits 	Mnemonic	Description		Access Type   Reset Value
> ==========================================================================
> 63 	CfgEn 		Configuration Enable 	R/W 		0
> 
> 62 	CtrEn 		Counter Enable 		R/W 		0
> 
> 61:53 	– 		Reserved 		MBZ 		0
> 
> 52:48 	CtrID 		Counter Identifier	R/W		0
> 
> 47 	IsCOS		BwSrc field is a COS	R/W		0
> 			(not an RMID)
> 
> 46:44 	–		Reserved		MBZ		0
> 
> 43:32	BwSrc		Bandwidth Source	R/W		0
> 			(RMID or COS)
> 
> 31:0	BwType		Bandwidth types to	R/W		0
> 			track for this counter
> ==========================================================================
> 

This is copy&paste from AMD spec but needs some translation to map it to
resctrl.

> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v4: Added more descriptions.
>      Changed the name abmc_ctr_id to ctr_id.
>      Added L3_QOS_ABMC_DSC. Used for reading the configuration.
> 
> v3: No changes.
> 
> v2: No changes.
> ---
>   arch/x86/include/asm/msr-index.h       |  2 ++
>   arch/x86/kernel/cpu/resctrl/internal.h | 30 ++++++++++++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 5f9a0139e98c..6d2fe39ac68f 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1172,6 +1172,8 @@
>   #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>   #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>   #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
> +#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
> +#define MSR_IA32_L3_QOS_ABMC_DSC	0xc00003fe
>   
>   /* MSR_IA32_VMX_MISC bits */
>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 60a1ca0a11a7..45ed33f4f0ff 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -107,6 +107,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>   #define ASSIGN_TOTAL			BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
>   #define ASSIGN_LOCAL			BIT(QOS_L3_MBM_LOCAL_EVENT_ID)
>   
> +/* Maximum assignable counters per resctrl group */
> +#define MAX_CNTRS		2
> +
>   struct rdt_fs_context {
>   	struct kernfs_fs_context	kfc;
>   	bool				enable_cdpl2;
> @@ -211,6 +214,7 @@ enum rdtgrp_mode {
>    * @crdtgrp_list:		child rdtgroup node list
>    * @rmid:			rmid for this rdtgroup
>    * @mon_state:			Assignment state of the group
> + * @ctr_id:			ABMC counter ids assigned to this group
>    */
>   struct mongroup {
>   	struct kernfs_node	*mon_data_kn;
> @@ -218,6 +222,7 @@ struct mongroup {
>   	struct list_head	crdtgrp_list;
>   	u32			rmid;
>   	u32			mon_state;
> +	u32			ctr_id[MAX_CNTRS];

To match "num_cntrs" it seems "cntr_id" may be more appropriate?

>   };
>   
>   /**
> @@ -568,6 +573,31 @@ union cpuid_0x10_x_edx {
>   	unsigned int full;
>   };
>   
> +/*
> + * ABMC counters can be configured  by writing to L3_QOS_ABMC_CFG.

extra space

> + * @bw_type		: Bandwidth types to track for this counter

What is a "Bandwidth type"? What are possible values?

> + * @bw_src		: Bandwidth Source (RMID or CLOSID)
> + * @reserved1		: Reserved
> + * @is_cos		: BwSrc field is a COS (not an RMID)

Please be consistent wrt "CLOS"/"CLOSID" in comment and member name

> + * @ctr_id		: Counter Identifier

Please be consistent with "cntr" vs "ctr". Earlier the series
introduces "num_cntrs" so cntr seems appropriate?

> + * @reserved		: Reserved
> + * @ctr_en		: Counter Enable bit
> + * @cfg_en		: Configuration Enable bit

Why are there two enable bits? How are they used?

(please match other kernel doc wrt : usage)

> + */
> +union l3_qos_abmc_cfg {
> +	struct {
> +		unsigned long  bw_type	:32,
> +			       bw_src	:12,
> +			       reserved1: 3,
> +			       is_cos	: 1,
> +			       ctr_id	: 5,
> +			       reserved	: 9,
> +			       ctr_en	: 1,
> +			       cfg_en	: 1;
> +	} split;
> +	unsigned long full;
> +};
> +
>   void rdt_last_cmd_clear(void);
>   void rdt_last_cmd_puts(const char *s);
>   __printf(1, 2)

Reinette


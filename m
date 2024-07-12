Return-Path: <linux-kernel+bounces-251196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AE89301F5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D853281D05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CB54757;
	Fri, 12 Jul 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PONdE0i8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D99502AD;
	Fri, 12 Jul 2024 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822100; cv=fail; b=AJB0eOzTG8y0fAnMeD6ZNVj/rXOwPFsHlxYvVW3d/iVOPLjo1/ZE4FEDgbk09fEa+muiIfa4rhEftNb57aWMW9ty2J3ic9h7Jeob2052pMn43QCHC8Eho2L2QxdyWT0+QsxRA+DywkQ+bUe1XUoB4nWYTilItyPICEnzY7cW9/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822100; c=relaxed/simple;
	bh=mi+GeNqrJT4dnTc0uAAtP0YSEpKiK2wqeCOCC3FX9jA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W7/kAWhtnJTQSe4BOICQSnhohzNZVOEoqncv2TArvI17mHj2fCqg99vNbMwO+/zDiRmptfbt4yWyUlotaREMorxPvOSN65VXT+0JwVQb7+p/ovh+1BxmOTFSybcGzd04ENVM/QMGrV+HqQHEudgUYSfX9KVoE9pUSSf+M0odlNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PONdE0i8; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822099; x=1752358099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mi+GeNqrJT4dnTc0uAAtP0YSEpKiK2wqeCOCC3FX9jA=;
  b=PONdE0i8CLu1RWte0Bv2goEqJdXmYlFzJRcUy7YPlETcDu0q5mbl9Fb/
   okO1pERk7fpgZ2Fn7E6/Qz4KF1e/L7tUF8y4j2aXNI6EatQ9gde0kpGQv
   G5iPaateCyDQT2OPXiFv/rn/bvUltTbKErOZYAKQkh2br5Yyik+ckExnv
   Ro3TzjCCjVCqbbYelMjOPtFKh1+dGPQc0YxkgFuzvYP8s+5QMwYMInz9O
   ffgNfzZ8JTyovxQcUE5m1Ahwe5zS3cIhj2gieuCVis/JG/wgECpxMlQ5U
   EeAKf5pZO8vdVgN/zfykHVMB0wpv4HZehHEH4guURQdydU9NsFuq5KhZC
   g==;
X-CSE-ConnectionGUID: 7CMhu00sQTSk1INN8t/wVg==
X-CSE-MsgGUID: mNMBdotXT+y2SOyVRRk5pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="22043118"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="22043118"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:08:18 -0700
X-CSE-ConnectionGUID: HlRfxji8Tw+NaDGXz8DEPA==
X-CSE-MsgGUID: VrUKVz7NTliEAF8yvwfqIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="79736683"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:08:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:08:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:08:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:08:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:08:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+it5YNLuFpI8SlpVMEHCX8IhHJ4IpMjPxnyXXbDnkH5ZFdvxA5paTeygAFF1PMsiey+yAqyIuaAwhom/t/TGUkMbHsPzmQyY3soA9N5AvTjqykZavjPOP6tTeZl3LmmS9iZkRT8S0MwGjCIuyYdK6jpZSTINgxxpZJY7RiDGhmW+kyUNVOliB9ceLys90OJLWBSSbxGnuF8U5UKF+6V24qnfbcmJEMV7Ep3nWlzHQI9bM5KGmzZmswkib6gO6J6zls6/exPcUGX5JpoVxNmHFf7zo1ithQ1OJBgUFyCLuaoIra1mESvf8iZ/+3WwKviiuqYL1M0l58lLGUHBOxzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TlBtPVHVaYLgW4k0XwG9n/M/ND1rd4IaVUasHWqsxc=;
 b=VNwYTTFgQPOcZFZvrrcPSPtqYVwcljoZAFPbTEfgtY7FbK/pcA0OxOBXo+HpGhh/Fz674skAm9YFl0xGPb2vZx84iBsO09u/PTguiz/JkXJJUbVyQ3R1LnURNDBfvw0SIBHMwrjoHIQR6dx78gwKrYeUrnd9zq+x17abMkLYUjjcsbff3x6+NgPPQEJeAm52vNLijxm/Gyf+WPbXOaJJjj3IZOND5aezxTasYhrp1HJ13+nzW7KWSDvNsXr2wXYJreThCFBQkq3jOGzL5d+6oSNiaoKspqC9RRwRKv3vAtHxw79uCJmFUGAjdr+nHYvTP2+KEwu8Nv0UNVLeoha9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7514.namprd11.prod.outlook.com (2603:10b6:510:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:08:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:08:12 +0000
Message-ID: <6a68fabd-9a37-4183-8234-36ab8fab9b5e@intel.com>
Date: Fri, 12 Jul 2024 15:08:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/20] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <f3f03d4c3518474d3e8a591c22d965ba5b934361.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f3f03d4c3518474d3e8a591c22d965ba5b934361.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:303:6a::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ed4ac7-1a12-4e25-8d92-08dca2bf1eeb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0FEbXMrMVdSZXlWT1RlcG9IcUlKTEI4TlNITTFZM3QxaDdPZXFLZWZiSlBP?=
 =?utf-8?B?aXdpdXJhTURuSnVONUhpVTRzNzVmWkdicEE4WDNTanU5bUJ4RkNKSENGK25S?=
 =?utf-8?B?aU5JS3RlZjJzQjFlUXJ3UGlWYmNPNVl2bHU4anNPSkpoY0h1VFpqeWpzNVo1?=
 =?utf-8?B?SGlWVi80V083em1Jc1JvR1dSSUZsMk9rMEZnSm40NUxlR2tnTDZ6KytQajVS?=
 =?utf-8?B?d0lsWk03NjJCUmtyT09zejV1a2x4NkVXZHlMTjh2RVZnYTZhVittdHpjOXgz?=
 =?utf-8?B?QjJwSzJhU2VxNGdwT3NUb1VMbG5IZ1VzS3NTV1hMTUxEa0pnNzJjUnZiU1Iz?=
 =?utf-8?B?MlU2dmQrT2R2Ny9Tb2dsYU5LdnFFSUhETzV2L1B6SW9HanZSREYwR09NTU1a?=
 =?utf-8?B?aHF0UDFObE0zaS9CZDd6aStrSEN6Y2pOWW5ua015c1dCbHJURFloeit1WEg5?=
 =?utf-8?B?dm9HZHFvSk5iU0QvQ2Ewb0U5VUptbkc2Y25GQ0tzWklPV2NUS2cza2tsV01L?=
 =?utf-8?B?TWFqR0IrUDdXaXV3eEFidEVzQnYrM1YrYTV6enBmMXVKVG4zcHBUSno0NCtk?=
 =?utf-8?B?aWV5ajhlTWh3Sk1YdUUyZUlUWHpKa3Z2WDdxTVY0S2FpYXBUSkFpUlB0b1ZM?=
 =?utf-8?B?aTRFVWpSbUtDS2NNT0RHWDFBSWhob3hGZDNieldONGlrZlRnNTExZks0bGZQ?=
 =?utf-8?B?dFhYWWVlaTJ3RWtLeS92UXBTbjJlbytjRFBXRHN5VjhxNCs5dW8yRGE5RnNa?=
 =?utf-8?B?TFVvZlcvR29YV0ZiNXl6U0hSWTBwbWNtV1I3VmNORzdtS281N2lQZWFlSE9U?=
 =?utf-8?B?QjA3Q0Fhd09aMXlkSWNTVWhmRXVhczVMTThmdlgrc0JacHVSSEVBTnNvMlY1?=
 =?utf-8?B?dngvc1AxTWxQME1CaWxSQld5VmQyVU1yZWtGVkhTSFczSGJ5dEJIeG1UUmhN?=
 =?utf-8?B?ZFYrZmNZNERRVVlVeExEOEVNUEVRRjRCcUd0amRPUVYxVU1zdldkbFM2azdD?=
 =?utf-8?B?NGVyR293VTdyWlBSRVc0a2l5bjBPY041ZVVXS0RPYzgzRklzVGVpK09LbVhK?=
 =?utf-8?B?ZVFnS2ZhRzhPbUlmRENxYVB6V0hYdVNScnJZMDhpNDRMVmxtWHZsanpsbjRK?=
 =?utf-8?B?aG9hTWh5azZVLzdsMmhSbzJaQjQ4MEk1ZXExVWZsdTRjelRNejk1NExyRi9r?=
 =?utf-8?B?NW1tRTNDT2U2NDlqVkdwZ1dOWXdueHZKS2xvRG4zblJNSnY2Yk9GL25INlgw?=
 =?utf-8?B?ZVNMRjBVSmZ4RHFTUkVNN1BKcDd5bEs3dXM3SnJnYWRLYlVyTHMyWFM1RXpI?=
 =?utf-8?B?NW95Tm9UeklJbkZ5bTVCdGZOd1J1QzkyZ0NJeVlIV3dSYkkvT1BRQWR5Q21E?=
 =?utf-8?B?Z0hvaFY1c1Mvc2hsTDdUeWtQbEdIU0pFK29Udk4zZW9EeGYvUG43T0lmQ3Ri?=
 =?utf-8?B?MkUrQVI3VTZ0NS94cXJ6MnFyU0gyOXJGSWowWVRtNXZFMTFZenJpOWJWOGgv?=
 =?utf-8?B?ZWsvdkV1M08zQUdsRlBlWHdvTG82c25uQzhhMkFLTGlYTXZyMUJWa1dsenZX?=
 =?utf-8?B?VTlxblhHUzI4YnBtNTNkdXA1d3J3aUs4b29NR3JZZWlDaTB4UEVzaW5pUFk2?=
 =?utf-8?B?djQwVmRkVTM2YkhJZytlR0RNekZtd2ZDWUZSNUh3dXlPNjdpSHRFdnlwWFl6?=
 =?utf-8?B?dE9mYnI4cmJQdW5LUnNidjVaSTlVdndJZTByWlBWdlFiUGF1cy80am92Q0JC?=
 =?utf-8?B?cy9CcVJyclVKUThDQUswL3krOEh1V1RrcWtyaGxNOEh5WUgvZ1V2a0lPZDRa?=
 =?utf-8?B?NlZJRXBSQUFBS3N5T0NwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdNUFRoekJyVlllUXFJbVM3anBHYjZrL3cwREwrSzZEWVdKVk5vMGQrVmdZ?=
 =?utf-8?B?aGNvTXdmeUd3UjFkYVR4L2dZdFFpOFVKTzVEZ1RPdUkraE9wSnU0N0lCa0E0?=
 =?utf-8?B?QXhTZGk0MDdLcGRNTnIvK2ZVRU44MzFTZkEzNlJOUGxFNzhsVWdhRDAxZ0dS?=
 =?utf-8?B?aVB0TjdlU2RXZmIwSXdmdmlXVTgwdjMxZldhUm1XWEFLdG5hMmxBOW9tKzI1?=
 =?utf-8?B?ZDBRRnRKUkVlaGtsNStkOWxMeVhlb3d5VE5OZGtVYmRVQjRpRWtxVmZjM1hl?=
 =?utf-8?B?ekkraHd0c2VsSkhvazZZUVZNUWdiQ2lOTTBvYi84cDl3Q2dtak9zRWVkWWFw?=
 =?utf-8?B?MHdja01SeWFtVTBlRFptTStnbW1hYm9PUC82ZTd3UHMwck1wSW9oYldKeVFX?=
 =?utf-8?B?ZjNvYUc0V1dyVm1lNkxoM2dGWURWZHNiNW13amExcGR5U1gwN0ZobGtYZzZE?=
 =?utf-8?B?TzhuamtiQ0xuT2Jsd045VW9mOCtXZTFXSTJMV1pQZnhlM1AzODN1bkVrT1NG?=
 =?utf-8?B?TW9xS01lalR6d0Z0ZXFJYTRFMlVIK3NpLzEzKzUwMDM1QmRDNGtYZHRDLzVJ?=
 =?utf-8?B?elM3RmxMeGFWcWViY3o5SzFMVEZyTGZpbVIwMi9HUjVHUUVtZTN0c3Fad2ox?=
 =?utf-8?B?VVZJVjVaOU92VTgxNlBTMGNoeHRUUEwxOVdMejJkV0kySFg2akpqVUxMOFBR?=
 =?utf-8?B?QjBuQlBNaWFqdmpMdTNCREhqZUFLK1VzWmUrMGlJTmR5Rmt1OW53SkN4UmhE?=
 =?utf-8?B?TGRmSzBzSDEwY3VZQUpjZFlZaTJkVjFmV21pYlhubmJHQkR5RlEybzA3UjAv?=
 =?utf-8?B?clFHNmhGUnlaTXRxdUhONHdGNmdBWko2bEdYODdlZ3VxZzBuT3RBSUxmQTBV?=
 =?utf-8?B?Q241N1RERFF3T1hFM2JSUkxkaHVpYm9DTlBBNkxSUkVsc1NpSk4yZWVVZEMr?=
 =?utf-8?B?aVlmRGlrQ2grbVFMUmJsVkQrSDlIMy9RcmZIa21pckdZMFNhc2FWM2d5SnJ4?=
 =?utf-8?B?TDI2Y1NDb3NTQUZUaDBPT0gvSHR0S05MVUlLZzZWR2YwTlZVM21zZDhTd2JW?=
 =?utf-8?B?bm5rbXNvb215L05tZTlTbEdWUzU3N2FRWm9tVkl2SXl2S2ZZZCtOQlN6b2Nu?=
 =?utf-8?B?T0dTdVJETm5tQWNNUWhRdEU1YWlmbzQ4WmgvSnkyWUcrUC9Ccm5DMlVqd1Nj?=
 =?utf-8?B?UEk4d0FEdmpVNjdRL1cza1pLZ3BuMEF4MmdIblljMjB5bmZWY3NZaE01WjFa?=
 =?utf-8?B?N3NqQ3NNMEJ1djRXdWNBSnNBTE5XZ3M3SXdIV2twV2VrRUloQWtIUlRuaE9z?=
 =?utf-8?B?Z2pMS21GNzk3N3k0VjV3OHYrajdPSFA2ZGZOMjlDaUpTcmp2UFphS0hvenI1?=
 =?utf-8?B?aW5hTnVIaTNabjNZT3ozVEVXajBzK0xiYlBlVlNXdndCOFRmRTUyTlpweFY4?=
 =?utf-8?B?bTZUTHJPM1UySmJzcDdCckZqVU9ubEMrOEhONGFsOEIvYmJYZmoxc2R2QXdK?=
 =?utf-8?B?TkhMcDhqUnRVWGZJbmJkR0FFVVp2ajZ0dFRZSDlzaGI4ZFRFZ05QbWM5UU1I?=
 =?utf-8?B?M0xabFllT3F4dE9rTWdLbEJyNGl1UmZNc3FjYzV1THk2a2lMWC9jbFB3bjFv?=
 =?utf-8?B?a1ZuamFTUitVMUpxcldZQS9aUWNkRXFkNGVjREREV3R4S1pyais5ekNsdDVL?=
 =?utf-8?B?Ujc5Z3RXSXBIVzZoM21nbTliUVlRa0M1UW02VU9kVmtHb2Vjek8rUjJjdS9Z?=
 =?utf-8?B?WEZHOUhOVmlqQjkyNXhLenVMQStzZGNZZFBtbGZ6Q1cvb0tiUUZwQ0VmckU3?=
 =?utf-8?B?d0lLWjBscVpQVmREcTJnZWVoQWtLU3JQYnpIbmlhZjljcmUwTlYwaEJOSWND?=
 =?utf-8?B?UEl4SDd4ZG1zK3Vxb2JNYmVRSXoyUkJYZlk3R2tzcVNLdW5iVEVkeW9DdjFQ?=
 =?utf-8?B?d0NIYXEwcXdiV1NSVzltK2hiRFNXNkN3a3lmaVVmdjd3MGptU2VuT2dMM2cy?=
 =?utf-8?B?c08vZWxUY2xQdmphZ0F3N0RldWMySzBLdnV2ZFErMENlVFBVSnBDWG16RXhz?=
 =?utf-8?B?bUlzTjdzL0VwZFdmdFJQT2d3aExzZnRLVkpFT2doanpyak9veVZ2NVJMdnFB?=
 =?utf-8?B?UkZzSDlhbXZNbmNDV25KV1FqZzdpVE1EdmtLcXVkMGY1SWs2aFYrbkxpMXdT?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ed4ac7-1a12-4e25-8d92-08dca2bf1eeb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:08:12.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MKmmrj3PIkh7WoKOUDV09t9UOXhJ+kZr4LscMBnKCj0Y9oDjgi3s2nQUxvNHqWODPmOsueEmT7czqapqr9hEEGbY+Vj0JPZXjDu476S+5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7514
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
> supported, the bandwidth events can be configured to track specific
> events. The event configuration is domain specific. ABMC (Assignable
> Bandwidth Monitoring Counters) feature needs event configuration
> information to assign hardware counter to an RMID. Event configurations
> are not stored in resctrl but instead always read from or written to
> hardware directly when prompted by user space.
> 
> Read the event configuration from the hardware during the domain
> initialization. Save the configuration information in the rdt_hw_domain,

rdt_hw_domain -> rdt_hw_mon_domain

> so it can be used for counter assignment.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5: Exported mon_event_config_index_get.
>      Renamed arch_domain_mbm_evt_config to resctrl_arch_mbm_evt_config.
> 
> v4: Read the configuration information from the hardware to initialize.
>      Added few commit messages.
>      Fixed the tab spaces.
> 
> v3: Minor changes related to rebase in mbm_config_write_domain.
> 
> v2: No changes.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>   arch/x86/kernel/cpu/resctrl/internal.h |  6 ++++++
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 22 ++++++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>   4 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index ff5cb693b396..6265ef8b610f 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -619,6 +619,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>   
>   	arch_mon_domain_online(r, d);
>   
> +	resctrl_arch_mbm_evt_config(hw_dom);
> +

This does not look to be an arch call called by the fs code so special
naming does not seem to be required? If it _was_ an arch callback then
it cannot take a HW resource as parameter since the fs code does not have
access to that.


>   	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>   		mon_domain_free(hw_dom);
>   		return;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 0ce9797f80fe..4cb1a5d014a3 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -401,6 +401,8 @@ struct rdt_hw_ctrl_domain {
>    * @d_resctrl:	Properties exposed to the resctrl file system
>    * @arch_mbm_total:	arch private state for MBM total bandwidth
>    * @arch_mbm_local:	arch private state for MBM local bandwidth
> + * @mbm_total_cfg:	MBM total bandwidth configuration
> + * @mbm_local_cfg:	MBM local bandwidth configuration
>    *
>    * Members of this structure are accessed via helpers that provide abstraction.
>    */
> @@ -408,6 +410,8 @@ struct rdt_hw_mon_domain {
>   	struct rdt_mon_domain		d_resctrl;
>   	struct arch_mbm_state		*arch_mbm_total;
>   	struct arch_mbm_state		*arch_mbm_local;
> +	u32				mbm_total_cfg;
> +	u32				mbm_local_cfg;
>   };
>   
>   static inline struct rdt_hw_ctrl_domain *resctrl_to_arch_ctrl_dom(struct rdt_ctrl_domain *r)
> @@ -662,6 +666,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free);
>   void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init resctrl_file_fflags_init(const char *config,
>   				     unsigned long fflags);
> +void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
> +unsigned int mon_event_config_index_get(u32 evtid);
>   void rdt_staged_configs_clear(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 7a93a6d2b2de..b96b0a8bd7d3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1256,6 +1256,28 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   	return 0;
>   }
>   
> +void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom)

A function is expected to have a verb in its name and the verb here seems to be
"config", which does not seem appropriate and creates confusion with
resctrl_arch_event_config_set(). How about resctrl_arch_mbm_evt_config_init()
with proper initializer of the config values to also cover case when events are
not configurable (INVALID_CONFIG_VALUE introduced in next patch?) ?

> +{
> +	unsigned int index;
> +	u64 msrval;
> +
> +	/*
> +	 * Read the configuration registers QOS_EVT_CFG_n, where <n> is
> +	 * the BMEC event number (EvtID).
> +	 */
> +	if (mbm_total_event.configurable) {
> +		index = mon_event_config_index_get(QOS_L3_MBM_TOTAL_EVENT_ID);
> +		rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
> +		hw_dom->mbm_total_cfg = msrval & MAX_EVT_CONFIG_BITS;
> +	}
> +
> +	if (mbm_local_event.configurable) {
> +		index = mon_event_config_index_get(QOS_L3_MBM_LOCAL_EVENT_ID);
> +		rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
> +		hw_dom->mbm_local_cfg = msrval & MAX_EVT_CONFIG_BITS;
> +	}
> +}
> +
>   void __exit rdt_put_mon_l3_config(void)
>   {
>   	dom_data_exit();
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b3d3fa048f15..b2b751741dd8 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1606,7 +1606,7 @@ struct mon_config_info {
>    *         1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
>    *         INVALID_CONFIG_INDEX for invalid evtid
>    */
> -static inline unsigned int mon_event_config_index_get(u32 evtid)
> +unsigned int mon_event_config_index_get(u32 evtid)
>   {
>   	switch (evtid) {
>   	case QOS_L3_MBM_TOTAL_EVENT_ID:

Reinette


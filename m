Return-Path: <linux-kernel+bounces-290353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4450395529D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9CE284353
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4297D4315D;
	Fri, 16 Aug 2024 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcXj7rui"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E01420D0;
	Fri, 16 Aug 2024 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844532; cv=fail; b=L4/Hy+c283knEMRpqZcBHIM/RGPJVjknEXXIEace43ADIGtug2JhWyHW65Q9zm9TijznKRzS4wOTy52DZ5E652l3ZEKnlYHAh40kW3pBxZpKw7TfDs5PgFyhNy0/J4jWvQ0ju7mmZf3N/HO15BaRNO6dwyzAaVQjcpyPWL25AOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844532; c=relaxed/simple;
	bh=iMEPZ5Y9g8P9GMGYlIsjAQmOWdwgvpLtgjDTd+rTWGE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HSql5TCuRLdry2KqlXMhSo+vFls+Pdx9JbQaTHkk84tM4afU8yr40poZVTAM65T8z2uqwq4oxMfXvtcXIZ2Khqsg+g12QN2B3E511MaDPWPMYq7fmFYJRMDmnuESrATRg4SVXMrEDqGjISm4grADw116ri394MfgbPf7VyVS39E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcXj7rui; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844531; x=1755380531;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iMEPZ5Y9g8P9GMGYlIsjAQmOWdwgvpLtgjDTd+rTWGE=;
  b=LcXj7rui++E1CBSKB+fGlBoSmQnVqSh7iotgvVJYRao/XiwdO+SaM8Gk
   XGcNZFv7HO+nzH5RJwXqXs14hmkWpB+KeLzoxPPHK6YT+j//nqzO+2xod
   6PxIXACAUaFDnSzZLIFdenSpInq3w1+AD1ZRgz2eY/0VackIzl5g1hI2Z
   n6+15A6Oj6Ic1IFyEQc0FzgHzZbnxpUfc/B0T09fuETnBpYOmKinWxxqE
   287UyQDlATwu8q5wNfUzJgQYyCgVWgDbYA78oAU8+yb70qX1bCMtdzudg
   bUnegdIJfrv0xIiKNrzwjjyZoLO7lCv+OyWRYu68H0KgPxra/GiCQDllO
   A==;
X-CSE-ConnectionGUID: uXd4RB8HQpalBl9CXgUSVA==
X-CSE-MsgGUID: 6y9fSKQ+TVSy1BUngXGTrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22325580"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="22325580"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:42:09 -0700
X-CSE-ConnectionGUID: t0nky8GiRVOHoLKhk0XvCA==
X-CSE-MsgGUID: iPl5ujR5TsqZAyUwZaN3KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="60066779"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:42:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:42:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:42:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:42:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPT8esctPmDbJ9z1tIGeQBdnti1lSYDYwvxeQLDSNYUoal+VS/keISdauMga14CPL2XG1V6y/fe98GTDkErAFPzMKEH7KlPZkyqX8O47C7L3alcT+SoY5Qh3AH3HX/PExQlxYSMMn0tnUk/Ubd7HGCJd36X+1npkCfDMcOWJ3NlBHbO9dQgLVUi4uEvTJyDzaRI1NNVQxKRyTiQhN+pQIUhJRnF7lBjSjeUBhM1y1pZBWDiSpS3p6Lg9EnZwYistZiIGN0xTUePz4ONDEiguWTNlYxyneNoi4TP9zi54QctBreJaNO/w0qlnzZhuJBTQFhOKhw1+3EQWSISwx4AoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEfUSRrqpnAkYaUX8MUIGs19T5TsIVJOcE8UncZGeH4=;
 b=HFOVRcpfano/8jrYLhX8wD8n9oJuZ0LYzbtCVgL6A1+PsS+EyPiKPUeHvhWTU0TTOhTKkE87CUvOXxSbRkVJXNWFKCPqpTeF0C3EaAmUuriMf84qXsHSKpjYCFjhtPPNUgY8kaKIIGTpeZ/bQI+g1upQCp732LFR7Q8aeQBiA7ZbrJW16mE86Q/q9HjXZiSnjiTopPi5mn4V40xBpJS2krg83YkclLmYEWlIGbm71RUYzlAnCpI77aWVeYBdQ3h42kL6uZuhg49VQxRIARB1rfa0/VNfgkWiKuzvqvFdkgq0NySstcoAaOVw3dktb+LQLgyHD7AZTfEdTzgC7iGPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 21:42:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:42:04 +0000
Message-ID: <6d2dd646-49c0-4d7a-90da-10919f617e77@intel.com>
Date: Fri, 16 Aug 2024 14:42:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/22] x86/resctrl: Assign/unassign counters by default
 when ABMC is enabled
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <48e7516ccc04715d4fd6678cf00a99ccf43fba10.1722981659.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <48e7516ccc04715d4fd6678cf00a99ccf43fba10.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 27190487-9f36-4796-41d0-08dcbe3c44c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGlzUG1JM2w1cEU2aWxLak5nOStwdFRnZjVNYmNLcjBNdEZtZzZXNThmS3c3?=
 =?utf-8?B?S0d6UUwwWE5KNTJPYitiVVlDTUJFRDFEMmRWYksxTnJ3UkdvTnAyOHNBMjlt?=
 =?utf-8?B?UzRtOEMrcXZaMUtwbnFPNWNIWkJLd0hZN0hGeWJOKzBGVnh1VEhYN043ekUw?=
 =?utf-8?B?dkR3M3hVL0FPWHdzUUY2UmlyQ1pEdXM4dWRsWERTYkVleGRoL3RvT1NpZjFU?=
 =?utf-8?B?WWJKRnFQQUpFaXQrZW5mQjN3bWR1WGV1YXY1elVZRU1IK1RtYmxjZW8rYkpP?=
 =?utf-8?B?ZXpCMW5WQWVQOGRFSDBFNkQ2OThCejVESVcvU295N1hEaGxCRmZyeXdwV25R?=
 =?utf-8?B?UzdtSUUxRG1YVXQzM2cwQWdabGRCQ0RQNTU3aDVzT1pKaHUzMkdQR1dWWVhL?=
 =?utf-8?B?SjRYOVkyNWxUTWYrbEQwd0dqbUtlZHdsREpVWk1YU1hjTmlMTmowNFlSWG1h?=
 =?utf-8?B?c0RhVnpTMm9pV0FXZUFTNndRYTJGaWZtMFl4NmpBZVNrWWNITGpmenJHellR?=
 =?utf-8?B?bU9ZYlhoTnNKT2gzYnVxM3R4THVNMFg3UDBsMUx5MjZOelllT1BmNWJDRUdy?=
 =?utf-8?B?Vk4zVS94Y0lvYzhDaXBTTUp5Tk9FZnd6YjZVWHBPcEc0OXRrTXR2eDVRMGY4?=
 =?utf-8?B?T2dUb3NrWndjcmZ2SFRWZUxVdVBHc3FsVS9TVkhmK2pRZHd3bTFlSkJMcWEy?=
 =?utf-8?B?ZnlhQ1lpUnlhbktnaitGZlp1TDZwR3hDaXZTQUpuS3cyOEZLRi9oeVMzSzRX?=
 =?utf-8?B?d25mcTU4cU9xWlhsNGlmOXFPNXlWUHcrb29FcElyY0VYQ0NQb2l0U29wakJ1?=
 =?utf-8?B?OUM5ZkRPZTVSOHdTd1FBVUd3MHFrYTd0N3pFcDVIemRBT01HZDh0Q2RmY1hO?=
 =?utf-8?B?WGVFdGFQN1JEU0Fuam5SL0tLcHYydUFlN1hMTFFITXA4V0h6U3RsWXJzdnp0?=
 =?utf-8?B?VVRvQTB1RkVSa2RKeXBVMGRlY1h0ZG9WVElvZjdTbzJNdEVwbk4rK09kQUdO?=
 =?utf-8?B?VUdVTWZTNE5CMElwRmtEMk80R1dwdzJFN1R6Vit4UnUrcUdmclNvNnVUemRT?=
 =?utf-8?B?elRnY1RzSmFKbUZ0dWlzdk1jQXVEajB1aDNhaHhZRGpFNzY2UEFtblU2UXdi?=
 =?utf-8?B?NGlzSUZEZEx1TWFaVHRsWkZRbmJVYit0cGNiY0VSS1hrOFRKU2c5TklaMWxQ?=
 =?utf-8?B?cHZTOW9aTmUrRURQZUxSZjhjeVhPUDkxb0hFQTB5V1B2RjNqamdHeFhicTVk?=
 =?utf-8?B?Ly9kdVZ6cUNDVUFSSE0vQStRc3pWNllGM0hOelNZamYydE9Oc2NYQTdDaVA3?=
 =?utf-8?B?dXRxWno3R29kMGRwNm5aY2lhQUxXYVZwS3BnR21IblYzY1RNOHFTYlF4R1hB?=
 =?utf-8?B?MS8rcGh0RnVzM0RZcW1mVE1uc2Z3eVRLUkxxbjRrcmVlYW9RT3pGRlhiNWhN?=
 =?utf-8?B?THY0NFJFbE5lRE9EeU1idW1kYkpuMHE0TE5zUExicnJvSk9jUGQzY0tCMzIy?=
 =?utf-8?B?aStqOTRKTVVRWWQyL3ZYWGJPMGdCYlg2NGhwanBWU2ZOUlc4UnlRLzhqRmR1?=
 =?utf-8?B?Y1krbGNMdGx2NTcrYkUxdXJueWtnUWZDTmt6azVSQnJBKzgwV2ttamZ6V2dL?=
 =?utf-8?B?VWNCSVJGTk9FQkIxZFZ6S005cWRXZWdrRDVncGtGU016N0kyYUFjT1FWaEpD?=
 =?utf-8?B?cTFTMm9JSTdxTXBNZHhwWlgwZ0NTS3J2NTYwQ0pmNzJzbDltNndRTTI2Y2hY?=
 =?utf-8?B?b3E2ZUx3TnpLU0VOSVl0YWU5d3RydlBLUUNxQzFPME5Va2c4U1F5bWdYV2FC?=
 =?utf-8?B?N0h5NkFib2lHK3R1STFLQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlkMmpaaHVzL3p4dE05Kzl4Q0VCc2xYSjloUEswZGR0YVBJQzVFS0czSlJn?=
 =?utf-8?B?T1hMNVBPcThSRlVtV0w3cXl4dDR6a0tzY05TVGovdnBnMDJUOE1tV2xqQkFi?=
 =?utf-8?B?OUs1aHI5K3l2UXc5aVhIWXVzTUtxQ244ODZtRHFDSzhHQXEvSXl6ZnNOaFdP?=
 =?utf-8?B?Q0JiYytHRU0vdWE1UUs2amtUbVhmVGhjcUJFMWhkdmRwSWN5clp3c21pbW5s?=
 =?utf-8?B?dWxYWlhwV24xYUFGeFhzUWh5UzJ1QTI1Tno4STBUK3k4UDc5OXBCR2ZFY2x3?=
 =?utf-8?B?bVhPVE10OGZQTWFBaklhU2huVlJOSnhSY2hUSUJlTFFRRnEremlGdGIyd0hD?=
 =?utf-8?B?VjQ3VlcwOXhiYTlZQ3pnQnhzNG1Za0VYWEc3K0c3VGdHcUExK2tsaFlzMjZ4?=
 =?utf-8?B?UmQ2bXdoVlphTDVQZFpOSjgvaWgvTXRiUUJBZTBqdTRhbnBaTlZEVU43NVYx?=
 =?utf-8?B?aUp0b1RNQ0lqQUFHR08xTnRVWEU0M3JVQTlQRkRUVExCTEZYMk5yS0xhWkJl?=
 =?utf-8?B?TElYUTVURHhCNjJBUitDemtiOW9qUWU4Y0IwQmtMb3ZvcFdUcGdSUnI4RndV?=
 =?utf-8?B?VUJrRE91YWM3ZnY3RTQ1d0x4SlM4djZPcFVhUHVOT0hHMUh3WHl0ZHF1SDcy?=
 =?utf-8?B?UmwxamMzZWJNS29oQlM5L09BYTByOGdiNWtpc0s3NmpkNklMNkN6YnRTUUZ2?=
 =?utf-8?B?MFJWZ2lPQVMwcDFQZUI0M3dUd21XaGFnWDlTWE9yNXRuS1Q0clN3TXhGSGtO?=
 =?utf-8?B?T2dhVnRWdHBud25UczBZOG5TVWFLQUZnZjdpRFBKak5oWHF1TnRUazNJTnZL?=
 =?utf-8?B?T0VnZkQxTVhmWlU1VUlCOEZqQ0FsbHA2OXhLWThzclR2NXpEMnFPZlRSQmZR?=
 =?utf-8?B?ZGt4cWJwbG9kRWRTU2lJYmRGODNGZnE1K1hScEZPOERjeFRsbUk5bDU1cVNW?=
 =?utf-8?B?Zm9FT1hzNkNqTkc2aDhTdFYyMUtXVkIxSDVPZVRyUWlkU2xHYUg2ampOcFNk?=
 =?utf-8?B?RDd6cXI1VkwzNVcvdElMRDRtMHRGZjhQZjN2alhGZEJXQlpPMWtFK1FFa1lu?=
 =?utf-8?B?VFhLMXhMc1FJK0hjenpVeElpeUl6SjcxVDVzVDBhL0wzY3AzTVlRSWJuRTBH?=
 =?utf-8?B?ckN1c1dCSGlVb1EwaWRVNDMyYU1pYkJsd21HRW50VUhRZ1gzVWZXdThZcGRR?=
 =?utf-8?B?c28wWUNqK2JTY1lnUXAydWh3MnZZYXVCQzFLRFg0TXF5bUZDNGRPRFBDZ0Mv?=
 =?utf-8?B?bkxvdkwxMUFvQlhpeUhoWVZodi9Ta0EwdnRkc3M2WkZwVkEwMWdmZnJjbldw?=
 =?utf-8?B?UG5USnhadXk4aVdualZyVk5CMy9qblVHeXdSVVQxZUtuTFVVcGlpcFFsaU12?=
 =?utf-8?B?VG9kYnMvZ1BRTmRsU2Rqem56VXBjQm9oOG1BOVk1citZQ2hMU3RtWCtUcG96?=
 =?utf-8?B?Mi9pczFpM0hxVHEwTi96bEw5K3p6eWZ1Sm1zcG13Tkw5eHVrQ0hvKzlyajY3?=
 =?utf-8?B?STlOSFJSdlQ1NjRtZWYzaE5JRkVaUG1MSnpPVUp3QmpaZkZkQk1lVnZnRU9O?=
 =?utf-8?B?enRUSG5sb0IyUlVkeEZmRVhNaGJ0UGxKYXNKVzB2OWRyYW90MGRBSmpVNnRP?=
 =?utf-8?B?a0M0OEJCUzJ5WmFrcmlGaFFmU3VBOHlvS0lXMVVXczU3bVBQd01hSjIyWHhN?=
 =?utf-8?B?Yk5uUkZ0NFJQc0w0bVVBbTRzTm1qRm02WTZDdFNPMkh3OFI0VVhsYUpRZFk1?=
 =?utf-8?B?NGZwbkUwNjcrTHRwd0xMMDdhMUxsYU9WSDhRRDI0b1hPdSsxZzRiL3ZjajVs?=
 =?utf-8?B?SUljOVorU3E1amF5OTJ5SmZPNUZ5R1RSSHNyVXFMZnJGdXlyMUhNaUN6N0ds?=
 =?utf-8?B?YmRTWVQvcGoxVS9zbHJJbnBuS01NN0hHTitkWEg1amxiSmswY0pYLzF4c1dL?=
 =?utf-8?B?ZkM4VXlUY2FUc0t6N2RjSnRlb09iOVEyd0RMNkJ2ajJQa2RUMlliTzB4R1Na?=
 =?utf-8?B?eUNMVFlBOWRQMEJraEkwb3hNQzN3TjQ4Q3pjRE1mQ2VEbktPeHorOFY3R0JP?=
 =?utf-8?B?OE1qNENRdTNRZ0xWQy9QUnlOWnZ5ell0aUJBSzhDQXAxUW1vd1htYlNGcXF0?=
 =?utf-8?B?bW44bTQrd1lIaFFhV0Vjd1V5Yit0OURWTnFBNTk4QmFLMFZrdW9lOTA4STRO?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27190487-9f36-4796-41d0-08dcbe3c44c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:42:04.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PKk89VdgL1QAfR+rQFfPlcKqN5BdsFOFbhdTe92ZuzhaHagA3ZQq/fHS9SvQVcKy0elv3AExxw8c+f4PhboskYyQrFTPHtvbfBPjOeiHWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> Assign/unassign counters on resctrl group creation/deletion. Two counters
> are required per group, one for total event and one for local event.
> 
> There are only limited number of counters for assignment. If the counters
> are exhausted, report the warnings and continue. It is not required to

Regarding "report the warnings and continue", which warnings are you referring to?

> fail group creation for assignment failures. Users have the option to
> modify the assignments later.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Removed the redundant comments on all the calls of
>      rdtgroup_assign_cntrs. Updated the commit message.
>      Dropped printing error message on every call of rdtgroup_assign_cntrs.
> 
> v5: Removed the code to enable/disable ABMC during the mount.
>      That will be another patch.
>      Added arch callers to get the arch specific data.
>      Renamed fuctions to match the other abmc function.
>      Added code comments for assignment failures.
> 
> v4: Few name changes based on the upstream discussion.
>      Commit message update.
> 
> v3: This is a new patch. Patch addresses the upstream comment to enable
>      ABMC feature by default if the feature is available.
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 ++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0c2215dbd497..d93c1d784b91 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2908,6 +2908,46 @@ static void schemata_list_destroy(void)
>   	}
>   }
>   
> +/*
> + * Called when new group is created. Assign the counters if ABMC is

Please replace ABMC with resctrl fs generic terms.

> + * already enabled. Two counters are required per group, one for total
> + * event and one for local event. With limited number of counters,
> + * the assignments can fail in some cases. But, it is not required to
> + * fail the group creation. Users have the option to modify the
> + * assignments after the group creation.
> + */
> +static int rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	int ret = 0;
> +
> +	if (!resctrl_arch_get_abmc_enabled())
> +		return 0;
> +
> +	if (is_mbm_total_enabled())
> +		ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (!ret && is_mbm_local_enabled())
> +		ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	return ret;
> +}
> +

Reinette


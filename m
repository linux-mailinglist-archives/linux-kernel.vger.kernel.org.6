Return-Path: <linux-kernel+bounces-290355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A64E9552A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E0DB22C34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BBC1C578F;
	Fri, 16 Aug 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+gcU95V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4B1420D0;
	Fri, 16 Aug 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844599; cv=fail; b=lWUdF/uBh4D3oqpGjewkRJiJ3wVH/52uM3chmLM9n4pshseWgNCR/duewEMtLC/ad9V/VCy70+8KrLqyYD8ow/y0Yw6XyD9/lsFsdanC5LNlmGrwxx50JX+zIq2X7tMsruH4EDbfjPVjbqG/wDZpMUcVqgxzQb2pAepgh5KkpLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844599; c=relaxed/simple;
	bh=s2GV2Txss2mHE5Nu4/cUDUxnvzAlfgagARab8dndyPI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gn2Z0ZRtviCMtgC6RlwLkzJ7eTCq9mD8rKctbauIDe0U3/DxQNl21kzrW3T+Dp802uIvtdyV8VUPH3S2Wb/Hkxe6McKL7EbCIMYg+awi5aw+FfmWb0MKxboNVY2mHTZL33sJrkvvS2adO8ZmrBhlpZWiT0VsrS3tKIfiX86MBXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+gcU95V; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844598; x=1755380598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s2GV2Txss2mHE5Nu4/cUDUxnvzAlfgagARab8dndyPI=;
  b=n+gcU95V+J4l8TY0R75ydIb2zbeNyUPF03KXT5dVz4ebYflb4GrHLBrU
   FbcHKUIizrd0usr4j1wxEDJn4xIddgcwf6oL5K2DictBhU/lZSyBQ71im
   L6B16KhXKwNoZHBA+nCnSCP64WEk8az/I7ukjoKn8Mb2kUgJPRzrxZ9yV
   Mv+jCDafwBX/xy3uGy3r4E6OObS6n948fxfYlAZx7aTm/659EfOCYsg3I
   wior8cqcre2ZNUdf/59SFQxa+rxKncQN08z4ulgCmuRKve5PCZy0ysdHW
   htS2Tb1sjb3BdnvT/ZOXeHcn6lxTaUCq1XJn2BEdOXdMeaQDYixClCRo+
   g==;
X-CSE-ConnectionGUID: Jb17auwBShy3rmAbRA/M/g==
X-CSE-MsgGUID: eohBWeemRFOX0GWNpoQk2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="13061950"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="13061950"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:43:17 -0700
X-CSE-ConnectionGUID: ypKGsnuSQdeYp1d5po8RBQ==
X-CSE-MsgGUID: jfPQyoJFS4ibTvQXq2TGWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="59483983"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:43:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:43:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:43:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:43:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/3bsMqIPatvSfNgUXFW5mAXM3ccSI8hWRxKzKBxPH34EWwTdDu/0S6/zDdlyMfMDdgA4Gn0H3iaKnLFAK5JwTNaDLLjoILeME1GeygLtClqY565oYqVyQSM/AM1WDDZQbe2FD82ffWBFPdyrAOPQy4lNcJKZ3+dbUP2SkkeEsvYNFtCcLQ8GyS8Pk/evKe4Qpa88zuJSrqbX9mjodgxC93TZHUaqYBcelrHxs6J/xWojOhC9tprAg5SxGHrRqk2yBkIybBzL1zaMQhVch8xCYyKzdNhhV7PbFaqfmHZ5HhttdU2XOIbhueB1N14oSb4BgrURO1nWlUCuRt6mDJ+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a85Ox+no4sAnD9YDcRSSB6XkmC5Pe53aklRx370SHSs=;
 b=RMpDXAp9PbX0NpAyAvmig1Ne4+Yg3pF9hcSszWj0mcUX5/XUpb3tWt/ZgIBKxCnrvBbZYcGv0QEXiJnLugPpFK7LfrKUuyDglpS6W7J0QXXbje9T2AsP6ujzRPcHS5WtR3jRBLdp+s9asnI5mEGnqHQdn/s8uWyv7L6bGsPyQU8MasEnsQaTxPsnPQr0Je50du4TWnw+adJsgaC+VWOgIVPe5eGoMjjcoFrB4DO+0pgHf3cAk9LHB66lxtQ9ZCx+bf8pn6BqVhRSUyK9UV0+iJw8QzoLt2UnlV7zaG7ZSB4R05xjpdcZcnIK+7SjNbuiGQkL2cD0qkE7y67wLQx7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 21:43:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:43:14 +0000
Message-ID: <ef586a11-5d8f-434f-962c-6893ae4668de@intel.com>
Date: Fri, 16 Aug 2024 14:42:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/22] x86/resctrl: Introduce the interface to switch
 between monitor modes
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
 <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a47650-2d35-4134-6241-08dcbe3c6e93
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDc5ZDd5YVZ5SHVEY0N3UTBUWlNQNkJvMW9yVTFYc1V4dUhIclFTWXR5bmxn?=
 =?utf-8?B?MzFSNENpZThjeGRCbGtoMFUvbm1kMytCOUo5OXptZXlCM3prTldETFVWMHd2?=
 =?utf-8?B?RGE2QmFwTjltZ3hOaTRZd0ZodVZOR0FxOEp4S2UxWHJsWk84TEM5Z2tnakxm?=
 =?utf-8?B?UnNjOWk0aDFqa3ZCcVpPSW5IN3Rac0lqOG1nK3RKejY1WFBDR2NTY1BNeE9a?=
 =?utf-8?B?NG1NRkJEUklrNHU4ZDVLa0E0akVPakc3TEpLcG9CTjR2OGx1emJ6MjhSemtO?=
 =?utf-8?B?VzBNUTVkSWd1Unh0SHBaNVZtNjYxcjRVcUJFQUptbXJDSWJQVExqdDZnUmNt?=
 =?utf-8?B?NzJSZUtwYmNLOTVFeHV4bVJ4SDVoMm9CMnlSR2ZnQUpJSWJucXRMdjdGZUUy?=
 =?utf-8?B?aXhYdk1OREhCdlRmeXppVFVjSVE1clRHNVplWUFQYStUT1BqL3hMWUlNTFNk?=
 =?utf-8?B?Tmh4eDJBQWFuYmZiSjhDdnR1SkZoMUNTVmdHbk5BM3JMSS9FdUdtdTVZQllK?=
 =?utf-8?B?bG4vZVNKS3dkUXNvVGdJYVlqRzlyd1o4RE5OUzBsQ0hRNDRBQ0lvRzh5TUdR?=
 =?utf-8?B?WkhLY29waGpqU0x5UVYzbE52T0dyOW4zQWM4S3o1dTFkWTNvM3V2WlZ3ZkVY?=
 =?utf-8?B?ZmhMTnREaC9XQkdYeGNaVG1pVHFMVFpxcDdKUW1VVzNPWVJKQ3JsL2NPTWNF?=
 =?utf-8?B?OWE5VnpPQzdDZ2xMOUhsMUU2UXdxbjBHOWtRRjcvRENKZENFZG1vL0lCVnB5?=
 =?utf-8?B?M1Z2SFB3RzByV2xuYTRodzBYRVNGWTlaRUV5UmtmOUg1WWM2UWVrbXprejJX?=
 =?utf-8?B?OTZmTHRHamVCNTltK2I4ZklMc2Y3OE1YT2gvWmxNYWkzMXo4Y1NDaFJ5TWxD?=
 =?utf-8?B?aVFya2JCUjJ1aFVXYWtnTDJneUFYQ0VyWjFDbTQwenVlS0RQRmlhRk9zOEN4?=
 =?utf-8?B?UFNUdVp3S2dublNMc3JwSEZKdTMrTjdjbUFwd281S1VHd1M5bEtXL2FTbGZK?=
 =?utf-8?B?ODN2R0RMbkQxQTlqdmY1TTNaeWZycWNDZlhVQnlMNVhWbjRxSXA5bldjb1hk?=
 =?utf-8?B?K3c0RjIvTHFYaXVpbjVERHl4dW40QVVocVVkTEZjVUtEQUNHVWh0U2o1akFY?=
 =?utf-8?B?VWRVYVRrSHI5a0M2eit4NWJ4Z0RxR1RDWVFKZUFCVlRWbWVIQVNSYll3ZU5R?=
 =?utf-8?B?TjZENUgvdW5tUUozTXRPbGJ6eWZ5REMxZTBscmVDQyszdTlVdHRLMmRsZnpW?=
 =?utf-8?B?TXR1Tm56VS9wUm9nZHYzOEpaVUozVWxqMlJRcVBzaVBvemtLeUdxWEsyQ1dr?=
 =?utf-8?B?TS9TSFRUVmU4Z0gyRVNnZ3c1TStRZmIyTjZPL3dDeExjb3pNM1VtczZROVhC?=
 =?utf-8?B?bEt0bU1lUXltUUkzWktTRkJmWERtSlNzZEwrcTVob1JRM21YZGpyUkViTmJM?=
 =?utf-8?B?dWwrMGtXSzdpd1pzVGNYbEc1MmpTNEd1VWJZZjNKeXRhRjVGcGxOL0pXc0M3?=
 =?utf-8?B?bEhQUWJEUkdVUWtWUlNJSitiZkRMZWRXM0N3Zk45Q1J6SUVoMjhFVGs1RXdC?=
 =?utf-8?B?RTFrZ2hGVkJoWFNkUlhtc0JBVHhOSGg3Uldlb3J3bXlqUGZ0cWRzNHFGQTl6?=
 =?utf-8?B?cTlac0dTajhwQnpVdjVnUjR3TU1VbnVQR3Ntd3dQb1pQYjhjMXFiTmp0ZDZu?=
 =?utf-8?B?OHk4cXJlUlp3UjRYc3A0YUtjWTBVZWdtNjBBVHQwaGtobzVwQmJBZkx0ckRD?=
 =?utf-8?B?Tjh3U1EvSWs2RTFpZGNTdHZLVG5kYXpQbXNMcDdRM0xnV0E0UWlaRlAxYldG?=
 =?utf-8?B?dC9zUTU3ajR4SUFNelcvdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVtZXpUeGN4UFFCKy80aE16VjZPbERMTndIcUIwTWhhM1l5ZWo3MlFpZmcz?=
 =?utf-8?B?REN0QmRRZ2xuTWZtRVpMM1MxN1dJRzh6VHlMY08zSGxrM2FMcGhTV0gyR3hX?=
 =?utf-8?B?UW42ZkFJZzB6NVRYNlZkZkFEUkFOTTZtK2dpUmFRdWp0R056d2NKM3NiSzFJ?=
 =?utf-8?B?NXdqZ0paTGJGSUhHSkNiRUpkVWRQYk4xdmFjZ0RpN3AySjVsd29GMHlmaFlU?=
 =?utf-8?B?ZDRjdy9rWGI3YnhHUTM2Lyt2em1jYzFnMmZLUEhoWnkvYjR0bmxGMVZ1ejhw?=
 =?utf-8?B?U0lkeGI5VU9Wc2sveW44YzhXdWhnWEhxT1lHTkN4eTltditWZFFJZVllNFVR?=
 =?utf-8?B?RS9tL0pFNDczbi9NR1M2czRvR2hpaDhTOTA3VmFsUkpUWVUwejBQTWJObHBS?=
 =?utf-8?B?M0g1TEpOVGxuSTJHbHI1WFgxeG1CNDRUdlBqTE1WK0xXSHNZV2xYckJOMCtX?=
 =?utf-8?B?eGZ5UFd1MmcwWkNVNldqTWhDS0t5UzRqQVAwUURyVStZRk9sVHJrRmVXZWZv?=
 =?utf-8?B?bFlBczdVNXV3ZEhnd3pYSWk5RzVRamxkdlp2TUZra2NJM1g0OW9oUTIxR1ZG?=
 =?utf-8?B?OUFlSzRsMThzY3B3VUpHa1YydzVlOHNhcDBDME0yUUVaQkFzYTl5WmM1WnNt?=
 =?utf-8?B?YUlxSEJOMVBpeVBaWTdndUtKT2pyZkRLYVNMRlJFcW1jSjJmTVlWTEtpSXZx?=
 =?utf-8?B?N0FtaU1DOTg3MksxbjVLckpYVUFGdHNaS2E2SU55N3c3eUNsaGVvc2ZiTWgy?=
 =?utf-8?B?a2RGaVdIUEVxR2pBWEpSWm5MSzVJN1NrYmZrRHJEamtMLzQzSmpxaEtQUlFk?=
 =?utf-8?B?Mk96c3hpUHFCYXhLcWNBWkJnZU5MblhYamJNWFlmaHBoUERTcHpLSXdjVHBt?=
 =?utf-8?B?cE1XdkZhMHU3TTgxRGpuUzZtYmJzWXpEejRXWHo0T3hTUTB5VHVmaWsvUkR0?=
 =?utf-8?B?R3hsNFY5cko0TjZnVGZ1UlV0QnJQR2svd3JzQkNYUDBndzZDWVpBN0tRL0gv?=
 =?utf-8?B?YlZBV203U2UyTUVGZ010SldtbHo5NS9nNE40eGpxS3Z5d09mbUtKQXIwcVFm?=
 =?utf-8?B?SGU5azlLekxRUHFObGQyT0ZpQjVka3RQV1RWTlhOdzdBRUR4Rng4aGg3SFYz?=
 =?utf-8?B?QU9TZXVTK3ZLK2dGaDh4WGhwU0Rld1hGdUtmUDNDdEp0RXRGNDNiQTRrdVIw?=
 =?utf-8?B?VWNCL3k1Mk83OWlyYWNkdCtucTR5Y05LVDN3T29KM3U4RFdJcEhMTGZFSmQ5?=
 =?utf-8?B?ZC85NEUwbFBhK2JLS1k2cmpPUVJ2SEd3aDlaNVlTNCtkYSt3ckR4aDZSUzVR?=
 =?utf-8?B?TnRHOFZkRERKdGFQK1NWcmRKSnl3Y3BwNDdmam1SUUJEQlFZZVNqNTNZRmV1?=
 =?utf-8?B?dVN6Q0dBajRwYVVhZWhTVGpGVktoeTNYVThIQTJNanNhbVpta2FiZTBaNVRi?=
 =?utf-8?B?dVFTS3pvcVlYVG9EQ25TT2JjVmdJQXQvZDdUVXZBY1lzelRJVFkzWVhJbVBv?=
 =?utf-8?B?Y2pxbVFUNVBPREhnb1l4cEVVeXh5YzBkdkt4Sk13bVRUdVRNUEVmMmJPakxi?=
 =?utf-8?B?NlNlME9NdmVsWnJvT1R6akhMblBhL1RlNi81emNKRkRaUzZqeWdUU2hKMHhQ?=
 =?utf-8?B?Mk1LdzdnSmw0WmhJajJGY0hpT0xOYStiOXhlK0VVSWpJSExzbVlybEpySExv?=
 =?utf-8?B?VVpuZTJMK2hXU2xyMTlSVi9JTDRLUHBWeUQ0eXV1dUl4WlpWWmh6cE5uMnh2?=
 =?utf-8?B?UW1YL215T2pIdjNEdXFaNC9QNmhMTE14Q2ErazhtVkx5UFVxa1pQYnZxM05a?=
 =?utf-8?B?bzhMSXJlVUxNWEp2MXNNZFFoV3F1aUxycm85S2xqZHFUaDJSTXN6Um1qbW1U?=
 =?utf-8?B?bm9XQVdibGR6K2dKamdUQUNhajdnRnBVMytBRTBMbDlGcFdUbjVLZ0laR1NF?=
 =?utf-8?B?eG13QXQ4eFVEajdvL3d0amxmQnpISTZhTW9wZkU3NXJ3Rjl1c0dBZkx5TFlV?=
 =?utf-8?B?MXcxNVpsOUdHa1hZeHg0WHlZNG9GQmRkWVIycmN0Vm5hOG42dDJUWVM1Sk12?=
 =?utf-8?B?MGVBMHRZb0VVc1oxT25oK1orYUtXbG1xQmhtdjNLRmQ5Qk5sTkNadWxGRGsv?=
 =?utf-8?B?OTZHQXZEZ1RTMmlnNTlBUVZnMkFnMVNuVGtOc2VEbUZGazk1QWUxV0VvejU4?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a47650-2d35-4134-6241-08dcbe3c6e93
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:43:14.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmCVSY9iqHtYfKQKMNL5/hlSna3Z6nsyTHzRjl+CPPwbogYOF4F6X2daNktGFebpTqFM/YYVRbpEDV3dcrhbhF0FrlXQF+gkXbBeHq9/rbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> +static ssize_t rdtgroup_mbm_mode_write(struct kernfs_open_file *of,
> +				       char *buf, size_t nbytes,
> +				       loff_t off)
> +{
> +	int mbm_cntr_assign = resctrl_arch_get_abmc_enabled();

This needs to be protected by the mutex.

> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret = 0;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!strcmp(buf, "legacy")) {
> +		if (mbm_cntr_assign)
> +			resctrl_arch_mbm_cntr_assign_disable();
> +	} else if (!strcmp(buf, "mbm_cntr_assign")) {
> +		if (!mbm_cntr_assign) {
> +			rdtgroup_mbm_cntr_reset(r);
> +			ret = resctrl_arch_mbm_cntr_assign_enable();
> +		}
> +	} else {
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +

Reinette


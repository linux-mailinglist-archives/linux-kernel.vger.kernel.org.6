Return-Path: <linux-kernel+bounces-367187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C899FF98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E5D1C24788
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC4717C234;
	Wed, 16 Oct 2024 03:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKM9U1VX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9357CBE;
	Wed, 16 Oct 2024 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050044; cv=fail; b=rQ1VMrlJzkMuZ0tIZQFH1W05iohY5pmDRi+PClvap/wmz2oSEZFlSjqNk6MJ7Fi1OwZh7o7ttN0VB/q/W+NgE+ncOthZLq/vghEMxWO1W3DTXZPa2Pytzlz5ehj39OLj4eQCeQMbYGiezH4WVizGt1LjCrd4shfUolcveaPhwmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050044; c=relaxed/simple;
	bh=Wd/caWL5O/gBCtQxOdRXzZlADL7AicOOrsiRuBTHHIU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fMh344H991VBk9v3rQ5/YqMclO2HhO35oUKZVLLmnz22pNAgDMr+DltXZjkYvwWWU/tFwzwKD/6Odq1rGfAS5wF8Po64Qs8DyWO5jhZCn2GTzlVFmVsrklR8zgdNamqEyXJX8PvG7R7OHsYHLcxbafEiV/AFoEHdBNO1DLKlrL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKM9U1VX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729050042; x=1760586042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wd/caWL5O/gBCtQxOdRXzZlADL7AicOOrsiRuBTHHIU=;
  b=lKM9U1VX00NUS/6cpC8WJF1bRaxK1JJuyLsfMcjSrlnsuFZVScw0Ahus
   6Pw4JXGq5ibF6E/4mIopi+PNNdfU+nSZSIp0J4Zp28A6Pc0/CspBLKCRv
   wiyJpBp7oCpaKn2Z1UefKzkrFupF+sy2dp1SabY0H1IykXDCbcmzpsorS
   qJshHAsPs6JNNwk9qZ31uoMYjEECyhwvJktDwz4t81oXqAG/AEVy/WMI4
   HmLpUch/KKXg3ulifYHxzumh+ascQaeBu9ylfGsyl61p/uAzdmrMdZE1h
   VDycz6m2cv1drfDKuiykfOzsBm3B5by9+kLuIAZYzcgKiCQgkBKs9Yis/
   Q==;
X-CSE-ConnectionGUID: OqMATHQvTVm4XTDh1ztEMQ==
X-CSE-MsgGUID: odvKVG2URH6SF8nciy2gOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28268127"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28268127"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:40:41 -0700
X-CSE-ConnectionGUID: i62z83oVTIqozvpnYzRcQw==
X-CSE-MsgGUID: cfyumBC4Sm2dRBJ735r8RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="83173964"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:40:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:40:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:40:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:40:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFKnKYSqmlvFtgVr1tnSZUmAWd+D/+4DcgcrF8W6aML/KQSDlPjw8fhNhcWiZiSLeyTiwZGwYzv9tu6VdvPrRGYDakEd482FkCFUwMbZpM1/eix1gNBrxhVbUCL0YUNIRPCI8rHig8BtjwJ40T8k+eEyL4wbHMnoPkH7skwlfHlPmtVBAHc3xcAf1q5hFt8iTd5UQU5wW7Waznbulq2RvwlGbAxCgoZzT6pG24Lidw8TgeMcoQlX5vUv98QhjpJ01ibg4c6+pneRsv4T7JS3Q7+Kr8nUpEo4moIvqmFnv0DGKRdRRpS1jD0GYub6sQPo+MT9wZQXfG1VCQBxjCNiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTHzf3N5RIUEOY55mXhZYeojfOkCF8Ufzz7cqkUODD0=;
 b=dL/NTNN0WkjH6QPiGHX8WXYbPRVndeq2B2zNMuECLRZdcK2tzW+m+milLATAu+dP8KaexmbLloM42iUJjSaXkRnAixsz46Dv1YfmHoDbrdYU4IfFYDGyjpaDyFZDt1fimDRqQeE+Gr+fS3jeQ1HFLvMSqIVuwfEA7l4SD5COw/V/a0e4zyie1vvwh1svl8zSEbCuB6Ta+7HDNyILVu9l7QRIeLw0V8WkmjoWDIkai1fXr5s5t573DtAw+pLlpZBWfjyEMAqwYRr6V204ilJFEvj1B1V5aOSNhMIvB1ZCjCHrG8SfxoZMdI5BL98eK9gWrP6LoP+vQQoJPdEI/oivNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 03:40:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:40:32 +0000
Message-ID: <03b278b5-6c15-4d09-9ab7-3317e84a409e@intel.com>
Date: Tue, 15 Oct 2024 20:40:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 23/25] x86/resctrl: Update assignments on event
 configuration changes
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <715b84c29f4ec849a79698ad43218d4a486422d3.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <715b84c29f4ec849a79698ad43218d4a486422d3.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: cee334e8-ca93-4c24-51d9-08dced944973
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDdtcnk4Ylp6YWNCYmhYTzVSamIvRFg1anY0NnBETUVkQkprSHBoZmlNSHpr?=
 =?utf-8?B?aU5PZVJwczZvOVh3NXY2R09ZZkRjVEU4dGNwRkdrY3ZOU3VHOFg0L09tWFBm?=
 =?utf-8?B?TzcwNTlaeUVsQklNNXNVTE5yZU01QnR6eW00RzRmYVkzcTJ0VHBUcEF3czd0?=
 =?utf-8?B?S3FwenVneUt5eDNrTnFrRldNVk9veEE1WDhGUXJDRzRvSnVJUmtTaWpaRm1H?=
 =?utf-8?B?VnV2aWxlMkR4bnFXTHlYdUovNVRIQ05weGhoeVI2dTRiWDJ0VCswMnlFN3FX?=
 =?utf-8?B?QlM3bXRnMUxRUTNBQ2VwZjdPaFZVRmlYYlExdnZiVnJhakg2eE1neEZxaEgz?=
 =?utf-8?B?cE9oeXkzTnM0cG5oUzBZNUtMQTRLTW9nWHo1ZnlUbUlJZjdUb1ZOdWNJSmFQ?=
 =?utf-8?B?SXg5RkVsNHdGQnp5Z3hVVG80am9sQkxtTVl4SjN3YXdkcHU5QjE0Z20zV2NY?=
 =?utf-8?B?R3B0bUJ2NVBFbWI5dkEzRnFBQnBuMUNkbytMMjFPS3ZuNEVRZmpIY1VJdVFz?=
 =?utf-8?B?RzR6SXBWR3c2TVg5cVpqK3J5QlVqcEpwczhSeUgyZy9GK1hPdzdUOGJZeE1Y?=
 =?utf-8?B?dlBFaUdIMU9WbUI1eHZEYnE5N2hDQ1BRckQ0dHlFZEgxc2VwZS9BT0tqS2Zq?=
 =?utf-8?B?SUZDQTZ0N2xLZFpSUVNzQXRtbkgyOVpjeXMvd0QrMjRlK3ZPTStqNTJZb0o2?=
 =?utf-8?B?bTFZVnZJU1VvOTZTUGdIZ2sxdW5vYzhiVDUrUmtqcXlhVVVnSXFIMWFkSkJV?=
 =?utf-8?B?M3pUK2hOeEFkbGJNSE9LQklLMkxCOUdrVUwyaW0wRjBJVmxDSThUTjAwcTVF?=
 =?utf-8?B?bzEwQWs5WFplUklJZU9yb3Z2VWJRNGk0b1BXLzZKbW05NThiS2xKVGpZZVFZ?=
 =?utf-8?B?TWc3dTdRMDhJUTRCZ1JoZGNPblVaWUI3RDVNaEhqdk5Ram03MWgvc1RJVUhV?=
 =?utf-8?B?ZThuU0pSSlhRVWhUVUhVNkVRRm9IK2hWRVdra3k3OStQR1JRN3p5SUx2cGxk?=
 =?utf-8?B?MG9rczAwNUdOeGpQWHNnUFRqelZtQUN2NXZJdWZFUzNDUWhPZkpJc2FFMjBk?=
 =?utf-8?B?NVZEb0VRaEhnNjZWbVZ3WmErQUs1M3NRczBhaG82NlFvL1ZpZHErSWk2Tmpi?=
 =?utf-8?B?ZnhLSURIVkExNVppY0lrdWNKWUVyWHMrQ1l4MnVUL0VqdUZEZnQ4RnRJejFL?=
 =?utf-8?B?UXZiL1lIWkw5Sm0xR3dGU2VndkZOL2pqRU8va1p2YUF6b0NDNHNZektxTm82?=
 =?utf-8?B?U0NyRHlyeGZ5RWJvMXdObDY5TWRFQW1lYjdxZi9tcnZuSXBWY0RMYURDSllh?=
 =?utf-8?B?dXhDcTFKRktoNGs5LzkzZ3VOQkMyV2JRamVIeW52MlhuZDRzdGkvR2Rzckdm?=
 =?utf-8?B?dzZUQTJHdWVYcDkwemU2MVZhZWF2Wkx6WXRXSzkvSFRINmV3RmVlVzVmaGFp?=
 =?utf-8?B?a0wvZEx0bzVVQmV3YVJ5a1ZLaklweXl2Z0lLUU9RRnFBMEhhRHpuY1UzRjNG?=
 =?utf-8?B?ZDVRa0lHSzN3dGVTQ3VGVnI3aTZWaVNIbGRPMlcwL0lOa1NWNVVwYW1ucFRz?=
 =?utf-8?B?Y0s2ZlVJZjRKK1d5TkpvMFE5ZzZUa212SzBMcUx5WVlTcy9jS1BkM3FQZkNs?=
 =?utf-8?B?NFJROXprUFVHcFZ1NFBGRHJCTzJsSFN1ck1TUWNYRnFTVnFGcDJIK3Z0NFJX?=
 =?utf-8?B?SXpOblV1TEJzMXZqTDJITmlVS3NocitKTFNTU0R5U2VTUTV4ZG1YOHpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDFhbER2QkFCcElTSmJtaDFFZHBTaW1WdmhBeTMramhHN3lzandiRDZkLytu?=
 =?utf-8?B?ajd1SGU3aWhwaFdreWJYK3NIYjNwOGVuZDdVV1ZST2xYMVp1eXo5S0o1S3E3?=
 =?utf-8?B?UVY3UlBaL216MndJUkVxZ1hEVEVGOTRSSDVQVWgvbENPeDNKbmRaU1l4VWFm?=
 =?utf-8?B?QkFKRC9GT2ZSRlpuYkl3OVhlRERTbEUzeDFkK1h1WkorM1ZSNjA4UjZTalk5?=
 =?utf-8?B?YmsraVpzRUprMUlSam0vVVVEZjZiVlVtYUpmRys2V2tFcXludm9iYW5veXox?=
 =?utf-8?B?MkhDdmQ5Rkt1aFRZNWd5SGh2OStLeDZxdHlvM0RJTENmeVNMREQyL2N0UEUx?=
 =?utf-8?B?VFpFRm1pNUJtNVh4QStMNkt3QXR1c2VQUWNEdHNaU3o5NmhwNUg5WmkwT3lt?=
 =?utf-8?B?cjNuSjdMYTVOZCtXT2krQlpqa1BMN2VSWldmMGEwZEU2WWtWTDVXUjZZMXIx?=
 =?utf-8?B?aEFBbWVhVHBja01SRnQ2dlhybGJpTFpBUWkveVFYZWJ6OGZDNkZLdGVZSkdO?=
 =?utf-8?B?RDc2OEVHay9ZL0k3NW1TQUdjeWd0RWdLelIzdmpKbTY4dno0ZFhJSHNjZnJV?=
 =?utf-8?B?SE9EOHVhTHNpb3REcCtJeVNPY1dZYm1ZbWpxb0FSUTNSdXpqVWVmYml6ZVdq?=
 =?utf-8?B?UnJaR21YckJONkRvQXFNaUNia1pKQjM5ZWZYa0ZPK3Zsc2lwSVp5cTVaN3Ji?=
 =?utf-8?B?SjUyZTk1Kzd2R2FyclhnZWxjNWtQUkVKMk5xd2RWRzBvZlRzZ203eGI1Uk1m?=
 =?utf-8?B?S3F2cG1UaGsvZElCMllGSDNBRVJlZFdMbWFFVWpFcExQRXNiUi9yRXVTL1FE?=
 =?utf-8?B?cExORnlaaEtpNVJ5aW45L2ZpN1pERGQ2cDBQZjlKbjFYOTNnWFJzM2ZrZmM0?=
 =?utf-8?B?TnlWaUJWelJQQWdwMitpSHRhbXVJRE9FSEdYYW1ZZVVxL1h1STR6UWJhZ3NQ?=
 =?utf-8?B?dEdmcXQrTHhINXV3TjBMNU03RUkrNzV5amFKbCtQY0hTcE1ITmlUY3NmVGRJ?=
 =?utf-8?B?ZC9lM3dKMWlVcHJabHAxQlhIS2hFcy9uZk5BU3VOUFFQNmZ0b2dUUUZrOUps?=
 =?utf-8?B?ejBDa2E2aXQ0dFZqUWJHWWlzWThzck80d2U2bWVVaFlqQ0FVcnJGMGUvd0RK?=
 =?utf-8?B?Z3ZFYkRaSUdqOXIzOWl6TEpxOTViTTBJSlVpcVZQSWQvRHhMeHFSalQ2KzV0?=
 =?utf-8?B?YTFUMWkvNDM4Mmt6OG5oL2NiZTN6MUxuejN0cUNEcWY2RVFxbE50RityS1Fs?=
 =?utf-8?B?bVhHUWVyaDdHS0lHTTRpKzRGZEJPbnBsWnJoUjhZZ1B5QTJZdU5qa2lrQSto?=
 =?utf-8?B?V2VFSjh1UmFiYUdGdlIrdFJka1oyN1pPVW5Hc0dzdit2ZXFvMzBaMngvRnpt?=
 =?utf-8?B?TGlBYS9GVDVKYzZ6WTdzbENsRzlVTndjUUU4UjdVYnVZS1JaZWx6Z2pIZDkr?=
 =?utf-8?B?REZTeVBheldXdXNpUmRyeHc3K0ZXbU5qcy9DMDJIcGNFYllrZVR1WE95dzg1?=
 =?utf-8?B?ZEpyVGFxVkQydlllb3pnRzFZTThNWFZwRitOTlBTSmdTYk16Ym82Z1NjQW0z?=
 =?utf-8?B?djhaYzVrNjZTQVhsVi95R050aFVNQnRHd28yUmZVZ2p6bmFDZGYzeEt2ZmtU?=
 =?utf-8?B?UXdZRzhlekI5bzZqOEg2TXo5U0dVNy9ITW5oM0wrUWszRU9CVW1aUFo3amdT?=
 =?utf-8?B?MUtxMlA0VFgrSExLU082L21rTlVxSjZ3MWFRSWU4WkxsMjRCM2YzNVk4QUU2?=
 =?utf-8?B?SHFOck1sSFB0a2RLanhSNzVpVFRzc240eW5mUG85SHdBM3VYUy9yNWpHUlMx?=
 =?utf-8?B?WVljL3k2dnpvL25sN0VicmRqSkdxbnJ3ckdXUmVKYUg0SWJrRFY2eUZvWTNF?=
 =?utf-8?B?bnpNMFVxVTVrYm9nTk5xczUzcUxnQlFhTzBzQ3VuQ1RTM2F6c3BVUEJDOHpm?=
 =?utf-8?B?bVVwaGc2SGd4ZDlSbTk0VlZhN2tRaVh2dGpkNzJubTFHMU5QZ2FadGE4QVMx?=
 =?utf-8?B?ZG9ueUZJNVZaQU5ZZDVHbDh3NkdmaXdsMU16bEtjVUpyOVhGbWJYbFBvelpB?=
 =?utf-8?B?b3N4NmFxMWRIelJWanJqZkhhUUpxcDNpVHpsN0RNdkZjV1ZCMEFrV3pCYUJ3?=
 =?utf-8?B?T1VTVjV3d3hGMVZESkpMT28yYWZwN0p3UW9oUkdIbURxTEl0MnprUVNCeWxj?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cee334e8-ca93-4c24-51d9-08dced944973
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:40:32.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofsJtwPJRO9LNIxvu7B1okyg1/7HXhsqzilPc1EafCgCoZtRP9q6n9HWdZhjK9IdEhCFAtHpdfD3JerSuf7I1M47TPZqe9hHZmjBW3dwNqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> Users can modify the configuration of assignable events. Whenever the
> event configuration is updated, MBM assignments must be revised across
> all monitor groups within the impacted domains.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
...

> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 49 ++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f890d294e002..cf2e0ad0e4f4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1669,6 +1669,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  }
>  
>  struct mon_config_info {
> +	struct rdt_resource *r;
>  	struct rdt_mon_domain *d;
>  	u32 evtid;
>  	u32 mon_config;
> @@ -1694,11 +1695,46 @@ u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
>  	return INVALID_CONFIG_VALUE;
>  }
>  
> +static void mbm_cntr_event_update(int cntr_id, unsigned int index, u32 val)
> +{
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct rdtgroup *prgrp, *crgrp;
> +	int update = 0;
> +
> +	/* Check if the cntr_id is associated to the event type updated */
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		if (prgrp->mon.cntr_id[index] == cntr_id) {
> +			abmc_cfg.split.bw_src = prgrp->mon.rmid;
> +			update = 1;
> +			goto out_update;
> +		}
> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
> +			if (crgrp->mon.cntr_id[index] == cntr_id) {
> +				abmc_cfg.split.bw_src = crgrp->mon.rmid;
> +				update = 1;
> +				goto out_update;
> +			}
> +		}

This code looks like it is better suited for resctrl fs. Note that
after the arch fs split struct rdtgroup is private to resctrl fs.

> +	}
> +
> +out_update:
> +	if (update) {
> +		abmc_cfg.split.cfg_en = 1;
> +		abmc_cfg.split.cntr_en = 1;
> +		abmc_cfg.split.cntr_id = cntr_id;
> +		abmc_cfg.split.bw_type = val;
> +		wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg.full);
> +	}
> +}
> +
>  void resctrl_arch_mon_event_config_set(void *info)
>  {
>  	struct mon_config_info *mon_info = info;
> +	struct rdt_mon_domain *d = mon_info->d;
> +	struct rdt_resource *r = mon_info->r;
>  	struct rdt_hw_mon_domain *hw_dom;
>  	unsigned int index;
> +	int cntr_id;
>  
>  	index = mon_event_config_index_get(mon_info->evtid);
>  	if (index == INVALID_CONFIG_INDEX)
> @@ -1718,6 +1754,18 @@ void resctrl_arch_mon_event_config_set(void *info)
>  		hw_dom->mbm_local_cfg =  mon_info->mon_config;
>  		break;
>  	}
> +
> +	/*
> +	 * Update the assignment if the domain has the cntr_id's assigned
> +	 * to event type updated.
> +	 */
> +	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
> +			if (test_bit(cntr_id, d->mbm_cntr_map))
> +				mbm_cntr_event_update(cntr_id, index,
> +						      mon_info->mon_config);
> +		}
> +	}
>  }
>  
>  /**
> @@ -1805,6 +1853,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>  	mon_info.d = d;
>  	mon_info.evtid = evtid;
>  	mon_info.mon_config = val;
> +	mon_info.r = r;
>  
>  	/*
>  	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the

If I understand correctly, mbm_config_write_domain() paints itself into a corner by
calling arch code via IPI. As seen above it needs resctrl help to get all the information
and doing so from the arch helper is not appropriate.

How about calling a resctrl fs helper via IPI instead? For example:

resctrl_mon_event_config_set() {

	resctrl_arch_mon_event_config_set();

	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
		for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
			if (test_bit(cntr_id, d->mbm_cntr_map)) {
				/* determine rmid */
				resctrl_arch_config_cntr()
			}
		}
	}
}


mbm_config_write_domain() {

	...
	smp_call_function_any(&d->hdr.cpu_mask, resctrl_mon_event_config_set, ...)
	...

}

By removing reset of arch state from resctrl_arch_config_cntr() this works well with the
resctrl_arch_reset_rmid_all() that is done from mbm_config_write_domain().
Even though resctrl_arch_config_cntr() contains a smp_call_function_any() it should
already be running on CPU in mask and thus should just run on local CPU.

Reinette




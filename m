Return-Path: <linux-kernel+bounces-368601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0CF9A1213
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 536FCB24874
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F718DF97;
	Wed, 16 Oct 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrnCM0C4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF318C33E;
	Wed, 16 Oct 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104952; cv=fail; b=iUPHLFWGKAOKa64JPudc0z1idojIuJiXubUY0vgXP3XgIc7TNrxdU5BMmIWMYUv65Tw3F29TnZ+wGdkw1DnlO3gzWWn17q1DJiT7hBSrq86TK+FzvVWWceIHiulfSpEFV02i6i+B8A++3zUSnYtkNAFtERpLORVRl3ZoyIA0OJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104952; c=relaxed/simple;
	bh=/lV4oNK2Jo4cmDejR/BOM+TuL5wLinkZ5RKTKPBtNso=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jQxzN3IDL4R/INOtkkEsjEmEXHRnljuNaGJA29RdEyL35th16mH5Q2zpvYK+5eOj2paZjhjFlrW46tptUivjSxJECdfeT9zxw/aUwpaENzCtVqF1kGDzXBgXCj9jtNww8UzlCzPn10/2v9jXQvGeIed4kdtUnti31ojmMRnGg5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrnCM0C4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729104950; x=1760640950;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/lV4oNK2Jo4cmDejR/BOM+TuL5wLinkZ5RKTKPBtNso=;
  b=IrnCM0C429C44uttLsLmAa+oOt5yS9yRYipwA6OEofLXhb2R0f8hProy
   ws66ShL6u6/VOdc0ISlt+XOCW6Pq9kcFQkUV0REasOleSyS8PsX85W2F1
   mF5gYfH9Z3Ji9XpTJpA7/0jwYDXhIRB1bkEmWjzLYhvjWh5eyzJj3nEiG
   +mURqFrq83jBj/1RIj4RSHpElDdSmMcD14pbMbOVszXM2M7ZafphY4VVO
   FsAPRG2O7nF6CPt2qI9NN0A5eTWeAhJTS5eZwSDCqrX0ZUrGCytvzlw6I
   O865BcGeJlaYeEPxfXeyJ979mnJLHujvsUCaxVkWK0+JnImoonWQZk642
   Q==;
X-CSE-ConnectionGUID: DmKycJZTRVmfyCiADgVB1w==
X-CSE-MsgGUID: 8D3cmtvjSZGqCZCxuVd0ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39690479"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39690479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:55:48 -0700
X-CSE-ConnectionGUID: OFEs5zksTdSBepVUd+8jlw==
X-CSE-MsgGUID: M0ZeVUgpS/GjzLG8QVK27A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82852975"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 11:55:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 11:55:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 11:55:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 11:55:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 11:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ0kzK//EmaYXkQVNIX4t8J8tZzOvQWLOLE9Oc9c2TXY+w19kHHGSM9NJLelFSQiLHkNovuNrp5ohVm+g3ZetY/hX1JnwaLazAWsAVnSTvbHdgB/nOpLzYznI3enO/veNeNioE1wW4A7RrX5xKrgKdTLLYzYvO3RzdpYHNkAYXwquYF4vAfJC4L0l3Svew7Ji912hhxCu5YtuL26sRlj/ErJ0GeWZnhxS7ZhgErTaf8pGnju175fOeQVW1oEFRjTcooKxMhRt10nrFDrQn+QpKBmkhiRVCfs7wajqtTcB0PBiGCPeWq+2X1upnW2d7OplNHnfIVVWR12vEewaUDGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd+WUv8JoEogBcG+jYRRD+QysL248Bz2wt1SX8faPFQ=;
 b=kLzGNmxdWumA14t07GI2BdPohBLSMUtJQPltT9NIdzQjyQoe8Y88kbxHkwmZpNMPOv38jSN0wEQ0KWZ+CWJt3UcB6mE6TF8Zyla2vIkWisUGTxMUJryCD4Gr6PdCBcuOz16YQr+Eo+iaMsubbNvMYW9KqNm6IahdbTX7jIeNztKeMXkptszvMvOEb0irFvGMSiH0Ro86iRGN9WSvfk+f1T9/OMSc4AbpDweeDd7CO7/wIJlFQFgkHYwDSJpn6hndaKfoc2lXngltuIYe3OnalXZhSuGGET88HRro0bbGhf6DSvQVoBFeEreAODayhlaKz+77lPSioYAItot0CrVFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 18:55:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 18:55:40 +0000
Message-ID: <00ae6b0e-29a2-4240-93af-c460ce4de66a@intel.com>
Date: Wed, 16 Oct 2024 11:55:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/25] x86/resctrl: Add __init attribute to
 dom_data_init()
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <03077cf67cea1b3ebb00495fd40d1535db27ff8c.1728495588.git.babu.moger@amd.com>
 <b19af235-7ad5-4897-8082-1eabfee849e8@intel.com>
 <7749600f-f281-4cb8-b909-382a69dac56b@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <7749600f-f281-4cb8-b909-382a69dac56b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:303:16d::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: c805d7d1-b266-48b0-4712-08dcee142105
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzNiNFJVRXhSQllnSUpYQ2tjM0txMHJzNlVDUmh4YThrM3ZjOUFjTEtaeTd5?=
 =?utf-8?B?bnpiY0kyU1kyMWlOOFpwVG5XQXZscWVybzdGK282NmZzcUNTRUtETlZwd3Bs?=
 =?utf-8?B?QnQwMlJEK1ZhZDM1M24wVkJxS1BwL0xmbGxRUVhzaGw2TTNOS3pURWdiOGNR?=
 =?utf-8?B?WVNmTUtGTDIxRmFzbi8zNG1hLzNxQzEvZGxDKytRNWJEUzkzNllZZGVNT0Ri?=
 =?utf-8?B?aVhWKzVGK0R1K1g5eFNucU9idlFwTlBMWDB3OG4rS0FOeG5rS3NDZnZJTCs5?=
 =?utf-8?B?c1pwZnlrVHBzZkJWTjU2azFKZ1g2eHNGTXRoOGN6Q1R3NGlKS2ZvUVp4Smhq?=
 =?utf-8?B?QktIcTZwS01jeFBQUlh1dFBUck1FK2E1WThHUHRGL296Uk01WE1NNzU1aXpP?=
 =?utf-8?B?SldEUzhEZXU3MXhGdmhSZWhrQmRkWHFwdkRKUGRxMTZ5WlY2a0gyZUNCdTRZ?=
 =?utf-8?B?UURRL2UvQ1B4U0ZPa01RcTJTYUo5aDE2L3BUU01KOGl3d01Fd0lvU0ZqZWZV?=
 =?utf-8?B?NEc4SkhJT2h5NFQ2c2ZVR2VrdUU3M1lKK0RKOFdSNEpDUFprbE12RWR4eHhn?=
 =?utf-8?B?NnRuN00xak5YMlozWXpWSG44RExKTyttVkFOV2tReitMdlRueU0zTTlrN1Zr?=
 =?utf-8?B?L1pDSi9pOGMxc001UU1TdFV6QnVaUEIwMU1lbnVyQmp4R3RYUnBYako3NjRk?=
 =?utf-8?B?Q2dJNEZqZ3drOUQ0dWtvU2NVbTBjdm9BaHVhSnBOa0tzQkU0N0htM0puV2s5?=
 =?utf-8?B?NU5BM2J3dGI3NU1pdnBhRmZ2alA5Z3RjOFFFcjRNRzR0WjJSRnBlZEljNWNO?=
 =?utf-8?B?MTR0ZVhScThYVWd4UU14S3BDZ0lna3lLNnZzVGdQdEVNV0pUUGJLaXFxUVZF?=
 =?utf-8?B?eG5QeFVMSm9FS05rUjVCVFl6bGFsM0NZMkJyYmhCMmJMNHpFa3JFb0pKSExX?=
 =?utf-8?B?aGtaQW9HQlE3Tk5tMGdoT1c5K1M1Zi9FSDJLNWwwWWI1bDJPZll5WGlMS1d0?=
 =?utf-8?B?cmk2Z2s2VUtmWWFvbGRCZ0Z4a05EYkNjaGxoY3NMOW01d0RBajFBVzNpT0ps?=
 =?utf-8?B?VWIwM2xZK3pVaXRvODdrNnpsWkxPcEFqaUw1UlJOc3huM3NpSTU2S2VFQlY4?=
 =?utf-8?B?Q3VoekxBbU9DVmg3dW56VkZySW8rRVAxY3h6eFNWeFdYRlIvZjh4RS9GSmZu?=
 =?utf-8?B?ZE05eCs0ZHdWdWVneE8zNnVuVkJFa0U3MElDRk0vM1phN2toUklNbG85dlpt?=
 =?utf-8?B?d1BGZGszRDVIQWVTY3BUdzBPWW9VL2RXZ3BnTFk3U1VsYllNZEpHTUN3dVV3?=
 =?utf-8?B?RkJiZlZKM2lCWEoyQjQzb1VYZWI3NitKcjdZdENVQ214em50Z0dIMGZvckM0?=
 =?utf-8?B?YUFXdkdJMTVvVEFTNWJ4VmsweTgwYVlraWlPOVI5dFYwOFFaRHAya3VhVHlP?=
 =?utf-8?B?UkUvUDl1UkRVT3BhZ2N5b0lNeFRmVzJiQzV5TUF4YjBOdGczQU80bFgwRTlI?=
 =?utf-8?B?YU1DMFI4cVBGbno1NEtxRm1qSVhWZUtTcmhGOUJVYS8wUlk3TG5zdGxTS3Ux?=
 =?utf-8?B?d2lWUlZCZDM2YmpsblY0bkw2YW1QcWE2cUxJY3FkYk9COGlkRzBJS2pNaFU5?=
 =?utf-8?B?NHdTV2IxcjB1WHNxUVh5S3YrbWhyZENLc3BoYTNZRVdhYTdBSlVReFZrN2I2?=
 =?utf-8?B?SmJyeGxuNVBkUEZlRXpwUnl2T1NWZWtsVHRlU3lvUVRPalZjRkQ3RWtRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhRdzFGNEZCM3N0ZUZlNEhkR2NSaFJHcTdtSEdpakhJZFhiSW54TzdiNjZq?=
 =?utf-8?B?SWM5bmZyeURrWS9QZnI4Q1ovcHhmTnJrYVBKeVE3WnFhQ3UxSVNVcTd2eFhj?=
 =?utf-8?B?ZUk0d0ZubkJjYWRrT3RJY3luZGJRRU9Fd3AyNVJnbWZSbytWMEkySlRBNEtt?=
 =?utf-8?B?WW5GRUp1VTBkaG5rRC9sQzdpUmJiOUJGODNtakJPdTQwZ0Z5anIyaW45MFFv?=
 =?utf-8?B?Ym9wcWE4U2FhaUIwYVVWL09XR2VNQnY4S2Rhai9VdWNWbXZJMzJNaUs2WEc2?=
 =?utf-8?B?MFFyVjV2cytRRk9VOWJwMldpdFRyNHBJRncxMm5WSGVncDE3N2xsUlpPUEp2?=
 =?utf-8?B?Sm1WYzNQd1lOU2ZDR1A0WnVSNFh5cDhNdWoxdGFza1RQRkxkUWUxL0ZxRFJB?=
 =?utf-8?B?UmFMc1lla3hEcjNSTlh5Y0JCTWsxRytiZEZPay9QN3F3SGo3enRqb1BqYk5H?=
 =?utf-8?B?VmFobno2cHZMQzZiQ1I0MTZrWnJRaHl5UC9yZGFEWFFYd1UvSGN5SmJNaC9Q?=
 =?utf-8?B?Rjh2UDBid0hHcnB0aURPdUllcjFRUmxiNlNmNDZGbHlIcitMamlwb0MxYzFa?=
 =?utf-8?B?YTBvRDk0L1VkTGVFZHNadVVKYjNEeWtTZkE1cWx6cFV4WkU2YzlsTDNFN2tI?=
 =?utf-8?B?TEFXQ2FxRk9uK0czcHRqTmhzNkRuNGorMnVqOU4wWXNUSVNJcTNmSWlKMCsz?=
 =?utf-8?B?bE50T2dFUWc3VElJbVJKdElGMnlPTkpNdlNWMHZ6c2JkV29BMGllQkx6YUVP?=
 =?utf-8?B?VE55TlE0cjlLRGhvTVFudlBRTjY5amNtTnBTL2gvMHpBUFp0SEU0SmprOXUv?=
 =?utf-8?B?TTJkb3BJMG9lM0w0R2pUU2hoalJmZWRnM1Rpa0huTUFwQktWTzA1WGNIVVAw?=
 =?utf-8?B?eDFUTGdOdFVlZTdsSFY1Y3NvNDFNNUlDbVdhSmNlWFNON3JPdzcwTDRiYk1N?=
 =?utf-8?B?SjNJS3hwT002WEt0Nlg0ajViSW16Unp2cUk1YzFiaWttZm5EcTV6cnFJdTN1?=
 =?utf-8?B?UWxWOWtSWWhEZG9QU2Q3NTlOWi9peW0wZ2d0N2F6bmpTK0NBcVBVM2kvZHc3?=
 =?utf-8?B?V2FodzZIeHdUTzRUVVlHSWNLdXZnK0J0djdVbi8wU2lFUktDN2gwQ01MdFR1?=
 =?utf-8?B?dXFOSFZTc0dDakNVVVVQU0ZvQXFRZmdyTGNMcGpOMDkxbFMwMXErTXUva2Vs?=
 =?utf-8?B?dzRNVFZqMFNneHRmM3cwNVBNMStRTjdIZmRMaXN1aTIxWnNBT1BiTk1XMERE?=
 =?utf-8?B?RzhGanNMbm84a0ZROUlIWDZjUTVlUFArVnJrZEdYc2FDRGlsbEluSUFPUWNI?=
 =?utf-8?B?NHVEenVhSHFGL1QreHBvUDYxNjA5cHBqaGZ6UGovTHd6Q1ZZMExxaklMS0lk?=
 =?utf-8?B?SVA2NTE5SmdhREFjdDRoeWFIWDhMbTdQSG9wUTNIT3cxNlQxVkRkT2xNdzJo?=
 =?utf-8?B?ZzIyT1VQUDFyZmYrdGt1R2xtaGx3OFZLQ1hyN0pGRGRqaTBSa0FXNkFwYmdJ?=
 =?utf-8?B?UFFRNzRDVk0ya2hvY0x4d2huaW5NOU9EdGVFa0xDQ1c5aXFJNGxUSG9mRFMw?=
 =?utf-8?B?cTBBOXpPWG1hZnZhMlpYdUFDZ0l4STVleWcreTJTdVFyT1lDcFNDREJlbXF6?=
 =?utf-8?B?VkFOc2RPM0RaNVplZU5ac01OZFpHU1BtN1FhanNuV2dlbzJ2NFdXQnFjT1JR?=
 =?utf-8?B?OXRWdnVEZ2FYOStXWW1RT20zeFFQVm5pLzBQN2J1eTZyOUZDMG5Xc3k0SU5a?=
 =?utf-8?B?RUwyRWlVMHlnQUptWTNBSk9vcFJZaXpXd2pyQUtLSHdvbWlEY0RXajluY25r?=
 =?utf-8?B?eDNWZ0dyTXdxZ2l4Sm52c2VINklva0E5VVlBenhiZG9FbkFIZ3paZU0zOVly?=
 =?utf-8?B?NVM0N3lnYkh3MkdPQnV2SHlFc2dVVDNyNEVvZDR5ZlVQcHN3Q1NTdG1IOCtT?=
 =?utf-8?B?a0x0S0ZjcS9QUnkxL1VwK1hpRTBhWjM4U2tJUmdTU2FQK0EzWmdDMGJVSERX?=
 =?utf-8?B?SGwyNzl1bVp0a0pYQWwrRGFCUTlEUjF2TEpXVkVWQ2tUZkVyTmFKOFV5eGFW?=
 =?utf-8?B?WUQ0ZHlJcXl3bzlqNk1iNUk1YkkzUVlKZ0V0RFdpNExDT3Z1YjFaTmNjT0RS?=
 =?utf-8?B?Sms4YmpZMzhwNjA3NUR2c0pLUFFWcGUxc2pQbm5rSzlPWG9CR2pkVmZwM3p0?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c805d7d1-b266-48b0-4712-08dcee142105
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 18:55:40.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7nylJCjbjft+/soChpERFBonFJPsX26BhfSI/Kr4guRBMSHK8+FNsBh7OSu5eqrMFppjnchNZgrbHSPciULTEt7n6PccjlSouD5K3YvVnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com

Hi Babu,

On 10/16/24 10:32 AM, Moger, Babu wrote:
> 
> 
> On 10/15/24 22:13, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/9/24 10:39 AM, Babu Moger wrote:
>>> dom_data_init() is only called during the __init sequence.
>>> Add __init attribute like the rest of call sequence.
>>>
>>> While at it, pass 'struct rdt_resource' to dom_data_init() and
>>> dom_data_exit() which will be used for mbm counter __init and__exit
>>> call sequence.
>>
>> This patch needs to be split. Please move fixes to beginning of series and
>> move the addition of the parameter to the patch where it is first used/needed.
> 
> Sure. Will move the fixes to the beginning.
> 
>>
>>>
>>> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
>>
>> For this change I think the following Fixes tag would be more accurate:
>> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
>>
>> I think for a complete fix of the above commit it also needs to add __init
>> storage class to l3_mon_evt_init().
> 
> Yes. Sure.
> 
>>
>> The __init storage class is also missing from rdt_get_mon_l3_config() ...
> 
> 1 internal.h _int rdt_get_mon_l3_config(struct rdt_resource *r);
> 2 monitor.c  int __init rdt_get_mon_l3_config(struct rdt_resource *r)
> 
> rdt_get_mon_l3_config() has __init attribute already. But prototype in
> internal.h does not add the '__init'. Looks like that is ok.

I also think it may technically be ok since as far as I understand attributes
the attributes will be merged. Even so, doing so does not match the current
style where the storage class of declaration and definition are the same. See
for example the partner function rdt_put_mon_l3_config().

> 
> 
>> fixing that would indeed need the Fixes tag below:
>> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()"
> 
> How about addressing both dom_data_init() and l3_mon_evt_init() in a
> single patch and adding 2 fixes flags?

... and add __init to declaration of rdt_get_mon_l3_config() ?

> 
> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to
> rdt_get_mon_l3_config()")

Reinette


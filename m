Return-Path: <linux-kernel+bounces-271768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F194530F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5995A1F23AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94B148FF7;
	Thu,  1 Aug 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivaKsImN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792C143872;
	Thu,  1 Aug 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538601; cv=fail; b=dqUdG3IuhXEYZOTzuSa/ngysVJWfy2T77i8Zwc2V0FUuGS1+qmLelYRDT4f4ZLXEgQCEfKjiSTSsGxxSxdXeJ8YKZpMMHKvxd5I66vYeDILgXVOR8AmYJQ7Lq/chGyn3oN5I4yi/+QqN5Ra2B5LrtYtxUptcvKMYxUm9Ve5bIqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538601; c=relaxed/simple;
	bh=bt/K43m5kbe8vh32sKbD/DEowZxr++UavC5PzivCV5Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MtvMeF00dzdHUKKC04BXwBhSsaMY1IEnFIxd0aNFsNraVr5DsGLqWrqQZw/fcVDTPnAd88xn53HicbaXswj6rxoZUG2fIT6JXw/K7AAzb38JJMa96TxJ5ce5ASzMGu8mVy9FF5MnuP9LrdtJwyCz8OHCEOLwt+99WrerAok1cBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivaKsImN; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722538599; x=1754074599;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bt/K43m5kbe8vh32sKbD/DEowZxr++UavC5PzivCV5Y=;
  b=ivaKsImNdNsuFfm4QzAp2GDvg/3MSHgkf+yz8SnCFTMhY5UA3aL5+Rpp
   b1SBrgBD9xyrIpzj17aMbJWKu7iR1iRREOoYs1rTJK6YNTC+vBstRlCMH
   sFo63A/ltKPmHxitIkAaVLURpxyW61hlfhcSI5MmrlECfdqj+1BCMUUuD
   2eJ2Msqu/xdLUmkK4ePle/so8g/bKbLl53o274yz1meK/CbFc7HnoeDte
   PiybJQizUGlkMETJf5rmUD4F2PBKpQkrr096Zz5reRAr+mwqtjzBit/EN
   kgqZOBF+yspEL8SK7d+d7BtfJv1w08QwuhxFKt0RINkJfkzLUITX6EBGh
   g==;
X-CSE-ConnectionGUID: NWSd9PK+QmyzhY81oRuRbw==
X-CSE-MsgGUID: syHn8lT7Qv+2DG+Idg6R8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="31175398"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="31175398"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 11:56:38 -0700
X-CSE-ConnectionGUID: uw903IonQ+Wi/noZFC3baA==
X-CSE-MsgGUID: yAry2NK5TJ6ItgKNznqDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="59988258"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 11:56:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 11:56:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 11:56:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 11:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSEyesPZDEtXZSo/+5inuHXUJ/WInO85VBokW+7Ld5lUkgC/28yUzT2CtJLQLkrwfU40dCanLZ13fNRn9NeVpWerOlrsuEvLKBy1i+DlNo6LEmMhtfgdb9toiXpW/7WYYpqrCK/vAdPRPyPmZLWKS7fBmeFB8kUjUgEdj3y8sDsu4cwsKgEHF4Hs6A3mHTdCpfiOaic3Nn1arXmsHSIeX1tneBlx2u3mKobT4m3xQZub70bLNphg+Sy7WysJ/S752uXYiUAhMCEoo8v+hQPFrhhvkLqtemn4NL+ulKyjFJG/gXCppwLfS5IsVzkppIGMJCsc/L3Zp80E19grcPvx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPRwm0KUBOhN6vrFNdpKvRJXz04T1Jpt0tDiDjr0OqA=;
 b=Fs3HSPLscldIyM7n9d2MfGK+ij9+ByhOqMPTYF/JoUMktSuNb/4RkEyyl6GXjoZThmUX89JHrzlUFqPk7CScH0735ebPh27HHfAptiGG7n9t7NqTDR07k9zSwPkUZvoJLY+SeWwoNH8QyLFERhb+yEOrNzuslQ+9DchlHtf21EiIXntnk8GGSIlpaUZkuhhexNORQpG2ShkT3N4tA21ZtCOqwn1F2Q09mwnb9wuTcYwFcXMXqMYtGINIW9j9rmGB5hMle3YxRPB5iA8PdW3TaRWOWf/PC4bi9L5Esg1JT/IG8fgoWkwDx/TorSV5C1rdUZwFN+kSLICyMHxIFEbqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6486.namprd11.prod.outlook.com (2603:10b6:930:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Thu, 1 Aug
 2024 18:56:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 18:56:31 +0000
Message-ID: <90282397-fb9c-427b-80e7-5bbc325527de@intel.com>
Date: Thu, 1 Aug 2024 11:56:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/20] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1720043311.git.babu.moger@amd.com>
 <49aa5321f6e81825a0e9e44cef06c243634e341a.1720043311.git.babu.moger@amd.com>
 <CALPaoCjL92Jwm=Ynt+pEpSt5KLVxnJL8KOKymZ=WP+cUufy_Uw@mail.gmail.com>
 <54127ad5-8dce-b783-acf2-61bebd0db86d@amd.com>
 <CALPaoCiv9pFg2kzG9i-mVy4D4EP600x38F+WSXR2DqoZ9GjecA@mail.gmail.com>
 <6535bb31-8f91-4b0a-904c-45f320308966@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <6535bb31-8f91-4b0a-904c-45f320308966@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:303:b5::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 81efd39f-143b-4804-b3f9-08dcb25ba7f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWh5Sk1CcnZDQmtqcm15SkJjUkhuaDJHK09FMkRURHljd3hFcDc1ZWVFU3FN?=
 =?utf-8?B?MzJvb21TcmxnbjFxK1pENGx2T2RoNDN5U0hVRjRzLy9RbDBPK2ZBanlnTkVP?=
 =?utf-8?B?YTg0YTJVWHY4MldNUzVsbWlnbjhEQ0NwR3FJei96S2hPclZXdkNvNElHcjZn?=
 =?utf-8?B?UEZUZysvSVI1WG5YYURWZkhCNHlMNkJaME14MnM5enB5NG0rVUZRNkRPMlF6?=
 =?utf-8?B?TUpIWHRXNWNMYUJiT2g4QWVCaS81b2djS01vMUlYd3VkRXBJU3VJdVdxRlRj?=
 =?utf-8?B?TDVVTHBHZkZwSHJXblNjR3plYys4MTNZWkNpMElSQ2V2OEZzWjZuSjczbHVm?=
 =?utf-8?B?Qlc2QW1TT2xnb2tSdjMzdWhpM3YxVytVU0RiSFp1SVBNUzFFK2FxUnA2QVkv?=
 =?utf-8?B?MU0yVE55S2lzcVhMTGtDRGhObnFhT3Zhb2g3MDBqaVdrb3hSeEZ0UFd0Y2ln?=
 =?utf-8?B?OVBJZHJJK3pSSzg0MUY4WGJaVUw2RzhPNUYrSkZDWHk2dC9SRmg2c1c5SXcy?=
 =?utf-8?B?M1Erdi8wRDgya2pSYm43WGx6UDVZUTVjcXRISm90V1YyMGVnbWJRT3NLUXRu?=
 =?utf-8?B?N1N3VHl1c3BIaml6UklZQmNoTzNiYzJpb0xxU1dMZTJQVFR0SzZOM3NURlNV?=
 =?utf-8?B?Zm1FOG1EcGxFNWRkcGtBeSttR242YnBkbjdMM0ZaSVdRZGM5VmtaOHNURWlI?=
 =?utf-8?B?NVpMWXBiZFlqSDBvT2NSenZQWkc2SUl6cHVUQ2VleTRRYSsxOHRFRXNKYWFa?=
 =?utf-8?B?RGZsdzllSndCY0RwcXBzZDZqN2lDdWFCdTc3YlZTN216Z3JodDQ3TjZybE5v?=
 =?utf-8?B?REpSa09lZUZtZGZaUk9yKzhtazNJbXVuQ3BHU3p6N0grZWUyWU5TMUVyL09V?=
 =?utf-8?B?cnNUc3gxbm8zL2REZFZlZ1Ryclc0eDdMS01RaDBEcEZWbjZRVFFqSlZPUldZ?=
 =?utf-8?B?bWxHcU1qOEJjUjhoaENvcDF6di9ndDkybGtBOFBGbDVpWVhOK2pTZmZMNlNh?=
 =?utf-8?B?b3pRNVpiUUdBbTM5NmwrdFMyMHlROWhpak5mT2xreG40UmpyL0pQV2pTR2RW?=
 =?utf-8?B?Rmo1VW9GSGhiMGFUcSt4SCtmRUdVSmNVbnl6anBOKytzTGlyU1B0aC9wa0k0?=
 =?utf-8?B?Y1N4UmhpSXUrZzhuc3JGem5wVkdjNmhIR2JUQ3ZtbDEyZXNqL1g5QUx2bjB4?=
 =?utf-8?B?eFhQUVNpcnMzbWo3TkpTYTFDbUNOV0tFSHMxZFZVYzEwTkI4UHcyb3p6aWhN?=
 =?utf-8?B?OHh5SzJ4UktzbXVEOHhKeEhCTWJNT0VkeGhnMDJJcVhXYW9ScDFrQjMrU01n?=
 =?utf-8?B?ajNuYm5qeWJWdTd0VEZUdVhLbjhndWJzYUozRVFRRndVL2tPalhBZVNpRVVI?=
 =?utf-8?B?dmxUMzhlRHBwQUlRckFaWFJXaXJUbG1DUExxM1lObE4yTkVxRmM0SXZIcTZp?=
 =?utf-8?B?allQN2l4MkRNVlB6ZnFDTmsxVksycFlHUjIwOEQxRFpJVGpvc1cwN2J2c3lT?=
 =?utf-8?B?VElSOE9uZU45TkQ0SEwwTkt1ZmJXclhWVEZlM2NzMHVyVHBLaE1XVHRheDFx?=
 =?utf-8?B?MExNTlB6MjA4SFA4bUZmN2wzOTBvNHdUbFA5QnRWbTB1b2t5WFFwbEsxdGxN?=
 =?utf-8?B?c0FMUVNLa0p0bmZSd1MwVHZrQmJOcFVXOXphd2Y1enVZTXUxNm56Q3g4cHd4?=
 =?utf-8?B?VXlwamFXaVdkRTN2UCtSSUZ1dTkrTXQ2elZRYUlabkpJT2tObWFRYS9rZmNK?=
 =?utf-8?Q?wSQ0DDqxztZu5FEvL0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJqU000TE1EcU9nUHZ1TTJnOFZmKzNsK1Y5cy9TVGZkMzFpb2Vnc3hKckx1?=
 =?utf-8?B?TVZkR2VCWGM2SFFscFhLK0tZNlhuQm84YTR0THVJTDVKUjdLSWlGZEt4czk1?=
 =?utf-8?B?NXFmbFJBZGN1cm9BNWJCdy9zVHJDVTI0d0lodHhocFo5SmhPb2dzRHlWTzRV?=
 =?utf-8?B?ZDN6bWNCK2FCSC9od3hsTGJWcEErdW9ZOXR3d3pvZDkrcmorYmM4bklHak9s?=
 =?utf-8?B?UHdvTGUyNGJzaVRUYnl1VUFPVzV6SUluQzBoSGZ0ejJHc01NNXpCaWJvR0ND?=
 =?utf-8?B?VTJaalJwM2RHRmlzUm9KaU1EaFhRdG4zWlp0em4rc1BDeHdJVHdFN3NpbHNO?=
 =?utf-8?B?eE9VZnJVVDVKNFY0ajNJT0pPNWdhZHZqMlZzTkxweURmemk5ekhnMTQ1bjJW?=
 =?utf-8?B?THdQWGdTY0ZqN1gwRHpEV1lFWHkvYm1OS0dNdEZaVHRxbTFiMnRwdVdMa1Iv?=
 =?utf-8?B?cWNVazFkSkxqeFQwM0lWQjZJNjNtbUphVFVLUGQrVHJ6N1E1ODlCOUJId29S?=
 =?utf-8?B?azlqYXhBMGFCYmxKWVdncWt2dUw4U0J2YTFDcTJGOEZNaFgzcUhycEZZRktq?=
 =?utf-8?B?R2NzdVFOVFdETUtjQjVOWFhqZ3BjUHBIYTk1RkR3NFQ2dHZoSmZ2eTNmNHNZ?=
 =?utf-8?B?MEZpNkFUZ0ZFcnpsVjdUMzFBanBFRTl6Z3Y5R0NTWVJDbDBBaEZDb2taL09B?=
 =?utf-8?B?L0JIR0NCODVoenQ4YnlUbFZQb2NpRWE5akJFdTlWY0U5dmplZnAxZGRVRjBB?=
 =?utf-8?B?Z2syTjVRN2R0VWh5YkdSR0lhWHVQOGc4UCtadlY3YzRQekVaTTdBQmdBRWJo?=
 =?utf-8?B?WTVKZTlJZUNVNHRYOU5xdG9mR0FXM1o1M09tR3NVcWRmbGZkd3gxZHpjRnBs?=
 =?utf-8?B?bUt5QmU1S0ZtOXdWdWRlZEU5R1hXQndCTW5Bbmw2STNlemhiTHVlc1kzMU9T?=
 =?utf-8?B?MDduN0ZJeUsxbnBVWDVacUpVU3NOeWZBK1A0MDdtNHhzWTh4aXFoU2lWRnFv?=
 =?utf-8?B?dXBNZ3V0NmJVMlo4QXRudDN1TTBKOWxObm5lZm5hajYrN3V4ZHRLL2xQNThw?=
 =?utf-8?B?eDk2VEpNN1c3bVV0ejhacGF0Vi9OYkVaTC8yS2VXWXFFTmxtR2N5dWpMZXVv?=
 =?utf-8?B?Wkw1cmdpYVdkMzAyVWlqeUVJRzVDMlB5cXVnem5rNHZTYnJkVFlpQVFCUjNQ?=
 =?utf-8?B?RVMvL0VUeXI5dFVwNVJNY3ZhemRQS0VuWmdscjFZTVdVa2Yrb1hsa2lNN01F?=
 =?utf-8?B?Zi91VXRpRnRzODdPQjlRN3pFL3JLYzRadjZMelREbUlLczAzRVFCZzI1cXBX?=
 =?utf-8?B?OHB6UlhkV241ZHdTbUt2b3lRR2gxVGlsZVZpSVJocEYyaWhENHE5WGlGeTlw?=
 =?utf-8?B?MCtqK2FJeU9Hc2Nxdlg2YUlsKzRjQ0Rvbnp5cmcwUWhFNjB6bDBmRWJaQVN0?=
 =?utf-8?B?aVdmcDZLd2R3cjdSZklEaWdzb1J3Sis0Z3dJbWNJUHA0V0VxTUc4TlUvR3Yz?=
 =?utf-8?B?aVlqM2ZEWTBHMHVQZ0t6T2ptUW5hTFd2UHZuRFowN3lmV0ViMklNY0VicU5K?=
 =?utf-8?B?WStsWG1tNjNZZmlsNkRYTGcybU1kOHEwMzVLaEhKdElQTEdHTktSeno2OTB3?=
 =?utf-8?B?WUJ4Y0RLcEZIWUdvOCtVZTRVOW1Ha0FVdldHZ3doRVZEMzlydjFKdkliNnRl?=
 =?utf-8?B?ZE91eWI1MUNOS0tyN2RUMlNYL2RkUkZMNFV5QS9kNUZzSEFtQ3JPLzAvVnB1?=
 =?utf-8?B?b1k1aTY2em5ucCtqSU5xeDZjZExBeSswZUZ1dFZUOEN3TndIYlYvNkpkUFlZ?=
 =?utf-8?B?U2I1bVdQWlkzUGdKN1g0cnk1QzZ0dWswaW1xWW1OakRXaElDbXZmdHlWcTFY?=
 =?utf-8?B?Y3FMRlE5Rk95ZGZYZ0QvWWk2YTVrRjI4N0xtTHEwb25WTTg3d01DMTd4S2Va?=
 =?utf-8?B?dHJpbmJFbktDek9scHAxU29MdWNoRWl1M1gzSk1iQU14dWFEdTA5OUZPeVJ3?=
 =?utf-8?B?NG5jWmNtam9ESXJvakNxMmJlSmd2OWpTK0FOMGRMZlc5NXhHWGZGS3dVVXlX?=
 =?utf-8?B?VHA2ajcyMEU4ZHNBZmY1VkMxa0xJU0duT0Q4dk1xYkVHUVpEMEUzNnlyV1NJ?=
 =?utf-8?B?ZHBMaUpmZXZ3UUFoRlFQdEliWk5HZElOTENFVXMxRGEvVERHUVRrclJTWWZW?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81efd39f-143b-4804-b3f9-08dcb25ba7f0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 18:56:31.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YE+Bk4ubeYY56KGPBZPPPM4iPmODpKHguC6y0niGwx6F7lYTV7TlGtXeVErzkeB9op655tKpkpZJ2VQNOdcEl+UfBlTM3pJPi0e1iZRI22E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6486
X-OriginatorOrg: intel.com

Hi Babu and Peter,

On 7/25/24 10:28 AM, Moger, Babu wrote:
> Hi Peter,
> 
> On 7/25/24 12:11, Peter Newman wrote:
>> Hi Babu,
>>
>> On Wed, Jul 24, 2024 at 6:23 PM Moger, Babu <bmoger@amd.com> wrote:
>>>
>>> Hi Peter,
>>>
>>> On 7/24/2024 7:03 PM, Peter Newman wrote:
>>>> Hi Babu,
>>>>
>>>> On Wed, Jul 3, 2024 at 2:51 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>>
>>>>> Introduce the interface to enable events in ABMC mode.
>>>>>
>>>>> Events can be enabled or disabled by writing to file
>>>>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>>>>
>>>>> Format is similar to the list format with addition of op-code for the
>>>>> assignment operation.
>>>>>    "<CTRL_MON group>/<MON group>/<op-code><flags>"
>>>>>
>>>>> Format for specific type of groups:
>>>>>
>>>>>    * Default CTRL_MON group:
>>>>>            "//<domain_id><op-code><flags>"
>>>>>
>>>>>    * Non-default CTRL_MON group:
>>>>>            "<CTRL_MON group>//<domain_id><op-code><flags>"
>>>>>
>>>>>    * Child MON group of default CTRL_MON group:
>>>>>            "/<MON group>/<domain_id><op-code><flags>"
>>>>>
>>>>>    * Child MON group of non-default CTRL_MON group:
>>>>>            "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
>>>>
>>>> Just a reminder, Reinette and I had discussed[1] omitting the
>>>> domain_id for performing the same operation on all domains.
>>>
>>> Yes. I remember. Lets refresh our memory.
>>>>
>>>> I would really appreciate this, otherwise our most typical operations
>>>> could be really tedious and needlessly serialized.
>>>
>>>>
>>>> # cat mbm_control
>>>> //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;12=tl;13=tl;14=tl;15=tl;16=tl;17=tl;18=tl;19=tl;20=tl;21=tl;22=tl;23=tl;24=tl;25=tl;26=tl;27=tl;28=tl;29=tl;30=tl;31=tl;
>>>> # echo '//-l' > mbm_control
>>>
>>> What is the expectation here?
>>> You want to unassign local event on all the domains?
>>
>> Correct.
>>
>>>
>>> Domain id makes it easy to parse the command. Without that it parsing
>>> code becomes  messy.
>>>
>>> How about something like this? We can use the max domain id to mean all
>>> the domains. In the above case there are 32 domains(0-31). 32 is total
>>> number of domains. We can get that details looking through all the
>>> domains. We can print that detail when we list it.
>>
>> This sounds like only a minor simplification to the parsing code. It
>> seems like it would be easy to determine if the final '/' is
>> immediately followed by an opcode (+-=_) rather than a number.
> 
> Ok. Will try to get that working. Will let you know if there are
> complexities with that.--
> Thanks
> Babu Moger

Dave suggested [1]  "*" to indicate "all domains". This seems an intuitive
addition to the interface to accomplish this goal.

Reinette

[1] https://lore.kernel.org/lkml/ZierjRNDMfg5swT8@e133380.arm.com/


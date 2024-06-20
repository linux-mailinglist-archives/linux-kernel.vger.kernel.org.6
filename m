Return-Path: <linux-kernel+bounces-223638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F21DD9115DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4591F24049
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AB8140378;
	Thu, 20 Jun 2024 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWnglapk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F27149C65;
	Thu, 20 Jun 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923807; cv=fail; b=omlHQGIgBxUywF/gCFQrjw7J+OiNeMYICySX4RRkcrbnToyl7+AbBaDdrFB6askkcCiqhVSwy7XbimuvHZnN9OeK6E6xDjTCfxJosK1OQ84pZePLoz6XJmkt0pArCbGq/bKCakt/NMJ4JpP0WKB1lYP3C6mQT9oV2YlCjsW+Itk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923807; c=relaxed/simple;
	bh=YwMQukSmepSUPOhbkrv0GTvZTnzz7Mna1yKsz6DtSZM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dbk6txyTFXOU6NGX9e12I/lrHFUGde/l3Zc5DhcE1PQfLplFCAucA29+BmmUgtQTWiDxk6nZtyX6+UJNYjr+JogV5KMGQf8tFkxPpAcsypsLUU+uW6dIfoyNKflBxfnbVHCJO5+++GDnn9f86D9cUkJGNrRnLadX9SezLdJUJpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWnglapk; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718923806; x=1750459806;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YwMQukSmepSUPOhbkrv0GTvZTnzz7Mna1yKsz6DtSZM=;
  b=SWnglapkJotMsy0VNuL2zwhieaLdhFW7z+2CbR93/EgE880VSN8QaRKH
   47qjFOweBjFbZkHp1mK+Z1r3s/etSZ2IQPXE66kEci+L9x2BCBBTmk/OD
   w2/FX7HXMCFXcqTlMYClqT1S84+C3ZZHnTKUk9u6fn+fOFlS53VjLCEQL
   3o0A+G+OHMXVNB+0zjH7U55TouhAjPcysSoAWbbWS3bsp5chEyw0S1m9B
   IZodlg7QIWbEDaIQ2xLiLvNyzFXAqTgrP8JYCyyAl9iOIAopQqO4lPfA9
   nskGhSU/uqyEOrtXHUt5/wgJ4Jl+ttJb5UIw68A0E/2lt7V2xm0j4rf3U
   g==;
X-CSE-ConnectionGUID: Jdw5Ey8XRiu1TZssVwL9Yw==
X-CSE-MsgGUID: /nmrOYuYQ3KpyZ2SSPLXDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16082717"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="16082717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:50:05 -0700
X-CSE-ConnectionGUID: dRMRyKWpSLej4Fs9oTLkcg==
X-CSE-MsgGUID: CTLcpkr7QYiCyTtgp8QgdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="65641501"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 15:50:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 15:50:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 15:50:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 15:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZv3n9LB/tbtap9HhLA5onqLuU6jbyFdQV/J147+RlrFZUcL1k2cbK50iUKuPROwbcphVrsimbg8NSt95sosZb2fIFKx5kaThf2e68uWF67fjLxg8d5JzXYsGa9VNWSa54i+QbwJACBf877Lo3Az7IXsM3AbiodMA3fDRtE9x0mpbfpVx66vMKONplVMP3gBio7L2/7X22MjNOEiKs8U8fSunFdPfP52JEJATDoedWTlL8mcSt+UUfEZZ9ROAkAea2e4gbEOQw6HfzCVDuiViwaWNgcrgC8v/CSip8H0AYH+tJOysnU7Rzd+Wpxkv8OxCCTPgW0Cn8AnsBNaAknVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c6fMFACVvpy05UgPPesvI67N+bvkGbHji2+1dMKqHg=;
 b=ctvvBarmGANhHUIYNcRcOMKHg5aLz/vSlKNEI0xR2baWm0wapbX8UBkNa76V+yYT9Ta46Q8NNFSg6oXrTWbHTz6wDbHxjGU0SB10W2vTveMC2RkgPb0196aUjh4HxKDNkDIMjKlLB8muhoJdz36+R9U0At6u73UDMpTI+PhnixQ3d59BGxtpQV3gYeGqRtgGJ0LZTILqYbYcRDqNBPHcWTCAbd+NWcpSUVHDFd/23Q+HAplQsLtTIRL16Ap0hRJhCPHZU0T7iZB//iBzuwn38sVAWHLxopxJNnejSsN4nyo05/Ytn5/ALUr8gIoecLnZVNdqvo2ZTRkYoi93TbDvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 22:50:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 22:50:00 +0000
Message-ID: <5789ec24-3633-4e9b-8b1d-595d27e1eb8e@intel.com>
Date: Thu, 20 Jun 2024 15:49:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/19] x86/resctrl: Enable ABMC by default on resctrl
 mount
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <74f014062885d707701873527c1b12268603a525.1716552602.git.babu.moger@amd.com>
 <b722c5da-812c-4ccb-ae7b-e7bc9c9de50f@intel.com>
 <343960a8-b364-44b1-aebf-ebb7fe0a1466@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <343960a8-b364-44b1-aebf-ebb7fe0a1466@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2054b2-19ae-468c-e052-08dc917b5107
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXlSR1lxMUVGSC9Nb3dvSFpFMjJkMUxvL1JiWktKVW53bUZZZTVlUm8yMDRY?=
 =?utf-8?B?UWd4b1daTjhzN3dBdTdwQlR1WHAwRWpnMWltNTJUcWNobnJLOXdDRFlMZDlE?=
 =?utf-8?B?WEU4VmNUU25waUQyWlNyTzRtYytrQld0R2ZlSUJhOVZTS1FuN0JCZnlLYksw?=
 =?utf-8?B?cHZVZTdXZFVuVXFaOTRBS0dkUGFLVW1TY0luNGkrS29VUnVMRWxMVmJJYVpj?=
 =?utf-8?B?dXFBMWdWMkQxeXFmMStPelFIUjI1WVovR09nUUUvQW1Fd2J2Yk9PMEJNYjI1?=
 =?utf-8?B?c1ZDRWtZMXJpMUoveG13dDVaMEFYUFJHWS9Zd3RjLzA3a3ZWNXVPVS9IaDNF?=
 =?utf-8?B?MXF1dHV1bjFUSDlnZFoyaWpmZnQvSDA1Tm14TlVUeUsyQU1VZk1iRGRJelM0?=
 =?utf-8?B?YjUveW9sSGtXcVM2SFJmZFNHYTRYTnhTVnpYMndnUk9DVFMyam1vWmtrNGp6?=
 =?utf-8?B?bUI2d2FpZXZSbndBa2JEL1RiL1pPeUluRXV2NDNobi9IaSswT01HMGJZR2dH?=
 =?utf-8?B?eHllR3REL2hvNWRwVFQ5MEpvdHlpK290Z291bTFTbGhiQVp0RjBwUFlWUXJy?=
 =?utf-8?B?bVZRN2xueUc2TVBpanRRNDNua0EzZmJNK3gyaDZIKysxVFNWdEN5R09WZk1p?=
 =?utf-8?B?aDZBcVF2SENTUEN0cHd0Qlh1RUg3MG9jWXhEYktVYm1FcjUvSjdWbzNBUDJz?=
 =?utf-8?B?RmVlSEtRR0NkenE0NzhQa0ZsUW9BakR6TnpzVVU1WTB6dFgvRFJuTThlSi9o?=
 =?utf-8?B?ZnhGaUpwV240V0tmblRkRzZXTHJYR2xLbFNBU3dUQzE5OXVzQXJkcEN4Q05C?=
 =?utf-8?B?cXNoaXp3RGRXKzY4aTdvRy94R2Y0ZWxoaWg1Ry9EbGpHUzROZkZ3eDBiUXhh?=
 =?utf-8?B?dTltVEtaRlFHVjFBSDZIa2VWT01nMkl5WFJFVDJONVdsY3RyVXIzdEltZjJ4?=
 =?utf-8?B?dzJ6dU0xZEtOZnZqenZNVjZ4SjdaaGNxYnlaZkZZWFhLVXc3a3ozU0xHZ2pt?=
 =?utf-8?B?V0NEN0F5VVlCYTZpQmZ6NWZEMzhwZGhoc3ZMTzRNbkxKcEwrNEgrOU1XTnNV?=
 =?utf-8?B?bEw3ZXRYK0Vja0NxOXBRNmw0YW1aOU5TRS8rYmsxV3hoUm9SRlpnL1BZRFVP?=
 =?utf-8?B?R3ArMkRjQ3RhaDAvUm9EdTAxb3c1K0dCTjJEQ2RucW1sWnlFKyt5NHhBRVhi?=
 =?utf-8?B?OUl1R1dzZUZyU0h1N2thb01XNHJtT0FWQ2IraGFKM2NwRU9MZDZCZ3JSQXE2?=
 =?utf-8?B?K3pDTlNIL1NsdXdha28ydHoyQlpRVHZzYmhxUEt2T21xeGhNWFNRVG5PU1Zn?=
 =?utf-8?B?RncxcHZTNzZBbEt2T1JVZ3c3c24yNzdGSy9kcVgybHNMREJYM3BCMTUvbUNT?=
 =?utf-8?B?cGt3RURPb2k2ZG5kVWJCTVZmZzdBbGpmcTFDNUxtRmFQQVNZMXhOckh3eFdz?=
 =?utf-8?B?ZXFqenh4bXFWOWpkMllERzg2TTZhWHNNbnBCRkJWS1VuVHI2SHd6ZXV4VzJI?=
 =?utf-8?B?Q2VacHgxUWJOMEtBeE02L1JpMk0zWU5GZnh5dlVJUWJGVmp6a0R0TkhYSlJ6?=
 =?utf-8?B?Uk9OVTBSUGJrSVlORnRnS3dFdXM4U0p0YVpkSG9lY1Bwc05OQmk0QWRnL1p3?=
 =?utf-8?B?aVRRbnZQS3psbm9nbnFNb2VnRVlHdUFCVzBPeEc1ZUV4NWdYZ3pES2cvRm5F?=
 =?utf-8?B?ODBpY1NOVktYUnZjRFgwc2dVamVULzlBTGZqeGpLNmlOaGhJSk81alNlRVFZ?=
 =?utf-8?Q?BMTRQs18j8NE70u4TlYWbHaPU9V0FCMsR/xiacG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzkybFd5cWdnbFd1VGIrSDFnTHBrQmx0Z2dOeStQOHlDemFQMWVidGNsTDlC?=
 =?utf-8?B?OFVKNnFsUHFST3lBVGJXRlk0OHZwY0RBQXlBbjJ3bERhSytEOWg5YlJJQ3gv?=
 =?utf-8?B?Z01IcFd0K3ZTV0lYdjdNTUJJbVIzZWh6b004TS9CakVyUGlkWkQwTlQ5Rzdu?=
 =?utf-8?B?UXltYkRwN1hGOHFRMkRzZWxqRUo3S1B0MmhoSndnZS9NbHN0NWxmTjNwVUV6?=
 =?utf-8?B?ODAzbEFTZERDVTdkNG1MYi9heFhCMEd1dnEvVHVMVU13bm4zc3BoYmZOUWlJ?=
 =?utf-8?B?Zzh5am4wL3RIQW01QStwV05jTFBOcUZEaEdOd2pqdlNyc3lVSGUxVVVxRExr?=
 =?utf-8?B?QU9RdGVndnp1R05lUnZCaXRiM3RyclZOZW1ic2dLMDJYd0NlLy8zNmZGaHp1?=
 =?utf-8?B?ems3cnl4TXQ3anRSQjhVS1k4cmNvNU5wQjFhanE3UGx4TE9yVnZlZzVLWVpL?=
 =?utf-8?B?Uk5HZUc3Y2NIQjhFQUp6cnpqWjcwSWx6RWtyTmpRN3dBSEZ1OElVUEl1WFJk?=
 =?utf-8?B?ZEk4aWFMY085cEM5QzhPQTNLcVZibHQ2ZU1LdVZSa1ovSHlHOUhCcE15UFFq?=
 =?utf-8?B?c3I4VVhpdkpNWDFXTHdyd3d0TktGVlFua0pmRnhXdm1XTUVKOXNWeE9YVHNS?=
 =?utf-8?B?eXJoZzRSMkc2bFUwbzIvMHNOU3FPZ1QzU2FOY1hoTVZPUUlwODhtempBMXdY?=
 =?utf-8?B?SWpIQlFMb3JidUcrWllkQ1NpWjFUcytQL3JwbjRZMW4rbDdQZWRVbzkwNFNS?=
 =?utf-8?B?ZmF3MGgzMXB3Rnl0bEJ6b2ZmaldmdGdHWjR4VEFaNGZZNCt3R3BNalNvd0V1?=
 =?utf-8?B?NkQ5MjZFb2Zkdk8vOUwzZ09mc3ptM05aSlBEZ0lvQ1VMb3F2Q0s4MHV2a1Np?=
 =?utf-8?B?dUhpNkIxeG5iekxTMkdkUGVUenJlbjJoVG54eWZDTUdlRytpODZ4LytUVm02?=
 =?utf-8?B?MDEyZDhIclduNy9pamtvdmxVM3pHcmRvellHVWdYb0JKem1UWk9RZjFmNkJx?=
 =?utf-8?B?NnZyY1FZbWYvUWF2SUFIRGlJbkllSEtBRmd5cmhtVEtBeXJiUnFmVTZWdGFO?=
 =?utf-8?B?bjBST05uK29ub1J5TDdFUmtSbXI3N21CcVZzSjBEOUNZNnJGMVlxUjNmTXgr?=
 =?utf-8?B?L3h3MjlQa1NKS1I1aFlhQkx3NERQYzU2aWZmVFFBbjRSZW1EQU5HV05iZCtW?=
 =?utf-8?B?VDVSSTAxdzcxVWhoY1J6T3VycTZGcDJoeUQ0UVU2U1ByS2h6bHRNOWVldmt0?=
 =?utf-8?B?YlBqUXlJN1VPTWJQbm9ReXl2c0ZmWDdmdDZHZVltSHdSd2pHS29CbW5McmdO?=
 =?utf-8?B?ZHhIVmtSU1Zsc0lXMTNXbVJrbERITzlKMHBpNUYzdVhjNGRkYmRISnYrUDUr?=
 =?utf-8?B?SVlMRkozRVM2N1piL3BPR214bnBFV0YxMXJndHM2V1BVblY3SWoyWU9mbUpj?=
 =?utf-8?B?NmhzTXhWenF0eG90YXkveCtYTzRNT0VheFg4WVg3ZHJIQmt4SWdZZVplSmc4?=
 =?utf-8?B?VVBjWGtIK05wdHlqVXBFb1JWWUk2V1JqMmYraXkzeDNGL28reW1ac3JxTm04?=
 =?utf-8?B?SG5HN1crTHN0eWUwcFI5cEVGNEMwWlRGQWJQWjI5TkJ1akZROFA3UE5tdjE4?=
 =?utf-8?B?QzlnRlVWRkJWaURrMDk0S0VaVjU2dVU5UzgvdmVsNTh6dUc4UkNEcWFjN2tx?=
 =?utf-8?B?M1dXc1VHajFLdU5jTmp1MUQ3VmhKQzRSOHZGNW1ib293NFM2U1QzWFlUUkxP?=
 =?utf-8?B?bVZqNmZudzJGZXF6ZkxOQVFxZU9qSS9hY0E0a3RiUmtYQ3M2V2QxbDEwVEpM?=
 =?utf-8?B?S2phK1M1V3Z4U1YrdHUxV0hEc1hMMDFRSUN0V1cyM1VQMFhSUHcwWXIyV0Nm?=
 =?utf-8?B?WWxEY3k5dE1CcnB5OGNMQ1VRVnZaL3IyNmNOczA1VkJLWVhNQ0xEMW1ZN0dS?=
 =?utf-8?B?dHZmVjQ2Z3VCUW11NldnQkpzTDUxRmR4cm1zU2Iva0RPWVNxcjBzYXh5cVJW?=
 =?utf-8?B?cURkMEtJdGoxVFZrRlJCWXA3TENmODRYSHBOSXFGZXRqNUNrL0JqaTNWNGY0?=
 =?utf-8?B?SzBIQlZKcUxDd2U4bDFMM1hGcVhWeEUzZGx5NHE5WXhndFAxTmttSUlxaHpv?=
 =?utf-8?B?WDZBdkcyajZLZTlSQU5HSEpiZjZ0Z1VBdWlLeWVlMGRxRWwvNTVJWVdYNmJH?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2054b2-19ae-468c-e052-08dc917b5107
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:50:00.7682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixlquLctxNT9dWKNQW6HJ9T82K5gxORK2W6GfAYmBCA/0LysGCqQ0LSKTD1fga7NdCkz9E59BfVpe7LahaPo7dKAM9EPfhJOmYwzqQJoBHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com

Hi Babu,

On 6/20/24 7:46 AM, Moger, Babu wrote:
> On 6/13/24 20:50, Reinette Chatre wrote:
>> On 5/24/24 5:23 AM, Babu Moger wrote:


>>> +        if (resctrl_assign_events(&rdtgroup_default) < 0)
>>> +            rdt_last_cmd_puts("Monitor assignment failed\n");
>>
>> How will user know that there is a warning? This does not return an error
>> so nothing will prompt user to check the status file. Perhaps add a comment
>> in the docs to help users at least know that this exists. Another helpful
> 
> Sure. Will add text about this in the documentation.
> 
>> thing will be to have the counter return "Unassigned" if it has not been
>> assigned
>> since users familiar with old interface may see "Unavailable" without
>> knowing that user action is required to get a working event.
> 
> Not so sure about interpreting hardware reported error.
> 

I only see "Unavailable" as a hardware error and that is already
supported. "Unassigned" is not a hardware error but instead indicates
to user space that no hardware counter is backing the queried event.

Reinette


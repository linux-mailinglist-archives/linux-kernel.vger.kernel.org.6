Return-Path: <linux-kernel+bounces-214156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF990804F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D261F22991
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D8B64A;
	Fri, 14 Jun 2024 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fe0DTVoq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F849441;
	Fri, 14 Jun 2024 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326461; cv=fail; b=C4JgAvLD33Kp3LcfTc4ZBsMZLe51gHpl66Jo16+3tOkIsgbdISkJ+6Xl3qpM5avQLnAYVpUHjMj/HrZjugxCRr66FzSnopksyyBM39C6aHvLBgHHwDjmrBoF5t0FfU0OhlCd1VHaETQSy8wh7ZMXYOs+X1Js5/U5xCxiW613K5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326461; c=relaxed/simple;
	bh=pMBL3hw6JRo2xY1zcxtzn+vL66S0QGvV3Gk58cQKcp0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X3aFRLAuZGx/Bn6FvATt7IFn2lLFRtj8pnOcOFpa3aAz43q1FcKlZvvHEIiGhlLYAff3ZOt0VYEsXPW2+drAFliXSkSAJJ1yK5/k2Vh4gIQvcOfdqlvGbyq3JYpXjIZQmsQErCEobN7BTP+MQeEiI5B821d/QDT/MGA+Lc+Tskk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fe0DTVoq; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718326459; x=1749862459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pMBL3hw6JRo2xY1zcxtzn+vL66S0QGvV3Gk58cQKcp0=;
  b=fe0DTVoq7r27Sk6p9m/JL47VSYjmrH8tsqD8m0gEBs/lYl7WNZmyXzjf
   20BmiaKerQ688Q1g58Ze4MvEpjAwVdsHv06Hgyqc7W4FJucGqZrd7G+lm
   BdWloUh6Gs6ZZowUJkoeoVM4/TTD1FixWKRM8PrfwsOrJz03GYQ4VejYc
   6j4ud9WgUpZ4PeTZ6ZOzgAA6lgcdPF0wEDZ+Qi8XlXw/9FfmckhZc459V
   mPSECRequ+wE+KL7DzPJUhpWy/7Ks2dxL6oONzBBOO0+ZCtk8YRoTshV8
   3hk9iQ3DftoTCzzyPEZhYXA+8XQFNnWoRm7he8jzvv1xV7XD6ipWrNY2+
   g==;
X-CSE-ConnectionGUID: LL5lwcpdRw+6Uj2eZlrAlg==
X-CSE-MsgGUID: 25TwImpGTeWygO+9FWOfPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15030129"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15030129"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:54:18 -0700
X-CSE-ConnectionGUID: 3g3+y7e6Qjar5+mivLEw1Q==
X-CSE-MsgGUID: WPnAznbUQXGWglactjyTjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40444642"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 17:54:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:54:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 17:54:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 17:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntvwgiovFuiO1qkByQvEmbnGSb2L5oGhsF+CqvJ5IXl6/lft7yEDy7jRVUyg2PQpetj5QCIldjpWdtlBtN4MStOB2HYtUWEEfXwovOxXgltCJoCriKQnhlk+WsPib6PgshJ1IHFbHPI0mLMydmAcW78J0kC+1aBJnxxduZ716kIPl7qKYWg+a/LoOnfwfKorGUDHOO7qWdW9+QXFlHUAz1ik4zNU6L3nN41QwXVyN7Bb76zPklLv5WN36o8OKca7Dk0oANpA4LPhjF8rW1Nf1YQQ9Suxn/zl3Bb8/tUwFioTlVZBNqLRfb2BrvfamrDndFnQgbvSsWTok6XsvRIb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZcyNFIrulwjT5cRRh4ghsAqG58qz3f5G58e91UCwQE=;
 b=gmZXPs55h4JAfNSDpOQvlCuMRxB46yLcan625hz56NPxbTYHKKyF3aKr0juSRCYIsNiw6fv49p+djCjARhTTQOJnW7OFDMlGudOg5iKfAj9GaETNcCfMDNXtbogEnXfPlCzEn2b7TkTKFDe0Zdi/XFm9NpohR+dXaIJEsBbeRO5NFXL0i/sPvcr3SuTMJ1bD0dOPTe7n2+XERwouQ1QjEApFONP6FU+FiH2htCnni9h3nsXb028r4m+UEn44praTccYY6pJWVKcY01ZFRnDnJytSuymPYeN1GLCuHrhc8CnU1lSPQRUTorTbTqe4g2z7nfpDqs7NyL+qJ+fdMv0dBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 14 Jun
 2024 00:54:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 00:54:13 +0000
Message-ID: <2e488812-671e-4aa9-a292-c54b174f2dd7@intel.com>
Date: Thu, 13 Jun 2024 17:54:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:303:b6::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 73786075-cd76-402c-5655-08dc8c0c8266
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzI1TUNhQTh6alBzRE1OK2ZRbk56bDV4a0ZHQmk4N3VQeVdGaUZyc3lwRG4v?=
 =?utf-8?B?WjBHMUN2Mmc0WExNdzBLVDMrU1ZHYkpIWEVRbXl0Zmg2MG1EWUN5Tmw1aHQ4?=
 =?utf-8?B?SEJ5QTFXa1g0dGNNWHlkRTBmcXlJaktlTndrVzBpbmZ1SXBNLzR1Y2djLzFU?=
 =?utf-8?B?UEV2a3BkcmxwVGYyQ1pLRFpUN1NYS3VnNjl5TTEyaC9KYm93Ry93QjNPOW12?=
 =?utf-8?B?K1ozd2c2Zm9uZUVRQjVhQzFIWEdxT2o5bkRTNWltVkpGemxBT1RxN0gwU2U5?=
 =?utf-8?B?cTB4MnlHdHhyWS83N0FPR3VIeGJwT0ZLSkl6ZmNQTlJDTEo0MEpEelJtQzJx?=
 =?utf-8?B?c25idGcwUzNFWmZldm9RN2dZUXQ0Y0ZubGg5dzVCTThNMjRwaDY1VXV0QThw?=
 =?utf-8?B?bEowSnNBSDduMHUxR0JaRi8rekYxRklxK0lBZm1CK3RqWUhUK09JYmhjcy9k?=
 =?utf-8?B?ZGpXejJNT1BoV2E5c3FtdFpMOUY2RDZlYnpldzA5Zi8wSXdUN1hKRUxVUGQr?=
 =?utf-8?B?eldkMTlnRE83dHgwN1B2QXBSNVpwN3ZBZkh6K05vWGxIVk9DRmtRdlRyU0s2?=
 =?utf-8?B?RUtITmRwcGVPb1N2cUkrNEZpWTZlTFo1RkthejFNeXRheWphVSt6b042MkZs?=
 =?utf-8?B?cWZZTEJYRERHdi9BWXBHWXROWUdNWUIvMnc3ZG9yOWEwZmk3cjZNM2RXOXBi?=
 =?utf-8?B?b3VvTDZJR1I3Y0F6WDNhTWJxNWVNcGwrbFpKNFhJNVI2Um1aODBRMHRZRUQ0?=
 =?utf-8?B?R3Q2dnArK1ltQlpMM1FvYjRNV3A4QjlsSnpiM0JvOXlNQm1uM1BwVzRYSkxP?=
 =?utf-8?B?WkNnVkVhOVRLMGpybFdONlJCMXF0MjlMQmZydTVZY2d4M2tvRXhEOTdsSTRT?=
 =?utf-8?B?S0VUUGRjVlJnQXNCT0lMMWpETW1YTjUxZHRxMVl4Q3ZMTnkxaC9hSmZMYzN3?=
 =?utf-8?B?d29zTmcxK1d0a3FweWFtbm1tUk9WQXE5ZHgvbWM0STNxeFhUMnZEZGpudHJB?=
 =?utf-8?B?NC8yZjNOY1lUR1pLY05Pc0RFZFhkQjJLUUR4VkFNWlh6RGVZT1lBN1gzNXBT?=
 =?utf-8?B?VnYyZGNSMkloQURzQ3F5bitqM3E2MzhrVmthMUQzRUYzV2MxYS9vWWVBWG5H?=
 =?utf-8?B?dEhUZmxDR2FudDVseWxsTGdtUXJQYU5OaHIzeEV2STVyK2lHTGVpNmJ0Wkdx?=
 =?utf-8?B?eC92dURtMU9QZUpSQXhtNTF5dEg4WlUzbFRweituTGNuc09KR2JNSUN4QVFX?=
 =?utf-8?B?VmZUU0g5eHhpWmw3NUdaQytWK20yUUlBaERrSXQyTXpoRFRObXd0eG9NL2NL?=
 =?utf-8?B?WWppMytuTkpNTDBlRStSYmpnOXdabit4RnY5bk5hV2pXSzNqYkxUaE9teWNV?=
 =?utf-8?B?bXFSbnhoRU84cE8ycG1VREZsMFlwRGhJWnRSTTdMdVZ3eEdHOVE1S2FwdVlm?=
 =?utf-8?B?K1M3SlhOZnUxNEM3UHdzT1JxZ20vdThaWEgzbWNVdHFZY3FFNlJndFpsRkJz?=
 =?utf-8?B?aGlMSmptejh2RGZOVEhidDR2WDlNUlM1dHBZc1llZFZlcjhGSkNIa2lzSDl2?=
 =?utf-8?B?TFJVTWdVNlRWNHpSQk5MRWNwZ1dkV2tVcWc2clBlWmx4Nzl5VDFJWjdxV3RG?=
 =?utf-8?B?aWR3ZWcxNDVBWHNyMjFsR0l1R3h5Yy92S1Nwak1Pby9rUzBJbXJMWXdsTzVa?=
 =?utf-8?B?UUppQVpSU3dwekZ4aFl5SldocmxFWDByUHBJMzZKZGJabmtuWU8wVTdtK050?=
 =?utf-8?Q?HX9B8QybViah081qZA4fJZILfghdNqU5u/Xe35X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFgybjE4ckdyNXd5RFo4MmRjRHhrOEszMTRvaVFrNSsvS1ErZDNWMWp6N1dQ?=
 =?utf-8?B?cGZmWEhNV2RadUdzcXN2eFZTK1Fxbi8zSk85T2c0K2tJMDVJNS8vL1NXWnda?=
 =?utf-8?B?VzZ1QXFCTkZCdUovQ3pNNTkwaGIvTEhSSEk3YkU2VHcxbWcwWXFhVEdSSXF5?=
 =?utf-8?B?Lzl4am1zcWQxWG5DaVNzTmxmaDEwZHpXT0pWdVg5Rmd6VzU5U1RkVEw4b29I?=
 =?utf-8?B?Y1NFVHdQRWxVanhkZ0xxNTV0Y3QxSnhkbWhuREh0T1p4Z0lWL1kzQldGaDFV?=
 =?utf-8?B?aHM2SnNxbHl4Q1RGOWtseGhDVUpBYlZQMHRydTZ3NXJ6ckFVeGw1bzVCNjBs?=
 =?utf-8?B?SUtvbVltZ1B3VjJXL0xzSVQwSSt6Qmd5SWZSSjQ1dkU2RHNac3p3RE9EMmhR?=
 =?utf-8?B?MUdaMU05bDRyMFNxOXA0dmdyY2oyRnNsK09xU1JFTTVQWHg1MGswYVZNUG1E?=
 =?utf-8?B?Zm95SThGR09mL3RCcVNIMTVrakRHZ0tUbUZGajFuTkE1K0xYeE05REVJK3lr?=
 =?utf-8?B?ZHdxMGp4YTJ5bzZMSzFEMHJhbkovYVhBem54aEJuSFExQzV2OWZBbkdtUHpy?=
 =?utf-8?B?QitmN3NONExZL2c4R3JMdS9BT3dVSFVBOVk3WlNvWENUOERaQkVGZmZYdHpk?=
 =?utf-8?B?OHRNWitQZkEwQ0kwNSt4ZktRWUVJdFRQcHFDUzh4T1dlWlh2NHhnYisrb1RM?=
 =?utf-8?B?akJQYng1UWFtVGhrQnVCdnZkMmNSQUVMbTVSTlhuZ1dmSUs4bVFZUjh1UkNV?=
 =?utf-8?B?Y3lUUWIyZkpZMVpkT1BOc25INCsrZDZTNDZ6L1dUS25pM2oxZWQwN0NNTjJi?=
 =?utf-8?B?czh4OFZucmcxODNlMWFDQ0dpdlk5RkdWdkNHc3h0Rzl3OWNxUGh1MUpxeDhw?=
 =?utf-8?B?UHdQdmFPelIyZHV6KytWMFlOZXJpZERlbE5idlEzQW1CNUpWS1hPamdncW54?=
 =?utf-8?B?NmVjcFRUcTJ5MEMySW5JYmZiQ2tPVUhYemxMVU5WUnBvcmZIK2pvclRSeTFG?=
 =?utf-8?B?cEc2Q21KSWlXUW5EUlI0c2VlRk5iNEEyQlk2WEZhdUZrZ0k4ZjBEVnhOMHhx?=
 =?utf-8?B?bzZ0NjVLUlVldXBOdHNPY2RiNmxHcWFaZ1VxS1lqNmJXRHByblVNNjkraGZR?=
 =?utf-8?B?Y1JXaTdGcm5SUlN3MFVUelpsLzllbmlFbWFvUHEycUIyUFYvcGZLcVo2VjRo?=
 =?utf-8?B?c2lFM2lSZ2pSOC9idVM0K2xQYTZnemFyR3p6dHJSd2pFODZLVndtdUtQRDFt?=
 =?utf-8?B?TC9ESEszWDBXU09ocXF3bmxTYWh1a0VyOXlzTEhJWDRheXUyUVdMQ0dFNGVG?=
 =?utf-8?B?WEFrUlptdWp3UE0yR29RR2pRakRBVVJkeDV1UG1KSmh5V0lhd1JBNkZhTjl0?=
 =?utf-8?B?U1FSVkJMT1UrN0lrbDIzR0dkMERsa0hjWkVuVmxDc1QyUjJvODVzTFd2dmdB?=
 =?utf-8?B?RlNYb0VKaTRBS0RLR01uZ1BiVUVhOVBUVUlRcnFmYnhTMTRXdjF1WlltMHNr?=
 =?utf-8?B?WW95SHZmb1dnakg0c0RVdmE2K1c0SmIwWlhwQmRCMFAzOC9HeE1Ed1BpZm5G?=
 =?utf-8?B?WnMyZmRXMGlSNWdVb1hKdStxUDYvbStMeEUvcTIyKzhYK3EzbUlUVldUcmZs?=
 =?utf-8?B?cVF0ZE0zc0wvT243VGIrK0ozY2t5di8wbVlsM05PMXlaV3NtWTNIVHdtaHBD?=
 =?utf-8?B?M09YZUIvWVBJN29weUVKcmhXUlhTcGl5bFRRQ3N3dFVoQksyZUw0YVB5dlJx?=
 =?utf-8?B?dGNRUGt2U1RZNzhzU3JWeUcrcnpod3lsNkVrcklQand6dHFMeGFlL2xnbTdD?=
 =?utf-8?B?Q09MYUpjbFdvSVJsb1VKNytEVlh5bndoSi9VODJiSGlra3F0NG80VWc2MzVE?=
 =?utf-8?B?NDVwUWlLVEM0Q2w3cjJka0xycTFacWhoVzR2cjlyQlcvYWM4clN2US92UXAw?=
 =?utf-8?B?TVo0N2VqZXZRZXlPNXVrTG1pSG9XNHZJMTZQcU1WOTR5T0krdHdIVUFQMzBo?=
 =?utf-8?B?MjhIZDVrQ3UwdFZkaEQwWjZ2V0tuNHB5VWgvak1mRDlFdHFrSmVuUDVyM3ZL?=
 =?utf-8?B?R3poZFpmNTk0Q2ladGdiQ2Vpa1Z6M04vM2REc3ozZS9DT1M1TytGcmxaVmUr?=
 =?utf-8?B?SWl1RmFvNzNnblpYWVUzcU5DeitaY3ErU2lNQjJEcnFUMStCeVZNWWlheUZF?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73786075-cd76-402c-5655-08dc8c0c8266
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 00:54:13.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pierdD35ZuE8V0eV/wWxyPaC+i5h8+yxl1+aOyb1lItNq+RsDYvXEHpX68VPaesZGyIJyI/bXyyxbemRBvP7hLQn96+iM0kvxhEIuzQ2hhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> 
> 
> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>     to list and modify the group's assignment states.

There was a lot of discussion resulting in this centralized file. At first glance this
file appears to be very complicated and I believe any reasonable person would wonder if
all of this is necessary. I recommend that you add a motivation for why this file is needed.
Some items I recall are : it makes it easier for user space to learn how counters are used (no
need to traverse resctrl and open()/close() many files), on the resctrl side it makes
it possible to support counter re-assignment with a single IPI. There may be other motivations
that I am forgetting now.

Also, could the name just be "mbm_control"? What is enabled at this time are "assignable
counters" but in the future we may want to add support for other flags that have nothing to
do with "assignable counters".

> 
> 	The list follows the following format:
> 
> 	"<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"

"assignment_flags" -> "flags" ? (throughout)

> 
> 
> 	Format for specific type of groups:
> 
> 	* Default CTRL_MON group:
> 	 "//<domain_id>=<assignment_flags>"
> 
>         * Non-default CTRL_MON group:
>                 "<CTRL_MON group>//<domain_id>=<assignment_flags>"
> 
>         * Child MON group of default CTRL_MON group:
>                 "/<MON group>/<domain_id>=<assignment_flags>"
> 
>         * Child MON group of non-default CTRL_MON group:
>                 "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
> 
>         Assignment flags can be one of the following:
> 
>          t  MBM total event is enabled
>          l  MBM local event is enabled
>          tl Both total and local MBM events are enabled
>          _  None of the MBM events are enabled
> 
> 	Examples:
> 
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=tl;1=tl;
> 	/child_default_mon_grp/0=tl;1=tl;
> 
> 	There are four groups and all the groups have local and total
> 	event enabled on domain 0 and 1.
> 
> 	=tl means both total and local events are enabled.
> 
> 	"//" - This is a default CONTROL MON group
> 
> 	"non_default_ctrl_mon_grp//" - This is non default CONTROL MON group

Be consistent with "non-default" (vs non default) as well as "CTRL_MON" (vs
CONTROL MON).

> 
> 	"/child_default_mon_grp/"  - This is Child MON group of the defult group

"Child" -> "child"
"defult" -> "default"

> 
> 	"non_default_ctrl_mon_grp/child_non_default_mon_grp/" - This is child
> 	MON group of the non default group

non-default

> 
> e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control.
> 
> 	The write format is similar to the above list format with addition of
> 	op-code for the assignment operation.
> 	
> 	* Default CTRL_MON group:
> 	        "//<domain_id><op-code><assignment_flags>"
> 	
> 	* Non-default CTRL_MON group:
> 	        "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
> 	
> 	* Child MON group of default CTRL_MON group:
> 	        "/<MON group>/<domain_id><op-code><assignment_flags>"
> 	
> 	* Child MON group of non-default CTRL_MON group:
> 	        "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
> 	
> 	Op-code can be one of the following:
> 	
> 	= Update the assignment to match the flags
> 	+ Assign a new state
> 	- Unassign a new state

Looking here and the implementation it seems that "+_" and "-_" is supported.
I think that should be invalid. Only "=_" seems appropriate to me.
Also please take care to not have a catchall "default" that does an
unassign. Doing something like that will prevent us from ever being
able to add any flags in the future.

> 	
> 	
> 	Initial group status:
> 	
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=tl;1=tl;
> 	/child_default_mon_grp/0=tl;1=tl;
> 	
> 	 To update the default group to enable only total event on domain 0:
> 	 # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	
> 	 Assignment status after the update:
> 	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	 non_default_ctrl_mon_grp//0=tl;1=tl;
> 	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	 //0=t;1=tl;
> 	 /child_default_mon_grp/0=tl;1=tl;
> 	
> 	 To update the MON group child_default_mon_grp to remove total event on domain 1:
> 	 # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	
> 	 Assignment status after the update:
> 	 $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	 non_default_ctrl_mon_grp//0=tl;1=tl;
> 	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	 //0=t;1=l;
> 	 /child_default_mon_grp/0=t;1=tl;

This does not look right. Why did domain #1 of the default CTRL_MON group change also?

> 	
> 	 To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
> 	 remove both local and total events on domain 1:
> 	 # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
> 	               /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	
> 	 Assignment status after the update:
> 	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	 non_default_ctrl_mon_grp//0=tl;1=tl;
> 	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> 	 //0=t;1=l;
> 	 /child_default_mon_grp/0=t;1=tl;
> 	
> 	 To update the default group to add a total event domain 1.
> 	 # echo "//1+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	

Unclear where "t" flag was removed.

> 	 Assignment status after the update:
> 	
> 	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 	 non_default_ctrl_mon_grp//0=tl;1=tl;
> 	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> 	 //0=t;1=tl;
> 	 /child_default_mon_grp/0=t;1=tl;
> 	
> f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
>     There is no change in reading the evetns with ABMC. If the event is unassigned

"evetns" -> "events"

>     when reading, then the read will come back as Unavailable.

Should this not rather be "Unassigned"? According to the docs the counters
will return "Unavailable" right after reconfigure so it seems that there
are scenarios where an "assigned" counter returns "Unavailable". It seems more
useful to return "Unassigned" that will have a new specific meaning that
overloading existing "Unavailable" that has original meaning of "try again" ....
but in this case trying again will be futile.

> 	
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	779247936
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> 	765207488
> 	
> g. Users will have the option to go back to legacy_mbm mode if required.
>     This can be done using the following command.
> 
> 	# echo "legacy_mbm" > /sys/fs/resctrl/info/L3_MON/mbm_assign
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>          abmc
>          [mbm_legacy]

It is confusing for the value written by user space to be different from
the value displayed: "legacy_mbm" vs "mbm_legacy.

This is still missing information about what happens to the counters/events on
such a switch. Will events just keep counting? Will they be reset? ...?

I also think we should try to find a more generic name for this file.
"mbm_cntr_mode" or "mbm_mode" maybe?

> 
> h. Check the bandwidth configuration for the group. Note that bandwidth
>     configuration has a domain scope. Total event defaults to 0x7F (to
>     count all the events) and local event defaults to 0x15 (to count all
>     the local numa events). The event bitmap decoding is available at
>     https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>     in section "mbm_total_bytes_config", "mbm_local_bytes_config":
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 	0=0x7f;1=0x7f
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
> 	0=0x15;1=0x15
> 	
> j. Change the bandwidth source for domain 0 for the total event to count only reads.
>     Note that this change effects total events on the domain 0.
> 	
> 	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 	0=0x33;1=0x7F
> 	
> k. Now read the total event again. The mbm_total_bytes should display
>     only the read events.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	314101

According to doc, right after a BMEC change the counter will read "Unavailable"
is this not the case here?

> 	
> l. Unmount the resctrl
> 	
> 	#umount /sys/fs/resctrl/

Reinette



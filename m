Return-Path: <linux-kernel+bounces-214197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C690811C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3A31C21573
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE081822FB;
	Fri, 14 Jun 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAroIbhQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055981822CF;
	Fri, 14 Jun 2024 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329855; cv=fail; b=oavcYQRtiK/RuIba87G2HVyNRjUu0Ig5Zwagz3yBfvspADM8XhYCKWqBrsHnWjPvyV1ex6SKck0dC1s+38N4b4i4HI/D++KxM+aXk/kDesdGMfBHVoi95BsKpFKTyS+/qlxVoc3iHZm42WckeWST94tIaazEkcQvksvIelzHZNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329855; c=relaxed/simple;
	bh=VJ4S7OVAPKzy6UCnTE2Ep302e7/BxMlT4cYsbuZ2WD0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKUxUuF/CgQW9kxf4OAeEcAi0mqhx/sFalKL6v09Ym66Uy9G6X5gsCI/Vheuv+Kn3hzqr4SHwdcmJD3CmBchdTDQGn7UZOKH5X0vCTKrJEVHU94dg3ZBzdD5idGShMa8PxzYpi+DwdiIlUcbMwJATaCN5qgNWcvVQ4CJ8REq9ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAroIbhQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718329854; x=1749865854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VJ4S7OVAPKzy6UCnTE2Ep302e7/BxMlT4cYsbuZ2WD0=;
  b=UAroIbhQLQ+yZmi2t7XeHh12YiWL3o7r+jnak6STg5mNchadnJbPHChC
   EA5EDwm/hBzc/jBruE8EAdTcYphxcYsCs97MRJwEeulN+TKq1wMX4//8J
   OFTyQN5PWmKL35B7qZIp8L7DvjIwHBlXS8zneO8p/k6gF7HrGkXpheIGf
   yJWETZuE/MIoLadZfvWLHLupkcGocYjuGg2ctov7C7C82ctA/ifHr/yuS
   0oYkW4C6hFDrYnZndA6Og7/qFfTce/bRE6CiBYHZ0sARbrpcrKVnX7LHK
   QYrAOO1wIAu1b5rHbpb4Lr6YFgjc2DHGgFGeupRC85hsJSYwCdgSp0CGG
   Q==;
X-CSE-ConnectionGUID: 5CeZBleeTvGxMPH+4LOImQ==
X-CSE-MsgGUID: G/CoB22JQ0eLn69H6gG/Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15349202"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15349202"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:50:53 -0700
X-CSE-ConnectionGUID: Fm7WL0aURLe+CaLPYWObnw==
X-CSE-MsgGUID: P8CQtO6oStit7yggqZE53w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="77822592"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:50:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:50:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:50:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:50:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:50:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1OoLLUFK/VeNfNLK8M3KMepCvlWz2+rR3KphW7iW49BbX/f2vNjrsPvNHjKuKn6cO5jE7hEaeeNTe0L8ZndP3PrXCZg5KSGI3o/P7t0nkwP/hYqhx1Gr42CBxk9sNvyg81fRYMmtc2HOffhZ6YMuf2vUgkkQePZUFhcjybEd2mJgwzUOjdirEKG2DEhLyMqN8ORvKmkx1VZNrE3wz08233MC5x4vE/DCZeJNzjcdH5RLL3/JmUrQ/lqRxr5qABzNA1lSr+sRkyEx2FxLD/EMapOhCNOJzRu2i9L4SvhYrEZBHnDFcEJjdzMEupYuDtRPXqiRD2JOzNmhwfDYKS0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsbDHCs8mlut4z6tYbNZX8KHb8CmoN2YCy2rscGUz6I=;
 b=h9zavJdiyGngU2z1h/Nzt9crdegQm2lZZDqMlj+N3pnipd9apYV06bGWjUXuqvCHy8WIt0lFxPikwlFnqp1qhUTk8Zw14aS0cAP94gceaZV8lx7hqLFmIag2Td0401xwVDylRgf4clG0BprOs4/pUodZZM9hjFOG+Bopsc1fakB7pTY9svcWulgWj3KFlMaMMzV2YuvlBodS9yWzORuIi+C6xDB19I/I7ABZEmOvGaKodENzjVcL5RWT88oJjYrBqBbKHQXWC6Bg8PIqcUGA9Exw5tblFE2w8k4JNrGYmmN4g2tn5Ms8024kFSqy4IgfE0mAKIAjc77Syx5se81t9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 01:50:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:50:47 +0000
Message-ID: <b722c5da-812c-4ccb-ae7b-e7bc9c9de50f@intel.com>
Date: Thu, 13 Jun 2024 18:50:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/19] x86/resctrl: Enable ABMC by default on resctrl
 mount
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
 <74f014062885d707701873527c1b12268603a525.1716552602.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <74f014062885d707701873527c1b12268603a525.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0272.namprd04.prod.outlook.com
 (2603:10b6:303:89::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a2a129-9b93-4983-ed4f-08dc8c146948
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1IwVFlKaXNJbVJUR3RYd0ZpMGFmaFk3M1YzbHArK2QwTE9FejBtNFBFQVRq?=
 =?utf-8?B?RVpkWklBUHRFaFhGUW9xRXVZcm11WStvYVlTNFZ2VzdpQXhaV1BHUzhqWVBp?=
 =?utf-8?B?QlMzUHRubXZvNGVKMzBWMVhzUDNOcmxOYWxTblJzWkxMOXVvUmlnOGg1ZUVo?=
 =?utf-8?B?VHp2QU1OdTFjdzRGcW5raUtqYXg3SnFDZTRJVHpGMWdlNW5oTEhFT0NQTUda?=
 =?utf-8?B?a05HS3dLaVhTSGQ1aCt0czhFWGc1NkZiN1RXdVRSZ2lrVUhnWG5pVEJWcVEr?=
 =?utf-8?B?aUJNY0FyeXhZbWNyTlRNRFVoMVVBaGZqL21IY2FWaDZ3TmRpNS9wY3dZKzls?=
 =?utf-8?B?ZGtXd2ZVTEh0RmxvTHQwdTZ2K1hpZmM2MEN3VjJIOHFmOGVTUFd6VXoxUGNi?=
 =?utf-8?B?SS9kb1c2ZnZ5bVlLVFBydENVdGpHRURMNE8vWmg2MjhXc1RUaHZuMnNWZ2Jk?=
 =?utf-8?B?Z3p4cWVLMHA3OW9qZzg1Y0FFSEVEZnlKaTZpYkRvVXV2QlZzZDhxUE0rcXRF?=
 =?utf-8?B?SEtxRVl0MEtDdFNpRlVHNEtqMEJLS2trbExjVk9Ody9BWW0zVE1sNTFvMXBq?=
 =?utf-8?B?YXprdVRFbk1yS2tHajZqS1hQSGk0NnVsbjBTYVI3cjl1a0t2YTY4S2U4UHUx?=
 =?utf-8?B?dGxhaHRzZ2Y0VGZvWnFubGk4YjNJMm5Vdi85dTArUnNidXV5cS9lOFVneEFL?=
 =?utf-8?B?UDgzREhrTlRROEtscjg4MEgxWG9CWm5JMG5EaU9FVHF6b2NHRGJiOTlhR3Fa?=
 =?utf-8?B?VWozNlE4djdiNXFTSTdRTWFDbHhKNDcvaWlKVjVNM3BINVRFWEdCejhjNTJH?=
 =?utf-8?B?cm53MUF4NXJpZkN3QzlFWVJPSnF2VVphYXBVcmJhdFZ4TE9KY1MyaStTTi96?=
 =?utf-8?B?dHI0dHV6UW1vdGVWNHgzdmVWTVdQMERqMU8rbmN6QjUwd0I1ckx5VFgzdWM2?=
 =?utf-8?B?VVJxTytIbW03YU1jY2tlZFArUm9aMXBDMFFIanYyYlREd0hNR0tFQml1bzZ4?=
 =?utf-8?B?S1EwbERtd0c2NjFiVStQTk5vQXZrTkdQVnpFWFdacS9VVUp6akQxcHNiNk9q?=
 =?utf-8?B?b0l1dURaZWI3dnBFL2RrRzByYXZpaVJiSDREeWpzL3I4UmJCUERHSXNRRXMw?=
 =?utf-8?B?cHBGMExkR0RHUzQwOCtsQVhRZVVNQTg1enp2dmdiMlcrVDJrajh2aVVYbXRq?=
 =?utf-8?B?ZGx2NTlnWVROdlhib0k0TU1XanBCMlo4OFJKQ08rSWdmaGE1R3RKMUZkbnB0?=
 =?utf-8?B?eE51VmM5bmJLYWZ4NTNuY1NmbGkyQUI3SXFEQ0M2YmQ5RXRHVGQ2L2Q2VFl3?=
 =?utf-8?B?dDVHM0tnU1FBNEwySDJERWZhR3ZDY05tODNUcWJ4eTNJYUdHd1R5RFdKYXlo?=
 =?utf-8?B?cERnZEd6T3dHbXNqL1hTOXAzYlJ5bU5UMDdKMDhsaWh0c21jZmJhaHAvREF1?=
 =?utf-8?B?WEdvc24zUFZOZWdOOFlSRFhMY1hVTFpIVkVuYWNTeGVUbmN4ZFBIczF5VHUw?=
 =?utf-8?B?L0xTZUtZL2drRTVkaHNpT0lTV3lwRVZWYWFBZDgvYjQzNUMvQ2dlNnVhSjVL?=
 =?utf-8?B?WXBCYTQ2eU0zeDJFUVdZN2o2cDl5TWo1NWVPUmhsZFVKNUR5K2RvS3E4OFU0?=
 =?utf-8?B?UGhlNUI3UWxrZE9YR1RIN0JpSUplb0dFMkpseG1VZXhXb3Zwc3pyTC9tbnBX?=
 =?utf-8?B?dTZTRUpJNDYrdjAxN0lIUU1EV3QwYWhsYkYxUlV0enVrc2VTelZnSnpjbkJJ?=
 =?utf-8?Q?ismWpvhMlkdkeAf2J4xGrsgN3UTrc/etOUiL0ki?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU9mR1RVeUcrRHJ3OG9samdLb25TT1RRS0ltYUJob2hIeHpsNHBmUzN5ekVL?=
 =?utf-8?B?eEI1aHpGWUhuNjhrWHFNd2lQaElVY2lvN2xLb1I4RVJBQlhwYUJWMW5BZUdZ?=
 =?utf-8?B?S0oydmRURXJmYm1QeVplSUF0U054RlptbDFPQ3JDSklCVGhZVStGUVByMUxJ?=
 =?utf-8?B?NVp1T1RkT2IrcE9xbnpPVDIzVE9VSWFlUkJJZGozTGpENWpxdThMQ3J0dEEv?=
 =?utf-8?B?Wnd6aGorekZQblRXeWpIYVMzTE02VFBhRU84VzhuaFlxS2sxY3p4MU4vMUR1?=
 =?utf-8?B?VXYya1E3eURrTVBvT29jT3M5ajV6VXQvVGlhSTRURFVXNm01WmFISTYvNXc2?=
 =?utf-8?B?ZlRBTmxvRHUxZE9rcUZUK1pCOG1NczlhMTNXRUlGTklqU2k0R3NPc1pXNmZw?=
 =?utf-8?B?c09XZ3dKMUM4c3Eycng2NGtpS1dxL1VLdW1Idjc1OWFUdkJJOWViVXYyNm5T?=
 =?utf-8?B?cEZUWjIyT3JodUM1cUdLQU8wbGhndmk0bXA5ZmtxZnhQZ0RoNGo5V05sYlhv?=
 =?utf-8?B?NWsyTUlJRlJacXdxQUlFTW9PRnFPc0ppTm1lKzlMRHVFOXRYSEZLcUZEb0tM?=
 =?utf-8?B?QW1zbDBrbW0rbyttV2czdGNZTlQ4SGlZYmxhck9BMSs0UjhWeHNlQ3IzQXdS?=
 =?utf-8?B?MUpySWNBMVhlQlRJOFB5N0VuaXB3b0RRRk5pY2IvaVN1Sng2S3NGbEV6WW9H?=
 =?utf-8?B?aTBNZVBLcE03ekl5L0IvdmFZdGFZbjdjdm5rOFRIQmlzeGYrYVFtclhTN002?=
 =?utf-8?B?SklzKzRodERSRWlpODNEUDhoREJtanl6VHBrMDM3a1RFTHplK2NTS0hzM0VN?=
 =?utf-8?B?TkM2SGdpUFRTT2N4OEdQU3VwT2szK3lGak9YNkxudmxMWTcwWEluL3cxSnV1?=
 =?utf-8?B?c3owTndVcTN4MHNiYzV4WHdtNXk1R0xtRDQyZlBGZjZER0IzcFhkcUNSREJH?=
 =?utf-8?B?eHlsNWpOTDEzNTdzV2hzdXVTTTY2ZGJyTGdCMFFpU3ZwRHRjSjlxR2ljaVFk?=
 =?utf-8?B?NHp2d0dlREhOb2VMSVFnRFdkSkFPSVRNK2hoaURUL2VZMzc5VkpSOW5aTVh4?=
 =?utf-8?B?VFRteWpqMm5IOTJEaEIxUk9kRVBmcEhVYkJ0d28rSHNvUm91NGJvREY5MENJ?=
 =?utf-8?B?SnpLSm1ScGc4NkR6WXR2TXdJOWhPeDNjTERUN01ibXZRWTVSWmhxSWNFejNl?=
 =?utf-8?B?clFpRUhpd0w3VG1vL2V6SXpTelE3Rk9pak1NYlp3aGovUnpXZ2pEM0NrbURU?=
 =?utf-8?B?b0RpWk92MTg4ZmEweThPenVCdy80akZ2emRtZU42Qm5HOTFKYitXTlNzZXpp?=
 =?utf-8?B?c2ppK3dmbUwyR0N5anNQdldpVERNbGNrSlVxNXc4aXlZMmJNR3p6dVNpSWls?=
 =?utf-8?B?a3AxUTl1TUpGS0MvazFsbWRpNnY1VzZ2ak9vK3l3RElLazk2M21rN2ljeVdj?=
 =?utf-8?B?NEUxNVRJckhHZ1BnY24vZFVBd1R4dHdLTnFGb3RPaEVLdDRmYUluKzkvSWcz?=
 =?utf-8?B?NllsSlpDN1NlWWJtSFNGNG50YTJhSDR3OTRxK3hDZVp1YytKNnl4MGl4endp?=
 =?utf-8?B?b3lCYzA2TGpTMHk3SGJHL1NoVDE5VTJsT3ZWanYycU9QUU4xdGRGQ2tWdDJO?=
 =?utf-8?B?UWRsKzZvOFJSUjV2TzUvK1pXcUZlb2ZQa0N4Sm9SVExCcGFCbHFpRWppV2Yz?=
 =?utf-8?B?TEFsaFFvV3BFNlZWNGc2UnBhVnVVa1FDTW5OdU15ZFhxRmJ1YzM5MFgzV2hP?=
 =?utf-8?B?aWtYQmM4QXgxM2tXbXZxZnVHVmtPeDNlVSt2bHU2dGlHMnpZTUJma3U4NnRj?=
 =?utf-8?B?bE81QmZmbk9GTmVmdkMxZVFwcWs1eUNCa2ZCVmhTNDMzVGZKTkIrQTRURGYz?=
 =?utf-8?B?RHhoaGZ5T3RRVDQySUVhakxWNmQ2bFB2ZVdXcUQxRzUya1puT2ZWUy9ERVBS?=
 =?utf-8?B?c3MzeW1jcER0UFl5QUtWUFJpR1YzdEhNUnFFRzBHbVNtaUl3RGVCSXVveW8v?=
 =?utf-8?B?ZmJjOHJJU0RNY3dibnppK0Vpd3VIdjA0RUluOXJxZVY2ZnArOTBIS3UrVjRx?=
 =?utf-8?B?Z2crUFR3R1VRQlVvbk9iTmQzWUVHRlVQZWNOeEFPYXRQdHZWRy8xSGs4ZjFW?=
 =?utf-8?B?MWFXZFJwTm84TitZcHhIalMzVjBwamRQc3hsMjBONjVqZFBlSm9wNU5BUHBx?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a2a129-9b93-4983-ed4f-08dc8c146948
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:50:47.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxcJltPVKbpEfRcOgPh5ZW8ts7LKuIYAE5zZywJaKGQj3nGAE/iEVpqHzVcTTSfCpk2euLb/Vjc9eOxtxpmZ83GYMJDWQuJ3TkOrOeekfgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> Enable ABMC by default when feature is supported.

Why enable/disable it on every mount/unmount cycle though? Why not just
enable it at the beginning and only change if requested by user?

> 
> Counters are assigned automatically on group creation. If the counters
> are exhausted, report the warnings and continue. It is not required to
> fail group creation for assignment failures. Users will have the option
> to modify the assignments.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v4: Few name changes based on the upstream discussion.
>      Commit message update.
> 
> v3: This is a new patch. Patch addresses the upstream comment to enable
>      ABMC feature by default if the feature is available.
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 69 ++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5ea1e58c7201..f452b6d9bb99 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2756,6 +2756,7 @@ static void rdt_disable_ctx(void)
>   {
>   	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>   	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> +	resctrl_abmc_disable(RDT_RESOURCE_L3);
>   	set_mba_sc(false);
>   
>   	resctrl_debug = false;
> @@ -2786,6 +2787,8 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>   	if (ctx->enable_debug)
>   		resctrl_debug = true;
>   
> +	resctrl_abmc_enable(RDT_RESOURCE_L3);
> +
>   	return 0;
>   
>   out_cdpl3:
> @@ -2882,6 +2885,41 @@ static void schemata_list_destroy(void)
>   	}
>   }
>   
> +static int resctrl_assign_events(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	int ret = 0;
> +
> +	if (!hw_res->abmc_enabled)
> +		return 0;

resctrl fs should not be peeking in arch structure

> +
> +	if (is_mbm_total_enabled())
> +		ret = resctrl_grp_assign(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (!ret && is_mbm_local_enabled())
> +		ret = resctrl_grp_assign(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
> +

This function needs a comment about why it is ok to return with error and
partial changes.

> +	return ret;
> +}
> +
> +static int resctrl_unassign_events(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	int ret = 0;
> +
> +	if (!hw_res->abmc_enabled)
> +		return 0;
> +
> +	if (is_mbm_total_enabled())
> +		ret = resctrl_grp_unassign(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (!ret && is_mbm_local_enabled())
> +		ret = resctrl_grp_unassign(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
> +	return ret;
> +}
> +
>   static int rdt_get_tree(struct fs_context *fc)
>   {
>   	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> @@ -2941,6 +2979,14 @@ static int rdt_get_tree(struct fs_context *fc)
>   		if (ret < 0)
>   			goto out_mongrp;
>   		rdtgroup_default.mon.mon_data_kn = kn_mondata;
> +
> +		/*
> +		 * Assign the monitor counters if it is available. If it fails,
> +		 * report the warnings and continue. It is not nessaccery to
> +		 * fail here.
> +		 */

nessaccery -> necessary

Please elaborate why it is not necessary to fail.


> +		if (resctrl_assign_events(&rdtgroup_default) < 0)
> +			rdt_last_cmd_puts("Monitor assignment failed\n");

How will user know that there is a warning? This does not return an error
so nothing will prompt user to check the status file. Perhaps add a comment
in the docs to help users at least know that this exists. Another helpful
thing will be to have the counter return "Unassigned" if it has not been assigned
since users familiar with old interface may see "Unavailable" without
knowing that user action is required to get a working event.

>   	}
>   
>   	ret = rdt_pseudo_lock_init();
> @@ -3214,6 +3260,8 @@ static void rdt_kill_sb(struct super_block *sb)
>   	cpus_read_lock();
>   	mutex_lock(&rdtgroup_mutex);
>   
> +	resctrl_unassign_events(&rdtgroup_default);
> +
>   	rdt_disable_ctx();
>   
>   	/*Put everything back to default values. */
> @@ -3752,6 +3800,14 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>   		goto out_unlock;
>   	}
>   
> +	/*
> +	 * Assign the monitor counters if it is available. If it fails,
> +	 * report the warnings and continue. It is not nessaccery to
> +	 * fail here.
> +	 */

Fix copy&paste here and below.

> +	if (resctrl_assign_events(rdtgrp) < 0)
> +		rdt_last_cmd_puts("Monitor assignment failed\n");
> +
>   	kernfs_activate(rdtgrp->kn);
>   
>   	/*
> @@ -3796,6 +3852,14 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>   	if (ret)
>   		goto out_closid_free;
>   
> +	/*
> +	 * Assign the monitor counters if it is available. If it fails,
> +	 * report the warnings and continue. It is not nessaccery to
> +	 * fail here.
> +	 */
> +	if (resctrl_assign_events(rdtgrp) < 0)
> +		rdt_last_cmd_puts("Monitor assignment failed\n");
> +
>   	kernfs_activate(rdtgrp->kn);
>   
>   	ret = rdtgroup_init_alloc(rdtgrp);
> @@ -3891,6 +3955,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	update_closid_rmid(tmpmask, NULL);
>   
>   	rdtgrp->flags = RDT_DELETED;
> +
> +	resctrl_unassign_events(rdtgrp);
> +
>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   	/*
> @@ -3937,6 +4004,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>   	update_closid_rmid(tmpmask, NULL);
>   
> +	resctrl_unassign_events(rdtgrp);
> +
>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   	closid_free(rdtgrp->closid);
>   

Reinette


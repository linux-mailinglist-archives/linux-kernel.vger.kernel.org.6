Return-Path: <linux-kernel+bounces-251203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4971930209
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5288B1F2278F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387754757;
	Fri, 12 Jul 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xe80cQrH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB051BDC3;
	Fri, 12 Jul 2024 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822539; cv=fail; b=bMHJdSLOQTyJeMonO67biWgYXer1WDB2Yhnixwm1IkI03eDnkTLJRqsfbKICmySurDewredWTf5poxnC0/ti8X0+V9MinO3cSPQPsSQsdYlhCjL0t8BEdlU28/wv4UKXQgvJnPL3euwPydTZ8G/6BD69C2Pj1tM2JH1mpbnHwfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822539; c=relaxed/simple;
	bh=NbCEVBcm4bR0zxH5J6fqFbJ5umiO7w0BgYZNjqfWUrY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RJOE0bLl6wquvZoOqj2D+IAmWD0oqD5pUdn5hcAjoK4BADPNdOoxXL30pOIicic4hyv7UlSWJ9xcpAQGKWWmzorvwQWevyRRLspFw38JpVDPd8q4f10XY7HrKcpxC/jlFN+ehlBBqBMzb/D6GELCsOyOWfi3Ezu/5D9Wbpj9xBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xe80cQrH; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822538; x=1752358538;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NbCEVBcm4bR0zxH5J6fqFbJ5umiO7w0BgYZNjqfWUrY=;
  b=Xe80cQrHBPAcSnxw2EkPKQPmuD+Iox4TWxfYB4UySJTkPlxDhO99Esch
   sjuNVvbZQ78v5N7Z++u2/+JtjbKp6F3PfAcI1Bloxb2NDeFu2FQT/R+dK
   aPn/WYwZMxX/C2StQBfJvokuOBgJq9vKcjW1IuVMJx08M+4QbRJ+mwzqr
   X82NoLIUZCeCy/RJDTDp32XjxsBD9kA9L5M3CN/tN9AYc7dj0jJylv50q
   D5XnxBPiKJGy1dGdeAPBR60c6NOP4J0XBcyGKuQskvPLQDfdrRTU9FsSO
   ldPzkswF0QOi2yN/59UOXulWkCRiEoZviWAVSk4eDDSvRgiG/FXFBjXDx
   w==;
X-CSE-ConnectionGUID: ovX0Zp9NQXKPc+H1TA+wkw==
X-CSE-MsgGUID: 6tjucx9CT96VfWsXZSbxbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18413581"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="18413581"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:15:38 -0700
X-CSE-ConnectionGUID: OGXM6luoRA692XvNGOI9Jg==
X-CSE-MsgGUID: 0gbYVMP9S4Szy1ghFg54zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="49032846"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:15:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:15:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:15:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:15:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZ7/9PFVwaaz1N8bIrASA0GWVEBXh+vDAtQovV58JAsOF+ahbRgJ28WErbBtcaEsjR3Hqb3hi+iZncgzA8V6VoQp8nUOubRKo1qxy+uQugOsMgbRJTFeobyKbIwaCnpx9hs844NhtSOIAy/6UL5LE/k0znM9EMjxLdBGFeAeN1ABriqnWIPfbPBp85AILK5Frg4Fk4QbpbO5nfrwHzLlDTfykipPzPtooixZnpQ84eLG607G24pZ73KTSOKQzMZx34XUtNwwMGWG2cvMmR2vWVQa4AVsbmpeZMtvX+Oei7KGt1vZzZONvU6fZT3+eR5jxB/K6CsIHw2YqgxpssOaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y262UrCRq62aqYHlHIF3H20vkB/oSIClICJw9LZl7IU=;
 b=p56lEwuvYfn5vZIWyAUdc8b1irPULoT/bjcfndp5HBDgRuHACYMoMIOZxWNL/CxNw3lVTIBgdh4ciUcNmrve/eIcCQLyJlIBY5BmBRJdaQGy002+9sqg+L9a2P30Jo9z6W9f5CzVITsiCndcclENILTqdV2VM1Au6CLUElJQuw4Fc6IQxeDrdImq2Asmfk4CHcz58XIO7VZ9mMOeVS7Hzq8bp5UPb23D9Bd0rKGXG8Zi+Qo+Qmczi+SmUYH7+0ywOjixI33HmH9Pu6yrnKIOZ7WoZ6VoliSMpZVpQPxhuUIwy58qMYtGy1RdOU3sxmFmqH2gDDeKPCgr370X61rgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 22:15:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:15:32 +0000
Message-ID: <d9de1a56-8b0c-484e-bf44-69891a2e9894@intel.com>
Date: Fri, 12 Jul 2024 15:15:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/20] x86/resctrl: Enable AMD ABMC feature by default
 when supported
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
 <9f03d5661a4f054124cc7ae1903207714c5188ee.1720043311.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9f03d5661a4f054124cc7ae1903207714c5188ee.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d92640-0cdc-472f-c7e7-08dca2c02528
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1FaN2drSmVtVGllMUpiOHpMR2hWVkZHRXdkNW5na2NSMHdOcDNRR3BoaTlE?=
 =?utf-8?B?amkzdDd6THNialAwQS8zRmZnN3JUVXdIS1RzVmI1YU82N0o4R2pwM21LVFU2?=
 =?utf-8?B?NnFkeTVrSkVydnFaWngvb05qU0UzZnAzRU5Va2FKKzZsLy95ajZtUHhJMUpZ?=
 =?utf-8?B?cFBDamdpKzNxcmJDLzFERk5yVmZZMklZdGVXM0Z4TktPTXREaERqelRyL1U5?=
 =?utf-8?B?KzdtSzZOb0RxUUpKOEpiUWQ3NHVTQzZ4T25STUNFcVpXaWJkbjFvd1B4eTFv?=
 =?utf-8?B?ZC9mdDFsOUhWMjN1YnVzQ2Jsd0J3eHUvS0dxU0F0REwvRS96OFZHWUc1dEtN?=
 =?utf-8?B?NEhyR3lmOFg4NzMySDlLdW1TTFlHdFhOTVR4Rlh6dzdxOHlUcUdNamZsRnNW?=
 =?utf-8?B?Q0NhbzdEM3R3d0lZbk5mZTRQbHBYTDF6Skk2bWh0amJRYVNlSnN4UlhuSXZJ?=
 =?utf-8?B?UnpGaFgzR2U2S0dCTjhUM21lQkFIRjNEbFFDbVo0emdPZWZLQUNJckZ2UFI5?=
 =?utf-8?B?eXpPWEdudTZHdS83djM5MTdlR1ZnaC84VloxWkdRbGkwQkd0OGlteTlrZmF3?=
 =?utf-8?B?eDNIWjBTZXhnQU9OQ1lReTJHTjg5SGVpOWFiZVVFdElLT1ZtVisrT0FBYm5O?=
 =?utf-8?B?TCtDbHRtamU5TnB6Nm14QXBObXlpNklleUFBK01ieE5zNjRreFhWRWNlcFhl?=
 =?utf-8?B?RkwvendHYjh4eXUwV1VTeEhneXljbXJnMUxNQUtiVGpGRjhCM09YVlpRZlBE?=
 =?utf-8?B?ZjVPWFRhcXROL00wYWJKSnc1T1A4WllXNlRScjVjVlpUZSs1cC9lK3MzbHU3?=
 =?utf-8?B?S1g0bWdKUTFRdG5TKzd1NnJrQndhMFpjdGU5emdCRlprRnZqYlNYY2tYbHE1?=
 =?utf-8?B?emNpbTI2T1N0TXMwc05QZ0xmTWJFdGJSdy9xTEN5cC8zdVV2SHkvKzJmTkZp?=
 =?utf-8?B?RUIxdWd0N0UzOVRpV2hiOS9MSStNQVg4eEVRQUk4TldZTTJKU0NuWHlOYWFw?=
 =?utf-8?B?eENmZmVRWm9XTzBuekp1LzBBaEVSSStGYTdnczFFaU1RRlN0RzNRY2FGR3N2?=
 =?utf-8?B?RFhHSVl4T3hVTjJUK2Y5MXpJV3dPWUJuUGVMZlg1b0dSNy9acCsyVXdqTlR1?=
 =?utf-8?B?UFVUMkszNDlRcnE1bnJDeVkrN1ZYVVFsT0ZwVkxzcEVBSjRpVFZCRzBJTDB0?=
 =?utf-8?B?ZTc3bXd1MEZUUzh2a1pxam81ekJYdnNDT0lVSTNOVEpJZnNzTkRVazVtUVdN?=
 =?utf-8?B?cjFmS0pUM3grVmNqM1FKQmlyR1FhMWFWZ2JucHBLNzczSlc3c2NnbzlIQWdV?=
 =?utf-8?B?OUd6K2kycGFGOUZ6WGVabm1XTzRqYVIzTFJrWXJjdlYzaldqZ0NOeTdPVFZV?=
 =?utf-8?B?QjhzdjdQRmdFa1NzSE1sSGhXNTFuSlpCRDdjalVxcllVbW9NVDd3RjhOYjU4?=
 =?utf-8?B?bWdnMVVPUlljRmlYMDBEL3ZWTk9CU01rbXc4cG9zc2RET0ZEK0VaTmMxNTN5?=
 =?utf-8?B?RERuN1pBT2RYMmw1ZkFPN3RrVHlpNGlRSlliekNLL2RuZy9oelFlUWk4M3c1?=
 =?utf-8?B?Z1NOSVd2dEZoMlROYlZkR2t2NlE5aXdjRkZJb0V3L2REb0tFYXkrc0J2aGph?=
 =?utf-8?B?ZVRnVnVQWkdwSzBod3llRjVsU3pvM2xWWWpRcHNvV1VGdlFNTGE1cExpNmhk?=
 =?utf-8?B?cWtZdVdYeHNNKzkwbmI2SGxIMWlscWFQaytmRjJVQTNpcHRvSFpvQ21WbGdF?=
 =?utf-8?B?YnRSZmVqaFRKSFlNVmNVTU80eFRFVkJUZUpYSVAyaDlhQTc1UWhPOWp2Yzd0?=
 =?utf-8?B?VUxJdjZ1UUFCWklLdXJtZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTNzZXZrK3lHK09DVjNqdkl2STBJVXA2MnVHclNOTjlLYmg2Mmx1ZEoxdnl0?=
 =?utf-8?B?SkZjbXU0WlVXRlMrMnQ0WXRmTzdzb016ekluVHkxVm55R1JlSkVQL29MQVUv?=
 =?utf-8?B?bTIrWGljM2ZTVVp2LzBjR1FPUkNnV0dCTGJFaDhCeHFNZGMyWlNhWHd0a09p?=
 =?utf-8?B?RlVIQlJtRWdGcXpIeEY2WndibVY4ZE81bXNreHBmY3JZRW9jN0RWUTk5NFF3?=
 =?utf-8?B?TzYxWC9jeW9ReHVVSnNPK2lkNldBVDdTNDNvRXYvcUh0SVE0b1lRWTNoVHUw?=
 =?utf-8?B?UjZrRXVFeit1dHljMlBER1BXOW56N1JvYkhUSDZ2ME1aNFpPSkhNYzlzaWJ6?=
 =?utf-8?B?MCtzMk5waEthZUkwcHV6clc5Y1FsOVJuTmpBQk5vdlR3TXFLb2pZTnM0b0hN?=
 =?utf-8?B?Y3JrQzdFQ3NLenhQK0VYeTJFdzJvZmtUa2lpb0xXVG9takFaejZGMGIwTGV2?=
 =?utf-8?B?dEVoWnAwSW9UK1hJd0dRTi96RVdCYVlMTlRWNWMxOVcrWmNybGt4NzZBZHZC?=
 =?utf-8?B?TnNaUHFqWFNKdmtnS0tEcTYxaE80c1hLWFpPSHREMS82TG4vTTZtdDRrWU5k?=
 =?utf-8?B?bUkrblNtNWlOSlNUSkE5b1BFS25RaXRha0ErV3FvRW8zREdTUklsdlB1QjEx?=
 =?utf-8?B?YkV5dGh1Q1hOUjF5TUdNVHVnbTJlTG56dGh0a3hlZ3d4REVkTms3WE1kTmU1?=
 =?utf-8?B?U0pDME11aXNvTTFwa2ExTno4Q055VDFmZTVaWmFGekZWNW1JYjlvZWI4L0JY?=
 =?utf-8?B?R3B3bnl3K3JSNXJFQWdNNFBYbVV2Q1ZyNHdBcDBRZzVRelpZWnE1SmRBaW5a?=
 =?utf-8?B?K0JKaDNTa0VyTWtxNGh0M0JvRWRFUDFNMVF0dEoxME96cWdOeWdXT3o0Qlpi?=
 =?utf-8?B?T1hORC9XUDJSS3E2RU55cFlWSjBPak9CS2N0dmxmMnM3bzNXcDdzNVlXQjZU?=
 =?utf-8?B?OC9hL2ZYaDhTK0pBUXlJRGZ6QXRXdFJ2ZlU3OVFEK1lCUVgrQkxaOFpuUXgx?=
 =?utf-8?B?WG91OVMwT00zVzk5UTN3aktaZjhTeUc0TWZtZFRxK1k4ZlpZcHBKdzdRUC92?=
 =?utf-8?B?dEJyNnZ1T2F1dmFWZlJKN3ZiRk1UUVRVS3hndTV1UWh5cjNaMUpaakFuR1ps?=
 =?utf-8?B?VFpEM0VoVmFSaHkxQU5xdU5KOER0cGtLU1VLVU9RakNYRFVkdm9EMXNIUlps?=
 =?utf-8?B?RDgxeUNTWG85U09HbGtMK29BQ0R3ZzIvb3lnWExBR1FRWXIrQzBxVUJLSFRT?=
 =?utf-8?B?Y1g2R0ZQU21HdVdjQnlKS1ZmS2tPQW10WGN3S1ExWGtuc3ROblZXc3VvNGkr?=
 =?utf-8?B?QWk1NERidnlWc0d5dnQrUUlvcWpJSDBBU3pYam5tdmxmT2ZEeWQ2ZVpVWEpq?=
 =?utf-8?B?Skh0aFJxYzQ2bHFYbUI3YTdPTkVJYmxBaHVJS0tIOFVmdHVlOEVuMXNKZTJW?=
 =?utf-8?B?c0d5bXZ2Y1ZwTHAwL2dGREZiSHZjWENIUUlzN3QycHhOL0FYc3E1ZjJjQ2pz?=
 =?utf-8?B?V0pGQk9XQ3cyTUtWOFRNSG9SYUQ1T0ZxZUpLWHZxTGZGcjNvY2JDaWZQNFIy?=
 =?utf-8?B?RmsyWWRyOGowOU93TDFKc29mMFFGaXJvL1BIZUpRbkZJT081SXRDMExEYkxi?=
 =?utf-8?B?QWxESS9LUXBsTTQrOHMxSjN1Qk5DdjN5eEVDYTY1UHVhNisyR213STdUVUk5?=
 =?utf-8?B?T1REejVNdmxNR2J6NDZzSVltVzJVMTY1Zlo4U1k1aE5pNWlHZ3hxc1Q3SWxT?=
 =?utf-8?B?emZVK1FIZ1RPS09rcDJyTlFRQllsMTNma0FodUJyT00ycjYxM0ZsRUw2K3Rx?=
 =?utf-8?B?aE10RTdTREh3azRKV1E1QXlNY012WURzTnVPL1RjV0lmb0UrUGpIcHU5eVZ5?=
 =?utf-8?B?UHZKT1VhNnp5dVUwSVR4bWJGelozQnFrY3BxZzlhZndheDZEb0l6S05TQ2or?=
 =?utf-8?B?eHY5amduc2RYdE1veW1pNFlRbzVPNWV3eUxpZi9WaUloWTZwMnhLTHo4WnIy?=
 =?utf-8?B?NW14aDFNcDJMWDd3cTNFTFBlL21hc3JMUmptWjlyVXFUNlRTT1pwcFMyRFF6?=
 =?utf-8?B?WmVuV1h3WFdzYy9RbE8xY2kyYmFVLy8vNURGZGJwK2dSNElXc0tDS3AzWTYr?=
 =?utf-8?B?aUt2ME4vWTFGZDBQTVBLM3BlMi81bG9WUUdJSURwZ2pOenN6RHFkOWVWaGJl?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d92640-0cdc-472f-c7e7-08dca2c02528
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:15:32.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYIgY1LHn41kruSqh3z8IKUbGintdA+Jv08uzKJKzwxCYJFx1gDo0TTPnSg0aZSTlQr32dTqyuGUKB+HE0iUfUBPAg/VMi8CuyHjLvk1FWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> Enable ABMC by default when supported during the boot up.
> 
> Users will not see any difference in the behavior when resctrl is
> mounted. With automatic assignment everything will work as running
> in the legacy monitor mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5: New patch to enable ABMC by default.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
>   3 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 6265ef8b610f..b69b2650bde3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>   		d = container_of(hdr, struct rdt_mon_domain, hdr);
>   
>   		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +		resctrl_arch_configure_abmc();
>   		return;
>   	}
>   
> @@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>   	arch_mon_domain_online(r, d);
>   
>   	resctrl_arch_mbm_evt_config(hw_dom);
> +	resctrl_arch_configure_abmc();
>   
>   	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>   		mon_domain_free(hw_dom);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index beb005775fe4..0f858cff8ab1 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -707,6 +707,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init resctrl_file_fflags_init(const char *config,
>   				     unsigned long fflags);
>   void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
> +void resctrl_arch_configure_abmc(void);
>   unsigned int mon_event_config_index_get(u32 evtid);
>   int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32 rmid,
>   			     u32 cntr_id, u32 closid, bool enable);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 531233779f8d..d978668c8865 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2733,6 +2733,23 @@ void resctrl_arch_abmc_disable(void)
>   	}
>   }
>   
> +void resctrl_arch_configure_abmc(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	bool enable = true;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (r->mon.abmc_capable) {
> +		if (!hw_res->abmc_enabled)
> +			hw_res->abmc_enabled = true;
> +		resctrl_abmc_set_one_amd(&enable);
> +	}

This does not look right. It is not architecture code that needs to
decide if this feature is enabled or not, right? The feature is enabled
via fs (for example when user writes to mbm_mode). If the default is
enabled then it should be set by fs. resctrl_arch_configure_abmc()
then checks if feature is capable and enabled before it configures
it on the CPU.

> +
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
>   /*
>    * We don't allow rdtgroup directories to be created anywhere
>    * except the root directory. Thus when looking for the rdtgroup

Reinette


Return-Path: <linux-kernel+bounces-350709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87550990853
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FF01F215BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F71C878E;
	Fri,  4 Oct 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJ2ZVKJ+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770A1C8771;
	Fri,  4 Oct 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057223; cv=fail; b=gA+uIQuQA3+iU/uMsyLMlAkzheCyWjYH+3P4sagG4wHg+9K5Scie4qWYnMk9TZ9YO2kFceFPq6NLBvv+xojDL7jNCuQANiDW9GJ8iZPRWiXsek87XABwyTFogLbEg9xW4OBfurbG+AiBx3HAw2O+tarFvJMTqBB45wUitOfC1Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057223; c=relaxed/simple;
	bh=k04LDEVic2f0DTCg/GgnP7j5A1fYvIQ64pjBiD0Dr+c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pv1g/G6LIzakXxK4rTfpek6LS4b0g11U2l8AeZvLFHNIYbXwBIb1iR9b1nSoycgU8WPKV5PjQ7CEnpYaNEXPRJHtHJZchVrzp1R24l2v9avMaBejVCfv8EXNCWOXPwy12x+AEFJLId3k+4aXrg21IkukrStTEtdcWy/9KYRb6bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJ2ZVKJ+; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728057222; x=1759593222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k04LDEVic2f0DTCg/GgnP7j5A1fYvIQ64pjBiD0Dr+c=;
  b=XJ2ZVKJ+C2IE5vaVNgoqYzMrFop+svqvDQVsx/kfkB3I9ijS00mcoO8C
   TksBn4auZN/nHbCrBUbVi6e/c2+Qvbq3GeK6tjedai/o/0JDPOv9xdefp
   rSiLFgzw9RLeLiAwaFQ9NJfeidlclcbyBbENlpBaRS4sGjtwQ6NiRAwH2
   w4cV7fA0iWBQWvfHoL9JTJdqXXYO7XfGjb8HFWnxPbt1u2Qxv81sZy+3n
   HPCcrw/EHbeLccFlmV/BnJU2n2s/D3fJeTmadR8MMwm1kcBT8JmoXaFsA
   VVUPJSni29Gq8DQ1ayy7iENirjmNLI268ksEikV9qfwlxQ0w4Dwn2dXBC
   g==;
X-CSE-ConnectionGUID: AOfNxGa+QpqwyvTJt+rMnw==
X-CSE-MsgGUID: 02d2k/yMTxqILWxbVZyH7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27460205"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27460205"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 08:53:41 -0700
X-CSE-ConnectionGUID: TbmsPRktTmGxtkcJ/XiJvA==
X-CSE-MsgGUID: mCSOo67BSD2civrguPANwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74572479"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 08:53:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 08:53:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 08:53:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 08:53:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 08:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOgQLJSvlnEzA7p2Lx7vsdD5dGfwYqqB65YVpCsCL1oD/Q1y0laLo6QWTPOc9kgASzthIK+5vycHFpM+P3cyG/ewKNiqnh7JyDN9g5aafaWUGuhZ9bNZ6qxg4EjvsBEc5jSwb3hvgWLcyz+vOp/FKN+CG9eLmXK3+F9Mqbf6jtZaWRqr2gX0+so5KW1bZHLr10kQ8BcycflsRC1EOiMKP5SPdnFKb7wZ48ZV2CGtbXG2KxmWczCGsXdPwTaMHNJfObq4pSEQwNbTUC6awubiwvM0bt+dPQSL8pumbNZlAW66jlP9seV5o3tzCXRxuocmTpfVZSP8jJGOcwRlycdShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdGzuDYmE7TYTM7l5lpv7SelaP7R2gYDjNlSE6I0XJE=;
 b=QpoQvNbP7MzorB8eBn/nDy5ia38cISym41lzp9yn8ilkTMctu6xa4ZlMFJY1RtqmOx7ibwRb3hdKb46kEsIfOACJSF5ROp3ljDHhRRgTwIBes6Qp3mbR5OX42cOQiBt1C4RScpjWibTzEUEdio7j9gRMd60rEAuZnWsYOU/q5HaO49FLa2+bhOvpH3ZRqQsxD9cgBBVkllh67XORR0Mqj1YqT2E0okWrm7vepqfNl1HxD77ECoRQhD+GjWRTT05yInFaIhtJ7MY+ggkitXnvuZtMKHe0QlICNEgNib5xDagNNQGQzJOt6ouewE2qJ3OiXs8RHGmhPfbUgKUGtf7JOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:53:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:53:35 +0000
Message-ID: <a28382ed-3c09-4a63-91ec-ea3cdd07fb54@intel.com>
Date: Fri, 4 Oct 2024 08:53:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/24] x86/resctrl: Update assignments on event
 configuration changes
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
 <384c2074-0076-4686-bebd-ba3ac3c05188@intel.com>
 <f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com>
 <d2147cb6-9d1a-49af-9be8-5d788ce7ee7b@intel.com>
 <c514416e-4320-3826-21dd-7e79ebc83351@amd.com>
 <33c56f32-4e56-47b5-890c-fbf1d45d7213@intel.com>
 <9621def4-2753-0f50-ceb6-3185c1789fec@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <9621def4-2753-0f50-ceb6-3185c1789fec@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7da0ba-3156-471a-54a8-08dce48cb457
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXYwQUsxOWtwTXRsb2hwTS96MEFYVVFXbC9lc2hreHRmb282UDR2K3h1ek5H?=
 =?utf-8?B?aTBNOHpxWWdHMEJWWkRPck1xNEJaZGtkUHhVK3Q4aGorMTJvelVxSDZPMHNF?=
 =?utf-8?B?bGQ2MDNma2hlTkNnTGd2THhzdjNiaHcyNU9zOWl3L01QVzJKNm5hbUt4OWpP?=
 =?utf-8?B?eUJuRDhML09iUWM4VnQyOFVXLzlIQWM0SVk0THp4eWd2dWNNYWc1elZzeVBN?=
 =?utf-8?B?RTljSDBRNzJ2bXFnWUNuWVY3UHdtbmY4dXdmRTUxcFQ4Qk5KaGJ4cmtVSzlZ?=
 =?utf-8?B?VWpxRGxGdHhuV2NXTTVsMjZEMlBLaHFzcWI1WURFZ2lHZjdtUVlOa2FwNTBm?=
 =?utf-8?B?Q1R4UXJZc1pBK3Brdm5ZQzZ0QW94YnZpL0RIbmZ4NVFvOXR6RWJiREVMRnhT?=
 =?utf-8?B?VCsreTFVM1ZvOEptdDBmV2tzd2V1T3Y5cEZvNkZVSFRycFJOdHpzU2M3emx1?=
 =?utf-8?B?Q2thZ2pSNEpGaEpTd0crZkpDZStwUmYxemwxRUh1WWFyVGF3UUpMb3ViMzdn?=
 =?utf-8?B?a0R5ZCtvWmZJMGd3cE95T1ZqZWtETEhKcng1Sm9UWHg3WlRkMDZmcTVtT2xE?=
 =?utf-8?B?elh5RS9mZFhuZzJJaTBNYUprOThHbWFoQXJyWk1OVzFWUGZYcE1xRFVnZHQ4?=
 =?utf-8?B?aG51c2cwK0tMK2krMHVERzc5VmlrZkxjektxYkdvdkE1eHZxZ2Q4NEFvUzRF?=
 =?utf-8?B?TWRKWUczQUQyZTlPa0pldTh3UkMwVVdnVnRMZjZjbVJHa2N0VDBiMUNQQ0My?=
 =?utf-8?B?TEJwdUJzRG4wL05QSEhMc0l3UUYxSWNzS3ExSE1JRGZOQUJVMmFYSU02OC9t?=
 =?utf-8?B?SXM4SGxzUnI5bTNoRU90TW8yNy8zRnZNRU9lbGU5QW5IbXAyVVA2K3lFODRI?=
 =?utf-8?B?K21wWmFNNGtGOGFud0Q4QmpWT3FlRzFmaG9hL1NNNVFhK3Z2QU9EaTVoWHBt?=
 =?utf-8?B?a1JJNVh3RXU4S1M2SHpvWUh1QUlCR2xyYnRkM0c5aXhUeWx1cVZQQWwwWGdw?=
 =?utf-8?B?RUF5eEk5Y0VpZldLYzlTc0RxYzdjR0tOWXpIREF1QVVIZThUS3VBdXl6bmxI?=
 =?utf-8?B?dncvVThITDNQblo0dVFuY0x2aWlnTVpOcmhyRlVjMWc5NDJQak1WbmF1SjdR?=
 =?utf-8?B?WWVEVGRlQ2krTnl2dFo0ODBNVjB3RnFXUkRxUW5aMnFWY2U2OURWRGNHanZN?=
 =?utf-8?B?VXBOQnEvaUt3ZmZYZEQ2TGw3dFRvR1NpcXRJMDFKSnhUd2hhYS9LWVFweXpm?=
 =?utf-8?B?OXM1U0hVakpEc2hvb005UngwUkdvMFBVVXZGa2tBaG90Sm1RQ3RreERia3dM?=
 =?utf-8?B?QTRESkxvY2szd0ZGZ2tIMkNOVnNNTDBibjlObW1MZDlHSTd1a2tBRjRYM040?=
 =?utf-8?B?VW9ObysvcHltL09CSXJjSEljNmphZy80eGx0Q2ZjL1hUTkdlTXdzL2FwY0Zy?=
 =?utf-8?B?UnNMaFhLSTFaSFFrM3FwbUlYZGtrTjg0UFRIcS9YUjJTRWgzcm8zbFJ2bExZ?=
 =?utf-8?B?L01hYmoxUE9zZ1pSeW5zdmFRZDZZSWJEWjNpanFhQ0E3N3pKUXp1U1VOSGlI?=
 =?utf-8?B?WUlERkpwbXlreHFXSGNrQXNUUytiWnU2MWV0RXpoZ0IwYzZEWElvZUthT0pF?=
 =?utf-8?B?aVBMeXphRXE2MnRKM09xTTRTZGpwKzdTSGJvdFBLdzEvOUk4S3VrK2RnTFlS?=
 =?utf-8?B?RW9lZTV4bmVjblh2cElDd0Fzb3E5LzhHYVgyUjh5SlU5MC8rQkswRnR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUp0SjVPRXZ6UXJDRGMwTW9qWEtBS2JLdU0yam1oakVxeURpMDVSdm94UVZT?=
 =?utf-8?B?eHpZbE1LTENjRW5RVkF4MjZuelNhWTBoaWdFQmNPV0VkbUNSUW9PZ3lKSnJV?=
 =?utf-8?B?MzFIamxYZUxFSmp3ckZIYTBKaVpzQjVoSkpod25NMVB1MExPZ1hqc2ZKaElD?=
 =?utf-8?B?NkwxYjNQNUQ5OVhHNFVVKzdkRWkyOWxvbkZQeU5MVXh4Vm9kV25tM1Y5WmxE?=
 =?utf-8?B?a2NXeFF3QUs1Zm45MlZia0ZYakJsOG9sSm1ERXVXSU51WGRLMHVBV0hsTklO?=
 =?utf-8?B?dm13UWNGVE0wQlM4TjN0d1ROa3ZzUzArTFdseGo3NzFWL2prcjFhSGRGbVd5?=
 =?utf-8?B?Qkt0L2REc3FWNGZHcHJMQjFvOStzVlRQQzVpMXJ6Nmw4dWIyb25PTGpnUVNS?=
 =?utf-8?B?a3JsZXovalNIdXJXVHhPMzBFVkxMc3pXaEo0Ym53dWM5clhOWldsaGJ2OFV4?=
 =?utf-8?B?WDBmRUJBS3l3MTZNZGZVNGJlNU9DR2FqWWhtbHhOVWN4NHpiOEFhTm5tRXd0?=
 =?utf-8?B?bktEcktXVVBscEcrQ2wweGxIU09NZFRzMXhDUmVZKzVzVWJNbmI2ZkFjd1ZO?=
 =?utf-8?B?bnM2QTRpdDgzVDJoRFhxZUZQcWlEZ2tQTmZyOVowZ21reS9kakZDLy95QVBW?=
 =?utf-8?B?azJNNWdpZFg2ZWdSR2tYYjhOTURob1dtSXlkK2dURnVRd3ppOVFhZ011Qlk4?=
 =?utf-8?B?eFJXMXBBWENRb2VYMWhTd3pKSDlRc1JuVXF6MDU3SEdMdGtjRVlFOE1Na0ZC?=
 =?utf-8?B?VjFibm1OM1dXVWtsWmxTQVFIUFJ1MGtuVm5wODY2RVJqNDE0ODNzbVNXLzFU?=
 =?utf-8?B?MTl2dWlNaWs5d09yRE9XdlpRUjEyci9tU0JVL0tpcjYyR2d4WUVPMUs2dGs5?=
 =?utf-8?B?OHM4WlhrSVROclVQdVFESUxCdTVrdnFPL1lCdnRzWkUwb2kvQWlsNzhnWE0x?=
 =?utf-8?B?TWc5TWpubUVNSzNpS1FWQmJRRGc1OXhFTUlTK2pFanVjN3lMb1dySG5ZSGY0?=
 =?utf-8?B?WS9HNTFWUm5KQXRUQ29iakNvMUFkREVab3JxUm5OVkQ3d25iRjBjM3YvaUUz?=
 =?utf-8?B?RHMrNUpLb2lMb1VCSkV5N0NGVGd5YWFDYUMzQ2VJSHVIMitzRU5vcUg3R0dy?=
 =?utf-8?B?aSt5UDZwM2VYVFVuRXd3M2ppWHBETDI4b3ZRc2ZSZXNXOTdUYmttVHdkY2Iw?=
 =?utf-8?B?eFJzc2JPUXp2SlgvTFA5ZFd2QkIrak4rcng3djBkcEV1VnB4YmJZNUlyY3pw?=
 =?utf-8?B?TGFpWmhuTWZDRS91dXIrb1pReHR6dGpZOWZxQ3VnUXdrY0VBS3htUVkyTUhq?=
 =?utf-8?B?TFd4amttK3VFekVlZWtTcjNFeHZGRnMwdnJ6eWpwcFIzQVdEbGltMExXVEFy?=
 =?utf-8?B?bmxkN0ZHTUcvc0g5WEJQbUR0RXFySXdaQ1l0OE5xRHJyeHlBaVlVNzVFZXI0?=
 =?utf-8?B?UzRNbXJGWnhKWGZya2hQdWJ1SFhlN0hOZ1JySjUrZndxQUdyWVh4WnMySzhQ?=
 =?utf-8?B?SHh2Qkl4b0wrYWRvc1EzOHlPaEdVVHAvMm1wRXdQcU9KWGRaaTJnZWVJU1RT?=
 =?utf-8?B?YnY5L0UvQ094WU10Mlc2WHRMUlN6R3FEVXhmUmdYMHRadzN2YVcvS3VMb3Vq?=
 =?utf-8?B?U2FZclpXVXcwbEhJNmtPR1U3Q0kyQkQzS0hJWkhBT2txS3FkcWJuR05zamxI?=
 =?utf-8?B?eUJhV1I5TWxtNzdZc3l2RWtQUzNWU2RsZjI2Z2wvVlZVaXBpVkNvNmk5NktN?=
 =?utf-8?B?Zk83QXl0TjViU0daMmhhaFBFK3RFckZVdDFOSUNJVFZMNXlNY3lxRUtXNFpV?=
 =?utf-8?B?RDhyWmYyc0pzaWdWRzhhbVdWQTRqQUJsZC9TZUJUNUZVKzVyUllWVUUxMm8v?=
 =?utf-8?B?aitRRVMrTzJNaVFEOXQ2NUpMK2V4eGgxS3l3R2VsR0NUbWtTWG9KT2JkdXY2?=
 =?utf-8?B?ZlFDTnp0R1IxTlkyd0lOd043MVVNdXFUUlVTMVRjRGtyWlhPM3ZXSjEzbE1K?=
 =?utf-8?B?RGp0ZXZJRDdxdjE2T0RseGZtRjBFUm0zNUdtTU42dmFjUThPck0xV1VGWG5r?=
 =?utf-8?B?T21ITG14RFJDOTdsU2JIL1NPbS9CaHFZSmZGcmZXS0padDFzYWNSUUxEUmx5?=
 =?utf-8?B?WXI4aFBWazQ4OHpxbkVub1kyVFREb0Q5TmJRZDhTS295Z3lWZzhjVGRvUDlI?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7da0ba-3156-471a-54a8-08dce48cb457
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:53:35.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zK+uV4tUq57A52QyCq1NOqznkRiSr7l05/hoYy25WEty7tD37ab/Njcu3ScZog246LCYUw7MRx9VwwFq3jKCp+U16rfafXPoaiV/b94s2A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8278
X-OriginatorOrg: intel.com

Hi Babu,

On 10/4/24 8:02 AM, Moger, Babu wrote:
> On 10/3/2024 9:17 PM, Reinette Chatre wrote:
>> On 10/3/24 5:51 PM, Moger, Babu wrote:
>>> On 10/2/2024 1:20 PM, Reinette Chatre wrote:
>>>> On 9/27/24 9:22 AM, Moger, Babu wrote:
>>>>> On 9/19/2024 12:45 PM, Reinette Chatre wrote:
>>>>>> On 9/4/24 3:21 PM, Babu Moger wrote:

>>>>> Using the domain bitmap we can figure out which of the counters are assigned in the domain. I can use the hardware help to update the assignment for each counter.  This has to be done via IPI.
>>>>> Something like this.
>>>>>
>>>>> static void rdtgroup_abmc_dom_cfg(void *info)
>>>>> {
>>>>>       union l3_qos_abmc_cfg *abmc_cfg = info;
>>>>>           u32 val = abmc_cfg->bw_type;
>>>>>
>>>>>           /* Get the counter configuration */
>>>>>       wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>>>>       rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
>>>>>
>>>>
>>>> This is not clear to me. I expected MSR_IA32_L3_QOS_ABMC_DSC
>>>> to return the bw_type that was just written to
>>>> MSR_IA32_L3_QOS_ABMC_CFG.
>>>>
>>>> It is also not clear to me how these registers can be
>>>> used without a valid counter ID. I seem to miss
>>>> the context of this call.
>>>
>>> Event configuration changes are domain specific. We have the domain data structure and we have the bitmap(mbm_cntr_map) in rdt_mon_domain. This bitmap tells us which of the counters in the domain are configured. So, we can get the  counter id from this bitmap. Using the counter id, we can query the hardware to get the current configuration by this sequence.
>>>
>>> /* Get the counter configuration */
>>> for (i=0; i< r->mon.num_mbm_cntrs; i++) {
>>>   if (test_bit(i, d->mbm_cntr_map)) {
>>>     abmc_cfg->cntr_id = i;
>>>     abmc_cfg.split.cfg_en = 0;
>>>     wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>>
>>>     /* Reading L3_QOS_ABMC_DSC returns the configuration of the
>>>      * counter id specified in L3_QOS_ABMC_CFG.cntr_id with RMID(bw_src)
>>>      * and event configuration(bw_type)  Get the counter configuration
>>>      */
>>>     rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
>>>
>>
>> Apologies but I do still have the same question as before ... wouldn't
>> MSR_IA32_L3_QOS_ABMC_DSC return the value that was just written to
>> MSR_IA32_L3_QOS_ABMC_CFG? If so, the previous wrmsrl() would set the
>> counter's bw_type to what is set in *abmc_cfg provided as parameter. It
>> thus still seems unclear why reading it back is necessary.
> 
> Yes. It is not clear in the spec.
> 
> QOS_ABMC_DSC is read-only MSR and used only to get the configured counter id information.
> 
> The configuration is only updated when QOS_ABMC_CFG.cfg_en = 1.
> 
> When you write QOS_ABMC_CFG with cntr_id = n, abmc_cfg.split.cfg_en
> = 0 and reading the QOS_ABMC_DSC back will return the configuration
> of cntr_id. Note that when abmc_cfg.split.cfg_en = 0, it will not
> change the counter id configuration. when you read QOS_ABMC_DSC back
> here, we will get bw_type (event config), bw_src (RMID) etc.

ah. I see now. Thank you very much for clarifying.

Reinette



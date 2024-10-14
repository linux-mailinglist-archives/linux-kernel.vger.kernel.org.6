Return-Path: <linux-kernel+bounces-364683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C205599D7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FE1B212C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B4B1CF2BE;
	Mon, 14 Oct 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SR/onToc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C811CF28B;
	Mon, 14 Oct 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936372; cv=fail; b=Bh1pp44xtmkOEgqiI0YlU5ceNlNwwctT3rsLZ799krVHjE05RsUsLVPsLhEOPoHuGXhf+HPGBO9mXDf9DMgElcwMjZkpf+sKHdZPKbUMUxokX/Qx7TvE5Ns2MvTSY2kEZ51zkt+kOWg6moCXMvMU/vrHzwWk//OfTCAu6xAH1Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936372; c=relaxed/simple;
	bh=HuqonZcU4DIJMiPsXkkz8w3paAXMp5yj+l3BKBiF0fQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xbi15UEi2fmMtVnxlLpPyDCWuQli1/IZEsWk6SsvB5EK4zL/tYh0PB+EnLRBvninXUPLSQXO1r0EHn9Bbg1dXMX9c3raFmeeuHR+LiJoz+4s5acX7NAYzdQ/Zh3ARRtBJErzKG9euu/kedYG4i43HOrCFsyZGAROlv6XTZu3NS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SR/onToc; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728936371; x=1760472371;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HuqonZcU4DIJMiPsXkkz8w3paAXMp5yj+l3BKBiF0fQ=;
  b=SR/onToc1dQGVzK8chx3Tbqd20q86tHS6gGgoeOU5ZytGLRTb5bF13LP
   cjqRaNCK/gvlxRp1kjCz1o/0hLoj3V6cyJR5YxtVg+SAQBnX7eL8fQq4A
   rRPL5gAzT7cnql+6oOfeNfVKMQ6N97YtX0fXobq0jWrxaCXV+dxpJWciN
   KWBkf8K45p8e6jwS/nMnAb97H5p4/EnaqvffgjS/30pmbicnKMPc40/eq
   Yqkvd2T0C7wBNMrBFASL2Y9zrN8I51zUI9bcrY/w0G3gFX+aKpQNHFSUl
   K7efAsg38pvlm1uJ5a42HZD9zZ2yN+xDtsTb5mj9+oKRTOXlaeHo39ON7
   A==;
X-CSE-ConnectionGUID: Z54ns/3+REKJbMHG/6bggw==
X-CSE-MsgGUID: yWpRwG/pQMS5rQfKiGVoyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28183359"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="28183359"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 13:06:10 -0700
X-CSE-ConnectionGUID: CU1kez2mSRaaiNdGj306Ow==
X-CSE-MsgGUID: 9dq38craTR6wF2/G98zrMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="108417970"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 13:06:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 13:06:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 13:06:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 13:06:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 13:06:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDZ0mFgcjzPc6GoxZsgiFeOrqpZ81NsKOxeTTCffH5q00W1FTemyGZ3g3SFGCoj62OSgAWAXRQZOlXAvjIQt8kqjG3B/1vWSZS0pyBYpUbg9nAuHjkcWslP65Bd97WJgm4mkigE3vKKre2mBMKut7KEZm8QIRhkBCk6Pte+OrbKbs7U1t8TKAS4FeGF+jQ2TnTnro8MyHn3aTds0CLAe48nUTjlMYswog3ACudTlqxZ8E+0VZOAh+tOH7E+64XCdc1H48r2gTTLnqDW9zZ4KEIb3/fC3kv4VXrUpw4ou8d8i1x/7JMmrPhBE+I5OvaByUxrFuR57HA4R+QukdkPmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8taECK1vVSJTGVhU7bVXYkTPzQp/N0cjAruEy1pp/C4=;
 b=mfVmpISJMM3PSsux2xsHEgZ3e0Q4NtSQz3llUt7kqvb53EwmKyDsyhhdyIikzDr3DZimv29Hnpp0Lrhn2C3duF3vnLIBOA+ITZLdHl+VutzQrERL/lQBLPtxf1uTjbsqOaGKUW2Qu4r6sSvhuSKmTHTbY3ljpuKpeUucXASJk/uAMNY8BHMhA+mj6c4vmqtgWNGSlGAwTaJRePtxRNs4Zg1+hehVMqhGYFuQ+IzxoHa+52uMi3nfFpZ9qLSoR+Of502iUF4R7qHPNR/ivnDrS2sDLf2O/PXKO+Kd+0pDsYzHUjjeX1JePuFbTFn6RxHezDRIWxTqSnK7zkbPFWk4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8560.namprd11.prod.outlook.com (2603:10b6:408:1e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Mon, 14 Oct
 2024 20:06:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 20:05:59 +0000
Message-ID: <799f514f-b06e-46d9-bfe7-dfd986aef166@intel.com>
Date: Mon, 14 Oct 2024 13:05:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: "Luck, Tony" <tony.luck@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
	"kim.phillips@amd.com" <kim.phillips@amd.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "seanjc@google.com" <seanjc@google.com>,
	"jmattson@google.com" <jmattson@google.com>, "leitao@debian.org"
	<leitao@debian.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Joseph, Jithu" <jithu.joseph@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
 <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
 <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
 <0ee2e67d-c1dd-489e-beef-1f255c5629d6@amd.com>
 <SJ1PR11MB60833A1571413763DE36B538FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <23b5a3d2-91ac-4467-9db0-3de483cfacf9@amd.com>
 <SJ1PR11MB6083583A24FA3B3B7C2DCD64FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB6083583A24FA3B3B7C2DCD64FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:303:85::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 82459ff6-498d-4ca7-6d1e-08dcec8b9f3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TndtdUtwVEt6MHY4SzRRR2xlYWYvaWFDSm5WZGkzd25FdnRjSHQ4dFBRREw2?=
 =?utf-8?B?dzlqSllZWjlwYXM5VkN6V3M4b0I5VDRnVGczQ2pBWS9yWVJLdjkwd1hHWkpN?=
 =?utf-8?B?b29VSVh0ZWxtajNtOUZFTzVtKzgrZ0Q5Q21VSmxYcnNMRnIrQkMvaGYvbjVa?=
 =?utf-8?B?d2NnOFQxMXVUY0wzeEd5L0ViemtGSUtqQ29NRmpzZG1qU0ZBZDVIWFRrV2Fi?=
 =?utf-8?B?RmhLUC8rQlhNR2FSZEpuREd4Y25lblFtVUJNSE9SVnJTMi9oMWlaMCtzc2d0?=
 =?utf-8?B?L09JakQyNmltQ2JkWGNOY0VtcE1Nb0JnSGdueEk2L1c5endScENrRUlqei9Y?=
 =?utf-8?B?WTNMYkJ3ekw4WnovSXk0LzBjY2NKcjlUWFBVZmlJSWlmbmhqQzFTOUcxc1hw?=
 =?utf-8?B?Sng5eCtxTHRTSzJraWJmUlpDUTUzL2RtdWF4c0dXMERYM0J4NnFiQzF1Tk1j?=
 =?utf-8?B?LzJ1NU1vUE9oektyb0l6eUJSWklLUmlYZW1BU1pRYVpKK3IrYk1kRVVZbU5F?=
 =?utf-8?B?R29IdlZ1UEdUVXp5SFRiNkkrTVVsNENvTmZzdHF3M1dUakNSVkVIS2NsSytW?=
 =?utf-8?B?V2ZiTmw2YVFUbmx0c1dKS3FHQk8rQjEvNEgzMnVUNE5UbkgrZ2dhb3ZSRGF3?=
 =?utf-8?B?K1ZWeDR6c0E0cWowZGViT1pXQVhTanVFYzJiOW1udXFQNkRnMi8xbUN1ajlQ?=
 =?utf-8?B?blJrbVN2WUQxYmFFbzJqNXRUeDM5dDQxMlZJVllMbmxBN3VmK2YwL1FZV0RZ?=
 =?utf-8?B?YkhUdy94bHRsOTBTSFo4cGFEc2wxSkQ0cldRbVlvSHU0ZzAvblorUFYvVGVi?=
 =?utf-8?B?YkRtRmFRSGRhMUxLd0dtQ2U4V3RIRUduRklZd3hvT0ZhSGRyOVllbmFHeVNi?=
 =?utf-8?B?R2g0am9YTWpyNVhvNnpMRm1zb3Q5bHBjUExoa2lDS3lUZHd1d3JDd3FRNGpF?=
 =?utf-8?B?TmMvU1ZaN2Yyd0hPd0ZvMC83VFFLRms4TzhOR0poVW9oQUYxejhuMzhtSEE0?=
 =?utf-8?B?U0djbjRuRFZBOVN3ZHNzamRiUVhIVzUrZUtsMVFzd2dBM0pvSU52R2RjM3FI?=
 =?utf-8?B?VjQ4VkhHUjRmK2VVSXFUaXlHV1Z2bFNkVHZPSVM4a1M4MUhKMysxNzV3UlE5?=
 =?utf-8?B?TDBlT0xZTFdmNkhLYk0wZ0hITGxXV3YwZ3M0by9jS2Y2T05MbjRjZXJhaFVF?=
 =?utf-8?B?NEI1eCtpRldLQXVpMjd4cGtQUDdmOGZrRmQ3c1FBR3dvYmVMaXVpeVNHakJY?=
 =?utf-8?B?NWtaQTVyRXZRVlY3VkpSZFkvU3g2WmhpNjBuWFpwNEE2OGtINFJ1UHByelAw?=
 =?utf-8?B?MmdEc0FIdUZHNkNTQ08vS1JqbTB6aTN6eGVvNERLWWpmU2R2eUhvbGdDZ29E?=
 =?utf-8?B?RnlKK2E4cWhmaVZCMVFhN2ZLZ0JITTBLbGV2K2FZaEVYWGF6b1RCWk9Id2lP?=
 =?utf-8?B?T25kdVdacEtweDBRMG1kSDR3ekZoNlgyMk5sMGhpNnhUek5RQUwxQ2hreHl3?=
 =?utf-8?B?U29zQitaN0dNbHdZWTBoUDArR2toaWxVd1Y4em9DaUJQTk1tMG5jTTFvN25q?=
 =?utf-8?B?c3JlU1BYMFRSY09Ea0NFekEreWhuOXNRaUdtWTkyVkFLZ1ZGOWZQbFR6RDRL?=
 =?utf-8?B?dVpxZmxlQytjMHh6NTNqQmQybTA4NEJneFcwOHdrY2FVc0ZTMG1aOTZ3djAw?=
 =?utf-8?B?dGcrSDVUQkhYc29SMVdhekxEOExCUmFTaWxlRDAzcGUzblFKdVZ4aXhqaXMx?=
 =?utf-8?Q?o5XmHAoNdiEhgG3nhU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnNhcmFURnBocmJyQ2VoalptQ3VVS1UvQndRWjdXUHNieFNSbVpDczYxTFVG?=
 =?utf-8?B?ZjdRQjNoNTlQQThDcmhtaCszbmdKWlFNaU5kMmQzZitGZ0xGT096UkZvUHIy?=
 =?utf-8?B?VGlQRWN0L3ZYOWJ6bFlPaXBXZEhjT0syMnJ1WGN5bVFxemFsdkZtZkgySjFp?=
 =?utf-8?B?VVJNc3YzcXc5Rk0rVG1FaHVZVmJoM0hSOXVGZTVGTHp6VjM5MnF0L0pRTW80?=
 =?utf-8?B?SDg3THNsQ3VEbWhUNmVNKzlyZi91RklGUFZuZ0txWnFWY2dUd1dFUlpnOUp5?=
 =?utf-8?B?UjJMVnM5dGdaL09ZOFhLZm1KZk5iVXNvd2FuMm1zMzhNZmR3bnJuMlUybDI5?=
 =?utf-8?B?cnhaNVdaSXVtODU4TGRkc2hDQkhsZmVqOFdmdmZVQ0c0QStxZm10Rm9rTWdJ?=
 =?utf-8?B?eDZqQ2tHUGZJYUpaazh0TTJlSm95eU5tNGtlekltOTdMbTZRcC9IbHRmcFVF?=
 =?utf-8?B?N0JMNjE5THNNcVBnaXJ5UmNXSjJOQ1dMWkU4YVRQVVRCb1dWUHRheTBtMnJJ?=
 =?utf-8?B?NjArWDlBalpmN1lOUkRTVkNyMXFtdnJSakVQRnQwTFB2MnFJYSt4ckVPQUZL?=
 =?utf-8?B?ZjBjQUFlZ29ZcEZpcnRTME5aaGN1RmNRSFM3bDd3dkkwV0hhYWFyMC96RFd3?=
 =?utf-8?B?bWlhalgxcXVWY0MxalMvZlE3TWp1aFhoY1ZyMi9hVEwyME9mb2xxY0Fna2hT?=
 =?utf-8?B?K3NPNi96NHN2ZUFNTnNrTEpPTms5NmVPMTlpRVNFZ1lBQjhtYU5lRHorS0ps?=
 =?utf-8?B?a2NlRGVKTHhzeDVvNlh1dW1rRkYvZTd3Y29JTktFSzRReWFvTC9ORkF3Mm5x?=
 =?utf-8?B?NDBId2Fxa09TRytpWDFtYUw4d2tuQXJKNFpTcnRlL3BWOGNyOFpEOFRSb3ZN?=
 =?utf-8?B?bDVGWnlmRE1oUS9sRVhrNTJXcWdMRExnZFhlbzA2Q25aKzdSalBjc2liaTgy?=
 =?utf-8?B?bUFQaW9EOE9zODlJdGlEYjVPb0laWVdlcGZiaEMzL3dYeTc3dGRRV0NBNGpq?=
 =?utf-8?B?RVpkSmE2YThLb25WYTdCWWR2RlhtUHlZbUE0ZW1XazZnZ0t6QkJ0SXNpWXA2?=
 =?utf-8?B?REJERFN5aFArTHBPa1plSE9pbFhRS0xTdmdtWHEvRm56NGlGOGd5aFdYeW50?=
 =?utf-8?B?cDdFek44TFIvY0JOQ2NHYkxmY2ZmRmpxZmIybXNaSDFOYzVMd3hoUm9kK2U3?=
 =?utf-8?B?QlFYdldlOGFGSDdhd3pKN2RkWVpoNkVTb3hXTWxPSzZudHpPT1o5d2dtVlNX?=
 =?utf-8?B?NTZocjVqWGxpYWJ4T0Zpd1lEWWRJUURVQkRLZDFkKy9hQ0FTMG5aWDFiY1cx?=
 =?utf-8?B?MmptcXJvN0kxMUE5RyswZHdJWUQ0dFluZ1NLYit5eTlFWFVNL2RHMXhFK3N4?=
 =?utf-8?B?blBBT2dRZFN2SHRyTkVOdWY4QlpyRVovaEo1ZExkZkVJT29sVWgxWGpwcnNR?=
 =?utf-8?B?ZFZ1L2JwUkQwT2RPQ1JUSy9uVmFHS2ZyWkJ4NjJUYVpmOU9pWWc1REJMdUlV?=
 =?utf-8?B?c1A2RHFzU1NYcHZSSmRIVksydmlUelNHNUZNenJ2dmdPRkhHbVRNNUdKTGl5?=
 =?utf-8?B?dm5RaTZoSDR2RVpzY1FEY2VGbkhhM1Yrc1p1YU1FL3JPaDFFeVNXUDhkYTZj?=
 =?utf-8?B?VEtmblU2dFRpVWdGL3dlSnIycUk0LzdmZDk4cDFRQkNaNkNkb1RiWWNOT3U5?=
 =?utf-8?B?RmF6QnFBYzRnUk1KVGNKa3Rmb0cxcklneWt5b3c4c215QzB5WjRRa0l4NXFn?=
 =?utf-8?B?ZEtTVWhKZHZnamhBQlpma0NYZXdoM3FSdnJuOStLNUlJNFB5bUNLSVAwTTJX?=
 =?utf-8?B?YTg4ekRZclpGcFJGNTdlK2tkVnVlU290dk9sVnZWV3N5WXR5UHFIdHc0SEU1?=
 =?utf-8?B?eXVLd2pTUU01bHRXNzBSTmtEczNIbERpTGpCRnFrYlpFRTVRR2JYZ3Q5WG0z?=
 =?utf-8?B?M29RREdJUysyUTJ5NlVkNThsUGd1cXVuTzhnY2lid20rbXEvRkVCWkdudFpq?=
 =?utf-8?B?SVpCQ05KbWxUZElHSjE1Q1JoamFvK0oyK0oxdWJ1ZEwyOWFaUEl1UFBTUUhZ?=
 =?utf-8?B?cHZQdzM3VUdxOEk1ZjRMS1N0M1c5dHY0RWtzT0JlN0MvOXJtWjF5akgxa0p6?=
 =?utf-8?B?ZVl6dFFTZnZUUVBVMDFCOXVzbUJJRU5PSk1RWXJUckVEWVVLamZlUXNQZWV0?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82459ff6-498d-4ca7-6d1e-08dcec8b9f3b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:05:59.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjvvCxIJOiPrpIvgBekC/kZXH28Etcg7hZSXz5iBFL52nUoVS67w9+rYBq9cI5MfJCDaME2U3tNs1H6Up0LvTWxCRqFUqi9AT6U1urY80v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8560
X-OriginatorOrg: intel.com

Hi Tony,

On 10/14/24 12:51 PM, Luck, Tony wrote:
>>> What advantage does it have over skipping the per-domain list and
>>> just providing a single value for all domains? You clearly expect this
>>> will be a common user request since you implemented the "*" means
>>> apply to all domains.
>>>
>>
>> We started with a global assignment by applying assignment across all the
>> domains initially.
>>
>> But we wanted give a generic approach which allows both the options(domain
>> specific assignment and global assignment with '*"). It is also matches
>> with other managements (RMID/CLOSID management) we are doing in resctrl
>> right now. Also, there is an extra IPI for each domain if user is only
>> interested in on domain.
>>
>> Some of the discussions are here.
>> https://lore.kernel.org/lkml/f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com/#r
> 
> My summary of that:
> 
> Peter: Complex, don't need per-domain.
> Reinette: Maybe some architecture might want per-domain.

To be specific ... we already have an architecture that supports per-domain:
AMD's ABMC. When I considered the lifetime of user interfaces (forever?) while knowing
that ABMC does indeed support per-domain counter assignment it seems a good
precaution for the user interface to support that, even if the first
implementation does not.

There are two parts to this work: (a) the new user interface
and (b) support for ABMC. I believe that the user interface has to be
flexible to support all ABMC features that users may want to take advantage of,
even if the first implementation does not enable those features. In addition,
the user interface should support future usages that we know if, "soft-ABMC"
and MPAM.

I do not think that we should require all implementations to support everything
made possible by user interface though. As I mentioned in that thread [1] I do
think that the user _interface_ needs to be flexible by supporting domain level
counter assignment, but that it may be possible that the _implementation_ only
supports assignment to '*' domain values. 

I thus do not think we should simplify the syntax of mbm_assign_control,
but I also do not think we should require that all implementations support all that
the syntax makes possible. 
 
> Since you seem to want to keep the flexibility for a possible future
> where per-domain is needed. The "available_mbm_cntrs" file
> suggested in another thread would need to list available counters
> on each domain to avoid ABI problems should that future arrive.
> 
> $ cat num_mbm_counters
> 32
> 
> $ cat available_mbm_cntrs
> 0=12;1=9

Good point.

> 
> Current implementation would show same number for all domains.
> 

Reinette

[1] https://lore.kernel.org/all/c8a23c54-237c-4ebb-9c88-39606b9ae1ab@intel.com/




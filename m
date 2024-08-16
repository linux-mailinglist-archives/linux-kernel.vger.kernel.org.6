Return-Path: <linux-kernel+bounces-290354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FFC95529F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF4E283134
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577B1C4635;
	Fri, 16 Aug 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SX1B83bw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409831420D0;
	Fri, 16 Aug 2024 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844561; cv=fail; b=uvFl32zRZ3YsImxJQos+hiAzZmepJZCmdB/4YY4XX8r49Nv4WiKFSUhnG2lGZnNHGQHY0aKXYz1rUCF5gkAvj74rPlWMKIV4XctUk6LAxNOsjhWV3t/VtkgWPQ+UMUamC3gU0UPXFu3WSUl+97bJs9n7QjdiQ5MUzfd/eTFLgXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844561; c=relaxed/simple;
	bh=poxnpFlwL3fP005NYVs5gYoHRpsS0rp3+u6MsKuLU90=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhLswAOqq4dPbIQ/20ACFVP0IRS4Ft03ehsESxRKUIIc7NueACjrizcCQtlsuVp4JKADuVq3reMVcWEqkmnzSTJ1/KWwSYjHBko+5gftZRdD6tdOJwpZ724hilhy3tTE5t7+suXSwgsdzS3jDJu+GbMCC66vi2yz3QnmVVtMtjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SX1B83bw; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844560; x=1755380560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=poxnpFlwL3fP005NYVs5gYoHRpsS0rp3+u6MsKuLU90=;
  b=SX1B83bwYKnxBTZllvVvjg3azFwm8kG7EZDZXD5l6Edox+Tb8DDidiF+
   jKnE/vIewk1W3x2xLm/8Gn4EudQvQgbfATNl2XrOd8PbKyRi+KcPKlC44
   9/V+RbNHHLYD9cpsjtuIVhjIS045quwW/trGIMp4UJqQ/GQaqIyn6YRkm
   WAmVLcd0SkMhrDiGCEzP/dXRNKfQanDY15RnyebhZA14VjSLNnP25iral
   XnyY1NVuFG1D5wUb2t4qB5BDJPeSS/w1ILjJZKUgLgT+5V2a/Z5pvSRZl
   dJYdJTfPR9SI8AiQdGrroWSKlmfnZ9FkCwVkPs4Ka8gTXu6r+Nv4qe21p
   Q==;
X-CSE-ConnectionGUID: G/QXGc4PSJ6tpI51kYzzjQ==
X-CSE-MsgGUID: 8DK7ERdmTB+uYB6bZEXizQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="44673624"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="44673624"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:42:39 -0700
X-CSE-ConnectionGUID: kN60/S7zR9KsHgtilmMeZg==
X-CSE-MsgGUID: RaRwYJeiSZWdM8XkzIJQgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="59823363"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:42:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:42:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:42:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3Qseq+ooQligI36UYv+j3p35TOvsafwtwRY6yMY0MaFY7mQf9MADgTsXKU0ntkGYotk0lv1Ti4oKp/IEV285LG4hsd310k89UW1HMgAQBjg+r/mQESjobaTFdFqmOoiyxvSiwCneR18faK4iyKkRnmUCJWsoU+gvEHjHCG0rOQF7MsVE6P/b9kNYtMtbWPbx23dOjLE/NL+iLvTU+zVDr57cBD5Otq7CCr9RQN7o0ADp7XmBhm+CvT4eZz3n1uQPypicdQQt5W8wDzySDpG184tqrGL8U4TOevGazoeuX85itb18MRTJQ0toapfkgwLQnDYC8t8I7w52+E7kquJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li67DJs2WQL71eik0M0ldyY6729kTbDNAc1c6HeeRI8=;
 b=Y2BePGMMM3MKQdIpuJ9BmeMkwAaJEoUNGMKrYszJN8qYHTO9nNdNii2onnfAvElmCK+Qa6BQK8vtglM85++dIXyelsMnOSe061UkwZM7qskhJBSQNfUgfkz7XDJgjyE6jGNIQGUwWSBP5Gu62VzI2NF+gpHivgp/y/QOyyrwGAnCVKvjoA1jJUj4oxxUjAMWiC4N9jFKkougSMN6mveOmWG2jE7K7dOJ7VG2VfipriiRRhALHgd2rnMkejZBhTpqvX9dNatki/h/rDPmr/XkCLSt3UaEVH0zV/TeoiZLBhSyXS0Wu2LYv+ag7xtynKqJp2zqBdvAcJ4XNrWYu/FPRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 21:42:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:42:36 +0000
Message-ID: <bac86fa6-bfb2-46fc-a279-c6a263c00058@intel.com>
Date: Fri, 16 Aug 2024 14:42:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/22] x86/resctrl: Report "Unassigned" for MBM events
 in ABMC mode
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
 <5906d1a910c5e2bceb680c874e5e391618f6e313.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <5906d1a910c5e2bceb680c874e5e391618f6e313.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:303:b8::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 177b5442-6bd2-44cc-d679-08dcbe3c57b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWxVb3pFVXVqV0N2ZW9wakN5N1NLMGgrT2NYSzAwVnk5RlZtdWJtcGNjUGtm?=
 =?utf-8?B?bVU0UFVxc1NOL0d0S01XWGZZblJyYUhRd2FTVGo0L3dBWjVWS1VFc3VvRUM1?=
 =?utf-8?B?eDRtN3hYMUUzRFpCZ2pPMmZ6akMyYVZjdkl4REZhTXRnQWZjYTNjalNVUlFm?=
 =?utf-8?B?Sk10aVhEVFBFaC9HMHV1NHZYbnRIc29PQmp5N3NWdCt6K0VMa2pSR3JTc1A0?=
 =?utf-8?B?aWNQUjdja29KRG1tZ1k0NnhPc0s1SU1WL0kzdmoweFpJZEw5ZFhMSFBSQzN2?=
 =?utf-8?B?akpDRTI4Z3ZZdkQ2U0IzbFZmVVMyazNGS2NCL0ZxOC84VXZMaEg1QmF3NmpE?=
 =?utf-8?B?S2ZLazlPK3llWW1SZXdNKzZYSXV4ZTFPaUlkbVlwSytGQzh5KzlSUEtWNTBK?=
 =?utf-8?B?ZE5SRzNBYjVRSzdlTGU0V2NkdTJ5cjV5TEhkUmhMSmtIRmxuRTRrbWdkMVFw?=
 =?utf-8?B?YTJiVjVJM0xVSUZhUFlNcUJpc1lwZ0lncFJWM0pVMzE5UWk5MW1OejV5MUtP?=
 =?utf-8?B?eTBMUVQ3bUI2REovci8xTTlvM3FtWlJtdEhtcEYrTThDd2J2RVRiTEU4UU5H?=
 =?utf-8?B?VlNMd210azlaTDBhT1Q2c3ZJZ21TVys0K0grODh2aHFDKzQxWTIrWUNyNllO?=
 =?utf-8?B?TDRuYmR4V3pnUEFyV2MwaENTNXByam11c3AvNmszbytybUF3cjZTT09OMlFM?=
 =?utf-8?B?RENaN09RWnlTRU1HLzN2RzV3R2RPNHhqbWp5RHVkRW1uMmVORTd2SkgremlK?=
 =?utf-8?B?ZWZNekVtWFlVK0tZbTVLdXhieWpLUHczTjdweDEwUDBaM2JpajAxZkFzVk0z?=
 =?utf-8?B?eG40b3pQQ29iekNVamIyalpOc0VJR3FuR3Z6VEpqaXE1amEzajR6SjY0N3Ru?=
 =?utf-8?B?V3ZTZHhaS3VZNDFxeCtHSHVXOVdGYW5GcWRpTytFM2JVZUY4WDR5SWJkNkVS?=
 =?utf-8?B?azFKdW1BamNFblpvc01pR0N3eUZMYWVKeHR2U3BITnFEMFVBbDJhcXE3RS9z?=
 =?utf-8?B?QmhLbEVoRFB5RkR0WFgvVnBUSXZaNExHL1pjOUU5UEhRdDNWYWlmb0xrelFJ?=
 =?utf-8?B?T3pXcXZwc0V1a3FJK0hudFF5cXpJc0tRMk9SeDBYak9DZGxjSWMvVWVmb0xv?=
 =?utf-8?B?aWdNajhHTFR4eU1BSzRLMUE5c0FxREpzdXdhWlhxODJyaHJIRWVJRFZVRmJp?=
 =?utf-8?B?UjFJMkx6ZU03aVEySlVqYmlrRlZwbnhJMjU3VjlldE1SbjF6QkoxMEFOSWdG?=
 =?utf-8?B?TUNyWXBsV3cxNFEvcUNEN2VnRjZ0SU9UTFU0YmVHaXNUL2hDQ0pHWXFPTlJ3?=
 =?utf-8?B?TUZtOXRBQ1piUmtHZkNaekNGVnVBVzYyZUQxc1JrbExlY1Y5OFVtTXpSZVg1?=
 =?utf-8?B?L1ZrcWt6OHhzOW43MDd2WmRqcjRKRGkwZmtLNTVUKzFCYi9tK0lNeHJmallL?=
 =?utf-8?B?dFBKNU5ya3FKUi9WVEFyKzRnb0tnVWJsZ3VGdlZhV2dqVFlCRENJTmIySHlY?=
 =?utf-8?B?SkhJYVp3NVppSWRBZS9GQWlPcGxSTzJMMndlNUZaVjU4NXo3OTlHTXBOdito?=
 =?utf-8?B?VzRxd0hvVjdMYUpOanVkTHZ3VVNmT2lYRnJnZk9lZW4vaHRCR0xBMk9ncUpl?=
 =?utf-8?B?Si9iS3JQSG5TODNvaXBxK2pveDNmdzVzUzFSM3JpVElNZzFDNEtMOUVWeVNG?=
 =?utf-8?B?clZwRFpiL3U0UDdIaStPRERvU3lDQnBDcVAwSDFIZXBhVUtzVVU1NG80QkVi?=
 =?utf-8?B?VDRPeHF0YVdwTnA3ellnQ21jcE4rZDVQK2FDeGdiUEZsSzZDdzl4eUtoOGw5?=
 =?utf-8?B?RkRhUHlCZEdaYkdJWDY3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnEvMnUrVUE4YzlKaDh4Z1NISElScFUvcUFqeldyT1V2OWx0S3V6aUNCclIz?=
 =?utf-8?B?Q0tGWEFybEdFMm5RYVV0UDEremFXeVhPSHJiUlhINmtXYnYzdlJvZnBCSzFE?=
 =?utf-8?B?MGpoS3FjOHlEWEJUd0tVRExpWEFmNnE1cDdGQmN0NFNYUk1DT3h5dnNLRVZl?=
 =?utf-8?B?Y2RLZURpSWduUVlLUUhnWjVuNURvNmhjeVBTbzVnTmxTWjdJbituVnpoUHJT?=
 =?utf-8?B?czVJNHZOQkg0WWlLQzI2MUlxclloRy9EOGIxWEVUZXAySE0yZSsyMjl3c1Rv?=
 =?utf-8?B?Nkc4aFpVZGwxYk8rbnp4Nml2T0VtdnFMcjJ2ZDFyc1hhS3Y5WGdOV0tudjVk?=
 =?utf-8?B?WERYVFdHa1Vlb1ZHWmMreFJaVUUrcHBrMm85UEw4VWNqS3E1Tk9JWngwZEdv?=
 =?utf-8?B?N1M3d200T29TNVJqR3JNQitPM2F2NVRLVzZJa0preXBjWkd2cmJSYjBUTXYv?=
 =?utf-8?B?Z1o4MVdrV1diMXQ2czBsL1liVWFPWjdlRWZXdEFEM0JOMHBtb1h0TGNIVDN4?=
 =?utf-8?B?TEg2QjhBSUU1KzZIdTJVYWc0ZXFiWjE4N0ZFejk3N0VMaXpEUW9YVEJVRkVy?=
 =?utf-8?B?QS90Z3RxWmExWWE0L1FnOHU3Sk5WaGV3VEF3ci9XVXJuY28zZy8yRVpmb1ZW?=
 =?utf-8?B?cS8xTUJObS9laFYwTC9ETjgyMFJlRVpzKytuTmpCcnVydEZVWGtTZjNmQmZP?=
 =?utf-8?B?NGNNR0pZZDN5bm1qRW5ubVZYZjk1eDVTWXFrS2Z0Z2tLM0ZkMGNmK1QzSnVL?=
 =?utf-8?B?QjFld3l2aWIvNTdnYnlVSS9CLythaEcxUURWT3pJWTlaYWlaVnUvL0NqRlg1?=
 =?utf-8?B?VitjQUIzQmtJYWo5dzhvdFBrSGFKVVZETXdRVjlGNXFHV2hrYW9sa05qYVUr?=
 =?utf-8?B?QlR1Mk5kRmNmeXBEYlp4TWc1STZoNkZRL3hkZ0dCZThDMDhPUUgraFlQcVFC?=
 =?utf-8?B?QktXVkYwanNDYkQ1RUhxcWR0aHp3RmxoeGpXcmxJN1B4Z1V3MUd0WklwSnJK?=
 =?utf-8?B?UmMwYmdTWnBWd1BiTzN6UzNoVHQrUWVnYmZaNjNJc2R0ajhOb0hlR3dnb0p3?=
 =?utf-8?B?eWt5QXRnbWhwYkhKa2tXOVRWc3p5TXpXK09PVEVKSVdEakhqNjFKY29Cb0Zv?=
 =?utf-8?B?dzNDSE9PNzJsTW9MZTYxSW9JZ2hWdnZLTVYrYU5Ob3NwbG5JZ1Z6UkgwMW9z?=
 =?utf-8?B?TmduSkVGeFc4ejdLQ05NK1pLSHd2RVErcDgxb2pLR1dESHdYL2JOUEZhb1NB?=
 =?utf-8?B?cFpWNGpORjVXb0dFSCswVjliREZoSy9NUEhwYXVIV2ZEOUloRkhjdmEvUG5Z?=
 =?utf-8?B?UFJadkdpN09UTWFTanZSZldYUXJyWGJndXVTQ0Q5ZHRMOVhlZStjSjRuL3NC?=
 =?utf-8?B?N3ZIRy80ZkVPWGlrTFFFZFVuMzBnSTRuYVB2R1RidE83bFljeGVrSXM1WjUz?=
 =?utf-8?B?Z2h4aE03UzBhanlWVmxRMEc4UG5ieWxhMUYydktocFdBL28xdUJqYVF3STFw?=
 =?utf-8?B?M2txY2drN3dPVkxvYmtScFM2emhYSzBGY29sM0xZQnZiT09OL3FQb1BhdEk1?=
 =?utf-8?B?eWxwRmxKM01sR0x2KzNNc0F6SUExdTJtQmFyaExDMi9VVUFIZm8xWjIrZzll?=
 =?utf-8?B?TXdlNElzZ3U4VWxLSVVlQ1hkckgzdUlCUk5yYWdEdGM3cDd1RWlsZ2JJd2Vy?=
 =?utf-8?B?aVRJenlydlU2MWM2RFRScnR4VCtBTkdCZlZpaGl3d0g3ZWhneVV0WU5BWjda?=
 =?utf-8?B?RGo2ZW5SdTRRSVQvMlpJSlNUNDlqNXZVZUU4b2xDYjRacW9TemM0emhXQ2g5?=
 =?utf-8?B?aUpIR0hlVTJSR3duSHdmQ2FsaGZOdlV2SU04cWlCaitXaDhJUnJucUF4K2p2?=
 =?utf-8?B?ejRRSkY4ODNGR0JsakdibXBvTjVidmhuWGFqYWV2QXBaZUQ5Z2EvVG01bEJr?=
 =?utf-8?B?SnFNQTdCcWtDL053U2RIK3RIRTdodklIekpqazZXaEJaNXgrN3hVYzVJeFVH?=
 =?utf-8?B?cG9nTWNoYXRIZ0dCZVhMUXlXTXNCMXZwQURFOWRwM2V0NVl5KzJrdDNaWkJ5?=
 =?utf-8?B?cEsrdUJzSXIvYkFtcTM3dVUxYW9wbWNwRHJ2clVQRFhLYnFlbXRNalVtejhG?=
 =?utf-8?B?L2xFU1ViM2dXemVoSkVNTW5paFNJZU83YkREZFhpeXdwd2JTQWM4bitPMzNQ?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 177b5442-6bd2-44cc-d679-08dcbe3c57b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:42:35.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWcNQE55q4bsIZc82Ri50gOdb2BvR0PdtSsOp4PdB1eBJAsk+pjHtPHoBfXYsU+bkQHyEpDshu/hDdp7XT2reitW0fDhC7Ku+mrMNKO2FUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> In ABMC mode, the hardware counter should be assigned to read the MBM
> events.
> 
> Report "Unassigned" in case the user attempts to read the events without
> assigning the counter.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Added more explaination in the resctrl.rst
>      Added checks to detect "Unassigned" before reading RMID.
> 
> v5: New patch.
> ---
>   Documentation/arch/x86/resctrl.rst        | 11 +++++++++++
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index fe9f10766c4f..aea440ee6107 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -294,6 +294,17 @@ with the following files:
>   "num_mbm_cntrs":
>   	The number of monitoring counters available for assignment.
>   
> +	Resctrl subsystem provides the interface to count maximum of two
> +	MBM events per group, from a combination of total and local events.
> +	Keeping the current interface, users can assign a maximum of two
> +	monitoring counters per group. User will also have the option to
> +	enable only one counter to the group.
> +
> +	With limited number of counters, system can run out of assignable counters.
> +	In mbm_cntr_assign mode, the MBM event counters will return "Unassigned" if
> +	the counter is not assigned to the event when read. Users need to assign a
> +	counter manually to read the events.

This seems more appropriate for the "mon_data" section.

Reinette


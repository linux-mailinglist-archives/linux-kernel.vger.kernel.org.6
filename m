Return-Path: <linux-kernel+bounces-251199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5389301FE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9461C218CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB855E49;
	Fri, 12 Jul 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXQLxhX4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358CC44C9B;
	Fri, 12 Jul 2024 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822265; cv=fail; b=jhFiOktaIBnV7IG5s8Ft0CvnewQgS6YvnJareDEfNjN2tFpkJFUQ789OK1mt3YQBh2+RnYG8IU5tN2+ANQEWlbkxLKrzlqblS1YVd1imLAVwlPyOpBVkKswyWm6CQMoYJ7yUdBPOQ1AZD0RNa0SXfl3sFmqCEKQ0a/tVJKycdwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822265; c=relaxed/simple;
	bh=M25E8Ifgq/+/z4ceOocuua3NfbeLgYaiAKkQDi7DNMY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lL0+PGP55lkbu+8JNU3oCjnHhIyYzRrGSUZZ4E6GLqTMz/nm4fDg1LhrUoYGXngYJQuavd/k6yvkChdia7gkIiQMOP2dgBeQZ1KdP9+7KcgsLWBN5pAgXWW8H6sEUcFNKxEe7L26aZPWs7tNivuZrKsVncaRl/XMDInRqu4+6YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXQLxhX4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822264; x=1752358264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M25E8Ifgq/+/z4ceOocuua3NfbeLgYaiAKkQDi7DNMY=;
  b=JXQLxhX4loFx/AcR6Ou00UgZJ2kFRuYJJblIca7VYLMr+vynAY/uvmu0
   eZ+b5QB+CdjIWNEjvnsRyfLeVavtO3OSTYCdBYy7Wix8kpzKAlIvbluWP
   MnWlIau8hqmRH34/FCfX/qscAIoBiIjRYAHxDj1c/cn8o+PkEMdrwrOr8
   2ZhDaylNyNBV5hdTqoN8J8dodO89gRRP3sQ8wekJXnTxNaG6DCtt34+Cs
   A+pXFZ8CVzL+v7J7UGrwn0YKvW2xbiDiyzhBoVfWKaHATtZzWNWJv+gLz
   GND8D9tPGaZ6sEyqBdABuiOckZnesUS7yyPWLSqAabMLIFwAN5AkLW0qw
   g==;
X-CSE-ConnectionGUID: s7q38OVnTCS85lWLv73RYQ==
X-CSE-MsgGUID: LQM5s0zWTdCgFiVpyOVqyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18422574"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="18422574"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:11:03 -0700
X-CSE-ConnectionGUID: sh9G/vTkTm2MXOiblDn+Bw==
X-CSE-MsgGUID: VbAtjJ0TTdq4WPbcRy5rww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="49121515"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:11:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:11:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:11:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:11:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:11:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgIDMmO2JWH/3kBXHtyUxgZCjNZf3hSMNI4jEKrFdquvkCjaqVj2FobX1bUZGxEzEMv/8GjtHTchGqBf5LlcXY9zBCuudvvgQonbVDJ07c65kjtKiamzqKflyRvhmIJ292V9+KtZigoT95VIbrHFBGnWSXcBoRgOMwqNeuhdrMMySrL0C+z/+Szy07QPvVj7JioKUSEnL8f8PRgJqO0/ql7ZBHlhpg4Gm8M9G6dXA656A34SodJuBWx+tf2lImwpkwl+6ZmZ57KWesEyOCuQLr6rzJgMFSM8Wx5ak4ZXK8OBhJaNn5etwFaNcnkwYYcQKXKNjsoFhMw8ssrDk4Si6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL+Uv46psB9qg0gcwQkJ9cHp5rUO2AHlecwji7+jvMk=;
 b=c9djigqjXtVuJ0/n8DmYHtdzesHEL79LpD7sPfiK094Muc2tAvB6F0Znx3g57y+tZfkrdFODXN/TXw+3Opufoz03soU+VBl4hb+MpmI3pPIBC8US7mTlHDqzkl0Iwo9oJzfjXOcEEuCfStQRvGJxCKLJ17pQzhCUuvW1I8xg8rGM5rgQqZOs4GJh2uQAMA8OI7rVbUdQ+vHnWDPxHFE3sib6ALHpMzQH0hAvbjMyo/m6ImJ5ZAvZlM7bhWHTTes3tYLVBMEvKMQ0t7UzpIniGGxZLN6hUkHEIml70NGEUcufQfpuLFo9+rGK4iO6BfOIMKSEDpIBqnKQi40sREGiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7514.namprd11.prod.outlook.com (2603:10b6:510:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:10:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:10:57 +0000
Message-ID: <5877c7ea-45ad-431f-8595-3d8a49d3fe05@intel.com>
Date: Fri, 12 Jul 2024 15:10:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/20] x86/resctrl: Assign/unassign counters by default
 when ABMC is enabled
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
 <89b7b4c59f3389034337301c1741ce224e19061e.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <89b7b4c59f3389034337301c1741ce224e19061e.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0374.namprd04.prod.outlook.com
 (2603:10b6:303:81::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: bb04dc3c-047b-4d83-73a0-08dca2bf8186
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1FOUFkzUHpNQ2pnY2ZhY3pqY2pENHZ3UWhYQ3VZOXVKSFNFNTlkOFpBUDdG?=
 =?utf-8?B?eHlXMUgrUVdOaTVKekZBS3JBcVpxK2l3akRlNW5USE1iVEx2NzRVQUlUVUM3?=
 =?utf-8?B?aFFoSUhZbER0d0VuOVpMdENlNVltaWtjVHYvUmtSTEJxSE5RemtBUjIvTTIy?=
 =?utf-8?B?dUo4ckN2dzZHVzcyU3FlMk1kK0tmTVJXNEQ1N0RJamQyaE1hek52S1pjZDZQ?=
 =?utf-8?B?enVwU1BWUkNWNlNyQWhCcURXdVdqRStWTHFlKy9sb3gwMk9jU1RiK1M0SlB2?=
 =?utf-8?B?RWh3Skxvc0Z2SEVPc3VzY29xRnFham9FclI4b3ZzSWhGOGRSTzdNZlpKaDdB?=
 =?utf-8?B?VVBPT0dzWWorN1pHSjJmNlkvWENYWFF6Yko5d0l0UXd0ZWc2c0hvbEpScUZp?=
 =?utf-8?B?NHAvSDExSEg0RmlnZkpEQ0tYNTFFdnpwZkFMcHJxVm1kL3VVMWNOa1ZtbXVm?=
 =?utf-8?B?ek5FTWFtdHdxb3ExTCtZUVVuZnA2cVUwQVJyQW1CTnVVNnlCb2pVRE0rNmRK?=
 =?utf-8?B?NjFwZncyNWJUSWZ5NFRHTzlNd25CMEVQYzhPZFpKS2lOOVA0MVBDUEVOSHB4?=
 =?utf-8?B?M1NKcHpsQmozcUF4eHVKTEFEVVEzbjJSMWNSZ1ZTdGZiWG9jRjJxdThqY2l5?=
 =?utf-8?B?T21xNVZFT1dYWE1kRVBwUE81VXAzbVRQQm9nWUF2T0VSbnVnZkhPQW5PRFlC?=
 =?utf-8?B?N2kyQmw3dEhkdFliTlJJRDBCMHNMNnU2MS9FWHpXTEFYRnpRS1JnQkdQc0l2?=
 =?utf-8?B?amhFL3h6Ni9JRXkzR1c3cm5GU0gvYmsrblpvWElWYTNIYTI0VWxNOG5YcHpz?=
 =?utf-8?B?NTlkUDFvOWVmR2RYRnVISGxKZ2tUcHhwRmtSQWZ5YURaYW94MDFBeVlGSzY5?=
 =?utf-8?B?TE16bnVLY09WYmM4NkxnMUVRZFZHUXhDNjU5UjRINDdDREh6RFR5aWRqK1E0?=
 =?utf-8?B?eDdkZW9HUHQyVXlQTFFvamNib2R1NkdZN0l6cjQ1WlJHek0vUXFwYWNtWU1I?=
 =?utf-8?B?N1RqeWhrYWE5eU9sZ1NiQW1KbXFab3lkMjZjZ2NtK3hoVzFCUzJ4N0RHckhm?=
 =?utf-8?B?SEhMTC9PUkpvSEg4UFRTcHZWa21GOVZIVkptZFlMcTh5bWhoM21OU2hUSnda?=
 =?utf-8?B?NEwyd2tVWTNYc3VKY3RaKys4K0RQWG1zQVJqc1VsZ3dER01FOXhqN1NEOStP?=
 =?utf-8?B?N09kdWlMOE1JNWxJalUrdlBKTDZiWW01UGU5dHJRVzdjR1I5clBma2RiOGw2?=
 =?utf-8?B?V1VXUXZuWHhlUmsvSTdDd29uZllubUpVQk1VQk1tNVdRZ1QyTXJPL2RGUGxh?=
 =?utf-8?B?RTBZRDJXNXVGNmZ5T0lsaXByRldERUdGOENTOFRmMk1vYkt0a2ZSS3k4UHNx?=
 =?utf-8?B?Yml4ZGlJM0hZSk9vbGJYb1phemVHU0MxTVJMSW5VQytzUTdrV0pvVGNYR3lI?=
 =?utf-8?B?MHVoZzRrTm4rL2V4NnNOUEN2aW9aUWZSNzc2SmJwUUpycS9Hc2xkYzV1RWtz?=
 =?utf-8?B?dks0alJCNklEeVdWQitsT3g1SFhUNVpZdGtnWHhFd0ZaWHdKY3hVa2Q0TU0y?=
 =?utf-8?B?WkwyY0lNODRqZ0JmOFErV3ZTQU5JaGpiMW8xRzdPSGhrRTgrZDVwTzUvR3Vs?=
 =?utf-8?B?SG11VzlSeHBZMTQrYzY5L0Q5ZHcxbjZqTmcvcXV3SzRhVEI0cmZvNm1zME43?=
 =?utf-8?B?WnVjaDdDNWpvd21sWWdIWXluc0UycS9FRGl5WWord1d4MzRpbnJ6VU9nUHYx?=
 =?utf-8?B?eElyM1kwcjRraW8rODlTWndEbWw1TFVZa3Y4U1VzRys2N3U1QnVyZWI1czlD?=
 =?utf-8?B?S3FUcGxnTmswMkVxNzM2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRPNFA3R29UT053K3NId0R2ajRrOE9qK2pJcFdlYStHT0hkTVh4c2JaV3FO?=
 =?utf-8?B?NFZFb0F3Nk45NDZjTTN1MSs3OUMyL0RSQitMMGVCVGZBUERzbXZwNjh0Q1RR?=
 =?utf-8?B?em9hZzVwdXVkM3NIckttOXEzaUdoaUR3ODd6Uy9RS2VMQ0tlRTA0cGI0MmYz?=
 =?utf-8?B?NVZsSlUxVUg5RFFHeW1iaVp5WHM4OU1Rcm01UFdTdE0yVlhWMWxHZmx2aFhy?=
 =?utf-8?B?VWVmL3B1YTRudEQ2Zm90ZXQ2UHpHYk9SR2F1dlRRdFQyWmtxZ29FMjNIMDBD?=
 =?utf-8?B?V05XdmtNWUxZeGVZbTJmeDBHNGVFRURyUnBDb2IvaVRsT0FOelBRRUVTRWxk?=
 =?utf-8?B?YjRGZ3EyN21rRGFsemYybTE0Q1VibGNZRXVtMm4vYmp4a2xxdGE0QzAzT1h6?=
 =?utf-8?B?R3FlQnVxSU5qS2hOU2NIMVc3MWpFRW0wQWZTSHpCcmZFSXltZnN3QytoSjNk?=
 =?utf-8?B?SWtHZXJxS1pINk1TKzhLVTU3Qm1qZlR3eEMwTXlWWWpwWEw4VS9CM0lKK1RB?=
 =?utf-8?B?VXp0VUZzM1lRQys2LzZQOGxMMnMwOGpGZlBvcEkrbFVVQU9hLysyTzlpRE4y?=
 =?utf-8?B?RVR1ZGFJOE8yVDZiTDRrdEk2Q2Z6TUdhLzZPTEZQU050OFpJd2ZnT0ZYTnJp?=
 =?utf-8?B?NVlZSnllQ1RHQkUyZ0lVRVlmZ0hHNTFzSmg4bVpSb0pYeGZOa1A5WWM1eGJL?=
 =?utf-8?B?aGloL1ZFNEJZT2Q3dGdJdThjQmZabVFORFMrbG51T1FheDBGNk1BTXA1K3h5?=
 =?utf-8?B?a3UyYTVnUkc0S05uUWs2K3pKa1ZDUWIyNWErSVdFamZob09FL0hSNHBUQ3hU?=
 =?utf-8?B?Ykw0d3lTRTVTdmh1MVBkYVpFWG85V3BVZjUyTXNmUStCazB4QmF5dzNTQmlZ?=
 =?utf-8?B?Qko3WVB6VmpScDF1RlFEYzVtNGJoRThFd0txVkRYUDFoZFJ5bGZKMWV3RTgy?=
 =?utf-8?B?NXBGdmxSaW85MjBkakVwaG55ZE5NSU9qTVgwcDI1VkJyeXBzSGVZa1kvYlN6?=
 =?utf-8?B?Y1lUaDBlT1NHUjFUUElkd1VOdHNhNkUwdGEyMHU5WlYxNTVyKzk2VUFNVU11?=
 =?utf-8?B?K0ZjcDRTWDNHZmpUdTF3aDNxenc1OUFDczRxWG1LYm5VZlFLN2JTYXVmRFRh?=
 =?utf-8?B?M0dpZElCbnd5QU0xa21OZjZkOWN6WGxxVXpxekROUFpPUVZYYytrRjNoSldy?=
 =?utf-8?B?bjE5TWJZSlU1YUx1UlZZM3lGcEFkWERGTDZPa05lRjlwTmVSMnR0Ym96TTl2?=
 =?utf-8?B?YWpmbE9Pbk1LZnlFZE5OWG9lUVdLTFlseVYrdWhKdlB0ejdNWGM4cjYyT2tY?=
 =?utf-8?B?MXg3dUU3czQ0a2d0SUI4ZzJaQjF4cS9aMHY5MFA4UDAzcVBVOStPejZMUGxw?=
 =?utf-8?B?YXUzVEtyN1cwOUd6NUJWOFpDeTVZRmdWeXczaVYwZG16MEE5b2RYZWNzYjN6?=
 =?utf-8?B?V0lLOVpOVzhiL1dMMmpiYjVaRDRqYmJmTjRySmF5WWJnUlBpNThoTC9vUGow?=
 =?utf-8?B?MjUvcFFTSDhpeHh1OVFtdXQ4TWR0VnJYN2ZwWG1NSVdMOVJ4ODU1SWxTVEZq?=
 =?utf-8?B?T2V0aXJwaXp5MTF5ZDZkZGlqOHJyTms3UGVXdGRuTFYwVkJGR1Q5cGtDV0Qz?=
 =?utf-8?B?UTErdXJJa0dYQmswNjR6WmNLN09BeHBXUDlMRnVOZHZRbFQ3NmZKQ3ZFQm5p?=
 =?utf-8?B?ZHRkMWw2OXhmREdaYjc0MThwdGV0LzNqUWpzeFpOay96T2tOb3ZnRDkzYlNs?=
 =?utf-8?B?TC91Q0g5T0h3aWJmYjc0U2xNU0tKMHFkQTNRajlkQUZIUm5LTGtac1RGd1Jx?=
 =?utf-8?B?c2dkZ1ROaUVDN0ZNNzUzWElsbXVlMzBMcmtMOU9aYWxNR2dIZ1Eza0VaUldB?=
 =?utf-8?B?bTZNc201VnN2TEZhTUh4L1lUTGdLMExQUGhLK0tGeUdoUDcyd1lzb0JJOFdp?=
 =?utf-8?B?bzQ2SU1CTWxacEgyWDlybFJsdStrSkFUOXJEMVhIcmJKdFkvRFZPcUJSRVh6?=
 =?utf-8?B?WEZpdWtJMmFqbnN5RE9CdERCb291TEllcXo5bUlOQnhxZmkxQmVWaGgzbEJj?=
 =?utf-8?B?eElBYmVvS01rcGMyT0pkU3lnQjZBb1hLbWsxa3lkck9URzNDMDgxV1pPcHJY?=
 =?utf-8?B?UUxPZExzN01ycjVqT09KUlJtZTF4blhwQThlRStFalovZkhPYTVWakxCVEth?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb04dc3c-047b-4d83-73a0-08dca2bf8186
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:10:57.6760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVmfZtDab/8E9Vse4aO8WMwbJ2eYhVY+oLGTHtJqW0+JkhlPKn9Z8N3+O8DKmm+/5G04VuX6RQaFVMXIfgKQTyjl87zkwGlQZnin7bFPcf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7514
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> Assign/unassign counters on resctrl group creation/deletion. If the
> counters are exhausted, report the warnings and continue. It is not
> required to fail group creation for assignment failures. Users have
> the option to modify the assignments later.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5: Removed the code to enable/disable ABMC during the mount.
>      That will be another patch.
>      Added arch callers to get the arch specific data.
>      Renamed fuctions to match the other abmc function.
>      Added code comments for assignment failures.
> 
> v4: Few name changes based on the upstream discussion.
>      Commit message update.
> 
> v3: This is a new patch. Patch addresses the upstream comment to enable
>      ABMC feature by default if the feature is available.
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 78 ++++++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ffde30b36c1a..475a0c7b2a25 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2910,6 +2910,46 @@ static void schemata_list_destroy(void)
>   	}
>   }
>   
> +/*
> + * Called when new group is created. Assign the counters if ABMC is
> + * already enabled. Two counters are required per group, one for total
> + * event and one for local event. With limited number of counters,
> + * the assignments can fail in some cases. But, it is not required to
> + * fail the group creation. Users have the option to modify the
> + * assignments after the group creation.
> + */
> +static int rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	int ret = 0;
> +
> +	if (!resctrl_arch_get_abmc_enabled())
> +		return 0;
> +
> +	if (is_mbm_total_enabled())
> +		ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (!ret && is_mbm_local_enabled())
> +		ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	return ret;
> +}
> +
> +static int rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	int ret = 0;
> +
> +	if (!resctrl_arch_get_abmc_enabled())
> +		return 0;
> +
> +	if (is_mbm_total_enabled())
> +		ret = rdtgroup_unassign_cntr(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (!ret && is_mbm_local_enabled())
> +		ret = rdtgroup_unassign_cntr(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	return ret;
> +}
> +
>   static int rdt_get_tree(struct fs_context *fc)
>   {
>   	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -2972,6 +3012,16 @@ static int rdt_get_tree(struct fs_context *fc)
>   		if (ret < 0)
>   			goto out_mongrp;
>   		rdtgroup_default.mon.mon_data_kn = kn_mondata;
> +
> +		/*
> +		 * Assign the counters if ABMC is already enabled.
> +		 * With limited number of counters, the assignments can
> +		 * fail in some cases. But, it is not required to fail
> +		 * the group creation. Users have the option to modify
> +		 * the assignments after the group creation.
> +		 */

The function has detailed comments - it seems unnecessary to me that the
same comments are duplicated at each call site.

> +		if (rdtgroup_assign_cntrs(&rdtgroup_default) < 0)
> +			rdt_last_cmd_puts("Monitor assignment failed\n");

rdtgroup_assign_cntrs() already prints message, why print another? Error
handling can then be dropped.

>   	}
>   
>   	ret = rdt_pseudo_lock_init();
> @@ -3246,6 +3296,8 @@ static void rdt_kill_sb(struct super_block *sb)
>   	cpus_read_lock();
>   	mutex_lock(&rdtgroup_mutex);
>   
> +	rdtgroup_unassign_cntrs(&rdtgroup_default);
> +

This seems appropriate to be in the "Put everything back to default values"
section.

>   	rdt_disable_ctx();
>   
>   	/*Put everything back to default values. */
> @@ -3850,6 +3902,16 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>   		goto out_unlock;
>   	}
>   
> +	/*
> +	 * Assign the counters if ABMC is already enabled.
> +	 * With the limited number of counters, there can be cases
> +	 * only on assignment succeed. It is not required to fail
> +	 * here in that case. Users have the option to modify the
> +	 * assignments later.
> +	 */
> +	if (rdtgroup_assign_cntrs(rdtgrp) < 0)
> +		rdt_last_cmd_puts("Monitor assignment failed\n");
> +
>   	kernfs_activate(rdtgrp->kn);
>   
>   	/*
> @@ -3894,6 +3956,17 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>   	if (ret)
>   		goto out_closid_free;
>   
> +	/*
> +	 * Assign the counters if ABMC is already enabled.
> +	 * With the limited number of counters, there can be cases
> +	 * only on assignment succeed. It is not required to fail
> +	 * here in that case. Users have the option to assign the
> +	 * counter later.
> +	 */
> +
> +	if (rdtgroup_assign_cntrs(rdtgrp) < 0)
> +		rdt_last_cmd_puts("Monitor assignment failed\n");
> +
>   	kernfs_activate(rdtgrp->kn);
>   
>   	ret = rdtgroup_init_alloc(rdtgrp);
> @@ -3989,6 +4062,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	update_closid_rmid(tmpmask, NULL);
>   
>   	rdtgrp->flags = RDT_DELETED;
> +
> +	rdtgroup_unassign_cntrs(rdtgrp);
> +
>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   	/*
> @@ -4035,6 +4111,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>   	update_closid_rmid(tmpmask, NULL);
>   
> +	rdtgroup_unassign_cntrs(rdtgrp);
> +
>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   	closid_free(rdtgrp->closid);
>   

Reinette


Return-Path: <linux-kernel+bounces-251197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF749301F9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5611F22DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB355E49;
	Fri, 12 Jul 2024 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtXZrDfu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6DD200CD;
	Fri, 12 Jul 2024 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822166; cv=fail; b=sBV/2p/IHKMXw7G8pmE0T403JmBX8MU9q6JC6DcEQ0vC9Bfnzj5V/gV07dSfqXwg6pw+3EkTtV7G2NUlRpNqXJp59PzqGNLq0r6pArgFjYqRPR4Ua0slIu+5vCXbKMnbJ0uao9M1M8WDeIN/ei16qxNWNNxnbZwOhYR9YseMQug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822166; c=relaxed/simple;
	bh=aerqc1xK+90PldpBAksK3sR1V2FJCseDoN7KNYsp18c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uT4B1ljBUrWryDusyXLy0gIKl21mbSqjdSWTMXkrIJhlO+8ZD360YZV5rMfLxLBG7UCpRu8P1wJA0/z9abn9ehidbgB8z4AloXQnvME3D91JbI61uSKQHJErRtCuZbqe9zgjlTy90M9fbdQNZ/34zrL+1aGBiVoZZNfej4rgnUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtXZrDfu; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822165; x=1752358165;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aerqc1xK+90PldpBAksK3sR1V2FJCseDoN7KNYsp18c=;
  b=RtXZrDfuBpYxD7eqO2DXjKq2r6K+nKGkFalE0UzgEW2f9W4Il0Agw55b
   Jvjvt4CI5MirIN+naw66b4iOwenPOPMkIC9aYGXAtIH/mfUgT0hDrGYU5
   CDVRw4wXbT1Gw5/A8p6KYvjh5KL7u97/Ktcc3BkVJzvg8Rh/XRjtg/RBW
   HpcCe/l54pHRz1n9qHE1IXz5s7rUm14TKKiFfAkALVR/sx6GgV8j5v1MO
   PD/BHLMj8NZM8+L31Kv34bz9x+uJ+7pn0g1872ivdefq+m20NpUWjdI/H
   ESk9tR/buU1go3hbnrYMVSOd067s/PYuVOhgjeiaG111G0BpZotSKkI/2
   Q==;
X-CSE-ConnectionGUID: BgXHoBrWQWWRllwyl+uvQA==
X-CSE-MsgGUID: NF5EawVlTsKv29irYQhsgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="28875141"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="28875141"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:09:25 -0700
X-CSE-ConnectionGUID: 9TnRgvIQRiWxELOF6RGevQ==
X-CSE-MsgGUID: Qt4BQsHCQZ66JZAEwzCTfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="48925929"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:09:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:09:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:09:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:09:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK2wg1M5vo9HTMBE32aK5JwFGwqtmyKPe05QaMMjiZOfKGAP2xu+8plm3NLDt2q7aBLbuNtm1urq2kDry76gMhlCGVbJL+njApeNiYlQofNQ1NeGqYrxNEgc5JuMyOqFiyAXObcFl3zCAkjfKD5fZFI476EOh4kA3d84lMde5PsTckbIqrXOipnRuxzCWkG3/t/gqpvigPZ+STgtUl/glVCpNPlVHrCvKURQ7SBeFw9NXb4LOs4bsNt6uwTWysGqgUjY7xwYWUDPFvA5Gz9jJZfDq/zmu4u83O4mV4q/q7CHc1BJkD427O9fMnRH9JCmXaIg4t+iBrCmic+TLrbJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhNWihJuZBUX7jgsGxZivm4PsrFRul3E98pWq+NngJ8=;
 b=ghPmvSReIeEyA4Uemvk3wcN7wVzosP6Vh62B1PeZTLTxaNp/TIZJMXmemPOxuEEFof3RjBH110mhsKdTrYU3meIFeiATsbKnZ6YNl/K0hOChNE86tdOMdXNgQgQ+zmK26k2naPOwAtWBkVzc5+se5XbOp1oUpXBtRYELAlXV05Kx+ZTzYorZe1DDCGdo7BdyLHjmiHwzwDNk4X4qLY8Jl8hl+B52EDsE7/dT1hoxksL9rJCUMnYmxGELWqTUggpRSz41ZpqqhzrgKC+c5A/eLOV60eIP7/yTYc9rf67oITeOL/gVdzu8ZzKKz5JKfPKNzcvTpKXpt9pE6TlaRGkjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7514.namprd11.prod.outlook.com (2603:10b6:510:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:09:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:09:19 +0000
Message-ID: <3f93f294-5d13-4805-9954-07c93845e836@intel.com>
Date: Fri, 12 Jul 2024 15:09:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/20] x86/resctrl: Add the interface to assign
 hardware counter
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
 <add3032b43cd06b538f57249fe0b80a9b5e5fda5.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <add3032b43cd06b538f57249fe0b80a9b5e5fda5.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:303:6a::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdf4d67-ed43-45c7-eefd-08dca2bf46c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDVmS1VweThlQUd3Qk9Za25uYTZjVHgzQTVzd2JuVTQ3TGhteVBNUUZDbGNn?=
 =?utf-8?B?RExPQzZZQ3lTOEZHdHBRUXBuMXVSWVNNU084Qy8yWmRMQjlOQkM2L0JOeVZr?=
 =?utf-8?B?MEVBb3dtUCszVjZ5NFVaK1UvR1oxRmN3dUl2Q0VOOThOWlpZVXFlUHNHMTU3?=
 =?utf-8?B?ZzFmMkt0Z3V1OVpvaVJ2N3lqMjVxcDBlb2ljUlhYcENCTVRLNUIrMnc5eTh5?=
 =?utf-8?B?aUdwTW5JNU55ZXJLNUdrSk00YndXZ0RYK3p5TFNMNVoweTVzWUJZT3lWVzB1?=
 =?utf-8?B?LzI2RWgyS1ltRHk1RTlCc2xHNnJJbytWbER2dXU0NVFpUWRXckc2Q3Brc01s?=
 =?utf-8?B?aXlZbURuckJLU21EOWdMQ25jVFZZaXZjUWpaUC9vVEFmWWtpYU1BZnZnYzFr?=
 =?utf-8?B?aXN3by9XOVYrWUhJNVBkUmpyS250bW1wR0o5M3BjZmtlRVZqN0FrRU5zZThZ?=
 =?utf-8?B?RDgrcnhkbjJvSzdFVjhqVy9kRG55U3oyV1ZpSEMzZ01qUW54RjZ4ZFpGcS9y?=
 =?utf-8?B?cGpvanRiMlpzV0NiMTkwWUtSa21VVXVFbjR2TGpsR0cvRTNjY0VaS1FDV0Fx?=
 =?utf-8?B?M3B6VC91M3JSazFGTjZvZUJ3N1o2VVIxQzBzQVRJb0RXWFpER00xMHBxM3ZW?=
 =?utf-8?B?RmpzVkZKYjNpTnIrZWFNNWZrcmtsT2xqc0JwUFNXTEZEQ0pZeHkyL3czTEJ6?=
 =?utf-8?B?Ukw5VmNrV3g0cWdKdnlWQ3pqMklPcnZPUFp4dmg1WjU3bE4zai9XeklXTUFP?=
 =?utf-8?B?N3pCa2lZMU5lWURTbE1rbHI4aXBJN1BLWEp0K1ZuSHp3T2NRbVA0ZVhreGFp?=
 =?utf-8?B?UHorQWQvajJEbStwTW52TUtCUGtsSXRIT2xiYi81WHlab1VsbFJsR09Vb2JM?=
 =?utf-8?B?U1VhT1VlR29WVzJiL3h1MzFBb01sMW9Pb3h0cXdrT1dHdGRHWmRkaFN6cDNy?=
 =?utf-8?B?MFE5cENyNXRwT3YraGZ6dXlqcERqRFlBK0R2WDdvbHVBQnVwWkZMWWM2RVB1?=
 =?utf-8?B?SzRqcWlTNkt3Y01kNWlSa3VGa2lHU1JoTXpwek1qeExWVVNtUCtxRWNXWnBz?=
 =?utf-8?B?OVpYTEhUdFh4cE1LSU5ZTXYwMUFFR2JBRFo1OG84M2p5S3JxajRsY3M5M1Ju?=
 =?utf-8?B?d0MyOGpwc25sN2Uzd3RReEdXRU8vT0M2d0x2MU5JNmFsM0lWSisxZkhad2R0?=
 =?utf-8?B?d2JoN05jZ1A3SzE3WVJmUi9DNkxwK1F0dno5MUpEZVNpVjFnSW9aR2hweS9O?=
 =?utf-8?B?MU90RHd5dUV1VTE0OWFwMHFVdW9xai85RzlnTWt2bER0US8xL0lKQzFKNlpH?=
 =?utf-8?B?M1NTL0cwRHhSQTdXeUVRQ0JndHB1UlFha3ExSVBFQlFtb2xoUFYvZ3ZKNXlT?=
 =?utf-8?B?U0pPRkphdTlndWVSTzVWNTBkTGlrQjVZSlo0TUMxQ1JHV2I1eVBmS2RCUmNR?=
 =?utf-8?B?dzVvalErOGVJOWI5YXNETUNTSG9sUGlIOTM5S3lPSlBpQjkxZHZvMmpQdHpy?=
 =?utf-8?B?SGlSMGpvUldsZHJPQnhramhIZVpSdjF2SDFmbWZoR1FFNVZ1OGpQOGVqSVBU?=
 =?utf-8?B?bmFFSjNoMXZIV2p3ZXBWa3c4akg3dGVWWm9PelpYTmJ2RjRLZWpGOVJ5MHIx?=
 =?utf-8?B?L3I5RndKMktMeFNDVWppVzA5NkZ5L3pvZ1VmTUp5Y2pJMUlMNmFISjJMT0lM?=
 =?utf-8?B?T1ZDVEQ3TmtNdkNKUWdtUzZWMk1YQTdTUmd3K29aeEFKTXpWdFBDMDN3OWx3?=
 =?utf-8?Q?l3UO3d14m90hCCuDTo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y25rcE9oeUdlWklZYVhDVkZvRERsN0NVSi9PMzBwaW8xSmVtZ1c5L1J6cGVE?=
 =?utf-8?B?VHBPbWxUdlowa2MzdG5XNEQzaVZrU3k4MlUrZFU1R2JHaG9EcU1FMkpKUVJT?=
 =?utf-8?B?eUFoSnNGcjYyVUJ6dG5pdHRScXdLVVRhMHNaUWZValpULzM5c0kvclMxd2tN?=
 =?utf-8?B?NThKaVVkY3c2Q1pPeml4QVVqWEFwY0lnZGZJaktwWlltMzVzU3JQdCtPVWxl?=
 =?utf-8?B?ZUlOZVlaWGhUVUJwWllkL3hKUUhZRjZBeUU5QTV5cnNjbXVEYk8vSnpSSGJn?=
 =?utf-8?B?UHdqdXJoRE5RRW5OazJjcDJCR0l0RjZINDdWU2hVUkZ5T053WFplWnNFS0NI?=
 =?utf-8?B?b3V3R1dBbHZkMGRURkxMU2xlT3R4VjdwclZuOHVjUTBvOGdJRUl2Ullrbzl1?=
 =?utf-8?B?L1FUMStKdmhRNUxURGt6Y3pRUTdhMUJDdlZaTjBLOTdLWlludDhyN0JjOGw2?=
 =?utf-8?B?aWFLV2wxRVYrS1JxbFlyL0NJNldzdDF5ZVcwVWhrZnE0aWtYaHAzNzBiTnhl?=
 =?utf-8?B?RkN6TDR2N1A4MlJZQnd5bk5zdjJFQnUxNHc5Uk1oZlZzMCswRGFsM2xmck1Y?=
 =?utf-8?B?RTVTYTZvRUZrb2E0NUFKV0lOaEUyTTJscUdPT2VoemNRNXltTmhQSTJwWVN5?=
 =?utf-8?B?ZGFWcG42MXc0b1dsbkZKM28wZVdmNGNnRWMxbzJubEJFendpN3VVNStsWDdG?=
 =?utf-8?B?Vi9wWDRISi91NG5mTFBWbE56KzJLd3I1NGVaTVJFdzdtb1NxZlNmRndEL1VO?=
 =?utf-8?B?Tmw2MDR5R3cwcDlZc2dTWDBWWUpaYm9POHNUNFYrdTltNllqWjMrcHlnTHUy?=
 =?utf-8?B?ZXdGemcyVTRGNGk0eTRkeklXcWt6YjFNYW95VzdOYS95MkMxeElvWGVWM3VW?=
 =?utf-8?B?WlRTUEVjMENCMlB2UzVnUHEzRHNoejBURXJFeU51ZmJaelJhTzZkWTNCcGVZ?=
 =?utf-8?B?SXBYQjJLR3VHczNBbmlYbTg2N2xBWVFlci9Gd0pYRFVkSmdNeGJzME9wTlNl?=
 =?utf-8?B?VVVna2UwN1VmU0V1cWtMMnVjKzNIZlBDMzBmQWZLNEJIYytJS1VmN0pJUDhL?=
 =?utf-8?B?VVU3RzRSTUZZQ0p4S2pZN1ZjajFnd0c3K1FPc0gxQVlabnQxakE5OVJMa25i?=
 =?utf-8?B?ajRqekY5OTcwaG55Z010ZVQ2Y0RqZk9rWU5obXRyWFZ5dElYRlROK05DU2cx?=
 =?utf-8?B?WHdybGMxaW0wMmZiRVNFWEsxRTVUYnV0VWw5MTJqUWQxOUhnZVM1L0c3VWpk?=
 =?utf-8?B?em5XekJDdWVjNURleGpjTjJhOFlKSmxHRSt4T2Erb2ZSeTVmR3FHYVpOaEc4?=
 =?utf-8?B?V1cvd3g5akRhNmJoVGRtYXlDT3dsVlYzMlNXT28ra2ZyYUhqMDdtcHJ5OEFz?=
 =?utf-8?B?eUtmeWJJQnhmN3dJdUhSWDE2QWUwV3pNYUQyQ1FDUGEweDJVSVNweUh4Zllk?=
 =?utf-8?B?YlpvcGErVUt5WElsa0RRZ0dIT1VyWWZWaXNaSkVUa1RqZUFTNjY2SVhhRHdE?=
 =?utf-8?B?RFJOTTlFNXpmY2pTMCt3clhvWWlQZ3FQMXB6ZzAyT09NMnZ1UXlGZHdIQjNw?=
 =?utf-8?B?ZUl5VkcyNGs2a25aY2lZeERTL0ZiS1gyMjdyQnBYMWY3ZFYxNVZpbVl1eU1n?=
 =?utf-8?B?MXVCcnZ3cHlzeHV5WVhGRU50bmhkTE41Q081bGF1WU0zWTdTVzJTeUpNaHZH?=
 =?utf-8?B?azdtVU1tVUlRWktGVGE0QUpQb0lYUVQ4NklxSUFmZjRXVmh4UVlqTXdSTkJw?=
 =?utf-8?B?Sms5ODBmKy82Q0RuQTdnUlVCTDBTd0RKWnhWcmtuV0haUldJYUJIYm1qeHZL?=
 =?utf-8?B?NUN0WExtREk0SzJUSDVydUJFY0g3NDhRdkxSMkloMU1kemRFMUVHZUxibnFS?=
 =?utf-8?B?OVVMUExuUUtnOG1RUXFQenhKRjdkeDRNNUtTZGFLcTQ4OVcwSHk1cjY0RDI1?=
 =?utf-8?B?aDlHZHZpc2krQXhWN292WXl1b1p5UElFcnZURkVmMFc4OTUzVW1aQXpuM0xz?=
 =?utf-8?B?c0l2TXljNTBwN3ZhZUxUVDhoOUFuRlkySTQ2VFozbS9xWXUxemhXMVJnTG56?=
 =?utf-8?B?dEZ3UTZqQUVGcmppcjFzbUVsZ3hOdjkrZ0R0UUZEOUtBcTFOQjZDUGdXK2di?=
 =?utf-8?B?RnNldFZrR2I1ak9sOEV3dW5RZFVtR0FkT3hlSXBxTlBTM1pNZmQyWnBBRGdl?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdf4d67-ed43-45c7-eefd-08dca2bf46c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:09:19.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9USCVZyUWeCYHHDsGsonowJT05k0JleRT2p094PjIZGKSUtoLk7tYAWH0ozKpTj4rB0qAijv8TFSN8FqrcMGk4pg80JoAQPOTjN16Ycz3nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7514
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as it is assigned.
> The assigned RMID will be tracked by the hardware until the user unassigns
> it manually.
> 
> Individual counters are configured by writing to L3_QOS_ABMC_CFG MSR
> and specifying the counter id, bandwidth source, and bandwidth types.
> 
> Provide the interface to assign the counter ids to RMID.
> 

Again this is a mix of a couple of layers where this single patch
introduces fs code (mbm_cntr_alloc() and rdtgroup_assign_cntr()) as well
as architecture specific code (resctrl_arch_assign_cntr() and rdtgroup_abmc_cfg()).
Lumping this all together without any guidance to reader makes this very difficult
to navigate. This work needs to be split into fs and arch parts with
clear descriptions of how the layers interact.

> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>      Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v5: Few name changes to match cntr_id.
>      Changed the function names to
>      rdtgroup_assign_cntr
>      resctr_arch_assign_cntr
>      More comments on commit log.
>      Added function summary.
> 
> v4: Commit message update.
>      User bitmap APIs where applicable.
>      Changed the interfaces considering MPAM(arm).
>      Added domain specific assignment.
> 
> v3: Removed the static from the prototype of rdtgroup_assign_abmc.
>      The function is not called directly from user anymore. These
>      changes are related to global assignment interface.
> 
> v2: Minor text changes in commit message.
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  3 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 96 ++++++++++++++++++++++++++
>   2 files changed, 99 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6925c947682d..66460375056c 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -708,6 +708,9 @@ void __init resctrl_file_fflags_init(const char *config,
>   				     unsigned long fflags);
>   void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
>   unsigned int mon_event_config_index_get(u32 evtid);
> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32 rmid,
> +			     u32 cntr_id, u32 closid, bool enable);
> +int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, u32 evtid);
>   void rdt_staged_configs_clear(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d2663f1345b7..44f6eff42c30 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -202,6 +202,19 @@ static void mbm_cntrs_init(void)
>   	mbm_cntrs_free_map_len = r->mon.num_mbm_cntrs;
>   }
>   
> +static int mbm_cntr_alloc(void)
> +{
> +	u32 cntr_id = find_first_bit(&mbm_cntrs_free_map,
> +				     mbm_cntrs_free_map_len);
> +
> +	if (cntr_id >= mbm_cntrs_free_map_len)
> +		return -ENOSPC;
> +
> +	__clear_bit(cntr_id, &mbm_cntrs_free_map);
> +
> +	return cntr_id;
> +}
> +
>   /**
>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>    * @closid: closid if the resource group
> @@ -1860,6 +1873,89 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>   	return ret ?: nbytes;
>   }
>   
> +static void rdtgroup_abmc_cfg(void *info)
> +{
> +	u64 *msrval = info;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
> +}
> +
> +/*
> + * Send an IPI to the domain to assign the counter id to RMID.
> + */
> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32 rmid,

u32 evtid -> enum resctrl_event_id evtid

> +			     u32 cntr_id, u32 closid, bool enable)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct arch_mbm_state *arch_mbm;
> +
> +	abmc_cfg.split.cfg_en = 1;
> +	abmc_cfg.split.cntr_en = enable ? 1 : 0;
> +	abmc_cfg.split.cntr_id = cntr_id;
> +	abmc_cfg.split.bw_src = rmid;
> +
> +	/* Update the event configuration from the domain */
> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_total[rmid];
> +	} else {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_local[rmid];
> +	}
> +
> +	smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_cfg, &abmc_cfg, 1);
> +
> +	/*
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in next update.
> +	 */
> +	if (arch_mbm)
> +		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
> +
> +	return 0;
> +}
> +
> +/*
> + * Assign a hardware counter id to the group. Allocate a new counter id
> + * if the event is unassigned.
> + */
> +int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, u32 evtid)

u32 evtid -> enum resctrl_event_id evtid

> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int cntr_id = 0, index;
> +	struct rdt_mon_domain *d;

reverse fir

> +
> +	index = mon_event_config_index_get(evtid);
> +	if (index == INVALID_CONFIG_INDEX) {
> +		rdt_last_cmd_puts("Invalid event id\n");

This is a kernel bug and can be a WARN (once) instead. No need to message user space.

> +		return -EINVAL;
> +	}
> +
> +	/* Nothing to do if event has been assigned already */
> +	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET) {
> +		rdt_last_cmd_puts("ABMC counter is assigned already\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Allocate a new counter id and update domains
> +	 */
> +	cntr_id = mbm_cntr_alloc();
> +	if (cntr_id < 0) {
> +		rdt_last_cmd_puts("Out of ABMC counters\n");
> +		return -ENOSPC;
> +	}
> +
> +	rdtgrp->mon.cntr_id[index] = cntr_id;
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list)
> +		resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
> +					 cntr_id, rdtgrp->closid, 1);
> +
> +	return 0;
> +}
> +
>   /* rdtgroup information files for one cache resource. */
>   static struct rftype res_common_files[] = {
>   	{

Reinette


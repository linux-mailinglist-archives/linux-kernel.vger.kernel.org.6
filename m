Return-Path: <linux-kernel+bounces-421497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3959A9D8C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C4D285E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0950C1B87C1;
	Mon, 25 Nov 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXeuTfoj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C116A395;
	Mon, 25 Nov 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558687; cv=fail; b=cJw6x5j8YJCTmfINgMtbvAl0pMOlsvVDnuicTxl+LLWsVGap4mdkoJ6XNyn2c1TGukL+PCWRlTFOv48vtA1dFAQ30gZ56owFgEy6myNYMLdABrbapBsUmRkNkF18bZtVNXlwAWqW3rCXjBoWLDAsOKp1a9plB0RitOh5QUoX5S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558687; c=relaxed/simple;
	bh=nQh0r6Cs1HJXg9StD8voh6DexO30QJjOqj2GyYQX2q0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bftnXckVgOxHBSUH2x+IJ2UDahs3H+M7oldNE4gGdxU5dukpZj40hX+5BZk9rx+0vVaVkUPTlvcPOjBu2CD6HDeQ87b7EPcNHd7nBLZRl5dHwYrT7wrdX4+1NvToH1taUr8N6kGpe2cT4Pt/By57idTY4fAp4qJc9wzXxOluuSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXeuTfoj; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732558686; x=1764094686;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nQh0r6Cs1HJXg9StD8voh6DexO30QJjOqj2GyYQX2q0=;
  b=AXeuTfojSvsqp91S3UqDrrn89trIadtxnm34afM4HjsgOIxjTe84KjMS
   YN3qfH7ELtH7A6hoxogYJCn8X2Hjt4umKKD3BWI5AjTnZVZyFuG/Mv3Xt
   kzN4Q58rF/gI2PQB+B1qoGvu0l/BopD1OG5YZksoy9TxhkZ1aKp+kx8U8
   QjKqowPbqDvGXx02HsJkQkhul10hh88kil1OL6+BfqRu4bA8H6dZi8EhU
   3zl2Yh6LglKA87HzJdoqS0CmMjcgE4oypb1AKILjUNr1mpdYGy3oaIaKJ
   yy+jbGgVjcrSLd4e9dJfYw3EgY+6JeF6Nnrsl0pCBbcErTf8xzjMXAMX5
   g==;
X-CSE-ConnectionGUID: W8TWcsmNTp2qDcwGSf1PDA==
X-CSE-MsgGUID: LLLLADNiQTGk58n180Av3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="44079173"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="44079173"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 10:18:05 -0800
X-CSE-ConnectionGUID: opGuNLorQoWLxO3AV/ABPw==
X-CSE-MsgGUID: IbdDWxUTTNSndoYVJ13L/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="92164001"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 10:18:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 10:18:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 10:18:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 10:18:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEnxIhlVlJYxQ2l13eeeyhJqF5YVme6vbI6rYvktVCcnTAvRCjIns1SzkLc4sVYRWJmp84xhgqR9mfj98bPG7Tg/Dft8FWcS5zXaA1kLnw8oLhrfqYufsOEa0mBtxw2Rw5t+5a4ynbTM/ln+wBB9BT4Gw3L4zX9oT9GLJ4+LM2Xv/pwCe8SvC8Z6ZJL42iatb8yks7rfK2QkJxwdoLn0hfRT7fkmyHDs5jvR+Zn78DXsegsmPbBy1lL5neiFrXcR1qD2H6A37JQkqasnzX3pBaWJftfpSIkHzVv/4oVvW+mgasGNodI1qzP9xwiqarM/T2g14xTti1DITKU6PWUJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20XrGK0pWgU0WkBAIDV9pJqtS+vsS8/Ay51/RJj9o0c=;
 b=DUPjzgzmtkbRXVG9W5wEunXeB/6TZghwyuprOfKWI0XaIre6SOBG00xiOrnaQ8HLfxLh8VOsYSN6rYS2RdKlD5M5L57M60l2TtTjJfykd7ttYoUYw++86PD9yaYWPjrj2kZ00tQoiv6aYa5UvFnEXbMZrXY32L8WGItZNQYNtnn9M2sbPHEhfwDGzFNApfkhJj+P11y1jVLP+wRfi7BVsAFBCYosGwRxSRP3cGFbTG7Rm72Smld0YcHFCIBH6wLNLO2yf1VzOipVqaoLFUxo+Yf4v6SP7aiPsrshpBUVwIMg0fgAk3NlES/8L8S24f8ausyTVc5i51ArzF/ehU0OhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7837.namprd11.prod.outlook.com (2603:10b6:208:406::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 18:17:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 18:17:56 +0000
Message-ID: <6bd4335d-4b55-455f-a042-948df227e02e@intel.com>
Date: Mon, 25 Nov 2024 10:17:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display
 monitor mode
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
 <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
 <33cd0cc0-4f81-4a2d-a327-0c976219996a@amd.com>
 <d5bead60-6a38-426e-afa6-e7980a268d6f@intel.com>
 <0eff9462-e7e2-49a9-9538-c8907024322f@amd.com>
 <6c5f8c64-43f6-4145-b0dc-429603f8ee24@intel.com>
 <9fc844fc-23e3-4b58-958d-75c96c98fad7@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9fc844fc-23e3-4b58-958d-75c96c98fad7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb56571-0ccf-426a-3b3c-08dd0d7d7c51
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVAwK3p1cWpMYjlCRHVEVVBJSTlzODBhZXRiU0FvYjRhTHRmbXlnYWtlVmVS?=
 =?utf-8?B?V3c3WnBoczNiRy8xR3l4czVMS0NLTUJLS2ZCYllNbmpCRmFadExMbXBxdGxI?=
 =?utf-8?B?Q3FRNnpoZ1B4bVAxV0hHRjNQL2FHN2xLSVhwWng5U2NURmttUk9XOUd3RW1a?=
 =?utf-8?B?bHFXZUtHV2tLNWZpMEZhTTJTY1hlYm5CQW1pV2FqcndPdWgweE42ZVY2UnNF?=
 =?utf-8?B?Q0FBMHFTNHZraENMU1pPdjBZQWU3UmVTMW1PQVNMZklCZ1llK3VKWEZHdzNR?=
 =?utf-8?B?c3dGSGJZOGYrMmV5SmJEUFJ4eE9iK3duR3dBVUlNWkNpWXVHNG9JdVlhZ1kv?=
 =?utf-8?B?T0x3M1I4UUh3NnFVenAxbUxhVS9YUVlLS2RMdXIrWkNvaXVScS9rYlYzdEZs?=
 =?utf-8?B?amFoWUVIajZzUFFVNDc5RzgwRndpMVl4YlgrWDJWdWg5Z2FINzlBdWVzd0c4?=
 =?utf-8?B?WVN6bGdHbVo0SUJuenBtQXhpRDhzSGI5VjBpNjdEQnYzdmdiVmMrc25lOGpU?=
 =?utf-8?B?SWxQWnVTM3FpN21wdGxGRWJHTEEzM1JPTTR2aWx4QXFFOEljcUlxcnBXV05S?=
 =?utf-8?B?ZVBPN1hDSkIvckgwWU1JcDgrZ0NPOUlFOHVpU1ljYjl5RTVYeDJiNklaQ21R?=
 =?utf-8?B?RnMrUVFWcUFxOVZhVUxQd0JJZTdYWVlSSjlYbWZqRHBDV2V1WjJSUVA2V0dX?=
 =?utf-8?B?V09sSUlnSng4VEt6TWZhaWVPdTdGVHdFeGNEaTNUWktrc1V3REt6cFRiTlNC?=
 =?utf-8?B?ZFlSZTNOeTIzeDdzbExaUG9WUGQ1NWtLTnFtdjB2V0c0eTFsL0l1bUdLbzNT?=
 =?utf-8?B?ODRQekJyWG0wemlnTHIrRjdBdGtDWjRiUUxkOXRTMjRUWXdrc2tMaldwR1ZV?=
 =?utf-8?B?eHNIRHA4djdOc1RLeUVHSTRuS1g0aXhCVjR1alFKVC9NcU44dWViWTJ2Snpo?=
 =?utf-8?B?M2p6UDRpYWtwUGlIS2FXNEZsRytmbG9WcFBuL1FKSnJDcXdMZUxHR2w4NndX?=
 =?utf-8?B?YldPb3JiV1h1RGNCVFBwU05KTFBrMy80U0hpc2ZQbXZ0Y2VmMWtmNXVQeDU0?=
 =?utf-8?B?MmVUUE1PZEZjNVhoMG9Ucmk5aWsweVdJc05LY3pRM1ZwOXFXajl3T2Z4NXJL?=
 =?utf-8?B?WkxEVWRrdjF2WTY3REJKOUwxN3Zha2tGeXdFUSt5MnFLRFBwdndybVdFZU1R?=
 =?utf-8?B?T1hRRTJRSnUyZ2xqenVQdUREWFg2UHVHSWxnUDR6NWw5TkVlejFOV3VrdU9X?=
 =?utf-8?B?OHVJOFI0bG9PdVhkNThENVZMYlZSZ1A5VWhLQUNKL2kxTmZuZ2pmdDNGZ3lj?=
 =?utf-8?B?ZVNKbHZHM2pXczFBZnlxZHBTck54cXVJSVJCVGgvbzQrcm9wbXpxdlo0V0RE?=
 =?utf-8?B?UktMUGszNGVrM0hXKzN5ZTBKbXNBam1DMy8xaTVBTlJIeUE5cVBXZWh0Tytw?=
 =?utf-8?B?aVlYdllMM1h3OEtOZUJuWkRFc045Zi9xclR3NWhGTGZCQkhVTDZxTFVXWk96?=
 =?utf-8?B?NWZRQjJTRGlzK0hXNEd5cFVDcndhaWc5U1BiZU5kc1VpMWt2Vnc2bjJ6RlVJ?=
 =?utf-8?B?OFZqWTJoeXBrVnNQQTJRVDZvSXRNL1JWdWdPV3poSlkwMEFqMEIvemRwdk5Z?=
 =?utf-8?B?ZEd0OTQ3b3Vwd3JENm9zdmFYT3NXTDFnYytXWnorZS83UDhLR251d1RNQ0ly?=
 =?utf-8?B?UVRLZnZDTmlwQ1kxY0JFemlTeCttWU5CdDIrR0Iycnk4OWlwYVlzNit6a1Jq?=
 =?utf-8?B?bklRTlNwNFpSQk1RS1doaWJNcEtUSXNwWHJTWVhyeUU4RGFQTmRpMDMyZDJ3?=
 =?utf-8?Q?g/vtzz0cZkI+BOrKqZd8MXQNKcbNrZuJ5oCDk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5FcStyQVJQREpjYTlrRnp6dUZHNFQ2dXpFMHlDM2R4THMza2ZsTW9XTmFB?=
 =?utf-8?B?Q3FiUDIzc3gxQ2V0NFZnODlkbXJNbXdJNGtwOGZMdVNSNlY5UkdJSlR3V1dq?=
 =?utf-8?B?Ym9lcVh2OC9BS3pvUTBPd0tqTno3elh6YmtuYnBTYk1IbDU2YXk4NWVJSjYx?=
 =?utf-8?B?cFVKSkRrKyt3OGN4NGlaWk5HeFF3NG9SdndRdmN6RzNmR21lZmhWVjBpeGZR?=
 =?utf-8?B?ajJlQU1TYnBZOFRGR29kd3FNZ2hRZWRyS0FqVGhPazBya0svL3JpOWNHL0Ft?=
 =?utf-8?B?SGVsL1FVbkhCMzR4RGxESEs2d214ZUpGaDBzc3dNcElvUVJIWFFEaFllWWNi?=
 =?utf-8?B?ZU9sTUx0MTJjVm04Y0l3ZHNDU0UrQ2NBNWticmxPS0NWR1RXbHRLd3o3OERF?=
 =?utf-8?B?OWNNd1NOQi9jcklBNFVYeWl6eE4xaVprQUZzOHhVMmZuWGFMYzlkMWZLQ3hQ?=
 =?utf-8?B?NkRMMW5oTDU4Qm02MENneHRrczg2amVlOEZCUWlpd0phaG11RHVQWUQ4b1Uy?=
 =?utf-8?B?Y2xhT0NocThPZFNXcGc0d0Fza25SSUZGOTZ1NU0xYnZ6OGVweURKZHkyWG9E?=
 =?utf-8?B?eUxtVUdYcWw0QzdySjhaVHZ5VkFJTk5BRWZ3b3IwNGhFVkxXTlI4UjVxOTJs?=
 =?utf-8?B?NXhkWUF3Zm9jQjJhQ0VEV1paN0FFK0JISjVZcmoxQmFaOHJvUHRlZ3BuMjF1?=
 =?utf-8?B?MkpDK29HalpSRWFYdmZWKys4cnVLT1czdnZMbXQrbHpiYWVNRzhqTkFnbS9Y?=
 =?utf-8?B?a0JkYi9LQ0FTNmZML21ndlZoRm0yN1o1RGV3UmVPT3hESjZWRTExZ1o3Y0RX?=
 =?utf-8?B?S2F4bitYd1NyNm5oWDB4N21OTUxCRDczcEJyanpEemFQTVp2ZysyMFdmTytW?=
 =?utf-8?B?L2pnbzZpTFl0NCt4dmN1RjRPUDVnU0hTYjBjNzRLR1BtanY2VXltUUV6cko2?=
 =?utf-8?B?NFV6dVloQmY4NXd6UWxRVFVyQmRJalBUMnJvRGZFNWZoQlhJU0llRk1BVDd4?=
 =?utf-8?B?WnBFR0g0K0tLdzNjNG41SjBkSmV6MEYyZFUwSFJ0eDdWT3A0NWRMZVd1amtV?=
 =?utf-8?B?WExiVy9IemttL0I1U255U1habkR4N3NOK3dlbDlsQnV3TkhML2lHSStDOTNp?=
 =?utf-8?B?akN5bHltMXk1SnpLdVR5Rzlsby81R3lRTkxIUUNkMzVxdnM3d2szZG5lYVB5?=
 =?utf-8?B?b1pzTTlkY2VJenNGQUFuYng1VExkNW1STGFnV2xES3dkZTl4aW9udmlzUTl2?=
 =?utf-8?B?WGl5Mnd2eVRNOEljOHNFaFNUVTg5c1pmM2JrOUNmNzlVVU1VWVhTNEsydktn?=
 =?utf-8?B?WmhkQUw5c2N6eURzNDZXTHgwUy9ZR0FpT2VxNGNPbk5na1hIS1Z3Vmw1RHNI?=
 =?utf-8?B?ZUJEa2s2bzNBUk1TN0JoTVU5WW9xRU9BMXZTMThOaWxyOWxpSnNuSTdzeEtN?=
 =?utf-8?B?eGszek13TzNJQ1J3SllJcTJxajJTU3owdU9FTCtVenlxU0J4ajByZEhITTZ4?=
 =?utf-8?B?aE42dXpuRjhaazJyQms3QU5FV1dwR3FndlAzRzI5ZW40MTd6T0dOUHNqTFRT?=
 =?utf-8?B?dTFMMVhQaE9qOW9DeHdBaFZBVEFsVE9HU2tRdENvQlJRaUMvc3RYUENjb3o4?=
 =?utf-8?B?N3NwYmVORFhQYXNFS1BJclVNWkFlYnJFUHJVbTFMOGg5Q21tUkViS0JiSGVK?=
 =?utf-8?B?T0EydnNXaC9rNGhIQzdxcEJQUVN6RVhwL053RXhtVWFBUm0zVE5ZaitZVnUy?=
 =?utf-8?B?T0xGSm1QeXd3Q1BpTXo0MjNkK2hpNWo0NjZHNE5XeGJPZWEvRFBOM3Q4MDBi?=
 =?utf-8?B?N1IvcnNNRjB0d05HUTFwSEo1ZUxCSGh2U0tsNC9ZQ2NFc05xYjQ3VzJYY2V5?=
 =?utf-8?B?Qjk1Q3laWEcyVWZ0eWhZTWFaNHZrVUtkTnYrQUthdFRNVUxEZ00rTm5qWkNN?=
 =?utf-8?B?UlhsNnlXZ3RaK09CK285ODNkc3o0K1NQSVBhWkhKdy9iRmJEZnlDRm5XNGh3?=
 =?utf-8?B?T09sMGxrLzhYWnk5VWo0NkhzWUpYSDRORlpiZEtBTS83Ri9RaTdyaE9xZ3E3?=
 =?utf-8?B?UUJTOFFtRnBnQldvOWJ2N2pXTXByKy9rN3d6NzdDN3F5eVpoa0FxSVdXKzFV?=
 =?utf-8?B?aXNTb2diU2NpRnVPTnV6MERrUVVRNElqc3U3M1pJTU42bTliQy9HMmtCYTBi?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb56571-0ccf-426a-3b3c-08dd0d7d7c51
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:17:56.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbeyMV2xOopuL726aWMKATyQYroGnJU1EHfbA1XEA10lGUGxSe0gpxf2HZEm6ssNNp1bf1Tij3O+ZDrcviHQeBIJIPfHbXSscPGCU/IBxjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7837
X-OriginatorOrg: intel.com

Hi Babu,

On 11/22/24 4:02 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/22/2024 3:37 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 11/22/24 10:25 AM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 11/18/2024 4:07 PM, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 11/18/24 11:04 AM, Moger, Babu wrote:
>>>>> Hi Reinette,
>>>>>
>>>>> On 11/15/24 18:00, Reinette Chatre wrote:
>>>>>> Hi Babu,
>>>>>>
>>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>>>>>>> supported.
>>>>>>>
>>>>>>> The "mbm_cntr_assign" mode provides the option to assign a counter to
>>>>>>> an RMID, event pair and monitor the bandwidth as long as it is assigned.
>>>>>>>
>>>>>>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>>>>>>> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
>>>>>>>
>>>>>>> The "default" mode is the existing monitoring mode that works without the
>>>>>>> explicit counter assignment, instead relying on dynamic counter assignment
>>>>>>> by hardware that may result in hardware not dedicating a counter resulting
>>>>>>> in monitoring data reads returning "Unavailable".
>>>>>>>
>>>>>>> Provide an interface to display the monitor mode on the system.
>>>>>>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>>>>> [mbm_cntr_assign]
>>>>>>> default
>>>>>>>
>>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>>> ---
>>>>
>>>> ...
>>>>
>>>>>> I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
>>>>>> to make the event data "more predictable" and then be concerned when the mode does
>>>>>> not exist.
>>>>>>
>>>>>> As an alternative, is it possible to know the number of hardware counters on AMD systems
>>>>>> without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
>>>>>> users to know if their platform may be impacted by this type of "unpredictability" (by comparing
>>>>>> num_mbm_cntrs to num_rmids).
>>>>>
>>>>> There is some round about(or hacky) way to find that out number of RMIDs
>>>>> that can be active.
>>>>
>>>> Does this give consistent and accurate data? Is this something that can be added to resctrl?
>>>> (Reading your other message [1] it does not sound as though it can produce an accurate
>>>> number on boot.)
>>>> If not then it will be up to the documentation to be accurate.
>>>>
>>>>
>>>>>>> +
>>>>>>> +    AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>>>>>>> +    enable this mode by default so that counters remain assigned even when the
>>>>>>> +    corresponding RMID is not in use by any processor.
>>>>>>> +
>>>>>>> +    "default":
>>>>>>> +
>>>>>>> +    In default mode resctrl assumes there is a hardware counter for each
>>>>>>> +    event within every CTRL_MON and MON group. Reading mbm_total_bytes or
>>>>>>> +    mbm_local_bytes may report 'Unavailable' if there is no counter associated
>>>>>>> +    with that event.
>>>>>>
>>>>>> If I understand correctly, on AMD platforms without ABMC the events only report
>>>>>> "Unavailable" if there is no counter assigned at the time of the query. If a counter
>>>>>> is unassigned and then reassigned then the event count will reset and the user
>>>>>> will get some data back but it may thus be unpredictable (to match earlier language).
>>>>>> Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
>>>>>> "unpredictable" event counts (not just "Unavailable") ... this gets complicated
>>>>>
>>>>> Yes. All the AMD systems without ABMC are affected by this problem.
>>>>>
>>>>>> because users should be steered to avoid "default" mode if mbm_assign_mode is
>>>>>> available, while not be made concerned to use "default" mode on Intel where
>>>>>> mbm_assign_mode is not available.
>>>>>
>>>>> Can we add text to clarify this?
>>>>
>>>> Please do.
>>>
>>> I think we need to add text about AMD systems. How about this?
>>>
>>> "default":
>>> In default mode resctrl assumes there is a hardware counter for each
>>> event within every CTRL_MON and MON group. On AMD systems with 16 more monitoring groups, reading mbm_total_bytes or mbm_local_bytes may report 'Unavailable' if there is no counter associated with that event. It is therefore recommended to use the 'mbm_cntr_assign' mode, if supported."
>>
>>
>> What is meant with "On AMD systems with 16 more monitoring groups"? First, the language is
>> not clear, second, you mentioned earlier that there is just a "hacky" way to determine number
>> of RMIDs that can be active but here "16" is made official in the documentation?
>>
> 
> The lowest active RMID is 16. I could not get it using the hacky way.
> I have verified testing on all the previous generation of AMD systems by creating the monitoring groups until it reports "Unavailable".
> In recent systems it is 32.  We can drop the exact number to be generic.
> 
> 
> There is no clear documentation on that.  Here is what the doc says.
> 
> A given implementation may have insufficient hardware to simultaneously track the bandwidth for all RMID values which the hardware supports. If an attempt is made to read a Bandwidth Count for an RMID that has been impacted by these hardware limitations, the “U” bit of the
> QM_CTR will be set when the counter is read. Subsequent QM_CTR reads for that RMID and Event may return a value with the "U" bit clear. Potential causes of the “U” bit being set include (but are not limited to)
> 
> • RMID is not currently tracked by the hardware.
> • RMID was not tracked by the hardware at some time since it was last read.
> • RMID has not been read since it started being tracked by the hardware.
> 
> All RMIDs which are currently in use by one or more processors in the QOS domain will be tracked. The hardware will always begin tracking a new RMID value when it gets written to the PQR_ASSOC register of any of the processors in the QOS domain and it is not already being tracked. When the hardware begins tracking an RMID that it was not previously tracking, it will clear the QM_CTR for all events in the new RMID
> 
> - Babu Moger
> 

I think I am starting to understand what is meant with the "count the traffic in an
unpredictable way". From what I understand the hardware uses the "U" bit to indicate
that an RMID was not tracked for a while, but it only sets this bit on the
first read. After that the "U" bit may be cleared if a counter can be assigned to an RMID
afterwards.
If it was only user space that reads the data then it should be clear to the user when the
hardware limitation is encountered and thus hardware behavior can be "predictable", but since
the overflow handler runs once per second it may indeed be the overflow handler that
encounters the "U" bit and that bit is not currently handled. This could leave user space
with impression that events are always returning data but that data may indeed be wrong.

In another thread [1] Tony confirmed that "U" bit is not returned by Intel systems so
this issue only impacts AMD. As I understand the other scenarios in which AMD systems
can return "U" (the first read after assigning an RMID and the first read after changing
the memory config) are all scenarios that can be controlled by resctrl.

I do not see why unpredictable data should be addressed with documentation. Could this not be
fixed instead? Essentially stating "AMD systems without ABMC count the traffic in an unpredictable
way" seems like a poor user experience.
What if instead resctrl handles the "U" bit better? For example, when the overflow
handler encounters the "U" bit the RMID can be permanently marked as "Unavailable"? Would
that not be better than the counter behaving unpredictably with users never knowing if they
can trust the event counters?

Reinette

[1] https://lore.kernel.org/all/ZzUvA2XE01U25A38@agluck-desk3/



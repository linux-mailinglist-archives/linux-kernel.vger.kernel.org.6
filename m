Return-Path: <linux-kernel+bounces-367145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB699FF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D62E1C21F53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DDF16EC0E;
	Wed, 16 Oct 2024 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1Ql4aMg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A319614D6EF;
	Wed, 16 Oct 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729047965; cv=fail; b=kfpaUtBtW5sIGueDee9SjQTKHwudRFErQlxdx+dBnrtMN+YtBRJbp9poPY+KmSCIXzADYkcByySrIppckJamtP8isg2oRrTRMicoH0so2w3y/GjVF5UymUjL4YhVVPZyW+ZmaAv+eJK46cfooGxXgvzda+a++hGMFRQeCmE+ZRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729047965; c=relaxed/simple;
	bh=lFkAxSKokk5nmc80/GW7fc+bXir2s3JpLOUg7cLzrfI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lDTI30dIDCs61MbH31oXH9F8H12xAc2JnBs17ekMrVMbhIL9f2WSTc1o+q3HCkG1JiXUpHSAOaxuFyC7PdSfKfAtJT6bZgNcPFK9/pOTCmmVKyTUqhEPrvn126MYaGDrrNDqkPld4rMaBdp0xGylc/spQar6Gd+swbH5h12PkHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1Ql4aMg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729047964; x=1760583964;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lFkAxSKokk5nmc80/GW7fc+bXir2s3JpLOUg7cLzrfI=;
  b=h1Ql4aMg569rKlWCNRH/PHVqd+MLNG/5SyHLy4DVoNWVIvNVnDurhO3R
   73mY9qNN2ayvdY7bMqUZ1zUoZ54G/slPjCfkQ3O+7Z1CqVcHv21/01blq
   Akt5ClMAgFRKd8aALD8NsE1z84IU4CVAGH6iGsTiaxN7RPmYyG/T75i7q
   7Lf8zburT3UFWcWli5xXBgbBYurZzk8TfE/ogGDHMmtMXtSh3kywr9dbk
   cYriE4X0wl0uY25jCx/h7IPL4vuJxywbM349rvQSB06tKq0sOx2CfK5gq
   MZy9g0vvZdhaNEGR7sv/oShQUOrVYr7tY/9kWJzbAs2gHvjQ2hEoD/sui
   A==;
X-CSE-ConnectionGUID: qHX1QZ/1QVGL7NmPzyHokw==
X-CSE-MsgGUID: qstRxi4wT5+7/RJDtet7Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45953940"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45953940"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:06:03 -0700
X-CSE-ConnectionGUID: K32lH5HUQ8metGd1DMzgVA==
X-CSE-MsgGUID: eEEKjRSFTx6pcs+SoRjACA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77979761"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:06:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:06:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:06:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KU6Jvau0vOV1WpxqL4PYSiyFkkPYiwAqEmoXApOtRvLnnOwgfBuH2KcfuZBsPm8s4MkYfUBWWnwAwAkIoNBRrUx5okpqwBpYHo4jnOvmahfe14hehNh07KgYZUespdS/Ulw0/UoiqLN2dxqAQD5H+3n6FCNqD7rmYHk9aCGIpTPMfZlrDE8ymg0JdGN5oMWqi/nrGsp2aVh3xqsv8deAMXxLhY+o7EJ8wD1YGlBp2AQhxFUp22PjS/C55mlfF8qLmag9PYO1vIZJvrO4iNWhp/dJ4pMPqQqQScBfxAfXo11K72AzcPnzbydXuYoHnegael4if5GWe5N1qGR9VCO1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3SYdIoBfpClBwRjWLNKKp1uh0p83foG2aPBPZ9nnSg=;
 b=n4xkLfVBK434QC0az+edMeekaF/XSytvFKP4p/rXLZol1P9s8F5dNkDzYKj9JmDuFsaS8FojOAh0VJ8DDYPqZwAq4riI13ffDKrTLmGg60YCYtJXdBMjEo2AXOW2G0wSaAWfQe3nrmofehWzOQBo839ClQ2w2yeEVitTaijBLLow9VzfTHfcKxGxO+3JvrsU/ZHd3bKd30BmJlyb+5Tw6KSyGg8O7ojJt4uxJO1RGcTZ5gXKzpMyIRjkCc5fmk/hfTWd9uBOm/zqCGSSxrLKlqeTD/ymQ3/835psAw011Rt7hPSRumXx2LxfNBa8XG8LMzfWbCc2tVL3rMERj8p/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 03:05:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:05:54 +0000
Message-ID: <9bc745ed-2520-4f33-85e3-881d3bf6aaab@intel.com>
Date: Tue, 15 Oct 2024 20:05:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/25] x86/resctrl : Support AMD Assignable Bandwidth
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
References: <cover.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0323.namprd04.prod.outlook.com
 (2603:10b6:303:82::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b68f0c-bfa0-415d-d643-08dced8f72dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2U5VU4xcXhCL01QSVY3a1ZzVlE3SWkxVGNQUVJTVncyWjlrVjdqR0NCZ09G?=
 =?utf-8?B?eFp5WTNnamNkQ3YyNzVtY01iNURoYVF5dWg1REpkTDdvOUE0US8rYWlTbXlO?=
 =?utf-8?B?d09EYVNFNmxqeUk0NlVkR1p0Z3MrTTI5Qjd3MmNWNndiQXJKOWdybDF3MmZk?=
 =?utf-8?B?STZDTDNLSE13UUFmTEQrbWJreS9BdTZZbU5USkdTN2JDNUx6WGVHU1dMaE5h?=
 =?utf-8?B?UWVJY2dRcWc5a2tieWU1RmFmVWVSUk9xcjQvMXZOWTVKdVdVeTAyVHNkRWhq?=
 =?utf-8?B?NlVrV0VYT2JFVnZpYzFaY2kvMnR5NDVpZEFhelNNTE1vZ1NhYktNVFRoNkV1?=
 =?utf-8?B?S2NndG9kdE54UFlnRW84NDRkTXMvbnlpckRRVmpwRzdqN3ZWZ0s2c1poenFL?=
 =?utf-8?B?WmVCQmZTL3o1Ukx5UHVQcFY0cFord0ZlckhRTnYxZDNpSHBmTHhsTVJKamJW?=
 =?utf-8?B?c0R1MzRmZElXUnE4TWk4eUYvblFkTFY1Y0VEckVQUGZQNlRFYkNSYnJmcUF4?=
 =?utf-8?B?TUlFZndaWEZFdmhLMEtrcWdNME5ndk4wUDdBM0NoRkxXZ1VFOU92RHhTcGV5?=
 =?utf-8?B?Vk5NanNacHNkamM1WEJ6QUptMGk0VzhIYlBpb2RxMGZPNFlldWVYR01OUGl0?=
 =?utf-8?B?cW5CN2FRK3daR3Q2TE9FVnhhdi9CenR3WVByS2NJdlEybjFkNDBMRjljeGVq?=
 =?utf-8?B?amF6Q05IUnZEd0FDY2kraFZETndMaG1kajVqV29LbmdqeEpjWE4zR1hHMHU4?=
 =?utf-8?B?aGsxcThIVUZNQ1hrZ3lIaUdubkFKNDhxWThHK2t1bzl3TWZlT1p2ZThDY2JF?=
 =?utf-8?B?cTFvZUZVa0J5SWtoNG5uUHRIdmk4S2hLYThJemxjeHFkcGR1emxMUDkybkdp?=
 =?utf-8?B?aUxPRXNOTFVhM0prV0FEUG00ZHpmRTRGZHBISjJ4cTQyMExHbDc0RjBoeS9S?=
 =?utf-8?B?SjUwSzJXZ0dVTmVHWERHb0lna29iUHE1V0t0Yi9OZ01ML0N6WFR3T2hkSHVs?=
 =?utf-8?B?aGl1ZUdDUzFWeGFubnEwYVkyNUxvMXVTQmgwelVaU2xJT3RlUUJEdTJuOU1C?=
 =?utf-8?B?MThVa2hLRFdlMXQyOTZqd1J1eENsMzJXRDY2dE9ISFIrTDBDYWJEc2ppTGUx?=
 =?utf-8?B?cCsvbzZ6b2ZLMXE1akdUQzdXYjZzNE9aSjIzcE5sVVBPcGlsbFR4UFhwRjUx?=
 =?utf-8?B?Y3o1ZWpzZENwWjRZNC8wMlArekZ1NlhrWmFQbUdmQU5tSm9kc3RWM1BxYkdN?=
 =?utf-8?B?ajBVUWZkVXVTbGlzd3c4cUZIS2VwUFpvbUlXYll3ZGVWVG5FV3RHdUtKTzFt?=
 =?utf-8?B?ZWtLZUZrb1JHN0txN3hwYkRhQWEzOGd4Zy92NlAvZ2wyNkVyZlpnYVdWdDh3?=
 =?utf-8?B?S1ZPOGxVbzlKS1N4UHlub2dLSTdZYW90NWFXd2FoRnExc3IxSWZiWEEyUURW?=
 =?utf-8?B?WXQvbkNBeTYyZ1lzdjNiUXBWMTRWNkxGZFdUa2djRUNNRy8xVTJXYjRLckpi?=
 =?utf-8?B?bTZJQnZ6dVp2V1lmQXBycGFoK1dYMUtaZ0Z4Um9mNmpaQ0doU054Q1NaRHhW?=
 =?utf-8?B?bVNwQTAyQmYySEREaTJaMkdhNGEyaHEzODVUSDV0MGYzVDZ5elhqYlhkOWJH?=
 =?utf-8?B?c2cyanI0dGJCbE5vT1FBa1BzZC9iQmZXb1AyWjlzSWVSa0RSempYdjZTQms4?=
 =?utf-8?B?UnZqcFdGazhveUpmbHlKalgxSGRoV293aUdya1dRdEZ3eGtBMXBBR29RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3pYc3c3KzhkYjFpekZHUFNvYk5RZVdidHpkWDFZRW9qdjNtc2s4V0Z3UE1i?=
 =?utf-8?B?NC9HRDM1NjE1VitpaUwwOUpiMmpCc0N1bHgrQW1kUTVsWjdYSEFnN05XQm1u?=
 =?utf-8?B?SnFHSjNnVmNycFFOQitoQ1hYNEVFdkVPMmx4YjAzazViWjZVWEx0LzlzMHpn?=
 =?utf-8?B?QnF1U3Q5anhaRy9mcTNFTjJCQnRRZEF0Y1MrRTc4Z291N1YyQVVEQmdSWWNH?=
 =?utf-8?B?bjUycUNrbUpNeUF1UjI5Z1UxaTBIbjd2d1RaZzNaUU5SMkNCZitJSVVVM1No?=
 =?utf-8?B?cWpTOXdTbzZrcTBHS01RZW1QWlAzRTl1K0ZxVk1BSTFhNXNVUDB6OXkramsr?=
 =?utf-8?B?dXhlTkpia2hkUkRRU0JxYTIxNU5uWTV0bUpERmd4Vmt3SHZ3Y0hyNElmemNu?=
 =?utf-8?B?Z2ZxL1ZMOWt0bmZwZ05HRTEvQmNocWdFcHUyMFEzdEY5ZGdvNUwwdU1TOFB5?=
 =?utf-8?B?UnlWUWRDQXpQZE5mekFWMk92L2YwbGI4TU5GaFZDd2RTYlVEQjc4WnBmUWhR?=
 =?utf-8?B?UGJtTkl1WUk0NlhyR2tUZ2k2eG5aMDNzd1Z1aWVaYXdCNkFYcU9zMnkxUm5z?=
 =?utf-8?B?eHgzZ0E3bU9Ga2phNHBmRGNCUTB0MVJTS0RhRjlVTzhqZ3R0djliN1NDRnhI?=
 =?utf-8?B?VnduRXp0UkVBRWFITm9nNmxOTEVtQnRpZmpxWHVtREtINDgyUjhEY01YVDJm?=
 =?utf-8?B?Y1FhQkcrWEU1ZEVFNUsxaDlmRktZZG0xd1RDUjBxZ1Z1WW5tZWtkOVljWk5T?=
 =?utf-8?B?TEh0SmhSM1FpaDJCaUswUE5JR082UnJPNTVrNStDOFcvc2JMaU5sMEI3M0l1?=
 =?utf-8?B?Z1JaQndhWVBubWU5K2dwM2NmT0FDbTlmeXVaR2Y3TmVjRmgyWExlWUJnOStT?=
 =?utf-8?B?dWIzZTF0TlpaYjZDMkI4VEJUL1B6K0pVNU52VjRZNWJVeHQycVRldlNWc0dz?=
 =?utf-8?B?K044WC9TVHpvZUZETWVINzZXQlYxL2tyQnlhZ3ZBSFhMc2dVU3ZuY3dyOGJi?=
 =?utf-8?B?aHIxaUIvSmNVUFJUVDl3aUVrK2YvWEp5aGp1cFBuR0x2Q2pNTDUwY3hnS2RP?=
 =?utf-8?B?U3NRanY1SWV6eitkZ2FFTkpCNkRORXJ3SjBiTGFoU2tnNWtPbTFYczUvYmtW?=
 =?utf-8?B?aU5IaG5KcjZ6TXBsTGVBb3Zyc0t2S1pHVjlSOThMQmo5bmtvUVRhUG5ZRVlx?=
 =?utf-8?B?VjhJZkp6SGE3V3hRVVAwa1cwZkcwLzQxYnRKSHR3eW1jdjI4ZENzWHZmK0cz?=
 =?utf-8?B?SlZGa0J1dFFRNWxXN3QrbE1ucTJ2Z1VjbERmbE8wMHBCU09Tbk05bzNtVVZU?=
 =?utf-8?B?cXRMQTY4RU9Fem1tcjB3RzBwQTJZWVBRMlVGakdyK0UvWVRBUTlNM1ppWXRS?=
 =?utf-8?B?ditVL0NpWnNnNnhNZ1lEbFRpVzhDalpobzc0QTJTQnhLTkdBQlEyaTQxZE55?=
 =?utf-8?B?TXhXWURrU1gzWGt3UnE1cHYxVFhRM2VlTmJkOHlvMk5FNkhvbFBibENXK2Vt?=
 =?utf-8?B?dVh4TVhPWXZBKzVmNTNzd29CWGpsNVZYamcwOWIwajFTZGE2eU5vekNZcTdX?=
 =?utf-8?B?UUI4Z2cyMFVWdm1WRVRHRnh1UmhsMm10K3ZZcEluWXpINlJkNndKaTBSSS9T?=
 =?utf-8?B?V0ROVlBIV0NQelNjMUErMTVJWldQQmpFUllCeXdZdlp1aXlJMjNsZmh0TmFU?=
 =?utf-8?B?WGRPRGdTTS9KOHhIQkgxeXU5TWMyVDR0eEJNQ1ZVQVAyYXcwZDBsZzRKL3JV?=
 =?utf-8?B?RGNHODNLTVZZbFRHc1RqSzI2NFd6UGovZHVYcnZta0ViS0dTelBhdGIzUTg3?=
 =?utf-8?B?Y0FZSkNwRXgydFJNY3JwdWhWZ3o2b0FMTU9EVTc4TmNncW5hUTMzMEc0YzJP?=
 =?utf-8?B?S3ZrbFVsNlpCeW5IRkFDVDVQdzBFVTdhdzFWWEpub2grRlFJb3VYajNvZWwv?=
 =?utf-8?B?Q0p2MEdsUXRuQ1NCSHVPTmxSZk9sdit6NEk1VHJnTG9yam5oT2RYc0FSaHlh?=
 =?utf-8?B?Q01wa1dkeENrSEtMZElNMldIMVJ4SUk3Uk9IL1lyMFIwMW1iN0xkY1dIZXF0?=
 =?utf-8?B?MitibUFnT2Q5L2F3WGxObWM4bElVWWFqeWgzRy9XeDJvVVoyN25KcDZFaEYz?=
 =?utf-8?B?Sy9zV0NrdGlZb04wYW55L0c4Y1ZmMmFmK2U4QjZNcE9KUFBXUlQ3cE44a2RI?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b68f0c-bfa0-415d-d643-08dced8f72dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:05:54.4072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gO6iK7O8LGvCif3LerFDS9UN7f1RpJDtFRCEcrNKmQKd6d7yWd/5b7MVAcsuMJjw1FpSxzgWTcEGouJjqTE/F0LWoKgP45Xh/RkXW9nkcPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> 
> This series adds the support for Assignable Bandwidth Monitoring Counters
> (ABMC). It is also called QoS RMID Pinning feature
> 
> Series is written such that it is easier to support other assignable
> features supported from different vendors.
> 
> The feature details are documented in the  APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC). The documentation is available at
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> The patches are based on top of commit
> 5b0c5f05fb2fe (tip/master) Merge branch into tip/master: 'x86/splitlock'
> 
> # Introduction
> 
> Users can create as many monitor groups as RMIDs supported by the hardware.
> However, bandwidth monitoring feature on AMD system only guarantees that
> RMIDs currently assigned to a processor will be tracked by hardware.
> The counters of any other RMIDs which are no longer being tracked will be
> reset to zero. The MBM event counters return "Unavailable" for the RMIDs
> that are not tracked by hardware. So, there can be only limited number of
> groups that can give guaranteed monitoring numbers. With ever changing
> configurations there is no way to definitely know which of these groups
> are being tracked for certain point of time. Users do not have the option
> to monitor a group or set of groups for certain period of time without
> worrying about RMID being reset in between.

"worrying about RMID being reset in between" -> "worrying about counter being
reset in between"? 

>     
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID, event pair and monitor the bandwidth as long as it is
> assigned.  The assigned RMID will be tracked by the hardware until the user
> unassigns it manually. There is no need to worry about counters being reset
> during this period. Additionally, the user can specify a bitmask identifying
> the specific bandwidth types from the given source to track with the counter.
> 
> Without ABMC enabled, monitoring will work in current 'default' mode without
> assignment option.
> 

Reinette


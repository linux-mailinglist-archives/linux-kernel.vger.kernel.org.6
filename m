Return-Path: <linux-kernel+bounces-400725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46069C1174
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25D61C21E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779BC218306;
	Thu,  7 Nov 2024 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQUt/PSS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3F215C6D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017025; cv=fail; b=C4yT/spKYsQ8mbAnpyUXZN8KHYlZeDzOFtoGLN7NCbea0t3wKItqFnSYSSjtkVTFcil5HenRorV8CiE3rS/7VpSxCnmQk9u7YiR0js36R0fRy4+e1HovVJ5w6SoMh4tl9t9wGcVbqhK3iZKR3F1n2Shs3ypgCJss/6rClzBAC7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017025; c=relaxed/simple;
	bh=kV5jfqyXFKismzo3+ZKHQYO481YI5eMHLnHHzMyjFs4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jOyoyiATWLKP5V1CE327aosc9F7JI5aAMT/ICZjryMmW2MRYoP/E2eenPfzFYznYLTO2gqGLFis4OAkQbDbqsfag4nMAP7WyKRcwIEKSfsqvy2mYYSdbNPQ2weINX9UeS3OblxfZwsztDdZh/LyVCxh6l6Aw/Ovj9aMVL0gjjuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQUt/PSS; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731017024; x=1762553024;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kV5jfqyXFKismzo3+ZKHQYO481YI5eMHLnHHzMyjFs4=;
  b=QQUt/PSSSupiK3LjGpjhLoJ8xmzPb3IQbXwIpoX5KGW2GyKVEx3nC6RM
   uEZ46kWpn3bL9LuMBaXwfXk7DU8SukGeSSZL/snSLu4kiHrWywYg8na71
   a05w1k/WYBWPDumvwrz92kSUL1B0M4LSJO1HRNdU9XTUzFqRH/Hf1AGzD
   SBgABmS0ibLfPCj0ggyreGyMByOVpImUPNWR0TXdIyjpdrUJ6Bn6IOIVb
   M0BpUd3wlZ7U9aMysxpjvuUVun/tAXbDS1k+2YasIL+OYWFVuOk2pBuIe
   /c7GgwWRg7TlpzCQbNtpGQdyuGp0KFs01EzdkLJbGoRjGFz2JEvd1AHqr
   w==;
X-CSE-ConnectionGUID: c15LNPWlReW6u/3Iqgit7A==
X-CSE-MsgGUID: niIyRhicRRi6iPJfaLmvbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41506135"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="41506135"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 14:03:43 -0800
X-CSE-ConnectionGUID: cBSCAji+TQS4xvSyZentUw==
X-CSE-MsgGUID: NKQYsT9KSrOD26wQC8A4MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="108526269"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 14:03:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 14:03:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 14:03:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 14:03:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZZtEDDVnuOsMAynL+vKCmZIbkcDFApHGybw9ipKpi4Gu8t2FBAgh3pleUdpgLPL9Lui2DFZKmL3gPxBe9PDFF7NEmsdBNEKO56n1ab4mFUBOZ4JJZuxRWlYLMWNmwGqxfCHE6OjsXzW0yBpgiOzvrD5JAD62q56VInoe+sN9akF0fhukAF0eqUHk9pn2QP8TtjKa1QhI5SyRvYiNZR/Krz9cWZ7KRHZTXgW8df7m+6Sla/NRodEIh7GBnqX+H79FQTsoa+iuXpX8dRGEphWFBMbPsAttuINsiIsoPHjhBlywnNTW4G6/npzErUwkWr2t9GPy3C+CQW3mLF4hG7AYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9bTnOIDksgi6ZFUGEvuT2MkUwcElKq9iIUWvCAKId4=;
 b=l3KS2G4zZsXxt47RQt1TUfgCFnV5YNax34M9MrWmWl3bRuynuqL1EaF0iTXpAcn2tabO24RgLuPvvkd0D8Wfb3udDLtP5M5YEeKwDXhyTx6MFyQbsW6A4qLbA5xOu5579z3f1nvq0YYYPRKgpc/5OUpEUTCDHakh6UzF23CRoNYl3HMsO543DTZlr+wwSekGathnoFmTf8yQRTXtv6AJ1ZFMv1ZikM63u4w/LrAh2Xa77aKT2E0gpDBQ69NQDpOkTDJzv+cSt98+YhyxqebEof9jZVxAfKM0UldHwWxocoqQ961SN1KsSo82eZduKiLWWrsWat1MwAj6JncFOHK9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 22:03:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 22:03:07 +0000
Message-ID: <c4ced27a-b3e9-4727-9c39-7d1fd0cb0dd2@intel.com>
Date: Thu, 7 Nov 2024 14:03:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
To: "Luck, Tony" <tony.luck@intel.com>, Peter Newman <peternewman@google.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Eranian,
 Stephane" <eranian@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"nert.pinx@gmail.com" <nert.pinx@gmail.com>, "tan.shaopeng@fujitsu.com"
	<tan.shaopeng@fujitsu.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
 <ZyzxbhHQptbktfGH@agluck-desk3>
 <034d8377-6276-417a-983b-1af4617d60ca@intel.com>
 <IA1PR11MB6076F9F222A98125974C5CBCFC5C2@IA1PR11MB6076.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <IA1PR11MB6076F9F222A98125974C5CBCFC5C2@IA1PR11MB6076.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:303:8d::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f64109-866c-4b09-c6b9-08dcff77f628
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3JUUk5KYVNPTDZSTmNiZFBReUdtRmtyTHlzOGlKZlVici9VYTJ0REpnMkww?=
 =?utf-8?B?ZHZsUW0zVTdPaWlCQ2tnZlEzY0l4WWt2M0dxR0l1OWVTOUZBN0wvQ094NDVW?=
 =?utf-8?B?U1RrS2FVcnArWVh2d3hWQlk3MzNQeVNhQmg0eHJtSVludE9BZ25XNEk3SnM0?=
 =?utf-8?B?S25qVmZjdTE0RDArbUlkSjJPcit0bGJhZ1FOc1lqOU51U2VMN1ZPV2pScGEr?=
 =?utf-8?B?UzFMQ2hSUEE4SUdlZlRBTGZBUnBXbFF0UWtoVGhYSFlZVlVyK3gxLzNMVzFW?=
 =?utf-8?B?S3JzY0doQTdnUEtPQjdlZ0hJSGlBZEowa3Y2NzhvUlhQNGE3WCtvNWxVUk9o?=
 =?utf-8?B?SlJYQWttczkxaEJocldyTUxEZTlBOVdxRVJyOFlIWkQvSVFiTVJoRXJhV05z?=
 =?utf-8?B?VzN0eENWRVBNWnlGZllIRGJLZnpzT3p5VjRvYUw3bEh3RUkyU2ZaY25Ha0Ns?=
 =?utf-8?B?ZXZsbXl0SlhiT1RIcHVaR3RiU2VTM0xHL2ZvRlE0M2ZGQnp5b3ZSQ0hMeFpl?=
 =?utf-8?B?a2pBNDhRUkxsTEJFTlprOVpqSzMwdW5VU3FOTTlGS2VnYUhxSGlXT3lGdFBi?=
 =?utf-8?B?bWt2NTcwRzYrL2tiYmVKRFoweWxjMFVscERIdmJGS01QanY3MUQvMHpINjFK?=
 =?utf-8?B?U0ZSNU5meSszVUxpaE9Wdk9COWFGVUdsMkpWZzZJck1TdldOOWViQkNMcndH?=
 =?utf-8?B?NDdNaERjZFNJNUxsNFB0cDM0SWF1eEI1aHpFcE1rYmFmd3gzZ3RtRDBCQWkr?=
 =?utf-8?B?UWxXYW4wTWZacGM5M1NPNmVHWlVjTEViNnBGN0NRRGs3SDk3SEhXcEhDQmlk?=
 =?utf-8?B?S095VlQvY1BocVo0U0M0QXloa3dZRTB3NXVVSC9PeVJ2NGk1SWlwRUpXcVlT?=
 =?utf-8?B?MEF0ckNKNWJnUWM3WDRMYm8yTFNpU2VteU9yS29kZWdXY1JLOTdETHlPS2RP?=
 =?utf-8?B?bDY4TVh1UzVSZk5sSmFOa1dDZ2oyeU4xbHZ3RmpvcFVNOFp3dUFOMndUYVpV?=
 =?utf-8?B?NTFqWnQ5ZkNhRmFoM2d3bmwxNjZXaEpQMFFpZmdrNkF4bE9zY0xDOCsvYVlw?=
 =?utf-8?B?UThCRy9qcDRONWxLUjJxM1UvdmE3eXEva3RCT2RINytXamZjYnJVam03Mjlq?=
 =?utf-8?B?TzBSdWZjQjZkZmtvWUxyREZ6QXIvaTFPK1doYzdVcVc1cnJHSy9DK2NwM1oy?=
 =?utf-8?B?Z2xNNGd6dkFmdjM1TWk4N2hCcSt4OUMvemJML1VUTjZyK2hHTjRsUUlMb09V?=
 =?utf-8?B?b2hjMTRqQmxRMHhXdEo3WlIvL0l4Y2dVckJQT0gxaVNib2xOcnZ0NkYxdlhR?=
 =?utf-8?B?UGpENEI2enNINngzWDVZSTJQRmJxVFNkeHk1bXFpOTRMMy9KdWxzMUlOZjBD?=
 =?utf-8?B?NWdLSmFVWUQxekVwblV3MklNYmhTdVJjZ3pqdGlJT2hCRTJEK04yRks0ME10?=
 =?utf-8?B?bE1KY3BXVlQwTEdLWmEvRDlFRys0SjUyb0NoemVRcXFHZ0o2SHlndm5lQU15?=
 =?utf-8?B?WkNza2NkYUF5OEk5ZXNmMyt0SFYrVWZnY2F4VlRQNE8wOUtnTzhMaENoS0RR?=
 =?utf-8?B?bWk3dVR5eU50dG1hSTQ3RCs0dFpTVGdTNTBYYXAzT0NrdGdHY2VpVG1GeGhP?=
 =?utf-8?B?T0ZQT1RNS1c3UTJSc1F1WjVURlhtb2NEcTZJYXVUbjZSVlhVVzcxZ044T2Zh?=
 =?utf-8?B?RUVEejMvM080OC9LMEs3TkdKUGlsaEd2TTBydm5lRWVXU2FlWVkwS0w2MDFJ?=
 =?utf-8?Q?Dxt+KzFnSxJkshlOnoo6tOaofGoNmhpdkSdioYf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXZBQnU0UjZ3QVNtNlZ0N0dvQ2M3b1BodG5WdTBRVm4vY1RWSWd1TjlzL3d2?=
 =?utf-8?B?a3VVOUZtelBlUktBcXVObElDdXBPeFhhRWVWYldjc3pPeEJ5UE9uRFJURjlz?=
 =?utf-8?B?THBiaklGbTlNMFBPS0hUbjh5am5pbmpqYUFManhyMTRtTjVNQUtNUC94SzhW?=
 =?utf-8?B?LzMwTmxmelhXR0syVkZrYjB4aVNlYjFvZ1R6SS83Qk51US9qMktXR09keDBm?=
 =?utf-8?B?ZTVHT2tSekYyZHdzMmx1MmR1SnNWZjdZN1hkb24xaVBRT3R0Z1g3bEtrOGU0?=
 =?utf-8?B?bi9EVDNOREo3K3RiUC9ZSEVMdVpFREpFNFNUaWJkeEd6OUtsUTV4MEJQWU0y?=
 =?utf-8?B?OVJDbWNMbFY2eUNhYVNidytycnZvNXhZSFlUMXRJSlMzUkRJL3krdTVCOHdQ?=
 =?utf-8?B?b1F2VUlQbTlCcVFEdFFRUkVaVitTNTZBSTluYWM5L0cycDhUdUlJaXJxZFY0?=
 =?utf-8?B?TkVRRk9EZEpUSGhNOG43VnAveklCcmJLVTRYWmp6dzkyOXdUOUFiNDF3M1Nv?=
 =?utf-8?B?YXZ2c0tobG1Lc3NxcmNTTURHMzVuMjRmUEtObk5DVlNmMGQ3dDFRVmpGWWdV?=
 =?utf-8?B?eDdVUVc1OHlqVE10a3dtRXBOY3FFbUVqSWQ4eUxDeDJoeDFCaG1taG5PRzM5?=
 =?utf-8?B?UEM3VUNBMW9lRUYveDloWlcvTDdQTWcyKzBnamhPRVdBZmY1RENmSisyL0s4?=
 =?utf-8?B?emRmTW90YW0vREd6MHhnWGZIYnRGRjlMek9aeHdJN0hSOWdEaExuZW8rRDJW?=
 =?utf-8?B?ZEpiOU91ZXdLS0ZlNytiUTRDbk9QdERFOHBGOFRJenJ5RlNhM2xYODNWUUVR?=
 =?utf-8?B?UWVibFVERXR4N3NicnFtUzBkUHMvbmxjSVFobVZyS0dYSFJCakl2dWIzSGlN?=
 =?utf-8?B?WmFxekNvWUZseUlMZDVEOW9BdnhzaUJNcEFNN1ljY21kWjBzd0hyR1hRNFZR?=
 =?utf-8?B?V0V1Y1dXSjNJcG5iT2JmNUZ4U3lHU1ZMNFpVVXJXeTVQa25IcXk4V0lEb2k3?=
 =?utf-8?B?bEpGK3VqWWhONHFpcEVENjQ0bG5DRUVRSHZmN2w1dmM3WTZneWxDUHZPR1Iz?=
 =?utf-8?B?WDdXZHpibytMMmM4b1FudU8vVlpvdi9hdHUzY2YwVklqWmprWkw3alppVjBv?=
 =?utf-8?B?RFAzV2hSMlVqR01HVTJoaG13VTdWM1JBR1JWZm9ZVlNpRDhrZFZaM1NDaTVp?=
 =?utf-8?B?eVdZOUFhdlJJV0E2SHVRc0ozazgyQ1JMd1FueHd5bGhLelRWYTM5bHlNYWRL?=
 =?utf-8?B?djlQUzFQLzZQcDczSVViQ1lqSlJObnlPREJlb3Y0bmVEeGtsUi90cmJCdDQ5?=
 =?utf-8?B?SWZteDNEelcvL2dlRXc1UGp6VXQzdGdhd3BYTHhUWnFrMEtmaWtyMDQyVzlP?=
 =?utf-8?B?aFVmK2UzbVY4RmxQbVRMZnBVSnUwRnRBbjg5Q1pqUjdRd0Jha0FGRFdQbitQ?=
 =?utf-8?B?TjFYMEVMeGZVZjdjMXV1cXowQmg0VzExVS9JbHZXM2U3MDMrY084QSt6RmFM?=
 =?utf-8?B?bjk4Nm13L2taYjNMbllGaWZpMi9DbXEyeUpuZWM5Z29kMDBtSEVPK0pxL1hW?=
 =?utf-8?B?L2c0b2FxVVdCcFFYM0k3SHlXYjdKeElVQXdYV21mSlNTeXpVNjFHQlVHSW5Y?=
 =?utf-8?B?T2d4eVdsQ3UrbURESG93aUdiMlRwU0JFK05ZQ25naE11cGRNeGxHbXVlRG1U?=
 =?utf-8?B?NEYxYXpUMlJDVVAvSVZldGNGbFE0ZnkvZkZya1gvb0poZTFhTWF3MUVaakE3?=
 =?utf-8?B?OHhnMWpNRTZrcVI4c092ZUIrNjZxVWlnMnBqUUJiWVhyWWovTEl4a3NZRzRu?=
 =?utf-8?B?eE1KR2V3ZThuQ205ckdvY2pIRmF1aXJBSGQ3ZXRiS3dSQloyWDdFVXZuL25j?=
 =?utf-8?B?OGNkYmoveWZMb1FTdm1UWGl6MmRnbnJKdzBiUHpFRmhPMnRtVTNtZmhCRDJm?=
 =?utf-8?B?enJ0UkNSeUQzOHpEWXdVekFCdVBTVmdyTEpaT2M3U1ptakhZM1Q1ZXY0aExa?=
 =?utf-8?B?MUtLdkNHMStiL2haL2RiUndlV3BsZ2RUTm5pT1lncnU1UE9Da05nWmczUDM1?=
 =?utf-8?B?eUhqQ2FkVEx1UldudCtKa3l4VkJSME9FeVpya2pZcHU1SnI1b0lSQjNJSlRa?=
 =?utf-8?B?WlZTSU1qWE5HUnJ0WjQ5bjZWdXR5eWdWa01LY05kRU1saG90dHRaMEZLeFdY?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f64109-866c-4b09-c6b9-08dcff77f628
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 22:03:07.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+a9tIvQsvhImtGbCMMXSFuksSl5M15nFIW8+jNTFYu/2BYeuvpAM2UClq3XDENPzs0EPCwzGOCf1715xgrAlsw0sTFVGeLnW1wRevTk+oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
X-OriginatorOrg: intel.com

Hi Tony,

On 11/7/24 12:58 PM, Luck, Tony wrote:
>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_01
>>> <rdtgroup nameA> <MBM total count> <timestamp> <generation>
>>> <rdtgroup nameB> <MBM total count> <timestamp> <generation>
>>> ...
>>>
>>> Where <timestamp> tracks when this sample was captured. And
>>> <generation> is an integer that is incremented when data
>>> for this event is lost (e.g. due to ABMC counter re-assignment).
> 
> Maintaining separate timestamps for each group may be overkill.
> The overflow function walks through them all quite rapidly. On
> Intel Icelake with 100 groups there is only a 670 usec delta
> between the first and last.

If cached data is presented to the user I think the timestamp is
required to let user space know when the data was collected. This timestamp
would be unique per domain as it reflects the per-domain overflow workers.
As you state, it may be overkill if done for each group but I think it
is valuable to have it for the particular domain.
It sounds as though the use case is for user space to query counters
every second. With the overflow handler and user space thread running
queries at same interval it may help to ensure that user space and kernel
does not get out of sync. For example, a scenario where user space believes it
queries once per second but receives the same cached data in two consecutive
queries.

> 
>> It is not obvious to me how resctrl can provide a reliable
>> "generation" value.
> 
> Keep a generation count for each event in each group. Increment
> the count when taking the h/w counter away.

Since this is a snapshot of the counter, why not pass the exact value or
issue encountered when counter was read? For example, "Error", "Unavailable", or
"Unassigned" instead of a "MBM <total|local> count"? We need to be careful
when presenting cached data to user space since the data becomes stale
if any issue is encountered during its query from hardware because that would
make any cached "MBM <total|local> count" invalid.

A generation value would be of most use if it can be understood by user space.
I think that would require something separate for user space to know which
"generation" a counter is after it is assigned so that a query of cached data
can be matched to it. 

I think maybe the issue you are trying to address is a user assigning a counter
and then reading the cached data and getting cached data from a previous
configuration? Please note that in the current implementation the cached
data is reset directly on counter assignment [1]. If a user assigns a new
counter and then immediately read cached data then the cached data will
reflect the assignment even if the overflow worker thread did not get a chance
to run since the assignment.

> 
>>> Then a monitor application can compute bandwidth for each
>>> group by periodic sampling and for each group:
>>>
>>>     if (thisgeneration == lastgeneration) {
>>>             bw = (thiscount - lastcount) / (thistimestanp - lasttimestamp);
>>
>> If user space needs visibility into these internals then we could also
>> consider adding a trace event that logs the timestamped data right when it
>> is queried by the overflow handler.
> 
> That would provide accurate data at low overhead, assuming that
> the user wants bandwidth data every second. If they only need
> data over longer time intervals all the extra trace events aren't
> needed.

Using tracepoints comes with benefits of features supported by its user space
infrastructure. This is one more tool available to explore what would work best
to address the use cases. The use case presented in this thread is to collect
monitoring data once per second.

Reinette
 
[1] https://lore.kernel.org/all/3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com/


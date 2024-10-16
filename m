Return-Path: <linux-kernel+bounces-367190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BAD99FFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1462B2867EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF317622F;
	Wed, 16 Oct 2024 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KloVjvgT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33B148FED;
	Wed, 16 Oct 2024 03:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050231; cv=fail; b=h6G54AuOaj8D1zkn+XcXtnJRpYOE2UEK2XBSngIhrrSZnBUrx4EYtfI3bmhtrVjDHzx79BK6Gz66qnsQJW31vRy565abc6I9/yeDlZKFv/y58Onu4bPsVUHtcsJyMDGHr2DOrXRnu+W3k6QPyKx1RbTPvL6oE7iEMrRKrPqunhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050231; c=relaxed/simple;
	bh=TBluriUzpzWidcaR1TNt0H69WORDgvzuaSWxhN/FQPI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KvhposmF5FRu+ILsmNPXptfWCgfEhf9OYI4/THAf6MdkgUbs60Q9gJ6N7V8VAyRDCVVf5W2MYc2bEB1jBR4WXo+yJoLwue1R957enR6O3sD6vZzo4uejtFd0NomK5Ogddq1+rZn83pZMAm2J8V1gwcy8F9ymkReroHcPh3hfH38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KloVjvgT; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729050230; x=1760586230;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TBluriUzpzWidcaR1TNt0H69WORDgvzuaSWxhN/FQPI=;
  b=KloVjvgToR/j8pI+p6nPmCxUEQQvpNBhwwUeZ260qjy0ybj76QB0GWgF
   0d32KAhiNjRNEHpWsMXaAHhurKXPpRzcc3ezwCsJlGVkYJvCkOLJrW7ZP
   VfXDtesQx+pdlL605KkKTWk+nMgFCouPAVv/56V4R2Kd/TEyV8a9KNBiW
   6E+EBNjm/TfHSeUYOd+x6KnfUxSASm5J9xfM3U/AR/ycmFPxPCoOjuvVA
   b+C1ugJM650JPsfx2JgxKoxXnbv0UtTDfX3vZvdAKDsaKBLPyalg6VwFI
   uce4y72sZok6+BWyfDrxnV6qvt/DqeTM39Y1h6/Hvcxky6Brch0XY9ifB
   Q==;
X-CSE-ConnectionGUID: uqQq4meoSQOk/qKgmFZTuA==
X-CSE-MsgGUID: QijxuvRxRd2bbTgy+rl1Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28624368"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28624368"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:43:48 -0700
X-CSE-ConnectionGUID: 010zRx+mSiu3dXht2+wDuQ==
X-CSE-MsgGUID: T3HVuTHpSAO9UXwYsFu6lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78164779"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:43:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:43:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:43:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:43:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:43:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAv7ZYePPExa2i9ms1N9Wz6CCNBHf44J+f7yYQ5f+P+6miKfGy0cg0+BWcQ6TEdE7sBsPi300K55Wy6Owd6KxT7O2HED4//3MsH51spCFP+QzoDfz82S0ckw9KpeSOWoVyZKJVYAJ/5/H5XwtLNjnoor8sUaKitcczNShHQP3rV1Rpn5KRwglJLwqClAknuORtVgDYHBQaZtOZILHtivT7H/GdF84jUkUijJakb1TclMacjWrXNHxPeg7k0qZI2Hyp/W3pbQ3Satg0PC5hsGTmKq5ZeDa7lCgwtbOe9YWOYEZyplhsiHIR3yQcbUdsikKTCBckNmjoY3DZhMnoTBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw1f/a3VbaHRFDG0lgFMhleMyjfaC1axka+O29S1dFo=;
 b=CJ3rgii7hKE/ivJLrvy3+XP3g+s1eiAaC+KmvC6EZSqYjiy7EjPTSLRKxM5D7wNEDBSGCoOQL+YxVgBODDX27RiklCFjOVAXGWjjMsb7/D7VMvUUrHkCq3pdbiHmxmfGWUb86SvPvBzwh9K+VTVylfUEUl0hH0FnDFu7kwsooFcOdXwNm01+baGryLLjZe9hz0XyQNHeYtuKbszHEk8q5Sg1veyqIhBMaffIMuWIcprIIn05DMYTv/myC0s+v1lVsMYtfT+A06cegZ233YA4psH05C8oz5DNiL8s4b2GdZg2b9wspkWj/fnpNg/qrJLwb/e4p9yCHh/b5XDom8MzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 03:43:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:43:43 +0000
Message-ID: <faf0b49e-b379-48d2-a14d-ad931bb46883@intel.com>
Date: Tue, 15 Oct 2024 20:43:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 25/25] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
 <c3c12e970a660c32088a447f9961826ec3a9fb24.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c3c12e970a660c32088a447f9961826ec3a9fb24.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: d942db49-c083-4d51-3839-08dced94bb50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2Y1aURYRi9CWTc4V1JNU0kyclI5Y29pQUxtdDRYeEwwa2daczFrMUtsR3F2?=
 =?utf-8?B?UWNyK2Z3M1ljSXVjdnRDajh4T2dDbHRMbEhHSGFIcE0reVZNSmxYZy9DQkV1?=
 =?utf-8?B?cXZDU2dZQ3N3YUNvN2JoUEFrU21jR2I4S09OSUthTG1RU1NzN2tzU3RtMmxp?=
 =?utf-8?B?WVpRWmJoR1NsMXhJWitONXpQeVYyaXVlTWZaYWtzWGlxUForTExYMFYvUEZR?=
 =?utf-8?B?YXRKWnVrTUd5WXBVemdQbTBLNEpKS1Ztb2hWWmk1ZjBDRWZoWXNZZGg4VkJW?=
 =?utf-8?B?MSthNEVVOGZacXVtUzlvbkQ3QVhQYms4V1dHVDNDM1F4Nm1wOENNeE1NSzY3?=
 =?utf-8?B?c3NUdlEvQ1JMVzNWUFNKaVdnSUp0a0dvOEZkS3NzOFIzZzlsSDJNdWFCOVVV?=
 =?utf-8?B?WjA0S1FxTkFGenNnbzZtWWNUOGRsR1NOSmRGdWRNU3hIZVlwNkNYZnJkdlN1?=
 =?utf-8?B?VFZ0ZVRubzFBMHY4YUdwbDdjd29HekREelRGblFGWVlndmVNRTJXUlRLd28y?=
 =?utf-8?B?K2xzN1RTdi9CWTNqbENyQUx5V0dvNm52KzVaY1dGSmxXL2tpVC9FMU8xSzI1?=
 =?utf-8?B?ZnNGRTc1KzRJTFRmTmFOVXIzY0xCMTdlMXBFZXNiZGFLZE9OL3B1RkRMcUxD?=
 =?utf-8?B?NTRJRXAzSFRQOUMxdnkxR1FRVkRWZEhBMlN3cDJaMG0rQmtDVU51ZWNRNFpz?=
 =?utf-8?B?SEJRVDc2dXloNmtITG51WHdhanpINHQvcEs4akVCazN3Y05qajVlKzlLQXVi?=
 =?utf-8?B?MGN5enh3bi9ZcUpWb24xZEg3aVg3TGoyZE1TRXVGdW1JZU9OM0hsYzBSbm1M?=
 =?utf-8?B?enlOVHEyOUhNcGMxTGJjODBUeHRTeHdmaGxhRmRLNjZNbGtYTnpKbGJyZDFl?=
 =?utf-8?B?elU5NlY5NCtLZmN3cFd3R2M1UWt4ZTFscWxnRnluTllmQVlwWlZScVFZZTJ1?=
 =?utf-8?B?cEsySWRpblJhVTFmZU92Ly9xQ21zSGZZT3BKaDJMYzNHRkdoMFVvMWNpeTls?=
 =?utf-8?B?eUU2NUlpT0hvSk1yRVA0S3VPT0JwZlVCK1VVWXZZK2NnWjlXcXNGRTNENytp?=
 =?utf-8?B?d3FwWlhqRW1hK28vWlJOVE9TWU5ocC9PZ1BUYTN1anRGUnNVOFQ2MzlnSU8r?=
 =?utf-8?B?NWxlQkxRTHFnclhNMGQ0c3k4c3pTMGplNDNLS0dOS3RqWEZQYWVTY3J3OWNu?=
 =?utf-8?B?azZFRDBHR0JqLzloQ1VySkxiZUZuWVkvdFlnMWF0YW5maGtRS2hSYlNVQ3RQ?=
 =?utf-8?B?a21jQUNkL2NKS1phYm9jcnVCUXNKRWtiNytaMFYwbWwrMnI4K3BkR1g5YXJV?=
 =?utf-8?B?UStISU1kTy8rMlprSTlnK2lxQlg5aXU0Nmc0QW10OU15MkJaTkFQK25hbFgz?=
 =?utf-8?B?emlZM2taSmNMbFBBK1ZISGgwV3JLa29vU2RNQmhaR1kyTjF0dFZUZFdWLy90?=
 =?utf-8?B?M3RvWUg1dGhscjNLcGd4b1R2cXNRQnV4NXV4WXZvZjRQcnpqRXpINFEvVnpi?=
 =?utf-8?B?RHE1RWhBS0h0bWllNEpoejhERmJZRjJXNGxkTmRLL2RqZmEyNVdGUmpGUjFs?=
 =?utf-8?B?L0FHRVVvOC9HZ210Y0ZBenphQjdEWm1ZRmMwcWdUdkptajJVcy9kTjJxcXBF?=
 =?utf-8?B?WVNIL1huZEdQQVQ5MGgrZG5zbDFocUUzRFNGTGVUZlEzdzNlS0I0MU5qNUZD?=
 =?utf-8?B?WTQrTjgzT2VRS29uQTdyYlVpT1RsZkFHbHp2TDViOWxyQ1pUVDdTU2N3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDkrT0hlSkVlM3NrOGIwSFBBSWFuZFlER2RzTWtSSy82KzlnQ2JEa0Fzc1gz?=
 =?utf-8?B?WXhyeXRMZ1BvSHZSZkJqaWQvY1NSOVVUMGdYcm04Y2JKdDMvSWxIbEw5WUE0?=
 =?utf-8?B?R3hyVTRMajlmWm1SdFZVbVVpbm1HdUhXcE5zWjY1ZXo3SnVFT1FmYlJiSi9i?=
 =?utf-8?B?UTlPYVkzWXVnTUxKSG9SNi85NnNqY24wbzlGOGZ6VzZVZS83eC90a0hhYmpZ?=
 =?utf-8?B?aVRvWCtRZkJ5WWRLdzgwaFNFR3p5SWwydWhpMDdERlk0TStUSkFZeGJsL2FF?=
 =?utf-8?B?bTlOTW53bXRhdnBubGdMbFpBVTgvaHd1b08vei9mVk43QkVrR3BhY3ZWS05w?=
 =?utf-8?B?d1JNeFJxUGtzVU9EVTJRZjVTMW4rVGVNbTVnck9mVUlIck5qMFlaRU1ld3Bh?=
 =?utf-8?B?QzM1eE1DNTBNdXhyN0tmbW50RkVKQmhOa2kzbnM1MlQyZTJUV2NOWFpDVTJj?=
 =?utf-8?B?YXlqTW1pOFhKaE1UWng3YU8rb3ZsOExQSEpXcTdXWjU4Z1AyTGRuZ1NMVWUw?=
 =?utf-8?B?WTBSWjFjZWZnQ2RDbzhlaURobjl0MWJjV2MxclVyZ1BJZFg1NkhtTmRmVzBh?=
 =?utf-8?B?ckw0OWpUV2N1b0J5WVVqSFpNdW41bjVlZ1RRSE1GeGMzNjdYK1Bnd3R5czhE?=
 =?utf-8?B?N0hVQ3VMRWt3bWxqNXpMcDErSHBSUFAzRXl5OW15WWxHZ0k3bVhQSG1vNDBY?=
 =?utf-8?B?SnVvUE8rdmk4bmtaWmZGZHV2Skszc0xNZEFpN3dMbS8rR0hiK0h1d0NLb0dH?=
 =?utf-8?B?V3lnVmJGbmx1d2ZZK21PRG9mU1JHVDlwREYrakJ1a0U2ZWl4VTN6dkZNYTdE?=
 =?utf-8?B?dzljNm9OV3B1bmRlZERELy9kTEhXbU1ERzNEVGliRGZBNHJTWkZrNUdUVytj?=
 =?utf-8?B?L3FRK0VkNVdVZTJTNFMwVXh6ckJINlo4aWxzL0RjQm5HRmpoUkZ0KzBhM1Fy?=
 =?utf-8?B?RkI2KzZhczBEVGJ4c1ExclhZUnFWV0x5enNxQmVGWExGZ3B3NFNaM1grWWtP?=
 =?utf-8?B?VUZPQmozYklmWVMxZGo4V2kyTm52YlVqdDh0b2pGTURZSnh1SGJaV1RvMk13?=
 =?utf-8?B?SVVWS2hoajgyYzArZzNTd05LUzdCRlBxM2xpQUxzODRuODV0MHlBNGNGRERm?=
 =?utf-8?B?MWF1M2t5Q2JZSHdybWhCZHN1T3pQa0paYStnWStRVGkvVzFObnRZa24zckYw?=
 =?utf-8?B?Sm1MVG55Tk5sWmRRWmt1enBNbE8zblhGNllFbHdKcklvWGNScFRONG0vdnNT?=
 =?utf-8?B?VzJzRlVjMXN1d3Vjay9DS1d4QTFVSEpGZXhhSE00RVAxSTZDcUVYSXA1L1Yy?=
 =?utf-8?B?UU1jd21mREZFQWcyeFQ5bTRnRnJZYUxFNHZLNE9sRE5VL3ltWDMxVmRFZjkz?=
 =?utf-8?B?d2xkaE82L2RuNUlaMVp4bkpWeUlwc3U0S1RRVHBIQWMyeDNKcmhkVUlLZUxW?=
 =?utf-8?B?cmsxK2dQRDNlTzkybTB1VFNNN3F3WXVRMVJNbGUzaDBtbUZNUnR5NTRyNUVv?=
 =?utf-8?B?bFZiK0FDZG0wSFVmbWRDQnZ1Yi9EdXJHQ3ZDWEF1MDByMWlHS2NaR0FZRVNq?=
 =?utf-8?B?VkcrQjg5ejlFTTcwZjU4WlJ0KzhKcEJYd0FrSjhiSnEwSVA0VjlPZ01DaWZm?=
 =?utf-8?B?a2dFVzRwa1NBOCtGcE5VSFpkcElmaWlWOGR5NVZiaWlzMmxwZnRSbHdEMGZT?=
 =?utf-8?B?d3p6enBPbXZ5OER6YnRpSkNFMjFWaThVUXROMlZwdkU3ZXV6bWtZMU5ZeVl5?=
 =?utf-8?B?VDRPL2cwWnVBUUo1SXl3SHlXL1A2NHVSNSt1ZXVwTUVQamNqL2s5U1NlTVdQ?=
 =?utf-8?B?Yyt1YnFBRWxRdUVEem1DTVArZFNHb2FmWE1yK1JwR09BemVXNG1PejJiMFlB?=
 =?utf-8?B?TnhwQ2Z4SGpSOXlnV01vSUsxWjRyODQyN3plTTBDWHplRzVnQkxhUmMxUWJj?=
 =?utf-8?B?NDlqSHA0M1Z4STNGSFVTVDR1bkdXN24vcHFBMm5WcFJKN1J1N3NKSVdTMzlU?=
 =?utf-8?B?N1JYMDdZMnl2MnNNUmw5S3kxT3ErRjFSMDFUaGpxQ3hiRm05MGE4V1hqd3Ew?=
 =?utf-8?B?UXE5eVEzWSt3cERkaXd6cUZEQWxBa1FyeE5EeTlQcUlocTJlQXpWNnR1c2xQ?=
 =?utf-8?B?UEhhWE5oSWJwaVRnNXFlVkVIRDZYdHRXZUp6amNYMHZ2M2RqanFFbisxS3Bj?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d942db49-c083-4d51-3839-08dced94bb50
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:43:43.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq8IrfwStHsV305wMK/k0sOuTrAfdP9HipciSqox40qUefY54vIJWvauPPRt73T//0OONL45uSpa7UN2MXj5GyYVaL0BDinajrLt24LFquw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> Introduce the interface to assign MBM events in mbm_cntr_assign mode.
> 
> Events can be enabled or disabled by writing to file
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> Format is similar to the list format with addition of opcode for the
> assignment operation.
>  "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Format for specific type of groups:
> 
>  * Default CTRL_MON group:
>          "//<domain_id><opcode><flags>"
> 
>  * Non-default CTRL_MON group:
>          "<CTRL_MON group>//<domain_id><opcode><flags>"
> 
>  * Child MON group of default CTRL_MON group:
>          "/<MON group>/<domain_id><opcode><flags>"
> 
>  * Child MON group of non-default CTRL_MON group:
>          "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Domain_id '*' will apply the flags on all the domains.
> 
> Opcode can be one of the following:
> 
>  = Update the assignment to match the flags
>  + Assign a new MBM event without impacting existing assignments.
>  - Unassign a MBM event from currently assigned events.
> 
> Assignment flags can be one of the following:
>  t  MBM total event
>  l  MBM local event
>  tl Both total and local MBM events
>  _  None of the MBM events. Valid only with '=' opcode. This flag cannot
>     be combined with other flags.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v8: Moved unassign as the first action during the assign modification.
>     Assign none "_" takes priority. Cannot be mixed with other flags.
>     Updated the documentation and .rst file format. htmldoc looks ok.
> 
> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>     Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>     Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>     Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>     Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>     Removed ABMC reference in FS code.
>     Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>     Not sure if we need to change the behaviour here. Processed them sequencially right now.
>     Users have the liberty to pass the flags. Restricting it might be a problem later.
> 
> v6: Added support assign all if domain id is '*'
>     Fixed the allocation of counter id if it not assigned already.
> 
> v5: Interface name changed from mbm_assign_control to mbm_control.
>     Fixed opcode and flags combination.
>     '=_" is valid.
>     "-_" amd "+_" is not valid.
>     Minor message update.
>     Renamed the function with prefix - rdtgroup_.
>     Corrected few documentation mistakes.
>     Rebase related changes after SNC support.
> 
> v4: Added domain specific assignments. Fixed the opcode parsing.
> 
> v3: New patch.
>     Addresses the feedback to provide the global assignment interface.
>     https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
> ---
>  Documentation/arch/x86/resctrl.rst     | 115 +++++++++++-
>  arch/x86/kernel/cpu/resctrl/internal.h |  10 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 233 ++++++++++++++++++++++++-
>  3 files changed, 356 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index b85d3bc3e301..77bb0b095127 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -336,7 +336,8 @@ with the following files:
>  	 t  MBM total event is assigned.
>  	 l  MBM local event is assigned.
>  	 tl Both total and local MBM events are assigned.
> -	 _  None of the MBM events are assigned.
> +	 _  None of the MBM events are assigned. Only works with opcode '=' for write
> +	    and cannot be combined with other flags.
>  
>  	Examples:
>  	::
> @@ -354,6 +355,118 @@ with the following files:
>  	There are four resctrl groups. All the groups have total and local MBM events
>  	assigned on domain 0 and 1.
>  
> +	Assignment state can be updated by writing to the interface.
> +
> +	Format is similar to the list format with addition of opcode for the
> +	assignment operation.
> +
> +		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> +
> +	Format for each type of groups:
> +
> +        * Default CTRL_MON group:
> +                "//<domain_id><opcode><flags>"
> +
> +        * Non-default CTRL_MON group:
> +                "<CTRL_MON group>//<domain_id><opcode><flags>"
> +
> +        * Child MON group of default CTRL_MON group:
> +                "/<MON group>/<domain_id><opcode><flags>"
> +
> +        * Child MON group of non-default CTRL_MON group:
> +                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> +
> +	Domain_id '*' will apply the flags on all the domains.
> +
> +	Opcode can be one of the following:
> +	::
> +
> +	 = Update the assignment to match the MBM event.
> +	 + Assign a new MBM event without impacting existing assignments.
> +	 - Unassign a MBM event from currently assigned events.
> +
> +	Examples:
> +	Initial group status:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +
> +	To update the default group to assign only total MBM event on domain 0:
> +	::
> +
> +	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +
> +	To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
> +	::
> +
> +	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +
> +	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control

Please be consistent by always using "# cat", not sometimes "$ cat" as above.

> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to unassign
> +	both local and total MBM events on domain 1:
> +	::
> +
> +	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
> +			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +

Missing "# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control"

> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	To update the default group to add a local MBM event domain 0.
> +	::
> +
> +	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all the
> +	MBM events on all the domains.
> +	::
> +
> +	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	Assignment status after the update:
> +	::
> +
> +	  #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control

Please be consistent with spacing "# cat" vs "#cat". This is very noticeable when
viewing the formatted docs.

> +	  non_default_ctrl_mon_grp//0=_;1=_;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a6f40d3115f4..e8d6a430dc4a 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -74,6 +74,16 @@
>   */
>  #define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>  
> +/*
> + * Assignment flags for mbm_cntr_assign feature
> + */
> +enum {
> +	ASSIGN_NONE	= 0,
> +	ASSIGN_TOTAL	= BIT(QOS_L3_MBM_TOTAL_EVENT_ID),
> +	ASSIGN_LOCAL	= BIT(QOS_L3_MBM_LOCAL_EVENT_ID),
> +	ASSIGN_INVALID,
> +};
> +
>  /**
>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>   *			        aren't marked nohz_full
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index cf92ceb0f05e..6095146e3ba4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1040,6 +1040,236 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int rdtgroup_str_to_mon_state(char *flag)
> +{
> +	int i, mon_state = ASSIGN_NONE;
> +
> +	for (i = 0; i < strlen(flag); i++) {
> +		switch (*(flag + i)) {
> +		case 't':
> +			mon_state |= ASSIGN_TOTAL;
> +			break;
> +		case 'l':
> +			mon_state |= ASSIGN_LOCAL;
> +			break;
> +		case '_':
> +			return ASSIGN_NONE;
> +		default:
> +			return ASSIGN_INVALID;
> +		}
> +	}
> +
> +	return mon_state;
> +}
> +
> +static struct rdtgroup *rdtgroup_find_grp_by_name(enum rdt_group_type rtype,
> +						  char *p_grp, char *c_grp)
> +{
> +	struct rdtgroup *rdtg, *crg;
> +
> +	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
> +		return &rdtgroup_default;
> +	} else if (rtype == RDTCTRL_GROUP) {
> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
> +			if (!strcmp(p_grp, rdtg->kn->name))
> +				return rdtg;
> +	} else if (rtype == RDTMON_GROUP) {
> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +			if (!strcmp(p_grp, rdtg->kn->name)) {
> +				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +						    mon.crdtgrp_list) {
> +					if (!strcmp(c_grp, crg->kn->name))
> +						return crg;
> +				}
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int rdtgroup_process_flags(struct rdt_resource *r,
> +				  enum rdt_group_type rtype,
> +				  char *p_grp, char *c_grp, char *tok)
> +{
> +	int op, mon_state, assign_state, unassign_state;
> +	char *dom_str, *id_str, *op_str;
> +	struct rdt_mon_domain *d;
> +	struct rdtgroup *rdtgrp;
> +	unsigned long dom_id;
> +	int ret, found = 0;
> +
> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
> +
> +	if (!rdtgrp) {
> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
> +		return -EINVAL;
> +	}
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +
> +	op_str = strpbrk(dom_str, "=+-");
> +
> +	if (op_str) {
> +		op = *op_str;
> +	} else {
> +		rdt_last_cmd_puts("Missing operation =, +, - character\n");
> +		return -EINVAL;
> +	}
> +
> +	id_str = strsep(&dom_str, "=+-");
> +
> +	/* Check for domain id '*' which means all domains */
> +	if (id_str && *id_str == '*') {
> +		d = NULL;
> +		goto check_state;
> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Verify if the dom_id is valid */
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
> +		return -EINVAL;
> +	}
> +
> +check_state:
> +	mon_state = rdtgroup_str_to_mon_state(dom_str);
> +
> +	if (mon_state == ASSIGN_INVALID) {
> +		rdt_last_cmd_puts("Invalid assign flag\n");
> +		goto out_fail;
> +	}
> +
> +	assign_state = 0;
> +	unassign_state = 0;
> +
> +	switch (op) {
> +	case '+':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		assign_state = mon_state;
> +		break;
> +	case '-':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		unassign_state = mon_state;
> +		break;
> +	case '=':
> +		assign_state = mon_state;
> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (unassign_state & ASSIGN_TOTAL) {
> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (unassign_state & ASSIGN_LOCAL) {
> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (assign_state & ASSIGN_TOTAL) {
> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (assign_state & ASSIGN_LOCAL) {
> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	goto next;
> +
> +out_fail:

Is it possible to print a message to the command status to give some details about which
request failed? I am wondering about a scenario where a user changes multiple domains of
multiple groups, since the operation does not undo changes, it will fail without information
to user space about which setting triggered the failure and which settings succeeded.
This is similar to what is done when user attempts to move several tasks ... the error will
indicate which task triggered failure so that user space knows what completed successfully.

> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
> +						 char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	char *token, *cmon_grp, *mon_grp;
> +	enum rdt_group_type rtype;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");

Writing to last_cmd_status_buf here ...

> +		mutex_unlock(&rdtgroup_mutex);
> +		cpus_read_unlock();
> +		return -EINVAL;
> +	}
> +
> +	rdt_last_cmd_clear();

... but initializing buffer here. 
Sidenote: This was an issue before. If you receive comments about
items in patches, please do check if those comments apply to other patches also.

> +
> +	while ((token = strsep(&buf, "\n")) != NULL) {
> +		if (strstr(token, "/")) {
> +			/*
> +			 * The write command follows the following format:
> +			 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
> +			 * Extract the CTRL_MON group.
> +			 */
> +			cmon_grp = strsep(&token, "/");
> +
> +			/*
> +			 * Extract the MON_GROUP.
> +			 * strsep returns empty string for contiguous delimiters.
> +			 * Empty mon_grp here means it is a RDTCTRL_GROUP.
> +			 */
> +			mon_grp = strsep(&token, "/");
> +
> +			if (*mon_grp == '\0')
> +				rtype = RDTCTRL_GROUP;
> +			else
> +				rtype = RDTMON_GROUP;
> +
> +			ret = rdtgroup_process_flags(r, rtype, cmon_grp, mon_grp, token);
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  /*
> @@ -2328,9 +2558,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "mbm_assign_control",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= rdtgroup_mbm_assign_control_show,
> +		.write		= rdtgroup_mbm_assign_control_write,
>  	},
>  	{
>  		.name		= "cpus_list",

On a high level this looks ok but this code needs to be more robust. This will parse
data from user space that may include all kinds of input ... think malicious user or
a buggy script. I am not able to test this code but I tried to work through what will
happen under some wrong input and found some issues. For example, if user space provides
input like '//\n' then rdtgroup_process_flags() will be called with token == NULL. This will
result in rdtgroup_process_flags() returning "success", but fortunately do nothing, for
this invalid input. A more severe example is with input like '//0=\n', from what I can tell
this will result in rdtgroup_str_to_mon_state() called with dom_str==NULL that will treat
this as ASSIGN_NONE and proceed as if user provided '//0=_'.
This was just some scenarios with basic input that could be typos, no real stress tests.
I stopped here though since I believe it is already clear this needs to be more robust.
Please do test this interface by exercising it with invalid input and corner cases.

Reinette



Return-Path: <linux-kernel+bounces-558588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15830A5E833
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A581797F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3CF1F1522;
	Wed, 12 Mar 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdIvUrKW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66681F1509
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821428; cv=fail; b=pU04fu2TYrBMZYTiEheRm2+hlJQX59bGiVrzlH9tY3sN0GKTuTN3bDbqgz8m5B/p58HnjTpTXMZUVx3Odx3p+iVXnuxl7SS/NdW4sK0+HhZ+03x3wCt4574qf+cHcygAlL74DLXlKM9iSEg9THUNExkE4PJ+Bk3/BHk76PPlXo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821428; c=relaxed/simple;
	bh=a2iozV0WtfnOdrejFJ4ixEmM+gIvWxQ2zsn4mZWA7SA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TR4tDuJQy1wDgamGdSO6TL2Edz7V4jarxeAeFFB7wgMUqIiD5W0S4FFC2TcdPFGf6tL8k681t6e5eb3FiK6pbRxEbqTZ/lB+15ACw+bqEYlwEPlCKHAtFxsIcUNp6cFIQoG48FZefWYH7GN81KO3IV8IZ+/cbKkb6PzfPf0yqIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdIvUrKW; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741821426; x=1773357426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a2iozV0WtfnOdrejFJ4ixEmM+gIvWxQ2zsn4mZWA7SA=;
  b=DdIvUrKWmMS3+jybpOuqWG80O1l7qUV8yGC6WE/UxyCsLv6Ihrh3uMWr
   eiIcsMCwa7EBXSIJtz01eYr71xrI19OpgLRR8bAmst3HPX0bjoBQEh5lL
   6jv6WkNwr9HqiXDm7tGAz/bYkupT1Nzmm7nooNFG2HlLmRCnaCOwqsTNC
   R/Wdrj6+K36np02UBsEO39Gx6lqbWHgpMokGbGobZ9JZWLlRqx6hAt138
   JrcJ8SpwZLB90sEFGBOPm1AWtLSEcC4rEWTEHhPAFb8i8vq0yHMvhYZ/T
   mAByDsF2Kghr0Oo50yBVcRZ6ZWmQTHvR6YWZCO9yxw195oluuZ97EMT9h
   Q==;
X-CSE-ConnectionGUID: XwoVWUdiTBOnFQtzacH+hg==
X-CSE-MsgGUID: rhEmKSJdT/mWR+alF8X4Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43027798"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="43027798"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:17:05 -0700
X-CSE-ConnectionGUID: ciWGKVU+Ruijp94FZQXZ/A==
X-CSE-MsgGUID: KlaU8RFhSfS6mYQDWWoqbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="124947488"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 16:17:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 16:17:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 16:17:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 16:17:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKrKQ+6L84ztcgBpD23FMmIaZI+2IIMQH5YrgLIwGi3Eg9v7Ldi/tcpJ9D6dN8BRf4zxTKpgBlmdkedJ49mNosNqyfUcf1mJtjgWp7iMJ7+RgEoXY2gRA/7BmmFAhRPluCcKIrF7iFnjOq57pVgQG7irbFTH1eYSyN4YU5fwPtq8wvxxw/A3N/1gIJJJPhPlFf1YYHI8jp9HkA+lOv+WpKotn5hD2qhR2+WcMcMo98CUuJ1EwR/luj+qyXtEY+5g3IKI7DAQUr0o6ZRId37Y6KQaMXTHOYOqzIC4OaTO6Hak09n93Wn0WdQ09I6eKC7U3R9XRJmgpNy3NKlEgn+xBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UCjpELYIXxwqw0s8ITmAgQISkFdxR9Vkw2kPI0G4xQ=;
 b=g42CL8Ac38+Npnm53w4veIj4Of1Qsuy9ecCVtiI5KJrxNwKaed92e1/phOJRnMKnqSfKCAgrP7xdjk7HcpeuYYkbkzuC6cLtUCtzZ/VeNV2UeV37F4v8PQAVMl2Jz/RlwwqKyUR0qPErOGAxzPzA4V95N7srJTTdHIYQvXP+07DoRThg4mvabwdzsoQovECK7j5IU7fhQBrRPk8sza+GxLGlff/K2d7OUCYCu/VGkTGS/OuYn9YUB2ueuc/ctxhIdSqCZvp2Ds5O2/2yTGFEAulyEWWS8zShlMI8FRYpxHEybhVDvWg0RMPqnyqTUjoif9NQFaygLr5MNA1qsDECqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB6957.namprd11.prod.outlook.com (2603:10b6:303:22a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:16:33 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:16:33 +0000
Message-ID: <ed81aa4e-6ebc-40ad-af45-289cc7138c0f@intel.com>
Date: Wed, 12 Mar 2025 16:16:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] x86/cpufeature: Warn about unmet feature dependencies
To: Ingo Molnar <mingo@kernel.org>
CC: <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, Uros
 Bizjak <ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>, Sean
 Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>, Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>, Xin Li
	<xin3.li@intel.com>, "Alexander Shishkin" <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20250307000204.3581369-1-sohil.mehta@intel.com>
 <Z8resWzgtZaTuzEN@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <Z8resWzgtZaTuzEN@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: a62f374c-5ca3-4257-e60e-08dd61bbed91
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0FYY01SSWE2eGQ0NnltNG9KSzlMakVzRTd6ZG1NWE5FeFMvUUJ3UkZINHUv?=
 =?utf-8?B?bGV6dDFQK1FqMXRzdmEzL3NOOTk3Nm9CcnF2cWxKNFh0NGYrcStaK1E0OFFG?=
 =?utf-8?B?VEwxYklnL3ZOSzhnNnIwOXlPc3RXNnMzMHZBZlhrQ2M5VEp2UWRqVDZxQWkw?=
 =?utf-8?B?R1h3UVRQUGVURm1UMnFDT3NKeDh6UGJ4cGErN2RCMUdBc0Z2K2l2OG5SZCtm?=
 =?utf-8?B?Q1A2cm9MTGdVV01xL2ZlU2tVNnlFTS9FWmdTdk9lUmJqL01VZUpQbUVJMzBJ?=
 =?utf-8?B?TFRvQXRrSmxGMnFmK1VKWXdJeFRCZUdySjMxRGxweFQzSDA3N1gyK3EzTTRI?=
 =?utf-8?B?Z3dMMzBaUXUydFhtOVNxOHJrVFdDcHY2cGFFaEdsS29jT0tzMXRWeCtmU3Jw?=
 =?utf-8?B?dDV2MnJnaGhlYlFPWnFaMkJwOXluSU5Ia3FPcVdlL2tXcHNOQW1VcU1kdmg4?=
 =?utf-8?B?clc3Y1BOc1pUSjEva0dPbmllcjVhWmFPN2tIMllqbk9mN0U3ckZRVFJZeW1S?=
 =?utf-8?B?SkJJbnc3eDZGS3ovc1JsaEZuSGVPRitUN3JRMklkYjdtYjhSQ3kwUDZiektS?=
 =?utf-8?B?c0VzUXh2RUhhWnNCK3EyK0VwSVN0ejU5NVY0U0NaUExhaVJ2aWZZUzY5cnh2?=
 =?utf-8?B?SVQrWWJIN0lmUHh4QndnOEx1bGJDTTlUQW41akh0YVNQOUJxM0JYVXRaUkJx?=
 =?utf-8?B?STd3RnRTRVh3QkdkWmNJTTYyQUs4c3V6NW03YmNUYmZhQUtBWHNPVlVLTTRm?=
 =?utf-8?B?eUZ5SjEwVFZLTnk4YnNOa3k3UjRPMjg4MUt1VmltUEZGSFlyeTNkcEYvdkZY?=
 =?utf-8?B?NGJ0QXQzeDBPaXlUWkpBalRKRkJGckZSbHFoMmdwSldYV1ZZbXRWUzJqSHFS?=
 =?utf-8?B?R1lleUhMYXpzdVhMaWd6Ylc0Vkl1K0R0SnRPSkdzTnZRcVZXVlhPcHdFS0pR?=
 =?utf-8?B?U1BDMG8rWktIVHRnMjV5aDBIckE5c1ZCaDhnMXMreGt3bzhhOWdrK2NxdEp5?=
 =?utf-8?B?MXoybzYzaWRuQVhLVk1CTkZ6U3VsTTVpRzRWYmVBN1Y2Y29oS0Z6ZkdhRzVn?=
 =?utf-8?B?MDd1REc3YWk5c1pVNDE4SVVyZGY5Slh3cmtTS3BVYVVrUFQrT21zSmJ5cmZ5?=
 =?utf-8?B?cmlCYnBQem5GUEkwV2JBa2JTMlVWamwzaTdHaG14cHVBNUZIZmZ1Q0QzT1Fz?=
 =?utf-8?B?UHAvUFozZi9GR0lMUCt0YXk2YVRUa1VSK2RwNGZDMVM0THNZMGF6VFZIWlRO?=
 =?utf-8?B?U09hY3oxN0RxQzNxdDhaMUxCcmhBNHlKWk1STThxRkNmRWtCbWZSRndNOVY3?=
 =?utf-8?B?UFFQeGNpYlgxTjBhODB6QVFoN3RKQ0l1Snd6Y2dwTm5nVWQ3UHVFaEFlaTZT?=
 =?utf-8?B?TlZZUXhUdjBWN1U0bjUrbytOWmFWTXcwOFNSaXZqdTQyVitxc0xia3dXTmdM?=
 =?utf-8?B?R2lDRHZaZkNuZ1lYVmszd1dXajRjaG40V2lUU3A4OGJNaFV2aEpZRFlmYk9w?=
 =?utf-8?B?WGhqVVR0bWw3eXVIb3Fib3JNWDVOeHhNZGJEemZFS3Flb0N2ZGp1eDU5VEVW?=
 =?utf-8?B?THA5VHc3WGJ1aC9XcnFGOEdTclJXRXE4cEViNzF4bHBNRXZvSkdpNlZGYlJB?=
 =?utf-8?B?dVpjU3NjRnFMNW5KdWI1RVB0a0J6aFRDa2Z0NUZ1L3NJV1JwdFF1cHJJNE9Y?=
 =?utf-8?B?THVVNnBzNnNKV2c1MWxRSjNqRVcvYlNJTDF3TGw4Y3hxOGJqSU5GS0twSDNW?=
 =?utf-8?B?WDlpbGN4aisvcFkrclI0WHdGSENuS0tKQUhabVlmYkpYdHhjcjR2VjkyQmZq?=
 =?utf-8?B?blpuczFwSldya0d6YzIwRUZma2U2aEdvSWxQK3VWSGM1cWhSb2lCZ2lDWHRH?=
 =?utf-8?Q?K3EXF9yqtyk+s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1VlYTIwcmxZYWg5bTVYdlBQczlrVDBmNmlyMmV1dWpQNzFqRmVYSUdoZjl3?=
 =?utf-8?B?TUREQVJQMlh0SXU4b0FYd01XbktNTXFnODE0R0lnRVhRUEVHdHNRSGp3VjVj?=
 =?utf-8?B?U2g0MHlYU05RZmw5cUpuQlIySXg0ZzRROUdleERoYkpjODk4VzlmS3NtR1Rs?=
 =?utf-8?B?ZEZsQWdOWHRJQjBUNmZLRk9XU1JaNkVJTEp6cDhHc2FDV2NlS3IyaVJlYW4z?=
 =?utf-8?B?UE9sZ1hKUnRHdDgwQnIxNjJnaExYeU84Y0x2N1RoZCsyYWVSZlJyc3dwZ0hs?=
 =?utf-8?B?TnU2dmV2cnJHZHVPcDRjcWNJeVp6OHA4QlZWUC9vZWl0MDdNZHVpRXduZWQ5?=
 =?utf-8?B?cjRSWksvUHpBMERtVnhMRFYzaEVvSnZoU3Z3aGRTNWQ1b29kSGtYT3M1S0lz?=
 =?utf-8?B?V0wyOGNpZjltalArbU9TRWJIbVlQOVlTUjQvUmp6bW1sTHoyTmltRjYrNnYy?=
 =?utf-8?B?M3ZjNTNtcCthZ3VUcmp5VFVrVks0Ky8xSmtjdmYrWFZJWmZFYitNbU1mcW1B?=
 =?utf-8?B?L1RYdjZuSS9DMzdLVWVKQXozUEtlWXd2dXptUUoxUVFpN2w0RGxFL3NMSjJZ?=
 =?utf-8?B?QVhSaGNMVmRac1NrelNHRjJqM1U2L3FRYW15aGlwN3BrMU9JU04rS05pRFRG?=
 =?utf-8?B?V2FIQzlGNlRGeTJQY0poT1NIQS8xOU9SRjRlOTl0RldNV1dweERxbzA2NWli?=
 =?utf-8?B?ZWw2Qmd1WnNKZGZDMzRQeVdzS0R5Y3BrNDdWQ0J0dlUzMWM3K2dJQXZFUjlQ?=
 =?utf-8?B?L3kwMzArQ3FpZmVoVTExeEJFcDc3LzBaODVHNVUrcCtpUFpwV3ZZdkFFOFZs?=
 =?utf-8?B?anFnSFpoZTFTbk5TUHo0Wi9SMUZmTXU5VHJZemVpU0RKejZOSmJwRGxYVG5u?=
 =?utf-8?B?d1NldWprdDRid3FGbjVKVW5GSHFDdENLc1FWc2dESldXK3pCT1RYTFJ4U2Nk?=
 =?utf-8?B?aE94dnVhNHYvMzVsRVM2T3hTS2lCeDd0Wm5jcDh4OEpUdzJpRjNEVVhROHFl?=
 =?utf-8?B?Q21iTXl2Wmg3aDNlMlduTFpZQldicXZ3M1d3Y213UkpQODFtZ2RTaHBMSWZ0?=
 =?utf-8?B?NmhxdGdXUWdNd1ArcVJTa050UmFrUit1MW5ZVkRaRXZ1MDJ0YmlYYWthVWRI?=
 =?utf-8?B?N3JacStEQ2NtVTdORWVMSmNkejliMXJLZy9vREtYMVB2ZjBKbk9VK2hvT0lp?=
 =?utf-8?B?R1hTd0hHdEROajJEODg2Zkc3V1dKck9TNjFkbFRqaEZMN1kyQy81T1RmdDVn?=
 =?utf-8?B?cEVkTE9zQTdoKzZKQ21LTE1hL24xTzVmTkcvemtMMjRWOUZtTHJHdXZxeEhR?=
 =?utf-8?B?RjM5M3lpVUZTSmpMS0FjSWo2ZUl6bkRVckZEUjJXMUQ5SzZCNW04dVEvak5u?=
 =?utf-8?B?NjJMWFZoeCtESzNNYW83WHg5aDJxTGNac2JDNmlDS3VVT2hjRkMzVlZlWGJX?=
 =?utf-8?B?K0VqWXNua0M4NUpFVDlsdkdZSnpMeVQ5bDRRaFNPWGx1Qkw2TnlNeWpCQW5i?=
 =?utf-8?B?b3JlRVFuQ0N6ZzhBWlF4WE9uaUpVaVkxNGVVd3B1elg4MGV6OTdOWWJLV1Yx?=
 =?utf-8?B?UDdIaDB0aVRycTRIcTBNai9jMjloSUdmWkNDV3pGR0pVdkZEY1ZLQkROeFd5?=
 =?utf-8?B?bnlXV2lkVFVmdWY2OHYva00rZnpTVlZOUWJIVW1aS0tQZXJVeklBS3RVYjNi?=
 =?utf-8?B?UDZDOHRtVlhMcnRyclh0OVZsNEszcnFFSzNtZG4rMElhSVQ2cTd3VE1QMzlU?=
 =?utf-8?B?MWdlT0U3Z0xjMWdqeDAyekRUeGhaVXBGcHlrb1NOeXVwOVQvbllYZnhXL0RM?=
 =?utf-8?B?eEY4d0s1c2hrYXpwUElvdjQ4dWpnR0hJdFArMjd0L2hCT01YL0JvNzlLTXZq?=
 =?utf-8?B?aENtUERSd1diYllKL2pvd3NhUUlwazM2RXhISStIREVLQzdrcW1YTWRlRE9a?=
 =?utf-8?B?QnFITnNNNnh6Qy9yNWp1d0gwZnRYUEtaY3MvNllXRDBOdnlPWklsVVdOV3c5?=
 =?utf-8?B?K1pHRjM3R2FobnUycDQxVThpU3V5V05vUnBCbkxybktWTjNUREx2WHphVTI1?=
 =?utf-8?B?WDBHSWlkWUNIRmRzNmdxZUcyS1JQM3ZxZ3djaDJrUXlNTGM4a2Z3T3ZPRnZ4?=
 =?utf-8?Q?JJx7O7DdAfcDMxqEheAfDODd9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a62f374c-5ca3-4257-e60e-08dd61bbed91
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 23:16:33.2936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFcJ73VoXrtC594YfhRQoMBVhGDmml61Ip2H60SmjKIfqiQzfwNghQVdk3ifg+0Vt42UGT83/mLzP5kwrsenkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6957
X-OriginatorOrg: intel.com

On 3/7/2025 3:55 AM, Ingo Molnar wrote:

>>  
>> +	/* Scan for unmet dependencies based on the CPUID dependency table */
>> +	scan_feature_dependencies(c);
> 
> s/scane_feature_dependencies
>  /x86_check_cpufeature_deps
> 

How about check_cpufeature_deps() without the "x86" prefix? It would
blend in with the other function calls in early_identify_cpu() and
identify_cpu().

> 
>> + */
>> +static const char *x86_feature_name(unsigned int feature, char *buf)
>> +{
>> +	if (x86_cap_flags[feature])
>> +		return x86_cap_flags[feature];
>> +
>> +	snprintf(buf, 16, "%d*32+%2d", feature / 32, feature % 32);
>> +
>> +	return buf;
>> +}
>> +

I was wondering if it would be better to build the feature name using a
macro and reusing it elsewhere? This is all I could come up with:

/*
 * Use with a %s format specifier to print the feature name.
 *
 * Return the feature "name" if set, otherwise return the X86_FEATURE_*
 * numerals to make it easier to identify the feature.
 */
#define x86_feature_name(feature) \
	(x86_cap_flags[feature] ? x86_cap_flags[feature] : \
	({ \
		char buf[16]; \
		snprintf(buf, 16, "%d*32+%2d", feature >> 5, feature & 31); \
		buf; \
	}) \
	)


This would remove the need for callers to explicitly define a buffer.
Also, it would help reduce a few lines in the newly merged
parse_set_clear_cpuid(). But overall, it doesn't seem worth it. Let me
know if you think otherwise or have a better idea.

>> +void scan_feature_dependencies(struct cpuinfo_x86 *c)
>> +{
>> +	char feature_buf[16], depends_buf[16];
>> +	const struct cpuid_dep *d;
>> +
>> +	for (d = cpuid_deps; d->feature; d++) {
>> +		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
>> +			/*
>> +			 * Only warn about the first unmet dependency on the
>> +			 * first CPU where it is encountered to avoid spamming
>> +			 * the kernel log.
>> +			 */
>> +			pr_warn_once("CPU%d: feature:%s may not work properly without feature:%s\n",
>> +				     smp_processor_id(),
>> +				     x86_feature_name(d->feature, feature_buf),
>> +				     x86_feature_name(d->depends, depends_buf));
> 
> I'd make this a bit less passive-aggressive, something like:
> 
>      x86 CPU feature dependency check failure: CPU%d has '%s' enabled but '%s' disabled. Kernel might be fine, but no guarantees.
> 

Sure! How about making it slightly shorter?

"x86 CPU feature check: CPU%d has '%s' enabled but '%s' disabled. Kernel
might be fine, but no guarantees."

> Because initially most of these warnings will be about quirks and 
> oddities that happen to work fine in the current code.
> 

Yeah, we can probably modify the check later based on how it goes.





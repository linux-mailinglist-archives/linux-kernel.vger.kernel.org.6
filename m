Return-Path: <linux-kernel+bounces-367188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28B399FF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890CD2865A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C317C210;
	Wed, 16 Oct 2024 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tqd7Q//f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5948158A2E;
	Wed, 16 Oct 2024 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050077; cv=fail; b=UQhzskMNlQ1R/RU2yYhYbZPzSVWA84Cd2gVHD/8g8EcIOXvPi1i1pmhvsgEtobGiHm9XHvoFV0aDzPEs1cZm8yy6o2AZ0wfozWTYhXtGP2xhciKXTr90zX1TXvb1Vbm0dgnI+sNZI9DaL2PUTHXI0S3Gr2N43B6ROMlXx6q2Vtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050077; c=relaxed/simple;
	bh=FlRPtMMpfF8gD0xYSENDyM+kKJssQVimFvPGlEVRpp4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1cGQrn1qGBmq+IPUvLzwR5WIwLg2cEyxAyj5D31OtO3WQsGoLgNyFUORl/anBSw3L1ddUKCrryrPC3oRy9f9g0pkew2mMzEAZNlHScSabm0dJhzDOJ2z6vf+LZua1wP8Qyps4yOeqdjVoCWRtP/oyVoKhMx+sOiyqjFbcG0gYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tqd7Q//f; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729050076; x=1760586076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FlRPtMMpfF8gD0xYSENDyM+kKJssQVimFvPGlEVRpp4=;
  b=Tqd7Q//fLCLAkrUNe7Zz4a+6svJOqsbHeI/RTCp8bbZMViivJ8SPgzoa
   ylyTedqZwyNNOgpaOILWTb/6UZbo1TRuZCF8vEsQhfkH4vFdq8QcLpZK8
   Ddz1hiQcFpvNp1RKmuIkxSRPoRuiPdO8Nyod2dvPEeF2Pe/hYwtCzd+ko
   FUoVpwwukNTCF62IUgbgG8VvpFlkbMs5R3i+YLJ7t1gzgYsgYGH86qSa7
   8uZUG/XiZUtQJOsZrz+G/LDWu4Yn8aRtnyqLowwaTu/onNCsBo4UVn1Hg
   Ggfbl8YvVvjalIlXF3sPssQnm/iEx1HVzvU3s6KU/FKxvHxKfSyuQxOWC
   A==;
X-CSE-ConnectionGUID: bEu3PKBcSXiwJQYwCyD1Qw==
X-CSE-MsgGUID: ezK9NbYgR6icq/QDQcoIEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32281219"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="32281219"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:41:14 -0700
X-CSE-ConnectionGUID: 70PQDkm/REOgq6mhnIn9ug==
X-CSE-MsgGUID: 3SsagNznQzK4NtEfoA4z+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="108840547"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:41:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:41:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:41:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:41:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI1mjO9XhqIs0FUqMjT/fe6uAckmSnCCOftUf+7jDT1Dx7JrsmK0jsbg18aX7Z0WhWNFgsZWKKai7z91B0FLEe91ITezW+8j5otAYSM5+aMlVvjMfW+4FgEAdpNNai57PvZsjmm4ORsc8uFhl6NOrkRcHxvVDHIvPNxhHDGlUpjCuezPMjvtwwUBdvqW4awDql5cZhTPebuMG0S5taE+xrv67hg0KQWIhHypWqOx/qOguXwF5qh/9ZfMwaoDTecZzM4Tlnpd/NZSIUcZkRWSarg4DaKVJgHZNYnw7htMlnWG+V1YWnIBhvNcR4yivMAX903vnchlnguLJJy9j++0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pWZEjQ26iKQoLz6Ger3woV0b7uCTxBY9muRynn/lBQ=;
 b=QECIHs34JAbM9tpNHzO8obxKksXqyNPeqsu1wXt8MQwAJUS9LZ/QUo24KgmcI5uysZAu4Dbh0faB48OjQQ2Wael41rkA1kn6jjGJaHC905ij4D+gN39PFge46Zpo6X5kYFU7Frdawv0iI+IBD3QrWEnJZIKlcqDTK3gQYM9yLDeJ36zrYlP3Yh7zyi6ZdqaWnZO5w/YgPVh9RHMbYqrVvrNiFH1NrN7plD0eYy+xFp48RQuFWsJDvCruv6HNlABC0lSVV6vZ7WVUmFghK2EqNT2L3arAFsqC25Z6akOzc/gUXgz0rcAi+X1/6kE2bTFXxPnOK2aFkAKglNH6pBoZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 03:41:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:41:01 +0000
Message-ID: <6752082b-9069-4424-a7d4-cb4480f09213@intel.com>
Date: Tue, 15 Oct 2024 20:40:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 24/25] x86/resctrl: Introduce interface to list
 assignment states of all the groups
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
 <a7a62f49523aabba1afdeb469c8df393e182acd8.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a7a62f49523aabba1afdeb469c8df393e182acd8.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 426828e1-fa06-408c-16ee-08dced945ac0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkhabHJnSGp4WEFTZm16eGRVbTk4cmM1ZGFSRGRlczd4NkxWNjFIWUZNNFNn?=
 =?utf-8?B?ajh4aWE0UFBBdWhSQjljSXpQc3doYm1YY0Y2Z3JybnJTRmUydWNkMjBYR2dy?=
 =?utf-8?B?UWhTZHZJZ1BjV2xpUUNnQWV0SjJ2RzJreER0TnZuVU1IWk9POG91cFM0cjJl?=
 =?utf-8?B?MndxWnJ5ZmRvU2J6bXU4R21iNWwveVJ1dDJNNjFFRnVQZnBGRlduUVVGNGQ5?=
 =?utf-8?B?QS90dlp3WXBUSndUS3JBS0NVWDBOZDM3M0I0OFJIeXFQdE1FT3FMU0Uyd1Ni?=
 =?utf-8?B?cUpBQWxDNnFXcldqNkFCU1I0U0c0VEIzeXdOelh6aW1RR3J6NkZ5NGUzVkJy?=
 =?utf-8?B?akl4VGRydW5PTzZON21tL1FKdVhWdUVHazBqV1NNaHo3cXJkVlFSM2VhMzhy?=
 =?utf-8?B?NFh2UFovajVBVUZtdW1FOUIwZlUxRVNNT2owRGZGSDRWcWpNQitMRjd4ZUE3?=
 =?utf-8?B?VnhVbjdkU2RyaFNSMno1cHFZazFqdW9ucEllM1JDUGRVRFh3amRZUEtBYU5I?=
 =?utf-8?B?R3FBWW5qOEZEcGRWZTJ6L2g5Z3dta25IRS9JVzNtbVFLNFpEY2NCM01JWUlu?=
 =?utf-8?B?ZU10L2pZZXZKMi9XdndrYU5JQUlVcTFrb0RXQU1pb0tJb204MlFHcEk1RDlR?=
 =?utf-8?B?d2FCKzA1cWVKL05kdHFZdzlFZytNbnE4UHBkbU1mbTFPdHUrTUxEcHJFUy80?=
 =?utf-8?B?blQrWEJZeEVoc084czd1blFrR2JMTkxZSEM3c3ZtazVGRU1HTHVqSk5WU2xD?=
 =?utf-8?B?YUFiYmYyUTYrbVhTNlpEeVd0Q2dpTkpTSUp2OXdQT3VJWXR2ZUlBVzA0UVc1?=
 =?utf-8?B?blBKNy9vdEFjS0xSWGRQb2tCQ3lBSm5nK2w3M2pyWFVIcnFFTXg4NVhsdjVL?=
 =?utf-8?B?a0dCd0xTdmVEQ2ZFN0w1QmFmM2FEOVZEVHd6Szh2M3E1MXRBd1BpL2U1bXZE?=
 =?utf-8?B?emdKaGdiRm5UYU5JOWlrbjdFVm0zaDFCcTRHYnRFT0F1ZHhJVE9wWGgwaXIy?=
 =?utf-8?B?R1I3dTRrSGxLUzdhcmh2cGpHUy8zaktiQU9CVnVVYXdBK3REZkRCaDcwc3RR?=
 =?utf-8?B?Smg3cGRiS3ZnN0ZwN3RmazFKVnFSem1HMEhka2JaMjNkTytCZkt5MUJBaG94?=
 =?utf-8?B?cERuUjE1ZmI4R1ZKUSszR2JNMWRqc3lmeDd4anVXWmZ2eGRwTEFuZ29xVVZJ?=
 =?utf-8?B?RlJodEZyWllVOEZyTU11aVVwRzdqUGpMcFNsZTlYUWhWUi9NTGxPenA3MjRI?=
 =?utf-8?B?MTlnZnhTY3VibjJXOGtSK3didGR0SXY2S2VaYlM0MS8ya1lhUGJnbHZpeS9h?=
 =?utf-8?B?d0NXRThVYm0vQTBTZk1BdTlnZVFyV1lvcnI3VkdnRUtUSWNIaFgySXlldVhE?=
 =?utf-8?B?dGtzYWhoSlcybzNZWFV6MWJ2MkVDZXBDUHE2TEtkNFMwdm0ybWNiSEFjZ2Ni?=
 =?utf-8?B?SXBoZVBPdXBvN2RERm9GS1pFWGxWOHpxbnoxL0FIRlA3VzFNbFo3WjRzOGlC?=
 =?utf-8?B?R0ZTaW9mZ01aR3YxakZDNlpDUGZkV1lhMFpuRVBrdUZmL2tGRDd5SDFGT0hP?=
 =?utf-8?B?Z0F3YXFaODNJaXhxZ1ZjT3g3YUtDUFB5UGVsV0wvdGtwWFhSR1FSc29Qcmpv?=
 =?utf-8?B?aTc1MkFVWHZ1eGc5WlgvM1oxb2ZjWkJ4aEhuemdMaDREbndKS1hCTzJWaGt2?=
 =?utf-8?B?V1l2K2d3TWZDYVJudzJ3KzdkWHdvbXVIamo3QTZlU2dJT0Z5RnFTbldRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2hFMzZNSk5HM3ZLeXhWU1RZTFlWVkgxcE1Za3hjajVNSFArSkFQbDdnSzVH?=
 =?utf-8?B?ZVo0SzMyNUlwSnNoR1J3VHhzbGVQcEhHUHFuL3EreUY5T0F2SXQzaE5OQWor?=
 =?utf-8?B?Y0YvWTJRQTEzeGRtQlVzbWJlUG9wb2FNYTNuRmVTaURyclNUYXNVRmE5WmYx?=
 =?utf-8?B?UzJWdW1PS1RGSjB1dVNFbUs4amJtcmRWRzBsQXB0YWU3NFlvQU5xUmtXZkRE?=
 =?utf-8?B?Y21NUXBVcGIyT3lkVUlQNW53ZUZpNnByUld1akx6dklXdG1yUkxYeW5UeGZT?=
 =?utf-8?B?QUhGR1RaUm9aejF4QVUvVHRRSE9qbWE2Nlk2SkNvUUVyeHRuS3pzc2FlaC90?=
 =?utf-8?B?UUp6NEhkd3ZIZC9PUjd6RTZZZFFjcTRmM1Aya1JKWmVZYkdSbzk2QjdraEZp?=
 =?utf-8?B?M0gvQ1N5Qk5iQXNJQTVQNG9aT0lMUWw5NGVNYlBWNGRGNmFqNit1UjcxVHAx?=
 =?utf-8?B?MTJhQ1ZVeUsvaGsrSUhoSm5WYUNFak9QQjdwTFpaTENlUFdGUHE2aXlRLzFw?=
 =?utf-8?B?SWE5WnE2SCtvWDhWY3l5b2hoWlV5SVpCSU5EdGF2WmJEdjl0ZnZaRzVrbGpB?=
 =?utf-8?B?MFNkZkhtMm5tU1dhNEcvMzFCbzNpRU1pL3hYd3BlRTdyaEpMQlc0dTJJVzB5?=
 =?utf-8?B?eTR6dWFNZ014dGlGOVBCNmNsdStPZzhaTDNna3ZUVnJRd3ZWWXV6VGVtVEVv?=
 =?utf-8?B?ajJNbFdqQS9hTTNTS2dPMzkwRGZQOEhrOS9va3lZTHN4ZHFHNVVvV1o1YSty?=
 =?utf-8?B?dFZWeGQrZFQ4MElvTDZCQ1dyWjdKMUlaNCsxSk5TZWlFenpwbUhNU0h5eDlN?=
 =?utf-8?B?TVZxMk9vbXFCZmt4ZTVRcSt1SVJxZDJYbVg3b1AyZnhFYVpyakNvK0tyczc4?=
 =?utf-8?B?dW1teGF4SnFSYVE0K0dZR2FBL1RRSDFTZU1pemozcnoydkRyZTByNjgrbmc5?=
 =?utf-8?B?dHZTN21wWWRGb3VnQzBweDNVQzRhaktoUlI0SmJOT1Q0THgrd3hXM3IxMkhJ?=
 =?utf-8?B?Wmk5K2ZLMXIyZmcreVJTeVRZZDFkL1p5dHlEZUpzODZKWWUrSGV3OWRnam5n?=
 =?utf-8?B?MHVVZ2Iva1hJY0xHTzVzRFRidzIrUDVaZHo3bStuTmY0Y2R6SlU0bEhnb00w?=
 =?utf-8?B?M3g4NkVXeDBDL1hvUFQwTVBSQzhUWk5VSWF3L3RTNHhXV1A0ajJ6Y0dhQUFq?=
 =?utf-8?B?WVRDRzV6N1RVS0FBSEJPdTZSTFRzUkVDQUhkRkVPVTZQS3RPMlgyS1ppdXdj?=
 =?utf-8?B?SEhzL09MOVFScnowdklHOWdwUjhaVHliMEM5MnR0OWJEbEdGRlJPQWMxazVw?=
 =?utf-8?B?VlRodWlQUGJFUFZEWHlTWUpsT2lNSTltUE5QVmhpLzlUKzZzbGgrR3VLOSt1?=
 =?utf-8?B?cXM1ZjdDblc0T1JpVGdXZ0NHazRzb2ErbHdRSkVwdXJDdEQ2emYyb3NsNXdu?=
 =?utf-8?B?aTBCRC9VM3AvZ1NRVE1JUGJXQ1dFaDduSnRpWkplUVJBbnYzYTJSdWQwZW0w?=
 =?utf-8?B?bWZXWEwzbGVMUElqdU5nVVdyYzQrMVJ5ZVl4UkdqOUh6NHkzRDU5R09rallS?=
 =?utf-8?B?QWM0NXZjeWVVa05ONjBoSDl3R2tHWW5Sc25YK3RacW5xNWdOY2FPWjhNc3Qz?=
 =?utf-8?B?YmtNTXpDSGdaUE84L0dTYThSa2hrdTBFZ3A0K0VZcDBOZHlHZVl2clFuMXJ0?=
 =?utf-8?B?TzAvT0xsWGxZa3ZUWXZ6NHVjSTEwZXlLY09EcnVzcDNXTEtodmNpT253SEVp?=
 =?utf-8?B?aGxMQnFyQVo2MWNGTTJqVWNCd1MySXluVW1IbFUxOHlrajhKTHBVMUdicXYw?=
 =?utf-8?B?L0pCeVFmQW5RT0gwVVNmM3FKQTg4NEZwZzlRZnZCdWZ4WVhwTDgzTEpGajBS?=
 =?utf-8?B?eitnQ2RYcDRxRHRlMG84b3krRXZhNFhjK25wOXdvbThCTHlWdjA0U0tHdFAz?=
 =?utf-8?B?ZXArSG9yTkJCaGhLckJ2SThrTW96ekhCS1lHdVY0RThJN2d1NmcvSzFRK2I1?=
 =?utf-8?B?T3FCL2lNWjBiSTQveE9vb2NGMWVKRHdMbURXZ3J5YTgrQTgzMnFBVDdmeWU1?=
 =?utf-8?B?VWxMYkxTVThYOElzd3haa0E4T3JlUG1Bbjd4cnZLVGlaYjFWcEZ1ZzVrZ3hy?=
 =?utf-8?B?SkJyUU9WczlxVDcrMEFTY0VWTC8rVWpYV0NONmwvSHBBU1hwNjJJTGhPQmc1?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 426828e1-fa06-408c-16ee-08dced945ac0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:41:01.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwRqQ3HTYleiqv5UO9RVzkJDDrKf6hmlgN29ukwMWRiLOzeCfBry3QgsBKmq0c5L0gUlVCEylz2nY02e+8iuTS85Wj8ZSateXDIQhRLlcMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> Provide the interface to list the assignment states of all the resctrl
> groups in mbm_cntr_assign mode.
> 
> Example:
> $mount -t resctrl resctrl /sys/fs/resctrl/
> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> //0=tl;1=tl;
> 
> List follows the following format:
> 
> "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> Format for specific type of groups:
> 
> - Default CTRL_MON group:
>   "//<domain_id>=<flags>"
> 
> - Non-default CTRL_MON group:
>   "<CTRL_MON group>//<domain_id>=<flags>"
> 
> - Child MON group of default CTRL_MON group:
>   "/<MON group>/<domain_id>=<flags>"
> 
> - Child MON group of non-default CTRL_MON group:
>   "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> Flags can be one of the following:
> t  MBM total event is enabled
> l  MBM local event is enabled
> tl Both total and local MBM events are enabled
> _  None of the MBM events are enabled
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v8: Moved resctrl_mbm_event_assigned() in here as it is first used here.
>     Moved rdt_last_cmd_clear() before making any call.
>     Updated the commit log.
>     Corrected the doc format.
> 
> v7: Renamed the interface name from 'mbm_control' to 'mbm_assign_control'
>     to match 'mbm_assign_mode'.
>     Removed Arch references from FS code.
>     Added rdt_last_cmd_clear() before the command processing.
>     Added rdtgroup_mutex before all the calls.
>     Removed references of ABMC from FS code.
> 
> v6: The domain specific assignment can be determined looking at mbm_cntr_map.
>     Removed rdtgroup_abmc_dom_cfg() and rdtgroup_abmc_dom_state().
>     Removed the switch statement for the domain_state detection.
>     Determined the flags incremently.
>     Removed special handling of default group while printing..
> 
> v5: Replaced "assignment flags" with "flags".
>     Changes related to mon structure.
>     Changes related renaming the interface from mbm_assign_control to
>     mbm_control.
> 
> v4: Added functionality to query domain specific assigment in.
>     rdtgroup_abmc_dom_state().
> 
> v3: New patch.
>     Addresses the feedback to provide the global assignment interface.
>     https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
> ---
>  Documentation/arch/x86/resctrl.rst     | 44 +++++++++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 76 ++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index d9574078f735..b85d3bc3e301 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -310,6 +310,50 @@ with the following files:
>  	The number of monitoring counters available for assignment when the
>  	architecture supports mbm_cntr_assign mode.
>  
> +"mbm_assign_control":
> +	Reports the resctrl group and monitor status of each group.
> +
> +	List follows the following format:
> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> +
> +	Format for specific type of groups:
> +
> +	* Default CTRL_MON group:
> +		"//<domain_id>=<flags>"
> +
> +	* Non-default CTRL_MON group:
> +		"<CTRL_MON group>//<domain_id>=<flags>"
> +
> +	* Child MON group of default CTRL_MON group:
> +		"/<MON group>/<domain_id>=<flags>"
> +
> +	* Child MON group of non-default CTRL_MON group:
> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> +
> +	Flags can be one of the following:
> +	::
> +
> +	 t  MBM total event is assigned.
> +	 l  MBM local event is assigned.
> +	 tl Both total and local MBM events are assigned.
> +	 _  None of the MBM events are assigned.
> +
> +	Examples:
> +	::
> +
> +	 # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
> +
> +	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	 non_default_ctrl_mon_grp//0=tl;1=tl;
> +	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	 //0=tl;1=tl;
> +	 /child_default_mon_grp/0=tl;1=tl;
> +
> +	There are four resctrl groups. All the groups have total and local MBM events
> +	assigned on domain 0 and 1.
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 395d99984893..fa7c77935080 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1269,6 +1269,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
>  			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
>  			hw_res->mbm_cntr_assign_enabled = true;
> +			resctrl_file_fflags_init("mbm_assign_control", RFTYPE_MON_INFO);
>  		}
>  	}
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index cf2e0ad0e4f4..cf92ceb0f05e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -970,6 +970,76 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static bool resctrl_mbm_event_assigned(struct rdtgroup *rdtg,
> +				       struct rdt_mon_domain *d, u32 evtid)

u32 -> enum resctrl_event_id ?

> +{
> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
> +	int cntr_id = rdtg->mon.cntr_id[index];
> +
> +	return cntr_id != MON_CNTR_UNSET && test_bit(cntr_id, d->mbm_cntr_map);
> +}
> +
> +static char *rdtgroup_mon_state_to_str(struct rdtgroup *rdtgrp,
> +				       struct rdt_mon_domain *d, char *str)
> +{
> +	char *tmp = str;
> +
> +	/* Query the total and local event flags for the domain */
> +	if (resctrl_mbm_event_assigned(rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID))
> +		*tmp++ = 't';
> +
> +	if (resctrl_mbm_event_assigned(rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID))
> +		*tmp++ = 'l';
> +
> +	if (tmp == str)
> +		*tmp++ = '_';
> +
> +	*tmp = '\0';
> +	return str;
> +}
> +

Reinette



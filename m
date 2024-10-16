Return-Path: <linux-kernel+bounces-367155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FC699FF32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DC22838ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FF15D5CA;
	Wed, 16 Oct 2024 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMsWnnzB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACCA13D53D;
	Wed, 16 Oct 2024 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048530; cv=fail; b=AzkgzNMDyT/FaAuP2zqU+srPs2ZnjaobEuU6Mf1zG4+/rPWLLkf4gkbusGTMsNtOODs6MIhynVCP4IVxEaPEUXRR6LmMBnLycM3CaRomXNsEuzIzAL+VOQf5wSBMCvGh+KmsL8dUASZND+UyXS8QhIwhqfmurA5o90vOq1FIRHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048530; c=relaxed/simple;
	bh=BKFbWNNeq79cEgDn7P7Yy4iHZJNFTL85IlXHuecxaJI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g46VWs8RdlPpXhDg9yP4rd+WkRBHJFx14chYSaRwzzX3TkCe+42OA0sMKAvdPvnEwVVIJpPFIvDr7611yKMuKwGrsSwJz6VKytQK4NiYFRyn8Iwk8xmzQinubA7jUrQxSxg4o4+/M9QM9kjMeQia0vKeDKG6dUT0+1/qdaIwgss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMsWnnzB; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048529; x=1760584529;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BKFbWNNeq79cEgDn7P7Yy4iHZJNFTL85IlXHuecxaJI=;
  b=YMsWnnzB5BlBiuBWfqRX2w3pNbv4zNWtpT4xKEfIB8lCsUj96DKf3XbT
   zQvayuKAVLCEgzVrUzEezQKZBqryI3JHPGJLm6iNuWx546A0KVsDNuG7S
   7eQt/bXWh1fediy4DdxDzwPf+2cmZrX+LaYEveR6uje846LzglrplPGRs
   HKe5mCLojFFFPM4YzVbhH7glghkpL3H90Xqfimm92SKBAChT60EjcR3dV
   q+0b/YyioB06jhzUUPi9DnBrl033WrfMgozE0Ozy9uljdty3aEk2xHYhG
   ZwIsiflQhiluJDqK9/QXeexOy2L+pHFwDr1FQ078/rHZM+d/avx7LAcH/
   g==;
X-CSE-ConnectionGUID: GdpU5WMUQMW83Cr36P9fnw==
X-CSE-MsgGUID: /h3wfijxRlWO9y70SpLdsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28354923"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28354923"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:15:26 -0700
X-CSE-ConnectionGUID: iXYP8YhoTgmuntU2KrXLlQ==
X-CSE-MsgGUID: GhyHlAIyRNyZt/kb0NV47w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77716448"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:15:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:15:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:15:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:15:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6DCY5G+py6bylCENk23WcAjQkB2F2FP7LBNMzAdMh51or430xWzd35hMhesCXbErBse96tDoA4IBspguL8q/hiZp9cr0C5rhpKacODaLN+cSpVnttV+QQV3FuoTxzu+MnqZLf9zdYhhdT8xWN10A6B2JiLn/bu6mzE9A/X6/zQHeduYbaTMWhbGqGWQ3G/QCyXQiavPbP5Sniw0SNpfb3AtcE8eUMtAI7mqs16iVuCoybdikXbjJBWDB0JY9cx162rTzfn2KDf25G4i00pQpPr/pmoocSsk4sQcxTte5weWelP4aRZJj3YtraXoK5Chf607uuNBTISoR83yyRdnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGp2bruL7KF+bAPbWsaAlsH18an7fKsnMBto72Ordrg=;
 b=Cyww6hV57skPBUjMP4XlqjZoIq/IGn2IBdnSytieQq85WPvBJRlFjoMbQjfx5btcgf/QDezd2xEx2Inqwa+m7QwKkxGt64Ru1ZAA1kTi8iJj2gsg0xm22HxkhIjeGLT3ZZ1+LI14i0m8DVeB7/qAZG6xyEhbAzKoS8WAUVRA+bt+wWEsQ5RRfmA8HbX7HHLMwp92K+4yr9voA7liSIEsEDHTcVEn5K92m8NtF85XB4TS/7NIMjAiWchN8+2B/CO4Lz7jXfGizHN/jHNUcKksmdLXKiRwUPyedZIHP9opdXXwQjA7niJl/IRtGApxrsaJVOyp7WiDGQgFvQLDYUk1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL4PR11MB8823.namprd11.prod.outlook.com (2603:10b6:208:5a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 03:15:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:15:21 +0000
Message-ID: <bd0b29b4-b43b-496c-b560-b3d279ecf163@intel.com>
Date: Tue, 15 Oct 2024 20:15:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/25] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg in struct rdt_hw_mon_domain
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
 <c428eff6b5763635f445f25ea8c8c6d9b1b23b31.1728495588.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c428eff6b5763635f445f25ea8c8c6d9b1b23b31.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL4PR11MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 2824f31d-2845-4b80-52fa-08dced90c4b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWlXNG4wcXJDbXYzQWZNU1BHTmxUOHJSeU91SVpFU3JvRlhqN0RZb1JBRkJY?=
 =?utf-8?B?R0EwOWIwWjNiZjB6Uk53bldMNElORmxXZSs2ajN3VFd2TU1xN21uOC9ZRVk1?=
 =?utf-8?B?L3dqa0RtTjAvaDVrMTdGSGtXVENUOFpuZ0w4YUxTVG1lbTFaSTNXdHNSeDl0?=
 =?utf-8?B?N0p5QjlJUGs3c1ppMHk4RjBsN0VaNXN0WkcwTWFpaUM2NkEwb0NIL1RkM2hR?=
 =?utf-8?B?Wm5mTXArYlhVY1RselRkSjR6OHVPaU16YjJoWGI4TVpISnFQdUhicmljVzln?=
 =?utf-8?B?L2JNQkx6OUFqYmJaQVRFaEVLUXpGb1NJMTBtdU9tcmZEcHM0U2puM2lQYUgz?=
 =?utf-8?B?L2pOV3pCZWRhSHg4YlMrTW5DL1NjNlVoZGFtQ0cydkltOUJXd3ByTEJWRlZz?=
 =?utf-8?B?QnU1UHNMY1RLRlgxQ2FXQUF6bEVrY0dVY2MrYjFpR0pWVkhXaTB2bXhoMVlH?=
 =?utf-8?B?WUNiNlZKM2Mxd2tWUnphMXFlSzZab0xTemNqaW1KQzZqWTM2TmUzZU1IUmZS?=
 =?utf-8?B?UDVIWkp4TS9JaVQwKzhuajA0cFhWZ1NsMGVmV01aNWptM2V6aVN1ZnpNT0cx?=
 =?utf-8?B?SWdOL3k5M1ZpNHV2MGtaajMxelRzZXVRWG0xbXBwUFM2OXZmZmRHaXhQNEtS?=
 =?utf-8?B?SXdxWEs2R2ViVnY4V2F1SFVoSWV2RFVsQjhVbld5djMyRUVySGxLdEFDbktm?=
 =?utf-8?B?ZjgvZzlkcS84RUdMTmNrT2pLczl5ajZXb0w3VUFLSFZtZFpLZ00raFl6NlNp?=
 =?utf-8?B?VEhIN1NuZVZsQitDYnUranRTQ2h3cE5XaHM4d2w3emVSNmZlakJYaU5sTDRR?=
 =?utf-8?B?dVBReHlHam45blR0MCt3UTFwNURpOGZFeWFzaEl0cFQyemdOQlRyT0dUZkJH?=
 =?utf-8?B?eXYrWmx4MDF4T0FJVVgza0lkZzFiR3NVVjFLTmRLdmRRSW9VYkZSOUJaeUoz?=
 =?utf-8?B?U2ZNWHZlOEJFVyt0M0NacWg1bEh6RnJWVThQdEt1MkY0U1FNdnNQMnljSnp6?=
 =?utf-8?B?dllKMGxnWU1GaFFaTURRTVpoS241VnhNWGh4Z0F2TCt5WllBdzBnelc4MzFB?=
 =?utf-8?B?RER3UGtqQlNFL21hWVo2QkRZZEFvOHRzT3BISXFSRExtVjd2V09OWHlLcFAr?=
 =?utf-8?B?NStUL1pUWUhUMlJxNE5IYi9ka3o4QXMwdWcxWFFacklPc0lwYU9LRGVhTlda?=
 =?utf-8?B?Sk9seG5WQkhHWEJzWWY0STRpVCtFR1FKeUhLVFNlYmZYR0NKUUhSUTJ5SU45?=
 =?utf-8?B?SitYaXV4TlRiMUxLTURLajZMOUE2dHduaG1hYktUbEppemhZRG5FODFHdU5Q?=
 =?utf-8?B?RHR2MmNQUnMxZlFnZkJLd2RIejRYTkZDZnlyYllPV1h2R3l3SjExK09mWjV2?=
 =?utf-8?B?Rlk4WG9oekFlQ0NsQkVuTE80bHFjcHQ1QXZ6Q0NNYTQ3WUdjTFBtQU93bnFJ?=
 =?utf-8?B?Q010aTYwRXk5SVJvbnJkZzJHWEM3REMzcDdSQWJwR3RSNjZZL3cyMVdSMGND?=
 =?utf-8?B?eG1uOUkzZGdmNk1TZnFNK3dBUERTblZtN3lQZ25FVUR5OGJ4eGtmQnJaRmky?=
 =?utf-8?B?V1VGN2JJdStLb2VsSjhRSG5qSXhVSFdLa3ZlNEVIVUEwdm53Z1pOaVBDSmZZ?=
 =?utf-8?B?VVVxOWlhbkRqV05KTDR3WmcvSExzaWIydFhvanJLdEtLMDRxVmFtNnAzUlhP?=
 =?utf-8?B?bjRhTitCZFFMMjRoeTlpbEltZ2h1TC9mbEcxM0k3Z0p4MUd6bDNraktBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTA4M0FpYVRiUkVFNjhVRmY3WWlUTHBSc1cvYktPMnpKSW9kOGRlNE9qNVl6?=
 =?utf-8?B?VzVpNko5MHJxQUxRaWdXWko3NmJQenYyLy9YbklaZmV5TU5BbGZTaTJETXhv?=
 =?utf-8?B?bmRSYmlIaHBmcmFucGlhS2oyL29PRkF2MUNnaVpsTEpveVNFOFowa1JDT3E2?=
 =?utf-8?B?VUQ5blpTeTVnTFo0U0xuM1p6QXdpa2JRZ2UxTGtnTUpobUlCRjZIRVNQTS8z?=
 =?utf-8?B?Z2lXemdrbUlRSEdXdEJmT3o0RGczODFRMW1Na0lBMWlrQ0NkWGkvcVlyaXJQ?=
 =?utf-8?B?WXBsK09aVm0wU1JLYUlhUUZjSTBLSGphTnBqS3F1Nm5nbUlNQzFFSUxlTm9i?=
 =?utf-8?B?UDY4dlRKa2tHNWFBelkzN0s2allsSjZaL2xRVnVZRDFZTWRjZDdjVVVlMExN?=
 =?utf-8?B?dndSWmpmdUdqTVdhWDgyRUo3UkdFenpDYTB3VGlxdDQ0L3ZSQ0lCZjdici9s?=
 =?utf-8?B?VXFaVU44elhINUpiSWQ1M0dwdkU5K0QrREZldTdZVXUxTWJqd29jSlgxQUlr?=
 =?utf-8?B?d1BjNlFjK3dnM0Q5SFhwZjNRWjRUVDJJS2lmYm4zNFpQbG1hZXV0RjA4a1V0?=
 =?utf-8?B?QUEzdklrV09iTCtDT1luWjlnSGkwY3oySHRuNXBodUVIaXdWb3lrd083Y3J6?=
 =?utf-8?B?TnhqYngrbmVtQkxUanM5VldhVnYxTTdmaGZWVDB0d2Vvbm1Kd0VTY3BiRTNh?=
 =?utf-8?B?QkNNYkY0R0JVRkFhYnluUGl6eTZtSm1DM0VGK00wcXd5SHZyM21ja3g1VnBz?=
 =?utf-8?B?akQvUDk1MjNvNXljQXF4dkt1V2V2Ukp3MDJNZ284LytCS25ocWVFTHdobkJv?=
 =?utf-8?B?em11Y0s3UmRGV3kvbXlBOWJJK0dXSDdtUnZCVHNCL29CdXJYY2NtbUl2alZF?=
 =?utf-8?B?cjVxRHVCVXYwWjAxWDA4aUUrbXRId2ROdi9hZmxaOUo5QlJPeU5RYjdnN1hy?=
 =?utf-8?B?WUQxUDJuTVp4cDBYMUR6M1lTUEtsQS9rc0dWdVc3bEdRRmtRbHlVa3NvTml4?=
 =?utf-8?B?RWwrbDFRYVFFOXpsOHdIK2IzbE10MVZ2bjZyQ0o1SUhWNzhJbXlPdkNTNVpP?=
 =?utf-8?B?VjIza3UzNm5FMTkwMGxiVzFkMFdmMVByZWl4S1dvWm5tdWtZL3NhZldEelNs?=
 =?utf-8?B?TncxUHpycWFFSTBWVE40aHhBNnVwRlNteitYN0N4cHB3Z1IyNG44c3J4bjhF?=
 =?utf-8?B?Z3d5QTJyZjhPSlE4cWZBeUZhTGpDUUtaN2pGbW5HRXVwNFdlNWNLOXIvcXho?=
 =?utf-8?B?QjZVdFdUS1lWbVZUalNKNTBOL2NwYm16eVBJa29BblNKcEhGMThGM3pRSmFv?=
 =?utf-8?B?NlhnZ3VHazl2ZXRiQlRaWTdrQkNoUnBpTUcybjR6eXlJaGRqdWRjTUFZZjJk?=
 =?utf-8?B?WnNCMlp5dE03R1g4eWV3ek5hOURJVHkrMFgrUHdKMDcrRVZteHVUbWxtRUVO?=
 =?utf-8?B?QVNtY3dZL2JDc0dlelUzZkwxUHhENGhHQ2tDUHkwWEI1c2NQRWNRM0NYYUVm?=
 =?utf-8?B?VCtvNGVwcm9sVnRvd2lPS1p0Y1JXazBHV2YrZFU3SE4rbGVMR09BS1QyYmFX?=
 =?utf-8?B?aDEra3gzU0hQK25EM04zUEFLdys1OUhXMTV0NVlzQ2wwaXErUXIxYmIrY1Z3?=
 =?utf-8?B?NTVxNGRBQ3RpUC9Hby9UeDBNcWp4T2EwSVBoclFMb3pPaGd4K0VSMjVzRU5M?=
 =?utf-8?B?ZkhTdUN6cktNZ3hHRFUxZk81bUwxTW03RERpeHE4SUk4UXRlM0FIclNZaXBV?=
 =?utf-8?B?Uzc3K1ZZbm5RbElYd2ZDMWZHN21jb01hK3JaUElYVWEzRm0zeXJkVjFFakJV?=
 =?utf-8?B?WmtBN0RXR3JnZHQzWW1FU0NNNkJ5YXFxMVYvU3RaQmNSclg4dTVISHNvZW44?=
 =?utf-8?B?QWJ2c3ZzQ1czTTNsb0lFQUhteUhyNThDWWlncFRzODl5Vy9oUktzLy93L1h2?=
 =?utf-8?B?TjVSSjVJU1JUOEZ3ektSdXFUOXNmdzUvWmllbVdTT2RJbnhrNHM0TFljOVpu?=
 =?utf-8?B?SEE0d1pHbFg3T2U3RTJhNmpVUkxZRDFZWitTMHovb0ZGQlZLNFBGRCtYbGdU?=
 =?utf-8?B?S2NUSWdQVlJWZzdPcVZ0VDlwT2MzdEJ1UTZkUHhVMCtOQ1BqQlpzUEZ2QjFo?=
 =?utf-8?B?QXBDR1diNnQrTUZyWndNbWVYVDNYalJyRWpHQzh2SFprY041KzV0RW1KRDNP?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2824f31d-2845-4b80-52fa-08dced90c4b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:15:21.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fc6o7KyoRNkjW6Vl3lbl2vCpkk45u+JOufQLcVWv+PXohvsrVo0mKgD/l68BhothIOgK9SsgusdnTpWXufsUwhtLCzYguAU6omjfvqJXK0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8823
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
> supported, the bandwidth events can be configured to track specific
> events. The event configuration is domain specific. ABMC (Assignable
> Bandwidth Monitoring Counters) feature needs event configuration
> information to assign a hardware counter to an RMID. Event configurations
> are not stored in resctrl but instead always read from or written to
> hardware directly when prompted by user space.
> 
> Read the event configuration from the hardware during the domain
> initialization. Save the configuration value in struct rdt_hw_mon_domain,
> so it can be used for counter assignment.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



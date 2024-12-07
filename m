Return-Path: <linux-kernel+bounces-435813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F199E7D79
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C0C282DCD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D73232;
	Sat,  7 Dec 2024 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mt0elPjB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645A139E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733531125; cv=fail; b=TvJVp8KeY7BX9w4/1wo8yMRI3c5tAtRLlauadGsJrDSCSwAzYtuyH8msuIhlkXhkcKJ/dJN/xHwHUN+eD7SK+D6q2D/XW6Hh5ok/rSkItcIO4mpMzjXFMlfmfAd7XXHrSCMoNwbtQfqORL8+i3cB2sDEWxKv4CUW/GbRoWQ2yyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733531125; c=relaxed/simple;
	bh=aGfVeJ/RNOfmOswwiQmcyCJqVBWdG84mAWw2/aFx95c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQxZl29QEnq9EamUN6BvgzA442ZFlz8w6nTkl3nlsODJRA+EGFSRR37kfrUag4kgi74TdU0v5jsO8PPy0SP2BihbXe5cBW+KU3i65Cr4Ks5yZD41XKw+Knborn/koe5sBgrjE4Rx8qCYMjtI/RtjlCAxMhYSysn5bfPEwlPIY9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mt0elPjB; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733531123; x=1765067123;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aGfVeJ/RNOfmOswwiQmcyCJqVBWdG84mAWw2/aFx95c=;
  b=mt0elPjBzVGT79bdkwDkn5Ug6l55JYaVLNSavSIePldrw+fviO7W24ek
   qgmkM45iual/6l+N9+tS53r/3LNmYW2rzzHpTIBYxxHWH1Raw1uIIFnFY
   OQGFhLepsn0B/2Mtk0GUkSaeYPYfLDqqrwgLERffnQenppB12x5LKgfyr
   o8/9OG9SAAGPTnRawz+XhRhS7wsDmfBPFtlUPeMaCLsARbpBRIO0aWiKl
   Pff+yTc4TvkOzPq7e1kv7nELrJwEX5NVMlojJFsO9BMl4xqvn5SbgxhCP
   QiE5H11U/HPo0bdBLYz2k8+JPPZ65RUnG8H/lLiaUdHbLkI5olDPkvnwD
   g==;
X-CSE-ConnectionGUID: rLUr4gNbRYewihxfJ+Fv3A==
X-CSE-MsgGUID: Jh2jhw5jSQ6nYhVQWsUXPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33952937"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33952937"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 16:25:22 -0800
X-CSE-ConnectionGUID: GzpFRhyFSWG77RQ/Jh66lQ==
X-CSE-MsgGUID: sGA9uFeSQgaT5EsHQqZW0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="131950367"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 16:25:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 16:25:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 16:25:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 16:25:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbt3svrOHR7PcEncgVzU5bNgtLE5utbYebazAiaCKmlFcG5zkoiv9mQXhMJS7dan6M2FgPDOoDWMQ3MkTsQ9U7npAd0cchQnT8h8z97f4w0l0ld8+FBtfuegktwtJONctdxRuoeMU713GPsRzE9MmHXrZ6MGtGJhBy7CuccSXPKFNOp9RzG91nGPxqEZwsDDfSMA3/plmMg8MVd7WP2VwgtLD/cEKEOdRTDXVw1ifrhq/xzWcgql3zJ4/qkANFwmnQ9Pj9mMunHMVURhS2AMC98bVKxPmu7a/AgMzrSSEMMqbCUMJFUiFRmQ/mOAMu6JY8RozOZ2oX3JM6JNvbMNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV4yLAmZCS8ZICFZhEvr1O1TdfG4km/yvrZuBbCJ1cI=;
 b=GszNqBmQXXAmFx9y7wO4dXI8E1pEqovzlcF9A516sP74nLNVPEjVVzm4vsf00SsPUfNkwIff5dyGk45sTsIAttDv8Epx3fkjdsjiLwqg5xJIOsxc+DBlHIDv2Zt0SpKCI4S7o7A6qRj1KNmrUPt/2l5O6Kpwz2+Q3oaPsZzkW4JGVgiD2CsSvH8nuQEYHEml6B52cCiKEctCtWqWt6WFmBVcFXnSZuYb5QfTQk6MZYBxq1MgeKWajecn/oos1tWzZgYptFN5xkvOkpRC0TQY1CDXnOL168o634xwkDQp7WC3DAtUm02chJXBPSSJvYsG8wvc/XQoEFx3mjWlAoQ7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 00:25:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Sat, 7 Dec 2024
 00:25:18 +0000
Message-ID: <3c8fa312-e6d4-41d3-8912-b35ecdf93eb9@intel.com>
Date: Fri, 6 Dec 2024 16:25:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Disallow mongroup rename on MPAM
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Babu Moger
	<babu.moger@amd.com>, James Morse <james.morse@arm.com>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, Tony Luck <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>
References: <20241205153845.394714-1-peternewman@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20241205153845.394714-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:303:2b::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 2639b7b2-a5cc-4c67-395d-08dd1655a0a4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmpsRTB1ZmtKeldMdmp0ZjJhalhZRUREcEFOOWFsZUpSZlNYWkNkZktHcXJY?=
 =?utf-8?B?clQweE4xVWFmODBiNmF4NGNsNExZNHJlbEZQSGlZZnJjUURnMnE4WkowY0Fs?=
 =?utf-8?B?d1lFWFZjTnpFNU9RdGduUyt0THVZT1J5bDZOa3dETDJCbGszOUoxNzNrWnhE?=
 =?utf-8?B?OGNDYTZsYTRBVFluNmFrYWVsY0RTRzhLQXdVWk5aN09VUXVwLzJwUjUza0tU?=
 =?utf-8?B?aGJTT2k2cnVLbkRSdFVma3A1cU5iNDVPb3ZudllGWU1vQncvTWU5ZTJNNWMz?=
 =?utf-8?B?NmRHLzcyWXRTZWdmN3BhNFZmYXp1RGZrK0FkcnBjamZWdFVaT2c5NzRQM3lH?=
 =?utf-8?B?NGR6SXBsaE0waDNxcTVCem5mdWt4RXAraE50YTRab2JhSzNpR3dkeEF2WUo3?=
 =?utf-8?B?K2hTdlZ5UzZFWVIzRk5sRVFuQWNyaXpWQTFhbHp0THlBdERIeEIwdnhNWkFn?=
 =?utf-8?B?a20zTXNmQXNwZ1gvb0xSMEdqU1B4ZkRXUWlzcXlkOTVOU0ZuakFLT0pkckhR?=
 =?utf-8?B?UlpXV2o4ZnpISEQ5eGF5MEIzNHVROWIzOHg0ODNQZUY2VVNjdHR1YUxyRURK?=
 =?utf-8?B?RkhGeCtoMHJLRU5NNlJIck55UzExYXU5QU5GdWxQcVlOblpRbkJJNDlKVmJj?=
 =?utf-8?B?dHhZVkY0aEdGVnFmSU5WMjlJVVZwR0NPYlJnY2QraDI3azJLV1RBZlpGdDli?=
 =?utf-8?B?UmNzbkxwdXpvZ0FoZWhrYk95ZW5wRFErcU9EZURIM1JXRkJ0QnZoNjBJUGJ6?=
 =?utf-8?B?dmtuc2RYUlRuNmEvbEhrUWRhVm5PVDRMRERhWUdFMFNHTGhYcS83NlFXTHQv?=
 =?utf-8?B?MWp2R1N5WTFaOUdZWlpGU3QveGxKRUU2YVllNDZUa1RCQ3pCTUtLekRYbVg2?=
 =?utf-8?B?TDh5a09oSmQwY2dvOTk0MkpHRmhPS2pMVThXZXVuZ2dhT25qRmdoaFVNQ3hj?=
 =?utf-8?B?K0xqUHpVYlplTEJXRk8xQkU4QjhQTkFlV3FWTUUyNEZyZU9tTFF6dGMraDFH?=
 =?utf-8?B?NTR6M0F4MDlBUVZTeG0zRXBMcHNFaWxPQzk0RFNvZjNTSWt6NTdjNjhac1BV?=
 =?utf-8?B?UDhaRWJDYy9hWXNPVHppbnJPMEJDK0dmMGk4QVZzWkRZcVRCTTRua1g0Uzdu?=
 =?utf-8?B?T1hYY25tV3JjOG8zdm9PZ0RzWWx4enZiQUs3RTd0R0lDZnVwV0cxcjBYR001?=
 =?utf-8?B?RDVMYjZhSnJYMjNRRlRyTEkwZ1FFVWJkZ3JLUk1hUHlNUnYrWEFFT1lEZlFm?=
 =?utf-8?B?aWpXRzM2SGZ5QVRNTDlyWktVK3RtcGZBaSs3eUZPbUd2dURIbVJoMk1Ncnk1?=
 =?utf-8?B?dlhPdFpadSt6VWV3My9RNzEraGtqcmE4LzRWYnN5a1Vyc0ZPRnQ2eUlzMzVC?=
 =?utf-8?B?akxxWTM5TXJmQnhjMUwxUitCN0R3T1h2NlFqeWJiODlHN3A4TWUzZXhrMjRP?=
 =?utf-8?B?OUt2NmtBTUZNRk9CQVdmZzM4ckh1Q2dmYlVVcHZVY3pzK0Zxb0lzVlhVcDdR?=
 =?utf-8?B?cndiVytRYlgycEpzVkNCZTNSRmg5OTdtM1FKM2JpeXVLYVRWaFo0ODZPVVJD?=
 =?utf-8?B?OFZWZUhaQnA4NGdCWTllR0VpMFUrMGZKak5BWWZQRnlJQWhxZE55cXJiUk10?=
 =?utf-8?B?MHhDNG5PZGdJUFU5aE5RMlRmNlpJUWV1TVJad09mTjJZcGpuRU1PeTh4K1RY?=
 =?utf-8?B?MmtwdGRvYk13N2ZHUEVoWjBpeHF6dDBlT05MS0FaQUJiOHpxMWY2T2wvQ1Bq?=
 =?utf-8?B?WUJwMnpXSHRjV2Eza3J3UitoZ09lMUNHOUYzYUJKUHN5TGVnNXlzQnJEZVJ2?=
 =?utf-8?Q?cZn41ZzbFL+CmBR3UbtZASoL2hCcx39IGyZaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVA2MUZxa0JDenQ0VjhHcyt4YlZFakczbWRxRW5wMXk5cFVUL2FEeGdrNUor?=
 =?utf-8?B?SlBkNFNzS1d1MGp4R0hHN1I5ZngwMTQ3MDk3d29qb0ZHWE5wRE91enNQb3cr?=
 =?utf-8?B?TW9KNjU4cW1JWkJtZTRPa3ZjV0E0WmFsNVNSSCthUm1QbDJQMjU0Qk9hbFVW?=
 =?utf-8?B?cGwwREFIZmdjN2hSWk0xWGJ2eEI2U2dsQlFvYis1K2dmSFM1NVlEYkdKMzU4?=
 =?utf-8?B?Nm5MS2tpc1JQVFlaT3d6SWlON2lOaE9HSEFLR2VUMlRUblRpbkE2bGJOdlNB?=
 =?utf-8?B?MjlkMXhJc2dnMlQxU2FxVDdQc1JhMzQ2bTVWNlFUV1ZrbWJ4QmtjdEpPWlNI?=
 =?utf-8?B?N09JS3o2OTFNenVCRGE4S0hMUVBBT3BhODRSb0ptM2dZbWVhSVBhUWw3SURQ?=
 =?utf-8?B?OFgxTWs3UTZWOGxQWldEM3NkNTFNQ3dCMUhBeDhSTzBublRmbkZ3NUVDV2Nz?=
 =?utf-8?B?YUxaa2dBSUtQMmhaMWN1dTRxSlU5UHd4eEtzUUZyTDBnaVp3ekdxK2FlK0x6?=
 =?utf-8?B?RHBHR1lPV0ZoOVFNSzFoWTk1ZTREaElaYnVaYWk1c3R1Z1Mwd0kwVm9zWVNK?=
 =?utf-8?B?a0pCSWpWTlNxcGxpUEpZaEhkVDFPd0QxaEFqSEkrYnJrNjFJbXdTaTBuVUQz?=
 =?utf-8?B?Sm5VWXNjYTRXQ1pNeGJncXIwVDl6OXVablB0RWR4TFo4RUxsa3ljME1QcUI4?=
 =?utf-8?B?Q0JKZzcwejBBcEtrbkxMK2toMzBCM3dDM0lreW1JZGFvYXgwYmlQY3RXcTJH?=
 =?utf-8?B?K2tzbmd4YXh0emRpK1RYSHlqY0pmb0NPTjdyVlpYZDAwZ28vRHZPY0x5cXZJ?=
 =?utf-8?B?R01YR2NLQ1NJdnBFbTRTeUdWbjZnU01RR2Rpa09NUEwxakNlcEdGTTZ4NStE?=
 =?utf-8?B?d3k3U09RbDhMYUlNR2hDZGhNTk5FeFl2ckdpUkhXRXhrZzFsRnllaitGWTl5?=
 =?utf-8?B?RDhNTDA0SWlmUFMyaVF5b0MvMlNBTDJyYmhmNCt1bC9QV3pGQm5iNDUwQjI3?=
 =?utf-8?B?MEYyblRGK3RDbTdPUlJSS2Jkd0llOVRpdVZGd1NHYmlsZHVpNytVY3BjTE5E?=
 =?utf-8?B?WkVOVXNTTFdxeU00RnQySUNNYk5IQUhaUjNNaGZQb1VhOVFuYmZLWkNCYzkz?=
 =?utf-8?B?Vml4VnFFelE2WUZnOUxzWUJHdnNHUW1veEVsRjZDQmlVZWlNVmg2UHExV0Jl?=
 =?utf-8?B?ZWgxekFFL05ZbTUzTHpvdUh6Y2JFUDQvNFhpSVBIdEVDK3dGWVRJT1VISG04?=
 =?utf-8?B?QVhqNzhTaHJ2c1dxcVpaQzhUeDVzSUx1enI1Y0FoVjJLR0V4ZHlwMDY4cFZW?=
 =?utf-8?B?NjltR3ZGK2FSMjBYQklaK0dhRmRQMzZuck9RNCtwcFdCazg4dVU5V1N5Nm5J?=
 =?utf-8?B?UjZBZStqRXhPTVgwbVBMYVNTOFZjM1EvUmEwQWdUSWpGaGxuM1lTWjJSai9m?=
 =?utf-8?B?NllyZGljU29XdldvODk0dFpycmZ4b1ZIQ1hPL0pkVnRWR2FtSmt1VTY1VkZ4?=
 =?utf-8?B?Zm8rd01sdXV6N0hOSXp6eUdrMnEzOFU2UVFqUG0zcS96K3gxTGl5M3YxN2p2?=
 =?utf-8?B?T2haUnlodGl4QlFaOVhtWDd1V25BV0NOeWNVQ1JtSTc2aVU4SnRvMENMRWpL?=
 =?utf-8?B?aEpjWUl2Rkw3bDB1UGlMU2pHd2d0QjJzTjErcnB4M3FRbnNralRFbTNUNmpF?=
 =?utf-8?B?Q3BtaWNMN0hzTlNBTXpuZnZyUDQ5eUV6WTRnRDZiWWVScTVEOXFrTVBLZk9o?=
 =?utf-8?B?LzVJbXlDaWdHRkM0V2lWOUVzZWV0TDlXSmJpTXBYSHViU2VIVE9QeVFzT21V?=
 =?utf-8?B?OVRkK05lTDN5bGRTYUFlV0xpcVZ1dFF5VUdvTVlheTU4bmhjYXRPNnFLZi9w?=
 =?utf-8?B?bnBsOGdqNEs4UytZZG9HK2VYbUc1S2lJRUFpN2lIRWxWbHJ3ZVRxOHN0ZGdT?=
 =?utf-8?B?bHdOcnJaS1VsZmpOR3c4TnZjQlJSWTg2UjZlNlZibVJMbG5kVFVKLyt5NHBP?=
 =?utf-8?B?ZzF4VUszTlhNMWkxdE1DVGpkSDU5aFp6U05yYkZSMS9nbTJQemwycGdZb1d0?=
 =?utf-8?B?NTRyVGJ5TnJwM29ZZXZ4QjNqOFdmTmRyT2ZSWVNLZXVyNFVxUjd0K0hOWTNa?=
 =?utf-8?B?TTdUQTJqZlhObXhHUld6SFFTTWg5b0xCZk5kcU1DeUNsNk50cUlpai9TLzV5?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2639b7b2-a5cc-4c67-395d-08dd1655a0a4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 00:25:18.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9aTkouHwewt3EUZi1JjSkvnMUKHdIOci8ZzBP84cfAtoYr3UWY/cBupPoNchNRNgjLm3rkeodjutShrTxebQ2AJDDWZdwM6gteBD9kWNo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com

Hi Peter,

On 12/5/24 7:38 AM, Peter Newman wrote:
> Moving a monitoring group to a different parent control assumes that the

Should "parent control" perhaps be "parent control group"?

> monitors will not be impacted. This is not the case on MPAM where the
> PMG is an extension of the PARTID.
> 
> Detect this situation by requiring the change in CLOSID not to affect
> the result of resctrl_arch_rmid_idx_encode(), otherwise return
> -EOPNOTSUPP.

I think it is potentially confusing how the changelog jumps between
different architectural acronyms without introduction and
without noting how these architectural acronyms relate to resctrl.

Consider something like below:

	On x86 the hardware monitoring id (the x86 RMID) is independent
	from the hardware control id (the x86 CLOSID). On Arm the
	hardware monitoring id (the MPAM PMG) is dependent on the
	hardware control id (the MPAM PARTID). resctrl associates the
	hardware monitoring id with a resctrl monitoring group using
	the x86 "rmid" term and associates the hardware control id with
	the resctrl control group using the x86 "closid" term.

	User space can move a monitoring group to a different parent
	control group. This results in the monitoring group's control id
	changed to the new parent control group's id. This is safe to do
	on x86 because the monitoring and control ids are independent, but
	not safe on Arm where the ids are dependent. On Arm the destination
	control	group may not have the original monitoring id available for
	use, and if it does, the monitoring counters associated with the new
	control	and monitoring id pair will not reflect	the original monitoring
	group's	data.

	Use resctrl_arch_rmid_idx_encode() to detect if a change in
	the control group id impacts the monitoring id and prevent
	moving a monitor group to a new control group if it does.

Please do correct and feel free to improve.

> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---

It may be helpful to add in the maintainer notes that there is no
Fixes: tag needed because MPAM is not yet supported and thus this issue
cannot be encountered at this time.

> v1->v2:
>  - separated out from earlier series
>  - fixed capitalization in error message
> 
> [v1] https://lore.kernel.org/lkml/20240325172707.73966-4-peternewman@google.com/
> 
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d906a1cd84917..8c77496b090cd 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3888,6 +3888,19 @@ static int rdtgroup_rename(struct kernfs_node *kn,
>  		goto out;
>  	}
>  
> +	/*
> +	 * If changing the CLOSID impacts the RMID, this operation is not
> +	 * supported.
> +	 */
> +	if (resctrl_arch_rmid_idx_encode(rdtgrp->mon.parent->closid,
> +					 rdtgrp->mon.rmid) !=
> +	    resctrl_arch_rmid_idx_encode(new_prdtgrp->closid,
> +					 rdtgrp->mon.rmid)) {
> +		rdt_last_cmd_puts("Changing parent control group not supported\n");
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
>  	/*
>  	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
>  	 * current parent CTRL_MON group and therefore cannot be assigned to
> 
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37

The change looks good to me.

Thank you.

Reinette



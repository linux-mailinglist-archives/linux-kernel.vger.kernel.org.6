Return-Path: <linux-kernel+bounces-430548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C89E329D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E52284910
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E6165EFC;
	Wed,  4 Dec 2024 04:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmfsaYMI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652A219E4;
	Wed,  4 Dec 2024 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285801; cv=fail; b=dl8daqJ1MAHV7+fa3ail3QaJKOXs7+mp31l93Ic9jDqpdJBdsnvfNc7qPyXFzwiGhUXxbqB9ikV6sNAzzBRBzYcfksNKE3lNiPz52iYvzrCozP2SPdiDthAewTpjR9lPav/TV63oKFPGghQoswmUDyJ7Y8FtuGoTvvGjszCq6zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285801; c=relaxed/simple;
	bh=5hajlxedU9vDVCE2lxxSaGkxOrqdZ13CB4wkJIxd4A0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7yclKH3LFkovrKjRUTtXoh/v17iymcMewwr2zFJjcGwA+hmAxTm/oIIi6wNORNkoQ6O3zeiCBObfuzhBZis7hpQyF+cs/r9RrAjv0i9ayFzYFJyuBAFt7CtT7xYqNnv9aC7tfT9Fd4X2mHNxKT9LHEc7SH88ezI1buGqvc19dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmfsaYMI; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733285799; x=1764821799;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5hajlxedU9vDVCE2lxxSaGkxOrqdZ13CB4wkJIxd4A0=;
  b=ZmfsaYMIs1by/ofmo+E1HwShMZl4UIKJwNPsz5iunJdiAPYowXaT5UEk
   q+cPDc00i5c669v19h+NOMrHRZ7seJsgQk0K6cVpgHJr7ZB4Iyf3ZLsx/
   yUQsCjI7uIqrUsNeHC+8yvl0jOx/BDmJNwjA3ttH35O+kkCfF7qtQuDTN
   KazGS1lVa/XmfGwecSo8Z8gukkZ1s9hmJ71WCn33MK9dpsP9DG+HmX5kP
   thaJu8hhqkfCmTTOoJLlU1GxmdOALVLnnNkzDSAon8AflvV8FRb9YY4mH
   uv5bRhrODw8VxHkPr3Two8Yra0akVCvChbT28gv1OoPgY0hSHnHam/43o
   Q==;
X-CSE-ConnectionGUID: r8mSDLaDSpCqFv+DKpW0WA==
X-CSE-MsgGUID: Y5ow3AwvSfq3NUN8dqsK+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="36381257"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="36381257"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 20:16:08 -0800
X-CSE-ConnectionGUID: LOzh7mLOQ+mAHbQZLE4blg==
X-CSE-MsgGUID: m2rUv3SRS1q1CKeFsVMZkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94072248"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 20:16:07 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 20:16:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 20:16:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 20:16:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tesEgsT5FJMzJyE4ATIvreSN9wJxkwoUYI6p55gsXt5s4P0sP2Hw7QnsCIIb6otooT402ewJgRPI/ArHK2JidmiodIeJl5Cwbr9nvs2ji+QyGtY9fFa3AD/OsO9N2oDni6hg1Xdvpi2Jb3QwVTznfDCODwpfhy3tzAS2nMA9Q4Y74J1rF7rq7age+tj3Uy41HSWxY2S2GKRl0hVvtP+bIKOxA0/V3c0S/baXrpthqo/IbDzdiPd8VqAdn7CgT300wBMJBIoLP+4+teE3gHc03uwUh6cN4NuZ0/gAIzoRCzCfLMa/6NqQdHAzriZqyoaVWkMkP2XyMaif0K7Stg4PEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6AMlnsxCGSFzO7W0oYGZIPLn+fiy0lgxadgISj0VDs=;
 b=sZ4c3fX67P6YmeQiVgRXdeyAQApFBZEMCynDUjAePxqkFSk8qGM8rMiv7oJCdTevbeQtjeFV+tDBzlBazOWidgP9WnpE8AjsFmPHh8VZVQ16ocXLLcjoTkNMd0/ZL5VoqR8eo4fmUIRxK80JDJkplhHi7VvpOzaz1k1CXrsNzH/pS2sCqilmQPpzK88+nZX3FewWQGOanBFMme4HoZau76NDWsZjJD5Cn0VmZjekTF3xg16RG1WM1vOeuQptYz6tbFqxwxjjkAVZh385QscsIkHrnTUIRd5tgD4V6CU03Jga+QhqB1Zo0Yfe4MaNhaoIKXEsWc2Pn+UkD+g+mYky5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 04:15:58 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8207.014; Wed, 4 Dec 2024
 04:15:58 +0000
Message-ID: <b3b3fdde-ce64-dbd2-00a2-a5d75259e558@intel.com>
Date: Tue, 3 Dec 2024 20:16:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 18/26] x86/resctrl: Add the interface to assign/update
 counter assignment
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
	<reinette.chatre@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <thuth@redhat.com>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <akpm@linux-foundation.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <perry.yuan@amd.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<seanjc@google.com>, <jithu.joseph@intel.com>, <brijesh.singh@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 005f7053-5bb4-4ccd-c342-08dd141a5a91
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXg1cVFDZUFoRnNrTHFKMnowcFVFS2JYeHlWTGJ1NDNOcHpUcHhMNThKWlY4?=
 =?utf-8?B?bXdTUkNPajdTMnkwakM0MnFoUUhwTVpRMGR4RHFianBwYTVVV0FhTUJWZTBw?=
 =?utf-8?B?K0VnNm9IVzMzSUphRS92MXkvUDBFeHlUWTVaeW9zT0huckNkTmx0QlE1WFJa?=
 =?utf-8?B?QUZReDhnMDE4b0xpTTBNLy94NmcyUTQxWkhja2NhZFU1dHExdHc5TS8yUzZz?=
 =?utf-8?B?bEs5bHRlZnM1RlFhbEJ6U3hKd1REUFlEMGl5UWxEUmxRZ2NpVHlOQUxJWUpP?=
 =?utf-8?B?alU2amQvdk1uMUM3c25pVk9iQ3VGeEVMcXYvK2JDTTN1di9xZlBJOVM5TC8z?=
 =?utf-8?B?R0E4YXdVWWpIVFJTMFcrajlnZnplNFdxN0wyWE1XNXg2RFJ5bUg4NzhCKzhL?=
 =?utf-8?B?MUVIbTRHdzJ4b0hJaVU5TkZUVUN2VXprUEppazB3M2drT2tZZG5ScG90eEow?=
 =?utf-8?B?WW8vRzlwS0NYdzJqL2lFNEcyQU91emVVdXpxbjlDMHE1Z3Jwb0JzaUthbzQw?=
 =?utf-8?B?RTdMMzNCNVJFaDI2ckM2cFpNdEltVTh4MTlFM2VyTURJOVcwVGc2VzBlOVFK?=
 =?utf-8?B?bTBtR3NXVHF1NUlyczd5UGZmY2E3MXk2TXlVREVDWWtyeGJBbFdCWGl1SUxr?=
 =?utf-8?B?UE9wSmV1NUpxNFhlZ2RHN1g5c3h3azhOMFNxRFRhQXAzRlJQb1dFRUwxTmF3?=
 =?utf-8?B?UlozYThwemRxd3NCWkk3RnVmTWN6WjF1ZjRuQ1pBaUI3OWRpa01IVVhBVkhH?=
 =?utf-8?B?UVVSR2t6eWhzbndPYUVNUnJHQUNNS0RDZ0xwUnFBVU5NYlJiNFdVTTNndzQy?=
 =?utf-8?B?bk9teG1EajZTUlZIbStNZ3FNelhUMzdTYTlRNXhYWkptVjZ1STZtUnBvakZQ?=
 =?utf-8?B?UGw0Mi9YU25lcVRZV2pPb2JkOWpzN29SKzhrc0dzZXdrZjdXRlBYTWlGM1VP?=
 =?utf-8?B?cXAvSW5aeWQrVDhvSjJDb0wrZ3BtNWNZVEJkV0dtYnJJN0R4bXloZkNYZnFv?=
 =?utf-8?B?L09SQXl2T3VMTlRiQ3k2R3c4RUh4TnJwMjA4YjkzbWJaVUduN2c2SkMwSlcx?=
 =?utf-8?B?RitMZnJqMkt2MmdSTVRmbU56RmRGR0ZCRDI3RmhnTWJXVVhINVN4WWpjVDlU?=
 =?utf-8?B?TVlINFgxWkpYbDRNYkhIT0FIZFliQkdNZVIwenVCaXlPNVlxU2dSSTVjaHRi?=
 =?utf-8?B?NHhXQW5FTzdQd1V0OEJyOGZrZEZGbXI0MmRvSStKdkZyVGNtdmhSVjdLaUFZ?=
 =?utf-8?B?QUQ3UThCR0lPUFRzUE9GSTdoWTcwdzBTdUxCN0sybDZHbFFpbXh5cnpxekt2?=
 =?utf-8?B?cThtQnVoSCtCTlBYQTBSOXI3clhENml6UGs1MHYzQnR3d1N1RWZqS0JHNk80?=
 =?utf-8?B?bU9lSlREcHlXUnRUbHV4MlNiclVEdzRHbXNPK2l0aXJCcmRobFRFams1dTVl?=
 =?utf-8?B?ZUZaTDczSVgwK2R5U0V1c1dBZldmdDJDNWpocVpyRjJzY2YrVFhZZ3YvK1V0?=
 =?utf-8?B?bEkzSU82cXBJY25HaVFkOHViMFZ3NXRHVmtpdWpZZit0NTM4c3VjVWpxV056?=
 =?utf-8?B?aVdTdEx6VmdlbU5pS0VSdjZ0ekRSL2s5SmJhOWRvMHo0WFBMS05kWHRhS1Rw?=
 =?utf-8?B?eGQ0NFI1M2tpV3JyWHc2ZEc1T2FHSE9PdnpEazZLUGN2Tys4K05yajVONllB?=
 =?utf-8?B?MTA2Q3hkRmVPUkZEYWt6Y0dhUlVhRURUZEVFai9jQjFrVXh0R2Z1Tk1SQlNO?=
 =?utf-8?B?MjZwbm5xMFVuNUtHTlRZdjBUb2dFQlI0cU82bWpQN3hlSVhucldzaXVrTEc4?=
 =?utf-8?B?MWRsU21HVVdoOGo0ZGE0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3pvcFpQajQzMHJsVXJzTGhWU3JJSG92OUNwRkxSNFpVbzZIUmJ2Y050cHZm?=
 =?utf-8?B?ZFU0MWpyT3l5WEJJWWdzVjYvTW1aSHVKZW5tV1pXWjZES1RNcFoyZFk1REQy?=
 =?utf-8?B?SzJzYUJDVmplakVXSUh0Qm1rSTZGK0RualVSa01Sc2dlNzQ2bEtMajd1bElw?=
 =?utf-8?B?NkoyUnVLMTNjQWVlRTM5TUxaUDlSUjZWSjk4MCtZOG12MW5KZHF2VlJJalEw?=
 =?utf-8?B?SlhOLy9ralNNNmpMZTdnbWhOb1Q0UWVIRVdHSUlyRUpaeW55ckZtMmNKYUVB?=
 =?utf-8?B?V3FBL1Rpc01SakVDQWhZVGZtK2l1ZEhGRU96bk9DRGg4VnViYUM4aVpIR3dZ?=
 =?utf-8?B?RmYvY3BiTFFBV1kvZEZBNi9TUmtNTkFMSmtJY2JoVTJ3V0ViUThkdE9seVZW?=
 =?utf-8?B?UTcwdUlpS0hYMG85cjdlWkhWZWRGbnFCY3NwRzdKSmJZUHhBY3AvSG1NZFZG?=
 =?utf-8?B?ckRaWS9WZjhGMzVSMWlwUmlpWGlkVVJ4NW05SDRGZnljQzBFS1dabXdTd1FS?=
 =?utf-8?B?cUZFRzVmOHh0MDVQb3ZxUHYzRXV3dUx2bHVjYXRZTTVManA1aXJld1FOeldI?=
 =?utf-8?B?TXZrbmlVOTFhekJ2ZzVxZXB5cUpVN2lKckp6Vjl0WnNHdXkreTVnd1RyWmhJ?=
 =?utf-8?B?NU5GMWFGeXJMQWlvaytFbWhLM3RUa0s4QUpPbFgybEFmdEwwbm1TdTExTHdk?=
 =?utf-8?B?Y1AyaHAwdFpRK1ZNcFRFbmZiemEwMWRXTFVuQW4wVG5TTHlnb1NuaEQ4cnU1?=
 =?utf-8?B?NDlnNWVNMCtMWDVDbGtoUGVXQmtQS3hqcExsMW9keDE1bE5GUHZPQk9xeFVr?=
 =?utf-8?B?RkkybVBQMnBwc0JNVFR4RUdTelhkc0VPLzcycSthZ2NPeWE4Q0hoeFA4alZk?=
 =?utf-8?B?YWZkMHpKdkRjU2UxMXlSQUFSalZML3NyaC9SVVl5VDVneVZHRmQrQWJBR1NG?=
 =?utf-8?B?Wi9GRjJXTjNlSzRsTTQxeGowZm45TlpnNmJ0TmlGYzFHU3NZd0pYVzhZbDgz?=
 =?utf-8?B?OWtYRW9uUVJVOVJVOWNwT0ZoK3dkZzdPbVZNZXZaYkpQMjBOQXBaL21wMFY2?=
 =?utf-8?B?ZWR5M2g4Y3o3RTRrYjQ4WWIrcStYUXZOZEs1a3V2UU1YNE1VNmNEbnFvZUxL?=
 =?utf-8?B?NkQyRHRvWkF0WHdZZ0VuaEk0Vk9PMEtiVTB1SnJiUkdpRnljb3A1UGg3YU1W?=
 =?utf-8?B?a2xRSG5UTlpLUXdTSUkweUNjYlV5ZWdxOGdST1BCK1RuTXdHMUN6WXd1NTlF?=
 =?utf-8?B?OGVmN3dya1BjejV6U1RxSXU4VHM3U2szRDRzU1Q0eHZFbWhLdytPOE1NYkJo?=
 =?utf-8?B?Snh2TCtpMDVzbEVZbUZDcWVqNklXN25kZ01lOTMybzA4UWxXMTN5dUxsQXhM?=
 =?utf-8?B?RFJVREZFYVdWVWNyUFlVV1EvZXNHTnM3UVJ3bFI5cmdHcGNLa2hIYUNBNkYr?=
 =?utf-8?B?ZWhaMlc0bkx1NHZwNzZkZStBK1owR21MeGpzWGx4UzVFRlMwV3N4aks2VkNV?=
 =?utf-8?B?TU5YNzZQQU14QnErdVpOK253d2RBRHk3STI0S1NteFVpTDlmQmZSUGNIb1Rj?=
 =?utf-8?B?QkZ6cmpoMkZSUTZyZUpUbFVHRXpJMk4xYU5pR3E0Y3pnUjcreThjdFl1SXgv?=
 =?utf-8?B?U0NsMkxKWVVVWGFFeStiTnpFNFZsZE1TaU5XSDVvbDJsRC9mM1l0M3NLUGpv?=
 =?utf-8?B?R2NMMHlYQkdMbWZWVkROMGlCeFAzeTNOWCtBQlU3dVF5M1h2SDNJOFo5U3g1?=
 =?utf-8?B?QWtIcEZZdGtmSDlveEp3R3pQTVNsODIvZEx2dUlPRFNtZmp6SzlsbENITDI4?=
 =?utf-8?B?UCtUUXVXam9wMmJYKy9qZHpHdkdaT0g5Y3E3azVTMG9zZ0h6ay9xT3pBUXdK?=
 =?utf-8?B?SUtmbVdmUXR6RUNQTlJkdFhOY29nU215cnZuSnRjbVFqS0cybkNKckM0b3Ry?=
 =?utf-8?B?Vlh5cXh1cnJnTHFMWUdqSVZCajRxWGV3N1AyRjEzZmxveS9reFR3UG5iRURF?=
 =?utf-8?B?Vm5DYXNtMktJdzhVTGkrUW91Y09hS3lsWnZKc0hyZzVVdTBtNTFZNFdvQ2Ja?=
 =?utf-8?B?d1lpTlVnU25peXNvbWtOb0F2MkJ4VTNwc0lzZ0h5SjJVRFVTMDh0Vm4zV1I0?=
 =?utf-8?Q?Za7QibTLezPSNagLqUDfEr7aA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 005f7053-5bb4-4ccd-c342-08dd141a5a91
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 04:15:57.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxJi+HnkENHNvNwqf+CKfz4BhiB7oejWGqEpY8r/apkcK/kI4vcntpbiFE2nIkpglrnbUf4Ghs4xcif5Vyk3rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-OriginatorOrg: intel.com

Hi, Babu,

On 10/29/24 16:21, Babu Moger wrote:
> The mbm_cntr_assign mode offers several hardware counters that can be
> assigned to an RMID, event pair and monitor the bandwidth as long as it
> is assigned.
> 
> Counters are managed at two levels. The global assignment is tracked
> using the mbm_cntr_free_map field in the struct resctrl_mon, while
> domain-specific assignments are tracked using the mbm_cntr_map field
> in the struct rdt_mon_domain. Allocation begins at the global level
> and is then applied individually to each domain.
> 
> Introduce an interface to allocate these counters and update the
> corresponding domains accordingly.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v9: Introduced new function resctrl_config_cntr to assign the counter, update
>      the bitmap and reset the architectural state.
>      Taken care of error handling(freeing the counter) when assignment fails.
>      Moved mbm_cntr_assigned_to_domain here as it used in this patch.
>      Minor text changes.
> 
> v8: Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
>      Added the code to return the error if rdtgroup_assign_cntr_event fails.
>      Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
>      Updated typo in the comments.
> 
> v7: New patch. Moved all the FS code here.
>      Merged rdtgroup_assign_cntr and rdtgroup_alloc_cntr.
>      Adde new #define MBM_EVENT_ARRAY_INDEX.
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 87 ++++++++++++++++++++++++++
>   2 files changed, 89 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 00f7bf60e16a..cb496bd97007 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -717,6 +717,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
>   int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>   			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>   			     u32 cntr_id, bool assign);
> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>   void rdt_staged_configs_clear(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1b5529c212f5..bc3752967c44 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1924,6 +1924,93 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>   	return 0;
>   }
>   
> +/*
> + * Configure the counter for the event, RMID pair for the domain.
> + * Update the bitmap and reset the architectural state.
> + */
> +static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			       enum resctrl_event_id evtid, u32 rmid, u32 closid,
> +			       u32 cntr_id, bool assign)
> +{
> +	int ret;
> +
> +	ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
> +	if (ret)
> +		return ret;
> +
> +	if (assign)
> +		__set_bit(cntr_id, d->mbm_cntr_map);
> +	else
> +		__clear_bit(cntr_id, d->mbm_cntr_map);
> +
> +	/*
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in next update.
> +	 */
> +	resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
> +
> +	return ret;
> +}
> +
> +static bool mbm_cntr_assigned_to_domain(struct rdt_resource *r, u32 cntr_id)
> +{
> +	struct rdt_mon_domain *d;
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list)
> +		if (test_bit(cntr_id, d->mbm_cntr_map))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * Assign a hardware counter to event @evtid of group @rdtgrp.
> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
> + * else the counter will be assigned to specific domain.
> + */
> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid)
> +{
> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
> +	int cntr_id = rdtgrp->mon.cntr_id[index];
> +	int ret;
> +
> +	/*
> +	 * Allocate a new counter id to the event if the counter is not
> +	 * assigned already.
> +	 */
> +	if (cntr_id == MON_CNTR_UNSET) {
> +		cntr_id = mbm_cntr_alloc(r);
> +		if (cntr_id < 0) {
> +			rdt_last_cmd_puts("Out of MBM assignable counters\n");
> +			return -ENOSPC;
> +		}
> +		rdtgrp->mon.cntr_id[index] = cntr_id;
> +	}
> +
> +	if (!d) {

Should assert cpus are locked here?

         /* Walking r->domains, ensure it can't race with cpuhp */
         lockdep_assert_cpus_held();

Please see more comments on patch #20.

> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +			ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +						  rdtgrp->closid, cntr_id, true);
> +			if (ret)
> +				goto out_done_assign;
> +		}
> +	} else {
> +		ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +					  rdtgrp->closid, cntr_id, true);
> +		if (ret)
> +			goto out_done_assign;
> +	}
> +
> +out_done_assign:
> +	if (ret && !mbm_cntr_assigned_to_domain(r, cntr_id)) {
> +		mbm_cntr_free(r, cntr_id);
> +		rdtgroup_cntr_id_init(rdtgrp, evtid);
> +	}
> +
> +	return ret;
> +}
> +
>   /* rdtgroup information files for one cache resource. */
>   static struct rftype res_common_files[] = {
>   	{

Thanks.

-Fenghua


Return-Path: <linux-kernel+bounces-328872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F50F978A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C502863BE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2682154BE0;
	Fri, 13 Sep 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgpaS8gv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475D824A1;
	Fri, 13 Sep 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260407; cv=fail; b=pzrED2NW8CXiw1IL645jqCFd2ffWGK5wd6kpPtTrhyPZucU5NWsyx+SKpQwI45VypkDtFL8GqOoiq7aFaGCw8BCEuGzX7z/FtjavGezTJkkLdxOQId56L0g6cUtkWS3c4erTUwEe1iQeSni8ZSDlelLZTHzKDbtddUAdED8+aVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260407; c=relaxed/simple;
	bh=oY1xvxZoYBgdcgXF0l8WyRFlDsO59w52jEzVi2K2PBY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=an2aFYQhriqBJz9OjDEpOjFEPLD//wZA+L4tswmG6vLBoLJ/NfVJz0gaoAltXtrYJVuiHcIFSUypMe9Y+QwNdqqbm8uteKhLiyTtNyn2+oykr2vTLJvAkIULBN1zESdTT/sqcUahKWdYqShf+C0nAPlP8OkvzEjBI13llRnQ4sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgpaS8gv; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726260406; x=1757796406;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oY1xvxZoYBgdcgXF0l8WyRFlDsO59w52jEzVi2K2PBY=;
  b=TgpaS8gvzjLL+XccceKeGq1HG4V3l2j3pqUqsIwcAlwffKXLf+SookkB
   McL6Sg4on4aiHqGZ25cRT+SU/K1HLpnq6lLvPQLtIBZW/ebZw2WE5xsBS
   bWjhOgOgS8u3EmzlqJCEA9HKd5LE8kBZ3Dcb0Y+uxwk8x2XWnnjx2vA2j
   b4ccAbzWw+vjuZrBzJ4OcNARM37sAnfov3VSEYfUGBh0ZdwXLnwAGUnHr
   LUUj35sj7pPPcYQvTywgRUkj1L3CzU1mGAO8zk20k9k3cP4y4bJ/krulg
   +0RB6uwKiaG/sdcBY/qovFQS961wGzFlFaoSXpF33XBrDkvC4xrX7rW3i
   Q==;
X-CSE-ConnectionGUID: XqeBP0BuSKSiTd5ozgkPKA==
X-CSE-MsgGUID: YzoBxqopQhKPv/bAqvj7yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28959075"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="28959075"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 13:46:45 -0700
X-CSE-ConnectionGUID: WQne9h5gQeuXIZf7Q5nIPA==
X-CSE-MsgGUID: 6NL9v/fQTcu0xVjjqWkLOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="68439735"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 13:46:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:46:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:46:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 13:46:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 13:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc0CvK5joZMPCdIFn+goSXtWFmzDxDktIpmGpv+ihBJTvKO/kebOGXNvLTl74tGF7bCip1UkmZ6xNxZ8ujO8vnqINk7CtM/D60DBRod2N3+pkSuwXuzpD1xWNZ6WBp+/zLlCEqSziYEXV4ez9SQC/4L1qAEzONkw2LnljmEkpc2TmU8GV1zrPJv5IHUaXZcJ4O6/x+gabADSsLPfqG79TJ7xXbxrUEr1Drlk2Lfik5ohW1kVwfLAc/DNRE8D4+3rnr47k5wQaC76RzZjV1qAsuQwHY3wh1PMQyoJxXD8yhRqfNGsb18jokqilGHk2IFmc8p5vxwOZqKRS2I+W5Z8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEcxJVC/GUy1N1JZZv2PJqJ4D5uyjuWNAX4m4coIuC0=;
 b=ki2WbTMDtjhmBB7S2jv6rJVaXfEbT5H319JNJJxYEZM/FgOoy1wskROj/v7Ll19LkxTGqmYyFWgUmtFImfxSd03Tl+F2j/7RtLajFur6dK3SLlUlTkjhYH6iEQPxHBGgPKqJcOkI9diIJ+Amd5HcbndFpmVehkn7HTdo5Cjg1OXF3wTdPp1Hiaio8Ho+uMIFk7LPBZq0exSqQ2u1Gw5Ot2Nk3F/bZa717sjhw1mwfjHmEyi7G5mgu2oUDF0f8WGJeb7LCjciOXkNZfdMzvgevy9cvqCnFC56jubrFlLoA2OZgeAWAwK/OShYie8g7KUfsevyk5jZ0v3Vn/Xh5C086A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 20:46:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 20:46:40 +0000
Message-ID: <e85178fb-7258-4bd9-b9a3-0114c1c41111@intel.com>
Date: Fri, 13 Sep 2024 13:46:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] x86/resctrl: Implement SDCIAE enable/disable
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <alexandre.chartre@oracle.com>, <perry.yuan@amd.com>,
	<tan.shaopeng@fujitsu.com>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>
References: <cover.1723824984.git.babu.moger@amd.com>
 <d40df35b8f25b1ce009863da5b53f43640fb426d.1723824984.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d40df35b8f25b1ce009863da5b53f43640fb426d.1723824984.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 939919f9-8a20-40ad-5883-08dcd4352b32
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDJhcytvbXBmbWl4QStZNUNkeGhPaFN0VEFIMS9ER21jbXRYU0tob0hIWkxP?=
 =?utf-8?B?citzTlpsRXhxSmhLcjJncGRLWFNWWnRyNmxjclFYQTNrVmp0MktxMWFYTGFP?=
 =?utf-8?B?OXFNV1Q3WUFkN0RpY2JSeVJyMS9GTzhKRmRxMHU2bGtvM3VDL09JbEFhNHUz?=
 =?utf-8?B?dXU5SnRpcFFEMFFiMlh1SzZQR1MvWnNncU5hVXpCUHlrbE9kdmxvNi85WE1q?=
 =?utf-8?B?S2dpSENYUE1FQWd4ZGQrbmQxTmFGekJRaGI0S05mQW9tWUlVdko3Y2psaU51?=
 =?utf-8?B?V0NwOWdWb2FnczViUEs0a2hxU1NqK255Q3NvdFE1bEdKSjdiUlRTOUJTU3hw?=
 =?utf-8?B?SlRDNEdMclh6RUR2T3JkeFpxbC9aaTVDT1RSR1h2ajNjQ2VoK25lZlozWVE3?=
 =?utf-8?B?WHFCL0FuYkp2RWt1Q3EvakxCSlY3aUhVRjdKTGk2bDlRcjlacTI3TGw5d2ZX?=
 =?utf-8?B?L2RFRkRveGhtMDdjTGF3MzVVeXJHejZrSVZ2YlJCdUpuVHFGcUhCdlc1Qzhx?=
 =?utf-8?B?RmE1WUFUOUV0aDNTOU1PZUxLZ3JZZG9ZOE5BS0JYNG5uYm1vRzhOMzV4NXhN?=
 =?utf-8?B?WjJ5b24zRmk1Z2VyUGdyU3ZKSS8zZ0RaNmlpRmNSaC9URUozY0wzN2d2My8z?=
 =?utf-8?B?N3ByY2s0dWFYMGthaUVBcTFXeVBtM2ZKUDlYWU9icTBLZzVUUUc4NTNDdGti?=
 =?utf-8?B?QU9YTU4vbDczS0NKM2tjaG91V0k3Q0gxb2RlbTVIL0IvOVBHdUE2UVA3YWJL?=
 =?utf-8?B?eGxwRGVodDRDcWhnZlNnUmQwNnJ5aUs1dnBNSysvMjBzUHRVbVRiZ3dWTk5D?=
 =?utf-8?B?bklSNnJKajJJbGh3WHVxcm9NZ3VTWWhEeHZPQkgzc3RMcW51ZlgzNGt1UDJi?=
 =?utf-8?B?Z1lNQ1RzY2hMQVY1bUJCY2tBcG1rbkNvZmU1QnJYejk1S3VkK1FLSTdiQ2RX?=
 =?utf-8?B?aUFiWmZCb2IyRkhmZTZ3cEx4UDdmcHh1MGxrYnFFTTRBUDNGY2NSdXpuRDli?=
 =?utf-8?B?aGltc1dLbVZJVlIzYURyZFJyMXJDV01FNU9zWVRqb2FaMjhoWHVIRG0xeTNq?=
 =?utf-8?B?QzZ2cWpaakNNMUJUTGVXcEtReW5QVHN6NXlCazNZbGtjKzk3bStZU0NLM2R5?=
 =?utf-8?B?NmZZRkVTQVZZRlFyR1JJVWxHdXY3RUpGbkNZTTJpU3JRNmtSZk1UQzFHYW9a?=
 =?utf-8?B?Sk9tU1NuNnArQy8zcFUwVWZlTkUyQ3Y2REY5RWhrMjZHRGl3YkpOTVMwcnZp?=
 =?utf-8?B?a1FtNjJtMzd3RkEvOVdpdXkvaEhMTk1CcE1YZytnRWZiUnlpV09rcDI2dkZh?=
 =?utf-8?B?TEhyaFNRNTU2RnpKUTBsblJqUUJZU2U5b0V3SkNwNmpiNEtKRzlqcklkeVlV?=
 =?utf-8?B?L1NBc0IySDJKb2ovQ3BvWEV3UGdnN1psckw2Z1RnTXAzcDA4RzF1eFFuam1a?=
 =?utf-8?B?bE1MTVAxNjlRaGRBaHMzckk0STMralVqSGFYdDMrc1ZoczQ1TkxvR3luNzlZ?=
 =?utf-8?B?ckk0aDNNcnNKdEZ4UFh4aEpiZE9MTDgxN1ZZaEhIY3RWRnRRODVrL2V0LzRW?=
 =?utf-8?B?Q3BBVXJzU1JiaXk1SndWc2FLQ1BZRU1WR2FjR0s1dzV3U1V5UFgyd1RYc2Jh?=
 =?utf-8?B?YXBxQ3NvalJKeDdlL05aOXlQMm91WVd6Mk9lYkIwaUtJVE9Dbzd5NkVRQ045?=
 =?utf-8?B?Z0xSZm1zOTAyRVR3RW5HV3hKZ1BrUVRVYm5uMHluUTk5V0p1WEM0YTM0TnAy?=
 =?utf-8?B?b2oyU3ZieloxK1pyeW5BZ1d6S3F6ajVnZDdSOVp1cERIYWZyS0RCbXlxRVlZ?=
 =?utf-8?B?eFBKUEZXaWFxOTdPUU50Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVhWSkptSm56ZkJkRXVWemVhK3lXQzIxd1Q1RDRVQld6SXFzaUFNemhpYWYr?=
 =?utf-8?B?T1pUOFpPdHR2WTA3SzBqd3kvTTY5TlFvNVlxZlg2TyttZ05WZmhLYU42QStN?=
 =?utf-8?B?UWM2U25MNkllWnpRd1dqWmt0SkdHdnNCMGIvVWdFRGNNcUJpa0pZZmVyNGNP?=
 =?utf-8?B?NnpmbWdIUXNhcWY4TWk4UXZEam9GeFBLakNzLzFsNW5EN1RVYitkemlMbk1n?=
 =?utf-8?B?dTNpRDdNSHkxYnB2WUVTTnlkdGxiUWpiT0toUncvRVhSciszc0hJWGZwVlRN?=
 =?utf-8?B?QVVUNitoUmJ5ZlJUd1VTeXh3ZEpGQzJaRHF4QnRZUThiQ2xEYUFrcnN0TW1N?=
 =?utf-8?B?dW1DWTdIVGlqV0dScFowMUtWbnhveGVKYzJHa0lBYXNDczVJZC91S0hyeW13?=
 =?utf-8?B?VXBURkVqNUMrbG85YjFoUzdLNEZkOG55ZWkrcTZlUTI5eDU4ZzhKL05xT1pZ?=
 =?utf-8?B?bGRuZHp5Vkp1OHl1b0hsanZJQ3NSZE1JM3doK25xemZyQ0pGYzdySzgwL3J5?=
 =?utf-8?B?L1FVeVRYdG8zbnJuMGR4MVNJTHdCL0NTVUFHNkFTM1NqMXl5RVBKd0FZZ2pW?=
 =?utf-8?B?eHNGSGFWNGFBRGpHUFVnaUFjNFlwcWVleUs4b3dvVDBDcGNBZUhkUXB5REVv?=
 =?utf-8?B?L1QzVm1JeDZJSVplbzRwSzZkWHpFQktOYTRBSXRnanU1NFJvZmZCRUdEMGd5?=
 =?utf-8?B?clIyZ3lHY0ZpWGV2a3kzb2hwdEhHaVdyQVh3bVRQY1hlMFdia0doRU5OY1Ir?=
 =?utf-8?B?ODZpR09kVDE5bnpWU01mWUh4K3Jwa0gwdE5VREJZVm5SSTZYMGZoZTF2a1pE?=
 =?utf-8?B?TWNHQmZ2ZFgrQVBadGZoRUhDckVaTUZEQkhLVkJDQ3JrdkN1ZVBmeXRqRllX?=
 =?utf-8?B?NG1xckF4QkczdXJZWE5XNWdyRzdjWURjTCtDUjJsUmttR1M3eWVNK0JTbGxa?=
 =?utf-8?B?ajA2OFVQUzBuTCtadU02dTdWbkc4Nk9qS0w0NHZZcFQyeWwwaDMwc2IxWEZE?=
 =?utf-8?B?OHNvejBYek5uWk5iMTY3WjM2Wm05RTNFQVM4dmg4ZU1UbllGRWVNaXFpMHBG?=
 =?utf-8?B?NC8zMWtCbE5xTlJVaHlGQnhYb21TaG1SSm4vTFhnblM1aUhBWFcwQVpJa05i?=
 =?utf-8?B?RnNJWHlCU2JRdDJuZ2UrMUxzM3Z3Y1dja3BlYVl6Y1lUaTN3em9PZ1NJcFBZ?=
 =?utf-8?B?U3hVV2RrNUxMTU5KcUswRjFCNXF1T2llQWJaOFJBOWJpREpLdFdVNVcxMVlM?=
 =?utf-8?B?TlVHYncvSXBJczhPOWJkZk9YUFFaY2RUdTRUSmRyQWZHaXRmc0RaeXZYd0Iv?=
 =?utf-8?B?QzVJSGNJYWlkMGZYNVE1QS9MZEhLYVhaS0NaQzVXaStSTjgyQkdvem9LbDdl?=
 =?utf-8?B?bnFjY0FKNmczbXM0UEc0K012N0FaWXQzV1NxODZoTnJmb2tkSmM0c29tNDVa?=
 =?utf-8?B?b08vSUFNWVNkUXdyektkNHRnNmF2NXB1clZ4MGN2eWRoYktvV2w1RC9SV0hE?=
 =?utf-8?B?a1RNbmhHeDAzT2s5d1BPWE5aK0dncEdBQmlRWHVVVVdDVVh6dmNpVVA0YlBF?=
 =?utf-8?B?OVhsQTYwbUcxYzd5RUhMbVpycEFvUXZnMC9GenpMM3ZMWmpMcWU2Mk9ZZEI0?=
 =?utf-8?B?WUJOZjBRMXJGRWZJTkNhb0h5SkxhMEVWKzNLdVA4SThiY0RrWFNGM0xWOStZ?=
 =?utf-8?B?SE9US0d6SUVMN0Z5K09TOEdIMlNPVklPN2cxTUZ5blFheC9KRG0rZ1ErbGZl?=
 =?utf-8?B?bnhaUnJoTzVMVVhMNEVWcUk5RFE1NUN2QVkrYVFwUUhEc0l2MjFNLzFYZDU1?=
 =?utf-8?B?aUVhWEIvanRQVjhWcWxZdHRSdkZsQVZiTVl1Q2R2YkRlUEpQWGhpN054dFNV?=
 =?utf-8?B?REwvL0lESDRSQWNFeC95NWw1V1NySnJuaXgvNU1jY3puN0Z4Sm0zVXNpb3FU?=
 =?utf-8?B?RGJNMGN1Q1htdyt1MkVwSm5zanhrVHg5TGZuU3ZlSCsvY0hiSVU0UC80WFNC?=
 =?utf-8?B?RjlDbE9adEEyV0hVZmVaK1ZaYmFkOUp4SS95VEptT3RqZUVxME94S1VJeGls?=
 =?utf-8?B?RVIyK1Vzd3l2eS8wRlpQUkowcFo5TjhiaTVhZWpWYkFpMVd5M1psb2N3Ymsv?=
 =?utf-8?B?L3d0ZzQ2Y2VNZ1hIMTRNcVc4SUUyUTdnanM4OFdxRytYVWlwY2JNNjlhRmVX?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 939919f9-8a20-40ad-5883-08dcd4352b32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:46:40.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNgZMVAkhR1Xyo2QbpiYIbEE04I9+SYDDaG62OpOF+u/PB9gPrFsL/6uNPf/H8s3b07bdExo5CymSz7uAHr3ZbR9pRv2mlWqjx44bDh9u88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com

Hi Babu,

On 8/16/24 9:16 AM, Babu Moger wrote:
> SDCIAE feature can be enabled by setting bit 1 in MSR L3_QOS_EXT_CFG.
> When the state of SDCIAE is changed, it must be changed to the updated
> value on all logical processors in the QOS Domain. By default, the SDCIAE
> feature is disabled.
> 
> Introduce arch handlers to detect and enable/disable the feature.
> 
> The SDCIAE feature details are available in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE)
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
>   arch/x86/include/asm/msr-index.h       |  1 +
>   arch/x86/kernel/cpu/resctrl/internal.h | 12 +++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 ++++++++++++++++++++++++++
>   3 files changed, 74 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 82c6a4d350e0..c78afed3c21f 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1181,6 +1181,7 @@
>   /* - AMD: */
>   #define MSR_IA32_MBA_BW_BASE		0xc0000200
>   #define MSR_IA32_SMBA_BW_BASE		0xc0000280
> +#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>   #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>   
>   /* MSR_IA32_VMX_MISC bits */
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 955999aecfca..ceb0e8e1ed76 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -56,6 +56,9 @@
>   /* Max event bits supported */
>   #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>   
> +/* Setting bit 1 in L3_QOS_EXT_CFG enables the SDCIAE feature. */
> +#define SDCIAE_ENABLE_BIT		1
> +
>   /**
>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>    *			        aren't marked nohz_full
> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>    * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
>    *			Monitoring Event Configuration (BMEC) is supported.
>    * @cdp_enabled:	CDP state of this resource
> + * @sdciae_enabled:	SDCIAE feature is enabled
>    *
>    * Members of this structure are either private to the architecture
>    * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>   	unsigned int		mbm_width;
>   	unsigned int		mbm_cfg_mask;
>   	bool			cdp_enabled;
> +	bool			sdciae_enabled;
>   };
>   
>   static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
> @@ -536,6 +541,13 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>   
>   void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
>   
> +static inline bool resctrl_arch_get_sdciae_enabled(enum resctrl_res_level l)
> +{
> +	return rdt_resources_all[l].sdciae_enabled;
> +}
> +
> +int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool enable);
> +
>   /*
>    * To return the common struct rdt_resource, which is contained in struct
>    * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d7163b764c62..c62d6183bfe4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1789,6 +1789,67 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>   	return ret ?: nbytes;
>   }
>   
> +static void resctrl_sdciae_msrwrite(void *arg)
> +{
> +	bool *enable = arg;
> +
> +	if (*enable)
> +		msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
> +	else
> +		msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
> +}

(hmmm ... so there is an effort to make the rest of the code not be
resource specific ... but then the lowest level has L3 MSR hardcoded)

> +
> +static int resctrl_sdciae_setup(enum resctrl_res_level l, bool enable)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
> +	struct rdt_ctrl_domain *d;
> +
> +	/* Update  L3_QOS_EXT_CFG MSR on all the CPUs in all domains*/

(please note some space issues above)

> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list)
> +		on_each_cpu_mask(&d->hdr.cpu_mask, resctrl_sdciae_msrwrite, &enable, 1);
> +
> +	return 0;

It seems that this will be inside the arch specific code while
resctrl_arch_set_sdciae_enabled() will be called by resctrl fs code. It is
thus not clear why above returns an int, thus forcing callers to do
error code handling, when it will always just return 0.

> +}
> +
> +static int resctrl_sdciae_enable(enum resctrl_res_level l)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
> +	int ret = 0;
> +
> +	if (!hw_res->sdciae_enabled) {
> +		ret = resctrl_sdciae_setup(l, true);
> +		if (!ret)
> +			hw_res->sdciae_enabled = true;
> +	}
> +
> +	return ret;

Same here ... this will always return 0, no?

> +}
> +
> +static void resctrl_sdciae_disable(enum resctrl_res_level l)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
> +
> +	if (hw_res->sdciae_enabled) {
> +		resctrl_sdciae_setup(l, false);
> +		hw_res->sdciae_enabled = false;
> +	}
> +}
> +
> +int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool enable)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
> +
> +	if (!hw_res->r_resctrl.sdciae_capable)
> +		return -EINVAL;
> +
> +	if (enable)
> +		return resctrl_sdciae_enable(l);
> +
> +	resctrl_sdciae_disable(l);
> +
> +	return 0;
> +}
> +
>   /* rdtgroup information files for one cache resource. */
>   static struct rftype res_common_files[] = {
>   	{

Reinette


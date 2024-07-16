Return-Path: <linux-kernel+bounces-254421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19B933304
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E173F1C2237A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572C61A00ED;
	Tue, 16 Jul 2024 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1rC/VrY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BA21448ED;
	Tue, 16 Jul 2024 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162584; cv=fail; b=RJQptR74pME3LeWpC5ZjHesb82CkJ9l3RQznlbx/1/wD7j03BizdfzU0MA46vG3nOBxykT/PaMvnThRQT+fyAZGM+h2Zu4rLwQVJzy0GWGTFe8xewdFcITf4lTdGWeC84oRh646cC8tmWZpBnsoGANWeZ/V0oJrGPBLzoydobgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162584; c=relaxed/simple;
	bh=l0vSoZqHye9dqDRr1EvxNqFzwRgAT/YdEEUbHdjEI4Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aerWLqMIc+AxAIAei+Dc9kcGpbFls3eYv9G0Axm7Ud437A6ytYgo/mw2JtpfZa9WuVx3ERFXz4xeRxZ3H+qgwcKXVCHypwQZdrN9f2Kr3PL0SjP1+M3JtUxZRVGMTmfA/T9RTaKI6IOD9FsmZJjgSWMgZe5wGPdTcKq/DOSCZz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1rC/VrY; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721162583; x=1752698583;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l0vSoZqHye9dqDRr1EvxNqFzwRgAT/YdEEUbHdjEI4Q=;
  b=i1rC/VrYs5P2d+mHbXgMxnVT0WoUldbjLvlR2QRpjAaPtw9p2HqyGh6N
   NmF3A+C0x8nttF4mw3KH9Khwd+S78+EcXblAjQE2Pgpk/51MOPXRRPYGz
   temLcEVW57JZ62WlXQFlk3i+wOOqufczvMlYLYjhssChuAPg/hgYvnoV5
   lGN5mIG87NJ8ymZvuRiKXRnvQ4xpVDaGscploEMZdAFwyVUDEIQHQa/DY
   AbUHg3qQDOcStYMxQz8ycdothZHxX0gJd/GLhm2BhHqW3Qo3AcL6gVmkt
   VAJ+uxGBKHRg+FurLTXoy5L369z8lSUu5aMq43pIkEu5Exrxlfibo57MV
   Q==;
X-CSE-ConnectionGUID: +QaAJWKRSmm0UAYRXGd4bw==
X-CSE-MsgGUID: Tl/FPtthQr2QfrUyuxqd0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29781742"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="29781742"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 13:43:01 -0700
X-CSE-ConnectionGUID: YuAayZe7SXKkDopGD0z6iQ==
X-CSE-MsgGUID: 0PAN7D9WQ5aXxty/NT1X8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="50056244"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 13:43:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 13:42:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 13:42:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 13:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rr0n3f3NTts3/BUImIPNFbQRLfy4GpCBnMWp9c8r9CgPyyJk04VT0ffjuaxAnj+2J8HB94LL7ziOE3Ce0ME1aFj6jqmDkJoMuKOCSSqLQZ+eF8TQ3yt33qZI3fJDg2luPOKzHIiq+IobLT8UJIXAOknnP7sBolP8xbRMdy0uB3oiJWMyw3tUFoBVAki3NGQoD33qY/NUEF5xztHEGGcrPfCn4wuRdCggCo34KbdqNmkXnbGoIfajJm8QzE/4o1xZx88tJbHg0gparDt3jHYDXppALTOwA6cX4CuSlJ0e8qIiCYRc0GktqEG/nJ5n4QCL04f+AGAm5bvVCKDmSjZEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lguyR75wCpnFvFFohRuEHu3tFIc436vBZGcKxENcj2o=;
 b=dGk1bplq4siDJDGq2KNInTVVkxSeNsU2xFCFBKv5ein0LLW3but+/U1F4qQm2ky2yNlVgs8LGatlE1+Fuz3T9rDGTosRSKkVj54XmPrGl9vKN3yuHkzg9Yed4F/VukAhuiDsY2u7oZkcycMaBcUqI+STtKuuO3cm7MwfuzK3Jz0k4vvxeY68lOUvMY3BI2uV5MeVVDMj6SpckY7sPlE0g24ghqVOlh9gsd0uVDPkcLJU6BvX0O7BnL0QOvrROK7Kf8uEciUfpjmhO4Pz+f++0R6TXlVY5HUEWeCiExrkuRCE5LqIynXSFh4Bz6XyhMKX8eqhDTSZnw5QBAU3h01ScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 20:42:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:42:55 +0000
Message-ID: <fbdccb3a-031c-44ba-aea9-36d22096a28a@intel.com>
Date: Tue, 16 Jul 2024 13:42:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/20] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <f3f03d4c3518474d3e8a591c22d965ba5b934361.1720043311.git.babu.moger@amd.com>
 <6a68fabd-9a37-4183-8234-36ab8fab9b5e@intel.com>
 <b10fbeb9-6ab8-4cc1-a786-9a62faa27946@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b10fbeb9-6ab8-4cc1-a786-9a62faa27946@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f701113-a730-412c-58fb-08dca5d7deec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzVYSmsxQXZTS1NWZUluREJoVEJCRGZkcmJMamhlNFBxOWhXOS84WXl3QmNU?=
 =?utf-8?B?cVVtU21FMTlnS0kySVZPZFVaUU1HemRUb0M5QjMyYjBmSmFGNE1BN1FXaWtm?=
 =?utf-8?B?U1FhbmJJVnhsWlN5NHpQS1VBNEpJMkVwcGozRzY2Zk1OZ0grZEVMNlRFVVdW?=
 =?utf-8?B?YVNyb1FDQUpZakJJUDVoTGFqeU11YWdITkUrdktQTTFDdXBPTTFSc0k1b2Nm?=
 =?utf-8?B?c0NFRU9qbGZOcGNMT0U2WUlzM05iTGN6QVRnaGg5NjZJUzhDSWVRaVVxVUtU?=
 =?utf-8?B?TXVHbXI2bEJxMk9QaG1tWjdMaHRGcXh3dnFwTGY5UmlscUlSYUlSK0FIdlUr?=
 =?utf-8?B?bWZHMEEwVWUzenBWejMrWUl5ZFd0M3VPN3FIQ0dRNjEyVURQME1iWFU2MVVJ?=
 =?utf-8?B?Qnd5UC9WS3U2YUJIclpWTmRpeWwycWpmbHpZOWE1UlRKcWhidjBzTzZQZUpF?=
 =?utf-8?B?b2RPT1dQQlJjWU5NK3N2VktaU2VxbGxYdVhac0VhQUUxZzlBZTVtL3V3RHdV?=
 =?utf-8?B?bVprdStSa3ZxWTdRbkI0K0ExRDdtYlBOSTRTdFN1Q3FYbFN4bldwZnNVUmc3?=
 =?utf-8?B?UEtWMngxNE51WnNMRzVpNDlYZmg4RkJaV2RWeGtlbDhwUW9vMmxsY2tyZlBt?=
 =?utf-8?B?eE5raU0zdTA0S0QvTGNYLzd6U2V3NVg5SU8xL21GM055WlJHMmJmaVZEQkdp?=
 =?utf-8?B?dktRMmxwbmwyajhSdGlDcU03QTUrSmNFRzhGWVArclNLTld6cmkxWmtPTnJW?=
 =?utf-8?B?ay82aElTM0pHT29nWEsrSXpjTnZqb2h0NkhBSHc1NVlqODQrSzB6bHpubkti?=
 =?utf-8?B?cVVPM01FQnRTZDAyZml4S1RiZWNSSnVJMk02a09TS1pWMlA3UHJxTWFOSGtP?=
 =?utf-8?B?c2pKeDRwOW1BMXl5Sjg3NVo0VzRTUTRvT3hEOWRKVzVmVE5nK3JYMU8yRytm?=
 =?utf-8?B?RTh4aTVreDNwVXdwdVlkalZOYVpPaUVJaERiY2ZpTFR1aDJZOWJ2RE1Gcm81?=
 =?utf-8?B?YWVkRk1tOW9PTDRYVHQ1WGtlUWJkM0wveHFNdnduZ24wTmd3MXp6NDQzckda?=
 =?utf-8?B?WGVIOFFtK0VBVEhVcGhvNmtiOEZ4QTNWYlZTVUpnbU1qM1ZCU0tuVUMycXlx?=
 =?utf-8?B?UjNyQWt3cmdKWGg3NGdQVlJCL1oyR3h6dXlLdjBKMlJTTjV2ZkFuTEJCTW85?=
 =?utf-8?B?dzV5Y1JoZDhnekJGekdZVTdVYnY0Q3dVRU1kOVdBUkI1N1k5YnkxajIrbU5B?=
 =?utf-8?B?dHhTWWlkb1Z5eHFUQllzenkzVWlYczZhRStJcDJtRmFIditDWEZXeHFEbnJl?=
 =?utf-8?B?c3h1ckpkWUM0MkhRSjYxeWxPYk9OaE9RY0pQK1hlMEplc1B0cExpVEJLeXF4?=
 =?utf-8?B?R2g0ZGZ3MUlLY0t2a1kxRDl6MXM3MXplaTV2akpnQ2tGaHI3QWRYWTRVejY5?=
 =?utf-8?B?Y1h2WUFIMEFkZGJ5TlFudllIdWxTQUxjMnVwVUNWaHI2MzRwOHVJaVd1ZVdl?=
 =?utf-8?B?VEUzeGtHVDdJN2pOa3N4S293TVFpQyszdEV5WDZoNmVvN1FLQ1VydFF6UGJB?=
 =?utf-8?B?cW9QNWlJVHBQNldGTXB2MHRVMnNQN3FDRjZBRjZ6YUVVM081SjhSWlVXa3ow?=
 =?utf-8?B?bE9zYmhqV3Mvc3VoRisxVldaSnl2eXRvZ1VSRlEyNTB2SWsyL0s4dzIrOE1Y?=
 =?utf-8?B?cXBvYmFGY3N6MVozNVFud3BmVi8yVmNBcmMrczdBQnlYZUJ0RnUzcHZ5Z3c2?=
 =?utf-8?B?NXlrZHZwc3FkakR1eC90dllycWViVUY1T2M4MFdsTC81VEpqbXZZQkE3SVJs?=
 =?utf-8?B?WnBGOFNyRFZzRFE4ZE1jQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1htK1Q2U1JtS1RlK1pQdmg5K3NEam1xLzdsVXZMZncxZmxUSDZRTmYrc3FU?=
 =?utf-8?B?OERJbzZTSjlZdXAzR3BpUC9ZaTN0ODF2UjVNVjJBckl5ZWhnSXJmaWdwcEV1?=
 =?utf-8?B?YWV6YUlEZ3IyM3M1QTVaMVF2VUVoUGtzVEtVMDZycGpLSFIydm5ocjNUNVE5?=
 =?utf-8?B?MEF1NTRUMWpLb3UzZXZEa1lnK0hoRjZ2VWxybm5wMHJ0bmpqTndXR05NYmxj?=
 =?utf-8?B?aWIwQ0NialY4WGpjNFliMlFibFZWbGlibUw2V3BWYWtrdUZkVFFyeTZjMG5T?=
 =?utf-8?B?Y203Vm0rdXRLKzA3Z1NiUzN6Qmova3lKaWxCSzY2UFQrMjQ0b3lrRmtpR1Z6?=
 =?utf-8?B?V0hSSUhCQzV2UDlQUlN4b2Zmemxpc1Y3TXQ0bS8yRS82THhqT3o4ZzVReE85?=
 =?utf-8?B?RFR2bE5yVjlRU1VkNVg5b2lvTzhHNFdNK3JidlA4ek9XSElIYVE2TitUOTUv?=
 =?utf-8?B?S1BUU1VXeDloWnhESnpadUNlNTZDeDBkVDFEanlwT1p0THJSeVYybDRVREND?=
 =?utf-8?B?UmpnR2VoWkdZRVE2MldHdzNwbVFTQ2JYeVJNKy9WR2JaZDg5SE1Ldng5SjB5?=
 =?utf-8?B?RkQ2V1RNSjZPUTcvNFFLNnVNWFlPbFg2bkU3ekQyWkdOLzg1Ym9CczB3dmtL?=
 =?utf-8?B?b0tneDV3NTNzd0tBMWhDaEV1MVVzdndlYzZyUVlDZEg1Ym4xMVozTnZZWW4w?=
 =?utf-8?B?cUQ0b1NJR3FnMTF0bW56Z29waURxL203V01RVU0rQVlvRnJTcXAwN2d6dS8x?=
 =?utf-8?B?bCsxenR4bEtuQzkyV0xSaEtNTWl6YmgvTWV2c2xtS0pIdDZLOEhOQVF6azBD?=
 =?utf-8?B?TTE0ZmFDYnRQRHZycjZxVGcvWFBmcTVTY1Zha2JNYzk4V0cxR2p2S2NkdFpL?=
 =?utf-8?B?RlRIVXdjdC9KNHp3NUszZk1mNEdRWmRsemxMZzBkTllWdlVqVDZjM1hFS2NT?=
 =?utf-8?B?eXZyRmpOcFkrV2lRRkFUcFU0cjdNSUxnYnA2cHRDQWdqNzZab1lvREk1UnR3?=
 =?utf-8?B?RVpBRW5VNHA5M1RleGVSRzdtcVNnU1J5RjZwRll1dGRzUFpndjdnNVAwaVRn?=
 =?utf-8?B?TnpVSnhObDRiOWVwZU1tRy9VaXUxWm1NN1F0ZVlkTzBGVHV3WE85aGdqTU9i?=
 =?utf-8?B?emlhV1c5MktIaXMwK3dmOEE4VDhuNGgrNnk2dmtsejZHcDhVdnhpTnZldnVO?=
 =?utf-8?B?NTJBaWxSRlhxVVV3WGpPNkxEdmFEN0xrTlo5OGdvMWZYQmVEa3hlenIwUFYy?=
 =?utf-8?B?MktjQ1lRSGd2STVQTDlNTGJWQW5zVnV4cFZsOFNyU3VVeW1GRmZrS0h1ckUv?=
 =?utf-8?B?U2YxUHRvZWwzN1I4Sms5dTdvNUVOcGxCK3Fxa0kzRVFSRDl4Z0QwL3VIeFVx?=
 =?utf-8?B?c0U2Z3ZzVEp2Z1BpM1N6TUZvNjRuL1ErTHNtNk5HbEtkWW5oTk42MzdZRUdC?=
 =?utf-8?B?d1RUd0twTS9YZ29Pa0c2L1ZSNHlXY1dmaDlQeGlSMzNhTmdEV3BWaGVaZTg3?=
 =?utf-8?B?blJmZ1RJT3BTNktKTklpa0dPWWk2bmhZY2pvT2N3V1Z1MmN2SnQ0NkJuMmNQ?=
 =?utf-8?B?THJ5N3daWk9semQ3OGd6MHZTczVTVVZZakFXbWJITlg4T2RRa21YNEJHQWhr?=
 =?utf-8?B?YW1kWmliQ0k5M3BJd3JrV0d2TXJOUVRDN3BCZTEzYmpaWENNL2gvSU5xK0NY?=
 =?utf-8?B?ZTJ6OEtyN2ZOQUwxS25jbkRSUXExajZjWTNFbExncThJZWo2eTZYQ3lSSlRR?=
 =?utf-8?B?aEpreTRLM2FpRXlMWXpNdWdDeGtKNWd2UnFKZ3BXM1dhOVJPNU9mckFhNFBl?=
 =?utf-8?B?K3F5bCtYTmdKejRrTzdSYTluQzlSZFlsNDkxaERDdTBuZ0ZmdjhRNDRteEx0?=
 =?utf-8?B?VU5pbjJnZHZObE9HZ1I3UUMwYnEzSDJJWDltcVJTYlRwT2Znb0tSWXNJbWsr?=
 =?utf-8?B?RkRqU0VIVlQzN3VqVGp3NXZCOHFPNEIzczFpZ05LSEZvcWJqWDhHVVUzUUts?=
 =?utf-8?B?THBNa3FrdlBlNWhIa0lROTFSdzJTTmVxTFA4K3E5dkxPNFo5Y0RzYlAvaENM?=
 =?utf-8?B?QmNOLzIvdUhKeGt6WHpuQ0tneXNza054L0ZPZldvcGNmQ2lXZXVvQVVEMFNC?=
 =?utf-8?B?Tzh2WkttTHdUdVROSWhwKzVmYjdMY3NSOGQ2cjNxRzFWdjN1QUsvdlhJaHNO?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f701113-a730-412c-58fb-08dca5d7deec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:42:55.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6GjijJE7nIqD6Xup4YhD+dMhO9yqFcq0QLhRNly+w29uxRvK+ZoL+keNoRTJx4FDYSg8D861FLhE9z1SkeMs8tkJtAo5Ktlxq3c1yF9OQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

Hi Babu,

On 7/16/24 12:21 PM, Moger, Babu wrote:
> On 7/12/24 17:08, Reinette Chatre wrote:
>> On 7/3/24 2:48 PM, Babu Moger wrote:

>>> @@ -662,6 +666,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool
>>> force_free);
>>>    void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>>    void __init resctrl_file_fflags_init(const char *config,
>>>                         unsigned long fflags);
>>> +void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
>>> +unsigned int mon_event_config_index_get(u32 evtid);
>>>    void rdt_staged_configs_clear(void);
>>>    bool closid_allocated(unsigned int closid);
>>>    int resctrl_find_cleanest_closid(void);
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 7a93a6d2b2de..b96b0a8bd7d3 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -1256,6 +1256,28 @@ int __init rdt_get_mon_l3_config(struct
>>> rdt_resource *r)
>>>        return 0;
>>>    }
>>>    +void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom)
>>
>> A function is expected to have a verb in its name and the verb here seems
>> to be
>> "config", which does not seem appropriate and creates confusion with
>> resctrl_arch_event_config_set(). How about resctrl_arch_mbm_evt_config_init()
>> with proper initializer of the config values to also cover case when
>> events are
>> not configurable (INVALID_CONFIG_VALUE introduced in next patch?) ?
> 
> Sorry. I am not clear on this comment. Can you please elaborate?

This comment has two parts.

First, there is the naming of the function.
The name of the function should reflect what the function does and I
believe that resctrl_arch_mbm_evt_config() is close enough to
resctrl_arch_event_config_set() to cause confusion while also lacking
an expected verb in the function name (since "config" should not be
considered a verb here) . I proposed resctrl_arch_mbm_evt_config_init()
as a new function name that has the "init" verb to indicate that this
function "init"ializes the MBM config values.

Second, there is the work done by the function.
In this implementation the function initializes
rdt_hw_mon_domain->mbm_total_cfg and rdt_hw_mon_domain->mbm_local_cfg
when the events are configurable. I proposed that as an initializer
the function can be expected to initialize rdt_hw_mon_domain->mbm_total_cfg
and rdt_hw_mon_domain->mbm_local_cfg whether the events are configurable
or not. In the latter case they can be initialized with INVALID_CONFIG_VALUE?

Reinette




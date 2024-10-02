Return-Path: <linux-kernel+bounces-348075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A275498E22F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A6128424F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B40212F09;
	Wed,  2 Oct 2024 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/FXaLgC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87920212F00;
	Wed,  2 Oct 2024 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893221; cv=fail; b=NhEQgjoVTdPNMCxMK+kmAAL6i/gBBPH1//L8oKlFUISGQ9onHN0Ig5ayYMfhq63bcxY763htkTKyO/WqbDomQPYp5iGHF3hRMZRBaVbIReYCVaM0LOVPCBpE8OzZ2ahgU0RvB9GnKVfCwzgvj8tuEWFKz+cBGQyOUZIITI+YIYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893221; c=relaxed/simple;
	bh=SgSjt237qcLROUAIeP5od1TegWI99l3WQs7apBIn51Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qe1PF96CUIXWtH6r6txPU66g6Fjm17iGMdhPZaM7C70QQgioAZc5eFAPtqVQ0BNyJx1k1Ola74rysiusDmmQndfMNMWq747M+DiHOBfYWSyECYAsx+Ya3Qh5MVhGDQB7E22DVPbn75FJ9cbNLz3RcoVkLH3GzaeCH5MJbJRocjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/FXaLgC; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727893220; x=1759429220;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SgSjt237qcLROUAIeP5od1TegWI99l3WQs7apBIn51Y=;
  b=e/FXaLgCOpRDCFT2tCAPM/1oNB+FozvwVA12vrSi+XjKYv6qPUfzg60P
   RfvQS6NICVe31Ken2Glk9T1SUCH+Bcy6rno1PP/ep4E2gGxQPpAEl7t/0
   p/xivEcd5KX56ChcuzzLHbjkycGVoHee8kMM3JvHriD1nzGLFDWohq2cP
   0VGHPi3n8wybrVCS6uCeo8DYVlRyEpjBcudKS9albRxkWycFKblEkxIJ6
   66EBoPJfzyvXQJTg7eIN8CsMyREjhQAE8P8xM1kZ42/Bs7NpKrInr8mWn
   6PJUuNrNA29nv1FYs6Hx2Qa0Fm56t0kU3Ue+so5+HI3K40ribSupdn3nN
   g==;
X-CSE-ConnectionGUID: 31yGNeLcR9W+wcDe6xvkIw==
X-CSE-MsgGUID: Au6DaRmtRJCyQhrVv7hepQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26956982"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="26956982"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 11:20:19 -0700
X-CSE-ConnectionGUID: +kTp3m29TOWosU3+5pZvNw==
X-CSE-MsgGUID: pk9dUFPQQnO+ZKay0pfc+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78618398"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 11:20:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 11:20:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 11:20:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 11:20:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 11:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFxTOcvs+EcUeGx9y662f4dL6Um7RsSGZIpt7Tpu4bdIDN3jrtmtz+Zki0nzrfrvJgAtOlUcWoRt0LwvBERyBPB91kuFb08VV1nN9Z8aj7E5Lz5kz222J9vxHju2cttzvaeLWB/UuOKur8FCexD6J2b3AJ9ghvjiYzgVJdJ4aSxnxwGkLJ+FNkyJEG4bBoYFeaVcywAwacxdkZhKpp+TW6b0pJvLSHZfFdIaHQxBWCzNWbkTmrgg/H9yYnFzYPz99C1Ii6Mfs19A6GBCTw4GB3N1mela79tTIvaFa27txx4bquo8DwXlPFEp38liIcywFlBi6niUT1Bpn4Myf6hlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hw1zSVr3wTtRw2oGjbp+73Wh9Lr/UB5YhBZVaA02thc=;
 b=AZi1Fh9WFA5yvPdkGyuWSwxUMdmO/untmngtq6wXkD9JO2rrkOajFor7qaRfnwlQDjir1oOqCIVVoC9uPKCmtasBv/O669fmHlu0i8LsD+MT8uOoEDqn6MwzQLiYZaE2SaPnKk30EWm+aPT4Aj+AyzLKz8/91dLzrfDqTATpsmzLW1fShY6XBALFV6Kn7tTYR8UUNtuL4KaTe0skcBGqUilMzCPy8qi9dZAVQKqjFy3P0To9w3l/4Z06tCwasjPGziTthKGDZ5yeHLaRiXaLXJ04CwgMPF61DQW5OuZbBXOOBtWd+vgWZgw08oQmB7LI1FszbsHzzSFoj55BTjmePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6576.namprd11.prod.outlook.com (2603:10b6:a03:478::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 18:20:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 18:20:07 +0000
Message-ID: <d2147cb6-9d1a-49af-9be8-5d788ce7ee7b@intel.com>
Date: Wed, 2 Oct 2024 11:20:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/24] x86/resctrl: Update assignments on event
 configuration changes
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
 <384c2074-0076-4686-bebd-ba3ac3c05188@intel.com>
 <f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ac30a5-b130-4c65-2419-08dce30ed7ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjRQaEFsL0c0U201RjZ5allqTWRQWGU3SEtjYXZUNU1MU3RYT040T2FUZTVD?=
 =?utf-8?B?dzgzYzVtdlhocnBiWDhiRjZ2UVZpTFZOZFlpMFBrQkVPbUlZcWZKK3FaUDJQ?=
 =?utf-8?B?VmpKaFpIUWFPNGxNek9xWE9na3ZzYWEyc2pYclQzdVY5U0JjZHc3T3ZiblND?=
 =?utf-8?B?UVpIZ1JvZmtWblNha3hXREc3V1p5ODFKRm10MUl0Q2VMUStlU0RhRmtwYUNR?=
 =?utf-8?B?OFdEaktsL0ErQzA0a29kM0dxeXRZenNCV0hwa0hYL2kweElvVStjdUNTc0NF?=
 =?utf-8?B?ZkRuTXBrOHZvTHZiWUw2TmxBUUQzcS9zQmw5UC9wbk12emVmaVNyZHY3aTA5?=
 =?utf-8?B?WUZQSEFScWJwc3h4cXFnTFJURkcvcFhsQUcyc1BxT29JS1gvWWM1OEJrQ21M?=
 =?utf-8?B?NGdUNE14bGIraGlkZXR5ZHVUMC9qc1k1UThwakF3ajhWRHV0V01LNnZSbTV3?=
 =?utf-8?B?SlYxTWUwT2oxYmpLMG9QQkpWRE9hY0dsdkJDeVVFRGlDRHQ1YUMybzhKYzRu?=
 =?utf-8?B?NmpObzRNTmZrN0JVMEFRaEI0OE1mMHlMRUlrM2J4S2N6endVWm1xQjYxdVkw?=
 =?utf-8?B?VTdRam5seG83YzF4cEgybXozWkl1enJHM1A2ZVFFS2I4cm90dXhac1cvMjFI?=
 =?utf-8?B?c2ZXR01tb2tGRzdGSllNNnlpUmJ6eWI1aDlRUkJ5RS9PUWZaWWw0V2VKZGM1?=
 =?utf-8?B?V2xscXA3V0pITTNVL0FnVUpvYmNlbHU4WGNhbFg5a2tlbzIxa1N2aHFLaUQ4?=
 =?utf-8?B?Q1FmQjV0WDlyaENGNG9VTHM1a1V0SXJpb01KUzJQeUNVamRDbkVzc1FkTnFq?=
 =?utf-8?B?Mk52czZYK2RaZnhpK2tpcU56RVQxbGJNRzRqdWthUDlJNm5nOEJveEJmQlJP?=
 =?utf-8?B?R0Rmb1ZpUEVyWnI4TUpCRlh2L0hXQXovd3RnQnFpaEJTekF2OXN1Nk9Fd0hw?=
 =?utf-8?B?ZForTU5HT0JDWlRkQkIyK250ZHdUTmxSc0dVZkxqaXRneHBSb2ZYZC92UWlh?=
 =?utf-8?B?ZVYwNGhtSGFXSUpycXlraDVXWjdVK3VWdHZmWkI0aHNaWThDd005eFc4bUVD?=
 =?utf-8?B?Nzd6NSswdFlHRGEyR0pOR0UyQ0pReUVpd1VkcEsvUWZFRzVtWUJMUUcwVTRR?=
 =?utf-8?B?Mkh4em02cVRYQWNoRW91UzAvQWtPU29ncHhEejd4RXdBODN5Y0ZjdyswRlhi?=
 =?utf-8?B?bFAwWGVtUXE3WXQ5R0RTdXhqLzZLVC9XY1ZGczhCR0svQTRoaGZpSFI3ZlRt?=
 =?utf-8?B?TDVFMGMyL0o5RDdyb1dSY0ZOMzRlU25BcmlBSlpGUHJaZ0ZlN1Znd0sxMzZ1?=
 =?utf-8?B?OFk1TTBwOEFWem1pRFZ2U3JuRlAyWEVqQkUwbXdEVCtsbnk1V0ZFME9sdmNH?=
 =?utf-8?B?a3ZCZnpOd2k1SzlSNUtTdDNYWVRvcDU2QWV3K3Axb2JjTEtsMkI0dW1XcVNh?=
 =?utf-8?B?eUovdzE4ZDV2cEdETFo2NTVlK09oam92dzg4enE0bGUybnE4WkNEcWlXb0k0?=
 =?utf-8?B?MkhrR2N6UkV5d3pLY1dxZXU1R0NoR0hWcWtvd1pxaWRnekdla1hJWFk0TUo4?=
 =?utf-8?B?VExQcWlOc2ZwOUR5WXA0bTB4d3BjSGxZN1FzMnplMGVwS0wvdEpCN1RZUVpF?=
 =?utf-8?B?bGJRcU9nTlZsL2o1ZEFQRUcvdnZFVEtGVmxxcmh5RENoYU9oRFdBQ3AwR2xr?=
 =?utf-8?B?V0FyRzdXeStLcEg3T3VrRUJmSHRsckwwTnhwdG5icUZtZ1pQdHpidE5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZENVMDVPZ1NYY0NXSjVwcEZoS3dCMzV5RlRoWXUrbU5TYXJaSVNSRC8rWWR2?=
 =?utf-8?B?ZWpCdC95c0YzeEpOZ0c3TDI5VGlFZ3ZBcVQzeVB6amI2V013VVVXZHEwZDRN?=
 =?utf-8?B?SXlEUlFPTm0zUzZndkMyM3FLanpHSnUzSDMwR3dvYlZveklNeUo5b0NmcHhw?=
 =?utf-8?B?TEpySkFCV3k2SkJIWDZXQy9iUVlKcHhyTi96OVJ6aVVYR0toeGF0dE9TcjdM?=
 =?utf-8?B?ekhMRGNQTGRpaXJENkh4U0N3YUx3bEx3TFloRlpDempoSGZab2tlNXNIQTNH?=
 =?utf-8?B?UHJLT1NCbEJWWkhuSlF3ZnpVcVdDR1N4RVB6Sm5oZVRCQnhTbW5GUW1YUnVH?=
 =?utf-8?B?eE9hVHlWbmZhSmMwZzh1cjkwWitnbnhjcDZZYmh0d3B5aFZ6UkZocWpwS3E4?=
 =?utf-8?B?Q1dDWjFqVDZUMDNDeXpjVDhtZm5ULzlqNGNwV213OHE1MG4wd1ZEK1pabVA0?=
 =?utf-8?B?WUR1NzFNeU9ndVNmMlNrMjUvWFJleVpLOUNaanpGL25Nak1UNHIxcnVkZS9B?=
 =?utf-8?B?Wm45VnVzUkpBTHMzejZBQW1rZ0xVTHhJa1IrL2d2SnExS0JtMGtGOWJNajVu?=
 =?utf-8?B?NEFXZFFFbFYydlpZRFYvdFl6dnZ6RlNIOTk0MWxpQVN5aldzZkNBOUxZNllx?=
 =?utf-8?B?ZzNBWHROdExkb2R5ZDhTYmVGRTY3QkJXbUI1dFNkL1BCZlNSaEtSZXR1RHJz?=
 =?utf-8?B?d2V1KytqcnBCcSsrK3pTaUhSL0ZFN3daeS80S2pBMTZZWk9xNTl5UUNtRXBs?=
 =?utf-8?B?czhENmdjdkQ0K3FwdVVlUGxMYUJ0SlpCRGl6WHRubWdUYS9zRFMvRXRCdU9m?=
 =?utf-8?B?U0pkalJYcDY4Y0UvaUxnVWhLSHlzUWYwdVYrSGFpdFI1ZlAvVUV0WUN6Wkkw?=
 =?utf-8?B?SzFTRHYyZko1dmlJZVZ5eVRveE53M1Y5bEV6cDlmSnFtMlU5enQ0TGxyenY3?=
 =?utf-8?B?aWpuSGF4OGx1TU1aOTVwcnU0d1BGZ2U1b1REYjRnTmpkcjNSMVVyTnhHcVQr?=
 =?utf-8?B?Snd3QWFIOHFKemNMSUlvQ2ZQM2pZenEwUGNBRDBmUnprL3NrOVZranV3bk9K?=
 =?utf-8?B?M2FhbmFoOEdTZ0JidzFvTVM4cVh0ejNoVlhzdXVuR1RIV1hqK0dmUEgyMkJQ?=
 =?utf-8?B?MEliNXZUV00vWDBDOEtlOWU3cHhEckF5UklNa0srYXVIYVpMLzdTQmYwdGhU?=
 =?utf-8?B?K1hhTDJ2VU9OMlZlaUdFZXErM0lCa20zWlZtenpGYk9MWUpHeDZIWWkyejhz?=
 =?utf-8?B?TWx2OEFsRXFqK2VKRXJDeEVBaXMxcTFvRGk4RDlzWXl5blFMWC9lcnRtTi9Z?=
 =?utf-8?B?U1ZMajk3VWQwNW5ZaittL3RPTXp2dUJ5VHQ5NGlhWkdPRUhaU3dFTjNGZXJ0?=
 =?utf-8?B?MHJqd1FkTXcyblZRV2t4cmhDWE9rcG9ZWElyNFdnYzlDR1p1NXBmNDlBNE9u?=
 =?utf-8?B?Q0V5SjYzTjdxTWFFOHk3a1dTOTR3NTZOa1doaEE1QnhVb0RrS2huMU92R2xm?=
 =?utf-8?B?UmFEUWVYcmJ0Yk9jcUdWdElPdXM0Qyt2MkxwaXE3SjQ2Z1krNTFWNzFIUGhN?=
 =?utf-8?B?bEt0Nk9wTitKSGJvZ0VqV2lOcHRXMUNUKzQvYnVMQmJoekhNSEI5Q21VTW53?=
 =?utf-8?B?dDF4cUJ0SFN6eVNzeWxKZXBRVU43U0tYYjV0Z29YQUpXcGVFR3FGdUI1QVhY?=
 =?utf-8?B?VGdDc0xhRlFhREVyNEtQNStUVVVaRFd0V2RpemkvUEdLZlhMMzNmaVIzaFhV?=
 =?utf-8?B?dW1kMUtqYUhENnJBTytwRTN3RGVjWTJFUmVHR2hzSkpXZFF3TkQ4THN1WGpX?=
 =?utf-8?B?V0dRSXdqQ0xyZm5VTysyUmJaNzk5UGJwV0JJSlR5NU1URnVZd2E4K1FzcE1F?=
 =?utf-8?B?aFhUL05TZXdxLzNhbHZ0VGNRZzVlUWVlTDhEZEZFMHQ5OUF4OGpRYUJOSU1n?=
 =?utf-8?B?NUp6NnBLd2Z3SWlDYytyczNwanF5V3dtZGd3R29tQzZ4aGJydHViN2pDQ0hM?=
 =?utf-8?B?NEJqMDZOQUVCYlJqdXRBQkw1MkdseGl0R2kxYktMYTVyVGR6WmRuNzZQOHkv?=
 =?utf-8?B?QnpoL3JkaXpLUG9ZSkpmMWZOVGxidDRSbHV3alU4TWRYM1oxZXZIYjhIMEYy?=
 =?utf-8?B?Rlk3MkFScWNJNWF1M3VGb0FjNnk5cjRvTlo5ZDhxYXNhU3lMRUZSa2RTUlZn?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ac30a5-b130-4c65-2419-08dce30ed7ee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 18:20:07.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqQ+xalE7gyW7fg1lxf3pKdRd1YnEVAgnn0paAJIudg624qVKFSIkN5beYzexz72Fz51xdncY2qJLkiXFc2VD1alzmSGoWF4GvEYd5Gyet4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6576
X-OriginatorOrg: intel.com

Hi Babu,

On 9/27/24 9:22 AM, Moger, Babu wrote:
> Hi Reinitte,
> 
> On 9/19/2024 12:45 PM, Reinette Chatre wrote:
>> On 9/4/24 3:21 PM, Babu Moger wrote:

...

>>> +}
>>> +
>>>   static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>>                        struct seq_file *s, void *v)
>>>   {
>>> @@ -1793,12 +1802,48 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>>>       return 0;
>>>   }
>>>   +static int resctrl_mbm_event_update_assign(struct rdt_resource *r,
>>> +                       struct rdt_mon_domain *d, u32 evtid)
>>> +{
>>> +    struct rdt_mon_domain *dom;
>>> +    struct rdtgroup *rdtg;
>>> +    int ret = 0;
>>> +
>>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>> +        return ret;
>>> +
>>> +    list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>>> +        struct rdtgroup *crg;
>>> +
>>> +        list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>> +            if (d == dom && resctrl_mbm_event_assigned(rdtg, dom, evtid)) {
>>> +                ret = rdtgroup_assign_cntr(r, rdtg, dom, evtid);
>>> +                if (ret)
>>> +                    goto out_done;
>>> +            }
>>> +        }
>>> +
>>> +        list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, mon.crdtgrp_list) {
>>> +            list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>> +                if (d == dom && resctrl_mbm_event_assigned(crg, dom, evtid)) {
>>> +                    ret = rdtgroup_assign_cntr(r, crg, dom, evtid);
>>> +                    if (ret)
>>> +                        goto out_done;
>>> +                }
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +out_done:
>>> +    return ret;
>>> +}
>>>     static void mbm_config_write_domain(struct rdt_resource *r,
>>>                       struct rdt_mon_domain *d, u32 evtid, u32 val)
>>>   {
>>>       struct mon_config_info mon_info = {0};
>>>       u32 config_val;
>>> +    int ret;
>>>         /*
>>>        * Check the current config value first. If both are the same then
>>> @@ -1822,6 +1867,14 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>>>                     resctrl_arch_event_config_set,
>>>                     &mon_info, 1);
>>>   +    /*
>>> +     * Counter assignments needs to be updated to match the event
>>> +     * configuration.
>>> +     */
>>> +    ret = resctrl_mbm_event_update_assign(r, d, evtid);
>>> +    if (ret)
>>> +        rdt_last_cmd_puts("Assign failed, event will be Unavailable\n");
>>> +
>>
>> This does not look right. This function _just_ returned from an IPI on appropriate CPU and then
>> starts flow to do _another_ IPI to run code that could have just been run during previous IPI.
>> The whole flow to call rdgroup_assign_cntr() also seems like an obfuscated way to call resctrl_arch_assign_cntr()
>> to just reconfigure the counter (not actually assign it).
>> Could it perhaps call some resctrl fs code via single IPI that in turn calls the appropriate arch code to set the new
>> mon event config and re-configures the counter?
>>
> 
> I think we can simplify this. We dont have to go thru all the rdtgroups to figure out if the counter is assigned or not.
> 
> I can move the code inside mon_config_write() after the call mbm_config_write_domain().

mbm_config_write_domain() already does an IPI so if I understand correctly this will still
result in a second IPI that seems unnecessary to me. Why can the reconfigure not be done
with a single IPI?

> 
> Using the domain bitmap we can figure out which of the counters are assigned in the domain. I can use the hardware help to update the assignment for each counter.  This has to be done via IPI.
> Something like this.
> 
> static void rdtgroup_abmc_dom_cfg(void *info)
> {
>     union l3_qos_abmc_cfg *abmc_cfg = info;
>         u32 val = abmc_cfg->bw_type;
> 
>         /* Get the counter configuration */
>     wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>     rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
> 

This is not clear to me. I expected MSR_IA32_L3_QOS_ABMC_DSC
to return the bw_type that was just written to 
MSR_IA32_L3_QOS_ABMC_CFG. 

It is also not clear to me how these registers can be
used without a valid counter ID. I seem to miss
the context of this call.

>         /* update the counter configuration */
>         if (abmc_cfg->bw_type != val) {
>             abmc_cfg->bw_type = val;
>             abmc_cfg.split.cfg_en = 1;
>             wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>         }
> }
> 
> 

Reinette


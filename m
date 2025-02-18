Return-Path: <linux-kernel+bounces-520008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C1EA3A4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CA9188A64A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6D270EAD;
	Tue, 18 Feb 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9nEr49P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CB26A089;
	Tue, 18 Feb 2025 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901043; cv=fail; b=ry2krY5Sa3fRigrqdBw/phu2qMJU2XbAtbwJ5JIOtm78oK5u1ISKKKlSdHCyzZG4ReJBzkMG3rU8JWAKHMIhudWEYwxfhn1E5t2O33wc8ZQ6iV2PTBWoQukTtJsE4Aumb3yEkiiT7qdY6qkZGAscwTHLjcn1gIH74U0vwrCZnN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901043; c=relaxed/simple;
	bh=VfAprtVOMR4swkZ6BDsHNWRs9UN1YzNFphLT65cInaE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JMq0w34+Hjf8WhtJiDpblrofTauMhgzGUMpMwHquAofxxEZzZ1Ub7CUd5rPZwj5w5TrY3fKvaRfTrpmxty7XPzWvE1bATLax7uIQnPCfgDLencfI6VAagxtyVuMT6OoguoQK7aiHZz+6bg8F/WcWH1ZHotLKEKLMG+15A7RAXKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9nEr49P; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739901041; x=1771437041;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VfAprtVOMR4swkZ6BDsHNWRs9UN1YzNFphLT65cInaE=;
  b=Y9nEr49PNcetphBkiNRqYyR7G48ASCiUUziZSlQZtC7j6yegzL+45A3w
   Z2clqmM5KflYBzbaTameJGHAuku7Trtm2Q1Fa8nBFYC07n2hpZxD0IzMh
   Ooz2kM44obBxrVNsOy0DzlFSSBGzQ/J9kPcdx9XAe3UlTxSHoUrN9GMUE
   +8uZoj3iIL/s4FJi+11vgFlgedDajyHe/e6UDuI1fRplVeBVeQhj4iMJv
   R3vC4dZ5LPuZ3CqaOeHHBCNKJSp++ie664tBqi1Vlpbx4PbPuWmgi2TG8
   7rxP4ZAyDedWt8DWd1mOYXbhejDlxvo/Sj0ncM4qIwZLm861tDC02zYMJ
   A==;
X-CSE-ConnectionGUID: FwDO1bzMQdajjC2SrIl9qQ==
X-CSE-MsgGUID: wQfQ9NPCSBKdyimyRuEwxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="52020021"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="52020021"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 09:49:58 -0800
X-CSE-ConnectionGUID: yR/syoitQPKIKLrvZ48KNA==
X-CSE-MsgGUID: SxQ6MTw5RdKYiobjQL68lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137699736"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 09:49:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 09:49:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 09:49:56 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 09:49:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyzlAs9Qehwthofu1fofpYzHsg1ElAiFvqJivkpo4lW7b5HW4CRDYdmLKbPJSs/evMcJW4wXSuE8J39zJzYCy8P9PgfFBvS9joZjL/ZQEMbPfkCr7RYhj3XGilLVL+uyEHNDsGrelMbTjnRu1banhjDNW6lPR9fQ9xExqoBomb6QDX/mvfT0fsYy+wJ4cQJx0gGxAiq+/Z9wKc/pAHGouKrU9bF8UtQKx8j0+DVigXFiSt2Uhh5dO39c8RGem9w21/BiefYnpnRj0+BSH3+sbsbO/XNp0oQD+MRSH2P6l0a8D443Kw1Pe2uCXeezUK5AAdVHv2epeUe6tNtw3nBc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D505h4x/9x2ukQ3FE7B+xIUpKsIqJnim7CHdg29Ow5I=;
 b=BNfsvB10O8WgTSFhdBt4MnhpyJgKym7vCBdDqHySoD6zaUvKJzA7yrNsKhHJV1G4hZIhgbbguAvZk9gs7n+FvNKJDB+KzpsnBqEhZGsM8W7gmp/IclZg32T52PV39QGvYRlUBOIpumCkXjJ9yK5JxfZ+tO0BPTduzIfRP9gIHeqM4JgNyqGV1BK88uiIau+Ikotih6Nu6gOHl77BCeW+GTVBIPsS+8KfMwJ4ZwPgHJDiV5RwgGj4NlEuqJ4ftOoxjy3LRHVs6a7LqqDN/F41vUtnu/9pgS5MNz3BMI+K5DrVsSsd9FFnIQcP+cL2U43L0EJ07zKE006hC/lsS0Zf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 17:49:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8445.015; Tue, 18 Feb 2025
 17:49:21 +0000
Message-ID: <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
Date: Tue, 18 Feb 2025 09:49:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
CC: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>, "Babu
 Moger" <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 0872661b-1811-4171-7f77-08dd504492d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVFvVzRpb2VqZm94UFJqRVhHQU10emt3UEZLOFBIUXJjS29KRVkrSm5UYnZT?=
 =?utf-8?B?enBNN250TXpLazBidWp0dE5OdjRrNkNueWZIdkY5b1plM1p4R2d4S3UzaTl5?=
 =?utf-8?B?d2xuem9KRSt5aXl2S29CR2FOZGl3TksvUUFFK1JKcHV1d09YbFQyaEpzc29w?=
 =?utf-8?B?bWJmVUovcjBsN0xVVzM5RE02bEN1czVrVFVValFwMjN1RzhXcFNqWXBRcHp2?=
 =?utf-8?B?RjhCZVF5YXNMZ0N0MVlyc3llZFdSbUZmY0hYZVI3TWhLWTB2NDU2aDNVVTN3?=
 =?utf-8?B?Wi92UmxLV0Y1TnpHT083WkdROFQwV0ZaZ2N0QXg0MXJrVlVKcVFDdzMrVmdF?=
 =?utf-8?B?Unc3VlF2OFllYVBGS1Fkdmc1NnFmRzczK1VXN2tEQWRWaWt2Sld0Qmhib3hH?=
 =?utf-8?B?aEJFNnJlK3I2TVhja1BUZ1lFa0YyZTZFdHpIQXpNQmRtOFptZ1Fjcnp1UEoy?=
 =?utf-8?B?dnRxWGROMUd0MDRyS05oVXVIU0l3QVcyRW5LaUYvRWJTVG96Si9mWEhlOFFv?=
 =?utf-8?B?TFVrRHhtZkNQODNIeXJGNlhFelNKUzd0RlYrVGVwRFVjTFBUZGxWdFRJbDZN?=
 =?utf-8?B?M0kvbUZDL1RjdHkvQU5FcHY1bmFockRnTStmOGd0OGRDRVd5M2E5SkhXSFBF?=
 =?utf-8?B?Wm5KTGFWd2pWd1N3dnZVSDk1c0VCNUNtd0YveG1jZ3RrK25WNm5ybktIYmQ4?=
 =?utf-8?B?UmtRTUE5S0ZneEhnSGw2THJYQ1NpOWJpaGt4VmJON2tCS3hRUjQ1cnNnN09P?=
 =?utf-8?B?UlZ1Q0RneG1HamlkbCtBWUhzOXkyR0dtejRxSStXRmRZUEJqaEdrZ1JYSnpO?=
 =?utf-8?B?QjhmNUM1Z1BVZi9tNENadDk3VlhXbTQrT3FrWURHVjhtdVF0RlhrZ1lFM0t5?=
 =?utf-8?B?QllqanpZWkcrOUhBSmV3RERHK1dPV0RPYWhTQzBnSzd0aVY1SXAyekhDdWNo?=
 =?utf-8?B?K2FhMkNoa2JIeUtkSkoyd2NHNU04b01iMC93dGg0K1IxSi9BNm9GNjl0UmVs?=
 =?utf-8?B?dHF4T29nSEJ0QXozTXZZTE8yRk5MNGQyY1Bna3FSSW9DcVlHVTc5VnQ0eno0?=
 =?utf-8?B?czg4cGI2TmZOUzlIL1lRWkhvUE05MjZVRjFXOFNDNVIwSzJlVS9ac0Z2ckFx?=
 =?utf-8?B?Rms3Q2t6UUFYYUY2K3dGNjBNL1BuRnJaSVlLd0VwSzlUK0NLOHVDa2ZWcUNF?=
 =?utf-8?B?Tnh4YTFtalYrN0J5bzI3M3NPZ2ZxRXVpYkRudkNaa3QyS1VqdGZEQWw3ZDF3?=
 =?utf-8?B?bXNRa2tIU1R1blpDVzluVW1FcERacUpZSld1dHZDVENRZ3BTdDIwcmtRVmRL?=
 =?utf-8?B?YzY5Z3hGc2FCNDljTlVyeWt3RThocXo5L3JxZVhXQkFOOUVmS01SaCswZ2NJ?=
 =?utf-8?B?eHpVdkpvNkVwMXd4OGQrcUtyVVhrVVZOaUtpTk5uWjlTdWRTOHFUdVBYWmpZ?=
 =?utf-8?B?alJObFFWdTdKVS9oMVMybkFPRUJzcFQ0T1ArUzAzckFYWXJ2VXBRVGJJQkJK?=
 =?utf-8?B?Ulo5V1VBWS9OZ29VeW9CekdsRjd1a1N6bzdEczRiaS81RXdPMzA5cEUwMjFU?=
 =?utf-8?B?ZHNLd05BY2ErUlZzK0xlUTYwQUk1eHZoNnliNm8xb0ovOXZnMjdGWi9pL2NB?=
 =?utf-8?B?Z1orM1M5TTBTQkNUQXB4VDZaWDJRKzgrQSt4dktqUFJPNGptVlBwNlYrY3Fa?=
 =?utf-8?B?ZFl0d1NsaUt0SGU4Wk1lUTQzWkg3REFZd1hmTnBWTlFGZkljbzJyUkN2ckoy?=
 =?utf-8?B?MGMzcW83RlN1aWN6dnJDUlFsNzRSMVpFcTNzdXRvdzZkdlcxSXJzc3BFa0lJ?=
 =?utf-8?B?UW9oQ1MxcUUwVXQ2QWxVQmh0RU1JdXlnSHNzVkFzNDVSTHp2NGEzZ3huREVu?=
 =?utf-8?Q?ciqP+qUhAi2JX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2hkSTVsSWpVMk9RMXhMc3ByZjlVQy9COHB1N3dtblJxVXdadDFEWHBEUytV?=
 =?utf-8?B?TWF4cEJIYUcra2kzMkVRNENaa3MwZmpWQkFoZXd2MmNHclAwMVRmSW5DL3lF?=
 =?utf-8?B?WXpidXNJSCtQSTNuT0k2SmY4cXl6UlZlT2dySVp1Tis4Zk13dXlYa3RvWnFQ?=
 =?utf-8?B?YjhOVWxGN2hjNTJJeFNLd2wyRWwxdFV1ZzUvTmpjY0p0OXNwVFM4d1crdGh1?=
 =?utf-8?B?L3RHZlBmbkgzMm1MMFJkV0pSc24zeGlVTXlDYUV0dllZWnZFSWxIL0ppdk80?=
 =?utf-8?B?VXVxeXFQS0s4bVVtbXI5SnpXd3BSYnVITWViWkVOZHp2S3U0ZXZMbXpKRmxo?=
 =?utf-8?B?amczMFFZOTZUbURneWl2U1BjZU5FSGJvWHF0cHo4SHhGUE5CWm9DY3VjSEg0?=
 =?utf-8?B?a3RKeFh6K0p2b1JGbFBnTHZzN3VSR1UzUjlsZWdyblV3Q1hWRVl2NGVDVzB4?=
 =?utf-8?B?cFh2MFQ4cXNwTWVIKzZ1WTBXcmNualdlSDU2RE50QWZ2Wm1PTkZaVnExbS9W?=
 =?utf-8?B?VTlRc052a2haWGZLRnl3WDVpdEJDL1A2b2FtTzlra01VZnIwTi9sSGMrdGFm?=
 =?utf-8?B?SkJaelFnM0NOWVY5cTFsaGlmR0hJSnB6alBBaUlIQnBlME1JbTRVekJiUDRQ?=
 =?utf-8?B?cHIvV0d3MnhIWjVCOEwraklkOHNhWXF2TWk2TjJJbWVlcFBuWlkrRHlDcjdF?=
 =?utf-8?B?SmMzUElBSlZrSXAzamZJeEFrOS9sMUhVVERJOE5FN1R4REQ3U0Ftc1didjJX?=
 =?utf-8?B?SlBjNE9OczFIRTN4OUN1bW90SEFCVTcrL0dkQzNFMU5tRmk1SDQ1dDlGK2Nh?=
 =?utf-8?B?bVFWMFc0RFlWSTBjUVBkdmhTM2syeUxxbUpnMWZjT3lKSCtjVmVZam1sK1hS?=
 =?utf-8?B?bFZRZU5EQUFkUjVQWjVWckdHYURjeWpjVXlLU3Z5Q2czeVNiK0ZGMHVvZWdH?=
 =?utf-8?B?TlIzamtMM2VqWE5JcThIUnpkQzZ2azc1ZFRLUkkxejN4ZlU3cXhEMnppT0Zx?=
 =?utf-8?B?QklDOXpmZEowWGlSc1NrVGJ0MXBHNnRuSEptVlRHdERkUTBTSmZDNVllMllh?=
 =?utf-8?B?SGRKTGtoRDNNRUpObjRyY0F0NU8vYXdMZ0o0Nk1EK05jRmdFWGtHdHgzMS9Q?=
 =?utf-8?B?QklmeVM2SWI1ZHNodU9JNU1LQUUyU3I0SW4zQkd4dEV2dTd5ZGNYWmdwN0Vp?=
 =?utf-8?B?MU5XcmN3RXFFRisxc3JTV3J5VklkWXl6a2dxVHFaSzg3M2FrYjQwcEtxUU1v?=
 =?utf-8?B?ZlRwUHgySER5RnU3T0JYbFdNcVUySkc5bU9lSWNoSlJQQm1VVTFqVlc5eTgy?=
 =?utf-8?B?UkM0TkhZMW1neGlMdy93L3IraVBIWEE5NWJ1SWMxYXd5UmRBakY0TVl6UDd5?=
 =?utf-8?B?Sjk2YldyT0p5dXdrblFkMVh2RXFsU2lyRVBnVWR0bG5oOVdQcjVXR0d3eWxx?=
 =?utf-8?B?a3BJWCt0VU9QdThCd2FUSEVhdUlXK3crWFVIV3pQUkcxMkpIQXVuSVJoZVJj?=
 =?utf-8?B?aGtNQ3hBeEhMOWZ4dEMyUnR2VkVrQkQ1aGF5c3lTQWFTaUpQUUZtRkxpMWQw?=
 =?utf-8?B?RVRrcDRnMTdBdmd5QjdJaXprbEptdkZFRk5PQ1JPUXc1SW5qU2xUV1F5WTZh?=
 =?utf-8?B?SW5La0s1emp0UnVjK203cGlzaXdiN0JFL0pZSVIwcC9valRpUzNHUWlVMk1x?=
 =?utf-8?B?WklBejVQRllzcTBhNkhpaVIwNCszbjRHRUhsWVZBeW1qeUQ2Ui9EU0FNaTVE?=
 =?utf-8?B?eUhjY3BqSmdHK2IrWmhtc0E2cTEraDVYYnQyY0pFaFVvQ0drb2hZZzlyZjNW?=
 =?utf-8?B?cDlaUndPekxKTnZnWTVwL0htcmNVYzVaQy8zMFRZZ0k5cEFKS1VETjBnZDBj?=
 =?utf-8?B?dnhwblBvaEJ3UE1nWElGcTVDenB0MXNjUkR3VGVBWWFOQWZhVFIxb2VBRjVE?=
 =?utf-8?B?TUZmNVJDaGdaalVMaEhTSWdTVjVNNE5FUnI5eDd5Y1Z2NmxaNHBaSkx3M0pF?=
 =?utf-8?B?L0FzSU94NnlKNDcvc1lCVmZySG02OXAzTVpBdW8ycVBCdFlHN1o3M0ZkK09i?=
 =?utf-8?B?MkhONE9RcDAya0pzVEhQUWNnSUl2R2dML0t5U3ZqK1craE4vZTRraGtLWHpE?=
 =?utf-8?B?OTBSTStDdXFUNnZjN2N4bXUxL25iajVFektXU1pXdUdMSStVZ2Q4L2xMRXFh?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0872661b-1811-4171-7f77-08dd504492d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:49:21.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+sFUTL4jzlgKABZyi2NlB5qNfcRRPw1v8FbrZdtIWMWrM/XUFiSIxwq3ldLqhGI6RwkMRMAVRRyL5HUfczFMT6AwHfTn0Ndr4qIYwiDAdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6462
X-OriginatorOrg: intel.com

Hi Peter,

On 2/17/25 2:26 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Babu,
>>
>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>
>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>
>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>> Please help me understand if you see it differently.
>>>>>>
>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>
>>>>>> mbm_local_read_bytes a
>>>>>> mbm_local_write_bytes b
>>>>>>
>>>>>> Then mbm_assign_control can be used as:
>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>> <value>
>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>
>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>
>> As mentioned above, one possible issue with existing interface is that
>> it is limited to 26 events (assuming only lower case letters are used). The limit
>> is low enough to be of concern.
> 
> The events which can be monitored by a single counter on ABMC and MPAM
> so far are combinable, so 26 counters per group today means it limits
> breaking down MBM traffic for each group 26 ways. If a user complained
> that a 26-way breakdown of a group's MBM traffic was limiting their
> investigation, I would question whether they know what they're looking
> for.

The key here is "so far" as well as the focus on MBM only. 

It is impossible for me to predict what we will see in a couple of years
from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
to support their users. Just looking at the Intel RDT spec the event register
has space for 32 events for each "CPU agent" resource. That does not take into
account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
that he is working on patches [1] that will add new events and shared the idea
that we may be trending to support "perf" like events associated with RMID. I
expect AMD PQoS and Arm MPAM to provide related enhancements to support their
customers.
This all makes me think that resctrl should be ready to support more events than 26.

My goal is for resctrl to have a user interface that can as much as possible
be ready for whatever may be required from it years down the line. Of course,
I may be wrong and resctrl would never need to support more than 26 events per
resource (*). The risk is that resctrl *may* need to support more than 26 events
and how could resctrl support that?

What is the risk of supporting more than 26 events? As I highlighted earlier
the interface I used as demonstration may become unwieldy to parse on a system
with many domains that supports many events. This is a concern for me. Any suggestions
will be appreciated, especially from you since I know that you are very familiar with
issues related to large scale use of resctrl interfaces.

Reinette

[1] https://lore.kernel.org/lkml/SJ1PR11MB6083759CCE59FF2FE931471EFCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com/

(*) There is also the scenario where combined between resources there may be
more than 26 events supported that will require the same one letter flag to be
used for different events of different resources. This may potentially be
confusing.


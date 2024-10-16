Return-Path: <linux-kernel+bounces-367147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A25B99FF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA8B283221
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502B616EC0E;
	Wed, 16 Oct 2024 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmOTW5zj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2514D6EF;
	Wed, 16 Oct 2024 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048022; cv=fail; b=exoGpXLxHcB9JtL+JcBmkKDykWylBmr6a6ngnHG94R5wo0DTqC0PSD8mFdvcO1Ax7LtUo8kaS2kk8m5VqTNinK2TuJmrsXZCGHdadju15AulC/om6ZxC3EtidXANV6GlAn8TcKwL8zUy/diiaU/72MWk9K8UbZ7YdbAlXqSP4xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048022; c=relaxed/simple;
	bh=CGEPKukOccO6FMOAEWCmkyCUBa0hUYiLRhkxljTJkWA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LujAPsdnz6q23fUQrto3uvfHEp4ycQXk3Tzl/8hwrFft4NmQPsd1768Z6YIb4a+WkFrkC7RhpX6K/iLQk1/KpPaAPn0xs2xmA9pZa70mP/OcZm1s7D5HCwYm9YPR76vSMO7U8GRIKyucrZEp69TmBxe/Vhrb8gfjVX7F1HeRuCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmOTW5zj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048021; x=1760584021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CGEPKukOccO6FMOAEWCmkyCUBa0hUYiLRhkxljTJkWA=;
  b=EmOTW5zjP1gH8pe9xyhnU1MTLO9Y29A8WLaMvzebIRavZnXZOMmP9cP7
   vxC3UxmxsZ7u6SMMSP1Tpbmkf4pJc2+sXy5zPs7z/nPpHegP9lhEeIyXX
   T+ZkE7pV3sEgqEn5miEZEyP7lsOVkOI1BcP6j4qOvmMMhLCZ6PUripzMY
   kXTv3VS+JgE8C60CM22nWw4V681hF8rErWLAm27z0SpQfrttEa5KkOdT5
   959ZNKAdediZUp02rF8vD+SiAP9udjFJnkbYZGGb/re6n4Nt7OIroLNo2
   SqUdDf2NwI89e4YATz7myGOlI3Lwg1qG/lKoaZFF95ysSm63YXfuuXxmn
   A==;
X-CSE-ConnectionGUID: +bZcPb/cS6SZf4n+ZAnJDw==
X-CSE-MsgGUID: x8y/IMCoTW+E0kg4eiCL4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45954187"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45954187"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:07:01 -0700
X-CSE-ConnectionGUID: bC85cZziQTq6PZntNKKK7g==
X-CSE-MsgGUID: Sp7oEM9bQ8GeAGmjkAuOLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77980025"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:07:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:06:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:06:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:06:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GytHfTnNolKEes21pnCdwLn1V1t4YQbl8Ufj6vWM0Io5hu7/DuMdCmnnXWcuBnKUQ9pvUxpPGdCAsd1NcBrcmQKRfpv4LZ8tmA5NoKu2m7a9fGfIUwN2392rkPUF0mTHPJSFmHtfkc/mhFKCSurGQNJCKeSdLT5H+DqhS7i9GyYau422uguDrzct1imQAEQSfsuiZoP6igfqQKqTJMezqW27HT7eNfco4xaYWSfLgFO8fJTaa5mFNb9w6KEJSLFZgPdJNzLi/NYdqCdK+st/C+5JypefzaQX1tjSO8I24BvKa8N5wtBlBRpjofpXy7M3aADq7pI6L956VjFZgu6iTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoU9/zsYJt/q6ngZQJ3deZHCNj3XVEI8Oh7eYhDCZ+8=;
 b=HFHedgtASzc3CNulfIDI2WK4eGsUWE1CiQ7aAwEgK49qmqTuvrPfi7MwJujR57lNpXqB5ZTIkyTTVa+12dVSB19NuCktoHl9uznVeltyERmMrHQqgCiR7/fqQTTRf5/K2DHwpIQZ6LJ4Kf3ncgb7FmnmGk6sOwKimAhNRWA2bWMf+gNTBiojB33SLwKChdozJwyOwh2fKbuLs9Nc5bLyZrKRzOuYHCZm9bESZi1WyGs9d5ZmuXWY8FqvYu0QjyFQimVgfNQE3rrzLpMf33fBQcRbAgBChp61HSmxPd8GgIWigQD271SWFwlSSEZNZB7LK1ou/TbHnEhHCEkTZOLV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 03:06:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:06:55 +0000
Message-ID: <34611342-5dfd-48d6-8b76-f5db1d40f6df@intel.com>
Date: Tue, 15 Oct 2024 20:06:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/25] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
 <797226b0c121bca6b6e6c3bf535a70aef2c4989c.1728495588.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <797226b0c121bca6b6e6c3bf535a70aef2c4989c.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: d6cd7b1b-4e9d-44d1-22e6-08dced8f971d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2ZKUUtETTBrK3lEYVNIUXZLWmtpV2xGK1AvYVRjM2R1V2tmaTk2UVY2MldQ?=
 =?utf-8?B?bFoxZXQ5aThlMlp3T2xBQjlTVTh4dUJVV2lSNFArdlJNREdnQkREVE5mN2dw?=
 =?utf-8?B?QkhpL2FnRUhLRTk1R2w2Z25mVGpqQ29mSXNNdGJjNXczVHRLOG1Gb3QzdTZx?=
 =?utf-8?B?VFFwZitzOHhMZGFsSTBNMGlWM01wZUlzUjIrYXRUUldCby9nV1hMWWVhNnJU?=
 =?utf-8?B?bTFuaDZZNVZxbnVyZE4yR2cwV3huQ1FZcXBQVnFsOG5qbVd0aC9rOW9PZHMr?=
 =?utf-8?B?c2V0ZVo5dGQzZWw3NUlkQnU0R0lwT1dISzV2cjA3Y3NuMGxuaGpkRmhLd3M3?=
 =?utf-8?B?cVd1TWE0ek9pYlZxZ2tRRy93aHprR0gvcURibFd0SzJRZ0NaMkZjdnhBQmJx?=
 =?utf-8?B?Q1ZacEdCdk1hMXVyTyt2M1B6cGJlMDB6UXQvd3JCb01lWjlMZmlHRVFLZml4?=
 =?utf-8?B?aHRJZ2ROaWI5YU5SZ1RQaFB6bWpXYlFTYy9jWEQxb1FTNmc5VWFvdlkvOHg3?=
 =?utf-8?B?bjN1L2VYc2ZZaytlSlYxU01LYk5rV2xueUtyUWdRamF0NnROV01TZlJLYUtk?=
 =?utf-8?B?ZGptUUw4K0hXYXQ3L25JOHQ3OVhaMC9aWHVEY2o3bEhvanRTRE56NTJ2NW5Y?=
 =?utf-8?B?UXBjTUthTVlRNnZQdzAxUTdlVWttbytzZjRpTWxKenZjbW5QcldyZFYxeWpC?=
 =?utf-8?B?NHZrM1NZTzZLYjBQYnRVc0YzTWRuUjgvQy9MZzZJaWp4Q3JySi8yK2plbkt6?=
 =?utf-8?B?QkFMUUZaS3c3MldvOTMwMkQ1RERxWklDQzh0SDU2MHZqb0pvejREUzR4cXZM?=
 =?utf-8?B?bnlzeTBZNERZRXovdTJyckZxTitndTRyZ3JRVi9QYkpXS21naVp2T1pOV1F0?=
 =?utf-8?B?WjFYUjh5YUdyRVZjN3liRW9MeDc3dGt3THExeVF3bnB2TnZJVy9FV1lXWnRT?=
 =?utf-8?B?MVdWSURDUlVzVmxYZ3MyTGJ2VU9ScXNJY3IxY1U5bWZvamh6NU4wOHJ4bFJD?=
 =?utf-8?B?V3dtaUdvYWlrQTVqQ3Y5bG82MXJsQVBBTHgxR2VveGV0L1hrT09IYWZyUDZ2?=
 =?utf-8?B?c1M2U2gvUHphbFNXUHI5dkk0ZkFwenRNZEEzejcxTnh4cTNyZS94dldCSTNT?=
 =?utf-8?B?ak1rWGJRNnliVFhiZlc5cGhqampFN2Y0OUVNYzkwRVJ5SkpYbWdnS1ZKNHk5?=
 =?utf-8?B?R3gzYldUU01DbU5HUlFJeTVCeXV0bWtvSi9aMGhIa0RHU2JmNlAyLys0K01L?=
 =?utf-8?B?empqTk9nT0NZTW1hWUdIWFF1UTYxYzA0b1J1RDFzRS9aKzVXRE1ybGNBQS8z?=
 =?utf-8?B?WndiSVppNjY2NFMwd1VLN2FnNStzVmVHWnNuMHJZMFczV01oRmdYdGFub1c1?=
 =?utf-8?B?eUw2WmlVem9CcFJiZDRqTW1TV0hlUUM5UStlb21QUWNBZWtEY0lFZGljWHgr?=
 =?utf-8?B?S2RMZHZ6REdaVk42ZlZ4c3lTZFRmZjZxcXhCZ1lxRTk2eDkrbXV3OE11djNz?=
 =?utf-8?B?a0pQRkhiT2pDTlI2bUNTc05uTnhlNDdGWis4WWMveWpuTEp2UkZTNGFuUXBP?=
 =?utf-8?B?eTNETm9Fdk9wZUVheXd4RTRnaytHbG5pSWFBQm5hVEREVTMzSDBxSUhQRENJ?=
 =?utf-8?B?bXlKQytzS2hBVy9sYm5QSnAwTnNwbTdWR0tKRjA0WWxmd1diT1lCTnVVOUZX?=
 =?utf-8?B?N2RHOXJTMzNzK2JWSFZHSjN3UlptNW9aVENjdXRXN3JoejVQOVozc3R3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJOZFNEOVRKS015ZlpLakRMYi9oTjQ2OU9lZDA4ZytKeVFpczNvTGZqMTE4?=
 =?utf-8?B?QTVzUll6Y29jUDJIOHZTQjg1cU4rK0JQY0dWQjlseTc4ckt4TG9YZVpQOWt4?=
 =?utf-8?B?QjFsUmVrZGd3U0dib2hTQllqOXpuMkdmSVhseTNOMDloZ3dOVnBrNUVYRlRq?=
 =?utf-8?B?S2JHTGl0WDFiOWxYRmQreXFScTlBNVQzcGYya1gxd0hvZmpFVWFscUNGaURr?=
 =?utf-8?B?RzdMc2dtbEc3SmRtdTlUeC9NTmZxQjdtcDFZTFFkOWNqODJxR0pPS2czc0ZM?=
 =?utf-8?B?b0lwSVlKMklNNTNlM1hHQTlCN1pnZTVlcC95RktOVWN6L0ZPV1JEMHNFMnJT?=
 =?utf-8?B?MWVPSE1PTnhtSDhKZktLdkk3M0NVMTdYSUpseDJXUXBiYzVWVlkwekM2Y0xs?=
 =?utf-8?B?L3FyWjUzak1zYWhvcytDNmNSSjl3SjBJci83cnIwQWFUS3FuZGhsRXc2QVV1?=
 =?utf-8?B?L3dHdlB3bUFXcitsaEQrbGVlVGFTQkdOb2F6c3hSc0NwUGZsMW9xMXhlaXN3?=
 =?utf-8?B?T3R5SzRLZlJFZVVrWEI0V2tJWCtpLy9KRVNXTkF1Nk5HUWxuR3JOL3VxNXlF?=
 =?utf-8?B?cWwwZjJucnhpeTliMGI2OWc4NTdCSnpRN2hRT25NdFdVUUsvUUNLczNsdXVX?=
 =?utf-8?B?ajNVNlBzdUtoSDRhWVB2Q3NCdW10NWM5M1QyKzBYUzBrQmMwTGNQZG5yM3c2?=
 =?utf-8?B?SjNqYmt6TVVLQm1STUNOR3V2SEJkamlpeHZjZHJMaDcydkpkM2hHVEc0R09p?=
 =?utf-8?B?N0JlcW1FZXZETE5yVkxlUURQZ0tTeWt4SFBhbEF1NmMzVXdvcGpXMXNrZGFH?=
 =?utf-8?B?bWFQZUJHeTB6L1F4MVdWRm1KVFYxYVQ3bjNmZndyMXBOZHdUKzZKUldvdkpF?=
 =?utf-8?B?MDA0Ry9YclZGaWxhOERjVXhwenp5VVd6SVJoVmMxamcvb1BFMjVkMGJtaXhU?=
 =?utf-8?B?ZHNNL1pyWkloMXBReXYwQzNGMVorazRoRGk4MmU0QW5MSm02S0Y0blNpZm5p?=
 =?utf-8?B?Vm1ta2JncllReHJFMmRLckJFRjVhV2MzcnVmOVlxTThIdnp2YWhJTGJudEJ0?=
 =?utf-8?B?bDdTN0VjUitocm53aVJDcFVqQ2NvS2ZYYkRYSHAxeHphZ2lvb3pncEtGeW9s?=
 =?utf-8?B?U1ZKT1Z1SE44QnVSYU5PbVZrVXBSRWNXdEwyY25sTk9ab0VoYTdldnJQbG03?=
 =?utf-8?B?N08vRXRMelFXSFlwZjhla25EUml2aklUQ0xDWno0eDBWMVVjT2FIQXMvQ2cr?=
 =?utf-8?B?UnRIZ0tnK2hJZTJuSkdNL1NSM2REUnIvRFNzNEtacFVHSlR2QkhnUWhKSURs?=
 =?utf-8?B?cTkzdGVLamdUQlRlQXkxdVN0Rld6cTkvMEZqOFpCQldlZzRZSUt3YnZSbVdW?=
 =?utf-8?B?cC81WncrVTM1enUzeXV4RzhHNkdNN2twbVU2YVJJU0hpR2NZSUdYWmhXVDdV?=
 =?utf-8?B?a1NDbFV2SlFWQTNPdFkvSHc0UW43NEtIam1mL0llWXBGekg2by9wTmtVQzZp?=
 =?utf-8?B?Z0lYaFNlTmtZd0JaZFpRbkVLSmRvUWJ3KzFWbEZGZkQ1Q20vODNkTGNDbzlq?=
 =?utf-8?B?SmVkVk1tamZMTWRKVDVyWjJvWXhsWDVvd1Y5K0NnT0V3RkhwSGpxY1RIdjR5?=
 =?utf-8?B?clFYbitlUDFJTG1uMHM4WlZiUjhNRWsvLzJDLzlrYWV4a3Y0YmVxYXpMcTZn?=
 =?utf-8?B?QVNpWFU3aHkwVTV2Y3p2V1kybExScDdtSzIyTlRGSG5lYm54Nnh2Q2VEVVhj?=
 =?utf-8?B?VS9sODdWM0k1Q0dpVnNrTWgxSDJsYmo1OFBjV0VSSEdHek1YUGJ0N2JCLzlW?=
 =?utf-8?B?N1hvR1B4OU1ISzM4N2lBOGtmWXNyNThmckdOakRVaUNMTE1FWjNYYlVpeTFl?=
 =?utf-8?B?bS96djc2Y1ZsZmRPWW5UTHFnT2NLU0N3eGMzZTFNaUY3MkhYeUdOYlFGOWJQ?=
 =?utf-8?B?WE91QjdZZG1vTXk3eUxtbC9oMXNjdm90b2h5cGtFOHdWMEhid21idjY1L3hE?=
 =?utf-8?B?VEtMU0E5R29NWndpUzRJWlRtemp6VVlkamROMFZqWGhML2FrUlc0OFdvZFBQ?=
 =?utf-8?B?Um1CUWMzWXJWdnFWOVJ1U1J6cTd4NUVhLy81NS9YdUFEZzdBZVBncTg5aXpw?=
 =?utf-8?B?TUI3ajlNRU9RYnE2QktqMHdUc21PVEFhMFpiSG10cmphMkhHL29lUXNiRlIv?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cd7b1b-4e9d-44d1-22e6-08dced8f971d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:06:55.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdKVgPINTK93yO+iX1hJH69zsR67dl8DID8VKlkCwrHk/+3GDlw2WN7MpkrZHYUNNoUGthtbj2aiwSuERNbGKg29uZ0AOLv/qyQzvKVKRe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>      Monitoring Counter ID + 1
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Detect the feature and number of assignable monitoring counters supported.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



Return-Path: <linux-kernel+bounces-214188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD69080DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9801C282420
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5119B1822F2;
	Fri, 14 Jun 2024 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaFqSHjo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB02AF0F;
	Fri, 14 Jun 2024 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329422; cv=fail; b=KWeCTQNu6IcEDHzCKEUrTyYwrQQzQ/qOqgUJ/SdknecQfJF2vHvkI2soSeTVOoKtPq0J36qNMxWQAFTNAu0euY+dFzSszi1UFZqWg3gAM8QK9ZsFjrHByyhE4MGFscgQWxXJvrNsfwfkYdNZRvCUpgDA030KZ90r/jVbq2MBxyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329422; c=relaxed/simple;
	bh=p6OtIMAjcm7+OJ9h7mPHEQ2Z8DFwdwfE6kn9RlvSV0w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NmwRcUU4xSsFiXLmZkjRvI5zcJz03DQXr/h3EJg/e2zXUXG20Bt+MInK3w3+FPkj5lzmYv2r5COB4OOh6LijTFj8pwXCkClBlQFQaWfFlpWdjiuE11nm6AgKrlnXvy0quL2SWp7a5tnvAOViPld4Kq4MRkkrXPUnfxB2Mz8ESIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaFqSHjo; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718329421; x=1749865421;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p6OtIMAjcm7+OJ9h7mPHEQ2Z8DFwdwfE6kn9RlvSV0w=;
  b=TaFqSHjoobA+I1y0tTYgONWKIi7p0IcF4TsOPxKB1Vv67FLGOKyPkFzt
   m6dmkJguF8qL7Tn7krBmtgyZQVW9HQEsOeZPgRACvrMygakjL2F7xRy9F
   x/0nkH/GphRFTvHvsrmfKS5W6lxTJlVaIwA/gce1Vi/qY4HCEIc2DOfWB
   1+UaLm42H6SBT4F0Hl6ZWkCLpWrHRa14OPvA0xC9ZNrckzaHiUeyH8thQ
   IcgiwT9YZ168HSqRKsP41IzmwJ1RICa/dtE0a8BXhjs0cQQd9N0mWWACt
   tbpUlwuMFMZALUJstBCYRwJ5Ek42Q9sVJtxHLy8ebG5lS4d8fYlx4IsRv
   A==;
X-CSE-ConnectionGUID: +2rx0n+TQWO4Y0nH4h/f3Q==
X-CSE-MsgGUID: e6g6iPYWQE25esKjvRzi8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15427884"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15427884"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:43:40 -0700
X-CSE-ConnectionGUID: 9ibBBY5eSWKxOMO2lKslIw==
X-CSE-MsgGUID: Z2jyoZowSbG8LFVCyfltkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40480796"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:43:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:43:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:43:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:43:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxvyzYuqT0DVjOJL3p4xfBVqe7FIZLuJ8yZEJ6DTtKGLwvhBUmpFSHDqofBESsGiMdSHX0nnxsc9ALTsNJt89e71TJNz+DpvnVTq3aRUCI7IlfR24ZkY0vYvchwlyOFvlAjSU1KeiNIvON6eqYyy1XKcDYyka8gRuQkXzlPOafTEnLOAc242TyJDCHZyPlPrBl+//4AsM0TwgUZOMGo0kzwtUzf25WZ8fM7D2O9Rn3HkN9abjt4z+O7Legjbsid/N8v8WOoAwBJV8OSHSkYzYVYxJ7rKNFuPNRBHAxvtDUFL0TYMkUiM6gwt88hrO2+gFlA3S4jUAj0SyTl9Uhyodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaoCpCOMW6tJS+0jffu8lVzryQUlaK6QRNZVwog0b7Q=;
 b=KUBse95i5jH8KSk5eSpxkovVubBy75SH8l/rIP3zqYvSfkYnPjC9uWZlAyyovjEiJ7GA8OdC8yy6og95PGXduuJPw0elV7JIbK9cRr6y5DJ2a4V0HV65W7EI2vX4z9zY3daKt1shi+aTaUfwmZLDq4v1rf1XN6VWM5BbhSC55kVg5Xe36JZi5KfcSSIIuzbYfR8UQca0mKDT9hKG1ebd4OszdL9Mi4I5KR6/g71BL8vvBKeVpF/La7UdsQQUqK/zalB/BF3Dz5Cx4nkd3GJKBWp64ctosHjvPKR7oaB4W5ILN5sQTN4kgREkPGztYL4liRKeYZwch6Lat1qR72LqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 01:43:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:43:34 +0000
Message-ID: <48e0d78c-5ed8-4b93-8f12-3ce3fd74116c@intel.com>
Date: Thu, 13 Jun 2024 18:43:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/19] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <a02dd2b9fa06f360eabe923c5c6d17fa4036aa9a.1716552602.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a02dd2b9fa06f360eabe923c5c6d17fa4036aa9a.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 18122751-b530-4830-61c0-08dc8c13676c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk1PT0M2eDZ5UDNQa2sydGp5bkJyemV4WWhta0tHUWhNWDE0NExTWUlHZHAy?=
 =?utf-8?B?YUxWdUU5Q1J3SWRWbmpHZWNrMFpTVjJhMXRnNDRPc25WQ2xHQ1lzblhyTzlm?=
 =?utf-8?B?U2JwUG00K1FjeDNZQm9pR1VyWlZ0M1BKaDBLZTNJR29wL2tGMDMremY2VTVI?=
 =?utf-8?B?ajB3KzB0Z1AzeFpQWkxaV21nSmVVdDZ1WE9pYzQyUWRjUDdmWURxZ0dsSktH?=
 =?utf-8?B?dmxJUHk0Yk9mcmR2eWlEUk8zZ2VSNk5LaU9XeVlodU1ZVHc3SWlmcktYM3Zy?=
 =?utf-8?B?NUVhY25jRkREVFdlU1E0bzAwRzRXQkUwVi9WVTFwNEtCSzMveDFaRElzTjFo?=
 =?utf-8?B?M3Y4allhMnVQQm56S1FINVRlTDV0cTlPSC9NVWRWaFJZWStobTN2Q05XVmdQ?=
 =?utf-8?B?WnFESGRMKzFodmNkUGJES0IwODN3SXNaOXZZazRFS0NwcTl3OUV5TmVsRW5O?=
 =?utf-8?B?RU0ybmVUWndYd1g5bkoyQmhhUkZGbXNQSlR0clI4anRNVktUV2JsTlBqbWFP?=
 =?utf-8?B?bEZjanRxZ3JoZkpaQnczOUN1Y2dJdjYyb0RLRmZiUnBGZ0lOTlFLOS84emxz?=
 =?utf-8?B?T0owZ2N1c0lFZSt5ejluaDRMNkx0amZMNSs2SCtCOHgvYUY5UTZSdzdUS1FW?=
 =?utf-8?B?cVV2RjZPRmJ4cStNV29XeUYzT1FIbFNvYnpUMmJhODU0TGdkSkNRVWhna2Vt?=
 =?utf-8?B?VGdLWHA1NnFGNXJldDBGRW0yK2g3T2xjZnIzdTZmQ2FYRXFQKzlUS2RiM0pO?=
 =?utf-8?B?TXlIWlZkVG9nR0RSZkxLYm5nM3c3WW1aeXF3T01rTlZTMHlzNEUxdWdJNDR3?=
 =?utf-8?B?OWFZN0JXUUpNcnplb2pEUWJwS2ovbUxxWjNWd21COXl2V0daOVc5UUNKS05n?=
 =?utf-8?B?VGU0WHBjcEYzdXVHZnRnaEtWOCszdWUvSWxmajh6OTFsNWVXNG1selRSVjdG?=
 =?utf-8?B?SHZFUnZzVUh1Zng2ZHVMaFF5ejRXK3lCMjZxOExmeXFMb3dIbUNZNVJpNG53?=
 =?utf-8?B?dDdURTY2NTljeGpEZW1MNEtaVit4NUJyNUJVWnU5ZDUyYzFyKzkzTEk1bzFE?=
 =?utf-8?B?UkZLWnA5SllwTnBqQXlmck5Xakg0MTR3NUtkSEFHTGllbGtOYkpNQ3NzeEJm?=
 =?utf-8?B?QzRBM2JNK0pDZG5NY1dDcGtjL05Ba0RKeWYzVDV1L3JYN21nNStuQXdCS2hl?=
 =?utf-8?B?VWc5TmhJRnArL2g3VXMySXc3WVVOYUNXYllIZ0tra1pseGFCcEtYOTZxeERX?=
 =?utf-8?B?ZHBsRThzcG5zZklwbTV1cWlNczBJZHpkU2xXUlB0enBucENIVmpmMXFnaGJ2?=
 =?utf-8?B?UkRqcDZUMDBYV3YyQTltZXpEa0k5N3BYOGZVRFhDSXpBZ1RGZ1pwQUVuTWl2?=
 =?utf-8?B?R0RicmJyWElKc2VGWEhkTGNrUyt6MjNqRGh2WW93ajJKL0N0ZWFxSTI4dFZ4?=
 =?utf-8?B?d2wxYy9aWFBsRDlRNjZZZ2tTL1c0R3pYTVdZYWMzMENwd1JlNTdGbGczbFg2?=
 =?utf-8?B?c1ZabWtBb1AyZDkwODF4TS9CeEFUMk5tc3YxVG5LMmd0UkpOQW9lMVlES1gv?=
 =?utf-8?B?Mk1oaW91Qndjb0M3amJvcXdYZ0pWNm5neWE1ZWt3Y2RQMlJBVm1jZ1F1dW96?=
 =?utf-8?B?RzdzRVNmNWZ3T2FPeTFnczVvZEdhMHlxQTYwWHEvYjNBWU5IN05QZkVQN1pa?=
 =?utf-8?B?NmtGYlNYaTRTWG90MlhpRnY0d2RIYWxYNXd5NWlITmJVY1RuQkxRbFZSZkgv?=
 =?utf-8?Q?+/CBcEY95kqChJ1bFo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2p1WFN4bjYxZkRheVc2Nnk1cHMveXJ4UnEvT0h1YnJSYXFPWnpuWktkYW9I?=
 =?utf-8?B?ZlRBVXl1NTZnNWV5Q3V1d2pLQ0JNUWxRNXJRd2g5N01nZGRMTFpBQ1hTczJ5?=
 =?utf-8?B?WWp1SDYvaFY4QUtFSTQ4RFNzUmRUcmhBa09ha09VaTJJZUN0WXAyT085Tzl5?=
 =?utf-8?B?VjhGLzYrMklLU3RuaTJGSkJ6ZzhkSzhQd2llUGNFNnhodFo2dW13aFpoWTRz?=
 =?utf-8?B?UmdFSlhvekJpZFZBZW9Hak81VG4vYU11TDBlbkhzSGtjZjExWHVLOWIxN28y?=
 =?utf-8?B?NUp0bVkwYVI0QnVsTjJZZytHRTA3WlpyYzdiZ3BxWkQwSGZPNVBCZjZuNlhW?=
 =?utf-8?B?SEQ2d3BkL0VLNExoM0p1dHh6b2ZlYWZCcitRYjRJQitHZWtxaVMzY1hZQlcx?=
 =?utf-8?B?VVZDYTNVcFJrZXF5bGtwOThvTEFPZ1ZRLzV1aDhFSDd5dFlnSUx2MzZtZHF6?=
 =?utf-8?B?ZlVRUDVjbklYbERackthaUJjYzJZa0xhbHdDYjQ5SkJlNHNBSDV0MTRSMm9k?=
 =?utf-8?B?VFhwb2hHY2dlZEszYjZvYTB1K01vQzlRWU9XOXA4YzVQWVU3YlRIVmREMk5Z?=
 =?utf-8?B?K1Z2ejkvTjBzTEpkWk9ZbVh6SnFwUkdQZmorS2FNcy9kTHdQOWVNNzZFSkV5?=
 =?utf-8?B?azIrRW1NQ2IvU1ovQnFSc2lwUUgya3JtMXJmUitsZ1QxN1NqMi9KZmJOMlAy?=
 =?utf-8?B?U2UrWHdNLzhSMFFhQkRjQ2RzOXVBUVdvSW0xbEtDdk1sa2VxTWdPeDYzUVhO?=
 =?utf-8?B?dG9wVUwvNnNud3YwQ0huZEN4Z1hMMXAxMnpoTWh2ckFSNDZnV08waWRWOWdY?=
 =?utf-8?B?MlZqL3BVUkx1UkpWbG9yVnZiUG5hdjdYaWw5NVdhbnd4VTJHNlpuOUYvTTRO?=
 =?utf-8?B?T1VPTWdHbWREcjdScGtNU1U1cGhHbTA1SERUOCtLTGZzYm43MVpRNTR6eW5O?=
 =?utf-8?B?czNxTlJQUlhrS3pUUThiQk83TnFSZ2h0R1BXdEJKL2hWcE1QUXFxY2syUzkx?=
 =?utf-8?B?MldSYTQ4N21xUzhHV2pObEdCUEozMnpoMDVDcitnZitOQW5BQzI0T2N0bXFp?=
 =?utf-8?B?N0pZZTN2RzEzMHdPTzYyTThoTkEwS0lKR25xTTBWNWNaVzlBYk8wNlZRVUxQ?=
 =?utf-8?B?MG00d2w1eFp0MHBxRm9aOE54ZFZwQmxJZTlxY3EzTkRBd203Rzc1emZrL0Ra?=
 =?utf-8?B?OVViMmJYN2lscnVwUUFzWjJjWnhDNHJwWkV0aUEwd2NzWmFBQ3VMVFlPaDlL?=
 =?utf-8?B?WVFiMWZodlZwdkRHOCtCMlArMEMxb1BUR2R0MkVOM08zMWFFTnllV1BuMGZH?=
 =?utf-8?B?SE1rMkZ0TjlKdjFMU29acVpDMll3a2pTcGtFYXJBTUd1TSs3cGU5OUtBWEYz?=
 =?utf-8?B?ZC9mNVMveW1YdGtHZHlKN0dQQ21zUHAzMnp6VFFva3VVTHF5S0U0SU5OOXp5?=
 =?utf-8?B?YkdZbTBlM2tFUTNIa0FoY2pIUnlyU3dHN3hZdHZ0RkFZcHNhYWdmZWl4M2tr?=
 =?utf-8?B?WmFNUUFuY0hUTjJOTkJydmJGRHlwQ3dEVlJudVVkUmxQenZZMmJPNXZZWTJs?=
 =?utf-8?B?VldTWmNqN1lkTGRsbXVrVzQwbjBBS0pPb3RwYW1Vcjdzb284OXM1bTJFbXJW?=
 =?utf-8?B?ZHdpVDNXdlNvcFVwOWtidmVpQjJLQkZEdmIzOWZ3cmlLcGZ1RzRKdHhud3pV?=
 =?utf-8?B?MEtxMHk4SHN1VWhkMHBqWG5FNEZibkRkT0JQcmU3N2ltbGR6MkNwaHQ0WXhZ?=
 =?utf-8?B?V2Z4WjlyQWxOSlpTdWZZOE5xck9CYXRDbmlSK2pYS3hGZzNsOXk1YnYxcTE5?=
 =?utf-8?B?YlhxREhjQitxZStSU3pHc1JVWkxmVWNtM1NiaktOVWd4V05kZzlYa2NrMFhh?=
 =?utf-8?B?OFJ4cjl5M2RSN3RYZzlhWG5reGU1VkNHdEs4YVVVUUJQRExod3RHajNpZm9X?=
 =?utf-8?B?WThGOXJJb0lVWFVoaTgzbnZhTzhKZ2p3dE96Uzc1aVhtVEoyRVAyUTBYaks2?=
 =?utf-8?B?eDJ2UUJrM0p6dExQL1NvNUgvWWtnZ2thdTI0aDRzbGxnRi9nTmltejBWVGZt?=
 =?utf-8?B?OFZ1UXF3cldHRFgrQWIrbjVBclVaeGFuaG5MbHN1NVo2RFBqU1F2akkvY0pR?=
 =?utf-8?B?SDVWdmRhek16akp1WDlTOXppL2JjbXd2ODNrV0c1N3Q3ZXVEUDgzMjlGM2RE?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18122751-b530-4830-61c0-08dc8c13676c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:43:34.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/IaqsU1nOodcc1vRP9TP+2PTLmtQBPSchtUCFwpYrEtiuhKdkr5GueLQbZEjHI+Na6ZOdO5/QD3K0Eysg5fRfrV/l12UZUUeMG0eNtpVnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
> supported, the bandwidth events can be configured to track specific
> events. The event configuration is domain specific. ABMC (Assignable
> Bandwidth Monitoring Counters) feature needs event configuration
> information to assign hardware counter to an RMID. Event configurations
> are not stored in resctrl but instead always read from or written to
> hardware directly when prompted by user space.
> 
> Read the event configuration from the hardware during the domain
> initialization. Save the configuration information in the rdt_hw_domain,
> so it can be used for counter assignment.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v4: Read the configuration information from the hardware to initialize.
>      Added few commit messages.
>      Fixed the tab spaces.
> 
> v3: Minor changes related to rebase in mbm_config_write_domain.
> 
> v2: No changes.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>   arch/x86/kernel/cpu/resctrl/internal.h |  5 +++++
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 21 +++++++++++++++++++++
>   3 files changed, 28 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index ec93f6a50308..856c46d12177 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -542,6 +542,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   		return;
>   	}
>   
> +	arch_domain_mbm_evt_config(hw_dom);
> +
>   	list_add_tail_rcu(&d->list, add_pos);
>   
>   	err = resctrl_online_domain(r, d);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5e7e76cd512f..60a1ca0a11a7 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -373,6 +373,8 @@ struct arch_mbm_state {
>    * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
>    * @arch_mbm_total:	arch private state for MBM total bandwidth
>    * @arch_mbm_local:	arch private state for MBM local bandwidth
> + * @mbm_total_cfg:	MBM total bandwidth configuration
> + * @mbm_local_cfg:	MBM local bandwidth configuration
>    *
>    * Members of this structure are accessed via helpers that provide abstraction.
>    */
> @@ -381,6 +383,8 @@ struct rdt_hw_domain {
>   	u32				*ctrl_val;
>   	struct arch_mbm_state		*arch_mbm_total;
>   	struct arch_mbm_state		*arch_mbm_local;
> +	u32				mbm_total_cfg;
> +	u32				mbm_local_cfg;
>   };

Similar to the abmc_enabled member of rdt_hw_resource, these new
members of rdt_hw_domain are architecture specific and should never be
touched directly by resctrl fs code, for example, from mbm_config_show().

>   
>   static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
> @@ -622,6 +626,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
>   void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init resctrl_file_fflags_init(const char *config,
>   				     unsigned long fflags);
> +void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
>   void rdt_staged_configs_clear(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index b1d002e5e93d..ab0f4bb49bd9 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1093,6 +1093,27 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   	return 0;
>   }
>   
> +void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom)
> +{
> +	u64 msrval;
> +
> +	/*
> +	 * Read the configuration registers QOS_EVT_CFG_n, where <n> is
> +	 * the BMEC event number (EvtID).
> +	 * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
> +	 * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID

This is what mon_event_config_index_get() is for, no?

> +	 */
> +	if (mbm_total_event.configurable) {
> +		rdmsrl(MSR_IA32_EVT_CFG_BASE, msrval);
> +		hw_dom->mbm_total_cfg = msrval & MAX_EVT_CONFIG_BITS;
> +	}
> +
> +	if (mbm_local_event.configurable) {
> +		rdmsrl(MSR_IA32_EVT_CFG_BASE + 1, msrval);
> +		hw_dom->mbm_local_cfg = msrval & MAX_EVT_CONFIG_BITS;
> +	}
> +}
> +
>   void __exit rdt_put_mon_l3_config(void)
>   {
>   	dom_data_exit();

Reinette


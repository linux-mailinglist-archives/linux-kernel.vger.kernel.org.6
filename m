Return-Path: <linux-kernel+bounces-251198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248459301FB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EBF1F22D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA73155E49;
	Fri, 12 Jul 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDfZXbUh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74B200CD;
	Fri, 12 Jul 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822214; cv=fail; b=imK4PbgGtrtoJzU6T9CgGeOuGSLxyMSBW4mxFhf531Hc6fBVxSRtNJjGHIQIt4A0+bCqMCF/z64sge5+ArHFGDbS9A0fRzo0/EW2Nhqkxc3w7u4g8PToWPtzIRFiKAnVk9cO0035h3b7GhDZyX/mxGUUYEJGMXEJtsHKjmnFqw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822214; c=relaxed/simple;
	bh=rNLugxGFODqvhUYmIcUg3F0SP/F5AHmyHtl/FI5FCqw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tbs4YQLRwOxDrVDjf+U2msfi+WvzQELWFn0axnl003I4r+0oaL1zYlgdyB5vt2qfJ0cTFcTo04Iz18fFX0bRfrXJIPVYhBQxkuYzQjtRVAgHiX51hogPnUqb+mpH4ApOYyFnlvYcOw6GT4+K3AbLh7guRj6wtU9EFd63gGGg2DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDfZXbUh; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822213; x=1752358213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rNLugxGFODqvhUYmIcUg3F0SP/F5AHmyHtl/FI5FCqw=;
  b=LDfZXbUh3xDodRA+j4AFHPjaG0Fc/MZhXTJaPxcEwd+LTNPDmlISAJpc
   PxH4IxsrEMh942pcbWC251+wyV8/4sxVHSbApkfjb7dNBJzBMbY50e1qu
   DAg76ruEn3D2hzM/9IAs46ggyl1bn9HHinmGcTag1Lrl4xyW6uklqfniJ
   axUvugee7EALX9ciig6aRs/BHDNy3bnSFBD2oBCes/qFKuelpuNBziVMe
   0BtdGVre9gNLkv1Vd7uPcO27uk/x/PRtBwEN2wV//EmGPAuLxys8kAMwz
   gMElSs4WBDhtzhZOXGy6RTQ1UpUyIc5wkf2vZVfSqc6z0MkevB5vahedO
   w==;
X-CSE-ConnectionGUID: aW0PdlkLQ/O2lrFikLJALw==
X-CSE-MsgGUID: UO4jS7hnRZqmYBLy0nOGhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="28875286"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="28875286"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:10:12 -0700
X-CSE-ConnectionGUID: vuYQBXdbQk6j/bJuoew+aw==
X-CSE-MsgGUID: XeNyDiAYRmelXUP9pnlQjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="48926254"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:10:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:10:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:10:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F790IOSQsMdh69GAS7YdvMSIY3oOsJCkVXwln5QY60TehIFu0YVxxPJJLJzWS6DJStHO/w8IEeRvm02PXLPIp//hefuhxRCOaeU3oEav59AGQSdiYu3iPaSH8XrcYEDtPRWD6BgWHQFw8bqm4TQESDkAbS7ftsWOcXlg0oBIs777/zDZwOIqW3/9wmk0DTQF5j0dOI9JmLLimpvuW2PfM02nY1QPI4fZpzWIVvZhqO7hALzrxNM8484biVX/K+6Tov43/5gZEhgeON8sy1spuXATpKnhrrgZ+bBWvlnGk26F+dZDTbhGODGNxkY3hFWuAM/mNf7FAxr33dG06lf7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6vZa3tbDxc/Jb7px0ksTA1eTVC3frN43nGumIDttgo=;
 b=JF5MvsahkwBzSfX/dGLMAgnG0Vj6hwTzOv0gec3kXkFpdXm4tQecMYHEAl8kQFeHzPkZCtD0ezI2Y74JyM0YwN6T5Bpiuno2E5J5ICGfItJIa5R7eCInMUD954ZdHvVDQdo5F+wV0G1hNF0r8eq5CISKhwwf0EgdfaSKNgVLaZLEh9TZk0FGmm2Vnd003AYSv1uLEsvRtu21rlJwuCW32eU7m0yxKsNhQy0NVRiZaOUguccKnpYtIxJbJ+Ropv5YGw4Yk2v/wlByKxqSlTdWzTPGQuyF6BeIzx/WkSElfys49WGRzJFxLXIMbcvfpe5UcFRMNd39E9UWwPj0xSuCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7514.namprd11.prod.outlook.com (2603:10b6:510:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:10:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:10:08 +0000
Message-ID: <0ffec8d1-a27f-48b4-997a-8cc057de701e@intel.com>
Date: Fri, 12 Jul 2024 15:10:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/20] x86/resctrl: Remove MSR reading of event
 configuration value
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <82e8c5c888220b7659d7cd57fb291412ba62b120.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <82e8c5c888220b7659d7cd57fb291412ba62b120.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0388.namprd04.prod.outlook.com
 (2603:10b6:303:81::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8c801d-c816-4c05-1921-08dca2bf6471
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am5ZekYrMS9lcEJ0WVpnLzluZFREUWRtY1lJcDNBd3pvN1g3UmFzSWRnWHRj?=
 =?utf-8?B?MWxVcXU1NUxGVndJTTZnV2orWWFwY3JKTWJ6cXBDa3J2NGZYZm5sWHpZZExz?=
 =?utf-8?B?UUxxZ0ZuODZZcG8zUjlnSVhldmZpbk94R2RJWitmdEhYU09ZSy82QVBFUlZH?=
 =?utf-8?B?OFJpVVI3OFB6aVZzSnAvR2ljQ0lWVmlmMmpmKy93RG9wSXU4TjFwNzlla1ZV?=
 =?utf-8?B?YzY2WHAzOU5PT0RacHJobk12THdTYm5TOFh2dFhkMUp4VTFBN0lJUzBNa0Ns?=
 =?utf-8?B?Q0FRQ2RqWnMwam1ZZlNHSkZTeGU3STk2cDVjcWZKZGEvQzhaRVh4MkdvVlRY?=
 =?utf-8?B?TUZZejJIQUxsblJmOEV4aDB3MjdlQnNXdUxNcGt4SWhLZWhtWDI3T1BHSTVW?=
 =?utf-8?B?d0xIK0xHaG5KMFhZZlZxUTkwN0w5UlQ4MG9ZNno3bXYvYVRFYm8zSzB3Ungx?=
 =?utf-8?B?R1A1UzRlS3ZSSFpIR29FSW8zc0pHRnhzaXMyZGwyQjJ4L3UwUUZFeDI4VGdV?=
 =?utf-8?B?Z1NCTWc4LzdFUGl3aEREd0NPRWNGZWY4bUNLSEU4dE1DYVpOVVFjK3RxckNn?=
 =?utf-8?B?TjB0bFRuV2ljeHFzWFZDNStEeG9wSE5Kdk9VNmtsY0dpNWw4VEF5QkNlNXlH?=
 =?utf-8?B?ZGFITXh4aUdkRzRTV2V1K0UyT00zWFNCaEFyZERQUGlMOThzTHkvTDFQTVhx?=
 =?utf-8?B?Ly9qb3ZsOE5BSCtCSTNGSTFWTVFDWi9BblgrNnJsSjBBek92Mjh2M3E2ZEdI?=
 =?utf-8?B?eXpWS1V1VlRxNDN5SXg2QzBnOHJCTTFEOFVuU0dLS3NKRzh4VVhVUlZ6Nmxk?=
 =?utf-8?B?Q212UkduUE50Sm0xc3VCNzE3M2tBQmVWWENRQlVjbmZxRDFvdFpyVGs2T1Zq?=
 =?utf-8?B?SldxOG1tL2dKNWZYK3k1YWZQUXJYSlFKWERObmVDSWI1S3RERUw5ZVI1NzBh?=
 =?utf-8?B?aEpkZE1hYzNLRE90QitxeE8wVThBb3l5OGw4YUFXMFBRMUR4TTNtSzNpc1N0?=
 =?utf-8?B?RXB1Q2x4K2JzZXhmc2dnZ3NWOU0weWhrSjU0b2dOTnMvSmdaaHIxdDJIZWlk?=
 =?utf-8?B?OTZ0aUIzQm0rYUtCQVpXaDZYV0cyU1hZYVJXMzhIbEJJeVV4ZitFQ2VIMzlR?=
 =?utf-8?B?bUhTNTNXT1RvT090Q1UyWlBGRkY0RkNhRXlQZzloTXhBUWMzK3dqSUlLa1lK?=
 =?utf-8?B?R0lNMW5zWkdyR1hSdlkvVjA0N3FRdThTaysvWHhnU0V1bHkvUWF3WGtnL1Z6?=
 =?utf-8?B?S3pFVzRsMzBuc2IwMU9YckJub3lDK1lmV0ZnbGxVQUVXUW1GODlpNG1lVmta?=
 =?utf-8?B?QUJpWmg0L3EzTDdiSDRVSE8rVmk4ZXp0bndlOE1OTUdRbmVIczd0dlI5czBu?=
 =?utf-8?B?Y253bUZaU3JwRGF0a1I4U1ZLYnBQT3pBQW5DTmVNRmpvNWEyWnRFWGwrcHNI?=
 =?utf-8?B?VVZZSTdadTNiT0JzWU9Ka2V0ZlhDYjBrRklVNjBwdmVMbzJIMDcwRVdxd3lk?=
 =?utf-8?B?V09iUDBiTzFVMnEyREZPQzAwQTdyRXRpbXB2NUd5cFlQUnB1cTZQUCtCa3o4?=
 =?utf-8?B?RTA2aGRvdTcxcEU5eC91NFphajFEejc3TSszdDIwYmhnMmdzZkRTazIvL1B3?=
 =?utf-8?B?Z0FtOFpNOXpyMUN0ckdtdmYra3l0M295NmVzaEt1Ymg2REhLeGh6MHNHRE5j?=
 =?utf-8?B?OHRPVlNtaE51elRYRWJTbUc3Mk5YdVV2TUE4cWdlV21vdEU3V05HV2graytH?=
 =?utf-8?Q?CbWCjMKescL/iRDupk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdzT1J0SmVWU0hjcGp0NTJJUCtCc2JQcjVzcnFSb0ljOFNYY1krSGV3Uk9q?=
 =?utf-8?B?cTI4SGgyRi9BcXFlNXlya2xQUGp3YWtCNkNLTFB5K2IrOC9nZTQ1SVdyTElv?=
 =?utf-8?B?TktCMEMrQ3JzYzVudzRMNGRwK1ZtQ2NxNVlNaG0wMEdlUWdhbTN4ODFRMzFx?=
 =?utf-8?B?bjFUaU13STR6TEt5V1FkS2hLS0lTNFFKREhSdVFaeGhOQXREYjVGa0czRVJU?=
 =?utf-8?B?eU1PaFliaGJmUU8wT0x6UXVLdFBNZTk0Uy9TU3d0eGgrVUhjMmdaaVZOSjdv?=
 =?utf-8?B?Q2syUHBNaFptYWRUVUlHMU9zdGhsblRLdTVXYnArUDJ6OTN4N3ExNFZJUG9Z?=
 =?utf-8?B?NUI0eFZHVGhRSmtaNDhkelQ2OWZKb3kvOEpDZ1RuTWVRRUh6QzZ3MnRGdEZu?=
 =?utf-8?B?R2Nwb1UzOHZFRkRsb2RUVE05VVBJVFFhZjliUVRFdGszMTU3NWNibXJnQ1NE?=
 =?utf-8?B?NktXQ210MjlRRHkwVlFZOTZIa0piQTJjR0oydXp0bHMxZ05mdWdES0FIU3gv?=
 =?utf-8?B?NUorOENXeGx0aU13S3gveTZpQWRrdUNKSUJ0WSswZENJZ1p3REkxaUU3eTl2?=
 =?utf-8?B?WXJ0bjFMRE5CN1dsOWN4czFRMjdLcU82RGV1dVBVQXlvYytDNnRqTExuNUJJ?=
 =?utf-8?B?YTc3S2UxZjlzWEN5cmQ0K3puK20rK1N2Q3pyaTRMa202MEFlSzVnWk1FRUta?=
 =?utf-8?B?TVFQQkplelpsaXk2c21TUVdPT1g3THVKd0lWYnl2VTdJZnBBbTM4YWJ6R3pt?=
 =?utf-8?B?ejFFMWMxSHFQYW5LTS82aURBZTlkdThiQmpwb3puVVdkbzlTZzUxZkQzbVgx?=
 =?utf-8?B?ZC9TTFhqSTJqa0UrL204NHJDQVpTNlJ2SkdoRCtVbENWc05nZklTSFNCVi9M?=
 =?utf-8?B?b3lORzI5TDROSno2Y2NNRXIyaUtIR0dWeXZ3akE4RUFxVll2MHRDYjZMS1RT?=
 =?utf-8?B?MlkwVEoxZUIwN2dzZGdza2hDbi9oRjUzblQ5bndRQnB0Y2pRa0pINGJCQ0xx?=
 =?utf-8?B?SEJoYjlVVDN6Qm5PY0ZhQ1pDc2NyOEk0L2FoRHRyd1U3ZXBhczZOVWlxS1lK?=
 =?utf-8?B?cmsxNUtNUW9OVVZMMmpUOStLb1YwT0NBbENGdmtSN1ltME1Wa000a21hK3l5?=
 =?utf-8?B?STI4ay8wSXk5WjR3N2o5SWxnNUJRMHEwejZBMXlhK2FoUTNKUE01VFpmZjJC?=
 =?utf-8?B?YXhMOVd3d2hDYWQ5YUxoU0ZtU3VyQitLWHBlNXBFZlVtbm5nZmJuTmt1SlZQ?=
 =?utf-8?B?T1VYTEowWWphQjVZK3o1cDh3cUZiQVNRSWFSeWpkbzhMTDhtK3oyaHBsMmVL?=
 =?utf-8?B?cU11eDl3T1A4RWpVZEE4MmtzTDQrZ2EvQTh3Sm1GN2g2RDVsRHlTb0FiWnht?=
 =?utf-8?B?b2hvTGVUQWszM0drWG5LNjdreEQzblpTdlBRMC81OHBGNXVBc1pCM0FZU2d3?=
 =?utf-8?B?S3M2WldOR2JlQlhJZHFqSnNaSE4ySEtZaVg2bzhUWDlSM3BjSlAzTmRTUW9v?=
 =?utf-8?B?VlhvTWJWZ2Uzek4xbCtjWTQvZ0MyZUJHdHRqT1VPcFpYUGRwRGk2Q2s1TzNl?=
 =?utf-8?B?UlloNlZRNExlM2htUG91amN5bUNRZTRHTW5RS0h6R2wwS2c1VktkN01ZNmdU?=
 =?utf-8?B?YzZneHVwSDdpSDRGSjF3TWFWY1liemVZbVRVbzZZdXBoN0E1SVVEdnZhK29D?=
 =?utf-8?B?ejVoL3JDVUdtbVJVNmQ4MWtib3BXZUp4dkRVYlZocGJ0MHhTM0VyWEI4dXo0?=
 =?utf-8?B?NHlKNERFK0wvQ2ZYelc1SlJzaExyck9JTmt5Q2tlQjkzTDFXWVhMZzdjWmZU?=
 =?utf-8?B?VmR2T0taTEpSUnFXQkl3MURsWFh5TzMrT3lrVGVMSWRUNHROUHV1cEl2aUpm?=
 =?utf-8?B?bkdnVW14ZWN0NlVQSEVxZ2hZem5yOTh5bmJiakI4OThLbWhrQ2FoUjYvakN6?=
 =?utf-8?B?OUZsQ1VwZ3N5ZzNHYnpjSEFQdng3UXlDOGJ4QUNhNGo2KzROM21hUUxlQjBW?=
 =?utf-8?B?cXE1RytNNVF1MWxEUVVkL2FNd2x3ZVJBZHV4YjdpdmdPMW5yMGtja2ZJck9r?=
 =?utf-8?B?bTFuRHFaeS9oclo1d2U2QUNGakNFa0ptb3ljWnlobFdxZEZpc2FBWkpXSjVl?=
 =?utf-8?B?bU8vcGNIRStyQkNaSkJqU3FWZS9Vdk9XUGMzU0tINXB3MGhHT0VQd2kyVVR2?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8c801d-c816-4c05-1921-08dca2bf6471
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:10:08.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvrqRCRUSN0AS3n7zl4guMhe/87VxMe+SfUjHSOnFL0VVOFM4PB7hgDA7WNHkeQICdLg8SkCL0asUfv6BrcfjkNXgBqL+Cb/9Jx0AKrRIsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7514
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> The event configuration is domain specific and initialized during domain
> initialization. It is not required to read the configuration register
> every time user asks for it. Use the value stored in rdt_mon_hw_domain

rdt_mon_hw_domain -> rdt_hw_mon_domain

> instead. Also update the configuration value when user writes it.

Please separate the context/problem/solution clearly.

> 
> Introduce resctrl_arch_event_config_get() and
> resctrl_arch_event_config_set() to get/set architecture domain specific
> mbm_total_cfg/mbm_local_cfg values.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5: Introduced resctrl_arch_event_config_get and
>      resctrl_arch_event_config_get() based on our discussion.
>      https://lore.kernel.org/lkml/68e861f9-245d-4496-a72e-46fc57d19c62@amd.com/
> 
> v4: New patch.
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 112 +++++++++++++++----------
>   include/linux/resctrl.h                |   4 +
>   2 files changed, 72 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b2b751741dd8..91c5d45ac367 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1591,10 +1591,59 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>   }
>   
>   struct mon_config_info {
> +	struct rdt_mon_domain *d;
>   	u32 evtid;
>   	u32 mon_config;
>   };

as seen above, mon_config is a u32

>   
> +#define INVALID_CONFIG_VALUE   UINT_MAX

So an invalid config value can be U32_MAX?

> +
> +unsigned int resctrl_arch_event_config_get(struct rdt_mon_domain *d,
> +					   enum resctrl_event_id eventid)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +
> +	switch (eventid) {
> +	case QOS_L3_OCCUP_EVENT_ID:
> +		break;
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		return hw_dom->mbm_total_cfg;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		return hw_dom->mbm_local_cfg;
> +	}
> +
> +	/* Never expect to get here */
> +	WARN_ON_ONCE(1);
> +
> +	return INVALID_CONFIG_VALUE;
> +}
> +
> +void resctrl_arch_event_config_set(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	struct rdt_hw_mon_domain *hw_dom;
> +	unsigned int index;
> +
> +	index = mon_event_config_index_get(mon_info->evtid);
> +	if (index == INVALID_CONFIG_VALUE) {

INVALID_CONFIG_INDEX?

> +		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> +		return;
> +	}
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
> +
> +	hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
> +
> +	switch (mon_info->evtid) {
> +	case QOS_L3_OCCUP_EVENT_ID:
> +		break;
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		hw_dom->mbm_total_cfg = mon_info->mon_config;
> +		break;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		hw_dom->mbm_local_cfg =  mon_info->mon_config;

Please add a break here.

> +	}
> +}
> +
>   #define INVALID_CONFIG_INDEX   UINT_MAX
>   
>   /**
> @@ -1619,33 +1668,11 @@ unsigned int mon_event_config_index_get(u32 evtid)
>   	}
>   }
>   
> -static void mon_event_config_read(void *info)
> -{
> -	struct mon_config_info *mon_info = info;
> -	unsigned int index;
> -	u64 msrval;
> -
> -	index = mon_event_config_index_get(mon_info->evtid);
> -	if (index == INVALID_CONFIG_INDEX) {
> -		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> -		return;
> -	}
> -	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
> -
> -	/* Report only the valid event configuration bits */
> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
> -}
> -
> -static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info *mon_info)
> -{
> -	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
> -}
> -
>   static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
>   {
> -	struct mon_config_info mon_info = {0};
>   	struct rdt_mon_domain *dom;
>   	bool sep = false;
> +	int val;
>   
>   	cpus_read_lock();
>   	mutex_lock(&rdtgroup_mutex);
> @@ -1654,11 +1681,13 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>   		if (sep)
>   			seq_puts(s, ";");
>   
> -		memset(&mon_info, 0, sizeof(struct mon_config_info));
> -		mon_info.evtid = evtid;
> -		mondata_config_read(dom, &mon_info);
> +		val = resctrl_arch_event_config_get(dom, evtid);

There are too many types used interchangeably. The mon_config is a "u32", but the new function
returns "unsigned int", which is then assigned to an "int". Please just use one type
consistently, it is a u32 so resctrl_arch_event_config_get() can return u32 and "val" should
be u32.

> +		if (val == INVALID_CONFIG_VALUE) {
> +			rdt_last_cmd_puts("Invalid event configuration\n");

I do not see a reason to print message to user space here. If this error is encountered
then it is a kernel bug and resctrl_arch_event_config_get() would already have triggered
a WARN.

Since this is a "never should happen" scenario I wonder if we can not just print
the INVALID_CONFIG_VALUE to user space?


> +			break;
> +		}
>   
> -		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
> +		seq_printf(s, "%d=0x%02x", dom->hdr.id, val);
>   		sep = true;
>   	}
>   	seq_puts(s, "\n");
> @@ -1689,33 +1718,27 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>   	return 0;
>   }
>   
> -static void mon_event_config_write(void *info)
> -{
> -	struct mon_config_info *mon_info = info;
> -	unsigned int index;
> -
> -	index = mon_event_config_index_get(mon_info->evtid);
> -	if (index == INVALID_CONFIG_INDEX) {
> -		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> -		return;
> -	}
> -	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
> -}
>   
>   static void mbm_config_write_domain(struct rdt_resource *r,
>   				    struct rdt_mon_domain *d, u32 evtid, u32 val)
>   {
>   	struct mon_config_info mon_info = {0};
> +	int config_val;
>   
>   	/*
> -	 * Read the current config value first. If both are the same then
> +	 * Check the current config value first. If both are the same then
>   	 * no need to write it again.
>   	 */
> -	mon_info.evtid = evtid;
> -	mondata_config_read(d, &mon_info);
> -	if (mon_info.mon_config == val)
> +	config_val = resctrl_arch_event_config_get(d, evtid);
> +	if (config_val == INVALID_CONFIG_VALUE) {
> +		rdt_last_cmd_puts("Invalid event configuration\n");

same here about unneeded print to user space. When this is encountered it is
a kernel bug.

> +		return;
> +	}
> +	if (config_val == val)
>   		return;
>   
> +	mon_info.d = d;
> +	mon_info.evtid = evtid;
>   	mon_info.mon_config = val;
>   
>   	/*
> @@ -1724,7 +1747,8 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>   	 * are scoped at the domain level. Writing any of these MSRs
>   	 * on one CPU is observed by all the CPUs in the domain.
>   	 */
> -	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
> +	smp_call_function_any(&d->hdr.cpu_mask,
> +			      resctrl_arch_event_config_set,
>   			      &mon_info, 1);
>   
>   	/*
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 62f0f002ef41..f017258ebf85 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -352,6 +352,10 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
>    */
>   void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
>   
> +void resctrl_arch_event_config_set(void *info);
> +unsigned int resctrl_arch_event_config_get(struct rdt_mon_domain *d,
> +					   enum resctrl_event_id eventid);
> +
>   extern unsigned int resctrl_rmid_realloc_threshold;
>   extern unsigned int resctrl_rmid_realloc_limit;
>   

Reinette


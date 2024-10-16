Return-Path: <linux-kernel+bounces-367170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF799FF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7389B21996
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C59175D56;
	Wed, 16 Oct 2024 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhmNKhXe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808FC2FB;
	Wed, 16 Oct 2024 03:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049054; cv=fail; b=clzAd9IkHRZmXouUST0Z+uzBwxjmtJH4E5OpRLkoGJ7JrafHvnXpGJOdk4z/HPfm/YHK6gqkodipWgCydgQT4uobN/Pfa8TUr3UXwgNI2oek5w5VDspoSb+s/ynNJL4I03WJM+2oqStW5BZFFD+pTsTrUMxGbKMVvel1DzhXhUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049054; c=relaxed/simple;
	bh=0ytGt96PVDHOrv5BUHLIopdGDVVUbYzPa2lPgAmLjMc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T6+i92feETPPrkG/K4YmIdrABUsYo7kUUDtV1pOZIGCNackf/UJEQIvp+pfNlI31zeFTPXtmUuyj3SJIgvywONntwGo5zG45M7RFXKvh3iKICb8ywq8++gV9DlcOnROxsAB/dGamCx0YhhUQu8Veejod5sJ72vjzpeSvUKI4GX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhmNKhXe; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049053; x=1760585053;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ytGt96PVDHOrv5BUHLIopdGDVVUbYzPa2lPgAmLjMc=;
  b=EhmNKhXeNU029dElBGZts8E4T3ugdQpEtYEREGPalDTRnsoCBamrxu1L
   jLm6OEnN03A9gKe7dbDIiqOhpBkGGDnSG9aIAKz5idSP+mMt7OEMpOdVA
   tkC+CCkKjd+iTQmPDzlp/kAl9lJb22E21F+uMeQENiKLhR0dlr9+qSCAy
   BQ+T5ikbGMZm2wzLB2lKuY/dCBiZVupsSdkNyHiHbHOg1Cf/zHBexVE/a
   oMAzFLhYy9D7f2NJ1YZ4hj1KLZYXMbha71sVRiO1So0JL85PBksp5WisV
   uKz3Aq5jxOYt8fgJywCgNLmHPinZY4jyU21wq+e366CeWr95Gb5CFTaXI
   w==;
X-CSE-ConnectionGUID: NUbZ1QZJQdG2VqHCV5OI9w==
X-CSE-MsgGUID: 8Cq0IhgGR3qCdgN+jTZhnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="53891230"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="53891230"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:24:01 -0700
X-CSE-ConnectionGUID: hFpzl6PzT7Gi3/mFip342w==
X-CSE-MsgGUID: WhjyWrIRRjSdZVahFOpdaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78443182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:23:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:23:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:23:54 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:23:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO15aN/fyAjIGtZZgpWyc5eQeYTCa/toCZ4MFzI5jESQ77apyHJ2rkNd9Xtp1I+kLmiDL/Huesp1za/1bxgd+oIycJscpUW16shUh4ZASRMTtu8t8WjxtzVPfK3x1TO7QpSeK2oLV8He184kBiKhPm25cgI+NBC/SnY/ZUXZomHO8hjjhhLWwKWCI/YZb4RlWIL9EyYutqi9OJoofzSCV0KurZGuGNtBVYnbMPrrlxejOZxHBg2LcGVsHEWfr3V9ORg6SV8NdQZE4nK4O1NMY5HsXlB4fA+/UVg6X1D8fDBJdG9b6ssmbRBvW15DAYELWFullbj73ptPZ/R2sLcKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3YWNea6H8URLw5ghVtHZ9cBAP5X3v8PMftBo4FWOPE=;
 b=Mvm9lHuzjPLCFRu8eO2S6mXTG5bHVqFZWGygzLRwrgaVGO3xbmywKFRHbx9t/gWj+1NWSOXorF/AYN+kluOlN4m6uRS+61QVwas4+oANcPfsRkGOcVI4jMaAl9wMfuPdpH3tqI7chmu/vLS12LCLuSIm1tY55I4sCKi2vmgwGo55P0nubqidZov8QNMzriz/qHXTyVbPl/EFRu1qItmVs7gubfPQEpxEgzHN37Jn8TZuaX58Qlk8nyTzDcsfOrJpf9eU6PYCNvx+l9iIMEV+OXXjbli5uoP0D7A0kqJXfvjrgQLix1ESyMNoLZAYatumQj6bTbTtH79UVRAq9wUpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 03:23:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:23:51 +0000
Message-ID: <d0251b1b-a188-459d-a758-fe34d91ae91b@intel.com>
Date: Tue, 15 Oct 2024 20:23:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/25] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
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
 <16d88cc4091cef1999b7ec329364e12dd0dc748d.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <16d88cc4091cef1999b7ec329364e12dd0dc748d.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:303:84::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: e68e9584-e340-477a-fcd3-08dced91f49f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWdrZGxPWDM3VDlNaU9ranNmSnBibFNKeDl3WGhKdFpZN1dZNVg4eGRRdUY2?=
 =?utf-8?B?SGRqbC81OUhxbElkNnppdTExZGpHeGlUY3FqaTFORlc0U1VOM2pEMGJaSEVq?=
 =?utf-8?B?dzUzYkJNaDgyQUlITkx4MUFBS2VUNGw3dndXdHZPK2ZvbkhUL3B4empEQnll?=
 =?utf-8?B?LzZuM2xoRGFITFNvOVk4aU5sQTVjcVlyRVAvaDNvTVRtbWI5UXJKU0VSai9o?=
 =?utf-8?B?YUExSGtmbEVlTy9WUjZPZXpuRE8xY25qTHlKNkVPaUp0T3hOeEtqV0dlWkdG?=
 =?utf-8?B?ZWdkSHpwMUtmZkNGQzJyUWNiaWJnaGVQQ1Fpb0wrVXhFZlQ2TDFOUUtBd1JQ?=
 =?utf-8?B?N2hjMFRvMWU1VHM5TEM0NVMrOHBLaVJGMGVnYmNWci85dXV1MUdocW04QTFI?=
 =?utf-8?B?bTY2YkFTUUw1SnR2V2wvOFNyMGRqcEc0ZHo2Um44NEJUNWhma3g4ak5GMnR4?=
 =?utf-8?B?ZFAzVzN6ZzlucFBhbTZvOHE3Y2toQUJIOE9wS0JIUndXL3hUWDJ1Szg4cGln?=
 =?utf-8?B?UVBUMVd4VnRPbjBpTWU0S2hmSXRzcDB0VmxrVUFqQTlFZUxYd25Mb3hodVBU?=
 =?utf-8?B?dGRSRDNLRTkreWNaTFVhWTFJODc5Sk4yakVoMmszWXZpWUJDUlY0NmJrVERn?=
 =?utf-8?B?d1N5dHB6UGNnbUd5NEN3cFNxd0FVVm9ZOTVHL2NaZUVGMlRMOGJOQ1Zzd0dl?=
 =?utf-8?B?THpxSlpQKzFaVi85SkdxZ21RS2NqZ0dzTVVCQWg2UC9pQk1qb2tWdk9lRVhB?=
 =?utf-8?B?YXdza0k4U1oyVk9VMXVyVGJ5K0hzS0liekxDTnRKYkpSTTVvNWtmYU1ieGha?=
 =?utf-8?B?aTMwNGZhZGRpUGU2dXY5dE1TSHROQ3M3dkZ5WUIwb1N5RWIrWmNBZHg2N1dY?=
 =?utf-8?B?L0l1R3kxdFJhVlFNWHk3aDFPckl5K1JQKzJwOE94K2VtM0s2aXRtOEYrRm14?=
 =?utf-8?B?ZUVSNkRrQWV3RG0zbGs4RXdOR3g3MWNwQkpWQzdPb1V0UXFWSEpZaTV3aWdq?=
 =?utf-8?B?UXJ0dkhFK1VxaG5SSW9JWmpEVFQ0bDNwOTVJempta2RUYWJLQzRPZXFETHVu?=
 =?utf-8?B?WmU3OUxVV0ZPbWtpd094UE9HamovaG9SdGx6bm5BbEg4TVVQbHR6VEJURWNa?=
 =?utf-8?B?YTFxTGlzN2wxb0JPTjVmbHVKNkhuemdLR2NvWWNrVmdseDRsQ0hrMFFocnhG?=
 =?utf-8?B?L2dmdWxnU1ZVNTlaY1I3TFZZeTNqa29Ndkkvc1VaaUxnZWZxQmpIOWFXUEox?=
 =?utf-8?B?S3FBZHlyYnJwZ2RjRHRrbDAzYWNmbm56eDlPKzZEK24vSGdYcHdUU2QyZFFT?=
 =?utf-8?B?WU43dEl6elBaMnorbWNZT1VTSW04MXQya2g2Y2wvRDE5SFp6Y1RXaG0wVi9W?=
 =?utf-8?B?a2prU0FVemRidXVHUGJhUzlyczBqRzJyTzQvSEZmM2ZqQnppbWkzQlZUSlEx?=
 =?utf-8?B?VHY4RmlSZUxrZjBtRTFUY3RPeVV4YlVZd3JmeUdRek5ta0FKcnRUWE1VQXBk?=
 =?utf-8?B?emJHZzZNdCtjMXRZSGRlNUYrM1l5VTd4Titrc1RVaTJjUWlIYXBSQjczcDhR?=
 =?utf-8?B?czdTTFJrejlma1VleW5VTjlaSzBTYVk5SzhMcEh2YzZOQ0ZlZ1haZExrS2NR?=
 =?utf-8?B?SHN3T1FrMzZrTFNIeUV6RWZURzdDMERZSGxSTmJYNjRXa09uVk53Tkp2TWNK?=
 =?utf-8?B?WWVYeC81YlJrWU5WTURSNTFKSm5ETXZCV0wwNGlVblpROVBKeTBKRWJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmxObG04bVc5MENwaUl5R0o1MXc2TkZxUmJuend2WlNoL09jVVhkeTFlNENR?=
 =?utf-8?B?cTZQMXc1cGp3K2pEeTVFZzB6NGUwQVdtRDgvVjNEb1pEaG1XWFQvdVR6VEhC?=
 =?utf-8?B?c0prbXVlRWNKd2ZJYUd4MGpHSFo3bWtyV1pIT0dMUTVmdklnY1o5MVIvZ29y?=
 =?utf-8?B?ejk3Sk5QOFUrdDFIVUFwSFZGbVVMd1I1MlBtaS9VcWd5NE1JZXVnL2x6Z3Ir?=
 =?utf-8?B?UlJPRWhndDdPNWVxVE9qbExOL0F4ZXFsbFA1ODd2RUhHL3dGUmhVUzh0LzFu?=
 =?utf-8?B?NUpjSkcwY0U2KzdYWWg0RVdsSm9QN1pmRWR0U0F1K2JZYkRGb3hHTEV4QlFr?=
 =?utf-8?B?dmUrZ2NCaXZ5OC9Xem9KRlRhZE5XY2wyQ3dUZkN5QzQzYUN1U0Y2MTRPRlBL?=
 =?utf-8?B?dU45SGhEWis4enFDOWVDSWFlcTlqdmxzS01ZTWVjTWJsT0dkcWp5b25hK1p6?=
 =?utf-8?B?RGp0ZnVnalZITy80OWNqU3o0SW9uZDVCOWl4eUVDemdyS1pBOGt1TG9kQldD?=
 =?utf-8?B?NDBBa1c2U3hYM2pSancvYXJMdHpIR09nVnlmUEp5VTE1OW1tVzA0ZFk0dHpz?=
 =?utf-8?B?QS91OEtCbC9RTk1IVjEza0tlemlxcThCdVo0a1ozWStDMFlscC9DbzBibVky?=
 =?utf-8?B?UjVUcXMwYkowa1VCRythYVBieTQvQVNZdFhFbVZ2K040Sk9McGRSU0Q0cVdy?=
 =?utf-8?B?dUxOSytXQ1NkMjFOV3kyR3JkMXNONUdWMEVJVlFUZVZKb0N6R0FraGJGZzFH?=
 =?utf-8?B?ZkVraHh2c3Uvbm1YNkdjUDFzbVJJQjF6cVVLV2M3TjRJWTEzN1cyVithNGNl?=
 =?utf-8?B?dzIvVVlMUjE2NDMvaXpxT1pQazdpeVZnbFE3NFRTZnp5N1BCMW1oaktZM2hI?=
 =?utf-8?B?OVZxTmQwV1NSZ0c3Zm8yZXc2QzlubzZpSVozUnNMWk9LQUhIMnhETWlHbjZv?=
 =?utf-8?B?bXpleEViVXJsa2NFSG5uTlpXaVErTlBlaHJRemd4aDY4Z0hhNWp1RTh5bjZQ?=
 =?utf-8?B?L2JVMy93b0crQ0MyZ1pubjZCR2xlSWtnNzVKdm1WQlYwUDdxWCtsVFhCNldv?=
 =?utf-8?B?NHBMdmd5UkFxN3BQTG96cTk2MWkrVUNYY2xOZ1ZWajFrUkNVakFCQ082eWx0?=
 =?utf-8?B?cEgrUVRlRlRXSkV2aHh2a2JibUxSNzJXYVIwZzhHbG5WR2MzWCtacUdyNTNN?=
 =?utf-8?B?Q0Y5S0oybkM5L2owdlE0bmlISytidXVnV010RW5GNFNpeHdsc3NPY0lPanJ3?=
 =?utf-8?B?dzkzejFRakNtREtoeTltWG9TYmlYYXd3N3loOCtsS0lpVS9Pdmt5eldRazNu?=
 =?utf-8?B?TWtNeFhWRHVxd0pxTVFVb2NUUDNWanZHWWxYalhwSDhFSmJrb2xpaEVFUXZr?=
 =?utf-8?B?ZWM3QVFFaXRZMXRwcEtVcWJPYTZKenRxSktIM2wxam1Qb0tNbEl4K1RxUjJj?=
 =?utf-8?B?ejJxdDFETXloSkh1bGxGVk5PS2pnTGhSanZrWEMxczhLcFJybXFKWjVpMEt1?=
 =?utf-8?B?b2ViQ0ZLUlgraTRTcEtMMGE3YzNjYzBLWkF5TyszL3hUOUxlb1Mrd3p4aTRT?=
 =?utf-8?B?UkVQeWNIQUNQd0lKK1p1cjRTOUdvTkI1WkhjaWtycXp2bnBreitmRkgzTmwv?=
 =?utf-8?B?Y0xRZHZ0YjdKczhnMUw3TU80M1hlVHNmYnJINUI2L2lVQ1dhMXF5UGJkUXpK?=
 =?utf-8?B?elJ1SzNuZTRMK3hZZDhWejdINUR6WkZnWEdId05XOVZBVFJPc3hPcVN0aDRS?=
 =?utf-8?B?OGJLWm9XNXRBQ1JZSHh6SExjcWZ4N0EwZGdiWXBIMVZ0a1hEa20vWWN1Q1d2?=
 =?utf-8?B?ZW1JR1lsUXc5cUdIbWNxeXpHdjVpSVJieWx5ejZEVFZNeHVsUE1laXVKWEtS?=
 =?utf-8?B?VkxSbDZyQ0V2cmdvZzZ5OWlUYXU5c2pxVk9KcjVHcDZKQSsxV0c3SnRUSTBm?=
 =?utf-8?B?Uk5qVmcxWENXZG1vQXpNWkk1eGh6bkp6VUVLbjN2SVZaR04xeXdQVjZiTW9N?=
 =?utf-8?B?L0pnRE1vdGtyV05pMTJiOXBlTTNVb0d3WHVyZHpYb1A5NTV3dFZxKy90VGJq?=
 =?utf-8?B?dTltME9CYklScHNQOUZ4Qk9naDdqN0xpS2svektpRUR4M0FycldTT0Vsa0NG?=
 =?utf-8?B?N3RzV2lMOXVQdW1zQlhuS0NUQXd4MnJGbjVzeGRuNGo5R1FZZkpOcnJUVUFo?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e68e9584-e340-477a-fcd3-08dced91f49f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:23:51.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeylmjMO75WFZlw2ZU7YYQhRU46+jvXGhkeXgrOyX82Nya34NcDWz96F82a4zhcbL1Ylv2/Re/yaDXfML5bw1vFM/g17QPA4kd/+1G3a3IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID, event pair and monitor the bandwidth as long as it is
> assigned. The assigned RMID will be tracked by the hardware until the user
> unassigns it manually.
> 
> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
> specifying the counter id, bandwidth source, and bandwidth types.
> 
> Provide the interface to assign the counter ids to RMID.
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>     Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  3 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 ++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 58298db9034f..6d4df0490186 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -705,6 +705,9 @@ int mbm_cntr_alloc(struct rdt_resource *r);
>  void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
>  void arch_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
>  unsigned int mon_event_config_index_get(u32 evtid);
> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
> +			     u32 cntr_id, bool assign);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 03b670b95c49..4ab1a18010c9 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1853,6 +1853,51 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>  	return ret ?: nbytes;
>  }
>  
> +static void resctrl_abmc_config_one_amd(void *info)
> +{
> +	u64 *msrval = info;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
> +}
> +
> +/*
> + * Send an IPI to the domain to assign the counter to RMID, event pair.
> + */
> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
> +			     u32 cntr_id, bool assign)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct arch_mbm_state *arch_mbm;
> +
> +	abmc_cfg.split.cfg_en = 1;
> +	abmc_cfg.split.cntr_en = assign ? 1 : 0;
> +	abmc_cfg.split.cntr_id = cntr_id;
> +	abmc_cfg.split.bw_src = rmid;
> +
> +	/* Update the event configuration from the domain */
> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_total[rmid];
> +	} else {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_local[rmid];
> +	}
> +
> +	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
> +			      &abmc_cfg, 1);
> +
> +	/*
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in next update.
> +	 */
> +	if (arch_mbm)
> +		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
> +

More on this later, but I do believe later code can be simplified if
reset of architectural state is done by caller. This function should
focus on just configuring the counter.

> +	return 0;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{

Reinette


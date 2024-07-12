Return-Path: <linux-kernel+bounces-251187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271C39301C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E07FB22037
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A5955E49;
	Fri, 12 Jul 2024 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFgM5xKk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5581BDE6;
	Fri, 12 Jul 2024 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821373; cv=fail; b=fbmFC6gAkWASWaP/H5zk4AjysXfa69vT7mHN3WU+Te21KnfrPMymOgKKboYZb6nMrOsracWd9D/b3yhjmfQsLO2wLQDS3/tkiliC8KMQYVMCc52yLIO5oOXschj5tUMD6KD7MgEMrouvg5y0cOdK9ieXgQCDlrLwwsC7XHuK/bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821373; c=relaxed/simple;
	bh=jJCRwJxoosLbrVfU3VcyrnOylMm4SMC5AgN8574Hboc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QMerxxmRDoyTScgNYgvFPsR7LfBgcUyEOrZ2ZyiTke+kMgCwpiolqYK+DahnmyxNVJx5iekoZceA4mSx5maA+kxDqJOj4lTyJW2Nt4mADG55lxAMBuP5kjBdEoqQJyfBjyznC259GYVPFy5rULK1bsnm4DqaqaAXHp+b24QY63g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFgM5xKk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720821371; x=1752357371;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jJCRwJxoosLbrVfU3VcyrnOylMm4SMC5AgN8574Hboc=;
  b=bFgM5xKkLTJBY224TxX1OGgjM6i9nyw92UFO/MVi8t0vIlAX5tYHYeJV
   oc9k8FqxaTfryHIGcG5ZvZFtAsnzBg2q39/XTEV8vY++qsXSOKU1CoBBC
   ZX9aam8mH3YEnK6wVmJZIEDCN1OtHm3QmgqxujysF2MEqP0bMxbUFnhNl
   P0difB6sr7zTYHnB98Mk8pTTRkEO4+r2GwmESgogEa5EKKA3nglnqIJoQ
   cDcP+0Uxv6PqZVqx0zktsig+0+eFzfvdAknZEWRB2hyuTGsCOsOJwsM2W
   H3pXO3HJ/k5cwqJTAmgoGexTNiqbLyo6O5aePyqZ5OeEZ2B+VCzc2qNd+
   g==;
X-CSE-ConnectionGUID: 3hQzW5xdQ+CFvnps+ovr2g==
X-CSE-MsgGUID: GvgbETt/Rw28VKe0+tCpaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="17992531"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="17992531"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 14:56:09 -0700
X-CSE-ConnectionGUID: xepB+ubRRDWuUZc/VFbnnA==
X-CSE-MsgGUID: n0PK5u3GRBS5mPZRA6mSKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53868149"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 14:56:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 14:56:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 14:56:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 14:56:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 14:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbPbOs4uWL4jwZpTgu8epuOnGcqEfsIW6O+yzBvgZ24RJexoxnI2DJM1YpOEh3LbC/WOI0f5khRAAzmSq6W9w5nQ+Dre2YG6NoRdep8OH+HJpUXya0rk7o74J5SlNle3hYnbu5CP9iIJ1u9ctETgcjM4YwbneyIqHi3uIZaXmh2lI8hpuaFK1KyPU+P+wQrFC94NI5hk9SrhftUUldvymUNYoFcl2fuNH7j1K2w0SbPYoU58q3XICsxlwGJxty5UbvE6YO3mGNz0plPcXZmlLuscJ4M1JuMcGLIi5xuZRBuvpj8QOdDsRb5GM6K+6VFzeSdm/hWxNSob22vwRKBghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=casLdDwlUg1V2W7mFdqObOMhUFq2soiqjgLfwHqrySM=;
 b=d2EcY/TG5ieaN3Ims0mUzEQi0BlPJDVTSbojaSQ6BVbUM2GPxTa+pV3JcihoSWCoNMQT7f7GFHNvA2ZyMIOXyFO9A5xoS7yoU4jbFLbAuaqBiRklzK7Mgkp3IFtYHT3E+TP3y/t+cozrPShrjX669xttFhdmsLf32zK4oeBYnyYyAJZ4UrVDgHiMUlHO6qIlI6QeLYX+Jg/0DHlClagGrjkKvBxUb9vEpAEuVbQZ9+j0s0GrMSQbPd7FceKrOz192pE+oy2lIJ2nH16kTXKjtUrER7M/hIsx5ATTd+yJe7Kyx2alt4z546JmmF5JuenfvBnCw33TjzRegasexvzM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 21:55:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 21:55:59 +0000
Message-ID: <1c51aa93-5b86-4361-87d5-3d5d48fac4e6@intel.com>
Date: Fri, 12 Jul 2024 14:55:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/20] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
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
 <724d0234ca56d71f9d8d893806870181d027f556.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <724d0234ca56d71f9d8d893806870181d027f556.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8aa3f3-c1a5-4325-6326-08dca2bd69d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anNQUVFTdUpxc2RuQ3htVkk3KzZjSUcyTlFqSnR5eTU4VUt1eVRacWUvMVNY?=
 =?utf-8?B?VFZCSmNGZ0oxb3FsRlNTSTI2c0kveGJLZ282TDVlZGdNdkxtNHRvcjY4aFlk?=
 =?utf-8?B?TFZHZjFFNlQ1ZkwvR1BEdWdEZTFUZUZQSGx3RWpiVXN6Zk1TV0FkaWJyYnRK?=
 =?utf-8?B?SmtUVi9qWXpWbmszakRMYldDRzlnaGp2bEVBdTVQMEVPL3BlYllGTlBFa0Fp?=
 =?utf-8?B?U251TkpkL1ZBaFdVWEwwME11VmlyK2NUMlM3TlV6Rmx4eEplZXNIVFVmOG9w?=
 =?utf-8?B?NEx2dm1lVjdrdVJiZ0ZkMWM1OUtSSUZneFRxdk1pSGEvUlhpcWJyVWFaYU02?=
 =?utf-8?B?d1VXQXZ3NjQxVTdVMnZYdjNnNU9yOXdxYW5wQ25aVjVja2VITlJSVjNHVjVB?=
 =?utf-8?B?MnlpSk1CdmRqaXpvNUk4YnVRMEpaaWRCUURnVjAreUJHZ0VVZjExT1NrbHo3?=
 =?utf-8?B?cjNYUThNYVlTZkRZNGpwREp6dVhGYVRaSEdYaTc4UkJwbTAxUnU4SnRuUjV2?=
 =?utf-8?B?dU96ZGJ0RWIvYkFzUWsvakdHRENZSnZKMTY2Ty80eUdabElJb2Vtcy9VaVJw?=
 =?utf-8?B?cXU5cUNvWkRNU2U3aHZUeG5zRlBJd054ZjJXWWxqVm5vZFBlTGdyb1V3L2dv?=
 =?utf-8?B?ZE93SklTYXhsY2ZLc3NFcmxLSEFNcVZ1ME5vQ1VWckdrNXVOMnNmS1RRMzNI?=
 =?utf-8?B?MlFTcVFIU0NzYUdRTWZQb1IvUHhSTnA3c2dSWDlhbHNzRG1vVDIwZzd4cFR3?=
 =?utf-8?B?dXFYemV3ZFlzRmNrRGRORjJSWTY0QkVqRE03SWprbFAxZk5GOGdONGJxYjRS?=
 =?utf-8?B?WENZZldKK1hDNjgwMlpub0tBSi9NUmU5QXlQdktyd0ZBRHR2Y2JJWWsxbEMw?=
 =?utf-8?B?K0FQRW9OK2VsMmxoNlJ1SjFNVDN1UUtkZlJMUFA2V2ZDYWhES0RxZXhSZC8z?=
 =?utf-8?B?WXRLZ2VFM1ZDRU9EVTVNODhpNit5NXhsOFBIV0xuak5Gb3VxRHRvNlRPanEz?=
 =?utf-8?B?VTF1dXdKOUlMWkFKTDJSZUphNDZ4czlMc01YSk4wNGVtZ2dSOXE1SDhPaTFi?=
 =?utf-8?B?d0V5bVVHekNqMk1VZWVTZ2xJNDF1YjR3Ri9sNGFZWUhMNnRaWTJ0NWx0TlRw?=
 =?utf-8?B?b1ZCbFFmVG5XNWZGQ3ZYbVBoUFUzVldVN0ZtV1dod0diWmxhZ0Frc21GNldF?=
 =?utf-8?B?SGRRcFBxVVRBUjdLWGJEQ1g2Qk9BZGphUXlqZldCa0RvMzFrNnpTaVBoa295?=
 =?utf-8?B?TkxVMkJnTlg2WWJqMitrUDVpZ0wyNEE5bVY1SHlObURia1hpQi9LMktyM1Az?=
 =?utf-8?B?Wms1SEFIei9aTkt3cFR0SStYV2hwWUZISWtyZHFzUkl3TmtGUExnbG96ZWg5?=
 =?utf-8?B?bzhVQUl0MW10cnl4c2ZMZzJPQkZCekdLaUNoM2ZYU3EzNm1COXI2VFNNZTZQ?=
 =?utf-8?B?YktPS3UvaCtMVGZWZ2tpMDQyTVBBNkFxdGRySUFXMDNIUzhaSi94NDJOWVdK?=
 =?utf-8?B?RTJOTXExbG5kMlRsYTlJclVhMFo0alA5UFcvU2FsdHNJTm9tOHhUOTlxYisr?=
 =?utf-8?B?UXBCVHM2M3A0WG0yUzJvSkF1aWNZYUhxMXFoQ0Vmakk2OUVIblBEbGI3S0dU?=
 =?utf-8?B?enA2WHhJUDFZWUFWRmFpbTFMMlM2TjJOckF3QitBUU01bDFNYjcrVDdBd3Zz?=
 =?utf-8?B?K2F3M1V0UU5GeTd6RzBrUVMyWXJYcXgwZS9kRUZjeFVYY1BPUWk1TWhPTUNB?=
 =?utf-8?Q?IwlnRywZ5tY0zm7AEw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlWUW4vUHZ1RkppQWVJYUk4Z0Zza1hBOGRLOTVTWmtEZlNreTIxWTBjS1Bl?=
 =?utf-8?B?RnVCZ2RZbTFhMHU1c1JpNU83VFRQVlFoWWk5VEZkOVVmR0VTQmcxSFFsd0c3?=
 =?utf-8?B?b1VIQ0F0ZVJNcjlKeHllOVpneHJoNXJMUXBHSmQybEI1N2ZJMFZRY3RPajRF?=
 =?utf-8?B?azJhQnM2VXEwdUpRQmIyRTRtTzdLem1DdkFoZ3hJWGwzWm9RN0hiNVJDcjN6?=
 =?utf-8?B?dXlEWmNTTVE1TWZoWTQ4dmFZUWtJTkN4RGJleC92dmdRSnBpcTBsZ01SbU9m?=
 =?utf-8?B?bW85QjhEY1NodjZYeHN0dGVkaFk5cFY0NzJnUUh1LzZUWGJrUmY0M1plbFU2?=
 =?utf-8?B?YnFrNHVIdTJENktHZEJ6V3M3Tm5ibkt0STArYy9iclZMSGZIRjBRS2Y3NVNB?=
 =?utf-8?B?c0orQ3lUeGl5b0JUQ2JkSU5rMkZkZS9zUlBZdnUzOGtiUGVIdU54d2tNVkVS?=
 =?utf-8?B?RHhDK3IvMVJua2F2d0xybXA5OGtUWTNLNnI4ZThRNWdCS25PZmJpUHRIQTNV?=
 =?utf-8?B?ZlIxTjVIL0tiV3ZPSHZpSDFTSWtCVEo2ODZMdEFLdGd3Ym5jYTl4NjhTMSt1?=
 =?utf-8?B?VGJlL2laalBRcU9zVDV1RzF6Sk5EOFFIeVhCdmxjcTZxQ0ZKU3RGc0hZcVNJ?=
 =?utf-8?B?UVlYa3JPZ3NNOFJrTWMyZDc1RHFnTHNvVFg2ZTl1TWh3REdhT0FpMmE4REJq?=
 =?utf-8?B?djh3ZXNLSnVGMUxjd05yTUh4TUxqUGVjQkpQNFU5dDRPQmo5REZXcjF5VXNh?=
 =?utf-8?B?UlRmRjA4ZVpRQS9tNlJ4NjFyRjFERVJlSHc2RjR6M054SkY2VmN0c2Zwbnhi?=
 =?utf-8?B?dWU5ZmFuaUxqS005YUh5Y2JVdndYZm9BNjZvcmZ0aWdMaHZ4ekZ5OU02NzdI?=
 =?utf-8?B?NXJMUUdMaFBudjJGUVlhd21nU1ZvZkxKU2t6aWxtWDZnZ2lmOE1VbWdOR2to?=
 =?utf-8?B?VVpjUmZOdnY1N0pLSVN2dXFPMG9rcjFaTVN3Rm96SkJ6TXVPUWN3cHViYm4z?=
 =?utf-8?B?YWYrYTlNOHdkUFFPNTJXbjZ0YnROK2Vta29kMVNEMzM2U1JvVTFVNUt2MXpn?=
 =?utf-8?B?RmI5UVV1SkNhTi9SNUpRRVZhczVHWWsxS2wwc1pUaUNjc2FiNVY2UUFsL0FI?=
 =?utf-8?B?bHQzeURjOWRPODNhZW9BcFp0TnFiMHh3NVJVdCtyQXZ6Mm81bi8reWQ1bDZL?=
 =?utf-8?B?VHNRNlUxNEN5Y0tudkhXb2tFOTM5SVN5V2taSEpmUTc0TFM1ZnNqTldtK0Z1?=
 =?utf-8?B?K2UwdkF6c1hORkJQMnJWSFFFWVZUNkxSK1doMjU2OWljL2RYQXBabU5JY0lZ?=
 =?utf-8?B?RVAxR3VPcG1XSGdGbWE3TVJCbGF2WEdMcVcyUVQyeFRqTFFLbk93cWIzaXhQ?=
 =?utf-8?B?K2x1ZVFoT294SUZtdldHcGZHNFRJckJpWStwY3h5d0dtS01TdFdCNTl3aVNE?=
 =?utf-8?B?WU1PUWE2N1dXUU5LU3VoSk5KWU1EenozWFRxd1RFMFhqK0xBUTJESk93c0dW?=
 =?utf-8?B?MkszUUZnVnNFTTJlWUZIWUI1dnIrRnMzd1J6dVFkMi9DaGpHOW5FQUJ3aSt5?=
 =?utf-8?B?aTZlcmZmbnZQK0JCUWNMd2crQTdVbEhIR25zMkZmdUp4dE1LeEtRZFhRNzdZ?=
 =?utf-8?B?anRlRitWYnN6ZDNKRElUTW9CUFJJQm9RcHFkQ0RQTElyc3RIRnRiSERRRGth?=
 =?utf-8?B?aU9zU3hRNXhoUWZmWE9qQ1MxRFVmajQweFlEVy9KSmJPYWVGU0JxUnQ1UHJy?=
 =?utf-8?B?WU0rTUU4UXptdUwyZmpRMGdPNmhPRGt1blhzNG9Pb2s4SVhyV2hJUkZQZjBG?=
 =?utf-8?B?YnBrSmxpaCtyWStySFlSWXBoTU5jLzFzaW8zdDgwb2xaMHZ1YjRubzAzclh2?=
 =?utf-8?B?aGJlRy93U0lnYlFzS1Jkd3NsUFU0TFE0OCtWdzNpeEgwK08wV0VKVXpQSjhS?=
 =?utf-8?B?RXpYTWl0VE1zUmhjaEZuVXZEWTMvYnZWbm5ZSmJYSnN1TS9Oem8rUjRleFc3?=
 =?utf-8?B?NGtoTEVKanVIblYxbTk0ZXpJbGlOejZUbzdvT2RxUlFyWUkvWkdpTW1pTklr?=
 =?utf-8?B?eXJremw2ODU4VExBcVBuTHFiWTQ5UWNsSEdMWThDdnFrMWVJcCthdzBmQ1lJ?=
 =?utf-8?B?dWRhRHRSaDdGUkdmcWFlWENwVThzVkQyZkk0Um5WTzFxaDZGdHM3OHlNRTRa?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8aa3f3-c1a5-4325-6326-08dca2bd69d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 21:55:58.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+8vLRzz0Rpbg8oQlExuHZPGssKdxxDGv9W0wxdyz/RCoTMbCmWWbU9Ch+jxEOvbg0Uvn3yeeveAGAWaX8eLigGJblJEFiG4EcEBi26y7EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6725
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> Users can create as many monitor groups as RMIDs supported by the hardware.
> However, bandwidth monitoring feature on AMD system only guarantees that
> RMIDs currently assigned to a processor will be tracked by hardware. The
> counters of any other RMIDs which are no longer being tracked will be
> reset to zero. The MBM event counters return "Unavailable" for the RMIDs
> that are not tracked by hardware. So, there can be only limited number of
> groups that can give guaranteed monitoring numbers. With ever changing
> configurations there is no way to definitely know which of these groups
> are being tracked for certain point of time. Users do not have the option
> to monitor a group or set of groups for certain period of time without
> worrying about RMID being reset in between.
> 
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as it is assigned.
> The assigned RMID will be tracked by the hardware until the user unassigns
> it manually. There is no need to worry about counters being reset during
> this period. Additionally, the user can specify a bitmask identifying the
> specific bandwidth types from the given source to track with the counter.
> 
> Without ABMC enabled, monitoring will work in current mode without
> assignment option.
> 
> Linux resctrl subsystem provides the interface to count maximum of two
> memory bandwidth events per group, from a combination of available total
> and local events. Keeping the current interface, users can enable a maximum
> of 2 ABMC counters per group. User will also have the option to enable only
> one counter to the group. If the system runs out of assignable ABMC
> counters, kernel will display an error. Users need to disable an already
> enabled counter to make space for new assignments.
> 
> The feature can be detected via CPUID_Fn80000020_EBX_x00 bit 5.
> Bits Description
> 5    ABMC (Assignable Bandwidth Monitoring Counters)
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Note: Checkpatch checks/warnings are ignored to maintain coding style.

This note may be more appropriate below the '---' separator line.

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


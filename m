Return-Path: <linux-kernel+bounces-290400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681D955357
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF922831AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F3145B39;
	Fri, 16 Aug 2024 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTNOj8x7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218DC2D02E;
	Fri, 16 Aug 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847626; cv=fail; b=m+hBSIv2kaW0oBVbwKT6Hhrap0vvIaTpsZRlYCdL4gejCQPc6wRPSavxE1yCrjzHLkMdHihnqZhWBwnhPcuDLb+fxhx/NnaIeoIotZDHF3uUUqNe3q33KTiRfNTxmoTBjv1uE5CRHHyElIjT7UAnPz4mcOuyS0ESk+t0gaxoGMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847626; c=relaxed/simple;
	bh=o/5CK/sIOE+rAe4Ap39biPh0kslyLbcT4dnAZYTeJsw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IzeYWYJIbn1VkT29YI7uyJD5KDBMHcXqSodlFusZAkrViEzaVUfgf7vRoEHyYU288WoQc5nU2dFhO2Blfe3ztH4SjIsJQHA7MXMYK3xVrC88PUCiIhndgt3rNTnIF1VS+kwr238T4CDuyZ/iVaXLCDJ+gCbtI9t7Xht38J0rsZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTNOj8x7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723847624; x=1755383624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o/5CK/sIOE+rAe4Ap39biPh0kslyLbcT4dnAZYTeJsw=;
  b=hTNOj8x71AchFL1xU4MQH72f9bO6ulCuwjCHR9MTBnOOFCfBo76giBYW
   I+T6sE2FNZq+BlbM8XDDD+OPr8aGjg09JhZ9r5izHpbLRBTCVE4GJjQeC
   pRRA6FoRJcS6A3PxRQxVdNoWs88GAvUNw1/UKTr5xA8yN8H6JYXIy7CQr
   W+M441Hn9DdOiuGVjh8tQ4rQA+gyLx7LT4wtGiIwYdo6GfKgiSFHAs8iM
   8IwjKWbMDmqaAGXo1IoN5s29ms8difHWuevNYZPUtPdrVgQ2kaeg9KOgT
   jhKc961xqdEVPJUJ0mRo/isrQMgyJHkNTocziccRgi1yFfAQrfCCGcPqU
   w==;
X-CSE-ConnectionGUID: xZ2xf//MSnGA+pntMo4W5g==
X-CSE-MsgGUID: 3IZyLVucRTmH3ttZM8w8Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="33542530"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="33542530"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 15:33:43 -0700
X-CSE-ConnectionGUID: 0mYj4AbWQ7GK8Fk7hSTxuw==
X-CSE-MsgGUID: laWsx1vIQVCvT0N1XnelZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="64695882"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 15:33:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 15:33:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 15:33:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 15:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/Bc7VPMhRGb/VSZ9Ro9Avt7pPISwWl3y7lket9sDRSR4bvmnLi6auhEfWL+z4okYD8b3WaK5kPA7gPpn4y6DUlOTc7acOFu27XJD7vRwekE1PYFm+jOIX6yN0/aYufA1S101q9ovShP1DhjIqcPPFw3n6PH9yi/uUVgs0ChqxFc7Iy2EwGnxaSpYMzXHlPrSIw21yKmA5jc3GN7FPQ7mupy9SvNdnzrrwPnlc96RyyDF8zSP7Yc2avsThvMJab2Mb75aRknfKCquxVk64Pb08kTPAmPVazzGJS6a54Xvm3Zdf2d1OaT1biSvno3iCYEGdHa+Vb1AhPV9a2KRD6/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl/7mBN/X/xNMqk4kgSTV4xoKZ/AdO2Lf7fLePlaXlI=;
 b=VSOJk7Q0A+2iVMjnWl1qyZbMkxCWOaHa1lj+ZdkFOtGIA2YQmbVzOFXgUUBXyfA2qXJwUS2E40QY8qkB+EpQmFAk3gASYnDn8VTmy5sFqP+PRXY+Ec6pEaFtKC6/WtCGhb0UYuqMSNNX34/iFn2NnvTlJVYF2CIVcJssgw6nvRLraMnhARebWNBILOxo4HlKzO0g+fUhUm2Yb42cNTjmLlTCDkLHHYA+9/nyaMhaRRYE7/GM61kmRpihTlRjdMlSFjdbkXW9Ivx96TaJAvuTO8jKk1naN6BwVAG3T4J0uAHHS4rVDhmHo+b3JtxcBAFd0PsPZqNxgQA77gL8z0E/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7397.namprd11.prod.outlook.com (2603:10b6:8:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 22:33:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 22:33:39 +0000
Message-ID: <d4873add-ac24-47dd-be45-28af3698c334@intel.com>
Date: Fri, 16 Aug 2024 15:33:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/22] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <30a946c5ec042e66db675e9e57fe2cff971f570e.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <30a946c5ec042e66db675e9e57fe2cff971f570e.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:303:b7::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa93371-66ae-46ab-f813-08dcbe4379ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cC9YSlQ0QUNaK2dMUVhGd3J3YnVubmI1MXArL2NPRUdrVm1wUHgxSnlNRWk4?=
 =?utf-8?B?NDRGV0FoQXF1WkxoVFp6dFZpaXhWam0wMFlWNWJHZTVsZkEzb2JuSlZSczM1?=
 =?utf-8?B?YmxJRXFxZnJPcS90TnIxdm9ybkFLSC9TUldlb0JibE9EZGlWYWk1K3Z1dnpa?=
 =?utf-8?B?cFhXWTRnNkZXeU9lMS96azkxTHU1dnN0M0R6czlKSkRUeit3c1hSR2RBT1Va?=
 =?utf-8?B?WnlHbXl1MEdaS2ZicFZQNzNod2ljMWlzTGJsKytraXk2UjVsY05nT0ZLUVlk?=
 =?utf-8?B?eEUyWTc5M013elMwRXlzaUxUM0dINms4NDh1Vzd0Zi9kTk8wdS8rdi92Y2ov?=
 =?utf-8?B?bVI1WjZjQWNXaW03MmJjQU43akt5UDl1WTN0Wmh1akNGYktNT293MFNKWGdN?=
 =?utf-8?B?Z3ZLUjMyTlR6bWttZFFIVXR2enByRE96SURBL0FMalVzQWdINnBIWVJoZGZx?=
 =?utf-8?B?RGNBc0M4N3kxOVZDaytoUmF1OU9GaWZLWWttYXU2bi9EUTdNVmphR2NYRHhS?=
 =?utf-8?B?UkZHZGtjdzc4ekdmbTE5Z0NsK1lKYkFZaklLYyt1WHJtSzRWVlRpSHlTYzQr?=
 =?utf-8?B?U3Foa3pIMmhzUnd0UVRLSE9LTzdMd3JJckNiUFo4NUlORytDaVQyNjA3Wmd6?=
 =?utf-8?B?TFphaVg4MWtyZjBDc0pENzQzMkNNNTFxTVpnamxCVWd6cCtuOXU0Z2VKWVlN?=
 =?utf-8?B?VzhScFhvUlcvczJMUWs4dWJ5ZDEvb1pYNzVMUG1RVW84TG5LQnU0dUhMeVgv?=
 =?utf-8?B?Ukp3eHhQU0c2MzU4a1FHd0ticWhMdkVNU2dKTCtDd2xNMHI4VzFuUXh4MXVB?=
 =?utf-8?B?aDhRNTQyWCt3bVhWNTNKV25tSHJYSS85TmdyRU8wWUhCMUxNZSt3YjRCVHFH?=
 =?utf-8?B?WjNmSldLT2hWTmNxVWFsNU5lMll1M1RCUjRCVjdXMjVDSWhjNlBvWGlMQUJ5?=
 =?utf-8?B?Y01LeDhxa0l4QnEzeC9EWENaZGZRYjlQRjNUYVpMckRGUmd0TmN6YmUrSmJV?=
 =?utf-8?B?QkVaalo5NFJyTjZESlZEUUNEV3FjNnYxd1ZRNWdPbVdCVnc5L3BXcS9BN0Y0?=
 =?utf-8?B?VDRtM2l1NFhKMWxSWExJQ3F5RDRSYXBLMDVZSnNLUGpWZGgwVUt3bFBxaU5x?=
 =?utf-8?B?VUUvL21NYUZuU0svVVdSbVN6alVoeVg3czNKQkZYcUl4ZU9lSzJVd2JOQnUz?=
 =?utf-8?B?Qi92Sm9idkVWZUg3Vm9uMmpYYUlYczZjZE1UcC96Mkk2MnpjRlRoM3pYSnB5?=
 =?utf-8?B?dVBJUHZGMW15M0ZqdGF1Qnh0Z1VkSVQ1eVpMTHBsejBsOE5ZZ1VYZmtSZ2pS?=
 =?utf-8?B?M2xtaTdLSXh5NmZGdTZjR2NpOUd3WE45VjE3M3c0THcyc0pCRERRRldpdnJp?=
 =?utf-8?B?NWduYzRHQnAzZTNKMnE1VUVlejJvWVJDc3lJS2VGcHZHVTlsMjFyOGNlaFRB?=
 =?utf-8?B?ZnFFYWRPUCs5czFuRWZrMkxRNXpKaU5idWthajc3cmZueXBIVmVGY0dMRklR?=
 =?utf-8?B?ZSs2RGtvRWppZURsMk5uMVgvT2RVUEhkc2J1NGZmKzd1cHZvNkNPUHpaVG5n?=
 =?utf-8?B?WEQycXRRVjlCRWp3RUxxRldqNFJmY3cxQjRaMXZsWXhlS0o0cHI4TDA5dkVH?=
 =?utf-8?B?MGtnSGlHSXZxb0NYRElXVnBTODlKVDA3TXphRnlOcUlnSzJDTTdTYUpYUTZE?=
 =?utf-8?B?Y1dkQnBvQUIwNjYyY1dnbGhDZ25OOGh6aFA2MmdWZlZnY0VERm5KbVd4MGNE?=
 =?utf-8?Q?JpAWqAu5TRFqFhRTro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG41UVhER0ZpbGdlYkRXSUhXMjJYbjVqckVYQkMvamhOenczZE1oUTgwU3dL?=
 =?utf-8?B?Wk9nR2NMbTZWVzRaT3RRUGpLZ1k4MGpvTHZZRE5qSFZaL3BIbE9JZFdjNlgw?=
 =?utf-8?B?UWh5SEZsNjVDWXlockxQTm9lQ3l0ekNIYjAvTEFZZUZ3WkxSblp0SlZnUXo0?=
 =?utf-8?B?NG1hOGtyNThIODdIU2tMS2w0ZXB0V09pRFNvMjZmS1FUbGx2bTIwakQyMVli?=
 =?utf-8?B?NUcya0crbU1sVnZTNlRjT3FlVExDVHNHQ3IvR09YNW5KMllJdzdoUlVWRFFy?=
 =?utf-8?B?b1NtWloycERXZjdkUnEzT3MwclJQaXlFV0FZN0txc3JtK0FiZ0xjUkgrT2lL?=
 =?utf-8?B?VVlYT1pzZmtSa0J5UlJkcWQ1dXRDanlQbCtKU2cxb0xDVnZPYVNWMFZ4SUFy?=
 =?utf-8?B?NDdrdWVtYW5sMmJDbWQxM0FZck9uRFMwWGJmOHc1bWVmWXdwbnNJWFYvR04y?=
 =?utf-8?B?NHplTkR5b0ZsMUFyWkgrMjZwRERINFhOR1F4azV6dTVmN0x5aG51MktFTGNp?=
 =?utf-8?B?eGZFNDE2T0N2MllrazVNVU1EakpMQXRxOVZzQkR2SmJwS1dMRXJiNk1wT2pM?=
 =?utf-8?B?RlJkM3NQU1hldXJUQW00UWZzdXlKV1QvNTlqUjRuSEVZTDVzKy96K3dFN1I3?=
 =?utf-8?B?K2F4emFHODhZaElJR1BXU1hzallxZElZY05vczdVaHUzV1llMGNJM1RCV2pj?=
 =?utf-8?B?WUtPWU1SeUZNWHdPK3ZuT3hGUnhzWnlKaFl0bSt6dEtFYmptNS9HN1h3emZi?=
 =?utf-8?B?OVJnQjlKU1FrRWlieFRFYkp3RnducGVxV04zV29Bb2pWYUZxVG5MT2NObTM3?=
 =?utf-8?B?bUoxZzNSNnpIdXYrTVN1eFRYRkxyaVFQQlZlTUFZMVZzQmNJR1UyVGlJMmxF?=
 =?utf-8?B?cmp0K2FDYWZPM2NWMGJ4L3N6RUZ6WExnendLemx4UjU2QnpnOFJVMis3RFVY?=
 =?utf-8?B?SzJzemdlaDIrelhCcXlPaTJLdldzQ2lwL3RiaEgzK0p3ZVA4ZzJNUVRSZ0k5?=
 =?utf-8?B?U0dWbVF4VDFPVnhDWExOQUR1VzlvOENoOEVnUDRzcVlsWno2Z202dTZVT3pl?=
 =?utf-8?B?K3dqNTZwNUhsWE56WUJ2NDdUTE5hekx0L0JkaUQwR1kxYTRyd1dTYm9zRitL?=
 =?utf-8?B?YnVvMzV3TkJFVnFsZDY5MEo3bEpUK0pmTDE4SEJnVkI3MzVRVkhTQW10S3hR?=
 =?utf-8?B?aUZBV3dUVHdmeis4Qk1zTjVDZjJWeUUrbTBTN244R0V5QndaYW16ZnlLcGRH?=
 =?utf-8?B?R3YvVU5LS3ZOa296aHRzTDR5U0dPKy9xUWZIRlF1L2pZRjNqaUJYQXhJNVRw?=
 =?utf-8?B?endRVzdlcnFPeHQ3Vlh5MFdERjU4Ry9LY1VOTXJFZE1DUkIvUUVUNDdoWWJ3?=
 =?utf-8?B?ZHM1dnlUam52L1RaK2x2Z3ZyQk5lTnZxbjl5NnY4djBMbzhvWng5V0VTYi96?=
 =?utf-8?B?NUZQU081Uk5rS2M1TE1kdjZNWE5ub2o3QVlyNzhZMW9IajBKRkQ2VGQrY050?=
 =?utf-8?B?ZnNsbkFDc294R0N4bSswQnZlbTRIWldsa3FFaXBObXZEbWc1bEpEc0NrVXBz?=
 =?utf-8?B?ek15SGFCT2ROdnFKTVg3RTUzcjREZG4vRjBLM08yUjc1ZW1lTjV6K3hJSUto?=
 =?utf-8?B?Rzh6dkRMYXd1Wk1aaURTUm52VXJRUGU0RklBQ3BTSnlvUUxKeVRHdWN6ZEJV?=
 =?utf-8?B?Y0tNSUhUSU9ZVkxwSzBuZ0VPOUJUR04rMjFzQXdSb3hyYnZSbVdwR0ROSThC?=
 =?utf-8?B?WmFnbU9UdXhmRGRwTFdlM2lQU3RZSlErNW54alBxcE1ZUDAzS3YySnI5K2xz?=
 =?utf-8?B?bnAwM3kwWUt6eTBlNmd0aFF1Vk5hSDJtTVArUEFXTTZ5QXhHTXF0NndhOGtF?=
 =?utf-8?B?SGtuRWVNSlh6M2U4MEgvaGd1VUJjRlQ3dStNaEFTUkF1MmZ0R1dPZFRqYmhL?=
 =?utf-8?B?U0l1YnlQanZFdzFaclovQnA5bGc4RmhiY0VLRnZmUFprVTJNVHFSSFBGd2k3?=
 =?utf-8?B?Y0JMK2lhM3htQjhhOGJ4RnlZS3liZUhLaWdxOFN2YzRadk9DRWZuK3lhTWRz?=
 =?utf-8?B?OWtybGVVT0hxRlVLRFZUeXJKa3hRVFFDNlpqL09ML2dTL0xSa2szYi8zM1Va?=
 =?utf-8?B?MmVYZU93Z1M3bER6eE5hMUJ6ejRqdGx3dFBQajJRdXlOSDJwajloRi8xOWNt?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa93371-66ae-46ab-f813-08dcbe4379ad
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:33:39.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bio1vWQLMlZsYx2Zn3eIvgYUbitSRQPiQSKWpuXd7IIQlHX++zX5M2xxJ2XP24F/aOUnfFA3W1papRbj/7RxDSBH7bADyVNTstttpyIffTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7397
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> Introduce the interface to assign MBM events in ABMC mode.
> 
> Events can be enabled or disabled by writing to file
> /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> Format is similar to the list format with addition of opcode for the
> assignment operation.
>   "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Format for specific type of groups:
> 
>   * Default CTRL_MON group:
>           "//<domain_id><opcode><flags>"
> 
>   * Non-default CTRL_MON group:
>           "<CTRL_MON group>//<domain_id><opcode><flags>"
> 
>   * Child MON group of default CTRL_MON group:
>           "/<MON group>/<domain_id><opcode><flags>"
> 
>   * Child MON group of non-default CTRL_MON group:
>           "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Domain_id '*' will apply the flags on all the domains.
> 
> Opcode can be one of the following:
> 
>   = Update the assignment to match the flags
>   + assign a MBM event
>   - unassign a MBM event
> 
> Assignment flags can be one of the following:
>   t  MBM total event
>   l  MBM local event
>   tl Both total and local MBM events
>   _  None of the MBM events. Valid only with '=' opcode.

(please note comments in this area of cover letter)

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Added support assign all if domain id is '*'
>      Fixed the allocation of counter id if it not assigned already.
> 
> v5: Interface name changed from mbm_assign_control to mbm_control.
>      Fixed opcode and flags combination.
>      '=_" is valid.
>      "-_" amd "+_" is not valid.
>      Minor message update.
>      Renamed the function with prefix - rdtgroup_.
>      Corrected few documentation mistakes.
>      Rebase related changes after SNC support.
> 
> v4: Added domain specific assignments. Fixed the opcode parsing.
> 
> v3: New patch.
>      Addresses the feedback to provide the global assignment interface.
>      https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
> ---
>   Documentation/arch/x86/resctrl.rst     |  94 +++++++-
>   arch/x86/kernel/cpu/resctrl/internal.h |   7 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 315 ++++++++++++++++++++++++-
>   3 files changed, 414 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 113c22ba6db3..ae3b17b7cefe 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -346,7 +346,7 @@ with the following files:
>   	 t  MBM total event is enabled.
>   	 l  MBM local event is enabled.
>   	 tl Both total and local MBM events are enabled.
> -	 _  None of the MBM events are enabled.
> +	 _  None of the MBM events are enabled. Only works with opcode '=' for write.
>   
>   	Examples:
>   	::
> @@ -365,6 +365,98 @@ with the following files:
>   	 enabled on domain 0 and 1.
>   
>   
> +	Assignment state can be updated by writing to the interface.
> +
> +	Format is similar to the list format with addition of opcode for the
> +	assignment operation.
> +
> +		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> +
> +	Format for each type of groups:
> +
> +        * Default CTRL_MON group:
> +                "//<domain_id><opcode><flags>"
> +
> +        * Non-default CTRL_MON group:
> +                "<CTRL_MON group>//<domain_id><opcode><flags>"
> +
> +        * Child MON group of default CTRL_MON group:
> +                "/<MON group>/<domain_id><opcode><flags>"
> +
> +        * Child MON group of non-default CTRL_MON group:
> +                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> +
> +	Domain_id '*' wil apply the flags on all the domains.
> +
> +	Opcode can be one of the following:
> +	::
> +
> +	 = Update the assignment to match the MBM event.
> +	 + Assign a MBM event.

"Assign a new MBM event without impacting existing assignments."?

> +	 - Unassign a MBM event.

(similar)

> +
> +	Examples:
> +	::
> +
> +	  Initial group status:
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +
> +	  To update the default group to assign only total MBM event on domain 0:
> +	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> +
> +	  Assignment status after the update:
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +
> +	  To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
> +	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> +
> +	  Assignment status after the update:
> +	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	  To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
> +	  unassign both local and total MBM events on domain 1:
> +	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
> +			/sys/fs/resctrl/info/L3_MON/mbm_control
> +
> +	  Assignment status after the update:
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	  To update the default group to add a local MBM event domain 0.
> +	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
> +
> +	  Assignment status after the update:
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	  To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all
> +	  the MBM events on all the domains.
> +	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_control
> +
> +	  Assignment status after the update:
> +	  #cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	  non_default_ctrl_mon_grp//0=_;1=_;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
>   "max_threshold_occupancy":
>   		Read/write file provides the largest value (in
>   		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ba3012f8f940..5af225b4a497 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -46,6 +46,13 @@
>   
>   #define MON_CNTR_UNSET			U32_MAX
>   
> +/*
> + * Assignment flags for ABMC feature

(this is resctrl fs code)

> + */
> +#define ASSIGN_NONE			0
> +#define ASSIGN_TOTAL			BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
> +#define ASSIGN_LOCAL			BIT(QOS_L3_MBM_LOCAL_EVENT_ID)
> +
>   /**
>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>    *			        aren't marked nohz_full
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d7aadca5e4ab..8567fb3a6274 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1034,6 +1034,318 @@ static int rdtgroup_mbm_control_show(struct kernfs_open_file *of,
>   	return 0;
>   }
>   
> +/*
> + * Update the assign states for the domain.
> + *
> + * If this is a new assignment for the group then allocate a counter and update
> + * the assignment else just update the assign state
> + */
> +static int rdtgroup_assign_update(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid,
> +				  struct rdt_mon_domain *d)
> +{
> +	int ret, index;
> +
> +	index = mon_event_config_index_get(evtid);
> +	if (index == INVALID_CONFIG_INDEX)
> +                return -EINVAL;

(wrong spacing ... see checkpatch.pl)

> +
> +	if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
> +		ret = rdtgroup_alloc_cntr(rdtgrp, index);
> +		if (ret < 0)
> +			goto out_done;
> +	}
> +
> +	/* Update the state on all domains if d == NULL */
> +	if (d == NULL) {

if (!d) ... (checkpatch)

> +		ret = rdtgroup_assign_cntr(rdtgrp, evtid);
> +	} else {
> +		ret = resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
> +					       rdtgrp->mon.cntr_id[index],
> +					       rdtgrp->closid, 1);
> +		if (!ret)
> +			set_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map);
> +	}
> +
> +out_done:
> +	return ret;
> +}

Please merge this with almost identical rdtgroup_assign_cntr()

> +
> +/*
> + * Update the unassign state for the domain.
> + *
> + * Free the counter if it is unassigned on all the domains else just
> + * update the unassign state
> + */
> +static int rdtgroup_unassign_update(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid,
> +				    struct rdt_mon_domain *d)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int ret = 0, index;
> +
> +	index = mon_event_config_index_get(evtid);
> +	if (index == INVALID_CONFIG_INDEX)
> +                return -EINVAL;

(wrong spacing ... see checkpatch.pl)

> +
> +	if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET)
> +		goto out_done;
> +
> +	if (d == NULL) {

if (!d)

> +		ret = rdtgroup_unassign_cntr(rdtgrp, evtid);
> +	} else {
> +		ret = resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
> +					       rdtgrp->mon.cntr_id[index],
> +					       rdtgrp->closid, 0);
> +		if (!ret) {
> +			clear_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map);
> +			rdtgroup_free_cntr(r, rdtgrp, index);
> +		}
> +	}
> +
> +out_done:
> +	return ret;
> +}

Please merge this with almost identical rdtgroup_unassign_cntr()

> +
> +static int rdtgroup_str_to_mon_state(char *flag)
> +{
> +	int i, mon_state = 0;
> +
> +	for (i = 0; i < strlen(flag); i++) {
> +		switch (*(flag + i)) {
> +		case 't':
> +			mon_state |= ASSIGN_TOTAL;
> +			break;
> +		case 'l':
> +			mon_state |= ASSIGN_LOCAL;
> +			break;
> +		case '_':
> +			mon_state = ASSIGN_NONE;
> +			break;

It looks like this supports flags like "_lt", treating it as assigning
both local and total. I expect this should remove all flags instead?

> +		default:
> +			break;
> +		}
> +	}
> +
> +	return mon_state;
> +}

hmmm ... so you removed assigning mon_state to ASSIGN_NONE from default,
but that did not change what this function returns since ASSIGN_NONE is 0
and mon_state is initialized to 0. Unknown flags should cause error so
that it is possible to add flags in the future. Above prevents us from
ever adding new flags.

> +
> +static struct rdtgroup *rdtgroup_find_grp(enum rdt_group_type rtype, char *p_grp, char *c_grp)

rdtgroup_find_grp() -> rdtgroup_find_grp_by_name()?

> +{
> +	struct rdtgroup *rdtg, *crg;
> +
> +	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
> +		return &rdtgroup_default;
> +	} else if (rtype == RDTCTRL_GROUP) {
> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
> +			if (!strcmp(p_grp, rdtg->kn->name))
> +				return rdtg;
> +	} else if (rtype == RDTMON_GROUP) {
> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +			if (!strcmp(p_grp, rdtg->kn->name)) {
> +				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +						    mon.crdtgrp_list) {
> +					if (!strcmp(c_grp, crg->kn->name))
> +						return crg;
> +				}
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int rdtgroup_process_flags(struct rdt_resource *r,
> +				  enum rdt_group_type rtype,
> +				  char *p_grp, char *c_grp, char *tok)
> +{
> +	int op, mon_state, assign_state, unassign_state;
> +	char *dom_str, *id_str, *op_str;
> +	struct rdt_mon_domain *d;
> +	struct rdtgroup *rdtgrp;
> +	unsigned long dom_id;
> +	int ret, found = 0;
> +
> +	rdtgrp = rdtgroup_find_grp(rtype, p_grp, c_grp);
> +
> +	if (!rdtgrp) {
> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
> +		return -EINVAL;
> +	}
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +
> +	op_str = strpbrk(dom_str, "=+-");
> +
> +	if (op_str) {
> +		op = *op_str;
> +	} else {
> +		rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
> +		return -EINVAL;
> +	}
> +
> +	id_str = strsep(&dom_str, "=+-");
> +
> +	/* Check for domain id '*' which means all domains */
> +	if (id_str && *id_str == '*') {
> +		d = NULL;
> +		goto check_state;
> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Verify if the dom_id is valid */
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
> +		return -EINVAL;
> +	}
> +
> +check_state:
> +	mon_state = rdtgroup_str_to_mon_state(dom_str);

Function should return error and exit here.

> +
> +	assign_state = 0;
> +	unassign_state = 0;
> +
> +	switch (op) {
> +	case '+':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		assign_state = mon_state;
> +		break;
> +	case '-':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		unassign_state = mon_state;
> +		break;
> +	case '=':
> +		assign_state = mon_state;
> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (assign_state & ASSIGN_TOTAL) {
> +		ret = rdtgroup_assign_update(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID, d);
> +		if (ret)
> +			goto out_fail;
> +	}

Should unassign occur before assign so that unassign can make counters available for
assign that follows?

> +
> +	if (assign_state & ASSIGN_LOCAL) {
> +		ret = rdtgroup_assign_update(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID, d);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (unassign_state & ASSIGN_TOTAL) {
> +		ret = rdtgroup_unassign_update(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID, d);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (unassign_state & ASSIGN_LOCAL) {
> +		ret = rdtgroup_unassign_update(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID, d);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	goto next;
> +
> +out_fail:
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t rdtgroup_mbm_control_write(struct kernfs_open_file *of,
> +					  char *buf, size_t nbytes,
> +					  loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	char *token, *cmon_grp, *mon_grp;
> +	int ret;
> +
> +	if (!resctrl_arch_get_abmc_enabled())
> +		return -EINVAL;

This needs to be protected by mutex.

> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +	rdt_last_cmd_clear();
> +
> +	while ((token = strsep(&buf, "\n")) != NULL) {
> +		if (strstr(token, "//")) {
> +			/*
> +			 * The CTRL_MON group processing:
> +			 * default CTRL_MON group: "//<flags>"
> +			 * non-default CTRL_MON group: "<CTRL_MON group>//flags"
> +			 * The CTRL_MON group will be empty string if it is a
> +			 * default group.
> +			 */
> +			cmon_grp = strsep(&token, "//");
> +
> +			/*
> +			 * strsep returns empty string for contiguous delimiters.
> +			 * Make sure check for two consecutive delimiters and
> +			 * advance the token.
> +			 */
> +			mon_grp = strsep(&token, "//");
> +			if (*mon_grp != '\0') {
> +				rdt_last_cmd_printf("Invalid CTRL_MON group format %s\n", token);
> +				ret = -EINVAL;
> +				break;
> +			}
> +
> +			ret = rdtgroup_process_flags(r, RDTCTRL_GROUP, cmon_grp, mon_grp, token);
> +			if (ret)
> +				break;
> +		} else if (strstr(token, "/")) {
> +			/*
> +			 * MON group processing:
> +			 * MON_GROUP inside default CTRL_MON group: "/<MON group>/<flags>"
> +			 * MON_GROUP within CTRL_MON group: "<CTRL_MON group>/<MON group>/<flags>"
> +			 */
> +			cmon_grp = strsep(&token, "/");

Isn't strsep(&token, "//") the same as strsep(&token, "/")? It looks like these two big branches
can be merged.

> +
> +			/* Extract the MON_GROUP. It cannot be empty string */
> +			mon_grp = strsep(&token, "/");
> +			if (*mon_grp == '\0') {
> +				rdt_last_cmd_printf("Invalid MON_GROUP format %s\n", token);
> +				ret = -EINVAL;
> +				break;
> +			}
> +
> +			ret = rdtgroup_process_flags(r, RDTMON_GROUP, cmon_grp, mon_grp, token);
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -2277,9 +2589,10 @@ static struct rftype res_common_files[] = {
>   	},
>   	{
>   		.name		= "mbm_control",
> -		.mode		= 0444,
> +		.mode		= 0644,
>   		.kf_ops		= &rdtgroup_kf_single_ops,
>   		.seq_show	= rdtgroup_mbm_control_show,
> +		.write		= rdtgroup_mbm_control_write,
>   	},
>   	{
>   		.name		= "cpus_list",

Reinette


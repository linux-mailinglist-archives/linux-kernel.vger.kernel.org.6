Return-Path: <linux-kernel+bounces-367156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8B99FF34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45B11C2451F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0515C145;
	Wed, 16 Oct 2024 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZcBL4b+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4121E3B6;
	Wed, 16 Oct 2024 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048576; cv=fail; b=OLUo8GP7ggAmxoXaKh61EzTD5Q5Eo27C9+xjwqz5IdtqdHm2BCrmcUZw3ugUq80SafwfjrA2Ioa8tKgvKmXV4lGVtXABKIRK36noGRdQwpEr8elnJZ5EFDi2/Xr4XMZHCleqaCcUNbC1IASKS7sWp3LnUvEpQaArbn8CIDlrDmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048576; c=relaxed/simple;
	bh=Ell59W7W5TDPfqBbTY/BGAyo66hRIub/EyJC8IHtyTI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AUa96+d6CgPX/mE7XobZQbL0s4RZ4oenN9HZCZENUaElYe3lfz6elsbVPP2j+foX7Yf+hvM8uOszhXVBDBPIbnaQndaMW3OLcDTzChzqHqXQ5ABP7uTR07ujlLV5vssFHvO+aVQp8CM1QYzvr8JPXZsXaHmeNyBHP1HR3fI/4sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZcBL4b+; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048575; x=1760584575;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ell59W7W5TDPfqBbTY/BGAyo66hRIub/EyJC8IHtyTI=;
  b=RZcBL4b+v30PxaU+fPksI53eCrbR50yocAhhpK7fBXbH0YTNja3e6ytC
   JoC8zVUG9HO23hch4k16lxBHdX0faFZnqewHRfJF73awzHpg8VCAHWUWT
   ypFGWj35LySv7ULofri0cSbcSkBRqoUSdNFodwGe2YN203zUHktp0xVnr
   wX/kto942ClmV9ls39CMQKbhKEY9xfw4JpxvG76rzGlHKd/9oJ2lYiYD3
   2pavyHMWNSRsBGLFyYLlR+wPYwmztbAQRA528eFKXLQe1VAH633z44gTh
   L1mQT6l6/fZHO4ayDGNfBMbeyEEh/+SVBLcgkMNu7JNeXoIxw9uFETl63
   g==;
X-CSE-ConnectionGUID: 0tHQz8s5T+CtThsc5Ze7dw==
X-CSE-MsgGUID: SLXs2BKWRXWSYg2/fgZHpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28354961"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28354961"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:16:14 -0700
X-CSE-ConnectionGUID: d60yq+VvRAKVECCmwXJeHw==
X-CSE-MsgGUID: lPGTzLBVR8OyzRey602yJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77716509"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:16:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:16:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:16:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:16:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5fpriCO0vlYiVjyB+AopSaFJ6gfJyPzyQeqL/ZPtvgd7YSNzAPLGzr8FUp3ZimnDQTMDTCgeeejxMiKqkSSSIddjrN3UZ49XhRUHpTcCJXQ+MmR6ny8+G3MWlf0JpI6X0jKLI8I8KVH/4ygRIxMDnHTLVsJy9a3Wj6ew1EM8mKVTIL8Ipyj8/03mDLmBySRPIcAwuJtobpOHp4V17KTmGTXPsFfEygMrz/83uPWEwh6eFCLMDq7o5cY/9mZcLDg+KZo1TZ2J541VFpodArI3RUP9fWHibnnq0uS/RGM4NkTgXcfV5E6DUkLmkT/t5Auo4TDtu/BAr/1F5DjbdLvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0RDgBXe3Knsu82J5GsLMwDCV+pTfeg+DwjxqOVRG+Q=;
 b=NsJ2aCmV6PmLroqna042wZm/f9WvEMJzzwEQZxVhT1lBfxLhxpEeaGNLiYy89dVxJsG5ZKUg5CrYv+MuIFHV+fXHGJ0IlEqk2rMSguY0/VGQIzjYUXnnyJK5RFpDkG3F8muQS+NTYB9EpwAKQISIXHCMJ9MddGBXJjfagPL8Zik1oog7RZ72+D1u7VFOHtbXAmfr6dDwCM6jd9g92sxefNk9lk0LE3CMKCZzkIrmJ0P89wF9lL3AIzxCyv1RMKY0kHj37XkTLgys4mmtLynSXmBd4Q9D3pbqr7IzpzOtcOTAnaZPBbl0liU7hqywlTrYPHab3qfNksp+UqNctSfAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL4PR11MB8823.namprd11.prod.outlook.com (2603:10b6:208:5a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 03:16:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:16:04 +0000
Message-ID: <dd53ed4f-d1c3-4b1c-9f4c-1852a64e9d87@intel.com>
Date: Tue, 15 Oct 2024 20:16:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/25] x86/resctrl: Remove MSR reading of event
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <d6e298e9ccbf04207cb352b4f3c9f90613547b52.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d6e298e9ccbf04207cb352b4f3c9f90613547b52.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:303:8d::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL4PR11MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: f41269fe-0144-4b27-1a55-08dced90de95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2RDWWdSTmNQVGlNM2JYamlXWlYvZlp6OHUrcHlRZUpJZW9Pd0pPOFZqYU9i?=
 =?utf-8?B?NUdBUCt5MUlDN2pac2EwUTluZ1piVDJ2Z3IvcHZsd1hHbEo5YjNVb1gzQ05W?=
 =?utf-8?B?NGZ1NSs3eldDZFUwNDE3SjcxMjhLcmFZb0hTU0pjWGo3czRWRC9yeUJEWVVm?=
 =?utf-8?B?eVg3U1lpcTlDYkg0Y2ZvaGNWV3lSdEYxRUI1VWpWRlZndUwweHUyK3lnVUdq?=
 =?utf-8?B?dytGcHFwSEVMUGIxYWtvTmhxdXdDVGhyZmdrUDJIZVBVUllaWTBOTEx2WUZ1?=
 =?utf-8?B?bk1OVWM1VS8wTERUVlRETnNzd1FvT1BuYTE2ak5lNTN4dnJaUHhWakJQalhy?=
 =?utf-8?B?L0JlUFhrWkU2NDY1dzZVMWV4a2ZSanZIamV2QUFVbFRSdzVRL3ZSMmUveTBI?=
 =?utf-8?B?ZWRzQjVRZ3JsOWlTMlNPZFZQWGdxenFGZEREK2hXUU1uN0dobUVtU2FhR3Fv?=
 =?utf-8?B?cFJwNG5ycGx6bm0xM3p3RTNDMi9TempKMGpkK2ZhSXVrZzJkVEVKVDR4T3dq?=
 =?utf-8?B?NDdKc2UxV0tnOTVoOWs2YncydmRXK1dkN2RobmxpM25RR2VPM0RySkRIckly?=
 =?utf-8?B?NTJEUkl0VVdoalJsNzI5cVgyN1ZPaU1Bc2NISWx3ZXpQL0p5ZmlFRW04ZkpV?=
 =?utf-8?B?MEk2ZWl5SXFrYThhTzB3OWZBbHJhZE5WN2R0NExjdmdpWGhRQUlNenZ6MExk?=
 =?utf-8?B?VGpxTVZpWHd4ZEtmYUVtZE9TbjdJdDIvczRpd2pXZEdoNk9wUG5zUzdYU1Ay?=
 =?utf-8?B?dkFKMzFGRXNLdW51cVkwV2t5MW14NnVJUUYxV2JLVEhIbWZOS2pNSEtTRUlt?=
 =?utf-8?B?Zk5ONEdyMHpSM01xWlYrWWduWjdGZzBvRi9veDFHQlRjZHlqNklVZTlnU3Mx?=
 =?utf-8?B?UjE1aFk2UTZISFVwdzlDYWlCYlNNQUNTTWlQbTdjYnJIOUZaZnY2NkpxMEQ3?=
 =?utf-8?B?UDdyQmR4dHZBRzFXdFJOeks2cFR1dDkzTVgyN1ZTWDh1NjMxcHFEUHVvcXJU?=
 =?utf-8?B?TmpqSUdjZ2srUFlqR3ZaRWN1OHdmNVBoRTUybEU3T1cxYVFleFRTZ25jVDBL?=
 =?utf-8?B?eDhGS1oyMm5DUGlUeHN1RDVxcVF6RTR4aTlUNkxNYk5IQXpOSkhWckZuaUx3?=
 =?utf-8?B?dEtSNmwrWEhrTTYvUGd5MlNJNmZqckFIRC83S0NCWnd1dmZIMW9ZTlpsYVlv?=
 =?utf-8?B?bmliZ2JNRFVFQjVtdlJ0N09QalRzckRqMkcrS1lVaTFSOTVGNGx3dmd1MUJx?=
 =?utf-8?B?VzBoT2IzdWZzVmg4TXBlSjRVa1dCWCtNNnhiZmF4bzY0SldVc3VZamZwYW4z?=
 =?utf-8?B?RVhNTGJSYlRJdUhUZU4vaUkxUlNwQkU2SlVjTFV3dzhydUJyVWpqTlg4Y1hT?=
 =?utf-8?B?KzRCaUlHS1U0aE1sKzNBaXdjTG5DcHJpamxBUlNlbGRtOU1kUVFnenQ3TytO?=
 =?utf-8?B?QStkTHg2QzV6OTFFQ0hXc0wxbGJsRDBjaVE1YW5BRnNwMThPeWZMYlJoTXZR?=
 =?utf-8?B?bFJ5R0t5c3FNNjI4TFlvMWI1U3p3Y05tZlpLdUQrSTkzbHc2Mytkdkp2ekxI?=
 =?utf-8?B?Z1F4Rmk4aEFDanc1amo0RzgrVlBtcG5BNkFoUkpJWm5kQnB5S1VEeTZCeVFs?=
 =?utf-8?B?bjRvWnhmNlNZTTl2cTNWV2FPQm9zTGZldngvOFlKMGFMVEttZGdYek8weGNx?=
 =?utf-8?B?VUVCWGFSUkpDNmx4ZFdiTnAxaGxoM3UzYkI1clhtQUZKdFhwTDl6S2x3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdrTHJaalZDbnhMUXRUZm1rMkZLZ1ZXZEovVVpOZkp1NVlBaWp0ZUdDUU56?=
 =?utf-8?B?ODVWRmV0dHFzNFJ0U0V2UzJldmZ0TWR4dFp4aFRkUmtJdGl5WmVXUEtNOVNq?=
 =?utf-8?B?bThLTFlBVDlybWs2aWxwT1Q3amhrSmJURzMxbWZEOTlaY05Xd2xNYVNUYm94?=
 =?utf-8?B?WUtpWUVrc09jQTQzTzhZZ09Gb0IxNlpMMnkxUy9CODR0K2h0KzdrMmUvbzlK?=
 =?utf-8?B?d2orVzFnbW9lZkovcmtvM29NVGpId1Fod3QvSDhHWVYzdS9oaTJRK2t2TmlR?=
 =?utf-8?B?VGFCK244UUpiWEtNVXdDUFc4S2MxZE5zZ09YaUh0YUxnQXpxWVJPQXR4eTVY?=
 =?utf-8?B?V2phb2U2WlNrTlZBc1ZTZzF0a09ORzdKQ1ZaZUsxZExmcXozMGlRalVTVC9X?=
 =?utf-8?B?SEtiazlmTjZqMXRBOTN3UHJIRU9GR2VhdlRYSTFzbmZjdEdEZnFlVm9EanFq?=
 =?utf-8?B?TnQzSFN1dTQveHEzb0svRXZsZkl2aU1UckwwY2RkeElSdmpQbUt4WHVVQTUv?=
 =?utf-8?B?cmdFWnJ5M2lXVGRreWRlempYUk1JaVVlV1c1amc1Y1U2MiszbDZCbkllS0Q5?=
 =?utf-8?B?R0lsUlErSXdsR2FlVUJVcHFaY24rdUwxWUpObFJvcktJWUFDTStPN1VrYVlm?=
 =?utf-8?B?K0xOdE9MeVZnWGlMZEtrRktkbUpYMHVSU21kK0t1WnZORW5RM0V0Q3dwdFJR?=
 =?utf-8?B?ejNQSmJRUDRXemNyL2xNRDdRVmpLRmhlK0pzR2FIOWcrQ3NjVGJSckNPUGNj?=
 =?utf-8?B?K2FLSVRtVGtrb1E1V0t4cDhmL1czZ3M5Y1ZsQkF0cXFqSjB5TmhJVkg5b0No?=
 =?utf-8?B?dzJ1cURpMzhsdERXaFVyQW9ObWRpbzBEU2tvQnU5dGxubFVyd2ZUanoyK1pU?=
 =?utf-8?B?VGR4N0dYQm94VHNWWU02cFRWdUF4QTJCaGI0MXVWaXhKUFhyOGpuUGZoRmpr?=
 =?utf-8?B?bVlmcWMxdWtTRE1MYVdBd2RHTzI4LzM5NVJyN3dPZUlRQU1GYmZYcUZ5bzh5?=
 =?utf-8?B?S25McFlyUWY5NW1EUUNvSTRwMThLdmhCRWhQNkp6bTJ4L2J2SnZ6MzhLRzRs?=
 =?utf-8?B?eUlEUUVDQ2hjNmJyU29GbmpjRktKVEhqRHNLQnJaOXhlRUpjOXBpR3hrdWdD?=
 =?utf-8?B?ZUdYazQwRStycFE0Y1JReXd4SEtQRUppWncwMTZZaFBUbDNtZDFqbWtqUEZm?=
 =?utf-8?B?cS8xaXhMTWE3Q1BCRFRxKzVYb21xN1VlTUFuYkJWQUlTR1gwSWN5SWNHUTBT?=
 =?utf-8?B?ajdQa1ZMUDQwMUJ0a2NqdTNzWlJ2aDVqUDRRalg1MnBsa1FnUHZoRVJtNExt?=
 =?utf-8?B?Ty9SMGZCVm1jNWZ6Q0k2SDdXdVpZMHB0OHBxa21uL1R3NVM5bkc5am9EVTRL?=
 =?utf-8?B?Nm1MOFZUN0ZsVlozSDc3WDNXb3MrSTdpSlVHWk1nT1l2dW9hRGNsMWZpZ2Jo?=
 =?utf-8?B?aHhJN1FkejVPMHU4OGN5Y1dmVUpxRnpVaE5LeTRVTHM5TDRtV09nSy81bHlw?=
 =?utf-8?B?OERZR1dvbGpuYjZpZVNEMWlWODFSdzh6dkVqd3Rwa2dkeFlLNDJWc0I4Z0Jl?=
 =?utf-8?B?QmxHR2dTZXhpOFVIVk1jc2twS1BSc2dzaFh2bktpcHhwWGJoQXZsUnl6RzVz?=
 =?utf-8?B?TEdnWFJnY3pKM0c1R29iNkZUTmM3b1Y4U3dicVd0eGloNXlRMHdyVEowNFRJ?=
 =?utf-8?B?d2RXYytBODJGazE0ZnUzZ0p1UGtJZkxmZ1JNbnpEdFJ6QWtLZ2FuL1cxYTBx?=
 =?utf-8?B?Z205cE1NMDVOcEZOeFh5b2xNVXZpckRwWWlJWUEvaWlUbnFBTGZoTmlDRE1L?=
 =?utf-8?B?SUtsZlRXWUxYMjNtL1F3RmgwOTNEcnRwL3ZyNEpjRnNWc0t3QzVySllYUWkz?=
 =?utf-8?B?ZE90QkNKaEdHeDVYZVpKMGtkaEdzbXIxcjZiL0NmMmVxWVcwRXZZOXB4YU5k?=
 =?utf-8?B?aU54NUw3SVRsamc2dVhEU3N0ekVFZzZ3YlZvS3gxOXYzdmtTdVZDRHBOYTZW?=
 =?utf-8?B?cW4yYTd6bzJDN2VEcEFBY0VBNkZvMzBUemJ1dG9wWnNKTWdRY0RPeGMyU1ov?=
 =?utf-8?B?UTY2aHlMS282TWV6dWFHVkc4b1BiQXZRaGxyc0hDU3VyQ1R6c0txdngvL3Zo?=
 =?utf-8?B?ZGNWenZXNTh4WjM5ZG5zZXdNTHhlNEFta2tkZFRadWRtS0ZXVVBoeHNBdURN?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f41269fe-0144-4b27-1a55-08dced90de95
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:16:04.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txA+kB4P4MOoaG0nIrVsytUQIpHloNY1QCefp17tgwidM5OQscfO8KkgogLktt7O17nIkGX9kaqitUYus/JvL/VEPxAjfTjCHOTsUwE5T/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8823
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> The event configuration is domain specific and initialized during domain
> initialization. The values are stored in struct rdt_hw_mon_domain.
> 
> It is not required to read the configuration register every time user asks
> for it. Use the value stored in struct rdt_hw_mon_domain instead.
> 
> Introduce resctrl_arch_mon_event_config_get() and
> resctrl_arch_mon_event_config_set() to get/set architecture domain specific
> mbm_total_cfg/mbm_local_cfg values.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
...


> +void resctrl_arch_mon_event_config_set(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	struct rdt_hw_mon_domain *hw_dom;
> +	unsigned int index;
> +
> +	index = mon_event_config_index_get(mon_info->evtid);
> +	if (index == INVALID_CONFIG_INDEX)
> +		return;
> +
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
> +
> +	hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
> +
> +	switch (mon_info->evtid) {
> +	case QOS_L3_OCCUP_EVENT_ID:
> +		break;

This check does no harm but I do not think it is necessary since earlier
mon_event_config_index_get() would return INVALID_CONFIG_INDEX if the
evtid is QOS_L3_OCCUP_EVENT_ID.

> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		hw_dom->mbm_total_cfg = mon_info->mon_config;
> +		break;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		hw_dom->mbm_local_cfg =  mon_info->mon_config;

nit: unnecessary space

> +		break;
> +	}
> +}
> +

Reinette



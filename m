Return-Path: <linux-kernel+bounces-333703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AB397CC97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CC61F2233E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE01A01B7;
	Thu, 19 Sep 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrj48LVV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1A3B1B5;
	Thu, 19 Sep 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764157; cv=fail; b=eJ+jpHV8OD/nSsRBRqxct7t0AjB7QanjgJP3Tyn0rdvkjkHA3Oj3Bkqj6hO1v2CZ4nh1V3svrRz1j6yr/WVg0dAZwGr3c53YKPwgzXDq5E6tvU8XHI8kLzps00uXZQ+DOY0G3rwF0YtK3OPC98T4c/HHI8OaKklZa/pjzO1vZLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764157; c=relaxed/simple;
	bh=7JDS3+9JrgvBze9CuuQeEp3DzLE0+MEnFNqPTesKiX0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RgkxN2SOCM08IolGbITDQpp/JxwMpfsWe8eV183so+G+B2XCRDCgQ/9nbuTBnlV6qLofQ9FJKFQP1vo7TcCn3qSLsQ57x+oszIq0guO+p+DlcLrqYFJkCwgM7fGXjMR8O90dsdrcBvq19G7mEs/WkQ69TNNQ+9AASNji6ZQvUZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrj48LVV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726764156; x=1758300156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7JDS3+9JrgvBze9CuuQeEp3DzLE0+MEnFNqPTesKiX0=;
  b=lrj48LVVTXM9pGS6BNal3flKc0A+eCz/6wAcbXKBVqcIJXVkFtEhaZhL
   GaWgGmPx7mFTtfmr9i5xbGUu7bEu34WDp+EAk124uRnaYD5hBElMx8loH
   n1dSOU4Yj7nF8b8GOdrabhIxTBKvu04nG19THJQTX6upmDpzWxGmB6ZkT
   9KiL+/F/EAX+MF4OkWiNcxx8hd4aNnkJI4pZmhSCag4q5caY+HkK2SjgW
   tZGP5/p0JNkMHKjeqoJNfJSfWvVXOzA7v2bd04vJYxj0ZDolkxM4O9dCH
   4Yk6MKkD1dJJFIzzFPe+pwc+YOtztwwCGeV/0aznTzR2qjdanrihgoVeY
   A==;
X-CSE-ConnectionGUID: hEFVqclvRf6i45+jVnxztA==
X-CSE-MsgGUID: Vyo3ZFQxRyqg9ntDKnJllw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29483891"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="29483891"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:42:35 -0700
X-CSE-ConnectionGUID: Ih+vlJsNRYaHDb4f8qkiKg==
X-CSE-MsgGUID: iOZ/2MRrR6e3bfr4A0Z9kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="74965215"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 09:42:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:42:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 09:42:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 09:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gvgbdg179tHZLrdFLfynsCobzjzNxLGFdZldJ5MZnQMmC/Wdq5x4H7MKbqJA5Me4Jmr9scJKZcyojs3BXs/1Bw4715kHziCURlrBEH8/XArdCjMVJz3s/JOiKF+J38Xo5/ytF9RpT0O1ULXxr0Z3lmSgN8XMSCjAgil8nKGVmIBgquTzKzRao+2ZOpzBbGYbyzspLSwh0ge+/z/XPsF9zxycdeUciT3ZP6qD2hxc2WXgKYxtXUmrQa5w/SUd3id0LNF3gEeWwkqBuGmkRe3YAxHVj71A+DGCzeBuwxUiI8fiXdyL365/uJTvUAv/kiQFveRla48VPTW8UhWzL2OOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKeZOjuqz/sFEYVz4OtcujDsI98ewuyvv6kZzEO+beI=;
 b=Q2hB4npuKjTW7Jv6yQwX7ScZ0hlGnKoOBt+lubtrmT1eaF9VtJ288V5BRZUdZp1EQxqxnhFYAqVMVbNKlGNdYVpmzrIEA0n0n2WK547w4xb2T7SL0IQgMOI97N0V44Tja9V4/cRm+aFd4F6JivYeJ63Nq6Q6WWVtH4a0CVBa86kK2Llo8Z11tXHpSywnLgh6bjiuNkzg14ctJijdfdOFcQUH0Es9G8OSWLiM/eFI8fHs4uzWvUtfFzWGIofbKw1L5umyumF2gJey37p8rNv8u5MlOZ3aFn7MalZc544wM5Cw5HxOtn0QnpZgQpUTAb18LpoFE1AyCbd9eW9ahb3xsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 16:42:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 16:42:30 +0000
Message-ID: <50084b31-49e4-41c7-be1e-24773d03d5d3@intel.com>
Date: Thu, 19 Sep 2024 09:42:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/24] x86/resctrl: Introduce bitmap mbm_cntr_free_map
 to track assignable counters
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <a94c14653c29e89bc76727addfcdf1f9c164b95d.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a94c14653c29e89bc76727addfcdf1f9c164b95d.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0299.namprd04.prod.outlook.com
 (2603:10b6:303:89::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: b98f28a7-eaad-485d-fd3e-08dcd8ca0d75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWpHUWZoeDkySUNmVEZJR0xiV2labk93NDJQTXppekFTQ0RHeVNYb0w5Yk9V?=
 =?utf-8?B?b2hSUFlaa2x6bWdMMDVydC9OU1JIcXdrMUp5ZGNkN1NLU0t1UDhzNGUrbko5?=
 =?utf-8?B?MHRVZnpvS3g3b2wySGQ0VG5FOVRGR0hqY0tBUmVyYmdoUWY2cElreEVBS1Y0?=
 =?utf-8?B?clJMc0NZL0twTXNneDhRdHlQNE9JL3BES3JxM2hEMHoxU1hzREt5clpkVEVv?=
 =?utf-8?B?RzUraFp6RlRidVh5Y0xCSDR0TkhGdnJsNVdZbHdXQXNvWVQyc2FobWJpMm83?=
 =?utf-8?B?OWF0UlJmeGNGZEFnOWdjbzJTVXFEYVFSVXZTbTVCbUZXSW4zQlFpV0ZoNzhM?=
 =?utf-8?B?RnAyUmxURjc5MHE4U00xa25aazZkVWR1TTNtYUlXdzFQZmJPSDJNRzZMYU9D?=
 =?utf-8?B?eVZyZUpVbG9HKzIrczhVUnpNaERtV2ZrTzBXSThaLzlhY0FIa1phQi9Pb0xj?=
 =?utf-8?B?L0RJRWIxV05Bb0NKZ1FONDBKdGEvbXk0TWVxUlpKVjVac01kM0M0RmpuZFVp?=
 =?utf-8?B?UUtvalZiZUJCRlFhUTFkRmx3RkVTaDRKa3ZFN1FMTXBjNEJrVTZCeUpIUTVQ?=
 =?utf-8?B?c1NJdUJFc3dTTVdVcURGQS9JTm0rcnNwU09lb3hFZ1ZwK1lqWVFFYTlIVkgy?=
 =?utf-8?B?WSs0NERZYnJFUnFBQlNpKzBRbnZRQjAvZlBZR0d5bXA3VzRZSWE2ZDlOL2Zh?=
 =?utf-8?B?WnZjTmhyUHRsNmdUeEFqSVRCbERFclNOdThHRmk5UHJXczhsRE96TW5zSldu?=
 =?utf-8?B?elpRNlBZY25oaGVoNlBESmYzRmdQYlpqT1ZIMmF5dkJ3T2ZXTStSbkE1ekZF?=
 =?utf-8?B?R2lQUkpidmxtR0tXeHVNSUpSWUpNb2tHV3NoSkRzUzgwdkw1cjhaRzZTbklY?=
 =?utf-8?B?VVgzd2pJUkVlQ2dDZFdaNVFXN05RcW9vd0tzaVNMZk8ydEpNZGI5Nm5idXkv?=
 =?utf-8?B?NG1wSjBoSmh4MHdZZnBxdGh3aXlhMGplU0k0MHpWNmY5THBpMldrcHgzOHdY?=
 =?utf-8?B?S1QwK1VXSmtlL2wwL1NSWGJUTCsyOXZHck5mRWcxZnBhZmt2S25BMWZLdjcx?=
 =?utf-8?B?djJlTVNIaVN6ZmM1WW9LSU9ZeFBISi80SHQzNlc2akJTUkVicHFBUlVYejVt?=
 =?utf-8?B?MlQyN083U3h5NFdTVThnVHo0N1VvSktoT1ViaEZHamp2NWtLeHE3ZzNuYVRW?=
 =?utf-8?B?aTNIZm9XT1JJRlNDYk1EYlBmazlMU1J0UUZGK3JDc05ZOWNLK0dHM2F3Y3dU?=
 =?utf-8?B?NVJ4bFBqaUwvaytKb1l3azhtaGtsSjdnQzFFS1NPWjJNZllBVWpFOWJzcHJ2?=
 =?utf-8?B?SG13aUFNSnRrZzlmRllvOEUya1pKUUZZMTNma1RZSzdxNStlM1k5TXJ1SHp4?=
 =?utf-8?B?N0MxVnZKVTAvTjhyVlRLT2dBamJBR0NGQ09oelc5ZFg5K0JZeDhENjd4VEx1?=
 =?utf-8?B?eCszcFhLNTRHNm9kQ3ZjbU9aREVid1VFb3BqT1dYbEd3Z2owVTZTTWZkbE1R?=
 =?utf-8?B?eTRibXI5eVdkMDNjd0UrR1lDU3FIU2xHdDdqKzN0MFgwSjJ0THh5ZE8yRitU?=
 =?utf-8?B?SWhPSjhVeWVwbmpnMEE0bE1NdW9LS1VSZ0FIOVFnc21LclhqOHphYlE1cjJW?=
 =?utf-8?B?Ky9zUDF4cnR1Nnp1YmMwNzFSQzQ1dGJpcnJYM1JRYWx4RDFJMXNUVG5rSTh0?=
 =?utf-8?B?L0ZIQXA1VndpYm1FN25VSHpNcjFPSHJaUFNuN3BnV2wvWXlzaG1sdEFSVUUx?=
 =?utf-8?B?VEF1VUpzYzgyUldWZytmejEzWEhFZXAxUFZNVEZUbGYwWEZiVDhuaFVrOUdW?=
 =?utf-8?B?V3l0Zkt0L0lpdDNwdHIwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpRMFRSSmF0RWZ4TFIvOVNxamhqZ3luYis5S1BqMFdwaDVFVjlLRjYxSWUx?=
 =?utf-8?B?WGhVYjN3ZlJ3b1VlcENSSWpQeVdnTFRzMDYvN2RYN09uNjZGQ2s5TElCUEp1?=
 =?utf-8?B?Tm1pOWxDcjZHOHo1R3lBcXQ2ckFRRE9MN0FlU2RXNzJFSGpwRTJnVkdkeEYy?=
 =?utf-8?B?R3BSSFJjRnVHUkxOTlBsTnp6VnNqRDg0M1BLQXVPVG02TC9xNWowMzFhZTl4?=
 =?utf-8?B?ajdHUExIbXpBVWJhRmlFRVBrMU1rc3pzWUt1Q2I0bnRqb20yd0pmZGM1TUVJ?=
 =?utf-8?B?Yk8yYTlrelNJSTY0TG15aUdWMWozVUxvcS9VRUlPU1JMR2VEQ2hrbCsxeUxu?=
 =?utf-8?B?MjZVZnlrVWJCQ1l3TTdWS0loeCtaeGExQUpIbU5naVhPOFNham90OFpKRGth?=
 =?utf-8?B?TFhyK2t3SU1qdG01dWRreWt3YndyUVVaOGk2dEVkeTMvT3dtY2NwUlN4VGgy?=
 =?utf-8?B?ZGhsWlRkLzRlWTdoSTE1ZFcxWnpRaGNHWkhJdXd3M0d3Qlh3c3pCNUlOb3VN?=
 =?utf-8?B?a3R0dVBQT241QTJCMzVjd2NDZmoyTWFPSUhxZFJDbEdhZ2ZXbmExRVhnWGhL?=
 =?utf-8?B?R2d6b1Q5VGpXTXFkVW8xRERXTVZ5dnpoeEpmdDdZcnpwc1l6MW93WW8wSFI0?=
 =?utf-8?B?ZTkzUnpkZS9tS055aWZROGZ2YkJhSVJDU2JvQkhoZjBmK1djOVpuZ3p5dG9B?=
 =?utf-8?B?MWpWNkFoelRhRkNPN1lWT3JVMnpBSHVlS3J1L2JlQ3ozcDRWWEFSS3dwQ1E5?=
 =?utf-8?B?Q1AydjZCUUpJd0lsRG1kbVE2amQ3dGlXcy9HY2M2YmlDL0lFSHE0VFcwdmJP?=
 =?utf-8?B?WDBqSnVpRkRXT1lyOUU2UjJPbW8wcmpqbU1FSnlmQ2p2VDBDZ00zanltRzlS?=
 =?utf-8?B?VlM1RXBzV1FPSzVRRDRISCtuUTRERk5KcGUzNkVkdENpL2VOQVIyU2I3YmZo?=
 =?utf-8?B?UkhWNUU3dE84cUNJaFBNNklXR0ltcmRxV0tidis5UWFQQysvc2x6V3lLaGxQ?=
 =?utf-8?B?azIyYWZCMlJtSkdRR3dJV2MvYzdHdThhSHZtOXA1Zlg2Skt6RENwMDJNK3lU?=
 =?utf-8?B?NTA4dUxkT3Vjd21EWElEcnVjZmpKa2lEcE5Lc05aQlFwM29Ja1ZEcUY2S0NJ?=
 =?utf-8?B?anZBaGc0UjhXY3l4NkljMDE2VzEwdjBGL2ZnMi81bTZjWlY0UkJ4clFBSGZ1?=
 =?utf-8?B?NUN3WWpzRmwwcU56bVlXbU4wTTNNaGJqbEI3R2h2MlFBZmJsSHduMWpsbEs4?=
 =?utf-8?B?R1hsN3NKWis5SGxJVENkSE5lRFZGWmhZcUlOT0FIQW05NEc4UlRhYkplMWIx?=
 =?utf-8?B?SHhWczNuV3VPaUpuVFlsMVA0NUlMQXFNQzUyR2RsU3hVNkJyNXkxZ3RPYThu?=
 =?utf-8?B?TjJmdG51N0NOT3ZmYmxXNWJFelE3UVN6T0FaMXo3M2VZaEw2MWFzVnlpZTVH?=
 =?utf-8?B?RWxUZlFBVEhEZzY0b3BiUVRUY1haelU2R256Z3JHMjkvaVJvQVdRMGFCOTB3?=
 =?utf-8?B?TGljWDVROTBYaFd4NkZMRlBsWW5VMCt5YVpwV1VJWTBidE9aem5QaDFLVGVV?=
 =?utf-8?B?Smk5Yjg4MXQrdTBYTlBDSlFUV1VKWDdyOUM5N1FhSi8xT2VYSWhVbHc3VXdv?=
 =?utf-8?B?MndaS2JoZllheEhockgvaDN0NUMzZDhpS1N5TVQ2WEdQMENiM2o3T0xJYUND?=
 =?utf-8?B?YktMc1NuRjV1L2NnaXltVGQ4ck40YVREeU1tYndCcFV5alFHd3JkYUxicStH?=
 =?utf-8?B?aHVxYXFsckZabFVnZUdCTkpjeExjWm53SkNqZEhiRVAyemJlTUcycG1OblVC?=
 =?utf-8?B?cGYraW9LUStEallyMDZ4NjgyRUFPUHpEWlJjTlR6WFc4OEw2dW9pRG0wQzR0?=
 =?utf-8?B?K210WVdnSDlXdDRBQTdEekM2cHhpSWJuSjNnbEJYKzMzRVZFK0d4Wi9HTUMy?=
 =?utf-8?B?ZXMxRC9zWDVCdFA2YVdRVk96YTVRNkZ2WXR6UERpY1ZwamNsaUxqVkVzQUVq?=
 =?utf-8?B?cENFRStQSkpxS2NteGQzNFZYeGZXdUxMYWhSUWp2dDN1NTU2Y2hROGF0MUZM?=
 =?utf-8?B?ZFBFeW05cDJ6RTFrWndyc2p0c0ZabG5nNGliRS9qZERrc1c0QkpQT1Bhd1pR?=
 =?utf-8?B?Wlc3RDI3QzZBd1JoSXIwTkpBTHVRTk83OTk5VjdQRjZZU3hsaVVrMXFmODlw?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b98f28a7-eaad-485d-fd3e-08dcd8ca0d75
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:42:30.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBg3RNAOaT1OZhd33ITkwGf6OrZxZKahPvFrZAoyYEQvOU8PFiVpNQHT09krzo25b+0tlejTASH8ontNtDhJgmUsPsm7Lt1eufTN2BPcy9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> Hardware provides a set of counters when mbm_cntr_assignable feature is
> supported. These counters are used for assigning the events in resctrl
> a group when the feature is enabled. The kernel must manage and track the

The second sentence ("These counters ...") is difficult to parse.

> number of available counters.

"The kernel must manage and track the number of available counters." ->
"The kernel must manage and track the available counters." ?

> 
> Introduce mbm_cntr_free_map bitmap to track available counters and set
> of routines to allocate and free the counters.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index e3e71843401a..f98cc5b9bebc 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1175,6 +1175,30 @@ static __init int snc_get_config(void)
>  	return ret;
>  }
>  
> +/*
> + * Counter bitmap for tracking the available counters.
> + * 'mbm_cntr_assign' mode provides set of hardware counters for assigning
> + * RMID, event pair. Each RMID and event pair takes one hardware counter.

(soft-ABMC may need to edit this comment)

> + * Kernel needs to keep track of the number of available counters.

Last sentence seems to be duplicate of the first?

> + */
> +static int mbm_cntrs_init(struct rdt_resource *r)

Needs __init?

> +{
> +	if (r->mon.mbm_cntr_assignable) {
> +		r->mon.mbm_cntr_free_map = bitmap_zalloc(r->mon.num_mbm_cntrs,
> +							 GFP_KERNEL);
> +		if (!r->mon.mbm_cntr_free_map)
> +			return -ENOMEM;
> +		bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
> +	}
> +	return 0;
> +}
> +
> +static void __exit mbm_cntrs_exit(struct rdt_resource *r)
> +{
> +	if (r->mon.mbm_cntr_assignable)
> +		bitmap_free(r->mon.mbm_cntr_free_map);
> +}
> +
>  int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  {
>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
> @@ -1240,6 +1264,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  		}
>  	}
>  
> +	ret = mbm_cntrs_init(r);
> +	if (ret)
> +		return ret;

Missing cleanup of earlier allocation on error path here. Even so, this does not
seem to integrate with existing dom_data_init() wrt ordering and locking. Could
this be more fitting when merged with dom_data_init() (after moving it)?

> +
>  	l3_mon_evt_init(r);
>  
>  	r->mon_capable = true;
> @@ -1247,9 +1275,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	return 0;
>  }
>  
> -void __exit rdt_put_mon_l3_config(void)
> +void __exit rdt_put_mon_l3_config(struct rdt_resource *r)
>  {
>  	dom_data_exit();
> +	mbm_cntrs_exit(r);

There is a mismatch wrt locking used in dom_data_exit() and mbm_cntrs_exit() that is
sure to cause confusion and difficulty in the MPAM transition.

>  }
>  
>  void __init intel_rdt_mbm_apply_quirk(void)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ba737890d5c2..a51992984832 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -185,6 +185,25 @@ bool closid_allocated(unsigned int closid)
>  	return !test_bit(closid, &closid_free_map);
>  }
>  
> +int mbm_cntr_alloc(struct rdt_resource *r)
> +{
> +	int cntr_id;
> +
> +	cntr_id = find_first_bit(r->mon.mbm_cntr_free_map,
> +				 r->mon.num_mbm_cntrs);
> +	if (cntr_id >= r->mon.num_mbm_cntrs)
> +		return -ENOSPC;
> +
> +	__clear_bit(cntr_id, r->mon.mbm_cntr_free_map);
> +
> +	return cntr_id;
> +}
> +
> +void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id)
> +{
> +	__set_bit(cntr_id, r->mon.mbm_cntr_free_map);
> +}
> +
>  /**
>   * rdtgroup_mode_by_closid - Return mode of resource group with closid
>   * @closid: closid if the resource group
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index f11d6fdfd977..aab22ff8e0c1 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -187,12 +187,14 @@ enum resctrl_scope {
>   * @num_rmid:		Number of RMIDs available
>   * @num_mbm_cntrs:	Number of assignable monitoring counters
>   * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
> + * @mbm_cntr_free_map:	bitmap of number of assignable MBM counters

The "number of" is not clear ... it seems to indicate tracking a count? How about
just "bitmap of free MBM counters"

>   * @evt_list:		List of monitoring events
>   */
>  struct resctrl_mon {
>  	int			num_rmid;
>  	int			num_mbm_cntrs;
>  	bool			mbm_cntr_assignable;
> +	unsigned long		*mbm_cntr_free_map;
>  	struct list_head	evt_list;
>  };
>  

Reinette


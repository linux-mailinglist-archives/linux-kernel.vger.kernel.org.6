Return-Path: <linux-kernel+bounces-512054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36385A3336A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FC4188681C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BC720B1FE;
	Wed, 12 Feb 2025 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbixEkyO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA051EF0B9;
	Wed, 12 Feb 2025 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403256; cv=fail; b=cUXFddt7NlaOTJXI/70FEJyvU9fKKhrZrTBk4JnoNgWbo+rFBX6BlwSaEQczywQiMZApOIWgmT2ApbKJI7e10OEsF3VyfnnnHEwmM7F+Hc86FncMdBk5LQVV1SPmmhPyHK6SzbYWLB18O30Bs2kYVzWnHweN7AGx8z0WlEn6sQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403256; c=relaxed/simple;
	bh=Unk3/2GcJXC0xDVMTCfZH0xvWNWdZ1dnFBp0wfTgWZ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bF5NYI6Ydk0ruT9XHkc7urSm12/sgvy2ntxLzptxdQOIeyGE0m6Fjr1/Ul+skKYVQYCXUFsjdrBWPxhQFKtSTMeWULi9eJHnWgBsPzG6yOxSRLRgy6PTWpN0p7nMum4V0bifMU+zYVkfOdGR0uJWyBnI08ZDbTbTWi/JpaMMTJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbixEkyO; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739403254; x=1770939254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Unk3/2GcJXC0xDVMTCfZH0xvWNWdZ1dnFBp0wfTgWZ8=;
  b=VbixEkyO1IWkEOpWgjTDk/YMVGv7AuhQUq0DRX+zf6KmJfmw5EPbg0bC
   2HAwz10bGOTmqWL7S1LeTQgVa302WvHiSJ/zc0Fgo/MV3exwTK26eSDDS
   HM8e8MiN/r8E5xGj8y32Gbq7YD5FVvNOHVgbvXzLow77//9YgyIHd8Ww3
   R2dXreX6tIK3OOrwdPH08fJxidJ3vfLr6Y8l2USBLyzZ1d8i1WgX7PeMY
   97HeGeVKwpB/dGZ015uHwo/XbJ+ttqbD7QFE9JZ4+45IrWH1okrIrJipx
   OhtucCwvy2eF3SGdrJIn5RNfvo2vOIErJarRhdN4PR/H1/oHi2UcizZ5p
   A==;
X-CSE-ConnectionGUID: q1kiztFuTBeNHpMPYcb6Xg==
X-CSE-MsgGUID: tm+P7AL9Tqebo768Nc50HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39965170"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="39965170"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 15:34:13 -0800
X-CSE-ConnectionGUID: apvGeP0HQDGkqimakeZV4g==
X-CSE-MsgGUID: NlCX4lTDQt+S+7YRV3NLWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="117974731"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 15:34:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 15:34:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 15:34:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 15:34:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcUnpPpgZuGWvecK8GuW5DHMv70jR4LFHRIHjU7CmVLsjt4xW1PgQPUfiQv6Q0jg8B6R+VI6+pShsqMdQFE1CvgqIR5FzctVSeLjP3KjPRKTrKbaaGDSfK2OR23DHOjVbYCKSzwScZCiWlBwaWGgEna370vG5yxrCf///sBMrm2ydPp5mSX1wh91tD9phFUmAd/WXyC0yW/GrunsQGrU1XVV+7nFWPP6DrNVij5+YkJxJZ6uTAKYjTTl/7CWB3bG67SM0M1/rcL1GHgVJVxOOoNQBPR97G4rm1pCoj/1faDkUu3GGTyocP81Ijjt3uOP53ZowquZDNyy76DZu4HUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFYPd+TxhxAd7BjIqDjl0AAEFeY1Ho3e05RlwoUuud8=;
 b=WIFnuby6WO7nQOwryuH8M5qxstsAnQvLy3eFY9ksstE6sRUDKBsxHBPqUbDbfKA83sk7l484JXEoFnVJPpUAHMPs3oXR1JNuYK97LtBTZ6gxgthzvAyfpuSC9z1Sr8/mPgEHppvBceLPtzAa+X1Nr7szfHOXzbBy5ry6GILrlEOSj1TXqkQ36lFVtc8rEpjWDw7Ek0QfOmnppybkZfzuYSQTYG/YrW+Vq8t87iej+4doJQsNgPwFh8z7dy2N9UbWTzkb2icFVrJvtJYav+Kee0POFAr08QzA/r1r8OuevTDINCT8Fj0M8E823URg+mimXK74CRTOaZehBCbDiXtVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 23:33:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 23:33:34 +0000
Message-ID: <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
Date: Wed, 12 Feb 2025 15:33:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>,
	<peternewman@google.com>
CC: <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <tony.luck@intel.com>,
	<fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <Z6zeXby8ajh0ax6i@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:303:2a::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 3157fb15-e1cc-4b54-6fdb-08dd4bbdaadb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3hBd1BrQ3pSTGFwZWdtQmhydWNOd3daakZ2elVoakVaWVlLYmdOTytTS2Jo?=
 =?utf-8?B?L2JvQ0pXTFFtalo0WlBtM3YxNi94VTZTb2tkeTV4b09VTUthNnd4TlBxc1E1?=
 =?utf-8?B?MTd1UXc0c0kzVjh4NG15Vmdkbjg0bHFZWjFPNUZXb2dmU0ZsMW92QlV6WUlW?=
 =?utf-8?B?L3JQRXpMWGtzN1BIT3JCaDNjWExqOEFLRzU1bjFQYTRRdThuMnRKd3F0dzVN?=
 =?utf-8?B?ajRqSXgwRkkrUkZOUDJJUE9iM24rTWd2Z3IvTFZreHFEY3ZQOGo2eXRrRTlx?=
 =?utf-8?B?LzREOUtSMXkvZHRJTGd0WlFzdG0zQVZkOFdtZnRpNXZKcUY4Z0JVdlgvMjhG?=
 =?utf-8?B?Zm5ENElTaHFBa2ZTb0JHbU9BUmEzRU5aWnVmUlM4VE82Z1VRVTZ2Q214ZUdu?=
 =?utf-8?B?SkVTbVhUTWdFc0ZkRWR2Z25SNlJGSlZSc2JaUzlITUV6S1JxNStuekFlY09Q?=
 =?utf-8?B?TDVUU1FqNHptOVl4ZW8xeTdUNzlTbStlVFJXTldFQTVManJsd2VETHNxSnNz?=
 =?utf-8?B?TWpsRXMyeGNFeGNiSjNWOW9iMGsrNGZseTZmWDFhM3ZDR0x6eE5LS04wcGk5?=
 =?utf-8?B?WnhWVXJOdnFpckF6YXlVZUQ4RGdKRGYxRy9FbXRjQXkyUldLcmtDYVp3NFhq?=
 =?utf-8?B?eGxsUjRqZnZDZGVqV01NOU9EUE5NQXV2K1V1UmJrNnA1VjdFVXduWkZtNjBS?=
 =?utf-8?B?NlVsd1dndU9zOFhmQTVKM0tXczE4ZVdGWEVYUHZkb0hQdHVCQ1dwZ0hiS3B5?=
 =?utf-8?B?cTdBdGlBNnhnVzZqREVrMG9IcGwybGlRODJUOURYK0tJMmZBMWtuL2p1Y05w?=
 =?utf-8?B?VHRzY3VGSTNrVVJxbUNOaGlQaTlXRjh1UmdESXR6Qkp2a0FKeWExamZ6Mnlo?=
 =?utf-8?B?SHdjVGZMSk90RitDZEhWYzNTeXhWcDNiM0pGS1hRVzkwNkFQQ2poQmpNYllJ?=
 =?utf-8?B?ODFFWE0ybVNScUlJTEtHclVmV253ZUw1RHZSTHc3WDBWQkVxN0IvUlMwWmhF?=
 =?utf-8?B?TnEyL05pZjY1WURKZjgxU0hKbVlUb1pjVzFsdG55N29MbTdSWVFJYzNHbjYv?=
 =?utf-8?B?U1FtUkIzWWZVL1RaQ1dYN0ladE8xS1ZHTzM5Z01LR3ZlU1ZIRXM0SnhYYlNy?=
 =?utf-8?B?RWlrMk5WcTNUUTh2cXlFNzJ6c0FGdVRPYzRaNDA2M1RnOHN3c3EyRzdDbEtj?=
 =?utf-8?B?MG11ZmtPWEJDc3AzNG9wNExtTXdBVXBGUUU5b0RudlhrdHBFUGlTWjNCbjJS?=
 =?utf-8?B?SzRFZS80SXdTUHhtZ3d4c202d1VWY1JnWktIeC8ydHdyeHQwTWEza1FoQlEr?=
 =?utf-8?B?eUkzRENELzY0QlVzejBoS2JQL3NRWGt1ait0cGJLUTlKbzYxbXVaSVZaTHFV?=
 =?utf-8?B?anJiQ2pMTlhObDVYMUNVVEpHSk5RSFJaS0FOV05XbUN0QUFWUllVcHA0U1FM?=
 =?utf-8?B?UVdia3NKSy9uOHBqNU9BdEJKdk92WXhoZVAyZjd0N2NtcDR1UnZpUnZMdEM1?=
 =?utf-8?B?K1dyeTBIMGNIMGlaVjRWOEhnaU01OFlNeWhIaDd1U0daZHBKM2FSZTdRK1ZU?=
 =?utf-8?B?WnBzSFMrcWdUcVhrbUV4aGtKcjdGQkpxREpvdXRYVVF1bnlRMG9KZDY1aUJw?=
 =?utf-8?B?K0hRZ1VLcGxoQVJIdnFFRnJwMSszVnorUHNPTG9oQnZkaWpxSVFvY3BiV0ZP?=
 =?utf-8?B?OVJzMHdnYWY2T3lPdWJMQVUxaU1RVXFBUDFOcHlZMXNtVnJWc1B2aW5VMG5y?=
 =?utf-8?B?a0JZT0hsYzdYbnJlY2hROTdzbWJzaUlRbHJ0WDFuS3RXeXVOVHpjVWR5WEVs?=
 =?utf-8?B?NHZSN0w5TW14S09xck1XQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2lqZnpJMW1CSG5vZzdWTm4rTzIrUEZ0bzZOOUl1b3VCampXMCtLNktHdFJQ?=
 =?utf-8?B?SS9FZnZUTVRyaW83SEJxcXJzNHkxc2hRcHNseXRIQzBwVm9TN056dVU4MUE0?=
 =?utf-8?B?VDdOSkNmL3FCaUVPOHp2bHFHeFBVdEJvbnhHUFlpTEhLa3o5RVRkTGZ1ZTNs?=
 =?utf-8?B?NU9MZFRHMnBiemk2cHd3alBkR0F1ejZqUG9MeEVEQ2R2L1dvT3V6VSs2NjFt?=
 =?utf-8?B?dVA1MnJvWHVzQkdEK3dOeFlSS3NyWWhxR01SNmRNeGYrSWl3WFA4RlVwSDJl?=
 =?utf-8?B?dlk0S2dwSGF0V3QwNmhKTmM4a1N3WE9zV1kza1JzcWI2alI5TWhCcTlidHc3?=
 =?utf-8?B?cDR0U2h5SXVJWDRTT3d6V0NZQVpSUFQrdkxYWlRFdlZEYXNFdmROZ05CTU56?=
 =?utf-8?B?VVFOU0ptOGxZNFN1RTJmQ2ZBb1Z1dTdIdjBUNStlNndBZ3hHT01tdjYwUHNh?=
 =?utf-8?B?UUVJYldhYSt5d3pGNUUyRVp5bkFDVnVsdHNhb1dHaWQvQ1JzWk43ekQwYjU0?=
 =?utf-8?B?MUN6UVp4RFI2RmtoV24zOEN2Uy96aXVmS0ZOZHNyd0dVMktSeFU0SkpuZGd1?=
 =?utf-8?B?NmlOOTFVQUZGaEhqdGRVeHpiYkJRL1U2M0xBTFBiN1dmWmQ4d2RZeHk5NW1o?=
 =?utf-8?B?b1FrVmcyWS8yamhkNitFL3p5NHQvOHdLcW1NUnVsUWVOZTY1dVdnOUJHdGF1?=
 =?utf-8?B?cmtxeTB6MVlBMUpWUVo0SHNEZnNYbDd0aVNrYXZEbmdHOEpsVnByVzdyQkpw?=
 =?utf-8?B?TWNFR3ZQcm9wQVBZdWZ6ZHJna3Qzb056ZVp0M3ZhYUl6blVPLzg3VVZqRkdW?=
 =?utf-8?B?NUN3enRJWGFUa1hGSDA3ZHBMZExUMWREYnh4eW9FdzZJM3NtMWtXZ29JQ3pV?=
 =?utf-8?B?dFZFQVhrakxaTDR5UnJMZXA2T2pnT0hubDVNZFRNZGFWQWJnaGJKQ0p6TWps?=
 =?utf-8?B?YUNFam9LWlZoSmp2TkwrUnhPbVlBdHBKRVRUbkUwL015Wlh5ZGJTTHZyL1ZG?=
 =?utf-8?B?bVArQXhOTnkxQnhCMU83aU1PS25PL1ExNFdjM09PeVJOQ1Z3bTRndURudENz?=
 =?utf-8?B?WGhUUzRpQWJmaElmZXFnaTZYOWNNZ1N0NG5uNmZKNHh1b0VZcjIwYlMvTzZ5?=
 =?utf-8?B?RVhrRG9GTGZHbk4wdlZ2eUhDUHNwTXVjVDk0Tk5PRXdpdXNWRWlKa0pEM1hL?=
 =?utf-8?B?ZklhTzB4LzBUdEVFUnREN2NaY2piLzI2c3lyNUx6ellJM2tzMlZ4MDl5RzAx?=
 =?utf-8?B?OUdzUU9SY3RqeWhSV0lSN2ZCT1ZQUW9DdTdRSEtudXhoeDdvZEV4TUJPRDVU?=
 =?utf-8?B?cWdZSWpERDBNWWtHdUI5YWo5SmxEYTV0MExHQmhjeUlMNEZHeXdrWFVVMUxN?=
 =?utf-8?B?OUFPVWlrcFppR1RPdTRBbmpzY1lXblBLbUJTRjlESVFyYSt2MGtRaGZlU1dv?=
 =?utf-8?B?bzNTdzBrOS81MlIxb1dOMDRDUmFkZis0TzNKQnBrbE5oeURDS3diMVhQSVhp?=
 =?utf-8?B?Q0lUZnQvbXd6UWxiR0xMMml1bGFUMGNxdEFVU3JoMHE2ejlLbzFhTjEwZkpt?=
 =?utf-8?B?Yy8yYXp3YXJLMnorN1VEVWsxdmJ1QXdSWXVOclVwNi9KZktINEtqdlkrcHd3?=
 =?utf-8?B?QXVoWmtreWhoUmtYb2hJK0VtK29aYk9NNnhHTkJVK0trTm1xS3JZMlN6N094?=
 =?utf-8?B?QXRGc2NEdzl5aENvK3JXQVdTSGNjejA0QVNKVXA0Ty9LQW5oVXlVMzFSQ3Zp?=
 =?utf-8?B?ekdPb3YwVFBHb0U5VHdkTmdKeFNmcDVzZHNIRUQwM2ZMS2ZHUVJ3SG45enBw?=
 =?utf-8?B?TkYvU2RERGI3Z1FSYzJWdHQxVFJxTWZXT2lEbWx4dkR0eFVFbkVaSlROTVBR?=
 =?utf-8?B?S2tsdUtsVkxnWGZGYUxLb0l2RVphM0ZBMFFUWjFNUHR6VTNWdk9GN3dSdDNL?=
 =?utf-8?B?a25ZZDhQb0hSUys2K24zUGZwTWVCVUZvNlloOEpvOW9WaGU5WEVkZDMzYmto?=
 =?utf-8?B?MWtGZTNYald1WWVRZEFSbkFrRHNzWkRkT1k5N2NQVnhqN2g1dTBwbkt0K3Y2?=
 =?utf-8?B?VDBWMjhENmpLd2J4V2FQTDZPaG42d0JUUElpQkNqVWhLMEtNdDUyMzFub0Mv?=
 =?utf-8?B?YklYaitrSVlJT3RsNUx2M3ZMazlRRWFRZVRDYXFtZUxabzVGSkVFTUVORFZZ?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3157fb15-e1cc-4b54-6fdb-08dd4bbdaadb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 23:33:34.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeIx4FpLNqRmurpMeJy/rvQLQ9/pcYoONwXOIhhrUMKshxgMRBLI3RLG34m2lWyBh6kEqu7p8QuOyQsGdXSs1bfRxhlBWQUbStMEjr8O8Ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com

Hi Dave,

On 2/12/25 9:46 AM, Dave Martin wrote:
> Hi there,
> 
> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>
>> This series adds the support for Assignable Bandwidth Monitoring Counters
>> (ABMC). It is also called QoS RMID Pinning feature
>>
>> Series is written such that it is easier to support other assignable
>> features supported from different vendors.
>>
>> The feature details are documented in the  APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC). The documentation is available at
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> The patches are based on top of commit
>> d361b84d51bfe (tip/master) Merge branch into tip/master: 'x86/tdx'
>>
>> # Introduction
> 
> [...]
> 
>> # Examples
>>
>> a. Check if ABMC support is available
>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>
>> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> 	[mbm_cntr_assign]
>> 	default
> 
> (Nit: can this be called "mbm_counter_assign"?  The name is already
> long, so I wonder whether anything is gained by using a cryptic
> abbreviation for "counter".  Same with all the "cntrs" elsewhere.
> This is purely cosmetic, though -- the interface works either way.)
> 
>> 	ABMC feature is detected and it is enabled.
>>
>> b. Check how many ABMC counters are available. 
>>
>> 	# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
>> 	32
> 
> Is this file needed?
> 
> With MPAM, it is more difficult to promise that the same number of
> counters will be available everywhere.
> 
> Rather than lie, or report a "safe" value here that may waste some
> counters, can we just allow the number of counters to be be discovered
> per domain via available_mbm_cntrs?

This sounds reasonable to me. I think us having trouble with the
user documentation of this file so late in development should also have been
a sign to rethink its value.

For a user to discover the number of counters supported via available_mbm_cntrs
would require the file's contents to be captured right after mount. Since we've
had scenarios where new userspace needs to discover an up-and-running system's
configuration this may not be possible. I thus wonder instead of removing
num_mbm_cntrs, it could be modified to return the per-domain supported counters
instead of a single value? 

> num_closids and num_rmids are already problematic for MPAM, so it would
> be good to avoid any more parameters of this sort from being reported
> to userspace unless there is a clear understanding of why they are
> needed.

Yes. Appreciate your help in identifying what could be problematic for MPAM.

> 
> Reporting number of counters per monitoring domain is a more natural
> fit for MPAM, as below:
> 
>> c. Check how many ABMC counters are available in each domain.
>>
>> 	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs 
>> 	0=30;1=30
> 
> For MPAM, this seems supportable.  Each monitoring domain will have
> some counters, and a well-defined number of them will be available for
> allocation at any one time.
> 
>> d. Create few resctrl groups.
>>
>> 	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>>
>> e. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    to list and modify any group's monitoring states. File provides single place
>>    to list monitoring states of all the resctrl groups. It makes it easier for
>>    user space to learn about the used counters without needing to traverse all
>>    the groups thus reducing the number of file system calls.
>>
>> 	The list follows the following format:
>>
>> 	"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>> 	Format for specific type of groups:
>>
>> 	* Default CTRL_MON group:
>> 	 "//<domain_id>=<flags>"
> 
> [...]
> 
>>        Flags can be one of the following:
>>
>>         t  MBM total event is enabled.
>>         l  MBM local event is enabled.
>>         tl Both total and local MBM events are enabled.
>>         _  None of the MBM events are enabled
>>
>> 	Examples:
> 
> [...]
> 
> I think that this basically works for MPAM.
> 
> The local/total distinction doesn't map in a consistent way onto MPAM,
> but this problem is not specific to ABMC.  It feels sensible for ABMC
> to be built around the same concepts that resctrl already has elsewhere
> in the interface.  MPAM will do its best to fit (as already).
> 
> Regarding Peter's use case of assiging multiple counters to a
> monitoring group [1], I feel that it's probably good enough to make
> sure that the ABMC interface can be extended in future in a backwards
> compatible way so as to support this, without trying to support it
> immediately.
> 
> [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/
> 

I do not think that resctrl's current support of the mbm_total_bytes and
mbm_local_bytes should be considered as the "only" two available "slots"
into which all possible events should be forced into. "mon_features" exists
to guide user space to which events are supported and as I see it new events
can be listed here to inform user space of their availability, with their
associated event files available in the resource groups.

> 
> For example, if we added new generic "letters" -- say, "0" to "9",
> combined with new counter files in resctrlfs, that feels like a
> possible approach.  ABMC (as in this series) should just reject such
> such assignments, and the new counter files wouldn't exist.
> 
> Availability of this feature could also be reported as a distinct mode
> in mbm_assign_mode, say "mbm_cntr_generic", or whatever.
> 
> 
> A _sketch_ of this follows.  This is NOT a proposal -- the key
> question is whether we are confident that we can extend the interface
> in this way in the future without breaking anything.
> 
> If "yes", then the ABMC interface (as proposed by this series) works as
> a foundation to build on.
> 
> --8<--
> 
> [artists's impression]
> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>  	mbm_cntr_generic
>  	[mbm_cntr_assign]
>  	default
> 
> # echo mbm_cntr_generic >/sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> # echo '//0=01;1=23' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter0_bytes_type 
> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter1_bytes_type 
> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter2_bytes_type 
> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter3_bytes_type 
> 
> ...
> 
> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_counter1_bytes
> 
> etc.
> 

It is not clear to me what additional features such an interface enables. It
also looks like user space will need to track and manage counter IDs?

It sounds to me as though the issue starts with your statement
"The local/total distinction doesn't map in a consistent way onto MPAM". To
address this I expect that an MPAM system will not support nor list
mbm_total_bytes and/or mbm_local_bytes in its mon_features file (*)? Instead,
it would list the events that are appropriate to the system? Trying to match
with what Peter said [1] in the message you refer to, this may be possible:

# cat /sys/fs/resctrl/info/L3_MON/mon_features
mbm_local_read_bytes
mbm_local_write_bytes
mbm_local_bytes

(*) I am including mbm_local_bytes since it could be an event that can be software
defined as a sum of mbm_local_read_bytes and mbm_local_write_bytes when they are both
counted.

I see the support for MPAM events distinct from the support of assignable counters.
Once the MPAM events are sorted, I think that they can be assigned with existing interface.
Please help me understand if you see it differently.
	
Doing so would need to come up with alphabetical letters for these events,
which seems to be needed for your proposal also? If we use possible flags of:

mbm_local_read_bytes a
mbm_local_write_bytes b

Then mbm_assign_control can be used as:
# echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
<value>
# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
<sum of mbm_local_read_bytes and mbm_local_write_bytes>

One issue would be when resctrl needs to support more than 26 events (no more flags available),
assuming that upper case would be used for "shared" counters (unless this interface is defined
differently and only few uppercase letters used for it). Would this be too low of a limit?

Reinette

[1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/


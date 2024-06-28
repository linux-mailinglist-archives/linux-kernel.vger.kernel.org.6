Return-Path: <linux-kernel+bounces-234237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6634691C421
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3B0286B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446D1C9ED9;
	Fri, 28 Jun 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3cVEEdX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125D15698D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593418; cv=fail; b=VKgVj4qW7J/fmoTMC/Tfm19QF6wiraOxWbDpYhmOHYwpJwhHzqnhxWd41Mmw3PPSsDYetFdJcLoOeXjMeKHfLRZnzkW1CnXC+V6HGQ8tfxeNgqp8xoU1JJiZeMRdY+Ru22rTbcTu3lzQMBHrChtn0jYwK1HgCqBxOLoWJ8AqyjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593418; c=relaxed/simple;
	bh=VZWJ5byquVT/yVXsY8Uae9uBjGzHUiHxE+JE/lclFJU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nz3ohS1pyINIq0cASpV1IXwZ1s3k0dNWj3Clp8YZTKN3/Tz+2/EokMRvDSTNt0bzyTVAP4PxdhqkZ7Ryish4iKB7NetZlDV6ptDSNH87xFRPZq1541NCW7ovbVgPniw2ePlVpJd/A3mM8DgZWaPIHFKAb1rOceoNYkrUqgIvFBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3cVEEdX; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593417; x=1751129417;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VZWJ5byquVT/yVXsY8Uae9uBjGzHUiHxE+JE/lclFJU=;
  b=C3cVEEdXRSdxM9z9MpSTxjTMutGaSM6SFxFTQsFLVTQOo6MtGQEav5fp
   TeGkRkdlLUvgUQjYECJ+qpsbFonDq850x/b3oydLaarNpgam60fvVFuAZ
   UWVcR8e40tLDJkS2Psokk4A1c6g6r3ZA5kH6+SwMmW2a8GxlCwxqksBzM
   Jzwiyz9SrhM5irRJP0/1Tb3LZX/bCYrqJh+QzDlciHnqrbQzfS0tmczJC
   F7pWxa6oK8CVpDcfYtjf+Hgk8OehztZBlZBZE806BUsY96wjBxPDwLtB4
   Y3WCgkR+cjqegnq9S+4EXxUQ/UWRUr3Em9QsAAKfUC5pOZpLuT9rObLbU
   A==;
X-CSE-ConnectionGUID: uMNC1K+qTpSBWvh2R9PWOw==
X-CSE-MsgGUID: BWgKVIl8RhmEDQze8FI1zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16918308"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16918308"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:50:17 -0700
X-CSE-ConnectionGUID: Q8Di7ZeBQyOh6Zd4oRSrDA==
X-CSE-MsgGUID: qIA3GVdSTBWI6bGgOfIxqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="49407755"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:50:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:50:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:50:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:50:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:50:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giiuXBquq+MsM31djhstY8cqbZdVrYOESHNe+eNVwC4cGDmxrVO4L42GdPfy/n3Lbg2YsC9SdmrwPc6mEbJ4ZvBaO+lGJVLWSICOGUA9IfptlQQ/GY6rIcuMhTe5Okdn9c6DFUXo8f60/QgSFxlHJOunrF2MURJYzZ2DehVs0bmZOvVAexhKDfx76Mlfg2SgwSnMXd/RWdTyhomxi3eD9QtEincaj8Byx8W4yKLJlhx22GMZMqqBMbmMzjwAMnUYEzjFxC7DbDxHYtqW22ms+XQppBg3+T/R7N4GNqqk96H4XxTPCtqzRe95I54Yd5r877BVyLPFi0YQHAeUaejxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyt/lZ56hRI4G2scrEJ4IfDOEWCdxK5CUW0i/8YLGI4=;
 b=OmniH0d+YwWNOqx1h5BtdELBwzqukapV27Ek7cWk9B703B/e4yQMeQrH2zzRqf6rq+RTpP7fgyA5JaN01M6I3QQfMp1B5cgT8AljcWkiu/aKF0fmC8U8TppVnn3CP8i9eQQxcGngPe9gmS+XLhkx1PBXdmP12N1e+fwU3EehZRBy3We7OkUtieTvD9fWWTkkiYOiNunjf6shj1n+toVDQXGwF8YWv6DhmCdLJznMu/bSdDlBE9ojiK9POItw6gEWVDeQNm2aiyB+l7l4pUKXk6swhLBL2L3VLNSuls6Z2xaXsY0Ok3kvbYvk2dE5cNYMAsZD3IQmefPg4fdmjSnyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4840.namprd11.prod.outlook.com (2603:10b6:510:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:50:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:50:12 +0000
Message-ID: <077b64f2-5839-48ae-ba41-b703a8021663@intel.com>
Date: Fri, 28 Jun 2024 09:49:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/38] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-21-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-21-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: eec77118-a33c-4038-1381-08dc979260cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2dhSmk3QmdKdFlNUFZpa0FOT25kSGVvLzk2NW9FWlJQekdrZEZHRElyT2hm?=
 =?utf-8?B?NWJZU3JiK3ZyZ210RUlzMkFCWmN2S1pkYVd5WVlSenhsQjU0YnJSNE5tQllw?=
 =?utf-8?B?M1JmOEhSclp5VzJTaEZ4WnRCWmFteTFKOEsxOGRQUEN0RE9wdDZTM0Mwcmlx?=
 =?utf-8?B?amtMcjFDSGtVOGVHMDN2cC82cjErcUFmQjBUeFlLYzZKVWMxeURiZ3Y0MVFU?=
 =?utf-8?B?K2w5aThPcndUNXFLcS9IdFV0NXZUQkVjb0tVd3pwSDN3MUZxT0pDRnNQQWY3?=
 =?utf-8?B?TnpURVlBWVIzSzNueHVNa1NYS2ZkRklZcTlJZlJzV0pLS0xIelVEM29VeldT?=
 =?utf-8?B?NGV0eTJqemlTSlZxNUtxNGd2WWNTb0czbkZydmZvNm05WmhvWlpKbTlXVmcr?=
 =?utf-8?B?d1J3TlRiUkhCZEUrQjlVQzl0T2J4Z3dMb3R1dkhsR0kvUm5Lb3dWWVlPRVU4?=
 =?utf-8?B?TERmTysvSGxJN2xGSWVzc0ZZaGZMcEVaY1pTdHljeHlGdnF5V296QlBTVWtP?=
 =?utf-8?B?Nkh4eTlXM0hpY3Bhc1ZaYlptQlIzTEZqa0xmc3VQWThGOGhGVkVHR1dBU1Zi?=
 =?utf-8?B?UjcyN2hnZ2ZjZDVQUVFvc1NLbFlKTXF5U1dnSGVqckk5NlQ4KzdhcDJ6Z0VC?=
 =?utf-8?B?TVNzOUl6TDd1VXI2bFZOUnRucm9NVmtpUnBqdjY2OTFaVmlFWjlPNnRzOXRj?=
 =?utf-8?B?WElFUTdkNzdVNWJhYlM5U0hCbC82cm9TNmFjck15cnVNTnVLTCtnWGdoZFpO?=
 =?utf-8?B?cHh0UGtudnR3dHgwU05jOFBmNS9OTG5La2x5M0F0aHRGa3Rjc3NPSzhTM1FR?=
 =?utf-8?B?dkdyNHllUk01T24xZHRiUkIwUnBiK01UdXVOdWFBMklYM3FKMGt2S0c3M3N3?=
 =?utf-8?B?RlNuZGg4VjRjME5aRHNmUXBaYmNHU040UGIzT1ZQYjg5U0hIdW9kSWo2emhQ?=
 =?utf-8?B?akhwRUlSSGdhUVo4RlE5UzROYisxUmRhOVVpSmpObmJxRzB4U1lmck1ZaGU3?=
 =?utf-8?B?TWFjMnR2MWw5ZTVuK0xVWTd5V25neFVuK2JBQmR0dDNvMEJlaDRMaXhQRGRk?=
 =?utf-8?B?OGRaLzdHcFlyTXgwdkp3NjB1UU8vKzQ5MFVocHkxOFduaWp4cUNlTnRpVURp?=
 =?utf-8?B?cGVoR1VzeUNiWm4rNlpJRk1ZbzZGaW1DRk9xK1M5QnplM1pmZFAybzJkWmoz?=
 =?utf-8?B?SFNibkQ4Z3hVMlVVck1HSEZpN2orakxxNDM1WHc0eEJKRlU1MTJxWVgrY2du?=
 =?utf-8?B?TnNqZnBjZmpYcWg5Q09zWE5OWWRhOUhvd0p5NVo1aCtZZjdDQ2hLUDl3dWw1?=
 =?utf-8?B?VFFQbGg1VzNGNWNUQjcvNDBFNmQ2ck4yRU5WN2M1WTF0UDhUZEpEdENlSlVK?=
 =?utf-8?B?N3FFMTZiNGt5V09Fb0Y4cTZtdUxMZ3FGVlBvMzJkcER5aGFoc1o4OGtOM1M2?=
 =?utf-8?B?QjJNeUJUTGlUNENONmhaZk9JekdKb1dWelpWV0pGcFMxbXkwV1BINFoyaHUy?=
 =?utf-8?B?VWZHaE1JSFNBU2NPSXVuWXhGcXlENzJhZ0RVTjBQaEpIYjZEZlJZY2RJQzlH?=
 =?utf-8?B?cWV6Rzdqakp1MWlXNExnSWVPTjBsYnl3R0hESlRzZ3FmMFBFRlNvdHJBc1FG?=
 =?utf-8?B?b3hPVFM4SjUwU1hGMEMvNFphbldmMUxFemZmV0VIQ1pWV0lWT2U2WnVlSVY5?=
 =?utf-8?B?WUhCbkFIdlhnaE43VnJuTnh4Nm0wN0RBQWNNOGNBM21SQ0tRcjZCa1NKZE1h?=
 =?utf-8?B?a3pmZVYwcmtuNWR2TUtwNnQ5QmNOU3NKamNRVEJYeUJ0R1NhQjd1V1B1VjZI?=
 =?utf-8?B?Mm95bkljTnJhdXNVWlNvZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlIvL24xcW8wenlyYmlsK0xuTmt1cEg0ME9nWC85UXBqYmJqbDh1cTlzU2c3?=
 =?utf-8?B?S1g1OTE0TkExMy84T1dIaXFvQ2VkNVFyMWJ4RXp3MEg5dnE2YU8xRlRTVC9u?=
 =?utf-8?B?L21UUnlIdzFoV3Jock5HOWsrSG91QnVrdFpvR3lGWWZWbFVFekRCTW9TazNF?=
 =?utf-8?B?dXcrSGQ4RXBjRXphZ0pOOFFnWWNEMldSQ254elo5VnRFa01JSThZTlZLWE1t?=
 =?utf-8?B?cUJaVDVKNHZ4eWxzbEdhSGI1L2RiK3M4QVZGNG9MNDVCRE01cHp6TnRRdUVy?=
 =?utf-8?B?Q3o2ZEtodTMxcmlRS1hhMU9xTzllVnBkeDB1SHRsWkpaVjRHWElSV1UyZ3Vx?=
 =?utf-8?B?bGp4RDZpdzdtYjh3V3A4WUl3MllXYk9TOU94WTk1ZVQ0WTF0RHJDUWpsbWtl?=
 =?utf-8?B?c0VvSXJFbWp0ZC9PK3AremVkaXI0SnJGUXR4Z2ZxRFQzNlBnS3J4eGFOa3lL?=
 =?utf-8?B?bE1BM3RMM1RndG0rOW01Sno3SWRFQ2hEc29tRFlrYytwSDZ4YjhWb2Z5Yysr?=
 =?utf-8?B?bXBEY3B1blRHZEp6SWdsOU9kcGRSV09hYUgwaWlhNmJXV1lPQjQreGJ5M1dT?=
 =?utf-8?B?bXJRQnZyRWJZV0E4bWNWckFHdXhUZTVHVm50TFY2RUVnUVY1QUF5aW9OQjlW?=
 =?utf-8?B?ZmxCL21LWi9mNkZGTmRHKzQ3V1VRTFV1V0NMSzJMWXJEVVdtemRhOTNIZnFT?=
 =?utf-8?B?M0JrV0J1bWZqYlVSWG12aTB1SWNMYkZYN0xNUGJKb3RLOWcvbERGN0VycFB0?=
 =?utf-8?B?cCt4aHF5ZWtHRXRuakZMcmxlR0tZLzI3R3drdDdRRVExNFFhUjlxNE1oMjRQ?=
 =?utf-8?B?R1ZMdzMrR1Z0UmExNEpja3M1czNVR1B5L1BXL1A3dmhVVlEzRnE0c2VIU21W?=
 =?utf-8?B?bTJlakNYdTN5SHdISmZnOEFFaktZT0JGdklENStuQ0VsRnBIa2F2cVhPY2Fi?=
 =?utf-8?B?SlFKejB2dmZxTjM5ZXhML083UzhFczc4QmlwbkxKSUswRU1BSGhtTUoxSUQ4?=
 =?utf-8?B?UjMvM0RBRk9XZm1zOGhWRXpPY1hEc3hXRlE5SUlFZmR3SmdvOXFETi81TTk5?=
 =?utf-8?B?UVNoaUw0RTR5L3hTZXp3UDR4Z09pU256VEdnYlZuWStwN0ZSN0ZlRHN2MTQz?=
 =?utf-8?B?OWdmcnNSeDByYnFJM09VMW1hS1ZRWWxMS0VQekV3bUJKNGhZV1ozRDdVcDNm?=
 =?utf-8?B?MFZKaTNBQm1ZVHBBcm91eDdUcE1BSjZ0c296Nm9mZEt0MXBMYWxReXN5SDU4?=
 =?utf-8?B?c1BSNUxWc2lYcWxDRE1GUU12NS9NNU5tTmhKY3hvZVBpcHoyUmEyRWs5SGtC?=
 =?utf-8?B?ZTRHYXQyUnNaQ1NVa3M5VzhQaENmRHBvTUU1Y0ZtMW8rREl4RnNVVlVTMUFC?=
 =?utf-8?B?a2VDcDBscmREZ2NSOGNEUFFKWU9lREpYdiszdzNyS3hxcjlTVDNtdzl5eGhK?=
 =?utf-8?B?aEFhOGJuRzgrenpsalYxdmNZb1NPZUtUR3ZHL1hweGN6L1Y1Q0dZVTJReEpa?=
 =?utf-8?B?Ui9UYTd6NzRaREpVZTRJaW4rV2x5VzhveStoQVAzd1dqQjBUbkVpeTBteG5K?=
 =?utf-8?B?TmVzZHg1TzRoVDAvbDNUaE5uRUtJblFUanJKRml1S3ZNanMrTC9nY0tFU0Rp?=
 =?utf-8?B?R2JuejFmOGhkbllsSnFoN0ZQQ1hZM2R2Zkx1NGJ4bEZNN1BPSElFbElqbFhE?=
 =?utf-8?B?aDNVMTBGZlpxc09EenpqTmpHTDEyT1VVT1lFMUdveHZzaVR5ZHhrWEhJWUgz?=
 =?utf-8?B?Y0xmT1pEWWwxd3JjRTJyTmNrUHpZUERkaVFWbFlnNzdpaERIOEZqMGZ0bVNz?=
 =?utf-8?B?K3RBUjFySVNtMG14Q3o2VjJEYjUwRGgzVU5uSy9CME16UXBxak51WmRpRTdW?=
 =?utf-8?B?Ynpoa3ZQcTZLUlc5MWM3WlBYaUlNK2xRMnBkc2VCbWpXVDB5RENBclJsL1VR?=
 =?utf-8?B?NjM3YVZ5aFRPWkl3MW0xMmVHdmQ4R2wyVUxCZ3oyUER0T2czWXVIRDRvOTYr?=
 =?utf-8?B?Nk80anppODMxMW5NOFFMUWdQNSthdEN1d0RMb2RtNWRDUkhWU1IxMys1Vm9C?=
 =?utf-8?B?OSt4VUZ1Yk54SkR0MFc3TGdyQklwYWlSbzBHcWJPOUNidTB0YzNWLzhsb2Nn?=
 =?utf-8?B?YmFYc3g4UDRxdi9ibGdEWXNBdEFZbThpTExOSDVJbFNzS0tXVWdKcnBVQVVK?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eec77118-a33c-4038-1381-08dc979260cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:50:12.6165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bup+8iL80+O4DEtXR2wDQa4qJ31snjYueCSaDmLI6nxFjVIwN24+u8lTSWwAvMhe/uAUqyb4yVcc4WEQkWT3SJy/oVFdMGz0aG4jnzNQPos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4840
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index fbae9a907544..65f0a2d17e4b 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -220,6 +220,13 @@ struct resctrl_cpu_defaults {
>   	u32 rmid;
>   };
>   
> +struct resctrl_mon_config_info {
> +	struct rdt_resource	*r;
> +	struct rdt_domain	*d;
> +	u32			evtid;
> +	u32			mon_config;
> +};
> +
>   /**
>    * resctrl_arch_sync_cpu_closid_rmid() - Refresh this CPU's CLOSID and RMID.
>    *					 Call via IPI.
> @@ -263,6 +270,8 @@ struct rdt_domain *resctrl_arch_find_domain(struct rdt_resource *r, int id);
>   int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
>   
>   bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
> +void resctrl_arch_mon_event_config_write(void *info);
> +void resctrl_arch_mon_event_config_read(void *info);
>  

Considering this is the API doc I think it will be useful to have a comment that
connects the void pointers in these functions to struct resctrl_mon_config_info.
  
>   /*
>    * Update the ctrl_val and apply this config right now.

Reinette


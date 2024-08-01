Return-Path: <linux-kernel+bounces-271728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C199452A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83333284127
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D5143733;
	Thu,  1 Aug 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDKPvRV8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7AA182D8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536203; cv=fail; b=MUYBC43Rdcwk4WrK1NGgfxqQUg5Ovns0gz8hHL0xzim8aurmdWyAYS+Y64zdZ2DgozL1QrIN6lQb7sazurI67MeAb3v/W7IB9TEmsWa2o0ALHDQ5S+UiVMIZN2+QIvl1nttcpVINHdNshNW61hLTvFdGF5QVtmwawdrW7puJJWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536203; c=relaxed/simple;
	bh=i+FJNGdlHwkqxcuh8H6h0jWuupb6n0LdZobzEPTaBE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YIKHHaWNumnpl2nhHNyYZByfcUB2j1siVQLWNL0Z3Lwj4t9dMLF0K8CugSCA/kJw1VUiPOh27Lidcp/3DnJsJRNVrSAmDf9ZFkBW+HHc5bIHRkZpfMxngdAlmlbAkrWtU7cVZlqKUW+zUWAxmiKeYOjORoyGh8qi+DxlnIpXEns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDKPvRV8; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722536202; x=1754072202;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i+FJNGdlHwkqxcuh8H6h0jWuupb6n0LdZobzEPTaBE0=;
  b=oDKPvRV8bIVio0vBtLp17XBfkbRckHqlX+HMe5ewzJeD6Xy6k42Ur0dd
   dUyG+jsSmTOu3j3def/BssrLp957Y3dXAXTiTnjDC3Yz+Y/ezeeAhMcFH
   wK7PmgbsSlRH6GrkArKEgIj0jUEUNz1WB4EPpFZtY7VYQehie4wv5/oJF
   Lzur00Ye7Z4cB6rHAD+I14Co3/dZ6N9gpIU89ChJurnftjlFUnJy/HY94
   2FNg3Ho7Pcnp1KWX1exdHXP9xoGcQHgqZx0Sxlna2Y5DeU3k2hSQV5QxF
   WhNbBtXiGLdGJs+PKUDufNS2IjRjBdAI3J1cVtuCUdRYIMJfpuAPkyJCo
   Q==;
X-CSE-ConnectionGUID: nLt1bs7KQlCfhT/aEiU7tA==
X-CSE-MsgGUID: gBEceLoyReGheO1Ybv8p4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="31170826"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="31170826"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 11:16:41 -0700
X-CSE-ConnectionGUID: scC8R1xySLCAAPsRv4TlhA==
X-CSE-MsgGUID: Q3zh2z15QhKS+OYNp3Ejdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="92667340"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 11:16:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 11:16:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 11:16:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 11:16:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUkzNvtTvgB5t0lzd3q4zMvRlVgFlkaqr/QEn8Ur3pGt+UumhN5AvdDKbpDlryk5RRHyBF7JSgHtGMk1WvUcLvhNlBCajaq+eF6+k2OgQZrrN3CIfHXwMy5T9WGJtl1SkUj2Fgpcnv95L8V8d2LD1jwIYZuAqgw6JidKPA0GqHOFmd39cGLh6sqyMthOJqOvZXtQ1zHAvMxGSVyPVdeHe5ykGQBKapCkighT8cbqO1iAtOogSfLf7Gfr9IKhkPYP4SWvQRYtnoHKCBYoAN0UzHcqNn1ncMgxOeZEWs9TWmysHmjAJNoIfqxG3xyAjuwjKpEFGctPdnBQpdses7KnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLT6oxhZnujE+GCOSUQSzn4YOMSpbEAnEwalSDeOqfk=;
 b=SaLgvpowPHlMfm/IMM6HvFigpPHooxCEKE0m9uSYgc6G32GrWFs0VKFnV5lgMDU5rFWkoEVd78l/I3YBeKgRMNgmK9/E88tOHjRLUcm3RHevY39ZlszI+9FkxG+N5U/GBxxc5SFyj8ATFV+ZZlNTzhGyCw+ZDF2wxLSFWMDSEUJ2RJ+xyuNcD/IRf7VQ9pZAfbda/FqgRkqWzaZL4U71h9hUwGVD6cFlG+4FWweNZIkoXw28c8eHIMxuBTLl5n8XACVm7AGkE7KsKBA9YguPxLzr+nf1jA21mu8aSBDsiQbqL3k8gaz88D7wZDw9LMP/m70v9IaGn/WWsj6lhvWEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 18:16:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 18:16:36 +0000
Message-ID: <f67e36b2-709f-485f-a0db-388247ff6b37@intel.com>
Date: Thu, 1 Aug 2024 11:16:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix arch_mbm_* array overrun on SNC
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Babu Moger
	<babu.moger@amd.com>, Tony Luck <tony.luck@intel.com>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <irogers@google.com>, <namhyung@google.com>
References: <20240722204611.3549213-1-peternewman@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240722204611.3549213-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:302:1::43) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4fc0cd-5863-4e2a-c239-08dcb25614ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R28wcVZLbGlJOERHMDB5K1hOYXlCRklzeFNSVWxzT1pmTFBFSGhLcFdIcytm?=
 =?utf-8?B?dCtXUVVMZEprb1ZNeC9aNkhYeWpYY2h3U1h6QW95TUI3K000c2JwUWdhNnJH?=
 =?utf-8?B?cDh6eGFYZkpRMUpFZW1GYkZhK0pkU21PUE42TS96UWFuQ3paNFhGdzVUcktH?=
 =?utf-8?B?MEhTdGM0U2tWL2p0Wmh3WXgwSFI1bXVOaHV5OXBDVVUrSGgzeDZDY0tlcEZY?=
 =?utf-8?B?T1BxV0tNL2VhZ01UUW9pQzV3UzZnM1pPWkREZDRXNUl1c3pRcXlramtmMEdD?=
 =?utf-8?B?S3pzUE5HVW13cDVjcGtKa29yUm0zczBpU0dQeFJNYzRLcVVaZWt5NVFWT0NK?=
 =?utf-8?B?Y1Z3YUVEUUx2S1k1TC9tdzBqWi85eVFzNnpwT2pxbGhFSkQ0NnR4aVVzRXZk?=
 =?utf-8?B?R0hGempWWEVsNVducUdzYzhZOXI1bFNLalJPRFY5bTFoWXZBWEhDM1VTaUQ5?=
 =?utf-8?B?Q0lyb0RwYy9SREszd0xxYVpwaC9tSGxqVkoxWVViSm9IbklvbWxvazNGOEFv?=
 =?utf-8?B?U0UwNlAzaS9oSGp5N2Vnazd2SFNrQm1rYWRLdzQ0SUxHcW15eDhCK1pCOGtN?=
 =?utf-8?B?NkJVL0ZGYjk0eWVtYnE1eWN3SzYwUG5Mdkc4VkhIYzhPQVlqTGdQN1pOUVdC?=
 =?utf-8?B?RGtWRVVteTFIRG9UWStkM1lYQjM2aHZDYVNFanBlK0F2S3NIUUtuSktJMWtT?=
 =?utf-8?B?Zld3QUhQMjRSeU1odE1PM2d4eVFJZUZJeWlVMDRNRlRYNUVlRUVCVnVGY21H?=
 =?utf-8?B?OTFnMFlVTitEdktZQmlZSEE3b0FxQlh6SWtrMmpYamFyTzZsR3J6M25zQTVm?=
 =?utf-8?B?VGdwNU9oR3EyRXFyQ0RlVWVIUkZINFd6Y3dBNmtqb1FNSUFBMlZGdzRveHpG?=
 =?utf-8?B?NUd2RlRDSEZsRmx6VHdZN0RIVUdENVVGR1hhc1QxdVk2MndjUGpScWRFUEZB?=
 =?utf-8?B?aUxHRDZDaklMaXBKc1lCN1ZicitqbGR0cmRZNThPcE50dmljRWkvSmJvSEcz?=
 =?utf-8?B?aytmMkMzYWFkUk4xMVA0amZvY3p2VElKVW9kUEk0d05xUC9IcWZnbnFEUjBE?=
 =?utf-8?B?b3ZkOFNFUjJuREsxRE02UjF0Vlpyem9iWWowU3grdStpMHNWYk1zSHpnUE1h?=
 =?utf-8?B?dnVWTHFDUnRyUFgwek5QR2ovOExxdnpDazRIdzBydHMxWFVmR0xLamZiR2Zh?=
 =?utf-8?B?VDFCTVdGc2FFQzMwUGg0R1kyNGJNQWdkS1hzVUM1V1B3bmhLLzVYUDJhZmd1?=
 =?utf-8?B?b3hGZUJBOVI5R3hQdDU1YTNYV0Z5ZWt3Zk5FZ3crNUpTc1pVQjZYUXBZSXZw?=
 =?utf-8?B?NWllbmk1Qkt4d1d1RDRrc21JaDFxU3NZOXhvaXlkRFoyemZSTmVoeG5sTGpp?=
 =?utf-8?B?dndYYitIa0ErdnJQVEx1R1Y4WGdqMWNkcFRTN2w5MGdRTUw3Y0NDVDJKOVhB?=
 =?utf-8?B?Qitra1VENWV1MjdJWWw3UW5saWcwU21aUUdJL0gvYkVvbWVieW9aQW9GeFJz?=
 =?utf-8?B?bmF6NWtjY3M4SU5JY21ueW1CNkRDYTV4czg3VDBhOUtTT3Q0Qzh2RSt1ODZ1?=
 =?utf-8?B?Tmt2SHdmTk5VanJacVIrMGE5WWM2d1pxV2UvNFdkTnIvZVdRWU40OXIxSEps?=
 =?utf-8?B?bldUT041eVkrUXZxS2p3a0EyQjZQT0tyRTQwam1tbThOY2Y3LzhuTFc2djRC?=
 =?utf-8?B?bjZSeE5Sd0lLOTRqeDk5a0xQa0pYMWY3dnN4OVZRTFZZTzVHSzlhTDJsb0VU?=
 =?utf-8?B?S0o4NnZIWUxaQ25rV094MndycGJ2Y2M5OEh0YkpQQWFLYWZqa0w4TFFjL2lh?=
 =?utf-8?B?WFA2Tlh4c2ZIT2ZMNHF0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE1HeGdHa2lneEoxYXNPb0JTTXA1VTZZSDJZNUlmMTgzY0FKeWxaUTd3aHcx?=
 =?utf-8?B?Y2xmbjFlTHh4U0JRMXp4cXRRQmg3cjc2bGxCcVNlMU5MY3pjN3ZPekJBc011?=
 =?utf-8?B?Z2VmSS9GMHhMTFZSNnVEbFdPMjJ6SGlIUHltVkRHS2doZXFTVmk2T2E1ZWhP?=
 =?utf-8?B?VnhsVFBudExpbUJ1UmRTeHErNERwMzROTlJNREVsU2w2Mksra3JQRXl4RS9X?=
 =?utf-8?B?cnRkQU5DL0VVRWYydnlYdTNjcXVRQXM2ZXFDKzBlOGFQeTI1dUZTS2FhYno3?=
 =?utf-8?B?MG5xdU5mWWtENnpWQWZXcU1saUhGbGtvbHRpUHhrS2FYeXlPUm1FWWZNelpr?=
 =?utf-8?B?TTAyMlFhSkRJMG9aUC9abnFXc1kycGM5OWhKTURSWWRkZE1sSjd3YnBSTTIv?=
 =?utf-8?B?WDc3SjZicVdkYmVMUE03cjFNbDFDUWppWVIyTE1EZ0hLeXdMOXRTemRFS0lq?=
 =?utf-8?B?TW9YcHlEUVBLTHdYNjFxZnRHc00rZExlbU92Z0NhUTRHZnIrTUhMWE0xaFBP?=
 =?utf-8?B?NzlpY1ZWTjl0MkJoZko5bzYyRldNc1MrZTlyWEZpQmFuMVY4dWtoTG1zc0RZ?=
 =?utf-8?B?WC9vdXNnRENMVkNiK0xzVEFvb1U1MUZCZjJVbEQ1aTdkdUd5OTRxVDY0R2VF?=
 =?utf-8?B?R0M5TE9GWExDUzc2ZDUrMnJKMVJCclRVdFN5bmwyTVBvWmZVUFhXS2ZOb2Fx?=
 =?utf-8?B?amd6MHY3ZWE2T0luSXM2WThoSkZhT2RKQWJFQmJjNVEwUkk2Z29BY2w1czJU?=
 =?utf-8?B?QTZXSE96Q1NiZnVkL1VDSWdlN1F3SDgrNkpENC82VjZMeHU5aVpsV1ZpTHpD?=
 =?utf-8?B?SzV3anpISjJOS1V0YmdOM1NLM2ZveDR6eXltUlBpMmpyTUxMeTFKQTNtOTBK?=
 =?utf-8?B?b0EyYmM1Q1N3blJGbGFIV2tUVGp3cEFNVmVvVldhZDZBbWNZVDJBdXhZWHlG?=
 =?utf-8?B?RlNVdDd5SXRRLytVOWxNalo1c3VRMmpxcnpDUnZzcFIwV0F0dElPNDlKZkVp?=
 =?utf-8?B?ZEpvRzJvWjNWNXNld01yY0JDRWs2TkVjR0tpRXA3YWozSlBaTElGdHlmcVNi?=
 =?utf-8?B?ZndnRjluOFcvb3BtUEM4MHVkMFBQRUN2eThuMUkxTlpPTE83VFdaRzJHNUoz?=
 =?utf-8?B?UHd6S0NCaWRVR1lIMW9DWEJBTWU1dVVPWnNuTFF1M0FhK2RrQjJnOEcxZjhU?=
 =?utf-8?B?a3MzT0dLVHFCbUovUlVUV3M3MGFnZmF6YW82VTF5czNScm1sbW9zU1pmZ1Yv?=
 =?utf-8?B?cjJQVVlZeks1c0FvVGZ4UzV4WnRiTU9vWkQyODBBTFZ1NGVDc2FWeHFzdmhP?=
 =?utf-8?B?RlhFUlJISDlVZ3M0RUVPOFpQajUvcEhiM25BNTN1ZCsySXZHZVUzbHV2LzVj?=
 =?utf-8?B?UGFDQ2I4b00xOTVNOTgzdVIxRW1aTGgyOStGK3EraSsvc1MzVWUyanVTM0Vs?=
 =?utf-8?B?UEpQQUF6MXNlT0tqUEJ5R20wWVBVeDJxVzJEY0J2ZmZjd2lmK3RpckhUQWJo?=
 =?utf-8?B?L3hBTXMvYmdnYXU1djZKbmNPV2JRck1qR2N5UVczZ0ZOb3JJZTV1bDZQOEYz?=
 =?utf-8?B?bUZSaWprWG1YSXJDQUtLaU1PY250VnNNVUF5Y2ZHYStxSy9mZEhSbldySElw?=
 =?utf-8?B?aDlCMng4eXc2OVhoY25FN1gvS1JIZzFVWFdNeXBpMjlocmZqeW9FRS90cTlr?=
 =?utf-8?B?dyswU2xoYk1TN2dlUDFKem9FWmVmUVk4YmU4MENFbGg2QUlMdzg1VVFhQWZW?=
 =?utf-8?B?ZkVEbnZYWWc5VjdzN2g2WEdDaVFia245Vjd4NVdON3hBaGt5OHhLdXY0aCtR?=
 =?utf-8?B?bE43WTZmSnZIT1ZaZjB0Sm83WXFpWjJqTXpidlp6eFJzNnk5NVZVY05Ta3F3?=
 =?utf-8?B?dlU2VGNQUEtuTEhieGJrR0lkYWVPQlgvREREanMzVVpDNUVSWVZSeG5WL1Vz?=
 =?utf-8?B?ampBY3NONjIvRklmKysrVkN4eHB5bktWV1hJVWdCZW9RRjcvcFFjOUplTFRZ?=
 =?utf-8?B?NXUxd3R2U2gvTTNFaW1jUmxiUmo4VVZOayt5cU4xTFZZVjRodVlpNFltbjRL?=
 =?utf-8?B?UVp6YllBQXBZMHgzdSt4UWhDaHBwdDRaUnhQeXpRWTJxeDNvR2pkeFNCSkFQ?=
 =?utf-8?B?NzVSQUtSd3NLZ2loTlVZZkZHVTYzekJoUDV1dzVNOEZtWXRQd1FmaG1BdUJR?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4fc0cd-5863-4e2a-c239-08dcb25614ca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 18:16:36.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /onitzoSJpfqQwFSM0wKZ/IkmlqOh8NEqfooNyzQ9yy85VXlh/gh/cAR9oD79wMlR57+W5fegxfhrInCO0GF1OxOL3punkkHhkV5i3p3OM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8185
X-OriginatorOrg: intel.com

Hi Peter,

On 7/22/24 1:46 PM, Peter Newman wrote:
> When using resctrl on systems with Sub-NUMA Clustering enabled,
> monitoring groups may be allocated RMID values which would overrun the
> arch_mbm_{local,total} arrays.
> 
> This is due to inconsistencies in whether the SNC-adjusted num_rmid
> value or the unadjusted value in resctrl_arch_system_num_rmid_idx() is
> used. The num_rmid value for the L3 resource is currently:
> 
>   resctrl_arch_system_num_rmid_idx() / snc_nodes_per_l3_cache
> 
> As a simple fix, make resctrl_arch_system_num_rmid_idx() return the
> SNC-adjusted, L3 num_rmid value on x86.
> 

Thank you very much for finding, root-causing, and providing a fix for
the issue.

> Fixes: e13db55b5a0d ("x86/resctrl: Introduce snc_nodes_per_l3_cache")
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>   arch/x86/include/asm/resctrl.h     | 6 ------
>   arch/x86/kernel/cpu/resctrl/core.c | 8 ++++++++
>   include/linux/resctrl.h            | 3 +++
>   3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 12dbd2588ca7..8b1b6ce1e51b 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -156,12 +156,6 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
>   		__resctrl_sched_in(tsk);
>   }
>   
> -static inline u32 resctrl_arch_system_num_rmid_idx(void)
> -{
> -	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
> -	return boot_cpu_data.x86_cache_max_rmid + 1;
> -}
> -
>   static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
>   {
>   	*rmid = idx;
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 1930fce9dfe9..8591d53c144b 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -119,6 +119,14 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   	},
>   };
>   
> +u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
> +	return r->num_rmid;
> +}
> +
>   /*
>    * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
>    * as they do not have CPUID enumeration support for Cache allocation.
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index b0875b99e811..43ac241471b3 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -248,6 +248,9 @@ struct resctrl_schema {
>   
>   /* The number of closid supported by this resource regardless of CDP */
>   u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
> +
> +u32 resctrl_arch_system_num_rmid_idx(void);
> +

nit: the additional empty lines are unnecessary.

>   int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
>   
>   /*

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


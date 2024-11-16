Return-Path: <linux-kernel+bounces-411523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CF09CFB71
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749261F23C26
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC781361;
	Sat, 16 Nov 2024 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlVyDEUJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021B802;
	Sat, 16 Nov 2024 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715615; cv=fail; b=IgvPkyeV2eCdUNH5EifsFGepiYpQ3QAPva82CDDvOAf8KjF1CbNQV/On7jC/LYSG7lRHRMyZDv2n4TUUvTRybdUpXAvX621KT67YY8Cw8XacPxWh41MT5FTLZxuVR8lDinjcA3SJnyyeWSl6suW1YCaVc+2K6nd0C3uXQFBJ028=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715615; c=relaxed/simple;
	bh=l7zIFJIJAqGYmpf7lYo5nZ5F/UuQ59PthRRrlY93aqg=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YaVz6InK0IgzHqpzDsbsQRyaBP9aRB28iGAsreozo5qXLArjevK7MT4a3mR1pDqRTqKDfHzlswlI77YddNBxx7Nm6LfOZvSJ/5lA7a3yHVWRvp2vfIWWoynNMXeAHTO3lK2vovSbgCRrIXarFFCKgziOYhI+DCEWDfHrNjkjBD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlVyDEUJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731715614; x=1763251614;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l7zIFJIJAqGYmpf7lYo5nZ5F/UuQ59PthRRrlY93aqg=;
  b=nlVyDEUJkrMUZ5ETgkrMxLrxeWLTFV843TNLLJ2wCNmvwPzaHbBF8SpE
   hzQOHyyOUyWYV8cNXQjfok7SAaAMTf13ug6xgQGIfbqxJ4OIFtb7LWUg3
   fxQWIRZLXJ1eSTO6RoTZ55vPFtflvGq3tIKEQNqI39E0km8Gc2DWqkJw4
   EaS0AhihqK17Q9XFCnqB4MfbnofhnRuMnWefP6reXJwfx4Bet/whDIo1c
   Dps8oZW2nacXZ9SwKK6PFkceq8z1Lz6GNvwWY0jdFi5woAEzpzSkZZMXP
   XHJQw8nIqurpMuHTSq1Gp+nffrrE4EMPskT+eeBX5zR8csO/rnlQmAi0E
   w==;
X-CSE-ConnectionGUID: uclHiVmgTPOGS2tJmuloLw==
X-CSE-MsgGUID: CZfIgzM/QN6opkj1pVweag==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="57153657"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="57153657"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:06:53 -0800
X-CSE-ConnectionGUID: ylqn7/iSSjGLgNGAoqa3WA==
X-CSE-MsgGUID: PyKz0bZlTx+uyXpd6LjiBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="93642040"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 16:06:53 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 16:06:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 16:06:52 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 16:06:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDvQCuQjKmHYgvPrQ6EbBZHuJ9qEbne6p5EN5XeRWvM+4vIwurQCsWDjQQzkKggBTDzWYz0bOEMsed/WM26ZGIoWSuR0hmuw3ye4udMdWQ48ZJCy4LD61H72a815xqaMYtUgQSouhsfEZmBIj2tQ/fKpYuGUV3K2nUCgLqAE9CXxz8rLP0Hc+TWoBqu8ZwSrxRhkLMtvuvXCODsHhbyyelSVWh+Z4cSHC12mrtQaiJG68MUUXIUpX1MedRWeT87WZhf+zs0Q9F/b6UbhRZzJlcOK/BlvIjBgHfAdBhxXTzHC7H70ogdp3m2bIDpKUZocqQrRfX8QYCva8orub3/vug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DChj3yl3SuV9o2pRt/DqwmvXu7WJ64q5/jcFa4KDOi0=;
 b=tgaRo94XOXNgO9QardzY42gl2WGij2psYsa7v9pTL9Qn5QFEk29WtsHg3iaQs/nfEfmRb20ta6edctYrGLyD5tIT9JlcVLbFZ0hIhh76f5GcA0mUQpnJB93K6qAU+6aAQb20M+kIIWV5klwpxK0T8A6B/IydiEqP1WhgwVLscA8NwTh7dvZYMaLVW/ZhipquqkjHyCst5tV40vzcLANZZDZGwLgdjhCVj5G5u2Kx4vSJ7ubBOgtj3VOPH0KDzZTh0TDdzUYvfwaHRFXQ7AOTEt4TtQsoUapKlzi1C/zj7G7JRi2/epcS+br8D9HZx9vFX3oKG8vpNovfucFkU60NZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7944.namprd11.prod.outlook.com (2603:10b6:208:3d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Sat, 16 Nov
 2024 00:06:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 00:06:41 +0000
Message-ID: <b6ef8e35-7acf-4391-9cab-76d7910435d7@intel.com>
Date: Fri, 15 Nov 2024 16:06:38 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 09/26] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <447a268e3cddcebc30a0b2c5ccb321e3c6b9c8d9.1730244116.git.babu.moger@amd.com>
Content-Language: en-US
In-Reply-To: <447a268e3cddcebc30a0b2c5ccb321e3c6b9c8d9.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c77fdc3-1ff5-4fd4-94e1-08dd05d28c66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTR2S0RJKzd6STd4em90Q3UycjZ5Mld3S1FHeURQUTBITStnVHVKUWEvdEJY?=
 =?utf-8?B?TXY5TnM4aGRZY3dHRUl4MG1NYncxNlk4U3phZTFaVkhhZFNwV244SE9LME44?=
 =?utf-8?B?N1czdWdYeFlQN2J4QkFCdjdwbmtGUVQvcXVjMXkvWEJERUxTOStWdmdtcTJZ?=
 =?utf-8?B?NlVDRTFaM21heE1EZW9vQkZiZmdROFlkVmp5UHA2NEUzdFNJSjRKdkdpSVpC?=
 =?utf-8?B?TnRMZXZudEd1OEdzVEpnMy96WFk5aFFWYURab052T2tHT0dXaEVKQ0p0a3hk?=
 =?utf-8?B?d0EvNTByK04wdWVnaUtJRU4vWVh2VmRUa00wUmxFLzMzRW1zMFlUb0tkN2Fj?=
 =?utf-8?B?Qll0S2ZWaHhSVFYrclNqb1dTSTBKYmtjYkkxZUdHVTZGbnprTENTeEFXL1pX?=
 =?utf-8?B?aGFGVDdkNVZhdkJ0eTVEZWJBcVBleUxXVkJSR0FYZy9MRjAxdHY2NmN4QTc1?=
 =?utf-8?B?S2IyVmlvU2ZaY2pKbXhMeDRiR1d3RERBNGlZV01EWGowYmxuVHAveDVwdlNz?=
 =?utf-8?B?bDNOdzdXWlVhVjJOd1lFWVlIQldTRFpyeWtMR005OWxlbFR0dUExSW5zbHRj?=
 =?utf-8?B?VGFOU3VIbDFrNzNxMmdTUnJJbTBMRGt1MHYvMkxEMEl0eStZL3pNUkJKQnQz?=
 =?utf-8?B?Y0prK3ZrL3pLa3kzTHZKZUkxb0EySlhUdDBFVDJORU1laEd3elBhZzVXTnB4?=
 =?utf-8?B?enFvVU9qUldCeU5JS1Zta25pa2RDeWw0VENpNVVSWnJFYVkrbkYzSktxL25o?=
 =?utf-8?B?OVlRVDAybE8rUUtkYVY4b3R1ZjhPYVNldWdsMGpPOEJ0dTdqNUNZRGI3T09j?=
 =?utf-8?B?YW5PbFNwSTc2bGVHS05oWGdVemZoL3lBZGNuaVljTk1GN0ZXZW5EL2VOcSs2?=
 =?utf-8?B?MDRCUEtVbkd2RG8yQ3BWVDRVa2NtZjlSRnByV094dHRCT0lPUnZoei9URXls?=
 =?utf-8?B?SGg4eVRTNUxiR3Z4RU5LazdGS25BWnhBK0swUEl3Zjd0VVF6TStmdXZyS0FP?=
 =?utf-8?B?Yi84Z2V6YnBINHRUampURi9mZ00yVUdSYUYzUWM0Z2VnUUNnUFNxQ0lRTm80?=
 =?utf-8?B?TVQrUHU5VXo2RWE3VVdqSVB2Y2hZQUVTcE9HSUcxaTZ2YitUMTFISWdFYjJL?=
 =?utf-8?B?Wm9lQnNLeGRaV1VKY1lFV0hhcno3NytjWk9uLzJCcjhFVXZKb01jamJBMmhK?=
 =?utf-8?B?eEs5VmZNL0ZnUHlCOXZCRjUweEFGSkl2eW1neWRHSnZITHVsWlkvNlREQ3dK?=
 =?utf-8?B?NWlNNkkvS3F2VG9lcXRKNVhodWhWeUkxY2Yvd3BsNFhuTWhHWHBabjdRcDYx?=
 =?utf-8?B?UnErMUJGdGo5RzEybXpRelREcFRFZEJ5UlJKSXNYTVgvL2tJTzdnVlhLV09L?=
 =?utf-8?B?Y3lqd3VVRTRQaEpIRTllM3IwVyt4VlpWLys0aEU3WjllVFZWc3MwSlJ3Vmpz?=
 =?utf-8?B?NjUwV3BHSXZCU0EzeWtNQmpKcU1SQkxQSFdaNXFBc1NOR0NZUHVWMmtTSkhr?=
 =?utf-8?B?Y3JwcmhMNlVhWWExd0diSmUrR2tkSmVLWWJkY2JyL2pNZ2pCVlJXWDNLUGtm?=
 =?utf-8?B?bEQ5VEx3OSt0NE9hSnV2ZGsxWDB0eTBwcU5pby9HbjFvUDU4aktURWxCYXdH?=
 =?utf-8?B?c0ZZQ3RMVG5pQmZ2SjRPN3FtVHUvcG9KZ1AzRWhvbGJEWGJSVjdYWHJESWJX?=
 =?utf-8?B?RGFBYUQ3WDNObHRNM3NSaEp6YnZVVGkwVHpXaXVnRnJpUkV6YU1Od0ljWHFa?=
 =?utf-8?Q?fBeHtTIn9lkoe1cKWc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElnL0Fzc3hNV0tLWDN6cG42azRkZUtpaDFJbTVsN3RxVkxuK3hocGxIcjhj?=
 =?utf-8?B?ZXZGLzJEbG9wTUEwTnZMWjZEMEZmd3RUdGtaWGdaZjFjWHB0VEx0QThiUUNX?=
 =?utf-8?B?ZGpBVytlVExRNTRYalhUV3YyMXdSa1B6UUZ4ZU9aNXFoeTNpeDEwQW5pbFd6?=
 =?utf-8?B?cXpmVEVQaFVIMWcyM1ExQldVMXBMd3FndWtoeXZQZUdmbkJuNnJ4K2VJaVl0?=
 =?utf-8?B?dGg1b2tsQzZWTlQrNnFpdG55cDhPUXVUam5VOWhJUkRMcXlCc1pScnV3RWRF?=
 =?utf-8?B?ZWpuUjVTdGRBNzhyc2wzWDhQd3pnblRWeTd6SHhEWnJSQ1dZdEJzK1VDOUNN?=
 =?utf-8?B?MXpkUEhNd0dBYjJhTExiVGpZTXQ5Z3lvaTJmc3hJdG15UzVNZnByb1B3ek5i?=
 =?utf-8?B?a3hldTRHWmZLMDZJS2RyTFpyTlE1SThNQ0ppbmU1Ykh5MTVYNDBlRW4yNjlS?=
 =?utf-8?B?dUwxZHlkVnl3K1dBK3lROThtS3k3WGxsZUdiTmxGTm0ydHNIRlZCK2tnRU1N?=
 =?utf-8?B?K2FKcFdJelNjbHlaSEtoRnNzU01JZGZNZVdyYUdsck1HcTBuWWszN01pUVdP?=
 =?utf-8?B?NFVtd0RtQnRPdGRoeWhoYnQ3WkNtMlEzdTc4My9DN0xDRk93TWxRUEFYVTBn?=
 =?utf-8?B?aGdoQm1FRmF4dFREU2d3NXRscDliYUJTTm9vMkhLdHpmRFpiUnBYVWhweTY5?=
 =?utf-8?B?a0FvTzBIZzNhdkVjTkpiZlFaM2lHQkFZTUxxdExXbEN3QlBuOVpveHk1NUZa?=
 =?utf-8?B?NldBQm8vMnNOTFp1NFI1OTdUcTlEaWNkL05mWWxPZ2dDbHF3ei9aQXJteWV3?=
 =?utf-8?B?Zkk1d1pDWHZibmZVMkRmVVNoR2lKN1JnU2F3NkVER01WUGttNU1qOTBrV3Zp?=
 =?utf-8?B?QzhJc0Z1ang0RjFnVm9UWkExaUFXM0k3MEFUV3ZZMDlGcGd3S3M5blYrQ1BV?=
 =?utf-8?B?VnVPT0RRNXpjdk04OTVvUDcyb3l2WHdyV3lhOEk1K0RoQzRSOWRRZStyblNx?=
 =?utf-8?B?VEtodC84L2NMNEloRk94NlVQSUlQYWFGejFiOXUvMTg2NGxYT2EvdmdvSzBT?=
 =?utf-8?B?UEJKTGxTc0xPMjkxNUx5eXZqMEgyNmF5RG1Tcy84bk4zNG9rZWtFUVI3bGVU?=
 =?utf-8?B?ZTQzQmFDeFhVNXFFMEh0aFBGdW4xUHhDVi9YUDVJOVhaV29DSkJTQmFWSEQy?=
 =?utf-8?B?WnZSaFU1TS9JdEY5V2lVS1daN2hJMEtZOURlaWlWdmpsZkZ1RGVvQm1udkR5?=
 =?utf-8?B?ZWY1R0F2TmlDd0NESDJKMlpDZVFTcG00UzJyRjJPcEdKblVEU1A5bWNtWVJz?=
 =?utf-8?B?L2NpR0JvTllBTmlJek1Rb281QjdqWjJCVUNwc3JhY0xuUkdoOU9PbVN4T0px?=
 =?utf-8?B?cE5XWkdmM1cvNzFjbmtHMFNjOXF1ZjBteVk4SmRqZFlaWmdNTUVsanFSVmV0?=
 =?utf-8?B?MHl4K0d4TlhPUmprTEZwdXVTc2lHS0NlMDcrS2JNMkdrNmdBaThpZFp2clFS?=
 =?utf-8?B?RmVINkQ5a250RS9hM0NwM2xqZUo1akdxVjBrQ0NsUTFuTVJ6R3lyZnQvSzJ5?=
 =?utf-8?B?L0podDMxYmpOVGt5MmhseTdHMDhiREt4NFYzbDJpaXZXeGsxTkJ4L2U4MWpK?=
 =?utf-8?B?VnRxcExWVTM4Skh2T0JDdUdQUnBOb0w3U3h1S0V1QWoyVGZ2bkRPcFFSLzNW?=
 =?utf-8?B?YTI3Zjloa1NXdURQR0RobnZKYlRBWTFmR1VuVVcxa2lScU9TU1RMS2VzWDBR?=
 =?utf-8?B?ZGJycWtlb0I1Tnk3cVRlOUEyWUNiYWd6VVJEVGVicGNTeVFjdEY4akVLRmYx?=
 =?utf-8?B?MmVJem02dWhSV2l4Q1U4V1pVajNFYlBnZjF0dXg5ZG9HQTgyME1nMlV2TjF5?=
 =?utf-8?B?cXhIN1BKTU9LNGZ5bzJEN25RdldVMC9lbGJmYjJuekdhMmJtS1U2K0ZmY3ha?=
 =?utf-8?B?T25JMjFERXUvVlVPU09nWTQyekx4RVA0VmoxRVRweW9pZWVNVS9LRDNXZEV3?=
 =?utf-8?B?czBWU2VhdUtwME44K2l6a1JmbjJsSFBkcmFaY3lTcC9hNGxML3NEd3I2N0NB?=
 =?utf-8?B?UU8zRm5XSi80em5uMTFyZXFsNnJTRitDOHUxQ25idUorT2dPY0lPaFRXZXVC?=
 =?utf-8?B?dW92R3FneWwzN1F0N3hPQzRLMnFTNVBKSm5OT01MRXQrWGovVHh5am5tRjJB?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c77fdc3-1ff5-4fd4-94e1-08dd05d28c66
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:06:41.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdPhDNWO8KWDACTFOLPWE9+dDYNyczSwJ+yjgAAiq3rhf+tUi80IGGPTYjEnbrc9ovBcUV+rrG3geXBJS6Hbs49n2WxDGOQSEvXG71hKU7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7944
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> The mbm_cntr_assign mode provides an option to the user to assign a
> counter to an RMID, event pair and monitor the bandwidth as long as
> the counter is assigned. Number of assignments depend on number of
> monitoring counters available.
> 
> Provide the interface to display the number of monitoring counters
> supported. The interface file 'num_mbm_cntrs' is available when an
> architecture supports mbm_cntr_assign mode.
> 

As mentioned in previous patch, do you think it may be possible to
have a value for num_mbm_cntrs for non-ABMC AMD systems? If that is
available and always exposed to user space (irrespective of
mbm_cntr_assign mode) then it would be clear to user space on
benefits/risks of running a "default" mode.

Reinette



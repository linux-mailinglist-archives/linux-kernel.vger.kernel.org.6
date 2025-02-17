Return-Path: <linux-kernel+bounces-516875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9586DA37927
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41216188C155
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72232611E;
	Mon, 17 Feb 2025 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jh6Pum/C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC679D2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739751509; cv=fail; b=kN6XaEroigZWN5iiWMtTOXFgt9VJoWNQweDVCZRNirYbPfZqTUkkTv3ttipVNsjHFGjJYnJlCOjutV7JZrduFcjZ6MvcJWwwi8TD8KoKVdQlLpBnVcGZiUrLNuczM4aWVdz5v+w8j4BrzbxBH9XLHhw9/QOKqs1A9HrD9i8WRFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739751509; c=relaxed/simple;
	bh=Ps6RggQeVMXnVNMi1vvTv/aKcLhTORCcqevrw16vaWs=;
	h=Message-ID:Date:Subject:References:From:To:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=Pd2F/ttCPnqZeoJ4iuRpw/a4djS5DQm1RjVW486NNUfsspQp9hreid3u5L8cAHMzErvY3hmWiHVHt4/cXW+9lCpMiCy4935mcnDymC6HP0OzAUJ436d7yk/rDcA756uN01LVNU/is+GTLRsg7lzIw2YB+bPGPGne6Qvi20rFyQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jh6Pum/C; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739751507; x=1771287507;
  h=message-id:date:subject:references:from:to:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ps6RggQeVMXnVNMi1vvTv/aKcLhTORCcqevrw16vaWs=;
  b=jh6Pum/CGsxHiFxfm07clvlX9p4kxoEOdIdu4WHbfxh0x2EjTZJAF9iN
   DNsJ3PHRWB/aiiCYxWdV6AugXXTeSw/sS/YgO+WPnVfe3msFQcN+EUnuz
   D4+luhGoDhlEm/cZbT5rJTuUgUhcNYAn9V7ye7P8rDK724rOPbSoXaEwN
   iYhwdF2u3zqljlLNjzVVTgzckkvxPESE9TYCesL1P9lBACoqoTfrKvRTn
   u3CNaMgdvPxvgnxyUFOStjNToEEOPvLElqGgbF/kpTM3IqXUnsPYS3h2D
   W/yqRbRnGb9+fvY7w8wdQLt8BuLie3v2wiHRXEzZXJHvMDaGs8Y5sRYT3
   g==;
X-CSE-ConnectionGUID: 5PMeEnQDTzio2moUqreItQ==
X-CSE-MsgGUID: 6Y1wl/ZyTMCYXOYfE0UyGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40548341"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40548341"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 16:18:26 -0800
X-CSE-ConnectionGUID: CuJFHdL4SPGJLylwP/yLEA==
X-CSE-MsgGUID: cZURgqZ0R3GRGcV9G4/GZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="113851203"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2025 16:18:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Feb 2025 16:18:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 16:18:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 16:18:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1laRVj3kNSpQ6oEdv5Kn7LC2b7viqN0KcPqIJqiAXFKRdX7SzXgYKKc5VPNW8tOg32+s/Q9nSie1NX2Ko3rZHMkxiWBdUvdTPVuxeHkeGnK2EBSD6rw4d4NXLm+IEf3x8MTtk4FGWey4U04Z+fMv2yq++Lld646UQMCj73jyvpofxdNKQKOQ3Hm/F2KZ7B/TFhtWdfB+q6VB6/xIkFNLy5qUK872HFU+5FEcrAbiS06y7IMwRtvTROxZ9nYzOQO6UmG6QRL+qHDZlV5/VIABbNOBhwN7KKZL1ku2yloBbi9Fw0A1v7NfqSJaGzyU46HnelP9r1hWNE384YXlslHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O+54nRHYZN4fctyS9T2NRpzVmtAIIlsKMrVoxJPvUY=;
 b=vYtBvqxvdtJz1llNQzaCRO+MH6cj0OshLxpD+F9nbzpDqBeXwdD8c21SnkB5dvNENM5j9ly1W/tzb4oeuNHILHqaulzIQw4M4myZylfqI1eC/7/oZjEXGEelOrhZRoKhCGb6CMi+41N1npkcEpf78G7afl6wE9QTnPzf1R1Ra/MX/7ws6drU+nSMtL2plYbskctc7j2X9MdnaCXT+eiK4ILzuVWwBqmdKL076b9xEhR43Ox9cf8qbyoC96TG2p2+fFuNUZ59iwLUckzss907h/1B7uM3CSDYdi0Np2F0VFdps7h5NSXicBR+wWhWneupHoZIzLZdMQm8vAPzlVjudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB8221.namprd11.prod.outlook.com (2603:10b6:208:451::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 00:17:51 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 00:17:51 +0000
Message-ID: <828df2dd-a099-4146-96fe-0915cfa2e4b5@intel.com>
Date: Mon, 17 Feb 2025 13:17:39 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tsm: Add TVM Measurement Register support
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <20250212-tdx-rtmr-v1-1-9795dc49e132@intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
To: Cedric Xing <cedric.xing@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
In-Reply-To: <20250212-tdx-rtmr-v1-1-9795dc49e132@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|IA1PR11MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: b89dea70-a8ad-4556-221e-08dd4ee883d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjlMeW91eWVrYTZpbWpzaWlFdTFtMS9yWkFZWmRpZVU5YW5oSjhDZ21jdWh2?=
 =?utf-8?B?L2Jxc0pvMUl0bjhMRmxUa3RPL3Z3eUo3dWVYOUJqcnB1SXRjd0VQenNmQlNw?=
 =?utf-8?B?ZFJBN214MitJQ0lRRGhlTlQ1RisvUzhvV2w1clRBMmpjcndsZStCZ2lGbTky?=
 =?utf-8?B?a24vLzVQRC82SmFIT1ZNUnl5UWFISnRuTmpzamVIMEtmTVBiZXZsNk8zR0Fo?=
 =?utf-8?B?UEg3WXcwcmYvalBtR1o2L2l2bHdMTWNKZ2F4VWxaeEtuNVJtTHdjQzlGUFJn?=
 =?utf-8?B?U3lWZ2RNTDVGMVpva2VyUjJ2d2xBV0xUVkpSQkQxZzJua0VIOVcxOC8yWXhF?=
 =?utf-8?B?bXQwUUNSQlNscGY2RUNMVjJCaW9JTUZvNjRBMW83UHdpR2h5M2lXZFg4V1FS?=
 =?utf-8?B?SUtTak5XbjZ0clB4ckJMbmo3QUpSUTcyWDdNWVMzWmxSQVhGQklheCtEWVly?=
 =?utf-8?B?QXk2K21qdlg2MzBoUTdxcmRmM3JpbU14Uk1oOVZSd0tnai8wRFZHRVNqbTJy?=
 =?utf-8?B?V1FnS0R1T0J2NmI1QnlJTGlkMVlZUmczYXJwYlBxZUxheTV2Ky9wZHFJMElK?=
 =?utf-8?B?QlZHQWFtMnJzL2FUSlBRbUcvQ2FpdVJWTFhlRjRVR29Id2R6TlBPazZjdXNL?=
 =?utf-8?B?N2M3U1Q0R0puMzNISGM0RDFpc1V1c2NmTzlDbmg4M29qMjNrOEtMaXRtamNC?=
 =?utf-8?B?STZJemd2d3JlLzl3VThxQlZrcWhvREFSY094M1JjaGpHZlNRTGJKK2k5Uksy?=
 =?utf-8?B?TEVqeXlKQlZpandicEkwYkFrTVlLT0xXZyt2QVB2UURkUDRYWWZ5V2c2UW1n?=
 =?utf-8?B?WHkzK3pGSVFTSFk3RThkOVZHMW1BcXBCL1JIMVJZeG12dUNySGk4MGhwM09Q?=
 =?utf-8?B?MWtkNDlRSVRlTFluMGgxYnNmQkc3M1BRUm8yMHNnRFc0K004QjZLZzZmQ2RI?=
 =?utf-8?B?N09mMVhRRzJ0NGdXVDI1VDJCeU1vOG1XR1VHZ2U5U3JBZmZFWmN0bjBQQjJF?=
 =?utf-8?B?UWIzY2hoN3BySUlMYmtUbWYrV3ExUEs0M1g0YWhmZlNGZnR1ZXRrYmcxSVAy?=
 =?utf-8?B?aVlmUmhPa2dDdGhJNnVLTG9FejJvTTIrWGR4em5BV0xOdFpSK0NiMklhb1I4?=
 =?utf-8?B?ZGhxdWRTaHIzMTZDcS9la3V4N1NDS2FMOGpIYktkbnRiWXExU0tkcmVvL1hi?=
 =?utf-8?B?eFB5YUQ5MVVBdC9HQloxTTh1Y1pSd0Zwbk54Ri9FaGpvOGhBSnQxbnNvdmd4?=
 =?utf-8?B?VXZuNWRPUDB6QUo5MmE3S2N4S1VkbHNaTXNHOS9nSm5lQ2gzWmI5UVBYOXp0?=
 =?utf-8?B?UllMZXE0am8xOHd1eXE1VkNUbTdhbXY2aHdLd0QvZ3JPcXFXTHBhNWFBaENV?=
 =?utf-8?B?eWpiazM5NXpvV0I4STlPSDlYL0dveGVWaFZYU1hUZklZeDVZKythWDdCanhM?=
 =?utf-8?B?Y3Nrc0NSYXhONjR2bGJqdlVCQVBDYjVXR1JFa3hveVN4MjA3cERycm4xS0N6?=
 =?utf-8?B?eFAvaVJKVWU0ek43VlJreWRQVVZxWHNra0dXVTRQYUsweXB5Z0NvZm0yZFVS?=
 =?utf-8?B?WlE0SC9NZlU2OFpyUmVKVzVDNDhMT0ViUC9wcmJic1RnempLQkFJSkZzcVpF?=
 =?utf-8?B?YmJ4N0FkWGMwbnZXZzhiS3A1TERkQ3RaMFhrbkx6YlBzaEJ4cGVYQ0NoOUEx?=
 =?utf-8?B?a0c3MUttcitockFVeS85Ym54SjR1aFFtMW42Sy9WYkpHb3JiZ01Pa1daa0p0?=
 =?utf-8?B?UXFadVVoODFsNmdpMi82VHNQa0k4RmFYYVZpVVNJQ1J6VGhmVCsvM0JyZ04w?=
 =?utf-8?B?bFRoa283N21BQjFsVzBybmEwTHZXY2pxWGJrcWFMNG92cWI4S3ZRazhEek9q?=
 =?utf-8?Q?JuxbbD9azUnTQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cno0dGxQVW00aTlvN25Uemd0c0FST1BqakdWQXZURWdwcEM2TDB2Z0pRN2dM?=
 =?utf-8?B?ZEFCRUsyVjRNcjAvcDVNSkhybU1hNWhVRzBDcjdwUjc0TTdZcUF2NVRKQitM?=
 =?utf-8?B?TnlVMWp5ekh2VVYxTnJCNHByRWJiZ1B1YTRyZWZjcTdrNHFwUEhIb0VwdkVB?=
 =?utf-8?B?Nk8yL3ZKU3pMc003YUI4L0tZTWR2SjNvVmlQbVJuVGEyQzM1Mmt2V1YyTGRG?=
 =?utf-8?B?SGdZOGxiQnA3V2crR1poQjR3MTF3dnB6Q2xnSmNGWXFNRkw4VmNBc05GRDBx?=
 =?utf-8?B?RGc1Y0NNQzVqNGFNN3p0UHNzaUtUNXN3RjZSTHNiUmFvQjRYV0RNYThzdHJN?=
 =?utf-8?B?VzRMWEU5c3Q5bjhiZUhDZGg0QkZtQTgvVU9MbGllYm9lb3pkMVNCc3g2WTJV?=
 =?utf-8?B?YUNNRGFva2c3M0hKTTFHb2JadUNVcXA1RU5MTTFYL01YZ3A5RFpEaG9zM2ky?=
 =?utf-8?B?NndCUkdldUM0aUFNK3FWNERnemdGcWhsck9lZE9hM21wYThkY0tab3FWQjA5?=
 =?utf-8?B?Qmg4NTFPYzNwcFJTa2FEMDNmdnRMMlZqRnhaNlRMY2d2ZWQ2L2dEOG9mNlZy?=
 =?utf-8?B?R0V5c1dIM2gyQm05Nkx3b0hIbDZsTkFWMEFSQVFwQndodGRPQ1JmWlp0NCsr?=
 =?utf-8?B?YjFKZnBYWW1KT1JUNUpobmNNckFUMWJVMHFpMk1SZEpZTUxpKzR0M2ZXRzNZ?=
 =?utf-8?B?R252Y0lpcG9qdEFVNEhJVnN2RzlNTSs1LytsaEJMeEdWWW9BVWdBOEJCSmly?=
 =?utf-8?B?aklOMkdPOWNUdzdwSXQzTkROeHJpQzFlc0VyRGFiTFRqZXdtWTBrdjhocENP?=
 =?utf-8?B?YnAwRlZ2UGxwY0FIYUREazBGaWZ0Tm5aazM0b21lSDhqOXVYOXp5c0NFeUdP?=
 =?utf-8?B?czdqU2NRUEhna1lJMVo3WmpHSEZsb3FIbW5hT2VtaEdxZlRsQU5xYUQrbnU2?=
 =?utf-8?B?RktGK2Q2bWE3eVhjRkhMY3pYd0I2S1FJUzF5eG16S21sQmtEbUZnNEN5KzVY?=
 =?utf-8?B?RkxCbndiZjJURFVlOHRnTlpSRWpiTUxBNnd0TnQyaGFXS3NEOHd4T25QeFMz?=
 =?utf-8?B?NFBTQkZBMW1jUFV1TFBHVFY3NVBVNjlEcDdxQjJhRkVxV0pjUkdxQjJsSEVX?=
 =?utf-8?B?Qkp0WDdmSm5QVGZiM0hIUitGeWlVUTJpbm11dm9sUDhUOGdHNEt3aHFrWUJ1?=
 =?utf-8?B?Z3o4dnUrMzYzQ2lkd3hmdk9iYTZCRHB4Y3F5emFVaUxhS2lKcDV1SFNMVVRE?=
 =?utf-8?B?Q08yLzB6L2FPSTYyaEZtRnNzekRQVjNtY0lMcFpNQUxjU3dPU0xPSllJMXNF?=
 =?utf-8?B?ajRxaEpDYXQ3bEhmQXBqV1c5WVduTk52a2VOQmFpZ3hNcCtYTm8veHcxcjlE?=
 =?utf-8?B?Q2dENElqSHpXSElkTjVHbWNieDJWTm4vRkQ1ai9oSHE4WlpibVlPMjh3UUVu?=
 =?utf-8?B?Q0lRQnBDdmNXRWUrZE9iUzVmalpKZEptQXMvT0ZYNzBWZUFibjdoKzBKWldr?=
 =?utf-8?B?enlvQ2RESFdZTHhnZU43Q0JnUHNzUEV5SFFocVVNUEhLQ0czY2MzVERNSzlR?=
 =?utf-8?B?TEV6eXd5aDlNaFBrZkxPTmdmQUtnMlhjN05NUXhkbjFJY05BQzEzenozRFlY?=
 =?utf-8?B?VlNheGlscjRsQ2U5cXdQV0RiL3I1VmlnUUZ0ajBWTlFod3lJWUZVZmYyay9I?=
 =?utf-8?B?a1dxRCs3S1BLL29IeWN3dlgrSEgxUk1ZZTdMMEZJdkNJeXUvRjBWOVRxS3d0?=
 =?utf-8?B?MlJCd2ptVStpZ2FVNEpMdGRwTWdoUUxqUnNVQkxZWDNBWGxGK2dwWml0RGxD?=
 =?utf-8?B?Nm5HeW9JVzcxblZFUlRPeGtqTHVrQVdBVXpCZHU3L1JYazZNNUVVZ2tnQ2M2?=
 =?utf-8?B?N3RySTVZcGhraHUvSnA5bmVNa1Y4WE5NUUZSR09mYnJwejg0YzFOMk4zTDhm?=
 =?utf-8?B?R2NuK3d4M0paVHpqL2tZdWxpUXpSazRkMDUzazRNNDhjVXRwbTRHN1ZOUDJt?=
 =?utf-8?B?b1pPaW1qR3QwdVNiSDUzL21aUWUvRy9USUx6dDRZSks0R0Rkb0hCamNHM2tZ?=
 =?utf-8?B?MlduUC9lb0ZTeUdqZjEvMThVRVVZdmFVMzNLMnBVNkFJNDM2LytIRmVQeGp0?=
 =?utf-8?Q?NZqfHzCQu/a4q2CyWdlgDXhmb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b89dea70-a8ad-4556-221e-08dd4ee883d4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 00:17:51.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQ0tiYEGc+yK20/pd4rKNvDwemJtFB13guwxcAs8E+Jcj5XiKFNrrcEtCoAMeQY95HJtHk+gmdhERYVpFsug1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8221
X-OriginatorOrg: intel.com

Hi Cedric,

[...]

> +static ssize_t tmr_digest_read(struct file *filp, struct kobject *kobj, struct bin_attribute *attr,
> +			       char *page, loff_t off, size_t count)

Better to rename 'page' to 'buffer'?

Since page normally implies 4KB alignment but I don't see we need the 
alignment here.

> +{
> +	const struct tsm_measurement_register *mr;
> +	struct tmr_provider *pvd;
> +	int rc;
> +
> +	if (off < 0 || off > attr->size)
> +		return -EINVAL;
> +
> +	count = min(count, attr->size - (size_t)off);
> +	if (!count)
> +		return count;
> +
> +	mr = (typeof(mr))attr->private;
> +	pvd = tmr_mr_to_provider(mr, kobj);
> +	rc = down_read_interruptible(&pvd->rwsem);
> +	if (rc)
> +		return rc;
> +
> +	if ((mr->mr_flags & TSM_MR_F_L) && !pvd->in_sync) {
> +		up_read(&pvd->rwsem);
> +
> +		rc = down_write_killable(&pvd->rwsem);
> +		if (rc)
> +			return rc;
> +
> +		if (!pvd->in_sync) {
> +			rc = tmr_call_refresh(pvd, mr);
> +			pvd->in_sync = !rc;
> +		}
> +
> +		downgrade_write(&pvd->rwsem);
> +	}
> +
> +	if (!rc)
> +		memcpy(page, mr->mr_value + off, count);
> +
> +	up_read(&pvd->rwsem);
> +	return rc ?: count;
> +}
> +
> +static ssize_t tmr_digest_write(struct file *filp, struct kobject *kobj, struct bin_attribute *attr,
> +				char *page, loff_t off, size_t count)
> +{
> +	const struct tsm_measurement_register *mr;
> +	struct tmr_provider *pvd;
> +	ssize_t rc;
> +
> +	if (off != 0 || count != attr->size)
> +		return -EINVAL;
> +
> +	mr = (typeof(mr))attr->private;
> +	pvd = tmr_mr_to_provider(mr, kobj);
> +	rc = down_write_killable(&pvd->rwsem);
> +	if (rc)
> +		return rc;
> +
> +	if (mr->mr_flags & TSM_MR_F_X)
> +		rc = tmr_call_extend(pvd, mr, page);
> +	else
> +		memcpy(mr->mr_value, page, count);
> +
> +	if (!rc)
> +		pvd->in_sync = false;
> +
> +	up_write(&pvd->rwsem);
> +	return rc ?: count;
> +}

The logic around using pvd->in_sync is kinda complicated.  MR operations 
seem like a classic reader/writer contention problem and I am not sure 
why pvd->in_sync is needed.  Could you help to clarify?

[...]

> +
> +/**
> + * struct tsm_measurement_register - describes an architectural measurement register (MR)
> + * @mr_name: name of the MR
> + * @mr_value: buffer containing the current value of the MR
> + * @mr_size: size of the MR - typically the digest size of @mr_hash
> + * @mr_flags: bitwise OR of flags defined in enum tsm_measurement_register_flag
> + * @mr_hash: optional hash identifier defined in include/uapi/linux/hash_info.h
> + *
> + * A CC guest driver provides this structure to detail the measurement facility supported by the
> + * underlying CC hardware. After registration via `tsm_register_measurement`, the CC guest driver
> + * must retain this structure until it is unregistered using `tsm_unregister_measurement`.
> + */
> +struct tsm_measurement_register {
> +	const char *mr_name;
> +	void *mr_value;
> +	u32 mr_size;
> +	u32 mr_flags;
> +	enum hash_algo mr_hash;
> +};
> +
> +/**
> + * enum tsm_measurement_register_flag - properties of an MR
> + * @TSM_MR_F_X: this MR supports the extension semantics on write
> + * @TSM_MR_F_W: this MR is writable

Why a MR can be written w/o being extended?  What is the use case of this?

> + * @TSM_MR_F_R: this MR is readable. This should typically be set
> + * @TSM_MR_F_L: this MR is live - writes to other MRs may change this MR

Why one MR can be changed by writing to other MRs?

> + * @TSM_MR_F_F: present this MR as a file (instead of a directory)
> + * @TSM_MR_F_LIVE: shorthand for L (live) and R (readable)
> + * @TSM_MR_F_RTMR: shorthand for LIVE and X (extensible)
> + */
> +enum tsm_measurement_register_flag {
> +	TSM_MR_F_X = 1,
> +	TSM_MR_F_W = 2,
> +	TSM_MR_F_R = 4,
> +	TSM_MR_F_L = 8,
> +	TSM_MR_F_F = 16,
> +	TSM_MR_F_LIVE = TSM_MR_F_L | TSM_MR_F_R,
> +	TSM_MR_F_RTMR = TSM_MR_F_LIVE | TSM_MR_F_X,
> +};

I am not sure whether we need so many flags.  To me seems like we only need:

  - TSM_MR_ENABLED:  The MR has been initialized with a certain algo.
  - TSM_MR_UNLOCKED: The MR is writable and any write will extend it.
  - TSM_MR_LOCKED:   The MR is locked and finalized.

The TSM_MR_ENABLED may not be needed either, but I think it's better to 
have it so that the kernel can reject both read/write from userspace.

> +
> +#define TSM_MR_(mr, hash)                                                           \
> +	.mr_name = #mr, .mr_size = hash##_DIGEST_SIZE, .mr_hash = HASH_ALGO_##hash, \
> +	.mr_flags = TSM_MR_F_R
> +
> +/**
> + * struct tsm_measurement - define CC specific MRs and methods for updating them
> + * @name: name of the measurement provider
> + * @mrs: array of MR definitions ending with mr_name set to %NULL
> + * @refresh: invoked to update the specified MR
> + * @extend: invoked to extend the specified MR with mr_size bytes
> + */
> +struct tsm_measurement {
> +	const char *name;
> +	const struct tsm_measurement_register *mrs;
> +	int (*refresh)(struct tsm_measurement *tmr, const struct tsm_measurement_register *mr);
> +	int (*extend)(struct tsm_measurement *tmr, const struct tsm_measurement_register *mr,
> +		      const u8 *data);
> +};

 From the description above, I don't quite follow what does ->refresh() 
do exactly.  Could you clarify why we need it?


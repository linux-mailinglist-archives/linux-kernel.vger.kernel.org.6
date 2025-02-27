Return-Path: <linux-kernel+bounces-537245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71555A48997
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC353B72E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0771026FA7B;
	Thu, 27 Feb 2025 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EudCmuJr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E11AB6D8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687307; cv=fail; b=KOg5140sJunR8XSa289fZhYV79CIW3PJ3z4aym7QU3wrnhqBgibfW9Ac4FNJy9mmChp/QQx2qSsW1t20NjKia6htF8/8OhR8BiEaGx2nOuTaj0fl2aN5PVaysa1mhifBBHnbE6E7mQjN6CSZGXvgPcM79CceR+j7V+RKOIJTquk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687307; c=relaxed/simple;
	bh=mSS/gJJ+pSe4osmZH87CADUPN2eyhQQjCpeHo6LGs/w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=izqJvVANjIK79WE6lCzLRka3xSjimHp0autDDe22CwgAnBzscKUA4DnVdVep+7qIFqJCU6ntvzbe2LYQvQP7F0WhyDp/dDZQ8nK62vhECuWDxRIitHr47vadtPoSq/JrF1bP1FozfSOgSBNEuhRVmamnM/2K/DHuG/LTb6p60NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EudCmuJr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740687305; x=1772223305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mSS/gJJ+pSe4osmZH87CADUPN2eyhQQjCpeHo6LGs/w=;
  b=EudCmuJrVOnYtBgviBcOkkyG6XbGT8+tF1wdzB/SperdX43MfpU+dZmW
   nLKDJsPX6sKNmFXufRTP2K+y+y6XFU+cfsOmhXkn3PFobClkef24cJm2Q
   DOK8v7y11rQho54c5ruD73T6DMnP6+1GhR1pmleg9SsljZp4Q1nRI+1Xp
   1Q/vJZq7Db1WRip2w/hEViQC698yAQcIjc7WaYn9SyhZw0lqNde7yvjEf
   cZuKXldHbJoaL3SxUl0O+Bs9o5HLCKxETjaGUe7/Mxz/koyyClTmBQ/r/
   9wVn1I3UbR6xVm4uml4ujgoKvts6lwECfMYxvnVWm7IyQ9qr6miBGt0Ek
   g==;
X-CSE-ConnectionGUID: SKP/V0paRtCyy0rBxYy12A==
X-CSE-MsgGUID: 7LDKcdJyRWGzaCujVq7ebQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41517132"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41517132"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 12:15:03 -0800
X-CSE-ConnectionGUID: Z/a+ooPrS+6h9u6QPLfe5Q==
X-CSE-MsgGUID: 88Y+1QkcRKKHh5mbChE+IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="122257028"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2025 12:15:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 12:15:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 12:15:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 12:14:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ap992ieiK07e0dmPHHdgbAXRxBY4Bv1xtFJqfmbCFdNy3ivvIxr0+3mG+lzuxKphPwjZXK33NbRLIQ2E2P7xRT+KuAIKzF/5v/WJZmNZXddJ+3uncX6h43ZOhY9RXTw3qqHdtdk7Tw7aCU9L08ZWgmfvwS8QleAwyY9sAWKCJ2dJNKurXIOqQa4fJY32HDYibRJTQK92mxLyITGMSIP0NBGVQnqYWhtWXOPojnyVRbKaYzYVYRAGVZbR+On3e9KseCJetwVmIQTC0n5P7hWvIbmeJ7PGzL9B6uVarWAMMBAAMW1TP4Ln8JsG/lOMzBxKsHh931WP2H93PNfjgEPhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4G/Z7GM1PNUpKnC2J/KFH7NxBQmm0gUN69oArMJTs0=;
 b=Idy+WNQWrHEKDXIR6KoXAQYcHs273LcN9e//mVE4lw7NGcNi7gGYjyOZ+7+cvsNFwHGrR6GKW/5M9nPFtd8TonC41ARDhEUdhqVhODsTSDG+YZDoGhOrnJ7ZMlSFz9RvyhgTVTM2JEwu/Hds3+smk9PoJur6F7cWHIJvHn+kyziekMMs0BleDCvq4UF4Cv2kZWilyudZvSncnNc2Xfj0bsRwZ1x6DaUDhRJukzWUAZIJXEncPCrYgh7F+FL/TD+iwEym+aqjGOup4BfAWJY6tkIQ+XBxf9I67rMsBb+mqta9jdfN4MaAZd8kZc6b7oo/AZvfv4XxxA+Uct2GsJEwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB7399.namprd11.prod.outlook.com (2603:10b6:8:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 20:14:44 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 20:14:44 +0000
Message-ID: <8b174f56-191b-45bd-93ec-4c6444c770a5@intel.com>
Date: Thu, 27 Feb 2025 12:14:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/cpufeature: Add feature dependency checks
To: Ingo Molnar <mingo@kernel.org>
CC: <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, Uros
 Bizjak <ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>, Sean
 Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>, Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>, Xin Li
	<xin3.li@intel.com>, "Alexander Shishkin" <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20241210224037.3052555-1-sohil.mehta@intel.com>
 <Z8Cy-IonwmCGNkkQ@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <Z8Cy-IonwmCGNkkQ@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:610:76::32) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d690f42-6836-4f39-a442-08dd576b6021
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTc2MUE3UW5iYWdXYWI0QUdsVFhDRGpyUlBjV1BlV0I4Z3NZc1Z3d2RJcnIy?=
 =?utf-8?B?WHRtcmE4K0ROLy9HMmRuSnpEK2h1ejc5UWsyOFNBelA3c1EyRkp0azZ6R0d3?=
 =?utf-8?B?RkQxQlYrcFVqNlB2Q1lpM1JDaVpKa3ZPdVM1UXozK1BRcTlFTHUvUU8xaUJj?=
 =?utf-8?B?OXlYYUV5UmhYVGRrTndFYzJwbEwvYVJJS2Era2RTUVE0eGpjbTlsZnhtVmNv?=
 =?utf-8?B?SHBpVmZITTZoeVd6NVFtYnpQSGZLeldtdmxSWFVvMkxlbUNVd1AyNTA3M1px?=
 =?utf-8?B?T0IvQjdMMXErWnpSYTZ0THVCMnJzSytOUFdoUzFWNWlHa2M4eVdUeE16MXFz?=
 =?utf-8?B?cXhZYTZTVDlFZnJOZ2g0a0dIbnVjS3lNSFJkb2paNEkyK1BaUnZYYlJVWjgr?=
 =?utf-8?B?REk2QmhOcWFSVTN2SkFISVJFd1NnQjBtR3RTbzJyWVF2eVpHaytzcExjenhu?=
 =?utf-8?B?OThOZjFCeFZ3Q0l1cGhFMFJSTTFyN2hwT0lCNll3alJ0aHNPelBuNVVvY01I?=
 =?utf-8?B?UFJQaVp0TnJNY0ZBMFJ1VmZ0d2ExM2Z1NHliMEVlODBTWFNzeFlBS1YwYTZs?=
 =?utf-8?B?c0ZGaC9KVjRUN3dQMVR6NHNQNGJUMHdJdWljWk5HNmZVbm9tNGFoSFo2bGY3?=
 =?utf-8?B?RHpJT0RZU0FJK0VPb1Y1VzZjclQ5bTJROG9XaFpaQ2JLV3FmaHFTcW1FelZl?=
 =?utf-8?B?OWV2N3l0ZjlMemNaa2VHdEsxdUc2Tmhyb2VyQTRzNTBKSHBuMUNXWHZEeUpV?=
 =?utf-8?B?UzR2MFhFdjB5SXJUT3ZOdHl5aDE2NTlrc1Y5cXVoTHkwdFNTVXFhRFRneDY4?=
 =?utf-8?B?UURTclMrRVhNU3FPUDdUWDNQMGF2TytFMWtNai9zSnpxQXRtUkIzVlZJZm1z?=
 =?utf-8?B?NmRBYUNwZkdycWxHK2NTakZDdGw4TThmZUh6L2Rjd3hJMkxkbnd2bVlRdWQr?=
 =?utf-8?B?VG9sSmtkdWJpVnR2M2VoQkZsTjc5WVJyWCtFUFZ5WG1NOVpBYUVIWUNiRzlL?=
 =?utf-8?B?dzZIazFVTTZmb2dBT3Q3aHVtODdweDZLWXdVNFhhNFlNd1JjcE80aXcwd2c3?=
 =?utf-8?B?bEFLWGs3d3RxOE04cjI0dTd3bUpwYm1VT3ZENFg0bkxuS3o5YTBMelZPWncy?=
 =?utf-8?B?ZDFKeDNuN251dEt2QWhxNzRrUjFvdWdyR0xJZmZua29pU3E5Q1hnMVdOalUy?=
 =?utf-8?B?TkdHNGtRMmVNN1Q4aVQ5OURleGZKaXBqL3VsWS81RzlFM3RSVm5JRGx2TDh4?=
 =?utf-8?B?ditRdGduQk81UUQrSW9YMHhpTlowdjZHcU9SZnJjbHBqcExzcCtyZWpLS2x0?=
 =?utf-8?B?U01YWDJyQ2oyNG83WTZNLytaWm1iOFd0NkVUaVF0TVBxdGtTQlJKRkxPNVRh?=
 =?utf-8?B?TFY0RDhKQ2YwaG15T2dZeXQ3T3kzdzIzNlVtc2dteUpua2I4ZHZ4aENnaXF0?=
 =?utf-8?B?S3Vwc1Y3SzdBcGJhdU1Rb1haVzlxZDVhbWgxdXlZZjFRYjJ5Q1VGcmtOYXk2?=
 =?utf-8?B?V3hYVTVnSUZocVRZRXJuRDA4dTNQcURTMzRRYVRqeTRPdFkraXh3RU0xT3Qw?=
 =?utf-8?B?N3R5MzZvTXpqMlRjZXlxNnk0cml4TUZzTGl6MDRSZUFzM0NjS3RJV1pwTVFl?=
 =?utf-8?B?SGVpSmpYMSsrdWh2L1o3K2RGUEtpSFlpSCtTQlkyZE9NSHEyNHlnMjBadzU0?=
 =?utf-8?B?VllnZzQvUHNRMVAzZklDL0xOb01GZ0NSMGlMOUR3NnJJUmhPa1BmL2toamJz?=
 =?utf-8?B?RHhQRmhmR1RxZENNRlhHdXF2YlV2RStaMlM0TWFqYjdiaXAzLzVxOXY2UTk0?=
 =?utf-8?B?aWZpazM1aUtML2czcEk1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODRybGtPZ1BJYUY4SGFYbzVkRXJTK21xVGV1ZWtpWVYyZUQzdGxUUWVZV3RH?=
 =?utf-8?B?M3VKYzBrR1VuWldnZE5iY2Jyb09MeTRGZ0M2UHlJMk5UL24zbmFySlBxVlB2?=
 =?utf-8?B?eGN2c3YvY2t2RGpGd2l2VVMvVkFDMnhxcTl1UWxrUDJNUHYrcGZ2VVVFR0Z0?=
 =?utf-8?B?Tm9jN1NwSDF4bzBReWl3clVNVjBFSEpRZk5lTXMzaS9rMzRLOEpyWm1rMmlQ?=
 =?utf-8?B?SFkzRU1oR1ltUlkwa2IxQjNvM0pUeEFkNk02Ky8rUzIxWTkrdEZPUzN4eHlz?=
 =?utf-8?B?Q3JFVnBvVGZOcGU3cnpWVFpERERqbTVUQlg0Q1pxanFMcWNnQU5IbXI2Wk9J?=
 =?utf-8?B?OUZ2R2FOenBWZnUxSWM0WjZHaytaeTl5SkJMRWIwU1M3VnJhTW1MZmlhQlRX?=
 =?utf-8?B?VUpvOVgrUWowQVVLY0laT3JhNlhxRStOYjdDMFNYVzJua0MvVUNQN3FzMC9s?=
 =?utf-8?B?UVhEbWxjejBtVkkraW1iMFo3S2NhdXRsQlhUcEVrcitMTXAvczB2MWhjK2ZK?=
 =?utf-8?B?SjB4UzdBelJJYXdWdHRKWVhKZ3FVZmIyMDRPZkhwNjlMb05Tdy9oMDVKOXZt?=
 =?utf-8?B?TEw3M1pzVFVXakpzaWJHREhVVVl1TFVXWlFqbVVsaDkvZW5KajZLZUpsVUNE?=
 =?utf-8?B?NEVRcnBETkE4d3V4Z3ZXSHhkci9HQ0tUREZoV3QxVDljMEozTlQ4aHNDV0pO?=
 =?utf-8?B?MjNMV0lscDg5M2JiM0tIVGR5SGRYdVBNRm1scmJLUjFkUHlUYzAvTy9qNE43?=
 =?utf-8?B?cW5PemZZZGlYVnlBZE9kN2drMkFkeFZpakJlTGVmTjhNdHoxSDBwR2hHZGQy?=
 =?utf-8?B?NXFMTHhIVUNYRTEza2ZpVzMyUk8vVy9wcW5mT0NuSW1GdUMwcW9UT3EvTjJM?=
 =?utf-8?B?djR3S2NyZUZHTFQ3QjFwY1M5b3lFc2s1Q01HdURHVi9KWjdadi95bjNlOThu?=
 =?utf-8?B?TGxxL2hFRU9qNDE4M05kOXUwbVZuQ1NHUnNOUnl5VG1rcUpBUVJNMXJ5dDRS?=
 =?utf-8?B?dW1UT2kyUzNLbS9DQW5HcHVTTjZ1Wjh6RG9xYmczR2t1RzVWVnhobkF1dHhs?=
 =?utf-8?B?VmdpV242SFJRazNISDM1N1lDdjBaekhQUUNhZk1GSzVzQXJWZkVaV21uN08w?=
 =?utf-8?B?RE9USGdwb2RGUVdIREhqcDZrNUU1WlgrcU1jTllER3JwSmcvNGQ0dWl6Tk9s?=
 =?utf-8?B?SW9WNTdjTVdoY3ZlOHBIZlZvY3FmL05JcGpsbWpCdDJoS0dFSlZtWktLV1NQ?=
 =?utf-8?B?ZFRRVU9KYVBLSVlGU3BqM2IvV0l4N0FRRXpDZ0hTY2hnOGFodlRnc1FxQ3Vl?=
 =?utf-8?B?VE53eUw3RHMxZDhSSlcxc2YwTUhtaG9Ebm1MSnZIbkFEWHYyWWZkTTFKSDlp?=
 =?utf-8?B?RTVvMVdTUmtUcEZVYTFyNmpDZE1ncXFOYlNPN3Y3MlV6VlpBdkh3S2h0MVl5?=
 =?utf-8?B?S0tPQjU1ZUNnTk9HcEpIRG5BZkRscW04TVpNQ1M4YVN5M3VHQUZsVzBpMUZt?=
 =?utf-8?B?N05rUzlaT2V4T3RKT1o3Zi9QYkVCWWhRZVNUekFoYmVQeE1KYTFManVXWUhE?=
 =?utf-8?B?L0pHbXd1dHduVlBSQ05oTEc0cnZBZTRBWlpzODYvMXN0WlI5TnJjQnlRUWQx?=
 =?utf-8?B?NmVWYmtoRGtiZXdRWGltcFVhZkRXTFRnMWorVys0cWEramlHT1YwYlMzNlBN?=
 =?utf-8?B?clVMMmtlR0xwcyt4OWZIeDQzSDZDeVp0M0ZpTlVxYnFpKzFqSTZOYzFjSDVV?=
 =?utf-8?B?d1c0VEtKcWdFTm9RNUJvRldvZ1ArTjhaNXpoN0loRHVKNXNPdzJJQWVrYStH?=
 =?utf-8?B?clYwM0RVbVBacTdPRS9sV0oyZlc5K05SVzZHWTJtVHBTUmsvdFRnbm9TM0R3?=
 =?utf-8?B?U29oRHNTWEgzNnNTQjA0RnlxaGhQN2NjVVNwVkNteGdNb2g1eWdlT3RPWXdG?=
 =?utf-8?B?ZEplQ3o1OXlxQzVDQkNvekJ3QmZLdXRhSENBVDNCcVE0OHhVcFBWV3ZTSU1S?=
 =?utf-8?B?b21JNzZtUUEzUjBtRThRM1l1Rld0OEpxTHEvZ1JCLytTNXkxQ1QwUUFmcktl?=
 =?utf-8?B?UkFBYXB6TUZYVDY3MCszSTgyQ1NkOTRXa0FLWUxtaXBqeitQQnRKL2J1Z3pY?=
 =?utf-8?Q?pmMYnaj0mi47GLc+FdOuopBVa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d690f42-6836-4f39-a442-08dd576b6021
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:14:44.4610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qetqSu6YS8S9+T5seiaW2+ETamfUVVKsZPwZU6yAeS5QhhdQtdqD3HT7zB93BPUyMO231Fcm8OZxi978n1Ccng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7399
X-OriginatorOrg: intel.com

On 2/27/2025 10:46 AM, Ingo Molnar wrote:

>> +void filter_feature_dependencies(struct cpuinfo_x86 *c)
>> +{
>> +	char feature_buf[16], depends_buf[16];
>> +	const struct cpuid_dep *d;
>> +
>> +	for (d = cpuid_deps; d->feature; d++) {
>> +		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
>> +			pr_info("CPU%d: Disabling feature %s due to missing feature %s\n",
>> +				smp_processor_id(),
>> +				x86_feature_name(d->feature, feature_buf),
>> +				x86_feature_name(d->depends, depends_buf));
>> +			do_clear_cpu_cap(c, d->feature);
>> +		}
>> +	}
> 
> So let's not disable any CPU features actively for the time being, how 
> about issuing a pr_warn() only about the dependency violation?
> 
> I think the main problem is when these problems slip through 100% 
> unnoticed.
> 

I guess you are right. Highlighting the issue is the main part. Beyond
that we can leave the system behavior as-is for now.

Most of the listed dependencies seem to be spec-driven, though the
kernel might create arbitrary dependencies for security reasons such as
making LAM depend on LASS[1]. I think those can probably be handled on a
case by case basis during specific feature enabling.

For the new pr_warn(), I am considering printing it only once per
feature instead of printing it on every CPU (which could be 100s).
But that would mean tracking it in a global feature_warn bitmap.

	DECLARE_BITMAP(feature_warn, MAX_FEATURE_BITS);

Another option would be run the scan only on the BSP. But that could
cause some issues to be missed[2].

I am wondering if there is a better way to do this?

-Sohil

[1]:
https://lore.kernel.org/all/20241028160917.1380714-15-alexander.shishkin@linux.intel.com/

[2]:
https://lore.kernel.org/lkml/ZsfJUT0AWFhoONWf@google.com/#:~:text=divergent%20features%20from%20the%20boot%20CPU





Return-Path: <linux-kernel+bounces-364432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA5899D496
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D6C1C23E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD21AF4EE;
	Mon, 14 Oct 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVh3cfSU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E828FC;
	Mon, 14 Oct 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923149; cv=fail; b=f8eojjR6B3pO5rHb5uuhWUwmB/YQokaW4FqJR89H8gZUu4RfOTdBSO02Xn3gyowxIPSgiEvnizdIuuVQ48ig+nZ9j7jm+hWhnju3j8MPAHc4LqWZfsotsBYX4jxw9ZeRnnX+8PLaerGjRaXWYF6KmAIcE/7Ujyns2qTJGnuGEno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923149; c=relaxed/simple;
	bh=ZxNYeqISOGFfoXV+K6qv8rh4fravSElCNAmr6Y7oPjQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QPKjCLk6rgDW3+DDnlHBoPxV1wnKmiVwMIkyUCsTVDehwchz8/tFImMm7J6GUQDGOQ3mnoYVx9eAb3HkF0DVGd+1pHyKlhLUF34ba7URzYJGf47e6ecslCCK7Kg8TlCqphIPTD+c+KYK7B60Sy36NqQdw40DLZDL1cupI5qrTbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVh3cfSU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728923148; x=1760459148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZxNYeqISOGFfoXV+K6qv8rh4fravSElCNAmr6Y7oPjQ=;
  b=UVh3cfSUhhX5hjNC3Bn6QrVZLiaBQLjCKRRkDHBSd7FpYxVUmOLiANLL
   Fea5fdklFllCbT5Ovnv+sIuluBZS5sQQF547nHd3SEC1CUUqO0WnOD6nc
   OkCdGt7Mp0tjI0IvcV6xghG9DXeAgArnW8fLw7CqkhGapDvHPd/H8kYtD
   bDY6nYzz3fxsLq+C38ba0QSiqxsJBgBEhAqaUcvQq8j9N3do77mR6hw+f
   l/9uPBtlFD9DvoSanCWB6NRlgQHBT9qOy552ExF7GoH2zQzyz/W8jqUt8
   Yad6gTnKGitkHq75B+eF1VAoGnpVmhQLX3gjWLsM77DhJAN1mPFTl+J3r
   Q==;
X-CSE-ConnectionGUID: 1ZdmEvvQTqSK5uIUplPsBA==
X-CSE-MsgGUID: VaGSHU3BRN2nwSR8J1a7bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="27735165"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="27735165"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 09:25:47 -0700
X-CSE-ConnectionGUID: ZiB1IFAQSU6YrN8xIWk/oQ==
X-CSE-MsgGUID: A2zS9B1eRg6SQdyjs6I9DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82405091"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 09:25:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 09:25:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 09:25:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 09:25:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+U8BuqfVDyezGuFnsp3OlOOBcKn1hJgrAn3ea43MS0E9waOrJLSGMG4Z40XIHUv0qTsL05oHbWFRRPYajFbSHFCShZvXlJRfjCGV1kwRwmEOSFbDlkdoRNFbOMq8HE44sR/4nAUPqr8Tz9BLGBj5w2m/PHfYogk8K6xSQR8skVu/VESdYqE9orwLMOv97xgxYeX9NIBBghZkXeu6lLz+usLJcb3TLQ/H7nyEa1X0irVLlunbyo4yrm4oHWtzLMl5UaDXl+xhJ3vd9KZiz1bwgyIZ9oOYgO9YURZV/9sOGfdmcX5qkwmdAzFit3BwA/7M41qA6aseVvsXaY67xXFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlbXhj9WK5+slLucfaNfLgTU80hfM2IDt6szeW2cZbQ=;
 b=ZlDEnTJN6xIfzWxsMawtlo6qMKfa+XaXFrMeQKM7g3soaOX62UTBMdEf2Yor9hBB+pkdMPCemkomFuYJhbI1uMto459qDaOkcbeU+YO/FQAjm3Z56l1XS9Kz3PC2IAiMZ0e1ZMlKP4IcFLuTn5yLCnwNFE7fjYUd9DB2Q6Gv+ZcQQJ5z03W1zncjCJ91arh/m1tI6wHxTIbKbLEsg8eKzqicKoZApCchXHoMe2mj/c6oHQp/blw3Od4cu5Eh3C9PmIJebcDQjdVZUjIV9Vqe+TBcFqy07XAOIK/OBhfXlOQAgMlIr3yK0mFMuwNVDQiM+PMhX+YGQ8v6vA8CN/LULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6924.namprd11.prod.outlook.com (2603:10b6:806:2ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 16:25:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:25:37 +0000
Message-ID: <ceeaf5a7-190e-4c29-89da-ba9e83693360@intel.com>
Date: Mon, 14 Oct 2024 09:25:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: <babu.moger@amd.com>, Tony Luck <tony.luck@intel.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
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
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: ec895c6b-ec89-45f0-f9e1-08dcec6cd5e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emlZRFJtd3dnSUJDMHJjdXhEWUJ1V0tXQmZER3AzRHpMR3NhSk1RTGgvZHJP?=
 =?utf-8?B?NHdVbnpGeDRJQm9sVzVsVGh1cEk1OFNudnRzMzVZWWNYanhGZlZ1ak5iOWgz?=
 =?utf-8?B?WnlCUWRpRTZSeGREQ2lUcXFRcWlrN29jbGhpbDVCT0ttWGpHbEQzRDRzZ2l2?=
 =?utf-8?B?WlpWMmN1SkZXQnIwbWhBTTI2NDkwUFh2bHlYY0l0UVE3U3EzcUkwVnBuZzl6?=
 =?utf-8?B?WlVqbVdBKzdGSWpuUTQwTHQ0b2NhTmZ0aDJ2Q2NzTnIrRWIyOGMzc3p6THZ1?=
 =?utf-8?B?NGlqOWEzUS9kV2lvQWd5YkxEUkNySmZwU3RyTWViOHRMbTdFNUhBVFNQQXdp?=
 =?utf-8?B?L1pKRE5taTE3eXJRYS8xZFo5VkZLQTVHTjRWSkRKL2loZ0VOOGxob2dlWFZ6?=
 =?utf-8?B?czBsbWdWb2UyUUdRbHFMZlNBZlhiaUI5c3d5Y3ZmdWJqcHZmRFBhZitYSGNL?=
 =?utf-8?B?YkZSOE55cS9TZDlKZXZxVWJBeEVIQmV3dktuR3piRXlNRC9nWmZoMFJEczNu?=
 =?utf-8?B?VzVlaW0vRXJTVmkwb0dsQmF3cEQ0MWJsUmF5S3YwK3JtLzI1YW1PVVg4RFFX?=
 =?utf-8?B?WEtjWGxvM3hEYTAxRDBja0RZMlRuQ2lHMCtkQXc4aUV2SGUwVzF1YVNuQm1F?=
 =?utf-8?B?UGZHN29LSjA5dzJ4dXk0YzBkMWx3T3NjWXprS1hUV2IyVGp5RkpsME5tSjNx?=
 =?utf-8?B?bElHak1KNlowdFI4U2RQSHIwV0g3dm5mMzYrTmxtNE1EdHVrcFhxd090aGhi?=
 =?utf-8?B?ZVFRK1VsaWZIMDZBWGZySVRMZ2l6Qm9XejMxejQ4d2RNWkVyNHhKVTNOU1N3?=
 =?utf-8?B?T1JYV0xVS3NJSGovZHVqZGNISmd0dTZ5REpaUnF5bTN1TXQxOUowQVBXOUtm?=
 =?utf-8?B?cnpYYUU0RjBUYXgrbllYOE5SSVo0TnVkc3piR0VGZmRDcUVjZzBwMlBwNDNB?=
 =?utf-8?B?bWVraE0zeGh1OG83WkZpbXdaK09CS2FLTWtCQ25UVVpNT1FnZUl2ekxQTVQ4?=
 =?utf-8?B?b0paeUxGV1lneTV4akhJaHZpcGdsWWNWeGNsRXlRMXo0WE4rYTNVaXE5Q0Z4?=
 =?utf-8?B?aFpZZzhKVWNyVi9VZGJEYU9qZnNpZ3o4OGtKWE9nVm1kckczWlp3ZjViV2sy?=
 =?utf-8?B?aFhDanp5R29GNGlWYlV5OExOYk1aSlYzby9UUWJiNVRGWmVTTUNycEVJV0hI?=
 =?utf-8?B?WTEwTXBzZHNFamJKR3FXNnFEWkhaN002WWs0MXk0aktmeUI3WlZ6dkhHMzVx?=
 =?utf-8?B?b0dpUmtObnNPZGFJRVR4UE1tK2V6RkJwZ1RFZTlFMTZrR1d4OEd0elZnRnJl?=
 =?utf-8?B?bVJqY3ZPQTdMTlRnYWNKdGt0SUVRWUo4YWlxMUlSdno1UXZUWUF1TmI5ZGhu?=
 =?utf-8?B?V1ArWExBc2d6S1lxUjRXMXZwOWFsbWc1NG5xRVBZUmJIanVrMXVleGZrUW9u?=
 =?utf-8?B?Uzd3OG8xQ1ZZVzgxdGRBVUhzZ1N2OEtwYVAxaTdha1YxQkNnY1p2RHdZQWFk?=
 =?utf-8?B?VTdObkNHZXB4NDM2ZWk3UnNCL1ZJYUFsMnNIZ3JFWXhiYzZPNUNsT09nSEFY?=
 =?utf-8?B?SDJ6cWM3MlAzcUZlai82eWozNjk4b29TWXhaeDhxNU92SmpiLzFaTm5qMnNR?=
 =?utf-8?B?eWhmLzNVN25iWWxPTDBmem9vOCtOWE9ZWVRQaGdkdCs4SFI3N0o2YTcvOVFD?=
 =?utf-8?B?bktXS2xZZmdoNXZSeVN0elBBTmNESGgxSG9TZW55akRoY0poS3djTkVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlIazl6TzZ5RGNhei84cFhPbzJ2ekNlSGE3QWZYaDlvQ0p1UWF3MXlBcEhH?=
 =?utf-8?B?T0V2a0crSytCV0haMUs5TkFPZ0xOK1BrNXdUWXZXQWNqa2o1TFpGbjkySHZj?=
 =?utf-8?B?dXNBam50aW9uOUh5RjJYeFdlanNpSytLWEJrdWx2RGZxQjg0blNLOGo4cGpz?=
 =?utf-8?B?V1JFcEFHcmJyYiswWnNHMGJMbXY5TTN1VlR4b0VTRTlrcVhrTDZDT2R4Zmlz?=
 =?utf-8?B?OUwwUDlscENPNmJteld1cmMydzA1SGNWWXA5SGptblRxcEhMVVNZQTdNSU9T?=
 =?utf-8?B?U3U1eWpsT0lMaEJjaXBqeVNqNmVIYUpRM2FIUjJoMWpGc05uNW5xaDRvM2xP?=
 =?utf-8?B?U01WWWZBUm1LRGdhRW83VGtGVDZVRzZRNXNXQ1RIczU1bjZuL2oveW5DZkR0?=
 =?utf-8?B?UTBrWjlSOHpHS3VnYW1nT2tKQWltVjVCUXIyOXV5NUh4OE9aUjZnUHhFVFl4?=
 =?utf-8?B?eHRlWkF0ZTNNMXhsYS9adjV1eTczWlAzU2IwQkduUU5KOHAxaGpmOUJ6YWxi?=
 =?utf-8?B?Vm9TTTVTMU5MM1dnYS9RZE1Cc1ExdjhMR0FRaVNxQVMrSmNFZXV3ZXlaREZr?=
 =?utf-8?B?ZzRrWCtyNnFabks3dWE2eEcrWE96Q3EwSVAvRHhpdGkzWkx2YVlpbGJQZGJT?=
 =?utf-8?B?SDhhaDRyRHZrUjJtRWpPWmIrNUtNUHFuc0JMaU1rWHlHTGZJeXhZWXJXRjJv?=
 =?utf-8?B?eTFDQzU0U2dNTXVXZExRNGtzMDUzdll6MkpSME1pejdqdldqQ3huQzdCYzcz?=
 =?utf-8?B?QkkxV3hDNEU2RXkrZ3BRMmxNQWNOOG1zNy9XSTV3M0QwZ3pkREUzL2ZaUDAw?=
 =?utf-8?B?MXRuWWtGRnkySTBGNlcyaklaMTZKdzlZTEtENEhUcFpxVzB2L3ZSalBEbjVp?=
 =?utf-8?B?WERHK2Zaa0ViVGlQVzJoTjU3alhxVmNpS1pLYUM5VFZnand5RGtPVi9WRk5C?=
 =?utf-8?B?NlM4cFdIL0NUVTdQYXZzTmYydnpSeVVHSTJ3NC9qTmhNR3RPdHFDSG44ZnJw?=
 =?utf-8?B?bjlLOFZjQlJLcW96YWZoRzNSSGsySHJvRDZYeDVUZVV6ZTgvN3dTVE1HUUpq?=
 =?utf-8?B?NTZTU2RNZ01CcXhDRXg0c20xbnFQSHQzWk42NjZ2engzVVRYYnpaaXhiRy9R?=
 =?utf-8?B?cmlnaHJKb0VaSUZMV3NiRzdMbEJEemlPbCtQaUVLZlNCTGQrMkZMK1JMMFY1?=
 =?utf-8?B?dDRaK2FuSU5Fd29hcjZpL1Z5L3VqeDZCU1FtZGo0ZnQ5UXluWU0rZEF6ZjNt?=
 =?utf-8?B?ODdCb2ZYV09JdzZlRWxwT2F6bGU4RUZVMSt2NjFGK3Fid3YvOUtTTnI5c1Qr?=
 =?utf-8?B?bmlmSGdmUXFKaWFPZndjM3llVGlubVJEZzA3anRMSzF0VXpTcUNHNHZUN1py?=
 =?utf-8?B?K2kyVkxlUU1neE4zSVlXVHhHcytVTEE5RVpoL28rNWtUK1ltb0czZ08ydWhM?=
 =?utf-8?B?TWlZTjVqYzF0QjhqSTRnOUd5VE5nalFrSkRubUlSdjhEUFNoTGFIMTlOUS8z?=
 =?utf-8?B?cGtEQkhzaVM4bWFkbU8rUXV5aXE5YytyZlhMTjVXV2NEQi9KUWVYSkxZa204?=
 =?utf-8?B?M0tCWS8rdWhLRzJRT05COWdTdzVIT1h5NUtHeTRmN25wR1p0NDI0MjhhSGVj?=
 =?utf-8?B?ZDJJSEN0Q0RHQ0pETEpNdzJiZVdNRFZXeiszWitWQ2pUc0lheUNZMVcvaXN4?=
 =?utf-8?B?MWJlaXFqSVhXb29zWFBGVHpqZElkWm1MVkROOWIrSUlkSHNmeDNCVlBPS2Ev?=
 =?utf-8?B?aE5sUmQzQ25xOEZBMDB2dlZBUkpKbmZsckxiQTVwT29MS3hvZXo4V2U1bWpH?=
 =?utf-8?B?TFQyNUczZWE1eTd6U01xMHZQVmFUY01TYlNxNVBpRG00djljQ1J2WkdYNm55?=
 =?utf-8?B?Ym5XU0ltY0IydmhNSm1UZUlBRjVNWEdtT0I5MHJIcW43b1BUS2Z3WjNYaCth?=
 =?utf-8?B?NVBzQ0JiQ2pjVkJzUVRtYnZ2ZDFNMmRGTnFISzJlcWxJWlFRNmNVc2poZGxR?=
 =?utf-8?B?TWk1bE8vRlJBS1E0U0wxdGpPVWxDZ1VlZFc5MGlFZ0xlZUd3djNyNkZLRmdq?=
 =?utf-8?B?b2hSU25WY3d4YzF5VER5eFc1Y205QmthNUpqMWZxTWZrbjF4M2k3b3prWENx?=
 =?utf-8?B?V3hPb1haeUtnb3d0R25hak5sV1MxaEY2VmZZckpud3RrVGI1V3hoWFc0V21B?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec895c6b-ec89-45f0-f9e1-08dcec6cd5e7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:25:37.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T33zeuZp5aoob4SmhOkHcWOGSao42wYdXX2piDRRsQxurYpeCYuiFKfYcAom+DSq5Yyii6VEwjmfIMlr09r0heCdDLz+tvNytqzbwAhzv4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6924
X-OriginatorOrg: intel.com

Hi Babu and Tony,

On 10/10/24 8:12 AM, Moger, Babu wrote:
> 
> All good points. How about this text:
> 
> "num_mbm_cntrs":
> The number of monitoring counters available for assignment when the
> architecture supports mbm_cntr_assign mode.
> 
> Resctrl subsystem provides the interface to count maximum of two memory

subsystem -> filesystem

> bandwidth events per group, from a combination of available total and

Is this "from a combination of ..." snippet intended to hint at BMEC?

> local events. Keeping the current interface, users can enable a maximum of

What is meant by "Keeping the current interface"? Which interface? What will
"current" mean when a user reads this documentation?

> 2 counters per group. User will also have the option to enable only one

"User will also have" is talking about the future. When will this be the case?

> counter to the group to maximize the number of groups monitored.
> 
> 

I think that we need to be careful when making this documentation so specific
to the ABMC implementation. We already know that "soft-ABMC" is coming and
Peter already shared [1] that with software assignment it will not be possible
to assign counters to individual events. 

The goal of this work is to create a generic interface and this is the documentation
for it. If this documentation is created to be specific to the first implementation
it will make it difficult to use this same interface to support other
implementations.

Reinette


[1] https://lore.kernel.org/all/CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com/


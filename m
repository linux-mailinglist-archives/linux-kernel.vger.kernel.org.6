Return-Path: <linux-kernel+bounces-518352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14295A38DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D135F188BD02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2D7238D53;
	Mon, 17 Feb 2025 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeVTx4md"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB822E3E8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739826016; cv=fail; b=rmxc882mATq7c5opbk1YlLOdN9b3z4lgOQ2zH/RPEczl7fQCJApiBn1YGfzChTttfl++7PrUDqtuPYC/Jsht6kS62o3apZUz1Qr3BkuOHpAR6FLd79G+igYx0j3q+3O17AAqvbyJ9BFO0rw8QCpkIS7obW0ofEzeJmUXErYZh3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739826016; c=relaxed/simple;
	bh=Bj3vIC+Ar22ColvZIDRGemUqLDQ2PTQ52zR30XMs6NQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEdzvxN/GmdnXdJaP9nFltqz0uDOfOzW24srvMminEYK1vuKGAHdW05OplOCLpZRplXCcPJVFqhjIvwcw0JAiKz2JqbpriOt/myQ6H2rkOfK0DOn0Yg+Oh0LaatFH4KqehYRxef+mNlU+5WFVbFyjM7unwJqeFqmYoo0o7CYC9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeVTx4md; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739826015; x=1771362015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bj3vIC+Ar22ColvZIDRGemUqLDQ2PTQ52zR30XMs6NQ=;
  b=GeVTx4mdI1mvk1KtJa6eGAXj6dp9BbiCRm/0gMgDR3s1Ybmm50LXJdgU
   rItbIX5C5mA1DCUEPawFxzZbzAaKuEOpuBppCUTetX6juU47/UkdWagTC
   TVea/BpeRg6YhQT6EzGfIFr8Tl5oT2UQ907swvKRkUYvNy6OoJWqRhi8e
   5AuAKoHbY6oVEb28W0C/l2eVxuYREWzYt8Ne6ECU5JRx9sGCUBJ0Jf/Ca
   w/P/AOAVvu2up4EF9wo+QcAXDDe5NTm5cwXufDsLph3Gv4VVSE4pCOMfa
   X3/PL9MLKXWkwPz3tY36TPvhDf3YAAAf9gVd8OWT4oCOZ9gxp6J9E0GUH
   Q==;
X-CSE-ConnectionGUID: x3fmiNOBTSyYZMSDMTp0Pw==
X-CSE-MsgGUID: VSOrk0TUTCiDDlAdze2L9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40221555"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="40221555"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 13:00:14 -0800
X-CSE-ConnectionGUID: ANcXR8cxSa+RM7dsbI7JuQ==
X-CSE-MsgGUID: qEnkruhGQj6/jcfMePQM9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="114142888"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 13:00:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 13:00:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 13:00:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 13:00:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrvO3VzEV/LLZL6+ZW0eZuZr/UptUY9+ZqNGw5NLvpdtFpmSWHqfLAH065PGvbBmm8OysibHdXpbKR+3eZJi1nt9ySKMNOXXDgxKxWU1zY6z3tZq7+ojcjoVxYgnbIZX8OgQ/PIwOZoyr2WDgGavF4NMU40o5MmaE34Cb/mnkmjKdVLUwZ/smfmuKTk3NZ8cGscZPv7tHEI/N+RXzjQN2NiTi9TYA53q3qHQYHZx6pYPCHy9X6uI2JozO819iQPWjpAxhs3WVaLIwbuq/HkEeM0PYT8JLzXNM4esOFk2cxM4cZudQ+4F6gcSGlMJbYPYDKsxiP1Q9yv5K1tx28pXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhAgJ4u88IsITUBqcFv6AcQNP/ryQzH5UmJE3n0qrBY=;
 b=bHuKbpP/cN4WqioScajnGKsC3ocUzeoVF57bjopW2KgEn+lZSNdN71P8KSsVY6JfUR3aqc7QiOI0HEWRhc3VNRjxFgQgbxeNNJgS5/aQTJCwvptcYJxCIDvQUdQcjM4TpFwLyKXLV1HJVA/r5y/vsdFsmCG8U8JHAnRJPINPDPlUIjcQX8Lw+QTk6o6qkH+2klrPckqXa2JOG1f8m7J3kATx9oYA506EfIlpB5d2bI7+yQGU0KURIIuKKmmVjyWOvX2EKdPiJdQy0UP4MZBe8vE/PZ2n1vCDpeJu0fsarFvAh8lFCdilk2PeOdtCG+bA3uFJuQhAPKtte1ZvNZWfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 BY1PR11MB8055.namprd11.prod.outlook.com (2603:10b6:a03:530::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Mon, 17 Feb
 2025 20:59:24 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 20:59:24 +0000
Message-ID: <2306bc17-d1bd-44b0-b5a0-5ddb8c8d30f7@intel.com>
Date: Mon, 17 Feb 2025 14:58:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/tdx: Add tdx_mcall_rtmr_extend() interface
To: "Huang, Kai" <kai.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <20250212-tdx-rtmr-v1-3-9795dc49e132@intel.com>
 <5b6a06ac-b98e-4e15-9b19-913aec8bf4df@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <5b6a06ac-b98e-4e15-9b19-913aec8bf4df@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|BY1PR11MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a067f83-c049-4256-3a6a-08dd4f95f552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnZtWTZDVUlaTUR5bXhmcG8vOW1MOFBvTVp2REkvMVphTXFHZzFyM0JYSDhr?=
 =?utf-8?B?Y1RCT3UxWVQra08wRVJjYXhoc1FvUGg0Q2FqOVhHRzNSUmpYOUZVRDIxUWg4?=
 =?utf-8?B?ckJZbzZnN21BRWgvWmEvcWgwcVNLSitqSFk2R2dmL2YzNGlGRUd3OHJlTDJz?=
 =?utf-8?B?dkM3QjhiRkpEanVZR2FmY0ZyN1BERUlwaTVvUWdpR3NiUUljYnJ2UWV4Y0FU?=
 =?utf-8?B?cFNSUFBHaXJra0ZnM043SnBhM05rZUVsMWRpOUxkZ1BFNXpBeU0yY3lqR2Nx?=
 =?utf-8?B?QVJIZGxqMWxMcUVVU1RWU1lNdHBVRjh2UGFJb204NXRPOTRGeHVTL29xU0hr?=
 =?utf-8?B?NzlZWTcxelhjVXZaQmhDTEtweGJaQXdOVHhBSWFNWHBtOTRpS0t6dS9BMmhK?=
 =?utf-8?B?OTdBS3ptN24ydmlETG9LWHZlWDJNWnowUjQ3ZTFaUGlFbEhhbTdKWkcrWE1V?=
 =?utf-8?B?QUY2ckVRakx2QS9xd1l4WEwwL1ZZYnFuS3R1a0FSeVFmWXRIanVTZC9BRDhW?=
 =?utf-8?B?LzVDUDJXT2d2ZVdtcitxZUlpL0tFM1BMTk00N3VBTW0zaGFrWmpsOTdMVlps?=
 =?utf-8?B?NjRPZEFSVDQzdFVGWkcyUTFLWVJxTEFnODlFRjdvOG5zdlVqSnV6ZEU1d3JK?=
 =?utf-8?B?MWVrTmRRRE9PSDJmTVE0a3N0dGRBRFoyNEdXZFcrRjZkZjVoMXkrYkgxUHdx?=
 =?utf-8?B?SGk0TjhWWFFCVVVhNzdlS3pFck9GZXJmV294MzIzNDBFbCtONm5MdWpEUG51?=
 =?utf-8?B?V1RRcVh4Z1dzcmtTaElVWWZBeGlEVDNDVkNWQy81WDRMV3ZYRVZHMDZDaS9j?=
 =?utf-8?B?MmhVQVMzMjB1NVd3RFJLakVpNUVoQ3hJZnpGbHhyMTVsMUJIWEUzZm55VUhX?=
 =?utf-8?B?NVdRWG5ZUmlLZEprVGNSYnlLSzhKQTdKU2dIUTM0R2F2ZThOQVVYZEUyZVBU?=
 =?utf-8?B?Q1FmYUFMZjQzRzN0ekdqYlNlRjIvM2hUbGFIZDYyRU83UGk5YWlxZERseWgw?=
 =?utf-8?B?NUNyUHM1WFZlUFd2U1RxSnJRYWllaXVMVUdnK2lqeVFNSWo3aXBPUG1SUWxu?=
 =?utf-8?B?WVJ6bzVQRXorbEE0RWFodHBueFJSWG1YTDJiVlp6bW55RHQrRit5WTNHMGM5?=
 =?utf-8?B?RmcvMmQycHJyMjZtNkJwYWljYXpwVTZxTitUN0F5UmlqSGpzTXY3R0h5SCt3?=
 =?utf-8?B?N0UxQ1VhRHQwNE81WTJ3UlN4ZzdqRmJUazg0UGYrSjVMbEpDaG5uTU5JelZn?=
 =?utf-8?B?NStWcnp1QlNFSUtGYW02OW5VOXN5TUpuQlFpM1ZqckZuUE94S1ViSXFXL2Y4?=
 =?utf-8?B?dXVqM0tSTm1Md2xjMU5pSVpmaEIvSVNyRkdlMjNCWEk2VjhzWmVzK0hHSVlS?=
 =?utf-8?B?bmNWc1AwTTFRNTlPclVrOEgzS25wQTRaRkZsVU50MUw0dDY1Mk5idlJydjNK?=
 =?utf-8?B?MEkxVno3R3pOU3ZLV002SDhPZTc5SHJoRUtIMEtWQk5SU1hZNnI5cUJxek40?=
 =?utf-8?B?VWxxTFcrRHZ4VU1DWHVXN05oUlVmamQ1bUFZaWpLb3FPaGpTcEs0YmVYTG1Y?=
 =?utf-8?B?V3Y4MTFFenZLTzZSOFd3LzYyaTdScmZhenN1ODFrdDVuRmZUZHhHcWdWenMw?=
 =?utf-8?B?QWxkS00vamJSei9SYmlLcXk5YWFuMUdtazVTZTNVN3YyZXZ1eWN4ekhBNXM2?=
 =?utf-8?B?cXhJS1ZCS3IxaVNOOXRkY2lWQjA4Q0RvZlQ4NGxKajNFajhMTjFxNXZhSk1N?=
 =?utf-8?B?ODZySWZ0b2JvU3hSUEZNYll5R1VHTGRJck9TOTZBVVIxZjZsY0l5a2w1MDNQ?=
 =?utf-8?B?Zm04eGloaUVFVVpVbmw5TkxTRUNpNXovdXhkZEdJdk56MWROcDg4SlpVaC93?=
 =?utf-8?B?QkhkWkQ1clBEZWx5b1o2Mk9XeExQMFNKZjBncGxiN3E0ZXpxT2VUbmZ3anlr?=
 =?utf-8?Q?hR74pnTr0d8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5wbnZaZ3J1d2FvVjZ1YnZ3UXM3MERzc0g3YkJ1bUdodUY4NG5BcFFMV3BE?=
 =?utf-8?B?Y3RDbFhNd3JZcSsvTy8vSi9lZ3dkUVhVK2FORWpzbVB5Y2lDcW14b3RobXlY?=
 =?utf-8?B?WnIrL1VXRlpaOHdyYzdkcWVueDUvSnZVMS9pUEFSdU01QjA2b05WS2ZHaGM4?=
 =?utf-8?B?bTFHN3BGakhLa2FxbGhUb014Z3BidTVQaE4rclJ6WmtYRStuR1hhS3hmMEJK?=
 =?utf-8?B?N1JEeXN5NlB5MVh3cGRVWW5nYWVaV2poeXlsNjZHeGplZkZ0M1M5R0xXaDdo?=
 =?utf-8?B?Smd0VDRCbkcyR3dEbXJhYVBIVm9HOVQ2cy85eEVMUnRRdmFjZFhhL0xVTDYy?=
 =?utf-8?B?N3pMNmNVeXpwZ3Z0ZUw2YXduVUpqSDErQ3lUMGhTOFlZMHFlbkZTQU9HVEpW?=
 =?utf-8?B?VHNaU1RlanRwRkNQTFJmd1hScndqYkdBQVNyOWhFRVlLSTREUmhZZy9xS201?=
 =?utf-8?B?bVhLS2VLRnN2OFlzTE8rSXJSYjgyNVBlUDNSRExHa0toWFBGMnVlRDRJM3B0?=
 =?utf-8?B?cXovaUdDR2gzaTBPaitmbFJ1UFRUTlZLcGhKbGE0aW5vM3IwNWlaWmlnSVhx?=
 =?utf-8?B?MkphM3dvRkJuTTY1WUZiUDVnU2Y2azJMeU0rOFY0aVVRZWltU3pGL1BaQll0?=
 =?utf-8?B?T3NmelNFSGlrVnUrWkc0SXVMYnN6STRpOUJCZ0NmSE9rVDR0cFdLcnhuYldW?=
 =?utf-8?B?dzFrbndtTmpJU3N1ZzlXTEtoOFRyNkJEYm9HRkJnMkRYQWNGTEtPNVBtWmIv?=
 =?utf-8?B?RGZ5ZFZYdHBDWlZLVDRuby9UU1hUNkFjT1doSmZUTHlsR3FQR2lTUW5NSHNL?=
 =?utf-8?B?TC80Ym50NHBkU0FRRGhPb0Vvc2VUNlNkNWZoQURHUVBCMGttMVFQRUFFUzhD?=
 =?utf-8?B?UDlKbDRYalB6WE5oVkVLTzNtbTRLYmZLcmhOSVZiNHVTeUdyZUhXYWFFaXZS?=
 =?utf-8?B?UDZNdGlZM2JGOHN0QUJXRzNoL0djTUhrZjNiU2JhUnNieGlHUVY1RjFTWm44?=
 =?utf-8?B?LzNtRktYa3hwckdIRVpEMDFVenQ0Vk5yMzNrWWcrSnloTDFpdEV2MCtycnpa?=
 =?utf-8?B?YUpabjJGQ0RrVzNKVEFkblh4ZzlUOS8xSmJrZkUxQXBqVmpVMVRVR0I1OEFx?=
 =?utf-8?B?ZlNtWkdPUlNnaklyWlo3ZlQwR3IvOFlzbDVtMHRERUd1SnB3MnFVUjJVTUs2?=
 =?utf-8?B?TGZWSmE4eFNXcEhyRmU1WDBsUjA3Vk54Q3JyN3ZTWTcyZmtWNVA3OFZReHVu?=
 =?utf-8?B?SWJUdTgyYW13TTlyRVlJbGs0UmZNNG9YT0dsN2tiazIrRXZYcC84KzV3U2wv?=
 =?utf-8?B?aHVrTnY1Z09WaDZSR0J3QUpiRGw0NHlJRDJIazFBOFVXbFdaQlpLdDFHNXow?=
 =?utf-8?B?emJNanZFSUZONU5NLytVRzJhelduQ0dSczdhcVROaURGcmYvMXNHN0E3QVZQ?=
 =?utf-8?B?bmF3djhZQ1p3MjdvUHpMbmZWanBwTTFwWm1kaXlYK2NYaGo3dFA4TmJnRklO?=
 =?utf-8?B?eHRoY3VWZnJwVzFFeGV3MWhnMzVkWGZpa0xZMmlIWTVBbkM2dW1kcnM4MTl5?=
 =?utf-8?B?Tm4xQUlZaURDTzFsU1FzSjRGbFd6MGNOcG1sbHZ2dURQUCs1OW5tRWQxZ3NO?=
 =?utf-8?B?Z1llSWtpdlAwRzNNM0J5QmhVTG1qcWZtS0JZbVBFaDUvcDUvb3R6dXBKd21N?=
 =?utf-8?B?MnpzRmNRTVZ0SFBWVmF4dUlXb1NCQ3hqSmhGOHJTSUYwVWJFSTlWYlh5b2Ft?=
 =?utf-8?B?emlCVWdyWWNHcGZwa2M4ajlYNXdRWFhxWDBVSU9ZL0hYcTZvSEk1QWd2L2hZ?=
 =?utf-8?B?QlVtYnZUYitTaEhjVzFoZ3JVQmFRZHI0d2lHdDhvdnJzU3RXbzF0bGlUOWR1?=
 =?utf-8?B?cWM5ZmxrTXI5dFM5cHRDUjZPUUFub3VQSVMxcjhPL0FqNXl2V1lUcXJwN1hM?=
 =?utf-8?B?dXZhanJLT2xrNXdJTVV0SE5GQ2QzRSttTEN6T3VJZ2c3Q2xZZDNpNjFrbDFH?=
 =?utf-8?B?WDhyUGFqZVZvTldOU2pOTHdCeExYdFQyeEQyZDZObWZZMm5wUXhsd3RKOVVZ?=
 =?utf-8?B?bSs0UG1seVRmQlkzckV2TkdUWjAwSXZ3YW56d0lZc0xSTkFzNGlNZGJvRCtE?=
 =?utf-8?Q?caiKonGsGoblbX8FHkZEB69jM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a067f83-c049-4256-3a6a-08dd4f95f552
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:59:24.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFItZPHsm1ViG8jUXkSKMV6KMVgq9ISvSr/PT1zJbO696FTEVTJB9f8UD2tMonqI7X7WzVsrKt0uYPDvj5fuxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8055
X-OriginatorOrg: intel.com

On 2/16/2025 6:40 PM, Huang, Kai wrote:
> 
>> @@ -135,6 +136,41 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 
>> *tdreport)
>>   }
>>   EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
>> +/**
>> + * tdx_mcall_rtmr_extend() - Wrapper to extend RTMR registers using
>> + *                 TDG.MR.RTMR.EXTEND TDCALL.
> 
> Nit:  I would prefer to name it as tdx_mcall_extend_rtmr() since this 
> matches the existing tdx_mcall_get_report0() (and tdx_hcall_get_quote()) 
> better.  But no strong opinion.
> 
This actually my preference too!

Sathy, what do you think?


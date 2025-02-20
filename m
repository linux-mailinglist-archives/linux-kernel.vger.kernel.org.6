Return-Path: <linux-kernel+bounces-522967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F8A3D0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437C33BA303
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824101DEFF7;
	Thu, 20 Feb 2025 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRN9gqCt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5953199237
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740028046; cv=fail; b=lCKIC2NzUMd3vp8WwCwnqIiPWHNNZSSR0D9wqk3C2a2/Qd8IFK5REvv2rvbto2w0WcKOYosfED8WnQBqbtjVoKMspGavCEfvZ/LgpfAWNQaIO4SEgFDb+mGbbhi+yyFokSeScGp3PLj/z3q5JW9Fb4ci28G+xyaLgJ8IHTlV8Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740028046; c=relaxed/simple;
	bh=5jp5bX4qEcOR1d6aUtglLMoWFIHamTHuMWjxF+nSBMQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rLyJs37+VhCCSX4XCM0USU+MR7uHD7WTyY2J1uZFniIw5R3EdpY5JCla7+SxF9xSx7d3cqX9ywxxi92dS7HChuaVjZcCQm+Kifoh/vn16ry9trS3HvTo3xWljN1LkDJXAFZ+QFhStnidv/ijZ6xygJbja2fEoLyJIe8gsfhBMQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRN9gqCt; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740028044; x=1771564044;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5jp5bX4qEcOR1d6aUtglLMoWFIHamTHuMWjxF+nSBMQ=;
  b=mRN9gqCtElM9nUfzA0eI0RRZkNflWgVSciN4ZHGfEQXM9Ih/aTFXGipW
   NorTJ/YxJ3sfoFyYAx3iVCYU6YrtgtGoKpxAaA/EJjslCaF8Ps3IikVUe
   Pge+TrlHZEHjlkhi7PPwsEghXlFZ5emfsmKnzXUa2MWUv8WEAjeCmzKOH
   DLHuypzEYrFG5PBf+afw27tbyQx9vzWH9/+YqF4pf7Rg5bKOAwef5eZqX
   TFTqCk0cxYmhu318Eky3YaKadcSzi0j3arLKfThjx8U9KeIbzmGhXhzVb
   C+IMDJJI3aAsd4CIFAjdAgd7IRunz5m591I7rLnjh5JkIaCGkobM2XxyE
   w==;
X-CSE-ConnectionGUID: LE23yf+DSeusItnAai/fJA==
X-CSE-MsgGUID: 2xvJjV+gSlixwRUU01zTuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44567757"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="44567757"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 21:07:24 -0800
X-CSE-ConnectionGUID: XSGHB85PQE6PvWnS7Kzzpw==
X-CSE-MsgGUID: nCeVoCK7RfGlddK9UTAUCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="145775926"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 21:07:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 21:07:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 21:07:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 21:07:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF/uq3o0BYUfTH9qtmf4EWYUGnhY9S4N/Rp9o3W7f3NgYGPzaLyUd368oQj9i6MVgJ8XFveg6n69ZvGgo/qxCWwO7HL8d5XMhgWP0bdpMAQ14dVuQ7GBoduG6mvd4P/4w+NdLfoZKONOgQqDEMyWb7zl6gSKU/kw8RS8P2KBOmEG/wsQPJWN3bCQ0oHHRHzo8Uvjd6gUttPcGQWsuqxy7wCRgJ1C189jWdSk89SvyzimE6Me+VyX6qNVAGCQm7uoDZ6ijanhbBzld4QgK9FaaKx0g9eygSFvjSNENUlqXwKphU/9Xr7q/IUbgjhPCxP+O/7k02gl8YY3qQKJKr+PBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI8lfQt3fC28FpRXxtQL8NpW3oZ9MKY9AF/W+wcF4/E=;
 b=WlOxg0CJGhpH6A4aQJqfhNgF8ve/Iv99TAz6SEGeZ1QFVmNG0zjFpZzBuddoTK+uxRJjMKx39aOQd6wGGM6ZpOXoefKSnRUKIWWN+ygx3El6QEhmBfsm9VnYIsS9WkMf1Coz2AYbflCpAdi/MR7y7MaihyxBsBxNjb2usmEzLfbS33wPZLCiataZETqgR2wdJxaWbqcDM9XDu7Km9znLGMQCBN1jR/Mfoa+VIlbsI15MfNgTbOs26TuVLVwxx0J6mlt5XQubV23rVkpAYDnLmDXcs2IFK4DZyzc1+BOTJ/tCXPbCG3KggZ8qFwJEdsemTE3Q21gSXZ1YsudzkQIUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 IA0PR11MB7912.namprd11.prod.outlook.com (2603:10b6:208:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.23; Thu, 20 Feb
 2025 05:07:21 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 05:07:20 +0000
Message-ID: <9784e70b-b6c7-44d0-99ef-2c07bf020848@intel.com>
Date: Wed, 19 Feb 2025 23:07:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Mikko Ylinen <mikko.ylinen@linux.intel.com>
CC: Dave Hansen <dave.hansen@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <Z7Sd6FuDDMgExEna@himmelriiki>
 <465d712c-b638-4884-88c8-1a88c506efdf@intel.com>
 <Z7XkoQ1cJNw8dn3I@himmelriiki>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <Z7XkoQ1cJNw8dn3I@himmelriiki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:74::21) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|IA0PR11MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 617927d8-3502-48f6-b32e-08dd516c744e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THlaZjUxVkJtY2o2RmhWNzB6TU5TdDUxYk9vS0FpZEJBVEkrUS9BbG1od0lp?=
 =?utf-8?B?VWxKbXZhYWlPNHFwZkRGOHViaVI5dkQxVlBXeHRWM013ejFveEpkVXpMbDk5?=
 =?utf-8?B?WU1DUDRoL2w2NGczNk9pMEJkc0VZQzVoNFM2d1duZTRod0s3c0p5U1I2dE1w?=
 =?utf-8?B?K1VVd1dkUXN6SVdkZGplRzdBa1BqenZaL05FNWthc2wzcDNremRqVW10OEFM?=
 =?utf-8?B?U3NVOXJ3bVdaOERRRDA3YTZYdlRZMnlQQStnOG5GTm9rRXJJbzVFTWRTODB1?=
 =?utf-8?B?c3hvemtzKzVsRzhJbUFZQ1RrNXBZZ1BaNDVNYzRiVmo2M3lsN0pWL1BXdzha?=
 =?utf-8?B?SThqWmVxOW5GM3h6U0ZBWmxoOGd0bGdOSjhmU3ZpenYva0RiQnl5NUd0bUVj?=
 =?utf-8?B?SnE5dkE4czNCOG50R0VDRmFtNzNUQnF2VXVhNkROd3FiSEJKQkpna0p6WU5o?=
 =?utf-8?B?T2ZxbHUzMTBoRHV1MTNEWmlEYzdGcFhLeEd3QTVCT2did1djdjhnbDhGRVMx?=
 =?utf-8?B?Wi9jK3l1OTRnQThDbmRhbEZXUUp2Mm4xZjdrdGM2R0RZbmVVdkRlaGFQUktU?=
 =?utf-8?B?aVZza0w0dk9idkJZckI2elpEVnlFcUQxNTIwNVVhQnM0eFI1aDVWaVRJaEs5?=
 =?utf-8?B?WStwbyt0SC9DKzZxTkxjQXZRQ3F0YkNpSEV3ZXZ5SUZHUi81ZlQ1NTl1bFNL?=
 =?utf-8?B?ZVBSc25ERGlOUkdyaTdIN2hLK3pXeTlWMThmMGpyYit3SnFRckVLR2k4dEJY?=
 =?utf-8?B?ekxkYzdMc3k4MFJ5QW9DZnB4elFFWG1QdzE2NEU1ZjJWNlhKcmc3SFRnSTBY?=
 =?utf-8?B?QnZxN2ZUblZBdGdMR3RoUEloeUZ4WUxqQUIwa1MvbnJPcGxPeTFScldjcEtr?=
 =?utf-8?B?cFNBZzd2ZVp1WmkrY0kySmR3b0FxcG5rclh1a05SeGtqSzNSVVRhc2tLN1Bk?=
 =?utf-8?B?V3lIVjdTTnFVSWd1ck5wVFhaZWN5MTd2eXF1NmJuZmZud3JIaytzMHRCV0Vz?=
 =?utf-8?B?bnQrbmhWWGJiUzNOeHRFRTlsTlkzMStYaXdHMDJLdU40Qy9vTTEreExndzMr?=
 =?utf-8?B?YmFRSTJBdXJvYWNxRGVuMU5FaGd2ZjJodmJHRUJxZG0yVko5WFl5OGRyLytF?=
 =?utf-8?B?MkZrcisxeWNkdDFNYWRyWFIwY3dMRVUraUp2bUkvR21uRkJzUG9vRjRVbVBk?=
 =?utf-8?B?VndSRUpPSy8zcWtKSldZWWFwaHlENC9OMDB2dTAyYWlXQzhCa05pTTB4amVP?=
 =?utf-8?B?QmpSSytyUEdDTDY2NkRzZFNiYkdYa2grb0RHeXRwdHJIaTVUZHF6MTNQaVEz?=
 =?utf-8?B?a3lwUTdtYitlT0FnNnNBVUM0Z2lOeEtITUFkbHdUa0U1VGk0bERGYW1oUmdJ?=
 =?utf-8?B?RjBXa0RkaDBLRUlTaG1xQjNlL1J1dFhEbWg5UTBOSlVXV2NGdzJDN25wZTVE?=
 =?utf-8?B?MTdMZGJzdVM1VUZUYzEzK0xKZ2JNR0pFMStJNGtnSlNkT1JRSFk0UW5ZZER2?=
 =?utf-8?B?SE1CYzF4L0lqTjIvNmZMVWRUL3FRRk92RktkQ1RsWWpxamNUTnF4VS9STDgw?=
 =?utf-8?B?N1JJNFFDRHRnRVY0N09VdjdoWmFVSEd0aWZFWUFaNmNxNDJEN0ZSUFJFcUxy?=
 =?utf-8?B?aEF6R0dDVzN5TFpmMTBxVVEwK0NYRU44NUc3Uncybmh0OXdwYUhjck9XeU0z?=
 =?utf-8?B?RTlPUlIrMjFzWWM5THlRU2NJVUtsQytuczZ1MEVTSDBjY0JhdnF1T2puSzNx?=
 =?utf-8?B?TVVaaitWN25Pb1ZyWS8rekpvK3VlNzdzajNXanlmdXloalFYdkxxYWtFS3Ux?=
 =?utf-8?B?WjlLVVBKY2FjNkIxY2xaM2xjUXdXYTlDTTlqNDZybHp6bXdMeXJEbEFEbThz?=
 =?utf-8?Q?z860XRVJhe44t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVRcEFNSVgvSEdMUVhZRTBacGVZVXFyQzlFUXkzajFZZDZRUHJGYjJHZjRp?=
 =?utf-8?B?RENGdzJ3WVhmTkdIb0wwZVIwZnF6L0Rob1hUUTZOdldWV0VuSHB0L0NHcC9z?=
 =?utf-8?B?d2w3MkxXODRvbUpJZEpvVnl4K3pDZ01OYnRod1dhNmdDMUYrYmJCNXdveEZ1?=
 =?utf-8?B?VERwMzFkOG5SbUNNaXlFMWR0OS8yRi9PZmNEb0crL1N0RHRpQzNyb0tVRjFE?=
 =?utf-8?B?VEdGbi9mQnhFV2dZNWlKV0lUdzYxazBiemJuaGxCVmg2dHRiRlJXdERDM1po?=
 =?utf-8?B?ZHdseFdOYlViaTFoU0Z3Z1JlTUlCZUZLbzgzMXBiOG92RzFCa1pVOW9VN3Vu?=
 =?utf-8?B?eVhwR2RNTFpmN3Z4akU4UXVHTHBFMnJZZk5SbXd4RGwrWU1ZeGc0YmpZN3dx?=
 =?utf-8?B?SzFOdEVZWXQrQUZmVzc0RjhEdUhPeDdma3BYckdLL0FtWUt2aEt3MUE2TVNC?=
 =?utf-8?B?Sng1U1cwd2phdlVWcEpRZE5jT2pQZ2x3Rzg0SmRzNHdHSVRrcTZjbzNRTFNC?=
 =?utf-8?B?Ty9yVFFEMWpHb1pmT3pMK0hFaDFPN1NuUWUyN1QzM0M5NXZHdk4xNm9Lbkdj?=
 =?utf-8?B?V01qYUduWDRLNVBGUmlWVTlLcDFoM2g0UVNLeFQ1VHl6QlJ0Wk9ZYSswaGJT?=
 =?utf-8?B?V29takdpNU9HMnk2czl1d2ZsbWhGV29NdksraS9Dd3dhbmIzK3RpbFdSQm5h?=
 =?utf-8?B?dTQxbFlIdHBUZDQ4c2g5K2lZcGpPTEFGMlJ2R3lBaHlmQmRKRjhIZzVFMlBK?=
 =?utf-8?B?SU1SZ0hQMGtBeE94RUllcHlSUFhLckc3RDUrckl5SEVjYmRSVlk2cnNmcjN2?=
 =?utf-8?B?RnA2UzJRMjFEYUJTY3NQRzJsS2dLbnloSURVQzFGMG1FRkNOTnBXaFhlL2xa?=
 =?utf-8?B?VjJoQ0pjUXZvUTBpdmEwa2N1WVZpWC93blFIbW53TlVyQ29CcXFwR0pMZTJK?=
 =?utf-8?B?Y3ZQTm9TQkR5bVgvT1IzMHhHVVBrTGx4UG12WG1NZFpjdXB6cUEzMDlIbWFF?=
 =?utf-8?B?V2Z5eHhHWVBVaVRsMXJscHI1V2VVMVE4K0RueHlrL0VwdU94RHZIOFVudXZI?=
 =?utf-8?B?TmExT2FRMmE3T29hZU4vZUc5UmFZV3pPY2ZDdStzbHhqQXlYMFRVZWh3QUpJ?=
 =?utf-8?B?NUJ6QTZZYTdOekhlWlRwMWtkVjdQbzZGc1Eyc1VIKy9Fa1ZpZk5DVW9HdHVk?=
 =?utf-8?B?VmViYklhVlh0SFJJNWIrUlBPL0o5UVVDZGUvNTVCUDJ6bGh4eXVPajZxQSt2?=
 =?utf-8?B?Wm93WUJpdlMrdXBPZmdpMzV1cFNsOXZHSUJEYzQ3d2N4N0xvRjd3VUt1YlEr?=
 =?utf-8?B?QzlxUk1NTDB3cndLTGp2OVA3aThNczhuM0dpekJyaDFFSFNhQ0ZBbDlQYUlu?=
 =?utf-8?B?enVsSU16M0g5aC9QUzArL0VnYkdtMTF5cHhvQzRPUkw1RlArU3pYakJXM3ZE?=
 =?utf-8?B?OFh0NmNVT3FyZk1FcnF1T2czb0hYdzVmUWh2cUUwbzJnT2U0aWJDQmVQL2FF?=
 =?utf-8?B?czh2N3hYTEQvaWIwVWRpTW0wQytsbStHdHJ2NUhXQTZEQzZzeW0vbURITldT?=
 =?utf-8?B?aStsSCtvVGszNlVvckZERjhNWFBKbDdNL21lT0xUc3RkRXZRS0s0ZE03K0RI?=
 =?utf-8?B?MytlUFBBZE9QNlg3WnlyM0tQenNmYVYrQjVXbEVCZkVJTzVMSkVvS0o0Rmhv?=
 =?utf-8?B?elJ1di9FdVAwZVkwa3R4WHY0b2p5Ty9rODd4dHArNEJzTDNxTE0vNldvQlFy?=
 =?utf-8?B?L2V2dWk0NjhMbWtmUUxsMW9hOWs5N3MwbVMzQ09WU01ESWRjeDQrb3FzSS9q?=
 =?utf-8?B?WTRCYVJjcHh6TkVHVUVtVW91SHVucFBSU2I4TGRxVVdYV2RRY0srZGU4ZUIx?=
 =?utf-8?B?T0tDV3Y5aEsyRUN2aTZlMjlucWpQdXlxdjBGK3M5VG5NL0Y2Ykk4Wm5tOS8v?=
 =?utf-8?B?WitqOTRoSzFRV3JEYm5QTFhmcURDNkZrdTNXU05qeWJNVnVkdlpnUmxrTm5v?=
 =?utf-8?B?ZGY1RGpjNDR4MDlxbDZKZGVEdUNBenBJOVF2MWpJbnhwVC83Wm1oaVdVNTRR?=
 =?utf-8?B?WnZxVDhSU2xyRjd6c2tnZUdyTUxZc2oxbWlHZGVMWitlMGFMQWNGeE0rYks0?=
 =?utf-8?Q?3u+hcyhRtf0tn0KaDXjQh/Esi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 617927d8-3502-48f6-b32e-08dd516c744e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 05:07:20.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZJvAhwAKJgceDO7QYnGxdzKZM89V7dUnvCFVhkfx5Ft2i+sLTuHH2DMxmai2tKhpOFEjNGnnGeyGiPqG0na2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7912
X-OriginatorOrg: intel.com

On 2/19/2025 8:03 AM, Mikko Ylinen wrote:
> On Tue, Feb 18, 2025 at 10:04:19PM -0600, Xing, Cedric wrote:
>> On 2/18/2025 8:49 AM, Mikko Ylinen wrote:
>>> On Thu, Feb 13, 2025 at 03:50:19PM -0600, Xing, Cedric wrote:
>>>> On 2/13/2025 10:58 AM, Dave Hansen wrote:
>>>>> On 2/13/25 08:21, Xing, Cedric wrote:
>>>>>> On 2/12/2025 10:50 PM, Dave Hansen wrote:
>>>>>>> On 2/12/25 18:23, Cedric Xing wrote:
>>>>>>>> NOTE: This patch series introduces the Measurement Register (MR) ABI,
>>>>>>>> and
>>>>>>>> is a continuation of the RFC series on the same topic [1].
>>>>>>>
>>>>>>> Could you please explain how the benefits of this series are helpful to
>>>>>>> end users?
>>>>>>
>>>>>> This series exposes MRs as sysfs attributes, allowing end users to
>>>>>> access them effortlessly without needing to write any code. This
>>>>>> simplifies the process of debugging and diagnosing measurement-related
>>>>>> issues. Additionally, it makes the CC architecture more intuitive for
>>>>>> newcomers.
>>>>>
>>>>> Wait a sec, so there's already ABI for manipulating these? This just
>>>>> adds a parallel sysfs interface to the existing ABI?
>>>>>
>>>> No, this is new. There's no existing ABI for accessing measurement registers
>>>> from within a TVM (TEE VM). Currently, on TDX for example, reading TDX
>>>> measurement registers (MRs) must be done by getting a TD quote. And there's
>>>> no way to extend any RTMRs. Therefore, it would be much easier end users to
>>>
>>> TD reports *are* available through the tdx_guest ioctl so there's overlap
>>> with the suggested reportdata/report0 entries at least. Since configfs-tsm
>>> provides the generic transport for TVM reports, the best option to make report0
>>> available is through configfs-tsm reports.
>>>
>> Given the purpose of TSM, I once thought this TDX_CMD_GET_REPORT0 ioctl of
>> /dev/tdx_guest had been deprecated but I was wrong.
>>
>> However, unlocked_ioctl is the only fops remaining on /dev/tdx_guest and
>> TDX_CMD_GET_REPORT0 is the only command supported. It might soon be time to
>> deprecate this interface.
> 
> Once an alternative is available but it's still in use because of this
> use case (i.e., read registers from a TD report). AFAUI, SEV has its
> reports available through configfs-tsm reports so it'd be a good fit here too.
> 
I think every CC arch should have a presence in configfs-tsm for 
generating remotely verifiable reports. This patch series offers 
read/extend functionality to MRs. The overlap here is that any reports 
should include the values of all MRs. However, obtaining a report may 
not be the only way to read MRs. For example, TPM supports commands for 
reading PCRs without attesting to their values. The read functionality 
is definitely a convenience to applications, and helps performance, and 
can also help educating developers. The configfs-tsm report interface 
will work for sure but I don't how it could be as a good fit as this 
sysfs interface.

> Obviously, if the registers get exposed through this series, the use case
> can be covered but full TD report is still good to keep available.
> 
With this series, the full TD report can be requested by writing to 
`reportdata` followed by reading from `report0`.

>>
>>> The use case on MRCONFIGID mentioned later in this thread does not depend
>>> on this series. It's easy for the user-space to interprete the full report
>>> to find MRCONFIGID or any other register value (the same is true for HOSTDATA
>>> on SNP).
>>>
>> Yes, parsing the full report will always be an option. But reading static
>> MRs like MRCONDFIGID or HOSTDATA from sysfs attributes will be way more
>> convenient.
>>
>> Additionally, this sysfs interface is more friendly to newcomers, as
>> everyone can tell what MRs are available from the directory tree structure,
>> rather than studying processor manuals.
>>
>>> The question here is whether there's any real benefit for the kernel to
>>> expose the provider specific report details through sysfs or could we focus on
>>> the RTMR extend capability only.
>>>
>> Again, parsing the full report is always an alternative for reading any MRs
>> from the underlying arch. But it's much more convenient to read them from
>> files, which I believe is a REAL benefit.
>>
>> Or can we flip the question around and ask: is there any real benefit NOT to
>> allow reading MRs as files and force users and applications to go through an
>> arch specific IOCTL interface?
> 
> FWIW, I'm not thinking about IOCTLs here but configfs-tsm reports: a
> single read gives you all registers as specified by the report without
> having to add anything to the kernel ABI.
> 
Guess through configfs-tsm you'd have to select the service provider 
first. In contrast, it'd take only a single read from `report0` to get 
the full report through this series. Moreover, it is table driven, so 
these `report0`/`reportdata` attributes add ZERO code and take only 2 
table entries (<100 bytes) to implement on TDX. I'm not sure if adding a 
local report provider to configfs-tsm can be any simpler.


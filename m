Return-Path: <linux-kernel+bounces-333711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA097CCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5A8283359
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09D01A0B02;
	Thu, 19 Sep 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ssw9IHGV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF719992E;
	Thu, 19 Sep 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764948; cv=fail; b=a03oZbhcJqQfEYeANsVJ50YAmiGLiUxQyH7o5tc9JI9VgyklgVcGZ6NuA/UkgwkrRXSBUDDJiQWAdbox6Ero/UQV6eZNMwoa8DyOQucLRVWVUz2Yohm/EBK0f8diLAIs/ofLmacSp7AMsOAcEg8Nv8zeK2nVPX153r21G5pFqRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764948; c=relaxed/simple;
	bh=w3KdzNXuOhTzK2F4bZRBfyBf3o/zF8wkRG5NFlgf97s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nVyPmxf4QlqVYCZ4mJQ6ewkyJOO5q2QSSW7YEjRugXE58uOVGjCnyl+6WPWCuB0ta1d5SAu3vR8QL0kZM8XxfDvNSWLyo0UYfxBLOo6Xv+CnheJ6oFC3RHZIHjSnxeEWNxT9wooTMP+6NrbbVdqiBu/dq5U0bfdcaw0pbCXk5Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ssw9IHGV; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726764947; x=1758300947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w3KdzNXuOhTzK2F4bZRBfyBf3o/zF8wkRG5NFlgf97s=;
  b=Ssw9IHGVBqf9KDObjb2Ij5xkVT/ZBpFxbX90S4Ix4B6mSaZazk5Nw5zM
   e6MQekqiNiNObBzvzsvOxJRkCzcyoghs8ovPkraOarE+ocrVqw2XWIsUA
   yvs4Yo4MC84UCXsAUSmdIeUgRzCG1Jzz9uD6kupM9Nc0udD1yPOMD4QN6
   8ptgeLg30zmqLovwsRuFFxn2/l6bXLVK+oGQnuBqNt7/VeGx9VNSRZlT3
   Z9lFc61IJm0wBD+5iJoajgGshGhG3VAjrzNa6DFAi/jRarBe59MPqe401
   trfu27gIh2oDwCBtiRXxUvnS63novhJBFxquLiv1ehd/oyfPuOFy1PWVc
   A==;
X-CSE-ConnectionGUID: xiUfO0x0QvCD+z0PMxRpdQ==
X-CSE-MsgGUID: DfMHuFAMTCWNKV5vjOh3zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13596255"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="13596255"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:55:46 -0700
X-CSE-ConnectionGUID: 38/ZOkzORlijP6gRqFI9KQ==
X-CSE-MsgGUID: aPZaWYSbRY+ZqipgCV7szA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="70448147"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 09:55:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:55:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:55:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 09:55:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 09:55:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+WzGdvVlWAwNo2gn0tuDImejfjb5JAL0E/8xsA9CuGnF6Mtl3oyXN4MQwXbRCkrjGSdvg6kCfTTKjdtXvG28IHeEkrgzzUyu0r8DyUv/lR3eqdfkR1U+DxBEuXMo+25hXurrCx4RmEsEg3bs4WI2YPqYbAMxMFgzXifM5zQDxWVjLtiVi691CUruWOUg8YBkom/65q+TX8g4RXAPJzF5+8LIwdSo2UcesNMWWvUWINlX64piB+pH3botydP80EVUXDtGibkTUOAPV2lxlbsGlGBZ9/6pkkpQvop9RHSIy3Hv5PcBGo/6D074rm7CqJ9vECjzm4CrBHv2v2hykrovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JQ8Jm7ZlH/RO+9pAc4A3VwLC/j2AG1RkgqX5BTVYDI=;
 b=fsIO6Z4xdGoFReoebNv3B5yMTwhB+WnFl3V4sAp5mGMOJYM01VgjpEeQYQcDOyIolVpoc9FVHG074qkCAR6vp0gCO8CRuVi3bzXX5KJ/VzbfMQ3GtQvNLojdQQHP5hoNXV4SZ/1idVVk8N4WyZ0MZfaxpevip5TFQipZ9BOmPrMqDe/W0cExfKF150eqAo48Mb/yoWI1rwkz2jtroS0haAVs75fQsW30OKcYARoD465AmmLLxlcT5qfCL8nDNkFQwN8qw7RJFHzIdJ2qhqR1LRChZ26AUN3BUOKYCBht402gDkMsrqjLIrO9S2vrngoxYM6qo25zEkMKihMhOCgjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 16:55:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 16:55:16 +0000
Message-ID: <ea526972-cbdf-41f0-8861-7b4702bdb7d6@intel.com>
Date: Thu, 19 Sep 2024 09:55:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/24] x86/resctrl: Remove MSR reading of event
 configuration value
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
 <dd3a5803de44391e7496649147d8fd03ebe52525.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <dd3a5803de44391e7496649147d8fd03ebe52525.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b20a33-ceb8-4a8c-ae58-08dcd8cbd66e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTd6VEhSWTN3bklQS0kvN2liZURhdDFLTjRqWmRaSHMwTzg3WWtNaVdhNmht?=
 =?utf-8?B?MFFPY0l2bUJzME1VRzFaN0w0ZXJRckFqRHJ4cG8vUmJQSTkyQ0dGNVhKKzZh?=
 =?utf-8?B?bTdPa1drUG1WeXA5RzQreFRTcHkzNjY5TnRqalYzSmFKRzJFTjBOSXRtOEJz?=
 =?utf-8?B?TU4yOHlmQThURHB1UE9mL0wwaU55YnpUb0o1TWpRUEtVNmtkK3RLMnZIcjA4?=
 =?utf-8?B?K2VHMnRZWVVKK0p4QTZOT21oNjczTnlEWmNlK0tsS0h5bXBhcGdDODRXOUho?=
 =?utf-8?B?TjBLL2RmSkhNRzVEcDE3MWoxTDFwQmhMRXJjUGVBVDZFZFcvMUY4LzVqZytJ?=
 =?utf-8?B?c3dLSWEvZmpLb0U2Ti95N3A5YzN4Wk4vVmZYTG5zVVFjd3hCZ3g2NEJsWU9M?=
 =?utf-8?B?NFZ4OTN3SzJXamlsY1I4QUcyWTAwL1VvVG85d1RDTHNWUE9BYTNYUnFNemNl?=
 =?utf-8?B?YTZqeXlEUWx5bk9ENlErekl6TXlhMHBmdzVYQS8wMUh3K0dUcFViM2ZicWdZ?=
 =?utf-8?B?a0NHbmRVRmY3M3hHWWY4K1ZlRVB2cDNCVGdKdTNPSGEvd0grd1dtK0VHdGl5?=
 =?utf-8?B?bmpaVDFueHVMby9DOWJKNW9HanJSSWNTai9DOHp2dC9USzNwU2xOTmdWQTlY?=
 =?utf-8?B?Q1lVb2hVdDJHZnREaGtzRVQwNTJlcTVHNTc0MHlDTTZwc0xxNlZueWFZN1Ux?=
 =?utf-8?B?QzI4djF2TUl5WDU0NW8xcWlXWjM0UHYrOEt5VEVYTnVmRHhZVkFmUitHaHZ5?=
 =?utf-8?B?emV2NEpRQ3J6SElNVmpwb2c1TG5FeHd4Y2pHVGxLbTBTRnBwMHN0djNyR3J3?=
 =?utf-8?B?WjlJYjFOMlorbHNnWVphRm9NeWRhL2ttcDJjQTFtaUNBd3A0TEp2Y2pyMkRK?=
 =?utf-8?B?eS8ydmdvajFxTWR4WXVtZDFSelhTd0V5amNkckpUcmg1SHZOMTYzYTdTN0Yw?=
 =?utf-8?B?WnpjczhBNWRrNWZwblV0SndXZzBkOHd0LzhycnBLWDZrcUkyalNOWFBHMklR?=
 =?utf-8?B?KzZ2MlhsSGhHT0ZQYVFheEE4elloaGN0QWpIUkZJRXRuSVNPOGtEM3A3d1Bw?=
 =?utf-8?B?OUpwZW9wZ0VtRnNwVWdqejZHUk5Qa0xBZ2Nrd0VDa3pHZlVZd2U2RnBQa2dY?=
 =?utf-8?B?T3RwQmpTTlpOVmQ4a0pSc0NyOUkyZGRQaEovbFNZUGdjeU5nWVh1Znh1aGps?=
 =?utf-8?B?aTlkZnA4RTVZRERHZzlSK0ppczhCb1FabTlBd1NFVEdEd01QYlpXWlNZcjZu?=
 =?utf-8?B?VnRGbFF3Q3o4eG1lY3Q3RWkwT1VLQjdDcUhmN3N2S0dxeHZXdEFpVlVRSWdv?=
 =?utf-8?B?aWoybkxlNWhzanRyVnRxYnpxNEpxVTd1VmZ2QXFJbDVqbjVkeDZFeElsOEM4?=
 =?utf-8?B?bFRLMDFHMmhyQ3p0anVpSTJpTzBzbWNDNkErTjlweFhzVlRSdm5DU1ZuY3FQ?=
 =?utf-8?B?dTBwaGJtY1NaRW1NYlQ3WUphTktEYnlrVzh6QlNQV1JoV1hpZlBiWnhLRVZi?=
 =?utf-8?B?ZHcwMTlPTmpVaCtka0M5WnlZQ0FxV0dZUlFDOHJHdWRnYjk2K0hFY3dzTU8x?=
 =?utf-8?B?NFJIUGoxY1NZclZLWFliRDNpK1FTbjNGclZUcWVBcy9rRFFSRGdoclRjOWNH?=
 =?utf-8?B?MUc3bmpPbzJuNzU4YUFyYkd1Rk9ZQXUxQm5oZHNEK2JMT2ZpaTQ5eDQ5Rmd4?=
 =?utf-8?B?czhGbnFaZ0FWVVRHMW5EVE9XdzFvSzF6RHBLLy94NGtiYTVvUkp2b3RETTBJ?=
 =?utf-8?B?UjJNQXlhc0xxdnJEU0lGa1Z1SGdQdlBYcXN5VktKbEJxNmtWVkJMSTRaei9K?=
 =?utf-8?B?dmhuTmVKbldVZjhvNlFTdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0JsV0ZZaVlUMWQ3OWY2OGtkZzZLQnhqR255Ykp0QzEvZnN2VGVqcXhGV3h4?=
 =?utf-8?B?dGxXNEU1WDdrZjR0ek9ma0pOcTM4QXRML0VhQmdrYUtwZmYvVjFMMUNjbC81?=
 =?utf-8?B?aEZZY2o1UTNOMHNyVUl3LytYS0lsMTBFNjFHaU9SK2ZWRG5XT3BqU1dVSVEw?=
 =?utf-8?B?TXNpRXBXYkJyb3dKTERGTGFGMk5vUjVWNmdSYlo2cUNKU2dPT2NzNm9tSkZM?=
 =?utf-8?B?MTdNL0xsa2hiM2NhYTZtK21DcER6ck1PdmpEeVhGSnNRMkNtV1RMcitCQnk4?=
 =?utf-8?B?cUpFcE5Rb0ZMVVVlYnZ0VGY5M0NjVzVSeWxHSlkybnFLQjNXL0VzME9TRk9C?=
 =?utf-8?B?emhqWFpZTlZGUFVKZlp0Z1pRdFAvcU9hSjY5UEZ0akZDaWJKTXlyNHFXTGlX?=
 =?utf-8?B?TGlPRFhScDB2UjMzRUQ4TktET0hMcEY1cEo2bEhMME42Um9WdGdiU2VrU0hJ?=
 =?utf-8?B?Q1VrWTRvQ1VobjVKYThXYnpyWFlVWWdka2ZaTWI4RjJVYm1wcytldk9DVlVU?=
 =?utf-8?B?cWVGS3hoUlhaN1JsQk5rYmpqR0JyYVNKUmRjRjBOb1pwNHRSWW56YmhIcUlx?=
 =?utf-8?B?L3J2d0R3R3R1MU0ySUNrM0tHRHlHNUNqK01OSGpPYSt6eXNQdWo5Sy83Q0ZX?=
 =?utf-8?B?bk93a0dMZzc0TWxhWGFrNTBCeGdwQ243T3NHSVRmcVJmdWl6VExkODZSOHhx?=
 =?utf-8?B?TFpGcVZzYkJ1bXBldTN1UDVUZHJTRXJZWFNyRGkrM2d4eDcyaEFNQmJ0TzND?=
 =?utf-8?B?OHZQd0Z3dlR6TTBtdkpJU2M2a2NMSXo4V1hiblpobnh6UWxNVTU2elk0a0RE?=
 =?utf-8?B?MUx6RGtvM25LUFlWRXUwREVaOVN6V2hEQzJnOW04ODNGWkw1enh2ZDU5eDBF?=
 =?utf-8?B?MExTbTVwUkQ1VlFNZUtZdUpGbG90Z0xQM2psZndTRGw5ZWVhMCtQMGx2Mlg4?=
 =?utf-8?B?dnprSFNPSVZlYXpQWWRPbkxwM0Zab2dYZ29NNW1hT242Z2t6U09qVUJFTno0?=
 =?utf-8?B?dE5JMHB5MG5ZT3lYV29tUm9UVWloY251K1dRWldPc3NGdGlnMGZNSENKNEw3?=
 =?utf-8?B?ZnppQlpWSVh3THh1VnNHeUxKMzYwMlpzVUthc1JCdXhWcFlPYWZMVExEazk2?=
 =?utf-8?B?NG4zNXJvczNubTZUa1FUNXorc3M3LzlpR2Q0dGJISkM1S283OGFxeWY0dmZw?=
 =?utf-8?B?NldKTWYxM2RMaGRDOCtVellnbS9ldnVYc3Y1bUpTRHRSZThEMm00bTVRYWRs?=
 =?utf-8?B?V2FITVRxclczYTdnNEMwNTl2czlLNy9FSzRrUXBId2RtVktjbmZjQ1ZNTFNE?=
 =?utf-8?B?OHlBcVozOEhCa2N0MnowN01OQWozMnJ5RGNRS25XQkp6UERpcENjc0g1cVhF?=
 =?utf-8?B?REFEcG4vZEhveGthZVFiMXJOMGdCdjV3RHFYcFlpcXFwOEU5V05WME1IMkdr?=
 =?utf-8?B?RSthaCtjajlwejVwU21QbVAyUzNzb1RPRlhoNmNKUXZTOWR5YlF4b2ZPT0xl?=
 =?utf-8?B?eHRSSEY2ZllKMUNoSXRhc0FwR2lEeFgwSzBKdkZxb0R0dkJXb2V3R1BkYi9S?=
 =?utf-8?B?VEs0ckZnZHpTeFBsUFVyMTRnVFZhSUMzeWVKaG9wL2lFaENUbG9adzAraHl1?=
 =?utf-8?B?VWRaRFdCdERhQ2JjcllLcldicGhobUZmWXc5VTRHT0Zsa0tJMjNBdVp2SjEr?=
 =?utf-8?B?ZjQ1WWZNYlcyTHVoeUVFOUNpSmxGbUNXbFFtV3VIb3dpOWMwUHJxK01lMHB3?=
 =?utf-8?B?d20vUU9JVDNzQWIwRnIxRWtsVm05TG54QlRlaWFGNkFEVDFTSmZpLzZKY3ha?=
 =?utf-8?B?dmVOYUM5cHlOR1A4TGJVZjkzejhtMTJqcUdxRjRoUFVpRElmeEZkcXROQzZJ?=
 =?utf-8?B?TElXalJCM3dWbktTa3JxdHo2U3FxWTVLRjF4TnVqT1ZRWW56azIrb2ZmMnV6?=
 =?utf-8?B?K0xQQUJDemdyUXZ3UGQrRE9YU0szL1h3TGFuUFV5ZU8zRkNPWEZkckVtek1l?=
 =?utf-8?B?NE1UeTVxOWxnQ0s5SHlnYk1NY1NGSEpwMDM4cTM5dEIvcURlYmVZMjYyeC95?=
 =?utf-8?B?b2J6dkswRUhzOG82YXV3QTlTdUdyRTViT1p2TnFycEdIb1ZVdktQY1R5WFR0?=
 =?utf-8?B?djc4cVZocG9jckh4Z3pIUkU2T0I5bTlDbUhSZGxPNlAyZG5iaEFEWm1IVy9v?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b20a33-ceb8-4a8c-ae58-08dcd8cbd66e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:55:16.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tH1z2sDbx12q2dSmLune20Z56x3oNm6+oyB/41qtSqVGH0KtHHXqFWAGruXmpsnEi7RTUNBi3zxaBpyHPuqIQUdnpnJivyVF+SV8JY0O4Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> The event configuration is domain specific and initialized during domain
> initialization. The values are stored in struct rdt_hw_mon_domain.
> 
> It is not required to read the configuration register every time user asks
> for it. Use the value stored in struct rdt_hw_mon_domain instead.
> 
> Introduce resctrl_arch_event_config_get() and
> resctrl_arch_event_config_set() to get/set architecture domain specific
> mbm_total_cfg/mbm_local_cfg values.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

This change looks fine, but could the function names be more specific? For example,
 resctrl_arch_mon_event_config_get()/resctrl_arch_mon_event_config_set()?

Reinette





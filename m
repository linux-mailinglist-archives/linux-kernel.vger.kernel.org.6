Return-Path: <linux-kernel+bounces-290351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C694E955299
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0FD1C20C09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3741C461E;
	Fri, 16 Aug 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxpPmap/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69E4315D;
	Fri, 16 Aug 2024 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844475; cv=fail; b=dcWKjpR9YiK1bOoyX5qSLEBomfKEeM+oE1SNcZ+rIOWDPPVrbBh4zz95ynoTM6F9UYLpC1N2qgBY1gRWybgAoF7eu9ui87qPwgRAA4M0ngSvO9vnPY1Fr9ETp0ZlM2V1wL374j0OWyOYNqJuCFqcYFuZbLcGYHKPUfldDVR5YlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844475; c=relaxed/simple;
	bh=FgVwzV8PU9hQ0y/fMUWlLUVUCwyvGrj58FUA/OVwl6Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a/0TDSW7zzEAHhCMzLByEiwxZv6/QQyrUzf4nygsx8RkVODKo3H22vFRjTRoHlHGIDbE4Iwglm/zDU1u9tkFiHJtU6tb7UxqENST5z/uwIbGPA6xmNSnTIX65H9Skt4NvOplghKl4sC+uC4iTY57ZqdTck60WsDu8TXLec8+Gd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxpPmap/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844474; x=1755380474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FgVwzV8PU9hQ0y/fMUWlLUVUCwyvGrj58FUA/OVwl6Q=;
  b=JxpPmap/r22mLhUc0g1TBZvL1iG/m5lfO1G5DFckOgNzfmVYHrvPvkFq
   ws2HdAF0gkgTPPlMu1sihm64uHdoo+8SbGjV+NcbgKshPMnveoqYo2JMM
   8TIw/oQ2cFIdfvsn6CsW4AZzjHMZp5/bFIJmACKVsAKgbPcamXNruKYlk
   Z6Kd6Z7vdmzyUFP6lzuNUlA7So/B2ESgJXsLF2dyDA7f7uafJT6XjyKa+
   /mDydoIHG7ftRUDL4CkOQA9IvFO43+0QgzsrfXNsWjAxRTbWeXK5Io7EL
   g/iDCfZIEmlYgkY2to4bQ3lq6XJeUDAI5XBoY+chV3xaBCB8Z/xI/dhW2
   w==;
X-CSE-ConnectionGUID: UuiDVXZUQVm9XhnpYTxuyg==
X-CSE-MsgGUID: xc3/3vjcRA2Ykn/JosnxRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22325511"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="22325511"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:41:12 -0700
X-CSE-ConnectionGUID: XBDrMPj7RqyOcZ1+H/3VyA==
X-CSE-MsgGUID: UXAVZuqxQMOdtNlDAWmwqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="60066604"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:41:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:41:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:41:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHqVIs6AihXN6D5Zm1d1nJhZSIRGzZUF7U3exlYaCpoaItYlAE/uWPXG66lfvQlVg/HmQslJ7Uooc0qA2bAZNqNVik1Nwu00ZJ3uGCJz5svjHxCRSxomEHKrwHv7tb8b9+FxDU5A9S4xZdk137Xj/6mQWHhot5ew3nl9Q4iwTRyYiXPa08dW4oMEG6wDu3QVw0zlIsVKiGDUnS5eUNh44vXIPRXxiuB4/FKEjlyI7a4n/pHnnAVzw+W4TM/ZThnKVGwEwa5DrbXZ1HyO2CmLJd1OJ2nzTQ1WOJKoFvYXOsmRSb/+aFFFZFJHSNRvdRjh7V8OXPtUl9KwRq8xsbJ11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQEcctdXCBDFM0FBNT6y/elhNGZAmiCQoUWut0fCRL0=;
 b=V4LIm9LTpsXvd6DJhmJCiZlWJW9nEzJstUTPEhMedWh+SkueIDu/dokf35PkhWoJzjlZmVTS5S7po+V8/B6qFyKTjoRVaoAZ2kgAchhcuAtUwBdlZPfhwIUCiV7Iz864AQNzBqEjjemiGfL36XgOMDXWlTeD9vIyM+bnYJijdbnoUlqu2xKKWS7umTjg6/9ujhEXyaZk2Lb+pxHpLp+E+EGmoDE0SZyQPbhGtmOiwhu/mMrHTAR6NIgPxZBQUqxJlisKH++4e9L0fImPA7dOrn/JpJv884ajX9DiniXsJOtGMCqI8s+WJSFOjXLatPlU6Y52AVw5Q/ZW0HwH/xVn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 21:41:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:41:07 +0000
Message-ID: <aa118320-72eb-4dd6-8826-0f3f7287becc@intel.com>
Date: Fri, 16 Aug 2024 14:41:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/22] x86/resctrl: Add the interface to assign a
 hardware counter
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <099ecbbe678dd44387a8962d0cb81e61500cd2fa.1722981659.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <099ecbbe678dd44387a8962d0cb81e61500cd2fa.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:303:b8::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecff65d-7077-4b33-5773-08dcbe3c22d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVBMN0I5RmNldU92RlN1RndmOTdyVythcjV4NnU5NUVLaVZUL3NURnNUL0JR?=
 =?utf-8?B?L3RZS1M3VCtWNmxDMFEzMDg5RVNubGpsVHhZZmEzNDM2UWw1Tzd0WFhWN1hM?=
 =?utf-8?B?WGx4NWJRUldxU0pVNCszRW9tZUFRa29NYWlkQkNBZDdNWWtzdndxTEdlK2Zu?=
 =?utf-8?B?R3Q2QnVxNlh6WXp1RFIreWk5MkNFSTMzZlZnTXp6Qzk3bE5TUGEvSGcyWnpx?=
 =?utf-8?B?OVdtZ3B5NUVLdFdiSFoyYkNIQzNoL1BNTTVrVmVZSEhTbSt1Vi9CY0VpcitM?=
 =?utf-8?B?TDVRWHppb1ZYblRxK0JiTmJSUEpLSjJZRFV0cFN5OUsybzNmU08vM2JDM2tF?=
 =?utf-8?B?YjNwNHhRTlBIaXpTMVlJZmtIcW9relFPQzlWWEk0cHQ5empOazFwd3U3bjVy?=
 =?utf-8?B?K2cxMFVPQ0N1UyswZG5NYkJqeXFJQUo5SnVyTXM4Z08wc2pNWW00QnZYb2Rl?=
 =?utf-8?B?Wm9UNHVrem1MVTQ4YXRVLy80cVFEOVlRV0FTNjllY2VNdVk5R0hkRFJEczdK?=
 =?utf-8?B?eVRRdHdzQ1U4Q1ljdkx1TWw4RmtpUTZQb1lkL3hiRUVSb2NMd281OHA0b0pq?=
 =?utf-8?B?OTNVY241VmZYZk5xZTF1eitncjJYZmNzajQ2d0NUbU9vT0YvT2IxdHptTi9R?=
 =?utf-8?B?eE5NNS8xL0pkNG4yYk0xMkxjR0FiMmRLZDBueDk4VDgzOE5Pa1NFSDgrSzJQ?=
 =?utf-8?B?SEhWbVpXZTNWbG5KeW53NHF3ZW95SmZZeU1LSGxDMFptSGlPVDdhVkdNNGUr?=
 =?utf-8?B?YWJpY1htVXhKQ05uZmwvNjkwK2l0b3F1Q1Rsa0NCQStBQWV4MXAxMXQxZWpF?=
 =?utf-8?B?M1FDTjRodVJIQXQzOUZuclo3L2g1K0JzQmRZelBXb3RpbmNrY005MWVsTlRz?=
 =?utf-8?B?VHVvWUxzbXhMdnZqNzQ1b2NSV0loS0Jyc1NTc0ozeGp1QzZUaG9IbzBXZWJn?=
 =?utf-8?B?YmNSOXZEc01QSitQdEVDOTdCZ29TRzZwN0Z2ZGk2dWQyT081QmpqMFEvd094?=
 =?utf-8?B?b3FiS1ZPdXduYUlxUDUvTnRjU1RFYzFTakpxRWtaTkVQekZqYkVLUzM1cVlK?=
 =?utf-8?B?MVBodHhUa1NRUVNleS8vdm9ocEtZbFlPeGdybmZ3YnQzd1o5ekxjQWVaejh5?=
 =?utf-8?B?MkJmZGUvREdIam4vZnVwcm1ibE53eXBHck9iOENhUGxTREFFeDY0ZmlCcVN3?=
 =?utf-8?B?cHg2ekRBT25KMjlpd1lUZ1R0UnFyUHN6d2p3RE9GdkxKcHZaMEJWVHdCbkFu?=
 =?utf-8?B?SnZqRkg1eDdIRUtwNHVuM1dmeFJINlpBTUx3RHZhQlVJRjNiV0VkQXhXZXBS?=
 =?utf-8?B?MzNXR255MkJsSTBQdzl3R1diNHBtekNRb2FBUFJLeHU2TThFZHV4dTVPbEM1?=
 =?utf-8?B?RTVRc3RmdTVXakVsK3VMYmtvWGw2eDBIUUxqYk9uM3J6SStBRXV2UER2QXgv?=
 =?utf-8?B?SkFIanQxZW9TYzZKaWhwZWttRmZNL2xQZnhjc2tsaHo4N3VoWTFrVE9YS3Qr?=
 =?utf-8?B?V2lVQzVncXloaDZDVTM2UEtsQzlDaW5MVkIwNktmUmNxZUUxWVN5RU5ZMWZJ?=
 =?utf-8?B?U1c3YmJBY2VzV00vbEROcnR5c0hhN1RxTXZPaVlDTEtmYmlMNE1taXpWUjhr?=
 =?utf-8?B?bXpBUWp5Um1iYU43L0lUc214U3FKVkpKMkRlNlIzRmJiVFpWT0NYcGZOOHA1?=
 =?utf-8?B?WHZuYlpPQXpKUVR1Y05DUUROblZzc3JwMEo2WXBTZ0ExMTg2UFQ5Y2pSRzcx?=
 =?utf-8?B?R2l0c2ozaENBREJyRFE0cVRlSEk0c2hsbllTYmFnT1BEZkRuMzFuUGMxUENr?=
 =?utf-8?Q?fIZZXLRUYWUHh/mnT3gjteJXNcWN6gK9j7pFY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkpUaUdHLzlnSXJJc0ovWHVxcFlZNGZQempZcXZJb2t4TWF4TE4xdXZxdndh?=
 =?utf-8?B?eDJTUnJ0N1VpT1IzM09JK1J2K2RQeVhmNHlERnVDa01UbEhFTERXcGJQajNu?=
 =?utf-8?B?RVRrZDF0VlFab0xsTVJGS3RUaklLU0dSREFwQitNbEkxUE0yVUZ4cG51K2VI?=
 =?utf-8?B?L1QydS9DdEhvWENXeGRXd0VJSUVCY3hyaGZ3VlJKZEpGdTh6UEZ2Nitzb1Uz?=
 =?utf-8?B?L0dmQmdzWUd4NG16STZKZmNoT3cvZ291Y1ZRZEtGamRDSUdXSGk0L3FBWnN4?=
 =?utf-8?B?RzBqcm56dUZIQXNmTmZCTjJQVjdlQ0xaNzIxV1ZxMURaN2pSbzJXZWVhREVS?=
 =?utf-8?B?MU1ZbXNJNFN0Wk9ESzdnNmhmNUN4MlhKR1M5TytjWjlDRnhrOWRVWXc2cDZo?=
 =?utf-8?B?bUdDMjdabHBDclZWY0NyTkt4SDVla1YvZHQ1WDc0TFVSa2xCM1hzMWM0RXpj?=
 =?utf-8?B?MlZzam55WEUycVpQODRUaFNxSjQvYWdCM1NCckF0UktLNnNmYldrcXJ0d1Mr?=
 =?utf-8?B?d3BzQTJhMUxoS25wZ1UwblU1SGdiaDdFYWtaVUV2a2ErOStaMkttaVZGbjdn?=
 =?utf-8?B?ZXJMcTA2emlsYUk5VkxyV1U2TENHNHVHN2gwOTVkZnI3ckk1RnAzZ001ZFUw?=
 =?utf-8?B?T2FSWXVPSVRCTENaR1hhai9KazhGdUVvK2t4Qzl2ZFVaVFNtY1J2a3JCc0hm?=
 =?utf-8?B?ejJnNFQ1azBxOHdXSC9IU1ZlaFJ5YVI1OWU2ZTJLVlJudFpvbEZmT2pJeDZL?=
 =?utf-8?B?MHZaYzRhVmloalV1bkxsbmN4dXJBTzJKWjYxMmlKamU5d3hwdGdVdkw2OXY4?=
 =?utf-8?B?QW9JU2JQc2dyaEpSb2Z5akdCT1dGbzNWK2tiTEN6SG5obkhzcDNRVWNyUUR5?=
 =?utf-8?B?MEZua0V3OWQyRXluZzR5NWFBSDFIZTFkUVBMVm5tNUJKdElLRFN2cXFMTFQz?=
 =?utf-8?B?S2g5LzRIdnFkam1iKzFiQWxUMzBnNklvbXZXaGlMT0pIbFZ6dkFXVXJVdDZm?=
 =?utf-8?B?K24xSFk3Y2grWUFpMXFvNjlGSHZ6YnA2WGNUcXJZVk9xMmt6K005elI2d3Rm?=
 =?utf-8?B?clU2VXpiRVV0cjFUT2lHYVBCMjZZcUFOTEhPVlozZzJZV3FueC8rY0NRVmxy?=
 =?utf-8?B?N2p0WG9tZTJXa2d2WXg5T2doUzIydFUvM1VBYWNPa01RZkxMQzVjSHdoSG1q?=
 =?utf-8?B?cGNuOHhBREVwbGYrSUw0RW1tcGE3RXR2S2VSK0daeEVKZWdScjM3ZS96QU5u?=
 =?utf-8?B?UkpmSnRPZndIU0F1aEt0eDRUM0hlRC85SXRaVVdXMTVIMHJUVDdsc1BTUHEw?=
 =?utf-8?B?TDdDdUNRRGxuYnVyQU1rU3BjbkZEc3htSzFJUXVoQ2ZRYWoxT2JTZEpvcDJY?=
 =?utf-8?B?eWpCRlVhaFZXak5LV2ZlZ2IvMm5rRTkvTHVaZkdmQlpsa1BNTXRiTnJoeEs3?=
 =?utf-8?B?dUxvc3Uwb2w0RFkyQXJkbnU2K2s1NWRhT29MbVN3SFJLd3IzdUdIcGU0bkF3?=
 =?utf-8?B?a1BxVmFYaE9uZXZCTHNSNmdXQW4zU3hPNkxnUm5yZEh5MHdGOUhMY2xLK0FS?=
 =?utf-8?B?T1BDaGN1Y3pxM3hOblFybUxOTTBuMlpVcTVzWDd1S1NmTTA5Q3UwcmROV3FS?=
 =?utf-8?B?Mkd3RGxLWGkveUp3amZIcXc5dTl1OUwrQ3RlQnlrYllFbWhQQy9lNlB2R2dR?=
 =?utf-8?B?KzhFWFJlSmJHaEFOK1VBMHRPNXg0TFlXWVdBREJpVmJuSGV3TFFDMGMxekNi?=
 =?utf-8?B?VW0xM0xpY2pYOGpzdnJjSmlta0prU3M2RVFlY0hJTFpzT2U3TE1KTjY0Y0py?=
 =?utf-8?B?azVFMFRFNFU1Y01zVVVibGMzU1A3UDE2d1VaeXd2TDdQRUZaeXJ0aFA5K0g4?=
 =?utf-8?B?cVJxVDI4eGNPNnBFVThXZHo0c1VsdWdtcDJaeHhheTZaeTFyMDdhaEtzeUY3?=
 =?utf-8?B?ZTUxdm1sRS9YTFNnbHFmVkNtN2tsUHltWWdObkpSdTJ4RUJ2c09DSUdSR21V?=
 =?utf-8?B?cDFlcml1b3UyaEptQjlZMTVEemp6RU1EamVzOEloRHB3ZkpyOU9KK0ErNGRh?=
 =?utf-8?B?U0w0emJqZzI5NTJ4SkhpNWF6MSt5VEJXTjk0S0p3d1hFODhYOWpXUy9aam9j?=
 =?utf-8?B?NGNaVGdoWWtHWHhuTE5LQ2RnTlF6TDJFbXRRU1ZBckxBdlVRY1VZWWhyYnV0?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecff65d-7077-4b33-5773-08dcbe3c22d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:41:07.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qqh8dJFHQfhZ41Ht8nz2wC4d9ddlw29gENF6tHsTPLd70qB39XkYonDn3CNx3jAOReT887zkcJjO9VZwlmXUMizt5eA0BKI0iY9ELAFDTSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware

This patch is a mix of resctrl fs and arch code, could each piece please
be desribed clearly?

> counter to an RMID and monitor the bandwidth as long as it is assigned.
> The assigned RMID will be tracked by the hardware until the user unassigns
> it manually.
> 
> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
> specifying the counter id, bandwidth source, and bandwidth types.
> 
> Provide the interface to assign the counter ids to RMID.
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>      Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Removed mbm_cntr_alloc() from this patch to keep fs and arch code
>      separate.
>      Added code to update the counter assignment at domain level.
> 
> v5: Few name changes to match cntr_id.
>      Changed the function names to
>        rdtgroup_assign_cntr
>        resctr_arch_assign_cntr
>        More comments on commit log.
>        Added function summary.
> 
> v4: Commit message update.
>        User bitmap APIs where applicable.
>        Changed the interfaces considering MPAM(arm).
>        Added domain specific assignment.
> 
> v3: Removed the static from the prototype of rdtgroup_assign_abmc.
>        The function is not called directly from user anymore. These
>        changes are related to global assignment interface.
> 
> v2: Minor text changes in commit message.
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  4 ++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 97 ++++++++++++++++++++++++++
>   2 files changed, 101 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index d93082b65d69..4e8109dee174 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -685,6 +685,10 @@ int mbm_cntr_alloc(struct rdt_resource *r);
>   void mbm_cntr_free(u32 cntr_id);
>   void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
>   unsigned int mon_event_config_index_get(u32 evtid);
> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evtid,
> +			     u32 rmid, u32 cntr_id, u32 closid, bool assign);
> +int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
> +int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index);
>   void rdt_staged_configs_clear(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 60696b248b56..1ee91a7293a8 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1864,6 +1864,103 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>   	return ret ?: nbytes;
>   }
>   
> +static void rdtgroup_abmc_cfg(void *info)

This has nothing to do with a resctrl group (arch code has no insight into the groups anyway).
Maybe an arch specific name like "resctrl_abmc_config_one_amd()" to match earlier
"resctrl_abmc_set_one_amd()"?


> +{
> +	u64 *msrval = info;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
> +}
> +
> +/*
> + * Send an IPI to the domain to assign the counter id to RMID.
> + */
> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evtid,
> +			     u32 rmid, u32 cntr_id, u32 closid, bool assign)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct arch_mbm_state *arch_mbm;
> +
> +	abmc_cfg.split.cfg_en = 1;
> +	abmc_cfg.split.cntr_en = assign ? 1 : 0;
> +	abmc_cfg.split.cntr_id = cntr_id;
> +	abmc_cfg.split.bw_src = rmid;
> +
> +	/* Update the event configuration from the domain */
> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_total[rmid];
> +	} else {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_local[rmid];
> +	}
> +
> +	smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_cfg, &abmc_cfg, 1);
> +
> +	/*
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in next update.
> +	 */
> +	if (arch_mbm)
> +		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
> +
> +	return 0;
> +}
> +
> +/* Allocate a new counter id if the event is unassigned */
> +int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int cntr_id;
> +
> +	/* Nothing to do if event has been assigned already */
> +	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET) {
> +		rdt_last_cmd_puts("ABMC counter is assigned already\n");

This is resctrl fs code. Please replace the arch specific messages
("ABMC") with resctrl fs terms.

> +		return 0;
> +	}
> +
> +	/*
> +	 * Allocate a new counter id and update domains
> +	 */
> +	cntr_id = mbm_cntr_alloc(r);
> +	if (cntr_id < 0) {
> +		rdt_last_cmd_puts("Out of ABMC counters\n");

here also.

> +		return -ENOSPC;
> +	}
> +
> +	rdtgrp->mon.cntr_id[index] = cntr_id;
> +
> +	return 0;
> +}
> +
> +/*
> + * Assign a hardware counter to the group and assign the counter
> + * all the domains in the group. It will try to allocate the mbm
> + * counter if the counter is available.
> + */
> +int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_mon_domain *d;
> +	int index;
> +
> +	index = mon_event_config_index_get(evtid);

After going through MPAM series this no longer looks correct. As the name of this
function implies this is an index unique to the monitor event configuration feature
and as the MPAM series highlights, it is unique to the architecture, not something
that is visible to resctrl fs. resctrl fs uses the event IDs and it is only when the
fs makes a request to the architecture that this translation comes into play.

With this change, what is the architecture specific "mon event config index" now
becomes part of resctrl fs used for something totally different from mon event
configuration.

I think we should separate this to make sure we distinguish between an architectural
translation and a resctrl fs translation, the array index is not the same as the architecture
specific "mov event config index".

How about we start with something simple that is defined by resctrl fs? for example:
#define MBM_EVENT_ARRAY_INDEX(_event) (_event  - 2)


> +	if (index == INVALID_CONFIG_INDEX)
> +		return -EINVAL;
> +
> +	if (rdtgroup_alloc_cntr(rdtgrp, index))
> +		return -EINVAL;
> +

hmmm ... so rdtgroup_alloc_cntr() returns 0 if the counter is assigned already, and
in this case the configuration is done again even if counter was already assigned.
Is this intended?

rdtgroup_assign_cntr() seems to be almost identical to rdtgroup_assign_update()
that has protection against the above from happening. It looks like these two
functions can be merged into one?

> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
> +					 rdtgrp->mon.cntr_id[index],

There currently seems to be a mismatch between functions needing to
access this ID directly as above in some cases while also needing to
use helpers like rdtgroup_alloc_cntr().

Also, as James indicated, resctrl_arch_assign_cntr() may fail on Arm
so this needs error checking even though the x86 implementation always
returns success.

> +					 rdtgrp->closid, true);
> +		set_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map);
> +	}
> +
> +	return 0;
> +}
> +
>   /* rdtgroup information files for one cache resource. */
>   static struct rftype res_common_files[] = {
>   	{

Reinette


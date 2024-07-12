Return-Path: <linux-kernel+bounces-251204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066293020C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DE81C218B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17A54757;
	Fri, 12 Jul 2024 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6QryL3J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7E1BDC3;
	Fri, 12 Jul 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822606; cv=fail; b=GYPTNFYOPsxqiGv0AhHupnmC5Jdz1ZPIvkc2/tBuudxiGFvmHX98fQYw7wzKlVI/h4T+31iLhKEJowKWyywNccKJywajH/04/0UUi7uFHL3vNTDHWq0DWZ1Ym+ixcUl3VS0mYCa0EsM6NSPjgurZgRtRXwUqkaPItimj5CYkL00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822606; c=relaxed/simple;
	bh=Vg643C8mwS2Jri6DLQ2Zy0gRjV7OKIy8+BnbXaKfNS4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=anTU56b4wF+ZlgoLINn8zSjHy0dgCdGfx7c4G8OASsta0RmB15gWQ6CX7wkWErgqhv2Y2zS00lKer2hg4ahUqCpqSJuMQCiXE1N8LQxaLaxMrr7qHSB4znLGH/HuO20TD27KRmf10T4syRuNXITeBCm5Rb/8fGDHyBfyaofMZyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6QryL3J; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822604; x=1752358604;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vg643C8mwS2Jri6DLQ2Zy0gRjV7OKIy8+BnbXaKfNS4=;
  b=a6QryL3JH72lN8rW4UuMAlPUhcuFEE6M3eRK4ysHwW0Nt6tp/YpclWWG
   qDoueS6oALunFBTe0rAtI4bg2KddAJxyIJMbcyJzjE7V/Pu10WVSNdWuV
   GlW8PRvk43FL8zIcCpwS6De5FVTkSMTlXq75PxQh5SiEUKfIVSpV5ApiJ
   vVZkBkNMbYNKwX3dfVfOMYkyCgkyPnOeJqAiAHcmQFIAtw+Ec/5XUpIx9
   82xTre+cf7458RJAYPuHErsDpKICj8g60zM4iFuWSvSzXF0eiQNQvW+zL
   2QeJ8/A/BB4gZKPxY9KA6uQwMNJ7VLDOvqNeqQq27bqAeChklFSLgVqI+
   A==;
X-CSE-ConnectionGUID: ZIEBuDfQRMu7O9sEokyB4A==
X-CSE-MsgGUID: CGjBL9h5Qb2hpeeMEAMjOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29430209"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="29430209"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:16:44 -0700
X-CSE-ConnectionGUID: m3ztO0PwS+CJ+Y9u6SNUfQ==
X-CSE-MsgGUID: mMF0Izl9TIGGA5SXYre99A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="48987175"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:16:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:16:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:16:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:16:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGEaaqdGZX623BhRntpSyrSlZ3wbAxkcdH11eg06PdA8NqKXQMXvQJ0JURU43vzYjo3rsxp4Q0XmpK5GzE47DT0OIKd/FS9hjOnKvc1wxgKyu2gbOzhNT09XhuePZCJixyb7jEfgmq6WIryvjWQ63bsE3pduRS7gZiB7llEhopw9VKyQCzJn7wHqkdQ2haWcTi7LY++1njEeXgI1woWOCxqWSBVXHm07Bul2TCA3XyJ+SvIFEjUudPVGNBQSBJWsbP8lgO45+RHCUefsiuZHfNLbYGXZl121Kox2YTHaxe6oywiMkpj3t0LPwCnOQLvmRQzKpFCub+c8HwHeDAogqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edXtCZLG2sWw0IR164E1NBnAB/9GYp7P9CBMylmyEAQ=;
 b=GM7Z7isxEvxGC1SV8UpqgwtKcDW/cpJRGXgb4QtYx5qpAO6JR6UF8F3cAiyPTnq4q5Ajmdt/r6B/eZ8ijP4Vayo06p2+5vjCsVc+Lm2Q2ksLBnlkXc05VzicErjH6OV2jT3cxmQnIGFFUoeDTsroKwVawBcisKaiBLvii9oKBVks49Fg7Z92ulpkwgZnPhnK0M2a8Pn9mvOedGnqwBPR5VxcGlkOMIMfRTGQSsRapciWvt8MArITyupU/bsX/4ZzjJgQgpZVaT2Eq7q0qcVEvO6SDghbD66O5SXyIs4TYa5hmBIg0wl0QltpfRN3Gm1iQLdjDxJFK3mYhUevNum5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 22:16:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:16:39 +0000
Message-ID: <710a83af-ed88-412f-8f7e-33678a8ed197@intel.com>
Date: Fri, 12 Jul 2024 15:16:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/20] x86/resctrl: Introduce interface to list monitor
 states of all the groups
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <3be66db2dbbe2d231fd5afbe6c7f092278b5a903.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3be66db2dbbe2d231fd5afbe6c7f092278b5a903.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0288.namprd04.prod.outlook.com
 (2603:10b6:303:89::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d91ae1f-60a5-4f96-a9fb-08dca2c04d17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTFKcVFoTzFFQXdQV2wvdk5tcUpoVWlHTkRqUW9FbWpxb2ZadE0rWEdlU3hH?=
 =?utf-8?B?bEg1NHg4Q2VXdGlxNnpGWWYxZS9QVEwwUktRVlhHSGdRa2x0YzVINFZLMVVv?=
 =?utf-8?B?MS9pK0pZWFc3bER4VjF3OE12TXhLZVFzU0dqMkF5Z1dCWWdTaG1hUitXa1lU?=
 =?utf-8?B?ekNqaklKaWtyMWNKZk9ETWtpT29wU3RuVDlHaWpVVjU1aTJ4bUxzaUlUaEtl?=
 =?utf-8?B?Zlg3ZlNnTk4yY2htck1xcy91bG9EakJWdWQwcjVnZGVkYklWUjA2Y3BKOENw?=
 =?utf-8?B?Z1ZBYitZM1JvWnVYb3lSNVI5OGQreHAxbzU3SG9HMXNrZC96d3dFeXNHNUgx?=
 =?utf-8?B?MXJQanlHQTFicDg1UXFXUEdic2hSUnRJUGNQd2lYdEJjaStaUTlvWmN3aDVq?=
 =?utf-8?B?MVZEZ1MveW9Sbzd3NjQzYlpteGNGRGRzUFk2T2x2MkI4UThsRzlQUmUzakJS?=
 =?utf-8?B?MGtSbVVneVl4dFV1QWI5cm1SKzZiVk5tM3QzQkpGcStLRHRqSnd1Y25helhE?=
 =?utf-8?B?YkdQclFteVNaSmhmZHRZV1BrQjI5MTI5dmpsVVIvdllJb3R3Qkh4UEJodUJW?=
 =?utf-8?B?MjUzVDFMTytVUG9MS2lOd0VsNDduVytsbDhINHBSRG9nVVpadGVJNit6T1RP?=
 =?utf-8?B?NWJ1T00xU2pHVEFLYW9HSkV3MFNSbFFGeUZLZk96TTZnMEtDZlBTTkd6VXVT?=
 =?utf-8?B?cXBVWDhBSXAwc1JrNlc4Y1JDYnp3SEhMWm0wa3ZHbENoTjBxZTc1Rk95ckY2?=
 =?utf-8?B?cTh5MXpQM3lySTNmL1FiSDVTd29PcVBQZDE2cE83RVV2cmlKS1FyT284OGJE?=
 =?utf-8?B?WW5FRU9zT2t3YVpZTVlpdUQrUUpaZDhUaUVRSSsxOVBLOHZ0YkRxTjBSTmo5?=
 =?utf-8?B?SG81aVRaSVFaZ0JrYU52eDNFT05IYWJLbG9kOFp6TmZkVXJMSHkzaWtiQThR?=
 =?utf-8?B?NkJ5ZXd2RUFHWWhXVk50SHB6OVFEa2E4aUpmR1pvVFkrRmFsanJkRDNIZ1V2?=
 =?utf-8?B?MVM2cVZTQWxzUGZCbFRhQWxoTlFiWURYSzFXZDVaOUFsUjRBc01La1ZudDZF?=
 =?utf-8?B?UTRjL2lFTjNMU25jbktEaGFYQnljL3U4SDM0aUtqNURiSy9pMitWTzVFSHdD?=
 =?utf-8?B?UFlXTXRHVGJvYnhtNzNTTWJOL2kwbjVrZGNpbHRoYUFLTjJvRkJaTlo4VVBI?=
 =?utf-8?B?ZVlaQ0RwUnVpSlJIUzZRQjU1VDVMWXcyNDhKMkpWS3lDYXNuSkltRDVIRnND?=
 =?utf-8?B?M0pheUVTZy9EbmlpOTBpSGNVTlZ5RFpIMEF3dDJ3ZkY1enVuZmI3eis0bDYw?=
 =?utf-8?B?SnJuaVdEZ200VjJXV2EyYnJhaXp1eWF6ZWdvTWtTRGdxT0w5OGFGN0NBd1JB?=
 =?utf-8?B?M0ZQZjVtTEdlTWJwN3l0RUVaWStFWHdzNFozQlJyMnk5ZE1HRmlUWHdYQ2tK?=
 =?utf-8?B?NlhydGtYMkNmVzE5TGtYM3dXS0VObjY1Um5saDg0WXVOMXhoUG1LSTE4Y3l3?=
 =?utf-8?B?RzVLT1B1NUpOZTVYTDhOcXcybFJ1MUUyd1BtcVVYOTdwV2VtKzVBb3JIN1JB?=
 =?utf-8?B?a2RMRjJSU01uNFluR0JHOTVsVkllRkZkekU2NkVSMjM4U0c0RHh1VFRmVTc3?=
 =?utf-8?B?OGhQWExDY1JQLzJEMzM0VVNSRktmcUs1bjBVZm51eFp4YkE4UytzWG51NHFN?=
 =?utf-8?B?cC9PeDZ6a3Z4TGEzN3VZRUdJV1ZXOERTL1JnZFVKVnVMeDRJR3cwNzFoMW41?=
 =?utf-8?Q?I7WzzJvM79vNyVr3ao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0ZxbkFFR003aXpMR2dTazNrcEtiRGZ1TlQ5ZHMvNlZuVk94V1hzZkx3ZDVH?=
 =?utf-8?B?U0FHOHRzRlRtVGJ0M01uVExkZUh2K004cDlHTG5sWHQxNEptaitQcVJuNjBF?=
 =?utf-8?B?ZWcwNXdIdVJoKzFXekxFVWZ5SEVSTWdYOGtkbEx3MGJIZXlNWkV6RW1teFhk?=
 =?utf-8?B?RW9TdDBPTU1FS3JlVUZGNHc2UHozWFpNaE9sQmpBTC9MTkRaK2w5Z1lsSy9X?=
 =?utf-8?B?ZjNGenJPcVV4Qm5qbkFHd2hXZ0l2cEV6NFh5YkdNZzNEcUJWaHFOOXRSbTNv?=
 =?utf-8?B?b1JtN1Z5M1k5VGFwbEtvaU5TZkhoc2dLbUd5RW81cEt1VlhEUGpwTU9MT3lX?=
 =?utf-8?B?MElIQVJwRHpHbjBpR053b0xSQjN0YngxY2puY09ML1JzU1hIRDRza003MUpz?=
 =?utf-8?B?WGxjdnZCbkQ1ekJpWmNhRFB3N3JMZ05wM2VNZW1kVFhVTHkwL3U3VUo1dVRC?=
 =?utf-8?B?Y3pMdy9JZUIxVEpnNkxBcWx3bVJ5aGVhTDZXL05LK2ZpVkRveUNyNWgvdUNh?=
 =?utf-8?B?UkZzSk1lVjBQZUlsbk11K3NsMkNDK3NIQUxRYlpab3RLakZET0g4MndGMGc2?=
 =?utf-8?B?WTR0aGFWaDhRbnJ6ckRnSVNteXJWdWc2bWkxY1pveUk3ZHhmbFd1OHBKVlh3?=
 =?utf-8?B?RGNNbGg1VTZPNGM2MFA3ZjloS1FVVXkvV3N3ekRvTG0rQ3NuaUE4Slp2Wi9q?=
 =?utf-8?B?OC9HenFMck5zN1M4RHVhZXg0L0w2ZWZxdVh6QVNBR2dUNVJFWFdJMHlic3Iz?=
 =?utf-8?B?bWs2ZmZNK3o2cFpuSERrTmFCd0NEaGQweVl4a29rckhwNmtjMUN4cHh0b2Ni?=
 =?utf-8?B?Y1kyL3BmZkRQcVMycTBLOU45bmlyc2VPSDlrNUZzMy95ZkJIcGhxMTNiV3Fp?=
 =?utf-8?B?Q1R2ZUNxSTY0aXY5ZSsxVDMxeE0wd1Y0TnEzb0EyTHRXdjV5ajdzR0FqNHBx?=
 =?utf-8?B?bjVIK2JTNHR0WTBaSXMwbWtMeHR3VFlabmNFY2ZuYVZuQ3hCQlVwSXEvbm5z?=
 =?utf-8?B?UWlGR2U3bXQxVStZQVJkTWcrMXpZSnhUUzVYVVVpL2piNE14NXNNamlGbVlx?=
 =?utf-8?B?NGRWL2pyRFBYQnA1OVRnNTc4S3FUTXlRYWFUOTVoMlB4aVVIQXBMd2lsTFFQ?=
 =?utf-8?B?bU41OGpyVUxzbitXM0VpM2RZQkpFOFFZTkFEQ0JVOThsSU1aRTZtODNUYkwv?=
 =?utf-8?B?VDVFTXg5dC9pV0JBRmM5MXRJTmNkWk0yaWhwWnJiYTY5Y1c0djdSQ3RQL25s?=
 =?utf-8?B?K212cXZDUCt1eGpvMUJORTJYckJqTXRvUU00WjgzR1AzcjRCMmN3aU5xYUdr?=
 =?utf-8?B?MExPOStnOGVMWlFFeTVxN05ON0VEUFpnb2k5UTNuWlQ3SUZqbFZicGpjSEVl?=
 =?utf-8?B?ckxUc1dJK0lYV2kwVlA4bWJhRGo2VFBoN0ZZNUx4RGh5YkxvMU9pdC9DTVZR?=
 =?utf-8?B?T20reEp5UGc1WW9yT3Q2MU1DbmFuQjQxYkRuWHFtTEVwdGVlRTViNjN1S0o2?=
 =?utf-8?B?d1ZNTFV5WTc5bDZjZm1YRkJJK3hRVkdONHJWZFNuMU5sbUh6M2pMdzBQUjA4?=
 =?utf-8?B?L0dxRXVGRk54SnVpektjWTlNdEtZdXFpMERBR3M0RkVBRGV4UGw4cjU3R1Bv?=
 =?utf-8?B?dVdjRExuOVUvZEVjblRWWmsvdE4yOG53RytaeW9hK2RnUGkvZklzRGJKYWpT?=
 =?utf-8?B?V2RPYlhVazR0T3p6UG84eTc2ZFRjVGZCTGxaSFlKVldIamxOZ0JFcmlWa0po?=
 =?utf-8?B?REZEa2ZWVjRma1lFYTFmNkU5WHRLU0NkZDZEWWFrcW1sNlQ5UnZVTGUvczF3?=
 =?utf-8?B?dE5RUGVQL2xXUG5zS1ZCNGZSNTBZYUFiOTdsOTJjcXBXcWJKY0pMRWJWTDhE?=
 =?utf-8?B?Rzc2UFUwc3UrelJSRWVJcTdVZFRZV3hvTVN0RC9mazdzNzUzUTJUbjAvUUZ1?=
 =?utf-8?B?bmhWajduQ0VMbDVoVUVsQWVGM1MwZXN1ajE3SEdvVnNDZDlnZWQ4ZXJnd1pm?=
 =?utf-8?B?bk1sRCs0akppdzcxdEZVSk4xRzBFV0V1SlkzSUhFR29UclFMc2dScGxJWXhs?=
 =?utf-8?B?OGpjVXY3anBkbmh4QjczNmdpa1EvcUpJZnhZR2N6YVVWcVFLT2FabEdkcDVU?=
 =?utf-8?B?S1lwaHBiUW1IWjBEVVBKRTRrQkVlMDF4eXRpcUUzeXUrM2hKZEF1TkZBTmVU?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d91ae1f-60a5-4f96-a9fb-08dca2c04d17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:16:39.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJG7ff6IUGfHaY5KmBWlNEKQnaXLke/PCzNirQtIycIBLXQciHBjpfwmdLsSuqpRQw0LsffWgvo1rj0/0mLWWrZR4erylIpfMfHi/SQREZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> Provide the interface to list the monitor states of all the resctrl
> groups in ABMC mode.
> 
> Example:
> $cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> List follows the following format:
> 
> "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> Format for specific type of groups:
> 
> - Default CTRL_MON group:
>    "//<domain_id>=<flags>"
> 
> - Non-default CTRL_MON group:
>    "<CTRL_MON group>//<domain_id>=<flags>"
> 
> - Child MON group of default CTRL_MON group:
>    "/<MON group>/<domain_id>=<flags>"
> 
> - Child MON group of non-default CTRL_MON group:
>    "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> 
> Flags can be one of the following:
> t  MBM total event is enabled
> l  MBM local event is enabled
> tl Both total and local MBM events are enabled
> _  None of the MBM events are enabled
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5: Replaced "assignment flags" with "flags".
>      Changes related to mon structure.
>      Changes related renaming the interface from mbm_assign_control to
>      mbm_control.
> 
> v4: Added functionality to query domain specific assigment in.
>      rdtgroup_abmc_dom_state().
> 
> v3: New patch.
>      Addresses the feedback to provide the global assignment interface.
>      https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
> ---
>   Documentation/arch/x86/resctrl.rst     |  54 ++++++++++
>   arch/x86/kernel/cpu/resctrl/monitor.c  |   1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 130 +++++++++++++++++++++++++
>   3 files changed, 185 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 4c41c5622627..05fee779e109 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -304,6 +304,60 @@ with the following files:
>   "num_mbm_cntrs":
>   	The number of monitoring counters available for assignment.
>   
> +"mbm_control":
> +	Available when ABMC features are supported.

"Available when ABMC features are supported." can be dropped

> +	Reports the resctrl group and monitor status of each group.
> +
> +	List follows the following format:
> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> +
> +	Format for specific type of grpups:

grpups -> groups

> +
> +	* Default CTRL_MON group:
> +		"//<domain_id>=<flags>"
> +
> +	* Non-default CTRL_MON group:
> +		"<CTRL_MON group>//<domain_id>=<flags>"
> +
> +	* Child MON group of default CTRL_MON group:
> +		"/<MON group>/<domain_id>=<flags>"
> +
> +	* Child MON group of non-default CTRL_MON group:
> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> +
> +	Flags can be one of the following:
> +	::
> +
> +	 t  MBM total event is enabled.
> +	 l  MBM local event is enabled.
> +	 tl Both total and local MBM events are enabled.
> +	 _  None of the MBM events are enabled.
> +
> +	Examples:
> +	::
> +
> +	 # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
> +
> +	 # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	 non_default_ctrl_mon_grp//0=tl;1=tl;
> +	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	 //0=tl;1=tl;
> +	 /child_default_mon_grp/0=tl;1=tl;
> +
> +	 There are four resctrl groups. All the groups have total and local events are
> +	 enabled on domain 0 and 1.

"All the groups have total and local events are enabled" -> "All the groups have total and local events enabled"?

> +

The text below seems to repeat ealier description.

> +	 non_default_ctrl_mon_grp// - This is a non-default CTRL_MON group.
> +
> +	 non_default_ctrl_mon_grp/child_non_default_mon_grp/ - This is a child monitor
> +	 group of non-default CTRL_MON group.
> +
> +	 // - This is a default CTRL_MON group.
> +
> +	 /child_default_mon_grp/ - This is a child monitor group of default CTRL_MON group.
> +
>   "max_threshold_occupancy":
>   		Read/write file provides the largest value (in
>   		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index b96b0a8bd7d3..684730f1a72d 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1244,6 +1244,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   				r->mon.num_mbm_cntrs = 64;
>   
>   			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
> +			resctrl_file_fflags_init("mbm_control", RFTYPE_MON_INFO);

Shouldn't this file always be present?

>   		}
>   	}
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d978668c8865..0de9f23d5389 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -944,6 +944,130 @@ static ssize_t rdtgroup_mbm_mode_write(struct kernfs_open_file *of,
>   	return ret ?: nbytes;
>   }
>   
> +static void rdtgroup_abmc_dom_cfg(void *info)
> +{
> +	u64 *msrval = info;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
> +	rdmsrl(MSR_IA32_L3_QOS_ABMC_DSC, *msrval);
> +}
> +
> +/*
> + * Writing the counter id with CfgEn=0 on L3_QOS_ABMC_CFG and reading
> + * L3_QOS_ABMC_DSC back will return configuration of the counter
> + * specified.

Can this be expanded to explain what the return values mean?

> + */
> +static int rdtgroup_abmc_dom_state(struct rdt_mon_domain *d, u32 cntr_id,
> +				   u32 rmid)
> +{
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +
> +	abmc_cfg.split.cfg_en = 0;
> +	abmc_cfg.split.cntr_id = cntr_id;
> +
> +	smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_dom_cfg,
> +			      &abmc_cfg, 1);
> +
> +	if (abmc_cfg.split.cntr_en && abmc_cfg.split.bw_src == rmid)
> +		return 0;
> +	else
> +		return -1;
> +}
> +
> +static char *rdtgroup_mon_state_to_str(struct rdtgroup *rdtgrp,
> +				       struct rdt_mon_domain *d, char *str)
> +{
> +	char *tmp = str;
> +	int dom_state = ASSIGN_NONE;

reverse fir

> +
> +	/*
> +	 * Query the monitor state for the domain.
> +	 * Index 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
> +	 * Index 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID

Why not use the helper?

> +	 */
> +	if (rdtgrp->mon.cntr_id[0] != MON_CNTR_UNSET)
> +		if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[0], rdtgrp->mon.rmid))
> +			dom_state |= ASSIGN_TOTAL;
> +
> +	if (rdtgrp->mon.cntr_id[1] != MON_CNTR_UNSET)
> +		if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[1], rdtgrp->mon.rmid))
> +			dom_state |= ASSIGN_LOCAL;
> +
> +	switch (dom_state) {
> +	case ASSIGN_NONE:
> +		*tmp++ = '_';
> +		break;
> +	case (ASSIGN_TOTAL | ASSIGN_LOCAL):
> +		*tmp++ = 't';
> +		*tmp++ = 'l';
> +		break;
> +	case ASSIGN_TOTAL:
> +		*tmp++ = 't';
> +		break;
> +	case ASSIGN_LOCAL:
> +		*tmp++ = 'l';
> +		break;
> +	default:
> +		break;
> +	}

This switch statement does not scale. Adding new flags will be painful. Can flags not
just incrementally be printed as learned from hardware with "_" printed as last resort?
This would elimininate need for these "ASSIGN" flags.

> +
> +	*tmp = '\0';
> +	return str;
> +}
> +
> +static int rdtgroup_mbm_control_show(struct kernfs_open_file *of,
> +				     struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	struct rdt_mon_domain *dom;
> +	struct rdtgroup *rdtg;
> +	int grp_default = 0;
> +	char str[10];
> +
> +	if (!hw_res->abmc_enabled) {
> +		rdt_last_cmd_puts("ABMC feature is not enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +		struct rdtgroup *crg;
> +
> +		if (rdtg == &rdtgroup_default) {
> +			grp_default = 1;
> +			seq_puts(s, "//");
> +		} else {
> +			grp_default = 0;
> +			seq_printf(s, "%s//", rdtg->kn->name);
> +		}

Isn't the default resource group's name already empty string? That should
eliminate the need for this special handling, no?

> +
> +		list_for_each_entry(dom, &r->mon_domains, hdr.list)
> +			seq_printf(s, "%d=%s;", dom->hdr.id,
> +				   rdtgroup_mon_state_to_str(rdtg, dom, str));
> +		seq_putc(s, '\n');
> +
> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +				    mon.crdtgrp_list) {
> +			if (grp_default)
> +				seq_printf(s, "/%s/", crg->kn->name);
> +			else
> +				seq_printf(s, "%s/%s/", rdtg->kn->name,
> +					   crg->kn->name);
> +

Same here .... with default group having name of empty string it can just be
printed directly, no?

> +			list_for_each_entry(dom, &r->mon_domains, hdr.list)
> +				seq_printf(s, "%d=%s;", dom->hdr.id,
> +					   rdtgroup_mon_state_to_str(crg, dom, str));
> +			seq_putc(s, '\n');
> +		}
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -2156,6 +2280,12 @@ static struct rftype res_common_files[] = {
>   		.kf_ops		= &rdtgroup_kf_single_ops,
>   		.seq_show	= rdtgroup_num_mbm_cntrs_show,
>   	},
> +	{
> +		.name		= "mbm_control",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_mbm_control_show,
> +	},
>   	{
>   		.name		= "cpus_list",
>   		.mode		= 0644,

Reinette


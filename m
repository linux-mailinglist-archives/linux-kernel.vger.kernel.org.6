Return-Path: <linux-kernel+bounces-423737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B629DAC08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D58282C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E176200BB0;
	Wed, 27 Nov 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuyxVe4B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093041428E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726095; cv=fail; b=IjPNbECXYpGmntlUQYbNxPvqmYi0XJ73EZLLwokhAHYBdove3XyTkTqwv1IbPTnpGsQR6t0YAIugDlaDvM1M5l5xhLqE2Dy/QDENgJ//ug/lgO57Qe1wWrEJYSjGu8tPFb/PpFNEgyRJjJGTyxLrlkATE3u6inaH/Ch7uJ0Ehg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726095; c=relaxed/simple;
	bh=gQl0XRAdth6EFmNSVFBRK9rMUVFS6E7iiJ33/Wrei1M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e4gLq0B7ZcNPhVz0pSKYhjhlOUfUUn9EhUnArnyhuN59pIcgDYKhGRl+XWH/VJmfN4aWrgslI40l5tprGG9FBHgfPzMbWC/MBByO7T3U3eSUrW+GG0KuRlDQp5bxEPcD2QNPqIaQr5rClr5x96mb0DFoQY4eRpcFp2/Cx+HmYxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuyxVe4B; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732726095; x=1764262095;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=gQl0XRAdth6EFmNSVFBRK9rMUVFS6E7iiJ33/Wrei1M=;
  b=DuyxVe4BVuPcf5m49EB28ZRXyZIZQLjAPe2LD7poIzib2J17HlhWdFtq
   Sj9ulOOX13oNZts2NRV3jbb7EI/kIiVKfChJa1QJs9fyuUwLaooS2o8fs
   s4HtP0WCKxvwlgsDiVOnGf1nLSJnKYLKh07WJ1vtM11Fy+qr5hg/D7+1o
   sp+5e6sFSf58244Wm0cYtVrbLg6O295/1qp7N8e49mUflTaYw3UiAOqOO
   +SlK+qs0xGb597rNTFAfq7t/bA0eGOwxqtTRr4GGCb7Y22NOhNpPKGPNe
   AgjzDrPIJkH9/ujirUuheC3dvYi7lYLWYsJ5jQqhUBHu/ruR+eR37hNJx
   Q==;
X-CSE-ConnectionGUID: aDRTRl0USyCFit25DPmDXA==
X-CSE-MsgGUID: Q4r7IdQ1T5OnP2upW+yFFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="44002300"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="44002300"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:48:14 -0800
X-CSE-ConnectionGUID: 9d0rKszLQpSJvFcn9J6Rpg==
X-CSE-MsgGUID: /KdsUQF/RE2ksBCAPwXWlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="91618015"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 08:48:13 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 08:48:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 08:48:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 08:48:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kh1GEBYx9ZZAQN9FHC37fujIKr/jX679mOBUiuQGMSwuzCuzxXokAbOxVfg2ARhVtk07v9VG1yTtrRL73xTSv5rGMmHDRGrwPeHYzzUm7qp9185qcrk0g2XY9ioI3hKew4H/QgXq+4bUmIRJxaJZ4fsBmStSsjPTvD0R2XLSmALSrW1qyGLqXAnFBvvn1Tifsq3DjudYrDZrb1/3AbeWqquYMcRuzI7QbQV/HuVl7BGSWtUBdWeZxXGXkS9yz+qCvelrJMKsRo7wpCnIPjZoDVYvGvbF5hhXJbtvD2xyj35BFIM0Rlfi1dhtLJiEYd/HvFhZgoupO6MMmm1l3FsrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQl0XRAdth6EFmNSVFBRK9rMUVFS6E7iiJ33/Wrei1M=;
 b=ZIBBu1xiMwifsf4Yq5vhRn6DdhSUQJ7rkR3GuzjjyZ58CzvB/hWcTl7BNm5KtoPNRzaMVrjDw7uh2D0hqkdERs2i5sVdSthzA3clphfpuU62rk47JD02BoxUGsafszh9JT4/igVxv1IjW2pdJhyRi6viqTnM2N2XIqHAHlT3+UmH5L8migEkSa3HmaSNmEzVTnILeEVp3MGbsC/dAk3HCVzzj2mNxGILKRlG47ClHObPPa87bl7CyGobowhhrhrCEG6AvCFU3qrVKrjysZKYRCs0KxClAecvFk7JsaLpPkvrM6Es8vdKcmbkuYnVdZvMIVRcbZSwDwaijx74ZGWlJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB5114.namprd11.prod.outlook.com (2603:10b6:806:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 16:48:09 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 16:48:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Li, Rongqing"
	<lirongqing@baidu.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH][v4] virt: tdx-guest: Don't free decrypted memory
Thread-Topic: [PATCH][v4] virt: tdx-guest: Don't free decrypted memory
Thread-Index: AQHawjpiYTlNCyETo0aBg6z1bqykdLLMU8+A
Date: Wed, 27 Nov 2024 16:48:09 +0000
Message-ID: <63a3e464f368b6103c637af384eb0b069eac3158.camel@intel.com>
References: <20240619111801.25630-1-lirongqing@baidu.com>
In-Reply-To: <20240619111801.25630-1-lirongqing@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB5114:EE_
x-ms-office365-filtering-correlation-id: f35910a9-fec5-4cef-b47c-08dd0f03466f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVV1eTVuT1NuTVoxMy9US2tFN3JiQVNHSHVOMS9mMHdwc3hwMFF0RmliZE1O?=
 =?utf-8?B?R2grbUVlMWtDZzltY2VBdVorRU1DajlZOW93SVB5QVU4K1FNY3JBbmlqUGlS?=
 =?utf-8?B?NVEzRnJTZ2IyWVo3NGF2VXZ4T1ZONEhVSlFNeVJnRHJFUUtwMW5LaEpudStQ?=
 =?utf-8?B?UllzUFd3WGNLVFRxUHpBa0JwbWY4T05GS21OejVJTjlpWUxaaUtJOGNsYmgz?=
 =?utf-8?B?anVWL2lzZlBHVlJqMWd4ZTlwZWRVUENxc3BsMVFZTWNFWDlaZzVIUVhzd1ZT?=
 =?utf-8?B?RExYZXNlcUlLMXRoN2pxb01KZ1NYL0tPT1BsOVZoeHIraDZBWDdtVTZCZCtR?=
 =?utf-8?B?RHZnMmtjVThGRmN5cW9kaWRKNzhhVzZzd0xQNVpwOUlWOFVNM1NYNkVNNzFm?=
 =?utf-8?B?Yi9pWHUzV0tLcHBtNmRYWWFGZndSZ2R6NDdwZHgyNnZNY3VkRDVHS0Y2Y1J2?=
 =?utf-8?B?dDE5N2RSLzYwQWtJaTBpdG5Ja2p5cENIQmtnWlJPS2lOWERlaitNZHNrbjZi?=
 =?utf-8?B?MndNYTFUQW9tWHlWWnhpYmU5UUgrMkV4QXpvTXRNaVhWK1F4SXlWODNkdzJJ?=
 =?utf-8?B?aktvR1BpaDQ1N3B2NXg4S2kzdkRLeW1IQ1B5UGFoYkJzNUpVUzMwTFk4OUhh?=
 =?utf-8?B?dEpZVjkxQWhndklWWjVMLzl6bUFsUDUwNHhnZndJNGhWQjR3L1Fka0NUT1Za?=
 =?utf-8?B?MjgzcVU3bkk4UHdGS0ZxRGQ5TjJXV0RuMjc1Yjhrb1RHaTdtK25DcEw0ZE9F?=
 =?utf-8?B?TWJIcHBJUGR0dnZrRzN0T2RLSXUwdWRNWW5nY3doNTJRT05jU0FkQVlPUmZi?=
 =?utf-8?B?Q0tVbU12UFc0Vm5UblVIQXJFdm5aVFZZY0dDcWpKRXpoWWxQRERRWkxuNk50?=
 =?utf-8?B?anhvOWVNbnYwOHNhSDlmamRDMmc4STN1aFRWUGR6YWdlR1E4VGtKUmZGOXhV?=
 =?utf-8?B?dEU0VCsxODJ5NTRKVTlPREhJL09BdHJCa1VKeUJsVkRYdmJTVEs5T0hVY1dO?=
 =?utf-8?B?N3B5d3BtRnhpWGwvS3FqWGFMbEdkeTNzTDJIYTlKVFdKWnlScnhGWmNiZktP?=
 =?utf-8?B?YjZ3enlIcXNRWHBzemJXNmw0U1djbVRpR0VtVG1jTUxiMzhCYUtRMkJDVHRC?=
 =?utf-8?B?bzQ0QjJlNWxLT3ZSWXVlc1N3ejRib2tDWmZIejdmSmR5MVBBMW1LVWtNNlNm?=
 =?utf-8?B?cDZlSSt4Y21SbUx6RDRRRHE1T1pCakowMElLRVd5OUN3WEFzZ296WU4rYVFV?=
 =?utf-8?B?T1BjajFyWUpxWElPZ2Y3Ri9GMXdxejFuVHdrcGREMFVPa3lhdlVQR3hhaHpz?=
 =?utf-8?B?QURsNDdyQlFzS2k3S2tSdndva2tpVHEvcWN6NjJZbkN2NmhRY05IaFEyOHlh?=
 =?utf-8?B?REs2SG1WRHVyKzBFcGhWZk5Cem5UaTBpdWY4WnlPc1pkaERDR1dpOUw0aEky?=
 =?utf-8?B?MHNUSElMdDJXY3l1T1pyd3RORmlUTFVHeUxSUXFmWjZ2ajNqZytEZUxqcGJs?=
 =?utf-8?B?Z0hXdE5pSStrdGd0UjVXcU03N0Y5cWZXYUtDbGFOWUNJbUY4Q2pqWGlCcnNV?=
 =?utf-8?B?QXlPa0xUbEd3WWZnMGJiRFBRZW55N1F5MGhsbDA4bk5DVCtzdnBUT0d6cmUy?=
 =?utf-8?B?SWpEUGdROElDRHFJcE5SK05oUEhZUHE3L3FSVEMxMkh0UDNVM0czZFVFM2xz?=
 =?utf-8?B?REduNVZScDZDMTJCK1hBTGRRNDhoQWtCM2ZTWit3bElPTEZPWUduektOYy96?=
 =?utf-8?B?N0dEME9ZYjJicFoxNjVvOGg3dE9kV29FbUVLcEE4emNFZHM1OUtkUHVmaGx3?=
 =?utf-8?B?aHFKemx1WDdUTU8yenNZTzB0QngxYTloS08yeHllVkZaTFZwWFBoWm9uenAw?=
 =?utf-8?B?K01YOVU2NnlGbWdCang3djBVNXZTdGdmQTd1TUVRS3E3SUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0ptOW84ZDZNMDNvY0tZZXV0NkJXc0tSU1hHWXdoRFkweSs4UlZ1STd0OGFT?=
 =?utf-8?B?cTV4TURWSzVlbElQSktFa3A3SW1KYXhoRXA3RGc2Q1ZTaERTdHh0alVoSXdE?=
 =?utf-8?B?TytQOGpZb3JpZFg2Vkw4bXd2eWd4SFBzR0dOamFYZlpyMWlDUnQ4V2ozY3Fw?=
 =?utf-8?B?eTV3RGxwQzRDV3dJQWtRcFJzSW1nUjJKV29sendCa2UvZWN6dmhEbXEwanNu?=
 =?utf-8?B?cDF4a01qa2hzalJRL2Q0WFBPb3c4TExVOFU4SlY3ejJsQkh4bWN6YTJESmZs?=
 =?utf-8?B?b0JIeHM0NVk4VUdIb2YzQ0dDUExFSC9SR2R3Q1hiTFRtTUVUazhVaFQ4YXIy?=
 =?utf-8?B?U01NY2tkdkU0NHJUelRzUTJ2MTBvSzNPYjhHNHhLZ3JzUjBsekEwZC8zZmlG?=
 =?utf-8?B?Y2Y1SUxLWlBURGJlcDNMK0NNMEljRkRvMzNZSi85Y01WdEswbFE4dE94eDFH?=
 =?utf-8?B?c3EvRjBqYTI1UUxKR1pHRTEzWUVCSm5MYmRDRWFHWktVMDNYbElNYkFoN0N3?=
 =?utf-8?B?SDlaSjFGcXFvZHdOSDBsUUVEeU1hdmkzZjYvdXJJVm1BTkV1U1NmVjBvMlBx?=
 =?utf-8?B?aFhxMHgxWUtqZWhVUGR5UjRIRSsvUzU1RXYwTWlIQThMQTdpRHJjd3BMWGNI?=
 =?utf-8?B?aFZQS3RCU0NINE02dnRtYjFRdGIvS0pmQUgvaDBRZTNkZzZEZkxxUmxnK01D?=
 =?utf-8?B?b3YxNU5kSFpkUURJZE9JY1RRcXltcGoyT3ZqQ014RGd4NVFLWlhYT2NTMzFw?=
 =?utf-8?B?WkozbTFYT09tSXJacWtDT1l1UmcxWnBvKzA3Tnp2djhzZXFtbVh4ZVQzcUNR?=
 =?utf-8?B?dER4TVFPa1JyUHBneUI2K3pSdnA4elhPZ1pUOUowNkFDc0pKUkl1Qk1qalcv?=
 =?utf-8?B?S2hGY3RZWUZpY3JKdnFLSDZQQTN2SUp0YmZ4NEd0eHRmQWpGR091RWswZVJB?=
 =?utf-8?B?L3ZKUk9IRVNoNEVnbXVpcHFTVkxXb0RWV002KzVxNEJxU3NOUkEwTGthUWli?=
 =?utf-8?B?clNCSjVuZGFvOSs3elRBMUwwU3NMQ0h1eE44VnBCeGovdHYvUVhMOVY1RW9K?=
 =?utf-8?B?aXpIc3pQVllVOTZ3UVNXdnFnRHFyYURaVmNFeDh3WnNqWWx1ZTdaNERsU29N?=
 =?utf-8?B?MGhBRzdGUG9rV1N2djFiMW9jYUlkOTlMeUhjbWFLME1GSy8rVisyQW5sbHlr?=
 =?utf-8?B?a3lvcUlpK2JKdlJHNTFDREZkNnpVcG9tUjlhTmpBRXZvVGZnMXoxa0M1UVI3?=
 =?utf-8?B?dFh4NHRnRTBLVG5wMEc1aWtOWktlWlN6c0lNYmhtYW96bEtvcS9pOTBNZ256?=
 =?utf-8?B?S2RUR2U3cnVrZWI5cjlqNHlMSVg0TUpYZGFvVDcrVUhicGlXeStEcHZpRGY4?=
 =?utf-8?B?ck96WGFIZkdRVzdSeEMrZkNvNWNGbE9NczFyVEl2VXFrQS9tZzY5WHlSSGs3?=
 =?utf-8?B?aHNGenFSZHUxbElBNEdJT3ZQUXJJYzhGM1JtYVNDZHNZYTZTd2VvU05FT2xI?=
 =?utf-8?B?NXJPdFdkcU16dmMyRCtnY0lCdU9ZUjlrVGZrWDBQYll5TXp3OGlqb0h2Q2k3?=
 =?utf-8?B?Vk94R01pZ29qYWs2ZVI2R2UzSTUxT1JWRWc4dFh2VlRuZ0ZtMWtiSW82R0Zx?=
 =?utf-8?B?UHNSdmdYRXdoTHkyVllXNnphSW93dWp6eHRranEwblNXdHdGVS9TM2Z5Y0tr?=
 =?utf-8?B?TFZvN1ZNRHBLc3V3T0xIWTY4Wm9CVHRhalVoZzFKaThkMGdzaGZNeGhmdkJp?=
 =?utf-8?B?UG91TFdneVVWaS9pWnA1UkhVTXJhTVA1TlBCRFhPR1VpUzFPNXdjWncxMXB0?=
 =?utf-8?B?Vno1ZnY2U2QxSi84b2RVa3FGQWVOajdsdjV3Q1loQjRxSzVMaURlZjVBbGs2?=
 =?utf-8?B?WDNKNW9QbDlyem9tSXpGYk1iYUtpVVhOUDMzemlXVmJ2T001VkZOeHdYMENR?=
 =?utf-8?B?NHBPSDNaemgyTVhvWVVYVlIwcEJvTVE2bGdUNllpMFQraExsYlg4cE1SRnBT?=
 =?utf-8?B?aVdCN1JmdXFpS3ZxYjE1VS9Wcmhxekh0WkU2cnp2TFNHY1BFUVFoSUFPdURy?=
 =?utf-8?B?UHF1ZVNkTGNDd2tNanNOaWNZVVVDTDVLbnhDakQxRW5Ub1lmOEp3UFJId1Zq?=
 =?utf-8?B?TkIycmJuT0dYYUFzQjF3ZkttQ3ZZRmtxT01JZ2JaMXBObEpzVWNMeWxtTlZn?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <991DFA0A08C6D64F8AC5F0105E81951A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35910a9-fec5-4cef-b47c-08dd0f03466f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 16:48:09.7253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gj0VycxNHJcdrPteZxbM+n8n0jlSapoEmL1F7Pm4AqmeU+gBhwhObIF+4FwfEeCkRtt5yipaJScJzyPZvUvKZLB+mw0D/jrd5Ktv5Hx5JhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5114
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDE5OjE4ICswODAwLCBMaSBSb25nUWluZyB3cm90ZToNCj4g
SW4gQ29DbyBWTXMgaXQgaXMgcG9zc2libGUgZm9yIHRoZSB1bnRydXN0ZWQgaG9zdCB0byBjYXVz
ZQ0KPiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHRvIGZhaWwgc3VjaCB0aGF0IGFuIGVycm9yIGlz
IHJldHVybmVkDQo+IGFuZCB0aGUgcmVzdWx0aW5nIG1lbW9yeSBpcyBzaGFyZWQuIENhbGxlcnMg
bmVlZCB0byB0YWtlIGNhcmUNCj4gdG8gaGFuZGxlIHRoZXNlIGVycm9ycyB0byBhdm9pZCByZXR1
cm5pbmcgZGVjcnlwdGVkIChzaGFyZWQpDQo+IG1lbW9yeSB0byB0aGUgcGFnZSBhbGxvY2F0b3Is
IHdoaWNoIGNvdWxkIGxlYWQgdG8gZnVuY3Rpb25hbA0KPiBvciBzZWN1cml0eSBpc3N1ZXMuDQo+
IA0KPiBMZWFrIHRoZSBkZWNyeXB0ZWQgbWVtb3J5IHdoZW4gc2V0X21lbW9yeV9kZWNyeXB0ZWQo
KSBmYWlscywNCj4gYW5kIGRvbid0IG5lZWQgdG8gcHJpbnQgYW4gZXJyb3Igc2luY2Ugc2V0X21l
bW9yeV9kZWNyeXB0ZWQoKQ0KPiB3aWxsIGNhbGwgV0FSTl9PTkNFKCkuDQo+IA0KPiBSZXZpZXdl
ZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiBSZXZp
ZXdlZC1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+
DQoNCkl0IG5lZWRzIGEgRml4ZXMgdGFnLg0KRml4ZXM6IGY0NzM4ZjU2ZDFkYyAoInZpcnQ6IHRk
eC1ndWVzdDogQWRkIFF1b3RlIGdlbmVyYXRpb24gc3VwcG9ydCB1c2luZw0KVFNNX1JFUE9SVFMi
KQ0KDQpJIHRoaW5rIGl0IGlzIGEgd29ydGh3aGlsZSBmaXguIFdpdGhvdXQgaXQgdGhlIGd1ZXN0
IGNhbiBiZSB0cmlja2VkIGludG8gZnJlZWluZw0Kc2hhcmVkIHBhZ2VzLCBvciB0cnlpbmcgdG8g
ZXhlY3V0ZSBmcm9tIHRoZW0gYW5kIGNyYXNoaW5nLg0KDQpJJ20gbm90IHN1cmUgaG93IHdlIG1p
c3NlZCB0aGlzIGNhc2UsIGJ1dCBmcm9tIHRoZSBmaXhlcyBjb21taXQgZGF0ZSBpdCBtYXkgaGF2
ZQ0KYmVlbiBpbi1mbGlnaHQgc29tZXdoZXJlIHdoZW4gSSB3YXMgZG9pbmcgdGhlIHRyZWV3aWRl
IHNlYXJjaC4NCg==


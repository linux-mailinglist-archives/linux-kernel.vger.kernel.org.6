Return-Path: <linux-kernel+bounces-550699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16045A56316
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1081892852
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC391E1DE7;
	Fri,  7 Mar 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSQrspQA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD4199E94
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337884; cv=fail; b=jgG4G70NY9+ir9ncpfeXXV73arbiYkqUCGki5NUJY2qIOZnZDBOXzglzk1wPECceJqvdIMYeKaYs1G8VvO9hDBvI3jXWFJj+4K+XmPXElussmZPXweej4xg5JRzVf4udQ/QWcqzQHaqxWiNu+65iDZLSa3yyy8xrrDzLdv/h2+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337884; c=relaxed/simple;
	bh=h1qTP1tvVkYwhrwbItRCVo+EZctf+2y+VhJ3ecJRRbU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8kYqeMts/T2lPhmgclzIm4BsmPA22AA1lozqzWobejdnxiFcF2BMVNEg5RoIH49Br46siXARwc/+Mcs6s5ulIt8lQ6+5ECcibMnvwIRKgd6MPjFl+qKMGaxcn4HjSNj3kDVQdfV3WsgfElNN3EYdcmn6RIsEvUMgvxs2YD6Kfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSQrspQA; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741337882; x=1772873882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h1qTP1tvVkYwhrwbItRCVo+EZctf+2y+VhJ3ecJRRbU=;
  b=dSQrspQA3iHD0sEMAS2z4PZY2cYXSOGuuaVyY3Zk8wXsNAbCHr1Ktyb5
   kvIlQy5Ia2tRfUYXuKkxkpOMzdOkz2ZjfqZ3ZVHhQSvn6oN8kIjWveRzJ
   lxcCzPkjxm4aFMXTbwnJtYwtcZ4Gq+bA43bdja2FANiv3HxXlDCm8m9vb
   zoK7jhTTx4LshLlSbU1O/kOl7rY0FTos9f/zM88Qlf+6K2cEhUgAOgu5f
   Rxb3lTdW9OkDuhrWaiVFFMJaMl37iu3fcQAU3TQ7W9tIf5SkNhs4XgEdm
   lHgZQSKGM2xKoNcKhSJ5dztxWUc7uAXSL5vh7n5cqSTWwByBNDZ+sFltD
   g==;
X-CSE-ConnectionGUID: o/FIXXjyQAeI48uZuXRyHA==
X-CSE-MsgGUID: HXgZTHKSQd6DLyjQngIKEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41547322"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="41547322"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:01 -0800
X-CSE-ConnectionGUID: jsNJbFSzQn619vMwxGIhwg==
X-CSE-MsgGUID: eaaHyuoWT1GbPGpHJhZctw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120189761"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 00:58:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 00:58:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 00:58:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKMsr98lASXxNWh+LhaOkX8YPRE56sqQmvAoh6pQ8zwlnblZK3B/tfCyuOPXhvvihZwp406F+U67iqfp1UuoaffKeX5Dgt0UzlBJqC4Hia3Nf7Fp1hyxzMQIT1VFMoIERiCLmE2p4ZTgFjE1ac8grK0RzRBBr9rQn2YiA6jKN2HIuc3ngVcFsvFbYUNr6nVn3sse1XtI1MjehUvwNPyd1OXCMBw7Bey8iCCV7nKamANzxAgckvWAkyvV8Ruq+G5n5bALZgOGP8ir4VHCJROwpxI3HO0CZj/b3xymItwa/25AlQ059zYA5Oc2gOCAFMxgEsS4rFQCljwYpVcIwFQTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjuLpLf+qjlqi3A2umf9M4tXIF+4vHcCaEytpyyOBgo=;
 b=crgPZ7bKisCV4NVEAs2lzx1COvQqfbf0/h8tCsnE4osf1OraAVMAd5vxf184i6G7CiAq87fDJMtOSg3hvl8xhBGR27KBf6kLGh5Tvp8wOhak1v8rm/0zO7+9VDahXE4zPJB2c8KNmWlJIm8tfDOHmzA/49aBNl6JD5xrKqYTm2BfDwRG1bnpM4VufdpKn6Xlzz/pvI5vjUhIxZJAqAOlKtpVXHe5tL/VmblBJzcttlgdJFdyGlI5awNFXz3zEwzZ4+ddeUTJFC7igIa2Kk5D60jcfbZ07akG48Judb9PoCYmeJJu9PfCF3b/ITFxe6z3nvRBKoQEs7l7Vxa6ZOzHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) by
 IA0PR11MB7912.namprd11.prod.outlook.com (2603:10b6:208:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 08:57:26 +0000
Received: from DS0PR11MB7904.namprd11.prod.outlook.com
 ([fe80::f97d:d6b8:112a:7739]) by DS0PR11MB7904.namprd11.prod.outlook.com
 ([fe80::f97d:d6b8:112a:7739%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 08:57:26 +0000
Message-ID: <eb8a6e71-601a-435f-a79b-ce95ee012c8f@intel.com>
Date: Fri, 7 Mar 2025 10:56:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/vmemmap: Use direct-mapped VA instead of
 vmemmap-based VA
To: Dave Hansen <dave.hansen@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: "Harry Yoo (Oracle)" <42.hyeyoo@gmail.com>,
	<linux-kernel@vger.kernel.org>, <osalvador@suse.de>, <byungchul@sk.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<max.byungchul.park@sk.com>, <max.byungchul.park@gmail.com>, <x86@kernel.org>
References: <20250217114133.400063-1-gwan-gyeong.mun@intel.com>
 <20250217114133.400063-2-gwan-gyeong.mun@intel.com>
 <Z7QaPwI1eMPEwHii@MacBook-Air-5.local>
 <20250217214342.33b4fcc4e775cf5ca70053a0@linux-foundation.org>
 <06eff380-a386-44d1-9115-33a08c2d8c95@intel.com>
 <20250305194641.357826b606a53f98474eb997@linux-foundation.org>
 <716f5a42-6828-4f0e-9002-d3bd5c4ad363@intel.com>
Content-Language: en-US
From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <716f5a42-6828-4f0e-9002-d3bd5c4ad363@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::8) To DS0PR11MB7904.namprd11.prod.outlook.com
 (2603:10b6:8:f8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7904:EE_|IA0PR11MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9838bcb7-731a-4435-942c-08dd5d5614f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG5KQ2U2K2ZCeitMTHVBSE5Wc1h1N1lFbGlBaDJjYjd0VVZ4cTBJWllpbGpn?=
 =?utf-8?B?eUtodTl5aTBoRzc0MDB0aHZRSjdxNW1NZStUei9HM1lZbzg1RzJ0NnNLZGdZ?=
 =?utf-8?B?NUVuMnpkY3Z2b0psU0JkUkN2MG5oaTh2VUFqdlNuaTFTOUlpU2kxdHNWaE5u?=
 =?utf-8?B?ODNQSUFxV3AvTTJnYjFvMjdSUVhRRWExS0IwNFZ6dXArR2dQSGRUUitTelVZ?=
 =?utf-8?B?dm9KaDhFUHl2UzRIaEdYRTFlSlJSWTVRc3NoMWtMU2o2VGlXaGt3T0IwOXpW?=
 =?utf-8?B?WXZEUzc5VWxDSWI4c2RFTG85NnNndUdIYkhyRFFOR0VoOGlDcjlhOXorQ1No?=
 =?utf-8?B?MEpwZWthdk14cnVrZWpjSGI0c2tyeXJMY1VGRmpWYUJhMzBEV1Z1TmFNbllq?=
 =?utf-8?B?ZlUxQU1zb1Vkc1VCVFp3cnhiNnFXL2YrWTFYcThsMmI5WlN0Z0M0cUtIMklJ?=
 =?utf-8?B?UjBNdEJSckI0ejFlbExUa0YzTXVSSCtHNXBmNXlyd2Z3WTN5SnY2OEVTYkQ4?=
 =?utf-8?B?U3BsMy8rZW9jK2o1RXF3TElOTElMWjMwaVhadys0WW5sZytkMlFMOTlPdlF0?=
 =?utf-8?B?Z1RKTytnUzhiTnliQWkvSzZUZGw4Vml2NFUrelVvTENZRHc5WC96WG0xbHNh?=
 =?utf-8?B?R3ZvQ1JPTHpQT3huRW5na1Z3eXZKTlBydTkwNVkweHk5RUM0KzBDUnJzcy81?=
 =?utf-8?B?cHIremNxL3ZGYXJQc2hOWi9pTHIxSjZyTUpTRVBhbnJJUzdyTHpOVld6T1Y2?=
 =?utf-8?B?RlVsUE1QUENHTEo3bUN4ZGliUEQ5a3NXWEZuQjVqcXM2eDRTZXZoS3BvbWds?=
 =?utf-8?B?c1lIQnhINzdNV3lrYlkrRE9OeXdUNVk2RDdBYjlpKzhYQ0RoQnR5LzNyWVlr?=
 =?utf-8?B?VURSUlpuRlZISWdSQk9INXJwWnFHVWNta3JvcEFIak4xbDdENnpobjYzYXht?=
 =?utf-8?B?eWFha2ZzZDhpTTcvNGNPWW0rWUJ0bjRpditOOTU2eWZFWWNyY2JFUE91YUY0?=
 =?utf-8?B?RGZsQm90M3QxM1VoM0NwdkRQTXVKblZQUmlEQjVvQUZVYkJFdXlBd1NYNU9T?=
 =?utf-8?B?bHVyTHpoNHpTOHlVRXVLQ2EyU2IwMmppRG1pMW9LdWxaK3F4QTJiczNlZXIw?=
 =?utf-8?B?RkIzQTJuc1ljVmVnVGREWkhQZFU3cDFmV0FBODVvTk1kNzEvQ1BxY1FmRkN1?=
 =?utf-8?B?R3JtN25ZaE5QNHY0R25NVkE4Y3JUSWFEbTl4dkswNTREZC9sVHBvc3JkZEVQ?=
 =?utf-8?B?SWlwYko2NG9ySnFnOEVpeStRYkVNdUdBc2V4c3NPNTJHTFNwYlg5ZFBLT2VZ?=
 =?utf-8?B?dmFZTWtRWU0rWUY0NGxZdS85NDNXaU5CeEhPY1hJSXZFVTRoZVBVZ0xLQyt4?=
 =?utf-8?B?NE90dEYzQ2d2RGJqQURCc1lKb3dIbVppNVhvSGlsOGhnQjkxbUhueVBRQ05t?=
 =?utf-8?B?Skp0VnBRT2p6Sys2RTNNNjRPK0V6NndCdXVzcktDTHR2SnRYY2s0VFdvb1BE?=
 =?utf-8?B?SmVzOWJiOVdhZDM1dkl0eUcyOFlkSHhGdXdSRmZzUVpCdjI0aVJ0QjRsTE5s?=
 =?utf-8?B?c1hrbGZFbGVpZThhN1hwc0grOXVuWHpFV0E2aks0Vm1hV3h5amtJWnNmZjJq?=
 =?utf-8?B?UmRQb25KR1BJUjZ2TzlTWW0xdVRYbXpadHBTWSszV0s0eVJQUVdTMWxGVWIv?=
 =?utf-8?B?T0ljYmRBc2JlNWNnZVB4alphYjFOSndoTU5IS2UvVW5XbVpwRDZtRWFmYXp5?=
 =?utf-8?B?UFJHUnhwOXpsMm5UaFBlNnlkUVlCV3hWKzZtVUFiL1FIZ3poelZKb0s4MnFp?=
 =?utf-8?B?OTYwWEJnTFZzS2wxM3IzOUZmY04rblhEVHo3dDZJcE9hczFQQ2s4dWg1WVNI?=
 =?utf-8?Q?Ak75uoYIxLKG8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNyOXAwT3hLc0ZrTFdCbG5HNFRxSXcwNXJlWlI5Y1dOSW5TQmZPNXNjRHBC?=
 =?utf-8?B?SmtTWnZMSWpURnJ0NmVCZlc5UCt6OHQzNG1WMHlnWFI1Si8vMnd2enU1RmY3?=
 =?utf-8?B?bjViNVkwRUY2eXI3WVFld01HcHdHMTNOdm9BWnhEOFRsUms3ZlJUa1FPdHd4?=
 =?utf-8?B?RE9NTVZoNVc3akVNaklYSlhVVjNnY3lHOG1POFhXdDV4cUZsTWFoRkNHZkw3?=
 =?utf-8?B?YnFiQko2MEhxejhJUTRja1Z5QUIzelhqODRpa3c0dE9kTk9RazVOeU5oemtC?=
 =?utf-8?B?R0xBSW5SQ3dqbFdKRUthbVZiVmdaRXU5blJMVXM2bHlIYS9MWnc0Z0FoQXdm?=
 =?utf-8?B?UEp3eDdkL3lwcVhxUGZya00vTjdoMXREZlZLcDJIZ0RsR3c1bUdxa0FBTFdQ?=
 =?utf-8?B?bjh2eFlBaXNiTHA1TDJneXJCejZqblNXYXFCc0dISm5sSGlXZGlaNk9LY29K?=
 =?utf-8?B?ZGNPWGFyL3NMTXhWbWJUWUlranFhcFA1Z2gySFdMK0hHQ3hIbGFzalUvY0o1?=
 =?utf-8?B?RGFyVlRxZ1UyT3VlMnlqMjI3MG54MndGaGgvVCtPNlZsaGE3QlJJdU40V1Iz?=
 =?utf-8?B?TFlScTllbXRwbEo3ZDN1bzF2Q1huNGVIZlNzWFVhaVI0K0ltakw5WlpYK1h5?=
 =?utf-8?B?NWlGeTMwM3c1SWNrOWZHRmRNOW91aC9Ucm5HM0swYjZaM21DTFVHUzIwVTZv?=
 =?utf-8?B?QTFIazlQY281RHJqRWh1T2JiRnpsQXpwSnd5Zi9BZzZaSm15amRBTGU4TENj?=
 =?utf-8?B?U2lpN2ptYzZHb0UwOGkvcWIwYTBOaXozSG5BOEQzWmtBV2tTSFFTTXR4MWJU?=
 =?utf-8?B?cU13MzFka3F5bkdCbWllN1poNFJ2OEw3Y01aWDEwOU1NWTVOWU5LbmtGZ3ZE?=
 =?utf-8?B?N053eFZ6ZGlZa3h6bzA0dDlmUmVSbHpXaDV5Yy9PRldvRWV1RHIrcENZaGI5?=
 =?utf-8?B?cXBoNVBlVDArK2hBMndTbUJ4VENoRlBKN1NnS2p6ZElXbjhXT3luVUhKc1Bk?=
 =?utf-8?B?T1F5STRDMi9pMW9VRHN1NXNxazFUUFFTTEhkYXA0MytIdVdEWnYzTWl2S1gz?=
 =?utf-8?B?dTVuQVA0bmdlWWNSL2pLcnhkcXZnMFJwWDh3QTNjTW9RTmU1Q0U4UTIrQ3Q3?=
 =?utf-8?B?WlEvVHFPUEhjTDVsNVdKQkhDOTR0UjF1dVR0bjdCVkp6R3lKc05FeTMvMm93?=
 =?utf-8?B?VkdYWmI1bWhrbHpCaXhxb3BNbkpQKzVNQ3plc09rYlFKREpUUHVLcGNVMmpU?=
 =?utf-8?B?LzdzS3QwZjV3V0duWjFVSWFJcE9NaEczNDJjMWM4SlMzSEhEU0s1c3FDTVp1?=
 =?utf-8?B?R1lMWVhpSUlKcWRMci9jRU15YmVWZnk3Nm1ZMU9EbmsrOUhqNXRHK3kyL05p?=
 =?utf-8?B?SnNVRnFzUHUrVUtUaUlicFg3UU9DRDI0VjFiMHVrSlk1NmRZSFMwc1hia1FB?=
 =?utf-8?B?WER3bUZYREozMHlidXduUHhoaHlHeG4rUXYxNHRYWk5SKzhCTFFGQjQ0dnBR?=
 =?utf-8?B?d0dlMnJ3cVlkTnYzZmxpekp6ZDZDdDNEbG5Dd1pqNms0emtWMFVLTWhFcjdG?=
 =?utf-8?B?ck1UMW1jUnJJYUZIQW5Bb0VkeEdBS0ZLYWdac0Vmcmc0Z2JCZW9XUmZGbEQr?=
 =?utf-8?B?Vmk0aS93ZXU3cTU5THEvNGFza1RsZ0ZEU2kvbThlRUpoT0NQTENYQlJGZ3dz?=
 =?utf-8?B?RHJKbEFVK1YyOUZ5ay9yaEt6d05sK3R1VUFQc0JnK1M2WForRENSTTRhcnZv?=
 =?utf-8?B?RzZxK1AwR1BQN1psbEY2SEg2VjJtdlh0NnZDV2lMUjg1ZEk5VGlmOTdvMUlM?=
 =?utf-8?B?ekxFdHJBVGhJRitlL3NGN3J5RUhxbzBwZlNwVGFoMWs3bkYrU1FvZEVJMmgv?=
 =?utf-8?B?a3ZEbXFkTVhEM2QyUmF0eVhxVXVCR1hFQmhpM2pyRUYvTnZQazF3bVNjd2FB?=
 =?utf-8?B?b0FibnBSTEtmNE1vOUdpeWt2dHlQSXFWTkJQOExMejVBWXI0cEg1dDVYY1lp?=
 =?utf-8?B?V1FRQStvbmtJWForSml3a281QjBsNzVVdmlXeTJ4TnQ1elQ2SzVWOGRsVUJP?=
 =?utf-8?B?eHhzbWg2L3ZaT0lnRW00aWdmaVZuTlNxanZDOS91WHlRK0NZYW43bzMxWmtE?=
 =?utf-8?B?K1VlcDZqc0RJcEE2aTF3REkwZzYvOHNVZWNnenJLNHZHSFo4WE5pc2VqeFVO?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9838bcb7-731a-4435-942c-08dd5d5614f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 08:57:26.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJQfJEHzSsBjErHraReQbGYv8R9tvho4rgbXtUg+pJMTC6wMPrBkY5zlAEv3/xVq/lqWgejRBq720O1bmDJiUi3AhCO/R09koZAm2b9fFZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7912
X-OriginatorOrg: intel.com

Sorry for the late reply.

On 3/6/25 6:09 PM, Dave Hansen wrote:
> On 3/5/25 19:46, Andrew Morton wrote:
>> Can we please have review from x86 maintainers?
> 
> I didn't respond here because I thought this was the same problem from
> the same contributor that we addressed in another thread:
> 
>> https://lore.kernel.org/all/d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com/
> 
> I think this approach is a hack. It basically requires that every bit of
> code that _might_ update (and then use) a PGD in the init_mm know how to
> find the direct map alias and then use that instead. This would further
> specialize the x86 code. I have no reason to believe that this is truly
> an x86-specific problem. Are we really the only arch that has a
> per-process PGD that maps the shared kernel page tables?
> 
currently the scenario that causes this issue only happens on x86, 
therfore I did a hotfix to make sure it would not affect other archtecture.

And I agree, I don't think this is an x86 only issue, and if there is a 
scenario that can cause the situation I reported on other platforms, I 
think it is possible.
> The right solution (like I mentioned in the other thread) is to sync the
> PGDs more aggressively. Syncing them is expensive, of course, but it's a
> pretty darn rare operation.
I'll send a new patch that introdues helper functions suggested by Dave 
above.

Thank you for not forgetting this issue and bringing it back to the surface.

Thanks,

G.G.


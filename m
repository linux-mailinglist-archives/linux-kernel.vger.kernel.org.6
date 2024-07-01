Return-Path: <linux-kernel+bounces-236899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B191E85F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1631C216C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682716F8F0;
	Mon,  1 Jul 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S27138dp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E016F8F3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861222; cv=fail; b=OIx+M9I/lqmU8kL7DoBkY2x5iQbeXF464U4+mOFokozJ/3VHjMV66VIgqtlkJy98pajBWB+wgrnpMPA0ifn/z7KvLxZNkf0r9mirin2v5zmW+j381S4eWD9majNwJ12gnOKPHGDUlSbZ3J9pgcXUK+PzwzHIyNCFIq0lARKbUO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861222; c=relaxed/simple;
	bh=KRpictUQGEfRn0o7HAa4MqfGs9X9Xag7E+sG6lHirJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NzrZuwOuNjcZ0uaiEamqbICyI9Ektob9Kd1WQf+jyRdv+NJTCFdfdQY8aDKMEK3JhN0QCgdgCnrHARl1eHYfyJqheWeunVuhQAY4SytynO42fo+/xEYLRnd9XDVeRHvQMnu6/b5YhWvSuO5TZ3QB+Sq2pawcLCMZsJRreJhqmo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S27138dp; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719861222; x=1751397222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KRpictUQGEfRn0o7HAa4MqfGs9X9Xag7E+sG6lHirJU=;
  b=S27138dp/v/EVdKsyOozG1CVYNl2bo5wNKtGLy8TsVFRHpNGhTlcG3iQ
   J68BAYHmB75oPpEihqQCQPgKtFXACbHMF1BS0C4EviQh8pj7Z/0Zar6o4
   XreJL55TAjtJFZhhD/a1LujesyknMbdf2TqfuZQaagQkPHO2UI1xFI46p
   /StMNqZRrBPj4xWWjcl2lbt45dRlFHGpfhhBHO4P4nF0Tzy47BjELANTH
   eQu05GG25KXTElF3WeD7Au0mRIgk5uO2VXYiRofvg1aJkCe4WEe+62rtR
   Ad0YRmKfIuiuHh3ZycIaI3i6NYmTntpqEz+I+Z1eDD1GUuPDDOrqttPEw
   g==;
X-CSE-ConnectionGUID: DUEwKUfsRm+osAfA4TSBjw==
X-CSE-MsgGUID: KwZm/c8ISfqPycUyxWJDsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16850683"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="16850683"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 12:13:41 -0700
X-CSE-ConnectionGUID: zMr/h7uhQT2JOQNi7Od+aQ==
X-CSE-MsgGUID: QOlCHPDzTM29uQcwz9V0/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45634870"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 12:13:39 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 12:13:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 12:13:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 12:13:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4r6CwkDbCvNE1MbnJw6+hcK4K3ey4GJSBw/+VUAIExQ+WyH0lQ2H7/cGF1/OOCBosjcVAvcHiVNXroHvwLvOl4mmGTMTLslcSSuIzGA48ru3bbsLP/Fd7Myy66487Ii5P6PAn8M5i1UVHci4jfUuOCE+hLO2Yl0QFGZWjyjLXx8SmkSM4JEgaXmutAFDnBlbMpTQggcjlVaNEs8cllnQ1cEmr6UgNcoeVx7qNZ6l2nlT8+//XHiTyYVrcdU/lAs/yGmKoo3dq584nFRjW8MbzYdhmDgkNvvjxtm92iIhsl9FelM1jD7BDHag0L95r0lBZFnDnNV+5SnB2b1Hwlzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRpictUQGEfRn0o7HAa4MqfGs9X9Xag7E+sG6lHirJU=;
 b=oUZO42WnO+cBJ1mJrDbW3rfUqZjRWyJpKm0AYz4wOpXxzEr8ecMM3UaVlPBUoWJHxT9MRzlQBxMcVSfzao2dvDRbFFC46OnKlcwy69dhV2Ww53RUhixwjs/RSef+DadkVJDsQCAHlg8FzmgbQktuLGYcAA2XfqOk6iZIphIoIPcHzq8E2VFgMDGVWZ9V5zBgWHmq9SgjT0WwSKj58Vc3e9JDkbRK4BnD4pC9v/Q73/mCeCM9tJvTfZoPIJiwJJinyctaxJ01SsaG8cfPFdXAcYV5U0hBzkxhNvItUXahDI+P/y9qnbZT+5g8j1Dz3FTCUXT7bHvkGzonc6jQiKJElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7382.namprd11.prod.outlook.com (2603:10b6:8:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 19:13:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 19:13:30 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "jgross@suse.com" <jgross@suse.com>, "luto@kernel.org" <luto@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>
CC: "x86@kernel.org" <x86@kernel.org>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "Rodel, Jorg" <jroedel@suse.de>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Thread-Topic: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Thread-Index: AQHayZ0272Rw0HaOX0+/vmpf14Hnz7HeiKyAgAOkgwCAAAtfAIAABcCAgAAD+oA=
Date: Mon, 1 Jul 2024 19:13:30 +0000
Message-ID: <25478bbd92a0dacb6d52d7ffd214374e151a9338.camel@intel.com>
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
	 <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
	 <5cf60d52-1682-4244-b892-688b22eaf4a1@amd.com>
	 <8d970528-0e57-457f-ae00-862b4d320a2a@suse.com>
	 <0dfcaae1-9ee7-47c5-b530-2062021155f0@amd.com>
In-Reply-To: <0dfcaae1-9ee7-47c5-b530-2062021155f0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7382:EE_
x-ms-office365-filtering-correlation-id: 95a622d6-a04b-4282-b76f-08dc9a01e4c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0RYYmRyTStDMmtmNEFZWWxWVjZNNmJFNHdLa2FwYmJrR2loQ2dNS3pHSWZD?=
 =?utf-8?B?OUJjd21zcnBsRVBGa2RPckNxZEVlNHIwd2ltUXk2Z0ZVVncza3p2VjBzUFNZ?=
 =?utf-8?B?Z3BLNk5nQjFJWXVObkxyUnVMWldXM2dTcHZtRCtpSDhTNUdjNU9hdFJ2dVVi?=
 =?utf-8?B?Vkc0OVRpTkZWKzBnai9vcVRCNGJybnRPS3BpY2loQXp0cmpiaUNZYWUvdXlM?=
 =?utf-8?B?aTRJVFpGcjFaS0ZyVUlGUXg1akJoYStZYllzWE9XdjJDR2JzeUtMQ0I3NUNP?=
 =?utf-8?B?K2t5dFF2bGIyUXQvT21SR1NBcGQxOXkwUGtoWGNlZTRFWVFOSThOOXltSVBn?=
 =?utf-8?B?Tnp6OExTd3BtYklydS9rWWYzeVlMVVV4RkxlQWtJczRjbEs3Wko2Q05SendU?=
 =?utf-8?B?RWNZR3pKejkwdGxSb1NKazllRGhpRXpNbzhDUVBGMzJYN044U2JWZGtmNnIz?=
 =?utf-8?B?cm1LWHRMRFE5Kys5WTVLQm4vZFZ1ckFoS1l2REZjb3RVMmNveXZjRzVmWWYy?=
 =?utf-8?B?MnRtNVMrTUltY3kvVzlKdHl2ajdERURzOGIxZEJQaUJpREw0QVN1bGtiT3lY?=
 =?utf-8?B?b0lJemQ4Q3ZGRTZMWnZFcW5EamtIMUJTK3BPM2xObFFka1ZZUTd5YlZmQU9y?=
 =?utf-8?B?SStJZkRZUnQ5a01FNkk3RHVBRGJWZkZ6MnpPOGNsSWZpLzVpN2J6Q1ZCb0dT?=
 =?utf-8?B?MW9FU3NEdkxtWE91b0pmdzB5bStBd1hOdDg3YndUemt0RmNNR3JkdEFOdUEz?=
 =?utf-8?B?OGczRFhPaTh0WlAxSmtaY3I2UXVwWXAzVzlka09tZm54QnpoVU5aaDRpMm9v?=
 =?utf-8?B?NE9TMDY3cWRaSXVDTTA5bk93dWRvZXk4QUkrY094YnFNdWlVdmhiMHU2T1Rw?=
 =?utf-8?B?ZmdlQTh1NkVsbnp2RllwcDZvUGJoZzJhdXRwejVDRzdHUWxtdWpWQlZndWdm?=
 =?utf-8?B?TGlnMk5vTmhSL1RWWjA1VGVFSU03RkhCM1FGaUF4cG1TbHpyR1lBb2Z1QktH?=
 =?utf-8?B?MGJzUkh0VC8rTDZUK3dWOEJBaWthYkx5Y3BHV0VCTm9wd3dNS1IvZWl4Q2dB?=
 =?utf-8?B?bS9hVStWMW94MlhpSGhGUE9uVVFFYk1DdTRiQXZrR2RPNDIzNGFuSnFwNS9T?=
 =?utf-8?B?cWVIcEtIdEtvdzR5U3A4b2FWUHY1WW1lWDd0SHNDUkNqSVFFZG1zbE1idUhl?=
 =?utf-8?B?K25oQ0szcXlicHJRc3RTQkFVU3dmSU5tN3k3bGhKd1Nld1p0aEVaSmpJWjJj?=
 =?utf-8?B?cXB4QmVXOFFVZFpQYjNMaXlBMmJlNmtET3VweWRkZGNGNGh3cmwrZFpnbnlG?=
 =?utf-8?B?MFJkeFVSNGd6WElZd2pUSGRnQ1FudEp0NzlHR3BxZnJLMjJTU29vMmJicHNq?=
 =?utf-8?B?YU1xQ1JLZVI1RXIzdGdDUVp2cENjRGM0dHdXSGh5T3NIMVpyakJIeW1TWUk1?=
 =?utf-8?B?VFo2aEhCNVlQVlJrT1BQY2RYajN2TTBRczc5ZktVbGtlUU81b3M5aFVURnlI?=
 =?utf-8?B?SDdFWkFnRUV5cE94YkNzeEN2RmpNZDBYTkJoaFVOQXhuTjBzVS9kRk05L0x1?=
 =?utf-8?B?VFJLRlluMllQbjM0WUdlZFNhLzk4cGticzExSi9yRkkxb0ZMWlBpKzRJL2Qr?=
 =?utf-8?B?T21TTUNNc0tsV3VoeXJ4eWZFVU9Ma2UzejhTZGtOb1V5L0FZYit3QWtKU2tW?=
 =?utf-8?B?S25uOVBiWTFXb1MzbXZDdlZzbGhjU2owTFMwM0J1OGMzZ0t2Nkx4bzRGcjNX?=
 =?utf-8?B?L3RlaG54d1AzK2NGWGhIQlNrZWI5REk5ZUxMRGd1WEcrRVZnZWpGVEdmMHNm?=
 =?utf-8?B?bThXdGI4bzRDRUhyVnJ3RVU5aTltT2Q1QlA2ODVjSi80MzBPTllPbXpEUDJZ?=
 =?utf-8?B?V1dncjJ1ZXJxUTBwY3Z1WEVmeEswQzVOMHlET2hVL1BqdGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWJCTWx5Y1JXZ0dCTit3Y0g1OFkwM2NDQmpMS2x2TkkyZGdOb0lWM0RXOVAx?=
 =?utf-8?B?MzladDJBaUdaZ3Irc0VGQVFjRlZJNFhBVDNUZ2prZ2lyNXpybVhDUmFVck5y?=
 =?utf-8?B?bUdkN2YvM090M1FYeEhydzBjVFpvejlaMkM0YkMwVTd6eUpOOGFwVmpKTXIv?=
 =?utf-8?B?SVFNSlFwRzZ4RE1NV1RwdzNFM2ZuWHE2WWFVSFZBNHh5a0tsd2d0enBqZHJq?=
 =?utf-8?B?aXFNVitTNGpMOXFqdnozK0pHY3U3eVRqRm01cW4xSElYMVJCQkoyaDcvSGtR?=
 =?utf-8?B?azU3Z0pEZmFiejlUN2VwM1publpsZkRzc3VOeG91ekljZFhLZ2RTZXZoNCtn?=
 =?utf-8?B?ZmJ0ejJ5eWhqbjNnM1ZVZlZZRkRXdm9sYkJPV1NRbWdWUlI1ZU9lZmgrVUZW?=
 =?utf-8?B?djNSQWhqSWMvR3phazdwWkZrQ3VFeTlad0VMeHcxWjdianE3M0ZUaDlYa09Z?=
 =?utf-8?B?Ukt0MjBSczNUdUdhbVkrdFdlSW1lVVpXc093ZHhVaVJwOG1VTW5Da0pPeHFz?=
 =?utf-8?B?RW5uNnN4TzFhY0FsY1gwbkJqVVV1NnYvSWRrN2t4T2JMNnNJMDM4TEhLcXQ2?=
 =?utf-8?B?aUdVTmI5MlBOeXdoMDhWUXkrOUVFZStJSnRoV2hidXFzRU9sT0R0Rk9KRnU3?=
 =?utf-8?B?RlZCZ3hvVExtYnRYc0NUZlNBa00xblZrQTYzK0pFQVhMdlhpOWd3NFJuRDRW?=
 =?utf-8?B?L0IzOEdTd3hmNUlsR25wc1hHOUp2R0VHdFdFSkdYSnV5ZXdOV0xZTm8yOVd3?=
 =?utf-8?B?Wk4vVm82Wmk4Uk9Yb0l6NjVFUTAydFczMkd2eTFhZTlFRnAyUlh6ZHNCcGNC?=
 =?utf-8?B?V0FvNGlTZFJ4LzU0N1k4dWdnMjVia0tpYk84SVFUYWhtWUV2emJmMEp0OXZi?=
 =?utf-8?B?SUJ2cW9adis0Y2ZYdm1qK1ZZK21udGo4OHVQUDV6aGduREt1WSsra0Z6Slhs?=
 =?utf-8?B?ZTg4VWpuRWIyelFGRWppclRzRkUxdEF3SHRoMnZKVUdYbFJIUGpNRXNGN01C?=
 =?utf-8?B?WVJlelU5cHl4V0x3Wkd3Si80STZnWkZBMytYOURuSm1yYTVvSVovbE05OERK?=
 =?utf-8?B?Z1B1YzBEMDdTdUEvcEkyUCt1NjA4Vk1hQzVxU0lEUVd5QS95ZWJ0ODFOU09B?=
 =?utf-8?B?OThhQ09DYWdBRmZCb1B4WFBRRmQyMzZwOFYxeGlIbzBJSDU3dHNZUjFlQjdB?=
 =?utf-8?B?cnNnSEN2YmZwS0M5NWNEUTczU0xhYXA1SmJmcmVBT2cvemFyc2k1RFNzZEtS?=
 =?utf-8?B?dEYvbUgyQzNDaGpyekZ3dTVrY1A4QndlL1UzUk16OGxxcnlta1V1TW5IYTA1?=
 =?utf-8?B?ZFFIMDFsQ1RDQkdKbGZJa3FRbmpsc0ZwOHp1Q2tDUExJVG44QkQzcjFIWDA0?=
 =?utf-8?B?R2grYzcybHlLazBSeXdzMFIrbGViTWgwaDc3WG5TbzVPMWZWaXRialZTSlN6?=
 =?utf-8?B?NlgydzUzN0hYaEhyTENqL2dkdG9tZDBxeGRDSy82RE5vbUJBUENYSS83aFpr?=
 =?utf-8?B?R1lGejZNR2U5M24yVEdEdUE5RUNmQ25qUFVrMUFTNWFJM0gxRm0yQnpmcW1T?=
 =?utf-8?B?Smw3WTFzS2VYMEI3SUdmL09rRXJqeFgwRGt0cTd5WE8wUnZINDhKMms5Yjk1?=
 =?utf-8?B?M0JDRk12YklmYzhIQkMyMkxPNHJsTVZydDA0TXFES091a3pUY04wK2h0L01K?=
 =?utf-8?B?Zm5OQUZnT0xNS3RRTDB1aHduS3h4dnErY282NjZhQldtYUl2YThzSU1ib0pF?=
 =?utf-8?B?N3JZVUNZTWRIQ1VGZWF1WE5WVy9yWkp1NXE4WkZTc01Vb3FEMXpXby80cVZv?=
 =?utf-8?B?NDc0akZZMUJYNU1VaUpQUmZDSVZLby9zb043ck5zSWp3bG9hbWVlNHJ1WmV3?=
 =?utf-8?B?N1MxaC9xUVllSUt1dHFoWDIvcmxNV0RFT3ZhSjdsZDcwRWNGQWo2bzFjTkFt?=
 =?utf-8?B?NllWZFhMZzBhUDdFZ1lQcENFM2JmZnpOSmllZmkzRkNNcEp3QlBGVENFUFlW?=
 =?utf-8?B?c2R6UlBVUFR6SXlqSGtWaU5Demx6eDZ4VmkwWDI2cHNodmpIR2pHc2RMU25Y?=
 =?utf-8?B?cnUwWlQxWit6aUdNaDhVWksycENGTmdENGFLa2JRbXZ6VHAzMkZWRGVZUDNO?=
 =?utf-8?B?M1hBL20rNExBamxkby9oYUx0UllocVlhMkE4cWhUdXZaTkZ0SnAzWDIwNUhL?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ADB98A3FCE47C4E8DB8A7C82E212D1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a622d6-a04b-4282-b76f-08dc9a01e4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 19:13:30.3000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkN6vW01pyNbX8KPxy2O5tJd7n6eWRscePEdzi0PmPzlLnsQGMW8RXzdtf+ZuZqhTiOaDBFXD0e4cdgAQetjDXpK9iKC9J3guc1WNzxfmpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7382
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDEzOjU5IC0wNTAwLCBLYWxyYSwgQXNoaXNoIHdyb3RlOg0K
PiANCj4gVGhlbiB3aGF0IGlzIHRoZSBjYWxsZXIgc3VwcG9zZWQgdG8gZG8gaW4gdGhpcyBjYXNl
ID8NCj4gDQo+IEFzIHRoZSByZXR1cm4gZnJvbSBsb29rdXBfYWRkcmVzcygpIGlzIG5vbi1OVUxM
IGluIHRoaXMgY2FzZSwgYWNjZXNzaW5nIGl0DQo+IGNhdXNlcyBhIGZhdGFsICNQRi4NCj4gDQo+
IElzIHRoZSBjYWxsZXIgc3VwcG9zZWQgdG8gYWRkIHRoZSBjaGVjayBmb3IgYSB2YWxpZCBQVEUg
dXNpbmcgcHRlX25vbmUoKnB0ZSkgPw0KDQpJIGRpZCBhIHF1aWNrIGxvb2sgYXQgdGhlIGNhbGxl
cnMsIGFuZCBzb21lIGRvIHRoZWlyIG93biBjaGVjayBmb3IgcHRlX25vbmUoKS4NCkJ1dCBzb21l
IGRvbid0LiBTb21lIGFsc28gYXNzdW1lIHRoZSByZXR1cm4gY2FuJ3QgYmUgTlVMTC4NCg0KQ2Fu
IHlvdSBlbGFib3JhdGUgb24geW91ciBnb2FsIGZvciB0aGlzIGNoYW5nZT8gSnVzdCBhIGNsZWFu
dXA/DQoNCg0K


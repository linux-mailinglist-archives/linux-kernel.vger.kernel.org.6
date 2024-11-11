Return-Path: <linux-kernel+bounces-403673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0809C38E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F558B21144
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B415852E;
	Mon, 11 Nov 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kx0sGndz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4A12CD96;
	Mon, 11 Nov 2024 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309024; cv=fail; b=T/gBPzSoM1a3sN+c93fdhTByt6GXBI8LFPbvD77Se/JAi207MHR2RlwMqqxVvMQXG4e4+6gh7oAdaVb9m2WVqSQtzezU5aMkNZfcFj21Asw6jzJW9Y3IDQyYmkLXfGxMDOKp9bbi6nPJQfycFLvkvCy8zFHlo7ON2LjsV0jtOCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309024; c=relaxed/simple;
	bh=k/ew5gmFceE5YI7qIJOn+GdC3HaQ6U5uwGdC4OXmSgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hbyRSkmkUG/jaKYnBg84BPLxtommsshyu+0h8WadhhdObaczMA+3tEIn9cUsjlJH4D8ETVqTd4duuohVkme0jOK0ZMqar0Js0NGjSKSYkzLxWK9n+kK3wuyvG7yviZGXfdGE/rJpcxmC3JHkfeIv3dlK6IIoAbbAoPwjPY/b93w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kx0sGndz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731309022; x=1762845022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k/ew5gmFceE5YI7qIJOn+GdC3HaQ6U5uwGdC4OXmSgk=;
  b=kx0sGndzj9CBXr4UTMpW7sDwidwit2sa+N/qwl3Ee7Lu2WWFgKrrF+X7
   bDPK/vs2Rw6leUFgSnxzdAH9CLN4C8J+hIz6gHokHFmdoi62rWz3Go2Rf
   VP/Ju9qtaw81hEeh0+58opTNkn77hbL+UVEvB271lXbOz0f3/o0jdOVsR
   MfwwH7IWTAkLRVkeC2SMErVSXO+u6jEToVC6jsPv2slQJgIOrt63PATv4
   Jtcx7Jkc/YIcgsL/SQqFFkAs+0H34fCqnh+RgT2vF7Rw/n0/noX8X+u6d
   T6dVNVUO95Jg3g6byVKTgSYV+mDqXYypirycP+MeyrD5YIeCEieU74JuG
   Q==;
X-CSE-ConnectionGUID: 2jTRgYyrROiokSnNvPdbqA==
X-CSE-MsgGUID: Y6gcWQU4S32lw7ukRAh7Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="42491140"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="42491140"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 23:10:22 -0800
X-CSE-ConnectionGUID: ehefFqljTBC9dJUX2smTIA==
X-CSE-MsgGUID: kJF+aLsmQXuc32jSScUu3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="91720696"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2024 23:10:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 23:10:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 10 Nov 2024 23:10:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 10 Nov 2024 23:10:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj9ZSMY/Ig7eaJ7je+bD/QnF4ghglF/kW1WpluFmzNYLqqwWI798l9l1NxOaTdpCyp3RxArtRVARSvfAZX2UYATUq1uhPhYRac3B8E+qjKqFB5aaOJj7SZ/Z+31fmdtxaNEhtfdvpgQX60CSDWYtEy3rS5j+Jllx7rGq461r/SHgwjhtTMuyf0G+sKa2e3f1IpEjQtG3qLP38pHLt51Om7DbYFQZkT6SVLJYCmgSo2zPbN+rQLAcA8hkZV8IUrU2NVs0bwpuVF49GGNgg4e8k4EgK8UKhOo1ZFoosAX1qhfYhgGkMwVyNxr54RKMOdTvR1ktZR2TI3Qk4VNI3fLZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/ew5gmFceE5YI7qIJOn+GdC3HaQ6U5uwGdC4OXmSgk=;
 b=m99pZSw3xJ/3PZ0J9yhxGkoMeVvTfjuNJNro5/Gpc0tUVl1SjBkWDuTJZ/VkWB03TYqHDK0wHcnDk5uA9Hmm8IX2bTGEZsKlvmYkzf9yaxYZPQlqDXWGQglbqV6+gvBdfMXj2Wv73BTKhrr0x7HHDhH1E/Da1uPHhuAv0u+RCB7+Cfamkj0BCIWz6wDBS539YL1oLd1OAFUqj7bvuEiXZxucOXAUzWTqVy1YRH1gZG3oQh+7oOad5YJRRRkkZERatWTr3zcfodRAo5kntV75yQWN4G7jGBcfvrekm+6uDzkAGYYNs/Boago8ZZ+Ead8ZzhzQbmquBqGkxE8V9ooeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by MW4PR11MB8292.namprd11.prod.outlook.com (2603:10b6:303:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 07:10:17 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 07:10:16 +0000
From: "Xu, Even" <even.xu@intel.com>
To: "Aaron, Ma" <aaron.ma@canonical.com>
CC: "bentiss@kernel.org" <bentiss@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "jikos@kernel.org" <jikos@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui1"
	<rui1.zhang@intel.com>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>
Subject: RE: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO
 operation APIs
Thread-Topic: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO
 operation APIs
Thread-Index: AQHbJexOlqStX2GM7kymeEIvMWZKNLKxt2GAgAACx0CAAArCAIAAAG/A
Date: Mon, 11 Nov 2024 07:10:16 +0000
Message-ID: <IA1PR11MB6098DE17D19343A9C077F248F4582@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20241024081023.1468951-5-even.xu@intel.com>
 <da650a93-6d21-444b-adb7-045566f53d5a@canonical.com>
 <IA1PR11MB6098D581A332E576528FD30DF4582@IA1PR11MB6098.namprd11.prod.outlook.com>
 <1a8f80ab-135e-4e57-b9b7-1940e4bfb4f3@canonical.com>
In-Reply-To: <1a8f80ab-135e-4e57-b9b7-1940e4bfb4f3@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|MW4PR11MB8292:EE_
x-ms-office365-filtering-correlation-id: 1cf9cac0-7f7a-42ad-7543-08dd021fe51e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MjlZQ0w3cVp6SnEyZytKOGQrM2RnZERZYWd0SDFKdHFXdDdrek1Zb1M2TklL?=
 =?utf-8?B?UERQMmxVem9tendZTkJXeGdoTldZM0NUYXlQT09qaGxCVEw1RlNGcGtqRmov?=
 =?utf-8?B?RHpMWWJZSjVzaHNuR3RzcFZkeVlsZVBRV1ZtNG9YcVIyRm1SUVZjOTFlY2k1?=
 =?utf-8?B?Mks3cmxBdWpiSFVLK1ZHbmRBRExkQ1JKMlUvUzlsWXg3OGR2S2pEVDc5VVVi?=
 =?utf-8?B?NVlyUG9DLzNQaFVKUDhCa3Y0cGJJRlpESkNSOGtEOThJWEpBRlB2a2FmK0hU?=
 =?utf-8?B?UVpwRXdmVUpUd0ZJYTF2NFBoTnF4VXhtcU9Zc3R4MWtFTk1KMFlTMWowVkow?=
 =?utf-8?B?OW9ZV20wd2NYbFo4Zjd0RXl4YS9kdGoydktaNytpdTdZclhaSnhpRGJrM3Uv?=
 =?utf-8?B?VGRSMEVQT3cvR0hCOWE3S0p6aEF3MVZic0V4UUFVUGxSNkxwcWExbmlvOGVx?=
 =?utf-8?B?a1BKaWlQYmhNNjdNMW44elhETEZBL0tRYndBc205NTZ2T0NLZnR1a3RhbHpv?=
 =?utf-8?B?Tk0vY1U3aTJHMmljZXFJRnBCVHYrdmFSVTZ6SW1hL0N5cUlKRXc5dFRDY1Fn?=
 =?utf-8?B?b0tXYmF5aVVxL3pCL0dUUThIbE5ISGFEeTRWNDlzL25JUTdpMVEvZDVIenB1?=
 =?utf-8?B?VjZSaU5TSWM1d1RyeVZjQ1g0RG9OWWFVcWFvUkpkMmIwRzcvYzBrZk1aNU5i?=
 =?utf-8?B?TGNMaHVVL1k3YlZZSm4vNVlrbDBKSVpyN0FpSzM5VFA5eXkza203ZTJJVkRr?=
 =?utf-8?B?UWNHQ2Q5ckZXeExUN0pVK3U2SVNQRUhRck5YYjBTSE1TbVBCMGt5cDdWZWtS?=
 =?utf-8?B?QUdRdVNmQ2RFVW1zT0dlZkh4K280cnFkQ090ODRUaDhjbVRvV2RTdi9aOGxu?=
 =?utf-8?B?RXJ0blpkYnJBc3lvbXpRR0JjOVhNWjZ2NGNxTkFYL3lxNGtiMkNGY3dLYkVr?=
 =?utf-8?B?ajA3VUx2WStTSFMvKzZ2eEFYNS93a0EwYTlXUXJwSTJFTmNkeXpTYVRXRFNI?=
 =?utf-8?B?ZWtLMmZXSGtvUFVHQmloQWU4TDFMS3N1ZmdnN3p1WS96YkpvTUFmcnBCRjlG?=
 =?utf-8?B?Y3lZY3BEYzBFTUlnREg0Zm9sU2Rxejg2R2pzNEtjRXlwM3FXak43U296dHpH?=
 =?utf-8?B?MGtzSnpTZ3luTU9DVEpodllHamR6VEMwM0dyUlRyN05zbWttcjh1Y3NQZ3Rk?=
 =?utf-8?B?YS9oNTlmSXZsc01XMURqcmxkYXkzTElkZHU3N1R3ck5DQkxhMndaNGRaZHhY?=
 =?utf-8?B?OXZXTlBUODkrLzNpMW5VNDgxUTdFUFNpYnB5MG5ZcXNYZ1BYRURDYmM1Q1N6?=
 =?utf-8?B?NnFXM1U4MGlGVmFBTC9ZWjUvcGFjamkwRjBxS3ZxbmNpQTdxNlhIanlwaXFF?=
 =?utf-8?B?eGtQcDJxWldFSkNNZVdXTmlXMkQ0bnN0bm9TNE12TmlEaEtqalZwUUFYM2hw?=
 =?utf-8?B?RU96RWF0ZWllWUlWSld1cFNBWUZiTldqb3M5U1FrZzdVQm53SmxGN3dLVjJL?=
 =?utf-8?B?cWtmUHB0R0paRWJ1aVo3Z0lMMjBmYTdveHdES0s3Q0VqbFVQUElnVkZKNHVE?=
 =?utf-8?B?THBib1ZpN0NNVXJRTm54em4zQTR6dVZqdjRCUW1kOHRHd0tTZ2hMakVkNzVx?=
 =?utf-8?B?RzQ5czFQeTBCeWZRYUJqNis5UjBVR2d5dFJXNGdNRlgxSzk2VGlERjJCVjli?=
 =?utf-8?B?MkVTbTlGUjlPOGJVZ1l5NHNCTGJRTmloZE5rUFZjYTZKSkl3OHU5R043VWRW?=
 =?utf-8?B?RytneTJ2OVJZRzhFaVY4NmpDSnpBQ2lFSm1Yd0ovSlVoUWlpSzg0SjBheXBF?=
 =?utf-8?Q?NEM+TVOPQvj43gwlNp+w2KkeLvAvAGw6hHxJI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUZNMFlIemtsZmErbVRuTTdERGFsRTdtRkp6VDIxN2xRbEVIZ2tCajJITkpo?=
 =?utf-8?B?Q2h4MkZxZHgrWlRnbWtuazAveE5YRlJ2QnRGSlRwckY1RTUyRnIzZ05OVS9z?=
 =?utf-8?B?SXFZVCtPV3ZVV0Q0cnlpT1VjRXcyQnU5ZmxGbnhxV3BNaTMwek9GSTFqUHZy?=
 =?utf-8?B?ZDFEUit2MzZPNDVGalU0K1V1T0hsa3p0YTNuK0ladjZVclhtbnRJK1VvcXkv?=
 =?utf-8?B?Q2xhTGMvZy84M1orUzhzd0R5NDh6OXE1S1ZaKzgxblFzMnRycDRWamtlbysw?=
 =?utf-8?B?aGE5cVhqWG41ekdIVkoxeU5GcEswTmdMR2J4bzhuNW9ZQmpubFBVZ051aGNj?=
 =?utf-8?B?SCs5dmpGb2lXeXJSQ1JhTHJaWTRpWEJxZ2pzbUNjcG5Fc3U1SHdoSjZYYXl5?=
 =?utf-8?B?b2V3cFY5TjZJWjFmVjJ4TWd4eWtWK2NBZlFXTFg0VkduVDBSMWtrWkY2S0h0?=
 =?utf-8?B?WVRacFo1R1JBMEsxZnBUcVNmNDZVUmJQL2w4YXFHRE1LTkg0bmdZOVI1YlF0?=
 =?utf-8?B?MDRYS0cwT3pFamZlVHk5c3RjUUdIN2laOS8vaHlDYm5zUjZRQWVnWDJDZ25D?=
 =?utf-8?B?Wk9GdkxsVE12OGd5N0YxTkNPekhHL2c0UVJzSkNlcXByc1JmMVRvUTIrNTVF?=
 =?utf-8?B?KzRCQ3JhYytHd3hCZVpWSVRLYkRoZVlyVHBqeG1hWmU4ZG5BMGowMTB0ay90?=
 =?utf-8?B?Z0haNG94TlViOVBtZk5kSzJ4azI2N1JhbGt2V0Jkd3BRaEE1b0JDbStHZ1VO?=
 =?utf-8?B?bUswOUV1czRrQnQ1MzYxYWFaa2hnVG5neTZ5M2duZ0FOSGRHa1gvU2RQbUti?=
 =?utf-8?B?aTBpUW1wRHhOWHpwMzRUemw5OVRSTlhtdjNuQno1MGNQQTJ3MmhqQ1N0M0JT?=
 =?utf-8?B?eDRSU0lGeEZUK3dYTzRneWFJYjBYd1RQMVBud1hYUmYzOGg1ajN6V09aMXNv?=
 =?utf-8?B?dENUZ28yekd1RlZQZDQvZjZQOXRFSVIrb0VvaU5uaU9XV2MxcmRVeW52cUVH?=
 =?utf-8?B?WFIzeTlEMGRkL0lxeHpNTGN6ODA0UWxOUjVQYTZuTVo4a2l1NWNEblFyV3Ax?=
 =?utf-8?B?STBHTjh5RGE5L2NDb0lSY0JISDkya0ptUGN1eHlkdFdwTnR1SVdGNVE0RmQv?=
 =?utf-8?B?NFRscmpxNU9UWno4ZWYzTXV4c2wyOWhDOTBnblpTa3F3cW5MekgyVDhxa2oz?=
 =?utf-8?B?WlBVbWZOQThYYUFBVWhuQk83NTNmeHZ4dys5VFNlN3ZxMENBVmNhdmZNQXdN?=
 =?utf-8?B?V0tRY1k0Sys4UlFmMlQ3S1N2eXJvRDFhOEVXWmQ1d1dZMHFUWnBBQy9JbVlp?=
 =?utf-8?B?aHhXbzJsTldHSW1VS1lZd2x5aUVpQk81TFVrMEZhUjFBZURuVGo0LzFVQjRF?=
 =?utf-8?B?QncwVExSV3ZGU2pRUWhhY0pmWjhjOFZWdU5CbHFlencrM2s0aEZ2M1Vhdzg3?=
 =?utf-8?B?dUgxajRkMHRYWnE4dnRRLzc2TXdQN05UdHBzMDdOSUdJVWpRZVMveW84aDVM?=
 =?utf-8?B?dEdwV3hERzJWOFROUmdITjJ4cVFQMVJ6QWtLVUdSTVpIdE1ySmorazM0dE95?=
 =?utf-8?B?dHlyUW0yUWw2UFpOV1FHZXN1bFNQTEdvb3pMN1pTTHRXMWJtYmRIS1huOU10?=
 =?utf-8?B?RlJvL0hEbUhvVldsME9MSWxPbHJML1BEWC9TeG1yeHBxVDRhU0s5d3VCbzR1?=
 =?utf-8?B?Q2RkV3VXTnRlQXhZMFVBKzVGSndUVVdqQk8zTGxYcHRvZWthcnZDQVdqa1ZV?=
 =?utf-8?B?d3FEVVFkRVBHQnZOZUxWZll0TVlROGNYNzYyZ0Y2L3l4Mzc4TlI5b1V2QXla?=
 =?utf-8?B?citZVXl5VjZnY1dLdUNUczd3eWpjMk4rZjk0emJvZnI5UkIxWHA2TzRSWCti?=
 =?utf-8?B?MG1zQ0V0cVgrRTNhSnFTWVQ0QnVsWGloODB2QW83aVc3ekt1NUR2elBiRXlr?=
 =?utf-8?B?UFpNQ2ZMMEhBa051dmZWQ1RJUU0yZ1BkeWxYVVUrbGwwS0NhQUNhTUhPMUpz?=
 =?utf-8?B?VUVXSGtvOWx5UEJ6Q3VnNnpiNHpTMUFoVi9wZnBUbWxrQjcxcVFITm5RcUJD?=
 =?utf-8?B?Mmp4VHY4NXVPTG4rd1VhUEQrekVxU3UzeElaYk9qenJMKzJ2UDVGV1ZNSDho?=
 =?utf-8?Q?riqU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf9cac0-7f7a-42ad-7543-08dd021fe51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 07:10:16.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KScjRKB/Vn1XCdkO/iS/Upt9zhrkDRlyT+1UZuW1mTOAaOIckTnPv/TW5Pj+PVHf40R2L42gLnF3HBW/wPQOBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8292
X-OriginatorOrg: intel.com

SGksIEFhcm9uLA0KDQpUaGF0J3MgT0suIEdsYWQgdG8ga25vdyBpdCB3b3Jrcy4NClRoYW5rcyBm
b3IgdGVzdGluZyENCg0KQmVzdCBSZWdhcmRzLA0KRXZlbiBYdQ0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPg0K
PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDExLCAyMDI0IDM6MDggUE0NCj4gVG86IFh1LCBFdmVu
IDxldmVuLnh1QGludGVsLmNvbT4NCj4gQ2M6IGJlbnRpc3NAa2VybmVsLm9yZzsgY29yYmV0QGx3
bi5uZXQ7IGppa29zQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBaaGFuZywgUnVpMQ0KPiA8cnVpMS56aGFuZ0Bp
bnRlbC5jb20+OyBzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbTsgU3VuLCBYaW5w
ZW5nDQo+IDx4aW5wZW5nLnN1bkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEg
MDQvMjJdIEhJRDogaW50ZWwtdGhjLWhpZDogaW50ZWwtdGhjOiBBZGQgVEhDIFBJTyBvcGVyYXRp
b24NCj4gQVBJcw0KPiANCj4gSGkgRXZlbiwNCj4gDQo+IFNvcnJ5LCBteSBmYXVsdC4NCj4gDQo+
IFRoZSBwYXRjaHNldCBpcyBhcHBsaWVkIG9uIDYuMTItcmM3Lg0KPiBCdWlsZGluZywgd2lsbCBs
ZXQgeW91IGtub3cgdGhlIHRlc3QgcmVzdWx0Lg0KPiANCj4gVGhhbmtzLg0KPiBBYXJvbg0KPiAN
Cj4gT24gMTEvMTEvMjQgMjozMSBQTSwgWHUsIEV2ZW4gd3JvdGU6DQo+ID4gSGksIEFhcm9uLA0K
PiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uDQo+ID4gVGhlIGZpbGUgImludGVs
LXRoYy1ody5oIiBzaG91bGQgYmUgdGhlcmUsIGl0IHdhcyBhZGRlZCBieSAiW1BBVENIIHYxIDAz
LzIyXQ0KPiBISUQ6IGludGVsLXRoYy1oaWQ6IGludGVsLXRoYzogQWRkIFRIQyByZWdpc3RlcnMg
ZGVmaW5pdGlvbiIuDQo+ID4gSSB0ZXN0ZWQgaXQgb24gdjYuMTEuDQo+ID4gQW55d2F5LCBsZXQg
bWUgZG91YmxlIGNoZWNrIHdoYXQncyB3cm9uZyBhbmQgY29tZSBiYWNrIHRvIHlvdS4NCj4gPiBU
aGFua3MhDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gRXZlbiBYdQ0KPiA+DQo+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEFhcm9uIE1hIDxhYXJvbi5tYUBj
YW5vbmljYWwuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDExLCAyMDI0IDI6MTkg
UE0NCj4gPj4gVG86IFh1LCBFdmVuIDxldmVuLnh1QGludGVsLmNvbT4NCj4gPj4gQ2M6IGJlbnRp
c3NAa2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7IGppa29zQGtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiA+PiBkb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcjsNCj4g
Pj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgWmhhbmcsIFJ1aTEgPHJ1aTEuemhhbmdA
aW50ZWwuY29tPjsNCj4gPj4gc3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb207IFN1
biwgWGlucGVuZw0KPiA+PiA8eGlucGVuZy5zdW5AaW50ZWwuY29tPg0KPiA+PiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxIDA0LzIyXSBISUQ6IGludGVsLXRoYy1oaWQ6IGludGVsLXRoYzogQWRkIFRI
Qw0KPiA+PiBQSU8gb3BlcmF0aW9uIEFQSXMNCj4gPj4NCj4gPj4gSGkgRXZlbiwNCj4gPj4NCj4g
Pj4gSXQgZmFpbHMgdG8gYmUgYXBwbGllZCBvbiB2Ni4xMi1yYzcuDQo+ID4+DQo+ID4+IFRoZXJl
IGlzIG5vIGZpbGUgaW50ZWwtdGhjLWh3LmguDQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IEFh
cm9uDQoNCg==


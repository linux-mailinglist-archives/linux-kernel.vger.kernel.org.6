Return-Path: <linux-kernel+bounces-561994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24589A61A09
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBD47AD990
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB04204C15;
	Fri, 14 Mar 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsYkFuiz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8892040A4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741979043; cv=fail; b=OTH7NuCskfHTX082a/Y6dS4FO0pReT5kP7oBCHPA3m/xqT+jiVzRv2IfIWmv2clfW+LwBfPpw6ufN8pQkV7YPOwD2Gr1OJMaKi/H4RvjjDYSTgxdZtQW3DETuZmPGR+27Slt2meERTL+me1JD30nWL7mKBftRrWEIZclel6udQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741979043; c=relaxed/simple;
	bh=woihsvJ9/St9v9J6LYsTI2uxT1mWS2FH3SkVw2j5cW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lc3C4sKqVlgXd23hxLOlVUk9j2BGYMCyf9Q6VuEwORy7yZHND+aGjGARrHdxpK3a7/CTyahegeGMmqdN2FhDF+b1jyUDw8DtKNJT0iOezrgOLBGZLaw6emE+di2DV3nEInuMHeL8Sl9A4KA65PnhsnS9oL8WO6QrNNIZRj+nYDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsYkFuiz; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741979042; x=1773515042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=woihsvJ9/St9v9J6LYsTI2uxT1mWS2FH3SkVw2j5cW8=;
  b=TsYkFuizLjiGeuvSfM7pteMo6ZRlDJS864pKHMe/xyg4LWtTMP8D6Uy0
   ErHfQ2AOopOBISfdwtInbdKolk1ni/g2FedRZ/lS5yesRd0tRooQNO4IN
   2uWKtAska87ALuhLL02+oW7CVgjCjA9rG3yNr9+PyfeT1e+HDryIWwV3l
   TuAGPi7cszDuWoMNHlk3v7HBJdrN9tGHcLJsOijStvvFC2x8HlOdsmtGT
   LrXsWx/rrdht9fDGy9OvjIq7CCexuoMrPLRA2n2VYJuL7y8wg0+8s0Xu6
   xVxSoo8kk/f3pNLuvg96iTx/l6tOfWOoMfehUvOVszdylvW23RtnrkAut
   A==;
X-CSE-ConnectionGUID: iUhA+x07RcKBvwj1uO07OQ==
X-CSE-MsgGUID: vB6Qo//fSDaOaXQA2eOkNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="53796834"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53796834"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 12:04:01 -0700
X-CSE-ConnectionGUID: WQo+OoQ9TyKj39Tz6DtYOg==
X-CSE-MsgGUID: tu+r5hVyTZeue0WF3vq+jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152302174"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2025 12:04:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 12:04:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 12:04:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 12:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYOZk4bcnGC8ue+GqQyQo4Ib3zuE2ZxD2Zt7yGUF/yU1WF6K6dwGNsOn4Hax3xdS5Znq8aGrerY3JP1vlOZjqD6ws/9w2DzQI5o7KGkvKSr9INBbpTT/HrmhdiYjx+rbeWgYJ5FvqyEPkRyhTkUx0suv7IQntOLS2HyCNHapWcZSYfxXmPPOo/dB5my/moZz3CKYCiPCOxDNri4O+smsVbVU7MczS4v/SkE3Q36l3HwP0WUeAkvV06wUSI/ZdiLwJI8TxuraOzx8ErY4bU20hco++CzJ/ej8cTY9LcYGAyPWuyQUqImTEzIHdiBlfDJYyNIHqfqwTcNkGw+FMYfECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woihsvJ9/St9v9J6LYsTI2uxT1mWS2FH3SkVw2j5cW8=;
 b=O4q4dgNl1zqilw20vzucN4BaNQtt1B0wbvtdbybQNvvBTQmmki+LYQegvvCNIXpedaQQ97tzlShyQyc/HM2ij6xj0++iprT5yebuDtWZOu/les/68lypm73Jhn+Rxs3SI39mSK7/DviDs0x0b9rcNJMRFdZlU1cNimBJ7K0Eu9lL3MqiP98xY29yQQkREVy+eypysZbXDyV2nmSF6sa/n5qK1vW8HnUBbnTRDIpPYM+tUUUGFfatnXL1p2NVR37ugleGAMLKPm+4FpXurgBEd79B1sb5UjidNfF5ECnsNUnidZCDpDGKvnmfJhJdEqixUJhWuayXqDhFPXxBaCxtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6100.namprd11.prod.outlook.com (2603:10b6:208:3d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Fri, 14 Mar
 2025 19:03:56 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 19:03:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org"
	<x86@kernel.org>, "sagis@google.com" <sagis@google.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Topic: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Index: AQHbk0LJuXFYy0Gh0U6rXIUsBiIijrNwJfcAgAAZYwCAARH4AIAAV+KAgAAEGYCAABOhAIABQDMA
Date: Fri, 14 Mar 2025 19:03:56 +0000
Message-ID: <a6b3a87eba30fdb79423306da538b9c8bb7b8634.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
	 <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
	 <e1b3da33446178861ca34e61675f184b439101e2.camel@intel.com>
	 <5e736c6d7794b8642d020350e302ead0d6ca13ae.camel@intel.com>
	 <da02e1d5a489526770ec737eac41237226cdb5cd.camel@intel.com>
	 <e7b259b0a986f3cf1578b000f9113933ef80a324.camel@intel.com>
	 <1a6b44f3fb23d0a35bb3c24d755fb2ae6f74b1bb.camel@intel.com>
In-Reply-To: <1a6b44f3fb23d0a35bb3c24d755fb2ae6f74b1bb.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6100:EE_
x-ms-office365-filtering-correlation-id: fc45cd65-9e60-4ce2-0564-08dd632af87f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z1cyNHdPRjhtSXdYWnk0NFIvbXBWd3NHbXAwK21KZzd1a1BTdkJlLzFabDNk?=
 =?utf-8?B?YTJ4bnV2d2VuenF0eHRNckVxQWpSbkIxdkp3WnpxTmwzQ3U5UldOT1htY2Ft?=
 =?utf-8?B?RUJ6ekpoSS8xbzR3TnBZeTU5QW9EaENmRTYwZUcrMVRlenRkTnVISTFqMTlV?=
 =?utf-8?B?S0dWNmppYXJkbWJNNlNPWUtUK0FhOXJNY2ZMT0ZtWldoTnE0ZFRvbTRPY3p1?=
 =?utf-8?B?WkxlWnhnWWZ2dWZLYmkzRWRreHlBVTRuZ1VWV0ZONzRSb1BKRFBqSmt1N2w4?=
 =?utf-8?B?UmFMcjZjU2tFUG9FUk9WdkZyUlNaeXRDcWo4RVFvbzJUY2JWMWtlT0tGT1dX?=
 =?utf-8?B?N2hwQkRPWW0yUU03WEdBTXhoOXQ4c3F4MnYyeTR1bVdZYkIyMEVmWE11Szhr?=
 =?utf-8?B?WmRtR3R4aXZaMmZ1RTgyZjV3OGhwTnpLZVhPS0FNSFh4OGpSaUo0cjhaODJE?=
 =?utf-8?B?L2JkcjhEandXdDFRUG02dlZGQzMzMjJuRDRhL0Jta2xFYkdqSytUSldLYzQw?=
 =?utf-8?B?SUlFRDFRQUNVejJ5VWZ6Z3Q3dzgvb2NNUkc0L2V2Y0dOcTJZd2dLdFdoNzJZ?=
 =?utf-8?B?N3dKbEx2SWw2ZHNCcjJudWFBWGJyRXl5em9PRi9QNXprd0FOcTUxaDNBNm1k?=
 =?utf-8?B?YUUvNGhQSmZnVFpDQ1ByaE9HVUpmQ253aWY5N0lMUWlVT0dSeDQ3NHMwamZN?=
 =?utf-8?B?d1F4WjZGdE1PanlzOEhBZXRXL084UTZtMmJJenpkMVR6MWgzbndPMlZzWGdN?=
 =?utf-8?B?dFZaRVZVV3VUZUluekV1QVdhU1picW55SHRuS0I4NFNUQ2pLVGFyYWhZMmtx?=
 =?utf-8?B?czdkNXlzbGo5VGhYWUY2UVBVUHY0L1RGYzdrYWhuRXhhK2FHMGQ2bGN4ZDNt?=
 =?utf-8?B?cXZIU3QwcFJ3OEQ0SVdZYWFZM014Tmx3WXlFT0hjNUVqOTlldStvMlJpSGdw?=
 =?utf-8?B?RGJqc0xaZHZGSFp2WTJCQmEyNzBNLzFweDd6dk1EQk5Yc0M1L0lLeWZSdHkw?=
 =?utf-8?B?b0hBOE8wUE54d0creHJMRWdPL2I2dG9GZzQ0NEJvWStFa1hxa3FCVFcrdXRm?=
 =?utf-8?B?MERhcm1nMmxsRStZZkdhMDBFTytCQ0h6RW9vd2tCWWY3bHlMNmVlZ1lCQmlO?=
 =?utf-8?B?S082bTNjd3VMZVdJS3RkZ1FMMXJSdW9IQUxVdTU5QzI0WnhkQmdjNzVObXpK?=
 =?utf-8?B?RHNsemVXbHZmd0tXU2NIeFQ3eHcvODk2RXllOHJ3KzlrK1loS2kvekhkN1Yr?=
 =?utf-8?B?dm9KYm5mdVovY0RlWEJGSG9VNktqKyswSXNaN1ZOMmovbEd0RUhoYjBlNkly?=
 =?utf-8?B?NGdrTGVYZU5velVGODhrUVh6akxoSTVQVWp3ZEhPUDlRM0E4WFJrVFk4T1Y5?=
 =?utf-8?B?ZHVIY3lxaEVjdlM1bzhmYURrUU5iemNiaHpwYWJGZTNZY3JLQ3V6MVpsVWFJ?=
 =?utf-8?B?YVFDT2NhQmpaTDROUmpkemt0UENmY09qbHZ5cjE5c01WRjEzU0JJZ0ZXcnZJ?=
 =?utf-8?B?Q2ZITFBZODZFRFpJSXJoU2N0QS9BeTBodDU5L1hxMGhYTG5HakxDZG9kUnZH?=
 =?utf-8?B?WjNYdEhOUXdQdC9VeUZpT083U3h6NUNmbWZzNjgxV09GQ2VHbWlnQXEzbk1y?=
 =?utf-8?B?ZWsrZnloblhhR1R0TXZzSkN2anBtdTIzMUtKdTVnZktLWUkycFV2TkdwWXRY?=
 =?utf-8?B?R3htMEpnR3Jhbml0NERiL05BdVdvOEJkdnpPTGtFaTN5WU4vRmxhcjJqMGxj?=
 =?utf-8?B?RkVzS1B3dWcwUVgvZmpLWXRxeE56OGJ2bXZNR1FTbk1Fc0tHZEt6SnRPVUMr?=
 =?utf-8?B?dDNWMFdKczZkVHplRlJiTm9NQlNrbWdEdm9kSDZoQk5JMU1KTEVYVytTZ0p5?=
 =?utf-8?B?K1hVWjBDQlZ2ZjVJWUhmQ2FySXFuV2VqMGZaRVp5cTk2VXhGOTlrNUprMEp6?=
 =?utf-8?Q?zTsjJhCa/BT1hALwYgcdM1fgLHGYvWuC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2FXYzBPeVdESXlIMFR3blNIWWxPSTRTVEMrRWdpOC9aN0Jzb3hZbHVOcUFz?=
 =?utf-8?B?NXl0WEpERXl2VkdVV0FJOWpMR1JxYVNaQk0rQ0dtSjFXa1ZMbGsvak1nUzBV?=
 =?utf-8?B?RTVOMTdleEliV3RpZ2xqb2s0NGdOd3VDUVBDTTZoUDRVSzJ1NUpSeUpTN2NT?=
 =?utf-8?B?VkhOSzhrc3BGdktWZTZhVGRNZWxOckZ6WmNDbFRFS3I1SEZKZ3VFdHBCbHps?=
 =?utf-8?B?K25WSTFxbGJTb01pcE5lVkE0K3pOdVgwVDR4TDNRMGcrOVNNWFU5Wi9NNDdS?=
 =?utf-8?B?QmU4TDl2WHFsWXNVL3BEYWRHYnN0cEtHY1paclhFV3Z1TjNjSWk3TEsycW1V?=
 =?utf-8?B?Z1UyM2d2azQ0dzhGU3V1alBBTHlicmlUZk5oaTBYeHAvbWViYlA0dzI3UWtM?=
 =?utf-8?B?V2lQakhIOFlqYUYxakNKeW1Qajh6aCtwdGNQVXlDN1FMa1UzYnN3VUI0UWtr?=
 =?utf-8?B?dWVnVmxzN1pZYmJNQWl1SlBUYmVnR1VXYXFqMFZ6Mk0xV1RlWVF4OHlUbVJ1?=
 =?utf-8?B?T1pkcjIvK214aWRxbk5aQ2w2TUsxVWpOQUF3enRQSU40TXRhOWVJNkprbklP?=
 =?utf-8?B?SUdNZ3hhUFBzUklkREFFWUw5WERKUjVuMTEwMzlSNDBNOXpNeWg5a1lYeVda?=
 =?utf-8?B?akZ6UlAvU0tPckEzcUZITHl4Sm5oVStxTmpOT2pNY0p3bVhHR3B0OWNTUkVK?=
 =?utf-8?B?K3pqendJdGJQUDhySFNNVUs4WHdOTE4zNzdkNUF1UUk4TFlDdmlaWXYwM2lD?=
 =?utf-8?B?Sm16V1hITzM1Tk9rRWJhNFpLbDdNNTU4dGhoS2ROL2x6NUVFaHlVUTF2WkZy?=
 =?utf-8?B?NU8wMW80K0RUTUoydFZMM25CZHFwRXg5NUptSlBhdkJtR0Zna1Q5TXlZdFph?=
 =?utf-8?B?Qk9OR2hBVU9ZMUViUk5qVk5nSVVRYVdHUmpDa0x2cTJiT0RpMWpWbndkS0FQ?=
 =?utf-8?B?VGw2bjRnRXpXVXZDWmtFOFp2VVBLa3dGWS9MUDhQRVpJRksrRkxiKzlxcTgz?=
 =?utf-8?B?ZzJsOEcyOXJvVU8yVzhuSEU1WmMvN1FuSlQ2RXE2ZVZGSUIyS3d0NjlraHhC?=
 =?utf-8?B?RTFNcjV2VDZrL2lPT2xWSHN6WTAvR0hLRXJzcC96SWZqYjZ3Qys1YTlPZUV3?=
 =?utf-8?B?bFJNaVRDNEtFdjVVUXpNQ2RBYlRiVERuL1JPWkdWZFArS2JBa3p0TlJJSEph?=
 =?utf-8?B?NHRRZjBOQU1ZejROT0s2ZnBXc0ZmZXZERjFXODd3QThoN0pEYm5GdTlTQ210?=
 =?utf-8?B?RjNZVC9uUlBEaDk3ZFpSeVJNeEpTaDZXZjBzR1d3UHBkU29UWEJjK21jWUJO?=
 =?utf-8?B?RGtvU0NLSktnNmhhdEhwTDRmeUg1Ynk2ZkVtejA2Rk1oYkxxNlJocmIzaTRl?=
 =?utf-8?B?MnB3Y2FhVEdpeFhnaTJicVNBTFZFMTdscC9uVGlDMTlMVW1FclNtcFM4ZTFV?=
 =?utf-8?B?SjFuM2FnMndsZi8yTndwemgvQzBUbDZNb3hNU3pGdE5ZYU1GWjB4MURka2FM?=
 =?utf-8?B?VGpnemY0dzlnSzVoZmF1aDZFeEptMkI1YTNjRnIyS1hJYnRrYnh5aGp6dGVy?=
 =?utf-8?B?LzFLbU5vUHFCYWJnVzdZZHpZNU9kYXZsSldIL2F2QlZGd1dSYUE4ZHdUYnNV?=
 =?utf-8?B?WnMvS3RVa3VjQmFmRFBuK0pyelI4bkVLeGIycHpGa0NPTTh4Y3RobDJJSXN4?=
 =?utf-8?B?cGJpdmJSNndVbkYrMDRSWXF1VEg0OWZCVUlMa0RvSUMybXJEeXBjUklGb1lK?=
 =?utf-8?B?QmFGcFBqN0gwYTcwOFdKaU9nNkNwaHJ0elowTUxDZVBaYm5tazJWMVEvdmZT?=
 =?utf-8?B?cDNZUmRCRy9nRG5IVTlxRWtKcC96YzVVWDlUdEFFMWN6ZEcrNmp4OVNZYUNx?=
 =?utf-8?B?TE9rWHRyUjNVaVhXSzdGRlFqRDNRMTNxRG1TdStoaVQ2YjVDYUszVFdYYm1i?=
 =?utf-8?B?Tzk3a2FNUGo3NDhnbDZYL3BWT0EybEhnUlh3bUFFNnpDbW9GS2RLN3hoZThT?=
 =?utf-8?B?QkJwUTljd2FiaGt5UTJrOVB5L2ZISytwQ3NobzcvZFBoY1BEWmJhRWV4V0Ri?=
 =?utf-8?B?cnlvbjgvNW9JUWlYR3dTZlVPYVZTZWYyRGpWNzFWMFd6STNlbERENUl5Z1R4?=
 =?utf-8?B?OFRkek5CUTVkU1ZJWVhocXFTWmxCT0w3SXcxbXdmRW12NDJDMTFGOUxORVYw?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F420533285F8CF4081AF4402D2183C0B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc45cd65-9e60-4ce2-0564-08dd632af87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 19:03:56.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuDVRyn0KMex+SLoIOK7WaWOjG05wiYOryJZbZ7Df4pBfmKNj3a4Jk8AQXbzluBUntfzvIIIL6yukPyTFJ80EtRjrit72zE3H6EDX7RFVM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6100
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIzOjU3ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IFNvIHRoaXMgd2lsbCBzd2l0Y2ggYWxsIG9mIFREWCB0byBiZSBkZWZhdWx0IG9mZiB0aGVuLCB1
bmxlc3MgdGhlIGtlcm5lbA0KPiA+IGdldHMgYQ0KPiA+IHBhcmFtZXRlciBzZXQuwqANCj4gPiAN
Cj4gDQo+IEN1cnJlbnRseSBpbiBLVk0gVERYIGlzIGFsc28gZGVmYXVsdCBvZmYuDQoNCkdvb2Qg
cG9pbnQuIEl0IGJlZ3MgdGhlIHF1ZXN0aW9uIG9mIGhvdyBtYW55IGNvbW1hbmQgbGluZSBvcHRp
b25zIHRoZSB1c2VyDQpzaG91bGQgaGF2ZSB0byBwYXNzIHRvIGVuYWJsZSBURFguDQoNCj4gDQo+
ID4gSW4gd2hpY2ggY2FzZSB3ZSBjb3VsZCBhbHNvIGp1c3QgdW5sb2NrIHRoZSBLY29uZmlnIHdp
dGgganVzdCBvbmUNCj4gPiBzbWFsbCBjaGFuZ2UuIFREWCBhbmQga2V4ZWMgd291bGQgc3RpbGwg
bXV0dWFsbHkgZXhjbHVzaXZlLCBidXQganVzdCBhdA0KPiA+IHJ1bnRpbWUuDQo+IA0KPiBZZWFo
IEkgYW0gdGhpbmtpbmcgdGhpcyB0b28sIGdpdmVuIHRoZSAia2V5SUQgMCBpbnRlZ3JpdHkiIHRo
aW5nIGFyZSBzdGlsbCBvbi0NCj4gZ29pbmcuDQoNCllvdSBtZW50aW9uZWQgb2ZmbGluZSB0aGF0
IHRoZXJlIHVzZWQgdG8gYmUgYSBjb21tYW5kIGxpbmUgb3B0aW9uLCBidXQgaXQgd2FzDQpyZW1v
dmVkIGFmdGVyIGRpc2N1c3Npb24gd2l0aCBEYXZlLiBJIHdlbnQgdG8gbG9vayBmb3IgaXQgYW5k
IG9ubHkgZm91bmQgdGhpczoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvN2U2MzkxMmEt
ODk1Zi1kM2IzLTMxNzMtMzM2YmVhYTg2ZDA4QGludGVsLmNvbS8NCg0KLi4ud2hlcmUgRGF2ZSBq
dXN0IGFza3Mgd2h5IGl0J3MgbmVlZGVkLiBJbiB0aGUgbmV4dCB2ZXJzaW9uIGl0J3MgZHJvcHBl
ZC4NClVubGVzcyB0aGVyZSBpcyBhbnl0aGluZyBtb3JlLCBpdCBkb2Vzbid0IHNlZW0gbGlrZSB0
aGVyZSB3YXMgcmVhbGx5IGFueQ0Kb2JqZWN0aW9uLg0KDQo+IA0KPiA+IFdlIHNob3VsZCB0cnkg
dG8gZmxhZyBQYW9sbyBhbmQgc2VlIHdoYXQgaGUgdGhpbmtzLg0KPiANCj4gSSBhcHByZWNpYXRl
IGlmIHlvdSBjb3VsZCBoZWxwIHRvIGRvLg0KPiANCj4gPiANCj4gPiBPciBpcyB0aGUgcHJvcG9z
YWwgdG8gb25seSBiZSBkZWZhdWx0IHRkeF9ob3N0PW9mZiBvbiB0aGUgZXJyYXRhIHBsYXRmb3Jt
cz8NCj4gPiBBbmQNCj4gPiB0ZHhfaG9zdD1vbiBvdGhlcndpc2U/DQo+IA0KPiBUaGUgdHJpY2t5
IHRoaW5nIGlzLCBuYXR1cmFsbHksIHdlIHdhbnQgdG8gc2tpcCBhbGwgdGhlIGNvZGUgaW4gdGR4
X2luaXQoKSBpZg0KPiB0ZHhfaG9zdD1vZmYsIGJlY2F1c2UgdGhlcmUncyBubyByZWFzb24gdG8g
ZG8gdGhvc2UgZGV0ZWN0aW9uL2luaXRpYWxpemF0aW9uDQo+IGlmDQo+IHdlIGFyZSBub3QgZ29p
bmcgdG8gdXNlIFREWCwgZS5nLiwgd2UgZG9uJ3QgbmVlZCB0byB0aGlzIG9uZToNCj4gDQo+IAly
ZWdpc3Rlcl9tZW1vcnlfbm90aWZpZXIoJnRkeF9tZW1vcnlfbmIpOw0KPiANCj4gLi4gdGhhdCBt
ZWFucyB0aGUgY29kZSBvZiBkZXRlY3RpbmcgZXJyYXR1bSB3aWxsIGJlIHNraXBwZWQgdG9vLg0K
PiANCj4gSWYgd2Ugb25seSB0byBvbmx5IG1ha2UgdGR4X2hvc3Q9b2ZmIGFzIGRlZmF1bHQgZm9y
IGVycmF0dW0gcGxhdGZvcm1zLCB0aGVuIHdlDQo+IG5lZWQgdG8gZG8gY2xlYW51cCAoZS5nLiwg
dG8gdW5yZWdpc3RlciB0aGUgYWJvdmUgbWVtb3J5IG5vdGlmaWVyKS4NCg0KVGhpcyBpcyBhIHN0
cmFuZ2UgcG9pbnQuIFRoZSBlcnJhdGEgZGV0ZWN0aW9uIGlzIG5vdCBkZXBlbmRlbnQgb24gdGhl
IGVhcmxpZXINCmNvZGUgaW4gVERYIGluaXQuIEl0IGNvdWxkbid0IGp1c3QgYmUgbW92ZWQ/DQoN
Cj4gDQo+IFRoaXMgaXNuJ3QgbmljZSBhbmQgc2VlbXMgaGFja3kuDQo+IA0KPiBJIGRvbid0IHNl
ZSBtYWtpbmcgdGR4X2hvc3Q9b2ZmIGFzIGRlZmF1bHQgaGFzIHByb2JsZW0sIGFueXdheSwgYXMg
bWVudGlvbmVkDQo+IGFib3ZlIFREWCBpcyBvZmYgYnkgZGVmYXVsdCBpbiBLVk0uDQoNClllYSwg
dGR4X2hvc3Q9IWVycmF0YSBhcyBhIGRlZmF1bHQgdmFsdWUgbWFrZXMgaXQgbW9yZSBjb21wbGlj
YXRlZC4NCg0KDQpTbyBJIHRoaW5rIHRoZSBzaXR1YXRpb24gaXMgd2UgbmVlZCBhdCBvbmUga2Vy
bmVsIHBhcmFtZXRlci4gV2UgYWxyZWFkeSBoYXZlIG9uZQ0KZm9yIEtWTSwgd2hpY2ggY29udHJv
bHMgdGhlIGxhdGUgaW5pdGlhbGl6YXRpb24gcGFydHMgb2YgVERYIHRoYXQgd2UgY2FyZSBhYm91
dA0KaGVyZS4gU28gd2hhdCBhYm91dCBqdXN0IHVzaW5nIHRoZSBleGlzdGluZyBvbmU/IEkgdGhp
bmsgd2UgZG9uJ3Qgd2FudCB0d28uDQoNCklmIEtWTSBoYXMgbm90IGluaXRpYWxpemVkIFREWCAo
YmFzZWQgb24gaXRzIG93biBURFggcGFyYW1ldGVyKSwgdGhlbiBrZXhlYyBpcw0KZmluZS4gSXQg
Y291bGQgd29yayBieSBleHBvc2luZyBhbiBpbnRlcmZhY2UgZm9yIGZlYXR1cmVzIHRvIGJlIGV4
Y2x1c2l2ZSB3aXRoDQpURFguwqBTaW5jZSByZWFsIFREWCBtb2R1bGUgaW5pdGlhbGl6YXRpb24g
aGFwcGVucyBsYXRlIGFueXdheS4gSSBkb24ndCBrbm93IGlmDQppdCdzIGJldHRlciB0aGFuIGEg
a2VybmVsIG9uZSwgYnV0IEkgZG9uJ3Qgc2VlIGFkZGluZyBhIHNlY29uZCBvbmUgZ29pbmcgd2Vs
bC4NCg0KDQpWZXJ5LCB2ZXJ5IHJvdWdoOg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L21hY2hpbmVfa2V4ZWNfNjQuYw0KYi9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5j
DQppbmRleCBhNjhmNWEwYTlmMzcuLmJmZWE0ZTc4YzU3NyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2
L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5l
X2tleGVjXzY0LmMNCkBAIC0zMTUsNiArMzE1LDEyIEBAIGludCBtYWNoaW5lX2tleGVjX3ByZXBh
cmUoc3RydWN0IGtpbWFnZSAqaW1hZ2UpDQogICAgICAgIHJlc3VsdCA9IGluaXRfcGd0YWJsZShp
bWFnZSwgX19wYShjb250cm9sX3BhZ2UpKTsNCiAgICAgICAgaWYgKHJlc3VsdCkNCiAgICAgICAg
ICAgICAgICByZXR1cm4gcmVzdWx0Ow0KKw0KKyAgICAgICBpZiAodGR4X2V4Y2x1ZGVfZmVhdHVy
ZSgpKSB7DQorICAgICAgICAgICAgICAgcHJfaW5mb19vbmNlKCJOb3QgYWxsb3dlZCBvbmNlIFRE
WCBoYXMgYmVlbiB1c2VkLlxuIik7DQorICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQ
Ow0KKyAgICAgICB9DQorDQogICAgICAgIGtleGVjX3ZhX2NvbnRyb2xfcGFnZSA9ICh1bnNpZ25l
ZCBsb25nKWNvbnRyb2xfcGFnZTsNCiAgICAgICAga2V4ZWNfcGFfdGFibGVfcGFnZSA9ICh1bnNp
Z25lZCBsb25nKV9fcGEoaW1hZ2UtPmFyY2gucGdkKTsNCiANCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCmluZGV4
IGY1ZTJhOTM3YzFlNy4uOWIxZjQyYTEwNTljIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvdmlydC92
bXgvdGR4L3RkeC5jDQorKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCkBAIC0xMjE1
LDYgKzEyMTUsMjEgQEAgaW50IHRkeF9lbmFibGUodm9pZCkNCiB9DQogRVhQT1JUX1NZTUJPTF9H
UEwodGR4X2VuYWJsZSk7DQogDQorYm9vbCB0ZHhfZXhjbHVkZV9mZWF0dXJlKHZvaWQpDQorew0K
KyAgICAgICBib29sIHJldCA9IGZhbHNlOw0KKw0KKyAgICAgICBtdXRleF9sb2NrKCZ0ZHhfbW9k
dWxlX2xvY2spOw0KKyAgICAgICBpZiAodGR4X21vZHVsZV9zdGF0dXMgPT0gVERYX01PRFVMRV9J
TklUSUFMSVpFRCkNCisgICAgICAgICAgICAgICByZXQgPSB0cnVlOw0KKyAgICAgICBlbHNlDQor
ICAgICAgICAgICAgICAgdGR4X21vZHVsZV9zdGF0dXMgPSBURFhfTU9EVUxFX0VYQ0xVREVEOw0K
KyAgICAgICBtdXRleF9sb2NrKCZ0ZHhfbW9kdWxlX2xvY2spOw0KKw0KKyAgICAgICByZXR1cm4g
cmV0Ow0KK30NCisNCiBzdGF0aWMgYm9vbCBpc19wYW10X3BhZ2UodW5zaWduZWQgbG9uZyBwaHlz
KQ0KIHsNCiAgICAgICAgc3RydWN0IHRkbXJfaW5mb19saXN0ICp0ZG1yX2xpc3QgPSAmdGR4X3Rk
bXJfbGlzdDsNCg0KDQo=


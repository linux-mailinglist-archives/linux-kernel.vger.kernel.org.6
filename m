Return-Path: <linux-kernel+bounces-293784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FDD9584A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B599D1C21EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED8918D63E;
	Tue, 20 Aug 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuwCSqip"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3418D63C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149964; cv=fail; b=qqXdla9ea96CoeKKU+8RYhWdyLQhPrQQa0AoqtAKlnad65POLM8jEJCCpoxFmfR81tqCJ78DcJwjm2QH/T3VyxSRS4Oc4YzmZHVEEEocrmMVP11FOaG35lYjYI8V2sF9C5OraZZPfpkzFPFz5Oy42og6dWGSCL7bK3co6u7zHis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149964; c=relaxed/simple;
	bh=vvHxqHhDQID9M/GHXLqU45YlewC7fDd6ol7nLRFJp2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AbtMKPYLoegGr4RJAz9morbNzyrtpjEHcUzEIbgZwlj/NqjeqG6WYTfWPbfxjewdOTcSiNyiyEwJaQ+6o2t+uUPDl4/wbtIGKBbNxTzcAo37OmNPlL55N+Lgn7UnV4o5ET55Ts+HgCZily7wZRVDUVVUdbfpyJ1ZmMvy1VySVpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuwCSqip; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724149963; x=1755685963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vvHxqHhDQID9M/GHXLqU45YlewC7fDd6ol7nLRFJp2E=;
  b=HuwCSqipCKTE5y6DXIDuSAJEFPVVNkrxD0/2XLAm51GX5rpa0jTpHNBs
   JFkw8mCH1U9xf49O9TC5JyxAR71uEepmZKmwpHmq9JVieEv7o6rpJFmBD
   8DLCpYLFnlF5SZ1LNsjVEsTZCfK+9uk+M9j6019VaPIEMLcOnmPhaHvFJ
   Bf5I/rMdimMT5dGEtwhUF9dH4HWabsF273gi7JWFWpmtRVvVfaGWYwhqy
   EhWOCOjueBriT1IBh7e/5geqB40LfyR5bLRFKzT+Povm5a066PFWgbdVx
   1TbglYWHSaOOaLhHKRQ7lSMUHRoN2MD/XvtgJC4bwqZENpTRG9PCfmCKs
   w==;
X-CSE-ConnectionGUID: h7yyHeWiSn+6oAwf8j+rsw==
X-CSE-MsgGUID: 6vXsmez/TeCpmIK9OnmGuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="47834877"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="47834877"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:32:42 -0700
X-CSE-ConnectionGUID: GSI/WLdcSK2wh1QeQszyMA==
X-CSE-MsgGUID: r6AyuGaCQ+GIzxTRrxsEww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="91407165"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 03:32:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 03:32:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 03:32:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 03:32:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 03:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4s5NCylp+OeesSG6jvvWmgU4KD2bkp8vPrUj8KbQUe4AhcYQf2Ajyf1eHkxzBemwLYgXPc2USzuEWcIrNC5tqTAA3B8n7tzOrbxBs0eHEpVHXKxti8THHgdkarVyZxDVfFITldCYzB/zNuWV6/eap6Lg4xJId2+5JmdnxWXXShJmKW2W6uaMYIz3UKnj+ELrW8BK/hPuf/f9C8X9AwodBSbKIr60uYGt70xoKGGQxXBSiLaMPaEWPxhMtoFS78cKTn3uq1gwO8PM4hn989dgtO8Z5fN0yQ2kBO11pMDt5yirBvTC7QGsunLwHr9+s1/SFRC9EjuByvBrODZUf3oiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvHxqHhDQID9M/GHXLqU45YlewC7fDd6ol7nLRFJp2E=;
 b=VOQqqvZWEpi8WIX48nwALrYLZyb3h/2uUB+DJqSoWxuM1VJjeni1npyb2+ampGCPc/f6iIgtQ4k3CIlKKKgA2AFSh7qMVJMejCfGpIKFqXZp2p40eNF8oV6+EqmiWqHqAVIdfyBT93kK8UEiM+kmG2k+qfSzYIM3DJkrLH+E38ERAPLa5dFSrwPLFOiU8y502u3sIqrARXT+nlm8K3gVSKxcBwQ6ikdMN63tiE1MzEXPzUmzswPJX2H28lqy9nOAy8RRhgOHjuAzAu0+AC+/3cPOcCzVPR14HluRH+T6eZYQQ1hp/pG8OYFVIQzMAWWeCn15oEaq084tR1ccu1MWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7122.namprd11.prod.outlook.com (2603:10b6:510:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 10:32:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 10:32:39 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH 1/2] x86/kexec: Fix a comment of swap_pages() assembly
Thread-Topic: [PATCH 1/2] x86/kexec: Fix a comment of swap_pages() assembly
Thread-Index: AQHa8jCNtMAgu1nVoEeKB6LO9+s7wrIv1OkAgAAfQQA=
Date: Tue, 20 Aug 2024 10:32:39 +0000
Message-ID: <4c35dfdadff667ae5ea00dd6002b8cd73301dc22.camel@intel.com>
References: <cover.1724068916.git.kai.huang@intel.com>
	 <d4538576fc5eeab2e4f3ea4c5111dc9597369ed4.1724068916.git.kai.huang@intel.com>
	 <q2y5vte3wwn5qde5p4nfmjfqtzxfen3nhjdyafc7nbirfidpvr@ro3djjz3pub4>
In-Reply-To: <q2y5vte3wwn5qde5p4nfmjfqtzxfen3nhjdyafc7nbirfidpvr@ro3djjz3pub4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7122:EE_
x-ms-office365-filtering-correlation-id: 4d1cfa2f-1c33-422c-a3ff-08dcc1036a50
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3NiQjBnMnZKZ3pOcG1JU3hBbFg3c2lBYWJ1ekE5VVRrYkU4Yml4alk5c0NL?=
 =?utf-8?B?dGNDT3YxaVhtZzArbnZLMUFQUVZFSVljajBMSmJFUHVIL0Vib1ZQYUdzeENR?=
 =?utf-8?B?SU1uRTQyNHk2UGlVUkpRUmFJYVE0L2JiU1h2U1hXempzTjlobmQwR3laNkcx?=
 =?utf-8?B?Ykc1TDRteVBqWWIrZkwzTFhZd21EMFhJZkZ2aS9yRUt6UC8xTkRiWE1EbE9V?=
 =?utf-8?B?Z3pzb3A3cnAzQXU1T05SNVR6NjJwclh1TE42aTFpdEZGWVY5RTZ5SlhNM2pq?=
 =?utf-8?B?cTdVNEdJQU02NGJxR0FWMWhKWGdNMVFqWElwZVpGTmYvUllUUW96ZDhJRXJ3?=
 =?utf-8?B?QmhFNlJXSE1JWjNOb1lGcXJzL3BZNEdTeTVHV3gzSDJRNG9JMGYraCtRcml4?=
 =?utf-8?B?aDVUdXo3ZWFkSGI0UWx4TElsL1NvOTlFNlFpSEVOQ21Nb2RCMGZtR1JSNzF2?=
 =?utf-8?B?QnZaUlJzU0ExcVFlVWZSeVBNSCtFVDExbldIdDdVSFRKTE1lUlo5aVpGakV2?=
 =?utf-8?B?cTJWd2lBd0k0d1BTSjE5a01VdTArSGtjdk5xZnUyQW1kck8xNVJtS1pZUWxI?=
 =?utf-8?B?dTFVckpNdkN1d29yWkpFRmY5Q00wZ2JUV0ZwcmFJNlgxUXpPSlRlaDJ0VnFK?=
 =?utf-8?B?bm9tSXpvWTUxS3lyZnBoVzdvMks4cm0wQkVUYjhHdzg2ZkJTRGtRZ1NpMG5l?=
 =?utf-8?B?RkF6aUJiZTRDbXZGblVmMXNRcmFmY3FESkhvbEFyUVBQOHJzNVMxMThHNm1p?=
 =?utf-8?B?SFk3eXg0K0VuOEY0bXkrQ3FwRDEyOVpkOE9TVmZ4NjFzK3g0YlVmbmFRc0VF?=
 =?utf-8?B?d0hVT2tBbGpYR2QzdUpLbUM2dTdtMWo5eFo5TkE5ay9GdEowSTJNNWd6UGhW?=
 =?utf-8?B?U21qVXp2YlRYSUMrTW1tRVdQTjh0UHZuN2doZ1Y3anN5TkJ5elRjTHN2eGtt?=
 =?utf-8?B?Y0ZBMlNmUzZ3VEFJRk5KeXJ5ZTRHVEQyeGRtMzFISENtSnBZdGVHZVk1bGJk?=
 =?utf-8?B?cTVmVW8xVGpheElHTVJsMjJEVnhXKzlPc3o2UnJwQ2VhbWJzS0NscjhQeDJN?=
 =?utf-8?B?Q3NMMUhsbnpvd0RwSXFoMlpaZTd4VFhjSnBGNVpHYndhY05XeVVRVE1uTnpz?=
 =?utf-8?B?aklPb0dMREo5Qk1qc1k4Vy9QbGc0VEhwM1JFdTN3cW9sM1I5cU1sTDVGMVho?=
 =?utf-8?B?OUR2dktkT3hibHZ5MktTcHNkWkxPVlRaRlpUajJWWWtpbHVxQzczVytCeUVo?=
 =?utf-8?B?V3JmQnJCdG01VG91WktndUlnb1dGMjZDallRdzlxM3FXeXREVzBsbjZPZ3RP?=
 =?utf-8?B?V2NkNzN4S1JnVGVpMDJ1ekZFRkpmbmYrdW55N3l1d0RONjBzUVdhNng4RVE5?=
 =?utf-8?B?WWhRVUtiWWpjUTFyUTJHTnYzdmZENklnOE5DWW90d0sxTU5qTjZTV05jNlIz?=
 =?utf-8?B?QVV3ekJONkVLZi9DS1dGQ2l4STkyaW51S0paNVpvQjMxYTFVd3FvSnYvclBJ?=
 =?utf-8?B?RGZBREthQk91bjUra2kxVGVuMU9wdzA1SThSMFlHTlliTUw0YnlkVUZMRmpO?=
 =?utf-8?B?cFpPMHk0R2tIUzE0WnhLR2VCMktnZDZKWnFIVHhhcTRhZ2wyVlQxR21nOGNl?=
 =?utf-8?B?Rmt5cVNRMnMzVm9WQ3JLQ3RJRUlneDl4MXFMeFNUb1RYS3NnV284VVRLR1NC?=
 =?utf-8?B?YmU3K3ozUGt3TFF6b2pHaDliVm9RQW1YZm9WZnFtLzVFM1JWY3kyT0oxYXox?=
 =?utf-8?B?VlRLVForMzhhd2FFZGdsMUpaWkNET3d1KzlIMWdvRGk5aVNtOGViemZUOEVZ?=
 =?utf-8?B?cDNFSDZXWFMxaldXK1VZLzBpYmhtWGJPVFdmb0xqeUlvZTZYSkdFSzVOaEhs?=
 =?utf-8?B?VGgvcjJEUTk5alR4N0g4RCtnQktJNk12Sjc1WU54Y3AxV1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDY0bVZYZFUzQlU4SFFWblh3b3V6b0dLWE9Zd20wQmZUUjhtbGhzZ2R0QjdL?=
 =?utf-8?B?aEZHYk9wVHF4RXBKK0crVUx2OWJ0aExNWGJNTm5NZEhIbnlsWWJrUXhHbHl4?=
 =?utf-8?B?STA5d2ZkRno3bGx4dlpOL0hIdEFiTjhSUDE5eExQTkNJb3Z6cGNPS0ZRS2F0?=
 =?utf-8?B?UFVNdVFrRExrR3o4a2Ntajl5KzhERGg0WVpCQ3FoRFRQVFVqNFVjY0tSWHhm?=
 =?utf-8?B?UUhtSnNZY2s0NGI3aEljaTJFNVdnTzJ2eDIwemVxTUtPcjZNOUFCVExaRUov?=
 =?utf-8?B?RklmcHFkWnlUbTNzbm51K1RaK2VLSmkySlkxdG5ucXhwVVdwNWJvb29mRGZU?=
 =?utf-8?B?T3hUQW9SWGlaMFlKQ0JVcm5Ed01qMFhLbXNqUmRkMUJMenoyellOaGtIeENy?=
 =?utf-8?B?WmYrRjJ4am0wN2lWVXFVTGNVenJZSXlxa2xMVzhZeUF4enNDbzI4d0NoNExO?=
 =?utf-8?B?K2RzcXgvNEZQd3dFUTFTWTlkcmFzb2tsbSt6L3VaVGQ1dFVSOEZhcTdVUDV6?=
 =?utf-8?B?bDRzbWpuUTRESTlRTzlTOWxDa0tadko1TmJUMnhjM1VwTTY5Z2JYS09wZkxl?=
 =?utf-8?B?Y0U5NWdkWFBOZ0NabjVldFpuUFJkSTgwTlQwaTFlaStjREFLZVlaVERsdDZT?=
 =?utf-8?B?Q3dzaktibnRMWlVvaUZzZjkxSy9rL1FhZDlrRC9sRVk0L3ZPY1NqM0VTN0FZ?=
 =?utf-8?B?Z2xsR1VhMTQ2UHVpVHRGb3ZpSDBxUDk2NGx6VjQ5NncwZE16VjFuVkRvVXZP?=
 =?utf-8?B?bVZGcWpIa2VkOVM3ZUJYbDZtWk9BaHRHSzNRZ3B1dDcxR1NFaS9TcmgrRVll?=
 =?utf-8?B?MFNBL1lXZ1V5NnBZN3JIVVlJTmZnRG9vcGpxZVpxVkNPdFNsOTdGM2FJdTVQ?=
 =?utf-8?B?dHNEMEFFTWxRZGhETjF4c1Uxa20zVWUxT3hEakkzRk00aEMrYUVZUXFJWkMy?=
 =?utf-8?B?V3crcE5EOXNYa1gvbXY1T1cwVGozNWp2TEZXQzJiMVh2dDRxZUdITUVoem8y?=
 =?utf-8?B?bWJwN3k4OXJLN1ZVK1dxc3kzYW1SODg5cm90RnJacHRwWGg2Mm9RL1habTkx?=
 =?utf-8?B?ZnFna1NLTHFabnNnL0t2dDhCNkRkdnZxYTl1N3NjZ2pTMytsZDlacmFhNGw2?=
 =?utf-8?B?RzVPdXZUdktxajNXakliWEM1aVlTb2N4MFl3VGk1Z2VnQXZyUGRUUXhHZ25n?=
 =?utf-8?B?UmhrbFp6WU9KbGhIbEN1dzlVQXd3MTEyY1hRekpLaTQ5UnU3R1dBWEFmcC9p?=
 =?utf-8?B?dmxPcjZBRVQxdDYwM0VFQzVSTnJhSnduSDQzY1lqQXBmTFdZZ2xLZEFSSGdx?=
 =?utf-8?B?TjZaRTVhcjhNOUo0eEdHbExzbWlnTnEwZk5iQklKc1VaMVMyMEVjK2M5NHZh?=
 =?utf-8?B?UFR0TkplWmYxcFR4T1o3c08rL09DMnArOGFTSUN5QTVhWHh2Znd2UUhuZWdw?=
 =?utf-8?B?b1ZwUDNjc0haL01GeXZoWmpnbUlYTm85VEllUW1rR09lZTB1T0hFNWZWdi9X?=
 =?utf-8?B?TktPM052bXJnSUY5QStRU0RDclhGRW03M0tDZC9KRTMyR2FvNG1pdlk1b1Fw?=
 =?utf-8?B?T2NCOVNqUmhXNk5lcXREYnJheVhUMXkwaERlbE1TbXd6VlZWa1R2NDJUNEwx?=
 =?utf-8?B?a3FhOGt1Yk9wekx5YnpGV3J3Ky85RENPdXJWQktldnNneVBwT0hFaGFVNFJx?=
 =?utf-8?B?WW5lSDM1ZXVzdkhvMTJLUlpreEoza2hoUlNJUjJma0VSUzNXdkRGOEpkT0Qv?=
 =?utf-8?B?ZU9yUHVOSWVjc0dvazZMRXBFeHlTblhUQzV5Y2xVTmNaZFE3NFh1ZEhmWERa?=
 =?utf-8?B?ZmVOenArUTZaWVIrY1pDRVZDSFhYRmJucTJuWVNWRTkzUCt2d3RLRXRtUlVu?=
 =?utf-8?B?Slk1Nld5T1VEcTVHK3BMbGQ2OWcrdmNHSVRYRWNSV3NRR1BYZ3k0ZjBiZnVX?=
 =?utf-8?B?SGxMNU1IMko3bWZBUmlVaCtDUC9NK0tSc0sxKzVmOFI4WHdJd0s2ZzRGT29P?=
 =?utf-8?B?UGdpZk9BY1BsdmExMDdyQjRZZEs1Nno4ajNKZE4vTlRXYWFpV0ZWQzJXTEtv?=
 =?utf-8?B?d0ZMdWdtdEpPVEJuR0dIWm02OWRKQm43VDQ3TS9TRU1SSEJkN2pjd0paZ2Rh?=
 =?utf-8?B?NDgvNVZMV1VrbE1Xa2hjR2I3MVdWY2l2ckZ1SUdMMkdTdnA0SmRvdUs0SHF5?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3412FB67414D5E4695434F75B496266A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1cfa2f-1c33-422c-a3ff-08dcc1036a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 10:32:39.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C37tPZby1+V5fTKhc7/O8A29U//FarMJIymEjCID3zTX8U9yvIDbwJ/5NKdh7gj+Pp7xWT3TJqbTNDDXVDwcHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7122
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDExOjQwICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFR1ZSwgQXVnIDIwLCAyMDI0IGF0IDEyOjIxOjExQU0gKzEyMDAsIEthaSBIdWFu
ZyB3cm90ZToNCj4gPiBXaGVuIHJlbG9jYXRlX2tlcm5lbCgpIGdldHMgY2FsbGVkLCAlcmRpIGhv
bGRzICdpbmRpcmVjdGlvbl9wYWdlJyBhbmQNCj4gPiAlcnNpIGhvbGRzICdwYWdlX2xpc3QnLiAg
QW5kICVyZGkgYWx3YXlzIGhvbGRzICdpbmRpcmVjdGlvbl9wYWdlJyB3aGVuDQo+ID4gc3dhcF9w
YWdlcygpIGlzIGNhbGxlZC4NCj4gPiANCj4gPiBUaGVyZWZvcmUgdGhlIGNvbW1lbnQgb2YgdGhl
IGZpcnN0IGxpbmUgY29kZSBvZiBzd2FwX3BhZ2VzKCkNCj4gPiANCj4gPiAJbW92cSAgICAlcmRp
LCAlcmN4ICAgICAgLyogUHV0IHRoZSBwYWdlX2xpc3QgaW4gJXJjeCAqLw0KPiA+IA0KPiA+IC4u
IGlzbid0IGNvcnJlY3QgYmVjYXVzZSBpdCBhY3R1YWxseSBtb3ZlcyB0aGUgJ2luZGlyZWN0aW9u
X3BhZ2UnIHRvDQo+ID4gdGhlICVyY3guICBGaXggaXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiANCj4gQWNrZWQtYnk6IEtpcmls
bCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IExv
b2tzIGxpa2UgaXQgZ290IGJyb2tlbiBieSA0YmZhYWVmMDFhMWIgKCJbUEFUQ0hdIEF2b2lkIG92
ZXJ3cml0aW5nIHRoZQ0KPiBjdXJyZW50IHBnZCAoVjQsIHg4Nl82NCkiKQ0KPiANCg0KVGhhbmtz
IGZvciBmaW5kaW5nIHRoaXMuICBJIHNwZW50IHNvbWUgdGltZSB5ZXN0ZXJkYXkgdHJ5aW5nIHRv
IGRvIHNvIGJ1dCBpdA0Kd2Fzbid0IG9idmlvdXMgdG8gbWUuICA6LSkNCg0KWWVzIHRoYXQgbGlu
ZSB3YXMgZmlyc3RseSBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCA1MjM0ZjVlYjA0YWJiICgiW1BBVENI
XSBrZXhlYzoNCng4Nl82NCBrZXhlYyBpbXBsZW1lbnRhdGlvbiIpIGJ1dCBieSB0aGF0IHRpbWUg
aXQgd2FzIGNvcnJlY3Q6ICVyZGkgaW5kZWVkDQpob2xkcyAncGFnZV9saXN0Jy4gIFRoZSBjb21t
aXQgeW91IG1lbnRpb25lZCBhYm92ZSBhZGRzIGEgbmV3IChmaXJzdCkgYXJndW1lbnQNCnRvIHJl
bG9jYXRlX2tlcm5lbCgpIGFuZCAlcmRpIHdhcyBjaGFuZ2VkIHRvIGhvbGQgJ2luZGlyZWN0aW9u
X3BhZ2UnLCBidXQgdGhlDQpjb21tZW50IHdhcyBsZWZ0b3Zlci4NCg0KQnV0IHRoZSB0d28gY29t
bWl0cyB3ZXJlIGludHJvZHVjZWQgYXQgMjAwNCBhbmQgMjAwNiwgc28gSSBkb24ndCB0aGluayBp
dA0Kd29ydGggYW55IEZpeGVzIHRhZz8NCg==


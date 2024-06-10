Return-Path: <linux-kernel+bounces-208887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0115A902A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6037A1F21B03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3774E1DD;
	Mon, 10 Jun 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKD0v4gs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80D17545
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052748; cv=fail; b=JXCP5xMbVltUd9E3LgZv2Nn7CZQMzot6NhBcub/VVPmIj6B2btlVwKGWyOaXgFlPQ3zqz0+y7UcAzNYZDS5toA1Q+NzD3uio7giGVk9m53sIVE+5u4/dJMrxRsjpqzESdiBrnyiy3O7htMaDBEbsFZ9BU8lUXxT3NHYCsgNnfoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052748; c=relaxed/simple;
	bh=UROqKNKdR0O7nTSfVHBwMqdzetS8K3EtHvmg4CSdoOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TFnX8GhHgQ7/2m6RYNHQEXap2Q7gRhh8ZJGlbqxAERj63r+T4BDJrytJMLCahX3xRxmXy0k5Y9cojHhLjLOboAn04S0SpDR5tU726D6BCBHLG5Ccs0SfSaM+MilY+RT1lylKZdkmK7QcJWTDLO0Ftii2/jH68+SVLe0Ye17dLRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKD0v4gs; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718052746; x=1749588746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UROqKNKdR0O7nTSfVHBwMqdzetS8K3EtHvmg4CSdoOY=;
  b=VKD0v4gs/EcnjQznt4fRqcSnJyyRxzoeyIjBBVaOKF4EG6hwARlh4K3i
   mxj1PmclEIozpUfHTK1arq07IKWPbmZEbPJ+CczTmE5+hhM5Sh4KUkdzR
   AeTK4VRhaVarUXyY/DN+xbTqrtL9Hg6ToLfYP+h8g6WK7lnegXUGxK0dX
   0ua645VbFjqz2o7dvT9kr5YtJXpB8+8anXRUIdUGXyQgT/3KW68uyuJhj
   323ZVJStVD4oAS6DA3jEiRxOEADZeBNXBiYXpgefNxpUwcSklE2iiWTJp
   99f0jmqhBwPrkY5sAR8zYM23t5FIv3IWfLLFzMXyIrBv9YLjsNvGT92wU
   A==;
X-CSE-ConnectionGUID: adyflnZTRo2HKe4sT8bD2g==
X-CSE-MsgGUID: CNIRE8fATzCumjU6KM/bIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="17653808"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17653808"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:52:14 -0700
X-CSE-ConnectionGUID: Ai0gOUHESFmm+3vtZ7zH4w==
X-CSE-MsgGUID: HJEXzXzGTUaN02IDGjcwZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="44318617"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 13:52:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 13:52:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 13:52:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 13:52:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 13:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRUVYzfv3Epsail9qsBG5C47Lr70lsvVXab2x7ixDHhBa91l8rzY0BF96z3f3bG/yz1bmgUE+GdpuCVi1hFXAy8xCfD4jrtllmb4om1twvWqLTdB7qd8bVj7mPQISHXDFRP4H6OQ9RE21maHVTjFHRF4G4749qchhqj503O2Vlxou/mPYH/iGfeXaQC5FGBhYEPNxgTEFqaLQfgkEWd7Pbdb6nbjJdMLo9YbmdZAWmEVMELZjOgXCkg1BEP3POTkjiaXqEJHwstLzCHNpATvO9y7OWASIQSBQ2g1mkbx2IFCyw9s8WqefTW5yj7UqZPhrUlw9Ll/nTxrB//aak9rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UROqKNKdR0O7nTSfVHBwMqdzetS8K3EtHvmg4CSdoOY=;
 b=UEIf7j/T4Nm7T2Q4KcWsS1z3VtgHA6mmzwsWOGIneefFJ+om3P/armzthjtZLUE/hodqgSjGShOJ0cr+qCHVrA9ZIc35q7Szg4bigGjbQY0Z2hYV6wydBKaUVG5GRioV9ymjcyYyZm/fCQ3dc/19YZ6nMEJ9uL5LPAHIucSz7omEUBSWKM6LYbUaWm4HPFj6CO6gDjvDOsmmwbfPlnvoSXANzvk44BwanCR9204PUVHSKCOdo07yAczEztAG0ChRwWGE9Jk5VUNANLjgBrpo8uMIct6ZT/fUo2D0OZvBJKKHJXAV9BTEoVf4PEqE8wOKNGvo+pdZZha1j7qREJSmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:52:11 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba%7]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:52:11 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Cavitt, Jonathan"
	<jonathan.cavitt@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"quic_mojha@quicinc.com" <quic_mojha@quicinc.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
Thread-Topic: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
Thread-Index: AQHau1Dob65BNjHB3Ea4KMOr/SX3ibHBb2wAgAAHdgCAAAKZAA==
Date: Mon, 10 Jun 2024 20:52:11 +0000
Message-ID: <f40ea3ddb5434715335b4634f38011ccd79e870c.camel@intel.com>
References: <20240610161133.156566-1-jose.souza@intel.com>
	 <ZmdfCDCQSZIsAWOQ@intel.com>
	 <CH0PR11MB5444A6196C5AC7D3AE960FD3E5C62@CH0PR11MB5444.namprd11.prod.outlook.com>
In-Reply-To: <CH0PR11MB5444A6196C5AC7D3AE960FD3E5C62@CH0PR11MB5444.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|CH0PR11MB5316:EE_
x-ms-office365-filtering-correlation-id: c3388e87-a5ab-467e-ecca-08dc898f3334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?U1NwdzFtVy9wNHFkZWRMcjBvSnc0ckc5ZDlsa3l1d2J3YVdZMGtjMGJkSVdY?=
 =?utf-8?B?VGdBZU02TzZVdWVJYXowMmkxbTBWRmU2U0lFNWY5bTlzalVoaXJmYzdsMUts?=
 =?utf-8?B?SGFCaXU4dk53ZUthUGxIN1RleFIzbkc3c21RNElRT3IrL0hDelNQekVIVnVt?=
 =?utf-8?B?eVZDcGFjS000TWVpaCtBUUY3aW56cTZvTnd6eFNJL0svTmtudDQyY1U5ZXBB?=
 =?utf-8?B?bDVlTFR2TENIS0xuaExBYlF2UDlwVDNGQjliVE9qZm11MzRMRXI5dmpTRkRq?=
 =?utf-8?B?NkJDTFE2cXdYVzBCanJNY1Awa0pUOTh2OVEydTNlWkFrKzhFeERqZVkzczN5?=
 =?utf-8?B?SVBYZzNzYmlyT0ZDUUVVOTRZOHErc1hQUERMRXJVK04ra2crT2ZJN0tZQmsz?=
 =?utf-8?B?WUpoR1ZRZWRpNzQ4dGpTd3N6LzZEeXBqYWxxUUhYbWxIUVNlRnN4RkM5NG9k?=
 =?utf-8?B?TlVVMUt2dnlld0M3WndKYjRZUVA2YXVYK3VESS9kb3gyeHM1WEduNE41ekRI?=
 =?utf-8?B?Wk9UNk9uZ2psV1QvQmlJMUpsMzhTV2VjVmpaV09RK1ZaVTA0VngzTFhHVEZa?=
 =?utf-8?B?N1ZNbFVGNUZrRXpOYjF0Y2tyT3ZOK1VuMm8ybmFOUmpWTGVEcW41Yzl2WmV0?=
 =?utf-8?B?R0ZSSmxrUklEbkZGV2FoMnBnZThlT2EzMytDcEk2emNNWncrUzQ1bnRWK0tV?=
 =?utf-8?B?bHN2OFFVT3JKRnhtNXNmbFJIU1ZYOFVOeGVkcDVpaTRLNVJNVzM2WkUrRDVo?=
 =?utf-8?B?bXYrY0hVaWIyd1FTL3Y0ZktBUjdMTGVNdThQeHF6NnZmdnNpejBRVlNQSGhr?=
 =?utf-8?B?YWxyaGlnR0tWOFAzVnNneDIybUx5VmdNT05xSVJRUUpoUW9xQVFFak43eEpM?=
 =?utf-8?B?YjUwdGNweGxrVjlYUWMzSHNQbUFldVZsUjZiTGFiNWwxR3ZpU21OTXMwUzRY?=
 =?utf-8?B?NGtsWk55WkFqR2VLNmRkWDlBdTgwU3JSTVc5ZU5IVGVQRmNWYTZNeUdRVGN3?=
 =?utf-8?B?T2hNaHlxNWZKQzVZUEcyMEJVTjNueTV4d05iNzc4bjUrWVYrbHMvWnl3VDMr?=
 =?utf-8?B?Y1Z5WHR2Y2lvZ08xRys4cVBqNVBlMFhyZHZ5TWNSNVVTckszVDAzbENHckVJ?=
 =?utf-8?B?TUpiSkIwWFBRRHpNeHhFcHVPazBUYVM5M3JKZXhJWStrcWV6QVhqNXp1M0Fq?=
 =?utf-8?B?dERVMll0d3dFaVdvZlV1RmpnbHlqTzhqMXhFVUs3OC9GWUxOY05QWnRnQmtU?=
 =?utf-8?B?UWlxUmVQaVpwMkRqTjdiQWZmdUtyUTFRREdZYW43eXlZZ3kzQWRHUDlvRStK?=
 =?utf-8?B?M1UyNzNSTk5Wa2NZb2phM0hIY0g5QVY2R3k4bFltaWI1WEJOV3M4MDF0eEhn?=
 =?utf-8?B?ZVduc1lZenNVSlQ5RGxmaVEzVHFHaGJaVUZLUTFBL1pXM0FydHhYSzhFSjBv?=
 =?utf-8?B?ci8zR2hkdVNjeGovZzZQTUpwaTdFSkNwNFUzSlJjelEzS29SYXdZeUtxYzhp?=
 =?utf-8?B?Y0VKd0Zabkw4VHBtTGFJOUk0K1JFMVlkS25JT1plZWd4WktENmgzaDNvR1J2?=
 =?utf-8?B?Q0F2VDBacXE5bi9maDk4UjZLMG5JWGZWNkh2ZTdkak9nNEZMbFY2bUUwaFpI?=
 =?utf-8?B?RHhINnFQVzdHalNreDJ5YWk4WnFjYkFDKzdGdk0vN3h2a2JIaDNQT3lXVUtE?=
 =?utf-8?B?eWkxVnFDZ1crVHFQVzIwWlZpU0FoN2x4RGtrQ3A1T3gvVThYTWJuQ0JZZUUy?=
 =?utf-8?B?ZFlBcktmTG8wcTdRS2tTRldHQTZIZHhpVTBIRFp0b1U4WFRHTGhGNWNSOTRP?=
 =?utf-8?Q?5Gifv3s3NJurePezPxNIaGxPLeC5jjA1xMf5o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlQ5dHBzNTZUVlhDYWY2VmJ0N3p4aUJNcU9KakQ5bkZib0dxRXRKTFI0aitQ?=
 =?utf-8?B?Y0ZVYllsdzZxZmNBVzM2SXE4ZUw3aXMvWWcyb3UvdHFxMFdMbnJERHNHMC9I?=
 =?utf-8?B?SWU1VHNxWVd0eFd3cDM3ci9LYkxCdWdSYy9PTjIxWnlkbElZMDFvOThxblhJ?=
 =?utf-8?B?SmNVeTRTY09rZCsvZE9acHBKYXJTWEZlRG5YUjFuL1lFQTZubndyZ3pOMHI2?=
 =?utf-8?B?MVJ5YXNsNjk1TnhQcUFxc0ZjK2RqZFlPY1F3anN0SFlKWUxPVXNkVzNTSGxW?=
 =?utf-8?B?cW1meko0ZXpyUUVTUGhHV0FkR2NwOGJYSWVjeE1JMDA3ZGZCQ3dGc3NOcFdR?=
 =?utf-8?B?ZVp5bEtlTnQvZlljZm9OWjJKRXFIQi9oZ0h6Tk05TkNoWXFteXhGQXErLzdV?=
 =?utf-8?B?K3N0NlgxRHNaRHVUMXV1Uy8zWlE1b2NoRWIzVy9WbXJnWjJadTNqaStOMHQx?=
 =?utf-8?B?aXFzc2cwQjlKK2pJL1RVUjl4WDRaTmpDYUZuYW1hblNwUUt0MXNDY2lKcFI1?=
 =?utf-8?B?SUkreFhQSWtjb29DaFpNWkxNc2g4dmVTaDFDd1QwWXV2ZXBqYy82T2VGbHk0?=
 =?utf-8?B?WlN1a0tyTGJrTUxyRk94T0E5ejlmcmRyaDAwdDFLeVFhSXJIUFFjUEdIeHBB?=
 =?utf-8?B?eVNXaU53bnBmUklKWEMvUGh4dVpKcGM0b1pnL1dJSUI1d04zdFV4eDdJY1Q1?=
 =?utf-8?B?ZG0rV0ZWbmZVUHZKbEZndGU5aTV5NVdqM1lOaEQwVzlhaGRwR1VyY25meTN2?=
 =?utf-8?B?SVNIbjhoYVVGWlhRcDN2NnU5LzFVVkFyb3RkUjdBMjJoWXFSVDBrdU1xVEpU?=
 =?utf-8?B?TXVIN2dxQU1oSnJ6UWhtaXpTM2JXWFVsS09Dck9KYml5d3ptQ0Y0a2lYV3BS?=
 =?utf-8?B?a2g2RzdJckVhVDlIcjF1dkRmYjNvVHdXMGROdmJNQ1l4ZzU3T0JUTGcrWjdV?=
 =?utf-8?B?cExUTjFsamZmUUZQRVlLbk9raU41NzloNm5xZ0doU09UOE0xcm5BbGtjWGlt?=
 =?utf-8?B?QlF5VkgxQ0NDOXltc05tcXltQUxpRlVpWmpNcUtHdC9BZ3ZjUXhzVzBaWHpu?=
 =?utf-8?B?ZmIxWStTN2NJNUF0ZDI0aEthZHFwdWFGbGdDOTBQcjVXS3hiQ2gyNno3ZUpv?=
 =?utf-8?B?VmYwNUZCTEdUWFVGeERZUjVaYTFGUFExRHVJaXU4d0R3SjR2M2ZTN0NOaVUy?=
 =?utf-8?B?SXN2eC83Rzc3cEhZK2ZTb0VDUjVqT3BiMTE4Y0UrY00wQnBPSk1pcTF0NFhl?=
 =?utf-8?B?S2lSbHBCMWc1WWlkY1lQYmQzb0hTS2xCbnhJbDNGTktScVo3aWVsYXhzM2t5?=
 =?utf-8?B?eVprQlQyenFRQ2Nta1BwS2Y2Y3IwQXBjMld5dHJPaytibVMyb0N6RTRpeXJo?=
 =?utf-8?B?Z0ZCOUZ0OVBXcDNrQzdRc0ZySmIyT2NBZTBDTXdFVlJrbWZDSVFCbjZ4aVAy?=
 =?utf-8?B?Q3RueVF1SEk4OXhrZy9LK0lSTnptWXdLY2lyV1d4NFVPNjFKQXVUZ3ZSMzZk?=
 =?utf-8?B?c3NuMk5UWEtyUE5hVkVIUmZLTEhSYkhlcG1EcjF0dllwQjl2T2JaL3UxaTg0?=
 =?utf-8?B?bk9EbjRiZGY3N0JVR1N1dk11MkxPMW9HL2JReC9oTy82THp2TFVFVXVlVkpC?=
 =?utf-8?B?QlE4QVdGWnJXVzFRSXdVS05NWFpYbVQrRmcyUnl5d1NodEt3M0t2eUkreUZM?=
 =?utf-8?B?OFJhcWlwczZjdDZMVS9PYjBEWE43bjJlUDkwRGJaejZiTkFYa25WSG0wMGdq?=
 =?utf-8?B?TEY0U25ibmN0RmZTV2VVZnVEQTlYMTJBMzVkM1cwYmhIbDJRa1hBS1JSczE2?=
 =?utf-8?B?dUl5K2RVdjB5QzkwOCttcFpzTVZYYkkwMllxQjF5dzFOL1A5TGJEQ2FjU2xZ?=
 =?utf-8?B?K3piYlllMkpldXlXbVplYi80dTNhWFdPRE1kN2cyNTJOOFJSWUhxT2lxb3F3?=
 =?utf-8?B?TVVxVHoxN0NIOU5CVUhFdmgrWXIwQnhIditvUkJjbDlBSTJzYStTYSsyTEVr?=
 =?utf-8?B?Q3VmSmM2UGZtU1NiOVBGYVIraTN6cWppeTBYRkpPMXRybjdObUtlU1JnaEZE?=
 =?utf-8?B?REdSL1RsY1Vwd01FNnViTjBMdzZ1QlUzZ0haR3pkRXlZQWFmMjZ4MUcxRkJp?=
 =?utf-8?B?dzhOVWx6UzZpd3YyYmJBUWJsTGlxOTFnZWVMME9xSDkyeWMrTldsbWdzYUkv?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C216D687119A64C923F410824783418@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3388e87-a5ab-467e-ecca-08dc898f3334
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 20:52:11.1733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azyQMfuWnYWORWz4+yeRukvalALq1e/C0OVA6zx+QDNYhHHDJDtj4rBUIj1XmhYwBrWGP1nsHGNmiVsKliT/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA2LTEwIGF0IDIwOjQyICswMDAwLCBDYXZpdHQsIEpvbmF0aGFuIHdyb3Rl
Og0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaXZpLCBSb2RyaWdvIDxy
b2RyaWdvLnZpdmlAaW50ZWwuY29tPiANCj4gU2VudDogTW9uZGF5LCBKdW5lIDEwLCAyMDI0IDE6
MTYgUE0NCj4gVG86IFNvdXphLCBKb3NlIDxqb3NlLnNvdXphQGludGVsLmNvbT4NCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgTXVrZXNoIE9qaGEgPHF1aWNfbW9qaGFAcXVpY2luYy5jb20+OyBKb2hhbm5lcyBCZXJnIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PjsgQ2F2aXR0LCBKb25hdGhhbiA8am9uYXRoYW4uY2F2
aXR0QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzJdIGRldmNvcmVkdW1w
OiBBZGQgZGV2X2NvcmVkdW1wbV90aW1lb3V0KCkNCj4gPiANCj4gPiBPbiBNb24sIEp1biAxMCwg
MjAyNCBhdCAwOToxMTozMkFNIC0wNzAwLCBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIHdyb3RlOg0K
PiA+ID4gQWRkIGZ1bmN0aW9uIHRvIHNldCBhIGN1c3RvbSBjb3JlZHVtcCB0aW1lb3V0Lg0KPiA+
ID4gDQo+ID4gPiBGb3IgWGUgZHJpdmVyIHVzYWdlLCBjdXJyZW50IDUgbWludXRlcyB0aW1lb3V0
IG1heSBiZSB0b28gc2hvcnQgZm9yDQo+ID4gPiB1c2VycyB0byBzZWFyY2ggYW5kIHVuZGVyc3Rh
bmQgd2hhdCBuZWVkcyB0byBiZSBkb25lIHRvIGNhcHR1cmUNCj4gPiA+IGNvcmVkdW1wIHRvIHJl
cG9ydCBidWdzLg0KPiA+ID4gDQo+ID4gPiBXZSBoYXZlIHBsYW5zIHRvIGF1dG9tYXRlKGRpc3Ry
aWJ1dGUgYSB1ZGV2IHNjcmlwdCkgaXQgYnV0IGF0IHRoZSBlbmQNCj4gPiA+IHdpbGwgYmUgdXAg
dG8gZGlzdHJvcyBhbmQgdXNlcnMgdG8gcGFjayBpdCBzbyBoYXZpbmcgYSBvcHRpb24gdG8NCj4g
PiA+IGluY3JlYXNlIHRoZSB0aW1lb3V0IGlzIGEgc2FmZXIgb3B0aW9uLg0KPiA+ID4gDQo+ID4g
PiB2MjoNCj4gPiA+IC0gcmVwbGFjZSBkZXZfY29yZWR1bXBfdGltZW91dF9zZXQoKSBieSBkZXZf
Y29yZWR1bXBtX3RpbWVvdXQoKSAoTXVrZXNoKQ0KPiA+ID4gDQo+ID4gPiB2MzoNCj4gPiA+IC0g
bWFrZSBkZXZfY29yZWR1bXBtKCkgc3RhdGljIGlubGluZSAoSm9oYW5uZXMpDQo+ID4gPiANCj4g
PiA+IHY1Og0KPiA+ID4gLSByZW5hbWUgREVWQ09SRURVTVBfVElNRU9VVCAtPiBERVZDRF9USU1F
T1VUIHRvIGF2b2lkIHJlZGVmaW5pdGlvbg0KPiA+ID4gaW4gaW5jbHVkZS9uZXQvYmx1ZXRvb3Ro
L2NvcmVkdW1wLmgNCj4gPiA+IA0KPiA+ID4gQ2M6IFJvZHJpZ28gVml2aSA8cm9kcmlnby52aXZp
QGludGVsLmNvbT4NCj4gPiANCj4gPiBSZXZpZXdlZC1ieTogUm9kcmlnbyBWaXZpIDxyb2RyaWdv
LnZpdmlAaW50ZWwuY29tPg0KPiA+IA0KPiA+ID4gQ2M6IE11a2VzaCBPamhhIDxxdWljX21vamhh
QHF1aWNpbmMuY29tPg0KPiA+ID4gQ2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0
aW9ucy5uZXQ+DQo+ID4gPiBDYzogSm9uYXRoYW4gQ2F2aXR0IDxqb25hdGhhbi5jYXZpdHRAaW50
ZWwuY29tPg0KPiA+ID4gQWNrZWQtYnk6IEpvbmF0aGFuIENhdml0dCA8am9uYXRoYW4uY2F2aXR0
QGludGVsLmNvbT4NCj4gPiANCj4gPiBKb25hdGhhbiwgYWxzbyBhY2sgdG8gbWVyZ2UgdGhpcyB0
aHJvdWdoIGRybS1uZXh0IGZsb3c/DQo+IA0KPiBBY2sgY2xlYXIgZm9yIGRybS1uZXh0IGZsb3cu
ICBBY3R1YWxseSwgeW91IGNhbiB1cGdyYWRlIHRoYXQgdG8gYQ0KPiBSZXZpZXdlZC1ieTogSm9u
YXRoYW4gQ2F2aXR0IDxqb25hdGhhbi5jYXZpdHRAaW50ZWwuY29tPg0KPiBJIHByb3ZpZGVkIHRo
ZSBBY2sgYmFjayBiZWZvcmUgSSBrbmV3IEkgd2FzIGFsbG93ZWQgdG8gcHJvdmlkZQ0KPiBSZXZp
ZXdlZC1ieXMsIG9yIHRoYXQgdGhleSB3ZXJlIGRpZmZlcmVudCBmcm9tIEFja3MgZXZlbiBpbiBt
eQ0KPiBjYXNlLiAgSSB0cnVzdCB0aGF0IG15IHBhc3Qtc2VsZiB3aG8gb3JpZ2luYWxseSByZXZp
ZXdlZCB0aGlzIG1lYW50DQo+IGZvciB0aGUgQWNrIHRvIGJlIGEgc3RhbmQtaW4gYXMgYSBub24t
Y29tbWl0dGFsIFJCLg0KDQoNClRoYW5rcyB5b3UgYm90aCBidXQgSSB0aGluayB3ZSBuZWVkIHdh
aXQgZm9yIGFuIGFjayBmcm9tIEpvaGFubmVzIG9yIE11a2VzaCB0byBtZXJnZSB0aGlzIGRldmNv
cmVkdW1wIHBhdGNoLg0KT24gbXkgb3RoZXIgZGV2Y29yZWR1bXAgcGF0Y2ggYWxyZWFkeSBtZXJn
ZWQgd2UgYWxzbyBhc2sgZnJvbSBhIEdyZWcncyBhY2sgdG8gbWVyZ2UgaXQgdGhyb3VnaCBkcm0t
bmV4dC4NCg0KDQo+IA0KPiAtSm9uYXRoYW4gQ2F2aXR0DQo+IA0KPiA+IA0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSA8am9zZS5zb3V6YUBpbnRlbC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYyAgfCAyMyArKysrKysr
Ky0tLS0tLS0tDQo+ID4gPiAgaW5jbHVkZS9saW51eC9kZXZjb3JlZHVtcC5oIHwgNTQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NTQgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYyBiL2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVt
cC5jDQo+ID4gPiBpbmRleCA4MmFlYjA5YjNkMWI1Li5jNzk1ZWRhZDFiOTY5IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMv
YmFzZS9kZXZjb3JlZHVtcC5jDQo+ID4gPiBAQCAtMTgsOSArMTgsNiBAQCBzdGF0aWMgc3RydWN0
IGNsYXNzIGRldmNkX2NsYXNzOw0KPiA+ID4gIC8qIGdsb2JhbCBkaXNhYmxlIGZsYWcsIGZvciBz
ZWN1cml0eSBwdXJwb3NlcyAqLw0KPiA+ID4gIHN0YXRpYyBib29sIGRldmNkX2Rpc2FibGVkOw0K
PiA+ID4gIA0KPiA+ID4gLS8qIGlmIGRhdGEgaXNuJ3QgcmVhZCBieSB1c2Vyc3BhY2UgYWZ0ZXIg
NSBtaW51dGVzIHRoZW4gZGVsZXRlIGl0ICovDQo+ID4gPiAtI2RlZmluZSBERVZDRF9USU1FT1VU
CShIWiAqIDYwICogNSkNCj4gPiA+IC0NCj4gPiA+ICBzdHJ1Y3QgZGV2Y2RfZW50cnkgew0KPiA+
ID4gIAlzdHJ1Y3QgZGV2aWNlIGRldmNkX2RldjsNCj4gPiA+ICAJdm9pZCAqZGF0YTsNCj4gPiA+
IEBAIC0zMjgsNyArMzI1LDggQEAgdm9pZCBkZXZfY29yZWR1bXBfcHV0KHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChkZXZfY29yZWR1bXBfcHV0KTsNCj4gPiA+
ICANCj4gPiA+ICAvKioNCj4gPiA+IC0gKiBkZXZfY29yZWR1bXBtIC0gY3JlYXRlIGRldmljZSBj
b3JlZHVtcCB3aXRoIHJlYWQvZnJlZSBtZXRob2RzDQo+ID4gPiArICogZGV2X2NvcmVkdW1wbV90
aW1lb3V0IC0gY3JlYXRlIGRldmljZSBjb3JlZHVtcCB3aXRoIHJlYWQvZnJlZSBtZXRob2RzIHdp
dGggYQ0KPiA+ID4gKyAqIGN1c3RvbSB0aW1lb3V0Lg0KPiA+ID4gICAqIEBkZXY6IHRoZSBzdHJ1
Y3QgZGV2aWNlIGZvciB0aGUgY3Jhc2hlZCBkZXZpY2UNCj4gPiA+ICAgKiBAb3duZXI6IHRoZSBt
b2R1bGUgdGhhdCBjb250YWlucyB0aGUgcmVhZC9mcmVlIGZ1bmN0aW9ucywgdXNlICVUSElTX01P
RFVMRQ0KPiA+ID4gICAqIEBkYXRhOiBkYXRhIGNvb2tpZSBmb3IgdGhlIEByZWFkL0BmcmVlIGZ1
bmN0aW9ucw0KPiA+ID4gQEAgLTMzNiwxNyArMzM0LDIwIEBAIEVYUE9SVF9TWU1CT0xfR1BMKGRl
dl9jb3JlZHVtcF9wdXQpOw0KPiA+ID4gICAqIEBnZnA6IGFsbG9jYXRpb24gZmxhZ3MNCj4gPiA+
ICAgKiBAcmVhZDogZnVuY3Rpb24gdG8gcmVhZCBmcm9tIHRoZSBnaXZlbiBidWZmZXINCj4gPiA+
ICAgKiBAZnJlZTogZnVuY3Rpb24gdG8gZnJlZSB0aGUgZ2l2ZW4gYnVmZmVyDQo+ID4gPiArICog
QHRpbWVvdXQ6IHRpbWUgaW4gamlmZmllcyB0byByZW1vdmUgY29yZWR1bXANCj4gPiA+ICAgKg0K
PiA+ID4gICAqIENyZWF0ZXMgYSBuZXcgZGV2aWNlIGNvcmVkdW1wIGZvciB0aGUgZ2l2ZW4gZGV2
aWNlLiBJZiBhIHByZXZpb3VzIG9uZSBoYXNuJ3QNCj4gPiA+ICAgKiBiZWVuIHJlYWQgeWV0LCB0
aGUgbmV3IGNvcmVkdW1wIGlzIGRpc2NhcmRlZC4gVGhlIGRhdGEgbGlmZXRpbWUgaXMgZGV0ZXJt
aW5lZA0KPiA+ID4gICAqIGJ5IHRoZSBkZXZpY2UgY29yZWR1bXAgZnJhbWV3b3JrIGFuZCB3aGVu
IGl0IGlzIG5vIGxvbmdlciBuZWVkZWQgdGhlIEBmcmVlDQo+ID4gPiAgICogZnVuY3Rpb24gd2ls
bCBiZSBjYWxsZWQgdG8gZnJlZSB0aGUgZGF0YS4NCj4gPiA+ICAgKi8NCj4gPiA+IC12b2lkIGRl
dl9jb3JlZHVtcG0oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbW9kdWxlICpvd25lciwNCj4g
PiA+IC0JCSAgIHZvaWQgKmRhdGEsIHNpemVfdCBkYXRhbGVuLCBnZnBfdCBnZnAsDQo+ID4gPiAt
CQkgICBzc2l6ZV90ICgqcmVhZCkoY2hhciAqYnVmZmVyLCBsb2ZmX3Qgb2Zmc2V0LCBzaXplX3Qg
Y291bnQsDQo+ID4gPiAtCQkJCSAgIHZvaWQgKmRhdGEsIHNpemVfdCBkYXRhbGVuKSwNCj4gPiA+
IC0JCSAgIHZvaWQgKCpmcmVlKSh2b2lkICpkYXRhKSkNCj4gPiA+ICt2b2lkIGRldl9jb3JlZHVt
cG1fdGltZW91dChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtb2R1bGUgKm93bmVyLA0KPiA+
ID4gKwkJCSAgIHZvaWQgKmRhdGEsIHNpemVfdCBkYXRhbGVuLCBnZnBfdCBnZnAsDQo+ID4gPiAr
CQkJICAgc3NpemVfdCAoKnJlYWQpKGNoYXIgKmJ1ZmZlciwgbG9mZl90IG9mZnNldCwNCj4gPiA+
ICsJCQkJCSAgIHNpemVfdCBjb3VudCwgdm9pZCAqZGF0YSwNCj4gPiA+ICsJCQkJCSAgIHNpemVf
dCBkYXRhbGVuKSwNCj4gPiA+ICsJCQkgICB2b2lkICgqZnJlZSkodm9pZCAqZGF0YSksDQo+ID4g
PiArCQkJICAgdW5zaWduZWQgbG9uZyB0aW1lb3V0KQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RhdGlj
IGF0b21pY190IGRldmNkX2NvdW50ID0gQVRPTUlDX0lOSVQoMCk7DQo+ID4gPiAgCXN0cnVjdCBk
ZXZjZF9lbnRyeSAqZGV2Y2Q7DQo+ID4gPiBAQCAtNDAzLDcgKzQwNCw3IEBAIHZvaWQgZGV2X2Nv
cmVkdW1wbShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtb2R1bGUgKm93bmVyLA0KPiA+ID4g
IAlkZXZfc2V0X3VldmVudF9zdXBwcmVzcygmZGV2Y2QtPmRldmNkX2RldiwgZmFsc2UpOw0KPiA+
ID4gIAlrb2JqZWN0X3VldmVudCgmZGV2Y2QtPmRldmNkX2Rldi5rb2JqLCBLT0JKX0FERCk7DQo+
ID4gPiAgCUlOSVRfREVMQVlFRF9XT1JLKCZkZXZjZC0+ZGVsX3drLCBkZXZjZF9kZWwpOw0KPiA+
ID4gLQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmRldmNkLT5kZWxfd2ssIERFVkNEX1RJTUVPVVQp
Ow0KPiA+ID4gKwlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmRldmNkLT5kZWxfd2ssIHRpbWVvdXQp
Ow0KPiA+ID4gIAltdXRleF91bmxvY2soJmRldmNkLT5tdXRleCk7DQo+ID4gPiAgCXJldHVybjsN
Cj4gPiA+ICAgcHV0X2RldmljZToNCj4gPiA+IEBAIC00MTQsNyArNDE1LDcgQEAgdm9pZCBkZXZf
Y29yZWR1bXBtKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1vZHVsZSAqb3duZXIsDQo+ID4g
PiAgIGZyZWU6DQo+ID4gPiAgCWZyZWUoZGF0YSk7DQo+ID4gPiAgfQ0KPiA+ID4gLUVYUE9SVF9T
WU1CT0xfR1BMKGRldl9jb3JlZHVtcG0pOw0KPiA+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGRldl9j
b3JlZHVtcG1fdGltZW91dCk7DQo+ID4gPiAgDQo+ID4gPiAgLyoqDQo+ID4gPiAgICogZGV2X2Nv
cmVkdW1wc2cgLSBjcmVhdGUgZGV2aWNlIGNvcmVkdW1wIHRoYXQgdXNlcyBzY2F0dGVybGlzdCBh
cyBkYXRhDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZjb3JlZHVtcC5oIGIv
aW5jbHVkZS9saW51eC9kZXZjb3JlZHVtcC5oDQo+ID4gPiBpbmRleCBjOGY3ZWI2Y2MxOTE1Li5l
M2RlMWU1NDVhNGE1IDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9kZXZjb3JlZHVt
cC5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2RldmNvcmVkdW1wLmgNCj4gPiA+IEBAIC0x
Miw2ICsxMiw5IEBADQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3NjYXR0ZXJsaXN0Lmg+DQo+ID4g
PiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiA+ICANCj4gPiA+ICsvKiBpZiBkYXRhIGlz
bid0IHJlYWQgYnkgdXNlcnNwYWNlIGFmdGVyIDUgbWludXRlcyB0aGVuIGRlbGV0ZSBpdCAqLw0K
PiA+ID4gKyNkZWZpbmUgREVWQ0RfVElNRU9VVAkoSFogKiA2MCAqIDUpDQo+ID4gPiArDQo+ID4g
PiAgLyoNCj4gPiA+ICAgKiBfZGV2Y2RfZnJlZV9zZ3RhYmxlIC0gZnJlZSBhbGwgdGhlIG1lbW9y
eSBvZiB0aGUgZ2l2ZW4gc2NhdHRlcmxpc3QgdGFibGUNCj4gPiA+ICAgKiAoaS5lLiBib3RoIHBh
Z2VzIGFuZCBzY2F0dGVybGlzdCBpbnN0YW5jZXMpDQo+ID4gPiBAQCAtNTAsMTYgKzUzLDE3IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBfZGV2Y2RfZnJlZV9zZ3RhYmxlKHN0cnVjdCBzY2F0dGVybGlz
dCAqdGFibGUpDQo+ID4gPiAgCWtmcmVlKGRlbGV0ZV9pdGVyKTsNCj4gPiA+ICB9DQo+ID4gPiAg
DQo+ID4gPiAtDQo+ID4gPiAgI2lmZGVmIENPTkZJR19ERVZfQ09SRURVTVANCj4gPiA+ICB2b2lk
IGRldl9jb3JlZHVtcHYoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzaXplX3QgZGF0
YWxlbiwNCj4gPiA+ICAJCSAgIGdmcF90IGdmcCk7DQo+ID4gPiAgDQo+ID4gPiAtdm9pZCBkZXZf
Y29yZWR1bXBtKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1vZHVsZSAqb3duZXIsDQo+ID4g
PiAtCQkgICB2b2lkICpkYXRhLCBzaXplX3QgZGF0YWxlbiwgZ2ZwX3QgZ2ZwLA0KPiA+ID4gLQkJ
ICAgc3NpemVfdCAoKnJlYWQpKGNoYXIgKmJ1ZmZlciwgbG9mZl90IG9mZnNldCwgc2l6ZV90IGNv
dW50LA0KPiA+ID4gLQkJCQkgICB2b2lkICpkYXRhLCBzaXplX3QgZGF0YWxlbiksDQo+ID4gPiAt
CQkgICB2b2lkICgqZnJlZSkodm9pZCAqZGF0YSkpOw0KPiA+ID4gK3ZvaWQgZGV2X2NvcmVkdW1w
bV90aW1lb3V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1vZHVsZSAqb3duZXIsDQo+ID4g
PiArCQkJICAgdm9pZCAqZGF0YSwgc2l6ZV90IGRhdGFsZW4sIGdmcF90IGdmcCwNCj4gPiA+ICsJ
CQkgICBzc2l6ZV90ICgqcmVhZCkoY2hhciAqYnVmZmVyLCBsb2ZmX3Qgb2Zmc2V0LA0KPiA+ID4g
KwkJCQkJICAgc2l6ZV90IGNvdW50LCB2b2lkICpkYXRhLA0KPiA+ID4gKwkJCQkJICAgc2l6ZV90
IGRhdGFsZW4pLA0KPiA+ID4gKwkJCSAgIHZvaWQgKCpmcmVlKSh2b2lkICpkYXRhKSwNCj4gPiA+
ICsJCQkgICB1bnNpZ25lZCBsb25nIHRpbWVvdXQpOw0KPiA+ID4gIA0KPiA+ID4gIHZvaWQgZGV2
X2NvcmVkdW1wc2coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnRhYmxl
LA0KPiA+ID4gIAkJICAgIHNpemVfdCBkYXRhbGVuLCBnZnBfdCBnZnApOw0KPiA+ID4gQEAgLTcy
LDEyICs3NiwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZGV2X2NvcmVkdW1wdihzdHJ1Y3QgZGV2
aWNlICpkZXYsIHZvaWQgKmRhdGEsDQo+ID4gPiAgCXZmcmVlKGRhdGEpOw0KPiA+ID4gIH0NCj4g
PiA+ICANCj4gPiA+IC1zdGF0aWMgaW5saW5lIHZvaWQNCj4gPiA+IC1kZXZfY29yZWR1bXBtKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1vZHVsZSAqb3duZXIsDQo+ID4gPiAtCSAgICAgIHZv
aWQgKmRhdGEsIHNpemVfdCBkYXRhbGVuLCBnZnBfdCBnZnAsDQo+ID4gPiAtCSAgICAgIHNzaXpl
X3QgKCpyZWFkKShjaGFyICpidWZmZXIsIGxvZmZfdCBvZmZzZXQsIHNpemVfdCBjb3VudCwNCj4g
PiA+IC0JCQkgICAgICB2b2lkICpkYXRhLCBzaXplX3QgZGF0YWxlbiksDQo+ID4gPiAtCSAgICAg
IHZvaWQgKCpmcmVlKSh2b2lkICpkYXRhKSkNCj4gPiA+ICt2b2lkIGRldl9jb3JlZHVtcG1fdGlt
ZW91dChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtb2R1bGUgKm93bmVyLA0KPiA+ID4gKwkJ
CSAgIHZvaWQgKmRhdGEsIHNpemVfdCBkYXRhbGVuLCBnZnBfdCBnZnAsDQo+ID4gPiArCQkJICAg
c3NpemVfdCAoKnJlYWQpKGNoYXIgKmJ1ZmZlciwgbG9mZl90IG9mZnNldCwNCj4gPiA+ICsJCQkJ
CSAgIHNpemVfdCBjb3VudCwgdm9pZCAqZGF0YSwNCj4gPiA+ICsJCQkJCSAgIHNpemVfdCBkYXRh
bGVuKSwNCj4gPiA+ICsJCQkgICB2b2lkICgqZnJlZSkodm9pZCAqZGF0YSksDQo+ID4gPiArCQkJ
ICAgdW5zaWduZWQgbG9uZyB0aW1lb3V0KQ0KPiA+ID4gIHsNCj4gPiA+ICAJZnJlZShkYXRhKTsN
Cj4gPiA+ICB9DQo+ID4gPiBAQCAtOTIsNCArOTcsMjkgQEAgc3RhdGljIGlubGluZSB2b2lkIGRl
dl9jb3JlZHVtcF9wdXQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gIH0NCj4gPiA+ICAjZW5k
aWYgLyogQ09ORklHX0RFVl9DT1JFRFVNUCAqLw0KPiA+ID4gIA0KPiA+ID4gKy8qKg0KPiA+ID4g
KyAqIGRldl9jb3JlZHVtcG0gLSBjcmVhdGUgZGV2aWNlIGNvcmVkdW1wIHdpdGggcmVhZC9mcmVl
IG1ldGhvZHMNCj4gPiA+ICsgKiBAZGV2OiB0aGUgc3RydWN0IGRldmljZSBmb3IgdGhlIGNyYXNo
ZWQgZGV2aWNlDQo+ID4gPiArICogQG93bmVyOiB0aGUgbW9kdWxlIHRoYXQgY29udGFpbnMgdGhl
IHJlYWQvZnJlZSBmdW5jdGlvbnMsIHVzZSAlVEhJU19NT0RVTEUNCj4gPiA+ICsgKiBAZGF0YTog
ZGF0YSBjb29raWUgZm9yIHRoZSBAcmVhZC9AZnJlZSBmdW5jdGlvbnMNCj4gPiA+ICsgKiBAZGF0
YWxlbjogbGVuZ3RoIG9mIHRoZSBkYXRhDQo+ID4gPiArICogQGdmcDogYWxsb2NhdGlvbiBmbGFn
cw0KPiA+ID4gKyAqIEByZWFkOiBmdW5jdGlvbiB0byByZWFkIGZyb20gdGhlIGdpdmVuIGJ1ZmZl
cg0KPiA+ID4gKyAqIEBmcmVlOiBmdW5jdGlvbiB0byBmcmVlIHRoZSBnaXZlbiBidWZmZXINCj4g
PiA+ICsgKg0KPiA+ID4gKyAqIENyZWF0ZXMgYSBuZXcgZGV2aWNlIGNvcmVkdW1wIGZvciB0aGUg
Z2l2ZW4gZGV2aWNlLiBJZiBhIHByZXZpb3VzIG9uZSBoYXNuJ3QNCj4gPiA+ICsgKiBiZWVuIHJl
YWQgeWV0LCB0aGUgbmV3IGNvcmVkdW1wIGlzIGRpc2NhcmRlZC4gVGhlIGRhdGEgbGlmZXRpbWUg
aXMgZGV0ZXJtaW5lZA0KPiA+ID4gKyAqIGJ5IHRoZSBkZXZpY2UgY29yZWR1bXAgZnJhbWV3b3Jr
IGFuZCB3aGVuIGl0IGlzIG5vIGxvbmdlciBuZWVkZWQgdGhlIEBmcmVlDQo+ID4gPiArICogZnVu
Y3Rpb24gd2lsbCBiZSBjYWxsZWQgdG8gZnJlZSB0aGUgZGF0YS4NCj4gPiA+ICsgKi8NCj4gPiA+
ICtzdGF0aWMgaW5saW5lIHZvaWQgZGV2X2NvcmVkdW1wbShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBtb2R1bGUgKm93bmVyLA0KPiA+ID4gKwkJCQkgdm9pZCAqZGF0YSwgc2l6ZV90IGRhdGFs
ZW4sIGdmcF90IGdmcCwNCj4gPiA+ICsJCQkJIHNzaXplX3QgKCpyZWFkKShjaGFyICpidWZmZXIs
IGxvZmZfdCBvZmZzZXQsIHNpemVfdCBjb3VudCwNCj4gPiA+ICsJCQkJCQkgdm9pZCAqZGF0YSwg
c2l6ZV90IGRhdGFsZW4pLA0KPiA+ID4gKwkJCQl2b2lkICgqZnJlZSkodm9pZCAqZGF0YSkpDQo+
ID4gPiArew0KPiA+ID4gKwlkZXZfY29yZWR1bXBtX3RpbWVvdXQoZGV2LCBvd25lciwgZGF0YSwg
ZGF0YWxlbiwgZ2ZwLCByZWFkLCBmcmVlLA0KPiA+ID4gKwkJCSAgICAgIERFVkNEX1RJTUVPVVQp
Ow0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICAjZW5kaWYgLyogX19ERVZDT1JFRFVNUF9IICov
DQo+ID4gPiAtLSANCj4gPiA+IDIuNDUuMg0KPiA+ID4gDQo+ID4gDQoNCg==


Return-Path: <linux-kernel+bounces-532740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA27A451B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088FE3A615A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4078314D2A0;
	Wed, 26 Feb 2025 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRX07Jc3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D620328;
	Wed, 26 Feb 2025 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530722; cv=fail; b=Y9CpPrtb1UYxNeRv2iTJqOAC5ix9IBgDRu/nh0sg24+I/8wP1mKJSq6S+v7aWQI3pApSHnd4jvpa/f/9RVFBIFsaDDoWI1UV7w6RcE8yCwwjrtfXbgzf1Vfbyo8SCmsF5tGA6KyV1R7YoKYxFQh4/zLl3VNZEzd4fbeuE/NYJKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530722; c=relaxed/simple;
	bh=6UBy6piADmDYW/XUVbVFxWq9jm5DnHiL1cg6W+xsnSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwHUMIraIGrfapJR4dbT2sbQ4J9+HSrNvRbFxlsyZ0Pxn09LDb5/QuMKaUclHIJXvKLOFATMAxbtoBaCTKznCTUlZrw4Hc5IrT9NwKLxWxhzHeiEVJJGPC7HfYg3LVJJQppYXUoFKvvIm5dIiX5yiyRRiCjuq2YXTzRWvMLg3mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRX07Jc3; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740530720; x=1772066720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6UBy6piADmDYW/XUVbVFxWq9jm5DnHiL1cg6W+xsnSE=;
  b=NRX07Jc3KvmnpeNJEnDVPjvDILx7lyYcSAieM3wRQut6KF4/L5QPVlvC
   LgL634cos+7IKa+NUV3IP4ms1C3Pjx9t4lNNMhxpjiH8svLY7B3DJRLem
   jgvIVK3vOrw2bBVw8h0FHq1mnOfBP2C5l8khnCJNMKNofBPyknBKp997j
   gnFKWOlHokTjAs0Hj7L+GAic2lIQrzid0S9nbSYGS1CdaHEpfv1rFdGWW
   dxVVyRMvNim19nVObIia/zzpDoNGfCZ9uPuIhJ2vUKmj24gZyFhLpG1Xb
   8QFu4QeKLRAlxaVHV9qoofhdJq9G4X/pfPrXX89idkseNkhUXAcpmY27u
   Q==;
X-CSE-ConnectionGUID: wfQkDx7uRoyw74cNeWpoug==
X-CSE-MsgGUID: tHiMakw/SNSTJnYOvAi0kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41067720"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41067720"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 16:45:20 -0800
X-CSE-ConnectionGUID: SsOJqeDhTeGK4dJCvOCDSA==
X-CSE-MsgGUID: EpMbCfNyQriF2RwGO3nNPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="117169523"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 16:45:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 16:45:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 16:45:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 16:45:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcJx2pDlnICAV1Je8NL8n4M+ejsZwkw5FuFxKez6LQSxpJSStaJytEkZSmfm1lnhzHwdZtpRXEuRFmrZn4nYnHB+2D/EeTk21yejLbUQWfEq5z+5MAQPsoJ/Swdl6RQDz5UeXO68wtFSrrQONs/1QsbkWZlJ165sWLiqZTcpZdNdq1hul0L9aLBtwpjawNGzvmEDXaACWTgYL2QJk7JIAGu/Y2vDCTj8Gw76EvaccKJDhC8+co7yTYD2GAwGZAPWmCBnq5lZ1klV0iiud5NgD12Hp8ulib3TX8guqwgHnitGu4iTVYzuuwWd9ieR3Ao+DbdrI61YxACcQUd9Zzal8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UBy6piADmDYW/XUVbVFxWq9jm5DnHiL1cg6W+xsnSE=;
 b=Tzayvt+nvfdJi6ADEyi9KxJexRv6Bj2p5HaQ8Xhegprn8xx7goQ0bh52LiOl4p+fPxHrQSF2eNl/lgvRlXVqDof3u+cXZ5qQ3jQA4YrFwXofEtPh6MDwwGPEU9u6e5JLlGSAT9MRXMUbCv0WbNzE4lGXQ1k6lP9PLcxfsW7kLyPehlAzjgyjw6H7fTB8dsMFRjqHwl5cNiLxbwycyMkHdg1HLN1axslksWmEmP64GsSLmdFijwCloW5h6NgZ6Z+vy5rhlnzDzeIorCXjFSsIMTSBT0GQb4Cd14O4Zgcw+DMiF2+7bNxr+CAV1mnTHih83M7TQKBBf8MngR92HsSaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 00:45:16 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 00:45:16 +0000
From: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "nirav.rabara@altera.com"
	<nirav.rabara@altera.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH RESEND v2] arm64: dts: socfpga: agilex: Add dma channel id
 for spi
Thread-Topic: [PATCH RESEND v2] arm64: dts: socfpga: agilex: Add dma channel
 id for spi
Thread-Index: AQHbh4s7G0JTuUOdE0K5gOCG5DOuKLNYT8YAgABwEXA=
Date: Wed, 26 Feb 2025 00:45:16 +0000
Message-ID: <BL3PR11MB653251B58933CFCE0034E3F7A2C22@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20250225133919.4128252-1-niravkumar.l.rabara@intel.com>
 <10bb3b7b-f7fc-459d-b397-1ef7bb31a51e@kernel.org>
In-Reply-To: <10bb3b7b-f7fc-459d-b397-1ef7bb31a51e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|IA1PR11MB6267:EE_
x-ms-office365-filtering-correlation-id: a4993e70-c6ed-448c-e08d-08dd55fed659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RlNGdlNzcXhzZ0djaHg0TXhFM2Y1L3hPRHlNbFZnUXlob2RBZVdYZmJWdEY3?=
 =?utf-8?B?WGZycWFmZEMvbEVjZGY1VkhFMnZKRFVPSS9LMXdyQ0lvOXRTdWo5OVhlaG9B?=
 =?utf-8?B?NXpZaVdzMVNwWU5kSVFUeVR0cEZXQzJYRi9xb0VmSkVVdkFqQ3JhN2V0NVRj?=
 =?utf-8?B?QWRBSEp3TUk1QmR6OHZxRWg5TVI2UnJIR01lakd3S2lFdDVoYS9HMncyMWMv?=
 =?utf-8?B?azRFenVESlk3ZEpYbHVFT01GWStpWTFBVnI2cDJlYTFlQlljRHBjb3NuMEha?=
 =?utf-8?B?Uklham0wT3VYajdLajMzUHNmMVhXOVZPaUNVOHM2NFdRTld5ejR5OWRaMkNK?=
 =?utf-8?B?eHRLWVMyK1RiTGppV0pveXk1dEZ6MU1LVWMyM1lSZ1JwU2VxaEFEK2FHYnBp?=
 =?utf-8?B?U1hsbzhrZWhuZFhNWDZON1JzZldPQmlLVTRUeTd2V2N2alh3QVFxaHZjN1ZR?=
 =?utf-8?B?SVhLM2tCWnl6d1ZBci9wMStSTVA0TVpPdys3L0cxeUUwWkIvZEtrQlFOVWhL?=
 =?utf-8?B?REdOVHNnb1V4TXpMQTJVZTAydDYxdEVJRW93NlplOGVnZHdwekY2ZG03Vjgv?=
 =?utf-8?B?WjZlZjdzMEh4MnNvaVR0ZDN3cnFidVhqRHhVSnI0YWN6U0JGWXA1ZFI4M1FD?=
 =?utf-8?B?Q3FvMkY3cUlWSi8rL1dlWkx0SXpKYmNUMDR0U3dyRmlxKzVpT1BlZzdLWVVi?=
 =?utf-8?B?ZE9rY2I3UGlhY1pCaGhSSXgxSXdHUG5CeENGRFVyYUROalhlYVFYMEtWQ1d0?=
 =?utf-8?B?c002RkZ4b0hwZXZyYWRBTHVXWTRNbGZmbXZsUEN0VExDTmorSDg2ck4zUVlm?=
 =?utf-8?B?b3VielEvczd5azlkem01OURoOTVtWUpneXpENmlsQnBJOVFNK0RqcWRmMFkw?=
 =?utf-8?B?SDZyRHBuWHlGdTRidVdQREVPQTV3NGhTWFlWZDZJQ0JjZXVkbVQ5bkd2d1M4?=
 =?utf-8?B?MTNIWXE2WVlWd09sclRQVlJuZTYxOUR5WDV3TkJBUjQ4bk56LzVYOWhnWlQz?=
 =?utf-8?B?MjNDWnQ3S1hrQXd0aUs0N2JNTnNjWDBsTTFhTTJ6VlZIdUlENm55OXNZVFpB?=
 =?utf-8?B?SFJHelpQWFAwVVBIeFYrSm5Vc0xyUG0rYUNCY2pSYVQ4WUZqRndmd096Nyt2?=
 =?utf-8?B?M3RabXRnQi81UGRKRFpxLzBnYW4xc3RQRys3S3BTSUZBcTZmT0c3Vm5xdktU?=
 =?utf-8?B?Q3VETEM4QzFXaEVSZzVLNGxZOXFkbEVBOER6VGlZVUR3a0ordlFVUVV4Ymxy?=
 =?utf-8?B?cjRVdkJPMXNGY0hjRTZneEszeWZoN1hBbzlYbkFKbnpzTHpDTVk0OFkrMFVP?=
 =?utf-8?B?YlpNMU5ROFgwU3hTNVQzdmVCRUVtVjRjU3RxRGh0WnV6cXdKeGtHTUZraUtu?=
 =?utf-8?B?a2I0R3RTV1YrRXdTY29MWjhROEpVU3pYbkt0T2E2cXh1T0NHakVKWGphRjlC?=
 =?utf-8?B?RkdNVHdxcythNGI3WHN6aCtWd2E2UmxIeVJGY25xeC9pRmgyVkQ1UW90eXpp?=
 =?utf-8?B?Y1N3ZWFYQUd0MjJTL0RVS2RVbzE2cmJLUEk0cWlSenZld2dTdXZDNTA2cUEx?=
 =?utf-8?B?VkNFcUptS1ZmYnRySythS0I0b2p3czZjQjkwTHNVa1l0SzlyRDczV2VKcENL?=
 =?utf-8?B?UkZUY1h3S0JpRHE4U3gxUFdCVzljZ2s0NlI2d0hHNllFRWxON3F3SmRhR1dY?=
 =?utf-8?B?aHJJNXpjWitUSDA3WWF4TllKeW40ZWs0QWR4S0lOa1FHazkrMktVdTdacnZy?=
 =?utf-8?B?Z21JaExlNkxkc1l6NVRCUWZRN2JYTk5XNS9mcXl0R0FEcUs1VUFZckFub2JG?=
 =?utf-8?B?UDNQaWZvQ2l1cHo4Z2M0Y09UVXBNMnNBRWdqRGhwa2tKRkhZNHJYWjJNVGJr?=
 =?utf-8?B?eXg5emV4UDJ6TkY3M0pYa0RKQTBFUHpmY2tHRmVxWE4rTDdpcVIxUFE4Qno2?=
 =?utf-8?Q?IV25Gd+58FnLuatVrSzAszcZPNEDGIWu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUttWUsvUTVBME1IRGY2ZlF3QVBqT20vQ2Jmd1J6MUdKTG41MTlBcHZiMkkw?=
 =?utf-8?B?Qk1USHRLMWFWM0wyRE5LL21qQXRkaFA0WHVpVGVGVEpmcG9BUzlGcUg5K0JQ?=
 =?utf-8?B?MVh0SXBNMTlXd2R3K3NEb3UzRSs3WjZHbERpbHk2U0pJZXRuaGo3TEwzNUFv?=
 =?utf-8?B?QlUwZ2crRFcyU1ZhUUVlcU4wNE1CYWdXZVhQSzd0SkQrMHhCYnVNTXV6S1Jo?=
 =?utf-8?B?QjFQSyt3NXV2aVNYSVZoeUV5MXIzaGNleGdXdHBPblBIQnp4QWcwcWRZQ1Rs?=
 =?utf-8?B?Z3ZrNzhvODFqQk5xVkpXanJsS2p5d3VOUDN5KzgwYTB6NTY4WEM2Z3pDT3Qz?=
 =?utf-8?B?MEZoVjFzbFJLanhHeHRKbno4N3ZONGNOS1NtNXlmalRJZ2lEZzF0VW8yUGph?=
 =?utf-8?B?bDVNRTFhOUNyM01ZTy9HVzVxQlJpVHV4WEV2SDZJNUQ5VEVwTDhHSGlUQjhV?=
 =?utf-8?B?bmkzU2xpV0ZkOVU1QXhITU5ScEFjWUxWa2twMVNGVDFDNEQ4NU55bStCUVJX?=
 =?utf-8?B?RUR0RnZJRk80c2IrSXVkNlpyM2RhNmI0Z1c1ZGl0ZHZuWFNPdzVpNCthbUxU?=
 =?utf-8?B?NndjNGN2aU84a2I3eko1ZmtaMUV2bSt4aDZSeFZJWC8weFJSemdoMGdkK21n?=
 =?utf-8?B?dzRRS29Vd2YwYUtsMDBtMDVxZWVMM25QVnlyUjJkNXdadG81OWwyTm5WY2l0?=
 =?utf-8?B?QW5JM2NoWmFTNkNMZTd1VUF5Y3N3cGJXbGtvSldlVW5ab0FTeENIUjQzaitF?=
 =?utf-8?B?QVV2UHp5WldEaTByQnpjNmMrRlZWUjhwUVZpREhXanRxTGJSZUNUV3RxeGtB?=
 =?utf-8?B?YldIZWZadXFWV0ZFUHVFeDdqQVVFRmpSaFBzODVIQ1p4RFFzVmtERENLenY1?=
 =?utf-8?B?bHVEUHpYeTdEdTBYWEFETERjL1NuN2NuM1h1MFlRRlRMTVlrT0JiSWNXbHNT?=
 =?utf-8?B?ZHJiMk8zby9FVlU3aHNYanFmQlJIV0s2ZjBaL29ncTgvTWZMY1Z0Y3FILzlJ?=
 =?utf-8?B?dW0zMWFURlg2QVZwRDdtZFZNTDNGakJJMUVmUk5iUWZNS0tNd3pGZHdiTU1r?=
 =?utf-8?B?dFhiUEJLQmZ4cFdubDRRVmxCQ2wxSlcwVjZ5ZW4weWNzd1VwUGc1UkdEQ0xP?=
 =?utf-8?B?U3dkNFlRMFMvRlV4SmFaMVZSTmFMSGVBYjdaVHBxajNoMGxtVERvNzY2SVhp?=
 =?utf-8?B?OVhOTDNiTFRQTzJTdDYrQ3VtODZha0ZzeHlYRDZZallmTXlqTWdZUW90TXVi?=
 =?utf-8?B?QXd4MEZtK2luTnJMQVhtY3BUNFUranpwZm9TazZ1ZUowYTk5dC9xSWZTNFRH?=
 =?utf-8?B?T0RFeFkxU0tCaEl2aGl3Zm9zZitLV0VsbzRzRTV0S296enE2RStLd1hUem8w?=
 =?utf-8?B?eUdzeUdHVkVWbXNCUVVnQXM3QWtGSThSejJtdzBVMjlka0hUK00rTTNkRHdv?=
 =?utf-8?B?SkV1TUsrYnN4TVIzM0JYbkpmV2piRzZBa1lpY0lneWhocEwwQnNha1RBQWQ0?=
 =?utf-8?B?U285eWxEMlVzbFJnTjFweGY3bTkveFlkM01aM0NPSjhtaDlvejhMZWVvOUU1?=
 =?utf-8?B?ZXk5cnU1QXRCMUx0blBtMDMyWnFaVDJseW1JS21SbTYrQ2FXZzNqU1R4bHBP?=
 =?utf-8?B?MXdERXNIY0RUaVFhMUJjM1hlejQxdU1iTWx0Z2dvcUMyQlNWbUMrZUJOYVF0?=
 =?utf-8?B?eUJiaXdUU055cng4ZUV3L2NEYTEzMVZvYm9CWGNFcTlMbG5JM3c1bGVJbnNB?=
 =?utf-8?B?L0YzNTk0dEZ6SHpMRnRVTVlTOTFYbG4rUTlRa1JsY0V2UmxWKzdLRkNxOS9l?=
 =?utf-8?B?NmpwQzUwVzV2RW5SRkV0VEpTRndwWWJNdHk1OGxlTmJqeFgrMk5LSGk5K00v?=
 =?utf-8?B?VEVaMFlsWGlEMFhQL2ZPM0dUcGllRGEwZTJXNjk4alZFN2RqTGhhdkUyN09s?=
 =?utf-8?B?MXpIMytDWE5qc01tbjdDRUVESlhBL25UdEhaUjNxYWZPU1RTeEQ1TDVyMld2?=
 =?utf-8?B?TkFLV3p3Z0FpQndTdlFyMWQwWWkxUlhPeC9rUTE2SGxXeXpURitheTlNZEUv?=
 =?utf-8?B?YWljVnNOMkpxaVFLbldlK2RvaUJuYW5HOFdQNFVrWDNxNmpNYndHSm1PTS80?=
 =?utf-8?B?ZkI4aEkreHFGSGo1cnlMcHJGL0xzSE9ZRjlJZy9KTVVXcEdERWwyRWNSWjdj?=
 =?utf-8?B?VFdoTDVCSDhQdHBlR2w5cDE5MGc1VGZ0eHR6djc1UWRjMUgvN3c0Qm9WSHZo?=
 =?utf-8?B?dnByMTkwckFCM3lMSjd2QWE0Q29BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4993e70-c6ed-448c-e08d-08dd55fed659
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 00:45:16.2143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hToe7PduoVTFMXqW+kiL2wdqBvKAUOEI9pAZvWOiseNH4UA7QWKGfXsDrzuutH/9tit13a2wiuy8mUImxCn3xO84T5rAN90BCEtLx8TtkRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com

SGkgS3J5c3p0b2YsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDI2
IEZlYnJ1YXJ5LCAyMDI1IDI6MDIgQU0NCj4gVG86IFJhYmFyYSwgTmlyYXZrdW1hciBMIDxuaXJh
dmt1bWFyLmwucmFiYXJhQGludGVsLmNvbT47IERpbmggTmd1eWVuDQo+IDxkaW5ndXllbkBrZXJu
ZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dz
a2kNCj4gPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVs
Lm9yZz47DQo+IG5pcmF2LnJhYmFyYUBhbHRlcmEuY29tOyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmc7IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2lA
bGluYXJvLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRVNFTkQgdjJdIGFybTY0OiBkdHM6
IHNvY2ZwZ2E6IGFnaWxleDogQWRkIGRtYSBjaGFubmVsDQo+IGlkIGZvciBzcGkNCj4gDQo+IE9u
IDI1LzAyLzIwMjUgMTQ6MzksIG5pcmF2a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tIHdyb3RlOg0K
PiA+IEZyb206IE5pcmF2a3VtYXIgTCBSYWJhcmEgPG5pcmF2a3VtYXIubC5yYWJhcmFAaW50ZWwu
Y29tPg0KPiA+DQo+ID4gQWRkIERNQSBjaGFubmVsIGlkcyBmb3Igc3BpMCBhbmQgc3BpMSBub2Rl
cyBpbiBkZXZpY2UgdHJlZS4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TmlyYXZrdW1hciBMIFJhYmFyYSA8bmlyYXZrdW1hci5sLnJhYmFyYUBpbnRlbC5jb20+DQo+IA0K
PiBUaGF0J3Mgbm90IGEgYnVnZml4Lg0KPiANCj4gV2h5IGRvIHlvdSBDYyBzdGFibGU/DQo+IA0K
SXQgd2FzIGEgbWlzdGFrZS4gRG8gSSBuZWVkIHRvIHJlc2VuZCB0aGlzIHBhdGNoIHdpdGhvdXQg
Q2MgU3RhYmxlPyANCg0KVGhhbmtzLA0KTmlyYXYNCg==


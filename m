Return-Path: <linux-kernel+bounces-234573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851191C829
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E44B2237D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36787D06B;
	Fri, 28 Jun 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQwq9Rt1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B47F7CA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610410; cv=fail; b=rpIdltQRZVMQv+SDprd5UPcdaTxSNRvLX2m/6vAWt5Cex8MJ6cMmhZVr2q3UR9zGWXKS4hhKL7/WVMV7RIeyGMKJ51xKfh1s6/MN5bsh0w7lZcX2R8o0TvFaQ2HcWqUEdEIkjEhf2KVsbR4wSHZKD/Y08RkQC+4F1L+8QHY0LAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610410; c=relaxed/simple;
	bh=g6oY8wFOH8uLw32EfBtrqDyP+R+r1rZx5s45wORP47Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iHV4mcjZlqgE/EB324JjSIAPbNweFLp8iQHBlvnPJjhQE1eDuKVctbbZ88iIUNoHnHuZf9L0enpBdj9Wpmc/JEN8Hzuf90O/6ajut25NDm4ET6g39tp9rOC0767WzHQqxuKG2K50/pNcSDUVoH3QzylRvCfaycBqZVEZGtTkIL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQwq9Rt1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719610409; x=1751146409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g6oY8wFOH8uLw32EfBtrqDyP+R+r1rZx5s45wORP47Q=;
  b=TQwq9Rt1C5WKA9dQSISi5yddot1SMubZ4Bu7Id4J3T20MAZvOy64copx
   vcDpIgGe8bdET72Eobq5W5tXJ3Dl9le1enq5390D2AQ/Tu3eh9v31H3/9
   0dOIj+ti16PK3LoR+fs9z9ebw7tY4aaabo57gbpFz0P8O6onFwmiwP+2c
   wzLjLU0KrXNQN2Dgpz5VmGRuxn4Qd0AmPHP7y4WQx3vmyWgtsZGDMwZIE
   T2+UZy47BP5dIwidkVDBtYKYsq5jcTagmw7gSxqJyFMJkGfHCztQXCN8f
   gjM2DW0MEzY3nIjZCbgMH3x7hIBgMXTGRIYOeKyzhulZ05TjeUCTWkaDO
   g==;
X-CSE-ConnectionGUID: tYRKZF/zTwe+Hgau1HTW/A==
X-CSE-MsgGUID: WAuZ4IEYQEmoj5TzDv6z3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16482949"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16482949"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:33:28 -0700
X-CSE-ConnectionGUID: 10HCMq0JRYerN3sdPDir2Q==
X-CSE-MsgGUID: SBKHCKmPQ6SAxvrohgpZaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68059140"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 14:33:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 14:33:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 14:33:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 14:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJYYCyS88JFJJxVT+2Vztt3AlF4ClN3KdZwVGVpcBtk/6P+UnLJUor2aZzIyhbKE/r0LaK8qqSJIx/vs2QVbze3/zrcLCM7BCRJOrk77vER8fVnCNCcdgfXDMROQHhDp86flOQUhJYQJss8410jKYLeO5AGlYFEdwd+jZPDuPUD6fu5DWqoo2YDZp9m58ZaImAPcZ+K12DZe3YHvpM89OqRBDP0VpCk4gqmUwzcq2XXemkVVg/7BpjIz6rSmUISWI19kjXFDdjTGNCgMI0JWPi/lC+9rvcBPSsj5NHL7JUwNh3qnn6ECdSDjAijhwKR8rXIUoQG4oyAg3ruhpS7I/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6oY8wFOH8uLw32EfBtrqDyP+R+r1rZx5s45wORP47Q=;
 b=BvNkCbFMbeJSMQMvYNDSk8IaAfeuL0y5qwtZF0x76BySKroieBUg2bQT5+VnFaRFniIQmTaipU644DK/B9AJQQdPjHMF956QE15GLu5c7E/wthliK5O1kK1XKwuye9TBD1r0G79N94auA1F6vIxNGpZWq9DCSZJsOF55JcqNK9cDry0am0d7EQXZFtxUYzbysGAKb2QO7mzFqj/4GgbybdWQP+/qjkYFBPHQSMJ9aIa3DSfe3HL+7ryJZSPGCwIKwMz6XwKCr64lPz+w+KvnasZMHErvMmLJgV5Ys0kzQzmuOzdck9WZ8fQtrQoFhAveYk/kMUfHb2lc5nC1htNEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 21:33:22 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 21:33:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
	"Rodel, Jorg" <jroedel@suse.de>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Thread-Topic: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Thread-Index: AQHayZ0272Rw0HaOX0+/vmpf14Hnz7HdqJoAgAAG3oCAAALkAA==
Date: Fri, 28 Jun 2024 21:33:21 +0000
Message-ID: <0226cae0f31c4e1143bbe1e3ac49b67bf101576d.camel@intel.com>
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
	 <fcb19e22678d126f9c4223d1e80f8c7d27e22692.camel@intel.com>
	 <d24f7bae-9581-4d1a-ae05-2fede38b5e1f@amd.com>
In-Reply-To: <d24f7bae-9581-4d1a-ae05-2fede38b5e1f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7535:EE_
x-ms-office365-filtering-correlation-id: 4c3a9253-5ac7-4632-b2a6-08dc97b9ef0a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vk1WMkhiMXhhd2xMNlNTTC9CVUN4WHlmd3VjZ3liQ25GdGlIdmhNbkIxa1NL?=
 =?utf-8?B?Rkp5bEo3SGZ2WDAzNHVCQ2tvT21xcGl1RzUrc0hOcE1RM2NTa2xJL1FPazFr?=
 =?utf-8?B?Zlk3U0svOVRJN3hyWEtWMy9vVWlQTElJY0wrNkxpaFJnMjZYN3RQdjl5TXVO?=
 =?utf-8?B?QUZqMC9MazdWdm5UYTJVVlV1YzE0eGk4aHR6NTdkc2MzQ3hIT056d05GWjE3?=
 =?utf-8?B?YnFiRWJ4dURMM2M3Vi80TXVOVzMyWU4wWXQwRTVGL0ZsaC85VERHUHVmN1dn?=
 =?utf-8?B?aFQ5QmF1cU1OT1laMjBsVUdJdE1WRmpqeEU4UzNHNUNXYncyb3NIM0lOK3Bm?=
 =?utf-8?B?S3o3UzBPMGNCaGNTSGU4L1o1SG5BUkVRSys3TDR1aDZPZDcvMlBxTTlmczlC?=
 =?utf-8?B?eFYxWXlRWGowWkpHQ3JIQTRWaDkrMTF5TFZCVlNVQjVZWkhuMHVPQ1pTNHN5?=
 =?utf-8?B?WUhxTjJ2cmh3THprSkQwcU1RcmJTRWp6UFlyMjFSZVFhN1VURXJBVktCb1RU?=
 =?utf-8?B?KysxVzgxalVsV2lvRGRCVnFSdE5NMlZ5K254L0tHNDFCa2FpYzlXdnBZbXRP?=
 =?utf-8?B?NEJ1UlF6WE1tNlAyaWZpWmNrSEM5WVgzVFRoV0g3VFF1US9JZ3VQU0NlQ2Qx?=
 =?utf-8?B?dlA2RjFiWmtlcG1vMzVCUWM3K2hJSzJJOTAwdmRxai84SWFxeExQbDRyQ0ZY?=
 =?utf-8?B?ZU03QTBYUGFJUXlxcENudEJLbmNJaHp4dTI2OUFiR0hORHFTZ0RPaHpIdklz?=
 =?utf-8?B?dWJIUUZnZC92b21CblhBZVlack44RkZNQlFwQzVjVndxYVNIM1lPR29kVG1B?=
 =?utf-8?B?NjFvZ1hBbll6SzN2N0NHT0tMQzdPRWpEaUcrN0FmQ1RkYklHVE45TVViVGRl?=
 =?utf-8?B?QXNRUHZQNWVrSUQvU2drK2tUZExDcUFRZEVoWjdQdE1XTE1ZQXJ3NkttU0o1?=
 =?utf-8?B?SDJZV2h2MjNxcEszVmlZZnZIWE9HdXMyRE96ZEVYUFh1Rzdzc3JTYWd4N2pl?=
 =?utf-8?B?eStuUE5vRnM3UkI1eTRyUURGZ0o4YnZWVEhGRlo0OGdNVEQxMUVwamlLcHpz?=
 =?utf-8?B?UkhVdi9qYWZVM0t2M05YTEhaelFNQmtQMklLTzR4LzkzZnVlZGZUWVRsWmkr?=
 =?utf-8?B?MVdiVzNWNGVGY2hYU3VOSDV3b3BWMC9yNC80WnJrSXR5UGphN1Fyc3NBUllq?=
 =?utf-8?B?Yzk1S2RFa2FTaWhRak1SV20yNWt4ckJvMm5NalRrcUlNeEFzQXkzSDN0ektm?=
 =?utf-8?B?MXlha0pLdFl0TmlhREV5N3BNdkprT1NNcWlkUytRZUlkSXhWa2Zxc01tczcy?=
 =?utf-8?B?TDh5T0o2bzVHaGd4T0hkS3EzeWIzR20wWGNhRkRKZjFrWlJxNE9jaithajRv?=
 =?utf-8?B?OC9tQ1VYcFlNc1JiYTZVYTR2YXp4RjA4TDc3SVVoMWVTYmpkVlpDSWhybGt5?=
 =?utf-8?B?Y0NFaC9ER3phUFpuODJaT0dvd1FSME5sM1pzME9YNlVKZU5yM3V4cHNWYkVr?=
 =?utf-8?B?dC96T0svS0JkQ0U0cUJkN2Z0TGJXWWI3ZXdMcTlFQzM2eklMek1VVk5CeDMx?=
 =?utf-8?B?R1E1blNZZmhGTnRja1JiNTJpNFdKMU5pRHdCZW9XeElmT3dtQ0JadGpjS1lM?=
 =?utf-8?B?OWF3Mnc3anI2Vk5PdmZJcDFYYXp4VndqM1liSUNQWjFsMlR3N3JhMTNqYVNM?=
 =?utf-8?B?THRwc2FQRzIyWmR6L3gzZFk4K2JRcHVwTUdidFJPeUw4blJEWVM2WitIZEEw?=
 =?utf-8?B?UThqV2lqVnJtak5JS0k4RTdZZFlWaXVBVkMycUFxVnEvTE0wNVFtMzdoLzdh?=
 =?utf-8?Q?aB0/YHtHE/nZTSEbyWXmxAwC3eCEq3JV1z/34=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnlLMmx3Wmx0Nk5RQzErSUlWekpVZnplNGFZcnlyamF3dVRobjZOZmcyRURD?=
 =?utf-8?B?OVJ4MlpQRGlhbjVLd3dzd0MwQVU5U3Y1OWJDRG5PL00xRTVBSkFXanJtWHdp?=
 =?utf-8?B?dnFSekZyYjdZVnJUK1loZ0tyZVF1U2NWSWVYZkhVWmF5eW54UElWdHUzMzQy?=
 =?utf-8?B?Ry95M2dCblU2VXpjQ29QS2hLWVNuU3hoZ2Z5KzAvTEFTUlhUcnpEQW9GWTAx?=
 =?utf-8?B?MGdYdG0zcTZ6UzQrYTNKbklJRVFWdHVsZ01iWVAva2hiUzFaKzk3MTFWYmE2?=
 =?utf-8?B?NFJoY2FrL1NiRFFlZ3orNVR1ejI0UXlyZGVXazRXVzAzNjV0cWtyMmJsdFhw?=
 =?utf-8?B?WSt4NEwwaHo5TEFQWjNhRkdTUDNzV09WOGtxaUEwTXlBU3hndm5CNDlhMDlW?=
 =?utf-8?B?OGdaVWpxV25Oa2h2MFRuWXJWM3ZocEZJdW1tYWtycThWeE9FWExFejBDdFk0?=
 =?utf-8?B?UTBjc2crd0VQYmxaVUlFOWs2UXVoT0xrZFEwd1NzYUpOMXFSZ2V5a2pSZ2ZL?=
 =?utf-8?B?aGRKL1B3NHd2VWxKRkcyUWhsVzJvLzFPd2lNSHNRck12MEdRWnYyRmtZVzdP?=
 =?utf-8?B?Mk42cTJVcVE0ZmJ0ejZaM0lmNS9NWkorMjl2NW04Q0tJS29PV2RVUFVZekxW?=
 =?utf-8?B?VEJHQlUyUVI4SVZEL1lHeXFFV29HYXVCK2ZiMHhaTXJrTS9qWDFjSmYxRHho?=
 =?utf-8?B?V0syYW90MDVGcDFBcGwrVDRUZVJualV2M1IyQlN0TVlnaXp0U21JcnBxNnVV?=
 =?utf-8?B?eWVlQ01UQURvTjROay9MeStHU1lsM3BRYWZTcWZmd2xmdDU0WnE1RWVjSU1n?=
 =?utf-8?B?aGlFdWJvcEk2R0JpQklQR1FQSEZ6VUE4OG1zRElhWHZkZ2M0blA0SnIzNzBJ?=
 =?utf-8?B?Nm5zQi83aHB6TnpDY2Z4RTJBZGdkWlVpd0ZWRFNScXlIeGtQdnNCL3d2UjUz?=
 =?utf-8?B?V010a3lnMFhQRFlJN0JsMG8wdm9oSG9reEFyS1JZL2VIM3h1cTMzM25Bd0Y0?=
 =?utf-8?B?UnhhYzRjOHJwSHJuUWtTSFhuRjg1YktDQlBreHQ3RkJySmpjYUhpVkV6MlMx?=
 =?utf-8?B?RGVGT0xsQ3ZDQ2cxNFZlUWNnV29KMUJNMENlWnhhSjQ0a25Od3VST1U0ZkRQ?=
 =?utf-8?B?ak9hME5EWnErVEdTTC9IbXVDOXpXcG1PV2VySEdaQ1ZVZVJsOGltWUZEcVFj?=
 =?utf-8?B?RGdCdm5hRnFoaVJncmE0WGdPS21QTlBxelJjUW1NVzc0elFsMysvSzJ5Tm1R?=
 =?utf-8?B?VVJwNmVIM1p6RG9QSmcrWTYyUjFNNWM1VUQ5WWFXclBpdkhaaTZleG9MWUpy?=
 =?utf-8?B?L0ZHbG1NYlduNXJQbUNpVU44eE5oWmo1SUJPZFpuZGlWUTBsZFJDREFoV2FK?=
 =?utf-8?B?UE1yTmV0MSszNkc1V1EvR0pzMjNhWHNlNTFPbkRZcGMvam5vd0tncGdHckVT?=
 =?utf-8?B?ZUVGMjJlaUNENi9jcHNvWWc1ckZIR1VCQzJuQ0phSm40eXdJcXVLVGR0WkpO?=
 =?utf-8?B?K0N2N0FnUzNwdjN5TW5odndkU1JIQ3JkS3RGMktnbGZTNmFSYzVCSGkrNlRY?=
 =?utf-8?B?NUVXQXFQbUJjZFpoN0JwU3JVQjB6bXgwRno1b0lyZklVUEtVQnFudGV2RHIz?=
 =?utf-8?B?SXNQd0lBTmttb3BSQkFnWENNUGZYaWJ3MVdjVy9TYU9WLy9qMG9qYXMxam1l?=
 =?utf-8?B?V29EQ0s1R24rdlNqVTVVbW81VHhYY1VYM0kxN1dsZUhhMzdNdCtXcHgwSVRi?=
 =?utf-8?B?NTJUNkNlYWtEbmVmTDBmcDhZKzg1QXBDTUJLU0NaajVnTEhma2wyWkpwNjdt?=
 =?utf-8?B?WEI3c2oxdXlQaGxPMm1kdFZEb3RkZjl0bWZYMXh6eWtTOXRxNzdjNVFGL0NL?=
 =?utf-8?B?MnlWRUVGSmtST0wwL29JUDdwSEcvKzloMHpRb1Z5TlRnNGdqd25wanRLV0Mr?=
 =?utf-8?B?SkFpNkw0WjdTZ3JyTktPdUtUcXY0clRBL2pPY21nb3Q0NDRxUVNyQlR5Rjcy?=
 =?utf-8?B?ZFpTWFdqMWV5R2RJbzNKMitvOUhFdXM1S1RlSUVDeVUwM1pUeWhiVjFhWUlu?=
 =?utf-8?B?QlZJMm1uZFd1UDdsdHN2K3JlOFQxNElhVEF0V1ErWjNBTDFUYjIzcjFBdkhh?=
 =?utf-8?B?Zmw1MWwvbmpHbC95ZDRqYThJdTk1Y0hqdWFCOHhkdGhHRUIwM0crRHJHVVlo?=
 =?utf-8?Q?z8ck29Jf1Burd/6Adw4yjg4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7CB1BC4924A3F469F0554F1F9E18C8C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3a9253-5ac7-4632-b2a6-08dc97b9ef0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 21:33:21.4805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZxfVdFeC6JHuLFdb/S1VZSqx9+KhONfemAm/1TSE0PGlph/h73RacBmgnOyD3eMhGlxskYopT45beuAqgIV06RnFlJAPzH8CJkub7L6n+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA2LTI4IGF0IDE2OjIyIC0wNTAwLCBLYWxyYSwgQXNoaXNoIHdyb3RlOg0K
PiA+ID4gQEAgLTcxNyw3ICs3MTgsMTEgQEAgcHRlX3QgKmxvb2t1cF9hZGRyZXNzX2luX3BnZF9h
dHRyKHBnZF90ICpwZ2QsDQo+ID4gPiB1bnNpZ25lZA0KPiA+ID4gbG9uZyBhZGRyZXNzLA0KPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoCpueCB8PSBwbWRfZmxhZ3MoKnBtZCkgJiBfUEFHRV9OWDsNCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqAqcncgJj0gcG1kX2ZsYWdzKCpwbWQpICYgX1BBR0VfUlc7DQo+
ID4gPiDCoA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIHB0ZV9vZmZzZXRfa2VybmVsKHBt
ZCwgYWRkcmVzcyk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBwdGUgPSBwdGVfb2Zmc2V0X2tlcm5l
bChwbWQsIGFkZHJlc3MpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHB0ZV9ub25lKCpwdGUp
KQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBOVUxMOw0KPiA+
ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHB0ZTsNCj4gPiBUaGUgb3RoZXIgbGV2
ZWxzIGNoZWNrIGZvciBwWFhfbm9uZSgpIGJlZm9yZSBhZGp1c3RpbmcgKmxldmVsLiBOb3Qgc3Vy
ZSB3aGF0DQo+ID4gdGhlDQo+ID4gZWZmZWN0IHdvdWxkIGJlLCBidXQgSSB0aGluayBpdCBzaG91
bGQgYmUgdGhlIHNhbWUgYmVoYXZpb3IgZm9yIGFsbC4NCj4gDQo+IElmIHdlIGFyZSByZXR1cm5p
bmcgTlVMTCwgd2h5IHNob3VsZCBhZGp1c3RpbmcgKmxldmVsIG1hdHRlci4NCg0KV2VsbCwgSSB0
aGluayBzeW1tZXRyeSBpcyBlbm91Z2ggb2YgYSByZWFzb24sIGJ1dCBhY3R1YWxseSBpdCBzaG91
bGQgYmUgb2suDQoNCkkgd2FzIGxvb2tpbmcgYXQgdGhpcyBkaWZmIGNvbXBhcmVkIHRvIG15IHdv
cmtpbmcgdHJlZSwgYnV0IHRoaXMgdGlwIGNvbW1pdA0KKHdoaWNoIGlzIGFib3V0IHRoYXQgc2Nl
bmFyaW8pIG1ha2VzIGl0IHNldCAqbGV2ZWwgYmVmb3JlIGNoZWNraW5nIG5vbmUgZm9yIGFsbA0K
b2YgdGhlbToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTcxODcxOTMwMTU5LjEwODc1
LjE2MDgxODM5MTk3NDM3Mjk5MDA3LnRpcC1ib3QyQHRpcC1ib3QyLw0KDQpTbyBzb3JyeSwgbmV2
ZXJtaW5kLg0K


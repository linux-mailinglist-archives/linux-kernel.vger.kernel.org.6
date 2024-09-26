Return-Path: <linux-kernel+bounces-340827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD767987847
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D98C1F22B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A115B118;
	Thu, 26 Sep 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/xF3xS1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285A136337
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371781; cv=fail; b=AoLqcMTHoDBlg7IR11UoSi41G0UNgpCfTOsfve+BqUKw37uy8PaQ+o/zWop93D4PyKTdgDSZBAhgayBfGugmia6CMGYFRDwP29EEeibEHVVmG2M9+H/nxAvjmvSFnibqUjPIxAJKe2bKl6IpjjdGfs6lOeRq/e+OZJ27x/+Crvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371781; c=relaxed/simple;
	bh=TGSuupJb9W8hoVRKfDz5EjCvloUTmH4OgQ6YK/cs7iY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tUIa9/CZpaOdoxFLJcfunamgi5mqL61ox0Iz8xNM3VyLMk46GwYS3EkyevPpMPOeJzo7OVRryq+Hqw5F0q7HiGdYwAuMEVzzQZGykn1DWy3b/9SUIyIoibfiP3dLe4zNYTa4RwpkbEsXyYso/L7emoUthp/I3KWm+Otsxb8RXUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/xF3xS1; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727371779; x=1758907779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TGSuupJb9W8hoVRKfDz5EjCvloUTmH4OgQ6YK/cs7iY=;
  b=G/xF3xS1yg4e9MjWaNiAwx8BG04tbTs5ZUMia6pp2/iYdC+TA6A01uEA
   0UhgOzxAMzzal5D/ruQ8X6jOBSubzMMHbdBzA2T0b2Qt4h+w5xAzZX/7W
   iGkONfAqQIu5joFJDEif8grzzkkv1D50TfmrYnk2R1jY//6jKTj+kgEi+
   fmQjjVcmJN8PHmRrBnDaKTCF+E4sGXjJbDQBo6LS5Z5n66ppl+OKvUsFH
   S0bt25f4+WOdXAF6wJtpXqkdM0I5zd8QaMnxs+Lp5eqt68tFoSc6aBWpn
   l0bm4An31p9X9cXxdQLMozzmvHUzbBZ4fAsLBTilFE4eZFMCnwDCH+DJz
   A==;
X-CSE-ConnectionGUID: C0aDJnqCRSan0D0boAP0QA==
X-CSE-MsgGUID: z+s82TQ/S6GSWvXG/L6UfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="14110182"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="14110182"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 10:29:38 -0700
X-CSE-ConnectionGUID: UXzEqarGRp2+aF8tp3UyxA==
X-CSE-MsgGUID: cfj0gnzFRxSrGgwpY5k/mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="77060146"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 10:29:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 10:29:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 10:29:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 10:29:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 10:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YA+sSS2dDqu3vqGp5G3jyhY1VsFERi5BMXlulTFoIwsOYzzWGryT8Yfivb3uYyZz+/SZ+nsv5D0OifDoEcTwIHYCwTLn6gEoz9NxxOASlUwC9UQxaPO3FNP4cYUA03eJQDfgS2PDNlp2mwed7gI471cDOCwL8Jy/Qxlg6QT1yysynEiVSrRyX4OQUOypkYbrxN4WNu6pFbysUhoMF7h0QEuqwWQoiuK3SUhc1HIwLPwgCeH8ey5ZBBAbAKPc5BmdfSTff5FldhT98/U7CcDe2qUryWPzmASvVyGbpeORhGZLEq8XpPgD8pt0OlXYNoElwCn84Ppz539vE7QhfEyHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGSuupJb9W8hoVRKfDz5EjCvloUTmH4OgQ6YK/cs7iY=;
 b=wQNiHoOQaeL9YytIB3ycfaVyl39OeYLBt8YvsQ/yU3UTVK2BZckP85by8WSofFm8vwFxaH0cJWClIdqAUtExtm+Q+9I0MBg5bqyFOxWQgKR0MI/AtE5NEU7N0CrYIaCtcxQ3NmH6dXgDVRy6CrZqciuvdgv4GQjoc5pD3QRcnWz/kWlqGJmk6rvmWEEO6qZ0wgXP6bX8FV6FptGs3YUPV7rxW6hW5kVOqkU2uhevngZgUwrs2FS0qKlOFS4sE8G2ifOkaF/KuK+KIVCa6Z0xnH6dvQB6SrMfGtRdvFhkWuCq+QQjJVbmvMCG1lukAVc/IFxovFFwUxMAECMq39NYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SN7PR11MB6603.namprd11.prod.outlook.com (2603:10b6:806:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Thu, 26 Sep
 2024 17:29:30 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 17:29:30 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Johannes Weiner <hannes@cmpxchg.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAEuMgCAAFEmAIAADdcAgAAFSgCAAAmZgIAADtIAgAAWxLCAAFmCgIAAEe0AgAC+71CAABHrAIAAANsg
Date: Thu, 26 Sep 2024 17:29:30 +0000
Message-ID: <SJ0PR11MB56781678BE55278052EB590CC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org>
 <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <20240925192006.GB876370@cmpxchg.org>
 <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org>
 <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
 <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com>
 <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaRjrPTdCCAA0zSVyAZ2sCKiJUC36J0fsajdtp1i_JZeg@mail.gmail.com>
In-Reply-To: <CAJD7tkaRjrPTdCCAA0zSVyAZ2sCKiJUC36J0fsajdtp1i_JZeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SN7PR11MB6603:EE_
x-ms-office365-filtering-correlation-id: f2b828cc-0a73-4210-2266-08dcde50c750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b2p3QTczczJOemNDUlcwWDZKaFhtK0lzS2RLSkZCb0dkOG04dy9ORzFIQzBO?=
 =?utf-8?B?YkhrOTQ4UWV4Y2xJa1V6UUlCVXh2ajFySi8xWVVLNGQwMVBYUHhhd28wZmh2?=
 =?utf-8?B?eURIY0hXM3dYdEtoL3k3NXhDSm05MllSRkhDL3hZOVlrMzh5ZHU3NmtsZHBz?=
 =?utf-8?B?dGJxeTBsUFNhUkEyTXhTM1BkNjVHRjUrZEd0UzVlMkphZCtKZElZa290YkZB?=
 =?utf-8?B?bEJtZzE1SU5XS0ZuQjJqTXU1ek82amhvd1FGY29RNll4aFhHcGkzUFY2Z2ZR?=
 =?utf-8?B?TU1Ya0ZoVVI3bEZnQU9FL1FtSkgra05HUXJ3dHdDbGMvb1MyL0F1TzRnaXRI?=
 =?utf-8?B?bFdydk4yK0k3WHNJcXZ1NGFuVmRzR3c0SG8ybStuZnJNME5ZMkNBbm9mVWly?=
 =?utf-8?B?Z3VZZ2dtYUVwWTN3TUxvM1E0UndBVjhqMlU3K0V2NXo4eWNnVW55Y1VCdk1y?=
 =?utf-8?B?QkRTQ1JKZDRGYnc1ZDdKeUF1R3lRL3BVVE83STcrUVgrMU1EWTB3cC9xVnph?=
 =?utf-8?B?YUJmaDdBQTFwNzdBOWEwTTFqMDlQL041NUFFNFFIdlpjUm1jMGl1ZHNNQkpj?=
 =?utf-8?B?V2hQMnhESGNqYU1xSG1razl3ZytqYVdDY2p2cklueTZOaktnTC9yN1g2MUlI?=
 =?utf-8?B?QjVpQm5NRktrUjRENUVGOEpkMDhUdnh1emkzbFk2TkVUaUxEbnpYVW1hL0VS?=
 =?utf-8?B?bW5ST283WDVwOWlZcWRaRnc3UTE3NzN1bXNlZEVLTG15N3JWdXlTSmRnRGU2?=
 =?utf-8?B?NS9FTUhmN1IrWjFGQmdNVGdzcGJmbXR4UWVTWXRSc3JIUVpxcFFYQkNNWjFp?=
 =?utf-8?B?NUIwVmZIOWZkVkh2YWcxQ0RTZHBlUlZOK01iZk9CUC9JWE02N3dIWjVOeHlo?=
 =?utf-8?B?VWxkRUg5NllMMXJDR3U5dDJYbitYeng0S1FEalBqVGhnZzNOR3ZCNnZZdHpw?=
 =?utf-8?B?OWMwOG5MazZ0VWRnTTJvMm1CUVZhSER4RU8xRUJHSWV5M2NUSW9JZ0ZTODRL?=
 =?utf-8?B?cUorZVNwVHBWUzhkTy9CM3ZCU0k5VndEVnZBWmpHblVjSnd3MXA1dHRONmZh?=
 =?utf-8?B?UXpVSGxMSmp2Mnh2VzRjak9aYnc1dTBmb0M5SGxBbjVOYUxoTFBQakMrdjlT?=
 =?utf-8?B?bk5FSFlnWDZKSWZaSGJtclJzaWVOanJZVVgzd3IyMzJvWDhDbzk3RGd1R2ll?=
 =?utf-8?B?QzFtL1BNVGZRRE5MalVDbWF6SGZ5bTI4eWx6blZOaVU2RHFPWWlzYWMwcnJz?=
 =?utf-8?B?Rjd3SFIvWXIzYnorOGhpeUs1aW8vK3d3YkpNOUsxSDBLWEc4VG5jbHZuaDVD?=
 =?utf-8?B?TzFpcVpDdEhtcmF1TEVLbytva1J4dHE0aUR5QXZpT05Bc3UvY3hHZFBmcHNO?=
 =?utf-8?B?bEdCbDhWRkZ5WFVhcGlVVnk0QjZ6aUJLcmorM1NRYU1UQk51K3hGMzBIbTlP?=
 =?utf-8?B?Zi92N0oza1VWQzRVNDBtTUt5Z01hZHlRcEhRMDVZODN1RGJDbzVvQ3BJOXFD?=
 =?utf-8?B?d2dnL2xsQnpkWm5YWWljVzZLTnVEeUZSOVNIMmFid056NTg1ZUFjaHNhelpx?=
 =?utf-8?B?by9mK0puWVhzTmVQcnBHaVZyQmVWZlFMeTVVOXpEU2FQR1REWDhybmh2SXJD?=
 =?utf-8?B?SzZSQzUrWEh6UjFFa1FTb3hlNFJ4Mk1XT0ZpRnk4QTUzenVDUm1ZM3dMVTVU?=
 =?utf-8?B?cElLd2x0MTdCQk43dkR2Q3ppT3lNWHkvRHVPTWZ2T1dGZnJsWldhSzZIclJz?=
 =?utf-8?B?bWt6b21BRXRlbE0yQ2FQYnV6cWdqT0hnWi9RdTdyUE9VZVFnYWV0K2VNZXRX?=
 =?utf-8?B?ZThPblRlbEEwVTEvNTB6QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0RuL2hQMzArRDFuVkU4b3ZuODg4Qm9lY3Z3dE9mQ1hQTzRObVpEaVNoeitG?=
 =?utf-8?B?Q0FRb3RkdE5DRC9xeWlCOVV4a3VzMUNPMmJxd01meUh0b2FBeUdCK01mZTdI?=
 =?utf-8?B?U1EwaDZJTXN3UUo2aXF3UFIyb0M5TThkUjl5a01RV09BVnJhZnJGR2tBeDlO?=
 =?utf-8?B?S2F5L0ZnNlRxL09JY3ptOW5rdmQreDhlUDM4Wi9WUlZ5dTVwV3p6Q1BxK2RN?=
 =?utf-8?B?bmZrMjVPdk5oTHVFMzZWZVBtU1hsdEJINmpCcUxmZDE1Q2pQWFp5bm5FU1pk?=
 =?utf-8?B?VXFqNlpnWll3NG15eDNZazduUVRoMnpYdXZ3M0tDekhqVzNnK2wwS3JrRjdj?=
 =?utf-8?B?bnQ3a29SWE9YeHFtVUR1dTZxMGNKb2VwTEhud0FZVjdOOGdIOFFNWkRITTZF?=
 =?utf-8?B?MU4xTW9VcnpGcTcreTJON2dzL2pTL0NMUDFBSXQrNnNMNEJ6QWpPYS9vVFRP?=
 =?utf-8?B?VFV4am0yV1h3SzVYbzhYdlpDeHJ3VUZUL0h0Ymc4Znd3aUY2QkErSFpKcGxU?=
 =?utf-8?B?WHh3NjUzdUFLZ20vaTN0WjdhcnhDVzN2UWNoR0tEdXQrWDRpVXcyZGNyd2dH?=
 =?utf-8?B?Z09jZzNiQ1hrNUtjcjVod3hLalVwU21zOXNzcDhuVmFESUU5cUJTTzdiK2Fs?=
 =?utf-8?B?WjNxbGZpN28yeGhqYkRpTURiV3c1S0p2NVhxT2RQeGhBQytTTDFYd014RWR4?=
 =?utf-8?B?Z25FbEJ1N1FLdm1weUc0Nmxhc0srTGJ6YWljSnBlRHcvczN2ak0xR2J5Wmx4?=
 =?utf-8?B?SlRqeXprdElQUFViVjdFWEVBcHJNVEdMdERJeW1sOEI1bk1hU3F5K0FMNGhy?=
 =?utf-8?B?eTFMOHd6aW1HMkUxQis2eW41T242azRWSEpGUndaSklzZGxGSENyRkF5NDNT?=
 =?utf-8?B?MVloVXRjTU14ZEhVaEk5QnhISG05WlpabTFScWljMVk0VHlaRk9PQWdkZits?=
 =?utf-8?B?ZE52NlFIb1AweHlZdHdTR2plL0JxS1hKUGVKRUZMZlNMWE4vRjJBTTYwdTIw?=
 =?utf-8?B?bURBQllVdytvdUlMbG1Ed3l0ZGJtRmFJY0IxVlV6cDJrTVpMRk56YUZQU1VW?=
 =?utf-8?B?VXhsMUhUSkE2dHZzbndiWDlRcUJMWW1Wa1JVODl6OW45c00xUmZIMlVHWlpI?=
 =?utf-8?B?cERLcmlNdVBIN1lhYUtLWDJmeGM3UTlpY2srZzExRmdhek9TWitaWFZIcFZr?=
 =?utf-8?B?MExUZi83YTd5dnMrS0lkT25vd1d5UXFqZGpldkpkOVo0cUV0UU1JV0J6a2ZM?=
 =?utf-8?B?ZWk2WFk1QWFjVVc5L3E3YjJvN2cxNXdBWGtIVWJXN3FpZmljbStURGYzVHVi?=
 =?utf-8?B?Zlk4TzJOS0F1Yjdlb0d6OG9FWFE3aVhVd1JNQS9IMnNoenIzVVpISUVQb3Vr?=
 =?utf-8?B?aDdBS0FDVFZpQUlqTklLVnYwQ1MyMXV6TGNaeEdPK3NQUVRDM2p0RjQvakZT?=
 =?utf-8?B?WGV2aGxZU0RCc0Qrb1hLdFQ0RUl5MXZobHV2NDVFb1JPcm1xRFNrZGlUNkNB?=
 =?utf-8?B?Y3ErdmZvcXFyV3QvQVlWS3JoMXNKL3RWNy9SclBySFRWcDludXRrM1VKcXcw?=
 =?utf-8?B?dDFMblVBTHRFSkdZaUR2K1hjM0Q0TkVtdzlHekx1STNacEI4UUxyZkpQNDdP?=
 =?utf-8?B?eUJMeG5JZG1PR1g4eFQyMVN3YkVaRW5NL1ZSNkNZbXlWaXdHa1ZFU1c5YUIx?=
 =?utf-8?B?c1ZOME9oeGlGQkFSaENxaTJmZjhqeEorWmpNd2dYU3N1WWpmRlMvSWVERnpD?=
 =?utf-8?B?elk0amJhN2dZQlVoOVM5RW9YR2dMbzd0UXo5U05OZzcrM0VMaFhFTktiQmJ4?=
 =?utf-8?B?bE0xNSt0VzBFNlNaNWMzZVRZcU9EMURHUFBNUGdBM3pBV1k4N25CNFF4cnUy?=
 =?utf-8?B?Z3QxSUZkTG4wYlBCekdnRzFKdHNGTExmejJGN05MRlZiZjVSWXVEMC9TS043?=
 =?utf-8?B?d3NZWWsxd0YzdDhOa0Y5Nm5sU2tLYWluOHYrWGdQWTJsUGJGaU1CYWZadjdp?=
 =?utf-8?B?aUlmMW8yekpkRVJyZXM5U0M0Wm0rOFRwY3pQODkrMGJ6eEFEaG1HbUhUUURN?=
 =?utf-8?B?cGMwVGRENGlleHg1aExqa20vQ2tyMUwxTTNUU0FjTklEdTJpaDhMbkdyR1Vu?=
 =?utf-8?B?SDBOdEdweFJPZUEydnhZb3F2c3hMQ05BMVRoR28xbVQyNHV4RTNvaTVLaWty?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b828cc-0a73-4210-2266-08dcde50c750
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 17:29:30.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCvAgycX77N3bOPwpP+PhFJpN81lctnZ2DTu8/1WsDlLdHKjGLAWEUMJHi1GHIv5bjDaRRF1ttn7HPsLZvxSrDLWCcYruxuvM2RPMaJ3qec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6603
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI2LCAyMDI0IDEw
OjIwIEFNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50
ZWwuY29tPg0KPiBDYzogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNoZy5vcmc+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1tbUBrdmFjay5vcmc7IG5waGFtY3NA
Z21haWwuY29tOyBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFp
bC5jb207IHNoYWtlZWwuYnV0dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiBI
dWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtw
bUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVs
LmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBH
b3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY3IDYvOF0gbW06IHpzd2FwOiBTdXBwb3J0IG1USFAgc3dhcG91dCBpbg0KPiB6c3dhcF9z
dG9yZSgpLg0KPiANCj4gT24gVGh1LCBTZXAgMjYsIDIwMjQgYXQgOTo0MOKAr0FNIFNyaWRoYXIs
IEthbmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogWW9zcnkgQWht
ZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDI1LCAyMDI0IDk6NTIgUE0NCj4gPiA+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5j
aGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IEpvaGFubmVzIFdlaW5lciA8aGFu
bmVzQGNtcHhjaGcub3JnPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
PiBsaW51eC1tbUBrdmFjay5vcmc7IG5waGFtY3NAZ21haWwuY29tOyBjaGVuZ21pbmcuemhvdUBs
aW51eC5kZXY7DQo+ID4gPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyBzaGFrZWVsLmJ1dHRAbGlu
dXguZGV2Ow0KPiByeWFuLnJvYmVydHNAYXJtLmNvbTsNCj4gPiA+IEh1YW5nLCBZaW5nIDx5aW5n
Lmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiA+ID4g
Zm91bmRhdGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hh
bGksIFdhamRpIEsNCj4gPiA+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZp
bm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djcgNi84XSBtbTogenN3YXA6IFN1cHBvcnQgbVRIUCBzd2Fwb3V0IGluDQo+ID4gPiB6c3dhcF9z
dG9yZSgpLg0KPiA+ID4NCj4gPiA+IFsuLl0NCj4gPiA+ID4NCj4gPiA+ID4gT25lIHRoaW5nIEkg
cmVhbGl6ZWQgd2hpbGUgcmV3b3JraW5nIHRoZSBwYXRjaGVzIGZvciB0aGUgYmF0Y2hlZCBjaGVj
a3MNCj4gaXM6DQo+ID4gPiA+IHdpdGhpbiB6c3dhcF9zdG9yZV9wYWdlKCksIHdlIHNldCB0aGUg
ZW50cnktPm9iamNnIGFuZCBlbnRyeS0+cG9vbA0KPiBiZWZvcmUNCj4gPiA+ID4gYWRkaW5nIGl0
IHRvIHRoZSB4YXJyYXkuIEdpdmVuIHRoaXMsIHdvdWxkbid0IGl0IGJlIHNhZmVyIHRvIGdldCB0
aGUgb2JqY2cNCj4gPiA+ID4gYW5kIHBvb2wgcmVmZXJlbmNlIHBlciBzdWItcGFnZSwgbG9jYWxs
eSBpbiB6c3dhcF9zdG9yZV9wYWdlKCksIHJhdGhlcg0KPiB0aGFuDQo+ID4gPiA+IG9idGFpbmlu
ZyBiYXRjaGVkIHJlZmVyZW5jZXMgYXQgdGhlIGVuZCBpZiB0aGUgc3RvcmUgaXMgc3VjY2Vzc2Z1
bD8gSWYgd2UNCj4gPiA+IHdhbnQNCj4gPiA+ID4genN3YXBfc3RvcmVfcGFnZSgpIHRvIGJlIHNl
bGYtY29udGFpbmVkIGFuZCBjb3JyZWN0IGFzIGZhciBhcyB0aGUgZW50cnkNCj4gPiA+ID4gYmVp
bmcgY3JlYXRlZCBhbmQgYWRkZWQgdG8gdGhlIHhhcnJheSwgaXQgc2VlbXMgbGlrZSB0aGUgcmln
aHQgdGhpbmcgdG8NCj4gZG8/DQo+ID4gPiA+IEkgYW0gYSBiaXQgYXBwcmVoZW5zaXZlIGFib3V0
IHRoZSBlbnRyeSBiZWluZyBhZGRlZCB0byB0aGUgeGFycmF5DQo+IHdpdGhvdXQNCj4gPiA+ID4g
YSByZWZlcmVuY2Ugb2J0YWluZWQgb24gdGhlIG9iamNnIGFuZCBwb29sLCBiZWNhdXNlIGFueSBw
YWdlLQ0KPiA+ID4gZmF1bHRzL3dyaXRlYmFjaw0KPiA+ID4gPiB0aGF0IG9jY3VyIG9uIHN1Yi1w
YWdlcyBhZGRlZCB0byB0aGUgeGFycmF5IGJlZm9yZSB0aGUgZW50aXJlIGZvbGlvIGhhcw0KPiBi
ZWVuDQo+ID4gPiA+IHN0b3JlZCwgd291bGQgcnVuIGludG8gaXNzdWVzLg0KPiA+ID4NCj4gPiA+
IFdlIGRlZmluaXRlbHkgc2hvdWxkIG5vdCBvYnRhaW4gcmVmZXJlbmNlcyB0byB0aGUgcG9vbCBh
bmQgb2JqY2cgYWZ0ZXINCj4gPiA+IGluaXRpYWxpemluZyB0aGUgZW50cmllcyB3aXRoIHRoZW0u
IFdlIGNhbiBvYnRhaW4gYWxsIHJlZmVyZW5jZXMgaW4NCj4gPiA+IHpzd2FwX3N0b3JlKCkgYmVm
b3JlIHpzd2FwX3N0b3JlX3BhZ2UoKS4gSU9XLCB0aGUgYmF0Y2hpbmcgaW4gdGhpcw0KPiA+ID4g
Y2FzZSBzaG91bGQgYmUgZG9uZSBiZWZvcmUgdGhlIHBlci1wYWdlIG9wZXJhdGlvbnMsIG5vdCBh
ZnRlci4NCj4gPg0KPiA+IFRoYW5rcyBZb3NyeS4gSUlVQywgd2Ugc2hvdWxkIG9idGFpbiBhbGwg
cmVmZXJlbmNlcyB0byB0aGUgb2JqY2cgYW5kIHRvIHRoZQ0KPiA+IHpzd2FwX3Bvb2wgYXQgdGhl
IHN0YXJ0IG9mIHpzd2FwX3N0b3JlLg0KPiA+DQo+ID4gSW4gdGhlIGNhc2Ugb2YgZXJyb3Igb24g
YW55IHN1Yi1wYWdlLCB3ZSB3aWxsIHVud2luZCBzdGF0ZSBmb3IgcG90ZW50aWFsbHkNCj4gPiBv
bmx5IHRoZSBzdG9yZWQgcGFnZXMgb3IgdGhlIGVudGlyZSBmb2xpbyBpZiBpdCBoYXBwZW5lZCB0
byBhbHJlYWR5IGJlIGluDQo+IHpzd2FwDQo+ID4gYW5kIGlzIGJlaW5nIHJlLXdyaXR0ZW4uIFdl
IG1pZ2h0IG5lZWQgc29tZSBhZGRpdGlvbmFsIGJvb2sta2VlcGluZyB0bw0KPiA+IGtlZXAgdHJh
Y2sgb2Ygd2hpY2ggc3ViLXBhZ2VzIHdlcmUgZm91bmQgaW4gdGhlIHhhcnJheSBhbmQNCj4genN3
YXBfZW50cnlfZnJlZSgpDQo+ID4gZ290IGNhbGxlZCAobnJfc2IpLiBBc3N1bWluZyBJIGRlZmlu
ZSBhIG5ldyAib2JqX2Nncm91cF9wdXRfbWFueSgpIiwgSQ0KPiB3b3VsZCBuZWVkDQo+ID4gdG8g
Y2FsbCB0aGlzIHdpdGggKGZvbGlvX25yX3BhZ2VzKCkgLSBucl9zYikuDQo+ID4NCj4gPiBBcyBm
YXIgYXMgenN3YXBfcG9vbF9nZXQoKSwgdGhlcmUgaXMgc29tZSBhZGRlZCBjb21wbGV4aXR5IGlm
IHdlIHdhbnQgdG8NCj4gPiBrZWVwIHRoZSBleGlzdGluZyBpbXBsZW1lbnRhdGlvbiB0aGF0IGNh
bGxzICJwZXJjcHVfcmVmX3RyeWdldCgpIiwgYW5kDQo+IGFzc3VtaW5nDQo+ID4gdGhpcyBpcyBl
eHRlbmRlZCB0byBwcm92aWRlIGEgbmV3ICJ6c3dhcF9wb29sX2dldF9tYW55KCkiIHRoYXQgY2Fs
bHMNCj4gPiAicGVyY3B1X3JlZl90cnlnZXRfbWFueSgpIi4gSXMgdGhlcmUgYSByZWFzb24gd2Ug
dXNlIHBlcmNwdV9yZWZfdHJ5Z2V0KCkNCj4gaW5zdGVhZA0KPiA+IG9mIHBlcmNwdV9yZWZfZ2V0
KCk/IFJlYXNvbiBJIGFzayBpcywgd2l0aCB0cnlnZXQoKSwgaWYgZm9yIHNvbWUgcmVhc29uIHRo
ZQ0KPiBwb29sLT5yZWYNCj4gPiBpcyAwLCBubyBmdXJ0aGVyIGluY3JlbWVudHMgd2lsbCBiZSBt
YWRlLiBJZiBzbywgdXBvbiB1bndpbmRpbmcgc3RhdGUgaW4NCj4gPiB6c3dhcF9zdG9yZSgpLCBJ
IHdvdWxkIG5lZWQgdG8gc3BlY2lhbC1jYXNlIHRvIGNhdGNoIHRoaXMgYmVmb3JlIGNhbGxpbmcg
YQ0KPiBuZXcNCj4gPiAienN3YXBfcG9vbF9wdXRfbWFueSgpIi4NCj4gPg0KPiA+IFRoaW5ncyBj
b3VsZCBiZSBhIGxpdHRsZSBzaW1wbGVyIGlmIHpzd2FwX3Bvb2xfZ2V0KCkgY2FuIHVzZQ0KPiAi
cGVyY3B1X3JlZl9nZXQoKSINCj4gPiB3aGljaCB3aWxsIGFsd2F5cyBpbmNyZW1lbnQgdGhlIHJl
ZmNvdW50LiBTaW5jZSB0aGUgenN3YXAgcG9vbC0+cmVmIGlzDQo+IGluaXRpYWxpemVkDQo+ID4g
dG8gIjEiLCB0aGlzIHNlZW1zIE9rLCBidXQgSSBkb24ndCBrbm93IGlmIHRoZXJlIHdpbGwgYmUg
dW5pbnRlbmRlZA0KPiBjb25zZXF1ZW5jZXMuDQo+ID4NCj4gPiBDYW4geW91IHBsZWFzZSBhZHZp
c2Ugb24gd2hhdCBpcyB0aGUgc2ltcGxlc3QvY2xlYW5lc3QgYXBwcm9hY2g6DQo+ID4NCj4gPiAx
KSBQcm9jZWVkIHdpdGggdGhlIGFib3ZlIGNoYW5nZXMgd2l0aG91dCBjaGFuZ2luZyBwZXJjcHVf
cmVmX3RyeWdldCBpbg0KPiA+ICAgICAgenN3YXBfcG9vbF9nZXQuIE5lZWRzIHNwZWNpYWwtY2Fz
aW5nIGluIHpzd2FwX3N0b3JlIHRvIGRldGVjdCBwb29sLQ0KPiA+cmVmDQo+ID4gICAgIGJlaW5n
ICIwIiBiZWZvcmUgY2FsbGluZyB6c3dhcF9wb29sX3B1dFtfbWFueV0uDQo+IA0KPiBNeSBhc3N1
bXB0aW9uIGlzIHRoYXQgd2UgY2FuIHJlb3JkZXIgdGhlIGNvZGUgc3VjaCB0aGF0IGlmDQo+IHpz
d2FwX3Bvb2xfZ2V0X21hbnkoKSBmYWlscyB3ZSBkb24ndCBjYWxsIHpzd2FwX3Bvb2xfcHV0X21h
bnkoKSB0bw0KPiBiZWdpbiB3aXRoIChlLmcuIGp1bXAgdG8gYSBsYWJlbCBhZnRlciB6c3dhcF9w
b29sX3B1dF9tYW55KCkpLg0KDQpIb3dldmVyLCB0aGUgcG9vbCByZWZjb3VudCBjb3VsZCBjaGFu
Z2UgYmV0d2VlbiB0aGUgc3RhcnQgYW5kIGVuZCBvZg0KenN3YXBfc3RvcmUuDQoNCj4gDQo+ID4g
MikgTW9kaWZ5IHpzd2FwX3Bvb2xfZ2V0L3pzd2FwX3Bvb2xfZ2V0X21hbnkgdG8gdXNlDQo+IHBl
cmNwdV9yZWZfZ2V0X21hbnkNCj4gPiAgICAgYW5kIGF2b2lkIHNwZWNpYWwtY2FzaW5nIHRvIGRl
dGVjdCBwb29sLT5yZWYgYmVpbmcgIjAiIGJlZm9yZSBjYWxsaW5nDQo+ID4gICAgIHpzd2FwX3Bv
b2xfcHV0W19tYW55XS4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgd2UgY2FuIHNpbXBseSBzd2l0Y2gg
dGhlIHRyeWdldCB0byBhIGdldCwgYXMgSSBiZWxpZXZlDQo+IHdlIGNhbiByYWNlIHdpdGggdGhl
IHBvb2wgYmVpbmcgZGVzdHJveWVkLg0KDQpUaGF0IHdhcyBteSBpbml0aWFsIHRob3VnaHQgYXMg
d2VsbCwgYnV0IEkgZmlndXJlZCB0aGlzIGNvdWxkbid0IGhhcHBlbg0Kc2luY2UgdGhlIHBvb2wt
PnJlZiBpcyBpbml0aWFsaXplZCB0byAiMSIsIGFuZCBiYXNlZCBvbiB0aGUgZXhpc3RpbmcNCmlt
cGxlbWVudGF0aW9uLiBJbiBhbnkgY2FzZSwgSSBjYW4gdW5kZXJzdGFuZCB0aGUgaW50ZW50IG9m
IHRoZSB1c2UNCm9mICJ0cnlnZXQiOyBpdCBpcyBqdXN0IHRoYXQgaXQgYWRkcyB0byB0aGUgY29u
c2lkZXJhdGlvbnMgZm9yIHJlZmVyZW5jZQ0KYmF0Y2hpbmcuDQoNCj4gDQo+ID4gMykgS2VlcCB0
aGUgYXBwcm9hY2ggaW4gdjcgd2hlcmUgb2JqX2Nncm91cF9nZXQvcHV0IGlzIGxvY2FsaXplZCB0
bw0KPiA+ICAgICB6c3dhcF9zdG9yZV9wYWdlIGZvciBib3RoIHN1Y2Nlc3MgYW5kIGVycm9yIGNv
bmRpdGlvbnMsIGFuZCBhbnkNCj4gdW53aW5kaW5nDQo+ID4gICAgIHN0YXRlIGluIHpzd2FwX3N0
b3JlIHdpbGwgdGFrZSBjYXJlIG9mIGRyb3BwaW5nIHJlZmVyZW5jZXMgb2J0YWluZWQgZnJvbQ0K
PiA+ICAgICBwcmlvciBzdWNjZXNzZnVsIHdyaXRlcyAoZnJvbSB0aGlzIG9yIHByaW9yIGludm9j
YXRpb25zIG9mIHpzd2FwX3N0b3JlKS4NCj4gDQo+IEkgYW0gYWxzbyBmaW5lIHdpdGggZG9pbmcg
dGhhdCBhbmQgZG9pbmcgdGhlIHJlZmVyZW5jZSBiYXRjaGluZyBhcyBhIGZvbGxvdyB1cC4NCg0K
SSB0aGluayBzbyB0b28hIFdlIGNvdWxkIHRyeSBhbmQgaW1wcm92ZSB1cG9uICgzKSB3aXRoIHJl
ZmVyZW5jZSBiYXRjaGluZw0KaW4gYSBmb2xsb3ctdXAgcGF0Y2guDQoNClRoYW5rcywNCkthbmNo
YW5hDQoNCj4gDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEthbmNoYW5hDQo+ID4NCj4gPiA+
DQo+ID4gPiA+DQo+ID4gPiA+IEp1c3Qgd2FudGVkIHRvIHJ1biB0aGlzIGJ5IHlvdS4gVGhlIHJl
c3Qgb2YgdGhlIGJhdGNoZWQgY2hhcmdpbmcsIGF0b21pYw0KPiA+ID4gPiBhbmQgc3RhdCB1cGRh
dGVzIHNob3VsZCBiZSBPay4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiBLYW5j
aGFuYQ0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiA+IEth
bmNoYW5hDQo=


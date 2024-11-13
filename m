Return-Path: <linux-kernel+bounces-408308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005AA9C7D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838431F2307B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD56207A0D;
	Wed, 13 Nov 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRxGY/Rd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F720697E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531548; cv=fail; b=iNziSS591uVa+09FOq22mujuWcrSLbHGb8J8mcsiR8FiDrM1KL/O0LU5GlTtXf24ZWknxLO7Lyoob8U0V/4KgCfwyaAHkgN9NqUsBVJ7DueujrVUJnMmFHkfi/WY0pqCrKvFXmGXjxa+g9eKiyVJkaE2xouDs2Xn/p3GqSnL+HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531548; c=relaxed/simple;
	bh=/tRejyXDPPfhBqQEy5nqOWUrs+qJ+rTB/aVT+jEPln0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mNUZWLQEMwMH7mfVQKEUSan11FAnyD0RzpLPK3jiIWHJfKbSOVdEnXaHavcSNFQY+Z2ZEla8W0OPFReuQUuOCPMRjgSq0Ccg52xMrK72DkGp1HSe3KCZ0tiPsDVRjyj2cyDxQPxzAjyS/q+bAMKULt/yTzu1ngGq9VPcx3CUDlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRxGY/Rd; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731531547; x=1763067547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/tRejyXDPPfhBqQEy5nqOWUrs+qJ+rTB/aVT+jEPln0=;
  b=YRxGY/RdgSL4YS6ReiN86bjKiNKkXljrBBFJPByPwR2egxWoUTXA1CSL
   TXXZ0UONCudNLjFveWDCl02qmsVl3Un24z8KaHP+MuhkHOZCU4XAKE2dh
   LROcNfSoSYsPgqSkmVxUDtwKKpEGUqIba46CGgFGSlleSr8WtSYVAroBh
   K6vTHDl5dJt8DEruWd3iLgzXYBpxHqGoVr7FCGhMhBxB6bdXd+NHsW87b
   WxI7E0NwlFhZ9F7oO1FISgq++pIroEJnMg4dznWuMCs5OBz9s3tnI31+c
   uGraEWwikQPVd++J2fWAiftVku92tHn2bocn+1qwFOCEZUgPHzDOHfxDD
   A==;
X-CSE-ConnectionGUID: QEHEAdsnT/6faJkbzDCsfw==
X-CSE-MsgGUID: tvvmjziOSFqdvtqAZndMtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42833364"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="42833364"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 12:59:06 -0800
X-CSE-ConnectionGUID: xr4oMNDTQWOXgiwjWRfVaQ==
X-CSE-MsgGUID: +ebdVwwiTfqCAyN8ThyKSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="118810126"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 12:59:06 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 12:59:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 12:59:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 12:59:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsRGF1NnZlAoYrINJC9pdcRnjllGGTBEnE/2ChdbbInv+dVkh0ttwTc6YfMcJwQePD6+oowxYgn4F+AsFid+HZ2DAvsoFGLLGqG+bukyQ6QjYjfEd2wQjkoMDVKUxIJn/BqHIKIU097OmWBtZnJarY9LYqlEVdT3bgQK2xwYS/7IBPek4i/FQ+fv3lfBDcB1RkvP9R9Fwb/ZIDx9C7gpObjOmhrfV+JAHro86agEbRY4290ZNDezAii0Yh5ZVm0eV4m0vZoS89UEoL8yVcq2K4cWnZDBQkd6hh9iFpW1/z6I9SjCbIV9U88hRq6fnxb1DRhQHQrkRzvjJf9EIbsGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tRejyXDPPfhBqQEy5nqOWUrs+qJ+rTB/aVT+jEPln0=;
 b=MFHrzXmaViizGm5yFTh2MLuzddSrIgFIBlUjBbL7bOGpzQbmSqLJNn4qOrx2ONZiJcQRLNB+Lt5FQmw1IFTvavUlhomz954mTEYjv4KJ2vZeFZ+JdhlJQpN6mkcEIYvfjq1cZfoHESyvZgGKozy9aDcO1FbmEzjsMMsh1NrUVrdQZ53jMLzl3ukVXavsdoMeVzBD61jROU5KvzJyrFKaih5YNiKuvt7e4u8Uck75iIojJ9n6F9HW84qlPZIJMQgq9evNfDORKANazpfuomHnP8HdczdlPVBGeDS4eATwlptMgVVxxmDNbZAJ2e2KZ8BqOVALAblnG/oEZ6MKV/gKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 20:59:01 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 20:59:01 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAd4ICAAAwBAA==
Date: Wed, 13 Nov 2024 20:59:00 +0000
Message-ID: <SJ0PR11MB5678995E8E0B6B39509DB875C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZHvHUi0KpEW+M0k5A-9UfAGJzm++gzaaxdCbLsLFVQJw@mail.gmail.com>
In-Reply-To: <CAJD7tkZHvHUi0KpEW+M0k5A-9UfAGJzm++gzaaxdCbLsLFVQJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CH3PR11MB8703:EE_
x-ms-office365-filtering-correlation-id: 35d53c23-df72-4c4f-395d-08dd0425ffe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q2hIcjRheHc4am1mSHkyRC9LUCthdjBmTXcxMmNxOGJQcUNobFpQdDFwcjI2?=
 =?utf-8?B?MHJpUlJuVzVDRlhGV2pMdHVSNTBKSzJ4TFZDMmRHeCtvMmxyazBRcjBkRFVX?=
 =?utf-8?B?ekE0eDBYSjhMODZwZVZpVjVOeG52aDlxWkZBQ29qSURZcU5tZEIvcGFjL2ZB?=
 =?utf-8?B?V29sNlVTeWlMbTd5T0RDT2pJdk9YWktoZzJ1MFZoeFFPSThZUlRpZkRsSUdS?=
 =?utf-8?B?eFNmN0d1R292Szd3VVg1VHBHM0lJRDZhcXoyc001SHoyQlZYQ054akdZTVJj?=
 =?utf-8?B?dkVzWHJDcFg4WGZodWJqVWdIc0k1UEFWR3V6cjRtQ1NpYnhVMU9iNTZwcFhi?=
 =?utf-8?B?ZUpkczBQRGpKWEI5WjdYdjF3WTFqVXVDd3B2VVFUOU1VckcvOVFSeW53UHIx?=
 =?utf-8?B?L1p5VDBOclRiUGtsSGZDbk1OODRoamNmSThRR2wzcEs0TitMN3U5R2xySEFY?=
 =?utf-8?B?QmxieE53UzZscEYzU1hSVnFCR3V6UlgxNEZ3QVlWOWVYWWxVbFdKNkJQZFRp?=
 =?utf-8?B?Y29BclhSWnlkN2lKRGwxbFVVZkFlSHYyMUFCTnRuTTdBS2h3RlBVbWVoakdv?=
 =?utf-8?B?ZDQzNDhsRlJoc3lhVGgyZmR2UGtIQncrMDRPYk41S0x2UTJzUmlyTzRzS3ZG?=
 =?utf-8?B?QUtSMUc0TmFuQ004aVFrR29DdDR0bTJmM21vWG1UaVhJWjFlcVRISFlJZjNQ?=
 =?utf-8?B?YXNKdVQ2N0tUc3VqRlZnbncxYmw3cWVweEp4MFA2Qm40Lys5MFh2cWtON0dC?=
 =?utf-8?B?T3VxMTJLVGltdjEyNVlsZDF3emxxQktGMzlENGlUTDUwdEtIcE5NdU4rOVkr?=
 =?utf-8?B?b2hPRTFnMkVTMGxZMVAyUDU5RFF2S0tJWDJ3Z2JiNWIxSTA5NEluNzVBOVln?=
 =?utf-8?B?TG0yRGV0NThvMkZEcGZBRUo2VVNBRldsWTBlWFVZQWxMbElibXBRcjA1eUs2?=
 =?utf-8?B?MGgvTmppT2dKQlRTTHlnL1hKeDdmMnVQQXFYbkVGQ1J4dE9iZFlYWHFVMVBO?=
 =?utf-8?B?NkhFeUVZdkNzdlQ2aFRpc0J4K1lDVVNKWE1QZjZ1VFdvQno2aG12d0RNTGhP?=
 =?utf-8?B?d3JPRkZXdFdBOFRSZDcxZHo1R0xYK3dTclVDL2tCRG9pRUtkcXZIaTk1dkQz?=
 =?utf-8?B?dXZzWWlWQ0h2REdGRC9vc2twcHozSnZXY1hOWFBONWI3djRybGEwdzdWeUtq?=
 =?utf-8?B?OGdtRjNyWEp6V1VRRy9SZHF3WG5PaVVIYzlDVE1WK0E4Ni9xcG9BR2xCeXdE?=
 =?utf-8?B?T3p1MlVpWjZHTFFiVzh4b0JzY28xZHlSV05XWTZoRGdJODZnZ0hGUFVCQTRL?=
 =?utf-8?B?SGFTaU93Wnp4M0lIYlJCNVZGOU9BWkVLTCtVZC8yMnRrVnF0aXR0ekpGVzc0?=
 =?utf-8?B?Qmo2cThzbFZaUjNjK0d4VGIzYld1TStuNDNTZDJpc1pRaW1qai9FLzFDRmdu?=
 =?utf-8?B?S0YrTG5xWTY5dURJYVBRTkxyRUFOemlzR05XeXkvU0RCaDFYemc2QlpOYlJ6?=
 =?utf-8?B?bTF1SjRaTjRNMTNvS2lrVWFmS20vYlpKOUNEZTZublh2QTdHUVVPYTg3RUdD?=
 =?utf-8?B?UlB0Z3VIZVh5RWVNZXo2Yjk1cjVkZGJMZEtGZ2wya1dyZHl6TCtLazgzNTl0?=
 =?utf-8?B?cnBKMXd5OEszQTg1aWIrbjlVR3BuaTJaeWE1c1hyZG1HeStQSlc4YWJ1MmRy?=
 =?utf-8?B?UmNSQ1JzRFRwODNQQlh2TXVsdlNndHNYMk5CVHNEZkVFclp0Mjk5RFhHMHI4?=
 =?utf-8?B?b2xHYlgrYVA5SVppRTd3TklzczJFSlRna21Td1daaXdWTnkyK1FtVXQvYVRF?=
 =?utf-8?Q?bcw/W07Uvw9dd3WGkfeGc+SgEa004kAB4ismg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0M0aXJTZXg5NFlUWjl5ZmtVQitReVBYc2VsRy9jNDJmeTc5L01rNU1XMzQx?=
 =?utf-8?B?NnlMOEZKYXRqeWFGUDJCTXlWNlBLNzZyV1Y3OFJnQ0lVT3VjcDU0ZVluRUFB?=
 =?utf-8?B?NWVuWGNzTS9SeUdvT1RuOVYrR0h6SEZzL3RQTkp0Vm0zTkhjSE1VNVErck0r?=
 =?utf-8?B?T3o0MCtOZElTUnRKK1lKdEYxTWJQRlBpank3cGwrMEpxdHdNQkZWbUVXSXRn?=
 =?utf-8?B?Wk9xdFFYcExvamIva2hGbnRmK0xHSDQxd3RFekZVelY4T00zNVQwbDN6aXBS?=
 =?utf-8?B?aXZ5VUFDRUl5RHluLzlreTlYbEpFZnpURWk2dFN3V0UvbjhiVFoveUpyeWMy?=
 =?utf-8?B?SVk4bWdlTVk1THU3SElINWVyajVXeWowMit1RTJMaEFEQzYyZWhqcjJOejFi?=
 =?utf-8?B?UkhoQmk3cnRZQUVmN0NGTGwzbHJEajU4M2R4eENabno0RWtyT240ZHpmUE11?=
 =?utf-8?B?dGphM0dXOGJsWEhjbVMxZVVia3FMZ3VKYVlvRGNsTC9sUy9sMmo4bTFQSHBp?=
 =?utf-8?B?TVZ5ellqMFRocktZWU9KTVRkWGcwNFlNeW5UZWxTSTNqeU1TR2RubjdqVnIr?=
 =?utf-8?B?NjduM3crUzdKWW0zMkk0cjNqZWtPN2RFeFFnN3dMaDRlOGI0T3ZCQzBpWlVj?=
 =?utf-8?B?c21hTTBZOU9PcmZ6bit3K0h5R3ovdmR4QUI5MGR6TlVLTCtHZjc3eUJQdzRQ?=
 =?utf-8?B?NHRlSUVsWmdtOXdySzRuZS91MDJKejVTWEh3emRmZ01CaGF0eC9Qa3FQeGdY?=
 =?utf-8?B?VXVzQjk3NUVJN0ZwS2cvTU81THZEMndvay8rWEhWaDZDMCszbGZ0aWZqU3I1?=
 =?utf-8?B?N1lBVVBKUnNDZERFTDR6VHE5M3lEZ2RQU1BnbWxBeXJ5SytUYnRjcDhXb1dC?=
 =?utf-8?B?aEVUSkozRjloVnlwY0lPd3Bud2JJN2toK2NnYkxwaTU4NUpXa2pxalFGYUJ6?=
 =?utf-8?B?Z21wdkNmVTV2NmhvQlVOanc0OHRYUzZabTBYYk85bC8zTUVtWFh6WlZOanJ4?=
 =?utf-8?B?ZlVzQzNmSm9nUjVuSHBrRmNNY2x0YnE0NzBqMU1hTHNMdlFOaTdDcFUrQlpD?=
 =?utf-8?B?UnpkS2s2TDlLcTBwTEVkR0g2NzFMSElHczZpcHFqTC84d2ZUOXdXUDU5clVQ?=
 =?utf-8?B?ZU44T0Yya0FtR29IYnRDbkRVQVJBdlNjQVRabGRiRG15c2w4SldkcGg2bmVr?=
 =?utf-8?B?NjVwWkRja3ArUGpLTExmRDIyQ1pHc0R5enIzb3hVYTUrTkljSlVnR29LeU1J?=
 =?utf-8?B?Z24zRFUrSlRjNC9GZkx2SVhRSXNBaVpLcXdKUXF5amxDaUJhclF4VmttZ2o5?=
 =?utf-8?B?MFNzcnNBRzJaUWtUYXFWT3ZBL1FJR0xqeGphbkRMQlM4Sm0wdmNETnpvOEU1?=
 =?utf-8?B?UlhuRTczL21KTWl0RUpTb25qdE4yVVBjVTBkb3dlVFV2S0JuQm5UYTlhZ1V1?=
 =?utf-8?B?L3M5cU5pTTMwOUpuZE8vb2NHMVpKcWNXYmF0MmF2djdvQXhYQllML0JLWW1R?=
 =?utf-8?B?cEZpZkFQUEZLUlpMNHBLMkFsQ3Q4Y3JUOHc0TVZlSGR5cDlEc2ZCdis1K3Jv?=
 =?utf-8?B?bkhIMkFkZ2R5Q0srbFgyaDFLbndIWmxJTlFPcVh0RGRQb3E3VzJ6UUlpcUNZ?=
 =?utf-8?B?eTY2Ullxb3lZMW1JU0ROb05qOGpMQVVRYm9CWktTNFR2a3FmMWpTeW9WbEtX?=
 =?utf-8?B?dXZLUlZyTWM1aG9vN1N1MktkMHFKRUgrR1owM1JCWFNlWFlPYnpIUUplZ1hR?=
 =?utf-8?B?NXJaMyticXRGRVlmZS9RRDB4S1FEeU5EaVljZWV5ZVdIRUVKYVhXa2V0clJI?=
 =?utf-8?B?OU50NmNqeTZNSkMxNjVKTVFGdUpWeXJlREsrRFRldHZCT3ptTy9Qbkk5Nk1D?=
 =?utf-8?B?ZG5zWitqd2s3eVk5Wk5Nd042TzdWelFkdHdLdWphZWpFOTdadHJBTEhCVjhK?=
 =?utf-8?B?Nzk0RERaRnRhMGZ1bDJPdU9Tc2RrQnRVdmNYT2JQR0Nnb09ESHJsZWJUT2JQ?=
 =?utf-8?B?cXIvQlJQS0VETTlkZjJuN0JoTmg0bHA4NXhxL2xOS01oelhsVVRRM1dHVFJt?=
 =?utf-8?B?aGtYdVU4MU00WVl2V25NZm94a3lIYlVoTnE2bEQwR2lUQ09tbW9mQmYwUDFk?=
 =?utf-8?B?WGtqajUvZzZzd1hZb3hXQjdvcmt3cndjNXA3YXErdEVMak9YRXVBajgxNUdN?=
 =?utf-8?B?U3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d53c23-df72-4c4f-395d-08dd0425ffe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 20:59:00.9515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/wGt1039lkqovirs334KuCgkqelvfR/IAgnWZISbHTWKbc1mHdlUzPKF8GXhsLu2QGKQHkkXCnJI5E8gZ6HYQ0QdtkuNdrzVHxlm1oAWb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMjQg
MTI6MTEgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBp
bnRlbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBr
dmFjay5vcmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207IGNoZW5n
bWluZy56aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgcnlhbi5yb2Jl
cnRzQGFybS5jb207IEh1YW5nLCBZaW5nDQo+IDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25i
YW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBGZWdoYWxpLCBXYWpk
aSBLIDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaA0KPiA8dmlub2Ro
LmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2FwOiBG
aXggYSBwb3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4genN3YXBfZGVjb21wcmVzcygpLg0KPiAN
Cj4gT24gV2VkLCBOb3YgMTMsIDIwMjQgYXQgMTE6MTLigK9BTSBTcmlkaGFyLCBLYW5jaGFuYSBQ
DQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIFlv
c3J5LA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
WW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXks
IE5vdmVtYmVyIDEyLCAyMDI0IDEwOjIyIFBNDQo+ID4gPiBUbzogU3JpZGhhciwgS2FuY2hhbmEg
UCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gPiA+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+ID4gPiBoYW5uZXNAY21weGNo
Zy5vcmc7IG5waGFtY3NAZ21haWwuY29tOw0KPiBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+
ID4gPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcs
IFlpbmcNCj4gPiA+IDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBh
a3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsNCj4gPiA+IEZlZ2hhbGksIFdhamRpIEsgPHdh
amRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoDQo+ID4gPiA8dmlub2RoLmdv
cGFsQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG1tOiB6c3dhcDog
Rml4IGEgcG90ZW50aWFsIG1lbW9yeSBsZWFrIGluDQo+ID4gPiB6c3dhcF9kZWNvbXByZXNzKCku
DQo+ID4gPg0KPiA+ID4gT24gVHVlLCBOb3YgMTIsIDIwMjQgYXQgOTo1OeKAr1BNIFNyaWRoYXIs
IEthbmNoYW5hIFANCj4gPiA+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToN
Cj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gPiA+IEZyb206IFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+ID4g
PiA+ID4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIwMjQgOTozNSBQTQ0KPiA+ID4gPiA+
IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0K
PiA+ID4gPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFj
ay5vcmc7DQo+ID4gPiA+ID4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsN
Cj4gPiA+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsNCj4gPiA+ID4gPiB1c2FtYWFyaWY2NDJA
Z21haWwuY29tOyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcNCj4gPiA+ID4gPiA8
eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4g
PiA+IGZvdW5kYXRpb24ub3JnOw0KPiA+ID4gPiA+IEZlZ2hhbGksIFdhamRpIEsgPHdhamRpLmsu
ZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoDQo+ID4gPiA+ID4gPHZpbm9kaC5nb3Bh
bEBpbnRlbC5jb20+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2Fw
OiBGaXggYSBwb3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4gPiA+ID4gPiB6c3dhcF9kZWNvbXBy
ZXNzKCkuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBUdWUsIE5vdiAxMiwgMjAyNCBhdCA5OjI0
4oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFyDQo+ID4gPiA+ID4gPGthbmNoYW5hLnAuc3JpZGhhckBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoaXMgaXMgYSBob3Rm
aXggZm9yIGEgcG90ZW50aWFsIHpwb29sIG1lbW9yeSBsZWFrIHRoYXQgY291bGQgcmVzdWx0IGlu
DQo+ID4gPiA+ID4gPiB0aGUgZXhpc3RpbmcgenN3YXBfZGVjb21wcmVzcygpOg0KPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhY29tcF9jdHgtPm11dGV4KTsN
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgICAgICAgIGlmIChzcmMgIT0gYWNvbXBfY3R4LT5i
dWZmZXIpDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgenBvb2xfdW5tYXBfaGFuZGxlKHpw
b29sLCBlbnRyeS0+aGFuZGxlKTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBSZWxlYXNpbmcg
dGhlIGxvY2sgYmVmb3JlIHRoZSBjb25kaXRpb25hbCBkb2VzIG5vdCBwcm90ZWN0IHRoZQ0KPiBp
bnRlZ3JpdHkNCj4gPiA+IG9mDQo+ID4gPiA+ID4gPiAic3JjIiwgd2hpY2ggaXMgc2V0IGVhcmxp
ZXIgdW5kZXIgdGhlIGFjb21wX2N0eCBtdXRleCBsb2NrLiBUaGlzDQo+IHBvc2VzIGENCj4gPiA+
ID4gPiA+IHJpc2sgZm9yIHRoZSBjb25kaXRpb25hbCBiZWhhdmluZyBhcyBpbnRlbmRlZCwgYW5k
IGNvbnNlcXVlbnRseSBub3QNCj4gPiA+ID4gPiA+IHVubWFwcGluZyB0aGUgenBvb2wgaGFuZGxl
LCB3aGljaCBjb3VsZCBjYXVzZSBhIHpzd2FwIHpwb29sDQo+IG1lbW9yeQ0KPiA+ID4gPiA+IGxl
YWsuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBtb3ZlcyB0aGUgbXV0ZXhf
dW5sb2NrKCkgdG8gb2NjdXIgYWZ0ZXIgdGhlIGNvbmRpdGlvbmFsDQo+IGFuZA0KPiA+ID4gPiA+
ID4gc3Vic2VxdWVudCB6cG9vbF91bm1hcF9oYW5kbGUoKS4gVGhpcyBlbnN1cmVzIHRoYXQgdGhl
IHZhbHVlIG9mDQo+ICJzcmMiDQo+ID4gPiA+ID4gPiBvYnRhaW5lZCBlYXJsaWVyLCB3aXRoIHRo
ZSBtdXRleCBsb2NrZWQsIGRvZXMgbm90IGNoYW5nZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRo
ZSBjb21taXQgbG9nIGlzIHRvbyBjb21wbGljYXRlZCBhbmQgaW5jb3JyZWN0LiBJdCBpcyB0YWxr
aW5nIGFib3V0DQo+ID4gPiA+ID4gdGhlIHN0YWJpbGl0eSBvZiAnc3JjJywgYnV0IHRoYXQncyBh
IGxvY2FsIHZhcmlhYmxlIG9uIHRoZSBzdGFjaw0KPiA+ID4gPiA+IGFueXdheS4gSXQgZG9lc24n
dCBuZWVkIHByb3RlY3Rpb24uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgcHJvYmxlbSBpcyAn
YWNvbXBfY3R4LT5idWZmZXInIGJlaW5nIHJldXNlZCBhbmQgY2hhbmdlZCBhZnRlcg0KPiB0aGUN
Cj4gPiA+ID4gPiBtdXRleCBpcyByZWxlYXNlZC4gTGVhZGluZyB0byB0aGUgY2hlY2sgbm90IGJl
aW5nIHJlbGlhYmxlLiBQbGVhc2UNCj4gPiA+ID4gPiBzaW1wbGlmeSB0aGlzLg0KPiA+ID4gPg0K
PiA+ID4gPiBUaGFua3MgWW9zcnkuIFRoYXQncyBleGFjdGx5IHdoYXQgSSBtZWFudCwgYnV0IEkg
dGhpbmsgdGhlIHdvcmRpbmcgZ290DQo+ID4gPiA+IGNvbmZ1c2luZy4gVGhlIHByb2JsZW0gSSB3
YXMgdHJ5aW5nIHRvIGZpeCBpcyB0aGUgYWNvbXBfY3R4LT5idWZmZXINCj4gPiA+ID4gdmFsdWUg
Y2hhbmdpbmcgYWZ0ZXIgdGhlIGxvY2sgaXMgcmVsZWFzZWQuIFRoaXMgY291bGQgaGFwcGVuIGFz
IGEgcmVzdWx0DQo+IG9mDQo+ID4gPiBhbnkNCj4gPiA+ID4gb3RoZXIgY29tcHJlc3Mgb3IgZGVj
b21wcmVzcyB0aGF0IGFjcXVpcmVzIHRoZSBsb2NrLiBJIHdpbGwgc2ltcGxpZnkgYW5kDQo+ID4g
PiA+IGNsYXJpZnkgYWNjb3JkaW5nbHkuDQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBFdmVuIHRob3VnaCBhbiBhY3R1YWwgbWVtb3J5IGxlYWsgd2FzIG5vdCBv
YnNlcnZlZCwgdGhpcyBmaXggc2VlbXMNCj4gPiA+IGxpa2UgYQ0KPiA+ID4gPiA+ID4gY2xlYW5l
ciBpbXBsZW1lbnRhdGlvbi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBLYW5jaGFuYSBQIFNyaWRoYXIgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4g
PiA+ID4gPiBGaXhlczogOWM1MDA4MzVmMjc5ICgibW06IHpzd2FwOiBmaXgga2VybmVsIEJVRyBp
biBzZ19pbml0X29uZSIpDQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBtbS96c3dhcC5j
IHwgMyArKy0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL21tL3pz
d2FwLmMgYi9tbS96c3dhcC5jDQo+ID4gPiA+ID4gPiBpbmRleCBmNjMxNmI2NmZiMjMuLjU4ODEw
ZmE4ZmYyMyAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL21tL3pzd2FwLmMNCj4gPiA+ID4gPiA+
ICsrKyBiL21tL3pzd2FwLmMNCj4gPiA+ID4gPiA+IEBAIC05ODYsMTAgKzk4NiwxMSBAQCBzdGF0
aWMgdm9pZCB6c3dhcF9kZWNvbXByZXNzKHN0cnVjdA0KPiA+ID4gPiA+IHpzd2FwX2VudHJ5ICpl
bnRyeSwgc3RydWN0IGZvbGlvICpmb2xpbykNCj4gPiA+ID4gPiA+ICAgICAgICAgYWNvbXBfcmVx
dWVzdF9zZXRfcGFyYW1zKGFjb21wX2N0eC0+cmVxLCAmaW5wdXQsICZvdXRwdXQsDQo+ID4gPiBl
bnRyeS0NCj4gPiA+ID4gPiA+bGVuZ3RoLCBQQUdFX1NJWkUpOw0KPiA+ID4gPiA+ID4NCj4gQlVH
X09OKGNyeXB0b193YWl0X3JlcShjcnlwdG9fYWNvbXBfZGVjb21wcmVzcyhhY29tcF9jdHgtDQo+
ID4gPiA+ID4gPnJlcSksICZhY29tcF9jdHgtPndhaXQpKTsNCj4gPiA+ID4gPiA+ICAgICAgICAg
QlVHX09OKGFjb21wX2N0eC0+cmVxLT5kbGVuICE9IFBBR0VfU0laRSk7DQo+ID4gPiA+ID4gPiAt
ICAgICAgIG11dGV4X3VubG9jaygmYWNvbXBfY3R4LT5tdXRleCk7DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gICAgICAgICBpZiAoc3JjICE9IGFjb21wX2N0eC0+YnVmZmVyKQ0KPiA+ID4gPiA+
ID4gICAgICAgICAgICAgICAgIHpwb29sX3VubWFwX2hhbmRsZSh6cG9vbCwgZW50cnktPmhhbmRs
ZSk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBY3R1YWxseSBub3cgdGhhdCBJIHRoaW5rIG1vcmUg
YWJvdXQgaXQsIEkgdGhpbmsgdGhpcyBjaGVjayBpc24ndA0KPiA+ID4gPiA+IGVudGlyZWx5IHNh
ZmUsIGV2ZW4gdW5kZXIgdGhlIGxvY2suIElzIGl0IHBvc3NpYmxlIHRoYXQNCj4gPiA+ID4gPiAn
YWNvbXBfY3R4LT5idWZmZXInIGp1c3QgaGFwcGVucyB0byBiZSBlcXVhbCB0byAnc3JjJyBmcm9t
IGEgcHJldmlvdXMNCj4gPiA+ID4gPiBkZWNvbXByZXNzaW9uIGF0IHRoZSBzYW1lIGhhbmRsZT8g
SW4gdGhpcyBjYXNlLCB3ZSB3aWxsIGFsc28NCj4gPiA+ID4gPiBtaXN0YWtlbmx5IHNraXAgdGhl
IHVubWFwLg0KPiA+ID4gPg0KPiA+ID4gPiBJZiB3ZSBtb3ZlIHRoZSBtdXRleF91bmxvY2sgdG8g
aGFwcGVuIGFmdGVyIHRoZSBjb25kaXRpb25hbCBhbmQNCj4gdW5tYXAsDQo+ID4gPiA+IHNob3Vs
ZG4ndCB0aGF0IGJlIHN1ZmZpY2llbnQgdW5kZXIgYWxsIGNvbmRpdGlvbnM/IFdpdGggdGhlIGZp
eCwgInNyYyIgY2FuDQo+ID4gPiA+IHRha2Ugb24gb25seSAyIHZhbHVlcyBpbiB0aGlzIHByb2Nl
ZHVyZTogdGhlIG1hcHBlZCBoYW5kbGUgb3INCj4gPiA+ID4gYWNvbXBfY3R4LT5idWZmZXIuIFRo
ZSBvbmx5IGFtYmlndWl0eSB3b3VsZCBiZSBpbiB0aGUgKHVubGlrZWx5PykgY2FzZQ0KPiA+ID4g
PiBpZiB0aGUgbWFwcGVkIHpwb29sIGhhbmRsZSBoYXBwZW5zIHRvIGJlIGVxdWFsIHRvIGFjb21w
X2N0eC0+YnVmZmVyLg0KPiA+ID4NCj4gPiA+IFllcywgdGhhdCdzIHRoZSBzY2VuYXJpbyBJIG1l
YW4uDQo+ID4gPg0KPiA+ID4gU3BlY2lmaWNhbGx5LCBpbiB6c3dhcF9kZWNvbXByZXNzKCksIHdl
IGRvIG5vdCB1c2UgJ2Fjb21wX2N0eC0+YnVmZmVyJw0KPiA+ID4gc28gJ3NyYycgaXMgZXF1YWwg
dG8gdGhlIG1hcHBlZCBoYW5kbGUuIEJ1dCwgJ2Fjb21wX2N0eC0+YnVmZmVyJw0KPiA+ID4gaGFw
cGVucyB0byBiZSBlcXVhbCB0byB0aGUgc2FtZSBoYW5kbGUgZnJvbSBhIHByZXZpb3VzIG9wZXJh
dGlvbiBhcyB3ZQ0KPiA+ID4gZG9uJ3QgY2xlYXIgaXQuDQo+ID4NCj4gPiBBbHRob3VnaCwgd2Ug
bmV2ZXIgbW9kaWZ5ICdhY29tcF9jdHgtPmJ1ZmZlcicgaW4genN3YXBfZGVjb21wcmVzcygpLA0K
PiA+IHdlIG9ubHkgY29weSB0byBpdC4NCj4gDQo+IER1aCwgeWVzLiBJIGNvbmZ1c2VkIG15c2Vs
Ziwgc29ycnkgZm9yIHRoZSBub2lzZS4NCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiBJbiB0aGlzIGNh
c2UsIHRoZSAnc3JjICE9IGFjb21wX2N0eC0+YnVmZmVyJyBjaGVjayB3aWxsIGJlIGZhbHNlLCBl
dmVuDQo+ID4gPiB0aG91Z2ggaXQgc2hvdWxkIGJlIHRydWUuIFRoaXMgd2lsbCByZXN1bHQgaW4g
YW4gZXh0cmENCj4gPiA+IHpwb29sX3VubWFwX2hhbmRsZSgpIGNhbGwuIEkgZGlkbid0IGxvb2sg
Y2xvc2VseSwgYnV0IHRoaXMgc2VlbXMgbGlrZQ0KPiA+ID4gaXQgY2FuIGhhdmUgYSB3b3JzZSBl
ZmZlY3QgdGhhbiBsZWFraW5nIG1lbW9yeSAoZS5nLiB0aGVyZSB3aWxsIGJlIGFuDQo+ID4gPiBl
eHRyYSBfX2t1bm1hcF9hdG9taWMoKSBjYWxsIGluIHpzbWFsbG9jLCBhbmQgd2UgbWF5IGVuZCB1
cCBjb3JydXB0aW5nDQo+ID4gPiBhIHJhbmRvbSBoYW5kbGUpLg0KPiA+ID4NCj4gPiA+ID4NCj4g
PiA+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgYW0gbWlzc2luZyBhbnl0aGluZy4NCj4gPiA+
ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEl0IHdvdWxkIGJlIG1vcmUgcmVsaWFibGUgdG8gc2V0
IGEgYm9vbGVhbiB2YXJpYWJsZSBpZiB3ZSBjb3B5IHRvDQo+ID4gPiA+ID4gYWNvbXBfY3R4LT5i
dWZmZXIgYW5kIGRvIHRoZSB1bm1hcCwgYW5kIGNoZWNrIHRoYXQgZmxhZyBoZXJlIHRvDQo+IGNo
ZWNrDQo+ID4gPiA+ID4gaWYgdGhlIHVubWFwIHdhcyBkb25lIG9yIG5vdC4NCj4gPiA+ID4NCj4g
PiA+ID4gU3VyZSwgdGhpcyBjb3VsZCBiZSBkb25lLCBidXQgbm90IHN1cmUgaWYgaXQgaXMgcmVx
dWlyZWQuIFBsZWFzZSBsZXQgbWUga25vdw0KPiA+ID4gPiBpZiB3ZSBzdGlsbCBuZWVkIHRoZSBi
b29sZWFuIHZhcmlhYmxlIGluIGFkZGl0aW9uIHRvIG1vdmluZyB0aGUNCj4gPiA+IG11dGV4X3Vu
bG9jaygpLg0KPiA+ID4NCj4gPiA+IElmIHdlIHVzZSBhIGJvb2xlYW4sIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gbW92ZSBtdXRleF91bmxvY2soKS4gVGhlDQo+ID4gPiBib29sZWFuIHdpbGwgYmUgYSBs
b2NhbCB2YXJpYWJsZSBvbiB0aGUgc3RhY2sgdGhhdCBkb2Vzbid0IG5lZWQNCj4gPiA+IHByb3Rl
Y3Rpb24uDQo+ID4NCj4gPiBJIGFncmVlLCB1c2luZyB0aGUgYm9vbGVhbiB2YXJpYWJsZSB0byBk
byB0aGUgdW5tYXAgcmF0aGVyIHRoYW4gdGhlIGNoZWNrDQo+ID4gZm9yIChzcmMgIT0gYWNvbXBf
Y3R4LT5idWZmZXIpIGlzIG1vcmUgZmFpbC1zYWZlLg0KPiA+DQo+ID4gSSBhbSBzdGlsbCB0aGlu
a2luZyBtb3ZpbmcgdGhlIG11dGV4X3VubG9jaygpIGNvdWxkIGhlbHAsIG9yIGF0IGxlYXN0IGhh
dmUNCj4gPiBubyBkb3duc2lkZS4gVGhlIGFjb21wX2N0eCBpcyBwZXItY3B1IGFuZCBpdCdzIG11
dGV4X2xvY2svdW5sb2NrDQo+ID4gc2FmZWd1YXJkcyB0aGUgaW50ZXJhY3Rpb24gYmV0d2VlbiB0
aGUgZGVjb21wcmVzcyBvcGVyYXRpb24sIHRoZQ0KPiA+IHNnXyooKSBBUEkgY2FsbHMgaW5zaWRl
IHpzd2FwX2RlY29tcHJlc3MoKSBhbmQgdGhlIHNoYXJlZCB6cG9vbC4NCj4gPg0KPiA+IElmIHdl
IHJlbGVhc2UgdGhlIHBlci1jcHUgYWNvbXBfY3R4J3MgbXV0ZXggbG9jayBiZWZvcmUgdGhlDQo+
ID4genBvb2xfdW5tYXBfaGFuZGxlKCksIGlzIGl0IHBvc3NpYmxlIHRoYXQgYW5vdGhlciBjcHUg
Y291bGQgYWNxdWlyZQ0KPiA+IGl0J3MgYWNvbXBfY3R4J3MgbG9jayBhbmQgbWFwIHRoZSBzYW1l
IHpwb29sIGhhbmRsZSAodGhhdCB0aGUgZWFybGllcg0KPiA+IGNwdSBoYXMgeWV0IHRvIHVubWFw
IG9yIGlzIGNvbmN1cnJlbnRseSB1bm1hcHBpbmcpIGZvciBhIHdyaXRlPw0KPiA+IElmIHRoaXMg
Y291bGQgaGFwcGVuLCB3b3VsZCBpdCByZXN1bHQgaW4gdW5kZWZpbmVkIHN0YXRlIGZvciBib3Ro
DQo+ID4gdGhlc2UgenBvb2wgb3BzIG9uIGRpZmZlcmVudCBjcHUncz8NCj4gDQo+IFdoeSB3b3Vs
ZCB0aGlzIHJlc3VsdCBpbiBhbiB1bmRlZmluZWQgc3RhdGU/IEZvciB6c21hbGxvYywgbWFwcGlu
Zw0KPiB1c2VzIGEgcGVyLUNQVSBidWZmZXIgYW5kIHByZWVtcHRpb24gaXMgZGlzYWJsZWQgYmV0
d2VlbiBtYXBwaW5nIGFuZA0KPiB1bm1hcHBpbmcgYW55d2F5LiBJZiBhbm90aGVyIENQVSBtYXBz
IHRoZSBvYmplY3QgaXQgc2hvdWxkIGJlIGZpbmUuDQo+IA0KPiA+DQo+ID4gV291bGQga2VlcGlu
ZyB0aGUgcGVyLWNwdSBtdXRleCBsb2NrZWQgdGhyb3VnaCB0aGUNCj4gPiB6cG9vbF91bm1hcF9o
YW5kbGUoKSBjcmVhdGUgYSBub24tcHJlZW1wdGlibGUgc3RhdGUgdGhhdCB3b3VsZA0KPiA+IGF2
b2lkIHRoaXM/IElPVywgaWYgdGhlIGFib3ZlIHNjZW5hcmlvIGlzIHBvc3NpYmxlLCBkb2VzIHRo
ZSBwZXItY3B1DQo+ID4gYWNvbXBfY3R4J3MgbXV0ZXggaGVscC9pcyBhIG5vLW9wPyBPciwgaXMg
dGhlIGFib3ZlIHNjZW5hcmlvIHNvbWVob3cNCj4gPiBwcmV2ZW50ZWQgYnkgdGhlIGltcGxlbWVu
dGF0aW9uIG9mIHRoZSB6cG9vbHM/DQo+IA0KPiBBdCBsZWFzdCBmb3IgenNtYWxsb2MsIEkgdGhp
bmsgaXQgaXMuDQo+IA0KPiA+DQo+ID4gSnVzdCB0aG91Z2h0IEkgd291bGQgYnJpbmcgdXAgdGhl
c2Ugb3BlbiBxdWVzdGlvbnMuIFBsZWFzZSBkbyBzaGFyZQ0KPiA+IHlvdXIgdGhvdWdodHMgYW5k
IGFkdmlzZS4NCj4gDQo+IEkgdGhpbmsgbW92aW5nIHRoZSBtdXRleCB1bmxvY2sgYWZ0ZXIgdGhl
IHVubWFwIHdvbid0IG1ha2UgbXVjaCBvZiBhDQo+IGRpZmZlcmVuY2UgZnJvbSBhIHBlcmZvcm1h
bmNlIHNpZGUsIGF0IGxlYXN0IGZvciB6c21hbGxvYy4gUHJlZW1wdGlvbg0KPiB3aWxsIGJlIGRp
c2FibGVkIHVudGlsIHRoZSB1bm1hcCBpcyBkb25lIGFueXdheSwgc28gZXZlbiBhZnRlciB3ZQ0K
PiByZWxlYXNlIHRoZSBwZXItQ1BVIG11dGV4IGl0IGNhbm5vdCBiZSBhY3F1aXJlZCBieSBhbnlv
bmUgZWxzZSB1bnRpbA0KPiB0aGUgdW5tYXAgaXMgZG9uZS4NCj4gDQo+IEFueXdheSwgSSB0aGlu
ayB0aGUgZml4IHlvdSBoYXZlIHJpZ2h0IG5vdyBpcyBmaW5lLCBpZiB5b3UgcHJlZmVyIG5vdA0K
PiBhZGRpbmcgYSBib29sZWFuLiBJZiB5b3UgZG8gYWRkIGEgYm9vbGVhbiwgd2hldGhlciB5b3Ug
bW92ZSB0aGUgbXV0ZXgNCj4gdW5sb2NrIG9yIG5vdCBzaG91bGQgbm90IG1ha2UgYSBkaWZmZXJl
bmNlLg0KDQpUaGFua3MgZm9yIHRoZSBndWlkYW5jZSBvbiBuZXh0IHN0ZXBzISBJIHdpbGwgYWRk
IHRoZSBib29sZWFuIGFuZCBtb3ZlDQp0aGUgbXV0ZXguDQoNCj4gDQo+IFBsZWFzZSBqdXN0IHJl
d3JpdGUgdGhlIGNvbW1pdCBsb2cgYW5kIENDIHN0YWJsZSAoaW4gdGhlIGNvbW1pdCBsb2csDQo+
IG5vdCBpbiB0aGUgZW1haWwgQ0MgbGlzdCkuDQoNCkkgZ3Vlc3MgdGhpcyByZWZlcnMgdG8gYWRk
aW5nICJDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyIgaW4gdGhlIGNvbW1pdCBsb2cNCihhcyBm
b3VuZCBmcm9tIHRoZSBsYXRlc3QgbWFpbmxpbmUgZ2l0IGxvZykgPw0KDQpUaGFua3MgYWdhaW4s
DQpLYW5jaGFuYQ0KDQo=


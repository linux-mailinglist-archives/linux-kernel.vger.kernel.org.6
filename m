Return-Path: <linux-kernel+bounces-408547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5239C804E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71508B2332C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0791E3799;
	Thu, 14 Nov 2024 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izD087tP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB001EEE6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731549406; cv=fail; b=gI0yNV0Mq08BRlGJjiK12LccILun8wUatJgu80c4932/jB5X0amtqwnF19Tt/gCN+FO2wepmWqujpvgqDDUSUpvJXrgLp+qLQW2g+lmWSRXHHs44atXBvkZtUU9UORbmL8CbILj7c7fUw3cxIERt1xDs7WcUWyNeNcRCBY48vFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731549406; c=relaxed/simple;
	bh=Mt/0PIzC8F/sc8PJGU+vUUdhbykHXqfmpjemHvD4T8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fWiaQWAJWt1FLIn6MLssZM8O71STssKES7CwnTIhSx9kBb0nrM9akhMpDbs1H08p3YkOAP/p5GaiPwa/X1z62KmTsNCcXBk3fSSIe5LaYmbyEzoxyCLvjDZ3D/A3QjMD0c1XCdRSNZszQ/Mu9qgLEdRw4Jnfr57trBmRRjyt8zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izD087tP; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731549404; x=1763085404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mt/0PIzC8F/sc8PJGU+vUUdhbykHXqfmpjemHvD4T8E=;
  b=izD087tPzu8Xc62znHn4gNn1otnur8I5VsiSDQ+Fo13kZstKXBzSwpm2
   BJtq3PcAz/FyutK+fv/Vjbv6oaRCkPqIh96DhxLz7/iOemCp60DgAYoPf
   vmKX3aOgUlY8/HRYfinsGrJdq5jI+cc5OgrIJNiXRO3WvoWZEp7IAexvI
   guQiEW/C4LzcR0jSbzkgBfeQDgU+SCP0SXdhbUP5HpsdMJuxJAu/Aaauk
   Ks1H2cX+3Bd39iqYF5z+pmKT+HFOBCENztHvO4+uZJRuCgJArA1eysWIG
   ij6SQzO34w8qU9nat090/Tl9BaIJHsZoJIMCFV6Ukkaz1xh9/rQ4qYrFP
   A==;
X-CSE-ConnectionGUID: 1rm0MZ+OQj23mMiLSyLwyQ==
X-CSE-MsgGUID: D6j1K92wRFOG+TM+7A6Kxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31329255"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31329255"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 17:56:44 -0800
X-CSE-ConnectionGUID: iYGLhVYHRvu9FWmC5pu3zA==
X-CSE-MsgGUID: sd6452KBS1eAI7WsWuVKqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92971982"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 17:56:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 17:56:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 17:56:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 17:56:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfgtynI9vsSFKSEJ94sObGnBc/5NuvLWRcOG5qfVnUhOPnhzRdc3lGnsc58PT62zh1Dr3Id9Ct0uUyiDAmN9l/fGwb2MXPaD4zxXtyqNfuuE/Ui5P41nxtCD/XcMAa3wmYAdh58uc/O9IyRpyKx5BraCS/2CRU56R7Dy7PFgmoABI0CIoO0AvZrCVcleoxvgfRvOQreF4jFLIGrGST7pXwfsp/X1Yq8RpdqClZC6oxrN9CTPWsBiECXTZw3KI98xRaBpu78pduO38ZOBAhOl6Tiqk0OdHZGX/R3Iun+u0en4hhyqqvMxg4/W3kQXRl+O/WDgiKImTcUd53gl0XpKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt/0PIzC8F/sc8PJGU+vUUdhbykHXqfmpjemHvD4T8E=;
 b=f+rLRpIgamb/0cipgeCWzpmWsugoqwm/1EGv1tyBkB7yR+kCnv68JzL76j1AcjWimvs+dqHJCdIGTZDrs2tkdmFE0KbPF7WEPDootGNcWF4sYc2ntnVmFeHWmxemvcXNCaJdECraEMcyKTf7IbDQ/q7H1t6W0mJr/WITGWdvEjyODN8RJcu7QQ9DRJJHGgSCYDoXJpLpsPHA3fJgTlyqlIWh+D9v/PIqMYQxOlNTIrPJBrl2Yn9u+zSPMLwf/x2TxtRmccri0zBnoeNOc6JMANlIKgpL0U9iN1HVaNYtTEKydDP0TOg97kc6mjQYQZQw6+SubBX8TipOpFs35ohxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CO1PR11MB4770.namprd11.prod.outlook.com (2603:10b6:303:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 01:56:18 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 01:56:16 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAz64CAAATjwIAALQAAgAAWEyA=
Date: Thu, 14 Nov 2024 01:56:16 +0000
Message-ID: <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
 <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
In-Reply-To: <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CO1PR11MB4770:EE_
x-ms-office365-filtering-correlation-id: e31fbff5-8806-432c-6896-08dd044f86c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?REJhMmR0RVhzaWxVc1UvVm85UXV0OFl2b2t1WGpPTXBuWkpibzA4dCtvdS83?=
 =?utf-8?B?dS9jL1paT202TnZHVTZPK2VTVk1nd1pNODBhNjNvZ1dNcEpmWnFJYVdxM2hs?=
 =?utf-8?B?eWRLaEdPSElkdE5zZGh1RWNSdXFqdGwwMWVZK3FXTS9McUZ3Qkduc2ZnOWJa?=
 =?utf-8?B?Rk8zTTQ1VFBaMjNVVkM3bi9WUmU3eGlIeTlKMExlQ21WMk43RXl6dDlPaCtw?=
 =?utf-8?B?cGF2L0ZoRXVMUUw2Z0VhVmlQVWdwaitZS2laU0liSjVJRmhUM29NUE9nMFF5?=
 =?utf-8?B?cDNndndkcnU2ODh2VVNQY0pEYUt2a2doeWZRQ08zbUtCdWltb0pVSlJuYkVk?=
 =?utf-8?B?ckVmcS92bVVVS3g5R0RNd0NmVGxQVXh4WHYrbEJET2dHSU5jcFFTZTdJWTEz?=
 =?utf-8?B?N3lLWk5IYXJyRHZBRjdjUDllY0lWQTBWdkFUZVFBL0hPMERvVEJvUUV5UC80?=
 =?utf-8?B?cnI3VHJtb2V6dlp1SE9lKzFaSFhGVFZ1S0p2Mnh5cWF2bmZkTHM0QkNQOWJU?=
 =?utf-8?B?WXVNcENVNS84dEZWTTlqRWRuQnU2SUJtd0Y1Vmg4Ri9ESlN5WVdIMnZ1WUdp?=
 =?utf-8?B?cENoaUtNbDVnSi9neVVBY0N5VkJKWDNnc3JkeUZraEpqc0tpSHZFME15VEhF?=
 =?utf-8?B?L1lDYzJCUFhRTVJKUXBNajB1d3p2SklMMjM4SGRCVXBQT3FpaXZ6WFNxSENX?=
 =?utf-8?B?TmF4N0toN2IvWG9BTGdjZTVmOXFZeTg4MWsybitWNkhocDlod2x5Tmk1L1pa?=
 =?utf-8?B?WFNFVForR1hzbi9HMUtZR3F4YXMzTGtRRC9FRVBWZk01cjB1RGNiejBsRTIr?=
 =?utf-8?B?Z3dyWlpTc3YwUXltZ0lTd0RmK3FNUlVEa3orb1B6VERwMU5ocTArUFloVjFL?=
 =?utf-8?B?SGxWdHk4QkkyYnMvWW1sSStoR2VmVXhBejhnRkVjSXJxSjBzSitlTE5LOVZW?=
 =?utf-8?B?ZUtzU25aU0d5bHdCYnJ6ZTV4SXlVRkF3M1E0MlNLWkJTcnVpbTJyUVJLbXVS?=
 =?utf-8?B?VG50alNzZmxReGh1czNJNjdOUjhSZHNEb1A5TGt5YVFyZTRsbi9mUWN0dnNM?=
 =?utf-8?B?a1g3ZCtrNDF4WHhrenYyYTZTbzNoRXhCY0FxK2JuVUExQytaT01MQy9SaEhF?=
 =?utf-8?B?amNLOERLU2hJVHczYVdMd0JIdUV0U212eG1hNkVGMldSV284Rm1FRGFLVWJn?=
 =?utf-8?B?Ui81Mllkb3VSZks2SEkvcmw5VEd6WnVDenFsc1dxNTNUelJWOFRwbkZvSTBa?=
 =?utf-8?B?eFVCeStITVB2TjY0OTNiWU52QmpZalUxOFFFanpsbnd2K3hyWDJnMTVLSkEr?=
 =?utf-8?B?QmNyaVZFUFo5TEVPVjhUU09NT0k4cUxpcVdJUEVaanZKNXQvdGVMUFdDVllO?=
 =?utf-8?B?bFk3M1RYdWZUV2trbzRONHZjbWVVcmxsNGJDTjAwUVdiK25FdENURkczeFU4?=
 =?utf-8?B?eHBMakdCS2ltc3JJY1pDdzlOQWZ6eDdBZE1Xc3AwTmRZZ1ZRZHVXOElBV1E1?=
 =?utf-8?B?d1NwVzZWQkZSZ2hoQURMSnpDMWhDL2RxT0VpZlF6WjFzTDVEQjBHNWYyZXYw?=
 =?utf-8?B?TXNzSTN6K2l0bFNqcnVwZHM0cE9kRE1qczUyaFBTNG15a1hvb2diNStlb3Fx?=
 =?utf-8?B?Y2lZU1puUE9Bc3d5SXFHaytUNU5sQlU1WjVaQjJEUEk5TXJ2dXFtVEFqR0x0?=
 =?utf-8?B?Q1Fud0g4dnYzeFIvaUEwV1QyRWZ0Vm5MUVVrZHBzRmdYVFk3Q0F6cm96c3Rt?=
 =?utf-8?B?dVh4OFNiMXI4VnJVNGMyWWV3WVc1Zi85SWVSOUp4cmdqazdjZDU0ajdpQk5L?=
 =?utf-8?Q?MNIKV5RgrZFDes5qMjpUrcrcKRuf2EKeW9NOA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHZZNHh3L1RScGRrOTBQbTM4YnM4RWcrM1BleGJiQWJVOUlUZ05jenJUR1BN?=
 =?utf-8?B?enJCTWNmYTllYVZZTEFuZDJTOHhxOEloVTBwRHBPeGZnNWQ4a3d4Z2Y3YkVS?=
 =?utf-8?B?ZTBnNDFRKzJzMTdKeHRjSnNhMWdPM3NEaHBNVmhVbStjR2tEZUYwUXQyK0Nt?=
 =?utf-8?B?aTVmZi9CN2Z3QkZSMmFrL1ZSLytOVlFIaktXTWMxWkpWS1pJR0hGTkViQjZk?=
 =?utf-8?B?SjF2V2syRHJ1MWRjSm5ZN0pqdFpQSFdJdEpJWWRwYmNHSXh3NkFFT0J6a0dm?=
 =?utf-8?B?bUFkOEwvSDhtdjh3Z3hKNElGamFYamZlOVhUMWF6ZDhrTFRKV3JIOHYzMFZK?=
 =?utf-8?B?Szh6YjdjTnBUQWtVcnJOV3JxdkZiZm9FUjl3aU91UHRxR2ZlRm12ODhLS3pD?=
 =?utf-8?B?Y09TUlpvN2VDc2cwbDNxd3V2Ykx4Z1dnWFNVbHBaUEFrcElNMUFFOFIvbXZO?=
 =?utf-8?B?Sm5jSGZLMFplOEdVT29kSUc0Q2F5d2J5NFJ4YmJjMVZ3NFVCaGZ3VFNpeVJJ?=
 =?utf-8?B?Q0tjMXFPc2U1cGwwZ3NXSGZicXA2alVwQmFveFh6WW9LZ3NCcUxRRW9XNFVa?=
 =?utf-8?B?Y2ZNeTFsbGE1ZWlNWXZzMDMwOWFBN0QyeGlMOU1SWjg4UVpwVjJrOG9vYVY0?=
 =?utf-8?B?WHk4NUx4Q3lmT0xQSS9FZ29kYVkreG5PY0hDUnpJU2JlZHBMQmJjRzVscjBL?=
 =?utf-8?B?OG9zTkpuU0labFlhUFphbWhZM3puWm9Odlh2Y0dQSmVPMnRrbUU0bHhhbmNl?=
 =?utf-8?B?bGRQODFqMTh0d3dIWDlkRkpNVTJKUlF4aDdldnV0L2VrTU9QaHdITXIzU1BU?=
 =?utf-8?B?aDQ0ZVgvdjc0VitFRDJaZHNDT1BJKzdVWE5PN09lajNROGhsOXFuU20yem9O?=
 =?utf-8?B?RklOcHd0OGlKNG5UbHY5d1Y0alhjMVlZNnlCeVlNSThmSjgvejJ2QmNwcThN?=
 =?utf-8?B?dlpMb2M0V1VnajRPU1V1VnRTaDk2TGh2Y0l3ZnExUzJDM3dFL3E3TVo5SFk3?=
 =?utf-8?B?dWdEbkdMNUUveWYzTExFZTdCSDRuSnlwNTl1b290Rko0VUcwRlo1R2lqWEx3?=
 =?utf-8?B?Z1FUem05ZG90NktMSTdzOXZLNWpUNGw4SjNHRVNFR2oyV3U2SEpqOHZ1aUU1?=
 =?utf-8?B?WTgzeDgxeHdPSXpaMHhRYU9XeEoySFhUUEhmYmdmb2hFR2Y4a0lyVkV3TW0r?=
 =?utf-8?B?cUZ5Q05PZFk4WkpZeUIvaDFmWUR4R013UUNUa09zM3JQa0Q2ZXk4aGRzcG9Z?=
 =?utf-8?B?RXQ0VDZsNitrTzdDMFNMNlVtZnpkYW5Yb2R1RTN2TzFpQlhIVE5Na3VYKzla?=
 =?utf-8?B?dFhqSFFUeFJSVVpwdFZ1VSs2QnhmMGd2MHVDTGZCMzBEMVJwWmR5RlphV3JN?=
 =?utf-8?B?QzNvaGNUeklHcUxiUnpmUjVkVnlEYzlyZW1HZVdYZjk3TWs0dlpndHg3dGVu?=
 =?utf-8?B?K0tFZUN3dFE0Z2FMOVlVU2JBNVVJZFA1ZTNOK1pQYmxmYmZHZ1R1NTJ4TG1h?=
 =?utf-8?B?RHZiNlhhRThycG4wckh6Um9TOG1YaEFRazBDZSt2S3VBb2puOGZwc25IUGhu?=
 =?utf-8?B?amUxREMrUVZneXNueFlFMGtZTnhlY3lFdjZJSjRyWVEwRERneUJQekxBTmw5?=
 =?utf-8?B?U3dPMFg5RGZGTXF1eFZ3Uk92bmtzT3hEU1V1R1IwZHovRzZoRnhSQWcwbkI5?=
 =?utf-8?B?L0llSisxbGR3SW4rbEdNTS9aNVRQYjNTTTlSSjMvYmo2WWV3NEQ4YVU1Szlt?=
 =?utf-8?B?aDZiYzNMMXlYUk1JVG9PNURKSWxsZnlWS2F2dUhNUUlDdU8vWm5qMkRRSUZ4?=
 =?utf-8?B?eTd6NWUwMDhSa2xncjk0Y3Faa3hYT2g2TGVST013azNCYVprMTNRcXlNV2Nm?=
 =?utf-8?B?WDc3UWJDQVdDUWtSNUxyaW5kSzlQN2ZwUmRxNGxHOStLRlJmSmRBcnhOSVB6?=
 =?utf-8?B?UVo3aXkvRXB1TFgwQzZoc3NzTVQwZE85cGpkcjJXR085bmhjUk5SNnp1Rkow?=
 =?utf-8?B?L0RvTyt3QjJxcGE5ZTRtMmZ3MWhQQ0xoNUc3L3FIaWFxSEQzWmUxbU9oMERE?=
 =?utf-8?B?M25pYjBuWmQ4ckF3Ujd4d1hkTFVpNURQV1NFSSs3Q2d2MS84VTZBSnJqdjhs?=
 =?utf-8?B?b1JLUVByUTlOaFpmZlljVGlLMzhyLzExamIyR1dyYlJldnBTRWJhckFqM0tV?=
 =?utf-8?B?YkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e31fbff5-8806-432c-6896-08dd044f86c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:56:16.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxdbbHMKF7DkIaNiQZxBumfljKbQZRxKUDTEzRzHLIE+IXRJNmMpL7X2J9PlcD6sCI7lcAMQdj8OWWuR/ukS+YDy0IlRUi+9GMADh0Y7fqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4770
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMjQgNDoyOSBQ
TQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNv
bT4NCj4gQ2M6IEpvaGFubmVzIFdlaW5lciA8aGFubmVzQGNtcHhjaGcub3JnPjsgWW9zcnkgQWht
ZWQNCj4gPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBtbUBrdmFjay5vcmc7IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsgdXNh
bWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5n
IDx5aW5nLmh1YW5nQGludGVsLmNvbT47DQo+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4
LWZvdW5kYXRpb24ub3JnOyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50
ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2FwOiBGaXggYSBwb3RlbnRpYWwgbWVtb3J5IGxlYWsg
aW4NCj4genN3YXBfZGVjb21wcmVzcygpLg0KPiANCj4gT24gV2VkLCBOb3YgMTMsIDIwMjQgYXQg
MjoxM+KAr1BNIFNyaWRoYXIsIEthbmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+IFRoYW5rcyBKb2hhbm5lcywgZm9yIHRo
ZXNlIGluc2lnaHRzLiBJIHdhcyB0aGlua2luZyBvZiB0aGUgZm9sbG93aW5nDQo+ID4gaW4genN3
YXBfZGVjb21wcmVzcygpIGFzIGNyZWF0aW5nIGEgbm9uLXByZWVtcHRpYmxlIGNvbnRleHQgYmVj
YXVzZQ0KPiA+IG9mIHRoZSBjYWxsIHRvIHJhd19jcHVfcHRyKCkgYXQgdGhlIHN0YXJ0OyB3aXRo
IHRoaXMgY29udGV4dCBleHRlbmRpbmcNCj4gPiB1bnRpbCB0aGUgbXV0ZXhfdW5sb2NrKCk6DQo+
ID4NCj4gPiAgICAgICAgIGFjb21wX2N0eCA9IHJhd19jcHVfcHRyKGVudHJ5LT5wb29sLT5hY29t
cF9jdHgpOw0KPiA+ICAgICAgICAgbXV0ZXhfbG9jaygmYWNvbXBfY3R4LT5tdXRleCk7DQo+ID4N
Cj4gPiAgICAgICAgIFsuLi5dDQo+ID4NCj4gPiAgICAgICAgIG11dGV4X3VubG9jaygmYWNvbXBf
Y3R4LT5tdXRleCk7DQo+ID4NCj4gPiAgICAgICAgIGlmIChzcmMgIT0gYWNvbXBfY3R4LT5idWZm
ZXIpDQo+ID4gICAgICAgICAgICAgICAgIHpwb29sX3VubWFwX2hhbmRsZSh6cG9vbCwgZW50cnkt
PmhhbmRsZSk7DQo+ID4NCj4gPiBCYXNlZCBvbiB0aGlzIHVuZGVyc3RhbmRpbmcsIEkgd2FzIGEg
Yml0IHdvcnJpZWQgYWJvdXQgdGhlDQo+ID4gImFjb21wX2N0eC0+YnVmZmVyIiBpbiB0aGUgY29u
ZGl0aW9uYWwgdGhhdCBnYXRlcyB0aGUNCj4gPiB6cG9vbF91bm1hcF9oYW5kbGUoKSBub3QgYmVp
bmcgdGhlIHNhbWUgYWNvbXBfY3R4IGFzIHRoZSBvbmUNCj4gPiBhdCB0aGUgYmVnaW5uaW5nLiBJ
IG1heSBoYXZlIGJlZW4gY29uZnVzaW5nIG15c2VsZiwgc2luY2UgdGhlIGFjb21wX2N0eA0KPiA+
IGlzIG5vdCByZS1ldmFsdWF0ZWQgYmVmb3JlIHRoZSBjb25kaXRpb25hbCwganVzdCByZXVzZWQg
ZnJvbSB0aGUNCj4gPiBzdGFydC4gTXkgYXBvbG9naWVzIHRvIHlvdSBhbmQgWW9zcnkhDQo+ID4N
Cj4gPiA+DQo+ID4gPiBUaGF0IGJlaW5nIHNhaWQsIEkgZG8gdGhpbmsgdGhlcmUgaXMgYSBVQUYg
YnVnIGluIENQVSBob3RwbHVnZ2luZy4NCj4gPiA+DQo+ID4gPiBUaGVyZSBpcyBhbiBhY29tcF9j
dHggZm9yIGVhY2ggY3B1LCBidXQgbm90ZSB0aGF0IHRoaXMgaXMgYmVzdCBlZmZvcnQNCj4gPiA+
IHBhcmFsbGVsaXNtLCBub3QgYSBndWFyYW50ZWUgdGhhdCB3ZSBhbHdheXMgaGF2ZSB0aGUgY29u
dGV4dCBvZiB0aGUNCj4gPiA+IGxvY2FsIENQVS4gTG9vayBjbG9zZWx5OiB3ZSBwaWNrIHRoZSAi
bG9jYWwiIENQVSB3aXRoIHByZWVtcHRpb24NCj4gPiA+IGVuYWJsZWQsIHRoZW4gY29udGVuZCBm
b3IgdGhlIG11dGV4LiBUaGlzIG1heSB3ZWxsIHB1dCB1cyB0byBzbGVlcCBhbmQNCj4gPiA+IGdl
dCB1cyBtaWdyYXRlZCwgc28gd2UgY291bGQgYmUgdXNpbmcgdGhlIGNvbnRleHQgb2YgYSBDUFUg
d2UgYXJlIG5vDQo+ID4gPiBsb25nZXIgcnVubmluZyBvbi4gVGhpcyBpcyBmaW5lIGJlY2F1c2Ug
d2UgaG9sZCB0aGUgbXV0ZXggLSBpZiB0aGF0DQo+ID4gPiBvdGhlciBDUFUgdHJpZXMgdG8gdXNl
IHRoZSBhY29tcF9jdHgsIGl0J2xsIHdhaXQgZm9yIHVzLg0KPiA+ID4NCj4gPiA+IEhvd2V2ZXIs
IGlmIHdlIGdldCBtaWdyYXRlZCBhbmQgdmFjYXRlIHRoZSBDUFUgd2hvc2UgY29udGV4dCB3ZSBo
YXZlDQo+ID4gPiBsb2NrZWQsIHRoZSBDUFUgbWlnaHQgZ2V0IG9mZmxpbmVkIGFuZCB6c3dhcF9j
cHVfY29tcF9kZWFkKCkgY2FuIGZyZWUNCj4gPiA+IHRoZSBjb250ZXh0IHVuZGVybmVhdGggdXMu
IEkgdGhpbmsgd2UgbmVlZCB0byByZWZjb3VudCB0aGUgYWNvbXBfY3R4Lg0KPiA+DQo+ID4gSSBz
ZWUuIFdvdWxkbid0IGl0IHRoZW4gc2VlbSB0byBtYWtlIHRoZSBjb2RlIG1vcmUgZmFpbC1zYWZl
IHRvIG5vdCBhbGxvdw0KPiA+IHRoZSBtaWdyYXRpb24gdG8gaGFwcGVuIHVudGlsIGFmdGVyIHRo
ZSBjaGVjayBmb3IgKHNyYyAhPSBhY29tcF9jdHgtPmJ1ZmZlciksDQo+IGJ5DQo+ID4gbW92aW5n
IHRoZSBtdXRleF91bmxvY2soKSBhZnRlciB0aGlzIGNoZWNrPyBPciwgdXNlIGEgYm9vbGVhbiB0
byBkZXRlcm1pbmUNCj4gPiBpZiB0aGUgdW5tYXBfaGFuZGxlIG5lZWRzIHRvIGJlIGRvbmUgYXMg
WW9zcnkgc3VnZ2VzdGVkPw0KPiANCj4gSG1tIGRvZXMgaXQgbWFrZSBpdCBzYWZlPyBJdCBpcyBt
dXRleF9sb2NrKCkgdGhhdCBwdXRzIHRoZSB0YXNrIHRvDQo+IHNsZWVwLCBhZnRlciB3aGljaCBp
dCBjYW4gZ2V0IG1pZ3JhdGVkIHRvIGEgZGlmZmVyZW50IENQVS4gTW92aW5nDQo+IG11dGV4X3Vu
bG9jaygpIHRvIGJlbG93IG9yIG5vdCBkb2Vzbid0IHJlYWxseSBtYXR0ZXIsIG5vPyBPciBhbSBJ
DQo+IG1pc3Npbmcgc29tZXRoaW5nIGhlcmUuLi4NCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMs
IE5oYXQuIEkgZ3Vlc3MgbXkgbGFzdCBjb21tZW50IGluIHJlc3BvbnNlDQp0byB3aGF0IEpvaGFu
bmVzIG1lbnRpb25lZCBhYm91dCB0aGUgVUFGIHNpdHVhdGlvbiwgaXMgdGhlIG9uZSB0aGF0J3MN
CnN0aWxsIGFuIG9wZW4gZnJvbSBteSBwZXJzcGVjdGl2ZS4gSWYgdGhlIHByb2Nlc3MgY2FuIGdl
dCBtaWdyYXRlZCBhZnRlciANCnRoZSBtdXRleCB1bmxvY2ssIGFuZCBpZiB0aGUgYWNvbXBfY3R4
IG9idGFpbmVkIGVhcmxpZXIgZ2V0cyBkZWxldGVkIA0KKGFzIEpvaGFubmVzIHdhcyBtZW50aW9u
aW5nKSwgdGhlbiB3ZSBjb3VsZCBiZSBhY2Nlc3NpbmcNCmFuIGludmFsaWQgcG9pbnRlciBpbiB0
aGUgImlmIChzcmMgIT0gYWNvbXBfY3R4LT5idWZmZXIpIi4gU28gbXkgcXVlc3Rpb24NCndhcywg
Y2FuIHdlIHByZXZlbnQgdGhlIG1pZ3JhdGlvbiB0byBhIGRpZmZlcmVudCBjcHUgYnkgcmVsaW5x
dWlzaGluZw0KdGhlIG11dGV4IGxvY2sgYWZ0ZXIgdGhpcyBjb25kaXRpb25hbDsgb3IsIG1ha2Ug
dGhlIGNvbmRpdGlvbmFsIGJlIGRldGVybWluZWQNCmJ5IGEgYm9vbGVhbiB0aGF0IGdldHMgc2V0
IGVhcmxpZXIgdG8gZGVjaWRlIHdoZXRoZXIgb3Igbm90IHRvIHVubWFwDQp0aGUgenBvb2wgaGFu
ZGxlIChhcyBhZ2FpbnN0IHVzaW5nIHRoZSBhY29tcF9jdHggdG8gZGVjaWRlIHRoaXMpLg0KDQpU
aGFua3MsDQpLYW5jaGFuYQ0KDQo+IA0KPiBJIHRoaW5rIEpvaGFubmVzJyBwcm9wb3NhbCBpcyB0
aGUgc2FmZXN0IDopDQo=


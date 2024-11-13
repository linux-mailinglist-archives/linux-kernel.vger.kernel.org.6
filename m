Return-Path: <linux-kernel+bounces-408207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FB9C7C01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BB528184A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA822204031;
	Wed, 13 Nov 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4jDNLlE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0016DEB4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525150; cv=fail; b=EMHLMZ8Ejs+XUR1P478DS+wtUpntvUsQIv/ZwRaj0eoZSC4m/6BXxlRsfxeTEi86lygfWL7F39x2UnLLCglDxqlOolIKoYlRCsJQCvr2FeM48r4+GCdwfmT27T0LB7sPBHpJoEwfeQvRWQKWatlC49G+WvpcVHeVkjUWby/YcG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525150; c=relaxed/simple;
	bh=FLOOgP+4Aw1qwwGsZSEOCDAyLtPL/A/dZ4ZgOY+QZDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AfarfCgzgJ9lREI5GfDPRkHiM8IiQgM0+Cw9SspIZ+eVOLOApOMWrAINFWyQCzFTQsRH++kB0yICl+qd45LZbYiFerYZGXsHdaoCCsN4ImWJCgKizREB/zRbPQ2mdYCFSY7yhMZMgWtolXAjUx3WCuvCu4/m2N16rZe3SSdY8+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4jDNLlE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731525148; x=1763061148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FLOOgP+4Aw1qwwGsZSEOCDAyLtPL/A/dZ4ZgOY+QZDk=;
  b=W4jDNLlE/Al31pEDWWf6TI9RkuZJZOr3aOp3MVNChPsfjgSKUtRHFrLi
   A1B+ZArqqdcqPKQ6eV7m3wbS7rS3wna1Zq11RO8i4lxRES9KWG8aXCwy0
   my0npEY0IJhO8aIAcMgayrqCrk72E9vPvLamuD2lxCz5Ru3Bz6rgbEqG0
   NRtgWhvZgJ0n8kCBYtOcZ4Ek9yAZtvbOij2rHKQJaLcZWL1E1267Jy/H0
   GA6MhZ4ET0qGBe7/qdLzWLwQT2psJmmL5CcF86BggaLGohzdWRgfqopiV
   QT+wsG6AqZfeQlT2O0NaJnZ21Ww+d1kfnpHjOVYR2IJdC3aoWvnxKJa15
   g==;
X-CSE-ConnectionGUID: bbyvY482Szq7YcuNEzDgPw==
X-CSE-MsgGUID: uqVj7SmpT5qppu9LSHUMEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42823548"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42823548"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 11:12:27 -0800
X-CSE-ConnectionGUID: o4j/Kdc0ToyHW/0UpB0hsA==
X-CSE-MsgGUID: xxzw0nVRS4+4pX6Q3vy/Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="88367931"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 11:12:28 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 11:12:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 11:12:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 11:12:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soyYjq81pmh5mIS0sMWk6RQoI6hWtHMLh51+0Mp12BXIMDHMV+0tVIj+a+s/4CANKWWIP4+xoH0kj0XCCnQIy9SM1Bs3Pv/EohzBIfYCJSeCZdi1T1/w7bh8Xv0LyCMNzUssNMKneo+lv1CUPlQBnWyPZ3IR6SjHLdZOg6QUgO0LFTO1u+YVv9AVgJH6A6hx4nlLWkMLJQvTrrF+/FLgRZY5KfC2l06HiSJDKSybQdkmmt8xYrppfe9wBjIjfRzyMi/Vq7mLDY2vzmYrLnPkCebdv3b2ybbVIKeM8D8mIVsgnx5bHTDagjrOi5ze4zqvQnaybUjBcXjfAuIKGBflhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLOOgP+4Aw1qwwGsZSEOCDAyLtPL/A/dZ4ZgOY+QZDk=;
 b=stPzbq/e/EHOP5Us0noWH19NXYr3WcS9UCSNR1winlce+qe11Xig68divIP43Z22cnEJtR5kfFyov5MD2p1gK0nR1p00gjGmgv6OG2OM7UT3MKP+IityXZ5ZHoXLlJCcI0YG2VSQr0Id9WeIPinNhTY9Yk15aArEZl6IS1NwqIZort0mYH+IUcTX5f2ZpOpBBGmpCr+sECaEXTkZtBMNyDc4qPFf8C9N8MsPKZ7v91idV8X72++xVsi9yf2nOZCCRyDMVe4eiNCT40aSiv0bpjcLUI2s59GFxRKOWjYLDaw3JQyW1wZjUhAKGMm171HQM042LWEf81lI/EEkOS/juQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SJ2PR11MB8588.namprd11.prod.outlook.com (2603:10b6:a03:56c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 19:12:19 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 19:12:19 +0000
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
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcg
Date: Wed, 13 Nov 2024 19:12:18 +0000
Message-ID: <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SJ2PR11MB8588:EE_
x-ms-office365-filtering-correlation-id: c6824571-f524-4d5b-6d01-08dd04171801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cXlybXdsaG9ZbW5HT1I2dzB3UGdaUlhNZ3VkbHdZV1J2WFFQREd3eDRaOVRw?=
 =?utf-8?B?VWRhZ1VXLzdzS3hmdnV0djNyY2dkNk5xNVN5c3RpUHU1RjE5RjAxVXdMWnJU?=
 =?utf-8?B?dEdYZGVZdllvSWI5WjloYWluajhXRmxyNEh1VjdRSXVwNE9ZWUo0N1dVZ245?=
 =?utf-8?B?RFQ5LzN2bmNJbWE4L0NjQkpEY08zdXV5VnZzWHQzUHREclhBZDM5Q2VrTi9D?=
 =?utf-8?B?cWltY3NVUHdGMHVqc1ZWNUc2WkJOY3BIVVRWTzd3TkNtemVlK0VtaHNyWXpU?=
 =?utf-8?B?SnJhaWV2ZUJ0K2tWNC9kaXlhNU9Jb3JGTDhyNmg4ZFM3ZzJHSWtGTWJMdnFZ?=
 =?utf-8?B?aEFSTnZOVHFDVnVCbHQ2NVRjQTMrRmRIcnZqQnlzOVlEdTZmR1NqcEpndVJj?=
 =?utf-8?B?S0VsQW9tWVljVFFndTdJcStHcnpwSWFuYnM5V3hGTWRkTTJTNGtDSU5aMkky?=
 =?utf-8?B?M3h6VCtTUXhhRW1HS0FkN0h6S3pKdG5oNFhsajU2Q3RDNithbXBzNUZveEhv?=
 =?utf-8?B?VHlNaW9YTEltS1FYQ1BCd0Y1WTFCdU0rQlYxTjhzRDZPbmg2SWxPaWM3TjJ3?=
 =?utf-8?B?cVVuOEovRXBUL0duQzhxUFhRemlNY0JuaXQwWkxHRytNZSthdDJuK2ZqRE5V?=
 =?utf-8?B?NVlpVGFETEgvRXc1V0pQaS9kdWkySlZQSFNiNU8yYzFVcm5zSi9PbGJQVk8x?=
 =?utf-8?B?ZitpcXkyMU42YnQ2RVhoR1AzcXlNUWNXVlZXWmk3b3ZBTHNNbnJ2UkhEM1Ez?=
 =?utf-8?B?bit6YjFnSzJpUG1ZdVRTWkQwbXNjZXpvcUQxVnlaQ2RDbHlVY2N3bHVvSzBS?=
 =?utf-8?B?WFRDQW5USTd1YUkrYTNZZEVqTEVSSWx4QVFDS29KZzdNY1JMMXVtWTM3R2Nk?=
 =?utf-8?B?RmhickFpdXJ6d2p3V1BtTGNGVjI4TlMzMzN4NEhFbXVGWi9lenJubkZkSmI2?=
 =?utf-8?B?MFN5akJyMVdnWkZad01xelljeVJPbHZsYnQ2SFkxYVR5RnRUaXdkNUJjTzdM?=
 =?utf-8?B?QXhZNzJGOEhOR092TTJaNlIwdUdObHhKcU1zZ3VScUNQbEVUb1N3Z2preC82?=
 =?utf-8?B?alJ3aEdYZG5pQzVNdkJneFUrQlhITVhoMm8yNGszVjBacnFoUm9xeHJ1N0JS?=
 =?utf-8?B?b1dDSEJTWVVsWEVtRWc0Sm9YeDlyYVpYNmJqay9McWU4OFZVNWhlL2RqV2pJ?=
 =?utf-8?B?bnRZKzZaaFFYUEVzMEN3WHJsdE1rOTc3cjc3SFpzZGJLK1pJWG0rN2dlbndo?=
 =?utf-8?B?dVUxVWVJdEFabkg2UnVLNTR2STJteVVnUnFlOG1SVlhYZ3BBNGhpaS95N2hH?=
 =?utf-8?B?R3ZCM0pZR2ZSS1dxUnNOZnhPOEs2UjZhRHlZcWwwT0JoUGk4R2NEY29pYTNF?=
 =?utf-8?B?aWpFWlE5T1BrOUp6MU44WVV6Ny9FUCt4NlRzM1B6RE5KZUlRMU9lYTVmQ3hv?=
 =?utf-8?B?MVJHMlEzYlpNUlZqejYzQlgzcWc5VzhNUzBrcy83cWxNaWJ3ZGUzVWVCNS9K?=
 =?utf-8?B?U2YxUWltTEZwWUIyd3ZCdDNqNm50R0x1VlRyWWxCUHFMdS9uR2M2dlAvaUVo?=
 =?utf-8?B?S1V1b291UHNySk51bXBKZW9MMHVPR3BIWHpLTExFM1MrWlQxeWdIR1V1WWov?=
 =?utf-8?B?SlZOYW1UQ1c1ZUh2SlJmeWlpUXd2K1cwbllpZ0V3U1NpbVU0bVNHMVFiSDBO?=
 =?utf-8?B?OVFRRnlYY1ZET2w3TVlOQmx5SVlmNDJoNlkzMktWR0FFR0haQllrNDRQeGth?=
 =?utf-8?B?UEFzWGo2c2REZUlpdkhyVEFScVB4bUtiYThjaTdiMDFsNEVHNkVkamtTUm9n?=
 =?utf-8?Q?AFyWWhpfzi5Pafg7OnJ2BvtRtgD+mM4vqnT+A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU96VkoyZzE2SjVEWWNOSWtIdnBwVVJ0ZzRtaHU0MFN4MjYxLzFlbWM5RXVZ?=
 =?utf-8?B?SlNMUURBaTVnYnQ2WXJ2Z3dzRzRCMWtwOGt5Szk4bXVrVTR5NVo4WU05amZK?=
 =?utf-8?B?S3RpUUFQdE1LcmVKTEluLy9pQWxtcmN1V0hiTjNEUzIyaXNBalNMSFg5d0Fv?=
 =?utf-8?B?bElzd0ZoekMxakwzN2ZQWG4yUTlNRmhMekRIRFlMRUZBQkhWc1RFdVhBZCs2?=
 =?utf-8?B?TXJnc0REaFVOZ2FiKzBybzF1Wng3alBBRHg5dnUyWGMwNDduUi8zY0JQVFRG?=
 =?utf-8?B?MEFjYWhYblY3dEVOWUdQOHErWXdWYkJ1dTZGcG1ub2ZTZVdVM09YeDRaemRp?=
 =?utf-8?B?K3hnN2RCQ0hjckprTEtJTGhwZWF0Q1QvYklDWXpRWjRBTG12dDM2UVpBRFhv?=
 =?utf-8?B?N2pQckIvd094NEE4VWtjb3hWTmZlbnVCVGlWejZEdVVZZCtjU3N3WE5IWGZF?=
 =?utf-8?B?TVBGSVdkWDVJRmh2MTVVSWJmTVo3RWk1cTc2Yk5RYkxibVdnOXRybzN1Uy81?=
 =?utf-8?B?VGlTOVYxbDQ4V2FGY0VwdEZtcGdnaE05ZXVuZjNzRHhOQUFOMkhRWm5Qdmd4?=
 =?utf-8?B?aWV1czA0bFRqZHRtc2FnNW5sWVdSN1oxY3hkb01xOEtLVXBmazBmQ3o5Zkt5?=
 =?utf-8?B?LzdnTGZXUXJCY2hpYmFNTEJPeVlIQnVBbFVpNzNqeDcvZE1Za0hLa3VUT2xo?=
 =?utf-8?B?aVRzVTI1dVZWWlVSTENiZlJWTWJEbk5QMUtBWG5sMmxNaXA4cFZqSDY5UEN5?=
 =?utf-8?B?UVUxMVZDYlZvcmJ4TkdWdTlkL2J1VlFSeDFRRThEaUNEd1FRc2I5aWt1cWVw?=
 =?utf-8?B?MEdEUU9rUklZbHFHMkRDdGZ1WTI1VWM2a0Y5NlRKSStrTzA1cEkxRlZCSWs1?=
 =?utf-8?B?VlNGdGdMaElwUXpXTzR5V25QWGcxUEVkSnZzaTZWb0NuT1Jpd1RHcU9CdGdZ?=
 =?utf-8?B?emQ2Vjk3VmpoaFROM0JoeXFKa0VrK055MHNaQmdJcUtoMnR2YVE3NXpFaWdL?=
 =?utf-8?B?Zkcrbmk0aE1rMzJlK0cxYyt6a3ZYMno5Mmp1ODRKMGZJYXJzcUhkK1VrNkQr?=
 =?utf-8?B?NVhWMmhLNHdhSVNFWThtTFFmeFo3S0hkMVJPT3FoWFBkd2swbUZwMThuSENw?=
 =?utf-8?B?REtqNnRWR0JTMUloeHZCYkZSeUJsaUEvaEJOa2tTMVBUN09ONFpuU0w4R2lX?=
 =?utf-8?B?dzFTWG10ZFBWQVBlNXVmNXZIbVQ0cUdUblVndUdrOUtlRGZleHNHSWRxbDR0?=
 =?utf-8?B?dk9JZVp2N3R4cjMrSXdZWjBkSnFJTlB0WjQ2ZlhUZ2dNVEY4T0ZyS0J6Tzc0?=
 =?utf-8?B?c1FUOGxTS2JxQklmQjRnZ3V1U2xiY0xIRUUxbTZ3UC93K3BYVGZhcThwMHBZ?=
 =?utf-8?B?aVFZSFlFTHpraDNFNE1RN3RWa0FldmxZd1d3Tnd5WTR6SUU5S3dIVjJwQXJx?=
 =?utf-8?B?bk13cFh2b1hES0Z2SFFUY3JldTV1bDdXeDRxUGxNOGw2MEQ2YWNqdWVSYUI0?=
 =?utf-8?B?bWxLMDhwanhwV0lRVmlIbkE1Y3BwQk9ETG9lTlFia0ViZkdQamxPMVVLdlJE?=
 =?utf-8?B?THorL1A5cDg3VFZnYUpvYitGdmNmTllxMG81MGppaE9jbnhWRnZ2SGZjclRK?=
 =?utf-8?B?MElQdWVmVjB5WWlZNEVxVFRyNU9wRGZRbVoweGx0UjJrR2NYTTlmRDVXS2Rp?=
 =?utf-8?B?dk1OdXFZRitKR2JMLzNFWnkyWGV5VGhDSURnbk1EZUQreEhxTVVEd2N4VHE3?=
 =?utf-8?B?dnJhVHZrYy9sS0tERzZ6RnVnbFVoWDFZdTV2V2RhMTNlK0ZlUTVyVzJRZGpW?=
 =?utf-8?B?TTArd0xVa1lWUnRTM3p2Z3ozZmtNaTBWQlBwNlB1Mmg0TXZSOVhlWFQ0eElR?=
 =?utf-8?B?dUhuK2oxTnJBa3NKUlNudzJ6YWtMekRzWERxRjhEWmhjNkhkTFNLL21VSXds?=
 =?utf-8?B?TllWNGxNQ2hLWU8zdy9iRy83cmE5QjdESFFnMVV6TWthZE9MWEFNL20vZ3dV?=
 =?utf-8?B?T0t4cTQwVUtsUFRaMlV0WkdCTlBkZUtSVEREdmFUc2hpTnMyaUdZTVdtRGFL?=
 =?utf-8?B?TWVQdXd0Y2E2L0U1WDVBY2JRVVF1SXlERnNXQjJPbk03Q0UrVWQ1THFCUjE4?=
 =?utf-8?B?SGpMVjl5NHlzQkc4ck9HUGJZNEE3MGROMVVsS000OTI0dFN1eWkvbjhPMXdX?=
 =?utf-8?B?UXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6824571-f524-4d5b-6d01-08dd04171801
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 19:12:18.9486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Utk0OEVx5u1p5/wKaeY7BWLRp9O0GEoRbbF3+hz6YDfoScbAePXsg4kjHNKemyaIH5ctV8GpkwHImvwAEMSksvqR6mlEdMaZEAffSBd9m9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8588
X-OriginatorOrg: intel.com

SGkgWW9zcnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWW9zcnkg
QWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIg
MTIsIDIwMjQgMTA6MjIgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAu
c3JpZGhhckBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1tbUBrdmFjay5vcmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5j
b207IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsg
cnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nDQo+IDx5aW5nLmh1YW5nQGludGVsLmNv
bT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBGZWdo
YWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaA0K
PiA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06
IHpzd2FwOiBGaXggYSBwb3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4genN3YXBfZGVjb21wcmVz
cygpLg0KPiANCj4gT24gVHVlLCBOb3YgMTIsIDIwMjQgYXQgOTo1OeKAr1BNIFNyaWRoYXIsIEth
bmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBZb3NyeSBB
aG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgTm92ZW1i
ZXIgMTIsIDIwMjQgOTozNSBQTQ0KPiA+ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNo
YW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4gaGFubmVzQGNtcHhjaGcub3JnOyBu
cGhhbWNzQGdtYWlsLmNvbTsNCj4gY2hlbmdtaW5nLnpob3VAbGludXguZGV2Ow0KPiA+ID4gdXNh
bWFhcmlmNjQyQGdtYWlsLmNvbTsgcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nDQo+
ID4gPiA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51
eC0NCj4gZm91bmRhdGlvbi5vcmc7DQo+ID4gPiBGZWdoYWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZl
Z2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaA0KPiA+ID4gPHZpbm9kaC5nb3BhbEBpbnRl
bC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBtbTogenN3YXA6IEZpeCBhIHBv
dGVudGlhbCBtZW1vcnkgbGVhayBpbg0KPiA+ID4genN3YXBfZGVjb21wcmVzcygpLg0KPiA+ID4N
Cj4gPiA+IE9uIFR1ZSwgTm92IDEyLCAyMDI0IGF0IDk6MjTigK9QTSBLYW5jaGFuYSBQIFNyaWRo
YXINCj4gPiA+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4N
Cj4gPiA+ID4gVGhpcyBpcyBhIGhvdGZpeCBmb3IgYSBwb3RlbnRpYWwgenBvb2wgbWVtb3J5IGxl
YWsgdGhhdCBjb3VsZCByZXN1bHQgaW4NCj4gPiA+ID4gdGhlIGV4aXN0aW5nIHpzd2FwX2RlY29t
cHJlc3MoKToNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICBtdXRleF91bmxvY2soJmFjb21wX2N0
eC0+bXV0ZXgpOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIGlmIChzcmMgIT0gYWNvbXBfY3R4
LT5idWZmZXIpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICB6cG9vbF91bm1hcF9oYW5kbGUoenBv
b2wsIGVudHJ5LT5oYW5kbGUpOw0KPiA+ID4gPg0KPiA+ID4gPiBSZWxlYXNpbmcgdGhlIGxvY2sg
YmVmb3JlIHRoZSBjb25kaXRpb25hbCBkb2VzIG5vdCBwcm90ZWN0IHRoZSBpbnRlZ3JpdHkNCj4g
b2YNCj4gPiA+ID4gInNyYyIsIHdoaWNoIGlzIHNldCBlYXJsaWVyIHVuZGVyIHRoZSBhY29tcF9j
dHggbXV0ZXggbG9jay4gVGhpcyBwb3NlcyBhDQo+ID4gPiA+IHJpc2sgZm9yIHRoZSBjb25kaXRp
b25hbCBiZWhhdmluZyBhcyBpbnRlbmRlZCwgYW5kIGNvbnNlcXVlbnRseSBub3QNCj4gPiA+ID4g
dW5tYXBwaW5nIHRoZSB6cG9vbCBoYW5kbGUsIHdoaWNoIGNvdWxkIGNhdXNlIGEgenN3YXAgenBv
b2wgbWVtb3J5DQo+ID4gPiBsZWFrLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIG1vdmVz
IHRoZSBtdXRleF91bmxvY2soKSB0byBvY2N1ciBhZnRlciB0aGUgY29uZGl0aW9uYWwgYW5kDQo+
ID4gPiA+IHN1YnNlcXVlbnQgenBvb2xfdW5tYXBfaGFuZGxlKCkuIFRoaXMgZW5zdXJlcyB0aGF0
IHRoZSB2YWx1ZSBvZiAic3JjIg0KPiA+ID4gPiBvYnRhaW5lZCBlYXJsaWVyLCB3aXRoIHRoZSBt
dXRleCBsb2NrZWQsIGRvZXMgbm90IGNoYW5nZS4NCj4gPiA+DQo+ID4gPiBUaGUgY29tbWl0IGxv
ZyBpcyB0b28gY29tcGxpY2F0ZWQgYW5kIGluY29ycmVjdC4gSXQgaXMgdGFsa2luZyBhYm91dA0K
PiA+ID4gdGhlIHN0YWJpbGl0eSBvZiAnc3JjJywgYnV0IHRoYXQncyBhIGxvY2FsIHZhcmlhYmxl
IG9uIHRoZSBzdGFjaw0KPiA+ID4gYW55d2F5LiBJdCBkb2Vzbid0IG5lZWQgcHJvdGVjdGlvbi4N
Cj4gPiA+DQo+ID4gPiBUaGUgcHJvYmxlbSBpcyAnYWNvbXBfY3R4LT5idWZmZXInIGJlaW5nIHJl
dXNlZCBhbmQgY2hhbmdlZCBhZnRlciB0aGUNCj4gPiA+IG11dGV4IGlzIHJlbGVhc2VkLiBMZWFk
aW5nIHRvIHRoZSBjaGVjayBub3QgYmVpbmcgcmVsaWFibGUuIFBsZWFzZQ0KPiA+ID4gc2ltcGxp
ZnkgdGhpcy4NCj4gPg0KPiA+IFRoYW5rcyBZb3NyeS4gVGhhdCdzIGV4YWN0bHkgd2hhdCBJIG1l
YW50LCBidXQgSSB0aGluayB0aGUgd29yZGluZyBnb3QNCj4gPiBjb25mdXNpbmcuIFRoZSBwcm9i
bGVtIEkgd2FzIHRyeWluZyB0byBmaXggaXMgdGhlIGFjb21wX2N0eC0+YnVmZmVyDQo+ID4gdmFs
dWUgY2hhbmdpbmcgYWZ0ZXIgdGhlIGxvY2sgaXMgcmVsZWFzZWQuIFRoaXMgY291bGQgaGFwcGVu
IGFzIGEgcmVzdWx0IG9mDQo+IGFueQ0KPiA+IG90aGVyIGNvbXByZXNzIG9yIGRlY29tcHJlc3Mg
dGhhdCBhY3F1aXJlcyB0aGUgbG9jay4gSSB3aWxsIHNpbXBsaWZ5IGFuZA0KPiA+IGNsYXJpZnkg
YWNjb3JkaW5nbHkuDQo+ID4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEV2ZW4gdGhvdWdoIGFu
IGFjdHVhbCBtZW1vcnkgbGVhayB3YXMgbm90IG9ic2VydmVkLCB0aGlzIGZpeCBzZWVtcw0KPiBs
aWtlIGENCj4gPiA+ID4gY2xlYW5lciBpbXBsZW1lbnRhdGlvbi4NCj4gPiA+ID4NCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50
ZWwuY29tPg0KPiA+ID4gPiBGaXhlczogOWM1MDA4MzVmMjc5ICgibW06IHpzd2FwOiBmaXgga2Vy
bmVsIEJVRyBpbiBzZ19pbml0X29uZSIpDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgbW0venN3YXAu
YyB8IDMgKystDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9tbS96c3dhcC5jIGIvbW0v
enN3YXAuYw0KPiA+ID4gPiBpbmRleCBmNjMxNmI2NmZiMjMuLjU4ODEwZmE4ZmYyMyAxMDA2NDQN
Cj4gPiA+ID4gLS0tIGEvbW0venN3YXAuYw0KPiA+ID4gPiArKysgYi9tbS96c3dhcC5jDQo+ID4g
PiA+IEBAIC05ODYsMTAgKzk4NiwxMSBAQCBzdGF0aWMgdm9pZCB6c3dhcF9kZWNvbXByZXNzKHN0
cnVjdA0KPiA+ID4genN3YXBfZW50cnkgKmVudHJ5LCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiA+
ID4gPiAgICAgICAgIGFjb21wX3JlcXVlc3Rfc2V0X3BhcmFtcyhhY29tcF9jdHgtPnJlcSwgJmlu
cHV0LCAmb3V0cHV0LA0KPiBlbnRyeS0NCj4gPiA+ID5sZW5ndGgsIFBBR0VfU0laRSk7DQo+ID4g
PiA+ICAgICAgICAgQlVHX09OKGNyeXB0b193YWl0X3JlcShjcnlwdG9fYWNvbXBfZGVjb21wcmVz
cyhhY29tcF9jdHgtDQo+ID4gPiA+cmVxKSwgJmFjb21wX2N0eC0+d2FpdCkpOw0KPiA+ID4gPiAg
ICAgICAgIEJVR19PTihhY29tcF9jdHgtPnJlcS0+ZGxlbiAhPSBQQUdFX1NJWkUpOw0KPiA+ID4g
PiAtICAgICAgIG11dGV4X3VubG9jaygmYWNvbXBfY3R4LT5tdXRleCk7DQo+ID4gPiA+DQo+ID4g
PiA+ICAgICAgICAgaWYgKHNyYyAhPSBhY29tcF9jdHgtPmJ1ZmZlcikNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgIHpwb29sX3VubWFwX2hhbmRsZSh6cG9vbCwgZW50cnktPmhhbmRsZSk7DQo+ID4g
Pg0KPiA+ID4gQWN0dWFsbHkgbm93IHRoYXQgSSB0aGluayBtb3JlIGFib3V0IGl0LCBJIHRoaW5r
IHRoaXMgY2hlY2sgaXNuJ3QNCj4gPiA+IGVudGlyZWx5IHNhZmUsIGV2ZW4gdW5kZXIgdGhlIGxv
Y2suIElzIGl0IHBvc3NpYmxlIHRoYXQNCj4gPiA+ICdhY29tcF9jdHgtPmJ1ZmZlcicganVzdCBo
YXBwZW5zIHRvIGJlIGVxdWFsIHRvICdzcmMnIGZyb20gYSBwcmV2aW91cw0KPiA+ID4gZGVjb21w
cmVzc2lvbiBhdCB0aGUgc2FtZSBoYW5kbGU/IEluIHRoaXMgY2FzZSwgd2Ugd2lsbCBhbHNvDQo+
ID4gPiBtaXN0YWtlbmx5IHNraXAgdGhlIHVubWFwLg0KPiA+DQo+ID4gSWYgd2UgbW92ZSB0aGUg
bXV0ZXhfdW5sb2NrIHRvIGhhcHBlbiBhZnRlciB0aGUgY29uZGl0aW9uYWwgYW5kIHVubWFwLA0K
PiA+IHNob3VsZG4ndCB0aGF0IGJlIHN1ZmZpY2llbnQgdW5kZXIgYWxsIGNvbmRpdGlvbnM/IFdp
dGggdGhlIGZpeCwgInNyYyIgY2FuDQo+ID4gdGFrZSBvbiBvbmx5IDIgdmFsdWVzIGluIHRoaXMg
cHJvY2VkdXJlOiB0aGUgbWFwcGVkIGhhbmRsZSBvcg0KPiA+IGFjb21wX2N0eC0+YnVmZmVyLiBU
aGUgb25seSBhbWJpZ3VpdHkgd291bGQgYmUgaW4gdGhlICh1bmxpa2VseT8pIGNhc2UNCj4gPiBp
ZiB0aGUgbWFwcGVkIHpwb29sIGhhbmRsZSBoYXBwZW5zIHRvIGJlIGVxdWFsIHRvIGFjb21wX2N0
eC0+YnVmZmVyLg0KPiANCj4gWWVzLCB0aGF0J3MgdGhlIHNjZW5hcmlvIEkgbWVhbi4NCj4gDQo+
IFNwZWNpZmljYWxseSwgaW4genN3YXBfZGVjb21wcmVzcygpLCB3ZSBkbyBub3QgdXNlICdhY29t
cF9jdHgtPmJ1ZmZlcicNCj4gc28gJ3NyYycgaXMgZXF1YWwgdG8gdGhlIG1hcHBlZCBoYW5kbGUu
IEJ1dCwgJ2Fjb21wX2N0eC0+YnVmZmVyJw0KPiBoYXBwZW5zIHRvIGJlIGVxdWFsIHRvIHRoZSBz
YW1lIGhhbmRsZSBmcm9tIGEgcHJldmlvdXMgb3BlcmF0aW9uIGFzIHdlDQo+IGRvbid0IGNsZWFy
IGl0Lg0KDQpBbHRob3VnaCwgd2UgbmV2ZXIgbW9kaWZ5ICdhY29tcF9jdHgtPmJ1ZmZlcicgaW4g
enN3YXBfZGVjb21wcmVzcygpLA0Kd2Ugb25seSBjb3B5IHRvIGl0Lg0KDQo+IA0KPiBJbiB0aGlz
IGNhc2UsIHRoZSAnc3JjICE9IGFjb21wX2N0eC0+YnVmZmVyJyBjaGVjayB3aWxsIGJlIGZhbHNl
LCBldmVuDQo+IHRob3VnaCBpdCBzaG91bGQgYmUgdHJ1ZS4gVGhpcyB3aWxsIHJlc3VsdCBpbiBh
biBleHRyYQ0KPiB6cG9vbF91bm1hcF9oYW5kbGUoKSBjYWxsLiBJIGRpZG4ndCBsb29rIGNsb3Nl
bHksIGJ1dCB0aGlzIHNlZW1zIGxpa2UNCj4gaXQgY2FuIGhhdmUgYSB3b3JzZSBlZmZlY3QgdGhh
biBsZWFraW5nIG1lbW9yeSAoZS5nLiB0aGVyZSB3aWxsIGJlIGFuDQo+IGV4dHJhIF9fa3VubWFw
X2F0b21pYygpIGNhbGwgaW4genNtYWxsb2MsIGFuZCB3ZSBtYXkgZW5kIHVwIGNvcnJ1cHRpbmcN
Cj4gYSByYW5kb20gaGFuZGxlKS4NCj4gDQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYg
SSBhbSBtaXNzaW5nIGFueXRoaW5nLg0KPiA+DQo+ID4gPg0KPiA+ID4gSXQgd291bGQgYmUgbW9y
ZSByZWxpYWJsZSB0byBzZXQgYSBib29sZWFuIHZhcmlhYmxlIGlmIHdlIGNvcHkgdG8NCj4gPiA+
IGFjb21wX2N0eC0+YnVmZmVyIGFuZCBkbyB0aGUgdW5tYXAsIGFuZCBjaGVjayB0aGF0IGZsYWcg
aGVyZSB0byBjaGVjaw0KPiA+ID4gaWYgdGhlIHVubWFwIHdhcyBkb25lIG9yIG5vdC4NCj4gPg0K
PiA+IFN1cmUsIHRoaXMgY291bGQgYmUgZG9uZSwgYnV0IG5vdCBzdXJlIGlmIGl0IGlzIHJlcXVp
cmVkLiBQbGVhc2UgbGV0IG1lIGtub3cNCj4gPiBpZiB3ZSBzdGlsbCBuZWVkIHRoZSBib29sZWFu
IHZhcmlhYmxlIGluIGFkZGl0aW9uIHRvIG1vdmluZyB0aGUNCj4gbXV0ZXhfdW5sb2NrKCkuDQo+
IA0KPiBJZiB3ZSB1c2UgYSBib29sZWFuLCB0aGVyZSBpcyBubyBuZWVkIHRvIG1vdmUgbXV0ZXhf
dW5sb2NrKCkuIFRoZQ0KPiBib29sZWFuIHdpbGwgYmUgYSBsb2NhbCB2YXJpYWJsZSBvbiB0aGUg
c3RhY2sgdGhhdCBkb2Vzbid0IG5lZWQNCj4gcHJvdGVjdGlvbi4NCg0KSSBhZ3JlZSwgdXNpbmcg
dGhlIGJvb2xlYW4gdmFyaWFibGUgdG8gZG8gdGhlIHVubWFwIHJhdGhlciB0aGFuIHRoZSBjaGVj
aw0KZm9yIChzcmMgIT0gYWNvbXBfY3R4LT5idWZmZXIpIGlzIG1vcmUgZmFpbC1zYWZlLg0KDQpJ
IGFtIHN0aWxsIHRoaW5raW5nIG1vdmluZyB0aGUgbXV0ZXhfdW5sb2NrKCkgY291bGQgaGVscCwg
b3IgYXQgbGVhc3QgaGF2ZQ0Kbm8gZG93bnNpZGUuIFRoZSBhY29tcF9jdHggaXMgcGVyLWNwdSBh
bmQgaXQncyBtdXRleF9sb2NrL3VubG9jaw0Kc2FmZWd1YXJkcyB0aGUgaW50ZXJhY3Rpb24gYmV0
d2VlbiB0aGUgZGVjb21wcmVzcyBvcGVyYXRpb24sIHRoZQ0Kc2dfKigpIEFQSSBjYWxscyBpbnNp
ZGUgenN3YXBfZGVjb21wcmVzcygpIGFuZCB0aGUgc2hhcmVkIHpwb29sLg0KDQpJZiB3ZSByZWxl
YXNlIHRoZSBwZXItY3B1IGFjb21wX2N0eCdzIG11dGV4IGxvY2sgYmVmb3JlIHRoZQ0KenBvb2xf
dW5tYXBfaGFuZGxlKCksIGlzIGl0IHBvc3NpYmxlIHRoYXQgYW5vdGhlciBjcHUgY291bGQgYWNx
dWlyZQ0KaXQncyBhY29tcF9jdHgncyBsb2NrIGFuZCBtYXAgdGhlIHNhbWUgenBvb2wgaGFuZGxl
ICh0aGF0IHRoZSBlYXJsaWVyDQpjcHUgaGFzIHlldCB0byB1bm1hcCBvciBpcyBjb25jdXJyZW50
bHkgdW5tYXBwaW5nKSBmb3IgYSB3cml0ZT8NCklmIHRoaXMgY291bGQgaGFwcGVuLCB3b3VsZCBp
dCByZXN1bHQgaW4gdW5kZWZpbmVkIHN0YXRlIGZvciBib3RoDQp0aGVzZSB6cG9vbCBvcHMgb24g
ZGlmZmVyZW50IGNwdSdzPw0KDQpXb3VsZCBrZWVwaW5nIHRoZSBwZXItY3B1IG11dGV4IGxvY2tl
ZCB0aHJvdWdoIHRoZQ0KenBvb2xfdW5tYXBfaGFuZGxlKCkgY3JlYXRlIGEgbm9uLXByZWVtcHRp
YmxlIHN0YXRlIHRoYXQgd291bGQNCmF2b2lkIHRoaXM/IElPVywgaWYgdGhlIGFib3ZlIHNjZW5h
cmlvIGlzIHBvc3NpYmxlLCBkb2VzIHRoZSBwZXItY3B1DQphY29tcF9jdHgncyBtdXRleCBoZWxw
L2lzIGEgbm8tb3A/IE9yLCBpcyB0aGUgYWJvdmUgc2NlbmFyaW8gc29tZWhvdw0KcHJldmVudGVk
IGJ5IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgenBvb2xzPw0KDQpKdXN0IHRob3VnaHQgSSB3
b3VsZCBicmluZyB1cCB0aGVzZSBvcGVuIHF1ZXN0aW9ucy4gUGxlYXNlIGRvIHNoYXJlDQp5b3Vy
IHRob3VnaHRzIGFuZCBhZHZpc2UuDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+ID4NCj4g
PiBUaGFua3MsDQo+ID4gS2FuY2hhbmENCj4gPg0KPiA+ID4NCj4gPiA+ID4gKw0KPiA+ID4gPiAr
ICAgICAgIG11dGV4X3VubG9jaygmYWNvbXBfY3R4LT5tdXRleCk7DQo+ID4gPiA+ICB9DQo+ID4g
PiA+DQo+ID4gPiA+ICAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+ID4gPiA+
DQo+ID4gPiA+IGJhc2UtY29tbWl0OiAwZTViZGVkYjM5ZGVkNzY3YmZmNGM2MTg0MjI1NTc4NTk1
Y2VlOThjDQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMjcuMA0KPiA+ID4gPg0K


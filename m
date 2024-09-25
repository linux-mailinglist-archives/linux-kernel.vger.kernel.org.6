Return-Path: <linux-kernel+bounces-339528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F298666F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05171F23CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDB13BC18;
	Wed, 25 Sep 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGPeus3b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115974C1B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289578; cv=fail; b=HCryzFggXgeJHVuMIf83Q9Rb9bhBQbcFxZZ5YwJNUMLyo0TVdWdPQbfALQqghvwKZX/S+eT8AG5z8AptiO1+OKFd+OeIv6VpR11N4zjCRElVQCObMfRleSd/3GimTQbSAQZT9RDgchw7Tmn3UWPNcwX+XMj6/mJtgXb/xy8li+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289578; c=relaxed/simple;
	bh=g75nevuANRsc4Ts8jyNVzPgvyhO3yXMMsRMejYztrKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G8M17Xt43uf4hOY8fMQAhbF8TNNG0nLsuEwT+c0mxqVwgmjTd20u5WvU9TmopZx1Vo+lkP/KqGLaZAY/yKzqPOzTozflvTRqjcge0Sd9D+3nG4dr5ReDJ/RhugeDvTgQXwSCZPVUCpY3JNrUEzVCY2wD0Nchpg+92M54FCZFX0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGPeus3b; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727289576; x=1758825576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g75nevuANRsc4Ts8jyNVzPgvyhO3yXMMsRMejYztrKo=;
  b=QGPeus3bUS5GflsVS3GU/B1rQOUAyUSj3b6CveCgvtrGZCNoBsDH8+GU
   LDsX/TWx9NI1hFPySdw5rkXeqytkSTX7HGgX7YTDjFvzdL/MTygm2acfp
   xCpsRyiRb5wUos6lX4bhe++RjzlOLZFVo9jKDYCLIlZgCueAmvOOsOOh+
   C8TZdZY/zavEBcFCre0YUHJgY2lo2E8RcNpovtmeLyUV+B9UvbxMRVaUw
   mZerRuuDpbwvq8MPokJC0xkWhggzkPXseIWJWVjcktnBvqQO02eyJST05
   zqUr8dkGsWUvJ0mPkFPJuq/dzg8zXHHcERhGnxpPPHA6JV7s+/L9JKDzc
   w==;
X-CSE-ConnectionGUID: ifVb1iIYS8qAOjbuFx7Bzg==
X-CSE-MsgGUID: GkaYcAe/QdyOiKJHXs8xMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="25869900"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="25869900"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 11:39:35 -0700
X-CSE-ConnectionGUID: pVe9qKzFRVm2AVVKb9D/+A==
X-CSE-MsgGUID: ulFKhX1bSIKzyEwVvEPdsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="71750996"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 11:39:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:39:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 11:39:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 11:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmQhw8cmLfqDKkBjkN5CY6cSUXz/KIuuRrzBIe2wSoXGZQ8b4B7CX31wxELShokG0uu+ao9tERk4DDOv4c774WHRAGvMNF1OCpG2GLS+/aUtgJCAQ6feVT5rY2DfR2zTDEE6+v6JQiCyAbd/VJvgiK3Y4O0TWmVvPEEJ825s1TvQcuGAyVNzp2oNudYSvUbGPj4lSSfJLNyUcdsYcWcVFMacsLzQoeujlQGEpCH4v6Ua7L+nhVKpguyB3nHpGm/xF5jXzVVeIK0ewJgsDJGCzsoXd2qeo9iSJRvOyuyH4GHn2QXdYYoH2xfiMjGI/jr9JxLOlRbQshvpwedSvOUolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnN5KuA1oDmUudg9tYMpibIzYnwjpsv0hgW6TWFaGPk=;
 b=m74h/PvGIrEyibWp3kXYcZgf/6xO1oeCwDd9nOlwajnu5GZMbTdx9wKKshPLQTOJY9aYS8TtvDLUG/jkumJ5xvVvdjELRu75KhtPrEy/++bYrikQY+SO9G2bwql4Dgz9IrxJ5TRVkEfT4V5DQx4evUSTM2YK3KZdUr0SfuCVec+uZ3ZK96wjUXyx2cAeTAr3ZGa6PC7tC8zwDr1IeVz/uHl5DR4agi7KW6tOf88JKaYpn0aU+aAfL5rCrUt91c3k/Kkrhs5ucxzNuhhSkkL9AL9aY4GGkItsihMTzdK1rq1T60DNL2rog5Bc5EF/kqaMOxX7PStYX5WY64BI+PUF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 18:39:25 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 18:39:25 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHbDh9+WG1/kyAOWku1xyL3C5nTY7JoDu73gACtkAA=
Date: Wed, 25 Sep 2024 18:39:25 +0000
Message-ID: <SJ0PR11MB5678BC6BBF8A4D7694EDDFDAC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <87v7yks0kd.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v7yks0kd.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH0PR11MB4904:EE_
x-ms-office365-filtering-correlation-id: ab8df112-1186-484d-0dbc-08dcdd91616a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dw39mFceu2RyPvnayoNhIpYA/PJJP81VSLFnhyQa5NZmKQXnngySCyLCu1vU?=
 =?us-ascii?Q?RZREYTD4hzTYLrJIdRUHoLfaock4qCyANzxVRNNvQl2kcl8zGDy2yNv2YXRk?=
 =?us-ascii?Q?z903lvUI/0E7iCEIq2BNVYSjwc8oosA77hejfhvdyxnTvA6e7a8V+ycPLPlN?=
 =?us-ascii?Q?csX6Q9FL3yHW1W7H4kiYJFVNrGhlphXqrtkvLNvcUB5R/qVOtzGNpuOOt4Le?=
 =?us-ascii?Q?+84G5bnq3SzcuUIG+KDCrmJaGuttT3VSiyDi/u1IZO6n1aroVCr3bs4HMX0Z?=
 =?us-ascii?Q?bB3itqLoxqId4d/0vfMb26huqHL7RsvvJlwvYwHlydJjxMWMZ6Ii8b5Cqj7f?=
 =?us-ascii?Q?uR7nGTdaXqdxvKcC87QyMHgJse5MbTOVNwVHVOKybJP34tIvF9ICIzxSfclg?=
 =?us-ascii?Q?aCUSuVpUauZz4VSuFSTiztmnqJ8H4rsRmffmfrhEyvFcCm9yhqkhLmu/wAyc?=
 =?us-ascii?Q?iGNinK7CPvBPy7kMTR+l+QnvUstW4rxJZavKM26fiLzyIGEoKBFtKlAYnl/W?=
 =?us-ascii?Q?QHN2T2LUsNSv4z5o7wPAoQ6q1v/YsMD5PlEVz7lxYwNn6FliDdiOZ+UTqXSC?=
 =?us-ascii?Q?NlyXsQQ3/FvZEpfeGps89LvLwHqXYPCHxIvVigg3nYtpBzAyZxjcL9EB1ZeR?=
 =?us-ascii?Q?RH/dMD4tpTw02FFZHJDgsc2n85Fta4hPinCd8VxMPu7iQdkwjFVAGTMi3l4r?=
 =?us-ascii?Q?/yiCYOfaqAEFLY3I0FWMAlAiGAVbi4vzz+msKpMzENlA0OtpMKmNDZsIcVG8?=
 =?us-ascii?Q?qWJ4ZEafxCSy9hNWTLmGn2mgQ25sEWK8/DiEu+X4mtMvnfVXnXOc6+VGdCWT?=
 =?us-ascii?Q?iDQ19LfGXVpYrALPiELuObO4Su63li8GX0U37uSYMjRhZEptAxlzfQbbLWyh?=
 =?us-ascii?Q?VZv6+lGxZAL+iM7gcbHRBkvRlIu/lrTkh6Qn8DVARUiYNzKi24OoftWQ+Hl8?=
 =?us-ascii?Q?PVHFDglzTbksC7T/6zUKqLByu3J4twkNjTOtZmbXL75gDj2iBEyf4vfcYdgU?=
 =?us-ascii?Q?7+tFuSNuYTzH+5/LpnTSp1ZWCMfygqojsMI7e41NgZgs+YttNXJQmlHU287R?=
 =?us-ascii?Q?5p6qaU6dZ3wRUJs8jGwn/cLM3wLbfbJhvx6qbD5/gD5vIViQYeUcyRzXsfrP?=
 =?us-ascii?Q?3iNl524GLx1VmhbF1lsZg4PimrTJu0p4uK5wse++f9Yop15HGXwyRQLwW5EJ?=
 =?us-ascii?Q?HEpXlNjZJp7WVB61wBPm8e87aX+J2+HvfGys3SSRdpN1aa4rdBjEUeDTl84G?=
 =?us-ascii?Q?mpc5FMlPKnE8qJKMqCwaGvQr0cZbZufbQdufl0AL+JSZKQsbm+hQXonxhBz6?=
 =?us-ascii?Q?31PKWy+tOhXgTrNH/Sec+vomjBv63gbngTs20oBgRc+QZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cg9fpu0wYe16J2wKuvHXETOoTNwZd8lbXs5l01Zb/AracSs7ZN6ADrWEbKf9?=
 =?us-ascii?Q?hfFmzhtBeAcZ7AbNqfcph0rJNRpuBC3KbPksjAD6Suzthgq/MD1sdZsWBgSa?=
 =?us-ascii?Q?6BdxBZWeuySuOTRYh44UOnZDDvZNpQgLQxLr91ug27HtODd8SdSJE6NIXO40?=
 =?us-ascii?Q?dTSHKoIc6BkbJNHQ2zJL11Vj3zRkojlJixMrCm6yc7GyP5LA3BWvN6ccwCtq?=
 =?us-ascii?Q?TmqHOeQuEhr3/UmnY0pRgPguIJ+myhePLy+P7Hl44LwvYnY+g7NwvAldXoBW?=
 =?us-ascii?Q?YR+NAwinEdqZAJA9BkpbMtji7WllGwJnyGx2QozEEU42lb5y1sdH9ALVStfr?=
 =?us-ascii?Q?+8rniM1SMoRlJS6luJpvXB6MntQHszkRZLpy+rChQORu4lKRQNtNwfep1K9A?=
 =?us-ascii?Q?EVfvkMeIPk9ysNolnTieiMUpYQyBUEOt/ZlX8eSqepVA0FgCin8WwJg7qev4?=
 =?us-ascii?Q?fJpm6DrjtbZGohpU40VM6o1/sRllQVfF0L9pryNUH40oucXQE6tseP6ci25f?=
 =?us-ascii?Q?CMSmmwL941vVLuFAwIKDxsyF+7toDhQGRt8Xpkqw39myeIeud8kepkDX0+C0?=
 =?us-ascii?Q?PNvCZ5xYPA5xaKLF2TE9EG9Z/1v9+d00u7tOj6ttJxLjFfYyCFIDgAq9RhDl?=
 =?us-ascii?Q?YQ+Ly6paQX81+b4w3C/CCydsVcIHGQdT4J38CZ2o1FLvctW3qYSYJWHlOdQh?=
 =?us-ascii?Q?QrbLYB5NZgj7tlYNWfAx6xMXkd03W2VbYEyDGs/6wMBo65+OA/IzzFy2qCMG?=
 =?us-ascii?Q?QNcxPLOsDOHOTIyZ1sC141RdSqWIG02SIBqL4EZgZKyYAcBpc17/VwQRCfEJ?=
 =?us-ascii?Q?2YWtOuX+C2/0g5X4gmD6+LwvfIgWg5X3HjZ9lkbgPckEHPhT4PsYlrWAOmgu?=
 =?us-ascii?Q?IY3ROX+dOTnWRNjvG/kZ2LPEnz6xxdaiagdprcpmkgygxBhce7p24HfQaW3s?=
 =?us-ascii?Q?CYNonmioVZDKqi2H1NAeQscJJ59cXQ1p5HAGi2TFrWMPhELOGa9octDEkbSU?=
 =?us-ascii?Q?4c7BOW4YmVFyPHMq2TkzMReIuAzQznrkIF2UwIq5NF5VV/S8igOAx9fEaM9T?=
 =?us-ascii?Q?XmGY0/0WlHgfHMGmoaAI1BDPT26b6OF4ripkybvahbEkm/fUlHI6grYYtfIt?=
 =?us-ascii?Q?Hp7YpdzJwCHOQK+/a0F4xxkhQcsTZZgHIgd0GF50NEC25joQcD9eKnxR1NXx?=
 =?us-ascii?Q?ryFL78jE+TaoX6ODFdgDLprs6QobG4K1O50VWpst9M3my2maZtcg4r8CyBx9?=
 =?us-ascii?Q?MSe3gHthIVgz6qjo4PqH2rH3T9svvY6tW+9ehBfcnqmUT+yf3D1JAMyjcC2D?=
 =?us-ascii?Q?2omKNg7fkraREJWenznxwO1Yti5zDVrDb9arvUx3UWt+aGcmb4rgxQomKSyE?=
 =?us-ascii?Q?Z3tJlAw8K3kjygYIxJa6LgaCtO2CqZCKs6y3mY/qT0ZqWS0XLYShlWqx5gPq?=
 =?us-ascii?Q?6L928nd9ownGjCF6+3DDXxm60th0q+ITwue3WnP0ivT4r9BnpDppQDuWgzaS?=
 =?us-ascii?Q?MoNAtNh29rJhWpaM889n5GPjcXbMqPDjS1lctF9d0P2gN25Nk7+XerGyn9y5?=
 =?us-ascii?Q?69c8zxxs7NMtF6XGC1BWZEJew0zhu4R/KSkXoq4N9A3enMWCySOOr7vJu/t/?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8df112-1186-484d-0dbc-08dcdd91616a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 18:39:25.3868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbZJQwRcbQU/P6jkCvMrQSkR40g4PIcDyuN4p9QSKp+gJBhLB6+8CHp/MOK4QAOzY4irPpmVjZGq4X4edPodFYoV0BKyl4jbJMuQ2gVb+mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Tuesday, September 24, 2024 11:35 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; 21cnbao@gmail.com;
> akpm@linux-foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali,
> Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
>=20
> Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:
>=20
> [snip]
>=20
> >
> > Case 1: Comparing zswap 4K vs. zswap mTHP
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In this scenario, the "before" is CONFIG_THP_SWAP set to off, that resu=
lts in
> > 64K/2M (m)THP to be split into 4K folios that get processed by zswap.
> >
> > The "after" is CONFIG_THP_SWAP set to on, and this patch-series, that
> results
> > in 64K/2M (m)THP to not be split, and processed by zswap.
> >
> >  64KB mTHP (cgroup memory.high set to 40G):
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  ----------------------------------------------------------------------=
---------
> >                     mm-unstable 9-23-2024              zswap-mTHP     C=
hange wrt
> >                         CONFIG_THP_SWAP=3DN       CONFIG_THP_SWAP=3DY  =
     Baseline
> >                                  Baseline
> >  ----------------------------------------------------------------------=
---------
> >  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd=
 deflate-
> >                                       iaa                     iaa      =
      iaa
> >  ----------------------------------------------------------------------=
---------
> >  Throughput (KB/s)   143,323      125,485     153,550     129,609    7%=
       3%
> >  elapsed time (sec)    24.97        25.42       23.90       25.19    4%=
       1%
> >  sys time (sec)       822.72       750.96      757.70      731.13    8%=
       3%
> >  memcg_high          132,743      169,825     148,075     192,744
> >  memcg_swap_fail     639,067      841,553       2,204       2,215
> >  pswpin                    0            0           0           0
> >  pswpout                   0            0           0           0
> >  zswpin                  795          873         760         902
> >  zswpout          10,011,266   13,195,137  10,010,017  13,193,554
> >  thp_swpout                0            0           0           0
> >  thp_swpout_               0            0           0           0
> >   fallback
> >  64kB-mthp_          639,065      841,553       2,204       2,215
> >   swpout_fallback
> >  pgmajfault            2,861        2,924       3,054       3,259
> >  ZSWPOUT-64kB            n/a          n/a     623,451     822,268
> >  SWPOUT-64kB               0            0           0           0
> >  ----------------------------------------------------------------------=
---------
> >
>=20
> IIUC, the throughput is the sum of throughput of all usemem processes?
>=20
> One possible issue of usemem test case is the "imbalance" issue.  That
> is, some usemem processes may swap-out/swap-in less, so the score is
> very high; while some other processes may swap-out/swap-in more, so the
> score is very low.  Sometimes, the total score decreases, but the scores
> of usemem processes are more balanced, so that the performance should be
> considered better.  And, in general, we should make usemem score
> balanced among processes via say longer test time.  Can you check this
> in your test results?

Actually, the throughput data listed in the cover-letter is the average of
all the usemem processes. Your observation about the "imbalance" issue is
right. Some processes see a higher throughput than others. I have noticed
that the throughputs progressively reduce as the individual processes exit
and print their stats.

Listed below are the stats from two runs of usemem70: sleep 10 and sleep 30=
.
Both are run with a cgroup mem-limit of 40G. Data is with v7, 64K folios ar=
e
enabled, zswap uses zstd.=20


-----------------------------------------------
               sleep 10           sleep 30
      Throughput (KB/s)  Throughput (KB/s)
 -----------------------------------------------
                181,540            191,686
                179,651            191,459
                179,068            188,834
                177,244            187,568
                177,215            186,703
                176,565            185,584
                176,546            185,370
                176,470            185,021
                176,214            184,303
                176,128            184,040
                175,279            183,932
                174,745            180,831
                173,935            179,418
                161,546            168,014
                160,332            167,540
                160,122            167,364
                159,613            167,020
                159,546            166,590
                159,021            166,483
                158,845            166,418
                158,426            166,264
                158,396            166,066
                158,371            165,944
                158,298            165,866
                158,250            165,884
                158,057            165,533
                158,011            165,532
                157,899            165,457
                157,894            165,424
                157,839            165,410
                157,731            165,407
                157,629            165,273
                157,626            164,867
                157,581            164,636
                157,471            164,266
                157,430            164,225
                157,287            163,290
                156,289            153,597
                153,970            147,494
                148,244            147,102
                142,907            146,111
                142,811            145,789
                139,171            141,168
                136,314            140,714
                133,616            140,111
                132,881            139,636
                132,729            136,943
                132,680            136,844
                132,248            135,726
                132,027            135,384
                131,929            135,270
                131,766            134,748
                131,667            134,733
                131,576            134,582
                131,396            134,302
                131,351            134,160
                131,135            134,102
                130,885            134,097
                130,854            134,058
                130,767            134,006
                130,666            133,960
                130,647            133,894
                130,152            133,837
                130,006            133,747
                129,921            133,679
                129,856            133,666
                129,377            133,564
                128,366            133,331
                127,988            132,938
                126,903            132,746
 -----------------------------------------------
      sum    10,526,916         10,919,561
  average       150,385            155,994
   stddev        17,551             19,633
 -----------------------------------------------
    elapsed       24.40              43.66
 time (sec)
   sys time      806.25             766.05
      (sec)
    zswpout  10,008,713         10,008,407
  64K folio     623,463            623,629
     swpout
 -----------------------------------------------

As we increase the time for which allocations are maintained,
there seems to be a slight improvement in throughput, but the
variance increases as well. The processes with lower throughput
could be the ones that handle the memcg being over limit by
doing reclaim, possibly before they can allocate.

Interestingly, the longer test time does seem to reduce the amount
of reclaim (hence lower sys time), but more 64K large folios seem to
be reclaimed. Could this mean that with longer test time (sleep 30),
more cold memory residing in large folios is getting reclaimed, as
against memory just relinquished by the exiting processes?

Thanks,
Kanchana

>=20
> [snip]
>=20
> --
> Best Regards,
> Huang, Ying


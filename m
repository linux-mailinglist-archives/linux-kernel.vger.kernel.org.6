Return-Path: <linux-kernel+bounces-337711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E928F984DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178611C240FD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52A1AB6F3;
	Tue, 24 Sep 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om8XqWGm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4071AB6D2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217187; cv=fail; b=nnw5PxatS+tgWMW8XJa+FFFx7mSuINY2mclx8BaAhLz3ZMQ6ttBUSfRSBVLWuPznVFiJTNt+iE0XEUnUeFr7pCC3BWzhHQFgTtxXa4nQKZoPvfALjxGdMvBdNS/QJv7odSJfFeqvutjCwa1wKJeLFXyOb81DXAio6/AS9KETHF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217187; c=relaxed/simple;
	bh=EpuzYqJgLzTxM8gUl+KQWC+LR6tzHnVWYjWgmadFnz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGgpAMo2+7C124upIkmL1KJuwIAqg7knefgnnx2P66JqVVlK18kMkFEvZKGL0lzBxG3LApK5jKr+M0KPMB+XSuBlbYYHo7kNj4EXT3iwVCe7qmR7tRGWNvt5ZkRVFec0NSqNyyo6xCLOdKrBRJLu7pxB2Wm8aAIsk4InIT5qA4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Om8XqWGm; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217185; x=1758753185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EpuzYqJgLzTxM8gUl+KQWC+LR6tzHnVWYjWgmadFnz4=;
  b=Om8XqWGmmWObmkW73dC/NyMbeJSN1mjC52QG26OFT0GOYFJNx1Q1BsMO
   w9XXW/WiGLEYiESa4mHs28YnwsBMX8fjwbXq414Rt2Ge0NX4hgcvqNnbl
   I20lYDRNBrMDEcsPzw+k+zO+9V3znNmAo95nTgsmrlBBk7poT5HOmwYba
   OO6w0X5B/dn65TPK7GaJsNWNJbilIq/zUdJO4crUZxzLYO+7HaMy0Z5Bq
   CIoogb0WMpyRx6MvIc5tqIMUDMTh03L5nUXTbo34vj7AyWsNK0QjuVIap
   Z7wzWbv1WQ9tLB9ojMabHaxr5lmxxzS/Focg4kx1eouHDd4I7iJmVHeIY
   g==;
X-CSE-ConnectionGUID: nsuAAlbtTN2K7mRjIZeLiQ==
X-CSE-MsgGUID: LJNPWpIJQF6zXq1V1NWmyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="25754849"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="25754849"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:32:08 -0700
X-CSE-ConnectionGUID: DA/NXCe2T8GTJ3edgN6aIw==
X-CSE-MsgGUID: PCvwe5sgTpKSPbkmhoUShQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="75960551"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 15:32:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:32:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 15:32:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 15:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix/FtODxwvy7aEQRhsf0UypeWYE0NrDQL38rxqvIuJyRhfcfmC10QjOLbEYSzCGqdZKO37HqdO+0dsHfF4o3EvTRmBbvTqbcbTsT7ajuZdWfopDqplz0vLIDXOMMqhRC3+kb5zvgUBYCBDJQI7tkY0C0592LSjPFQEx2BFu1F2X6LYB3nyXUGV2idJ46TivuHXKaliUduAyemO/BsW08ir7hrwZN0Eri3ZPjEjXkZTqj6lgKJllY2Yp2T6nOheShQOroGXs+qZiTspoHxBfaq0SHiOXzLIYMOE1NN94O22W3+oksZu2V0jCS+DWi0rN50GwGMD/s3Gc59t2L9D45WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpuzYqJgLzTxM8gUl+KQWC+LR6tzHnVWYjWgmadFnz4=;
 b=sqtTK4i/qUbb9yusUOX6HkakJmCMoSOtpXSyGlevOWQ9NHWo5WvexJoR49HpA4tYtdOqP1qjigqnsS/rZDmawUTi434WMHuBkSNDMKhvKntdFsqvWFytDh+LaJaxJQ6bOoQI70MYBhnP2fgIL58iLc80jj+6AS0qzNYIWwRmqG+1tqFphKcREsPMIt38PfaLz/+FJif7vLvGio5HzSZ+B16GScYTyi7mz33RrqbZSolBxVrJGRzJcpEo58A8EiA5S2ZLCMX6ypWISTFkVFlkY5Pc8fvMFTwjBvVNWyaIeWv2OLRGDNyV6WwkBgPEy76rOi17TQ0xTpegft7Z+h3J2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by BN9PR11MB5321.namprd11.prod.outlook.com (2603:10b6:408:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 22:32:05 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 22:32:05 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
Thread-Topic: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
Thread-Index: AQHbDh9/7v3nj1Rpsk6L/K4X0ZY53bJnUVKAgAAzI6A=
Date: Tue, 24 Sep 2024 22:32:04 +0000
Message-ID: <SJ0PR11MB5678E588D9640C92E06AB0A8C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
 <CAJD7tkbdRPKxOoVJMg5XdQuoByE1yuOjEENuM=wDnh_cOQZ7mA@mail.gmail.com>
In-Reply-To: <CAJD7tkbdRPKxOoVJMg5XdQuoByE1yuOjEENuM=wDnh_cOQZ7mA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|BN9PR11MB5321:EE_
x-ms-office365-filtering-correlation-id: efd332ac-f24c-4e99-ec08-08dcdce8b790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eG9pSERDOXFjL0oyVk8rMFJQaWdnSUIrbkRqOElRSlQ3QmM2Rm9HUHovaFlI?=
 =?utf-8?B?Vlc0K2t5dWNEUGNTaVc4NkdKZDZBWE9iUWJsR0FzZ0pGWFpncWoyVnB6UEps?=
 =?utf-8?B?ekNYZUFSeHg3R0RoVllTcUpyb0JRejZ4ZDZyLzZCanNQaXBZMmdPbjl2UzZq?=
 =?utf-8?B?WXdvbExwdmdDd09tMHVFL3pocG1sMTZmVEtiRUV1UFVjZncxc0NvVnRhdHQv?=
 =?utf-8?B?Zm1xSmR1RGtZcFB1WDhXWjhTU1llVmhFVm0yTklITENVc05MeTd0RCs5TFpN?=
 =?utf-8?B?dFVFN3FLM3lEcjNsc0t2bDZOR2RaalM3NFdFeVdTMVFpWVJCMmRTK0d5cjdM?=
 =?utf-8?B?NGR3ZWQ3bkRpL2xpVmgxa2orWHZ2akpXYTVoelFKaUpGd3JnMHN1OXlJZTcw?=
 =?utf-8?B?T3BwMzFjWHdkU0VPTlBzOTZRMk94YVVwKzM3TS92TVdVVmQ0QWltcXVSVm51?=
 =?utf-8?B?NklxNkZ4bDNjWnEzSlNDdHd5eDVDUUlsUStNejVDbjFzN0F0Z3dkV3J0bG1h?=
 =?utf-8?B?a3YybDJhMG1BVGJaTFhBUVNzZW1hNElXUnQ2MEFvamJ1YS9uVEFyUUNFeXdP?=
 =?utf-8?B?blBsalBUdEhjMTZ2Y2J5RGtFMGtXcThtMnlScDg0d0ZZK2ZidEFkYkZ4cGx5?=
 =?utf-8?B?VUYzenpPajZtb2lrLzlPcDRGcDlHa2cyVHBLOG82SUhGUGp0eEQvVFMzZ1Rk?=
 =?utf-8?B?ZFI3R3NCdUI2a053Zm8zU1ZiOHpabGRyY2JqRS9FcnMyaGZmSVlOTXBESWdt?=
 =?utf-8?B?d1VtSFNHUlB1Ymt0K0hTNHRFaTRhdUpNY01aL1lIZUtOcmpVQVBvQWlDZm5h?=
 =?utf-8?B?Q3RlWjFWcnBTdm9xVU5UVHN0UmQzZjJHUitHalQyRkdzblZRRm1PNFY2ODM5?=
 =?utf-8?B?TTEyV2Vtd2o5ZkhHSUQ0dFNlVEIyeS9BMTR4eDB5bk9XOG94MjAzVU0zSmlm?=
 =?utf-8?B?REdETWkwMUVJNmdXUkgrTW5PY1dqVmhOUFFrSk5UZE1YbzZodm1JYjE2UExE?=
 =?utf-8?B?bVJXdkpVUjBFSm5HdTlPNEhncklXZ1hzV2ZzbStwYisxQjM2YU43emVSWmFa?=
 =?utf-8?B?Y0tkNkEyVmUvTVh1YkE5anMzcVF3Nzh2U05KNy9lVG5BR2JqOUl1OHdKTkpZ?=
 =?utf-8?B?dkpLQ2Fvc2szVWUzRXhMV2pVUDJ6cXV5TDhaQmhSbWppbFhQalJxV1pYcGli?=
 =?utf-8?B?dWk0TVhMRTM1Q2dlbzFnY0o0bnlGbFIrcU9rOVo4NGdNcXY3NzQ4cmFLV3Ex?=
 =?utf-8?B?MTI3dWh0clkzeklNMFlMZGFTaUNSV1ByUUpzL0VPdGdPcDFhOXZGaVNMWTJP?=
 =?utf-8?B?MTY3RTRZR1B6QWxkdE4vRFJrT2YzN240aXQyenh3Q093NG4vZkdaNTRIcEVa?=
 =?utf-8?B?QTlsbSs2WEkwUUV3dzVmY0dQQ3R1emFZR0hDUUZ6RkhKWVRnajM2Rkd6blVl?=
 =?utf-8?B?RVhYREY4MmUxOXIyc0I2eVV6WUZ5azhhblhSR1BFWGJjaVpjc1MvVVVRL0hl?=
 =?utf-8?B?U0VZRGxzR1paeVI0aHhNY2JDTXcxNlRpSjJIYk5ibVpKN3ZzRDBFQTliRVB1?=
 =?utf-8?B?MmQ2ZTdxeXZBZmxYeGNXRlJDM2xoaWNxOHAxU1owa3ZSenZjTDE5ZjJZd01n?=
 =?utf-8?B?UG85ZFY4T3pqRVBHMjRZSjVSMmlielJBcVE4bmsxV1hJZlg1MU5nWXB6S3lS?=
 =?utf-8?B?R0pIV1dNZWVFVHk1YW5XYnltTzExRUdBQVcxTDFCVzl2NlE5STFDTTRYcUpK?=
 =?utf-8?B?cXV1NCtzVnN0NnVqV1RrWlZ4bzRBMm1ic04xaEkzQWNpUk5oNzhIZ242OTRF?=
 =?utf-8?B?OGZBUWNibEZPa3lOZFp6QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTk4aUNNZS9qenVBc3VyTHpsV3RzUlJoWHZGeGtRMEJKeDI2TGxmOHZTSldr?=
 =?utf-8?B?RUNSRUFhVjN0c3Z0MVpvSy8rTW5NeWRyaENEa1lEU3MzUGo3dzdOWVlBd3p0?=
 =?utf-8?B?dGJSQWVLeG5hL1p6UVZBdkRjY0JYVU83eHNlMzZPc1FEMWt6K0wxekVvSWV3?=
 =?utf-8?B?OTZhNW9ieTZnN0g0RG5BdG1HZVJVVFhFQmVpK2YyVTJrMWp3WUt6TThaMkhx?=
 =?utf-8?B?blAvR3lza3hYbDdpenVzWTIxazR0SHpXVUh6WHRGL0lPWFRuYVU2OGFiVnV2?=
 =?utf-8?B?UkF4ZmJPaTZFYTNPOFZRc3ZXditKL0JqSE1KNWUxVUxMc2h2Rlo2QlRHdEhU?=
 =?utf-8?B?b2w4R0g4T3FTeVhEUjRCMUMrRFdsQjkzMyt0ZFBNREdYbXhib0FKNkhqN2NB?=
 =?utf-8?B?S0liTTBuM0xoK0ZOM2NJWkZpays4ZEJlSDBMKzRqclY5UDFrYnZpS3RoaDB3?=
 =?utf-8?B?eTI2bEFrdGVFUTdzcjMrMXpOeHlOb3V5Kzd0eFJPQ1lZLzhCaXR6L0JLSkli?=
 =?utf-8?B?UTEvYUd2RnNSQVB1cG5CbHpqNWVwRVh4OHJESXFXQ2wvdEkwTTVoQmczS1Ft?=
 =?utf-8?B?RGRCL2xIbUtBcGVYWTRQTzVBM0g4VGdzNlRVZzl1RWdnWnJlNWxNSlRNbjJG?=
 =?utf-8?B?S2R0a1dGeW03bC9aTElkN0diVTVaNUVnNm9oWWhUb3pVYVZhMkZuamhoUWh6?=
 =?utf-8?B?RDU3SkdmQnRXbnJlQjFzd3ZLY3o5Q0NjN2VYa2VjcEZyOWlVdkdvQVVISm5S?=
 =?utf-8?B?VFB1bm5FVW5RaTQvTWFxOXRPYkdSeEVmaHV1SDk5dUc2V1MzTjEyUDhyaDhv?=
 =?utf-8?B?MDY5V1IxR1RuSTZVd3g1SEpQOU1oaEMzQll1YnpZa2s4YXAvUGFkdlJzUW8v?=
 =?utf-8?B?ZUFEc1NpUVQzNEI3NzlZSkdseWV6UmtSM3JXclNSWEN5eCs5N0FSeHdNOHU3?=
 =?utf-8?B?Qnc1OXhtMjNnbGNnaTlPRCt3cUpYajltNmZpa1pzeGdQYlY5Uk1YUEUwcFlr?=
 =?utf-8?B?L25oQ3AycDFOdXJaSjJZeDVWWXNzVWNYRGtidStLWXQ3aUJQa0I5dFJkcXJW?=
 =?utf-8?B?SzI0NlhYSzZxV3FYNHMreFo2dGVuVGVkc2E5UkhPUHNXejJCa2xZUEt0dDFH?=
 =?utf-8?B?TzdoRDJtQjdWVkV6MVFuWkNLTzJJK1ZFQlNUUVJHY0pOMVZyWHByTWljNHFu?=
 =?utf-8?B?ZGpRVXlhcFlCZ3dKQU1TZytSR2ZISTI2QnNzc2dLQWZOSyt2N2xLWmJOenB1?=
 =?utf-8?B?bEZjS0p6VWxmT1BTUjEwZW5za2JaRmFKbWJZVHpsSXNNam1NYjM1Rkk0MDVT?=
 =?utf-8?B?OVZEQVRackx1dncvVjZVZ0JSOW9ZWWR6c296UDJhNFU2MmNsaEZKNVBaWDFW?=
 =?utf-8?B?SHcyaUpMNWJKQmNtNC9XNkRrTGVMMklUTDhxSGJNQWQzZ0RjV0xBaFZxUi8y?=
 =?utf-8?B?WHhXMUZnUFA2eUZFK21HNXZkbE8wMWU0ZDBoNVN3bmxFTXU2VGt2MW93aDJ1?=
 =?utf-8?B?ci9la29FcmNjTEdiRGtyQ2lzUnFYN1RzUTd5MFNuZmw0WE9SWW1FeDYvMnEz?=
 =?utf-8?B?cFU2aUdnTW9iaU5JNDhwakc2cXo1NXExYk5EUkkvdmVLY3VTK0h4V3JhKzVN?=
 =?utf-8?B?WEIrKzFlVFBUNE9GanpOWGNUdDU1WG1PbWxGOUZ1WWVibVlSODBEb2tGMzYw?=
 =?utf-8?B?Qm10UjgxWHNvY2RZZmRvWlZOMU5PWFk4bVduNEk3TWtnLzJzTnNEZlgydERD?=
 =?utf-8?B?ajgrVUJueTFoS3hBaEUyRERvOFZhdkpmSVk3UzRzQ2lwdEtydklsMU1abUpo?=
 =?utf-8?B?Q0dzSzhjTmVBSUx0MzNMSnVLZU5Ua3JsVUxqSWlSMWo1alloeDg0a3kzajJ1?=
 =?utf-8?B?cnYwZUZZSlBleXR4RjNYWXFldkd4UzRoM243U1JRZEo2ZWE0M3pEOHNYZ1lw?=
 =?utf-8?B?d2tiV005NEMxbzNOWkFJR1RlQlpVOGsxSnZadzI5aHQ0Z2Y3MWF5U3VJRVY1?=
 =?utf-8?B?RENuMHMxbmh1THhpVkZxdHgyS1FlMXRXK1RLNEFpSWdlNzFGSWFWTXB5bXho?=
 =?utf-8?B?SDVvRTVKdlczc0xQNGZ2dEFUc0d6SjR2UjVRalIxeHJ5a29WczhUK0JZc3Z5?=
 =?utf-8?B?TkN3d0ZyWGttNVVJdExNT1hmNUlMN3FMOHZsakFtS3JiUVMzbE5qVFZ0SW9T?=
 =?utf-8?B?ZEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efd332ac-f24c-4e99-ec08-08dcdce8b790
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 22:32:04.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+N6INbipoNQkjPVgg03XZjlYpkHDdhmYHXqAjnpXUSdETffiNqufxNi86KvLjOFU4UVcuVzx1YRuedue0/emLpsuUwp4KHjXZI75ou8Q6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5321
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgMTI6
MjAgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFj
ay5vcmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207IGNoZW5nbWlu
Zy56aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgc2hha2VlbC5idXR0
QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1
YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0
aW9uLm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2Fq
ZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9k
aC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgNC84XSBtbTogenN3
YXA6IFJlZmFjdG9yIGNvZGUgdG8gZGVsZXRlIHN0b3JlZA0KPiBvZmZzZXRzIGluIGNhc2Ugb2Yg
ZXJyb3JzLg0KPiANCj4gT24gTW9uLCBTZXAgMjMsIDIwMjQgYXQgNjoxN+KAr1BNIEthbmNoYW5h
IFAgU3JpZGhhcg0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBBZGRlZCBhIG5ldyBwcm9jZWR1cmUgenN3YXBfZGVsZXRlX3N0b3JlZF9vZmZzZXRzKCkg
dGhhdCBjYW4gYmUNCj4gPiBjYWxsZWQgdG8gZGVsZXRlIHN0b3JlZCBvZmZzZXRzIGluIGEgZm9s
aW8gaW4gY2FzZSB6c3dhcF9zdG9yZSgpDQo+ID4gZmFpbHMgb3IgenN3YXAgaXMgZGlzYWJsZWQu
DQo+IA0KPiBJIGRvbid0IHNlZSB0aGUgdmFsdWUgaW4gdGhpcyBoZWxwZXIuIEl0IHdpbGwgZ2V0
IGNhbGxlZCBpbiBvbmUgcGxhY2UNCj4gQUZBSUNULCBhbmQgaXQgaXMgYSBiaXQgaW5jb25zaXN0
ZW50IHRoYXQgd2UgaGF2ZSB0byBleHBsaWNpdGx5IGxvb3ANCj4gaW4genN3YXBfc3RvcmUoKSB0
byBzdG9yZSBwYWdlcywgYnV0IHRoZSBsb29wIHRvIGRlbGV0ZSBwYWdlcyB1cG9uDQo+IGZhaWx1
cmUgaXMgaGlkZGVuIGluIHRoZSBoZWxwZXIuDQo+IA0KPiBJIGFtIG5vdCBhZ2FpbnN0IGFkZGlu
ZyBhIHRyaXZpYWwgenN3YXBfdHJlZV9kZWxldGUoKSBoZWxwZXIgKG9yDQo+IHNpbWlsYXIpIHRo
YXQgY2FsbHMgeGFfZXJhc2UoKSBhbmQgIHpzd2FwX2VudHJ5X2ZyZWUoKSB0byBtYXRjaA0KPiB6
c3dhcF90cmVlX3N0b3JlKCkgaWYgeW91IHByZWZlciB0aGF0Lg0KDQpUaGlzIGlzIGEgZ29vZCBw
b2ludC4gSSBoYWQgcmVmYWN0b3JlZCB0aGlzIHJvdXRpbmUgaW4gdGhlIGNvbnRleHQNCm9mIG15
IGNvZGUgdGhhdCBkb2VzIGJhdGNoaW5nIGFuZCB0aGUgc2FtZSBsb29wIG92ZXIgdGhlIG1USFAn
cw0Kc3VicGFnZXMgd291bGQgZ2V0IGNhbGxlZCBpbiBtdWx0aXBsZSBlcnJvciBjb25kaXRpb24g
Y2FzZXMuDQoNCkkgYW0gdGhpbmtpbmcgaXQgbWlnaHQgcHJvYmFibHkgbWFrZSBzZW5zZSBmb3Ig
c2F5IHpzd2FwX3RyZWVfZGVsZXRlKCkNCnRvIHRha2UgYSAiZm9saW8iIGFuZCAidHJlZSIgYW5k
IGVuY2Fwc3VsYXRlIGRlbGV0aW5nIGFsbCBzdG9yZWQgb2Zmc2V0cw0KZm9yIHRoYXQgZm9saW8u
IFNpbmNlIHdlIGhhdmUgYWxyZWFkeSBkb25lIHRoZSBjb21wdXRlcyBmb3IgZmluZGluZyB0aGUN
CiJ0cmVlIiwgaGF2aW5nIHRoYXQgYXMgYW4gaW5wdXQgcGFyYW1ldGVyIGlzIG1haW5seSBmb3Ig
bGF0ZW5jeSwgYnV0IGlmDQppdCBpcyBjbGVhbmVyIHRvIGhhdmUgInpzd2FwX3RyZWVfZGVsZXRl
KHN0cnVjdCBmb2xpbyAqZm9saW8pIiwgdGhhdCBzaG91bGQNCmJlIE9rIHRvby4gUGxlYXNlIGxl
dCBtZSBrbm93IHlvdXIgc3VnZ2VzdGlvbiBvbiB0aGlzLg0KDQpUaGFua3MsDQpLYW5jaGFuYQ0K
DQo+IA0KPiA+DQo+ID4gUmVmYWN0b3JlZCB0aGUgY29kZSBpbiB6c3dhcF9zdG9yZSgpIHRoYXQg
aGFuZGxlcyB0aGVzZSBjYXNlcywNCj4gPiB0byBjYWxsIHpzd2FwX2RlbGV0ZV9zdG9yZWRfb2Zm
c2V0cygpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5j
aGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBtbS96c3dhcC5jIHwgMzMg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAz
MCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21t
L3pzd2FwLmMgYi9tbS96c3dhcC5jDQo+ID4gaW5kZXggZmQzNWE4MWI2ZTM2Li45YmVhOTQ4ZDY1
M2UgMTAwNjQ0DQo+ID4gLS0tIGEvbW0venN3YXAuYw0KPiA+ICsrKyBiL21tL3pzd2FwLmMNCj4g
PiBAQCAtMTQzNSw4ICsxNDM1LDM3IEBAIHN0YXRpYyBib29sIHpzd2FwX3N0b3JlX2VudHJ5KHN0
cnVjdCB4YXJyYXkNCj4gKnRyZWUsDQo+ID4gICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAgfQ0K
PiA+DQo+ID4gKy8qDQo+ID4gKyAqIElmIHRoZSB6c3dhcCBzdG9yZSBmYWlscyBvciB6c3dhcCBp
cyBkaXNhYmxlZCwgd2UgbXVzdCBpbnZhbGlkYXRlIHRoZQ0KPiA+ICsgKiBwb3NzaWJseSBzdGFs
ZSBlbnRyaWVzIHdoaWNoIHdlcmUgcHJldmlvdXNseSBzdG9yZWQgYXQgdGhlIG9mZnNldHMNCj4g
PiArICogY29ycmVzcG9uZGluZyB0byBlYWNoIHBhZ2Ugb2YgdGhlIGZvbGlvLiBPdGhlcndpc2Us
IHdyaXRlYmFjayBjb3VsZA0KPiA+ICsgKiBvdmVyd3JpdGUgdGhlIG5ldyBkYXRhIGluIHRoZSBz
d2FwZmlsZS4NCj4gPiArICoNCj4gPiArICogVGhpcyBpcyBjYWxsZWQgYWZ0ZXIgdGhlIHN0b3Jl
IG9mIGFuIG9mZnNldCBpbiBhIGxhcmdlIGZvbGlvIGhhcyBmYWlsZWQuDQo+ID4gKyAqIEFsbCB6
c3dhcCBlbnRyaWVzIGluIHRoZSBmb2xpbyBtdXN0IGJlIGRlbGV0ZWQuIFRoaXMgaGVscHMgbWFr
ZSBzdXJlDQo+ID4gKyAqIHRoYXQgYSBzd2FwcGVkLW91dCBtVEhQIGlzIGVpdGhlciBlbnRpcmVs
eSBzdG9yZWQgaW4genN3YXAsIG9yIGVudGlyZWx5DQo+ID4gKyAqIG5vdCBzdG9yZWQgaW4genN3
YXAuDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMgaXMgYWxzbyBjYWxsZWQgaWYgenN3YXBfc3RvcmUo
KSBpcyBpbnZva2VkLCBidXQgenN3YXAgaXMgbm90IGVuYWJsZWQuDQo+ID4gKyAqIEFsbCBvZmZz
ZXRzIGZvciB0aGUgZm9saW8gYXJlIGRlbGV0ZWQgZnJvbSB6c3dhcCBpbiB0aGlzIGNhc2UuDQo+
ID4gKyAqLw0KPiA+ICtzdGF0aWMgdm9pZCB6c3dhcF9kZWxldGVfc3RvcmVkX29mZnNldHMoc3Ry
dWN0IHhhcnJheSAqdHJlZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcGdvZmZfdCBvZmZzZXQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGxvbmcgbnJfcGFnZXMpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCB6c3dh
cF9lbnRyeSAqZW50cnk7DQo+ID4gKyAgICAgICBsb25nIGk7DQo+ID4gKw0KPiA+ICsgICAgICAg
Zm9yIChpID0gMDsgaSA8IG5yX3BhZ2VzOyArK2kpIHsNCj4gPiArICAgICAgICAgICAgICAgZW50
cnkgPSB4YV9lcmFzZSh0cmVlLCBvZmZzZXQgKyBpKTsNCj4gPiArICAgICAgICAgICAgICAgaWYg
KGVudHJ5KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHpzd2FwX2VudHJ5X2ZyZWUoZW50
cnkpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICBib29sIHpzd2FwX3N0b3Jl
KHN0cnVjdCBmb2xpbyAqZm9saW8pDQo+ID4gIHsNCj4gPiArICAgICAgIGxvbmcgbnJfcGFnZXMg
PSBmb2xpb19ucl9wYWdlcyhmb2xpbyk7DQo+ID4gICAgICAgICBzd3BfZW50cnlfdCBzd3AgPSBm
b2xpby0+c3dhcDsNCj4gPiAgICAgICAgIHBnb2ZmX3Qgb2Zmc2V0ID0gc3dwX29mZnNldChzd3Ap
Ow0KPiA+ICAgICAgICAgc3RydWN0IHhhcnJheSAqdHJlZSA9IHN3YXBfenN3YXBfdHJlZShzd3Ap
Ow0KPiA+IEBAIC0xNTQxLDkgKzE1NzAsNyBAQCBib29sIHpzd2FwX3N0b3JlKHN0cnVjdCBmb2xp
byAqZm9saW8pDQo+ID4gICAgICAgICAgKiBwb3NzaWJseSBzdGFsZSBlbnRyeSB3aGljaCB3YXMg
cHJldmlvdXNseSBzdG9yZWQgYXQgdGhpcyBvZmZzZXQuDQo+ID4gICAgICAgICAgKiBPdGhlcndp
c2UsIHdyaXRlYmFjayBjb3VsZCBvdmVyd3JpdGUgdGhlIG5ldyBkYXRhIGluIHRoZSBzd2FwZmls
ZS4NCj4gPiAgICAgICAgICAqLw0KPiA+IC0gICAgICAgZW50cnkgPSB4YV9lcmFzZSh0cmVlLCBv
ZmZzZXQpOw0KPiA+IC0gICAgICAgaWYgKGVudHJ5KQ0KPiA+IC0gICAgICAgICAgICAgICB6c3dh
cF9lbnRyeV9mcmVlKGVudHJ5KTsNCj4gPiArICAgICAgIHpzd2FwX2RlbGV0ZV9zdG9yZWRfb2Zm
c2V0cyh0cmVlLCBvZmZzZXQsIG5yX3BhZ2VzKTsNCj4gPiAgICAgICAgIHJldHVybiBmYWxzZTsN
Cj4gPiAgfQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjI3LjANCj4gPg0K


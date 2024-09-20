Return-Path: <linux-kernel+bounces-333925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D936C97CFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098741C2263B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DA812E7F;
	Fri, 20 Sep 2024 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBruBlmy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCAB63B9
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726799564; cv=fail; b=OfKcfsFxV6/ItwITaBq7M1dShUhva2l+/U9lhZJJXEBIjn+zEgmWQfSoha39Yc25f1q89XzVA8xh+SiKm5ADfc4bUVORwmB5XQUdhP/87+USpKwqdXwQXDESU70hdWJKG9hm94ql0+vVe1AUYISxL8nrR7mkKwBCDEYsjZYnfps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726799564; c=relaxed/simple;
	bh=cmJ5lTs6vvegmJdmMBCrt2HDFc40m0Joz4vHjrig+50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qpi6X7XDx6HVCggBST0u4kDvt5iskm6ulpPltIg+Y3JrGTNnj3lXfsQSlvG+pNC1r2u9RJ2KspIjRCcGnVc12+ggtY7hcZAAr2Yrc4Cr6QsNFTldKiNhhLWGuSwp8ua61ShsmXmhwNGOxyYqtfZByN3kgjnfVgcWGyMmWx2U1Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBruBlmy; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726799563; x=1758335563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cmJ5lTs6vvegmJdmMBCrt2HDFc40m0Joz4vHjrig+50=;
  b=OBruBlmyOzszoy7AbqSG0Ziy+4vWH8qpEtv+86Cn3K4Ow4xT3xiasTgA
   0JfuTR48S0KwtkSass3NpsV4QrgPXXwBVCcFtgKseSqpHg48tjYr2bfbO
   B3DdFVm5wTIZmWO511rwxYLaBmr2d8Bs3QYpltpAcPNv2IEIa1Jv0PP5m
   N3baF2IEAtC4P8o2tHC3JGo3n1hH12TPfBXAwN1C+mQL2Cj70w+Dh2qRK
   CG5FxSgV1mOrxkry/b/LWJbkp81opATEual+J3KZozUZU6qtLckVwF2jG
   AeLQUIZajilxr+GbBrm2O0qzEkGGMRgkcbkucVKtBqDfXu9ksEWI3HaAH
   w==;
X-CSE-ConnectionGUID: m+K9PBfeSy2H/6JJ3BqQbQ==
X-CSE-MsgGUID: jRvHh2FcRYalw6p1VJZzhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13602169"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="13602169"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 19:32:42 -0700
X-CSE-ConnectionGUID: xJasYl09Sqe6YIqIOS0wtg==
X-CSE-MsgGUID: qlOlCn8hQTezKjsc9voj1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74675757"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 19:32:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:32:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 19:32:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 19:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9RULkBV1Cah7BjI+ygMWGj3UQCXteXkYhpB5UT51j1ZCr4aWllxwzEiH7GbXxUPFGmAsy5qAkaKI29O4/0M/xWdsnMAra11aX+I8RiQj2dWIoqPchWHGpBcjJcoyAZaIhx4muBbbbybDpmdYXm8Bo9zLe/2mYfbrQlWePrgIocJNvrrz+kRAlN0pbMGywraD4eTggEdoJnQPfebl3+bOPERQuekG0j859C2S1wxngAAvq/6OhIdweOxJiWkjNp0ftthjy+lzkOkY1rSXaFfIg/5yATd9yIxK0htXzeOHKdrUddYdh30c8Q/0R5iv+XOiHzH7GCjTuHYJfZYzVc7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmJ5lTs6vvegmJdmMBCrt2HDFc40m0Joz4vHjrig+50=;
 b=F35CocGzpGzsbuT4cwS75usDT+S6eN7fBK54HMXNW+cleSIxLpcNsmUQoQ6+8icOEbeG0FXNU1QIQzioJeW5ijAmSi4mKwKopbDhSntLrYPmDQeoVZUluNEFxAfA7kYw+14s0FU68uwnljV5ce3g0TWOIr6hIvN5c/SR7R3qiGfZbozr8GNWJXQ81/8tfo371uOESZkEvIoDPB5V+7E2nk22G80a9XhNL75Pt66C1RXqYKKFcOpT7+TmQPOHUYkLZ+l4HYH+vbs1vQQTRY/n5+6PYHE3YfhPUsVlhX0UIUpk+XqtUNCf50ac6THAukh2+Uc9J791HNTYBWbeUU57mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28; Fri, 20 Sep
 2024 02:32:39 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 02:32:39 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 3/3] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP zswpout stats.
Thread-Topic: [PATCH v6 3/3] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP zswpout stats.
Thread-Index: AQHa+lo+/g+JraXASEmsFJLqyAt0i7I+7/wAgCElpWA=
Date: Fri, 20 Sep 2024 02:32:39 +0000
Message-ID: <SJ0PR11MB56787D663020677A0448D906C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <20240829212705.6714-4-kanchana.p.sridhar@intel.com>
 <CAKEwX=Na1AySK6UMm41h5NkFo59c_ZBGvD-FUZb9vbQ90e-ejw@mail.gmail.com>
In-Reply-To: <CAKEwX=Na1AySK6UMm41h5NkFo59c_ZBGvD-FUZb9vbQ90e-ejw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SJ1PR11MB6129:EE_
x-ms-office365-filtering-correlation-id: 981f79d1-8390-4a20-febd-08dcd91c7f10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QnI0WFZUemFEYThoeDdRRVBSWG9oWGp6dmNYZ0ZNUGJwemRZUFFDdFVUT3lE?=
 =?utf-8?B?TlMyZ1U2ZXhQNXYvKzcxaVQzNmRVRTRsMzB0Q1U4ZHRaU3kzYy9uVXA1d0pH?=
 =?utf-8?B?bTgrUFNubmZxanUyeXdyZ3lvYkVvN3FQL2tiSmprdUNkdmxQZkQyUlpwUDB4?=
 =?utf-8?B?WUdxYitOYk82WDF3Q01vS0txUy90VTJkT3BOVGRrRmt2MXpYTmFCeUJyV2pP?=
 =?utf-8?B?RmJkZ0lacnBZQzMxaTBHYXRpZ0JobDQwQTZaRWVnYThvajVGMVk3VTRmVERl?=
 =?utf-8?B?S2J5OEl3aG9TU1QyM29UVkRjOFhZSkV6aVg3elFRMHQycGlURkVITmg5Zy9X?=
 =?utf-8?B?dGJDMWtnVytlSnZseUNHNDRmRDRCeE9ua2xuNVdQeHNLbVgvTEpFZk5weUkv?=
 =?utf-8?B?eWVEZXBlMFh0TUxZeE13eXZsTHVFOUJrWXNaSThSQldoRFF5RWM2NDQzLzdH?=
 =?utf-8?B?STM0WTFxOWUyWlpWSFVJSlBzVDZuZmE0ckJZM0RsUTQrekgrc1J5MUVTQjhZ?=
 =?utf-8?B?T2lVc1hTNTJ3SUc3RVE0ZXkrRnhWNWNuY3haaW1hOGxPYVcvU0JIdDJqcVhM?=
 =?utf-8?B?K1pNMTI0K1FtUXJFT3dXbkhlSmp0Sk0xSXluQzVHaUl1UC9lL2hmWXppclZl?=
 =?utf-8?B?Y3VqYkZqcGVVcEY2K1hRVkQ2Tm9pUE1ZUU1vanpYYXZQUlpTbm1RLzQrQ09M?=
 =?utf-8?B?ckJ4eFNqQ0VMWXRXdDY2SXk3M252eWhxWnhGdkYybE02cGFYOHBnYnNBK0xo?=
 =?utf-8?B?Q2Z2d2x2U3d1cW00VzBJVlhLWVJHaUZEb3RWOEVZdUcxbVpGV0FPc2crTldV?=
 =?utf-8?B?UkdhTjhEYTg2dkxEYXJITHpVbHlaTklwcCtOdFBtdWJGT0xYaHFnelFOR2xF?=
 =?utf-8?B?ZGRscElBS2s4YUhPN1FsY1pLbFhIQlhhWmVIVVcrRGVKYnhjV0ppTXhlRnl3?=
 =?utf-8?B?K01FOE1ja1pJSGZXbWdLdllxbWJtQ05ScjNvVnJqME5zZTRnNmVRNTB0OTFL?=
 =?utf-8?B?eDRieVh1K1hkcHpzenFqM1ZKcytyWjBUSzl6UmtLQlhneU9wQ09FUFpPQkpq?=
 =?utf-8?B?VGREWklQaWhxL3Bnc1psUHF0Ukx4UzAycmF2LzltcVVLSndTeENHaDdwMUlF?=
 =?utf-8?B?emUwOUthd1EwZlhMQ20vanNxRkZGOWdSVm91ZjlkMTJNd3NuTFVkYVVxQWxU?=
 =?utf-8?B?djFRbkcwdlNoMnpKMDhTOHNoS3RRZ0txWDhFY1NvV0tnVlh1OGkyQUg3MUZN?=
 =?utf-8?B?bTRXM0crVnk5bGdabFpLV0RqS0VFY2hvdFFKTkhYcFMwMjdCR01Tb3JPWDk5?=
 =?utf-8?B?WUs1MzRFeW1tYWJqNkVHUWREYjE5Ti9WN3ZrZVh5dUxvY3JkSlB2bC96MW40?=
 =?utf-8?B?TnM4UnNsZFNUUnJmRzdSZXYvS20wemE0NktGL2JKMTRrcEplS005S0ZDVmZ0?=
 =?utf-8?B?eUhHMEdtdWxDMjdwcEZvSW9majd1MTNXRC9UZ2VnZGI3STFNNENLUGtnL0Fn?=
 =?utf-8?B?ZkcwY3NkSFd4dGk4SmFheFRQL3BZQ3U5c1Q4TlhFaEJRNHo3UzlPTlR0MHdl?=
 =?utf-8?B?bzRhQ29Ec1pOU1ZicSt5NHRkQXI1UGJ6OGQ5NHZMMmJ1NnFZVWJ5OVpnMTRX?=
 =?utf-8?B?R0tWbXdvanQyY0Y2dEswRlZHRTdWWURHeldOOEtCck5JbGduQkMvWjh5WGI4?=
 =?utf-8?B?b2tGaUU5YytDUFp1T0h0SGFRSW5HM0w5UjltMWJZdVZHUTgrWlo0T0pTNEU2?=
 =?utf-8?B?dEtPSWg4a2MwRUVMOUVvMWo3Zjd1RmhHMFVyUEtGOUd3T2c5UG9KRkZzUlcz?=
 =?utf-8?B?Y0JLNEV0dSt2SHZwbGNMZ29vNlJGbWNkdFZrdTFURDN6Z05aeHJtZkxaUWRD?=
 =?utf-8?B?dVZ5ekNWMk9LQ21mSGtjTDZMQS91R2F3QmdNUDkvYXZRUmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VitRRy9zM0VnaDdJa21lN2V1NlBwZndZU0hTV1VjZURtKzdmWXhrY0NCbm04?=
 =?utf-8?B?NlV1OHB3b3poMjFkRkYvRmY0MUJhaHZ0WFNOd0RhMzJQTG1IaGRWYXpvNEVi?=
 =?utf-8?B?ZzBEOTZNYkJDNUdid1Y0SEdPYTZWTmh6L0RrMUlTY1VhUy9CU2pRTnI0U2hK?=
 =?utf-8?B?dFp2MTljSjlYaUFQbGFZRks2RkpnUlhyLyt6UjZUYURickNFQ3o3T3Y1NDUy?=
 =?utf-8?B?V1B6RHV6LzlRODNpRmRlVEN4Tmw1c2xiYUFJbDdsSUMzcklLWXg2SExYVnk5?=
 =?utf-8?B?SWV4ZDFVWmxVVnU1TU1DOTJGWGpIYnZPdHlSL0R6eURwYWY5ZXdpcy8yZUhs?=
 =?utf-8?B?Q1VyMmM1T1VTS3lDSG9VamVpZ1QreXVPN0t2VmNEbzB5S1ZaU2VKR1ZSSVBw?=
 =?utf-8?B?NXVubFJjdXd4aDcwSE9CSFVFWlpEbHNZLzBWWnZ3TW1KOFhBVW5TOWNDbnFh?=
 =?utf-8?B?WUV4bzhmYXk2UGp0ZXpOaWFueXdHeWQwVnVzMmFGMVJvOGFGWDlFbVdOcE0y?=
 =?utf-8?B?Vy9QcllxbC9LNW5qZEJLL1BjSHlrQ1ZHanN2YnYvb2lhRGJ4aUcxSVhHenJo?=
 =?utf-8?B?MW41dy9YQXJZODF6UlF1YlpaT3FCbkdVSVhxVU54aGI5Z3liWU5LUlNSWkhm?=
 =?utf-8?B?eXB2Z2VMZ2UvclZVZjhYUnRHcnNYaTlhUHdDYTB6TVp3ODU0SncweUp1ekFK?=
 =?utf-8?B?dW1NdFBwa1c0NmhHTHcrRFNJbHptbTNTaXBWWGlUcFFxMTFreVpMOTRGUHRO?=
 =?utf-8?B?Vm1nWmd4VjMvS1pXL1orTzl3Vm92bFFkQ2RBZHZWSWI5YjdxQkhmTVdESnRq?=
 =?utf-8?B?Z3cxRHZoSFFtWkg3dEpPbXlyN0lPbE9DN0Ntb1FNWUpkYWZYamtnYXFLZjRD?=
 =?utf-8?B?TS9nNzdRUFhjNUNEVzk0WmVXVEN3c2tGd1FKNGZHcGpMQmhZNXpsaGVsYkRS?=
 =?utf-8?B?SWowZnluQk9odkxTRDc1azdoSVM5cE5OdjRzbi9vdm5LaktxQ1N6ekVGME9n?=
 =?utf-8?B?K0V4Yk9oeElFaGg3ZTJXMkJ4dTdLK3RCMmsrZzZCSHRsREJHWisxVkhUdTI2?=
 =?utf-8?B?MlFjS3drUlVVUzhUZWU0R3hldWhBYWxYbnFNZG0vVWg4c3VCRERqVCtaWjUv?=
 =?utf-8?B?STdVOGFSazYyNlFQZlhKUFplMnh3RDJOTG13aVltRUhJblUvRCtBd0JIekw3?=
 =?utf-8?B?RW1rcXJTRDlibjJUdjRFOVhmZlNoc2pRd3J5REpabkU2VS9jUUsxK1NEM0sy?=
 =?utf-8?B?bjhtZkE0dTFNNEhQbzVCdHpydFZBbDB3SVc1c214WVNyNmNucFMrNW5YcFZk?=
 =?utf-8?B?am9WYXdQWkxQTW4zN2FJMkdTblB6MzlsMVhEeGNnYXp1TXpLeHpuK2ZMOGVs?=
 =?utf-8?B?UFNKdzNOY04vc1JDbVF1a216cU1qK0duYTdBVldEcnoxUTR4U21VNUROSnZM?=
 =?utf-8?B?T01zMWdydExNc2JpaldkZUtXMGV0V1RVLzd0Tmp3bW9XRjdVK0p0a3hrRW5u?=
 =?utf-8?B?ZHJhQzA5TE1NUXBDSzE0bmFaM293SlgzMy9pWmRONjF4K2hrNzlxM2lxVTQ5?=
 =?utf-8?B?N21VMm80Q3BzdDE2aDBGcnQ0MDl3SEZLWDFnZ0dwVkRPTDVYZVpTK1ZGcDFo?=
 =?utf-8?B?UXFOSW1DVHNRN0RZUUV1UWZLZ0VmeG0vcTladjkvd2lEUHFsN1BkYU9PRHRa?=
 =?utf-8?B?ZGxTRS85RjI0UzZTQmx5Rzg0ektDdW01Q2xFdXpXc0pXOENSTFhDRm52cDZY?=
 =?utf-8?B?YUtiWS9jYWc0aGt0VkFXdnZGUEp2ZVRSSWpSbE5BZkt6OWgxM0tJVnVkSkpL?=
 =?utf-8?B?NXN3VUVxWExWbFdmWmJrRkhSakJJdHB0cUdHYXhDV21udm5JVGUzKzJwYzk1?=
 =?utf-8?B?TWl1aWg2U0lZWGQrOEhKZlZKZzVBdlloVGhSSE02cE5aOThmaG1EVk5jUVFv?=
 =?utf-8?B?SEtrcVliMkk0V1dTRmRBdVFHWXRONERRSEkxSzZTc1Q1RjY1MDJDREtTNnBm?=
 =?utf-8?B?YWxLZXRVcTVHTmZ1UW9tOE1uZnc2UHRrd2NDSmtMNXlzUEwxK0kxdW9zb3Bz?=
 =?utf-8?B?OHMzM0MwY2dpcm5tV0l3OXVIenNJVEhMdVROdGRXL3Q4NDRCUUN4SVdzQlZr?=
 =?utf-8?B?elQraHdmWkl6N1pwLzV3bmk0M3hwSk8xUkREODJNMmdEWm1iczhKU0FhQ0E0?=
 =?utf-8?B?aEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 981f79d1-8390-4a20-febd-08dcd91c7f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 02:32:39.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4SSNizngOr8YE6LxySqWjGhzrZVJ7DW9AujLNAtLBJYmo0J5s5sUqWER38XdVzRkGC13tRLLF6J2Hvd7Ee6PbGJb0wSSZTnzrr39yAqQNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDI5LCAyMDI0IDU6MjAgUE0NCj4g
VG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+
IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOw0KPiBjaGVuZ21pbmcu
emhvdUBsaW51eC5kZXY7IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+IHJ5YW4ucm9iZXJ0c0Bh
cm0uY29tOyBIdWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+Ow0KPiAyMWNuYmFvQGdt
YWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgWm91LCBOYW5oYWkNCj4gPG5hbmhh
aS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVs
LmNvbT47DQo+IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjYgMy8zXSBtbTogc3dhcDogQ291bnQgc3VjY2Vzc2Z1bCBtVEhQIFpT
V0FQIHN0b3Jlcw0KPiBpbiBzeXNmcyBtVEhQIHpzd3BvdXQgc3RhdHMuDQo+IA0KPiBPbiBUaHUs
IEF1ZyAyOSwgMjAyNCBhdCAyOjI34oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFyDQo+IDxrYW5jaGFu
YS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBhIG5ldyBNVEhQX1NU
QVRfWlNXUE9VVCBlbnRyeSB0byB0aGUgc3lzZnMgbVRIUCBzdGF0cyBzbyB0aGF0DQo+ID4gcGVy
LW9yZGVyIG1USFAgZm9saW8gWlNXQVAgc3RvcmVzIGNhbiBiZSBhY2NvdW50ZWQuDQo+IA0KPiBD
YW4geW91IHVwZGF0ZSBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL3RyYW5zaHVnZS5yc3Q/
DQoNCkNlcnRhaW5seSwgd2lsbCBkbyBzbyENCg0KPiANCj4gMS4gTmV3IGVudHJ5IGZvciB6c3dw
b3V0Lg0KPiANCj4gMi4gUHJvYmFibHkgc2hvdWxkIGNsYXJpZnkgdGhlIHNlbWFudGljcyBvZiBz
d3BvdXQgdG9vIC0gdGhpcyBkb2VzIG5vdA0KPiBpbmNsdWRlIHpzd2FwIHJpZ2h0Pw0KDQpTdXJl
LiBBbmQgeWVzLCB0aGlzIGRvZXMgbm90IGluY2x1ZGUgenN3YXAuDQoNClRoYW5rcywNCkthbmNo
YW5hDQo=


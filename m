Return-Path: <linux-kernel+bounces-303884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA9196167C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4265E1C23672
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5082A1CE6F9;
	Tue, 27 Aug 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPLisiyd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB81CE6E8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782160; cv=fail; b=tcBnRTHjAVHOI72zfwkbefBHLmAbItxbqKM+1utQuGpg916wj4ypBzMQMjCgUm+Lk8rrLfT07D4eOkHjDYGyoDGrdV6juX6ExPp4coRl6+bHyEsx97MuxRo7bK1o4ww3kAXIsi7pjcvXTof8Y8ObUtrOaKBm0lx721C8t/ABZGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782160; c=relaxed/simple;
	bh=be6b8+lAdCSoQr9NuIYwsk5ZZVOjMLTJc2Im3ZIGLng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDuD1Apn9bVqBYgESSbmdctjpTPG0oDaLyo30l1/A6gHyLTsz8TD9ETuMK8azeAP29HK0WLGk6OcIH61qiOeeDYgFagdXdVZNMsK4RXP8JkJGrvbKXBhQOPfOmCmj+XTxxdPQ4oTz2fR8f3SXqV+dBLpu/rZ3cZjUza8W3w232I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPLisiyd; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724782158; x=1756318158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=be6b8+lAdCSoQr9NuIYwsk5ZZVOjMLTJc2Im3ZIGLng=;
  b=aPLisiydTcW8f6NSrVDdBcRcXDeBo4cjBZjIwy+xo2vnPoa180LeVGrr
   dnRoNKbyT4Yw1YJtmFZe3bxcvG1LI8PDbCvrjRc2BWT8doMclSk4thmsa
   6q9arFzWNDuJvirp6Z3HlbI9oAQZYNCHnSzG7eMh6XGfkm2g9L0RG1LuH
   Zz8+bMIqhCQZi7xRe/NuVceMG6awgvprglF2y+CX982TIPgx2gu8/nSlk
   LZdc8vejtVzHPnCXO3+KWl9G/1DjCSkd/J9wv/0xIqdLWjGsI7DMm8O7G
   kTScJxUhZJexs5Yy9fJYg8sCqtdJreFVxmDyb7qpMOLjIwQ1zTgBw2i2x
   g==;
X-CSE-ConnectionGUID: qnk0CdHETYWR1AR7BRZcVA==
X-CSE-MsgGUID: b+cDxWA7R0+4oXuOA7j2kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="40752117"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="40752117"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 11:09:18 -0700
X-CSE-ConnectionGUID: lDqalYWZTtec8OQGp0Kvbg==
X-CSE-MsgGUID: nmhPgd3CTni3CRiiuWwwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67303454"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 11:09:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 11:09:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 11:09:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 11:09:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 11:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEZokEtYF480ogXHLnLwbWCJ89rpsAy9rN36Hpj94a2HKvPihZMrkF2GjF0F7kQ8yDa8Ow3lZmZt88DrzwRpxtrYhw8GGlJxucmQQr7Nvtm7xYiTDCqOI/4yhBPt86H+YebPs7zSZUXNHOx5jIM8tym07oDbZ3dXjpX3nRlPjSuzT6a2unkAyjnmaiwX+ypbau2v3S6IYtVQUirj/iPvp48fWKJqkxk8PowSNOdjc1BzKywqo72ExnW1bZoZf6D+NH9lSJubtwOyvTykEvNC8XO/mFGBHIbGatK66WX7rH8jpb7+uOfpy+2D5OANKUGuJIBDVMInU7EQIuH7UC8rCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be6b8+lAdCSoQr9NuIYwsk5ZZVOjMLTJc2Im3ZIGLng=;
 b=XBL03h8R6cA7s+NIbe/OzDxN1buZF/Jjz01CuGGW6G1ZdeAap/H399mACMgVLqplTHjmmvh8z9rVwMEX115qNzRCtawrE3jR/YVIfYYiPuKo/yeiesXKGZ9PBabpLCFc7PimRBwrjVdn5zPo6BRF5rUnowvJxeb23JLPVD8ExEoqMAwTtLQHkG4G8B93LR4QP8BPrGpvFMh9ld9NjIvzCZ7MIwUPoS57RHSCb4hILUoV3MDA5hkEwXO/cxgd7sTsnVlNY9LKaG0QP0Phn0PAxu5G6F5beBLWnPZJ4tFEWw4JNPCTr1xbzlslnmRIszuU+YYOuMYRZkm/T0ED1Yp1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5671.namprd11.prod.outlook.com (2603:10b6:8:3c::24) by
 DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Tue, 27 Aug 2024 18:09:14 +0000
Received: from DM8PR11MB5671.namprd11.prod.outlook.com
 ([fe80::8271:3a1e:8c5c:5641]) by DM8PR11MB5671.namprd11.prod.outlook.com
 ([fe80::8271:3a1e:8c5c:5641%5]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 18:09:14 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: RE: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa8d3OD+uOh/WK5kyI6A6kVnXGhrI7PpCAgAAuphA=
Date: Tue, 27 Aug 2024 18:09:14 +0000
Message-ID: <DM8PR11MB5671C46D8F582D60A90814F0C9942@DM8PR11MB5671.namprd11.prod.outlook.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=Nw3bbm7_J3feiUbk-3n3jj9_FbKHLiBJtQc6ZTfqq2Rg@mail.gmail.com>
In-Reply-To: <CAKEwX=Nw3bbm7_J3feiUbk-3n3jj9_FbKHLiBJtQc6ZTfqq2Rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5671:EE_|DM4PR11MB6336:EE_
x-ms-office365-filtering-correlation-id: 64293395-ed43-4b30-28b1-08dcc6c35bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UkwrOCtWTThOczQxQ0diVFRLQWkzY2xtOTlrNDQrK2Q5SWpiQmE3QkFDdXFY?=
 =?utf-8?B?RmR5R0EzN29JS05ZeFRXUERBUnZkdGRaZDRFUGlxcmNMMFNYUlhqZEllZllY?=
 =?utf-8?B?M0s0Y1ZTTTlMa2QxUHZadTdFWWZZVG9wcVlWaEdGUHFjWUx4RUJla1hmaTJS?=
 =?utf-8?B?MklzNnFsZUxxQ2FheFYxVUVPVkkvV1RQS1Y3SENUSW5Vb2c4RHhOeHhOUEVZ?=
 =?utf-8?B?Yk9kNG1NS01WdWY3SjlhZmx5WlJnTFpiTTZwRGJIL3JncHZ5ZXlhMUtERGg0?=
 =?utf-8?B?RnprSGc3L0FzbkpPempYQStaYWxYTWNvOXpkUWZTZzF5N3ZmS1liWDJxbnFW?=
 =?utf-8?B?czZRb0dGWkF0ZWhwUHAwTGlSMjVKVGZlR3dBdWxsK2w0ZHo3NHVXaDZVMVQy?=
 =?utf-8?B?WUROS2Rvclc5SnZPdW5Wd2VOTGs0NFd1bUQzeUd4cmlmWEkvV1VWTmdLcVU1?=
 =?utf-8?B?TS9FcExQV0o5eU9mOFpiSU82R1BXOG5HYkQ3RndDeDd1elNXa2pZUzJyRlhh?=
 =?utf-8?B?Wml6Q05nblNmN3hJT01VU0JUaXVBWHA3VGdxWWcvRHNIRmdEVFEzQ2FNUlhz?=
 =?utf-8?B?L2V0dGFIdzh0SGdEQkMyTE9xT0tuOWR2alpUemtuc0VRSDZZNGJENGI2MkhQ?=
 =?utf-8?B?MndNUm8wMW1UWGJzM3FacEJZWExVblNDU2k1TnRJYm5neGlZbDNJdEdvQUNI?=
 =?utf-8?B?VUxZVmpzcG9meTI3RGgwWkY5VStvdW42c3MzOFBKSHlCUzhRT01qOGpjZzh5?=
 =?utf-8?B?aElhZFlDTm5wV1NUMUJWazhSWCtWeEVod0FWSVlEUjlJdVNaeGRqQXAxb1dh?=
 =?utf-8?B?YUZESUNITTJMV0pJSEs4Q1F5UUFnR2twWVIyMWQyS0tNOVJvSnZzdWZyem11?=
 =?utf-8?B?QUtOVU9WT3RmYmdlVm1GalI4cmFabVM1N3NEcFBncTU2c2FnWGl6WkF1MWcz?=
 =?utf-8?B?ZmQ5UGxWYTB2a0t6aG5OMVpsNTBIcHJydVJvcmZlbVJNMXQrOGlXRnp2Lzdx?=
 =?utf-8?B?cEY0aWxRVmtHL1BOMVdheFhPOFBDME15NXMrVXRkaE9GMUFtVHd4YXJ4NXdx?=
 =?utf-8?B?aDVkeFA4ZkZJTmNWWmkzNDZwdlhSb3A0K05tY0tSSjBUd1pOZ1ZETkZxM0J5?=
 =?utf-8?B?NVRtTVZIMUx6aW5KRm5zbjhhZUY0YTEyelY4SnMxSElreTZzSGlDQlZSb3My?=
 =?utf-8?B?Q3VxOTZaT05iSnMzRTBwOTY1V1kyc2JLMTJXaFBwbHhjaGl4T0cyUGJtQlNE?=
 =?utf-8?B?SVlpOXJZNExseWhiY0o4YmNwVFZOeXNTUlk5M3dMUFRUNE04WHhreDM1UkJS?=
 =?utf-8?B?elJWUkVFVFkxSEFiaTY5ZlI0UzVzNThOZVdxQVRmRjFIRFRyajllNkVQbGIv?=
 =?utf-8?B?eGdYOHZ3MHQ3M3luNy9LaDZoaXA3N0RENXNjUFE1NVQ5SkZaSjBtOGZIbk1h?=
 =?utf-8?B?ckw2Yjg2dWx5ZEtzTVZwc0ZyOVlnTGFXdGs0YmlGRGRuMWRQS0tnRUprQVJw?=
 =?utf-8?B?cEVpeWI4U0dNbWk5S3ZlVGVCRTIyZmVkTFUzb254TENheGpkdlBhY2FTeTh4?=
 =?utf-8?B?cWxOOHlPWWZtcGZMYWh3U2E4Y05MZUhtYnVCWG9yR2RZTWg0L2tCbzhBbzVF?=
 =?utf-8?B?b3hMcXNWZkNzeE5mS0JtR0JWdEs3MG10K0szalB2dzhlellOWUpDMVQrbmdJ?=
 =?utf-8?B?VFROU2p5Um1EeWM0bi9qZkt1RXNoWHR4cWJoamtvNktiZTNKQlNHQ29KUmwv?=
 =?utf-8?B?VjlDT1Bia3d6Z3Z0bjBYVGVkVGlpa1N0QmpJOFpkc2cvM3NXNlpkd2F3U2d1?=
 =?utf-8?B?SkdhM1lyYXRkRDhCU2oza1NITVRLNWFBTkt4NGU1SGxGYjdhR0NDOE5MaENE?=
 =?utf-8?B?MVg1YzAzc1A2eXZFOGhUbjBKeVFCaU43VjUyMXJXWVQzTEtVeGU4bysyeG1M?=
 =?utf-8?Q?X3MQJu5Ug4g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sno5R0JzRGtQWDByQjJtNjlnME5FWEFuWWxjNXpaZHhFaEF2RHExNHBQUDB0?=
 =?utf-8?B?QWZ0eURsbG1zVmpoVEtSa0UwM013WVdmbkNzaERXYzdyd2ZxM2tsU2pLRlFU?=
 =?utf-8?B?SmRYTzJaS3o2dVVCMGppcG4vWU12bUxCNjRwUVhsbW9NQ1N1MmQ5dm9xS1My?=
 =?utf-8?B?SHFmSjJEdE1tcENHdlh0ZHU4Y0pDWk1xTVg1QlBzb1Bzc2w1TTdHTGsva2o2?=
 =?utf-8?B?TVU1eUVueFVTcjVzYS8raVlQMXZ4SFNoOGR1NWQvbzJtbWVJU2ozM05BbFdr?=
 =?utf-8?B?NEVjbzNPcmhzNENSUjk1ZW55dUVKYThBQklZcU02SHVaNFNXYTFMb3pYeHBn?=
 =?utf-8?B?c2hoQU9CWjdTNEJiWlAzbml3cnRDZmdMNGZUTFFZSU1CUjRrclVTMzF0WDg1?=
 =?utf-8?B?OHpHcDMyaEpEVUZxNnpqRkVpWGVKVDA0T0k3MGdGWElmY3BSRUdOb2J0T2ZI?=
 =?utf-8?B?RGV3VmlYUnBUN0lhMUlaNnl0WmFjOUpkdWxDbFRhcEhZdHVUSk5qSjRTcUU1?=
 =?utf-8?B?azl1TzZNbFdqa2RGbnJRWURxTmNtTWxiS1N4UTk2Y1NBWWRMT0ZhbENpbmli?=
 =?utf-8?B?NlNTMk5ZWlU0TEZHak1KeFYvZXY1a1ZRVGJDRmJ6WjVKb2ozVm4yRlZGTVo5?=
 =?utf-8?B?eVUxSGk3MlVZOVc4YVNwYnBUbFBaVlF2ZElQK2xQY2x6aklvSkhyajR0cXdO?=
 =?utf-8?B?NHJCVkw1a0t0alRMb21DRzczZW5HbFQ1Z1RsbHlNZzR0eThIUzhuVHlvd1Fz?=
 =?utf-8?B?NlZtY09uMUg1a2NvdjJ4NVpNenRsWk9zbWp0akNqWG1LcnBwbjQ3QTlJM3ds?=
 =?utf-8?B?TWUwTkc5ZW1vaTY5UWpQYUdsR2tiNDc4QmQ2Y1AydUVRY0Z5Q2JKOHRVQ0xQ?=
 =?utf-8?B?bWZSdytiWVFaNSs5S3dBV1pjMU5oenNpSDVIWVl0TFJYbmpQc1dVeU1KN0Vy?=
 =?utf-8?B?U1ZJaytHM3ljdHV2R0dacUdHZkVROUtEK2JzSm9HTzMwWGMrbTF6L05QUlAw?=
 =?utf-8?B?T2JnMDhWaFhzRFZLL2VVRVdMZk9tRk1ZUGZ4NXJsaStXOFFwcGVueHBMWjVq?=
 =?utf-8?B?Z2JSd1huQzY1SjlyL25DdUlXajBLaTViRlp3RFVDWURGbHA4eEhuRE5XaVNN?=
 =?utf-8?B?WWFrcWhObkZoUFp4SHNRL2JqdS93MTEvc0FBUVlEUEZxZUJjUHZZNjBTaklk?=
 =?utf-8?B?WFhVK01wWHVLS2pGdWlIamRTaVdVV1NmY1F4L1JSdXFGVEQyekdCWlkvUFFa?=
 =?utf-8?B?ellCSnduWnZLVWtwOGpaWS9MVUJiRlhEL2hpQ3NscUZneGJocTgxNFlGMklX?=
 =?utf-8?B?YkVJQjdacVN6VlVUSnB6eGZJZE9ia3lYNzZteEpuaXlPcldvOFE4SCsrb1pW?=
 =?utf-8?B?QjhUQkthbi93UUI3T0FEQW5hSDBPb25SQ1FQMXZhN29QRE42RTJLNmNvOWxp?=
 =?utf-8?B?ejV3NnBMdzN2czJCVDRtOFVhSkZTMEd1QW1MdHh3MTBvMFZsOThreGh0VlZD?=
 =?utf-8?B?T1ArQ09qdlp6bGVubTV0a2p5WllaT1Y3aDRiQWtpZm9EV2hFRW5jMS81dlNE?=
 =?utf-8?B?cXdhaTlPNnFYak9IaWJiS1dQa0x2TFRKU0xMYWRaVVEwcDhLbE82RlNZZU45?=
 =?utf-8?B?ekpsd05YNFhuOWZQaGprNmVQUE1XOWZiSTZ1YWpSM2NBTXdJN01FL1ZhVFNx?=
 =?utf-8?B?YTd3Zy9vRXhyM3haRGxlVy83dUtOK05CYzlrTG1URzJDUzloZ0RxUStTZkJU?=
 =?utf-8?B?cVQ4endqREduc25YRmpuVDN4NlJoTkttKy90SWc5dVJNUVJQM1Y2VHVYOWgy?=
 =?utf-8?B?SU05bGU0Q2MzNURSdzR6WXR1V0NQcVNlcm5paStoc0JwZjRJb3NZQmtDUHB3?=
 =?utf-8?B?K3d6Rk5SYlFRWDJMK0FFaEtBTFNkQVlnRVloL1ZSWi9IVDFld2pVWmRMVllr?=
 =?utf-8?B?aWpiUnZiMjFlby8wM2hhcnBRR1EzRFVTZEJPVzhwVVFJQXd0NXMxdHd3WUZB?=
 =?utf-8?B?akFLYmlTakNLemkvNzlZdGlvdGZSaWppanZkWmdvL2l4RVVnekxSZWZweXVO?=
 =?utf-8?B?SHY2L1pLeDVIR2JOV1BtNm5mL2lRRExjeUgrUjhZbXRuMnhQdmVUUCtDWGdQ?=
 =?utf-8?B?UXFsbndady9TSTN6M0RmUzlRbVY3dlM5T05YL3hOTzZqZ2pKeGYwRndEdUJy?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64293395-ed43-4b30-28b1-08dcc6c35bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 18:09:14.1522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdz9UsfBpWTeI11taBoDJko/y/LPOLrnbsXfdVjVLTHOQd6x4PaAyhzvW+O3RekUw32Mc7LGojk8Z29jPyvQpc/nPuNfTkJCKwbAdOTC9HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
X-OriginatorOrg: intel.com

SGkgTmhhdCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBo
YW0gPG5waGFtY3NAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjcsIDIwMjQg
Nzo1NSBBTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGlu
dGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2
YWNrLm9yZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyB5b3NyeWFobWVkQGdvb2dsZS5jb207IHJ5
YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiBIdWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+
OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc7IFpvdSwg
TmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRp
LmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNF0gbW06IFpTV0FQIHN3YXAtb3V0IG9m
IG1USFAgZm9saW9zDQo+IA0KPiBPbiBTdW4sIEF1ZyAxOCwgMjAyNCBhdCA3OjE24oCvUE0gS2Fu
Y2hhbmEgUCBTcmlkaGFyDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEhpIEFsbCwNCj4gPg0KPiA+IGJhc2UtY29tbWl0OiA4YzBiNGY3YjY1ZmQxY2E3
YWYwMTI2N2Y0OTFlODE1YTQwZDc3NDQ0DQo+ID4gLS0NCj4gPiAyLjI3LjANCj4gPg0KPiANCj4g
QlRXLCB3aGVyZSBkb2VzIHRoaXMgY29tbWl0IGNvbWUgZnJvbT8gSSBhc3N1bWUgdGhpcyBpcyBw
b3N0LW1USFANCj4gc3dhcG91dCAtIGRvZXMgaXQgaGF2ZSBtVEhQIHN3YXBpbj8gQ2hyaXMgTGkn
cyBwYXRjaCBzZXJpZXMgdG8gaW1wcm92ZQ0KPiBzd2FwIHNsb3QgYWxsb2NhdGlvbj8NCj4gDQo+
IENhbid0IHNlZW0gdG8gZmluZCBpdCB3aGVuIEkgZmV0Y2ggbW0tdW5zdGFibGUgZm9yIHNvbWUg
cmVhc29uIGhtbW1tbS4NCg0KVGhpcyB3YXMgdGhlIGxhdGVzdCBtbS11bnN0YWJsZSBhcyBvZiA4
LzE4LzIwMjQ6DQoNCmNvbW1pdCA4YzBiNGY3YjY1ZmQxY2E3YWYwMTI2N2Y0OTFlODE1YTQwZDc3
NDQ0DQpBdXRob3I6IFpoYW95YW5nIEh1YW5nIDx6aGFveWFuZy5odWFuZ0B1bmlzb2MuY29tPg0K
RGF0ZTogICBUaHUgTWF5IDExIDEzOjIyOjMwIDIwMjMgKzA4MDANCg0KICAgIG1tOiBvcHRpbWl6
YXRpb24gb24gcGFnZSBhbGxvY2F0aW9uIHdoZW4gQ01BIGVuYWJsZWQNCg0KTGV0IG1lIHJlYmFz
ZSB0byB0aGUgbGF0ZXN0IG1tLXVuc3RhYmxlIGFuZCBzZW5kIG91dCBhbiB1cGRhdGVkIHBhdGNo
c2V0Lg0KDQptbS11bnN0YWJsZSBhcyBvZiA4LzI3LzIwMjQ6DQoNCi0gSGFzIHNvbWUgb2YgQ2hy
aXMgTGkncyBwYXRjaGVzIHRvIGltcHJvdmUgc3dhcCBzbG90IGFsbG9jYXRpb246DQoNCmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tbS9wYXRjaC8yMDI0MDczMC1z
d2FwLWFsbG9jYXRvci12NS0zLWNiOWMxNDhiOTI5N0BrZXJuZWwub3JnLw0KaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1tL3BhdGNoLzIwMjQwNzMwLXN3YXAtYWxs
b2NhdG9yLXY1LTItY2I5YzE0OGI5Mjk3QGtlcm5lbC5vcmcvDQpodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3Byb2plY3QvbGludXgtbW0vcGF0Y2gvMjAyNDA3MzAtc3dhcC1hbGxvY2F0b3It
djUtMS1jYjljMTQ4YjkyOTdAa2VybmVsLm9yZy8NCg0KLSBEb2VzIG5vdCB5ZXQgaGF2ZSBtVEhQ
IHN3YXBpbiBhcyBmYXIgYXMgSSBjYW4gdGVsbC4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg==


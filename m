Return-Path: <linux-kernel+bounces-299920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEDA95DC37
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 08:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B0B1F2381B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 06:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB3150997;
	Sat, 24 Aug 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7UDCL93"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A12F29
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724480661; cv=fail; b=hOfvrB3KfL/61HYmVfN8+bcfcfj4b/ytSFV2pR13JZj/vP4bCoaK33ve+ENWxmcMrm8OhYhv8zflg0/U+hw5W1vyfIKlB55LuehLkaiko4ac467y5I87l8ntqG5myxj6fHMWum+arFZb8tWND6Y3v/ZHDkzpMc7wz2eiDzaWlWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724480661; c=relaxed/simple;
	bh=18vIfELP7Tep8G+0oM5FBIyzpsdhPu+4A7SR3mwUkCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cZPBkqYCCYZa4tvWYqT1q7tY7QtqOqoP81ZH8Fqpk6njm9WyzjDKBB0OVcukbDeIJecW/DP9pm+QKuw2oHNwtDmO4WQznrPB76ToPu/4Z6zgE4IN9ualpEmOHcGBfDve7TSGA/jwCjIE8oqEKZNdDjPGaROyaziRxyHeAmYm2CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7UDCL93; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724480659; x=1756016659;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=18vIfELP7Tep8G+0oM5FBIyzpsdhPu+4A7SR3mwUkCc=;
  b=D7UDCL93JAW+NUwVwSdVQGMzaA/p/tARtYlu5IrmUVlQ1J0L7dJF0Hti
   /l5L+hsmAOjClbmmpgCiSHr+Kitcaf4GEYl73g0jXVM7e/YBcCh0daMcS
   ujY4OxTLv1a/O3NnmgMu2vXgV+RpzagcoOrz5ZJ1IjwBOMHxzbprnIC2i
   5ACxvaEeOUt79nOCbjQWN9AVhUTLB1/cneJGAh7TW1L9SfHzDB8bhqcZv
   HK30o0m4HvuKtazM600bOJPCJeC6QQodk+JRhnbMbmNzEbEg5F/LhRv3k
   HrYUJXhtQZ0ZXreWGKuvLulkKSOK883j+vwUIz+QdXNB6jBKQNgKhwfw/
   g==;
X-CSE-ConnectionGUID: LxPZUX7/QHWRAC6MfD2pkA==
X-CSE-MsgGUID: Jem42TGQSrOXzIp2JblU2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22560479"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="22560479"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 23:24:18 -0700
X-CSE-ConnectionGUID: QuEkSCFCQzmoeWFGWiXVng==
X-CSE-MsgGUID: D1JpsjZ0Qd2vu7EprWZYcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99518118"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 23:24:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 23:24:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 23:24:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 23:24:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 23:24:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNVR1jjdQvbFK+dp/58IZVX/KIzw3SsJ33qdOXE+J9Kce88oSh3d++/P5/AcG82aDvuktK1M/6AMdrRLfxwcaAlM70YKBCKFZMNagEhJiZrJodzdgXlSQG4tzvAhbKOfKF3TVJin1Rd+yKhE7fZ2hfnBA3EKzAkqqTa4qr5LDvU0j6T6vIvfMdgjtGKKljnGB6KEhyoEVEj4LR361HqHofmN945+GTsQbx0fN3UijmHEWJwmAg2ZMwnQqPdv1aoip1lLgS1qBjYcosipjhMOsiHpm8f9TnFyZc2ez3Yncxkgm1/uqwOIwZvF4FCR3cl7N0WOn6uRqth04Qr0N3MDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18vIfELP7Tep8G+0oM5FBIyzpsdhPu+4A7SR3mwUkCc=;
 b=WodEuvZ5FrwYzKQ+soNW49pLiCHVfxrfjk5ij9zjwiZP/CubpqQ7++3w1bmAHHNnjwdDi32fjhDmLAwHQgHOMQz/kHtRawS9LxJhxZttjxSJLrNx/bw+nwDRjutsFlipqc2xPjpdloEAbZjZfEQbOwrloIxeTNeroX7gzNLsuKhHvF6EQw7iMqJ+gOBth6a47Qa+IBFWUAIDTY58UzeSemZxIog8RszEbx+1KyHXSNmZWslHONDkhVXjSjMPBI5PQZuKnpAz2907V4MDkbmPwD1LrHsuO3TGYpwXh4FTg6hh7BQsIPDgMVdt8ITTIoOJkYNuAelgVc+dQMcl884Ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by LV8PR11MB8511.namprd11.prod.outlook.com (2603:10b6:408:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sat, 24 Aug
 2024 06:24:15 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Sat, 24 Aug 2024
 06:24:14 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang,
 Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa8d3OD+uOh/WK5kyI6A6kVnXGhrIxzReAgAP1QQCAADPskA==
Date: Sat, 24 Aug 2024 06:24:14 +0000
Message-ID: <SJ0PR11MB567847468457F7B094AF3AE5C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
 <CAJD7tka1KcL7O+=YanStLz9VnsJtoKkB0d5SDyFUrezno0Z2Sg@mail.gmail.com>
In-Reply-To: <CAJD7tka1KcL7O+=YanStLz9VnsJtoKkB0d5SDyFUrezno0Z2Sg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|LV8PR11MB8511:EE_
x-ms-office365-filtering-correlation-id: 46883123-31de-4324-0129-08dcc405604f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVE5UmFQaEtMOVdTdm4wY2luZ2o4UXdPcG1SenJRQjZISVVwbDVYTDNXVkJx?=
 =?utf-8?B?KzdsdFdYU0UrN1NTdU9uWmpTb01MbUNiK0UxaEhGYnMyU2xJWnNORnhtT2ZR?=
 =?utf-8?B?a1dtWUxxTlhSZTRkWHdJR0VIdTc3bHJyOENUbUNDTGZzNkwyRHlQdFRDazUv?=
 =?utf-8?B?R1p1YW9IV21nWWcyTGpOSlVpS21zZUkwdHlBb3FPUXpXVWJDNy9nbzBKVDBE?=
 =?utf-8?B?RHBKV1hBdzFOS0g1cDl2ZjNpb0l0MitxdTdPT1lTYTBjeWFtMndGMGhZWndk?=
 =?utf-8?B?VVlmeEM3VHQwUk40ZXpjdmtMay9NZElqQlprbFQxVTJlVTVMSHl1V3IxSEh5?=
 =?utf-8?B?RzVjcmNQaHhDemIzR05nK2tqdFlqbS9NYXE0Ri9NY3N6bEd0amZkaW5kQmt0?=
 =?utf-8?B?YUUrNWtRdGN5RTV4d2hVRE8wWkpRRWdBV2pmcjR0N0R2SmFwY090bmRaQkZv?=
 =?utf-8?B?M0pxMXRXUnRIWVA2cGkrZU51eGNTeEdLT3MvaVpaaVZQTXBadlFvNCtsQUdC?=
 =?utf-8?B?L2JZOUl4R3JjY0tIUUJQalJXdCtwbUdETmw5Tmlua2RsaWFYdEhKQW1WOEha?=
 =?utf-8?B?cEFzN210eG45Nll6MkdWK21lc2d0b216Nm1hdnNzN1BoWW1BTUs2Tm5rS0l2?=
 =?utf-8?B?ZnMwb0RVRE5UMjl5UFM3RG9DYnplcnVjQWxjVHdHSCtUa2ZQRjRlOE92VTF3?=
 =?utf-8?B?UkNETzVJbDNEb3dMT2RJUXZTNUpNTkM0MGNGdG5ibS9MWTN1K3VsaFIxb3ZQ?=
 =?utf-8?B?c1lFdjF2OGRWVzd3alBGNUJCVTR1cjdSL3N6cEZQeEF2TmErOG0rQzByYUZE?=
 =?utf-8?B?aEZRVy9heHlLanQ2aUpiOEpYTFd1WUZyY3l3MXROT2pha3VuMVNhdnJaWGdM?=
 =?utf-8?B?QWlXcHAvNytOUWF5aEsyRG9BZmhnZG9NUjNQdWlPWkp6UXQza0NSbDlHRXNq?=
 =?utf-8?B?eWkvQng3RnRDWU42L0JZRjkrSU16THdBWEZ5a3lvcloybExJZXl5RXF5cGZQ?=
 =?utf-8?B?Y3NSaEVTQzlHaWd0M2hKL3lqNDA4L0JBNW1jUE9NclNOL2VzYWY4Y2V3elM0?=
 =?utf-8?B?RStOdGNQU3NBdEluelAvcFBzU3gwTTVReDdMbjVId3FvRUtQRjVId3hnbUZ4?=
 =?utf-8?B?TytPVjhQV29RaUhlTFFiZjh2ci8vcWlUazVvQlRMMlFxRmdCbjlSRjFDQVpJ?=
 =?utf-8?B?L2VTWlVBZmt0SjZRQlhPcXhyTTFJZHFVTGxabHVwdUhSNTBrYzhrdmliVERU?=
 =?utf-8?B?Smt5RVFPZDhwdnpod3R2dUtWNHU3SWVTK0FubHhiRmVUSEE2NHBDd2dEMDdw?=
 =?utf-8?B?blYwYmZyWkFaZ0dwcnN4NmV6RVpRd0ZycjFXck5aU2ptUFNNUE9zWklKbkds?=
 =?utf-8?B?V3lhRkE3aUpOQTlWbUVlUkxRWVBGSWFHYUowb2dXdUhWbEpYTXFydWwzMlVt?=
 =?utf-8?B?bVBUVnhUUGdyem9Ra0ppTVhNVWdnaitWME5iVVNtYUlpRGVFcEpDL2xLVFZ4?=
 =?utf-8?B?SFZxcFh4NTRxR282YXJiZFNSYmZWVlduZnozSFRIdkpFcEpPcWVYY0xJU2Nq?=
 =?utf-8?B?Q2s5RUR5UTZySGdGaXR1ODBqeXNMWjJCS0FQTklGL0dPaVZOeHVUbHZLUkxK?=
 =?utf-8?B?WU51aDVSYjBQYUZBbmdSLzZSMW9uNjZJMjgrYWl1cHVjcHdsVUEzT1BWYjBn?=
 =?utf-8?B?enVwTGgxZXFmakg4by9DT0kyWnVuVDJ2WXB2d3pBK3Z0UkJLNmhieTFqOGlj?=
 =?utf-8?B?ZkRPaThGWDF0UDVDOGRqZ04xZllMYTlPK0xOaHVJM1JTWXlHaWM4S082S1Fz?=
 =?utf-8?B?Q3BSczVlb0xCNjdLMzVmdE96VTlBWUtsVzZvVFp5WXF4L1luMml0MUtZWmlw?=
 =?utf-8?B?Z1VXdk1SeTVIV0gxc3NiSDRZd1JCWTMyK1JxZ1U2Sk9TNFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE1OcCtlZTVHTXlJT1dNUUg3UFk0WnpWTS9Kbms4SzNVUGhzME9hRHdmRVh3?=
 =?utf-8?B?NklSWnBTZFNsaHJhdXZQaTVVN2VjUDJSUlpQS0dxbUNweWlJU05raFoxaFpW?=
 =?utf-8?B?cHVPMVU5Q1JtVTRWalMyTHJUeWZuTmxjUk1qVW9UKzllNmpNV2pvMFZ2K0hj?=
 =?utf-8?B?bmtOQ0FKOTJSRldFc3VkUW02alM4ZWVZNjJSSStJNU1xTnVsWWZLNE5maXFq?=
 =?utf-8?B?ZjdIc0VBS2JMVFFWR1hkR2VCalZreC9IWlNBVkNyeFRibzk1WExXQURFVEJU?=
 =?utf-8?B?dVFhOEg3YTVkQkIyMlRKVHNCaGRSOHB6akRPZ09SWEN1aGkyOWR1c21IMEhl?=
 =?utf-8?B?WjBaR0kydnpNYnhUY2NBam1FeGFueXJjbXJYbklncU14dXRHVWN4aUdKMEx3?=
 =?utf-8?B?YWFGTDF2ZHpYNWh3blpmVklmWVNwS1NDa3EzVHE1RFRGQnhpV1lpV3ZsaXdG?=
 =?utf-8?B?Q045czBTSXFzWmExSUIzRlFYMWQyTHRoTVFUYWUrQ2dteWd2UjlQQnRWRWRR?=
 =?utf-8?B?RjVsUUp5NXNPS1FyeXgxUGJwMkFpQ3V0VlhhOTJMc2F6STZwbEJzQlNkVVNT?=
 =?utf-8?B?RU9VcUJMQ3Y2RXdiNU5nRTdrUjhKR0w0SVJ6UEFvNmF1ckZ5aWJVcVd6c2tn?=
 =?utf-8?B?WGRvaTE2YWRJZ3JNNDN3bFZEY1BRZ1FFdzNGZWxKZUNBdnFXQ0xjeElYWk5y?=
 =?utf-8?B?WDh1WFg1aGVWVEhLS3RQSDZtL2YxOUp2OENLQVBEZFJJOTRzVldKOERrclAv?=
 =?utf-8?B?cDJ5dzVCMGZrWWZuQkNkbE9xb09sUVRRL0tSVHhhWEdEWDVOZzc3UW5reU1W?=
 =?utf-8?B?RjNTNmZEeVlTZkNSN29lK0kwcll4bXVQK1ppWDBaaFJyN3Z5L2M0aXB6SUhl?=
 =?utf-8?B?Wm1nenY1UEo5d1paNVMvdkEyS2FjZWZlWXoyY09OLzdDQVNYT2RYYXdwa2tL?=
 =?utf-8?B?VVI0azVFWTZwU1M4V3VEWHdlREtqVXdVOUdKZTV4d01xbFA0NGNMMnUzd1NL?=
 =?utf-8?B?cGtuQTAzdTYrd3BhbVh5RG9XU2RDdCtFVnd1Z2drRDlWTEdQc3RRR2VDbmcx?=
 =?utf-8?B?U0pwa3hMdWh3ZW55WFRKQW9EeUZ2MmpoQXd6Y2QyNGFJVkdPbzQ5OU1McjZ5?=
 =?utf-8?B?ZGFiejB3RHVRNHVobXNCVDdUQzF4TEhHYnFqMURwS3l5TDZROUlaNTZXbEQv?=
 =?utf-8?B?WXZmbFVra1VNWW1uOXNJcTJtKzI3TFdzeEtMNHVaQmtYdmpRUVNJWWcwVjNx?=
 =?utf-8?B?d1gyZkFUZXVCOXFsUWtxa1JZa3dQanRxRmhtbzBNRTlQdmhocFhsZFVBbDdJ?=
 =?utf-8?B?K1ViNGgvZk5oNWFGYnZsU25Obmd3dHpPVCszcWMvQlB5cEpVSVBNSVUweTIv?=
 =?utf-8?B?YTJKcDNHVm5yUVFrMWpDWVl2OWVZTU05ZktjUDdoN2dVb1JRS2lhSW5sY3lj?=
 =?utf-8?B?c0doVk9tSFVDL1lmd3h2bFR4OVhzYnRuRm1ZVXFpMWhONnVoMExQZHNud2xp?=
 =?utf-8?B?bjNubjd1RjFnYmhvNExJODk2UUkxRGhzdUVTL1ZCZGdZT2Q2eWpwRVdzTGl3?=
 =?utf-8?B?Y0x5RXdoYkQ2M3lOQWJKMVJPdjNLVGkwWUErWTQ3SWtxci9LckxhZm1XR2xv?=
 =?utf-8?B?YStlNDdqVUcrdGlJR1ZXU2dKSXZmbVU5eGVWK1R1eHRCT1VaZHpicmF5TVdL?=
 =?utf-8?B?T2g1NlN1Rkx3T21JYWF4akR3VFN1UWloZ1FSR3ZlRmwxNmtPNkp1bEhZTWtH?=
 =?utf-8?B?R2dwcE85QVV1SW8rTW5GWWtqNHZQYWlaNDdteXRYNDZDVHlHc2l6NGhRd3pX?=
 =?utf-8?B?TDgrbGpMZzlLS2xMb1YwYzkvaExnc2RzdDdPTkNQR3k1c2VZdlNTUU5qVFlT?=
 =?utf-8?B?WklpMXZwWngzS3dTb2Jndkd5ajhRVlppR05BZU5iZDRTTUQ1c2ZtWHVHLzNP?=
 =?utf-8?B?Mll1S3EyVStSK1d5N016V3ZFeDAvQkNDZjhtQ0VkdVZUS3JWSThKTUNEZitW?=
 =?utf-8?B?L1dKU1dqaXVYM1JUZUluUmFJbHJpNTRDVU03TG9yRTdVaWJSdm16ZDFBSXk1?=
 =?utf-8?B?YlJ5WEdzQjNFNmlyZnZmNW1RU2RacDRsaXplL2pUVE0vUGZQRjhIUUlTUysw?=
 =?utf-8?B?dEhmRnZJZlFvd00wdXBaYjBRbFNmZXVEbFhmWHhqNVMvYXg4em1zOGJROEZw?=
 =?utf-8?B?TUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46883123-31de-4324-0129-08dcc405604f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2024 06:24:14.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vuh8ThlzVKgPdNqjpupB31svK05yWTuWdGJb3E3r9tP8BPQsbd8N9xhsYb+oKekb3sj1tQ4MzjH//wdKmAxD/nhGIabZ1NRt/8K5z/9mmbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8511
X-OriginatorOrg: intel.com

SGkgWW9zcnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWW9zcnkg
QWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjMs
IDIwMjQgODoxMCBQTQ0KPiBUbzogTmhhdCBQaGFtIDxucGhhbWNzQGdtYWlsLmNvbT4NCj4gQ2M6
IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBoYW5uZXNA
Y21weGNoZy5vcmc7DQo+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZyA8eWluZy5o
dWFuZ0BpbnRlbC5jb20+Ow0KPiAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0
aW9uLm9yZzsgWm91LCBOYW5oYWkNCj4gPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwg
V2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47DQo+IEdvcGFsLCBWaW5vZGggPHZp
bm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC80XSBtbTog
WlNXQVAgc3dhcC1vdXQgb2YgbVRIUCBmb2xpb3MNCj4gDQo+IFsuLl0NCj4gPg0KPiA+IEknbSBu
b3QgdHJ5aW5nIHRvIGRlbGF5IHRoaXMgcGF0Y2ggLSBJIGZ1bGx5IGJlbGlldmUgaW4gc3VwcG9y
dGluZw0KPiA+IHpzd2FwIGZvciBsYXJnZXIgcGFnZXMgKGJvdGggbVRIUCBhbmQgVEhQIC0gd2hh
dGV2ZXIgdGhlIG1lbW9yeQ0KPiA+IHJlY2xhaW0gc3Vic3lzdGVtIHRocm93cyBhdCB1cykuDQo+
ID4NCj4gPiBCdXQgd2UgbmVlZCB0byBnZXQgdG8gdGhlIGJvdHRvbSBvZiB0aGlzIDopIFRoZXNl
IGFyZSB2ZXJ5IHN1c3BpY2lvdXMNCj4gPiBhbmQgY29uY2VybmluZyBkYXRhLiBJZiB0aGlzIGlz
IHNvbWV0aGluZyB1cmdlbnQsIEkgY2FuIGxpdmUgd2l0aCBhDQo+ID4gZ2F0ZSB0byBlbmFibGUv
ZGlzYWJsZSB0aGlzLCBidXQgSSdkIG11Y2ggcHJlZmVyIHdlIHVuZGVyc3RhbmQgd2hhdCdzDQo+
ID4gZ29pbmcgb24gaGVyZS4NCj4gDQo+IEFncmVlZC4gSSBkb24ndCB0aGluayBtZXJnaW5nIHRo
aXMgc3VwcG9ydCBpcyB1cmdlbnQsIHNvIEkgdGhpbmsgd2UNCj4gc2hvdWxkIGJldHRlciB1bmRl
cnN0YW5kIHdoYXQgaXMgaGFwcGVuaW5nIGhlcmUuIElmIHRoZXJlIGlzIGEgcHJvYmxlbQ0KPiB3
aXRoIGhvdyB3ZSBjaGFyZ2UgY29tcHJlc3NlZCBtZW1vcnkgdG9kYXkgKHRlbXBvcmFyeSBkb3Vi
bGUgY2hhcmdlcyksDQo+IHdlIG5lZWQgdG8gc29ydCB0aGlzIG91dCBiZWZvcmUgdGhlIHRoZSBt
VEhQIHN1cHBvcnQsIGFzIGl0IHdpbGwgb25seQ0KPiBtYWtlIHRoaW5ncyB3b3JzZS4NCj4gDQo+
IEkgaGF2ZSB0byBhZG1pdCBJIGRpZG4ndCB0YWtlIGEgZGVlcCBsb29rIGF0IHRoZSBkaXNjdXNz
aW9uIGFuZCBkYXRhLA0KPiBzbyB0aGVyZSBtYXkgYmUgb3RoZXIgcHJvYmxlbXMgdGhhdCBJIGRp
ZG4ndCBub3RpY2UuIEl0IHNlZW1zIHRvIG1lDQo+IGxpa2UgS2FuY2hhbmEgaXMgZG9pbmcgbW9y
ZSBkZWJ1Z2dpbmcgdG8gdW5kZXJzdGFuZCB3aGF0IGlzIGhhcHBlbmluZywNCj4gc28gdGhhdCdz
IGdyZWF0IQ0KDQpUaGlzIHNvdW5kcyBnb29kLiBJIGp1c3Qgc2hhcmVkIHRoZSBkYXRhIGFuZCBt
eSBsZWFybmluZ3MgZnJvbSBzb21lDQpkZWJ1Z2dpbmcgZXhwZXJpbWVudHMuIEkgd291bGQgYXBw
cmVjaWF0ZSBpdCBpZiB5b3UgY2FuIHJldmlldyB0aGlzIGFuZA0Kc3VnZ2VzdCBuZXh0IHN0ZXBz
Lg0KDQo+IA0KPiBBcyBmb3IgdGhlIHBhdGNoZXMsIHdlIHNob3VsZCBzb3J0IG91dCB0aGUgaW1w
YWN0IG9uIGEgaGlnaGVyIGxldmVsDQo+IGJlZm9yZSBkaXNjdXNzaW5nIGltcGxlbWVudGF0aW9u
IGRldGFpbHMuIEZyb20gYSBxdWljayBsb29rIHRob3VnaCBpdA0KPiBzZWVtcyBsaWtlIHRoZSBm
aXJzdCBwYXRjaCBjYW4gYmUgZHJvcHBlZCBhZnRlciBVc2FtYSdzIHBhdGNoZXMgdGhhdA0KPiBy
ZW1vdmUgdGhlIHNhbWUtZmlsbGVkIGhhbmRsaW5nIGZyb20genN3YXAgbGFuZCwgYW5kIHRoZSBs
YXN0IHR3bw0KPiBwYXRjaGVzIGNhbiBiZSBzcXVhc2hlZC4NCg0KU3VyZSwgdGhpcyBzb3VuZHMg
Z29vZC4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg==


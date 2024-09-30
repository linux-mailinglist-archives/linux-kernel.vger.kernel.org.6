Return-Path: <linux-kernel+bounces-344568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0598AB74
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C024B22137
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBA198E61;
	Mon, 30 Sep 2024 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7aQSjRl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F518C31
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718956; cv=fail; b=Kz57MBdrxJ4w9AN1M2WYQ0yJxCY4TbLWaQSL03Givtpo3hD/85RWFHwZ3XN/XTmrderU9gPk9AKyq7xuY/Tv44theUSEMN1EX7+ooueYBRYPUESHKeGi/Eqrn0SClMEpScHkH+8nGmDWBBO/zHutzG1MEwC0LHkW0XYRTdL6sHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718956; c=relaxed/simple;
	bh=loDMXK7U6nvKxBqxttrsDJjylFyQb36B4eALC/bEEus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i9gljZaKC+qgW7Kr3cSP+Cf3Kq2kUfyobCUeSr2vP23xcPG+fBBnOlGS5ugVFnMxHBC84RET5z7O3BUQoKvwS0xixzobE8Xb+xnEI87EiaAO8d47WfszBFru4oy6pyaeo9OXIDC0xCNRt9FLxZmWjrsj8BCUQkf+Q2yTwrlqMjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7aQSjRl; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727718954; x=1759254954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=loDMXK7U6nvKxBqxttrsDJjylFyQb36B4eALC/bEEus=;
  b=i7aQSjRlXJM6KFMHXi3Y2rwOvtkQWja3Koh0hebdv91DBDNIzFDxQDDm
   qRvbpmWk8FGI84DYjkzb3Y315wcCQQcOoaD4QNf286aB7MpZHnvi0ZaJO
   OpLzdjYayxzWHDoJIrx/08YFpSBIs3GGw1Gmrx7HXDmLqlLZ4pWYDrsol
   ewK/BQslD6SZWaJ1DhpooLCAHz/5SedagY3ec/WXJZ7OaGZF0Sx/t5bTl
   u3ULg6p6zLqtJ9gwHyMMs7MxRaLGktkrBIpD+SLwEvAkXVhEpRn4gKmSK
   TmtRSKEpmvfACfGvh3i6x9I29zm7gIuJp4pcl0+wX4tS2r/JW/cm7gzG2
   Q==;
X-CSE-ConnectionGUID: Ttez6qLZQeGHHGHuQ7T7Ww==
X-CSE-MsgGUID: fc8sY/gJRsCeYf2AwUEBAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26925563"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26925563"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 10:55:53 -0700
X-CSE-ConnectionGUID: z7TuyquVTLWKKjNJZt3p/g==
X-CSE-MsgGUID: xnQoSGAmQdieQ0ZH8fdNrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73051889"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 10:55:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 10:55:52 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 10:55:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 10:55:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 10:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7LNMvi3/16ximqPuKnPBl1OiLFPf0gUxVsBDkJTygs5SP50WWESz4nL1E2t9ihOha49YKAOUmXQprybSxQVabnR5iNNTvJWNT+YL9xxTJJBS+7eCBUJ6jWdnhzptR//RQX7p6AnVOXBCFWISK1+GBeJxnXe6kApumCMvKsk7yJ1aQPelbatS2sxfmG7h21uwYjIF7pvwc46+3raa6qH6fgr1YoE2n+6A5ZEtQbTQLOJeMN3tmC27611HVZVDjFJ/HnXGWYgnUQSg3dkXCYPxQ2oSwaYjg57rp3AZryyd4EBSU/oyN+Tk3g5J1DszAik9TD7n2EHurI4KdB9tgJ0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loDMXK7U6nvKxBqxttrsDJjylFyQb36B4eALC/bEEus=;
 b=xHdqgkdjHWa6TYkFY0keao+byb+V6rESVmXsIFtJdIsxEkdXCJLq/LH6DJPA80HT35O64Xa4dbYTQ7doJD4iDp98mPwO871NiBwkgkQuwAj5vRUTRZjjqdKyi/x3JMfasrmp83UgyIwo9z3men5bk7WAKRgm4+SQlM8OglhSkedT1YcZ/gFa7DVleIQhR/KL5QUV5eaI5xYXdlWc3ag22mYzK4qKYv6+fKdSdAPBeOUAIpUmpfk6aZOOjF7TGjnbI3+rgnWiPgRVfjT7JaK3TrysQfbN2I8Of08TfGkM7w2ygu7IUDDvtermNR9aMDP4yw++uIMpmDFZ45KsOe/gkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 17:55:44 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 17:55:44 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v8 6/8] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v8 6/8] mm: zswap: Support large folios in zswap_store().
Thread-Index: AQHbEUxuGKWHQbb9n0y12+mOnhkTu7JsjjkAgACw2gCAAEIAAIABwuTAgAFcSQA=
Date: Mon, 30 Sep 2024 17:55:44 +0000
Message-ID: <SJ0PR11MB567870784D380DE5EDB29AEBC9762@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkZRTAiEJQpg96zqDye3ViCfvBsMM1Ozmcs75e__WcF0kQ@mail.gmail.com>
 <20240928141514.GE957841@cmpxchg.org>
 <CAJD7tkbw7i=JB5NDYmmsxEw--NqkOidNeO-0+Gj0EvZfk627Dw@mail.gmail.com>
 <SJ0PR11MB56780EABB1E37C98A0EDE4EDC9752@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56780EABB1E37C98A0EDE4EDC9752@SJ0PR11MB5678.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CH0PR11MB5234:EE_
x-ms-office365-filtering-correlation-id: 62ddf866-29e5-40a0-18f8-08dce1791b2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZTl4US9sTmNabTY0VEZmVENDR2Z3RjFuRWVtR1NlZjJFaDZPNXpoRUlJYlZX?=
 =?utf-8?B?ZkNiK2c2Zi9HdlpuNmFCTUNxWnRkOXB1K1dtS3RaaXUyUC96Q3lMTVlzR3Y5?=
 =?utf-8?B?NFhpM01MUXY3alRzUWNCRTZWaE1JU3lnM3p1c09RWUt3RS9zMmZLbWs0VTky?=
 =?utf-8?B?VGpweVVlYU1ITGFjbFZZWDJQR0dReHJDdDI4UTMrSDlES0dTQWR4NGFrbGo4?=
 =?utf-8?B?elJ3ZFRkM2lFdy8vOFZxUWRESmduTkFmYTA3S3hyQjRmc3J3MkJHeFZGSnJr?=
 =?utf-8?B?akpZM3A3ZUhrcTZDVDlERGMxK0N2V09NaWZxVWdvei9WRmV4ZUYwSjFpQnls?=
 =?utf-8?B?S3YzMTRjV05BaUlTTUJHQStDcFd2VFBUS2xPand3TGJHZkF4TGJ5UkJFbHpv?=
 =?utf-8?B?SkJFY2hqd2RMR3h0QmJEZm9ITGw2b3BLNEF3OWIyeUpYdzlBRG9aenJOTWhO?=
 =?utf-8?B?S2U4YVlMSnNrd3BacVcwbHcyMUdCRzdIamtvUTEyUWh0ckwzcmN3UnQ3aTJi?=
 =?utf-8?B?SHpwUWQ1WUhMRlJDYU9NRExHbk5uL3dBRUdhWG5JN3YyUmcwelByVUU2cm1k?=
 =?utf-8?B?U2diS2VHM29MNXpYbHFmVWg2bkxSYUVVemU2QVdic2FCY1VRbEhxemR2Mmt5?=
 =?utf-8?B?K04vWk9hRUxTVmwyLzNkWXBjd1ZWWDZqWVp3Zi9ZeEMycmV3THZoVFlJNldp?=
 =?utf-8?B?ZG9QelF0dUlQUHA0TXpYeFBFK2gyQllzNmgzWFE1c2o5WHFKOWk4T1JBY1RF?=
 =?utf-8?B?U2JqblV0WkZDMDlydHdaMmNWdm83MmhsQXo2Z0ZCYmZzemV5UEZ3SlFwaWM4?=
 =?utf-8?B?bm0zVG9HTjZqcmxBTFdDSG1INFErSjd4S2hGbHZGUjBReDdkN0huaDNQQTVl?=
 =?utf-8?B?MlpOeDJuT0NYMDczcUlGckRySDNrSkZMRncvS2pnOHNmMHBPOTJTMTgvVVVK?=
 =?utf-8?B?bS96ZGlYY3l2dUZ5a0FmcDZXdEp5M1QycDRyd21pK1I1R3kvZE1FVHNReFY1?=
 =?utf-8?B?SkhzNUNLNlE4VWo2enAyR0syRXY3WjNCa0UvN2ZqT3luanN3OWtMSEhwSEFx?=
 =?utf-8?B?aWJEYzBzYzd2UmZ5cmxVdGlkeVhzOElsb2tMTGtISzdETHVYbFNSb21vT3JO?=
 =?utf-8?B?SEswSS9rQlJLaXk2WHE2eWk2ODAwVkludEtGVDBOR1RtRGZ3a2FTZ1JSYW03?=
 =?utf-8?B?Qk5iMTJSU1VuS25LT1FqNGNCRGFUK0VFNkR4SDJVcmFkdFpzcGZnczNOSnlY?=
 =?utf-8?B?cmxaNnNjSCtWVVdvZEtkWnVYbjhnRVJXRlBSQm0rckoxZ2Z4TENKYnVza0N0?=
 =?utf-8?B?WEt1WlY0R3pnMzFxM2dNcEFWQUs3Q2NnWm9CbUVoMVFuOWN3M0crY0F4SFpi?=
 =?utf-8?B?dFhvb0p0YloyVGowQ2UwUTFqckdQSkJnRUZYSWlYWGtpeTV6MzN5dFdqTmhX?=
 =?utf-8?B?ZGtrclZkTHVyQVpWeFZ2bUZsaDV0TnJoeWpZZUdrOFl6UG1zNlJ2Z2ZoZXVC?=
 =?utf-8?B?TVVyNEFuNmp2SE5EeWkrUDdDWHlLS2JlbEVzS1A2QU5qS09rMW8xNTBXMElm?=
 =?utf-8?B?VHBpUkF3OU9KdlVoWGFCT3lGRU1HdlZLMkJxb0JtYTIwRWtGZEU5c2s4dGcx?=
 =?utf-8?B?cnlackprVXlyYjhobFp6dDY5YTVlOTQ4V1Q5WXltUThORUVBVEpkaTNlYjJY?=
 =?utf-8?B?Yjh3YWhFQnNXYnFqNXg0SXl0Q3NDVEFQc2Q0MlF4eFBvWGNlWng3QXpuRHE1?=
 =?utf-8?B?RE5PTS9mYVhHZ2JOcXg1TEkzNHVwRTdDN1JzTnBjcFk1WFM2NHp6dHRjYXY5?=
 =?utf-8?B?QlU2WUt2NjZtMGNVL2l0dTFkazUvcWMvL1FxMURyTExqdi8xWWZUSzRwL2M2?=
 =?utf-8?B?VW82TmxUOWZjd1JUVit4M05jNHRQZ3JnNnBvdWgwenJzQnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2ZKQkdVek03dHQwNWF1ZVNFcFYvNjBUaEVFNDViVXdXNDlUakpycmpWU1Y3?=
 =?utf-8?B?SE1IRWRmZ0dwTDd0MWtJaGV4NWhyL29TdUxocms4cEdpTkdXM01POTZaQndk?=
 =?utf-8?B?ODRKMW1Kc0dIaWcxYzZGMU1rTWRtY3Vld1JDMUs2MUdWaTYzdnZVVHh3bVNK?=
 =?utf-8?B?OGRMeXFTMU01M3ZPS0dsbENUMFlqcHFrbjFtZlBIeEJtSUNCZG1hM2VBQjBi?=
 =?utf-8?B?Y2pQdlc5VkI3Ty9hdUZadUpPdkp3NHVDZkRYaklldXVCSGpmcERnNy9TeURl?=
 =?utf-8?B?UnRjYjNtN0N5VjZvSUFIR2lOa0RNQmhzclk2emU1ejkyL2Y5VnFodWVRZkc4?=
 =?utf-8?B?REZkQjhhTi9rKzErK1pnOTE0eXdrclBpSC92K2dtR2E0dEtpT24xMlhBbXBt?=
 =?utf-8?B?Mm5vbFVHTy8wR0Z0T3JVRytYSlphZU5XZi9ybGtJYll5WWorNU1oWnRuM28v?=
 =?utf-8?B?bE1uWFIvZ0UvTXQ5ajZZay9XT3RyUjdFNzhkaGhTUXBZOHhJR3NSSFFQSnBt?=
 =?utf-8?B?Z0tJSjVEeTJFUFJPSDBQbE9nZkxyN0tDMWJ5NWYxV2habm5mYlRxUXNHbnRV?=
 =?utf-8?B?dDVSYUtUYUVJQlh4bjRuNFRpcS9neTlPWFlISUp2b0xWUGRacnZMSlNUR3ln?=
 =?utf-8?B?ZU5JOFVqTk5OSXFmMWVjM1N0V3NFU3A3M1IrVWJrNHFaWURXd0Q4aWFKc2dX?=
 =?utf-8?B?bVlZNUg0b05ST3d1NXp5aFdPdTF0cTFYOFRYQm9uenk4VHBhRXNITmh5T3hj?=
 =?utf-8?B?dlcyMHdGOEFLVEVhU3RFQVRZQVpnZkkwS1Q1MGYrbzFuS3BrWlV1MndKaGEz?=
 =?utf-8?B?TkZSN1ZEdFpuT0xhMnJNSnhacEZGclYrOEg5U3B5NEZySElyQThiV2ZHRXZJ?=
 =?utf-8?B?TzVOb0Iwdjg2NjJwYU40S3hGSmFSOW1menpyTUVHdWt6VjlFOHo0YTdPRnhJ?=
 =?utf-8?B?NzR4c3Z1MnhqMll1NW81LzV2eHBxdjk0bU42b3N4MUlLNHQ5UHFTcnpVTlpl?=
 =?utf-8?B?NmNWVHhjOHVHNWpjRzZKc1g2bXpHalBLaGhGZEFUdWZuakN3K1E1MGlMTzk3?=
 =?utf-8?B?VW5mUEJXYWExSkJqMGgzL0E3V3I0OXp2eFMwN0xJZnJ5WlNOL1lvYnFoVFJ3?=
 =?utf-8?B?UnJzdDQyYUdRbU54L2sxNWJKNnpNL3dJVWU3WGJOWXV1TFVaSXMyNkxSOG0r?=
 =?utf-8?B?TGQ2bDlwaDNETjNjZ1cyTng2TVE0eTBRV2Y2Y2RpdUpQVTBrT0VBNFNBM3px?=
 =?utf-8?B?VkZ5aCs5TFNSN2tmYXAwY3I0NWJyNWxiVDdwSmtkNmJUMmZJbHhiTDlaTDdO?=
 =?utf-8?B?QjV0TlBaTzFXY2x6SjZpREs3eEJKMEdMc3Y5SjBleEp3cFhmMktlbktaRjUz?=
 =?utf-8?B?TkZ0OVFtQnJ5WUdYellYc0U0UysxazlDeFhwT0RBWWptTUN1VUw2RnZMVy9R?=
 =?utf-8?B?TkFaTHF2bkxjNk0rV1FWRGhWZnlsZ0RFaUVzZ2g3V2NkMlkrZm1QdEh6TkU2?=
 =?utf-8?B?T1l6ZTdaNWFpcjlHTFp4aUpON2VSZGxUZGxmWHF5ZjRkMVUrbDNoZjFMZDh5?=
 =?utf-8?B?bmwzWER0cFErSi9RdTAxaWMxdmttYjQyOGhhSE5DQ3Z5U1JsMTB0OVpkUXpF?=
 =?utf-8?B?UDU4Yy9uWjBiZjIrRVFJamtseUlsaUVVdTZiQ0tlTGtTTVp2OE1oaHd0R0V4?=
 =?utf-8?B?a0VVeUlKRU41Qk15OEdjOVFaQmhYM0JUZ25qakdXa2gyU3ZpeVROcVBCZTdG?=
 =?utf-8?B?alZWamt0WS9HRm85V2lqK3BwUnZXOHllTUpISko2dDFkZEd0TTE3ald0MzBN?=
 =?utf-8?B?SHltVGNUSWlxSE9jV2lZVG5IcDE1d0R4T3dCbWpCNnNwTGsyTmRZcTFwdmpk?=
 =?utf-8?B?eUJMc1I0M0g3R3d6aE1LeDU4ZTZ4Yk9RaWZ3RE5vdUo4dktZUVo0aFhZTDMw?=
 =?utf-8?B?cHdPUzhBUjNnbWpkY2ExcGFpUmw3L1JaSHEvWDBvYXNzWFFTR2taMS82UG81?=
 =?utf-8?B?cE5vTGVlaVFzQnRFbFptMHFEaTdhd24yb0dYUVlBUXJMSzd6SW9CUDNVSmpv?=
 =?utf-8?B?dUdrcnZVMzNCTmZaZkY4d3RJZVhJZ3Mxb211TW1MOThZUk45K09qMjdIbG5y?=
 =?utf-8?B?TmVWc1pvNXZlQms3eEF6RWdVRGRQQkNhVHE5dnFDWld3dC9WRFFYdWhwRHVB?=
 =?utf-8?B?Z1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ddf866-29e5-40a0-18f8-08dce1791b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 17:55:44.3060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QT+el89MvKsFLkdZKcJcS7rZ3g6jnD2S0SzAAD8yy6zgVn1IxPzE9/e2UlpmSIuc73qxfqf5XlU25aqRe6b8OAAHobTJMHU1YZwsge9RJMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTcmlkaGFyLCBLYW5jaGFuYSBQ
IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJl
ciAyOSwgMjAyNCAyOjE1IFBNDQo+IFRvOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUu
Y29tPjsgSm9oYW5uZXMgV2VpbmVyDQo+IDxoYW5uZXNAY21weGNoZy5vcmc+DQo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IG5waGFtY3NA
Z21haWwuY29tOyBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFp
bC5jb207IHNoYWtlZWwuYnV0dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiBI
dWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtw
bUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVs
LmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBH
b3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPjsNCj4gU3JpZGhhciwgS2FuY2hh
bmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRD
SCB2OCA2LzhdIG1tOiB6c3dhcDogU3VwcG9ydCBsYXJnZSBmb2xpb3MgaW4genN3YXBfc3RvcmUo
KS4NCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBZb3NyeSBB
aG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiA+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1i
ZXIgMjgsIDIwMjQgMTE6MTEgQU0NCj4gPiBUbzogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21w
eGNoZy5vcmc+DQo+ID4gQ2M6IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhh
ckBpbnRlbC5jb20+OyBsaW51eC0NCj4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1t
bUBrdmFjay5vcmc7IG5waGFtY3NAZ21haWwuY29tOw0KPiA+IGNoZW5nbWluZy56aG91QGxpbnV4
LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gPiBzaGFrZWVsLmJ1dHRAbGludXguZGV2
OyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcNCj4gPiA8eWluZy5odWFuZ0BpbnRl
bC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc7
DQo+ID4gWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkg
Sw0KPiA+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2Ro
LmdvcGFsQGludGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDYvOF0gbW06IHpz
d2FwOiBTdXBwb3J0IGxhcmdlIGZvbGlvcyBpbg0KPiB6c3dhcF9zdG9yZSgpLg0KPiA+DQo+ID4g
T24gU2F0LCBTZXAgMjgsIDIwMjQgYXQgNzoxNeKAr0FNIEpvaGFubmVzIFdlaW5lciA8aGFubmVz
QGNtcHhjaGcub3JnPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgU2VwIDI3LCAy
MDI0IGF0IDA4OjQyOjE2UE0gLTA3MDAsIFlvc3J5IEFobWVkIHdyb3RlOg0KPiA+ID4gPiBPbiBG
cmksIFNlcCAyNywgMjAyNCBhdCA3OjE24oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFyDQo+ID4gPiA+
ID4gIHsNCj4gPiA+ID4gPiArICAgICAgIHN0cnVjdCBwYWdlICpwYWdlID0gZm9saW9fcGFnZShm
b2xpbywgaW5kZXgpOw0KPiA+ID4gPiA+ICAgICAgICAgc3dwX2VudHJ5X3Qgc3dwID0gZm9saW8t
PnN3YXA7DQo+ID4gPiA+ID4gLSAgICAgICBwZ29mZl90IG9mZnNldCA9IHN3cF9vZmZzZXQoc3dw
KTsNCj4gPiA+ID4gPiAgICAgICAgIHN0cnVjdCB4YXJyYXkgKnRyZWUgPSBzd2FwX3pzd2FwX3Ry
ZWUoc3dwKTsNCj4gPiA+ID4gPiArICAgICAgIHBnb2ZmX3Qgb2Zmc2V0ID0gc3dwX29mZnNldChz
d3ApICsgaW5kZXg7DQo+ID4gPiA+ID4gICAgICAgICBzdHJ1Y3QgenN3YXBfZW50cnkgKmVudHJ5
LCAqb2xkOw0KPiA+ID4gPiA+IC0gICAgICAgc3RydWN0IG9ial9jZ3JvdXAgKm9iamNnID0gTlVM
TDsNCj4gPiA+ID4gPiAtICAgICAgIHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZyA9IE5VTEw7DQo+
ID4gPiA+ID4gLQ0KPiA+ID4gPiA+IC0gICAgICAgVk1fV0FSTl9PTl9PTkNFKCFmb2xpb190ZXN0
X2xvY2tlZChmb2xpbykpOw0KPiA+ID4gPiA+IC0gICAgICAgVk1fV0FSTl9PTl9PTkNFKCFmb2xp
b190ZXN0X3N3YXBjYWNoZShmb2xpbykpOw0KPiA+ID4gPiA+ICsgICAgICAgaW50IHR5cGUgPSBz
d3BfdHlwZShzd3ApOw0KPiA+ID4gPg0KPiA+ID4gPiBXaHkgZG8gd2UgbmVlZCB0eXBlPyBXZSB1
c2UgaXQgd2hlbiBpbml0aWFsaXppbmcgZW50cnktPnN3cGVudHJ5IHRvDQo+ID4gPiA+IHJlY29u
c3RydWN0IHRoZSBzd3BfZW50cnlfdCB3ZSBhbHJlYWR5IGhhdmUuDQo+ID4gPg0KPiA+ID4gSXQn
cyBub3QgdGhlIHNhbWUgZW50cnkuIGZvbGlvLT5zd2FwIHBvaW50cyB0byB0aGUgaGVhZCBlbnRy
eSwgdGhpcw0KPiA+ID4gZnVuY3Rpb24gaGFzIHRvIHN0b3JlIHN3YXAgZW50cmllcyB3aXRoIHRo
ZSBvZmZzZXRzIG9mIGVhY2ggc3VicGFnZS4NCj4gPg0KPiA+IER1aCwgeWVhaCwgdGhhbmtzLg0K
PiA+DQo+ID4gPg0KPiA+ID4gR2l2ZW4gdGhlIG5hbWUgb2YgdGhpcyBmdW5jdGlvbiwgaXQgbWln
aHQgYmUgYmV0dGVyIHRvIGFjdHVhbGx5IHBhc3MgYQ0KPiA+ID4gcGFnZSBwb2ludGVyIHRvIGl0
OyBkbyB0aGUgZm9saW9fcGFnZSgpIGluc2lkZSB6c3dhcF9zdG9yZSgpLg0KPiA+ID4NCj4gPiA+
IFRoZW4gZG8NCj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgICAgZW50cnktPnN3cGVudHJ5ID0g
cGFnZV9zd2FwX2VudHJ5KHBhZ2UpOw0KPiA+ID4NCj4gPiA+IGJlbG93Lg0KPiA+DQo+ID4gVGhh
dCBpcyBpbmRlZWQgY2xlYXJlci4NCj4gPg0KPiA+IEFsdGhvdWdoIHRoaXMgd2lsbCBiZSBhZGRp
bmcgeWV0IGFub3RoZXIgY2FsbGVyIG9mIHBhZ2Vfc3dhcF9lbnRyeSgpDQo+ID4gdGhhdCBhbHJl
YWR5IGhhcyB0aGUgZm9saW8sIHlldCBpdCBjYWxscyBwYWdlX3N3YXBfZW50cnkoKSBmb3IgZWFj
aA0KPiA+IHBhZ2UgaW4gdGhlIGZvbGlvLCB3aGljaCBjYWxscyBwYWdlX2ZvbGlvKCkgaW5zaWRl
Lg0KPiA+DQo+ID4gSSB3b25kZXIgaWYgd2Ugc2hvdWxkIGFkZCAob3IgcmVwbGFjZSBwYWdlX3N3
YXBfZW50cnkoKSkgd2l0aCBhDQo+ID4gZm9saW9fc3dhcF9lbnRyeShmb2xpbywgaW5kZXgpIGhl
bHBlci4gVGhpcyBjYW4gYWxzbyBiZSBkb25lIGFzIGENCj4gPiBmb2xsb3cgdXAuDQo+IA0KPiBU
aGFua3MgSm9oYW5uZXMgYW5kIFlvc3J5IGZvciB0aGVzZSBjb21tZW50cy4gSSB3YXMgdGhpbmtp
bmcgYWJvdXQNCj4gdGhpcyBzb21lIG1vcmUuIEluIGl0cyBjdXJyZW50IGZvcm0sIHpzd2FwX3N0
b3JlX3BhZ2UoKSBpcyBjYWxsZWQgaW4gdGhlDQo+IGNvbnRleHQNCj4gb2YgdGhlIGZvbGlvIGJ5
IHBhc3NpbmcgaW4gYSBbZm9saW8sIGluZGV4XS4gVGhpcyBpbXBsaWVzIGEga2V5IGFzc3VtcHRp
b24gYWJvdXQNCj4gdGhlIGV4aXN0aW5nIHpzd2FwX3N0b3JlKCkgbGFyZ2UgZm9saW9zIGZ1bmN0
aW9uYWxpdHksIGkuZS4sIHdlIGRvIHRoZSBwZXItcGFnZQ0KPiBzdG9yZSBmb3IgdGhlIHBhZ2Ug
YXQgYSAiaW5kZXggKiBQQUdFX1NJWkUiIHdpdGhpbiB0aGUgZm9saW8sIGFuZCBub3QgZm9yIGFu
eQ0KPiBhcmJpdHJhcnkgcGFnZS4gRnVydGhlciwgd2UgbmVlZCB0aGUgZm9saW8gZm9yIGZvbGlv
X25pZCgpOyBidXQgdGhpcyBjYW4gYWxzbyBiZQ0KPiBjb21wdXRlZCBmcm9tIHRoZSBwYWdlLiBB
bm90aGVyIHJlYXNvbiB3aHkgSSB0aG91Z2h0IHRoZSBleGlzdGluZyBzaWduYXR1cmUNCj4gbWln
aHQgYmUgcHJlZmVyYWJsZSBpcyBiZWNhdXNlIGl0IHNlZW1zIGxpa2UgaXQgZW5hYmxlcyBnZXR0
aW5nIHRoZSBlbnRyeSdzDQo+IHN3cF9lbnRyeV90IHdpdGggZmV3ZXIgY29tcHV0ZXMuIENvdWxk
IGNhbGxpbmcgcGFnZV9zd2FwX2VudHJ5KCkgYWRkDQo+IG1vcmUgY29tcHV0ZXM7IHdoaWNoIGlm
IGl0IGlzIHRoZSBjYXNlLCBjb3VsZCBwb3RlbnRpYWxseSBhZGQgdXAgKHNheSA1MTINCj4gdGlt
ZXMpDQoNCkkgd2VudCBhaGVhZCBhbmQgcXVhbnRpZmllZCB0aGlzIHdpdGggdGhlIHY4IHNpZ25h
dHVyZSBvZiB6c3dhcF9zdG9yZV9wYWdlKCkNCmFuZCB0aGUgc3VnZ2VzdGVkIGNoYW5nZXMgZm9y
IHRoaXMgZnVuY3Rpb24gdG8gdGFrZSBhIHBhZ2UgYW5kIHVzZQ0KcGFnZV9zd2FwX2VudHJ5KCku
IEkgcmFuIHVzZW1lbSB3aXRoIDJNIHBtZC1tYXBwYWJsZSBmb2xpb3MgZW5hYmxlZC4NClRoZSBy
ZXN1bHRzIGluZGljYXRlIHRoYXQgdGhlIHBhZ2Vfc3dhcF9lbnRyeSgpIGltcGxlbWVudGF0aW9u
IGlzIHNsaWdodGx5DQpiZXR0ZXIgaW4gdGhyb3VnaHB1dCBhbmQgbGF0ZW5jeToNCg0Kdjg6ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBydW4xICAgICAgIHJ1bjIgICAgICAgcnVuMyAgICBh
dmVyYWdlDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NClRvdGFsIHRocm91Z2hwdXQgKEtCL3MpOiAgIDYsNDgzLDgz
NSAgNiwzOTYsNzYwICA2LDM0OSw1MzIgIDYsNDEwLDA0Mg0KQXZlcmFnZSB0aHJvdWdocHV0IChL
Qi9zKTogICAyMTYsMTI3ICAgIDIxMywyMjUJICAgMjExLDY1MSAgICAyMTMsODg5DQplbGFwc2Vk
IHRpbWUgKHNlYyk6ICAgICAgICAgICAxMDcuNzUgICAgIDEwNy4wNgkgICAgMTA5Ljk5ICAgICAx
MDguODcNCnN5cyB0aW1lIChzZWMpOiAgICAgICAgICAgICAyLDQ3Ni40MyAgIDIsNDUzLjk5CSAg
Miw1NTEuNTIgICAyLDUxMy45OA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCg0KcGFnZV9zd2FwX2VudHJ5KCk6
ICAgICAgICAgICAgICBydW4xICAgICAgIHJ1bjIgICAgICAgcnVuMyAgICBhdmVyYWdlDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NClRvdGFsIHRocm91Z2hwdXQgKEtCL3MpOiAgIDYsNDYyLDk1NCAgNiwzOTYsMTM0
ICA2LDQxOCwwNzYgIDYsNDI1LDcyMQ0KQXZlcmFnZSB0aHJvdWdocHV0IChLQi9zKTogICAyMTUs
NDMxICAgIDIxMywyMDQJICAgMjEzLDkzNSAgICAyMTQsNjgzDQplbGFwc2VkIHRpbWUgKHNlYyk6
ICAgICAgICAgICAxMDguNjcgICAgIDEwOS40NgkgICAgMTA3LjkxICAgICAxMDguMjkNCnN5cyB0
aW1lIChzZWMpOiAgICAgICAgICAgICAyLDQ3My42NSAgIDIsNDkzLjMzCSAgMiw1MDcuODIgICAy
LDQ5MC43NA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkJhc2VkIG9uIHRoaXMsIEkgd2lsbCBnbyBh
aGVhZCBhbmQgaW1wbGVtZW50IHRoZSBjaGFuZ2Ugc3VnZ2VzdGVkDQpieSBKb2hhbm5lcyBhbmQg
c3VibWl0IGEgdjkuDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+IEkgd291bGQgYXBwcmVj
aWF0ZSB5b3VyIHRob3VnaHRzIG9uIHdoZXRoZXIgdGhlc2UgYXJlIHZhbGlkIGNvbnNpZGVyYXRp
b25zLA0KPiBhbmQgY2FuIHByb2NlZWQgYWNjb3JkaW5nbHkuDQo+IA0KPiA+DQo+ID4gPg0KPiA+
ID4gPiA+ICAgICAgICAgb2JqX2Nncm91cF9wdXQob2JqY2cpOw0KPiA+ID4gPiA+IC0gICAgICAg
aWYgKHpzd2FwX3Bvb2xfcmVhY2hlZF9mdWxsKQ0KPiA+ID4gPiA+IC0gICAgICAgICAgICAgICBx
dWV1ZV93b3JrKHNocmlua193cSwgJnpzd2FwX3Nocmlua193b3JrKTsNCj4gPiA+ID4gPiAtY2hl
Y2tfb2xkOg0KPiA+ID4gPiA+ICsgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiA+ICt9DQo+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtib29sIHpzd2FwX3N0b3JlKHN0cnVjdCBmb2xpbyAqZm9s
aW8pDQo+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiArICAgICAgIGxvbmcgbnJfcGFnZXMgPSBmb2xp
b19ucl9wYWdlcyhmb2xpbyk7DQo+ID4gPiA+ID4gKyAgICAgICBzd3BfZW50cnlfdCBzd3AgPSBm
b2xpby0+c3dhcDsNCj4gPiA+ID4gPiArICAgICAgIHN0cnVjdCB4YXJyYXkgKnRyZWUgPSBzd2Fw
X3pzd2FwX3RyZWUoc3dwKTsNCj4gPiA+ID4gPiArICAgICAgIHBnb2ZmX3Qgb2Zmc2V0ID0gc3dw
X29mZnNldChzd3ApOw0KPiA+ID4gPiA+ICsgICAgICAgc3RydWN0IG9ial9jZ3JvdXAgKm9iamNn
ID0gTlVMTDsNCj4gPiA+ID4gPiArICAgICAgIHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZyA9IE5V
TEw7DQo+ID4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgenN3YXBfcG9vbCAqcG9vbDsNCj4gPiA+ID4g
PiArICAgICAgIHNpemVfdCBjb21wcmVzc2VkX2J5dGVzID0gMDsNCj4gPiA+ID4NCj4gPiA+ID4g
V2h5IHNpemVfdD8gZW50cnktPmxlbmd0aCBpcyBpbnQuDQo+ID4gPg0KPiA+ID4gSW4gbGlnaHQg
b2YgV2lsbHkncyBjb21tZW50LCBJIHRoaW5rIHNpemVfdCBpcyBhIGdvb2QgaWRlYS4NCj4gPg0K
PiA+IEFncmVlZC4NCj4gDQo+IFRoYW5rcyBZb3NyeSwgTWF0dGhldyBhbmQgSm9oYW5uZXMgZm9y
IHRoZSByZXNvbHV0aW9uIG9uIHRoaXMhDQo+IA0KPiBUaGFua3MsDQo+IEthbmNoYW5hDQoNCg==


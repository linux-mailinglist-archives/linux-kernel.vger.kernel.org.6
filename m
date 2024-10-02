Return-Path: <linux-kernel+bounces-348154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD77398E368
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABEA9B23733
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07E2141A9;
	Wed,  2 Oct 2024 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdCrLuiR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845771D0DCE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897098; cv=fail; b=DQqSKqcv1lPmxnuLPI+11ffyxkv3N6NXm30f7u568dLlsNlvzEIYlMFMeJDp/mLvIYO4ttrmDE1frNyBVmLB4Ozu4iBE4/PI2hGOUj3uCsVdMldK5JrN0EpXettfH6ZhvhYNbeeATMj3fc06y51j4QSyT9/9ELDEyUdPTGL89Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897098; c=relaxed/simple;
	bh=/hNbGZCB6lUoCJP6RK2KA/VDusAO3GhQM3WynlEvR1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RbZQ2ICHT+9Q1NXE2b4OvcIpbSulqzCz1P2exAdJ5tOjPLWGrc3G/LyxbjOmV9Y3wdGiB6hORSQoD4l8jyxOGGjglvZO/6DHrIdaxLqjcNUcH3H0QlAhvm3Kh+hEtHfi1jt7AqrnD6pPaQanZ8gvLFlMHLuTlKjrEc8TP4IZaEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdCrLuiR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727897096; x=1759433096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/hNbGZCB6lUoCJP6RK2KA/VDusAO3GhQM3WynlEvR1o=;
  b=MdCrLuiRNGGyJrejFJyekPE6M/txqYn7t3XehWiMHnBBGbu8Hr2RcGFT
   51GP4l4qOmCfPJGtCdhAd83caOUNQ5dnpyyBNybxTMUOUcyFS/pxfn/TW
   c720j5alxjaj37yc2l1AaTbBwIqraRZJXMrVB5ffRGgrKhKMjPpl/ZtHf
   WRSBSEycS0KetwuBGdO/mwfBwsxxyN37nXQTXfk9KLuddAgm/KI/G9Ne6
   rSIh2UlawGBIRwT8H3tAYO2Hnkli7ux+Ub/BdkEDqt0Oq9EsPbLbvEeUU
   izT+FeGJIQZm1aFwiEVl9yQgR/ZICRprLG5+x6D3Yua4dTWXpJC6+xI5L
   Q==;
X-CSE-ConnectionGUID: w5Wz/PGeTtauuhyhCTrW/A==
X-CSE-MsgGUID: nxrBuUUYROqE501I1++9jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26947187"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="26947187"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 12:24:56 -0700
X-CSE-ConnectionGUID: ovCSyoZHTzO0vIYrIIlFoA==
X-CSE-MsgGUID: NnyI7SMxR6KjGYGtU2OR8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78853565"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 12:24:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 12:24:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 12:24:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 12:24:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 12:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkxAOjiTqtv7mJC6OWBjwSAclVIdwlHkugAj4BEVn/xCzJRUO5ZZS2BacKrGQ4RuKrW4FWlULr5p/roVP+QMw4TfrZPOJ1CG/mdPP/oaMOQPOGyR8VMbsHBWaMG+y/7TZ2cZ3iyVnaQw4GQ3itEMl0RjL5xl3L+Y7OO96NCW94BR/XKzavzHISGJ2W5d75vw3OYGLCsrCapufTKc7SM40ShXlC4KZMPNuJTIB3N3EAvgUBhoqPcrS5LkPZaQ/Ka7elyS5r3q3uiYPcW6LqJ2Y6D8C0I32tYRigPnNurc7T0VP+mWANp1tjfnpTqMf4ouD+JvAsHmeukCqORYRZDMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hNbGZCB6lUoCJP6RK2KA/VDusAO3GhQM3WynlEvR1o=;
 b=iA1zkIVe7tyEbjNHKvsWRzoBPaEb5gHhTMu9L8P9UtG7cfH2s4qdW8EkHyCKuJAm5P+9eqXUBULUNx5umRvYOTldzdTfn79krGX/fN6mF9TMvTS4qxycnSX2SbdOAuRXYg72p+EcE+pGZOomGogUQ+7WWWytVUnO+m3QvEPyGQymqCKKQ0OJ9aibnLeI33Xvi4jbFlp4V+NcLnxwye8RN3TyKFVKVU21jeBBAkX9kKsFezkIEe6/hurntplbE1UM3RgsQYTeSzi2STanV4A+I6nfSVEfQizEUniAQ3BYtKXSJV20NEEeoft459tDszrXIycxDvbdS04U7MT2j1vKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by LV3PR11MB8483.namprd11.prod.outlook.com (2603:10b6:408:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 19:24:45 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 19:24:45 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Delete comments for "value" member of
 'struct zswap_entry'.
Thread-Topic: [PATCH v1] mm: zswap: Delete comments for "value" member of
 'struct zswap_entry'.
Thread-Index: AQHbFPEJcWVeqIgEEEyjAoSCuRhz6LJzxCyAgAATMXA=
Date: Wed, 2 Oct 2024 19:24:45 +0000
Message-ID: <SJ0PR11MB5678D9226152E19086B60C26C9702@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241002173208.213631-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=PksK6rHbCW_Sx=5fa+=qgUYu8JTWrAy-XGq3phuReVqg@mail.gmail.com>
In-Reply-To: <CAKEwX=PksK6rHbCW_Sx=5fa+=qgUYu8JTWrAy-XGq3phuReVqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|LV3PR11MB8483:EE_
x-ms-office365-filtering-correlation-id: 7f464be6-da50-41e6-ab44-08dce317df8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VUd1UE0rMllSQ21qVDE2azR6b1pXVzFOcmlvWUU0ZUN6RzA5RVBLY2RxWnpO?=
 =?utf-8?B?dVpQSWs3RExwL1FNb0lUOW16VzFkUnZaSFI0TVZXbUlnNUVRb2pOVGc1ZEJZ?=
 =?utf-8?B?TGI3SVp6bVJwTSt5N3dUUnNTUTBxKzlhaE1tbUF3NWc2Y0VuMElSbWFRU2cw?=
 =?utf-8?B?UExwR1Bxa3JpSWI0NGZza3doOTAxUWpWUWtEZWIyUTE0d0JFemtRMkJmZTdm?=
 =?utf-8?B?Nk1hWHZKdmhrOUxBa1hPemg2VVEzZ05pUEJWVllWL3UwM0o1a09aRFJCbHpH?=
 =?utf-8?B?R3BENTVGT3NTODJEZElhOFV4T0hERzVTTWdGZjZNdVFzbUw4NVd0Y043MmRn?=
 =?utf-8?B?QTUxUjU1Q0JtWFVtVW11VC9FbUJTWVVYVGIzV2VqN005Q1JkeFdyYmxIK2ho?=
 =?utf-8?B?U3VYNzJFc0pHU3NEbHV6SGp3b2tEU3UyWVZBR0JWSHRRWWlSVWVlM1Z3dDN4?=
 =?utf-8?B?K0xOdzdsRG5nb0tIVUlSOVQyZi8zNFBFRlhHWmNyeURVNTk0OS9oQlZDeS84?=
 =?utf-8?B?NU1CTHIyYy9yTHNOVzZjK3VDd0xjTmxzTnFOU1FFc21MMDRxdGdYSUVSMU9j?=
 =?utf-8?B?Ukg5d09XMERuSGozUlVYK1h6RE0rQkVjelZabjZlM3NWWTgrL1AwSFRBcUY4?=
 =?utf-8?B?VTJTKzBxd2Z6RmdBVTNROXNzOFJ0MStTVU9NZ3dkL3FYMXUwRzBGMEFNZE9P?=
 =?utf-8?B?dHF3c0o2aUMvNnNkZ3FQR05Oc0pkR2IzNHowQXRtZlBJeVNOdXZlS2hEZE00?=
 =?utf-8?B?TDIrSWlsbGZlL25kdjF4S29lNjZTM0R1WnM4L25NWHhxSGtRMkQ1VU5ZU1pU?=
 =?utf-8?B?bUtBRE5ER3lCbURCT3NGTzR6d3BWMjEzUTVtaFEzZ2g0ZUFaajlDOCsxVXFN?=
 =?utf-8?B?NHJ2ZVpTRGx2VnlXbENLUkc3LzcxR3VjQlZldWdyL2ozU21YeXRoeG4yUng0?=
 =?utf-8?B?UmhiRVdkL0d1NjAyUWIvQnJHNFBIczVRa3VrbHJFbXN2cktJSU1PSGNGS1oz?=
 =?utf-8?B?OUlTVXBFUVFEcTVlQ2pWRzlYVzdlNjVWMHJyMlBZNGVYTWxmcVRVZ0NoM3RD?=
 =?utf-8?B?UnUwdmE2UDZYdVdnNWdmbXcvMXgzWWdINEx4SkRJS0dpYnNYTnNQWkpvR2ZJ?=
 =?utf-8?B?cUhNTC9CT0lYRXQxUWo0bW8wZjErS1o3NktNWVVFcURwbEpsU3lRSTBxSTc4?=
 =?utf-8?B?UHRnSWJSby9CczdJTkRLajcvTEx1SXNkU0hJSVZ5VjZCdWRNQjNQekR3NnI2?=
 =?utf-8?B?bUoxUS9EY09yNktHWVdicXRDMW4zNENQdUFJVGhkVS9KdU03am9MOWx0c0Ru?=
 =?utf-8?B?REZCWGp5SEtIcEdITnVRbituRXpoeW5mZzU1aG1zZ3VTb09udHl1WFBtemE1?=
 =?utf-8?B?aytXUk1aQThlNEN2WUZsbUpGSURpRFNmUWRwQ1pEbWc0bUwwZFBINmVPYUhM?=
 =?utf-8?B?VnYyQzlyY3hZVEdXQTh3MWgwM0tiNktCdXV3WUZlN1VGZHNSWGtITXRGNk1h?=
 =?utf-8?B?YXE2ZHVIQmphU3JFZlVlRVVhY0RJV2pDb05WS09uTlJHK2wxOEozUWFpRXNT?=
 =?utf-8?B?M29uQVUzelMvcm96Y1orTTVkbk5RNHEvTHduZ2VzOGlVQTdaOTRrOXpOTSt3?=
 =?utf-8?B?OTNlQkNSNFJadHJtYWM4R0xyb0xhS0hDMDQwaks4THpjaU9ybUFya0tZdjB5?=
 =?utf-8?B?ckNLZkhXZFRtS0QxNzYrMlZ4WURSbm9TTk44Y1ZjTlhYeC9NSnEzb3JFeW8z?=
 =?utf-8?B?eEdNWDBPMzVicDZSbHdmaEt0ejFPTjR4dSs5ZmFubVFzSEo0ckZlWEwrNVBX?=
 =?utf-8?B?WXpwcGJJV2NYQ3I2L3V6Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUFHNWNOcC9iL1J6cmRPVmI3aTUxRkhSbjZiQ3YxZVVGd2FQOVFYaytIKzY3?=
 =?utf-8?B?NklJRmxSR1lObGZWV2JPWUhmd3Ixd1dPY1NSZERCZ0ZBKzBhYVN0L2JpTS9D?=
 =?utf-8?B?M1FZRHZqSmFDSnA1TWFXVm5vbmlIS1NFOUpmMUM5YkNFM3FFK1BDRm1jN0du?=
 =?utf-8?B?ZDBmb21peW40RUIzaW5ac0pUd3ZmeEwwRHV1dS9OS1RsTXM2Zk1hakJmUkZh?=
 =?utf-8?B?NFhQUXltdGp1cXpEYVdOOXBRR0dPYTA5ekNMOGJLSHZmenZJdFlwMTVOVTdG?=
 =?utf-8?B?YmxWMGNESVVDMU9VWTVjYy8wUVpvczJMUjlkcmx6bmdjYjcvaEZ0VlhhMkVw?=
 =?utf-8?B?UmJBNjI5N1A0MEoyMDJ1YmkrSGFRRVZSWFN2U2cyWlBDTi9Bb21rdDZqY1Uv?=
 =?utf-8?B?QW1uMGhBOGlLa0lFK2NUdXdDNERXeWRtVS9ldFVXOEIxOG5CdlFsWHhTOUZj?=
 =?utf-8?B?My91d1lDVERlUWFHRG02WmQxVVRQWGFBeTViZ0k1VHhucDUvVlVUQ3dBRkxS?=
 =?utf-8?B?VThHeW5CRXcvRDl6Z1pJMnBFQksxNExMdVM0SDA4OUcvRTk0WVpCLzYraExw?=
 =?utf-8?B?YUV5eEc2QlpJUXE2U1FnenMxZDFDR2M2S2xkeW1Sb3BPY3k4Y2xGQS91OGlZ?=
 =?utf-8?B?WXdrL1c0UWY2QVpoalQzYXplQjh4OE5Bb3hXSDZreW5nd2NEN2szS1hHbnY1?=
 =?utf-8?B?a3hLckRkWStrT0VEQTJuam9nelU5elVJVVhVVE9TN1lmZ0trSDVLYkZyVk1L?=
 =?utf-8?B?NnNzYzZ1OHh3RHhnQ1NGRk8vOHdCNkxVbWtlZ1dHSG9hTkdySmpIeTdNb3lw?=
 =?utf-8?B?NDM2cjlyYXI0eHNKaDVjYzR2WUxGdUU2RkEyYm4zOVdBSmFmZFovN0o5WGx2?=
 =?utf-8?B?TzJuLzh3R0x4dy9CN1ZSVHpFUHRrLytDdmllb1hxY1VGWHBTaHNxczdDL2J6?=
 =?utf-8?B?TldWSkRPeWdRNGo3Z2RWRUsxZm1NTjJ2OHpWd1hXN3dwclNGYWQvZ25zdG5i?=
 =?utf-8?B?MlRxYXE5dkJiNVp5djJiM0ZnUndjL3VjaEl5dldFbW1IY0tDeHV2V3BEZ0pL?=
 =?utf-8?B?cWpqa1d3YXBIRGFJMk5JMFNTMTdsNjMvTWRBNk9rQ3FzSlVOeUhrZWlvd3ZY?=
 =?utf-8?B?T1ZRajUrOWVNc0hla25IS01pVzFnZ1laRTF0aHkyRXdwNlF4VGxpeGpZQkdD?=
 =?utf-8?B?ajVWR3IrRFlFWitzbTdoSk84RFExbDNrQkpTQXNpZmtQM2VZVW1qKzU3UTdM?=
 =?utf-8?B?QkVrcnlkMll5c242RlB0R1JISngxVmw2RTUvTDMraXdjbU9jeHRaam9ENXk1?=
 =?utf-8?B?QlllU0xIbnZyQ0JkRzFCc1ZHcjRiZ0J6aXp3TlVydFZadXZFMTAwaHJFOUdZ?=
 =?utf-8?B?WXVLSU1RbFBBaHNkdzRxZUExYVB5dVNSblk1eDNzbkpsbkxIQmc3TzZmRUVY?=
 =?utf-8?B?QUhlY3BVYmpyd1psTzNVbHY0V1dPcWFYdlNjVnRndUlEekxzbmZJREFpRTJR?=
 =?utf-8?B?cmJqM0tzZDdyRDcwbXdKV1ZkMWsvS0t4VXorZGRDaFBGeG5tdlpiNHM2bUk0?=
 =?utf-8?B?ZHNJbnJVMUlOR2pCNVB2QUJjN1hBZk5EemtXSDBWcFFSYTZxLzVSME5Dc2JI?=
 =?utf-8?B?QWlUNENiWThzWVVQUmxmaWJEU29CZ2p5Wkk4dDN0L0NQT2prMy9ZWUlKdFFm?=
 =?utf-8?B?MUtacTVvVVVLM2VGQUQ0VmU5ODU5dDByNUlLQVFiY3JSYy83bCs1RmZOVWc5?=
 =?utf-8?B?MUduODZqOWpoOFhsRlVhRmdhOXp2WTljQ1J2TnVrREhJZ2FxSDlsaTlObHlw?=
 =?utf-8?B?b0ZjQmh3MFBHU0dXWmpVU1lqeHFJUUxFbFIzOVFJMEYzSG9HMmZWMzg5cjU3?=
 =?utf-8?B?MHdYenFNZHFnZVQ3Rng1N2hhVnZZY1dNV2hOZ3FxNU5BZVRYeFFOMVpQazNX?=
 =?utf-8?B?SlFSbERWclJzc3lKKytKNEdYM0ZrWDRKeXhRZGxkQjd1ZWc4cjFLNDEvcVdr?=
 =?utf-8?B?Nm9rRHRZa01rRXFnNUpvTytyQVhYeTdwQmF0MkZ6M08yUTIzWFlaR0lsb2xJ?=
 =?utf-8?B?eUlxbFBLZXY5R29RcTA2M0JoR3JVcXowdEhXZWlqS28vQWQwL1RQcExPYXpX?=
 =?utf-8?B?dk9iTmI1WUYvME1KOW9DdmpDZHJ3c2NYd2I0VnJ0eXRRTjk5YkVLRU8rR3Q2?=
 =?utf-8?B?MEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f464be6-da50-41e6-ab44-08dce317df8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 19:24:45.3684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKPmSv2gk0Zec0x9J2CL761dLjv7iX8wtZ6phWLZLW/XLkDPknDl0qsdqWAX488adMcOUq4vAjhyR7oaF7+TcKsEUo1L5cpCZ2UeqOBjuwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8483
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMiwgMjAyNCAxMToxNSBBTQ0K
PiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4N
Cj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsN
Cj4gaGFubmVzQGNtcHhjaGcub3JnOyB5b3NyeWFobWVkQGdvb2dsZS5jb207DQo+IGNoZW5nbWlu
Zy56aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gcnlhbi5yb2JlcnRz
QGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47DQo+IDIxY25iYW9A
Z21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBGZWdoYWxpLCBXYWpkaSBLDQo+
IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFs
QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2FwOiBEZWxldGUg
Y29tbWVudHMgZm9yICJ2YWx1ZSIgbWVtYmVyIG9mDQo+ICdzdHJ1Y3QgenN3YXBfZW50cnknLg0K
PiANCj4gT24gV2VkLCBPY3QgMiwgMjAyNCBhdCAxMDozMuKAr0FNIEthbmNoYW5hIFAgU3JpZGhh
cg0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBNYWRl
IGEgbWlub3IgZWRpdCBpbiB0aGUgY29tbWVudHMgZm9yICdzdHJ1Y3QgenN3YXBfZW50cnknIHRv
IGRlbGV0ZQ0KPiA+IHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgJ3ZhbHVlJyBtZW1iZXIgdGhhdCB3
YXMgZGVsZXRlZCBpbiBjb21taXQNCj4gPiAyMGE1NTMyZmZhNTNkNmVjZjQxZGVkOTIwYTdiMGZm
OWM2NWE3ZGNmICgibW06IHJlbW92ZSBjb2RlIHRvDQo+IGhhbmRsZQ0KPiA+IHNhbWUgZmlsbGVk
IHBhZ2VzIikuDQo+IA0KPiBJcyBpdCB3b3J0aCBhZGRpbmcgYSBGaXhlcyB0YWcgZm9yIHRoaXM/
IEZXSVcsIGl0J3MgcmVhbGx5IGp1c3QgYQ0KPiBkb2N1bWVudGF0aW9uIGNvcnJlY3Rpb24sIG5v
dCBhbiBhY3R1YWwgYnVnIGZpeC4gQnV0IGl0J3MgYSAiZml4Ig0KPiBuZXZlcnRoZWxlc3MuLi4N
Cj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuYSBQIFNyaWRoYXIgPGthbmNoYW5h
LnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIG1tL3pzd2FwLmMgfCAxIC0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9t
bS96c3dhcC5jIGIvbW0venN3YXAuYw0KPiA+IGluZGV4IDA5YWFmNzBmOTVjNi4uYzNlMjU3OTA0
YjM2IDEwMDY0NA0KPiA+IC0tLSBhL21tL3pzd2FwLmMNCj4gPiArKysgYi9tbS96c3dhcC5jDQo+
ID4gQEAgLTE5MCw3ICsxOTAsNiBAQCBzdGF0aWMgc3RydWN0IHNocmlua2VyICp6c3dhcF9zaHJp
bmtlcjsNCj4gPiAgICogICAgICAgICAgICAgIHNlY3Rpb24gZm9yIGNvbnRleHQuDQo+ID4gICAq
IHBvb2wgLSB0aGUgenN3YXBfcG9vbCB0aGUgZW50cnkncyBkYXRhIGlzIGluDQo+ID4gICAqIGhh
bmRsZSAtIHpwb29sIGFsbG9jYXRpb24gaGFuZGxlIHRoYXQgc3RvcmVzIHRoZSBjb21wcmVzc2Vk
IHBhZ2UgZGF0YQ0KPiA+IC0gKiB2YWx1ZSAtIHZhbHVlIG9mIHRoZSBzYW1lLXZhbHVlIGZpbGxl
ZCBwYWdlcyB3aGljaCBoYXZlIHNhbWUgY29udGVudA0KPiA+ICAgKiBvYmpjZyAtIHRoZSBvYmpf
Y2dyb3VwIHRoYXQgdGhlIGNvbXByZXNzZWQgbWVtb3J5IGlzIGNoYXJnZWQgdG8NCj4gPiAgICog
bHJ1IC0gaGFuZGxlIHRvIHRoZSBwb29sJ3MgbHJ1IHVzZWQgdG8gZXZpY3QgcGFnZXMuDQo+ID4g
ICAqLw0KPiANCj4gVGhhbmtzIEthbmNoYW5hIQ0KPiBSZXZpZXdlZC1ieTogTmhhdCBQaGFtIDxu
cGhhbWNzQGdtYWlsLmNvbT4NCg0KU3VyZSB0aGluZyEgVGhhbmtzIE5oYXQsIEkgd2lsbCBhZGQg
YSBGaXhlcyB0YWcuDQo=


Return-Path: <linux-kernel+bounces-286999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FBC95216B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287101F245B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6B1BC076;
	Wed, 14 Aug 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVsZVHJj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977E1BBBE4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657257; cv=fail; b=T86FUCVFLvNQhElhKdfFdjCiZCOGwriUY96qQsJmJeXZsDyjQ0w3aaGnXaf0Xi/I1UtQgiKSuc+kVkn9fHIJDH3ECPvNN21mbm1OxOzr6/GcEziTh2ToPfimG0qEp+SelTkPcmGKWzAB+eAvRX5ItGix9vqBiBdP67NdLEOpop8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657257; c=relaxed/simple;
	bh=SOR8My+9QiHrgyoauLNBnDM/ro68VneC56E14GEL4+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jHtqfM+aXYO65cu7q+8IY9BDuRZgSgLzPc6XjdRdtQ8+6l2fwenJYYmGEohc+9zBBddX1fEgOQI7Kbii4kykwJanJ0gW8yXDEAbrqjkosl7c7CA2Vqlsg5t+iUNaBcxizj+WPL7w0pKJ9vMqotvTBGreH+qZ//HS2pzfZsMZBOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVsZVHJj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723657256; x=1755193256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SOR8My+9QiHrgyoauLNBnDM/ro68VneC56E14GEL4+Q=;
  b=JVsZVHJjNmp1tl+B7W5gQ1OTLT6qc1jWjm8p+VV0AZV9p0lzC09oDSc0
   /CIMErHUIvEv1UMg8Up6ikJtwZCrHj9n9Hg4a7dBpXaFIs+HBT1ZEXcTY
   /zBWkFgynW/kX2GGcSKRHUlJvUomZurWDO1d/PBO/KCdOr9WBLmoS0q0I
   2t2pwWIYZeD2IwAmAaI6ZSgIONYj7NOPreugBYjNonFRsSYArL3ZDPboH
   jUGQzm8IPzlRXUI6DI3On/+PAltl0OAuDeKh91wBoibGqAPy7vjw+2kx8
   iV5/BRPNFg9F+xQdf86vtDksksAJgwFQyIwKnYjWGwY4Mo5s3HBqDzF8T
   w==;
X-CSE-ConnectionGUID: 00mxm24RSCefWot+BZafSQ==
X-CSE-MsgGUID: bGbh+6CuSzWSamzLGH2NEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="25756721"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="25756721"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:40:55 -0700
X-CSE-ConnectionGUID: 4ZP72OlXTIavLhOUlpCAng==
X-CSE-MsgGUID: kE22jMTHTQarfc1BFkqPwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59376226"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 10:40:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 10:40:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 10:40:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 10:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tw93MNuFw3JMIgxpArmf1ZpZNKp36q7+PRNoOxCWi5ViD9JbjyvYzXxKNeGwcxMTOlhuNXCUAM455opP5XX6DRjJApDoovIJQEsuLIjWcTrkiTWYajIq8RpmRzhBMBicWRQUdKEzYOHSjB2xNm73/wAzXk4p8/rO0KnFnVCsqgMhOm1vz/C1cGBhqKP3MnPqMrY0GXcQ8cIwdJTjU9Mbb4dybqI2jMTxjjoEyd7yKPkxIOJnqmmPgD5ZlDWui2E14OYy4Qn1ojOz/JlEoN69W6Vq11fXgc2/I2vp2F3NLQXXVLOsOFPuLU6fc7o1g5d7zjrij7nkboetBfOHQAl6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOR8My+9QiHrgyoauLNBnDM/ro68VneC56E14GEL4+Q=;
 b=pA2C9wi7fe38zQ3A7tqOdGiUNPVjTdjW7smaJh7FSb5mo41XMOsSynQC30Fp5dbv4hcmoovTRdK6nFB4UK4VFbSNp5D6TQkSYAfQWwgyyCgxm32yV0HZA1sAmzOJN3baqhPfUXnjj/jYWzXLS2MZ8UaId+fwA6qNdi5FvfTnS8Thq1v8n8Xf/7fdALzIj+rF6Xc4foBCpXKIlgYEaq8+YAd5xLs7H2QMIqEQvvuXE8pdU0EnjdEwfbHbU5A3C914mfUwFEo6RHsS0gvUgBY5fiFFno98bANQHdGyUGPEdSFWt6smjvZxdkyKa3HBCLh1xsa2/benCuldH2DSW8RlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SN7PR11MB6996.namprd11.prod.outlook.com (2603:10b6:806:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 17:40:51 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 17:40:50 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Barry Song <21cnbao@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [RFC PATCH v1 2/4] mm: vmstat: Per mTHP-size zswap_store vmstat
 event counters.
Thread-Topic: [RFC PATCH v1 2/4] mm: vmstat: Per mTHP-size zswap_store vmstat
 event counters.
Thread-Index: AQHa7hMz8a7cvwYlHUeFP9+2SI8vyrImYJeAgAChlMA=
Date: Wed, 14 Aug 2024 17:40:50 +0000
Message-ID: <SJ0PR11MB5678048AA2B4C654E41082D8C9872@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
 <20240814062830.26833-3-kanchana.p.sridhar@intel.com>
 <CAGsJ_4yWjjY_GqcaJsma9vPsuV29-WFK5Ho9DFZBx=HnL9=nPQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4yWjjY_GqcaJsma9vPsuV29-WFK5Ho9DFZBx=HnL9=nPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SN7PR11MB6996:EE_
x-ms-office365-filtering-correlation-id: 75a42939-ddd7-4f51-d5f1-08dcbc883d1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OEswY2ZaQkpWNVZZQTd6L3ArbUN2SmlGdjNqaTQxQ0N4WXlqSzhodWs5NEtK?=
 =?utf-8?B?TjdPSGh5N3dERy82Z0Iwb0RzbS83QTZCdXhXOWpqbll3VFRMZVo0dStWOGlm?=
 =?utf-8?B?cHE5Y0dTNlpaWUF2azFSbWNhOWNoY2ZUeGZRNTBnbjNRNklBSkovbmcyNTdH?=
 =?utf-8?B?c2dhc2RzdE1Sb24xSXNERURDN3psRjJnaGxTQ0JidTlKVGp5eGtNZ1IzSWJj?=
 =?utf-8?B?bUlsV3dTQzdwejE1dVdLVGMzVHVoaEM2TUNsVkZNbWNQeHpGNG1LK01HaGxS?=
 =?utf-8?B?bnRQMHBrMzJjd2krK2FCZ1ZEaVBJdEJTTCtBRUxtUVQ2d0xUWW45eUZBMjdE?=
 =?utf-8?B?a0E3UnBaVi9UUDE2TnArNVFUSGhwcVBQZmxaY0ZxcnpYenhVaythYnowUGFr?=
 =?utf-8?B?RVkvbVhjMS9RbHpYMjJPN1E1VzJ5YmtueHBGMWczM1dYVGRxeG5IcGJUYk5i?=
 =?utf-8?B?U2Y0K0pudnU3VzNkWTgrNUFpMUJ0Z25xOVBQU0FkT09oaVFCM2k5cExSL0xi?=
 =?utf-8?B?L1FncUFmL09JMXorQSttWFlJREkyeVJMRHIyQzlGdzdERTQ2WU1mOGVqR1dq?=
 =?utf-8?B?aVBYZGpTZ205Uzl0aS9UQmlDaVBRQnRCR2dyQTN2aFVnTEhzRGRIS3UrUXA4?=
 =?utf-8?B?RnVtYnhNTW1NeDJhWUI3SzAzMWJWRUZEZ09XVmlRVU5CTGRnSTRQSjJvbnFp?=
 =?utf-8?B?VUc2SXNQWG1aUDMybW9seUU4bkR4aXZrSjYvS2I2eWdTT014emNyVHJySXR2?=
 =?utf-8?B?elN6bmU4Z1RBdmQ3Vk9hbmhsRTU2NkkrekdyTlp2NjV0NlVCUmpsRkpxV1Fj?=
 =?utf-8?B?d0RNOTFEWmVTL3E2eFBDOHhBUXRFZHZZY1NYY1gxb2lnczAxYkZhMFpRQkg2?=
 =?utf-8?B?OUY1c0s0TEFwRFdKVnpmLzZ5UGV1TVFDYnMxa2FhQWllWFpYTm1ON1JWT0JR?=
 =?utf-8?B?TzFXWWJrVElxRG8wdFQ3OHI2YTBlTmd6K0NiTG5DOWdEbzRNVkRVN1FDZXY1?=
 =?utf-8?B?NEtWeTdZeVJXR2Zyd2NOTHdDVHpZeWg0a0JOcXFVa0hjdFdLb1dIRGU2N2tp?=
 =?utf-8?B?SEJ3M1FHYnRYQlVzU0dSb2lEMG5WMzJPd3FyaEM1SkxTVVYzRjJlYitwbVo3?=
 =?utf-8?B?SVV6b1pEanRmRlNhcnkrTTVuUk5oVmY5eERWSENoSHZ6TnhOT2JsVk9zQmRm?=
 =?utf-8?B?TkhqNUc2aHlTOS9vd3A2c3l6b0xvOGpGN0YrdFl0TE5WNzBLQ2V3SjErUEs3?=
 =?utf-8?B?Z0FPem5oVGpjRVFBMU5WK0dpejJwamtHd3hXME9KMTc4YnVvL2h3c0o3NVpX?=
 =?utf-8?B?VDVHSnk5WmZqQ01MNUthajU1WDNKbnZ3N3NLdWwrQXJpUnJ4QUkzUDgzSjlr?=
 =?utf-8?B?WEZuOTlIaWVMZ3o4V25mZit3dGRPNWZXalpSTmpBSFR6a0Y3YTBRK3ZjUURE?=
 =?utf-8?B?V2dFSGpWMUlaeTlyVHUzQmNJTmxjbUxDbDU5b2Yya2FpZlR6ZUo0QTZSTnll?=
 =?utf-8?B?RVA3RnYzVm13R1o1VFBwbzlSTEtXbFFDdDE5UGI0TjFIZFdIU3J3V1h4MHJ3?=
 =?utf-8?B?b05CVXI3dVMzT1J5QndsSFdGb0c1RGIyeVBrb3pwRVUveG5FamJpYmJGUzB5?=
 =?utf-8?B?ZVFRZmxZTGtCd1NQU1hvWTF6TERGV3JkRi8xUGpwYktxNk83NU5KTEZydG9V?=
 =?utf-8?B?eGkyNVNzWEhkVjZKTEZ0alJveW1YNEZocTJxcEdLTmRXTkRvcEdYeEpzQ3FU?=
 =?utf-8?B?SHQyTHBqSS9BTy8yWmpYUjlHaWRNNlJEcER3NjZRUW02dytVY3kwejNqcEto?=
 =?utf-8?B?a0xYV1BPOThGdE5jRytJNGdtOExMRkU2R2MzUU5JS0hhTUZyVkd4TFpnSC9F?=
 =?utf-8?B?V3JEcmJWQitJWEozMVpHcE1ZeVJhQ0dlQ0E3V2kyRVJsaWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXdNeGJkMzBrUU9qcW9kdHU1L0phRExXNmx2cmE5Q0lLM1JqcTZoSmVTOTFH?=
 =?utf-8?B?YXpVNDRMQ25oN3d4bVV0L2ZMN2FXVHZkZTRPUlJtUHcrTCtLeGRXZjhTTVBv?=
 =?utf-8?B?RWVFTUs4NWFTbUE5cXlwenpRY01LWTF6YXlFbWRPTmV1YmZUb2JZbGpScXQx?=
 =?utf-8?B?N2xqVjlkRUQ1OGFKTW1RdDNqZjVhWjNnZVQxZVdpb3FJMFlBaVliM2syZW0y?=
 =?utf-8?B?WkY4TlhJVXRKYnpZVjN4bm5BeUdOUldKZS9zbHJ6R0Q5TkZYTVlxNGYyWkdZ?=
 =?utf-8?B?OTBsMVhoaXhkRHJlSExzc2JQWWJ4bGpSMGM0T2RrcFZWSnptakxxUzNOUjAy?=
 =?utf-8?B?UU5iWUZRUEtSN2hsWWJVZ3U5NVVHT1o4ejNEdHVmMU41SzN6TU5ZaDdnNFlJ?=
 =?utf-8?B?bSt5Q3NuN3VQWjc5M09PVythRGI5RXkrU3QyR1pBWHFYejYxQ2JNLzlKcnBh?=
 =?utf-8?B?L2dmelNhNFlYdVhuL3EvaU5HQmNSTE1zaGxTQk9MNW9hMmljdzAxSUVFa3M3?=
 =?utf-8?B?elNES0VCeDJlaUtoQlp0bXRMVGI0ZVgxMDdRTDBzTDFaR25oalRoQWxkS2py?=
 =?utf-8?B?a1I1UXNJR2NNVmhxUWc4czY3TjJDRmV0emdHYWRGbGNUVEdOSEJaYjRsdlBJ?=
 =?utf-8?B?OFJYd2tIejR1aFVlc2lQTm9RRG5XNllZSktjdnZUVUl2UHoxclp4TlU4ZVNS?=
 =?utf-8?B?VWovUUxobWxrdStvN2cvYXl3ZndXeVQ3RUNBNW9hSEYxaUZPSmpmM3lMeTh4?=
 =?utf-8?B?VlFXYnVtcUorbjNOV0tkay9pVVBzbmJkUzZsSkgrMGhPUkRiTnFaVWU5SWpF?=
 =?utf-8?B?YzJWWERFS3FITDFrbFFyTTZSYUsyZU9lMFNRQ0poR2x0REViVzZ1NlIzNVVq?=
 =?utf-8?B?ZW5ZSVNnbUlXVVdxWGROMHcxdFNQUWQxWEVTZlFOT0NhWmF2U3kzV2xSY214?=
 =?utf-8?B?NXZFLzU1RCs0endUbk9PZUdVWC9Qa013dDFkK2hqV1ZxSlVTS2J0Nm9EU2dq?=
 =?utf-8?B?OGRLQjl6ZjdENzdpdHZSS3hzT1lOSk9kTlpoc0xRMEREVDVGT3hkeWNSTDFx?=
 =?utf-8?B?eXlJd0VCa2htKzZtM3ZSU3o4Nlk4UENEejhpamNWTFdmQzU4dGNvdEtQc3pX?=
 =?utf-8?B?SmhxQXJHYnNNNkIvYzJXTU5YeVR3TDVlOFdMUUE3aUVmbHFNUWFMM2lYVS9R?=
 =?utf-8?B?U1plYlR3THpKcWgzT1NIdDVHK1FyTnBCaE5xMnpyemVyaWZPMzlZZnpETEN1?=
 =?utf-8?B?SEZ0WnQ3V2RiekJOYVhwY0x1Q2ErNkw3MlJ4ZXI0b0JGMXRSTzJYYTlNTHAz?=
 =?utf-8?B?aEUvdTE4UU5xRHo2VkRKbU16NXF2UEg0Q2J3c1dheEZWcEd1US9SVnp1bHVv?=
 =?utf-8?B?RGlXaXJVZjY3UWNINXNwTkRabXZSY1diUHNLeURKSjB0V1RCV2d6T3Z2M1BU?=
 =?utf-8?B?WVVDZXFyQmM3dG1keDAyS2JLcWt0czFpazdIZHh5MTZ6Z25waGJOekx0S3l6?=
 =?utf-8?B?NzdHTUd3Rll4RTRpWUE2MUhYbWhhWXZub3YwK1h6Qm9VUUNqOWpKanBMMFpm?=
 =?utf-8?B?VXpVcmpRTEp2djlWK0FnenpOd2k3K1FmcFhXRkRhNGZ6cHl6QVhlVDRsZGxl?=
 =?utf-8?B?VnF1d2J6N2hlVXpSU1FWZFFxbVRMWVpUSGRmSGFwSUc0R3lxWURqRHZ0Z096?=
 =?utf-8?B?dUg2MGZQc0xsRW1DN2lBK2dsT1FyeURIK2xXT0hwdlA0QllkbkdESEVJUDBR?=
 =?utf-8?B?ckNwT0E2Z28vOVljS29SNGM5aXNPYmlHWTc0c2hQOWkya3ZsWDZFRVI1eTNB?=
 =?utf-8?B?VTFCdGF1WCt2STM1RUdsOC95SHpDc0dVcWJVVkhZYVRJSUtDNmJ1TENLOWQ3?=
 =?utf-8?B?dzQzVkRnbE55Z2lha0lKOVdIbFpDMXBVZytibVZibi9VM2R3YVBIeHRjM2Jv?=
 =?utf-8?B?Tmw3N3NsSVYwamVvOTg0bVBzOUFrUXhzWkh4QUU0aXIvU3VjeWt0QjgyTGNo?=
 =?utf-8?B?cis5QzFOL2JYNzlLMmZXaEhobGc1alh6bzlQNHVNa2JCcXQrdjZvWWVTTXI4?=
 =?utf-8?B?aU5vTGM4SG5DaktWbWxJWkZoQ0JSZmdsWmVFSHB6eGJtYVR1VFh3TG11dUZ0?=
 =?utf-8?B?QTVJOSt4Tks1VGJPWDBaRktpbldpb1NYbVlwOXB2ZWMzSmlDN2h5NExDS1ZV?=
 =?utf-8?B?cXNnaklQZ0xWVGVPc1lQVnN6NzlsaElYQTgzcy9oZ2FZeDVCSGUrMzBCOTVX?=
 =?utf-8?B?TTZoQjAyRVNIUU1UUExtK3JNbFNnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a42939-ddd7-4f51-d5f1-08dcbc883d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 17:40:50.6360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXgUmauMojj17+7PRCiSSs7S9rF4fw4MFZhCRVuxLk/fPAksN8K5APR2gfxK/dH5ClaRSKR6mCnEYXtX5HUAJPIxFV0qL1lrNtBLKAoRQ4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6996
X-OriginatorOrg: intel.com

SGkgQmFycnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFycnkg
U29uZyA8MjFjbmJhb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE0LCAy
MDI0IDEyOjQ5IEFNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRo
YXJAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
bW1Aa3ZhY2sub3JnOw0KPiBoYW5uZXNAY21weGNoZy5vcmc7IHlvc3J5YWhtZWRAZ29vZ2xlLmNv
bTsgbnBoYW1jc0BnbWFpbC5jb207DQo+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWlu
ZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsg
Wm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8
d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBp
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxIDIvNF0gbW06IHZtc3RhdDog
UGVyIG1USFAtc2l6ZSB6c3dhcF9zdG9yZQ0KPiB2bXN0YXQgZXZlbnQgY291bnRlcnMuDQo+IA0K
PiBPbiBXZWQsIEF1ZyAxNCwgMjAyNCBhdCA2OjI44oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFyDQo+
IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZGVkIHZt
c3RhdCBldmVudCBjb3VudGVycyBwZXIgbVRIUC1zaXplIHRoYXQgY2FuIGJlIHVzZWQgdG8gYWNj
b3VudA0KPiA+IGZvciBmb2xpb3Mgb2YgZGlmZmVyZW50IHNpemVzIGJlaW5nIHN1Y2Nlc3NmdWxs
eSBzdG9yZWQgaW4gWlNXQVAuDQo+ID4NCj4gPiBGb3IgdGhpcyBSRkMsIGl0IGlzIG5vdCBjbGVh
ciBpZiB0aGVzZSB6c3dwb3V0IGNvdW50ZXJzIHNob3VsZCBpbnN0ZWFkDQo+ID4gYmUgYWRkZWQg
YXMgcGFydCBvZiB0aGUgZXhpc3RpbmcgbVRIUCBzdGF0cyBpbg0KPiA+IC9zeXMva2VybmVsL21t
L3RyYW5zcGFyZW50X2h1Z2VwYWdlL2h1Z2VwYWdlcy0qa0Ivc3RhdHMuDQo+ID4NCj4gPiBUaGUg
Zm9sbG93aW5nIGlzIGFsc28gYSB2aWFibGUgb3B0aW9uLCBzaG91bGQgaXQgbWFrZSBiZXR0ZXIg
c2Vuc2UsDQo+ID4gZm9yIGluc3RhbmNlLCBhczoNCj4gPg0KPiA+IC9zeXMva2VybmVsL21tL3Ry
YW5zcGFyZW50X2h1Z2VwYWdlL2h1Z2VwYWdlcy0qa0Ivc3RhdHMvenN3cG91dC4NCj4gPg0KPiA+
IElmIHNvLCB3ZSB3b3VsZCBiZSBhYmxlIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gbVRIUCB6c3dh
cCBhbmQNCj4gPiBub24tenN3YXAgc3dhcG91dHMgdGhyb3VnaDoNCj4gPg0KPiA+IC9zeXMva2Vy
bmVsL21tL3RyYW5zcGFyZW50X2h1Z2VwYWdlL2h1Z2VwYWdlcy0qa0Ivc3RhdHMvenN3cG91dA0K
PiA+DQo+ID4gYW5kDQo+ID4NCj4gPiAvc3lzL2tlcm5lbC9tbS90cmFuc3BhcmVudF9odWdlcGFn
ZS9odWdlcGFnZXMtKmtCL3N0YXRzL3N3cG91dA0KPiA+DQo+ID4gcmVzcGVjdGl2ZWx5Lg0KPiA+
DQo+ID4gQ29tbWVudHMgd291bGQgYmUgYXBwcmVjaWF0ZWQgYXMgdG8gd2hpY2ggYXBwcm9hY2gg
aXMgcHJlZmVyYWJsZS4NCj4gDQo+IEV2ZW4gdGhvdWdoIHN3YXBvdXQgbWlnaHQgZ28gdGhyb3Vn
aCB6c3dhcCwgZnJvbSB0aGUgcGVyc3BlY3RpdmUgb2YNCj4gdGhlIG1tIGNvcmUsIGl0IHNob3Vs
ZG4ndCBiZSBhd2FyZSBvZiB0aGF0LiBTaG91bGRuJ3QgenN3cG91dCBiZSBwYXJ0DQo+IG9mIHN3
cG91dD8gV2h5IGFyZSB0aGV5IHNlcGFyYXRlPyBubyBtYXR0ZXIgaWYgYSBtVEhQIGhhcyBiZWVu
DQo+IHB1dCBpbiB6c3dhcCwgaXQgaGFzIGJlZW4gc3dhcHBlZC1vdXQgdG8gbW0tY29yZT8gTm8/
DQoNClRoYW5rcyBmb3IgdGhlIGNvZGUgcmV2aWV3IGNvbW1lbnRzLiBUaGlzIGlzIGEgZ29vZCBw
b2ludC4gSSB3YXMga2VlcGluZyBpbg0KbWluZCB0aGUgY29udmVudGlvbiB1c2VkIGJ5IGV4aXN0
aW5nIHZtc3RhdCBldmVudCBjb3VudGVycyB0aGF0IGRpc3Rpbmd1aXNoDQp6c3dwb3V0L3pzd3Bp
biBmcm9tIHBzd3BvdXQvcHN3cGluIGV2ZW50cy4NCg0KSWYgd2Ugd2FudCB0byBrZWVwIHRoZSBk
aXN0aW5jdGlvbiBpbiBtVEhQIHN3YXBvdXRzLCB3b3VsZCBhZGRpbmcgYQ0Kc2VwYXJhdGUgTVRI
UF9TVEFUX1pTV1BPVVQgdG8gImVudW0gbXRocF9zdGF0X2l0ZW0iIGJlIE9rPw0KDQpJbiBhbnkg
Y2FzZSwgaXQgbG9va3MgbGlrZSBhbGwgdGhhdCB3b3VsZCBiZSBuZWVkZWQgaXMgYSBjYWxsIHRv
DQpjb3VudF9tdGhwX3N0YXQoZm9saW9fb3JkZXIoZm9saW8pLCBNVEhQX1NUQVRfW1pdU1dQT1VU
KSBpbiB0aGUNCmdlbmVyYWwgY2FzZS4NCg0KSSB3aWxsIG1ha2UgdGhpcyBjaGFuZ2UgaW4gdjIs
IGRlcGVuZGluZyBvbiB3aGV0aGVyIG9yIG5vdCB0aGUNCnNlcGFyYXRpb24gb2YgenN3cG91dCB2
cy4gbm9uLXpzd2FwIHN3cG91dCBpcyByZWNvbW1lbmRlZCBmb3INCm1USFAuDQoNCj4gDQo+IA0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNy
aWRoYXJAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3ZtX2V2ZW50X2l0
ZW0uaCB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICBtbS92bXN0YXQuYyAgICAgICAgICAgICAg
ICAgICB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZtX2V2ZW50X2l0
ZW0uaA0KPiBiL2luY2x1ZGUvbGludXgvdm1fZXZlbnRfaXRlbS5oDQo+ID4gaW5kZXggNzQ3OTQz
YmM4Y2MyLi4yNDUxYmNmY2YwNWMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92bV9l
dmVudF9pdGVtLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZtX2V2ZW50X2l0ZW0uaA0KPiA+
IEBAIC0xMTQsNiArMTE0LDkgQEAgZW51bSB2bV9ldmVudF9pdGVtIHsgUEdQR0lOLCBQR1BHT1VU
LA0KPiBQU1dQSU4sIFBTV1BPVVQsDQo+ID4gICAgICAgICAgICAgICAgIFRIUF9aRVJPX1BBR0Vf
QUxMT0MsDQo+ID4gICAgICAgICAgICAgICAgIFRIUF9aRVJPX1BBR0VfQUxMT0NfRkFJTEVELA0K
PiA+ICAgICAgICAgICAgICAgICBUSFBfU1dQT1VULA0KPiA+ICsjaWZkZWYgQ09ORklHX1pTV0FQ
DQo+ID4gKyAgICAgICAgICAgICAgIFpTV1BPVVRfUE1EX1RIUF9GT0xJTywNCj4gPiArI2VuZGlm
DQo+ID4gICAgICAgICAgICAgICAgIFRIUF9TV1BPVVRfRkFMTEJBQ0ssDQo+ID4gICNlbmRpZg0K
PiA+ICAjaWZkZWYgQ09ORklHX01FTU9SWV9CQUxMT09ODQo+ID4gQEAgLTE0Myw2ICsxNDYsMTgg
QEAgZW51bSB2bV9ldmVudF9pdGVtIHsgUEdQR0lOLCBQR1BHT1VULA0KPiBQU1dQSU4sIFBTV1BP
VVQsDQo+ID4gICAgICAgICAgICAgICAgIFpTV1BJTiwNCj4gPiAgICAgICAgICAgICAgICAgWlNX
UE9VVCwNCj4gPiAgICAgICAgICAgICAgICAgWlNXUFdCLA0KPiA+ICsgICAgICAgICAgICAgICBa
U1dQT1VUXzRLQl9GT0xJTywNCj4gPiArI2lmZGVmIENPTkZJR19USFBfU1dBUA0KPiA+ICsgICAg
ICAgICAgICAgICBtVEhQX1pTV1BPVVRfOGtCLA0KPiA+ICsgICAgICAgICAgICAgICBtVEhQX1pT
V1BPVVRfMTZrQiwNCj4gPiArICAgICAgICAgICAgICAgbVRIUF9aU1dQT1VUXzMya0IsDQo+ID4g
KyAgICAgICAgICAgICAgIG1USFBfWlNXUE9VVF82NGtCLA0KPiA+ICsgICAgICAgICAgICAgICBt
VEhQX1pTV1BPVVRfMTI4a0IsDQo+ID4gKyAgICAgICAgICAgICAgIG1USFBfWlNXUE9VVF8yNTZr
QiwNCj4gPiArICAgICAgICAgICAgICAgbVRIUF9aU1dQT1VUXzUxMmtCLA0KPiA+ICsgICAgICAg
ICAgICAgICBtVEhQX1pTV1BPVVRfMTAyNGtCLA0KPiA+ICsgICAgICAgICAgICAgICBtVEhQX1pT
V1BPVVRfMjA0OGtCLA0KPiA+ICsjZW5kaWYNCj4gDQo+IFRoaXMgaW1wbGVtZW50YXRpb24gaGFy
ZGNvZGVzIGFzc3VtcHRpb25zIGFib3V0IHRoZSBwYWdlIHNpemUgYmVpbmcgNEtCLA0KPiBidXQg
cGFnZSBzaXplcyBjYW4gdmFyeSwgYW5kIHNvIGNhbiB0aGUgVEhQIG9yZGVycz8NCg0KQWdyZWVk
LCB3aWxsIGFkZHJlc3MgaW4gdjIuDQoNCj4gDQo+ID4gICNlbmRpZg0KPiA+ICAjaWZkZWYgQ09O
RklHX1g4Ng0KPiA+ICAgICAgICAgICAgICAgICBESVJFQ1RfTUFQX0xFVkVMMl9TUExJVCwNCj4g
PiBkaWZmIC0tZ2l0IGEvbW0vdm1zdGF0LmMgYi9tbS92bXN0YXQuYw0KPiA+IGluZGV4IDg1MDdj
NDk3MjE4Yi4uMGU2NmM4YjBjNDg2IDEwMDY0NA0KPiA+IC0tLSBhL21tL3Ztc3RhdC5jDQo+ID4g
KysrIGIvbW0vdm1zdGF0LmMNCj4gPiBAQCAtMTM3NSw2ICsxMzc1LDkgQEAgY29uc3QgY2hhciAq
IGNvbnN0IHZtc3RhdF90ZXh0W10gPSB7DQo+ID4gICAgICAgICAidGhwX3plcm9fcGFnZV9hbGxv
YyIsDQo+ID4gICAgICAgICAidGhwX3plcm9fcGFnZV9hbGxvY19mYWlsZWQiLA0KPiA+ICAgICAg
ICAgInRocF9zd3BvdXQiLA0KPiA+ICsjaWZkZWYgQ09ORklHX1pTV0FQDQo+ID4gKyAgICAgICAi
enN3cG91dF9wbWRfdGhwX2ZvbGlvIiwNCj4gPiArI2VuZGlmDQo+ID4gICAgICAgICAidGhwX3N3
cG91dF9mYWxsYmFjayIsDQo+ID4gICNlbmRpZg0KPiA+ICAjaWZkZWYgQ09ORklHX01FTU9SWV9C
QUxMT09ODQo+ID4gQEAgLTE0MDUsNiArMTQwOCwxOCBAQCBjb25zdCBjaGFyICogY29uc3Qgdm1z
dGF0X3RleHRbXSA9IHsNCj4gPiAgICAgICAgICJ6c3dwaW4iLA0KPiA+ICAgICAgICAgInpzd3Bv
dXQiLA0KPiA+ICAgICAgICAgInpzd3B3YiIsDQo+ID4gKyAgICAgICAienN3cG91dF80a2JfZm9s
aW8iLA0KPiA+ICsjaWZkZWYgQ09ORklHX1RIUF9TV0FQDQo+ID4gKyAgICAgICAibXRocF96c3dw
b3V0XzhrYiIsDQo+ID4gKyAgICAgICAibXRocF96c3dwb3V0XzE2a2IiLA0KPiA+ICsgICAgICAg
Im10aHBfenN3cG91dF8zMmtiIiwNCj4gPiArICAgICAgICJtdGhwX3pzd3BvdXRfNjRrYiIsDQo+
ID4gKyAgICAgICAibXRocF96c3dwb3V0XzEyOGtiIiwNCj4gPiArICAgICAgICJtdGhwX3pzd3Bv
dXRfMjU2a2IiLA0KPiA+ICsgICAgICAgIm10aHBfenN3cG91dF81MTJrYiIsDQo+ID4gKyAgICAg
ICAibXRocF96c3dwb3V0XzEwMjRrYiIsDQo+ID4gKyAgICAgICAibXRocF96c3dwb3V0XzIwNDhr
YiIsDQo+ID4gKyNlbmRpZg0KPiANCj4gVGhlIGlzc3VlIGhlcmUgaXMgdGhhdCB0aGUgbnVtYmVy
IG9mIFRIUCBvcmRlcnMNCj4gY2FuIHZhcnkgYWNyb3NzIGRpZmZlcmVudCBwbGF0Zm9ybXMuDQoN
CkFncmVlZCwgd2lsbCBhZGRyZXNzIGluIHYyLg0KDQpUaGFua3MsDQpLYW5jaGFuYQ0KDQo+IA0K
PiA+ICAjZW5kaWYNCj4gPiAgI2lmZGVmIENPTkZJR19YODYNCj4gPiAgICAgICAgICJkaXJlY3Rf
bWFwX2xldmVsMl9zcGxpdHMiLA0KPiA+IC0tDQo+ID4gMi4yNy4wDQo+ID4NCj4gDQo+IFRoYW5r
cw0KPiBCYXJyeQ0K


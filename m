Return-Path: <linux-kernel+bounces-303938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A61961723
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC49A1C2334C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C492B1D27B1;
	Tue, 27 Aug 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVg5NIaV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3BA84D34
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784207; cv=fail; b=OxXifkytECE0zrIxumzfhlXNVwRb7mBQGOkmyoS7eqrxBF2y+hCpPYVKI99eOv+L/t9NzbmOcMknBlK6+rmYreG8+NpPbHGj4kb0AhecEnrVY+typC909zZbuHfxvWi7ScZ0Ktq9oDSeLqbnG1fNZYiozOceR8QFq2S3mJhfcqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784207; c=relaxed/simple;
	bh=YlqP97RHPxjyZrarjZcxycVU8xzEFU9L73u5HJ6XxG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=boE1VspmK0eoE/u4vcPeUtyh4bmalIhP78jl6c7ZHtDJD7s0fFp8ndKmD79FgUURZP6g/nVK39V02/5F9JU1fPZvy2Dg0R/oqf3qNFBm0wC+P+eg5cdNo2Z/EJMiNaqsUlUxzEV88y7Eb8GpMei3+taxlJCu7CZBa9UJUFr4POM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVg5NIaV; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724784206; x=1756320206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YlqP97RHPxjyZrarjZcxycVU8xzEFU9L73u5HJ6XxG4=;
  b=CVg5NIaV9gwqF/slI1MaXq5/+0H/FclfcT1JZtln4ODPNvL4q8wUynZn
   xUJJe7kJN7pN4z6lQznf76/EaoVnOtXhvraFW6tqUMZEXWNSCsfyjF4Ox
   zRkzgymSDhM2hZKWF6b75JKf4zzLJ6NoqDQ4y8HQgN27Lvw/TvKhloid0
   yTzOHo+iZZ6F+kTGEuLkEM4lN6DYKirBYvcjL7jWBD8gIGWZRxIj2UuzF
   5Z+RbMwszU5rI19s82tFo5xhv266kA/bP6jXl3/v5sRPuV2Od0oZspECH
   rJ7vb6+kguO2dsX16poCyv2zsORZnXqrtekUVFILA9omZKD+RBiXsl6Sw
   A==;
X-CSE-ConnectionGUID: NKpTypQ0Rjix1RJcP/3nnA==
X-CSE-MsgGUID: WHMu/BsjRXyaDgqxp+DOyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34692782"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34692782"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 11:43:24 -0700
X-CSE-ConnectionGUID: C1pNXJNxS9+5aQbJHtJN9A==
X-CSE-MsgGUID: WBvefZ6VQbiuyTT7Oewe/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67782348"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 11:43:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 11:43:23 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 11:43:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 11:43:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 11:43:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQbk5dxcW2hEjaE0pAR+2DyJhquiCC0kG0mlASac6aJlhl7GsPGxGzTsxt/gTEcixKmiA2swA2iHjvOkvFVZmSQt9L7RnCrYMTQGRboOA9q4oYYeMziO8SiCPzR3Wh2zKcRlSrz18/dimLtrxFapyRCIgf6IjqEe1/ypQ9lJqOzRgp9lBPrDDQVbHP7NkmJAvJIoFSm7wb8fmQAWyPNuQrt/v/VRITJt/fdSjlENG7Ha7QU2GOJxRyoz2buimvheedQJtBfntViJ5HmIBVrJwsChvvJqxCaIpRTXI+Eq9CkIFE02/nINDwZh0laOTql/ee8q/NogcIyUF3ZNgelw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlqP97RHPxjyZrarjZcxycVU8xzEFU9L73u5HJ6XxG4=;
 b=kYHThRJJIQZk5DygkvZVntaPDTi2TOw8MW1gsY8OS/ICPXzCJ69tiQGH4PJ6Nd00gxUmPCxN1D5teMDQCJGizAxFqs2MSHIof5oVgvwpNDigTFkOq7KVObEXBZVMDcCpdFOxinj5ugUxOmARGLqQHAkwwdaRHFd5Ajht6Gq46iqiY7eWm/qm8tsaqd2z1XOnk/fazsHeIwBb7rwqMc5kX3sghklUUrC/fTjmxUJ+OyLShSViotNw1aOXptcS0fFBFm5p07CGeNTKLqb3eAJGiKPm7t58uuJDzGjc6TdlFZznnDNL3ejRJaoyjOawkxt7OOvQo4evCyGcKmbZ37oQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5671.namprd11.prod.outlook.com (2603:10b6:8:3c::24) by
 DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Tue, 27 Aug 2024 18:43:20 +0000
Received: from DM8PR11MB5671.namprd11.prod.outlook.com
 ([fe80::8271:3a1e:8c5c:5641]) by DM8PR11MB5671.namprd11.prod.outlook.com
 ([fe80::8271:3a1e:8c5c:5641%5]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 18:43:20 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa8d3OD+uOh/WK5kyI6A6kVnXGhrIxzReAgABJIZCAA+ChsIADqWIAgABIr/CAAV2VgIAAAcEAgAA1wMA=
Date: Tue, 27 Aug 2024 18:43:20 +0000
Message-ID: <DM8PR11MB5671177E56AB8064336284E3C9942@DM8PR11MB5671.namprd11.prod.outlook.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
 <SJ0PR11MB5678288EE890E8CB882839CDC98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB567801EE747E2810EF183C73C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=PYv4Cn_a7WSnbUyhwSBO61xoDPSexXxS0uwwxu5P6XLw@mail.gmail.com>
 <SJ0PR11MB5678E44062CADBE8BAB546F3C9942@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=ORuJabxQSehU5E0QNG=Gx6QkyTCb1vek3AOcQuvF54Xg@mail.gmail.com>
 <CAKEwX=MPM8v6WZ3XUD11MkZceo7Y82C0pMTwLJuZX67Wo27WbA@mail.gmail.com>
In-Reply-To: <CAKEwX=MPM8v6WZ3XUD11MkZceo7Y82C0pMTwLJuZX67Wo27WbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5671:EE_|DM6PR11MB4516:EE_
x-ms-office365-filtering-correlation-id: 597ac6e7-3a40-48bf-43d2-08dcc6c81f84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVVEMjhnamgyTm1lODA4bnFDNnNNNng4S1lYcFJuVmUwRUYvWmlRMWJ5bTc5?=
 =?utf-8?B?Q2llT2E2cXBvaHMzN29vRU5QU043M2pIQXcvZ2VTam13NVhmSm1tdElYbDR2?=
 =?utf-8?B?QmhDRk1YaVpkcWdiaUJpSnRvMmlkTDN5VEJJM29CdTQySlkrU3phT1JkSXZY?=
 =?utf-8?B?ZnlqUUdPSlVVdjlUbW9xcHlRR0RzTzBmMFAvaDlBRjJqcEhXaVB0bXhkN0xv?=
 =?utf-8?B?Qk0rNWFvTDEvTVdwYlNkZDMzYlEvOEE1L1hxRU5OMkxsYTlUWWI0MjMyZjM0?=
 =?utf-8?B?ODhxN1J2N2t0c2p2QllpWExyWStRMk9haVl6enhJdjYvckhmOXl4SE03ZDhm?=
 =?utf-8?B?ejR3aTVkKzBXcW5Dc1ZLMS84eVJkYUdEU0VBMlZsQlJHR3FXSnVwTmg3Sm9O?=
 =?utf-8?B?dUZqdTJSU1ZtZEcvTFQ2b0VZS3FwWnhVSjlwbGdLMWtHWVUzMHJZQWtrQnMz?=
 =?utf-8?B?NUpTUzd0SmtoVnF6RmtqUlp4c3RqOERoVmJoWUlCUktxZnA2MGF5cmxxRTZj?=
 =?utf-8?B?REdoMy9uWE8vMFcrbDh1V0lDS21ZMDlEektaWkd2RVk3TUxWU3BBT0pwUGk5?=
 =?utf-8?B?N2FNRDQvYnNDS0lBbXoyRzlMamtNTDFmUXN6RjFGYWZYY3RzSG9iMWVwcjV6?=
 =?utf-8?B?ZFdGdE83Y0x5eXJwelF3RFgzYkNLYnZzaDZxK2RudkRzR2hxOSt5eEh6YlMz?=
 =?utf-8?B?dWJQVXN2ZEVRanpEQ1RIU0h2VzRLTXNYMmVQNFZDTUMyNUxBQklMMkVFei9B?=
 =?utf-8?B?anR4UjNHSWRJaDMwdjdiVW84M2xQZ1dDZUloL01CRWZxSDk5M0ljckxqWVJu?=
 =?utf-8?B?RFlUcmppandCMHJkOTU0U0llYkNVbVRlYWxrNTltSG1zTkxnQnhNbW12SEg1?=
 =?utf-8?B?NmljNi9mcFVIbS90RDdKcG50dmNDKzJVOERJMnVlQmM0di9VdXR5VWZhay8y?=
 =?utf-8?B?WERsYzRkNTRITm1aa1JOR1FKNERpR2MySFkxdmVoUHRjbWc5b2hVSkFWaWtR?=
 =?utf-8?B?eEhMMTJQWk83eXpPWDN2MDdhT0ZnSGFDaWY3dm1UbSs0TnVaMUZVQmc1VnNX?=
 =?utf-8?B?Lzg1NUs2ZFBzWHEzT3ltR0d3TXVUZ0tnbi9ySkEvcjhkc0ZYMDdHK3ZEUEJT?=
 =?utf-8?B?enpRQVlhMndvaU1Rb29ZWmozdGFlK3dVYVZqbE43WFNaV1cwdWFZN0dOTkEr?=
 =?utf-8?B?ZDM5SUhYMnZqL2pvd01TYWN6RzhQMVIvMFVsZklGc09hOS9kaUc3NzRCWFhO?=
 =?utf-8?B?OHlMbFNJem5pL0lVUWN0T1kyTFFyQzh2RnpGdExISVFibXE5MmlFV2FadFUr?=
 =?utf-8?B?MWF4K202cGR0Y0xxZkJUUHM4UUcySHk1NFZ1QzZielV6UEgxcVc5bzNMOVVY?=
 =?utf-8?B?Nm1lODRXWFEvd2Y1NDZDOERuRktzcS80YittR0JyOGhsQ3NWZkk3NXJEc0pN?=
 =?utf-8?B?QlBXN29CMFdMR20vZlN5RGNJK3VUUmZpb3VjdnlwbnhXWXNIK05Scks3bndL?=
 =?utf-8?B?c0YrRzY5c05wZXJpYXh3Q0NkQk1XRjYrRHhEQ1FHNzlmZ2o3U0IvN2cvTUlB?=
 =?utf-8?B?djJodDFuVWsvVUN0RTg3dVNMWmZQRmNiSzlMMFA0V2hCOGFLa05ia0FLcGYr?=
 =?utf-8?B?NmtPM3RKSWIzMjFlaVJRbW9hbFpGb2pIcy9zaFdRd29OMHJERUFNd3NaR2dt?=
 =?utf-8?B?UzFRUmM5WG1wSEdWRnkxbUxMRjdhQ0VVOXI4TnRkRS9zZWpoQ2c0VUZUQnh0?=
 =?utf-8?B?Yk9NZUUwRjFnTEQxN0FpbTRsNGUrUnhlelhZdjAyY1lvZHFGcFFRa2c5OVZo?=
 =?utf-8?B?N3lXK2NKYjZqVHEzOUVQRGZnVzNSQ1U2MnArZ2ZOK2JZaHJlQ3Y4cDlHb3RJ?=
 =?utf-8?B?NHV6K1pmbGF3SnE4ejZxV3hWdVZmS0IrUUNKK3hGUlp3SXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck1DUlMrSG5uWERmZ0FBSitndGRveW9JSjBOa1FBRGR2alBQYkUzRldhVFMr?=
 =?utf-8?B?cEdVdGVEb2lrL2tqbjl3RkxPU28rdkJheGxXeVFrWUFTTHBaZTEvYnB6bWtF?=
 =?utf-8?B?VWFWaThqQ1FNbjkrY1R1YWMwemRvZ0RCZnhQSjF6NEhlTmJyRXFlaFN1KzFB?=
 =?utf-8?B?a29idUtYUVEwYzBTZzFzUEFqK1pJWHNhdmxBMFJRdGs0a3Q2bE1ZNlBLcnh1?=
 =?utf-8?B?RkVLdUo5OFVyU3hSakhwUWdseHpOanZQLzVOazloVnpMc2U0djJpUlFZbHd2?=
 =?utf-8?B?L0h3OUFsTjBFZ3Irc0tlcXpsYktZL3ZPRG1oanBxQnlsai9kTFJMNzI4Nkdq?=
 =?utf-8?B?MTN0T3hUWU5GZm5vRzkzZGpsQWRhSDE1ck5qWDZldmoxWVlac1JTdy9FV3dT?=
 =?utf-8?B?Y1I2Q1Z6UUl3VzRXUmJDZjQ5N3pZL1htT3pLdEx0bDFlZXI3bWtRN1V4b3p1?=
 =?utf-8?B?emVsOHBSYWhUcmtoMUFXUTlHTEM3dlBuWlJ2V0dqcnNGbDE2ZDNsdEF4OVJN?=
 =?utf-8?B?eE92SWg4eTJzSjQ1WjdWa053TnhBWGtaMTF1Q21zSHFsV05PNHBZV0dybldD?=
 =?utf-8?B?SDJ5NlhJNnlGeTBGZHpIUTR6Yi9ycXdXWGNoUXdnVVRwTFg5cUpycWlJa245?=
 =?utf-8?B?R0l6V3Y0VUFDQktIUmtkMnhhRDFlbjBjOG9tZHYvZXNLVHhuL0ViTHFheGp4?=
 =?utf-8?B?UkJDaGlqSjN4Uy9Cb2xmL3pENVErODFCa1Irc0tzR2RwRGZZUXplOEMzd2Y1?=
 =?utf-8?B?cUpwMVpvbzJTMjhOOW1kcmNEK1V1RXprajFYTTFGaXU1MHVRQXAxWjVaR3A0?=
 =?utf-8?B?eFNUT1YrVytzeFRNYXdjWUZXYjZkbmVsaEFFeitYT0hrTkRqcVk4bnBTbW9W?=
 =?utf-8?B?S3dGT0UzYXBmZEhlQkhjYjFrRGtlTzE2cVhTN00xSU95R0REQVR2NDlaOWZZ?=
 =?utf-8?B?cUtkUUtTSmsveUhUMVQ1MWpFbnUvUEJyRjIxNWE2aGI4L1J4UHZvYWdVOEJX?=
 =?utf-8?B?RHJGcXVZTFZTTVJtSEozdU9tVzRaQVlqSU1mbnVRNlJUWktIUjBzTHQ3QkI2?=
 =?utf-8?B?VHQ4UjZGTnIzVTdZb3Myb3N5M2FmRWU1amM3RS9aeFVDcGJpcGFqMWROQjFx?=
 =?utf-8?B?ekhGL0JSQnFiR09obEZYanFUWWwwODAxdG5jVFBCcFFBTTlLeThwSm9XQVBT?=
 =?utf-8?B?TVoxaWxrU0wxM2RjNHBzTjNOK0hzNGp2TVZyblNIN3pWbXFnM24xRkt5Rlht?=
 =?utf-8?B?L3VRQXBDWTVQL2V4Z2twc21oRkJPbHJXZkZsbzAyOUUrU01TYlVSTkt0OUJ0?=
 =?utf-8?B?ckh3aVEya2o3UTg2STlOK040VENFc0pyNUhVMi9aTTVTYTVuQmJRV3J4NDdw?=
 =?utf-8?B?emNJL0tjWjhRRUFpa2V3bFlValhhbGllRVE4RUdPdGhHVVBJVE9PVk5uRVg5?=
 =?utf-8?B?RE9XZ1owbTZDa3V6YXR0VjhpYThtdE8rcnBLb0pzcFkwVU56ekpKMDNUYklV?=
 =?utf-8?B?UGNPQ1plL2ZrL1NCb1ROYXRaMGpBZVF5aHRibndpQTh6bDI1M28rYjd5QW5F?=
 =?utf-8?B?ak81OXFkWUtqbk5kcmNvM3MxOHJzazVwbXkvcDJtNEJKSEFOcFR5ejljT2li?=
 =?utf-8?B?eDh3QTdVa0hMSGRqV3JhZzB4UXRzcGpvdWplMloyQmg0VUc4NTZoMW5NSTRP?=
 =?utf-8?B?blRLZVV2OEYxU2JibUZRR3Q3c3BSSXM3M0ZoUEJaNng4RXhhSnQ2NHpTcWta?=
 =?utf-8?B?SmoyamFBRXRmVFl6dTRLV3pGQXErU1dUZ2ZtUVJld09XTU5WMUplei8vSkZD?=
 =?utf-8?B?QTcrakZlT0p6YkJsdnJmSWh2WVVGSXVWT0l2TjllNVMzMGpMd25EQWpQUy80?=
 =?utf-8?B?bEpNVkZ2RE9vNUNSaUhzSUVIVnY3a0NYaldOSU5Ha3B3Y2gxREF0TkQzOU1L?=
 =?utf-8?B?a3JsZjl1Nndla3Z2cUd2SnIyUEVEQnlaQ0pUSURxdHpUUHh6aENFZXU4ZHYr?=
 =?utf-8?B?RGJNcW5RYVVqdGJGbXgwNGJSTjZINWZDRjZOTU1GcStjcUZrTzVUTXc1SXda?=
 =?utf-8?B?MkZKT1ZYcjllMEI1Ym9RNXM2QWxGOGMyMkxFUDJmcVBWTVpBSjBKUUc4d0JM?=
 =?utf-8?B?MkRPVWQwMnBzM25TUzdtbGIwZjNIaDU0ZGQ4L2p3QVhVSythaXNxbWRWMUta?=
 =?utf-8?B?aHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 597ac6e7-3a40-48bf-43d2-08dcc6c81f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 18:43:20.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4+ayaEzHcPtOjegYhIq3HLQ5ESOPiv4qb7Lux/Bo3jbGkeHTPcut0/57LGR1kS8tU5xm2ZUJK6mNJbJ2lrP//bsXEhKXYiOCseO3bYVD/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNywgMjAyNCA4OjMwIEFNDQo+
IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0K
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0K
PiBoYW5uZXNAY21weGNoZy5vcmc7IHlvc3J5YWhtZWRAZ29vZ2xlLmNvbTsgcnlhbi5yb2JlcnRz
QGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9A
Z21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgWm91LCBOYW5oYWkgPG5h
bmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxp
QGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC80XSBtbTogWlNXQVAgc3dhcC1vdXQgb2YgbVRIUCBmb2xp
b3MNCj4gDQo+IE9uIFR1ZSwgQXVnIDI3LCAyMDI0IGF0IDg6MjPigK9BTSBOaGF0IFBoYW0gPG5w
aGFtY3NAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIE1vbiwgQXVnIDI2LCAyMDI0IGF0
IDExOjA44oCvUE0gU3JpZGhhciwgS2FuY2hhbmEgUA0KPiA+IDxrYW5jaGFuYS5wLnNyaWRoYXJA
aW50ZWwuY29tPiB3cm90ZToNCj4gPiBZZWFoIHRoYXQncyBhIGJpdCB1bmZhaXIgc3RpbGwuIFdp
bGQgaWRlYSwgYnV0IHdoYXQgYWJvdXQgd2UgY29tcGFyZQ0KPiA+IFNTRCB3aXRob3V0IHpzd2Fw
IChvciBTU0Qgd2l0aCB6c3dhcCwgYnV0IHdpdGhvdXQgdGhpcyBwYXRjaCBzZXJpZXMgc28NCj4g
PiB0aGF0IG1USFAgYXJlIG5vdCB6c3dhcHBlZCkgdi5zIHpzd2FwLW9uLXpyYW0gKGkuZSB3aXRo
IGEgYmFja2luZw0KPiA+IHN3YXBmaWxlIG9uIHpyYW0gYmxvY2sgZGV2aWNlKS4NCj4gPg0KPiA+
IEl0IGlzIHN0dXBpZCwgSSBrbm93LiBCdXQgbGV0J3MgdGFrZSBhZHZhbnRhZ2Ugb2YgdGhlIGZh
Y3QgdGhhdCB6cmFtDQo+ID4gaXMgbm90IGNoYXJnZWQgdG8gY2dyb3VwLCBwcmV0ZW5kaW5nIHRo
YXQgaXRzIG1lbW9yeSBmb290IHByaW50IGlzDQo+ID4gZW1wdHk/DQo+ID4NCj4gPiBJIGRvbid0
IGtub3cgaG93IHpyYW0gd29ya3MgdGhvdWdoLCBzbyBteSBhcG9sb2dpZXMgaWYgaXQncyBhIHN0
dXBpZA0KPiA+IHN1Z2dlc3Rpb24gOikNCj4gDQo+IE9oIG52bSwgbG9va3MgbGlrZSB0aGF0J3Mg
d2hhdCB5b3UncmUgYWxyZWFkeSBkb2luZy4NCj4gDQo+IFRoYXQgc2FpZCwgdGhlIGx6NCBjb2x1
bW4gaXMgc29vb28gYmFkIHN0aWxsLCB3aGVyZWFzIHRoZSBkZWZsYXRlLWlhYQ0KPiBjbGVhcmx5
IHNob3dzIGltcHJvdmVtZW50ISBUaGlzIG1lYW5zIGl0IGNvdWxkIGJlDQo+IGNvbXByZXNzb3It
ZGVwZW5kZW50Lg0KPiANCj4gQ2FuIHlvdSB0cnkgaXQgd2l0aCB6c3RkPw0KDQpTdXJlLCBJIHdp
bGwgZ2F0aGVyIGRhdGEgd2l0aCB6c3RkLg0KDQpUaGFua3MsDQpLYW5jaGFuYQ0KDQo=


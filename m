Return-Path: <linux-kernel+bounces-436651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA47E9E8900
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E989284712
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0CA28691;
	Mon,  9 Dec 2024 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mee63dRx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FBE17741;
	Mon,  9 Dec 2024 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733708228; cv=fail; b=t4+rzbA9ZuyVIjkcqiErCQsgd2bYpc6WCbQMSTgqAty8YeU5LM11BQ426Grnur3GmdsEZpqyRtptlKnfrlGuRro6hmrvfW1425Cm3yigW4XBaV4EAc/mI1r/IcW8+MExn5ztquPB/Vc8W2RkWN+0v/PgBHd5DBIgcI7CqvUfzJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733708228; c=relaxed/simple;
	bh=XckRNQfHcr+ERiip99ax6JHKATDkL4iXNuqxY7qMdfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ILLt5AInl8FknwxZeF2gdnTSYaaOKwUxfjVqdJkOAcInO8y4yx8XVo7z5rD6Nybscc4tLqPOHCZQn44eERA42MZPH7N7s1upQ4zbV9C54XVqM8m8tvBKGnqpn5+vbHY3tfVqqtKjTMOVjE/ZV6znIVAYbn7vdZdfeUxhpVnfJwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mee63dRx; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733708224; x=1765244224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XckRNQfHcr+ERiip99ax6JHKATDkL4iXNuqxY7qMdfQ=;
  b=Mee63dRx1uhFaca/0cL2YBEeiygSU1QraUTtyv93X2ASKm9FQe/x94td
   ExyBL1tql1E4kIA/EXejyYVt+hV2X5lTtOaTaouUVaSiXmuPFpDRWzwug
   dMI1Pgxp9Y0mFLLmFM5z8Zj2Bp7K4I0V8k1CUNOcMR8TG9nSPRRDJNa+/
   9HQiz4wZQMISP+f/7ATTWHwzGUgI79wkaKZwmPx26UBMRVDq72kBuWtGY
   mBvwxyTrhqyGypUdue6iXhqa1jHlVd/Kx3AdkAzmx6cXwXrPrWfo4Hj+g
   z0GFz3NS5RdYnI0FgNzayzfRBN6W2D8y4BKnqqF/BD2u4npnOBMBrHutG
   Q==;
X-CSE-ConnectionGUID: Q50+TidnRNKhahnm6B8ncA==
X-CSE-MsgGUID: 2SM85Xx7TYKHiW7+sl8C9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="44462743"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="44462743"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 17:37:02 -0800
X-CSE-ConnectionGUID: wqHfsiErS7a+1LnhWoO2iw==
X-CSE-MsgGUID: RQDZNUuET0KXFSvGom2/Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95275832"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2024 17:37:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Dec 2024 17:37:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Dec 2024 17:37:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Dec 2024 17:37:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbCrU75I9TO/Ac/HWjeGmPfO9HtU3RsgQSll1C0SOkA7NHvv+pzGGs4kAA3Ye3HWsjYOni57LocB9ZecjVLA/jThnQoLNmLldPtOxZ8z8LhlKJZI6HzvPhPXzeWQ889l8Vb/3uplGP6jJtqFsdvbGIREuRuesrFjkgj8+411N/brOV6wrGNgz1qwt0+Pkf01WAv1z5i/Bzdrbl/HBIDmVrm2oZnpmZ4SzOlvs7XyU0jhMyReDB232E2Byt4LMGVkE2uGjvR0wYZADx5jyONRbKMYAWEnkzcHDQOX8qwOJZ9KhFiBpLHDBuHbUMlv+D0Bl0lMv2ZdCxY/2kx9iNY9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XckRNQfHcr+ERiip99ax6JHKATDkL4iXNuqxY7qMdfQ=;
 b=AibpdUsOCY1PNuVMeXFPCfjSq3EI9Q/BQjeJZZy+JmSZsQUNAyniD4mN2y7PzcBSQ7TC5E3TnBpDZdPHspFA82FemG4NK48gBgaoKn+r8lOPgqpCU1RqR+lujKR46Dk4KWrLFb0FnA39ZLwX+/VRGeIU8JiX79PR5YvgFsM3o/WPBEsNMdbkhDwpZCNZsZU+LG/k8Y85rAP6UsUhKHMydRjuqBK/mp4fy/E9+80IuQjAGRgEI6BJ6zYEMuDaDgV1nqV9Qv5OwCiUce9rl6OrkNy4EVz7FYEF51htY7bvN+QmQnulFi/eOmNrhpuZN/h7aeHfOdJOWsH1HkX1YStYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by IA0PR11MB8397.namprd11.prod.outlook.com (2603:10b6:208:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 01:36:58 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%6]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 01:36:58 +0000
From: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Richard
 Weinberger" <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
Thread-Topic: [PATCH v4] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
Thread-Index: AQHbRte2I6iSt4KgBk+IuGQxfboRn7LXcXdbgAT7LICAALqmgA==
Date: Mon, 9 Dec 2024 01:36:57 +0000
Message-ID: <BL3PR11MB653282E179DA562E3F4AB707A23C2@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20241205053350.434370-1-niravkumar.l.rabara@intel.com>
 <87mshawhta.fsf@bootlin.com>
 <ugcx6muozaven6lolhzpk5mvrt5fncoaahnsx5lbdsaurid4mc@i4qflh2edqnh>
In-Reply-To: <ugcx6muozaven6lolhzpk5mvrt5fncoaahnsx5lbdsaurid4mc@i4qflh2edqnh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|IA0PR11MB8397:EE_
x-ms-office365-filtering-correlation-id: c439ce61-4d0b-4f65-5856-08dd17f1f87c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bnVwNXZndFVxRXZBejNFam1tYUthc3dTRzN5VGJBcVVHMEdpaXB4dDNNM0xr?=
 =?utf-8?B?aytrNHhMd1VSQkQ4U0krb2duZFh1TDJuUlJDTWR5QjlmbnlpM2lCbGxnbzMv?=
 =?utf-8?B?c3krT3lsNE10VW91aFFaQm56UDQ3U0NNZ0hVams4MnJYR0J2bk1lMHpGb2Zm?=
 =?utf-8?B?TW9HcmJwdm5SQ25YbmMrVDY1WW5TcGd0WWZIczdIRHNMU1QzRmZ2bHZJU1ZL?=
 =?utf-8?B?SXZmdit5MGNSdTZ1YzByTmlMallMb1pId0k5RkUyK1Z1ODJtRWJFallhN2tv?=
 =?utf-8?B?QnRaNGRhZUdsU1pDK1hjT2tpUXRzNmc1VEY4MElMZk0yZkZyWTdpMnhNKzR4?=
 =?utf-8?B?MldEV3RSUjEvYkp0b3hNNFFSdkd0RXlIVXdiWHVsRHE5UjhweVlMcWZYM2to?=
 =?utf-8?B?Z2hzQkp3SWRXMWdBU3Y0eXJta04zaXltOVJZd3JOUk9hVGN0d3Y5VG4xY3NU?=
 =?utf-8?B?RHVKVDVOaEdkNStXSzVReEZ2ZG9hcWRjQUJTWXlNWVN5Y1dpcXE3TW8xTjIr?=
 =?utf-8?B?U1MzOEZTU0FYNmQ4Q0s1N09RemJkYzhPRnFQTTY5V0pRbGR0c3BaK1Y3TVlh?=
 =?utf-8?B?a3FKZHhKZkJZcnQwTTl1VFFBUDFuekxxdXJwZnZ1QXFDWCszTGV4OEdCV3VG?=
 =?utf-8?B?ZlRxTGhsTG5DU3F0amVlVEZlQ05EVk5qdFNKMTNRWTN1R21xTmtNZTB5eFp3?=
 =?utf-8?B?dEM5WmRTQUNyVzdYOGpnY0hUdW90cGxqNlZia1pIUU9QdnJGbUkxa0krYm1t?=
 =?utf-8?B?b3VyUnBYZlR4cERVQldQVklCM2dQS3JHVHlmKy8wZnRqbCt4dzhabDlGMkh3?=
 =?utf-8?B?RkhCS1FsQUl5WjYxVDV2RzZNL2pRQlZLVDZvOXA2dWZwUUxRWEZBZS9UYnNW?=
 =?utf-8?B?bndtcWgwMVNIVE04UHNhZGR6RHkva2V0U21kL3ZkdXVpQksrMXd1dDhrQWxw?=
 =?utf-8?B?SHRsbFNsbCt1d1RvYkJtVjZON29ENy96azY0MjArQUFnN28yL1Z2L0xjcnRB?=
 =?utf-8?B?UmZMV05QZFJhWDdrbzd5bWJOeDZyWlgrNWUvaXJiVng0TnpnazlHMGFyY3pM?=
 =?utf-8?B?QkVmeU83MW9yWExzZHBOZTRMVEJtd0dXRkpPVGZKU0pBUVhJTk16dnBxVnBW?=
 =?utf-8?B?a3FSL0ZkRWpQdkdoS1VVTC9sekp3Q2FDbndYRUEzTTlsajh5SnppSWsxSHdM?=
 =?utf-8?B?Szcxb2JJajk1ZHRwV2xXcFc2RDNlYXBZUDFCVnE0RUVJYVFwenhYYUhJN2Np?=
 =?utf-8?B?bVJySk80bm1YbHhzOUIvWCt3cTNaK2x2aEpZVXZNTGdGVmxDamlFdS91N3U4?=
 =?utf-8?B?c1N5SG94UVoxVmZFQ1YvZWZlZEV1NUtYSEx5amJNYXZxWU1ockx3amE4WHNN?=
 =?utf-8?B?Njlwa2JnaW5iR29XNytxM0NpZE5SVTR5Z3pYN1lVK2I0QjE2ZE1lNWZGblpz?=
 =?utf-8?B?T3hMTFNqMitkV0RQK3EzQ0ZMZGFha01QWUNNc2NEb2RISmZDTUh4Mkt3cmd5?=
 =?utf-8?B?RWxtVzZpYitrMzRCUCtvZnZhZEN2dW53V1R6RVd2SDVvRStGelYzb05CcXlT?=
 =?utf-8?B?Q0pqNVpyVXBJdXo0OHRER0RuMVhwR2lEUCtoUDh6N1p0bjZoUFFZVWNOYm1i?=
 =?utf-8?B?UUFiQXJISGt1RE55ZTFBcERVMys1REQzREh4dXpqMFArRHRTOTZ2WnBFVWpY?=
 =?utf-8?B?YndFRVQrZFYrTDh5M0tROHR1SElBS1h2VHhlVmhnUnNtcVFkYWxaQWMwc09Z?=
 =?utf-8?B?Sk5iZEtPOXVGWC9kNU5aT29rMHNxZTdBK29vdGxVTTdpZWtCTVpDUDJUdlpK?=
 =?utf-8?B?VENsanVqN29hVnZGZDFiaGNmdTlKcTRqVG13b2ltUW1raUI4TlIxVTkyWDgy?=
 =?utf-8?B?bzRDc0RRd1hyM1J1OWxaWGlhZGpRb0pGZnErQ00xMEVYYWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjFXRUw2aGdBQmtRUFI2eTZGbkp1SmJFNXZvakZOVG0xZ044R00rU01hUTlr?=
 =?utf-8?B?SktRMWVxdGFDSTFnWUxXN3dkaEx3WUFZZlJIblcrSlhteDk3TVltYW9VMEo2?=
 =?utf-8?B?U0JaTEk5Q0tkRnlyR0FqVkFWMEEyN2M2bFBRTVhwV3Vma2FLQlhhSWpoSnJa?=
 =?utf-8?B?NVZHOGY4MW96OEs2TytmSGJKdWY2SEhkOGtHUHNRdXg0L3hWN2QvaWViMzdE?=
 =?utf-8?B?Q1RZOGMzeUUyTWhrYzNRRHBMK2l5cU9TTjE5V0JBTkxzdEptZ3IybkZxK0Uy?=
 =?utf-8?B?UldYOXZPVzRmeHZ5NURrWVF0cVp6V08zM2FocFIxU2xYUmR2SEY3VXY4K0l3?=
 =?utf-8?B?MGNuWkRxYmJmVEJDMitCWEF6bXFzczJlTi9kTDgvTXQrSExTaEdzVlRzU3hh?=
 =?utf-8?B?MWVGQkdIUzFHY0Y3dVFoWEY4NHRWNDhPc3RFVDVCL2x3cU14Z3BKTUNMNFVn?=
 =?utf-8?B?QmE4VmFyRnUrUVQvejkrK0pFZW11RFBpMWxwUWFGbEFNSEcwWE1ldUNjejhv?=
 =?utf-8?B?SklCQ1NrY3NSeUtUSmxndHRzU2lVb3N1TjBzL0d2Wk1RcXVzbnZuNy9SdUh5?=
 =?utf-8?B?eVBlTXc0T0FVb1VMa1ExRU9Fc0wvcTkvMmxJRHA4dDR5clFTa1pNd3VYVW1w?=
 =?utf-8?B?eWxjdTRVT2orNmE3ZTB1Wk1JWlNseDJxMkFKaWJndEI2TkdnY28xMzNWbmJr?=
 =?utf-8?B?bzA2UDBHeWsvWmpHa2pHaUExRHZMT2hTTWFrcTJMWU5pcnhMbXJNbzFsUmNO?=
 =?utf-8?B?ajJKQzBXb2paMEcrc3ArNzAxdnJoa0FWNm5iUktocWdMajdkbE9ZYnc4QlJP?=
 =?utf-8?B?VkdLalZqWklYYkk3bjdWeGc1amdIQWJ6cFFrTDRQQUk1RW5BZ0xKK01ETHFR?=
 =?utf-8?B?a0ZmSkhwdkdGazhPem1HSmtZRHkwaThWMlNNODlIRUdRazFrWGNNQW05cWJX?=
 =?utf-8?B?RVlNV1JHdFFHd2ZiQnpOeVFjQ2V5ZGhJVFhXWHk2WFE1bTEzcy9FSFd4Z3Fs?=
 =?utf-8?B?Zk8wek95ejhtdVMxeU1Ld0NVNEt4SVVEMVZzbTBZREwvYzBTWktJMTZtNDNE?=
 =?utf-8?B?TDJ2ZXRmMm9sUzNIUTRBOHJ5cWM2TU9ENXQzL2pDYmZqZzNrbkthNXFsYjl2?=
 =?utf-8?B?MlExWU1jL0FFOFdpczBYcUNudEVEYjdFRFpUWXVmTzRydGJLd2xCNU43SFhM?=
 =?utf-8?B?ZC9ESzBmYldlYVE1Zm5VMzJCeG5vTDQ2dEs3S09ZL3BKeGJRRkJNY0QwaW8z?=
 =?utf-8?B?dm5OYWdNRFlWVWRNYWtDeS9JeUVjN2xML2N2NWxtM2ZoWU5XSk9FUndIU2lr?=
 =?utf-8?B?YSt1QWwrRktwQjRBVmM2OUU4czFldUI4VDR3TFNhaVlEUk9NYTRWUFh2N2hk?=
 =?utf-8?B?emdaVFIySWpxSEk4OXZSVUtwV1lCdjlXVFZlVUpnQzU5U3VDQ0d2N0h6Z2po?=
 =?utf-8?B?eXMybGFId2diUVR5SUZOMk42SS81bWNmK0hwd1pJK292N3VHeEdRYmdyazQ4?=
 =?utf-8?B?cURDNEJVbW0wUUxVbG1RcVZCOVJMYXo4V2loMlZBR0huTm84UFlJRlZjOE8w?=
 =?utf-8?B?MmhHRnVMQmQ1STNBV3BiU0lGQ2krWmpPK0xqU0JURm50eTlnZUplb0pBSXZx?=
 =?utf-8?B?K0tXRFVoOVZZRzFQck1SbkR2RzZoZ1lNalVEOVJVekhJTk9DYjFOSUlNQWZv?=
 =?utf-8?B?ditabERraC9tdFNKUU0rem1WOW5LSzEyOVQ2YVR3Z0thbllWRWlaS3Bxa1Z0?=
 =?utf-8?B?U3k4dTVxcWdxbElwSUtBS2xQZFlXMUpxbWdRRDhCOUlML3BxN3VhbkNJa3RH?=
 =?utf-8?B?TEF0YVkzS0ZSU0dHVzNSLzZxMmFhL1EwMU42WXIyVDlxTkYyd3lwYWlpbUs2?=
 =?utf-8?B?dkR3L1NOelhrRWlsbmFvbmdSMjkzVnRKZzdSd2dwNGw5aUFWTzFjRFdFS2tx?=
 =?utf-8?B?MEpHZWV4R293UnR1alFYMkNQV0U0Y05wcjNtZENLajRFaTN4ZGJlYmtidDUw?=
 =?utf-8?B?dmZISDhEY1M1RElXci9BRHNSb2pKak0vUk5HOUhFREpDeW1hKzlUQjFhcEdG?=
 =?utf-8?B?Ti9la2todTRGQ1JhQnFxdDViNy9WZWtpRUNjdFQ2cW5sZnJ1L2RubEhjWi9w?=
 =?utf-8?B?WjhyQ3AvWndTL3MxN0JOL3dFUnhBUE9EK0RQSURpNldhUFViQ1VkV0hwZlRJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c439ce61-4d0b-4f65-5856-08dd17f1f87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 01:36:57.9416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ms60uJhJrAJ6ZHwNSk/U+tKGBdmx/DYWNysEhKDW7oBS6le6l+WIcNl78DQY1MU9hiEb+d2POMW+/8WFFpnFqj5D+4EMNPj5DuFYMQ6tWQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8397
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIDggRGVjZW1iZXIsIDIwMjQg
MTA6MjYgUE0NCj4gVG86IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+
DQo+IENjOiBSYWJhcmEsIE5pcmF2a3VtYXIgTCA8bmlyYXZrdW1hci5sLnJhYmFyYUBpbnRlbC5j
b20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgUmljaGFyZCBXZWluYmVyZ2VyIDxy
aWNoYXJkQG5vZC5hdD47IFZpZ25lc2gNCj4gUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT47
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxr
cnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBs
aW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gZHQtYmluZGluZ3M6IG10ZDogY2FkZW5j
ZTogY29udmVydCBjYWRlbmNlLW5hbmQtDQo+IGNvbnRyb2xsZXIudHh0IHRvIHlhbWwNCj4gDQo+
IE9uIFRodSwgRGVjIDA1LCAyMDI0IGF0IDExOjIyOjA5QU0gKzAxMDAsIE1pcXVlbCBSYXluYWwg
d3JvdGU6DQo+ID4gT24gMDUvMTIvMjAyNCBhdCAxMzozMzo1MCArMDgsIG5pcmF2a3VtYXIubC5y
YWJhcmFAaW50ZWwuY29tIHdyb3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBOaXJhdmt1bWFyIEwgUmFi
YXJhIDxuaXJhdmt1bWFyLmwucmFiYXJhQGludGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBDb252ZXJ0
IGNhZGVuY2UtbmFuZC1jb250cm9sbGVyLnR4dCB0byB5YW1sIGZvcm1hdC4NCj4gPiA+IFVwZGF0
ZSBjYWRlbmNlLW5hbmQtY29udHJvbGxlci50eHQgdG8gY2RucyxocC1uZmMueWFtbCBpbiBNQUlO
VEFJTkVSDQo+IGZpbGUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTmlyYXZrdW1hciBM
IFJhYmFyYSA8bmlyYXZrdW1hci5sLnJhYmFyYUBpbnRlbC5jb20+DQo+ID4NCj4gPiBMb29rcyBn
b29kIHRvIG1lLCBidXQgSSdsbCB3YWl0IGZvciBiaW5kaW5nIG1haW50YWluZXJzIGFjayBvZmMu
DQo+IA0KPiBUaGVyZSB3YXMgb25lLCBidXQgYXV0aG9yIGlnbm9yZWQgaXQuDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpNeSBhcG9sb2dpZXMsIEkgZm9yZ290IHRvIGluY2x1
ZGUgdGhlICdSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IGNvbm9yLmRvb2xleUBtaWNyb2NoaXAu
Y29tJyB0YWcgdGhhdCBJIHJlY2VpdmVkIGluIHRoZSB2MyBwYXRjaC4gSSB3aWxsIGVuc3VyZSB0
aGlzIGRvZXMgbm90IGhhcHBlbiBhZ2Fpbi4NCg0KVGhhbmtzLA0KTmlyYXYNCg==


Return-Path: <linux-kernel+bounces-337465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F59D984A68
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50852B20A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2345A4AEEA;
	Tue, 24 Sep 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iolNoeV3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830AF1B85CC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199980; cv=fail; b=OlVI7WSA9vhP/eBmUNTZClWSBsqVG3uGJNUfJzzZmnepLp1X75KL6cl5Y2eMZZKWawt6Phxku8kA1ymBaHWix1Yjp74ST3s7dU5Y6zdzvYyCracwndUJuQiKO5jEHGvFvco30g1mem4jePSSJvTV4mIxxGlDjbei3kzOoiGDMQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199980; c=relaxed/simple;
	bh=wC132uykqncFFmx6K6TFmTsnB/rnXsUmTYkLY8gSzzo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EzeFFS6gpJcK0fFqqiQoi3nP5sBHDfuxCfnGoJs0mwEV8TVLMYgl/UFXEk7X/WWPavCzb44+g3b1U4hvnfoCMhMm3VAD/zmJueTNB+mZf9Qiv2AutgVDyf2pYWdcBGdhA/A3hMm5kPMZBPgys6EF0LwUYNBf9qDB+0nB6OR8ZSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iolNoeV3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727199979; x=1758735979;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wC132uykqncFFmx6K6TFmTsnB/rnXsUmTYkLY8gSzzo=;
  b=iolNoeV3wUj9fmiwZfjaoXIZh4s6iqza67NpbuXasvmyBWQ/I4yCf9ic
   qVNTfHM9ypeH3fZhlWPdLb6nsrCTza0b5THIZxvkJC2WvzWv50mylJQEy
   gsne2mwn2DiUZQzEWXTQaA91u6XldZVaqM2CQ4+kzyPPDHUAtxl/A4uo8
   Opho7B4bsDSQy4r6Kx4EXMSC7MFh2q3H9B+egt4MiKDrWIRnVeARuS6SP
   8EqcQmR8foV7PZP5UYrgY8YmBMxs2cNaWYWszl4mkdkr5Ebax1XyZO7yo
   ZbITOQZkIebJ9Tsa+WFQvSx28b9szeosXsFI1yaC7bY47SmvQ1ENT7f7n
   Q==;
X-CSE-ConnectionGUID: SRRW3nWZTOC1hLSb5MUBSg==
X-CSE-MsgGUID: l1dCflDhSGyzc2OuYSYFOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26160180"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="26160180"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 10:46:17 -0700
X-CSE-ConnectionGUID: bsvN+nkDTViibGJ0ZaHE+g==
X-CSE-MsgGUID: /Rtg+QSWRLKy/mtPwMvaoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76015182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 10:46:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 10:46:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 10:46:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 10:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6x+jJwbOVc0a6030qs3ROvdHFsV1JhtdHJGI+i1aUM3y8VaHnkrPZ1bWRhk5Qbe5jF4UUO6Q0yx+JLajnF6TqIvA42B7Fsc/1wBQ8rx4XIEMKNn+Opx65vRngKP3DRGlarunjAQSKKBCFptJQJgUnOTCP7DJMHTZaKTyFlNShzM6O1LoZ2g0OXHWP4TLDtJHbCAh2zXZzeB+grGiEVcFaPE/X+acONitCNmwYgObkwB2mn4KYFgPEB4AlClFuBki2xHztmersIed7ayj/w1ZwNM7mlgUET5u5B8v2MKpEMupS1WLpN7ccuYJAMT9eTPoD7K7n+pjDZ35hrqs/hDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2LTHfwkczMIYDtXxUJf4kpmdOcXElQl2bnoVyuv29o=;
 b=jsFyiZ4lwoqJ6f2AG6nrVFfr0Uf0d/FOyyz05kPaVIbeyzxBE+KEXOmbNrmgwuMdlwQkQybK7v7MUyc7jna1HF4USJe7wFVqg6D9ifFaVR+lJMoqcAk9W0vLVuBH4P99uMuBbuwAfQpxabEOr2GwPHw5g1yBfSFBoxHdSxJ7/LLstCQmbmVNIGXUKI4+guTa2BEwO1olxZ3f1kN/iZZbicze7a3ClSyMUVmgySmftVUZKkTLQDrQOpHp/493HCt5AuQolBBUQ2vZdcdTbtml1tCuVFB0BU06U7cUJ4ZNribh2Vkz6PTLhWWm4l2Ye+pM7Bs5XwEulWsktcz9AldzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 17:46:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 17:46:12 +0000
Message-ID: <a7c80676-0761-4618-ac07-0b53434b1a9b@intel.com>
Date: Tue, 24 Sep 2024 10:46:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
To: Martin Kletzander <nert.pinx@gmail.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <8d028c5f6f23e92fb83cbf20599366e896abc5b5.1727167989.git.nert.pinx@gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8d028c5f6f23e92fb83cbf20599366e896abc5b5.1727167989.git.nert.pinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: a109faf5-0d17-4d20-c640-08dcdcc0c7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTVvQjVFaUJXanFyT1VSSlhLT0tTWGR0TW12V1lBTVh4Q1VJRW92ZWtnQnFF?=
 =?utf-8?B?aVgzL0Y0K3dHajlWT2d1UTRqVzVsUmtpZmxPVnNwM1lLb05jTjRURzZvSXVk?=
 =?utf-8?B?TUprSDVEQzhRd21QRmRrY25TOENYWnB3KytmMGU0bHl3bHhIN2swTlhVeWVR?=
 =?utf-8?B?VGhybmFFYlBKUVEvelhsTEZOTi9RdGlIcEwvM2dnNHBqS3MzUVJVVGNhcTRv?=
 =?utf-8?B?ampHNE9XMjhzZlB5dUpISUdJTnZYZWVWTlhMRVJ4aVhUS21TNDhNdGZQSzlp?=
 =?utf-8?B?U0xwYUE3TnpqUXFoWW44WmZ0UnRNVE5hU0NkMUs3QlF3OFY1eWxBdS9yMktI?=
 =?utf-8?B?WWloRFpBR0lKYXFsRittNGJ3Z1lESnZaMnAyU2p0SXRPOWhzQkR4U2l5Wjhi?=
 =?utf-8?B?RS9ZcC9HYUFibjI5Nk5mK2FyNXJvVUNtcHFFdUkrc01FamNpWlV2SnRnTXNv?=
 =?utf-8?B?QXhMOHlaOElvd0tubkVsREM5OERKc3FBaG5Od05ZUXdld0pvcCsyL3BYYWRS?=
 =?utf-8?B?NXc4dWFZY3Vtamo2Wk00NDFtUEZlOTVqa21lbUFWb2EwRkUwbG01TGJhL3ZH?=
 =?utf-8?B?VWd5ZnVEVkVXZ010UGpEL1lnTEhnYzhVYjVJUUdVd0VOOEkrM0JjV0NYd1ZE?=
 =?utf-8?B?WW5HZnNlN0hnQVJkekI1cVhOODdKVUt2WVBuQmpXakQ4SmJOQnNuUHdmUGoy?=
 =?utf-8?B?b3BzM2FPaDlhbko2Rm9PR3lZaytvSXZ3ak81U1puV0JidWVwTmVIVCtHMXFo?=
 =?utf-8?B?cmNxU0JiMHZ3dWFPYU9vUnNRd05NWkcvY2lqTTQ4SytxcVlaaEFOUmNiSXJR?=
 =?utf-8?B?a0RkRXhZK1k2Zm0yektIVlFoQVNaSmRCbUZBRG12Ymt1cStiOU94UnJCY0xT?=
 =?utf-8?B?MkZFcVlZa29ZTUpLWDIvMXU4NFhUZTN5cnUxK21pVVYwVFUraEhCTFlCeWRv?=
 =?utf-8?B?T2psbExVZit2YUgzTHlKWlVMbWs5RHppcFdHR2lqK3NxenN2a1RSVFFUWU9Y?=
 =?utf-8?B?VU5ocmFjRUZLUzMzcnczMzRDbWJJYXVzQzVCajVWSXNqMDZQNGorUDFaNVJY?=
 =?utf-8?B?OXJXZlViSXN5NHR3RDVDbmNnc01zcmhiYjdlYmJVQ3NjODNWNSs5R1FMZVB3?=
 =?utf-8?B?WUJIZ3cwencrRGRsWDVmcUJJYnEwTU5hRm92SzBveDRqdUgzaGhJKzVqUUph?=
 =?utf-8?B?ZnpseUFkM1hqL2MrRTlwSzd3L2EwYTJxaUp4a1drT3F0REc4S2QzNU1jdm9r?=
 =?utf-8?B?VDV2Q25KVHFGYyt3U3FXTGdjK0FxcFF1SXA4WlJSTVNteG1uVXYwKytTN1VC?=
 =?utf-8?B?MGZGVjQ1MTc0elpXRklzbGdpOExaN205cDljTHdNWWJ0MVFKeExXRTBZTG8v?=
 =?utf-8?B?aFBRQWdsQ3l1dXgvZG11c2NHQy9SNHcwUGdTTjJEYnQ2UEhzUUNUbkJwSm1F?=
 =?utf-8?B?dlYwMGFDcmg4ZFkwdlpSYjNjRjhZNVBNYXp2cFkxZDJaTVBzWVRCWmZ5WVJS?=
 =?utf-8?B?RS95bHpuWTVRY3VuUDZISVk1RzM2V3p0eGNkZEJPRDdKVm9SSjZnNWJNeE9G?=
 =?utf-8?B?QWUxR1BUNWhsNlplWjFrckY5Zk5oVkZwVG42a2loRlpnNDRSZ2dDblBaVElh?=
 =?utf-8?B?YTJETE9lZ1RsUHhYNFVkdVdCc1hqeUplTzF5eHdMMVdGVVB4Mlh2V1NvTnp6?=
 =?utf-8?B?VS9Lck12N1NEK2p4ZkdXLzl2SHc4WUF2bXNtTjB5RkpSOVE4QlUydHhoYnVv?=
 =?utf-8?B?bENHSGhaYkM0WTVNTXZoV09XUTRIa3ExcXIwemJuWGlvb3lkaERIbjVpRW9Q?=
 =?utf-8?Q?WNZBTwx7uMgOB0uLZmUtxC/bD4s6s09ldlFCY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2h4NU92d0dTbTZLcG9qT2I3eXd1aTMyMlQyaXRZbXJtU2dwc0tqVUFweDZi?=
 =?utf-8?B?RnVybHQza0U2REhoVDVsR2dSb1FmbjRUaDhQa1kxdno1aGlZNjhpa3NtRUtT?=
 =?utf-8?B?Ty8ySEUrcDh6WFRJTmZRZDBxcTh2SXdoZTlFaTBrOFNibDRJWWhraXoxenlF?=
 =?utf-8?B?elJ6YXRVY3prYjNDLzZJNE0wWTdZTjJBdDdsTUpnNjdMMGFIL0N6c0dOczh1?=
 =?utf-8?B?b0FiSmJKRkI0V0xiVHpZQXB3T3VWWEVVeHA0Z3E5bUhvMHBxQmxWYVJWRDdJ?=
 =?utf-8?B?Q2JtN1hnL3l2K2d3UVdrdGVGNXdKeWpNWnFDakhFUXhZY3h2YlpvRkZtMFY4?=
 =?utf-8?B?Zm03OVR5ZUswdllpdkdVMGIvd2RESHl5bExwZytTbWFnNTd0cUJEU3pNLzU3?=
 =?utf-8?B?TU13ZkQ1VXBrc2kxMTRwNTlYcms1d1pQamxkQm9HQVZUNTd0UWN0aS9PL0xG?=
 =?utf-8?B?V0p0bXFFR3BKTVlGQ3gwWGQ4eHdoV3JtZWIzUnJCSERPUDhwTklIRzNEN0hN?=
 =?utf-8?B?M2txMjJWaGxFTER1YndFL0VGalc2ck9YbTNJL0ROWk9DTE4yYlFiTEVTcDRP?=
 =?utf-8?B?WkgwOGZBc1RSWEJGeVRPZHh3MnU3cE9KRis1dzlRM2FlVVNkaTFNbUJtdi9X?=
 =?utf-8?B?eFJwR1FFc0p6N1lxRy9yMEh3NmJoNzdWWDRFY2hjZnNuY1pvTFdhWTJWek5U?=
 =?utf-8?B?bzBvZ3BHeW5nQ3F3ZzJKaTFrZGRldWY2bG5wWmNvekhEbWt3OXUzdklNaDhw?=
 =?utf-8?B?aFZyanVOY0R2Q0NLcStuaFZ5aW8wWCtHMU03YVRVYm5jNW9RSzl1aDd1cEdT?=
 =?utf-8?B?TGpqcFFidzVmN2pYVVBTRmxkQTRxOFBLaWxmejFDV1VGR2JPQlNlYkZqSHgx?=
 =?utf-8?B?MUhaS2RBdmp1NVVmM0tYdU5rV0dWcVRqV1o1OHR4MnUxaTBaZWg1R2xURTZl?=
 =?utf-8?B?SEEwcjBLYU1vR0ZqZ2xEYlMzUVNITDRsdGsxRm1UUm5PQk1vRC9lVHZVSHpy?=
 =?utf-8?B?d05lbHJCLzUwSHhDT0hKNWpkNU1WRUsrbkxzMVhFNUVQV0xId3hpUk9icmFo?=
 =?utf-8?B?eDY5dERFZXB1YWdLN01xeE1ZVmR0ZHo0WlF4YS9OcndDK1VpNGlhQVNTNnU2?=
 =?utf-8?B?QkNxYnQ0N29jajcyYjY3VVl2TnhWWnFjakRSNGFDenU3b3c4VE9ERlQ4b2xN?=
 =?utf-8?B?M0VzVllseGlyT0dlT0R4Wklpc282d2RoMXZOT00zRW4zOUNic0h0NjkvSzY2?=
 =?utf-8?B?aHErRjJiNGhSeTZqMWtwMDZpUFo4c05ZRWNqZkJFR3NVQTZ2VE9LSnhqK3oy?=
 =?utf-8?B?b3IwWkNRZjc0QU1LWG9KRENpcllsVFUyVHdvb2pMMWJYcDU1NWtxZm12OGhk?=
 =?utf-8?B?ZlpSbjRhWE9sb2Q3a3ZoZkNLYjJUUmkzQUp2cklnamFQd0NTNFFVVDl1KzlP?=
 =?utf-8?B?WXdNWWdTeEtxOEhzZ1hWTWN5L3NvdEtqeGFhOG9xcXl2b2hhVUlHeGo4Y0dT?=
 =?utf-8?B?M1VxL3ZRaGpBZzRhR3lVWDVtZWNxR202ZFQ0bXplTXIvVHMvWERIU1ZrV1VD?=
 =?utf-8?B?WTFXSmV3eDVtT3U1aHJYUWtqZjI4VGJxSk9uUUFUZVFSTGFORlJLZVRGU3M4?=
 =?utf-8?B?MjJTN1NEQVN6MDJtUkQ3K0xDYXhzY3FqcmNEK1FYYjR6YjluVVpyTVJsTmMv?=
 =?utf-8?B?bUNuek1NODRRTys1a2E0V1BUSG15RERpMC95cXlKR3J3Qm5VK1EwWUF5SzJV?=
 =?utf-8?B?YWkxL2NOenNlSnhxTFNxOEJodGZPc0g0NzBmMWFleU5YZytqU3FlTGtRVGRa?=
 =?utf-8?B?Zkx1bkc3OTFuNjVWQ0UweWE5Vncwa0kyN1U2Uk9IVlA2MlFoZWRPTG03VkVV?=
 =?utf-8?B?d25CeUR5VlkxTWpNaW54c3d1emoyamdyUzRnR09TcFVVSW02d00zUU45N253?=
 =?utf-8?B?R1o0UE1qZ0RFd1FPNzdJVjhwNGVNbVB0WmFJQTR4bkFNdXExRDJ0SkJNazB5?=
 =?utf-8?B?eVhWRHFPTFJ0bEYyK1ZZK2xMejJoeUd5M2YrekJmb1RKR3lDbklUdjR1SGhs?=
 =?utf-8?B?dUpielhhRW1hQVF2dldJMmxML3VwWFFoWmJOejhROVBYVFF3KzlpSk00Zno2?=
 =?utf-8?B?MkcxQ3hDSi9USHhBSkpMS1MwUnpKUldPRHMvWGJoaE96KzZyNXdrTFlrZTI0?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a109faf5-0d17-4d20-c640-08dcdcc0c7c1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 17:46:12.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6X65DRfVVriRCmUeLIhmV5520GmSkwJKj2nXqDT3MZkhJusXipR7d0jg1pGofF+UDeHH3wRNuWLh+LbgxAtWiwnl8Ykexvx0lcUVH9yVVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

Hi Martin,

On 9/24/24 1:53 AM, Martin Kletzander wrote:
> The memory bandwidth value was parsed as unsigned long, but later on
> rounded up and stored in u32.  That could result in an overflow,
> especially if resctrl is mounted with the "mba_MBps" option.
> 
> Switch the variable right to u32 and parse it as such.
> 
> Since the granularity and minimum bandwidth are not used when the
> software controller is used (resctrl is mounted with the "mba_MBps"),
> skip the rounding up as well and return early from bw_validate().

Since this patch will flow via the tip tree the changelog needs
to meet the requirements documented in Documentation/process/maintainer-tip.rst
Here is an example how the changelog can be when taking into account
that context, problem, solution needs to be clearly separated with
everything written in imperative mood:

	The resctrl schemata file supports specifying memory bandwidth
	associated with the Memory Bandwidth Allocation (MBA) feature
	via a percentage (this is the default) or bandwidth in MiBps
	(when resctrl is mounted with the "mba_MBps" option). The allowed
	range for the bandwidth percentage is from
	/sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity       
	of /sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for              
	the MiBps bandwidth is 0 to U32_MAX.                                            
                                                                                
	There are two issues with parsing of MiBps memory bandwidth:                    
	* The user provided MiBps is mistakenly round up to the granularity
	  that is unique to percentage input.                                                         
	* The user provided MiBps is parsed using unsigned long (thus accepting         
	  values up to ULONG_MAX), and then assigned to u32 that could result in        
	  overflow.                                                                     
                                                                                
	Do not round up the MiBps value and parse user provided bandwidth as            
	the u32 it is intended to be. Use the appropriate kstrtou32() that              
	can detect out of range values.                                                 


This needs "Fixes" tags. Looks like the following are appropriate:
Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")              
Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")   
 
> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
> Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Please place your SoB at the end. For details about tag ordering
you can refer to section "Ordering of commit tags" in 
Documentation/process/maintainer-tip.rst


>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 50fa1fe9a073..53defc5a6784 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -29,10 +29,10 @@
>   * hardware. The allocated bandwidth percentage is rounded to the next
>   * control step available on the hardware.
>   */
> -static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
> +static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
> -	unsigned long bw;
>  	int ret;
> +	u32 bw;
>  
>  	/*
>  	 * Only linear delay values is supported for current Intel SKUs.
> @@ -42,14 +42,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>  		return false;
>  	}
>  
> -	ret = kstrtoul(buf, 10, &bw);
> +	ret = kstrtou32(buf, 10, &bw);
>  	if (ret) {
> -		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
> +		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
>  		return false;
>  	}
>  
> -	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
> -	    !is_mba_sc(r)) {
> +	/* Nothing else to do if software controller is enabled. */
> +	if (is_mba_sc(r)) {
> +		*data = bw;
> +		return true;
> +	}
> +
> +	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
>  		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
>  				    r->membw.min_bw, r->default_ctrl);

By now you may have noticed the lkp report [1] catching an issue with my
code snippet. Could you please take a look? Seems that %u would be appropriate.

>  		return false;
> @@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>  	struct resctrl_staged_config *cfg;
>  	u32 closid = data->rdtgrp->closid;
>  	struct rdt_resource *r = s->res;
> -	unsigned long bw_val;
> +	u32 bw_val;
>  
>  	cfg = &d->staged_config[s->conf_type];
>  	if (cfg->have_new_ctrl) {

Reinette

[1] https://lore.kernel.org/all/202409250046.1Kk0NXVZ-lkp@intel.com/




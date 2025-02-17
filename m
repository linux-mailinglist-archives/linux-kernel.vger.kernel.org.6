Return-Path: <linux-kernel+bounces-518202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A0A38B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DE8188F1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863723643F;
	Mon, 17 Feb 2025 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSJmK003"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4723642B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817496; cv=fail; b=PKZQ26M8MKZcHRQYRPKueJBWlkfoVFgWTxfa8aBUn5/7ytG8AvJuvLzj4qtLPAFA9ajJZS7NJ3NS36S7NsG6N2Ry37x+WeFGq1PyEQI+gfQRVmsJLSRJNAgyjsAGxPg8mZ1Iq3BqmpnMEN/O0nPwS2ein40ZIb3FwK0PtYTKN2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817496; c=relaxed/simple;
	bh=CFz3QexjusFaCouZT7biffI13dt13YhFqjzjcPZ33+E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CC2nmCyr9KSKmpvxdtBG1IspMM46SSHI4zzHQv+flVXAjko26//gPECkwPtMFAxuCNYh6F6T/1mpVWBdV09/HsFJ8BfAlZGYrXFYHjJOh8HBy/2r28bYiMVOTyE79HDrsaLjw2z5sUH6D+WbG53KfUG576T+SSx1WYdpj4Lua6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSJmK003; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739817494; x=1771353494;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CFz3QexjusFaCouZT7biffI13dt13YhFqjzjcPZ33+E=;
  b=gSJmK003AvCxgb3Rw3QS1QUn1FTvWV75xRFzum78DrObvrhPpSggVpWv
   S+XrBYTS9Az+B78RkSgPOCVDzlehJ7s/1YhlpGYPMAlrHiD2O0N7wzdNJ
   BiJqQ5DCn+yEB3lGqGVWtbEb/lbVATtbOUp0W2WSzS3djCtesMWyXSt6/
   YnjkDvzAeMVut7ZsXMe8h1XCryLP/0zSIeb+Dx5RXHD2MdkGXoJ+Lj8pr
   RfgWawOgviKkDwkMKMjKULg5S182tI8hyckaq1LI2yT2QWOfygytWkzFX
   1VtK3AKCMd50jRwNhB4Rqjc3lv7Slx9ujLKpzzPwpdz5/R7mQ70w1G8qI
   w==;
X-CSE-ConnectionGUID: p7hjDADZRZWkJGyS3GD/Uw==
X-CSE-MsgGUID: MZUVQK7lSKazkxhJCUXuog==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40214126"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="40214126"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 10:38:14 -0800
X-CSE-ConnectionGUID: 6rBB0pooTYyJwpVire+I9g==
X-CSE-MsgGUID: isLAIaGlRWix1d3Hz0A3wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="114386506"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 10:38:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Feb 2025 10:38:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Feb 2025 10:38:12 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 10:38:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSJRo5CDU1O9HFg6TyIQTfxgFbsKNUvRiLSz2xx8hyjsLN3CTVh+hBZyvx/6TtDe9huXWqeDhFsyisjYzwlZT2e9CZq/F/ujOKxvoHbW1boKPRH5mMfdQ62sl7K512N119Mb4/niAuf3kfRPXlk2hXrvme4mCgmfJy2I9B9kyb211FrT/JNX9LHwmKVv0llsqrSTAy/NCWwqhQqKCO16uuN4yBds0S7uhGxMxXkHYBVnLHZYcY0Fy20Xhl1KOhnlp4poTq4+aEIfNr+7pxR6oPrsCMkclf1tKqMXd7rS+ljxOeqc7J1NSoQ6yy1UXbUIVRHA9fN9xOmM0eqShzkwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJOr/W5XvA4Jct+SudYeYcMy2N3Q46HCp6mZjRtE/Vg=;
 b=g6gNxNCkKzGDI35i+whcD+OU5Loq5gJCH351R8a/vZhvN3npd2PG1pHnoLy86DZSZDjkI4/ZrLaNDLTdRF19XICQ8r0nT/T3OfcUP5T3jpBThbEwNl7Hz4GwgG/h9WLGc0S1Ai2bCpeo/mL7iY1XPbMGY9O/NyYfi+vksii9PUz49EbraTzxlLKX/Wjh13uRO8jjnfntmmHDcYwdSEv5KtFD5YJKK53xADISZPHVMjDtgYQNSnGTy7NHrKaav5N0THsBrDZlzc7fNjiO3O//EX3tZQ3Sg+0U8NTL4M5nIBT0mrFOrHcWXbc9RDSia+JRrtvSS/n7ssgnmymB4hmAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS7PR11MB7860.namprd11.prod.outlook.com (2603:10b6:8:e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Mon, 17 Feb 2025 18:37:42 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 18:37:41 +0000
Date: Mon, 17 Feb 2025 19:37:12 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>, Andrey Ryabinin
	<ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, "Dmitry
 Vyukov" <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	<kasan-dev@googlegroups.com>, <llvm@lists.linux.dev>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon
	<will@kernel.org>, Evgenii Stepanov <eugenis@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/9] kasan: sw_tags: Use arithmetic shift for shadow
 computation
Message-ID: <kmibbbrtlwds6td64hloau7pf3smqth4wff33soebvujohsvli@kni5dtvpwsxf>
References: <CA+fCnZeBEe3VWm=VfYvG-f4eh2jAFP-p4Xn4SLEeFCGTudVuEw@mail.gmail.com>
 <e7t5yzfw3dq5stp5xjy5yclcx6ikne4vwz7d6w2ukfw2b7gr6t@oomoynf3b2jl>
 <zjuvfdbl7q76ahdxk3lrgaznk7vjj43f5ftzfgrnca6dqtcd5x@5qj24womzgyq>
 <CA+fCnZfySpeRy0FCFidLdUUeqp97eBdjAqQyYPpz1WxYwcsW9A@mail.gmail.com>
 <aqhm7lc57srsfuff3bceb3dcmsdyxksb7t6bgwbqi54ppevpoh@apolj3nteaz6>
 <CA+fCnZdjTkreTcoo+J8wMhwDuAFM4g33U5BFy0OPtE0UCvyJbQ@mail.gmail.com>
 <CA+fCnZcoVdfXVN8VBFLx835cV0eGAT6Ewror2whLW761JnHjNQ@mail.gmail.com>
 <sjownmnyf4ygi5rtbedan6oauzvyk2d7xcummo5rykiryrpcrt@kasomz5imkkm>
 <tuwambkzk6ca5mpni7ev5hvr47dkbk6ru3vikplx67hyvqj2sw@rugqv7vhikxb>
 <CA+fCnZcHnWr0++8omB5ju8E3uSK+s+JOFZ3=UqgtVEcBzrm2Lg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcHnWr0++8omB5ju8E3uSK+s+JOFZ3=UqgtVEcBzrm2Lg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::7) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS7PR11MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cec8ee-d1c9-40ca-7e93-08dd4f822979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGdXbG1CV014dmlZd1Y3bXVlQUV5MWpuOEFSUHZiVXZ5N2k0aGJNbXI3VlNR?=
 =?utf-8?B?L3J2Z0JuQ0VHSG04Snh3dk5SUWpaTXB3UkNtZUpnZGpqZnNaM3hkZ0VSWXZy?=
 =?utf-8?B?cFh6WmcyblpOZEF3SzF2cUV0NmVCV0poM2dzRmJBOWluck1iSldnVFRSQ2ta?=
 =?utf-8?B?RDVCejA3Uyt3aHFIRWhpSk5xeWhicThYODJNVHhEc3hjRW1JVi9SNk11VDVG?=
 =?utf-8?B?SzYxblJZYStRd3V2MFlqQVJoL01ReG14VUpDY1pmbWlkWFphMTFsZXdYQ1Nx?=
 =?utf-8?B?ZHhRMDc5VWhySVpHNjdPeSsrSFRYbjlqM3FzZFd3RkFEcnBWZGREeHFFVmZ5?=
 =?utf-8?B?MnVGWGloK2pIVmQwOEwrcitBY3hIL0k0cU45YzVNQ2xEOGE3cnhFRXAyUFMy?=
 =?utf-8?B?N2JVOHFzQThwb2JIRnhaYVk5d3ZYcnlKWDNDM2ZPLy96aXk4K1FiOGN3bUY2?=
 =?utf-8?B?OEU2czNDUVNua0htby9nVTJJSWc4aExJaDZYZU5jNUplR3RzUEpmMStLWGN2?=
 =?utf-8?B?STROMGtXaGZaWm1ab3lPcGdLQlNjdTJHR0gxOGl2TGpmR2N3QytPM29GSkNK?=
 =?utf-8?B?VEozTU5TT0MvNVdQOVhvVEpEd0ZLMXBYdEIyeDdUMlRkNWNTd3BDa2hjWnUx?=
 =?utf-8?B?UEJ3VnhRNGx4UVlSQjNkdjVmSU9YcERlUkFXK1dMS2xVbm1aTllBazFjdTFP?=
 =?utf-8?B?Nk5nTWZTeFhYdDVqOUVEb3ZJV2RXTGdCU0dRRm4wYTlxbmVrVnJZOUpDRXpW?=
 =?utf-8?B?d2RsYTJCSWJOQWZvVXZvRCtuL1QxRHhFRjNlNmFqNGxnWlFjajQ1L1FDNzRq?=
 =?utf-8?B?Qml2R0Y0eHg1MlppMkUxUWNCVzA5WlBCYXAvRk11aGQ0bElYNXJFYUVXSUpX?=
 =?utf-8?B?Y2tkRHhQc0VNKzVDTFNSSUh6MFJ0UU1OTmJadjVuZzE5RWxkZHErM21sam9O?=
 =?utf-8?B?bGtzdTRMYUF2L25VWGV4UzlTc29ReGxPYXU1K29ydHJ6UzI2MmpoaGoxWFk5?=
 =?utf-8?B?TWkyWnZOSnlCOTdUYnE0Ty84U3EybEZYeEJsY1NRMG1HNTdIL0dNLzZxVVZ6?=
 =?utf-8?B?eVoya0x6bnd2bDRUTlJWYTdNaGJXMjRRUytSTkpmbTh4bWFJekM3R1NvZjZ2?=
 =?utf-8?B?emVmVWlienRZNEFxN09qNmxLMTFaa0FTeWJ0N3Npa2wwREpqUG1waXlSVjZ5?=
 =?utf-8?B?bjlCWXBFckVoTGIxeWQwUnlQR09UbG5NcHpKRkNlN0FPbXVKZzV3SEZzaXhX?=
 =?utf-8?B?QmFRd2RmWXNGNU1rM2wxVDdPRythMlBjZUUyL3FQSzV6bHZhYlQrVjFhTHhx?=
 =?utf-8?B?aDdVaG1RUmg5djNzSkFwcDNQRURBazBaNDIzazJnWU83MVZQMjFDVFhFL1VU?=
 =?utf-8?B?MjdYdkczelpyRDY1a3VVZTh5OGV6YmRhVDhoTEEvUHlqOXJIMlZMSlFkYWQ2?=
 =?utf-8?B?ZnRKQnRtanV6Vi9sTWQ2OW1iTHBJYmNCY1l3ME5rTTFKV3pDMkRvMWN3YnhZ?=
 =?utf-8?B?RGlNUDNPb2p6WTVhQnRmSXFYOW9GbVY4OFdyYWhBenRlUmNkTE5WV1JlcW1L?=
 =?utf-8?B?aHlLSXhSbjlLMjZaOGp0U2g2c3FvWmZvN2hUVThJTlY2c3EzSFdTRm9YVllD?=
 =?utf-8?B?aFRTbU13SVdHT1hXcXl5VkJYU3VWVko4anFEMk5UQU1DZ3hRdmxzU1V6ek0r?=
 =?utf-8?B?RXVWczJqeWNmaDlvRkZOWHZyZHRsSENGSzA0K1NBZXMyU0xyRitzYUxENFUy?=
 =?utf-8?B?ODhkSkZoTVVZZTZ0L0RhWWk0cEtQMWdUZG00YmxLMHA1MGNnUnRHTG1uaVd2?=
 =?utf-8?B?dHFTNVZrdW5sZ1llaVlWS0h4bXZ3NW1wdlc2Rm5FcjROYjVnK1NZWGlXcWd0?=
 =?utf-8?Q?KXXem+9otIMea?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2hUTk1pcVZ4OXZ2eitrN0J2aTZtOU5qdWlvTmdyL3pzVWJkSTZTSVRLVjNj?=
 =?utf-8?B?bjQwd3dKQ1hqNGR4dDJtQVVWbU1KYTdaSDRJY3hhaHF1VHVkVCszMFhkSVdn?=
 =?utf-8?B?YzM0NTU1M1ErZ3dTYVRyL0JJdFY0YVVzWDV6eDJhWW5XRHdTdjcvRUxPS09u?=
 =?utf-8?B?clRmNndMVS9pdHNLb2N1VkpaVVJpeE1wOCtoVURoY1p0c2N6bzdrWFhyUVNY?=
 =?utf-8?B?TmZmRnQ1ODN0djVTRS9iYXdOdjczcHdJb3pnZkhKT2FBdFAxQUZZRm55MGdY?=
 =?utf-8?B?bW9uZVFsMzFaM2pzVjF2ZUFubFozS1VybHVId2o5d2lHOStTODNReG5QdlRW?=
 =?utf-8?B?S3M4UHdhd1FQVEhqdUFCVFl6RVNXdHozVkFxb0hSNVJIdlBvaDcxdmhxVE5o?=
 =?utf-8?B?eUV5aFdFa05ZZ2pCSDhRSHRtd0ZJeWcrM0duRjBNenp3THZTSFNiY0tydjFq?=
 =?utf-8?B?NjlzZitOR25WalBKVWh0UTUwSkJDYUdUdytSNW40bi9KTUQ5a1hhOXVkWTM2?=
 =?utf-8?B?WXBpdU84RDhrU1l6WWJ0c1pQUkxxbThLUlg3M0xPSXQ4N1dGcG8xZGs1Z0Rx?=
 =?utf-8?B?L0tvc2kzWVpncnhkSnhoT0hoSm5BS2RkajJMbTdGQWRJdmg1NTRmZDhTTU1n?=
 =?utf-8?B?dkQwWXdvek5pMzRhOGlCVG9IR0tjNFZBNGtMWUhEVmNsZzRhZDN2ejhqc0FE?=
 =?utf-8?B?ZWwycTRhampvUzExMEl6d2xJMDJDZ0J4Szc3TkszTXVOcnJBOFVBeGJ2a1hj?=
 =?utf-8?B?d3FUeW1DV2ZtZFFzbUtuWEVhM1RWN0ovaHRTQk9HNFprSlNYQjYxdWUwUDNX?=
 =?utf-8?B?elZyNXMyTU9xVmRKSkZ5WFZmY01MeHpkb2NQN24xeUMrMjRqbWs3SGNVbE9z?=
 =?utf-8?B?alpCZjE4SkgzVms4MkdGa2luZG9uUGVmemtQVFRTdjRxWXhHcEhWYTd4Wkty?=
 =?utf-8?B?RjAwa0RUWWN6Rko4QnFUTlg2T0dIRVh4MkpVT25FTXI3SHg1Si9lU0ZpRkdk?=
 =?utf-8?B?ejJaeDhIWXdaVng1Z0hFcG1XSm5uRnBsWWhHNjNUK3ZzaFNiOUYzLzJSbkp2?=
 =?utf-8?B?V1QvK0RhMHNKcGRJemt6R1V2Q2Nab2Fkc0pCWmd1UUMzRUcwNzBJUWw3eXlZ?=
 =?utf-8?B?VURkM1c4Wmh2VTJKSllNYmVmK1ZYL09lbFhhdk5KUVJmL00wTlluNndvQzRB?=
 =?utf-8?B?bFoyQzVKVFRrZnBFTENOdStxcFRzeFkrWlpUdnU3WGpGZ2hHa0FUWm0rblky?=
 =?utf-8?B?WFAvVksxTGFsbTRUU1M4elp3aUJKTFI3L1dyRnZ0REdBblI4ZittdG16L3Vj?=
 =?utf-8?B?K1ZRV2pBUTVzbGQ1UzVmUHd0YTl5OS9RZHBvMm1BQ3cvc0RGZVZLRDdBUlFt?=
 =?utf-8?B?UXREU3A0UEg2K2lnR1ZPTm1xZVpUT042VFB3cmlyTWxzaERtTzZMLzMxWHNh?=
 =?utf-8?B?RVgzbXRhRHlCbW5qakRJeXZyTlUyUGNPZWhmcURjNWNhdkNLbVoyMTlYNDBE?=
 =?utf-8?B?UVBZN0ZrdG1GNk5vTFZVQ2RSMG1haHp6WUROMTlFZTFyNkxaL3A5NTZ0cFRu?=
 =?utf-8?B?YmREbW5DbmtyOGlIVFV3TFdxSWFRY1R0UlhIZUh4d1prRzY5S3JEeVBIc0R5?=
 =?utf-8?B?eUtiem84RmpnTmdhZjFCVHZYRC9TTlVkZjJxbzRTcFI5Y3NsYWlmTURpcm1i?=
 =?utf-8?B?YXZpT0dQWE5MbUlxdTVYUjFQTEFMZjRRUW9CVzdsdjZJbE1kNHl3T3lFQTZR?=
 =?utf-8?B?QXRRZldvOHNsSWlEU1ZWME5BTUdJQlk4VDVWMW5qS3d5NDlJSE9qWGdpVDJX?=
 =?utf-8?B?clYxZytNTDMwN1dnODhIOXFLSmloa1BHdEhCbmZzdkFEcjVtbnNxb3pvR3ZE?=
 =?utf-8?B?VW5QTnU5YTRDZXlGZFJlVXUvM3Y5UG9oQm9Vak5FR2Y2WVNGSWNuM29MazRu?=
 =?utf-8?B?ZGxPSnBCd2h3c2l6WUtmaGtjT0dMWTFPaGNSK2FDVUhRcGlWZFZRNHlmSUJL?=
 =?utf-8?B?VUxqTjVyRm9GWEx4QUttZlBUMEFtMTNjaEhZQ1JQaHVtUkluMEdrZTBpMHlX?=
 =?utf-8?B?Z0RlbTNrcVVXMnNYWlNQUU9leklqOEpOajduWTdleTQvdWNDcGE0eVcxeGdR?=
 =?utf-8?B?OWtzbmpZTWZGcnp1Z01taC9Mc3c2Z1dlRlBMRExiZk9veSt4a3BlNDc5TTc2?=
 =?utf-8?Q?tXRZJgVTLDWquoa2f7MFFGA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cec8ee-d1c9-40ca-7e93-08dd4f822979
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 18:37:41.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnde02ZQefCeJ+Vw4RcdDaUi3QdNfeuWsahKFtY7vOH5FAnhL0rMt16LRV+DdRwkLaDbTxAwwsLo9YwZtOgNwMRPaIeglJfI86jin5AV+1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7860
X-OriginatorOrg: intel.com

On 2025-02-17 at 17:13:23 +0100, Andrey Konovalov wrote:
>On Fri, Feb 14, 2025 at 9:21 AM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> On 2025-02-13 at 17:20:22 +0100, Maciej Wieczor-Retman wrote:
>> >On 2025-02-13 at 02:28:08 +0100, Andrey Konovalov wrote:
>> >>On Thu, Feb 13, 2025 at 2:21 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>> >>>
>> >>> On Tue, Feb 11, 2025 at 7:07 PM Maciej Wieczor-Retman
>> >>> <maciej.wieczor-retman@intel.com> wrote:
>> >>> >
>> >>> > I did some experiments with multiple addresses passed through
>> >>> > kasan_mem_to_shadow(). And it seems like we can get almost any address out when
>> >>> > we consider any random bogus pointers.
>> >>> >
>> >>> > I used the KASAN_SHADOW_OFFSET from your example above. Userspace addresses seem
>> >>> > to map to the range [KASAN_SHADOW_OFFSET - 0xffff8fffffffffff]. Then going
>> >>> > through non-canonical addresses until 0x0007ffffffffffff we reach the end of
>> >>> > kernel LA and we loop around. Then the addresses seem to go from 0 until we
>> >>> > again start reaching the kernel space and then it maps into the proper shadow
>> >>> > memory.
>> >>> >
>> >>> > It gave me the same results when using the previous version of
>> >>> > kasan_mem_to_shadow() so I'm wondering whether I'm doing this experiment
>> >>> > incorrectly or if there aren't any addresses we can rule out here?
>> >>>
>> >>> By the definition of the shadow mapping, if we apply that mapping to
>> >>> the whole 64-bit address space, the result will only contain 1/8th
>> >>> (1/16th for SW/HW_TAGS) of that space.
>> >>>
>> >>> For example, with the current upstream value of KASAN_SHADOW_OFFSET on
>> >>> x86 and arm64, the value of the top 3 bits (4 for SW/HW_TAGS) of any
>> >>> shadow address are always the same: KASAN_SHADOW_OFFSET's value is
>> >>> such that the shadow address calculation never overflows. Addresses
>> >>> that have a different value for those top 3 bits are the once we can
>> >>> rule out.
>> >>
>> >>Eh, scratch that, the 3rd bit from the top changes, as
>> >>KASAN_SHADOW_OFFSET is not a that-well-aligned value, the overall size
>> >>of the mapping holds.
>> >>
>> >>> The KASAN_SHADOW_OFFSET value from my example does rely on the
>> >>> overflow (arguably, this makes things more confusing [1]). But still,
>> >>> the possible values of shadow addresses should only cover 1/16th of
>> >>> the address space.
>> >>>
>> >>> So whether the address belongs to that 1/8th (1/16th) of the address
>> >>> space is what we want to check in kasan_non_canonical_hook().
>> >>>
>> >
>> >Right, I somehow forgot that obviously the whole LA has to map to 1/16th of the
>> >address space and it shold stay contiguous.
>> >
>> >After rethinking how the mapping worked before and will work after making stuff
>> >signed I thought this patch could make use of the overflow?
>> >
>> >From what I noticed, all the Kconfig values for KASAN_SHADOW_OFFSET should make
>> >it so there will be overflow when inputing more and more positive addresses.
>> >
>> >So maybe we should first find what the most negative and most positive (signed)
>> >addresses map to in shadow memory address space. And then when looking for
>> >invalid values that aren't the product of kasan_mem_to_shadow() we should check
>> >
>> >       if (addr > kasan_mem_to_shadow(biggest_positive_address) &&
>> >           addr < kasan_mem_to_shadow(smallest_negative_address))
>> >               return;
>> >
>> >Is this correct?
>>
>> I suppose the original code in the patch does the same thing when you change the
>> || into &&:
>>
>>         if (addr < KASAN_SHADOW_OFFSET - max_shadow_size / 2 &&
>>             addr >= KASAN_SHADOW_OFFSET + max_shadow_size / 2)
>>                 return;
>>
>> kasan_mem_to_shadow(0x7FFFFFFFFFFFFFFF) -> 0x07ff7fffffffffff
>> kasan_mem_to_shadow(0x8000000000000000) -> 0xf7ff800000000000
>
>I'm a bit lost with these calculations at this point. Please send the
>full patch, including the new values for KASAN_SHADOW_OFFSET (do I
>understand correctly that you want to change them?). It'll be easier
>to look at the code.

Sorry, this thread became a little bit confusing. No, I think the
KASAN_SHADOW_OFFSET values are fine. I just wanted to embrace the idea of
overflow for the purpose of the check in kasan_non_canonical_hook().

But I'll put down my train of thought about the overflow + calculations in the
patch message.

>
>Feel free to send this patch separately from the rest of the series,
>so that we can finalize it first.

I have the x86 tag-based series basically ready (just need to re-read it) so I
think I can send it as whole with this patch and 3 others from this series.

-- 
Kind regards
Maciej Wieczór-Retman


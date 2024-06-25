Return-Path: <linux-kernel+bounces-228976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228D0916945
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F811C20B15
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E741607BA;
	Tue, 25 Jun 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WK2ASVc1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0417C98
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323150; cv=fail; b=TOKcFjJ4D/fLP7SC7hBJXJDNXE1pbOUtUX/oweTTWwwnQmp47HXpezBhC4Tn222mo4k056hd9FPtdDvKp42+ARIb6clgnkZjaaqnZ8sJ5il3FP3HYch8Ltmjz1311kGh1WC6sU/mWbT/bfrkQC3k/97eDxA41Vap/ThMpehVSM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323150; c=relaxed/simple;
	bh=VoMdK8ySO8qMSYxLnSpiGNxY2F5Rip3RWy+41q+O7/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lInQ+HL45ZHfa61e5v1qAG7HUn449xlNiDTJiJT0o/lBrx2hoFTFYhnMmw8qzl2v9mNNtLMZHKRyIsAVaB5fBWpn54Reb5qQfUhIyyse/cZ0FQWtgrCdithe8VKyzSNXy070pCu3K1XZgS+MmvZNCJeFaJ/Z0TzdrRGZEWvsyhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WK2ASVc1; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719323148; x=1750859148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VoMdK8ySO8qMSYxLnSpiGNxY2F5Rip3RWy+41q+O7/8=;
  b=WK2ASVc11LsfR38U36Kj4vneuAUhFqDt3SCKfjahGWdUp//muP6e9cCA
   Zb2TlOOVtNmZDphbqfawv29vXvMj7JhjZzERgiQdWN7UH7HyKg66QRFRc
   IzBb6GW3GEqKcphrNO9MPlVOO1EqpGBRNsMfHSFPTlW1g3uhcIpmRWzya
   SWM0BaoQZ8d7KfIHgPCStKwWPF64uHloRl/AvKC2OhPZTunTqhcQLvhnS
   /tUPoqhz0XXRXkiEfFDkJ55HfNR9AqcQ7KFLKzWWuuwYW9tNI9O+72qjV
   VGo6WAQsT4G+QJS9oAeLya/6OHl8f4QinlQNUS6EjepqVkBxpEqp2oTqe
   Q==;
X-CSE-ConnectionGUID: 20j5Ta4fR1CR/gB0GEiLWg==
X-CSE-MsgGUID: CsIqsbXGTKOfGt+PSNlMLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="27746394"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="27746394"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 06:45:47 -0700
X-CSE-ConnectionGUID: 0GDWO5tlTGeYDY33HAuZeA==
X-CSE-MsgGUID: NXpACuRxRhSCux1tGOsqjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="44100400"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 06:45:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 06:45:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 06:45:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 06:45:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 06:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AorMnS9L/l/uMUCkyEKntua0PkkXuTQmnsMZIacrBINzwcX42AEnBHsSpU/rTG2SDvFZgWC9aqiNoPBb4sSqYpUxGEmkLN5KskfIlBS9S1mnIuO8X+rTsMm1vzQsc9dgKxkJphGRRfWxMKuXzBXT1HjiztJffjpUyy415QyNGW6hus9G8x3YYmNtVLCeCqN7OVf6dXONpGSSlhroq+ohY6W+Nfh9MMwoOmwSnrogKRaVOvfmWla+zBq19Hm87Chf1X6gA1sxI0/VQI/QJA1lbqeuvbky5JCBBc8q5hZ1RFEgx5FozaQPqnmTaGumNPaw50+y6i/IQ3JS5p7KPpeczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoMdK8ySO8qMSYxLnSpiGNxY2F5Rip3RWy+41q+O7/8=;
 b=Ln9s3aR6NH3jFte3U3NimyUIhgJFcQ+xrF0WqAxpDB50wjRMiN0rVR0QLbyCQEh5GJmmRxeVVzWUjSUG68y6CiJAU82nl9C5I7pyUKvSOvYIx2mGaqd/ZUoQegCXUq7HTz4sCf9jwFwhqL7oLjnM1MaQLd2ugBIzEyVGwvsU3A/b0Fq+CwcuG+ZpEZ3+nCLP41wQweuE3TqtdFrHyyvUPqvVCquPLcpjPK3WeEbyqnjvd0rfPsiA8feOlXV+EW3yk0bGvv718FNekBtyTsN9HrMI5sVGpXAJ9qxiGoWLX8yyXvOSAIZaPZ39W8XkPbGHIaNtTwjwFwDC3iqv7/WPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7537.namprd11.prod.outlook.com (2603:10b6:806:348::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 13:45:40 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 13:45:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bp@alien8.de"
	<bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "luto@amacapital.net" <luto@amacapital.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>, "dave@sr71.net" <dave@sr71.net>,
	"oleg@redhat.com" <oleg@redhat.com>, "ubizjak@gmail.com" <ubizjak@gmail.com>
Subject: Re: [PATCH 2/3] x86/fpu: Remove the thread::fpu pointer
Thread-Topic: [PATCH 2/3] x86/fpu: Remove the thread::fpu pointer
Thread-Index: AQHaxsBAeIRGWNR6RESl9E5Eccw5jLHYfm2A
Date: Tue, 25 Jun 2024 13:45:40 +0000
Message-ID: <0044b843e959e7b32f9da7b58469f6685c9b2d13.camel@intel.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
	 <20240605083557.2051480-3-mingo@kernel.org>
	 <93bcabebe678b532cd8ee75fa2f48f32ceeb64b2.camel@intel.com>
In-Reply-To: <93bcabebe678b532cd8ee75fa2f48f32ceeb64b2.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7537:EE_
x-ms-office365-filtering-correlation-id: ceb55e7c-674d-441d-4576-08dc951d1a4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|7416011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?ejNiNEFTdFVHU01SZkRVMXNTNHNrdnNRZ3RCckN4NVIycW9NVVp2QlFWcjB3?=
 =?utf-8?B?ek1ER2tiR2NLNUFJVW9NV3E0T3RYa0FXdE5RK3dnWmlIbjdESmlUM2dzbFFr?=
 =?utf-8?B?cjBQVnVIb3k1bFNLVlgwb0RXODdLUE9HV2wvRGNMSEVaL214QVlLTEJvaTJ5?=
 =?utf-8?B?ZVpwVHV1cFIzVGl1RllTVVIwSDIwa3JwQnBVN1dSTTBPeVkrL2JOUWtKaldD?=
 =?utf-8?B?alp1dWJQUFB1NjVwVTBaMXZqU3g1NDB3cE9uMWt3V0RyaGZ3TlZuMlNlQ3VD?=
 =?utf-8?B?TGxSKzhHY0dqT3lld3RURU02SUNKME9vQUF3VUZ1SEFKYytCcW5LOW56L0dn?=
 =?utf-8?B?cjdkV1M4enkvd1BpTmNQWUVhUUFpejdaK1RvNW1lQWJIakthdGRuYkNRVFVj?=
 =?utf-8?B?RHNtd3k3RDYwc05XaXQ1QjFFMmduelRYK1RvVWtubUNweGpib0pkUmoySmxI?=
 =?utf-8?B?MUV2eTdvQmJpdERoTXM5WGFpdzRrdzFoaEUyN3gyZkZOZURtWS9GSkZ1Nmdr?=
 =?utf-8?B?VjBwZjZ4akhVd051U1crZmRoUE0xN2RteU5rVkFQTHVkeEhjd2hQQkFlVWhT?=
 =?utf-8?B?YjhNcHUwcWovL0NyRXZXeWFxcWU5bFdSZWdIcE5TZDJSZmZ1YmJWRnFkS2Vl?=
 =?utf-8?B?QWR6YmZsZ1YzajBRS1J6c1paNVJTc2FUalg4NmZrYWRiTXZpcGlsVkhaazNL?=
 =?utf-8?B?ZDZGdHhsWkw4VjdxZmFVdFNyWmc5OFcwV21pM21LNnpKZFYvUXVyVmZ6Z2Js?=
 =?utf-8?B?Rm0zNERZMVUwcGZHNldlRndkK1crVkFiMnVUOGFkakhYUHB1YkErZ1h6N1Z2?=
 =?utf-8?B?enJPejRQRkVyRElOL3BMSDhxejI4eGVIeHoxVlNFVmEva1lzelZ3a0xCWkYw?=
 =?utf-8?B?ZWExNlU1S2ZsK3lDdTNhSW1qNk1jR0s4WW1IMWFGVHBYSmcwSGFNTVdyR1Fi?=
 =?utf-8?B?NHJoOThmSFd5aHBENlhDelJzdkh4NHNCaWxLS3lEelVRK1NPS2l5dHRRSFZp?=
 =?utf-8?B?VEgzMitJWnliUjJFZEpWb2FmS0NSdDVBNm9CTHBTTUluZWowSmRRMWFBTG9J?=
 =?utf-8?B?Z3ZvaXVZTURyajhnT0dPNzZYQlUyMjI5VmtFdXcyRjdwT2dJK0NNR1U4Q1BY?=
 =?utf-8?B?clViSjVqczMyNHhkL1hJd1BLWVMvZlZhZzZqeXIyRit6ZnU4MzQwNWpVK0k1?=
 =?utf-8?B?dEJ0Um5oY1hPemZqR0g3TVY3Ym1PcG0zZWxPdnFzYThkWHhMaGIwUTVPUzdj?=
 =?utf-8?B?bEVkdXlLeU9Cbis5S2hTc0dMNGpyTTNQcHpKV29VZHVqNEJGSnBLellibTFh?=
 =?utf-8?B?S1psZlVMQnFnZ2hpOTJwRGZVT1lMSEV0aEEwWFh1a0h6VWhrOTlqWlNvS0Vo?=
 =?utf-8?B?aXdIYTBqQ0VEZU1zejd2Zit0SG53L0ZKTkkzRGlEYXBYUWlsWlVJMEc0WU1K?=
 =?utf-8?B?SktqWnlBa3NQL0wxUlNwQjRXZFZsSTMzVGlOTjY5YjRtNEZ6Y1VFRWJKWm1n?=
 =?utf-8?B?L2g5TzdFR25tVDRzTC9Va2hkWENZL0tnREg3Yi9NRnJuTWxHZUcvUSs5NE4w?=
 =?utf-8?B?S2FUYjAwSklsdzVLSUgrMlRWMDRvOUJkL09hb2NYU2VSbWVrN084YkRtUW1O?=
 =?utf-8?B?Y2VwcENpc0Erek9VZjZGRy9lNGlYNlJvTHd5SXRROWk4dmdJQXdoUXk3SXE2?=
 =?utf-8?B?cklpZ1orUUFHeU9ZZGp2RGd4c2JRZmQzdlRYZEJUOUF0bzBSYlVXcEF6VVUx?=
 =?utf-8?B?eFVpZmRLajVQcjV4VHdHcEZsTC9mYTJrVWM5Wmlpa1VIZ0theUpsVXljZG1F?=
 =?utf-8?Q?USSkyTFOaqAvgrMuaLh9qVsfn28KtW/UIhAgc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(7416011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHd5a2VLR3dOZERDM1VEZVVNNGx5TjV3SWM0b083cHM3SXExZ2Q1WnhMTzJ6?=
 =?utf-8?B?VHlNMTZKcTdhMnp3WjN1bHhSTC9GM09pZ25RQ0VnRnJUbHUxOXVKWXVYd3lz?=
 =?utf-8?B?TU11TGhURldtaGVnT2hiNC9yUHFkUzNpRjBNMUh4OFRxM1QxV3hLOGFtYjZ0?=
 =?utf-8?B?cGw3bXVobEo4cldPRitXNjhzb0pBbUZkRTJIOFBPcXpQYXRLR0xRTnIrQlFS?=
 =?utf-8?B?YWZuVk1RenU0YUpLNlJ5WXBXWkxYZkZWaEVONUJMNFByQlZXWGRNUksxUHIx?=
 =?utf-8?B?UXpxYmIzcnNiZXpQZVlGQVp2NDVJYmJsc0VuNlhsVG9TMWpQOHVQUXJQS0wx?=
 =?utf-8?B?dUJEeTl3Mm9kdHlWN0YvM004YVcxbTVweTJ0cUN5cldJeW12NkxzVFExOFMr?=
 =?utf-8?B?OWI0Z080TXYyeDAzay9nRUJ1UUt6OW5uWjcxT2xjSGJvQTlsdmxYWm13V0pW?=
 =?utf-8?B?SlEwZEJZVUQxN0txM3JOQk9GbWVMdUJSVFlpUGc4UmJuYWorK3c3QjNRNDh1?=
 =?utf-8?B?L1J2cFRWQk1kTFpTTDdKdlJnN040ZkwzeUw5NU5xaTFIc3FTSCtuM3pMOGVu?=
 =?utf-8?B?YWFSaUQxNnNyY0QxSGNZMWZidkpqa3VEZVA0S0pEdy9tdnB0eUY1Tmw2Ukp2?=
 =?utf-8?B?QVB5TWozNE5pd2pUUHdZYzJ1a0FQeTdQdnlmd1ZIcTFERkFsN1hjc1dYQXR3?=
 =?utf-8?B?eEtBY2JOdk9XQ3Vha25kRVMvY01NZG1wMVlWblROWDk4REd5WGJqTzhmdWxs?=
 =?utf-8?B?Nm4vTzFFOWNtYXE5d2dZZjIrbkp2UHZkemhuOEJobTMyQksrbVNTV2dVRGtT?=
 =?utf-8?B?NU1iTzVvN1lONUFkaktaTSs1Z3BZdC9pYmNyQ0IySWcwMVQ2NVkrZ0dXd0FD?=
 =?utf-8?B?ME5jd2UzVzg2TnV5S0JxWVpHeFF1a2xxajJwU0t1SDltMzFDeEtnekZjY0pB?=
 =?utf-8?B?V1BIaGpqUjB2NElwU2tGT3pxRnFyOHZJbnZzTkJWbDlUOWdwRnVsNlhIYkoy?=
 =?utf-8?B?cGtTejdySU1aVjRkOXFUV2JIQVV0akd3NDYxYXpvQk92SkNOY0NFbkNwNGJI?=
 =?utf-8?B?K1VkdW5yamI2NE9nMWQwQ0ZlL0R5Z0xFN3dKRElwQTd4aE1HY3Y1UVNPR1VK?=
 =?utf-8?B?N0RJK2hUbjdJMDYzZ3Z6aklpVWI0djB3NzBteVBrUmYxNFFSZFprbUtCSGxY?=
 =?utf-8?B?dFhXQWlMbVBGbHhqSTYvQTlzSHhiR0hQWXBjVWtyQ2g5c1dSTVdLVmszYWdO?=
 =?utf-8?B?OG9ST2M5SWM0clFYTlB2UFl4dTcyS0xFMTE5YS9NblRIL1diQWwrVEpObkZv?=
 =?utf-8?B?Y3F1cDBoc3VhYytZQ0VndzdpSThKN29XWVNjQjF4RWlnK3BYUnVUTW1yM1RB?=
 =?utf-8?B?V1NkbHN4WVloTWpSNXpyV2lYRHo2Sks0bldiZGhLY3l4N3dvamVrdHM0N0Jv?=
 =?utf-8?B?UE5kdGpRWWRxbEVYd0ZzRVZDMGg3bmtnWTc3THNicnRDdHJ3V3F2bjlZWUdi?=
 =?utf-8?B?WjU3YWpOSzgxSTVmOXFvQnhjaXluVmxqSEpVbTA2bHFqS2JxaW00Qjc5R1Q5?=
 =?utf-8?B?YTMxUmpNazZMSVlHR1VUeWVLTmJmSzlseVhmN2dkU08yVUttcXpQaStEYk5C?=
 =?utf-8?B?RjNhTjVsRGFkOWhzVVFPVksxOEFuZXRlZEJsalcvSmhMTTRmNWlUV1BSYnVo?=
 =?utf-8?B?bFNNZjg5LzlESVk1TU9LQlVLMHZHMXp4TGhxNGJoWmpBL202bSsrenZMb2dq?=
 =?utf-8?B?d3hyYmtKQnFPa1V0NzNJQjNhZk9QbjR4aGF0MDRmejRHeEYwdjZscmo4TWFY?=
 =?utf-8?B?UFlmRzdkWUFGMEhaaURLa0Z0NWtaalp2bzNWL3FsZjlCclF0T2F1SU81ZDd1?=
 =?utf-8?B?MjFTanRJVCtPRHBMQ3lwYTJIOFhTQndOQXhNK0RDUklaTiswL3E0TmVWWHYr?=
 =?utf-8?B?Vlp3em9hdXJ1WjkyU2Qzb1Z1QW1RekRnTjNjL0ljMHpuVCtjY29lNWRBeEFJ?=
 =?utf-8?B?YkI5bEVwNzdFcDJza1hGR1cwUEp3czZmZEJjb0NYdGFZaTNUcGRLQTI3c1h6?=
 =?utf-8?B?eDl2QTJkZDBUY1JXa205Q0IybXFCSGpVd1ZjdlNONm42NkZKVWk0dFJBQjNL?=
 =?utf-8?B?RXBpeVJkQlkwRmpZejd5UGdtdXd4SStIYlZadjAvYmZSMWVVNnVVbzdhaXdv?=
 =?utf-8?Q?UO7fsvqYYZJw30H+JzRZHp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8259D2E0031A141A2257C97A34C6027@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb55e7c-674d-441d-4576-08dc951d1a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 13:45:40.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0uvaAqyLhvBl92VUzhxCa6K2j3m8lg4fGb2lLfWngXaGMXpqIK5psKxIqClgdJjBs7vhSA5y2et1KsOl0Mzglgsl2wLH/aNPh7IWJnxDKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7537
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA2LTI0IGF0IDIyOjI2IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gDQo+IElmIGl0J3Mgbm90IG9idmlvdXMsIEkgY2FuIGludmVzdGlnYXRlIHNvbWUgbW9yZSB0
b21vcnJvdyBvbiBhIG1vcmUgbm9ybWFsIFZNDQo+IGNvbmZpZ3VyYXRpb24uDQoNCkkgc2VlIHRo
ZSBzYW1lIGlzc3VlIG9uIGEgbm9ybWFsIFZNLiBDT05GSUdfREVCVUdfTE9DS19BTExPQyBzZWVt
cyB0byBiZSB0aGUNCmNyaXRpY2FsIGNvbmZpZy4NCg==


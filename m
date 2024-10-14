Return-Path: <linux-kernel+bounces-364534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C1999D5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DD0280F79
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA521C7287;
	Mon, 14 Oct 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdSAiwZY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55E1B85C0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928243; cv=fail; b=G2xcxUPjsrmukiRA8x7XvRbvH6dxjBiyMO3oEj4cYy1sRM1OXwQetbMfgKm40f9yFVyG8dX/zr7exBFjMPPB+qzaT9NKfwOClPbPMIbi3YfV/EKBZjGWRC+71mcHfzApGC/zkea/bSt05739+mWkyXiw58CL4Xr9kHofScvDiU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928243; c=relaxed/simple;
	bh=mmW2sETKh0DOJ/kkVUPyQ8/88186F2thuiYJXazha/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X3oe6M/aEan+dBrpvQN2Md//l4Qd9VZiG4E/bJJzP7gT6/pO/mqPaNIOSLoacqXPWhMa+vuF6boHvhi1AaTktd52kCSX85Zrzq4M+3XI9NgjV63hzkvGHwO0H+R2YepBbmI0l9rkBiERadJ+3nF/lqUvBJhq6R6T4DSN31aGwLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdSAiwZY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728928241; x=1760464241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mmW2sETKh0DOJ/kkVUPyQ8/88186F2thuiYJXazha/4=;
  b=NdSAiwZY5CRzT/Huh36UFqB8ph5qYRxwPoGEXtW5SrTIqEfyt3/hMi4w
   0r68rQ9RpcVO5fjKFI7Tak0S65UesDmzuUvccbmo9WPrPI7fCJca3T707
   7XUbTfmPvdlYRSGFGxik3UkbiNZH5Wh8qFW2SjdYEZwgGVALCij/F9esH
   Djn+CobobDyIj6v+p3JE3RXp7zU7dzkm4qO0AvNQfOvrNtvh0b5qDKX1J
   Rso0Qv9yJ6r8LwdMVfxOqjONNoELysxqZ4K+KGaqQeKSzFtmPc+DtLyBq
   5noamIJPS0FLFejserjCcLe9jJ2jL7R2YPJRMTIxtgMoEAOakXwFM9e1q
   A==;
X-CSE-ConnectionGUID: aF37XBy+T82ZSvYu0oY+kg==
X-CSE-MsgGUID: AYxja+2wSAenL44Ig0UNmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="15916086"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="15916086"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 10:50:41 -0700
X-CSE-ConnectionGUID: 9R5Jb0GSRhifPccE2xVV4Q==
X-CSE-MsgGUID: guCFHifZR0GvAoi6oY5BFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77258819"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 10:50:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 10:50:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 10:50:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 10:50:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 10:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2SUE/nfnR0xFicVfx0xRPFAowXeSYT6h0xX7f/xg4kv5PE7PNBs04P7M7zdNltK1PXteQ6e/7dkKUoePgfNyXhcaSTmuBmtOlFq8AZVm80CmSVrnt8J+V5oIfqEprEUtilpOU6k/17kUXieRbhJT1HznFbPqzXG/POOY5Q81AsHDYlb/qXEMp62TekY9N8QDgxduzRB7N3j53mISU4PTPonwS9jrb2m7k2qv7rs9fDHQD5W8D3dHRtVLqC20t76g6wpaKMKh+vIo50a/hsZnYvVxNVa9TnAjyEWvQYUm+HCuhQDCjZzf6sX8wTvPQ3vYYfPWtHL24OZH6bvEhTH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmW2sETKh0DOJ/kkVUPyQ8/88186F2thuiYJXazha/4=;
 b=q5tPuMyKUJFsgw4tcEE0d3yGkb/fRt7Hl4fcT4SVTCpT/MzE5FFkasTFZ2JtAsbuRdVrWPvZK2CG2Q38AnoRq5hOzjfChdHcRsOZJbqxeox5UMQcaJKjiK6vHRJDESc/0Yv6ALnxD3BCfschrgOSSG7JtvJcf8sUmuUsxo4tPw0xWpDJLVy7vhfqzZLJqWInP/l+VWeE3rYuutYXEXLegPUOPyJASNbbNnpNLbSdibYwujpXYmeDuHfBB6Pp1eCyRWWmeLSBfInXwI8CRTq2C8WCFnF0HVUTW2O7+nyXCp9OM5EHfx6O8nuZOx1gNYEUkBbPqKh33gUjXqwMXgnuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13)
 by LV3PR11MB8530.namprd11.prod.outlook.com (2603:10b6:408:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 17:50:34 +0000
Received: from PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac]) by PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:50:34 +0000
From: "Constable, Scott D" <scott.d.constable@intel.com>
To: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Milburn,
 Alyssa" <alyssa.milburn@intel.com>, "joao@overdrivepizza.com"
	<joao@overdrivepizza.com>, "jose.marchesi@oracle.com"
	<jose.marchesi@oracle.com>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>
Subject: RE: [PATCH 13/14] x86: BHI stubs
Thread-Topic: [PATCH 13/14] x86: BHI stubs
Thread-Index: AQHbERapFNubaMHC4ke6cJuSW9kYg7Jw3cUAgAAO2ACAAAQ9AIAAz/kAgAAEtgCAAzTDgIAAHF6AgBGB80A=
Date: Mon, 14 Oct 2024 17:50:33 +0000
Message-ID: <PH7PR11MB757220761F23360280DF4A0DBB442@PH7PR11MB7572.namprd11.prod.outlook.com>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
 <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
 <20240930223848.ulipiky3uw52ej56@treble>
 <20241001110310.GM5594@noisy.programming.kicks-ass.net>
 <a7912ce1-131e-4b30-bed4-2576441c6212@citrix.com>
 <20241003121739.GB17263@noisy.programming.kicks-ass.net>
 <630467e0-6cd4-441d-a2cd-070a002c6f95@citrix.com>
In-Reply-To: <630467e0-6cd4-441d-a2cd-070a002c6f95@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7572:EE_|LV3PR11MB8530:EE_
x-ms-office365-filtering-correlation-id: f59f473f-441c-470f-6d3b-08dcec78b3fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SXg1andtaTJsenRoa1o5MWkvT0hnZEdvc3lCN3QyTGlXdXBxV3JRWmRkb0lE?=
 =?utf-8?B?aTFrT01YSVVBUFV5UlVKeUhyenFNUDBYbVczcmk2eWlxL3RHeitOdTdPUFpM?=
 =?utf-8?B?TTJPVkhWMmZNcnphN0tBYzlyd280dG1UMG9ZZVQ2dmFOYUVXYnhCbjVDcDhV?=
 =?utf-8?B?SnUxc0FRTVVGd1NTUWZvMDNPblA4UkhBQW1IMGhzTEp2N3EyUy9sVzNGTW1j?=
 =?utf-8?B?dWVVMnA3U1o1SGZuTTVyeTNKWmJueE1BME5xUWp5VVgxajZTL0srRGVDUzBU?=
 =?utf-8?B?Yy9ncGlCOSt4NHBDR0xVemdRcWt5djNHNW1tYVZ4dy9sakRQMWt5SHVjN1Bk?=
 =?utf-8?B?cWhJM3NscWJCK2g1YU55ZmExWGJMMi80VjY0UFBWL0FkSDZoSURRbnhNQkEz?=
 =?utf-8?B?dWYyM0ZUV0I3cVZiZGNMdG92RkRya01RaFlOclArMnhDQ0p3Z09SVEg0dVNx?=
 =?utf-8?B?eWQvV1VIb2orRkJnMGFOaEtib0xwSHg3d3o5eXlGSXVQY21DVC95aHRMd3FN?=
 =?utf-8?B?Y2x0VUpxTzFWWi9aZzJOM3IwT2xCaGg5NGZsNmlIWmNhbHFPRXRPK05Kbi9L?=
 =?utf-8?B?NUc4QWRWYVFSdERmZWMzcnFLOVBSUjBoa1BmMGNRdExaZ0xqY08yQVZvLzN0?=
 =?utf-8?B?ZElCZ3RmQXlwa2xPcmhvQ1A0NjF4Sm1DaEF2WE9OVHVqTU9VQnJNRHBBWENi?=
 =?utf-8?B?WEcwdGdaMGJkU1YxOUJnUkpZSWxKS2l6WmN0TTVxc1htdkVudFpHdW04T2s0?=
 =?utf-8?B?MUhUbFh1OXc4cFpNanRyQS8reGQ5R1pwSjQrOVZ6Y1lkODVYRGlTaG1idUxH?=
 =?utf-8?B?ajhtZVpRMW1XNE9RWE95S1h0aHdvWFkvSFQ0T0JvVURWVlVyZXQ2bitsS2Ru?=
 =?utf-8?B?SDJ6YnRibEdNbkN3emtzaTZDdkF2QXNQUlFLa2NxdnNNMElBQVU2S0F5Tlp4?=
 =?utf-8?B?OVQ2aGFIYWJjdnFFTWlDaTdXUFNscDZEeTFWSWR0aW9FVXZBQW9XSjExWHpY?=
 =?utf-8?B?VTJqajdWNHFUaHlDUWNnUDVKQ20yZnNydnFhQmM3T0puUmVRenVDQURLVkRF?=
 =?utf-8?B?c01QZ21nb3Q2OGFMNXFvbFJNVFVPNWdnb3FscHljSEJRcGFtcDBDM0hRbUxq?=
 =?utf-8?B?b3o0eTdZdVorSEYwS1FzejFkQ3hlemFxdG9qcXFwdFlYTzB5N1pxaXorck13?=
 =?utf-8?B?NFdteDhiSVN6TDVvQmtJS0dJc3o4QUdZdmFVd2tDRUd2Z2ZCS1JmSDJaNjMr?=
 =?utf-8?B?UGxNK0ptL0FqeUw5R01UTEJKNjNJSWd0a3I1cWI3T1oxWHVKdFRZUmVYS3ky?=
 =?utf-8?B?Q3VZK3RUbm8xaTE0SWFJZS9JNVUwSUpOTWMySXpubUs4SVdaM0FnU1Z2QWtp?=
 =?utf-8?B?aXNjOFlTU3lBbkhKVmozMUEzNTZmbE0xN0RzWU8wb1FKVXU2YzFERllTeVM2?=
 =?utf-8?B?b1IzZHVocG5TL2lrYnFacDlDRzBnakV3NnlteW05c3NuOXkyUEZISEFid0xS?=
 =?utf-8?B?b1lpVEF4WWVNWWtxUzl2MkFERlRMbUtxaXJySUt4RUVraklRSGhxSDI0ZGNr?=
 =?utf-8?B?VUZ4QjExRVFER3d6anBacWUxcU1CaisrVGlhZVFEenBUdVAyTld1cG5EczBz?=
 =?utf-8?B?bytGMStSWjBsMU5YNFNPcy8wZnc1elVNdXVKQlZRQVNtTGdaOG1lalhDN1du?=
 =?utf-8?B?YmJKWUd5ZzBISHFUaUplZ1kvRkx4Sm1UMXdRS21Ld2VnQmNTMXhrdENlcjZ2?=
 =?utf-8?B?RDlzM0tZVmlzdWxnaU8wZGtNUTVmYmIxdlU2Smo5c2NpaVZ2Zm9KKzJMWDB0?=
 =?utf-8?B?Wkk3bDBQSEtoNng4QzRMQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7572.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0lERU5BTU1Dd3laZW1sV0o1NUxkanRDTDBVUmlCSjUrcXV6NmdLUG91VVFI?=
 =?utf-8?B?UFpPNWErRllHSEc3UkxWNFdxYVdaV21OcTBnaktweU5vYWN1MTVuN2FHUWlx?=
 =?utf-8?B?ZER6cHVBNWhrOHN1Zk8xNVFnREo1Q0ZpREVkek5KbytoMlpVMHd3T1RZVkNS?=
 =?utf-8?B?Q05jZVNkSngvazFPcGJmdkFhS2IrRyt0dHMzWnZjVkJ5M1k0bzNabkZtNjhk?=
 =?utf-8?B?cHhVOG9wOW41eG1NZXhvUTBpVHZtdWNoZDZVWll5dW5CNlpibkwvTm1BY1Vy?=
 =?utf-8?B?Y01LeWlHZ1JxMXdkVjdGZzhibUlzOVNDVUozbXAyRHc0ZnJNQk5UdTBLbDNt?=
 =?utf-8?B?RlcwWXo0WDZ2Qmg3OHhVbStMemJFdzJ5Si9HU2s3NXlRRXRaNGZiWDZlOWcz?=
 =?utf-8?B?bDJjWUFzNm9RZE5ST0VET0tVMWhoWEJLU055NEwzNlJVNVlEQzA5bFBPZ2xC?=
 =?utf-8?B?VERIZEhDNEltbEJTYW50TUxUazVFRGhMaC9td3FYNit2S3ZUckRRc3J0VTFk?=
 =?utf-8?B?cjgyTjFZL2g0cXV0K2cyL2MvQkNoUWIxTmtCTktWSTJSUlB0RllOc1QvWUhy?=
 =?utf-8?B?Qk5MdlV2NGYzdjRxdEVvek1MdWJmRFkwMjBWb05nell5dFY4NWcxOHpEUnVx?=
 =?utf-8?B?eGVIeFB3QjZtb0JDRVZRZUZQdUx4bUFXOC95Nk9oV2F1Smt3WUd1NUE1aTBP?=
 =?utf-8?B?VHBCcGlWdHNpMTI1OTZ1N1hIMDZwTDN2L3RuaXRyOWdtSmxxY2toRzV5bFpW?=
 =?utf-8?B?WEpRUW0wQzgwK2VNa3lvSXF6ejE5eW9iNFJLR05nbjJsSFZoWlZ5RDRIcjdK?=
 =?utf-8?B?Z0JXWlE2WFQ0VDZJWlhYOHJsdDBnajM1ZlNQNlk4YlRIM29zYmhhNzdyVCtw?=
 =?utf-8?B?aStwRVFoZEZXeGdHM1J2cG5jclZrbDhZYURXclRLV0hsMkNpeWRtM1dGTXM3?=
 =?utf-8?B?Z25XNjZEeXFiOFRvaXNjOExFd2RQZU9hSE51WU1xTlB6K2ovVklXdzAwOUdn?=
 =?utf-8?B?a240ZHpUenhITzFsUk1yYzhZakNFakxDZFhIN2NFcERJRGtTUG5qL0ZEVzMy?=
 =?utf-8?B?UGFzc0hSbGJkekpGL0RUSHJlWjIyNVppR0lWSW10UmR0WGV3UzkvUUlsVkxz?=
 =?utf-8?B?TC92RzJiRWNRSjNqQWNoSTZpSnkzNUFMWEFmY25ZanBSZG5qZmlFeVhKRGVs?=
 =?utf-8?B?dEIzb1YrTG5KYUpHaVhjaFI2MThwUWVBNS9BNjkwWjJhT2JZQUU1NEpzdjRN?=
 =?utf-8?B?bG5CMC9pMFZDZ1FFU0tEZmxkT2ZQRUxpZml1VmtFWnBTZDJwdVp4TWlLQ2xQ?=
 =?utf-8?B?Z3M2N216WXRnNzBKT0htODhZaVAxM09TTlVKeHVIWS9EU0oxZlMrbEhlazBI?=
 =?utf-8?B?NGtZMG5HQ2RhUTFEdmpmVUpJNXB6V2NFTStJOFlOazlhRzJkYVZLU0MzLzVl?=
 =?utf-8?B?ZlV6WklhYTE1VWpRQTFsc1M3WERWdllNOUlDak40QVIxOUxwOHdJellPenRq?=
 =?utf-8?B?dldLNlJ5OVZxc0xva2JwbzJaSHVWT2NTenZSYXlRMERlUU1DWisvRTlieDRO?=
 =?utf-8?B?WWc0SWRETGFrYi9WOEViNWs2TUI0SmgrMExNako1Z0RrVEw4Y0htT0xPZHdP?=
 =?utf-8?B?U1N2ZTY1RVE3L2oray8xQXV5VUgrb0xUdEVReFZUeTY2ajNWUzJOS3pCRVlq?=
 =?utf-8?B?c0RtVE8zU3BGS2lKay9FM1l4TnRXWWNxdEJ3NkNmWGtCaWpraEZZQkJyVXdW?=
 =?utf-8?B?b3ltTHIyRlNjSjR3aUNCUDdPVFVEOGFNUTQ3N0VINEpCZ3VQU3MwblcrRVJz?=
 =?utf-8?B?WVczRE0xdFJJZW92YTk5bUpHamEyM2dNREErV3VpY0NFTE8rQldXL0FsOFVh?=
 =?utf-8?B?eHNBd3gySlhpNHJBU1BDZWVlRGFyWDYwWXlCd3p4Rk9VUHhOTlVYSDBhaEN1?=
 =?utf-8?B?elBmVytQdHQveENMOEFQSkxUWDRtVllSVlI1YTBuNU1XazhWS01rOG5HZ2R1?=
 =?utf-8?B?NXZPNlNEU1BYQUcyM0dHbXBTWmNhTTk3T0NDRHo5aUsxUjZlS3dVMWtBdnNw?=
 =?utf-8?B?Qm4yNlc0Y0pRcHp3aUlRUU1pcHo4NGkreWdsZ0t3WWNPdTQ2UWtYdmc3MUs4?=
 =?utf-8?B?ZzZWYkIyMVNNeFhaTDM3eFlpWUM1eFFJNTFZK3U0elNGWWdNemhpaE1DUG9H?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7572.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59f473f-441c-470f-6d3b-08dcec78b3fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 17:50:33.9455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JZwPErbKQAicsd9UEtWJaDmUY6e1XF9+nxqRWXutp4AaCw+wXhiOR75jNFSx/0QqP4YyebOo50A3RRsXa7cxbwh31poGJjvFdeeY5pLJdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com

SGVsbG8gQW5kcmV3LA0KDQpZb3VyIG9ic2VydmF0aW9uIGlzIHZhbGlkLiBJZiB3ZSBhc3N1bWUg
dGhhdCB0aGUgaGFzaGluZyBmdW5jdGlvbiB1c2VkIGJ5IEZpbmVJQlQgaXMgdW5pZm9ybWx5IGRp
c3RyaWJ1dGVkLCB0aGVuIHRoZSBkaXN0cmlidXRpb24gb2YgaGFzaGVzIGF0IHRoZSBjYWxsIHNp
dGUgYW5kIGF0IHRoZSBjYWxsIHRhcmdldCBpcyBbMCwyXjMyLTFdLiBUaGUgZGlmZmVyZW5jZSBv
ZiB0aGUgdHdvIGhhc2hlcyBjb21wdXRlZCBpbiBSMTAgd2lsbCBoYXZlIHRoZSBzYW1lIGRpc3Ry
aWJ1dGlvbiBiZWNhdXNlIG9mIHdyYXAtYXJvdW5kLCBhbmQgdGhlIG1lYW4gb2YgdGhpcyBkaXN0
cmlidXRpb24gaXMgMl4zMS0xLiBUaGVyZWZvcmUsIHRvIHJlYXNvbmFibHkgYnlwYXNzIHRoZSBw
cm9wb3NlZCBtaXRpZ2F0aW9uLCBJIGJlbGlldmUgYW4gYXR0YWNrZXIgd291bGQgbmVlZCB0aGUg
aGFyZGVuZWQgcG9pbnRlciB0byBiZSBhZGRlZC9zdWJ0cmFjdGVkIHRvL2Zyb20gYW4gYXR0YWNr
ZXItY29udHJvbGxlZCA2NC1iaXQgdmFsdWUsIG9yIGFuIGF0dGFja2VyLWNvbnRyb2xsZWQgMzIt
Yml0IHZhbHVlIHNjYWxlZCBieSAyLCA0LCBvciA4LiBUaGVyZWZvcmUsIEkgdGhpbmsgaXQgd291
bGQgYmUgcmVhc29uYWJsZSB0byBhZGRpdGlvbmFsbHkgYXBwbHkgdGhlIENNT1YgaGFyZGVuaW5n
IHRvIGFueSAzMi0vNjQtYml0IGludGVncmFsIHBhcmFtZXRlcnMsIGluY2x1ZGluZyBlbnVtcy4g
SSBzY2FubmVkIHRoZSBrZXJuZWwgKFVidW50dSBub2JsZSA2LjggY29uZmlnKSBhbmQgZm91bmQg
dGhhdCA3NyUgb2YgcGFyYW1ldGVycyB0byBpbmRpcmVjdCBjYWxsIHRhcmdldHMgYXJlIHBvaW50
ZXJzICh3aGljaCB3ZSBhbHJlYWR5IGhhcmRlbikgYW5kIGxlc3MgdGhhbiAyMCUgYXJlIDMyLS82
NC1iaXQgaW50ZWdyYWxzIGFuZCBlbnVtcy4NCg0KSSB0aGluayB0aGF0IHRoaXMgcHJvcG9zYWwg
d291bGQgYWxzbyBhZGRyZXNzIHNvbWUgb3RoZXIgcG90ZW50aWFsIGNvcm5lciBjYXNlcywgc3Vj
aCBhczoNCi0gYW4gYXR0YWNrZXItY29udHJvbGxlZCAzMi0vNjQtYml0IGF0dGFja2VyLWNvbnRy
b2xsZWQgaW50ZWdyYWwgcGFyYW1ldGVyIGlzIHVzZWQgdG8gaW5kZXggaW50byBhIGZpeGVkLWFk
ZHJlc3MgYXJyYXkNCi0gYW4gYXR0YWNrZXItY29udHJvbGxlZCA2NC1iaXQgYXR0YWNrZXItY29u
dHJvbGxlZCBpbnRlZ3JhbCBwYXJhbWV0ZXIgaXMgY2FzdCBpbnRvIGEgcG9pbnRlcg0KDQpEb2Vz
IHRoaXMgcHJvcG9zYWwgYWRkcmVzcyB5b3VyIGNvbmNlcm4/DQoNClRoYW5rcyBhbmQgcmVnYXJk
cywNCg0KU2NvdHQgQ29uc3RhYmxlDQoNCj5PbiAwMy8xMC8yMDI0IDE6MTcgcG0sIFBldGVyIFpp
amxzdHJhIHdyb3RlOg0KPj4gT24gVHVlLCBPY3QgMDEsIDIwMjQgYXQgMTI6MjA6MDJQTSArMDEw
MCwgQW5kcmV3IENvb3BlciB3cm90ZToNCj4+PiBPbiAwMS8xMC8yMDI0IDEyOjAzIHBtLCBQZXRl
ciBaaWpsc3RyYSB3cm90ZToNCj4+Pj4gICogICBub3A0DQo+Pj4+ICAqICAgY2FsbCAqJXIxMQ0K
Pj4+Pg0KPj4+PiBBbmQgbGV0cyB0YWtlIGEgcmFuZG9tIGJoaSBmdW5jdGlvbjoNCj4+Pj4NCj4+
Pj4gKyAgICAgICAuYWxpZ24gMTYNCj4+Pj4gK1NZTV9JTk5FUl9MQUJFTChfX2JoaV9hcmdzXzBf
MSwgU1lNX0xfTE9DQUwpDQo+Pj4+ICsgICAgICAgVU5XSU5EX0hJTlRfRlVOQw0KPj4+PiArICAg
ICAgIGNtb3ZuZSAlcjEwLCAlcmRpDQo+Pj4+ICsgICAgICAgY21vdm5lICVyMTAsICVyc2kNCj4+
Pj4gKyAgICAgICBBTk5PVEFURV9VTlJFVF9TQUZFDQo+Pj4+ICsgICAgICAgcmV0DQo+Pj4+ICsg
ICAgICAgaW50Mw0KPj4+Pg0KPj4+PiBTbyB0aGUgY2FzZSB5b3Ugd29ycnkgYWJvdXQgaXMgU1VC
TCBkb2VzICpub3QqIHJlc3VsdCBpbiAwLCBidXQgd2UgDQo+Pj4+IHNwZWN1bGF0ZSBKWiB0cnVl
IGFuZCBlbmQgdXAgaW4gQ0FMTCwgYW5kIGRvIENNT1ZuZS4NCj4+Pj4NCj4+Pj4gU2luY2Ugd2Ug
c3BlY3VsYXRlZCBaLCB3ZSBtdXN0IHRoZW4gYWxzbyBub3QgZG8gdGhlIENNT1YsIHNvIHRoZSAN
Cj4+Pj4gdmFsdWUgb2YgUjEwIGlzIGlycmVsZXZhbnQsIGl0IHdpbGwgbm90IGJlIHVzZWQuIFRo
ZSB0aGluZyBob3dldmVyIA0KPj4+PiBpcyB0aGF0IENNT1Ygd2lsbCB1bmNvbmRpdGlvbmFsbHkg
cHV0IGEgc3RvcmUgZGVwZW5kZW5jeSBvbiB0aGUgDQo+Pj4+IHRhcmdldCByZWdpc3RlciAoUkRJ
LCBSU0kgaW4gdGhlIGFib3ZlIHNlcXVlbmNlKSBhbmQgYXMgc3VjaCBhbnkgDQo+Pj4+IGZ1cnRo
ZXIgc3BlY3VsYXRpdmUgY29kZSB0cnlpbmcgdG8gdXNlIHRob3NlIHJlZ2lzdGVycyB3aWxsIHN0
YWxsLg0KPj4+IEhvdyBkb2VzIHRoYXQgaGVscD8NCj4+Pg0KPj4+IFRoZSB3cml0ZSBkZXBlbmRl
bmN5IGRvZXNuJ3Qgc3RvcCBhIGRlcGVuZGVudCBsb2FkIGZyb20gZXhlY3V0aW5nIGluIA0KPj4+
IHRoZSBzaGFkb3cgb2YgYSBtaXNwcmVkaWN0ZWQgYnJhbmNoLg0KPj4gSSd2ZSBiZWVuIGdpdmVu
IHRvIHVuZGVyc3RhbmQgQ01PVmNjIHdpbGwga2lsbCBhbnkgZnVydGhlciBzcGVjdWxhdGlvbiAN
Cj4+IHVzaW5nIHRoZSB0YXJnZXQgcmVnaXN0ZXIuIFNvIGJ5ICdwb2lzb25pbmcnIGFsbCBhcmd1
bWVudCByZWdpc3RlcnMgDQo+PiB0aGF0IGFyZSBpbnZvbHZlZCB3aXRoIGxvYWRzLCB3ZSBhdm9p
ZCBhbnkgc3VjaCBsb2FkIGZyb20gaGFwcGVuaW5nIA0KPj4gZHVyaW5nIHNwZWN1bGF0aW9uLg0K
DQo+IElBTkFQQSAoSSBhbSBub3QgYSBwaXBlbGluZSBhcmNoaXRlY3QpLCBidXQgQUlVSSwNCg0K
PiBDTU9WY2MgZXN0YWJsaXNoZXMgYSBkYXRhIGRlcGVuZGVuY3kgYmV0d2VlbiBmbGFncyBhbmQg
dGhlIGRlc3RpbmF0aW9uIHJlZ2lzdGVyIHRoYXQgZG9lc24ndCBleGlzdCBpbiB0aGUgcGlwZWxp
bmUgaWYgeW91J2QgdXNlZCBhIGNvbmRpdGlvbmFsIGJyYW5jaCBpbnN0ZWFkLg0KDQo+IEl0IGRv
ZXMgcHJldmVudCBhIGRlcGVuZGVudCBsb2FkIGZyb20gZXhlY3V0aW5nIGJlZm9yZSB0aGUgQ01P
VmNjIGhhcyBleGVjdXRlZC7CoCBCdXQgaXQgZG9lcyBub3Qgc3RvcCB0aGF0IGxvYWQgZnJvbSBl
eGVjdXRpbmcgc3BlY3VsYXRpdmVseSBldmVudHVhbGx5Lg0KDQo+IFNvLCBnaXZlbiB0aGUgZm9s
bG93aW5nIGNhc2U6DQoNCj4gKiBTVUIgaXMvd2lsbCByZXN1bHRzIG5vbnplcm8gKFpGPTAsICVy
MTA9bm9uemVybykNCj4gKiBKWiBwcmVkaWN0ZWQgdGFrZW4sIGRlc3BpdGUgKFpGPTApDQoNCj4g
d2UgY2FsbCBfX2JoaV9hcmdzX1hYWCB3aGVyZWluOg0KDQo+ICogQ01PVk5aIGJsb2NrcyB1bnRp
bCBTVUIgZXhlY3V0ZXMgKGZsYWdzIGRlcGVuZGVuY3kpDQo+ICogQ01PVk5aIGV2ZW50dWFsbHkg
ZXhlY3V0ZXMsIGFuZCBiZWNhdXNlIFpGPTAsIGl0IHJlYWxseSBkb2VzIHdyaXRlDQo+ICVyMTAg
b3ZlciB0aGUgdGFyZ2V0IHJlZ2lzdGVycw0KDQo+IGFuZCB0aGVuIHdlIGVudGVyIHRoZSBmdW5j
dGlvbiB3aXRoIGFsbCBwb2ludGVycyBjb250YWluaW5nIHRoZSBub256ZXJvIHJlc2lkdWFsIGZy
b20gdGhlIGhhc2ggY2hlY2suDQoNCj4gTm93LCBiZWNhdXNlIGl0J3MgYSBTVUJMLCB0aGUgcmVz
dWx0IGlzIDwgMl4zMiwgYSBzdHJhaWdodCBkZWZlcmVuY2Ugb2Ygb25lIG9mIHRoZXNlIHBvaW50
ZXJzIHdpbGwgYmUgYmxvY2tlZCBieSBTTUFQIChub29uZSBjYXJlcyBhYm91dCAzMmJpdCwgb3Ig
cHJlLVNNQVAgaGFyZHdhcmUsIHJpZ2h0PykNCg0KPiBGb3J3YXJkIHJlZmVyZW5jZXMgZnJvbSB0
aGUgcG9pbnRlcnMgd2lsbCBiZSBzYWZlIChhc3N1bWluZyBTSUIgZG9lc24ndCByZWFjaCB0aGUg
Y2Fub25pY2FsIGJvdW5kYXJ5KSwgYnV0IGJhY2t3YXJkIHJlZmVyZW5jZXMgbWF5IHdyYXAgYXJv
dW5kIGJhY2sgaW50byB0aGUga2VybmVsIHNwYWNlLsKgIFRoZXNlIHdpbGwgbm90IGJlIGJsb2Nr
ZWQgYnkgU01BUCBhbmQgd2lsbCBzcGlsbCB0aGVpciBzZWNyZXRzIGlmIHN1aXRhYmx5IHByb3Zv
a2VkLg0KDQo+IH5BbmRyZXcNCg==


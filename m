Return-Path: <linux-kernel+bounces-337605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430FC984C40
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C471C22BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058E13B783;
	Tue, 24 Sep 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iW+Rdl+p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051E1386C6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727210516; cv=fail; b=eoQzJT2QAIc7+PmwJ7ltXg1LTOwPtDOSw/iSjK0R7QtckBUQJ3aEAVY/fRi6651e6cSNvQnp1m5I/2XyhZuZf6vPO0qH0XkZDc7AobaDD/3Zmh9So5s85SRr2WeAtqZNq2/m/m3dOosBne1+sbenQ/DBi2brehS3XaFlsUp12E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727210516; c=relaxed/simple;
	bh=kF/wwLeALLznOlVlcnqDDgn+/R1tBEJcqNFd3praJno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDGDvOI69oPcnQwpO3Xk83p/1r4012VwMHrPfrWK7CgzCC4eCkhsfZ7kY/K2nlxufsl67tY+Y+KlxF7hV+4+y1+AgvrtpEnndVMUX2a8wier27eYpOXAs7ZJa/RHdwrWKzY90B+dYPldlHAnFAvpA0aOoJcWQwf4gbSzS6NyCcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iW+Rdl+p; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727210514; x=1758746514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kF/wwLeALLznOlVlcnqDDgn+/R1tBEJcqNFd3praJno=;
  b=iW+Rdl+pc9lKzf3aX76ZMVYNmxYLfm1GZJPwU2uzhwhKHNMUc6ZU1duq
   qJndm2KhsGMfVrXBwDZu44VenObUIiat8z8tbmhVfFl4Ta3pEyj1OHtTT
   TB8Y7MIl03+x9bee/6rGzmVm0MY0d6hVOrH2zm/wIO4Qq8MWuCLAXt2Ii
   8lJ3Jp5zqOcmU1ehaEJ2Ha7SIc6e34/V19/YbqTiHI8M+pK2YmJfwM4+c
   MkhiZbHjHz9mMT6ik2Wzcl5ahPUgBX/+StX4twb3m1/lvftUmEzrgk4k/
   VLoKUya7anSV4d0+xb7dY58cpJcSmpUDtanjyVSSC9mD+py3Yk/LoWLgt
   g==;
X-CSE-ConnectionGUID: M6Vu2XMLRAGS2IQJ7+RTFA==
X-CSE-MsgGUID: xZKTlk4JRCKXEzHTVjZNGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26051652"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="26051652"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 13:41:54 -0700
X-CSE-ConnectionGUID: a6oTCdsXT+qnkqAtOTsPew==
X-CSE-MsgGUID: C1m2m8w5SMCjrwX+Fcvgvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76469435"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 13:41:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 13:41:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 13:41:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 13:41:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+bJGZuqmAuRlRhFTlxavUtDIIn/Gv5JbZ8rErJu8adZsm3ZeYOEqX6798+U0cjO8LxC0k/WdGMOeovcn324GyfR+6Mb7wCWBlM4UVEPJHfvSrW2hs6AXi5Ae53SuO57h9IYAEoTpqE4epRlQ+B2kLe61a2XA3+B2fWZ+k2ik4rEQEEu3A+dqbso8yBjzX6O5ihApbRg/qWWgyag92DKjrl4L3VWDMEKttzuIto00aFKqk8VgaD0VlfwzgEXf1H0FkxqvmmSMum6kKoZQ0cA9f4V7i+bj8GzMVpqdW+vXkbdK7fM5zh4oRRxpFVvQ4NTWkrJZrPB1PeNouNJ0r4lPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF/wwLeALLznOlVlcnqDDgn+/R1tBEJcqNFd3praJno=;
 b=nwM6CWtIRy19ry/kdTD/++IW6b312Z0cVnRYXgjiSWdkFXdipwctR6++h0m/3iQc6WPNUg1eZuG3M6fukbx27fUbna6lWCm1kzzulfH9W2RbXeMXNIYJUjT2HOGbzuWbn9JQi1+IN1FcY8E9YLI8iZl19ynZMUNlyKclOAmappktZdYMDDiwLIoVRzk/IIqWKNWkpy6rgVD8E4zccX174xCSyK8LVtNOT1FWt2AjzzT2MdxXmOpy/bw7gpyvZkNmuSIIfqpg7mr9rZD8zfVrlyOLv+QWay6YMabppzWm3FUFhHCwEBQr7VY5YqdzFlpyQhfLCiJp+ePremmu6AHmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 20:41:49 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 20:41:49 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
Thread-Topic: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
Thread-Index: AQHbDh9/7v3nj1Rpsk6L/K4X0ZY53bJnMSgAgAA2vCA=
Date: Tue, 24 Sep 2024 20:41:48 +0000
Message-ID: <SJ0PR11MB56781536ABC19E44614131E4C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
 <CAKEwX=PM0xFj0VDOndarDk2n-PxWuQdyAdjdmVoGBk+RrN2wcw@mail.gmail.com>
In-Reply-To: <CAKEwX=PM0xFj0VDOndarDk2n-PxWuQdyAdjdmVoGBk+RrN2wcw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH7PR11MB5941:EE_
x-ms-office365-filtering-correlation-id: 3afd770b-c27c-40f8-5a01-08dcdcd95020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OThwUnFZaDRUM1A0WFF0SVNyekx3NFRLeTl5YjExMExVQk1JTHNNeEdFYmlM?=
 =?utf-8?B?U3NDcCtnK3JvVWNmTzJnclhSQzI0SFNvWWFwREs2NWpqN1pkSExBWFVzbkVv?=
 =?utf-8?B?QkhSaElNNDJJVjJVQVFVM3d0b3IxbENwMFM5TDBVNWRGSmxCU2VKWFQ2WENM?=
 =?utf-8?B?ckhpd1MxWGt5MmROSXc4dmFFSXkxbmRKdGcwazZEM0dQVS9pQXQ5NWdVWjN0?=
 =?utf-8?B?SDd3cGFpNHFrMUMyZkJrSkZwNFZNOVZaS0I2VHVNUmhTMkJvUU5VVnFjMzNT?=
 =?utf-8?B?Z3F2OVRjNkc5akM4d1Z3eWF1dmxCbjhMay80UE8yOHlrOVZaeXU1UnRhTkhw?=
 =?utf-8?B?ZUgySU91bzRWdTdZaDR2d3FYTjBzQ0lLVlBURUMrN3VDSCtxUjM5KzVJWGMy?=
 =?utf-8?B?WEZrZ1NNZllqUWthM1Ixdnh5Vm1pdXV3UjVReGVNeDhub2w0K0ovRFl0YUJy?=
 =?utf-8?B?UWpXa0liR053dnF2c0Z3cUxCczZMTHFEazdkcjVaV2U0Rk80M1ovMmxmazB0?=
 =?utf-8?B?Uk1RK0NiSXJabFAzY014T0JFR0dvNzFLSzgydFZSd09hYVI2YmwyYUtOVVIw?=
 =?utf-8?B?NWNqYkNzSnJZQU5aZ3hYQkxEYWE2Tmcwai9oRFRmcDA4WWtsZFVEMUpDRnBH?=
 =?utf-8?B?c3BlWUl0SWZrNVc4TCtSNjZhM2hOWGxROW9obFZzdC9NR0VKWjRJRElOdmJ4?=
 =?utf-8?B?RkprNnRBRGZ2MTFWb1hIUHdaSzRvTG5CRkNickY5QU4yb2Yxd1JFdndpcUs4?=
 =?utf-8?B?YWp5d2FLZ0toYVNjK1EwUHlVMTkxZzY5cGYvTzVVUWNHS1RoV2d6eFBrNDRV?=
 =?utf-8?B?UmtORGNZYkxPM3hKZFNVT3hTU2JTRVhaakg0cUFuRHNXMC9lUnZyYTFDQWcz?=
 =?utf-8?B?MTRVa1V6Uyt1M1BmLzF1R3RFVHRaOElQOFE0WVFYWlZJb2RBcXo4TXlzQ2FF?=
 =?utf-8?B?aVdJWDYvSDdUWXJENnJERXVLcmFKZVhsRzU0a2VWVUltNFFEbDQwNG54T2hz?=
 =?utf-8?B?a3E1OEozSk56dFp2WWxHR3hQTDh0cWhpUVFHZDVMSTRqanhyVEp0QkVYdjI4?=
 =?utf-8?B?UHZLUXhETjVVa3FJcnpJWHpHN0pBWmQ0Z0h6TitnQjJmeWExSjVMQjBKMVRi?=
 =?utf-8?B?MjRzNnI3eEwyQ1NyM2RIdTlsT29IQ2tQNHVkZ3dMclBIeXJHMy9MeTUvL0tz?=
 =?utf-8?B?enMwTVJUckErY1c5Slc2eGVUS2FRNFh4LzRlczkvOG5VSHhjR1NJaWR3NGFF?=
 =?utf-8?B?ZkRKWG9TRjM3ZW44RDJFZWJLSTRwQ09xTGgvWnV1MmwvYUI2RXU1Z3EreE0x?=
 =?utf-8?B?MWJGOEFOMU9Za0s5aDVrQTNsdU5oaDI0YnpJMHdPdWJNSk4rN0VUUWhoNnVV?=
 =?utf-8?B?ZlNCM2pEeTNTTzhLaHRQaURiVTM3V1ZacVd0M1F4Z1dOMnJLN3pNdE1MQVU3?=
 =?utf-8?B?YVY5OXZuYzhyT2ZaRldvL05LRU5COHlrUFI1TU1iK3VOV04rOEpKRmkxSG1q?=
 =?utf-8?B?NnZrTzZucUZWM3lVcFRsSUVwRWxDZW92b201dXZxRlpkRnJqR0ZkTnMvcGp6?=
 =?utf-8?B?eWF6ZGNYZm5GQWVmc0l5eDFWM0JtSW1razJuaGdsTENRbVVWYXZ2SGlteFF4?=
 =?utf-8?B?bUZJZ0RxY0daZlBaQ01yNC9NMUp2d295SmZIZEh0ZWN2L21xclBCL1U0WWgw?=
 =?utf-8?B?QW1UL1ozWXZDTGJGeGViZWdlSkxwTlRHNFNpQWJ5RnJTdnBJSThjVDNMMm8r?=
 =?utf-8?B?d0hDNFFscUZCdkxoN2J6Ulc1M0RYTTVhTjlheUlOdzNsUmpucGJYNktpOU5P?=
 =?utf-8?B?eDBCZ3E0RWpwTTVkdkdHZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emVxWlB6UytCTkZDWTBaWXd3VFpUK05MUTFvc3VUV3JwTTdDVlkxYjgzTnpS?=
 =?utf-8?B?RzNzNzdrYy9xZWNIY2Y4b0ZOMjBDa0xNeFdRZUMwWUdUM1hmMmdBa2kxWEVp?=
 =?utf-8?B?QlExRGg3RnJnZXdtbGttQk9NMDRRb2YxeGRWdjd2SzJkMExTL0VCVGovOElK?=
 =?utf-8?B?eklDT1hMRWY5OWxFM2JkSFhRSE1RSVBUUXFxR3BWM3YrTks5Z2ZzM1Z2bDBF?=
 =?utf-8?B?YU8zbGRCUlBjU0IydDdXZ1I0czhJRHJpa2ExcUhpLytHR3dYTVZaaEMvMjdK?=
 =?utf-8?B?YmpzUi9VbnQ2d1pldEJ1ckRVUlVVa0NQaU15T2ZWbVl4Rit1WDhSWG5zd3lo?=
 =?utf-8?B?RFpPbmhGRjJkeVEyOWN5N0dPRjAvcTRuNVVydmxYdlEwSkJKU3lENEpBQk5Z?=
 =?utf-8?B?MmlpMG9NdFQ2UmRwdzBFWkE4NGVqVm1ia2N1T3ZxcGJYcStKenlvaFBnb2Jr?=
 =?utf-8?B?ODhOUjV0Y3NSdVJ3aGhCZ0VoNjg5OFc5U1FJYmNXVWVTdHlMcS9nbEE5a0hY?=
 =?utf-8?B?WXYvMG5DV2tTbWVySXFJNW9RdXBPRnhXcUE1ekovQ3dML2R3NU5QUmRlRXE2?=
 =?utf-8?B?QTExaGQyQ2wvOVAxTllLdWtvdTRxMjRkaUU2M3VLOUVXU2RCdVRSS3lsWmk0?=
 =?utf-8?B?bWRobkgyeThSSkNYV09CZ0dvU2g3NVI1SUVSVnQ5S28xVHgwUzY0WW00d0NV?=
 =?utf-8?B?QmczclBOeHRKMXFtQ3cvTDczcFBnRnpvdGdOdUxSZi9ucXBkT2RHV1hQRk02?=
 =?utf-8?B?SExQbm9QZlZLSVRURDNucVU4U0h0SnJLVWQzWmhhMGxXNEg2bFgzR0ZGSXo2?=
 =?utf-8?B?OUc2aXgxaUZNczVMVUpMY3pLWGUwL2RVb2pZcEFMLzk5K243NnYyRWREOFU3?=
 =?utf-8?B?NlBhQzRHbnhzVjQ5S2RUWHozQVFuM1JKRGZIV3VCUU5iZHZIWWxYNEZRSUFM?=
 =?utf-8?B?UTBjQ1RTSzdNRE41LzBxcUp5NlV5NlQxWVdHUGRZVlRyNS9iUjhFVFU4RmI5?=
 =?utf-8?B?Z2J4ZUtqR3ZiUWxQMVVvUXN5bzZhd3htenh6M3J5SGZOZjdYWFBySFdzSGxr?=
 =?utf-8?B?cUtzZEVtWWNTNmtvM0NnSEtjRVU4Nm9ENEZJRXRyZEFNTlAxcnduRjNidzNM?=
 =?utf-8?B?VWdrUi9CcmhqQVFoVHJUTFN5ZnluQ2Z0czRMT2tLU3RxWThNdEFURE9naXFP?=
 =?utf-8?B?UGhMdlFRdEtacjBoUUhHZlBsdWw4YjJsc1VyL1JHTVlPRkdLdnFhYjgzdzFt?=
 =?utf-8?B?NHB2b1E1ZnpxMHA2K3l2aXh6dkRLYml6V2x1T1B0MWRSb0F1VHNXVDZmQXdW?=
 =?utf-8?B?SWNtckJFRURsaUdHZ1dvTUp5aFNFNkhUbllzRFZ6OXA3Sld4aDhHcUVMeFVh?=
 =?utf-8?B?em91SUJPKysweFMzUGtPMHhCNk8rbEk5aURrNGVxMnRKemVEZkpSSkNPTWtF?=
 =?utf-8?B?L25nZTgvM3J1dVJzenE4N3lhbFNiby82cUx6QlRycFRKbURDMkI3aGFOTjhu?=
 =?utf-8?B?K1VWTGJqaHRnam0wT0xHcEVSSkIvd2J2Mm1RYmg2czgyU2FoVi9Gc24zK1BT?=
 =?utf-8?B?TlByQStvMmZWcmQxRnh6TGpMQW56a0pENzJVUDhnczNMUWk5aGxFL2ZCUUNr?=
 =?utf-8?B?L21SMTRCcTAwd1hKRys1MGQvODFKK0VnUGZ4akdiU250YXNtQjJma3Fxell6?=
 =?utf-8?B?Q3RRWlJHbGJ2eFVWOHg1OVkwMHc4OFVJOHoweWl2RjlET0xsSDRjSm5LYnZw?=
 =?utf-8?B?MzE3MzNoa1B6NG5aTXpEZVg4UXUzWTM3RWMyaGtJRnJJVTJxRlExNVRyUVFu?=
 =?utf-8?B?NDQ2L1paNTJRanozdUx1aktBY0FTMlo4ZTZxTE5PeEpPblZYWlQ1a2s3MEYr?=
 =?utf-8?B?REM3Yjk0bEg4d0dESXRrTS9VaDN3QTlBL2VFS0MzbU9ZaHlpUStUbFJqZnAw?=
 =?utf-8?B?TlVxd1Nuc3I1OUNQUGNjTUFGRWl4YkEwOWtYVnZpUWt5N1pRM3dBMFd2VTRN?=
 =?utf-8?B?NTNaRHhMYjNKMmNjME1KMzFsVzgybFFYZ3pRT1dVL2VicUpYejF2Q0NITENF?=
 =?utf-8?B?M2YyM3N6Rkw4alRieDliS0dqaVQ3SzJPTHFDUjlOVUMxZU8reU16T1h1Mi93?=
 =?utf-8?B?WmVQQk1pbjN0cWtKcHNZNUErQWVXSGR0OUNIek1LVUlkelcrZ3B4M3F5bzlz?=
 =?utf-8?B?SWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afd770b-c27c-40f8-5a01-08dcdcd95020
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 20:41:48.9869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjzYmAkhebdDzbcyM8skqzhLKbGoM/aAPmSlb+2JvNCpzAQbm/6GJ1Ersj6PTCB/HpGS4oA2f/rBhAKtukclmgEwKNkK1J28hkKiQ5urmqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgMTA6MjUgQU0N
Cj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOw0KPiBjaGVuZ21p
bmcuemhvdUBsaW51eC5kZXY7IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+IHNoYWtlZWwuYnV0
dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZw0KPiA8eWluZy5o
dWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZzsNCj4gWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2Fq
ZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9k
aC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgNC84XSBtbTogenN3
YXA6IFJlZmFjdG9yIGNvZGUgdG8gZGVsZXRlIHN0b3JlZA0KPiBvZmZzZXRzIGluIGNhc2Ugb2Yg
ZXJyb3JzLg0KPiANCj4gT24gTW9uLCBTZXAgMjMsIDIwMjQgYXQgNjoxN+KAr1BNIEthbmNoYW5h
IFAgU3JpZGhhcg0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBBZGRlZCBhIG5ldyBwcm9jZWR1cmUgenN3YXBfZGVsZXRlX3N0b3JlZF9vZmZzZXRzKCkg
dGhhdCBjYW4gYmUNCj4gPiBjYWxsZWQgdG8gZGVsZXRlIHN0b3JlZCBvZmZzZXRzIGluIGEgZm9s
aW8gaW4gY2FzZSB6c3dhcF9zdG9yZSgpDQo+ID4gZmFpbHMgb3IgenN3YXAgaXMgZGlzYWJsZWQu
DQo+ID4NCj4gPiBSZWZhY3RvcmVkIHRoZSBjb2RlIGluIHpzd2FwX3N0b3JlKCkgdGhhdCBoYW5k
bGVzIHRoZXNlIGNhc2VzLA0KPiA+IHRvIGNhbGwgenN3YXBfZGVsZXRlX3N0b3JlZF9vZmZzZXRz
KCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuYSBQIFNyaWRoYXIgPGthbmNoYW5h
LnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIG1tL3pzd2FwLmMgfCAzMyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0venN3
YXAuYyBiL21tL3pzd2FwLmMNCj4gPiBpbmRleCBmZDM1YTgxYjZlMzYuLjliZWE5NDhkNjUzZSAx
MDA2NDQNCj4gPiAtLS0gYS9tbS96c3dhcC5jDQo+ID4gKysrIGIvbW0venN3YXAuYw0KPiA+IEBA
IC0xNDM1LDggKzE0MzUsMzcgQEAgc3RhdGljIGJvb2wgenN3YXBfc3RvcmVfZW50cnkoc3RydWN0
IHhhcnJheQ0KPiAqdHJlZSwNCj4gPiAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICB9DQo+ID4N
Cj4gPiArLyoNCj4gPiArICogSWYgdGhlIHpzd2FwIHN0b3JlIGZhaWxzIG9yIHpzd2FwIGlzIGRp
c2FibGVkLCB3ZSBtdXN0IGludmFsaWRhdGUgdGhlDQo+ID4gKyAqIHBvc3NpYmx5IHN0YWxlIGVu
dHJpZXMgd2hpY2ggd2VyZSBwcmV2aW91c2x5IHN0b3JlZCBhdCB0aGUgb2Zmc2V0cw0KPiA+ICsg
KiBjb3JyZXNwb25kaW5nIHRvIGVhY2ggcGFnZSBvZiB0aGUgZm9saW8uIE90aGVyd2lzZSwgd3Jp
dGViYWNrIGNvdWxkDQo+ID4gKyAqIG92ZXJ3cml0ZSB0aGUgbmV3IGRhdGEgaW4gdGhlIHN3YXBm
aWxlLg0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIGlzIGNhbGxlZCBhZnRlciB0aGUgc3RvcmUgb2Yg
YW4gb2Zmc2V0IGluIGEgbGFyZ2UgZm9saW8gaGFzIGZhaWxlZC4NCj4gDQo+ICJzdG9yZSBvZiBh
IHN1YnBhZ2UiIHJhdGhlciB0aGFuICJzdG9yZWQgb2YgYW4gb2Zmc2V0Ij8NCg0KU3VyZSwgSSB3
aWxsIG1ha2UgdGhpcyBjaGFuZ2UgaW4gdjguDQoNCj4gDQo+IA0KPiA+ICsgKiBBbGwgenN3YXAg
ZW50cmllcyBpbiB0aGUgZm9saW8gbXVzdCBiZSBkZWxldGVkLiBUaGlzIGhlbHBzIG1ha2Ugc3Vy
ZQ0KPiA+ICsgKiB0aGF0IGEgc3dhcHBlZC1vdXQgbVRIUCBpcyBlaXRoZXIgZW50aXJlbHkgc3Rv
cmVkIGluIHpzd2FwLCBvciBlbnRpcmVseQ0KPiA+ICsgKiBub3Qgc3RvcmVkIGluIHpzd2FwLg0K
PiA+ICsgKg0KPiA+ICsgKiBUaGlzIGlzIGFsc28gY2FsbGVkIGlmIHpzd2FwX3N0b3JlKCkgaXMg
aW52b2tlZCwgYnV0IHpzd2FwIGlzIG5vdCBlbmFibGVkLg0KPiA+ICsgKiBBbGwgb2Zmc2V0cyBm
b3IgdGhlIGZvbGlvIGFyZSBkZWxldGVkIGZyb20genN3YXAgaW4gdGhpcyBjYXNlLg0KPiA+ICsg
Ki8NCj4gPiArc3RhdGljIHZvaWQgenN3YXBfZGVsZXRlX3N0b3JlZF9vZmZzZXRzKHN0cnVjdCB4
YXJyYXkgKnRyZWUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBnb2ZmX3Qgb2Zmc2V0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBsb25nIG5yX3BhZ2VzKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgenN3YXBfZW50
cnkgKmVudHJ5Ow0KPiA+ICsgICAgICAgbG9uZyBpOw0KPiA+ICsNCj4gPiArICAgICAgIGZvciAo
aSA9IDA7IGkgPCBucl9wYWdlczsgKytpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGVudHJ5ID0g
eGFfZXJhc2UodHJlZSwgb2Zmc2V0ICsgaSk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChlbnRy
eSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB6c3dhcF9lbnRyeV9mcmVlKGVudHJ5KTsN
Cj4gPiArICAgICAgIH0NCj4gPiArfQ0KPiA+ICsNCg==


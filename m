Return-Path: <linux-kernel+bounces-291335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67B6956104
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0331C21461
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51B22F19;
	Mon, 19 Aug 2024 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGVWgIVa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577B1C695
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724033724; cv=fail; b=Beb4mP0tjiNrc+VzV0aLJOICjg6BEjhJF4326JwpQ8j+Kstb+F1tIwdgA/f5zrI+4cIgjehGOVgY9AkQ/tq8IEiA2+m2EbPcxv+DZOC4+23feFSVgZDzlHTjQrUaY9PXjH+wpfQ3kOVUnrYfaEpxGl10ED6tllo/NB520WKLfTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724033724; c=relaxed/simple;
	bh=/B4fnSMXJYpIWK1I33+YUyxXlSxvjL+UczNLbLtzdxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dVYUjX3zukR20PyYBkUKropMRkkRA/KzpvYne4eYB8EY7TC1CmUhi659tp2O2SWnz0oOtkpMdervqkdplDs9mGGxXxKwpddhFJFEXfB7DwrbPN0AlAz9tSax8Do5iBDH8bCeANsSfRFmx0UpxgHh4DAE/cI6WfaLuXzberLlDKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGVWgIVa; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724033722; x=1755569722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/B4fnSMXJYpIWK1I33+YUyxXlSxvjL+UczNLbLtzdxs=;
  b=OGVWgIVaLzfthrxs6pSCTqhzsojBi3T67f8USlGes9buf7b1uQQ1LW6P
   s4uGAejMkkuoPzrEiVBnrI6a9wn0uE955qBYhL4hAu9nfyottcjZZ9xhl
   zyW+Wkz2vFWahM6KK0hQSH3jLT975fsKCtmi6WTPdhbkEYMw1gCnODvAc
   KwIevNoqtKcLtOSk5rPpSp5P8e7slbvpG8W3rCNGjbgVmrbtXKi4Yu7cu
   r8DZv+VXKqz1aNVEBUDGjSQwJwHddl/k5N5NWiVEYMlBJPhuaWpyTlPLi
   gb/D8c/6Z5emgcbVa7Mh320Nq8rhKpouDpjjco0VHttA4M0h6SWLcVEEh
   w==;
X-CSE-ConnectionGUID: cSzJ/XjbQS6TtuuPWRcGTA==
X-CSE-MsgGUID: ftvMlNvbQzeOeo342TEyJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="26126215"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="26126215"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 19:15:21 -0700
X-CSE-ConnectionGUID: 1jrTnTbjRG20uy/2yv5vWQ==
X-CSE-MsgGUID: YsSmrG+qQrOOWeb67dGDfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65187958"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 19:15:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 19:15:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 19:15:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 19:15:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 19:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky5ndT0KNUPGrWNf6OW4x9r++iOQg3pgIJC2u1sMHeHRIVZ6a7IBrSJjc+IO+dolb7iq9OarzhGd3dSTZZm8UD0L5yWM80BkI3LTAGu76G1EaosmiRqIjdj6HsGiubs2Xv+i2D4b7156XGe8upkW0k6vH/JRIHl1X3goOpCWtxbz8di1+JXET8oWlcLi9LqgjzL4cW97UniStaIgLh+zihvdsYdfEPd0/tfOKDwGqxn5ia44h7OEKLFqy12ewdWkFzsrRIiOfFhlMuUhGxVc1WYIaC+L9C8l6oDdHVEbVRQvsAYEqDfmCRUWdJk8mfaUGI0HqQ8SThRyTOqK+QQi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B4fnSMXJYpIWK1I33+YUyxXlSxvjL+UczNLbLtzdxs=;
 b=MAELb1I8WsqOcrp6RYbZ52RaV4vHUlxsvPvKbn1V5ScBUU8NL4NJWqd3yZ/ONrEkcVFDQ9ayW5y45ila0vzqVCnQgDNkB/kSofiJQScTChiA3fPFar7KPhFMrA12puiYVeRuLMC13BjJPah4UwJWLlQl3Zkdbe0DgqlhAOu6BfNlMEmYKLMaYyOs9HaGeVlX4xKkPvTCwi65sjUPUul+w3c6zaiCI1uyHdqQkjL9LZDgmvzV6Hzak4rnfbemob0OMpJmtY9tHXVEf1akQcvubpXdnmSV78Z92wNfkx476uxMkAO/x2RxBTwdG45LNnaHsVWRzMzJZnylltNTw0v2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DS0PR11MB7850.namprd11.prod.outlook.com (2603:10b6:8:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 02:15:17 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 02:15:17 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Barry Song <21cnbao@gmail.com>, lkp <lkp@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, "Zou,
 Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v3 4/4] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP stats.
Thread-Topic: [PATCH v3 4/4] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP stats.
Thread-Index: AQHa8GOnX2uCOw2KF0Kfzopbi73zCrIsI2CAgACBLgCAATO3UA==
Date: Mon, 19 Aug 2024 02:15:17 +0000
Message-ID: <SJ0PR11MB567820C0928A42CED7633DDAC98C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240817050921.18462-5-kanchana.p.sridhar@intel.com>
 <202408180729.M6uZh634-lkp@intel.com>
 <CAGsJ_4ye5f9Jecr4tH0hNwQAbCytDM99S9t=DCNK1G3-aa22-w@mail.gmail.com>
In-Reply-To: <CAGsJ_4ye5f9Jecr4tH0hNwQAbCytDM99S9t=DCNK1G3-aa22-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DS0PR11MB7850:EE_
x-ms-office365-filtering-correlation-id: 5c505ca0-cb52-474c-9550-08dcbff4c49f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TC9wVEJhQ242dkNjZXNZVjdQeVVaY1U4Rno4ZHpaTG5oN2hSemxIOHRDNE9r?=
 =?utf-8?B?ZHpjVUpQRkQybUhlS0gwQmlxQ2NFOE0wOFJPVU01OWwySzRNZkwzTCtCdk5a?=
 =?utf-8?B?T091clBvblNyL0FZSm9FV3ZLc1lPbVFIQ3g1bkZJdWhLZXplRFV1OXlvU2JC?=
 =?utf-8?B?R1djVmtQaDR6aG9nUTZaeXJ2OWFhelduYW1UTVlNa25yTjBtRFU1SXA2Q3Zl?=
 =?utf-8?B?U01SZzZiV3h1WTVRa2NPSkVSVG5aWUt5KzhJc1JIL2UwQmc4aDB1UFlqdkpO?=
 =?utf-8?B?YSs5L3FUZXh4M0cxVllseFVPa1Z5cCtvaUgzT1Yxbk8vTDA2UFBwUTg1NmRD?=
 =?utf-8?B?YUJBR1BuM2NhVVMzbWl5SDdFZWJyVUNxR2VlbEFrYnF2czZZT1RwcUljNVFw?=
 =?utf-8?B?R3B2M0NFRVY4ZDhzUHU1UXpENDFyYVdNOG1ybFVkOC9RaVZwdVdOUm1YTnYy?=
 =?utf-8?B?azk2Z1NnWFZKRWtsZlJJbEhPcmVld1J6aFp6M0hXOGgzdmV6dzQ0eHZhUHc4?=
 =?utf-8?B?UnRINEY0akVEWTRXaDJUcGY4ejQ4ckN4UEJrZlc1a2NRQzUwdzljRDFLNm1K?=
 =?utf-8?B?WGMwL2NRT1B4Z2x2ODlUY0l4ZTBDNW9ING9qVWU5RXJFMng4dWxWSUJKQmdy?=
 =?utf-8?B?WXJWM2FibEpUdEx6aVgwc0lVWm5YNWJzMUtrZ1dVM3g5eGZHdEVCeGR0azRi?=
 =?utf-8?B?ekJSd2VTRWwyWXJPQXdnSC9WeDNwODVlNkpDYTFhcmE4bVhQcU96SGozdWF0?=
 =?utf-8?B?SXIrQzdJRlJOMVUveHZ1UUhybTM2WWhhUndJOVEyWVFpTHV0NkZXQ3RmRU5k?=
 =?utf-8?B?YjhOdzYzUzNQRVNPWGlRYm44Zkt4b3FkMHI3cGQ1TUg4cFhEaDRXN0l4bFp0?=
 =?utf-8?B?Q1hEelIzYUdRZVVDeHlnNlM1d1RYR3ZLR2NCNFI3MGJxbmF4NVpQTmh6U1Rw?=
 =?utf-8?B?TmVOMG90MVFWV0JPZzJwdDVEWTltNG12ZGFjWFRYRnEyRUlnNUt2TFIxUEhr?=
 =?utf-8?B?SFNINEdLMkNuNVFqS3pIWGNHUWJ3Q1hBeUdDT2F0Nno3bFdsYytsQU9Ucnh3?=
 =?utf-8?B?RGliaHdQNGJadGgxRGhUSG5Lanc2Rjk0L2ZxSm9KUDdMcWY4Zms5aWxxRyt5?=
 =?utf-8?B?Q09NTjhWS1NzSXdnZit6TUhzampISTVnVW1jTm5GZSt5SGo0RVdjRHRWTThx?=
 =?utf-8?B?b0NlTkE4UHAwVHZrY0FMUzhPWlVvOUlNbkZWdmxvR0hNTEl0aWo2K3FCOXA2?=
 =?utf-8?B?bjQxTkxQSW1YdStZV0JmYnJwUXYvMG5FRHBRbVpxNUkwYk0wT1huY1JVRCtF?=
 =?utf-8?B?eUpVMFdRMHVZODZjTW9RdDhhclJPSjRtVnAyMWdIUkxtV0N6SzhodkUybWpv?=
 =?utf-8?B?c005eGhhVlp6N0lieXBTcUZVcHlaMHp6MmV5K1pkaUhVRmpKU0s0TGJDdHhE?=
 =?utf-8?B?b3lUOEtWQklEQStaT3ZxQWZQQUdRSGR0bHRyZDllbGhnRGhDWHBlV3ZFYjFO?=
 =?utf-8?B?WW5PaGt2bUc0RW9nK3lteG9BNTRuRFk3b1cyaEV2Mll3VEZRWE9ScitSTDl0?=
 =?utf-8?B?d0UrK0t5Y0NnNldUbktIdTA2N1NPRjdZZWswbEJYK2xQVi9meHdqQ2ZOTnlN?=
 =?utf-8?B?dDB4bDNOZXlVOWV5T1Z1c0NFVElYUXJaVmpIa3pQU3I2TDRFcXJYWWZsd1BX?=
 =?utf-8?B?U0NZUGFlTGV6UEFKMVh5eU53ZEsrYlUzSDdUdDJORGF2aFBSRmZvZnQvMy9S?=
 =?utf-8?B?VVJPeVZkMzNoakJzT0VSN2lPbjl3ZDl6Q09wVXRybS9rNTZJcE41UG1UbTA5?=
 =?utf-8?Q?nbIamG03cVj1nybtQVHAjpe3DCZaAH5SDZLf0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elJnbkxyMFpHcklUenpJVmpSYWorODJHZmVOdXUxa1ZwUzFiWDVWMlFOZ09q?=
 =?utf-8?B?ZUdlc3dFb0pzS1pDS0RWNHBuUWdEbnAxNEsvREV1OWp2bDJBU3pzWXdGellz?=
 =?utf-8?B?Y1Q5eEh5bW9vVXFzaXYrYVhkQkF5R2RBSjFxVmUwRWJyS1FUaEFIcW5abHFy?=
 =?utf-8?B?UXorNnpQeEw3YjNyd1Y2UjFoeUlDak5WYXFFVnZSdzFmWUdHdUpMeTZGc255?=
 =?utf-8?B?OU5hNVZIVjdSNzgwT0U2cDJacWxiK0d3Sis4azZhT3JmM1J3eXMybzAxdGJQ?=
 =?utf-8?B?S0k3NmRZTTFtemZEQzV1RGh0U1FkYjYzVStxUFAzbjFPOGRmNmx0OEpQOHVa?=
 =?utf-8?B?cVZhQ01ydHlLWDBlZWJMRGsrK2ZKQ2lxOTNETGRMZHI4V3N4RDlmK1U0aFh5?=
 =?utf-8?B?QjM4by9EYW5tc2hGOTZMaEJKb3RZdFlHeS94dWFySFZIdDB0M1BNME1EU3Rs?=
 =?utf-8?B?TjJMbVF3UkZBWmNHamowbmppREtTWlhKV3hkTVNoNTc3b3YzdTN1KzNNTlBs?=
 =?utf-8?B?Q0t0dVQrM3BHTmY4em5zZTliQkhYN3VSWkhLalJtdThhbXhacUJtTkdkd20x?=
 =?utf-8?B?eUdSWTZZZktocUx1M0FsVUNqdTFTZlBhY1F3VW16VGtvMVkxV2NlYkNkU1RQ?=
 =?utf-8?B?ZGZJR0FVNmU1QWgyNnYzYmtpRnVSMS9DTkprYXdEalBNNVI5NGF5YlpGeU9T?=
 =?utf-8?B?SUZmY1kvN2pueEZ3ZVh3dGRSbG5INXltNUh0UzZZMHJpVGl6dDFudFFSVWY3?=
 =?utf-8?B?V3VpQjAvbURXQlhXTDMwYnFkMURmb2hiamdqZDArQ2Z3b3RRUFk0dlF6em5y?=
 =?utf-8?B?NDVjdEU4Qmkzbkl0M3hsRk1nTVIycnk1dzE3b2wxSGRmMFB5K293UnN1cFlw?=
 =?utf-8?B?R1dRQ2prY0dDcEw5MUpJbUovVjNWV2l5dGFKY01yMlBrUWxjbFpjV1JUbGk5?=
 =?utf-8?B?bW9LajQreXgwVTlEcVVhQTZ5ZUkvSWR4NER0K3BMajVLdER4aUpUTzlsNndS?=
 =?utf-8?B?b0ozSzRYWHlmR3k3aStJRzAxcEdrTitQMkI2REVYY1FCRjZia2svRWRMVmlt?=
 =?utf-8?B?ekVkb2t4cXBCKzV3YkRrTDNHdTBSNVBnUTBWdWdTVHFjN0t0eXVLblJzR1Fj?=
 =?utf-8?B?SnFjeGlrNW1ESnI3bGNRMU5GN3lGV1ZTb3V6KzA3RXNhcDhKSytrelRaT01L?=
 =?utf-8?B?Y0UrblJwNERIcjJpZFFCUTUrMkF2M3V2dnV5WHM4VGZWaW0wbGxyQ01CdGJx?=
 =?utf-8?B?V01LZEdYSU1wYW1pYWJQZnpoQmdoTDRwTFNQSjhUY2xYaTJrTCtUcjVidmJK?=
 =?utf-8?B?aTNLRzlZbG1LRnh1VEx6bjRidU5ucWt5RU5HeU5neGo1cCtqa29aM0FsQ1hp?=
 =?utf-8?B?dWJ6WHdqK2hTa2ZrbTRMWml0RFRHOGxla3dLZTR0R3AzMjIxa2FvS01nTkNF?=
 =?utf-8?B?Q3Y1WlNnbW9rd2hHczFVNnQ5TVNQMld6d01XaGZWMVBJRGV0T3RQWkhMb25G?=
 =?utf-8?B?dkJmLzNDMTdlcGJDSVVlZ3FxK3N3WTVCOW1oa1R4RXY5N3Q5RTZnbFlRMUF0?=
 =?utf-8?B?akdRZHZXVE9PMHhLelF2QklQbHdJdkU5TmJJcXdYekZwMVlNYVQ4TEFNNU0x?=
 =?utf-8?B?ZGNMc2ZsWTgrTXhXeVJsM2hsUHhZVkRTdlZBZmR1ZUh5MlE2Z1pVQVVRbzln?=
 =?utf-8?B?L1RWdFJIazVSUEc5VE1EMm15b0F6amNLVWEyZkVlZ1REbHZiQkx6ME5XMEtp?=
 =?utf-8?B?eVpWMW1RaGNwbHpSMkdEbk9HV0VKYklSVnFPTEx2aHFiaHhZeUtZN2Vibk9t?=
 =?utf-8?B?NjkwMWRQNzNCUm9iZTZ2T0NaZXdFKzZBbWFlS29ub0IvbUUxQXdIZkJWSjBX?=
 =?utf-8?B?Vml3bURJZWN0TnNZdTJJVWtZU0FOZWRzMmZTWCtyZzViaExzSStsVGZBRjha?=
 =?utf-8?B?RXp5R1ZtSzY0UTVDTmtLazFFY2VibVV5SjBaNUFSdlJaa2h5MGxHaWVKQ1Ri?=
 =?utf-8?B?T0RucHc1Uy93VjQxUXJtVzM4REhTRWZEQkI2QU04aWgyVEIrSEhoaDcwSUhP?=
 =?utf-8?B?Nks2MGVwK0JDQXJnQU1TbFFabXNDSU0wcUhwNjNYQzNqYlNhc2FrRUxwVjZi?=
 =?utf-8?B?cnhoN2hGU0pJU2hDb2FzUDdPVzZyQVd6cWgycWpWYUNiVTk2WFRNWHlOUzBY?=
 =?utf-8?B?UFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c505ca0-cb52-474c-9550-08dcbff4c49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 02:15:17.1284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vn6MLeYoI1i+0jzYOm5uf+NrzmSZ43i+CQ+iEgjoFH2EGlt+fCsljZ+S/IUWX355rgr3yXyDbmfcZVUGz8f/JTMYBd+FtavnvTsvUtZzz84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7850
X-OriginatorOrg: intel.com

SGkgQmFycnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFycnkg
U29uZyA8MjFjbmJhb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgQXVndXN0IDE4LCAyMDI0
IDEyOjQ2IEFNDQo+IFRvOiBsa3AgPGxrcEBpbnRlbC5jb20+DQo+IENjOiBTcmlkaGFyLCBLYW5j
aGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgaGFubmVzQGNtcHhjaGcub3JnOw0K
PiB5b3NyeWFobWVkQGdvb2dsZS5jb207IG5waGFtY3NAZ21haWwuY29tOyByeWFuLnJvYmVydHNA
YXJtLmNvbTsNCj4gSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgYWtwbUBsaW51
eC1mb3VuZGF0aW9uLm9yZzsgb2Uta2J1aWxkLQ0KPiBhbGxAbGlzdHMubGludXguZGV2OyBab3Us
IE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpk
aS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA0LzRdIG1tOiBzd2FwOiBDb3VudCBzdWNj
ZXNzZnVsIG1USFAgWlNXQVAgc3RvcmVzDQo+IGluIHN5c2ZzIG1USFAgc3RhdHMuDQo+IA0KPiBP
biBTdW4sIEF1ZyAxOCwgMjAyNCBhdCAxMjowNOKAr1BNIGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIEthbmNoYW5hLA0KPiA+DQo+ID4ga2VybmVs
IHRlc3Qgcm9ib3Qgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9yczoNCj4gPg0KPiA+
IFthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24gN2M2MjZjZTRiYWUxYWMxNGY2MDA3NmQwMGVhZmU3
MWFmMzA0NTBiYV0NCj4gPg0KPiA+IHVybDogICAgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxh
Yi1sa3AvbGludXgvY29tbWl0cy9LYW5jaGFuYS1QLQ0KPiBTcmlkaGFyL21tLXpzd2FwLXpzd2Fw
X2lzX2ZvbGlvX3NhbWVfZmlsbGVkLXRha2VzLWFuLWluZGV4LWluLXRoZS0NCj4gZm9saW8vMjAy
NDA4MTctMTMxMDUzDQo+ID4gYmFzZTogICA3YzYyNmNlNGJhZTFhYzE0ZjYwMDc2ZDAwZWFmZTcx
YWYzMDQ1MGJhDQo+ID4gcGF0Y2ggbGluazogICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDI0MDgxNzA1MDkyMS4xODQ2Mi01LQ0KPiBrYW5jaGFuYS5wLnNyaWRoYXIlNDBpbnRlbC5jb20N
Cj4gPiBwYXRjaCBzdWJqZWN0OiBbUEFUQ0ggdjMgNC80XSBtbTogc3dhcDogQ291bnQgc3VjY2Vz
c2Z1bCBtVEhQIFpTV0FQDQo+IHN0b3JlcyBpbiBzeXNmcyBtVEhQIHN0YXRzLg0KPiA+IGNvbmZp
ZzogeDg2XzY0LWRlZmNvbmZpZyAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS0NCj4gY2kv
YXJjaGl2ZS8yMDI0MDgxOC8yMDI0MDgxODA3MjkuTTZ1Wmg2MzQtbGtwQGludGVsLmNvbS9jb25m
aWcpDQo+ID4gY29tcGlsZXI6IGdjYy0xMSAoRGViaWFuIDExLjMuMC0xMikgMTEuMy4wDQo+ID4g
cmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKTogKGh0dHBzOi8vZG93bmxvYWQuMDEub3Jn
LzBkYXktDQo+IGNpL2FyY2hpdmUvMjAyNDA4MTgvMjAyNDA4MTgwNzI5Lk02dVpoNjM0LWxrcEBp
bnRlbC5jb20vcmVwcm9kdWNlKQ0KPiA+DQo+ID4gSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBz
ZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcgdmVyc2lvbiBvZg0KPiA+
IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MNCj4gPiB8
IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiB8IENs
b3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI0MDgxODA3Mjku
TTZ1Wmg2MzQtDQo+IGxrcEBpbnRlbC5jb20vDQo+ID4NCj4gPiBBbGwgZXJyb3JzIChuZXcgb25l
cyBwcmVmaXhlZCBieSA+Pik6DQo+ID4NCj4gPiAgICBtbS9wYWdlX2lvLmM6IEluIGZ1bmN0aW9u
ICdjb3VudF9tdGhwX3pzd3BvdXRfdm1fZXZlbnQnOg0KPiA+ID4+IG1tL3BhZ2VfaW8uYzoxNzg6
MTc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbg0KPiAnY291bnRfbXRo
cF9zdGF0JyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiAgICAg
IDE3OCB8ICAgICAgICAgICAgICAgICBjb3VudF9tdGhwX3N0YXQoZm9saW9fb3JkZXIoZm9saW8p
LA0KPiBNVEhQX1NUQVRfWlNXUE9VVCk7DQo+ID4gICAgICAgICAgfCAgICAgICAgICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+DQo+ID4gPj4gbW0vcGFnZV9pby5jOjE3ODo1MzogZXJyb3I6ICdNVEhQ
X1NUQVRfWlNXUE9VVCcgdW5kZWNsYXJlZCAoZmlyc3QNCj4gdXNlIGluIHRoaXMgZnVuY3Rpb24p
DQo+ID4gICAgICAxNzggfCAgICAgICAgICAgICAgICAgY291bnRfbXRocF9zdGF0KGZvbGlvX29y
ZGVyKGZvbGlvKSwNCj4gTVRIUF9TVEFUX1pTV1BPVVQpOw0KPiA+ICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+DQo+ID4gICAgbW0vcGFnZV9pby5jOjE3ODo1Mzogbm90ZTogZWFjaCB1bmRlY2xhcmVk
IGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seQ0KPiBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0
IGFwcGVhcnMgaW4NCj4gPiAgICBjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBl
cnJvcnMNCj4gDQo+IGkgYmVsaWV2ZSB0aGlzIGhhcyBiZWVuIGZpeGVkIGJ5IFJ5YW4ncyBsYXRl
c3QgY2xlYW51cA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA4MDgxMTE4NDku
NjUxODY3LTItDQo+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tLw0KPiANCj4gS2FuY2hhbmEsIGlzIHlv
dXIgY29kZSBvbiB0b3Agb2YgbW0tdW5zdGFibGU/DQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRo
ZSBwb2ludGVyIHRvIFJ5YW4ncyBsYXRlc3QgY291bnRfbXRocF9zdGF0KCkgY2xlYW51cCBwYXRj
aCENCkkgd2lsbCBzdWJtaXQgbXkgcGF0Y2hlcyByZWJhc2VkIHRvIG1tLXVuc3RhYmxlLCBhbmQg
d2l0aCBjaGFuZ2VzIGFsaWduZWQgdG8NClJ5YW4ncyBwYXRjaC4gSG9wZWZ1bGx5IHRoaXMgc2hv
dWxkIHJlc29sdmUgdGhlIGtlcm5lbCByb2JvdCBidWlsZCBlcnJvcnMuIEkgYmVsaWV2ZQ0KdGhp
cyB3YXMgaGFwcGVuaW5nIGJlY2F1c2UgaW4gdjMsIEkgaGFkIG1hZGUgdGhlIGNhbGwgdG8gY291
bnRfbXRocF9zdGF0KCkgY29uZGl0aW9uYWwNCm9uIGlmZGVmIENPTkZJR19USFBfU1dBUCwgd2hl
cmVhcyAiZW51bSBtdGhwX3N0YXRfaXRlbSIgd2FzIGRlZmluZWQgYmFzZWQNCm9uIGlmZGVmIENP
TkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRSAoaW4gdjMpLg0KDQpQbGVhc2UgZG8gcmV2aWV3IHRo
ZSB2NCBhbmQgbGV0IG1lIGtub3cgaWYgdGhpcyBsb29rcyBnb29kLiBUaGFua3MgYWdhaW4uDQoN
ClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+ID4NCj4gPg0KPiA+IHZpbSArL2NvdW50X210aHBf
c3RhdCArMTc4IG1tL3BhZ2VfaW8uYw0KPiA+DQo+ID4gICAgMTc0DQo+ID4gICAgMTc1ICBzdGF0
aWMgaW5saW5lIHZvaWQgY291bnRfbXRocF96c3dwb3V0X3ZtX2V2ZW50KHN0cnVjdCBmb2xpbyAq
Zm9saW8pDQo+ID4gICAgMTc2ICB7DQo+ID4gICAgMTc3ICAgICAgICAgIGlmIChJU19FTkFCTEVE
KENPTkZJR19USFBfU1dBUCkpDQo+ID4gID4gMTc4ICAgICAgICAgICAgICAgICAgY291bnRfbXRo
cF9zdGF0KGZvbGlvX29yZGVyKGZvbGlvKSwNCj4gTVRIUF9TVEFUX1pTV1BPVVQpOw0KPiA+ICAg
IDE3OSAgfQ0KPiA+ICAgIDE4MA0KPiA+DQo+ID4gLS0NCj4gPiAwLURBWSBDSSBLZXJuZWwgVGVz
dCBTZXJ2aWNlDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2xrcC10ZXN0cy93aWtpDQo=


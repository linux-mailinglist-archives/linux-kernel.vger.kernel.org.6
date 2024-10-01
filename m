Return-Path: <linux-kernel+bounces-346375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376098C40A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7679B1C21229
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8B51CB522;
	Tue,  1 Oct 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOP3C32f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F71C8FC1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801921; cv=fail; b=RUWAxoSQ/4whi15xB062mmSvkpDpT1Qro3uSd4YKCKpWpWlbSgIE76hKOfks30RDffY3gexVyunvi+vngJR0dONGtAIJOP8SUHT778YSzrXDaFq+9UH5UAwFw8c6nsWOtRxP3wGDFbNXKrgAJDug3Mgz+YMgURJbPczUaJ3IeXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801921; c=relaxed/simple;
	bh=ow/9J6htNlz8wT/cYkI6yo92jp5X9RQc6mrByZLU1g4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a0H+t6TIbDmpkqrq0YG8d5ECuu2CvahS728DShI8NNyfpyYvS7z60tG15ERbYRBCp0wNBt+3EKJetyzy6Szm4FL6W5d3uvfALUCe++hRRWqLtN/F0gqMIxC3K39PnEmqjma9MglDTSw2cmMLKE5NqgGK9hUT+XKQ+LuKnun4t0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOP3C32f; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727801920; x=1759337920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ow/9J6htNlz8wT/cYkI6yo92jp5X9RQc6mrByZLU1g4=;
  b=GOP3C32firChdfXIoZMg8wZmk/qliayaVWhkffql8CZ5GKrxWCIYxEk8
   8nk+ZdARwO2DU6x+YiSeD0cy4IhVbg1PGLx7Rm06KyaWhsFoKbzhbumPm
   0I/jQDBCnDHjTr4BPsuC5nvs3DrDayBT1e7og2UpmRCVHi9LrAzNbAKYl
   2nC92nM6sGh/BmQbiFesHR1Iw+bZ3nl3j5n4a/qPs6pB+syzfmHNB3ySV
   SP01wawoaFAHdjmlqnLRlWToc6YVRioaT6UA1xWOqTYJpZzW5sDvdBnx1
   1FQ8TYN7HndVEeo8DJTPYUWLBYZqvXSZB55tmM63710PaTBVmpYQsdUTt
   w==;
X-CSE-ConnectionGUID: a0BaN7TXQDynpy6SUwOedg==
X-CSE-MsgGUID: YCn9QsjpRYCB9kNS6LFnzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26902392"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26902392"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:58:38 -0700
X-CSE-ConnectionGUID: gL+2zEAhR/C/+uPm5YU/DA==
X-CSE-MsgGUID: 8qqvrGt6Sd6AwMBXThPigg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="111196521"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 09:58:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 09:58:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 09:58:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 09:58:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 09:58:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw0Ggtcx5jMV5UE8r1FrxTESFlEsl1mCgkHCnujcHTaHCSlXV4pDoRdtQtd4vxo7b1yF58ntv9+ewxEn4AHHBYRg6suthNONUlgBn8sxLkJQ0A/kcNyjFjJKwFBVo9La5FTMk9yIX5Sf+x5dMqEVQTkgYN+c2rwTCrEb9aSRumXq56QBSxYmYk+1Ui6QdLRznufrzeKHCVaqAXIPF8sl/wGTFv0VX4kwlzFMrD7kPYkOi7p4QVfFMNqfkD7Fsp8gpH2W6U4dBaYqCNoq2ehZk2ydf2KfnX5Dp9aDykxPjnLGGODB6advvPKqvgrsXWYzBxXYOh/EKZiicMhFYrshsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow/9J6htNlz8wT/cYkI6yo92jp5X9RQc6mrByZLU1g4=;
 b=xl7yFmvvQs1FKhN33k6ETTUS4dO/vMqY7Q+97yYGobyeKOQMqONznHZ8b6lAu1tzjA8yygTHuvUDHqvKuW4p2ZMR9xEkYYz6NptfzNtoZ4b12wRx9MV2fy5jno9wu7/8pfACqxai8SXtP72We5EaJzzqKVvd461Gs66poLToLOYsKV4AQC1j9Sk0vMRYhZWXJAFQP+509yKM8LVVmmzo/QyCv67Vs//i0EhqPw6eNWzD1tSoYWA9VI9S4uzyNjnYGd3YHw3rnX03558YKprAyhWb15Br4v5YEZo5nZmiQPReQKqnSBrAKvH8JsPupU6bK4FbdwsiAzuEG/wPEHEQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SN7PR11MB6752.namprd11.prod.outlook.com (2603:10b6:806:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 16:58:33 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 16:58:33 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Index: AQHbE4XaXdnmYogniUi9EO2aNKPUnLJw9HoAgAAUeVCAAF5igIAAt03g
Date: Tue, 1 Oct 2024 16:58:33 +0000
Message-ID: <SJ0PR11MB567885FD8899DA83FB95DE61C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkZh6ufHQef5HjXf_F5b5LC1EATexgseD=4WvrO+a6Ni6w@mail.gmail.com>
 <SJ0PR11MB567830D47190C55F14CE75AAC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYF+Q2+f-=OK64C1dUqbnMVLLmWU1RDVrfJ9+rjBgqEbg@mail.gmail.com>
In-Reply-To: <CAJD7tkYF+Q2+f-=OK64C1dUqbnMVLLmWU1RDVrfJ9+rjBgqEbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SN7PR11MB6752:EE_
x-ms-office365-filtering-correlation-id: 636d1ecb-caf0-41fe-2d6d-08dce23a48da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZGJsSzlydU12aEsvb3JCQm5ITE1IUEViS2JNMEJ2YjduTDJ0MmVaSkJrRlRS?=
 =?utf-8?B?cW9zMTcxUURwVllxRzkxamN6dnFBc0prNVFDTEFGNEpaRXVTc1FUUmFmRnh1?=
 =?utf-8?B?TkViYW90eUtja1ZzQnIwSDlkMUEvcGR5S1Y5VGd1SU5xak1XNjlrVWJMbHVZ?=
 =?utf-8?B?ZW9Ya1IwN0NHNmgwVFEvNDZuclJiT3IzdUlTVUtJTHp1N3JGZ0xPKy9SMjdq?=
 =?utf-8?B?c3FiU1I1dFhURGEvdEt6WVJtMmtVRWc2TWFYcklkOUlJVjVROHJyaGN6ZWRE?=
 =?utf-8?B?dW1tM281V3lQYWV6Z1hYT1FrWEprMXFGbXcxWnBYRXlnLzB6V0N5SE9weFRx?=
 =?utf-8?B?K1NPbEludWswTUJ3SUtEdG5HRDNiRFN5aWpMaFFHRG5jN0ZEZktlN0lkay9G?=
 =?utf-8?B?UlV1dTlKanB3Z1V3Vi81QWZiWHlZUkJSaWVwaTNKQWNjSTAvV1FUOTVETzdE?=
 =?utf-8?B?ZWQvUE5IakpnMHZFVGxjcUJPUGdIaXAyU0xzZGFqaVp4THg4VXdKQ3VqSGVI?=
 =?utf-8?B?M3BJWlBOOVdYYnJyczNERzJaSmdVWGtVNWFsam9UZkEwd0ZvRG5MTWNWYjRk?=
 =?utf-8?B?aUxtTnRQSHI2dlo5UWg3QUF6UjdXMXY3U1U3VnFxVTRiRU54Vm5KQUg2REFr?=
 =?utf-8?B?REpQcFRmdVpRdFUvUDNidHh3YkMxeGpjT0ZSa01zL1pSYUlnSElyM1JtZ0c1?=
 =?utf-8?B?UDIzU1ljU0luaE9QaFNjZG92NmpXTUZBOWVGdU9XWCtOcHBFMWNYY3MraVJ1?=
 =?utf-8?B?VjhiKzZXNi90SHVpQVo3anFpakFoOXJ1SGNrMXA0TFlWNk52MFQ0SnJJMFVl?=
 =?utf-8?B?d0d3eHY4NVpCOXAwWi9GeUUyNGN5a0FSWldlZUhZK2FSdVc0RDMxUjNZUys1?=
 =?utf-8?B?dkpHcHZ3UHJxZ1d3WDdqSnRVci9SRC84em1yZ0x5Nkp5bU54MU9ibFZZQW9L?=
 =?utf-8?B?eHduUVNmOU84Yi9ZQTg3dVRLdHVKZFNlVWxWSFhqY3p5azZveEhRQUZGSXBD?=
 =?utf-8?B?b3U3aUdkamlwYkRRakNUNHF1Q3huakZYSmV2SGFDZnJiZlk4Y05VMVBmZnJV?=
 =?utf-8?B?VEJVQTZ3bTZuUlU0OE1tZVEvdHNobGhod3lCTU5FZmxhU2Y3TGVmRC9JM0tv?=
 =?utf-8?B?R1hCNjBqblA5MEd4WHBtOGw3dW1rTzh1OVYzanpnQjVkTmUwcExwNUhtTzJI?=
 =?utf-8?B?ZzlERkNtT0pUYTBTakdtdldxNkp0OG5WSnQyQWxMa05JQWtVTnFOdnBhK09k?=
 =?utf-8?B?b3c1czV6cjZTb2w0MTk3bXU3Tks5SkJ0dDJQelhOMWoyQlF2TEFUNTdRanA4?=
 =?utf-8?B?MUsxTW82WUZNSGFIaEozVWFDYk5DaURyaGF0TldBYzFWT0dzQXVrY2FoMGtn?=
 =?utf-8?B?TzRvK2VHVVFDaGxRaG9QNHpvdGdQN09oQWc3TXk0NXVpZXI1S2VNZGwvNUJZ?=
 =?utf-8?B?TzBIbXFjSzlWQ1pDVTVybUJ1OWFTdVNLNDM1a0JsUkR3Q0ZsNVlneDFlTmMr?=
 =?utf-8?B?NzdYdWVDbE42bmUxV2sxNHdaaGlmbEF6bEhEdU5NbDIydUUzZkV3NzJlWGJ4?=
 =?utf-8?B?bGxpTnJyeXR6bGZZeG5PNmtvM1gzMEZqSjJmamxraVhYVDVxem04RTlGOXUr?=
 =?utf-8?B?OUV1SCtnK1JGOXdHaGdaY0lXUkdySzc4YVA4a2s3UG1OaVBZVGRJTGo0MHU5?=
 =?utf-8?B?TXNiSTFvdkNESWxGNG5yOHFSdzdtek5hRk9jblVPY3ZOZDhUbFcwSnZYdTVq?=
 =?utf-8?B?dWM3SzFwWUZrOXRkM0VkdW83RENSRjV5WWNWUDNCV2VDSFIzYTFIdk1JcWNJ?=
 =?utf-8?B?QWtoYjdnRktTV1dYNitSQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rnc5QzdGMDlKNlorZ1lReDRxUkJBS1RaZExjNU43cEtFeDE3M2xxV3dnUVZ5?=
 =?utf-8?B?WHhxTmxSY0c2a01HQVQxVjQzOXZsZXgxY3gwRjA4aTd1VlFOMnFEWDVBZnlV?=
 =?utf-8?B?TWlZN0RhbjIycW8zOVhOR1dpb3JQNmdlaGpjdjJhVDFkNkNiNXlZSTMzM3Jy?=
 =?utf-8?B?Zm9XY3d6ZWcrNjNTeElHdHZiTC95SkhTL2JVSXZIdlNLOXBES0ZUSUN6aG5G?=
 =?utf-8?B?OGh6RFRUUVpNdXJ4UEJpd0RoTml3NnlwQVlnUGlXY21KS2xycFM0SEJHc3Ry?=
 =?utf-8?B?cjJSN3B3Uyt3clQxenB2ZTVSWThDMDl3aGI4a2lwMUVKWCtLTTFodS9NWVo1?=
 =?utf-8?B?eHJCZjF2TUFHVC9RVDVwNUYzOHprUXNIa1pwT0ZxS25JalhsT0cyRUlKZGtq?=
 =?utf-8?B?NE90YmZCQnZZNkdVcnNFeWF1aGROUWpzQ2t5QTRRcHB0N1pGMkQvUFpISHNo?=
 =?utf-8?B?WGl6Z0hwWWx0MlIyVTFBVjdhZlpDWG5YdGphU0pvcnhOZVVXb3lBSjZiTXVx?=
 =?utf-8?B?VEhtNGlOUWhtdFNUTkphUk43b291TXdySHpKdUFubTBVRmRpWFJMN2p4Qzlj?=
 =?utf-8?B?OVZ5am8xNFVQQnljem13SHpuSUkwOVNTOEY1enduOFlaOWhqbEZ0NHB4ZVFN?=
 =?utf-8?B?SmYrQ3BEWVZHRHNheERCQ2xOdklFTlZ3cEw2b3VZeTg0UUpIV3RxRU1Od0I3?=
 =?utf-8?B?QWtXc3B6emc4U3VReFJqdnpNd1VyNTRRODQzbXpXdmxGUnhWYjhkWkVsS2Q1?=
 =?utf-8?B?NVVqRDk4YVVGVmFOZDdjRW03Z3lvWkhiMEVnbkJsVFBDZEhpTGlJc3BWRzZG?=
 =?utf-8?B?OUt5V01JM3RGQjF2NWNvRjBoaXNJRE9SQmJxenkyTE5TNjhNQTBVZGUzMG5l?=
 =?utf-8?B?My9BQmprMjZyc250R2h0dUNOS3RxdWIvNU1FL0xIMERKNjFRd0JuRk1mVytp?=
 =?utf-8?B?REJMNmw4VjQyQ2N1Q3JWS2MzT0d0UkFubnp3K0QvLytYZ2xLS2t2YnU5MXRM?=
 =?utf-8?B?dzBuOVdxRVBQc1VCLzZzQyt4VWEvMFRMN3JBbDFPa2ozUiszbnArMG1wMG5o?=
 =?utf-8?B?blg3UzBMZnhGOTA2c3F6WmpuMDdHVUFNdG9sZUtaTUxPazVOTEJmQ1gvcGlp?=
 =?utf-8?B?VzczMEwwWTVacE5XOXdmSnFTTXdQaVpXamhhZzFlNkc0MGRGT2J3SHhJMzRK?=
 =?utf-8?B?OWtZclcvQUVrS2g2NDNMSVIyaWw4bzdoblZCV2hIWnBiYjVNVjloVnNTZ29W?=
 =?utf-8?B?R1NBOG1vRFdYbno1WmNZNzY0TGk3SUFmSEpaYVZsbk02T1dYYUVQaXZOWXRq?=
 =?utf-8?B?TFNBSm9lVHRIdENoYmh0b0ZUaTg3RnkvWS8yVktVdWhiSnZ0STFUYVU4ZTBo?=
 =?utf-8?B?eVFqRENmMHEwTk5JeC9nejJteUVibVB1UDR4WWhzR29SVTBsdHNUUGtzemoz?=
 =?utf-8?B?R3J3SEFQOS8wcDh2LytZWFdzeG9wd3d5c3pMOWY1dFBRV2ZUT1hPNGVoVlJx?=
 =?utf-8?B?Z3VpbGNaRmRGeXdZV2dpKzAvQUZXOTllMm5DSVNRckNqS21hK3RUVkh6NFUz?=
 =?utf-8?B?SFpIdHZubHYvTXFhMzRyRWZPbmZVZ3psRDgxU052RnV1ZHNaR05wT3RDUDhh?=
 =?utf-8?B?UHgyMkE2dEFWbU9NSVhwTHc2SEZORjExNE9ZT01FcFNLT1IwSGp0dGIzbVhO?=
 =?utf-8?B?b3JvTkxkOS8xaG1yZjV3em92YVVnQml1WjErQ0o0cDNzTytDTDBaTCtBaFhO?=
 =?utf-8?B?OFBOMGp2N0hONTVpL2M3ZXZpTnBhWFFleWhXYnpJQkVDTnpjWS8xVjh3aW4r?=
 =?utf-8?B?cEpQMHpSWVVxUjlQRkdiVFpVZllvREU2SDA1dXJXa0hRVFdVekczZCs5K1JH?=
 =?utf-8?B?MWtSQ1pMdlZ4SHRjUjBHSzJ6eGJkckVkL2c0UFRXaEJxZE5yeFh5VTBuZFpL?=
 =?utf-8?B?TVA3WnFQeVNLWC9rK2paV2tJVi9rNGNRTVBtRlhNRU83Ry94L1FWanJsS3F5?=
 =?utf-8?B?bXFvaHYzK1BiQzBnREhlZzhXVUsxak15MDI1bUtFazRWVC9UNXZZV1RrNitk?=
 =?utf-8?B?UDVVUjdJTHJFSmpnNlBDQ0pXeTA5N2YvaExBZkF2WnJMcTFaZUFxZnd2YUdO?=
 =?utf-8?B?VDI4S1ZRdXNBOGtObVNxSTgvWTB2elY4THpLOUNWenFYY1liOHNVNFQxVWMw?=
 =?utf-8?B?VVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 636d1ecb-caf0-41fe-2d6d-08dce23a48da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 16:58:33.7855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngPwyiGO/pGSTEUcbHyMSq5LDp/OhzcsFS5JGpLZGH4K9/eiqzU/k1wimn37R0/Y4+G3z298FZyIqdiWvmb0YcyJhDdiob5D+PaPoIlSZTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6752
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAzMCwgMjAyNCAxMTow
MCBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVs
LmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNr
Lm9yZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgY2hlbmdtaW5n
Lnpob3VAbGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyBzaGFrZWVsLmJ1dHRA
bGludXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsNCj4gSHVhbmcsIFlpbmcgPHlpbmcuaHVh
bmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+IGZvdW5kYXRp
b24ub3JnOyB3aWxseUBpbmZyYWRlYWQub3JnOyBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRl
bC5jb20+Ow0KPiBGZWdoYWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsg
R29wYWwsIFZpbm9kaA0KPiA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2OSA2LzddIG1tOiB6c3dhcDogU3VwcG9ydCBsYXJnZSBmb2xpb3MgaW4genN3YXBf
c3RvcmUoKS4NCj4gDQo+IFsuLl0NCj4gPiA+ID4gIHN0b3JlX2ZhaWxlZDoNCj4gPiA+ID4gICAg
ICAgICB6cG9vbF9mcmVlKGVudHJ5LT5wb29sLT56cG9vbCwgZW50cnktPmhhbmRsZSk7DQo+ID4g
PiA+IC1wdXRfcG9vbDoNCj4gPiA+ID4gLSAgICAgICB6c3dhcF9wb29sX3B1dChlbnRyeS0+cG9v
bCk7DQo+ID4gPiA+IC1mcmVlcGFnZToNCj4gPiA+ID4gK3B1dF9wb29sX29iamNnOg0KPiA+ID4g
PiArICAgICAgIHpzd2FwX3Bvb2xfcHV0KHBvb2wpOw0KPiA+ID4gPiArICAgICAgIG9ial9jZ3Jv
dXBfcHV0KG9iamNnKTsNCj4gPiA+DQo+ID4gPiBJIHRoaW5rIGlmIHdlIHJlb3JkZXIgdGhlIGZ1
bmN0aW9uIHdlIGNhbiBkcm9wIHRoZXNlIGNhbGxzLCBtYWtlIHRoZQ0KPiA+ID4gY29tbWVudHMg
cG9zaXRpb25lZCBhIGJpdCBiZXR0ZXIsIGFuZCBjZW50cmFsaXplIHRoZSBlbnRyeQ0KPiA+ID4g
aW5pdGlhbGl6YXRpb25zLiBJIGFtIGFsc28gbm90IGEgZmFuIG9mIHBhc3NpbmcgYSBzZW1pLWlu
aXRpYWxpemVkDQo+ID4gPiBlbnRyeSB0byB6c3dhcF9jb21wcmVzcygpIHRvIGdldCB0aGUgcG9v
bCBwb2ludGVyLg0KPiA+ID4NCj4gPiA+IERvZXMgdGhlIGZvbGxvd2luZyBkaWZmIGltcHJvdmUg
dGhpbmdzIG9yIGRpZCBJIG1pc3Mgc29tZXRoaW5nPw0KPiA+DQo+ID4gV2Ugc2hvdWxkbuKAmXQg
YmUgYWRkaW5nIHRoZSBlbnRyeSB0byB0aGUgeGFycmF5IGJlZm9yZSBpbml0aWFsaXppbmcgaXRz
IHBvb2wNCj4gPiBhbmQgb2JqY2csIHJpZ2h0PyBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBhbSBt
aXN1bmRlcnN0YW5kaW5nIHdoYXQgeW91J3JlDQo+ID4gcHJvcG9zaW5nIGluIHRoZSBkaWZmLg0K
PiANCj4gSXQgc2hvdWxkIGJlIHNhZmUuIFdlIGFscmVhZHkgaW5pdGlhbGl6ZSBlbnRyeS0+bHJ1
IGFmdGVyIHdlIGluc2VydA0KPiB0aGUgZW50cnkgaW4gdGhlIHRyZWUuIFNlZSB0aGUgY29tbWVu
dCBhYm92ZSB0aGUgY2FsbCB0bw0KPiB6c3dhcF9scnVfYWRkKCkuIEJhc2ljYWxseSB3ZSBhcmUg
cHJvdGVjdGVkIGFnYWluc3QgY29uY3VycmVudA0KPiBzdG9yZXMvbG9hZHMgdGhyb3VnaCB0aGUg
Zm9saW8gbG9jaywgYW5kIGFyZSBwcm90ZWN0ZWQgYWdhaW5zdA0KPiB3cml0ZWJhY2sgYmVjYXVz
ZSB0aGUgZW50cnkgaXMgbm90IG9uIHRoZSBMUlUgeWV0Lg0KDQpUaGFua3MgZm9yIHRoZSBjbGFy
aWZpY2F0aW9uLCBZb3NyeS4gU2luY2UgdGhpcyBpcyBhIGNoYW5nZSBpbiB0aGUgZW50cnkNCmlu
aXRpYWxpemF0aW9uIHdydCB0aGUgbWFpbmxpbmUsIGlzIGl0IE9rIGlmIHRoaXMgaXMgZG9uZSBp
biBhIGZvbGxvdy11cCBwYXRjaD8NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiANCj4gPg0KPiA+
ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9tbS96c3dhcC5jIGIvbW0venN3YXAuYw0KPiA+ID4gaW5k
ZXggYjc0YzhkZTk5NjQ2OC4uZWFjMWY4NDY4ODZhNiAxMDA2NDQNCj4gPiA+IC0tLSBhL21tL3pz
d2FwLmMNCj4gPiA+ICsrKyBiL21tL3pzd2FwLmMNCj4gPiA+IEBAIC04ODEsNyArODgxLDggQEAg
c3RhdGljIGludCB6c3dhcF9jcHVfY29tcF9kZWFkKHVuc2lnbmVkIGludA0KPiBjcHUsDQo+ID4g
PiBzdHJ1Y3QgaGxpc3Rfbm9kZSAqbm9kZSkNCj4gPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4g
PiAgfQ0KPiA+ID4NCj4gPiA+IC1zdGF0aWMgYm9vbCB6c3dhcF9jb21wcmVzcyhzdHJ1Y3QgcGFn
ZSAqcGFnZSwgc3RydWN0IHpzd2FwX2VudHJ5DQo+ICplbnRyeSkNCj4gPiA+ICtzdGF0aWMgYm9v
bCB6c3dhcF9jb21wcmVzcyhzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IHpzd2FwX2VudHJ5DQo+
ICplbnRyeSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB6c3dhcF9w
b29sICpwb29sKQ0KPiA+ID4gIHsNCj4gPiA+ICAgICAgICAgc3RydWN0IGNyeXB0b19hY29tcF9j
dHggKmFjb21wX2N0eDsNCj4gPiA+ICAgICAgICAgc3RydWN0IHNjYXR0ZXJsaXN0IGlucHV0LCBv
dXRwdXQ7DQo+ID4gPiBAQCAtODkzLDcgKzg5NCw3IEBAIHN0YXRpYyBib29sIHpzd2FwX2NvbXBy
ZXNzKHN0cnVjdCBwYWdlICpwYWdlLA0KPiA+ID4gc3RydWN0IHpzd2FwX2VudHJ5ICplbnRyeSkN
Cj4gPiA+ICAgICAgICAgZ2ZwX3QgZ2ZwOw0KPiA+ID4gICAgICAgICB1OCAqZHN0Ow0KPiA+ID4N
Cj4gPiA+IC0gICAgICAgYWNvbXBfY3R4ID0gcmF3X2NwdV9wdHIoZW50cnktPnBvb2wtPmFjb21w
X2N0eCk7DQo+ID4gPiArICAgICAgIGFjb21wX2N0eCA9IHJhd19jcHVfcHRyKHBvb2wtPmFjb21w
X2N0eCk7DQo+ID4gPg0KPiA+ID4gICAgICAgICBtdXRleF9sb2NrKCZhY29tcF9jdHgtPm11dGV4
KTsNCj4gPiA+DQo+ID4gPiBAQCAtOTI2LDcgKzkyNyw3IEBAIHN0YXRpYyBib29sIHpzd2FwX2Nv
bXByZXNzKHN0cnVjdCBwYWdlICpwYWdlLA0KPiA+ID4gc3RydWN0IHpzd2FwX2VudHJ5ICplbnRy
eSkNCj4gPiA+ICAgICAgICAgaWYgKGNvbXBfcmV0KQ0KPiA+ID4gICAgICAgICAgICAgICAgIGdv
dG8gdW5sb2NrOw0KPiA+ID4NCj4gPiA+IC0gICAgICAgenBvb2wgPSBlbnRyeS0+cG9vbC0+enBv
b2w7DQo+ID4gPiArICAgICAgIHpwb29sID0gcG9vbC0+enBvb2w7DQo+ID4gPiAgICAgICAgIGdm
cCA9IF9fR0ZQX05PUkVUUlkgfCBfX0dGUF9OT1dBUk4gfA0KPiBfX0dGUF9LU1dBUERfUkVDTEFJ
TTsNCj4gPiA+ICAgICAgICAgaWYgKHpwb29sX21hbGxvY19zdXBwb3J0X21vdmFibGUoenBvb2wp
KQ0KPiA+ID4gICAgICAgICAgICAgICAgIGdmcCB8PSBfX0dGUF9ISUdITUVNIHwgX19HRlBfTU9W
QUJMRTsNCj4gPiA+IEBAIC0xNDM1LDIzICsxNDM2LDExIEBAIHN0YXRpYyBib29sIHpzd2FwX3N0
b3JlX3BhZ2Uoc3RydWN0IHBhZ2UNCj4gPiA+ICpwYWdlLA0KPiA+ID4gICAgICAgICBlbnRyeSA9
IHpzd2FwX2VudHJ5X2NhY2hlX2FsbG9jKEdGUF9LRVJORUwsDQo+ID4gPiBmb2xpb19uaWQocGFn
ZV9mb2xpbyhwYWdlKSkpOw0KPiA+ID4gICAgICAgICBpZiAoIWVudHJ5KSB7DQo+ID4gPiAgICAg
ICAgICAgICAgICAgenN3YXBfcmVqZWN0X2ttZW1jYWNoZV9mYWlsKys7DQo+ID4gPiAtICAgICAg
ICAgICAgICAgZ290byByZWplY3Q7DQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPiA+ID4gICAgICAgICB9DQo+ID4gPg0KPiA+ID4gLSAgICAgICAvKiB6c3dhcF9zdG9yZSgp
IGFscmVhZHkgaG9sZHMgYSByZWYgb24gJ29iamNnJyBhbmQgJ3Bvb2wnICovDQo+ID4gPiAtICAg
ICAgIGlmIChvYmpjZykNCj4gPiA+IC0gICAgICAgICAgICAgICBvYmpfY2dyb3VwX2dldChvYmpj
Zyk7DQo+ID4gPiAtICAgICAgIHpzd2FwX3Bvb2xfZ2V0KHBvb2wpOw0KPiA+ID4gLQ0KPiA+ID4g
LSAgICAgICAvKiBpZiBlbnRyeSBpcyBzdWNjZXNzZnVsbHkgYWRkZWQsIGl0IGtlZXBzIHRoZSBy
ZWZlcmVuY2UgKi8NCj4gPiA+IC0gICAgICAgZW50cnktPnBvb2wgPSBwb29sOw0KPiA+ID4gLQ0K
PiA+ID4gLSAgICAgICBpZiAoIXpzd2FwX2NvbXByZXNzKHBhZ2UsIGVudHJ5KSkNCj4gPiA+IC0g
ICAgICAgICAgICAgICBnb3RvIHB1dF9wb29sX29iamNnOw0KPiA+ID4gLQ0KPiA+ID4gLSAgICAg
ICBlbnRyeS0+c3dwZW50cnkgPSBwYWdlX3N3YXBfZW50cnkocGFnZSk7DQo+ID4gPiAtICAgICAg
IGVudHJ5LT5vYmpjZyA9IG9iamNnOw0KPiA+ID4gLSAgICAgICBlbnRyeS0+cmVmZXJlbmNlZCA9
IHRydWU7DQo+ID4gPiArICAgICAgIGlmICghenN3YXBfY29tcHJlc3MocGFnZSwgZW50cnksIHBv
b2wpKQ0KPiA+ID4gKyAgICAgICAgICAgICAgIGdvdG8gY29tcHJlc3NfZmFpbGVkOw0KPiA+ID4N
Cj4gPiA+ICAgICAgICAgb2xkID0geGFfc3RvcmUodHJlZSwgc3dwX29mZnNldChlbnRyeS0+c3dw
ZW50cnkpLCBlbnRyeSwNCj4gR0ZQX0tFUk5FTCk7DQo+ID4gPiAgICAgICAgIGlmICh4YV9pc19l
cnIob2xkKSkgew0KPiA+ID4gQEAgLTE0NzAsNiArMTQ1OSwxNiBAQCBzdGF0aWMgYm9vbCB6c3dh
cF9zdG9yZV9wYWdlKHN0cnVjdCBwYWdlDQo+ICpwYWdlLA0KPiA+ID4gICAgICAgICBpZiAob2xk
KQ0KPiA+ID4gICAgICAgICAgICAgICAgIHpzd2FwX2VudHJ5X2ZyZWUob2xkKTsNCj4gPiA+DQo+
ID4gPiArICAgICAgIC8qDQo+ID4gPiArICAgICAgICAqIFRoZSBlbnRyeSBpcyBzdWNjZXNzZnVs
bHkgY29tcHJlc3NlZCBhbmQgc3RvcmVkIGluIHRoZSB0cmVlLCB0aGVyZQ0KPiBpcw0KPiA+ID4g
KyAgICAgICAgKiBubyBmdXJ0aGVyIHBvc3NpYmlsaXR5IG9mIGZhaWx1cmUuIEdyYWIgcmVmcyB0
byB0aGUgcG9vbCBhbmQgb2JqY2cuDQo+ID4gPiArICAgICAgICAqIFRoZXNlIHJlZnMgd2lsbCBi
ZSBkcm9wcGVkIGJ5IHpzd2FwX2VudHJ5X2ZyZWUoKSB3aGVuIHRoZSBlbnRyeQ0KPiBpcw0KPiA+
ID4gKyAgICAgICAgKiByZW1vdmVkIGZyb20gdGhlIHRyZWUuDQo+ID4gPiArICAgICAgICAqLw0K
PiA+ID4gKyAgICAgICB6c3dhcF9wb29sX2dldChwb29sKTsNCj4gPiA+ICsgICAgICAgaWYgKG9i
amNnKQ0KPiA+ID4gKyAgICAgICAgICAgICAgIG9ial9jZ3JvdXBfZ2V0KG9iamNnKTsNCj4gPiA+
ICsNCj4gPiA+ICAgICAgICAgLyoNCj4gPiA+ICAgICAgICAgICogV2UgZmluaXNoIGluaXRpYWxp
emluZyB0aGUgZW50cnkgd2hpbGUgaXQncyBhbHJlYWR5IGluIHhhcnJheS4NCj4gPiA+ICAgICAg
ICAgICogVGhpcyBpcyBzYWZlIGJlY2F1c2U6DQo+ID4gPiBAQCAtMTQ4MCwyNiArMTQ3OSwyMiBA
QCBzdGF0aWMgYm9vbCB6c3dhcF9zdG9yZV9wYWdlKHN0cnVjdCBwYWdlDQo+ID4gPiAqcGFnZSwN
Cj4gPiA+ICAgICAgICAgICogICAgVGhlIHB1Ymxpc2hpbmcgb3JkZXIgbWF0dGVycyB0byBwcmV2
ZW50IHdyaXRlYmFjayBmcm9tIHNlZWluZw0KPiA+ID4gICAgICAgICAgKiAgICBhbiBpbmNvaGVy
ZW50IGVudHJ5Lg0KPiA+ID4gICAgICAgICAgKi8NCj4gDQo+IEkgYW0gcmVmZXJyaW5nIHRvIHRo
ZSBjb21tZW50IGhlcmUgXg0KPiANCj4gPiA+ICsgICAgICAgZW50cnktPnBvb2wgPSBwb29sOw0K
PiA+ID4gKyAgICAgICBlbnRyeS0+c3dwZW50cnkgPSBwYWdlX3N3YXBfZW50cnkocGFnZSk7DQo+
ID4gPiArICAgICAgIGVudHJ5LT5vYmpjZyA9IG9iamNnOw0KPiA+ID4gKyAgICAgICBlbnRyeS0+
cmVmZXJlbmNlZCA9IHRydWU7DQo+ID4gPiAgICAgICAgIGlmIChlbnRyeS0+bGVuZ3RoKSB7DQo+
ID4gPiAgICAgICAgICAgICAgICAgKmNvbXByZXNzZWRfYnl0ZXMgKz0gZW50cnktPmxlbmd0aDsN
Cj4gPiA+ICAgICAgICAgICAgICAgICBJTklUX0xJU1RfSEVBRCgmZW50cnktPmxydSk7DQo+ID4g
PiAgICAgICAgICAgICAgICAgenN3YXBfbHJ1X2FkZCgmenN3YXBfbGlzdF9scnUsIGVudHJ5KTsN
Cj4gPiA+ICAgICAgICAgfQ0K


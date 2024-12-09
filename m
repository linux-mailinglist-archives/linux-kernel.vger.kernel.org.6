Return-Path: <linux-kernel+bounces-436784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A1F9E8AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52121882F71
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719D318A6B2;
	Mon,  9 Dec 2024 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIqe91DP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F0193435
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720371; cv=fail; b=kOJmXFVwE3pkhaAMIRkjaTPuYBFkPszTN+CZsHGgCG2+qcCl7e/6fG3QchxbQ8W0kCLR7quBGNBeVEeK3SKyZ6B8CZqlgia8yMd+V4Xla+MKKQ21UjNPF4LEhWAV65sTaXfxRrWo28FgoaZolqeJrXrnQfOogDPEBVMXB9IGfy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720371; c=relaxed/simple;
	bh=CiTv/AALIV66QZoQek0LVJwjIcwQOE1e0pTTHhvTUpU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QeYGsB3bMPAnNNSVyEz5w/U6GPnhthtjSI5jwVCtCoDFGyDSc3GbZnhi0FrNVwhVU4eBpIxOC/GUjh5931g0EU6RRA3jlJkh6MyltGSz6zwTR2JTr6MRdiAjZwl5rDB6iECS/0nAcjnXRshqeB9H44o7pCntQSi4WkbWWYDQrt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIqe91DP; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720370; x=1765256370;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CiTv/AALIV66QZoQek0LVJwjIcwQOE1e0pTTHhvTUpU=;
  b=cIqe91DPfwV9FJIWNx9DCid4xY304vNqd9Hsh5yUFo0IWboX9l+XVote
   eYIw3vx1HZqj0xNgQZmbzuTZoiLGTasIa1kQdAeAaq0QisJtcX6R4+il2
   EWB2+pepl7gpzcpiHOIG0o8goiIgK/QG0cN/q0hng5/hIo1hsTrgEfrlz
   89EUfj+X4cccKGXcnrEnbFqzpb1QiyJ5p4RMQSi6IeUXxB6MJ3csZfHuV
   PuWFgn7bF1QPAsQaBv/ivkOvovmGDhatylfKygyesklwZzXvdbE3x+Ekz
   8JxzOYG5kDl5BowEbYzI5ip1tYagRi+BUY2VJmcZWYWszZh/wXdG6VObo
   A==;
X-CSE-ConnectionGUID: ImolCp0VT8aXvwEs64Dzpw==
X-CSE-MsgGUID: uE5YR1fuTiWA4Nm1W3I1AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34061064"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34061064"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:59:29 -0800
X-CSE-ConnectionGUID: rTL1Q26fRTKbt1CqYOnulg==
X-CSE-MsgGUID: OpqwcYrvT3qFnF7WH2hdWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99014325"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2024 20:59:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Dec 2024 20:59:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Dec 2024 20:59:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Dec 2024 20:59:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6n6MvFYBm2PADHENZ+1fDWlLrj7y/n8IoPtJKI1FyWBDOJ1LNj4EwZHwjUuTAMLwtcQShlYa1KYasvYCKhikH48FiTJEOcFeOfUhSyIPd1wLPINsTZwpYfJziJSoBKvG85v++tv2g3ptSth7Y/IbzvTUVtEbpQHtmxtw3aDPopstE4HJa9itT7ZGjXdE4KvJUxRDwcHI04sGFNHb9P0sD6DvVJN0bwNVNmjo0t8cR7kBjlLtpSJ+v2jl0jpFuEq3ETwocJwF5ukKjtsO/AVN6mgs7s2UQf22hErYfusEsHRzu9a0I/Fxc9ngP/iz5LSyVKVNS/7T+eCWY0+EVtaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5YkC//5aD8UOrBXj0QV4RKwFTXnGFge1N+uKKsV3Eo=;
 b=xcoJyakFFiSZpfgbc35iItV1T0a08771Uh4xTfubGgaCMu0jku+ECivnlgWNSQ+47UXjbsiFRA/P+48pILyt06NWQVKzkqJfMaQU37nJIXjUea9EPNePzx/G9fuiyTpW9z+LItFn2bMMTmfYvS5+YGSZlFNxgW0KWCSWEQKA8PgdJAWr0aS9PGGa+JOlbU1o+yLDH4EG5Mc9TSdFcC9zFnlmTEQHz+rLkdvDUUHbWgnaCgaqYEVRk34Lvt9ccwcyjin/FuOvB6lumMxR7iahfHE6YnX0eY6YDSGcph/gVtJEKIs9BjDHXX25RSHqa2QbuZSxxYcKRaUZ5xxgEuKmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 04:59:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 04:59:17 +0000
Date: Mon, 9 Dec 2024 12:59:01 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, "David
 Hildenbrand" <david@redhat.com>, David Howells <dhowells@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Hillf Danton <hdanton@sina.com>, "Hugh
 Dickins" <hughd@google.com>, Jann Horn <jannh@google.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, "Mel
 Gorman" <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>,
	"Minchan Kim" <minchan@google.com>, Oleg Nesterov <oleg@redhat.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, "Peter Xu" <peterx@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, Sourav Panda
	<souravpanda@google.com>, "Vlastimil Babka" <vbabka@suse.cz>, Wei Yang
	<richard.weiyang@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [akpm-mm:mm-unstable] [mm] 85ad413389:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Z1Z5FbBHojF6ywfA@xsang-OptiPlex-9020>
References: <202412082208.db1fb2c9-lkp@intel.com>
 <CAJuCfpGeKgOgqq69OD-TMoQLhyy+HuTKK=cQPHMY2DgNcJf5Xg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGeKgOgqq69OD-TMoQLhyy+HuTKK=cQPHMY2DgNcJf5Xg@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a1bbfd-fcea-40c2-3e7b-08dd180e3c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1pSTmgwcHcrdERvcVFqR1AwRmppWjBtY3RHTFVKaVlJRkZUMVQxcjc1aE5B?=
 =?utf-8?B?d3BVMGQyN1MrZm5za1N6TUJrOWZIeFF6am1Ha09GaDhYa2k3UG9La2w1WFlE?=
 =?utf-8?B?eUNLdkpqNFJ0NFA5d3F6eEFlcHA0OUZhVE8zdWtROVB3aEI4MVlBQ0tWdFN6?=
 =?utf-8?B?TlFtVGZCU2M1V1lYdXFYLy9LaHdnWktLQ1JaSnhiTmtjd0dqOCtLTkIzR25y?=
 =?utf-8?B?RFU5TWdwRFZzcmNHdkc5ZCt3TnUvSjF1TUJGanJIWTNKaDUxaEorTVFKZjdN?=
 =?utf-8?B?S0lQY0NFZEFFOEoyaXRmd2I1M044L1prV2pqWHl2cm85emo4eVhzZFBKU0Nw?=
 =?utf-8?B?c3RrZng4bldMQU4yTFZ5MTlMUVNGanh0L0FKK1pSTG5jZzg1MTZMQWlZQUJl?=
 =?utf-8?B?Kysxa2ZuOUMrckpMY1BYRUprN25pN1lvS0RXLzdlMUV2d2xOSGh6eGZtcVNW?=
 =?utf-8?B?SUp3ZUVlZVo5UXFjM0FaVVd5UjZyUld4N1h2N2Q4bVRZeUFiQnVuT1Rvb2tB?=
 =?utf-8?B?Q2R5YjY2OTRhRnd0T1M4Yk9zeTd1OXFnSUttMnFyb3BKWUwvRXhHenNsUGpu?=
 =?utf-8?B?RktZeDJGTmlja1N2aHI0a09VNjFLUko2SDc5QVNRWmM1ZVdLdENJTjYzblVm?=
 =?utf-8?B?MFc5cHVBUFBSWDRaRVlFZXA5NmNCRUd0d1NlQmJUaHd4N2o3WlZucUZHdkpS?=
 =?utf-8?B?L002aFh6aTc5NGI1cUVPQy9xNFlrazl2OVFsSUJHSXRpTWNqenFSeGY5MVNZ?=
 =?utf-8?B?UUJJR0JlUy8ydmU1VXRvUjZFMUxRWVlUMlB1aXVPSVRnRFRBNWFyMnViNGtT?=
 =?utf-8?B?cGpUM1dQblVkaFNJcDZrbXN5RktBQlYzZ1JPUGg3UzhsVFpkc3U3UEo5a0Z5?=
 =?utf-8?B?MGxOaWtoRWRiZDhNM2ZSUlhEM3FhTE94d3Q5YjhNdm9KUlRFT0pHWjZIN2dO?=
 =?utf-8?B?aU92WWUwbkNaUzFPZFUzMWNkZmYvY0szMllNcFArK013NFRLdzJjL0tKNEUy?=
 =?utf-8?B?Z0J0NFFvZjdTU0F6WDg1UERLTEZvdjRXWmxOaUc3OG5zVUl2YVU3dHZTUTIy?=
 =?utf-8?B?Uyt2R0k4RU9OU1Q5MC8vSCtFZGxiUmRTM2liekhPVlRKS3JxMlZBSnRuWTR2?=
 =?utf-8?B?SVpYZnYyeHN0RUtFR2h3T0Q1b05waERrQWdibkNBZUt1SkpCU3UzWUhidERI?=
 =?utf-8?B?RDN0WWdSeTNFMjY2eTBxbTU1Z1RMVHZCZEVxTExlNUJTZWh4QTZ1aTR0VDBR?=
 =?utf-8?B?Zi85MlVEUHlFRExoNFgyZEZkTldQMmtoRmc0a0JzWDNIeFhLcnhYSmw1anRm?=
 =?utf-8?B?Yjl1RldIc0tnYU5yRkwwZURoNy94YkJBbXNEVG8zdStTMkt0MzE5S1B0VG5n?=
 =?utf-8?B?TEhTN1hTV0kzcjBpdUtmV1VQZ1QzM3pXUjVwbE1LMm5xV2ZMQU44L3JjWjUy?=
 =?utf-8?B?eURYSzNDMVoySTdteCtCaVFTY2llR3NpckZwUjRCUk45dVhSTE5hMTg1b2R5?=
 =?utf-8?B?VTNsYndoZ1NDRFgyTDg4Zm9FZ0hsdzNYYXlLSm1LdVNzTy8zcnNlc1lzYlMx?=
 =?utf-8?B?S2dudWVUZVNXc2RLcjhoaTZRTDU0aDJ5Mmp2eVRjc1BvY0RnaUhYbSthaU10?=
 =?utf-8?B?VGpCMmdtZ0o0K1kyYlE5VEJTQ1RyWHJwZGVtbjRzenVNYi9aREM0U3lSYVd1?=
 =?utf-8?B?dUhqYmYyeVVNVFhkKys4QktBVE90SzNLNjJtbkhKVGxZVWN0bm1WNnRwMlJi?=
 =?utf-8?B?Tks3RXQrNUwwM2ZOemZ4Z2lsRDUvVk5sVjRDWjNwUkl3Ry9XajlRNUNHMGFJ?=
 =?utf-8?Q?hc0DZHuQpseZXamFpLQsLhMku0W+ffTku2L7o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJWYzlrRTBFbFB6THhHSDluNncwMkpRWGRPVWx2bXVSNnpvV3BidHl1N0Uz?=
 =?utf-8?B?OG9ueHFJTW1YdW5iTlV3aDhDUW9oM21BVk05TzBNVmk3aWltaHlqTUcyK1lR?=
 =?utf-8?B?SXAyM01Qai94MWRTNWI0WDVnNjNMYXpMZXFCMFp4dmkrZW1Tc2ZGZEliN3Nj?=
 =?utf-8?B?MllwQWdJeFA1bW1YZ2tVZnpKVWUwMnhsd09OYlFHNDVUQ1FaQzJYYXRvcUZy?=
 =?utf-8?B?SGFEOEpYV0k2S0RYbmdmVlFuVlUzWkdTN21HN0RoYXlRQVRWTFc0SEduUHpp?=
 =?utf-8?B?cVhOdkxpdFp4cHZ6NTZHL056dFpLaUUzemdzaUJ1eDdjQnJjd3dJY24xc2k3?=
 =?utf-8?B?OXZBWkQvK0JoN29RdWpQMGFwd3Z5UkV6WmJPRkQ0MS9hYVBjNVEvT1JjNFhW?=
 =?utf-8?B?RkwvQnVEUVlxTGxicGV2aFo2TkJKNWwxcEhVeEtkcXVBTG5mMFV4NWdaTkdl?=
 =?utf-8?B?OVNEcm9tOVJzaDVhemsyU2ZzaXVWM2tkZ1RxRWhQVjFJdDB0NFErd1BDYmxy?=
 =?utf-8?B?ZHBZZTA3MHAwNlBqaks4MG84b1dEWmJFZC9WRkJkUVlNZnVvMzNDSWhOTU1u?=
 =?utf-8?B?TXNrSWtQeEdVRDk3ZGcrdHpoL0dpQ0VoazlRbGc2TDZudWtEQXN6RjYxR3NL?=
 =?utf-8?B?UFFheEU3RXphNS90Vk1LZHNWVkl4UWhaMXhMdm5RZW9vaWwxRVBPRlRMUzhl?=
 =?utf-8?B?L3lvWGp1SDMzWFM1ZzNQQ0V3NGg0WlFtWkhDTTZIYUswS25QNXRIYThBTmpr?=
 =?utf-8?B?VCtkZjlqMUtGRS9POWNzck8rQ1ByUmNJb013eXlhTnc0RnMvVU1NcmwyaURW?=
 =?utf-8?B?a0gzS2hqN1NRRlc3cERFOW4vdHdyd3h2czQzMWhPSnZ5NnpMaHhNd2oyVXlT?=
 =?utf-8?B?bGh0Z0dMSzlIQlphdkpCUXU4cHQ2NytXeGQrUk5ZRUN2ZTAvK2dDR0E0anV5?=
 =?utf-8?B?ekdwYkNZNFpjVGY4cFpjRHZudFUyRUR0ZkJhSE9ocnM4NWRZWGpCS1U2VFJQ?=
 =?utf-8?B?VE42MlhvbitKY3ptVDhQZVJicWE0UXd0VUIrS3kxRDRtZVFpR2xETWcrNWR4?=
 =?utf-8?B?dW9VWVFJMDNCNytVNWtBL2Y3UDFxUSs3UFpLZCszYTdNejgreFN4Yi9oam02?=
 =?utf-8?B?dDBHeXZkWVBZZjVCSHhOdk1vNzdMOStWaDRMNnk3SzFBYk0xMStDVUxiSkVt?=
 =?utf-8?B?Q041SUd0WG53UXRIeFZuODFPL0FMaWZCSzdDOHNINGlidHBORExtQ1ZpTE10?=
 =?utf-8?B?U2p3TTNZc09IZDlqZDhQWitDTkRMTzFPc0tZSTZzRWFYb2dOZHd2UnVrMmpi?=
 =?utf-8?B?Vy9JejVqRkI4YW53N3ZZSHN3MWw0SEI1TWkvQ3RaaXluZjFIUnphL1ZQaXFi?=
 =?utf-8?B?MzEyVW4vc1p2MnNlUEVROFhkQzkxQ3RycTVzRVB0SjkwOForRmFLTFBiWFo3?=
 =?utf-8?B?OXhkWWt3QU9xYTd5eDl3QTNKeHVMb1VyZjQ0Qjk1ckx1MUtDRlBLTTJaS2tj?=
 =?utf-8?B?WnB1R3VySkM2SzhIdjdTVmJWNnp0eDg1ZHdyVTRaR0F6T3BUYmpKSzYvTjNv?=
 =?utf-8?B?d093Tm43NFF2Tld4L2lZT3JVWXVzdThncTB5NUZBckwyVFlnZDJBV3dHTVZE?=
 =?utf-8?B?ZXpXbCs1d2dRcVQyTzhaUVFKMGZxdlJCTXpueE52a29MdUtxMGhtT2RRQTNx?=
 =?utf-8?B?UWxwc1JlcncycWhlVnhHUlJjMHkwdThIL1h0Ni81VzNHdnRNVmpoeDc4U2lK?=
 =?utf-8?B?N1hBeTJob3pEL0I0czZKQXpVMnNPYUgybEhJNG9SYVBVTzhhR29aWlZpRjI2?=
 =?utf-8?B?bUpXT2lIanBSOTVUcWowUHN4U3VkMUhWd1k3OVZQMVZ4ZmVLdGhiRVpBVDlU?=
 =?utf-8?B?YnNJVUZwRnhPanNVcXZmNTdpeGtrSGd2UGZTZVlvVjgxK2lidmxtbVF1UUU5?=
 =?utf-8?B?UGhYZVF6VjRYZllXQ0NBYmxlc2N0MnBkRzJHcnhsRHpubzVrMVo3czV3WXZK?=
 =?utf-8?B?N1I3M0MyOFdsMjFNOHpmcEJSdXB1VmlmcmRrSHBYRXVyTGcyNmNSMjZCQ0sr?=
 =?utf-8?B?SkhKb1pwREJPVXREdTdDS2VVOEJNOXBJcld2aElidGdWb0RjQ3hzYWh4T1Jx?=
 =?utf-8?B?dThPZDcxdkREYmxvOEZFcDN5L3BBdDNKMWpUZUgzNnFaUVZONFBZS2NiNytH?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a1bbfd-fcea-40c2-3e7b-08dd180e3c07
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 04:59:17.3335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pl7PY9PlCllVwL1Ip1Puo4gpx3zV6feWDmK09yNr+OvZ9AotkqZdQuqSawW6LE3h4OBDKSUI+OLCZtbsjZXyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com

hi, Suren Baghdasaryan,

On Sun, Dec 08, 2024 at 06:09:05PM -0800, Suren Baghdasaryan wrote:
> On Sun, Dec 8, 2024 at 7:26 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> >
> > commit: 85ad413389aec04cfaaba043caa8128b76c6e491 ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> > https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-unstable
> >
> > in testcase: boot
> >
> > config: i386-randconfig-141-20241208
> > compiler: gcc-11
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +------------------------------------------------+------------+------------+
> > |                                                | 98d5eefb97 | 85ad413389 |
> > +------------------------------------------------+------------+------------+
> > | BUG:kernel_NULL_pointer_dereference,address    | 0          | 12         |
> > | Oops                                           | 0          | 12         |
> > | EIP:lock_anon_vma_root                         | 0          | 12         |
> > | Kernel_panic-not_syncing:Fatal_exception       | 0          | 12         |
> > +------------------------------------------------+------------+------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202412082208.db1fb2c9-lkp@intel.com
> 
> Thanks for the report!
> It looks like anon_vma passed to lock_anon_vma_root() is NULL but it's
> not obvious to me why my patch would cause that.
> 
> Oliver, how can I reproduce this locally?
> 

To reproduce:

        # build kernel
	cd linux
	cp config-6.13.0-rc1-00162-g85ad413389ae .config
	make -j$(nproc) HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make -j$(nproc) HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


config and job-script files are attached in original report.

one thing we want to mention is this seems only reproducible with i386 config in
our tests.


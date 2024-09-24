Return-Path: <linux-kernel+bounces-337784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C95A984EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA571C22A01
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354114884D;
	Tue, 24 Sep 2024 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpTcDDdR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C29101DE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727220074; cv=fail; b=qNOlpUpDKLQ/f8eYXzRMGJjaxmM4xgtOQpG52HVtC9tAqdXGvtebcpK/GVkNtY2rE59OcyZwyPb+MPiIHQqg4F0JrVmTd+0IS7Oj+erVWZN/uAthDMjwZca8sB69F8dBioEGoljbi8BqQPKVWpYPuNXaAe4mCYAutyhTs20VbBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727220074; c=relaxed/simple;
	bh=5GEDZhnCPBIq3j5ZrJm/9CQdNLT8LlJOv8NwcwxZYdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YXncpz7jHJo0NhYPc/37mnClErE3KQpQVUhdeOaVwnTWpMBHOaGSQjBOUXOxaNJ16nP1MacaOdxD0l/8n6Ymf99ReERLcN0tHvWXQm5hUP5bvnJ1q4VWoOmEdO1jPA62+s1Gy+EZ78aLbzjsGiJcCKJlur1iFmhevAIacFameE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpTcDDdR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727220073; x=1758756073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5GEDZhnCPBIq3j5ZrJm/9CQdNLT8LlJOv8NwcwxZYdY=;
  b=IpTcDDdRf6+YvGuAGWrUeXZVCX2wwDEsrmm+0fhIRr0Nloyem38hT9MD
   +K5MedlI+xaMWLMfS1JVtmJDDYTY7+KLPz1if9kUB5R4k2GnSdoTI6nf1
   /r/Eg/641aLz45UQc50MHYNcwNIYKWWFIsRf+mcj/Pn/aGp0TouUfA9id
   X/4kuzUsdk8So5t5Cb6G69hUWv4ZhldJtFsbt+NcuHkSH7I78eOa2ffd9
   UPhDoEJAxDl9O9hk89dXVtNOgXwdEayE+Ixwcwy0Z2rv1pqi+XSg8DARX
   O+y3R85R0m1esPKqmsujgwPykfzz/0W9q0BzGXWpV0f63IGxIzzlkbKWH
   A==;
X-CSE-ConnectionGUID: P42em6WeR/+KKbF6dsvnvw==
X-CSE-MsgGUID: WG59tIADTymfQEUtl26L3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36811505"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36811505"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:21:13 -0700
X-CSE-ConnectionGUID: fewpeL8lSoa2ilXxRzPTww==
X-CSE-MsgGUID: vNCesP75TuqTyjYOGiVulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="71204871"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 16:21:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 16:21:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 16:21:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 16:21:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 16:21:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCkkVPapKNWpN7JKCinj7hvMpg3HkUDcvR/jYtgd5FPJmxLC8Yi3c18LtzogXU8mWel33RayRbK2XE8RC4sIro2EN+jDX7RI+z3Wr9PT1oVVsqchfVc5tiXFzv9jeSOf2J/WDwZmYN40DLLJdhMytGtmIZq0HyQ2F/HNq8c3bc2b232l825Err8Wp8VwYxF3AjB/sHpPP4V4k6qeW/0b0jRkDrH11RAawmIRyT6kxqxkG56lSibB6R0YVbCMjlYvapZbto7nJXKpiEu/UFtslr8+VZE/JhpiPPpESCKLcmDfKfEgX8IVpOFmrWCangkpNiQ+p8GdKr9NsqgqEE/fIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GEDZhnCPBIq3j5ZrJm/9CQdNLT8LlJOv8NwcwxZYdY=;
 b=NWVeY/QtjhIwyHxd2CtQauo9hToiauczT3KP9phCSzXGpslntRYiccQe2KZHPKkoQkquT+FQRQP4ge4dvMJKeamXSTeZhrgBp8aatDyKczv2MmTRTSkkxa24uCJV7feSecxzlX2sm7SkUcMOQZTDnbfiGUtZiFixdV9WU5NPM8OsPNG/HGhRjeWjkzAQbXHrfJ6Lpw93fx7vWxOEX5obwU2OGqF23d9Fww+E2cZCjylpkb2NZc+h0ZH2Ew3qFTe3tubzYfJRknoj5Q0cxZWpHtEf9umCYMWofinfbwUoCuz1YWFlJugBi5lUU7pPufcTzUpu276zh90+uf+SZsRLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Tue, 24 Sep
 2024 23:21:08 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 23:21:08 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAAUT4CAACVpIA==
Date: Tue, 24 Sep 2024 23:21:08 +0000
Message-ID: <SJ0PR11MB5678ABEC34FF72B0EF97CD37C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <CAKEwX=O4PJmLRLog3NGzy+r6+1XTXs_r9Nxs73CJeFeN0pcr+Q@mail.gmail.com>
In-Reply-To: <CAKEwX=O4PJmLRLog3NGzy+r6+1XTXs_r9Nxs73CJeFeN0pcr+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH0PR11MB4982:EE_
x-ms-office365-filtering-correlation-id: f9861ba4-68a9-4a7d-5047-08dcdcef91ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dWx2Ulg1ck9CQTZDbXE2amtFYlJOT0RQZXNmWHNRdWp2Z0tVNUxnRHc4Qk5L?=
 =?utf-8?B?KzVGbTBzUWYrc0FqNXcyZm5FQ3ZrNUowbGZFaXB4ZWdYOVNCZlBCdGVWY0dt?=
 =?utf-8?B?enNkeVErcUszNTAwRExLTm0vWVg5YkN4eCt4OFQyRFhQanllay9INS9qM2U0?=
 =?utf-8?B?b0h2NjhUVllOTVhvaFczR1Brb1BvWC9tTS9QOHE1WDU3WlRWZExMbGRoakV1?=
 =?utf-8?B?WTJCSHVqNWZObFhDOTZldE00UkJYMDZHS1hWNDhBbDh6UUdsQjVYMUh3clUw?=
 =?utf-8?B?Z0FQWk9ha3lvWHZ3Ri9RRzJTTmlpOUNDMUo4QUdDVnZHcFRQUVJZTjlHMEVO?=
 =?utf-8?B?bExSclZ2QTBYeWdkVmtjVUNPdlo3eW5zb25DaXdNZXA2WTVncHU1QjJ3UDN3?=
 =?utf-8?B?UzFXYmo2Y1BCbVQxbEowSFpHQjkxRVVUR3J1RnAvZHhuZ1ZLVkVzSUQrVWNt?=
 =?utf-8?B?ZHM4V21NOUM1V2o4a05MUDR5WElrZEFpVVFsb0puZy9uaW1nRG4wWVlNdzM3?=
 =?utf-8?B?ajRiMkY2WHdyVnJIM3FvazBLRVd4V3M5VjVWaTdMTDlGTDJEa1BFQmtybnpo?=
 =?utf-8?B?TExoTjRmMlBQdXhIcFdnWjdTNldodmNhYWk4cDliQThoSHl4OXRtT3dzTDBJ?=
 =?utf-8?B?S2pzekhyempOakIzWlhtMUZQUkI4RmQ2ZGMvajVSUk1Mb1I3UnpHcXl3UWZF?=
 =?utf-8?B?VGR1eEtUSFU5NjlkL0FGUmdtYUpxNzBTVkM5MWtkR1ZRKytPWklSc1R4K1JP?=
 =?utf-8?B?anZKOUc5bUgrWWtqWndMSVRpblVNbUJEQUZWR2VHZVpQaDhrZld2YXlNOGZ2?=
 =?utf-8?B?VFhnM095R20rUGQrUlAvbnpwZWFaZjVPc0FFRkFxd3p3Qk1Da3pqeXdQN2sr?=
 =?utf-8?B?d0tyalFhbEFLQW9WZnBuSnJvY1VHaVdCZGVVOTNJNXJ0VklaQUJFM2tXTDFn?=
 =?utf-8?B?Z2RGa2VPQ05JUU1yZ2JRaUx5UnZXY2hwQnEySWx6VjdQU2s3WjFjVFdQNFFM?=
 =?utf-8?B?RUY3VWxUQTYwektuM0ExaUtYRDhLbGd4WHZlZlExS0xpUzhtaXJIaXNHN2pC?=
 =?utf-8?B?Vys3T09xOHduV1oveVV2ekxiM3N5TE5jd3BDTExsKzVFRkJVd29XMmhpUUJN?=
 =?utf-8?B?VisxNzI1amd4d2c3MmQrbk5wMmFFcmQ0dFQvaXdidTNqTFVJTzhlZVVFU1ZE?=
 =?utf-8?B?em5wTG1sa3lVN0pTdUh2V3JhZmhGNWZtWkdBZGRqbjBJNWhneVdCdS96NzJN?=
 =?utf-8?B?cklIOVBjeWpBdHR6ZWNaRFJiZXF3TDRod1ZtV3ZmOTRrZ2J6YXJ6NzlGc3Bk?=
 =?utf-8?B?N0ZQRGJUZVR5L0tEUUFlYW1JU2hBSGF4T3lZZDhCNmR4SEFVTWlaNEx5NnA0?=
 =?utf-8?B?STVIR0krUG5UU0t0YUZzeE43SkpqQjlyY1hsa0xpQ210c0FuYnFETTVDVDN5?=
 =?utf-8?B?ajhhTW1YQmRtblJWK0ZYcXJ4b1BEZkR4M3dTUXNxV3NnSUR5Sk93QitnbVlo?=
 =?utf-8?B?MXRZVEY3ejBzdHVVb1lnenkwQktra1ZqTFpLa3ZrTmhvcnBNSko0ZjlrZFlX?=
 =?utf-8?B?ejBJRFJDdk16UWFVQ0xNbGoreEdBOC82a3laWFhYMDgybFl0akk5aGZKaDBt?=
 =?utf-8?B?cS9zY3dmNmUwOXRGTEFnVlZyNE5mNXl2OXJ3emdMcUlPYk9DTVFaQ250a3do?=
 =?utf-8?B?OWoyb25qUnBYUFlQNmVzQytKQS9JNms3ZmZyR2xseDRhbXZYNExveExVcnpj?=
 =?utf-8?B?TVdIZnVKWkFyVmhrZU5uT0pnb2NDNEZVTHkyb3V0czRRTGNjTFhUOE9NZllv?=
 =?utf-8?B?emtHYUhYb25oNGkybENKUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDhaYTQxSEpDMndYcm56bDJrT1BSY1FzWGcyOXV1aFN6S0FycXhLSTNjRXRQ?=
 =?utf-8?B?alhPU2crWVBjWkt5REhtWG0ramtFZHgvQ3FNQ0prbGRvYzEzR0wyNUl6Tjdl?=
 =?utf-8?B?dU11MllpclE2UWl6NGUwdmxsTC9yM1Z1K042dXdpbzJrcTIvUGhtR3VLZ1M0?=
 =?utf-8?B?alNpTC9ydjVvZjlsbkdYWkxpTzdieG9ua3J5d0J4ZjVuMGNwUDRUOU1MbFdZ?=
 =?utf-8?B?T1RmQzFFSTE1MnpZNVkvUlZnYlNpMThaU0F3aXNrN3dvK3JKbHhEQzBKSmNj?=
 =?utf-8?B?bWJoczFERXhPSEkvc2cxMUVRK3l2dFgzYU9aNGo3SzNCcHNsOC9WZ0JOd3Vi?=
 =?utf-8?B?S0xteVAxR2RPYjZaT3VWdTRPNEg4YlhkZS9CSXQvbk55UXB1bUNFa2lRTVBP?=
 =?utf-8?B?SWNPNThuaEtBK3E3cnBJUW5rWStNdnRPNnZRZ2srR05lakE5RUxRTGZ2ZnI0?=
 =?utf-8?B?U0VBU1JQYjJFVW5Nc25wdGl4bi9UMVFreWRQRjVXdjRPR3h3VEF6UjVsVEdU?=
 =?utf-8?B?aUxLdWJoU0k4YVErbW5aeGNjeTBzcnRSaHZDTjQva1l0WFRrWk1LQVo3VGN1?=
 =?utf-8?B?eE54TldBYUs5RklnVDdnWFVwZlliZE5oTXRQcVdtZ0tGb0RiZWU0OWNqN094?=
 =?utf-8?B?d2hxdTJmdTE5WTE0V0Q4c01EUTBjcENmdGlRY1BhdGdqYnI1UjF3cnJ0aE11?=
 =?utf-8?B?YWl5T2FISWVrTG1hT0hGUW9JWVpTeGlqa2tTYzhIY1lONlJUNkFENWlJdXFS?=
 =?utf-8?B?UFVlRFYxaGRTVFdweDRlQk9CRVBqNWREUlJZZ2lIOTQvTjlFMU0zT0pYWGxQ?=
 =?utf-8?B?RUQ2Mkc5ZGNUUjR2V2xtNy9HQm9PWGdJeFNvRTIweWhHaEVuYS9EWUk5OEUw?=
 =?utf-8?B?VFFrZk5EMXBBZXk5SVlra1ltZ21GcWZZU0xvQXFmT0RDZmJidmFsTWlmcGM2?=
 =?utf-8?B?ZndoZjF5UEUwYkE0cGRHbmNGTkt2b1FUMVFvSkF5T0ZrNHNsZXJzR0lzM2ZK?=
 =?utf-8?B?ckpyYlc1bzcrbCtjc0RqZnY0VmEwZDkzYTVudm9DM0lYbzRqb1VmejhXQjh3?=
 =?utf-8?B?VldUbHhjQ3pELzBqcWwwU3J5T0VvbGdhZmdUWk93T1ZJaHBsbXNBbGY1Lzd0?=
 =?utf-8?B?T254Y0lTUUF3OUYwS1R5Y3BoUzRtZm5uQS9rdWdNczF4djBPeWlUOGx2Yk9C?=
 =?utf-8?B?TjJTc3dXNHdhN3F1eHpPNkVhcFdNN2xUbGZEenFSRjdRWDd1anVreEtmbUhF?=
 =?utf-8?B?aDZMYUxWdDBnOGlCdGg3SXl3cXFiNkV2RE5pbXU3WDg5NFdlb2xvamxseDVZ?=
 =?utf-8?B?aVZiY3duTmtGeTJ4MjE5Q3owdGVkMkJXbG1iendZY3VrakJvY2RtYzNFcFRD?=
 =?utf-8?B?UDJmYzRHSkRVMytrV21TZWh1bzJWS1RGMUNHYXJGNXVFSUpFZitNQkpld3dl?=
 =?utf-8?B?Y1Y3TG5hY1kvbUxIY29EZEdOVExvOGwxQWFZbnIrUy9CWjBWZlRlYW9FMG4w?=
 =?utf-8?B?MjE5OEMzWXVrZlVSMy9acUZNVTk4UUxoVU50UG1IVUpjeXUwN3RpdS82eEY5?=
 =?utf-8?B?MWx2eXJRLy9rOVMvM3hGNllrN0VzTjBRZUpVZnZZNDdabHdkejF0QjFyRU43?=
 =?utf-8?B?empLQUtJZGtteDUxYmo3RHdrc1Yzdlc4dzNBNVNzT3J0ZTFiY3R4VGRKMVpH?=
 =?utf-8?B?dFFuWnFnd3cxVVZrdUdLdERFVTZxbXNaN0g1UVBGdmZDTTE4amZmRVJhakJT?=
 =?utf-8?B?SlJwZHJQVWlOUURmcUdDWThBZXFiS011QWJuYlVPaWxqSW8xZ3M4TzRLU0dD?=
 =?utf-8?B?aWRRS1R1WmhGY0ZzbnpHaitSbnl2SS9nWWtVaGpqUjFRVzlCUzFDdnNsM01P?=
 =?utf-8?B?cjFRU1F3VURWeFRHcE85N2kyYkwxSFlXMURoeTJPeVRWNTRUR3Q4NE5GcW9E?=
 =?utf-8?B?cE9nRkFWV1UxUnFVT0hOTkJ3cEhmOUgzUkpIczY0UC9FMWxSdzdVcFZEYUhZ?=
 =?utf-8?B?eEhZZ3d4bVY3S0VDeUlFbHd0bG1mUkJaTDhzcWt2Q2xMaGhoTUFDMDNvNUtZ?=
 =?utf-8?B?S1UxdXFBMytPSjU4cjdLbnRIVkp3cUIyeFhmV0hoVjJpZHZXck93YlVEMTN6?=
 =?utf-8?B?aW56aUNMaUs5cmE3Zm9DaHZnSEJ3U2I0WmJiQlU5SGFiMkxzc092azUvQUl6?=
 =?utf-8?B?Vmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9861ba4-68a9-4a7d-5047-08dcdcef91ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 23:21:08.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/yVNyQ5vuN+T897sIh4vmJLwbGfRIE1RCnoH5e68p/5lu2Sz4jKcmPw4IczBEHzVm+E4ssydeJyl39AOpc7khAzR5bPnB59nvp4wufOpgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgMTo1MSBQTQ0K
PiBUbzogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gQ2M6IFNyaWRoYXIs
IEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBoYW5uZXNAY21weGNoZy5v
cmc7DQo+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsN
Cj4gc2hha2VlbC5idXR0QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZ
aW5nDQo+IDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnOw0KPiBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+
OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWws
IFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NyA2LzhdIG1tOiB6c3dhcDogU3VwcG9ydCBtVEhQIHN3YXBvdXQgaW4NCj4genN3YXBfc3RvcmUo
KS4NCj4gDQo+IE9uIFR1ZSwgU2VwIDI0LCAyMDI0IGF0IDEyOjM54oCvUE0gWW9zcnkgQWhtZWQg
PHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIFNlcCAy
MywgMjAyNCBhdCA2OjE34oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFyDQo+ID4gPiArICAgICAgICAq
IFRoZSBjZ3JvdXAgenN3YXAgbGltaXQgY2hlY2sgaXMgZG9uZSBvbmNlIGF0IHRoZSBiZWdpbm5p
bmcgb2YgYW4NCj4gPiA+ICsgICAgICAgICogbVRIUCBzdG9yZSwgYW5kIG5vdCB3aXRoaW4genN3
YXBfc3RvcmVfcGFnZSgpIGZvciBlYWNoIHBhZ2UNCj4gPiA+ICsgICAgICAgICogaW4gdGhlIG1U
SFAuIFdlIGRvIGhvd2V2ZXIgY2hlY2sgdGhlIHpzd2FwIHBvb2wgbGltaXRzIGF0IHRoZQ0KPiA+
ID4gKyAgICAgICAgKiBzdGFydCBvZiB6c3dhcF9zdG9yZV9wYWdlKCkuIFdoYXQgdGhpcyBtZWFu
cyBpcywgdGhlIGNncm91cA0KPiA+ID4gKyAgICAgICAgKiBjb3VsZCBnbyBvdmVyIHRoZSBsaW1p
dHMgYnkgYXQgbW9zdCAoSFBBR0VfUE1EX05SIC0gMSkgcGFnZXMuDQo+ID4gPiArICAgICAgICAq
IEhvd2V2ZXIsIHRoZSBwZXItc3RvcmUtcGFnZSB6c3dhcCBwb29sIGxpbWl0cyBjaGVjayBzaG91
bGQNCj4gPiA+ICsgICAgICAgICogaG9wZWZ1bGx5IHRyaWdnZXIgdGhlIGNncm91cCBhd2FyZSBh
bmQgenN3YXAgTFJVIGF3YXJlIGdsb2JhbA0KPiA+ID4gKyAgICAgICAgKiByZWNsYWltIGltcGxl
bWVudGVkIGluIHRoZSBzaHJpbmtlci4gSWYgdGhpcyBhc3N1bXB0aW9uIGhvbGRzLA0KPiA+ID4g
KyAgICAgICAgKiB0aGUgY2dyb3VwIGV4Y2VlZGluZyB0aGUgenN3YXAgbGltaXRzIGNvdWxkIHBv
dGVudGlhbGx5IGJlDQo+ID4gPiArICAgICAgICAqIHJlc29sdmVkIGJlZm9yZSB0aGUgbmV4dCB6
c3dhcF9zdG9yZSwgYW5kIGlmIGl0IGlzIG5vdCwgdGhlIG5leHQNCj4gPiA+ICsgICAgICAgICog
enN3YXBfc3RvcmUgd291bGQgZmFpbCB0aGUgY2dyb3VwIHpzd2FwIGxpbWl0IGNoZWNrIGF0IHRo
ZSBzdGFydC4NCj4gPiA+ICsgICAgICAgICovDQo+ID4NCj4gPiBJIGRvIG5vdCByZWFsbHkgbGlr
ZSB0aGlzLiBBbGxvd2luZyBnb2luZyBvbmUgcGFnZSBhYm92ZSB0aGUgbGltaXQgaXMNCj4gPiBv
bmUgdGhpbmcsIGJ1dCBvbmUgVEhQIGFib3ZlIHRoZSBsaW1pdCBzZWVtcyB0b28gbXVjaC4gSSBh
bHNvIGRvbid0DQo+IA0KPiBIbW0gd2hhdCBpZiB5b3UgaGF2ZSBtdWx0aXBsZSBjb25jdXJyZW50
IHpzd2FwIHN0b3JlcywgZnJvbSBkaWZmZXJlbnQNCj4gdGFza3MgYnV0IHRoZSBzYW1lIGNncm91
cD8gSWYgbm9uZSBvZiB0aGVtIGhhcyBjaGFyZ2VkLCB0aGV5IHdvdWxkIGFsbA0KPiBnZXQgZ3Jl
ZW5saXQsIGFuZCBjaGFyZ2UgdG93YXJkcyB0aGUgY2dyb3VwLi4uDQo+IA0KPiBTbyB0ZWNobmlj
YWxseSB0aGUgenN3YXAgbGltaXQgY2hlY2tpbmcgaXMgYWxyZWFkeSBiZXN0LWVmZm9ydCBvbmx5
Lg0KPiBCdXQgbm93LCBpbnN0ZWFkIG9mIG9uZSBwYWdlIHBlciB2aW9sYXRpb24sIGl0J3MgNTEy
IHBhZ2VzIHBlcg0KPiB2aW9sYXRpb24gOikNCj4gDQo+IFllYWggdGhpcyBjYW4gYmUgYmFkLiBJ
IHRoaW5rIHRoaXMgaXMgb25seSBzYWZlIGlmIHlvdSBvbmx5IHVzZQ0KPiB6c3dhcC5tYXggYXMg
YSBiaW5hcnkga25vYiAoMCBvciBtYXgpLi4uDQo+IA0KPiA+IGxpa2UgcmVseWluZyBvbiB0aGUg
cmVwZWF0ZWQgbGltaXQgY2hlY2tpbmcgaW4genN3YXBfc3RvcmVfcGFnZSgpLCBpZg0KPiA+IGFu
eXRoaW5nIEkgdGhpbmsgdGhhdCBzaG91bGQgYmUgYmF0Y2hlZCB0b28uDQo+ID4NCj4gPiBJcyBp
dCB0b28gdW5yZWFzb25hYmxlIHRvIG1haW50YWluIHRoZSBhdmVyYWdlIGNvbXByZXNzaW9uIHJh
dGlvIGFuZA0KPiA+IHVzZSB0aGF0IHRvIGVzdGltYXRlIGxpbWl0IGNoZWNraW5nIGZvciBib3Ro
IG1lbWNnIGFuZCBnbG9iYWwgbGltaXRzPw0KPiA+IEpvaGFubmVzLCBOaGF0LCBhbnkgdGhvdWdo
dHMgb24gdGhpcz8NCj4gDQo+IEkgcmVtZW1iZXIgYXNraW5nIGFib3V0IHRoaXMsIGJ1dCBwYXN0
IE5oYXQgbWlnaHQgaGF2ZSByZWxlbnRlZCA6KQ0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtDQo+IG1tL0NBS0V3WD1QZkFNWjJxSnR3S3dKc1Z4M1RaV3hWNXoyWmFVMUVwazFV
RD1EQmRNc2pGQUBtYWlsDQo+IC5nbWFpbC5jb20vDQo+IA0KPiBXZSBjYW4gZG8gbGltaXQgY2hl
Y2tpbmcgYW5kIGNoYXJnaW5nIGFmdGVyIGNvbXByZXNzaW9uIGlzIGRvbmUsIGJ1dA0KPiB0aGF0
J3MgYSBsb3Qgb2YgY29kZSBjaGFuZ2UgKG1pZ2h0IG5vdCBldmVuIGJlIHBvc3NpYmxlKS4uLiBJ
dCB3aWxsLA0KPiBob3dldmVyLCBhbGxvdyB1cyB0byBkbyBjaGFyZ2luZyArIGNoZWNraW5nIGlu
IG9uZSBnbyAocmF0aGVyIHRoYW4NCj4gZG9pbmcgaXQgOCwgMTYsIG9yIDUxMiB0aW1lcykNCj4g
DQo+IEFub3RoZXIgdGhpbmcgd2UgY2FuIGRvIGlzIHRvIHJlZ2lzdGVyIGEgenN3YXAgd3JpdGVi
YWNrIGFmdGVyIHRoZQ0KPiB6c3dhcCBzdG9yZSBhdHRlbXB0cyB0byBjbGVhbiB1cCBleGNlc3Mg
Y2FwYWNpdHkuIE5vdCBzdXJlIHdoYXQgd2lsbA0KPiBoYXBwZW4gaWYgenN3YXAgd3JpdGViYWNr
IGlzIGRpc2FibGVkIGZvciB0aGUgY2dyb3VwIHRob3VnaCA6KQ0KPiANCj4gSWYgaXQncyB0b28g
aGFyZCwgdGhlIGF2ZXJhZ2UgZXN0aW1hdGUgY291bGQgYmUgYSBkZWNlbnQgY29tcHJvbWlzZSwN
Cj4gdW50aWwgd2UgZmlndXJlIHNvbWV0aGluZyBzbWFydGVyLg0KDQpUaGFua3MgWW9zcnkgYW5k
IE5oYXQgZm9yIHRoZXNlIGluc2lnaHRzLiBUaGlzIGlzIGhvdyBJIHdhcyB2aWV3aW5nDQp0aGlz
IHNjZW5hcmlvOiBJIHRob3VnaHQgb2YgaW5jcmVtZW50YWxseSAocGVyIHN1YnBhZ2Ugc3RvcmUp
IGNhbGxpbmcNCnpzd2FwX3Bvb2xfZ2V0KCkgYW5kIGxpbWl0IGNoZWNrcyBmb2xsb3dlZCBieSBz
aHJpbmtlciBpbnZvY2F0aW9ucw0KaW4gY2FzZSBvZiBlcnJvciBjb25kaXRpb25zIHRvIGFsbG93
IGRpZmZlcmVudCBjb25jdXJyZW50IHN0b3JlcyB0byBtYWtlDQpwcm9ncmVzcywgd2l0aG91dCBm
YXZvcmluZyBvbmx5IG9uZSBwcm9jZXNzJ3MgbVRIUCBzdG9yZSBiYXNlZCBvbg0KdGhlcmUgYmVp
bmcgZW5vdWdoIHpwb29sIHNwYWNlIGF2YWlsYWJsZSAoZm9yIGUuZy4gYmFzZWQgb24gY29tcHJl
c3Npb24NCnJhdGlvIGVzdGltYXRlKS4NCg0KQmVzaWRlcyBzaW1wbGljaXR5IGFuZCBubyBhZGRl
ZCBvdmVyaGVhZCBpbiB0aGUgcmVndWxhciBjYXNlcywgSSB3YXMNCnRoaW5raW5nIHRoaXMgYXBw
cm9hY2ggd291bGQgaGF2ZSBtaW5pbWFsIGltcGFjdCBvbiB0aGUgcHJvY2VzcyhlcykNCnRoYXQg
c2VlIHRoZSB6c3dhcCBsaW1pdCBiZWluZyBleGNlZWRlZCwgYW5kIHRoYXQgdGhpcyB3b3VsZCBi
ZSBiZXR0ZXINCnRoYW4gcHJlZW1wdGl2ZWx5IGNoZWNraW5nIGZvciB0aGUgZW50aXJlIG1USFAg
YW5kIGZhaWxpbmcgKHRoaXMgY291bGQNCmFsc28gY29tcGxpY2F0ZSB0aGluZ3Mgd2hlcmUgbm8g
b25lIG1ha2VzIHByb2dyZXNzIGJlY2F1c2UgbXVsdGlwbGUNCnByb2Nlc3NlcyBydW4gdGhlIGJh
dGNoIGNoZWNrcyBhbmQgZmFpbCwgd2hlbiByZWFsaXN0aWNhbGx5IG9uZS9tYW55DQpjb3VsZCBo
YXZlIHRyaWdnZXJlZCB0aGUgc2hyaW5rZXIgYmVmb3JlIGVycm9yaW5nIG91dCwgYW5kIGF0IGxl
YXN0DQpvbmUvZmV3IGNvdWxkIGhhdmUgbWFkZSBwcm9ncmVzcykuDQoNCkFub3RoZXIgcG90ZW50
aWFsIHNvbHV0aW9uIGZvciB0aGlzIGNvdWxkIGJlIGJhc2VkIG9uIGV4cGVyaW1lbnRhbA0KZGF0
YSBmb3IgYSBnaXZlbiBzZXR1cCwgb24gbVRIUCBzd2Fwb3V0IGZhaWx1cmVzIGFuZCBzYXksIHJl
ZHVjaW5nDQp0aGUgenN3YXAgenBvb2wgbWF4LWxpbWl0IGFuZC9vciBhY2NlcHRhbmNlIHRocmVz
aG9sZCBwZXJoYXBzPw0KDQpXb3VsZCBhcHByZWNpYXRlIHlvdXIgc3VnZ2VzdGlvbnMgb24gaG93
IHRvIHByb2NlZWQgYXMgZmFyIGFzDQp0aGUgbGltaXQgY2hlY2tzLg0KDQpUaGFua3MsDQpLYW5j
aGFuYQ0K


Return-Path: <linux-kernel+bounces-322306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86897270E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CC71F24B52
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC805143880;
	Tue, 10 Sep 2024 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1D2oKUy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F11EB5B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934693; cv=fail; b=Wc1drMJcSesbicwlwCDe9k2qrbFfrhu8ZaW4E4Tfk0uD0IVol+IpGjOt2uEiZ0G54q1jHkhwnfaVN/CsWIGd/8ZKypeXi/mDaa8PEXCOPsu/RjpebmeDzO8Xxih57faeNcpORDtcIVfIgSYw+oDne4GFwAg9s7cHIuRp5GClFcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934693; c=relaxed/simple;
	bh=keKPIKzGg1hhiAnXreWL8xnQ2WjNPLWI0n2iWRJBDd8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MtbPL/FzSHRNb9R7W7Ro21lK8eSx+hEBjpYhG4zkF6mk2c2DHgIk8iaBPE0AZybUlcxq5r5Mt5T2G540lK1TG8h5dbzsrEnsFsL/gQ3WRN/qEY7kEEKNtjUSdskbS4+Lxmuxg7qzfkctI4vTSJJfpHqObpYM84ZX2KWATcbkaCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1D2oKUy; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725934692; x=1757470692;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=keKPIKzGg1hhiAnXreWL8xnQ2WjNPLWI0n2iWRJBDd8=;
  b=a1D2oKUyqchdhVUW/FltR411vVIf8rKCzKrg4AqHiWj7VVmKH3sbO4fv
   4nWIU97vY9mnwym+aFeDOPKvpODWdeEBMeOKybEUA3sHd/Igw/htayEaJ
   lbizyuYipACu3DyCkJlCSlK64S0w9200czVesPDQz/lOalGhMi0yXGUyL
   Y8BXpvZ9nyCr0LxEKG/KkBds/hpYcImK+3bLsC4fH4BY86aetVIANew+f
   6Xt/EZXXNm28zzLpLQGQmUChraP/BCoOpj5odVe9aszugwwNtQNyk/Evj
   nZ7cHk//YIjNX0FQnS3Q83wtAAVsuML1WwisGeduFqpZJTUNBiDiVLzQo
   A==;
X-CSE-ConnectionGUID: v9hndqPdTCaxu3IMXpUHhg==
X-CSE-MsgGUID: taFKerP3TM67hhV8tj7GBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24161908"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24161908"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 19:18:11 -0700
X-CSE-ConnectionGUID: KpfKdFwdRA2f8zREIIhiGA==
X-CSE-MsgGUID: sRJ47Az6R3qSD9rVRPgKcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="67121980"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 19:18:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 19:18:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 19:18:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 19:18:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 19:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLJhFdRwPFk8w+Z1wNN2kn61DdHy7Y/AdZ2hLqlqBKKFTVO/6O/RTxaaSPVdFNin8a2sWCVI+hIkEh25+hSiqBzNxBofG5eicmCMBQ3PQjAZsVE1w9A/Wbtb3S4dtCZX5wiG44ePKC828Rqj3nzaSdTAAbu3hMjKz5CWw871TtI2jLVkKxnFHUzDekjyd5nnJusXZjOc2G8Tc2m2yOGzGswrkJQGKAQsEwymhAO9iqyu0++wWbV9e3HBCnIuvN0DhEO3nmm7e/YtB0JLS0j1mdwyzwxL18cnKI16/gegPsS1pNit3hKfom6tDqOZv3tV50ChIPM5iMrYP1Q1C45bUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7BGG6a4MU4IV9Pk6VDHqgGUYMeCGni7DpdPBDwY3RI=;
 b=tNOUNouia3tZ0T/BXECUDlqYGIOnJxJg9ehtHKwdSrKwbM1vzfOdVNQU67qXTdFOeidgOwZk5Wcvt8aWycW92DCgLBnJRBwRDgeqzUtX+dwZ1Zjwqz/w0JLHYvQwU+NTqV5Vrnw2svDD3w9z8r+Ht30g08RxwAvKCTgmBCi7UQ0G6QJeK6aTN0p6sdAYHsTyeMinyJANtJusHIiZG6D3e/98r2L7kialuVoaK2s1/iSJ+YAEavNTXwN99nsvA3VzN4wsL9AZY/QXqzkQx8tg4GF8LJV90/stQ36YvJ3v7u9yvWofbnBhgKj4Q3JmOYAt4IoyxD7cdUQersvv46iQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Tue, 10 Sep
 2024 02:18:08 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%5]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 02:18:06 +0000
Date: Tue, 10 Sep 2024 10:17:54 +0800
From: Feng Tang <feng.tang@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
	<akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Marco Elver <elver@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, "Danilo
 Krummrich" <dakr@kernel.org>, <linux-mm@kvack.org>,
	<kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] mm/kasan: Don't store metadata inside kmalloc object
 when slub_debug_orig_size is on
Message-ID: <Zt+sUs46cZc0vh/K@feng-clx.sh.intel.com>
References: <20240909012958.913438-1-feng.tang@intel.com>
 <20240909012958.913438-2-feng.tang@intel.com>
 <CA+fCnZcqnsAFEHKcPDag60FR_UbpOQpJidF+wqgZzUZUe6MPVQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcqnsAFEHKcPDag60FR_UbpOQpJidF+wqgZzUZUe6MPVQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6299d4-5f22-4615-8ed7-08dcd13eceaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2U5Zkw0NEcxOXMvajI4U3R0TnIvSXBXd1kycHRLOXdkNU5aeW10Z2JuYklV?=
 =?utf-8?B?T21jMk1FQzhzSWcvbW1iN1k0WTJFaEF0V09sQjJ5aW9MNnlXam5wNnl0clIv?=
 =?utf-8?B?Qm1RWExoRC9sTkhUMCtRS1FRV3o4SlAwVGlHRzlVYU5xZk9ldmpGc0JUdzdF?=
 =?utf-8?B?WFZzclRsWCtPSXY3WFBqZnBmY2JacHIvcytjano0RTlOWUFmb0NFeUlTUUtu?=
 =?utf-8?B?OTl5UjNjT1BuOGtOYnd0bUtwT25YbE41cGl6ZERUTHNyTFBLaEt2WkdnNksx?=
 =?utf-8?B?ajVRaCszVkh2bGlKalM4ZFE2MnZtSStESkwwc2hBZ0pZcC9mV1dhc1JzRi9D?=
 =?utf-8?B?OVhWaUsyMkNzaCtQRm4vWXhxaE0vY1RENWlvOE9OYk53c014WWJOYTJOREFa?=
 =?utf-8?B?NG9GMjA0WDBWSDdSUU9CM1JpVktLVUFqZkZ5aVNranRkYTJ6NUt5azdYSVph?=
 =?utf-8?B?L21kamt2bGRrSjhVRnZxN2NuK01lZklxc1RZRmttTnhzbWJFSmllWVpsa3E3?=
 =?utf-8?B?dTFYVDdWZ05ocUhHalNWQ09TV051K08xTXIva25PakVYVWlpYjY4RXFNRUJn?=
 =?utf-8?B?WDl5Ni90TlEvS2hWQmRKUERJbEFtVVd6eFNJR3pzUWVBZ21lT0x0QldIYUZ3?=
 =?utf-8?B?SHJBR3MwT2FJdkVBMWU5ZUFTcFpZY0I1dEFSaEQ2bFVuUWlHcElZc2crQXJu?=
 =?utf-8?B?ekN3a2VROFpzaExsNVd1K1JNRnI5S0RmRFUxNGxueGEvTHB5NmU2Q0N2SHJ0?=
 =?utf-8?B?YXMyUUdtQ0JrU2tjdHZ6cXNROEd1M0E2a1hBaEhNeEV2TEpSckF1S0FjZkU3?=
 =?utf-8?B?T044S3Uyd0NJRWgvaGRBZXNhTUtIbjViSEJmdStHQ2htdGJOYS9HZGpROUVF?=
 =?utf-8?B?UnlnOUVHV3BKWitEaUNMWDIxZXk4YUtuRXF5cVhWSEgxNTI4akpHamMvVExi?=
 =?utf-8?B?SlluRTdyTWx0R3lDRjdSL3gwRU0vUE5wd3BqdWJqd0dOY1BGWjdGQTZ4QUJM?=
 =?utf-8?B?RS8zTHBuenpHanRlbXFQbTluTnZLc1BZQVE5MjBGWEg0SEUwODU1Um5reEdU?=
 =?utf-8?B?NUZySjRvVldVdDNBTlJHMU1KT1U1MzdrcTlzcjU0WDI3THdISnZUL3QrRXJx?=
 =?utf-8?B?Y01haG5zMXpRRU1TY2lmUWQ4Sm1wTzVPWmgyeWpVQWwwYUMxYWNlcEdrQUIw?=
 =?utf-8?B?U1lFQzVDVnZZN0M2K3VpNjJpY1hYOFFqd3BFUjhDTExYckNjSk02VXBLL3l4?=
 =?utf-8?B?Tngxbnc5cWx5SXRrSEtqb1Nqd1hFRUR4cjNrMzhkd3I0dTVpcjJ1cWFHYWhQ?=
 =?utf-8?B?c2dvclR2eVpjUDNpdzhOc1l1emZBQWs0eHMrMHllN04rNTZuTXIzWW9oRzdV?=
 =?utf-8?B?bGJRbTRmSzY3WkM0QzlKcjhhL0prQmwxdWVMVGhKaGFtcFdURVZKYUpsWTNz?=
 =?utf-8?B?SGdibU5IcmxlYzVQa3NwMlRTNldHMzJqS1dIRTF5VXBNMC9PcWJjYkJIb0lz?=
 =?utf-8?B?SW1iMTNqVHBSTFczV3c0a3l3a2ROSkRXcy9pNVluaVI0WlNIYjhBWUg4QUl3?=
 =?utf-8?B?Wlh0NnlGUGRjODErNUh4L2xzR2Uvc1lrZXVnbUdZU2JqekV4S0JHSVBiVU8v?=
 =?utf-8?B?RCtGbjB0aW9hZmN2a0o1NzFvaEl3U2hoaDRjQzBqSU82bHdPN2REc1JiNkRK?=
 =?utf-8?B?ZjlXVENlRzlDb3ovRFZMV1BKTmlFWHROVzZvb25yNkR2MDY4c2ZGQ0FqNW94?=
 =?utf-8?B?TmQvUGpveXFyYktSSmQ2alRLSm5xWVR2Zkt3Qlk1K3Z2Zll6WEN6aWxleE4y?=
 =?utf-8?B?eXk5RTkwdEtvK2lVY1FRdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHRFR1I3LzhDWmF5WElNaUdZVGsycGRYWW5TOHZaYnRlMDBUSHdYSE8xRlVK?=
 =?utf-8?B?U3E5U1dCb01tZXVYYXBTelJrWnI5bElYd0dtQ0huWU94cU1HQzdFSitmU1Nq?=
 =?utf-8?B?aHpZMFpEMFFsMGN0SXNLQUJ4c0M5d3EwYlZLcGFVcjM0MVc0YU40NGFSS25m?=
 =?utf-8?B?ZWtWb0R5STJHSDM0TmxQa0QvSEZCT0I0TGxZUFcrRm9rcHdaeVpkNUk1VWJJ?=
 =?utf-8?B?S1pWN2RMN082dktENjNKb1VWYUdSYkhJWE8rVTNDakNkdmQ2RFg2VEdkb2po?=
 =?utf-8?B?ZEhIUU9NQnRGb1NGc1pJcHhtZFZCU1BaY0xkejdwc1lxNHZPZmUvVk1BZjJC?=
 =?utf-8?B?RHFUbXVReTA2Z2hlUzc5dnBmTjVPbngzZVozZ1BVTHNoUlM3Smxob1Z2RDlw?=
 =?utf-8?B?cG0xSklHcUVHcXdTUmxBbFVLcXlXbkpsTmpxdlh1L2ZvQ0ZyM3FiTFhXem16?=
 =?utf-8?B?a2hiVVR3VVQ4ZFpLSHY1alZqdk1HUzZqOXBCYnlBK09GSjlkTWI2YWNBSE1a?=
 =?utf-8?B?WlFuYXlUSGJlbEExRk90Nnl4aVhURWhMYnN5WlZOZVR4czhIRFBHOFNsZjJF?=
 =?utf-8?B?MEV3a3l4OWpkL2g0WklibGNSM1FJS29UQ3VhbDNRczk0Vmw5WFhDakNzTlBa?=
 =?utf-8?B?c3dTVHlTY3hBY2VnSnd3bk4rYjNxT2F1eHA2UUorWitEa1QyVmhoZVFRb3hI?=
 =?utf-8?B?S3VGaTBDSlc4OXFPbnEzdzdZMG0zNmpnUXp1NjNqSExyM0xxd1B0RmpvNTFY?=
 =?utf-8?B?S1dlZmZ5bjVBSlBOM0ZWVnVMN2VwaXBqV214eHFGK1ZEdEpITEFGV3ErbXZC?=
 =?utf-8?B?cXhTc1dZSEd0ems0amN4NmxyY0pQV2xpKzBJdlVPcTlHdko2YkJramNJR0Zl?=
 =?utf-8?B?eXJqeGFmZFU1U3hER2tkcExEM3dqN1RVc3Q5QllNWm5IejFOSE1RRVo1YjdQ?=
 =?utf-8?B?SDdxVU9uaFhISk1YUE52YTk5L2RJY2w4US9tN1gxZVZpL2dNWWFBak1JejVF?=
 =?utf-8?B?U2c0ZDVyWWlzdlQzeW55RHFJOUptWUlDNUNXUVdObmhpUjZPSFlONTJmMmF3?=
 =?utf-8?B?TGxTTVBqd0hwMlFzTnhXNlcycGZtVDR3QjZaSmFOLzdBRXNlYjlVSXJUNXEy?=
 =?utf-8?B?OXdsM1VHVmpvbS9rUnRiSDJMa0liYXhRZDZvaWhJbkhvekdiWnZyUWNhempq?=
 =?utf-8?B?c1NMa3hJZ2ZvOEVqWW1nNVhzclo3L1FwV3Y1Qm5BV25ZSmxWNkQwcFNLQ0Y5?=
 =?utf-8?B?K09HNzRjTzV2TlNyZ1RYZXBRL3RmUlZ2dUUzT0dkeEFFSXlscjY1a3JkQ0pi?=
 =?utf-8?B?OFl4NW9yMUN0R1VYWE4vSC9haDgrbHphV2JPTVdGQmZYT1c3Mzl3a3pRbGs2?=
 =?utf-8?B?QkhGMndGTmEyQ3JiSHppNFMvUHhuT2hZTEg4TWdvZjRsam84UEdFNzgrZ2VB?=
 =?utf-8?B?T1lOYmJaR3JkSXY4eVRJcmFKdXJLbWlhWDIyQjQ4STgzUitJeEFqbWNSbFdi?=
 =?utf-8?B?eDk4ZFlGQ1dRVnJrbW9FeXhocDJYNExHUjU1Z3lsVWpLRkVmUmdMdW1Ic0Ry?=
 =?utf-8?B?QXMvcW1iRUpNRXVkOGJvQVVqRlVOUWZlS1NiaW81THhGbXVBN29hcVplb1dn?=
 =?utf-8?B?Unk5Ni83bGxVYk9UVE92c2pRdlNWSGNlSE1Ea1R0aURiK2Jjcks1cUJYWVl3?=
 =?utf-8?B?eTY2eGRvcldya1lFdm0ycXVwbXlGa3VkelhQeGdEeHhLQVp1ZlFSUmU3UmdJ?=
 =?utf-8?B?cHVQUEo4Z3MxK0ExZU44a3dSMXJQV0pJSFFqbjM0dDlsZmQ4Vk5NUU13VCs2?=
 =?utf-8?B?OXN5dnJhSHZuZ3RDRWdSTnQ5blpmNGV2SEtkR2t1WXNSbjIyYU1VbGJtZXdQ?=
 =?utf-8?B?R2UwSXNRMHJkM00rSVJXWjEzVWoyR3BxSWpVV0dpd2tpTW5YSENCeVRmYW5W?=
 =?utf-8?B?bUtlNHV3eDJVWVRWdWxQSmNpeUVuVzVhS0tQd2xQRko2bWxRcXI0NWFVN2x2?=
 =?utf-8?B?WENBS0JCazc1Q1hITVNUeFhzaENacWF0R2ZtMkZ4OHFnNTdxd3lXMjJkL3Vt?=
 =?utf-8?B?MkRvM1VFekFwc29FalhMN09MTzFkencxVGYrNkhHZjFxeHp6U3dvc1FCd0tr?=
 =?utf-8?Q?aP0L+ZHdA9tqsP7dDX99mg9pY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6299d4-5f22-4615-8ed7-08dcd13eceaf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 02:18:06.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS5KxD8GoVUg0yUXUQZLj8xcxtQRNeCRDKBceyVl/MsHm851h4rj6P2wIAzCarHbOfBZp6xORZkn2dsP/p92Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com

On Mon, Sep 09, 2024 at 06:24:21PM +0200, Andrey Konovalov wrote:
> On Mon, Sep 9, 2024 at 3:30 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > For a kmalloc object, when both kasan and slub redzone sanity check
> > are enabled, they could both manipulate its data space like storing
> > kasan free meta data and setting up kmalloc redzone, and may affect
> > accuracy of that object's 'orig_size'.
> >
> > As an accurate 'orig_size' will be needed by some function like
> > krealloc() soon, save kasan's free meta data in slub's metadata area
> > instead of inside object when 'orig_size' is enabled.
> >
> > This will make it easier to maintain/understand the code. Size wise,
> > when these two options are both enabled, the slub meta data space is
> > already huge, and this just slightly increase the overall size.
> >
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/kasan/generic.c |  5 ++++-
> >  mm/slab.h          |  6 ++++++
> >  mm/slub.c          | 17 -----------------
> >  3 files changed, 10 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > index 6310a180278b..cad376199d47 100644
> > --- a/mm/kasan/generic.c
> > +++ b/mm/kasan/generic.c
> > @@ -393,8 +393,11 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >          *    be touched after it was freed, or
> >          * 2. Object has a constructor, which means it's expected to
> >          *    retain its content until the next allocation.
> 
> Nit: ", or" above.

Aha, yes, I missed that.

Hi Vlastimil,

Could you help to change it when taking the patches, or you prefer me
to send a new version? thanks!

> 
> > +        * 3. It is from a kmalloc cache which enables the debug option
> > +        *    to store original size.
> >          */
> > -       if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
> > +       if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
> > +            slub_debug_orig_size(cache)) {
> >                 cache->kasan_info.free_meta_offset = *size;
> >                 *size += sizeof(struct kasan_free_meta);
> >                 goto free_meta_added;
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 90f95bda4571..7a0e9b34ba2a 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -689,6 +689,12 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> >  void __check_heap_object(const void *ptr, unsigned long n,
> >                          const struct slab *slab, bool to_user);
> >
> > +static inline bool slub_debug_orig_size(struct kmem_cache *s)
> > +{
> > +       return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> > +                       (s->flags & SLAB_KMALLOC));
> > +}
> > +
> >  #ifdef CONFIG_SLUB_DEBUG
> >  void skip_orig_size_check(struct kmem_cache *s, const void *object);
> >  #endif
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 23761533329d..996a72fa6f62 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -230,12 +230,6 @@ static inline bool kmem_cache_debug(struct kmem_cache *s)
> >         return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
> >  }
> >
> > -static inline bool slub_debug_orig_size(struct kmem_cache *s)
> > -{
> > -       return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> > -                       (s->flags & SLAB_KMALLOC));
> > -}
> > -
> >  void *fixup_red_left(struct kmem_cache *s, void *p)
> >  {
> >         if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
> > @@ -760,21 +754,10 @@ static inline void set_orig_size(struct kmem_cache *s,
> >                                 void *object, unsigned int orig_size)
> >  {
> >         void *p = kasan_reset_tag(object);
> > -       unsigned int kasan_meta_size;
> >
> >         if (!slub_debug_orig_size(s))
> >                 return;
> >
> > -       /*
> > -        * KASAN can save its free meta data inside of the object at offset 0.
> > -        * If this meta data size is larger than 'orig_size', it will overlap
> > -        * the data redzone in [orig_size+1, object_size]. Thus, we adjust
> > -        * 'orig_size' to be as at least as big as KASAN's meta data.
> > -        */
> > -       kasan_meta_size = kasan_metadata_size(s, true);
> > -       if (kasan_meta_size > orig_size)
> > -               orig_size = kasan_meta_size;
> > -
> >         p += get_info_end(s);
> >         p += sizeof(struct track) * 2;
> >
> > --
> > 2.34.1
> >
> 
> Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

- Feng



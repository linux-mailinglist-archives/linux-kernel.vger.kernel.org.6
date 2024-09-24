Return-Path: <linux-kernel+bounces-337685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1738984D82
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915A2285684
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1D146A87;
	Tue, 24 Sep 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyBc8Tiw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE2768FD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216230; cv=fail; b=OQWlZj3UA6cnIU+w73QmVEp+YycMUkfAi3Ye2PWHotSrTMQnAsjDwp/53Owtk2DtZ1gofERUNe6pHMJUxZVk37yU+9ukOemtu7Wh6ThI7rMF3Iqy3iGBAw3CMrEi8v/BhRX0MrI8NHqHSeA5IY6ps8eqPsIqtdmbYNJdz6lFBRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216230; c=relaxed/simple;
	bh=c4/xAjAG0osIgk9BVT5s7knns/+J5qGB0i2H1s4+IZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sZIVkwMhhJaWaFlvaRaAHdtfoTXnNM6YF2MJfScU+aiTPfbPbuqnRidk9QxgnYXX0FGhT6h9YEVCLR+47gr+8FtikJDTU1+51wMOFnENtB5/eAkFIEH9GS0L1vHDfDbxEZBQoMzE6cKAHaWCR86JUXcDjq4an7bmQEpnfdZxih4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyBc8Tiw; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727216229; x=1758752229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c4/xAjAG0osIgk9BVT5s7knns/+J5qGB0i2H1s4+IZo=;
  b=CyBc8TiwpYsp88l52sZ2lWdx3dT/qQK2s305bfXwJAKqOscqVH029n4h
   duTq8q0Dd7Fh2c8nzXQ6nWeHxnJi9R2vXoXm4mlU8cOJyvVPQiXWnm419
   ekhoO7i7ltql/vBFfbeKqnj9CVsWDPoof2OyYO8G6jZcEylq6d7/X1h3y
   dfweKPqmd+kjtynZHs3MtvfwqKbXSA/RIVS54JP4jvOjnH9CyfZ4E/a9t
   13CprRhPFcYESIECfBIZ/slqB0MptuKiASLj2HZixUhh434RGiGFhqlpd
   RpX4FOr4tdgOKQQAf3hWZBSChAf4giA/Urz88Xx6g/U5hpJ8Pkeu7uG+x
   A==;
X-CSE-ConnectionGUID: y6rrIW/mRkaNsqI++M/w6A==
X-CSE-MsgGUID: m/9NAEvBR8mpoe9zXwPDaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="25753170"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="25753170"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:17:08 -0700
X-CSE-ConnectionGUID: +mKfX7XWTfCH5KBKnZSIag==
X-CSE-MsgGUID: e96aqNZPTp+1m3LJDzQoGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="71439595"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 15:17:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:17:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:17:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 15:17:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 15:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuZb8gLfhIbI7DGJz9pzen+Q6NOZ6BjoNMNwIxXot6YanBaSh4KGHkwq99V8jgz+aCX36aOQnQJz5mNZWyVbXUOQwDK11CQbSrS+Zxjps5t2BfL/Jlx6Sbmppwzt0Ua2ujHV+t5TvY0Gy3eglhkE0rRcHlTbMxBbsEwbw80asivlRUoa35f67L/59HnKCbZmNZj5FhLpdH9rOWSk+/S8H+qh9WgRCbMrXYJFpBn8FjZvqcCv/l180bSCQG0hgvzQQhGSaP02Frntb58SJxPlabMaaBVcJu57RjNeHxZeDwOW2bUgeUv6K+akpWHCd21T4y5CbdihYTnki9FfTqkYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4/xAjAG0osIgk9BVT5s7knns/+J5qGB0i2H1s4+IZo=;
 b=zR2zNzLhs9Kg9sT4WpKwPKqJQsICRFh8KaY0xC48Sjy5rvNMdZXpuVJmVCV/INW3DkYb4kaqo/bEahFR60XEsCCnokqz3g+BYninlIUDqkNlVffClAonYfdQWaBzq9c3b2WJIH7I+b9khJ/8a/W/nCpH7CYyDYUSeu9pHwuixDLsZC4r0TiJ+v+HbcXlhdZhLDTyqbRNDpLlY3Bh2/FRpNDNUod2VCr3rXpXgFpy3dNf3od6mSbcZT6KtwCNGDAX9sttV2ydeOWdzs+234TnqrsuVGE12sQCyteu4gHKxotiIBQBgmIIJYaCvFB5v1zkyQVXnsJgPkdilUkeaQch5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 22:17:03 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 22:17:03 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>
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
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnM4MAgAA0ncCAAAdQgIAAB1eAgAAG+3A=
Date: Tue, 24 Sep 2024 22:17:02 +0000
Message-ID: <SJ0PR11MB5678558D6728055819B06C61C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAKEwX=Nw_ax0RRSaD9n3h1vqbu+5PEuur3RqXrMrYyvOPuzB3Q@mail.gmail.com>
 <SJ0PR11MB56785712C0EF98B7BE558720C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=MgpP_w6JFC5ahVN-erCWK2NDGSbxNdLxKg9P4yd01Unw@mail.gmail.com>
 <CAJD7tkasC4n+mE=q+L9cjf4342eSkOQPeeV1wzBKxTp39wnZJA@mail.gmail.com>
In-Reply-To: <CAJD7tkasC4n+mE=q+L9cjf4342eSkOQPeeV1wzBKxTp39wnZJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|MN0PR11MB6110:EE_
x-ms-office365-filtering-correlation-id: e58e26d2-89e6-47d6-b453-08dcdce69df4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TmUvK2xLTXkrQlRBU2JKQStINzJiMzlmR2tmMGVCcTR3anNRamtpcU9zbk5o?=
 =?utf-8?B?cG82OFM1Z1NZMm5aZkk3TFgwZ3AyaGJ5WnJTSHAxcUVYMWxycVF5TWJKenZS?=
 =?utf-8?B?R3BHUXptQzR6RDdqaHZOZG85UmdzLzF5MTlsMTBxR2hkNS9aNHFaS1NDK1Zr?=
 =?utf-8?B?YWZMb1BXendTVTNkT0VZdTBodEQ5VUt2ZThSQVJmU0w2aFV3K2hYc0NlU1l5?=
 =?utf-8?B?R0JTa0o1aEF4Mzg4SWU3NytmS2s0cXFwTHZXbDNUUWFvTVpvclg3OFVVd0Vh?=
 =?utf-8?B?emp3NHVDdjNUdjdlOTNRRms1TEdPQXFmdjF0Wi9MWUpWOVVGd1g0eG9uekda?=
 =?utf-8?B?RlZHRStacGM1NGhtSTNRcnNvNmZ0aFNJT0N5RHpRVXRJT0xPMHZGcEhQUVQ4?=
 =?utf-8?B?Sm1CbkZyaDEvdVFJSTlLS0liTWlZVFBBVjBJN2FkNTJTUDVMcHRPamErcENS?=
 =?utf-8?B?WGJuYVJtVUlNdzhxUHYxUzdPbTgraHlqVlZBcWtxYzd1dDg0a3VoV0pWTVN1?=
 =?utf-8?B?VjBaQ2NrMVkwazM0amJ0bncyUElEWHRwdEFjQnJjcXFhNXIxbXk2UGJwQ0dh?=
 =?utf-8?B?czg1dHRva3BYTGF2YnBYQlRwazRNM0oxT21EbGNEMEFPY3VQQVVrS1hheGF0?=
 =?utf-8?B?RjR0Qnh5aFJ5UmVvc01PWFpLLzRmZnY2b3ZKMThDMlBnWWZhbzhCVVZQN2Np?=
 =?utf-8?B?QmNGdVRSYjh1UDVLVURJRy9DWmlCd01tb3VIZUs3dVNrTDRaMFU3WHluNnpU?=
 =?utf-8?B?SmsxdEZiSHp3RnU5d0hJeHYxbU1HQlF0NFZ0VEVYcUhtRjFaVldONXhWVVNy?=
 =?utf-8?B?Qm5GZzZtS3hGOGVJZEZuYncxenBraEVjZlNXM0ZXY2J0N1dqcWFEbSt2YlVJ?=
 =?utf-8?B?ZldXYytoZDZOb1VBK1NkY3Bmd2xYdjNYNTByOC9wNG5oUVo3MVB0Z0RsQ0lu?=
 =?utf-8?B?alFjOWRUU3FRQkIreUhQVExaU0ZhYVlKd2xZUEJUZ2paVlZwSGRMUXY0ZTJU?=
 =?utf-8?B?dElHZjJPOEhDMnlxN25FS1N1Q2JlS1pFb3hwcThESytXWmdtZkZ0S0kwMmhT?=
 =?utf-8?B?dEZqdzYzckgrRjVyakFCYU9sL09xbTdoNnRnd1hCYlBCQk5Tblc5UXBMMjV5?=
 =?utf-8?B?ZUdub2JFK1RvZXVBRDNyZkJYUVNjU1NWNWJjTDFzdFA3WHNkTTc3RmRHZHA4?=
 =?utf-8?B?OENoblFoSS9lL3lkTmxkNnRFMEUwS3R3Y255dFpkUVI5aUFFL0s0Vld6d3VK?=
 =?utf-8?B?TzhuREZGK3BJK0RsaCtvMjZLakVETWhZQVZpdGlERFVIeHVYUzc0aE5lZjB6?=
 =?utf-8?B?WEJBRDFGRnpQWm50OFFJemtjZUJTd1A2ZkYwNGQwWlcrWFpQMmY1MzdpcGlF?=
 =?utf-8?B?M2dhZ0llRFdzVURRQVkyYXpiNEcrWG92ZGtTK0ZRUHUzZytFUzVVMnY2bHNo?=
 =?utf-8?B?VXoyY0FiZTZMYWJ6L2UwYXFCWFZ0T0ZpOTd0YWtFQmYrOWZxejc3a0h6dGZp?=
 =?utf-8?B?T0dTS2NGbFN2STl0Sy9jczZraUhEZVZFK0t0TDVnbzZ5a0RlTTQzckU5UUds?=
 =?utf-8?B?SXRqdUVEOFVINkpHbUVJSExVQmtnV1BRK3pOcGRRRGpSZ3p2TVNBZGtWSXk3?=
 =?utf-8?B?OURmZ0pwS1N5ZHZiQ043U2RDdzdRemtrdDhaaE04OWZFTGVkbFE1dGQ5cSty?=
 =?utf-8?B?RllaZHVJckw0bmxvUkJGWW8wVU5DampPTGovZ1ZzQXUxQWQ1WHNHUzhkQmpj?=
 =?utf-8?B?ZnhKcWFFUjc3RDk3di9zNFowS2pKaWpxUHRjWFY5bmpVVUhMN2FueTJycUgw?=
 =?utf-8?B?bGlEZ0JOMjQxQ0ttclRkRUN4ekZIVE9pY0J5Z2ZiK2kwbVRWbms1OUlPY3Bs?=
 =?utf-8?B?NC9LcWRGaDRDczFDK2hxcHVzSlNnZW1NTUJuR2luSkZXWEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlRXUjZjaEdHZlcxOC9WeXNzVnhxNU0rSDl3ZFBIYTV2K0xlQnNyejUwZUFW?=
 =?utf-8?B?eGxjc2cvaGpMVkFNU3JrSm82K1JqazRrV0ZjUnFPek5QeGZzTzVFNFpTeklj?=
 =?utf-8?B?ZHRNMWRkNWFSQmQwSzRZek9ZZkRybW1HbjZPWGtKT2IyMW5kbE5tRWEyNW1n?=
 =?utf-8?B?Yy9EbS8yd0xjMWwzWXZjT1JPWDh5emI2RGk4eWltU0FLQkVsa2RIZW1Pc1Nt?=
 =?utf-8?B?RG5ubUczUm9RWmlBSkNlR1JOM096S2o1eDJvNis2T2gwQnhha3Zmb2hUUWwz?=
 =?utf-8?B?b0w1TjlYUzJJdElrRFZEeHlwbUFlSTZ3MjljdW5iN3l5Rm9ndnYweVFubjUw?=
 =?utf-8?B?aEpiREdyVUVnanNWSTcxMWtjWHJRTUc3MkNyNnBIWVh6eEFDOEtZYjg2OXBp?=
 =?utf-8?B?OFppUGVxd2FPTnI5TjdtQ3oyVlBpN2prYnUwUW1aNm00eXdMaHVycGNncjZn?=
 =?utf-8?B?WnJOejgvT2QrVkE3VzdJUTIySzRoOU9iR09nRFVzWmdEQXZjejU4ZUY5NHlJ?=
 =?utf-8?B?blBUeVVZRDFoSE1PQVIzclcycVB3bWRqTHlRUE0zcHlad0xZWkxGRmZiK3BE?=
 =?utf-8?B?Z1ZsOW9aZThtdDJKL2xsV3ByT01jOXg1Vm1ROGZvR08reFBEQk9aYkdJVFlz?=
 =?utf-8?B?aTJZWmVsdVBTRURyVi9aUDVUaVkwMyt5WExKd3p5YWNtQTRHdXF0UUEwQjFm?=
 =?utf-8?B?UHFrNzFiWnY0OVBNbFVqSUwvRWlPRlJnT2ZqUzJrZUJCYnFEUXZuc3NWVjNK?=
 =?utf-8?B?UkdydExGMkVZeS9Gc2M5SWNleFZoWkxOQmF0RkJ2eG1ZUDRvTmROSEtYa1hw?=
 =?utf-8?B?M1dKUDlXUnJIdEI0WG1XbGw3WHhlTU8wMkxydFhOUHhuS2ZBWkMwSmxXTitj?=
 =?utf-8?B?MmtwMkJiT3FWcVlTVEtZekQwbUNKNXMvS0tKOE5GTHh3WHMzdGRyeFBVNXpG?=
 =?utf-8?B?VXhDRUQyczhGYy8rQUJuMElUampHSVRpTllLKzRGMkdydGZ6a0JnUTFMcmRw?=
 =?utf-8?B?QXFVajdOVHRpSTBCOVF3QVVjakJrOGNEN1BEQnFaQ3dUUlV1Y0pxd0FJbWQ0?=
 =?utf-8?B?Z3piRWE1WFF6YVZpelRWbjdiWFdiMkl0K212ZXo3VEpmQUVFODFGMEtGMFdI?=
 =?utf-8?B?czVhZDhRMzRNMUlCbGt0aVRWUTkyejhHbGpNRXBPcTNXSXd3OHVwd21UUW9G?=
 =?utf-8?B?MFh0d252RXB6RzJ0emxHVUJuL1R6VDVRKzhhUEx3aWJ3WWhoRXJ6R2hOYnB0?=
 =?utf-8?B?cDErVDJHT3o5SnZkS0lURW4zeWs4N2FvRDNJZnk4ckdSZXI2SEFXL2ZSdTlv?=
 =?utf-8?B?QU5HV3dCRkF0ZXJzTXZFMjFTeC8vODY1ZHY1alR3MkVFRE03TDhzcElKTkhk?=
 =?utf-8?B?K0hJUU1YRzRsL1ZEMzJUTEZhNUlwZHNFU0NPaWxpT3NiRHlwZ04wWnozZk5L?=
 =?utf-8?B?aUw3YnRFamJJZzNWOWFnUHhNWmlnaFZaMHlmM3AvVXo3QXFNTEw0MkhXQlVJ?=
 =?utf-8?B?QTdWZUVnWlJiRWhMU3dXWkFNNEppeDllRG1CSUxBWWtaVkM1Zzd4QWtjUzQr?=
 =?utf-8?B?OG5acWVvV1hXcVVsWTdJbTFFekhNMmhzbWdOSk9Pa0RvY3lmb0tHY2o3dmJH?=
 =?utf-8?B?d1U3T25xUE41NGpEY0JkNEMxTXJacUl5aVN1Vi9yVzVwVFFHa2U2eHo4WGQz?=
 =?utf-8?B?bFlYTnFEanRHa1NQR1hJSnYwZjdXVWpYSzlGYWpLWkdVSjVPS1lEdWp4VEgx?=
 =?utf-8?B?aDA3SkhubmtKSE03YWZQNUhUTFVyRmc0K2VoRW5BNStvSXZRaUlGbTBzaXlG?=
 =?utf-8?B?V3BtYjlIOFhzMHF0VStqY1ZLV2Z3TGkvUVFiSUROaXBJeVE5MzJPbjVweTZF?=
 =?utf-8?B?Z21KWVFrTjgzWG5jRllUZDFkbkNJSUx4YWdNUFFrQTd4SGoxclNFcWQ1VTFT?=
 =?utf-8?B?N2JkZEk5cjVwTlBEWFBzMm51ek9TL3Nsa29wRWZiZWNkU1YzdkgyeC9mRmUw?=
 =?utf-8?B?MytrZXNobVlvKytRakdjOVJ6aTI3RlY4TWhzdWtiL1BqVkZZMHJRbUhtMVh3?=
 =?utf-8?B?NXV5QndIbksxb2JnR0ZQQ1BNc3B5WVI5NlBUN1N2UkFHTEVxb2pCVUZFeXh3?=
 =?utf-8?B?V0dCN09hb0I1djZyL2l5WnJ5bExsMGMwSzE5TGo2a2gxYUEweFJtcXNnRkhW?=
 =?utf-8?B?Wnc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e58e26d2-89e6-47d6-b453-08dcdce69df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 22:17:03.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98C+GbOmuLiGNLFdQAhN2NwlgA1GwRfqxz7TMK/CaNQqbGKtX9PTkEfR+jMVSryRJ8EBWuMPtZefYRRK4lLWc571bKdBNLuDEUxZKV2VwP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNCwgMjAyNCAy
OjM0IFBNDQo+IFRvOiBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPg0KPiBDYzogU3JpZGhh
ciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT47IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGhhbm5lc0BjbXB4Y2hn
Lm9yZzsNCj4gY2hlbmdtaW5nLnpob3VAbGludXguZGV2OyB1c2FtYWFyaWY2NDJAZ21haWwuY29t
Ow0KPiBzaGFrZWVsLmJ1dHRAbGludXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcs
IFlpbmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc7DQo+IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNv
bT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3Bh
bCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY3IDYvOF0gbW06IHpzd2FwOiBTdXBwb3J0IG1USFAgc3dhcG91dCBpbg0KPiB6c3dhcF9zdG9y
ZSgpLg0KPiANCj4gT24gVHVlLCBTZXAgMjQsIDIwMjQgYXQgMjowOOKAr1BNIE5oYXQgUGhhbSA8
bnBoYW1jc0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCBTZXAgMjQsIDIwMjQg
YXQgMTo1MeKAr1BNIFNyaWRoYXIsIEthbmNoYW5hIFANCj4gPiA8a2FuY2hhbmEucC5zcmlkaGFy
QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgYW4gZXhjZWxs
ZW50IHBvaW50LiBUaGFua3MgTmhhdCBmb3IgY2F0Y2hpbmcgdGhpcyEgSSBjYW4gc2VlIHR3bw0K
PiA+ID4gb3B0aW9ucyB0byBzb2x2aW5nIHRoaXM6DQo+ID4gPg0KPiA+ID4gT3B0aW9uIDE6IElm
IHpzd2FwX210aHBfZW5hYmxlZCBpcyAiZmFsc2UiLCBkZWxldGUgYWxsIHN0b3JlZCBvZmZzZXRz
DQo+ID4gPiBmb3IgdGhlIG1USFAgaW4genN3YXAgYmVmb3JlIGV4aXRpbmcuIFRoaXMgY291bGQg
cmFjZSB3aXRoIHdyaXRlYmFjaw0KPiA+ID4gKGVpdGhlciBvbmUgb3IgbW9yZSBzdWJwYWdlcyBj
b3VsZCBiZSB3cml0dGVuIGJhY2sgYmVmb3JlIHpzd2FwX3N0b3JlDQo+ID4gPiBhY3F1aXJlcyB0
aGUgdHJlZSBsb2NrKSwgaG93ZXZlciwgSSBkb24ndCB0aGluayBpdCB3aWxsIGNhdXNlIGRhdGEN
Cj4gaW5jb25zaXN0ZW5jaWVzLg0KPiA+ID4gQW55IG9mZnNldHMgZm9yIHN1YnBhZ2VzIG5vdCB3
cml0dGVuIGJhY2sgd2lsbCBiZSBkZWxldGVkIGZyb20genN3YXAsDQo+ID4gPiB6c3dhcF9zdG9y
ZSgpIHdpbGwgcmV0dXJuIGZhbHNlLCBhbmQgdGhlIGJhY2tpbmcgc3dhcCBkZXZpY2UncyBzdWJz
ZXF1ZW50DQo+ID4gPiBzd2Fwb3V0IHdpbGwgb3Zlci13cml0ZSB0aGUgenN3YXAgd3JpdGUtYmFj
ayBkYXRhLiBDb3VsZCBhbnl0aGluZyBnbw0KPiB3cm9uZw0KPiA+ID4gd2l0aCB0aGlzPw0KPiA+
DQo+ID4gSSB0aGluayB0aGlzIHNob3VsZCBiZSBzYWZlLCBhbGJlaXQgYSBiaXQgYXdrd2FyZC4N
Cj4gPg0KPiA+IEF0IHRoaXMgcG9pbnQgKHpzd2FwX3N0b3JlKCkpLCB3ZSBzaG91bGQgaGF2ZSB0
aGUgZm9saW8gYWRkZWQgdG8gdG8NCj4gPiBzd2FwIGNhY2hlLCBhbmQgbG9ja2VkLiBBbGwgdGhl
IGFzc29jaWF0ZWQgc3dhcCBlbnRyaWVzIHdpbGwgcG9pbnQgdG8NCj4gPiB0aGlzIHNhbWUgKGxh
cmdlKSBmb2xpby4NCj4gPg0KPiA+IEFueSBjb25jdXJyZW50IHpzd2FwIHdyaXRlYmFjayBhdHRl
bXB0LCBldmVuIG9uIGEgdGFpbCBwYWdlLCBzaG91bGQNCj4gPiBnZXQgdGhhdCBmb2xpbyB3aGVu
IGl0IGNhbGxzIF9fcmVhZF9zd2FwX2NhY2hlX2FzeW5jKCksIGFuZCB3aXRoDQo+ID4gcGFnZV9h
bGxvY2F0ZWQgPT0gZmFsc2UsIGFuZCBzaG91bGQgc2hvcnQgY2lyY3VpdC4NCj4gPg0KPiA+IFNv
IEkgZG9uJ3QgdGhpbmsgd2Ugd2lsbCByYWNlIHdpdGggenN3YXBfd3JpdGViYWNrKCkuDQo+ID4N
Cj4gPiBZb3NyeSwgQ2hlbmdtaW5nLCBKb2hhbm5lcywgYW55IHRob3VnaHRzPw0KPiANCj4gV2h5
IGNhbid0IHdlIGp1c3QgaGFuZGxlIGl0IHRoZSBzYW1lIHdheSBhcyB3ZSBoYW5kbGUgenN3YXAN
Cj4gZGlzYWJsZW1lbnQ/IElmIGl0IGlzIGRpc2FibGVkLCB3ZSBpbnZhbGlkYXRlIGFueSBvbGQg
ZW50cmllcyBmb3IgdGhlDQo+IG9mZnNldHMgYW5kIHJldHVybiBmYWxzZSB0byBzd2Fwb3V0IHRv
IGRpc2suDQo+IA0KPiBUYWtpbmcgYSBzdGVwIGJhY2ssIHdoeSBkbyB3ZSBuZWVkIHRoZSBydW50
aW1lIGtub2IgYW5kIGNvbmZpZyBvcHRpb24/DQo+IEFyZSB0aGVyZSBjYXNlcyB3aGVyZSB3ZSB0
aGluayB6c3dhcG91dCBvZiBtVEhQcyB3aWxsIHBlcmZvcm0gYmFkbHksDQo+IG9yIGlzIGl0IGp1
c3QgZHVlIHRvIGxhY2sgb2YgY29uZmlkZW5jZSBpbiB0aGUgZmVhdHVyZT8NCg0KVGhhbmtzIE5o
YXQgYW5kIFlvc3J5IGZvciB0aGUgc3VnZ2VzdGlvbnMvY29tbWVudHMuDQoNCklmIEkgcmVjYWxs
IGNvcnJlY3RseSwgdGhlIHRvcGljIG9mIGFkZGluZyBhIGNvbmZpZyBvcHRpb24va25vYiBjYW1l
IHVwDQpiYXNlZCBvbiBlYXJsaWVyIGRhdGEgSSBoYWQgY29sbGVjdGVkIHdpdGggYSB6cmFtIGJh
Y2tpbmcgZGV2aWNlIHNldHVwLA0Kd2hpY2ggc2hvd2VkIGEgcGVyZm9ybWFuY2UgZGVncmFkYXRp
b24gd2l0aCB6c3RkLCBidXQgbm90IHdpdGggZGVmbGF0ZS1pYWEuDQoNClNpbmNlIHRoZSB2NyBk
YXRhIGNvbGxlY3RlZCB3aXRoIGFuIDgyM0cgU1NEIHN3YXAgZGlzayBwYXJ0aXRpb24gaW5kaWNh
dGVzDQp0aGF0IHdlIGdldCBnb29kIHRocm91Z2hwdXQgYW5kIGxhdGVuY3kgaW1wcm92ZW1lbnRz
IHdpdGggenN3YXAtbVRIUA0Kd2l0aCB6c3RkIGFuZCBkZWZsYXRlLWlhYSwgSSBhbSBub3Qgc3Vy
ZSBpZiB0aGUga25vYiBpcyBzdGlsbCByZXF1aXJlZCAoaWYgdGhpcw0KaXMgcmVwcmVzZW50YXRp
dmUgb2YgbW9zdCBvZiB0aGUgc2V0dXBzIHRoYXQgdXNlIG1USFApLg0KDQpJIGFtIGNvbmZpZGVu
dCBhYm91dCB0aGUgenN3YXAtbVRIUCBmZWF0dXJlIGl0c2VsZiwgYW5kIGRvbuKAmXQgdGhpbmsg
dGhlDQprbm9iIGlzIG5lZWRlZCBmcm9tIHRoYXQgcGVyc3BlY3RpdmUuIEkgdGhpbmsgdGhlIHF1
ZXN0aW9uIGlzIHJlYWxseSBhYm91dA0KaGF2aW5nIHRoZSBhYmlsaXR5IHRvIGRpc2FibGUgenN3
YXAtbVRIUCBpbiBzb21lIGV4aXN0aW5nIHNldHVwIHdoZXJlDQpoYXZpbmcgbVRIUCBlbmFibGVk
IHBlcmZvcm1zIHdvcnNlIHdpdGggdGhpcyBwYXRjaHNldCB0aGFuIHdpdGhvdXQuDQoNCkkgYW0g
T2sgd2l0aCBoYXZpbmcgdGhlIGtub2IgYW5kIGhhbmRsaW5nIGl0IHVzaW5nIE9wdGlvbiAxLCBv
ciwgbm90DQpoYXZpbmcgYSBrbm9iLg0KDQpUaGFua3MsDQpLYW5jaGFuYSANCg0KPiANCj4gPg0K
PiA+ID4NCj4gPiA+IE9wdGlvbiAyOiBPbmx5IHByb3ZpZGUgYSBidWlsZCBjb25maWcgb3B0aW9u
LA0KPiA+ID4gQ09ORklHX1pTV0FQX1NUT1JFX1RIUF9ERUZBVUxUX09OLCB0aGF0IGNhbm5vdCBi
ZSBkeW5hbWljYWxseQ0KPiBjaGFuZ2VkLg0KPiA+DQo+ID4gVGhpcyBjYW4gYmUgYSBsYXN0IHJl
c29ydCB0aGluZywgaWYgdGhlIGFib3ZlIGRvZXNuJ3Qgd29yay4gTm90IHRoZQ0KPiA+IGVuZCBv
ZiB0aGUgd29ybGQsIGJ1dCBub3QgaWRlYWwgOikNCj4gPg0KPiA+ID4NCj4gPiA+IFdvdWxkIGFw
cHJlY2lhdGUgc3VnZ2VzdGlvbnMgb24gdGhlc2UsIGFuZCBvdGhlciBwb3RlbnRpYWwgc29sdXRp
b25zLg0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+IEthbmNoYW5hDQo=


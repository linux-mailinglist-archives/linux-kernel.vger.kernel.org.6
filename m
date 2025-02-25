Return-Path: <linux-kernel+bounces-531772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516FAA44496
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD64219C27DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6994155C8C;
	Tue, 25 Feb 2025 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eICYD0wi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2F140E3C;
	Tue, 25 Feb 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498042; cv=fail; b=kpyw/Aqc6eCcTlYAHRlVd83Y4odh3uyLMLHCQIxy9ztoujys3oS5KHPwIXnDhQqW/ELT/5a6ZelMK7eDie8dXeZdQzLDuK1dVFkNoOh+mOhV9xXV10dkKyCLdcsujto+FfwuT0+q2QFYhD+3K0drZ2m1o4TtZZye8ZQAuan6jhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498042; c=relaxed/simple;
	bh=1l6qLlkJgC/l5m1wPP5EN06KiPSp4djcuVQ6slrs1nE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UpooL0TK+egUgcn89nx27EZgLQ2lgMyBSSjy4XNKGL6xLkX/1swGLMx9xafW5cRF8TedsdwqFyqd4IoQlO1qE2p243RuGMm6KphoBqSj6Y84Tkkjy5JtebiP0IC0T4sakAgVP2bg9HgTXgVGIu1M3++wrzYRkhjQg2qmuqq+iXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eICYD0wi; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740498041; x=1772034041;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1l6qLlkJgC/l5m1wPP5EN06KiPSp4djcuVQ6slrs1nE=;
  b=eICYD0wi+gu+yN1cOjhpKn8KKlnJ+V+nQsWTqWKvEDfdlEDlxCig+3Nr
   jTfZLaEX2sChQUqVnrFwRBNiO++FG0VnwTkFEV8Plqhssvg+j+9vMXGm7
   5fr1b1mjnabM3+9/UGQR13uMBu84btngU48ViP7cF6p/3/P6f/qZFRwCF
   6S2IhE7DOzO7TyFoizvtb/wq6EkUHPEHrjdr4cIc5DQlGv/WWM8934xd9
   pYKu4YxiJzcPD7ZD4xliAdFRqSXWE71Vdwzp3hUa7JSIBeRRt6KQix+3l
   stI4Mp5lvaBW1uQJ39OmZAU6H5+2TNphLpObwaRXpPCNw+F4J8guHQJFK
   A==;
X-CSE-ConnectionGUID: af3pxtiPQJuSiDAU/2WKRQ==
X-CSE-MsgGUID: Y/gvhxvcRES1uni2BDSDyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52708745"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="52708745"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 07:40:40 -0800
X-CSE-ConnectionGUID: 8+IIvQNtSF+VCTZCV7nrWw==
X-CSE-MsgGUID: FnPRtxhgTJWqJ/91D16mgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120535663"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 07:40:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 07:40:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 07:40:36 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 07:40:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsTRTLcOVtbg0hrbboJ1pIHq2+ZgVS6hWnIOy3ANRswWe/165i4nUs69kQCRAQwvpgvTlqDhDEC20OrAmmOr0JEygo366nNcX9BFD1EFhp8mMxVhJ+TdY76GWAEYUVgq2QbRP56s2x1hvifcFO+TZuqoXoSwwxMwndEsEr6tH/mqM4mIWJ6KFlYsw2XFEkh+Srto5MCLpNCRCSoUboZ9rmxs4G5/LfvEMKt6nmvBelIqG7JFGqmWT8A4ThZ6p/+itqs02MIKrfpW2REYRzjSidAjbrvEXkUMECblj1QotnYD8lAFYT2QQNwPZ6D3FcZQ2DtwDvcdv+xeGzRkzPkFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PQLBivEoT1UBSqDp49iU7lYurciYe66wD2t94XSzsI=;
 b=MYGEP9xsQZZ28qMdvJXcqMiOTP78yzI9NQ6x85xYLAZxG92cWaRA74VUXu24eFbX+l+6ujQ5nx48QkkmtyGtG9sS3PSWT1i/Mj6xtKsPpb/R/sGZ5QPmWWU/6MNi36oV7MgvBeKto1y3MtfCz90CRGrOzUMVNDt4DJdGBDbNApHZd8QUT+FA0+Ym2ydZWr9fyurQ0SYV8PXCv2b4QXtrGitAfoho7gkUc85JvwyLukiK/jkBt1Lf4VRIBszMnL17og5PzJ3hE91/5Avrsw/UnqlBI6i4hkTZh2EZVneX61GBhUGpdBRz/klL+VjhKI6dYLu8WEt7L4xEOZ7CH3ehUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 15:40:01 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:40:01 +0000
Date: Tue, 25 Feb 2025 16:39:15 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: <kees@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<kevinloughlin@google.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<justinstitt@google.com>, <catalin.marinas@arm.com>,
	<wangkefeng.wang@huawei.com>, <bhe@redhat.com>, <ryabinin.a.a@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <will@kernel.org>, <ardb@kernel.org>,
	<jason.andryuk@amd.com>, <dave.hansen@linux.intel.com>,
	<pasha.tatashin@soleen.com>, <ndesaulniers@google.com>,
	<guoweikang.kernel@gmail.com>, <dwmw@amazon.co.uk>, <mark.rutland@arm.com>,
	<broonie@kernel.org>, <apopple@nvidia.com>, <bp@alien8.de>,
	<rppt@kernel.org>, <kaleshsingh@google.com>, <richard.weiyang@gmail.com>,
	<luto@kernel.org>, <glider@google.com>, <pankaj.gupta@amd.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kuan-ying.lee@canonical.com>,
	<tony.luck@intel.com>, <tj@kernel.org>, <jgross@suse.com>,
	<dvyukov@google.com>, <baohua@kernel.org>, <samuel.holland@sifive.com>,
	<dennis@kernel.org>, <akpm@linux-foundation.org>,
	<thomas.weissschuh@linutronix.de>, <surenb@google.com>,
	<kbingham@kernel.org>, <ankita@nvidia.com>, <nathan@kernel.org>,
	<ziy@nvidia.com>, <xin@zytor.com>, <rafael.j.wysocki@intel.com>,
	<andriy.shevchenko@linux.intel.com>, <cl@linux.com>, <jhubbard@nvidia.com>,
	<hpa@zytor.com>, <scott@os.amperecomputing.com>, <david@redhat.com>,
	<jan.kiszka@siemens.com>, <vincenzo.frascino@arm.com>, <corbet@lwn.net>,
	<maz@kernel.org>, <mingo@redhat.com>, <arnd@arndb.de>, <ytcoode@gmail.com>,
	<xur@google.com>, <morbo@google.com>, <thiago.bauermann@linaro.org>,
	<linux-doc@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH v2 14/14] x86: Make software tag-based kasan available
Message-ID: <rmj3ffo2cwt26jaiqglz6cahlrqqy76ye47wjdv4xn22nar6mp@7vg5okkq7kjj>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <d266338a0eae1f673802e41d7230c4c92c3532b3.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZezPtE+xaZpsf3B5MwhpfdQV+5b4EgAa9PX0FR1+iawfA@mail.gmail.com>
 <afc4db6mt3uuimj4lokfeglhqc22u5ckgvunqtiwecjan5vjj2@lvphketnxhhr>
 <CA+fCnZdhvzUs6NWxCz+PcxBf=tz5xcsHOraKT5+y+vNJb2b-Lg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdhvzUs6NWxCz+PcxBf=tz5xcsHOraKT5+y+vNJb2b-Lg@mail.gmail.com>
X-ClientProxiedBy: DUZP191CA0042.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::6) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf0f902-d8a1-44c9-838e-08dd55b2aac3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjdYbDZpRTFOMzVTcDNlVnM1alVjWk9DekplVXA4RXl0T3JJQTlseHBuN3VN?=
 =?utf-8?B?NytlTFYyendhajhvYkRMT3JiYzd1eDhkeXlVZmltdlNkZUt0Y3k4US8xV3d5?=
 =?utf-8?B?aEhSc1AzQnUzWWVIM3JVSVhQdVRERmRCSDE2bjBmYXUvN2puZzFKZHJvMDNG?=
 =?utf-8?B?NStFZWZ6bEpqNjBsUXRWRkwxQjJkQzR2WWk1L1Z0dFJNTFpEa05FVVZ2d1k4?=
 =?utf-8?B?VCtsZlE5UitJMVhmYU9xR2l0MTNMRFlEbUFEcktnTEZyV3ZoeVhEL3JNRmJo?=
 =?utf-8?B?WVJKbnExUHV2Z2duOGEyZDFTd29wWGhZQzFYRzNtelpKQkh6bVJpZjVEdUxt?=
 =?utf-8?B?eU1OdXZ0OVJHM0p2SXRxNy9WSHZnRUo2Y01WZUpieFhRU0dkTjFacjFnYVlr?=
 =?utf-8?B?RkZxV0pqaFNnbk1tTDRlaFRDUTRzMkZDR3UzNVFOLzJsaVlLb3RNd3ZyU0Rx?=
 =?utf-8?B?OVFiNGJhR1hhODFyVDFTTHVvZ1V6OTlXRS9paWRLNmxSU3FDemVQMzlmSkI0?=
 =?utf-8?B?WXBKM2dTRkRRNkJVZ1F4NTJKZk5Pa2ozSUJVc3RwQlJ0U0E2d3JpRm5QWXhV?=
 =?utf-8?B?cWtaTzVoRW1KYWp1V2prUElscHJ5UGhUMEJuU1p4UXRRWXRMMDFPTnFaL3V2?=
 =?utf-8?B?NXRtVnpZS3RlK1daSWthYno0NlczWW85d3pvOWppdXFhMWtGakgrdC9zQSto?=
 =?utf-8?B?R29LVExjYjdGZUx2VGtNeTJOK1hCY0xBL1MyWlg0Tk9BRTBZNEo1NlNxRWRX?=
 =?utf-8?B?UkhORENkcCtHbHlzRTNUTStmN3h5cEhGekV0MThQK3grYWJYaUNPN2c0VlJO?=
 =?utf-8?B?aDFWY0pDRzVPUFk2SjRqcGdRN1dKTThwRHFwVVFLZDIwOXQvT05RZXdNMXo3?=
 =?utf-8?B?K1pSZ3l6RjB4TytadGUzUkg1MkJQZEhRaWhKc3JDRmlRZDJLN2twQklYWnAx?=
 =?utf-8?B?SXdQVVRyay81cjI0bklYSUt4eVVER1NvTE9KZnY1YWhocnFINzVmSUljUmoz?=
 =?utf-8?B?QUdqb2VRWUlTTFZSYnl0Z2d1YVlmMnlDcHp2RE1aU2hid2VLYTNXWGRTaEg0?=
 =?utf-8?B?QkxjMHY5ZThvWGJLYzdUQWRqTGxnem00Vkd2UnhhbEI2MFUxQlZEdWsxc3g4?=
 =?utf-8?B?cGQwd0d5cVlLWS84MTBnNW5LenFRWjBucHVOT3YvWExSOXBRenhKUGVnM0hL?=
 =?utf-8?B?WVh5MjZSVVZ2OUoxYXJGSGtBQnpEaTBscks3ZVlUeW1LMWRKcldoMDlrVjdi?=
 =?utf-8?B?R2hBa20yUFVNZ0ZjdjA1dStWL3hhVmx2UmpnMDIwb1FDbURrYUw3OEJSTjRJ?=
 =?utf-8?B?OGFFUWNDRjNzdzM3cjZ1MlRESFYvY0dQdUFrRk1GRDN4dThnMTFBVVZYR0pW?=
 =?utf-8?B?K1RncklaeWhqN1pOZ3IvWHp2R1dzM2FBWHd0NW5td2NFSUN1VEdES1hpU0x0?=
 =?utf-8?B?YzBzaU5pWEF5aUR2Q09MMzFKbXhHLzIyb3V0ckt4WWl0VlFzMEc1cUlNY3Vt?=
 =?utf-8?B?Wjh0ZFJWdTNyaDZjRFRzQWRtMjNjMTlvcVdEOHBjd3hZSzJZZElqVWFjZnkw?=
 =?utf-8?B?OWVNa3hYNElYZ1pKTzRJRFl5S1o5M0xqVnBFZFpoOHZCWUJQMjZWZzlDb3pW?=
 =?utf-8?B?RWIzaE05TFNzWlRGbWVBbTZnRWYxS0IwWFFpczcyVWI2Y2ZXQURDUWZKZUFr?=
 =?utf-8?B?OGtMQWJzSlVnREZ0SE4vVXdMUTdDUitVSklScTN4ZVNiSVJVbys5WGY1ajQw?=
 =?utf-8?B?ZlVFZGErVkhXUUQ0WGtZY2dROXJHNmc2b3ZjNktqamhIeVJxVVpvSkV4TlZh?=
 =?utf-8?B?YzQrVzg3MUhsK0tOMFJHZktOaWErZ2hNdGxXTEFtUEJaVENEZ2xMMVlHNWN5?=
 =?utf-8?Q?dkWcMg1UMRgZG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUR0SFpWMXBCY1cvWGdOcGpLa2h1dEJjcTJqTWVBbkZKK2FmejBiSlhydFV1?=
 =?utf-8?B?SytpTkhIUnFJRm1ncXB3UFNEdlhkVE52bFZ0bFNtb3NpRTJhNmdscHFDUkQy?=
 =?utf-8?B?UGtTKzRDOXlGbG95ZkloMG1sRUNnODNZNVFkdFhLN09pblN2anloQzhYeEJZ?=
 =?utf-8?B?VDBaZmdBUE5Felk5bkk3ajRxMXV4ZzRhZzRjSFp3eWsydTVHNW01RjczTGZi?=
 =?utf-8?B?MkxaeUFORmpaUzllTFVGRllBY1RwdTdxTEZ6VzVOVHk4dEhvaVpab1diNEVi?=
 =?utf-8?B?dGZPTWtPWUN2R29RZTVEWVFVZVFhME82eEgxanVDL3pSclpCUzNCOGhlZWYr?=
 =?utf-8?B?ZjJ3YitSSzAwRENkdjNqMC9FTUdNNFY2Wmo4NVdOby9RWlZreFhnVTBPczN5?=
 =?utf-8?B?WFdjT0lSU2t6QzRxR0FDa3VUMXRXTFdKTzVjbHIvZHlYQ2VjbjhhTFBZZi9i?=
 =?utf-8?B?Ymc3ZTlERnhIU1V0a0RPc0JrL3FUOFl3NEJKZy9MaWFhTjdTd0ZOSUZaVmVp?=
 =?utf-8?B?Q1hHN1VSWXhPdkswSnJJMmpLa1Z6cHdFbllhSDJTUUdVT0JGLzhLNmVJR2d4?=
 =?utf-8?B?K2pIWGRhQnNpMmt4UXdJSmJNWTM4ekRLTWlZTEZ0a28zNWMrRngrb3RDaVVM?=
 =?utf-8?B?RlRBNDBZRUt4RE9vb3o5SFRGWnNwbWpBTHNIaGsxNTdqQW11clZzNE5uRnRK?=
 =?utf-8?B?TmY2eVZEcTZzZ3lYMERWQ09NWk1CUUFZTU5Tekh5N3lVRENvUXlxMVVzTGgw?=
 =?utf-8?B?c0ZMYVE2V3Ric0NDdldFS0ZGam9CeS9xdTZWUG40bmNWNFNDRzV5akVocEd2?=
 =?utf-8?B?MmJybVVWK1NWbTNEYzJSMGxzdktoVlpNR294N1FsTjk0cytBaWVDVmZycVVF?=
 =?utf-8?B?OXBaRStZSkgzZlVaemlvamQvbDhUWklIYlBYNVBzTUlBNDdNd0dkZklmc25J?=
 =?utf-8?B?bitHTW1mb09DVmRXSE1OSEV0Q2d0cHh2UmEyREdVNFB6VHpSeWM2TDFNSGMw?=
 =?utf-8?B?UllIcTBBMHhQWTdIQVBmbWhCSFVqOW1IRXF6WmowM054TnRSMHZjOXh3S211?=
 =?utf-8?B?RGtQSmV4bW8yT0R5R3ZLcW5ieE5KdE5wSzVKaTU5Ym4yWVBGd2h5T1BTWmVw?=
 =?utf-8?B?L3R6S1JQYXFQcmN0WkFRaVBGVXlrM2lVR2ZjeTRCVTVVWFhRUEFWTEh6SGNr?=
 =?utf-8?B?VXRmUG5FSFVRMXhxNnZ6aEZLaVBtamJ3aFQzR2ZWenUyR3c5aStuM1RTVzFC?=
 =?utf-8?B?UURsQ1NmR21HZFdaY0doUWphQjFVZkNoYkhOb3pHaFpvVlhYRndJQ3grNHRC?=
 =?utf-8?B?ejNmazNzak9GTVR6RXFMQmFJZzl6K0FpYVVjdFUxK2laWmc4YW1EVTZienVr?=
 =?utf-8?B?ZG1VQjlubmdRa0lsbnJCL24yZ1MwTnFvK2pVRHZYMGxlQkZSaUViSnZwajg3?=
 =?utf-8?B?YUI1aHhTZEd5R2hMQ0pFZW5qdXdOemJyaWxoVWFXejJtM1dHMm5oOGRMRDJa?=
 =?utf-8?B?YWpBOGFueS91ZFIvU295eG4yTTg0ZHU0VHZrcTRmbXFGTVJVcmxqYmhlUWxz?=
 =?utf-8?B?aXNuZXp4SXE2ZThjSU1TUzhGT21FRFB1TDl0eUNFck8vV2pVRkordnl2YWl6?=
 =?utf-8?B?WUJFdzgxaWlWa2wvREFNOVIwYmlsTVBHRGJhT2FCMnBGT0V2b1NycDBiV01a?=
 =?utf-8?B?MFlPZ0kySDJEY2dFNHJxVnh2MEQ5dmFlUHhvdHpkL2lKTXBnbEgxemlLMHRO?=
 =?utf-8?B?cVNJRkxBS0ZQazl3RXAxRW1NVGpUWExlRy9Xbng0bHhqS1dndTFxL09LTE9I?=
 =?utf-8?B?YU1QM0VZS0ErOFdLOFFrUGV5dmhVTk5sUm4zeXpoSEZGSTMxWWR6L3VFWDBV?=
 =?utf-8?B?eXhpQ0Fod0lyWElaaXZGMWtWS2tkUmlHMmllelZXV09iaGh4S3oweTdHbXNZ?=
 =?utf-8?B?b0JDeXFVRXZVUjlsNmM2dU1uaUh3MnpaNzZvRyt0eTBPTS9EMTZGaVlMenNT?=
 =?utf-8?B?REVKM2tKVDVsWVJHVVA1c2RrWkJiMTZlUjkyQktHY0lFYi9scm5HaCtBQW9Z?=
 =?utf-8?B?ZzdsYnFxWXdGMEdVU3JhYVNYc2g2S2lNMWltSHVtUEg3WmhnS1dhYWNwM1Zz?=
 =?utf-8?B?bnRDc0k2VXhvQzIyRW50MlJtRVQ5UTBuemV6SXZBNmtaVXA2VXpXZHBYRUF5?=
 =?utf-8?Q?yfpjaDUkc+onVlhN6Qf8v6s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf0f902-d8a1-44c9-838e-08dd55b2aac3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:40:01.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQrGWZNTjQi5NeP5dEwXUi7WPQuDBsTaNF7HVejUOGfKmhF1TvMacCMaA+RJ3YJ5RDBPsxEKNdwWJ8bNSQsbmhw6Vj57dOZR8g+xJPAAkQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com

On 2025-02-22 at 16:06:34 +0100, Andrey Konovalov wrote:
>On Fri, Feb 21, 2025 at 3:45 PM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> >What's the purpose of this config option? I think we can just change
>> >the value of the KASAN_SHADOW_SCALE_SHIFT define when KASAN_SW_TAGS is
>> >enabled.
>>
>> Well, I was aiming at later adding the "default 5 if KASAN_SW_TAGS_DENSE", and
>> this way it would look much cleaner than the:
>>
>> if KASAN_SW_TAGS
>>         if KASAN_SW_TAGS_DENSE
>>                 KASAN_SHADOW_SCALE_SHIFT = 5
>>         else
>>                 KASAN_SHADOW_SCALE_SHIFT = 4
>> else
>>         KASAN_SHADOW_SCALE_SHIFT = 3
>
>I think this is fine. It's still better than adding a non-configurable
>config option.
>
>> But now that I think of it, it should be possible to overwrite the
>> KASAN_SHADOW_SCALE_SHIFT from non-arch code if dense mode is enabled.
>
>This should also work. Especially since the dense mode will probably
>work for arm64 as well.
>
>But let's keep this series self-contained.

Yes, of course. Anyway I'll just do one preprocessor if else in the same place
that the old x86 KASAN_SHADOW_SCALE_SHIFT was.

>
>> That's a topic for the next series but I'd imagine all architectures would
>> normally use the 16 memory bytes / shadow byte and if they'd care for the dense
>> mode they'd go for 32 memory bytes / shadow byte. Or do you think that's a
>> faulty assumption?
>
>Probably, but for sure I don't know, not that many architectures that
>care about memory tagging yet :)

I'll keep this assumption for now then. If some arch will have a different idea
about granularity I suppose the relevant code can be moved to arch specific
directories.

-- 
Kind regards
Maciej Wieczór-Retman


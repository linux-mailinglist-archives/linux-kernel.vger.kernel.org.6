Return-Path: <linux-kernel+bounces-522875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60F2A3CF7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9E31895AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4131D89E9;
	Thu, 20 Feb 2025 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2r1OvFk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2781CD1E0;
	Thu, 20 Feb 2025 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019829; cv=fail; b=hMFm97gFRm/GE1yM63jlS2j1fX/TbFeCVrsrM2fFTSKU8GKzY84KWbdf76+jD/Q6bPUfyJnWWnESADILLATji06At19jgL09hK+oobBZAa6H6NyAI+0fozqElhzwDqyyCYXUbRFcGk/UtuJeO1BN0kMIVru8LZCFaC3r1NBI+5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019829; c=relaxed/simple;
	bh=otbgG6m6QuuVfWzLkeRJcIDIID3Q1dDN0MxrRel+UCM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BcMtflMBpHxVNLJt6tSez6XoO9gQT/v5lj5xizdduyQwUt9rYZklF6bKPYv+r2/+kNNcuQoo3NoWZBLXP0NDwO7WUss9sfIbSDhkLzDoY3KvaINspC3QsoDrgql0P473/J8UMMBnJCbc0V+yHEqCZhIoRbUAvDWbixhB3cT+7Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2r1OvFk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740019828; x=1771555828;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=otbgG6m6QuuVfWzLkeRJcIDIID3Q1dDN0MxrRel+UCM=;
  b=U2r1OvFk+MGWhqhdvR1C5ubkyjeTWWT4V6zZmAO02E73j7WclKI+0HWK
   T3AvR1RwEZiNtJGUABcsg+ogbpO9Rhc0gZOoPKBgkN2PIYsPksqf/lzdR
   9XIprPDxUN67B29Aqr5xOFrR2rVTXCwnIRUJQEw15G/Jid/yacoExz2Nd
   h84uNb4XVDZLqjC1PWSzT0HOq5IR+RrXdThroEAJ8wGyTvxTMwuAa1UOH
   n9CGM8bqnFMUpt3Z+aHddNthBoI23RK6RHc9jDQjQaO+dt167MCGsWKp3
   mVOjPe+6s9c48780cxW9xaUqypk6Nncm37Cs1aTmSE/gYuwnwb5I/EYeC
   Q==;
X-CSE-ConnectionGUID: HxtDynGaT2e7X2mv0oaYLA==
X-CSE-MsgGUID: HBv3ureMQ7Cj5vIlcT9TRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39971971"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="39971971"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 18:50:22 -0800
X-CSE-ConnectionGUID: bRGJ3QY1Qb2FHxIeo79I3w==
X-CSE-MsgGUID: BkFiOeEuQNSNwMssXpLF2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152105459"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 18:50:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 18:50:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 18:50:22 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 18:50:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueykPsnkkUsGWPJ9MZXszb4XUCPh2mM4xjj1nWHQoXDEC6WJLKvGfJucl0s9duG3DvQNnBDfJUHBqogyhPE8OCVaNVkC+xgJ7sdK4hqSfi65wt0zHMINccSv83TouOzXCC7kBlGfEg18G4YbWXR5VHXahI4JOkwtop9Kq1AHXFv1nO4h7bNrKIY8P9WlLSHrXPDZ1Fyj3Z6Cz1JsEt3mAK8aY8IExZbHMHlAByc5mVikEphMItk9divGcidJzGFW9h+JyJxNRMKhjJMAuNohkcsrpc/xKKoQBUP5auD84KpmY+AEYq/oYOFTunBuRPlnBKSi1K6+yUHXHLll1sIwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4CE4mFlB4cf7WxrthGGqJzMUhWHAR4BS00o3jg84VU=;
 b=oNxhRwHxICE67M3y0KMrOBjc9jhT1Pu12tfg3M6HfF4JXSRsM1qUgHArIbP59ZjQ4vCaYwDk+TYMx4H7j5OeVMdls2oD8Tlb0OIr32ksdb58I0f3qXJ7KiOOoEajnsWUqd5LRHpW+ZccGT3U13Z7ff9m/MBRXew2jTtKpiDylx6NZPm1uqMubCdct2/k6ATJZ5TsGYZydwCnpIb7P+cYzNUuc8MmfqKhNeMXuR5g5zHAh7YYCaSMCHzDfXkk7L4pJa6iWQBsM/JqPChM88wYQPwAW9q4XcLF8EneeqmE2jsokZrixNvSvelqwyTsn1fEzbMiDvz01nSmPKV6LrzZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7277.namprd11.prod.outlook.com (2603:10b6:8:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 02:49:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 02:49:42 +0000
Date: Thu, 20 Feb 2025 10:49:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<kasan-dev@googlegroups.com>, <kees@kernel.org>,
	<julian.stecklina@cyberus-technology.de>, <kevinloughlin@google.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <justinstitt@google.com>,
	<catalin.marinas@arm.com>, <wangkefeng.wang@huawei.com>, <bhe@redhat.com>,
	<ryabinin.a.a@gmail.com>, <kirill.shutemov@linux.intel.com>,
	<will@kernel.org>, <ardb@kernel.org>, <jason.andryuk@amd.com>,
	<dave.hansen@linux.intel.com>, <pasha.tatashin@soleen.com>,
	<ndesaulniers@google.com>, <guoweikang.kernel@gmail.com>,
	<dwmw@amazon.co.uk>, <mark.rutland@arm.com>, <broonie@kernel.org>,
	<apopple@nvidia.com>, <bp@alien8.de>, <rppt@kernel.org>,
	<kaleshsingh@google.com>, <richard.weiyang@gmail.com>, <luto@kernel.org>,
	<glider@google.com>, <pankaj.gupta@amd.com>, <andreyknvl@gmail.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kuan-ying.lee@canonical.com>,
	<tony.luck@intel.com>, <tj@kernel.org>, <jgross@suse.com>,
	<dvyukov@google.com>, <baohua@kernel.org>, <samuel.holland@sifive.com>,
	<dennis@kernel.org>, <akpm@linux-foundation.org>,
	<thomas.weissschuh@linutronix.de>, <surenb@google.com>,
	<kbingham@kernel.org>, <ankita@nvidia.com>, <nathan@kernel.org>,
	<maciej.wieczor-retman@intel.com>, <ziy@nvidia.com>, <xin@zytor.com>,
	<rafael.j.wysocki@intel.com>, <andriy.shevchenko@linux.intel.com>,
	<cl@linux.com>, <jhubbard@nvidia.com>, <hpa@zytor.com>,
	<scott@os.amperecomputing.com>, <david@redhat.com>, <jan.kiszka@siemens.com>,
	<vincenzo.frascino@arm.com>, <corbet@lwn.net>, <maz@kernel.org>,
	<mingo@redhat.com>, <arnd@arndb.de>, <ytcoode@gmail.com>, <xur@google.com>,
	<morbo@google.com>, <thiago.bauermann@linaro.org>,
	<linux-doc@vger.kernel.org>, <llvm@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 14/14] x86: Make software tag-based kasan available
Message-ID: <202502201048.208452a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d266338a0eae1f673802e41d7230c4c92c3532b3.1739866028.git.maciej.wieczor-retman@intel.com>
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: aa16e35a-b75c-400a-6817-08dd515939c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F4k+UnvCUlHVAJ3M4chVTwDE/FCJUiyQjFIuPfs0efa6+86en9lfazjDGrJK?=
 =?us-ascii?Q?1edKb6JsDlPZgwqLqDzg2rlgxUiQNEHVy7jMoXW/WHo8mBmjnD9AMrSDZpZp?=
 =?us-ascii?Q?1VzyIDF/wK2r5G7bTkf0AtWkUKszAGp3anqb2+z5NCujQoFMNwcLjWv6kpLR?=
 =?us-ascii?Q?iIzoFIvMY+0aOXW8UP4W6aSigL1Bblt7gdGaVZciVFe4Jm6imopK7QFs8xEL?=
 =?us-ascii?Q?nCjlsXFGIYuD2vP+E2eI5n86sG8lysiXb4UmcC9nvqRrOxsHmK0gLOmWW151?=
 =?us-ascii?Q?iO2muNmLXqUVygGyxuhvNtwkOIFYCPNmfUjDDlrBSYPGX7Rb9CoOq7/Altgq?=
 =?us-ascii?Q?UQEWrXWtU1pmKvRDejDaHKX4Fod6p88m0jTj5JJfunyHF3aCTT+1kVE/rvUv?=
 =?us-ascii?Q?5owsdEp6KLnDifGKhC/jwKTn01x/CstBta4Uxr3zsCrfY6VLj8AxSyeQJszZ?=
 =?us-ascii?Q?5ctVo+0p/WIP5ZEqKhCFPXwwrjdm6jsBDgWLs96ZUoNKpeCQCYvQdrT1Qa20?=
 =?us-ascii?Q?te9tLdPtPP+G5z6rUoaREx8O5lpyjNU/oURlq22/QgeB7CA6vtdgMbPaJ5Tz?=
 =?us-ascii?Q?b9xMFRzIDVEdifLdBTMxzCuXTVLy8szsJhcRxS6vb5FAW194qJr5ilOHTp6i?=
 =?us-ascii?Q?TrQQpLFrxhiiZbJcDG/m2z1+Vx8p0lOSjnRP42rgERw+KxjWeZS/GH3/bny7?=
 =?us-ascii?Q?bQRzA7JVIVOTe0f84yqHYV7SyaOuFJBQKOyeVqrrDsGay49Tp+Auw/UXalNA?=
 =?us-ascii?Q?d/SUQr7B8ewpw4SycNjWB6nFOJp1gv3G5CX4Tk4+P9FcJleMB5rJJbkjSwUI?=
 =?us-ascii?Q?V07CQLzGB7KeNdqJT7xBV1CI7urzfJHRkrpb1fxqHfVhcgbxtWd4Arg9izzx?=
 =?us-ascii?Q?cfsv+NIQ72X2W0bd1ht5e6PZAjojBRWyvxB6I4/L9HamJgUCsdjTaoySFKwe?=
 =?us-ascii?Q?tZgrsAB+ylKkQdg3uaII4MtJWEq4J8V1iYzoLQxTNz0UTMizUiHelpSnf80U?=
 =?us-ascii?Q?vXuPIL3L/Vsyy7UkEf82xkwyQkmHbZczUg07skhyA6bwFU3QwVpn2jr1F52j?=
 =?us-ascii?Q?9jc/L9iWVE9msAkE6P2BWEZR3dO/1LeafqQwZfuSK3PLtkYjSHxTF3CzYSz1?=
 =?us-ascii?Q?JHBbj9q5zCT2IJGPswXqYyKG+pd9gC190/PbLM0z4fLtcllVRn28MYdl5lv1?=
 =?us-ascii?Q?RCi68LzZONcMwOe9uBQF3D/V1sE1X+tc1cfTy8yCRvp+lPzovzErOixbRrvj?=
 =?us-ascii?Q?kF7+qiuBCyQzcojQnLcrfHlF7N/r3E+vJgxSsduToaW8WkSoPefqf278Ev5T?=
 =?us-ascii?Q?8WZLXBRjjGpCYt+eAzI7yOnOVP+Lbw066/aejc6lYfDuJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DHoVNpWfuT9qjUWa/D7qKFMfpjU7yxDN7WpD1izfFl8BMmB8F7e9SnVSWYC?=
 =?us-ascii?Q?aJjTpBWeceM/tilMOcVdNHZYW9Rt1zGTeModRiB7ah2J4F+sxzM2adbGC7ln?=
 =?us-ascii?Q?oENF9tQYz+INDitsL46g6BM/lkss2LyKm1sKehs78m9o4VwlfkrKEDIIVXFu?=
 =?us-ascii?Q?uKcHb8cyqFo5TqY8K1fwSfGjuNLwRqLCFIEpX4dQExFxyh+E7kMCrztspxeZ?=
 =?us-ascii?Q?kncwSWFfVxaATcVf8/vjyU4ErHOdvpCKvv5rc6FR3lFUbXA7qGkqsjCltsOp?=
 =?us-ascii?Q?hXxB1zC20xBarNQxq78stbbAx2gbAiYgCdggniNBF+1t/6LONtVfyikSlg4y?=
 =?us-ascii?Q?kjp93METxFr3UyJ0LcauJjmGHH/aXKkiYvzhDjxQZuETcXf1OYE9fdTel2nr?=
 =?us-ascii?Q?ptbJU651ajAhUUpZFrIO6HN9iIecPCL/cngeqNU2yW3kCmYC866kdlrGOafY?=
 =?us-ascii?Q?wcNSpRdyXsb7hvdK48HTruAWadL2YSixFHC4eXqDXCS86Ntmq1EXz3r+x0hE?=
 =?us-ascii?Q?je7v1PzS6Trnjseki08ic2fQqQSFC4/yVk0MxkTEtzTvnP67vYiZTd3VtYAP?=
 =?us-ascii?Q?NJIj+s/MypHEOTzKrlzOkCOA1lcuFUi24l4/cSR16TbnxfalAJOXwrbRSgr2?=
 =?us-ascii?Q?4KPgMGKhMUj3g9Vu9WzPhdokO9vw/37un84T4Cop7+WgQIlcZOqSjvUX47Jq?=
 =?us-ascii?Q?F/eFf/a/ahLKTC5arDGM5LNw/fhgdOfsDrllWEI/hwggC3Pj82PkLN+wkA4W?=
 =?us-ascii?Q?0tILJgMUFZdMKsqfVV8TfQPfUPy4tJvF+XeiZ0KRQbROBcydcHC/wHbvkeVZ?=
 =?us-ascii?Q?FTT0KQf2pi0Ucjwk2NOVAWsjofJh2nQKPWiYehtS/0b8dMzwP879GU5ajqs+?=
 =?us-ascii?Q?acFegqqyUidPV7XMWbg1OnKanWbMZnF897MOXf3WAel5x+VnwmkNmQfpdV+h?=
 =?us-ascii?Q?ui2dWb/SKY/YuRvbq3A1Wt84+SWFQlSVKY59Sug0BnrELEmiXU9MAPhiw7TJ?=
 =?us-ascii?Q?B0oKs8mKK+HJvoYonui55HVh4IJ6BBJFjusfrLan7d+/eIOhWQmkuSa3Fs47?=
 =?us-ascii?Q?DJXpckjhdmko3M1J9ww+BbKutn1WopM9UT6hhrG6Yov89Q2levGLGEWjyB+H?=
 =?us-ascii?Q?fqXqZE4kixqd4usVJjLngxzeOxfjdA5Xpo/hxQDlcJ7wsiYtjdt8Dxnikddl?=
 =?us-ascii?Q?UJXF1uSWuITVeeBAnQv9SlRpNfjQJLmUTlRsSJqfpq/nhxuNdSspuza/Zua8?=
 =?us-ascii?Q?KQk2AqCbtq2MCWQVNajzTZA2ndwE+DIHW7aVwcsxta7+POCBWT+BpTn7IU2D?=
 =?us-ascii?Q?ZvHpu4pMD+29EtHl7ajzGaZJ2ftZDikrqHUTPNRoiCYHezKaRQW6xw4Aw4x6?=
 =?us-ascii?Q?wSGVd1EZAmLxvntgzZyXf5mBH/WzakpR/K6PJZJEqz4LGv+CEFZuK3KDBeGg?=
 =?us-ascii?Q?rQbWiw2owg/GyF6+/G4O5LncssJwbvVd3hreOAVbkvcuMUAADk2GK7aenArI?=
 =?us-ascii?Q?xAi/JkvYhNHIKJKmT2x8WhZ+Fgll4XgZG+SUF/Y40FJ96ZupQ0jYSHkKisLw?=
 =?us-ascii?Q?Fe+rI10x7vg3cN9nQCz53tIZzf+mxWJHhlgGYoMU2E33eGitb52+occsPUr1?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa16e35a-b75c-400a-6817-08dd515939c9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 02:49:42.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stOdY/KYMcWs/dTE3XKLsusb8NJJAhn9tOqJ3BCYuDSG7v2YAETEDclFNhVDr5M3XFB2sUtHgIrjQJwAkXN+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7277
X-OriginatorOrg: intel.com



Hello,

by this commit, we noticed below config diff with its parent
(
* 3742b7b32f28b x86: Make software tag-based kasan available
* 0ef701bc87cdd x86: runtime_const used for KASAN_SHADOW_END  <-- parent
)

@@ -293,7 +293,7 @@ CONFIG_ARCH_HAS_CPU_RELAX=y
 CONFIG_ARCH_HIBERNATION_POSSIBLE=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_AUDIT_ARCH=y
-CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
+CONFIG_KASAN_SHADOW_SCALE_SHIFT=4
 CONFIG_ARCH_SUPPORTS_UPROBES=y
 CONFIG_FIX_EARLYCON_MEM=y
 CONFIG_PGTABLE_LEVELS=5
@@ -5387,13 +5387,15 @@ CONFIG_DEBUG_KMAP_LOCAL=y
 CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
 CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
 CONFIG_HAVE_ARCH_KASAN=y
+CONFIG_HAVE_ARCH_KASAN_SW_TAGS=y
 CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
 CONFIG_CC_HAS_KASAN_GENERIC=y
 CONFIG_CC_HAS_KASAN_SW_TAGS=y
 CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
 CONFIG_KASAN=y
 CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
-CONFIG_KASAN_GENERIC=y
+# CONFIG_KASAN_GENERIC is not set
+CONFIG_KASAN_SW_TAGS=y
 # CONFIG_KASAN_OUTLINE is not set
 CONFIG_KASAN_INLINE=y
 # CONFIG_KASAN_STACK is not set


below full report FYI.


kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_KASAN" on:

commit: 3742b7b32f28b574e97da7c4f50593877b99e95c ("[PATCH v2 14/14] x86: Make software tag-based kasan available")
url: https://github.com/intel-lab-lkp/linux/commits/Maciej-Wieczor-Retman/kasan-sw_tags-Use-arithmetic-shift-for-shadow-computation/20250218-162135
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 882b86fd4e0d49bf91148dbadcdbece19ded40e6
patch link: https://lore.kernel.org/all/d266338a0eae1f673802e41d7230c4c92c3532b3.1739866028.git.maciej.wieczor-retman@intel.com/
patch subject: [PATCH v2 14/14] x86: Make software tag-based kasan available

in testcase: boot

config: x86_64-randconfig-161-20250219
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------------------+------------+------------+
|                                                                                      | 0ef701bc87 | 3742b7b32f |
+--------------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                       | 21         | 0          |
| boot_failures                                                                        | 0          | 18         |
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_KASAN | 0          | 17         |
| RIP:stack_depot_save_flags                                                           | 0          | 17         |
| Kernel_panic-not_syncing:Fatal_exception                                             | 0          | 17         |
| KASAN:maybe_wild-memory-access_in_range[#-#]                                         | 0          | 2          |
+--------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502201048.208452a-lkp@intel.com


[   11.050670][    T0] Oops: general protection fault, probably for non-canonical address 0xfbff888100044018: 0000 [#1] PREEMPT KASAN
[   11.050681][    T0] KASAN: maybe wild-memory-access in range [0xbff8c81000440180-0xbff8c8100044018f]
[   11.050690][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G                T  6.14.0-rc2-00036-g3742b7b32f28 #2
[   11.050700][    T0] Tainted: [T]=RANDSTRUCT
[ 11.050704][ T0] RIP: 0010:stack_depot_save_flags (kbuild/src/smatch/lib/stackdepot.c:335) 
[ 11.050720][ T0] Code: 85 48 85 c0 0f 84 cf 01 00 00 48 8b 0d 35 b0 35 02 4c 8d 24 08 41 81 e7 ff ff 01 00 89 ca c1 e2 0d 81 e2 00 00 fe 07 44 09 fa <89> 54 08 18 4c 89 24 08 4c 89 64 08 08 48 03 4d c0 48 89 0d 04 b0
All code
========
   0:	85 48 85             	test   %ecx,-0x7b(%rax)
   3:	c0 0f 84             	rorb   $0x84,(%rdi)
   6:	cf                   	iret
   7:	01 00                	add    %eax,(%rax)
   9:	00 48 8b             	add    %cl,-0x75(%rax)
   c:	0d 35 b0 35 02       	or     $0x235b035,%eax
  11:	4c 8d 24 08          	lea    (%rax,%rcx,1),%r12
  15:	41 81 e7 ff ff 01 00 	and    $0x1ffff,%r15d
  1c:	89 ca                	mov    %ecx,%edx
  1e:	c1 e2 0d             	shl    $0xd,%edx
  21:	81 e2 00 00 fe 07    	and    $0x7fe0000,%edx
  27:	44 09 fa             	or     %r15d,%edx
  2a:*	89 54 08 18          	mov    %edx,0x18(%rax,%rcx,1)		<-- trapping instruction
  2e:	4c 89 24 08          	mov    %r12,(%rax,%rcx,1)
  32:	4c 89 64 08 08       	mov    %r12,0x8(%rax,%rcx,1)
  37:	48 03 4d c0          	add    -0x40(%rbp),%rcx
  3b:	48                   	rex.W
  3c:	89                   	.byte 0x89
  3d:	0d                   	.byte 0xd
  3e:	04 b0                	add    $0xb0,%al

Code starting with the faulting instruction
===========================================
   0:	89 54 08 18          	mov    %edx,0x18(%rax,%rcx,1)
   4:	4c 89 24 08          	mov    %r12,(%rax,%rcx,1)
   8:	4c 89 64 08 08       	mov    %r12,0x8(%rax,%rcx,1)
   d:	48 03 4d c0          	add    -0x40(%rbp),%rcx
  11:	48                   	rex.W
  12:	89                   	.byte 0x89
  13:	0d                   	.byte 0xd
  14:	04 b0                	add    $0xb0,%al
[   11.050728][    T0] RSP: 0000:ffffffff84207b08 EFLAGS: 00010002
[   11.050735][    T0] RAX: fbff888100044000 RBX: 0000000000000000 RCX: 0000000000000000
[   11.050765][    T0] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
[   11.050770][    T0] RBP: ffffffff84207b60 R08: ffff8883ee081360 R09: fbff888100044000
[   11.050774][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: fbff888100044000
[   11.050779][    T0] R13: 00000000f44e9436 R14: ffffffff84207b70 R15: 0000000000000001
[   11.050784][    T0] FS:  0000000000000000(0000) GS:ffffffff842fc000(0000) knlGS:0000000000000000
[   11.050791][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.050796][    T0] CR2: ffff88843ffff000 CR3: 00000000042cd000 CR4: 00000000000000b0
[   11.050804][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   11.050808][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   11.050813][    T0] Call Trace:
[   11.050816][    T0]  <TASK>
[ 11.050821][ T0] ? __die_body (kbuild/src/smatch/arch/x86/kernel/dumpstack.c:421) 
[ 11.050831][ T0] ? die_addr (kbuild/src/smatch/arch/x86/kernel/dumpstack.c:?) 
[ 11.050838][ T0] ? exc_general_protection (kbuild/src/smatch/arch/x86/kernel/traps.c:789) 
[ 11.050862][ T0] ? asm_exc_general_protection (kbuild/src/smatch/arch/x86/include/asm/idtentry.h:617) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250220/202502201048.208452a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



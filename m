Return-Path: <linux-kernel+bounces-525802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9981A3F565
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0F97ACB4F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FAE211296;
	Fri, 21 Feb 2025 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IU7cjINA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A9210F49;
	Fri, 21 Feb 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143544; cv=fail; b=c8DrN7hY7ssoUM3vn9t2jcIG33kYbhpcJRT17w9pgZP0N1/LBhX8xRdorCiF3ejRYMjr2Kb34FAmQz8HRQuJWJ41eDEQegkjEefQ1H66lHsjgwv1uHHxGROSWaz3Kvu9l9k0cgGWbNfv2YwUDlRbOOxA1qkrEuaMqoLsvXb5w/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143544; c=relaxed/simple;
	bh=Ju65s/dI/JH2RCaX9C+OxupxgJ3LyQRTpYvBz1/phFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hGggeKaAPS2Iu5SmfQNTdP+Jo6adnOHTJc6TCdPwyi7ZdziPc6uv0t3aahVIAgiENICpB3Spoe/XTA/eGfmGNRsSKQQNubds0ImJfeim5jJgj40eNtAuOHviA2pzyK1pKi5xrnVYMveTX+1KcmC3M5CgAUIeUs/v+Azwb4/k0sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IU7cjINA; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740143541; x=1771679541;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ju65s/dI/JH2RCaX9C+OxupxgJ3LyQRTpYvBz1/phFw=;
  b=IU7cjINAlIQCpczD8x+KxtYzchVNlQq8zJinIgDLP56+n/Ds1XFjyUU+
   r+Eb9Pbswt+qcufrAdZRnHDz01oQ4rS3UyJWxEecH2GbJwnx770sBcOhg
   Oc2sH23F5U425iLPV/WRbb2Am0akFQdIJPDtcoHAs7WjAYQSAL8+q5ba6
   YS1BVgNHjy3La6ZnzNkGM2R8nJMpyAFy7wdFJcAQdyl5Stl7g8pKWJ3e1
   2T5s6pZnxAIR7r0j9dQsCFABs1vVO5lxLKf04lCveodQv3JS1Ru9CLoK5
   lAQ8xeNfaGaaCQ001PrPSEAgP7VaWq1K6zMmQPpAns7oc1Dnr1BNzyxB5
   Q==;
X-CSE-ConnectionGUID: Kpy8yZoZSEmJONkgNnwYuw==
X-CSE-MsgGUID: gNWqmTyOTAWipZ7mMgXZMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40976200"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40976200"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:12:20 -0800
X-CSE-ConnectionGUID: Vc7w+KiQQF64o+SPnpqiPQ==
X-CSE-MsgGUID: Ov1oK/nXRFW0qCnvWrvanQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="146227893"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 05:12:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 05:12:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 05:12:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 05:12:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3G0+1rPeqnOvXlWjpUkXCgklymTBSE+nc0ZZDGRky8P092uW+lbFOx8EjCzQ4w3AL513yw04qa6Lt55HNfTAZTtFRyoDtzc7sTI0MW5IZEgAjO8nesJ42Ie3Taxly5MzfTMXrNul/CZPJGbqpPHbSXcwiuFoJqTZsIYF5TY35P9+S0Nsscx0VhGmOkuTP7eV+GB31ZrVdIGn/EBdZidU7R85tUevB4kscIj857rUCbyAHB5dJtU2JZEc/XKttQ+7zDodrBGMyHW4FHdfs0WHLi/AkHX9ElCmhzFKaJK1mjxx3s9M8OoD4ZIPn2ypMoR8jinKmF3PFrg5WFousZADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Erq851Xpiq5yOKMujew3ksRaFIlOy8OrX7gVYYJ9NPo=;
 b=MSVTuHYRPUEEbdmcOUTrUPKX5vvgrcmAXwa/eOm4ua1FQmW7GhZc++EWph+bircYC/e9KwJuN1CUf9PZ8SZA1GubUVBMoWNmhU1INiST0JLWmAITal6TI7LlsR5kEdIyCr0wbkCMGRyT+qv36fOeU94mEYRIwNTHLlUxU3u0QMEZf+CoxE+3hJvB7EWbpZ1FZtuvRatztNTRC6hnu6Avyridn4ri9NzPBFK4v6I3cKMAnZZRyeoTvMzV/IwjH/uQDidLojRors0/ng3BAFu4qfSkyB5Cyzmx+Ghd1xF23dujI9nwgntZCdG3g2JLSWHBNd2CJkUa0IrUliJa0hQeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB8036.namprd11.prod.outlook.com (2603:10b6:510:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 13:12:02 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 13:12:01 +0000
Date: Fri, 21 Feb 2025 14:11:24 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: <kees@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<kevinloughlin@google.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<justinstitt@google.com>, <catalin.marinas@arm.com>,
	<wangkefeng.wang@huawei.com>, <bhe@redhat.com>, <ryabinin.a.a@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <will@kernel.org>, <ardb@kernel.org>,
	<jason.andryuk@amd.com>, <dave.hansen@linux.intel.com>,
	<pasha.tatashin@soleen.com>, <guoweikang.kernel@gmail.com>,
	<dwmw@amazon.co.uk>, <mark.rutland@arm.com>, <broonie@kernel.org>,
	<apopple@nvidia.com>, <bp@alien8.de>, <rppt@kernel.org>,
	<kaleshsingh@google.com>, <richard.weiyang@gmail.com>, <luto@kernel.org>,
	<glider@google.com>, <pankaj.gupta@amd.com>,
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
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow
 computation
Message-ID: <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::34) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 15531a96-012d-40db-372a-08dd5279544e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aS9WdERUbldINFVzMkszZitrQkhWTnV3U2hWT2U2cU9uOWJjREloOWNTd043?=
 =?utf-8?B?NVBiUU94RENtNklMNE1vdVVKam1EcFNHVkkvbEVUUkxnS0dKYzNMNTFYbmlM?=
 =?utf-8?B?ZjZXUmJTTWVCVjlXRmlyOTZUVXRWdjN6UjlCYUkweW5zaThzN1FPSW9rRGtk?=
 =?utf-8?B?eVFnZk9QNWtsOUxadW9uc3pRZWdkY2gwd1FtdUtMS3VkT0ZPWVZRdVBiZC9z?=
 =?utf-8?B?UHBGN1VaUUtiWkovK2ZyVmdNM0hEVFdqS2k0UHdnUVRwSHlUeFRnSEpWSTM4?=
 =?utf-8?B?UExLRWVaSTV6alNPWno0ZmNJSENTWklkR25pd09ydHN4bzd6Rm1SSjl0dDVt?=
 =?utf-8?B?U1pBbWpDTDVvUlJGZzk4RjhaK1ZaOEVOUE1MMXFTaXI1bm55VEFObVpydEow?=
 =?utf-8?B?SlNYZUNxODVEU0tJZmV5M1pjTEFiMDNubGg2dlRYNWs4UFN1eTJ4VGhwZGlT?=
 =?utf-8?B?eko1WEJpYlF2MDFHeDh5OG1nelFYVHpaMEtlQzh1dGJlVHZPdmtMRXVDaUZk?=
 =?utf-8?B?REpTbmhMNDdQR0pBTTliemJvaHJucXJTTUl2RjJBYXhzMC9DT2t4MUNaQTNE?=
 =?utf-8?B?c1poOW85dVVuY3hOVXNoYlo0R0pjbEsyODRqaXgrMS9LK0swK3ZHSXoyTVhZ?=
 =?utf-8?B?RmRuV2tyY3NlOFhHRUVRVEdHNWZlOE8rOVRqZnI1UFJDVWtBS2s1VkVPeHVi?=
 =?utf-8?B?WkJoTFJuQk5zVjdscXZieWFlT2pVZnBXWjVxRmJadXhMcUU2Q2ZCZllqR1Zx?=
 =?utf-8?B?U3BhTkVQbmdsOVFNQ24rTU5ncUJYQUMrVlNrRFN0SFpBdVQ0dUhWMlpZT0xw?=
 =?utf-8?B?WTFoSzJKS0RvMngraGRUVnR2bEkwczIxcFd3cEpKeHV4bFl1ME16Mm4vYUwv?=
 =?utf-8?B?ZmtUTi9PY1VkMzUwUjFGNEI2ZDdCM2I5ZGRza2dMN3BvU2tFdU9QOGNJUmRW?=
 =?utf-8?B?MEtxR2FkdUlTVDRGYW5KQ2hHQ0dpZGhMTkw1ZXA3TzdDSFNHd3MzTWs5T0Nr?=
 =?utf-8?B?Vlg2amQ0a3RTekJYZkppZGZ4WVV6cDVoOHlwUE1MNkJLU3FlZ0gyS1FMcW5r?=
 =?utf-8?B?OEN2UkUvdWpVdE1UMEdZRHNCUExqdHNicVpjOFIwVTg4bzdVL05sbVdLZ3JF?=
 =?utf-8?B?QWtlMWx0blpOTERVM2UzWDZzMHlLRUQ2SWNQa2NXTDJBNVkyM0QwaG1MZ2Fk?=
 =?utf-8?B?S2xmTUJNdUs3RDNkZVc0RlVLUzhRRUczc1ZIQ2VXVTh2M05BRHpxVFhzdG1F?=
 =?utf-8?B?Q0llSUpwUElUaGlCdDlxOFphN2VWSjJhKzZDbS9HYWdGb3cvN211RlFBREFY?=
 =?utf-8?B?UVZHb2tudFlOVDZGVVcvMU15bVcwWU9xZ3Npb0xJdnB2V1dvOTZCOTl4OXlC?=
 =?utf-8?B?OGI0OTVMWnlHNmcrZkx4bTNybjhTSzJpekJoU3QvaC9YSVBwd05ST1NIUGdN?=
 =?utf-8?B?RXFSaVBPaDVGeTl5MDdFMkF5ekM2WlpIczFnemd3WG9FN0FMd2tFbWZXSjNy?=
 =?utf-8?B?S0piS2JaYWl5T0FaVzZmM3F0OTJ6ZnVrTENuQVE3b2xGejJxbTFvMmF2Qlll?=
 =?utf-8?B?Q2dydFBwZ3hvaEJ5UkFmK0syRHA0Rmt5dkxSM2FHNnQ0RnErcVQ1NGkzbFhL?=
 =?utf-8?B?ZStmRUdkZ1Rzc3doOS9XZXhCNGw2bXBnTXdhU2hmRHlNRlZBS3JjY0c3Rkhq?=
 =?utf-8?B?Qkpsbnh0WTNiU1BhaExPOTRDNURWcm0yL2RhblBQeDB2MDBzNWg0TzFld2lL?=
 =?utf-8?B?Rnh3ajluTGZkSVZEWHljQzNkd3BsQ21iS01YRTAzUm1tZUEyMTdlQW5CQThU?=
 =?utf-8?B?czh1LzI1NjdXelE0b2dJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZGYmh3UUhOWHYvc3J3R0dwT2g2YkZrOUcya0pLamlwc1l1MlRRRkQ4MERu?=
 =?utf-8?B?WllPd2RVNVZiUEg4UXBwV3FMcDEwSXV0OWJ2Tm9aL3FwaENib1ptVXNXM2Zq?=
 =?utf-8?B?QlRZNFp4NGw4YkswcXpaY0RsWlNIajBMY1h2V090R3czMVovWC9xeXFKK3Ir?=
 =?utf-8?B?SkhOT2t3YWRILzN4ODY5cjFmU3VFVGs3ZDdpaW1LdDBQY2NlV1VscGtYN1p1?=
 =?utf-8?B?MjdyaFlVbE1HWDVTdmxjak5LS0JveGk4aCt2MWZ0VGxnVDZRbWNwVTJ2OERM?=
 =?utf-8?B?VkdCbFlpSStsbTBMUkVFYmNTaHVvenFvMmhiZjJzbGd0eHpnREVPdGxNakNB?=
 =?utf-8?B?VHpDUk91N244RHpVa3AxVFdjV0ZPbDJqekwvQXpBWExVZEwxZnVKM1FwZWtS?=
 =?utf-8?B?K1JaamlMcjBIMGVBeTFlMGFxb2pxeFN6THVkMUdITFZnQlFxLzZON3hadXhL?=
 =?utf-8?B?TzM0d2hYU2dHYXhGQXFQdzh4a0hHSVRnMjdjVSttOENqSE5CQmJUS3VtUUxF?=
 =?utf-8?B?MWhVSmh6WS96REQzbW1RTmV0WExMQUN4TEpKL0Y4d1JKcU80VmNzaUE5eW5U?=
 =?utf-8?B?dmVDSFc4RVhrdlhrTGxRZDJZMEtnR1N5UWxETDlOL0NOYSt1NFpucnAzMU9s?=
 =?utf-8?B?c05TOFMvRm9MQ3dXSUpHNVRzNkc2eXBPbXlTODVxZkd0aXdoWGt0Y2FHelJs?=
 =?utf-8?B?ajF5WnNpVUJhc0w5MWFzQldxa0lkaHVRQURZT1NOaDRSbzFHOFRHQzlheFVt?=
 =?utf-8?B?TVVBdW1HTjkwNW82ZEdURGxpTk9hYi85YmlQSGpHcDFEZHRDN2J2eForTk8r?=
 =?utf-8?B?MjNhemt1RFdCdklLVnFwaWluNEtwMmNZVjNlQzFpOXBqc3VNZjJzMkZYNjhM?=
 =?utf-8?B?ZEVrbmZKMWd5VnBWTWQvOGNvUE1uNDJYTnU4UFpCV3ZLZHozVUFzc1JubFJy?=
 =?utf-8?B?bHhCQTh6VEo0OHZnd0JMeGFOUjRWckVJNzVUaXFyNCsrS3FoTWFDU2VxTmZD?=
 =?utf-8?B?MlZhMFIzYXRyRmxKMW9nMXhuT1hLVDJURkFidUt0OVp0TDl0UEE2WEg4Q2ti?=
 =?utf-8?B?bW5RWXpoZ0xSbUhONm5jaytXRDVMNGR3RXRUUWdxajFYV0RvMDFnWHBBQUZP?=
 =?utf-8?B?SGZZcC9XSDE5MVR2c0I0LzJ4LzJQNmVlcVB4Y3BPZW1QSzBiTEtrSVFJRHpZ?=
 =?utf-8?B?aW40Y0NjWmNveXA0Y2d5dWY2cXNvT3pmSlBKQ05hOEZaSVArcE1PdUE3S0NH?=
 =?utf-8?B?TzVaWW1Zd0NsQ0p1UUEzSXhqSHdzU3FHbER0ekJtdllERzdpaW96RUhaRVpu?=
 =?utf-8?B?Y0NaVUc2T1EyMldjSmxQL2F2Y1NGSlJJaGkxcVdYVFZKVWhGaWFvOXBlaGZi?=
 =?utf-8?B?Y29VR3hWdmlBTkZQK3NTRjZrYnJrci85VnBFY053aGdWaHRGSFRvT1BuZ3NU?=
 =?utf-8?B?L0l5OEJCdXJGL1NEc1Rsc2Rub1pXb1pQTDR4VUxsdEh3NlVqa0F6Z1hyMVJ2?=
 =?utf-8?B?MnltYzMwRnY0M0tDb3czT2NuOGRoT09KTjZrdmZYemN3RjBqSFBabk1DUUE3?=
 =?utf-8?B?Q0FNNUZtakIvVkxjUGJGaE55NWlzVDVMU2RpcDd6c25jS2RRYVUySWR3b0Y1?=
 =?utf-8?B?dFNrYWdGWExMUENJQVFrTG1MM1RTSWRNVTlYQVhWSE5WVU83empEL0NpTmpk?=
 =?utf-8?B?WlRzWTdoRDR6N09NYmlhKyswQll1NkZ5MFJXZytrdHJmVzdHbkhsd0tWU01o?=
 =?utf-8?B?UVBQQXAzeWNKbndQZ08yMVZaa1luZFZlZTBCSGtMUno1M0laWUdVVDBwOHpw?=
 =?utf-8?B?cTFZTW5qaVRnbmQzZUVBN0p0OUF6LzNNSDRlQ3M0NjdyY1dJZUp6KzdoTUVB?=
 =?utf-8?B?akNXSVhmY0RxeENoZkZLU2xBb2YyVVE2OHBNNk1VWkkrc0o3Zjl1RWVOZ2x3?=
 =?utf-8?B?SnBiQVVHbDJKRlpZeng1UjR6d1NJOENRekJ3cElsNjZhaDJsV0gvcmZRWWtN?=
 =?utf-8?B?TkwwNWk4am0zTHliM0FtQnZhd0cvZ3czR0Jnc0xhSUZvbC9zY3FFRW1vTnhC?=
 =?utf-8?B?Qy8zcjB4TXAwT0daYUZkQ1luUy9wZjhYSmE1UUY4MDk5WjViQ1dKMkpGQWNC?=
 =?utf-8?B?WXV5bHp1Ymg3ekpTNUN5a1loWERpUUtybG05Z1NVOWRDSDMxbHlaZ0NBajF6?=
 =?utf-8?Q?ChEFH8YHs/8l+ioom5aJhT0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15531a96-012d-40db-372a-08dd5279544e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:12:01.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9oEsLE6aUL+O5C8kX+pftz0qBoVNdQe+/COYRvMFTGIV9yQpoakizRicNenmEcjLSQDIxMPRQ7Qyj0K+Zr92KFusp1aD7vnuGKjRQmvDXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8036
X-OriginatorOrg: intel.com

On 2025-02-20 at 00:29:14 +0100, Andrey Konovalov wrote:
>On Tue, Feb 18, 2025 at 9:16 AM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> From: Samuel Holland <samuel.holland@sifive.com>
>>
>> Currently, kasan_mem_to_shadow() uses a logical right shift, which turns
>> canonical kernel addresses into non-canonical addresses by clearing the
>> high KASAN_SHADOW_SCALE_SHIFT bits. The value of KASAN_SHADOW_OFFSET is
>> then chosen so that the addition results in a canonical address for the
>> shadow memory.
>>
>> For KASAN_GENERIC, this shift/add combination is ABI with the compiler,
>> because KASAN_SHADOW_OFFSET is used in compiler-generated inline tag
>> checks[1], which must only attempt to dereference canonical addresses.
>>
>> However, for KASAN_SW_TAGS we have some freedom to change the algorithm
>> without breaking the ABI. Because TBI is enabled for kernel addresses,
>> the top bits of shadow memory addresses computed during tag checks are
>> irrelevant, and so likewise are the top bits of KASAN_SHADOW_OFFSET.
>> This is demonstrated by the fact that LLVM uses a logical right shift
>> in the tag check fast path[2] but a sbfx (signed bitfield extract)
>> instruction in the slow path[3] without causing any issues.
>>
>> Using an arithmetic shift in kasan_mem_to_shadow() provides a number of
>> benefits:
>>
>> 1) The memory layout is easier to understand. KASAN_SHADOW_OFFSET
>> becomes a canonical memory address, and the shifted pointer becomes a
>> negative offset, so KASAN_SHADOW_OFFSET == KASAN_SHADOW_END regardless
>> of the shift amount or the size of the virtual address space.
>>
>> 2) KASAN_SHADOW_OFFSET becomes a simpler constant, requiring only one
>> instruction to load instead of two. Since it must be loaded in each
>> function with a tag check, this decreases kernel text size by 0.5%.
>>
>> 3) This shift and the sign extension from kasan_reset_tag() can be
>> combined into a single sbfx instruction. When this same algorithm change
>> is applied to the compiler, it removes an instruction from each inline
>> tag check, further reducing kernel text size by an additional 4.6%.
>>
>> These benefits extend to other architectures as well. On RISC-V, where
>> the baseline ISA does not shifted addition or have an equivalent to the
>> sbfx instruction, loading KASAN_SHADOW_OFFSET is reduced from 3 to 2
>> instructions, and kasan_mem_to_shadow(kasan_reset_tag(addr)) similarly
>> combines two consecutive right shifts.
>>
>> Due to signed memory-to-shadow mapping kasan_non_canonical_hook() needs
>> changes - specifically the first part that tries to deduce if a faulty
>> address came from kasan_mem_to_shadow(). Previous value of
>> KASAN_SHADOW_OFFSET prevented any overflows when trying to map the
>> entire linear address space to shadow memory so the check in
>> kasan_non_canonical_hook() could consist of only checking whether the
>> address isn't below KASAN_SHADOW_OFFSET.
>>
>> The signed memory-to-shadow conversion means negative addresses will be
>> mapped below KASAN_SHADOW_OFFSET and positive addresses will map above
>> KASAN_SHADOW_OFFSET. When looking at the mapping of the entire address
>> space there will be an overflow when a big enough positive address will
>> be passed to kasan_mem_to_shadow(). Then the question of finding
>> addresses that couldn't come from kasan_mem_to_shadow() can be reduced
>> to figuring out if the address isn't above the highest overflowed value
>> (most positive address possible) AND below the most negative address
>> possible.
>
>Is there any reason we need this change for x86 SW_TAGS besides the
>optimization benefits?

I wanted to have the shadow memory boundries aligned properly, to not waste page
table entries, so the memory map is more straight forward. This patch helps with
that, I don't think it would have worked without it.

>
>Is it required for the "x86: runtime_const used for KASAN_SHADOW_END"
>patch? If so, please check my comment there first.

Probably not, even if the shadow memory boundry addresses are static defines
it'd be nice to have this patch to already think about the mappings as signed
and about offset as the end of the shadow memory space.

I'll think if I can keep all the things mentioned above without runtime_const. I
had some idea with non-canonical offsets but I need to write this out a bit more
yet.

>
>>
>> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Transforms/Instrumentation/AddressSanitizer.cpp#L1316 [1]
>> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Transforms/Instrumentation/HWAddressSanitizer.cpp#L895 [2]
>> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Target/AArch64/AArch64AsmPrinter.cpp#L669 [3]
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2: (Maciej)
>> - Correct address range that's checked in kasan_non_canonical_hook().
>>   Adjust the comment inside.
>> - Remove part of comment from arch/arm64/include/asm/memory.h.
>> - Append patch message paragraph about the overflow in
>>   kasan_non_canonical_hook().
>>
>>  arch/arm64/Kconfig              | 10 +++++-----
>>  arch/arm64/include/asm/memory.h | 14 +++++++++++++-
>>  arch/arm64/mm/kasan_init.c      |  7 +++++--
>>  include/linux/kasan.h           | 10 ++++++++--
>>  mm/kasan/report.c               | 26 ++++++++++++++++++++++----
>>  scripts/gdb/linux/mm.py         |  5 +++--
>>  6 files changed, 56 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index fcdd0ed3eca8..fe7d79b447c3 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -426,11 +426,11 @@ config KASAN_SHADOW_OFFSET
>>         default 0xdffffe0000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
>>         default 0xdfffffc000000000 if ARM64_VA_BITS_39 && !KASAN_SW_TAGS
>>         default 0xdffffff800000000 if ARM64_VA_BITS_36 && !KASAN_SW_TAGS
>> -       default 0xefff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && KASAN_SW_TAGS
>> -       default 0xefffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_52) && ARM64_16K_PAGES && KASAN_SW_TAGS
>> -       default 0xeffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
>> -       default 0xefffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
>> -       default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>> +       default 0xffff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && KASAN_SW_TAGS
>> +       default 0xffffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_52) && ARM64_16K_PAGES && KASAN_SW_TAGS
>> +       default 0xfffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
>> +       default 0xffffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
>> +       default 0xfffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>
>Ah, we also need to update Documentation/arch/arm64/kasan-offsets.sh,
>these offsets are generated by that script.
>
>Let's also point out in the commit message, that this change does not
>move the location of the shadow memory but only changes the way that
>location is calculated.

Will do, thanks :)

>
>>         default 0xffffffffffffffff
>>
>>  config UNWIND_TABLES
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 717829df294e..e71cdf036287 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -89,7 +89,15 @@
>>   *
>>   * KASAN_SHADOW_END is defined first as the shadow address that corresponds to
>>   * the upper bound of possible virtual kernel memory addresses UL(1) << 64
>> - * according to the mapping formula.
>> + * according to the mapping formula. For Generic KASAN, the address in the
>> + * mapping formula is treated as unsigned (part of the compiler's ABI), so the
>> + * end of the shadow memory region is at a large positive offset from
>> + * KASAN_SHADOW_OFFSET. For Software Tag-Based KASAN, the address in the
>> + * formula is treated as signed. Since all kernel addresses are negative, they
>> + * map to shadow memory below KASAN_SHADOW_OFFSET, making KASAN_SHADOW_OFFSET
>> + * itself the end of the shadow memory region. (User pointers are positive and
>> + * would map to shadow memory above KASAN_SHADOW_OFFSET, but shadow memory is
>> + * not allocated for them.)
>>   *
>>   * KASAN_SHADOW_START is defined second based on KASAN_SHADOW_END. The shadow
>>   * memory start must map to the lowest possible kernel virtual memory address
>> @@ -100,7 +108,11 @@
>>   */
>>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>>  #define KASAN_SHADOW_OFFSET    _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>> +#ifdef CONFIG_KASAN_GENERIC
>>  #define KASAN_SHADOW_END       ((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) + KASAN_SHADOW_OFFSET)
>> +#else
>> +#define KASAN_SHADOW_END       KASAN_SHADOW_OFFSET
>> +#endif
>>  #define _KASAN_SHADOW_START(va)        (KASAN_SHADOW_END - (UL(1) << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
>>  #define KASAN_SHADOW_START     _KASAN_SHADOW_START(vabits_actual)
>>  #define PAGE_END               KASAN_SHADOW_START
>> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
>> index b65a29440a0c..6836e571555c 100644
>> --- a/arch/arm64/mm/kasan_init.c
>> +++ b/arch/arm64/mm/kasan_init.c
>> @@ -198,8 +198,11 @@ static bool __init root_level_aligned(u64 addr)
>>  /* The early shadow maps everything to a single page of zeroes */
>>  asmlinkage void __init kasan_early_init(void)
>>  {
>> -       BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
>> -               KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
>> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>> +               BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
>> +                       KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
>> +       else
>> +               BUILD_BUG_ON(KASAN_SHADOW_OFFSET != KASAN_SHADOW_END);
>>         BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS), SHADOW_ALIGN));
>>         BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS_MIN), SHADOW_ALIGN));
>>         BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, SHADOW_ALIGN));
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index 890011071f2b..b396feca714f 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -61,8 +61,14 @@ int kasan_populate_early_shadow(const void *shadow_start,
>>  #ifndef kasan_mem_to_shadow
>>  static inline void *kasan_mem_to_shadow(const void *addr)
>>  {
>> -       return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
>> -               + KASAN_SHADOW_OFFSET;
>> +       void *scaled;
>> +
>> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>> +               scaled = (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT);
>> +       else
>> +               scaled = (void *)((long)addr >> KASAN_SHADOW_SCALE_SHIFT);
>> +
>> +       return KASAN_SHADOW_OFFSET + scaled;
>>  }
>>  #endif
>>
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index 3fe77a360f1c..5766714872d3 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -645,15 +645,33 @@ void kasan_report_async(void)
>>   */
>>  void kasan_non_canonical_hook(unsigned long addr)
>>  {
>> +       unsigned long max_shadow_size = BIT(BITS_PER_LONG - KASAN_SHADOW_SCALE_SHIFT);
>>         unsigned long orig_addr;
>>         const char *bug_type;
>>
>>         /*
>> -        * All addresses that came as a result of the memory-to-shadow mapping
>> -        * (even for bogus pointers) must be >= KASAN_SHADOW_OFFSET.
>> +        * With the default kasan_mem_to_shadow() algorithm, all addresses
>> +        * returned by the memory-to-shadow mapping (even for bogus pointers)
>> +        * must be within a certain displacement from KASAN_SHADOW_OFFSET.
>> +        *
>> +        * For Generic KASAN the displacement is unsigned so the mapping from zero
>> +        * to the last kernel address needs checking.
>> +        *
>> +        * For Software Tag-Based KASAN, the displacement is signed, so
>> +        * KASAN_SHADOW_OFFSET is the center of the range. Higher positive
>> +        * addresses overflow, so the range that can't be part of
>> +        * memory-to-shadow mapping is above the biggest positive address
>> +        * mapping and below the lowest possible one.
>>          */
>> -       if (addr < KASAN_SHADOW_OFFSET)
>> -               return;
>> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
>> +               if (addr < KASAN_SHADOW_OFFSET ||
>> +                   addr >= KASAN_SHADOW_OFFSET + max_shadow_size)
>> +                       return;
>> +       } else {
>> +               if (addr < KASAN_SHADOW_OFFSET - max_shadow_size / 2 &&
>> +                   addr >= KASAN_SHADOW_OFFSET + max_shadow_size / 2)
>> +                       return;
>
>Ok, I think this would work for what I had in mind.
>
>However, I just realized that this check is not entirely precise. When
>doing the memory-to-shadow mapping, the memory address always has its
>top byte set to 0xff: both the inlined compiler code and the outline
>KASAN code do this

Do you mean that non-canonical addresses passed to kasan_mem_to_shadow() will
map to the same space that the canonical version would map to?

What does that? Does the compiler do something more than is in
kasan_mem_to_shadow() when instrumenting functions?

> 		    Thus, the possible values a shadow address can
>take are the result of the memory-to-shadow mapping applied to
>[0xff00000000000000, 0xffffffffffffffff], not to the whole address
>space. So we can make this check more precise.

In case my question above didn't lead to this: what happens to the rest of the
values if they get plugged into kasan_mem_to_shadow()?

>
>> +       }
>>
>>         orig_addr = (unsigned long)kasan_shadow_to_mem((void *)addr);
>>
>> diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
>> index 7571aebbe650..2e63f3dedd53 100644
>> --- a/scripts/gdb/linux/mm.py
>> +++ b/scripts/gdb/linux/mm.py
>> @@ -110,12 +110,13 @@ class aarch64_page_ops():
>>          self.KERNEL_END = gdb.parse_and_eval("_end")
>>
>>          if constants.LX_CONFIG_KASAN_GENERIC or constants.LX_CONFIG_KASAN_SW_TAGS:
>> +            self.KASAN_SHADOW_OFFSET = constants.LX_CONFIG_KASAN_SHADOW_OFFSET
>>              if constants.LX_CONFIG_KASAN_GENERIC:
>>                  self.KASAN_SHADOW_SCALE_SHIFT = 3
>> +                self.KASAN_SHADOW_END = (1 << (64 - self.KASAN_SHADOW_SCALE_SHIFT)) + self.KASAN_SHADOW_OFFSET
>>              else:
>>                  self.KASAN_SHADOW_SCALE_SHIFT = 4
>> -            self.KASAN_SHADOW_OFFSET = constants.LX_CONFIG_KASAN_SHADOW_OFFSET
>> -            self.KASAN_SHADOW_END = (1 << (64 - self.KASAN_SHADOW_SCALE_SHIFT)) + self.KASAN_SHADOW_OFFSET
>> +                self.KASAN_SHADOW_END = self.KASAN_SHADOW_OFFSET
>>              self.PAGE_END = self.KASAN_SHADOW_END - (1 << (self.vabits_actual - self.KASAN_SHADOW_SCALE_SHIFT))
>>          else:
>>              self.PAGE_END = self._PAGE_END(self.VA_BITS_MIN)
>
>We likely also need to update scripts/gdb/linux/kasan.py.
>
>Also, later in the series, you change KASAN_SHADOW_OFFSET from a
>config option into a runtime_const, which AFAIU would make these
>scripts stop working.

Thanks, I'll have to think about these.

-- 
Kind regards
Maciej Wieczór-Retman


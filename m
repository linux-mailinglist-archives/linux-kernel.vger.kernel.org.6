Return-Path: <linux-kernel+bounces-544150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B3A4DDF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EA0189CDE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2A7202C2E;
	Tue,  4 Mar 2025 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qe5vLI7b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51A20127C;
	Tue,  4 Mar 2025 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091478; cv=fail; b=K6eRZU1VAuKC6GtiOKFm3SAx9VMXw1Um/ntmI+VCyGaRGSu2m/4yuJHyv+OiQ3/Vidiu2QamT0jZm1hezGq2cv4hKWDlrHMDG2qg0m6AyOzMnoQK7cteG9ZQ+VCKFEwdAG4nP2Chza2cNDNd4PgL8TBaz/btpKboS2SDYQmxnAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091478; c=relaxed/simple;
	bh=HKdgA1aIqhsa6RovPGA568tSm0R1YK5yXUfSMi01vJU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g58zolwd2Ji+C2H7QPRNhI7U/ykzMbvbRR4Ctiznxf8WyLP07havXxcsNHRRVKbC8NJXBI20ZWhzK4K1+2UYN95XsmOKHPbc2kgom/yaALoAQ+JjFnbglm/m43xLUusfdTV2ZktWz2uYCdqXMI9khYcRL6zOITwVSc6v4pjFikU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qe5vLI7b; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741091476; x=1772627476;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HKdgA1aIqhsa6RovPGA568tSm0R1YK5yXUfSMi01vJU=;
  b=Qe5vLI7bWkqcMr/iKN/d/awPiacHTDEKGmKTAja9xkcYxCesOkFTXmUX
   suH6OBQeIrF04RwwUaVxDEAj08qOY+ZsuQP7qytl3AwSsMw647D50/Shh
   uzvyvgUEbohb2+2fK5gtijpFj7NFKaaH3Nc02sgcA3DIVJ0kN6F/KkxBE
   qs3TEFTIG9VdvbdBHKcMbt5WjADbr9mj1ZHKEWx1ykMrw/QY/H6cZmUQ1
   m7ocgvEqZJVsrBpmi1gKNUmFv0gsxSvkOeD+UY0lv3b2Vn0ERumIdko4P
   gKtQ7C3mDB8D2D+WQ2sZ/w4zx6E58nLrLTKa18Ypsf02Q2ntx0fBrqDVJ
   Q==;
X-CSE-ConnectionGUID: NEJP9mD+QPejA0695kQjaQ==
X-CSE-MsgGUID: QxnkTL3lQc6YrQbJhgyedQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42131431"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42131431"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 04:31:15 -0800
X-CSE-ConnectionGUID: q8FbGAJcRkCU33cpR+Ijpw==
X-CSE-MsgGUID: xTmjFuFDR6uQDHALpl6KEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="149151521"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 04:31:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 04:31:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 04:31:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 04:31:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elBCuFg+ZLCDlWhIB/VudQbQGDVaDgm6plYIQPepU7GHYDQejFy2K+/maOnmtLzv446Y/6ow7HsBX/lisMZQeq81ftxi9uYStx4i35nS5MdbViyndZlwgcxzoX3VTv3SVLahKVShLhJ/PcdItYNT4n+WIKWkYA9+oqhVFfanbSd8RhsD0n+/A1B65nk4KzLE3f4Ocz1oKxx2/nazWAoa9MdluzlK+Q/Ab7RFtrA2l4RMWjWM8I/2NcteAyGJVr5n28Mm6F/+s9cWGQHkBiavjVdxGUV8UQ+kyHlATTcZ6++QFhLFMdhoX98h1gZOkH2wpJnbJoRg2pFsPjpDgsgOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSlA5+wP6hyocpEP58JMinuLswDOekjuyWJTFi3e9uQ=;
 b=tcLZ3pSR5xUwr5uu2Xzk1E4NyzySTbJo5CZfKFgTxGLB1OWu2iPA0UxxlM3G1hMz/mTUDBM+ALk7FWqNlj6vwnvbX0+xpiLVRRe3Izz80TLXDyOlmpV8+Ls0kvmIrj/EKWVSC+XEdxaqE4B4u+SfpXplLMI0Lw/hmokqU6FIIP5X9i3x3mbtovRXp/d5DsN1V49ghKdZHB8bL9vCpRjXGAc7Gu8zJMHYo74mENs1faVN1B+oXRZ3oA58K8MwkTWaUO/qD2APZKtU1x23P0h5ykYDi8L3UU6EEMcdBKfIOUq7fEN3a6YM2zjyaOzYfglp5O6Sr4kmvUBvbf5wEkGJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 12:31:09 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 12:31:09 +0000
Date: Tue, 4 Mar 2025 13:29:34 +0100
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
Message-ID: <aanh34t7p34xwjc757rzzwraewni54a6xx45q26tljs4crnzbb@s2shobk74gtj>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
 <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
 <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
 <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
 <CA+fCnZfb_cF1gbASZsi6Th_zDwXqu4KMtRUDxbsyfnyCfyUGfQ@mail.gmail.com>
 <paotjsjnoezcdjj57dsy3ufuneezmlxbc3zk3ebfzuiq722kz2@6vhollkdhul7>
 <CA+fCnZcCCXPmeEQw0cyQt7MLchMiMvzfZj=g-95UOURT4xK9KQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcCCXPmeEQw0cyQt7MLchMiMvzfZj=g-95UOURT4xK9KQ@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0296.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::31) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA2PR11MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2146bf-1930-4e21-e979-08dd5b187123
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXUxRWg2cFdacExJcWFhR0JZeFFpWDI3QjkxV2Qyc0RPejNPYndYeU1uZWJk?=
 =?utf-8?B?a0M2R21BdlF3VFRCTnpDVU9Pa01EcmozN2d2SndiWjNUK2hCL1NEbkJIQkNn?=
 =?utf-8?B?V0c3RDJZbTFyZHFJTGdpS1FhKzZoT3crNFU3UU1UQStiS3VHc04xL1RYOFRU?=
 =?utf-8?B?OE9zWkxhbGZ1QjhwZnJ4b09CUnlxL04xZFVCU2VXdmRJVCtGTUpRNUt0bFlY?=
 =?utf-8?B?K1FTVVkrWFFyVzkxM0FhMyswQ2dMMk4zRmI1dlpjM2tNMFVmdUY4L1hQZkI1?=
 =?utf-8?B?ak8wRFp0QXRIUCtiMkQvcUtwWlZnQWx5TDg1REJNOFBzOWFMdGovb2lLSHQz?=
 =?utf-8?B?MzQ5MlU3VUIvRDE0SDI2Yk9kVFdxMTZ6alNGSFFoVjg3RjAraVV3M3lvcHhG?=
 =?utf-8?B?eVFxNWMzQkhlUEUvSUhsMjBYbThGUGtONExwT3VOMkErcXhucmdBenlpQ1Jm?=
 =?utf-8?B?R1RIZ01ucENNQkF2OHJQaFRwTjgwV3FMYnRUWVB5L0hjQnJOSjhnVTVucWRp?=
 =?utf-8?B?NUF0b3hSS3pLT2daajhRMklpMU9ieVBjQ1BWWWtPdSs4SXV6NWlwQnZVaStj?=
 =?utf-8?B?VFlPd1Zaa1lCWG9JTFAzUVNRTjdPSFJETFVHdFlLdDNESlhDQ1pRWnVPdXd6?=
 =?utf-8?B?VXFXYldhY1RwdG1RZUFDV2ROZGdIKzM2Tzc2bS9aeldpUU5hRVhWVVRudG9B?=
 =?utf-8?B?SFp1S3pwald4T2Yrdks1ZGNELzA1d3NuQTFXbjhicTB2YzQzamhEV2ZzV3pm?=
 =?utf-8?B?UWh1UkdNaFlkVlhtSTNHeEtFeHZPb05HSWV3UVQ2YVdEenhXeWY5L0VrUStt?=
 =?utf-8?B?M0x4Si9TbkR2ZXpFd29ucGtkaHdvbS9pY2p0bVZOT1BjVXVISzBlVUJQVFRM?=
 =?utf-8?B?dEhNdXBoL3hYZG1BMVBUU2Y5OVgwRm9maEtzWXRwenVrKzdnektqQXVJOXAv?=
 =?utf-8?B?U1lhK21GM2JUTlZtRmlaTGZkSlpwWnZxMnlsdEFMcHNybHB1cytsWFJwRjhi?=
 =?utf-8?B?cEdXVXR6a2JLV3JoMjc4SFljdlBkT3M5bHlXblRodnMrWWhaa01EeWhLM0Nh?=
 =?utf-8?B?Wm9xOWtVTFpPOTIwOGJZS1JzNG15L20wTlhFUjlkUkFhTWJUY094bG15WFY0?=
 =?utf-8?B?emhyVHNCcnhOa2k4RHRCbmJjK2FlU3BlNjBvZUEydm9KSXVVMjV3Y0hQbVgy?=
 =?utf-8?B?QnYydWJTSElOWWdvaHJSbERhNlRtamlFd2R3K0Q3alQ3YTJTTy9IOHB6aHFJ?=
 =?utf-8?B?M05vOVk0OTROeml5UmFzeXMyamRXRytTR1A3cXFBV2JYWUxJS25mdHBMRXhk?=
 =?utf-8?B?TXpjY3psZTYwM0VjTDM3UGtJRWVSUndvWUdwU1E4YUl1TEJrdHdPay92cWUz?=
 =?utf-8?B?RTh3dXA4bzQyWDc4Tzd5bFFOQmQrNlErUXdKRmo3VWJkSnBnMi9kRUIycklu?=
 =?utf-8?B?MUExN3JvcWpBNG9SVlhlaGsrWlovUVN5WEVxNjNSdGx1L0pZaEE4QytZQzVU?=
 =?utf-8?B?QzFMOG92Tk1oRE9sU2Z6ZGp2ai82RWlHM3kwNUZxbTdWSTBpeFR1allSVkFx?=
 =?utf-8?B?U0JIKzVnY0gyd3puNWR0VjM3WWdXWURBSGdmL1FPalE0QURybXhYQldRSVNm?=
 =?utf-8?B?TzVSRjdhM3U5SE9ZSG9qa2EzTmhoYkFmSTY4SkdpcTBPdHNVb09IbmhlMWhZ?=
 =?utf-8?B?eVdnU3M1Tnp4S0VTOURNUVRWKytubXAyUTR5dmFBdml5NW9DVmhza3IvREdB?=
 =?utf-8?B?b0t3TDV4eHFhUXBpeWtFbFVPYU5VQ1loMzVRY1ZBTFZiNXlvQkdBRUwwT1pK?=
 =?utf-8?B?RHFlNk5xeDdwSW9aMy8yRlNuTklNdmRiaEI0TDVTT0xIWHpLS3NiN1lUeS9m?=
 =?utf-8?Q?B/r4zDwRHMo9p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnVZRVVyZm1uMUtOOVdpbHhBSlM1Ly9kMnlZYnNleENJSUg0NGd5eHdxZzJC?=
 =?utf-8?B?b09PcVRyNVM3TzhjTXl0QThhRTRBZDZCdkhJakZZYkFNRXJEQy81UDROWU56?=
 =?utf-8?B?eHhzMGhqMER4UFlpbm14eVpFdzNNSVBuTGdTRmF5V0x5bDZiYmtkTmZRbFNQ?=
 =?utf-8?B?RCtwTnowSERNNWNLUE9YakxramJtNmxmeHhtbUs5cmpyWUV3bFNXa2Fxck9K?=
 =?utf-8?B?RzJSdDVDRjVzelNFWkpqbE1yckFTZ2JGTHN0UWszYkNjSm5GSStIQ2p5TTgr?=
 =?utf-8?B?Zk9pVlF6RGhLRmpPamR6MFJVdUovZ2NQQ1EvMUFweEpUSytZdlVJVDRRT0s3?=
 =?utf-8?B?U3ZydmI2WDd1aWZyYXIrSmszT3QvVWdmK082VDlEN092UXlBTEw5akJha3p6?=
 =?utf-8?B?eGY3bmZYRzJoanB6bC9kSWsxd3ZLQk5FeHN0OVIydE1RRkwyTmc3dWtQZ1RM?=
 =?utf-8?B?ZHYwT3h1L3UwUmJlSUhhSTl0UEhVblUyMjc1ZDlhYWRUNExPMDYxNFpYR0o0?=
 =?utf-8?B?SnNzdS9rUFRWSjVpS0hHWm5kMzN5aWhKYXY4dWx3SVRhcjhsRTlua0U1UWpo?=
 =?utf-8?B?QTRIS0p2MGFKdGJZYzVOSXJFRWRXSWpWRFQ1YnJlM2hJUHF3UEVUVFVuMEdV?=
 =?utf-8?B?RTdFcGtINUxDUDkrR2kwNFNiNTM4SlNyZGlxWFNqd1FwUFV6cXpIZnpobDBl?=
 =?utf-8?B?c2lvTXd2S1ZHTEZJZFRDQXNrZ1AwTkJaQ3Fib0xUdTZoKzdnR1ZLRzdkNmNt?=
 =?utf-8?B?V1ExcUZQL3NUZDl2dlhaVUpZV3luZkpxb0FSWm0yVWtmdkZXR0lPZk5PTFhr?=
 =?utf-8?B?emRhV0tyUURGMFp6aW1zcUdWTTZFa0UxUW1jbWFIb1Q5dlVOUEVlMmZOUDVn?=
 =?utf-8?B?eVhnZks3NjRVb3dHMEZJQitEcHVtNXYwMjFyTTIxV1hhSEFNVzNPdHA0Ni9Z?=
 =?utf-8?B?OEtnR3dRZmF3Nk0vMkVacC9aL3ZmYjBhK3JRdE1FMU5WWEY0NVZJdzFIWDQ0?=
 =?utf-8?B?cktiTFBmZENmSmdXNUxRTWV0QkQzbWh6U05iRGFOL0JTZGM4U0daRk5DRW9U?=
 =?utf-8?B?WlBJWm5jSldpaFUybjArOWhocy9zeERFZHhaTTVJTnpYcFZTaFBzaUFuZDdF?=
 =?utf-8?B?V0ZNL1JTdjhvV21lSHcrUFNob29QL1dJa2R1WjhqWml5SVpvRE40WUgyTU1a?=
 =?utf-8?B?ZmNRYW9wMWdOeDZ5SlhTOERNWnUxTytNdklyUE1zYzV4eXJjVDNSdFViaU9E?=
 =?utf-8?B?L05SZkc0c0IzVTRvL2tkQWZVMG9HbFVzTGdwYkxoc21EWGV0RCtWSnBnQ0V6?=
 =?utf-8?B?ZWlnWUpZaXNtWm1BNDlNWnJUNU43SENUU0pYVHY1WFM2dzU5VTBDQVNOT1hH?=
 =?utf-8?B?ZzNpWCtvS3FkaGluQ3FsNkxwM1JpN09MemxqRXBMdWxsdUZqU01lN3hkSFg1?=
 =?utf-8?B?K1FLZ3pmMnIvY1VCcmhXQ0VlL3hHRi93TUVtUDdCeW1jYi9qb09Wc2hha001?=
 =?utf-8?B?UUhuNEJTdS9nVXZqbXpwaE1aaUpSRHdxWjdmWjFZVlMrWUQxT2tleDZSSnZm?=
 =?utf-8?B?aFYwemUrTjdaUnJZSjV4SzVYSWF6VVZQQS9IYWs4blp6aWYxNjRtV2d5aDlv?=
 =?utf-8?B?MnZoYW9WMk9tclhGcnMyMzA2aGZWRlJkZUMzdXpOYTluNlpZcEtycEkzQWlE?=
 =?utf-8?B?ZXNLK3hxdzhHOUJNMVdIN2RDUTFBc0F5YWxWdjZVRUJHd2dEV0YyaWNMVEhp?=
 =?utf-8?B?VTBOeXZXSGxIMlpYNkRNcS9kcUgxRGQzVXVwaVFsdStyUGZxTE5DTi9Uc0RP?=
 =?utf-8?B?VWpONmEwaWtrTkZsZ2p4NUpOanJZdE5qdUxiZW1Ec0lUWHo1TEs0WnBFaEI1?=
 =?utf-8?B?dkZwYklUMWZnZUJTTDdHamZFMXpLVTlDVU1pUVIwK2NpMzFsZGt5UktKOEk2?=
 =?utf-8?B?b2NYcmV6V0cxL0lSZENRbStVQjRwZUJEM09nMGVrVXVuSHRLbm5TRTlSRUlw?=
 =?utf-8?B?a2JhUWIzK3FUaGVFYTM5VUw0RnZ5bmkzcTdHdWsvcDVFWUVuK1AxOWxPL3F5?=
 =?utf-8?B?ZlJBZ3JOY1dOdlFKMXh6cmxJb1Q1bjBZMkNxc2d3MWFiRXlBVE0wdWFwNW1F?=
 =?utf-8?B?R1JPWnJzSWxRUjRQU3QwNnpwcE4zbjdTZWl0UXdhZlJlaE1lcldzdjBsUjZR?=
 =?utf-8?Q?tpkKL9X1I9HRYAW/c7PrQcM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2146bf-1930-4e21-e979-08dd5b187123
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 12:31:09.3849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuef0KPTsRdN8Vzd3OOuw9UcpQiFVNOBMNHle1QM+QHLBFsVx+4xNQihPQDWZnlJybgDi8XL1DIGtd7Er1YSRJ4UmsSAU0PFRyYC0aVi2O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com

On 2025-03-01 at 01:22:46 +0100, Andrey Konovalov wrote:
>On Thu, Feb 27, 2025 at 1:33 PM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> Btw just out of curiosity on the topic. If we used a runtime specified kasan
>> offset, could the gdb script issue (not knowing the offset at compile-time) be
>> fixed by just exporting the value through sysfs?
>>
>> I know that in inline mode the compiler would still need to know the offset
>> value but I was curious if this approach was okay at least in outline mode?
>
>I think this would work, assuming that GDB can pick it up from sysfs.

One other question that came to me about how KASAN works, is there some
mechanism to prevent data races between two threads? In the compiler perhaps?

For example memory is de-allocated and shadow memory is poisoned but some other
thread was just about to do a shadow memory check and was interrupted?

I've read the kasan/vmalloc.c comments and from them I'd extrapolate that the
caller needs to make sure there are not data races / memory barriers are in
place.

-- 
Kind regards
Maciej Wieczór-Retman


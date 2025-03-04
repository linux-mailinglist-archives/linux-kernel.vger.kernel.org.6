Return-Path: <linux-kernel+bounces-544356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EDFA4E06E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DA13AED3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8002054E0;
	Tue,  4 Mar 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QK6Duca4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934E17583;
	Tue,  4 Mar 2025 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097321; cv=fail; b=dcTeQQHtjEB3yOkVBHZyQhxROXNx2MZ/OdDfxZ9TJ37hLpWqi4FPlOGar+9MMpIWHql53w3OyM7Bzz4TJI7zL9QDAX0FhtDitHuiGAev9f9iHxsSUvBjK12u3/cNS/Pk7vZ3kv5uonTD5YMdLDszacwyUZbklegkLwH07sVMeg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097321; c=relaxed/simple;
	bh=1ZWav+lWKLf2tmmoGPYj8piCv9+hOAY0f10YIfHP0Nk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K1ikuw4OGQlJpIqBjWkZ4yJ0UWbYi/mTiSlU3v3peYd4fSCsoFYdbUaItHXMFnQM+x95azy3JTaC4W2LXAoQPCVRSqxK9/8eDwp3Xy6i+bKACxz5hkNTqpW+xWmbRNHEXYs12BY8hlGXZnEbBiAmEw0A+sre3281y37oQLf77n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QK6Duca4; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741097320; x=1772633320;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1ZWav+lWKLf2tmmoGPYj8piCv9+hOAY0f10YIfHP0Nk=;
  b=QK6Duca4Ju8lz0pMZu4RkFtPzD4ebMM5DgblLKzgH1zBNSQyAkOWf9Ym
   gFlx/pCsqmU0faxjAapwhLpcAl0XPY8p693Fq3hr1HslKMo65JPGsdp0X
   sEubyNzeITKDUOzgsRseSm2TMmdBddKazFd4Aaaf2S2JC3+3r6DjfMHFX
   57DMSVIXhmYifYZrUjvU6M/RCeTEjGLZJdba/RmX7ZqCySNHCYY1M8C4W
   wqzkdGi15+/HfXop+fJYrlAnEciH84thnmI+JY7me0Z9MJeflGRzHw++6
   3+7E/rH34JLzWr7zoI5ONjA4276cnk0ZNyAzJfjXpw+SUzmtrCrwFsQ3K
   Q==;
X-CSE-ConnectionGUID: Ovon9Fa3Q5O2uO+YbzGEGQ==
X-CSE-MsgGUID: QurZnYzvT1GeFfiaOYIJew==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29604020"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="29604020"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:08:36 -0800
X-CSE-ConnectionGUID: 9qgOOcg4Q46q7hssHs1PzA==
X-CSE-MsgGUID: R4e+DAXDQUqJsHWLlvrRVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123321534"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:08:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 4 Mar 2025 06:08:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Mar 2025 06:08:34 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 06:08:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7PWNTolHkyZn6Ls4LVbKEALIko8muiacjYgeuN0ACFN2Y6g+T3l+ooEbKqfwKe06HLkb2Tmv803ntSH/cijdD3f1nOfGMvQRDjkKZ0sJqCHe57XBEOOHHHXmcFSNYnfms9Kin4beqd2kZUJnD/KKbv4ArSRoufObWtqPWF3shBkJSXDt3w0iuSwwqOj9f9Z73jpqMk/532PZIACoFssLmpJmPqpRyCJSDlIovy4b/Kbl4LjMNDLrSETRKzIqmcuyUXbk4dBjR6yb/tzWPB2O4E3wSs1W70DeD+zrkb6eg/B9icYHfvweS8sk5v47Vxg8Elf1tTeXJAGcDrzurFoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlsZN0ueo1ClOTg8p4vIZPRmwYVb3yEyebfGzGqFo58=;
 b=EoCSTbIcGzLGyq6drSIvU6lbKJmaxB12Pt0NMDBAr3ey9Ooa5D1YTq/mpOoWx+sK0UGXzCAsS1AoOr85OlXgvgdwe4hjViwvBD5k7LzAiCbWHwn8QN6ZoDVOJ4WF7PAYXNunmBAKSjThIuFAjCwtBvZHtnGuMzbXQT5HiAw+4W2h8I7aaW5XWVZglCcjIK/JWFbfdTh7d5KLhbgMt9rSimnDMP6YLgooH+eRIoYkyVKP08ovVD8VARB7dQD3x3wYKwo6K94Le+Pc/hWarKDlLSwD2Akso90w7A2yvmd1d/CiaxRwUCVFC72RMSVCNQtZyKdBCMzgjGQXIafAmJzkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MN0PR11MB6087.namprd11.prod.outlook.com (2603:10b6:208:3cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 14:07:33 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 14:07:33 +0000
Date: Tue, 4 Mar 2025 15:06:54 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: Vitaly Buka <vitalybuka@google.com>, <kees@kernel.org>,
	<julian.stecklina@cyberus-technology.de>, <kevinloughlin@google.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <justinstitt@google.com>,
	<catalin.marinas@arm.com>, <wangkefeng.wang@huawei.com>, <bhe@redhat.com>,
	<ryabinin.a.a@gmail.com>, <kirill.shutemov@linux.intel.com>,
	<will@kernel.org>, <ardb@kernel.org>, <jason.andryuk@amd.com>,
	<dave.hansen@linux.intel.com>, <pasha.tatashin@soleen.com>,
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
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow
 computation
Message-ID: <xzxlu4k76wllfreg3oztflyubnmaiktbnvdmszelxxcb4vlhiv@xgo2545uyggy>
References: <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
 <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
 <gisttijkccu6pynsdhvv3lpyxx7bxpvqbni43ybsa5axujr7qj@7feqy5fy2kgt>
 <6wdzi5lszeaycdfjjowrbsnniks35zhatavknktskslwop5fne@uv5wzotu4ri4>
 <CA+fCnZeEm+-RzqEXp1FqYJ5Gsm+mUZh5k3nq=92ZuTiqwsaWvA@mail.gmail.com>
 <qnxlqbc4cs7izjilisbjlrup4zyntjyucvfa4s6eegn72wfbkd@czthvwkdvo3v>
 <CA+fCnZdUFO0+G9HHy4oaQfEx8sm3D_ZfxdkH3y2ZojjYqTN74Q@mail.gmail.com>
 <agqtypvkcpju3gdsq7pnpabikm4mnnpy4kp5efqs2pvsz6ubsl@togxtecvtb74>
 <mjyjkyiyhbbxyksiycywgh72laozztzwxxwi3gi252uk4b6f7j@3zwpv7l7aisk>
 <CA+fCnZcDyS8FJwE6x66THExYU_t_n9cTA=9Qy3wL-RSssEb55g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcDyS8FJwE6x66THExYU_t_n9cTA=9Qy3wL-RSssEb55g@mail.gmail.com>
X-ClientProxiedBy: CWLP123CA0177.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:19b::14) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MN0PR11MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2df622-f31c-472c-8f21-08dd5b25e889
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0dyZVIxV2NhaTYvU0p2RkM5OHNtMU43MG1iemQ1OFZ4NzBEUU02ZnozRVpW?=
 =?utf-8?B?R2hIUXljN2NPbUxMbnFRU0RGOVhMK1MzcWZiT2Q5cnQyd25sUGRRMlJGMkh0?=
 =?utf-8?B?SnlkbFFQaGp5dXFCRW10S1B6UGE5eXd6c0dNV1pHSUxqUnlpUW5la0dpY0xw?=
 =?utf-8?B?b1pmTDlPbEZXTnVoS3BzOVJhYVo2Q1N2VW1oaWVic0pMTzIySGU2ZUQzWW1l?=
 =?utf-8?B?cnBuZFA3V1hpeDNNZHZXOU04U3E4R3FBN2VYeXBmVzlPWStZeWhZdTd4ZkJo?=
 =?utf-8?B?aFFWdTRMNlFWUkh1Wjh6U0VuNEdPSGQ0Qkh4ZXk4eGxTMEtIQWlEZlMyRGFW?=
 =?utf-8?B?MkJUZklLaU5sWU52TSt1Y215V0FibHd2VGxCcHVzQSs0V0psYVdTM2NlSEZn?=
 =?utf-8?B?bms3cWRPZHV5VkFEY0pMNm1DeDM1L0lKTnZYLytCenNHMFhNUWlFTzk4a2tl?=
 =?utf-8?B?aVlvMDA3RHpqREJ5a2tnakFhRHk2aWoxTnQzam82dTJGd2FqS1NBeFlRckRX?=
 =?utf-8?B?aFZSVVdCK0NwdUVZTGhKY2t3NzFtRTVJQUhoTm5MSnkxVkh5RlpRY2Ftd0J6?=
 =?utf-8?B?eUZrVjVqcW50cnpiMUp4WXVreWN2ZHQwb1NuVEhVMWdCdmNaT0kxTXllanAw?=
 =?utf-8?B?N3BvQVV4bkRVYkt0UXd6c0ZzRzJYMjAycFJYaDIwa09pUElENWtRdzJYeVFO?=
 =?utf-8?B?azE1K29XR1pTajRDYmlnTlArZ0FwaEtwNmM2dVFXYXhEazFIVUsyTmE0UVhZ?=
 =?utf-8?B?SVFiYWlzVkt3ajFvR2lsNlNPNFcrbk9NNWxXLzN3aWRtR2NIWVZYNXV0R09B?=
 =?utf-8?B?UklrdC81dVc1MWxXRGlTazUzQ0FGR09QbEREdWNTMFdMZ3ArckFkQnpGdFQ5?=
 =?utf-8?B?TzBEQk8xamZnNUpMdXlSaEtqTlN0UGNqTStuODJPSmRNZU14dVF6Q25lQ3Bi?=
 =?utf-8?B?SjlnbkdFY2p3QzRBMkVxY2FVOHdSTExIVXZ4MzN2WU13ak1lMzVWQ1dyQk9T?=
 =?utf-8?B?dEhZWDVCRHAzbFVwZ0NpTEVYRHdObWh6QkZuNDk5WUFBTVUvdW85MHdnUDd6?=
 =?utf-8?B?aU5MWUFPSWZGZTduQ2lBcndPcU9kUWlwR21mMUZ3Y1ZoRU9mSytPZmpOeTN0?=
 =?utf-8?B?eTZvbkFhQ1NnMXp5ZktSWXdOS0poWnNHcU9HMGRvTzhRYVVIWWVXRWlFeDNF?=
 =?utf-8?B?RTZicEZ1NkZGSnFrTGlRbzNjTEtwYVVWMXdBcW9KSHpuVDBCWnI1ajFtTXNV?=
 =?utf-8?B?Q1BudVVlaXJ2QnJ2SWJ6S3pRK2x4ZitoNXJ0eFBISVJGYVVrdEhmUEpNSG5U?=
 =?utf-8?B?MFFzeEZyYkJoZjlRS0lVdFdzZXNmb3NXSjE2TnBpVnhJT0NiUVgwREpwTnd1?=
 =?utf-8?B?d1l5d080Q05ZNTd6WWk4WWgrdWVYRGV2S3dab0VWbTJMNXZsdWZEZElFSm5y?=
 =?utf-8?B?dTR1Z1NJcUJPNStUZVQ1bTBwL1NOWTRFTTZjUlcvZWYwbzU1NnBwampGbS90?=
 =?utf-8?B?bTVycXJIamRya3RGTytFYkx0QmhBZ0RlZ1NYSnNjdnRidHdmZ3EvSWtoYy8w?=
 =?utf-8?B?a21TL0IvczNWTTlLeXV5S0FsbngxbjlGQ3pmdDJOeTRoSE1BNXloNjFoRWRr?=
 =?utf-8?B?VDVGU2Z1WnN2SGl2UWdnRHVjRStBUm44bk5tTzBvUjN2QUNEZWpmdUxlOHhh?=
 =?utf-8?B?Z1RnNmQwVFAxZENpNTR5ckJNdk53dkRnOHJROEtMd2l1d0tKOTQwbUNrNldq?=
 =?utf-8?B?ekFuUUdvRHI2STV0TXBTb1lGSmlOSnRwN1pOMTNsYmY5RSs4UXFlRDRxTUtM?=
 =?utf-8?B?UUpXaXdGQXJ3TWljSmx1WGFvTjNBYXQ0RWxnd2xPQ1NMc3lKS2kyVUY3Y05S?=
 =?utf-8?Q?V9Uockl1XXRcG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDUwQU13ckNvcGg5dEltOGRqeU5LTkY1TVpFamhOS1dtbUREYjlucmJHTkxS?=
 =?utf-8?B?QXo0TGFtV3FIc1RxVFVzVzVvc0FzNEJ5cUpDWExVdFQ0UkpmNnJNeS95eHRP?=
 =?utf-8?B?aVpGQzlKU0hySHk1YmdZc3ZpL1hwSUtFZlM3M25VQzhIeCtBb0RSM000TFdn?=
 =?utf-8?B?SDhKUjVubm5OZWkrZmpEVHI5eDJkamxvSDhNUjhRYUh6dlh1VDcvUlZkWjgz?=
 =?utf-8?B?blE5aE41eWM1Q0V1QjIzMjJWbFRuZWhxbi9sYjVkeXNYTHlLWVlpem5XSXJP?=
 =?utf-8?B?NXo2bTNDMWhheUxmZEF3bzRTd3JKenIwTUxUNEFWME5IcUFtZnJNYkxra1VZ?=
 =?utf-8?B?UjhpQnNGSmhZNnVxUzRKUmdYRWF0dWdqejJ1TzJYSWt3ZWhoY3JwZGtRNWZk?=
 =?utf-8?B?czF4Q01xcGNUZjZHcHpVYnBqbTZTaGhvYlNIdDJzOU9UZVZSd3N2MWVraUhz?=
 =?utf-8?B?bVhwaGdvbTJPYmhRc1hmWmNESVI0S0hXNmg2UFZ0Y2pZYnFkSzFDQ0diMW5z?=
 =?utf-8?B?eTZhcUlpOWhya0NRNjNtU2x6dTVlMFJIV0M0cWs2YlJjQ2xSSlZlc1F3L2k4?=
 =?utf-8?B?clpaVjMwZjN6aTM3RDIxS0FqWTlxdGwrajBWbnI3U1BVQ3VJR3RNTFNVbmRt?=
 =?utf-8?B?RzN0K3krblQ3MFM0d0puelZ6dUVoOTRrNVdRMkpncVRLVElTbFVFcU84cFp2?=
 =?utf-8?B?djdSL1hSVVdQUVhSUjZhSkdnVjhXSHlTaXRuckgvL1g3UVMwOU02VUl2SXVi?=
 =?utf-8?B?dVZxNjZxYTZVdVZraUZ1MjdLam0rTThNMDVld085U1NCbElxRkxMRXJkNGMr?=
 =?utf-8?B?WlBKeGRUV2pibHRFOUN3MVdoMTlNMjF0dDZzaVd4bzRRaXlOL2p3dnpmQ2xS?=
 =?utf-8?B?SmpFVkZRMlBiOVRGQzg0cC9rME1QUVJVMzhkeXlJRGlPcVlFNU5oeEpQMDEy?=
 =?utf-8?B?SWp3b0duSGdkU2RzRVVGUE0rVUZXcmNldXlwVXFiM0tYdHdiMktKckZ2UCtP?=
 =?utf-8?B?M1l2SDlFbkZlVnhxTmFpQ29nTVQxaWNjbnNFN1MwQlluS2R0RUpRZnhJdWoz?=
 =?utf-8?B?VDJNdTlGb3E4UjJkUTl6YkFUdUIxTkRUTjd4UzRyZkpJd2xoTlBCZ0s3WlRt?=
 =?utf-8?B?bUk0dW10eDcyakdDSWFIUVZYV3JhcTZCZnZ1eEttSnFpRjNPdElSNytKRXFM?=
 =?utf-8?B?d3d3MHB2anRsb2NCVS81allTQ0QxcXV4WkRjczJITjZPYS9kZlVrcEtySUxK?=
 =?utf-8?B?Y0xYYzlnYnpkVCtOaFFWQXdPTE53dEpxQ0VYYTR2RW1UdlVlWTcybFpWNmND?=
 =?utf-8?B?Wkgzd3BhSWNPNmNJUVhoMkxXMzl2ZU1DUTl2dkhJRjlacXNvbkxMQkFtK1hR?=
 =?utf-8?B?UURlUXBpRFR1U05DUWNKOHozM2VBZ25tUFZoWXdUaGw5M2xMVktObmwzMllw?=
 =?utf-8?B?UUV0SVJMdWd2NlJyRmVBaEF2RUdMS0J0YWp3bWZQTzZIYnNDdHhWekJqbFN6?=
 =?utf-8?B?ZGVyb0hHbWc5WEhXUXR3R3FiejBQWTVoeWtUd0J0Y1J6MEYxSmFlaHF1MVY0?=
 =?utf-8?B?ZmtiRlBpMTY3QVB6Q1VUVDBhZXhYTjAvM3BpN3ZUYWZiMkMza00rV3d0M0sr?=
 =?utf-8?B?MGx5WEpoQytNZkVuOS96Q1NTS3BkM2x3RFQveXFjK1pUVU9qN3RiRktvVldt?=
 =?utf-8?B?TmFQYWVRM2swQkZ5YVdIWUNDWjlCMjBzTEpFV0hrbzM4a1FPeGc2Rk5PMlBs?=
 =?utf-8?B?aWFzZFpzL0lWdFJUM3VxdVZtMlMrcEN1RVYwRjgxN0RSaDdYeDBSTzFITHU4?=
 =?utf-8?B?QjNNLzNjTVROQnFvWFdyRkFpcGFlNy9jWUxidlk5Y20zT3ZqbHVaOG9MVHRo?=
 =?utf-8?B?eEZTemxkSU1UVWtZNjFxZ0pXRm44N0hoT0xPNnlTcG5BMm9idkdYV2tnM2o3?=
 =?utf-8?B?U3lhVlZ2eDlxaEl0eHVRaUZJc3JaTVR1WlYrSi8xaEJmK25lQjBKKzFpSERS?=
 =?utf-8?B?SnBBei81eWdpaUZWVmdyN0J1eWEvQ3oxUmMvKzloN0luZm05NU5iTVNZeHRX?=
 =?utf-8?B?WTZzVE91eVp2RHJReWdyejhVcE1pbU4xNk4xQmxjdXFlS0RJTHhjd1lpMlZh?=
 =?utf-8?B?Ync2blMrTVV4ZDFJSHkreUhmcm95MHAyWTVXRUJmQVBuc1dhTm5pb2N3WnZK?=
 =?utf-8?Q?6kpPCTorYszaKVMVv6fVpYg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2df622-f31c-472c-8f21-08dd5b25e889
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:07:33.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmKwmjxZwEFw1JPnhPBbeceWTbIFdY6wj221xUQS58NA8zgu7pkqGf09OtCZ35T+1q8t8UqRtnZ+WfNerUasJSGpX9YM9gGNxJrRMH2ps0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6087
X-OriginatorOrg: intel.com

On 2025-03-01 at 01:21:52 +0100, Andrey Konovalov wrote:
>On Fri, Feb 28, 2025 at 5:13 PM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> I was applying your other comments to the series and came up with something like
>> this. What do you think?
>>
>>         /*
>>          * With the default kasan_mem_to_shadow() algorithm, all addresses
>>          * returned by the memory-to-shadow mapping (even for bogus pointers)
>>          * must be within a certain displacement from KASAN_SHADOW_OFFSET.
>>          *
>>          * For Generic KASAN the displacement is unsigned so the mapping from zero
>>          * to the last kernel address needs checking.
>>          */
>>         if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
>>                 if (addr < KASAN_SHADOW_OFFSET ||
>>                     addr >= KASAN_SHADOW_OFFSET + max_shadow_size)
>>                         return;
>>         } else {
>>                 /*
>>                  * For the tag-based mode the compiler resets tags in addresses at
>>                  * the start of kasan_mem_to_shadow(). Because of this it's not
>>                  * necessary to check a mapping of the entire address space but only
>>                  * whether a range of [0xFF00000000000000 - 0xFFFFFFFFFFFFFFFF] is a
>>                  * valid memory-to-shadow mapping. On x86, tags are located in bits
>>                  * 62:57 so the range becomes [0x7E00000000000000 - 0xFFFFFFFFFFFFFFFF].
>>                  * The check below tries to exclude invalid addresses by
>>                  * checking spaces between [0x7E00000000000000 - 0x7FFFFFFFFFFFFFFF]
>>                  * (which are positive and will overflow the memory-to-shadow
>>                  * mapping) and [0xFE00000000000000 - 0xFFFFFFFFFFFFFFFF]
>>                  */
>>                  if (addr > KASAN_SHADOW_OFFSET ||
>>                      (addr < (u64)kasan_mem_to_shadow((void *)(0xFEUL << 56)) &&
>>                      addr > (u64)kasan_mem_to_shadow((void *)(~0UL >> 1))) ||
>>                      addr < (u64)kasan_mem_to_shadow((void *)(0x7EUL << 56)))
>>                         return;
>>         }
>>
>> The comment is a bit long and has a lot of hexes but maybe it's good to leave a
>> longer explanation so no one has to dig through the mailing archives to
>> understand the logic :b
>
>Explaining the logic sounds good to me!
>
>I think your patch is close to what would look good, but I think the
>parentheses in the long if condition look suspicious.
>
>Please check the attached diff (Gmail makes it hard to inline code): I
>fixed the parentheses (if I'm right about them being wrong), made the
>checks look uniform, added an arm-specific check, and reworked the
>comments (please check if they make sense).
>
>If the diff looks good to you, let's use that.
>
>It also would be great, if you could test this: add some code that
>dereferences various bad addresses and see if the extra KASAN message
>line gets printed during the GPF.

Sure, I'll do these tests :)

For now I found my code has some issue with inline mode so I'll first try to
track down what's wrong there.

But looking at the patch you sent I'm wondering - are we treating the arithmetic
in kasan_mem_to_shadow() as unsigned? You wrote that all the ranges will
overflow but I thought we're interpreting the arithmetic as signed - so only
positive addresses will overflow and negative addresses (with bit 63 set) will
only be more negative thus not causing an overflow. That was my assumption when
writing the previous checks - we need to check below the overflown range, above
the negative (not overflown) range, and between the two.

-- 
Kind regards
Maciej Wieczór-Retman


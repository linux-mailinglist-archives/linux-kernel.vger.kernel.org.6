Return-Path: <linux-kernel+bounces-538893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA399A49E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DB7188D217
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B6271277;
	Fri, 28 Feb 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3WLXUj3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575926E140;
	Fri, 28 Feb 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759224; cv=fail; b=DC1H6qIBs5Av7Ze1Ai/PJYksVqcV8t4F1C8k/PqZz3S//2jzA39cn+Zolb0dQiERcJaujW1qsTYeMuYPUiuh/Vkam7vLiHx79JqprCOAMkyK1pdWBvlph9BeljTh/zLers6+Z+FPoTRzjIaemnVSCTsT8Ek/GShtvGN4ZVg8KFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759224; c=relaxed/simple;
	bh=WEs8kDuOwDofBDUhQ6V0nyiteoXNYmJuIOMoLqV5TXg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jGZ8DD3/zOPzxlh3kmaaOngcrOl2fNfh5RwlBUYeDtkVJGYfKnug62Yc1QcyQiq9Jdv3yBpZFJAC0MX9zuttz2sAJgM7bl29EoPFszIsaICpD2bX3wHH3NUumOFlvyyW6ea892RF7zxOUL9blgG1JuEeMZY8GxoR0GjTu5qACHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3WLXUj3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740759223; x=1772295223;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WEs8kDuOwDofBDUhQ6V0nyiteoXNYmJuIOMoLqV5TXg=;
  b=j3WLXUj3aq0vXjziozlaUZwWIQerFjq8irRShg0yLI8inl7gaHQpjSjx
   zODQ8W00mHyzTLEv65OVjROGpYdbhmbKbK4LCSLA1e5ikkTTRzNAWAZiv
   VjUqUq/MkuQNkFwxn+WG3jR6o1f3qJe+frGqMrupQgO54OBvzsnb56AuE
   5vRolPs0W4odrJk6ZsvkW5gbtMnG8S7BDVHzHpvqcKwOgbk/u5lR++AKc
   XCR03OobMM61mdx5MR0n7yBYh3N9aoCP7hxiTO06lfim1zkn+fb7zum73
   NIUFa+Sz3Nwx40A+JR4B0TfYEiabaAbDiPA934mESQZFK6GyS+udxFO4k
   w==;
X-CSE-ConnectionGUID: yFVv7dvkSOqeh9Fa3AEaNg==
X-CSE-MsgGUID: guuJFsx8S9et3vNp8d5VFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41541442"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41541442"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 08:13:42 -0800
X-CSE-ConnectionGUID: SJKw0ZkfSjCohCA9oELcTw==
X-CSE-MsgGUID: mHwZRxP3QNCknTEvS9sDAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="148176891"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 08:13:42 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 28 Feb 2025 08:13:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Feb 2025 08:13:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 08:13:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzgcBFiX9XmYVZo1ikbbLqz6EBIV/f4felpPMwGUvF9IasD5/xXbP9aTlldO7bvcuhqFUHHLs+s13nz1PhlLdbiHPvFiCAGvnjeLcbm9vmcAw4IZ8UNyfTPPmCZ6ovt7FTe1RIEWbseSlhH9Q+U2lq2EgnqlUY952lXldgLTs9/c15EmnQgXAjKUyK16EUqnBJNjWVEpWvkllQ7Xl6o8OO2Vk2620fLmS0ZUqbJLdfJGKoNlp3S8CHut3pvYXpuaYkG0MVluJ1iwo+cJh+6rBNb+/XGekXKEg2aV5i+3lZ3Sa5uzDjDBNPqyb0ShMJ1rez6L+qur/twbN72iNHFOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIzk8eoRNEcC74x8l5GMGorU6dYDvghhX7oThqSxSrs=;
 b=HG4K9729dmTbGczJmqquDy5qUO8GE/SQSS1zQOzUpLHfIfYF6yKKcBq+zHjc/aRqXo55hFwGHXiPBbdUW3v24FA85AAsinyHOXz/K3KQcixzngvzhyeEQT1CXlzpme06ojXcQFRiZT/5B1GD0fnW+4HubXzDJPKdTTjmfm+3CWvQNYoWhtK0Ac28EsG3gijiGgF1bDVGg5BssVeZv1i/8Dy+W2TvDHo0I0ehLhLtit+vJ9ugiSyuNKfTr/xjsjhruHUhActh23BISgmRb7RnK/EpeeWKkxdZ5T1DP0Vv7dVn4GO4wOTGqon17T0BV9alcvE2FMXQZPe5PL9mWPUHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 16:13:25 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 16:13:25 +0000
Date: Fri, 28 Feb 2025 17:12:49 +0100
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
Message-ID: <mjyjkyiyhbbxyksiycywgh72laozztzwxxwi3gi252uk4b6f7j@3zwpv7l7aisk>
References: <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
 <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
 <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
 <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
 <gisttijkccu6pynsdhvv3lpyxx7bxpvqbni43ybsa5axujr7qj@7feqy5fy2kgt>
 <6wdzi5lszeaycdfjjowrbsnniks35zhatavknktskslwop5fne@uv5wzotu4ri4>
 <CA+fCnZeEm+-RzqEXp1FqYJ5Gsm+mUZh5k3nq=92ZuTiqwsaWvA@mail.gmail.com>
 <qnxlqbc4cs7izjilisbjlrup4zyntjyucvfa4s6eegn72wfbkd@czthvwkdvo3v>
 <CA+fCnZdUFO0+G9HHy4oaQfEx8sm3D_ZfxdkH3y2ZojjYqTN74Q@mail.gmail.com>
 <agqtypvkcpju3gdsq7pnpabikm4mnnpy4kp5efqs2pvsz6ubsl@togxtecvtb74>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agqtypvkcpju3gdsq7pnpabikm4mnnpy4kp5efqs2pvsz6ubsl@togxtecvtb74>
X-ClientProxiedBy: DU2P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::17) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH0PR11MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 3553750b-05eb-449e-8906-08dd5812d467
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnlWZVZoRlo5Nko2T3c0Y2oxUFJnT0Z2aUJ1dUVhTVQ5TW95WVI0VWRVTmRG?=
 =?utf-8?B?cHd0VGcxZVcwQVF4MDR2d3pUVkgvdmRrQmtqTWt1U2kxYkRQd08rbWZBOEJG?=
 =?utf-8?B?S3FPZHEvZWI2SHcvS0x5TDNKc0hVaGZrUUVXcGE4Z3ZKODd6TkRVd3RBcmNq?=
 =?utf-8?B?WVBLR2ZaUkdUZ3FzMVFDUkxybkNtd2hiUTRlTVNpR1VDWW9JeHlMcUZMS2Vi?=
 =?utf-8?B?N25DTEFKK1dTQ1NrUUJxTnlJY01Rd1BGbnU1RDV3M2dGN2RNWDhUMGFOYWFQ?=
 =?utf-8?B?algwVG5ZKzdkY0Q2TWVxUzI4cU5LNVU0endReUdkN2FkWjBTZ2cxd0VBUUNn?=
 =?utf-8?B?SDVnN3ZHc1ZVV0JmYUF4SURxeDY2WVV0QlVKTFBIcnVkT1RxeW5hOEN5QjZh?=
 =?utf-8?B?d3ozVVBqeGlRbnhmOXNFL0FZSk1mdWRGMlVNRFBObXROSkRQUnovRGN3RVJu?=
 =?utf-8?B?QUNYSXFUc1l0ZXlYclhnUHNsMXMrTmtHSjMyWkZoVzZ5eW53WDB5dXFTdldy?=
 =?utf-8?B?QmRlWHZnbEtuN1plODd3SDVTaHZwRittYUVoVmYrZFIxNmo3UkZQQ1d2UjNE?=
 =?utf-8?B?MEg0eWFRbjZFRlBYUlNSYjBUSE5oVmE3Y1JudWpyZlZJelo1ODFNaWpZQTNF?=
 =?utf-8?B?U1FTTXVvdndwemVNWWRIQ3RsdGV5NExWLzEyNjd4UnFpcnNTbHpJTWZSeVdj?=
 =?utf-8?B?VEtUM3MwN2tsMVdmUEZvdkcwaDZVQy9DQy9tNXY2a2hraFRBN0VvZVEvK0tM?=
 =?utf-8?B?K2piMWd4MEU2TDcrWFFQV1JKWDh0VGhkYnczM21lRkRrRjZLeGt1bndLQ0I3?=
 =?utf-8?B?WWR3WW5wUGJHdm5RajZqeWNvdUxURHYxa3RNNlU4SHlUR29zMmpMeUw4N0hX?=
 =?utf-8?B?cWQrZlpjdHRuN2kybHRQbm55cmJ3WmxpOFBOd0UyM3N5Z2krbDhyZHBrN1Fa?=
 =?utf-8?B?SVBLcnVucXc3clY2YjhHa3RyeWpYV3Q4QWd6OExYQmJFbmZvV0hKSDFoMGl5?=
 =?utf-8?B?QmhZS0Z2UGRPT0ZIbDFabmFVUWtkQytFTmVGblJOakF4a2hWR2lCTTlGbG04?=
 =?utf-8?B?eUdndFZXMGlHUTM2Rk9JQStBZWFoZ2JGYS9mU2JnWXlBTWRwK2p4UW9kWEdF?=
 =?utf-8?B?WGdJdW1jMUxlNXNuaGFIMVdNczcrUFB3SkZ3V0tmYlpQQ3FDUXVIcVpHcGVt?=
 =?utf-8?B?bHJRRnc5blpOSDR6MlE0dlZLK01HZEx1eGJOaFZ6MXNPRGtvYmZHZXhuSG1s?=
 =?utf-8?B?cVpKdDhaVHRaZjFySUozOHBDTkRlQ0ZzWEJIMm0yUFMwY1pkU1FQNHpuZGdV?=
 =?utf-8?B?MUVmZDV4NHRHWUY0WEtJa1Bza0tGdjVEL2l3MjRUTHRVT2FZOW5SYXNzaDFN?=
 =?utf-8?B?WFFBcGtoUFM5YUxIMkpzaHVqSkFSYTBVN1pEK2s2RnRMdGdlbDh0Qm94ejdD?=
 =?utf-8?B?dmUvM0g4cWx1WXNMd0pEdmVuQVIvdXNlcnJ5MVJLRFRHTFpzekhDUXlPL0Yy?=
 =?utf-8?B?ZW40czdBK3E1bGlFV2J6dm1DazhRbStPWnRrTFdrY21ZcHZiYjRBaG9MbDB6?=
 =?utf-8?B?WEFraXZtZ3BVclYzWklXeldpWUhrRXBHa2JDNmRaQXd1c1dBdzBEaXpLcmxK?=
 =?utf-8?B?VFk2SmdBbHVKUVpxNm1BSmtxazRBMzAyKzBUQWgzUmxEMzVMVmdXUDZFemxT?=
 =?utf-8?B?N3NkT3Z4YmkxOHNjdFdzUXV0VGNQUkc5aTlpbEdTSUoxYk5NZnFXU0Z4dDI1?=
 =?utf-8?B?SXpKVnJQYkxFVXpvdzBaSXhLMGdzZHhHNXRzeUIrVXdlQ04wMnVsNzZzNDZZ?=
 =?utf-8?B?S0hVZUdlRXd0RjNYdDVneS8wSVVtNkdiMzgzWTYrbTZudGFOaEZGYXZadEVJ?=
 =?utf-8?Q?kDQBieSeSHsLN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXEvcVhwR2VTblZ2R0J0SDV1OGswRGt2R3Z1YUdGTVFnUzdpYU1lRU5BemlH?=
 =?utf-8?B?emwybzEzVU9xWDdGVlZ5Y3pORHgzRDduYnpXaWRoRHBzd295bG5Kck9OOHFh?=
 =?utf-8?B?aHpNaHlQOU9aRERpQ2M4V0Y5aTNZZjZCeU1mMXlkdnJKOFllWXE2VTRzaDVT?=
 =?utf-8?B?NHYxcVdYUEFocHp0cmlIZ1ErZmRCTWNxRk50blhGVXZHZ2MxNU9KRW1GQ0ZF?=
 =?utf-8?B?WWQxWE5ZTnd1RUNqUHFKVm9teFhVRUdvZDVTYlZGaC9hdFR3Um5zT3VJSUUw?=
 =?utf-8?B?VXhrY3VNL3ZiRDJ2NW8xb2haV3FZb1NjQjJOT09hRlhTQitQQkp2YUpRUnR5?=
 =?utf-8?B?eEh2MmQxdlRZWlhtUStXN3ZOVVJjQ3RJeUQ5bnpGZC9NOHpZZ3ZvdTdJbzJG?=
 =?utf-8?B?QmF3ZXNQUGRSVmdLSWJrTUJHbXZkeFZ5Z2wzeFJieWdQNXlabVA4UnZYMHN4?=
 =?utf-8?B?aDBBcDFiQ2RoaVJJclh6NEpUcldtcU14TFQrRURtSFpYUzFOWXEyVVQ2Tk9v?=
 =?utf-8?B?NHMrZC9TVmIzeDR2MWFocHVDWmVqNTQwME1nbGZnK0VFUVQwQmVmVndZM1Rh?=
 =?utf-8?B?UlVzamZFR01hZjRLVFJkV3E5bnQrWW1qNy9kbGFlTkxKekUyUyszcHAvQzNj?=
 =?utf-8?B?c1FEc3ZqQnhLWHN6MDhETi9HclFTRDdFdHNaUHFyRWVEY0t5OEVnUm5RYmVj?=
 =?utf-8?B?cjZBMHVqTThiN3pGNmFJUElzazFpVnlKTGMzOFNBeWlCcUJ4WlpXNnppSWFO?=
 =?utf-8?B?L1l1aGpKbTEvWmRqQzJpUFhpTll3Sy9pcTZLeDljNm03QVpZbG9Fems2ZDg5?=
 =?utf-8?B?SGQ3WkZsQlFKQjZ5R1QrSkZnNnRyb09tM0tjRWdDY1EwUGtrdGdPUldtZ0FX?=
 =?utf-8?B?WUJhZjZ5M1VCYnFGWE5pSFZ3RkZ4bDBnR2xXOWFDb3Y4aEg5OGVMRUxhWkRq?=
 =?utf-8?B?QU4raFlxbldHck1HeXZHWmJ1Y3pXZGdEbi8wQURBNThiN2pvYUt4ZzlRTEZq?=
 =?utf-8?B?OTdZdGhDS1FieXUwUTJyRlM4Z1FKZFE1WCtKL05ZakFOL3N2eGw0YWRQTFhj?=
 =?utf-8?B?a2hkVGRzK0o2dEVoL0lEYWRPQWpQbTVlRHU5TW9ZM1dhVlg1MGJhUkFnZmpY?=
 =?utf-8?B?NGNBNUVEeTNjOEFCZUY3UDNYWnJVQ3F1U0J3bE5uY1dhNUVNRlpCMGdzUXpI?=
 =?utf-8?B?a3B5M2ZoYlNxczFSMWQzRjd2R3JVUVA2RTY1WkNiWjNYZlZJRDR0OXhBeGIx?=
 =?utf-8?B?RktvcXJEL1N6UWMydHQzL2ZBaVFUcnhET1g0dmJoTm5wekFrbVNDUmJzWlgv?=
 =?utf-8?B?ZWZEOE5UemR2dGR2b0sybmpoMDhEY0lzSDRRTEZnTzIxaHNtQWNpY0V6cE9q?=
 =?utf-8?B?QVRiV05NOGtTeG5mVFNQWS9LU2Z0M3ZNRGVUazdobG10bldKOWZNdG1qS0Y2?=
 =?utf-8?B?REo1c1Y0UTJPSVY3SnJaaXpwdEdUOVNPeFdqREdiNjRYRHNEOWxPRzlHN1Nu?=
 =?utf-8?B?eGV3NC9jWk9qVEFWVWdMdUQvUjFOekR2NVdjd3R0SkVwejExNDR1YzdRRTk2?=
 =?utf-8?B?NUcyZnZFYlFiaWJQZ1pLcU41R2dQdUpHV01MREowaVBGbmZYbzVyT2JKWjFL?=
 =?utf-8?B?OEN2cHNRUTJyOUJNTWZ1dlpKY3lHRkJGV1ZuYnN0eFJPNFhudWM3eVRIS3NQ?=
 =?utf-8?B?aFgwOUx4L2hFK2UxSEI1VnFUeDdzK3RydGFweVJDQllwamtJMzVlTjROR3E3?=
 =?utf-8?B?eTBQSjViMkFnNWc0V3pBVm81WnBDN2ZTRmE3WXZ5cDdiTjA0UU9lbk45SzRH?=
 =?utf-8?B?Q2JvWmVzcDB4Wkg5ZVRDU2NqaDRnZFdlYVhSMmtqRkpUdTZ4UVA1VnQvcUVX?=
 =?utf-8?B?TWxGbGFwYU9WTnlpME94djZkMzFmVDYyV3VrYnBYaGQ4dXp0ck9FaGVYVStp?=
 =?utf-8?B?TmxNK1RkR3Y3L1BONGxmSjZ6bGQyTHpyQVgwaXgrRittY2ZjZ2FOSmpSdHB3?=
 =?utf-8?B?RW9mRTQ3TUVYaU9VT1lPVWNxMG1zajRTcHdLT0hBd3grQ1FqL1ZhVm9WUWhs?=
 =?utf-8?B?WSszTTNpNUZjS1d6SXRIaS91a0V6b29STDhDVnJTRUhVem5kMjBDRWRSaG5h?=
 =?utf-8?B?emZvWGYrNW9ZOTBvTTlBN3YrR3Z4NnEwSlNwajZxNmpha2RUL1lnY0phNlJC?=
 =?utf-8?Q?t71LtOZlgi45qP1vEAXChFg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3553750b-05eb-449e-8906-08dd5812d467
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:13:25.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcfnrH0XbhO8Iem/nEftCXnNjyZ8jcoQ79GNkaXP9nkISA1uXLzb6OQGPmjnazaer4WNJU/dPXH/Ie3vkmqox3j1VxWvVasOm+5vkKibIls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-OriginatorOrg: intel.com

On 2025-02-27 at 13:27:32 +0100, Maciej Wieczor-Retman wrote:
>On 2025-02-26 at 20:44:35 +0100, Andrey Konovalov wrote:
>>On Wed, Feb 26, 2025 at 5:43 PM Maciej Wieczor-Retman
>><maciej.wieczor-retman@intel.com> wrote:
>>
>>> >With the way the compiler works right now, for the perfectly precise
>>> >check, I think we need to check 2 ranges: [0xfe00000000000000,
>>> >0xffffffffffffffff] for when bit 63 is set (of a potentially-invalid
>>> >pointer to which memory-to-shadow mapping is to be applied) and
>>> >[0x7e00000000000000, 0x7fffffffffffffff] for when bit 63 is reset. Bit
>>> >56 ranges through [0, 1] in both cases.
>>> >
>>> >However, in these patches, you use only bits [60:57]. The compiler is
>>> >not aware of this, so it still sets bits [62:57], and we end up with
>>> >the same two ranges. But in the KASAN code, you only set bits [60:57],
>>> >and thus we can end up with 8 potential ranges (2 possible values for
>>> >each of the top 3 bits), which gets complicated. So checking only one
>>> >range that covers all of them seems to be reasonable for simplicity
>>> >even though not entirely precise. And yes, [0x1e00000000000000,
>>> >0xffffffffffffffff] looks like the what we need.
>>>
>>> Aren't the 2 ranges you mentioned in the previous paragraph still valid, no
>>> matter what bits the __tag_set() function uses? I mean bits 62:57 are still
>>> reset by the compiler so bits 62:61 still won't matter. For example addresses
>>> 0x1e00000000000000 and 0x3e00000000000000 will resolve to the same thing after
>>> the compiler is done with them right?
>>
>>Ah, yes, you're right, it's the same 2 ranges.
>>
>>I was thinking about the outline instrumentation mode, where the
>>shadow address would be calculated based on resetting only bits
>>[60:57]. But then there we have a addr_has_metadata() check in
>>kasan_check_range(), so KASAN should not try to deference a bad shadow
>>address and thus should not reach kasan_non_canonical_hook() anyway.
>
>Okay, so I guess we should do the same check for both arm64 and x86 right? (and
>risc-v in the future). Just use the wider range - in this case the 2 ranges that
>x86 needs. Then it could look something like:
>
>			// 0xffffffffffffffff maps just below the shadow offset
>	if (addr > KASAN_SHADOW_OFFSET ||
>			// and check below the most negative address
>		(addr < kasan_mem_to_shadow(0xFE << 56) &&
>			// biggest positive address that overflows so check both above it
>		addr > kasan_mem_to_shadow(~0UL >> 1)) ||
>			// smallest positive address but will overflow so check addresses below it
>		addr < kasan_mem_to_shadow(0x7E << 56))
>		return
>
>so first two lines deal with the first range, and the next two lines deal with
>the second one.
>
>Or do you want me to make this part of non_canonical_hook() arch specific for
>maximum accuracy?
>

I was applying your other comments to the series and came up with something like
this. What do you think?

	/*
	 * With the default kasan_mem_to_shadow() algorithm, all addresses
	 * returned by the memory-to-shadow mapping (even for bogus pointers)
	 * must be within a certain displacement from KASAN_SHADOW_OFFSET.
	 *
	 * For Generic KASAN the displacement is unsigned so the mapping from zero
	 * to the last kernel address needs checking.
	 */
	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
		if (addr < KASAN_SHADOW_OFFSET ||
		    addr >= KASAN_SHADOW_OFFSET + max_shadow_size)
			return;
	} else {
		/*
		 * For the tag-based mode the compiler resets tags in addresses at
		 * the start of kasan_mem_to_shadow(). Because of this it's not
		 * necessary to check a mapping of the entire address space but only
		 * whether a range of [0xFF00000000000000 - 0xFFFFFFFFFFFFFFFF] is a
		 * valid memory-to-shadow mapping. On x86, tags are located in bits
		 * 62:57 so the range becomes [0x7E00000000000000 - 0xFFFFFFFFFFFFFFFF].
		 * The check below tries to exclude invalid addresses by
		 * checking spaces between [0x7E00000000000000 - 0x7FFFFFFFFFFFFFFF]
		 * (which are positive and will overflow the memory-to-shadow
		 * mapping) and [0xFE00000000000000 - 0xFFFFFFFFFFFFFFFF]
		 */
		 if (addr > KASAN_SHADOW_OFFSET ||
		     (addr < (u64)kasan_mem_to_shadow((void *)(0xFEUL << 56)) &&
		     addr > (u64)kasan_mem_to_shadow((void *)(~0UL >> 1))) ||
		     addr < (u64)kasan_mem_to_shadow((void *)(0x7EUL << 56)))
			return;
	}

The comment is a bit long and has a lot of hexes but maybe it's good to leave a
longer explanation so no one has to dig through the mailing archives to
understand the logic :b

-- 
Kind regards
Maciej Wieczór-Retman


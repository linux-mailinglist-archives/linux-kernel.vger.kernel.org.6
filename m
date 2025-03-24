Return-Path: <linux-kernel+bounces-573524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D38A6D8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9B23A7382
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6789D25DCF1;
	Mon, 24 Mar 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFOan6+v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF929250BF1;
	Mon, 24 Mar 2025 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813455; cv=fail; b=gFr7E5sX9tZ0a8YlgwwNFHXpgsLZTpAuewwweaFASNK0CL1v9+So7EGpsPD6R+43LQWNkvjMxt+pbtHxPys47+7Q7jUKQqk7RKZkAx0QYAdSQvqT+el7xmyNnS3jUDaaXzNKbrId1jZb7oFBZqjIzHklQbyyMVOQE6J6YFNvgTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813455; c=relaxed/simple;
	bh=RxpR+FXtrWWV7JEPEdRc8AfK6+es0kJ6Ggm5JfwYhIw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RyEGngpzysH244BgZMIl2aBf5hWI9M3DOEX71EqqmhpUulG5DS3Nh+mDwRMoH+RmZ/8OmXnEUbJgjE6IIdDTTwgCPTF8orpi7hMCDyaHLv9qvv55YLP2ES5MsSH0fkcB1vL41cAdCWu2gKwahiN5e/VIWxNKRlWQcniyuHzaBPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFOan6+v; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742813454; x=1774349454;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RxpR+FXtrWWV7JEPEdRc8AfK6+es0kJ6Ggm5JfwYhIw=;
  b=aFOan6+vx223FzshusjXyUbOvmf/pWVhs6s4e98wY+USLNlKkkGqtXw4
   yiAYy03kbjfy8CMFCz0ljUAlLcz2/rl4/rxQeMjF0KoJc7Ui6jC2JwoCA
   46jVNGd5FEjtphv+OVfG4v+EC4Om8yg5p6FzIsgXAQ1jWxqQ4hL+8QUZy
   Hf2r7ixUp2RU6dm3WdvW8aJ2n9nWsUKsuvcppODkuJa1ufd0uxcN/qUlP
   YmmAI9dSGbZNgendpRXxGB2f8jb0NmD/iATS8NmyIxRIB9mYbL31P29Dk
   x6MgTxREypYXT5xD/U5z2Gh+8j0h/6VMr48+LeCTfkl4FACxylJrA94Za
   A==;
X-CSE-ConnectionGUID: KkzMVeghSgicAqClLdIatQ==
X-CSE-MsgGUID: tfxPgRAJQDiz7SVbAxad/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="66478137"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="66478137"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:50:44 -0700
X-CSE-ConnectionGUID: iPQflxZsSaKyRvT5h74+oA==
X-CSE-MsgGUID: 0akvVragTuaHAtEM0YQVTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="124465942"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:50:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 03:50:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 03:50:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 03:50:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaInJ45QGX/2BeZXJXtcvbr8wkGTJhhG02yFjIbc2dAMMHYALsm68pCfjN4QLELRSO6FLyUqVB6JtWDWL2h9qB2mbD+9tLcY8WOGOsDtiL36Qzmz1mUIDa4II8cszDYULZ06Fv6k+/0GMvpUxv6dh0c1v4gIRvWfE1ZD1EeHzvFL5PLsU7tLfrxHUXi7T5oTfWepsLypNSBet2pgfKDyzi4sWH63G9g6qHymFkJIIcKs3bG2qMtT/Krt79T1OhT8fR0/ue8I7PVFcXBkxCo6IFxDBGWD3ZXER+ZeZIHWUA0RPzPfSpZ1fV1ALWQ8nCALTw9K6hJWO/wax3qQlDL2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI1VYGmSvmcTlSj+DPq6r/dPpIaszb7mEiec6Wu0J/U=;
 b=MN69q2hXoEGOpge2yCSSMgDvA+wBIiqke1cSFzQWnPodFaN2g6wj/C4/bM8tBcvxiFPbkQHuZxiy4Go6I4EwzhR/mymhKFULOpvDL/ywCkFY5uOxSW+BuxahciAlnRfGVtI38bqS6YIwnm8ztFubZLcWprwtWGYASXZWYfxLsRRINNCfOMVTWy9FjgwzbDoOhYzUfqIEWBCNZmND86uU/tJTPYipQsDm9DluAR4hytsH+96L4wBah69u4pseTkgSu4T1HWcZstE+2kuLcGeP6C1TXULS+0v8nNNjOKjoHElTRRFhA3cPjRjP0LJAnh+KaXLqUgoHNH/FVIOTA+j1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH8PR11MB6878.namprd11.prod.outlook.com (2603:10b6:510:22a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 10:50:25 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 10:50:25 +0000
Date: Mon, 24 Mar 2025 11:50:12 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: Florian Mayer <fmayer@google.com>, Vitaly Buka <vitalybuka@google.com>,
	<kees@kernel.org>, <julian.stecklina@cyberus-technology.de>,
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
Subject: Re: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
Message-ID: <zmebaukzqlem7qrskdbqyzdsqcgpp6533vvfbo4vh3vtyeh4iu@yghuqyloverw>
References: <CA+fCnZdtJj7VcEJfsjkjr3UhmkcKS25SEPTs=dB9k3cEFvfX2g@mail.gmail.com>
 <lcbigfjrgkckybimqx6cjoogon7nwyztv2tbet62wxbkm7hsyr@nyssicid3kwb>
 <CA+fCnZcOjyFrT7HKeSEvAEW05h8dFPMJKMB=PC_11h2W6g5eMw@mail.gmail.com>
 <uov3nar7yt7p3gb76mrmtw6fjfbxm5nmurn3hl72bkz6qwsfmv@ztvxz235oggw>
 <CA+fCnZcsg13eoaDJpueZ=erWjosgLDeTrjXVaifA305qAFEYDQ@mail.gmail.com>
 <ffr673gcremzfvcmjnt5qigfjfkrgchipgungjgnzqnf6kc7y6@n4kdu7nxoaw4>
 <CA+fCnZejp4YKT0-9Ak_8kauXDg5MsTLy0CVNQzzvtP29rqQ6Bw@mail.gmail.com>
 <t5bgb7eiyfc2ufsljsrdcinaqtzsnpyyorh2tqww2x35mg6tbt@sexrvo55uxfi>
 <CA+fCnZdunJhoNgsQMm4cPyephj9L7sMq-YF9sE7ANk0e7h7d=Q@mail.gmail.com>
 <s7wo5gqrvqfiq3k5wf2pwdurtdrzixlubmck5xgrr4eoj33hi4@vjexcwpp7g4g>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s7wo5gqrvqfiq3k5wf2pwdurtdrzixlubmck5xgrr4eoj33hi4@vjexcwpp7g4g>
X-ClientProxiedBy: DUZPR01CA0340.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::13) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH8PR11MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b6dc9a-c3bd-43af-cecb-08dd6ac1aea3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|27256017;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1R1RkxiTytIQjkxeVYrZ1BsVmE2d1JlU2xTK1piTmNmZUFoeUxLUlp2cFky?=
 =?utf-8?B?L293S0NkMmxQRG5MSnp6em5SbVQxc1UrcktBaXR2aFpQZ2VqN0x4bUNDVkdy?=
 =?utf-8?B?aGhqWWVoVUVORXBBRnowTnoxNFVnaGt1eXlRR0tSb3pTQ25UeXlRb09WSml4?=
 =?utf-8?B?WUFualFucmpoaVkzU29TUzI0Rm44NVlHRVpUWFV0bStHVndxd05SaEIycW5J?=
 =?utf-8?B?Y2Z4R3V5T2QxWWRKSlk5TGM1aE9MdGdNb3FMRC9Nb3pmcTc5MFhNSEhwRFNE?=
 =?utf-8?B?NWNScHNhdTM4b3ByRUtJYmdUUWZHZDI0Nks3NWpZU29ZSEsrdE1lSmRSdjk0?=
 =?utf-8?B?VE1IeXNTcXVDUHhqUWl5NzlNZ0lnYVpsTTdIbGFYcHo0MFBWNWx3dkZiZkhX?=
 =?utf-8?B?TmhiZG1Bcmgyb2IwVjVBUFpiS29pNHB4akE0aWJLWVJuam5HbStmN1FJd0J3?=
 =?utf-8?B?ZEFaaUdVVXNwYlNXbDNLK0s2ZHBkSmk2QUMzRHp5OGswdlRDLzhQZjRFU0R6?=
 =?utf-8?B?elVHb2tRYzhUR0w5QWNvVFRCK3pHKzZ6YjJ4OGJpZk5PcTFpTHdmKzROZzdJ?=
 =?utf-8?B?MUZQQms3LzJ4K1RlblhEQmFKSEgxMGFKZy82UlBpSXorYk8vQkRyVTZhZ1Z1?=
 =?utf-8?B?ekhvZ2FhVUg4KzBxSnVRV2dmWHh2U0ZFeXZ4aFY2Z3czTHh1TTlZNy9jR01s?=
 =?utf-8?B?My9wVVBaenlLT2Rtc1hIMHJxZkoxTFFEOGZiNk9neVRSNldIeGU3Z3VUYkRm?=
 =?utf-8?B?Y0Z3cU1zbzZLOE9yR3RxbGl0WmFjdW94WHcvejZsWVhLT0lCdGx5dVZNWlpi?=
 =?utf-8?B?SVk3WS9zWC9VVGNFRFhtOVR4V3lZMjFTUFBjMjBKVU5ZQm4yaTJzeDVYODE2?=
 =?utf-8?B?S2I1SlkvdXhMSTgrdG15VkxPTVZyRDlmZG9sM3NuenAveU5TaEpiblliTXk3?=
 =?utf-8?B?T2lDTE9rYlNvMkp2bHl3MnVSOXFXMXRBQXM1bXlZZkt3RmZNeUo4LzNvRlB5?=
 =?utf-8?B?TUM4ZUhDb2lJSFFRc3VMU0N0SmdNSXA1M3UvNEVDUklWQnF3QzhtQUh6Y212?=
 =?utf-8?B?QWl5eWh0UHpNbnVjQjl4a0V4ZVVycXNJMlFMdDBmNkJEdklYTWZ3VVNEQXpW?=
 =?utf-8?B?WWVvWjE4VVAwY0tDWHZpTkY1MUZySlM3ZE9sQnhBOUNaR1pZNXU1V2hkWWtJ?=
 =?utf-8?B?bmExeldmQ253S1ZpQVRzZzBhcms1dEdHeHZHRjNLTWVvajVCRmExK0ZNNWc5?=
 =?utf-8?B?amRxSExaTHJmbUcxSXNjRiszRmxRN2VpSkl0MTViOFpxaTdOOVgyZkFLSVBk?=
 =?utf-8?B?Y3pYeDF1MTR6VlNFLy9vaHpIY21KZGZiMC81U0tGOFhva0grSnRIZEdqUGJi?=
 =?utf-8?B?cEIra2lLVDNKNXFPU2JkVjFnVVkxM1NmQis0Q1VPYU9Qa2ZhZkphZWZmU0Fi?=
 =?utf-8?B?QUd0VW5nTHBySXpUeUpBUCt4blB2aHRaRGlqbXFIYzBNbzRueXZMNGlSamN2?=
 =?utf-8?B?MFNleHJBYTc2ZVVnTnJXRzByWHVaL0hKQUlNaVoyYU15eWlra3hBSGdaUGFI?=
 =?utf-8?B?VkY0MDVZVGkzT29DQ1JqRVZHZ1puYnJTdGoweklyQmgyaHhxKzVyazNtN3VD?=
 =?utf-8?B?Ylp2UVpGQlh2REl1cTl0UHZ3YWpoeEpxOXZuNExBQk5VNVlhWmdBamt5bWRM?=
 =?utf-8?B?S1Qzb2N4eDl6b3Zvc3UrSEhFVEV6V0t2c2hXbDFXUlpYaTErblgrSEQ4eDg5?=
 =?utf-8?B?UURCYVlzOENrS1ozcTcyeEppZmdlUkxyLytaZENGRGVoSjkwOUFqcVJmdDVF?=
 =?utf-8?B?MFNYajNIY0lGdjFGejVaSnF2UnlZRUNScFd3b1dtbXVySWlucWYyN0hkVm90?=
 =?utf-8?B?TXZ3N1h4WE1QUjFYTHVySWM1dzlZK1lmWFFoL2M2Tm1yMlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWRmeHQxdUxwSHFUSlBCcDBweFFrWnZsU3dQb0pCd2I2cmIrZStqRHV6WDVW?=
 =?utf-8?B?d1RsaVMyWTEyaWt5OVRPQ3lwelpabzNBMzhzYVFNSTRsYnJQNnpaVGxIUnZO?=
 =?utf-8?B?dVhNcnJheVRtT21qZEU0dXRLMTZsQ3M2QUJWcFltUGRJWmNyN2pnb0FkOTQy?=
 =?utf-8?B?SExCWTR4K0ZKNXJVamRXcERVQkt0Zmk4NTFGUzRxaWNOMjJYMDVFUTc0cmJT?=
 =?utf-8?B?NFdMK3pnUFEzcy9oT1hFam9BT3VRN2xXMXgyRFhyemd0TGUya09JdW9zSDVE?=
 =?utf-8?B?anpMZVVYV3owVzF0RDRrZnJuKzlWTVVjU3J5dWZMY29tYWxVYWJSZE5VdDk1?=
 =?utf-8?B?SU5QSDBnK1g4SmZOYm1aTEVEcXM5RUxJdTVOSTVMYnFSTUNNVkMwREplYXFP?=
 =?utf-8?B?Sm9vd3VvclBLR3hGa3h3TnhSZEllU2xYem9DeUJHaG5BWGlSbWlKSjNFYkYr?=
 =?utf-8?B?NXdPYkk2SnptemU1K2dBTll6eUNyZzFJdElSRncxMmlJTm9xSHh1K2pwbG12?=
 =?utf-8?B?K21sVStseHBDZ2hoSWJKdERhb1JKZ1hyUzNQcWVCK2ZnUm9hM0lpOXpwN04y?=
 =?utf-8?B?RFVZTy80QXc5UFVFQllRM1Zla3lrbkxnOWx5OVFSNUM5NTNCVWZybFg2aDZp?=
 =?utf-8?B?ZzR5Zzl4YTNZYk95emdtS3ZkUE1rd0JKZTFuNWxXM1FUVnB1MlE0T20wWnY1?=
 =?utf-8?B?clNPbGZsZWpKd21PVzhldDBOK2pKeHVUeG05cjg0bThtQzVWUmp2NFNLR1lP?=
 =?utf-8?B?T1B5clkxNEV0VG9RQUU0R2dqQ1lXSm5NY2MzQmlycTZ2b09RUGw3dFNwcStj?=
 =?utf-8?B?amN1M05GUkVsRS9NTUhHTU5GL0RHeElHUUo0UWViL2VwS3l0SnBiUisvTmpu?=
 =?utf-8?B?c1N0TVF2NmJRSTd2bzZrTTNWZnZ5aUswK2ZkS3RFOGN1bW5od0RteE1WalJo?=
 =?utf-8?B?Z1ZkWXhRamNLOTVTVGFlcC81UzNnMVVNUFg1VTZldUdabWFjdTdGYzQyZUIr?=
 =?utf-8?B?dmx4V0Y0MHpjc0RkeDRRUldHMU1KRTNCdkt1N2p4bTdVSjVBN1FPdUlMa1I3?=
 =?utf-8?B?bDNiZUEvYndyTmpWUmh5aXlzSXQxY2NOK0sxM2YwSWxlUk9UQW41MCtRUHg3?=
 =?utf-8?B?SkpnZmloSFd6akNDV1ZaRVRLNjN2NGtPRDNaTG5zemg3ZHhqbk5VQmRLVm04?=
 =?utf-8?B?OWdxS083OEdPK1JQUmVYcnBYNUp0K0ZmcGFTbk5PSlBCWUtRaTFTbmJVemRB?=
 =?utf-8?B?M2NsY2JyRy9BRFFCeXk0M3ROV2NsNWc5T0xYcVllNE00SjE1ZTcydE9sc1dR?=
 =?utf-8?B?b0Q1N3owMlltcDkrUTRlZGNsSnExK0R1YUJWL0F0R1A1Q21LeGtrb1NVT0tN?=
 =?utf-8?B?SzMwU1EwR045TjZJUUx5R05aTzFXRHUyeXljd1ZNV2RoVGhvWnp5ZHZWci9I?=
 =?utf-8?B?ektuRGlNaDN6aWtJeitQTldpMCt6WEtIalVCQ052akZiSW82RWpJOFpHK0Rx?=
 =?utf-8?B?ZDZZdnVzVVg5UFRLbHlWUFFUM2ZTY295cmQyS0N5eFZIWVlYK2hwVGpBOWVH?=
 =?utf-8?B?ZHhFaTdmK0NRaVlIRnI5K0RDNU5CVm55Q1Qwek15bFlrMThsck1KcGt3OE5Q?=
 =?utf-8?B?Y1c5Z0NYaWlKbnhoeDlEYnhhTXRlZjZwdlRhZS9yVnJCL0JlTklpWDVUdEd0?=
 =?utf-8?B?eFp1YldqVm1VRlVsbFA1ZVc3Z3BHbzdGV0hjWVJYaGgrUUVxcFhXQnU0WXp3?=
 =?utf-8?B?ZE1DWS9rUjFpaGZhd2praGdHd2paWVZDRzhBZ1A4SVIrKy9aT1ZKQXVaQlVx?=
 =?utf-8?B?cVdxNEp5QTFqS2RqNzc5STkrZjY5MGRoaFNTT3RWMVhZVFVVQkl1aDRWcFlw?=
 =?utf-8?B?VUx6M2Z3NjVjYWJRVSthWVhPai93aFdtSm9vNTAwZG1rdndHTEU0cjRwbTBt?=
 =?utf-8?B?dWZtU3hlWEMrblRXYWZhUkVWV1NRZTgxUlFtb3hkV1RxOHlaNUdUZVZ0bzho?=
 =?utf-8?B?bGRyQUpOcnNGS1N4NnBXUkt1dkFINlliaEZRVFBRL1d3dGlwSzJNZUc1RWpH?=
 =?utf-8?B?elZVSGY0Vmh1NDd6ZVgvYVI2NDFTRG52dmt0N09JVVRVbjlneDcrdjMvRjlx?=
 =?utf-8?B?TEpnQTFVZVFLS2o5TE83R1N5bVhmWkR2S005OVIwSkZrT2IrZVM4UCs4bC9y?=
 =?utf-8?Q?xIyCQvl3PwkJ9zYwD42qP/s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b6dc9a-c3bd-43af-cecb-08dd6ac1aea3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 10:50:24.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db97KM7GXfWrr3kV5XF+J1QffmUo4Mg2ndYuizJAHNemrTVnGHml2EsxYDdzGEqNWoUzAvMuuchkQ1qWi3M/P+8fCpv2R5Yq7szjmV5NFqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6878
X-OriginatorOrg: intel.com

On 2025-03-24 at 11:43:27 +0100, Maciej Wieczor-Retman wrote:
>On 2025-03-21 at 21:16:12 +0100, Andrey Konovalov wrote:
>>On Fri, Mar 21, 2025 at 8:21 PM Maciej Wieczor-Retman
>><maciej.wieczor-retman@intel.com> wrote:
>>>
>>> >To account for this, let's then set hwasan-instrument-with-calls=0
>>> >when CONFIG_KASAN_INLINE is enabled. And also please add a comment
>>> >explaining why this is done.
>>>
>>> After adding this option the kernel doesn't want to boot past uncompressing :b
>>>
>>> I went into Samuel's clang PR [1] and found there might be one more LShr that
>>> needs changing into AShr [2]? But I'm not very good at clang code. Do you maybe
>>> know if anything else in the clang code could be messing things up?
>>>
>>> After changing that LShr to AShr it moves a little further and hangs on some
>>> initmem setup code. Then I thought my KASAN_SHADOW_OFFSET is an issue so I
>>> changed to 4-level paging and the offset to 0xfffffc0000000000 and it moves a
>>> little further and panics on kmem_cache_init. I'll be debugging that further but
>>> just thought I'd ask if you know about something missing from the compiler side?
>>>
>>> [1] https://github.com/llvm/llvm-project/pull/103727
>>> [2] https://github.com/SiFiveHolland/llvm-project/blob/up/hwasan-opt/llvm/lib/Transforms/Instrumentation/HWAddressSanitizer.cpp#L995
>>
>>Hm, I only recall looking at the compiler code when investigating [1].
>>But as this series points out, [1] can be considered a feature and not
>>a bug. Other than that, nothing comes to mind.
>>
>>Thanks!
>>
>>[1] https://bugzilla.kernel.org/show_bug.cgi?id=218043
>
>So I assume that if outline mode works, inline mode should be fine as far as
>kernel is concerned? If so perhaps it will be more time efficient to post v3 of
>this series (once I'm done with kasan_non_canonical_hook() edge cases and
>unpoisoning per-cpu vms[areas] with the same tag) and work on the clang side
>later / in the meantime.

Oh, I guess I also need to add a patch to handle the int3 (X86_TRAP_BP) so
kasan reports show up in inline mode.

-- 
Kind regards
Maciej Wieczór-Retman


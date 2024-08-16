Return-Path: <linux-kernel+bounces-290347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E13FF955286
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52168B20F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B861C3F23;
	Fri, 16 Aug 2024 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faZCOpHy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEF4315D;
	Fri, 16 Aug 2024 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844325; cv=fail; b=QhYLgvPvUmzfrk26mwoV8SozrUpreVlDDgMnzR/4bYDKBHwK4t9Rfisk6A0THASNxLeptIBGDICOKmvL5tJKB5q8ofKbACBiylrP28J1K9NlL1eylZPehtSS6pKaD0lCAsN9R5dfh0ARlFgofJhD+JoCYJGz2dirICWctI5ZTSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844325; c=relaxed/simple;
	bh=R9jh45/md6pyS7lPrDR5sgy3LBP25zami2aKV84u8Yc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P0Zt0g4gLDT1f7pCULPX8CFwUoO7K7KzKSj6iwkr1pYJGKMRq/7nBYA23on+r+8+AP9X7/9f7fAs/AeU1bzMDYIdqHDX6wye6MESsKmQWRpIu4WuucHYmIAk1bemc3oCjnHvespm4OfUVkE9IdKUKfEkx7HeVFIX6ojqITJ8EbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faZCOpHy; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844323; x=1755380323;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R9jh45/md6pyS7lPrDR5sgy3LBP25zami2aKV84u8Yc=;
  b=faZCOpHyirjbTMThv2zgPVZTyn23l2kItjtP6ih/NtDuKw7DDDp0eL+N
   fr34gJMEQGcwKtENN1e18JnzNJyW929qj/TQ7H0e359/3rfvIvJjCJLtY
   IoW17zvw9+7OuG3G6LUu2nJVegnrJoYkKdGUf8C/jiDqI/o9vcWdLDovM
   Zpzh4/ZgReTsCzbw9Nz59hW6wkMEN4owm5anhQ9FkDg4lO606cvk8mb99
   TomAQ+ugDttdYuLBa6nCezWPf2wT+nud7TnesZAnGP6l0kxw6aCl8ohA+
   3Qr5XndXWj+jzziUMyqzSSfNmgW0XXuVi9FO+A8CJJ8ZAEpkJyAPLRXdM
   Q==;
X-CSE-ConnectionGUID: qkmAjHOKS8S+h4mUS9BZzg==
X-CSE-MsgGUID: aaCJUnIlT9GQDVeYXvPzQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22123223"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="22123223"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:38:42 -0700
X-CSE-ConnectionGUID: 8j1H+97dQsSpFEoztfDK4Q==
X-CSE-MsgGUID: 7TKaaQXZQKynSoH3Yxqy4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="90520119"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:38:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:38:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:38:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:38:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djCcgYyFuW6cPOMXNYvHHnZdKGSsyms1E3t6BZabI52foS4sNPx52vcoJEBwIemXoa4Teux87pExLcNuu6lK6XFTZI5yESOTO9j5jX1g2ycNh0AywNtvcte4e6g8mhGdSbIw2dGGzx3NcN1t5w4AW0q6L3je3JyekUHlOmpLWUrZ3cl/gcuX4MDupnMl6DjrYvnRaCQfw5CGgEExyY0DM77djiYIOOR2WearEfgBA8dRhDXVwwjlpfuplG4BYv/lsF36D3h2HWw/kmXxl6Wr6fEciaql5PiFiPtCMo453b9Dutc6/tNDgb6Rp5PLEJdDoWBhMm1G+qVcmWnUxe3JUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5jNHStNJVYakF5+zPN32x8VZEXEFZVwsichla7Na+Y=;
 b=M+58J9hYnXFyJTUmqQWrgz2Ms8lXVfjfopbER+r5OfPol2qq68N+ZtzXY3C/2Mhci9bK+xUa9kGnAEELBd03Q07KEpd968k7XGIcO8HvMPUZeXQ/OLVb2+Hln56Vh7ybhxddbuDwfo5b7RyuIajqjRhDyABaYYvaThgTH+NCPiBqqly3rLWGMl53OKW7Qs/FtMMMaDiSXm4+ZXLELEaJfzdjsqnUklxVYvTmTnRI5DU7nnPlP4YAyrdc8yX+J0i/Ajcea6jJKn9B1LrGwtkJ0YYRGwWVhXUYxhGpaeExvL1fOnhr5R8cLq6c4zUNdA2/pRoNfkWF7UbXLXG4cNo6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 21:38:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:38:35 +0000
Message-ID: <498fead6-8b03-4a68-8fb5-15c239e9b63e@intel.com>
Date: Fri, 16 Aug 2024 14:38:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/22] x86/resctrl: Add data structures and definitions
 for ABMC assignment
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1722981659.git.babu.moger@amd.com>
 <337d3ed1eebc662dbc7e536aba49987c2396972e.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <337d3ed1eebc662dbc7e536aba49987c2396972e.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0355.namprd04.prod.outlook.com
 (2603:10b6:303:8a::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2d5a2a-196f-477f-01af-08dcbe3bc82f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUF4L1NlbDhKc2RYcys2NmdzRGlXamNDNjZ2S0RWdktSNzBkcmhHNmN1VW9L?=
 =?utf-8?B?TzZjZnFVRUdvYk9OUmVZalpOS01jYzl6UER2Q0cvazVESHVtSUdKTDlqT05q?=
 =?utf-8?B?amNPMHhLT0xBSDZtWldkcjJ6S0hUbFFVVk8xeWlvV212MFVtNjIxVkRZZUpq?=
 =?utf-8?B?TU8zNXUxQWlkTkx1S1JzcVArSVBGQ1hrZ3FOcmxEWDBoZEZDSUVwSDI4cERC?=
 =?utf-8?B?L2hBTFJQOTFuV2tnaTB0Z2UzeGZxNDZTdWVPRUdYRFlmTW43c292MjNFdWpv?=
 =?utf-8?B?NFpDMlQ0Ri9Ba1E1QnBHMmVqMFpET3IwYkY2MUpBSm9MVVlFYzVnQkRaeXlD?=
 =?utf-8?B?eGQ5ZllXOGRGNS8yTHNLMVZPR1d1RG9tS04yMlRNSWdSL3hwdkE3cGR3R1or?=
 =?utf-8?B?VWdKMm05U3NqOHRrTmdwZ1QwK3pFMFlMSzA5cmJHd09iNWkwSDR4VXRKdVlN?=
 =?utf-8?B?WE1sQ1ZxRWNHc3haOUwwamRWMVdpdjNjRHc3cmhOeUREZHkwLzJIbDhFUHVl?=
 =?utf-8?B?c0JpdXlZd3ljK2Y0d2pZdTdaZUVVbzFrRFFsNk9GSHc1amtSY2E4aUdZNmFQ?=
 =?utf-8?B?Rm93Z0gyeUN4Z0FkVlNKa2NIZ0dEeFNBTHVQN09ZOEJjNWxrTXZXdXlsMkVx?=
 =?utf-8?B?M3h0dFA1ZDMvSkJLTFQrdlU2NkJ5MkNpN1RiZjBzM3VXOTc0ZnhSdlhzbXgr?=
 =?utf-8?B?QW50R2R1NDYyaFlGZ0FkbUh0b2cyVzVuUHllMkNOMUdodWhNSWE0dktHQ293?=
 =?utf-8?B?Snl3QXVOMTRWT3IwMXlEREdEbS95b3NzYktJSlBPY3hOTm5hcm1NTFg5dmNJ?=
 =?utf-8?B?bmtiTUg4dWdIQjFxOCs1cG8xbE1DKzZXeHpLY2Z1cFFaaXFENk5OTkVsZ1g2?=
 =?utf-8?B?elIwejNHOUc4dGxrMXN0Q0RZU01VcmJQV3RVbDl0T3UxQmozbzFCMU42aFFB?=
 =?utf-8?B?UlBmQnkwNTRUQ3ZCUkZhMHM1b2tsYnpxYXR5b3JZV3A5eFpqWXBlaWw2bHVu?=
 =?utf-8?B?N2ZOSmw5UjhEUVo5OFM3bS9zM2l4c29CbUxoQjlTbnBwNWtsZTl0eXQ2dVdx?=
 =?utf-8?B?M1JXUm5PN2VpRktobkhrYW1NUWdMMGdYNTZCOFRabnJ1cWJLbmh3ajlORWx6?=
 =?utf-8?B?R1Zhc2ZPRm5FTVBWOURQaE5oL2dkWkNoR0FFUjF3bkZ4SHIvUWFEeGJUNmoz?=
 =?utf-8?B?dGxLVUZLeEprU2R0eUFtdEtleUxsalB0czVPT3Izcm5kcmtJMFJYL1pNWnVN?=
 =?utf-8?B?YVArTDVoVkJ1dlg0aVJQMnlDNTJtMjZxdVlyUzNmcGFVcDBSU3dhaFFISVBy?=
 =?utf-8?B?aFU4d21zMUg2ZHcreEZZNW9TQk1JdmZFdlBGRmU4M21vUEtWWmdNZW9aR0lR?=
 =?utf-8?B?RHYwazI2ZTEybHZoSnR4QTVHQjdYbDlxdFpYOXpGYnppUTdHUU9lWFRvMys5?=
 =?utf-8?B?aGk4RTl3aXFBd3BXMGppVjVoaXE4SU1pNFdUL1JWREczek4rR055U0ZjR1Aw?=
 =?utf-8?B?K1FiYkVFMy80UVg1Ym1vVGZCNklwd1lMV0pER3BWcHRtNGdla0dDUkV6UjBT?=
 =?utf-8?B?cUxxM1RzQ1hjdFpOUW4zaUVBUUxCeEVSNUpjekFodlF1Mkp2c1NKRHJBSmpT?=
 =?utf-8?B?U0tFbFdjWXlWdEFHdkJnNmE2WTJ0d2Ira1BHRzFDVnQ2V3F1RlB4Vm5EdHlu?=
 =?utf-8?B?aEJ4ZC9Ld1lOR2crYnI4SW5HZjU4K2RaY1JmUitJV2NRV2liZnhodUJaaEMv?=
 =?utf-8?B?enJLbWJWbUNCUzZ2UVk5NW9uZmhoZjU3YTd6cGJvS2hXVnJMQkFlZi9BVENk?=
 =?utf-8?Q?q4doY31A0+oR7o40UHZMApNAfb2wq1wxkBalw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG5VNW1QbjIvVlE5ZDNVUlB3L3U1NDhtVDJycXcwbkpsbnE5V1lpVmNWdjlq?=
 =?utf-8?B?RE81VGsrcjUrRllUYW9zYWM0SDI4VENnbCt6SHVGOG0yWXgwditsRS9aMytY?=
 =?utf-8?B?bWREL2xZRVVvcGV6RXI1OGQwRlhJZHVZN2lyNkM5dnYwNTk2OG1iTjhwbVNE?=
 =?utf-8?B?bHdVM0NiK3FyVEtRK0o3UHAwMnp0R1l6K3ZOUGt5SmtLdUpSQm5kdERqN1g3?=
 =?utf-8?B?QTJOR205b1ZKbnE2ZEFJQjBZcjBvY3RiNEsvMDk0RVdRN0xPc280NEZ6QjFD?=
 =?utf-8?B?RnRHRnZZUzNld2hLaXhldVh4WE9JN0hHSHE5YmViZ25CUDJNeDUvOU8rVmx0?=
 =?utf-8?B?TzFjRlcrYTlyUW9Odks1Q0FlK0t2anlJVkxzYWJMM0VkczBNdFFtZ1hUSTdT?=
 =?utf-8?B?bXhaNDNzaGwyQ3pJSGgxTnN2ZDFrazZpa0lIVXhaWmJ1VWNvTTZ3QmVVOHFN?=
 =?utf-8?B?c2xwZ3hrWmhudkRnNnBpMmlaTDBrRjMyQ0Rwd1phK2JuV1NuVy9YaGNRdk56?=
 =?utf-8?B?Z1NTT0YwVkxBL050UVU5TlMwd1VIaWhwZnBSYkVpSmtNckYxUUxBT1VEMy9Q?=
 =?utf-8?B?bFdvZ1haSWdWUGNGdnBLZUhJc0tQVmVIZ0crL3dyaHBRSHZTV1VVZlRpcDZP?=
 =?utf-8?B?N3E5VDhLcGFiaXN5bDRSQUY1b1NKaFc4Z2lGOU5KRlRZZ2puY3phT04vbTVt?=
 =?utf-8?B?aGZlZndzcU91dmpvV1JIcHN2Nm83cTRZSXNoRTN5bEpEbzJDaWduSEtGcE1L?=
 =?utf-8?B?OUxHd2dWMUl0bk5mZjNCUW9wWEpTNHJabFE5RUZnMk5DYUI2S2Z5TTIwT1o1?=
 =?utf-8?B?NDBEUS8rUWFYUXluMVUrWGNMVFVHUDZETmw5cFZNbFh0cUJ3cGZWQXZ4d0VB?=
 =?utf-8?B?Sy84ME8xSXZKaW1ydE1vcVFiVHBoNUhaTFN5YTZpNERlSUxTMFppMnJTeWtS?=
 =?utf-8?B?MEpYMm1id2ltdFZrMXZFempBMWw1cERUUjVUd0ZlMDJJQzU2WnRQcHREalVG?=
 =?utf-8?B?aWE0SVVpY0QvQVVzRkpYQ3NzT1cwUnBHZEczUFpCaXFRS1QreUFkNzhZNWMw?=
 =?utf-8?B?N2ljZUg3aVB2NVpFbmdwb1lIK3FtYjJYZzBoOE90Z0pQbmsxT2RKeEx4d2ZX?=
 =?utf-8?B?ZWUyR3lNQ2pCMzlQZ0RxUVExYTRqUkZpbWV5ckw0OFZRU3NXTnhZMzZzRmtw?=
 =?utf-8?B?dEVJcEI0ejl4cFBKY1g5cFdodExNalV5OVYweWlkUnQzeXVPd1EzZDF3TFRE?=
 =?utf-8?B?blZSdGZLUE5STGVyR3VRUlV2NFE3OEFwQWVOL3dnQ2F0TjB4U2l2MVpTMEpn?=
 =?utf-8?B?R09Ldm96Nm9VSWNKZFlDWTFYVCt0YVdCOEpxMEJtRjN4dkFmQ2RGYjY1aG9t?=
 =?utf-8?B?YmRHUEhQYmZUdFNyMDVxa2k5TVpMaHpKemxiYXZOVmtsL3RPUW9INm8vZXJt?=
 =?utf-8?B?QnM2UzRtNWhxbGUxaklXeHl3Wkl1QWZxZUljQUFpYlY5b2ZDcTJkZ1lpVlo3?=
 =?utf-8?B?bkkvdzhPdm1kY3RaSlcyV3NOaUR2YjhGSk1LS2tWZ1M0RnE1aGQrVkRraUth?=
 =?utf-8?B?ZVNLcFJHek51aEpGejdNQnBqanJaR2pxNXRVV2V1QUw5MTVGdE5KV2RSVDJG?=
 =?utf-8?B?bTd0OFNIVEJDK2NIOXBkUFlRK09HVVNybHh0REZWYkd1OHhiWlNBQjRwN0h0?=
 =?utf-8?B?R2Z6c3hoWCtRRmY4R2lYREFKcEQxVXRxUUQwZVVkOUxwb0YwbGJqVitDU3dX?=
 =?utf-8?B?a0hIbTVhbkoxNUcwQUdiM2ZMd1dzY1lhbHZkanZBakxpOHZ2U3RGazBKdXdB?=
 =?utf-8?B?VjRqaHZFSkpmUEsrVHlxYjVoZ2NEd2p2Ui9GTDVzWTNFVlBVVUgvR0hLdXpE?=
 =?utf-8?B?RlVVSVNsN09JYkJBVXZSMkJVLzBjTnExZklUTHBISkJPY0w2ZzFQbjIvZmhT?=
 =?utf-8?B?ZDFTTDYwRWp3ZVpwN3JYOWUvb25KQnlKZUJOUVVTdDBzUEM0bFN4ZFREcjBu?=
 =?utf-8?B?WHBjd05rS2NWbmJ2KzdzTEpZUmI2blpvMWFWV1NGUnBEMEdteWlxU2RDVWVp?=
 =?utf-8?B?bFRISnhSbmdkckN1OVY0VDB4SGxhMUEzTzNwWWh2RmtOS1RVWGdSS0RxRDlp?=
 =?utf-8?B?clNlSDk4ZmhQcXJDakNRU0pVSFYyZXBBOGZjUTF5SG5maFQvd3VNSkdwenRM?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2d5a2a-196f-477f-01af-08dcbe3bc82f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:38:35.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7E7RQD+z5FcqEyWC+Zt4zI6TD5seyjYcyaUuiXDZMOXgR1Hv06Io/fJqwRSA59iyYo5HRUMUvvbUMlVSAGvHrTpDNUoOL3n1stdGOlXkS0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

Hi Babu,

This patch now only introduces one data structure so the subject could
be made more specific.

On 8/6/24 3:00 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as the counter
> is assigned. The bandwidth events will be tracked by the hardware until
> the user changes the configuration. Each resctrl group can configure
> maximum two counters, one for total event and one for local event.
> 
> 

(extra empty line)

> The ABMC feature implements a pair of MSRs, L3_QOS_ABMC_CFG (C000_03FDh)
> and L3_QOS_ABMC_DSC (C000_3FEh). The counters are configured by writing
> to MSR L3_QOS_ABMC_CFG. Configuration is done by setting the counter id,
> bandwidth source (RMID) and bandwidth configuration supported by BMEC
> (Bandwidth Monitoring Event Configuration).
> 
> L3_QOS_ABMC_DSC is a read-only MSR. Reading L3_QOS_ABMC_DSC returns the
> configuration of the counter id specified in L3_QOS_ABMC_CFG.cntr_id
> with rmid(bw_src) and event configuration(bw_type).
> 
> Attempts to read or write these MSRs when ABMC is not enabled will result
> in a #GP(0) exception.
> 
> Introduce data structures and definitions for ABMC MSRs.
> 
> MSR L3_QOS_ABMC_CFG (0xC000_03FDh) and L3_QOS_ABMC_DSC (0xC000_03FEh)
> details.

The changelog and patch introduce L3_QOS_ABMC_DSC but I cannot see that it is
used in this series.

> =========================================================================
> Bits 	Mnemonic	Description			Access Reset
> 							Type   Value
> =========================================================================
> 63 	CfgEn 		Configuration Enable 		R/W 	0
> 
> 62 	CtrEn 		Enable/disable Tracking		R/W 	0
> 
> 61:53 	– 		Reserved 			MBZ 	0
> 
> 52:48 	CtrID 		Counter Identifier		R/W	0
> 
> 47 	IsCOS		BwSrc field is a CLOSID		R/W	0
> 			(not an RMID)
> 
> 46:44 	–		Reserved			MBZ	0
> 
> 43:32	BwSrc		Bandwidth Source		R/W	0
> 			(RMID or CLOSID)
> 
> 31:0	BwType		Bandwidth configuration		R/W	0
> 			to track for this counter
> ==========================================================================
> 
> Configuration and tracking:
> CfgEn=1,CtrEn=0 : Configure CtrID and but no tracking the events yet.
> CfgEn=1,CtrEn=1 : Configure CtrID and start tracking events.

Could you please add the above snippet noting field combinations to the
kernel-doc of the union?

> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Removed all the fs related changes.
>      Added note on CfgEn,CtrEn.
>      Removed the definitions which are not used.
>      Removed cntr_id initialization.
> 
> v5: Moved assignment flags here (path 10/19 of v4).
>      Added MON_CNTR_UNSET definition to initialize cntr_id's.
>      More details in commit log.
>      Renamed few fields in l3_qos_abmc_cfg for readability.
> 
> v4: Added more descriptions.
>      Changed the name abmc_ctr_id to ctr_id.
>      Added L3_QOS_ABMC_DSC. Used for reading the configuration.
> 
> v3: No changes.
> 
> v2: No changes.
> ---
>   arch/x86/include/asm/msr-index.h       |  2 ++
>   arch/x86/kernel/cpu/resctrl/internal.h | 26 ++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index d86469bf5d41..5b3931a59d5a 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1183,6 +1183,8 @@
>   #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>   #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>   #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
> +#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
> +#define MSR_IA32_L3_QOS_ABMC_DSC	0xc00003fe
>   
>   /* MSR_IA32_VMX_MISC bits */
>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 1021227d8c7e..af3efa35a62e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -589,6 +589,32 @@ union cpuid_0x10_x_edx {
>   	unsigned int full;
>   };
>   
> +/*
> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
> + * @bw_type		: Bandwidth configuration(supported by BMEC)
> + *			  tracked by the @cntr_id.
> + * @bw_src		: Bandwidth source (RMID or CLOSID).
> + * @reserved1		: Reserved.
> + * @is_clos		: @bw_src field is a CLOSID (not an RMID).
> + * @cntr_id		: Counter identifier.
> + * @reserved		: Reserved.
> + * @cntr_en		: Tracking enable bit.
> + * @cfg_en		: Configuration enable bit.
> + */
> +union l3_qos_abmc_cfg {
> +	struct {
> +		unsigned long	bw_type	:32,
> +				bw_src	:12,
> +				reserved1: 3,
> +				is_clos	: 1,
> +				cntr_id	: 5,
> +				reserved : 9,
> +				cntr_en	: 1,
> +				cfg_en	: 1;
> +	} split;
> +	unsigned long full;
> +};
> +

This data structure still uses tabs that seem to have goal of aligning members
but the tabs are used inconsistently and members are not lining up either.

>   void rdt_last_cmd_clear(void);
>   void rdt_last_cmd_puts(const char *s);
>   __printf(1, 2)

Reinette


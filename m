Return-Path: <linux-kernel+bounces-285831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DCD951348
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368E21C22626
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4126F2FD;
	Wed, 14 Aug 2024 03:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmodfyHh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC964AEF6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607835; cv=fail; b=GatVvPaprpWuFrLBRwmoO1uwj0dailJZNjm7pbKACefZ4/0nRZnUt1XiPR5wYQvzx/iHUMKfeRK5rsW59UO9J2mKeDv8sG3qUGvH8c9kBYMC53sDDPwUO5C8IWOqcBiweRssLj+l3TcIsiNFbT73DsZEPxlMU2AlhVBohNZoe6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607835; c=relaxed/simple;
	bh=YiKPAdD+LPJJSLxNlxPOqlj75nA5OnWJ6zSN9xpDNoA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A+r9C8+3KyexOGzLn3xkQ5W4XfmBtYH3bAowNTFo2Vz5EOEeAVvVQgXewbBTmrdr8ABKJTjGKTTBwZMWBG23mZsfkuULnVNzyU/O8v7nPKLtscatp2pAbWISiX8rxaLCsKyboL7+cfWWxPFZcQyYpJCBUEos5LjhaoX6qlpzQKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmodfyHh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723607833; x=1755143833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YiKPAdD+LPJJSLxNlxPOqlj75nA5OnWJ6zSN9xpDNoA=;
  b=NmodfyHhaa3tqCr74dXE2/vzZ6OGa9+c31o5M9CicDHnavO6GyJ/g9Ys
   0iL5nCd/PlS1K+LXR0ZPYpDHJnL5mnZwhECnmgA/9gyrrtch5vWCxgLmr
   nyYL8nawD69F8FBcErdrG4Q+ZmnEMEoIM38lL32bOBdu9WEf4pLge3P+4
   BHTd2/fGcQR5k0QkMh5+mTaSQPNOjLjbPy6cLcEEpA3ylXdFIq8L9rsrr
   DtL2WEnZe295TX1knCXVWI6mw9NS1O8WZVoYWyjfjVm26N95dCuc3Q68p
   sLRLzr8Wda4hpG1dq4/H+HSCkn+ZgzI/9qfyN+wy8NECGcaHE5FmO8+YM
   w==;
X-CSE-ConnectionGUID: +S3z1i4GSXm4+CWoh1PXYQ==
X-CSE-MsgGUID: JXj4wwByTimx8f24DKI9qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="24712532"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="24712532"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 20:57:10 -0700
X-CSE-ConnectionGUID: l9F7iEp3QGyl+N8MjWuLeg==
X-CSE-MsgGUID: 79eUWSGKR9WozgFeZWS5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63032294"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 20:57:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:57:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:57:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 20:57:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 20:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7eLZSx/O+kiC7fBW/kVXPVvg7Y4AjV+YxpINqgTvL4PWNy17hDyVoHHecuQzRw0zHLe+YXOQcWR6sY3picOPsnraZlNLEY55iHgkHh91XRTxoFU3eNOfxHH1KWzoTzMVHzcLMHXu5DQVaoNMf/A3VMWno3jWblCmA/WYHrQ959qyzF1tNAJEiADu3uQFV8M1QQjfmowVV6kp46G7/pxV7BOjN4H9d3v9y00SI9xu7slUIwcP+V1qMfy8UgkhPGHLgmGDkaZzPfVnIGCgoCjij5wBklbo0T2W/uXnH5b21EYLaENiki/xs1S2dqfMxo11yFfjIfiuz5Cyi+igpyRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyaz7xdBiW6mhdbGGO4VZxvGstoOIlpjZEdarOPpcqQ=;
 b=nxcLjUmckZOWhYXRJmzJL7BUYARJVVqS3LjhsblrvdGJRFKYt1aDYYPCa2SgRHaB7d/cI7L73DNz51E9dDIVKMC+/RHudb6w22+T5UAOiCBerVz8lcbLM++6ysIRP6eVtKSuyS6XSGpQLFI4QWmvUX/IEt2j1XxF0s7jj5fmVx+qd3nrwQGiuiAqXXmYjM9AoTjR4KotvFy8ED3OQNL4FGlwZcbITHjC4HcUjIcUMERRNc4x2NVEs5/gJrEX/Glzw24viC8M65JHbc38od8ITkTLPjnorwbNKG40ZLcW63bTnIXooOZItISj3JF1xW5eATmH9q2eXlJQ0YqqaOaHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 03:57:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 03:57:02 +0000
Message-ID: <5eea2e6a-f062-4ff4-9d11-87d8af0306dd@intel.com>
Date: Tue, 13 Aug 2024 20:56:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/39] x86/resctrl: Use schema type to determine how to
 parse schema values
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-5-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240802172853.22529-5-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 25eba36e-3008-4cf7-483e-08dcbc152795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1ArSENCdTdiK1dYemdVWWtFckpQZDZXZzUvZlluYWhydWVWMVlrT0xWNDZa?=
 =?utf-8?B?QWN0SkF0QmUzOXdRZHdhcXZsVzZLYTJOSXNPTjBHYTMra2NBME5nalpuRE8w?=
 =?utf-8?B?d2I4amZqa0pnUFZjUDNwRXNMUXRKRzArQTRXaGk1T1FPNkFxY0JrbUc3U1hG?=
 =?utf-8?B?UGluVnhDR0NTVUI1U2dyTkpDQ1JrUzZ1cXFNd2E3VEpVWnpLUUdqcjN5VmFT?=
 =?utf-8?B?QzFIYXMwZ2ZYemxYcDFkWU1mT2NEZ1Zsd1cydlBwTzl2aGlPalVqTVpXejZT?=
 =?utf-8?B?a2pRbjVjMnJGTHlWQXRtclMvWHdZbEM0VlBORDFWUE9wSnpDM2ZwOUU2M2tT?=
 =?utf-8?B?QTZrVGN1eFBzMjdKUWJhc0JZNVN2MXIyUC9ocXkyZzJGQUZ4Zmt6T0NQMVI4?=
 =?utf-8?B?VW1tTXdyM0pKbk1vTDBGRDdyQi9zRnZ6dXIrZWRhQXFtd3dxTE5mclU1aFRw?=
 =?utf-8?B?Tk5nYVlRaUgyZUlCeitXWis5U1FQV2NpT3NRTG1Fejh1dXBCZWsyMWhHRzlv?=
 =?utf-8?B?ZmVpYUc0elZXSkw5MWxUK0NmMFRUSTJEZkRRWTlyZGNlYjhiQmZkc0Ryd1Yz?=
 =?utf-8?B?d2FxTHVGZ0tDZFY4U3BCWUVvYzZzemQ1L1NGMTlWS3FhRm9jcDRLVlk3OGx3?=
 =?utf-8?B?bGhDTThqTGNkYWY3c0E2OXRXeWJwZi9yRUZ5azQzZ2dLN0xRRGQvZlpVaFJa?=
 =?utf-8?B?OGdvMFZXTThlSFh1Wm5qVVp6a1BteWsxazNNZVF5YnpjcU0zVTRlN2xyaDJs?=
 =?utf-8?B?UUhZM3R1emhielBGNkQ4VHBrRXhESnhaa1pxTkJjOUdEalNtV1d0bk9KRjRN?=
 =?utf-8?B?T05qL3pSWFVFblM1TnhGMnZnVXNWY0NSdG1HQjB2SGRsYjZiZkR6TUdBajl4?=
 =?utf-8?B?NHB0dnA0NjdVallack1kUXZPZWdPUGFmWEk3QTB4b2VodVJndDhvTDBYSXFn?=
 =?utf-8?B?NElKQzQ4MzBmejJBVXFmVjVobTlNN1dHMkZjTEJOUnlYdG1ZQXZ2RTRaWjhw?=
 =?utf-8?B?RFhGaCtUaXM3anhnRS9EZ1VWenpBdHBKdGo3MVNRbmk3NEpTTkgyU3hMUWVw?=
 =?utf-8?B?UUwzUmlvK3FUbDd4dWhWSUxQZWswY2grazJ5TDViWXhUcVZMN0ZQaHcxdEJ6?=
 =?utf-8?B?ZGxZd3AxU2RwR0hTdlVNM3NWZDMvUnRERFMvSXpJcVp6TytISVRlOExXaDZT?=
 =?utf-8?B?Y2J4RmNWVTcxc2VyRnNEWjl6dEgzR1ViWmtsSGVZeHV6VUkxNG5udkIyQXhC?=
 =?utf-8?B?VWxLU0dZK3gwZnI3VllXQ2prK2w3NlRqR3hRMnR6dndaOHBtejFrSWhhNzVx?=
 =?utf-8?B?QTlTT0pkam1xYU5wa0NBdWM1UTc5Yko3M2hjNVYwek1jck85aGlpM2xSbjMx?=
 =?utf-8?B?OXBJOTQwMkc0SktTcDV0eFErZ3dxcUJZeDNiNVFzSmpsNU9uOUMvK3Jvc2Vo?=
 =?utf-8?B?ZW8yY1NSTnpzcnNuZG03U2picG9OUXp0RnYzNTU0R2t4Q254RE10dFRrUlpL?=
 =?utf-8?B?RUxNWW5VcUJtVE5zVXhNVGlCcm00VGZSam1wRUR6RGZ6TU5kYldGU21mbDQr?=
 =?utf-8?B?cGlDb1dTRU5TMXJacjlXN2F6aE1YWWR3RTdwVEw3SVVHSU1YRXRVVVNEOS9V?=
 =?utf-8?B?eEs1eTNJc1FzN3d0SnppQ2pSbVpZYVJ5anlvam9LdHg0ck9XL3BVWTE3UjVx?=
 =?utf-8?B?TW8vUDVTU29ObTVHMGtySSt5RUxUNFBlRktUc3lKanRRNFlyR2g5WXZJbWVY?=
 =?utf-8?B?NTNxOUlRQUhqNisvMkNyT1FkcHd4UTlYdFR4TGwzVmFKWVgxZkdmOHhod0V4?=
 =?utf-8?B?VjdqUjdvTERjRjk5VXdxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDZHOTN2K3B4eUlFN2VFdFlYb3lrMU10SUc5MFRXbXo5SDgyTXNsVllKN0Yv?=
 =?utf-8?B?MlcwYTFuMVpsSTJjZUM2L3J0OE5JcXlkUjhheXRNeWdTRkZhUWV0UU80eUQ5?=
 =?utf-8?B?cDNENVlRR1hURnlhOFUvOGJ5RXFHdG1BQmtKZWZBeHR4dHlWL0ZJeVlYSzVF?=
 =?utf-8?B?V0RzTTJkRXl0ZnoxKzB3UzI2Z3ZsbHkvZzdrODBpOWRZTFZPTTNFTUd1cGY1?=
 =?utf-8?B?VEFPV1AxRUZnZThMb01GZWNWOE12TFZKVmR3Y21oYk0vakt6amtXY0pZUzVh?=
 =?utf-8?B?VlRxc2E5Rmx1WXVTMHZ3TFZQbnNmTnNTc0FqN1h0b1FFaHFPVkFVYjNwNlNN?=
 =?utf-8?B?MUlEVW5raGlJU2JjZDlaNDNpWTQzOUpUQnc1bko1STkrbytVbEkwdTlBRGRX?=
 =?utf-8?B?alo1SmhBQWJiT3p5ZGtaTjAzSzJ0dFE5Zi9UNUFWSWZCb2picm8vUjl2VUta?=
 =?utf-8?B?cUlTb01iR0ErSTlPTnhhR1ArMjlSNDJMdDVmSldOTWk5a3BueVkxRy9JS21Q?=
 =?utf-8?B?M2NyZmE4WkdsOUF2TXlqRGxHRzBZZHg0MmIyeUtuU3ltaDh5OUZtQ3JnemM1?=
 =?utf-8?B?eG9UZjMwV1RrRmdTYkpiSWpLUFpjcmZyQUdDVlM4YXVCeEs0azNTUUxoNTRj?=
 =?utf-8?B?RWhCY2RLQkxCK3duTllCKzNiR2llempFTlFGQmFnMWhpOE1DUTVsQ0QzRHUr?=
 =?utf-8?B?dW4yVUdWVTZJMWYzbEpMS1U0TnVIWllCREU4SCtrVnlXQ2FqTFBxeHZZZ24x?=
 =?utf-8?B?OVAvVVJxd0F3eFlsOFVPQzdqUCtGRXBTQUlsWGI4UzFVTlRGalQ1bG0yeW5V?=
 =?utf-8?B?cVBYc1N0Y2x4eGoyWXowdnNBeHowN2RyQlRoazdTSmNldnNPNlBLc0N1QXd5?=
 =?utf-8?B?TnhXOVlwV2w4ZENFSmZpM2w3VjFkR2NPZVdOZEhESUg4YytZdlBJY0JiUm9D?=
 =?utf-8?B?L090czNXQkgwZGNvVWNYL3Fmb0YwclRzekFqMmlEcmhDdlRReGZmZUd1SGNt?=
 =?utf-8?B?VHhaN3R4VXpzUGJJWDdheW84WlJleGZxeVRhdHNLWFRNeUo4eENlZU8yRWwr?=
 =?utf-8?B?UTBQZ0o1aitEMEphcUtQamEraDEzNDEyY2NVUHN6UUVpZ1RLclhlcWpnb3I0?=
 =?utf-8?B?Wll6aGZwRlBPYXE0N1RESzkrMGNOeCsyeHZvR21JN21nZUlZRmFYTkdTRkRT?=
 =?utf-8?B?R29raE55WHEyVTkxNlZMMm9JODczdTZVOElvNVV5OC9hNGU5WW4xT2pxRW1K?=
 =?utf-8?B?SWJDaUE1UnZway9oMVFWV3Zrd2NVdjJ2SDl6dVd5K1RuRjZBRmdZeDVNaWFo?=
 =?utf-8?B?bmRSbmdWbHhlcHBVb0hmUm0rNWUwTGhSV29wdzV6OVRMeFFNV3F3V29lOXlS?=
 =?utf-8?B?U01yYi9yb1A0ek1FYk1uQzF1K2dGYTBPcE5DZVdwSlNTc212eFU2Zzhwd0RV?=
 =?utf-8?B?Y2FnSmpQZGpTMHNCdExRR05ad1Y3WGhzNjk4eTBpb2F6aUtnNHA2YUNJZ1VC?=
 =?utf-8?B?S1ZHMmN0UEZLOFJVOGtuMzNKTy8xQ1Q2WDRITXRJY0hNSmQ1d1pGRW9BQWRh?=
 =?utf-8?B?Z1p6NlNCcjdqMkNxL3QzOWFod2xPdjdYSEZicTNKODJzUlo3TlRuaEpSOWVU?=
 =?utf-8?B?VzJwZW4vZHFmU2orRFpOK29PbE9SdW1OaEszQlQ0YmcrbXd5dHJtSGRmcWFF?=
 =?utf-8?B?eGwxa2M1a1lMWjIwRHg4K3lMR0t2V2t2RXk1ME1DTDFQbjdOcHNTekN0Q2Zv?=
 =?utf-8?B?dVZtV2ZuM1Z1VVRBOWtacGh4OWhhaUJXTUtDN09UQ1UzMTdiamF0QVZQSTdC?=
 =?utf-8?B?RVFqT3Q0NHE1SzYwRjNIK2wvcDZERm1kZWxFZUQxL3NwWDliUlRtanRnSldm?=
 =?utf-8?B?bWl6TWhRMTR2Y0drNEorN3Z2aE1ZampJWHI2dUE1SGh5WGE4VFlGbk96UDBm?=
 =?utf-8?B?a0h0VUlHbFpOZXpZcVM0WFBsMzNGUVZGQ2FjdkFBcGcrYSsvbWJXQ1UxUktL?=
 =?utf-8?B?WGhUVEhFenNkR0lKMEFsQ1FhaXZ1SVZtaCtDTHh3SkJDS3NUbE1jUUZkWW1F?=
 =?utf-8?B?c1JRelRYN3g4ODBXZjN4ZVMvdlJHYkdVUXVlSndxQmlNMjNBanluRXBvY1gw?=
 =?utf-8?B?Yk1MMDVsdzNlYzNSMk9oa0ZYemJJRFdsY2g1QWhhRDFWR1dqRk5nNVhTUFZS?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25eba36e-3008-4cf7-483e-08dcbc152795
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 03:57:02.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxULNZV9FQhTr0VIVhhMcPGaCdKzhdCtFs7aTTvjmpUqZPT0ChkB1YHrZLvW4Hr+nijPMYP+1ptFTAqqsJUxYXloRffzSVkOliXmhmMtUnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6020
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 9ca542a8e2d4..57c88e1c2adf 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -72,7 +72,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   			.mon_scope		= RESCTRL_L3_CACHE,
>   			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
>   			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
> -			.parse_ctrlval		= parse_cbm,
> +			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
>   			.format_str		= "%d=%0*x",
>   		},
>   		.msr_base		= MSR_IA32_L3_CBM_BASE,
> @@ -85,7 +85,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   			.name			= "L2",
>   			.ctrl_scope		= RESCTRL_L2_CACHE,
>   			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
> -			.parse_ctrlval		= parse_cbm,
> +			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
>   			.format_str		= "%d=%0*x",
>   		},
>   		.msr_base		= MSR_IA32_L2_CBM_BASE,
> @@ -98,7 +98,11 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   			.name			= "MB",
>   			.ctrl_scope		= RESCTRL_L3_CACHE,
>   			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
> -			.parse_ctrlval		= parse_bw,
> +			/*
> +			 * MBA schema_fmt is modified by
> +			 * __rdt_get_mem_config_amd()
> +			 */
> +			.schema_fmt		= RESCTRL_SCHEMA_PERCENTAGE,
>   			.format_str		= "%d=%*u",
>   		},
>   	},
> @@ -109,7 +113,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   			.name			= "SMBA",
>   			.ctrl_scope		= RESCTRL_L3_CACHE,
>   			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
> -			.parse_ctrlval		= parse_bw,
> +			.schema_fmt		= RESCTRL_SCHEMA_MBPS,
>   			.format_str		= "%d=%*u",
>   		},
>   	},

...

> @@ -195,6 +204,19 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>   	return 0;
>   }
>   
> +static ctrlval_parser_t *get_parser(struct rdt_resource *r)
> +{
> +	switch (r->schema_fmt) {
> +	case RESCTRL_SCHEMA_BITMAP:
> +		return &parse_cbm;
> +	case RESCTRL_SCHEMA_PERCENTAGE:
> +	case RESCTRL_SCHEMA_MBPS:
> +		return &parse_bw;
> +	}
> +
> +	return NULL;
> +}
> +
>   /*
>    * For each domain in this resource we expect to find a series of:
>    *	id=mask

...

> @@ -192,6 +191,18 @@ enum resctrl_scope {
>   	RESCTRL_L3_NODE,
>   };
>   
> +/**
> + * enum resctrl_schema_fmt - The format user-space provides for a schema.
> + * @RESCTRL_SCHEMA_BITMAP:	The schema is a bitmap in hex.
> + * @RESCTRL_SCHEMA_PERCENTAGE:	The schema is a decimal percentage value.
> + * @RESCTRL_SCHEMA_MBPS:	The schema is a decimal MBps value.
> + */
> +enum resctrl_schema_fmt {
> +	RESCTRL_SCHEMA_BITMAP,
> +	RESCTRL_SCHEMA_PERCENTAGE,
> +	RESCTRL_SCHEMA_MBPS,
> +};
> +

I believe that the choice of RESCTRL_SCHEMA_PERCENTAGE and RESCTRL_SCHEMA_MBPS has
potential for significant confusion. The closest place to where user space can enter
a MBps value (which is actually MiBps) is on Intel when resctrl is mounted with mba_MBps,
and as per above it will have the "RESCTRL_SCHEMA_PERCENTAGE" format. What is considered
here as RESCTRL_SCHEMA_MBPS also cannot really be considered as "MBPS" since it is used to
cover AMD's values that are "multiples of one eighth GB/s". Any new resource that
_actually_ uses MBPS will thus not be able to use RESCTRL_SCHEMA_MBPS.

Considering that RESCTRL_SCHEMA_PERCENTAGE and RESCTRL_SCHEMA_MBPS use the same parser,
could "RESCTRL_SCHEMA_RANGE" be more fitting? I acknowledge that it is very generic and better
ideas are welcome. A "range" does seem to be appropriate considering the later patch (x86/resctrl:
Add max_bw to struct resctrl_membw) that codes an explicit max.

Reinette


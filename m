Return-Path: <linux-kernel+bounces-364583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2299D67F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E5F285732
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEC51CACD0;
	Mon, 14 Oct 2024 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V51BePSE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10D1C82F3;
	Mon, 14 Oct 2024 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930637; cv=fail; b=ZB0aTfZPoM5/MnBqE8AVvYjoqq0z9xAsGnklVJfDY43pZlQwIgcjWV+Q0nMiwd7B+UHTkxnCQ0Ng/S5q5Xzk1Kg6yLgGGv4iNXUHwMFulqs+TU+dKAWWmSPZf4if9c0AmGolryC2xWRE+LNb2jkXyY94Ma1sYmBlM8pqHxmpdvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930637; c=relaxed/simple;
	bh=JfeRgv0+0byVZGUAtlKkKS7Eu0AqKASZjvg/GSWK6Io=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WRTR4gFlJaEAEQPXvpO6rUDKAOABAA2pN3Ld7yqwpB1NB/xUTST2CQWYwltd1ADv5+x6sJwR7inOMQdMtPcUDFIYSEhhSnqFxqcWVDU/14Upmv5WHk++nh3+wT4WnujlVjok6OErki7PbuyjDVMk52dkNUb7NiZ86BZeIuW4CxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V51BePSE; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728930635; x=1760466635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JfeRgv0+0byVZGUAtlKkKS7Eu0AqKASZjvg/GSWK6Io=;
  b=V51BePSEYEbKDqZHnh4OXtAbMQ/IQQ9M9fjR5G1j+hLfRpBO5j8FXdDU
   92PNltSz/1o88IqcsTxgz8IGN9Apd+WnTNzuz5XCdgXm/z0cEHeOmIybf
   Lnu2sOWQo2FKcGRiCeqJLHSeRaR0FSD/TmJ1y7hHEjIp3nHuZMg1zln0d
   eVSaKXJY7v9zKHSSQnNfnD3KJrYoLaY+br/cD4Z2yWZ6afiIF+FSPfcqp
   Lj12ClUf9KPKj6xZT0DWutVdz4yKpa4roUXB6iKaXZJrtKQVG9m4FpdVa
   XYY1s1g27onvQj41WVsbkDj4/YASdCZZ8nB0jV/I7+s6uJHktDMEhzFXY
   w==;
X-CSE-ConnectionGUID: Lx9n/KAXRoSBqPESZXSTNg==
X-CSE-MsgGUID: fD2YuhriTgy5ze/AkA6X+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28441230"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28441230"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 11:30:34 -0700
X-CSE-ConnectionGUID: gxlyft3nSyO3Z4jmi7ozww==
X-CSE-MsgGUID: 31lxSMjoSnqD7oQlPI/m+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77835931"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 11:30:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 11:30:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 11:30:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 11:30:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 11:30:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZeZVexvK+4VYlmru0FlvmXgCZ7AnVWTd+4QXfDYEqARw+zucSDudZXSRV5RnpuT7oUIG0bayYZ2pqfRK9TSJg7SRGwxOheYnQg204aWM/+QmcLKE04pqgLMHt2t0shk0vUg4QOILQsqyxW5yMPjm+qgzbhyi+QzE2W6yMcgEh/A54Z5fJxmkI7Y4nnWAIobOPb2TtK0EoCoDOGLbb0bm4T3hcBjNm/C44G0Q51qBsfDqm39ICTxEkKL/2bOUmSqThuZOnAMHauVqUnRLC5acFI2L/qRKJ5wsSalf97JLvPA6WGaZa94TiJQ5DKYo9e4Cma5NXJJ1Y2JbbQOPJiMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZJcWOcaeTTyk4asBkY/QkodPM6pjzB+DUSepC5VA2Y=;
 b=SoszVM+11uTfkWxLIczS4GmFiGjmV83+8/8R92IS6oYlf0NjPP66F+ZsfoPjrj5mA5Aoc5qGS74xwmmJUoGiAp+KsNxLPPF7pMLU5hpM4Szc0L1GJT8NkcQXEHjhviVuUC3nG/hM43y2GAh//soQi0Lk0C6qTXOcO/2KMs/A5neP1alExgE9BPGtJTqPU1pQr930rN1yl+6UCgjI26w82sJ7OtEn+kr3p+7EtM/8wTJRUzuGCsk2eqxbsg2vZOF66PGXWZ3KPWQ8E9OFgX8xXvVg2izJ5kWVLSE154QPwRtKzU34I2eE+XzsJfnY5NQYYPn/I0QtKXXYo8yrv0lGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 18:30:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 18:30:29 +0000
Message-ID: <7687ed8b-006d-4a92-b9d1-64fa952ede1d@intel.com>
Date: Mon, 14 Oct 2024 11:30:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: <babu.moger@amd.com>, Tony Luck <tony.luck@intel.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <ceeaf5a7-190e-4c29-89da-ba9e83693360@intel.com>
 <91f63f7b-32e8-4a67-9851-1c080fe62e23@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <91f63f7b-32e8-4a67-9851-1c080fe62e23@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:303:b7::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: af26d89e-5de3-4971-975c-08dcec7e47cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmJjZUdxSlF6V1FIeG1ENGxhQW00Y05jQWgwL0gwd0VOcmY2Y1A3bGxJRjAv?=
 =?utf-8?B?RE5yWFFQc0dQbmdQaTErWjNrMEpKU0dFWm52UnNRc0R6UlVLdWY4clpEc0g0?=
 =?utf-8?B?R2xCbXJlSmR6Ym1vU3hOY29tdDd2UFEwa3Z3QlJreGpLSEVsS0pQVkhrVC8x?=
 =?utf-8?B?U3ozZVhVc0hxVnV6d3BIcG9wMms4NW9IcEgyYzY5WUVtMFU3NUNkNXhzZWNV?=
 =?utf-8?B?blAzMXJidC9IQU5uQTdMY3J2bEdjYWNJSnZTVDEyd0hqZ09MQ2FwbTdTRll5?=
 =?utf-8?B?Skd5ZkFzL2dwdkZhUFdVNnUwNzVrd3I3d3R5dG9KS3pqaW5WaHQ3Y2w3ZjVI?=
 =?utf-8?B?TitnbEJrbUttdDlYSytpdHlpS0dBTnViQmRoSXJOQWJCMndhb28yOWhVUlJ5?=
 =?utf-8?B?TStHZ3RTa3QydDN5RmF4WHpkL3hJSUkwZVpBRFN0NERVSXNaS2tteE85Rk04?=
 =?utf-8?B?MFk4QWVEQWhlcCthN3Z3UzlPaWZwNEpVbVdNL0F2b1Boc1c2SzBlbk82Y1NI?=
 =?utf-8?B?VGZiMmF6SjM2MmJHZWI1MkFqOU9qSVhXd2R1ck5NMWlzdnRPQ0t4alhnZUwv?=
 =?utf-8?B?akowNUZwZ0RpOUNBMGFycTM4Rkl1YlJGM3RVM0NsN2daUFkzTytDeEU1V3ZJ?=
 =?utf-8?B?dm9tbW5ORGpUcmRoM0pCSXl5NTAycHdWSSs3WGNPdklUU2N3WlFna0xJNDhm?=
 =?utf-8?B?SGp1Q3hQRXpLaUc0d2k0R3g1VVVjYlNYWjNESy9CWDZnM1l1eWJ4aHBwbk9E?=
 =?utf-8?B?VmNYbGo5M0FmUjF5S2VEcDdhaE1MQ2Zpd0pBTFR3cko3TkZBT08rNWp3U3Jj?=
 =?utf-8?B?TDNGalVxclZoUWVVdld2T0xIYWlXSzIxbm4rNHEwb2dUczBhd3hSa1dmditX?=
 =?utf-8?B?eEs2MS83alB3SEM0ZnVxb0xaTW5uc1oxNElhZnY4T0h5Zy9nbyt4U0dWMDVJ?=
 =?utf-8?B?QnJ6YjNuSmhibmdHRnl4S05HS3lUZkE4MjFjQmExYzY5ektsbkVZNVR0eXMw?=
 =?utf-8?B?SzhURWxpaUJhb2VoMkFqaVg4UzI2elkyT3I0VnFaMi9xd3VpWGVlVEMzVThG?=
 =?utf-8?B?Q3hrRS9yREo2L1BRZjd5WVhZM2VrUHZhZmFIYVVUb0JIMG9pbmZ4VHpUalY3?=
 =?utf-8?B?VVFMUEdJaE1nb3NNb3l6TVcydTdXcm9jV1RmMDROZFo1MWFmcUhjSkJINGVG?=
 =?utf-8?B?UVo2MzFCYTMraTZ0aGJNWEpPb3FDT3grM3RZcEZkdWl3dUJnTWVMYjhtVjlH?=
 =?utf-8?B?V2gxdi8zMTV6SE5aTHRmYU5TeC9ZbmcwTGh3Rk9JczBZYWg3a0tudUNXTDA2?=
 =?utf-8?B?aHptWlN0aFFmN1p1bjJweE14d0IrMU84RUJxczlvc3lodklKZkNNOEVkb0p1?=
 =?utf-8?B?d1BPWE8wRjlqcDBEZHJpSm5yRWZKZHN5MmVNcVVuZkNCc3JLWFhBbWNHc0pu?=
 =?utf-8?B?QnJjYmlRNHV1dmZLMitKbWg2V04zSjhnNitrTG1wT3M1cTE4R3hkSUZsaVJD?=
 =?utf-8?B?UjNXTXg2UHFZU1pYSzVwRkU4QVNtcENVWUgzWEdMYkpIR2phempFS3UwcTVo?=
 =?utf-8?B?Y2NMOEprWFljL2VLRmdpQWxrR0VmS1FGQm5GUHp4eEZZSm9wRmNBekhCVTV1?=
 =?utf-8?B?QVFTdU4zSTBsYm1pSTJtRlh2ekZpZ1FqVG9ualdVR1hJWGdYSFBkUkNSVjRi?=
 =?utf-8?B?Smd4cUNhN3U4VExWbXlITFcwbjNFUmwzdmNBR05YeTdEMDZlWEFjQ2hRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJWMTBPb1BRRjVhZHpTamsrWENUZGhiN2NVaUZrVUR3TTd2eEU4RTdOcS8v?=
 =?utf-8?B?MVlIVTM1OWxYUkdQNmpULzBuOFRIdXh6QXU5aUJtZkwrMDhycHFhWFIvY2My?=
 =?utf-8?B?cElEUWtLOW9lSEVYdmRocFdpTDdCSEJiQlB5SXBKekErc1hLd2c5cHBITzNQ?=
 =?utf-8?B?VEtITEVUdGZoOVovSVpxNzBxQ3ZOK25hVW9oZm5SY1BDWVFFNXJ2VmdSWEIw?=
 =?utf-8?B?RjNrZWhRNW03NnU3a0FsREdqazFRdkRzeDF0R1Q0RnJxR2l1TzZKdHhkK1ZX?=
 =?utf-8?B?bmdOeGg0Q2ZKdE5POHVUOWtxZU51STlFR2dQMXo0cFgyMExkMzFNMmxOS0d3?=
 =?utf-8?B?bUlWZjVsdmFPTlpVS0V1bSt3ZzNVTW9xMlBIK2hCajhYbnlRNmNxaEluR1Zy?=
 =?utf-8?B?MzI1dFBBQkR0ejB1Vk5DOGlGQis4VVMzNjl4WFFTSENGRTdYLzlJQmlQbi9z?=
 =?utf-8?B?dnJuL2FYeVNoQVcwamxVSDdDWEc3RC8rcmRUaVVFbSthZGZ4QnFlQy92QnFz?=
 =?utf-8?B?VEtFTzBBZTVJZDZkL3lBb3k3SlV0YUUzN1ZpekxsWUV3R21XREs3bGJNemx5?=
 =?utf-8?B?QXM0cFowbUdtR0ZhcG9KcUVRa2FOejZJY0ZxeVlnRUdPUnUrMVFhZTM0S3py?=
 =?utf-8?B?RmRNOEJNemxvOEZkQklRajNsRDdXUDd6VWsvNStHTlR1cGYzb0puYkxRQ09z?=
 =?utf-8?B?Q1ZYRG8wRGxHU2FpelorWkVGMGk3WkRyaUYwUFVxWlZnbk1yR2t5VXprVDNk?=
 =?utf-8?B?Q0JCY1NjbmsrV2lpNzhNb1o1YXZUcGc1d0pKdnMzSHkrOXFsaDdIYW0wMTlX?=
 =?utf-8?B?dDZRd2Zsck5UTU5TZGF2RWUrejFWSFY0ZVRUdDl3WVdGTjRoU3ZXRW1pMXRn?=
 =?utf-8?B?M05yMS9XZ1FFYVZyaGovaG9RdHB6cmxwbnA2SWQzVTNORnBidkFUb3lpdWI5?=
 =?utf-8?B?S0FxaHNyaExaV2wxekYxUnJiM1J2UkZVUjdVVWNqK2V1aEQxaTZzRlExRW8r?=
 =?utf-8?B?Q2VjdGZ6SlQ0VFZ1cDVWWFhWZWlxMGttZFlkWE9WcGFrVGZLdjA3SThCYWI2?=
 =?utf-8?B?MCsvbXFJTXAyS0pIOUQ2UG9laGFuTXhOcnAydFF1Y3g5My90NFlobjdyOW54?=
 =?utf-8?B?OEtOK21PWFZlaGpheXJsT3JsQ0hXbVlpVWY2a1FrL2JkUkZGa0dpTkVJbEMy?=
 =?utf-8?B?bHpraUNmazZjdzM0YTcreE9SR3hseTQ0MTlTRFVHUlRrdDgwbVdSSDFzNWdS?=
 =?utf-8?B?WTdDNkh2WVpqNVZGclZtbVJEKy91TmpLVTRuUUNkSTluL0tvUXVmYWxuOExl?=
 =?utf-8?B?NENYeTEzNGpSVGthejZ2UWFsVkVPVUk3ckk2QzUzSW8rZXJlZjdISzdZRXBZ?=
 =?utf-8?B?YlFEZzN3ek1kQXF3MzBuTXA2YXZhTFJ6b21mdkNhUUZpQ0tLTDZOVGpHb050?=
 =?utf-8?B?TEF3dFBRdHhnTXJNdzJHQzRvaEIrK21VSVVENXhYcU9UVnZKOUlSUjBIZ3h3?=
 =?utf-8?B?bldqaENCOU5iZEQ3UVhkN1FmQnJrQUpQVHJpWWloVEJWM3VpQmw5aFlmSXhn?=
 =?utf-8?B?elA2UHk2VmxqWVVGdDJPeWhLQndLMnlHVU1oRXVqNEN5S2ZIM1BEait2QUo4?=
 =?utf-8?B?QVdIU3ZlMnJ5b3pKZkFGdE1BWEZ4SElaK2w1UzVoZ2NQc2pVRHVQZkk1RWxY?=
 =?utf-8?B?QXlZOE1oODN2ZzM1N2FtVEtKbVp4SVA0M2JocVdEZFRjcitoaDFvYVRrLzZG?=
 =?utf-8?B?a3g5SVNtWmlWdHp4SCsyMDZvd0xackNIRnEvRStuVEdFOFNQZ3hPSlZDZ043?=
 =?utf-8?B?RkdRQmRSdElBQzlkdE5FVlc5VEl0UytMOXpqZW8zTnl3dGkvSVkveVRPejBm?=
 =?utf-8?B?eTBKTTcrU1JQdjI5cXg4d0ErUFBQS3NPZ3JxMi9jaytscFFyVFlVY0Ezd2p5?=
 =?utf-8?B?dDN0NDdGempIYktCTHgwTVNGVDlDYlVDRHhtZ3EzTzdMRjRTV0hjeHgyYmlS?=
 =?utf-8?B?dFlLdTdoUHVSYjNsS1FJMTg3dm5oRGpCTDNsZzRDUnlxMVZXOUIwekVFVGRn?=
 =?utf-8?B?S01XejFmRGQybVBZTkFnZkkzRDRCZWFZSithUzZtY1BjaW5iWXY5S0VQdEtO?=
 =?utf-8?B?aWY5Y1JpR210WDEyNG5VZkZJOTl4eEd5aEhBOVEyTkU3Y3pSWmk2dHNyS0pV?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af26d89e-5de3-4971-975c-08dcec7e47cf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 18:30:29.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDpfZXYpeLDWyJ0+c30V5ZdWzcagLVqWK6z0jBlaxaQpHTzslVqYrHFt8Sb7gLHYpFSWWnYr3pYVSF+uCKIw5rc6jGFWYM6rgoNSsUEzwcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
X-OriginatorOrg: intel.com

Hi Babu,

On 10/14/24 10:46 AM, Moger, Babu wrote:
> On 10/14/24 11:25, Reinette Chatre wrote:
>> On 10/10/24 8:12 AM, Moger, Babu wrote:
>>>
>>> All good points. How about this text:
>>>
>>> "num_mbm_cntrs":
>>> The number of monitoring counters available for assignment when the
>>> architecture supports mbm_cntr_assign mode.
>>>
>>> Resctrl subsystem provides the interface to count maximum of two memory
>>
>> subsystem -> filesystem
> 
> Sure.
>>
>>> bandwidth events per group, from a combination of available total and
>>
>> Is this "from a combination of ..." snippet intended to hint at BMEC?
> 
> No. We support 2 MBM events right now. That is why I added combination of
> total and local. I can remove that text.
> 
>>
>>> local events. Keeping the current interface, users can enable a maximum of
>>
>> What is meant by "Keeping the current interface"? Which interface? What will
>> "current" mean when a user reads this documentation?
> 
> I meant not to change any interface to support mbm_cntrl_assign feature.
> 
>>
>>> 2 counters per group. User will also have the option to enable only one
>>
>> "User will also have" is talking about the future. When will this be the case?
> 
> Again.. will have change the text here.
> 
>>
>>> counter to the group to maximize the number of groups monitored.
>>>
>>>
>>
>> I think that we need to be careful when making this documentation so specific
>> to the ABMC implementation. We already know that "soft-ABMC" is coming and
>> Peter already shared [1] that with software assignment it will not be possible
>> to assign counters to individual events. 
>>
>> The goal of this work is to create a generic interface and this is the documentation
>> for it. If this documentation is created to be specific to the first implementation
>> it will make it difficult to use this same interface to support other
>> implementations.
>>
> 
> Agree.
> 
> How about this?
> 
> 
> "num_mbm_cntrs":
> The number of monitoring counters available for assignment when the
> architecture supports mbm_cntr_assign mode.
> 
> The resctrl filesystem allows user track up to two memory bandwidth events
> per group, using a mix of total and local events. Users can enable up to 2

"a mix of" remains unclear to me since there are only two options. I think we
can be specific here.

> counters per group. There's also an option to enable just one counter per
> group, which allows monitoring more groups.
> 

How about below for the second paragraph:

	The resctrl filesystem supports tracking up to two memory bandwidth
	events per monitoring group: mbm_total_bytes and/or mbm_local_bytes.
	Up to two counters can be assigned per monitoring group, one for each
	memory bandwidth event. More monitoring groups can be tracked by
	assigning one counter per monitoring group. However, doing so limits
	memory bandwidth tracking to a single memory bandwidth event per
	monitoring group.
 
Reinette


Return-Path: <linux-kernel+bounces-379039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DA49AD8E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D1E1F22C17
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A117BD3;
	Thu, 24 Oct 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWSfPs5X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A317EAF9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729084; cv=fail; b=nlxkSlboMixaJC1tJ/hKB6IXnFPINLLU7HD/KXv6RG97HGy0xpnJ0IHD8KmHQJT763LwQBT5g7Wrt/hbvi7PZRH5TiSmNWxcV0wniTVJxxVhnSdAk4Th7iTq5G4J0JatIZUVRtmf/9EwTW+oiiNZSqzHnH2Sht+2oCwT31NFWhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729084; c=relaxed/simple;
	bh=XRcSKgj/8JA95efsHiu8ZJyhkx8yor2qo8xaxTDCRX8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VCkxBxWVBWRWDSMv+1FxkzFMiqHO/DLB3AJ9igVfK9588zBSDgP/xVG3senDVFUkJId1sUH5tmnylbA8uT0tMLoKH9olr6SYWI4Eovtu9vQvhTaUFRTlJtA0GHyplFOGGNFyegkkKv7DR/I4vwFlkVbcG+UTXxDGS8jMe5l088c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWSfPs5X; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729729083; x=1761265083;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XRcSKgj/8JA95efsHiu8ZJyhkx8yor2qo8xaxTDCRX8=;
  b=XWSfPs5XK385ukcqt8rqKKBY9weUSyTeO4DE/weBV/z9lPXX9Qbl2Y4/
   JhT9FlAY3AL38DCIKBrC6ZMOLe2g8MUbSdj/CqSTrNQ/ddz2RA5vpU74I
   3buWFAspA4dEPXWinU0r868XQt2uyH4Beo70c9jFoinEP1zszP7zqWA3s
   F++Of/1PVsymHSDZy2Joma0KMyOrJ/E4ghGt8GcVi8m35k/AH76gsvY9R
   AsR+Sb2PLPwZ0WWvAekWAiB3fvui3OJegP/lzIBxIoUoqVT0gUT0ejX9v
   kbI2zhN8KyF/CVEdMw9GRw4xIe/MHFL7me8vghqwQL1KmlGxJIdzXSO0h
   Q==;
X-CSE-ConnectionGUID: MNlWFpPdRCGPzxNUbga/4A==
X-CSE-MsgGUID: x8GftFqNQSKci5tFQjykjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28804774"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="28804774"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 17:18:02 -0700
X-CSE-ConnectionGUID: 8IFR5lfdSUS33TK+ZA/aDg==
X-CSE-MsgGUID: Y2QeCofTR8yEnjKH9gYxbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80528561"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 17:18:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 17:18:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 17:18:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 17:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai8hJuIVHEynLGFdxTuQlGHw4W9LPQ7EZxNZ0/I6AabzyWzQcreUR7K88f3zjQlYaBJoWct49e0GoHEYvqFWWxBe++ReZ0ZDasmYWlGloBcmm2IJMAIhcPFXI7XNZV40unkbDSA3Gszox5yY3X/M1Nig3XZsJ+kdt+5ua6VoUNBW6V3AzoaG+cGhddXyHOUyBHXFMeASK/fUkv3qfLu6P9yMjlvtdrfPehTbof+MvqJddw9CII/Zwh0Re30VFJyPHngcDejqz3K3N0n8cXeTPKs+p01yCoc6mSpDSGziJAha+mS/OiaOZ+hRf94/T7hI75O3bstKJgImnjJhk4lWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/keVfrGHM3VtiPQeXMQl8jnWvzm0Le2bKsrj81Yd8NU=;
 b=EgkbLvmtN+QKMWPIRjL3gHxylESAC+ZiFxlmI6D5+6qoWvwNOWmQ+QOC3Q2TifqPauqczJgUe+KLEhWreLH0SXsWM1mVns4rtjDptyIldCqdVKsYhQ1mMG3iCjYJd2UVz2VCmC/mFvZuL6+gxnb6SwU+whnicV3/5UoplO12TZ8Dvf9BWcDmvFmCZDFtgiBd9BD4gfoqVrH3J2X8i5IhZ6fRgkpURh0UpXei9eVH3zrLc2uO7lwuaERRmHvLvDC9t4glJJMH6+X06gW2Hd2c1QibAemHRD/c0VwYFG1O626TYMhqmm486aUmZStFGmWuVjY5W1tE5XIHbQOMT/QFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 00:17:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 00:17:57 +0000
Message-ID: <a009c748-dff6-45ae-8a38-fef66561af22@intel.com>
Date: Wed, 23 Oct 2024 17:17:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 40/40] x86/resctrl: Add python script to move resctrl
 code to /fs/resctrl
To: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, Fenghua Yu
	<fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-41-james.morse@arm.com>
 <ZwW7cWgXJmfW8AQP@agluck-desk3.sc.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ZwW7cWgXJmfW8AQP@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 36477a4a-f9d9-4e14-088f-08dcf3c15006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG1jSzZJWHBIN3JFcER5UlNnbXNBcVRQSXZuY2pjbFJ3V21qdHdoZStnS2JG?=
 =?utf-8?B?STJMVDY2cjYwMENCeExzZ29yYmFJam9nVFhWYzMvK0hGZ1c5bE5OSmg3Q3dB?=
 =?utf-8?B?a2gyN3R4VkFITURiT29SVy9mclU4TktDemdVMzRDS0J2anhCUjlpOXBzUVpQ?=
 =?utf-8?B?THFKd1B4eE9EQVM4bUVOaTFINjRibVBaMjVUNk5SaTdPU0JhakY5LzlPRkdq?=
 =?utf-8?B?WDZ5U0tQbll4TklPejhWYTk4dkJnYUliY3Y3SWd3SjkwY2N1dTlwaFhXTElO?=
 =?utf-8?B?cDdHN3FVcThYWjhOaklJWGZZM2JLS3Myd0hjTVpVZGhKc3FaMG1Fb2s2MHlm?=
 =?utf-8?B?OXArblJFV2lEZEpETFRFdFM2VW56OC9mbUxJMWJqSUkrWnU5OGIxNnMwQU9o?=
 =?utf-8?B?azFKcWJ3UHNsWVZ3eGZXWVlSamN4WUt4eVNZYll0cjZpOFI3WGRMWEdmS1Vt?=
 =?utf-8?B?Q3FNZnEzVXVET2dmcFpnZWZ1NlJJL2UzTVc0bzZsSTZWQTQ0RWRpL01YY1ZK?=
 =?utf-8?B?aURqQ0l5MERzREtJNmFHcVBpVEkxYVFsWFJqcnc0WXpzQy9sTHZKOU1qK0FF?=
 =?utf-8?B?Njg3aE82S3BML0FUUUdRN3lFVk1hTlovRGpLUlFNWEJkbzU1WlFFdnRWUzVr?=
 =?utf-8?B?dFV0V0g3VTkvSm9ZZklEaDdESmpKVDJpaWJ3dGRpZFN2eitUNUtjeG5tOUhJ?=
 =?utf-8?B?YWFpbVhkeHpZSlVUTTNXeDd5eFVUL0c4WjV0UGlmeTBzRThROEhtZ1d4M1ND?=
 =?utf-8?B?MDZvTXVWeURXWWttYWp3cXNLSlA1QzkyUXdxbC9nR1hOSUNPY2RWY0QwMndN?=
 =?utf-8?B?RTFYUVlJMXpIRitkcmgwSStDbk1weFJVbWJnYlV6RUVudWtOeVN4ZmdxSFJx?=
 =?utf-8?B?TFhjMjZBT3R6V2lZeU5kR2x4c2lhL1RnR2xxVEFHTWRrZk5WS1lDWk90bXk1?=
 =?utf-8?B?NGowWjRmeDZvZityQ0JZdWcxS1BwUjAwUlFENjMxOWRaSjA5cnBQUUpLcWgy?=
 =?utf-8?B?dVNTaDVkL3kxUk5tbDFmcHg3eXM3QW5zNkRqbUJaY0t6TUdrUzRRT0dpU2R6?=
 =?utf-8?B?MCt4N3lLdVdKaE8yWHhHM2NCeVJLRnVmaGVIREJUUElPaC9LVnRVandHb1N6?=
 =?utf-8?B?SGFJZmdQN1lBVlAvc3VGMko4Uy9FUkkxN0owMFlpY3pub1NGd25pQy9PMEI3?=
 =?utf-8?B?MTdQaTZNbTMxanp4ek45QTUxZHJzMmprRUJZVDZKTHBsQzhPR2lnYkdueTBt?=
 =?utf-8?B?aTVFLzQ4eGwxVUEyRlZXZ2ljTnQ0RGdSVm5maVVZdU92eTJvMlZ2Z2VXOXIw?=
 =?utf-8?B?WXF3MmprUkpTZmxsT1JjNDQ5c0tGZmhOTjlmV2RodkJpbGZKNGxwTzROTWlX?=
 =?utf-8?B?WnhaUFBLL0p3bDJLdG41azIzVE9mRE9rYTZEaHEzRHFuMWxSR04waWNYejFP?=
 =?utf-8?B?NEpzdUhIYUlWK3Q0djF3cE91eDdtck96QmM3M05QN0MwQzUxZytMYkNTcVpK?=
 =?utf-8?B?bWxMY05iVXJGTzFEN1BubmszZmRjK1BSUUhoWk9qc1dNZW9JRCtXWHdHSyt5?=
 =?utf-8?B?dlRTZjg3NkgwLytXVWRHVTlnRkRtMHp1Q3FXcHhMTUVPMWVpOFRtaWsweTlB?=
 =?utf-8?B?TXlFZkRzY1FXYWcrNGt1Z2N0c0RaOU9HRDNsOEJBYThuemxKOXhPbm9JcXl6?=
 =?utf-8?B?bHY0QTFISnJRa2xqSDQzUWo4bTVZbm5sOTBxM1N0T3Q1eTU3L29rbHlGVzJu?=
 =?utf-8?Q?nD7EkFjtg3Ck1+ixY250lqz5jAn3oma0mrMxmYt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhSd3dHTDdyOWlQZEVLWEZVdjNsOUg5Z3Noc1B1Mkt5YitWTTE5MjluZUNx?=
 =?utf-8?B?ZVcyWVkyV3BtUkttK0QwSzBNZ1U4STRYZ0p6WjJBZ3ErbHJQTGFjSzBpN0Mv?=
 =?utf-8?B?bUE4Q01JbWp0OWFkaEVKalk1emNVR0UyYjkwN0NZY0F3ZGl2YWtEdzRmb3JG?=
 =?utf-8?B?RTFQYUo4RjhpVThVWTRvODdOWHp1ekQ2WFFWVGhHbmpzcnQ4LzNjNG5CWjh4?=
 =?utf-8?B?em9qSENMbitGajY2b0hJbWg4Q3Z0dVJDSVVQREtxYWQ4ZmtoRDYxYzdBaXRU?=
 =?utf-8?B?OGFtOUxGdndHUHZCZDlNWWFsMmhWc2ltSXdqa0VwY2dBemQ0MlY0TnlQUUo5?=
 =?utf-8?B?NUtHRUpGZHIzUHhIUmJ2YnhUb25FQ2VYTnA4emZMd0xncHNMVkJlMGZkUzhq?=
 =?utf-8?B?VkxkZG0raUdkeTdJRzFiaStUQzBzdnZPbllYVnhhZmFpSzh6U0FVY0laNUF0?=
 =?utf-8?B?amJrMjd4RU5ZR1lUeXJGNHdqUkJMZ2hESUZKMjRlbG10UW0wM0lWNUNnTnpP?=
 =?utf-8?B?djYzeHpyUEVoUDhCdDY3U280UExpNjhwQXZHMjVmR1c5QnRBNG9oNkxTaStY?=
 =?utf-8?B?K1ljQ2dDQTBMNTAxaXZlejhTV0gwcEZWcWxvSWNJdkYwcWlLb3NGR0tHeFp4?=
 =?utf-8?B?ZlpLaXFkT1JNeWE2UXpZd0lHa01iK1podXBIdXhPTUE1VlhnVEVkem9vcW43?=
 =?utf-8?B?bjJuRlNRbTRvNlZjVjlvNHY2NGwvZkV3UkdxK3lsT1hQOG9xekRKaCtpakY4?=
 =?utf-8?B?YkdydFZ6bW14a1FMMEtjNit5a3ZVTVM4QlhJSGlzVE03ZHVsMW9RSlVHNEE4?=
 =?utf-8?B?RzBnMTkrTGR2TVlXL0dBYXlKRW0zOWJrN05DRm1HMUlmaFRmN21rSU13VXZI?=
 =?utf-8?B?WEhjM2VmeTJjdTJpZEJ4UWpLQVIydWFVUmY4bjhYVXg1Snl1OG9CcldSZXUv?=
 =?utf-8?B?ZU1wMUVPKy9wMG1DSTFPcVdwbHFWRlNIcGpQVndocFl3Y2todi9VaDFIM3cv?=
 =?utf-8?B?L2dVYzRBdXJmbk40V01tN1d1OWJOZEh0RjRodnU0VWJvMzc1b0ZIZWM5dUxj?=
 =?utf-8?B?dlJTR3VCSG1vTWR4enhwNW50K0o1MmdhcGhTTXJRMlJXTVk3SzNxTkgwRTVS?=
 =?utf-8?B?OFM0M1VhdFExM2pwVktFbEt3SkpPNzh2UUJEY2pEY1piTk4wWlhCc3l4RTZP?=
 =?utf-8?B?eUEzQW1janNrekpOenAwVlBjNmtTZVBrblpheW93bVdrd2N4L3ZkM2NMTXV3?=
 =?utf-8?B?bjd3bGhNQ1J4YlZnRDFQR0N4UGM5OVBhOUJXeW85aEg1R1V0a0Z0UjlxRGhT?=
 =?utf-8?B?WFkyaUVMdVJha2U5Zy9laVVaYlh2c0svcTVjeWtXTEdDbmNpRFZrK1IrTnJk?=
 =?utf-8?B?bTBPMzhPd3VGTFZ5QWVxaVAra00wb1BIRTlhbEZibHBMekZhd3hlM2RHUDFB?=
 =?utf-8?B?bEJ0MWlseE1tdTdURHVlZlp4RGg0bUxUSVY2RDErbmRxVnJlREp3WG9Pb2Rh?=
 =?utf-8?B?anBRbnlGWng2anhVOHpWK0I3Z3lxWkdxeDljcWViQW93TEYyZ1dIbXFvNTBk?=
 =?utf-8?B?V0N1RG1hTGxjNWUxZ2ZlQXF6YkgyWEJmdWpkK0U2SzU3dGRwSlV5MGlDMm56?=
 =?utf-8?B?aURzVDdSakVaSThQc0xQUkViUi9tU2tncHg1Z2RSRDZ0WUt4V004TUFzVHF2?=
 =?utf-8?B?SkczK1B0b1dXbEtyZk9nQk1qaHZQN083b2dYNGhBY093anVtNDNDZjhsQzQz?=
 =?utf-8?B?RzVsR01IYXdNZjNlRldhdk4xWG8wbldLTUw1WWJhaVg5dDIvTGlPbSsvUloz?=
 =?utf-8?B?Zkw1M3ZtTHVMV3BhbWt5TVVBQTZiMmZWNFhZaFBRR2Z0U2ZOa3hDV2NoYnk0?=
 =?utf-8?B?aUdLUnNSUmg3TGhKM0dPTXltZC9JWGR5cG9TZ3UrWlowbUR2UDNHZGZBUEVV?=
 =?utf-8?B?SzBoWDUxbFRnMDlqTm5tbnFzNVd2SytVejB6NHFlYkpFUGNabVlTZ0lhbDA4?=
 =?utf-8?B?UjhTb0gvaDVmRExEVnNCcEo4WWpJOHNaWnlUVXMxRlpsbVVJQk5CWWJQbXJ0?=
 =?utf-8?B?Z0dkYnBBSlZwUE1sR2tnaVp6SFlCNVAvMmd6cWVqc21veWZGQ0ZKakFCSDBm?=
 =?utf-8?B?WDUvUVlRVUZ3Tk52RGI4Z04zUDk3SUpNQ05NSGRzZGtCM0pLN3Y3R2IxamVD?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36477a4a-f9d9-4e14-088f-08dcf3c15006
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 00:17:57.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gt61vU8DWKHTRaQo7Jfiziw1U9GFMzTtDN+PLFfEBzXXWyrWJcIgnkk1E1VMHs4wbjcSA/o0eNf7YRxL0vDJ9hP8jJ53Cm/vUhhgcNi5kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-OriginatorOrg: intel.com

Hi James,

On 10/8/24 4:08 PM, Tony Luck wrote:
> On Fri, Oct 04, 2024 at 06:03:47PM +0000, James Morse wrote:
>> +functions_to_move = [
>> +	# common
>> +	"pr_fmt",
>> +
>> +	# ctrlmon.c
>> +	"rdt_parse_data",
>> +	"(ctrlval_parser_t)",
>> +	"bw_validate",
>> +	"parse_bw",
>> +	"cbm_validate",
>> +	"parse_cbm",
>> +	"get_parser",
>> +	"parse_line",
>> +	"rdtgroup_parse_resource",
>> +	"rdtgroup_schemata_write",
>> +	"show_doms",
>> +	"rdtgroup_schemata_show",
>> +	"smp_mon_event_count",
>> +	"mon_event_read",
>> +	"rdtgroup_mondata_show",
>> +
>> +	# internal.h
>> +	"MBM_OVERFLOW_INTERVAL",
>> +	"CQM_LIMBOCHECK_INTERVAL",
>> +	"cpumask_any_housekeeping",
>> +	"rdt_fs_context",
>> +	"rdt_fc2context",
>> +	"mon_evt",
>> +	"mon_data_bits",
>> +	"rmid_read",
>> +	"resctrl_schema_all",
>> +	"resctrl_mounted",
>> +	"rdt_group_type",
>> +	"rdtgrp_mode",
>> +	"mongroup",
>> +	"rdtgroup",
>> +	"RFTYPE_FLAGS_CPUS_LIST",
> 
> Something goes wrong with moving the RFTYPE_* defines. A new copy
> shows up in fs/resctrl/internal.h but the old copy isn't removed from
> arch/x86/kernel/cpu/resctrl/internal.h
> 
There seems to be a few more duplicates: RMID_VAL_ERROR, RMID_VAL_UNAVAIL,
MBM_CNTR_WIDTH_OFFSET_MAX, RDT_DELETED.

Also please check the trace files after the move and related CFLAGS.
arch/x86/kernel/cpu/resctrl/monitor_trace.h is just empty and the
arch/x86/kernel/cpu/resctrl/Makefile still has the "CFLAGS_monitor.o = -I$(src)"
Also please check fs/resctrl/pseudo_lock_trace.h

Reinette


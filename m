Return-Path: <linux-kernel+bounces-223640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C39115E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF42528544D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88088147C74;
	Thu, 20 Jun 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgvxIvLn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A36F2F1;
	Thu, 20 Jun 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923837; cv=fail; b=kaHkcQiNj3uDmuOeihnQISU+f5P1qxWpSfD6qExd4mSqO5RT1cOPKY/Zx+IP33iMl1y+iTdCthYeTylK1EevLWr5J8WZ27KMZXaGwYnjo9s/bSWkccvHzBB8juP+0ZUon/Vhw8wgMwZjjkp44sy2sDIyZ09wWPx/cCCShPL9ajs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923837; c=relaxed/simple;
	bh=qF+Ube6xotduqkv+F4t+bLLSo71sdzaSRLyLz95sH/s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bHlU0ZXNThDS6k92Vh8u5BgW96a9KarlAApWxkewZ/ErSzpS/bFKt8vq+HvGm6XSaKgZ6BZVZqI3avuIYmPDLxR7i0MvWtIE6DZ0UqvlpJirk5hhuM81R3Y/lePHJ9K1D/OQ7UGId471AiVhloXBYopruQsmTBH0dmw/8mfo4Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgvxIvLn; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718923836; x=1750459836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qF+Ube6xotduqkv+F4t+bLLSo71sdzaSRLyLz95sH/s=;
  b=WgvxIvLniPIIIaJOI97FQe4asTFKK//SF4xgpvZuwm5Lq9W/DF0Zrhj3
   oYYxxWTcw3l15jV3QtRJKHqXH4SA6TztJFyrhw8tOf3eyciNYRDfveuXj
   1HYeBrmy5aQlIH9BloDbOjy+v6Fz7H1Uw0c4+zeRkoX1ek3UzQGgPVtrX
   jTM7gqo6fa1N6ovhjmcTiOn8fQAzS8inuUoNPSq5yB2NYIL2oPmlhghrk
   5EqLLp1r16M/z2E/LwGlSF9APz0KuSWnW/nHSCrUWZhjZiziCsxAi6LJ8
   3Ttw/W/BG+Tw1Q6wFavpx3Gr6dL9qr4B02ikGGo493n6EplHyVivgX/+2
   A==;
X-CSE-ConnectionGUID: r/xnJThhSa+mhMH60GbbDw==
X-CSE-MsgGUID: eO/7PfJOReeNFRLT8SZTjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15697368"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="15697368"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:50:35 -0700
X-CSE-ConnectionGUID: bznWBlouTGaxYc4Y5gBLZA==
X-CSE-MsgGUID: TuLl3wSLRw6BpsH8Jrg0+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="47336974"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 15:50:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 15:50:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 15:50:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 15:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTkoNMNi3NiFTh0JGzvnr1U1UKe8B0CKJLd//RvYlV0k1jgScjBG2QuDvBFCypEx5+8olss85M3neFIxsmmUVFWKtICvcon299+U4yVe7U31LFvX0phVsEri0pZGyIIE4ZWMQXoPApAFDnCWpJTGdUtSCrzAw7RFTMRbRgVH/wa66aR5Xk9wwoLJ9eb9UIS+ReIs2qL3Jf7XGEm2pBzH6NnotiTl5YFMQo1seaMy6NTsRuF1r8YuwUOlGYNsfxegqJ4y614o+kLHo2FXGAOyd/uo8UFitbCupuNr79gcLJPeRO9Oy3ze4E3ocDebbtJC6rQdTMRBOpfn0HtoC3SO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Axd31JUvcvA9st9sG2Zp99qo2DmGDlFo+lzGLpSFpwQ=;
 b=apRnIAocWypxAQxF/71YvNjZrG+vXlfxvcz/Idt7I7/s8/dFQYXu1i0Q8ZWtZl8F0eEpK01h3T9cqaKEe16JjlGlDj7G9hX9dEaRPtOAVhvBc5l2sM1NfvPHG13HJq/yT6ARMhPG4T+UWnzZcbbdBAuLGIjmwY0LP18f4NbIdSVLRwHpE9UWEUssJV70h2o/6dH0rahf9GEdtjqUKCxwPfJJfiDYVv1vYAq46hx7ZCzPlLcuqTSvBdPU2y2fbq9c7orL6qkk3VTPJWBpCpkmhUTV1CncrgUU8YK5GPOsyuVJSHbQGP3AnY6PI33A3ZQhgP0J++wf3dFTqtDDoRgiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 22:50:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 22:50:32 +0000
Message-ID: <13297090-926c-4585-95ac-02a865ad1e49@intel.com>
Date: Thu, 20 Jun 2024 15:50:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] x86/resctrl: Add the interface to assign ABMC
 counter
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <631092558e7fe0ac2e6267070e40c4a97b300f57.1716552602.git.babu.moger@amd.com>
 <e649a49f-344f-4dbd-be2f-d70f932a80f4@intel.com>
 <16b7768c-8f68-65fb-19a5-55a117dd0603@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <16b7768c-8f68-65fb-19a5-55a117dd0603@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:303:86::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: dd89e11a-823e-4356-d8b9-08dc917b63ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTVjWUhpWnFsNGJhdFM1YWZFMlNiVk52R1A0dHVObythVUFFb2pHUXJVeWdD?=
 =?utf-8?B?aWMzc1kxWnVrQTB4WndSVTNLQkJFZ2MyNmdWb1JYQzhNSUVLZkJpSGNzbG9j?=
 =?utf-8?B?YUpHU1Z5ZUpickRGSm52TkhTRVRFOXJySEQrWkwyWHBTSzlkVzBhME8vZUZH?=
 =?utf-8?B?NExQTE5xNDcwVFduZXViOGw4TVM5REtnS010ZjNySWVnQnJiRXpvZFRveWQ4?=
 =?utf-8?B?bGRDUVViNVgvRHh1bW9RdWNyMWM2M200VDhXR3NjQXM2NUF1cmxLdnVaVTRI?=
 =?utf-8?B?TlJzRkpieURLV1NveUNTYXpzKzQzSFIyYTBZZWo3RFZtVGI4RUZ2SFc3YmNw?=
 =?utf-8?B?QkUwQnZEUkZUMk9hMDYvZlBwOGF6c3FmYnBaS0RKWHorNjdJNnkrY1Voa3Bj?=
 =?utf-8?B?amFSVUlvYlNGVU9VTDdZcHFvK2FJeW5WWFhGeUZZdDU1ZHhOSDhScm1JTk5D?=
 =?utf-8?B?Wkd2YzQyNlRwOCtBd3p5U3hrU0JFNTg3MEhpcUtkWGVDT0I4RXA1VGcxdXFM?=
 =?utf-8?B?ekNUN0dQMzd0UGplaStnU01UUkV0ZnRud0RFRW1TOWtUVXViVDJEQ25MTTBY?=
 =?utf-8?B?R3ZMbFB0Ykw0UHBVaUhQRkNWVXhDVHFpalZKcEhEQVVlelBRdTU0UVE2UnNJ?=
 =?utf-8?B?TmZIQ0Y0Mk9FSFlIRkN2VTJMOHd1V0xYTWdaQWdBelMxaElobzZOcmRUa2hT?=
 =?utf-8?B?YjB1aTdJQlhzRnZSNjJOVjgrR3BKTXlxTWVZSGtCY2hMTDZtYXdRZUlnYld1?=
 =?utf-8?B?RkFqN1IzM3lFZ09iT1REbWsxNTc4RnY0Z3Y3ZlJPVnZnWVFIVEZUUlVvS2Uz?=
 =?utf-8?B?STdRSjBoZHN6R2FaVVArU0JEUmhGSjJRWTZWT2hVSkl3S2puWjFvdDl6Z2dH?=
 =?utf-8?B?R1VWNVFYblQ3VDc4WWRuZnZBaENmYmp4eWV1eTBGb1dZemJ0Z0NOOVFKQXU0?=
 =?utf-8?B?VU9iYVBzWkt5T2pNQU93dlZHQ3hBUUV3aExzWXZTdk1ETjdJTTRKeHdvZm5F?=
 =?utf-8?B?UFM5d0xIZ1pYTFBUanIxdFlUVDNYOEI1TjJ5cHR6U2YyQXU3Y205bGZQRVR0?=
 =?utf-8?B?eXFtUU9YSnVDNDd1Y2c0U0MrUmtOcXo1aWhXWDJodXZwUjg4TGV3aGxHVVZ5?=
 =?utf-8?B?WHVXcTdMQTIvZXJ4eVpyRWhqKzdpTHVHdXlSdGphdEM5M096dGswN0t4V2FZ?=
 =?utf-8?B?MDN3b3JOVW84MWpBWitNWW1aVUR6eWFXVXpNTGRaM3dVWWxpeWRWdDR0TzJy?=
 =?utf-8?B?d2NCd0IyNEl4MkNBeHI1WVN4bDY4WWR5TUZXMCtpa2ZQdHYrTHhzVURoWG5R?=
 =?utf-8?B?NEE3eUJrb2JyeUtQYllWV3lpYnJ4d2VpL2xvR0tZbXFrUlRYLzRyekhpNWIy?=
 =?utf-8?B?azRWZlUxQUNydDJsOXhQaTRvTk9ya3IzZ2R3eUVaM2wzQzcxeEFETGdIL0Jq?=
 =?utf-8?B?YStiZktTN0M2MnJBcVhiR25qRHRQR251V25zNkJyMmYxalZiNEtoMCtjdEVh?=
 =?utf-8?B?MXZtelNtRzJkbnJJT2NpaEJybGVjV3BKamt5cVowSG1hZGVrY21ZVTFKRktW?=
 =?utf-8?B?Z3RHcFFaZ1BHNFF3dGFWVGc4a0hJTHJoeGZxMTJzVDMvOFhmTjRVODlNTlJJ?=
 =?utf-8?B?VFFXVGpCU0l5akxaYmhreVJBWjltZVg1NlFJc0xFckJkSUFqK2ZxcTl0Y0JG?=
 =?utf-8?B?OEhIcDBzd3QxdUlRU21mcUdQeDdOVmlYRkwyUWtlWnFxUGFmUFFZbjBONjBx?=
 =?utf-8?Q?f1wugAWhcpb7FIgBetmZVWwg0smJ9bYk+KQRXZI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmthUjk3dUtJbGh2aHprUk1vdytXdUxmZXF0dzJ0eHFhbmFrNEcxaFpjY3lw?=
 =?utf-8?B?ZUUxdEhFOE9kRkhYZGluNlNMbW9lc20wNEZTMFRkNCs5blBHcmxaQlZRNlJl?=
 =?utf-8?B?alh5dFdKSndSWk9HbDVyaDFEaktpVzIyYUl6RGVHMncyQ1U3U3RFdjcyQmRX?=
 =?utf-8?B?UGpnQmJKTWY2dTJIODBqdDhMc3RUWlg3ejZNSjdGSjlmY0pNd2l1a3Axalkw?=
 =?utf-8?B?eE10ZE1uME1HSTQrZjhVdjV5K3VQYVZsT1Z5UWhIL0FqYU5ZcWJMVk9QRVF0?=
 =?utf-8?B?TndJTjJ3R2N6aFMwK0lUZk1Pek1ndEpDU0kvaWgxMzRoN0l2bXExa1RBTmF6?=
 =?utf-8?B?QXlwL29JenVpMXZub1FFd01vandyR3hBSkVkYlhINm5IbllJdmxtci9HM2h0?=
 =?utf-8?B?R0R1YWU1aHAwaVJzTGd0M1dSVHZhTlpVajNwZ1ZBa1BlMXpoR2VicHN2ck9Z?=
 =?utf-8?B?SmRTdld5S04wcFVCUVpneHhqZ1pTQjZxNGNLZERseGQ4M3ovQjViSTVhNHZF?=
 =?utf-8?B?N2FnYlUxeFRYK2VsSkV2M3JrbVFoamQ2LzBRdXJwUE1kMnNwVHFnWnp0bnYr?=
 =?utf-8?B?UVZ5aS9Kck1tdmduSGRrMkN2cEY2bnppR1BadEN4YnEvSDQ0MUh6UTFnTlor?=
 =?utf-8?B?QU8wYnRaYk13eXFPOG80NFFzeVBBSjJBRU04MFlXdzh4a0twb2dUWC9jZTFu?=
 =?utf-8?B?K1oxZ016T01RVklYa3Z5SGlGQTJNTXliOHRyUlNHeDZ5NVBMNEFXMFdIUXg0?=
 =?utf-8?B?TkRVWWFYQUUvZTNoOFZIOGlPMHdHamlFRmdIMnFpUlhCa1E4TEY2MzYvZWM5?=
 =?utf-8?B?bkNKRnIvSjNDYWdVOEQrRHc4YlJ3NGJ6L2pBMFdtSFpZTTc5ZnlGRTJpU3JL?=
 =?utf-8?B?U1cvRDF6TXZybnhwRzIxbGxOM1FkSnk5bXFPamRFUTZleFNNcmUzNVZESmRP?=
 =?utf-8?B?dmdMTGc5dDEySUx4MTN2WXZwUVc3WUM1WjhVZ2Y4eHVhTjUzUm1xZ0VTRmdS?=
 =?utf-8?B?UDhqclcxd21SYUZjek5nUjM0clJzWTBwL1EzcFZZSnFhdEtRalFuM1RYNEpS?=
 =?utf-8?B?Sm95SXg0YXViWWNIcG4xMXJudjdtS0cyc3JveUJ3V3ZaR0xmTnVJSUNUMFps?=
 =?utf-8?B?VkNrZGREcnpJbnVtMlcvL2NnRm1wYlRYcDhrYk9EODY2MVNYbkZvbndZakFk?=
 =?utf-8?B?R1E5R3djK2w2NXBodGJQQkp0UW5SZVBRdlU3aVQ3TWpzYXZlQ1pxMUMySXhh?=
 =?utf-8?B?RXJhdUZoMk01R3hYeWVkMjQ4SWJqSURQL0VMbmNDZ2sybno1OTVnRWExTUpn?=
 =?utf-8?B?NlRIc1o0S09NU0ZrOWtuT1hQeSs1ZkRMMEZyQVkvNjNGSWhiZ0pDMFpuS3Nj?=
 =?utf-8?B?YmFxMEcxek9Henl6Z1VweGJualNuOGNkbGJDUExKUlEwdkNaMkxhbE5pbXZI?=
 =?utf-8?B?aGROT09JM0tjSEtrazMxMzdycDdRZlRVZkJFSkJoR3dOWnRiaHFkcmEyVDZi?=
 =?utf-8?B?N3J5RWdUWkhRZlF1Z21kcndXRXIzdWFXckxSK3pob1UyZ0lWOEJ6aGRaMlBu?=
 =?utf-8?B?TXkvZ1MxMk5xL2JxL0J6cjM4WHk5bERkUFU5SGc3dzZhcUNTeE5POTF6dlR5?=
 =?utf-8?B?azhLM1FYN0FVZG5TV1lud3hZTElCUkpKOGpYcjZqTDdhM2s4TTBrb1ZiMWhU?=
 =?utf-8?B?WUpLYjFkdFF6aVB5YWRiTjREQzNDOFF5T0VBNnRxRnZlN0xwN1FIMm9WSnEr?=
 =?utf-8?B?MWRXYTVFbCtDTlRncE0zRjhtc1ZNckRiOWRrM0JaR1BjaURQVWlQQW0yRE9a?=
 =?utf-8?B?azVXZHl5dU0vdmpWWnFNTmtMSitTb3F2c0JYajBVaXowN3k0TGg3NXV2aVl5?=
 =?utf-8?B?V0NrcVZUQW1XbnJLZlZoTUxVZEtwNS96U3pzS3RRdlZ4L3ZXbWpJM0xUY0lj?=
 =?utf-8?B?Q1FxWmhsSTMrd3NyY0hxMUVZMWVKSkllZ0NZcFBOK0o0NHlsQ2RiY1hta0lS?=
 =?utf-8?B?am8wajFEcmNyY3BuVkhMS2EvaUhIK3hLZ3FWZlBMMnQxTU9pZHpNeEtGT0Zk?=
 =?utf-8?B?L28wUFJJN1RYeUt1bmpmS3pCMEJUOGVtMG9XVFNPMzZiSzh0eVd4M1g3M1Z1?=
 =?utf-8?B?c1JyQnZiU0JwcE5Wci94WXFUVUxCNm50d0tQN3VNYk5JbzZEMHhNRFdzN1gw?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd89e11a-823e-4356-d8b9-08dc917b63ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:50:32.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mizhdExWxojMZQ2MbsZUfLg7GFw90yfty638KJ/4rUvLJaM0CjGcvVKEU3eGd9kNXCB0tBOlGU64pdOAU+TndVhitzThM1vxhhE9QsMfde4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com

Hi Babu,

On 6/19/24 3:38 PM, Moger, Babu wrote:
> On 6/13/2024 8:48 PM, Reinette Chatre wrote:
>> On 5/24/24 5:23 AM, Babu Moger wrote:

>>> +int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
>>> +            u32 ctr_id, u32 closid, bool enable)
>>> +{
>>> +    struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>>> +    union l3_qos_abmc_cfg abmc_cfg = { 0 };
>>> +    struct arch_mbm_state *arch_mbm;
>>> +
>>> +    abmc_cfg.split.cfg_en = 1;
>>> +    abmc_cfg.split.ctr_en = enable ? 1 : 0;
>>> +    abmc_cfg.split.ctr_id = ctr_id;
>>> +    abmc_cfg.split.bw_src = rmid;
>>> +
>>> +    /*
>>> +     * Read the event configuration from the domain and pass it as
>>> +     * bw_type.
>>> +     */
>>> +    if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>>> +        abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>>> +        arch_mbm = &hw_dom->arch_mbm_total[rmid];
>>> +    } else {
>>> +        abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>>> +        arch_mbm = &hw_dom->arch_mbm_local[rmid];
>>> +    }
>>> +
>>> +    smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_cfg, &abmc_cfg, 1);
>>> +
>>> +    /* Reset the internal counters */
>>
>> "internal counters"? This needs a definition ... but since this is not
>> a new data structure the comment can be more specific about what is done
>> and why.
> 
> How about?
> /* Reset internal mbm event counters. */

I think it is potentially confusing to introduce a new concept of
"internal counters". This is just the architectural state helping to
detect overflows. This commit has no mention of this but I assume that
the re-configuration of the counter will reset it, which explains
why it is required to reset the state maintained by software.
A similar comment to what can be found in mbm_config_write_domain()
would be useful. This does not have to be so elaborate, maybe just something
like (please feel free to improve):

	Configuring a hardware counter resets it. Reset architectural
	state to match.

Reinette


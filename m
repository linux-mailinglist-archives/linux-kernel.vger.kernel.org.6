Return-Path: <linux-kernel+bounces-411547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D26E9CFBC9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789CDB27C33
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726745C96;
	Sat, 16 Nov 2024 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpCgeBl9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CF610C;
	Sat, 16 Nov 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717545; cv=fail; b=I60MAct3m5tO7H2Zvtts/n9ctgMNEmZPTp3ITSEysALo+yKFBd4bYc2u3LOdUcr7eRLyxPxAMR7oy+e+PM4ecaz43Ss7JKxnh0HEMxtlEXJ/xe6awYVh6WWW2XmTLMPWB6C2/UIdkOg2uvqEoi3lGBTbw74ErECWI/CqNGEHEKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717545; c=relaxed/simple;
	bh=CkOWtVcNNvnwvh3i4nvc7XwsY3siJQTqcY3hgOklnq0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KBD/75jkOKciIH27XatwffA4COU+dPV7VI5a1GwudB7lhaz/PlJGZwpEpUxloTLD9hyXfMYK4J4vg/uNYpAh/2dqlbcx5m7TyqyCivKm1QKXiNTmLby1HMO7Jr8kTm813DPy/if4wxPkphltPwpgr/PcLj6tbcGk0QdudYkMh9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpCgeBl9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731717544; x=1763253544;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CkOWtVcNNvnwvh3i4nvc7XwsY3siJQTqcY3hgOklnq0=;
  b=PpCgeBl9aBdOmlPkXimEAyogWRe7W187wK4IG1Q2mydSlAH3GtXOlPCL
   6UtYJoUdHh3EGstp4CuPIfeRPJoqWWS5uJ9yH2hfF7k9u35zGHlYLupX1
   x3fiK4d+6d0Akx518ntL6wu1jek1+hJItsirx5ADbFbbKs6Qs1G3J6H35
   cm9sRxl87v6DZXTQe71QxOL0FfQt3VhhgMGKHHZBfIc3J0i3OFB6giPNi
   aG1WUtzKiJuLbYTVBgMRvLKKt/4NTsbuCcxpCjUtCsAi5COq4OMKW/S22
   I3zhvgGO4oPU8EboJ7kuYoH0R8nPM/WmZ1emh95cv26mSa1i6UaT+7U1O
   w==;
X-CSE-ConnectionGUID: QGySylMbQhSU3a4ws0zhQg==
X-CSE-MsgGUID: w1z+J5smSZa1M6lR3FXRwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="49173441"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="49173441"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:39:03 -0800
X-CSE-ConnectionGUID: c/98pglETkOgy5GRgQn1nA==
X-CSE-MsgGUID: fKrO8qRXR4+CCN9TBPkmhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93723329"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 16:39:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 16:39:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 16:39:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 16:39:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+2O1kRva8p9YcneMPJIKJb/8sb0wJZjkV8hVpqS381WNKrB7jqdHPpK1rHPZ33rNXV17c7X0VdWPPi6871zHHDxcEtbHD50UZBaRWooT+IF0agYShB9v9YKPLPmS9+h+GMVEt3IzLOJDa6mgBpU3WM67hO4BkI1HLJonCw8VTv24PiCkQMhUFp+ykX5ORP1qY1TYmbiWDSPtM40ahCXepAeBUOSwHl080GCxYsW+W7x1z1aT3NMo3NCiekkHV2GieB2h/egHCUtD3HgrjeTY8+UDj7n1K9wgkvgpN12Ccubhu+0h7dgA9QicpRRO2cOpzVje75h6UZo9xWrjAJfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbvBR/kbWTI3qnwBxUfTtAj5K+OyFnHlVb3o2Xyc9SU=;
 b=EbDjgeIasu/rzbHgdke5TNboDX316wj4ZTEIwQQMga5E+j6I9XVB1JaPff4wTP7cXLvgqzo55tEKLBkw+FRM5t5ojylpbNvz51OX96VmjKOyLoNuxG6JmJEdzPE7dKzDxkk4XltDj1Rk/QNUzzn0/Hzw2v/ZRXD0y0+UzviLumteJF6ib0gHjinwg8p0wfGIjf/qbt+lREyLK2ChMYV3w7++6Ko/tpm9HC00VK/QPMhKsfRbc7mwZ9BbTkGeaZjRopC1+L3Z3iB6oMNkiUwsdxXU1fjPJUO+gTx1ShdAUvinxDwYm7BvjIdd7cqspcgs6vHB5ub/f1cEN4x2dBdfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6955.namprd11.prod.outlook.com (2603:10b6:510:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Sat, 16 Nov
 2024 00:38:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 00:38:58 +0000
Message-ID: <49350779-c7a6-4fdd-a6cd-0fc5cf4d154a@intel.com>
Date: Fri, 15 Nov 2024 16:38:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/26] x86/resctrl: Introduce cntr_id in mongroup for
 assignments
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <be93dbe464747ef0b6e3158aacbd32499028cfb4.1730244116.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <be93dbe464747ef0b6e3158aacbd32499028cfb4.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:303:87::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 31597eea-2cd9-499b-cfff-08dd05d70ede
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnN1N093YmtWOTNrZVlXUzFFVXdGU3huQTdobWJEZ0JPaTcyMVJaNjB3Y3ZX?=
 =?utf-8?B?NFQ4aHduWCtEZkViZ0RiakVBelNyRnRENDdVN2dkR3BsZjlTVVlZbHh0aUxV?=
 =?utf-8?B?NGlSdjRHeFB2SXpObHlRcWpON3NraHNuMjVDWDFzMXorZndkWWZBcWNrWW1z?=
 =?utf-8?B?Y2FRSGhaaWxkdXJXS0dqMGFnTU51R0tBMHdVTHc2eFpzYUMxcmRmRTAzTVJK?=
 =?utf-8?B?bFRubk5vRnFWcHdDaCs2WHZQN0h6U3NvSHRIS0FydUdEelFOUysyNTY4T2xI?=
 =?utf-8?B?ZGV6eTFmbnE5RjROZGFGSlhTVUxCVjJoVVBXejVPVGNaZWZqc2pTWGdNUk13?=
 =?utf-8?B?bjhHa0lETnIyemYxUkJ5QTV3dnZkc3RmU0hRbnc2QUkzWWJWTHU1ZDd3ZTBl?=
 =?utf-8?B?OEhaREVHL0V1ZkdVVWtab0l1d1NmcnAxU2pHSXN0cHBQMlhCL3RjWE80Y0NL?=
 =?utf-8?B?aW9MRWJYSytJVXhNT2lxdTUzUHNOdC9aenZ2OTl1WjIxMFErZVd3T1VZZHds?=
 =?utf-8?B?aDF6Tmh1LzMrTmROcjlsakx3cmJrcGpybUVvNU9YNXhkS0RKTnZvQUV1NWVQ?=
 =?utf-8?B?NXl0azNabEhZU0NnVWsrMmNDbXRjQjVmWng2dEc5UWpCNS9GWXVZaG5KajFw?=
 =?utf-8?B?MG9xUjNTWmhJRzNZNHo1VGF3ZnRnSXVYMmN6bUtnU09NZFVYVHhGbi9hTTJw?=
 =?utf-8?B?UnVlVFFLU0YrQjkvZlc1cmwxcGQ0ckYvQ0Q4ZnRQMkVjaCt6M2dteVJ2RXB1?=
 =?utf-8?B?eXlJczlHbnFtVkJSOWJHc000cTZCM3RwUDFiSDJFWnN5RnZxcVNvTXpKR1Nv?=
 =?utf-8?B?S0FydUE2aVhxWk1iVWRPSTdPemJrWmhCWnhxY2FYZGNVRUhMc1JkWVpndnpP?=
 =?utf-8?B?S3A4cXgwYksyTmNSeWRETXQvUUJCRUVndmFIUFpDbmcwRFVwMmlvVDE4TmNT?=
 =?utf-8?B?RG50MVFZSHBHWjl6MTFGMDJXSHhvM2lZL3dOb01RUnV0dFhUMVRiUlIxK29Y?=
 =?utf-8?B?YXM0R1Bzd05RdDZQL2d4d09aV3R4ODNIbm54cnNQRDQ2dWdvR3g3VlBaeW9O?=
 =?utf-8?B?bUVwdEVpMitHUERaK2xwaUhwTTNpUll1eXVGTVFpUTBhMFVSV1lWWDFPUVVH?=
 =?utf-8?B?Q01kUzJXc0xBeVBpKy9TTVJNR0U1S05TNGpFeEp2YXdMZzZZdWhEcG5oWjNX?=
 =?utf-8?B?YklpbjZ2eUlqRTJkNWFFOGdPTjBad29veWFMTVpVOW1RcFc5Z3g1bWQ1Q0NL?=
 =?utf-8?B?VjBiUnBnRENXazJWa09xMEwxSEZNSjgrWjdlRElRREdZSXRoYVkzTU56UGRJ?=
 =?utf-8?B?ZGZXUGl1a2E1K3JmK1hDQVNvaVdJYU5OOHRxQlVZNVpQSHpJTHltZHcxUjFr?=
 =?utf-8?B?dmR2NkhpRVgrWnE2NGpjUWlNR0xScW1pM2ZmZm9QNjdzaE05Z3FDUUsrL0tW?=
 =?utf-8?B?MnczbE9SRDVqMGl6aFdjOXRYdEtjckM2MFpKYk4rM0FCcUtSalJjZnUzUUhk?=
 =?utf-8?B?TVNNNGxSS21Zc1E5SDRxOHhmY3UrMmtaYTFIbUpPYU9ycDcyeW50N0J5RDlr?=
 =?utf-8?B?UTFFd3N4UzNCekhiK0pZd1BUUXJXcVYzRzBDYUFkOEFyNkVqeEZhWGZRUWZz?=
 =?utf-8?B?d0ZUMXRST3Fwcmc4bEd1cnJsbjIyQjExM2xMRWtielJuYTg5aGtrdjhuN3cv?=
 =?utf-8?B?N0p5eTcxUEJoMk4rVTl0Wk9JVHhvakZhMmpndEE3STYrZ3BnSFFNcHcrczY0?=
 =?utf-8?Q?+lUpKcmcBcoNZE9kbk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkszM2NWaysza0puZWRqQ011NDQrS1ZudWt1bWZLd2VyQkJHZnlzSmMyM2Zm?=
 =?utf-8?B?RS8yTytReUVGNHZ0OWlzeXEzUTNJdHRtSkE2V2tVaDVoSVpybjFuS2hJT1pJ?=
 =?utf-8?B?aVJjUXdudHVPZWM1dFh1Q043SndVUjg4UzUzbjZLVTFDVC9vaUxPT2x6aUs5?=
 =?utf-8?B?a3hCU3plU2dhZkk0d3JtWnNnbVFmVmZYaC84cit1NzM3NjIxdW4zcmlqZyt4?=
 =?utf-8?B?SCtBUEprTmxnN1E4RG9QWWN1U3FISmNCdmpaVkw3RnVTaUUvV3hXdUE4cFh3?=
 =?utf-8?B?VzlqZHUxUE5XelZPVWpBdzJhMzByU3BDUWVDQ0pSZ3luK25EekROM3lBbkdi?=
 =?utf-8?B?cXpiZGtLVDdPMllKK1p0cXR4dnhMdExQcTVYQUs1NjZMM25UR2cyeFFVTzdt?=
 =?utf-8?B?S1B4czlJazRzL0x0eEJiT1dFNzBQd3BBNTN1ek1teElsci92KzhHenZrTEd0?=
 =?utf-8?B?dUFCaUVrbFY4dG92U1dMTkZWdjNxYkVPYjltOGFOb3RDc1RHWlBTcWNLVnlT?=
 =?utf-8?B?Z2JtdG5oeWV5TVlUeG1ZbGhjZWgvMHZINjdSdkk1YnV6TmN0bkZiWlhVTFlq?=
 =?utf-8?B?U05HSitRVjNOZWhLZ00yNHB6M3dULzd2bDJndmN3M0hWamJDclNLZmx6SlZ2?=
 =?utf-8?B?NE1lMnZMSDF0dERpZ0YxQjVXQ1ZoYXpnODVKOHplMFo0S2JBUjZFVFZxS1Zw?=
 =?utf-8?B?VElDNC9lbnQ1c0dneHlKcytUVktvKzk5cHhHZkVoQVlBdmVuUFQzSzdBU0t6?=
 =?utf-8?B?b1JpZ005c0MwbERzOVNqS1ZiZ2lDOU5Ed1lFeDl3MGl4SE11VGpWWk53WjFw?=
 =?utf-8?B?dGhsVzdpV3k0R253Y0NrSStLMHJqeE55d2k3cnFXNFRjZCs2eVZUeFA4NTVK?=
 =?utf-8?B?MFJiSEh0T2c5cTlrMmVuYWhNcDVxV3VYL0V3YmU4SmhJanpxQTFraUdXYmgw?=
 =?utf-8?B?aDZZM1VYTDJLeEwxTm45RzdveTZGc1FvYldyc0V0M3p2SFNmcTNwbGF6NXEw?=
 =?utf-8?B?bkwvc2lNOXhhbFMzQ2RnZVQzRzlMUE02d3AzeThFMXplV1pXeXBsZHEyTXVO?=
 =?utf-8?B?eEpIOEEzSmliSVA5QTV6Z0VBTitacGo4WEZidjdCWHlPQ2ZDaHkrZDZXbnNQ?=
 =?utf-8?B?ZkloZkRadHBkdks1UStRblQxN3NnOHZXb2N1aFpTaURQNUllZFZqQkI1Z0tD?=
 =?utf-8?B?V0NTaWdIUjlxT2Q2bFR0QkF6TVRWM2Qzd3RySC85eE1pV0ZiTExKRmVNWFRz?=
 =?utf-8?B?eWVUeGhyZUQ3VTRmWFZWVUs4dTA1M3NCb0thWDNVQnE5MHZ1NUp5U1hDZVFD?=
 =?utf-8?B?a2VkbEtaaDVodHZRamMzaG5SN095ZGRTVkJRRnIvRy9NcTZCQXNCbS83bHBa?=
 =?utf-8?B?VVkwOUZWTGhid2Mxand6eHBRZUVmZWtEeUVRSGZPcnhCa0RGNUNUcGV2OW10?=
 =?utf-8?B?bXBRWlZvWTArMWIxNjRmMGdxZExjdExjeHplVGkwQTFyQVJEd0FlUUFJQVg3?=
 =?utf-8?B?Z2IySGM3c294c0JGZS81SUh1dmt4OU5jU2UrMkxhMzNrenZ1Ry9LN1ZLM3Z5?=
 =?utf-8?B?U1R4bk5SV1pUeUdSZXYrVkdSOUlXb0FoV3R0WnVUL1V3TWZaUnYwdGwzd1lD?=
 =?utf-8?B?R2NJNXNlNkRXc0RXbXlWMVVuODcybmFqV3VrMktFMVczRjNJbnFLd2w3d3dE?=
 =?utf-8?B?TWpjQnE3RUxNTVUxODVkd0Rud3ZSSkJrZXNPYmtvS3JudzBGRnN6eVdNZTNy?=
 =?utf-8?B?czZwN09yM2tzNHJwMmtpTlpTc1dHQTFuSFV2RWxzTlFxRzA3UkoyR2cyZlk4?=
 =?utf-8?B?VTdqMFE4b3dzNjFwRHdNVnZ1a1dYOE5jZnoxcExoUitmdE5TSFFGM2EvUkF3?=
 =?utf-8?B?YjhtdXhKTDVhMlRUT0JNTE9yWEo2cXVoRWtVUTBNcWZyVUNZckhaQ29KS1hp?=
 =?utf-8?B?Q3BaMHpuSkQ5ajk1UHVJdXpreTJnZ3lXMEtIbWpRVThFcVBaYVFrZ0ZVeHpG?=
 =?utf-8?B?cFdkTHM1VE9sc1VDc25VZ0cxM2pmUU5kU3JDK0o3ZGJyczNURDIzTUd1SElD?=
 =?utf-8?B?QVcvVWZCakoyYjc3ZldUTk9adjFFK1pHcFdjL2xtSXEyRlN4ZlJkaFgwRTNO?=
 =?utf-8?B?VUFpODlONk5xTjVCYlNkMFU1TThpZGtIcE5RYWdQVWwzaWFZbEFFamFWcGVy?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31597eea-2cd9-499b-cfff-08dd05d70ede
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:38:58.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjmpA7tozi6m6h/eHdkvkZl1s6gr6TBagE0+8URYYfdYgeJp9OLWzi3lXHmhm+oM6EM7Um/xk8bwj56OAOMry4a/pbiIPULsq8g9S70BEs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6955
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> mbm_cntr_assign feature provides an option to the user to assign a counter

nit for consistency: "mbm_cntr_assign feature" -> "mbm_cntr_assign mode"

> to an RMID, event pair and monitor the bandwidth as long as the counter is
> assigned. There can be two counters per monitor group, one for MBM total
> event and another for MBM local event.
> 
> Introduce cntr_id to manage the assignments.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



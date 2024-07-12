Return-Path: <linux-kernel+bounces-251194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317C79301F1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555791C212C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB3502AD;
	Fri, 12 Jul 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMLyygnq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9A1BDC8;
	Fri, 12 Jul 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821995; cv=fail; b=okF61JhiWYDfLr689O1W/8NKB28E4UwY2UylVfTcI9Jog5tvQEIW1W1fFzdpa2Ps7SUReZTr84psKzKNsbf4R8TNlCCrA5UvGmpUmAaMDkUvMJk6srbM33SPAzvnx0MfR/bCxfv+HmZaM5HeplRkDiIAyyLIdswEORK9zGavAGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821995; c=relaxed/simple;
	bh=fWnYckWu1KD/Kw1BP4gbrtNCwBNYMjrcHcw+r5dLJtQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ub/1Qd9PmMf/SsSC/3a83svqfCNPrNLR2P45QR30X3OgaKFlZxLhGVjrykG4+bSASo/yAVcSuBqIfTYbNRs5gGlzLhytHW1/sRE44vZJE8b6w4ZQFpuCKYuNTinbvuXbKMta17o7wG21LbcatAdkXH2rGsPKjechKf+o7j9FVn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMLyygnq; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720821994; x=1752357994;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fWnYckWu1KD/Kw1BP4gbrtNCwBNYMjrcHcw+r5dLJtQ=;
  b=FMLyygnqfYrwkvzizwO/k69tQ85Jb05suBJvf/C21R3aZHRJVVTiP61V
   d0pVuEjdb5+Y3jRwP7HlCKB4n9kqBN3t5fNFrm1YcBh/urtYhfguj8PVB
   NQruWcmmbaGJJO5DA2lWvjGsxAJm9dLA0y9mUz1MAfKopE3P3OGA35wqT
   BUJZbo14HgSIAYrNwORPCKYkkrfCRvXMgUx2O0kqazaZVdznKoYR8rBdK
   z+Fn8IX9ibTaT/etwg6Oz49R8QqIthC6et2CCJLC8c9UC1DF/SwP/fSGJ
   OY77xGgXXE6hjRX8PAab8kKq6SRGxWxubqY5kuHmBIzF/fCtaZxXfyycM
   Q==;
X-CSE-ConnectionGUID: GBwf69TaTry32xp6qykbEA==
X-CSE-MsgGUID: JoqiC/OiRlKvc+IhJDOuWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="35823115"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="35823115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:06:33 -0700
X-CSE-ConnectionGUID: QQaUJ10MRKKRyOGq0i9lXw==
X-CSE-MsgGUID: cmj/tbnUTL+gthtiFXQOtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53404035"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:06:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:06:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:06:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:06:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:06:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JI1RpOQIzKsBiGIRDXVsE83ZKLqn7dSnEiJImSYGSH6ZTQTY8+y6wXJyKjUDZ93TGTvErMqRYAdnwCwfe+IhHT0pPi7bCTjjJ9lj81xHyn6fKbr62kZeKfTeoXNZen5Jlw9hr7F/PNIbdS/gojKxmRjfcIrP9LH5SzDvT1i8vFVFE8iRbgKsMw+04LQ5p0JaZY02j10EdHX1B2y1kR0ipFqXWkJG36YJR6UC9CGsZE81eLEPRf2kvEX6RGEYUmO461E8wf3acR3dZ4/D6ecW+eKRtCWLJnQT8yX7SA5OCeESpT7jVOncfgdIzLR7Wj9t45jMn1NSpM2HGnXE+xbehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rhcoUk2LOFCwEHyuUBA70w7jJPr8mJ+RDFzva2uOWo=;
 b=RM7RVClZVkgoUGZbW8/nucNM66K5Kgnf+f00Y1GeFaYjqApQz+EXOQIKyyRwNA3L13G91/HLM/bsPn724YEkk/+cgcE5Hz0cDIe8xR/YZj3X44Jof7bYIbTFfCM9Auy+mrg1EhMWEe+d15FkMs5mbuKINVfKTXc3kFFE2sa3K3ofZpNmws8ZXn4loDYIHuVfNv3IEeXh3m6YlPomnKittRIWZe9bV3kuKZh96hThy8t1klXMGvK/YtBjgMyT+ijnRNePLPI8cbTz6CRQRW0RHF8kwRFV0JcOHWjcrOrTrLk1fxWsPAhAcaM0nXzSaoUhp9hgJNWJWMtFHadaydy57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:06:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:06:28 +0000
Message-ID: <bad25f0e-8c74-46ad-8bd0-d25f954f1714@intel.com>
Date: Fri, 12 Jul 2024 15:06:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/20] x86/resctrl: Introduce the interface to display
 monitor mode
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <4b8e3a4dcd8b6c7d7ce80a54cd2a129cbd2eedda.1720043311.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4b8e3a4dcd8b6c7d7ce80a54cd2a129cbd2eedda.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 1926e024-5492-454e-85c1-08dca2bee0c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmUrRFBha1BJekFjOVYxdmtralBKb21lNEdpUkxJVmE3NisvL1VkTHRlOWJH?=
 =?utf-8?B?dmVGMmlsYXNkalI3LzJpeDJnU1Z1alV3Rm94c3VlMm9xQmlxdmRjTWliVGhq?=
 =?utf-8?B?TUNldC9zaTU3TDMrV0I3RXBWczB6cFpqd3haejRkbjRyUHFGd1JWVnRrbzZI?=
 =?utf-8?B?Wlh2eGQ0VXl1Zzd3T3dUMTdPVTFoelpnRnI4V1JsaE1CRlRQckxKcGVFaHQ1?=
 =?utf-8?B?Ym5FSlRUTlZLWDJ4b1NZNkpuQjY0SVFrcnBxc2kwNm50YWt1MjNaZWZOOFFs?=
 =?utf-8?B?MWVheXdZVjhxSHI3cS9TUUtreWJWTUpKNEgwcUtvSWlCRmRieVpnMUp3YkNu?=
 =?utf-8?B?WEZKTjRsSCtqMWJjS3l6TDZta3BScFlocmlEcGQ1MW5uWkRJd2w0K3YzN2ZG?=
 =?utf-8?B?eHExT3ljWTVLSmlKN3Jla1lWS0JQSXBJYWo5SzVPWE13T1lnUmtsREowYWd4?=
 =?utf-8?B?cS8xWUxRSDJQL2J0YUN3SEc1NEdJZ2plNnd5TkdkQW5mSy9EdDdlZ3NaWS9J?=
 =?utf-8?B?YzZPR3lWYnVsTVAreDRmWm1aUkhKM0Z4OTVRK2x6dW5BVm1nRGpCSnFGSW9p?=
 =?utf-8?B?TzNPZHdML0NFTVpPd05EZnRJN0tHcTduUEVqV0VKa1R2S2Uyc2IrK05GYVF0?=
 =?utf-8?B?MnlJZHdyczQrS2lHaFl5N2h1YUtlSU41RFJNYzRPVmRmL09lclh1VTVYV1kz?=
 =?utf-8?B?Q01NN2pGYm9DMFVnbTg4bWpKSjk0TnNqdmNhNUhTbVo0Tmc4Z0lMN2VZeThC?=
 =?utf-8?B?YjR2NVpBN1dvdGdWMGlqdUEvNEE3V1FCcTE3aGlxRG02ZkJlV3JoenNPN1Fi?=
 =?utf-8?B?Qk9QUE9FTVJOUEF6RXo3bXIrODUxVmFWTVZsbytoVWV0ZkRqaVBvMTdReGY5?=
 =?utf-8?B?NldnMjdhTjVYYU50OVovNnpvNGJLcEVVK1BKcUVtTWtYRUErYXJpQ3VGUk0z?=
 =?utf-8?B?NW5hU3VaRFpLVkFWNWg2R2lQbm5lNVpKMzhCN0xtZjRZMVBXTXFMWFhjeTRJ?=
 =?utf-8?B?NkZodjBsejduUTRZV2EwbGRPbTkzcmJyMDI5WFd4bVB5OUxpZmdXV1c4ajdV?=
 =?utf-8?B?UFV3RXVOR2RGa003enN3OHo0ZStyamxTTktIelBxMlhmeHo3eHFnZWM5SGgv?=
 =?utf-8?B?OGFVZHQ5bWhRejREeHVLdUdSWFhUaTdjbXZwbEg4QytwV2tuZVBBNlBUdjFa?=
 =?utf-8?B?MlRXQUY5bEdCMEZNYnVUWXVNK1UxdVJ6T0c1ZzdEcjJiVjY0YnNFMS9jelY1?=
 =?utf-8?B?NEswMi9xZjZsc1RBRW5GaXJuK0xmQnJtYkU4ZDNzUjBOKzlXeUl0Vm8xOGl0?=
 =?utf-8?B?dmkxME5MbDlmOWxTL0pEKzhjamtIcXo5dTNOQmZMVlFrYWRQWVZaZG5tUzIy?=
 =?utf-8?B?QWtDRmRqNWs3NEdCQktVNW5Ca2V1WTlQM09LN1R2NHhmczJTaGxRaWNweE4r?=
 =?utf-8?B?U08rTmdpMm1OQmhpUXFsc0k0bGExQUtvZ09wV1M0VmU4UW5naGdWWkJXTS9x?=
 =?utf-8?B?YTVkZG10cG1vUjd2eVU3YmIyWEpVVGkxdG1QeFZVQzFTN3NHVGpLMkIxQlRN?=
 =?utf-8?B?VTBKK1pOVUpJN3N4L2QvSVRoT3lxck1MeE5nNmpQVWFnTU16MlFmQVptek44?=
 =?utf-8?B?S3JlaGhxMGlERWgxL1RPY0FTb214azg4c05IUVdoSUtYZEJ0QjdkVGJzelRt?=
 =?utf-8?B?RHVTRDROd28zLzZTTlUvOGJyMko0UDZSK3ZUbmx0NUJCd2pNalhGZlovWEc3?=
 =?utf-8?B?bkFQdG45MnBTbG5keEFNVUFuL2Exd2h3VFpGcGZBaVlzODlMbEFuK3B3T3gw?=
 =?utf-8?B?TTVwNkl4TDNsaUFUdC9Ndz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JmMW9uSCtKZExueHVNVUFrandZdjhxNzZFOHBTeUlBY1ZkMzc2MllpWndN?=
 =?utf-8?B?bERzbC9QMzZmQjIvbjBtQzBtaE5SNUVCQ2F0VkJOWmp3a1VGb0kxZkExc1ZR?=
 =?utf-8?B?ZWxwWDlJL2xFSjVQS3lseFIwcG1LUTFXOUMyNWNMMHBGODJQVm5rblhiRXp5?=
 =?utf-8?B?UElhcGVFc0dYS3pNdWpWd3JnN09uY1hIRVV5YTkxd2U5WEt5Ry9zUG8yN3pC?=
 =?utf-8?B?L3hnYXhhNnZVUkdQdXpoaVJERjBNRjg3ZzYzVGZSK01sbXU3aHV3ODlZa0Nu?=
 =?utf-8?B?TjVlVnhLVkpTd21FSW5YWjdqeldQT3NpQ08xN0Vnc1h3LzIrZkRSWFFhWkxl?=
 =?utf-8?B?TUZjRmVVTE96Ri9yV2xVSWpjcmJsVXp5ZXZkZHcyU1R6ODdkbnFHTWtZaTlT?=
 =?utf-8?B?R3A0enNsQXQ5SHN3NU0vbWJBc2IrOFJwa0pNZHBEc3kvc2JZS2MyRTA0Z2pp?=
 =?utf-8?B?TDVqeWR1dkJQWkFENmpFLy9BaFc4WWE3TGhBY2xUM3NoRGo3Y015aGJnK3RH?=
 =?utf-8?B?VDRwRnYyRmN5ZGwvZG45NExmTUU5bTVwYkh0MFRQSGd1QXV0VHY3R0daWUx6?=
 =?utf-8?B?WVVnaTNLTVNYUHY3TnUwcFloWWdoKzljV0s5OC8yRlo1aEJYVlhZeUgxSGZP?=
 =?utf-8?B?WlBMd0tyRTVTd1htSnc1WmphdGs4emhMMjhFMUt1WGpHL0laMjlKdDIyRHY5?=
 =?utf-8?B?bmhzZncrN1J5bittOVVway9jRUY4c2hBNTRVNlRUUENCNElPY0t3WlEyNWwz?=
 =?utf-8?B?Y09hY1JuWFloOUd0WmpoVkExdzkrdWFIQ3gwYTVHTmw3M1BlSEc4eDlkQ0Zl?=
 =?utf-8?B?RVIyZjNsSVVRUTl1Y05UVEU2MkVJbHo0a2NJNCtMNmJCc1BvaWdzZVRJU0I2?=
 =?utf-8?B?UGwxU0pHYnZpRFhWL2thM3hoZVM3Q0xicEErOGc0cmpXUTU1QlNZeUh4c0p4?=
 =?utf-8?B?REg3K0VRQnRlOWpRV0U4dDQyK1JNMnl0b3k4YVJqVEdzVEpKVkdMUktWNUlT?=
 =?utf-8?B?K1Z4YkNsRG53VnMwN3NLV1R3b2k5eHJmYlBKODZsRTBhZFV5c09jdHRCY0da?=
 =?utf-8?B?eFNYb1lHdGZpTk1JUlp2S1JRNTZ4QSswc0kyZW1SeHdackd3K3QwZlpLcmc3?=
 =?utf-8?B?Z2RwbHhJYUhzSkE1R3lOTnBVcEs0WTZNbDNPY2Q0NTRlbHhHbnRLbk1mZzhX?=
 =?utf-8?B?Y0hoYmxNTEtWMkt1bGMrSWgvUC9VSXIyNWZmSTI1dG9aZ2x0WEFTTmVoaXVX?=
 =?utf-8?B?SW1wdUFEZ1oxb09xZTBCLzBVemRpWlExdTVva21JQ3MrSHpRZ1UwK2pKVGM0?=
 =?utf-8?B?enhNQlJTbjIwSk9JU2VzeVo2YkNObEkyNEkrK2hQdmtzc1dpeEJJcllkSWR6?=
 =?utf-8?B?L003UE5ZUVB0Mm0zUlBtN2owWTJpOGxsQkNpSjFFU3JlTkhwMVVJMnpKN01Q?=
 =?utf-8?B?UFlYOGNFY1Mzc3Ard3RSS1hKckI4RG1kZkNPL1h0eW14U2JvTzd3MWtZTkRH?=
 =?utf-8?B?L3R3Z3B0OWhjclliYi9kbHBFNzVhZGc0SWtIb3lqMGJUQnhjMzd2czJtSFR5?=
 =?utf-8?B?dXQrLzlPS3cwd2ZkVW1Jb1Y5c0tXc1ZaOFcwUXRvb3hvY28vOHppeEMzMk5a?=
 =?utf-8?B?dVhBbmRqeStVUWxZdEc3eTB3eS9IbWV2T0NvQnVUVkJUbmhwTGt4UCtpTFVN?=
 =?utf-8?B?RVpXdkhuM0RINW9BSUlwbHIwcC9JL2cwNk05dnFRd2Z6QU85SlpFRGEwT1A2?=
 =?utf-8?B?UGNFUzgzYThHOWoydXdOWm0xWktYQTdjUngxT2F6bVZOTFR1VGFIR2UyZndp?=
 =?utf-8?B?aTEyTWIrZ1BCUENkeTcvOHBWS3NaMVpYSy9Yc08wTE1lNVo2RDNnVml6Q2V3?=
 =?utf-8?B?eHFSeGJxU2xFQnVkbGx3amYxVGFGY05vYjg4eCt5QTl6Y01UZFdROUozTmF0?=
 =?utf-8?B?QllIdDBpWjZ6azNlWDh5a2VvMk5OeFV6cE1lQ1RiM2tzU2ZadG9wTXhYUjJs?=
 =?utf-8?B?TUN0MjJvSlRaaEFkRU5ET3FQNzRVa2pkWFAybjNlc04xb1RCaTVyZVAyZXpq?=
 =?utf-8?B?YWlrUHQzaWdsMG9BbHJGMmJIRzI1S1QrcXpHTzhCQUJSV00ycDd2VHpmbmpI?=
 =?utf-8?B?RFZMNHlmblZsWmttVGtxZjgxZkFwK29LR0UzMXdWTityY2ZVcDI1ZkJhdkVX?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1926e024-5492-454e-85c1-08dca2bee0c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:06:27.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Scr6RbHJkxPjE34Uy+RbyuUYbIKyu2UfNzMREMtha37qzmfCfx8ZdRXrtD+L1jqZrOwbB2zH5nrS/LDYIAxrxcJySTcIWeJhZmVsF6E6Png=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as it is assigned.
> ABMC mode is enabled by default when supported. System can be one mode
> at a time (Legacy monitor mode or ABMC mode).
> 
> Provide an interface to display the monitor mode on the system.
>      $cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>      [abmc]
>      legacy

<insert snippet about what happens when user switches from one mode
to another>

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5: Changed interface name to mbm_mode.
>      It will be always available even if ABMC feature is not supported.
>      Added description in resctrl.rst about ABMC mode.
>      Fixed display abmc and legacy consistantly.
> 
> v4: Fixed the checks for legacy and abmc mode. Default it ABMC.
> 
> v3: New patch to display ABMC capability.
> ---
>   Documentation/arch/x86/resctrl.rst     | 30 ++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/monitor.c  |  2 ++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 26 ++++++++++++++++++++++
>   3 files changed, 58 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 30586728a4cd..108e494fd7cc 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -257,6 +257,36 @@ with the following files:
>   	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>   	    0=0x30;1=0x30;3=0x15;4=0x15
>   
> +"mbm_mode":
> +	Reports the list of assignable monitoring features supported. The
> +	enclosed brackets indicate which feature is enabled.
> +	::
> +
> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> +	  [abmc]
> +	  legacy
> +

"mbm_cntr" mode can be documented here with the details on how AMD's ABMC is
one example of how it may be implemented on a system.

> +	The bandwidth monitoring feature on AMD system only guarantees that
> +	RMIDs currently assigned to a processor will be tracked by hardware.
> +	The counters of any other RMIDs which are no longer being tracked
> +	will be reset to zero. The MBM event counters return "Unavailable"
> +	for the RMIDs that are not tracked by hardware. So, there can be
> +	only limited number of groups that can give guaranteed monitoring
> +	numbers. With ever changing configurations there is no way to
> +	definitely know which of these groups are being tracked for certain
> +	point of time. Users do not have the option to monitor a group or
> +	set of groups for certain period of time without worrying about
> +	RMID being reset in between.
> +
> +	The ABMC feature provides an option to the user to assign a
> +	hardware counter to an RMID and monitor the bandwidth as long as
> +	it is assigned. The assigned RMID will be tracked by the hardware
> +	until the user unassigns it manually. There is no need to worry
> +	about counters being reset during this period.
> +
> +	Without ABMC enabled, monitoring will work in "legacy" mode
> +	without assignment option.

Let "legacy" be a distinct mode, instead of an alternative to ABMC.

> +
>   "max_threshold_occupancy":
>   		Read/write file provides the largest value (in
>   		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 12793762ca24..6c4cb36b4b50 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1245,6 +1245,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   		}
>   	}
>   
> +	resctrl_file_fflags_init("mbm_mode", RFTYPE_MON_INFO);
> +

Is this special flag assignment necessary? With file always visible I think it
can just be initialized in res_common_files below with the flag already assigned?

>   	l3_mon_evt_init(r);
>   
>   	r->mon_capable = true;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 471fc0dbd7c3..3988d7b86817 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -845,6 +845,26 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>   	return ret;
>   }
>   
> +static int rdtgroup_mbm_mode_show(struct kernfs_open_file *of,
> +				  struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	if (r->mon.abmc_capable) {
> +		if (resctrl_arch_get_abmc_enabled()) {
> +			seq_puts(s, "[abmc]\n");
> +			seq_puts(s, "legacy\n");
> +		} else {
> +			seq_puts(s, "abmc\n");
> +			seq_puts(s, "[legacy]\n");
> +		}
> +	} else {
> +		seq_puts(s, "[legacy]\n");
> +	}
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -1901,6 +1921,12 @@ static struct rftype res_common_files[] = {
>   		.seq_show	= mbm_local_bytes_config_show,
>   		.write		= mbm_local_bytes_config_write,
>   	},
> +	{
> +		.name		= "mbm_mode",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_mbm_mode_show,
> +	},
>   	{
>   		.name		= "cpus",
>   		.mode		= 0644,

Reinette


Return-Path: <linux-kernel+bounces-533702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BEDA45DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF5D1888BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEF2217701;
	Wed, 26 Feb 2025 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWvQr4j5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4DA215F7F;
	Wed, 26 Feb 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570829; cv=fail; b=ZglNkO/to6ApoKbH16lR1S8EAfE+/TOaomDC760qKT3oX3r4uyhPs8LqxKzo1c9x0XeDToceddCxolcPtgEYpGk+yCCOP5HmvW3Nw4F21rhnmZJG3s5fZ2InG44atKWVW7BBJfYitCwriN28jpF452rshsjhOnSKxIDG1fLy43g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570829; c=relaxed/simple;
	bh=3Y/kG+ir+Ci6po2nsQyHK0moSPFd3HDZ4ni7fGq0ZEs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fuh4s7gRYHkzqUsSDc3dXHTvAUaeV3Ay63gfaboGZ+rb2/y9ObHcTyVotrPZfDqnivNdER3zT07ncxe5yscS3eJSfBb4WhVjAAYJXjOCilLNFMOeFXWsugZK7ku9psB92Bd1GhI56QuxuCWRLHo6EsdbB72UB/+e/Ke1DR2ePwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWvQr4j5; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570827; x=1772106827;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3Y/kG+ir+Ci6po2nsQyHK0moSPFd3HDZ4ni7fGq0ZEs=;
  b=dWvQr4j5mlm9lp5OP4UuTQwlWg8IfxOBmrRClsHt9C3KmkMhNJP5OWMG
   hFnz0jBgEPnLkKdbc/3vfSR1HXwsUItZNKfwcvBYIPQX79IQEb3sDkftA
   Wwmft4pwwg787lNV2nos6kNw9ozTNqHgbpmq4Wia0xBMi4+ML5y8/VLn7
   fvTip3XGQvsp8lfOv4owu8rJKNIBmKklmUCixlKgZApuFtpSIGs9O32dq
   lLhATxZrYZhcoYaEN27k9KTENbCsb2DdWZBKyH9MmWF066olhvStzE/co
   dP0s7WBzvfP8g73wfTgLcKRvKU7QFhT5JOsdMhZ8khPKn8xFV3Qm6WBkQ
   w==;
X-CSE-ConnectionGUID: Ii3VGf2jREuI4N7d1YFA1Q==
X-CSE-MsgGUID: RPJHwhTsTw+5DpQ0HiDIdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58946671"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="58946671"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:53:46 -0800
X-CSE-ConnectionGUID: JV0dyDJqTtOtICKOVLhkLQ==
X-CSE-MsgGUID: Sqb2XMdSTGyOWRZ6JswYmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116492901"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 03:53:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 03:53:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 03:53:44 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 03:53:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbDDK+XkH1R9b+SF5db/FH6Zo5zEhQVdRWf05tmTBoeKLbN1acR8b8oCabY8HbMOIOEBYJryxKnR+flboz9TMFCXf1iIAd0aoHFK8C2akBgrXMULK1RuyImzOOXNGoJC/AMLIMF9ZkQlu0unLijcZyL3AvnKktSobKPINM22BL/CyLAOEl++3h+dzJdX+bnHmAugOFMs8DM01rPS0zE8CATZRpJ1cOzIHnDO0YhHxPdoNIJAY6AaqKroiWSxn5OBJ6Yflzcovmcjnu5V0VITlhdKaeJFKJ+/tl7I5ea9DHsMxLa+rAiVHyy70OQokMzskupMcalbb5nqgoSDZNBkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2tMdKQ9QONiiRKOvsiAHyE1lz0jk6878oFS8pM3ByQ=;
 b=O7j+USJlIFjtV7RJ5KcdMKkzkzBkCAWs+QqhHeryX/m+MS6nilyTOb4lEKosSyqIO3/q52JBCsN+5amaK0rFW/X7u9sn8jtl87EKAtxDX4Lu4gO6vHqgmmydVGlPCWmxsWdRYVcEJuo3ynp0yN3n0pbs8yLtr8/9GZKEdEy5O9DCmCYW1W8cePQibUuknZMLQ5tUQ339z00gycjql6GfwsZddmM52umJX31TKZsFSjxrxMIYx/viJ9dB5yxgXi1Mgc7wuV1sR8mgNvvIcXF669ks6ixHzP9LCAWACCBIMhYR4rbv5nCAkjcOjERvzWJDvZNW7+c0O3Y5rmFoOWBbxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 11:53:14 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 11:53:14 +0000
Date: Wed, 26 Feb 2025 12:52:38 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: <kees@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<kevinloughlin@google.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<justinstitt@google.com>, <catalin.marinas@arm.com>,
	<wangkefeng.wang@huawei.com>, <bhe@redhat.com>, <ryabinin.a.a@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <will@kernel.org>, <ardb@kernel.org>,
	<jason.andryuk@amd.com>, <dave.hansen@linux.intel.com>,
	<pasha.tatashin@soleen.com>, <ndesaulniers@google.com>,
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
Subject: Re: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
Message-ID: <ffr673gcremzfvcmjnt5qigfjfkrgchipgungjgnzqnf6kc7y6@n4kdu7nxoaw4>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <2a2f08bc8118b369610d34e4d190a879d44f76b8.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZdtJj7VcEJfsjkjr3UhmkcKS25SEPTs=dB9k3cEFvfX2g@mail.gmail.com>
 <lcbigfjrgkckybimqx6cjoogon7nwyztv2tbet62wxbkm7hsyr@nyssicid3kwb>
 <CA+fCnZcOjyFrT7HKeSEvAEW05h8dFPMJKMB=PC_11h2W6g5eMw@mail.gmail.com>
 <uov3nar7yt7p3gb76mrmtw6fjfbxm5nmurn3hl72bkz6qwsfmv@ztvxz235oggw>
 <CA+fCnZcsg13eoaDJpueZ=erWjosgLDeTrjXVaifA305qAFEYDQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcsg13eoaDJpueZ=erWjosgLDeTrjXVaifA305qAFEYDQ@mail.gmail.com>
X-ClientProxiedBy: DU7P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::28) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6dc528-2ca6-4570-5f73-08dd565c2662
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzMwenhObjFDU1NKMGtLS3dFWE9oSVVEWENBOHRWUE5obHNMakxpL2ZGOG95?=
 =?utf-8?B?RU9DSXpUYzRBQXJrUzRaQWpRMXB0ZWJ2ME51RUkrbmFuZURYRnNNUEFsd0hT?=
 =?utf-8?B?dVBTR2lMRFNmTXp5QnBCRDdYeU4vNTJlc1h6NmFaNG5hRHM0aitOS1JjLzc3?=
 =?utf-8?B?NzZYMlRRbmpXVHNnSWllOWt1eHBucDRLRVNiTEErMGVrdmVUQ1VHMU82NThq?=
 =?utf-8?B?TzdpSDhjVFJyOUdIdVpBd1hYNVRjdmhJc3orN3JNdFFrdTByYlExbWJpWXRW?=
 =?utf-8?B?bk00L0RZN0dHVENsTW1vU3hIN2JZc01nZ0cwSnlpT1NpdFRBZWppdnhFMGhm?=
 =?utf-8?B?NndDeEJLYVJVTGhFMmsvTXA4S2JvK2RrcHp4VnJFTHZCMnprU2lsOUZSb0xq?=
 =?utf-8?B?eUp2STA5SUJCZ0tSK2s0WEYraUZ6SUhueXhodzBIeVg4aDJBVG9EbEJaZ3Ji?=
 =?utf-8?B?aGx0ck9mTWZUWGNtM3JHZFlFMmphTHNJY3lUSktVVmEwNTVLMWhzeDFJTysz?=
 =?utf-8?B?V0UrRitQdXJuSzRnQ0RYU2NHZ2lsVHNCTkd5a2ZXTjZkMWxKQjBtN3J1RWlm?=
 =?utf-8?B?bGlPLy9lTUZ6T0tEZDV5d1JNWkFvNUdsMVNUb1l5OGU0UjF5RkpGZW5CbUxn?=
 =?utf-8?B?RkdUZW5qQzcxU3pUaHVEaE5QSXdGMk9DZTVQVDhKbnlMRkx4TWZ4OWdvTnR1?=
 =?utf-8?B?cUs0QlQ3SGVTTDhycERHZ1hsc2lvWXkvSTRJOW1GWWpxSFI4enFRckl2UkFL?=
 =?utf-8?B?bCtmWjd0SE5aaVNpR3ZvUVhra2NXZ1ZYd3F3L3pyUHYzdnBDbnhyVmJWT1NX?=
 =?utf-8?B?M3BkWC9mMFg5TkpUdVJjTnFKNkc0Q1UxSFRkc2Y5b1ZhVFNsN0lDV1BrQzgv?=
 =?utf-8?B?T0tKYitobzBUTk4vUkRPSDFIT29MV2FrTDlYS0dER3hyaE16TWthUzJSdnZj?=
 =?utf-8?B?UUx5eEw4ZjRRdEI2Z0tCT3ZPMytyR1RhaG1BZmhhN3Vobzl2OXZoODVmYlVq?=
 =?utf-8?B?SVV3TDhvdFkrRjd3Wms0eG5QU0NtV1B6a005NEwvNmpQRDNsTDU4WmM2eGdC?=
 =?utf-8?B?UHdMem5NTUMxL3hZRXUyQlRYNEJzVWgzbUNRUVNMN2MyOWc4T0JuTUFsK2tu?=
 =?utf-8?B?b3JSbG1UVTQrWXI4M1IyOWlDUWVUcEFnOGgwcWk4TEFPYWk0VjJhQVFKUitY?=
 =?utf-8?B?WE5QbGcwZVZiT05IOFNySWsxOWFoM3VwTlpZUk4yNTJsSW9KVWdIaFpESDhq?=
 =?utf-8?B?T3ZVc1NkbDhnVjF2bkJqa21uTTBPUytxYUFDS0xBcVRsckVaQXk0OExGeVdi?=
 =?utf-8?B?aEYrMjJjTUlIcWlUOFd0MStZZTh3Vzh3cHcvMzUxUmRXR2NBKzdnRG1FT0Jx?=
 =?utf-8?B?TVpCa0MycFhNMGMvMTIvY1J1UTJNd05PS1BlU094djNlcEFOM1haOVR0c2hS?=
 =?utf-8?B?NmlQUmRWRkdWait3dUc2Nkp4STJONmE2emVWYktKcnFNamdEeVk1ZTlub25G?=
 =?utf-8?B?RHpsN2NjK0w3T3BCeEEzcU5VNmx5YitSMENraGMyRWltaURPNnhwUHNXckV1?=
 =?utf-8?B?VGtUUmlNNE50UmNQMnlOT1JHM1lPNGxMQVA2NWRGZFBhUEdBeHV3TUdkTU9Q?=
 =?utf-8?B?b056QnhqWWVnR2F3QVd3ZDFzaGlobmlZRUxZVFoxSTU3UFBuRkFzY2pyankv?=
 =?utf-8?B?OC8xNGJZTDNQb2hWN2MwazkxRy8wMitUQ3AxZlluSi9wWlVPakpRMC9Lb1Jy?=
 =?utf-8?B?dklDTDBXUWQ3eEtpeTYrbkZZYnFGbndXY1FiODRQdXM4SFBYeXQ5ejk0SUtG?=
 =?utf-8?B?YzJRY2JYQWpHWHM4ajJhYXRaZ05SaHFrY3ozdTRRZDc5bjh6M2psVEhCZkVy?=
 =?utf-8?Q?v0BNMvuw1vC+E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXdBVGovbEJKZ1YyQTViR25DRmRpYUlpT1JtU3dWa0VFMUZBNlkvazdrTks0?=
 =?utf-8?B?dzYvTGU1dndnemZ6UmxmRFVGcFFYbE15dTAyTGVhMVRNcjRTNDlhMnYzU3Ru?=
 =?utf-8?B?SElDTkczV21hR2FvVkhhZ1JXUXRlMDVvOFNtVEFYeWVXUDArWSsvNkRFcG1V?=
 =?utf-8?B?WVV3T1l1QlVYYnhRSmxDK3l6NGs0aG1iZXJNdEk1S1p3am91TVdhLzFMVWQ5?=
 =?utf-8?B?L3lSY3RRcG95dW1sd0t1K3JlOGpyQWU1czFaVzNwU0tZU3dEbFdrTkg5aGY2?=
 =?utf-8?B?d0FhSUdUc05MY0tGT2FGMjg0ODJrQjA2WTBLWkFwdmFQcXRrSjBlclg2aGNT?=
 =?utf-8?B?amo0cENyMlNnRVNjUzRZQjdFMHFpRHlEcEd2SE00YlBiZU9Ra3FFYUZZekp1?=
 =?utf-8?B?MkZGdVQ5QkhXRk9tT0xwZTdxZXBuTDNoTUtZc294WkpSR2tOWjNDRlVXOFNX?=
 =?utf-8?B?elAxdWRlNzhYNytlazVxeWpuODFvSzF5ZmN3YWFVMzhuMUlVZkJVblQ4VlVa?=
 =?utf-8?B?MkdETHNIb2ZacUZaZjJ2SUpnc0t4UlR4QzlMM0o2U0tNRExuWEtwa2dkOWZV?=
 =?utf-8?B?RFRPdHZndUV4T1h4ODI3T3JCQXZRK3lobVZUZytrVHdMMm5IUXJ1ekhINjRY?=
 =?utf-8?B?YUF2Q0UvZEt1K1FSTStzbmhCLzlqeFdPaTFaVTlXVURPMlhaQ0JaQWpKM0ZV?=
 =?utf-8?B?Qkl3bi83dkRvNEdEVkNxYWNrRmxnZUVLd0gvelpZOXpSVm9hb1F0RXZvbnQ2?=
 =?utf-8?B?UVRKdndxKzZ5RmVNcEhrQjV3MUJaT2pBVFdkWjRZVXUyd21hZXZkTUJ5Z29O?=
 =?utf-8?B?SnhUS1I3SmZSRU5PdjdLOG9zQkVCejNsWTNBdmlOZzRrYkR1MzBkOHBVMVYw?=
 =?utf-8?B?QTQ4S3RxT1VqUUdMTWd6MUlIbWc2NnVhYlBYUjY4Vy9WTGF6L1ppTEtIc1VL?=
 =?utf-8?B?U1docVQwQ0NQeE01Z0pqYzIwWGcxMDNScE5EU2VxZXFESUNKTTNJVEp0amhK?=
 =?utf-8?B?RTIyTVNzRWVOVS9iSThjODdzZVlGNm1UMjVFWisvdnh3TkE0RitRY3U3dFBD?=
 =?utf-8?B?ZExzcjVpWm5QbU11TzZ0bGJ0ZEd4a3lBWi9DckVKbWxSU01kbUJCKzBiZkR1?=
 =?utf-8?B?SlBFcW9hRFhYUUIxWEhPbG5MTUFsOVg5b3R0ZzJhc0ZudndGZnUvSVFMT0dn?=
 =?utf-8?B?WjNyNlhRejJrZndSbGJTUC90WkVieVZxZFVPQ1lVUWMxKytONGpRZUxJR3ZP?=
 =?utf-8?B?NEFWTkhZb09OVmQ3eFJ2eVZyczNhQjdrUnhraDhIQ1gxQ2t1d0FsdjFIc3Nw?=
 =?utf-8?B?UERtc2tBSnRJU1M4QXlnejhMME8yaWs5ZVN2YW9QSTg0emJ3eDdESHJ6b2lD?=
 =?utf-8?B?TjNBMGY2d0JFZzFOUUNrRjRzSTZVVTh3Y0x5UDRTU0pTNkJieXFtdnU4RkF6?=
 =?utf-8?B?UWNXa1RCWTFZc2JWeVpjNGFlN1hna3lqTC9YQktJa1Uxdm5CQnB2dzBzT21a?=
 =?utf-8?B?ME85TldBVS9Ec3VtdEJ3OEN0U2lya2JFTmUrOVA3M1gvUGptdEJBWTZCSCt5?=
 =?utf-8?B?Q3A1V3dCK2FJOGZxbS9NU1U3YSt6enk1WEVadWZpN1dyblc4QWdGWjkyRGZP?=
 =?utf-8?B?ZktzUHpjVHNpRHJvMG05cEowL2lNUnhtVWdacDJGVDVXY0c2aTV3bHNIem41?=
 =?utf-8?B?bTIzZ0JzWXYwcVdMdVdnaEJOZ2l5SGdDL0ZRSzE2SElPVkp1MTFzemsvZm5Y?=
 =?utf-8?B?T3NzZHQ1UUE3Wmc5ZzZpOEFucjZBRjVpNzFUZzFoWS9jcktHSDNrVXVaVVNV?=
 =?utf-8?B?ODBDRmJBbUQzSjRTZVhBV3BUSTdRa1dNSCtkUEtlQVc3RUJjUDlLd2syWDEv?=
 =?utf-8?B?S2hlR3hHZU5YQVYwR1QraHJnTng5eFFLNlZuQWlNRENjZFhTOVJITi9kbjJR?=
 =?utf-8?B?SFhQU0VjbHpRSDFHSGZGMUROc3NaSENuV0tkcnBBS3lIbEVkNnhsaHk2RzZr?=
 =?utf-8?B?RW1VeWhvd2xNZk9QcEJtWWNTcmpoV29hUnBzODBNUVM5MG54aWJtUHhqODZp?=
 =?utf-8?B?NEdta1B1WEJEeXdZVXZteWZwVkRHUVIvWC80d2V0aHlLN0g2Rmg0aXVzc3RS?=
 =?utf-8?B?czN5YkdLRnNQOURlNVN6VnVnUkhETHg5MHc0ektlc3F5RTliMWtTa0syR090?=
 =?utf-8?Q?UbH/TTlfUfpckBBahXJaF8g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6dc528-2ca6-4570-5f73-08dd565c2662
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:53:13.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uU/OV7CtoiGcNJBNAIvH2vLAR8zYTMzn0VNuqoKnImVf/UmY3d8Gb+BYhVJPNlICwiBMYbfpGJFeQpZgsOGS4BbtP5u2c+9TSy77U6ZT4JA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741
X-OriginatorOrg: intel.com

On 2025-02-25 at 22:37:37 +0100, Andrey Konovalov wrote:
>On Tue, Feb 25, 2025 at 6:16 PM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> I mean in my tests, with setting offset in runtime, everything works correctly
>> in inline mode. Even though hwasan-mapping-offset ends up empty and doesn't end
>> up in CFLAGS_KASAN. I assume this means that the inline mode is pretty much the
>> same as outline mode with the runtime offset setting?
>>
>> I also tested if hwasan-mapping-offset does anything if I passed random values
>> to it by hardcoding them in the makefile and still everything seemed to work
>> just fine. Therefore I assumed that this option doesn't have any effect on x86.
>
>Hm that's weird. I wonder if inline instrumentation somehow gets auto-disabled.
>
>> Hmm indeed it does. Then I'm not sure why I didn't crash when I started putting
>> in random variables. I'll dive into assembly and see what's up in there.
>
>Please do, I'm curious what's going on there.

I think I figured it out.

After adding
	kasan_params += hwasan-instrument-with-calls=0
to Makefile.kasan just under
	kasan_params += hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET)
inline works properly in x86. I looked into assembly and before there were just
calls to __hwasan_load/store. After adding the the
hwasan-instrument-with-calls=0 I can see no calls and the KASAN offset is now
inlined, plus all functions that were previously instrumented now have the
kasan_check_range inlined in them.

My LLVM investigation lead me to
	bool shouldInstrumentWithCalls(const Triple &TargetTriple) {
	  return optOr(ClInstrumentWithCalls, TargetTriple.getArch() == Triple::x86_64);
	}
which I assume defaults to "1" on x86? So even with inline mode it doesn't care
and still does an outline version.

I checked how arm64 reacts to adding the hwasan-instrument-with-calls=0 by cross
compiling and I don't see any differences in output assembly.

>
>> But anyway I have an idea how to setup the x86 offset for tag-based mode so it
>> works for both paging modes. I did some testing and value
>>         0xffeffc0000000000
>> seems to work fine and has at least some of the benefits I was hoping for when
>> doing the runtime_const thing. It works in both paging modes because in 5 levels
>> it's just a little bit below the 0xffe0000000000000 that I was thinking about
>> first and in 4 levels, because of LAM, it becomes 0xfffffc0000000000 (because in
>> 4 level paging bits 62:48 are masked from address translation. So it's the same
>> as the end of generic mode shadow memory space.
>>
>> The alignment doesn't fit the shadow memory size so it's not optimal but I'm not
>> sure it can be if we want to have the inline mode and python scripts working at
>> the same time. At the very least I think the KASAN_SHADOW_END won't collide with
>> other things in the tab-based mode in 5 level paging mode, so no extra steps are
>> needed (arch/x86/mm/kasan_init_64.c in kasan_init()).
>
>What do you mean by "The alignment doesn't fit the shadow memory size"?

Maybe that's the wrong way to put it. I meant that KASAN_SHADOW_END and
KASAN_SHADOW_END aren't aligned to the size of shadow memory.

>
>> Do you see any problems with this offset for x86 tag-based mode?
>
>I don't, but I think someone who understands the x86 memory layout
>better needs to look at this.
>
>> Btw I think kasan_check_range() can be optimized on x86 if we use
>> addr_has_metadata() that doesn't use KASAN_SHADOW_START. Getting rid of it from
>> the implementation will remove pgtable_l5_enabled() which is pretty slow so
>> kasan_check_range() which is called a lot would probably work much faster.
>> Do you see any way in which addr_has_metadata() will make sense but won't use
>> KASAN_SHADOW_START? Every one of my ideas ends up using pgtable_l5_enabled()
>> because the metadata can have 6 or 15 bits depending on paging level.
>
>What if we turn pgtable_l5_enabled() into using a read-only static key
>(DEFINE_STATIC_KEY_FALSE_RO) instead of a bool variable? Or if that is
>not acceptable, we could cache its value in a KASAN-specific static
>key.

I think this was a false alarm, sorry. I asked Kirill about turning
pgtable_l5_enabled() into a runtime_const value but it turns out it's already
patched by alternative code during boot. I just saw a bunch more stuff there
because I was looking at the assembly output and the code isn't patched there
yet.

-- 
Kind regards
Maciej Wieczór-Retman


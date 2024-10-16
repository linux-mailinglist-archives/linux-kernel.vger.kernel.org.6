Return-Path: <linux-kernel+bounces-367167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6099FF54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D772C28614D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F417DFE9;
	Wed, 16 Oct 2024 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aldJr/a6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA021E3B6;
	Wed, 16 Oct 2024 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048762; cv=fail; b=FM/OpOSSF9hS3yp3yarvlrTl7mw2q9xyu1i+NKLwjOhiYMMoKtxBcVzO1xYBPZbWRPm6N8AbU7Iy4gcsvd/QbHiM0YqwhkMTXTMgHU3UqKTbCWrvgfJ6IS5fHietyfG+vRm8woM/tvThjN259Ds4yPo46KUcID5rpjn6DyNJaoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048762; c=relaxed/simple;
	bh=KHXoo73CG8bnoJR4R4kXP8tWEGHVxBud5DLVtMdWxOo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nlq8nEwZHy1vzBMMWj7zxOya6j+/V/WG+L+uHjpkPkNXm8uxjPhK5wP73U/wawGNQW2V6BnYUXOuJEzghloO0lGNUG+e8Uh/Lb8l01HEyzKYi+wrSAEAPB0uhfvN5Ju1qQ0VwQw/bcAfSOz/FIqTmw9p314SYWzoJ0U+KBtEm6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aldJr/a6; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048760; x=1760584760;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KHXoo73CG8bnoJR4R4kXP8tWEGHVxBud5DLVtMdWxOo=;
  b=aldJr/a6OMdQH0XHLId1Y0ZfMp4S6Zg5HRxpJNRjYP+UKbOAQ6qKywfh
   N98T2iNSErWEH/QgcenzZfB3KLnnzzkBtE49H1cHEg3vTiBIJ0nfFvhs8
   rVvTMQ554moHcsQ7ZDD0P+6MJT3zRFCRVIzgQS4liJYGCqzMmEoe8DIPV
   bzte3KHaFnpS5epJz2pP8pSR0XRdtubQhXn0jUB59dXlchhhbqw5n4SQe
   p/mqHlBoaOic/d+dBBjmU//5OUjXIFxZTWOWbPd3Z3NPav/o2gkV1ysw1
   W6IEAgWgIf6MgXmafw7s5qHucdaLouSsG7VaYmNEOhw/mG8afuOvFebBs
   A==;
X-CSE-ConnectionGUID: KXEyBH/PTNClLSpqKAWEnQ==
X-CSE-MsgGUID: 5UULmsukRTOo9glM3gXNFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32170873"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32170873"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:19:19 -0700
X-CSE-ConnectionGUID: Mt164ZpXT7qklsG0JqiGtQ==
X-CSE-MsgGUID: WGAmAgeiQ2GYipOq1LHSQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77765414"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:19:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:19:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:19:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/HXhjpCw8VYyz2rMZEG7WgJqyr1PZ1rOFYYsJMBOIZmIFvDUS4r+jkDoOrFuQ1XS4XKQl1nnn4CPL+YKA19mqpM+J8B/a3ZdD2GLrl3NvqI/gM1ARLW/yIY4xEIYDgpYwLNVJn64ag8deykVRwFibobje0iPs/01s+NoCAN56brfffHOOSAQ5trOxInz0CMYffR4v5+e7dbX1SRg5AQbIPmwR3WCaPHP4y5020BsFks21njbO489BS9vWEFbeqWff01KjhPdfo99+SsswubjQzIlpJKeT2pa+qUL8KojCqWJyJ+VMOVrtTg5A+ps5pFE+L2RfmM6l4jWbBdA/W8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoiiytKq4zWU6bIKfHvphV/H1u+iQXE4cokpWAQD5Ac=;
 b=kgnfMNnc29mptC7XPhHg4Fmx9VFN9pweEnyo+Nu6pmNMcv5TfgeihfwITf1TkpYe6r6hN1wtznT66dWP1d9eKArgyCBJ1bt08QDGQHsAGVhsQUUMz+7czdz0InIfyRFVeOs3HfZKZOyyR7p4aqImGw5oJWGOT9l1l1K80siIaPIql4uIjeMizBzx7dtKalHEPu6GKVaWLEN/nRRhXt6jS5e9/s/JrkR/kdPOD178zm58T03Xn+BM26/YChw6V0VeONyn0cnh04sGuflzrREr4TB5vHtG6q9y/VZSczMZg4pVdkuElqH179OC6GOEACsdHM9j1Kq+nQxyYMftQYd0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL4PR11MB8823.namprd11.prod.outlook.com (2603:10b6:208:5a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 03:19:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:19:14 +0000
Message-ID: <12413305-d795-4ce0-aa10-fc0ca03463a4@intel.com>
Date: Tue, 15 Oct 2024 20:19:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/25] x86/resctrl: Introduce mbm_cntr_map to track
 assignable counters at domain
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <2362cc9dc2e2e30c560423add198b621ad3d3307.1728495588.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2362cc9dc2e2e30c560423add198b621ad3d3307.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL4PR11MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb0f422-72fc-4868-a3e5-08dced914f98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck9TdUhLL3orUmZSbU5NRXl2WHVrS1hsMDR5N09xM0ZTbWcvbHZBeWJNR3p6?=
 =?utf-8?B?NFJwQTZrTGd4WW5JWXpmYmV1V205Tjc5M2xKdjFTZ0tmL3hJZkhhVnU5RVIr?=
 =?utf-8?B?aXNFeDJyR2lmVDlnYitUc25VanJsR0NhUlU2Y2xpUVBXdnpZbHA1ajNKSFFu?=
 =?utf-8?B?NXppQVB2OWxaZHBhN3hZMzZuVXNYdTJUUTl2RitXaEpDbnRucFY5S3ZBdW96?=
 =?utf-8?B?VEtDb2dsQ2ZxSGkvWFdUSjhSUUE4aGhhZkJEWU5uVEZHUzd3djZpSGJHVENM?=
 =?utf-8?B?UlJIekpSUlVqUEZQaWRXSEcwWWpFV1dCYzZLZWo4Q1h0RnNxeGdiOUN5cVk3?=
 =?utf-8?B?dlo1eU9IR1I1eXlXZUJVR0tyS1dOVlp0OVIwei9nV1pTWFpkNzhpTm43bS9w?=
 =?utf-8?B?VDRnWFNlbnM3azhzeFpibW5kNmk4cW5MVjQ0S1g1TFBVMXZ1Rlh4Q3pQN1RT?=
 =?utf-8?B?RU1IMExvL21KcnlVREtBcmFHajhtRHpXdmZoSkNUS1hkTGo4Z0JCZmZEYnl2?=
 =?utf-8?B?L1psTGdMVXN5ZWowemxob1g4eHJMQ1hPQWRDYm1SL1lDa3VZWFBwV3FxOHkx?=
 =?utf-8?B?SEZ6d1AzSHZyVUQvQ1RXZ0lNYUZpVU9LWS9ZekR4ZGtkc2dIcEllQTc3QzdV?=
 =?utf-8?B?R3hubzNsano2Uy80OGpueFB4N0lvWFdFRjdUZCtPUnNOdXBFaGR6eUc5Z0hT?=
 =?utf-8?B?UWNQNG15UUFZVEtUTW50QVhCalhYWUl3alhsSVVCZmZYQ0xuUnR6cVp6ZG5x?=
 =?utf-8?B?RXBjTmhBOElKSGtNeTBPTVUzQTFQS2lmMG1ER1VseEsxZVhweHhMUkJHc1BS?=
 =?utf-8?B?aEg0bldrMDR0SzVPWFpDQnFod3UrbnIyNysyNS9Oa3RBb2RVWHFMdEJ6K21T?=
 =?utf-8?B?SnVtbCt3T1lUSzNPelprTis5WEZHMVc5MlhyaEt0RXNPWkxvV1JBdUVaQ3c5?=
 =?utf-8?B?OFM1dnM2TkNySk5GenBTVEZib0R1VGkxTDlxSmlqVVdhTks4ejJWSzlBWXlM?=
 =?utf-8?B?NmRPdDRRenJiVlA4V0pvWVJXcHR2dEVORTJ5OVBFSk14dGlHdUhFaDZRUkMr?=
 =?utf-8?B?OWpyOS9wQnRKY0hpUmRuV0gvYzlUNjdMOUJ4VGRXa1kwOW1kQjdJbGppUzBv?=
 =?utf-8?B?Ly9meldzS0VTc2FyNVk5aUMxdXllcUtMcm9aakdCOXhsUm9YdlZ3UFhyclhh?=
 =?utf-8?B?MXZMdVNDWjJzWEI5R0c5bTU0NjNpeFhBSnlaSllUYnJXTCtuUkZ3WWUyMXJK?=
 =?utf-8?B?MmJGL0hSWlZKMnkrU2ZuVENtZnYxZzJaUWhJcWkvK292TklTdVhrdWxWMGhE?=
 =?utf-8?B?L25SUCt6U0JpckZ2Q0E0RHVncXlXNk8rK1luUDZ4WmtDdGs3WEhLVFFSQ3Vl?=
 =?utf-8?B?SlBaK0lFN3J0WU9xdzdkZ3dLSzZwSkY1WGhKQmh3bEZCam1mMi9IcjdxbTdv?=
 =?utf-8?B?eEJYK3RhZkplbjFuMzhzRHF4dUtPazY3dzE2dmc4SlM2aDdwb2ZKZWNPWlZs?=
 =?utf-8?B?RXJNMmhwdFpHRjA4bjgyU1BXcXBxZzZCNVZGMHIySHplM3hhcEhPaHYydVdh?=
 =?utf-8?B?TndzTlUycXg5cjY0bEl5bWZITzZDaGtlSmZ5TDlzM2pFSGttMzJ1dkYrV2p4?=
 =?utf-8?B?eGpzODB2NDRNTUpoZzhpb3JVNkFwRXhyeGM3ME5MQTNsTmJVM05JUFNjdmtS?=
 =?utf-8?B?dVlvYk56ajBnZ0JnUHdTYUZSMGJUWnFkWWxtN0YwNlJMa21pWSsyRk1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFDdmI5cFZUdFAxMTV0THFZK1VheDI0a1NTcnFOQ3FwUEY2Q25Ubm9Ndkl3?=
 =?utf-8?B?TWhsV3ZYM0FBallBL2c2RHhpeEVSWHl0cGlBWkdBKzN3TGMybVVvL0NZZDNp?=
 =?utf-8?B?aFM3N1lDRzJKSnhBZ2JYRFFBYjRaK09ueThlQVRzcVRYWmxvOUNnWG1mdVkr?=
 =?utf-8?B?YXRhMTdoaGVwWW5yakU3V1R5Rk02bWVibnIrYkRvbEI4WG0vcncrVG5tSGFw?=
 =?utf-8?B?TDRQTCtDdVBuZ3VqZzdiZHBQdG1USkpTMmV1UTg2eDVvSU1ZaE5vWlU0MVdE?=
 =?utf-8?B?VDZjcEV2eUdDdUNOK0xxUm8zWStsOWJvU1RnOEd3K1JPZGRSeGMrRTlXRFJt?=
 =?utf-8?B?ZWI0dFpHRFlOenhoNHcyNy9McUE1ZDhUalNVMHIrVERoNkdZbnZzdWN1QVhZ?=
 =?utf-8?B?QXpXZzVXQlRMR0tTeGZ0bWNxUWhidHVabUExM1k4VC9QcFFpZXJueFZ1eFI1?=
 =?utf-8?B?S0JCM1g1RFJuV1ZadmJYZjZiQ05KMnM0bGU3ak04Nk80ei9nVHRZQ2VFOU96?=
 =?utf-8?B?aXF2NG40ZG5tKzJGWW84NWVzQk1VSkQzOEt0dDk4WDZtTm5iS25HbWxMYUt6?=
 =?utf-8?B?bW02dEhVb0hpNGJZdEFuYUIzbGxUeUk3eTMveEpJazVldEo1Qm84a1RNOTJB?=
 =?utf-8?B?S2NibXh6QVVxT3psQVI5RXJ5cGs5N3NUS01NOWVCYStsUzF6OHVUV1VVWlRF?=
 =?utf-8?B?R1RpR0RLTTc0VUVUTUgvOGpXa0lTWjZVM2xnODd0M3JEZkl3YlV5TlBRWERY?=
 =?utf-8?B?bExkYVA2dUhnMmR5cHpLTTRzb0VYbG5aVXQxRVZxTXVMVHF3bmtzODlUTWZy?=
 =?utf-8?B?OENtQkVnQ2JBL1NiNVJNeDkyMTFqWWhUU25PNGF0WTRhcFp2M3pxN2FPbmJP?=
 =?utf-8?B?UGFOOTdxTkVMTkNGTDNjOGZRc2h6YU5SSU43S21RdTh1KzIrZWVlZUdEdW8v?=
 =?utf-8?B?V3Y3YUxCeStnMTdUcVhhOFVaLzhKSGlzakVzRnpWUFVsR0Y4VFpYbjFWTFln?=
 =?utf-8?B?UDNKSVhLOGlQY0M4d2JGSVFVVVJLcGd1VGxKYXB2S2lJazQvKzYwOUxLekg0?=
 =?utf-8?B?eWlWUmpZUXI0bG1EeGFERnJxNVIrUjJ5bHhZRCtWdFhORUQ3TkVVNzBmSFE5?=
 =?utf-8?B?U0h5QXh2RFJ2em4xUjh4ZmgzV2srVEVNWXlFWGF0ald3R2kvQ1dQdVB6VFNX?=
 =?utf-8?B?cURuZnhWcXl2RytLcWtJM3pSV1RuQXZHMjIxNTFLUktOOXoyaFdwTGFBc2lL?=
 =?utf-8?B?OC93WmIzZzA0ZytYd3ZGczlZU0Q0WGE3SG8rbEJKRHlPZnBRdGpHeHRqcjBW?=
 =?utf-8?B?Vyt2K3ZsR1h0c3lIWHY4T0VhcVIrZ0hnVGZSUEVsbHNaSXBhN01JOXc0elJa?=
 =?utf-8?B?bmttekF6VUlqcGJOY2Yvem9wakpuaHhxRzFiOS9Ja0NmU0lsU0M1Z0NwakZn?=
 =?utf-8?B?OUR6cmJUSVRESytxdWgrWGlvS24xQnV1NDlTRnNoMitiNG5ySXJDN3JjRTQ1?=
 =?utf-8?B?SXJTVEpYZVBIV3RNbzYxVUZiVDZEVTR5U083Qzd3NDVzMmxVL3FjSWNQNVps?=
 =?utf-8?B?djJCVjZrUzhEVlZjUHlsOUloc25QbE5iOS9DMHhXMnIwZTc4VkNLQTd6WWhK?=
 =?utf-8?B?NEZrU2dXd0ZjVWhWdWJQd0RnMHo0RFE4N1JJZUNuai9Oa1V3OXkxTW1oaUsz?=
 =?utf-8?B?STRjcFpYTGRpWkhQcEFqWWg5Tm9hN0dsMHQxYXM4RVd6QnVBMG5WUDMrWmJ1?=
 =?utf-8?B?ZTJwNnNka1hIOVI0SWQvNzZDNkkwL2M1eGRxdWF4TDYwUGZHcGNPdlNJbUFl?=
 =?utf-8?B?emp2RkxMR2lPY1N2UDdKcU82VXBSNGVWMDdmQjFMMG5rS0JOWHR1ZS83cFY3?=
 =?utf-8?B?VU9wNnh0UUVFSTdiVDBqS1o5YnVqMkppZ2xFSE40Q3g0MEs2NlBNSnMzSXpP?=
 =?utf-8?B?ZEtsQlBnU3YrRWppSTBDRWVqUWM1V3JzSE9oVU1zS294Z1FvMTRBeExUWm5x?=
 =?utf-8?B?WWZxQ0xvb25telJ2MVZsUmloWVRDcTcveFlQTzRSMlBGMFF1c2VTaWxVOFlU?=
 =?utf-8?B?VVZzU2xiVXFwQTFPTWZMOS8rQVd1UkFBTGJmVGlySlRBU0h2Y0N1cGhDWlc2?=
 =?utf-8?B?NDZPUUFSUndObGFoODdxdGkyZU1VQlBVcTBsQUdpUldFL3VIeWFTUlA5dGo3?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb0f422-72fc-4868-a3e5-08dced914f98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:19:14.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpaYYywAkD3bQLJcFE4Z0tEc2A/v7YVc2Oa7t0YAgKHnW0pLQGGFZvG6G3h9qMXTu/QNma2Y9/3XJ369W1zvR5O0p1uxwu08zO0SwYHg+h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8823
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> The MBM counters are allocated globally and assigned to an RMID, event pair
> in a resctrl group. It is tracked by mbm_cntr_free_map. Counters are
> assigned to the domain based on the user input. It needs to be tracked
> at domain level also.
> 
> Add the mbm_cntr_map bitmap in struct rdt_mon_domain to keep track of
> assignment at domain level. The global counter at mbm_cntr_free_map can
> be released when assignment at all the domains are cleared.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



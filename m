Return-Path: <linux-kernel+bounces-251202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF5A930207
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53301F211F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1159E54757;
	Fri, 12 Jul 2024 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXnA8UNz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC155E49;
	Fri, 12 Jul 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822459; cv=fail; b=SrrElYf+aIDrnxd1riz5vfqBTM+hddjGvvJjkRw/9NsymMo92+6Qp7EAGdvQYvGZfNLUgX7/BKdZ5QROgStR7FlZyYmS0tnrAxn9V7pemBbCdQBOGQZa+tTSkT6ejLZao6tQQWy0gF9rRY6EGdFn5YE0CTdQz++uIGXEWciWZhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822459; c=relaxed/simple;
	bh=t3HEJVKGM4sIZJxsH68PXJx+6WiIoEziTXTj3SY08H4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vh6nMfxcsyh2OhZYSbkleJrQYI4CwhgzYV1TRN7DkjHDH4SB0CVhbX7AfjK/AyAZ1sjhHTr41m5QyJDIJV9dZIlAXc3oZqEMN6d7hF2hO8s6spWqOuYGCo5BgTcRDlkdOrAdkIiRr5vbcSdkicPJ7u0T3ECPs95fSoEZLJwUFXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXnA8UNz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822458; x=1752358458;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t3HEJVKGM4sIZJxsH68PXJx+6WiIoEziTXTj3SY08H4=;
  b=BXnA8UNzYF61gakgRadb/sMDQwA5FclfzvU49RoM4+S22GqCk1yrAXWB
   jvHFkPgQ9s+bCJjFt5niFAA7TOIBnkShEp+R7RTXEeVqUPTlYAgZhCr6A
   yiUKDqj21ZqEUylrOkej5m/rb6PkCIQ+bQwefbtcni5HrE7ug2r7SC1hf
   8e86fL/sHJsw6RZkET0K38u3cQKpOEUUysoKznwFWg+vj4vph4xiJPodK
   EhYXizUCcBtnF8POKC1RaVcoG2+4ew3rLme/k94/WM3BEQi5cnBtnDaPv
   RYWk/Oe/YnEsFw0Bq1iGrEh/jFnXtGN0Lz978qQKk6tnXz9W5D/Qx0GQs
   A==;
X-CSE-ConnectionGUID: G2UDQmd1Q06Ep6WOSpDWBQ==
X-CSE-MsgGUID: PfUlAdaUTQqprLUPiPnsug==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29429913"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="29429913"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:14:18 -0700
X-CSE-ConnectionGUID: e2P7vnX2Q5elXoA8+RcArg==
X-CSE-MsgGUID: bs6GuFfbSw6WzG8O1g7d3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="48986755"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:14:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:14:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:14:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:14:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ2EBh+SBspDbOyLTv4Nv/2gS0UrqU9L5wBaU+GFUH+Ml8mb+tiImuw1Fihc10BqK8ItSj9bOhYR6HFIiEapgw41ucAI/mitbiFixBvzVLc3pf88ju8FaxBTAspRP1Sz0kOB/GczHSXbajd6BP1hPAqbE7RQ+NKeUKSRpzHv3SQEkT8O1jRVLSk/S3oA/XP8YFa/nUXhlUQ+OUYFWtodHNnhEKbUI51mYJgdLWDxAiNYTDfMu6oBhNu8btGUSKGUB52nY9HRUcXCXn6dL0A8bhu0dMtcsKKcFYbNx1LkU7EttKoIwwUl5Fwna5HmZvf+zby0Pwxw42NzMO8vo70reQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcapU+nJzkSvPQ7ENzAplhtI8a3ibcMpz11TvF07yBE=;
 b=YJIGZ0B12oKbWGyqWLSsazJBnlwUJNw/ZePAOswX28Hsr4ziqka45iTzM3vR8tlUqYsW2SpPrnH4ATEh6CLgRNBZWsGmiZt/wT2OgHnwUe6+3qBU+pDD1/xNfypNaw4PaBt06W6e15bPJSo7kbkjKT2Rj35iaV2OqtLHOsUnGxq3iTQbsyemwWhn6TZw72dPyvrEKETZEXZU6iOmYD/NEV9GeqHVCIKq/wNfd7QXPVb+Grp4nvaIkoRnOfeDXwTqNIY7EjgqVDgoz3rrOTMXmAGtMxMWlB1Pxh+on+SteCLEv7rxGQeUYg4+AXLYl7jBHIGECFAl0nPcR02R5verDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 22:14:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:14:13 +0000
Message-ID: <0815b30c-8bff-484d-895c-4f40e9b2d1db@intel.com>
Date: Fri, 12 Jul 2024 15:14:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/20] x86/resctrl: Introduce the interface switch
 between monitor modes
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
 <cce527151843aaa1a6001c75a17ee46108821233.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cce527151843aaa1a6001c75a17ee46108821233.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:303:b4::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c0a098-0d22-48fe-029e-08dca2bff5ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZW9meUdjbFVzcTNueUFodXFTSDJta1JmSTVuVkFLelBvTk9XUmpQK3A2eWMw?=
 =?utf-8?B?dE5Yb1N6NTU5OVhmVWVQTmxLTTVpMXY2am9NOWFvc2RYZVlvcXkxeFU3UVN1?=
 =?utf-8?B?eEwvWnVxSmJMa3M4cC9nODVDb3ZoNGlnTnpuRWUxTzVFS2FEQWxBcnI4ek56?=
 =?utf-8?B?TnNEZTVENENYcVJleUk5Vm0zblBJRTlEZ2pKK0Y4L0JKM2x0TEJ0NnlHYW1T?=
 =?utf-8?B?SlgzbmR1c0xkOEMxblpKWllUM3FKWlF6eEY0NzRBRFl0bDRDZHEyRlZ1QjE0?=
 =?utf-8?B?ZlFDTHRTendvanl3clRraitKUit3KzBuaXJKbEVmN1EwSFJiTHBudG84Unkx?=
 =?utf-8?B?MDhUOVFRc0MwT0tVZGYvTVRHNzVNWHVSQ1dRN1N0M3R1aXEzdmtCS2pwZ1JL?=
 =?utf-8?B?ZEpQTHBhQXV0RlVUZ3crZ29TaTg2eHNDT1dadlkyVnBTVExqMDNzdHhKNGNF?=
 =?utf-8?B?dE1pTHBTWWljUzk4dVJwZEYzMUcvWHdMWGF6TGsrbndpSlVRUW9heUZWaVQr?=
 =?utf-8?B?dHdHNmUyRkVFQUlSVDF4YkM2bVNYVTV2Uk5ZTE1PeFhablF2WCtvVERHNDBF?=
 =?utf-8?B?Y3hQMVFWelBhZlpUbnVwUEZlUllvNGtzY3BtZitrZS8xdEVNd2VDREs5WXdt?=
 =?utf-8?B?bVZsdmtQaGtNaGorQmZ4UXhENWErYXB1NHE1ejVZS1kwa1piNUNubjhvWmVX?=
 =?utf-8?B?WFEvM3NTMEVGcHBzMmRCbXlXVzJDcFRhNFB0Zk5xemo0VTR3N1FqTFFjbmdi?=
 =?utf-8?B?M3YvQ2VuZjVzQmVkNHFMYnhvZGRiNlU1akxVcEVlQWNCT2llL255TlgzODJQ?=
 =?utf-8?B?eGxleHdFbHFmS3ZMVXEyOHQ3Mlg5RFFWeVZ0UkIwZEVpMmhZTmJMOHFxVDBQ?=
 =?utf-8?B?Z3VmQThONVNydmZjcncvaHBQdGFzVXVac1FibEZoNWEwcDl3b0R3NjZkREtH?=
 =?utf-8?B?d1F0czV0bkE3U1dCbURlM2IrQXQrK0gwK3NZWVhkRmI5a3kvMS96SWRTZmhh?=
 =?utf-8?B?dWFOVnRuSVFnZUxVanNORkcyVUVVNFhwZkEzT2puRmZzeHR1UUR0OGFRQlRH?=
 =?utf-8?B?dGdCUEwyZFhaZi9ER1o0OFlsMjBISUlJSjF2STlKOVoza1ZsRkluTDFxSVhr?=
 =?utf-8?B?YWFCU1JNRW9tdzhRdkkvclJOeUpoOU1OVUhRc0pGY3doYU8zWkwxRXFpMTZN?=
 =?utf-8?B?WGs3am1FOXIwUnEyTFNUeHlscG1xQ01YRGZGTVg4enVZSThkNHFHbytEMlIy?=
 =?utf-8?B?cUpFN2xjRmlsd292ZHdlRktsSUtvTmFxZzdOZzBraG5zNXRxNUZ4SWJWbDRs?=
 =?utf-8?B?ZlBCL3AzQ0d2ekovbzVtNHAyNFFWc24xUExOTFVwczVrakg4WEtlOXMvM0Ez?=
 =?utf-8?B?M1hiM25nN1dDNFlqemVFR2FveDhRb1ZPV1hMbXYrNFRTS2JrK0lwMUpJcm5h?=
 =?utf-8?B?TU8wSm5ubUZHN2lHakt5QUowekU1RmJSSnBERkp3Mjl5aVo0WTVCWFNKSzl5?=
 =?utf-8?B?aWZIdElDMkN3RXVITHJGTjhNRS96SzJ3SXdMcy80QktGbDJvaXVXWmFEMTFp?=
 =?utf-8?B?VGlWN2c4KzB0UG85M3NJSXg5b24xN09NR25CMnFBZmZWTkR0WHJmeG1MT3VK?=
 =?utf-8?B?ViswbWJNVGRqZW81c3F6eHA4djY1QVc5SXFzK0VOYkRpZ2cxMHdqMUJ1bzgx?=
 =?utf-8?B?WFVabnhoZHZGTGcyc3E4M1FnNXdmRlhiWklUMjBhVFlDR0xmSXFzbk5aU0lP?=
 =?utf-8?B?c2dlV2dycFhCNGVGNjk5WGNEWjBKNWpUV0N5TEM2R1RlYVBRUTg0cXNsSlhW?=
 =?utf-8?B?enNmcHk3RkFnY3lWSXVZUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHVFZldyNVhvVGgwWkJjZ1M1NjUyaHRSYlJZSmtaN1ZVZ2ZwcUJvTSthMCts?=
 =?utf-8?B?Z1I1RnNhekdSZEJ2YjBqKzJxQ2t5RTZHZjlwZVZvb2M4L3poeUR6enBuUk45?=
 =?utf-8?B?QWREVklsVU1SMGlvb1paME1xK3gyOHJ1NWJRUjRoNEVLTGQva3NPVzJ3ejJq?=
 =?utf-8?B?cklEdVNZOVRRbG9ybzVuL1pMT2ZIT2N1YjNLQU1qNTZic3pmSzlCWmJUb0h6?=
 =?utf-8?B?bUsyelhSU2JUVjN5c2xncDFlNTg5NkZkU0F3eFVCMm83Yzc0bk4rMFBKUGRq?=
 =?utf-8?B?eU01QlVWUURHK3BFT3ZoTTBCa2dBZmlYZkxJaHN2OVBqYnhHWHAvZllOWUdt?=
 =?utf-8?B?MEFWSzk2N2lCNG5ISGpjTWJCSG4wV0IwSVhDRG9VNkp4YmdJcWc5VjNZMGt1?=
 =?utf-8?B?bjRqb1crYzBoZThwYjBxUjlmUlFBWmFhaURyQWtzNXZvQVo3UlhXcEpTRkwr?=
 =?utf-8?B?dXpKQVlhaHVLandIcFJtSXg1cXNnTS9Qam11VjBwY2hQbFRKOU9sbXpqV05E?=
 =?utf-8?B?WE5XR1pVaVVwbzFaTWxhYVdWQ3dCT0ZNck5ybFhaNjZKby8wc1R0UEoyd2hx?=
 =?utf-8?B?YnlJRnhVUTRMRVZpYW1wc05nckhoR20vcUQrQXpCeDh3bUkzMnZNeWtGVzFy?=
 =?utf-8?B?UXFzWUZaNXgzVENPN1FLcUVkbTZwcm1qY0ZDUUFyMDNpeXY3K0dvZlRYTHR5?=
 =?utf-8?B?VEZNaVBhRTAwUEw0U2NVRHBWaXYvZmhiUXUzeno1ZnJCeE5uVHlNcTNWQklP?=
 =?utf-8?B?UjhTcjJMSzNFV0t6Ymx1c2FTZ3g2UjFaNjRHSTVJMVVURjdxSXU2RENTM2VB?=
 =?utf-8?B?MzIzVXpCU0lQa1Q0OVdKSG40OWNYQnZIVmxCWUFQa1JkY1ZaZ21iRDBsU3Rs?=
 =?utf-8?B?blZWbFd4K0NldlU1SzRDaXNuMWlkejJNZ21vbXNYbGtKUGUxRG9yZXFtT1hr?=
 =?utf-8?B?Q3ZKNkQ4MTJNaEhrbkRCeVl6dWYyb1NmaUJSZytTd1BXOGJWM1RNWUZ2QXN1?=
 =?utf-8?B?Sm5od1dRVXNuU0k5VlhKbzVBZWtUeTJRQzg0VmN0RENNUFpoZzllK3BkZk1a?=
 =?utf-8?B?TnJKQndXU2p4a3VaMTJJV1Q1UFIycldnVDJtN1ZzbTQ4VGpPbVhwWEhxZmNG?=
 =?utf-8?B?bzRZMVhIMTlaYk1WTVNITGdId3FZaVBZM2lNT1BRR3R0TzhWU0g5U2t3S3Fr?=
 =?utf-8?B?TnpsbHBwejlYK0tSZ1M0SjFKWDZkbmJNS2hqVWN5TW9yL1JscitPZUNWcjVS?=
 =?utf-8?B?R2s2WjJBdTNOYTBGcXNZSW1Pc1ZTcklycUt3ZGpjT1ZlbjdSUFhPYVh3a3o0?=
 =?utf-8?B?azRyVEplYzdBa3dIb3g5aTIwcVFHMTB2cEtmYTB0L3ExNUU2RTFSRmYraFE3?=
 =?utf-8?B?czRNa3VyOHo2VGM1ckZqOUEyR2xWVmkwVWx4Kzd2Q01rT3NvckZoNjNVdUFR?=
 =?utf-8?B?QVhMKzJYbTJFbDBKSWE5U2JsQTRTNXpEVnJnVkdra1pBbTlVUyt4NGIya29y?=
 =?utf-8?B?WHBTOXd2ckV0bVNwR3psUkVNcmtYaGpEVmd5U2JRZk9LY2owOGJaclUyaFI5?=
 =?utf-8?B?NWE5WDBubSsxYmVONnNnelhqaENiUmNyUm9pOXRueHVUUXNpNjh6WjBZdTZK?=
 =?utf-8?B?SnAxYmpONGJReG92Ky8xUlZUK3VlYmhtNzlQT2JvR1hVOG5QbUdHb0dtaFZp?=
 =?utf-8?B?bGpSWk4zaUk1djFSaEFoWHc2MWp2SjQ1MU1rbVBZaExWU1o3azgwUzgwQjRZ?=
 =?utf-8?B?V1NUK1dxbXJ0c1BONTQzNDd6VkZ0QWY1ek9qMlZ6aEp0Z0Q4TkpNdVUzT3dU?=
 =?utf-8?B?Wm02bFY0dmhCamtBZnR4ekxGYmFuRSttRS9IV1NkM1lwL2VzSmsxYVl3NGpw?=
 =?utf-8?B?RnJ4NXlkaGg1Umh1Y1RqT2JXdmZsZlRCVDVoZHN3QkEwa3lHT0JiOTdoZGpX?=
 =?utf-8?B?eStiYWdkNEF3UWlxSGo1Umw2RkNDdFZmaTVBT0h4cVpOaUgwTUgvUVNuUXBK?=
 =?utf-8?B?K3VtZzdXRU40V3labU1tejA2NTBoMllvWUtJT3NrVzk2L0ZmRC9yWkhyYkU0?=
 =?utf-8?B?TW9acHYwOVRKRUJwUnAwZ2R6YWg3c09GU0w3U2JXWnF5dC9sL2QySW5ZSFUw?=
 =?utf-8?B?dW1CWi9kMTFIbWNQcldIQlQ5SnZTV1pNNTc5MXMrV3p5QVkwMVZrNXRHL3Fr?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c0a098-0d22-48fe-029e-08dca2bff5ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:14:13.4396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mSroe+lyR0YSij71i56w9bjkNlcIO/OQ+VDdlBoqh7qf3Bq08TfXMBxPsUA2OOIfupM2wUg+ZVDkGJSd/hUJ80IXSZhIzRBryyhSiUewMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> Introduce interface to switch between ABMC and legacy modes.
> 
> By default ABMC is enabled on boot if the feature is available.
> Provide the interface to go back to legacy mode if required.
> 
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> [abmc]
> legacy
> 
> To enable the legacy monitoring feature:
> $ echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v4: Minor commit text changes. Keep the default to ABMC when supported.
>      Fixed comments to reflect changed interface "mbm_mode".
> 
> v3: New patch to address the review comments from upstream.
> ---
>   Documentation/arch/x86/resctrl.rst     | 10 +++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 37 +++++++++++++++++++++++++-
>   2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 11b7a5f26b40..4c41c5622627 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -291,6 +291,16 @@ with the following files:
>   	Without ABMC enabled, monitoring will work in "legacy" mode
>   	without assignment option.
>   
> +	* To enable ABMC feature:
> +	  ::
> +
> +	    # echo  "abmc" > /sys/fs/resctrl/info/L3_MON/mbm_mode
> +
> +	* To enable the legacy monitoring feature:
> +	  ::
> +
> +	    # echo  "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
> +

Needs details on what user can expect to happen to counters/data when
switching between modes.

>   "num_mbm_cntrs":
>   	The number of monitoring counters available for assignment.
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 475a0c7b2a25..531233779f8d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -910,6 +910,40 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>   	return 0;
>   }
>   
> +static ssize_t rdtgroup_mbm_mode_write(struct kernfs_open_file *of,
> +				       char *buf, size_t nbytes,
> +				       loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret = 0;
> +
> +	if (!r->mon.abmc_capable)
> +		return -EINVAL;
> +

Why should a user not be able to write "legacy" into this
file if "legacy" is the only mode supported?

> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!strcmp(buf, "legacy"))
> +		resctrl_arch_abmc_disable();
> +	else if (!strcmp(buf, "abmc"))
> +		ret = resctrl_arch_abmc_enable();
> +	else
> +		ret = -EINVAL;
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -2103,9 +2137,10 @@ static struct rftype res_common_files[] = {
>   	},
>   	{
>   		.name		= "mbm_mode",
> -		.mode		= 0444,
> +		.mode		= 0644,
>   		.kf_ops		= &rdtgroup_kf_single_ops,
>   		.seq_show	= rdtgroup_mbm_mode_show,
> +		.write		= rdtgroup_mbm_mode_write,
>   	},
>   	{
>   		.name		= "cpus",

Reinette


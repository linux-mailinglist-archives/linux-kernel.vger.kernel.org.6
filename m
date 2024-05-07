Return-Path: <linux-kernel+bounces-172146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7929C8BEE15
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305D2284D59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788718734C;
	Tue,  7 May 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1xFQaMZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7718733B;
	Tue,  7 May 2024 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113660; cv=fail; b=Y7/y8U5YR1aBZVOjNnb1xUQLSQc3npR4ML9U9teqYQQSMePUM3Yq5LpGmLC6NEUzLHyDqpfRfxSnBTrwU0E1rXF8BZ9oLvnU/0L8DMKKx53lMFcIDHsJczSgBWpmlsopd1+PrpcCcncvkgPyArDPDn9LLa/ZgyR7+wIEh7HTO58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113660; c=relaxed/simple;
	bh=RQolFX0eMX1UY/alvPEvBbuhZQRzhy/TY5BerXjMjDY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KZ1p6GEFpgER6jvSNNpfFzYj/WNhAeackXthSGTmRs9VHDWGyPAfSS/uEWs1wUK7nUTnP/hv+ECxAy4AaqYnZCmKWGQ8rKLxI0FJ8hUmoMyFhvOw6ZVQXP8m/XzBJj1PS6QM+uJl9i/uRqZHQrJ9qcOnUGHzSNLprPdDwtf6+co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1xFQaMZ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715113660; x=1746649660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RQolFX0eMX1UY/alvPEvBbuhZQRzhy/TY5BerXjMjDY=;
  b=H1xFQaMZTC7PRwcy+o7eEsK2t1iRbp7v2Pigg/MrD3oO6oueqwBd/ZWJ
   mvKeOECwjcFdzY6TMbnRhf8Uo6I8XXthEjEKlwE8zv5C9jNXc9E759ayw
   NMts/iBPT/Ju0/l7p+o8ZuVnyniNSsnEwt/x/FN3LPvLgjVs3Fc/6LgCf
   z0FCY1d3C1f8BtSqWR11xzM12rCXLQ7gZUVUwqFr0SNnb5Fkhq0KPcxfb
   XIxDZW5KRaKWxDzUIGSAeojuXhUOO7hOZrVMwS85ZjLL+8+yOqEkMXmZ+
   OEZtLStniykhWq/0sVirzFNnEMjsUUOjubj282BTfat1BpFm+UqbqOTsd
   w==;
X-CSE-ConnectionGUID: t+i+yjsBRpCSR3Xq+KJkqA==
X-CSE-MsgGUID: OdToN/AGSmaFl2OYknlBSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22351721"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="22351721"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:27:39 -0700
X-CSE-ConnectionGUID: lJJqLxtOTRCALE8ySHAxrQ==
X-CSE-MsgGUID: r7LskTTMRqqAe8PWwtLi+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33204613"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 13:27:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 13:27:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 13:27:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 13:27:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E85K4AAe6JDKdTnA+r0zaOjLwYIQ2LZUjZ9U5OqW+BNCYqfNPBUNWl0ukKm5JwA74UsM21YM8vjoMXyo5psbLzOf8KBxSChW4DH2bNVTohVXNe6YvvljskzAnp0VrLQBzEwfOQ1Ddir1yo9ZiyVwRBGFp7OrjkTypUz53Ya5z8mqxHFjid5ICXjhDLuoxDyADjLNRr9BJbxxjQ4P6Np95La7OfwgloKQ5AaBgBZ3B1oBE/Cx2Fj7ATFeq+M3Hw5UcoMdYMkfrFpPyD/zwjMBlq9HhRE07LcsfPBYGu8Pmo2skwJ93sHs4Oa9GVR+KbfGQmrWN3cVPcyhMt7SnIuEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7faqgR+l3VP5jcWfxzdcJE8tSMM7W046e1ItD+HRktc=;
 b=Ypuf7jbBFVtLRtZZkLoPOvXg7liSZW6vwCCxA49MsIcaI11gZ743KsEE26/TPZYuoWxqLpGOq2LIVqQvJCaHgJp4vQ6nmxlmarM2z8rq7YC1XezwTd6JqT72ySnfkmkElzZ5S3itqLBewLScaIuhIqhGv7CPT1uVEqLgEaEDt5sYTf7FZ+SpDAqOvZF7Vpbyx8/j+K5xogBa1ktmAgx4uZRNM99e5anCw2wICQ17wACjN6d/Pbhn1gLYfH1QG8pEiTBCEei2gd4LBGX8wlVIMu7qA9KZW7Ta8Pt8t8cq770goxioAQCp6OMod2tRBE0/dn3f9Oe6GiG3+exZ+8NxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 20:27:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Tue, 7 May 2024
 20:27:35 +0000
Message-ID: <3f4d2c09-3158-477a-ba9b-f8f809d1999b@intel.com>
Date: Tue, 7 May 2024 13:27:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/17] x86/resctrl: Introduce
 resctrl_file_fflags_init
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <363c14eeeac99eb0453ac3429f9e7bd446b2acdb.1711674410.git.babu.moger@amd.com>
 <55fa3189-b5da-494f-8ec2-7f0ab4b8d33e@intel.com>
 <119fbe0f-9688-4382-9263-220f69caa718@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <119fbe0f-9688-4382-9263-220f69caa718@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: a11a20a7-7e47-46f9-485c-08dc6ed42182
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTd0bnNvcEVSTUl2NDZ4WW1jcDl0K1BxMk5GVXdzOVErdzZkTDZvQi83dHlS?=
 =?utf-8?B?M1VacGtFTkc2SFdUQ3hsdk0zaHJIQTloNi9PNWxzWDcvc2U0M2RkL0JSdFlF?=
 =?utf-8?B?UHV4cm4xMDIxYzVnRzVSZC9TbGluc3c4S1loQmkvMjNFMEZnc3M5WVgzYVdt?=
 =?utf-8?B?dWQ0UytVaVEzUWhmVEpGWWpuQ0NLc2duQkNacmpOY0RPbGJrbnV3Z0dpSEdp?=
 =?utf-8?B?YU1CUk9PUGFvWlFhTnFnRVczbTZIWjhvMDlrZ09lenVmWmZtUnRuRUxwRHJB?=
 =?utf-8?B?UkROcHJ2RDJXRjFSR1BWN0NVUkVURkdyblN1d2ppZVFpR2pmcENCeFVvalpJ?=
 =?utf-8?B?eFZ2a2VVT0IzUnlML0pQQlI4a0QyNjRvN21kc0lCSXcybU93c2I1cTZ0RW9V?=
 =?utf-8?B?K3NidzhKdVpVZGtmZGpuYzB4aS9pbzZiSlZGZE1GNnlhajJ5M1cxeTVBaWVR?=
 =?utf-8?B?bGdzcGMzMDFQeFZpM3NoU3E3NlM2NnU3emxBNTQrT3cyMEpQdlNwdVArQWFy?=
 =?utf-8?B?Nzh2OGhoVHR5aEhqSWp1UXR4L0F1NDJkRlArRFlmMFh5V2pYVVB3TzZHUGky?=
 =?utf-8?B?V0dvcUNlUndYTUxxNjlrcVE1VzM4Mm14RzlOUWVGZk5yRUpNblRjelZ6dGVV?=
 =?utf-8?B?a1ZqNmU0SUVzSW83ZWJQUW1HdFhIY1ZMYzUvL1NVckxpYkZ6M3d1TzBlSnI0?=
 =?utf-8?B?bHJzSXNoSFV2eUdJK3krTnlQemQ0VGI5MEMyYmdWNEdGbE04ZEcwVGc0bndh?=
 =?utf-8?B?SmFza3RXcG5pdGpPK3A1ZWlvWEdjeGVGNUpmQmtzcVNjbFczTUhnS3MwbHl4?=
 =?utf-8?B?MEJQVCt5aUcva3hTYWJlVEFrd1UrVytEQmViOHl5OWp4cnB2MnVhM3JkSExT?=
 =?utf-8?B?WXVIZUY2SCtvNUxSV3IrY3hXdFJxeHBxOTBHZWZIL0lkSkMzRWpsYm1xNDQx?=
 =?utf-8?B?K3RUV1Q4dEZnY0hQOHcyTnltY2lldldWejNNWDNKS25rQUxMOVUwaXVLVDY5?=
 =?utf-8?B?bU1nQjdzdFhIZVBWdGFYUHVRcm5kMnY3Q3BrQm8zZElIdFBCR0NpaEZta0NJ?=
 =?utf-8?B?NFJIUDgyTHVKa2pETXpncXhJWEZuaWM2VWFuMzlLSllkVW9GdDlFYkh3Lys0?=
 =?utf-8?B?S2NIZGtyeWIvbzgvRk9USVBCUmtSK05OUHErVllxL1BWSDUveWVhakY2RXFK?=
 =?utf-8?B?V0VOM3h0TWtqbCtRenhvckxyUTVpTkoydWp0UVNXTFF1RUFOTVpodFZDUWVP?=
 =?utf-8?B?QStkSm91U1lVWFM0a1Z6N1Nzcm5ZQTd2WGJPWVptK0FyVkU1OUd0N1VoUVNo?=
 =?utf-8?B?NmtESmFVb2JrMkhoWWI2UVc1YjZMWjN3NHRPeko4Z3lZWFZ4NjkxbFkySHlv?=
 =?utf-8?B?UVcyRmlaWXhUenhkODRrKzhDUzZyK0l4Q0tMd1RKMmRKU1BEeVFMdFpVajdF?=
 =?utf-8?B?ZWpsSldZeEUzTHo3UXc3dXQweXlXMkZEaG1WdzVZMVhZYUdXSmt0WHdQS0lG?=
 =?utf-8?B?T0QwRzRtR29qTGFhTDhsYytXNUNMZDRjZ2pzZHlVWFhkUXZhTk1WNDBObkJX?=
 =?utf-8?B?cjFwVm5CeVhneDU5b3o0M0hsRkVoYzJnaXdUSEIvdG0zMWpPMXlYbkg4MVU1?=
 =?utf-8?B?VWVyUHhRcHVDQ0lvejkyN0FSMUNmL1VQOElDSytHMFpyaXJHZjlSZldqdUxu?=
 =?utf-8?B?L3hYM080dUx6a09FOU5abkJlUVgraWsvZTZUQk96eFhWK1ZlbXk1a1dnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xlb2ZvZzhPb3hzY2QxMU9aKzVtekVucG5wdlYxd2p0b2NOQTNGU3BFV3NY?=
 =?utf-8?B?UU43bDZOdWZyVDV0STNlU2R5ZjZiQWdJVkNVQm1OQUw0MHhVQzNEL0l2SDJr?=
 =?utf-8?B?NlVGNjV5RU1SL1M0M2RJTHpxUE43UFVnSXVzSzFId0JNTDVqK01zQlBEbW5a?=
 =?utf-8?B?bWJjekY2QXdmbEFNUlluR0VjU1VRY3hkQVk3WEU1N05QZzB2T2RaWm5Idkpj?=
 =?utf-8?B?azFtdUIyQjFWRjZmNTlOZzhvakxVZjJnbXMxRFV5UkRsc2FNa1V1bnladGtK?=
 =?utf-8?B?MXRoZ1crUHlEMlZ6OVVrMDM3UU8xTSs4V3FQOWNhTTV5akpQOFkxWXI0c3M1?=
 =?utf-8?B?R1BZUit2bWhTdCt2ZVA0RzFjMTZHaTBuQmU5QlpxV1lwTFgvTVoreHZMZmFG?=
 =?utf-8?B?NFY4L2d2SUVNM2lCSnhNbXllZmNaYk9NY3F5VW1iMUY0Q0F1VjlxNXBkQmo0?=
 =?utf-8?B?SEUxWHVRMldSN2RlTnZudGRPNXBDbVZuWFFSV1l3dk5QYWFpTU9LeTBUUnU0?=
 =?utf-8?B?VzN0VUlLalVNMWg0NWlCSTVxcjduZFlKRW5qQUkrN0FYd3lIcHJ1RDZEVEd1?=
 =?utf-8?B?UFMyMU9QWEFoblR2Vnk1NGs4OVhvaHBzdzhvczQ3N2Y4a3c3NnIwaks5dlNN?=
 =?utf-8?B?WW9ISXhaRzgzWkdleFQ5N1dHQkQ1cFBOanpYTm1xWU9zMjdOcVZYdTU5T2xE?=
 =?utf-8?B?b3diZzlmNUZtaEVWQjlYTjRDNVRIYTVkVWdVaDJ3Rnh5ZTR2eFRqUG54elo3?=
 =?utf-8?B?bUxNZHk5eUNQK3U0dW9pUEdYTU5HMlJQMjRQOCsrdXBQRXd4aGQ2UkYrUW9n?=
 =?utf-8?B?M2xmbUdkaVd1bjU1dXpIT29QTUl1WWdERkFFWDc2c09RalRCMENSOEhpMXJV?=
 =?utf-8?B?RmhBbnoweUdYYVQrRks4SnJmTUNkRFZ6WCtMYzBrdVpaY3d1Qk9DRHNtKzRv?=
 =?utf-8?B?RVluN0l1dHFDc0g1N3hFZWx6L1lxVWNKL0FnZkk2WDA0Tm1GeHM0c2pPSkFn?=
 =?utf-8?B?dTFlQnhDamlZOTZ2L3BNeHA4OG5vSGo5RDBLM0FhOHo3dXNvZ0hNQWNsS0Nh?=
 =?utf-8?B?OTJSd2pwTFhvNVBHcG5xUEJQUzVJUTljY0VKL2x2dHRxdUtnT2RMWTh3SGtI?=
 =?utf-8?B?V0FuelNNR3VXeTNoSzJOSXhMNWV6Ny9VZVhzNEpMN29KaEU0Q2JlZDJYZkky?=
 =?utf-8?B?cFVKQitiWnMrbXpvd3JqTTAyQVE1dzIzUFBBMDl3M0tRNjJ1cGM0UnRTS2lp?=
 =?utf-8?B?MllXcGZyazh4MTkrcTcyMWY1WTcyaDNWQjRLV0V6ZmR5VFFZOVdSSGZ5akFs?=
 =?utf-8?B?bG1GYmFyTjVkRmYwQmcwbGNHLzJPeEJ4T01jZ3hsQnhUMmxjZDhFYStuaXVt?=
 =?utf-8?B?Tk53cnp3Si9ZTmlmaTV4ZVg1ZnBhbHlhOVBGcjZhNFQxWXg3RlY4NEZOOHZ5?=
 =?utf-8?B?WWg5SER5TElxV09UNkhuWS9OaFZmZTRjYmtyZzFkZzdKKy9OSTlNY0I5bGJW?=
 =?utf-8?B?aEtFUlRmeHFsYkhkb3Bkb3lQd0tCbGNxVVFMV3pZUWRhWG12TjM4aVV0emFv?=
 =?utf-8?B?enlqTWVaMGpiRkYxMDd4MzMzMk1JSTdLNHE0eitlQXFvMXlhVnhWUWhtN3FF?=
 =?utf-8?B?NEFYM0Y3M0VKNWRHUkJINHVFTzZNbW00SklBcWh5Nzl5TVRRMWpwN3RZakV0?=
 =?utf-8?B?cldHamxlZSt6andsSlUwVkhrbUw4ZnVzMTJUQmdwSEdBMHlMRkRKQnYycnor?=
 =?utf-8?B?WjBhOE15cXlFcFZOK29RNElqRStWbFZaNWVGaTlJWVhROUpZYkRNdXAvU0di?=
 =?utf-8?B?RTQvUHpvMlZVV2Fjd29VYitObk1zNm9HM1RmOFUvM3l0cExPR0k4dWJpUXhl?=
 =?utf-8?B?SkRLRkw2dTFCZUd4MGhneEZlWnRkVXFMUUZwZ1ZkYzRZbmRjOCtkaXZSWEt0?=
 =?utf-8?B?ekxzenhsTURyVnFuLzAzWFcvWUJBZTR3Vkl5eDczRjZmeWVqYXJoS1VnYWJ5?=
 =?utf-8?B?TmozbFlrY3NFc1c5OURHSXAzTlBTMFZHL05UTTdpbGw3TUgxLzFHOERybVlZ?=
 =?utf-8?B?SjBaMjA2MEdITUpaekw4cDRFbTNJTUtqcmpvQU53S0U4TVN2aE5VYlRxWlpl?=
 =?utf-8?B?c1NmUjVjUWpxWkFKRVNCb3NpbjQ2NWQ0Tmg2eEhhSTV5SDZnM2pLdndsaUs1?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a11a20a7-7e47-46f9-485c-08dc6ed42182
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:27:35.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEuGn3MNLsobRJWTX2biNUkka3BRzTWe06fLvszTCPkRxGKuWrUPH7A4BnjbM/QEtjpgQAgeQ8D/qF7lm3CVwF4BnFXCYWMMfNCLU7hVVRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4952
X-OriginatorOrg: intel.com

Hi Babu,

On 5/6/2024 1:23 PM, Moger, Babu wrote:
> On 5/3/24 18:26, Reinette Chatre wrote:
>> Hi Babu,
>>
>> In shortlog, please use () to indicate function:
>> resctrl_file_fflags_init().
>>
>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>> Consolidate multiple fflags initialization into one function.
>>>
>>> Remove thread_throttle_mode_init, mbm_config_rftype_init and
>>> consolidate them into resctrl_file_fflags_init.
>>
>> This changelog has no context and only describes what the code does,
>> which can be learned from reading the patch. Could you please
>> update changelog with context and motivation for this change?
> How about this?
> 
> Consolidate multiple fflags initialization into one function.
> 
> The functions thread_throttle_mode_init() and mbm_config_rftype_init()
> both initialize fflags for resctrl files. This can be simplified into one
> function passing the file name and flags to be initialized. It also helps
> code simplification of new flags initialized for ABMC feature.

I am not sure what you intend here. Is this the entire intended changelog?
I expected it to reflect x86 requirements as per
Documentation/process/maintainer-tip.rst. Under "Changelog":

"It's also useful to structure the changelog into several paragraphs and not
lump everything together into a single one. A good structure is to explain
the context, the problem and the solution in separate paragraphs and this
order."

Reinette


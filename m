Return-Path: <linux-kernel+bounces-366327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86C99F3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A60283A04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3491F9EA8;
	Tue, 15 Oct 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/jG7GGc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5701B3958;
	Tue, 15 Oct 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012708; cv=fail; b=KegfvhoKqbtGqrRJkEZGkwB6L/e1ktwfLchklJca6dA7vKhjP4itDPBB/0flAfEj6qhD7y5uKNe25fGv4xD9aWwUFqyXYTkkCcDCUPaWWFfR4zl/R81S/F+LyBdu+0li10/geScHHRG/DPcEGiqHg77SrmpSefaXM5ONSC9brEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012708; c=relaxed/simple;
	bh=FNweKcliBparJTOt7hxWdhpdGJKI2zsAG96wRjx/IPA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fcfZ+dR7H0+HgOIhGNKyDaCwDgbJoXw5hr6WwIv0jj/3MS7NUSPOFPzFsCq6PNSbACSdAjNYXtbegZJtzXoe1Hc11oJfMCqLmgSh4xHh+CHorovoaSmB4T0tCtC5Mka5iLj0JCNEZNGCB8/CJMvjFmQoYgV8M4jdNJU+6UtcDno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/jG7GGc; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729012706; x=1760548706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FNweKcliBparJTOt7hxWdhpdGJKI2zsAG96wRjx/IPA=;
  b=V/jG7GGcyISsLZ7TvV2Fb+pY6ElXT5Ew8P1JoDztztZlGC3cQvpDjAcR
   5wsEfrEu24zrk/0PebpRPtVlBpXWPj27Ytj7Vzk2vVO4rFcjHBx46nq0G
   rd7hNhWw7ZVwLEJlwNFNnRm3ZFlP/RXgcUa60lm10dDO9r6u76rh9PtZ0
   nvJMoRKb4l52CAWNtJCLh2aifq3dS/qARKa/gu3UzuWs7VgJ0weIN4bY6
   BSE0grlHVO8q16wR+A7uLlBEHIjeZZRREAAlwEvzAEOgGwnw2fMSeKRuk
   9pLfwg27nykHrjxYjPAxkHkL4y1z0YcjWXfXNhxiDBhg5jQSWQoDK5BI5
   g==;
X-CSE-ConnectionGUID: 6gqxvADkT6aWvJhKQ8ZRuA==
X-CSE-MsgGUID: jBgodMGSQnqtQyx8e20PTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45897474"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45897474"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 10:18:25 -0700
X-CSE-ConnectionGUID: rBGqV/Q2RfOBWSqiF/6X2w==
X-CSE-MsgGUID: NOfE3D9+TFeVT5KHJA7P/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="77626274"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 10:18:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 10:18:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 10:18:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 10:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3yohDM3TzfmNRBzFvfRDrvAjuAHD8ZpiHeyepf3DdS3kyub8zP9IJeLZ+Df3vWhFnZhVZSrO+bx8in/w7vcm6DZXF72Vr9P38jNrWFI+S0xd4ZSMI47jUi+iHILqcnS0WBxfEniwVtGr8D2sYCWDSDySAmxorEZfoQWwGpndBzvmoScQ9QjFBKO2BDSdEuqCjxNAEUZKzKaviJqJ8BC0bPvPkcl/YT1EJnYYUShDmZK1PhGNp+FnuAqAF6izHUdZlgmqhYLzbDjsZTHpTwgxklaTefBz4VqzkqOvgFD940VWqS8E/IbCucmoXzl7QteMJsGMJcIQUMEDoMpbJ9Frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxQE3yChYFaxL/X6P3U1i8hPbb9agI1svoawVWW6hIU=;
 b=U6BBvIGZeSti/4J1v41ewQWFZAznj0u+AF1VpsdJRI7MGrvzBQQaFEphTC9Y1fiFeubqBa79/R4Yda9FVDgVSjNYdDJg/mLs41V/ob48algeUfJvMtFVfCdlQ1fUKM8BRIfTLUfZDQGz9uu3ma38UYyyj/bk1sFLZqCUbYHgPmnikEZk1+oT60/LmuNdXx/OEuk+px2A6l26wfmpv6zcIcf+oUcHtBHblDYv32Q8xyrsWXRMte/I+dHjiKo37sPq4VURPVWGEYIrfjBWlhz3MMl6Oe7UNt/n7csk9dn2uubLMBfLMbyfTNi2+4C2/7ZZ8S36ptJFaTR51gXUHAA3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7934.namprd11.prod.outlook.com (2603:10b6:208:40d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 17:18:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 17:18:18 +0000
Message-ID: <8fa57edb-996c-4867-8a7e-05a8fcb9fe3a@intel.com>
Date: Tue, 15 Oct 2024 10:18:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: <babu.moger@amd.com>, "Luck, Tony" <tony.luck@intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
	"kim.phillips@amd.com" <kim.phillips@amd.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "seanjc@google.com" <seanjc@google.com>,
	"jmattson@google.com" <jmattson@google.com>, "leitao@debian.org"
	<leitao@debian.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Joseph, Jithu" <jithu.joseph@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
 <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
 <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <43654ae1-c894-409b-bcb8-065940644906@amd.com>
 <SJ1PR11MB6083379F790967B379C4232DFC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a972dfe9-341b-416c-a245-0834583c6620@amd.com>
 <567bd687-a69f-46fb-ab19-3f8d95c5e798@intel.com>
 <b4d9b572-4df3-4758-a40b-cb48fde0b595@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b4d9b572-4df3-4758-a40b-cb48fde0b595@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:303:b7::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 015a8374-4a37-4ce9-bc5b-08dced3d5ca6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTZIczdLQzVYVFdjYzFpU3dmOWtFUzFwcG9IRDlXNlgrUkI5a0J0L0s1cHFq?=
 =?utf-8?B?VDNNYnhVU1JGQXFsVGpsUHhMS1ppd0l5ZHFXd1gyeEllKzh2SGkxd0VBOVdM?=
 =?utf-8?B?OHdUZWhhaEJSS2JXeWRlUzR2dUZ5clFmbklDM2JhakE4eEoxNWw4WFJTZWR6?=
 =?utf-8?B?Q3FIc0J3ZEUvc0xnOEZGK0dLYmtDMWZBeFJ6dytLTkl6N1lZSnVwZTJjeEx4?=
 =?utf-8?B?b25RVUxud3VqVlBGd0N3aXEzcjN5aSt3WExFZit1a1NvcW91eWVheG5JUWx3?=
 =?utf-8?B?OWlNSHNJeFRIenJVNmNBNTBjT01QcjFCa2FPY2diNWJlMjM3RWZ2UjFaVTVU?=
 =?utf-8?B?UXh3eTVSU1dwR1pIb2w0QTlqS2pQT3dabHBWNDdycjh2OU5kcmRZL0RVRXhn?=
 =?utf-8?B?eHRnMGtEZGhaUzBWMWxBWUZCZjl6WUlJUDl5ajJXeVZjcGpMUXR3RHhpSThr?=
 =?utf-8?B?YnZnZ1l2WS83endFSE1sZ1g2SXVSM0tqNjZ5aGtqYktob1Q1cDJDWU9saW5w?=
 =?utf-8?B?aWZXSEo0ZVpuRUprRVRIdm12M2hxZVV6akM5RHp0czhiSHZZem0wbW80QUFo?=
 =?utf-8?B?eENVRmIwZE9RTjFiQm1wSXVBb0FlelhwMkxZZ1lUTkFkMDloZFpsZFBMMGVB?=
 =?utf-8?B?Mm1GZDdKM1kvWjdUNjM4WVFyTndqa2ZIZHR4amJ6V2FTeFRsWE1wYTdPcU94?=
 =?utf-8?B?NThibHp2VUkxRDVvM0JYalZYQ2JzcWM3dUtxbDZBNEdGSEJDQ0psR1B2Mzh1?=
 =?utf-8?B?Y3F3cGNnZ3NaWVRRMzE4a200MWhGMllpM0pGOUlQMHhRMVEyd29Xemoranh2?=
 =?utf-8?B?Mk5nRGRydDZFalczeVlNVkgyaS83RzFtK0RTWHhoZWdmVW5Fc3BxRzRPbms2?=
 =?utf-8?B?M294VjdWMmhZYmlRb1lOajdjNXNvZlNidWJkSExyYTNqOEpxcnliWHRQWGtO?=
 =?utf-8?B?dnpWS1c1U2xBNzBYLzEyaU1SVGxPTDNWcnczRGlyTGJEVDVWU1ZhL0lwUDRt?=
 =?utf-8?B?SEZyMmVCVVJVK0p6SE1DSmJ5d2pxMTBSZTNIUElGa2tudFdWR0tZMGNmeitv?=
 =?utf-8?B?cVpWRFhTVlVQZE1DczIxbjV2VGI2RzcxL01WQklabUk4dkVNRnU5bkMyamQ4?=
 =?utf-8?B?NXlZSlpOT093SUJRUTJBaUkvcFUyVHJEcGo4SFlDeEVuem1ITzVDaXBBcTZX?=
 =?utf-8?B?bS9uMkphMVdDaTEzVklMdjNMSmg3Y0ZCR2Yvcld0MGZ2UzBxVU8wMjk1elMx?=
 =?utf-8?B?c2hxKy9XdDk3aVZGSWxmR1MrYmdIVlNSbTE3ZURrdzYrdFlZN3Zha2o5UVRF?=
 =?utf-8?B?M09Dc1V6VmhESStLQUFYUFVONWlQY0VNeS8wajg1eEJTNWYrWEVGY1ZwOE9I?=
 =?utf-8?B?WnNnN0JkdEVPS3FQNG5BdXJOOWpuOU9NN1NYY3pWTzZtRit1ZksrWEFPZWFq?=
 =?utf-8?B?N0F2ZlJTME1LdnBlMmQwNFc5b295MXAxOEFidWg0MzFLNFoyTElxM3JLeUor?=
 =?utf-8?B?bTI5UFlGV3lPaStWRVh3bmVTZXlBTUVNUTdoa1dKR2xSKzh6VXJja3JGNHdS?=
 =?utf-8?B?VWFKMUVrYzBmSlY3UmVjOTBuaUdSeHhacys4UHN2Zk80akU0MFMweWtxM2FV?=
 =?utf-8?B?WWJJOGJyZzlMTmtyRURMcXlFbFRwSmM0UXF0UWtDaHh3NmErUmtqeUJXVFZZ?=
 =?utf-8?B?Qk5WMTVnOHNqZUhyNnVobmpWSytqVHFwZWZzckZ0L1lUdEwrOXVWcDh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJHTGczZVFKaGhZNFR2UnlOU1FvQ21mcUJNUjNvT1N5a3lmTmxPbklPZXhF?=
 =?utf-8?B?VVRkNlFCT2tQWnVSTkVMS05CMVdIRHBoaEFCMHBCNHZtelhlYURjVTRCMTJ1?=
 =?utf-8?B?TmtaUWpSMFo0Q1VXQUVyR3ZGREk3UUQvY0l0SlEwSXdRaW0wM1JQMU0yQlh2?=
 =?utf-8?B?WHduZG5FRHMrMXBJM2RZRnc3aHlXYkdhVEEvWnNZbk03SVByeEZ1TzhLYVhn?=
 =?utf-8?B?N3dqckNlVWlsY0NKVU95OEJueU5HZmROTFFaUmR1TlkrK1pXYnA2MmtRMHBB?=
 =?utf-8?B?MDlkNlErT2JENGZXODZ5aVUzYm5JMGpIMzNnYzF4WkpGSVRnMENCWGc5Y1pn?=
 =?utf-8?B?VjZBcGJ3WU51WGNUcGo3MzFUQ1pyQ1RJeXoyNHdCRGN4MmlJUDVIS2U2dURP?=
 =?utf-8?B?MEtGcW1vQ245QzdsUnZzMUdSTkg4MVdqZ0krVS85RWRVakR2Vnl3aUtZMGtM?=
 =?utf-8?B?eU1JRHRhU1ROMjQ0ZEkwWjBvK0FMai8wck0vdnlaNlJvSTRUOFBzL25UbDky?=
 =?utf-8?B?NUJXS1VCWmZFaE5DS2VtZG5SRWhMKytPeDBTN1NGdGtPc2RQb2lja1pMdGcz?=
 =?utf-8?B?YnFMWFU0RW4ybjQ0Znppb09Zd1hOYmVFMnd4L0NjRURUVVZlOEg5QnZSMDVP?=
 =?utf-8?B?Wkw1TzVKZXNTVE81VDhGc2c1M05ldytLVXNyM0NYZ1poYVcxL0tkd2tTMkw0?=
 =?utf-8?B?a005K1FlRE1uL05mb0c2RHVHaVR1cTE3MzJnZTFoL0p3S2ZEQ3VCMU9hM2Fp?=
 =?utf-8?B?SjBRS1VvZlVjM0N2azQ1YkxLV2pYNUZMV09qK1ZHSVRMMllJUHNMQ0FRb1RC?=
 =?utf-8?B?WkI5QURRKzlQdzczTTFEV2Z3VWYwRjZkMVRST29RTnBScUVhSG1xT3lmOSto?=
 =?utf-8?B?byt1ak9LWnlSOER2Z0dWQjlxZno5L3YvT0FQb0UzMjVQRFAyR2hKTFRQYkE5?=
 =?utf-8?B?Z1RZbVc4d0JQWlIrQ21GOHJNNG15VEhvSTBlYXZQaFNTZisraitpbXhvTnNP?=
 =?utf-8?B?TERGbFBJS1Erdnh1MXBBT2d5dXNWcXcrdTllaGcxMkFTS2M4YVZTOFN2ci9R?=
 =?utf-8?B?TGpNTEdsZmM2QVVROGZkVmpnQVJUanJBQjRBSHg0dnJLTGFSS1NpeWU4M29G?=
 =?utf-8?B?VTBVQ1hxYk05ZUhmZFkzbG1LNEZNdzlLSy9YV3dYTnk2ZmpienhCUmswVFZ5?=
 =?utf-8?B?dnVxMG55eVVGUkZZM3k5U1M5MFBIZEsyUHRLMmFuemxIM0RmOGpBM2hjVE9E?=
 =?utf-8?B?c3hIa1F0UHc0WEhDbUhXVkQ4TE1pNDgvTEZvbWgrMzJIeERSVWlwTmk2dHZB?=
 =?utf-8?B?Y3d6R25HSll4ZlJrRlJLNkwxVUc1cGNOMDVnMklmTUhKN0JGYnFnM05hM3hk?=
 =?utf-8?B?eHBid0tvd1A5cUZHZGI4bW1QSTRJQStZMWp3UW1HOTJxZnpKNXpqS1lwYS9S?=
 =?utf-8?B?MDEyVHIyT1lFdTE4UFBQUkZXQTZTN2RZY3Rod2N4R3VoVU5GSEtybzBvQXZt?=
 =?utf-8?B?QlgzcVpQVGNFYTlBOFhVb2ExKzF6Rm8xR25KaUsyL29SdTErNGJiU0hCZjU3?=
 =?utf-8?B?SVowdnFnaGgvZ1gvQzdHaFVLMDNGbjdOMVVkV25ZZ2xQQTdMZ1ZBcEQwQlBK?=
 =?utf-8?B?cTdnU0lOMVR5UVVqUFpRbnEra2x3QWQxQ05VRHB4djVDaTNnSUFISXdvZjF1?=
 =?utf-8?B?N2FnMzlCSWxTN3JkdHFYU3F3QXdQU1ZEQmNpNzlSSVdWRjFPdEFWZ0FLM2pj?=
 =?utf-8?B?Z3laTWxGVFVWQW00WGo2NkhZNGtVdEtveDk2S3dpdUF0V3Y3VkozRGxydk1h?=
 =?utf-8?B?VEpZU3I1TTF5NkFGOTBDaU1LSmljUTR1U2FpVWZWekloVlZ2SFBxak40aHNh?=
 =?utf-8?B?VTRJZmlUU3BtZTFxM1d1K2NlbDhMWHhYVk00VnJWTWhNbHYwUXdmZko1U2xn?=
 =?utf-8?B?eFo3S2FndHRkclU2M0VLZzF2OEYvYmhobXBpMzc5WUNIc0dWQmZnZERmRGIv?=
 =?utf-8?B?VzFUQXd0cUJpUjNjdk00Vm0zNk1FRUN6bDlYanQwUmsrdXN5SVdtUU0xQjR6?=
 =?utf-8?B?QnNSa0dVWTVGR3hOWm5CbkVrcFVKZk52L0JTbXdsWlFDK1ZGanBUQWovTXpy?=
 =?utf-8?B?ZlVxa2dueVJVTERpNTFnSVZhblFVc3c4TjdXUG5EQU9WTFRqbm1MR0lubXpV?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a8374-4a37-4ce9-bc5b-08dced3d5ca6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 17:18:18.4408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM9swwcUM1e2vVJBgK53iacb8Qt1aOh7qbTChlPRDgPYsX7rMcq5Q1WLv0JJwbweQKJ3HHyl0Utw+YKbxXsFIZd4d2vvt0+jCl90uIeAffY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7934
X-OriginatorOrg: intel.com

Hi Babu,

On 10/15/24 8:43 AM, Moger, Babu wrote:
> Hi Reinette/Tony,
> 
> On 10/14/24 21:39,  wrote:
>> Hi Babu,
>>
>> On 10/14/24 9:35 AM, Moger, Babu wrote:
>>> On 12/31/69 18:00, Luck, Tony wrote:
>>  
>>>>
>>>> It is still the case that callers don't care about the return value.
>>>
>>> That is correct.
>>>
>>
>> Are you planning to change this? I think Tony has a good point that since
>> assignment failures do not matter it unnecessarily complicates the code to
>> have rdtgroup_assign_cntrs() return failure.
>>
>> I also think the internals of rdtgroup_assign_cntrs() deserve a closer look.
>> I assume that error handling within rdtgroup_assign_cntrs() was created with
>> ABMC in mind. When only considering ABMC then the only reason why
>> rdtgroup_assign_cntr_event() could fail is if the system ran out of counters
>> and then indeed it makes no sense to attempt another call to rdtgroup_assign_cntr_event().
>>
>> Now that the resctrl fs/arch split is clear the implementation does indeed expose
>> another opportunity for failure ... if the arch callback, resctrl_arch_config_cntr()
>> fails. It could thus be possible for the first rdtgroup_assign_cntr_event() to fail
>> while the second succeeds. Earlier [1], Tony suggested to, within rdtgroup_assign_cntrs(),
>> remove the local ret variable and have it return void. This sounds good to me.
>> When doing so a function comment explaining the usage will be helpful.
>>
>> I also think that rdtgroup_unassign_cntrs() deserves similar scrutiny. Even more
>> so since I do not think that the second rdtgroup_unassign_cntr_event()
>> should be prevented from running if the first rdtgroup_unassign_cntr_event() fails.
> 
> 
> Sounds fine with me. Now it will look like this below.

Thank you for considering.

> 
> 

I assume that you will keep rdtgroup_assign_cntrs() function comment? I think
it may need some small changes to go with the function now returning void ...
for example, saying "Each group *requires* two counters" and then not failing when
two counters cannot be allocated seems suspect.

For example (please feel free to improve):

	Called when a new group is created. If "mbm_cntr_assign" mode is enabled,   
	counters are automatically assigned. Each group can accommodate two counters:      
	one for the total event and one for the local event. Assignments may fail
	due to the limited number of counters. However, it is not necessary to
	fail the group creation and thus no failure is returned. Users have the
	option to modify the counter assignments after the group has been created.   

> static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
> {
>   struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> 
>  if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>       return;
> 
>  if (is_mbm_total_enabled())
>    rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> 
>  if (is_mbm_local_enabled())
>    rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> 
> }
> 
> /*
>  * Called when a group is deleted. Counters are unassigned if it was in
>  * assigned state.
>  */
> static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
> {
>   struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> 
>   if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>        return;
> 
>  if (is_mbm_total_enabled())
>  rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> 
>  if (is_mbm_local_enabled())
>  rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> 
> }

Looks good to me, thank you.

Reinette



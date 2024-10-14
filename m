Return-Path: <linux-kernel+bounces-364460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288FD99D4EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC511C22DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C21A76C4;
	Mon, 14 Oct 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6T76HzY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067929CA;
	Mon, 14 Oct 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924371; cv=fail; b=HKkvLkgdcHL2wu2mSj9EijVoZjWek91ZIbYHtIQl4ByZBy0DVXrsAaKP/aTwAKDAE9N/FLR2TNLkRyhDNhNy3lmtQsoVMcMeE/1Uz9ZmzIVEGqAsW+AVQP/Y+8LJ8ba4hJ2ipkAD86BWpNIlAj5Odv6T7GagbNHVPRTcbZCsYBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924371; c=relaxed/simple;
	bh=4O3WHj924EBzwZIraxY0g+I4XhMDYiKUvirnZ20/Wi8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XJ4kBYiSdoOT+a528iln/KTXUMoEKRJxgzIKHCRhZdOYjTrrFfl4J+sWXOL/q+C65Kizgitvj2XWL//rvRcSyWIOaQS9q1a648WFqh+R2Q1RaHjJAK7tPmDacyY/3yqelLTvnDqVrSRmWQVeQH3jmuupb20spzF/1dhxGQqonnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6T76HzY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728924370; x=1760460370;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4O3WHj924EBzwZIraxY0g+I4XhMDYiKUvirnZ20/Wi8=;
  b=i6T76HzYYOK94EFB8aE33gR80cEhamUWeWOVi1UAEpI35XMmeIUDDhTX
   LRzxv+gAGh449u2+EDjZQelmz2t38trZ//wzrVWaXn8u/90WBWmh0esLH
   xblsevt6cbFCtHnkDgQQZ6RAxu0KhzojLoQA6ulI6DfXbSe3cdUXeA5t0
   BnxYhn7hhN62EtQMg7k+QfdP7lhcmYT0UVVGnA34Qg6x28TDSQF4FEbSc
   lKip6DCy/1zt3H/rOMTA9mAX/MqSOjbpqP9X3prZCPSiuo7l0bb1+Q8FY
   E3MU2VTO7HN0rU09EOQWS4Zgddk5LqGf7iX80abWokzyu3rKdtoSHFy0q
   g==;
X-CSE-ConnectionGUID: yxZdmaewRLyWi1s6lUpFzw==
X-CSE-MsgGUID: AFXmE0AlSGC5LHraWRYd7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="32081379"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="32081379"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 09:46:09 -0700
X-CSE-ConnectionGUID: t1AV7FheQuaT703GjNkjRA==
X-CSE-MsgGUID: uU9TwV5CQESdsGNih5uOmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82409697"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 09:46:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 09:46:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 09:46:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 09:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFsEOHTAVbOwaOOajtSKDjLywyeRhX11rZOoNQUTtGOXMXNmOPLqVl5CwhKnlMQyZ3qf7Ieuu3K/uxbxEBTKydGgSTJhqITYRaDEluhfH6vh8j+mj9HMA5iZrXEuUFSIP9QF+CZjTChQ/llQGLUurG1ftidmSyworx2drTkrQMYr6UrhdFrjzKkZlrWMNs7iTTUtI787aWUqsbmKvu0J/X5SF5MZRpRWNLPW4FCmI7QAJjd3WzDwb0SjI2lBHwBOTJl6Zj3pSmJ/7lB8zf7NpyHPpGbJqtzY0NGz+BEQAlyHDVaFbAQwKU6+mzE0j7haDFrbDy7hmpFkTI42va+8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86saTht1C5DRZFH9f+RtEuu95NfcCAqjvcxvGnIRsMQ=;
 b=YVFgakLoiDZf9OE0VlKlehV4cgyfcy062KwhFx3PSZDwiPu8ACqTkkhslXmdEvyGux4A02Sb920aA/kHCzSUmUCSj2vttj39xlfBALfKKBVT4KngQfUHy2AT6ikMwHPn+aueMMmkbQyA1+1BGt7bwe6i3aReLPyXzoQH59Tt36Kq/kxV9ewn6fyWJZ56DXVX2xbmnJb0Tj3/qFsbPSQ4ItAySFWXo8vMllnkGYdOavGIlxaj83KdqgpcWkmBAZEOSa6gXvDMg5BxSC1HkgLg3FGb5KdRflZHpjFxMFn9ksVwQv1yTI8fBQ2gKMHyQcyrvXN+gn+bWy2R0fo9bXhQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 16:46:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:46:05 +0000
Message-ID: <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
Date: Mon, 14 Oct 2024 09:46:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Tony Luck <tony.luck@intel.com>, <babu.moger@amd.com>
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
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
 <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV2PR11MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 6388602b-69ed-4a96-4d7d-08dcec6fb1dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elN0aGM0VENPUWZidmpBZVRPbGo2Zk5nZTRxQTlrRmozMDE5M2M2a2tXQkhS?=
 =?utf-8?B?T0kxSlkzeTZmbm5yY3RlaVdDWGhXM2JJM3hnSkM2ZzU5bjRRcENYTUNvMXBN?=
 =?utf-8?B?MnB3OFp6bVdIbHZKai95TEVXQjVRbkI2eUwxUFh4WWJKQXdlOHdWYUdqT25Q?=
 =?utf-8?B?WGZpSS9oRVBDUVBoaUFCQmI0S012VVJYaHcvRWw0ZTloV2FTRjF6WGlyTnBS?=
 =?utf-8?B?SUVTWFYvMmUyR2IxMUhOdlpaTHBjYWdnZmNIZFg3eXFlRGJSMkdXbit4ZC9T?=
 =?utf-8?B?T2E1ODNCZ1ZNeVRwa1YrZW1SMGtITXZWdEJ0dnBUQXpVWW95NFVkellMei9x?=
 =?utf-8?B?Y241VDY4Q0J2Y2RZZEl5d0tjbHZRYllDaWs2eC9SRGFzMFJDSEpSTHVTbGJF?=
 =?utf-8?B?Vi9rSTBQSjJHSWpXUjRsa0lrcVpCN0lGbmppTVRabW1iYWc2M0N4KzdnTVlJ?=
 =?utf-8?B?eGNNT0N3NEJlQnRsNkZ5bVJFcFhqTGkyRmVtSTVxYzdTR1htRElBQ0VVbTJB?=
 =?utf-8?B?Y3psTWpWYUN3WGpmWUFPUlVuTUNmUE94dG83YXFpZ1JENU0rQXpMMDN2WnZC?=
 =?utf-8?B?ZlQwWFhHMVhoeWsxTGhqdVFFYnpYMnl0T3dienl5ZGd2b1FpOUtHTHRPeW81?=
 =?utf-8?B?eHRTSENFSWRVa1lyeDd2OXJWNEdJZFNXbXArZ015NXNQaFdOeEh1bWJiQXZj?=
 =?utf-8?B?c3c2RDk1NHRsUnpYell2eFQxQ2QvaG5LKzl0MEtQdG41bU5XUmhra09uQ2Jw?=
 =?utf-8?B?ZERBWmVIN200d0JhdzM2Nm01TmNURVVFN3p6R1FPa0IreUpnZElFZ1hPR01M?=
 =?utf-8?B?d08rWm1nUDBpK1RWeUxEZkdmQkx3VjMzc2VZaHNmYVpJcEdiWmo2ZXlHQ2o2?=
 =?utf-8?B?cUo0U24wZUlVa1RVZVRnNmdwS1VwSU9EcjMvWnZtSlo1NGpGR1FGQVJIaFZT?=
 =?utf-8?B?eXVIbUY5VkNkL1FBNlFhSmJYZlhjRm0vNGxtK25jTmQ2YTZJc3JCMkJNQzYw?=
 =?utf-8?B?U1htVStBRkxwNzFFejc3R0RlWlpTTzZzbzBEelVLWC80c2o5MWw5b0NSUFI1?=
 =?utf-8?B?WnBONlhObHhQV054dldhYjVyTUdqdndiT1BJNFNKZXM2OW8rdzQxaWxXM05a?=
 =?utf-8?B?RzR5eFBZMFYweWFmektDbDlwelowQnVYZndGZVdzUWJpK04xamZOcWc1aUUv?=
 =?utf-8?B?SVZvcXBXQzBBTFJiMTh1blJzYmMzL2ppNEFwOWltZVpBTTMwQUtRbS9KLytq?=
 =?utf-8?B?OHJYbllYREFqanJsYTlyT1MzVzc2Y0VWZTNNdEpvR3JDNGNVcXV6VFFnMFBL?=
 =?utf-8?B?c2ZsQUM3Y2Z2MFh3WFIxeXNrcStnVENGQzVhQ0NoL3lydVlONG5yRjJRWFhT?=
 =?utf-8?B?RmN3YUlXOW04bEhQMW13d0NnUkNPVmc0cGdYNXVZVXBCV1RXV2F5Sll2TjZO?=
 =?utf-8?B?U0JuSGZ4WU82L1k2SWN5U3dYb0Mva2w3cUY1ZGJIY0VJMkNuN1FXZytZVTFC?=
 =?utf-8?B?UVp2Q1h1bmtnemt6LzFjUnhjaFRhWC9saUV6WlJpUEtvOGxHUDJXbFFWS3dn?=
 =?utf-8?B?eUNHbGg4Um9tMW5XQjJzTUpEVG52YXZlNUZUazVLQkxkb2RWQzFlZldPRXhm?=
 =?utf-8?B?c0J4ZUh4Y2E3amhrZXVxTVF5N2UrYWJzbjJ2YmMyQlpYOU5QZ2gzektucERs?=
 =?utf-8?B?OSs0azZ5bHZRQUNvZWN2eE40ZlJaMFhxbnNyMENROEhseG1NV0ZZakJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEc2eFNpVE45alhiZVJGUjJYSmV2Z3BkOW9Va1NpdFpLMjJnWWRCMFNnWnFZ?=
 =?utf-8?B?SW9HVUpJdFVyaU9BVmZybFBQWEpMeEdCaFhadE9vMVFCdHIwdnliYzBUdWll?=
 =?utf-8?B?ZkFhaEtaejczVTRnZjZvK3hReUgwbjJZamIyYXJYckE2cUR1RzdNMFI1ekJE?=
 =?utf-8?B?eTVaT2hURTlLWnFwNGhXVk9xRC9EOVpPSUtvOGwrYlZPVERkTnc5YzZjQlNM?=
 =?utf-8?B?SjhCSzNmQVRpbkp2U0ZXZFpQbEkwN3NyV3pGSjFXSUYrVXR3a0lTdmM0MUtF?=
 =?utf-8?B?QlhGd3o2bTJhekJhcUZGZk04QS9sRHlkb0MydHlqU0Q0Q1JkYzloYjZlZkVW?=
 =?utf-8?B?a3poT1BGWEVjMVRrSHJjV1Vxcy9XbW0wT0taRHlRdjZVNnhMN0ZZVjlYSC9U?=
 =?utf-8?B?Mm1ab1dLL0IwYUI1N3NZQlVOZWk5czdVSzFXTlZuK1Z5QjZyQVRyd281MUF2?=
 =?utf-8?B?RmwwZVp4dUZ6TWgyd3ZNUDZtVWRSUkNVSjBsSHJHSTR4R1ZuREZyZVE5V3pY?=
 =?utf-8?B?QjRTR05GL3ZyNjFiQnBMWmdKWEtkZUJUdHl2NXU5WndianNra3RNYnhjdDBs?=
 =?utf-8?B?aTZUd3d5QXRPaEoycGV2QXR2V1NOMm9tZzJ2N3hwUytWd1hjRk1uOTZ1Mlhl?=
 =?utf-8?B?UG5kcE9XQnJSSldvSlhxVzNBVXVYcWpJdWs0bFl2eE95MWdmNDFrZTN0T2xk?=
 =?utf-8?B?U21YTEZTbVNvd0Q5QTZDSkJCL2pjQ2FZMHNJUXRWQnIvSUpORXgrMDZRbjhP?=
 =?utf-8?B?ZDRWWSt4YTkrUzk0eXJ1amlKenlBN0xJOWFZeDNPRUhCS240QnFHdXh5ZDYw?=
 =?utf-8?B?Q2l2V0R6b3FFUHVhZ0lWSE5NYzFFa3NPLzFoR2hXWko5NXFnN2ovZHFjVGMv?=
 =?utf-8?B?VUt4TG1SbUNFUk1sMGVtL090dGhuN1VwaG5sVlBqa3hSSEVQR2JvY0Rtckgv?=
 =?utf-8?B?QVV0dlBHNS9KcEdvWUdHaGYycG9BSzREUkZ2Qk9NdTVKZXVQZXQvNTFUdTZU?=
 =?utf-8?B?cTNtYldnQmd5VVE3NHhETkFlRWZiR2w2S1AyY0pSaWMrb2JJRC8wQlhUVWxB?=
 =?utf-8?B?dm1nRnZmSElzeVNhZ05mcWhoeFQzQnVEais4dUxTdU83ZU9ZK2UrMHV1VVZu?=
 =?utf-8?B?L0U3Y2grbFFtanJGZEVPRzNOellmVEIreVIrbXJydWFJeFFRdms1cnZZUGJ4?=
 =?utf-8?B?TmV3US9JeS9ONmppNjNhMkY5NGdKRlZIaS9LOCtHbWlNUDNjb2hTdVVGdUpI?=
 =?utf-8?B?YTdVMklGMjhYNW41SHVqTUdyckw3NTB2OWpGbitjZy9taHRnZ1pHZWJNVDdR?=
 =?utf-8?B?RE9qN29uQWJvbHlMdDdlc3R2MVNIMDgrU2lVQXZoNE45TWxUTGZzYnpzbTRS?=
 =?utf-8?B?M0RNbnNubEV2aUE3cllEeDc1L1FPWHd2dmFVMk9ZSXBtQUFWalJDL2NCR2R3?=
 =?utf-8?B?MzVUYVZJUUx3bGxlZWtCSklmdHZGZ0xGdzFYaDZGUFdHQlI2aVdHSzhrdkJi?=
 =?utf-8?B?eFE5WHZUTGZHdHRya3JtTytBblA2eXhaeURwM0ZRZUtZSFVpYU9ybTBjeElj?=
 =?utf-8?B?TmwramRETWgvYlFjZVowZnhlczJueW9vNXZhWWxKKzgxL25Oa21NWHdyTnZw?=
 =?utf-8?B?UVVRSWlPUzBUUGhVUDYyNlB3MmVtbnZqRmMwZG51elV5ZWR1OXdqMjFmelFq?=
 =?utf-8?B?SDNqeGZaNjN5Zzh3RnhCNTJ2RUFJTUhuZ1p6cElpMVpMblNHQTZFNHdXSUhx?=
 =?utf-8?B?Q0NGckh2Nm1CcHBBQjFWVlk1QWdYVDhscnJ1UCtVTVVNZ2xPdFQ0enkxMjd4?=
 =?utf-8?B?MmtveUtFdWtIU1pvc1VNV0gwM04xT0kxQy8wbVNtMHFRYlA4L2RXeWRVcXhu?=
 =?utf-8?B?b2Z1RlhxbjlyQlBYNmhVRHQ4K25UaUljcTFtR1BNU0owZDk3WTZ0aGVSWTlO?=
 =?utf-8?B?NGxyOUtwRXhVa2tCMkRIY2hsdnBQWVBXaVJUL2NNY1pnZVgzOTZiSE9ZVzho?=
 =?utf-8?B?U1gvYmJPQjhYbTdiY2d4NGVidGYvWHU1NUE2SzQwYWd5ZlExaTA4VG9jOWQz?=
 =?utf-8?B?UUxUaUZ6WTRVQU1SaFVlRTlJM0lLWXYzNzQxRjNlRGVVN2ZsTVROQzFrcHVy?=
 =?utf-8?B?elFUblVBNnhHeENEaVlSTitFNUZVd1dHTGxicnA4bkNsWVBxaE4zc2wyaUs3?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6388602b-69ed-4a96-4d7d-08dcec6fb1dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:46:05.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZULrt4WPdaNE9qx+JnklIfUfqAxW96okPJTX2yu2xAQ3s/yIFptcrQD1s1FS5r68ctkchbEqL6oNR8CwHIMhuMnAvp8jHLqusUqIu1ZoRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com

Hi Tony,

On 10/11/24 2:36 PM, Tony Luck wrote:
> On Fri, Oct 11, 2024 at 03:49:48PM -0500, Moger, Babu wrote:
> 
> I.e. the user who chose this simply gave up being able to
> read total bandwidth on domain 1, but didn't get an extra
> counter in exchange for this sacrifice. That doesn't seem
> like a good deal.

As Babu mentioned earlier, this seems equivalent to the existing
CLOSid management. For example, if a user assigns only CPUs
from one domain to a resource group, it does not free up the
CLOSID to create a new resource group dedicated to other domain(s).

Reinette


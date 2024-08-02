Return-Path: <linux-kernel+bounces-273116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AF9464B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27278281741
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5F350284;
	Fri,  2 Aug 2024 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bhs53D+w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980C33DF;
	Fri,  2 Aug 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632152; cv=fail; b=ar04pCadyobH4nu7Ub3lhZcekkV9H7wivghiHOwEPCWmhulwqpjf6Gxv4RRIPhC8E2z5VNefIYNexsqsMWt3V9lv3f3wF/ExaaeJ5jlsNfcqmh21lpw0/oomgGZi3ZQS3SUtKSe9R72LWFomU+1Qj5d7OQLaE+iplEbLP7Pjgzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632152; c=relaxed/simple;
	bh=/2hdNJIxtqyUHnD7/a113VMhdnZANmEi7hgnF1qFtgI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fpHBGEK9388bpZYgQzStzS7xRESXF/26xx7MLR5JBvJrsy31bCUqTkE0bfW2hPBgj6d5ZaeKAQjHmilSe+frjf12R7DSS5ywR/pyVRKU5s/ZSXaaOit/WSacecp/M8IFmtDcwP1VaR2HCD3Da2duK2rDFOC77J0H/jlZAX3tzKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bhs53D+w; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722632151; x=1754168151;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/2hdNJIxtqyUHnD7/a113VMhdnZANmEi7hgnF1qFtgI=;
  b=Bhs53D+wtsTcZoq5KXrpHtLMYhCPGBMF8LXalBLKoPCQ5OvSPSEBDa4m
   FaGRZkoL7AEk5jadPdIiiRGOteDEqvDG7MMTZ6pGXVb3nUxKILpn6EEYw
   gUJHEcVN5ZjKG5xmFSTUf4JgD0OqgxMxKKTXoTmCBOUWHv3Zvs/sXy+Eb
   JyFqGHoHcqn0WRRBNwQgGkOCb9LPqymQO6tQg43Dh5c6gTIFidFq0nrcz
   /O1BmtsrVzJvpct4B37vslzz4l/ThA/bSHnSyU1LkrG2ixurzlMg6pf/M
   aHXHB9d5OkeemAJv7kjJgIYKVl92FgT8qUxXl5HUfR6viJxkQQKdIZFah
   A==;
X-CSE-ConnectionGUID: gvVKJaXLTkWRzwrr8dS42A==
X-CSE-MsgGUID: p/QJGxkhTemNINiV5oI2KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24535908"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="24535908"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 13:55:50 -0700
X-CSE-ConnectionGUID: 6Ptpm5qNQYqNwE+bFUWrQQ==
X-CSE-MsgGUID: 1PzXej6LT7SkrkSINZ02kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55463283"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 13:55:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 13:55:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 13:55:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 13:55:49 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 13:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQZ8/I4hlz8wgWAmSKtaypx/+gvExKvGRQdDAlo7dg5d8Ya3Yk2RWavRtyo3FSaX0w8mVeKo8QMNAwQZXXndQxdDq9+PbNO1qLo+1aZx6dvNzF5G6gKsu9ukRtPmQ/qBHTTugta7jbw/thFWho1SI68HLj4oliLnx24wO4JYP7xcpBT+tF/LiVP/SBUgbHtegU8NK+WI56UfvMQKcAPcZcviOefeRXvQkKceLw5prmbVWlUtImWrZiF8SnxOcf9OvnXKO1jE3hSaNuRppCkKIdCCI2H8epnEfzyEDSXkPcbc/3tgXiAzACEQrkvsua7krxzYQXi4p06n0PvjtplKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAGp030fEQlMHJ6ld0DiIZWJGQjUxCcS74isw79165g=;
 b=UQy0tasyjjJaHSddaCngEarcqWAFd4C7H5YWNH7SDxihfJeDLzad+GaL2FGqi3//LKLy4f4srdgY28hq0MGzMMbfweYXMa5xdYfOEmNIfkgHil3RTFA9vEj6sEzJ1UVgU16DQIPG9cegqbVEvszBCuXryjq8IwyL3tWYOX3Qd6zTaJTJDGGLW1gi4KqxZo4QHDGsqYo5A0Q6pGq0Wb5kcj9adcGmpnatIfXe8foyiz04O0BAtrgBvSQo2e1/eNnckO7O+Pc+ZoHU3LgN+hWZkPm1Xzp7Wb9Ih4F5pfKB9bK2WSGsW3TNFftfADJKmvqOfwENEU9/O7A9jRKSejNR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 20:55:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7807.034; Fri, 2 Aug 2024
 20:55:45 +0000
Message-ID: <b9e48e8f-3035-4a7e-a983-ce829bd9215a@intel.com>
Date: Fri, 2 Aug 2024 13:55:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
CC: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <tj@kernel.org>,
	<peterz@infradead.org>, <yanjiewtw@gmail.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1720043311.git.babu.moger@amd.com>
 <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
 <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
 <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
 <CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0302.namprd04.prod.outlook.com
 (2603:10b6:303:82::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3410fb27-e9b8-4391-4021-08dcb3357a8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGRSU1ljSTM5cWd2cldKNEpZRDk5bnZjVGk3Tmt6djRZeGFIb01PeGRxem1P?=
 =?utf-8?B?d1JSMG83Ymc4ZFBXWWpFVU9KYTVacXlXN2xlWnRRU05FQUlvL3dYQ1VhRlRV?=
 =?utf-8?B?cFhvQ2g0OHhZelh0TklMVTE3UzF2OE43cFp3aDdReW00S2IxRmUxL3JlSXNu?=
 =?utf-8?B?L2xPc0p4SlphLy91bEZkazdycHFlOWdWVFdiMVJ6QitKbGZzejZXTmVjeVNP?=
 =?utf-8?B?WlNSZWI3bC9ZLzhXMUs0QndSUW5sazlvK1NhcDBNeWZqKzk5V1N5ZHlMRFRs?=
 =?utf-8?B?OUZjNkt0OHRNNkpoMzNOWXV3bkkycG81SXZKWVNDN3lkVTZOcU9JWWV2SnZq?=
 =?utf-8?B?RHdkV0ZMQVBDNEYvZHl5Z29LUnFYSjBzdEVXMGx6K1JwMmh4WlpBb2dELzNw?=
 =?utf-8?B?eE44aUI3M09TVmtFV2U3bVVGbTBSOVEwaWRTcDA5UnJVYkNXa2VSb0JQdXEz?=
 =?utf-8?B?WWExTWdiZnovZFhGeXJ0aVBBVkhRY3pWNzFpd3lxTk4rV2IwZmpXU01jQUli?=
 =?utf-8?B?eWR4VHZWOUNNVTQ2VzlBZ2tDY0ZMNFRFN0hFdCtEWEtsb1JYOGFCTTlRb1lB?=
 =?utf-8?B?QzF5dHJqQ2VFTmpwZkhYWnVEYWVhdnVUTmw0N3MzTkhhdmNYeEVUYnNDd3lo?=
 =?utf-8?B?anJrSUUrS0drQmI5ejBYOGVtS2h2SWJWYzFlYnR1cHNZNzNkblRSR2tXTFlD?=
 =?utf-8?B?aGdrTUc1bUJtcXFsb2o1elJPNnh0K0hVcVZsajZSVmVPTWNKY2pqT2U2Qm5M?=
 =?utf-8?B?OUhtRUtqQnh6T2dUa1N3RHliWUtMazFqMWkvOWZDSHk1OUtYeEk2VVJyd0E3?=
 =?utf-8?B?SzdBMTdJd2VJcWNtWm54L1R4azJuYzFhNlpPM1BrSldJdklJY2NnRlRwayty?=
 =?utf-8?B?MDhzZncwVTFOblc0bFBtZVZ1OVppVDBLdlZxc1BkcDE0T3RSSFNDNVJ6Qjls?=
 =?utf-8?B?Mk5qOVo0akNGem82T2sxaGd3ejduTHJXUXNSZG4wc1JRWm4rQ0lqUUY2YkNi?=
 =?utf-8?B?T1RFWXpicVZXKzdadnBaa2oxR0liUjNpME1GUFNQbHhSSEgxSFE2TVJmWDVW?=
 =?utf-8?B?STNIaVJUcVFXbTJ6R3Z6NXFDd1BoVGpYRHN5R2lJYVU2NTYyQTBQcWQya05y?=
 =?utf-8?B?VHNZcHE4VThlNWZLcm9mMnh5T0ZGU0VabFZaeldyKzRkU2h1VktWeCtsalpQ?=
 =?utf-8?B?VWp2SXN2czl6by84SlRURUxLMzl3YUxxN0V4K0JlRTQ0Sks3UDhEbnhKdWNy?=
 =?utf-8?B?QUQ0V09EMFgySGh3QkF4bythVjRXV3ZKYjZCdWd4eFBXWVNLelBWNis4Nkcr?=
 =?utf-8?B?YUlBZ3ArcW1oakMxMEtISENqOGF1Y2d0dCtycU1kZnBzaTJ3aDJrYjdTcGtJ?=
 =?utf-8?B?a1IwMVFSUDdoTThKVmtGREdhOEt4U0pWVVBVb1MyanYzMUk5ZnMrdjR3cVNO?=
 =?utf-8?B?alZFcERNNUNERmhwRjcrUThzbjVKQ3N4MGRoZHZEbmc2RndSNzdTYzRRb04r?=
 =?utf-8?B?a1dDUElraG5oc2V4TU03YTQvcW1WeGwvT0ZwY01tNVhpaVBoemxOby8xWUNZ?=
 =?utf-8?B?aHdvbWRFQWFuYkVicmdtaEMzWlR3azNMN1pHeTBYOUE2ZEdGRWNWM01oc2ZU?=
 =?utf-8?B?MTdMektJWU1RZGZBMkdNZ0FXaXVHQ3BIWGVkWjdOT1NCWVhsUHJhZEtnaFc2?=
 =?utf-8?B?NXR5ZkVwZ1VHSVk0dU5oQm5tYm9VenRrN0oyVnRIMDRmUUpId01Jcm9xeVJI?=
 =?utf-8?B?SEYwMXNYSVh5MEl1WkkrRVBMZlY1cWVIU2Z6M2NuYzBwR2UvR2NpcmVrMHNP?=
 =?utf-8?B?ZkR2bjBZNEJiUi8rM0VXdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkdQZTdNZG92Y1Z2MzZsUndYVlhpWE9hNi82Y2ZFdDZUMWNTWG9uUUFOMHJz?=
 =?utf-8?B?V0UxWUY0TkE4SFVlVUZxSzRmZGZKaTZGYU5rb1N5c2I4ZTNhME40WTBmK2xv?=
 =?utf-8?B?cGNjeXNxV2lnRklySHFGM2IyTGcvTkREWHdqRTg1cm8yTXV3R0VqN1lJWE5K?=
 =?utf-8?B?VDdlbW5jWm9QRjMyYnNlRHpLRW50WWR1eFVlOTJLeGZZc1lya0N3WjZ6RkdZ?=
 =?utf-8?B?eGxlUDArOEhLeXlEcCtpajZkZEhVR3NTQnpOWXlsVlV0U1lrWEtWbjZwaDND?=
 =?utf-8?B?SVVHZVBwRzlkeVV3c2RLdDlqdkVtcFN4OWhDTk1yRnJxRmdiRW9ZMzJLcFN3?=
 =?utf-8?B?Nk5rZGJLdmo4YnAwcjF0bG9kb1ArM2ROVGVQYkozL2RzLzdwUU5TLzhtZXFu?=
 =?utf-8?B?ZTdmODE5S1kvdE13a1QwelFtbDJiU25tU3VqWXpjWWFvamVWWURwQ3BEN0R0?=
 =?utf-8?B?TXpDWTYwYTRSbi9KQmhxVTh4QlYvU3NHMktkb2Zua1cyWUpiNzFCVTJKdGRp?=
 =?utf-8?B?V2xSOTd1UW5RM2w1L01VdVRoTmpZcXlkMDlwT0I4elZBb2dYbmhEbTQxWUhN?=
 =?utf-8?B?MVNtZm1UMTI2enFWeEEvZGZlOXdQRFVSMWRwNnpDQmk1NWk5d3FISG8vLytq?=
 =?utf-8?B?RTR3aDRSZTlld1ZRS0VRMmsyc2xvRGFkOGJsOTJvakQvNktqekVQSU5jZ05Z?=
 =?utf-8?B?ampLSmdWUG84aE9weUsyT3lQYUphUTdNVFE1Uk04WkhwREFXaXloaWpOV1V6?=
 =?utf-8?B?NHEwNy90VWNVem1EL2EyTlRXK3BRZS9DOGxVRC9TdVRXSVk5V1lXOGVLUGtX?=
 =?utf-8?B?T1hSNlBIWWNKZG9PdE1nOXRuWVRqQkNTa0VZaFo2SnJGaitjdGdsaXU0Unha?=
 =?utf-8?B?ZXlyb0cvQlBPcmo5aFBBek1WUnQ4ZWxIMUZBNW5iSjZFeGp4eGljM3MvQ0E3?=
 =?utf-8?B?NEo0Rm5jb1BPQVpURmdxTzMyVFRVam9nTW9zRjFDdTgraGRqRHprRkw4TWNJ?=
 =?utf-8?B?Nm9MYWZTL0o5SDcySTlLZDhodmtpZkhWL05hWDFVRnZ5VDMvN3pWd1lVd0dW?=
 =?utf-8?B?NzgyMUZ4cnM0QWsvMUl0cVZvU1hZeFlhc2tFTUdLR01HTXRFMkxCcG1GbVlV?=
 =?utf-8?B?U0NRKzdOdVRvTzdzTnRDUjVIeEY2KzFBYXpTUFBsUnJpdjVOaGl6eCtnT2FX?=
 =?utf-8?B?MEVaSjZtVmVtNzVYSUtmbEcrUHRVYXJ1bkErREx6dXJlSlBEaEpFTVBrVFBB?=
 =?utf-8?B?MHRvOWt5R1hpM3hWcjZpQWxtOVcwSjRmbUNkUlBzcDQ0RHkwZmtnck9uaDRL?=
 =?utf-8?B?WTEzOTJPZGhqbnBVVlgwamxaTXc4TEhOWHZoOTRHdi93RXVuNWJpYXIxZTVW?=
 =?utf-8?B?VTgvZFA2ekhoeElvN1BuN3VXMXU4cmZIZG1GV0NJVXgvS2VYNUdWQ2ppRjdV?=
 =?utf-8?B?dzAwbndOSnYwdUl1WHVDRm9KS0syTHZXUVVhVHpDRTlGSytNSmZ2QTkvcGIw?=
 =?utf-8?B?UzlBRFNzTDhMaFRhd2hrSDdBUlkyUXB0M20wV3pMVGZ3QldjRnZPck8zbWc5?=
 =?utf-8?B?ZkI2ZFNYWGpRczhwRlNLTWkxblREWHZZc3ZMY2VuT25jeGNzVVBPVDdlT1du?=
 =?utf-8?B?OEFpa09nRmlYVnBkU3YySTNQN0RSMjVnZ0hqMDBuYUlPK1V1Sk84RVZadmMw?=
 =?utf-8?B?ekpIcms5NHNVMU4yZWZOby9WWWNSalI5b0djYVlyZWJjTFo1K0NPR1Y2VG1M?=
 =?utf-8?B?eVp6clpOZDZhalRjWm9obUlJaEMwenhaeWhGOVNXVE1YMm9SNTNoaTc1aExI?=
 =?utf-8?B?UENYa0s3TnJlNlRQRExCa2tZYnhTZ3JteTNRVG5hTXREZUlkMEUrWWE1a3B2?=
 =?utf-8?B?SEtzYnFodStiSDFPWFA2OWorYWVRcm5rRDRYb3NkQXlVc3dCSldEL3VyMHB1?=
 =?utf-8?B?L1Q1WXVGbzZvQ3FNT0NaVCtiSUNnNEJjL2JHUHUra3BRMGM2MlA4RGFLSDlX?=
 =?utf-8?B?OHcwcjNqbkUwc1JWczVsRDAvc09VcTdicktmMXd6TFlvS1FraGZCTjl0ZlYw?=
 =?utf-8?B?YktSUGxCRk5DNlVWRnhab0hIcHJWS3RpZkkrOVdtenU1SXI4TTE4bzU2VHRM?=
 =?utf-8?B?RjIwc2V0S2l6MFNEK0hRTDFSN0dLUGFxZ2NXdHBwdHNwcVNic2lNUXk3a3Vx?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3410fb27-e9b8-4391-4021-08dcb3357a8a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 20:55:45.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtLrD2jlWyTlV/yoi0u/ahbyncP2Lpvh+Xt4qDdsQ2Ey+5b5ZRmXsjUG62+Z5G7ryBKcIvmDXmjyHbzUSoZXCQ1l1n0ZAMKn0uKs4szletg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

Hi Peter,

On 8/2/24 11:49 AM, Peter Newman wrote:
> On Fri, Aug 2, 2024 at 9:14 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 8/1/24 3:45 PM, Peter Newman wrote:
>>> On Thu, Aug 1, 2024 at 2:50 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 7/17/24 10:19 AM, Moger, Babu wrote:
>>>>> On 7/12/24 17:03, Reinette Chatre wrote:
>>>>>> On 7/3/24 2:48 PM, Babu Moger wrote:
>>
>>>>>>> # Examples
>>>>>>>
>>>>>>> a. Check if ABMC support is available
>>>>>>>        #mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>
>>>>>>>        #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>>>>>        [abmc]
>>>>>>>        legacy
>>>>>>>
>>>>>>>        Linux kernel detected ABMC feature and it is enabled.
>>>>>>
>>>>>> How about renaming "abmc" to "mbm_cntrs"? This will match the num_mbm_cntrs
>>>>>> info file and be the final step to make this generic so that another
>>>>>> architecture
>>>>>> can more easily support assignining hardware counters without needing to call
>>>>>> the feature AMD's "abmc".
>>>>>
>>>>> I think we aleady settled this with "mbm_cntr_assignable".
>>>>>
>>>>> For soft-RMID" it will be mbm_sw_assignable.
>>>>
>>>> Maybe getting a bit long but how about "mbm_cntr_sw_assignable" to match
>>>> with the term "mbm_cntr" in accompanying "num_mbm_cntrs"?
>>>
>>> My users are pushing for a consistent interface regardless of whether
>>> counter assignment is implemented in hardware or software, so I would
>>> like to avoid exposing implementation differences in the interface
>>> where possible.
>>
>> This seems a reasonable ask but can we be confident that if hardware
>> supports assignable counters then there will never be a reason to use
>> software assignable counters? (This needs to also consider how/if Arm
>> may use this feature.)
>>
>> I am of course not familiar with details of the software implementation
>> - could there be benefits to using it even if hardware counters are
>> supported?
> 
> I can't see any situation where the user would want to choose software
> over hardware counters. The number of groups which can be monitored by
> software assignable counters will always be less than with hardware,
> due to the need for consuming one RMID (and the counters automatically
> allocated to it by the AMD hardware) for all unassigned groups.

Thank you for clarifying. This seems specific to this software implementation,
and I missed that there was a shift from soft-RMIDs to soft-ABMC. If I remember
correctly this depends on undocumented hardware specific knowledge.
  
> I consider software assignable a workaround to enable measuring
> bandwidth reliably on a large number of groups on pre-ABMC AMD
> hardware, or rather salvaging MBM on pre-ABMC hardware making use of
> our users' effort to adapt to counter assignment in resctrl. We hope
> no future implementations will choose to silently drop bandwidth
> counts, so fingers crossed, the software implementation can be phased
> out when these generations of AMD hardware are decommissioned.

That sounds ideal.

> 
> The MPAM specification natively supports (or requires) counter
> assignment in hardware. From what I recall in the last of James'
> prototypes I looked at, MBM was only supported if the implementation
> provided as many bandwidth counters as there were possible monitoring
> groups, so that it could assume a monitor IDs for every PARTID:PMG
> combination.

Thank you for this insight.

> 
>>
>> What I would like to avoid is future complexity of needing a new mount/config
>> option that user space needs to use to select if a single "mbm_cntr_assignable"
>> is backed by hardware or software.
> 
> In my testing so far, automatically enabling counter assignment and
> automatically allocating counters for all events in new groups works
> well enough.
> 
> The only configuration I need is the ability to disable the automatic
> counter allocation so that a userspace agent can have control of where
> all the counters are assigned at all times. It's easy to implement
> this as a simple flag if the user accepts that they need to manually
> deallocate any automatically-allocated counters from groups created
> before the flag was cleared.
> 
>>
>>> The main semantic difference with SW assignments is that it is not
>>> possible to assign counters to individual events. Because the
>>> implementation is assigning RMIDs to groups, assignment results in all
>>> events being counted.
>>>
>>> I was considering introducing a boolean mbm_assign_events node to
>>> indicate whether assigning individual events is supported. If true,
>>> num_mbm_cntrs indicates the number of events which can be counted,
>>> otherwise it indicates the number of groups to which counters can be
>>> assigned and attempting to assign a single event is silently upgraded
>>> to assigning counters to all events in the group.
>>
>> How were you envisioning your users using the control file ("mbm_control")
>> in these scenarios? Does this file's interface even work for SW assignment
>> scenarios?
>>
>> Users should expect consistent interface for "mbm_control" also.
>>
>> It sounds to me that a potential "mbm_assign_events" will be false for SW
>> assignments. That would mean that "num_mbm_cntrs" will
>> contain the number of groups to which counters can be assigned?
>> Would user space be required to always enable all flags (enable all events) of
>> all domains to the same values ... or would enabling of one flag (one event)
>> in one domain automatically result in all flags (all events) enabled for all
>> domains ... or would enabling of one flag (one event) in one domain only appear
>> to user space to be enabled while in reality all flags/events are actually enabled?
> 
> I believe mbm_control should always accurately reflect which events
> are being counted.

I agree.

> 
> The behavior as I've implemented today is:
> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_events
> 0
> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> test//0=_;1=_;
> //0=_;1=_;
> 
> # echo "test//1+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> test//0=_;1=tl;
> //0=_;1=_;
> 
> # echo "test//1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> test//0=_;1=_;
> //0=_;1=_;
> 
> 

This highlights how there cannot be a generic/consistent interface between hardware
and software implementation. If resctrl implements something like above without any
other hints to user space then it will push complexity to user space since user space
would not know if setting one flag results in setting more than that flag, which may
force a user space implementation to always follow a write with a read that
needs to confirm what actually resulted from the write. Similarly, that removing a
flag impacts other flags needs to be clear without user space needing to "try and
see what happens".

It is not clear to me how to interpret the above example when it comes to the
RMID management though. If the RMID assignment is per group then I expected all
the domains of a group to have the same flag(s)?

>>
>>> However, If we don't expect to see these semantics in any other
>>> implementation, these semantics could be implicit in the definition of
>>> a SW assignable counter.
>>
>> It is not clear to me how implementation differences between hardware
>> and software assignment can be hidden from user space. It is possible
>> to let user space enable individual events and then silently upgrade it
>> to all events. I see two options here, either "mbm_control" needs to
>> explicitly show this "silent upgrade" so that user space knows which
>> events are actually enabled, or "mbm_control" only shows flags/events enabled
>> from user space perspective. In the former scenario, this needs more
>> user space support since a generic user space cannot be confident which
>> flags are set after writing to "mbm_control". In the latter scenario,
>> meaning of "num_mbm_cntrs" becomes unclear since user space is expected
>> to rely on it to know which events can be enabled and if some are
>> actually "silently enabled" when user space still thinks it needs to be
>> enabled the number of available counters becomes vague.
>>
>> It is not clear to me how to present hardware and software assignable
>> counters with a single consistent interface. Actually, what if the
>> "mbm_mode" is what distinguishes how counters are assigned instead of how
>> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
>> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable"
>> and "mbm_cntr_group_assignable" is used? Could that replace a
>> potential "mbm_assign_events" while also supporting user space in
>> interactions with "mbm_control"?
> 
> If I understand this correctly, is this a preference that the info
> node be named differently if its value will have different units,
> rather than a second node to indicate what the value of num_mbm_cntrs
> actually means? This sounds reasonable to me.

Indeed. As you highlighted, user space may not need to know if
counters are backed by hardware or software, but user space needs to
know what to expect from (how to interact with) interface.

> I think it's also important to note that in MPAM, the MBWU (memory
> bandwidth usage) monitors don't have a concept of local versus total
> bandwidth, so event assignment would likely not apply there either.
> What the counted bandwidth actually represents is more implicit in the
> monitor's position in the memory system in the particular
> implementation. On a theoretical multi-socket system, resctrl would
> require knowledge about the system's architecture to stitch together
> the counts from different types of monitors to produce a local and
> total value. I don't know if we'd program this SoC-specific knowledge
> into the kernel to produce a unified MBM resource like we're
> accustomed to now or if we'd present multiple MBM resources, each only
> providing an mbm_total_bytes event. In this case, the counters would
> have to be assigned separately in each MBM resource, especially if the
> different MBM resources support a different number of counters.
> 

"total" and "local" bandwidth is already in grey area after the
introduction of mbm_total_bytes_config/mbm_local_bytes_config where
user space could set values reported to not be constrained by the
"total" and "local" terms. We keep sticking with it though, even in
this implementation that uses the "t" and "l" flags, knowing that
what is actually monitored when "l" is set is just what the user
configured via mbm_local_bytes_config, which theoretically
can be "total" bandwidth.

Reinette

ps. I will be offline next week.


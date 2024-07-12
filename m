Return-Path: <linux-kernel+bounces-251191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F649301EB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380901F22C63
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11255E49;
	Fri, 12 Jul 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEdVE7Hn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB06EB46;
	Fri, 12 Jul 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821878; cv=fail; b=HnMg81Fv3Q4XybttWh0dsDVuwX3jT8tNzqV4wOTR9FcPw3U78mKD4a9nDp7t7+I4uJmHrpIPErnUCWi0nSqiaxDv+jguEXbBtPB6WLIVr6+jtSjKuCwWiEw9mR0dSDH9sajWYcrLhmQxhlgn099btLGKrAtpWVrjl7IvQPIyHfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821878; c=relaxed/simple;
	bh=FjI7KPUj8EnobyxRCI6diZyzzwEW2DFdZGml5RZVKhg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9/CztGiMGxg+WiNmwT7WkvURr6BCqK79avoEY0k7e2S7J6oGrZbkb+hQeilpZnaUA1YSnmxtHUnWlbdkpjxautAgYHJlUcc2yuHo/FzkQCP6TqbbrMJqF4sc9H4cdwGoW3g1NJ6Vp5Z+x4JRlZcHTTfW/c8O19Q5YEZg2+/0PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEdVE7Hn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720821877; x=1752357877;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FjI7KPUj8EnobyxRCI6diZyzzwEW2DFdZGml5RZVKhg=;
  b=NEdVE7HnF7mDzRkn1SxuDX7LdlP87IVABnAFgrn6yG737c+hhfYa1bvQ
   De/9/KzY870NMIcNYyi1wwmerBYt397G5Gw30nW5ipLbrW2S6eB45kOr3
   gp9dgEa05nNP+SE8hsiTY/lIfQ4GFVb2vkuldDgjBX8rWZ9VaP5G6PCHA
   J9PBH+h6ql1PRCkQ6QV+hQt/jyX3eocw8KHTSZ39jG10b/HLHg2EV91I1
   NWPes0qiiO8CviKpFLH3zBJtP/r02xrggmFxjVqy3W+ty00hzAzQrigan
   ldvQfqpAQhkMWpseNQxhcZRbLFUWHDtsSwQL+Tk7YWROOpqLyVo7GNMep
   w==;
X-CSE-ConnectionGUID: v2Ua28/vQlGHeW3XVz1ZeA==
X-CSE-MsgGUID: q5qAD8AdSSi6I7YSm9FXlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="35822892"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="35822892"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:04:36 -0700
X-CSE-ConnectionGUID: B95MGFOdR4qlr/XuIrmyCA==
X-CSE-MsgGUID: 1ckeF8F3RQSs0wAjK6Gyrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53403424"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:04:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:04:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:04:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nq9X3YImypg2r3nvGPK+YQ0uFPKiUEkNgHaLQzzvCEdM+3JMiXcRZDA2fOtS5bCTX9a9CYm6+vMqIwdXwngW9PfD2Yg2a8zKs4zmQLU6rHgK++1J5hXsYD6RncoMJU6+XSpPfUH2cytNknjGT3yyKIOeCF5JrwgE1viE+jvfXGxx9LbwEx9U5V6Hoa46N7nhGu6K46af5kBb2bPehr2cU7HvL4hWXZMl/Peb8I1w1gJMzqwwNYLJe8i/wp51MAWeCdakDmIRUxYMrGIMFGfy2chF2yJkuAHZIoRuK5ZbTRyWXoG3P92cP7+p4xh3uWLpEyHG2DfBxksZulSU6gzLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QchhlncSrz2EFS+KjUNmcx45upz4i3yHdFsdHhuy9M=;
 b=pVdAzJPMNicJAbIYlHnVVOvd+ntYA1Gh5DBbiTM/P8JC+mrPxLTbrTCLABGT98knz4JEFyVplRPOKXH/psInndqUCPnJfrGbgyReHjxQNaIf83mFJm/nSN5bTBkN08lxUZUm4AS4VZPhlwDcmyzGWi4t6bTp+PzyrKGOViADRFgFsJfXENPZmP2NG/toizcolAcvcDujPDnft5WxVIs8WFeM7NO5CBMPpwp6qhBdDy/87rlkVVfIQWM8Pp0a/B56NUAsQKIXbTadk6SgvZKN6hNTrwqCaxkO142/K49lYP+bpDgoK6GwUnohSep/s+iqUSGQE/M/QW4M3lRIY/nb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:04:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:04:22 +0000
Message-ID: <1d0af059-4768-48ce-87ba-7a9a213a3fca@intel.com>
Date: Fri, 12 Jul 2024 15:04:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/20] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
 <ea967681e5ed7a9c27771d60ef993616e7e1292e.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ea967681e5ed7a9c27771d60ef993616e7e1292e.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9504de-2585-4427-5ce7-08dca2be95ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTdHZ042VUs0UExWb1BXTDRGWjFhMndpMXlnSXBzSVpMa0hoYlBPUGlkSitQ?=
 =?utf-8?B?c29qcjh5cUE5Skt0dEVGWUFOdlUwTGtlK2FKNXdWZFdZSzQ0ZU5BRmc1Mllz?=
 =?utf-8?B?NzllQWVlSEM1WHhSdkEyRytxUWFvTmFlOWw0NUhCcnJKVkRKZDhCTVUxS0JP?=
 =?utf-8?B?WFlLdGsyUnd0dEhrU3UzdjJiNXVCRldmSVJ5TVdwN0tIZmZnMzUrL0xQU002?=
 =?utf-8?B?OHNJU3BXZzNleDlXaHZ6Wi9OZU5Ta0JZeVo3L0YrcXBvZGwwdEtmTU5TbW85?=
 =?utf-8?B?RmNPSUpXL0laRi9LYkpTSkZOZ003Z2prRnNCa3hReFQ4YnYxUHdSaUJWNUFF?=
 =?utf-8?B?NStPNjNJQ1VrRWdWaGh4TnVTMzQrRTlVcWw3Q1h5NExDQWJObmhuTVdTOE5Z?=
 =?utf-8?B?cXI1cWErbjBORFpaQi9JTzl0bU1pMFppTldVWS9GK1UybzlGUXhDK1JPbE51?=
 =?utf-8?B?QlhKYWF0YzJxaFVlSjJRZTE4dWtuYTgwNmtvNC9abzRHdVRSQ3d1aUlzdGhK?=
 =?utf-8?B?K0FsRXhMZ2ZTTmZvV2ZOQzMyZk5CSDF4V1VxcHB5UVpoc3ZtdmlGODFMSnE0?=
 =?utf-8?B?enpjbmZhQ0hvZExUQjU4aEZUV2k3ODZlaXU5dVhhemhRNFhsSEtmOUovNFJ6?=
 =?utf-8?B?UVd1ZWpUc3lQWkJEWEVUVFJTQkUyaE5HaTUvU2ExVHdWa2cvcVBxeGFNUTBm?=
 =?utf-8?B?VE1hUWxRZ0R1YXBkK2pkcUhNV1FHVnRuS00vYVNDYWFWY2gzNDc3WTRuVm8v?=
 =?utf-8?B?c0F6Tkt4aFZjRldNYkdhYU50ZFFuWXpBOEM4dVJKaWl2RE9Rcnd5VXhCTmpn?=
 =?utf-8?B?RFJwVzIwNFoyRHFxYVJkVGxxN3RDTU9QVFBMS280eE9wYU82UW90L1NTK0Jl?=
 =?utf-8?B?cU15V0NlNm81bjc1VG0wNGMyZlh1MGlyL3BXV1NROUFqK3lLWkhnN1NzdjJj?=
 =?utf-8?B?aWtyQlpiQVR4UHgyd1FKRmtvc1VaWndVeEpONjRMT2ZiVnl2M1czSUdSS3Fo?=
 =?utf-8?B?bzkxSzB1OTA2dHVqUUk0REtRY2xoNkwvaElJMjYxRkJRZ1Z3UkI5M3kzb3ZX?=
 =?utf-8?B?WFdPbnp5VXp2N2lOY2VmTHEvQjRWYTkrOGlwMy9hK1JQRW5NNk1MVnpyVUVK?=
 =?utf-8?B?YmV1WHg4bVNmMXQwbTdSNFoxZDNiWFNtY1JZdkJwZklvZWxTdVVDZVVjcm90?=
 =?utf-8?B?TUd4bGU3ZUI4S1hXZnBTeVlmdi92aFQ2TWMvOUU4ZXBUTVdPNUNyTEd0d0V2?=
 =?utf-8?B?dSsvUkdlMjF3VUUycEtQeStoUnZuMThpem5sT0dCWjhKeEIyYlZPTFpmV3pL?=
 =?utf-8?B?VTBlWjQ1Y0ZXdjd1eGRYMDlWK29WQ0RINzcvTHRwU3NxNTJySFJzYWUyZ0V1?=
 =?utf-8?B?U1dzeXhWU29tNXY1ZzFHaE9IV3djRHNicTVDMjN3aDV2U2JGV2czY2Exc3Zz?=
 =?utf-8?B?MDJVVk5ESWxNaGQ2VlJkN1FNWHVGa2puN05UT0hkTGthNDE0b0JvRDczMDZq?=
 =?utf-8?B?VEoxNHM1Zkhzb21vUGViUnF6SFVraVF1V21wQmpaZGY3RnVDdHV1dDh6UURV?=
 =?utf-8?B?bDh6WnJoZEVmMWllMmNqR3BVRDYxb2tlNi8zblRrVjRNVllwL2ZScmNGMjhO?=
 =?utf-8?B?RGphcFJhSUNqRGFLY1MvWG5TSWl3TllSWXVZMmszbEZobjNsbXg3bjM3NG9o?=
 =?utf-8?B?eWh4aTdpQ0pVbVRHSm5yWXdDWGxIY1BYdWpEODNkVE1YUTg5MWg2VlVKWkxr?=
 =?utf-8?Q?EIonfwttnA0Vtxj3o0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3VjQmhjdkxYOHFqSWptWG5GL0lESkZtSngzTlkwa0plVTNsbDFoa2thNjJT?=
 =?utf-8?B?bGJhK1J5ZVg2bFdIb0JDRTZkSWZVb2t3My9JcmdEV2sxMjRYVm1vc0F6TjZh?=
 =?utf-8?B?eFBWYnRha2dNMHJqQ1BkQmZzWmlVNjdmOHh5M2RHeUljWk9nV3dBcWFvR3FJ?=
 =?utf-8?B?Q3dCV0lZeU9ibEdsaTNZZWhSVlBpY3JJTGlTRUd0QU5QeEJaSnpEalc3UFFE?=
 =?utf-8?B?OHdTeStiVWd5YlhOZTArcXE2SzNmNXBkZ05LczZHVHMvaU9IckovS01ZLzlo?=
 =?utf-8?B?Z2hSSGo0SzQzb1VsL1NWZlp1aEx1Vlc1Q2praklBdDNtNGoyY2s4MC9QTzFy?=
 =?utf-8?B?NklOYXE5VnZnbnRRcmwxVURVVnUwWXJqbGtQdndCVUxPcmxzL0EwU2tmdTJj?=
 =?utf-8?B?ME8vcmVMS2g0UHJ5S3RIeTNPVkNremdnUlp0L08vbFB3VExtSjMrbkNnNEl0?=
 =?utf-8?B?VXRSaXk0bXJ6dzE0SDRGc3RRdHI3aXF5eTRneDJySmtHTFBNRGV4WUZOWUxS?=
 =?utf-8?B?UUNRMGh1NVhGNlJLSEFoTmV5b3hlNVBZSnUxang0Q1Z1c1pwRlJmcmkxeGI1?=
 =?utf-8?B?aENoOGg5d05PS1JQeGFCMktXMFc1c2hOUTdJVzU2SVdzVVVmeHJwK3ZBRE1W?=
 =?utf-8?B?cnQrNGFLMkhvU3EyRE5tL2huajBUVDJSSDJSMGszcWgvM3lHclVoK0lVbDZi?=
 =?utf-8?B?ODhTRUFOOVl2azZ2YTNUMmd2YUhzOHJhMG54akl3VkpBSHliNlY1M2RsQTds?=
 =?utf-8?B?L3d4VTZnUitGOUREY0ZQTzRscnNDeU9BbWJVS3Z3allzcGlDR0FCd1ZlZGhB?=
 =?utf-8?B?ZEwxTWVaQWJ2Y2J3bnpDbUNEM1hoODFkVTFmY2hiazZjMDhwci9lTmZsenRa?=
 =?utf-8?B?SFUvdExoaVpIZUdQTnVFN3V0cWJjNFVSdHJQNW5oTkNPV2N5bVZ4THI1cy83?=
 =?utf-8?B?eXRFVHZSb3JXMGpDMlZ6ZkFLdmYvMXRqWXZJTnhDMHRBeEo0QXNMOUloTy9z?=
 =?utf-8?B?WXdkTHlTRzlwZms5SUhuemNKMjRPRzBvNzNnZC9YL3VOSFlFTFVBQWFYSzB6?=
 =?utf-8?B?L01LUDlTMVdIRmJVQ2NIVXNvbVFZVGNHNGJ3eFQ0U2NIdTRoREEzSEdyNTgv?=
 =?utf-8?B?QUtRdzhSTGlMenJodmdkMlF1VFlZQXFBOWJjcVdyTEpvYi9XcVRnR3ZCdWZp?=
 =?utf-8?B?Y0pLdHN4OTBGcHpxN3g3Zjd6cmxaWmE1aFRvZTQ3K1lyRkRheEJTZ1U2MkJ4?=
 =?utf-8?B?bnlTSVRybVh6S1YwdVphNXcrbnc3L0pJRy9sSFBTaDhSNEVyT28wUVRGU3Mr?=
 =?utf-8?B?Z1kybEVXN1JiZ2x3WGhwTEhEczhXUU16SDhpSFBtazVLL0xMTDdXR3VJb3Bh?=
 =?utf-8?B?TEJFUkNkclhXRndReXY3b3A5Wk12akhTaE82dldySUtURGhsU1FPVHRNQk01?=
 =?utf-8?B?ZE1iTnA2TEwyZlpMM3d3Y2YxdjVMbFlvN3U2TjViMW1LVkFzc1EwNkhVdlBp?=
 =?utf-8?B?SjBFcmZXaHQ0YUtCZGExdWw4TTIwTXdqT0RBNDN1azBxUDBHcldVQnBiaXVJ?=
 =?utf-8?B?ZTRXVmRnL2VBYjhtZGtYc3dtd3IzbjRjWnU4Wm5nTGFTSFczbGFDVFBLaE5l?=
 =?utf-8?B?dlhEUFhHVVl5Q2NoVHdGcFFBQVZKbHhmV2krUWV2bXdRSGJYZkM5U2I1ZmQw?=
 =?utf-8?B?S3lZNTRzRVI5am1HeU1hMmg0QzhGOXBJODVXUDc1NEpvd2FyQVo1S0h4VlVk?=
 =?utf-8?B?Q0NWNmNNaE5xMWU3L1UyT1lpaEJNb3YvNWJwM1FWb0tKQVcrMGJuZmJaVkgx?=
 =?utf-8?B?S25sN0NXTDhLRXMzQkJqbzhqOVZzMmJWSmVzU0VzRFRzS3llT2JRcFF6OWcr?=
 =?utf-8?B?WlVISTc4emVQdHprTUVrT25hdmhCdjV2dlJrZXN0TTg2REpSaTFPWTVHam9m?=
 =?utf-8?B?dVRpYU1rbGk0VVNRcjlxbnJOMmltTE5vSEgwTm9ISU5SMHY3bmJyaGtzb3h2?=
 =?utf-8?B?SkxyWFBVWE4wM05JZ2VWdVg1VGs5TmVrb0lTekNkaE1Ycml2YVhTdDBLVDI2?=
 =?utf-8?B?V1FqdkFER3hsQ3M3a2J1K2dJbzdGcE1jbTNubTRFRlBLaWt6WjVyNHBmWEtr?=
 =?utf-8?B?aHN6aEN3VklPSnl5QzltdVJxNklScFpTYm1zSVEwUHBTaW44NGZtdjV0UzB0?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9504de-2585-4427-5ce7-08dca2be95ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:04:22.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI6D36LzAIikEfMzz6+YIwp/kzTzBe/jueBN5AIhEDN+gOnyxOopPr/c19VUx/vzu1CqqvCp51tUGFFkYmE1olNwxB8p1//7r3gklt+7ChE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>       Monitoring Counter ID + 1
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).

<insert snippet about what the patch does>

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5: Name change num_cntrs to num_mbm_cntrs.
>      Moved abmc_capable to resctrl_mon.
> 
> v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
>      need to separate this as arch code.
> 
> v3: Removed changes related to mon_features.
>      Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
>      Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
>      rdt_resource. (James)
> 
> v2: Changed the field name to mbm_assign_capable from abmc_capable.
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 12 ++++++++++++
>   include/linux/resctrl.h               |  4 ++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 795fe91a8feb..87d40f149ebc 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1229,6 +1229,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   			mbm_local_event.configurable = true;
>   			mbm_config_rftype_init("mbm_local_bytes_config");
>   		}
> +
> +		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
> +			r->mon.abmc_capable = true;
> +			/*
> +			 * Query CPUID_Fn80000020_EBX_x05 for number of
> +			 * ABMC counters
> +			 */
> +			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
> +			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
> +			if (WARN_ON(r->mon.num_mbm_cntrs > 64))
> +				r->mon.num_mbm_cntrs = 64;
> +		}
>   	}
>   
>   	l3_mon_evt_init(r);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index e43fc5bb5a3a..62f0f002ef41 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -185,10 +185,14 @@ enum resctrl_scope {
>   /**
>    * struct resctrl_mon - Monitoring related data
>    * @num_rmid:		Number of RMIDs available
> + * @num_mbm_cntrs:	Number of monitoring counters
> + * @abmc_capable:	Is system capable of supporting monitor assignment?
>    * @evt_list:		List of monitoring events
>    */
>   struct resctrl_mon {
>   	int			num_rmid;
> +	int			num_mbm_cntrs;
> +	bool			abmc_capable;
>   	struct list_head	evt_list;
>   };
>   

How about renaming "abmc_capable" to "mbm_cntr_capable? That would,
(a) connect the capability to the "num_mbm_cntrs" property, and (b)
remove the AMD marketing name from the resctrl filesystem code that
will be shared by all architectures.

Reinette



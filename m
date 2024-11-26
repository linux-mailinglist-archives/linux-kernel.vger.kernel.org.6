Return-Path: <linux-kernel+bounces-422756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD09D9DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 012A9B259B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64F1DDA0E;
	Tue, 26 Nov 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGOcCCsm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAEC16F0E8;
	Tue, 26 Nov 2024 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647693; cv=fail; b=C/I33awrv6Co/rFNsHvD13/8BcNw+8Kqw444ik3q7OQYeo0kEXbBPNukTZHcaorEovQSCT7FwYO2HohD8slZ0rOEUtwTSKNegYoM6Qx0v8iFv7IlEI+Vg3Ef89/ZDS/ezoW85wEZETGwwYG1G95YExGrrT9xDjGH31VZgdKi2SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647693; c=relaxed/simple;
	bh=DdmzXHPWAQU+7uO7XJFB0CLRzTJ532nY08bKwr72nxk=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ncUiDW6eNGnqpGGLFuXOvCVk95/DcNE/AhYMmK2DIR7/Ri6s/rrGB5uFfpe41cWs9Ui3k1XbNatahL1N6I4jTxIaCwWgZqrENRVsGGzMvxRU1U2K3QZ5vZERA/JdEfkz6tewkWCeSXfX+JbzkdYjX7tjqfKv54yOatg867BGM08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGOcCCsm; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732647692; x=1764183692;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DdmzXHPWAQU+7uO7XJFB0CLRzTJ532nY08bKwr72nxk=;
  b=ZGOcCCsmlSNiyQGrcZY9IPyeOO1IQmJwMlMO2BXt+/mRspE2f9AfnNTp
   JnTj0TAUzrWhsFBvqszZIR4bGeTrmWQRQ1JPShXSZwFRWfu42TSLbwyaL
   Mm7hHGfb4RERX/KLN2Nbo6VTCubUT+s4JAYTXc2nB0rwWA4ZV6MG7uyIy
   jjqZ3sQjFRD6T78ShZepN10+nj5QFwZ93sjEXTPAGo3prykeS2fy3YG3+
   f02fpEFuCetIkxQpoyQLwmjxz+GGyxM/jGQJXnCzk9y6EBvLvmxjlMWp3
   XJMaEHuXGjXIYaFdUg3rvCPvnVV36oscuXmCDpXrh17lVUg9YtMXJmAfj
   A==;
X-CSE-ConnectionGUID: 8JSgAId3T7uhHboc+XdyDQ==
X-CSE-MsgGUID: QkTJuPuWSA2X2mKoCHIifg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32684450"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32684450"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 11:01:31 -0800
X-CSE-ConnectionGUID: Z7YP3PVQQUCx5arkkqM44g==
X-CSE-MsgGUID: iy/rpATjTymzAt1TABmjhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91651044"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 11:01:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 11:01:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 11:01:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 11:01:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQnAQmTOdN6ov1xBr3emBknCzbtWRRqz+Nipzmj/8h3Bmd7dJ0GxKij9/+zfRaszbczBR36vxaAs8mn8dMZ6sbQ3YlqWjGAoQWK09UpW7KzWdAmwGqbeCgLaRVebL0JtuvtkHZnUPjl56l7WFzGJVa6Hr6fB/ffm+AH1q3fgUuVEbYoqAZYSoEn0m7H3sBKSLS2xAAMO1jD+TqzRxQ1cOO82wuXkG9yMdT/9nSaOclj/iN90H/bGJgdSf0t45XLz0pLVVDKJHY/ewMPcDRXDMsABTEai11bEXxfmgEIbOfSeRdELbIf7HHNRn0E2ryofjm1xozuZDSWEcu22V87iXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpXfKKJr5wYOmlbhS52JHeweKqm1QR3sU6CE4OP4gLY=;
 b=dySds07PlvYx1Im/gEs07ZETvlV+YMPRyHg5y48JiSzwHjee85R6C6HzulVLJwcjh2uEkP9RnSwqDgLHXGfORC8KudWWqp6/n05DV37CJH4QQzD00BaSxbOeludI3lLs7R9lREEwhUyPbCE8sVyzeUvGTZgiGlN6CZMj4a4MXK1qKOB29n4qd7lVo/2pa83h33gwoHUjE6sc+YQYSwwDtcIuemQ03oofwdcr/N6y9KZo9FCr8PQ949uji+cA+04zxwZTSYtd3qYtaC0NLs2ahlG/cvKTu4uyVX4Zy3a2yDSimw8uI1OkWJwnhBi1GXuR9OnfgsdW+7z+eYw4wHBcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 19:01:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 19:01:24 +0000
Message-ID: <3f26c0b6-e010-4dfc-b5c3-7659f341dbe1@intel.com>
Date: Tue, 26 Nov 2024 11:01:20 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display
 monitor mode
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
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
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
 <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
 <33cd0cc0-4f81-4a2d-a327-0c976219996a@amd.com>
 <d5bead60-6a38-426e-afa6-e7980a268d6f@intel.com>
 <0eff9462-e7e2-49a9-9538-c8907024322f@amd.com>
 <6c5f8c64-43f6-4145-b0dc-429603f8ee24@intel.com>
 <9fc844fc-23e3-4b58-958d-75c96c98fad7@amd.com>
 <6bd4335d-4b55-455f-a042-948df227e02e@intel.com>
 <18eacffe-3839-4104-81ee-a3497b1f28f1@amd.com>
Content-Language: en-US
In-Reply-To: <18eacffe-3839-4104-81ee-a3497b1f28f1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0349.namprd04.prod.outlook.com
 (2603:10b6:303:8a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c78500d-65a3-40b3-4631-08dd0e4cb8e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXBNZnRzTHpOZUFDbVNISzY4SUlCN2p6YWhucmtVN1h5TEY1UWtrVkRGUHpJ?=
 =?utf-8?B?dE5vWE4rK0cvRTdMMTUzWmxkd2pSMXAxTDdyQUdVTGJXbnNJV2x1bmNqWGZ5?=
 =?utf-8?B?RW1YL3Y0Z1lZQ3l5dDRjQ3A1KzZoV2I4cnU2UFZ1dzBtLzZGSnZQcGdRMjFK?=
 =?utf-8?B?cmJxajBzOW9MRG56Ym4zR3J5NGRmelFKaGdsR1ZRZlZ4cm1RSG9SVHVHTVE5?=
 =?utf-8?B?dE4zcHNHOGdxaHoyN1R0UmZGQUp4OUFVSHJhaGs1c2hTL2dLM29WOUhGcXJi?=
 =?utf-8?B?aVV4eTh4NUtwNmw5QWhZVWtPWmh3d2VNN1FVZEQ1eGdQWkVJanZManFxWUJo?=
 =?utf-8?B?bTErZzRUelRscGNub2g1RXh0ZzBxRnpOcEVheCtMY0RWdjZuVVNzSlpaUnVD?=
 =?utf-8?B?aXBaSDVscXlGbVE2TDY3aHVCMVNyeEFOMmdQU0ZUaDJCTDgxMFhJSW0zYm5p?=
 =?utf-8?B?Y2dNMEoyaVA5aktZc3ZuSExZZkRSWWo0M29VcVVUNUtlLzlNVUV4amxVSkFV?=
 =?utf-8?B?TElpajRaQWlmc1U0Mzc1R1RYTWY3U25aNzUxbUdDNlpveWRpeEF3Z0FkckdF?=
 =?utf-8?B?b1djK0R2SHcvb1pjclZnc0wzendWa0VDekpvRlZXVlk3VVN5aUVrTmk2RVRL?=
 =?utf-8?B?Mm5vbHBHMkNnMkhDb2R6NUJNYTBWaFhOSHNORTQ4d25NNmdvc3dVdlMzQUNs?=
 =?utf-8?B?dmtkNm5HMHVKdXpDRjF5SC84Z3hmMTlCS0IyZGttaVlGVWFUOCtueG5TR21v?=
 =?utf-8?B?aStWOWZFbHRRcGlpelJhV1Zpc1VkendYMWU4V2lqbGtjSzArSDlPTzVvQzRM?=
 =?utf-8?B?dWlRaE9pSy9PcFhjLzl1VzJ3YnUyemgwb1oyaVZXRjRzN0N5UHBmYk81bHhp?=
 =?utf-8?B?d3Z1NVpLNnZEODhvQkx3bHVCcFJ1VFVwWk1GcDUyQ05XS2tFdkN4dFcvZW1F?=
 =?utf-8?B?VlpTaWRHaWZmMFlscDlCY1RLdmFTS3U3T29ENzFFSHVWRFBES2RoUUZ5YkJP?=
 =?utf-8?B?enBTVG5iTnp2cjBNQm4wNkczMEhGSVY2cXhybTFldjAyRlhET3Z6UVorZnNC?=
 =?utf-8?B?a2JMa3VzMnRiQVFLNEdJNFYxTUhkS1lsYlRsM1lmTG9PSUJaV1VVQWhTS2Ju?=
 =?utf-8?B?T1l5dE9tZ1dJVkpjKy9kaXhVa2Vua0tLTDNldWxFc204RE4zRlJlc2VaNHAv?=
 =?utf-8?B?b2NzMkVCMzYzN09PZUVLVFRwWHcyLzNjU1YwVGd6UVhhV2pCbUhmNW93TjNu?=
 =?utf-8?B?NFJYejZjd3Y5SWUvUmdLdHFQRzFZOXpHZTJSZHU4R2p2bGhLWGxyS09kb053?=
 =?utf-8?B?QVd0WXRwNk5UcW5wYTROcWIyV3dySkNRMFlsMUZ1K0VtKzdSeGVkTU1IbVA1?=
 =?utf-8?B?ZDlVbzJxS2pnWHpyNHkwZFA1elo1L0JXR29IVU8zUkJUMnBNekY5K0FpV29F?=
 =?utf-8?B?TFR2d2thUlhPMVlxWndsd1lidTNKUTBSamhyMnRZWEVQanlpRWsxMHVjRkh3?=
 =?utf-8?B?c3hBNEhYZDlLR2xjd0w1dSs2WlJHaWRua1BIWWEvUVJJdElqT3pmVTJFeTJ2?=
 =?utf-8?B?VXJOaUY5RkJhWWkyeitvK3JRSVIxS2t2VnJHRHFzUVJyYWU1TkJtNlVQV3Jv?=
 =?utf-8?B?N1JBOS9GVTg1c3VMZlNDcFBHamJyUmJLaHBLRkVtLzVKUW5FbUNLQ2NuVjJu?=
 =?utf-8?B?bEl1eGpqWC9SU0ZrVlZOWmZXVUVBTzVrU3B0bVBrcnpxREVkNm93ZWtMVUNu?=
 =?utf-8?B?Nm9hVjQxOUpnbG5rSnhoM01BT05mc1VRNFNWOVVhdVlrSnZ0dnE1cHBvWmFK?=
 =?utf-8?B?TlArVkIxY2RuTkZ4djI2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01LZmJiU2k0Y2JBYnRlSWxXd1NzZlJiT2J0R3Y4cllTUy94d056cks2WW5u?=
 =?utf-8?B?QkJFaU05dDZhTnBxR0c1SWE5dGo5NlpxcXFQNUk0L3drY3EvY1cxbzFsaDA1?=
 =?utf-8?B?bk9pUnRJMk0yS2lsd0xyQWg3OFRtMkZKSklnMmo0dWE3VlRmd3JFaG5paGor?=
 =?utf-8?B?UTdtOXFDUElNTDdoV3pZaHV3bE1JVWxtT3pNV0VFL2VqbGk3aGM5TmVZVFpH?=
 =?utf-8?B?eHQ0YW1GbG0zVlQrTWhxZ0FoUXcxK1FJeTRVZUxyTWhuaC94YUVobzluY0JC?=
 =?utf-8?B?SU4wYmxHdnpwUXI1T29rMVlHSnY0QVYzR0lnZDNFSHhVZzdJb3pGbE1yeEJB?=
 =?utf-8?B?Mk14LytOV0ZnZXlGenRaRG5yci9VTGdRaVBWUFlidWVEMzJRMjVIbVVYV3Js?=
 =?utf-8?B?b09rSHpIUWh0cWkxNUF4TkthbEh4MkxJMVowYTRDci9TazNVdVZpYm5kb201?=
 =?utf-8?B?YWdxakZ1b0MxWnhURURWaExROU15UWZsbVZuUlZLb0MvT045QmEyRCsxNVdq?=
 =?utf-8?B?aksxNXIyQ095d1JCQnZUa2ZSQUpKTzJQcGQrbDYrTStaaXNTRGJlNk5hU1RD?=
 =?utf-8?B?SkZySkFnd01TMC9Jb2hlU2w2UEFjcllKVkZpNnpsSVhVQk5BcVRwMUg0ZjhS?=
 =?utf-8?B?TTVhclRvNXQ0QTVsbVloYVlPSWpZVWswbTYrQktIVFNWUldxN0Y1a3dvblNu?=
 =?utf-8?B?c0RIQng0RXM0V1JpODB0eGFkZGhmdUdOQlltMUIrOWliVVc0K05FdVNRbnEr?=
 =?utf-8?B?WVNPU2oxRG5sTnM4dnBhTXl0VEdzbXdrK010dm9vWkIxZThvTTI3V1REelBB?=
 =?utf-8?B?UjhOZ1VmdkkwVjJFUnVleldiZEFNUEJIU3dKeEQ5dmxtNThDTzl6SnlLWE5a?=
 =?utf-8?B?WWc4ckRabGhwbHFaZFExTXR4M3lKb3NNaVlwTDZFVzVndm5DOXFQOVd1R1FJ?=
 =?utf-8?B?aWt5bnpIVVJZS1RRYmVMWjU4RXZNWWJvU3gzUlJnQ0ZPeFFQWTc1dzBidWhy?=
 =?utf-8?B?aTNKRnl6Z1BOQVlkd0J4U3lqWThLV1hoVkEyWHF3bHFJNzdBTHdsL2tOYkxY?=
 =?utf-8?B?bG95cFhvN2FycXJUVUpsZjlYL2ZjcmZsM28wb2VCZ2hJYXBNcE53L21TeVVR?=
 =?utf-8?B?a0FPdUtzRFdZUXhhVXg5UmNOeDR1M3lOUGI2WnMwQVFRZmhkVmNiWW04NWJH?=
 =?utf-8?B?b2JrdUR3RkFPYlRhYTFTc2xvbE1KYUFEZnQ0d0J2Q2g5anhNNEQ2UC85WStY?=
 =?utf-8?B?YXB0anZHMzVML1ZudW5NN3FrUlVJdCtiMlZoTndMKzBjcEkwOXBuSEVVa3po?=
 =?utf-8?B?QVIzZ20vaCtzcGw1ME51RFBzczlRWDVwZUdXS0MzNWgycWZuVjMrdEg0dXpO?=
 =?utf-8?B?S0kyUm5mWm12cW9WNUpIZXc0U3hUYjhORVplUmZSNWJpS0dHanV4SDBoZVYv?=
 =?utf-8?B?R0F1bVBtS2VIbnhJMW1vSDRRWDE1V0hJaXRYSm03N05NUFVZUTdSaXVtWGtP?=
 =?utf-8?B?WURTVExFMSsrb3dNcS90YWF0bG5QeUpMOElEanRlSzQ5NmVENXB0WlAwOXdq?=
 =?utf-8?B?WWlxWTM4YXNPb0ozUHpDMTNLR09IbDQzQTBZMjFWcTlrcFNHcjdIakRRNkNK?=
 =?utf-8?B?b0k5ZWpiWm1HS0lDb0dldGJ2K0xpSGdRbWhOOVd6MzA1bWQ2ZHBZalJ5U3B2?=
 =?utf-8?B?dzdBNFJiVy91eUJwWS9udVVodTBBTHl5bVhjVEpPQUpFVDhJajVDUkFSWjla?=
 =?utf-8?B?Qk1lQS84T2pTLzZ3dFNLSVlGQW9XVGlWWHpVZVI0akhNMmpxTTBDU2l6Tzd3?=
 =?utf-8?B?bmZIeGQxRXJSeVA3c2FXd0YvZ0orTnlyUzIwb3hJVlJ1VWM2eHRFZ2w3dUcy?=
 =?utf-8?B?eGFVZlNKRXZybDZvbjcwWlJuNmE4N0xKYnoxR1JoOVMxUWxJRWh0eVoyT3A5?=
 =?utf-8?B?MDE0NDh5eEczSlFzL2dUVkMzTUc4OElsZzY4blJFcTdDTGFvY1liMElSMUVj?=
 =?utf-8?B?ZzJPbXlXMHE0TWowbmtBN0VRMUcrcm02TWs0TEwxaGNaMWdHd1lBK256MnZ3?=
 =?utf-8?B?aDMwVTJzVUp5K0x1QUttQVdPd1BtTzN0YTBFS3ppYm94Um9qd3F2Ukw1MTdy?=
 =?utf-8?B?cEw3VkY1bHRJaUpoZUl4azA2aWdzSHE2M1NNZUNraDR1YUx4VmtYVHV6RExj?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c78500d-65a3-40b3-4631-08dd0e4cb8e1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 19:01:24.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2Ip0+CAnMA5N+eZOCyZk9aHy5w8xOK7lHveuSWls2MlGh0htMQnz+9uKrgC+wCR3YKvqF5twSt8YK3m98NPSE4sXfs8amcn/5n2AFkNLHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-OriginatorOrg: intel.com

Hi Babu,

On 11/26/24 9:09 AM, Moger, Babu wrote:
> On 11/25/2024 12:17 PM, Reinette Chatre wrote:
>> On 11/22/24 4:02 PM, Moger, Babu wrote:
>>> On 11/22/2024 3:37 PM, Reinette Chatre wrote:
>>>> On 11/22/24 10:25 AM, Moger, Babu wrote:
>>>>> On 11/18/2024 4:07 PM, Reinette Chatre wrote:
>>>>>> On 11/18/24 11:04 AM, Moger, Babu wrote:
>>>>>>> On 11/15/24 18:00, Reinette Chatre wrote:
>>>>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:

>>>>>>>> I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
>>>>>>>> to make the event data "more predictable" and then be concerned when the mode does
>>>>>>>> not exist.
>>>>>>>>
>>>>>>>> As an alternative, is it possible to know the number of hardware counters on AMD systems
>>>>>>>> without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
>>>>>>>> users to know if their platform may be impacted by this type of "unpredictability" (by comparing
>>>>>>>> num_mbm_cntrs to num_rmids).
>>>>>>>
>>>>>>> There is some round about(or hacky) way to find that out number of RMIDs
>>>>>>> that can be active.
>>>>>>
>>>>>> Does this give consistent and accurate data? Is this something that can be added to resctrl?
>>>>>> (Reading your other message [1] it does not sound as though it can produce an accurate
>>>>>> number on boot.)
>>>>>> If not then it will be up to the documentation to be accurate.
>>>>>>
>>>>>>
>>>>>>>>> +
>>>>>>>>> +    AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>>>>>>>>> +    enable this mode by default so that counters remain assigned even when the
>>>>>>>>> +    corresponding RMID is not in use by any processor.
>>>>>>>>> +
>>>>>>>>> +    "default":
>>>>>>>>> +
>>>>>>>>> +    In default mode resctrl assumes there is a hardware counter for each
>>>>>>>>> +    event within every CTRL_MON and MON group. Reading mbm_total_bytes or
>>>>>>>>> +    mbm_local_bytes may report 'Unavailable' if there is no counter associated
>>>>>>>>> +    with that event.
>>>>>>>>
>>>>>>>> If I understand correctly, on AMD platforms without ABMC the events only report
>>>>>>>> "Unavailable" if there is no counter assigned at the time of the query. If a counter
>>>>>>>> is unassigned and then reassigned then the event count will reset and the user
>>>>>>>> will get some data back but it may thus be unpredictable (to match earlier language).
>>>>>>>> Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
>>>>>>>> "unpredictable" event counts (not just "Unavailable") ... this gets complicated
>>>>>>>
>>>>>>> Yes. All the AMD systems without ABMC are affected by this problem.
>>>>>>>
>>>>>>>> because users should be steered to avoid "default" mode if mbm_assign_mode is
>>>>>>>> available, while not be made concerned to use "default" mode on Intel where
>>>>>>>> mbm_assign_mode is not available.
>>>>>>>
>>>>>>> Can we add text to clarify this?
>>>>>>
>>>>>> Please do.
>>>>>
>>>>> I think we need to add text about AMD systems. How about this?
>>>>>
>>>>> "default":
>>>>> In default mode resctrl assumes there is a hardware counter for each
>>>>> event within every CTRL_MON and MON group. On AMD systems with 16 more monitoring groups, reading mbm_total_bytes or mbm_local_bytes may report 'Unavailable' if there is no counter associated with that event. It is therefore recommended to use the 'mbm_cntr_assign' mode, if supported."
>>>>
>>>>
>>>> What is meant with "On AMD systems with 16 more monitoring groups"? First, the language is
>>>> not clear, second, you mentioned earlier that there is just a "hacky" way to determine number
>>>> of RMIDs that can be active but here "16" is made official in the documentation?
>>>>
>>>
>>> The lowest active RMID is 16. I could not get it using the hacky way.
>>> I have verified testing on all the previous generation of AMD systems by creating the monitoring groups until it reports "Unavailable".
>>> In recent systems it is 32.  We can drop the exact number to be generic.
>>>
>>>
>>> There is no clear documentation on that.  Here is what the doc says.
>>>
>>> A given implementation may have insufficient hardware to simultaneously track the bandwidth for all RMID values which the hardware supports. If an attempt is made to read a Bandwidth Count for an RMID that has been impacted by these hardware limitations, the “U” bit of the
>>> QM_CTR will be set when the counter is read. Subsequent QM_CTR reads for that RMID and Event may return a value with the "U" bit clear. Potential causes of the “U” bit being set include (but are not limited to)
>>>
>>> • RMID is not currently tracked by the hardware.
>>> • RMID was not tracked by the hardware at some time since it was last read.
>>> • RMID has not been read since it started being tracked by the hardware.
>>>
>>> All RMIDs which are currently in use by one or more processors in the QOS domain will be tracked. The hardware will always begin tracking a new RMID value when it gets written to the PQR_ASSOC register of any of the processors in the QOS domain and it is not already being tracked. When the hardware begins tracking an RMID that it was not previously tracking, it will clear the QM_CTR for all events in the new RMID
>>>
>>> - Babu Moger
>>>
>>
>> I think I am starting to understand what is meant with the "count the traffic in an
>> unpredictable way". From what I understand the hardware uses the "U" bit to indicate
>> that an RMID was not tracked for a while, but it only sets this bit on the
>> first read. After that the "U" bit may be cleared if a counter can be assigned to an RMID
>> afterwards.
>> If it was only user space that reads the data then it should be clear to the user when the
>> hardware limitation is encountered and thus hardware behavior can be "predictable", but since
>> the overflow handler runs once per second it may indeed be the overflow handler that
>> encounters the "U" bit and that bit is not currently handled. This could leave user space
>> with impression that events are always returning data but that data may indeed be wrong.
>>
>> In another thread [1] Tony confirmed that "U" bit is not returned by Intel systems so
>> this issue only impacts AMD. As I understand the other scenarios in which AMD systems
>> can return "U" (the first read after assigning an RMID and the first read after changing
>> the memory config) are all scenarios that can be controlled by resctrl.
>>
>> I do not see why unpredictable data should be addressed with documentation. Could this not be
>> fixed instead? Essentially stating "AMD systems without ABMC count the traffic in an unpredictable
>> way" seems like a poor user experience.
>> What if instead resctrl handles the "U" bit better? For example, when the overflow
>> handler encounters the "U" bit the RMID can be permanently marked as "Unavailable"? Would
>> that not be better than the counter behaving unpredictably with users never knowing if they
>> can trust the event counters?
> 
> Actually, I was looking at handling "Unavailable" in little bit better way. Right now, I see it reports "Unavailable" first then it goes into overflow and stays in overflow forever.

Could you please elaborate what you mean with "stays in overflow forever"?

> 
> Also setting the RMID Unavailable permanently is not a good option. We should have a way to reset it. At some later point the RMID can become active and report the correct numbers.

I assume that when an RMID becomes active cannot be the trigger to reset it since user space cannot
then be aware that a counter was not available for a while.

> I was thinking of introducing a new arch state(in arch_mbm_state) to handle this case. Need to investigate more on this. What do you think?
> 

Some new state is surely needed to reflect that the RMID's data may be wrong. It is not clear to
me how you envision the reset of the state. If it is driven from user space then I expect that
resctrl needs to be taught something about this and it cannot just be buried in arch code.

Reinette


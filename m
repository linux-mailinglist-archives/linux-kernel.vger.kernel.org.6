Return-Path: <linux-kernel+bounces-524519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B5EA3E40E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528853A8243
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEED32147E3;
	Thu, 20 Feb 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4iBSGf2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151C204864;
	Thu, 20 Feb 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076587; cv=fail; b=MHgkh78vJsUoj7kBtIPXzKzdMNCrHQEYHYpF1xChOLQbfK7nCJQ9PuGPfAKu4FXCs6fgAQ/SdPqmUK1hfiUk833taPD95e7u+CdO2dah63LCtQMDNss86S06FQ8mH51/5iQPHbkkdzV2DM9nRKL4kjqqbMZ/1MHI5U0SDgmv0Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076587; c=relaxed/simple;
	bh=H5eeC/5Po56B9kFjjjzFscYbdgDVEAwlt7Pki2f/InY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u8QgU25Ao4+0bPHnKtiKmA2Qv/3xMmZ6jpgT9ITTqBa5AuudJi4E46M+7+0kVXS+mN16RhRMFpKN8FctTH9jT1WuapozAjIGRsySec77ByemSX1yd8dQV+10aUmiBmgrHc9RH3SZ2pLpp5JPZSOmCXa3Gb6gU+w1Nbv1atB7AL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4iBSGf2; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740076585; x=1771612585;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H5eeC/5Po56B9kFjjjzFscYbdgDVEAwlt7Pki2f/InY=;
  b=C4iBSGf24VAQpXyE1DYh4Vf9P0BLN45ludg2pcLzJDX4WaSng10pHJPU
   T+ZqEdeGSlShmKVukWN2w1y01O1QhnP1Y+pejrYaGc1PPVL0FDuQs92wC
   aLtw9a0DIfoa+v6zAWQjTezkYDUa6hs0DuzrCWBt6wCI4zvddMYM0wjHf
   1PFg1GWYRhIRSDI7Qc8rj3VtohW7LNnZh1p/99Cr//mtqmpaUy7Dig6qE
   0PDFtYcmQTAh2UKezhtuVUHuR7ngWmrVmE1qUV0Sb+WJVy3UI7TB+PJZP
   9emRafcwF2RVnVjHhb8yH4PgCSgOWCwWR3tPIsxlYpWAoTiGhtyX3BSNU
   w==;
X-CSE-ConnectionGUID: C7loNLpERUaj/VON2rVPaA==
X-CSE-MsgGUID: cen8jnt8Tr63Z3hOp96YZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40588130"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40588130"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:36:24 -0800
X-CSE-ConnectionGUID: 89kfH6DvTgy4Z/LcOAwhuQ==
X-CSE-MsgGUID: cFxmAW70TmWidNi5cL8zgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115060588"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 10:36:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 10:36:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 10:36:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 10:36:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuKRzHrnq5G5w/MVuqVwt087HnwPMm5GbYUvCbLBZAGrfpI863yVCk0hyZmKTe8HJMZ7GtFUOL5G1Dt/X/iG6UddEMy7pgJ1E+FVeu+DVXcPYh2VAiyUrblLcyt0vJYwDn/8eJYgypPTky0v25AMU1yZhGxhK8BmyX3moT4InIyjhbmJaES/tw5WEQjK2j04G5tHFpYUsHbDCyCYgymwxuRA90vZZgYa9A4aC7dQAjcp6/Arsa8AbLf+L1IS9mwz9Kq92NlSgqLEZr4fIhGllh9V9gywqjEMHYyGMw2wgrXzAPy6Ci5xg4Rf55m1Gh3oidr3kGi+VeGDedXWeQO+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f13HKbs2r8wAtt8U5/CmuThYMuiFm2jRmc0WqdW0N+I=;
 b=Pfr8mFsgEFAzezxu2wjkLTzkjwSSDbkKfVMXdnWMb4N3MrCq4CrJLQhCrn+MwJ5IZotiLDCZMEkT5GtKqy+eeYA/AU9LRa1YF6+bLh7/x0TarU/kFgh0LB1K0TdyCHZt4b+Ixh8xE8isN33IXbCPux3OWvMYS0bsYnGpbUpTx2sLRe09t40dEdckyENH7f4begQ1haDUTYiFWqgEzfcotmf6yrVHnnz8PpgBH7J3BGxw6dR6Vnt7ucaoEHRBlr0oQOkyU+pxKZZNTZhpWDQRgvoFrZ1AynloJohGr/WRtbC6vTGJDU8QNJ0zRcBkGK4Q19IifRS1I7spO0GGGtYmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 18:36:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 18:36:11 +0000
Message-ID: <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
Date: Thu, 20 Feb 2025 10:36:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
CC: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>, "Babu
 Moger" <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 3967ae83-745e-4046-b86a-08dd51dd72a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blUyNE4yU0FLMHBJL2wwOTJsTzBIT2tRcVE0K3lOTzNTMTNEVk5zcmE4SHdj?=
 =?utf-8?B?MHF2bzBXVm5Bck5lUFJ2dFRDaG9wVndET3cyd0FkczV5ZGJyQ1RJN3B6WGli?=
 =?utf-8?B?V3ZQVGpYUjJDemVCN2FBOUFDcTZpcW9YUU5JcVovUG5rYm1sdzJkUkFMOWlW?=
 =?utf-8?B?a3BEbXh1dWRoWlJieXovSDRuRi8xTkRlSktYNjdBOUIwQS81RktSSnNqaGQ3?=
 =?utf-8?B?ekN0UzJIWmMvR09OQUxVQkI0cUxNREpYL0ZqdVhnaElJeFV4QTlpWHAyaThD?=
 =?utf-8?B?YnJxTmNYVzVpSzVEcDYzNi9oV1NrVjVrejlxT21IREp0Y1M3Nm9BaEJ6MHB3?=
 =?utf-8?B?YjVVRktrQXM2aGZlUHA4NlBydEZ2RmFBTWRIQnhNT3FTdWZMdUtNMWxibHJw?=
 =?utf-8?B?TUlqLzRwN1BPWHF5elllajZidVF1eloySkJuUzVPK3hSaEhqaGlHVnVZOHlU?=
 =?utf-8?B?K2Z3bTl5QUlYOURmTFNNNUpZQmpobTNYVG4weEU4N3d2YVBwemxSMWVROVBM?=
 =?utf-8?B?N3RvaVJZQktYVytHOURHamUwenZYdFJXT1hmWmQ2NHdZZkpSRUlEb2NSV24y?=
 =?utf-8?B?R0FGTkprWHNJdXdTc2QvdmJwRHBQR0VjRnBQWVYwNys5SzVhVklFdEt1dnBG?=
 =?utf-8?B?dXg3VkpoQUVVUGl6ekJ3TWFvRlVRTnN6SGwyR1hnTEI3bmdiQ25iOWthMStF?=
 =?utf-8?B?dnRMcWVFOGNRQlZic0VXSEZwK0U4TzFYUit4ZkUrT1hVYTFXT0pqQ1Q1MU15?=
 =?utf-8?B?YnBpUU1tUUxGTkJ4dFE2d2c0V0ZNMkkwczFCdXlwbWN5MW54NWpTYWZBRysx?=
 =?utf-8?B?RGxucTMzKzZyaTZNSUlianJ6amFadERlWGxFTm9WUlJwaFhSc3JucENORHlx?=
 =?utf-8?B?UlAzdzlycGp1d2drRmFyQWJaTFB2dWZDSFJOUys4cktvUG1nSmh0R0hNQ0Rk?=
 =?utf-8?B?VVN4VUdIQWxqZlMxcjVOTWZ1a1JtOTUrN2hId0pqK0g1VktKdkpGelJxalBt?=
 =?utf-8?B?ZnQrd2ViMjcrajhFckY3Rk9oYlh3clJOakxCMFFmNWNQQzFDN0ViRFV5MzZ3?=
 =?utf-8?B?QVNyOExWWkFXUU5qbDVWaTNRSGdtNXdaa2s0SVNLQkUxNjY2UUJKaWxoeEpl?=
 =?utf-8?B?clhBODdKb3hDYTg0WFNHTHpzNVVyY2I0OU1OKzEycmFFZHRObndkcmhGV2o1?=
 =?utf-8?B?amVOTG9uemRCMnFVblI5NWk5UHpNRU9WL0tFRFlOWEtySnRqbVBRekpnTmtZ?=
 =?utf-8?B?UlFTK1V1YUpOTFk0SGhvMGNjSXJPbmpYSmpKd1lIVEdzc3FNdCs3ZS9oZmwr?=
 =?utf-8?B?MWN1UzU2Y3o2Q0FsUjJBZTRGbkRyTzJPRFROdTVrL1IzTlFtWWdqTW8yNXJR?=
 =?utf-8?B?aFhkWStTRWtaYlVhUEJQYyt1U0VYT1ZYUS9SR1lkV2g4U0daVGNWb1dyem9D?=
 =?utf-8?B?d05jdm9UYThzd21jQWNkZ3g5a0FWZDBOTExjdGQzVjl3Nk5QclErQkl6enFi?=
 =?utf-8?B?Sm9PK3VkeDMwWlhUTFFiOFhxZVRVcVUzUjNXVHB3NHVpSUJpbVlVOS9FeUhx?=
 =?utf-8?B?MmwzZU5rMFpOVEJIaWVDVnFjREp1dXk0NVVtYWhMOUYrSnRUZFIxOGt0bUpB?=
 =?utf-8?B?aElLaEpXRklXa25NL0pPYThBWkdQeThpRGRkeXdZREtMYUZRZ2FjL3R3UUJE?=
 =?utf-8?B?MVNjVWxhOUU0YVlybHMydENlZ0NBNHlPQzA1NkNTcmR4cE55TEZWN3paVkQ4?=
 =?utf-8?B?UittYnI1NU1yYk1KcnZOY0o1YWZQVlhaWDNLUlpLT2lVRHNLMlppbVkvT3lQ?=
 =?utf-8?B?K0IxVVRKY2lCdzVNMnNjVEZaZ1JoT1B3SytsOFhPYVlkZmpxcFZLMFphQWVn?=
 =?utf-8?Q?mVexiFRRSSWog?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVcxd2FNWWlVWFVVNVpQWVVHdkE3clhXRDNCRENDckpQY05zVjhXQks1eFd0?=
 =?utf-8?B?Qnh3WFNtTjQzYm95SjhwMzRpd2F6Y1V0TE1GbDNPSGk1a0I3TmtnWlMxOGdP?=
 =?utf-8?B?VEtyQm9tUTJvKzN1MjRpTkMzN3l4Q2xpdEd3RUxXNGF6bFoxbXdZM2hNQVIv?=
 =?utf-8?B?RTdNdlBxVjRmSkNRaEV5SEY4eXZnNEZjYXcraG1VRG5waGUvZFUxSnduWWU2?=
 =?utf-8?B?bGhseDlzTTFVczFVeVRBZmwrUmJlb0VIUXZzaHFLM2hId0txcXErRzUzdDky?=
 =?utf-8?B?S2ZnQW1FSmpadEZqbnY3UStnRzlaNHN5SUN6T292YmowYzlab1VNQ2xSeGhJ?=
 =?utf-8?B?dnVpcW45S1lIQkhKMFU3VnZxa1NuVXFVZDBERjFZVmxGSXdHRTE2V3VWdVp2?=
 =?utf-8?B?L0FzL0VQR3VNUHB5RmJnYW9HVkZsUGJlQXlWMmJ3NkthbkhWRU13Q2JVdWx3?=
 =?utf-8?B?RG82VGoyWWU0NkZuRWRFMUhUSzlhQlJPZ1l4dUtNZUNvelpTR0ZGWnZ4TzdY?=
 =?utf-8?B?VXZjdTBpWjF0MmFpQ1FtcGMxdWNnSXJYbW0yeWFMS1d3OWVJNDlmMGhNYmlN?=
 =?utf-8?B?N0tFMlltS2VleXpMVEc0bEw5bEVySWJMTzBSb3g1VVZXbmQ3SDloZXQ3Vksw?=
 =?utf-8?B?REhldXdaNllya2FPTW5aWHE4Z0lWQ0toUUZUbVhaRXdjbFM5U01oTm1VY2di?=
 =?utf-8?B?RlpTWTJFd3QxL09TNG9XRHZPL1Z6aSs4S0lJQzFieWIvR0hJOTNmL1hKVERG?=
 =?utf-8?B?Vk84TFRVSGJMdWZEUGE4Z0hOMG05VzREZldZRVJuc0h5Si9PUkd3Vi93QVVC?=
 =?utf-8?B?Q2lhbmYxMjdIMEUvU2RibzloaHNTNTl4dFIyeFlQSno4amFuVkZYTFArSmRz?=
 =?utf-8?B?R0ZsOFY1cXFDdithbWZGQ3dPVjhtblJDd3pJK1Q4VFc5dWxCQTVTeWRzaDhk?=
 =?utf-8?B?ZzdiWXg2dHJkcHVva1ZuTzZpNGs3SS9JazM5bC8rR3dmR3A2L2tZbDhBeUpU?=
 =?utf-8?B?cGdoSkZ0ekZWQ1pJbWV5MExuczdVVHRzYS81RmM5KzNWNW1Oc1pNcGp3Y3dp?=
 =?utf-8?B?ZVFCVVc5MWJPMHNsWFJPcEVoNnZUSlU4ak5CMm16cXFzWlE5SFkyZ1VGVXFs?=
 =?utf-8?B?UGtmQ0wrZGQ5QW50Q0dOQlExbkxCSkJSQk1oVk5naGswZnVJdThpY3hsM1I2?=
 =?utf-8?B?V2FidEhlU25qNU9BaWZNbzdpYzFTaGltampic0o4V3B2Y2JnQ2JYVkpBdHlI?=
 =?utf-8?B?Z2dlNm81WUZ6SzNwTHI0ZDVZcjJqd2tVc2JTQml4eWRyM0pjUmlLYmtRMGRD?=
 =?utf-8?B?L2ZrcFFmaGlTRXEvM0FaSStLUkU1Y05OcWI3OVJNTTg5a3hNTi9EaGpqcGZx?=
 =?utf-8?B?R0xaWXVURFdwV1dDdGl5ckt1Q3ZlemlkbnVScVZzdUNTNG91MWVrMzVmY3Zv?=
 =?utf-8?B?cXNBMHdtUWxnVmw5akhxQVp3b3NsWXlxMnJVSEt3RWxNVEFSbEdjQTNkNHdS?=
 =?utf-8?B?b1NzeUdHNnplODB0U21LRW0vclJ5N05mSFFkTVFlYTVhZTlQRTIwV2RzNUVJ?=
 =?utf-8?B?bGh4ME1KdkRMdkhUM3FxRGRxNjB4NFJncVNiYlptSmNsRHpudnEwVkh6alVH?=
 =?utf-8?B?aVpzVk5zRmt2RnhHUW9vNzBOVGNVbXQ4VVhiKzNyZ2lWS3dSZE1XdG5LZU1v?=
 =?utf-8?B?VmFVOHM3Rm1XeFV3anNuZ0dzMHpWby90akI3RmpkWWF4KzcyQlk2WmpkTjBS?=
 =?utf-8?B?TFdGdElhRW55MXpvUjZqNGpTdWxPUFcyZWo1cUU5NXVpRVlpaTVlMEZuYUVR?=
 =?utf-8?B?UG5qbEtrNnF6RXcwektReEExbm1KbkZ6SVljUlRqRm5oMHFUTDNnb2lrNlhw?=
 =?utf-8?B?UDlWRTc4SFAySXNicVJub1FCYUpYcUxlbWZubXV5d21VNGVlZXFvR01jQW5n?=
 =?utf-8?B?dVprODhobTlGZkpTZG1rYUdHRDd6YTI4SlVFYzJxUUVrYnZoeGlkQlM5M3Zs?=
 =?utf-8?B?VGZrTXNEVUJwa3hPNmVWTy9KMXI3RzFvRExDNEFOWGdjejZSb3IxNGg2cFFD?=
 =?utf-8?B?cGtGV09keTBCZi9BN2k0dUZrQ2xXT1FST1F1a2pzRytjTVlSN1BBa3laQlhU?=
 =?utf-8?B?OU1ZNlNBUzFDMTZjWGNQZW9BNDdpOXAvaEt4SDVmeG9KUWJQMXF1ZFpFcVBt?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3967ae83-745e-4046-b86a-08dd51dd72a3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:36:11.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuoNjdBCS5vdeo0U2LfZChomX/6GZOvOj0iWy8o2PhlwaEr4bXhddphnca3xs4dpn6oO/pugbtJDe74HGCazfzXaqKlUh2du3fkFCOLDT8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com

Hi Peter,

On 2/20/25 6:53 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter,
>>
>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>> Hi Reinette,
>>>
>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>> Hi Reinette,
>>>>>
>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>
>>>>>> Hi Babu,
>>>>>>
>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>
>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>
>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>
>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>
>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>
>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>> <value>
>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>
>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>
>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>> is low enough to be of concern.
>>>>>
>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>> investigation, I would question whether they know what they're looking
>>>>> for.
>>>>
>>>> The key here is "so far" as well as the focus on MBM only.
>>>>
>>>> It is impossible for me to predict what we will see in a couple of years
>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>> that he is working on patches [1] that will add new events and shared the idea
>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>> customers.
>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>
>>> I was thinking of the letters as representing a reusable, user-defined
>>> event-set for applying to a single counter rather than as individual
>>> events, since MPAM and ABMC allow us to choose the set of events each
>>> one counts. Wherever we define the letters, we could use more symbolic
>>> event names.
>>
>> Thank you for clarifying.
>>
>>>
>>> In the letters as events model, choosing the events assigned to a
>>> group wouldn't be enough information, since we would want to control
>>> which events should share a counter and which should be counted by
>>> separate counters. I think the amount of information that would need
>>> to be encoded into mbm_assign_control to represent the level of
>>> configurability supported by hardware would quickly get out of hand.
>>>
>>> Maybe as an example, one counter for all reads, one counter for all
>>> writes in ABMC would look like...
>>>
>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>
>>> (per domain)
>>> group 0:
>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>> group 1:
>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>> ...
>>>
>>
>> I think this may also be what Dave was heading towards in [2] but in that
>> example and above the counter configuration appears to be global. You do mention
>> "configurability supported by hardware" so I wonder if per-domain counter
>> configuration is a requirement?
> 
> If it's global and we want a particular group to be watched by more
> counters, I wouldn't want this to result in allocating more counters
> for that group in all domains, or allocating counters in domains where
> they're not needed. I want to encourage my users to avoid allocating
> monitoring resources in domains where a job is not allowed to run so
> there's less pressure on the counters.
> 
> In Dave's proposal it looks like global configuration means
> globally-defined "named counter configurations", which works because
> it's really per-domain assignment of the configurations to however
> many counters the group needs in each domain.

I think I am becoming lost. Would a global configuration not break your
view of "event-set applied to a single counter"? If a counter is configured
globally then it would not make it possible to support the full configurability
of the hardware. 
Before I add more confusion, let me try with an example that builds on your
earlier example copied below:

>>> (per domain)
>>> group 0:
>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>> group 1:
>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>> ...

Since the above states "per domain" I rewrite the example to highlight that as
I understand it:

group 0:
 domain 0:
  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
  counter 1: VictimBW,LclNTWr,RmtNTWr
 domain 1:
  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
  counter 1: VictimBW,LclNTWr,RmtNTWr
group 1:
 domain 0:
  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
  counter 3: VictimBW,LclNTWr,RmtNTWr
 domain 1:
  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
  counter 3: VictimBW,LclNTWr,RmtNTWr

You mention that you do not want counters to be allocated in domains that they
are not needed in. So, let's say group 0 does not need counter 0 and counter 1
in domain 1, resulting in:

group 0:
 domain 0:
  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
  counter 1: VictimBW,LclNTWr,RmtNTWr
group 1:
 domain 0:
  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
  counter 3: VictimBW,LclNTWr,RmtNTWr
 domain 1:
  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
  counter 3: VictimBW,LclNTWr,RmtNTWr

With counter 0 and counter 1 available in domain 1, these counters could
theoretically be configured to give group 1 more data in domain 1:

group 0:
 domain 0:
  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
  counter 1: VictimBW,LclNTWr,RmtNTWr
group 1:
 domain 0:
  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
  counter 3: VictimBW,LclNTWr,RmtNTWr
 domain 1:
  counter 0: LclFill,RmtFill
  counter 1: LclNTWr,RmtNTWr
  counter 2: LclSlowFill,RmtSlowFill
  counter 3: VictimBW

The counters are shown with different per-domain configurations that seems to
match with earlier goals of (a) choose events counted by each counter and
(b) do not allocate counters in domains where they are not needed. As I
understand the above does contradict global counter configuration though.
Or do you mean that only the *name* of the counter is global and then
that it is reconfigured as part of every assignment?

>> Until now I viewed counter configuration separate from counter assignment,
>> similar to how AMD's counters can be configured via mbm_total_bytes_config and
>> mbm_local_bytes_config before they are assigned. That is still per-domain
>> counter configuration though, not per-counter.
>>
>>> I assume packing all of this info for a group's desired counter
>>> configuration into a single line (with 32 domains per line on many
>>> dual-socket AMD configurations I see) would be difficult to look at,
>>> even if we could settle on a single letter to represent each
>>> universally.
>>>
>>>>
>>>> My goal is for resctrl to have a user interface that can as much as possible
>>>> be ready for whatever may be required from it years down the line. Of course,
>>>> I may be wrong and resctrl would never need to support more than 26 events per
>>>> resource (*). The risk is that resctrl *may* need to support more than 26 events
>>>> and how could resctrl support that?
>>>>
>>>> What is the risk of supporting more than 26 events? As I highlighted earlier
>>>> the interface I used as demonstration may become unwieldy to parse on a system
>>>> with many domains that supports many events. This is a concern for me. Any suggestions
>>>> will be appreciated, especially from you since I know that you are very familiar with
>>>> issues related to large scale use of resctrl interfaces.
>>>
>>> It's mainly just the unwieldiness of all the information in one file.
>>> It's already at the limit of what I can visually look through.
>>
>> I agree.
>>
>>>
>>> I believe that shared assignments will take care of all the
>>> high-frequency and performance-intensive batch configuration updates I
>>> was originally concerned about, so I no longer see much benefit in
>>> finding ways to textually encode all this information in a single file
>>> when it would be more manageable to distribute it around the
>>> filesystem hierarchy.
>>
>> This is significant. The motivation for the single file was to support
>> the "high-frequency and performance-intensive" usage. Would "shared assignments"
>> not also depend on the same files that, if distributed, will require many
>> filesystem operations?
>> Having the files distributed will be significantly simpler while also
>> avoiding the file size issue that Dave Martin exposed.
> 
> The remaining filesystem operations will be assigning or removing
> shared counter assignments in the applicable domains, which would
> normally correspond to mkdir/rmdir of groups or changing their CPU
> affinity. The shared assignments are more "program and forget", while
> the exclusive assignment approach requires updates for every counter
> (in every domain) every few seconds to cover a large number of groups.
> 
> When they want to pay extra attention to a particular group, I expect
> they'll ask for exclusive counters and leave them assigned for a while
> as they collect extra data.

The single file approach is already unwieldy. The demands that will be
placed on it to support the usages currently being discussed would make this
interface even harder to use and manage. If the single file is not required 
then I think we should go back to smaller files distributed in resctrl.
This may not even be an either/or argument. One way to view mbm_assign_control
could be as a way for user to interact with the distributed counter
related files with a single file system operation. Although, without
knowing how counter configuration is expected to work this remains unclear.

Reinette




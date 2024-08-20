Return-Path: <linux-kernel+bounces-294448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3634958DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61132283591
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0E1C0DF8;
	Tue, 20 Aug 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXpZyV0K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD319005F;
	Tue, 20 Aug 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177299; cv=fail; b=FDW0PrnVQEZyiu42J/YJ1Ejmmqhm9Ot17WyqSYVQZZth8kzjXnmNVt2/upy0u/GmQKaMfUnTmNRo6/o2Si3IbVkZt/14lhQG52UxqqZPctG76JZPFdWJEliMpVvARgK7y6NNuFHBkWhPTycOG2XLGuwSqmwGR8gqJqoxeHt3T48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177299; c=relaxed/simple;
	bh=ukRWD6xyAF5R2V8ZA5eLE3IBD1oh/k8xA8uI5jsqdTk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QHzIsNN6IugYubkDKMbBKJ0uHs5SrlglnJ6NQy83pIb5x+H4gksrXAWooPPJY9rJWnQOKMXDpRquiJ0dU4fR3jZGTzfrp4CeycxVrv7Xtu3GqZAYAxlcUCx1l+6jkvSDyIDsAWFJ012X8nNh4iN5sauULLkaiSjvHdmMeFRjFic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXpZyV0K; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724177297; x=1755713297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ukRWD6xyAF5R2V8ZA5eLE3IBD1oh/k8xA8uI5jsqdTk=;
  b=ZXpZyV0KJ9HYO9Q8zENbEpDUIMVjBnSOBrWNCtKyIPTnaaQ6ZtFhTL42
   poixwjrpLuaY/nQGmg+nMydHxzxGaTKGxxuX4mSBBq4OGF+Ku0nFS8aIb
   6DRK0cOgerXCPpBc0JqhVaH8qAgpfM/hvtsO8TJVVCe1gt/wFLa6MBc0o
   FttWFuKnbw/oSbObPafUfsqA7SHXHP2OzULICeSNDdP01XjNPQqr+GGsd
   BDApF3Pi47rImRgb+rqc11+ADQ01XxoZkMPgXGZyctJ183ZqnBOe8QIdd
   Ucd+Ll7l4CMxujZggBDDqvizznnW75HH0f6IIRGL7XkMXARbRFni0sZDS
   Q==;
X-CSE-ConnectionGUID: rRydwtxrS0CgRJYgSo9zvg==
X-CSE-MsgGUID: GHsKGDTHRkKyFb3hcjuupw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22684182"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22684182"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 11:08:16 -0700
X-CSE-ConnectionGUID: I3p0Yy1bQgqOAzWEwl12bw==
X-CSE-MsgGUID: O8/Pz9xPQKi272Gptjbcmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65010681"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 11:08:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 11:08:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 11:08:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 11:08:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 11:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN1KlY1uSmil+bEOwlssmdkWYoIRQ/R8NMSPafKHkDHhUhl6UetlsOZ7o+SHPp8/JiWCfy0xhopxnyTv0pOOooJCvgXsxmO/db/VS1m92Z/r4uA5n+Nk/z4jPr19vKpLxzXVey/tJOpphgvKzzkdiagnSMzWgdEhYn+zV4GKdk+/7YuLPzTj3MyvkzTxqXaP/pQiGqlfR8HdkUbcvdfzSaTTA4nRGZpwkwYXQFQicRDuzdgUwewJArZLCBnUavdnWAQZZ+jfMi0XGmsFNcfbfYSOkP5kc3WqeHPKtOdgkDe6ehsumbx7RD9hXZ8WAa6DXKnx2Pq9M/wUVe8xcas7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gu6eT9Gh/2VTZR9RjQDOVUsAsImTjf8/geHor9FW+c=;
 b=cLz90muKcJSH5TCyUUEiJ9Xy/gfF0/BzAFjbBjoQRArmHM+UmSjhqWCJQfjRIVziX3klEzxuZtek9wflFMyYq0BYQE4npvha96UcLVlDqHiTdHWQbIIPrn2pxR4e+M6sZTmV8WvS4dl+RCoF9H/cl1/ZTS/webMjWzWcc3+Y9mRWGisRZd9RLQjgHBx4yGqrZs8l4yIP2AuA9dCiic18IiHssc16xejHEIZl1Gjckql1ohlWecGGk8gZwy3hGwWbi8i/vqGIpVPjVgzKhkcWygytMNxKs+cWIXlkt9ymRw6VahrA110HL+iFR0dm49ZVuXE5nYgzwyeiY26akOltSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5038.namprd11.prod.outlook.com (2603:10b6:a03:2d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 18:08:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:08:09 +0000
Message-ID: <8ae3edee-47f4-479c-a4a5-cb2e9c2982b8@intel.com>
Date: Tue, 20 Aug 2024 11:08:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/22] x86/resctrl: Introduce interface to display
 number of monitoring counters
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <da3c2f99c07987d59d9df1db0a0a85ec323cd67f.1722981659.git.babu.moger@amd.com>
 <6c1305ae-caa3-4da1-a0c2-3948cac976be@intel.com>
 <807d4e97-67e1-4644-ab99-caccd328eb62@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <807d4e97-67e1-4644-ab99-caccd328eb62@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:303:6a::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: 506b6079-ab8c-42d0-2c1d-08dcc1430c86
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFR5R29GSkRGUUFaM1BHVzBxUGVMYnVJV3RkMEZWTktUUExaY241a3dYVVNh?=
 =?utf-8?B?YUdYcHpyR1VYOHhNWTB1dW84RkhGZFI1ZG1UeHVhZWhOZFJydGFsWjNHU0o3?=
 =?utf-8?B?MENEYWNyOG9oWnZScEljbWx6OWhDRmt1NEdYZjZaQ3dBMXIzVTlidmN5N3Bh?=
 =?utf-8?B?d1BtWHFlSDZpQTdXRTllNWdDaU5PdVNFY3JmM3NuZGh0NzNuUmJtYTlyS3Jm?=
 =?utf-8?B?dS9KRldhMnNHZ1FRVWZab2Z6QzhJV2ZTUHF1N05wQzNKYVZaYTBhYUtOdnFi?=
 =?utf-8?B?ZndkSUNWK0pZdjltZnVQMzlJbWVOSE9SS2FzaG4rQlkvSk9jdVBHanJndHcv?=
 =?utf-8?B?dUZSRzEzWSs5akdSLzk0QlduZXJHOEFBMGFGZ05OOXlaTFJCUTJ0QktnY3FU?=
 =?utf-8?B?NTJoUUNIRXRnbmF1dVVJNk9ZM05IbzV3VGx5RDFNcTdHOUo5TXczV2RGeGxT?=
 =?utf-8?B?WlM5ZkVKeFZ1L09PK0ZMVHNteTFJdk5iTEhzR2hqbFV5bTUzcjNJOHM5ZjdH?=
 =?utf-8?B?Z2dTZFpOUm1Bd1l2OGpJOWFtN0c4SEQ2M2x3UnVwY3J6bnNMMnAyZ0x3dUp0?=
 =?utf-8?B?c0IwbXViK056QU1DeUx2U09EU282MnFwbC9NS0hsbzFyMkJ5VmI4cGY1bzhr?=
 =?utf-8?B?SGIwODhkeVoxYWI2RnRCZlhLZkY1Wm83NE9zSzBzMHdqK2tKNTBrNWNFZ3pW?=
 =?utf-8?B?ZjgvbGI1d3VqTGhUNDVWRGMrYWVyZ1FPZWNBeTNQcUg0Q0h0WmkxOVhJZDJ5?=
 =?utf-8?B?QXA1Qk5ucjc3bzZVSVN5dlN2NFpuL04wQjVyNDg4UEIyOUU2dlJTSnZ5OUEv?=
 =?utf-8?B?aEU5dVhtbHN3Qkl6VVV4UE9BclJlWEFSSUxZUXhpa3Jpekkwa29LUTZETWho?=
 =?utf-8?B?WXNZTHgyeFV6ZHBFUG5GUisrVFJuaC9FNXNmdkJjU2xQTTNla1JSZ2ptRW1E?=
 =?utf-8?B?TDh6MnVKa2dvOUVvdEM2bkVKMkF0RnNwQUVCYlpGZ2JTWlEzbERzdTNNYmZY?=
 =?utf-8?B?aGY4SzFGM0c3b1ZUMy9yNm5xcjd4U1U4S0FJMERES1BlOFE3QnZ4UW9zODR5?=
 =?utf-8?B?YUV1bkNxVndGMitxdjhKK0l3NDFEUUwrQzJVby9RMElqNFREQXJGNGRmemZr?=
 =?utf-8?B?dDRYMXNaWThmc0NtaGlkY2pnL1JiaXFCNTNobGVXZHFMZkJBOGJNZlhsdVZz?=
 =?utf-8?B?ZmdPUlpleUtZdlpnQVFhY2R4N0tXN2FIajNMVXZSZkRydS9heVdiL3NNUHVh?=
 =?utf-8?B?Q3RKQUZrc2FnYXZWNndUaFQwZkF6ZG5OeU1UUjkySWgyZ202WTVrQysxcm5L?=
 =?utf-8?B?S2xhN0d4c0N2VWgxTmNHRmVjV3NBU3dRMW1zcjN2eVMrVmVrSkR0RXVidUth?=
 =?utf-8?B?V0RyYnBlWEp5V0w2M1BETTlzM0dnN3c0UGorRDNaN1ZMcEhleDA5SE43TXBy?=
 =?utf-8?B?WlZZbzZuR095Mzk4eHJIeGtLT2twcCtCQUxWVlFvOTVwSG5BdHI1V2hjNnEy?=
 =?utf-8?B?bXRFLzRDaWdHQjNvRFhsQTJvL1M2dkxwYlhEMHIxcWMxQUFEZ0tZeUc1UDV1?=
 =?utf-8?B?SW52VGFFOG00Qkw2aFN1clcxMXdydTFab2tlbXBUWldvV05YeHk4bHhDK0xn?=
 =?utf-8?B?VWZaNkZ3UndILzh6YTZKd1JPVHVoREdyVGFFMG1vMlh5azIwSHo3MllmNmp2?=
 =?utf-8?B?cUp1eFdpbFZWcG1mR2dkZzRWbC9tUm9udkJZVmQweGF5Z1g2cHNBNkVweEVN?=
 =?utf-8?B?MVNJUHhibXJyZlZCOUh1L1FxT0FhdmFKT01PNzNXSCsrVGFkT3Flc3JKT3RG?=
 =?utf-8?Q?kIcBTg+Zp4BSUuJPrRvEPZes2zGN6UuV2xK40=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0FXMGJpQmdYaUMxQW1EZ2szT1R4d2NBV2NxYVRGVEZRc1BNdkh3Y093bFJp?=
 =?utf-8?B?eS9aTUMxWStoSnB0bURGdXVqSEZwNGdGYzBHTmw0aFVuZnRIM21SV1pTQmpw?=
 =?utf-8?B?TzcwRk9mQWJsd2lqbTIzZ1Z5UGZnVm55L1k0OFdPcURxbDhFSm91endHUFpX?=
 =?utf-8?B?WEhzTjl4QUdZWENibytiRUU2Skp5SXlUYXIyczVrVmRjeVVxMGlmUGRkNzU2?=
 =?utf-8?B?RXNBc0FudVIxVFMwcVFCTzFVdllHZlU0UDBRZ240dXJBdzhZVlZGY3ZjMGF0?=
 =?utf-8?B?VUdjWnNpSW5meTlBTFFvUmpJMmJKeEMzQzVpWTA1ZDByaGI1SVdlUyt6cU80?=
 =?utf-8?B?ZTZ3ZVVMekFiQ0VxWExoRnZ6MjMxSkY2S29aQ0ZhWjdUTERMbG1iMDBRZElL?=
 =?utf-8?B?eFBKcUlWYTZzaWtoQWJmblB5ZzZCL2F0R1JTZzl5Nkd4cEdja3BQRmtsYjF0?=
 =?utf-8?B?U3dKb210MkFPdTU4LzdRZUhTYkszNGxYVzdPeC83TDhXZ0l2UkdISjZDMm0z?=
 =?utf-8?B?RGZrZWh2Z2UraWZLRk16YW1LcTVDb3gzMVl2eStDSHY0MG5vVWp5UWVEb1Nh?=
 =?utf-8?B?SWdxQ2Fad2NPZFdRWkkxV09qNUVzWmdRVTVLSFhLMlpYRWdWRit2ZmdlQmMx?=
 =?utf-8?B?Tjl1S1d2ZSsrUldUdHA3QnVQM0YrUCszc0Vkais4c25hZWZRcTZwQ0pOTldk?=
 =?utf-8?B?b3haSHNSdm5sWTl2Vnk4akNaS0xtWjRKM1l3K0hjZ2dNRExvblBHMHd5elJS?=
 =?utf-8?B?WlFzc2JYUllzQUovQ3lUa0VVRDJwZEZJdmw1SGU2OG1zZC9GWWZCS3RsaTdX?=
 =?utf-8?B?QndwQ003VHVYTHFXSmlyTG9Ma3JOdlM0NDF5YjBUaEo4emtDODZST0NOL0pE?=
 =?utf-8?B?S1B4eDg3cGNQV2xFeHpoUjhTZGVPbnlQb2lYa3hJRnhtaGthZis1YVk4bTNM?=
 =?utf-8?B?emNvUm53cldjY2I0cDFwVjljRzYraS9YYTMzbFBsRkxiTWJtMHVZNkkzdEFR?=
 =?utf-8?B?WVE3amVtK0lkeTE1ZVY1aTBjWU9pY1B5TXdzMEZCSUx2UjR0TTBJemJLL2RL?=
 =?utf-8?B?YkJ5NVNkM3BTQVFNdXp6U3cxU3ZaTTdCemt3TXQ5OVM1SW5tb2lPU3NTL0h5?=
 =?utf-8?B?Mkt0aThmVG84RHNMVEplelhEVU1IeDcwVjBQcVFQOUYyc1dlWGdyeFZzSlZo?=
 =?utf-8?B?TnJIRXBZZFRvcld5SDZtWnNmdXUvTUxKcDJZSUpnYU9CRm9qdC8vUFl4Wkdw?=
 =?utf-8?B?d1RueHpOdTB6dzA1dUpRZlZlOEhwL1lEbzV4Z0ZCenE0ak9HTS91eEpxRW1p?=
 =?utf-8?B?cHBxSk53T0wyNEJaemhyVDViSW8vYjUyTHpKN2s0ZWVqb2xqdnc3V3UzVkYy?=
 =?utf-8?B?RCtEMW80Q0NSZ0p0N0t5R1hWc1p0MXpEMU1OK3ZYa0JocmVuQWo3UzBoeHB2?=
 =?utf-8?B?a3BocWxvZExvYTZ3OFliRnk5b1p2YXUzUklvdk5QZDQ4Sytub09NM0o4Y1Vk?=
 =?utf-8?B?dUh6NmRVc3ZiRFVUUzhxSURrOXMwU09abGx2TmZJQ2sra09sS253ZXJxd2hG?=
 =?utf-8?B?RHNRMDFVWjZqZ3c2eFJnY0o4WHg5WEo2WGlBSDRXUkJDQzdGdXBXS2xMNDJn?=
 =?utf-8?B?RDhVb0QzUlRyaER2L0lHclFTNmZLYjFSQlVlSi9VRnZVNGJndGFxT0tWMjlx?=
 =?utf-8?B?Vm9FS2hBZ3I2YkdlUUd0aDExTUFZYXhwWWZXdWwwUkQ0bnlMeWNzZDQxMnZY?=
 =?utf-8?B?SUIxRzBNRkhtbDBLbUs5MEdkVWYvZUdjOEpFL01DVHhUWGdkSU1yMTRTYnJw?=
 =?utf-8?B?ZUYvSVF0RERKc2RsMmFLOXd5TDk4OWcwMisvTldoTHd3eVVjNlpseHFWYkZp?=
 =?utf-8?B?b1dzZGxUdnNIc0VsdTU3UlhBancxYXVtb0hYTS9Fb1lQYlN2N0N6ZGZ1SWJn?=
 =?utf-8?B?SVVtTHoxQ1B2ZndrQlpINDNjQkovZXRjWlEvYVlYd2J0NTRENFFDRFdQL3Qr?=
 =?utf-8?B?dHB4M1dnYlYyRlYwNlh4V25ySXNDSEFNV0JQZXduTkFJSG84UjRNRkNlNUxE?=
 =?utf-8?B?QVZBTmR4MzkxL21RTmpuQ3JUOW9uaFhyaXZPejdTVW5VcGRwMXBLdzlXYkNo?=
 =?utf-8?B?VlVucHJyc1hWNll0SXpheHNmaFl2MElZbTJ6V2lDRE9LY2U4b1NTclRScG5n?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 506b6079-ab8c-42d0-2c1d-08dcc1430c86
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 18:08:09.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPllGhsrE+uTWNv58E6q2aVpcewyBFfrJbEgcbiHdcL89z08C3sDCTTnt3HyvtVw3+7wdBcgQry7Z7Mb3mkiOaZRpLtBNIPJ6r/Ve5z0KIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5038
X-OriginatorOrg: intel.com

Hi Babu,

On 8/20/24 8:56 AM, Moger, Babu wrote:
> On 8/16/24 16:34, Reinette Chatre wrote:
>> On 8/6/24 3:00 PM, Babu Moger wrote:

>>> diff --git a/Documentation/arch/x86/resctrl.rst
>>> b/Documentation/arch/x86/resctrl.rst
>>> index d4ec605b200a..fe9f10766c4f 100644
>>> --- a/Documentation/arch/x86/resctrl.rst
>>> +++ b/Documentation/arch/x86/resctrl.rst
>>> @@ -291,6 +291,9 @@ with the following files:
>>>            as long as there are enough RMID counters available to support
>>> number
>>>            of monitoring groups.
>>>    +"num_mbm_cntrs":
>>> +    The number of monitoring counters available for assignment.
>>> +
>>>    "max_threshold_occupancy":
>>>            Read/write file provides the largest value (in
>>>            bytes) at which a previously used LLC_occupancy
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 5e8706ab6361..83329cefebf7 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -1242,6 +1242,8 @@ int __init rdt_get_mon_l3_config(struct
>>> rdt_resource *r)
>>>                r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
>>>                if (WARN_ON(r->mon.num_mbm_cntrs > 64))
>>>                    r->mon.num_mbm_cntrs = 64;
>>> +
>>> +            resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
>>
>> The arch code should not access the resctrl file flags. This should be
>> moved to make
>> the MPAM support easier. With the arch code setting
>> r->mon.mbm_cntr_assignable the
>> fs code can use that to set the flags. Something similar to below patch is
>> needed:
>> https://lore.kernel.org/lkml/20240802172853.22529-27-james.morse@arm.com/
> 
> It is just moving the calls resctrl_file_fflags_init() to resctrl_init().
> The  rdt_resource fields are already setup here. Something like
> https://lore.kernel.org/lkml/20240802172853.22529-20-james.morse@arm.com/
> 
> I feel it is better done when MBAM fs/arch separation.

Indeed, it belongs with the rest of the mon state setup that is organized
as part of the MPAM work.

Reinette



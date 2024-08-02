Return-Path: <linux-kernel+bounces-272826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CDD9461A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E375C1C220AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBDB166F16;
	Fri,  2 Aug 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mS2ZjuFD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EF166F11;
	Fri,  2 Aug 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615242; cv=fail; b=mRFGVqqqf51RF+l+ePSmJNRgwaDM4G+Nlnqyujc86Z+CXUvUnTxT/tPIWqK5jxcfvn8um+2gGaLG6v4cdU/s83RDw+cOfWxLUUyOV5t5IGgfe9dkCN73yhP4ouTASScWtwrgW2NKfVc/n2XrLE0xntGFrroZbfjh5y31zdZDQNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615242; c=relaxed/simple;
	bh=UXBsYY/xQsKJJlu67LVlFBEZP70c1pn/sJmBv2B7RHo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J6WCIo/BrHY4sWmsqmDn81M3oeZXjUHpH9bmdpfSMMd5markUQZCxeVN2VH0J688vMYbZMm4qyxDgoYHsT3U57w4rXo18ZJ0jC17KGPO2ahLDWh4CLexGQjb4XuJl8ROuk+pvd2CNykSi/3RHnP9a3i4wD/QikuoEtrrr6pGyBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mS2ZjuFD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722615240; x=1754151240;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UXBsYY/xQsKJJlu67LVlFBEZP70c1pn/sJmBv2B7RHo=;
  b=mS2ZjuFDDCTjIuw2YMKAhjcJM5US5fYvo6oRW+Xy/L3XxKRS56NcojcC
   nPZ4oyFedEvt6SnYrNtE6B10jlvNW54HHaRJXszn88YewBQf9WuWbVdWp
   pwWuISyor8zk/A0frPzs3Sj7R64BaKRBjb9K8mI+VD5uyvopcaUNhUiq0
   k+INhEYPiQTQXWjpkcMHBfO4S7L/oC4NWEBYfqKLmV9JmoaB8vQzxGrzt
   CH3/2po78+G7vpJXO7536ZqQD7URVC81ptXS9uLBdcnqA3eIGaBURHptY
   d1a5NbCnyyfy5xeROZhfDcczj+Z47O93nDPoQctmZrX044dyHQ0/Ai3ss
   g==;
X-CSE-ConnectionGUID: dAkeYtRJTWi9HeXlT4r1wg==
X-CSE-MsgGUID: JHvNhMZvT1y1Z3Mbw6W8Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24409009"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="24409009"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 09:13:59 -0700
X-CSE-ConnectionGUID: IVCvkPuDTdC7mRziX/qfHA==
X-CSE-MsgGUID: RNrIy35+RJ2ofiLhDMzn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55370563"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 09:14:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 09:13:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 09:13:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 09:13:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 09:13:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7PDJHrI21EqcWIgba8uESLOMouCypRFlzwQLVvIJTBVNKrDt8+wLx7Miz2b6GKO6nQnkJsEFMGTwtZjLrtp+71psv2tNhpEZK9wurZiXD/nv5OEMsayaTEor/BagffpNYIG3PbnZ9jpiIRph/th51IjKTSyms5ADqApjWdKoj0xEbfHtcj6xqHAmxe6Wbx5vKuDtavBi0JnD+q9UGP54PhjhRrTw80Jb+a9GBCsvk44g9Gfs1Ottv+88KpX/VRPzFYktj+eiuv9GatLIxeZ7BLko2oGtLcVf6smVNLELAaOIp7nOQtYSMkPCrYb2h2hQx4ty/+8/JscDolon6nLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3+fz+MTtPokE5hbaTJTkaIBdGPV0I2jmDT6wOReRZk=;
 b=WxTcQFa0WdaOvFVs9haEqlAidQSTgtdPKR9vgVtqEsJseTpdVpb+BBVo4f+dsjw7M8dZQZMn4ePI2jyp9rJWNoilZkYcm84FfjVG2FMiFN5UIOlM1DPQ9RarBnS7qWIUsFCDXYY0hQr0aHqTz6F5FUWx0mka662bnqV0fK/w41Vg61M0WHqXvwLWAN4O+8H6Atig5goOeJfbRh5aBHXyhrAIr7uxMy3OtkooA6Lr6n26hSCr+VkX0wds9grpxju/rIw1DW1nosmY1b71OkxUolOJ0z25aqiyf4qN/jmt8a8tixIc0EHW7kRMpPbp9GEhbDdEwJ1ppHDKTdsJ7REFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB7030.namprd11.prod.outlook.com (2603:10b6:303:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 16:13:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7807.034; Fri, 2 Aug 2024
 16:13:54 +0000
Message-ID: <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
Date: Fri, 2 Aug 2024 09:13:50 -0700
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
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a9f410-9e4d-41a4-bdcd-08dcb30e1b05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2NUa1M5ZFJBRWlSd044cTIrMEMvQTBGbGtXbEVxaUthb05vcHk3VmxZcHV4?=
 =?utf-8?B?ZGlxSVRIeis1OU80UTRuTEd4UVlweGoxL2ZGUzNlTU5nMzIrdXFGWVROTUl5?=
 =?utf-8?B?RXVTN0ovY3ZUTi92WFE5MmxENE1GdEhRWVlLRGJKL1dNM3VPOHBUdWp4aWxS?=
 =?utf-8?B?VW51aEg0NVRvcm1IUmRBSjRPWjlFTTNJU2E3eUNhWkcyY21NdkRjM1JCbGZq?=
 =?utf-8?B?dzZsbEFmUGRPWDdneFB2Q0pxc2FtdktXcUFMb2FhajRqZE40ZVFycHpmcUpy?=
 =?utf-8?B?TWFDZHh2SFl6R0h2alNJSUtXSTB5eWs2SGN3YkNhekRqMjlHd2ZNckE2NEVT?=
 =?utf-8?B?V1ovUm9oeVFsY2ZLcjNabnlybGMzWWpkZU1iQ2syWFE4K3VZUDVENnRadDNz?=
 =?utf-8?B?ZlZ2SWxBa3BoeW5pZXFwdHM2Uk9Ddm51SDJrVE03UkRxaWlpc0Q3cXJzWERh?=
 =?utf-8?B?NXFNOGMwa1JHMmZzR3dESk1VS3Q3ZVJqd01ENEdEL0U0K1A5ZXdJcmZmUTNY?=
 =?utf-8?B?Vk9RcjUrSUF4OEJFRTk2Q2NvZjRHYnEwbW1iaTMxdHc2bTY5ZExidTlCUXFH?=
 =?utf-8?B?cERCd2U3OGh0NmVDZU9Rb0w0aENaY1o3MjArZ3JSNC9iUWZwUEs3eExVYUI0?=
 =?utf-8?B?N0R0Rzk5Y1daaGgzMmEzYVpMTHNESERoUkZNSHZTcEtmTDFOYW50M1pXNnp0?=
 =?utf-8?B?Snp3alhrbVlubjFOQ1kyODBmWSsvaUxBbGNxZkJReGxqMmJpeVJHc0V5bHU3?=
 =?utf-8?B?dmU5MWVseTQ3eWZoditVYW1RQTh0VWMxOGlDRjZ4UjZUVklHdC9JdEtnSUVJ?=
 =?utf-8?B?SFNCWXZsUVk5SGNBb3Y2U0pUcHNPSUNVakI1UEY1RGlKSER5c08xcWd3OTVq?=
 =?utf-8?B?eGpRM2pzSkw0dnFNWUJSVTc1d214THJjbW54Q3dDODZER2JmNVZyU2o3OHhI?=
 =?utf-8?B?cUdNSTRpbllTbUptUWlKb2xaUGJsaGhJVHN3UFE4eEZwaEphWUhjTDNndTht?=
 =?utf-8?B?Smtud05rdmVnaU1SemQvYzBDWkY4NGlUakJIcU8rV1NMUkgrZlVwRm1aRVlR?=
 =?utf-8?B?L2tNdXpLVzRYYzVQUHFyVFQxbjdVVnRVTE91eGlYcHRZdkFvTVUzZFBha1do?=
 =?utf-8?B?S0ZzK2NDazk2YS9ZMWFMTjZDZHpTM0VxbGlRWkNZSTZsYmVyS1VWNHAyM1BV?=
 =?utf-8?B?eE5MakpiSFJYeDUxMExhRUFuWnk5N1ZyNTM3ak9FZ2dwdGRyZVd1THlISThY?=
 =?utf-8?B?WkN1YlBSWHFoT1A5M2hXdXlkWFdIRnFod3hpZWpDanJjb3Ftbm5NYjNvNnpi?=
 =?utf-8?B?SXJSVnFqSWVCOXNXS0pHMFo0SHVxcUF4cllWWW9GYThLVkU4MmdPdmYrNjly?=
 =?utf-8?B?b3dSNVQzOG50SUExVUxEUXN2M3JYNlpxd3Qva0hsNHIxa2NJQThmYWgxT3dN?=
 =?utf-8?B?RWNjSXBBQmtOSHNvbmg3SjdjMWhBV2RZY2dEMDR5cmh3eWo0dzZTbXlaRWhs?=
 =?utf-8?B?U1NkS3YrUmMyemFFL2xEZVFJbWxnb1BPUTdUVlE1ZzZ4MFN0eVVnTTZkS0Qz?=
 =?utf-8?B?WmJ4VVhzRGxtTk8rV25pTkZpV21BblJYbUdDeG5iU29Td3B5R0ZwcXNqWXE4?=
 =?utf-8?B?SnBTUVJnTTNwSnovbGxPOEY0QnlqQW85SGVCMHB3blpDbFQ5U083QlNMQ2Jr?=
 =?utf-8?B?WFBZRXJmYmJyazhrck1SZU9IUHZpaDMwQzJsakx5S0xIS0JabFhvR0srcWpI?=
 =?utf-8?B?aitUTWoyZ05CZG0wbUJoUTRXSmFZeEcrUFMvYklNd1RhR1F0cGxmRWh6dzJQ?=
 =?utf-8?B?anJGUDdNcDJ1QUhxUW81UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkNORVU4R2NaeVV0c3hNT2R6Q25CZlRrYTZqRmNiRmMvbWtQTDlDaHJMZW9U?=
 =?utf-8?B?YUdWaXI5OVBMNzU4NEU4RGF3MEI5cWNUVjNoajlUY0NLcHY3U1EvaXJzRFor?=
 =?utf-8?B?d2g0bGpGeXpmTEhNeHg5ZjgvM0FoeVNQNVE3dUQ3LzBsY1pmVGJXMnhva3Fn?=
 =?utf-8?B?SUdrWlV4bHB4UlJNdFJodUxMOW12R3E2MHQyZDFWamtBbmpyWWVmTEtWdFZC?=
 =?utf-8?B?MUFEVWQvUUpMMWEyWFRweTRpbTZuZlowWm5qZkVOTlg5dkc3Y2NPUGFkZ01R?=
 =?utf-8?B?Rm5kb2xiQmJncC9EMVV0bnZIVWdhNzcvZ1E5aFA4Y2ZJZGkwaU94cHhibmJr?=
 =?utf-8?B?WFNrbE5UL25HQXlXanVxTm1jMXJhUXdVVTY3UkRuaXZjaDFrbjRNUE5SSHp4?=
 =?utf-8?B?UlM0OUE0OGZUSTVnZ3FQY0luVUxTamNVOGVIamhDWHNIQWhCaG0vcWoyZ1lH?=
 =?utf-8?B?a3VSbDh6YjJlUEpLNmdzWWtGUVdmcWZyMXNuWWoxdnc5SVhSMCtHeUo1c2RS?=
 =?utf-8?B?Q0NQN09qd3dwa0xJc3pzZzNsREVkK2Z4a1Q0bFRwU2doYmUwdjhUZU1rVnR5?=
 =?utf-8?B?a0d4cWwvV0VtL3lodXEwbFZjejBpcXNTcS9MTzNIU1pqT29WbW9nV2FmeFJn?=
 =?utf-8?B?cjJNUE00TXRWT0NNb2p3Sk9wTkNvSEJzM01SaTVIb3ZwL05VcnlXS0dXVGFE?=
 =?utf-8?B?TlpNYVdZalc3R2FSSlg2a1dhc0ZTZmlkbHhiYkR3c1FSd0YzSGZ2TUMrSGw5?=
 =?utf-8?B?eUIwVHJyR3hVSjBlL0I2ZlRSQ0ZGb3lQb2wrcFBXOE13allPQi9rY2FMSDI5?=
 =?utf-8?B?QzQraUpucDNBYW1NVlBBbGVXM05CK2NGcy9BdW8rSVFCT1Q4R2xjcktRQkZO?=
 =?utf-8?B?Tmo3OXR6RzFrellvS3l2Rjg3d0FtMHp0MDBoa0t4Yi9iSWRyYnd2a2dZNU1z?=
 =?utf-8?B?UWdpK2lteVpUc0Zhd3JQQnFSaTNsTytLeVl6YlBac0o5ZWFPbUJrS3d5cEpW?=
 =?utf-8?B?bnlEWmdRa1ZVc2dLNVROeWhLZUVqRDVKelkxd0Z4bndMZ0VUUmlIY2h0a0hk?=
 =?utf-8?B?dU1yU0doM0hqWlpiZEVodGVwVUJMSXc2QzRPUGYxa0RFOExHMTlSZHVSNEtY?=
 =?utf-8?B?NmpTZ3RoRjRseGpnWVMyTW96Nm9BQTBUN1NwRzdJTnNmWmhBL3dndXB4bHBl?=
 =?utf-8?B?anVmMVdmei83OWp0MUxlTUFlWE1uUitOZ0pjWlVWVytvcno2TVdGclZ6U3Uv?=
 =?utf-8?B?Rm1LaUs0WDlqYXFRYUtLc3pLNWdEK1pHM0l0SGoxNGVualhTUFkwY1MveHZF?=
 =?utf-8?B?QXF3RnlhNFNTVlpvVnRXWVZHakUxbGgvemlTZ0M4MWFlbU1XaHV3WmVKN2t5?=
 =?utf-8?B?SmRoU2d6N2dETW5QUGwxSFZjTmNqK2F3Yzh1eHA0KzNGQXRNclMyT1E5Q2Ji?=
 =?utf-8?B?MktWZ2FuaWN1azUwNnR3R01SZDlBMDlMWTAvM3VVT05aYzlHc1pPZGpCOFBV?=
 =?utf-8?B?U0l4bHUvaW9YazFIRkRHQmpYUTFHb2dSZmZmaU0vc04zOWVhY3VlbHp2ZW5i?=
 =?utf-8?B?S25VU29wVHY1ZWprcmlpTktNcGVRN0RCcDk2NkRaZHpFbGdLdUxvTys3c0d6?=
 =?utf-8?B?Y0Y5OVBxaGFKOGJNTG5Ua3NZOWJxMmI4TlNkem5Td1F3OVNGOGY2OFJTcGs3?=
 =?utf-8?B?UnJ4ZXVDZGFTVVVTc2t1KzVCa1dYdmgvY2Z2OWd3SWFvTlhFRDMyZWEzaUVS?=
 =?utf-8?B?TEdneU16N2RmNXdkSmFHekNOZTRJTng1b01RV0F2aFFXUmtzYzNpUjVvaXNB?=
 =?utf-8?B?dENvbnZRQ1ZwdnMwTkFJczJBekFHOXNTYnMrVndMNHlLa3FZckVGc0JmZEI1?=
 =?utf-8?B?TGNDVWJsMEhQRzRHUkZWYmlPU0owQzJxYkRRMjlmZjg1TWtIbzh1RlFTZTZR?=
 =?utf-8?B?Lzc5cTJQZUxXN1U3TUp4Nlc3SnhqUkV5OXhCbTU3S2dWT0VBbS9ncjdPQi9P?=
 =?utf-8?B?cHA0a3V3bWNxazZrbjdtZUdCNVFBSGpiOG0zK3VvaUVHYkRvN2dreWRxNXNV?=
 =?utf-8?B?T3ROeDR2RWNJLy8zbjNQTURncmJuRnRWNG14UzVienZJU3hPT2l2bzhuWGFq?=
 =?utf-8?B?ampEVW9EQ3RpU3UwNzB0UGl4VCtTNncwczRxdk1VSm1DWVpQM0UxakRHOVZH?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a9f410-9e4d-41a4-bdcd-08dcb30e1b05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 16:13:54.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ajbxM+lZU86+1ptT6gnwfysCF7rHS+oUobGKmMa64ZVY/aGZlhTFCqzW+tu5PB5y6d4YWJ8vgHQQ3NdvRRT++jP1mhPzNfc6j3Iqtk4Qrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7030
X-OriginatorOrg: intel.com

Hi Peter,

On 8/1/24 3:45 PM, Peter Newman wrote:
> On Thu, Aug 1, 2024 at 2:50 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 7/17/24 10:19 AM, Moger, Babu wrote:
>>> On 7/12/24 17:03, Reinette Chatre wrote:
>>>> On 7/3/24 2:48 PM, Babu Moger wrote:

>>>>> # Examples
>>>>>
>>>>> a. Check if ABMC support is available
>>>>>       #mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>
>>>>>       #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>>>       [abmc]
>>>>>       legacy
>>>>>
>>>>>       Linux kernel detected ABMC feature and it is enabled.
>>>>
>>>> How about renaming "abmc" to "mbm_cntrs"? This will match the num_mbm_cntrs
>>>> info file and be the final step to make this generic so that another
>>>> architecture
>>>> can more easily support assignining hardware counters without needing to call
>>>> the feature AMD's "abmc".
>>>
>>> I think we aleady settled this with "mbm_cntr_assignable".
>>>
>>> For soft-RMID" it will be mbm_sw_assignable.
>>
>> Maybe getting a bit long but how about "mbm_cntr_sw_assignable" to match
>> with the term "mbm_cntr" in accompanying "num_mbm_cntrs"?
> 
> My users are pushing for a consistent interface regardless of whether
> counter assignment is implemented in hardware or software, so I would
> like to avoid exposing implementation differences in the interface
> where possible.

This seems a reasonable ask but can we be confident that if hardware
supports assignable counters then there will never be a reason to use
software assignable counters? (This needs to also consider how/if Arm
may use this feature.)

I am of course not familiar with details of the software implementation
- could there be benefits to using it even if hardware counters are
supported?

What I would like to avoid is future complexity of needing a new mount/config
option that user space needs to use to select if a single "mbm_cntr_assignable"
is backed by hardware or software.

> The main semantic difference with SW assignments is that it is not
> possible to assign counters to individual events. Because the
> implementation is assigning RMIDs to groups, assignment results in all
> events being counted.
> 
> I was considering introducing a boolean mbm_assign_events node to
> indicate whether assigning individual events is supported. If true,
> num_mbm_cntrs indicates the number of events which can be counted,
> otherwise it indicates the number of groups to which counters can be
> assigned and attempting to assign a single event is silently upgraded
> to assigning counters to all events in the group.

How were you envisioning your users using the control file ("mbm_control")
in these scenarios? Does this file's interface even work for SW assignment
scenarios?

Users should expect consistent interface for "mbm_control" also.

It sounds to me that a potential "mbm_assign_events" will be false for SW
assignments. That would mean that "num_mbm_cntrs" will
contain the number of groups to which counters can be assigned?
Would user space be required to always enable all flags (enable all events) of
all domains to the same values ... or would enabling of one flag (one event)
in one domain automatically result in all flags (all events) enabled for all
domains ... or would enabling of one flag (one event) in one domain only appear
to user space to be enabled while in reality all flags/events are actually enabled?

> However, If we don't expect to see these semantics in any other
> implementation, these semantics could be implicit in the definition of
> a SW assignable counter.

It is not clear to me how implementation differences between hardware
and software assignment can be hidden from user space. It is possible
to let user space enable individual events and then silently upgrade it
to all events. I see two options here, either "mbm_control" needs to
explicitly show this "silent upgrade" so that user space knows which
events are actually enabled, or "mbm_control" only shows flags/events enabled
from user space perspective. In the former scenario, this needs more
user space support since a generic user space cannot be confident which
flags are set after writing to "mbm_control". In the latter scenario,
meaning of "num_mbm_cntrs" becomes unclear since user space is expected
to rely on it to know which events can be enabled and if some are
actually "silently enabled" when user space still thinks it needs to be
enabled the number of available counters becomes vague.

It is not clear to me how to present hardware and software assignable
counters with a single consistent interface. Actually, what if the
"mbm_mode" is what distinguishes how counters are assigned instead of how
it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
"mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable"
and "mbm_cntr_group_assignable" is used? Could that replace a
potential "mbm_assign_events" while also supporting user space in
interactions with "mbm_control"?

Reinette


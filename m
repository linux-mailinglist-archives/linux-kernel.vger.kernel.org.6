Return-Path: <linux-kernel+bounces-411537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A74879CFBAC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E3B1F22F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2324F4A31;
	Sat, 16 Nov 2024 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lq8Fmqy6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D94A1A;
	Sat, 16 Nov 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717071; cv=fail; b=HBKI90DArnn3wxCXrJgwvVmTzSE3Fmo5Cn7kBLXmF8UrsGpGwZ71E6xE9RJsLKAfZLPTL9sG3bKDQUExZx9tMI5/oAt3r09PjcVjsp38+VWM89z8QImTOjmZkYAywVI6W25smYU/yHhHSBD3ly+u8tIA5x9Bl6oRrlD+A1fpRTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717071; c=relaxed/simple;
	bh=thYVTscX+emaLLnzn4dPU18A+CG53aIEw3YKXxXMdFE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r7vQQjKYYaJg3P4tr6YSmeaqdRfy8KSHNrbByIkt3JDeUASGcHIIXdjkEyn1V2K40o+hfM1xz2LYPfN6NFG8NQoRbkdtf7MRBdJ7HSjGMeM68l1Rv+o83PCy8naHMjFYjwFUcdGkRuLXv/I2B1986FhFtLR47YJ4q7r1LTDWr90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lq8Fmqy6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731717069; x=1763253069;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=thYVTscX+emaLLnzn4dPU18A+CG53aIEw3YKXxXMdFE=;
  b=lq8Fmqy6d6qJ47sNIVWFS7MMXCc9pFpjrGRt0nAXxhP9ZP/vAOA3f9FC
   Gl++TYZgqWvz7qZ9iOV2BaqKxbQG/Rq8cSbegLxsN/72peKa0U1ijC9Jc
   qENWV1MUqJ/gJmPPjh5LuWNlNOwBYWkG4txI7JPpjFL5kizxdoG0PffoU
   aZeMR7nyVjbulqHsETed2TMNjc3xQ7B/Z8auWocUwYeiqAna6Sbsr4f9t
   nPiQLt7UZWoRcyZ0RfTrsrQV/Lh8YRQheQNkBE2r3B0JhVpl3LKWdCxJy
   crm80AK+JtYO36NL+X+MOT0PbS2sZPwugDWzIEf/XEiv72sQadV94MWqH
   A==;
X-CSE-ConnectionGUID: iJrhusY4SSinhx14hJECAg==
X-CSE-MsgGUID: KDKRsyDMRoSRYMiNf+7rGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="43145149"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="43145149"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:31:08 -0800
X-CSE-ConnectionGUID: vtUW9dZYScefXDBNlJAkmQ==
X-CSE-MsgGUID: UmXPXjvuSGi90g31R72YOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="88466198"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 16:31:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 16:31:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 16:31:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 16:31:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHeqQ2x7t9zsf7mLS42Z+XcyaNLXJ9ELhgXmBz0tqeJoDGdrQ6YNOXjgV/vybPNGOOojQUhIXJkMukJJrofjiQOLZ7o3CAgHWurTZAvrtptafRsKgpt5QqIQswgtDUGB4kYssIWkKbicCbMvtGbZ6vBEnLzTxXgAGS0oM1SKgcRIMWPizoIt8GuuM7GhRXvKz1r7k5a0OBcNknF00xqXbZUCq+YNAkMt308D6iC0dC/MovoJwxa1+yr8q3ZPiIVX/vvGpjgE1+uvfiv9bu/CFEunthE5RMXDBIvZdIbHtQa4LEs0GU0GnLNFNZgR9Y9xL0xTXIldnTQ5YxWEu0VZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8r+XyB/e7L8rPjqRjD+UIkksO4C2Zap6GwexYN6RFw=;
 b=kQp9ojTwI2NIBafoC4yRAxh0UCHrSBDL4Q6RNCS8B/0oSEQbhrsbbAOJ4xchcdx7lEqrhn9HPtA8GZ1Dth35KVqpq4ju43/+/1JBX1xg9VhoihuJXh0dlTllxonCG4i5DlNCh39CXTkwsBRKy8iC28tnT13Dz7Pd9xsx77NSZm3g6NuKjPaD0zEBLBStNDi7oYLV8vvFVIlVd8MSPyc6NSWgztmpeCdxM/x+KJf/IlinJSZwPPiQeLB6Nmp5Gcp3McaDDVYQgVLt8JIaKVwIto0jjRIsP3Xvx8E+4lgCLq0B4EbKEZR0CeA4OikitZB080MhkQ7cUjKEr/8DdChZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sat, 16 Nov
 2024 00:31:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 00:31:03 +0000
Message-ID: <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
Date: Fri, 15 Nov 2024 16:31:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
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
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: cea716c8-f7ba-40fc-25d4-08dd05d5f3b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?USsvZ05sYWpEYlJ3VW9nTm12Ymszdm0vQUI4eWRGM3R6ZkxDNmdBSmZjUWhs?=
 =?utf-8?B?ZW91a3VSRFpYYUZjeWZ3Rk1vcDVLWER0d0Y2aTNNbmpyVy9QK0ZwODZFVVhy?=
 =?utf-8?B?K0JTbEZpVXFYNmNPS1lwOVVMd210UEV0MmcwK2pweWVNVVk4bEd4M1FQOHlm?=
 =?utf-8?B?RUtSdWwwVlh0TGFoVHRXZkV4YXR2LzJ1U3hzT2FmSCsxWXhDZEd2OVFEc1BI?=
 =?utf-8?B?bUdIN2NXWnhaMVBvWkZaQUJyS1NzQXZHbm5Zei9ORWNWQnJjejBlbGJnZE8r?=
 =?utf-8?B?RHB6RGlxZm41WE1kcEl5VlZyOGgyOEtORi9wTnordE93ZjdoSEMzZzlqc0Z4?=
 =?utf-8?B?cXpoZXZyd0ZtalJmMEc2OWNRb3N1SE00dkxWalQyZW9BdnhiODhReHpJVGpl?=
 =?utf-8?B?VTNkUllwWXFBeHJLNFBWVmlKRkVGaWlPdUJINWp2UlkzVWNjZ0swSUdvNm9i?=
 =?utf-8?B?QVRqTGU1ZVYyUjZEeDhRZm50Rzg5amg1aUlGTDQzaGNXKzl0U3NITTlKd3lo?=
 =?utf-8?B?UVp5MDJTbUV6Z0lKV0xoRXBMMythU1lTYS9OYXBHNWMxeEUzajlQbmxOalVr?=
 =?utf-8?B?aVdhdThrTFNmbWp6c0I4ZGFCUVN0OEFnY0dqTUhmRlBZc3lBLzhFNFpkWlB1?=
 =?utf-8?B?dlpSRGVBZWV4bzBHMUwvc3lIOTBCaWJHTVVYWDIrdCtqOHZhc2l0VTJvYk5o?=
 =?utf-8?B?aVF5VDJFOEtnVTFLV1dCVGI3MGlpM0pqOUZpaE14ZHBBanM5TmtUckNacVQ3?=
 =?utf-8?B?N2dLbkhHMTFqNEkyZHdVL2tUNkhSdXV5MG9uTjZ4Q0xxL2tvekxRZEVlY2RK?=
 =?utf-8?B?RmNIWGdleFRhME9yVUFncnN3VWlGK1I0djJxYUpadGJwWmtCYnZZK3Q1bXdn?=
 =?utf-8?B?WTFCK3ZOSVdTdkxVelVOV0I4aVJOV1BBY1NBaFJlbzZPTWF6b01KRGdVbmcz?=
 =?utf-8?B?WTZRSzFzWVd6cFdlWldBM29HakdsdExUSC9ZTWNCdkhYNm51Um9pZlpoNjFG?=
 =?utf-8?B?d0s5VGlITXUzS2lXbDRmVXZnRnF1U3FncG9YUXVFTkZQNkhNcjBpT3hGd0Jr?=
 =?utf-8?B?dTZ4a0tETk90azU2TEw5dStIbThuUVBwV2MvdVYvd2k2YmxrVXl2Q3ZEenNZ?=
 =?utf-8?B?ZmpaSHlQWTlBMDZPaFcwYTRBN1l2YThZOTV0RnR1ZVh5T2s3bFdaRlI5bmVv?=
 =?utf-8?B?Wm1BQ2UrV0V0WHM3dFpkamJQT3oxa2dSZGxGbGVKQ3JpY3N1SUtZS2MxRzV2?=
 =?utf-8?B?MTg5SHVJT2g0MFRqeURnZ0l4aVY4Z2xHd1M3ZTY5dzdBMkpKbldKT3JIVjE0?=
 =?utf-8?B?L0c1dkRxMzZ1aHdYT0FLRDJQUEw4SDFCRTk4bHNkUlYyZ1Y1dmtRQzVEREJ1?=
 =?utf-8?B?NXA3cFY1L3RSNHFWZjdzY0NMQVMxNFBLVll6WmJBblBNaGNuNDNRbjV2UjE4?=
 =?utf-8?B?OXJKMlhUcXkyaUVoUzFZV05sWDNMYy93ajFOcU1oTVFHUWVrV29HaHVDbjB5?=
 =?utf-8?B?b2xBOGIrT1UyTTV4KzYrQWdSdUtJOTVheWx3aWFoeDVyVTdOcFdtTVU0WTRi?=
 =?utf-8?B?Yk0zLzJNcW1aNkdMNlNKeDhkaDRPdDBWc1kzQWpXU0o3bVp1VjhwWXkvNWtB?=
 =?utf-8?B?bk9HOThiYkFHUXpLUm1oNUpsMFlYaW40LzFucXlTaEdEbmh2b0FHZjNFMHJ1?=
 =?utf-8?B?QlR5K3REYlNmUmExWS9EK0F2eWMveWcwNFhHNURudDNQSDh3bFNwbW9zSDRl?=
 =?utf-8?Q?YIQph7R93XMAuQmOrmAbamAcPu7iPsdepq6sO3X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVsRmZJTlU5RkhjRWRweDNlUVMzeG1LR2o4SEZVYkR0dFB0bm42QjRobHIx?=
 =?utf-8?B?RW5kanhoRWNCVEFjN1E2djB5OHRudy9JVjhIMmZFZm1kOGhjN1BGbjlsSFQ5?=
 =?utf-8?B?WmRaSjY4S0J6aE5XdkxZT2xMb1hMSCtldDZnVlBWZ2NWYVhlNHA1aXpYMGtO?=
 =?utf-8?B?ZkZESlZBRzhtMWVrK2ZXWnFDVFIwNDRNeDJqRVJGdjNDSHFRTVJOZWp3ZzVa?=
 =?utf-8?B?clJEbjltZTBrNEtmbC92SGFJaGd1TFZSTWtvRDZXYkhPSEFUMmhCdTFZUGpy?=
 =?utf-8?B?RlZ5LzNQUnpwUFJHMk0wK29pU1dGVFgyb2VuKzNQMjRhMDMwUlBkc0N1aHRI?=
 =?utf-8?B?a2huU2MxR3JDTXYwbytnVmlERncxdXJOUGVXaFRnY3J3MElCQ0QvTkNTMzE4?=
 =?utf-8?B?RGI0VFdiVm5TZ3VhWTRBdTR2SnFaU0dwM2U4SFJDcEErcWtnSGVOWkl2dFl0?=
 =?utf-8?B?SWlqK0VnR1NiYXVrbUJla3RTRVFhYUJnNUovNEQwL3llSnpPdDJLQ0ZnQmdY?=
 =?utf-8?B?eTRqeWtJcjhBQWlhaXhBOTQ4SW53ZzVsVkFBWlRvL2pRcm1MZkFTQ3A5eXBk?=
 =?utf-8?B?YVRJSzgwcW1FYnhwMlg1T3NRRllMakpGR3ViSHBOMDEyYjFGdm00RXJvL0lV?=
 =?utf-8?B?b3BXSzFWQzcxR2haUnROK0w2R2lmampwR2FCbUgyMzFyYThUM0pzV1VOMlov?=
 =?utf-8?B?NGxGN01vd1o0bE5qbCtxOUl3eVJHR01OUEljbFNzeDg3NXpoRTFEQ01NVTJr?=
 =?utf-8?B?a1ArREs0UkxZZXdncTNIdXZod2RCU2c5Uy9kNzBWSWRjNUVCb24zS0VxYm9w?=
 =?utf-8?B?V2h0ZklFVk1JSGlxNmhleTg5bWdrdWIza3RSR3dFb0VyalhjbTZsdjZRVmZq?=
 =?utf-8?B?dFp4NHJzNlo2V0FyZ2JwNi9Rek5wM1hWNXBHMGtLUEg2MnFFL1JnVTY0d2gx?=
 =?utf-8?B?TFJNV1lJY0d6cHpZdGdaZVlMRmRvUWVrQUZmQWU3alRURENDODQvcjZaY3pv?=
 =?utf-8?B?akg2T0JTQ1plU3lVT214b1lUVFBhUXpEMm40V3RIWHlITVFjVWVMUmVlbXVv?=
 =?utf-8?B?QnVSN0V6TVFrYkFOSlZmUU5QZzgwcXNnNENYbzA2b2NKV1llem1UUUJjM3Jw?=
 =?utf-8?B?Z1ErM25Ba3g4UTBFUEpXY2V0WHIvTk5JTlVNZy9iZXcxd0RwV1YwNUpnR01U?=
 =?utf-8?B?bm5SZkxqOEhDWDFsc1RSVDRSbWxzS1IremczK25ENGNjbXdBZEc4N1h4TzZU?=
 =?utf-8?B?cGpjYXJ5YzdOaUF4WUgzdzQ2bzJpVkY3ZnV6dnRGZTJBblBidlZSaytEeFAy?=
 =?utf-8?B?UmRTRzZzNElWSkswMjEzelNtU0lPUmhzd1RSeXdZTisxYlFwdXMzV29FZC8r?=
 =?utf-8?B?V2ZtNlhxUzJxTmtaSnY0QjN5aklBQzRpQUVGUVQvNHlGWklxTW1rRlJTSXhR?=
 =?utf-8?B?OW5FbGZ3bU8yeXpreGwwU09wRGU0Tit4YlhBWVdmRjZ5U0lZSUNBRlpyRGk5?=
 =?utf-8?B?RlJkbXFoYzFTZ1B1S1Uvalgyc0hYQlJTM3RPbjJMemJDZXJITDdxZElOOVVM?=
 =?utf-8?B?OVo5eXM3eWRGTFU5bkc4b0xLeXk0LzVXTFlBK0JQSXorWENicmxxMStqR1FP?=
 =?utf-8?B?akpwUUgwUWFTbmZPZmlRYmZIS1FGa0djbVNNQ0NKaDB6YVBYYVZ4T1dxclNh?=
 =?utf-8?B?VnhFU2p3djVROStOYi9kYzBybHdmTG1tUlU1WDVPUWZsZTJEWitvK0h2N2JB?=
 =?utf-8?B?YXFRYmF3QTRkZHhyc1FUSG53cllvTWxzWE50RjMzOGVwYnBvTHBDMzNIZHZw?=
 =?utf-8?B?aitmMXpYdkZ6YTNFZk5PaFY2NG1WVSswRytseHFVZnFydmxVdzJLTEdkZThz?=
 =?utf-8?B?Y3FxY3FvZHZlZVRreEs3Wm1hYkV6KzkvKzRtanBFTXM3b1dQYUx1TGRwMm0x?=
 =?utf-8?B?SnVqNGwxdEFsRGhXYUV3dVB1alkxTFFKR0hNV2hFdlAzdnpDQXVvZGhHcm5P?=
 =?utf-8?B?S0FDdS9BZFFuOTlMSUxEZlFJeWgwSHpha2d1UTYrVzlIY055YjNqVHEwWGl5?=
 =?utf-8?B?MlI4aThHOTByK0xScklnWlZacE1CN0JURDB5UG5ZNnV6czkwT2tvTU8wemJP?=
 =?utf-8?B?UCtqOXcyN3k5WDltL0lRQ2Q3aE1td0tCVnB5cXlmODZ4ZFFjT0V1cHhtMUFl?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cea716c8-f7ba-40fc-25d4-08dd05d5f3b2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:31:03.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJaITM3JdxhvDROC9qrzDSVgyaIryz2jnPAjMyqTwR+r9sTuaPzy+vYXXvoj4Oh2yI9OVd8fr/H9NmhuizRplsdoWZu9TQKGJDOWcJBMDL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> Provide the interface to display the number of free monitoring counters
> available for assignment in each doamin when mbm_cntr_assign is supported.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v9: New patch.
> ---
>  Documentation/arch/x86/resctrl.rst     |  4 ++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 2f3a86278e84..2bc58d974934 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -302,6 +302,10 @@ with the following files:
>  	memory bandwidth tracking to a single memory bandwidth event per
>  	monitoring group.
>  
> +"available_mbm_cntrs":
> +	The number of free monitoring counters available assignment in each domain

"The number of free monitoring counters available assignment" -> "The number of monitoring
counters available for assignment"?

(not taking into account how text may change after addressing Peter's feedback)

> +	when the architecture supports mbm_cntr_assign mode.
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 3996f7528b66..e8d38a963f39 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1268,6 +1268,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>  			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
>  			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
> +			resctrl_file_fflags_init("available_mbm_cntrs", RFTYPE_MON_INFO);
>  		}
>  	}
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 654cdfee1b00..ef0c1246fa2a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -898,6 +898,33 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int rdtgroup_available_mbm_cntrs_show(struct kernfs_open_file *of,
> +					     struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	struct rdt_mon_domain *dom;
> +	bool sep = false;
> +	u32 val;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +		if (sep)
> +			seq_puts(s, ";");
> +
> +		val = r->mon.num_mbm_cntrs - hweight64(*dom->mbm_cntr_map);

This should probably be bitmap_weight() to address warnings like below that are
encountered by build testing with various configs (32bit in this case). 0day does
not seem to automatically pick up patches just based on submission but it sure will
when these are merged to tip so this needs a clean slate.

>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:916:32: warning: shift count >= width of type [-Wshift-count-overflow]
     916 |                 val = r->mon.num_mbm_cntrs - hweight64(*dom->mbm_cntr_map);
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from macro 'hweight64'
      29 | #define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) : __arch_hweight64(w))
         |                                                 ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bitops/const_hweight.h:21:76: note: expanded from macro '__const_hweight64'
      21 | #define __const_hweight64(w) (__const_hweight32(w) + __const_hweight32((w) >> 32))
         |                                                                            ^  ~~
   include/asm-generic/bitops/const_hweight.h:20:49: note: expanded from macro '__const_hweight32'
      20 | #define __const_hweight32(w) (__const_hweight16(w) + __const_hweight16((w) >> 16))
         |                                                 ^
   include/asm-generic/bitops/const_hweight.h:19:48: note: expanded from macro '__const_hweight16'
      19 | #define __const_hweight16(w) (__const_hweight8(w)  + __const_hweight8((w)  >> 8 ))
         |                                                ^
   include/asm-generic/bitops/const_hweight.h:10:9: note: expanded from macro '__const_hweight8'
      10 |          ((!!((w) & (1ULL << 0))) +     \
         |                ^


Reinette




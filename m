Return-Path: <linux-kernel+bounces-411526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B5A9CFB81
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1D1B2BA64
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ABD623;
	Sat, 16 Nov 2024 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUSbc4Di"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494928FF;
	Sat, 16 Nov 2024 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715939; cv=fail; b=e9a5WJdeGP9MqL3R4qo+NhNSx7STcQ2KhvQ4o1WW7DZZ9ZK80GO37uOqTb1aVUKTO2AqSeKQQQNWin4YKihU7GMfi3NdYg+C71bJtnM+mAywLgcAoWISfriZJahxSbUNvoMmVb8k8/qHt3894ykNWP6hSggJ0Ar0/DoaCYDshZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715939; c=relaxed/simple;
	bh=dRNl23lpFRuj7ZGNoo155gb4V103djWEGAGImcDx4HM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JheycDuW+yi0KEOvmPH9CX7G4d7F2x2XeCuYW+fN/4oy+2z0DvRjzv1HKtdwnSXCLsaBNSK/GQrR9V8mH5SGS9W2ZHgtun2K9+HCwOIBKuwd9hIlOCfpf9Py0vpHBJALeu4f+T810EHqBklRnRlfhVu7FfekTkqr1Myb+jTa1No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUSbc4Di; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731715938; x=1763251938;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dRNl23lpFRuj7ZGNoo155gb4V103djWEGAGImcDx4HM=;
  b=dUSbc4DiujlIPqHf+UqPfbspknJg2C5qIUSYKSpNoKw4c0qscAVAeOKk
   fAqMGhTGUohSemNxEglcQ2pEaRlHffHYeL7B8GncoQ40iMy7dkQqkXfww
   CJomqKfrEZbWGXUlshrhpaJcecC/jqwxX+2d4EjPmSFG1mw9n03deyTXl
   mxf9KrYJkBByvxJc694ywWH7evWFSJXCfT8NHEd7DX96A9HyZ4mPAvaC1
   nZ98dldi1/GuQf75v2qR224jM8gaQ75dlQH1ztZ29/6yjCektNJv0ZOHs
   AklhHk+OBl+e7a6RIkauV1ijDtufQdNrvhvWTDKQ/HEoCqq/Z8qa/uDuH
   A==;
X-CSE-ConnectionGUID: 4O1njE3NRSKX+WIwe8f18g==
X-CSE-MsgGUID: tuJ6eRf3TrOSCETf4KHoWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="49270700"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="49270700"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:12:15 -0800
X-CSE-ConnectionGUID: cZoyBEfqSKum37iJT2P6kA==
X-CSE-MsgGUID: T0cQxtIvTjuS9/HPmNd5Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="93159238"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 16:12:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 16:12:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 16:12:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 16:12:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFPgTVpE1q+EH4EF3s8zB64HkbG4h9CQZ20sZUKpWhMogBeJwmWN15Z76ffbCvRIk3Js2Bwggh7LCkUPhl2P70V9Nv0JTTQ2uNoQb2bhGZVpwbpvK2YgtcokxpYEwrF3xJ425FTcW5lWG5og+ieZ5uxmWLi6KahoJe6ModUK7G5eAkpJWHgHHQZHDbXjdCbimvGh6U6+hO+jUqGb48DHo8rn4ujpvJHLogbk1rNvP+h9fx8utbJsRT3qX2I97G82uYwFdYqBf5zBXG9MUoyowZ88xho3HObYzGg4y0+djonfT4EYvB1LNmxTXBR21vFAuvGH4KdpMhgDwB6wYJlwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyBG+zUbwGYRzWTBkdIZ8/sKNsxcom4AEIQS91NUNx8=;
 b=c+TeO3z0RKaktJM70mCRtoS2bVXgDegUKNR2QJWZbfNu+9gPE5vaEGVaba0arvzk7OIpL38/kV+xSNvVxrRYQx2dgO5zQPt/XEvktw4M16jlYFhmR66wsiN1ETOAn5PtO1m5fsMAsi2fK+y1hmjC/f1PMM9EqUhmmdAw+eTXlINVy7+MFbTyl0M0SyqzwdJcS+xCwJ+KRAqW3/aymKYerLKiw9uvvsQVudyWIkS3YrWhV4EbN4O3rdzUkCc6FEvy6bcDmQHhafJFxs+ykhCuBXbEiYfqDNEXAM+7r7TJn+jHRZar9KLPcx06mPWxScC1Nd4tYyB+zvTET3jmunJ+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7944.namprd11.prod.outlook.com (2603:10b6:208:3d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Sat, 16 Nov
 2024 00:12:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 00:12:00 +0000
Message-ID: <eff4e779-405b-4540-9884-19bdd34ddf6e@intel.com>
Date: Fri, 15 Nov 2024 16:11:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/26] x86/resctrl: Introduce bitmap mbm_cntr_free_map
 to track assignable counters
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
 <d9a18a268ece764a18a177ebfddb9899e53314aa.1730244116.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d9a18a268ece764a18a177ebfddb9899e53314aa.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 521d747f-7224-49de-f677-08dd05d34a9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cCswek5PNE5oUTBjTGJkNHI0VlF6eVh4WVpXV3BNaEZzQThEOVdXSXBnUVdJ?=
 =?utf-8?B?cU11cFk4bStzeEluRnJVUlVmUURRRFNlUFdLR0RJUXlYUDd0MmVUQnRieGhZ?=
 =?utf-8?B?dm00TWVhYS9FVi9tZytpNDBFQ3VuUmRKNlpCTHBIVmtYUzM0Zm9jZkhSbWpa?=
 =?utf-8?B?bTg0Tll6RTQreUFzdEJudk4zT0c1bk45eVlKTkNuMCt0akxmKytTcGM4eGpI?=
 =?utf-8?B?MDRwWHVpZ21LKzNPZEVRWnYxQ3dMclJwTjVzYUJhQUxWTk5Zd2hocWYvaHhv?=
 =?utf-8?B?QjI2VHY5SGtHU3NiWkdKelFLQ3k3U0RNcFhWeDFBWHdFdWdMdlZEMXdVRFRp?=
 =?utf-8?B?YUxHRGpIYkJvb2NwNkVKb09IMkMvbURITUxjRWJuTEdtU2hSdERCWTFDR0FQ?=
 =?utf-8?B?anBIdDBGNEdhUU1YQmlrdXdIMm1JWm1Vczc0NmRoNzR0Z0MyNTYrbzc0eG83?=
 =?utf-8?B?bVJvQnROMEo4bDVpWFhlR0RJVFErUlVxVUxWeGlyc0xIRkJMdXBSZWRyM1Fo?=
 =?utf-8?B?dGJ2NzBEMkdkZERreXozdFptRzF3RisxZTlFSHRWNGpRQ1pZbzRndDJqY01n?=
 =?utf-8?B?RFc0N29QeWQwbm8xRUJCVGl3ekFQcW1JOTVFd0lQNHNYT3JIYmo1UG9hRGVJ?=
 =?utf-8?B?MXBsYVhlOXBWQ1UyVUY2VU1uOVA5U3NWQ3VsL2JZYWYvd1JWekF4MFVhQUtn?=
 =?utf-8?B?RStaSkhDam5sYmlDbmVBbGZXbzVQbExKdDA4cWhBWG9nWmNHcUxGT3hxaGNF?=
 =?utf-8?B?LzJsQUhrYTFYQXVpTDAvQm0ycE0zWWlUOGdvWGZRWnFmMlQzazRWL0Y4Zk96?=
 =?utf-8?B?Z09OVUNuRm1rYUhXZkM3dTlPdnQzaktLclJIczRPRUw2eDlldTRjcXNLVDlN?=
 =?utf-8?B?Q2lkR3NyQ2ExZUU3bnNlckZsTHhYbFhQNlBsdUZuVzZyUGU0QTVxSE5IbnF2?=
 =?utf-8?B?OWRoclZPRVVwMDR2QXBodkJWMkRIRm9tZWw0djBWbko4OGNPOHRmNVFISHFt?=
 =?utf-8?B?c3RoRW9tYzBrQlNNUlBGUmY3eXRjVTJUM0xXeXF5bjFBWTlkeFBOWGFNdGgv?=
 =?utf-8?B?MHRjcVFRNHZuYkF6bHhuWDh3OTJvTDBPYXY3VFB4cytGU2ZDbGUzYUpFVzdZ?=
 =?utf-8?B?S1dNbXVqaEZwcDF4aWtXNEFOV3pKR1Q0NHgwMWxHZHBRYllKWGViNURCWXBy?=
 =?utf-8?B?Z2h2WklWbGF4MGFDWFdmbWFTVXlJcGROeFBiUUo1TEhnYzVDRE92ZzhzTG92?=
 =?utf-8?B?TmZHZGpjUWlVVVBFTkF6RTJpaUI3SmlIUmVUNVk0VmNWT01TandwTmFOR3hu?=
 =?utf-8?B?Vk43TkxzaGdvQmhvK09nQVgrT1djczMyZldsZkRQYUN2ZEdoRmpEb00rZU1u?=
 =?utf-8?B?K2tGVXJiTE9RVDljNlRwZHFFTjRvaWlSSFpUUVo2WHA2bTFKL3VYa1FNSUpZ?=
 =?utf-8?B?dDJnVENjcFlVVzdJZ3p6MGpkZm9aQlo1b3BXbmxBN1N1RmpCdTE1eE81SmhQ?=
 =?utf-8?B?WFpsRFBaeWJ1UEF6Zk1hTjBIRnd2cEpCdm16OHpRajYrUzg0S1A0YmlWb0xq?=
 =?utf-8?B?c3ptWFFmTEcvNHdvNlJ1NzlkWE56TjUwNXdiUlZNQ3psS0VDQ3Q4NjcrcUwv?=
 =?utf-8?B?ZDhucmNjK004L2JBMnVTSFY4bUNCNFZocnpPdzltd2R0aHBhMFh5RXlpNnhw?=
 =?utf-8?B?cHoxV1RLRW5sRlROWXN4d0Y2UDRHQ2g5a2ZETWM2S1FTNnBPWWVScXIyUmNX?=
 =?utf-8?Q?zCyCAn3TecVKbSDgMFIyDPzudKjjKl32p7T9ix5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmRwMVZoK09wSlhUakM5bVlMTFFHcGROa3pEKzZmbndWUm8xLzNjNzh1WDZk?=
 =?utf-8?B?S0hSc2F1ZVJnMmE5UWsrMFF0TWs3U3FQL1dLLzM5VTIrUjVHSHhyQUk5ZGpL?=
 =?utf-8?B?Z0V3T3R0Z09NVjEzaXNvRXA1d3VDQStRMXJ1Q2tFdXFORlVjMWhEU0ZXOTJ6?=
 =?utf-8?B?QjdjTmZ6VXQvNzJCYmhQa2lrRVE0MFBBU0FWL1hZQkhvcGRNeHZ4aEltV1gy?=
 =?utf-8?B?b25LclcxZ0hsMHI5OGVpS211SmUwVlBoQ3BPdU42M0NGRmZRaTU0bS9lOW0w?=
 =?utf-8?B?T3RSSVdiT1RGS2tKN3gyMEVrUGd2TjJyc2p1alR4NUVGaXhIR3RKcGJCNW43?=
 =?utf-8?B?NjVwSjB2L0ZtRW5Da2Y2dzRSQklLYjA2d1JFL2NFYjFQelRRaHlrYVFZRHgz?=
 =?utf-8?B?dTBidzNsRVIxQmo2VzVtclFTdloyeEUybGRwMnVGZWhvRlo3SjFuUXk5U28r?=
 =?utf-8?B?YkxJNGJYZmtkeFArdzNKdU1PUllwV3QybTYrRjhtc3JnclB3alFjY1AvMDIz?=
 =?utf-8?B?ZThCN1RYNDJ5ZkVMbmVGNzNzK2tRWWlPRDVpV0FpeHVhWGYrQ1NhZnFmaEM3?=
 =?utf-8?B?TnJrVFJOWmovVjJFZisxM3JMaWlYMU5rRE1JQnp5SUU1anJ6UHpGZ2s3aFNt?=
 =?utf-8?B?TElKUTVjd0ZVUXlLYW5TQkF3aERYd2FwRmhxMjlydE5ZRHE0aTNWUE8yQ0pi?=
 =?utf-8?B?U0RQNlFVTDJDWnhLQUNacjVEUDZDSndXb0ZaK0lKWXk5WkM4N1phd3hTcmMz?=
 =?utf-8?B?MFZQbjhEL0grYmQrK0MyU05SbGNPQzkyM2cxTGt5ZnpkTk0zT0hsWnB3UW9U?=
 =?utf-8?B?MG1IaWtvN2tlOWhWSU9rTUdrajd6UzlRZmMySTA3NWJFSDVuTFVVY3RISVBC?=
 =?utf-8?B?MGk1UFRrQ1BOZFpEMjY4bVUzMWZyaVR4UWQ3YmNrV3NvVkFJM1k0WVBHQ3Y0?=
 =?utf-8?B?akRtcGFmdHFGUllrWHhreUx3MGd1VTZzR0tueXcwdWZSNnhJZ3hnanhLdlls?=
 =?utf-8?B?dkdpZng5VTVQU2JVU2ExREg4aDdjdDhJd3doRVNBRXU1N3cyMnlJeGlOUGxo?=
 =?utf-8?B?MDhhYmk4alZXZDErbmlIR1RCK0haSEoyOHNPQzUvcUQxakdmNUoxMlRTak90?=
 =?utf-8?B?Q3ltM0dIbzJ2bUNnaUxnZS9weFVXQmhwanNCV2x5bUkrS2xPZ3l2aExJT0ZI?=
 =?utf-8?B?clhDTnlTRFFwQnV6N2NleFAwSUM1R28wdUl1dGR4MncxSHdPWFVLQVk1OEZr?=
 =?utf-8?B?SXZPODBFSXJlUjUrYmJwbVV1NEJTa0p1V3ViTTVPYmltZEZzakpiZyt5Z2hC?=
 =?utf-8?B?ZVZEVVlKVDZ6aURqbzhrNURINVlCZ25SOWMzbDVwNncvelBlb0pmVTdpYlc0?=
 =?utf-8?B?VzFBL1ZwaDhCTHdSb0p4Q2dMZnJOaGYzZXF0NklGWHB5c3hhTDNORzhOSGNP?=
 =?utf-8?B?bGtqNW5Gd0VoRjIrZmRQK2VrNHFyekZtczBtdktWeGV6QTVwQXE5QzlUVVFm?=
 =?utf-8?B?R0sxN2txczNBbVZtUUhFVlFVNmMzSXZ2b1I3d2k0RldEaUl4RlVLNlBBNXdX?=
 =?utf-8?B?bmNXVmpsZzR4VHJxTjVYQ01xYmhDYStIMWdMTHh4NVdISElxTEhUYVNGOFpL?=
 =?utf-8?B?NUhqUFI0aG5wUGJmdndQMzlwdzNQS0ZYeUo3ckV4K2ticlBDemhwRDFjWkRH?=
 =?utf-8?B?ZThuR1BlZGFpZG4zaUowRFdGczlIeFVPSTg5dFhUSXBISEZ4WmlGbVhHU3BO?=
 =?utf-8?B?aXdNd2ExUVcyS3orM2wzYlRiN3FIaUNtMXM4ZXc0aTdYNlY4YzFpRXFIRVhQ?=
 =?utf-8?B?L3h3NTcwSERIanpHTWVWZ2oxVGp5YXZSQVFzVWxwWUdFZ1RPTGVLNlBHQVBZ?=
 =?utf-8?B?ZzNibWNPTjFybE1Hd2t3dm1ObmZNQm9iTnFHRWl0aGdrMERSY285YWRPdzBq?=
 =?utf-8?B?djd0U043T2tBOE5DZm1SRlB1NGJDaStrZjgzcDBwVFgrbkNXc1AzMUdwdi9o?=
 =?utf-8?B?cmRqZG00TW9xRU1XbEY3YnBHMmQ4MVdOOWFBc09NTVRIWTJPTGhkUC92QVV0?=
 =?utf-8?B?NGwzUGxYNVcwL2d1Zi8xTkU2WkVRQ0wwOTZ3ZW02RFZadko4SUIzWXIwL1FP?=
 =?utf-8?B?aDZDMEErMmFZVnluS0V4dzJYWUE2TkgwR25uWUhseUlHTStVQVpSVkkrMEV2?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 521d747f-7224-49de-f677-08dd05d34a9c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:12:00.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1R/y51AAkRDy+okV8YW8ftXiSd2TNebqZvFkxTuvCTJHuII9tixUtzqLASt4iOaHG4lXU//ytC7xYthiySfjmi7VzqPLpZazNFAkpZZ16s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7944
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> Hardware provides a set of counters when mbm_assign_mode is supported.
> These counters are assigned to the MBM monitoring events of a CTRL_MON or
> MON group that needs to be tracked. The kernel must manage and track the
> available counters.
> 
> Introduce mbm_cntr_free_map bitmap to track available counters and set
> of routines to allocate and free the counters.
> 
> dom_data_init() requires mbm_cntr_assign state to initialize
> mbm_cntr_free_map bitmap. Move dom_data_init() after mbm_cntr_assign
> detection.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---


Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



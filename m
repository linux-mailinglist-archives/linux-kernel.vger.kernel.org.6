Return-Path: <linux-kernel+bounces-430549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFE9E329F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F698B28506
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4D175D5D;
	Wed,  4 Dec 2024 04:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQ3P7GN9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82B2500D4;
	Wed,  4 Dec 2024 04:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285802; cv=fail; b=NEY+aW0zM8CUGiPY0b4yuec6nZk5jhU3DabvIBx3JMl7m0aYRxDwy3U/6237vO+8MwvfdbXZZbwa/uB9oalQ3vkwW5vyQj57oWGlCPoZw6vv17NhwURkqoGUZzX1nm59VPrw0x9mcQl4CJctWCbXbf4DJuUHqKL/SRIlo5ZNG8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285802; c=relaxed/simple;
	bh=z6oeKBI7U+ruonc0QBNwbXQ827uH9bttXvT3yfIZm3c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J4k+EMnjieZqlzmMk2Eq6BoUt+bKw7ndZZML72IPWNX0PMEI1HNT7xQn1anUlEano18/WhG6ahNJgu1PTVVNH2/bLdteNZCg0J0Zg7kxXTvVSzf7XxgpPXbbvCikdJn+XYd5qLkend5LZKnn1fyZIu5/eQselyC1OpxeI7HCVXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQ3P7GN9; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733285800; x=1764821800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z6oeKBI7U+ruonc0QBNwbXQ827uH9bttXvT3yfIZm3c=;
  b=TQ3P7GN9uLD+mLYVIkLHJm56CeHUVZn4UXkJY+h2LiWmdXUPt9VoX42h
   WR5OaYl694j4IfzY9E/f/Rpa3GDqQSCoq1R7/uJv0GoGXnTadv9qSmmnE
   cRk5fad5S9xiAKTyHzGy2paTnrVMUmNwguS+Ic/jp7UcO08V1usvV/W68
   QdW06Fk5TggO5BIhkaptcH0hf+7wJHmfcxwOuYoaFUfmM/0m48607wucJ
   hl6AgyaKM6H21zJxi1zehlaVVo1lMqMHT80ysbrlHsvvAMFVmFIobBMg/
   tjczOANjiZ+0vxTXQiXW3EwCBPGQFE0+8744o1cLQybiFPvoQbT6DJ2Ts
   g==;
X-CSE-ConnectionGUID: mZE1Ee6PTeOooatKcgNSRg==
X-CSE-MsgGUID: G4KLNqHVSlWpDvDqChQylA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="36381280"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="36381280"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 20:16:13 -0800
X-CSE-ConnectionGUID: ZXYXgRZHTm+COyj/PCRHkA==
X-CSE-MsgGUID: KYWjf/amRHy8ixreID6Mnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94072280"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 20:16:13 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 20:16:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 20:16:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 20:16:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJNHr1AbFhDOxe06kcpu40TGgbB1dMUbDqfvkN4WJx7c5iMlirHZuLQlg1S/0/P9f4jImevQC5PsmR10ylzXKLAQ0KomwFDq55QzZ0nbekBTK2ZNDUP+euJwGKfMWbNGW20L2V/bzBIgGhbCZb2VeI3eOKsOamGMuD6sTf0uJH60hxz0XgLo0jlOzMPy4EJnmSqDNTjiZ3fvqEzFtByNH9U0OctRGZQsvl6HqbINoqZZTakmoZRUZMQKNOCwTSKgfFMyj2JjC24ChM/9n8nfrjdsMdUggXQ+bb2PJbvv/MDjEmO+1iayQBrrdKDlEsQas7K8Xf+qLt77tqcA5q3tWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SduQ+LhTz0aoa6qToXx7yI+2gJnHBWws2PND7/2giGM=;
 b=FX22e3g9t6t9hY/ZkRG4bHUaEK08P8mYT8plNifxpHtsfqkM3ctkUF7AJZh4OnblFpd1sEjKQlR+BiGIbgLxvwtsMEoREJ7WTWT9/enTdSJnvkoBZMu7Z5Ll0nuopeBsGi28MIdZZgfIVAUtpY7sJudTqaq23hFeZzOIRyuq2pRJx0NA4UHjarfGprdxjEwVkX8IFJ4ogDJGLUvVmPQP8308SXqCzXLD52CLhKWacXA16vinCcUiBehe3/WaucuCWgfDpWxGO2QTyWGU6p6Hr4DhSgAJ4XTEUXcxCrgNTzVLDm46N8P02/gJUL/Bo4RcEPlISqWgQyIIWVQiBl5VUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 04:16:09 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8207.014; Wed, 4 Dec 2024
 04:16:09 +0000
Message-ID: <3061ec99-c418-b1a3-7975-8a6b9d0bdd14@intel.com>
Date: Tue, 3 Dec 2024 20:16:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
	<reinette.chatre@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <thuth@redhat.com>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <akpm@linux-foundation.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <perry.yuan@amd.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<seanjc@google.com>, <jithu.joseph@intel.com>, <brijesh.singh@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 07493eeb-f72e-4e7f-2c09-08dd141a6154
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODNFSDI2eklxSkFtTTRQWFVsMHRwK2dqenJvOURtSm9NMHQ3UW5HeHVvc0xS?=
 =?utf-8?B?dnBSbEVlUWQ2eUZSWGVVZVllSDNZbW1lbVBONVNqTWJvaUxqUThHUWIwQVF2?=
 =?utf-8?B?Q3lzMTlUZFFwWWJZYmp1UlNTVU42ZUVQdWwvMXp6Wlg2VnUybGNTUGZSNlYv?=
 =?utf-8?B?VW02a2FQUWx0c2lpeDJVcUZnVkxDRUZkdnlSaFp2SGxXRlcwRHFPbldTOHhm?=
 =?utf-8?B?UVRZU2d4eEw5VEJWUFJOZ2NtaU40ZDQ4cmtzYTVpTkVRbWY5WFVic3lUN1A4?=
 =?utf-8?B?MWhzaHcybkVHcXFYR3Yxenh6djNwZDNYOGxFcHJ4akdaQ1Y4UEdKWVZQdWZp?=
 =?utf-8?B?U0wrcERSTCtwWnpSVXFhREZlVDd2Z3J6M0xRRStkVGdMSnNCRzdGSHp2VHN2?=
 =?utf-8?B?TktGUFlSM3JuTkF2b2ZTR1o1Zit1MGxLL0Z4WHlqWi84UTQzS0g2RmJDcVVp?=
 =?utf-8?B?b3hHcGtrYUdwdGN5OTJRU1BiMW1ic1FobmxXUENmQXo3RlR0cmNnSmY4RXBI?=
 =?utf-8?B?M2hUVkJaS00zSTlDR1ZONks5MnZLaWtkbmo4akRnOVlZN0Nld2FTVlk5MWZM?=
 =?utf-8?B?TnhXSzh4UDg5bTZPL3lmQ1FTUWgrSVFLVVBJOWFNMkZ0dVAvNjEzSDVQaWM2?=
 =?utf-8?B?YmFtRTFKQlljTVp6YTFjYTZxSHcxOE5TSzgya3M5Vk9TNkUwMm9kZW8xZlJJ?=
 =?utf-8?B?cnRzS2Y5cWIxT2lha1pOeWkrWDVxU3ZFSHFYMk9jTUJ4UkIwbUw0ZENDN2Jt?=
 =?utf-8?B?YW1SMlYzWUltbnptSno5TGFLZzRSaU0zRDJlODdXM01seWRZTFIreE9PMlVQ?=
 =?utf-8?B?aU5OOGFUTEFUMzA2dzllanpPWkc5bEJZUFdHQ0RaTGFPcWtyZmRnbVV1VkIr?=
 =?utf-8?B?WHhraVZmaFMxWjNRVDhWSDRIeDV2SDZaL0YybDJRMVBNZXJ5OEhVTFlxNDFG?=
 =?utf-8?B?M2YrZllRb3JlYlNya2xuT0tTMUlnV3M2c3JZY3FYeEEreVJmU2Q0eEdpa0NN?=
 =?utf-8?B?bnhKcUNaMzZTZG1QS2RQS05wNzU5SUdQcFJhcXFjRmsva2pNamY4SGJlbWlw?=
 =?utf-8?B?NS92N0czSVo5QTkrU0loWmpzQUxmMkUrVFhxZVdYekh6N1pHNzkyTStmUEpv?=
 =?utf-8?B?MFdxVkZzMDBXdlNOR1VuUnI5bHRReENkbGFPVjlVMXJHZC8wZXptV2tiSDJT?=
 =?utf-8?B?WWlYbWVza3MyOEl2L1pCR3UxTURBSnB3UWhxbFN5WlE5aldYTzJkTCsxYUpK?=
 =?utf-8?B?Tzl2N3V6UUdDSEpvblFFNTd5Z2RFdWdJY3RCRHhKcmpEWUp2aFgvMkkzbzdo?=
 =?utf-8?B?eWpqa0U3MVd0Mmtibmw0M0JRdTd3Wmh5a3JTRUlYbjh5Rm4xeVliVk9TNjND?=
 =?utf-8?B?Y252dnBpb2VKV0svTDNkRCtIaDdVY3FoN3BIckU1bUJhdDJMUlNVS1Q1bEhO?=
 =?utf-8?B?MnI0dy9wWENQeHpXOXIzdWRFSTQzNFh1dmhsY3NRaVJaNmVvZFpyc00ydnZG?=
 =?utf-8?B?N05mWTd4SGVYUjJZQ0NGaXEwdmtpN0UycEltVnlHdW0xWlEvbHNzdFNYcWhZ?=
 =?utf-8?B?WklWRmNrU1pFYlhma3plajAzOFhORzhqenAvZDg1blhrcmNyOC9yMU1LTzQz?=
 =?utf-8?B?SlhVd2UzSml4bkxpT05PelNsWUVMNEkyS2RScTZGVDByUzhZTEtVQlozNjhI?=
 =?utf-8?B?T1JaNWVWcEswdWxnbDBvb0NRWHlXODFIc21KbmQwR1BhL0N3NTB6RlQyYmhV?=
 =?utf-8?B?NFhpOE95a0tPUCtvMTVKMFpwUFBPRU9LQzhpVGIyN1p6ZGNZUnJNbkZYdkpU?=
 =?utf-8?B?Qy95UXA2bWY0UktITzlOZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHY5ZjdqdE5DNjE4eEdTTzErQllGSUY2dUJIZEdWbW0rSlJKT3FwWjJ0STI4?=
 =?utf-8?B?ZmpVSnF5YjRJMjVnM3VTNHY1Y0JhcEwzT0daRWxza29zODdtN2haTUEwalFK?=
 =?utf-8?B?Q0FhMFRSMUNxYlh4Yk1jdEhtcEphOTRCQW9uekNNdkgxWnJLUjJZVmtCbHIw?=
 =?utf-8?B?NjRFZVM3LzVic1hEV3owWGtCUVBWY1ZzdHhDSFl3VXQyOEJnbkw4MDY4WXBU?=
 =?utf-8?B?NUxzWTk5ZUhqeG9LU3duNVVLMFFpU2dyQlRkU2tRWnZFWDBCTW16YkRWbUR2?=
 =?utf-8?B?a3FXanlpS3BTYUpHNXlib3I0dVZzM2k4emlLeGlrSVh1NTNIemZuR1N6bnUw?=
 =?utf-8?B?SzhVdUdjRzBna2hiOEUxSUwzM1g5aDRVTXJ4allhc2NiNnBnUnE5cVBZWlRG?=
 =?utf-8?B?b1UxQ21kc1paRnQxYTNYU2s1RktVQ1hDNW82eFJBUVpYR2xuZllFbWpWVEk0?=
 =?utf-8?B?aDdjK1k4cFhicjYvTXFxY05ORGswUzdGeHJsa3B2L3ZMSU1KQlJ3djZ0Rm5S?=
 =?utf-8?B?ckYwTi91M2xpQlErQWEwbjZCSnJieUh0YW5KNDhEMGk2bGREV2NyUCtvSWpD?=
 =?utf-8?B?K1BPSFNYYk90S0NyVzgzTXV4dlNQci8veTJlV0UySnNIRit5ZDZCSHA3dngz?=
 =?utf-8?B?ZldQU1ArdUdaVVgwQitVUHJJdTNtMStVMlNQQ0dWdS9HZ1AySDBxcUlickJR?=
 =?utf-8?B?ZHhmYm5NSkh6SkdxaUhBVVVaTDZsRVVZckdtWVpvUGtmTW1UOTE1V2NNRnpt?=
 =?utf-8?B?SFlmQVlhR2sydmlKSVBhV2hraGsySy9jU0JGaE81S241ZUVHc2xhRVpSRktH?=
 =?utf-8?B?Q29LdHpDY2k2L0E2T0JPUjdyV3VhLzJuRkNxdW9wZFhTUXBkTE54SFFpVHky?=
 =?utf-8?B?WERka0hpS2F3NWZkeDJ0WlJiSktPMnJ2UUh3UkZYdmw2OUZoTytQazQ4TFB3?=
 =?utf-8?B?K0dKUVduYTFLSXUxMlM1QkR2YmJvQm11dlZNL0lhVCtjM0JIQy9mMDFSMGth?=
 =?utf-8?B?bnZGMHlReUhBK2prN0xCa1MzL1ozdHlYOEdiWU5GZ3h5MTZobVNTNnc2VmZK?=
 =?utf-8?B?NWdSejE0Q3ptdVFuSy9rZ2RRZEdNR280V1libE5lM1NrOGNJTjQ5L2ZOb1ZO?=
 =?utf-8?B?V0FGUVhLbkM3T0x2V3d2NW5WQ21JTStPa0ZtSXg0RmhOZ3NVc1ZRVTRqZENE?=
 =?utf-8?B?Slc1TEREMjJlMk9RT3kxNFdaMFkweUF3L3N2V2tySVpHRWVaWjU4WWlpbnpB?=
 =?utf-8?B?M0pPdE8yS1d1a0hDT09KSEE0L1cwVDVoU2YxYVlXclFVcVVtYXB4akVPOWZD?=
 =?utf-8?B?MlZRMDNXV1cxbnJST1FRYnRyNFlHUlhlKzZ6VkxuUDV4ejg5bkRZREUybFpU?=
 =?utf-8?B?RVZNSm9ZTVMwQUlnWEhvekJhU09OVUtGejhJSHJSN1JpeWRtOHdNNXRzSkFu?=
 =?utf-8?B?ZFhGRXdjZ2pFSFYxK3ZQaXBOWno3eXFkVjBGNkZBcUEwOSswZlM5K3Ftd3VB?=
 =?utf-8?B?aEVyUGZTblg3S3JBWXhMN3AwYmEyZC9sTk94cEcrQW05L2tHQWp3QXRyRUxw?=
 =?utf-8?B?VjlXdGl3WFZFdzV0QU5UOWMwdDhDZUNsaDJsc3hPNitNY1VYb1pqelhTVHJt?=
 =?utf-8?B?cENpUHJ6bEM5eXNTU3ZhK3l6Wm5yYmo0UitjR3d2TC9ucitmMlgrN3dsSjcw?=
 =?utf-8?B?R2hVM09ZMlRTUjBWMUtGLzJSYTk1Um42bDIzc3U3UDhOUk9lcStSbXR4QVJa?=
 =?utf-8?B?ME9rV0NRVDh1QTRVMkY2MDlaNC9wUzgwTUVyVDEyMDNtSS81T01FU0FvOGph?=
 =?utf-8?B?eGUzcFpVajlJcTFFWWI2OWRzcHcraFlDMmFhbzl3OUlYUGM1RTg3WDRCQXdh?=
 =?utf-8?B?R3lvN3d2R1lleVFRYTlZU1J5aFBxeDZXWnZvd2tvQU9acndvanlmc1FJVXYy?=
 =?utf-8?B?d1JxSXR0d3BFVFJFTWZOdFpmN0pFckNCOEIvWHdIZnZsZkJMb29uamxhUDBh?=
 =?utf-8?B?YkhNVDZETEFTQU5rMm9jOUVCQWYvS0l4d1RSWjdqR1NtMTBlN044aWFJb0F3?=
 =?utf-8?B?QXR0RmthRkJWTjYydTQzMGVmMmpMVmdzWU1xMjZEeFcyMW00UEx6VXV1TVNu?=
 =?utf-8?Q?neFHPHmZ8ue1LYMhP1rsBX/83?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07493eeb-f72e-4e7f-2c09-08dd141a6154
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 04:16:09.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l24nUeIxhOTpRvfRIB8LPPkRNYE3zfYzRhKcX0T55k0dUoIcEhoX9tF2PqRGH41QoQHpbxULiNDfXjzV25koKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-OriginatorOrg: intel.com

Hi, Babu,

On 10/29/24 16:21, Babu Moger wrote:
> Assign/unassign counters on resctrl group creation/deletion. Two counters
> are required per group, one for MBM total event and one for MBM local
> event.
> 
> There are a limited number of counters available for assignment. If these
> counters are exhausted, the kernel will display the error message: "Out of
> MBM assignable counters". However, it is not necessary to fail the
> creation of a group due to assignment failures. Users have the flexibility
> to modify the assignments at a later time.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v9: Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to return void.
>      Updated couple of rdtgroup_unassign_cntrs() calls properly.
>      Updated function comments.
> 
> v8: Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
>      Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
>      Fixed the problem with unassigning the child MON groups of CTRL_MON group.
> 
> v7: Reworded the commit message.
>      Removed the reference of ABMC with mbm_cntr_assign.
>      Renamed the function rdtgroup_assign_cntrs to rdtgroup_assign_grp.
> 
> v6: Removed the redundant comments on all the calls of
>      rdtgroup_assign_cntrs. Updated the commit message.
>      Dropped printing error message on every call of rdtgroup_assign_cntrs.
> 
> v5: Removed the code to enable/disable ABMC during the mount.
>      That will be another patch.
>      Added arch callers to get the arch specific data.
>      Renamed fuctions to match the other abmc function.
>      Added code comments for assignment failures.
> 
> v4: Few name changes based on the upstream discussion.
>      Commit message update.
> 
> v3: This is a new patch. Patch addresses the upstream comment to enable
>      ABMC feature by default if the feature is available.
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++++++-
>   1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b0cce3dfd062..a8d21b0b2054 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2932,6 +2932,46 @@ static void schemata_list_destroy(void)
>   	}
>   }
>   
> +/*
> + * Called when a new group is created. If "mbm_cntr_assign" mode is enabled,
> + * counters are automatically assigned. Each group can accommodate two counters:
> + * one for the total event and one for the local event. Assignments may fail
> + * due to the limited number of counters. However, it is not necessary to fail
> + * the group creation and thus no failure is returned. Users have the option
> + * to modify the counter assignments after the group has been created.
> + */
> +static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return;
> +
> +	if (is_mbm_total_enabled())
> +		rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);

In this code path,
resctrl_mkdir()->resctrl_mkdir_ctrl_mon()->rdtgroup_assign_cntrs()->rdtgroup_assign_cntr_event()

CPUs are not protected by read lock while rdtgroup_assign_cntr_event() 
walks r->mon_domains and run assing counters code on CPUs in the 
domains. Without CPU protection, r->mon_domains may race with CPU hotplug.

In another patch (i.e. rdt_get_tree()), rdtgroup_assign_cntrs() is 
protected by cpus_read_lock()/unlock().

So maybe define two helpers:

// Called when caller takes cpus_read_lock()
rdtgroup_assign_cntrs_locked()
{
	lockdep_assert_cpus_held();

	then the current rdtgroup_assign_cntrs() code
}

// Called when caller doesn't take cpus_read_lock()
rdtgroup_assign_cntrs()
{
	cpus_read_lock();
	rdtgroup_assign_cntrs_locked();
	cpus_read_unlock();
}

> +
> +	if (is_mbm_local_enabled())
> +		rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> +}
> +
> +/*
> + * Called when a group is deleted. Counters are unassigned if it was in
> + * assigned state.
> + */
> +static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return;
> +
> +	if (is_mbm_total_enabled())
> +		rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (is_mbm_local_enabled())
> +		rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> +}
> +

Seems rdtgroup_unassign_cntrs() is always protected by 
cpus_read_lock()/unlock(). So it's good.

>   static int rdt_get_tree(struct fs_context *fc)
>   {
>   	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> @@ -2991,6 +3031,8 @@ static int rdt_get_tree(struct fs_context *fc)
>   		if (ret < 0)
>   			goto out_mongrp;
>   		rdtgroup_default.mon.mon_data_kn = kn_mondata;
> +
> +		rdtgroup_assign_cntrs(&rdtgroup_default);

In this case, cpus_read_lock() was called earlier. Change to 
rdtgroup_assign_cntrs_locked().

>   	}
>   
>   	ret = rdt_pseudo_lock_init();
> @@ -3021,8 +3063,10 @@ static int rdt_get_tree(struct fs_context *fc)
>   out_psl:
>   	rdt_pseudo_lock_release();
>   out_mondata:
> -	if (resctrl_arch_mon_capable())
> +	if (resctrl_arch_mon_capable()) {
> +		rdtgroup_unassign_cntrs(&rdtgroup_default);
>   		kernfs_remove(kn_mondata);
> +	}
>   out_mongrp:
>   	if (resctrl_arch_mon_capable())
>   		kernfs_remove(kn_mongrp);
> @@ -3201,6 +3245,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>   
>   	head = &rdtgrp->mon.crdtgrp_list;
>   	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> +		rdtgroup_unassign_cntrs(sentry);
>   		free_rmid(sentry->closid, sentry->mon.rmid);
>   		list_del(&sentry->mon.crdtgrp_list);
>   
> @@ -3241,6 +3286,8 @@ static void rmdir_all_sub(void)
>   		cpumask_or(&rdtgroup_default.cpu_mask,
>   			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>   
> +		rdtgroup_unassign_cntrs(rdtgrp);
> +
>   		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   		kernfs_remove(rdtgrp->kn);
> @@ -3272,6 +3319,7 @@ static void rdt_kill_sb(struct super_block *sb)
>   	for_each_alloc_capable_rdt_resource(r)
>   		reset_all_ctrls(r);
>   	rmdir_all_sub();
> +	rdtgroup_unassign_cntrs(&rdtgroup_default);
>   	rdt_pseudo_lock_release();
>   	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>   	schemata_list_destroy();
> @@ -3280,6 +3328,7 @@ static void rdt_kill_sb(struct super_block *sb)
>   		resctrl_arch_disable_alloc();
>   	if (resctrl_arch_mon_capable())
>   		resctrl_arch_disable_mon();
> +

Unnecessary change.

>   	resctrl_mounted = false;
>   	kernfs_kill_sb(sb);
>   	mutex_unlock(&rdtgroup_mutex);
> @@ -3871,6 +3920,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>   		goto out_unlock;
>   	}
>   
> +	rdtgroup_assign_cntrs(rdtgrp);
> + >   	kernfs_activate(rdtgrp->kn);
>   
>   	/*
> @@ -3915,6 +3966,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>   	if (ret)
>   		goto out_closid_free;
>   
> +	rdtgroup_assign_cntrs(rdtgrp);
> +
>   	kernfs_activate(rdtgrp->kn);
>   
>   	ret = rdtgroup_init_alloc(rdtgrp);
> @@ -3940,6 +3993,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>   out_del_list:
>   	list_del(&rdtgrp->rdtgroup_list);
>   out_rmid_free:
> +	rdtgroup_unassign_cntrs(rdtgrp);
>   	mkdir_rdt_prepare_rmid_free(rdtgrp);
>   out_closid_free:
>   	closid_free(closid);
> @@ -4010,6 +4064,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	update_closid_rmid(tmpmask, NULL);
>   
>   	rdtgrp->flags = RDT_DELETED;
> +
> +	rdtgroup_unassign_cntrs(rdtgrp);
> +
>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   	/*
> @@ -4056,6 +4113,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>   	update_closid_rmid(tmpmask, NULL);
>   
> +	rdtgroup_unassign_cntrs(rdtgrp);
> +
>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   	closid_free(rdtgrp->closid);
>   

Thanks.

-Fenghua


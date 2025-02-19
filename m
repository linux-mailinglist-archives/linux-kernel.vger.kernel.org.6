Return-Path: <linux-kernel+bounces-522198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA65A3C74B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1D71781A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C67A214A90;
	Wed, 19 Feb 2025 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cu2glva8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D47214A66;
	Wed, 19 Feb 2025 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989290; cv=fail; b=Wkfkh/phEJ6Fzfex/7qmkC6z0Jk18xai4zkF6sOIrJ3XBeYmCmvnC0+9HNdu4ne3/mOZMRDiatdiVUrmMOLzdfdNNqQDu5cAkZMlF4dUXtLqAi1g4e2htwaafXkB8qqUGwgKXp58QPVLfGbK9q92luj8ZubfIbMvE1FaIWsJkQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989290; c=relaxed/simple;
	bh=JnON2mQO5InamLnOeFEZtSNOjyC+1XeG8RyqvkVrLKE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPGawLR71pm3DEG71OGBSeeC61Xz8+vNWQAPbL75JcYet8kDsWbHOI4YRbPL/z3UBRLyb10792Aq62e4swOqmRdpohMsknEDjcBBujBLej1dr1uLStjlId4MeYbeGT8w9rpQ45mV6MJU/MVa9Y5dN1EXIRkx7iNGRaH394NqJtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cu2glva8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739989289; x=1771525289;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JnON2mQO5InamLnOeFEZtSNOjyC+1XeG8RyqvkVrLKE=;
  b=cu2glva86HWOVoIvMO3vSB2xxdA3FcX1pIYyaun8sA4UelznUQGYYL6h
   NWRqZNkB6eDOcfLL2xWM0hYkf9wC/OpFIZwpZ7BQjtCG9XbdtLlk7VZxY
   eNU9umEhUh2q/9hcAku3zGB+Vz4YFrJg9FeLnvOg4U6J4yinEmadLVX8v
   8OvAq8l8CROTeFj5QW8CAgazrML0736QgdoEu3MxtVX+vlzWf3lLTRIY+
   pHDj9kpVIxzlO1s1e8fcEO71prilvx5aXRx+EZUQJL0NMZTKb+Znv6+9i
   E5sbk7lZ5me0j+HupsNEBnmZZMTo5qw5+2J+e2YqkwNJR9AYpmrl9o06E
   w==;
X-CSE-ConnectionGUID: PhZpKMAuTHqQu3dEWAdAPg==
X-CSE-MsgGUID: 97Xg63EhTuGZ7YGzjlcdnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40455432"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40455432"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:21:28 -0800
X-CSE-ConnectionGUID: 7sS+f5ZRRQmVoelhxBKp6Q==
X-CSE-MsgGUID: ohmnjxQJRZC+AKq2op1amw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114530847"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 09:56:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 09:56:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 09:56:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 09:56:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eogUpMH7eKIMCXqZ6IjRXMaGGL6MZSoAF+6NFtk8UGk+Q4OAVolBWvLcdutCpaYA2/AYifgwNcJdrxjBuj+XbcKTPYODpYPvPtkTJS37lZEO59YAxmJkasJA6o+WvH45g2RBLj7d4wpTbuwPl2qfiu7897Sigdwf7PJE8xSRcNDqEwnTZrGS5lrp0NOMjhj9B4lNizJ9wYoZ6fLFzeP4i0kinpuAmaSQQN+JFNLue32pzIH04/4Qr7H7sOBD2SR7rLckbm5VXPmnEPwgz8rcf4OXCu91YQeShXNO65R3cWj4l7VOqfgvBj4q0FJ1xCRd/QGsVkkmY3rc/1j4eMMqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q+KvwQDOimZEkpIxYPKC0tLtdsmJfXL6Nc6ETMjnSU=;
 b=G7GzWWBaZO8PMWNrLYJbMqHltWlsIW2P1k9prRUene7Es1xESQamUhoXgW71aV9GeW9HIm9w7NcqiUx3/nn28BvYpfYHfhMBdowv4AXT+idsac+cNQHL6tRShRpyfh4amWtRfNJARBRJxmK4hZPfzls5VVT3vI1yR+9ewsY1oEor6navzFN04oh/626y94glHQ4/nGq8wKOZ1P8TR/A4GRXSP557cLAq6JqbVntlnAOw2dhWLXydnqbpIkSxM4DtXp6uP3ZMGNznrv3iIfcT+Mr0IVqwv3rSxNtjWPIjQZrjckylgiQ/C7xg+8kENcPILsyIKnSsKdmoIBc9Cv03Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by DS7PR11MB7689.namprd11.prod.outlook.com (2603:10b6:8:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 17:56:34 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 17:56:34 +0000
Message-ID: <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
Date: Wed, 19 Feb 2025 09:56:29 -0800
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
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:303:8c::20) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|DS7PR11MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: a82af8ed-ac49-4b13-62f7-08dd510ebf64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXlibmwwZktrdHVsNVNGY2JRcGo4L1BTemhjWkwrZm1qQjJ2VklSRW00NjU3?=
 =?utf-8?B?UUNYTmpWeVo1SkdBQXdnOUhUQmFZTDlrODFyNHgyWFdWaytBZGZBRUU3eWFE?=
 =?utf-8?B?ZkFta0tFYTlrT1doSDVOU0dEWmhMTUU1Qm04RFNlT0xXSzdSd2ZuSTh3bmtn?=
 =?utf-8?B?SXk0ZnoydXIyOURRNlVxdlZWVnVEOXlzNS85bTNKdGF3THd3akxRR0UyYm1x?=
 =?utf-8?B?NUdUQkc4UGRkaUNkUno3RTU0YWpGRWc1YlUzdmRRaXFRV2lrRGo4aWdyZU41?=
 =?utf-8?B?MU91QXJGT3lNQ1k3RC9FbHF2UjQrOWFyWG1KRjRaQ2cvdzNaKy9ySjkvSFc1?=
 =?utf-8?B?ckdUOVhtUFpidjMzL28wT095NklsOUZ4ME9WU2ZjRXNXZnhpVEJadEN3RThn?=
 =?utf-8?B?ZVZaVEthNXBKRWZkTUJIR2RsSC9YUEx4UytNV0ZwNmtJbHZqUG42cCt6M2xh?=
 =?utf-8?B?TlhnNTE3clBjWVlhT3JocTk4TmYvbFB6eDg5ZVkzeFN2Z1pENGRpY2R1TU1o?=
 =?utf-8?B?TUF5S0RyOXV5VUY5cTl0WVd2NmRRSGszYm9XcDNhSHBTb1NlRG8wTU54TFJ5?=
 =?utf-8?B?Kzdob0NBbmplMWRwcGpOQm5adHcwQkM1ekVqTXY0NVpZZmwrTlYwZkM4a3lL?=
 =?utf-8?B?RXdqYkFJa0lhWnlNTklUT2lwQWNWeXExL3JjV1B4a0laOHlmK28xQVdrempM?=
 =?utf-8?B?c3NmMGl2SytZVkROcE1EUDhjYnA2c1NUQTQ5LzlhZ2hrczJIYy9Yejh5SDNL?=
 =?utf-8?B?UHJZb3M0b0VZRUEvSlBPVlRVNXRIQ3hOY2l3TG1hR3U3RU03UWVpTWkzMHRI?=
 =?utf-8?B?K29SNGdWNyt0WElsQ3U1Tm1zeWJQRTZ3OXUveEtGVDFzd0xnUmxNcGFTWW9R?=
 =?utf-8?B?UmdqMEg2aUo2KzI4KzVQN0V3ZkJwQnBhaVZKaDBPRjc4RDJvd0dNMkdRNC9D?=
 =?utf-8?B?SnoxTW9tbUJSaW01aHJzcStBNXk2bEpmZmJieFpGTTBmMlVVcW9BTUc3QXV0?=
 =?utf-8?B?WGkzS1ZuK09zOGVzVlhXNXpwd2FtTXlmTi91Wmp0WFBOamxPZUxVVU5lc3hQ?=
 =?utf-8?B?aDUrMktOUnV2KzlQNzAvSDZIa2N2VVdQN3lRVTRFd0pPR1pqbzRPd2NuYUps?=
 =?utf-8?B?blRELzNmakJRazE5QkEwdE9JL0pzNkFkWFFsdXFXN01SbDVEVHpucngwSVF5?=
 =?utf-8?B?dXljeXY1VjFxT1FWSFhFK1p5QVlpcGdoVU53R2NLL2ZUb3RzOXBMcTdiY0Fa?=
 =?utf-8?B?ajUxam93V0xIN2RTNVdWRjJuL0ZFVjVGZmh1eS9LMHl2d2Y3MFBNdUVTcERm?=
 =?utf-8?B?NUsrZCtwWDZzaXk1aEhKakVYdHl5YmZkZUdRek1xMXlLU01jTW5lMm5Jb1pH?=
 =?utf-8?B?VVVUWjJyeTVKdzVlOHphbVI2d3IxdnMvYjRGVjJ5SmJueUNJOWdISldTZVM0?=
 =?utf-8?B?R1ZKNlM5aXpmVnM0RVBxcStLWnY2MGRqWGd2R3pNUDUvUHlLNVFjcEJpamR6?=
 =?utf-8?B?RWV0eEtBaUZtYmtES0RUbURtOUYrVTh1cXI3anZwUzNuL3ZocUpFV3BGayt0?=
 =?utf-8?B?Qm1VeTJhWUt1SUFpQzdJMVovK050TW4xWExvcHVoRGdsWVJHbDlSY2JUTHJr?=
 =?utf-8?B?ZERqQkpoR09ham0vQm5oLzh1YzBNZnp2Zjh5WExjWEJTUit6ZkNScDgrMGIy?=
 =?utf-8?B?OEVZcHhxRkRLNkUwVFhJeFdvM3lseU5HMTM1S1ZNUnEvdXcvbVRDOHRpZ3NC?=
 =?utf-8?B?VkJWRlhiaVVBQ3lKV2NiYWo1bmRsUUN0MDJTWHlvN21uS1c4RDBoT1Jsc0Yw?=
 =?utf-8?B?c1RpQmZZWjFQUmhRMEF3emFZb01rRktrblJRWkdTWUZtV1B1Yk43b1lOU1U5?=
 =?utf-8?B?UGdxVjZ0MW5pQUNwR2wzdE1xRXA3SUhQa3RJMUFyY1hiNXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzlWV3NSWFRkNGppaTFzT0VsOXp2dlQvemtLZnR2Uy9PWU1YdFpMdWplbnpY?=
 =?utf-8?B?VE5Jc21wS1FreDJScjhLNHlNTFBOcVMzbzJsVkg5R3ZIRU9QT25IM2lrQmUw?=
 =?utf-8?B?d3hJMVBaSmNaN0U4L1p5dkZHeStQam41L0hZY3BPZ0djeVk5SXJETDE4aFBk?=
 =?utf-8?B?M0NTbWpPelZJYncwc3psSng0TnBodTlNODdndDJBVmdsL0xwTmQxWlkxZFVT?=
 =?utf-8?B?dTVXNUx3K2x2ZXFwMExpRTNrQUFTZmhYRDdtZ0k1UkI2RjZFN28rNEZ1SDV1?=
 =?utf-8?B?K21yVkxEVFVnZGlmUnp4ZXlETG1qb3pFY1ZMcTB2Q2xSSjJhNGVDdFpqb0FH?=
 =?utf-8?B?QVlaRmR0eXRGaEk3c3ZsTUxtNnc4TmRFK0JHQ2xCVTIvWGI0MkpDUnN2MkFl?=
 =?utf-8?B?dlhqbFA4dkZybDE2YSs0cUwyVWppbkhrLzFoOWlVLzltVTgzallkbUpKNHpq?=
 =?utf-8?B?V0dHWTJqby9oY1R5QlNseXVBSlA0aXArRXpzcWppUUlQbDdCL3RONkE0RUZ4?=
 =?utf-8?B?WXFlQVBsT2dGdlFJb1owamZxTnQ4VzlCc1ZMeEV3UmpwMnpwYjVqaDVaYU91?=
 =?utf-8?B?akN1QVhBc3J1ZDNXM0R4clB5Ym1iSlNFUTdHZDBQYmRSWWI5eDBmcStPMHJJ?=
 =?utf-8?B?blBoTk85MUNKRWwvTThSN2RqcEpNYzFqSFBSdEs3SzV3dm9GTTMxT1o2OThZ?=
 =?utf-8?B?bXoySUVMM2k1NHg0TDlUaGY1ZWFlWkFSWE0zM1Y0SGpkVWVhVnpqZm56N3FS?=
 =?utf-8?B?d3VaaHZtT2tHazBLSnBJek53QWVCVDRZcTZzRlAxaWxaZlY0Z2Q2MEs2WDl6?=
 =?utf-8?B?NGlpZXAwZm41ck5CeUhwa2VEUXlZUWVPVkJCM2ZMQk1oVHVjYlJ3RmlrK0d0?=
 =?utf-8?B?V3Z5bDVZREUyNHdWbGtsQ2wzZm04UWcyU2ZDZGUyR1B1M3lHNEVQUHpYL0o1?=
 =?utf-8?B?alNEb1BLeUhDbnpOcC82U0VZRXl1MCt6ZWNXMU5kejk3dWRib05NcGpBNHpw?=
 =?utf-8?B?ZmxTY0dZNm9uZ0RZRWpYMzRJZmI4WjA0V1RwUTQrTnR6K0Fqb0VzeGo2ZDFx?=
 =?utf-8?B?bEc3ekxDeXlTK0x6MUtqcEhXL1NPVEZVR3dzQUFPeTc0TWsxYnRVb2UwdkZh?=
 =?utf-8?B?OUhueFp3RnBrNnRjaXMveUYrMHgzNE9FRFlrbkNZNHJvYTgzRFV5VzYwMkU2?=
 =?utf-8?B?WEgwWWlQUnlrV0NzTE5jU2xlMmZzNlF2S1ZPL0RhL1o3bUpyMmV6K3lGNWRL?=
 =?utf-8?B?SmtxckZib0dZVjd5SVlraUlMSERWZFpiek10NXFpWnVnL2pJQ3lOb2J1QmFE?=
 =?utf-8?B?N3dGS2VQNm9Vc0JORTVFdGpKTHBtQ0VnRDBVdDRzQnhna3pKZGpQS2ZkV1ZO?=
 =?utf-8?B?K294UEZ2eGllZmtYV0E3cXdZY25ZVzZZRVlQNXFDdHJrdDFpT3ZXdG9EaS9t?=
 =?utf-8?B?L3FkQnI5OXRZRjFubzYvL0xoeDVwcjZDbmxQNjVJNDI3NTNsNW42WkNiSnlw?=
 =?utf-8?B?L1h0OHVSbW5pYkJyclBqOE53T1VOcldoTE81WWF4Qndvdk9mc2kxUDZ0RzQy?=
 =?utf-8?B?UlRaaFlVSTNCdGQ1d1VOODhVblBtbnRXZlhvSk8zRnFnU0l0SEUyNUxVY0NE?=
 =?utf-8?B?MFhuWGVVSHh5NHI1Y3E1OTU1N2xRdllIYzJoRVU1M1BiRXhJeHdkN1BTTzBk?=
 =?utf-8?B?UXZ4dmJpZ2htOUtJRTg4Z0xNUGlVOUZnaktNZjJ5T1loc1RWdHFuWmZxRjAr?=
 =?utf-8?B?M3NiUTVTUUp1RXZnNjhscVlhSWlqamN4aGVSTGxSMm1uMmhLNFJab3NjZCti?=
 =?utf-8?B?SkJpakRvWmZGZ3lRaU4yRHFLYkxNdjFrTURMclNWdkdKNllBTjdSNDhia2hv?=
 =?utf-8?B?eVlmbTJEUlQrR3lRMVoxc2Vxa1M4b09HbWxOdXVmUTJualVIVStjZWdVK3Uv?=
 =?utf-8?B?M2tJbG9wSlJxekJKTExFZ0V6ajJYLzB1MjdqLzlXdDJPdTVWQTQvZzlTMWEv?=
 =?utf-8?B?Mi94Y3JVNG0rVzZOQTQ1c2trdkNNRXZZYUpBcThlSUFUOURpZVh1dGJnank0?=
 =?utf-8?B?Y1pvR3dLQTRtdlRwd001WlA2WFNXQlRGSU1ZQW9aRTdKMVBNMTMzUmdHdjJx?=
 =?utf-8?B?VmJTWnNLcEFCSHBPVVNsbEJqSFVSeWMxMWxEdDg2RG11eGpvbHdETnJqODdu?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a82af8ed-ac49-4b13-62f7-08dd510ebf64
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:56:34.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujKEvDQvvc3qg5vewLTVKJRRrAVIfIEv1RXo8Jbqz3GZAR5r1fD1L9BpZK8nHf4Q50wCQfaJjgVcvzpuFzwWK0FRsHCIWp/GzrQOATBJ3vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7689
X-OriginatorOrg: intel.com

Hi Peter,

On 2/19/25 3:28 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter,
>>
>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>> Hi Reinette,
>>>
>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>>
>>>> Hi Babu,
>>>>
>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>
>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>
>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>
>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>
>>>>>>>> mbm_local_read_bytes a
>>>>>>>> mbm_local_write_bytes b
>>>>>>>>
>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>> <value>
>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>
>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>
>>>> As mentioned above, one possible issue with existing interface is that
>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>> is low enough to be of concern.
>>>
>>> The events which can be monitored by a single counter on ABMC and MPAM
>>> so far are combinable, so 26 counters per group today means it limits
>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>> investigation, I would question whether they know what they're looking
>>> for.
>>
>> The key here is "so far" as well as the focus on MBM only.
>>
>> It is impossible for me to predict what we will see in a couple of years
>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>> to support their users. Just looking at the Intel RDT spec the event register
>> has space for 32 events for each "CPU agent" resource. That does not take into
>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>> that he is working on patches [1] that will add new events and shared the idea
>> that we may be trending to support "perf" like events associated with RMID. I
>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>> customers.
>> This all makes me think that resctrl should be ready to support more events than 26.
> 
> I was thinking of the letters as representing a reusable, user-defined
> event-set for applying to a single counter rather than as individual
> events, since MPAM and ABMC allow us to choose the set of events each
> one counts. Wherever we define the letters, we could use more symbolic
> event names.

Thank you for clarifying.

> 
> In the letters as events model, choosing the events assigned to a
> group wouldn't be enough information, since we would want to control
> which events should share a counter and which should be counted by
> separate counters. I think the amount of information that would need
> to be encoded into mbm_assign_control to represent the level of
> configurability supported by hardware would quickly get out of hand.
> 
> Maybe as an example, one counter for all reads, one counter for all
> writes in ABMC would look like...
> 
> (L3_QOS_ABMC_CFG.BwType field names below)
> 
> (per domain)
> group 0:
>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>  counter 1: VictimBW,LclNTWr,RmtNTWr
> group 1:
>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>  counter 3: VictimBW,LclNTWr,RmtNTWr
> ...
> 

I think this may also be what Dave was heading towards in [2] but in that
example and above the counter configuration appears to be global. You do mention
"configurability supported by hardware" so I wonder if per-domain counter
configuration is a requirement?

Until now I viewed counter configuration separate from counter assignment,
similar to how AMD's counters can be configured via mbm_total_bytes_config and
mbm_local_bytes_config before they are assigned. That is still per-domain
counter configuration though, not per-counter.

> I assume packing all of this info for a group's desired counter
> configuration into a single line (with 32 domains per line on many
> dual-socket AMD configurations I see) would be difficult to look at,
> even if we could settle on a single letter to represent each
> universally.
> 
>>
>> My goal is for resctrl to have a user interface that can as much as possible
>> be ready for whatever may be required from it years down the line. Of course,
>> I may be wrong and resctrl would never need to support more than 26 events per
>> resource (*). The risk is that resctrl *may* need to support more than 26 events
>> and how could resctrl support that?
>>
>> What is the risk of supporting more than 26 events? As I highlighted earlier
>> the interface I used as demonstration may become unwieldy to parse on a system
>> with many domains that supports many events. This is a concern for me. Any suggestions
>> will be appreciated, especially from you since I know that you are very familiar with
>> issues related to large scale use of resctrl interfaces.
> 
> It's mainly just the unwieldiness of all the information in one file.
> It's already at the limit of what I can visually look through.

I agree.

> 
> I believe that shared assignments will take care of all the
> high-frequency and performance-intensive batch configuration updates I
> was originally concerned about, so I no longer see much benefit in
> finding ways to textually encode all this information in a single file
> when it would be more manageable to distribute it around the
> filesystem hierarchy.

This is significant. The motivation for the single file was to support
the "high-frequency and performance-intensive" usage. Would "shared assignments"
not also depend on the same files that, if distributed, will require many
filesystem operations? 
Having the files distributed will be significantly simpler while also
avoiding the file size issue that Dave Martin exposed. 

Reinette

>> [1] https://lore.kernel.org/lkml/SJ1PR11MB6083759CCE59FF2FE931471EFCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com/
>>
>> (*) There is also the scenario where combined between resources there may be
>> more than 26 events supported that will require the same one letter flag to be
>> used for different events of different resources. This may potentially be
>> confusing.

[2] https://lore.kernel.org/lkml/Z6zeXby8ajh0ax6i@e133380.arm.com/


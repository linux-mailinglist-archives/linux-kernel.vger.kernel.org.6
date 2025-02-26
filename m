Return-Path: <linux-kernel+bounces-534420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396B9A466BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E750217BF23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBB1221701;
	Wed, 26 Feb 2025 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5ynUjmQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396C21D5BB;
	Wed, 26 Feb 2025 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587128; cv=fail; b=okEpYuU9dHO2aUMNhx2EwLuzE+gLCYxi3WCvAPSsCcYz+hPMRu1KR2uur8ZvweEJiZbSOSpaQb3TA8JMIlUMUj9WS0hqttCttm/KfDMHItSLO6DzEhehDDCy83OjRMhptIk74BBwf+W4ZAmPS6WxPckLPnEYpjxLoaLXsH+2XYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587128; c=relaxed/simple;
	bh=+zqXy4araAtYC7DxvvbSS2WkZi0bXFavGyHDDk/kYGE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pLLy94NMkfhN7UAepF8AQ6ZXfS7WQ9WRgcIxzw5xS7tYieHUq9Ve9FtGVkw/LbgySCQtWHK3Y2UZfrROy8NHq72eN5nwmA4dWDd3L9KiQuDUffGdNq82C1R9ZK9ZQ7kjXdmJdwe8QCkLBP8rR6/E/GbnxqNLM1m4ywmIUWFSjRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5ynUjmQ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740587127; x=1772123127;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+zqXy4araAtYC7DxvvbSS2WkZi0bXFavGyHDDk/kYGE=;
  b=M5ynUjmQwF/SzbbJGlkhe5+JTIhqVbywA0NnyH91c8vyJktJzbQUV/oc
   fQpNFeSg/VgBDfePU4/ktYVIP2Ni5Vb2cL5BKDe9D2OfJfWPbH1bvixxQ
   NkO4C8bfoq6e1CSAbGeuUQFiB8KPo2vA2Ygq16QsVWAMqrAQQgQrMUr7K
   NBRIr2ZdPCu5jqPehkgz/3CQ9l4/h+yYLxqdtF9q55aMgtCwlcnJRGZMq
   4oEMKdrZU3y9SgHOB2sqhC9vN1QW/OxAULk57sL0FaVydg9+uABrpv9IE
   y2WxXcLfE9RuSTqzDxZogh5X9Jn8fQ9Q9gf7qcCLaeCsmwEWblkhQlybX
   Q==;
X-CSE-ConnectionGUID: ej17wLzESSS4hxeXzx2JAg==
X-CSE-MsgGUID: OW2R7JLGRaW40FNcrpPPkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="66814883"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="66814883"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:25:25 -0800
X-CSE-ConnectionGUID: SgoVBbRDSriRlrWI0k7yQA==
X-CSE-MsgGUID: 6tB56oaES9iBqvh9Mx7wsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121857593"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:25:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 08:25:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 08:25:23 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 08:25:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbRCfTqsojukq2DCW4exL82IoLk5DIKuHM8mj6Gg9fq/bLVK3strYSKkRCiwkD8EtspCbr0dXqasv8RrDuE2harLlQh8piGR/fCBt67qgevrJ54TLuhinMFgM/BPVVLhaGZmWC4S5WqZAHW+KudmHMp7qOK/96wVT/kEAbZXT7cXg09nucs8HEP7XgbsTKio4yzTrE9GGAx5eLfvPo2tewPyJhfD7t1ykPESeUf0uqTrApLU9CK6jq99Od9a4iyAYU8OFKZs5fextbMD1G/hnleBjKv92d3CqxDdtzS7TfvgzF70bi3rz0Y3R7YoV1eEWThxIrGE03onQdxyf7J/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsvSPytL654o+svqtZxRd5m+MjdQDfScGccahU1Y5Gs=;
 b=iBEoCo19PI5oP05vFwh0a1VMTgF9r+smTSmqcqoziv4fVNSHKqA28WskkWrBkBmcBYJB3SC0ysyeG3/vB5443/3w1iNEcEjs23VIxZrB+GA9h+J6HWtLPToO2E9bqm1S66znx1GP2pSieEaORFU4+Ji1fVpPBqvDwekPISoD81BW0HoHnf05pOtxC0BVw7rFiKARc7EAYeUp/aDTCIv33YwqZ+pTso2yNkJkSzZxjCmEQg29Jg8VBalZNPlgJWOwoLNqp0b4gkFVcXc3+2V30w1rtSezKfSK4iJTxFR2DeidVgk7jRFOSQKDHGbd3aYIGBxZto/rKi/B1dzN3YafNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4890.namprd11.prod.outlook.com (2603:10b6:806:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 16:25:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 16:25:20 +0000
Message-ID: <eb62be12-3a1f-4aad-b50f-bf71188ced75@intel.com>
Date: Wed, 26 Feb 2025 08:25:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>, <babu.moger@amd.com>
CC: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <akpm@linux-foundation.org>,
	<thuth@redhat.com>, <rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
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
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
 <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
 <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
 <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:303:8f::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8fd10a-e3b3-4078-92aa-08dd56822970
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjNueXVFUkJKZTFqbjJDd0M2a3hNRUo2MzhpMnRuZTVTaDR1THR6VW9EL3o3?=
 =?utf-8?B?MWxGVVRYMThnZGFBeVphK3hhSmxnaG1iOVErb1JWNS9QakhjUzhYcDhSQkFB?=
 =?utf-8?B?eTAzK2p1UFY3RzAvdkhPSkdvSS9wcnV1Q0dKeHJSSGh4QnpNNUxFWjV4Nnpt?=
 =?utf-8?B?RHZQKzJSL1gxbjNudlNlM3kvN0xSOUVQNlhXSmQva2FYMVlsUHl2anZnUHla?=
 =?utf-8?B?aUo1UC9LS3NuZ3FmODlPbU1tOVFhOHJsM0NPek0yZUdIdnhBSGYySzNEdHF0?=
 =?utf-8?B?NzB2RENod2pRYmlRWnpKL0cwQi9Ua3Ewai9zVGJsQUcxQWJQYTE2UEtKSzl4?=
 =?utf-8?B?azhZN2VtazA2dWZCYm5LNTJueFMwQzFnak1tWHRCNEVCN3B5aTVnS1VHaFNL?=
 =?utf-8?B?YitOalc5ZmNIKzBTUjJGbFkvRk9XaVlwcTRXUlFyaU52cEtlU0tyVnJ5VHpX?=
 =?utf-8?B?VGM5UHhNeXgyQWtZUDlwT2N2aVFmMFQ1RnpBbktaNEc4NWNRcWZuRmU0RTg3?=
 =?utf-8?B?cVA4L21lcVA0aVQxVVRIc3h5RjMwWWdOQUtUYVVvSmFzdGpNQ0xMY2NvQUhR?=
 =?utf-8?B?YWVvbzRKZzdqanJ5bHU2SUh5M043WEpaTTAwd3U2b2RIZml6alJEVVphSkNB?=
 =?utf-8?B?Qi9uZkl1dURFaEJBUEI1V2tqZ2hmSnFURzlWK2FUK3NyTXY5YW1qUkxreW93?=
 =?utf-8?B?amtzUFBvY2hpOURlQzNDNDNiSHhuUHdTM2xycldZNUFaSnhnTGVoWTFBcnJK?=
 =?utf-8?B?QWN3T2k3NDlVWEpOTTd6Ri9sTmQ5NTg3U2FRWUdpYTJGU2hnbmRiWDRwNUFy?=
 =?utf-8?B?QXVJMUVaM29UcngraVZtYWsxYmw2dUsyQUkwdk5rK2V6WjVUMjN5a3l0aURU?=
 =?utf-8?B?U3NHNlNWcEthWW5oUnRCL2lnb2JTeFZ6UXE5QnJlTnV2V0hzRGpJdmx0MFlL?=
 =?utf-8?B?RnFWbExXcE1VQ1BSYnk4WGpaSGkyR0lpcHRKQy90Y3dJK3BjOW1FUWlHSklG?=
 =?utf-8?B?WnVpeTJPQlB2OWRZOU9KZnpnUjUwRTNaSmwvS3JwTFNHOWliWjk3aGRVVUpL?=
 =?utf-8?B?WE5JWURVcEw5d3A5cmU2a08wbHFjb0x4U3hrS1JTR1BMYytSUnRlOUtSOEZC?=
 =?utf-8?B?a0RZcTU3ai96QmtwV1crajRrZFM4Q3RvbWFaektBekcrTWgxREFqNlpYR1Ny?=
 =?utf-8?B?TzJhSHNnalhNSFplK0R5aU8yTGw3QStpSEpSbEZIZ0FobzZtWnE4V3cwT0NN?=
 =?utf-8?B?RkdHaEdLOTNJYlI2Rk5mZ3ZUR2VOTjFsZkRBczZSc2pBZ3owNmdKeWYwZzV5?=
 =?utf-8?B?WEtPYllzYURzT0p5NTZGc1VzU0tsOGNZRkJmcEJIYTNBUjNzL09GQkl2eE5P?=
 =?utf-8?B?ZVRIZThpQ2dscW14R0ZaY0I5L0VMR1JTcGVjU1ZmVmtQS2JxdXQ1OWNncWdk?=
 =?utf-8?B?SUo5R3RZSGRBdnE0QW5UdnRFQW9VVmp1QkVUWWJqUEgweldXM3IyZWJxeEtr?=
 =?utf-8?B?RmxlWUI0TnhEYTRYN3FGemlXRWpKQmMvL01ma1NQVEdQODBHcFcrcGN6M3Bs?=
 =?utf-8?B?bzZ2VW1oRk5xWjRob0VtcE9CVk9DRk5YaDR3UEcxZlpVOUp4VTk4djNQbHRu?=
 =?utf-8?B?SWdaU2g0YjJzcTQ4U0RBK2JvWWVMbHlaenlZeWIxS1pQeUQyTlI5V2hVRDlh?=
 =?utf-8?B?WUpLMHp1bmRSUGJ3OGs4czJtazJKajhudDk5WUV2SkJQb3BDb29obG1wYk85?=
 =?utf-8?B?aVl5cnVwTmxOdS9iMk1ZVzZ0am54RVduWEdyVHozL3FSaXVWaThkekVPclBq?=
 =?utf-8?B?eW5aQk0ySXdtQi9IbTcwVjRlZmFWdTlCQjJxRERPMXdzY3hVWmphWXVZaGZi?=
 =?utf-8?B?UzZ4VitIQ0Q1Y2FZNE9vSzdnQ21NY3c0L1U4Qkh5QzRIU2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkpkVnhKSTJyQUxyNGNNTzdyM2NvQkVua2xGK0NIYlBPc3hxU1ZFN25aZU9U?=
 =?utf-8?B?WkZaY00ySW9vY0c3bUVmaitlQVBWTzNWRkJ4Q0tNQStWNUt2bkExNjZLUlRS?=
 =?utf-8?B?S0c3TU4rTVFoSUgvWTRTdTFwOEhRMXF3cXhzVHFpcGtXb2x6bHR5dnZrTmR0?=
 =?utf-8?B?SGhXN3VkeVlWR01ac3V6a2Y2T2E1MGtvQ0F6TnEzTWxHM0xGUFE0bmxSRDIv?=
 =?utf-8?B?a21VeFNXdFU0eW5nbEFNUXJyb1VlL0U4R0VkeEtMUUUrMFA3UmNmL1R0MjFB?=
 =?utf-8?B?WXBCYzViZVcyVjVuWnBycHlWTFFLYlZJbCtMTlU4eGF6eVhnYmJtT3c2NGV3?=
 =?utf-8?B?elh1SE9Kai9BNEV0dWw4Z3pWZVI5VEk5M09lMGZHU0NxZ0duSFRrVnhEMmFV?=
 =?utf-8?B?Y0NkbWhqYVNSQmZPeG9hTXJvTENCcEpZMHVoQ2FESzh2K3oxMFZWbEg3cDN5?=
 =?utf-8?B?R2M2bHVmVUVzek9xY3ZON3MyTEFhRjNVaHNDQjVpQTRyRGF6LzdiVWxwTnFz?=
 =?utf-8?B?YnZsYzZwVlc4L0kwRXp1NmduQnRaSm1iZ3JCQVVaZmpyWXFvSFQ1dWxNZnFu?=
 =?utf-8?B?NEkvS0hLRGxkajJCNVVVZ01iRjZwOWlRa1ZXazlpaXZSQThMZ2c4UGtja1FY?=
 =?utf-8?B?Tjh4TllPLzFmTk1nd29OeDhoWGtqWlg4N3ZyOU1KMWZyai9SaGNpWmoyWmF3?=
 =?utf-8?B?WU9IaFdKMGc1a2xiaERjVnhGK3ZyN1dQNitzU3o2amxIRXBBbzFOWDRUUmZp?=
 =?utf-8?B?a3dYVCtpajJmT1dTd1R5YWNpRHplb1pEN1R1LytTVnJEY1NVdnhQdEFvUnho?=
 =?utf-8?B?NEJKT0ZlMlNEZ3pVWWdNdlRPQWJvZGRwNUFYM1JrU0tIVnIrYkVKMm9pMzhG?=
 =?utf-8?B?ZEo3SmNFMWIrb2ZjbWFOdzV0cm5oMHptdkUxclVLWFpEbGJQYTFTRUFOZ2Ni?=
 =?utf-8?B?ak1weC9FSkFjSlRsRUtBY0llKzdYOWxrbDFHZDg4TkJOQkYwOHBaVnd6ckhm?=
 =?utf-8?B?WUtvaE9IMGFiSGRtTFdJamZtZUJqbk41OUpCa1pMK3RycjdMOERTU1ZFTWZF?=
 =?utf-8?B?SVZDaWNza0g1RDJqSzdaUFZBZi8xN3RMcWdOVUNvTDhselFXRVh0cmkvV3FG?=
 =?utf-8?B?ampXc1RqUEU0d1BEV0VId1NNR2xLb1FiZGpodkExMHRqbTlHTmlHNUlSemxD?=
 =?utf-8?B?bUZKMnlXV3ppY0lHUGt2bng1cGpjazRvaHNRS2U0N20yeDdXWk5aNEU1cXYw?=
 =?utf-8?B?V3pxbnNCYWJkc050NSt4L3RDUkF1M0dTTTNXUzZTd2ZCUU1HWGkySkl1b056?=
 =?utf-8?B?SVcwUi9TbzYrb2liV3RFaGU5akF4TXB1R01ZRmhQbmJsdHZHdnJqSTFSajBi?=
 =?utf-8?B?MllXZWtXeURGR0NPR0NZMlNsMzJBNm5jaUl3OUx3aEEyMHRnMFRTR3hEYnRo?=
 =?utf-8?B?ZEhlTmtCblEwVnlyQ1VoZXhhbWgvTE42emRXM0dYTlFEWjJCZVpKdEYwak9U?=
 =?utf-8?B?SlFGY29RekNLcmNQVlBFa2Q4a1RicXlVLzV6MDRuZzdodTVGdW5KSU5NZ2Fv?=
 =?utf-8?B?aUp4YTBGc01BNjdvSjhTZFJEREh0VWRUeEJqa0ZtLzdQWmFXbHZXOUNaM0Ni?=
 =?utf-8?B?VzF4c1RJQTNrMFBRV0JiWUd5b2NvdkxidlA2aU14bkdlbmpFcWw0L2VaQ3Jh?=
 =?utf-8?B?MHphTEh2cFJJa3lXcGJScmp1RnBUdnorVG5QTnhYTkZkZnltRWxoVXNGWDlh?=
 =?utf-8?B?VkRJU3p2clkzLzBmNjFuQWdiSktybW5tTktPcVYyeXNaRVFOL2tyOEdOUHVK?=
 =?utf-8?B?aStINjZZTDRGbEFzQ01tbW1vSXIvUzIrQllrVDlkc012bFA2cC95cE42V2dx?=
 =?utf-8?B?bjJuMVF0NVA3N3RsL2trS3dYTllaK0ZidzRYZkxMNFdlR2hDbGNXZzQ1dnI0?=
 =?utf-8?B?ZCtzK2hROWR6QVJaSmdkL1NzVGZHMlJHYjVCOStJRWNKZXVGNi9Nbk5MSXJ1?=
 =?utf-8?B?T01BaFo1bCtCdzZwbC84VHNRNk8raTJmR0tTdW42VnBEZnN3ZHhRTjRuWkVp?=
 =?utf-8?B?NFhBMnpFVFZyMHVMR2E4alg4QkdwMldQVDFOYk40WDQ3RWE3K3VPZnB3THl5?=
 =?utf-8?B?bnZCUGNCTER2NmdTWXcrU0JuM21nSkh6RncySzhkOTB2VGxZS0pYTE1DUUFu?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8fd10a-e3b3-4078-92aa-08dd56822970
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:25:19.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vY9yabYbVhoUU4+IPESZYu6/O/bWoaKsjMrK942S7X3RYukVyPFULGIe31JErXRZrnFBJY+GhGEYcHZcaHtkp3yFrbdCrtYy11Tt7NhZr4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4890
X-OriginatorOrg: intel.com

Hi Peter,

On 2/26/25 5:27 AM, Peter Newman wrote:
> Hi Babu,
> 
> On Tue, Feb 25, 2025 at 10:31 PM Moger, Babu <babu.moger@amd.com> wrote:
>>
>> Hi Peter,
>>
>> On 2/25/25 11:11, Peter Newman wrote:
>>> Hi Reinette,
>>>
>>> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>>>> <reinette.chatre@intel.com> wrote:
>>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>>>
>>>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>>>
>>>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>>>> for.
>>>>>>>>>>
>>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>>>
>>>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>>>> customers.
>>>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>>>
>>>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>>>> event names.
>>>>>>>>
>>>>>>>> Thank you for clarifying.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>>>> which events should share a counter and which should be counted by
>>>>>>>>> separate counters. I think the amount of information that would need
>>>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>>>
>>>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>>>> writes in ABMC would look like...
>>>>>>>>>
>>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>>>
>>>>>>>>> (per domain)
>>>>>>>>> group 0:
>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>> group 1:
>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>
>>>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>>>> configuration is a requirement?
>>>>>>>
>>>>>>> If it's global and we want a particular group to be watched by more
>>>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>>>> for that group in all domains, or allocating counters in domains where
>>>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>>>> there's less pressure on the counters.
>>>>>>>
>>>>>>> In Dave's proposal it looks like global configuration means
>>>>>>> globally-defined "named counter configurations", which works because
>>>>>>> it's really per-domain assignment of the configurations to however
>>>>>>> many counters the group needs in each domain.
>>>>>>
>>>>>> I think I am becoming lost. Would a global configuration not break your
>>>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>>>> globally then it would not make it possible to support the full configurability
>>>>>> of the hardware.
>>>>>> Before I add more confusion, let me try with an example that builds on your
>>>>>> earlier example copied below:
>>>>>>
>>>>>>>>> (per domain)
>>>>>>>>> group 0:
>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>> group 1:
>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>> ...
>>>>>>
>>>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>>>> I understand it:
>>>>>>
>>>>>> group 0:
>>>>>>  domain 0:
>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>  domain 1:
>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>> group 1:
>>>>>>  domain 0:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>  domain 1:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>
>>>>>> You mention that you do not want counters to be allocated in domains that they
>>>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>>>> in domain 1, resulting in:
>>>>>>
>>>>>> group 0:
>>>>>>  domain 0:
>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>> group 1:
>>>>>>  domain 0:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>  domain 1:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>
>>>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>>>
>>>>>> group 0:
>>>>>>  domain 0:
>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>> group 1:
>>>>>>  domain 0:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>  domain 1:
>>>>>>   counter 0: LclFill,RmtFill
>>>>>>   counter 1: LclNTWr,RmtNTWr
>>>>>>   counter 2: LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW
>>>>>>
>>>>>> The counters are shown with different per-domain configurations that seems to
>>>>>> match with earlier goals of (a) choose events counted by each counter and
>>>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>>>> understand the above does contradict global counter configuration though.
>>>>>> Or do you mean that only the *name* of the counter is global and then
>>>>>> that it is reconfigured as part of every assignment?
>>>>>
>>>>> Yes, I meant only the *name* is global. I assume based on a particular
>>>>> system configuration, the user will settle on a handful of useful
>>>>> groupings to count.
>>>>>
>>>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>>>
>>>>>  # define global configurations (in ABMC terms), not necessarily in this
>>>>>  # syntax and probably not in the mbm_assign_control file.
>>>>>
>>>>>  r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>  w=VictimBW,LclNTWr,RmtNTWr
>>>>>
>>>>>  # legacy "total" configuration, effectively r+w
>>>>>  t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>
>>>>>  /group0/0=t;1=t
>>>>>  /group1/0=t;1=t
>>>>>  /group2/0=_;1=t
>>>>>  /group3/0=rw;1=_
>>>>>
>>>>> - group2 is restricted to domain 0
>>>>> - group3 is restricted to domain 1
>>>>> - the rest are unrestricted
>>>>> - In group3, we decided we need to separate read and write traffic
>>>>>
>>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>>>
>>>>
>>>> I see. Thank you for the example.
>>>>
>>>> resctrl supports per-domain configurations with the following possible when
>>>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>>>
>>>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>>>
>>>>    /group0/0=t;1=t
>>>>    /group1/0=t;1=t
>>>>
>>>> Even though the flags are identical in all domains, the assigned counters will
>>>> be configured differently in each domain.
>>>>
>>>> With this supported by hardware and currently also supported by resctrl it seems
>>>> reasonable to carry this forward to what will be supported next.
>>>
>>> The hardware supports both a per-domain mode, where all groups in a
>>> domain use the same configurations and are limited to two events per
>>> group and a per-group mode where every group can be configured and
>>> assigned freely. This series is using the legacy counter access mode
>>> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
>>> in the domain can be read. If we chose to read the assigned counter
>>> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
>>> rather than asking the hardware to find the counter by RMID, we would
>>> not be limited to 2 counters per group/domain and the hardware would
>>> have the same flexibility as on MPAM.
>>
>> In extended mode, the contents of a specific counter can be read by
>> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=1,
>> [EvtID]=L3CacheABMC and setting [RMID] to the desired counter ID. Reading
>> QM_CTR will then return the contents of the specified counter.
>>
>> It is documented below.
>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>>  Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
>>
>> We previously discussed this with you (off the public list) and I
>> initially proposed the extended assignment mode.
>>
>> Yes, the extended mode allows greater flexibility by enabling multiple
>> counters to be assigned to the same group, rather than being limited to
>> just two.
>>
>> However, the challenge is that we currently lack the necessary interfaces
>> to configure multiple events per group. Without these interfaces, the
>> extended mode is not practical at this time.
>>
>> Therefore, we ultimately agreed to use the legacy mode, as it does not
>> require modifications to the existing interface, allowing us to continue
>> using it as is.
>>
>>>
>>> (I might have said something confusing in my last messages because I
>>> had forgotten that I switched to the extended assignment mode when
>>> prototyping with soft-ABMC and MPAM.)
>>>
>>> Forcing all groups on a domain to share the same 2 counter
>>> configurations would not be acceptable for us, as the example I gave
>>> earlier is one I've already been asked about.
>>
>> I don’t see this as a blocker. It should be considered an extension to the
>> current ABMC series. We can easily build on top of this series once we
>> finalize how to configure the multiple event interface for each group.
> 
> I don't think it is, either. Only being able to use ABMC to assign
> counters is fine for our use as an incremental step. My longer-term
> concern is the domain-scoped mbm_total_bytes_config and
> mbm_local_bytes_config files, but they were introduced with BMEC, so
> there's already an expectation that the files are present when BMEC is
> supported.
> 
> On ABMC hardware that also supports BMEC, I'm concerned about enabling
> ABMC when only the BMEC-style event configuration interface exists.

ABMC currently depends on BMEC making the current implementation the
one you are concerned about?
https://lore.kernel.org/lkml/e4111779ebb0e7004dbedc258eeae2677f578ab1.1737577229.git.babu.moger@amd.com/

> The scope of my issue is just whether enabling "full" ABMC support
> will require an additional opt-in, since that could remove the BMEC
> interface. If it does, it's something we can live with.


Reinette



Return-Path: <linux-kernel+bounces-550435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC441A55F91
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E36177796
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80297198E6D;
	Fri,  7 Mar 2025 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eij9S78a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C571922E1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322161; cv=fail; b=dIYCkzeXI3jLaORaheU5QAp/pdJVclOl4G7/0+/51dfAbj2j2o3Til49juDfkJlefCuY2EVNwSC2UMe7oU8htC41P1prwt5mf+XzYgnB7pUma8oua8cbjHqHZJR9O2u2QkhzwQ1AmPtQtgwP/NXFgnJ8sc0r1sW1eC7NZuP2bFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322161; c=relaxed/simple;
	bh=taoJ8BPwRz94Yd9gMqlxLZaJ/eR8yaHYEG0Vn4VjCLo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EiyjyQ+YwJkoz7MwDIdS49TLaNWxl7DFOIV6qRZ8adaq59tCoTeBFoxVP88t5mhbtAHBWivqTc5Jd1h/tJdG07WQjHOJqDcD3ojPtwC+6yU3+r7XizQ98KZvFnixFH1dCy5tvgpfWFS3+NNZ2FeQDzlXmYGffB/idupTE4ZbqNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eij9S78a; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741322161; x=1772858161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=taoJ8BPwRz94Yd9gMqlxLZaJ/eR8yaHYEG0Vn4VjCLo=;
  b=Eij9S78aTn8GFRQyPH9j6fwtpQFKjpRo2IHfyztXEnO1+xq9l6nDkB69
   bkjic8MsD1q6bXfwWB3BDNGKE+3WE1Wr7AQU8jRIqXYt/JwPXNVj9Dz5T
   PKRnBhpEV0BZbJ9azXbBxCgX6QbCpPEgi2bJgcWQXc20O2tgLkwcJq6z4
   RSx6GA3koWr38IuhXeHLGOiTmnmHLP0ClMlzElLpNWOpGjUF1uNgPz5zw
   SyHLD0mWwy2i7ToclgmyWmixTupCDrufkkAfsYyFWAzPVoYGaQk3j2VYL
   9y0tMStoL6GuRBE//X7t5EAsyuCp+0cNNwW3iFzktUP3JHbtvXexhKHx2
   A==;
X-CSE-ConnectionGUID: ll32OMMjSZ2z1rXDDcGKsw==
X-CSE-MsgGUID: 1nkIsOt5S6K1vavwpaOdVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42559581"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="42559581"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:36:00 -0800
X-CSE-ConnectionGUID: cUV5uDTHQySKjm2qLV1E3w==
X-CSE-MsgGUID: bhR3XIHgQaiUQFkxayrLeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="124145404"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:35:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 20:35:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 20:35:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 20:35:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSGn7WeIKF6IwRMOel/wCNxO2g+GHjS63DDI/hU9wDZHL92ISs7Q7MzBPgSoCpLl1rqrUza/o1ZbHe/1g3t21HrKo2nZcBeSBv/EvhCxNIsOjV6Ou1pwje6usajwQr/Y+m80TAHtVb6UjshVe7g4ezhevXecNhsOQNFM3Uyr6DhotQCFo371JadD15qhj/rAfrjmzHeRI3Tw6ts+YcUD9QRReHBXLXVTZ5TFmc7GA/hAE8vwdDtmGEDiNRaAaK70A1xr+HCPc1zb7S+29leZaLJY9Jq76ci8SQhIQMKfIJitCvKH+QwySWvD5cJ7adCR89sp3TBRIv0vG7o8ow87Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMIEXpTpcB4YIVnYz5sT7DdFqMhVNz/9l3hMMv60bHo=;
 b=AGBZZ3mK9aoybP4300y3uoEFRx7sdkp5RLGO0urJP5nxy+3gHNp1n2E2DCAIveSrTyMQ1lKJk9jX/EAaYxoncvX6YUmha5lFiSf/EL77UPXTVFWq/ghOtZKPt5ArAt2NLjckRwylEqXMrNLokVptQuHo1jVYUtaWWNgEExj91U4woWCgV6c4WylLGSsl4Sec1suak2ub+E2xGh4k+Tub6FcN/q1gUrzLB/Z2Od7pHvj6W8k5VyJCYwFEemtVa0h7dyuprBN8KdmR6dd1L0QLsLBUXdR69LSjnaM95NDTRk/GYd60wSkg88gNF1ue+fm7izXsStOP+BQ7iIWmBz0n9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:35:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 04:35:23 +0000
Message-ID: <117d83ab-aa02-4372-b15a-a4516ad5f0fb@intel.com>
Date: Thu, 6 Mar 2025 20:35:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/49] x86/resctrl: Move the is_mbm_*_enabled() helpers
 to asm/resctrl.h
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-19-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-19-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:303:8e::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: a31c6caa-be48-4cbc-fcba-08dd5d31799e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1VKZ0xCekI1c2Rpa0NRVXpzUVVlWjhVaXFhbVNsajA5akQxZmN6c2NON0VV?=
 =?utf-8?B?OGN0MGJ1MGlnL3hkYVVzUjFyVnM0bno5dHpZSzNhS3VqK2tOeTdjSEU5aGdp?=
 =?utf-8?B?OERMWndBckVUdUh6Z2tNY1NwM1dyLzZNQTdURTlVK0k5eTRHOFZlVm5qZ2Iy?=
 =?utf-8?B?Y2VRYXRsUVlOcG1vNEJBREo0SmdnclRINCthMC9uY1ZuODZMSGwxS2NhS0pC?=
 =?utf-8?B?bFFXREl0WjJsTWkvVDFITVRzc3pZV3hGS2wrU0R3dU0xR29QQjFSTGNCeWdO?=
 =?utf-8?B?c0FPOWlUbUZOeWFzYnlWbU0zSE5KVVM5UE9TMUZzS1VMVFphSjEzVlJJRGV5?=
 =?utf-8?B?dmtCUXl3NUZNVE1OZFdjUVVpdnFwNC9mYXNGMWdleFEyYWlqWkNXbDFQUUV5?=
 =?utf-8?B?dXg3NnV2MThYdGtya01QYkQxWGpabUVPZjJyK2pZTk5RK3ViK0JqNkdFYWQ1?=
 =?utf-8?B?SU9rV0ZBYzlzT0NzTzkzM1hKa0pKeHpndmlNWmhzK2VmWFdEV0YyL2UzS1J1?=
 =?utf-8?B?c1NaRWQyOXB2alZRempNYVdtTENBVFhqakZaUkNpNlAwL1JrejBSTHpXcW5P?=
 =?utf-8?B?TDJjSzlRN205OTUwaFRIK3dQV0ZUNHc4WUFqd2szWVVuamluK1RlMVNmWXBz?=
 =?utf-8?B?OFFLdDFhSzRPbmJPNkF4aFJnM2Q4b3h3bGJaWnBqT3pDVzFSMGI1SktFKzRa?=
 =?utf-8?B?Y3ZOcFY2SzFqaHI5TTgvVkpFRGc3QTFncnlHbkFkbXlCeHNwbUN6Rm5uKytn?=
 =?utf-8?B?K3p1clNma3lEbXdJK0VLeU4xdTlUdFNOamtMUmg5S2tqRUdEL1JQWW9zbk9m?=
 =?utf-8?B?MUltRjRhakwydjc5ZmVhK3QzR0VDc0orUjdVWHRhc2IzSUVaa1k5QktPWXpT?=
 =?utf-8?B?OTNTMlJUZE9xaU9zclBabkNkSW1NOGEvUndPTlFoVkVvV3RYQnk1OTA2M2V3?=
 =?utf-8?B?T2NaZWxDUHlJdnZ1eGNLSG1CK240ajV5QzhRSkxSVkpNRmwwZWVydVNFNjlz?=
 =?utf-8?B?NzB0Z3J4OThRWDNZOUl5L3F4OW5RNWtpSVhPeEpCSVhxcDFJVlgveGZqOWdK?=
 =?utf-8?B?UkR4MDVEUDA4RzNoN3pkcFVkMW95aHZPTXpZa3Y2TUNBSXBPbC9iY0xhQ3Jq?=
 =?utf-8?B?RlRxcFpBM0hXRE5UcHNkSDN2R2RITkNuNHZBNm5rR0VBVG1XUktIbS8vcE9Z?=
 =?utf-8?B?bjFYbWNYb1ZiYkRkS0FkaUNMN3oyR2Mvd0dhd01jYWZLTlNUZzhDRkk5bFh5?=
 =?utf-8?B?NnErYyswOHZnR3cvaVZwZGlzdmJSYXdaS3ZkeHBFdzlPaURkZnFJSHpvaEZJ?=
 =?utf-8?B?a3ZWQlZwaVdraXVsUFdjRWxuVFpUN1pZb1dGUlNYdEFsMGtENTF0bkNLNnVx?=
 =?utf-8?B?ZWhySDQ2NmJoUTBpbzhiTDdNVVMxalRrcUNJcU5PQWtWUk9WeVk2UStwY3gr?=
 =?utf-8?B?bnp2NjJuZVBUT2ltaXFtUlNyVHEvNkV4dTYyUXBzcVdPektLa3pGakdVZXZF?=
 =?utf-8?B?eHBwQUxyVnNKTDgzemNhbnFETWw5MjdZTHRabmVHVWdvQUhjNzhjanhaU2FG?=
 =?utf-8?B?SVNZUVpPTTBzaUpBenRtN2JOU1NhYVZVK0tBQ3Z5KzM1TDNMNWpJelZ1Znlx?=
 =?utf-8?B?QmZZWFBUTEkwNmlBYUFvd3cxcmZXbW5Hbm5na3pVUkIxNGUxQVhJV1lQTWFO?=
 =?utf-8?B?YXI4Y1FTd21SNTVwOUJjS1pIb3FDZUprREZMMmczZnNEUTF5YUVlUHZrMmZu?=
 =?utf-8?B?czM5OW1nYXU0bVJpQ2pyVlpBRjdLeStldHRDZ3JpZDZUSkZuOExsallMRmtj?=
 =?utf-8?B?cmhYQU44Uyt5YzZtSURBeG9TOTR6bldzRlc4M0xxalkrZnlaa01oY3F4d0NE?=
 =?utf-8?Q?xBMiBHbzKxOoy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmlXQWtRZmZIcWE3Z0Z5Q3hROTdWRG9kdlhjYndncmlOZythZHBtQnNPNFVh?=
 =?utf-8?B?amZWeDJnK1NjaVVOSnVMaVVLNmtFdXJNUVpCYU9RZnJEdWhUdHlvTkpwOG05?=
 =?utf-8?B?UHppSWFvWEJzbzkzV2F5Z2JMdis1RTJZb2pMSXk5SlJCK0g0blk2U25yNFBD?=
 =?utf-8?B?Ym5nREhUQmYxQ3l0ZE5uNEwyZzRXU2dKWUpqNDVWM0NRMlhkL0laMG03aC9U?=
 =?utf-8?B?SmgyWXorV0hKdVJrMlM0VHhnTXBZT0IzckN5d3k4cnJVTjZ5TGU1a0ppdmJs?=
 =?utf-8?B?SXFOcHJMb3JpZVpkcmVBWTZtYjZ2dzhCNGd4TlBncGVRaCtPSVhhdGlZV1F0?=
 =?utf-8?B?bEhMMHVGaXB1cmhhcFV0YnNDV3A3R3RNdWZ5d1lYV05zZ3ZXSEl4dFRyQVBi?=
 =?utf-8?B?ZVYzVlFKTHdhazdiUFg5UVNKaHhvTHhmVStvajE4d2dsNlN1OG43VERCVitz?=
 =?utf-8?B?SDRxdHpsK21OL0puZzU1d2tldVIvelNjNWZ6MVlmWEljaGxjUmpSUnpyc1Jr?=
 =?utf-8?B?MndBQ0I2RW1KVHBxeTQ0RS9qSTcrVUxWdllhUUJ1ZUVRamhHcjBhQy8ycHV0?=
 =?utf-8?B?Q3NocVNxeE1JKzcwTXRXM0piZ1RiQ0YxaUNVWTRETWRjTHlsRzU5cGNjU05D?=
 =?utf-8?B?OW1qMThWWG94MGlYUWtFUzBxRGpNOW10U0lHTjkyS3lsMlc2MXdKcWFKY1RQ?=
 =?utf-8?B?bFl3UTFnWVJ6TTM4b0hOaklvY0hTK1FHdkFXcFAwVVR4SnBkRGFqeE9HeXVZ?=
 =?utf-8?B?eGpoV1ppYW54WTVMYlNQR2JKcmNQQ09DdG9CVTZzbGo3U0dFS2Fqa3BIc0Zx?=
 =?utf-8?B?ZnE3NTRTdjBqcytCK1diWnYwb2pQaHJ3NCtNRE0rcFdUSitDSjVvb0pWdE1R?=
 =?utf-8?B?YVAvdlZ3ZUp3R1BqVmNRTU9oeitBcmNvZ1BiaG1Gdm9iWUQ4YzJLVzNVN0JG?=
 =?utf-8?B?c1dCdzRXenZCdlBuWk05OUVzeEZHNE5PY1orZ3NuWHFUdDREQjN1MDl2UFZB?=
 =?utf-8?B?VWVjRndZUFBxc3NIOGY4L2t4M3I3YkxHYy95amJlUm41bVAzK3N6TngvUjU2?=
 =?utf-8?B?ak81ZTNQSW9QcFdXTm5xazRtV0FwMDdveVhucW1qRnVzZXNJUHRBSlFpM1VE?=
 =?utf-8?B?SUdxK2pSbGYyZjRBb0pwbWNCK1kydzNLTWhhRi81SXVlSUtLS3J5V2E5UmlB?=
 =?utf-8?B?Zy9SQjlqRWxzakNUeGFIQ1luc3B4ZCtXc0l1V1VVU3R4elNYUENnaDVlQXVi?=
 =?utf-8?B?cHNYMjRHTmtqZVN2VlRmR2JNc05ITkozRVpkRnU2eTRGN1Raa0pPRFdVZjBs?=
 =?utf-8?B?MlBRbkxLTEZjblhaSEZOWklGQzRjMGoxWE1MS0ZBYzcrSG9JTEQ0N0pUVDRX?=
 =?utf-8?B?b2huaVJnZDIrQ210c3laUXVFc1ZaR1F0N2pUSk1lVkdwNjVyTEZKZE54aFBl?=
 =?utf-8?B?VG1pZ1I0c201RVNBNU0vTUVjcUg5UmZGSmFJcGlLblJCNlg3OExmNFl1SWxC?=
 =?utf-8?B?NUNIOHA5MnhWdzZKMzlDRVROMi9ER2Yyc1FISDBIdlhnV21zbmxVY21pQlRY?=
 =?utf-8?B?U09YTWE1c2xjTUZha3NldFpuYWlIRklndEpPVkVVU2xiKzYvTUlEdi8xR3BX?=
 =?utf-8?B?cDFzQktseXdTakFyVDFvdS9LUXB1TWlvd0VINFFBR0VsN1B2dlc1SXVyUTJD?=
 =?utf-8?B?bCtVYlIrdk1ScGkxKzZBU3F2b1kyY0VUeFVKLzdkNXFSMnpVWkdvUG1TOTlR?=
 =?utf-8?B?ZVFINThVQnROQURaQ3laL256YjZ0QWpqL0dKcmFWTTV5RnlPdzk4VnVEQkxY?=
 =?utf-8?B?MktQSFU2Q1VaS294Nmo5c0NIV2tRMERTVm9ldm55T1RrMk51VHdIdlNyNDV0?=
 =?utf-8?B?Q0xFN1FnUWR5anRnNDFSZWVHZEtBYjNzVkNBZmN0STJUWUhFRkh0aW5TbDNx?=
 =?utf-8?B?SGpEdnJ2Vzl0ZFVnVW1RL2kveFVHQ2tpMDhicjd5U0p4emtMTUdTU1ErTGJR?=
 =?utf-8?B?S0xTUUdNaFFHYlJ2SS9NNnQ5U1lnL1RBNHlTck13MWhNZ0xyQi9QcW5oUC9S?=
 =?utf-8?B?b2pLWGE4RkhaMit6Z3NkTitYWk14RlZqZE5HVjYwTjg5T0dXOFF6T0lId05z?=
 =?utf-8?B?Y0dscE5JeVBKMmpFV3FoWi95NEZ2RC9jRy91WnF0ZlNRRUEvUmxhUnFJWmJZ?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a31c6caa-be48-4cbc-fcba-08dd5d31799e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:35:23.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXd5ZegeqzoypGXWpQPQ1ZFCHZHtZSvdSq4nTYJjS39hXRIr4p2O7UH2yigb4F/gHfeL2ofT2V0WzntkYKRY5dAyjrXiXJfuEsDvrsAFBhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:58 AM, James Morse wrote:
> The architecture specific parts of resctrl provide helpers like
> is_mbm_total_enabled() and is_mbm_local_enabled() to hide accesses
> to the rdt_mon_features bitmap.
> 
> Exposing a group of helpers between the architecture and filesystem code
> is preferable to a single unsigned-long like rdt_mon_features. Helpers
> can be more readable and have a well defined behaviour, while allowing
> architectures to hide more complex behaviour.
> 
> Once the filesystem parts of resctrl are moved, these existing helpers can
> no longer live in internal.h. Move them to include/linux/resctrl.h
> Once these are exposed to the wider kernel, they should have a
> 'resctrl_arch_' prefix, to fit the rest of the arch<->fs interface.
> 
> Move and rename the helpers that touch rdt_mon_features directly.
> is_mbm_event() and is_mbm_enabled() are only called from rdtgroup.c,
> so can be moved into that file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


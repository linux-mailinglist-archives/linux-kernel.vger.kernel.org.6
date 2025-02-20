Return-Path: <linux-kernel+bounces-522787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665CFA3CE83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A207A705B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20814A0BC;
	Thu, 20 Feb 2025 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XofJABiu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C4286291
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014283; cv=fail; b=PQD8s9gT77e8+zif7q7Hg65WeGl3npzhOgVqUuTbIr16xM2Puw0EbdcB06652okisqkPghX4ZxBCtuiibkbZdct0ZszExCjdf9rgltA8pFbM5bBTRlzVlwYkjgNNqjHkQHHVCuFPJTUJ7UlLfwlwHj3Dv2iu546gQqnk0+pIt0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014283; c=relaxed/simple;
	bh=7JKCinUig9DSxAJRHeZM0SG2su8F3lmnkONDR+PSDSQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XYb4BYwRFrrnTiGJrXM7KUw82LuE+jVqcEnpxkiFLFoT6ixM/S1e0wFGoAS/+Iy+W1GU+d6qfmhjwF/PPeghz73T5s4PcMiQeyx0SSwwsmF19dgSHHlawYziaQFQhimBjmLlO+GsKambR4H1VNhhbsAwPM7KdYiTrWFg5eWLkKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XofJABiu; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740014281; x=1771550281;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7JKCinUig9DSxAJRHeZM0SG2su8F3lmnkONDR+PSDSQ=;
  b=XofJABiu1NoGKyzixuFv60nnkt8XKzu+chvJqAhNoQ0TlmW+ebV1ufNJ
   Bhj5FAx+6n3wjNMlItsQTlkWz2DgWHxLuvXyDaM2VRRc0KuBZN/hug8Ai
   nmAvKpluf/PAAHgSqj8hwZyGXenud9FIWk8mudr+YT3OU9M53kn9II67P
   O+raQrGZLdcfTjvxH1UbbE8HnIX1kVOle/VnGn2ScCkGGkXASoeLWo7if
   L2ko+s4JW9muCizKQ0rQvYhsTufLeXyiXV3XsB1sj2bQqbr3/g6PLImzg
   KR+IF2tTStfvkk2HUjNgcErmgsaD5RMiQneD/hVxvqDyLpwcRpd39DSwC
   Q==;
X-CSE-ConnectionGUID: No+nYaW4ST+9wBq9A4ywZA==
X-CSE-MsgGUID: bOn18CJVQt6fAq3znEMZXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51397507"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51397507"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:18:00 -0800
X-CSE-ConnectionGUID: jSBLWNKJTouxa3X6w/nkiQ==
X-CSE-MsgGUID: Pyf4NOpOQNq7rxIC+1ryJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115429885"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:17:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 17:17:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:17:58 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:17:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK2C3VheAKMmtX2YGSBl3C9cl7WoZKNnGy9YFQHbbsNWRNsw+CzUem1B1NwU0YDGYrB3WOUZ+tivBJwPsr9Kboa9ddlTJmGyGljHxMBElHDNsrhaF+KL5zJZ/cJeeWhlKQYJ6xRiJKDz+cB+adkpCP+RCt1iNNpAokMLKF1LFIUVigrdCrc+lz3RVsMXMLLBbtchwM4wNo58lBsRHBQ4hmhYizBvj87Qw4MS9SLzPr+nITvxLraXbX3ziX6dLbCqhs4WrtLub0y9cdelcQgWp0m1+ur7bUXRO1Afzk01VKRRRuy2aVhR7XIDyetQmlJpsxICU7Hfbfh8uPLXq8SLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7igxn+UZyd7gXnhgbhlY74sD9M4KIw3QqUmSzyVSpw=;
 b=ljnAMrSpCll/wd7Qgp0WFDs8uHC+MdXu5T3MohasO4FNFN8oSQuCgwOK/4rzPZY3XE5Ctlp/C5uA83RlPfuNFy9FhuJ9JsfXc+3mxtJPcTD0qi7dh/A1Xygd+o3kTO9wgV3Gbk2GgfTOzSlJKNLjyJorJ/NpnB0dq+S3oW1j6HCr7TkB5hLMj4NblFZ+boknrKf4wD3+HYNEE3A1nhNgoKuzMELKVEG44DSpkp8ggyCEry6DxLMKeDjZ6oCrmlUhvhSDx8yOpmLCPpStFeWfr447lQgXYO7GrGyajNcvx+9XigVOrfw5+/5HmCot/jA4m/MtfyVIVM1diDPcXofRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 20 Feb
 2025 01:17:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 01:17:44 +0000
Message-ID: <5424ecd1-6a6b-4ed9-87cb-845036c23fb8@intel.com>
Date: Wed, 19 Feb 2025 17:17:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/42] x86/resctrl: Move RFTYPE flags to be managed by
 resctrl
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
 Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-28-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-28-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4a22e5-9984-4905-e68e-08dd514c6134
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0RFZk9QMm5HMmVqMkxsTHk3V3BhUldYeTBWQ2dscEEyYTgraGttTkNMTkJC?=
 =?utf-8?B?UElKNG5DOE5tV1RiK0lVSGdEaUpLTXpCSWVnQ2tHd0Z5d2NEaGxHSnBHUmIx?=
 =?utf-8?B?SGhkWWNSYWFoWDBubnpzdmlxWDJaYXczUkpqOVdnZS9nVWJxZDc4K1ovSllQ?=
 =?utf-8?B?Yll2eEY3T3JndXpvZHd1NHd4YlJCODZZL1FLOU9JZU1Sc0pnL3NCWUJUSFlM?=
 =?utf-8?B?MCtjdHFzcXk4dUNlK0t6RVloeWc2d1FKZWttTThkRVlqbHMwZUFRNVRPSDhI?=
 =?utf-8?B?azlHeU51bXNzMVlDV044a04za2lIaWIybmNxUy9CLytEaFVJTWJ1elJCWnR0?=
 =?utf-8?B?VVN0eVJlS2RQb0wxYmYvb0JhMG43eTZ0cWhmcWl3bWNrc0JHc2l1ZHVOaEVH?=
 =?utf-8?B?MnFRUkVGWUIwc2VzeXBuZlYwS3Foa1MyeTgyRmtRWFdoaVhpVFEvd280WGdJ?=
 =?utf-8?B?TkJGY3gxZzZ6ZzdBMkFiOWZ1YVFFY014M3JUYmZKdkdDUjV6dGpDYTlsU0l5?=
 =?utf-8?B?dVZDV2lsQ2VKOHRpa1M2V3NMZXBrUzIyRnZJVXBRQTZ5QlpuLyt3UFJBNEkw?=
 =?utf-8?B?b0RNN1ZaNmJrRlhrdEJ6Ym1FR1doZU5lS2dpNjFxQlZ2bVhZZVRpMlYzS1l1?=
 =?utf-8?B?dVZvbXUwWUlFeDF4bU9RTkhaK3JzNHpGVFNXcWRXOVhnamNiRHNVT212U1Ry?=
 =?utf-8?B?VzlXM0V4M1RtQzFBNG9zeGduZlNhWE1BTStYcVlrZVJNbnB2MndaVGJNOUcz?=
 =?utf-8?B?L1MrZENlRjl5QXoweTI3Z3dHTFQxWmpYV1hpT3NtdWp4cG1NVFVINzR5MGQ1?=
 =?utf-8?B?RUxRbllzT1psZDhub1lEN1JLSFdROEhkcWZZYU9kd2NqaGYxWGhtRHhvWnpD?=
 =?utf-8?B?a3RRd0ZCUndBYVN2d3lIRkxqb21CcVV0UUxhU1Y0MEdQRkpuQ3RQQjIrMFY4?=
 =?utf-8?B?S0QycERkNXFqRDROeWNWdXpqTVlzL2lkTDBsVEJzYWRwMkpHWnNMTWs0QTB2?=
 =?utf-8?B?aEVqSjlSRDcrQWZyS2ZmQUpPQXJ1Tzl0eUNpT0pnaFh1aUdmMmM4YXFjV3dD?=
 =?utf-8?B?eWJTRkZpUFowK3cwVjFXclhPcjJINXY4NjB4WnNmc0hUTmhzUmpUNDlhdGhu?=
 =?utf-8?B?bG9XN3RxMlUwVFYyZEVBT09RZ1M1aksrekRreTJvVWloRldHV1dhQnFUOXlo?=
 =?utf-8?B?ZCtvMkNBRTBJYnh6U21FYzlXODVYalFVelpPUWJxMGJvZy80MVQzQnlWcGFs?=
 =?utf-8?B?V1J2WmNkSkprTkhJczBUdVdoZ2hBakMwN1lNdFBnNC9qM0pQNDlITWVzWUgr?=
 =?utf-8?B?aWhNY2dPcTd2U2VNTmFxOUtmSHlrdGpQd05BYjdLSkFVMXBVM2xzMG5TOThV?=
 =?utf-8?B?Z2Fwc2k5MEN3S1JtaTA3akpQR0FKZGJ5bnNMNWN3d0d5TWUyS0dGZ1E3L1Z5?=
 =?utf-8?B?QXMxdi91RHNLd3h3U2liSnFIK2I4SDZ4OFFLdlozYW8yY1FKYVBKNzVldUZN?=
 =?utf-8?B?YU5GSFRPSEMvaGlQcnNQbW4rb0MwS0l6NG82RTJuTGRzNndRckZ6algyZklv?=
 =?utf-8?B?VmhEbkZsbFdiTkN6VTlUQmhKWlBtaUZDS2RRNjhlNkFvWkx5ZlRCWU5ndVpW?=
 =?utf-8?B?dFVHcWJyRm94aXpwWnZOc25oYVBva3ZsMHIrc2tjQ1dQUzFYUERzZHJrTzZl?=
 =?utf-8?B?NnhqVkxPV3pIM25UNnVFM3VVbTdRdUdoeVFpRHgxM2htWWdPNmc0dVZYZzhU?=
 =?utf-8?B?VUN3Y1lVODBxR3NPY0xaeUZub3R6RkFJVStLQUhxMEMyRW44ODFoaW10WGo2?=
 =?utf-8?B?WkFsS0RGVlk2cm1Dam1PNzdYRzVmVVpjMk1Vc2w5VWt0NFh6eE9Xd3BFQjVO?=
 =?utf-8?Q?gw0XCgrDRgEo8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmgrQWRsRnNjYlUwSVVkU1l3Y1dXbkFiaGtHZFRDbnJHSFJjOXA0YzQxWkI5?=
 =?utf-8?B?Y1B6c05SWlpKYkV1Y3RMcU9ZUGI5ajhyL0g1YW1KWTVNcngrNW1YVDAyaWlI?=
 =?utf-8?B?VFEzMHg0QkZORGVzUHpHZ1BqWWtWekdFaHhYM1hCRjNrU3NmMlFmQ0V4MzZW?=
 =?utf-8?B?N0k2UzBLVnBTMVh6VnJjb1EvOGVBTHZqT1B0Nk9MRmNZOHRPRkl1MFlwamV3?=
 =?utf-8?B?cWRGZC9pOUV5WGUrMmtTSmp1cjhVZmlPWnpvVWpFdnVGOW1HQ3pjZ3JyaGpz?=
 =?utf-8?B?SkVuL1Irc0E4UWVpdkd6SFZPR2JySnkvRlFWb1ovQjBaSm16M0t1MUJ2VkZT?=
 =?utf-8?B?RXNRdXpsU0JiSW5hcmx6U3FtY2ZFMzMyYTVzV1I1aytUTHloUFMwOUl0WVY3?=
 =?utf-8?B?QjF2VXI2Q1JrY2RzT1dDdXBxU245WG5telNkc0FEd1haWHR1RlFDMVd6YStm?=
 =?utf-8?B?ZldWVFpIc1hzQk5XTzY1SW0zV09nOU5TN0dQVVNKOEpXbEk0VTNlQUVDQTNo?=
 =?utf-8?B?TzZDTjRVbEFuNGJKUFBNTWtHZGwvSjVNTVY5UXR4UU1vSndVZWl4SVNmZnFE?=
 =?utf-8?B?dTBrSi94TTVvSGRyZTIzMm9ueUgyUFFzOHRIL3o5RWJxc0tWOHU1ZzlEbUQ4?=
 =?utf-8?B?ZnZyVkovQUF4UUdwK2dNclNyT3VWc2RVcWpXVTZSOU5yYnNlNjBnTzFZcDRR?=
 =?utf-8?B?KzV0T1hWUXRJcEV5aUNZWkNIUmJVNkRvNjlKczhPbXJaU3NEMUNmblRLanB0?=
 =?utf-8?B?Y2ltZUVrclJobWZ2cVdrTnBibDR3Q0RKcFBoWEZxZWJOWkFhcEhZK1V2UG10?=
 =?utf-8?B?NE8rL1JTZ1c0OS9sbHk0TXk0V0pjbndmYlF5VGdmeGg3SzVUdkFyTjkwQkJR?=
 =?utf-8?B?WXNjeVBVOXhPQll5Qm5KU0xNbmxoTTlRM002VWhZSDhPbFp0SjFwbStMMERn?=
 =?utf-8?B?enRuL01pUWlzYmhPdVR3dk8rVkhrWjduNXdJTjB5RkpJRSsxT2dJbDJYL1U2?=
 =?utf-8?B?cWZLNHBYaTVuOFhuQnQzbFplaU5lb1lOMDlqaDU0NDlrdmp3NlhDQk4rTVJ4?=
 =?utf-8?B?WGF2MFBTMHI4ZFJoQ3lMY3hFTzlxQ3ZXcXJoczM4WEJQOWk4S1JYa2Jscncw?=
 =?utf-8?B?Q0NIZzIwZE1ITkdYL2lwUEdkRlg0d3ptZUh1VS9FR3ZmMDdRNkNvOHZjbmxp?=
 =?utf-8?B?L0MybDljMkdiaVVvMUdhcGQrckcySisxM0VDMHFzdVhGd3hoWk5xY3pBaUcx?=
 =?utf-8?B?ZFk2WU1ldGt6WXhsNEhYY0hQclRKdzBaUzdPRmhscGcvSlFIcXp6WEFLbzND?=
 =?utf-8?B?YmE3L3B1ME5oNXA5YmhBZXFvYm1lWS9JempRMU9lMkNuS2piUjFwcEdsZlRB?=
 =?utf-8?B?QnV5bzkrMCtyQUpieVNvLzB0WEZHaXdlWjVBOG1KR0RqVVJacFJEVm5Ib01Z?=
 =?utf-8?B?NTl3cUVpMmRNV2FCb0xpVCsrUTNHT2tFL3MweGhZSzNramJyVVI3T0NWdlRO?=
 =?utf-8?B?bXEzVDRjTlBQT05HN01XSVRDOW83eUlISC9wS0VzOHBNZHFvVzlSa0Nic2RT?=
 =?utf-8?B?aU05YnVCZ1o4MFh5V2hUbW5SQTVqTHRwUnZBU2JmeU9DWkNBYmw2bGY2c0Ju?=
 =?utf-8?B?R1Vib2RUSy8wUGFwVmE3ZkpKSW5Lc0VWSU42VWpMaTFNUDZNZWZEVlFKY3pk?=
 =?utf-8?B?RnFWanY3V2xhWnk2eTZodEI2YTBhTmhhTWVFUmtrWDMvOW5qLzRCZlVYSmFI?=
 =?utf-8?B?Q05sNXNtWWRNMzNZemhWZDk0M3ZBaDhzN1dQK3lwZzlkdUd4Q0Fua05KVHVq?=
 =?utf-8?B?aFRwUUxTTHMwZmVoWnlRUGVWM2xtVkFqZHdiWWZseW8yTVdXMXZiL0Y3Nytv?=
 =?utf-8?B?ZXIzRTBQTUdIQldQYmE5YUlzUDJudmFXRDVlcUQraDErcjlZMjFWSGcxaSs1?=
 =?utf-8?B?azRjSEk4cXJnNU1UeThUTU91VTNQeDlTYXpBTFFhOTNtcDM2ZGNITmpHSlNh?=
 =?utf-8?B?bm9jU21HSWhLUVJEdzM5TC9hK2tJVGJBTzJKaWlzbzcrT3hhM0lJYTJnZmV4?=
 =?utf-8?B?WDNaSXVmYkJ5N2Jqdk9QWGZYeTl6SDA5OFowNTFsVnYzRFg0L2FBUytvVnhP?=
 =?utf-8?B?Si9idFVNUURSaEVuZ2ROcE5iUjJKQ3JtRDd2Y0lFWlRRWTFrSDJxQnduVWcw?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4a22e5-9984-4905-e68e-08dd514c6134
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:17:44.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3y8aqffsAZmgxn/q7C7F+cTF0dIkxQXaqEqp1rCY8yjkkJjEx51qO+fL4RoTOKa85mTCANibMnb0jdxMynfND7+GmLdoB+6JK7SUBhvjOJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> resctrl_file_fflags_init() is called from the architecture specific code
> to make the 'thread_throttle_mode' file visible. The architecture specific
> code has already set the membw.throttle_mode in the rdt_resource.
> 
> This forces the RFTYPE flags used by resctrl to be exposed to the
> architecture specific code.
> 
> This doesn't need to be specific to the architecture, the throttle_mode
> can be used by resctrl to determine if the 'thread_throttle_mode' file
> should be visible. This allows the RFTYPE flags to be private to resctrl.
> 
> Add thread_throttle_mode_init(), and use it to call
> resctrl_file_fflags_init()  from resctrl_setup(). This avoids

"  from resctrl_setup()" -> " from resctrl_init()" ?

> publishing an extra function between the architecture and filesystem
> code.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



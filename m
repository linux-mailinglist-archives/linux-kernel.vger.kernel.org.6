Return-Path: <linux-kernel+bounces-550454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6249A55FC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E0C18937DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE85149DF0;
	Fri,  7 Mar 2025 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7bIchuo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA78635D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741323912; cv=fail; b=OKYY4b1LfyuGvuUbWnXw+OtXVHu7Cc/LMsI4eSreRaHxX6Fhtl/Hwt8vp+UR5j+zdXmMzHAMadpeWeo+LbnJUk6wn81ObaqRbUNib4wcLF0cKfb9L57iTShBCnd2opdC1K7oLErCll3wyxlTo8smFqb3jPCiJIBySFO4z/PbEvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741323912; c=relaxed/simple;
	bh=6dbOnkgZfuuzhoXRdZHS6MisCEFEhuu87uPc1xJmg7c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVWStAWJOXu7WRGnayFX5lp7zHEvCh2iG67IHu5RotfZXu6Gl/s58gkFiARpmY4QIMRxqeOJVOG/kZgDvZ6znbocN3g91QcVZrumvttM6KCWh1WeHvfzjqc+WKpgulTgTJCDg+RlcdudY3Kk5WM+fRpOZ1FI2piHa+HBpOUZfvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7bIchuo; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741323911; x=1772859911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6dbOnkgZfuuzhoXRdZHS6MisCEFEhuu87uPc1xJmg7c=;
  b=V7bIchuohjrFSdAb7qA0F7izo9i79aPAWZH7l5VvK+hV+b9bfvGEFjoz
   TpXJnANlFkm1FFcdViaLLUv2BrjWlK94DdSKz5GHth2rr2yxSd/FxoBAi
   Ma1JH1YmfJQGDr9gaYD7VPlWrNOeoerfSa1qLp9O5DPHauYZswvC2mvGn
   blATAvqajrYKW2MNXIKydn9jBhgrzzjoj5ogWlmSlffUFYaCFjXUm0Qov
   4de6jxYYTrN5PLktyXmdeh5yX8iSbEeAA4tKOwjJtfGxZDDFUJZ2Fnw6O
   wmpe78LHQzkfR3K7ztIs6kC7vNbg/lzqJRK4VUJQc2V4GQM5uTXHHqvTr
   g==;
X-CSE-ConnectionGUID: dY2hWqwET7GWEDjcCE/Zaw==
X-CSE-MsgGUID: E334RK1vSiCZl4N/fs+uTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53006130"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53006130"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:05:10 -0800
X-CSE-ConnectionGUID: ZZQwMPKnTNOaiFFEe4l1qQ==
X-CSE-MsgGUID: iw5u80g7T1SgHO4QNoXjfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119150596"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:05:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 21:05:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 21:05:08 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 21:05:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t81F1U7+FOIouykZASBuVSYDFTW2FXJVITuVfaDSmc5Wvw9A24eyGmfp2Ux/AA89iMhElG0TZLkM1eY/aS6lpKxXZIHEQtxqFQ/YNym2CPfNsRrBROaMYX2gKiMZ4pCP6liA8wpzK+U2ereGfj+EaLtFcuskEZlE6SuU2H72ye0EF+M5Jhp6Zs3VOhwWewIpsyWJaIzsfmYK6kxfs3tB3yksctyniEnfqrChgiuyUetAbKkbnHJkBuSlvA/8hIYtucVFj3EmBj4umL+muQPpwn+DmwMsiFsHPM5TTy56xqAZU49tYIwQl2STTdPzc6YwFdBrAMiC5pVQLr+Pk7bpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iR01Y3TbxvOQd0OHAvVhRAepL2Tfn7a/NEcz346F86c=;
 b=eqBg6Iel1hnUA8KUHwcW1Y1XPEi3W1dJK0c4kK5hKawdjjTV3Ai6rdKsgSHjWKu9M1Uihtn7u1qw0eIRyO7cPo1LhZ/Km6luGGIjWG26BjMgAyZeWWYAc7YNK5DmQbiFwJ4Hpo7mRsBtqoJYyWKEP9E17cRFbJzNpUPR+ZOz7V3z0Ktzb58iVx3QgaOPKo1j4Qk/9ugBqHDovvItYRwMjQ+7TwQa80uvSm5b1pmBEov4SHyMYKOHG2tARBoYf1PvskRaQHBYXLhw8ltyvHPzEO7tHYuXDCaOrlvp6zrGQ7UybbXzXrXg1zRRVUeRKdTdenfyYJoW3vWVY4i81baxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 05:05:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 05:05:06 +0000
Message-ID: <d520b762-29dc-4fbc-b1fa-aab9ab38dca4@intel.com>
Date: Thu, 6 Mar 2025 21:05:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 40/49] fs/resctrl: Add boiler plate for external
 resctrl code
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
 <20250228195913.24895-41-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-41-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8381:EE_
X-MS-Office365-Filtering-Correlation-Id: 46283505-3919-4439-40a0-08dd5d35a068
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUQ4aThUKytxbEoyQ2daSmp0WnRmWWdLV0M1WEZnM09VUFJrYk1VS0RWTjBL?=
 =?utf-8?B?NCtwSis1YUx3MVltbzlrVU1HTklkWkVlb3ppMFV4UGY1ZXVkVGZRQ1lNYnMz?=
 =?utf-8?B?N3VrV1N2Uk9uUWJpRzVaSXlBWGpqa3Rxa3ZsN0tvdXdXcUFFQWNBbXozUFRM?=
 =?utf-8?B?Z2VJbzNmNStERjJNRjFQTVlBOFNWbXU4YkR5N3ZVT0hyQnNHUjRkNmowM0lO?=
 =?utf-8?B?T2tndndaR0VSRUh0SHdkTmlSTXlYWWlpSG5GL1Q4NUtibm5QSjZ3TkxORVFk?=
 =?utf-8?B?M0lEayt4WjRQcmdIbUV3cW91RG5ydHd0dlB5TlFyNkVXSEtPK2JjWk5hT0cy?=
 =?utf-8?B?WEVFczV3SnhqdVdnbHIrRGNvVEd6am04bEJqcGdXZzNHK1g1bmNCVzdHU0Nz?=
 =?utf-8?B?N1FIMjFab3I3VmYvNkJtY25UK3B5bkdLL0Z4azRuZmtnSlFTeWQyOFAvcS9G?=
 =?utf-8?B?TXpwNFJUelIyVmdDYmRCdTdKRlFMalcySU9Cell6NjdZSk95MVAxRkJoSUFY?=
 =?utf-8?B?RWtSVERTdHJZQk5hbjJ4QlZGc2ZDWlQ2eFFKSmFhMWdENFhXclFWOHBIelN5?=
 =?utf-8?B?R2x5WllPU0NQaVlhbzBvM2FMRVUzSzh5RjgzVHhPZnlXQ0paWFp0OEx0NHp6?=
 =?utf-8?B?Z3FnQnJHZm5mWFg1clRFakhET0hOV1dFMXQ4L0MwSjh1aXNlTnUrTnoybGFC?=
 =?utf-8?B?Rm92Z1hoa3I4VEFBUGYvUkpib1NodnhpU3E1SDB3T25oRWp3dHRENEoyeG5t?=
 =?utf-8?B?WjBwRVArb2R1TWp6SXI4TGplT1FyUnErN2ptS2tqcTgwSWxiZS9WNnF4Z05F?=
 =?utf-8?B?NjliVldDSFhtak9HNU5RV3VUYTkrTXFXOFFuN2F1Y3cweEpPWHR6M2hLWHVo?=
 =?utf-8?B?UlRJTjhwL3BMNkJPdmxRU2xYYXdXTC91RHpXdHpiV005eG9WQ2V3VmlVc3V0?=
 =?utf-8?B?YkV1V05kd0M3ZGpJWUJwMGNjdTIyWGdhM3hFc1N4Qm9PR2x0TFJYUGtBU3hQ?=
 =?utf-8?B?V2dudU9iVEY2SGErNGlWQnk0NWpCMnBnZVdpaDA4NnEvcUhFMS9KV2hXakli?=
 =?utf-8?B?czZ4N1JDNFZmWHliMFI5eVU2N2JrdDBpcUpHVUN1TkQxeUlpVXRsUnlScDV4?=
 =?utf-8?B?RWJlRmliRmUzYXZyQ3R1Vk9nWTBBQnlERllyc3JCYzdQL2xNZ0JDVkpkaUJM?=
 =?utf-8?B?ZFFZTTRGRTlEYmx1TWtIcnRuVm5HVGtCV01JQmgrZ0xVN094dUNwN3lQd1ZT?=
 =?utf-8?B?cTBPWEJER1o0WWZ5bi9Sc0Z3aWgwSk10Y29xL0sxYkVMZk8rQUxhSE4wc3hz?=
 =?utf-8?B?VXg0OS9EN0xSbVVJZ2F1ZVNaV01sV05BR0VGSHY5Q0EzeDdVVFFtMVdnYkNQ?=
 =?utf-8?B?ZWhCanZSZU1ZbFJZSEtSNkdOOEJsUStiejhJU1Z1VTNYcGVHNzZqNXZYZTNa?=
 =?utf-8?B?SEE4elhMOVFJaFdTaUFMckdzZ2d5emtvR1pYb3BBZVR5dFhIaHNzM2Z3WHZa?=
 =?utf-8?B?UG1QRTk0d0ZQNUlMUGplQ1REMlhleHpvYXRZSU91M2tkSVNiS0t3NS9QWW94?=
 =?utf-8?B?M1g2dDBGTVQxcEZKc25Jb3JpejBOVHhSeGRGY1NVV3VBZ0lzek4zejFmdGpU?=
 =?utf-8?B?cFdKU2Vwa2NwL09nR1Z3dWgvdlVnYkhieVlucUNXY2sydnY0bUNVQ2x1ZzNo?=
 =?utf-8?B?dUZDSnU0Y0g0UUt3bmtmbEtWa2lwZnlwL3o0S0RJcTFkekp0cTVjRG1OaTR3?=
 =?utf-8?B?dXhPRWNEeUpyNklyVS9VZ0d0M0VnNU5TcFcvckx3YWNzdEJ5dlk1OFhIV1BU?=
 =?utf-8?B?dW1tYVpudENjKzV6OGVSQklYQXowSTdmOThNOEVITGoxb21EUWZvN09GVUVj?=
 =?utf-8?Q?kXisDK0meL+OC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG9Mc1ZFMjZNZW1tSFRIajR5eWJiNXMyU0QzR0tISVVQM1QrM0tNTkcrbGFk?=
 =?utf-8?B?eEUyQWljMHhpcGVzTUw3WlZScXpmNUN3OUszMWJrTmdpQ0dDNW1wU1Z4KzNG?=
 =?utf-8?B?WGRQa0pITEx0VXV6TGpsN1pmenFVNHdURkV4TjZnSDN4eWl3Y2tueW9BOEhL?=
 =?utf-8?B?NjhwWFJoZEdHMXMwejVIZkUxcXc2VXRSMXpabkYrYlVmTjQxQVZ0WWlwNEEv?=
 =?utf-8?B?b0s3a0FwVmxyWUF1MVAwMFFjSUxCZzgybVJ5SEltUW5ZVmZsVkZTZnluYXFa?=
 =?utf-8?B?eXdpUi9rSmlZaWtXUmNkenJSYXFTWFRMYUNlOTBYVzlGMUhSVTgrc2JaRGRn?=
 =?utf-8?B?bmttTlhWaFBZODRrcGJJYmw0Z25QeEk1WjRsZEJKZEhPL0xQRmlaaE5YdjB4?=
 =?utf-8?B?VFVSR0ZIUXNuaWZpd2UzSXUyVXUxL3pvQnI4L3VkT2RsNWhFMXRoNGZxUEZr?=
 =?utf-8?B?YmR4L1BwWFRhQlpCK0VCZ1B3cndXOEw2NHIydXNZb3RRYldTS0d4ZDE4Qkwv?=
 =?utf-8?B?QlpsNjNjZ1ptQ3Z6bEw4K3VSejdLT1lSbWRVV1ZYQjVFZ0Q3TXZkN3NyckYx?=
 =?utf-8?B?WEo5SytzMk8vcTdZL1JoU0pGZ0xNRFkvTWZaT3E3RENFcVJBRm11WjBPT3JH?=
 =?utf-8?B?ck00V2tDU2RGYWcwS2kwajVIS0RqenBIRjZoV3BESzkrdDltbzB2aWRMVG9t?=
 =?utf-8?B?RmVBRzlmVWJjWkd5TzVDWGpGRWJhN3R0YzRId1V6OTA5YVZ5MlZGS3JZQ0xF?=
 =?utf-8?B?Vk9zSEI3ZXZUNmhRUWF4MG9tNGpybFdkZnRtZTVUeVRDT0ljL3hPUUx2Zk9X?=
 =?utf-8?B?NHFZOEM0S1A0QU9jWnZodEZGTElMNUFrY3p6ZDVRRE10Z0FBaXFqQWdFT2dl?=
 =?utf-8?B?dmdzekZTQmpBdzcvaVVBUkc0S1Q5RFByUXhKZWUzSDhjcVNkR0tFRi9Xa1pt?=
 =?utf-8?B?RWdyMW41b0xLSFU5ZnFZcnBycldOanJwVVJrWEhOTERnUTNTTmVjTCt1NVIz?=
 =?utf-8?B?ejFwWXZlL3BIa3JXSEMwNHU0VFJNQ0RncTBMVHU0S2ZUUmJ5RDdqSGVVWnM2?=
 =?utf-8?B?NlhSUjZoZ2tHQm00Y2loVFFJYkJ6ejVNbnlNV2pUWmNUd1E3THovRk1iUkpo?=
 =?utf-8?B?OEhsRnFSbW9paUNTbUtHNEgwN1plZS9jaWx6TWQweXhrMXE3eUc1VHM4eTZk?=
 =?utf-8?B?MGZVcFJzTGFCNWpHRXB4SENUTlBBR1NiSk9LbWZFOHF5VWdTenpqS05nLzls?=
 =?utf-8?B?U1ZmMWJNYmpGSXVteWZWanBhbWJSVW9nN05lU2x4MFNRQ0hxM1BkU0xmMFNo?=
 =?utf-8?B?dmRIdEtSQk5iRFRXWVFaWGRBeWE2QU15R1lhR2FTdm5sZTd6WWtId3NEOE95?=
 =?utf-8?B?ZUUrMUkzQWtJc2twYmozTWpnaEV0cGFvTG9SbldySk9nZnlPWE5ucFY5THBn?=
 =?utf-8?B?eGpobEkwczIxTTFIdExGUWlVQjRKZnB6bThWM2xoNDJQVnVjc2tqMWpNZjdx?=
 =?utf-8?B?d3VJMWlrbzlwRUhqWEFVOVRWeGZKNE52VXJwbDZ0SzdOeU9uSUw5dnhJdWpa?=
 =?utf-8?B?aHNlUVZ0aTU3MTZ2Um9wbEpQSExiNzdxNmdsM1lpM2hZVXg0STQxRTMvbGVt?=
 =?utf-8?B?SFQ0MFhwL1dCWUF4bHdVVEtQOUFNbkVvbS8xNjRZNkNUZmJRZHZJRytJbFVO?=
 =?utf-8?B?QmZSb0VtbXJNbHlHNEhzSkxzeUdsckc5U0dJQ0U3MEh1dE1BYjQvNG4xMmdp?=
 =?utf-8?B?eFRCN1NrSTNlaEJKVWVPOEZKWEtsZVZJMmFBRWtEV29MekZ5dk1neEh0V3JX?=
 =?utf-8?B?YitlVlVwRTd6dW1hS3IwMEI5d0JGTVdWaTFTR1h3aTMyUWZSWnMrUTg2eFcz?=
 =?utf-8?B?MkZmOEcwTlByK2s2eHNJNERMWTJkWDVGWW1QdEZmRW42azNsK1cvWkI4NHlN?=
 =?utf-8?B?WklDSDZ4dCtSSlV0U3pKbFBWVnBEeFNkVlU2cXM4bG9CQjJUZ2c2aVpnc3hw?=
 =?utf-8?B?Q25tSXhIaDFZM1RmYld2bk9tcFcybUZ2bExyYXREb1oweWNyYk1zS1VuaitX?=
 =?utf-8?B?ZUtMdVJSaHcxN0gxazF4dmVucWFrVVFwcCs4MjFuenA1YWNFT1JEQ0JCTmI0?=
 =?utf-8?B?SFZnbitDQ0dmL0dHM0VXVmlJd1l0WkF0cE5TRE1lSlFqbVRhWUpqT1RESzR4?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46283505-3919-4439-40a0-08dd5d35a068
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:05:06.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSPV1BkyCu1VwzO8yfPS1Q7hZtRLnsBz354YLaj+xshLLiH9Z1rp0NpCSxH4JUP2eSfrlCvM96QjH6nsEoxg8rLVc2jwa7TU97m5IRHMjfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:59 AM, James Morse wrote:
> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> select this.
> 
> Adding an include of asm/resctrl.h to linux/resctrl.h allows the
> /fs/resctrl files to switch over to using this header instead.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



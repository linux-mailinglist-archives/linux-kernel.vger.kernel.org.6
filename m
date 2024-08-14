Return-Path: <linux-kernel+bounces-285835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176DC95134F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67237B223E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24D41A80;
	Wed, 14 Aug 2024 03:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmc4OSho"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1536134
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607991; cv=fail; b=O+l6JikybeJCPhcxCd0qCf6I+Qm8rVXRGtN/CxpbCqSHzm19tedse4r2bl2qfb89d5XvQDAXZh/RWazeKO2BiRXhT+GcG9IsOsWM1Qobozph9kq24QXhNas53TXqDsi4gG8/5XWzdcW1/GegShTGNCc9b17tKkEuieZsC2LwFWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607991; c=relaxed/simple;
	bh=XCc2TvX4OLLC+HEo5wpinSkGZT0hr3DbSSqEHEMx9Yk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d4dQiqzJARd/w3krUAM+HFAcRxeMVZ5Z+jOhfuKR0tcUDuwRpAn0DPEZN9XEnuR5pvoPEtm7TmfufS7otzRTHcP1q+LSGJQK291d1CMn5OHmqa0dxeASFzhWd4eY78dSqjOAm22XLYI+/zrW7G1K2XsBWYSeKSXpWnTDvEmTN5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmc4OSho; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723607990; x=1755143990;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XCc2TvX4OLLC+HEo5wpinSkGZT0hr3DbSSqEHEMx9Yk=;
  b=gmc4OShoi6RLWzLYg+rbB+2I6shAuhdk3ttOxU6pgudtFHHL8o+K/KNj
   jGdOIEQwuhU0sZNOYLiVG5GcD2xPEFKX2WCUHHaLnaAguqkGoXDQ6qYVb
   usr/X8qLXjMb7xx6BCt8cS+F5UPN4adiPc3sh1OYYTuWpxbvkAPg1a/Ct
   8c9Gr0xvu5Re9uFLlfom4aapF3m3HcRS2LSJYTl2LdKxFMniAjcr1rP6B
   Xu4tgsoQ5Ffjnq/L1f9doNf22Fkht5p7ZCH3+bdLvcxb0oYU1xjFr+IQh
   3k7JSRoZZ8FIX52SoJhBNticvsKTahMxs17Ho0iKZOVT6EfQHyWJZGhhw
   g==;
X-CSE-ConnectionGUID: HsjJ1lfgTO62J23NffLiBQ==
X-CSE-MsgGUID: beSLDoT/Tiu7+mV6cfEifw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25563485"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="25563485"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 20:59:49 -0700
X-CSE-ConnectionGUID: 6prN8ZsZQuS1XNdooyV3zA==
X-CSE-MsgGUID: ne/87c6DRxSd0vbQfugtBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63741663"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 20:59:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:59:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 20:59:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 20:59:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=od0Z1lekm/odzAXnKatXjBlq5Z3NWFT5BdpOZ54HvR5zWjITs0YthPP1xetra0ftIlL+pIk8mA6rojLjpl2uoT6wwW79syk+XIXyOqIbhduTv0HHG1g4/6BcAND7vrKG2y9sxRio6VJXDyekJKVNoAb04T/IFujD17FixZrf4Y3fYbUz3evXxTtjJ5YWDei4plRew2mPQcFW746C1atQOmJcyg3Ro5H7Oo61Pk9nzFqcxAsNllNT+2LGQ/zDI9H88MBaKutJo8FFbUAmFU9slRVnqwarMx2QyIz7W0F8yS2FLEbjjZY4CagI9fh5fdBlXwRd2L6ynAq+ov2sB0D9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwA+o4yrIZduSiS5eK0f4dSOFV5GyGG/U5rksxETUeM=;
 b=FqgceElIA6EKoIazSFlIQZzwec2jIBzh5w+9mXnxaZRdebEaQAC8HmbtdcC9/pCpqPg/uHS2SDpWQObkDZ7qMxRW/5ud1ArmAWlYtDG75bX2u/rNlTNLT33kzrggab/A2bUQGWE1sHUBqhSSs5AItYK/jbgzOQSWKlenPbm4exmUMefEbcTl0LGm3W3RCa9WGlZ0789JU6Or4tBVjw2Dd1ULbTEK75TQOazt3N0xriVJH4oPGF2hHaniXQSHKU+GXXOTKZ7zwHvbuXMrn5gwmVp5/MwjcrnJ8d14oQU9IOXTIocyGFlCIX6voztov9uD7PEKCjB2DvcSvX8rzGHUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Wed, 14 Aug
 2024 03:59:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 03:59:45 +0000
Message-ID: <44849590-d35f-4dcf-8744-a0472e6e9e3f@intel.com>
Date: Tue, 13 Aug 2024 20:59:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/39] x86/resctrl: Move data_width to be a schema
 property
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-7-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240802172853.22529-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: eed1210a-4391-4dba-9951-08dcbc158843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkZuOFlXaXJvdklwL2tuOUZ3WWJ1N1J2Z0wydmxwRXNDWTRmUmFzTElwbkJR?=
 =?utf-8?B?R3h5NjZpY1Z3QXltTHdUTlUzQnh3cGhwM1Q4Y2ZRak9IM2k4T3BMYXYvVjA0?=
 =?utf-8?B?R0FuOHg1Yng1czd0VCtSUmF5ZDc1UGFJajFsREN4dXNZRHB3RGFTVzVoZlda?=
 =?utf-8?B?ZzN3eEQrMm5SRytsQnRGdUp2QVdoMUx5dlZKbVo2aWc5a2NvUm9IYlh6N0lE?=
 =?utf-8?B?Z3NlenJMVkZaYUlHY0RMbzUyNnk3R2hXRng5ajlHSEliOHlxN2puUUNRZzcw?=
 =?utf-8?B?eDEwdmMwb2NUQXBmaHVNbzdkdUxic2Mva09adDMzaExtYytyRENELzJTcFNu?=
 =?utf-8?B?SnFmcTlkSkMwS04zb2VCM3M1OU1wMnBTSFBYL2hSWjVMV2V3UnlycFMzVFda?=
 =?utf-8?B?TFpBY1ZnS29lNk1Fclo2ekRjbFdVemhwakZOUzFsbWpCRlkzRUIvOE1vK1Uy?=
 =?utf-8?B?MVhCS0g0NG9jM2FaVVg1blpSWk5oZ2haVHJqLzNzSGtuU2xPeU93QlA4eWJM?=
 =?utf-8?B?UnJiZ01MV3RjYVo4aVJlMVcyRWJyTE5ST082SndTRytuMWNLS2JndkJSSXVE?=
 =?utf-8?B?SlYzUEFteWdzV2NUUmw0ZTFuN29zMmFwN3BkUElPWUR1dDZFSHg1VDhmUWI3?=
 =?utf-8?B?bHZVSysvY09TdWFiZ0I1RUJOZ3FzN0lnbWdlb2hFZEZ4amxNZjl3aUNObDdZ?=
 =?utf-8?B?M2I4bmlRa29RcStJTGtPcE5GRHlwRWVvMEJxcDNDNlI0SWltUW9uUTVkR0hS?=
 =?utf-8?B?WkxDNlJYa3YxY0ZrclIxQ1RVUzNoWDJ1Skh1Tnp1UU9mR2ZKNm1PWnRPQVZt?=
 =?utf-8?B?bEdINTB5ZFVZOTZnME9DSUNTSG1mZ2FHMEs4RW1EdGYydHl4QlZQZmUyR1hz?=
 =?utf-8?B?SitCWnJLK0pMYlZwUGttVTQySWtoMTBPWnNLMldvRWMwMkVRK0VGbC9ueE9J?=
 =?utf-8?B?allwRXR6Z1J0N3kvQXhET0RzVkFZeVh0K2RlR3RFTE1sWnVzMmFKbkFYMTg4?=
 =?utf-8?B?NEF0NEcvNFA2SmRvQkFIamppZmRQNkFlOExEZlladFlybHdmVWRYSzIzRTdG?=
 =?utf-8?B?NHkySWtITUcyTlkvUUdGZ0tVVU0yM2lOTnUxcS9HUmQ2Y2F0RU8xUjdXdnVr?=
 =?utf-8?B?S05PNFk5K2hTMENVS1BIeHpWN21BSUYzcDJlM1F0TkhlVmRlY0VxbmFHUi9L?=
 =?utf-8?B?YWJvbVFrNlp5cGdDSURtNEtjTGJqbjR4aTlpWkdWaTFpQVAydHpZU05Pengv?=
 =?utf-8?B?VXZJZ3NhQW5vQ0NVT1QrV0JueFBPQVVaSU02M1BOQkxKUEtDS2VsczRocnBP?=
 =?utf-8?B?SE8ydlBwUzhlckM1Um1RZVVOVUc0RllURUwzVXBuTHZBRXFST3JiQm9KNllE?=
 =?utf-8?B?OGdKcENIQ0dPeVFQeGhJRXEySEZ0Q1pndUwvTnZsT3cxSnZxRzVCc1RkRk5k?=
 =?utf-8?B?YjcwbmhMdXdRb3VIYUdWQzJsN3V0Zm80MXZEVUcxTDJsZUkwYUpCc0sweStP?=
 =?utf-8?B?eFFxVmc2N2tyRm1NcXlIYVZGWmxzNE5RL211N0ozbkI0Qk9YN1F0REdpOFdi?=
 =?utf-8?B?aDRSVTQzSTByNDVNekJ0MTBGektkOXdIMGk5TG5VSVJsWDRIRWpnZDJMbE9I?=
 =?utf-8?B?SlM0ZFp6cmVCenNkSUtCYWtnVWZ5UHVRejNXQVEzSURLVG4ydUdXV2pKVWNS?=
 =?utf-8?B?cnhLbmw2UnM0NVZYc3hwU3paTFV4Q0hwMmovMEZ3bGdZTUZxbW8rSm5XTGZB?=
 =?utf-8?B?YjBlTkpnUkg1bU8xT2JNWjZBQnFENDRuQUhHL1JnV29OVFQ4Q0pBVHVOcUhk?=
 =?utf-8?B?bFp5QmI1TndOcFhwMm0vQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmpoTXNBSmNaL1hKdjZPOEtibFJ5RmlaN04zMks0M21aYjVjT0ppQkd4SUdM?=
 =?utf-8?B?N0p4LzFqMU0wMGhRUXY5WVRwN2FzRlEvV0ZMbkV2SFJvOEVMS05EODNDY2ow?=
 =?utf-8?B?OTZXSzFmK2JIRmw1dlM5bGlZc0tGejJpRkx6dmNNb0o2RS9UdmVyQlBNcVFG?=
 =?utf-8?B?S0s1YnNuaWswZE54MEwycFFSNGxoZEplaWpwdWMyWkRRdDRmMEVZRWhsR1A0?=
 =?utf-8?B?REE5Witub2dkdEN2Y2VyK1ZmN28rb3BjU1Riblc3d2MrellnM3Z4VWVEbERo?=
 =?utf-8?B?U0RpZDl3MjJvOEZXVjZFNzJKODVlK0dWRXJ2WHJCWTZrUnV3aGxBVjR4eGJs?=
 =?utf-8?B?Y2JzZ3dyQTNscVpmd1dVeW9NNkpVUWh3OXZtT244NGRKQVdSRmNXS2dnZlBR?=
 =?utf-8?B?VXhDaG1yQjR3YzBnK3NBOUsyWlh5NmZGdUhYWXdQUFlwM1JXa2RzTVRiT0k5?=
 =?utf-8?B?SHhEWlVSVnUwL2Z5dFlOVDJjWHErUFQrWWs2ZzR1bjFPbzVEL1ZSeHByQzhx?=
 =?utf-8?B?Qml0aE1VLzYxYnRDYWticXBKK0ZIYkxaVERXN2JiUVE1MWVQZWJLV1lpVjh0?=
 =?utf-8?B?MTlyWXVFRkhLeEdXZmVyTFlMZU8yS2ZjUDkwNkVzNElyMlRRcWtnbTdIS2sy?=
 =?utf-8?B?QlhjaUdBVUhEWFFQSERYdG14WGxCWUFESnJWTUdBZlNrUWdlb1J6ZDV5algx?=
 =?utf-8?B?S1hiOEdkUEN3WUR4S0xGMlI2aUZySGcycWJ6Q3h1RzVqSzJiejhPYzlyZlhn?=
 =?utf-8?B?ODNSeDRndjlJOWc4NUZTVm5KTERRcFNWS3VoeXRMc3lrWENYRWMwb3lYQTFF?=
 =?utf-8?B?MGhiamVJdk5KSmgxWkI5dXY0SnRYNmpZS1hjMFV3RmZrTTAzZmtKVkJpaDVt?=
 =?utf-8?B?QUcxVU5XdHBYVmhHYjFYRlk2S01NTnV6amJYV04vOHhCUWNrYkd4d1J0clJn?=
 =?utf-8?B?amRHR3Q0blpQQXpuWXVZbFdzVnpJaFNuQ3JkcHgzcllTMHRBdVlwVGtwc3Zh?=
 =?utf-8?B?bTFtcnFDYm1XUU03WXZTWkxpMHhUWU5XRDNIdmNQWHo5UFVUcVlmN2pPMEFv?=
 =?utf-8?B?L1RKSm82NnZSSkVGUGZ1UVVsN2hFSlZJNC9IaGw0bUZDN2E3S2dOVzRNYlY2?=
 =?utf-8?B?YTErZmVZNGs3Q0E1WVZhbFJyS2Y3R0hzenEwVnp2OWhUUlM2cjcwckVnNmUz?=
 =?utf-8?B?bkgvRmFBNytOSExNd2tmYzBoWTNMVEM5d1NSRThhaURmclA3RjlCMEJIWlVy?=
 =?utf-8?B?Y3FlMFJxeUNWVGN1Y3JiRndENFNyMTU1b2lOQ0dlN0RqK0hOaWR6elFldVVQ?=
 =?utf-8?B?NWMwcHFxZlE4UHZ1V2M3QzIrNEJSSFg0cXluMFpmZzFnWDhXSmNSeE11WW5n?=
 =?utf-8?B?TzR2NWFsK1Y5ODVYaDh4VlZtZjFKalg1Y2xhSCtLRC9veXYxbUs2cDUzcmFu?=
 =?utf-8?B?MzVMNkt5VVUwNUZjVjkrRGJpNS8wcDRzTDVia3ZHdzI5OG02NmFyWHFqUGpK?=
 =?utf-8?B?TXF6V2JjRTZQRWhjZEhSdUQxNXd4WnNob3E4a2lLS2JYZ2h5U24vZkdsNWY3?=
 =?utf-8?B?Vjc4djlGSGpEMU9pbUNvTk1OL2dtRHNPU3ZFa3FJNzJ4dXNBWXdrTmdYMUI1?=
 =?utf-8?B?R3AwbFcza0w2c0tNSkJyaG5xL3YwOGNVN1NqSVdaUHg2UDRicm5FOGs1RnBt?=
 =?utf-8?B?V3huck82YnpHeGF6MllTTHZ6OTgwUHYrQTg2V3pWdE5JYkhjQkt6THp2cmhL?=
 =?utf-8?B?OXJXZldWSWRkM1l4aVVHRGlRU1k0WEw2WitsNy81STl5NDZzRDRYQnM5TnB6?=
 =?utf-8?B?d1dmbWFvbHFLckR2eDY1YU53VW5jSUJJV3dqVUwxR2tSeEpZc2VLZDI2cWx1?=
 =?utf-8?B?VVhlSXNJWDhmSHlHeUswcDlhRWRlVWdkcDd4Mk5zN2p5YjVxbFh1dDk3c2tn?=
 =?utf-8?B?ZkxzenJTQlZrdHV1M21SazJzNEVxdFEvSTNkdWhZbE96TFNaenhlMlVmWVNz?=
 =?utf-8?B?SE9Ia1MzY2ozbUw1TlVUMzBpSDJBdmRaUFd0cFZKRGFHUGRndEYxSks1T0NQ?=
 =?utf-8?B?S2hFMjNEd3l1SGpTTDdmYXdwQ0pNUk9nL0Y2bEhNUEs0clFrSE93SER6QW94?=
 =?utf-8?B?czVhT2MyZy82VXhEb250WjlMNGpvN0FDQ1l6bWxQL2NYY1RsSnoxWU1sYitr?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eed1210a-4391-4dba-9951-08dcbc158843
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 03:59:44.7012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3lG+chw/IK9FQfSqzMc8E3wst9Ga1TeivQ2P9HTdMMYiC+hRp96qqjTfS7A6BotFCnYQjB2ST30l7aBDv2RLM1+T8anlqctXi62AwSV+6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> The resctrl architecture code gets to specify the width of the schema
> entries that are used by resctrl. These are determined by the schema
> format, e.g. percentage or bitmap.
> 
> Move this property into struct resctrl_schema and get the filesystem
> parts of resctrl to set it based on the schema format. Remove
> rdt_init_padding(), its work is be done by schemata_list_add(),

"its work is be done by" -> "its work is done by"

> allowing max_name_width and max_data_width to be moved out of core.c
> which has no counterpart after the move to fs.
> 
> The logic for calculating max_name_width was moved in earlier patches,

("patches" in changelog can be a trigger, maybe "moved in earlier patches"
-> "moved earlier"?)

> but the definition was not moved.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> ---
> Changes since v3:
>   * Moved some words around in the commit message - maybe this is the right mood?
>   * Added a full-stop to an existing comment.
> 
> Changes since v2:
>   * This patch is new.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     | 26 --------------------------
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
>   include/linux/resctrl.h                |  4 ++--
>   3 files changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index f16014ee48aa..cb1d634274b4 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -43,12 +43,6 @@ static DEFINE_MUTEX(domain_list_lock);
>    */
>   DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
>   
> -/*
> - * Used to store the max resource name width and max resource data width
> - * to display the schemata in a tabular format
> - */
> -int max_name_width, max_data_width;
> -
>   /*
>    * Global boolean for rdt_alloc which is true if any
>    * resource allocation is enabled.
> @@ -224,7 +218,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
>   			return false;
>   		r->membw.arch_needs_linear = false;
>   	}
> -	r->data_width = 3;
>   
>   	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA))
>   		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
> @@ -264,8 +257,6 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>   	r->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
>   	r->membw.min_bw = 0;
>   	r->membw.bw_gran = 1;
> -	/* Max value is 2048, Data width should be 4 in decimal */
> -	r->data_width = 4;
>   
>   	r->alloc_capable = true;
>   
> @@ -285,7 +276,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>   	r->cache.cbm_len = eax.split.cbm_len + 1;
>   	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>   	r->cache.shareable_bits = ebx & r->default_ctrl;
> -	r->data_width = (r->cache.cbm_len + 3) / 4;
>   	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>   		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
>   	r->alloc_capable = true;
> @@ -781,20 +771,6 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
>   	return 0;
>   }
>   
> -/*
> - * Choose a width for the resource name and resource data based on the
> - * resource that has widest name and cbm.
> - */
> -static __init void rdt_init_padding(void)
> -{
> -	struct rdt_resource *r;
> -
> -	for_each_alloc_capable_rdt_resource(r) {
> -		if (r->data_width > max_data_width)
> -			max_data_width = r->data_width;
> -	}
> -}
> -
>   enum {
>   	RDT_FLAG_CMT,
>   	RDT_FLAG_MBM_TOTAL,
> @@ -1092,8 +1068,6 @@ static int __init resctrl_late_init(void)
>   	if (!get_rdt_resources())
>   		return -ENODEV;
>   
> -	rdt_init_padding();
> -
>   	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>   				  "x86/resctrl/cat:online:",
>   				  resctrl_arch_online_cpu,
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1ce851447923..ed06384f9161 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -57,6 +57,12 @@ static struct kernfs_node *kn_mongrp;
>   /* Kernel fs node for "mon_data" directory under root */
>   static struct kernfs_node *kn_mondata;
>   
> +/*
> + * Used to store the max resource name width and max resource data width
> + * to display the schemata in a tabular format.
> + */
> +int max_name_width, max_data_width;
> +
>   static struct seq_buf last_cmd_status;
>   static char last_cmd_status_buf[512];
>   
> @@ -2603,15 +2609,20 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
>   	switch (r->schema_fmt) {
>   	case RESCTRL_SCHEMA_BITMAP:
>   		s->fmt_str = "%d=%0*x";
> +		s->data_width = (r->cache.cbm_len + 3) / 4;
>   		break;
>   	case RESCTRL_SCHEMA_PERCENTAGE:
>   		s->fmt_str = "%d=%0*u";
> +		s->data_width = 3;
>   		break;
>   	case RESCTRL_SCHEMA_MBPS:
>   		s->fmt_str = "%d=%0*u";
> +		s->data_width = 4;
>   		break;
>   	}
>   
> +	max_data_width = max(max_data_width, s->data_width);
> +

To me this emphasizes that RESCTRL_SCHEMA_PERCENTAGE and
RESCTRL_SCHEMA_MBPS are not appropriate. Note how the minimum data width
of RESCTRL_SCHEMA_MBPS is 4, this is unexpected from an actual MBps
value. The choice of "4" is specific to AMD's input but that information
is lost in this change.
We are fortunate that data_width is a minimum, allowing the software controller
to be enabled with longer data values, but that is subtle and already
breaks the goal of "making things tabular".

I wonder how useful the data_width actually is. The "make things tabular"
motivation seems to only apply to resources that have the exact same scope
and as noted earlier seems to be broken already.
I am skeptical that user space will be impacted if this is removed.

Reinette


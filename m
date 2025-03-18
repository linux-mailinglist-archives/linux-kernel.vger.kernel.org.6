Return-Path: <linux-kernel+bounces-565419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C1A667B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FDB4224DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7D195FE8;
	Tue, 18 Mar 2025 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wbk7cvAi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841491474B8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269692; cv=fail; b=ZJ0G+Qwuhrtyjzu3CcW6Enmt14ae4RCcHWhn4+kwLztcZxpjnlzK8H4CsipPcSHkHwt/4oivzTaWw7a5gRKEinBZyICgVzKleqwIT0fgPO16xmY4RY29rIO7kp1wYfy1uI/KnsST2j4SSaKvuU7p1mlr2GMtQd4tf+R7MjYDkxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269692; c=relaxed/simple;
	bh=yFmF1rBNgHDU67oUuHm+Xvdh9pCHPxrJ4ANXyn18Zp4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cojOim6zRC+rBVWTREulqeqKjxbalo3xohcGUFWDG8wk0FVlag5nQ9Q2+Sp8I6EwpPkR7687lhFMqKANld+jZ5StSr9OPoqaU0OEE5HaMiQU0GGq3X29hMhC2mbvYyD8v9YrjH63+KqayEeN/RieexzS7NDmIUroYNh8XDpYA3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wbk7cvAi; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742269690; x=1773805690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yFmF1rBNgHDU67oUuHm+Xvdh9pCHPxrJ4ANXyn18Zp4=;
  b=Wbk7cvAihgI1DbiiNg1ypDByNChjGtMX+AvaABiwV1DI3PjWU1Hg44DR
   x3iWtQUTpfyWdZ4UOHXPt8SZMMMJLXENyF0SWMlnqKZbN+/7wPFRYvO6Y
   2aBepuESI8js1eDL0Np9W56v4B8dG/WUy1PZygEtenr+V13vyBR7j1//F
   7QmLFmJcxbmOdQwzCh2Atx2pQfOCLQNLMSXXHTtcqXCKRqvaURJFGa7s9
   RSC6a529ZMeR48xCRrqhP5LdemctE9OAyVzNfAp3i1Idr/vmSRe5xKNH3
   S8M6t3UhsCmK6jYoArBdal7/PCUba0LLjUmkh81qy1WmBw/kY30R6JGY/
   Q==;
X-CSE-ConnectionGUID: OAbxm1tNTamo7AzdzrbZ1Q==
X-CSE-MsgGUID: mAMDr7VHQcynBc0tYQpOXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="30975411"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="30975411"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:48:09 -0700
X-CSE-ConnectionGUID: cy7ZZjbpT5ek6I8rnyhicA==
X-CSE-MsgGUID: 8m1ZhfDOSCylm5VmszU/Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="122074495"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 20:48:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 20:48:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 20:48:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 20:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJ97Gh//lkoAOsYRiqydcQbRJ9LvE5C4v1w0xL8wImcqUYfJbpJJ/cTskWA5YbC73gTziJfX1oKXz0lD0wqZaFlNoB7mxGAMbxR4p34bIZh/4Efcsy1AJCZ4b/tZs7bWm08f9m481CuZGany4YiSoNX7A7X7S7s99ed/qVajPiG3KiolWmgnH1YZ0NojvdZAteSlllJwxmIeMyTDVDWmY9LPxFzJRIrQe5FKkqlHGTh2z6AKYaTJozwjQNx9sq33T5EtJAT/GtlvDCbLEmmFktgbQZwqmyEAnqHxwd5j5mW7LEd1Mj7wsKN7gy/jEhq0awaCM79A71gI4xoHATZE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nnnsm/aTdHW2wuimfx8/sGEKLgYSu/2pbjGbjDYCUU4=;
 b=ywjGcWQaqsyAE2TxrxVFVhPVts2F93x+dacDsQLq8o4X1N8yTCvehnd3zkJZ5ZNTJQi2pKrwyTOR2Njyxhl82zyzIKyLJVrDh+rq+shOGzpRkVqqzWgmEl1nm6WDYX1BcXvCW5N5BGTQGmcDbk9DCcYyWbxqbLEhki588wr4jPJUtY9a7hOZVyfhmMnKn1MOqRct5nHoL7d8mPUBUBUu20qFf+pxtfIshGJk44gwFbWy69RVA8JQu+jhxPfr2znFRKD63L1j7iAiqmb0biPpnGdjzu/BLTqbMCp5mAuGHCj8Citxdz6zSH0idKupoKMdEToEjBH7MeX3MTGoKpd9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:48:06 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:48:06 +0000
Message-ID: <7a160eed-5c27-4216-89e3-14bf61e1d2ed@intel.com>
Date: Mon, 17 Mar 2025 22:48:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, "Dionna
 Amalie Glaze" <dionnaglaze@google.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
 <8e188239-44d2-42ad-9fa9-b46ad0a5b5bb@linux.intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <8e188239-44d2-42ad-9fa9-b46ad0a5b5bb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:40::22) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|MW5PR11MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fae92ee-b932-4984-922c-08dd65cfb0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1NwQXVNR0NmbzFQQ0t3SFlmVlJTMkkyekVqMm5aN1ZPN1FXVVQzTzlEM0dk?=
 =?utf-8?B?Q25VNlZ2V3RwYzJsNEdqdXc2ekVkellhTm85Si9qTVpLYWpUT1VEZllSM2JO?=
 =?utf-8?B?WDhVb2g1QTU4OFNMVVlLUGlKdm5JRFdHTFhsc3FLQ09DRGxQc3pOeW1LL3pJ?=
 =?utf-8?B?OTFNOXVaRjdhb1dhQnV3Slp4NUNDRlV3VzBuRlY0UkR4ZGpvQmszQm9YVEpa?=
 =?utf-8?B?N3dGSmJKMGJBaTdiRTIxd0dFVCt3T0t3VEFqb2ZucFkrbUNUQ1FsSEF1SVY5?=
 =?utf-8?B?Y1B1K1l5MCtZVmIrUTVPM2tYWXE2Zlh4UlFubVhWN2taOHpPTWJUVEhGaDla?=
 =?utf-8?B?Ymo1cThzM0Zzdm1EZTNWcjUxc3BaSCtnOXNPdnV1d1BEck1wMk9ucGNkQk02?=
 =?utf-8?B?MUwveFJvcG5PRitzTG9jemx0WTRrY01neVNSRUpZWFZ6d3dQdnVrdVYxeURX?=
 =?utf-8?B?elprVmdrTWZGOUg3WllDckZRVUtXOC82RUJPOWZiOXlvTkREQ2NhVnVQc1hn?=
 =?utf-8?B?Rlg3ZXJZRFhQR3ZUaXdrcDBVbExUNWtiOU1KYWpJSlBhSTdiMFVCK0I1MFRT?=
 =?utf-8?B?Qzk5R1huc1pQQllhOGtDT2VTVXFXcHNKeWZZYUJqalQvbHVrVXpNOS8zZVpq?=
 =?utf-8?B?N1RGaERGWXQ4SDlUenhrWVUrdDVKcjh0TGpWaDR5bE8rTDFub0xPM1NYc2pI?=
 =?utf-8?B?UXp5L2VGUGVNcVRNc0ZxZndQTk9OK3o3UDZrejdGVmhRanBsWnRBbGVxQkVN?=
 =?utf-8?B?MlBlRDNOT2tiaEkzK0ZFWDYzVUIyWGRtc0tXR3RtYmNxMXhDYnIvdmR0N1I4?=
 =?utf-8?B?TERRNU9MNkNKZThZRkdIQW5TYzl2S01aUS9IRFl2cUNiaU5DVm5nRDI3Mzhi?=
 =?utf-8?B?bnRUZkVRRHkxbFozZXVCV0cwemhMMnF1eUlWdmVDRTBEWmtCcDhzM1lIYkd1?=
 =?utf-8?B?cmM3OXRuY2xKZ0tsZEg2Tmx4WGNHWDZ4RGcxOWRHbDJjelNia1QzdVdqUUdj?=
 =?utf-8?B?cStjcU5YQkdmWEg4OFZvTTBOcmp0Sm9BVlJXSUY5MDhvMGN0R3hTUGVLemgv?=
 =?utf-8?B?N0o3K0R1QnVzTUNpMkduc0VVRWEvdTQyR1gxSWp6eFVVTDNDam15ZDJXL0dx?=
 =?utf-8?B?RFZaaTQxWVhqbFZSME1nYXgrd2Frd1BaajV2akVFRFZSdC9wNTlZNkFXbG9O?=
 =?utf-8?B?M2hRRUtrcHNVYzc3MWFJVDUwa3F5c01sd2Joa256ejQyeHJqRGx2MWhCVjZr?=
 =?utf-8?B?ekdiVGI1cEN5Yjc2djFYaW03cndIWHpXYzVQWjM4TUNRSS80MjN1bWdERDVl?=
 =?utf-8?B?ZnhnK21XRmNkQ0NJQWF3em1kdzVjYmxNWUZXQ3A0QTg0LzJ4T05OaVQ4Nkxj?=
 =?utf-8?B?NkdCU2V0Sis1bVV3b2M3VGRWeHFmNTNmUmZ3Ny9SVHEybG5kc0dqNmtUWVRr?=
 =?utf-8?B?LzhBZ2Ura2ZzRXZuTmd4ZElSYWRFVTBEdG4xVHI4bW9mZVhYbmlyVU1FRmNI?=
 =?utf-8?B?L1JyeHorMHlzTHBNNHVTR2FkNmZQMkszTUV2ckxhaldpVG5mVlY0QTVlVEZn?=
 =?utf-8?B?YTRMN29OQWYwNkppZ3U2T2FFaExiak5GTFByZFhqSFhsUEJnUElxNG9hRUZJ?=
 =?utf-8?B?blFielNTZTZkRm1aMkN4cnY0VE5DK29OV05iZHRjckQ1ZldkR244NjJXZ2pZ?=
 =?utf-8?B?RGJvRUNVVnBGaVp2UmUzbmtFdWdocmhxaWUrVTRUZXJrd3NOTHhPNEd0ZVI5?=
 =?utf-8?B?cEdkOXcrb0hFYi9WL0RnWHF4blNsY2FOWTAxVUNEcHgyWnBHUDV0amQrNkVY?=
 =?utf-8?B?VS9VMlVIY0Z3L2lPOFdQbkh2TEdFL3NwWis0bVpacTNDQ3YwaVVHUS9lWjQ3?=
 =?utf-8?Q?RaDE5fLqlEorS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDN6cEQ2bkl6NEhkdDlsTnFrcUMzOWVwTlV6Yzd0cjREZEZ3YW9ES3h6MGFl?=
 =?utf-8?B?MlBLQk93WktFVDVjOHB2akIxZ2FrOEp5eDZiY3dMUTBNSzBxRlA1MFZoN3lI?=
 =?utf-8?B?ZUlvY0h0ZnhUUlJCUmFvOVdPdHc0c2ZuS2ZCMkgrbDk1YlB6T05iTkF0Q1Q5?=
 =?utf-8?B?ZU4yc1hCOVVkRDhRVXNCRzJJYVJjVzY0Y1l6OVlwSTUyMzJpVkU1ZGt4QmVB?=
 =?utf-8?B?ay9UbnhoYXJPMjY2ZDNoSFNJOGJFZEJ2ekUybjVuWUpiejhtNXRqWjY1K051?=
 =?utf-8?B?ZE5oVDZxYmEwT2I2Rk1VWFJ2UWVBTEMwZHdTS2JrczBOUkpLMTdhUmVQdEFt?=
 =?utf-8?B?Ui82Zm9BanIzOU1HbUQrWXVxZkRlL0V0WE5IRVZmZnBnRUdDei9SalU1TWVK?=
 =?utf-8?B?dmJ0WDVReHBpaVV2Mnk3dlJ5akZEbklBVG1KWmNVL1ZmellkTmowK3BEYzR5?=
 =?utf-8?B?akQzV1JTUjF0WDhUcThFTVZ4V1J4S1VTaHRJN3lwQVFyTUdRYXc3TG1zRzVL?=
 =?utf-8?B?SDZ6UFh3blNsMlBLRDJQV0R2YnlmQ3ZWSHBMZEc2VXZja1gwbFNQbUFsb1ZY?=
 =?utf-8?B?Vk12dy83aHowclRFeGErYllraUN2Sk5ZSTVJQjBLTFZQQmlkRUUxdHp4Y2VC?=
 =?utf-8?B?UjZrSG5JeGFwSE1pTDRMZFpnMWg4bFAzWnExcXR4WTZJZ2tGeEppQXVFRFZq?=
 =?utf-8?B?UFJoRjBFOWlheWgzditqMit3SVpRQzkxZGQrTGFHa3U2SEMwdTNWc2xTZGh2?=
 =?utf-8?B?MzU0bEFYU2VzamowUEtLajRTSFlMblpHdEVrbGxHMC9JSWpEc3JxVDRnYWxT?=
 =?utf-8?B?TEJGWEpHME9qWjJKUHBpakl0MjI4M01SYzZGcVVhNWVYeWZDZ2F4dG42YmI0?=
 =?utf-8?B?QVFRdS90NDR3LzlLc3N5SldwUEhMTG9oMVlBb1NtclJtNjg1SEdJVnlxZmQw?=
 =?utf-8?B?RWpyOTdMcGh1Y1l0akJoaW9wK0FEOXBlYlhmUXdRQUhzeVZOL2RiN01FbkF5?=
 =?utf-8?B?cFYwdzc2YnJhTS9jR1IwbGRZdmZFWkRBOFgxa2xwbDkwVU0zUTBFZG1qMWJj?=
 =?utf-8?B?RmpDdWZGUFNlQ0p1czhpbjd0TW9BQUFCMXBqSFJaSjNkL0lWUG9nQVJ6SDN6?=
 =?utf-8?B?T2JuNHBMOG92YUl3VzZFYnVIQ3RoYzdFemZnSmMrTDltS2NvYTFCcHdnR1A3?=
 =?utf-8?B?eDBBYlVNczlrc0EzM0FFT0RSVndqNlpaZzlaMkxFT0h4Q1NlbmlvdHZ4YTFX?=
 =?utf-8?B?STQ0RGpKRXRVVlg1S0FTQldrb2dMSXhXUEpCQkhzeFRRUEhEL1paS2ZMRzI1?=
 =?utf-8?B?ZjQ5SFdxeWEvdyswNmNVczluVUU0ejJWdWI4UVp5VXZQaWYyQ3RYdFR3SWFE?=
 =?utf-8?B?a2NESkpxbXcyem5tejlOb21oa3BmK3NGWmJMVmJaTnNRWFpkSXZKOGtvUGh1?=
 =?utf-8?B?K0JPYndNTDV6RWo0c1AwV0JBTXJ4MFJPVW1TS20xQ1NPb0NSSDFDbC9kaGU2?=
 =?utf-8?B?eG1HQ1ZlL2Nvd3lXVnZnbEY5Tm9rOVFTWlA4eGdSSllUZmFVSmhza1RiN1NT?=
 =?utf-8?B?WmJDNFJweG1YbkhmSXZrN2kvZElDTWNMZmFqWkEzN2pxSGdqbC9KWDlab0Fr?=
 =?utf-8?B?SjNGeTJsZTI2cG1FaVRhNUJjWUcrQzVuWW55bmNXSnE0Y3M1eXlxSzRpV3BT?=
 =?utf-8?B?M2RlanNJQThTR0xBWXdyYXZMc0tkYUhHYnFLdGlDcmNYbjFmNEVqNU5tUXh4?=
 =?utf-8?B?WHNVWkh4VCtycDhjTERXdDdTKzFuSFJ6NVJCR3RaVXFIMXJyZ1ZwSFZMQ0k0?=
 =?utf-8?B?YWlaUk1xVkttRGs2eHZsRkNJTkpwQ3huK3czN0Y0eGlKdWRJV2hBc1dlaC9s?=
 =?utf-8?B?ZXVzTkFvOGdCS3NkWHY3aGljV29ZaVpEZnU2NnVMUDF6aFA2dWthOEFFN3ZJ?=
 =?utf-8?B?WEZIK01icmxkcGM3cEVCM1JFelR2STM3QTEreWFPcVk0V1NMRE9BaXZrSWJ3?=
 =?utf-8?B?V24yOUlNb01vTW1WZlRIZEs5eGkxU0JaQmtuTEtXdVQ1UHMxNy9rTGNtbis0?=
 =?utf-8?B?MUNnZ3ptdHpUN2ZEajRZdnp0b1NYZ1llakpnRm1TckZIZXFacnBNUjRIM0FJ?=
 =?utf-8?Q?re+7LCR9ug47WYLgkC4ZQh9i7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fae92ee-b932-4984-922c-08dd65cfb0f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 03:48:06.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjzRzChZ3yYHQHnoRVPwXm8b83zDzl7f9np2oAbkq4gYgBBeaRPZ6Di1fORq/RfOlwk0A6xM046qt+txpNrhmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
X-OriginatorOrg: intel.com

On 3/17/2025 6:15 PM, Sathyanarayanan Kuppuswamy wrote:
[...]
> Any comment on the missing event log support? Extending the measurements
> without logging the event should break the tractability feature. Can you 
> add
> info about why it is ok to just add extension support for now?
> 
The event log support was once proposed and discussed. Please see 
https://lore.kernel.org/all/20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com/ 
for details. In short, it's difficult to define a log format that fits 
all applications, and luckily it doesn't have to be solved in kernel 
mode, so we leave it out for now.



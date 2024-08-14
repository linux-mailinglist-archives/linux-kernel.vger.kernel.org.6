Return-Path: <linux-kernel+bounces-285792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E010B9512DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22AE1C22ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4758B376F5;
	Wed, 14 Aug 2024 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fb6hRGHg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14328485
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604569; cv=fail; b=nJ2dsF+ItY0QqGCtQkW640noAqKRtqFy7JFXcIfrraKPB/glPyhxQMf6uOl1x+yRihP34YX63AqEOLwQ0sbYc9R3pbrwwvFt6zxy+73Hp7S81Jh5P3xYCZG7m37OAzXfjbRw6Xqylg5SyoRXuxcIn5aWZS/nDLEDMYPa2ZM6D7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604569; c=relaxed/simple;
	bh=xpsYGWFdgpfwlUKAw48Ftw9hYu7pczre5RXs78i81ZU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oNjZ3eOEKav7nyHiG2o5gXjX9oFmZeLkmpsIgnDso+vmw3iGPNFtdQn3meqUq0CTBwKhCZv5WQHR5PYT7oNYeXA8G9725Yz+1sMCLv6xJVBLyrKHOxY59IdbZTnkRhkeX/q+mhNuPpBfgbIeAs24CvHhmLrfDF7UcyY/fgGzT6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fb6hRGHg; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723604567; x=1755140567;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xpsYGWFdgpfwlUKAw48Ftw9hYu7pczre5RXs78i81ZU=;
  b=Fb6hRGHgY7cP4OvrrBMyPpi/rk/ftjZLicnpGBaCT518f0J84CtjzciF
   MYzs+7beYCgl9K6Xpago7mrSXGMpxtbN41Xjox7n3c5dD0NnAO1eBzFiD
   HMFgUybKgEQMv80wS5LuYmEM8mA9EIdXUFQK92Mw+PoMrPFGhHGBZgn0g
   ldkfKSUv947EVwPhjv0nJmZORXZEfKZQvbubtDj1wuuwX7G+yUsu/ckAN
   AMJmNyJP1olwWlXmcPF7uTUUEUEO5JHrrDhUVL/683Z7mPtzBqCTaGoSk
   X3nZvzLlehdqdayzeF2NwYZ1ReFvEuFwUTMyvuOvJ2/+5aSwYXnwmS/gJ
   Q==;
X-CSE-ConnectionGUID: raUdfVeaRti8Vj1Df6y+eg==
X-CSE-MsgGUID: oxDHTrH3SZelA4czTPR9gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="44317837"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="44317837"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 20:02:45 -0700
X-CSE-ConnectionGUID: dveGzwxPRJGjpx2aWnz/xA==
X-CSE-MsgGUID: PGjaiA8TQmaW6HbjZVfiqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58972747"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 20:02:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:02:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 20:02:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 20:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC2+3dgBlEliO5QnAubpi/TvSvpo+T8ynv//xEJYA9QLkS1PRAOn98mVwsSvaRYQEF7t/wcdlhOWaR3MhhTnRIdm1vC59MMVOBwDcfjxy/WkO/gAG9NkZwpUH/U+K1T51IY2sq+RscMST5aWIqiRFLASP+wTUzceDZAu+e1zSna5Gv/vO3wE95ovMWIpbpyIwcWC3h2hFI+e18uPI90da0Jem+X+jZB0s7v/mi7EZPEtk11fm4FzaGADPeOZIVS24i6NFZRpHGFkOYp5wRG+cBUbO5lZQQFMB4CggKVI3jG37eYQwWfTPZzCQz6TuT3TJiAm0qSS5ao6Cok2+A+NtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQocEPT4L8SPrYDA9ulepyJ/9aGypTjnKPGeC+PjUXU=;
 b=jiPFmkZ7vgNZvba0IdL+ptHXv+qLClKkOb8wv+4ySr2pzBVSsjX12MfZSO5VvNEwdPhQgEebLvML4PasxcN7MBPwAK1abqpfV88S00RHqip/U9zq0aodCKTC9jb8H7VWp+eGtybgpKGI/Z9eg3VF/S4r7g+eqdM6rgBYZIc/UrgRW6oGemgK019Xn+5+L38txKnDVhnFJ/AZ3FY9T44Bey/ppDx2FWr/iopmYu5FO8rJLX1J/laCuwXtDAIMLgoVnfPA2A9t6ndQQs0T+cXYoE2ZwaCgSlAQMPYHZy9pg+La8gVYohAlSgIW4VNYK2Re3CiAc/SM9EELBRuzj2tZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by DM4PR11MB8203.namprd11.prod.outlook.com (2603:10b6:8:187::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 03:02:42 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::dbf5:99e5:f9f0:74bf]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::dbf5:99e5:f9f0:74bf%4]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 03:02:42 +0000
Message-ID: <f4ddda8d-3513-4471-8609-acb3ce29219e@intel.com>
Date: Wed, 14 Aug 2024 11:02:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9%
 regression
To: Mateusz Guzik <mjguzik@gmail.com>
CC: David Hildenbrand <david@redhat.com>, kernel test robot
	<oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Huacai Chen
	<chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox
	<willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Ryan Roberts
	<ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>,
	<linux-mm@kvack.org>, <ying.huang@intel.com>, <feng.tang@intel.com>
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
 <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
 <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com>
 <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
 <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com>
 <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>
 <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2>
 <817150f2-abf7-430f-9973-540bd6cdd26f@intel.com>
 <CAGudoHG1=p0GEVaSASA1C+iVYbfA5rryozAPPEoxr5uKtM=ghw@mail.gmail.com>
Content-Language: en-US
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAGudoHG1=p0GEVaSASA1C+iVYbfA5rryozAPPEoxr5uKtM=ghw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0211.apcprd06.prod.outlook.com
 (2603:1096:4:68::19) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|DM4PR11MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c1a2f2-3d56-43a9-2da6-08dcbc0d8fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am1TY21NL2dodWt0V1hqWjBRQlRWSlpGK1ViL1JIRGJscy9jUDNmSEFnUjJp?=
 =?utf-8?B?MHdUcTE0MjZiZDh6YWVocDg2N1FxUGkxaWRiZWwwbTJCOVdkU2tGVDVPUjFs?=
 =?utf-8?B?NGtuVmY2UnVNSDNrbEdtakkvenlJenQvdWEwcU5OTUJtOEpSZk5NRndlR1VI?=
 =?utf-8?B?Z295aWhrK0dkSFR0LzhyRzJmdzFsbUJnb0xoZm9Ha1FrV2hicGkwWCtjbXdU?=
 =?utf-8?B?b0lOMHNrdWREU0JybXRqeTdLRGcrZmFYd3hOTWpQVTdPc3B0Q2t3R0k5YzNS?=
 =?utf-8?B?dHRJR1Q2M3ByRUwremVHQzh0blVCbkpVZ3Urajc3UDNMM0pIVnhIY0lPYzlL?=
 =?utf-8?B?TjNObHo3ZkRIUkdBRXJ3QXhHOUlrL2FvKzZ0RGhHYTZIeTlPbHV1aUJQNEFj?=
 =?utf-8?B?enVJYzdjVGp1VHNxV25tNUZXS3BNdnVMaDFHT1UyUEdvZ28wMlJUdFUrQzRk?=
 =?utf-8?B?OS8rZDQ4Ryt4cURUOXFJS1pDZzVYQm45RmJUZFExTXlNTEdrTHFPdzZFeTJN?=
 =?utf-8?B?cld6dWFwZWgybDNPZy94cU9XV3hUOFFxb3FRK3FXam9jSE1nQ0hkQXFmOVZG?=
 =?utf-8?B?Nm9vaGFvbFNKT1IyUEd1NUw0RCtKZlVwUmNkZTRxV3NUSENoMzNNdzk5dXZQ?=
 =?utf-8?B?L1dTTlNnTnhsV0ptUDY1MGs4WHJIeis1NHNHM1djdmY1WnNjaTFFM2N1MzN5?=
 =?utf-8?B?MjAxbkxyUVZvY1FaQWpjZ09xVXUxdHpad2N2em92YytKNHFZU0t3aXhtb3BI?=
 =?utf-8?B?U05YK3NFSklGaDhvWndsMGE3eW9zVWRFUlI4QzZvSGFSNnVwcjZPdURvUXpt?=
 =?utf-8?B?RGpRblNZY2JWSHhPeXlRQW9kdVc3SHJmYm02Wk5hME10SllDZzJVRGtLbC9t?=
 =?utf-8?B?MWNEeVMwSTFxeFZLVFZqM2F1d21iWjdNeGpTVTlhcW5HdmxKUk10MkxxT2Z4?=
 =?utf-8?B?VWFyWG5lZHI1VFVsYnRjNVJCZHZ5Y0RGVE1heTNUUnRSWXhXcWEyTE5Pak5H?=
 =?utf-8?B?QWxsZm1nM3Q3Mm9jeURqdnMxNm8rSjBKSGpOSC8wMmFraU0wY1dXR3NsYWhu?=
 =?utf-8?B?YSs3VHNxdkhQSTU4QUM2N0FXS2JrWHUybW9sUlVaVWF6MGo2cmd3YVBjdUpY?=
 =?utf-8?B?NGpkRE1qUDRyVHNsSkwrNURISGh1dUE5NnNBeFRkaWRRcnBibTlpMDVkaW5X?=
 =?utf-8?B?UDhpUExXWnJzMjZtY3pSUU15NHVhMlgxUElRS21DUTdQdkxvQXA4dHN3TWpi?=
 =?utf-8?B?eVFwOFI2blZudmRhTjdRN2xNWXpsMVVBRU9aT0tQUE95K0RGNThMSlA0eFpY?=
 =?utf-8?B?TVQzeDJoWW4vUXliYmxyUTRUL0NQcFZOa2Q1Ung5VWo2Tklud0JSNUdiOHFa?=
 =?utf-8?B?cGY0NHJvQlA2ZWU2TVdZNlVTUGM2cGV4WFZ5eGRId1h1QnR0UVYxWjYvQUkx?=
 =?utf-8?B?SnMwMk1QWm8vcE9uZlJBU3IvdS95cC8zcThXVnJQODFTMldVUXJ1azlPd0gv?=
 =?utf-8?B?S3Y4cTVpZytwQm5hWEVXY1VYaDQrWjB5dlJhcnA5eU8wYnA4blJNNjZzRUZN?=
 =?utf-8?B?RnJnQUIzNG1XWFhTdm82MGdoakNNRGptZGxtaHNyYVNERTJBVEpteThEU013?=
 =?utf-8?B?dEdyUFRReFZ4U0tWNG1ScDV1eEdIQlpYajllYytUSHh6OFdldC9XZTBpeGVO?=
 =?utf-8?B?dTVKT28wcW9FditVMXE4QSswZnVhTHVOZ2UrdUJEc0xDVGxuRitJb0tlWkNp?=
 =?utf-8?Q?hXZAMxUA7Fn+wIQfEE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ynp2cFpXOWNSbUZmKzg1eVZOakR2YlVMcTYzdGZ6aWRsWVJvRmIrbVFkSEhJ?=
 =?utf-8?B?ZzRjaUZSdEtVc2tiU01DTU1EMUZZalBRRGp4MGtMREZIUDRCYnJMb21QUElD?=
 =?utf-8?B?WG9hVEpaa3F5VWI5MUE4V09VQlRWOTlFbkx5VE1Ga2YrY3U3NDgwZ1FmaEFk?=
 =?utf-8?B?OHpvU3pLRFcrb2MvL2dOT1VIMFNCM2FHdTY4T0lQQzNpZXVQaEV3b0pZN3RH?=
 =?utf-8?B?WWVHanFPdmRNOXF3OCtlR0FZY292MHBRQjlsT3Jaa0g0SDZGWnljSmUweStJ?=
 =?utf-8?B?Wnc0Y1lRMmMvazE4MzFGbkRaLy9GeVg0WFdEVHJDRUFIa20ydXVWeGQ1OHZO?=
 =?utf-8?B?UnlLTzVseG5ZWWh4Nkp5MjQ0YnBlSUpaVWFkdTdhKzYvb3NvUXpoV1lhOU04?=
 =?utf-8?B?UGpybUNMQjRLeVVpZkNMUVhCUGJJTlVJR2h3ZWduS1JBMjlMTVRoSkVySHV4?=
 =?utf-8?B?ZllEbDd5TjlrYVhoMk9XNlRGOWNOSkQ4eVdma25sS0tFam9FRzNJUnZsRmxZ?=
 =?utf-8?B?Vm9YekRLQ2JuWHNxcXJpRmhmR3RtNUs4Y2tuRTFVUmJZdE9Sc1ZTVDlnelNy?=
 =?utf-8?B?dkNKWHdiK2YxVnQ5WktjTUtJSnRHSkI1MkV3dzQrV1FuNUFlOUJSUmlMMGc3?=
 =?utf-8?B?ZVNPSFBZRit6cnRSZGYvb2I4K1psTE1QejhFR2pkZ1BXSWJmNDBwTkJXOU1p?=
 =?utf-8?B?NFdseHU1SFE5YU05aVVIcFZyaGdQNmdKUVdRVUgzajJJZ3pndkNNWEZRRDZY?=
 =?utf-8?B?WWFMYk51cDJrRzhHZ3V1UXlnb1FOOUZxR0VBOUlnQnZTK0gxN2Evczh2Z0RS?=
 =?utf-8?B?WU5heEs0R2tjUW1YVmQ0ak9BZnRmdGZYR0MrRWpzWnpQdlozTEM1QjNGdDRY?=
 =?utf-8?B?cXI5OGdzWlREbU1UUmpsUWVwNGx1WitucE1LRTFuVk8wdFJzSlNyY2VyWDFr?=
 =?utf-8?B?ekVTWFNXZk81SnJHNWIvMW00b0NSU1pTMG5vOE1LaU5hL0I5ZittNk1rb2tQ?=
 =?utf-8?B?eXhsTE5oakd5L0pRQXZEY1BsdksyenFteXhpVkdtN3EyeHAwek1JS3JDamRH?=
 =?utf-8?B?REhveWZFdlNteURFMmRsL3pmVEEzRTkza0gvb2d1V0xHQ25kWmxya3g3MTVu?=
 =?utf-8?B?Z09nYnMzb05mOFVLRzlid3laczRXdVlNeHJDV0w3angzMFBYY2NQcXByaXh5?=
 =?utf-8?B?WkVMVGdzRkNjY0p2VlVDM1ptZXVsd0VGek9KMnkzUmlDMWJIWXllZUlQL1RJ?=
 =?utf-8?B?SEdnajh3SnIwWVpqRW9sMzZGWDZleWt5YTRHak96NmZjaFdFckhRTmxMVFBU?=
 =?utf-8?B?MFlKNExDVnhBK0JPV3pLRnJKVStHeWU2K1NvZENMWStXRllQVllmMXFSdjg2?=
 =?utf-8?B?WitvRXY2VnlyazJiTVBQRjE4a3FWem41SEIvTm9oZG1mUVFMNnZFTDBKWEtN?=
 =?utf-8?B?Qk1qNEZneVp5VEZCRU1KaTFGT1NKRldZMlVTcjk0MzR3Rm1OQlZFdVMwdmsr?=
 =?utf-8?B?VlZYVEc3dU5FUHkrdEQ4aWo3Q2RkNWdGblNlWGUyTXdXZy95RzFWTGRYRFJz?=
 =?utf-8?B?WUt5Z3ZMeWtiNGF2ZXJjcmxPWmhUOHBPVkllUU5TRkVjbzFaTjBpNnYvTHIz?=
 =?utf-8?B?blpKZndCTGRJQk1CNlJvNEdpb2FrYWR6ZTFmU29KQy9pK012SHZYelJZeU80?=
 =?utf-8?B?NVcyaDFaSGJnR1lOUkU5cnFHd0ZJOFlRUUFoRklSZjRyTzJicFhMdksxc3Yy?=
 =?utf-8?B?MVNRcXpRRkFudVNBd2tlRFV5ZWU5VFc5ZWJid2Z5b3ZHSlJGN2lFR2JjcGs4?=
 =?utf-8?B?azlndzg5NHNEeVhyNU9xZ1NVQU5zS2Q1TGY1SWNzZ01zY0d6aGZaQStmeXRp?=
 =?utf-8?B?c0Z4VGtBVzVGZzRtT3RRTC9kMENKMEN4RVhLdWFqQWR4a2o5dUpIY1dhd2l4?=
 =?utf-8?B?TzIvbzBQVmY5YmxzK2MyVUpmZm1pYW0vNU9QZlptTUQwL1hZSUxmWFlsQ3R1?=
 =?utf-8?B?Z1NXVW91R0tjNWJRNDdwOUI1RUtabm4wT3llVS83OW8yTEc1aXNsaVdwOTJW?=
 =?utf-8?B?UGt2ekdyUFpmeUFBazVmVm83WW9BYmlSS2d5aVJXTmNvemlQZVNEbThjeVBK?=
 =?utf-8?Q?L/XSVXtdvlAsnLhfRoL7oLwxP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c1a2f2-3d56-43a9-2da6-08dcbc0d8fe3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 03:02:42.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfafB5qidssl7eVtWOPo0GzfGwn489hFspuvTVN/Z5VBmWqL5r/zLqtlA1I/cQa62hU/77I6kxad8kIjF3pKYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
X-OriginatorOrg: intel.com

On 8/13/24 03:14, Mateusz Guzik wrote:
> thanks for testing
> 
> would you mind benchmarking the change which merely force-inlines _compund_page?
> 
> https://lore.kernel.org/linux-mm/66c4fcc5-47f6-438c-a73a-3af6e19c3200@redhat.com/
This change can resolve the regression also:
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/testtime/test/cpufreq_governor/debug-setup:
 
lkp-icl-2sp8/stress-ng/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3/gcc-12/100%/60s/clone/performance/yfw_test2

commit:
   9cb28da54643ad464c47585cd5866c30b0218e67  parent commit
   c0bff412e67b781d761e330ff9578aa9ed2be79e  commit introduced regression
   450b96d2c4f740152e03c6b79b484a10347b3ea9  the change proposed by David
                                             in above link

9cb28da54643ad46 c0bff412e67b781d761e330ff95 450b96d2c4f740152e03c6b79b4
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
       2906            +3.5%       3007            +0.4%       2919 
   stress-ng.clone.microsecs_per_clone
     562884            -2.9%     546575            -0.6%     559718 
   stress-ng.clone.ops
       9295            -2.9%       9028            -0.5%       9248 
   stress-ng.clone.ops_per_sec



Regards
Yin, Fengwei



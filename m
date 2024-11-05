Return-Path: <linux-kernel+bounces-397268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4139BD9A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F213A284827
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D021645C;
	Tue,  5 Nov 2024 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9hGvmpA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BF21620E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848839; cv=fail; b=kN2J5d8Oku+2XbrU18OJ/ZPid7Rcc+k0jhDY6LxwF89NmpLc9nWXbr26JOto7LQza8c4KBnLuER6iNwPAjfUo8ip5waFYnHz+/Ge1PQpzpGRHdSDDb+4DQKkHQ7mVhbiQKIuBDD9bw7ufuFXO1OR+F5hQgi3xiauwE8Fveqg1n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848839; c=relaxed/simple;
	bh=coW8lKMLw+x6K8dBrD5Mr7URCtDtwLb0oGuXyoMIozM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CySt+PLLocSwUQofR7YigCNJTgGYSR7znVf37ENmn5YP5pHvzKTnLt1pk/SOEQTzV3bJMkXasUN+Tgx+jHDlkOYf+6dm8o9KJ+xzFBppew7NhAvPQGIO1p1VqDzfJ842fOnMTodNhPl8CvwowNDIybwRDBbiU0ZUnbPkpp85mTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9hGvmpA; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730848837; x=1762384837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=coW8lKMLw+x6K8dBrD5Mr7URCtDtwLb0oGuXyoMIozM=;
  b=E9hGvmpAEJtw/dNvGRcS/YITOxUdZW1j1JTiHsxxHAjPn9Rvy5xCaGvb
   6VChF1s6A9q43mSdjQQfi6Z2bJILp+1APImECqui9FCAOQpc6immb8vRx
   +WSIPYzn+i6KYvqM6DdNaHFbcmS5v+noDVqTquYEjfAzkJNEITfUTbj09
   hFkDvYnFkk5foZFs/R6Vdvb4A/1G9RNnqxAlQ2wJmaQrwY4DuKDrtXyHM
   okE+MNP8vsSJPv7rGAuPjsLnIuP/Y0O0DXDqG/kdpJOonzlRC1QPbQW1W
   cnQK4DOnQf3dhGPRsQu9Lx598FAJ63yp1Gr6iYEfdCgCS79G/QvzoxOe2
   g==;
X-CSE-ConnectionGUID: oNxRyA1gQruWcf/fpnDEkg==
X-CSE-MsgGUID: eNXJpdHvQfKshI2mVgA3zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="34409365"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="34409365"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 15:20:36 -0800
X-CSE-ConnectionGUID: 6ANfiM4RRry68/WRCotilA==
X-CSE-MsgGUID: 4fWoqbaYTCq9H5CnYI1LhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="89028195"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 15:20:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 15:20:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 15:20:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 15:20:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyBtcVWHhgoWYyelo70cIpGXwm2tP3XpL71dhx9ikGYKO8qbV/IHocnGie5BvT0r2o6/jlw4oF9DAL6AtfMq7dTripXNZhzjV3RKCC1hNkxc0ca5MP6Up022au+Yrp8WnIobRYy3JWqIWCXxxJVLIeM6A6Mmgl61gX56Q9yrRRnhczooE8MMqXSlYrFBSWq/gWV6M/Y7mZlsFsUd/q4JeKMlba5YCHYxhLETqDAn4DxLGbZOcFxOAr8rGIwQL/LzbWhk6KisOwZZuoEdNc5/1t5/XXMKiaQAeLRcTHksnOj/zfAtAGTibVpWconVAvsg306p9pcKa2fK9jv+hAFztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=525QU1TUMK4XQvRYSs6w1Z1FriHibWzY/kq+inGn92s=;
 b=Mz0RVmZ5lMVks0JFNgtljawAC3QcUjSVJP0Rpyzr4DqyRS9ZDVgVs4A457gTniBNTW5K2ujaYEQgmGFiRPT44LDMKsust0AWJYvBEpLgEA+CPGLwo6YrVzQGZToMLfSyW72sKabXJ1gEmcqRtgivjJ2q803XGN5hqqa4qKeYuAEHM/RjDYwawPUTF6P976SOnDkO242XVSMbaWTZcVOn0AXya/+iUmdBV1lVr+w4zGaZFWfIXcVClG6AkpkcMStm/zAETOi9rUKzFOO4vo25J0INlTtP7x7H5MiV3wr5vAbWPKrukDWUaM+c7ccWexa6n4NoSoShczKXWw9uMLr9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6018.namprd11.prod.outlook.com (2603:10b6:8:5e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 23:20:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 23:20:29 +0000
Message-ID: <4e2f31bf-1035-40a6-b16d-081d6e45ead8@intel.com>
Date: Tue, 5 Nov 2024 15:20:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Tony Luck
	<tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, James Morse
	<james.morse@arm.com>, Martin Kletzander <nert.pinx@gmail.com>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
 <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
 <CALPaoCgc13hS64mSWvn6zYQWwVKzcyF8xueWsaP62ZZJiv+nog@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCgc13hS64mSWvn6zYQWwVKzcyF8xueWsaP62ZZJiv+nog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:303:6b::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 65168c18-20a3-4f49-dbdb-08dcfdf0703d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGVwVEhITFU4VUplYkZJbzFOSFpqY2FFVEE1Y3M2UWJvd2t1T01LMi9QLzJF?=
 =?utf-8?B?ZmhqcnpLTnVwZ2Y2RkI5SkNmZ2Q0TkhLc3FRMElYSC8wNHBGUU1ma0RXRWNX?=
 =?utf-8?B?aGlnMnZ2T1RvdlJ0WXZ1NU10SVdpTDc5NHE4WWt5UzVTSkVKbmp5WWtLdzFk?=
 =?utf-8?B?Sm4yQzRTRVNreFVFRk5mSkJvVCt6eS8rU3h1Q0JxR2hIUzVSbE5ZZWdqeDV5?=
 =?utf-8?B?SFBpQi84ay9FMmhNVVkveDNqUHBCSElCZTJ6TVB3YnM4dUNKeFA2UGZIRHIw?=
 =?utf-8?B?NmN6YXdaRDN4Rm5oME5PbGplcGRWVXl4TU1YN2dIV25veEJnVHhQbTRaSmVl?=
 =?utf-8?B?S2Rrc1R0NGZoT0FvZWZEM0p0VXJUTGxMSmZjbnNqVGRnUEtGWlJaeDFqUFkw?=
 =?utf-8?B?WDYvSGVqbVVrTnJMckFscXh0bndWbkEzN0hsYUJaNVBUd3RRU2I0dUtIcW1R?=
 =?utf-8?B?QnlBdlM0QjZVNjlXekJoMnF3L0hxSjFhSGErVEE5OHZIRHlDZU5ObzNFSEVR?=
 =?utf-8?B?UWgzYjZDOVZ5TXpYY2NVNkcrdnJoVmtZeHN4RXA3OEphZmo3WjRXNjcweUxn?=
 =?utf-8?B?bzN3V3Fma0dPK3ZOVGtuZU9HbDVWV2lhMTJXRk5MT29EeUVFUFFVQ0lWdEtz?=
 =?utf-8?B?cHdtWFcwK0x6Y0NCbldUSXl5VXc1M2NDVzA3MDRGazlQUFd4dXB0OXJzUWhW?=
 =?utf-8?B?ZjJQcFcvM2I2eTZIUjcwSFlsSlZvam1UY3EvcDRUNWYwK2MrUGVZTWZtRE5V?=
 =?utf-8?B?cGE0NWhseUNhWWkxdHFicUZHVXZRSjZITmdtOGRvMW9MR0ZTa3lpWFhOTVhD?=
 =?utf-8?B?NHNpSXdQaWcvaW5Ed2pQQ2I4elIvZ1RFSFNUS3pnNkFibURBNWF6RzBmQ1cz?=
 =?utf-8?B?bUpqclo4UUo3NnIyeUh0ZWc2ZzBUcTd4ZmpOYVJtcXFGQytUOUwzVjhjd3BS?=
 =?utf-8?B?cVN4L2VsQWlVV1g3YTN6ZzE1aHpPS0NJQjhMUDVxSVgvRE9xMTNyR1d1RUdz?=
 =?utf-8?B?V3p3LzYvNkNDRHdURE1zTTI5alJBL2xBRGRlMTRMY2lxbEVsaDI4ZDF6a1VK?=
 =?utf-8?B?VkJRbnIvbUE2eUlxbFRJb2d4bTZ1RkRyd0R3UE40b2taUkxoVkNaZ0U1bWxq?=
 =?utf-8?B?aDNwWkt5OEdnemVqa3E2TlFyRUZiV1lJelZtSHBOdXBzSVNoZURSVlI5NE5X?=
 =?utf-8?B?K0ltMnlONlh2ZHo5VWZNbDFWUUJObStHczN1VkF4YWJxOEVWY1N4ZVVlejhi?=
 =?utf-8?B?dEJUeWR4QytXYmNRTmx0by9XK3NoREk1UldpTklSOUQyR2ZpQnFnNnZFUWZ1?=
 =?utf-8?B?bUk1QTRMZU9pa1Z3QlBWa1JjZS9qYWx5TU1GZ3podGE0Qm5zRW1wTy9UTVRB?=
 =?utf-8?B?NWsvc2lXOWpPeFJZRlArQUtWL1MzNEFiK1Bob0hiQ1hOYmpiK0tRU0hRSko4?=
 =?utf-8?B?YVR4aWtMRTBzVFI4WlFvMCtPYkNFbGJKcllzaDR1eWJPdzFaYVNNQ0NNdWdD?=
 =?utf-8?B?NWNpMkpvOGFKdjMvTWxoc0w0dGp2bGwxU3JaT1ZGdWlqMTMxb0ZtUTNLMXVH?=
 =?utf-8?B?MUEzemViMEtJaWdhT21vcTNSdENBZFFjSFk2TmY5N3IvczFLQ0NRWlFNcnNu?=
 =?utf-8?B?VTF1SmplMDdMUWM0WEs3bUxQTVIxUFZtaUdoSVFtN0tqRzJ4Nk9WSEo3K3Nz?=
 =?utf-8?B?Z1duTnByQTVGcFlqQlRHb2hjVFRMTWt1bjdVdENhRkVyVnVVbThxd0tRZHR6?=
 =?utf-8?Q?N96b/X+LAGOrzPttdXl1HpwohmUrPqRwpiqHbHQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1NR3hQQmtZSGVXTytIWk5JVXRPTTM1L2pteThnaDhxVUVTK09UOExwTmRt?=
 =?utf-8?B?Sjc1eENFOWdlR3c5VnkrcUpPOTBtWGxiWE55b25ua0FDbTJ6QTM2RERmdjlC?=
 =?utf-8?B?TEQra1NpVFppZmljT1VUbjZxQXJ1Y2NqSG9tZVk1QlJZYlRqY1B5ejdZa3ZO?=
 =?utf-8?B?ZVZZaGxHK2dBQ1k5Ymp0b09jeEozM0VKMExObWRrZitBSWRidG1mMW42L3Av?=
 =?utf-8?B?SUNaOXZwNlhQektKSTZ2YVlnSmJ1SmRhdXlCcW5EM3FCM2x3cUpHVmlxSzc3?=
 =?utf-8?B?ZDdURmdXcXMxclVqcllyNkJ2dUtmdmhqUitRTU4vV0lvT2ltQ2hsRmlaMlBQ?=
 =?utf-8?B?b1JkOGMrVE9ITFZKLytFQW1COXovMHdKMEdxSnpkb1BNcUVlWVN1UXUzS2dH?=
 =?utf-8?B?RGVJV3ZEVWpZQnJ3QlJ4L2tvbWRYaWFLd24yNVdoc05ENnFLRnZCY1Z1ZGZV?=
 =?utf-8?B?bVdOUnhLcW5HN0lYQ2R0dG9nNVJHV0xZbmJRb3F0R3FqMTZ1UDZFdktIRVVv?=
 =?utf-8?B?djNITDJubHlCQzFxd09qU1hicE45R1ZOZy9WRG1LVFNOQWxYN3ZqdWtWUjNX?=
 =?utf-8?B?elZ1Mm9CODVHczlRbVUxekF3VzdaUlU3MWhaemM0SXRjODBKQkpmcDlsNk5S?=
 =?utf-8?B?QWF3WGFpVldycU14elQ4OURSeVljV3k3c0pTSjBZNHRhVVhGNnFKQWtEN3M1?=
 =?utf-8?B?MVZJZkxDdW1rYUE3QXpYclczc2xHd1FWSHlxWTc2TUVqaDl5L2hyY1dFRXNj?=
 =?utf-8?B?cG1UM2luem1qVnZteXhKWk9EVHdGUnpMYld3Tll5c1R5WVZnZUxOb1J6WmJr?=
 =?utf-8?B?eUhpTWllMm1HR2RUdjRDZ3k1SS8vZWFxc1ZSdFVXTVNENWloOTFsUTByRnBD?=
 =?utf-8?B?cmJMZG1FMW8reExwYWluNjk5cGlIVzhXSW5HUUpJQWdDQjhKTlJvMTl3bENI?=
 =?utf-8?B?VzVGVVZUeENjZXdNY3VnTHJmT2IrV2pNTGRacGM4RDY4UE9LMkREdkxqSEor?=
 =?utf-8?B?TFdKNnRGNXhmTXBGZ3JuOVc3SzFDN2N4MHg3S2Z4Umd2TGxLaHBXMDJ4MjFm?=
 =?utf-8?B?WGw1L1prOXBqWnVNcW9kVU5lY2dib3FKSFIreVdzRzRSUXNmT1plUk1DYTlX?=
 =?utf-8?B?S1dYSmZ2MFFBeDM2QTFRVEVYcGR3eFF2a1dhV1RIZU1ZUDl1VDJUbCtOVWZP?=
 =?utf-8?B?S0VORmdxWktDcEZmdi9wMmprdkZUSFZncDBSbXFLWDdHeThCME9sMmovUngx?=
 =?utf-8?B?TDlodjNMOU1tU21PSlRhalNZYXR5bWM5K2twT3VPejJsUE8rVGM1UDNHN0d5?=
 =?utf-8?B?S2wwSjBkVlpaYlp6MklIcEMvbTMzNjNRWXpzZC91bXNlcTU5VjQ1bkRhWkk3?=
 =?utf-8?B?L29GUVRPa1psWHUyWWs3M0JKNDlTK3lUSzF0ZWQ2Y3V3VnhIWDNIMTFqbkVa?=
 =?utf-8?B?VzgrZWcyVDV2R3dFSStmT3F3TVBiY0pVcEErNU9CTzlGZ3FtWXBlWVIrWlc2?=
 =?utf-8?B?eXE2WWtCRHdiUk1xNDA3UEV4L3hwU0R0TWlSTm03QVdmbkVwWDVZQUdyZDZ0?=
 =?utf-8?B?eGxoSTMyV0JpUE9RUDEwN3E5Tjd2ZVdYbjhRUStmMWtUQ1VLdWRpUThaaWxD?=
 =?utf-8?B?alZxYU1LL0hBdGYxdTFLZTBadXY5NDlSWS9BbEJoWW1qS0h2eDZhKzFjM3pC?=
 =?utf-8?B?RzZzaUtVQTY5MU9meWZLRUozRGppaWM0enZleDNFN3owanNvMkRqbTVKVnc3?=
 =?utf-8?B?VU1MV2RUSG5rMGFlcEdnQWY3MXZpOWVFbFl2Ry9uSnNpSmNnUndYQ2huOGFY?=
 =?utf-8?B?N1RKS3YrYlpHR2tHa0k4eEVFblVqWkptdWxoeEN0eWhJWGQvYTNseWxWU3E3?=
 =?utf-8?B?TEI3NGZsVEVsVzlXNk16dGx4SmtKOFhIMU1sRGRMeExFK1J1YkMwVVl1QXZS?=
 =?utf-8?B?dHVWdzhCcFhoSFBKYXlGTE5wL2ZtMTd0Y2RqbUludDl0dmt2MVZRYy9IMFk3?=
 =?utf-8?B?N3VzNFBBRitKV1N5NW9aK2krOUpMenZMSE9rdVlzMEp6V0M5N3ZHbXo4elZM?=
 =?utf-8?B?dnJ2T0NrUEthaFZiYkwzamw0cXNPUmZMdXhpYkQ2b3Y0VXR3Q1pCQzVPd2RR?=
 =?utf-8?B?TWdYcmlFd0lza21UMXBmTUdlaklPQWpUbFk1aGR5Sllvb0tFS3BqY1lGTTVa?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65168c18-20a3-4f49-dbdb-08dcfdf0703d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 23:20:29.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/d6WIrBHDncl1/53LjcDPCoFF54kPtV2mVkjOauc8sn8rysgwbS6p2Hu09JOJNSRysoTp8kcUaVQYCTSggnmPhV1HdYG6inCoCkfpjIrD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6018
X-OriginatorOrg: intel.com

Hi Peter,

On 11/5/24 3:25 AM, Peter Newman wrote:
> Hi Fenghua,
> 
> On Mon, Nov 4, 2024 at 11:36 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>>
>> Hi, Peter,
>>
>> On 10/31/24 07:25, Peter Newman wrote:
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> index 200d89a640270..daaff1cfd3f24 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> @@ -541,6 +541,31 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>>               return;
>>>       }
>>>
>>> +     /*
>>> +      * If a performance-conscious caller has gone to the trouble of binding
>>> +      * their thread to the monitoring domain of the event counter, ensure
>>> +      * that the counters are read directly. smp_call_on_cpu()
>>> +      * unconditionally uses a work queue to read the counter, substantially
>>> +      * increasing the cost of the read.
>>> +      *
>>> +      * Preemption must be disabled to prevent a migration out of the domain
>>> +      * after the CPU is checked, which would result in reading the wrong
>>> +      * counters. Note that this makes the (slow) remote path a little slower
>>> +      * by requiring preemption to be reenabled when redirecting the request
>>> +      * to another domain was in fact necessary.
>>> +      *
>>> +      * In the case where all eligible target CPUs are nohz_full and
>>> +      * smp_call_function_any() is used, keep preemption disabled to avoid
>>> +      * the cost of reenabling it twice in the same read.
>>> +      */
>>> +     cpu = get_cpu();
>>> +     if (cpumask_test_cpu(cpu, cpumask)) {
>>> +             mon_event_count(rr);
>>> +             resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
>>> +             put_cpu();
>>> +             return;
>>> +     }
>>
>> This fast path code is a duplicate part of smp_call_funcion_any().
>>
>> In nohz_full() case, the fast path doesn't gain much and even hurts
>> remote domain performance:
>> 1. On local domain, it may gain a little bit because it has a few lines
>> less than directly calling smp_call_function_any(). But the gain is
>> minor due to a lines less code, not due to heavy weight queued work.
>>
>> 2. On remote domain, it degrades performance because get_cpu() and
>> put_cpu() are both called twice: one in the fast path code and one in
>> smp_call_function_any(). As you mentioned earlier, put_cpu() impacts
>> performance. I think get_cpu() has same impact too.
> 
> get_cpu() and put_cpu() nest, so only the put_cpu() that reduces the
> preempt count to 0 will call into the scheduler. See the source
> comment I had added below.
> 
> But... note that below smp_call_on_cpu() is now called with preemption
> disabled. (Looks like I only benchmarked and never ran a debug
> build...) I will have to change the patch to make sure put_cpu() is
> called before smp_call_on_cpu().
> 
> 
>>
>> The fast path only gains in none nohz_full() case.
>>
>> So maybe it's better to move the fast path code into the non nohz_full()
>> case? With this change, you may have the following benefits:
>>
>> 1. No performance impact on nohz_full() case (either local or remote
>> domain).
>> 2. Improve performance on non nohz_full() case as you intended in this
>> patch.
>> 3. The fast path focuses on fixing the right performance bottleneck.
> 
> The consequence of reusing the current-cpu-in-mask check in
> smp_call_function_any() is that if the check fails, it could cause
> resctrl_arch_rmid_read() to fail by invoking it in an IPI handler when
> it would have succeeded if invoked on a kernel worker, undoing James's
> original work.

I think this change already undoes the motivation for 09909e098113
("x86/resctrl: Queue mon_event_read() instead of sending an IPI")? As you mention in
changelog the goal of that work was to enable resctrl_arch_rmid_read() to sleep.
This change will call resctrl_arch_rmid_read() with preemption disabled if
it happens to be called on CPU in monitoring domain. Would that not cause
MPAM monitor count reads from CPU in domain to be a bug?

Could you please try out this patch with CONFIG_DEBUG_ATOMIC_SLEEP=y?

Reinette



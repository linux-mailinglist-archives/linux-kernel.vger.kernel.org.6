Return-Path: <linux-kernel+bounces-402450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37549C27B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75CE1C20AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E11FB3DC;
	Fri,  8 Nov 2024 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgA3hXNs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB11E00B6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105784; cv=fail; b=ukP4acx6/lbFm+FXRKYd0Mf6pjeEA4uhByUKPH4qvJ8F6q8q/4BgaSN5rMKTymFDrdDQJQYEkJFH6YJxEYYkXLjcXrPGEsZw9oMHcQxGVhQXF0mHsynUEwUCmGWhPsXqmpT1ebSUJ6l92dTYYjiR3tBCu/JPflRiEvoZj4Fd4fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105784; c=relaxed/simple;
	bh=6iuD2IJ7kehJwDWdvbwsSlLS6prkIODQvflIKqcKn2I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s4OMOg4z6x2qI0YyDe2095vUVrE1V/cXgK6AEmwXmP8884QQ0i/5ZMjOcFN1qpUrNiK7xzocH1XsPwrZMklxA2QXrakEYIL6AC5TfarvW1tWF5e5UUJ7ihFHpVGbSsGysU7Zxh+9EzVzmql1uuPsUJMkoIEjsAUKK9Xw0sHUCPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgA3hXNs; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731105783; x=1762641783;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6iuD2IJ7kehJwDWdvbwsSlLS6prkIODQvflIKqcKn2I=;
  b=kgA3hXNsJEB6xXqjFEPw/nS6it/dV+L1LgJpZxzXmKamlZrFa3k84LaJ
   dIQ8E5Dw+Sf/+1TalHDd0PocOTId84qV5FZAd1URUeFjFjyUWKdJRcwe+
   PpzJpWdXcQDrE1JPIg6OcFd8ZwwIOP4vQ0IvA3Utc8ayCj6Ne1xoHmM92
   bAiahJSlr1ve1dzdZ22jte7Rb9zksf/nboqO1Mrr1bXwFcW8TLIe4qHXb
   eITfYqCFhjbF0egUWF6/bQYS6cYKIXNaJedulE7MrXqHasHkynFtJtvKS
   ogUsfkXNk2HhA2foxzlIKISwbIvDGLuAuBdXbWNRhiuA5bl9Qr6xtn7kf
   g==;
X-CSE-ConnectionGUID: ihscVyGrRHKq4E/zlP/ATg==
X-CSE-MsgGUID: kYDwjPoQQUqnwJsyFN++pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="34942226"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="34942226"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 14:43:03 -0800
X-CSE-ConnectionGUID: rb28OpxuTs+OuBOyvADAGQ==
X-CSE-MsgGUID: dz0tZ4SxRmSVkIxohHBQkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="85265500"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2024 14:43:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Nov 2024 14:43:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 8 Nov 2024 14:43:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 14:43:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKTTBcolp6kcDnbE/jtq3M0/qFX6UFS2SC07WZIREclfeXBA29aNB8JBAFNoN0YQznTmXAZansMBZ46WxRCDRklKKnvKkf6WuvlRI75LCUoB9cYm8aPyjhbm8lvoO1pF8BA+b75av3p/hmSvg6nvo3TAkr0vBNxItV1JqOaibS0AJSkzvsahN4JOAvFbuosfgO/k2VJSiWQgD8H0UxvO2V4bl4i1Eqiy1Hs+curNl8oQy6u9e9/7mpUwZlStoa4WtpBEloxyDaOAIy6H6sdAPQdyqtHobV9HujzJGDyvzB8aTm8rO/lWJUdoXA8IwnB0CHG0/TVCxhnXhY/Cug9fkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvbpsU4X6FZaYVxqmzAhd/5bOCGQ/T+CqfwfvYSd41c=;
 b=VmioLXXmVpFSpBrseBVhJ1XWvEskXMCMBAt2ra3jLCkQMA5PR7Mp1EF1uTPUTTBEXNrg4KJMi2O4BGORdDOg/NsJM3IklBq26xJeq6XMl5ORfU1QTuBVKI5VnnJBeigkh+YMyBhL5NFkBAID4Gf3jLgQwMIMdtIl8Iu+/u/sZ8aNeIYeRfmLvWg2Wzgvt2C13MvmiZ8TpEfU8alD9ysFVi+LJB+LAFuvVGJpTk0SyROxTRZHyj3yf6/0vfOXPQv52uzqdKXo/i7F43AJvF45U9fid1BaquWHlZyN//rgnQaW8AhBXZq7SrSTFQCUSwBQ0ZlnFY64dII9ErZgZ4y8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SJ0PR11MB5039.namprd11.prod.outlook.com (2603:10b6:a03:2da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 22:43:00 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%3]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 22:42:59 +0000
Message-ID: <dcb6d46d-c34d-4921-a881-ad8705d7129c@intel.com>
Date: Fri, 8 Nov 2024 14:42:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] x86/microcode/intel: Prepare for microcode
 staging
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241001161042.465584-5-chang.seok.bae@intel.com>
 <20241104111630.GSZyitDuXnBYmEFxvo@fat_crate.local>
 <d8d3959a-8c38-4ce4-885d-6a1e40219831@intel.com> <871pznq229.ffs@tglx>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <871pznq229.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SJ0PR11MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 73235846-cb82-4413-bbc0-08dd0046b25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UysyWVRJRE5FbjVuVTJidWV4ZzBvUmRTTTE2YUtSbFhVc0g3bVBDUEYvdE1y?=
 =?utf-8?B?dXlrbmFub2dQRDhaU3lmRXBTNnB1Y21tOG4vWWM4NXlRQ0dFZWpocjk1Yklo?=
 =?utf-8?B?cG9LUUZxd2NWZ2NYb042QkRRNnVYZ05sajVGTjB6L0ZwekYzMERRWDl4dkQr?=
 =?utf-8?B?akNCK1NyZjNrb2pJRnVxZS9VVWRPQnRyWG1nczE1ZDFjd25BTnVvTHNWM3ZD?=
 =?utf-8?B?bUZkeE1xaW9UWXZOY3JxRGo1K0dSSWtyM1JaZ3B5czIwK1ZNOURweTU3SVp5?=
 =?utf-8?B?c2V0cVV1YTh5cExZa1NJS2t1UmI1K2EydG5zM09QUkFWUytRaVdpQnYzbzF0?=
 =?utf-8?B?bVNxVHowRWYxZmxocHBDS2wxbTM5TWM0ZGZydnNzNTVlakJpdTE4VHp6RW55?=
 =?utf-8?B?dUpQZG1BVHJmS0FUTFg2U0ZEZUlYQ2hsek9OQlo3UzNSOXhwNnY4RjlNUGM2?=
 =?utf-8?B?TzlvS2ovWndsSjZKNnJpYjhyNytYcGxIMyswVXM0bjEzMStoNHA5TEN2MVhy?=
 =?utf-8?B?M09ZeC9pTTkybTZsUklaRVAvQi9tMmF4UGJDUThhQUY3cDhyQlpRUzVjYWQz?=
 =?utf-8?B?WHhLTm1vV1ZLQlFsNEw3UnJoMW1OdVhTMDg5OUI1UGtxSGxCRVJPYmZhOEVE?=
 =?utf-8?B?a1R3WkZRbUdFRmtwWnlva2Z2WUc0bS9TdWVkUHhCRVNReVFYZ3dWaGdtN0w2?=
 =?utf-8?B?U1kxUEVEM3I2Y2hRelkyMU13T1BFeXU4SHJjWDAyUjFQbW1oZmZiMVNLRW9E?=
 =?utf-8?B?YXdVMTRaWVk2U1JRMHU2RUE4VTBZczk3OXJFbXJzZGFONWIxcXBhSWpOMnNJ?=
 =?utf-8?B?SVBiNXpwRk9DUHE4cDlmdTFGcDRWSEgycEo3UGxRZS9WeHE1SkkyUVA2R0ZK?=
 =?utf-8?B?N0tIYjdZSXJPbTJtRGJPZW5vMTJaSlp6MU5IR3lmNis2WVk4Yitxb1Q2aXN2?=
 =?utf-8?B?dlJOSHI4UUxHVVRIcHdLeUpQUE9VQXFHVWhZd1lrRnVaSnlZZXhsQkNxaEVh?=
 =?utf-8?B?WVdzYU5tNEI1anJZb3VRMWVmT2FSV2hkSTdPZWp2RDdhNjh5RGt4K2pjTXNM?=
 =?utf-8?B?V2pHRWdRNUJWN2twblJETVJZNEVZUFE5ZnN5aXVnM09BV05EVGpMZWdIaHdM?=
 =?utf-8?B?WlVOUjJYenhaWGMwVlVTMHpwNTMwSXB1dkFFaTZJT0hac3JVMjkxNTN0N3Za?=
 =?utf-8?B?bHExaXdWR2h5V3pyc0R1bTVsTzlnU2wyQnA5bTRtdXdKWlVuWFJSZFN1NXlC?=
 =?utf-8?B?c3FUWHlEc3dNbjZTVjF1enBPV1BtSzNaMGtXRG8zNVhMQThGTFFnSGJtRFFE?=
 =?utf-8?B?dEdoZmg3R3NtQTN1UjcyMFBLYXFGaVN3bkozV1R0bjhobExqK0hXRzErZzdP?=
 =?utf-8?B?d3Z0V2ZpYWNyYyswQVpGZVJ2dlVtSFFFaGc4blRXalF3Q0NWZzhvbjVkY205?=
 =?utf-8?B?OHJhT1NBZzVTQ1d1Q2FEcFRzNERsays5eGFKSW9oWFdyN093blMyNGNuamsw?=
 =?utf-8?B?NkRSMGkxMlJsN0luTGwzeW5tMFVVVGFmRUxRc3JjNDJaR1M2a2tkSFQ4QzIy?=
 =?utf-8?B?L3RLUHFsWDV2SHFJeG1EdmlLTUs3cmtUeHhPRndXUUpwai9GeTJwWHM2dTh0?=
 =?utf-8?B?UVBBYk5RTncyRk14L3NYNnVQUGU1TVVJMFB6cHpZVXFIR3VhRG5vZGE1bnlv?=
 =?utf-8?B?T0VYZURxODhDZW1tVnFNUzBqZytZaDc1Y0gxNXB2NlZMMEFMbmpCR0FmNFRQ?=
 =?utf-8?Q?5kD0tuLVPTldn92XNTKZZDYcqhG19Yg3ECKp4SB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXc0VE9UY2VDN1dMckZQWjM0M2FnZmVrMUJraXBtYTZUb3NLYkJSekxvb2tE?=
 =?utf-8?B?b3U2YW1IS2pXNEJEWjZ4akhuNC8yMGRHZm5WSzZBb0txRXAzQXMxQXh5ZTVy?=
 =?utf-8?B?WS9WRE9Jb3E4S3M0RVdMYnFQZHdoRDA1bS9zQ3o2amZpbDd3cUlEdkltSjVj?=
 =?utf-8?B?Z3huZGJnNzhZWkMvUnN1TkhpSFd5VjBHMDJSZEE2MlBnUHRUcGJrdTZlZTBo?=
 =?utf-8?B?c0hiZ2oyQXhieitGanNMak96VlJ2cmVpakRVKzQyUWE3ZGNTZ1FsV3lPeTAz?=
 =?utf-8?B?b1pFV3JDUXdyWWFuRUtzUnRvSndiNVQ4ZnZhb01nazMxbktPdUROWlRpRDFL?=
 =?utf-8?B?SVZ3NktZVG93OUprYXpHTVhBNDdCZzFzaUViTUdmSnREeDhjeXJPQk5vUG12?=
 =?utf-8?B?Y2hZU3RpTkpLSTJ6YzJCVzVCSXBHdjNkYVFpNlVCblgzY2NNV3RVd3FMbXlX?=
 =?utf-8?B?MWNvcWJFeHY0Vk1iaFFrZDNIcjFvNFFiNndyd00vRU5QRFZzRmFoYnE3OEtU?=
 =?utf-8?B?WkVtT3VSbXdrVzVmblBBYThCZmVpeE04djAzOUJIaVBSN2NmM1Q4T2JtUlM5?=
 =?utf-8?B?eTNDVzJaak5acSs5SGdXdkJES25aZTVFMjhwMUY2YnM0SHJoWTVOVmRudloy?=
 =?utf-8?B?MGhQbFVYRUxYeW91QXZGdFRjV1I1aFlPQ2EwWm5XUmZCdkVlVElRNjBGK2lr?=
 =?utf-8?B?QkhnR0FvekhNcFRJMUZBeXgyVEd6eXZPMDBGd0tXK0JDd28yVCtFWGVZRWZo?=
 =?utf-8?B?anhSell0cUptVk95R3pEUDE4SEFFcGRka0hPZmlDaC9WUXNpWC81amR3eHcz?=
 =?utf-8?B?Wk5zQ09NZ2ozcDRjVEMyK2JYMkhwQm50UDJ4ZTlFdi9FZklPY3hpZHVmajYw?=
 =?utf-8?B?SGtSa0IrSHFhdnczTXN6czFheUNadit0NEJNSkFSWi82ZjJqSURIQjVSck5s?=
 =?utf-8?B?T0NkNmpLdFhKa3pRUG5iV3BQODA3NERWdk9qWnRiWUVIbU9KWHlWOXpMVVg2?=
 =?utf-8?B?RVFSaTNYVk81MU5UU2dpS1lwM1FSYVNRTTl0T2dPT3V6NUM1M1RmNWJTb0FU?=
 =?utf-8?B?VC96YnhzaVhmeEVnYjlXREtNK0loQzdENTVUVkNFczFBRWdZc3g0Z00zQ2V6?=
 =?utf-8?B?bUpXcFJIR3ZId3cwQ2NWUzAxdmd1UGJ6QUY3SHVTcno1b1VqQk9nWmhvMW12?=
 =?utf-8?B?S0NhUjJsSkEyS1VCclpFeFNJMVoybGthOU4xUWtTWVZQWGlwK0FUUExFY01H?=
 =?utf-8?B?dmNwVUVFZnlNc0cxS2hNNzJkUm9FR0xCNTZjcG1RdzFNTDdvMy9GRGE4L1M4?=
 =?utf-8?B?bmhuZzBCK0RmSkNuTEIvWng0MFdJVHhlcWpwK1kybllIOW14aTNPV3hZZGVx?=
 =?utf-8?B?T0JqMjFqb3gvQnc4VUZ0ajZ2THVEdm5EZTU1WGhGU3N2a2poeG44VHNpQXk4?=
 =?utf-8?B?anU5VlpvYkRiY0RFUEFnNWFlK1lvR0h0QmFFZUpYM3FDWnltTDNjb3kyTkxj?=
 =?utf-8?B?Wk1lb3NGU0JlaGtiKzhucUQ0ZXMrLzZaOGxyZXlJRURZM3hWc1FKOXhCeHR6?=
 =?utf-8?B?RnV5c0dTc3pKVmlPZzlsUXFDeUxCR3pZMTdPdWZieHpnMm9qeHNUZVJCZTE1?=
 =?utf-8?B?TEQ3dGhROGMvdWQzc0l6TWNtbGpyVExQN01hdi9IbkpnSU9RenlzVnZIRnNQ?=
 =?utf-8?B?elc2SDgwMjFGQWdtVTUvcXo2RXB4elVHcGUwVmd0OTJlQlRuY3RKM0hBOXJG?=
 =?utf-8?B?MVBZMU5sWS94QUVwa1RJanlYUTdWRFlnbnJNaHZFWTkrZEp1ejBDZVlickpF?=
 =?utf-8?B?eTVMSlByVUJQN1ZrTFh3VEFzTFZLdUtTV3RoNWE3bHA5UkVNYXJoWXZLT0JZ?=
 =?utf-8?B?dU42YnNYZy8ycHd1bE9YQjNPdG4reEtmZTNBSW1yRFlEMlRmemNQVVQrNnBa?=
 =?utf-8?B?MHVzdURVTWFkcCtmeDNKd2tqK3RDektZVmZOdjRuUmFuS3EwbmhtZGs1Znp2?=
 =?utf-8?B?YnlMc1RwN01iNENBbUlZeWhDSi9tUkZveVB0UzVkSzV0THJ3bDRaczVSenFo?=
 =?utf-8?B?K0RoZnV3bWp4RnZoNUZKYU1aWUw5Z3dHeG1iV3ZKSm5WZTJkczZZOWJZZWE3?=
 =?utf-8?B?YzRmbTZQeGR6eWNBOTVpeE41RkhPRW4rQk1Hd0hKZkFkdkVKQUE0cmhWRHYr?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73235846-cb82-4413-bbc0-08dd0046b25f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 22:42:59.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpHS0ragHEO4KoAFuxa6ElGAqcyEgNZM5BSRIV01GzBDkyhc1oAXmd/C9AoM9aTKCfgBg1P995HYgHs+shTeD8q0UZzjOMWs0P6dxg4GYXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5039
X-OriginatorOrg: intel.com

On 11/6/2024 5:12 PM, Thomas Gleixner wrote:
> 
> This looks all overly complicated. The documentation says:
> 
>    "There is one set of mailbox registers and internal staging buffers per
>     physical processor package. Therefore, the IA32_MCU_STAGING_MBOX_ADDR
>     MSR is package-scoped and will provide a different physical address on
>     each physical package."
> 
> So why going through loops and hoops?

While the initial approach was like the one below, the aspect I bought 
was to avoid relying on topology knowledge by simply searching for 
unique addresses. But you're right -- this introduces unnecessary loops, 
complicating the code anyway.

I should have explicitly highlighted this as a review point, so thank 
you for taking a closer look and correcting the approach.

Given that the scope is clearly stated in the spec as packaged-scoped 
and should be permanent, I think there is no question in leveraging it 
to make the code simple as you suggested:

> 
>     pkg_id = UINT_MAX;
> 
>     for_each_online_cpu(cpu) {
>     	if (topology_logical_package_id(cpu) == pkg_id)
>                continue;
>          pkg_id = topology_logical_package_id(cpu);
> 
>          rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &pa);
>          staging_work(pa, ucode_patch_late, totalsize);
>     }
> 
> Something like that should just work, no?

Yes, indeed.

Then I observed the package number repeated according to the CPU number 
mapping. For example, all SMT sibling threads map in the later CPU numbers.

Unless staging redundancy is intentional, it can be avoided by tracking 
package ids. But, in this case, the loop may be streamlined to SMT 
primary threads instead of all online CPUs, since core::setup_cpus() 
already ensures primary threads are online. Perhaps,

     /*
      * The MMIO address is unique per package, and all the SMT
      * primary threads are ensured online. Find staging addresses
      * by their package ids.
      */
     for_each_cpu(cpu, cpu_primary_thread_mask) {
         ...
     }

Thanks,
Chang


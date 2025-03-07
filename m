Return-Path: <linux-kernel+bounces-550453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7427BA55FC2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92BD1893768
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3B145B27;
	Fri,  7 Mar 2025 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGAcRepG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D8664C6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741323883; cv=fail; b=ACJLXDgANsWvmC3vfbsWpq9JhTHgYVVpNhhLPB9t5OgHyVs78X8OrQhbraCeM1+AnpAGjuEARXeMCtmQSEFjM3LHGb6dTtKSeBHqVqOyfIdjbBhcyE4ASCGHeoPS3oq8kaAZwuaVkG4kd5RLx+pYQRBr0JlQ8iKMX7UjPjPByzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741323883; c=relaxed/simple;
	bh=NCsmE4qNZVBhK4kWrHj879Ogh2JCN+05RvCATfeBA8c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R/lvC/U0BEPs3K4K0cO/leWwUvaMbN3egSLINaYfMTCRdaVGYB3tYGU+SdBGJa+XtIN8zP1NoYepSnDAVtmtfUBQMktOUo8Tw/p2HTUSPYINyGFFw3QJL7RP+VKl+NJJbYmnPJpjrcGF6+tYZinFCzw15zUwx6e1+PCsflSP4nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGAcRepG; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741323882; x=1772859882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NCsmE4qNZVBhK4kWrHj879Ogh2JCN+05RvCATfeBA8c=;
  b=PGAcRepGqQlhO/B9inl+O0tdaR9NJceuhG24aGNFqKNaEvMIWYoQdSGQ
   fkkf2s0Ar2vSgA47TIaAVRooba+ISAzMzv6uipNV2OMa3cFCPZlcXZl3c
   WY18nfUMlknFjfOD0Rb6FiWuG+qqpbvX7FxdDAnu0nOI1YyK4ta8x7lXY
   Ocf7p6OOBiKaWFsxkmGMqQMxEJ1lAvdwM1ATjGKm90CiaXEizYeiNQhTE
   rD6g6vNciJI045vm4dABCPnN8fifh0Q7aJ/bzaXZmmFBqIxYNfnZ2Ti1d
   IbsarfGEbrj+i/uJoOxgepteN9gQb4Bjj43y370sNEmMoBjIGCqXzoyFQ
   w==;
X-CSE-ConnectionGUID: VcQioUkcQQ6wPXlvKFBbng==
X-CSE-MsgGUID: tLrg5vk4QFSs3NT/h0MNvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="45170628"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="45170628"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:04:40 -0800
X-CSE-ConnectionGUID: 84z2hrHGQbWgkjDl4i3C+A==
X-CSE-MsgGUID: UO9UK+p4SPOno7Ev45mwKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124429796"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:04:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 6 Mar 2025 21:04:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 21:04:40 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 21:04:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImZGXyJw86VHyvT/z8nxOdOTgH7C0RhLKUg6rppXXixZOE4lHsd/Ft/Cd7DCgZx4RaFaE68QigeFy1j5JWlQ7m4lX8NMPB3ZY899WzsO03i+lJxNpwk0r49hvpw3Oz0rCLh4OsUzuy1WwM0QSuMqhyNMySTxRnXmuy++QlpDrUBWvweafZlai8igLWesZRvCRVe1gTAfTc5r2yIbCV/wpADcBW3zdKkaKmd9mVivtU0PW8j+aZbstq9JOuIMfdhkq38qkQTJe7APGisugitpyNUxl6vQq7SKXFuNOOvPeq1AiGeDrgRWycc4V6+WTBOdfSDcNOmnvNSUz9mup6JMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2NPMhh6ABvmybgAUEO3or/zd1m+O5F9h9+iucerzUs=;
 b=b1oTQ24CYb9Ejoiw2sxn8TCWamJaB1tnUddYryeZXBlaPAdfuPXvrOL0jx8AE2ar9yHriC7aIYLLA+X7YMw3V1FbCI/IQHaBTD2RStdeEaeO0ECfdHcOp5pfuylo1TYr6zfK4RL/5KOdN2KZ1ZwjcZcVW0HqGA8gWmcq00cGj5lquFQEHUEHxnDNvb31DCnTLNxRKn/ix+A4fS9Esr1pwbZ6f8Rpx2ARX+cVEKxp2sp1RzgFGOoBGW8vWQU3kJ4FGufq6RntWhLb00vjGQxLZWVacas4QHjHvFgkzoIta8f6o3WJP0ENEoROJZgzbc3uIklNsCLtBthkUzNbtTPcdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 05:04:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 05:04:37 +0000
Message-ID: <f140e607-37f8-48c1-ae54-58a20a980331@intel.com>
Date: Thu, 6 Mar 2025 21:04:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 39/49] x86/resctrl: Split trace.h
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
 <20250228195913.24895-40-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-40-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8381:EE_
X-MS-Office365-Filtering-Correlation-Id: c057c8a5-5551-41f3-2d99-08dd5d358f38
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDFpZzBlNXFOM1oyOEZGRGNXOEc0VjFWc1V2ZUdRaWZzMGZoQmJVVGZzQXpU?=
 =?utf-8?B?RXB6RW5VMUkyOWdJTlU4bm5UdUovS29ySHhsZ0lWYWtsVkZubjZTZmxqNkdq?=
 =?utf-8?B?TE1tSXZvL1o5Y0s3d2ZNSlp3ZzdSYUFRRlpsWkF1VnBtUi8zakhTY09DV1Qr?=
 =?utf-8?B?OUl3dzdwQkZNNzBKVEhmdEFqeW9lOHlCSDdIb0xtdVl0aUhPOXNTYTlMVTUw?=
 =?utf-8?B?NG0vdmkzS1VOd3VhSUppU3Q5UXVXSGNJbkl4dzZlTHFCSTZnM3VKM1hZdnhC?=
 =?utf-8?B?WXF0VjFSQWtoU0VIRW8wd3FyWnVTdDd5TWFiRzJpWWE1MFZ4cTBZWHptT0lr?=
 =?utf-8?B?RnB0VWxXL1ljUkwzNnBndFNSOHRxamhFR0luazBhL2dTMjVUdzV6Yys3OEVZ?=
 =?utf-8?B?ZnRKYWVVQ2M2TnE5bUpGUDloRlpKTEliL0hhY1RNMGNmd2lkbi9IUzlCcXJV?=
 =?utf-8?B?N3NnNnNXQzNkWUdMRTM3N0U1ekNHa0VQRTgxU0RMbndrZU5zeTlvQTZjdFBi?=
 =?utf-8?B?em5TNmp0WlNGZmdzaFV6U1JNbElZVzZoVWgvUS9mNjY2aHRHVXhiVGFPaFB6?=
 =?utf-8?B?QzhyVjZRazJEQXJvK0M4b01qL2JCYnY1cURkZ1lxUTVrOWpBamEzUkN3RGVW?=
 =?utf-8?B?d1J0TGZTNlgxSVlMeEFkdlYzaVdWQ1d4dEFrTUN2cFExUFBZZU45SmgrYjZr?=
 =?utf-8?B?YXlLeXFXRXJCRXpjYk54Y3R4bmZyQVZDNGVCY29FRUhpQnJ1RnE2OFlpMjIz?=
 =?utf-8?B?aTNMSm1DNmVNNVdYRFE0WHVNcHFNeFkzb2xRRFVPbGxHVSt5ZlBFWVhDRkEr?=
 =?utf-8?B?UVhQYVcwSisyNG5zQ0E0US9xdDg3MjJCSHFMN1lyK2tiaGx2djZ6VklwWm9y?=
 =?utf-8?B?em5pY3kzNS82Z3IzcVBuTkJ4SjhoSGpTTVNKbUV0K0xNd09uRXYzNEJZcGhQ?=
 =?utf-8?B?bHRGcWRoczJZWnVRaUt0L0x1VC9HQUd4T1BIckZ1YVBvMFJvbVpmeWFuTXVw?=
 =?utf-8?B?aXZEeXByeVRiM3BhekVwRThoMzF5UXZHWUZTQ0lsc0VEUytyRGhPMFNCKzRY?=
 =?utf-8?B?aHhUUGg3TC8xUExDYUUxS2xKUVZSbWFiNVdvRnJ0bzZRd0pCa0pmNnBEcUtQ?=
 =?utf-8?B?dUx4ckM4d2FubEs2UTRzNnZJc2VEYlFEWEhXSFhzVTRsTEpPcVY3OXEvQ1h4?=
 =?utf-8?B?RjhURmY3Q2w1Unl2WW9aVkRQRU5aWkdoRjhtVmFxQlhOZU5ibHZQQkZMT3Np?=
 =?utf-8?B?Z2hpL1NJTkpNTkdRNXlGRkxodzZQRnVwMmx4S2pyK0VjanZXSjRtbEVPODQz?=
 =?utf-8?B?cmpwdVpZWlBBRzlva2QydkFCRmlCNEJRZXNycG1Kbmh5TVJETnJjSUdTRks3?=
 =?utf-8?B?clVxL3FEODBjVml6SU5WTW1pWE5xdTNNQlU4SGwvS3pYSjU1bTJUeDVkU0F5?=
 =?utf-8?B?T0pNUGF0TTNqeDRMQTZFdmFWWXpOUEZIY294MGRoZlU0VFkyMU4vMHFFbnFl?=
 =?utf-8?B?bE5HaXdrN2ZqVk01aXY4VVJ6WU1CYThWcXJhbDhYUmkrRlRmeU1XZGNweEhQ?=
 =?utf-8?B?eUx2aUlXZksrb0t4TTREU1ZCOUREaTdVVmZHUlNBNFV1bTNTd2tzemtuYjUz?=
 =?utf-8?B?c3RqV04wZUVSYXNOMHBUMFM1bmVGY0F3YnVxZm9GdHFCQVM1TDlSK053Tm56?=
 =?utf-8?B?ekdLblI2cE44QlhJM3ZqTC9kTUc5NU1CanoxZWRrQ3BrMS9aQVNMLzNybGR3?=
 =?utf-8?B?RUxBSTRIR1hiNVpRM1hxdW90SzluVHBVcFhCWUtnMitYdWZmcDJpbDk1cG4z?=
 =?utf-8?B?bUtBVXE2NndRR1h3Q1lJRHVubi92TWtzNm5VV3lycFV1TjRPODhDTUtYSUJQ?=
 =?utf-8?Q?KvxpiEj6X+Rjz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFtazcvMnJ1TXd3ZG1KTXErci9iV0dDSmpCS2haUkZ0Q3ZaazVZbFN6bDda?=
 =?utf-8?B?Q1Z4T2E2bTdtNjBtZm81L0JXdVF0RTRZQWlrdXU5cjV3d3A5eXB0TFJZUS9x?=
 =?utf-8?B?WWRkazdJd05ZR3ZjTFcvSzRYYXkzbSt5bWowWDFKMFdHU2F6OWh2M2E5Wkdw?=
 =?utf-8?B?V1JlSkNySzY4SHo2NGFHQVg0cUJHK1VnRE5oRmd2QjZ1UFEwaWZac1pCNFp6?=
 =?utf-8?B?SVdiME9lNlBZK2VyRVZnaTR2dUxYK0RtMElOVndaZUM0OENiNy9BWFEzUFNN?=
 =?utf-8?B?dElXd2NVMUNZZTJ1eGlLY2RvMStoUVBOeldlNmo0S0NMa05aRUpCWGxGcW5D?=
 =?utf-8?B?andVZHd5Q2VYQ21yRnRPRkVsUEc1b3l0bHpTVkZHUzFvNXZBTUExM29tTm5t?=
 =?utf-8?B?aFJDTEhTTGp4dmMrM1pyV1J3Ulh1NHNYMWQ3MzQ4dmFFTmcrWW9oY2FneEtI?=
 =?utf-8?B?OUt6NlEzNG9sRlVUVmVsUWlwaldYMWtvcG1JSlBwc3cwMGZ3dEpkRElqQkxJ?=
 =?utf-8?B?TlJsdlBsOXE3VGVGM1Q3eDZxSmN3M0pzN0V1blNITTRhRnpPdlRDNjBndU9Q?=
 =?utf-8?B?a01CbXVMK1M3aFY3WTdjZURkcVZpTDhvY1hYWFdtczg3Y2ZqUzN4aDVMb0RY?=
 =?utf-8?B?NW9JV2ZyQk5veFdSUTdCdnhJYTVIb3FwYVBwSUVUejJDV0ROa0xQOUJraEVS?=
 =?utf-8?B?ZG1rbDE2V0VkNVZ5Nk14WFFuYnhvYmVoazhBK2JkaitUTEFXVGJ1VVU2cmQv?=
 =?utf-8?B?V1hmcHpkWVJ6d2lFUENYemhodGE1b1Q2cFVDMWlzZnBlRXhTRk44ZXZLZHAx?=
 =?utf-8?B?ajVYSk9tZG9iL3JubkdJM2RiZGU1WWRNZ3c3QjFJMHRxRThENEt5WGpzNktY?=
 =?utf-8?B?TXlUQjI0a01JOVE5UkxQQ0laTldqZ1N3MGZyR0FUd0tsM0tsdkFRenlGL0dz?=
 =?utf-8?B?YUFBUUpCUnQvdHRyUnJYTUowb2pSTjZ2cjY5QnhjTWR3RG5wTFdWTVpkU1hC?=
 =?utf-8?B?MHM4UHVZY2VMYXA3SU9qWFRrZXkzaFBJRWl6ODk0bzF6emw2M3ZwaFhhUzZv?=
 =?utf-8?B?YWxnOFY3RmIvMGlkK1NOdmdrcEdPalUxK2w2NFZoU25uczIyWHJhbGo5eUxV?=
 =?utf-8?B?TUhoNkxHT01WQmZ1bzBvVGRRWCtINTQwTlhEelRkSW5vcG5ESUVVQkxoaUFm?=
 =?utf-8?B?alJTSHhRWEdUQ21wVUEwKzlyWDQzYjhmcUFKYlZmVFRuM29OY083bGpPNUNI?=
 =?utf-8?B?aURDU0d3MzJFSG9BK2NEdEtaNXIzbitVS3dHY3JzK1Jodk1KT2JPVm5ORjR6?=
 =?utf-8?B?YzZxK1RsRDBnRzVhc1J4cGZZdFBXZElPTDExZUx4Tlo1L1dSQUQxdjNCbHhV?=
 =?utf-8?B?NXR4S1Q2R0wvWTlFWHV5dndTUG5LWHBuaFh3emNXNVEwRmVlK1A2Zk5KMzhZ?=
 =?utf-8?B?UzljMjJsUW9zYnRyZjZEdjIzWEJNazFiNG1QSmZIS3RLeDJOR0d4UUg3Qk5Z?=
 =?utf-8?B?YyttUkc2dXJhRkFnUlptYld0d3l0RWR6WlljQkhGL3dBOURneHd1OVdsMFlL?=
 =?utf-8?B?cXU2V3JXYnJzZE55SDBhbG5lNk5KcGRlN0ZRdWwxUWtTdlhBSFllUGJLNUJw?=
 =?utf-8?B?OVhsZWJtdHpYVXFoOWVzOVpDbVdtSTQydEFQZ2JPMUtZM2xaUW84UktDeGM2?=
 =?utf-8?B?alZnWU1WQXQ2eEJyVXBCRC8rUWxpdXZzOHZCK1NLTitESkJFVXo5a2xiMStM?=
 =?utf-8?B?SHZlbWlwT1VmZWY5NkM2eUJaZHArd2Y0b29Wc25uZmliSGlHTU1PM3AyZTBu?=
 =?utf-8?B?cmpnNFg3ajlOd0tJaEZIbS9oMWJ1RW1VdG5TVFl6OHZWTW5sdERwTzFaMmZE?=
 =?utf-8?B?V0hURzJpSktHYkxJei9hb2dZVEJxWWp6NDBReVU1eis2VCtXd2tHS0xOOEV5?=
 =?utf-8?B?dGRpZnNVQVcrb2lOa2p6Q3EzUmFnM2htOVpmcXN3SlRGd0hQNm05a3R2S25J?=
 =?utf-8?B?cjhKSDlnMXUvYzhENHFEcUp1TWRuaHBvY0dpYWlwTWQ3RSt0M3o2RVFOMkRL?=
 =?utf-8?B?cldGdzZWbElxd3FxLzB2VE95a2laam96NnNwRGFRcG5RZGRXTU8zTGc3WTFj?=
 =?utf-8?B?dmtQSHF1L2pNbUF4REJIR2ZpSXJYbmVVL3dZd0ZJQUltZFRaQnc1cHl6OTN2?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c057c8a5-5551-41f3-2d99-08dd5d358f38
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:04:37.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N6yWOuGFWFovqdgay8qUG836atOUTneEjYbq4WgPxDawQDEc6B4X2bz0Y0SQDzd4lWER4vrnYkbFYF/XeOw5qPHTdhrCWK5o2q3PudAAZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:59 AM, James Morse wrote:
> trace.h contains all the tracepoints. After the move to /fs/resctrl, some
> of these will be left behind. All the pseudo_lock tracepoints remain part
> of the architecture. The lone tracepoint in monitor.c moves to /fs/resctrl.
> 
> Split trace.h so that each C file includes a different trace header file.
> This means the trace header files are not modified when they are moved.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



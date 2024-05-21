Return-Path: <linux-kernel+bounces-185436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB78CB4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEFBB22840
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37121494C5;
	Tue, 21 May 2024 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l5XANnMb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBE433AD;
	Tue, 21 May 2024 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324655; cv=fail; b=WK9Gs/BXohR2NtzKNoqlZ7BjYdwJx0sdejr+FZejdls1MEEBoYEz8/zC7OKoAF5BMXga4MpFU+DxfCyd7pHxmJ+En8FtN9AyV5PVQeyyTlYTkIyqyksFC6gaEuGPv77XrKm107qWE6WwDF6TwFkimuyC6tkuC2hJu7t58yhpclM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324655; c=relaxed/simple;
	bh=HTe52oR1wO3AyP1FSUqXn6LkBZRiIGU7kjjEXzoIQLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gpxlxxNLry4TEbjjF1nwzRIwHQdZRjoMDjmYtE5Y+XKLmj4hEwuCoHM6Sm3eK07xsCc+stHsVPLGwmG2T9FwKbP7nxyHVnTqv30u8nlDFYBcNX4Z5F8j8Zu8kLLOQXOlYra7JQlVHsdiIM+KyLr2v/DH7U2nV9fwDZNv1o0Ngzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l5XANnMb; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iga6Zyjb9/3kNeymUaN91mBS1Kf6NkYWyDgvEFO+wErQ2kG7hhPu6IUE7uVDzDcwRwyALkN91VEB7mroybiDL2azFAEOicUum0XsBkosoBNnUHl7lkvMd0ZiTbRKoFlCjDBrtPhjLSmSWL+UJ0JfFClqdLj4Z347qclrB7Tn0GbuWjYuRBDvs8qhAZiAVow4RvU4+o7pzXZBxpwTPj4zfnl+JegdRMDtktIJ2g1KuHxQs9+jz+4syMOnq2EZ+zqcHk3ydY5f8WiiL2x4/ql/Age41v9raMTJc0S82Cxh2U9tW3k2qnddKxaYIDZ85WEIQ/bQmh2foRgUUYPG3NdB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B10YcnIyIQXWba2E2M7p79WuJpK93ZIquWTd4Cz6diU=;
 b=glPFbnZZFjRHBq4TvVVi6CulULrNBJFBV5Ye+uzN6r39z8VQKoVCdS19cwRDllZbtI/6/LXgJY8oTtreUPjoFC7ftYuAnFdavX4q7p7pTu/m2oztV2mpEGAEai7f4DO4tVE7521yOYrk0EbD+VF4jtNEgnNs/3B4psHSYffSlJ9Ov5EErL29Zz4bfQd9fV3W5tDROAGXDLTEq7+hbPGQ2sllBtsxnqi/Y+/nwMCMeCt/xwYmeXt4Q5PEo7DMywDlx/YPaXqHhMxHS6ITW7/zUqwOQ021dyYU69C/5FPFtG4ycEJafsNtPFluDrlay3AoUarNCMd77TozkzRn0f+4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B10YcnIyIQXWba2E2M7p79WuJpK93ZIquWTd4Cz6diU=;
 b=l5XANnMbZs0jtd8qywcqepX2UCYY9rRHR1BBATukUYhQyWwPf9F+llPeycw2SuUS1phLg5aZw6uKYMWwJXCVmWFUpY7q5M4+smrMWJBsMFRAsGAUmjiOZ9vnZWon+kFFMOPZDn8istp1/V49pwRyFNrywLIlKWeVrla2GwnfBM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 20:50:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 20:50:48 +0000
Message-ID: <df7b1dff-49da-4b1b-b230-f36a5a591c9f@amd.com>
Date: Tue, 21 May 2024 15:50:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] platform/x86: dell: Implement platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, lkp@intel.com, hdegoede@redhat.com,
 Yijun.Shen@dell.com, Matthew Garrett <mjg59@srcf.ucam.org>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240517224323.10045-1-lsanche@lyndeno.ca>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240517224323.10045-1-lsanche@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 37db0058-3066-4821-999c-08dc79d7b17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVo1VU9XR3ArNngvalBONWlLV25tRUEzTWpmaW9WUlhMaWRvNkxISjN1S1hi?=
 =?utf-8?B?aDdoNFZRN3VvRW5pVjNCUDNKTTdTZDlQT1pYRHRvL2V4TE11anJBOEIxOWl1?=
 =?utf-8?B?ak5QUTEwZ05nK2FQc2tFbGtmMmVYSWI5Und6VU9vQktRcTBjUWhOTCtubENV?=
 =?utf-8?B?OXNkTXFJclNOU1dZZnVTc1F0dTE3Zkd4Q1RlclBjb3cyWDdhVFhueFdlTHZa?=
 =?utf-8?B?SmpCbWUrVmUvZWd2Wi9SU0tBTE1VTUNIMXNKMnVPRUlWZ1VGOGg4S0ZZeDZU?=
 =?utf-8?B?MG1GZ1d1YnNnTzJiVVN1ZUthQkxtTGFpNzlHU2NMNVhmNHV4eUIyME1TR1dC?=
 =?utf-8?B?KzZmNEUwa2F2V2krWGd0QW9CenRzRnl2aU9zT3YzZGV4ZmZFcG9JQm9XU0tl?=
 =?utf-8?B?ZGowb2RiYUhOT3l3RFA4YzRFTmRFN3M4blZqUGFpVHRFc3hCZDVsR0tyRFk5?=
 =?utf-8?B?L3JCRFEzOG0zTzRRTmFOdGZBYzZmcG1LVEdxWHFMLzNPM0hJYjc1OGxVY2dJ?=
 =?utf-8?B?Q3Y4dFk0ZWRDcndINkp5WmNaZkprMndHcmw4L2FaTHdxVHgzeFFWUDN5T3ZS?=
 =?utf-8?B?eFhYOWFhc3J0bTVNUS9FRHNWSDJvbjM5M05zZSsyY0tVOWtBMVcxT1JoNzVj?=
 =?utf-8?B?ektzeTY5eTl5N0lVZUc4V1dYd1paaVZqTjM3a1MvbTAydGE1OVhraXVzcmtk?=
 =?utf-8?B?UUo0YlZjMEtkNE40K3g2b0lkSS9naWVUOXBCTWpvQkhuUmhtejltOXJLU0pv?=
 =?utf-8?B?QldreGkyQnI2UnhHZlQxU0Zwa241eHkrQmNyVlU5L0xJeVRKT2pqVEJmSU5s?=
 =?utf-8?B?eXhmZUQ3WXc5d2lFVTdWbWEwbW8wZmhYeFhNSUJlT2F4TCt4enI5WFh3a3lM?=
 =?utf-8?B?RUoxZ1pBcHlhK1JaemN0bzJ6MzFtUFd3TXBnNE9HVUxEK25rYTdhaVB3UzFZ?=
 =?utf-8?B?N0hNblRxd0g2WHBpZ243YUZHM3BnWm4vWjdPdkRseG1Tc014eGlSTW9RRjUv?=
 =?utf-8?B?KzkrdllKYlhIYVA2a2Y1UG9mdFVmR0txWE40aDE4M1RHdVpPSnlHZjIzcXRP?=
 =?utf-8?B?VXFQK2xTUzhBVTlrM1NGWnhtc2Y2ckc4eFlpSklTLytaRTRBRmdhSWFUcWtX?=
 =?utf-8?B?dGlrUkZRVHZBcmdqeEp6UDNtQlRhOXJBTVd0dTcrck9iekJ1ZGdueEVKL0hQ?=
 =?utf-8?B?M2pNUGFoRVlCTE9SUzl0eG5wZUVsdDJ6MWZ1U05vZTM0V1pIZmVDTzcyRjZI?=
 =?utf-8?B?QkNTb1E4THdiY0QzaTdWaktKb0g3alB5WXVmTzNJN0VsZm1lZlE3dXNFUTFF?=
 =?utf-8?B?SkZ4dElpK3BaWHVvbkcyKzVBRGdWNTJJV1I3TWtxUmlyZzY2K21pc0NXZ0Fk?=
 =?utf-8?B?a0M4L05PT3ZWRzdZemlmVTZQbHRhTmRuazRCcHZSRW96TXA2NHo4ak1JR2pL?=
 =?utf-8?B?LzJRaVJlbElMczQ2eHBqdXFzaHNYdG9SUFRrdmtrS21YNjJ5VzFHOUMvMWpr?=
 =?utf-8?B?TVF5eUd1NG9PUGJ6WDJQTUZZSjkxbGZ5UGQ3b1J2Wm9XT1BPQ3BCa2xZaHBj?=
 =?utf-8?B?c3g4VFpPKzQyVzdkOXllM2VIMkRuTHAzUWtnSFVueGl6VklXWFhkSUhiNWNM?=
 =?utf-8?B?SGo4Q2NuVlB1dUIwUC9RbzMvYXRPczVtYUVyTFdqNlJLNHF0d0FsWDZqZkhL?=
 =?utf-8?B?V1J5MkVFZVExK3BjaS90a2pRdTNkQklEcGVoRW1jVnA5L0pyN0NpNjRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkZzVHJCcnNNaVNJeUFKSms5bThQS3ZWbnJ0YXpjc2cyYVplczRsdXFmZkJH?=
 =?utf-8?B?L2syY3B0R2pjVEFBK1ZpN0x5d3NTT0h4TUlISDlKWmowZDM1dnBvK2VTZ3Fk?=
 =?utf-8?B?OENOSlhmYk1hLzFLSGloai94VHF3ZmJsajI2bnBOQytESlRvL1lDY1VHZFVL?=
 =?utf-8?B?bkJSZUVTQ2FmemJGVHRUeFRhd2piaXVLZ2tOUEYwNGt2aVhvbFNSbGs3NjhF?=
 =?utf-8?B?WVFZa3BtQms0eXljMzcrYytLZnFxRVQ2eitrNzJEUmdzUTE5aDgrK3FZaGlF?=
 =?utf-8?B?ODArNFR0dGVKUGg5KzVwWGhPeDB4dnIyTVVtYTlGcHFKcDQ5WUIxMWUvVW9F?=
 =?utf-8?B?V3IwbkQ2amx5YXFmOEVmS2FTWHhDS1U0ZzQ0ckRTMmtuTUZ5N2lXK2orcVBO?=
 =?utf-8?B?OG1uSzFna3VtZ3owWGxBWXhKUDdRcHF0aHJNL0VMcW1VL0w2Z0w3NlBnWjgx?=
 =?utf-8?B?TEh1czNIZTBkOERTTFdVQW9Yc2pCeVlsOGpEU0JFc2FoZUZIU3oyZVgxeitF?=
 =?utf-8?B?TE9UMC8yRS9ocGgySFdkTHRYWFl1RHBmYm5adXluSExIbisyNUsvS2ZmUXNK?=
 =?utf-8?B?NFhvMXRXTkdCaUFQSVZ2Mk15M0g5VXM2d29tbFpXTk4vTU42V0dUa1FXakNz?=
 =?utf-8?B?UEs4YUg2bTRSSWdzb0JVYWhsdkxVVm9NR1lKdHB1d3puU2dsTzZzTjJhMmxm?=
 =?utf-8?B?c1drNkx0QUcrRjNubk5GT2R4QkxxMjAvbmpvaXd1T1BQNFlxZ0ZMblBmMGRu?=
 =?utf-8?B?Mm9lTk1DTTNVa2UxQ0s5ZUw1cjRISEI4bVNKVnY3WWlwNU5QRHdwZ2xhLzRp?=
 =?utf-8?B?V1hicnBTSVArMERrdkNkV3BJUUFFOFVnUHRRVk9yem9FRTc3NnhleEtlMzN6?=
 =?utf-8?B?REN1TXRBb2Q5SGNiNk9tcEpWV1EwMFR5ZkNDKzk4WFMyVzc4dCsydUxzUW5k?=
 =?utf-8?B?d1ZtaVFzdXB5Vmw2NnBDNGxubXQ3a1d2elZTLzQyZDNuUkdiUzRHRHdOQW92?=
 =?utf-8?B?NS8zQzlyU3oreE53bkJ6RXFkTjBHa0RqQ2lUbmNkaTk3OWxaQmh2N052WGtC?=
 =?utf-8?B?UzhjZ2U3dUVuS3BLUGZpd2c0SGhtSzBqeGhNYytsd1hMV1pjbUFTS0xkRis3?=
 =?utf-8?B?cDljZkhiN3JVZXJKWjFlM09IMW9uZnU4TTkwRTN5UUFOQktMSGRrZjl6RkhD?=
 =?utf-8?B?UXczdDAwYnI4Tld5bU9teUNmcTdkSmZUOTRaYTRkM1h4SkxrNVJ5Ykx5VTB4?=
 =?utf-8?B?Zzk3WDE0dzNoUDRMQ0tBWFg2L25GSWZFWHhqSEh1SlRhVUxWZU9vdTBYNFZJ?=
 =?utf-8?B?R2F4Qml3ZCtaVTBlNnNyVXh1NGw1dmo5SmZmczJKMzVZbDBFWGNkRHRZTEdq?=
 =?utf-8?B?Vk9pbG53bVJsc0tPYXBMS2pkSXcxSU5sZjhHcTFqbmxCMUpKVEhwQkw5MFJH?=
 =?utf-8?B?c2VxL3VCRVNGSnZCQUdLaU9oVkVZM21IRUYwUG8zUm1QY2RWWERYZU52dk1N?=
 =?utf-8?B?WjlrY241M2VReGJpN2NkUW5EbEEwcUZncFlFb09sb2JKZU1MdTNONHNrbisv?=
 =?utf-8?B?dTdWTTY5ZDR2QzU2bW9oZ1ZXbUVBaTM4NXdQUmlEc0pHazFjeGJpS3V5amd2?=
 =?utf-8?B?QWRlZEpaQkYxVVRMOHNjUGxkR3FzWDNKVkYrbi9LZXNhcGhOcE5HL2ZibWp0?=
 =?utf-8?B?aThpSG9yUW5nTk9GY0t1VFlmaDJxMVpwSU05YW1hMWVkckhxMjdlRmlHNjlj?=
 =?utf-8?B?dDBVQ1o0cXBPQWlUdFhaWTBjUUI2SXBQeVZLaXFOWEh1L0lVUVdxYVhRV0lP?=
 =?utf-8?B?QnJYTEFvZDZiTFJYVm8vQ2NncDY3ZzF2ZVZVd2NyOUxrWENZcms5VlhkeWVH?=
 =?utf-8?B?NERLZjFqcmI2cEM1UGJTYVN2RkE0Y211dXZSNG93VlhBUythL3piWnVSbnhk?=
 =?utf-8?B?QlhHU3Z5K2RYZWZKdUNlSDE3Z05uMStzQ210SDlLOFFaTTN5Ni80TXdLSEZN?=
 =?utf-8?B?OW8rOUg4VmFiNmY0ZWo2VHgyc0YyYWVxN253WDBtbnV1UzlrNjJwRzd4OXVa?=
 =?utf-8?B?a2xFUmlzMUx3blRVbkx5amttK0Rwb0lDNzN4SW1sRjA0UXBrNWtqTFA1SVRn?=
 =?utf-8?Q?uZH0yXBl1ipqXWjd14/WJTE+m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37db0058-3066-4821-999c-08dc79d7b17f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 20:50:48.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhh6z4Ozisi2Ov1QHOrCQUHzz5Slw7eWnZhBexsJegIUubf8QC983ljdTpt8JwmZW20iWhThoBaIufXAW1AqrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

On 5/17/2024 17:42, Lyndon Sanche wrote:
> v7:
>   - Move platform_profile into new dell-pc module
>   - Add myself as maintainer of dell-pc
>   - Move smbios call and fill functions to dell-smbios-base
>   - Check for classes above 30 and return as not supported
>   - Rename dell_laptop_check_supported_cmds to
> 	 dell_smbios_class_is_supported
>   - Check for ENXIO and treat as no thermal modes supported
> v6:
>   - Add ACPI dependency for dell-laptop
>   - Add and use helper symbol for checking supported commands
> v5:
>   - Fix indent in smbios-thermal-ctl comment
>   - Remove linux/wmi.h include
>   - Add 'select ACPI_PLATFORM_PROFILE' to Dell KConfig
> v4:
>   - Make thermal_init and thermal_cleanup static
>   - Rearrange order of added includes, did not edit current includes
>   - Include bits.h
>   - Switch comment style
>   - Return error if platform_profile registering failed
>   - Add thermal calls to call_blacklist
>   - Align defines with tabs
>   - Correct separation of function and error handling
>   - Propagate error codes up
> v3:
>   - Convert smbios-thermal-ctl docs to multiline comment and wrap
>   - Change thermal_mode_bits enum to directly be BIT() values
> 	- Convert related code to use this
>   - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
> 	- Correct offset for getting current ACC mode, setting offset
> 		unchanged
>   - Check if thermal_handler is allocated before freeing and
> 	 unregistering platform_profile
> v2:
>   - Wrap smbios-thermal-ctl comment
>   - Return proper error code when invalid state returned
>   - Simplify platform_profile_get returns
>   - Propogate ENOMEM error
> 
> Lyndon Sanche (3):
>    platform/x86: dell-smbios: Add helper for checking supported class
>    platform/x86: dell-smbios: Move request functions for reuse
>    platform/x86: dell-pc: Implement platform_profile
> 
>   MAINTAINERS                                  |   6 +
>   drivers/platform/x86/dell/Kconfig            |  13 +
>   drivers/platform/x86/dell/Makefile           |   1 +
>   drivers/platform/x86/dell/dell-laptop.c      |  23 --
>   drivers/platform/x86/dell/dell-pc.c          | 310 +++++++++++++++++++
>   drivers/platform/x86/dell/dell-smbios-base.c |  35 +++
>   drivers/platform/x86/dell/dell-smbios.h      |   7 +
>   7 files changed, 372 insertions(+), 23 deletions(-)
>   create mode 100644 drivers/platform/x86/dell/dell-pc.c
> 

Series looks good to me, thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>


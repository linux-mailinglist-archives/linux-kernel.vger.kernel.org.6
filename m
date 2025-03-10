Return-Path: <linux-kernel+bounces-555174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5311A5A66A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D624D1725ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7DE1DE4E9;
	Mon, 10 Mar 2025 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NFS7hYIn"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C21D514E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643301; cv=fail; b=apIcw6745xdozLrtKVAIkyhN68nq7OgP5HcavZ6JM52NuPuVez4ppKrHAr+sYd49js7AasTmH8GaSydVGykJt3CgKbxBusNLl0B/YDq7MZQZl44Y0XinoCvWjV2vEua3TIWnJbhBOeBQVF3qXCGauM9nyflFjQ3OgF4IP7n0VL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643301; c=relaxed/simple;
	bh=XcPVdRdAPMzNAMbxqe3v2SBwYoiA0JF4X17VUEF2ZO0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i84UXVcYcv416VvwsdtsSU8rlpmbXP5VcvxrbWUgKH4oXszI2j6/gS5sUWvo2dzFhWXO1gyeRyq4F2TcMy5XHwxx/iKUaboCT7OEYulr4bgMIS5oKm5OEyJWqTnC0O7pq9rQpk9FNm6YUNdNaBnI7ItSiaUtElc+vnZ+JGDyXgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NFS7hYIn; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzdsrdrSh1P+vlMsRv7ItZbKWWV+FXYiN126+omjbpmP9Tovkd9htYlBQidNXhH00tUDg7aEMiInZCwbniuJOF0gpY1BkRuH2VBQcVv58l0Z67/9/agCQqIwwRN7qNt6pFo5C/83r6qY7UG7ruCEy0KSErLl/vQkPN9G8Vro1lAUz3QuJQHUMWBagp1vO7Rv7RZIxggcwnJUT88rrE1iKwkEb62AMuox3gO+MWlxi8B4rz7KYJaRJsjLfElikPYYuHwMT4G0rbiht27uW/d332bUkOYbMThU1ja9zQzq7Jld25wHRnp0XvqaCKgbM2uL5EqUThpzJG6A2x2iaVGFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDlzMDlE45W0J7RxlgMMyDhRdAXkvE9KO9r3Rhpg46Y=;
 b=HdE+UTuNFU7l/ZeL3lABijSrpGQMlkc3aNN+rr3Bl+yL63IRzgnDW+SNF5SCsAvkuLrLd8m/fJcLfemqoDKjKMoV8N6t/YTnFriTm4l1FlV5ol+tZA/XBzYNv3FLHeUbkqx5HHKxuJ052lIVLefEhuISWpTzb1qSOfd1YhKXQF6n4dUNcsLWE+Sz7BqwgL07N23lxXnRym6wOD70jEVNaav95SplCIJXSqEgbIRNHqjYvHohtTTmceEAJq1tUBJAS3r6bB5Zf4jDswyc35rIKb50iDK6CNlexdJu+L7N6NeY701ntIJfy+ursXqeKQvGVsUS+GZCmtawnHj4Pi79UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDlzMDlE45W0J7RxlgMMyDhRdAXkvE9KO9r3Rhpg46Y=;
 b=NFS7hYInzbLHwFHsaFsG0yIurSYDi3i1To7KyOGyYQGUISRDVigct3D0bwxVoqnFy8HlG3PIcyhncnZS0Mb9zBVk5/kmjkpd8UxhK3jM7kA/W8h4ZoGREWZ1LLkkiThVCxmnAskMh52kNkNTE0Dr+b3NeCvbcG1uSOjUtqgfYSy2kwOILTY2uUA19WEnQRQ6Mythx9BwPgsmBLkwcTiKOzbujvmQ18MWJTJ2jxLgJEGzeancHDa5olygS4RAClytHrgs63opIfVF/NvnDrHi0xzi3uKMgb4HjSPGlkaxdA4iK3Ew5sSP/WPX2Dxr8dcLKIZ0TClDTohbnmr/kTsdlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:48:16 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 21:48:16 +0000
Message-ID: <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
Date: Tue, 11 Mar 2025 08:48:11 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250310112206.4168-1-spasswolf@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250310112206.4168-1-spasswolf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: fc046a61-fce8-403b-264b-08dd601d4373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEQreUpjbHE0SzF0YVJCRzVOWEV6a2tCZjdGM2tzVlAwQTJMT2Mzb3JkN0Z3?=
 =?utf-8?B?RXJrKzBMV25ERDFOdi9PT0V5ejZ0R1NMWXBKaXR0NjJWZkJ5UmZHdWc1WlAv?=
 =?utf-8?B?NW0xNXAzSmZjeUF6UE1FcFg5OEV5NCsrMmdEaEhDRmtIeG5vY3JKL1RSQ0Nu?=
 =?utf-8?B?dUYvVjd2bDNPOTBkYVh1N3dTTStBQ0QwUEY0MzNRTlErazJ5b0NteWdQTk9M?=
 =?utf-8?B?YjdTNDVEMEtIR3VoMXRpVVVaTExaV0FlTEpYRjg0SDZxSnR5bXYvNHVBZDlN?=
 =?utf-8?B?cEZNczlOVUxnalFkL2NEK0luS3h1ZmJpV1VoM3BqUVJQSmd1MWU3VFlhSnlj?=
 =?utf-8?B?M09NUUNjbzRxYVFkRjBJWU9LUExlZ00zUVkweGhmKzhnZHc2a1FvM29ubmxB?=
 =?utf-8?B?QjFLMHlNdFlBQ1J1Y3FNRTdQY0tWKzYzZWd5K1B5U0lBTk9mQ2djenJzSjBm?=
 =?utf-8?B?TUNrbzNkWnhOcEdLS2VZTGhkdU5kRHFsUzNKSlJmcWlOajA3andCSEN2RUFP?=
 =?utf-8?B?bjk0cGxabVl6Rll3akx6SlhzN0RuY25nbVdrT0NqMmFHQlpmSnlKRHl0cjBY?=
 =?utf-8?B?MWtJdzRRc3h3Nnl6YVF0SFZONE03aGNMcm1pOEJ3L3hXdTIyeTdJb3V0Tlkr?=
 =?utf-8?B?UEhOMEJiUzN3N21tNy9sQ0ZjK0FrbmVpT0RVQ3NZTXgzOXVjQkwveWNjQXlu?=
 =?utf-8?B?Ri92ZnFObjBoUTFvdXM1L00zekgyZ1RqVjRTZ2xNSkpIeFNOK0Vwdkw4b201?=
 =?utf-8?B?c2d0Q0YxdWJoTU11Z3VFS1ova0xzWUx6Nm5ESWRVY0k4bmxPYVBHUWx5Q3Ix?=
 =?utf-8?B?MHFmVFZQSW5QUEt3bVRPR0Y2cHBUenBxRmdjMFVQaStSb0pXK3cyaTBHdjlV?=
 =?utf-8?B?S2hHUG1QbnIwY2xQanQ1emY0RjJML01zaytRNEluTHFHcVFwMlJCcVlBeWhn?=
 =?utf-8?B?RkQ1c0MrVjQ5TjlkNVBlYmdTY3BPdUxVTmRIdWpiVWh3YkNlZXpBRmtHVDRu?=
 =?utf-8?B?bDNJY1A5eXVWLzNnRmxYcVZWSHRzbUp0bmRtMi9yWEV0OUNQd2JEVFgxMC8v?=
 =?utf-8?B?RGVzNk84dUZNSWlGdm9SbkRpSStJdUErcTM5WVF0bk9HOWFxcDdnclFqaWVP?=
 =?utf-8?B?TURVZkF6THI4eWY1NFM0MmtJQldIMmpURUpJM2NOK1pzU1ZyVG51ZUtUVXBk?=
 =?utf-8?B?aW9CK01pSGQxVG5hK3NOblQ4cm5GOU5JaWtnWjhXME9xQnFRVjJqRXQ3aTRY?=
 =?utf-8?B?amRZSHdXRUUxSGVWbkFwYlFCbUhYK3RNTVErZkdvR2dIN2NxTGVFUHlYTUxO?=
 =?utf-8?B?b2NZVVNORG0wQS95a0doMUhraXgyQWdxSlY1VjNnbm5XalgrOUpFcW5PV2VO?=
 =?utf-8?B?czg3WGlQQ3UzZlZWOWgrNTQvSHN2RmJpRG9aa0ZjcE1xMkFUWGJNdHJVRXhL?=
 =?utf-8?B?ejBydzF1amg5Z2JEUUtJTFJTMVV4aWtzOS84Nis2OUZmSDNQV2w3RVN5QUhC?=
 =?utf-8?B?RW5wTXVlNk5LYUdsejJwZjFmNFZGZjViUUdXcEFlOXNDdlkzUzNObEtoZm9M?=
 =?utf-8?B?WGNMekNlVFNiRENRc09pYkM5ZVBUbExLdlVidGcwNTdGc09neWt6Y2hFeFBj?=
 =?utf-8?B?WmFOUENzeUZCMDFqRWlvVWlCa3dqSUxtV3hTSEd2bjVFQUV4TUJia1pGc01x?=
 =?utf-8?B?U0UyZENBZDRUNDAxRUJsYnM4Zk5TZ2xsUzAvTlJhMWN0bmlUMS9KUStRa3ZQ?=
 =?utf-8?B?TVNvcllNZGYxOE1wa21aRmRFckpFMmIrdjNlbWMrTmZBT1Fyb1p6eDM5NzNB?=
 =?utf-8?B?VXg1VmtPaXFzY1dVSkdqaXBhNkc0aFpCZWFkRDlvVHZ2dytvWU5DaC82T3lm?=
 =?utf-8?Q?6UzxLXTDK/MvP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3dtTE9HenpBaCtaWFFTSVQ2QlJOMTFHbEp2Q3NXRnNvWjA1R2hhNEQ1eTAy?=
 =?utf-8?B?WW5vS2c5d3NUZnYvVll6TFk4WG5xZDd0czdLVXVFeGdZVFRDSis3MVZNZTVM?=
 =?utf-8?B?WmZqeVZQY3VHUkVBZVNhUzlvZXBJcXc0KzVjTGVBOFJlQ1I0eWFydTJmZ0Vy?=
 =?utf-8?B?SWRXUGRwUW5EV2xacHhxMkV2UEZnRjE0MHowYVAyV0ZYL2hNU0c4UjRINkJs?=
 =?utf-8?B?WXFpaEFtTlN0SzhxbWcvVEdhZndUbktIMEZMVFdYL0ZXcGY2SXlQM3Y5T0JD?=
 =?utf-8?B?a0JhY0lYRmlWWEdINVZUWEdIQldBdWtQekkrSVVFQzNlMFpqbmpvakVWYnYz?=
 =?utf-8?B?dG14bU5TRW1KcEFWRHoyalFtSG0rNnNCbzB6cXh0RUEvTE9vcHFoWGJzMk45?=
 =?utf-8?B?aUlnZjNBbEEycUhkM3RZZTZNM2dMV3NMT3VaZ3RodHNMcU5uL3hOMzVDY1Iz?=
 =?utf-8?B?eEk3cXF2dmdsRGZ0b2w4ZHErQno1cE1jVFVSeXNUVVpVUVpiMUF3TDNXTVhp?=
 =?utf-8?B?bG0xZCsySHMvOWNDbnRsZVNURXIrTExxQ3oxRUIwZDExc3Jldko2VG1hbGxR?=
 =?utf-8?B?MkxQemtkMUV5cURwUTJHeE5QdzAzTXprNzVsZjlEaEdQOCt1Q0NEVGRzYVVt?=
 =?utf-8?B?UEhTanhuOStzcU44RTFDcGt3UFV4VmhrclRXYzVZNUpvK3lMbTl4UXZoaWR4?=
 =?utf-8?B?NW4rdEtTWFZzZXlYSC9rTnFaMXhkajV2d0FwcDI2cHMvODZXSkhVc040K1Q0?=
 =?utf-8?B?WExvY0R4ZTBiU3g2M2JYdG9OWTM5YzVkU1RwUjB3eGZXZHV2TVkxayt0UFpD?=
 =?utf-8?B?UFJtcjN6ZER0VXovL2tRR2tHRVMvUCtFWWhNNjNPTDQyZ1VFYTMrRVlzZ25Y?=
 =?utf-8?B?dzNqOW9YM25sVjh0bFZ5eFhLSWpxWUNhUE1kS2dtb292TWMyT0lrT0gzNko5?=
 =?utf-8?B?VXAyZ0k0V3VqVE0xV3lmZ2lkc2V4NHA1aFFMK21RVU8ySDZua0JhQk50WGJP?=
 =?utf-8?B?aW5WMy9lOVcxaElTYUhYRnFUaGl6N1Q4NHptcDlYcmc4V1l0R0tERncwSFZN?=
 =?utf-8?B?OEFoNDA2bit6ejB3ODJpVWNpUVhYV0NGMnJyUi8wa2lnckZqdHNjSU52VWJu?=
 =?utf-8?B?K21BcmE2SjBKUG5wQUcrWGVsYXAyRllRVm55NE5Ld2JDSmNKNDNpTmJvTy9v?=
 =?utf-8?B?V3V0SXNOZFZxSy9yNkl3NVhsejZWcGxVOE4za2lVTnB4bmt6TlBrTTlMRnVz?=
 =?utf-8?B?RG5Ydmd2RnI5TlVqTUpFODJNY3J5cXhLRXUrTC9tV0NHODc0OXpJQ1hDakNQ?=
 =?utf-8?B?b1JyWlZ2NUxUVW1sMTA5UkVHVlpMQXQ1SGtpNGJaM3RvcjJyZmdYa2VRSUc1?=
 =?utf-8?B?Z3RUQjhpTEtMcWRxbVdVVGNIaHVSWDZWTVQ5MWV1dURBOXVhR1dVTDl1ckhL?=
 =?utf-8?B?TWJFaTBOZ3cySTBOWWFiekR4bWVHNGd0RDNPTjJVZXNWVkxOeHR3MGUySGVO?=
 =?utf-8?B?YWZUS2I3ZVE3bmFLTVlPUTJRUStEVFdYSXdVWWRIVlMzTVMzUmtzTlNXc1VC?=
 =?utf-8?B?MndhV3ppWGFGZXpIWEJqQnJvb1dDYmhJanFQRzJCdzlrbGFmSGVJNHJ3cVpl?=
 =?utf-8?B?dDB6OEF4UFVqT1JNcFN3a3NyZ3RER1FpWVpscWx0RmJ1WjZpSFZvWVdlYlZp?=
 =?utf-8?B?SldrTmkxRWhXRVVVc3FVWlJkVjFCUC9tOUFMQjJlVUozYlYxWnJ6cVNEUHdn?=
 =?utf-8?B?cVE5cmlzSy9wTWpUNTBJeDJkYmVSWmU5OStsSElGbGtKSXM4RTBzUmRBOGJj?=
 =?utf-8?B?MnFiWjM5aWU5ZVBQaVdkT3FlYndCMENWSkxOelF0bzh4dW9aV3MwOVppdHZa?=
 =?utf-8?B?VlhEVGlqQlduOW9pVW01UFloSzlDL1JnMGwwVlJOcUgyZzk3UkZjazVFYUJq?=
 =?utf-8?B?ZkhiVnlNVU1POExJaE1mbE53L2hRREUzODRJZ2dTZm13Rk9HVzgxem5GR0ZW?=
 =?utf-8?B?eDBKcDQ5SDg2R2JYRkFjY2NQV3VMdVpSWUxsZURwU1RVZWdScFdpOS9RQjg3?=
 =?utf-8?B?TTFzQ1JubGhZdURoOTJHL3Z2UkZZd2FWRWZzVDc0bHVLWkVKL1pBcW9YVlEx?=
 =?utf-8?Q?t8X+uLggw7LhYH4tSKYfB6A7N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc046a61-fce8-403b-264b-08dd601d4373
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:48:15.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmIIpCwpjfMFpn2tNnW36M6cALIrJgmjpzwYat74bzq3rAzp3sVKOJHq/kt/C2+UT2pDmajAJsb5guNXxXV7jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823

On 3/10/25 22:22, Bert Karwatzki wrote:
> Using linux next-20250307 to play the game stellaris via steam I noticed that
> loading the game gets sluggish with the progress bar getting stuck at 100%.
> In this situation mouse and keyboard inputs don't work properly anymore.
> Switching to a VT and killing stellaris somewhat fixes the situation though in
> one instance the touchpad did not work after that. I bisected this between
> v6.14-rc5 and next-20250307 and got this as the first bad commit:
> 
> 7ffb791423c7c518269a9aad35039ef824a40adb is the first bad commit
> commit 7ffb791423c7c518269a9aad35039ef824a40adb (HEAD)
> Author: Balbir Singh <balbirs@nvidia.com>
> Date:   Fri Feb 7 10:42:34 2025 +1100
> 
>     x86/kaslr: Reduce KASLR entropy on most x86 systems
> 
> Reverting commit 7ffb791423c7 in next-20250307 fixes the issue for me.
> 

Thanks for the report! Could you also share the dmesg? Do you have any proprietary
modules loaded? Could you also share the output of /proc/iomem (captured as sudo)?
The lspci output is useful, lspci -vvv (captured with sudo) would help see where
the BAR regions are, specifically before and after the patch. Could you also share
the kernel config?

I assume your config has CONFIG_PCI_P2PDMA enabled. Did the system ever work with
nokaslr for you?

I am a little surprised that reducing the entropy causes these issues and having
a larger direct map causes these issues.

Balbir Singh


Return-Path: <linux-kernel+bounces-416187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BCE9D41D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97275B2331F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB919CCFA;
	Wed, 20 Nov 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P/fokmdi"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878A1E515;
	Wed, 20 Nov 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126134; cv=fail; b=hUoVZNFu1ixN+ygHm2ay80boxLRtLnbevB4il2m5xKBDpMtnastgnS/Ob/Q7U4khOnfuHpiWRZOCHHmgMLPkDp4jlm9pHRcF1MlHXKxhgLdzNucuyUGBPwKQEMWNbMt0j+a39EsxsZL25vYJOqzsIYGQ/dyjoToNhrKkRPdI+88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126134; c=relaxed/simple;
	bh=4UfaeuQJvLUPoNLMVkp5O81MruljDEbhi8kv9ZiFxyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jV5aHCTL/QdicU/0pDj8jq5Ppa268TRo9Z4J7dAAclrvpO9kOGI7RQNK2H5pcsw6gbK1QqbltZnlPt/n3zFHcq8g4pZjq5eixfwU7e/TmoBW0W9RvBEt6lejUtVOrKmt/iBV5M9RNs0/uR3w+Nlx+/R9n06lVpd0iFSlYQRgJNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P/fokmdi; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2g540mvpfuWL0+2uzV7JiTNZTpxWIGgkBZp2MgrtaVcm3Or+yM/M+Cw9Q8sxB/il8EFcqDFwhQx+KjKy6d3f44n9efhTQY8qC1bT5OoiOjlyClKqhrqjM/yQWux2PwkkRWtz7C+YRNTJoYigZ3DvSs3AawhwtKlApSNoSWCJOvyvseVhotWak0KE1wkK+YOJUTxR2JStUefI7m/MQ4ykg3TLdQSZnyXIOnsJ/WQw2C4/i46UaTVD1kLCjJBa8QPRCguByBh5CHNlVpNWrL6dzKr+PznhJ7+GFlyo9N1gEjvD6Sx2s5tj5W+xxroUoGSj5QUtywzHTZAB89utGbirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oajaWugIIyXFy5/j6GTq0us0uvn4OQ/jWFNLH54n7s0=;
 b=uBbiuFQhxo7JwLsXCJlkpulZi30zuvQ8VVh5ceVy/E0or3J51rK+9R9klxRmcp//C0pbAb1077cHfqfKz+IPvF2MuKLB6vNBSeLh3j1bv9GPQ5HdOQH7Mv6D5ZGHKyyOXjzOWKUp1oXOiNpP+L4e+tg7gnro1R/gIJZ3g9EmefUEWOE73HUmclRSKFL+psZ2El/UvWIJNt7TvvWCdPhuSZqbCQnLCDicRmbQkhceOHymJ+E5MvjA/+1Qnkie8hBDlj+dfmYYkhBPO8ImmGc2AG+IQuTp4Aoq7FzTeMDEoY0qq5//LtNJCi0l8rxwqZ/g4X6pTqoHzNctljsq5SS9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oajaWugIIyXFy5/j6GTq0us0uvn4OQ/jWFNLH54n7s0=;
 b=P/fokmdi5lwvn0jChYBwbiXOwP3cTwpd1xIup7DPAzyBZj386UTQ8p8N7H0GvWDCiK+NxCR9o4Xzv6Mg6gnXVBrv+JP8B27PAi35/OjzWTR/hCyCyuYrAcGhjuX07IC0QG1jRZzDP3bBp541+T3gRxuY4Zr+KBMunC1heCqUxB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 18:08:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 18:08:43 +0000
Message-ID: <fe39fe4d-b7fd-47b7-94e7-85106571b161@amd.com>
Date: Wed, 20 Nov 2024 12:08:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] alienware-wmi: Improvements
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, w_armin@gmx.de
References: <20241120163834.6446-3-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241120163834.6446-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0067.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 503d2c55-9bc8-4051-42c6-08dd098e5eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2daUEI4Y3dMQ082NmhTQXNhbXpGbk1aWU1TL3hzUnhzZWhtdlJCVHhXR1FR?=
 =?utf-8?B?Y1g3QldXa0RWYnF0c0ZnakY1SDFCOGtsUGxzOUlKWGd2dStEN3lhM24rYkIy?=
 =?utf-8?B?UjBOMDZOZkorbXhRaUZFNVpnenRDS3B2cnZmemJDNmNOckJnN1ZXVXV3dnY0?=
 =?utf-8?B?Y0JXQ3oySGQ5dDhvWVVySzhCSWhqNHk5YWhmeUNsclBseW9aaE41K2xCbHlF?=
 =?utf-8?B?TGNnRnNNZ21zWDlZSGRla1hXdXlFMjJxNGhUNUNVUXlXeThUUStjUmw2NmJj?=
 =?utf-8?B?b1dRSXRMV2FUNU1IK0pkdTdnVFRYT0lPV0VId091UERubHNKZWMwSlhUbUIz?=
 =?utf-8?B?TzVsMWNJNzBadXJOUnRQK1ordThxQnFtNFhtWVVuVWdlTkVZSklRWlkzRVY3?=
 =?utf-8?B?TG9haCtTM3VyYUdOS3JmTDBncXRrNXRNRWQxYjZpTnJFckdFTU1ZOUIzUkZG?=
 =?utf-8?B?STgxa0RWR25CSk9TUDE0Y0IzM2NLNTZHMGtvUmxoVXRMOGtLMTloUDdsNnVZ?=
 =?utf-8?B?MnNQbFBxc1puemF1TlpFQzAyR0FZbE10NzBCK0hReHR4WlF6YUpoRFlVNGxn?=
 =?utf-8?B?QlJkVEZCb3NMR1hYMmk0VW92Zm9hVUwrdmppN0phVEx5MWNPYlpXdllNOFdt?=
 =?utf-8?B?Q1B6T3BkMHNYYlBHT3BhaFBaMCsrRVo4czZSRTFma1dMQUtNTGNMeHpUdW5T?=
 =?utf-8?B?TFgyeHdTN3V4VXd5Vld5bUxUNXVvdzNveXFCTmdiZVhUM1ZERENoUHlPQUJ0?=
 =?utf-8?B?SDZjN2NuaXJ3dG1SY2xYVmd3MTZZMmJUdFZweTkvS1lwUUhCWnNXcW1mUEhz?=
 =?utf-8?B?TndJUENONXFtdXYrbThRNWswSS9Ra1lOTU5DbTdPdEYyNkdod2NZSG1ZL0JP?=
 =?utf-8?B?TkdGNjFTMG44WXdmc0FUbWFWM1daQWFqM0tjWDF5WVlZWXVzZWxvQ1AyK2Ir?=
 =?utf-8?B?NncrVjhOOGNGZHNWMFVBM1BTOEgyblZwODJtblZuQTJkVlFuQVdVemhQVUZY?=
 =?utf-8?B?U3JYelF3dFB5YnFMRDJMUzNMWnRwbG5JQU95OG9YNE1ZaTdLMm1CelNCaVBX?=
 =?utf-8?B?czVGNjVFMlp0eDkvc1pFdWhDdytNRGdlNjdCdC80RlBjbmhka2d5YmtQSGRo?=
 =?utf-8?B?aTd6S2dzQ3Y5Q3h1cDdPMlAxaDVOWW42cklZNWZ4bVpQL3lzZTNaViszd2Jq?=
 =?utf-8?B?MnAybWJMRnl4djhPMTVMSVpYQnJTclN1M2N4NVZkYmRQTkhLS0FlTE9yb04r?=
 =?utf-8?B?ZkxBL0doZ0xWSUlDRWdQdlFDbFVRZ1RNQk9tWkdoOVl5cDd6QWR1M2NpV25I?=
 =?utf-8?B?OHF6YjZ1NmlhRmF6d0VDc3M5VWJaK3FieVRUcHJWNlNvZWtRMisrRk05UTF0?=
 =?utf-8?B?dVZJUmZhOWFjZG1uWkpGS2xLUUZUSzg0YU42aWdCZkQ1UWhtQTFGRHBqU2FT?=
 =?utf-8?B?NnowUHNoL3hLMVgzbVFHMDg2d0VwQnJBSTZPakZsQXUyS2JXV1I5a2ZVaWlV?=
 =?utf-8?B?V05NUEl3dFV4YlNzN0RXeno1aGRsWUxaK3Y1UE5ESkpuMjNzR1RhdjliU01n?=
 =?utf-8?B?VjlaMVRnV28xZmlxVWxMNDdNaVppd3dtL2RxZUxRN2VOaE5JQkpYMThJOUJF?=
 =?utf-8?B?VDBGNVpNUU9YZUZORXFZcGs1eGhBaW9OOUtuT3JWaEFqRUNwMlFubEVoSTlJ?=
 =?utf-8?B?SlV1UTRwMEZCQjJpekhlQXdCbmJlY2YrekxNMjdSb1NpZ2JYa0JyZHJvaHFT?=
 =?utf-8?Q?iBoggkPA/f/NEHvWaUzJ7XnSFIna1J1OwLFXeSx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVl4TStTRi9EWnNCbmhDS1JjNDIzdFhpSS90UlRicTl1Q3pqNkpobkNwdU1n?=
 =?utf-8?B?OStTMjVLY3lEU2ZKdWtmRGJWZzRxejZHZFBNbUdoclQ2bSt2L28wZU9HWG4z?=
 =?utf-8?B?TE0ySDBqSER0WGVQQnltc01IMXhPZ1hrVGNkVy81NFI0ZVAxZjFlSE0zL0Jx?=
 =?utf-8?B?MkE1ek1JcXErZUJWdXVsMmVWWlAzSkIvWHhhYnB3b0RqTHJEeHBhVUMzQ3NR?=
 =?utf-8?B?ZGowaHBaQmdKelBDR24zSThtaTNPVGZRakdQRGQwUlkySUhPNUpBT3VrWncr?=
 =?utf-8?B?RlMvbnJtdDZOeDlQTUtHTEI4akgzU1l3cjk5SHAvQjdaUHNVS0NydGI0Q0dn?=
 =?utf-8?B?QzF0RlVEY0lSeDNMUDR6U2pmR25uQ0FRNndtSkRBSXY2TGpNK0IzTUM1UXVv?=
 =?utf-8?B?bk15b1FydEErcS83RnhhTGlSVjhTUlI3Z1JuRFl0aU5TZ0NkRkxqVEsxWlMw?=
 =?utf-8?B?U1VnSmhUK0dZRnExZmgyOU95aDNQRXJRcTB6a3oyOTg3ZFBibWd4ejJGTTJW?=
 =?utf-8?B?eWpnbDFOdHJNZ2Y1YVAxN3YyQkNmMmdES0FlVlhibGVwM1IzTU9SK1FFaVhp?=
 =?utf-8?B?WGVDeXZLTWlqVExMUy9JKzZ0ZmFWMkZHQk5TdXBKTTlnMnhJNHBMdE1jdGIx?=
 =?utf-8?B?N1V4bVJwbWxaTHZ1dkRaVlU2WW5RMmRHRFh3RmFFbUlpalZqMjBtakIyVng3?=
 =?utf-8?B?Z0pJendNeW1WbDVlTTFZV3lXR0dLbTNpWFRPd1Z3UlBiTnVRcGNGKzZ4Tll3?=
 =?utf-8?B?dzFIOEl4S0ZpcCs2dWg3NzJabFZTa0hFcEtOWnl5U3ppeGVXUG5aaUpxUEtB?=
 =?utf-8?B?aG9xZDZlWEtLMjFRblQvWStqNWhaZy9TcUx6c0EyRGpsSSsrTWpsbEZWdGtG?=
 =?utf-8?B?ZUN6cU4xNVV1Q1pNZGhlN1l1UHBaQllPNWc5MmJDYUd2bWRjbzJ4dUl4Rmxo?=
 =?utf-8?B?aFNXcThKNEhRaGRvRlFsOXFveExmcmROaks4MGpnVjN5djAxNHlUdnNnMy9l?=
 =?utf-8?B?UVJiaGJBNnBLTFhsa3hWREdqQkh0UWlOMy9hK2M5L1QvZmhZRUtUa0lNTXdS?=
 =?utf-8?B?OEhrajd1c1hkVjFqMGtSL1M5d2g4bFZGbWlhTHVwMjNmY3dKbDJwOWZ0NmF5?=
 =?utf-8?B?cGoyaGhTZzMxZlJLRU1FSVBjVUp4eEU2QVBneTFzY0pOakhnem8zYVNHQ0RC?=
 =?utf-8?B?dUdWRU5UcjZjWEthbXJRV3FJZmxrVExCVkdYNk1pK1dZaVJ3NDlTZll1Tmxr?=
 =?utf-8?B?aklFSkZMWVgwSTlza1ZMMzIyL1p6T3d1SDZHU3ppN1lIQUpGanlFbVl6d3pk?=
 =?utf-8?B?RWVYcXIrK3NSaWVqaFI2RVdCOGRYQVpiWC9rNW0xSURzcDJBcmZHQ3Nqbkk1?=
 =?utf-8?B?YnZnczd6ajM0QXRESGc3K1JRMUdleXFxVHNzdGcvakdtdEZNdzhjNWRwcGZY?=
 =?utf-8?B?bXhQbUdRSGRRT0JpRGNBS1VlaHM0UXB6ZjhhcXZXdlBBdmtSM3M0VWpoeUx4?=
 =?utf-8?B?ckI0OXBNeTFudTYzSGlBTWE4V1JIL0FtQktCL2x2MGl2cS9zZk1sdkE0NGJG?=
 =?utf-8?B?aHRsSGsyVmJEdDNEUnplQ2M0b3dsYy9TU0cvdDJUaXFzK05nRy8zcVdIQTNU?=
 =?utf-8?B?MklqTDE0UXE2UlVkQ21qMGZzbDkvcHljb2hkdFFpcWIwa01sczEyZExqNGpu?=
 =?utf-8?B?cGNoS2FpVmZEWU1sMjJ0KzVBUy9xa2xRMGRDbkFtdEp4VXBVTWxQSkcvUE51?=
 =?utf-8?B?c3JiL0l2SmNRS2QzVGV5Wk9oRVdFZVhHMlhPOTBlOGU0ZGlucm14QW9XbGp5?=
 =?utf-8?B?bDJHSStoRG8xT1FZc2RnWnl4b0ZHRSt6TFhLSzFtcEVZbUpuckRCZ29tc3dy?=
 =?utf-8?B?QnFlWmxnUEZ0SEJPNXNIK3FsVHdTZmRMeVpJOHpCRUh2dTBIV0pjdUhJdEFq?=
 =?utf-8?B?T0dHcEJDcGhYbGFGSWxlb3dJVFpyUmNNWmtpa1VZZUViRHU5Y2oxb1ZSUG9v?=
 =?utf-8?B?aVpJbmlLWVhNKzRxUW4vSTQyM2lhMXp3L1JKbWJVaUtZb25JUVJTOUdIQ2xj?=
 =?utf-8?B?UXpBZ0tvNGk2K1VLeUFXdEhtcWF5dC9NRU80OEJRMEFDWkd3bERQT1kyUEpP?=
 =?utf-8?Q?hCsSr42i0di+M1wJIoQbLeAfh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503d2c55-9bc8-4051-42c6-08dd098e5eb5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:08:43.6909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkLU7fjimKN4l/okIZnWoL9o1DlWncd48xeGs7/P+YVoMIyRK8VhmYEDJqsefJxYhYLHJK6EVfW9Klql8veFHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

On 11/20/2024 10:38, Kurt Borja wrote:
> Hi!
> 
> I want to migrate this driver to the new WMI interface. These are some
> improvements I figured I should send beforehand.
> 
> I made everything on top of pdx86/for-next because I think they are not
> fixes, just improvements. Check individual patches for more details.
> 
> Regards,
> Kurt
> 
> ---
> v2:
>   - Dropped patch 4/5 bacause it's empty after changes
>   - Changed patch order:
>      1 -> 3
>      2 -> 4
>      3 -> 1
>      5 -> 2
> ---
> Kurt Borja (4):
>    alienware-wmi: Migrate to device managed resources
>    alienware-wmi: Improves sysfs groups creation
>    alienware-wmi: Simplify platform device creation
>    alienware-wmi: Remove unnecessary check at module exit
> 
>   drivers/platform/x86/dell/alienware-wmi.c | 186 ++++++++--------------
>   1 file changed, 62 insertions(+), 124 deletions(-)
> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>


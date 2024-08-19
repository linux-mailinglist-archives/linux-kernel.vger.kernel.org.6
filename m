Return-Path: <linux-kernel+bounces-292526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC77B957086
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E21B2793C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6029F179953;
	Mon, 19 Aug 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q1ybFe4k"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062844C86
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085324; cv=fail; b=UVVpo1DJeT04yqTIx0GccX6HMrkt10r7F9sY61UGWdnp37fnbZSy73blNWsHijquGcFu0gmB3QMrTPk/GWRwaR4RbSXhwpTVuZATeTzdgBBFNS+mIXHA2LSmewVGNifq42K/dALLtK3D6s+ROxxZdT12x/xj0hO0orUEfBUGhLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085324; c=relaxed/simple;
	bh=5u4bUHWve9ulDD3hBSkxD30BIJxDOzz6W+OEiwwIjBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gVeT+sWQlDhwlT5gvihXz/OBRxGRCCzC4mlfI9yM8BT2BSvDCQ3ppmAl/X4ZsKiyxtEmn/RuoJ8qZJyErgWJkPS5N+m4K4Q4HOTCPiM5C88X/jevwEnbMnbwjHxcZ01MNxaxSTg1u+Z4o8L0K1E0ghz6BRKx9mdz8YNu5+0HNBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q1ybFe4k; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhRMa0TuO/GM5w4ueFEZr/sfbhz75NiJ+ykveWvD1nHjkRi6FumIy1PgAak5X/OS/hUI+M02iYzkkT9x1VYeCfzpAoesRsOQ+IAGogXCyBg+qlyXO4SNwUnNEAr0iRBH6czSD8z03zMPJFuWY+svRedxjWh7DGfh/1FylnhIA/AqcSPKoGSNMf35T1wMEy8yU/98RBdGjc5LCw6Udlf7QabUKzGNe6FFrQq4geBGz+sAHIX904EXukBuAPXaHMja2/uxTXpj6ObdqV1NRY5IJv7k2SdeppVGG/2JshEV0bjVx85Y7q8rNJ2UIMncJdMhpk7wwrhFInTsHuaM/J+R2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5u4bUHWve9ulDD3hBSkxD30BIJxDOzz6W+OEiwwIjBw=;
 b=jhT78LoLEFiiAd13anmDw1hcLCY+wfOmPtRy5hHEmDtTZbbkXB6SPkykBOXsOiJ584adYoHVnLNGz1r+pCp6Ofx4beS6aZGel8f53uRYUpe9DtckWpj63c8Ea9RlL08x79f2c9h77zF96t/TmE1a97hO2sTA5MU9YEl8rXwvbx98HviQOEn7Z9VKG1rx2ITQDOWRf1n4RMHXCAFzOTryMTiHrEMaEHFFDO+iCEI7rJFFOnJly3ocDnm1SgvuiKtv4iIvX9UNz0QIX4EgUgR01qMT2gkwem8R9aUpVNObSlJ6NvD0hTnEj+XYgiB/55GQkK9RoVicDN5/c2ut93qmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u4bUHWve9ulDD3hBSkxD30BIJxDOzz6W+OEiwwIjBw=;
 b=q1ybFe4kiYnTLHjldG8XfYW2UMXkuh907GAgwG219fCvjtGVdqt9401SL3YgU3yjR8t1UuaGjcglHBrUz9NYg7+jt11uVhk3VGCSodD+jCPylsJiDJfCKRHucotO8iQvLu7xNSVgQk6N/Z4HQgf0sJNY9rDCscfM6UyZ9g8H4Gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:35:20 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:35:20 +0000
Message-ID: <a5fb711a-daab-40ac-a9df-da542484e0f2@amd.com>
Date: Mon, 19 Aug 2024 22:05:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO
 mode
Content-Language: en-US
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-4-Shyam-sundar.S-k@amd.com>
 <2a9f6c23-9c7b-496b-9998-ea0afe526b46@linux.intel.com>
 <94e789ab-2e64-4a6e-804f-b5e7b2a952cb@amd.com>
 <0ae18e57-ef79-4fd8-9e9a-4c57b480b267@linux.intel.com>
 <d0ca0a49-311e-4af3-95df-f7c6f85e184f@amd.com>
 <9b8f3c29-3404-4db4-80cf-8fd1b5d018c8@amd.com>
 <9fbbefde-443d-458b-b2a7-b8e0c90af1bd@linux.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <9fbbefde-443d-458b-b2a7-b8e0c90af1bd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::6) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 97073b3d-9430-4396-856f-08dcc06cea3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDUxMEszWlh4WjAyUkY4enUzWkJaRVhFem9UbDgzeXprcXNBTWlET2ZqV3R5?=
 =?utf-8?B?dFlmd0ZPVGFSRkpGQlExWCt6dFdCTnBEai9ZRzNGdFNucVJ2SGVDU2VpRHN0?=
 =?utf-8?B?VmRGVllwMEM1LzdnZkhlQm1ta2FPOFBXM0JXVnRJMUZpL1Btd2RmRHNLQm5a?=
 =?utf-8?B?T21ubWlvOXdqcWdQL0w1RFBWc3RNdHMwb0VFdWhYUXdRdHlua2tyWGMzOHZF?=
 =?utf-8?B?Ni9jczNZTkEzekdRWUhUZVRDbmlqUUU5WlpPTDNvamxEZ2lPK0w3OUlLWFpF?=
 =?utf-8?B?VzBJS0U1YlhTSkpmQkJLMENTNm9PempiOHNZdElGWDhLK2QrdXhRWlZDbXdL?=
 =?utf-8?B?QkdmZVc3MkJIek42UjNSQUh1K1ZYR1lJN3pDRUdiWDFBRGV0QzluaWN3TEVO?=
 =?utf-8?B?dHFGbWZvbFNDckpZSjgzTUdPRXhQblhoTmVKRklLVmJWSTFKNWF6b2RPcDYx?=
 =?utf-8?B?QmxhVDRBRG1MOXYzR3ViQTlMR0h3eURVeFVHSm03ZXYvSmgyTmJLbDVmMW1K?=
 =?utf-8?B?OEdvYVZTTml5SFN3cnYyc0xteGR3cXdtbVZhQXBReHhDSXd6bzQzU3lQOEYw?=
 =?utf-8?B?K2tvMWN4ME5LZC9HQ0IvYmNNSmJVdDRXQm1McnlIMWc2dTdXNklBMlNuUlZr?=
 =?utf-8?B?akpaeDBLcm44Q3Nrc3h2cUlPZ0h2QVVRUHJqYzFCdVRHd2VOZ21LZkJPY01K?=
 =?utf-8?B?bGhIT3FQeTRYNktxSi9KM3REZExmUmZFbVhraHMvUlUyWFlKamI3aGg4MjJQ?=
 =?utf-8?B?dWlPcHBKRFRqL0FjT0FVL21DdlVvM1dpcWhkYU5VWEQ1RjY2R0l4Zmt1ZjZ5?=
 =?utf-8?B?SWdwR0s5OHRodGkxNkMyYithSU82dFZoVWN1bDJHbXZJZGtLdGQ3WGxCRUFV?=
 =?utf-8?B?YTd6UUtianBLRlFmZWhkZ2oyK3Uxci9Sam52Kzd5UWl4ODRXaGlhTWxCakdy?=
 =?utf-8?B?SERsYzZyazI2MGc1OHJuRVB6emtqUTk1RzljNitLOTgzTHFVL3NXa1piMkpS?=
 =?utf-8?B?Y2hDbDFaVTgvOGRSM2JYeTYvWmpuTzJxTG9aMEJIUHFBUjRvamhzdUloamlW?=
 =?utf-8?B?eGFoUVR1OVhYUWg5U1dhRGNBOVRmOE95bjJjOElNNGxrNDg5T2YxL2VUWVla?=
 =?utf-8?B?K3RsU2xrb29HeUNRcEZId2xjNDcxemV5TnRFR2NvNlo2RDI3VkQ3M0FxVk80?=
 =?utf-8?B?UHNKcUVsWGkxMVdoMEllNVVrbFg1K0hzZ21JQjNTTmI1NlJwOFZPZjJlNUpC?=
 =?utf-8?B?QXpWWVlncFA5WmxRQ2JxcVh3d1RlaDdQYnFTUXdNc0RpQ1kxQzBkQlp2YW40?=
 =?utf-8?B?aWVLYUZLeSs4MTZFOGlzb29Za3FXc2cwWnFZZ0pXMnltbGxXQ1BUbVYrd3g2?=
 =?utf-8?B?Ry8rT1VMeGdLSWNwL3puNFI2dEd0YjZGdHR0bHpTRjMvZ1FQU3dGNlNJY1Y4?=
 =?utf-8?B?RHpkRXAxQWphUUlRUm8waTNkbU9sWWJIV2M2N1VoQ2hDUzdKVysrY2hDbEoz?=
 =?utf-8?B?NVJuUGhWSFEvTWpUdUFGMWRIWDdZdUg2MXVEemkvUStsQlVrZE1UTWJpdFFP?=
 =?utf-8?B?K1o3bUNzb0V1cElubGVZTWY4ZnVYSUFxbXR1ZFVCUHV3dFpiYnZnVWZHRThC?=
 =?utf-8?B?dmVSTkowWlExLzJHalJFZWtUNGxZMHNybGVMSWwrc0JOS0VkVkdLcGNNdFRs?=
 =?utf-8?B?YWZZbVZoUktmR3RMNVNGSTlKV0d3N2UyRk5pOTlOQkNKNWRGSXhjUTRIMmhh?=
 =?utf-8?B?Z2Q1eko2UUhkRGsxQ0wzUVh6NVhoWG5RK0JZQml1U2JnV2l0SE1WREJ1Nm01?=
 =?utf-8?B?ekVZRTNRSUFieGNhSUdkUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjdEVGlKTUVTZ2phMTA5VnZKOXlkTEpuSjF3T0dzWkltcXlmNEpVOWlxcUJ0?=
 =?utf-8?B?aEdaTGtyRlpxNzRib2JKemxlR0xka01paWFUU281V1h6MlRGN0ZSZTlxM2xs?=
 =?utf-8?B?MFF2cFBnNnJuNlo1Wm01cWV3NjhlSHBtN0pKdkhOR2d2VnVoMjJnczN0czBL?=
 =?utf-8?B?aml0SzcrdTlGa05rcWhFaHZiMnZZNU5lT3RzWTNqS2NnaDZPWFpWbCtka3U1?=
 =?utf-8?B?aVFQdWo5dHV3SWg3YTBJemorVWZmMVJ1US9jbHEvdWdjd1ZjUmI4dHNXMVNX?=
 =?utf-8?B?ZE1XV1pIVnB0MXBROXhldC82ZjNvOFk0ZnVlZzVDY2Y4WVJ5NmFlZlNPZkhE?=
 =?utf-8?B?MjFWaDQ0bmNjbGRhYVVyWU5oL1E5UlJ3eHBIc280WlViQ0czR3A2TDVUMVJN?=
 =?utf-8?B?Mnd4SnlJc1JGUTg0Q3VsWXBHVzQ4TTErZ3ZmOXFhSVhyOWZWdlE2bzBDYTVY?=
 =?utf-8?B?bnNDRklqaldsQnE3VThxaXB1bHcwajR6bWMyTGxCd3pSV1I3cXdJVmlUV291?=
 =?utf-8?B?TE9Bd0t0dXl1UmxkaXBuWWRHV0Y3RC9MMkg3S2R2QWp4SHVoOTRzTjJSY3Jq?=
 =?utf-8?B?bmEzL3M2dTlCOGNGK04wdDIwR1NjWjR2VU9SalVDR09nd0kraFAvZ0JxQlhu?=
 =?utf-8?B?cUx1L3NGb0RiWFg2bFViNzN2MEllMGU3QjhXYkpOdVFySFBZM0FZYWdHVHdY?=
 =?utf-8?B?Y3JJOStkNjRVaXJBRFphem9zUWFaTWNYY0JTWnNNZ3NsQk9yMjZxNEYwT0hT?=
 =?utf-8?B?TCtyNUhUZE1qMG1zTkFqeW5leGFwOTM0eFVQNGJrckNoWjhCZ3JiNnNCbktF?=
 =?utf-8?B?RWcxRk1lNyt6UnlaL1FWbjVOeFozVGRNbWtWWmhmTzhtbkxwM3Bwd0YrVGQ2?=
 =?utf-8?B?cXZUeDRXb1NkQzJieEhJZUFQUTJhWEFUdkJnWlZzUzFXZXZGY040dnZIV0xs?=
 =?utf-8?B?VzdqcjdIUThKamV5azFCUkV6ZCtNT2VHZXlaY1l0TjIwdVU0SjBqb3ZNcU1L?=
 =?utf-8?B?Y2wydGFMRTlrSDZhd2ZncDRLdmVyTFhxelI0bk1iN3ZqQWtValZLUkg5USsw?=
 =?utf-8?B?aVRmTGR0VmdUWkdUUTNqeTZ4UExacnlIMng1OGpxVUEyeWkrSk80S3I2Witn?=
 =?utf-8?B?dVltRnloQXZTYXd4b3I5WStRcDNoRlgwUElUVnNBQVljcFN6eWZtaWZCd3Fy?=
 =?utf-8?B?TkFYS0UzeTErem5hMlV1cFpGaUZNZ2hjZm9JNUdlUDBaSlkxOTdLUDExTFF6?=
 =?utf-8?B?dVpHTXVRbitNTTJTcjJoNmVQb1NqV1d6VkZvTitZMVZBM3ZETldUOVRMRmFu?=
 =?utf-8?B?V2dyQ2k3c09jcjJLUC8wQThNT1FqSVVaM1A5bmo4a2dwYTFyY2RYemZCOFhV?=
 =?utf-8?B?OXFROVRwTVFoOUNYcEwvK09nMm9vVHFWT25xMUhzQXY3TW5oZEE5SE9jSFlH?=
 =?utf-8?B?eGdxbVRSN25ZOVhYNDVhQXhwS1d0MFl0SHA5MjYzdEZqcWZQYjhJeFpKSUlZ?=
 =?utf-8?B?OThiaWRkRkpKZ2FrM3RQVVRMMmk4RG9qbkQwOThLVGxUSEVkeGpjSXQ0RmFR?=
 =?utf-8?B?R211VW5aRmxzc2VQd3FadVZYZDd0NXFPc0tDelpHRmhaa0ZYbEpEZWlpcVpJ?=
 =?utf-8?B?ZW9weWppMkMwZ1VhTW9kZ2h2am5RZDA1a0lRYVYzRzB5eFNGZ0krMDNFSlRv?=
 =?utf-8?B?aGs1RlN4ZmlhOVNhZ2pYWWVTeUVkNmJ1QjZrS2gwRU15T0RsMjZ5UEV5YTZC?=
 =?utf-8?B?MWplQmlxenJBSTNqMWdOcFVjamVBSmg4TGZYTHViL09LTHN1U2xZNFBSWkdt?=
 =?utf-8?B?WFlWWHE1aVAvZWlZREdNWGVFQUM4MEVaZURXQlNpUTc5UkVYWFVCMWNzZHRN?=
 =?utf-8?B?OFk5Y2tlUEpIN0xpSk1nRlhaWmsyRVo2dXJITkh4RUJQc2RxVWM0WlFEUDgv?=
 =?utf-8?B?Q1FSN3JzSXYzQVc0NHFjdjFlS0ZjUldCQngvdW1scGJ1N1FTWHRQV1JsaU1N?=
 =?utf-8?B?UG1ubU82UGFkV01YNzF0d2pWeWhZTnRqay9pcm45QTFkc0UyVitUYURRbnBK?=
 =?utf-8?B?YXVQV1JzS1dlOWVhRVRXNFNLSk1iTTUrTXdEYjIvUzdJS3JybXdWYzAvVnNX?=
 =?utf-8?Q?laL+0WDsa8zn1uj5IOb4cx9Uh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97073b3d-9430-4396-856f-08dcc06cea3f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:35:20.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDhHuI+Sq6dV3p4B1sQmq8kTpb0SlFvFRq5nOGtFtPoaFyGSY4SxlU5pDelT2l5jhJUaWdRQm+BwYzfS0owtnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476



On 8/19/2024 16:40, Jarkko Nikula wrote:
> On 8/19/24 9:41 AM, Shyam Sundar S K wrote:
>>> I can add an additional check with the CPU ID and distinguish them(so
>>> the quirk gets applied to the affected HW versions) and just not
>>> restrict to X86_VENDOR_AMD, would that be fine with you?
>>>
>>> OTOH, Since these are quirks (where its a broken hardware problems)
>>> and the idea you suggested is related to driver data (where driver
>>> data is meant to store private information about the device)
>>>
>>> static const struct acpi_device_id i3c_hci_acpi_match[] = {
>>>       {"AMDI1234", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING |
>>> HCI_QUIRK_RESP_BUF_THLD},
>>>       {}
>>> };
>>>
>>> does that not conflict? quirk vs driver data?
>>>
>>> I am OK to implement it the way you prefer :-)
>>
>> Jarkko, any feedback on this?
>>
> Sorry, forgot to reply... What do you mean about conflict? So if
> driver data would pass quirk bits as above and set only to unique ACPI
> ID specific to that HW then there is no reason to check CPU ID later
> in the code.

OK. Let me respin a new version.

Thanks,
Shyam


Return-Path: <linux-kernel+bounces-554155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F13A593A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10871882949
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59322B8CA;
	Mon, 10 Mar 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5jcYUvQ3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADD22AE7C;
	Mon, 10 Mar 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608400; cv=fail; b=ZFVNbjNu5uAWLq9U3FwD/k187JlRXnBQM+ALfDlwd2GVMwHGLX4d3JYKb3Z16oWYVJlqGMiwVpBx3T77EJoGuzl8BkaFIEiiMjedE2pjjMy2eCQ1l3En7JvWSW/FTK5pHCsfiZW6d/+haqWuPsuYKaZu0UAszYh8gNpJ54e/rwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608400; c=relaxed/simple;
	bh=qWEieH51xmd+q18KdI76AMY54P3/zT/KT5EpBn3QWR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eO2dT/lc8k1sDhFWE4wUqEsO448gcxz52dMxu13IcA8HCI+kOVa+zSVWsiiReKIiSiWGflNHNt7PKJmQ4m1vHzE3atXHSA2VwFaDl5PGXeuq3Vwg6DSCWEP+Y9pGhKYNJPQPbZ9o5q6f8KE/0V/yhbW+IgeOxREu965u5xRASwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5jcYUvQ3; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4KzYdx7wLXltzSyXXpw8a4dx6HYMJOnxzghv8Ntx9OdD7EjyJ2To6PcruWsL6tUjXf3+9zIRpESkuG31SaQWOm2rnDZBpUjp5XdaaXA4cYUIF3mv++zSbWCn0mWQaZBL2ltO+RRqzgQOeWT+nqvrTXjJkT/wRhj1CGFT0QAa+svK2Yx2vBvhuDu3pTzNS6WVp4Fhr04zIbuaAm5iAgZWyKGqsaNGJLDLlMgOQR2wNM3Vx98dC/Nk7h0pZcbO+wTnTIpzVYM7aTGqpwOKkq5ut/wiHIkQ/I0rB0xKE6ryTSBbSAP2+zWaZUng2cWMAp18L2T/u4a3z70wA2Ffw2AXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wSDKpLZ4mHcKbYPTWY0SduxsaBxbR7RsnVc4msyqDY=;
 b=O/dioHNRQVWGPT2ahKQNgv2vx1EDrc3O4bFQog9OoB3EKu9nW5a2l+r9LvV8FmffrmJSTh6vcjE5z8ng9i5rPJhMhAEuUxczWYC2hPBOzOVBQL6ZltW7UYAeJUsxkIusC1Dalp1R8/EP34b4aLIG+DClr/dPZZHntc1ftXqtq3fsW4Agy/NGsmU1NU/Bf5cCKHKxO+dk67gz6ljI7hV0TB5cyEQ66DLwv7Oe2k/tz0w9/WTbqgAQbBZE0m4Q535T+igvyA10mzwea6pFx/eIsE8YxsRH7fM3pfplG9v3hEA+K1A26z8aoF3NAC7+3H77On+J/B2+ip0RI5/NzKLxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wSDKpLZ4mHcKbYPTWY0SduxsaBxbR7RsnVc4msyqDY=;
 b=5jcYUvQ3m346h5uMl6MKEx4DEUZv03NcZVTAhQT3atHqSoGJ4oupeVxoBu3v06mlDxuQyEt9NEe8XBG45DjhOQqW/9ahV34gvYVf4EqhFjeRNVtewv5yMyi9V6IXRnhsUY+mmL7pItgYzEgZkQrrOm0mu96q8OKZF5579lzjO1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 12:06:33 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::df88:d99:3cf3:dec0]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::df88:d99:3cf3:dec0%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 12:06:32 +0000
Message-ID: <484a533b-feab-491c-b3e3-62a3595fbcbc@amd.com>
Date: Mon, 10 Mar 2025 17:36:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] ASoC: amd: acp: Implement acp_common_hw_ops support
 for acp platforms
To: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
Cc: Vijendar.Mukunda@amd.com, mario.limonciello@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250310104601.7325-1-venkataprasad.potturu@amd.com>
 <20250310104601.7325-3-venkataprasad.potturu@amd.com>
 <f9436b0d-8cfa-4f37-9b0c-395c033f849e@linux.intel.com>
Content-Language: en-US
From: potturu venkata prasad <venkataprasad.potturu@amd.com>
In-Reply-To: <f9436b0d-8cfa-4f37-9b0c-395c033f849e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::29) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: c8569302-c95e-4739-e3c6-08dd5fcbff63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWd5MHp4WlVtTE5jbmtOVkNkNGVxRWJYNUVZVUlyQUJ3elR1WGhUS0dreHBr?=
 =?utf-8?B?TnZKMWZIQWhoZG9VS1YrT0I0N1l2d0ZzT0VxU1dNQ2x0T1lPV3BwYjJDVnZM?=
 =?utf-8?B?c0dUaHl4UUlidmJOVUU3dHJUMElGbWowUWJZYys2ZkIwM29jQUVTUkljN3Q1?=
 =?utf-8?B?ZFdXN3dYditxTmhlTFRPaytDZ2RvNXBwZlErU2NOWXg4VGQ1bGRVRlRvQmNs?=
 =?utf-8?B?bUZrMnJkWUYzMDh1d05aZExCUUFTQmhZUHhmUHNOUVRXSWh0MjM2ZXpSSGdU?=
 =?utf-8?B?M1lITlROR0lrN2hCZ1ljUi9FQkxHcElBUzFrbXljMWVHZkwzd05aVmtVdHZr?=
 =?utf-8?B?OXR6bHNYQTVnRjZiSnhjSlJZY1lBZk01b0JVWUJBSERPQnAwVGRJYkgxZHZz?=
 =?utf-8?B?aXlBZzBIQVF3OUtma0FscjhjNXNnNUNzUHhWUG1jc1ZmaEFRcHhRY2JxMW1N?=
 =?utf-8?B?T0l0YmtDY05UQ1NoTVQrZGlraU9rV1NIbjFNaW1BSGhNR0tkcFFJdThxT0FD?=
 =?utf-8?B?bU14NG9OQll3ajZnM1Z6Rkdnamg5eDJPNU1SV1pVMExtSGxiUkZ5K3kySDlG?=
 =?utf-8?B?bjRNV2JnZ0FoUzNTUkVCamQ1RGNISmgzNk1yTE5iVmNhU2x1UTAvVGt5Vmk5?=
 =?utf-8?B?OEJlU2FEenh6YnYxSlAwQ3dWY0ttQzR5a1pHNEJVNUF4SkF3bXhKby9rS0RT?=
 =?utf-8?B?alZFbi9aQW1TcXJ0ZWprS1NCRkE2cENCdThNeVZHditwZzZvY3IyNUE5WnY5?=
 =?utf-8?B?YzNjcWxsRFd3S1V0S1E5eE1kM1dqOTFsaUJXRTh2TzZ6WjVRYzBxZlBqeFhW?=
 =?utf-8?B?RUhSbUNKRGVXWS9Sei9kTUM2R1lZSi9uQloySjY2RG1Qb093Qi8xT2dPZXFN?=
 =?utf-8?B?Ums3VTdWSlh6RVFveXk0cDdENGRwdXp5bjFRV3R0MGNTNy9QWm5EdzNnV1Va?=
 =?utf-8?B?aEpRdVhZMEhrMytnOSs1eTFkSkN5RU1MY2xOdFk2Ty9UTmprS1hKREU5WThC?=
 =?utf-8?B?dVdhY0JwYmhkbkdMT1ZLR0plUXR4TDVrOC85dWhSTWo4alJmRVZ1cklJMU1M?=
 =?utf-8?B?NHIwb25oOUJRVVk2U2JmMU1wT3VVcU54WERhVWwwczdtOGFLZG5XRDJ6NEYw?=
 =?utf-8?B?S3IxVUtrNnJnQnJaSEM4N1FWQUMzVDJ6OW9vNk5hUE5ybE9Jem92WjdWVHVn?=
 =?utf-8?B?cnRTSS85cnFNMGIwVVVaYXZvcVVBWUlZSm9NNDgzRWVMRk1QckxZQ0Urd2pB?=
 =?utf-8?B?dWlPanNrNWdMbGY1aDlCdlIyTEp6K2VYWkpnMGd3bVNUbjFiamsxRVlKYS85?=
 =?utf-8?B?SHlPbGtKaTUvOTU1bEVqbTN4QVdqdENEd0FaUlYxU3ZKWlJaS3lSUVV3Z1JU?=
 =?utf-8?B?RGZXc0xhTWloN2x4MUE3clVBUFBhMWxuMkFwMmdpc0paTDlCbSs1K20zdWFE?=
 =?utf-8?B?N1BoYTFqQjdWT0xvb1E5dktJVTJwdFJZdGZUZnJpQ1lwRDJkaThHWXl1aFY4?=
 =?utf-8?B?aHZ0UEYyYitYc2k1T2paRS9jUUtHdDNqcEhVUGlVY0R4a3JwbHZndnYxa0ZY?=
 =?utf-8?B?MEpNZWhlNDh2azZWZVM2dUpPR2RHaFBpRW1IZ00yQlZQN2svbXc0MTdwWFRh?=
 =?utf-8?B?RElRUHhGZ3FaNVNrUU50M1RCcEZKQm5IMU1LTFFmOWUweE05VkhqODlFUmVq?=
 =?utf-8?B?ODZFODRRa0tCdUxTazlMdG9hYUFYLzUyNkpxQ2F4eVk0Ri9FTXBvSi9GYzcy?=
 =?utf-8?B?N3JPc25yK2VCbk5sR09HZlo4N3JrdThwVjBDZk0zL0JkOWlBbHl1WkNwUjVw?=
 =?utf-8?B?VFhsWjFpQm45QkFTT1NXUmJZaU43aVk3d3Bzd2FuQTFQWGszYUwyc3M0UXF5?=
 =?utf-8?Q?rdEM5KAOKcTlU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUhEdzVlSVNlK3grY2tJUnRvR2EyYmhQd0gxWUJRdzJ5TllmeHV2ZldURUc3?=
 =?utf-8?B?dWJmaXhyV1BRUTV2SzRCeUZNdTlGUnl3STFaWG9oTzF5NG5pOC9HUTdWcWll?=
 =?utf-8?B?VklBc0tNTzgzcFVOSk9MZHF0YXNMVW9QbmFTR1dHMU53cnJ6VlI1S3QwWlB3?=
 =?utf-8?B?ZDFXb1ZXeUp4cGN1TDA5QjVGYy9xejN4a1JtYTRXRXdQRFI5MnJta0NMc0FL?=
 =?utf-8?B?NVNVVzBPaXhMb1F3WDE3ejAwK1NIR3c5cHZvbFpiL1dMOUl2MmFCQ2hLaGlM?=
 =?utf-8?B?MG95NHZxODBnMCs2YTQ2UzVKcXZNMnRpRzgyRDl5L0djODhZeE5mZFZXRjY3?=
 =?utf-8?B?K1pSdTF4aW54VVpTOXEwclVWbHlBWTJaMm9TdW9zVXkrTWFuNXBDZy9hemVP?=
 =?utf-8?B?cnFyOERWQlVTRC9UQ3FRaldjK2I3NjhUZXc5VEpuR050dTlsaU0zNjZOMXRy?=
 =?utf-8?B?UUdkQThZaWxmNGVSTFFBdDZBNGFGWTkzZGVnQnF1WHgwcmhTSDZ1Y1NucjlC?=
 =?utf-8?B?SkJFOWxMVmI1MTFuYyszQUlzb0U2VE93ZGdmK2VSTEVqQWdkMTY5RTlLcWhE?=
 =?utf-8?B?UGQ4VEZpWUZBNGFKOUJ1V2tic0xCTHVrVGZ3RklqbW8vdldmaDJLcVRPaExw?=
 =?utf-8?B?MW53VkpqVTJtd01ZSTR1enYyeGtwbTVJeDMvKzY1WVFpNVV6TGkwanJXWHdJ?=
 =?utf-8?B?MHZUYjd6c1dnZWttODZaMHpDSm92MEhnNTBZZVQ3Z2tDVGhoc0NTMEhWSjhu?=
 =?utf-8?B?MnhNRlJwK0RPWkNCR1RkdC9LeXUwQWsrMHpyT3JRNWdDVkE2clE0enFBSnVE?=
 =?utf-8?B?NURpblVZbmF1Zmw0VSt2M1Q4ZVQ1Y1R4UlJ4SXVqd2ltNXlhME1pZURzTS9S?=
 =?utf-8?B?R0Q5QzVFQmNqL0hPYkRGaWhIK0NYVGtEZU44Z2FadGlWb3NxQitOTkVLcWFK?=
 =?utf-8?B?aEhXdGJmbFZLOUUralcwSU8zUXJ5VkRwTjRNYldmVWlmZFZJczh0VDl0Yloy?=
 =?utf-8?B?ajZTL3hEdG5zR0FpYmVXQVQ4WnpVdy9DclZVZU44QzV4bzRIOVgvUzdMMThT?=
 =?utf-8?B?Sk1ZdERUWFpaL2RTZnFQY1YvR0pkTS9pWkErZXJ4dGtDbUhUS3M1Zms1c0J6?=
 =?utf-8?B?azlkZ3dEdVJUNUo3L29PVE55N2p1R21IaWo0V210NjVLdDljTHhNQ1RyWkJG?=
 =?utf-8?B?N3IxTEVpZVBMY2NPdVB6SDNTQm5HNnVwdlVqRUc3aTRaVlRNdzR2bWEyRmpV?=
 =?utf-8?B?OGY2RFVaaDl3NVIyZzViTEMvUzF2ZE5Yc2EzazM5NDZpYzRCSnlyTnJvYWJr?=
 =?utf-8?B?dU8wekhhcUtnd0g0OUNMNFlSejlUUmpLejRlTm1aRXJCYWErOEFhOWsyVlNO?=
 =?utf-8?B?eE1Gdm1zeVlOellURlR4ajZCZzhFZFFacFlMQmNOa2RrbEQvNFlGRzRRc3RJ?=
 =?utf-8?B?SlhTMkNtLzc2U0M0UkN3UXJMcFV3VHY4WUh4aEZTYituVUhLU1NiMUVZaVZS?=
 =?utf-8?B?Wkh1RDBtK2FVajVKM1c1SVh0b00zSWNYWmF0Yzc3RXo2T3ZPWkMxVmtsb05K?=
 =?utf-8?B?WExsMDR1SDVDS1hNK2Q3cEplRlV4TzU4aHR5dXJrRlJXR253WE1LdzJCaVpX?=
 =?utf-8?B?N2V6dTdSbjhkU25hYmhQN05yTWdDWE9hR2RBcmk4QllUOThQT3hPcjh6a2Ri?=
 =?utf-8?B?ckZHZ0dJeWVnbFZ2NWxrcEJBVUJyL1p2c0ZJcUxzREpDbm8vODFWemVkK1li?=
 =?utf-8?B?UGZzVHQ0dDd4Sm1IREkxeVBCZTVDK3NWN0M5cmE2MjM2ZjB2dkVRZWhDb2ZZ?=
 =?utf-8?B?Sktwem9yMzY0emJrVzUxLzhvSHdrbTRlTFNFM2RQU2dSbDlJeU9udHZjWXht?=
 =?utf-8?B?YU1aVEszaS9Wc0JUeksyK3d1OVFDellldTJmWEFaRk9kMDB5TVlmOFlRdmty?=
 =?utf-8?B?dXp4OEpybnNBN0RQR0MrdjdCYjNNV09WaHBuUDhFQzZWYkllMDJnRXRTMlVl?=
 =?utf-8?B?YWxOY1ZGL2lZRWx5WDd2eWp3QnMySU9KSTdqbUZ2bENvMGkwcTlIS2FoSFJ0?=
 =?utf-8?B?Mko0T3VTd3Y3a0xqczhvc0hZaE9CU2w2dlFmNzN1VnRQRVdvK0VDMWR3Tysx?=
 =?utf-8?Q?kp6Jr/KTK6jZ3AuKod94AcOCQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8569302-c95e-4739-e3c6-08dd5fcbff63
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 12:06:32.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keMInyfi4hR4N/QUDx/m9pe6T/NtDzPSbt+KK5xHKfxDFl+94xH14dqk6kcLKOOpRx67WboNjaeWnI7gCg8ivQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251


On 3/10/25 16:55, Amadeusz Sławiński wrote:
> On 3/10/2025 11:45 AM, Venkata Prasad Potturu wrote:
>> Implement acp common hardware ops for acp_init and acp_deinit
>> funcions to support commons ops for all platforms.
>>
>> Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
>> ---
>>   sound/soc/amd/acp/acp-legacy-common.c | 50 +++++++++++++++++++++++++++
>>   sound/soc/amd/acp/acp-pci.c           | 13 ++++---
>>   sound/soc/amd/acp/amd.h               | 36 +++++++++++++++++++
>>   3 files changed, 95 insertions(+), 4 deletions(-)
>>
>
> ...
>
>>   @@ -252,6 +274,20 @@ int restore_acp_i2s_params(struct 
>> snd_pcm_substream *substream,
>>     void check_acp_config(struct pci_dev *pci, struct acp_chip_info 
>> *chip);
>>   +static inline int acp_hw_init(struct acp_chip_info *chip)
>> +{
>> +    if (chip && chip->acp_hw_ops && chip->acp_hw_ops->acp_init)
>> +        return chip->acp_hw_ops->acp_init(chip);
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int acp_hw_deinit(struct acp_chip_info *chip)
>> +{
>> +    if (chip && chip->acp_hw_ops && chip->acp_hw_ops->acp_init)
>
> Shouldn't it check for ->acp_deinit() instead?
Okay, I will correct it in version 2patch series.
>
>> +        return chip->acp_hw_ops->acp_deinit(chip);
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   static inline u64 acp_get_byte_count(struct acp_dev_data *adata, 
>> int dai_id, int direction)
>>   {
>>       u64 byte_count = 0, low = 0, high = 0;
>


Return-Path: <linux-kernel+bounces-340516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E44987482
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414401F226F8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10B4436E;
	Thu, 26 Sep 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d8jc9jub"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787E322B;
	Thu, 26 Sep 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357797; cv=fail; b=LhD+zlA7sQgpUkPAnojsF9FMnjxqsSyRwIy5QRkkZfqJbmV+w+MVc+thSZkBlhOI+8skI7tj/o99ULTEZKLSjqY6+RdiwBo6hkk1hVqEHCwQDtVNndnrJBBPyOLzrj3unGYbAhzv+riP1s5p21w1Ev1LaNBG2h8AyUcJ/4VoTeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357797; c=relaxed/simple;
	bh=LYcnaiNpGnPVwcOXeH2AWjIcHVLg1ddYa4FSSO52PUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OZrU2Rd45tnfdoUNYcC61VCj5+9opI4DKZNYmGwew3exWaf6dze/a9mT/1OAxXq481IqITxOzTXd+06Cup5jGYSJfHGQMH3//emCOl21kTV5PAOpGZYQI7qFF4jACe8lDQvlAnjdtSzdmJAxAfkIieAwpDGDKYFRtGsXr2BfDZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d8jc9jub; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAW40EfJ4FtdM6d5zNq9iDVqYy/M4ogDNHcm3w02Lgk26JD/CcpVnCBmpgnIX7vCENm+ENs3G8yF+UHgP4rMHol31zk8DVLcOA4sHmx6RAs12V0dWfmrkx/+49IqCSFDUgc8i7ZSyj+jndtaZE0luZbk95RVGDhcb/Uor8Ijck5U92smWnLY1jZjdN/uwUxLLFnZL1IIXQqmeikCqGEoB2H+GcE11r8GHSkw66NZpvuEgPjC77nSRyxQH7e/lthc5H6B1VaQXvfP9FJvn6d9qQwwMVrUR3bWhlvE/yDlR4PWQ7e/Zl03xGG+mX848NdzBymJrBnUZPFffenTOyVFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4zVsOTgwhj3TjCQJ8C5NT3azWw1xTyUs3poMI1pUEs=;
 b=WDHF+XgqbBml9RO0bivOSXzon6b7DD321u+hn2UjaHphq2j3V/a1d92zxQvDgqfndUvwXfZXEanoVwSRh4AJ/PmYSDbx+ToR1nKSoCoB8IlPN1hUKWE5FMTAfARqQcQUwgnnqsLpkfssIPd+aB7KeGIa4jXhpro1LKyakvZn8oPg0xcz2eFqSfSUnGgKYYUOQQF/KwSwfY7LHwWAt3jkmOV7JtkSPzSJEvfGHZafIDxOayz7oRQX51iPKklX2i7eC6qtHSPNue16Iw71KJKfTWpLcD9KAj1pqFu/LGhcKZW6JGMi5hEpFfCpgZgHatEYh4TzcX3/flXwiuxjB0YCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4zVsOTgwhj3TjCQJ8C5NT3azWw1xTyUs3poMI1pUEs=;
 b=d8jc9jubIsz20NaFpKB/qKNB9r3q2taydPqdFGg4IRcrDon6/17gPgGotIkhZp3s+nfIfboCiRzKrXY+aM146DLspZbmhD3aEe8CH6D/PXTUjv79axQHxvdLnLOCgFgy4GsYMMGUmDRpVH7IQwTyvjTxOKqjYWwaewvDDC3ekng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 13:36:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 13:36:34 +0000
Message-ID: <c19f3530-a065-461f-a5bf-ccc3988cf24c@amd.com>
Date: Thu, 26 Sep 2024 08:36:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] platfom/x86: asus-wmi: revert ROG Ally quirks
To: "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, corentin.chary@gmail.com, superm1@kernel.org
References: <20240926095344.1291013-1-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240926095344.1291013-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:806:21::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a6ae3c-a58c-448b-3a22-08dcde303cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emZ4aWpBVitmVGRteXJtTzdyelUxVmd4TytSZHFlVnZMZmxGSGY1bGZoVytN?=
 =?utf-8?B?amR2UXhOV3JndU0va2VlUUxKSXFvYUxJVnVhamhWdWFqTHRqWW9teGo5aWNH?=
 =?utf-8?B?NjA1dnV6ZmgzY1BET2d1bHB1K0hCZ1JoOVFWOEhTdW44eDRSV05SUzV1SkFE?=
 =?utf-8?B?c0t5N1Zna29HdGI1aHVBdUo3YmhtSXM1U3JvWlU3WDJpMEFDdzdndzYwREVv?=
 =?utf-8?B?UDA5NnVzSXZWTUwxU003R2Q2RVBLdS9iYm1kN2trenRsMkVlZmlHTVF3RGcy?=
 =?utf-8?B?MFlKOGEzYzFJSW1iZkxNcjhqcVh3TTdzYW1QQTZIQnVBUUJsQzNwU204c0ls?=
 =?utf-8?B?UGhVZWFGdnVyUXpZQ3kybTZsQ3N5c0dwYTlWUG9KM0xoYjlxNW03QWgwWGc0?=
 =?utf-8?B?czZoSWlFeEpDQmFBeDFCUy9vdDJ5QStmU2wwcHViWUswL0FCYXZjenlnakY4?=
 =?utf-8?B?cXVnZ3V4ZGVSNytIVjN5MVY1akQrNUhJSE1BbVp4TGtTMG5zelpQOHZvb2hs?=
 =?utf-8?B?dDlwbWk2Q1lUZENGM2NvM3FkWkNzakJHaUthNytPcldNMklDdlhJU2ZwMWth?=
 =?utf-8?B?amRLU3lmSVVCbTAxRGgzbkhoWmxKKzNQR1kzYmYwVEZXcUFlTEdMVjczeEF5?=
 =?utf-8?B?SGYrYVR4N3NtUnppUDZlTjVLL2dSaTh4Q1B1QVhveVY2WXllSTlMRS8vWlZm?=
 =?utf-8?B?cThOaHhjZno3K29BaTZSQ0pKeU4wYzNUejdQU2k3K0Z4SXBKMXdHR05HcnNK?=
 =?utf-8?B?S1VRT1RTdldDTkU1K24reStvSDk0RHhWS1ZaNUxwU0xLN2p1YS8zbVNuSHly?=
 =?utf-8?B?TTdUdnJqeEJmZ2FlbEZDbEpPa21zcmJqWGdsQVNZbWNxV1hualBrSHpmcWlJ?=
 =?utf-8?B?ZDVFdGJ6ZmV4TEt3V0x2K0s2VDBqSDFLeE1jT3h0SSt4b0VGaER1RS9XWEIr?=
 =?utf-8?B?eUtmcnpURE5aT1UvNllnSmI1cHo4eVZGVTdSRE1UbW5GVEUxTFNSR09yQlMz?=
 =?utf-8?B?ekJHdDEwdGZRTjc2aWVNYTM3V1R2elBIZHAzMWpZM3I4U0NtZjdUMEczSTRM?=
 =?utf-8?B?bGt2cjdiMXJWM21MZ0dGVjVGU2pjT0t1RWJBaGdPOTFuc2VCNFpkYkxiNEFN?=
 =?utf-8?B?V2lzMDh2MUt3ZFV0L2tFcEU2bmN3MnRKWnY2V3VrV242andINVh6eEhxYmZi?=
 =?utf-8?B?STNveHQrYnpwcUh2SWxVWUIyR1dvbC83NFN0MTFvcjBRR28wWDVkSGFrSHBW?=
 =?utf-8?B?cGt2NHQvaFBGb3VpekxJWlFMdy9YRG0xNHk0aDhKclQyM0xOejNDUVVvYXd1?=
 =?utf-8?B?R2ZjbXNOSmxaVCtjaDFDZERCanlsdXVvL0VLbklPbCtDV2s0Mno5VFF5eXA4?=
 =?utf-8?B?QWhvTDU4cTZIT2l0UjF4QlNDQktpWFlYcktIdHBGcG0rWXI0bldrQlQwMEJB?=
 =?utf-8?B?OU1ML0FTWlBkNzJlZ3d5emdXUTUvVXRlVmlOMjdEWmtNQTh1N0w3R1hnUmFm?=
 =?utf-8?B?eHNxYXhHWVU2NXJMN2Mxa2Z1bm1GT3ZUcmZzeDUxa1RhWHp1MkhUTjJreElm?=
 =?utf-8?B?SEl5QVM4MmFTMkFJMWpEYWNwRUk2ZnNGcU5Gcm5OL01kSG9rbUZvSXpRZVcy?=
 =?utf-8?B?OEVyK0hvYWRrdDZ3YVN6RXBYMkJrd29DTVVXSCtOSjlKUEF0U1Bla2FOM1ZP?=
 =?utf-8?B?T1BNMXdLTjZJT2R3SzIzWURBYTBjUUtqK2x2Z3BkamZXTDJDRFVEUWV3NzF1?=
 =?utf-8?B?NitWZkg4eG84UVV1bFpLMUQyTWZ6MXN5Y1dtVlhCY3BwWmtUTHNQZkNheXJQ?=
 =?utf-8?B?S3hRWTlIT0EvbnRITk9Ddz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0dFc2xTaUdyajZzVjc4TVNoRisrYzg2RzJGTnZ5NjFKQ3BLT05pVnA4NXA2?=
 =?utf-8?B?djA4dlhieUtVV0RNT2g1cmJjQ0xjdEpmZXdvUzZpRUJlSjlKK1NEbDU1Ukxo?=
 =?utf-8?B?SEdjUE80Zm1NMjlwSGNERDhjU3RERTRFSzdaakR2dkNvK1VxNWlXdVJaK1N3?=
 =?utf-8?B?bzExclBnN2JubjZyaHltajd4dzlaZ2dkUmdVaDBsdG12N1V1Vnk5YVpjQUgr?=
 =?utf-8?B?cFZoU0dvcFpxK3pwSzdxVnAzZGJ4NkFXR0lITmRsNHZ6NnhKMU1XWk41c0N1?=
 =?utf-8?B?YUw1ck00VDNxTDFaOWJoZWpQaFYzaGpOVk0vSEdzM2dBWks0UnFJRkNNMnh5?=
 =?utf-8?B?WTJRQ1dsczZoVGZFbXg1R0FYOWdNYTYxcHBTMEYxa3VzZS82M3psK1hYYm96?=
 =?utf-8?B?clJGQTAzWE5PbExjbXRrUUF2cUZZTVBaVU4rekJJa2pwMVkzR3J3dGx6MGRo?=
 =?utf-8?B?UERpT05qWlJmTnpkUmNETCtTYjVKQ200aWowemdhTHJBMHJJWUYzRmVBUmp5?=
 =?utf-8?B?U0pRekZmWXk0d0tqbUtjaWJQUjBCV1o5Q0kwVTRPRkRGaGxueXkyVDloa093?=
 =?utf-8?B?dml6alE3d0tnak9BVm9sZ1B2S0c1MTZOY25FYm5lcEc0NS81TUlRTlQzSitn?=
 =?utf-8?B?QTFpWjRtZHJzUjVZL2xjS0thOG5aK3pubnRiaXNHMG1uZG9VVjBIb0owUG1K?=
 =?utf-8?B?SGp6OGF5aE5XTzZrdFYzLzNNbGZDVkdFYVVZbzVocTlyeThhUVpMNkdBNmNS?=
 =?utf-8?B?a3cycE55SDV2TW9FQXZqVmxoUlkxSnpuVzNLT1BCZEYybjgwRHZieHJHTjY4?=
 =?utf-8?B?RXhvd1lWTTkzMXUwMmVRR2ZvT3BqNEJIMExRU0RBMXE2aVJXZ3VMdS9DQWU0?=
 =?utf-8?B?cVVONFZISDU5K29nYWVobzU1TEtleENIOHRaQU15SXYyRUhUeTB3c0M1WEpR?=
 =?utf-8?B?QmJPN2puUmF2ME53REFQZmp2VHFudnZTai8yM0VIdlBCUkFvb2ZPUDA4d1hu?=
 =?utf-8?B?d1duTHdWRzNBWkFMVFdYOEYwM2RmbVZyc04vTjFNVEg2djVKdiswWVpjbVBQ?=
 =?utf-8?B?VDZ5TVdITUpiSU5OaWZNWHRnc1JzYUlJQ1VHNldrOEl0djVhNW1BZ0cwKzk2?=
 =?utf-8?B?OVFlVHZhdG5Sb2o3NnhxajF3b1pTQW8rRkF1TlE0c0xkSGVRNEQ2cEVPemtH?=
 =?utf-8?B?eitsckVuM3ZLQ2xBNkxvbXRQZzBXVHNaRm53ZjFIQ1MwekpvYUNqWlY3dGhI?=
 =?utf-8?B?am9HZG5jK2tIRnhadGQxb3dDb1crQi9melp4N3ljV3pZaDNqN0h1N0F2R3RU?=
 =?utf-8?B?WHRaMGlVMUJRYVpDV25vb2hTNVAzd2hTeU9ubG1lRm9IQmd5NEI2K2t2SWJG?=
 =?utf-8?B?R0owcjZ5aHFISzJNQWRhMXcxSW9IVE1saklLK1hzZ3d2ZWJLWkJ0N3dGbFh4?=
 =?utf-8?B?dzhqSERQdjNVZi82SzBrbllraWdHT2EvVmdmNFBmOHJXTzhhUkIrU3JjcE9D?=
 =?utf-8?B?bVpxNTFsS3drNjR4dDZkbXJlbnZkUXRJZFNYS1dXV3NqZVZWRitJSmIyTUxx?=
 =?utf-8?B?ZlBVdm1XbkVmZWt1N0owUitqazlIWjNkcWNVbXYwejRkYzZFTHVXbFkwMDhG?=
 =?utf-8?B?ZTZ5eG9YSFNUTC9aSzhlTFAwNVYwdkU5d2Q0VG11K1YxNVp4UE9VamdIN3RK?=
 =?utf-8?B?Mzd3cHFwQWhRdmVvaGdpbGV1UWRIcFNHTlBEM21SNTdrQXhZNk5tc0Y1azBL?=
 =?utf-8?B?SHUvcUJzVWJzZFZRUFh0cXloeXNkbGY0c2RMcXZ6ZGtiK0luWEdDYi9WQUZP?=
 =?utf-8?B?emxzR0orRjNTbjExRzhCbTgrWnI3dUFyWFBnbmt2ZmF1NE15cnpGZkZZd0M3?=
 =?utf-8?B?T05NdlQwbjk5akdPRmtpZ2Q2T1U0Wk8ySmNYN3V0YXZGNHl2amJhejY5d2Nt?=
 =?utf-8?B?SnhyZ1BhZk1rRTk1TGMyRW5FdWQyalN5TEhwTWhTNVJBYzlOQ0d2bkpJQkhS?=
 =?utf-8?B?U0NSbWtuaDRHYjAxSHRGaEZFSlhIeVY3Z2tDRm82SVpuYm1HM0pNeVdYVG9n?=
 =?utf-8?B?c2ZuWUE3KzJpRWtRZmVITmllREFZV29HU0RabWdJQ2hmQWo4YXJkSjhyZEll?=
 =?utf-8?Q?tLX9hknuPw6TfamImaB7fZyLr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a6ae3c-a58c-448b-3a22-08dcde303cb6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 13:36:34.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbtkYsEFD8QExiabz7pKJs27bezxaDB6pJe13sHM6azOId24wIMnJ/4ILFWhfu5LFm9AZUXoQ2yGXMDVscU67A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429

On 9/26/2024 04:53, Luke D. Jones wrote:
> The ASUS ROG Ally (and Ally X) quirks that I added over the last year
> are not required. I worked with ASUS to pinpoint the exact cause of
> the original issue (MCU USB dev missing every second resume) and the
> result is a new MCU firmware which will be released on approx 16/10/24.
> 
> All users should update to MCU FW as soon as released to:
> - Ally 1: v319
> - Ally X: v313
> 
> Luke D. Jones (3):
>    Revert "platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU
>      powersave"
>    Revert "platform/x86: asus-wmi: disable USB0 hub on ROG Ally before
>      suspend"
>    platfom/x86: asus-wmi: cleanup after Ally quirk reverts
> 
>   drivers/platform/x86/asus-wmi.c | 39 +--------------------------------
>   1 file changed, 1 insertion(+), 38 deletions(-)
> 

This series looks good to me, but I would suggest that you also in the 
appropriate HID driver that communicates with the MCU to show a warning 
or notice if the version is below the required version.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>


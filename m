Return-Path: <linux-kernel+bounces-208818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A9290298C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923541C22CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE914E2CC;
	Mon, 10 Jun 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c+FV2S6a"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908481BC39
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049490; cv=fail; b=fWMXa4a4t16tGy+OWFucHlfE0iCCgn1I00w+tOoWL5qzZxkYqH6t1zMlQzSAgnvWwFZ9Od66ilLxRnWkWFgAha6qbGXCA6k0Ra4BZpV+YdScjKdMf8YdU+VS41eWSxuEuQZ7gQbxcaunnz5zWKiuvDq++psJE9AsVxUAbqzuXXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049490; c=relaxed/simple;
	bh=3KA729ZarYr21U2M81Ye+KqmllfqdReCn9P8ZrG6mII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CXL0gFtjcIYPCt37z5ryIlbvsGugfD9OJn4/aiWU2N9C8TXIcdDKjqbMlEZUqrbZkUMn6kpJfQ1xUbRR/OPUv5vUcDPG5kGcaiblcWXN/lCMuGaswBRwME3FgEQ4rqN72EPz/Jd8cU6KmDa87TMWH3Jl8PyVvWUS1J136EYh8aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c+FV2S6a; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNUI3596TVihJeyrkPvoaWz5p62LOrQgFbmjnN3aI6cXo9up8gRXXrpnuz99yUXk4v2S+eQxrSWRJkWe+El5dHCZ/bqzC0qMwYzO2m3Mt2fGGITRIsI/PNEYXPwMyn76IcoeHJEk+9CcLK1UstZPSifdAwN+cJArPrq1EwytgZq208CKg0wySUKpebTfmbKCQzhRTML/NW6r6+U5n8qAO3DShKjxgJALUAndq2VVOrxtroS3rJRLQ9Mrgle6zEKHvbkLd8jlfn6ts9YjtAlYUWMCw+jRem1isNl9snD2WsJbQSiIfXf/dws8cJEAWJjKVXABrkKDaU0jTCx5lDJs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oeLM/pQxx2ZFAAGgjwhneblncVK8a+S9uzTm5ZzbXs=;
 b=FYbVCfz6Z7UEt/yU/WqX5os9suar0z9ICqygI3gHDdb9/1E/1Jhbsd4gHI2RP9D621PzYypvn58nbI2+6/96nwPar4zqtqQnUniO3X2uveW1Nn7h49/F7qOyjwyV43Od/PtHXaOqq+WI01q6kPtYJjU9qCCzkrR5Xmd9x3nSWluTSF6X+FYhrjNTs6jk48dcgFbIZKeqXHF7Gmn+fR/YbHfRNSi4RssTLXGBLWt75gPIQBtWfVJuJ2RoetamKBcOfXHKNttGI42tU2a7a5RTFYqjC32h9IYwAiMLz2sG2FMoNgxX6r7kt3a6Cj1Tg42T0opNCxGzZYjMzODPC8vukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oeLM/pQxx2ZFAAGgjwhneblncVK8a+S9uzTm5ZzbXs=;
 b=c+FV2S6a9ZZuqgVM2HQf3E0kao3jjxyWbIky3ZBlrigyKY5SR4y1UHOKVsNoGhqI8X1/1gswRLSFO9GRCK3BdALQEqfVXgGCYX516Qjxxy/GGLcdMv0zfBq6BfCsSx2zJyjTfM5QGdIjPsHRh97LYKrnzq/gg9x1/w1eNxfNttw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 19:58:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 19:58:05 +0000
Message-ID: <74f3c189-f3d3-4dca-9357-d4bc8f98da08@amd.com>
Date: Mon, 10 Jun 2024 14:58:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: force min_input_signal to 0 on Framework AMD
 13/16
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Kieran Levin <ktl@framework.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>,
 Matt Hartley <matt.hartley@gmail.com>
References: <20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:806:6f::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e5263e-b5d5-4129-7831-08dc8987a474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjhTeFd4aGpua25vc3JyejFKVFpaZ0w3ZFB6a05kM01TVEhDTWFtUmJRQk1i?=
 =?utf-8?B?Z1Q2cUlZa1ZSb0hmeUdGNVR6dWZUeG5DMmZiMGxlbXdSendwUitubk9tT2V4?=
 =?utf-8?B?NHhGL1pCVmxKb2w1d3Zzc0hyNVdrMHBUTXkralQxQjYrQ0NVQ3Bmcm5iRmJj?=
 =?utf-8?B?NXlGOFZOMDZIYTZmNEJ4T1o2TVZiZkdjSDVXekU4WTNsK0tCVVd0K0I1czJw?=
 =?utf-8?B?OE1pRSt6bzBhY0R3aG84TzlSV2pXdzEyQklGZjdxdHF6YXVKaUR6cVpxN2oy?=
 =?utf-8?B?dk0yeU5Ta1FTMWg0MTRQQWZmYnBRZFdPRzdtL0tvV1dRdlo4UkU4MjBhT2Jv?=
 =?utf-8?B?UHVaVzN5bmQ0Tko5TnRhSEFXcFF3QzV4ZzVRejFEOE1XOEdnS3dFeWZGbHFx?=
 =?utf-8?B?d1F5Q2xYK3NnVktURUN3OSt4ODVmRVJGdER3bzdTckVsNGpMRjB1b3ZRdUda?=
 =?utf-8?B?VVY2MnlvNmJlQ00ydnFnWGp6MnBxZ3plRTNhZGdwbC9EWGFvRVcxdEdqOTFO?=
 =?utf-8?B?MkRGTWJLaDZIK1hXSHFsOHM5NE5sRzIrNHpvWENlVmpienNDQXVtYnFMV1FQ?=
 =?utf-8?B?bDEvRkt6S1FBb1pvUDFLSEFIV1FJMWNWWXZtMUtPK0YyeTJEZHJpNnFPWWxp?=
 =?utf-8?B?SnR0dUhwYUJIdnN3SlZsT0c4QWVFTmRFVHU1aUF4c2RZeFF5RnBud1BUa05x?=
 =?utf-8?B?bU1UcG16ZngybGFPeWdCOE5LNFFqakF3UGlyRExYSkFGWHVxMnJMM3Q0Q2FF?=
 =?utf-8?B?ZVE3enk3WStNMHRObWJlRzE0OVZkVEFOZ2FSNmtOakFvaTNRL082TEc2OG5S?=
 =?utf-8?B?SDRnK3hLNGUzUWE5bURDQnZMMXYxNHpISlNsVmZLakZVYkFSdG5VVEt6RVMx?=
 =?utf-8?B?ZitaS08zbkNZTFB0SGFnRklrckFTa2lPR0ZJSjBDcXhNbTM5T1NKeHk4Tjk5?=
 =?utf-8?B?TmpTQktRSU1LS1BTUEQrc0FERW1pZU5UeTR4YW41RGkvTW15cXhvOTJHemx3?=
 =?utf-8?B?T29YdjNkWWszRCtUNDlsZnh2Nk5BTHJRQ3NhaTBmZlNzL2RWMTd3aXVtRmN5?=
 =?utf-8?B?cm92QlBBOFdFa1REb0pQZnhIdHVJMGFGaXNnbE5ReVlmelM4SnRBVU9pN3pW?=
 =?utf-8?B?V1pHN05GeHZvMUlUR1lPNWhSdXZ1U2ViM1dEQU1xRWZxdzZvTU5HcjUybW5i?=
 =?utf-8?B?Q0FoUTJ4ck5TZk13djRsakV4aEtqa0RHSnhNZDNUTXRMSGNOQnB2cjVQWDhV?=
 =?utf-8?B?QnFIMWJVdlovSlVReFJEVllYdWZSTDlrNXJrMjVnOCtWdHpaRjJiYmROTUdx?=
 =?utf-8?B?SmVmZmxKTm9UeE16bHJidCtFS2JGVFZVNmFPYmt1WFVySDN1RWU5TVo3WmVt?=
 =?utf-8?B?K0F6VDJUN3VpVW1TdmpQVmlxTURaaHJ0SjdJejF2c1ZmUFpidFNSbVBzc3Zn?=
 =?utf-8?B?eU1lZWhYaEpMbUt2aEdid0J1Qmo2SElxY1VZS2xjenRwRGtWY2cvT2lsUlhn?=
 =?utf-8?B?c1dvdFZ2UHU2YmxCUm04RFZUaHBRbDhUTk9pTUJGcXdkWWJFN1JTTFIrOHJI?=
 =?utf-8?B?cjBjdTRoMDVPdk0yOXZlV0xqaGltRGYwd1BBZU55V09TdndDdWJXd2dESHVr?=
 =?utf-8?B?OTFKSVJXNlM3Sm9VcjRGRFZONXpvZmpETHprRk9DTTdvMGVPNHN4TEdGcDFU?=
 =?utf-8?Q?VPGSEKz6tl160qOZXDJB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFFRTjZlUWVwQmd5dFBQczU4bTVZRU9aa2Rwc1ZWRlE1dG4wbWhLWVZlQm9X?=
 =?utf-8?B?d094c2VBZk5GVVVncEw1eFJlQWI1ZnJSb1hocmxmZWx0L1ZxWjBhVkpSdmtv?=
 =?utf-8?B?UHhCaitodVc5TzBqSUlRUC95WlliNEY1SS9IRjNpd1U3TjRwV3NmOUNpUXFu?=
 =?utf-8?B?ZHBnR08vVm9tL0x6bzhjM2xsWW9TR0ZSaHVKYXRqditnR0M1eGErWjdPcUNp?=
 =?utf-8?B?SCtrejFGcFF4b2JrcXRtaWJRR3NKTS9uczJNdjU2UXRoMUw3UDZqSjJ6SVg3?=
 =?utf-8?B?ajY3bVdWZlM2N0JKWHBJSTN1N3k0WWVEU2Z6aTZhL3piUGFYWkF2dGRWbytu?=
 =?utf-8?B?NHFvb1BEUmJ0SWplYlNGT2I2OVNIOHNVR1dCZll3OVFnM0F5a1pyUk1KcnY1?=
 =?utf-8?B?Rlh5ZlE0aGU1aURtNERCZVM4S056ZlBwRzB3WnRHY01GTldvQ2tsdlZ3MjdD?=
 =?utf-8?B?MnBtaTVaQnJXcytpRDFPeC9lQ01pd0tpbGVEM3d1Vi9WUDJkbFNpUld1TXps?=
 =?utf-8?B?M01IMmFJQnIxem1vRit1T25ZRTZTclZjenhRdURyVmhFOU50ZkNEcldPdGVN?=
 =?utf-8?B?c1FmYlZiSHd5RjFQTWpnMjVNbzVQbURhZVVEN29lTSt6VXJ0YXFWUGV6YnRt?=
 =?utf-8?B?U2EzVjJPZXhxUmkxVHprM0dWc2NXYThpaFMwOXlrRFJMZEIxL09OcXVQKzhv?=
 =?utf-8?B?MjgzTjYxR29BMEVkZEUyKzQzQWl5UDRYU2V2Q0JSU05KM09nenUySVdTU1RW?=
 =?utf-8?B?eHVJRXJYemtmcnF6UlZxdEpvT1VidGxNS2ZQNElHTjlXejJrck5WU0hIMlpw?=
 =?utf-8?B?TjFSVnhCTWR5YnRHaUVHbzVzQWFYc2ZpSCs0UU5wK1VReWJPTi9uNGJJcGhr?=
 =?utf-8?B?SUtpQVgyNnpUOUtaRWR6VDU3MzV5bWRHZDFIT3UwaVgrdDJOdS9kMG4zQVp3?=
 =?utf-8?B?cEtOaXYzMEJZMXpNYUUwQjhOZXZpR3E5WWM5OXFYSHplREk0V1p6WFdnWDRI?=
 =?utf-8?B?YnUwbWJtVjl6dGkvd3d0bjBKRDlMNDUxYkFBVW91dlM1RlgyeEtOSXVCNlo4?=
 =?utf-8?B?Rlgrc05hbGtBMFRaSGZSQzVaM0d0VTBuVFlTcDh3dDZjbmZsZzJoNWJ3cVBZ?=
 =?utf-8?B?VjFHd3Y0dmE4RURyUWMyaVF2cjhuNTUxcGRCOThSUWc2Rk9RS25Db3VSUHly?=
 =?utf-8?B?Z01UM0VpM1pOcnVuWTdkSUhaRHRmUm5hL3VXU3FtUFBOOG5HRVZialMvTEZQ?=
 =?utf-8?B?YkxRZ2xhRCtFMkhHOHRuTDZWcEVKZWdaK3VHbXNRbFVYZ3RVS2hoWldobFNm?=
 =?utf-8?B?WHBFL0xyMkdXK0xTSFgyaXBEcmhWdGMyOXYrei82YTVhcGFvRjRsd2E0Y3dq?=
 =?utf-8?B?aVJyT0dvbmRIbkN0S3c2ZkVYeUNnYksvU0VKWmp4b3RlY1hPOGNQcVRJeVdH?=
 =?utf-8?B?R2paaGtkRVlFQnhyNElOYUg4VmFHcXJIWXZOOTR3SDBSd1hVa0FFWmlPbEpH?=
 =?utf-8?B?ZHQvTUQ5aW0xbnc1M1ZmcjN3RW1uc1g0UXRVT0xrK2ErV09HdkdZMkY0bUVX?=
 =?utf-8?B?OWt4S3h1bmcrV2lidWVOZDQ4L0JDbUE5VTZmY1RibW5aQjJ1WU5Wb1FiS0Ro?=
 =?utf-8?B?RGtWMUhiZytxZzJ4Q05kODhieWl2QWNaV09JNXNRbjR2cG5lZVFFaytrZStU?=
 =?utf-8?B?Yllyd1k0MnNvVUVDclNkKzN1QjltYkowK3RzcVVpdGJGSitVWGZxOWh1TUxR?=
 =?utf-8?B?M3cwQjJvM2dUbjlaaWVWeTBSVUYxbjlKcDY4NlorUW1CajJzby9vMkV6TWUy?=
 =?utf-8?B?VGc4UVNJL3g2OXlpYUpnc0NGZWZjQUw5c05iQnBCZHVsNncyQ0t2N2JtN0tR?=
 =?utf-8?B?TWx5dmREUlFZSU1QNjNPcW8wcWNBK2NNMjBEOXkvb0Q4ZXFlbGtpSUQvMmp4?=
 =?utf-8?B?TlhHTHhwaEtLbFJYK0hTaXZrblowUU9EdHlUMHZtU0JtQ0dOVkhsMUpRMHVo?=
 =?utf-8?B?b25HL3BLTUxielhOOEFjSWl3YXJ4MDRaWk8ydUI0NXI1R3l0WVp5OFViKzBs?=
 =?utf-8?B?cFBrSUtLQnFpNjY3Q0ZGVGNzYndmN3ZTT1hwUkdVR1Fac1VBZUdTN2VWck55?=
 =?utf-8?Q?u7mTo6jw4m3vbur2ilpFvxCo5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e5263e-b5d5-4129-7831-08dc8987a474
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 19:58:05.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaPd+PqsEnMmAzAGKd/ig13kO/NZJFN6KUgU/bLYXULXClLFt5zFEt4l42ryYQODJHZoUKgqTMTGedM/3BMlmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560

+Kieran

On 6/10/2024 14:26, Thomas Weißschuh wrote:
> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
> is "12". This leads to a fairly bright minimum display backlight.
> 
> Introduce a quirk to override "min_input_signal" to "0" which leads to a
> much lower minimum brightness, which is still readable even in daylight.
> 
> Tested on a Framework AMD 13 BIOS 3.05 and Framework AMD 16.
> 
> Link: https://community.frame.work/t/25711/9
> Link: https://community.frame.work/t/47036
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 35 ++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 7099ff9cf8c5..b481889f7491 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -25,6 +25,7 @@
>   #include <linux/pci.h>
>   #include <linux/acpi.h>
>   #include <linux/backlight.h>
> +#include <linux/dmi.h>
>   #include <linux/slab.h>
>   #include <linux/xarray.h>
>   #include <linux/power_supply.h>
> @@ -130,6 +131,35 @@ static struct amdgpu_acpi_priv {
>   	struct amdgpu_atcs atcs;
>   } amdgpu_acpi_priv;
>   
> +struct amdgpu_acpi_quirks {
> +	bool ignore_min_input_signal;
> +};
> +
> +static const struct dmi_system_id amdgpu_acpi_quirk_table[] = {
> +	{
> +		/* the Framework Laptop 13 (AMD Ryzen) and 16 (AMD Ryzen) */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "AMD Ryzen"),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Laptop"),
> +		},

Two problems I see:

1) This really "should" be fixed in the BIOS. I added Kieran to the 
thread for comments if that's viable.

2) IMO this is going to match too liberally across all potential 
Framework models.  If they introduce a refreshed motherboard for either 
product then the quirk would apply to both products when we don't know 
that such a deficiency would exist.

You can reference drivers/platform/x86/amd/pmc/pmc-quirks.c for what we 
used for a quirk that was matching against a single product and single 
BIOS.

But FWIW if that issue isn't fixed in the next BIOS I think we'll end up 
needing to tear out the BIOS string match and match just the platform.


> +		.driver_data = &(struct amdgpu_acpi_quirks) {
> +			.ignore_min_input_signal = true,
> +		},
> +	},
> +	{}
> +};
> +
> +static const struct amdgpu_acpi_quirks *amdgpu_acpi_get_quirks(void)
> +{
> +	const struct dmi_system_id *dmi_id;
> +
> +	dmi_id = dmi_first_match(amdgpu_acpi_quirk_table);
> +	if (!dmi_id)
> +		return NULL;
> +	return dmi_id->driver_data;
> +}
> +
>   /* Call the ATIF method
>    */
>   /**
> @@ -1388,6 +1418,7 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
>    */
>   void amdgpu_acpi_detect(void)
>   {
> +	const struct amdgpu_acpi_quirks *quirks = amdgpu_acpi_get_quirks();
>   	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
>   	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
>   	struct pci_dev *pdev = NULL;
> @@ -1429,6 +1460,10 @@ void amdgpu_acpi_detect(void)
>   					ret);
>   			atif->backlight_caps.caps_valid = false;
>   		}
> +		if (quirks && quirks->ignore_min_input_signal) {
> +			DRM_INFO("amdgpu_acpi quirk: min_input_signal=0\n");
> +			atif->backlight_caps.min_input_signal = 0;
> +		}
>   	} else {
>   		atif->backlight_caps.caps_valid = false;
>   	}
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
> 
> Best regards,



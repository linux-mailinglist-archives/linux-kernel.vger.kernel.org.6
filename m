Return-Path: <linux-kernel+bounces-358197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD8B997B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE881F24802
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3022A191478;
	Thu, 10 Oct 2024 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SnFcTLtG"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90018E75A;
	Thu, 10 Oct 2024 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531151; cv=fail; b=cp4q5TQeFs6z9+HwSGrpXUitYuQC5ajH8CzHbMD8TcRw5I0WSraFi4gm9SQiDVb+jUYPijF6/NLZPSD9Fa85t5iAJaB7s3BsZQb5UHhjo89rd0fxytX64yl+BhGFV9xiFYvwD1n+K17sla4HhT1xtXbXP9bU89TNEr/KtQpYhWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531151; c=relaxed/simple;
	bh=VJr/e2gRF2AuXY3EJInAURrNuQDGvqk4MYtWDcmhhzM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bQ4iYUirK2nl8iZZQGHPymbjvfU+eeffnPhrpaEXw+axpGn8GT9Wi4A6e+AFkToaRTzEDSv9GRkU7WTDFj+TspYdWawYT+tPxoUOJgZkgZdjYEgLN3/mK2+031xMxpNS6pvUaPv4g/hwrIgTYtyQYn+HIQ8+PlkQ8C/4nuGk744=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SnFcTLtG; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWdbz1LU/6aKDrJXIpbbfW8EwtajMr2UZuEZqd2k4jrnNolEejnQnKfj1dprQ3kXj259kacrQBuE7UHehl1XfRU/ZG7sc+H/vhd/3mLZDDNSu2MtdumhRxe74r3Iazut37N9v75sSi6Fh86BXxmr/G+SdxTdHFu/PCC3zsSOEc1O0xEksHjiS9rxmVP8rsT9xCzrGBwXYjpe5ZXqQisBUMh1ZXvVxu+5mr0gh9CCkKBR+ZAKLMX9YIkYtg5qKicjlLO+GbUifXcY8NPsWN0njhcuajLH9QArYsBm5dr0edpz3D7DbxiqAuvYMaO2eetGf0gnWDBPp9dMYEgudCP56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/myZm8006aJqOClHeeQCUyogKBkFL/kYxzHQpYQyjmM=;
 b=voLMvTXpNuSlYx1sSm/AQNT5sMvyhWMyTF1+F8B/+uw9aofOQRNS60rfKy2zC25O7a0D0jERRrZqgVLZOPa7KOTjgWLpFu55TAEEBAMHf06gVpNKlLZ/2yokagD/f2j0Bxmd5d21ttyv8hqv+HaHHXlq0rZD6ie1nwkIiiQL6ROQYRe5tOJmt6Bz1lmWXquYgS64lAK0yr0Swz2zMPuB1P0yO1t1Jf2uF8srsExdd+P+7/JdGZi4+lFbd/d8yGLtOm/EncuJjKeZgxmdkAjQsOXvWzXVIjVALQPUb5dwXmPAFPaIFo9AqJG59BaDpUIpSGBNGRWFjL6c2A0Fqk06cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/myZm8006aJqOClHeeQCUyogKBkFL/kYxzHQpYQyjmM=;
 b=SnFcTLtGdjTha0ALu+zHbpcHB2hP9pZWkR3GiL2HuxIqwRvlF4wQ/4FQOgD1vsExHVCM4tzlOGrGTzcMAihRPqeyfceBBB1/Ihtwsd2DX6Q0vf7CmRveAK6KcvDwITr69bedDL9nqr05bl8WGVRMTMKmtnp0Tf9gT+USKihhrBQGnXoH2KswTU8yl+WUnvDuMDDuG6jvfz1wXCle0Bap/0D/z87JDDEM6O/uVoRIsYwoDLYI5qKN6dtAJrqjtpVoH5ydT5G0EQbcwa9ZMOOsxjoIXQGTH8/7E/3m/6Cpm+2OmzvJ2JRTc7e2+u3RDIRQ/ncG9gU+iTJk1xdD8zJlCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.25; Thu, 10 Oct
 2024 03:32:26 +0000
Received: from SN7PR12MB7912.namprd12.prod.outlook.com
 ([fe80::3311:d713:f0c8:ec53]) by SN7PR12MB7912.namprd12.prod.outlook.com
 ([fe80::3311:d713:f0c8:ec53%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 03:32:25 +0000
Message-ID: <b0ac19a5-1d93-41a5-beaa-279939e8ebde@nvidia.com>
Date: Thu, 10 Oct 2024 11:32:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ALSA: hda/conexant - Fix audio routing for HP EliteOne
 1000 G2
To: Takashi Iwai <tiwai@suse.de>, Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 bo liu <bo.liu@senarytech.com>
References: <20241009134248.662175-1-kovalev@altlinux.org>
 <87h69ltmgn.wl-tiwai@suse.de>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <87h69ltmgn.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0096.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::36) To SN7PR12MB7912.namprd12.prod.outlook.com
 (2603:10b6:806:341::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7912:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 6837410c-3d21-4d9e-be46-08dce8dc28f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUlvZnlnN2hMamkzWmsvZlR3NUJuYnZla3FNaHhFODZTTDdjNXV0N2EyS0M1?=
 =?utf-8?B?VnUwNmc3ZFpzQVZvc0hBbk9rRjlMV0ZKMEY0aThVV25HcDRXVFJablZLRmM5?=
 =?utf-8?B?QkRQVUZtNkhUejlyT3phQitvK2t4cnVvV3F0VW9iY1NtM3RaZEpFRWlvdHZW?=
 =?utf-8?B?WC9kNnRuYzJsSTRmeVpsTm82d1hHQSsxVnVTMzRuTnExZkZXNm9Va3BzZy82?=
 =?utf-8?B?OEtPVDd2S2pqLzVoc2hVMVhNVUM0a1RlWk5ZR2dINEUrRG4vaHV5Vk9XQVlO?=
 =?utf-8?B?N2F6SXlwRFNLa2JkaGpyN2tNM2U1NmRnbDdLalFtMDF4ZEIxWEVDSVlPRVZy?=
 =?utf-8?B?eEpiRk1OWEVKK0h3YnNpNWN2a2RhVTBhTElSbTdGZVVWTkQ1Y2o3Yk9hS2wz?=
 =?utf-8?B?aDQvWGNocWxyeEROYmVRdUVZbXQ5c3RvWEFLaFYzcXQxSzZXN3BsSndCNENI?=
 =?utf-8?B?aUdvUUpZU0poLzJPRUNjNFR6SW9RU2dDY2ZPZFNvYjc2UFRXV29jd3JVL1VH?=
 =?utf-8?B?MGlNTTdRZXlnQUJIR1pMNTNlK2hFQ1RmVXdxKytlSTYrU1VFNmo1VDJyaW9u?=
 =?utf-8?B?S1FRWkpXSjBKcXhqdXpycjdpRTRzZWthS21ld3I3YncxYkZuZzFnQ0xVbmpK?=
 =?utf-8?B?SUw4UGhmTG9SQnFvdE56ZzF2bHZGckI2UnJIWlBZM1Foby91WlZVWTZDd05T?=
 =?utf-8?B?SkJ4cUlkeTFCYXBJNHBwdkwwaDlXRmFhRkUwUkhNaTJ6T0tOeWdBQ0NhbGJ0?=
 =?utf-8?B?cU94NVlwSDBsV0M1VlRvOWhUODN0aW9Nb2tYdmQ1Tkt3TmlBajBVQlkrU0Nn?=
 =?utf-8?B?bFE3dlhhMkxrRHlhNnZTOXAyY1dqb0JPUmsvQmFNMkVPUDNKMElTK0kydUp0?=
 =?utf-8?B?Ulh3QUJVbGJ0Ti85V0hsVERuOWtqTGFYdXJ2RTh3bHhhbTQzVFNURkJzeUli?=
 =?utf-8?B?cjI3V2VBYTFGSmFtM1dGOG5uVmowNVVJTC9vRUJMYzd5eWVPSUdBd292OEFt?=
 =?utf-8?B?cTFDRTEwN21ZbTFuSVJWVllFVWtXeEYxNHVmYlU0cmVUQ3JtL2xZb3dTcDkw?=
 =?utf-8?B?S3M5SnNGVVpOSWdPRm0wakJVSVY3aUlkd05OS25uQkRaY3N0ZysyRks3dEVw?=
 =?utf-8?B?U01MQkQzL1Y2SmUxVmFId3lyNEgzb3IzemgrMzVYaXdBOUk0eVMzbkRzSTRx?=
 =?utf-8?B?aFRSdzdidXBCRTZHREFoVk5FOTZqMUxlN3ppbjR1NVNaUi8rRkViK3pDZzlQ?=
 =?utf-8?B?L1R0QXlBVWRGRDNSaWJuYThhbmdzZDBrYjFDeitjdWNReFdtcWRiUkl3dDU3?=
 =?utf-8?B?MHdoNWFOQ3FhV2cyMloxTWVBazBqaFhMMUErRklJWmJEOTd3K1RRSDhvV3VZ?=
 =?utf-8?B?cUcrT0k2Y2RQM1dPRlVLMWZPQTBBNzU3b2MwK25WWUxNcGE0ak9YTFFLZkxi?=
 =?utf-8?B?QS9Vb2R1Q2xISjI5cFB0ZlFoSWl4a29zbW9BSEdENzcrbmNVbk5xL1g4K29B?=
 =?utf-8?B?OHBxc0RRV2pUZTdGWi9Ob2lsajhZV1BudktDTDM0S2tpZUdmeVUzUlVaRURu?=
 =?utf-8?B?MHRjV0lIUkVVRTVFdFlucGlSdUxpVVVpR01CeCtxczJUU0JaQS9tdXJMSWNZ?=
 =?utf-8?B?MC9td3FsM2F4d01tQjFDNjEzbitDcWUwK0xURW1GN1ZoTG9pa05PMDc4UU8y?=
 =?utf-8?B?N1pVVU4xajJ6eVZMNFY2QUNsRGg3d29DVmNScURXSTB2UURmZWJIN1F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7912.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFNiWVh6Y01xTktWWmdRM0tFc3NVZjhYUHJnSUM5RW9Va1lDd2JvT05mQmY0?=
 =?utf-8?B?S1dCQjFWODQvNnFYL0ZETXpzNlEyUUZFSUtxVDlZOUVFcTZHVSs2ZkhTU2Fy?=
 =?utf-8?B?L1dpN3ErK0R3WHlNZXJaK1dVUTFiRmNTSHZDN3pnWDIzSCtmejU4cnZ5bkt0?=
 =?utf-8?B?QXJaVzJaY3RXMmdzWnVTc0lScWJRaGRNbDBhRzhOb3V5SW1nMWNKcW9ZMWJ5?=
 =?utf-8?B?aUFzOHZVaHRVcGFxLzhPUkpPQWFQVExjNnU2ZW1acWV4bVlibzRhaHgvV2Vr?=
 =?utf-8?B?TncyU20rcERuQ3R5dTRRRTBraDcrU21kbGxObFBMUGVxRU9mWFArWG54clVV?=
 =?utf-8?B?dkhJbDRoSUplZUxtRndRbjFMOHBuUHd1VHMvRmthdGs3dnpCTDJrSlBabWJr?=
 =?utf-8?B?ck81ZHcrZ3JzSVRoZE8xbE5uNXhac0hTdUV4bkkzL1FBNVhsOTlwaThJZHVy?=
 =?utf-8?B?QjRadldjWHZGWnBhcDlNcUk2aXp4Z2wxWkQrV1VrMFAvVUdldlNTdVRGTDJa?=
 =?utf-8?B?RFBodzhrVUFFL1N3THFhQTVRSDQ0VjluZVo4UDVtMHJ2UzVrWDNWdXE4cWJu?=
 =?utf-8?B?WDlYbW1oQy9KMXJHaHIzMGdhTDhxMUVBK0ZSMWYrNGNDd3lNWUtFQ040UGRB?=
 =?utf-8?B?VFhCMVc1QTJMQ0sydlJlOWxWaTVHT3JXTk5Za21NMXVqT2NjVzVIUFNKNGdx?=
 =?utf-8?B?cUpXMWtxVFlCU2d6QXp6dWltSW55QU4wRjRib2YxdnBmR2J1ZWZsRVRuYlRE?=
 =?utf-8?B?dHk2elhNVE4zaXFKSThtWHV0amdiSGovNXNNVnNTUFpOWWVIODZrRktUY0R2?=
 =?utf-8?B?NHR0NEliSXZVZ0QwUFF0MHhITHByUll6YnE1S1NxemNUQ3QrVHBxUFYvbWc0?=
 =?utf-8?B?ZTlEa3c2aXI4NkhjMkRteENMYXJXR1R6T3VXcVl5bG1HeTRSYnRBbzJXZlkw?=
 =?utf-8?B?aStNSXRQSlZJMWhmK3haMGtjMEYxUHFOZ2x0aEdoRnFSSXNSL090VlhXYXZ4?=
 =?utf-8?B?WndablNxOGZZQUxMT09CMFRHKy9WSGpsZVI2eGRUdGNpcHZTVzRsZEFreU9p?=
 =?utf-8?B?QjZlWGsvWWdpbUsxYy9BY2IyV1BTZE9JMjdReG9GdlNHSDlVSzAraVEvWHli?=
 =?utf-8?B?R0VGLzFrTEUxcE5PRDhFMWJJMGhCQldSMjJRdUJJSTQ1L0w4WmdoZ1EwU3JB?=
 =?utf-8?B?RW9wWEpsNVRtYVVrSjJDelN4MlJsaTY2Q2hiT2pDNExtL1ZTNUhpNFZ2VnFB?=
 =?utf-8?B?cWRPYjJiMkIrRys4K2VJNSthREZqSVVMT2NtL2hyaWJOUnA5Uk5JcDBoLzZt?=
 =?utf-8?B?WVFhSGV3S0tSNEF2cnRuckRoT2pUZ2tYcVdmSkVXaVZ3TURaaWFmTnJkUFBY?=
 =?utf-8?B?MnBwMGN3c1dvNENuKzRleUFpcmNkR2ZSQmVxamwzWHFMOVNOR0xVSkJDZ242?=
 =?utf-8?B?WUg3bERraW04cDFBd25kVlpZSXVXRnpmWVRSWkRFUUR2MU5yeGFGdGJiVUpL?=
 =?utf-8?B?ZG9Wb0c5dktHdFBUY0VhNXpyMVBiUVFoL3EwOTBsZU10TE5PTXVCcUI0M0Z1?=
 =?utf-8?B?QUF5SUJsSkt0TDJXSEFZK1ZIdjlVRVdaWVJSZGxaRVJrRkRXeDQ2VXlVbHhV?=
 =?utf-8?B?NDFSa3RrbGpwWnhrUklFS09SeVM5QkJObjIrQ1VpOVgzekdLYTFXbzkrSnBx?=
 =?utf-8?B?VE11alRYVDNiZUduc2lCMkN6V0lTZ0pzVG4zMjdSczNtaXhHbjZnN3V2S0pE?=
 =?utf-8?B?bzkzSlMyckpwWHNpd1YrSmFrTE95RlN3M01iOStQQjcrdS8zMWhqc0lab3g3?=
 =?utf-8?B?dnRXdnI3M1l5NHIyZXR5NFowZHJkdGk5MlM3SjEvdjd4Mmg5R3lRU0JaK3dY?=
 =?utf-8?B?YnZPN25GVVN3Z1h0amhsUHZodkdvTE1BYWJiU1E4RWRjTlgveWFLdWUzR0pi?=
 =?utf-8?B?azd0QlNMckFHSEErRG5zMGdvdVhpL3RZRldCajZJUXBOTEoxT25odzUwTzNn?=
 =?utf-8?B?ZUduYW43VWxKZG92UHJOSkNZVStmQURFbkJSYm8wa3g0NVozZTl3WS9LSktv?=
 =?utf-8?B?aCtEVXhTNnhGZjd0djhuRWN4cmNia2djbW01YWFJaktDTlVLNEVKeWZKVDlK?=
 =?utf-8?Q?b0Dn9AYCdFqAsDFaSK/RpknbY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6837410c-3d21-4d9e-be46-08dce8dc28f6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7912.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 03:32:25.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNH3KC856HfXykZgqkl9efmiLF1c8Byv5pBeuzK3SoG2FEWj1nVbRuzmKEOZPLasxADmsYkkli1/ljOM1CLumw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288


On 2024/10/9 9:50 PM, Takashi Iwai wrote:
> On Wed, 09 Oct 2024 15:42:48 +0200,
> Vasiliy Kovalev wrote:
>>
>> There is a problem with simultaneous audio output to headphones and
>> speakers, and when headphones are turned off, the speakers also turn
>> off and do not turn them on.
>>
>> However, it was found that if you boot linux immediately after windows,
>> there are no such problems. When comparing alsa-info, the only difference
>> is the different configuration of Node 0x1d:
>>
>> working conf. (windows): Pin-ctls: 0x80: HP
>> not working     (linux): Pin-ctls: 0xc0: OUT HP
>>
>> This patch disable the AC_PINCTL_OUT_EN bit of Node 0x1d and fixes the
>> described problem.
>>
>> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> Thanks, applied now.

Though this is already applied, is it possible to see if the issue also 
happens on S4?

Linux doesn't put PCI devices like HDA to D3 during shutdown and reboot 
while Windows does, that might be the reason boot Linux after Windows 
can workaround the issue.

Linux does put PCI devices to D3 for hibernate (S4), so we can use it as 
an experiment.

Kai-Heng

> 
> 
> Takashi



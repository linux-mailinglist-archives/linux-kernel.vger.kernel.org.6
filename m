Return-Path: <linux-kernel+bounces-236108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7391DD8B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266DF282395
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B503F13C9A4;
	Mon,  1 Jul 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="Ms/kM9Qp"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48661376E7;
	Mon,  1 Jul 2024 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832124; cv=fail; b=Ah5mkaA2wjR0HDAsnWQss71MG0AmjmF1RhN2UjwFaOr3KUJrz9eUNkLhGfdg8yxlgks+PerPjmKB4dEudyeOj2urQY5Eq2s2/bhytY/ti9gavHtgQSWqmxtEBiDeWHpfvU2BuJSK7ufPow418HSUdYcFZ8NHLWN1ukysU5brSs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832124; c=relaxed/simple;
	bh=ru9VPKGKg5n1lr3yc+WJPLInBbPV+vQBOfZcMIamI98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B+1w4MZNSlclYOzBH1OfbJmejB0+E/53vKL0aHj3tY/K1EYIQbA/dpGplN2epqvKa0t8UQagNSzCWv9DYEkofVYlLDe9+W7+990IkcMKvM39bEdR/vfirO6eJVYAe68rg4lBbjk5y42Dz9wzIE37+eE+042tN239FNXeSgYHEx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=Ms/kM9Qp; arc=fail smtp.client-ip=40.107.22.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gT0mHCYJcZEvIimg714F7L6Y/hUcWi1P0Wj4R0YLX+Sk0rjjucnaEhYI9ATkmBbOlDPC9nbbnX92WpI5FfZ1+B/XjSJuTATM04vunk+Tav9aZrf6JDx3Uca6+R5gkVaKH0V4ktfWfsLY45EWOtj1FmCU4w9u3D6eL91mLFANBkamiD51bomnk6B+vyUWpaHOXyX3fweoJ5L/q7XNrSWwL97ZzARgYkAGMVWM9r39xuaMOeevK/x2zzJYDuFC7mS3+v/NHgF0vN7L3DPMgpQM6Up5W2jrCSpnfbtQBbiihVjGbaL7hYbbHtmWochCpmo8K/sc2sQHb+2lsEHiVEejIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZSVQ+fZL7o16SVchVfnkyNEFsRTX4U/KpXmEFoBu70=;
 b=lZQRySnfi7jpDYhDyy64CeOMus8oC1xS4qMfXZuKNPsP9MkqcFZuXBrraKak8rVhOMAL9dDbPQ2OztE7d2Cdk/g0iX7KaFVxsX0FtuosrSe/Jqn8JvBfZ/YWSzv4SUsoRkTtGXd1t6Kv4flG/pJHEpIyvLbbAbd4IIAIZn4eyO4GipiJNPiRmlpDfA4rtHkMkRsrFpBxojTb+RR2wTiJ4hB9N++j7tIgep9KRYvnTX2fys4N8PRn2XP5nyCJdWSy36S2my3QcARBdY77N45d0nJQd1dPEQotv44D0HEn8xC+k25ylOp3vXNlz9qMPGwdjakNsFk8g2hWQhTvy4NEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZSVQ+fZL7o16SVchVfnkyNEFsRTX4U/KpXmEFoBu70=;
 b=Ms/kM9QppeAw1P3V1amnSGDOVgTLbJDiJXD0JmME4dzjZUvkhH/Pazg0LGbZKP2tRLOv6jIF+M4ooyzKwBAy7oH2MDqMwc/5LcQvU16BPbDo/fsaoZl/MNOOQxIxvzzmgbeghy7LOgOSDZ8IH/91QYQd2iCmFVKo35WmPvQ+SRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB8073.eurprd04.prod.outlook.com (2603:10a6:10:24d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:08:38 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 11:08:38 +0000
Message-ID: <05e2dfa6-ea35-4600-94a3-6b182635434f@cherry.de>
Date: Mon, 1 Jul 2024 13:08:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] hwmon: (amc6821) Rename fan1_div to fan1_pulses
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-4-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-4-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0046.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::15) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: f38715f0-7eb6-4b7e-f5e1-08dc99be28a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVpxN0VybkhDQnNnOTNPdHBnMW5BYmk2NDVva1BJZnJDcVM5UmZDUnRXT1M1?=
 =?utf-8?B?SU9NS1lhUmxFelMvcXpDZ0NENVc5amEyNFplSmpROThLRTgwZ2lIVHY1VjE2?=
 =?utf-8?B?Zi9DSUoyOG8wQ2hLbndLelZCWm1KL1l5emNLK2dmWWZNRkZ5SHVIdnAvMzI0?=
 =?utf-8?B?ZVVqQTJyV09sWVMzcFJLWkFLdmx3M3M2dndzZnVWR0VZQXlyak9Cb1B1UkJi?=
 =?utf-8?B?UUtzc1M0OXZFbjlhZmpiTlpxMmFFNG54VE56ejM1dExaTE1rVXhZSzN2V0pT?=
 =?utf-8?B?N3hwOFY4UkN3T1ZUaHhCVUZmZEtINitkVWppK0Jpdng5dVBtYnBwU2ZmT1JI?=
 =?utf-8?B?WXd1bFJMblQ5enpQVFM3RnJrdCtPYXhmSW14TmpwQWduZ2RYTXRLSmRLOEw5?=
 =?utf-8?B?TkhGeG5odmx1ZjE1Z2s4dU9TVVR3ME5MeDVUb3paTmdEcVpkcDgyb1VzRlhR?=
 =?utf-8?B?d3NWL1E1R293SG4wMVlMNkh3VjQyS0pFVWMxbFBGOWdQa3gvZ21XR3JSaFdD?=
 =?utf-8?B?ZkFBMEdWbzZrSG0xQXdNcTJ1SWlZUlBJSGw5b2lTcEtZOE9Oc1hzNGtFTENo?=
 =?utf-8?B?ZFF5S1p5b01iMEtldGEvbUxXdFZEWWc3a1JpZFc1VkJrRnFwYzB2NXNuUXBj?=
 =?utf-8?B?bzYyaWhBU09PSFlkc2ZXSFg2MzI1d3B3K3FqTWhHMnpkY3FNK1dtLzJXZFBu?=
 =?utf-8?B?UW1mdCt3eWZtUXlSNDNPZFlKYW8vS1R0dUczZzY4TWhTdTFwRkZ6TS92QWVX?=
 =?utf-8?B?cndWV3c3OC9TelF4ZlcydzB4Z1BlMXptMGRMTldpM2svSEFkUFBFMDk4Rk9T?=
 =?utf-8?B?YWlENS90OGt1MVpTWWdBZWJkUzFpUWY0aEROY2RGdy84VW5nb1VtWStkUDJW?=
 =?utf-8?B?VjhkQnZlR1VGT1JhcVJ1c3AwUzBzK0t3czcvWUsvK0RTeDNCT2VzV2t5YXgx?=
 =?utf-8?B?bU5WQjZiQStsVjdFNlN5TVFxNzRpK2VVMWIvRFY1ZVRrRk80S1FZU0FMcDVD?=
 =?utf-8?B?MzdOQjhZUGQ0LzFGUVpvZVdRRmY1MVU2b1BkVk5rRDhZS2hSM00xK2FZWEwv?=
 =?utf-8?B?MmJpNE1mckpYWDY1QjE4M1RoV0tMRlplRHJZbEFFaXNjMXU3N085S1dWRHlR?=
 =?utf-8?B?YkFNM1hXNnRvc2xWekRheW1GVm80UHpyYWNPMDBXNzdWUU5kVTMveU95RFJM?=
 =?utf-8?B?Q3Z3bzRPb0dlam9IZ2RBaTQwVWpDV1FiRHdvWjJMUWFWaXIzMWc5NkQ4UDRo?=
 =?utf-8?B?djkzSTZqZ1dNcUExUHA3cVdBeGhnRFVqeHRLWGRYRzI3alo3N2Y5MFN5dVdO?=
 =?utf-8?B?Z0ZmQkFLcjlGdWZhQi9uNklISm9nNzVod0ZsQ0xwUzBjVUFFMysydHlwbFlF?=
 =?utf-8?B?QzUvMzF0REpZWGdxYzk3SUZwZWF6Tis1bWtkblNoUDArdUhVVHBzRExxUXBp?=
 =?utf-8?B?SjRvQjRZWENHMVRzYmRSK2JIcWpBbE8ycmlpV2ZjaVNwSlQ1bjhkSmZsdE1U?=
 =?utf-8?B?R2FRZmR1QUlvdW4wRlIyOGIzUDRSVktTR2VvSkxGTW1NbWR3RnFZcXRnVU1m?=
 =?utf-8?B?SnA4WEFQYlU3ZjhuTUd1QmJYVjl2OGFWME5QclpyV2dvZmNMbGlLRlV0Q0Na?=
 =?utf-8?B?YXoyUDZZQXNjR3NQTHQ3aFY0Y3RFYzg1WElrbS9VVHMxeUV1ZlMrM05QeHI5?=
 =?utf-8?B?OGlwLzZ4YUxkRllPTTE4UitzN0ZldlhMaEJmYVRtRGNRdUMxZ1kxV1RiNnRQ?=
 =?utf-8?B?WVN3eVRvZHR3cDBrcE0xWUdqWHdmSTU5eEtxcDBteVd5bkNIWmovd2VwMndV?=
 =?utf-8?B?UXVTQjcrWjlUMGNQSmdEdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1pHOUJTbjQzdnVRVW11dHZlV2t5NVdwSDRzSVJ0TFN3Vjk3Z3ZUdFF1UjRB?=
 =?utf-8?B?Qi9RZlZEeHhLYjVGZ2VVRm9jcnI3cklYNmpnNXZHU1V4aXFLYnBIcnRFZlU2?=
 =?utf-8?B?WGJIRlFFbDZoT0w3K1RjY3Q1dDF3VWJ4elhNYjZUNlYxK3NSczRERGdreTVR?=
 =?utf-8?B?VWV1cXZoU3lGVzRwS0tFQUkwOU9WdXVwYjNSY3Q1TEJ0dzhOdzJiSmRXdW5P?=
 =?utf-8?B?NWFNS2VqN25SVHoydFo4WXo4NFZpUUE1cER3TlNDTlFZQ0d3Q3llalBzWnpl?=
 =?utf-8?B?MkdmdkdEb0pIaTNPRmhJSXJHTmh1a0gvViszVjhmbGRjdTk5aWhsdmVsN3lQ?=
 =?utf-8?B?YjgwZlRrYjRqUXlBRXlwVWxVUEN2eCtydm84VmtvNzFCczd3bFNaUDUxQXM3?=
 =?utf-8?B?N0g4dXRoaDN3ZFEraFRwemtzZHFvZWF2VWdUUmhBV0RNbFRjWGdZSVl1Rjgw?=
 =?utf-8?B?QTExMUpCVVlVRHVDZWh2OTBVK2dDeWpicTlEbnVoN2xyRWFBaUpoSTB6UFda?=
 =?utf-8?B?N2lWRUl5LzlPWDNwdEI5aWoxanQzb0k2QnZmR3ZuVVAwNER3NXUzcVBvTlZQ?=
 =?utf-8?B?WVhMUkUxdEFvM3ppYzB5N29KSy96TkFFQ1FZTHdkTXMvbmhZY3ZpbFBiRmsr?=
 =?utf-8?B?ZFZNclk0NVpVU25rd1I0MWF4V0t2NHo2OVVVekJ5R0pSTXlFdlIrWlpEWkxC?=
 =?utf-8?B?eWxOR3BPeW1aSmNIZzJMTGpLeDl5cVR5czJ1R3FrQjBDcGQ5dWVZVG80NUl2?=
 =?utf-8?B?ZWpMTjZWK3Zra1hEb1ZLUEF2T1B5RmhWU2ExZHFRalZRYlIzdkRuT2lmRTh6?=
 =?utf-8?B?clZsYWxaWDhFTUlLOE8xWklVYWlOaW5FV0tMaEtpeS92L2xsMW13T1RhV1Zv?=
 =?utf-8?B?TzF0MFF3NXdNVTV4bjhjcjJkM0dEcTJscW1BbTVtVENTUzI1aFByK2FsaE9v?=
 =?utf-8?B?a2JTVGlNZDdpWVVoVGRvUjRXekJmVlF0YXlSemtrY1ZNUGxVTDZUYVI5a21h?=
 =?utf-8?B?cTZTRFVpUmFuZWZMTDAydWZGVWJIQUMrSy9STUVsZDdFWXY1TVQ1YmwwR0RY?=
 =?utf-8?B?bjJtSit2dkp5Rld6Y2Y0b09xN1dwcHpOd2tXRnAyQjJGaitJQmRRMmJ6bEZo?=
 =?utf-8?B?cFQzclZlMDdKeXJFUWsvdSs1Z0JNeWFDMTE1anRtTEp0d0gweDZrb3hTRVRI?=
 =?utf-8?B?ZFdOc2hScDFkSktQaTBZTFdVZGlCTWNSbHZNNWRDanhGNUxzYW5PMzNNN1Fq?=
 =?utf-8?B?dWVUTld3Rm55KzJQUElXWDV3SWxvZXltbFFuVi8vYlYrNnFvZnZMallEK2Nz?=
 =?utf-8?B?WFBJc2NabTNvY2xQZEVjNEcvQmlSQUVobW52eDJtTGFtbzdDUmtIeURKSFVQ?=
 =?utf-8?B?cTQrNHZjUnNLZURQQktSelNwakQwbzkwOGVsZ3B6Y1ZjaE5jK2dqQ1BDZ1hJ?=
 =?utf-8?B?WFF6QXorV2IzVUNwUVNtdi9SdXdPbDYvZ2Mvc05PRmlaV3lHTlRqRVBFT0JT?=
 =?utf-8?B?MkI4QXJ3MXhROXpSaWdMdEN4OGtkMXlQenVrSXo0KzcrYzJoZlZzQnh3d2gy?=
 =?utf-8?B?R043YUpGaGJ6ZHUwcG9oY00xRzFGWG1DRG1BUjBQekEwcm5OcWpMU1h5dVlj?=
 =?utf-8?B?R3VWV3phTXY1UlRBTmpvck5PZE1tWU9rWGhBODR0UjVRUUgwUDluK0ZYQW0z?=
 =?utf-8?B?bStkYUdMSHZ0TU81L1Ewbkd6dWdhUGREY3Zrd1hZU0NQTTd6UlBMV1lzYlJy?=
 =?utf-8?B?N0I5cmtUOTN0S3d0Wmg1Y1Y3dTFyZmwzSWU4WFlxY2tIeEErYXBQZjA3U0Ni?=
 =?utf-8?B?SWhSVlIvTVhJUnViYlI2SlYxeTZTNWlWWm4vWURxSVpPa0V3cEJxaFlvOFJj?=
 =?utf-8?B?YXJwSlJLUm5NRERYUVcwTWozTlllRzh4WFFxTlVrOVJlZWEvMm9zdlVnTDhB?=
 =?utf-8?B?K1pJMThZam12d1FjMUx3UUtsRlVQTVpneUNIVG1tSjVFTjlTcEdVTTJva3ZR?=
 =?utf-8?B?QjdmTTl0WTBpMC9rUWhkYmxTVVNSZk5KcWhwZmFaTTZyVWk3dXZ4VHR0R1Nm?=
 =?utf-8?B?dW5PUnRkRTdvK3FLeloweXVEWVlOdUc2L1hMeVlSVWVjLzNvRG96eVdSSVFy?=
 =?utf-8?B?L01CRU5KZERGQk9WTlVlclZRU09FZEE1aDduMm1PUC9WZ0dlOWtMK3lwVTZl?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f38715f0-7eb6-4b7e-f5e1-08dc99be28a7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 11:08:38.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ougDskg1q4qKuVP8tHAuHtvJxj8UiOQ3uNbbB03GlBadQGFqsvpvQJwuqUDLRrEJPfk9+3IlD5xUZmCYJm0bMU1KFOO0v8DUEuxgbh42GT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8073

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> The chip does not have a fan divisor. What it does have is a configuration
> to set either 2 or 4 pulses per fan rotation. Rename the attribute to
> reflect its use. Update documentation accordingly.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Good catch!

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin


Return-Path: <linux-kernel+bounces-513926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE41BA3505F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A069A16C9D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62E266B52;
	Thu, 13 Feb 2025 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="XnmkQtRe"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023090.outbound.protection.outlook.com [40.107.201.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015A266B67
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481305; cv=fail; b=Tds36bVVeDVm8N+DT9kwMIEnMRcjVI5RuYQSmasOJ8lvCstaBOSwCJaqkpkLBHQFlJWJ/lKxY+VoTfQ0xCblSubB+jb0ce3lceWYSo4KM/VWETLrH3XefvqabFaNJvjIcp0Hl/KY8dYwiqjXHb1FEGDpAezfGCj+JkafSZlSmdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481305; c=relaxed/simple;
	bh=Pg0hhkqttsHaef6N9JqIK8PZJ293IRgokfTlRAwQINQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sy+XFu8fO5EF9IftkLbbT1otz8Aoyq7nmIv2nAy6RHODXnXS8MBwCTu/j1YHlZ8qmYjDglzmNihHqy1qzZuiA4/iV5RYAH+yMfWyeo6+hOuZuX7DizZ5UNPk/gu0G7bka5pkoteDsnolsdr9tLntDjmWTS1AZJT646jqrPBrQMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=XnmkQtRe; arc=fail smtp.client-ip=40.107.201.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOHALwdkaNgO4SkHDfIzBBsiBfmsvcHwSSCU+88suomo4HJH0iR15smU0e+S4ZR5uFiKkGKHZN3bHnxp2PtoVRWH6QxN9AOUhOibvZpQy0u8BRUitWYLcI9Aqi+jAz0AH/4drzw8KjsazCxaFwNBoYdEJkq1A3eF6nHK9RD4+5rmacdtkKezMqovZcTStL5oaX1Xc4BgxEWEyLGNXTT9R6igJqBkOPgCkp+jtyJvtX/V2M0UbGyxdPjAyvn9h9htb3QBGCUZRclAc5M+CZZ9Ui5DlXe+XLoTskpmRcrFyVN5J5rMj2v4KKa0qw2e40tiOF+zAD9tL4WEM34HmqpXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4BVqdyc7EiSZoPa2OqFXJQVmZ6vRJDcXcdBhUrvJj4=;
 b=yUh4Nd44WVNsMz8qOS26UfwDix5xo3nEV8A8DaR5PsbG1RN6U4GvXVxFcZ4xtIwEcFVlBR0p+xs9Zlj0VSKqZyrw/e3XEXv6Y0X0ZKCBJtZ4ewpXSWRgUxLmw6Akdiz7CKeLR+o7hSu8KnxsS4i2GvzUQ7DXzJaF4RRPm7e0tzKul0gixiKaUUxxX33JrpJIE4V4wBq9xpMGb8e/wg1qGtqOgX0K3PHRH1L1G7FELQoJjBtv59+00olgpi2wXFhtXVY8I7gt/eI+H+NX7siim8ZaS9wSL3hUZ6kAv+FB3hey3yVjGZgx/pq/C2LJz3ryVPur3l7valdaa6jr/cCARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4BVqdyc7EiSZoPa2OqFXJQVmZ6vRJDcXcdBhUrvJj4=;
 b=XnmkQtRetrZupXJGqb+Op4DwvIjaj8ZeMWAZ7wqwG1SHOJNyn2Ztmt7cdpRMWh0VBy45pMcuLd27fFFOvEHgIr8w+CnD5Mkhc1X7kULmR4nN7asdZCDvHhJYurGX2gD1R+9hquhQYd3zjPgDFJmlNAjZqvrgAVFEhIxxPK4shaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6310.prod.exchangelabs.com (2603:10b6:510:9::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.8; Thu, 13 Feb 2025 21:14:58 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%6]) with mapi id 15.20.8466.004; Thu, 13 Feb 2025
 21:14:58 +0000
Message-ID: <0c644070-e4be-43c1-acb3-30cd030e20e1@os.amperecomputing.com>
Date: Thu, 13 Feb 2025 13:14:55 -0800
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [v2 PATCH 1/2] arm64: cpufeature: detect FEAT_BBM level 2
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250103011822.1257189-1-yang@os.amperecomputing.com>
 <20250103011822.1257189-2-yang@os.amperecomputing.com>
 <eef5fba9-da21-4131-a8a3-ae9a735869b1@arm.com>
Content-Language: en-US
In-Reply-To: <eef5fba9-da21-4131-a8a3-ae9a735869b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0084.namprd15.prod.outlook.com
 (2603:10b6:930:18::12) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: ac08494f-ae74-4447-305b-08dd4c737878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUhTQ3A3eEFmemZ2ZVpBS3dXZmNORnBsYzh0dXV5NWsrRG9SUlA2Q0s0WVh4?=
 =?utf-8?B?eTJaWlh4VWE3a3o0TG9SWTZUWkV4Uzl3KzFLdUM0M080ek1wd2pDYTI2c2FL?=
 =?utf-8?B?NFNDb3dBam5aTzRuTnN0QVl4L0t0Y0RaenB5a21MVGJpZzNGcWxEQkdMdU1j?=
 =?utf-8?B?U2hIcTVTRVBKRE45TzZIbU5KMWpTYnkvejF2MlQ2NENpUVJzaVVHaDd4eWVi?=
 =?utf-8?B?QTZRQXJZenhNN1Y4QWFscFE1RzVJR3p3YStudjlQMGZXYmJTb1pTMHl1NEVh?=
 =?utf-8?B?aVU3c0RmVW1kenRNM2VLaThteFNIY3EyR2FQREFmLzByMDIwbUR0MytKYzV5?=
 =?utf-8?B?aE9tUnFsamljVG5MWkRwWjROd2xkMUIweWVOV3JSNWJPR1JQNXErNlFPVE9h?=
 =?utf-8?B?Z0ZqNDFYRFd0dkl5M1RndkxwZ1FuQk92TWlkUDFjRnpSQmpXWDJXVzJTVkMv?=
 =?utf-8?B?amZWMVVFVVZZa0gwNFBDTjNUbC83ME14ODNUdTlzc0k5Ukd0VGEyWHFoaGd0?=
 =?utf-8?B?cjNHNGE1Q3JNY01iSDNIcjB6NS85cCtveDA5Q0Jqck16RGtqdUFxK0VSVEdo?=
 =?utf-8?B?Q1prVXVyeGhGRGZNRHJ3RjJ0UnBFb2pMa1RUSG8rR3BKTkxtS0diTVJVdkJM?=
 =?utf-8?B?cXJwWTlSa2Z5ZjMwc3ZFR3hUN1huQzQ1M0UzRWxYcjJWc2VNdWJjcEVCOEZp?=
 =?utf-8?B?am41eEt3U0JlQ1k2NTJPSFE1RTFEKzk3UVFYL0o4cjRmOG5mVFE2NDdPYlAx?=
 =?utf-8?B?RmZCSDRCc2loQjU4WTZFVmtlSTFiUTV6MDdXRnBNZzVPZHZLTmpMYWhYNk1F?=
 =?utf-8?B?M1NmbmNGMjVoVVpqdkNDWHVEVEl0eGU2czJ5QUhYNHBNOEU2NWJFalo5Qmxq?=
 =?utf-8?B?cTB1bkVTM0JxVkxmaDJwNHovZHZobGxUa1ZIZHlKQVkvNVFya3Zsak5MUDNv?=
 =?utf-8?B?dUVEYXpJT3pGWWpZOXEyckg2QjFDamZwUHJmMEVENHRSZE1QWVJURWpkWEpa?=
 =?utf-8?B?UVdGY1JUV3ZNbHE2QU5GM1FJWjc4VTFiN2xrM0NBNTdjUmdRTHMyWlZoZVhh?=
 =?utf-8?B?cWh1dTVRL1hpemxBU1N4V20xdXFiR0x5c1JNNFNYTTNieGxhL0xRZnBqVkp2?=
 =?utf-8?B?QmdkZVIyMzhiOSt4K1E5TjVycjJrbzFDVlNJeWFKRnZyaGFKZk01T3RTNWJS?=
 =?utf-8?B?dmNTalBsZDl5eGRMaFA2ZHIyNlIwS0M4QW1YcHp5dUkvYWs3RnBpZVQ0Vm9p?=
 =?utf-8?B?TDQvd3JyRFVRbnNKM3V1S3NjcWZZY1hBQkM0L1ZaVTBsQlZFUWNiZ1dFWmdD?=
 =?utf-8?B?c2VrdEowSGFNZ21YVFBOZmZSMytaTzd2bkFlVjNRM3Nsczh5TkVLSFdpNTNS?=
 =?utf-8?B?aERrQ01PR05FeFY5WmduZGZDV0NBTVhpbWhWVXlWeHF6MlU0RWYxMXpoWjU5?=
 =?utf-8?B?YncrdHVSZEV5elBFZjk0eEl2MGRtVFAzV3ovbmpTd1h0SG1jSDJicGs3NU1j?=
 =?utf-8?B?SnhXME1YOHJNWmJ0ZU91R24yQ05sZnM2VnREUnpXdVNJNG9VUU5GSkdJRTNh?=
 =?utf-8?B?QjhOeUlLYUhWSWo3V3pTdFMyd2tuam45UURrSGx2aXZlK0haWWhjbUtjd1VM?=
 =?utf-8?B?cnhCRDVhc0JsYnF1TmlZT3M1QTliTUQ2NVZNekpuU2JkcHdyenNaMmtkSkdY?=
 =?utf-8?B?UjMyc0d6WUtUY0RhL1dnc29jRTFSZEFzWVgrZ3R2VFA0MGNDL1J3RnBnbFIr?=
 =?utf-8?B?WnFiOGE1M05BNSsvRzY5V1pEb0RUYldpUEF5SldVblVnOGxEd21yK3lYZ0Yx?=
 =?utf-8?B?eFFTdlBCYnRlajFXOGZ3R0J1L29mR3VSNW5EU2pnWHFKaks0Z01Gb2NnTm95?=
 =?utf-8?Q?JZ82i1f7T0ZQ1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFAycU80Q2Qwd01lT3c2dXB2TUFJZlNQWHFXSkNwQ0FiYkh1MkxKcURGakxw?=
 =?utf-8?B?enBkdFhITThxUk9DVElKeVoxbzVDVVlSa3FTdTlUV00xL3hFb1JKU3VINXVz?=
 =?utf-8?B?QWlkZUVoTDh3MVVkTEg4UUZWUlFUN3dHT1BwVTQwRmIzWUdHQWNNVzdaS2pC?=
 =?utf-8?B?dVVCaUJBZFFiQWhBNEMzQVhDVk82V0R6Y3pwSlYzQTdkRXhMbzFFOVdXaDBM?=
 =?utf-8?B?bDI0dVowaXd4SjFLSjBablVUSXg4UGZiQStQOHp0cnhaU09yODladnF1NTRi?=
 =?utf-8?B?RlRMLytzWCtBNXMyVlFEQlVUMEptT3RTNDRJZzh6K3o0TU5aa2lrTys3YzY1?=
 =?utf-8?B?aDlZekdVMTdhR1JyeUo3aUJ3ZlpCb1NqUyttWjJYcUtKUU8vV1hMOFlsUS9a?=
 =?utf-8?B?dW5uQVdsK29iNW15c2FvcTR0eVpaRUtmNnk5TmF3T3lXVTZNcVdwNjJqRmdL?=
 =?utf-8?B?OTFUVUJaTjlWc2R4djVvME5BdEJqQ09RVk8reUh6Szl0NE5DRGJYcHFoeWFP?=
 =?utf-8?B?emYrUElCb01Hd3V3SjlBNEJGMU9SVmp0OG95Wjd4YnljQStHOFlCQ2NsQXhJ?=
 =?utf-8?B?VTJXcG13NW5SSk1EU0MrU2tBQksxM1MwK05pdisrWTllcFF4VHp2NXdjY2dG?=
 =?utf-8?B?Vlo0dUVPdmRvQXhwRlBENW5VbFF2QVVVQVFBN0ZjMGlzVGJHb01JdWw2ZEJh?=
 =?utf-8?B?NGtkeTlUSG05TGpWeWxjWW9ab3Z0bXJkSzNnVWZYU3Rjc2wzWmJnVXRldmQw?=
 =?utf-8?B?Y1dHMlVHTHA5ZlU1cmRybkwzaXBCYmxGZGpZL05NbzN5SlV2T2FucUZKWEQ2?=
 =?utf-8?B?SmlRWG9BVTF6ekhDOEFYenlrV1hEeG9Ud2lqMWgzanNCZjZ5M3lMNElUbVNk?=
 =?utf-8?B?MERBMFphaU9ubTdFcUh5eFRCZVVRN2J4THVMUWFWcG8vOE1pSUJXS0lHRnI2?=
 =?utf-8?B?WkEzb3NoUnpicHIvSW9vcEFaZFhuQVhXYmNjVUJRNU43NktucUc3V21aZFoz?=
 =?utf-8?B?V0RMUjAxM3ljbE5JSURpRDQxZ01pS2hKUmJVaGJwTHVIUFdCT2hsVldRd2pB?=
 =?utf-8?B?KzRiOHhVMjRSTTc4R3o2dkUvblhYd21ZQTA1dzg4b1lBeDZyNE8xenR4aGx3?=
 =?utf-8?B?V3BDV0o2b01YcEN6cWk5UmRHMTdBTDdJVWkzN1RHMDB5VEkzYlN2N3NHVkdZ?=
 =?utf-8?B?NDZmeW51NkJlb2NNQldPaUlkY0F1WW9oMHdMWGZ4akRMUloyUDkyRndIQXdO?=
 =?utf-8?B?SDZVY2FiL0lrcHFLd05QMENtZjducElIZkZGOXRoeEswb0kyTEhQQnR3d0NQ?=
 =?utf-8?B?RE1JYVd4akx1N1BqTloyQXg1TytNS3R1NG9WUzZpYU93c0RBRGtKLzZxeXNi?=
 =?utf-8?B?cDZFY0NXbjh4dkx1N3c0TlRKVDl0WE9CVnc2RkN6bzRBWVNRYWNCSGtoUjZq?=
 =?utf-8?B?NkszYzdabThoNTg0dSs5cmQ0M2ljbjhNRWt5Y0JuQUNiL3hOTDBITnZ5T2hG?=
 =?utf-8?B?ejlKMk1EcS9MYXNUbHAzM0dpL2R1ZjRTb0N6Z3NHenRidW42cDJoY05SSEty?=
 =?utf-8?B?QWRBOXROVTZJR0t5aXJoTTVVYmVkanBtWXRjVzNKazVRZE5tT3ZvZXBXTnZU?=
 =?utf-8?B?YzdKczdkd1FNVTkxakNQS1NMTDZJTXJJY0JSdjlWc2xJRWJIcHArRnNUK05T?=
 =?utf-8?B?MFBIRXQwTlQ4NzlrSXpvVmRHemxPbC9pQlA5a3pCMmdoMFpIQS9wbTZPT29k?=
 =?utf-8?B?UkxoRWlDZ1lpamhxVTg0U200ZnNYeVFhWGRTWkRWVG5kdWErYmprZEhGV1Bm?=
 =?utf-8?B?ZjltNW1OM3liMi9xd0l5d2FVN1RqRnlqcEdUOHpzZUdCQkZWdFV2RGJUY3dV?=
 =?utf-8?B?cjJXTTdsOHowSDV4cHJVT1J3VnlRSk9HYzZBWksrYndRNjdCYWNLanVVRk1K?=
 =?utf-8?B?aGVtZzFoZnN0emRqYXcyd0VvNGJZYjlMczhuOHZNR0xxa0lxbEZsZElnQTJE?=
 =?utf-8?B?VTZUelMwM0daVzQ3VXZnS1dCd3R1WDRoNUtxS3VqUUN0amtQdnQrOC84aEN2?=
 =?utf-8?B?SjlXR2Y4bmJ3TjlqR1Z1RlBHVkV2ekh4N3EwM3o3RkF0Y1QzUlJqTWVqSUow?=
 =?utf-8?B?d1g4a1AvWHl5eHNXWUdOL0ZuWVFEdTNuZEM0M3Qyc3RvSlA3TTl0VjJCcklS?=
 =?utf-8?Q?6+kAUH2oeZZpe8Mk99NZJE8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac08494f-ae74-4447-305b-08dd4c737878
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 21:14:58.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzZjY8UvOhBEvTuRvcKePw4CKkDFiRI5nJ7Mw25d0QSjL/VSJC+YfiTiJjj7qAj+icT0SV58+PKT++c3Mnd/4gEv/EbuB6IHoYYdVJonftQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6310




On 2/11/25 3:55 AM, Ryan Roberts wrote:

Hi Ryan,

Thanks for taking time to review the patches.

> On 03/01/2025 01:17, Yang Shi wrote:
>> FEAT_BBM level 2 allow changing block size of a translation with relaxed
>> TLB flushing.  But it may incur TLB conflict abort.  We can handle the
>> abort in kernel, however it is hard to guarantee the recuesive TLB
> nit: recuesive -> recursive ?

Yes, it is a typo. Will fix in the next version.

>> conflct will never happen in the handling itself.
>>
>> Some implementations can handle TLB conflict gracefully without fault
>> handler in kernel so FEAT_BBM level 2 can be enabled on those
>> implementations safely.
>>
>> Look up MIDR to filter out those CPUs.  AmpereOne is one of them.
>>
>> Suggested-by: Will Deacon<will@kernel.org>
>> Signed-off-by: Yang Shi<yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h | 19 +++++++++++++++++++
>>   arch/arm64/kernel/cpufeature.c      | 11 +++++++++++
>>   arch/arm64/tools/cpucaps            |  1 +
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 8b4e5a3cd24c..33ca9db42741 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -866,6 +866,25 @@ static __always_inline bool system_supports_mpam_hcr(void)
>>   	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>>   }
>>   
>> +static inline bool system_supports_bbmlv2(void)
> nit: Arm language internally is starting to refer to FEAT_BBML1 / FEAT_BBML2 and
> I believe this will soon make it's way to the Arm ARM. So probably better to
> refer to bbml2 rather than bbmlv2 throughout.

Sure.

>> +{
>> +	return cpus_have_final_boot_cap(ARM64_HAS_BBMLV2);
>> +}
>> +
>> +static inline bool bbmlv2_available(void)
> This function has no need to be in the header. system_supports_bbmlv2() is what
> users should use. Suggest moving to has_bbmlv2() in cpufeature.c.

bbmlv2_available() will be called by map_mem() in patch 2, but map_mem() 
is called before CPU feature is finalized. I saw you suggest collapse 
the page table in the below comment, if it works we don't need this 
function anymore. But I have more questions about that.

>> +{
>> +	static const struct midr_range support_bbmlv2[] = {
>> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
>> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>> +		{}
>> +	};
>> +
>> +	if (is_midr_in_range_list(read_cpuid_id(), support_bbmlv2))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>   int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>>   bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>>   
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 6ce71f444ed8..a60d5fa04828 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1889,6 +1889,11 @@ static bool has_lpa2(const struct arm64_cpu_capabilities *entry, int scope)
>>   }
>>   #endif
>>   
>> +static bool has_bbmlv2(const struct arm64_cpu_capabilities *entry, int scope)
>> +{
>> +	return bbmlv2_available();
>> +}
>> +
>>   #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>   #define KPTI_NG_TEMP_VA		(-(1UL << PMD_SHIFT))
>>   
>> @@ -2990,6 +2995,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, GCS, IMP)
>>   	},
>>   #endif
>> +	{
>> +		.desc = "BBM Level 2",
>> +		.capability = ARM64_HAS_BBMLV2,
>> +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
> I'm wondering if this will potentially lead to problems for assymetric
> collections of CPUs (e.g. big.LITTLE)? I can imagine that little CPUs might not
> support BBML2. In this case if you boot on a big CPU that does have BBML2, you
> will require the feature and refuse to online the secondary little CPUs.

Yes. This is the behavior of this patch.

> Perhaps this really needs to be a system feature, where it is only enabled if
> all CPUs in the system support it? I'm guessing that will make painting the
> linear map harder; I guess you will need to initially set it up with PTE
> mappings, then repaint as block mappings if BBML2 is determined to be supported
> if that's not already what you are doing.

Actually I thought about this before I posted the RFC patches to 
upstream. There are a couple of options, but I can't tell which one is 
the preferred and whether it is really that important to handle 
asymmetric systems gracefully or not, so I did it in the simplest way: 
just fail online the conflict cores. I also noticed some features behave 
similarly, for example, MPAM. And this RFC patch is mainly aimed to get 
some feedback from the community about whether it is worth it and the 
direction is right or not. So I tried to make it as simple as possible 
(for example, I didn't add CONT_PTE support in patch 2 either).

If I understand correctly, system feature needs to read the "sanitized" 
register value per the comment in cpufeature.c, but we read MIDR here. 
So it actually just uses the current CPU's (likely boot CPU) MIDR if it 
is s system feature, right? If we really want to handle such asymmetric 
systems gracefully, we need:
     - read all cores' MIDR then determine whether BBML2 should be 
advertised or not
     - update a flag or bitmap to tell us whether it is asymmetric or not
     - take actions based on the flag or bitmap (i.e. collapse page 
table or do nothing)

But system feature is not checked on the secondary cores. The 
check_local_cpu_capabilities() called by secondary_start_kernel() just 
checks SCOPE_LOCAL_CPU features if I read the code correctly. So local 
cpu feature may be better? The local cpu feature maintains a cpumask, it 
can tell us whether BBML2 is asymmetric or not.

In addition I'm also thinking about whether collapse is the best way or 
not. We should be able to have large block mapping in the first place if 
the boot CPU has BBML2, then split the page table if it is asymmetric. 
I'm supposed we need to stop machine anyway even though we do collapse. 
The split need to be called on the boot CPU. We already have split 
logic, we can reuse it anyway (maybe need some minor tweak to fit). It 
sounds simpler than collapse. And the asymmetric systems may be not that 
many in real world? I know there are a lot of big.LITTLE SoCs in the 
wild, but those big cores may typically not support BBML2. If so we can 
save boot up time for the most cases.

The other concern is about cpu hotplug. For example, if all the booting 
cores have BBML2, but the hot plugged cores don't, shall we split the 
page table when the cores are hot added, and collapse the page table 
when the cores are hot removed?

I'm not sure whether the extra logic to support asymmetric systems is 
worth it or not. Maybe we should start from the symmetric systems, then 
add more graceful handle to asymmetric systems later if it turns out to 
be a real problem? And unfortunately I don't have the appropriate 
hardware to test the code. Maybe you or someone else from ARM has the 
right hardware?

Thanks,
Yang

> Thanks,
> Ryan
>
>> +		.matches = has_bbmlv2,
>> +	},
>>   	{},
>>   };
>>   
>> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>> index eb17f59e543c..287bdede53f5 100644
>> --- a/arch/arm64/tools/cpucaps
>> +++ b/arch/arm64/tools/cpucaps
>> @@ -14,6 +14,7 @@ HAS_ADDRESS_AUTH_ARCH_QARMA5
>>   HAS_ADDRESS_AUTH_IMP_DEF
>>   HAS_AMU_EXTN
>>   HAS_ARMv8_4_TTL
>> +HAS_BBMLV2
>>   HAS_CACHE_DIC
>>   HAS_CACHE_IDC
>>   HAS_CNP



Return-Path: <linux-kernel+bounces-348146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130DC98E348
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509E1284F34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087B413CFA6;
	Wed,  2 Oct 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mVws8Y4w"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020102.outbound.protection.outlook.com [52.101.193.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D9433A9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895881; cv=fail; b=UwFZqzJ1PJplSf21Tc5MVahYCjib6YNYfRNkVvuLigBEBFobgAEL0k9X/Q+V0KxWgmopemuvgl8IFVmtP/f8MnoCgb3nGBgUTL2gOkZ+ObYdZ8ngjYRYsAbr3I27vb3R9Sl+9qnOuJeHu02/4czSH5TYZ2NDlwbzI1f0FxwC1Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895881; c=relaxed/simple;
	bh=gtMtDCGph2I593uXiZikwvXtHcxFOqiINT2NqjKfQRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lnanSWyoyrYvCjlpfLY8YHK5a4Yr2YcyFkbGSwcbW9dXVGuhevuwpw+RQJPVywSGm783Jh7va6BgfK77rTvyqpH3FBG9MTQQ2KJJA6Rl7aEU4jXGt6ouI6IgYC1Te8bhLkdmn+UrfSl20+AC3iini9rHDyg+ADsc4tRJFVUIJzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mVws8Y4w; arc=fail smtp.client-ip=52.101.193.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oajkvppe6l8kpi/9VdQZByEpXLSv+e/B89JWuzKBvZZwcJPldx73YV/RMJWrWeH92L1sFgk3rf4ZGG6nfldwf1s8463BERXomXiPwhINqKMXJtCG+xdcDEFS4ScRm4uPa8QYTBy+hrePxR2thp1euVIIwssIyrbICXMbDGdoEGckx9Xo8+z+AG5gpJ0mgLhzH6q1hKygYvNozlVtHbOwmJTrCd7RKnap64i4tDq2Mdty2RaKnbLEGzfAUh5jvp987f5ukI74ifnC9LWXbXVgduB0EOdrmk+N8ponasEBt6aW51GWM65u7L2ooiYumgbPkYtoTfDMINmd/ZUs4ZXVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLhO7oDELWV9QHKBA+6Elitf1N2wkWLHlUIdasw8YMo=;
 b=ahR4IVDe1zMUku6SWS0O0vGoE8mZq9gcvv3XDRbdjobSaCzcfV+8kxRFxm+zR4y3sXFGxWW7G5QTz7UmjFQs7fpqeoGQcZ+87WAAUfkBjAFIabzjqccN7mLcs6hnFuRazI6mZINlBErJJz+wJRLAg5f4n7PzBdzlqTjPxhMvcjmXRCGeYRPdcnIMmaMyT7ya5BDfVq2U2c7zdZgaP7nYaqeB8wdDcthOG8ANEHywg1zx0o0s559jlDtab6XZHIm4HESe2amUg6sTSSDbJFOFXVVKWpWRlpWjsWA9X4ru+6OCalDfTuSgPAoy4mK2nKzHz0sa+oxFQch6pcVj3zTIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLhO7oDELWV9QHKBA+6Elitf1N2wkWLHlUIdasw8YMo=;
 b=mVws8Y4wB5Qde1YhES/cpjJI8Jl1TtgK+ZeMojtffcmN9c7c0YIqdz3rf2foSlFCI0f7oG/gdOxSxH2ytvaX2wueCyUEJCVF3j/N2n6OuaUHotmW51XCmMfCX9oVxkV7Dv2VXTmXNwiGGlcnhiAvPUUCGXYAzMvoXk7FB+zINdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB7232.prod.exchangelabs.com (2603:10b6:806:1e7::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Wed, 2 Oct 2024 19:04:36 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Wed, 2 Oct 2024
 19:04:36 +0000
Message-ID: <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
Date: Wed, 2 Oct 2024 12:04:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@ziepe.ca, james.morse@arm.com, will@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a4b48f-91c4-4191-3fc6-08dce3150eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V213WHJqNmtOWWtOSHdXL0ZrbEowbWFBOHAzbEFtenRvS3A3L0ZWUGtHUTF0?=
 =?utf-8?B?ZlpURlV6UUZsQUtZUjRFTXRJbGN3UmdnQjlmQm9lb090U3Qxa0dyem5sVUM2?=
 =?utf-8?B?QVgwTDl5K0RFUVowZDcrRHdjd2ZyenNZVTVQbU1hRktMZmNPU1lPUXBWMk5T?=
 =?utf-8?B?UDQ2MVBJS0hNZS9XRzlPYzdvZUpCRlRuOSt3dVlkdmY1a2NDNUh5VkNpaGty?=
 =?utf-8?B?VHVtaUl0STNZSzh4UnYxOEtPVVBRMEJGK2JicllGQ1R5VHhvaEMxaU5KaWlB?=
 =?utf-8?B?U201Tnp4VW8ycUFwd0dEU2o2M0RvSHBZbytOaktnQyt0elRtVWJYOFlVM1Rm?=
 =?utf-8?B?MHJ2SjlkZ25acjdiK3FKYlk0VHV1cEZHWjRaak1BOVJ6ZVNESTlEMFJ1UUpj?=
 =?utf-8?B?L1htQXVsR2ZGZmVSdEJ1WGRwK1UxM1RvV1A3ZUtHVk5VQ09wSml0RWVjK0JN?=
 =?utf-8?B?d2plYUd5RWY4OEgzbDRkRjF5OGR6ZTdUR2hOcXUvZVEwd2N2MzVWUkVNd0lF?=
 =?utf-8?B?NFhSeDdnV0FPVHJTU215dFQ1cE9iYWhxVFcwbjRkYlNOUHZvYmZsbVNMQm92?=
 =?utf-8?B?QnlVRXo4Q212SGNPZXdGSG1LRUF4ejg2d29CdHlFSVBKY2lPM0RCQkk3bmdn?=
 =?utf-8?B?cEQ0UlpPbWlNN0kxUDQ3bHNrYU83WXljTDRWKy9XK0Z3eENwMXlzN21IRFNI?=
 =?utf-8?B?OGdkSjg4U1dpaDYxa01scTdsUnRGSjhCTzJJekdZWTg2TVZncVFaSndzaVFu?=
 =?utf-8?B?SitsdVlLVHhyS2NMTWRHSVVVcFdGT0FHOGJGZmpqaFp2Njh6eDZ4UWdoSVg1?=
 =?utf-8?B?dDQrTXZmUjhUN3pxZENlaEI4K3pDSklxTGhNcURFRHZzdkVxOHFoaWpxNDlp?=
 =?utf-8?B?RDMvVEQxWjA3ZFplTGpUWkJrY1JnSjExVGkzSmJ4dSt6NjBUUGR1WUFCSCtr?=
 =?utf-8?B?WlVsL0VUbk9OWFZJQm1TVGE2UFViaUFSalRJYzdpTGV5b1VmelpJNlFUTzlI?=
 =?utf-8?B?WFo1bkEyeEd3S2g3S1Z2b3FhTWNjYURwUUJyL2I1WkFISjNhY1BWKzlmV09r?=
 =?utf-8?B?bXNIb2YxYTArdEVRMHRSMFNhQ3VwOHdxeGpvMzJpdmR6cHR6d1pTOThjVmll?=
 =?utf-8?B?Q1FCZ2EyK0xzcDU4S3hQU2NYQ0dtN3B2ZW9KeUhxeDJRaHI4WDhaL2Q1MFdJ?=
 =?utf-8?B?Lzk0dmFpMFFlNnFxNWw1MVhLMEdiQTFIdjBQa0s3RkVtODd6SE42QVpSdk1q?=
 =?utf-8?B?QzJZV2lvWVJSY3dldXZkL0lTUCs0SGpETnVIdHhYalhpdXo0ekVkTHJpdFVo?=
 =?utf-8?B?dUMyU0JWbHpIcSt4QmxmNk1vUFVlKzFHUzZPM3drdjcxeVREUlpyNW9HY3Vs?=
 =?utf-8?B?eE5YQ2J5ZDZhTnhHNng5TGR4K1Q3ODlUTW0yanM0cWppVG5CS2tEazlpWm9Y?=
 =?utf-8?B?OEcxWjIzN2tDK29tOG1UQ0pHcEh3L2RicEoySXF4ekhDMjJYWnJRODFDT0Z5?=
 =?utf-8?B?cDEyVUptZEtTaHVXSTBDT3NaeXhFZDV0bXB0OUNPcktSSE5vZjEzbkIrSThP?=
 =?utf-8?B?aTV1YWVLWmlqTjNwOGE0RXRsVXprZThJWkFmd3U4RTU1QkNHYmJzcjZaUytS?=
 =?utf-8?B?eGdxSTgrZ0FJZklNMGZlek5XYVFrRlpUN055WnVVRjM1M3pySmN4K1pyY1ZY?=
 =?utf-8?B?bHpYbWcybFEyUTV6OWw0dzhvMFc1S2dnNVhtUmozYVNhZWxBemkwdTRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXh1elB3SGxUR01BaGNLdHAyZEVRV21ENlAyRW5lRHVyNnltNWZPTlNpbkFX?=
 =?utf-8?B?U0FNNFZEaUdwNW1CT1pRQ0Y1SnhFT3RnNnhjcDlQaXp3RmdmK2hPWTRFZnV6?=
 =?utf-8?B?amVDUFlaNlgrU1hyVDArY0pVd1l4Mk1IMkpWRTZNVEVpVmNhWkhRdG9TbzBU?=
 =?utf-8?B?Tk1JWWFQNEMzaDNvZzhrc2lzN3U3TThsa0NJbFNYWEJoWHI1UDIwN2FpSjNG?=
 =?utf-8?B?SDhHczhpSHlmRFFjM2hFd0tEQThhY2doeVNhcXRleGFTV0xSUHkwVHNrTjlR?=
 =?utf-8?B?d1FjcmVRbjJoRDFtWDVLRUtBWDVBUWt1RmtCY1ZzYzZ3cExDeDVzWmM5NXU4?=
 =?utf-8?B?YXpqSDMxeVNPY3gwMnU4Z0pzbmJ1dUR1NllzK1V2RUgwUVVXWFNra0xIUEND?=
 =?utf-8?B?bUVNMWx2cm5BM0lZV3hvR1p5T3ZwUk10cHB5SFhGa2lzWVAxYWEwUktWcDN2?=
 =?utf-8?B?dE9wM2FHMHFSY2dGbkNwUzVpK1lMYzJzblgzR05XRGtaTWhtaWlRMWZBUmJL?=
 =?utf-8?B?VThTRXErc09LMEJveFBQd1dLYUhqUU5mNUhqSTlEZ3huUFIwV1EvaXdmUm5H?=
 =?utf-8?B?cHlUS3BEbEJ1MGxLd0RRZ3Y1T0EvYnFqY3M4YTEzcTdFbUhmb210M3NDbzd0?=
 =?utf-8?B?WCthaURWYnRyYS8yZS92TmZpK3BJTGdFWlZzOTZXaWo0UVB4d0h4SHlzUzRR?=
 =?utf-8?B?Qk5pUXF3UDl6Tmp2MTlSY3dsQmF3dzUxa3Y4M3FMbkVueW5MNGxyYnFoRWdq?=
 =?utf-8?B?UE9EV2R0NThpUWxyZGxIYzlXMTVaUFZtaC9yYXNkazM2VUI3RVMwY3VzcVhq?=
 =?utf-8?B?amtxZEYyM2tSWlBhZkh3SU5HcXhxMVlBSXI4UDBISUdLSVNscUM0ZG53dG5X?=
 =?utf-8?B?K2I4NW5ZMk1PSVNuMEVIRDQvSjM5SmJpcVVheGRWblpZVkQ5aHNVNmh0ZXMv?=
 =?utf-8?B?ZmwzUGtEM3dBTDZwRmx5SzZsWmFZZEhvMUFnOHJTSHRiWXVDb3VXMFM1aFh0?=
 =?utf-8?B?VmlGTmRpWDZhNDIxeW80NC9WMGZhZFBzR1ZpTjJWS0djSmpPOEZiVEhCU0lm?=
 =?utf-8?B?WHE3bDd5Sko3TDlTY25jZnBMb0d2YzYzcmVHc3RFb0VDaXhvRFdYVFpZYVpM?=
 =?utf-8?B?cHR2RUw4bkxKcWRqR1E0YXVqYURQRVNyR1NxSVZ6ZURGUjB4OWFQL0RFWmN4?=
 =?utf-8?B?RTNhQUx5UzM3VVpxa2liekpBTUlnLzYxcjQzRitudkx0Y1VRWU5MczBodHdj?=
 =?utf-8?B?UFR1NlNOcXh0OUFPcnpCL010M1FHd3R0OStnalFVV0huNFVFSWJYbUdzcjR5?=
 =?utf-8?B?aVJFbDB0aU83V0pjRWlUVnJMRkcycmZkSnR2QUZwazlKaEpMa2NiVkZVN3lG?=
 =?utf-8?B?TlBlL0NVNWhLSkJVMXRDbnNsOHpIa29KWktpWHNZNHdQQ24vMHgxb2hlcnJQ?=
 =?utf-8?B?R2Vlck5sNHdobjRXaDh1cjVaMEtVN3pJeWYyd0VnQXErSzVuS0UwWUNLYUlJ?=
 =?utf-8?B?ZjZIMDNGTFhHa3pUUTJaUkMxQ083MkxFdmJlbkhVWVk2Q1liWVU4N1hpU0w3?=
 =?utf-8?B?OHlIUmo5YWNoZ3N6aHpKY1JIdmh3QWpaaFFJNVg2aVAvM1lQbkFEOGlmMGV1?=
 =?utf-8?B?S0VGNExYUEtaMUNVZXRVY0dlS2ZqSWdMdGNhM0l5WThRaXdLY1p3NFc4RmZ1?=
 =?utf-8?B?WHllRTFPVE40TjlaOXh2Qmo4WFhZZVd6ZU43cmJIMWtuOVFyMlB3YXI0aHUy?=
 =?utf-8?B?aUVzOUQ0a0M1S1hyYWZGd1dHdjBnaHRnNEg1RzJ0b0ROZ0UxYWUzNVE4dXJF?=
 =?utf-8?B?L3QyQUhhbXlkUUZNbEdCQ01xZFBzTElPQmp6M2dvNmZtNVp2NDMwTVk3dVRG?=
 =?utf-8?B?SnJSaHN5SWdMUUMydlZiQis4U056RkpDSnV5dldtMGxsRjBILzRzKzVnM0Ji?=
 =?utf-8?B?emlHUmMyeEgwT2RyWGh2SUdvNFlKY2V5eU5qQWV1K3hYTTFpNm9GRnpaWlRQ?=
 =?utf-8?B?c0N3eUdLWDNiaWd1a1FvUDNsQ1Y5TDI0b2lBNEFRMzZZMWVzYW9RZ3d5eWdB?=
 =?utf-8?B?T0dMU1c4U2k4UlpzbzNGZFBpb3laRkN4ZWYzYjZrSTdZN0FXVEVZN25pSGFs?=
 =?utf-8?B?L0huU1h0TWdlRTE3ZE9DRGNrdGFoS3UrSFhhaUZOS3VSbUZnNHFVdHFYazZu?=
 =?utf-8?Q?RTb4tfXlmojPGiUfY6bv/FM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a4b48f-91c4-4191-3fc6-08dce3150eda
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 19:04:36.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W59uvTaIsP0KVSVhGc1AS0DdTFWiu06GPLElIGGE+g+lBPgewM88cYAz/CK0h3qiRcdmlylPavywa7QsF4GIs4YtNTZbhC1JJQsCOd0Zoq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7232



On 10/2/24 11:17 AM, Nicolin Chen wrote:
> I think both v1 and v2 are missing iommu@lists.linux.dev in CC.

Will do it for the later revision.

>
> On Wed, Oct 02, 2024 at 10:55:14AM -0700, Yang Shi wrote:
>> +static inline unsigned int arm_smmu_strtab_max_sid(struct arm_smmu_device *smmu)
>> +{
>> +       return (1ULL << smmu->sid_bits);
>> +}
>> +
> Hmm, why ULL gets truncated to unsigned int here?

No particular reason, but it should be better to not truncate here. Will 
fix it.

>
> Thanks
> Nicolin



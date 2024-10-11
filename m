Return-Path: <linux-kernel+bounces-360722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B47D999EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF5AB2175E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177D20A5FA;
	Fri, 11 Oct 2024 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mPKBLWe/"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2856F1CCEEC;
	Fri, 11 Oct 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633643; cv=fail; b=tO4fNauTFla9ZxQoC8eri1mtRiZriEqs6OBQlXBFfG3uH68YkfIouNfBEOjo4i9bHmEliuC7UT7Q5gTc5M8B9AauQtRa9krlXcSAy/3JuLvbgt6c3PcZbF2aJiBMjD0XgvAdrtM/UunSZmIhS3+y1lmHFH7E6aP+l4Du4hpNkq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633643; c=relaxed/simple;
	bh=6RGojeqQe2VRlH0qgWViVH3YpqWM+D/puigWbnutVds=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nMZfNR9Ucv0AtrFMCB2QFvgzbRbQnBnPB+JUOhk8nd/5TIlpVWPM+dR4fPd+AYQdqEIiVb3CJsKdj60+MKpi5HAzRemaOnzb/4bfK2ZmGPC1vTREL80dRNdJqThbahTG0ftXCex1WWttWVGkSkONmveXcRLJf5AWq82qw+KoOcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mPKBLWe/; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJkNxa5TGSAV1Lk8ZwR3n8uMFGrZhyKYia0uY78uI3PbOcErpR2oP3dzxpFSBSorKbBxSLpDi6vbUI+RVgcpWSaViCL7dWRlvqGoX5a5TjkrIDk4U6aWWdRKzMwrY9nl/ja5GeFTR+A7vA9ECbidUZIFq9Fp5xpIJIY32uBliO1awxBp269ZfJysYxAUM8vdOTmQNxB1iN4RKILxySDaf4rcmZDQKbM2JV5XzO5K3MqefA0VfxrHPvigeAaYIm+nhyUtheBx5TmVk8mQwygdlRV+jVfHHX9NwBtm/M1RAiEoA04Hw7B7yag7nKR2Q6ujUq+U+Wf5wy8pDbrQifa1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGdGZXhiw8hHKRFGjER0MxAs7u/WmLTZtqTLAtllPRg=;
 b=Z+tCltKJW++tmD+GwXecMyPbYRQkmVpb9T7ZiOV7z2ytk2VmjrTU87dL1feHPv9euR34dFUIreztH4CR82jtee3qjEoVeZoUc/qNZeMqYNBEwd4pmLv14SJBdSk3ayJWf27goNqnLxD1B0J2vSithij1+z1FTATzDypMBBhylSRqBLHIIHl8cFbH+jF1iwdWf+qxPZoUskmgV0Zc5ttRdCS2WHiZm5iHDb2rM5EEvyOsYVOFrqL2eHE48BYlyUXMQrvtHaqegGHuSiW46Mi184uUgbWYfpo+0LGlIqFDzVnnD31DGuHzUVFJFJ0KOiRl+pu5sX/pfDIhaekIdJN30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGdGZXhiw8hHKRFGjER0MxAs7u/WmLTZtqTLAtllPRg=;
 b=mPKBLWe/RZ0GT7D0xmGf/CR7QBFxVEGZ5n19dSzfD+ajmCoWUmY/yCHa/RnoTp+vKR6jQCdsaY+NxVUHJLsTIHtQ7A2mhxhjp96lcsVA+yT89fGawyrzHe+DrvmyxpdnXPJZXiv5T6JGYV8biipdt++ryoCW9d4q4fQve9vzaSy0vm23Ui0uqYVzNTkocKaZ6TsOKITbzynRKJ+Dw3sWi39sBu81yw5JmZC3SAuWPFVOq1WSl6OIcopUhnUuiGxcb1hSTTVYBPnzKkZpiOwBAiAK16OSSaio7BWnpzBi5cFxf6hqzQOsrSG2InHfyvT1YJisMoVAjlZFSIZbnRTG7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 08:00:38 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1%5]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 08:00:37 +0000
Message-ID: <9c590d45-ba6e-48dc-aa32-e70029885867@nxp.com>
Date: Fri, 11 Oct 2024 11:00:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
To: Shengjiu Wang <shengjiu.wang@nxp.com>, shengjiu.wang@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1728622433-2873-1-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <1728622433-2873-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::17) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: aa81792f-cf7f-452b-8db9-08dce9cacaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak1Zc1JxWER2ekJRVFJNaDJ1bEltOEM2TzArYUttbjlTVjdiLysvTkFrVGlw?=
 =?utf-8?B?SCtZeE96R05ZVTh0b1JYZ0F4OGE0T0xreXJQY2pPbHZYUk02VU1aQ0VtZEt1?=
 =?utf-8?B?WGlOMldsMVZjVFhhdXBsWm1rMkFyMTJJZmdJOHdKNXpwTmtOSzA4WDRHeG5x?=
 =?utf-8?B?TUJWbTBUSmZGVm1OdnZodlI5ZEIzNzZ0WXpoczRIaFVTaDdiS3ozODJqS1Qy?=
 =?utf-8?B?SFJRblRQMkJZRW8wRlB6amZBTmdQbzcvU1F0bGN6SGVnZ3B6d1YrR3p5YTcz?=
 =?utf-8?B?UkkrNUNDUUlzTEI0RnZZSDZUdzVHVU03cTU0eUI0bzFYYkc3ZW9lMFI5cFVi?=
 =?utf-8?B?RkxQbldMTjdzckozaDdRUVN4M1l4VUV6Y2xPNjAvNGFONWxwMGY2dUU4Q3Rr?=
 =?utf-8?B?aVBHTlJzTHd6aXZxMnRCNzRiMytnakRPOEc3SjhoKzcrdWxkSkU1WWszdXBz?=
 =?utf-8?B?K2NHOXBrTDd4L0xwWGE5YWdHODd3S0dUYURZS3BFQUJyeTUva1ZLdTc3VVR2?=
 =?utf-8?B?WWRpQXMvdk9pR1NCeFF1TTJOcjU2OU8wTXkrc0p5b1FwZDVTNUozOVNXTlpQ?=
 =?utf-8?B?dEs4WEIzUjZEU21YM0J0dE1RaTIvSkJNQTU4Nk4xcFlsUGV6ekNUb1NUQ2lJ?=
 =?utf-8?B?RUhvbWFOTWtqMk13TnRLQkdxUFRzQUF5YWxObkltVUtyd0t0WVZBd2NYNytx?=
 =?utf-8?B?d29nRXhTeGtHaGd5dm9xWFRDNWNnOCsyakJoL1dVUHJsSVplajVENVc1aUVo?=
 =?utf-8?B?bGtwZWdtTW1JcnBJNit2c1RkR3FpcmI5eGtlMWU1MHhxL0o0ZE8vdklxNU5R?=
 =?utf-8?B?c2g0TEpvN29PK0pEaGZGSHhUZU9IVGU0UldWaVRpR2NlTjR3UFZkdnFOdVVV?=
 =?utf-8?B?RXpMdHpRb3RpUzIycVZueC9lM3NURFV2ZVhGcUdrR2NXS3RNdU80V3dQZXJi?=
 =?utf-8?B?QTJxaE41Qy82bC9EakRVNURuVENLcVdIN2RERFprdGVTZTh5Y0txZmNsWUxa?=
 =?utf-8?B?U2tYcWU1YldxZFZJTTJYNlRiMk9zMlVtQ3NRU2lxS0R4Yys1emlJZDh2WVF4?=
 =?utf-8?B?L2ViUGlsMTBkT1R4bkU2cG1ySHJOYlo5SXRQYm9BUVFLRDBYWThrbzVEZkFx?=
 =?utf-8?B?N1BnV1M5eDFCcG5WWU15cDRSeE9UQW4vWjV6Y3V4N3RaQ3NLWmNXQ1pBcy9t?=
 =?utf-8?B?OFdxcnA2aFlWSkNMNGczK0NCbFI5SEhLUTBYUlQzL1RpdUlRNkp4Q2FnUTh5?=
 =?utf-8?B?SHpXMS9yNmdEYkIrRFNTdlBmNDFEVXYvczZvM2dOQk1ZNWs0RG44eWlNOFh6?=
 =?utf-8?B?K0ZzQUEwYXNaZGZzdzFYQy9LT2Z4TFl0S0RVZEpvMzU0WHEzRVN5bUQzNnB0?=
 =?utf-8?B?blI1OWxOUmVrVVhyeVp1T3VSMldnVHVZdU1pUElEV1V2cDlYQ1laVnV1ejAx?=
 =?utf-8?B?cWZDNnBWQUZpYWYrUFpJY3pDek9zWFZ4eWN6VGM1WVV2MEd5aWVQMUVZSitE?=
 =?utf-8?B?eWJOcllUMmwyalAyMU1mQktWU1BaU1FiaEF3RlNxOWJMMTVwMjR4a24wMk9D?=
 =?utf-8?B?anE1b0JvM0F4cjJnMlI4SE52bFowS1VrVGkrVUxnSnJvUXZscFNIUlBFUVVs?=
 =?utf-8?B?NkplT0k2Z2FnaldYZE5KS0ZhYUljQU1uMmYrN21DNnlTWGF3S1JWYmRIZkR2?=
 =?utf-8?B?TnFjbWQ0MDJXL2oyb2FwYS9hVENFTEdKT1kxSnJMZG5LUE0rOWtwdTV4SFI1?=
 =?utf-8?Q?s015l95n6zVQvQRD7xWJkU2rVFopP4C/BJPobA5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUZNbjF2WWM5ZElpOEw4Qm10L1VISFlUVnVQa1RlOUhuMUVUM3ptZjlDTlA0?=
 =?utf-8?B?clpZSC9LMXNKZEJGeVJXN2pDbk01emRrQVJYR1g5YlA3b3Q5dE5YQWw4SGxv?=
 =?utf-8?B?L1ZLQzFrNlNJa2pSTUNKQUp4bFBzK0pjYjhRK0FJTmVFc2kwb3BIb01rMXUx?=
 =?utf-8?B?RndYVWttK2cvQUozczRETVZwRmJNSVdyMkdRMzhLeG0zdXpoTjF5c0x2UjlT?=
 =?utf-8?B?L3kxbnFkNVNXQkhYUzRYOWZ6MVpJSVYwUnVLYy95dmRScStJUys0Vk54bWZz?=
 =?utf-8?B?cHRlRE10N252VzMzTXkrcXRFWk50SXZhdERmZk1tRWtYeXBSNFhhb0VPQ2g5?=
 =?utf-8?B?L1Vicm05MUNOTjhDb3YycVhJLzlEZklyVDhJWk5KL2ExK055OERvNzhpM2xi?=
 =?utf-8?B?MDFwYnYrK2thSEVhcEMrSVVzY3dYN2NaOWhKQWhsMTdIbmxPU3ZKZlNrWStP?=
 =?utf-8?B?TndXVDNjMEdqODFyU0JPbUlGeGw4V2lVS1RleE9WQjNwTHlVV1B0VGlrVlhn?=
 =?utf-8?B?dUduM1E1Uzl6MnZWSnd6dEZxbURvLzZmdVF4RzZyUjRIODBpNm4zc1lraG5o?=
 =?utf-8?B?SFB5U2dwTzdNYjZSc3hUMnRyQ3dVVGdIOVl6UHUwZkE2MHlha1dNZTQybDU1?=
 =?utf-8?B?K2pXTE5kMlE5NnB0UEcyb09ZQWtyK2kwUVNRVnJ0eVVLNnYrTW9GblN6VmFs?=
 =?utf-8?B?Nm5kb1QyWFZBTE9TWkNXQkFoQ1JwSmNGYmsvcldRb1Nlb1JSM1RLVWgrMWJ6?=
 =?utf-8?B?VnJXWXVvTHhDQWV5dXRIcyt5b1Z2a0RBWU5udkN5WFRBV20zQlFpeW5NNnlP?=
 =?utf-8?B?K01wN0NEajBlenpPZWIxeXV0NG1pckN0YjNucStHd2pYdm1LUFVTU2p5UXhW?=
 =?utf-8?B?R2ZqYjBBOWNYWnRPT1JEWVdzMk9xWTFUMlRIUk9HMUtHdnMwMFJuNnlLMzUx?=
 =?utf-8?B?a2NRRUwzZExmRFBuVy9icjhPRlNmRldnV3ZkME5lbElqVEJCWGFVSExCQTRq?=
 =?utf-8?B?QXVlZEsvTkdnOUNrbnNGYzdzZjFuRVB4cmlka2I3QlUzUWplamswQ3ZVU0tm?=
 =?utf-8?B?MjBBUVFuTk5lMUdTRmZoUW9IdWtyTVZRNzF4TkRHbGRsTzZ0TzNWZ1loNHla?=
 =?utf-8?B?SDIwNnRmU3ZNV3dHaGtFb1JnY0grUmJKTHV1d2dRV09FRTF2RlEwVDU5cFcx?=
 =?utf-8?B?ZFZOZk4wL25ZY1FBMXlFOFdOd2RqZUJYMnFxVHh4NkFicGJLTnp0Q3BMYVFL?=
 =?utf-8?B?aUkwa2ZiYkNnSHBxNERmS0RzMXFXelpYUGpJb2xFVHFKbWtLR0NoMTBGM1Vn?=
 =?utf-8?B?TjVPczVIWmozNlZKb1lYRE5wSnZFR1FUcHVmV3pJS1VtbEsyT2RQY2JzRnAy?=
 =?utf-8?B?dG90NHh4b0ZzR3ppRHR4ejNrZmpVYjBGNUFxNkYrSDdhWVZPWDB3N3RDanhG?=
 =?utf-8?B?cUJhekNqbXpmdXdjUFRoUHdnT0dLdzBpNkFMb25MSHFmRmxaWFJLdlpmUkoz?=
 =?utf-8?B?RHFSSDd2SnFCMDZTb3ZsdW1ZaXRFamZlNjVaNTlHUUZQVDgrOTQyZ3lXRit0?=
 =?utf-8?B?N3Z3Uk8wVm50MUl4RGxMZTRsMGFxQmt5MkxvZXE0ditqbys4THhLL0d5Z2VW?=
 =?utf-8?B?bFo3eHRyYjlFcWNFTWd5aysxUkF0RzlObWlrQWNtQy9na1pZV2w3VW1ubEpN?=
 =?utf-8?B?MFo4bGltQ3FBRVo3dUlkZHpMcUNRRTQ1Vmp2a0V3RzJWVEp3Y2hHUFFscGZw?=
 =?utf-8?B?ZHFJbFVzYmxVMWp1TkR4c2plRGluQnVLUWxhVENYQnQvdzJ0SG9jOEw1dFVZ?=
 =?utf-8?B?cXpYcnloc213OW15dFlUMEwzdVRFMWJVVisvNGxFUXpRTWF6NW1pb1k1bXlE?=
 =?utf-8?B?SjJQbk92c3k2Y2hWSkQ2KzdYNEJkQUVxRGRmZmFDYW1NRWI4V0QvQTJXTWRo?=
 =?utf-8?B?VndIWDdKeTZsQ1hDeTVRRjJjcWk3eGdWdmlOOTRDNDQyZDVsVzNpZzkxZDNo?=
 =?utf-8?B?ZVdHUEcwUlBDOW9VNThVYXlNRGgzUjN5NnluZkgrYzNWVmRlZVN4d2V2NDNK?=
 =?utf-8?B?Rm0ySlZWRmRBNXdyWDJ2QXFMNUJlRHE3K1UvL3B6aTdTQTIveDJPazM0TUxw?=
 =?utf-8?Q?8ViunmMU4O/GUakEXpeJJok38?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa81792f-cf7f-452b-8db9-08dce9cacaa2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 08:00:37.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7tQaywfsLVS9Z5yx541OpRbt9Qj2vpX+/K7Vwd0SdPAxwVeipE1xht6GJgdRBDGKafUMSBFHIENPMVhA9B7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

On 10/11/2024 7:53 AM, Shengjiu Wang wrote:
> Irq handler need to be executed as fast as possible, so
> the log in irq handler is better to use dev_dbg which needs
> to be enabled when debugging.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia
> ---
>   sound/soc/fsl/fsl_esai.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index a65f5b9935a2..0b247f16a163 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -119,10 +119,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
>   		dev_dbg(&pdev->dev, "isr: Transmission Initialized\n");
>   
>   	if (esr & ESAI_ESR_RFF_MASK)
> -		dev_warn(&pdev->dev, "isr: Receiving overrun\n");
> +		dev_dbg(&pdev->dev, "isr: Receiving overrun\n");
>   
>   	if (esr & ESAI_ESR_TFE_MASK)
> -		dev_warn(&pdev->dev, "isr: Transmission underrun\n");
> +		dev_dbg(&pdev->dev, "isr: Transmission underrun\n");
>   
>   	if (esr & ESAI_ESR_TLS_MASK)
>   		dev_dbg(&pdev->dev, "isr: Just transmitted the last slot\n");

